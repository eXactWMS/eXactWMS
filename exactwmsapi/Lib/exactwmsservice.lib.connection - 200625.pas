unit exactwmsservice.lib.connection;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.SyncObjs,
  System.Threading,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.ODBCBase,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Phys.Intf,
  Math,
  System.DateUtils,
  IniFiles;

type
  TConnectionPool = class
  private
    FConnections: TQueue<TFDConnection>;
    FLock: TCriticalSection;
    FMaxConnections: Integer;
    FCreatedConnections: Integer;
    FWaitComponent: TFDGUIxWaitCursor;

    // Configurações de retry
    FMaxRetryAttempts: Integer;
    FMaxWaitTimeMs: Integer;
    FRetryIntervalMs: Integer;

    // Estatísticas
    FTotalRequests: Int64;
    FSuccessfulGets: Int64;
    FTimeoutErrors: Int64;

    function CreateConnection: TFDConnection;
    procedure ConfigureConnection(AConnection: TFDConnection);
    function GetCurrentTimeMs: Int64;

  public
    constructor Create(AMaxConnections: Integer = 100);
    destructor Destroy; override;

    function GetConnection: TFDConnection;
    procedure ReleaseConnection(AConnection: TFDConnection);
    function GetStatus: string;
  end;

var
  GlobalConnectionPool: TConnectionPool;

implementation

{ TConnectionPool }

constructor TConnectionPool.Create(AMaxConnections: Integer);
begin
  inherited Create;
  FMaxConnections := AMaxConnections;
  FCreatedConnections := 0;

  // Configurações padrão para retry automático
  FMaxRetryAttempts := 100;    // 100 tentativas
  FMaxWaitTimeMs := 30000;     // 30 segundos
  FRetryIntervalMs := 300;     // 300ms entre tentativas

  // Inicializa estatísticas
  FTotalRequests := 0;
  FSuccessfulGets := 0;
  FTimeoutErrors := 0;

  FConnections := TQueue<TFDConnection>.Create;
  FLock := TCriticalSection.Create;
  FWaitComponent := TFDGUIxWaitCursor.Create(nil);

  WriteLn(Format('Pool criado: %d conexões max, retry %d tentativas, timeout %ds',
    [FMaxConnections, FMaxRetryAttempts, FMaxWaitTimeMs div 1000]));
end;

destructor TConnectionPool.Destroy;
var
  Connection: TFDConnection;
begin
  FLock.Enter;
  try
    while FConnections.Count > 0 do
    begin
      Connection := FConnections.Dequeue;
      try
        if Connection.Connected then
          Connection.Connected := False;
        Connection.Free;
      except
        // Ignora erros na destruição
      end;
    end;
  finally
    FLock.Leave;
  end;

  FConnections.Free;
  FLock.Free;
  FWaitComponent.Free;
  inherited Destroy;
end;

function TConnectionPool.GetCurrentTimeMs: Int64;
var
  StartTime: TDateTime;
begin
  // SIMPLES E MULTIPLATAFORMA: Usa Now()
  StartTime := EncodeDate(1970, 1, 1); // Unix Epoch
  Result := MilliSecondsBetween(Now, StartTime);
end;

