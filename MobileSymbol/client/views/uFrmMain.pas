unit uFrmMain;

interface

uses
  IdUri,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, Rest.Json, System.Json, Rest.Types,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Ani, System.Actions,
  FMX.VirtualKeyboard, FMX.Platform, FireDAC.Comp.Client, uFrmBase, System.IOUtils,
  System.Permissions,
  {$IFDEF ANDROID}

  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI.Telephony, //Sms
  FMX.Helpers.Android,
  FMX.Platform.Android,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os, //Receber Intent
  {$Endif}
  {$IFDEF MSWINDOWS}
    Winapi.ShellAPI, Winapi.Windows,
  {$ENDIF MSWINDOWS}

  {$IFDEF IOS}
      Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS
  {$ENDIF IOS}
  FMX.MultiView, FMX.ScrollBox, FMX.Memo, FMX.Edit, System.Notification, FMX.Objects,
  FMX.ActnList,

  uFrmLogin, uFrmCaixa, uFrmEstoque, uFrmProduto, uFrmCarga, uFrmSeparacaoColetor, uTUsuario,
  uFrmControleArmazenagem, uFrmSaidaConsulta, uFrmAtualizadorApp, uFuncoes, U_MsgD, uFrmInventario,
  FMX.Media, ksTypes, ksLoadingIndicator, uFrmExpedicao,
  MobilePermissions.Model.Signature, MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard, MobilePermissions.Component
  , ConfiguracaoClass;

  //  ContactsManager

Const
  CorToastAlerta       = $FFC6DA16;
  CorToastErro         = $FFBD1919;
  CorToastInformação   = $FF2270AF;
  CorToastSucesso      = $FF22AF70;

type

  TFrmMain = class(TForm)
    LytMain: TLayout;
    Timer1: TTimer;
    AnimateDrawer: TFloatAnimation;
    Memo1: TMemo;
    Edit1: TEdit;
    NotificationCenter1: TNotificationCenter;
    LytBackground: TLayout;
    LblHeader: TLabel;
    MultiView1: TMultiView;
    RctDetUsuario: TRectangle;
    Circle1: TCircle;
    LblUsuario: TLabel;
    RctMnPrincipal: TRectangle;
    VertScrollBox1: TVertScrollBox;
    RctMnProdutos: TRectangle;
    Image3: TImage;
    LblMnProdutos: TLabel;
    RctMnCaixas: TRectangle;
    Image4: TImage;
    LblMnCaixas: TLabel;
    RctMnCargas: TRectangle;
    Image5: TImage;
    LblMnCargas: TLabel;
    RctMnMovimentacao: TRectangle;
    Image6: TImage;
    LblMnMovimentacao: TLabel;
    RctMnEntrada: TRectangle;
    Image7: TImage;
    LblMnEntrada: TLabel;
    RctMnEstoque: TRectangle;
    Image8: TImage;
    LblMnEstoque: TLabel;
    RctMnInventario: TRectangle;
    Image9: TImage;
    LblMnInventario: TLabel;
    RctMnSaida: TRectangle;
    Image10: TImage;
    LblMnSaidas: TLabel;
    RctMnSeparacao: TRectangle;
    Image11: TImage;
    lblMnSeparacao: TLabel;
    LblUsuarioEmail: TLabel;
    LytTop: TLayout;
    Rectangle1: TRectangle;
    LblDateTime: TLabel;
    RctMenu: TRectangle;
    RecBackground: TRectangle;
    RctMnSair: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    LblVersao: TLabel;
    LytFootUser: TLayout;
    LytRodape: TLayout;
    Rectangle2: TRectangle;
    ActionList1: TActionList;
    Ac_Finalizar: TAction;
    Ac_Cancel: TAction;
    RctAtualizador: TRectangle;
    Image2: TImage;
    LblAtualizador: TLabel;
    FloatAnimation2: TFloatAnimation;
    LblF2Menu: TLabel;
    MediaPlayer: TMediaPlayer;
    RctReconferencia: TRectangle;
    Image12: TImage;
    Label2: TLabel;
    ksLoadingIndicator1: TksLoadingIndicator;
    RctMnExpedicao: TRectangle;
    Image13: TImage;
    Label3: TLabel;
    MobilePermissions1: TMobilePermissions;
    RctLogoRS: TRectangle;
    LblDeviceId: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure LstCargosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
