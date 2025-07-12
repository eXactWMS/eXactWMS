unit UFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtDlgs, Types,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, acImage, Vcl.Buttons, System.UITypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxBarBuiltInMenu, cxPC, dxGDIPlusClasses, acPNG, Vcl.Mask, JvExMask,
  JvToolEdit, JvDBControls, JvExStdCtrls, JvCheckBox, JvBaseEdits, JvCombobox,
  Vcl.DBCtrls, AdvUtil, AdvObj, BaseGrid, AdvGrid, AdvDropDown,
  AdvCustomGridDropDown, AdvGridDropDown, AdvLookupBar, AdvGridLookupBar,
  AsgLinks, AsgMemo, System.ImageList, Vcl.ImgList
  , AdvEdit, CListEd, ImagePicker, System.Threading, Themes, Vcl.Samples.Spin, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls
  , ACBrBase, ACBrETQ, ACBrDevice, System.TypInfo, IniFiles,
  dxCore, cxClasses, dxForms, cxContainer, cxEdit, dxCameraControl;

type
  TdxCameraControlAccess = class(TdxCameraControl);

  TGroupBox = class(vcl.StdCtrls.TGroupBox) //declare this before of your form definition
  public
    procedure Paint; override;
  end;

  TOperacaoCrud = (poNew, poEdit, poDelete, poSearch, poPrint);

  TFrmBase = class(TForm)
    PanWin8: TPanel;
    PgcBase: TcxPageControl;
    PnHeader: TPanel;
    LblForm: TLabel;
    BalloonHint1: TBalloonHint;
    EdtPesq: TLabeledEdit;
    ImgProtocolo: TImage;
    Timer2: TTimer;
    OpenPictureDialog1: TOpenPictureDialog;
    PnlImgObjeto: TPanel;
    BtnIncluir: TsImage;
    BtnExcluir: TsImage;
    BtnFechar: TsImage;
    BtnSalvar: TsImage;
    BtnCancelar: TsImage;
    DsPesqGeral: TDataSource;
    FdMemPesqGeral: TFDMemTable;
    BtnEditar: TsImage;
    BtnPesquisarStand: TsImage;
    BtnImprimirStand: TsImage;
    BtnExportarStand: TsImage;
    BtnExportarPDF: TsImage;
    BtnImportarStand: TsImage;
    TabListagem: TcxTabSheet;
    TabPrincipal: TcxTabSheet;
    el1: TAdvEditEditLink;
    el2: TColorComboEditLink;
    el3: TMemoEditLink;
    el5: TCheckEditLink;
    el4: TMoneyEditLink;
    el6: TImagePickerEditLink;
    LstCadastro: TAdvStringGrid;
    AdvGridLookupBar1: TAdvGridLookupBar;
    PnlInfo: TPanel;
    LblInfo02: TLabel;
    LblInfo10: TLabel;
    LblInfo08: TLabel;
    LblInfo11: TLabel;
    LblInfo12: TLabel;
    PnlPesquisaCadastro: TPanel;
    ImgListSimNao: TImageList;
    Label1: TLabel;
    CbCampoPesq: TComboBox;
    EdtConteudoPesq: TLabeledEdit;
    BtnPesqConsGeral: TsImage;
    ImgLogoRhemasys: TsImage;
    LblClearFilter: TLabel;
    TmErro: TTimer;
    PnlErro: TPanel;
    LblMensShowErro: TLabel;
    ShCadastro: TShape;
    ChkCadastro: TCheckBox;
    LblPaginacao: TLabel;
    SpPaginacao: TJvSpinEdit;
    TbFrameWeb: TcxTabSheet;
    TabimportacaoCSV: TcxTabSheet;
    DbgImporta: TDBGrid;
    PbImportaFile: TProgressBar;
    BtnOpeFile: TButton;
    BtnImport: TButton;
    RgTipoImportacao: TRadioGroup;
    EdtFileIimport: TEdit;
    LblArqImport: TLabel;
    BtnImportaFile: TBitBtn;
    LblAguardeImportacaoCSV: TLabel;
    LblImportaCSV: TLabel;
    MmImporta: TMemo;
    TmImportacaoCSV: TTimer;
    OpenTextFileDialog1: TOpenTextFileDialog;
    LblRegTit: TLabel;
    LblTotReg: TLabel;
    BtnPrinterSetup: TsImage;
    PnlConfigPrinter: TPanel;
    LblLanguagePrinter: TLabel;
    LblPortConfigPrinter: TLabel;
    BtnOkPrinter: TsImage;
    CbModeloConfigPrinter: TComboBox;
    CbPortaConfigPrinter: TComboBox;
    ACBrETQConfig: TACBrETQ;
    Panel7: TPanel;
    LblTitConfigPrinter: TLabel;
    ImgClose: TImage;
    ImgMinimize: TImage;
    ImgObjeto: TImage;
    ccCamera: TdxCameraControl;
    PnlBotImgObjeto: TPanel;
    BtnImage: TImage;
    BtnWebCam: TImage;
    BtnImageOnOff: TsImage;
    LblAlertaConfigPrinter: TLabel;
    FdMemImportaCSV: TFDMemTable;
    DsImportaCSV: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure LblFormMouseEnter(Sender: TObject);
    procedure LblFormMouseLeave(Sender: TObject);
    procedure PanLateralMouseEnter(Sender: TObject);
    procedure PanLateralMouseLeave(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnLat03Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLat02Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPesqEnter(Sender: TObject);
    procedure EdtPesqExit(Sender: TObject);
    procedure ConsGeralDblClick(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgMinimizeClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ImgLogoRhemasysClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnImageClick(Sender: TObject);
    procedure BtnWebCamClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure ConsGeralCellClick(Column: TColumn);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure TabListagemShow(Sender: TObject);
    procedure LstCadastroDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure PgcBaseChange(Sender: TObject);
    procedure BtnPesqConsGeralClick(Sender: TObject);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure LblClearFilterMouseEnter(Sender: TObject);
    procedure LblClearFilterMouseLeave(Sender: TObject);
    procedure LblClearFilterClick(Sender: TObject);
    procedure TmErroTimer(Sender: TObject);
    procedure ChkCadastroClick(Sender: TObject);
    procedure LstCadastroRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure EdtConteudoPesqExit(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
    procedure TmImportacaoCSVTimer(Sender: TObject);
    procedure BtnImportarStandClick(Sender: TObject);
    procedure BtnImportaFileClick(Sender: TObject);
    procedure LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstCadastroClick(Sender: TObject);
    procedure BtnOpeFileClick(Sender: TObject);
    procedure BtnOkPrinterClick(Sender: TObject);
    procedure BtnPrinterSetupClick(Sender: TObject);
    procedure FdMemPesqGeralAfterClose(DataSet: TDataSet);
    procedure BtnImportClick(Sender: TObject);
    procedure TabimportacaoCSVShow(Sender: TObject);
  private
    fActivated  : boolean;
    //fVideoImage : TVideoImage;
    CorGetAtual, CorGetExit : TColor;
    fVideoBitmap: TBitmap;
    Pin : Boolean;
    //FActiveForm: TForm;
    procedure PanLateralResize(ModSize: Integer);
    procedure ApplicationEvents2Exception(Sender: TObject; E: Exception);
    procedure CloseForm;
    procedure SetCaptions;
    procedure Initialize;
    procedure CameraStateChanged(Sender: TObject);
    { Private declarations }
  Protected
    EnabledButtons : Boolean;
    OperacaoCrud : TOperacaoCrud;
    Function Confirmacao(pMensagem1 : String = 'Confirme a Operação'; pMensagem2 : String = ''; Answer : Boolean = True) : Boolean;
    Function MensagemSis(pMensagem1 : String = 'Atenção:'; pMensagem2 : String = ''; pMensagem3 : String = ''; pMensagem4 : String = ''; Answer : Boolean = False; pErro : Boolean = False) : Boolean;
    Procedure ShowDados; Dynamic;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); Dynamic;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; Dynamic;
    Procedure LimpaField; Dynamic;
    Procedure Limpar; Dynamic;
    Function DeleteReg : Boolean; Dynamic;
    Procedure GetListaLstCadastro; Dynamic;
    Function SalvarReg : Boolean; Dynamic;
    Procedure Imprimir; Dynamic;
    Procedure OpenFileImport; Dynamic;
    Procedure ProcessarFileImport; Dynamic;
    Function SavePhoto : Boolean; Dynamic;
    Procedure AfterCancelar; Dynamic;
  public
    { Public declarations }
    FActiveForm: TForm;
    ArqFoto : AnsiString;
    ImageWeb : tMemoryStream;
    Module, ModuleMenu : String;
    vLastErro : String;
    //Form Pesquisa Base
    pbTitulo  : String;
    pbService : String;
    ResponsivoVideo : Real;
    //pbCampos  : TDictionary;
    function Alpha(Texto: String): Boolean;
    procedure EnterFocus(Sender: TObject);
    procedure ExitFocus(Sender: TObject);
    Procedure SetReadOnly;
    procedure ativarbotoes;
    Procedure ShowErro(pMensagem: String = ''; pFileSound : String = 'toast4');
    Procedure ShowOk(pMensagem : String = ''; pFileSound : String = 'ok');
    Procedure ShowMSG(pMensagem : String = ''; pFileSound : String = 'ok');
    function IfThen(AValue: Boolean; const ATrue, AFalse: String): String;
    function IfThenInt(AValue: Boolean; const ATrue, AFalse: Integer): Integer;
    Procedure MontarPaginacao(pRegistro : Integer);
    Procedure GetUrlFrameWeb(pUrl : String);
    Procedure ConfigPrinterEtq;
    Procedure ImprimirExportar(pOnOff : Boolean);
    Function ConfirmaManutencao(vAcao : String) : Boolean;
  end;

var
  FrmBase: TFrmBase;
  dxgCameraDialogBounds: TRect;

Const MsgPesquisaNaoEntrada = 'Não foram encontrados dados com os critérios definidos';
Const OperacaoNaoPermitida  = 'Operação não permitida. Pode ser que você não tenha acesso.';

implementation

//http://edn.embarcadero.com/article/33752 - Boa praticas
{$R *.dfm}

uses uFrmeXactWMS, UFrmConfirmacao, uFuncoes, Vcl.DialogMessage,
  UFrmMensagemSis, cxEditConsts, cxGeometry, ACBrETQClass;

procedure TFrmBase.BtnImageClick(Sender: TObject);
begin
//Pegar Modelo do RhemaChurras image
end;

procedure TFrmBase.BtnImportaFileClick(Sender: TObject);
begin
  FdMemPesqGeral.Close;
  if EdtFileIimport.Text <> '' then
     OpenTextFileDialog1.FileName := EdtFileIimport.Text+'.Csv';
  if OpenTextFileDialog1.Execute then begin
     EdtFileIimport.Text := OpenTextFileDialog1.FileName;
  End;
end;

procedure TFrmBase.BtnImportarStandClick(Sender: TObject);
begin
  LblAguardeImportacaoCSV.Caption := '';
  LblImportaCSV.Caption       := '';
  TabImportacaoCSV.TabVisible := True;
  PgcBase.ActivePage          := TabImportacaoCSV;
  EdtFileIimport.ReadOnly     := False;
  RgTipoImportacao.ItemIndex  := -1;
  EdtFileIimport.Clear;
end;

procedure TFrmBase.BtnImportClick(Sender: TObject);
begin
  if EdtFileIimport.Text = '' then Begin
     ShowErro('Informe o arquivo a ser importado!');
     Exit;
  End;
  if Not FileExists(EdtFileIimport.Text) then Begin
     ShowErro('Arquivo para Importacao não encontrado.');
     Exit;
  End;
  TDialogMessage.ShowWaitMessage('Aguarde!!! O Arquivo está sendo importado...',
    procedure
    Begin
      ProcessarFileImport;
    End);
end;

procedure TFrmBase.BtnImprimirStandClick(Sender: TObject);
begin
  //if ((Not BtnImprimirStand.Grayed) and (Sender=BtnImprimirStand)) then
     Imprimir;
     OperacaoCrud := poPrint;
end;

procedure TFrmBase.BtnIncluirClick(Sender: TObject);
begin
  if (TsImage(sender).Enabled=False) or (TsImage(sender).Grayed) then Exit; //  or (FrmDataReyLoja.VerAcesso(FrmDataReyLoja.CodMenu+'01') = false) then exit;
  //PnlMenuFormStand.Enabled := False;
  LblForm.Caption  := Module+'/'+ModuleMenu+FrmeXactWMS.ModuleOpcao+FrmeXactWMS.ModuleItem +' - Novo';
  ativarbotoes;
  //SetReadOnly;
  LimpaField;
  PgcBase.ActivePage  := TabPrincipal;
  ChkCadastro.Checked := True;
  OperacaoCrud := poNew;
end;

procedure TFrmBase.BtnExcluirClick(Sender: TObject);
begin
  If (TsImage(sender).Enabled=False) or (TsImage(sender).Grayed) then Exit;
  if Not (EnabledButtons) then
     raise Exception.Create('Você deve selecionar um registro.');
  PgcBase.ActivePage := TabPrincipal;
  if (ConfirmaManutencao('Del')) and (DeleteReg) then Begin
     LimpaField;
     TabListagemShow(LstCadastro);
     MessageDlg('Excluído com sucesso.', mtConfirmation, [MbOk], 0);
  End;
  OperacaoCrud := poDelete;
end;

procedure TFrmBase.BtnExportarStandClick(Sender: TObject);
begin
//  Result := True;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.IsEmpty) then
     raise Exception.Create('Não há dados para exportar!');
  if (BtnExportarStand.Grayed) or (FdMemPesqGeral.IsEmpty) then Exit;
  Try
    DsPesqGeral.DataSet := nil;
    ExportarExcel(FdMemPesqGeral);
    DsPesqGeral.DataSet := FdMemPesqGeral;
  Except
//    result := False;
    raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
  End;
end;

procedure TFrmBase.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmBase.BtnSalvarClick(Sender: TObject);
begin
  If (TsImage(sender).Enabled=False) or (TsImage(sender).Grayed) then Exit;
  If (ConfirmaManutencao('Upd')) then Begin
     TDialogMessage.ShowWaitMessage('Salvando as Informações...',
       procedure
       begin
         if (SalvarReg)  then Begin
            AtivarBotoes;
            LimpaField;
            //MessageDlg('Registro salvo com sucesso.', mtConfirmation, [MbOk], 0);
            GetListaLstCadastro;
            LblForm.Caption  := Module+'/'+ModuleMenu+FrmeXactWMS.ModuleOpcao+FrmeXactWMS.ModuleItem;
         End;
       end);
  End;
end;

procedure TFrmBase.BtnWebCamClick(Sender: TObject);
Var   DeviceList : TStringList;
begin
  If TdxCameraControlAccess(ccCamera).State in [ccsRunning, ccsPaused]then Begin
     ccCamera.Capture;
     ccCamera.Pause;
     ImgObjeto.picture.Assign(ccCamera.CapturedBitmap);
     ccCamera.CapturedBitmap.SaveToFile('Teste.Jpg');
     ccCamera.Visible  := False;
     ImgObjeto.Visible := True;
     dxgCameraDialogBounds := BoundsRect;
     ccCamera.Active   := False;
     SavePhoto();
     //ccCamera.Play;
  End
  Else Begin
    ccCamera.Visible  := true;
    ImgObjeto.Visible := False;
    SetCaptions;
    Initialize;
    ccCamera.Active   := True;
  End;
end;

procedure TFrmBase.BtnCancelarClick(Sender: TObject);
begin
  If (TsImage(sender).Enabled=False) or (TsImage(sender).Grayed) then Exit;
  If ConfirmaManutencao('Canc') then Begin
     AtivarBotoes;
     LimpaField;
     //MessageDlg('Cancelado alteração do registro.', mtConfirmation, [MbOk], 0);
     LblForm.Caption  := Module+'/'+ModuleMenu+FrmeXactWMS.ModuleOpcao+FrmeXactWMS.ModuleItem;
     AfterCancelar;
  End;
end;

procedure TFrmBase.FdMemPesqGeralAfterClose(DataSet: TDataSet);
begin
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  BtnExportarStand.Enabled := False;
  BtnExportarStand.Grayed  := True;
end;

procedure TFrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
//  if Assigned(FActiveForm) then Begin
//    //FActiveForm.Close;
//    FActiveForm := Nil;
//  End;
end;

procedure TFrmBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //CloseForm;
  if BtnCancelar.Enabled then Begin
     If ConfirmaManutencao('Canc') then Begin
        AtivarBotoes;
        LimpaField;
        LblForm.Caption  := Module+'/'+ModuleMenu+FrmeXactWMS.ModuleOpcao+FrmeXactWMS.ModuleItem;
        //CanClose := True;
     End
     Else CanClose := False;
  End;
end;

procedure TFrmBase.FormCreate(Sender: TObject);
begin
  if Screen.Width > 1366 then
     ResponsivoVideo := ((Screen.Width - 1366) / 1366)
  Else
     ResponsivoVideo := 0;
  TbFrameWeb.TabVisible := False;
  vLastErro   := '';
  CorGetAtual := $00D9FCD6;
  CorGetExit  := clWhite;
  FrmeXactWMS.Tempo  := 0;
  Pin         := False;
  PgcBase.ActivePage := TabListagem;
  Top    := Round(FrmeXactWMS.Top+FrmeXactWMS.PnlTopRhemaSys.Height);
  Left   := FrmeXactWMS.Left+FrmeXactWMS.MenuSplit.Width;
  Height := Round(FrmeXactWMS.Height-(FrmeXactWMS.PnlTopRhemaSys.Height+0));
  Width  := FrmeXactWMS.Width - (FrmeXactWMS.MenuSplit.Width+0);
  PgcBase.ActivePage := TabListagem;
  LimpaField;
  SetReadOnly;
  TabImportacaoCSV.TabVisible := False;
  ConfigPrinterEtq;
  LstCadastro.RowCount;
  OperacaoCrud := poSearch;
  //CbModeloConfigPrinter.ItemIndex := CbModeloConfigPrinter.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
  //CbPortaConfigPrinter.ItemIndex  := CbPortaConfigPrinter.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra);
end;

procedure TFrmBase.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  PnlInfo.Visible := False;
  Timer2.Enabled  := False;
  FrmeXactWMS.Tempo := 0;
//  if PgcBase.ActivePageIndex <> 0 then Exit;
  case Key Of
     //Vk_F2: if BtnIncluir.Enabled  then BtnIncluirClick(BtnIncluir);
     //Vk_F3: if BtnEditar.Enabled   then BtnEditarClick(BtnEditar);
     //Vk_F4: if BtnExcluir.Enabled  then BtnExcluirClick(BtnExcluir);
     //Vk_F5: if BtnFechar.Enabled   then ImgCloseClick(ImgClose);   //BtnFecharClick(BtnFechar);
     //Vk_F6: if BtnSalvar.Enabled   then BtnSalvarClick(BtnSalvar);
     //Vk_F7: If BtnCancelar.Enabled then BtnCancelarClick(BtnCancelar);
     13: Begin
           Key := 0;
           SelectNext(ActiveControl,True,True);
         End;
     27: Begin
           //If BtnIncluir.Enabled Then BtnFecharClick(BtnFechar);
         End;
     VK_F9:  if vLastErro <> '' then ShowErro(vLastErro);
     Vk_F10: BtnPesquisarStandClick(BtnPesquisarStand); //ConsGeral
     Vk_F12: BtnImprimirStandClick(BtnImprimirStand); //Relatorios
   end;
{   If (Key = 73) and (Shift = [ssAlt]) then BtnIncluirClick(Sender);
   If (Key = 69) and (Shift = [ssAlt]) then BtnEditarClick(Sender);
   If (Key = 70) and (Shift = [ssAlt]) then BtnFecharClick(Sender);
   If (Key = 67) and (Shift = [ssAlt]) then BtnCancelarClick(Sender);
   If (Key = 88) and (Shift = [ssAlt]) then BtnExcluirClick(Sender);
   If (Key = 83) and (Shift = [ssAlt]) then BtnSalvarClick(Sender);
}end;

procedure TFrmBase.FormResize(Sender: TObject);
begin
 exit;
  Top    := Round(FrmeXactWMS.Top+FrmeXactWMS.PnlTopRhemaSys.Height)+25;
  Left   := FrmeXactWMS.Left+FrmeXactWMS.MenuSplit.Width+5;
  Height := Round(FrmeXactWMS.Height-(FrmeXactWMS.PnlTopRhemaSys.Height+15));
  Width  := FrmeXactWMS.Width - (FrmeXactWMS.MenuSplit.Width+16);
end;

procedure TFrmBase.FormShow(Sender: TObject);
Var xComp : Integer;
begin
  //SetReadOnly;
  if PgcBase.ActivePage = TabListagem then
     EdtConteudoPesq.SetFocus;
  LblForm.Caption  := Module+'/'+ModuleMenu+FrmeXactWMS.ModuleOpcao+FrmeXactWMS.ModuleItem;
  PnlConfigPrinter.Left := BtnPrinterSetup.Left;
  PnlConfigPrinter.Top  := BtnPrinterSetup.Top + BtnPrinterSetup.Height + 30;
End;

procedure TFrmBase.GetListaLstCadastro;
begin
  PgcBase.ActivePage := TabListagem;
  EdtConteudoPesq.SetFocus;
end;

procedure TFrmBase.GetUrlFrameWeb(pUrl: String);
begin

end;

procedure TFrmBase.ImgMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmBase.Imprimir;
begin
//
end;

procedure TFrmBase.ImprimirExportar(pOnOff: Boolean);
begin
  Self.BtnImprimirStand.Grayed  := Not pOnOff;
  Self.BtnImprimirStand.Enabled := pOnOff;
  Self.BtnExportarStand.Grayed  := Not pOnOff;
  Self.BtnExportarStand.Enabled := pOnOff;
end;

procedure TFrmBase.Initialize;
begin
  if not cxRectIsEmpty(dxgCameraDialogBounds) then
  begin
    Position := poDesigned;
    BoundsRect := dxgCameraDialogBounds;
  end;

  //btnSnapshot.Enabled := TdxCameraControlAccess(ccCamera).State in [ccsRunning, ccsPaused];
  TdxCameraControlAccess(ccCamera).OnStateChanged := CameraStateChanged;
end;

procedure TFrmBase.ImgLogoRhemasysClick(Sender: TObject);
begin
//  if PnlInfo.Visible then Exit;
//  PnlInfo.Visible := Not PnlInfo.Visible;
//  Timer2.Enabled  := PnlInfo.Visible;
end;

function TFrmBase.IfThen(AValue: Boolean; const ATrue, AFalse: String): String;
begin
 if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TFrmBase.IfThenInt(AValue: Boolean; const ATrue,
  AFalse: Integer): Integer;
begin
 if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

procedure TFrmBase.ImgCloseClick(Sender: TObject);
begin
  if (BtnIncluir.Enabled) then Close;
end;

procedure TFrmBase.ConfigPrinterEtq;
var
  I : TACBrETQModelo ;
  J: TACBrETQDPI;
  K: TACBrETQUnidade;
  L: TACBrETQBackFeed;
  M: Integer;
  N: TACBrETQOrigem;
  O: TACBrETQPaginaCodigo;
  ArqIni : TIniFile;
  vTextoIni : String;
begin
  inherited;
  CbModeloConfigPrinter.Items.Clear ;
  For I := Low(TACBrETQModelo) to High(TACBrETQModelo) do
     CbModeloConfigPrinter.Items.Add( GetEnumName(TypeInfo(TACBrETQModelo), integer(I) ) ) ;
  if (CbmodeloConfigPrinter.Items.Count=0) then
     CbModeloConfigPrinter.Items.Add(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
  CbPortaConfigPrinter.Items.Clear;
  {$IfDef MSWINDOWS}
   ACBrETQConfig.Device.WinUSB.FindUSBPrinters();
   for M := 0 to ACBrETQConfig.Device.WinUSB.DeviceList.Count-1 do
     CbPortaConfigPrinter.Items.Add('USB:'+ACBrETQConfig.Device.WinUSB.DeviceList.Items[M].DeviceName);
  {$EndIf}
  if (Copy(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra, 1, 2) = '\\') or (CbPortaConfigPrinter.Items.Count=0) then
     CbPortaConfigPrinter.Items.Add(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra);
  CbPortaConfigPrinter.Items.Add(FrmeXactWMS.PathApp+'Relatorio\EtqVolume.Prn' );
  ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');

   If CbModeloConfigPrinter.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra) < 0 then
      CbModeloConfigPrinter.Items.Add(ArqIni.ReadString('PRINTER', 'EtqCodBarra_Modelo', FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra));
   If CbPortaConfigPrinter.Items.IndexOf(ArqIni.ReadString('PRINTER',  'EtqCodBarra_Porta' , FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra)) < 0 then
      CbPortaConfigPrinter.Items.Add(ArqIni.ReadString('PRINTER',  'EtqCodBarra_Porta', FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra));


  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra <> '' then Begin
     CbModeloConfigPrinter.ItemIndex := CbModeloConfigPrinter.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
     if CbModeloConfigPrinter.ItemIndex < 0 then

  End;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra<> '' then Begin
     CbPortaConfigPrinter.ItemIndex := CbPortaConfigPrinter.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra);

  End;
end;

function TFrmBase.Confirmacao(pMensagem1 : String; pMensagem2 : String; Answer : Boolean) : Boolean;
begin
  With TFrmConfirmacao.Create(Self) do Try
    Mensag1.Caption := pMensagem1;
    Mensag2.Caption := pMensagem2;
    ImgOk.Visible   := True;
    BtnOk.Visible         := Not Answer;
    PctSim.Visible        := Answer;
    LblConfirmSim.Visible := Answer;
    PctNao.Visible        := Answer;
    LblConfirmNao.Visible := Answer;
    If ShowModal = MrOk Then Begin
       Result := True;
       End
    Else Begin
       Result := False;
       //abort;
       Exit;
    End;
  Finally
    Free;
  end;
end;

function TFrmBase.ConfirmaManutencao(vAcao: String): Boolean;
begin
  Result := False;
  With TFrmConfirmacao.Create(Self) do Try
    If vAcao = 'Upd' Then
    Begin
      Mensag1.Caption := 'Salvar Dados';
      Mensag2.Caption := 'Todos os Dados serão salvos';
      ImgOk.Visible   := True;
    End
    Else if vAcao = 'Del' Then
    Begin
      Mensag1.Caption := 'Excluir Dados';
      Mensag2.Caption := 'Todos os dados serão apagados';
      ImgOk.Visible   := True;
    End
    Else if vAcao = 'Canc' then
    Begin
      Mensag1.Caption := 'Cancelar Digitação.';
      Mensag2.Caption := 'Os dados digitados serão perdidos...';
      ImgCancel.Visible   := True;
    End
    Else
      Exit;

    If ShowModal = MrOk Then Begin
       Result := True;
       End
    Else Begin
       Result := False;
       abort;
       Exit;
    End;
  Finally
    Free;
  end;
end;

procedure TFrmBase.ConsGeralCellClick(Column: TColumn);
begin
  if FdMemPesqGeral.IsEmpty then Exit;
  ShowDados;
end;

procedure TFrmBase.ConsGeralDblClick(Sender: TObject);
begin
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.IsEmpty) then Exit;
  BtnPesquisarStandClick(Sender);
  BtnEditarClick(BtnEditar);