procedure TConnectionPool.ConfigureConnection(AConnection: TFDConnection);
var ArqIni : TIniFile;
begin
  AConnection.Params.Clear;
  try
    if GetEnvironmentVariable('RHEMA_DB_HOST') <> '' then begin
       AConnection.Params.Add('DriverID=MSSQL');
       AConnection.Params.Add('Server='+ GetEnvironmentVariable('RHEMA_DB_HOST'));
       AConnection.Params.Add('Database=' + GetEnvironmentVariable('RHEMA_DB_DATABASE'));
       AConnection.Params.Add('User_Name=' + GetEnvironmentVariable('RHEMA_DB_USER'));
       AConnection.Params.Add('Password=' + GetEnvironmentVariable('RHEMA_DB_PASSWORD'));
       AConnection.Params.Add('OSAuthent=No');
       AConnection.Params.Add('Encrypt=No');
       AConnection.Params.Add('TrustServerCertificate=Yes');

       // Configurações de performance
       AConnection.Params.Add('ApplicationName=EVOLUTIONSERVICE_API');
       AConnection.Params.Add('Workstation=API-Server');
       //AConnection.Params.Add('MARS=Yes');
       //AConnection.Params.Add('MARSConnection=Yes');
       AConnection.Params.Add('MARS=NO');

       // Timeout configurations
       AConnection.ResourceOptions.CmdExecTimeout := 15000;
       AConnection.Params.Add('ConnectionTimeout=15000');
       AConnection.Params.Add('CommandTimeout=15000');

       // Configurações adicionais para performance
       AConnection.ResourceOptions.AutoReconnect := False;
       AConnection.ResourceOptions.KeepConnection := True;
       AConnection.ResourceOptions.AutoConnect := False;

       AConnection.ResourceOptions.SilentMode := True;
       AConnection.ResourceOptions.DirectExecute := True;
    end
    else
    begin
      if not fileexists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini') then Begin
         Writeln('[Provider.Connection]Erro : [não encotrado arquivo de configuracao] ' + ExtractFilePath(GetModuleName(HInstance)));
         exit;
      end;
      ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini');
      AConnection.Params.Add('DriverID=' + ArqIni.ReadString('BD', 'Driver', 'MSSQL'));
      AConnection.Params.Add('Server=' + ArqIni.ReadString('BD', 'Server', 'locahost'));
      AConnection.Params.Add('Database=' + ArqIni.ReadString('BD', 'DataBase', 'eXactWMSTESTE'));
      AConnection.Params.Add('User_Name=' + ArqIni.ReadString('BD', 'user', 'sa'));
      AConnection.Params.Add('Password=' + ArqIni.ReadString('BD', 'pwd', 'xxxxxxx'));
      AConnection.Params.Add('OSAuthent=No');
      AConnection.Params.Add('Encrypt=No');
      AConnection.Params.Add('TrustServerCertificate=Yes');

      // Configurações de performance
      AConnection.Params.Add('ApplicationName=EVOLUTIONSERVICE_API');
      AConnection.Params.Add('Workstation=API-Server');
      AConnection.Params.Add('MARS=Yes');
      AConnection.Params.Add('MARSConnection=Yes');

      // Timeout configurations
      AConnection.ResourceOptions.CmdExecTimeout := 15000;
      AConnection.Params.Add('ConnectionTimeout=15000');
      AConnection.Params.Add('CommandTimeout=15000');

      // Configurações adicionais para performance
      AConnection.ResourceOptions.AutoReconnect := False;
      AConnection.ResourceOptions.KeepConnection := True;
      AConnection.ResourceOptions.AutoConnect := False;

      AConnection.ResourceOptions.SilentMode := True;
      AConnection.ResourceOptions.DirectExecute := True;
    end;
  finally
    if assigned(ArqIni) then
       FreeAndNil(ArqIni);
  end;
end;

function TConnectionPool.CreateConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  try
    ConfigureConnection(Result);
    Result.Connected := True;
    Inc(FCreatedConnections);
  except
    Result.Free;
    raise;
  end;
end;

function TConnectionPool.GetConnection: TFDConnection;
var
  AttemptCount: Integer;
  StartTime, CurrentTime: Int64;
  WaitTime: Integer;
  LastLogTime: Int64;