//      Shift: TShiftState);
    procedure Image1Click(Sender: TObject);

    procedure LstRelCargosClick(Sender: TObject);
    procedure LstRelMembrosClick(Sender: TObject);
    procedure LstRelTipoMembrosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RecBackgroundClick(Sender: TObject);
    procedure ListBoxItem13Click(Sender: TObject);
    procedure RctMnProdutosClick(Sender: TObject);
    procedure RctMnCaixasClick(Sender: TObject);
    procedure RctMnCargasClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure RctMnSairClick(Sender: TObject);
    procedure RctMnSeparacaoClick(Sender: TObject);
    procedure RctMnMovimentacaoClick(Sender: TObject);
    procedure RctMnInventarioClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LblDeviceIDDblClick(Sender: TObject);
    procedure Ac_FinalizarExecute(Sender: TObject);
    procedure RctMnEstoqueClick(Sender: TObject);
    procedure RctMnSaidaClick(Sender: TObject);
    procedure RctAtualizadorClick(Sender: TObject);
    procedure RctReconferenciaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RctMnExpedicaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLogin     : TFrmLogin;
    FCaixa     : TFrmCaixa;
    FExpedicao : TFrmExpedicao;
    FProduto   : TFrmProduto;
    FEstoque   : TFrmEstoque;
    FCarga     : TFrmCarga;
    FSeparacao : TFrmSeparacaoColetor;
    FMovimentacao  : TFrmControleArmazenagem;
    FSaidaConsulta : TFrmSaidaConsulta;
    FAtualizador   : TFrmAtualizadorApp;
    FInventario    : TFrmInventario;
    Function EndApk : Boolean;
    procedure DelayedSetFocus(control: TControl);
    procedure Messagem(Mens: String);
//    procedure PlaySound(pArqSom : String = 'toast3.wav');
//    procedure ShowHideMenu;
//    FTiposMembro: TFrmTiposMembro;
(*
     Procedure HideMenu;
     Procedure ShowMenu;
     Procedure CancelMenu(Sender : TObject);
*)
  protected
//    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
  public
    //Configuracao do Client - WMSConfig.xml
    ConfigWMS    : TConfiguracaoWMS;
    BASEUrl      : String;
    ObjUsuario   : TUsuario;
    Instalation  : Boolean;
    Company_Name : String;
    IpHost, PortHost  : String;
    Brand_Collector   : String;
    Scanner_Collector, Teclado : Boolean;  //Scanner_Collector indica se o Leitor de CB precisa ser ativado pelo App
    { Public declarations }
    Procedure ShowForm(AObject : TFmxObject);
(*
     Procedure ShowHideMenu;
     Procedure ShowBackGround(Aparent : TFmxObject; AOnClick : TNotifyEvent = Nil);
*)     Procedure HideBackGround;
    procedure ShowAlert(Titulo, Mensagem: String);                                  //$FF22AF70
    procedure MensToast(pMens : String = 'Operação bem sucedida!'; Cor : Cardinal = CorToastSucesso; ArqSom : String = 'toast3.wav'; SomOn : Boolean = True);
    Function ValidarFuncaoPorUsuario(pCdFuncao : Integer) : Boolean;
    procedure PlaySound(pArqSom : String = 'toast3.wav');
  end;

var
  FrmMain: TFrmMain;
  MsgD : TMsgD;

implementation

{$R *.fmx}

uses uDmClient, Notificacao;

