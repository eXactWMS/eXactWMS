unit uFrmBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  MultiDetailAppearanceU, FMX.Edit, FMX.ListBox, FMX.ScrollBox, FMX.Memo,
  FMX.PhoneDialer, System.Generics.Collections,
  uMyTabOrderClassHelper, System.Actions, FMX.ActnList, uTHistorico, uFuncoes,
  System.Rtti, FMX.Grid, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.IOUtils,
   Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
   U_MsgD, ksTypes, FMX.Media,
  FMX.Platform, FMX.VirtualKeyboard,
  ksLoadingIndicator, FMX.Grid.Style, FMX.Effects, FMX.Filter.Effects, FMX.Ani, Rest.Json, System.Json, Rest.Types
  {$IFDEF IOS}
      ,Macapi.Helpers
  {$ENDIF IOS}
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    , Androidapi.Helpers
    , Androidapi.JNI.Embarcadero
    , Androidapi.JNIBridge
    , Androidapi.JNI.GraphicsContentViewText
    , Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    , Androidapi.JNI.Os
  {$Endif}
  , FMX.Objects, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope;

{$IFDEF ANDROID} // or  {$IFDEF IOS}
 type
   TMyReceiver = class(TJavaLocal, JFMXBroadcastReceiverListener)
 public
   constructor Create;
   procedure onReceive(context: JContext; intent: JIntent); cdecl;
 end;
{$Endif}

