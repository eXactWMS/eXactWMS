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
  FireDAC.Phys.Intf,
  Math,
  System.DateUtils,
  IniFiles,
  System.Diagnostics, // Adicionado para TStopwatch

  FireDAC.Comp.UI;


type
  TLogQueue = class
  private
    FQueue: TQueue<string>;
    FLock: TCriticalSection;
    FLogThread: TThread;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Log(const AMessage: string);
  end;

  TConnectionInfo = class
  public
    Connection: TFDConnection;
    CreationTime: Int64; // Tempo de criação (em milissegundos desde o início)
    LastUsedTime: Int64; // Último uso (em milissegundos)
    constructor Create(AConnection: TFDConnection; ACurrentTimeMs: Int64);
  end;

  TConnectionPool = class
  private
    FConnections: TQueue<TConnectionInfo>;
    FLock: TCriticalSection;
    FMaxConnections: Integer;
    FBaseMaxConnections: Integer; // Limite base (mínimo)
    FAbsoluteMaxConnections: Integer; // Limite absoluto (máximo)
    FCreatedConnections: Integer;

    // Configurações de retry
    FMaxRetryAttempts: Integer;
    FMaxWaitTimeMs: Integer;
    FRetryIntervalMs: Integer;

    // Estatísticas
    FTotalRequests: Int64;
    FSuccessfulGets: Int64;
    FTimeoutErrors: Int64;

    FMaxLifetimeMs: Int64; // Tempo de vida máximo de uma conexão
    FMaxIdleTimeMs: Int64; // Tempo máximo de inatividade

    // Configurações de ajuste dinâmico
    FSuccessRateThreshold: Double; // Limiar de taxa de sucesso para ajuste
    FTimeoutThreshold: Integer; // Limiar de timeouts para ajuste
    FLastAdjustmentTime: Int64; // Último ajuste do pool
    FAdjustmentIntervalMs: Int64; // Intervalo entre ajuste

    FLogQueue: TLogQueue; // Instância para logging assíncrono

    function CreateConnection: TFDConnection;
    procedure ConfigureConnection(AConnection: TFDConnection);
    function GetCurrentTimeMs: Int64; // Alterado para usar TStopwatch

    function ValidateConnection(AConnection: TFDConnection): Boolean;
    procedure CleanupConnection(AConnection: TFDConnection); // Lógica de tratamento de erro aprimorada
    procedure ResetConnectionState(AConnection: TFDConnection);

    procedure Log(const AMessage: string); // Adicionado para logging mais granular

    Procedure SafeIncCreatedConnections;
    Procedure SafeDecCreatedConnections;

    function IsConnectionExpired(AConnInfo: TConnectionInfo): Boolean; // Novo método

    procedure AdjustPoolSize; // Novo método para ajuste dinâmico
    procedure RemoveIdleConnections; // Novo método para remover conexões ociosas
  public
    constructor Create(AMaxConnections: Integer = 100);
    destructor Destroy; override;

    function GetConnection: TFDConnection;
    procedure ReleaseConnection(AConnection: TFDConnection);
    function GetStatus: string;
  end;

var
  GlobalConnectionPool: TConnectionPool;

const
  CONNECTION_TIMEOUT = 60000; // Usar constante
  COMMAND_TIMEOUT    = 60000;
  MAX_LIFETIME_MS    = 3600000; // 1 hora de vida máxima
  MAX_IDLE_TIME_MS   = 600000; // 10 minutos de inatividade máxima

  ADJUSTMENT_INTERVAL_MS = 120000; //300000; // 5 minutos entre ajustes
  SUCCESS_RATE_THRESHOLD = 80.0; // Taxa de sucesso mínima antes de aumentar pool
  TIMEOUT_THRESHOLD      = 10; // Número de timeouts antes de aumentar pool

implementation

{ TConnectionPool }

