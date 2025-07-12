unit Server.ServerConsole;

interface

uses

  System.SysUtils,
  System.Classes,
  System.Types,
  IdContext,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  IdSSLOpenSSLHeaders,
  IdServerIOHandler,
  IdSSLOpenSSL,
  Server.Config,
  Web.WebReq,
  Web.WebBroker,
  Server.Constants,
  Server.Swagger,
  Server.ResourceBaseClass,
  Server.Connection,
  Datasnap.DSSession;

type
  TGetSSLPassword = class
    procedure OnGetSSLPassword(var APassword:
{$IF CompilerVersion < 27}AnsiString{$ELSE}string{$ENDIF});
  end;

type
  TMyIdSSLContext = class(TIdSSLContext)
  end;

type
  TSSLHelper = class

    procedure QuerySSLPort(APort: Word; var VUseSSL: boolean);
  end;

type
  Tbase = class(TResourceBaseClass)

  end;

type
  TServerConsole = class(TPersistent)
  private
    Ftitle: String;
    Fdescription: String;
  public
    procedure TerminateThreads;
    function BindPort(APort: Integer): boolean;
    function CheckPort(APort: Integer): Integer;
    procedure SetPort(const AServer: TIdHTTPWebBrokerBridge; APort: String);
    Function StartServer(const AServer: TIdHTTPWebBrokerBridge) : Boolean;
    procedure StopServer(const AServer: TIdHTTPWebBrokerBridge);
    procedure WriteCommands;
    procedure WriteStatus(const AServer: TIdHTTPWebBrokerBridge);
    Function RunServer(APort: Integer) : Boolean;
    procedure ExceptionServer(AContext: TIdContext; AException: Exception);

  published
    property Title: String read Ftitle write Ftitle;
    property Description: String read Fdescription write Fdescription;

  end;

var
  ServerConsole: TServerConsole;

implementation

uses
  Schedule.expedicao;

procedure TServerConsole.TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

function TServerConsole.BindPort(APort: Integer): boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := True;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(APort, nil);
  except
    Result := False;
  end;
end;

function TServerConsole.CheckPort(APort: Integer): Integer;
begin
  if BindPort(APort) then
    Result := APort
  else
    Result := 0;
end;

procedure TServerConsole.ExceptionServer(AContext: TIdContext;
  AException: Exception);
begin
  // Writeln('Internal erro '+AException.Message);
end;

procedure TServerConsole.SetPort(const AServer: TIdHTTPWebBrokerBridge;
  APort: String);
