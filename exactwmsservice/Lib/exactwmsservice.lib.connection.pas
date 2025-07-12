unit exactwmsservice.lib.connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  // Posix.Base,
  // Posix.Fcntl;
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  Data.DB,
  FireDAC.Comp.UI,
  FireDAC.Stan.Option,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.Pool,
  exactwmsservice.lib.utils,
  FireDAC.Phys.MSSQL, Generics.Collections;

type
  TConnection = class(TComponent)
  private
    FQuery: TFDQuery;
    FSender: TObject;
    FDB: TFDConnection;
    Fdriver: TFDPhysMSSQLDriverLink;
    FtimeExecute: TTime;
    FtimeOpen: TTime;
    FtimeConnect: TTime;
    FListQuerys: TObjectList<TFDQuery>;
    procedure SetupQuery(Obj: TFDQuery);
    Function GetSender: String;

  public
    property DB: TFDConnection read FDB write FDB;
    property Sender: TObject read FSender write FSender;
    property Query: TFDQuery read FQuery write FQuery;
    constructor Create(TypeConnecion: Integer = 0);
    destructor Destroy; override;
    procedure FDQueryBeforeExecute(DataSet: TFDDataSet);
    procedure FDQueryAfterExecute(DataSet: TFDDataSet);
    procedure FDQueryBeforeOpen(DataSet: TDataSet);
    procedure FDQueryAfterOpen(DataSet: TDataSet);
    procedure ConnectionError(ASender, AInitiator: TObject; var AException: Exception);
    Procedure ConnectionRecover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    function GetQuery: TFDQuery;

    procedure DConnectionBeforeConnect(Sender: TObject);
    procedure OnLogin(AConnection: TFDCustomConnection; AParams: TFDConnectionDefParams);
    procedure DAfterforeConnect(Sender: TObject);

    procedure QueryError(ASender, AInitiator: TObject; var AException: Exception);
  end;

const
  _MaxTimeOut = 60000;

implementation

{ TConnection }
{ ------------------------------------------------------------------------------- }
procedure TConnection.ConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  Tutil.Gravalog(GetSender + ' Erro na conexao ' + AException.Message);
  WriteLn('ERRO DE CONEXAO ');
//  Beep;
end;

