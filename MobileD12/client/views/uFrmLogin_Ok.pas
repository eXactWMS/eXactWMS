unit uFrmLogin;
//http://www.theclub.com.br/Restrito/Revistas/201405/delp1405.aspx
//Impressao de Pedidos

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uMyTabOrderClassHelper,
  //Data.DbxJsonReflect,
  FMX.VirtualKeyboard, FMX.Effects, FMX.Objects, System.Math, Rest.Json, Rest.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, System.JSON, System.IOUtils,
  {$IFDEF ANDROID}
    Androidapi.JNI.GraphicsContentViewText,
    Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
    Androidapi.JNI.Os,
    Androidapi.Helpers,
  {$Endif}
  {$IFDEF IOS}
      Macapi.Helpers,
  {$ENDIF IOS}
  FMX.Edit, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, FMX.ScrollBox,
  FMX.Ani, FMX.ListBox, ksTypes, ksLoadingIndicator, FMX.Filter.Effects,
  FMX.Media, Notificacao, ConfiguracaoClass, UsuarioClass, UsuarioCtrl,
  FMX.ActnList, System.Actions, FMX.TabControl, U_MsgD;

type
  TFrmLogin = class(TForm)
    RectAnimation1: TRectAnimation;
    LayoutBase: TLayout;
    ksLoadingIndicator1: TksLoadingIndicator;
    PgcPrincipal: TTabControl;
    TabConfig: TTabItem;
    ActionList1: TActionList;
    ChgTabDet: TChangeTabAction;
    ChgTabLista: TChangeTabAction;
    Ac_Ok: TAction;
    TabDetalhes: TTabItem;
    Layout2: TLayout;
    Layout1: TLayout;
    ImgRSTop: TImage;
    Layout4: TLayout;
    Layout6: TLayout;
    LblConnection: TLabel;
    LblVersao: TLabel;
    Layout5: TLayout;
    VSBConfig: TVertScrollBox;
    RctConfig: TRectangle;
    Código: TLabel;
    EdtEmpresa: TEdit;
    Lnempresa: TLine;
    EdtIpServer: TEdit;
    Line3: TLine;
    LblIpServer: TLabel;
    EdtPortServer: TEdit;
    Line4: TLine;
    Label4: TLabel;
    CbLeitor: TComboBox;
    Label5: TLabel;
    LblSwtLeitor: TLabel;
    SwtLeitor: TSwitch;
    Label6: TLabel;
    SwtKeyboardCfg: TSwitch;
    Layout3: TLayout;
    BtnSave: TSpeedButton;
    PthSave: Fmx.Objects.TPath;
    Label8: TLabel;
    BtnCancel: TSpeedButton;
    Path3: Fmx.Objects.TPath;
    Label9: TLabel;
    MPlayer: TMediaPlayer;
    Image3: TImage;
    Layout7: TLayout;
    Label10: TLabel;
    Label11: TLabel;
    Layout8: TLayout;
    lbl_criar_conta: TLabel;
    Label7: TLabel;
    PthConfigServer: Fmx.Objects.TPath;
    Layout11: TLayout;
    SbConfig: TSpeedButton;
    Layout12: TLayout;
    Layout13: TLayout;
    LblCriarConta: TLabel;
    ActAtualizaAPP: TAction;
    ActNaoAtualizaAPP: TAction;
    imgTop: TImage;
    aninlogo: TFloatAnimation;
    Layout9: TLayout;
    RctKeyboard: TRectangle;
    LBlActKeyboard: TLabel;
    SwtKeyboard: TSwitch;
    SignInBackgroundRect: TRectangle;
    Layout10: TLayout;
    BtnLogIn: TRectangle;
    LblLogin: TLabel;
    EdtSenha: TEdit;
    FillRGBEffect2: TFillRGBEffect;
    Line2: TLine;
    EdtUsuario: TEdit;
    FillRGBEffect1: TFillRGBEffect;
    Line1: TLine;
    Label1: TLabel;
    AnimaLLogin: TFloatAnimation;
    Label2: TLabel;
    AnimalSenha: TFloatAnimation;
    LblUsuario: TLabel;
    FloatAnimation1: TFloatAnimation;
    Path1: Fmx.Objects.TPath;
    Path2: Fmx.Objects.TPath;
    ShadowEffect3: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure EdtUsuarioValidate(Sender: TObject; var Text: string);
    procedure EdtUsuarioKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure SwtKeyboardClick(Sender: TObject);
    procedure EdtEmpresaChangeTracking(Sender: TObject);
    procedure EdtPortServerKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure SwtLeitorClick(Sender: TObject);
    procedure EdtUsuarioEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtSenhaChangeTracking(Sender: TObject);
    procedure BtnLogInClick(Sender: TObject);
    procedure EdtUsuarioTyping(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLogInMouseEnter(Sender: TObject);
    procedure BtnLogInMouseLeave(Sender: TObject);
    procedure SbConfigClick(Sender: TObject);
    procedure LblCriarContaClick(Sender: TObject);
    procedure EdtUsuarioChangeTracking(Sender: TObject);
  private
    { Private declarations }
    Tentativas : Single;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    //Configuração no Arquivo XML
    vArqConfig : String;
    XmlConfig  : IXMLDocument;
    vNode, vNodeChild : IXMLNode;
    Instalation  : Boolean;
    Company_Name : String;
    IpHost, PortHost  : String;
    Brand_Collector   : String;
    Scanner_Collector, Teclado : Boolean;  //Scanner_Collector indica se o Leitor de CB precisa ser ativado pelo App
    ObjUsuarioCtrl    : TUsuarioCtrl;
    vPosLblUsuario, vPosLblSenha : Single;
    Procedure ConfigSqlLite;
    procedure DelayedSetFocus(control: TControl);
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure UpdateKBBounds;
    procedure RestorePosition;
    Procedure LerXmlConfig;
    procedure EndApp;
    Procedure SaveXML;
    procedure MsgErroAlerta(pMensagem: String);
    Procedure ThreadLoginUsuarioTerminate(Sender: TObject);
  public
    { Public declarations }
  end;

Var FrmLogin : TFrmLogin;
    LoginLigado, SenhaLigado: boolean;
    MsgD : TMsgD;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

uses uFrmeXactWMS, uDmClient, uRetorno, uFuncoes, uDmeXactWMS;

procedure TFrmLogin.EdtPortServerKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  SoNumeros(KeyChar);
end;

procedure TFrmLogin.EdtSenhaChangeTracking(Sender: TObject);
begin
if (EdtSenha.Text.Length > 0) and (SenhaLigado=false) then
  begin
   Senhaligado:=true;
   animalSenha.StartValue := vPosLblSenha;
   animalSenha.StopValue  := vPosLblSenha-25;
   animalSenha.Enabled:=true;
   animalSenha.Start;
  end
else if EdtSenha.Text.Length = 0 then
  begin
   Senhaligado:=false;
   animalSenha.StartValue := vPosLblSenha-25;
   animalSenha.StopValue  := vPosLblSenha;
   animalSenha.Enabled:=true;
   animalSenha.Start;
  end;
end;

procedure TFrmLogin.EdtEmpresaChangeTracking(Sender: TObject);
begin
  EdtEmpresa.Text := Capitalizar(EdtEmpresa.text);
end;

procedure TFrmLogin.EdtUsuarioChangeTracking(Sender: TObject);
begin
if (EdtUsuario.Text.Length > 0) and (loginligado=false) then
  begin
   loginligado:=true;
   animallogin.StartValue := vPosLblUsuario;  //40
   animallogin.StopValue  := vPosLblUsuario-25;     //25
   animallogin.Enabled:=true;
   animallogin.Start;
  end
else if EdtUsuario.Text.Length = 0 then
  begin
   loginligado:=false;
   animallogin.StartValue := vPosLblUsuario-25;    //25
   animallogin.StopValue  := vPosLblUsuario; //40;
   animallogin.Enabled:=true;
   animallogin.Start;
  end;
end;

procedure TFrmLogin.EdtUsuarioEnter(Sender: TObject);
begin
  //LBlActKeyboard.Text := 'H='+Height.ToString()+'  W='+Width.ToString();
end;

procedure TFrmLogin.EdtUsuarioKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
  {$if defined(Android)}
var
    i: JIntent;
  {$Endif}
begin
  If (Key in [9, 13]) or (KeyChar=#13) then Begin //and (TEdit(Sender).Text<>'') then Begin
     If (Sender = EdtUsuario) and (EdtUsuario.Text<>'') then
        DelayedSetFocus(EdtSenha)
     Else If (Sender=EdtSenha) and (EdtSenha.Text<>'') then
        BtnLoginClick(BtnLogIn);
//     Key := 0;
  End
  Else if key = vkEscape then
     EndApp;
End;

procedure TFrmLogin.EdtUsuarioTyping(Sender: TObject);
begin
  LblUsuario.Text := '...';
end;

procedure TFrmLogin.EdtUsuarioValidate(Sender: TObject; var Text: string);
Var vErro : String;
    TH    : TThread;
begin
  If EdtUsuario.Text = '' then Exit;
  if StrToIntDef(EdtUsuario.Text, 0) = 0 then Begin
     MsgErroAlerta('Id de usuário inválido!');
     DelayEdSetFocus(EdtUsuario);
     Text := '';
  End;
  ksLoadingIndicator1.ShowLoading;
  TH := TThread.CreateAnonymousThread(procedure
  Var jArray  : TJsonArray;
  begin
    DmClient.RESTRequest1.ResetToDefaults;
    DmClient.RESTResponse1.ResetToDefaults;
    DmClient.ResetREST;
    DmClient.RESTRequest1.Resource := 'v1/usuario/{usuarioid}';
    DmClient.RESTRequest1.Params.AddUrlSegment('usuarioid', EdtUsuario.Text);
    DmClient.RESTRequest1.Method := TRESTRequestMethod.RmGet;
    DmClient.RESTRequest1.Execute;
    if DmCLient.RESTResponse1.StatusCode in [ 200, 201] then Begin
       jArray := DmClient.RESTResponse1.JSONValue as TJSONArray;
       if (jArray.Count<1) or (jArray.Items[0].TryGetValue<String>('Erro', vErro)) then Begin
          DelayedSetFocus(EdtUsuario);
          TThread.Synchronize(TThread.CurrentThread, procedure
          begin
             EdtUsuario.Text := '';
             MsgErroAlerta('Usuário Inválido!!!');
          End);
          jArray := Nil;
          Exit;
       End;
       If Not Assigned(ObjUsuarioCtrl) then
          ObjUsuarioCtrl := TUsuarioCtrl.Create();
       ObjUsuarioCtrl.ObjUsuario := TJson.JsonToObject<TUsuario>(jArray.Items[0].GetValue<TJsonObject>.ToString(), [joDateFormatUnix]);
       ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId  := jArray.Items[0].GetValue<Integer>('perfilid');
       ObjUsuarioCtrl.ObjUsuario.Perfil.Descricao := jArray.Items[0].GetValue<String>('descricao');
       ObjUsuarioCtrl.ObjUsuario.Perfil.Status    := jArray.Items[0].GetValue<integer>('statusperfil');
       ObjUsuarioCtrl.ObjUsuario.Perfil.Data      := StrToDate(jArray.Items[0].GetValue<String>('data'));
       if jArray.Items[0].GetValue<String>('hora') <> '' then
       ObjUsuarioCtrl.ObjUsuario.Perfil.Hora      := StrToTime(Copy(jArray.Items[0].GetValue<String>('hora'), 1, 8));

       if ObjUsuarioCtrl.ObjUsuario.usuarioid = 0 then Begin
          TThread.Synchronize(TThread.CurrentThread, procedure
          begin
             EdtUsuario.Text := '';
             MsgErroAlerta('Usuário Inválido!!!');
          End);
          DelayedSetFocus(EdtUsuario);
          jArray := Nil;
          Exit;
       End
       Else if ObjUsuarioCtrl.ObjUsuario.Status = 2 then Begin
          TThread.Synchronize(TThread.CurrentThread, procedure
          begin
             EdtUsuario.Text := '';
             MsgErroAlerta('Usuário com acesso desativado!!!');
          End);
          DelayedSetFocus(EdtUsuario);
          jArray := Nil;
          Exit;
       End;
       TThread.Synchronize(TThread.CurrentThread, procedure
       begin
         Lblusuario.Text := ObjUsuarioCtrl.ObjUsuario.Nome;
       End);
    End
    Else Begin
       TThread.Synchronize(TThread.CurrentThread, procedure
       begin
         Lblusuario.Text := 'ERRO('+DmCLient.RESTResponse1.StatusCode.ToString()+') '+
                          ReturnREST(DmCLient.RESTResponse1.StatusCode);
         EdtUsuario.Text := '';
       End);
       DelayedSetFocus(EdtUsuario);
       jArray := Nil;
       Exit;
    End;
    jArray := Nil;
  End);
  TH.OnTerminate := ThreadLoginUsuarioTerminate;
  TH.Start;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Assigned(XmlConfig) then
     XmlConfig := Nil;
  If Assigned(vNode) then
     vNode := Nil;
  If Assigned(vNodeChild) Then
     vNodeChild := nil;
  MsgD := Nil;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
Var vArq, ArqSom : String;
begin
  LoginLigado := False;
  SenhaLigado := False;
  {$IfDef Android}
     ksLoadingIndicator1.ShowLoading;
  {$EndIf}
  Application.ProcessMessages;
  Layout2.Visible   := True;
  PgcPrincipal.ActiveTab := TabDetalhes;
  VSBConfig.Visible := True;
  //Tratar se o arquivo Exist
  {$IfDef Android}
    vArq := TPath.Combine(TPath.GetDocumentsPath, 'eXactWmsMobile.exe');
    LblVersao.Text   := 'App Version: '+VersaoAPK;
  {$Endif}
  {$IfDef MSWINDOWS}
    vArq := GetCurrentDir + '\eXactWmsMobile.exe';
    LblVersao.Text   := 'Versão: '+Versao('eXactWmsMobile.exe');
  {$EndIf}
//  if FileExists(vArq) then
//     LblVersao.Text   := 'App Version: '+VersaoAPK //Versao('eXactWmsMobile.exe')
//  Else lblVersao.Text := 'App Version: Undefined';
  Tentativas := 1;
//https://www.devmedia.com.br/conectando-bases-de-dados-no-android-ios-e-windows-pelo-delphi/36901
//Delphi 10.3.3 abaixo
//https://docwiki.embarcadero.com/RADStudio/Sydney/en/Mobile_Tutorial:_Using_FireDAC_and_SQLite_(iOS_and_Android)
Try
  {$IfDef Android}
    //vArq := System.IOUtils.TPath.GetDocumentsPath + PathDelim + 'wmsconfig.xml';
    //vArqConfig := TPath.GetDocumentsPath + PathDelim + 'wmsconfig.xml';
    vArq := TPath.Combine(TPath.GetDocumentsPath, 'wmsconfig.xml');
  {$Endif}
  {$IfDef MSWINDOWS}
//    vArq := GetCurrentDir;
    vArq := GetCurrentDir + '\wmsconfig.xml';
  {$EndIf}
  if not FileExists(vArq) then Begin
     {$IfDef Android}
        ksLoadingIndicator1.HideLoading;
     {$EndIf}
     MessageDlg('Arquivo Configuração('+vArq+') não encontrado', TMsgDlgType.mtWarning,[TMsgDlgBtn.MbOk], 0,
         procedure (const AResult: TModalResult)
         begin
          //if AResult = MrYes then
           {$IfDef Android}
              ksLoadingIndicator1.HideLoading;
           {$EndIf}
           EndApp;
         end
     );
     End
  Else Begin
    LerXmlConfig;
  end;
Except ON E: Exception do Begin
    MessageDlg('ERRO: aqui! '+E.Message, TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbOK], 0,
        procedure (const AResult: TModalResult)
        begin
          if AResult = MrOk then
             Exit; //EndApp
        end
    );
  End;

End;

  Try
{
      If (Not dmClient.ServidorAtivo(IpHost, PortHost)) Then Begin
         ksLoadingIndicator1.HideLoading;
         Layout2.Visible  := True;
         RctLogin.Visible := True;
         MessageDlg('ERRO: Servidor não conectado...', TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbOK], 0,
             procedure (const AResult: TModalResult)
             begin
               if AResult = MrOk then
                  Exit; //EndApp
             end
         );
      End;
}
    LblConnection.Text := 'Server: '+IpHost+':'+PortHost;
    ConfigSqlLite; //https://www.youtube.com/watch?v=Ypr0NbL9Pb8
    DelayedSetFocus(EdtUsuario);