(*
 procedure TFrmMain.CancelMenu(Sender: TObject);
 begin
   HideBackGround;
   ShowHideMenu;
 end;

*)
procedure TFrmMain.Ac_FinalizarExecute(Sender: TObject);
begin
  if Assigned(FCaixa) then Begin
     FCaixa.Close;
     FreeAndNil(FCaixa);
  End;
  if Assigned(FCarga) then Begin
     FCarga.Close;
     FreeAndNil(FCarga);
  End;
  if Assigned(FMovimentacao) then Begin
     FMovimentacao.Close;
     FreeAndNil(FMovimentacao);
  End;
  if Assigned(FProduto) then Begin
     FProduto.Close;
     FProduto := Nil; //FreeAndNil(FProduto) ;
  End;
  if Assigned(FSeparacao) then Begin
     FSeparacao.Close;
     FreeAndNil(FSeparacao);
     FSeparacao.DisposeOf;
  End;
  if Assigned(ObjUsuario) then
     FreeAndNil(ObjUsuario);
  If Assigned(FrmLogin) then Begin
     FrmLogin.Close;
     FrmLogin.DisposeOf;
  End;
  Self.DisposeOf;
(*
    {$IFDEF ANDROID} // or  {$IFDEF IOS}
       TAndroidHelper.Activity.Finish; //FinishAndRemoveTask
  //              Self.hide;
       MainActivity.finish;
       Application.MainForm.DisposeOf;
       Application.Terminate;
    {$Else}
       FrmMain.DisposeOf;
       Application.Terminate;
    {$Endif}

*)end;

procedure TFrmMain.DelayedSetFocus(control: TControl);
begin
  TThread.CreateAnonymousThread(procedure begin
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
  end).Start;
end;

Function TFrmMain.EndApk : Boolean;
begin
  Result := False;
  MsgD.FormMsg    := FrmMain;
  MsgD.Title      := 'Sair do App';
  MsgD.Text       := 'Deseja sair?';

  MsgD.ActionOk   := Ac_Finalizar;
  MsgD.ActionCancel := Ac_Cancel;
  MsgD.TypeInfo   := tMsgDInformation;

  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
  //ShowAlert('', '');
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := EndApk;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
Var lPermissaoPhoneState : String;
begin
  //ConfigWMS    := TConfiguracaoWMS.Create;

  MsgD := TMsgD.Create;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  RecBackground.Visible := False;
  RecBackground.Align   := TAlignLayout.Contents;
  LblVersao.Text := 'App Version: '+Versao('eXactWMSMobile.exe');
  LytMain.BringToFront;
  lytMain.BringToFront;
  LblDeviceID.Text := '';
  MobilePermissions1.Dangerous.ReadPhoneState := True;
  MobilePermissions1.Apply;
  FrmMain.BASEUrl := DmClient.RESTClient1.BaseURL;
  {$IfDef Android}
     LblDeviceID.Text := 'Device: '+Copy(IMEI, 1, 6)+'******'; //IMEI;
  {$ENdif}
(*
  {$IFDEF ANDROID}
    Self.StyleBook := styleAndroid;
  {$ENDIF}

  {$IFDEF IOS}
    Self.StyleBook := styleIOS;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
    Self.StyleBook := styleWindows;
  {$ENDIF}
 *)
{  RecBackground.Visible := False;
  RecBackground.Align   := TAlignLayout.Contents;
  LstMnuMain.Width      := Self.ClientWidth;
  LstMnuMain.Position.X := -Self.ClientWidth;
  LytMain.BringToFront;
  LstCargosClick(Sender);
}

end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(ObjUsuario) then
     ObjUsuario := nil;
end;