constructor TConnectionPool.Create(AMaxConnections: Integer);
begin
  inherited Create;
  FMaxConnections         := AMaxConnections;
  FBaseMaxConnections     := AMaxConnections; // Limite base
  FAbsoluteMaxConnections := AMaxConnections * 2; // Limite máximo (dobro do base)
  FCreatedConnections     := 0;

  // Configurações padrão para retry automático
  FMaxRetryAttempts := 100;    // 100 tentativas
  FMaxWaitTimeMs := 60000; //30000;     // 30 segundos
  FRetryIntervalMs := 100; //300;     // 300ms entre tentativas
  FMaxLifetimeMs := MAX_LIFETIME_MS;
  FMaxIdleTimeMs := MAX_IDLE_TIME_MS;
  // Configurações de ajuste dinâmico
  FSuccessRateThreshold := SUCCESS_RATE_THRESHOLD;
  FTimeoutThreshold := TIMEOUT_THRESHOLD;
  FLastAdjustmentTime := 0;
  FAdjustmentIntervalMs := ADJUSTMENT_INTERVAL_MS;

  // Inicializa estatísticas
  FTotalRequests := 0;
  FSuccessfulGets := 0;
  FTimeoutErrors := 0;

  FConnections := TQueue<TConnectionInfo>.Create;
  FLock := TCriticalSection.Create;
  // FWaitComponent := TFDGUIxWaitCursor.Create(nil); // REMOVIDO: Desnecessário para console/serviço
  FLogQueue := TLogQueue.Create; // Cria a instância de logging assíncrono
  FLogQueue.Log(Format('Pool ROBUSTO criado: %d conexões max, retry %d tentativas, timeout %ds',
    [FMaxConnections, FMaxRetryAttempts, FMaxWaitTimeMs div 1000]));
end;

destructor TConnectionPool.Destroy;
var
  ConnInfo: TConnectionInfo;
begin
  Log('Finalizando pool de conexões...');
  FLock.Enter;
  try
    while FConnections.Count > 0 do
    begin
      ConnInfo := FConnections.Dequeue;
      try
        if Assigned(ConnInfo.Connection) and ConnInfo.Connection.Connected then
          ConnInfo.Connection.Connected := False;
        ConnInfo.Connection.Free;
        ConnInfo.Free; // Libera o TConnectionInfo
      except
        on E: Exception do
          Log(Format('⚠️ Erro ao liberar conexão na destruição do pool: %s', [E.Message]));
      end;
    end;
  finally
    FLock.Leave;
  end;
  FConnections.Free;
  FLock.Free;
  inherited Destroy;
end;

(*
destructor TConnectionPool.Destroy;
var
  Connection: TFDConnection;
begin
  Log('Finalizando pool de conexões...');

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
        on E: Exception do
          WriteLn(Format('⚠️  Erro ao liberar conexão na destruição do pool: %s', [E.Message]));
      end;
    end;
  finally
    FLock.Leave;
  end;

  FConnections.Free;
  FLock.Free;
  FLogQueue.Free; // Libera a instância de logging
  // FWaitComponent.Free; // REMOVIDO
  inherited Destroy;
end;
*)

function TConnectionPool.GetCurrentTimeMs: Int64;
begin
  // Usando TStopwatch para maior precisão e compatibilidade multiplataforma
  Result := TStopwatch.GetTimestamp div (TStopwatch.Frequency div 1000);
end;