//Ativado na DrogaClara
    //if Brand_Collector = 'Honeywell' then Begin
       //SwtKeyboard.IsChecked := True;
       //VKAutoShowMode := TVKAutoShowMode.DefinedBySystem   // Always
    //End;
   {$IfDef Android}
      ksLoadingIndicator1.HideLoading;
   {$EndIf}
  Except
    DelayedSetFocus(EdtUsuario);
    {$IfDef Android}
       ksLoadingIndicator1.HideLoading;
    {$EndIf}
    MessageDlg('ERRO: conexão com servidor!!!', TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbOK], 0,
        procedure (const AResult: TModalResult)
        begin
          if AResult = MrOk then
             Exit; //EndApp
        end
    );
  End;
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
//  if Assigned(FrmeXactWMS) then
//     FrmeXactWMS := Nil;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  vPosLblUsuario := Label1.Position.Y;
  vPosLblSenha   := Label2.Position.Y;
  if DebugHook <> 0 then
     EdtSenha.Text := '2022'; //'rhemasys';
end;

procedure TFrmLogin.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFrmLogin.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TFrmLogin.LblCriarContaClick(Sender: TObject);
begin
  //MsgWhatsApp('Reenvio de senha');
end;

procedure TFrmLogin.LerXmlConfig;
Var xTexto : String;
begin
  {$IfDef Android}
    vArqConfig := TPath.GetDocumentsPath + PathDelim + 'wmsconfig.xml';
  {$Endif}
  {$IfDef MsWindows}
    vArqConfig := GetCurrentDir + '\wmsconfig.xml';
  {$EndIf}
  try
    XmlConfig  := TXMLDocument.Create(Nil);
    XmlConfig.LoadFromFile(vArqConfig);
    XmlConfig.Active  := True;
    vNode := XmlConfig.ChildNodes.FindNode('config');
    Instalation  := vNode.ChildValues['Instalacao'] = '1';
    vNodeChild   := vNode.ChildNodes['Company'];
    Company_Name := vNodeChild.ChildValues['Name'];
    vNodeChild   := vNode.ChildNodes.FindNode('Server');
    IpHost       := vNodeChild.ChildValues['Ip'];
    PortHost     := vNodeChild.ChildValues['Port'];
    vNodeChild   := vNode.ChildNodes.FindNode('Collector');
    Brand_Collector   := vNodeChild.ChildValues['Brand'];
    Scanner_Collector := vNodeChild.ChildValues['Scanner'] = '1';
    Teclado      := vNodeChild.ChildValues['Teclado'];
    //Configurar o RestClient
    DmClient.RESTClient1.BaseURL     := 'http://'+IpHost+':'+PortHost;
    DmeXactWMS.RESTClientWMS.BaseURL := 'http://'+IpHost+':'+PortHost;
    DmeXactWMS.ClientReport.BaseURL := 'http://'+IpHost+':'+PortHost;
    //FrmeXactWMS.BASEUrl              := 'http://'+IpHost+':'+PortHost;
    //Configurar Teclado Virtual
    SwtKeyboard.IsChecked := Teclado;
    if Teclado then
       VKAutoShowMode := TVKAutoShowMode.Always //(DefinedBySystem, Never, Always)
    Else VKAutoShowMode := TVKAutoShowMode.Never; //(DefinedBySystem, Never, Always)

