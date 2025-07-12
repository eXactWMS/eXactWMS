unit uFrmeXactWMS;

interface

uses
  IdUri,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  Rest.Json, System.Json, Rest.Types,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Ani, System.Actions,
  FMX.VirtualKeyboard, FMX.Platform, FireDAC.Comp.Client, uFrmBase, System.IOUtils,
  System.Permissions, System.Generics.Collections,
  {$IFDEF ANDROID}
    Androidapi.Helpers,
    Androidapi.JNIBridge,
    Androidapi.JNI.Telephony, //Sms
    FMX.Helpers.Android,
    FMX.Platform.Android,
    Androidapi.JNI.GraphicsContentViewText,
    Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
    Androidapi.JNI.Os, //Receber Intent
    Androidapi.IOUtils,
  {$Endif}
  {$IFDEF MSWINDOWS}
    Winapi.ShellAPI, Winapi.Windows,
  {$ENDIF MSWINDOWS}

  {$IFDEF IOS}
      Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS
  {$ENDIF IOS}
  FMX.MultiView, FMX.ScrollBox, FMX.Edit, System.Notification, FMX.Objects,

  FMX.ActnList,


  uFrmLogin, uFrmEmbalagem, uFrmEstoque, uFrmProduto, uFrmProdutoEnderecar, uFrmSeparacaoColetor,

  uFrmControleArmazenagem, uFrmSaidaConsulta, uFrmAtualizadorApp, uFrmCheckOut, uFuncoes, U_MsgD, uFrmInventario,

  uFrmReposicaoReabastecer, uFrmCargaCarregar, uFrmCargaConferencia,

  uFrmEntrada,

  FMX.Media, ksTypes, ksLoadingIndicator, uFrmExpedicao,

  MobilePermissions.Model.Signature, MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard, MobilePermissions.Component

  , ConfiguracaoClass

  , UsuarioCtrl, uFrmReposicaoTransferenciaPicking, FMX.Memo,

  uFrmCheckListEstoque, FMX.Memo.Types;

  //  ContactsManager

Const
  CorToastAlerta       = $FFC6DA16;
  CorToastErro         = $FFBD1919;
  CorToastInformação   = $FF2270AF;
  CorToastSucesso      = $FF22AF70;