begin
  Result := nil;
  AttemptCount := 0;
  StartTime := GetCurrentTimeMs;
  LastLogTime := StartTime;

  // Incrementa estatística
  FLock.Enter;
  try
    Inc(FTotalRequests);
  finally
    FLock.Leave;
  end;

  // LOOP DE RETRY AUTOMÁTICO
  while (Result = nil) and
        (AttemptCount < FMaxRetryAttempts) and
        ((GetCurrentTimeMs - StartTime) < FMaxWaitTimeMs) do
  begin
    Inc(AttemptCount);
    CurrentTime := GetCurrentTimeMs;

    FLock.Enter;
    try
      // CENÁRIO 1: Pega conexão disponível (PICO DE TRÁFEGO)
      if FConnections.Count > 0 then
      begin
        Result := FConnections.Dequeue;

        // Verifica se está conectada
        if not Result.Connected then
        begin
          try
            Result.Connected := True;
          except
            Result.Free;
            Dec(FCreatedConnections);
            Result := nil;
            Continue;
          end;
        end;

        if Assigned(Result) then
        begin
          Inc(FSuccessfulGets);
          WaitTime := CurrentTime - StartTime;

          WriteLn(Format('✅ Conexão obtida em %dms (tentativa %d)', [WaitTime, AttemptCount]));
          Exit;
        end;
      end

      // CENÁRIO 2: Cria nova conexão (CONSULTAS PESADAS não bloqueiam)
      else if FCreatedConnections < FMaxConnections then
      begin
        try
          Result := CreateConnection;
          if Assigned(Result) then
          begin
            Inc(FSuccessfulGets);
            WaitTime := CurrentTime - StartTime;

            WriteLn(Format('✅ Nova conexão criada em %dms (%d/%d)',
              [WaitTime, FCreatedConnections, FMaxConnections]));
            Exit;
          end;
        except
          // Se falhar, continua tentando
          Result := nil;
        end;
      end;

    finally
      FLock.Leave;
    end;

    // Log a cada 5 segundos
    if (CurrentTime - LastLogTime) > 5000 then
    begin
      LastLogTime := CurrentTime;
      WriteLn(Format('⏳ Tentativa %d/%d, %ds/%ds, Pool: %d/%d',
        [AttemptCount, FMaxRetryAttempts,
         (CurrentTime - StartTime) div 1000, FMaxWaitTimeMs div 1000,
         FCreatedConnections, FMaxConnections]));
    end;

    // CENÁRIO 3: Aguarda conexão ser liberada (TIMEOUT INTELIGENTE)
    if Result = nil then
    begin
      Sleep(FRetryIntervalMs + (AttemptCount * 50)); // Progressivo
    end;
  end;

  // TIMEOUT: Registra erro mas dá informação útil
  if Result = nil then
  begin
    FLock.Enter;
    try
      Inc(FTimeoutErrors);
    finally
      FLock.Leave;
    end;

    WaitTime := GetCurrentTimeMs - StartTime;

    raise Exception.CreateFmt(
      'Pool esgotado após %d tentativas em %ds. Pool: %d/%d conexões. ' +
      'Stats: %d requests, %d sucessos, %d timeouts. ' +
      'Considere aumentar MaxConnections ou otimizar queries.',
      [AttemptCount, WaitTime div 1000, FCreatedConnections, FMaxConnections,
       FTotalRequests, FSuccessfulGets, FTimeoutErrors]
    );
  end;
end;

procedure TConnectionPool.ReleaseConnection(AConnection: TFDConnection);
begin
  if not Assigned(AConnection) then
    Exit;

  FLock.Enter;
  try
    // Limpa transações
    try
      if AConnection.Connected and AConnection.InTransaction then
        AConnection.Rollback;
    except
      // Se falhou, remove conexão
      try
        AConnection.Connected := False;
        AConnection.Free;
        Dec(FCreatedConnections);
      except
        // Ignora erros
      end;
      Exit;
    end;

    // Devolve para o pool se estiver OK
    if AConnection.Connected then
    begin
      FConnections.Enqueue(AConnection);
    end
    else
    begin
      // Conexão morta - remove
      try
        AConnection.Free;
        Dec(FCreatedConnections);
      except
        // Ignora erros
      end;
    end;

  finally
    FLock.Leave;
  end;
end;

function TConnectionPool.GetStatus: string;
var
  Available, Created: Integer;
  SuccessRate: Double;
begin
  FLock.Enter;
  try
    Available := FConnections.Count;
    Created := FCreatedConnections;

    if FTotalRequests > 0 then
      SuccessRate := (FSuccessfulGets / FTotalRequests) * 100
    else
      SuccessRate := 100.0;

    Result := Format('Pool: %d/%d conexões, %d disponíveis, %.1f%% sucesso (%d/%d reqs)',
      [Created, FMaxConnections, Available, SuccessRate, FSuccessfulGets, FTotalRequests]);
  finally
    FLock.Leave;
  end;
end;

initialization
  GlobalConnectionPool := TConnectionPool.Create(100);

finalization
  if Assigned(GlobalConnectionPool) then
    GlobalConnectionPool.Free;

end.