type
  TFrmBase = class(TForm)
    LytBase: TLayout;
    PgcPrincipal: TTabControl;
    TabLista: TTabItem;
    TabDetalhes: TTabItem;
    LstPrincipal: TListView;
    Codigo: TLabel;
    VertScrollBox1: TVertScrollBox;
    ActionList1: TActionList;
    ChgTabDet: TChangeTabAction;
    ChgTabLista: TChangeTabAction;
    EdtCodigo: TEdit;
    ScaledLayout1: TScaledLayout;
    GdSearch: TGrid;
    BindSearch: TBindSourceDB;
    QryListaPadrao: TFDMemTable;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSearch: TLinkGridToDataSource;
    Ac_Ok: TAction;
    RctTitle: TRectangle;
    LblTituloForm: TLabel;
    LytMnTop: TLayout;
    RctBarraFerramentas: TRectangle;
    BtnAdd: TSpeedButton;
    PthBtnAdd: TPath;
    BtnEdit: TSpeedButton;
    PthBtnEdit: TPath;
    BtnDel: TSpeedButton;
    PthBtnDel: TPath;
    BtnCancel: TSpeedButton;
    PthBtnCancel: TPath;
    BtnSave: TSpeedButton;
    PthBtnSave: TPath;
    BtnArrowLeft: TSpeedButton;
    PthArrowLeft: TPath;
    BtnArrowRigth: TSpeedButton;
    PthArrowRight: TPath;
    LytPesqForm: TLayout;
    LytTopForm: TLayout;
    RctTopForm: TRectangle;
    LblContPesq: TLabel;
    EdtConteudoPesq: TEdit;
    CbCampoPesq: TComboBox;
    LblCbPesq: TLabel;
    LnConteudoPesq: TLine;
    LnCodigo: TLine;
    BtnSearchPesq: TSpeedButton;
    PthSearcPesq: TPath;
    MediaPlayer1: TMediaPlayer;
    LytAutorizacao: TLayout;
    AnimaAutorizacao: TFloatAnimation;
    RctAutorizacao: TRectangle;
    LyrAutotizaTop: TLayout;
    RctAutorizaTop: TRectangle;
    LblAutorizaTop: TLabel;
    lytAutorizaCenterLogin: TLayout;
    RctAutorizaCenterLogin: TRectangle;
    PthCtrlSeg1: TPath;
    EdtUsuarioCtrlSeg: TEdit;
    FillRGBEffect1: TFillRGBEffect;
    LineCtrlSeg1: TLine;
    LblUsuarioCtrlSeg: TLabel;
    AnimaLLogin: TFloatAnimation;
    EdtSenhaCtrlSeg: TEdit;
    FillRGBEffect2: TFillRGBEffect;
    LineCtrlSeg2: TLine;
    LblSenhaCtrlSeg: TLabel;
    AnimalSenha: TFloatAnimation;
    PthCtrlSeg2: TPath;
    PthCloseAut: TPath;
    ksLoadingIndicator1: TksLoadingIndicator;
    BtnLogIn: TRectangle;
    LblLogin: TLabel;
    LblUsuarioAut: TLabel;
    FloatAnimation1: TFloatAnimation;
    LnCampoPesq: TLine;
    LytListaBase: TLayout;
    RctTitListaPrincipal: TRectangle;
    LblTit01: TLabel;
    ImgLstRecycledChocolate: TImage;
    ImgLstRecycledGray: TImage;
    ImgLstFdoYellow: TImage;
    ImgLstFdoGreen: TImage;
    ImgLstFdoRed: TImage;
    CircleStatus: TCircle;
    LblAtivo: TLabel;
    ImgFdoGrid01: TImage;
    ImgFdoGrid02: TImage;
    LytShowErro: TLayout;
    AnimaShowErro: TFloatAnimation;
    RctShowErro: TRectangle;
    LytHeaderShowErro: TLayout;
    RctHeaderShowErro: TRectangle;
    LblHeaderShowErro: TLabel;
    LytBodyShowErro: TLayout;
    Rectangle5: TRectangle;
    LblMsg01ShowErro: TLabel;
    LblMsg02ShowErro: TLabel;
    Path3: TPath;
    RctBtnOkShowErro: TRectangle;
    LblBtnOkShowErro: TLabel;
    EdtShowErro: TEdit;
    TabConfirmacao: TTabItem;
    RctConfirmacao: TRectangle;
    LytTopConfirmacao: TLayout;
    RctTopConfirmacao: TRectangle;
    LytImgConfirmacao: TLayout;
    PthConfirmacao: TPath;
    LytTituloConfirmacao: TLayout;
    LblTituloConfirmacao: TLabel;
    LytFootRodape: TLayout;
    RctFootRodape: TRectangle;
    LytTituloFootRodape: TLayout;
    LblTituloFoot: TLabel;
    LytCenterConfirmacao: TLayout;
    LytButtonConfirmacao: TLayout;
    LytMsgConfirmacao: TLayout;
    LytBtnConfirma: TLayout;
    RctBtnConfirma: TRectangle;
    lbl_BtnConfirma: TLabel;
    LytConfirma: TLayout;
    img_Confirma: TImage;
    AnimeConfirma: TFloatAnimation;
    LytBtnCancel: TLayout;
    RctbtnCancel: TRectangle;
    img_iconeCancel: TImage;
    lbl_BtnCancel: TLabel;
    img_Cancel: TImage;
    AnimeBtnCancel: TFloatAnimation;
    LytMensagem1: TLayout;
    LytMensagem2: TLayout;
    LytMensagens: TLayout;
    LblMensagem1: TLabel;
    LblMensagem2: TLabel;
    CircMenu: TCircle;
    ImgEye: TImage;
    ChgTabConfirmacao: TChangeTabAction;
    BtnTeclado: TSpeedButton;
    PthBtnTeclado: TPath;
    LblVersaoErro: TLabel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const [Ref] Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const [Ref] Bounds: TRect);
    procedure SpbBackClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure LstPrincipalGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure PgcPrincipalGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure GdSearchDblClick(Sender: TObject);
    procedure GdSearchGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure BtnArrowLeftClick(Sender: TObject);
    procedure BtnArrowRigthClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnLogInMouseEnter(Sender: TObject);
    procedure BtnLogInMouseLeave(Sender: TObject);
    procedure BtnLogInClick(Sender: TObject);
    procedure AnimaAutorizacaoFinish(Sender: TObject);
    procedure PthCloseAutClick(Sender: TObject);
    procedure EdtUsuarioCtrlSegTyping(Sender: TObject);
    procedure EdtUsuarioCtrlSegChangeTracking(Sender: TObject);
    procedure EdtSenhaCtrlSegChangeTracking(Sender: TObject);
    procedure EdtUsuarioCtrlSegKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtUsuarioCtrlSegValidate(Sender: TObject; var Text: string);
    procedure EdtSenhaCtrlSegValidate(Sender: TObject; var Text: string);
    procedure EdtSenhaCtrlSegKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure PgcPrincipalTap(Sender: TObject; const Point: TPointF);
    procedure BtnSearchPesqClick(Sender: TObject);
    procedure AnimaShowErroFinish(Sender: TObject);
    procedure RctBtnOkShowErroClick(Sender: TObject);
    procedure EdtConteudoPesqKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtConteudoPesqExit(Sender: TObject);
    procedure RctBtnConfirmaClick(Sender: TObject);
    procedure RctbtnCancelClick(Sender: TObject);
    procedure CircMenuClick(Sender: TObject);
    procedure Ac_OkExecute(Sender: TObject);
    procedure BtnTecladoClick(Sender: TObject);
  private
    { Private declarations }
    LoginLigado, SenhaLigado: boolean;
    {$IfDef Android}
    FMyListener: TMyReceiver;
    FBroadcastReceiver: JFMXBroadcastReceiver;
    {$Endif}
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    FocusActual : TControl;
    Procedure CtrlRead;
    Procedure ClearField(StateRead : Boolean); OverLoad;
    Procedure ClearFIeld; OverLoad;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure UpdateKBBounds;
    procedure RestorePosition;
    Procedure PthBtnOnOff(pSetar : Boolean);
    Procedure ProcessarGETErro(Sender: TObject);
    Procedure GetUsuarioSenha(Sender : TObject);
    procedure MsgErroAlerta(pMensagem: String);
    Procedure MsgSucesso(pMensagem : string);
  Protected
   vgHistorico : THistorico;
   Procedure AtualizarHistorico; dynamic;
   Procedure PermitirAcessoCtrlSeg; Dynamic;
   Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; Dynamic;
   Procedure ShowDados; Dynamic;
   Procedure LimpaField; Dynamic;
   Procedure Limpar; Dynamic;
   Function DeleteReg : Boolean; Dynamic;
   Function SalvarReg : Boolean; Dynamic;
   Procedure GetListaLstCadastro; Dynamic;
   Procedure LiberarFuncaoBloqueada; Dynamic;
   Procedure BlockFuncaoAutorizacao; Dynamic;
   Procedure ConfirmacaoExecute; Dynamic;
   Procedure ConfirmacaoCancel; Dynamic;
   Procedure AtivaCampoDefault; Dynamic;
  public
    { Public declarations }
    vPosLblUsuario, vPosLblSenha : Single;
    Discador : IFMXPhoneDialerService;
    FuncionalidadeCtrlSeg : String;
    ResultConfirm : Boolean;
    funcaoParaAutorizar : String;
    funcaoParaAutorizar_Liberada : Boolean;
    CampoDefault : String;
    Function NewCode : String; dynamic;
    Function DialNumber(Number : String) : Boolean;
    procedure PressionouVoltar;
    procedure PressionouMenu;
    procedure DelayedSetFocus(control: TControl);
    Procedure MensagemStand(vMens : String);
    Procedure ShowLoading;
    Procedure HideLoading;
    Procedure PressCancelamento;
    Procedure FuncaoDesabilitada(const Frm : Tform);
    Procedure ShowErro(pMensagem : String = ''; pArqSound : String = 'notfound');
    procedure ShowOk(pMensagem: String=''; pSom : String = 'ok');
    procedure ShowMSG(pMensagem: String=''; pSom : String = 'alerta');
    Procedure AtivarPanelSeguranca;
    Procedure SetAtivoOnOff(pOnOff : Boolean);
    Procedure SetCampoDefault(pCampoDefault : String);
  end;

Var FrmBase : TFrmBase;
    MsgD : TMsgD;

Const MsgPesquisaNaoEntrada = 'Não foram encontrados dados com os critérios definidos';
Const OperacaoNaoPermitida  = 'Operação não permitida. Pode ser que você não tenha acesso.';

implementation

Uses System.Math, Notificacao, uFrmeXactWMS, uDmClient, UsuarioCtrl;

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure StartButtonAnimation(rectButton: TRectangle;
                               lbl: TLabel; text: string;
                               icon: TImage;
                               animation: TFloatAnimation);
begin
    icon.Visible := true;
    animation.Start;

    rectButton.Opacity := 0.99;
    rectButton.Enabled := false;

    lbl.TagString := lbl.Text;
    lbl.Text := text;
end;