end;

function TFrmBase.DeleteReg: Boolean;
begin
  Result := False;
end;

procedure TFrmBase.BtnLat02Click(Sender: TObject);
begin
  if Not BtnIncluir.Visible then Exit;
end;

procedure TFrmBase.BtnLat03Click(Sender: TObject);
begin
  if Not BtnIncluir.Visible then Exit;
end;

procedure TFrmBase.BtnOkPrinterClick(Sender: TObject);
var ArqIni: TIniFile;
begin
  inherited;
  ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.ini');
  try
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra := CbModeloConfigPrinter.Text;
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra  := CbPortaConfigPrinter.Text;
    ArqIni.WriteString('PRINTER', 'EtqCodBarra_Modelo', CbModeloConfigPrinter.Text);
    ArqIni.WriteString('PRINTER', 'EtqCodBarra_Porta',  CbPortaConfigPrinter.Text);
  finally
    FreeAndNil(ArqIni);
  end;

  Try
    with ACBrETQConfig do
    begin
       Desativar;
       DPI           := TACBrETQDPI(2);
       LimparMemoria := True;
       Temperatura   := 10;
       Velocidade    := -1;
       BackFeed      := TACBrETQBackFeed(-1);
       Unidade       := etqMilimetros; //etqDecimoDeMilimetros;
       MargemEsquerda:= 0;
       Origem        := TACBrETQOrigem(1); //cbOrigem.ItemIndex);
       PaginaDeCodigo:= TACBrETQPaginaCodigo(2);
       Porta         := CbPortaConfigPrinter.Text;
       Modelo        := TACBrETQModelo(CbModeloConfigPrinter.ItemIndex);
    end;
    ACBrETQConfig.Ativar;
    If Not ACBrETQConfig.Ativo Then
       ShowErro('Não foi possível Ativar a Impressora!');
    ACBrETQConfig.Desativar;
  Except
    ShowErro('Impressora de Código de Barras sem comunicação!');
    Exit;
  End;
  PnlConfigPrinter.Visible := False;
