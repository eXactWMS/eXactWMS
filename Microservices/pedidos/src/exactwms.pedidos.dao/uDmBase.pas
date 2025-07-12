unit uDmBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,

  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MySQL,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script,
  FireDAC.Phys.MySQLDef,  FireDAC.Stan.Util, IniFiles,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.MSSQL,
  FireDAC.ConsoleUI.Wait;

type
  TDmBase = class(TDataModule)
    ConnRhemaWMS: TFDConnection;
    QryTemp: TFDQuery;
    FDTransaction1: TFDTransaction;
    FDScript1: TFDScript;
    QryData: TFDQuery;
    RESTClientWMS: TRESTClient;
    RESTRequestWMS: TRESTRequest;
    RESTResponseWMS: TRESTResponse;
    FDConnection1: TFDConnection;
    RESTClientCep: TRESTClient;
    RESTRequestCep: TRESTRequest;
    RESTResponseCep: TRESTResponse;
    ClientGraphics: TRESTClient;
    ReqGraphics: TRESTRequest;
    RespGraphics: TRESTResponse;
    ClientReport: TRESTClient;
    RequestReport: TRESTRequest;
    ResponseReport: TRESTResponse;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink2: TFDPhysMySQLDriverLink;
    procedure QryTempAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }

    Procedure ResetRest(pConnector: String = 'D');
    // D-Default   R-Report   S-Search
  end;

var
  DmBase: TDmBase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFuncoes;

{$R *.dfm}

procedure TDmBase.QryTempAfterPost(DataSet: TDataSet);
var
  i: integer;
begin
  inherited;
  for i := 0 to DataSet.Fields.Count - 1 do
  begin
    if DataSet.Fields[i] is TFloatField then
      TFloatField(DataSet.Fields[i]).DisplayFormat := ',0.00'
    else if DataSet.Fields[i] is TIntegerField then
      TIntegerField(DataSet.Fields[i]).DisplayFormat := '000';
  end;
end;

procedure TDmBase.ResetRest(pConnector: String);
// D-Default   R-Report   S-Search;
Var
  Erro: Boolean;
begin
  if pConnector = 'R' then
  Begin
    Repeat
      Try
        Erro := False;
        RequestReport.ResetToDefaults;
        ClientReport.Accept := 'application/json';
        // , text/plain; q=0.9, text/html;q=0.8,';
        ClientReport.AcceptCharset := 'UTF-8, *;q=0.8'; // 'application/json';//
      Except
        ON E: Exception do
          Erro := True;
      End;
    Until (Not Erro);
    RequestReport.Timeout := 30000; // *5;

    RequestReport.Params.AddHeader('usuarioid', '0');

{$IFDEF Android}
    RequestReport.Params.AddHeader('terminal', IMEI);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
    RequestReport.Params.AddHeader('versao', VersaoAPK);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
{$ELSE}
    RequestReport.Params.AddHeader('terminal', NomeDoComputador);
    RequestReport.Params.AddHeader('versao', Versao);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
{$ENDIF}
    RequestReport.Params.AddHeader('appname', 'eXactWMS');
  End
  Else if pConnector = 'S' then
  Begin
    Repeat
      Try
        Erro := False;
        RESTRequestWMS.ResetToDefaults;
        RESTClientWMS.Accept := 'application/json';
        // , text/plain; q=0.9, text/html;q=0.8,';
        RESTClientWMS.AcceptCharset := 'UTF-8, *;q=0.8';
        // 'application/json';//
        ClientGraphics.Accept := 'application/json';
        // , text/plain; q=0.9, text/html;q=0.8,';
        ClientGraphics.AcceptCharset := 'UTF-8, *;q=0.8';
        // 'application/json';//
      Except
        ON E: Exception do
          Erro := True;
      End;
    Until (Not Erro);
    RESTRequestWMS.Timeout := 30000; // *5;

    RESTRequestWMS.Params.AddHeader('usuarioid', '0');

{$IFDEF Android}
    RESTRequestWMS.Params.AddHeader('terminal', IMEI);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
    RESTRequestWMS.Params.AddHeader('versao', VersaoAPK);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
{$ELSE}
    RESTRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
    RESTRequestWMS.Params.AddHeader('versao', Versao);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
{$ENDIF}
    RESTRequestWMS.Params.AddHeader('appname', 'eXactWMS');
  End
  Else
  Begin
    RESTRequestWMS.Params.Count;
    Repeat
      Try
        Erro := False;
        RESTRequestWMS.ResetToDefaults;
        RESTClientWMS.Accept := 'application/json';
        // , text/plain; q=0.9, text/html;q=0.8,';
        RESTClientWMS.AcceptCharset := 'UTF-8, *;q=0.8';
        // 'application/json';//
        ClientGraphics.Accept := 'application/json';
        // , text/plain; q=0.9, text/html;q=0.8,';
        ClientGraphics.AcceptCharset := 'UTF-8, *;q=0.8';
        // 'application/json';//
      Except
        ON E: Exception do
          Erro := True;
      End;
    Until (Not Erro);
    RESTRequestWMS.Timeout := 30000; // *5;

    RESTRequestWMS.Params.AddHeader('usuarioid', '0');

{$IFDEF Android}
    RESTRequestWMS.Params.AddHeader('terminal', IMEI);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
    RESTRequestWMS.Params.AddHeader('versao', VersaoAPK);
    // IMEI;   //Substituído estacao por terminal em 18/03/2021
{$ELSE}
    RESTRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
    RESTRequestWMS.Params.AddHeader('versao', Versao);

{$ENDIF}
    RESTRequestWMS.Params.AddHeader('appname', 'eXactWMS');
  End;
end;
end.