procedure StopButtonAnimation(rectButton: TRectangle;
                              lbl: TLabel;
                              icon: TImage;
                              animation: TFloatAnimation;
                              hideIcon: Boolean);
begin
    if lbl.TagString <> '' then
        lbl.Text := lbl.TagString;

    rectButton.Opacity := 1;
    rectButton.Enabled := true;

    icon.Visible := NOT hideIcon;
    animation.Stop;
end;

procedure TFrmBase.AtualizarHistorico;
begin
  Exit;
  if (Assigned(vgHistorico) = False) then
  	begin
  	  vgHistorico := THistorico.Create;
  	end;

  vgHistorico.DataHora      := 0;
  vgHistorico.CodigoUsuario := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  vgHistorico.CodigoFuncao  := 0;
  {$IfDef Android}
    vgHistorico.Estacao := IMEI;
  {$EndIf}
  {$IfDef MsWindows}
    vgHistorico.Estacao       := NomeDoComputador;
  {$Endif}
  vgHistorico.Modulo        := Application.Title;// Name;
  vgHistorico.Versao        := Versao('ClientWMS.exe');
  vgHistorico.Observacao    := '';
end;

procedure TFrmBase.BlockFuncaoAutorizacao;
begin
//
end;

procedure TFrmBase.BtnAddClick(Sender: TObject);
begin
  PthBtnOnOff(False);
  ClearField;
  NewCode;
end;

procedure TFrmBase.BtnArrowLeftClick(Sender: TObject);
begin
  ChgTabLista.Execute;
  GetListaLstCadastro;
  EdtConteudoPesq.ReadOnly := False;
  DelayEdSetFocus(EdtconteudoPesq);
end;

procedure TFrmBase.BtnArrowRigthClick(Sender: TObject);
begin
  ChgTabDet.Execute;
end;

procedure TFrmBase.BtnCancelClick(Sender: TObject);
begin
  ResultConfirm := False;
  MessageDlg('Confirma o cancelamento?', TMsgDlgType.mtConfirmation,[TMsgDlgBtn.MbYes, TMsgDlgBtn.MbNo], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = mrYes then
        begin
            PthBtnOnOff(True);
            ClearField;
            ResultConfirm := True;
          {$IFDEF ANDROID}
//          MainActivity.finish;
          {$ELSE}
            exit;
          {$ENDIF}
        end;
      end
  );
end;

procedure TFrmBase.BtnDelClick(Sender: TObject);
begin
  {$Region 'Apaga Registro'}
  MessageDlg('Deseja Excluir o registro?', TMsgDlgType.mtConfirmation,[TMsgDlgBtn.MbYes, TMsgDlgBtn.MbNo], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = mrYes then Begin
           If DeleteReg then ClearField;
           MessageDlg('Registro excluído com sucesso!', TMsgDlgType.mtInformation,
                      [TMsgDlgBtn.mbOK], 0 );
//           Desabilitar;
//           KeyDown(VkTab, #0, ssShift);
        End;
      end
  );
end;

procedure TFrmBase.BtnEditClick(Sender: TObject);
begin
  PthBtnOnOff(False);
  CtrlRead;
end;

procedure TFrmBase.BtnLogInClick(Sender: TObject);
begin
  GetUsuarioSenha(BtnLogIn)
end;

procedure TFrmBase.BtnLogInMouseEnter(Sender: TObject);
begin
  BtnLogin.Fill.Color   := TAlphaColorRec.Chocolate;
  BtnLogin.Stroke.Color := TAlphaColorRec.Null;
  LblLogin.FontColor    := TAlphaColorRec.White;
end;

procedure TFrmBase.BtnLogInMouseLeave(Sender: TObject);
begin
  BtnLogin.Fill.Color   := TAlphaColorRec.Null;
  BtnLogin.Stroke.Color := TAlphaColorRec.Chocolate;
  LblLogin.FontColor    := TAlphaColorRec.Chocolate;
end;

procedure TFrmBase.ClearField;
begin
  ClearField(True);
end;

procedure TFrmBase.ConfirmacaoCancel;
begin
//
end;

procedure TFrmBase.ConfirmacaoExecute;
begin
//
end;

procedure TFrmBase.Ac_OkExecute(Sender: TObject);
begin
  AtivaCampoDefault;
end;

procedure TFrmBase.AnimaAutorizacaoFinish(Sender: TObject);
begin
  if AnimaAutorizacao.Inverse = true then
     LytAutorizacao.Visible := false
end;

procedure TFrmBase.AnimaShowErroFinish(Sender: TObject);
begin
  if AnimaShowErro.Inverse = true then Begin
     LytShowErro.Visible := false;
     Exit;
  End;
  DelayEdSetFocus( EdtShowErro );
  EdtShowErro.Visible := False;
end;

procedure TFrmBase.AtivaCampoDefault;
begin
 //com base na variavel pCampoDefault disparar DelayEdSetFocus
end;

Procedure TFrmBase.AtivarPanelSeguranca;
begin
  EdtUsuarioCtrlSeg.ReadOnly  := False;
  EdtSenhaCtrlSeg.ReadOnly    := False;
  AnimaAutorizacao.Inverse    := false;
  LytAutorizacao.Position.X   := Width + 20;
  LytAutorizacao.Visible      := true;
  ActiveControl := nil;
  AnimaAutorizacao.StartValue := Width + 20;
  AnimaAutorizacao.StopValue  := 0;
  AnimaAutorizacao.Enabled    := True;
  AnimaAutorizacao.Start;
  DelayedSetFocus(EdtUsuarioCtrlSeg);
  funcaoParaAutorizar_Liberada := False;
end;

procedure TFrmBase.CtrlRead;
Var xComp : Integer;
begin
  for xComp := 0 to ComponentCount -1 do Begin
      if (Components[xComp] is tEdit) then
          tEdit(Components[xComp]).ReadOnly := Not tEdit(Components[xComp]).ReadOnly
      Else if (Components[xComp] is tComboBox) then tComboBox(Components[xComp]).Enabled := Not tComboBox(Components[xComp]).Enabled
      Else if (Components[xComp] is tCheckBox) then tCheckBox(Components[xComp]).Enabled := Not tCheckBox(Components[xComp]).Enabled
      Else if (Components[xComp] is TSwitch) then TSwitch(Components[xComp]).Enabled := Not TSwitch(Components[xComp]).Enabled
      Else if (Components[xComp] is tRadioButton) then tRadioButton(Components[xComp]).Enabled := Not tRadioButton(Components[xComp]).Enabled
      Else if (Components[xComp] is tMemo) then TMemo(Components[xComp]).ReadOnly := Not TMemo(Components[xComp]).ReadOnly
  end;