end;

procedure TFrmBase.BtnOpeFileClick(Sender: TObject);
Var I : Integer;
  Function GetValor(Linha : String): String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
//    inc(I);
    I := 1;
    While Linha[I] >= ' ' do
    begin
      If Linha[I] = ';' then // vc pode usar qualquer delimitador ... eu
        // estou usando o ";"
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;
begin
  if EdtFileIimport.Text = '' then Begin
     ShowErro('Informe o arquivo a ser importado!');
     Exit;
  End;
  if Not FileExists(EdtFileIimport.Text) then Begin
     ShowErro('Arquivo para Importacao não encontrado.');
     Exit;
  End;
  TDialogMessage.ShowWaitMessage('Aguarde!!! Abrindo o arquivo para importação...',
    procedure
    Begin
      OpenFileImport;
    End);
end;

procedure TFrmBase.BtnPesqConsGeralClick(Sender: TObject);
begin
  if (CbCampoPesq.ItemIndex < 0) or (EdtConteudoPesq.Text = '') then Exit;
  If Not PesquisarComFiltro(CbCampoPesq.ItemIndex, EdtConteudoPesq.Text) then
     raise Exception.Create(MsgPesquisaNaoEntrada);
end;

procedure TFrmBase.BtnPesquisarStandClick(Sender: TObject);
Var I : Integer;
    vWidth, vHeight : Integer;