procedure TConnection.ConnectionRecover(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  //WriteLn('TENTANDO RECUPERAR CONEXAO(Reconectanto no banco)!');
  //DB.Open;
end;

constructor TConnection.Create(TypeConnecion: Integer = 0);
begin
  //Criando a Conexao Normal e/ou Log
  FListQuerys := TObjectList<TFDQuery>.Create();
  DB := TFDConnection.Create(nil);
  Db.FetchOptions.Mode           := fmAll;
  DB.FetchOptions.Unidirectional := true;
  DB.ResourceOptions.KeepConnection := true;
  DB.OnLogin := OnLogin;
  DB.OnError := ConnectionError;
  Db.OnRecover := ConnectionRecover;
  DB.ResourceOptions.SilentMode := true;
  DB.ResourceOptions.AutoReconnect := True;
  DB.BeforeConnect := DConnectionBeforeConnect;
  DB.AfterConnect := DAfterforeConnect;
  // criando sem pool - n�o funcina no modelo atual
  //Tutil.SetConection(DB, TypeConnecion);
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
  // Tutil.Gravalog('  ' + GetSender + '  Conectado ao banco delay conexao: ' +
  // FormatDateTime('HH:mm:ss:zzz', Time - FtimeConnect));

end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.DConnectionBeforeConnect(Sender: TObject);
begin
  FtimeConnect := Time;

end;

{ ------------------------------------------------------------------------------- }
destructor TConnection.Destroy;
var
  I: Integer;
begin;

  // 'sysctl -w vm.drop_caches=3'

  DB.Connected := False;
  { while FListQuerys.Count > 0 do
    begin
    FListQuerys[0].close;
    FreeAndNil(FListQuerys[0]);
    FListQuerys.de

    end; }

  for I := 0 to pred(FListQuerys.Count) do
  begin
    try
      FListQuerys[I].close;
      FreeAndNil(FListQuerys[I]);
    except
      on e: Exception do
        Tutil.Gravalog('  ' + GetSender + ' Query foi previamente liberada !');
    end;
  end;
  try
    FListQuerys.Destroy;
  except

  end;
  try
    if assigned(Query) then
    begin
      Query.close;
      Query.Free;
    end;
  except
  end;
  try
    if assigned(DB) then
    begin
      DB.close;
      DB.Connected := False;
      FreeAndNil(DB);
    end;
  except
  end;

  inherited;
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryAfterExecute(DataSet: TFDDataSet);
begin
  // Tutil.Gravalog('  ' + GetSender + ' Comando executado ' +
  // FormatDateTime('HH:mm:ss:zzz', Time - FtimeExecute));
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryAfterOpen(DataSet: TDataSet);
var
  NomeSender: string;
begin
  NomeSender := GetSender;
  // Tutil.Gravalog('   ' + GetSender + ' - Consulta executada: ' +
  // FormatDateTime('HH:mm:ss:zzz', Time - FtimeOpen) + ' Registros: ' +
  // inttostr(DataSet.RecordCount));

  // if DataSet.RecordCount > 500 then
  // Tutil.Gravalog('   ' + Nomesender + '< Warning > Limit Records  ! ' +
  // copy(TFDQuery(Dataset).sql.text, 0, 100));

  DataSet.First;
end;
{ ------------------------------------------------------------------------------- }

procedure TConnection.FDQueryBeforeExecute(DataSet: TFDDataSet);
begin
  // if (DataSet is TFDQuery) then
  // Tutil.Gravalog('  ' + GetSender + ' Executando comando ' +
  // copy(TFDQuery(DataSet).sql.text, 0, 100));
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryBeforeOpen(DataSet: TDataSet);
begin
  FtimeOpen := Time;
  try
    Tutil.Gravalog('Executando consulta ');
    Tutil.Gravalog('  ' + GetSender + ' Executando consulta ' + copy(trim(TFDQuery(DataSet).sql.text), 0, 400));
  Except
  end;
end;

function TConnection.GetQuery: TFDQuery;
begin
  result := TFDQuery.Create(Self);
  SetupQuery(result);
  FListQuerys.Add(result);
end;

function TConnection.GetSender: String;
begin
  result := '[SQLConexao]';
  if assigned(FSender) then
     result := '[SQLConexao]Sender-> ' + (FSender).ClassName;
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.OnLogin(AConnection: TFDCustomConnection;
  AParams: TFDConnectionDefParams);
begin

end;

procedure TConnection.QueryError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  Tutil.Gravalog('  ' + GetSender + ' Erro na execucao da query ->  ' + AException.Message);
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.SetupQuery(Obj: TFDQuery);
begin
  // {$DEFINE TESTEDEBUG}
  Obj.BeforeOpen    := FDQueryBeforeOpen;
  Obj.BeforeExecute := FDQueryBeforeExecute;
  Obj.AfterOpen     := FDQueryAfterOpen;
  Obj.AfterExecute  := FDQueryBeforeExecute;
  Obj.connection    := DB;
  Obj.ResourceOptions.SilentMode     := true;
  Obj.connection.TxOptions.Isolation := xiReadCommitted;
  Obj.FetchOptions.Unidirectional    := true;
  Obj.FetchOptions.Mode              := fmAll;
  Obj.ResourceOptions.CmdExecTimeout := _MaxTimeOut;

  Obj.OnError := QueryError;
{$IFDEF TESTEDEUBG}
  Obj.FetchOptions.AutoFetchAll := afDisable;
  Obj.FetchOptions.RecsMax := 2 Obj.FetchOptions.RowsetSize := 20;;
{$ENDIF}
end;

{ ------------------------------------------------------------------------------- }
end.