procedure TFrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
   FService : IFMXVirtualKeyboardService;
 begin
   TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
   if (Key = vkHardwareBack) or (Key = 137) or (Key = vkF2) then
   begin
     if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then begin
       //Reservado, não faz nada
     end
     else begin

       {Verifica qual formulário está ativo e então chama o método Voltar}
       {Se NÃO estiver com a listagem de pedidos aberta}
       {$Region 'Menu'}
       if MultiView1.IsShowed then begin
          MultiView1.HideMaster;
          Key := 0;
       end
       {$EndRegion}
       Else if ((Assigned(FSeparacao)) and (FSeparacao.PgcPrincipal.ActiveTab = FSeparacao.TabDetalhes) )then Begin     //and (FSeparacao.Visible)
          Key := 0;
//          if (FSeparacao.PgcPrincipal.ActiveTab = FSeparacao.TabDetalhes) or (FSeparacao.PgcPrincipal.ActiveTab = FSeparacao.TabAjusteLote) then Begin
//             DelayedSetFocus(FSeparacao.edtCodigo);
//             raise Exception.Create('Finalize a Separação...');
//          End;
       End
       else if (Assigned(FProduto)) and (FProduto.PgcPrincipal.ActiveTab = FProduto.TabDetalhes) and
               (FProduto.EdtCodigo.Text <> '') then Begin
         FProduto.EdtCodigo.Text := '';
         DelayedSetFocus(FProduto.EdtCodigo);
         FProduto.Limpar;
         Key := 0;
       End
       else if (Assigned(FProduto)) and (FProduto.lytBase.Visible) and not (FProduto.PgcPrincipal.ActiveTab = FProduto.TabLista) then Begin
         FProduto.PressionouVoltar;
         Key := 0;
       End
       Else  Begin
         ShowForm(Nil);
         MultiView1.ShowMaster;
       End;
     end;
   end;
//  if (key = VK_ESCAPE) then
//      FrmBase.PressCancelamento;
   Key := 0;
 end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  FrmMain.ConfigWMS :=  tJson.JsonToObject<TConfiguracaoWMS>( (DmClient.GetConfig.Items[0] as TJsonObject).ToString );
  if FrmMain.ConfigWMS.ApanheConsolidado = 1 then
     FrmMain.LblMnSeparacao.Text := 'Apanhe x Consolidado'
  Else FrmMain.LblMnSeparacao.Text := 'Apanhe';
end;

function TFrmMain.ValidarFuncaoPorUsuario(pCdFuncao: Integer): Boolean;
Var x : Integer;
begin
  Result := False;
  for X := 0 to Pred(ObjUsuario.Perfil.Funcoes.Size) do Begin
      if ObjUsuario.Perfil.Funcoes.Items[x].Codigo = pCdFuncao then
         Result := True;
  End;
end;

Procedure TFrmMain.ShowAlert(Titulo, Mensagem : String);   //Titulo : String = 'Ministério AVIVA'; Mensagem : String = 'Seja bem vindo ao nosso App Mobile');
var MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := 'Itec Brazil - WMS Mobile';
    MyNotification.Title := Titulo;
    MyNotification.AlertBody := Mensagem;
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
End;

procedure TFrmMain.HideBackGround;
begin
  With RecBackground do Begin
    AnimateFloat('opacity', 0, 0.1);
    Visible := False;
  End;
end;

procedure TFrmMain.Image1Click(Sender: TObject);
var       //http://stackoverflow.com/questions/26484766/open-url-in-xe6-firemonkey-ios-delphi
{$IFDEF ANDROID}
  Intent: JIntent;
{$ENDIF ANDROID}

{$IFDEF IOS}
  NSU: NSUrl;
{$ENDIF IOS}
myUrl : String;
begin
{$Region 'Internet'}
//http://stackoverflow.com/questions/18888345/how-to-check-if-network-is-available-on-android-delphi-xe5
  myURL := 'http://www.itecbrazil.com.br';
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(myURL), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}

{$IFDEF IOS}
  NSU   := StrToNSUrl(TIdURI.URLEncode(myURL));
  if SharedApplication.canOpenURL(NSU) then
  begin
    SharedApplication.openUrl(NSU);
  end;
{$ENDIF IOS}

{$IFDEF ANDROID}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(myURL));
  TAndroidHelper.Activity.startActivity(Intent);
{$ENDIF ANDROID}