begin
  If (TsImage(sender).Enabled=False) or (TsImage(sender).Grayed) or
     (Not BtnSalvar.Grayed) then Exit;
  PgcBase.ActivePage := TabListagem;
  OperacaoCrud := poSearch;
end;

procedure TFrmBase.BtnPrinterSetupClick(Sender: TObject);
begin
  PnlConfigPrinter.Visible := Not PnlConfigPrinter.Visible;
  //ConfigPrinterEtq;
end;

procedure TFrmBase.LblClearFilterClick(Sender: TObject);
begin
  LstCadastro.RowCount := 1;
  TabListagemShow(LstCadastro);
end;

procedure TFrmBase.LblClearFilterMouseEnter(Sender: TObject);
begin
  LblClearFilter.Font.Style := [fsItalic];
end;

procedure TFrmBase.LblClearFilterMouseLeave(Sender: TObject);
begin
  LblClearFilter.Font.Style := [];
end;

procedure TFrmBase.LblFormMouseEnter(Sender: TObject);
begin
  LblForm.Font.Style := [FsUnderline];
end;

procedure TFrmBase.LblFormMouseLeave(Sender: TObject);
begin
  LblForm.Font.Style := [];
end;

procedure TFrmBase.LimpaField;
Var xComp : Integer;
begin
  EnabledButtons := False;
  for xComp := 0 to ComponentCount -1 do Begin