//Ativar/Desativar Read dos Componentes
end;

procedure TFrmBase.DelayedSetFocus(control: TControl);
begin
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

Function TFrmBase.DeleteReg : Boolean;
begin
  Result := False;
end;

function TFrmBase.DialNumber(Number: String): Boolean;
begin
  if not Number.IsEmpty then begin
      TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, IInterface(Discador));
      if Assigned(Discador) then
         Discador.Call(Number);
  end
  else
     Discador.Call(InputBox('Discagem Automática', 'Informe o número a ser discado!', '' ));
 end;

procedure TFrmBase.EdtConteudoPesqExit(Sender: TObject);
begin
  //1 = 1;
end;

procedure TFrmBase.EdtConteudoPesqKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = 13) and (EdtConteudoPesq.Text<>'') and
     ((CbCampoPesq.ItemIndex >= 0) or (Not CbCampoPesq.Visible))then
     BtnSearchPesqClick(EdtConteudoPesq);
end;

procedure TFrmBase.EdtSenhaCtrlSegChangeTracking(Sender: TObject);
begin
if (EdtSenhaCtrlSeg.Text.Length > 0) and (SenhaLigado=false) then
  begin
   Senhaligado:=true;
   animalSenha.StartValue := vPosLblSenha;
   animalSenha.StopValue  := vPosLblSenha-25;
   animalSenha.Enabled:=true;
   animalSenha.Start;
  end
else if EdtSenhaCtrlSeg.Text.Length = 0 then
  begin
   Senhaligado:=false;
   animalSenha.StartValue := vPosLblSenha-25;
   animalSenha.StopValue  := vPosLblSenha;
   animalSenha.Enabled:=true;
   animalSenha.Start;
  end;
end;

procedure TFrmBase.EdtSenhaCtrlSegKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   If (Sender=EdtSenhaCtrlSeg) and (EdtSenhaCtrlSeg.Text<>'') and (EdtUsuarioCtrlSeg.Text<>'')then
      BtnLoginClick(BtnLogIn)
   Else DelayEdSetFocus(EdtUsuarioCtrlSeg);
end;

procedure TFrmBase.EdtSenhaCtrlSegValidate(Sender: TObject; var Text: string);
begin
//
end;

procedure TFrmBase.EdtUsuarioCtrlSegChangeTracking(Sender: TObject);
begin
if (EdtUsuarioCtrlSeg.Text.Length > 0) and (loginligado=false) then
  begin
   loginligado:=true;
   animallogin.StartValue := vPosLblUsuario;  //40
   animallogin.StopValue  := vPosLblUsuario-25;     //25
   animallogin.Enabled:=true;
   animallogin.Start;
  end
else if EdtUsuarioCtrlSeg.Text.Length = 0 then
  begin
   loginligado:=false;
   animallogin.StartValue := vPosLblUsuario-25;    //25
   animallogin.StopValue  := vPosLblUsuario; //40;
   animallogin.Enabled:=true;
   animallogin.Start;
  end;
end;

