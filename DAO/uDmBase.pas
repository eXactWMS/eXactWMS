unit uDmBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, WinApi.WIndows,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase, FireDAC.Phys.MySQL,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, ACBrBase, ACBrSocket,
  ACBrConsultaCNPJ, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Util, IniFiles,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.MSSQL;

type
  TDmBase = class(TDataModule)
    ConnRhemaWMS: TFDConnection;
    QryTemp: TFDQuery;
    FDTransaction1: TFDTransaction;
    FDScript1: TFDScript;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
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
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ClientReport: TRESTClient;
    RequestReport: TRESTRequest;
    ResponseReport: TRESTResponse;
    procedure QryTempAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function ConectarFD: Boolean;
    Procedure ResetRest(pConnector : String = 'D'); //D-Default   R-Report   S-Search
  end;

var
  DmBase: TDmBase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFuncoes, uFrmeXactWMS;

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

procedure TDmBase.ResetRest(pConnector : String); //D-Default   R-Report   S-Search;
Var Erro : Boolean;
begin
  if pConnector = 'R' then Begin
     Repeat
       Try
         Erro := False;
         RequestReport.ResetToDefaults;
         ClientReport.Accept         := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
         ClientReport.AcceptCharset  := 'UTF-8, *;q=0.8';   //'application/json';//
       Except ON E: Exception do
         Erro := True;
       End;
     Until (Not erro);
     RequestReport.Timeout := 30000;//*5;
     if FrmeXactWMS.ObjUsuarioCtrl = Nil then
        RequestReport.Params.AddHeader('usuarioid', '0')
     Else
        RequestReport.Params.AddHeader('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
     {$IfDef Android}
        RequestReport.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
        RequestReport.Params.AddHeader('versao', VersaoAPK); //IMEI;   //Substituído estacao por terminal em 18/03/2021
     {$else}
        RequestReport.Params.AddHeader('terminal', NomeDoComputador);
        RequestReport.Params.AddHeader('versao', Versao); //IMEI;   //Substituído estacao por terminal em 18/03/2021
     {$Endif}
     RequestReport.Params.AddHeader('appname', 'eXactWMS');
  End
  Else if PConnector = 'S' then Begin
     Repeat
       Try
         Erro := False;
         RESTRequestWMS.ResetToDefaults;
         RESTClientWMS.Accept         := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
         RESTClientWMS.AcceptCharset  := 'UTF-8, *;q=0.8';   //'application/json';//
         ClientGraphics.Accept        := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
         ClientGraphics.AcceptCharset := 'UTF-8, *;q=0.8';   //'application/json';//
       Except ON E: Exception do
         Erro := True;
       End;
     Until (Not erro);
     RESTRequestWMS.Timeout := 30000;//*5;
     if FrmeXactWMS.ObjUsuarioCtrl = Nil then
        RESTRequestWMS.Params.AddHeader('usuarioid', '0')
     Else
        RESTRequestWMS.Params.AddHeader('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
     {$IfDef Android}
        RESTRequestWMS.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
        RESTRequestWMS.Params.AddHeader('versao', VersaoAPK); //IMEI;   //Substituído estacao por terminal em 18/03/2021
     {$else}
        RESTRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
        RESTRequestWMS.Params.AddHeader('versao', Versao); //IMEI;   //Substituído estacao por terminal em 18/03/2021
     {$Endif}
     RESTRequestWMS.Params.AddHeader('appname', 'eXactWMS');
  End
  Else Begin
     RESTRequestWMS.Params.Count;
     Repeat
       Try
         Erro := False;
         RESTRequestWMS.ResetToDefaults;
         RESTClientWMS.Accept         := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
         RESTClientWMS.AcceptCharset  := 'UTF-8, *;q=0.8';   //'application/json';//
         ClientGraphics.Accept        := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
         ClientGraphics.AcceptCharset := 'UTF-8, *;q=0.8';   //'application/json';//
       Except ON E: Exception do
         Erro := True;
       End;
     Until (Not erro);
     RESTRequestWMS.Timeout := 30000;//*5;
     if FrmeXactWMS.ObjUsuarioCtrl = Nil then
        RESTRequestWMS.Params.AddHeader('usuarioid', '0')
     Else
        RESTRequestWMS.Params.AddHeader('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
     {$IfDef Android}
        RESTRequestWMS.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
        RESTRequestWMS.Params.AddHeader('versao', VersaoAPK); //IMEI;   //Substituído estacao por terminal em 18/03/2021
     {$else}
        RESTRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
        RESTRequestWMS.Params.AddHeader('versao', Versao); //IMEI;   //Substituído estacao por terminal em 18/03/2021
     {$Endif}
     RESTRequestWMS.Params.AddHeader('appname', 'eXactWMS');
  End;
end;

Function TDmBase.ConectarFD : Boolean;
Var ArqIni : TIniFile;
    vIpServidor, vIpChave : AnsiString;
begin
  inherited;
  if Not fileexists(FrmeXactWMS.PathApp+'DataReyLoja.Ini') then Begin
     ArqIni := TIniFile.Create(FrmeXactWMS.PathApp+'DataReyLoja.Ini');
//Banco de Dados
     repeat
       vIpServidor := InputBox('Conexão Banco de Dados', 'Informe o Ip do Servidor', '');
     until vIpServidor <> '';
     ArqIni.WriteString('BD','Server',CriptografarSimples(vIpServidor));
     ArqIni.WriteString('BD','User_Name',CriptografarSimples('root'));
     ArqIni.WriteString('BD','PassWord',CriptografarSimples('rhemasys')); //yeratad806092'));
     ArqIni.WriteString('BD','DataBase',CriptografarSimples('exactwms'));  //DataReyLoja
     ArqIni.WriteString('CONFIG','Idioma',CriptografarSimples('1'));
     ArqIni.WriteString('CONFIG','Internet',CriptografarSimples('1'));
     ArqIni.WriteString('CONFIG','Som1',CriptografarSimples('7500'));
     ArqIni.WriteString('CONFIG','Som2',CriptografarSimples('5200'));
   //Chave de Proteção
     repeat
       vIpChave := InputBox('Chave - Licença de uso...', 'Informe o Ip da Chave', '');
     until vIpChave <> '';
//     ShowMessage('Definindo chave em '+vIpChave);
     ArqIni.WriteString('CONKEY','Host',CriptografarSimples(vIpChave));
     ArqIni.WriteString('CONKEY','Port',CriptografarSimples('50003'));
     ArqIni.WriteString('CONKEY','Seed',CriptografarSimples('004'));
     ArqIni.Destroy;
  End;
  Try
    ArqIni := TIniFile.Create(FrmeXactWMS.PathApp+'DataReyLoja.Ini');
    //FrmRhemaWMS.LblServidor.Caption := 'Servidor.: '+CriptografarSimples(ArqIni.ReadString('BD','Server',''));
    ConnRhemaWMS.Params[0] := 'Server='+CriptografarSimples(ArqIni.ReadString('BD','Server',''));
    ConnRhemaWMS.Params[1] := 'User_Name='+CriptografarSimples(ArqIni.ReadString('BD','User_Name',''));
    ConnRhemaWMS.Params[2] := 'PassWord='+CriptografarSimples(ArqIni.ReadString('BD','PassWord',''));
    ConnRhemaWMS.Params[3] := 'DataBase='+Trim( CriptografarSimples(ArqIni.ReadString('BD','DataBase','')));
    //ConnRhemaWMS.Idioma   := StrToInt(CriptografarSimples(ArqIni.ReadString('CONFIG','Idioma','1')));
    //ConnRhemaWMS.Internet := StrToInt(CriptografarSimples(ArqIni.ReadString('CONFIG','Internet','1')));
    //ConnRhemaWMS.Som1     := StrToInt(CriptografarSimples(ArqIni.ReadString('CONFIG','Som1','7500')));
    //ConnRhemaWMS.Som2     := StrToInt(CriptografarSimples(ArqIni.ReadString('CONFIG','Som2','5200')));
  Except
    Application.MessageBox('Inconsistência no arquivo de parâmetros de inicialização...', 'Erro', MB_ICONERROR + MB_OK);
    FreeAndNil(ArqIni);
    Application.Terminate;
  End;
  Try
    if Not (ConnRhemaWMS.Connected) then
       ConnRhemaWMS.Connected := True;
    RestClientWMS.BaseURL  := CriptografarSimples(ArqIni.ReadString('msService','IpCadastro','Localhoost'));  //http://192.168.0.110:8200/
    ClientGraphics.BaseURL := CriptografarSimples(ArqIni.ReadString('msService','IpCadastro','Localhoost'));  //http://192.168.0.110:8200/
  Except
//    ShowMessage(FdConnection.Params[0]+#13+FdConnection.Params[1]+#13+FdConnection.Params[2]+#13+FdConnection.Params[3]);
    Showmessage('Não foi possível conectar o Banco de Dados no Servidor: '+ConnRhemaWMS.Params[0]+ArqIni.ReadString('BD','Server','')+'...');
    FreeAndNil(ArqIni);
    Application.Terminate;
  End;
  FreeAndNil(ArqIni);
//  FrmDataReyLoja.Login;
//  VProdutoCBarraCFor.Prepared;
end;

end.