//    ShowMessage('Componente: '+Components[xComp].Name);
    if (Components[xComp] is tJvDbComboEdit) then
       tJvDbComboEdit(Components[xComp]).Clear
    Else if (Components[xComp] is tJvComboEdit) then
       tJvComboEdit(Components[xComp]).Clear
    Else if (Components[xComp] is tComboBox) then
       tComboBox(Components[xComp]).ItemIndex := -1
    Else if (Components[xComp] is tJvComboBox) then
       TJvComboBox(Components[xComp]).ItemIndex := -1
    Else if (Components[xComp] is tEdit) then
       tEdit(Components[xComp]).Clear
    Else if (Components[xComp] is tJvCalcEdit) then
       tJvCalcEdit(Components[xComp]).Clear
    Else if (Components[xComp] is tJvCheckBox) then
       tJvCheckBox(Components[xComp]).Checked := False
    Else if (Components[xComp] is tJvDbCalcEdit) then
       tJvDbCalcEdit(Components[xComp]).Clear
    Else if (Components[xComp] is TJvDateEdit) then
       TJvDateEdit(Components[xComp]).Clear
    Else if (Components[xComp] is tRadioButton) then
       tRadioButton(Components[xComp]).Checked := False
    Else if (Components[xComp] is tRadioGroup) then
       tRadioGroup(Components[xComp]).ItemIndex := -1
    Else if (Components[xComp] is tMemo) then
       TMemo(Components[xComp]).Clear
    Else if (Components[xComp] is TLabelEdEdit) then
       TLabelEdEdit(Components[xComp]).Clear;
  end;
  Limpar;
end;

procedure TFrmBase.Limpar;
begin
  //Montar em Cada Form
  FdMemPesqGeral.Close;
  TabimportacaoCSV.TabVisible := False;
//Acrescentado em 01/09/2022
  BtnImprimirStand.Grayed := True;
  BtnExportarStand.Grayed := True;
  FdMemPesqGeral.Filter   := '';
  FdmemPesqGeral.Filtered := False;
  ImprimirExportar(False);
end;

procedure TFrmBase.LstCadastroClick(Sender: TObject);
begin
  LstCadastroClickCell(Sender, TAdvStringGrid(Sender).Row, 0);
end;

procedure TFrmBase.LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin  //and (aCol in [0, 1, 7])
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End
end;

procedure TFrmBase.LstCadastroDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if (Acol = 0) and (aRow > 0) then
     PesquisarClickInLstCadastro(aCol, aRow);
end;

procedure TFrmBase.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
begin
//Montar Em Cada Form
end;

procedure TFrmBase.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
//Montar Em Cada Form
end;

procedure TFrmBase.LstCadastroRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if LstCadastro.RowCount > 1 then
     LstCadastro.FixedRows := 1;
end;

function TFrmBase.MensagemSis(pMensagem1, pMensagem2, pMensagem3,
  pMensagem4: String; Answer, pErro : Boolean): Boolean;
begin
  With TFrmMensagemSis.Create(Self) do Try
    Mensag1.Caption := pMensagem1;
    Mensag2.Caption := pMensagem2;
    Mensag3.Caption := pMensagem3;
    Mensag4.Caption := pMensagem4;
    ImgOk.Visible   := True;
    BtnOk.Visible         := Not Answer;
    PctSim.Visible        := Answer;
    LblConfirmSim.Visible := Answer;
    PctNao.Visible        := Answer;
    LblConfirmNao.Visible := Answer;
    if pErro then
       Player('Alarme');
    If ShowModal = MrOk Then Begin
       Result := True;
       End
    Else Begin
       Result := False;
       //abort;
       Exit;
    End;
  Finally
    Free;
  end;
end;

procedure TFrmBase.MontarPaginacao(pRegistro : Integer);
Var xPag : Integer;
begin
  SpPaginacao.Value    := 1;
  SpPaginacao.Minvalue := 1;
  if (pRegistro Mod 2) > 0 then
     SpPaginacao.MaxValue := (pRegistro Div 2) + 1
  Else
     SpPaginacao.MaxValue := (pRegistro Div 2);
end;

procedure TFrmBase.OpenFileImport;
begin

end;

procedure TFrmBase.PanLateralMouseEnter(Sender: TObject);
begin
  PanLateralResize(1);
end;

procedure TFrmBase.PanLateralMouseLeave(Sender: TObject);
Var X : Integer;
begin
{
   if Not Pin then Exit;
   X := FrmRhemaWMS.GetMousePos(FrmDataReyLoja).X;
   If X > 170 then PanLateralResize(0);
}
end;

