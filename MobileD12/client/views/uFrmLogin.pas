unit uFrmLogin;
// http://www.theclub.com.br/Restrito/Revistas/201405/delp1405.aspx
// Impressao de Pedidos
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  uMyTabOrderClassHelper,
  // Data.DbxJsonReflect,
  FMX.VirtualKeyboard, FMX.Effects, FMX.Objects, System.Math, Rest.Json,
  Rest.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, System.Json,
  System.IOUtils,
{$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
{$ENDIF}
{$IFDEF IOS}
  Macapi.Helpers,
{$ENDIF IOS}
  FMX.Edit, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, FMX.ScrollBox,
  FMX.Ani, FMX.ListBox, ksTypes, ksLoadingIndicator, FMX.Filter.Effects,
  FMX.Media, Notificacao, ConfiguracaoClass, UsuarioClass, UsuarioCtrl,
  FMX.ActnList, System.Actions, FMX.TabControl, U_MsgD, System.ImageList,
  FMX.ImgList;
type
  TFrmLogin = class(TForm)
    layoutBase: TLayout;
    PgcPrincipal: TTabControl;
    TabConfig: TTabItem;
    ActionList1: TActionList;
    ChgTabDet: TChangeTabAction;
    ChgTabLista: TChangeTabAction;
    Ac_Ok: TAction;
    TabDetalhes: TTabItem;
    layoutTop: TLayout;
    layoutRodape: TLayout;
    layoutInfobar: TLayout;
    Layout5: TLayout;
    VSBConfig: TVertScrollBox;
    RctConfig: TRectangle;
    Código: TLabel;
    EdtEmpresa: TEdit;
    Lnempresa: TLine;
    EdtIpServer: TEdit;
    LblIpServer: TLabel;
    EdtPortServer: TEdit;
    Label4: TLabel;
    CbLeitor: TComboBox;
    Label5: TLabel;
    LblSwtLeitor: TLabel;
    SwtLeitor: TSwitch;
    Label6: TLabel;
    SwtKeyboardCfg: TSwitch;
    Layout3: TLayout;
    BtnSave: TSpeedButton;
    PthSave: FMX.Objects.TPath;
    Label8: TLabel;
    BtnCancel: TSpeedButton;
    Path3: FMX.Objects.TPath;
    Label9: TLabel;
    MPlayer: TMediaPlayer;
    layoutLoginBody: TLayout;
    ActAtualizaAPP: TAction;
    ActNaoAtualizaAPP: TAction;
    rectTop: TRectangle;
    rectRodape: TRectangle;
    lblExactMobile: TLabel;
    logoTipoExact: TCircle;
    sombraLogo: TShadowEffect;
    sombraMobile: TShadowEffect;
    loginStyle: TStyleBook;
    ImageList1: TImageList;
    layoutConta: TLayout;
    layoutLogin: TLayout;
    SignInBackgroundRect: TRectangle;
    sombraLogin: TShadowEffect;
    LblUsuario: TLabel;
    FloatAnimation1: TFloatAnimation;
    layoutBoasVindas: TLayout;
    EdtSenha: TEdit;
    FillRGBEffect2: TFillRGBEffect;
    Line2: TLine;
    EdtUsuario: TEdit;
    FillRGBEffect1: TFillRGBEffect;
    Line1: TLine;
    Image1: TImage;
    Image2: TImage;
    BackgroundImage: TImage;
    BackgroundGaussianBlurEffect: TGaussianBlurEffect;
    BtnLogIn: TRectangle;
    LblLogin: TLabel;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    Circle1: TCircle;
    ShadowEffect6: TShadowEffect;
    rectLabelsTeclado: TRectangle;
    LblCriarConta: TLabel;
    Label1: TLabel;
    SwtKeyboard: TSwitch;
    lbwelcome1: TLabel;
    animwelcome: TFloatAnimation;
    sombraWelcomeLabel: TShadowEffect;
    GlowEffect1: TGlowEffect;
    labelExactDetail: TLabel;
    sombraDetalhes: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    Rectangle1: TRectangle;
    LblVersao: TLabel;
    Z: TImage;
    aninlogo: TFloatAnimation;
    lablRes: TLabel;
    SbConfig: TImage;
    flarotatiologo: TFloatAnimation;
    LblConnection: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
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
    procedure EdtPortServerKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
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
    procedure LblCriarContaClick(Sender: TObject);
    procedure EdtUsuarioChangeTracking(Sender: TObject);
    procedure SignInBackgroundRectResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SbConfigClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
    Tentativas: Single;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    // Configuração no Arquivo XML
    vArqConfig: String;
    XmlConfig: IXMLDocument;
    vNode, vNodeChild: IXMLNode;
    Instalation: Boolean;
    Company_Name: String;
    IpHost, PortHost: String;
    Brand_Collector: String;
    Scanner_Collector, Teclado: Boolean;
    // Scanner_Collector indica se o Leitor de CB precisa ser ativado pelo App
    ObjUsuarioCtrl: TUsuarioCtrl;
    vPosLblUsuario, vPosLblSenha: Single;
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

Var
  FrmLogin: TFrmLogin;
  LoginLigado, SenhaLigado: Boolean;
  MsgD: TMsgD;

implementation
{$R *.fmx}
uses uFrmeXactWMS, uDmClient, uRetorno, uFuncoes, uDmeXactWMS;

procedure TFrmLogin.EdtPortServerKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  SoNumeros(KeyChar);
end;
procedure TFrmLogin.EdtSenhaChangeTracking(Sender: TObject);
begin
  if (EdtSenha.Text.Length > 0) and (SenhaLigado = false) then
  begin
    SenhaLigado := true;
  end
  else if EdtSenha.Text.Length = 0 then
  begin
    SenhaLigado := false;
  end;
end;

procedure TFrmLogin.EdtEmpresaChangeTracking(Sender: TObject);
begin
  //EdtEmpresa.Text := Capitalizar(EdtEmpresa.Text);
end;

procedure TFrmLogin.EdtUsuarioChangeTracking(Sender: TObject);
begin
  if (EdtUsuario.Text.Length > 0) and (LoginLigado = false) then
  begin
    LoginLigado := true;
  end
  else if EdtUsuario.Text.Length = 0 then
  begin
    LoginLigado := false;
  end;
end;

procedure TFrmLogin.EdtUsuarioEnter(Sender: TObject);
begin
  // LBlActKeyboard.Text := 'H='+Height.ToString()+'  W='+Width.ToString();
end;

procedure TFrmLogin.EdtUsuarioKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$IF defined(Android)}
var
  i: JIntent;
{$ENDIF}
begin
  If (Key in [9, 13]) or (KeyChar = #13) then
  Begin // and (TEdit(Sender).Text<>'') then Begin
    If (Sender = EdtUsuario) and (EdtUsuario.Text <> '') then
      DelayedSetFocus(EdtSenha)
    Else If (Sender = EdtSenha) and (EdtSenha.Text <> '') then
      BtnLogInClick(BtnLogIn);
    // Key := 0;
  End
  Else if Key = vkEscape then
    EndApp;
End;

procedure TFrmLogin.EdtUsuarioTyping(Sender: TObject);
begin
  LblUsuario.Text := '...';
end;

procedure TFrmLogin.EdtUsuarioValidate(Sender: TObject; var Text: string);
Var
  vErro: String;
  TH: TThread;
begin
  If EdtUsuario.Text = '' then
    Exit;
  if StrToIntDef(EdtUsuario.Text, 0) = 0 then
  Begin
    MsgErroAlerta('Id de usuário inválido!');
    DelayedSetFocus(EdtUsuario);
    Text := '';
  End;
  TH := TThread.CreateAnonymousThread(
    procedure
    Var
      jArray: TJsonArray;
    begin
      DmClient.RESTRequest1.ResetToDefaults;
      DmClient.RESTResponse1.ResetToDefaults;
      DmClient.ResetREST;
      DmClient.RESTRequest1.Resource := 'v1/usuario/{usuarioid}';
      DmClient.RESTRequest1.Params.AddUrlSegment('usuarioid', EdtUsuario.Text);
      DmClient.RESTRequest1.Method := TRESTRequestMethod.RmGet;
      DmClient.RESTRequest1.Execute;
      if DmClient.RESTResponse1.StatusCode in [200, 201] then Begin
         jArray := DmClient.RESTResponse1.JSONValue as TJsonArray;
         if (jArray.Count < 1) or (jArray.Items[0].TryGetValue<String>('Erro', vErro)) then Begin
            DelayedSetFocus(EdtUsuario);
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                EdtUsuario.Text := '';
                MsgErroAlerta('Usuário Inválido!!!');
              End);
            jArray := Nil;
            Exit;
         End;
         if (jArray.Items[0].GetValue<Integer>('status', 0) = 0) then Begin
            DelayedSetFocus(EdtUsuario);
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                EdtUsuario.Text := '';
                MsgErroAlerta('Usuário inativo!!!');
              End);
            jArray := Nil;
            Exit;
         End;

         If Not Assigned(ObjUsuarioCtrl) then
           ObjUsuarioCtrl := TUsuarioCtrl.Create();
         ObjUsuarioCtrl.ObjUsuario := TJson.JsonToObject<TUsuario>(jArray.Items[0].GetValue<TJsonObject>.ToString(), [joDateFormatUnix]);
         ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId := jArray.Items[0].GetValue<Integer>('perfilid');
         ObjUsuarioCtrl.ObjUsuario.Perfil.Descricao := jArray.Items[0].GetValue<String>('descricao');
         ObjUsuarioCtrl.ObjUsuario.Perfil.Status := jArray.Items[0].GetValue<Integer>('statusperfil');
         ObjUsuarioCtrl.ObjUsuario.Perfil.Data := StrToDate(jArray.Items[0].GetValue<String>('data'));
         if jArray.Items[0].GetValue<String>('hora') <> '' then
            ObjUsuarioCtrl.ObjUsuario.Perfil.Hora := StrToTime(Copy(jArray.Items[0].GetValue<String>('hora'), 1, 8));
         if ObjUsuarioCtrl.ObjUsuario.usuarioid = 0 then Begin
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                EdtUsuario.Text := '';
                MsgErroAlerta('Usuário Inválido!!!');
              End);
            DelayedSetFocus(EdtUsuario);
            jArray := Nil;
            Exit;
         End
         Else if ObjUsuarioCtrl.ObjUsuario.Status = 2 then Begin
           TThread.Synchronize(TThread.CurrentThread,
             procedure
             begin
               EdtUsuario.Text := '';
               MsgErroAlerta('Usuário com acesso desativado!!!');
             End);
           DelayedSetFocus(EdtUsuario);
           jArray := Nil;
           Exit;
         End;
         TThread.Synchronize(TThread.CurrentThread,
           procedure
           begin
             LblUsuario.Text := ObjUsuarioCtrl.ObjUsuario.Nome;
           End);
      End
      Else
      Begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            LblUsuario.Text := 'ERRO(' + DmClient.RESTResponse1.StatusCode.
              ToString() + ') ' + ReturnREST(DmClient.RESTResponse1.StatusCode);
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
Var
  vArq, ArqSom: String;