procedure TFrmBase.EdtUsuarioCtrlSegKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (Key in [9, 13]) or (KeyChar=#13) then Begin //and (TEdit(Sender).Text<>'') then Begin
     If (Sender = EdtUsuarioCtrlSeg) and (EdtUsuarioCtrlSeg.Text<>'') then Begin
        DelayedSetFocus(EdtSenhaCtrlSeg);
        GetUsuarioSenha(EdtUsuarioCtrlSeg);
     End
     Else If (Sender=EdtSenhaCtrlSeg) and (EdtSenhaCtrlSeg.Text<>'') then
        BtnLoginClick(BtnLogIn);
//     Key := 0;
  End
  Else if key = vkEscape then  Begin
     EdtUsuarioCtrlSeg.Text := '';
     EdtSenhaCtrlSeg.Text   := '';
  End;
end;

procedure TFrmBase.EdtUsuarioCtrlSegTyping(Sender: TObject);
begin
  LblUsuarioAut.Text := '...';
end;

procedure TFrmBase.EdtUsuarioCtrlSegValidate(Sender: TObject; var Text: string);
begin
//  GetUsuarioSenha(EdtUsuario);
end;

procedure TFrmBase.ClearField(StateRead : Boolean);
Var xComp : Integer;
begin
  If StateRead then CtrlRead;
  LimpaField;
{
   for xComp := 0 to ComponentCount -1 do Begin
       if (Components[xComp] is tComboBox) then tComboBox(Components[xComp]).ItemIndex := -1
       Else if (Components[xComp] is tEdit) then tEdit(Components[xComp]).Text := ''
       Else if (Components[xComp] is tRadioButton) then tRadioButton(Components[xComp]).IsChecked := False
       Else if (Components[xComp] is tMemo) then TMemo(Components[xComp]).Lines.Clear
       Else if (Components[xComp] is TSwitch) then TSwitch(Components[xComp]).IsChecked := False
       Else if (Components[xComp] is tCheckBox) then tCheckBox(Components[xComp]).IsChecked := False;
   end;
}
end;

procedure TFrmBase.LiberarFuncaoBloqueada;
begin
//
end;

procedure TFrmBase.LimpaField;
Var xComp : Integer;
begin
  //EnabledButtons := False;
  for xComp := 0 to ComponentCount -1 do Begin
    if (Components[xComp] is tComboBox)  then tComboBox(Components[xComp]).ItemIndex := -1
    Else if (Components[xComp] is tEdit) then tEdit(Components[xComp]).Text := ''
    Else if (Components[xComp] is tRadioButton) then tRadioButton(Components[xComp]).IsChecked := False
    Else if (Components[xComp] is tMemo) then TMemo(Components[xComp]).Text := '';
  end;
  EdtCodigo.Enabled  := True;
  EdtCodigo.ReadOnly := False;
  Limpar;
end;

procedure TFrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 // FreeAndNil(vgHistorico);
end;

procedure TFrmBase.FormCreate(Sender: TObject);
{$IfDef Android}
var  Filter: JIntentFilter;
{$Endif}
begin
{$IfDef Android}
  FMyListener := TMyReceiver.Create;
  FBroadcastReceiver := TJFMXBroadcastReceiver.JavaClass.init(FMyListener);
  Filter := TJIntentFilter.JavaClass.init(StringToJString('hsm.RECVRBI'));
  TAndroidHelper.context.getApplicationContext.registerReceiver
    (FBroadcastReceiver, Filter);
{$Endif}
  TabLista.Opacity    := 1;
  TabDetalhes.Opacity := 1;
//  PgcPrincipal.ActiveTab := TabLista;
  ClearField(True);
  VertScrollBox1.OnCalcContentBounds := CalcContentBoundsProc; //http://rodrigomourao.com.br/tvertscrollbox-aprenda-a-evitar-que-o-teclado-virtual-encubra-seus-controles/
  BtnArrowLeft.Text  := '';
  BtnArrowRigth.Text := '';
  //if FrmeXactWMS.Brand_Collector = 'Honeywell' then Begin
  //   VKAutoShowMode := TVKAutoShowMode.DefinedBySystem   // Always
  //End;
  PthBtnOnOff(True);
  //LytOpcoes.Visible       := false;
  LytAutorizacao.Visible  := False;
  LytShowErro.Visible     := False;
  LoginLigado := False;
  SenhaLigado := False;
  LimpaField;
  CbCampoPesq.Enabled := True;
  //Limpar;
  //GetListaLstCadastro;
  MsgD := TMsgD.Create;
  {$IFDEF ANDROID}
    BtnTeclado.Visible := True;
  {$Else}
    BtnTeclado.Visible := False;
  {$Endif}
  if Not (PgcPrincipal.ActiveTab = TabLista) then
     PgcPrincipal.ActiveTab := TabLista
  Else
     GetListaLstCadastro;
end;

procedure TFrmBase.FormDestroy(Sender: TObject);
begin
{$IfDef Android}
  TAndroidHelper.context.getApplicationContext.unregisterReceiver
    (FBroadcastReceiver);
{$Endif}
  MsgD.DisposeOf;
end;

procedure TFrmBase.FormFocusChanged(Sender: TObject);
begin
//  UpdateKBBounds;
end;

procedure TFrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
(*  //https://forums.embarcadero.com/thread.jspa?messageID=697582 Unit: MyTabOrderClassHelper.Pas
    case Key of
      vkReturn:
        TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
      vkTab:
        TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
    end;
*)
end;

procedure TFrmBase.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const [Ref] Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFrmBase.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const [Ref] Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TFrmBase.FuncaoDesabilitada(const Frm : Tform);
begin
  TThread.CreateAnonymousThread(procedure begin
    TThread.Synchronize(nil, procedure
    begin
      FrmeXactWMS.PlaySound('notfound.wav');
      TLoading.ToastMessage(FrmeXactWMS, 'Função desabilitada!', TAlignLayout.MostTop, CorToastErro);
    End);
  end).Start;
end;

procedure TFrmBase.GdSearchDblClick(Sender: TObject);
begin
//
end;

procedure TFrmBase.GdSearchGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
//  ShowMessage('Gesture Base GdSearch');
end;

procedure TFrmBase.GetListaLstCadastro;
begin
  PgcPrincipal.ActiveTab := TabLista;
  DelayEdSetFocus(EdtConteudoPesq);
end;

procedure TFrmBase.GetUsuarioSenha(Sender : TObject);
Var vErro   : String;
    jArray  : TJsonArray;
   ObjUsuarioCtrl : TUsuarioCtrl;
begin
  if (Sender=EdtUsuarioCtrlSeg) and (EdtUsuarioCtrlSeg.Text = '') then
     Exit;
  if (Sender=BtnLogIn) and ((EdtUsuarioCtrlSeg.Text = '') or (EdtSenhaCtrlSeg.Text='')) then Begin
     ShowErro('Informe usuário e senha.');
     Exit;
  End;
  Try
    //ShowLoadingIndicator(Self, True, True, 0.3);
    ksLoadingIndicator1.ShowLoading;
    Application.ProcessMessages;

    DmClient.RESTRequest1.ResetToDefaults;
    DmClient.RESTResponse1.ResetToDefaults;

    DmClient.RESTRequest1.Resource := 'v1/usuario/{usuarioid}';
    DmClient.RESTRequest1.Params.AddUrlSegment('usuarioid', EdtUsuarioCtrlSeg.Text);
    DmClient.RESTRequest1.Method := TRESTRequestMethod.RmGet;
    DmClient.RESTRequest1.Execute;
    if DmCLient.RESTResponse1.StatusCode in [ 200, 201] then Begin
       jArray := DmClient.RESTResponse1.JSONValue as TJSONArray;
       if (jArray.Count<1) or (jArray.Items[0].TryGetValue<String>('Erro', vErro)) then Begin
          if Sender=EdtUsuarioCtrlSeg then
             LblUsuarioAut.Text := '...'
          Else Begin
            EdtUsuarioCtrlSeg.Text := '';
            EdtSenhaCtrlSeg.Text   := '';
          End;;
          DelayedSetFocus(EdtUsuarioCtrlSeg);
          ksLoadingIndicator1.HideLoading;ksLoadingIndicator1.HideLoading;
          if Sender = BtnLogIn then
             MsgErroAlerta('Usuário/Senha Inválido!!!');
          Exit;
       End;
       if jArray.Items[0].GetValue<Integer>('usuarioid') = 0 then Begin
          EdtUsuarioCtrlSeg.Text := '';
          DelayedSetFocus(EdtUsuarioCtrlSeg);
          MsgErroAlerta('Usuário Inválido!!!');
          Exit;
       End
       Else if (jArray.Items[0].GetValue<Integer>('status') = 2) then Begin
          EdtUsuarioCtrlSeg.Text := '';
          DelayedSetFocus(EdtUsuarioCtrlSeg);
          ksLoadingIndicator1.HideLoading;
          MsgErroAlerta('Acesso negado! Usuário inativo.');
          Exit;
       End;
       LblUsuarioAut.Text := jArray.Items[0].GetValue<String>('nome');
       if (Sender = BtnLogIn) then Begin
          if (MD5Texto(EdtSenhaCtrlSeg.Text) = jArray.Items[0].GetValue<String>('senha'))  then Begin
             ObjUsuarioCtrl := TusuarioCtrl.Create();
             ObjUsuarioCtrl.ObjUsuario.UsuarioId := jArray.Items[0].GetValue<Integer>('usuarioid');
             ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId := jArray.Items[0].GetValue<Integer>('perfilid');
             If ObjUsuarioCtrl.AcessoFuncionalidade(funcaoParaAutorizar) then Begin
                PermitirAcessoCtrlSeg;
             End
             Else Begin
               ShowErro('Autorização negada!');
               EdtUsuarioCtrlSeg.Text := '';
               EdtSenhaCtrlSeg.Text   := '';
               LblUsuarioAut.Text     := '';
               DelayEdSetFocus(EdtusuarioCtrlSeg);
             End;
             ObjusuarioCtrl.DisposeOf;
          End
          Else
             ShowErro('Usuário/Senha inválido!');
       End;
    End
    Else Begin
       LblUsuarioAut.Text := '...';
       MsgErroAlerta('Ocorreu um erro no servidor. Tente novamente!');
       EdtUsuarioCtrlSeg.Text := '';
       EdtSenhaCtrlSeg.Text   := '';
       DelayedSetFocus(EdtUsuarioCtrlSeg);
       ksLoadingIndicator1.HideLoading;
       Exit;
    End;
  Except on E : Exception do Begin
    LblUsuarioAut.Text     := '';
    EdtUsuarioCtrlSeg.Text := '';
    EdtSenhaCtrlSeg.Text   := '';
    DelayedSetFocus(EdtUsuarioCtrlSeg);
    ksLoadingIndicator1.HideLoading;
    jArray := Nil;
    MsgErroAlerta('Erro:('+DmCLient.RESTResponse1.StatusCode.ToString()+') '+E.Message);
    Exit;
    End;
  End;
  jArray := Nil;
  ksLoadingIndicator1.HideLoading;
end;

procedure TFrmBase.HideLoading;
begin
  FrmeXactWMS.ksLoadingIndicator1.LoadingText.Text := 'Processando!!!';
  FrmeXactWMS.ksLoadingIndicator1.HideLoading;
//  TLoading.Hide;
End;

procedure TFrmBase.Limpar;
begin
  if (QryListaPadrao.Active) then Begin
     QryListaPadrao.EmptyDataSet;
     QryListaPadrao.FieldDefs.Clear;
     QryListaPadrao.Close;
  End;
  LstPrincipal.Items.Clear;
  CbCampoPesq.ItemIndex := 0;
end;

procedure TFrmBase.LstPrincipalGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  //if EventInfo.GestureID = sgiLeft Then
  //   PgcPrincipal.ActiveTab := TabDetalhes;
end;

procedure TFrmBase.MensagemStand(vMens: String);
begin
//Tocar Som
//https://delphiandroid.wordpress.com/2016/09/06/tocar-um-som-de-alerta-beep-em-delphi-xe7-plataforma-android/

  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Informação:';
  MsgD.Text       := vMens;
  MsgD.ActionOk   := Ac_Ok;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;

  //DelayEdSetFocus(MsgD.EditFocus);

  //MsgD.TEditFocus.Visible := False;

Exit;

  MessageDlg(vMens, TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbOK], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = mrYes then
        Else Begin
        End;
      end
  );