{$EndRegion}
end;

procedure TFrmMain.LblDeviceIDDblClick(Sender: TObject);
var Svc: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
     Svc.SetClipboard(LblDeviceID.Text)
end;

procedure TFrmMain.ListBoxItem13Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.LstCargosClick(Sender: TObject);
begin
{  if Not Assigned(FCargos) then
     FCargos := TFrmCargos.Create(Self);
  MultiView1.MasterButton := FCargos.spbBack;
  MultiView1.HideMaster;
  LytMain.AddObject(FCargos.lytCargos);
  ShowForm(FCargos.lytCargos);
}//  if Sender <> Self then ShowHideMenu;
end;

//Enviar SMS
procedure TFrmMain.LstRelCargosClick(Sender: TObject);
{$IFDEF ANDROID or  {$IFDEF IOS}
var
  GerenciadorSMS : JSmsManager;
{$Endif}
begin
{$IFDEF ANDROID or  {$IFDEF IOS}
  GerenciadorSMS := TJSmsManager.JavaClass.getDefault;
  GerenciadorSMS.sendTextMessage(StringToJString(Edit1.Text), nil, StringToJString(Memo1.Lines.Text), nil, nil )
{$Endif}
End;

procedure TFrmMain.LstRelMembrosClick(Sender: TObject);
{$IFDEF ANDROID or  {$IFDEF IOS}
Var
  uri : string;
  Intent : JIntent;
  idContato : Integer;
  //WhatsApp
  IntentWhats : JIntent;
  mensagem : string;
  Extras: JBundle;
{$Endif}
Begin
{$IFDEF ANDROID or  {$IFDEF IOS}
{$Region 'PegarContato'}
   uri:= 'content://com.android.contacts/contacts/';
   try
     Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_PICK,
               TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));

     SharedActivity.startActivityForResult(Intent, 0);
   except on E: Exception do
     ShowMessage(E.Message);
  end;
{$EndRegion}
{$Endif}

end;


procedure TFrmMain.LstRelTipoMembrosClick(Sender: TObject);
Var //vContatos : TContactsManager;
    X : Integer;
begin
{$Region 'Pegar Todos Contatos da Agenda'}
//https://pjstrnad.com/accessing-contacts-delphi-ios-android/
{  vContatos := createContactsManager;
  vContatos.ExtractContactsList;
  for X := 0 to vContatos.ContactsCount-1 do
    ShowMessage(FormatFloat('00',X)+': '+vContatos.Contacts[X].FirstName+' '+vContatos.Contacts[X].Phone);
}
{$EndRegion}
end;

procedure TFrmMain.Messagem(Mens: String);
begin
  MessageDlg(Mens, TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = mrYes then Begin
           {$IFDEF ANDROID} // or  {$IFDEF IOS}
              TAndroidHelper.Activity.Finish;
           {$Else}
              Application.Terminate;
           {$Endif}
        End;
      end
    );
end;

procedure TFrmMain.RctAtualizadorClick(Sender: TObject);
begin
  if Not Assigned(FAtualizador) then
     FAtualizador := TFrmAtualizadorApp.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FAtualizador.LytBase);
  ShowForm(FAtualizador.LytBase);
end;

procedure TFrmMain.RctMnCaixasClick(Sender: TObject);
begin
  if Not Assigned(FCaixa) then
     FCaixa := TFrmCaixa.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCaixa.LytBase);
  FCaixa.ShowLoading;
  DelayedSetFocus(FCaixa.EdtCodigo);
  FEstoque.HideLoading;
  ShowForm(FCaixa.LytBase);
end;

procedure TFrmMain.RctMnCargasClick(Sender: TObject);
Var I : Integer;
begin
  if Not Assigned(FCarga) then
     FCarga := TFrmCarga.Create(Self);