//    if Assigned(XmlConfig) then
//       FreeAndNil(XmlConfig);
  except on E: Exception do
    ShowMessage(E.Message);
  End;
end;

procedure TFrmLogin.BtnCancelClick(Sender: TObject);
begin
  EdtEmpresa.text     := '';
  EdtIpServer.Text    := '';
  EdtPortServer.Text  := '';
  SwtLeitor.IsChecked := False;
  SwtKeyboardCfg.IsChecked := False;
  CbLeitor.ItemIndex := -1;
end;

procedure TFrmLogin.BtnSaveClick(Sender: TObject);
begin
  if (EdtEmpresa.Text='') or (EdtIpServer.Text='') or (EdtPortServer.Text='') or
     (CbLeitor.ItemIndex = -1) or ((SwtLeitor.IsChecked) and (CbLeitor.ItemIndex <=0)) then
     raise Exception.Create('Informações inválida!!!');
  Company_Name      := EdtEmpresa.Text;
  IpHost            := EdtIpServer.Text;
  PortHost          := EdtPortServer.Text;
  Brand_Collector   := CbLeitor.Items[0];
  Scanner_Collector := SwtLeitor.IsChecked;
  Teclado           := SwtKeyboardCfg.IsChecked;
  SbConfigClick(SbConfig);
  SwtKeyboard.IsChecked := Teclado;
  SaveXml;