end;

function TFrmBase.NewCode: String;
begin
//
end;

procedure TFrmBase.PthBtnOnOff(pSetar: Boolean);
Begin
//  BtnAdd.Visible    := False;
//  BtnEdit.Visible   := False;
//  BtnDel.Visible    := False;
//  BtnSave.Visible   := False;
//  BtnCancel.Visible := False;

  BtnAdd.Enabled    := pSetar;
  BtnEdit.Enabled   := pSetar;
  BtnDel.Enabled    := pSetar;
  BtnSave.Enabled   := Not pSetar;
  BtnCancel.Enabled := Not pSetar;
  if BtnAdd.Enabled then
     PthBtnAdd.Fill.Color := TAlphaColorRec.Chocolate
  Else PthBtnAdd.Fill.Color := TAlphaColorRec.Darkgray;
  if BtnEdit.Enabled then
     PthBtnEdit.Fill.Color := TAlphaColorRec.Chocolate
  Else PthBtnEdit.Fill.Color := TAlphaColorRec.Darkgray;
  if BtnDel.Enabled then
     PthBtnDel.Fill.Color := TAlphaColorRec.Chocolate
  Else PthBtnDel.Fill.Color := TAlphaColorRec.Darkgray;
  if BtnSave.Enabled then
     PthBtnSave.Fill.Color := TAlphaColorRec.Chocolate
  Else PthBtnSave.Fill.Color := TAlphaColorRec.Darkgray;
  if BtnCancel.Enabled then
     PthBtnCancel.Fill.Color := TAlphaColorRec.Chocolate
  Else PthBtnCancel.Fill.Color := TAlphaColorRec.Darkgray;
  BtnArrowLeft.Enabled  := pSetar;
  BtnArrowRigth.Enabled := pSetar;;
  if BtnArrowLeft.Enabled then
     PthArrowLeft.Fill.Color := TAlphaColorRec.Chocolate
  Else PthArrowLeft.Fill.Color := TAlphaColorRec.Darkgray;
  if BtnArrowRigth.Enabled then
     PthArrowRight.Fill.Color := TAlphaColorRec.Chocolate
  Else PthArrowRight.Fill.Color := TAlphaColorRec.Darkgray;

{  if Not pSetar then Begin
     BtnArrowLeft.Action  := Nil;
     BtnArrowRigth.Action := Nil;
  End
  Else Begin
     BtnArrowLeft.Action  := ChgTabLista;
     BtnArrowRigth.Action := ChgTabDet;
  End;
}
  Exit;

  BtnAdd.Visible    := pSetar;
  BtnEdit.Visible   := pSetar;
  BtnDel.Visible    := pSetar;
  BtnSave.Visible   := Not pSetar;
  BtnCancel.Visible := Not pSetar;
//  PthBtnAdd.Fill.Color := TAlphaColorRec.ColorToRGB($FF1ED249);
end;

procedure TFrmBase.PthCloseAutClick(Sender: TObject);
begin
  AnimaAutorizacao.Inverse := true;
  AnimaAutorizacao.Enabled    := True;
  AnimaAutorizacao.Start;
  EdtUsuarioCtrlSeg.Text := '';
  EdtSenhaCtrlSeg.Text   := '';
  BlockFuncaoAutorizacao;