//  MultiView1.MasterButton := FCaixa.spbBack;
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCarga.LytBase);
  FCarga.ShowLoading;
  DelayedSetFocus(FCarga.EdtCodigo);
  FCarga.HideLoading;
  ShowForm(FCarga.LytBase);
end;

procedure TFrmMain.RctMnEstoqueClick(Sender: TObject);
begin
  if Not Assigned(FEstoque) then
     FEstoque := TFrmEstoque.Create(Self);
//  MultiView1.MasterButton := FProduto.spbBack;
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FEstoque.LytBase);
  FEstoque.ShowLoading;
  DelayedSetFocus(FEstoque.EdtCodigo);
  FEstoque.HideLoading;
  ShowForm(FEstoque.LytBase);
end;

procedure TFrmMain.RctMnExpedicaoClick(Sender: TObject);
begin
  if Not Assigned(FExpedicao) then
     FExpedicao := TFrmExpedicao.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FExpedicao.LytBase);
  FExpedicao.ShowLoading;
  DelayedSetFocus(FExpedicao.EdtCodigo);
  FExpedicao.HideLoading;
  ShowForm(FExpedicao.LytBase);
end;

procedure TFrmMain.RctMnInventarioClick(Sender: TObject);
begin
   if Not Assigned(FInventario) then
      FInventario := TFrmInventario.Create(Self);
   MultiView1.HideMaster;
   Self.LytMain.RemoveObject(0);
   Self.LytMain.AddObject(FInventario.LytBase);
   FMovimentacao.ShowLoading;
   DelayedSetFocus(FInventario.EdtCodInventario);
   FInventario.HideLoading;
   ShowForm(FInventario.LytBase);
end;

procedure TFrmMain.RctMnMovimentacaoClick(Sender: TObject);
begin
   if Not Assigned(FMovimentacao) then
      FMovimentacao := TFrmControleArmazenagem.Create(Self);
   MultiView1.HideMaster;
   Self.LytMain.RemoveObject(0);
   Self.LytMain.AddObject(FMovimentacao.LytBase);
   FMovimentacao.ShowLoading;
   FMovimentacao.HideLoading;
   ShowForm(FMovimentacao.LytBase);
end;

procedure TFrmMain.RctMnProdutosClick(Sender: TObject);
begin
  if Not Assigned(FProduto) then
     FProduto := TFrmProduto.Create(Self);
//  MultiView1.MasterButton := FProduto.spbBack;
  MultiView1.HideMaster;
  KsLoadingIndicator1.ShowLoading;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FProduto.LytBase);
  DelayedSetFocus(FProduto.EdtCodigo);
  ShowForm(FProduto.LytBase);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmMain.RctMnSaidaClick(Sender: TObject);
begin
  if Not Assigned(FSaidaConsulta) then
     FSaidaConsulta := TFrmSaidaConsulta.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FSaidaConsulta.LytBase);
  FSaidaConsulta.ShowLoading;
  DelayedSetFocus(FSaidaConsulta.EdtCodigo);
  FSaidaConsulta.HideLoading;
  ShowForm(FSaidaConsulta.LytBase);
end;

procedure TFrmMain.RctMnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmMain.RctMnSeparacaoClick(Sender: TObject);
begin
  if Not Assigned(FSeparacao) then
     FSeparacao := TFrmSeparacaoColetor.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FSeparacao.LytBase);
  FSeparacao.ShowLoading;
  DelayedSetFocus(FSeparacao.EdtCodigo);
  ShowForm(FSeparacao.LytBase);
  FSeparacao.HideLoading;
end;

procedure TFrmMain.RctReconferenciaClick(Sender: TObject);
begin
  MensToast('Em Desenvolvimento!', CorToastInformação);
end;

procedure TFrmMain.RecBackgroundClick(Sender: TObject);
begin

end;