type

  TFrmeXactWMS = class(TForm)
    Timer1: TTimer;
    NotificationCenter1: TNotificationCenter;
    MultiView1: TMultiView;
    RctDetUsuario: TRectangle;
    Circle1: TCircle;
    LblUsuario: TLabel;
    RctMnPrincipal: TRectangle;
    VertScrollBox1: TVertScrollBox;
    RctMnProdutos: TRectangle;
    LblMnProdutos: TLabel;
    RctMnCaixas: TRectangle;
    LblMnCaixas: TLabel;
    RctMnCargas: TRectangle;
    LblMnCargas: TLabel;
    RctMnMovimentacao: TRectangle;
    LblMnMovimentacao: TLabel;
    RctMnEstoque: TRectangle;
    LblMnEstoque: TLabel;
    RctMnInventario: TRectangle;
    LblMnInventario: TLabel;
    RctMnSaida: TRectangle;
    LblMnSaidas: TLabel;
    RctMnSeparacao: TRectangle;
    lblMnSeparacao: TLabel;
    LblUsuarioEmail: TLabel;
    RctMnSair: TRectangle;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    LblVersao: TLabel;
    LytFootUser: TLayout;
    Rectangle2: TRectangle;
    ActionList1: TActionList;
    Ac_Finalizar: TAction;
    Ac_Cancel: TAction;
    RctAtualizador: TRectangle;
    LblAtualizador: TLabel;
    FloatAnimation2: TFloatAnimation;
    MediaPlayer: TMediaPlayer;
    RctReconferencia: TRectangle;
    Label2: TLabel;
    ksLoadingIndicator1: TksLoadingIndicator;
    RctMnExpedicao: TRectangle;
    Label3: TLabel;
    MobilePermissions1: TMobilePermissions;
    RctLogoRS: TRectangle;
    PthBox: TPath;
    PthCarga: TPath;
    PthStock: TPath;
    PthExpedicao: TPath;
    PthInventario: TPath;
    PthProduto: TPath;
    PthMovimentacao: TPath;
    PthReconferencia: TPath;
    PthSaida: TPath;
    PthSair: TPath;
    Path3: TPath;
    PthAtualizar: TPath;
    Layout1: TLayout;
    LytMain: TLayout;
    Memo1: TMemo;
    Edit1: TEdit;
    RecBackground: TRectangle;
    AnimateDrawer: TFloatAnimation;
    LytRodape: TLayout;
    LblF2Menu: TLabel;
    LblDeviceId: TLabel;
    LytBackground: TLayout;
    LytTop: TLayout;
    Rectangle1: TRectangle;
    LblDateTime: TLabel;
    LblHeader: TLabel;
    RctProdutoEnderecar: TRectangle;
    Label4: TLabel;
    Path1: TPath;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    Layout15: TLayout;
    Layout16: TLayout;
    LytBtnMenu: TLayout;
    BrnMenu: TSpeedButton;
    ImgBtnMenu: TImage;
    RctReposicaoColeta: TRectangle;
    LblReposicaoColeta: TLabel;
    LytReposicaoColeta: TLayout;
    PthReposicaoColeta: TPath;
    RctCheckOut: TRectangle;
    LblCheckOut: TLabel;
    LytCheckOut: TLayout;
    PthCheckOut: TPath;
    RctCargaConferencia: TRectangle;
    LblCargaConferencia: TLabel;
    Layout17: TLayout;
    PthCargaConferencia: TPath;
    RctRecebimentos: TRectangle;
    LblRecebimentos: TLabel;
    LytRecebimentos: TLayout;
    Path2: TPath;
    RctTransfPicking: TRectangle;
    LblReposicaoTransfPick: TLabel;
    LytReposicaoTransfPick: TLayout;
    PthReposicaoTransfPick: TPath;
    ActAtualizaAPP: TAction;
    ActNaoAtualizaAPP: TAction;
    RctEstoqueCheckList: TRectangle;
    LblEstoqueCheckList: TLabel;
    LytEstoqueCheckList: TLayout;
    PthEstoqueCheckList: TPath;
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
    procedure RctProdutoEnderecarClick(Sender: TObject);
    procedure RctReposicaoColetaClick(Sender: TObject);
    procedure RctMnInventarioClick(Sender: TObject);
    procedure RctCheckOutClick(Sender: TObject);
    procedure RctCargaConferenciaClick(Sender: TObject);
    procedure RctRecebimentosClick(Sender: TObject);
    procedure BrnMenuClick(Sender: TObject);
    procedure RctTransfPickingClick(Sender: TObject);
    procedure ActAtualizaAPPExecute(Sender: TObject);
    procedure RctEstoqueCheckListClick(Sender: TObject);
  private
    { Private declarations }
    FLogin     : TFrmLogin;
    FCaixa     : TFrmEmbalagem;
    FCheckOut  : TFrmCheckOut;
    FExpedicao : TFrmExpedicao;
    FProduto   : TFrmProduto;
    FProdutoEnderecar : TFrmProdutoEnderecar;
    FEstoque   : TFrmEstoque;
    FCargaCarregar : TFrmCargaCarregar;
    FCargaConferencia : TFrmCargaConferencia;
    FSeparacao : TFrmSeparacaoColetor;
    FMovimentacao  : TFrmControleArmazenagem;
    FSaidaConsulta : TFrmSaidaConsulta;
    FAtualizador   : TFrmAtualizadorApp;
    FInventario    : TFrmInventario;
    FReabastecerPicking : TFrmReposicaoReabastecer;
    FReposicaoTransferenciaPicking : TFrmReposicaoTransferenciaPicking;
    FCheckListEstoque : TFrmCheckListEstoque;
    FRecebimentos  : TFrmEntrada;
    Function EndApk : Boolean;
    procedure DelayedSetFocus(control: TControl);
    procedure Messagem(Mens: String);
    Procedure GetUltimaVersao;
    procedure AtualizarAPP(pVersao : String);
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
    //ObjUsuario   : TUsuario;
    Instalation  : Boolean;
    Company_Name : String;
    IpHost, PortHost  : String;
    Brand_Collector   : String;
    Scanner_Collector, Teclado : Boolean;  //Scanner_Collector indica se o Leitor de CB precisa ser ativado pelo App
    ObjUsuarioCtrl : TUsuarioCtrl; //Padrão uExactWMS Desktop VCL
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
  FrmeXactWMS: TFrmeXactWMS;
  MsgD : TMsgD;