end;

procedure TFrmLogin.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then begin
     ContentBounds.Bottom := Max(ContentBounds.Bottom,
                             2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFrmLogin.BtnLogInClick(Sender: TObject);
Var Arq, vErro     : String;
    JsonArrayLogOn : TJsonArray;
begin
  if (EdtUsuario.Text='') or (EdtSenha.Text='') then Begin
     MsgErroAlerta('Usuario ou Senha inválida!!!');
     Exit;
  End;
  ksLoadingIndicator1.ShowLoading;
  if Not Assigned(ObjUsuarioCtrl) then Exit;
  if ((EdtUsuario.Text = ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString()) or
      (EdtUsuario.Text = ObjUsuarioCtrl.ObjUsuario.Nome)) and (MD5Texto(EdtSenha.Text) = ObjUsuarioCtrl.ObjUsuario.Senha) then Begin
     Try
     if not Assigned(FrmeXactWMS) then
        Application.CreateForm(TFrmeXactWMS, FrmeXactWMS);
     Except On E: Exception do Begin
//        ksLoadingIndicator1.HideLoading;
        raise Exception.Create('Erro(01): '+E.Message);
        End;
     End;
     FrmeXactWMS.LblUsuario.Text := Copy(ObjUsuarioCtrl.ObjUsuario.Nome, 1, 20);
     FrmeXactWMS.LblUsuarioEmail.Text := 'Geral';//' Usuario.Perfil.Nome;
     //Definir as Variaveis de Configuração Lidas do WmsConfig.XML
     FrmeXactWMS.Instalation  := Instalation;
     FrmeXactWMS.Company_Name := Company_Name;
     FrmeXactWMS.IpHost       := IpHost;
     FrmeXactWMS.PortHost     := Porthost;
     FrmeXactWMS.BASEUrl      := IpHost;
     FrmeXactWMS.Brand_Collector   := Brand_Collector;
     FrmeXactWMS.Scanner_Collector := Scanner_Collector;
     FrmeXactWMS.Teclado           := Teclado;
     FrmeXactWMS.ObjUsuarioCtrl    := ObjUsuarioCtrl;
     ObjUsuarioCtrl := Nil;
     FrmeXactWMS.Show;
     Application.MainForm := FrmeXactWMS;
     JsonArrayLogOn := ObjUsuarioCtrl.LogOn; //Salvar o Log de LogOn no eXactWMS
     if Not JsonArrayLogOn.Items[0].TryGetValue('Erro', vErro) then  Begin
        FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.IdLogOn := JsonArrayLogOn.Items[0].getValue<Integer>('idlogon');
     End;
     JsonArrayLogOn := Nil;
     close;
     ksLoadingIndicator1.HideLoading;
     FrmLogin := Nil;
     Exit;
     End
   Else if Tentativas > 3 then Begin
      ksLoadingIndicator1.HideLoading;
      MsgErroAlerta('Seu acesso foi negado!!!');
      EndApp;
   End;
   MsgErroAlerta('Usuario ou Senha inválida!!!');
   EdtUsuario.Text := '';
   EdtSenha.Text   := '';
   Tentativas      := Tentativas + 1;
   ksLoadingIndicator1.HideLoading;
   DelayedSetFocus(EdtUsuario);
end;

procedure TFrmLogin.BtnLogInMouseEnter(Sender: TObject);
begin
  BtnLogin.Fill.Color   := TAlphaColorRec.Chocolate;
  BtnLogin.Stroke.Color := TAlphaColorRec.Null;
  LblLogin.FontColor    := TAlphaColorRec.White;
end;

procedure TFrmLogin.BtnLogInMouseLeave(Sender: TObject);
begin
  BtnLogin.Fill.Color   := TAlphaColorRec.Null;
  BtnLogin.Stroke.Color := TAlphaColorRec.Chocolate;
  LblLogin.FontColor    := TAlphaColorRec.Chocolate;
end;

procedure TFrmLogin.RestorePosition;
begin
  VSBConfig.ViewportPosition := PointF(VSBConfig.ViewportPosition.X, 0);
  LayoutBase.Align := TAlignLayout.Client;
  VSBConfig.RealignContent;
end;

procedure TFrmLogin.SaveXML;
Var vlXML : IXMLDocument;
   vlNode, vlCompany, VlServer, vlCollector : IXMLNode;
begin
  vlXML   := TXMLDocument.Create(nil);
  vlXML.NodeIndentStr := '    ';
  vlXML.Options := vlXML.Options + [doNodeAutoIndent];
  vlXML.Active   := True;
  vlXML.Version  := '1.0';
  vlXML.Encoding := 'UTF-8';
  vlNode := vlXML.AddChild('config');
  vlNode.ChildValues['Instalacao'] := 1;
  vlCompany := vlNode.AddChild('Company');
  vlCompany.ChildValues['Name'] := EdtEmpresa.Text;
  vlServer  := vlNode.AddChild('Server');
  VlServer.ChildValues['Ip']   := EdtIpServer.Text;
  VlServer.ChildValues['Port'] := EdtPortServer.Text;
  vlCollector  := vlNode.AddChild('Collector');
  vlCollector.ChildValues['Brand']   := CbLeitor.Items[CbLeitor.ItemIndex];
  if SwtLeitor.IsChecked then vlCollector.ChildValues['Scanner'] := 1
  Else vlCollector.ChildValues['Scanner'] := 0;
  if SwtKeyboardCfg.IsChecked then vlCollector.ChildValues['Teclado'] := 1
  else vlCollector.ChildValues['Teclado'] := 0;
  vlXML.SaveToFile(vArqConfig);
  DmClient.RESTClient1.BaseURL := 'http://'+IpHost+':'+PortHost; //+'/datasnap/rest/TdmServidor';
  DmeXactWMS.RESTClientWMS.BaseURL := 'http://'+IpHost+':'+PortHost;
  DmeXactWMS.ClientReport.BaseURL := 'http://'+IpHost+':'+PortHost;
  //FrmeXactWMS.BaseURL          := 'http://'+IpHost+':'+PortHost;
  LblConnection.Text := 'Server: '+IpHost+':'+PortHost;
end;

procedure TFrmLogin.SbConfigClick(Sender: TObject);
begin
  if PgcPrincipal.ActiveTab = TabDetalhes then Begin
     ChgTabLista.Execute;
     EdtEmpresa.Text := Company_Name;
     EdtIpServer.Text := IpHost;
     EdtPortServer.Text := PortHost;
     CbLeitor.ItemIndex := CbLeitor.Items.IndexOf(Brand_Collector);
     SwtLeitor.IsChecked := Scanner_Collector;
     CbLeitor.Enabled := SwtLeitor.IsChecked;
     SwtKeyboardCfg.IsChecked := Teclado;
     DelayEdSetFocus(EdtEmpresa)
  End
  Else Begin
    ChgTabDet.Execute;
    DelayedSetFocus(EdtUsuario);
  End;
end;

procedure TFrmLogin.SwtKeyboardClick(Sender: TObject);
begin
  if SwtKeyboard.IsChecked then
     VKAutoShowMode := TVKAutoShowMode.DefinedBySystem   // Always
  Else VKAutoShowMode := TVKAutoShowMode.Never;
  EdtUsuario.SetFocus;
end;

procedure TFrmLogin.SwtLeitorClick(Sender: TObject);
begin
  CbLeitor.Enabled := SwtLeitor.IsChecked;
  if Not SwtLeitor.IsChecked then CbLeitor.ItemIndex := 0;
end;

procedure TFrmLogin.ThreadLoginUsuarioTerminate(Sender: TObject);
begin
  ksLoadingIndicator1.HideLoading;
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then begin
        MsgErroAlerta(Exception(TThread(sender).FatalException).Message);
        EdtUsuario.Text := '';
        DelayedSetFocus(EdtUsuario);
        exit;
     end;
  end;
  //DelayEdSetFocus( EdtSenha );
end;

procedure TFrmLogin.UpdateKBBounds;
var LFocused   : TControl;
    LFocusRect : TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VSBConfig.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      LayoutBase.Align := TAlignLayout.Horizontal;
      VSBConfig.RealignContent;
      Application.ProcessMessages;
      VSBConfig.ViewportPosition := PointF(VSBConfig.ViewportPosition.X, LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
     RestorePosition;
end;

procedure TFrmLogin.ConfigSqlLite;
Var vArq : String;
begin
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
     //vArq := TPath.GetDocumentsPath + PathDelim + 'exactwms.db3';
     vArq := TPath.Combine(TPath.GetDocumentsPath, 'exactwms.db3');
  {$Endif}
  {$IfDef MSWINDOWS}
     vArq := GetCurrentDir+'\Dados\exactwms.Db3';
  {$Endif}
  if not FileExists(vArq) then Begin
     MessageDlg('Arquivo SqLite('+vArq+') não encontrado', TMsgDlgType.mtWarning,[TMsgDlgBtn.MbOk], 0,
      procedure (const AResult: TModalResult)
      begin
        //if AResult = MrYes then
           EndApp;
      end
  );
  End;
  Try
    dmeXactWMS.FdWmsSqlLite.Params.Values['DataBase'] := vArq;
    dmeXactWMS.FdWmsSqlLite.Open();
  Except
    raise Exception.Create('Erro de conexão com o Banco de Dados Local.');
  End;
end;

procedure TFrmLogin.DelayedSetFocus(control : TControl);
begin
//https://stackoverflow.com/questions/36713878/delphi-fmx-set-focus-to-a-particular-control-so-the-cursor-appears
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize( nil,
         procedure
         begin
           control.SetFocus;
         end
      );
    end
  ).Start;
end;

Procedure TFrmLogin.EndApp;
Begin
  FreeAndNil(FrmLogin);
  FrmLogin.DisposeOf;
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
     TAndroidHelper.Activity.Finish;
  {$Else}
     Application.Terminate;
  {$Endif}
End;

Procedure TFrmLogin.MsgErroAlerta(pMensagem : String);
Begin
   TThread.CreateAnonymousThread(procedure begin
     TThread.Synchronize(nil, procedure
     begin
       if MPlayer.State = TMediaState.Playing then MPlayer.Stop;
       MPlayer.Clear;
       {$IFDEF ANDROID}
          MPlayer.FileName := TPath.Combine(TPath.GetDocumentsPath, 'notfound.wav');
       {$Endif}
       {$IfDef MSWINDOWS}
          MPlayer.FileName := GetCurrentDir+'\sound\notfound.wav';
       {$ENDIF}
//       if MPlayer.Media <> nil then
       MPlayer.Play;
     End);
   end).Start;
   TLoading.Hide;
   TLoading.ToastMessage(Self, pMensagem, TAlignLayout.top, CorToastErro);
End;

end.