//Manipular as MSG SMS - http://warquia.blogspot.com.br/2014/06/obter-lista-de-mensagens-sms.html
(*  //Enviar Email
 var
   Destinatario : string;
   Intent : JIntent;
   Destinatarios: TJavaObjectArray<JString>;
 begin
   Destinatario := 'genilsonsoares@icloud.com';
   Destinatarios := TJavaObjectArray<JString>.Create(1);

   Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
   Destinatarios.Items[0] := StringToJString(Destinatario);
   Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, Destinatarios);
   Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString('App AVIVA Ministerio'));
   Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString('Funcionou mesmo.... nao sei como'));
   Intent.setType(StringToJString('plain/text'));
   SharedActivity.startActivity(TJIntent.JavaClass.createChooser(Intent,
               StrToJCharSequence('Selecione o Correio de Email')));
*)

(*
 procedure TFrmMain.ShowBackGround(Aparent: TFmxObject; AOnClick: TNotifyEvent);
 begin
 //  With RecBackground do Begin
     RecBackground.OnClick := AOnClick;
     RecBackground.Parent  := AParent;
     RecBackground.BringToFront;
     RecBackground.Opacity := 0;
     RecBackground.Visible := True;
     RecBackground.AnimateFloat('opacity', 0.5, 0.1);
 //  End;
 end;

*)
procedure TFrmMain.ShowForm(AObject: TFmxObject);
Var I : Integer;
begin
  //HideBackGround;
  {$Region 'EsconderForm'}
  for I  := 0 to Pred(Self.LytMain.Children.Count) do
    TControl(Self.LytMain.Children[I]).Visible :=
       TControl(Self.LytMain.Children[I]) = TControl(AObject);
  {$EndRegion}
end;

(*
procedure TFrmMain.ShowHideMenu;
 Var Position : Single;
 begin
   Position := Self.ClientWidth - 40;
   case Self.LytMain.Position.X  = Position of
     True  : HideMenu;
     False : ShowMenu;
   end;
 end;

 procedure TFrmMain.ShowMenu;
 begin
   AnimateDrawer.StartValue := 0;
   AnimateDrawer.StopValue  := Self.ClientWidth - 40; //C_MnuEspaco;
   AnimateDrawer.Start;
   //Reposiciona o menu principal
   lstMnuMain.AnimateFloat('Position.X', 0);

   //Mostra o retângulo preto sobre a lista ativa
   ShowBackground(Self.lytMain, CancelMenu);
 //  </pre><pre>
 end;

*)
procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  LblDateTime.Text := DateToStr(Date())+' '+Copy(TimeToStr(Time()),1,5);
end;
                                                                                         //$FF22AF70
Procedure TFrmMain.MensToast(pMens : String = 'Operação bem sucedida!'; Cor : Cardinal = CorToastSucesso; ArqSom : String = 'toast3.wav'; SomOn : Boolean = True);
Begin
  TThread.CreateAnonymousThread(procedure begin
    TThread.Synchronize(nil, procedure
      begin
        //lbl_botao.Text := 'Adicionar ao carrinho';
        TLoading.Hide;
        TLoading.ToastMessage(FrmMain, pMens, TAlignLayout.Top, cor);

        if SomOn then
           PlaySound(ArqSom);
      end);
  end).Start;
End;

Procedure TFrmMain.PlaySound(pArqSom : String = 'toast3.wav');
Var Arq : String;
Begin
  With FrmMain do Begin
    {$IFDEF IOS}
      arq := TPath.Combine(TPath.GetDocumentsPath, pArqSom);
    {$ENDIF}
    {$IFDEF ANDROID}
      arq := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, pArqSom);
      //System.IOUtils.TPath.GetDocumentsPath + PathDelim +
    {$ENDIF}
    {$IFDEF MSWINDOWS}
       arq := GetCurrentDir+'\Sound\'+pArqSom;
    {$ENDIF}
    MediaPlayer.Clear;
    MediaPlayer.FileName := arq;

    if MediaPlayer.State = TMediaState.Playing then MediaPlayer.Stop;
    if MediaPlayer.Media <> nil then MediaPlayer.Play;
  end;
End;

end.