implementation

{$R *.fmx}

uses uDmClient, Notificacao, uOpenViewUrl;

procedure TFrmeXactWMS.DelayedSetFocus(control: TControl);
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

Function TFrmeXactWMS.EndApk : Boolean;
begin
  Result := False;
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Sair do App';
  MsgD.Text       := 'Deseja sair?';
  MsgD.ActionOk   := Ac_Finalizar;
  MsgD.ActionCancel := Ac_Cancel;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

procedure TFrmeXactWMS.FormActivate(Sender: TObject);
begin
  //ShowAlert('', '');
end;

procedure TFrmeXactWMS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := EndApk;
end;

procedure TFrmeXactWMS.FormCreate(Sender: TObject);
Var lPermissaoPhoneState : String;
begin
  //ConfigWMS    := TConfiguracaoWMS.Create;
  FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
  FormatSettings.LongDateFormat  := 'DD/MM/YYYY';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat 	:= 'hh:mm:ss';

  MsgD := TMsgD.Create;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  RecBackground.Visible := False;
  RecBackground.Align   := TAlignLayout.Contents;
  {$IfDef Android}
    LblVersao.Text   := 'Versão: '+VersaoAPK;
  {$Endif}
  {$IfDef MSWINDOWS}
    LblVersao.Text   := 'Versão: '+Versao('eXactWmsMobile.exe');
  {$EndIf}
  LytMain.BringToFront;
  lytMain.BringToFront;
  LblDeviceID.Text := '';
  MobilePermissions1.Dangerous.ReadPhoneState := True;
  MobilePermissions1.Dangerous.camera := True;
  MobilePermissions1.Dangerous.ReadExternalStorage := True;
  MobilePermissions1.Dangerous.WriteExternalStorage := True;
  MobilePermissions1.Apply;
  FrmeXactWMS.BASEUrl := DmClient.RESTClient1.BaseURL;
  ImgBtnMenu.Margins.Bottom := 3;
  {$IfDef Android}
     ImgBtnMenu.Margins.Bottom := 22;
     LblDeviceID.Text := 'Device: '+Copy(IMEI, 1, 6)+'******'; //IMEI;
     GetUltimaVersao;
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

procedure TFrmeXactWMS.FormDestroy(Sender: TObject);
begin
//  if Assigned(ObjUsuarioCtrl) then
//     ObjUsuarioCtrl := Nil;
end;

procedure TFrmeXactWMS.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
   FService : IFMXVirtualKeyboardService;
   xTeste : Integer;
 begin
   TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
   if (Key = vkHardwareBack) or (Key = 137) or (Key = vkF2) then
   begin
     if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
        xTeste := 0//Reservado, não faz nada
     else begin
       if MultiView1.IsShowed then begin
          MultiView1.HideMaster;
          Key := 0;
       end
       Else if ((Assigned(FSeparacao)) and (FSeparacao.PgcPrincipal.ActiveTab = FSeparacao.TabDetalhes) )then Begin     //and (FSeparacao.Visible)
          Key := 0;
         MultiView1.ShowMaster;
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
       else if (Assigned(FCheckListEstoque)) and (FCheckListEstoque.PgcPrincipal.ActiveTab = FCheckListEstoque.TabDetalhes) and
               (FCheckListEstoque.EdtCodigo.Text <> '') then Begin
         FCheckListEstoque.EdtCodigo.Text := '';
         DelayedSetFocus(FCheckListEstoque.EdtCodigo);
         //FCheckListEstoque.Limpar;
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

procedure TFrmeXactWMS.FormShow(Sender: TObject);
begin
  FrmeXactWMS.ConfigWMS :=  tJson.JsonToObject<TConfiguracaoWMS>( (DmClient.GetConfig.Items[0] as TJsonObject).ToString );
  if FrmeXactWMS.ConfigWMS.ApanheConsolidado = 1 then
     FrmeXactWMS.LblMnSeparacao.Text := 'Separação Consolidada'
  Else FrmeXactWMS.LblMnSeparacao.Text := 'Separação';
end;

procedure TFrmeXactWMS.AtualizarAPP(pVersao : String);
begin
  MsgD.FormMsg      := frmExactWMS;
  MsgD.Title        := 'Atualização do App. Versão: '+pVersao;
  MsgD.Text         := 'Deseja Atualizar agora?';
  MsgD.ActionOk     := ActAtualizaAPP;
  MsgD.ActionCancel := ActNaoAtualizaAPP;
  MsgD.TypeInfo     := tMsgDInformation;
  MsgD.Height       := 200;
  MsgD.ShowMsgD;