procedure TConnectionPool.Log(const AMessage: string);
begin
  // Para aplicações console, Log é adequado. Em um serviço, pode ser substituído por um logger mais robusto.
  //WriteLn
  FLogQueue.Log(Format('[%s] %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now), AMessage]));
end;

procedure TConnectionPool.AdjustPoolSize;
var
  CurrentTime: Int64;
  SuccessRate: Double;
  NewMaxConnections: Integer;
begin
  CurrentTime := GetCurrentTimeMs;
  if (CurrentTime - FLastAdjustmentTime) < FAdjustmentIntervalMs then
    Exit; // Não ajusta se o intervalo não passou

  FLock.Enter;
  try
    FLastAdjustmentTime := CurrentTime;
    if FTotalRequests > 0 then
      SuccessRate := (FSuccessfulGets / FTotalRequests) * 100
    else
      SuccessRate := 100.0;

    // Aumenta o pool se a taxa de sucesso estiver baixa ou houver muitos timeouts
    if (SuccessRate < FSuccessRateThreshold) or (FTimeoutErrors > FTimeoutThreshold) then
    begin
      NewMaxConnections := Min(FAbsoluteMaxConnections, FMaxConnections + 10);
      if NewMaxConnections > FMaxConnections then
      begin
        FMaxConnections := NewMaxConnections;
        Log(Format('📈 Pool aumentado para %d conexões (Taxa de sucesso: %.1f%%, Timeouts: %d)',
          [FMaxConnections, SuccessRate, FTimeoutErrors]));
      end;
    end
    // Reduz o pool se a utilização estiver baixa
    else if (FConnections.Count > FBaseMaxConnections div 2) and (SuccessRate > 95.0) and (FTimeoutErrors = 0) then
    begin
      NewMaxConnections := Max(FBaseMaxConnections, FMaxConnections - 10);
      if NewMaxConnections < FMaxConnections then
      begin
        FMaxConnections := NewMaxConnections;
        Log(Format('📉 Pool reduzido para %d conexões (Taxa de sucesso: %.1f%%, Timeouts: %d)',
          [FMaxConnections, SuccessRate, FTimeoutErrors]));
        RemoveIdleConnections; // Remove conexões ociosas se acima do novo limite
      end;
    end;
  finally
    FLock.Leave;
  end;
end;

procedure TConnectionPool.CleanupConnection(AConnection: TFDConnection);
begin
  if not Assigned(AConnection) then
    Exit;

  try
    if AConnection.Connected then
    begin
      // CRÍTICO: Aborta operações pendentes
      AConnection.AbortJob(True);

      // Limpa transações
      if AConnection.InTransaction then
      begin
        WriteLn('🔄 Fazendo rollback de transação pendente...');
        AConnection.Rollback;
      end;

      // Reset do estado da conexão
      ResetConnectionState(AConnection);

      WriteLn('🧹 Conexão limpa e pronta para reuso');
    end;
  except
    on E: Exception do
    begin
      // NÃO RELANÇA A EXCEÇÃO, APENAS LOGA E DEIXA A CONEXÃO SER DESCARTADA PELO CHAMADOR
      WriteLn(Format('⚠️  Erro na limpeza da conexão (será descartada): %s', [E.Message]));
      // A conexão será tratada como corrompida e removida do pool pelo ReleaseConnection ou GetConnection
    end;
  end;
end;

procedure TConnectionPool.ConfigureConnection(AConnection: TFDConnection);
var
  ArqIni : TIniFile;
  IniPath: string;
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

       // CONFIGURAÇÕES SEGURAS PARA PRODUÇÃO
       AConnection.Params.Add('ApplicationName=EVOLUTIONSERVICE_API');
       AConnection.Params.Add('Workstation=API-Server');

       // TIMEOUTS ROBUSTOS
       AConnection.ResourceOptions.CmdExecTimeout := COMMAND_TIMEOUT;  // 30s
       AConnection.Params.Add(Format('ConnectionTimeout=%d', [CONNECTION_TIMEOUT]));
       AConnection.Params.Add(Format('CommandTimeout=%d', [COMMAND_TIMEOUT]));

       // CONFIGURAÇÕES PARA POOL (SEM AutoReconnect)
       AConnection.ResourceOptions.AutoReconnect := False;  // ← POOL gerencia!
       AConnection.ResourceOptions.KeepConnection := True;
       AConnection.ResourceOptions.AutoConnect := False;

       AConnection.ResourceOptions.SilentMode := True;
       AConnection.ResourceOptions.DirectExecute := True;
    end
    else
    begin
      // Para multiplataforma, use TPath.GetHomePath ou TPath.GetAppPath para INI
      // Aqui, mantendo a lógica original para compatibilidade com o ambiente existente
      IniPath := ExtractFilePath(ParamStr(0)) + 'eXactWMS.ini'; // ParamStr(0) para nome do executável

      if not FileExists(IniPath) then Begin
         WriteLn(Format('[Provider.Connection]Erro : [não encontrado arquivo de configuracao] %s', [IniPath]));
         Exit;
      end;

      ArqIni := TIniFile.Create(IniPath);
      try
        AConnection.Params.Add('DriverID=' + ArqIni.ReadString('BD', 'Driver', 'MSSQL'));
        AConnection.Params.Add('Server=' + ArqIni.ReadString('BD', 'Server', 'localhost'));
        AConnection.Params.Add('Database=' + ArqIni.ReadString('BD', 'DataBase', 'eXactWMSTESTE'));
        AConnection.Params.Add('User_Name=' + ArqIni.ReadString('BD', 'user', 'sa'));
        AConnection.Params.Add('Password=' + ArqIni.ReadString('BD', 'pwd', 'xxxxxxx'));
        AConnection.Params.Add('OSAuthent=No');
        AConnection.Params.Add('Encrypt=No');
        AConnection.Params.Add('TrustServerCertificate=Yes');

        // MESMAS CONFIGURAÇÕES SEGURAS
        AConnection.Params.Add('ApplicationName=EVOLUTIONSERVICE_API');
        AConnection.Params.Add('Workstation=API-Server');

        AConnection.ResourceOptions.CmdExecTimeout := 60000;
        AConnection.Params.Add('ConnectionTimeout=60000');
        AConnection.Params.Add('CommandTimeout=60000');

        // MESMAS CONFIGURAÇÕES (SEM AutoReconnect)
        AConnection.ResourceOptions.AutoReconnect := False;  // ← POOL gerencia!
        AConnection.ResourceOptions.KeepConnection := True;
        AConnection.ResourceOptions.AutoConnect := False;

        AConnection.ResourceOptions.SilentMode := True;
        AConnection.ResourceOptions.DirectExecute := True;
      finally
        ArqIni.Free;
      end;
    end;
  except
    on E: Exception do
      WriteLn(Format('❌ Erro ao configurar conexão: %s', [E.Message]));
  end;
end;

function TConnectionPool.CreateConnection: TFDConnection;
var NewConnection: TFDConnection;
begin
  Result := nil;
  NewConnection := TFDConnection.Create(nil);
  try
    ConfigureConnection(NewConnection);
    NewConnection.Connected := True;
    SafeIncCreatedConnections;
    Result := NewConnection;
    NewConnection := nil; // Evita liberação no finally
    WriteLn(Format('🔧 Nova conexão criada - Total: %d/%d', [FCreatedConnections, FMaxConnections]));
  except
    on E: Exception do
    begin
      WriteLn(Format('❌ Erro ao criar conexão: %s', [E.Message]));
      if Assigned(NewConnection) then
         FreeAndNil(NewConnection);
      raise; // Re-lança para que o GetConnection possa tentar novamente ou falhar
    end;
  end;
end;

function TConnectionPool.GetConnection: TFDConnection;
var
  AttemptCount: Integer;
  StartTime, CurrentTime: Int64;
  WaitTime: Integer;
  LastLogTime: Int64;
  ValidationPassed: Boolean;
  ConnInfo: TConnectionInfo;
begin
  Result := nil;
  AttemptCount := 0;
  StartTime := GetCurrentTimeMs;
  LastLogTime := StartTime;
  AdjustPoolSize;
  FLock.Enter;
  try
    Inc(FTotalRequests);
    Log(Format('🔍 GetConnection #%d iniciado. Pool: %d disponíveis, %d/%d criadas',
      [FTotalRequests, FConnections.Count, FCreatedConnections, FMaxConnections]));
  finally
    FLock.Leave;
  end;
  while (Result = nil) and
        (AttemptCount < FMaxRetryAttempts) and
        ((GetCurrentTimeMs - StartTime) < FMaxWaitTimeMs) do
  begin
    Inc(AttemptCount);
    CurrentTime := GetCurrentTimeMs;
    FLock.Enter;
    try
      // CENÁRIO 1: Pega conexão disponível
      if FConnections.Count > 0 then
      begin
        ConnInfo := FConnections.Dequeue;
        if IsConnectionExpired(ConnInfo) then
        begin
          try
            if Assigned(ConnInfo.Connection) and ConnInfo.Connection.Connected then
              ConnInfo.Connection.Connected := False;
            ConnInfo.Connection.Free;
            ConnInfo.Free;
            Dec(FCreatedConnections);
            Log('🗑️ Conexão expirada removida do pool');
          except
            on E: Exception do
            begin
              Log(Format('⚠️ Erro ao liberar conexão expirada: %s', [E.Message]));
              Dec(FCreatedConnections);
            end;
          end;
          Result := nil;
          Continue;
        end;
        Result := ConnInfo.Connection;
        ConnInfo.LastUsedTime := CurrentTime; // Atualiza o tempo de uso
        ValidationPassed := False;
        try
          if ValidateConnection(Result) then
          begin
            CleanupConnection(Result);
            ValidationPassed := True;
            Inc(FSuccessfulGets);
            WaitTime := CurrentTime - StartTime;
            Log(Format('✅ Conexão validada e limpa em %dms (tentativa %d)',
              [WaitTime, AttemptCount]));
            ConnInfo.Free; // Libera o TConnectionInfo, mas mantém a conexão
            Exit;
          end;
        except
          on E: Exception do
          begin
            Log(Format('❌ Conexão corrompida durante validação/limpeza: %s', [E.Message]));
            ValidationPassed := False;
          end;
        end;
        if not ValidationPassed then
        begin
          try
            if Assigned(Result) then
            begin
              if Result.Connected then
                Result.Connected := False;
              Result.Free;
            end;
            ConnInfo.Free;
            Dec(FCreatedConnections);
            Log('🗑️ Conexão corrompida removida do pool');
          except
            on E: Exception do
            begin
              Log(Format('⚠️ Erro ao liberar conexão corrompida: %s', [E.Message]));
              Dec(FCreatedConnections);
            end;
          end;
          Result := nil;
          Continue;
        end;
      end
      // CENÁRIO 2: Cria nova conexão
      else if FCreatedConnections < FMaxConnections then
      begin
        try
          Log(Format('🏗️ Criando nova conexão (%d/%d)...',
            [FCreatedConnections + 1, FMaxConnections]));
          Result := CreateConnection;
          if Assigned(Result) then
          begin
            Inc(FSuccessfulGets);
            WaitTime := CurrentTime - StartTime;
            Log(Format('✅ Nova conexão criada em %dms', [WaitTime]));
            Exit;
          end;
        except
          on E: Exception do
          begin
            Log(Format('❌ Erro ao criar conexão: %s', [E.Message]));
            Result := nil;
          end;
        end;
      end;
    finally
      FLock.Leave;
    end;
    // Log e wait
    if (CurrentTime - LastLogTime) > 5000 then
    begin
      LastLogTime := CurrentTime;
      Log(Format('⏳ AGUARDANDO... Tentativa %d/%d, %ds/%ds',
        [AttemptCount, FMaxRetryAttempts,
         (CurrentTime - StartTime) div 1000, FMaxWaitTimeMs div 1000]));
    end;
    if Result = nil then
      Sleep(FRetryIntervalMs + (AttemptCount * 50));
  end;
  // Timeout
  if Result = nil then
  begin
    FLock.Enter;
    try
      Inc(FTimeoutErrors);
    finally
      FLock.Leave;
    end;
    raise Exception.CreateFmt('🚨 POOL ESGOTADO após %d tentativas! (Timeout: %dms)', [AttemptCount, FMaxWaitTimeMs]);
  end;
end;

procedure TConnectionPool.ReleaseConnection(AConnection: TFDConnection);
var
  ConnectionHealthy: Boolean;
  ConnInfo: TConnectionInfo;
  CurrentTime: Int64;
begin
  if not Assigned(AConnection) then
    Exit;
  ConnectionHealthy := False;
  CurrentTime := GetCurrentTimeMs;
  FLock.Enter;
  try
    try
      CleanupConnection(AConnection);
      if ValidateConnection(AConnection) then
      begin
        ConnectionHealthy := True;
        ConnInfo := TConnectionInfo.Create(AConnection, CurrentTime);
        ConnInfo.LastUsedTime := CurrentTime; // Atualiza o tempo de uso
        FConnections.Enqueue(ConnInfo);
        Log(Format('🔄 Conexão saudável devolvida. Pool: %d disponíveis',
          [FConnections.Count]));
      end;
    except
      on E: Exception do
      begin
        Log(Format('❌ Conexão problemática ao liberar (será descartada): %s', [E.Message]));
        ConnectionHealthy := False;
      end;
    end;
    if not ConnectionHealthy then
    begin
      try
        if Assigned(AConnection) then
        begin
          if AConnection.Connected then
            AConnection.Connected := False;
          AConnection.Free;
        end;
        Dec(FCreatedConnections);
        Log(Format('🗑️ Conexão removida do pool. Restam: %d/%d',
          [FCreatedConnections, FMaxConnections]));
      except
        on E: Exception do
        begin
          Log(Format('⚠️ Erro ao liberar conexão problemática: %s', [E.Message]));
          Dec(FCreatedConnections);
        end;
      end;
    end;
  finally
    FLock.Leave;
  end;
end;

procedure TConnectionPool.RemoveIdleConnections;
var
  TempQueue: TQueue<TConnectionInfo>;
  ConnInfo: TConnectionInfo;
  CurrentTime: Int64;
begin
  if FCreatedConnections <= FMaxConnections then
    Exit; // Não remove se já estiver dentro do limite

  CurrentTime := GetCurrentTimeMs;
  TempQueue := TQueue<TConnectionInfo>.Create;
  try
    FLock.Enter;
    try
      while FConnections.Count > 0 do
      begin
        ConnInfo := FConnections.Dequeue;
        if (FCreatedConnections > FMaxConnections) and
           (CurrentTime - ConnInfo.LastUsedTime > FMaxIdleTimeMs div 2) then
        begin
          try
            if Assigned(ConnInfo.Connection) and ConnInfo.Connection.Connected then
              ConnInfo.Connection.Connected := False;
            ConnInfo.Connection.Free;
            ConnInfo.Free;
            Dec(FCreatedConnections);
            Log('🗑️ Conexão ociosa removida durante redução do pool');
          except
            on E: Exception do
            begin
              Log(Format('⚠️ Erro ao remover conexão ociosa: %s', [E.Message]));
              Dec(FCreatedConnections);
            end;
          end;
        end
        else
          TempQueue.Enqueue(ConnInfo);
      end;
      // Restaura conexões não removidas
      while TempQueue.Count > 0 do
        FConnections.Enqueue(TempQueue.Dequeue);
    finally
      FLock.Leave;
    end;
  finally
    TempQueue.Free;
  end;
end;

(*function TConnectionPool.GetConnection: TFDConnection;
var
  AttemptCount: Integer;
  StartTime, CurrentTime: Int64;
  WaitTime: Integer;
  LastLogTime: Int64;
  ValidationPassed: Boolean;
begin
  Result := nil;
  AttemptCount := 0;
  StartTime := GetCurrentTimeMs;
  LastLogTime := StartTime;

  FLock.Enter;
  try
    Inc(FTotalRequests);
    WriteLn(Format('🔍 GetConnection #%d iniciado. Pool: %d disponíveis, %d/%d criadas',
      [FTotalRequests, FConnections.Count, FCreatedConnections, FMaxConnections]));
  finally
    FLock.Leave;
  end;

  while (Result = nil) and
        (AttemptCount < FMaxRetryAttempts) and
        ((GetCurrentTimeMs - StartTime) < FMaxWaitTimeMs) do
  begin
    Inc(AttemptCount);
    CurrentTime := GetCurrentTimeMs;

    FLock.Enter;
    try
      // CENÁRIO 1: Pega conexão disponível
      if FConnections.Count > 0 then
      begin
        Result := FConnections.Dequeue;
        ValidationPassed := False;

        try
          // VALIDAÇÃO ROBUSTA
          if ValidateConnection(Result) then
          begin
            CleanupConnection(Result);  // Limpa estado!
            ValidationPassed := True;

            Inc(FSuccessfulGets);
            WaitTime := CurrentTime - StartTime;
            WriteLn(Format('✅ Conexão validada e limpa em %dms (tentativa %d)',
              [WaitTime, AttemptCount]));
            Exit;
          end;

        except
          on E: Exception do
          begin
            WriteLn(Format('❌ Conexão corrompida durante validação/limpeza: %s', [E.Message]));
            ValidationPassed := False;
          end;
        end;

        // Se validação falhou, remove conexão
        if not ValidationPassed then
        begin
          try
            if Assigned(Result) then // Garante que Result não é nil antes de tentar acessar
            begin
              if Result.Connected then
                Result.Connected := False;
              Result.Free;
            end;
            Dec(FCreatedConnections);
            WriteLn('🗑️  Conexão corrompida removida do pool');
          except on E: Exception do Begin
            WriteLn(Format('⚠️  Erro ao liberar conexão corrompida: %s', [E.Message]));
            Dec(FCreatedConnections); // Força decremento mesmo se Free falhar
            End;
          end;
          Result := nil;
          Continue;
        end;
      end

      // CENÁRIO 2: Cria nova conexão
      else if FCreatedConnections < FMaxConnections then
      begin
        try
          WriteLn(Format('🏗️  Criando nova conexão (%d/%d)...',
            [FCreatedConnections + 1, FMaxConnections]));

          Result := CreateConnection;
          if Assigned(Result) then
          begin
            Inc(FSuccessfulGets);
            WaitTime := CurrentTime - StartTime;
            WriteLn(Format('✅ Nova conexão criada em %dms', [WaitTime]));
            Exit;
          end;
        except
          on E: Exception do
          begin
            WriteLn(Format('❌ Erro ao criar conexão: %s', [E.Message]));
            Result := nil;
          end;
        end;
      end;

    finally
      FLock.Leave;
    end;

    // Log e wait
    if (CurrentTime - LastLogTime) > 5000 then
    begin
      LastLogTime := CurrentTime;
      WriteLn(Format('⏳ AGUARDANDO... Tentativa %d/%d, %ds/%ds',
        [AttemptCount, FMaxRetryAttempts,
         (CurrentTime - StartTime) div 1000, FMaxWaitTimeMs div 1000]));
    end;

    if Result = nil then
      Sleep(FRetryIntervalMs + (AttemptCount * 50));
  end;

  // Timeout
  if Result = nil then
  begin
    FLock.Enter;
    try
      Inc(FTimeoutErrors);
    finally
      FLock.Leave;
    end;

    raise Exception.CreateFmt('🚨 POOL ESGOTADO após %d tentativas! (Timeout: %dms)', [AttemptCount, FMaxWaitTimeMs]);
  end;
end;

procedure TConnectionPool.ReleaseConnection(AConnection: TFDConnection);
var
  ConnectionHealthy: Boolean;
begin
  if not Assigned(AConnection) then
    Exit;

  ConnectionHealthy := False;

  FLock.Enter;
  try
    try
      // LIMPEZA ROBUSTA
      CleanupConnection(AConnection);

      // VALIDAÇÃO FINAL
      if ValidateConnection(AConnection) then
      begin
        ConnectionHealthy := True;
        FConnections.Enqueue(AConnection);
        WriteLn(Format('🔄 Conexão saudável devolvida. Pool: %d disponíveis',
          [FConnections.Count]));
      end;

    except
      on E: Exception do
      begin
        WriteLn(Format('❌ Conexão problemática ao liberar (será descartada): %s', [E.Message]));
        ConnectionHealthy := False;
      end;
    end;

    // Remove conexão problemática
    if not ConnectionHealthy then
    begin
      try
        if Assigned(AConnection) then // Garante que AConnection não é nil antes de tentar acessar
        begin
          if AConnection.Connected then
            AConnection.Connected := False;
          AConnection.Free;
        end;
        Dec(FCreatedConnections);
        WriteLn(Format('🗑️  Conexão removida do pool. Restam: %d/%d',
          [FCreatedConnections, FMaxConnections]));
      except on E: Exception do Begin
        WriteLn(Format('⚠️  Erro ao liberar conexão problemática: %s', [E.Message]));
        Dec(FCreatedConnections); // Força decremento
        End;
      end;
    end;

  finally
    FLock.Leave;
  end;
end;
*)

procedure TConnectionPool.ResetConnectionState(AConnection: TFDConnection);
begin
  if Assigned(AConnection) then
  begin
    // Restaura timeouts padrão
    AConnection.ResourceOptions.CmdExecTimeout := COMMAND_TIMEOUT;

    // Garante configurações corretas
    AConnection.ResourceOptions.DirectExecute := True;
    AConnection.ResourceOptions.KeepConnection := True;
    AConnection.ResourceOptions.SilentMode := True;

    // Adicional: Limpar quaisquer datasets ou comandos pendentes
    // Embora AbortJob já faça isso, é bom ser explícito se houver outros componentes
    // AConnection.CloseDataSets; // Pode ser útil dependendo do uso
  end;
end;

procedure TConnectionPool.SafeDecCreatedConnections;
begin
  FLock.Enter;
  try
    Dec(FCreatedConnections);
  finally
    FLock.Leave;
  end;
end;

procedure TConnectionPool.SafeIncCreatedConnections;
begin
  FLock.Enter;
  try
    Inc(FCreatedConnections);
  finally
    FLock.Leave;
  end;
end;

function TConnectionPool.ValidateConnection(AConnection: TFDConnection): Boolean;
var
  TestQuery: TFDQuery;
  StartTime: Int64;
begin
  Result := False;
  if not Assigned(AConnection) then
  begin
    WriteLn('⚠️ Tentativa de validar conexão nula.');
    Exit;
  end;
  try
    StartTime := GetCurrentTimeMs;
    // TESTE 1: Verificar estado da conexão sem query
    if AConnection.Connected then
    begin
      Result := True;
      WriteLn(Format('✅ Conexão considerada válida por estado em %dms', [GetCurrentTimeMs - StartTime]));
      Exit; // Sai se a conexão parece OK
    end
    else
    begin
      WriteLn('⚠️ Conexão desconectada - tentando reconectar...');
      AConnection.Connected := True;
      WriteLn('✅ Conexão reconectada com sucesso.');
    end;
    // TESTE 2: Query apenas se reconexão ocorreu ou em intervalos
    TestQuery := TFDQuery.Create(nil);
    try
      TestQuery.Connection := AConnection;
      TestQuery.SQL.Text := 'SELECT 1 as test_connection';
      TestQuery.ResourceOptions.CmdExecTimeout := 3000;
      TestQuery.Open;
      if TestQuery.RecordCount > 0 then
      begin
        Result := True;
        WriteLn(Format('✅ Conexão validada por query em %dms', [GetCurrentTimeMs - StartTime]));
      end;
    finally
      if Assigned(TestQuery) then
      begin
        if TestQuery.Active then
          TestQuery.Close;
        TestQuery.Free;
      end;
    end;
  except
    on E: Exception do
    begin
      WriteLn(Format('❌ Conexão inválida durante validação: %s', [E.Message]));
      Result := False;
    end;
  end;
end;

(*
function TConnectionPool.ValidateConnection(
  AConnection: TFDConnection): Boolean;
var
  TestQuery: TFDQuery;
  StartTime: Int64;
begin
  Result := False;
  TestQuery := nil;

  if not Assigned(AConnection) then
  begin
    WriteLn('⚠️  Tentativa de validar conexão nula.');
    Exit;
  end;

  try
    StartTime := GetCurrentTimeMs;

    // TESTE 1: Verificar se conectado
    if not AConnection.Connected then
    begin
      WriteLn('⚠️  Conexão desconectada - tentando reconectar...');
      try
        AConnection.Connected := True;
        WriteLn('✅ Conexão reconectada com sucesso.');
      except
        on E: Exception do
        begin
          WriteLn(Format('❌ Falha ao reconectar conexão: %s', [E.Message]));
          Exit; // Não prossegue com o teste de query se a reconexão falhou
        end;
      end;
    end;

    // TESTE 2: Query simples com timeout curto
    TestQuery := TFDQuery.Create(nil);
    try
      TestQuery.Connection := AConnection;
      TestQuery.SQL.Text := 'SELECT 1 as test_connection';
      TestQuery.ResourceOptions.CmdExecTimeout := 3000; // 3s apenas para teste

      TestQuery.Open;

      if TestQuery.RecordCount > 0 then
      begin
        Result := True;
        WriteLn(Format('✅ Conexão validada por query em %dms', [GetCurrentTimeMs - StartTime]));
      end
      else
      begin
        WriteLn('❌ Query de validação não retornou resultados.');
      end;
    finally
      if Assigned(TestQuery) then
      begin
        if TestQuery.Active then
          TestQuery.Close;
        TestQuery.Free;
      end;
    end;

  except
    on E: Exception do
    begin
      WriteLn(Format('❌ Conexão inválida durante validação por query: %s', [E.Message]));
      Result := False;
    end;
  end;
end;
*)

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

    Result := Format('Pool: %d/%d conexões, %d disponíveis, %.1f%% sucesso (%d/%d reqs, %d timeouts)',
      [Created, FMaxConnections, Available, SuccessRate, FSuccessfulGets, FTotalRequests, FTimeoutErrors]);
  finally
    FLock.Leave;
  end;
end;

function TConnectionPool.IsConnectionExpired(
  AConnInfo: TConnectionInfo): Boolean;
var
  CurrentTime: Int64;
begin
  CurrentTime := GetCurrentTimeMs;
  Result := (CurrentTime - AConnInfo.CreationTime > FMaxLifetimeMs) or
            (CurrentTime - AConnInfo.LastUsedTime > FMaxIdleTimeMs);
  if Result then
    Log(Format('⏳ Conexão expirada: Vida=%dms (max=%dms), Inativa=%dms (max=%dms)',
      [CurrentTime - AConnInfo.CreationTime, FMaxLifetimeMs,
       CurrentTime - AConnInfo.LastUsedTime, FMaxIdleTimeMs]));
end;

{ TLogQueue }

constructor TLogQueue.Create;
begin
  FQueue := TQueue<string>.Create;
  FLock := TCriticalSection.Create;
  FLogThread := TThread.CreateAnonymousThread(
    procedure
    var
      Msg: string;
    begin
      while not TThread.CurrentThread.CheckTerminated do
      begin
        FLock.Enter;
        try
          if FQueue.Count > 0 then
          begin
            Msg := FQueue.Dequeue;
            WriteLn(Msg); // Ou gravar em arquivo
          end;
        finally
          FLock.Leave;
        end;
        Sleep(100); // Intervalo configurável
      end;
    end);
  FLogThread.Start;
end;

destructor TLogQueue.Destroy;
begin
  // Finaliza a thread de logging
  if Assigned(FLogThread) then
  begin
    FLogThread.Terminate; // Sinaliza para a thread parar
    FLogThread.WaitFor;   // Aguarda a thread terminar
    FLogThread.Free;      // Libera a thread
  end;

  // Libera a fila de mensagens
  if Assigned(FQueue) then
    FQueue.Free;

  // Libera o objeto de sincronização
  if Assigned(FLock) then
    FLock.Free;

  inherited;
end;

procedure TLogQueue.Log(const AMessage: string);
begin
  FLock.Enter;
  try
    FQueue.Enqueue(Format('[%s] %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now), AMessage]));
  finally
    FLock.Leave;
  end;
end;

{ TConnectionInfo }

constructor TConnectionInfo.Create(AConnection: TFDConnection;
  ACurrentTimeMs: Int64);
begin
  Connection := AConnection;
  CreationTime := ACurrentTimeMs;
  LastUsedTime := ACurrentTimeMs;
end;

initialization
  // Para aplicações console, a inicialização global é aceitável.
  // Em serviços Windows, considere usar um mecanismo de inicialização de serviço.
  WriteLn(Format('[%s] %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now), 'Inicializando Pool Global de Conexões...']));
  GlobalConnectionPool := TConnectionPool.Create(100);

finalization
  WriteLn(Format('[%s] %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now), 'Finalizando Pool Global de Conexões...']));
  if Assigned(GlobalConnectionPool) then
    GlobalConnectionPool.Free;

end.