begin
  LoginLigado := false;
  SenhaLigado := false;
{$IFDEF Android}
{$ENDIF}
  Application.ProcessMessages;
  lablRes.Text := 'Screen Size : Height ' + inttostr(Height) + ' - Width ' +
    inttostr(Width);
  PgcPrincipal.ActiveTab := TabDetalhes;
  VSBConfig.Visible := true;
  // Tratar se o arquivo Exist
{$IFDEF Android}
  vArq := TPath.Combine(TPath.GetDocumentsPath, 'eXactWmsMobile.exe');
  LblVersao.Text := 'App Version: ' + VersaoAPK;
{$ENDIF}
{$IFDEF MSWINDOWS}
  vArq := GetCurrentDir + '\eXactWmsMobile.exe';
  LblVersao.Text := 'Versão: ' + Versao('eXactWmsMobile.exe');
{$ENDIF}
  // if FileExists(vArq) then
  // LblVersao.Text   := 'App Version: '+VersaoAPK //Versao('eXactWmsMobile.exe')
  // Else lblVersao.Text := 'App Version: Undefined';
  Tentativas := 1;
  // https://www.devmedia.com.br/conectando-bases-de-dados-no-android-ios-e-windows-pelo-delphi/36901
  // Delphi 10.3.3 abaixo
  // https://docwiki.embarcadero.com/RADStudio/Sydney/en/Mobile_Tutorial:_Using_FireDAC_and_SQLite_(iOS_and_Android)
  Try
{$IFDEF Android}
    // vArq := System.IOUtils.TPath.GetDocumentsPath + PathDelim + 'wmsconfig.xml';
    // vArqConfig := TPath.GetDocumentsPath + PathDelim + 'wmsconfig.xml';
    vArq := TPath.Combine(TPath.GetDocumentsPath, 'wmsconfig.xml');
{$ENDIF}
{$IFDEF MSWINDOWS}
    // vArq := GetCurrentDir;
    vArq := GetCurrentDir + '\wmsconfig.xml';
{$ENDIF}
    if not FileExists(vArq) then
    Begin
{$IFDEF Android}
{$ENDIF}
      MessageDlg('Arquivo Configuração(' + vArq + ') não encontrado',
        TMsgDlgType.mtWarning, [TMsgDlgBtn.MbOk], 0,
        procedure(const AResult: TModalResult)
        begin
          // if AResult = MrYes then
{$IFDEF Android}
{$ENDIF}
          EndApp;
        end);
    End
    Else
    Begin
      LerXmlConfig;
    end;
  Except
    ON E: Exception do
    Begin
      MessageDlg('ERRO: aqui! ' + E.Message, TMsgDlgType.mtConfirmation,
        [TMsgDlgBtn.MbOk], 0,
        procedure(const AResult: TModalResult)
        begin
          if AResult = MrOk then
            Exit; // EndApp
        end);
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
    LblConnection.Text := 'Server: ' + IpHost + ':' + PortHost;
    ConfigSqlLite; // https://www.youtube.com/watch?v=Ypr0NbL9Pb8
    DelayedSetFocus(EdtUsuario);
    // Ativado na DrogaClara
    // if Brand_Collector = 'Honeywell' then Begin
    // SwtKeyboard.IsChecked := True;
    // VKAutoShowMode := TVKAutoShowMode.DefinedBySystem   // Always
    // End;
{$IFDEF Android}
{$ENDIF}
  Except
    DelayedSetFocus(EdtUsuario);
{$IFDEF Android}
{$ENDIF}
    MessageDlg('ERRO: conexão com servidor!!!', TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.MbOk], 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult = MrOk then
          Exit; // EndApp
      end);
  End;
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  // if Assigned(FrmeXactWMS) then
  // FrmeXactWMS := Nil;
