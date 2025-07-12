unit exactwmsservice.lib.connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  Data.DB,
  FireDAC.Comp.UI,
  FireDAC.Stan.Option,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.Pool,
  exactwmsservice.lib.utils,
  FireDAC.Phys.MSSQL;

type
  TConnection = class
  private
    FQuery: TFDQuery;
    FDB: TFDConnection;
    Fdriver: TFDPhysMSSQLDriverLink;
    FtimeExecute: TTime;
    FtimeOpen: TTime;
    FtimeConnect: TTime;
    procedure SetupQuery(Obj: TFDQuery);
  public
    property DB: TFDConnection read FDB write FDB;
    property Query: TFDQuery read FQuery write FQuery;
    constructor Create(TypeConnecion: Integer = 0);
    destructor Destroy; override;
    procedure FDQueryBeforeExecute(DataSet: TFDDataSet);
    procedure FDQueryAfterExecute(DataSet: TFDDataSet);
    procedure FDQueryBeforeOpen(DataSet: TDataSet);
    procedure FDQueryAfterOpen(DataSet: TDataSet);
    procedure ConnectionError(ASender, AInitiator: TObject;
      var AException: Exception);

    procedure DConnectionBeforeConnect(Sender: TObject);
    procedure DAfterforeConnect(Sender: TObject);
  end;

const
  _MaxTimeOut = 180000;

implementation

{ TConnection }
procedure TConnection.ConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  Tutil.Gravalog('Erro na conexao ' + AException.Message);
end;

constructor TConnection.Create(TypeConnecion: Integer = 0);
begin
  DB := TFDConnection.Create(nil);
  DB.FetchOptions.Unidirectional := true;
  DB.ResourceOptions.CmdExecTimeout := _MaxTimeOut;
  DB.OnError := ConnectionError;
  DB.ResourceOptions.SilentMode := true;
  DB.ResourceOptions.AutoReconnect := true;
  DB.BeforeConnect := DConnectionBeforeConnect;
  DB.AfterConnect:=DAfterforeConnect;
  if TypeConnecion = 1 then
    DB.ConnectionDefName := _CTCONEXAOLOG
  else
    DB.ConnectionDefName := _CTCONEXAO;
  Query := TFDQuery.Create(nil);
  Query.connection := DB;
  SetupQuery(Query);
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.DAfterforeConnect(Sender: TObject);
begin

  Tutil.Gravalog('Conectado ao banco delay conexao: ' +
    FormatDateTime('HH:mm:ss:zzz', Time - FtimeConnect));
end;

procedure TConnection.DConnectionBeforeConnect(Sender: TObject);
begin
  FtimeConnect := Time;
  Tutil.Gravalog('Conectando ao banco -> Conexoes ativas : ' +
    IntToStr(FDManager.ConnectionCount -1));
end;

destructor TConnection.Destroy;
begin
  if assigned(Query) then
  begin
    Query.Close;
    Query.Free;
  end;
  if assigned(DB) then
  begin
    DB.Connected := False;
    DB.Free;
  end;
  if assigned(Fdriver) then
  begin
    FreeAndNil(Fdriver);
  end;
  inherited;
end;

procedure TConnection.FDQueryAfterExecute(DataSet: TFDDataSet);
begin
  Tutil.Gravalog('Comando executado ' + TimeToStr(Time - FtimeExecute));
end;

procedure TConnection.FDQueryAfterOpen(DataSet: TDataSet);
begin
  Tutil.Gravalog('Consulta executada ' + TimeToStr(Time - FtimeOpen));
end;

procedure TConnection.FDQueryBeforeExecute(DataSet: TFDDataSet);
begin
  FtimeExecute := Time;
  Tutil.Gravalog('Executando comando ');
end;

procedure TConnection.FDQueryBeforeOpen(DataSet: TDataSet);
begin
  FtimeOpen := Time;
  Tutil.Gravalog('Executando consulta ');
end;

procedure TConnection.SetupQuery(Obj: TFDQuery);
begin
  Obj.BeforeOpen := FDQueryBeforeOpen;
  Obj.BeforeExecute := FDQueryBeforeExecute;
  Obj.AfterOpen := FDQueryAfterOpen;
  Obj.AfterExecute := FDQueryBeforeExecute;
  Obj.connection := DB;
  Obj.ResourceOptions.SilentMode := true;
  Obj.ResourceOptions.CmdExecTimeout := _MaxTimeOut;
  Obj.FetchOptions.Unidirectional := true;
end;

end.