end;

procedure TFrmBase.PermitirAcessoCtrlSeg;
begin
  EdtUsuarioCtrlSeg.Text := '';
  EdtSenhaCtrlSeg.Text   := '';
  AnimaAutorizacao.Inverse := true;
  AnimaAutorizacao.Start;
  MsgSucesso('Acesso autorizadao!');
  LiberarFuncaoBloqueada;
end;

function TFrmBase.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  Result := False;
end;

procedure TFrmBase.PgcPrincipalChange(Sender: TObject);
begin
  if (PgcPrincipal.ActiveTab = TabLista) then Begin//and (BtnSave.Visible) then
     CbCampoPesq.Enabled := True;
     GetListaLstCadastro
  End;
//      PgcPrincipal.ActiveTab := TabDetalhes;
end;

procedure TFrmBase.PgcPrincipalGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
//  if EventInfo.GestureID = sgiRight Then
//     PgcPrincipal.ActiveTab := TabLista
//  Else if EventInfo.GestureID = sgiLeft Then
//     PgcPrincipal.ActiveTab := TabDetalhes;
end;

procedure TFrmBase.PgcPrincipalTap(Sender: TObject; const Point: TPointF);
begin
//   ShowErro('Evento TAP acionado');
end;

Procedure TFrmBase.PressCancelamento;
begin
  if BtnCancel.Enabled then Begin
     PthBtnOnOff(True);
     ClearField;
  End;
end;

procedure TFrmBase.PressionouMenu;
begin
  if (PgcPrincipal.ActiveTab = TabLista) then
     FrmeXactWMS.MultiView1.ShowMaster;
End;

procedure TFrmBase.PressionouVoltar;
begin
  if PgcPrincipal.ActiveTab <> TabLista then
     ChgTabLista.Execute
//    PgcPrincipal.Previous();
end;

procedure TFrmBase.ProcessarGETErro(Sender: TObject);
begin
  if Assigned(Sender) and (Sender is Exception) then
      showmessage(Exception(Sender).Message);
end;

function TFrmBase.SalvarReg: Boolean;
begin
  Result := False;
end;

procedure TFrmBase.SetAtivoOnOff(pOnOff: Boolean);
begin
  if pOnOff then Begin
     CircleStatus.Fill.Color := TAlphaColorRec.Green;
     LblAtivo.Text := 'Ativo';
  End
  Else Begin
     CircleStatus.Fill.Color := TAlphaColorRec.Red;
     LblAtivo.Text := 'Inativo';
  End;
end;

procedure TFrmBase.SetCampoDefault(pCampoDefault : String);
begin
  CampoDefault := pCampoDefault;
end;

procedure TFrmBase.ShowDados;
begin
  //EnabledButtons := True;
  PgcPrincipal.ActiveTab:= Tabdetalhes;
end;

Procedure TFrmBase.ShowErro(pMensagem: string = ''; pArqSound : String = 'notfound');
begin
  LblMsg01ShowErro.Text    := pMensagem;
  LblMsg02ShowErro.Text    := '';
  {$IfDef Android}
    LblVersaoErro.Text   := 'Versão: '+VersaoAPK;
  {$Endif}
  {$IfDef MSWINDOWS}
    LblVersaoErro.Text   := 'Versão: '+Versao('eXactWmsMobile.exe');
  {$EndIf}
  AnimaShowErro.Inverse    := False;
  LytShowErro.Position.X   := Width + 20;
  LytShowErro.Visible      := True;
  FocusActual              := ActiveControl;
  ActiveControl            := Nil;
  AnimaShowErro.StartValue := Width + 20;
  AnimaShowErro.StopValue  := 0;
  AnimaShowErro.Enabled    := True;
  AnimaShowErro.Start;
  TThread.CreateAnonymousThread(procedure begin
      FrmeXactWMS.PlaySound(pArqSound+'.wav');
  end).Start;
end;

procedure TFrmBase.ShowOk(pMensagem: String; pSom : String);
begin
  TThread.CreateAnonymousThread(procedure begin
    TThread.Synchronize(nil, procedure
    begin
      FrmeXactWMS.PlaySound(pSom+'.wav');
      TLoading.ToastMessage(FrmeXactWMS, pMensagem, TAlignLayout.Top, CorToastSucesso);
    End);
  end).Start;
end;

procedure TFrmBase.ShowLoading;
begin
  FrmeXactWMS.ksLoadingIndicator1.ShowLoading;
//  TLoading.Show(TFrmBase, 'Pesquisando');
end;

procedure TFrmBase.ShowMSG(pMensagem, pSom: String);
begin
  TThread.CreateAnonymousThread(procedure begin
    TThread.Synchronize(nil, procedure
    begin
      FrmeXactWMS.PlaySound(pSom+'.wav');
      TLoading.ToastMessage(FrmeXactWMS, pMensagem, TAlignLayout.Top, CorToastAlerta);
      AtivaCampoDefault;
    End);
  end).Start;

end;

procedure TFrmBase.SpbBackClick(Sender: TObject);
begin
  Hide;
end;

procedure TFrmBase.BtnSaveClick(Sender: TObject);
begin
  If SalvarReg then Begin
     PthBtnOnOff(True);
     ClearField;
  End;
end;

procedure TFrmBase.BtnSearchPesqClick(Sender: TObject);
begin
  if (EdtConteudoPesq.Text = '') then begin
     ShowErro('Informe o conteúdo para pesquisa!');
     DelayEdSetFocus(EdtConteudoPesq);
     Exit;
  End;
  if ((CbCampoPesq.ItemIndex < 0) and (CbCampoPesq.Visible)) or (EdtConteudoPesq.Text = '') then begin
     ShowErro('Informe o conteúdo para pesquisa!');
     DelayEdSetFocus(EdtConteudoPesq);
     Exit;
  End;
  If Not PesquisarComFiltro(CbCampoPesq.ItemIndex, EdtConteudoPesq.Text) then
     raise Exception.Create(MsgPesquisaNaoEntrada);
end;