procedure Tfrmbase.PanLateralResize(ModSize : Integer);
begin
{
   if Not Pin then Exit;
   if ModSize = 1 then Begin
      PnlMenuFormStand.Width := 80;
      ConsGeral.Width   := Width-105;
      ConsGeral.Left    := 85;
      End
   Else Begin
      PanLateral.Width := 15;
      ConsGeral.Width   := Width-(PanLateral.Width+25);
      ConsGeral.Left    := (PanLateral.Width+5);;
  End
}
end;

procedure TFrmBase.PesquisarClickInLstCadastro(aCol, aRow : Integer);
begin
  if StrToInt64Def(LstCadastro.Cells[aCol, aRow], 0) > 0 then
     PgcBase.ActivePage := TabPrincipal;
end;

Function TFrmBase.PesquisarComFiltro(pCampo : Integer; PConteudo: String) : Boolean;
begin
  Result := False;
end;

procedure TFrmBase.PgcBaseChange(Sender: TObject);
begin
  if (PgcBase.ActivePageIndex <> 1) and ( BtnSalvar.Enabled) then
     PgcBase.ActivePageIndex := 1;
//  if (PgcBase.ActivePage = TabListagem) and (PgcBase.CanFocus) and (EdtConteudoPesq.CanFocus) then
//     EdtConteudoPesq.SetFocus;
   if Not (PgcBase.ActivePage = TbFrameWeb) then
      TbFrameWeb.TabVisible := False;
end;

procedure TFrmBase.ProcessarFileImport;
begin

end;

function TFrmBase.SalvarReg: Boolean;
begin
  Result := False;
end;

function TFrmBase.SavePhoto : Boolean;
begin
  Result := False;
{
declarar a uses EncdDecd e utilizar o método DecodeString
Memo3.Lines.Text := DecodeString(Memo1.Lines.Text);
}
end;

procedure TFrmBase.SetCaptions;
begin
  Caption := cxGetResourceString(@sdxCameraDialogCaption);
  //btnCancel.Caption := cxGetResourceString(@sdxCameraDialogCancel);
  //btnAssign.Caption := cxGetResourceString(@sdxCameraDialogAssign);
  //btnSnapshot.Caption := cxGetResourceString(@sdxCameraDialogPause);
end;

procedure TFrmBase.SetReadOnly;
Var xComp : Integer;
begin
  xComp := 0;
  for xComp := 0 to ComponentCount -1 do Begin
    if (Components[xComp] is tJvDbComboEdit) then tJvDbComboEdit(Components[xComp]).ReadOnly := Not tJvDbComboEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tJvComboEdit) then tJvComboEdit(Components[xComp]).ReadOnly := Not tJvComboEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tComboBox) then tComboBox(Components[xComp]).Enabled := Not tComboBox(Components[xComp]).Enabled
    Else if (Components[xComp] is tJvComboBox) then tJvComboBox(Components[xComp]).ReadOnly := Not tJvComboBox(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tRadioGroup) then tRadioGroup(Components[xComp]).Enabled := Not tRadioGroup(Components[xComp]).Enabled
    Else if (Components[xComp] is tEdit) then tEdit(Components[xComp]).ReadOnly := Not tEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tJvCalcEdit) then tJvCalcEdit(Components[xComp]).ReadOnly := Not tJvCalcEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tJvCheckBox) then tJvCheckBox(Components[xComp]).ReadOnly := Not tJvCheckBox(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tCheckBox) then tCheckBox(Components[xComp]).Enabled := Not tCheckBox(Components[xComp]).Enabled
    Else if (Components[xComp] is tJvDbCalcEdit) then tJvDbCalcEdit(Components[xComp]).ReadOnly := Not tJvDbCalcEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tRadioButton) then tRadioButton(Components[xComp]).Enabled := Not tRadioButton(Components[xComp]).Enabled
    Else if (Components[xComp] is TJvDateEdit) then TJvDateEdit(Components[xComp]).ReadOnly := Not TJvDateEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tMemo) then TMemo(Components[xComp]).ReadOnly := Not TMemo(Components[xComp]).ReadOnly
    Else if (Components[xComp] is tMaskEdit) then TMaskEdit(Components[xComp]).ReadOnly := Not TMaskEdit(Components[xComp]).ReadOnly
    Else if (Components[xComp] is TLabelEdEdit) then TLabelEdEdit(Components[xComp]).ReadOnly := Not TLabelEdEdit(Components[xComp]).ReadOnly;
  end;
  CbCampoPesq.Enabled      := True;
  EdtConteudoPesq.ReadOnly := False;
end;

procedure TFrmBase.ShowDados;
begin
  EnabledButtons := True;
  PgcBase.ActivePage := TabPrincipal
end;

procedure TFrmBase.ShowErro(pMensagem: String = ''; pFileSound : String = 'toast4');
begin
  Application.ProcessMessages;
  PnlErro.Color   := $00AAAAFF;
  vLastErro       := '🤦🏼‍♂️'+pMensagem;
  LblMensShowErro.Caption := pMensagem;
  pnlErro.Visible := True;
  TmErro.Enabled  := True;
  Player(pFileSound);
  Application.ProcessMessages;
end;

procedure TFrmBase.ShowMSG(pMensagem, pFileSound: String);
begin
   Application.ProcessMessages;
  PnlErro.Color   := $0095FFFF;
  vLastErro       := pMensagem;
  LblMensShowErro.Caption := '🤷'+'Atenção: '+pMensagem;
  pnlErro.Visible := True;
  TmErro.Enabled  := True;
  Player(pFileSound);
  Application.ProcessMessages;
end;

procedure TFrmBase.ShowOk(pMensagem: String = ''; pFileSound : String = 'ok');
begin
  PnlErro.Color   := $00FFCF9F;
  vLastErro       := '👍'+pMensagem;
  LblMensShowErro.Caption := pMensagem;
  pnlErro.Visible := True;
  TmErro.Enabled  := True;
  Player(pFileSound);
end;

procedure TFrmBase.BtnEditarClick(Sender: TObject);
begin
  if (TsImage(sender).Enabled=False) or (FrmeXactWMS.VerAcesso(FrmeXactWMS.CodMenu+'02') = false) Or
     (TsImage(Sender).Grayed) then exit;
  if Not (EnabledButtons) then
     raise Exception.Create('Você deve selecionar um registro.');
  PgcBase.ActivePage := TabPrincipal;
  LblForm.Caption  := Module+'/'+ModuleMenu+FrmeXactWMS.ModuleOpcao+FrmeXactWMS.ModuleItem +' - Editar';
//  PnlMenuFormStand.Enabled := False;
  ativarbotoes;
  //SetReadOnly;
  PgcBase.ActivePage := TabPrincipal;
  OperacaoCrud := poEdit;
end;

procedure TFrmBase.TabimportacaoCSVShow(Sender: TObject);
begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.Close;
  End;
  FdMemPesqGeral.FieldDefs.Clear;
end;

procedure TFrmBase.TabListagemShow(Sender: TObject);
begin
  TDialogMessage.ShowWaitMessage('Buscando Dados...',
    procedure
    begin
      CbCampoPesq.ItemIndex := 0;
      EdtConteudoPesq .Text := '';
      Limpar;
      TabPrincipalShow(Sender);

      GetListaLstCadastro;
      if Assigned(LstCadastro) then
         LblTotReg.Caption := Pred(LstCadastro.RowCount).ToString();
    End);
end;