End;

procedure TFrmeXactWMS.GetUltimaVersao;
Var vHostBase  : String;
    JsonObject : TJsonObject;
    vErro      : String;
    pVersao    : String;
begin
  Try
    DmClient.RESTRequest1.Resource := 'v1/getversion';
    DmClient.RESTRequest1.Method   := RmGet;
    DmClient.RESTRequest1.Execute;
    JsonObject := DmClient.RESTResponse1.JSONValue as TJsonObject;
    if (Not JsonObject.TryGetValue('Erro', vErro)) and (JsonObject.Count > 0) then Begin
       pVersao := VersaoAPK;
       if (JsonObject.GetValue<String>('version') > pVersao) then Begin
          MensToast('Versao Atual : '+pVersao+'  Nova Versão('+JsonObject.GetValue<String>('version')+') Disponível! ', CorToastInformação);
          AtualizarAPP(pVersao);
       End;
    end;
  Except
  end;
end;

function TFrmeXactWMS.ValidarFuncaoPorUsuario(pCdFuncao: Integer): Boolean;
Var x : Integer;
begin
  Result := False;
  Exit;
{  for X := 0 to Pred(ObjUsuario.Perfil.Funcoes.Size) do Begin
      if ObjUsuario.Perfil.Funcoes.Items[x].Codigo = pCdFuncao then
         Result := True;
  End;
}end;

procedure TFrmeXactWMS.ActAtualizaAPPExecute(Sender: TObject);
begin
  RctAtualizadorClick(Sender);
end;

procedure TFrmeXactWMS.Ac_FinalizarExecute(Sender: TObject);
begin
  Try ObjUsuarioCtrl.LogOff Except End;
  ObjusuarioCtrl.Free;
  if Assigned(FCaixa) then Begin
     FCaixa.Close;
     FreeAndNil(FCaixa);
  End;
  if Assigned(FMovimentacao) then Begin
     FMovimentacao.Close;
     FMovimentacao := Nil;
  End;
  if Assigned(FProduto) then Begin
     FProduto.Close;
     FProduto := Nil; //FreeAndNil(FProduto) ;
  End;
  if Assigned(FSeparacao) then Begin
     FSeparacao.Close;
     FSeparacao := Nil;
  End;
  if Assigned(FReabastecerPicking) then Begin
     FReabastecerPicking.Close;
     FReabastecerPicking := Nil;
  End;
  if Assigned(FReposicaoTransferenciaPicking) then Begin
     FReposicaoTransferenciaPicking.Close;
     FReposicaoTransferenciaPicking := Nil;
  End;
  if Assigned(FCheckOut) then Begin
     FCheckOut.Close;
     FCheckOut := Nil;
  End;
  if Assigned(FExpedicao) then Begin
     FExpedicao.Close;
     FExpedicao := Nil;
  End;
  if Assigned(FCaixa) then Begin
     FCaixa.Close;
     FCaixa := Nil;
  End;
  if Assigned(FInventario) then Begin
     FInventario.Close;
     FInventario := nil;
  End;
  MsgD := Nil;
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
     TAndroidHelper.Activity.Finish; //FinishAndRemoveTask
     MainActivity.finish;
     Application.MainForm.DisposeOf;
     Application.Terminate;
  {$Else}
     Application.Terminate;
  {$Endif}
end;

procedure TFrmeXactWMS.BrnMenuClick(Sender: TObject);
begin
  if MultiView1.IsShowed then
     MultiView1.HideMaster
  Else MultiView1.ShowMaster;
end;

Procedure TFrmeXactWMS.ShowAlert(Titulo, Mensagem : String);   //Titulo : String = 'Ministério AVIVA'; Mensagem : String = 'Seja bem vindo ao nosso App Mobile');
var MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := 'Rhemasys Soluções - eXactWMS Mobile';
    MyNotification.Title := Titulo;
    MyNotification.AlertBody := Mensagem;
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
End;

procedure TFrmeXactWMS.HideBackGround;
begin
  With RecBackground do Begin
    AnimateFloat('opacity', 0, 0.1);
    Visible := False;
  End;
end;