//https://www.youtube.com/watch?v=NL5X26LeuWM
procedure TFrmBase.BtnTecladoClick(Sender: TObject);
Var FService : IFMXVirtualKeyboardService;
begin
  if VKAutoShowMode = TVKAutoShowMode.Never then Begin
     vKAutoShowMode := TVKAutoShowMode.DefinedBySystem; // Always
     TPlatformServices.Current.SupportsPlatformService(IFmxVirtualKeyboardService, IInterface(FService));
     if FService <> Nil then
        FService.ShowVirtualKeyboard(TControl(Screen.FocusControl));
     PthBtnTeclado.Fill.Color   := TAlphaColorRec.Chocolate;
  End
  Else Begin
     VKAutoShowMode := TVKAutoShowMode.Never;
     TPlatformServices.Current.SupportsPlatformService(IFmxVirtualKeyboardService, IInterface(FService));
     if FService <> Nil then
        FService.HideVirtualKeyboard;
     PthBtnTeclado.Fill.Color   := TAlphaColorRec.Gray;
  End;

  Exit;
  if VKAutoShowMode = TVKAutoShowMode.Never then Begin
    VKAutoShowMode := TVKAutoShowMode.DefinedBySystem; // Always
    PthBtnTeclado.Fill.Color   := TAlphaColorRec.Chocolate;
  End
  Else Begin
    VKAutoShowMode := TVKAutoShowMode.Never;
    PthBtnTeclado.Fill.Color   := TAlphaColorRec.Gray;
  End;
end;

procedure TFrmBase.SpeedButton2Click(Sender: TObject);
begin
  PgcPrincipal.Next();
end;

procedure TFrmBase.CalcContentBoundsProc(Sender: TObject;
                                       var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then begin
     ContentBounds.Bottom := Max(ContentBounds.Bottom,
                             2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFrmBase.CircMenuClick(Sender: TObject);
begin
  FrmeXactWMS.BrnMenuClick(Sender);
end;

procedure TFrmBase.UpdateKBBounds;
var LFocused   : TControl;
    LFocusRect : TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VertScrollBox1.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      LytBase.Align := TAlignLayout.Horizontal;
      VertScrollBox1.RealignContent;
      Application.ProcessMessages;
      VertScrollBox1.ViewportPosition :=
        PointF(VertScrollBox1.ViewportPosition.X,
               LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
     RestorePosition;
end;

procedure TFrmBase.RctBtnOkShowErroClick(Sender: TObject);
begin
  AnimaShowErro.Inverse := true;
  AnimaShowErro.Enabled := True;
  AnimaShowErro.Start;
  LytShowErro.Visible := False;
  AtivaCampoDefault;
end;

//https://www.youtube.com/watch?v=o9X1HFNjG3A&ab_channel=99Coders
procedure TFrmBase.RctBtnConfirmaClick(Sender: TObject);
begin
    LytButtonConfirmacao.Enabled := False;
    StartButtonAnimation(RctBtnConfirma, lbl_BtnConfirma, 'Enviando...', img_Confirma, AnimeConfirma);
    TThread.CreateAnonymousThread(procedure
    begin
        Try
          ConfirmacaoExecute; // Acesso a banco... acesso WS... etc
        Except

        End;
        TThread.Synchronize(nil, procedure
        begin
            StopButtonAnimation(RctBtnConfirma, lbl_BtnConfirma, img_Confirma,
                                AnimeConfirma, true);
            LytButtonConfirmacao.Enabled := True;
        end);

    end).Start;
end;

procedure TFrmBase.RctbtnCancelClick(Sender: TObject);
begin
  LytButtonConfirmacao.Enabled := False;
  StartButtonAnimation(RctBtnCancel, lbl_BtnCancel, 'Cancelando...',
                       img_Cancel, AnimeBtnCancel);

  TThread.CreateAnonymousThread(procedure
  begin
     ConfirmacaoCancel;
      TThread.Synchronize(nil, procedure
      begin
          StopButtonAnimation(RctBtnCancel, lbl_BtnCancel, img_Cancel,
                              AnimeBtnCancel, true);
          LytButtonConfirmacao.Enabled := True;
      end);

  end).Start;
end;

procedure TFrmBase.RestorePosition;
begin
  VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 0);
  LytBase.Align := TAlignLayout.Client;
  VertScrollBox1.RealignContent;
end;

Procedure TFrmBase.MsgErroAlerta(pMensagem : String);
Begin
    TThread.CreateAnonymousThread(procedure begin
       TThread.Synchronize(nil, procedure
       begin
         TLoading.Hide;
         TLoading.ToastMessage(Self, pMensagem, TAlignLayout.top, CorToastErro);
         if MediaPlayer1.State = TMediaState.Playing then
            MediaPlayer1.Stop;
         MediaPlayer1.Clear;
         {$IFDEF ANDROID}
            MediaPlayer1.FileName :=  System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'notfound.wav');
         {$Endif}
         {$IfDef MSWINDOWS}
            MediaPlayer1.FileName := GetCurrentDir+'\sound\notfound.wav';
         {$ENDIF}
         MediaPlayer1.Play;
       End);
     end).Start;
End;

procedure TFrmBase.MsgSucesso(pMensagem: string);
begin
   TThread.CreateAnonymousThread(procedure begin
       TThread.Synchronize(nil, procedure
       begin
         TLoading.Hide;
         TLoading.ToastMessage(Self, pMensagem, TAlignLayout.top, CorToastSucesso);
         if MediaPlayer1.State = TMediaState.Playing then
            MediaPlayer1.Stop;
         MediaPlayer1.Clear;
         {$IFDEF ANDROID}
            MediaPlayer1.FileName := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'toast4.wav');
         {$Endif}
         {$IfDef MSWINDOWS}
            MediaPlayer1.FileName := GetCurrentDir+'\sound\toast4.wav';
         {$ENDIF}
         MediaPlayer1.Play;
       End);
     end).Start;
end;

{ TMyReceiver }
{$IfDef Android}
constructor TMyReceiver.Create;
begin
  inherited;
end;

procedure TMyReceiver.onReceive(context: JContext; intent: JIntent);
var
  ldata: string;
begin
  ShowMessage('Retirar de FrmBase onReceive');
  ldata := JStringToString(intent.getStringExtra(StringToJString('data'))).Trim;
  if not ldata.IsEmpty then
  FrmBase.EdtCodigo.Text := lData;
//    MainForm.ListBox1.Items.Insert(0, ldata + ' - ' + FormatDateTime('hh:nn:ss', Now));
end;
{$Endif}

end.