procedure TFrmBase.TabPrincipalShow(Sender: TObject);
begin
  //ImgProtocolo.Visible  := PgcBase.ActivePage = TabListagem;
  //EdtPesq.Visible       := PgcBase.ActivePage = TabListagem;
end;

procedure TFrmBase.Timer2Timer(Sender: TObject);
begin
  PnlInfo.Visible := Not PnlInfo.Visible;
  Timer2.Enabled  := PnlInfo.Visible;
end;

procedure TFrmBase.TmErroTimer(Sender: TObject);
begin
  PnlErro.Enabled := False;
  PnlErro.Visible := False;
  TmErro.Enabled  := False;
end;

procedure TFrmBase.TmImportacaoCSVTimer(Sender: TObject);
begin
  Application.ProcessMessages;
  LblAguardeImportacaoCSV.Visible := not LblAguardeImportacaoCSV.Visible;
  LblAguardeImportacaoCSV.Caption := '';
  LblAguardeImportacaoCSV.Caption := 'AGUARDE!!!! Lendo o arquivo.  Reg.: '+FdMemPesqGeral.RecordCount.ToString;
  LblImportaCSV.Caption := '';//'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
end;

procedure tfrmbase.ativarbotoes;
begin
  BtnIncluir.Enabled  := Not BtnIncluir.Enabled;
  BtnEditar.Enabled   := Not BtnEditar.Enabled;
  BtnExcluir.Enabled  := Not BtnExcluir.Enabled;
  //BtnFechar.Enabled   := Not BtnFechar.Enabled;
  BtnSalvar.Enabled   := Not BtnSalvar.Enabled;
  BtnCancelar.Enabled := Not BtnCancelar.Enabled;
  BtnImportarStand.Enabled := BtnImportarStand.Enabled;
//  PnlMenuFormStand.Enabled := BtnIncluir.Enabled;
  BtnIncluir.Grayed  := Not BtnIncluir.Enabled;
  BtnEditar.Grayed   := Not BtnEditar.Enabled;
  BtnExcluir.Grayed  := Not BtnExcluir.Enabled;
  BtnSalvar.Grayed   := not BtnSalvar.Enabled;
  BtnCancelar.Grayed := not BtnCancelar.Enabled;
  BtnImportarStand.Grayed := Not BtnImprimirStand.Enabled;
  if BtnSalvar.Enabled then
     TabimportacaoCSV.TabVisible := False;
  if (BtnSalvar.Grayed) then
     OperacaoCrud := poSearch;
  SetReadOnly;
  TabListagem.TabVisible := Not BtnSalvar.Enabled;
end;

procedure TFrmBase.EdtConteudoPesqExit(Sender: TObject);
begin
  EdtConteudoPesq.Text := Trim(EdtConteudoPesq.Text);
end;