procedure TFrmeXactWMS.Image1Click(Sender: TObject);
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

procedure TFrmeXactWMS.LblDeviceIDDblClick(Sender: TObject);
var Svc: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
     Svc.SetClipboard(LblDeviceID.Text)
end;

procedure TFrmeXactWMS.ListBoxItem13Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmeXactWMS.LstCargosClick(Sender: TObject);
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
procedure TFrmeXactWMS.LstRelCargosClick(Sender: TObject);
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

procedure TFrmeXactWMS.LstRelMembrosClick(Sender: TObject);
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


procedure TFrmeXactWMS.LstRelTipoMembrosClick(Sender: TObject);
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

procedure TFrmeXactWMS.Messagem(Mens: String);
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

//Atualizar versão do APK
procedure TFrmeXactWMS.RctAtualizadorClick(Sender: TObject);
var
  {$IFDEF ANDROID}
     Intent: JIntent;
     Data: Jnet_Uri;
     F : JFile;
  {$Endif}
  FileName : String;
begin
   Try
     FileName :=   ConfigWMS.UrlUpdateApk+'/exactwmsmobile.apk';
     //openurl('https://exactwms.ddns.net:8300/exactwms/V.1.4.9.7/exactwmsmobile.apk', False);  //xAmpp
     {$IFDEF ANDROID}
        openurl(filename, False);
        //'https://exactwms.ddns.net:8300/update/exactwmsmobile.apk', False);
     {$ELSE}
        openurl('https://exactwms.ddns.net:8300/update/exactwmsmobile.exe', False);
     {$Endif}
   except on E: Exception do
     MensToast('Erro: '+E.message, CorToastErro , 'alarme');
   end;
   {$IFDEF ANDROID}
      //FileName := System.IOUtils.TPath.Combine( 'http://192.192.3.76/app/atualizarapp', 'exactwmsmobile.apk' );
{
       FileName := System.IOUtils.TPath.Combine( '192.168.1.5/atualiza/exactwms_android', 'exactwmsmobile.apk' );
       F := TJFile.JavaClass.init(StringToJString(FileName));

       Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_INSTALL_PACKAGE);
       Intent.setDataAndType(TAndroidHelper.JFileToJURI(F), StringToJString('application/vnd.android.package-archive'));
       Intent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);

       TAndroidHelper.context.startActivity(Intent);

}
      //Abaixo Rotina do Wilson
     //ATUALIZARAPP;
(*     try
       Intent := TJIntent.Create;
       Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
       Intent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
       Data := TAndroidHelper.JFileToJURI(TJFile.JavaClass.init(
               StringToJString('http://exactwms.ddns.net:8300/update/exactwmsmobile.apk')));
       Intent.setDataAndType(Data, StringToJString('application/vnd.android.package-archive'));
       TAndroidHelper.Activity.startActivity(Intent);
     except on E: Exception do
       MensToast('Erro: '+E.message, CorToastErro , 'alarme');
     end;
*)
   {$Endif}
end;


(*procedure TFrmeXactWMS.RctAtualizadorClick(Sender: TObject);
 begin
   //OpenURL('http://192.168.1.5/atualiza/eXactWMS_androi/eXactWmsMobile.apk', false);
   {$IFDEF ANDROID}
      {Verifica se o arquivo já existe na pasta de downloads. Apaga caso exista e cria novamente}
//      if FileExists(GetSharedDownloadsDir + '/exactwmsmobile.apk') then
//        DeleteFile(GetSharedDownloadsDir+'/exactwmsmobile.apk');
   {$Endif}
   Messagem('Atualizar APP');

   ShowMessage('Atualizando');
   OpenURL('//rslenovo01/app/atualizarapp/exactwmsmobile.apk', false);

   EXIT;


   if Not Assigned(FAtualizador) then
      FAtualizador := TFrmAtualizadorApp.Create(Self);
   MultiView1.HideMaster;
   Self.LytMain.RemoveObject(0);
   Self.LytMain.AddObject(FAtualizador.LytBase);
   ShowForm(FAtualizador.LytBase);
 end;
*)
procedure TFrmeXactWMS.RctCargaConferenciaClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FCargaConferencia) then
     FCargaConferencia := TFrmCargaConferencia.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCargaConferencia.LytBase);
  FCargaConferencia.LblTituloForm.Text := 'Carga Conferência';
  ShowForm(FCargaConferencia.LytBase);
  DelayedSetFocus(FCargaConferencia.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctCheckOutClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FCheckOut) then
     FCheckOut := TFrmCheckOut.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCheckOut.LytBase);
  FCheckOut.LblTituloForm.Text := 'CheckOut Volume Cxa.Fechada';
  ShowForm(FCheckOut.LytBase);
  if FCheckOut.RctCabecalho.Enabled = False then
     DelayedSetFocus(FCheckOut.EdtProduto)
  Else
     DelayedSetFocus(FCheckOut.EdtVolumeId);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctEstoqueCheckListClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FCheckListEstoque) then
     FCheckListEstoque := TFrmCheckListEstoque.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCheckListEstoque.LytBase);
  FCheckListEstoque.LblTituloForm.Text := 'Estoque - CheckList';
  ShowForm(FCheckListEstoque.LytBase);
  DelayedSetFocus(FCheckListEstoque.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnCaixasClick(Sender: TObject);
begin
  if Not Assigned(FCaixa) then
     FCaixa := TFrmEmbalagem.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCaixa.LytBase);
  FCaixa.ShowLoading;
  DelayedSetFocus(FCaixa.EdtCodigo);
  FCaixa.HideLoading;
  ShowForm(FCaixa.LytBase);
