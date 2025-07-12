unit uDmeXactWMS;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Comp.UI;
  //Data.Bind.Components, Data.Bind.ObjectScope;

type
  TDmeXactWMS = class(TDataModule)
    RESTRequestWMS: TRESTRequest;
    RESTClientWMS: TRESTClient;
    RESTResponseWMS: TRESTResponse;
    RESTClientCep: TRESTClient;
    RESTRequestCep: TRESTRequest;
    RESTResponseCep: TRESTResponse;
    FdWmsSqlLite: TFDConnection;
    QryVolumeProduto: TFDQuery;
    QryVolumeProdutoSalvar: TFDQuery;
    QryVolumeLote: TFDQuery;
    QryVolumeLoteSalvar: TFDQuery;
    QryGetVolumeProduto: TFDQuery;
    QryGetVolumeLote: TFDQuery;
    QryDelVolumeProdutoLote: TFDQuery;
    QryPesquisa: TFDQuery;
    QryVolumeEAN: TFDQuery;
    QryVolumeEANpedidovolumeid: TIntegerField;
    QryVolumeEANprodutoid: TIntegerField;
    QryVolumeEANcodbarras: TStringField;
    QryVolumeEANunidadesembalagem: TIntegerField;
    QryPesquisaVolumeLote: TFDQuery;
    ClientReport: TRESTClient;
    RequestReport: TRESTRequest;
    ResponseReport: TRESTResponse;
    QryVolumeCorteLote: TFDQuery;
    QryFinalizarVolumeLote: TFDQuery;
    QryVolumeDivergencia: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ResetRest(pConnector : String = 'D'); //D-Default   R-Report   S-Search;
  end;

var
  DmeXactWMS: TDmeXactWMS;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uFrmeXactWMS, uFuncoes;

{$R *.dfm}

{ TDmeXactWMS }

procedure TDmeXactWMS.ResetRest(pConnector : String);
Var Erro : Boolean;
begin
  Try
    if pConnector = 'R' then Begin
       RequestReport.ResetToDefaults;
       RequestReport.Timeout := 30000;
       ClientReport.Accept := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
       ClientReport.AcceptCharset := 'UTF-8, *;q=0.8';
       RequestReport.Params.Clear;
       if FrmeXactWMS.ObjUsuarioCtrl = Nil then
          RequestReport.Params.AddHeader('usuarioid', '0')
       Else
          RequestReport.Params.AddHeader('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
       {$IfDef Android}
          RequestReport.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
          RequestReport.Params.AddHeader('versao', VersaoAPK); //IMEI;   //Substituído estacao por terminal em 18/03/2021
          RequestReport.Params.AddHeader('appname', 'eXactWMSMobileAPK');
       {$else}
          RequestReport.Params.AddHeader('terminal', NomeDoComputador);
          RequestReport.Params.AddHeader('versao', Versao('eXactWmsMobile.exe')); //IMEI;   //Substituído estacao por terminal em 18/03/2021
          RequestReport.Params.AddHeader('appname', 'eXactWMSMobileWin');
       {$Endif}
    End
    Else Begin
      RESTRequestWMS.ResetToDefaults;
      RESTRequestWMS.Timeout := 30000;
      RESTClientWMS.Accept := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
      RESTClientWMS.AcceptCharset := 'UTF-8, *;q=0.8';
      RESTRequestWMS.Params.Clear;
      if FrmeXactWMS.ObjUsuarioCtrl = Nil then
         RESTRequestWMS.Params.AddHeader('usuarioid', '0')
      Else
         RESTRequestWMS.Params.AddHeader('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
      {$IfDef Android}
         RESTRequestWMS.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
         RESTRequestWMS.Params.AddHeader('appname', 'eXactWMSMobileAPK');
         RESTRequestWMS.Params.AddHeader('versao', VersaoAPK);
      {$else}
         RESTRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
         RESTRequestWMS.Params.AddHeader('appname', 'eXactWMSMobileWin');
         RESTRequestWMS.Params.AddHeader('versao', Versao('eXactWmsMobile.exe'));
      {$Endif}
    End;
  Except ON E: Exception do
    raise Exception.Create('Erro ResetRest '+E.Message);
  End;
end;


end.