procedure TFrmBase.EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  If (Key=#13) then Begin
     EdtConteudoPesq.Text := Trim(EdtConteudoPesq.Text);
     Key := #0;
     BtnPesqConsGeralClick(BtnPesqConsGeral);
     EdtConteudoPesq.SetFocus;
  End;
  if CbCampoPesq.ItemIndex = 0 then SoNumeros(Key);
end;

procedure TFrmBase.EdtPesqEnter(Sender: TObject);
begin
  EnterFocus(Sender);
end;

procedure TFrmBase.EdtPesqExit(Sender: TObject);
begin
  ExitFocus(Sender);
end;

procedure Tfrmbase.EnterFocus(Sender: TObject);
begin
  If activecontrol is TEdit then Begin
     TEdit(Sender).Color := CorGetAtual;
     TEdit(Sender).Font.Style := [FsBold];
     End
  else if ActiveControl is TJvComboEdit then BEgin
     TJvComboEdit(Sender).Color := CorGetAtual;
     TJvComboEdit(Sender).Font.Style := [FsBold];
     End
  else if ActiveControl is TJvDateEdit then Begin
     TJvDateEdit(Sender).Color := CorGetAtual;
     TJvDateEdit(Sender).Font.Style := [FsBold];
     End
  Else if ActiveControl is TJvCalcEdit then Begin
     TJvCalcEdit(Sender).Color := CorGetAtual;
     TJvCalcEdit(Sender).Font.Style := [FsBold];
     End
  Else if ActiveControl is TLabeledEdit then Begin
     TLabeledEdit(Sender).Color := CorGetAtual;
     TLabeledEdit(Sender).Font.Style := [FsBold];
  End;
end;

procedure Tfrmbase.ExitFocus(Sender: TObject);
begin
  If activecontrol is TEdit then Begin
     TEdit(Sender).Color := CorGetExit;
     TEdit(Sender).Font.Style := [];
     End
  else if ActiveControl is TJvComboEdit then BEgin
     TJvComboEdit(Sender).Color := CorGetExit;
     TJvComboEdit(Sender).Font.Style := [];
     End
  else if ActiveControl is TJvDateEdit then Begin
     TJvDateEdit(Sender).Color := CorGetExit;
     TJvDateEdit(Sender).Font.Style := [];
     End
  Else if ActiveControl is TJvCalcEdit then Begin
     TJvCalcEdit(Sender).Color := CorGetExit;
     TJvCalcEdit(Sender).Font.Style := [];
     End
  Else if ActiveControl is TLabeledEdit then Begin
     TLabeledEdit(Sender).Color := CorGetExit;
     TLabeledEdit(Sender).Font.Style := [];
  End;
end;

procedure TFrmBase.AfterCancelar;
var teste : String;
begin
  teste := '';
  //
end;

function Tfrmbase.Alpha(Texto: String): Boolean;
var X : Integer;
begin
  Result := False;
  for X := 1 to Length(Texto) do Begin
      if Texto[X] in ['a'..'z','A'..'Z'] then Result := True;
  End;
end;

procedure Tfrmbase.ApplicationEvents2Exception(Sender: TObject; E: Exception);
var
  NomeDoLog: string;
  Arquivo: TextFile;
begin
  NomeDoLog := ChangeFileExt(Application.Exename, '.log');
  AssignFile(Arquivo, NomeDoLog);
  if FileExists(NomeDoLog) then
    Append(arquivo)
  else
    ReWrite(arquivo);
  try
    WriteLn(arquivo, ' Date: '+DateTimeToStr(Now));
    WriteLn(arquivo, ' Form: ' + Screen.activeForm.Caption+'  Unit.: '+E.UnitName+'   Classe.: '+ClassName  );
    WriteLn(arquivo, 'Scope: ' +E.UnitScope );
    WriteLn(arquivo, 'Exception: ' + E.Message );
    WriteLn(arquivo, '------------------------------------------- ');
    Application.ShowException(E);
  finally
    CloseFile(arquivo);
  end;
end;

procedure TFrmBase.CameraStateChanged(Sender: TObject);
begin
//
end;

procedure TFrmBase.ChkCadastroClick(Sender: TObject);
begin
  if ChkCadastro.Checked then Begin
     ShCadastro.Pen.Color := ClGreen;
     ShCadastro.Brush.Color := ClGreen;
  End
  Else Begin
    ShCadastro.Pen.Color   := ClRed;
    ShCadastro.Brush.Color := ClRed;
  End;
end;

procedure TFrmBase.CloseForm;
Var I : Integer;
    vWidth, vHeight : Integer;
    Var lThread : TThread;
begin
  OnResize := nil;
  vWidth  := Width;
  vHeight := Height;
  for I := 20 Downto 1 do Begin
    Width  := Trunc(vWidth  * ((I*5) / 100));
    Height := Trunc(vHeight * ((I*5) / 100));
   Repaint;
//    Application.ProcessMessages;
    //Sleep(1);
  End;
  Repaint;
  FrmeXactWMS.TrimAppMemorySize;
End;

{ TFuncao }


{Procedure TFrmPainelEntrada.CabecalhoGrid;
Var X : Int64;
Begin
  vDias := MonthDays[IsLeapYear(SpinEdit1.Value), ComboBox1.ItemIndex+1];
//  MonthDays[IsLeapYear(YearOf(Now)), MonthOfTheYear(Now)]
  With AdvStringGrid1 do Begin
    FixedCols := 1;
    AdvStringGrid1.ColWidths[0] := 5;
    FixedRows := 0;
    RowCount  := 9;
    ColCount  := vDias + 3;

    MergeCells(1,1,1,3);
    Cells[1,2] := #13+#13+'Notas';
    Cells[2,1] :=  NomeMes(ComboBox1.ItemIndex+1, 1)+'/'+Right(IntToStr(SpinEdit1.Value),2);
    Cells[2,2] := 'Recebido';
    Cells[2,3] := 'Conferido';

    MergeCells(1,4,1,2);
    Cells[1,4] := #13+#13+'Volumes';
    Cells[2,4] := 'Recebido';
    Cells[2,5] := 'Conferido';

    MergeCells(1,6,1,8);
    Cells[1,7] := #13+#13+'Unidades';
    Cells[2,6] := 'Recebido';
    Cells[2,7] := 'Conferido';

    Cells[2,8] := 'Eficiência';
  End;

  for X := 3 to AdvStringGrid1.colcount-1  do
    AdvStringGrid1.ColWidths[X] := 40; //Largura das Colunas Diaria

  AdvStringGrid1.ColCount := AdvStringGrid1.ColCount + 1;
  for X := 1 to vDias do Begin
    AdvStringGrid1.Cells[X+2,1]      := FormatFloat('00', X)+'-'+
                                        NomeDia(dayofweek(strtodate( FormatFloat('00', X)+'/'+IntToStr(ComboBox1.ItemIndex+1)+'/'+IntToStr(SpinEdit1.Value))), 3);  //Nome do dia
    AdvStringGrid1.Alignments[X+2,1] := TaCenter;
    AdvStringGrid1.Colors[X+2,1]     := ClGray;
    AdvStringGrid1.FontColors[X+2,1] := ClNavy;
    AdvStringGrid1.FontSizes[X+2,1] := 7;
  End;

  AdvStringGrid1.Cells[AdvStringGrid1.ColCount-1,1] := 'MÉDIA';
  AdvStringGrid1.Alignments[AdvStringGrid1.ColCount-1,1] := TaCenter;
  AdvStringGrid1.Colors[AdvStringGrid1.ColCount-1,1]     := ClGray;
  AdvStringGrid1.FontColors[AdvStringGrid1.ColCount-1,1] := ClNavy;
  for X := 2 to AdvStringGrid1.RowCount-1 do Begin
    AdvStringGrid1.Alignments[AdvStringGrid1.ColCount-1,X] := taRightJustify;
    AdvStringGrid1.Colors[AdvStringGrid1.ColCount-1,X]     := ClGray;
    AdvStringGrid1.FontColors[AdvStringGrid1.ColCount-1,X] := ClNavy;
  End;

  AdvStringGrid1.RowHeights[0] := 30;
  AdvStringGrid1.MergeRowCells(0, true);
  AdvStringGrid1.Cells[1,0]    := 'PAINEL LINX - VISÃO RECEBIMENTO DE MERCADORIAS';
  AdvStringGrid1.Colors[1, 0]  := $00B99D7F;
  AdvStringGrid1.Alignments[1,0] := taCenter;
  AdvStringGrid1.FontSizes[1,0]  := 14;
  AdvStringGrid1.FontStyles[1,0] := [FsBold, FsItalic];

  for X := 1 to AdvStringGrid1.RowCount-1 do Begin
      AdvStringGrid1.Colors[1 , X]  := ClGray;
     AdvStringGrid1.FontStyles[1,X] := [FsBold];
     AdvStringGrid1.FontSizes[1,X]  := 6;
     AdvStringGrid1.FontSizes[2,X]  := 6;
  End;
  AdvStringGrid1.Colors[2 , 1]   := ClGray;
  AdvStringGrid1.FontStyles[2,1] := [FsBold];
  AdvStringGrid1.FontStyles[2,8] := [FsBold];
  AdvStringGrid1.RowHeights[AdvStringGrid1.RowCount-1] := 20;
  AdvStringGrid1.ColWidths[1] := 45;
  AdvStringGrid1.ColWidths[2] := 45;
  AdvStringGrid1.ColWidths[AdvStringGrid1.ColCount-1] := 40;
End;}

{ TGroupBox }

procedure TGroupBox.Paint;
var
  H: Integer;
  R: TRect;
  Flags: Longint;
  CaptionRect,
  OuterRect: TRect;
  Size: TSize;
  Box: TThemedButton;
  Details: TThemedElementDetails;
begin
  inherited;
  with Canvas do
  begin
    Font := Self.Font;

    if ThemeControl(Self) then
    begin
      if Text <> '' then
      begin
        GetTextExtentPoint32(Handle, PChar(Text), Length(Text), Size);
        CaptionRect := Rect(0, 0, Size.cx, Size.cy);
        if not UseRightToLeftAlignment then
          OffsetRect(CaptionRect, 8, 0)
        else
          OffsetRect(CaptionRect, Width - 8 - CaptionRect.Right, 0);
      end
      else
        CaptionRect := Rect(0, 0, 0, 0);

      OuterRect := ClientRect;
      OuterRect.Top := (CaptionRect.Bottom - CaptionRect.Top) div 2;
      with CaptionRect do
        ExcludeClipRect(Handle, Left, Top, Right, Bottom);
      if Enabled then
        Box := tbGroupBoxNormal
      else
        Box := tbGroupBoxDisabled;
      Details := ThemeServices.GetElementDetails(Box);
      //Draw the themed frame
      ThemeServices.DrawElement(Handle, Details, OuterRect);
      SelectClipRgn(Handle, 0);
      if Text <> '' then
      begin
         H := TextHeight('0');
         if not UseRightToLeftAlignment then
           R := Rect(8, 0, 0, H)
         else
           R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
         Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
         //Now using the Windows.DrawText
         DrawText(Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
         Brush.Color := Color;//background color of the caption
         Font.Color := clRed;//the color of the caption.
         DrawText(Handle, PChar(Text), Length(Text), R, Flags);
      end;
    end
    else
    inherited;   //if the control is not themed then use the original paint method.
  end;
end;

{//No Object Inspector na propriedade Font coloque a cor verde.
procedure TForm1.RADIOGROUP1Click(Sender: TObject);
Var
  i : Integer;
begin
  // Para trocar as cores dos botoes do RadioGroup
  for i := 0 to RADIOGROUP1.Items.Count-1 do begin
  TRadioButton(RADIOGROUP1.Controls).Font.Color := clGreen;
  TRadioButton(RADIOGROUP1.Controls).Font.Style := [fsBold];
  end;
  TRadioButton(RADIOGROUP1.Controls[RADIOGROUP1.ItemIndex]).Font.Color := clRed;
  TRadioButton(RADIOGROUP1.Controls[RADIOGROUP1.ItemIndex]).Font.Style := [fsBold];
end;}

end.