end;

procedure TFrmeXactWMS.RctMnCargasClick(Sender: TObject);
Var I : Integer;
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FCargaCarregar) then
     FCargaCarregar := TFrmCargaCarregar.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FCargaCarregar.LytBase);
  FCargaCarregar.LblTituloForm.Text := 'Carga Carregar';
  ShowForm(FCargaCarregar.LytBase);
  DelayedSetFocus(FCargaCarregar.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnEstoqueClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FEstoque) then
     FEstoque := TFrmEstoque.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FEstoque.LytBase);
  FEstoque.LblTituloForm.Text := 'Estoque - Consulta';
  ShowForm(FEstoque.LytBase);
  DelayedSetFocus(FEstoque.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnExpedicaoClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FExpedicao) then
     FExpedicao := TFrmExpedicao.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FExpedicao.LytBase);
  FExpedicao.LblTituloForm.Text := 'Registrar Volume na Expedição';
  ShowForm(FExpedicao.LytBase);
  DelayedSetFocus(FExpedicao.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnInventarioClick(Sender: TObject);
begin
   if Not Assigned(FInventario) then
      FInventario := TFrmInventario.Create(Self);
   MultiView1.HideMaster;
   Self.LytMain.RemoveObject(0);
   Self.LytMain.AddObject(FInventario.LytBase);
   FInventario.ShowLoading;
   FInventario.LblTituloForm.Text := 'Inventário - Contagem';
   DelayedSetFocus(FInventario.EdtCodigo);
   ShowForm(FInventario.LytBase);
   FInventario.HideLoading;
end;

procedure TFrmeXactWMS.RctMnMovimentacaoClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FMovimentacao) then
      FMovimentacao := TFrmControleArmazenagem.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FMovimentacao.LytBase);
  FMovimentacao.LblTituloForm.Text := 'Movimentação de Estoque';
  ShowForm(FMovimentacao.LytBase);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnProdutosClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FProduto) then
     FProduto := TFrmProduto.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FProduto.LytBase);
  FProduto.LblTituloForm.Text := 'Cadastro de Produtos';
  ShowForm(FProduto.LytBase);
  DelayedSetFocus(FProduto.EdtCodigo);
//  DelayedSetFocus(FSeparacao.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnSaidaClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FSaidaConsulta) then
     FSaidaConsulta := TFrmSaidaConsulta.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FSaidaConsulta.LytBase);
  FSaidaConsulta.LblTituloForm.Text := 'Consulta Pedidos/Volumes';
  ShowForm(FSaidaConsulta.LytBase);
  DelayedSetFocus(FSaidaConsulta.EdtPedidoId);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctMnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmeXactWMS.RctMnSeparacaoClick(Sender: TObject);
begin
//  FSeparacao.ShowLoading;
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FSeparacao) then
     FSeparacao := TFrmSeparacaoColetor.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FSeparacao.LytBase);
  FSeparacao.LblTituloForm.Text := 'Separação de Produtos';
  ShowForm(FSeparacao.LytBase);