end;

procedure TFrmLogin.FormResize(Sender: TObject);
begin
  layoutBoasVindas.Visible := Height > 420;
  layoutConta.Visible := Height > 420;
  layoutRodape.Visible := Height > 420;
  layoutTop.Visible := Height > 420;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  if DebugHook <> 0 then
    EdtSenha.Text := '2022'; // 'rhemasys';
  animwelcome.Start;
end;

procedure TFrmLogin.FormVirtualKeyboardHidden(Sender: TObject;
KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := false;
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

procedure TFrmLogin.SbConfigClick(Sender: TObject);
begin
  if PgcPrincipal.ActiveTab = TabDetalhes then
  Begin
    ChgTabLista.Execute;
    EdtEmpresa.Text := Company_Name;
    EdtIpServer.Text := IpHost;
    EdtPortServer.Text := PortHost;
    CbLeitor.ItemIndex := CbLeitor.Items.IndexOf(Brand_Collector);
    SwtLeitor.IsChecked := Scanner_Collector;
    CbLeitor.Enabled := SwtLeitor.IsChecked;
    SwtKeyboardCfg.IsChecked := Teclado;
    DelayedSetFocus(EdtEmpresa)
  End
  Else
  Begin
    ChgTabDet.Execute;
    DelayedSetFocus(EdtUsuario);
  End;
end;

procedure TFrmLogin.Label2Click(Sender: TObject);
var
  x: string;
begin
  x := TLabel(Sender).TextSettings.Font.Family;
  ShowMessage(x)
end;

procedure TFrmLogin.LblCriarContaClick(Sender: TObject);
begin
  MsgWhatsApp('Reenvio de senha');
end;

procedure TFrmLogin.LerXmlConfig;
Var xTexto: String;
    {$IFDEF Android}
      //KeyboardService: IFMXVirtualKeyboardService;
    {$ENDIF}
begin
{$IFDEF Android}
  vArqConfig := TPath.GetDocumentsPath + PathDelim + 'wmsconfig.xml';
{$ENDIF}
{$IFDEF MsWindows}
  vArqConfig := GetCurrentDir + '\wmsconfig.xml';
{$ENDIF}
  try
    XmlConfig := TXMLDocument.Create(Nil);
    XmlConfig.LoadFromFile(vArqConfig);
    XmlConfig.Active := true;
    vNode := XmlConfig.ChildNodes.FindNode('config');
    Instalation := vNode.ChildValues['Instalacao'] = '1';
    vNodeChild := vNode.ChildNodes['Company'];
    Company_Name := vNodeChild.ChildValues['Name'];
    vNodeChild := vNode.ChildNodes.FindNode('Server');
    IpHost := vNodeChild.ChildValues['Ip'];
    PortHost := vNodeChild.ChildValues['Port'];
    vNodeChild := vNode.ChildNodes.FindNode('Collector');
    Brand_Collector := vNodeChild.ChildValues['Brand'];
    Scanner_Collector := vNodeChild.ChildValues['Scanner'] = '1';
    Teclado := vNodeChild.ChildValues['Teclado'];
    // Configurar o RestClient
    DmClient.RESTClient1.BaseURL := 'http://' + IpHost + ':' + PortHost;
    DmeXactWMS.RESTClientWMS.BaseURL := 'http://' + IpHost + ':' + PortHost;
    DmeXactWMS.ClientReport.BaseURL := 'http://' + IpHost + ':' + PortHost;
    // FrmeXactWMS.BASEUrl              := 'http://'+IpHost+':'+PortHost;
    // Configurar Teclado Virtual
    SwtKeyboard.IsChecked := Teclado;
    if Teclado then
      VKAutoShowMode := TVKAutoShowMode.Always
      // (DefinedBySystem, Never, Always)
    Else Begin
      VKAutoShowMode := TVKAutoShowMode.Never;
      {$IFDEF Android}
         //KeyboardService.HideVirtualKeyboard;
      {$Endif}
    End
    // if Assigned(XmlConfig) then
    // FreeAndNil(XmlConfig);
  except
    on E: Exception do
      ShowMessage(E.Message);
  End;
end;

procedure TFrmLogin.BtnCancelClick(Sender: TObject);
begin
  EdtEmpresa.Text := '';
  EdtIpServer.Text := '';
  EdtPortServer.Text := '';
  SwtLeitor.IsChecked := false;
  SwtKeyboardCfg.IsChecked := false;
  CbLeitor.ItemIndex := -1;
end;

procedure TFrmLogin.BtnSaveClick(Sender: TObject);
begin
  if (EdtEmpresa.Text = '') or (EdtIpServer.Text = '') or
    (EdtPortServer.Text = '') or (CbLeitor.ItemIndex = -1) or
    ((SwtLeitor.IsChecked) and (CbLeitor.ItemIndex <= 0)) then
    raise Exception.Create('Informações inválida!!!');
  Company_Name := EdtEmpresa.Text;
  IpHost := EdtIpServer.Text;
  PortHost := EdtPortServer.Text;
  Brand_Collector := CbLeitor.Items[0];
  Scanner_Collector := SwtLeitor.IsChecked;
  Teclado := SwtKeyboardCfg.IsChecked;
  SbConfigClick(SbConfig);
  SwtKeyboard.IsChecked := Teclado;
  SaveXML;
end;

procedure TFrmLogin.CalcContentBoundsProc(Sender: TObject;
var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
      2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFrmLogin.BtnLogInClick(Sender: TObject);
Var
  Arq, vErro: String;
  JsonArrayLogOn: TJsonArray;
begin
  if (EdtUsuario.Text = '') or (EdtSenha.Text = '') then
  Begin
    MsgErroAlerta('Usuario ou Senha inválida!!!');
    Exit;
  End;
  if Not Assigned(ObjUsuarioCtrl) then
    Exit;
  if ((EdtUsuario.Text = ObjUsuarioCtrl.ObjUsuario.usuarioid.ToString()) or
    (EdtUsuario.Text = ObjUsuarioCtrl.ObjUsuario.Nome)) and
    (MD5Texto(EdtSenha.Text) = ObjUsuarioCtrl.ObjUsuario.Senha) then
  Begin
    Try
      if not Assigned(FrmeXactWMS) then
        Application.CreateForm(TFrmeXactWMS, FrmeXactWMS);
    Except
      On E: Exception do
      Begin
        // ksLoadingIndicator1.HideLoading;
        raise Exception.Create('Erro(01): ' + E.Message);
      End;
    End;
    FrmeXactWMS.LblUsuario.Text := Copy(ObjUsuarioCtrl.ObjUsuario.Nome, 1, 20);
    FrmeXactWMS.LblUsuarioEmail.Text := 'Geral'; // ' Usuario.Perfil.Nome;
    // Definir as Variaveis de Configuração Lidas do WmsConfig.XML
    FrmeXactWMS.Instalation := Instalation;
    FrmeXactWMS.Company_Name := Company_Name;
    FrmeXactWMS.IpHost := IpHost;
    FrmeXactWMS.PortHost := PortHost;
    FrmeXactWMS.BaseURL := IpHost;
    FrmeXactWMS.Brand_Collector := Brand_Collector;
    FrmeXactWMS.Scanner_Collector := Scanner_Collector;
    FrmeXactWMS.Teclado := Teclado;
    FrmeXactWMS.ObjUsuarioCtrl := ObjUsuarioCtrl;
    ObjUsuarioCtrl := Nil;
    FrmeXactWMS.Show;
    Application.MainForm := FrmeXactWMS;
    JsonArrayLogOn := ObjUsuarioCtrl.LogOn; // Salvar o Log de LogOn no eXactWMS
    if Not JsonArrayLogOn.Items[0].TryGetValue('Erro', vErro) then
    Begin
      FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.IdLogOn := JsonArrayLogOn.Items[0]
        .GetValue<Integer>('idlogon');
    End;
    JsonArrayLogOn := Nil;
    close;
    FrmLogin := Nil;
    Exit;
  End
  Else if Tentativas > 3 then
  Begin
    MsgErroAlerta('Seu acesso foi negado!!!');
    EndApp;
  End;
  MsgErroAlerta('Usuario ou Senha inválida!!!');
  EdtUsuario.Text := '';
  EdtSenha.Text := '';
  Tentativas := Tentativas + 1;
  DelayedSetFocus(EdtUsuario);
end;

procedure TFrmLogin.BtnLogInMouseEnter(Sender: TObject);
begin
  BtnLogIn.Fill.Color := TAlphaColorRec.Chocolate;
  BtnLogIn.Stroke.Color := TAlphaColorRec.Null;
  LblLogin.FontColor := TAlphaColorRec.White;
end;

procedure TFrmLogin.BtnLogInMouseLeave(Sender: TObject);
begin
  BtnLogIn.Fill.Color := TAlphaColorRec.Null;
  BtnLogIn.Stroke.Color := TAlphaColorRec.Chocolate;
  LblLogin.FontColor := TAlphaColorRec.Chocolate;
end;

procedure TFrmLogin.RestorePosition;
begin
  VSBConfig.ViewportPosition := PointF(VSBConfig.ViewportPosition.x, 0);
  layoutBase.Align := TAlignLayout.Client;
  VSBConfig.RealignContent;
end;

procedure TFrmLogin.SaveXML;
Var
  vlXML: IXMLDocument;
  vlNode, vlCompany, VlServer, vlCollector: IXMLNode;
begin
  vlXML := TXMLDocument.Create(nil);
  vlXML.NodeIndentStr := '    ';
  vlXML.Options := vlXML.Options + [doNodeAutoIndent];
  vlXML.Active := true;
  vlXML.Version := '1.0';
  vlXML.Encoding := 'UTF-8';
  vlNode := vlXML.AddChild('config');
  vlNode.ChildValues['Instalacao'] := 1;
  vlCompany := vlNode.AddChild('Company');
  vlCompany.ChildValues['Name'] := EdtEmpresa.Text;
  VlServer := vlNode.AddChild('Server');
  VlServer.ChildValues['Ip'] := EdtIpServer.Text;
  VlServer.ChildValues['Port'] := EdtPortServer.Text;
  vlCollector := vlNode.AddChild('Collector');
  vlCollector.ChildValues['Brand'] := CbLeitor.Items[CbLeitor.ItemIndex];
  if SwtLeitor.IsChecked then
    vlCollector.ChildValues['Scanner'] := 1
  Else
    vlCollector.ChildValues['Scanner'] := 0;
  if SwtKeyboardCfg.IsChecked then
    vlCollector.ChildValues['Teclado'] := 1
  else
    vlCollector.ChildValues['Teclado'] := 0;
  vlXML.SaveToFile(vArqConfig);
  DmClient.RESTClient1.BaseURL := 'http://' + IpHost + ':' + PortHost;
  // +'/datasnap/rest/TdmServidor';
  DmeXactWMS.RESTClientWMS.BaseURL := 'http://' + IpHost + ':' + PortHost;
  DmeXactWMS.ClientReport.BaseURL := 'http://' + IpHost + ':' + PortHost;
  // FrmeXactWMS.BaseURL          := 'http://'+IpHost+':'+PortHost;
  LblConnection.Text := 'Server: ' + IpHost + ':' + PortHost;
end;

procedure TFrmLogin.SignInBackgroundRectResize(Sender: TObject);
begin
  if TRectangle(Sender).Width > 275 then
    TRectangle(Sender).Width := 275;
  if TRectangle(Sender).Height > 225 then
    TRectangle(Sender).Height := 225;
end;

procedure TFrmLogin.SwtKeyboardClick(Sender: TObject);
    {$IFDEF Android}
      //Var KeyboardService: IFMXVirtualKeyboardService;
    {$ENDIF}
begin
  if SwtKeyboard.IsChecked then
    VKAutoShowMode := TVKAutoShowMode.DefinedBySystem // Always
  Else Begin
    VKAutoShowMode := TVKAutoShowMode.Never;
    {$IFDEF Android}
       //KeyboardService.hideVirtualKeyBoard;
    {$ENDIF}
  End;
  EdtUsuario.SetFocus;
end;

procedure TFrmLogin.SwtLeitorClick(Sender: TObject);
begin
  CbLeitor.Enabled := SwtLeitor.IsChecked;
  if Not SwtLeitor.IsChecked then
    CbLeitor.ItemIndex := 0;
end;

procedure TFrmLogin.ThreadLoginUsuarioTerminate(Sender: TObject);
begin
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      MsgErroAlerta(Exception(TThread(Sender).FatalException).Message);
      EdtUsuario.Text := '';
      DelayedSetFocus(EdtUsuario);
      Exit;
    end;
  end;
  // DelayEdSetFocus( EdtSenha );
end;

procedure TFrmLogin.UpdateKBBounds;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  { FNeedOffset := false;
    if Assigned(Focused) then
    begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VSBConfig.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
    (LFocusRect.Bottom > FKBBounds.Top) then
    begin
    FNeedOffset := true;
    layoutBase.Align := TAlignLayout.Horizontal;
    VSBConfig.RealignContent;
    Application.ProcessMessages;
    VSBConfig.ViewportPosition := PointF(VSBConfig.ViewportPosition.X,
    LFocusRect.Bottom - FKBBounds.Top);
    end;
    end;
    if not FNeedOffset then
    RestorePosition; }
end;

procedure TFrmLogin.ConfigSqlLite;
Var vArq: String;
begin
{$IFDEF ANDROID} // or  {$IFDEF IOS}
  // vArq := TPath.GetDocumentsPath + PathDelim + 'exactwms.db3';
  vArq := TPath.Combine(TPath.GetDocumentsPath, 'exactwms.db3');
{$ENDIF}
{$IFDEF MSWINDOWS}
  vArq := GetCurrentDir + '\Dados\exactwms.Db3';
{$ENDIF}
  if not FileExists(vArq) then
  Begin
    MessageDlg('Arquivo SqLite(' + vArq + ') não encontrado',
      TMsgDlgType.mtWarning, [TMsgDlgBtn.MbOk], 0,
      procedure(const AResult: TModalResult)
      begin
        // if AResult = MrYes then
        EndApp;
      end);
  End;
  Try
    DmeXactWMS.FdWmsSqlLite.Params.Values['DataBase'] := vArq;
    DmeXactWMS.FdWmsSqlLite.Open();
  Except
    raise Exception.Create('Erro de conexão com o Banco de Dados Local.');
  End;
end;

procedure TFrmLogin.DelayedSetFocus(control: TControl);
begin
  // https://stackoverflow.com/questions/36713878/delphi-fmx-set-focus-to-a-particular-control-so-the-cursor-appears
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          control.SetFocus;
        end);
    end).Start;
end;

Procedure TFrmLogin.EndApp;
Begin
  FreeAndNil(FrmLogin);
  FrmLogin.DisposeOf;
{$IFDEF ANDROID} // or  {$IFDEF IOS}
  TAndroidHelper.Activity.Finish;
{$ELSE}
  Application.Terminate;
{$ENDIF}
End;

Procedure TFrmLogin.MsgErroAlerta(pMensagem: String);
Begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          if MPlayer.State = TMediaState.Playing then
            MPlayer.Stop;
          MPlayer.Clear;
{$IFDEF ANDROID}
          MPlayer.FileName := TPath.Combine(TPath.GetDocumentsPath,
            'notfound.wav');
{$ENDIF}
{$IFDEF MSWINDOWS}
          MPlayer.FileName := GetCurrentDir + '\sound\notfound.wav';
{$ENDIF}
          // if MPlayer.Media <> nil then
          MPlayer.Play;
        End);
    end).Start;
  TLoading.Hide;
  TLoading.ToastMessage(Self, pMensagem, TAlignLayout.Top, CorToastErro);
End;

end.