begin
  if not AServer.Active then
  begin
    APort := APort.Replace(cCommandSetPort, '').Trim;
    if CheckPort(APort.ToInteger) > 0 then
    begin
      AServer.DefaultPort := APort.ToInteger;
      Writeln(Format(sPortSet, [APort]));
    end
    else
      Writeln(Format(sPortInUse, [APort]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

Function TServerConsole.StartServer(const AServer: TIdHTTPWebBrokerBridge) : Boolean;
begin
  if not AServer.Active then
  begin
    if CheckPort(AServer.DefaultPort) > 0 then
    begin

      AServer.Bindings.Clear;
      AServer.Active := True;
      Result := True;
    end
    else Begin
      Writeln(Format(sPortInUse, [AServer.DefaultPort.ToString]));
      Result := False;
    End;
  end
  else
    Writeln(sServerRunning);

end;

procedure TServerConsole.StopServer(const AServer: TIdHTTPWebBrokerBridge);
begin
  if AServer.Active then
  begin
    Writeln(sStoppingServer);
    TerminateThreads;
    AServer.Active := False;
    AServer.Bindings.Clear;
    Writeln(sServerStopped);
  end
  else
    Writeln(sServerNotRunning);
  Write(cArrow);
end;

procedure TServerConsole.WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure TServerConsole.WriteStatus(const AServer: TIdHTTPWebBrokerBridge);
begin
  Writeln(sIndyVersion + AServer.SessionList.Version);
  Writeln(sActive + AServer.Active.ToString(TUseBoolStrs.True));
  Writeln(sPort + AServer.DefaultPort.ToString);
  Writeln(sSessionID + AServer.SessionIDCookieName);
  Write(cArrow);
end;

procedure TesteDBconnection();
var
  ConnectionTeste: TConnection;
begin
  ConnectionTeste := TConnection.Create;
  try
    try
      if assigned(ConnectionTeste.Query) then
      begin

        ConnectionTeste.Query.SQL.Add('select CURRENT_TIMESTAMP');
        ConnectionTeste.Query.Open();
        Writeln('***************************************************');
        Writeln('***********Sucess to atach database****************');
        Writeln('Server database host :  ' + ConnectionTeste.DB.Params.Values
          ['Server']);
        Writeln('Server database time :  ' + ConnectionTeste.Query.Fields[0]
          .AsString);
        Writeln('***************************************************');
        ConnectionTeste.Query.Close;
      end
      else
      begin
        raise Exception.Create('Conexao não estabelecida');
      end;
    except
      on e: Exception do
        Writeln('Server data ERROR ' + e.Message);

    end;
  finally
    FreeAndNil(ConnectionTeste)
  end;

end;

Function TServerConsole.RunServer(APort: Integer) : Boolean;
var
  LServer: TIdHTTPWebBrokerBridge;
  LResponse: string;
  Initialized: boolean;
  SSLHandler: TIdServerIOHandlerSSLOpenSSL;
  LSSLHelper: TSSLHelper;
  LGetSSLPassword: TGetSSLPassword;
  CertFile: string;
  LKeyFile: string;
  FSSLContext: TMyIdSSLContext;
begin
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  LGetSSLPassword := nil;
  LSSLHelper := nil;
  try
    Writeln('Starting HttpsServer ..');
    LServer.DefaultPort := APort;
    TServerConfig.GetInstance;
    sleep(1000);
    try
      TesteDBconnection();
    except
      on e: Exception do
        Writeln(e.Message);
    end;
    try
      with TSwaggerGenerator.Create do
      begin
        SwaggerConfig.info.Title := Ftitle;
        SwaggerConfig.info.Description := Fdescription;
        Writeln('Config Swagger lib ..');
        MakeReposioty;
        Writeln('Config Swagger lib update, Swager.json ');
        free;
      end;
    except
      on e: Exception do
        Writeln(e.Message);

    end;
    LServer.AutoStartSession := True;
    LServer.SessionIDCookieName := 'UpdateServerCooks';
    LServer.KeepAlive := True;
    try
      Result := StartServer(LServer);
      if Not Result then
         Exit;
    except
      on e: Exception do
        Writeln(e.Message);
    end;
    with TScheduleexpedicao.Create(True) do
    begin
      resume;
    end;

    Writeln('HttpServer online !');
    while True do
    begin

      try
        Readln(LResponse);
        sleep(200);
        if LResponse <> '' then
        begin
          LResponse := LowerCase(LResponse);
          if LResponse.StartsWith(cCommandSetPort) then
            SetPort(LServer, LResponse)
          else if sametext(LResponse, cCommandStart) then
            StartServer(LServer)
          else if sametext(LResponse, cCommandStatus) then
            WriteStatus(LServer)
          else if sametext(LResponse, cCommandStop) then
            StopServer(LServer)
          else if sametext(LResponse, cCommandHelp) then
            WriteCommands
          else if sametext(LResponse, cCommandExit) then
            if LServer.Active then
            begin
              StopServer(LServer);
              break
            end
            else
              break
          else
          begin
            Writeln(LResponse + ' is invalid command');
            Write(cArrow);
          end;
        end;
      except
        on e: Exception do
          Writeln('Fatal Exception on run server ' + e.Message);
      end;
    end;
    Writeln('by..by');
    TerminateThreads();
  finally
    LServer.free;
  end;
end;

{ TSSLHelper }

procedure TSSLHelper.QuerySSLPort(APort: Word; var VUseSSL: boolean);
begin
  VUseSSL := True;
end;

{ TGetSSLPassword }

procedure TGetSSLPassword.OnGetSSLPassword(var APassword: string);
begin
  APassword := '';
end;

initialization
  ServerConsole := TServerConsole.Create;

end.