//  DelayedSetFocus(FSeparacao.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctProdutoEnderecarClick(Sender: TObject);
begin
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FProdutoEnderecar) then
     FProdutoEnderecar := TFrmProdutoEnderecar.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FProdutoEnderecar.LytBase);
  FProdutoEnderecar.LblTituloForm.Text := 'Endereçar Produto em Picking';
  ShowForm(FProdutoEnderecar.LytBase);
  //FormShow(FProdutoEnderecar);
  DelayedSetFocus(FProdutoEnderecar.EdtProduto);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctRecebimentosClick(Sender: TObject);
begin
  if Not Assigned(FRecebimentos) then
     FRecebimentos := TFrmEntrada.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FRecebimentos.LytBase);
  FRecebimentos.ShowLoading;
  FRecebimentos.LblTituloForm.Text := 'Recebimentos - Entrada';
  FRecebimentos.HideLoading;
  ShowForm(FRecebimentos.LytBase);
end;

procedure TFrmeXactWMS.RctReconferenciaClick(Sender: TObject);
begin
  MensToast('Em Desenvolvimento!', CorToastInformação);
end;

procedure TFrmeXactWMS.RctReposicaoColetaClick(Sender: TObject);
begin
//  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FReabastecerPicking) then
     FReabastecerPicking := TFrmReposicaoReabastecer.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FReabastecerPicking.LytBase);
  FReabastecerPicking.LblTituloForm.Text := 'Reabastecimento de Picking';
  ShowForm(FReabastecerPicking.LytBase);
  //FormShow(FReabastecerPicking);
  DelayedSetFocus(FReabastecerPicking.EdtCodigo);
//  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RctTransfPickingClick(Sender: TObject);
begin
  if Not (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposição - Transferência Picking')) then Begin
     MensToast('Usuário não autorizado!', CorToastAlerta, 'alarme');
     Exit;
  End;
  KsLoadingIndicator1.ShowLoading;
  if Not Assigned(FReposicaoTransferenciaPicking) then
     FReposicaoTransferenciaPicking := TFrmReposicaoTransferenciaPicking.Create(Self);
  MultiView1.HideMaster;
  Self.LytMain.RemoveObject(0);
  Self.LytMain.AddObject(FReposicaoTransferenciaPicking.LytBase);
  FReposicaoTransferenciaPicking.LblTituloForm.Text := 'Reposição - Transferência para Picking';
  ShowForm(FReposicaoTransferenciaPicking.LytBase);
  FReposicaoTransferenciaPicking.AtivarTransferenciaPicking;
  DelayedSetFocus(FReposicaoTransferenciaPicking.EdtCodigo);
  KsLoadingIndicator1.HideLoading;
end;

procedure TFrmeXactWMS.RecBackgroundClick(Sender: TObject);
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
 procedure TFrmeXactWMS.ShowBackGround(Aparent: TFmxObject; AOnClick: TNotifyEvent);
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
procedure TFrmeXactWMS.ShowForm(AObject: TFmxObject);
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
procedure TFrmeXactWMS.ShowHideMenu;
 Var Position : Single;
 begin
   Position := Self.ClientWidth - 40;
   case Self.LytMain.Position.X  = Position of
     True  : HideMenu;
     False : ShowMenu;
   end;
 end;

 procedure TFrmeXactWMS.ShowMenu;
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
procedure TFrmeXactWMS.Timer1Timer(Sender: TObject);
begin
  LblDateTime.Text := DateToStr(Date())+' '+Copy(TimeToStr(Time()),1,5);
end;
                                                                                         //$FF22AF70
Procedure TFrmeXactWMS.MensToast(pMens : String = 'Operação bem sucedida!'; Cor : Cardinal = CorToastSucesso; ArqSom : String = 'toast3.wav'; SomOn : Boolean = True);
Begin
  TThread.CreateAnonymousThread(procedure begin
    TThread.Synchronize(nil, procedure
      begin
        //lbl_botao.Text := 'Adicionar ao carrinho';
        TLoading.Hide;
        TLoading.ToastMessage(FrmeXactWMS, pMens, TAlignLayout.Top, cor);

        if SomOn then
           PlaySound(ArqSom);
      end);
  end).Start;
End;

Procedure TFrmeXactWMS.PlaySound(pArqSom : String = 'toast3.wav');
Var Arq : String;
Begin
  With FrmeXactWMS do Begin
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
