unit uFrmEnderecamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet, System.JSOn,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Generics.Collections,
  dxGDIPlusClasses, acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids,
  AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, JvToolEdit, JvBaseEdits, Vcl.Buttons,
  EnderecoCtrl, EnderecoClass, ProdutoCtrl, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase,
  ACBrETQ, dxCameraControl, EstoqueCtrl;

type
  TFrmEnderecamento = class(TFrmBase)
    EdtEnderecoId: TEdit;
    Label2: TLabel;
    EdtEndereco: TEdit;
    Label3: TLabel;
    lblEndereco: TLabel;
    EdtEstruturaId: TEdit;
    LblEstrutura: TLabel;
    Label4: TLabel;
    EdtRuaId: TEdit;
    LblRua: TLabel;
    Label6: TLabel;
    EdtZonaId: TEdit;
    LblZona: TLabel;
    Label5: TLabel;
    EdtArmazemId: TEdit;
    LblArmazem: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EdtPeso: TJvCalcEdit;
    EdtAltura: TJvCalcEdit;
    EdtLargura: TJvCalcEdit;
    EdtComprimento: TJvCalcEdit;
    EdtVolume: TJvCalcEdit;
    BtnPesqEstrutura: TBitBtn;
    BtnPesqRua: TBitBtn;
    BtnPesqZona: TBitBtn;
    BtnPesqArmazem: TBitBtn;
    TabManutencaoEndereco: TcxTabSheet;
    RgManutencao: TRadioGroup;
    PgcManutencao: TcxPageControl;
    TabManutencaoAtivaDesativa: TcxTabSheet;
    TabManutencaoMudarZona: TcxTabSheet;
    TabManutencaoCubagem: TcxTabSheet;
    TabManutencaoExcluir: TcxTabSheet;
    TabManutencaoTransferenciaPicking: TcxTabSheet;
    GbEnderecoAtivaDesativa: TGroupBox;
    Label13: TLabel;
    EdtEnderecoIniAtiva: TJvComboEdit;
    BtnSEndIniAtiva: TBitBtn;
    EdtEnderecoFinAtiva: TJvComboEdit;
    BtnSEndFinAtiva: TBitBtn;
    GbEnderecoMudarZona: TGroupBox;
    Label14: TLabel;
    EdtEnderecoIniMudarZona: TJvComboEdit;
    BtnSEndIniMudaZona: TBitBtn;
    EdtEnderecoFinMudarZona: TJvComboEdit;
    BtnSEndFinMudaZona: TBitBtn;
    GbEnderecoCubagem: TGroupBox;
    Label15: TLabel;
    EdtEnderecoIniCubagem: TJvComboEdit;
    BtnSEndIniCubagem: TBitBtn;
    EdtEnderecoFinCubagem: TJvComboEdit;
    BtnSEndFinCubagem: TBitBtn;
    GbEnderecoExcluir: TGroupBox;
    Label16: TLabel;
    EdtEnderecoIniExcluir: TJvComboEdit;
    BtnSEndIniExcluir: TBitBtn;
    EdtEnderecoFinExcluir: TJvComboEdit;
    BtnSEndFinExcluir: TBitBtn;
    TabManutencaoRemoverVinculo: TcxTabSheet;
    GroupBox5: TGroupBox;
    EdtPickingAtual: TJvComboEdit;
    BtnPesqPickingAtual: TBitBtn;
    Label17: TLabel;
    EdtProdutoVinculado: TEdit;
    LstManutencaoAtivaDesativa: TAdvStringGrid;
    Label18: TLabel;
    CbEstruturaAtivaDesativa: TComboBox;
    Label19: TLabel;
    EdtZonaIdAtivaDesativa: TJvComboEdit;
    BtnPesqZonaAtivaDesativa: TBitBtn;
    LblZonaAtivaDesativa: TLabel;
    ChkManutencaoAtivar: TCheckBox;
    ShManutencaoAtivar: TShape;
    Label21: TLabel;
    CbEstruturaMudarZona: TComboBox;
    EdtZonaIdMudarZona: TJvComboEdit;
    Label22: TLabel;
    BtnPesqZonaMudarZona: TBitBtn;
    LblZonaMudarZona: TLabel;
    Label20: TLabel;
    CbEstruturaCubagem: TComboBox;
    EdtZonaIdCubagem: TJvComboEdit;
    Label23: TLabel;
    BtnPesqZonaCubagem: TBitBtn;
    LblZonaCubagem: TLabel;
    Label24: TLabel;
    CbEstruturaExcluir: TComboBox;
    EdtZonaIdExcluir: TJvComboEdit;
    Label25: TLabel;
    BtnPesqZonaExcluir: TBitBtn;
    LblZonaExcluir: TLabel;
    LstManutencaoMudarZona: TAdvStringGrid;
    LstManutencaoCubagem: TAdvStringGrid;
    LstManutencaoExcluir: TAdvStringGrid;
    GroupBox6: TGroupBox;
    EdtPickingNovo: TJvComboEdit;
    BtnPesqPickingNovo: TBitBtn;
    LblPickingAtual: TLabel;
    LblPickingNovo: TLabel;
    SbSalvarAtivaDesativa: TPanel;
    ImgSbAtivaDesativa: TsImage;
    SbSalvarMudarZona: TPanel;
    ImgSbMudarZona: TsImage;
    SbSalvarCubagem: TPanel;
    ImgSbCubagem: TsImage;
    SbSalvarExcluir: TPanel;
    ImgSbExcluir: TsImage;
    SbSalvarTransferenciaPicking: TPanel;
    sImage5: TsImage;
    ImgSaveManut: TsImage;
    ImgPesqManut: TsImage;
    Label26: TLabel;
    ChkManutencaoDesativar: TCheckBox;
    ShManutencaoDesativar: TShape;
    EdtZonaIdNova: TJvComboEdit;
    Label27: TLabel;
    BtnPesqZonaMudarZonaNova: TBitBtn;
    LblZonaNova: TLabel;
    Label29: TLabel;
    GroupBox1: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    EdtPesoManutencao: TJvCalcEdit;
    EdtAlturaManutencao: TJvCalcEdit;
    EdtLarguraManutencao: TJvCalcEdit;
    EdtComprimentoManutencao: TJvCalcEdit;
    EdtVolumeManutencao: TJvCalcEdit;
    Label28: TLabel;
    EdtEstoquePicking: TEdit;
    TabManutencaoChoice: TcxTabSheet;
    Label8: TLabel;
    Label35: TLabel;
    CbEstruturaRemoverVinculo: TComboBox;
    Label36: TLabel;
    EdtZonaIdRemoverVinculo: TJvComboEdit;
    BtnPesqZonaRemoverVinculo: TBitBtn;
    LblZonaRemoverVinculo: TLabel;
    GbEnderecoRemoverVinculo: TGroupBox;
    Label38: TLabel;
    EdtEnderecoIniRemoverVinculo: TJvComboEdit;
    BtnSEndIniRemover: TBitBtn;
    EdtEnderecoFinRemoverVinculo: TJvComboEdit;
    BtnSEndFinRemover: TBitBtn;
    SbSalvarRemoverVinculo: TPanel;
    ImgSbRemoverVinculo: TsImage;
    LstManutencaoRemoverVinculo: TAdvStringGrid;
    LblTransferenciaEstoque: TLabel;
    TabCreateAddress: TcxTabSheet;
    Label37: TLabel;
    EdtRuaIdCe: TEdit;
    BtnPesqRuaCE: TBitBtn;
    LblRuaCE: TLabel;
    Label40: TLabel;
    EdtZonaIdCE: TEdit;
    BtnPesqZonaCE: TBitBtn;
    LblZonaCE: TLabel;
    Label42: TLabel;
    EdtArmazemIdCE: TEdit;
    BtnPesqArmazemCE: TBitBtn;
    LblArmazemCE: TLabel;
    Label44: TLabel;
    EdtEstruturaIdCE: TEdit;
    BtnPesqEstruturaCE: TBitBtn;
    LblEstruturaCE: TLabel;
    DbFaixaEnderecoCE: TGroupBox;
    Label46: TLabel;
    EdtFaixaInicialEndereco: TJvComboEdit;
    BtnPesqEnderecoInicialCE: TBitBtn;
    EdtFaixaFinalEndereco: TJvComboEdit;
    BtnPesqEnderecoFinalCE: TBitBtn;
    LstCreateAddress: TAdvStringGrid;
    PnlBlocoEnderecoCreate: TPanel;
    GroupBox4: TGroupBox;
    Label55: TLabel;
    EdtRuaInicialCE: TEdit;
    Label48: TLabel;
    EdtRuaFinalCE: TEdit;
    GroupBox7: TGroupBox;
    Label47: TLabel;
    Label56: TLabel;
    EdtPredioInicialCE: TEdit;
    EdtPredioFinalCE: TEdit;
    GroupBox8: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    EdtNivelInicialCE: TEdit;
    EdtNivelFinalCE: TEdit;
    GroupBox9: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    EdtAptoInicialCE: TEdit;
    EdtAptoFinalCE: TEdit;
    GroupBox10: TGroupBox;
    Label39: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label53: TLabel;
    EdtPesoCE: TJvCalcEdit;
    EdtAlturaCE: TJvCalcEdit;
    EdtLarguraCE: TJvCalcEdit;
    EdtComprimentoCE: TJvCalcEdit;
    EdtVolumeCE: TJvCalcEdit;
    SbSalvarCreateAddress: TPanel;
    ImgCreateAddress: TsImage;
    SbSimularCreateAddress: TPanel;
    ImgSimularCreateAddress: TsImage;
    FDMemCreateMultiploEndereco: TFDMemTable;
    FDMemCreateMultiploEnderecoEndereco: TStringField;
    FDMemCreateMultiploEnderecoAltura: TFloatField;
    FDMemCreateMultiploEnderecoLargura: TFloatField;
    FDMemCreateMultiploEnderecoComprimento: TFloatField;
    FDMemCreateMultiploEnderecoVolume: TFloatField;
    FDMemCreateMultiploEnderecoPeso: TFloatField;
    LblRegistroOnOff: TLabel;
    LblTotRegistroOnOff: TLabel;
    Label54: TLabel;
    LblTotRegistroMudarZona: TLabel;
    Label58: TLabel;
    LblTotRegistroCubagem: TLabel;
    Label60: TLabel;
    LblTotRegistroExcluir: TLabel;
    Label62: TLabel;
    LblTotRegistroRemoverPicking: TLabel;
    FDMemEnderecamentos: TFDMemTable;
    FDMemEnderecamentosEnderecoId: TIntegerField;
    FDMemEnderecamentosDescricao: TStringField;
    FDMemEnderecamentosAltura: TFloatField;
    FDMemEnderecamentosLargura: TFloatField;
    FDMemEnderecamentosComprimento: TFloatField;
    FDMemEnderecamentosVolume: TFloatField;
    FDMemEnderecamentosCapacidade: TFloatField;
    FDMemEnderecamentosStatus: TIntegerField;
    FDMemEnderecamentosEstruturaid: TIntegerField;
    FDMemEnderecamentosEstrutura: TStringField;
    FDMemEnderecamentosPickingFixo: TIntegerField;
    FDMemEnderecamentosMascara: TStringField;
    FDMemEnderecamentosRuaId: TIntegerField;
    FDMemEnderecamentosRua: TStringField;
    FDMemEnderecamentosLado: TStringField;
    FDMemEnderecamentosOrdem: TIntegerField;
    FDMemEnderecamentosZonaId: TIntegerField;
    FDMemEnderecamentosZona: TStringField;
    FDMemEnderecamentosEstoqueTipoId: TIntegerField;
    FDMemEnderecamentosProdutoSNGPC: TIntegerField;
    FDMemEnderecamentosArmazemId: TIntegerField;
    FDMemEnderecamentosArmazem: TStringField;
    FDMemEnderecamentosProdutoId: TIntegerField;
    FDMemEnderecamentosCodProduto: TIntegerField;
    FDMemEnderecamentosProduto: TStringField;
    FDMemEnderecamentosQtde: TIntegerField;
    FDMemEnderecamentosQtdePulmao: TIntegerField;
    FDMemEnderecamentosQtdeReserva: TIntegerField;
    FDMemEnderecamentosOcupacao: TFloatField;
    FDMemEnderecamentosCurva: TStringField;
    ChkBloquear: TCheckBox;
    ShBloquear: TShape;
    LblObs1RemVinculo: TLabel;
    EdtQtdeTransferencia: TEdit;
    Label57: TLabel;
    Label59: TLabel;
    EdtSaldoPicking: TEdit;
    ChkBloqueado: TCheckBox;
    ChkDesbloquear: TCheckBox;
    ShDesbloquear: TShape;
    Bevel1: TBevel;
    Bevel2: TBevel;
    TabQuebraRuaPicking: TcxTabSheet;
    GroupBox3: TGroupBox;
    Label61: TLabel;
    EdtEnderecoQRInicial: TJvComboEdit;
    BtnPesqEndInicialQR: TBitBtn;
    EdtEnderecoQRFinal: TJvComboEdit;
    BtnPesqEndFinalQR: TBitBtn;
    BtnSalvarQuebraRua: TPanel;
    ImgSaveQR: TsImage;
    LabelRuaQR: TLabel;
    EdtRuaIdQR: TEdit;
    BtnPesqRuaQR: TBitBtn;
    LblRuaQR: TLabel;
    Label65: TLabel;
    EdtZonaIdQR: TJvComboEdit;
    BtnPesqZonaQR: TBitBtn;
    LblZonaQR: TLabel;
    LstQuebraRua: TAdvStringGrid;
    EdtIntervaloAp: TEdit;
    Label63: TLabel;
    ChkBloqueioInventario: TCheckBox;
    FDMemEnderecamentosBloqueioInventario: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEnderecoIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEnderecoIdEnter(Sender: TObject);
    procedure EdtEstruturaIdExit(Sender: TObject);
    procedure EdtEnderecoIdExit(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEnderecoIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtAlturaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesqEstruturaClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure BtnPesqRuaClick(Sender: TObject);
    procedure BtnPesqArmazemClick(Sender: TObject);
    procedure EdtEstruturaIdChange(Sender: TObject);
    procedure EdtArmazemIdChange(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure EdtRuaIdChange(Sender: TObject);
    //procedure BtnOpeFileClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure RgManutencaoClick(Sender: TObject);
    procedure TabManutencaoEnderecoShow(Sender: TObject);
    procedure ChkManutencaoAtivarClick(Sender: TObject);
    procedure TabManutencaoAtivaDesativaShow(Sender: TObject);
    procedure BtnPesqZonaAtivaDesativaClick(Sender: TObject);
    procedure EdtZonaIdAtivaDesativaExit(Sender: TObject);
    procedure CbEstruturaAtivaDesativaClick(Sender: TObject);
    procedure EdtEnderecoIniAtivaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtEnderecoIniCubagemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtEnderecoIniExcluirKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SbSalvarExcluirClick(Sender: TObject);
    procedure ChkManutencaoDesativarClick(Sender: TObject);
    procedure LstManutencaoAtivaDesativaClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure EdtPickingAtualExit(Sender: TObject);
    procedure EdtPickingNovoExit(Sender: TObject);
    procedure EdtPickingAtualChange(Sender: TObject);
    procedure EdtPickingNovoChange(Sender: TObject);
    procedure PgcBaseChange(Sender: TObject);
    procedure EdtFaixaInicialEnderecoChange(Sender: TObject);
    procedure SbSimularCreateAddressClick(Sender: TObject);
    procedure SbSalvarCreateAddressClick(Sender: TObject);
    procedure EdtRuaInicialCEKeyPress(Sender: TObject; var Key: Char);
    procedure ChkBloquearClick(Sender: TObject);
    procedure ChkDesbloquearClick(Sender: TObject);
    procedure EdtEnderecoQRFinalChange(Sender: TObject);
    procedure EdtZonaIdQRChange(Sender: TObject);
    procedure EdtZonaIdMudarZonaChange(Sender: TObject);
    procedure EdtZonaIdAtivaDesativaChange(Sender: TObject);
    procedure EdtZonaIdCubagemChange(Sender: TObject);
    procedure EdtZonaIdExcluirChange(Sender: TObject);
    procedure EdtZonaIdRemoverVinculoChange(Sender: TObject);
    procedure EdtZonaIdCEChange(Sender: TObject);
    procedure EdtPesoExit(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabListagemShow(Sender: TObject);
  private
    { Private declarations }
    SelAtivaDesativa : Boolean;
    vMascaraEndereco : String;
    vEnderecoEdit    : String;
    Function GetListaEnderecos(pEnderecoId, pEstruturaId, pZonaId : Integer; pEnderecoIni, pEnderecoFin : String) : Boolean;
    Procedure DefineField;
    Procedure TabManutencaoOnOff(pTabVisible : Integer);
    Procedure GetEstrutura;
    Procedure GetEndereco(Sender: TObject; pLstManutencao : TAdvStringGrid);
    Procedure LimparLstManutencao;
    Procedure LimparManutencao;
    Procedure mostraSimulacaoEndereco;
    Procedure MostraCreateAddress;
    Procedure limparCreateAddress;
    Procedure ClearBlocoEnderecoCreate;
    Procedure HeaderLstManutencao(pLstManutencao : TAdvStringGrid);
    Procedure AtualizarTotal(pLstManutencao : TAdvStringGrid);
    Function CheckReserva(pEnderecoId : Integer) : Boolean;
    Procedure JsonToDataSet_ShowDados(pJsonArrayEndereco : TJsonArray);
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure Limpar; OverRide;
    procedure OpenFileImport; OverRide;
  public
    { Public declarations }
  end;

var
  FrmEnderecamento: TFrmEnderecamento;

implementation

{$R *.dfm}

uses uFuncoes, Views.Pequisa.EnderecamentoEstruturas,
  EnderecamentoEstruturaCtrl, Views.Pequisa.EnderecamentoZonas,
  EnderecamentoZonaCtrl, Views.Pequisa.EnderecamentoRuas, EnderecamentoRuaCtrl,
  Views.Pequisa.DesenhoArmazem, DesenhoArmazemCtrl, EnderecoEstruturaClass,
  EnderecamentoZonaClass, uFrmeXactWMS;
  //, DesenhoArmazemCtrl;

procedure TFrmEnderecamento.BtnPesqZonaAtivaDesativaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoZonas;
begin
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
          LblZonaAtivaDesativa.Caption := '';
          EdtZonaIdAtivaDesativa.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdAtivaDesativaExit(EdtZonaIdAtivaDesativa);
       End
       Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
          if Sender = BtnPesqZonaMudarZona then Begin
             LblZonaMudarZona.Caption := '';
             EdtZonaIdMudarZona.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
             EdtZonaIdAtivaDesativaExit(EdtZonaIdMudarZona);
          End
          Else if Sender = BtnPesqZonaMudarZonaNova then Begin
             LblZonaNova.Caption := '';
             EdtZonaIdNova.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
             EdtZonaIdAtivaDesativaExit(EdtZonaIdNova);
          End;
       End
       Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
          LblZonaCubagem.Caption := '';
          EdtZonaIdCubagem.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdAtivaDesativaExit(EdtZonaIdCubagem);
       End
       Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
          LblZonaExcluir.Caption := '';
          EdtZonaIdExcluir.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdAtivaDesativaExit(EdtZonaIdExcluir);
       End
       Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
          LblZonaRemoverVinculo.Caption := '';
          EdtZonaIdRemoverVinculo.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdAtivaDesativaExit(EdtZonaIdRemoverVinculo);
       End
       Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
          LblZonaQR.Caption := '';
          EdtZonaIdQR.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdAtivaDesativaExit(EdtZonaIdQR);
       End
    End;
  finally
    FrmPesquisaEnderecamentoZonas.Free;
  end;
end;

procedure TFrmEnderecamento.AtualizarTotal(pLstManutencao : TAdvStringGrid);
var xEndereco, xTotEndereco : Integer;
begin
  xTotEndereco := 0;
  for xEndereco := 1 to pLstManutencao.RowCount do Begin
    if pLstManutencao.Cells[10, xEndereco] = '1' then
       Inc(xTotEndereco);
  End;
  if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then
     LblTotRegistroOnOff.Caption := xTotEndereco.Tostring
  Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then
     LblTotRegistroMudarZona.Caption := xTotEndereco.Tostring
  Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then
     LblTotRegistroMudarZona.Caption := xTotEndereco.Tostring
  Else if PgcManutencao.ActivePage = TabManutencaoCubagem then
     LblTotRegistroCubagem.Caption := xTotEndereco.Tostring
  Else if PgcManutencao.ActivePage = TabManutencaoExcluir then
     LblTotRegistroExcluir.Caption := xTotEndereco.Tostring
  Else if PgcManutencao.ActivePage = TabManutencaoExcluir then
     LblTotRegistroExcluir.Caption := xTotEndereco.Tostring
  Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then
     LblTotRegistroRemoverPicking.Caption := xTotEndereco.Tostring;
end;

procedure TFrmEnderecamento.BtnEditarClick(Sender: TObject);
begin
  inherited;
  vEnderecoEdit := EdtEndereco.Text;
  EdtEndereco.ReadOnly := True;
  EdtEstruturaId.SetFocus;
end;

procedure TFrmEnderecamento.BtnImportClick(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonRetorno : TJsonObject;
    vErro :String;
begin
  inherited;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  FdMemPesqGeral.First;
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  While Not FdMemPesqGeral.Eof Do Begin
    ObjEnderecoCtrl.ObjEndereco.EnderecoId := 0;
    ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId := FdMemPesqGeral.FieldByName('EstruturaId').AsInteger;
    ObjEnderecoCtrl.ObjEndereco.EnderecoRua.RuaId             := FdMemPesqGeral.FieldByName('RuaId').AsInteger;
    ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId      := FdMemPesqGeral.FieldByName('ZonaId').AsInteger;
    ObjEnderecoCtrl.ObjEndereco.Descricao                     := FdMemPesqGeral.FieldByName('Endereco').AsString;
    ObjEnderecoCtrl.ObjEndereco.DesenhoArmazem.Id             := FdMemPesqGeral.FieldByName('ArmazemId').AsInteger;
    ObjEnderecoCtrl.ObjEndereco.Altura                        := FdMemPesqGeral.FieldByName('Altura').AsFloat;
    ObjEnderecoCtrl.ObjEndereco.Largura                       := FdMemPesqGeral.FieldByName('Largura').AsFloat;
    ObjEnderecoCtrl.ObjEndereco.Comprimento                   := FdMemPesqGeral.FieldByName('Comprimento').AsFloat;
    ObjEnderecoCtrl.ObjEndereco.Capacidade                    := FdMemPesqGeral.FieldByName('Capacidade').AsFloat;
    Try
      JsonRetorno := ObjEnderecoCtrl.Salvar;
      If JsonRetorno.TryGetValue('Erro', vErro) then Begin
         MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString+' - '+
                              FdMemPesqGeral.FieldByName('Endereco').AsString);
    End;
    Except On E: Exception do Begin
      MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString+' - '+
                              FdMemPesqGeral.FieldByName('Endereco').AsString);
      End;
    End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemPesqGeral.Next;
  End;
  ObjEnderecoCtrl.Free;
  ShowMessage('Importação concluída...');
end;

procedure TFrmEnderecamento.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtEndereco.ReadOnly := False;
  EdtEndereco.SetFocus;
end;

procedure TFrmEnderecamento.OpenFileImport;//BtnOpeFileClick(Sender: TObject);
var ArquivoCSV: TextFile;
    Linha : String;
    I : Integer;
    vAltura, vLargura, vComprimento, vCodProduto, pEndereco, vPicking, vErro : String;
    vEstruturaId : String;
//    JsonArrayProduto, JsonArrayEndereco : TJsonArray;
  Function GetValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
    inc(I);
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
  inherited;
  DefineField;
  if EdtFileIimport.Text = '' then
     raise Exception.Create('Informe o arquivo a ser importado!');
  if Not FileExists(EdtFileIimport.Text) then Begin
     ShowMessage('Arquivo para Importacao não encontrado.');
     Exit;
  End;
  AssignFile(ArquivoCSV, EdtFileIimport.Text);
  try
    TmImportacaoCSV.Enabled := True;
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);    //Pular Cabecalho
    while not Eoln(ArquivoCSV) do begin
      Readln(ArquivoCSV, Linha);
      I := 0;
      FdMemPesqGeral.Append;
      vEstruturaId := GetValor;
      if (UpperCase(vEstruturaId) = 'PULMAO') or (vEstruturaId = '1') then
         vEstruturaId := '1'
      Else If (UpperCase(vEstruturaId) = 'PICKING') or (vEstruturaId = '2') then
         vEstruturaId := '2';
      //Else If f (UpperCase(vEstruturaId) = 'SEGREGADO') or (vEstruturaId = 2) then
      //   vEstruturaId = 3;
      FdMemPesqGeral.FieldByName('EstruturaId').AsInteger := StrToInt64(vEstruturaId);
      FdMemPesqGeral.FieldByName('RuaId').AsInteger := StrToInt64(GetValor);
      FdMemPesqGeral.FieldByName('ZonaId').AsInteger := StrToInt64(GetValor);
      FdMemPesqGeral.FieldByName('Endereco').AsString := GetValor;
      FdMemPesqGeral.FieldByName('ArmazemId').AsInteger := StrToInt64(GetValor);
      FdMemPesqGeral.FieldByName('Altura').AsFloat := StrToFloat(GetValor);
      FdMemPesqGeral.FieldByName('Largura').AsFloat := StrToFloat(GetValor);
      FdMemPesqGeral.FieldByName('Comprimento').AsFloat := StrToFloat(GetValor);
      FdMemPesqGeral.FieldByName('Capacidade').AsFloat := StrToFloat(GetValor);
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmEnderecamento.BtnPesqArmazemClick(Sender: TObject);
var LForm: TFrmPesquisaDesenhoArmazem;
begin
  if (PgcBase.ActivePage = TabPrincipal) and  (Not (OperacaoCrud in [poNew, poEdit])) then Exit;
  if ((Sender=BtnPesqArmazem) and (EdtArmazemId.ReadOnly)) or
     ((Sender=BtnPesqArmazemCE) and (EdtArmazemIdCE.ReadOnly)) then Exit;
  inherited;
  //ShowForm(TFrmPesquisaLaboratorio, LForm);
  FrmPesquisaDesenhoArmazem := TFrmPesquisaDesenhoArmazem.Create(Application);
  try
    if (FrmPesquisaDesenhoArmazem.ShowModal = mrOk) then  Begin
       If (Sender=BtnPesqArmazem) then
          EdtArmazemId.Text := FrmPesquisaDesenhoArmazem.Tag.ToString()
       Else
          EdtArmazemIdCE.Text := FrmPesquisaDesenhoArmazem.Tag.ToString();
       EdtEstruturaIdExit(EdtArmazemId);
    End;
  finally
    FreeAndNil(FrmPesquisaDesenhoArmazem);
  end;
end;

procedure TFrmEnderecamento.BtnPesqEstruturaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoEstruturas;
begin
  if (PgcBase.ActivePage = TabPrincipal) and ( Not (OperacaoCrud in [poNew, poEdit])) then Exit;
  if ((Sender=BtnPesqEstrutura) and (EdtEstruturaId.ReadOnly)) Or
     ((Sender=BtnPesqEstruturaCE) and (EdtEstruturaIdCE.ReadOnly)) then Exit;
  inherited;
  //ShowForm(TFrmPesquisaLaboratorio, LForm);
  FrmPesquisaEnderecamentoEstruturas := TFrmPesquisaEnderecamentoEstruturas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoEstruturas.ShowModal = mrOk) then  Begin
       if (Sender=BtnPesqEstrutura) then Begin
          EdtEstruturaId.Text := FrmPesquisaEnderecamentoEstruturas.Tag.ToString();
          EdtEstruturaIdExit(EdtEstruturaId);
       End
       Else Begin
          EdtEstruturaIdCE.Text := FrmPesquisaEnderecamentoEstruturas.Tag.ToString();
          EdtEstruturaIdExit(EdtEstruturaIdCE);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoEstruturas);
  end;
end;

procedure TFrmEnderecamento.BtnPesqRuaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoRuas;
begin
  if (PgcBase.ActivePage = TabPrincipal) and (Not (OperacaoCrud in [poNew, poEdit])) then Exit;
  if ((Sender=BtnPesqRua) and (EdtRuaId.ReadOnly)) or
     ((Sender=BtnPesqRuaCe) and (EdtRuaIdCe.ReadOnly)) or
     ((Sender=BtnPesqRuaQR) and (EdtRuaIdQR.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaEnderecamentoRuas := TFrmPesquisaEnderecamentoRuas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoRuas.ShowModal = mrOk) then  Begin
       if (PgcBase.ActivePage = TabPrincipal) then Begin
          EdtRuaId.Text := FrmPesquisaEnderecamentoRuas.Tag.ToString();
          EdtEstruturaIdExit(EdtRuaId);
       End
       Else if (PgcBase.ActivePage = TabPrincipal) then Begin
          EdtRuaId.Text := FrmPesquisaEnderecamentoRuas.Tag.ToString();
          EdtEstruturaIdExit(EdtRuaIdQR);
       End
       Else Begin
          EdtRuaIdCe.Text := FrmPesquisaEnderecamentoRuas.Tag.ToString();
          EdtEstruturaIdExit(EdtRuaIdCE);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoRuas);
  end;
end;

procedure TFrmEnderecamento.BtnPesqZonaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoZonas;
begin
  if (PgcBase.ActivePage = TabPrincipal) and  (Not (OperacaoCrud in [poNew, poEdit])) then Exit;
  if ((Sender=BtnPesqZona)   and (EdtZonaId.ReadOnly)) or
     ((Sender=BtnPesqZonaCE) and (EdtZonaIdCE.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       if PgcBase.ActivePage = TabPrincipal then Begin
          EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtEstruturaIdExit(EdtZonaId);
       End
       Else Begin
          EdtZonaIdCE.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtEstruturaIdExit(EdtZonaIdCE);
       End
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmEnderecamento.CbEstruturaAtivaDesativaClick(Sender: TObject);
begin
  inherited;
  LimparLstManutencao;
end;

function TFrmEnderecamento.CheckReserva(pEnderecoId: Integer): Boolean;
Var JsonArrayEstoque  : TJsonArray;
    ObjEstoqueCtrl    : TEstoqueCtrl;
    vEnderecoId       : Integer;
    vErro : String;
begin
  Result := True;
  ObjEstoqueCtrl := TEstoqueCtrl.Create; //Verificar se Tem Estoque em Reserva
  JsonArrayEstoque  := TJsonArray.Create;
  JsonArrayEstoque := ObjEstoqueCtrl.GetEstoqueJson(0, 0, vEnderecoId, 6, 2, 2, 'N','S', 0);
  if Not JsonArrayEstoque.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Não é possível alterar o picking devido reservas pendentes.');
     Result := False;
  End;
  JsonArrayEstoque.Free;
  ObjEstoqueCtrl.Free
end;

procedure TFrmEnderecamento.ChkBloquearClick(Sender: TObject);
begin
  inherited;
  ShBloquear.Visible     := ChkBloquear.Checked;
  if (ChkBloquear.Checked) and (ChkDesbloquear.Checked) then begin
     ChkDesbloquear.Checked := False;
     ShDesbloquear.Visible  := False;
  end;
end;

procedure TFrmEnderecamento.ChkDesbloquearClick(Sender: TObject);
begin
  inherited;
  ShDesbloquear.Visible := ChkDesbloquear.Checked;
  if (ChkDesbloquear.Checked) and (ChkBloquear.Checked) then begin
     ChkBloquear.Checked := False;
     ShBloquear.Visible  := False;
  end;
end;

procedure TFrmEnderecamento.ChkManutencaoAtivarClick(Sender: TObject);
begin
  inherited;
  ShManutencaoAtivar.Visible     := ChkManutencaoAtivar.Checked;
  ChkManutencaoDesativar.Checked := not ChkManutencaoAtivar.Checked;
end;

procedure TFrmEnderecamento.ChkManutencaoDesativarClick(Sender: TObject);
begin
  inherited;
  ChkManutencaoAtivar.Checked   := Not ChkManutencaoDesativar.Checked;
  ShManutencaoAtivar.Visible    := ChkManutencaoAtivar.Checked;
  ShManutencaoDesativar.Visible := ChkManutencaoDesativar.Checked;
  if ChkManutencaoDesativar.Checked then Begin
     SelAtivaDesativa :=  True;
     LstManutencaoAtivaDesativaClickCell(LstManutencaoAtivaDesativa, 0, 10);
  End;
end;

procedure TFrmEnderecamento.ClearBlocoEnderecoCreate;
begin
  limparCreateAddress;
  EdtRuaInicialCE.Clear;
  EdtRuaFinalCE.Clear;
  EdtPredioInicialCE.Clear;
  EdtPredioFinalCE.Clear;
  EdtNivelInicialCE.Clear;
  EdtNivelFinalCE.Clear;
  EdtAptoInicialCE.Clear;
  EdtAptoFinalCE.Clear;
  EdtIntervaloAp.Text := '';
  //LstCreateAddress.ClearRect(0, 1, LstCreateAddress.ColCount-1, LstCreateAddress.RowCount-1);
end;

procedure TFrmEnderecamento.DefineField;
begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
  End;
  With FdMemPesqGeral.FieldDefs do begin
     Add('Estruturaid',ftInteger,0,True);
     Add('RuaId',ftInteger, 0,True);
     Add('ZonaId',ftInteger, 0,True);
     Add('Endereco',ftString, 11,True);
     Add('ArmazemId',ftInteger, 0,True);
     Add('Altura',ftFloat, 0,True);
     Add('Largura',ftFloat, 0,True);
     Add('Comprimento',ftFloat, 0,True);
     Add('Capacidade',ftFloat, 0,True);
  End;
  FdMemPesqGeral.CreateDataSet;
  FdMemPesqGeral.Open;
end;

function TFrmEnderecamento.DeleteReg: Boolean;
Var ObjEnderecoCtrl  : TEnderecoCtrl;
begin
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  ObjEnderecoCtrl.ObjEndereco.EnderecoId := StrToIntDef(EdtEndereco.Text, 0);
  Result := ObjEnderecoCtrl.DelEndereco;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmEnderecamento.EdtAlturaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  EdtVolume.Value := EdtAltura.Value * EdtLargura.Value * EdtComprimento.Value;
end;

procedure TFrmEnderecamento.EdtArmazemIdChange(Sender: TObject);
begin
  inherited;
  LblArmazem.Caption := '';
end;

procedure TFrmEnderecamento.EdtConteudoPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex in [0, 2, 3] then
     SoNumeros(Key);
end;

procedure TFrmEnderecamento.EdtEnderecoExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
// ((OperacaoCrud=poNew) or ((OperacaoCrud=poEdit) and (EdtEndereco.Text<>vEnderecoEdit)))
  if (EdtEndereco.Text<>'') then Begin
     Limpar;
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EdtEndereco.Text, EdtEndereco.Text, 'T', 2, 0, 0, 0);
     if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        If OperacaoCrud = poSearch Then
           JsonToDataSet_ShowDados(JsonArrayRetorno)
        Else If (OperacaoCrud in [poNew, poEdit]) and (EdtEndereco.Text<>ObjEnderecoCtrl.ObjEndereco.Descricao) then Begin
           ShowErro('Endereço('+EdtEndereco.Text+') já existe no cadastro!');
           EdtEndereco.Clear;
           EdtEndereco.SetFocus;
        End;
//        ShowErro('Endereço já criado!!!');
     End
     Else if Not (OperacaoCrud in [poNew, poEdit]) then begin
       ShowErro('Erro: '+vErro);
       EdtEndereco.Clear;
       EdtEndereco.SetFocus;
     end;
     JsonArrayRetorno := Nil;
     ObjEnderecoCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamento.EdtEnderecoIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmEnderecamento.EdtEnderecoIdExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : string;
begin
  if (Sender = EdtEnderecoId) and (EdtEnderecoId.Text<>'') and (StrToIntDef(EdtEnderecoId.Text, 0) <= 0) then Begin
     EdtEnderecoId.setFocus;
     ShowErro('Id do Endereço inválido!');
     EdtEnderecoId.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtEnderecoId.ReadOnly) and (EdtEnderecoId.Text<>'') then Begin
     Limpar;
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     if StrToIntDef(EdtEnderecoId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtEnderecoId.Text+') inválido!');
     JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(StrToIntDef(EdtEnderecoId.Text, 0), 0, 0, 0, '', '', 'T', 2, 0, 1);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
        ShowErro('Erro: '+vErro)
     Else
        JsonToDataSet_ShowDados(JsonArrayRetorno);
     FreeAndNil(ObjEnderecoCtrl);
  End;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamento.EdtEnderecoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmEnderecamento.EdtEnderecoIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Not EdtEnderecoId.ReadOnly) and ( (Sender=EdtEnderecoId) or (Sender=EdtEndereco)) then Begin
     if Sender=EdtEnderecoId then
        EdtEndereco.Clear
     Else EdtEnderecoId.Clear;
     Limpar;
  End;
end;

procedure TFrmEnderecamento.EdtEnderecoIniAtivaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtEnderecoIniCubagemKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtEnderecoIniExcluirKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtEnderecoQRFinalChange(Sender: TObject);
begin
  inherited;
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtEstruturaIdChange(Sender: TObject);
begin
  inherited;
  LblEstrutura.Caption := '';
  limparCreateAddress;
end;

procedure TFrmEnderecamento.EdtEstruturaIdExit(Sender: TObject);
Var ObjEnderecoEstruturaCtrl : TEnderecoEstruturaCtrl;
    ObjEnderecoZonaCtrl      : TEnderecamentoZonaCtrl;
    ObjEnderecoRuaCtrl       : TEnderecoRuaCtrl;
    ObjDesenhoArmazemCtrl    : TDesenhoArmazemCtrl;
    JsonArrayArmazem         : TJsonArray;
    vErro                    : String;
begin
  if ((Sender=EdtEstruturaid) and (EdtEstruturaid.Text<>'') and (StrTointDef(EdtEstruturaid.Text ,0) <= 0)) or
     ((Sender=EdtEstruturaIdCE) and (EdtEstruturaIdCE.Text<>'') and (StrTointDef(EdtEstruturaIdCE.Text ,0) <= 0)) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id('+TEdit(Sender).Text+') da Estrutura inválido!');
     TEdit(Sender).Clear;
     Exit;
  End
  Else if ((Sender=EdtZonaid) and (EdtZonaid.Text<>'') and (StrTointDef(EdtZonaid.Text ,0) <= 0)) or
     ((Sender=EdtZonaidCE) and (EdtZonaIdCE.Text<>'') and (StrTointDef(EdtZonaidCE.Text ,0) <= 0)) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id('+TEdit(Sender).Text+') da Zona/Setor inválido!');
     TEdit(Sender).Clear;
     Exit;
  End
  Else if ((Sender=EdtRuaId) and (EdtRuaId.Text<>'') and (StrTointDef(EdtRuaId.Text ,0) <= 0)) or
     ((Sender=EdtRuaIdCE) and (EdtRuaIdCE.Text<>'') and (StrTointDef(EdtRuaIdCE.Text ,0) <= 0)) or
     ((Sender=EdtRuaIdQR) and (EdtRuaIdQR.Text<>'') and (StrTointDef(EdtRuaIdQR.Text ,0) <= 0)) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id('+TEdit(Sender).Text+') da Rua inválido!');
     TEdit(Sender).Clear;
     Exit;
  End
  Else if ((Sender=EdtArmazemId) and (EdtArmazemId.Text<>'') and (StrTointDef(EdtArmazemId.Text ,0) <= 0)) or
     ((Sender=EdtArmazemIdCE) and (EdtArmazemIdCE.Text<>'') and (StrTointDef(EdtArmazemIdCE.Text ,0) <= 0)) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id('+TEdit(Sender).Text+') do Armazém inválido!');
     TEdit(Sender).Clear;
     Exit;
  End;

  inherited;
  if ((Sender=EdtEstruturaid) and (not EdtEstruturaId.ReadOnly)) or
     ((Sender=EdtEstruturaIdCE) and (not EdtEstruturaIdCE.ReadOnly)) then Begin
     If (Sender=EdtEstruturaid) then
        LblEstrutura.Caption := ''
     Else
        LblEstruturaCE.Caption := '';
     if ((Sender=EdtEstruturaid) and (EdtEstruturaId.text <> '')) or
        ((Sender=EdtEstruturaIdCE) and (EdtEstruturaIdCE.text <> '')) then Begin
        ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create();
        ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura := ObjEnderecoEstruturaCtrl.GetEnderecoEstrutura(StrToIntDef(TEdit(Sender).Text, 0), '', 1)[0];
        vMascaraEndereco := ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura.Mascara;
        if (Sender=EdtEstruturaid) then
           LblEstrutura.Caption := ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura.Descricao
        Else
           LblEstruturaCE.Caption := ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura.Descricao;
        ObjEnderecoEstruturaCtrl.Free;
        if StrToIntdef(EdtEstruturaIdCE.Text, 0) = 2 then Begin
           EdtNivelInicialCE.Text := '00';
           EdtNivelFinalCE.Text   := '00';
           EdtNivelInicialCE.ReadOnly := True;
           EdtNivelFinalCE.ReadOnly   := True;
           EdtNivelInicialCE.TabStop  := False;
           EdtNivelFinalCE.TabStop    := False;
        End
        Else Begin
           EdtNivelInicialCE.Text := '';
           EdtNivelFinalCE.Text   := '';
           EdtNivelInicialCE.ReadOnly := False;
           EdtNivelFinalCE.ReadOnly   := False;
           EdtNivelInicialCE.TabStop  := True;
           EdtNivelFinalCE.TabStop    := True;
        End;
     End;
  End
  Else if ((Sender=EdtZonaid) and (not EdtZonaId.ReadOnly)) or
          ((Sender=EdtZonaidCE) and (not EdtZonaIdCE.ReadOnly)) then Begin
     If (Sender=EdtZonaid) then lblZona.Caption := '' Else LblZonaCE.Caption := '';
     if TEdit(Sender).Text <> '' then Begin
        ObjEnderecoZonaCtrl := TEnderecamentoZonaCtrl.Create();
        ObjEnderecoZonaCtrl.ObjEnderecamentoZona := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrToIntDef(TEdit(Sender).Text, 0), '', 1)[0];
        If (Sender=EdtZonaid) then
           LblZona.Caption := ObjEnderecoZonaCtrl.ObjEnderecamentoZona.Descricao
        Else
           LblZonaCe.Caption := ObjEnderecoZonaCtrl.ObjEnderecamentoZona.Descricao;
        ObjEnderecoZonaCtrl.Free;
     End;
  End
  Else if ((Sender=EdtRuaId) and (not EdtRuaId.ReadOnly)) or
          ((Sender=EdtRuaIdCE) and (not EdtRuaIdCE.ReadOnly)) or
          ((Sender=EdtRuaIdQR) and (not EdtRuaIdQR.ReadOnly)) then Begin
     if (Sender=EdtRuaId) Then
        LblRua.Caption := ''
     Else IF (Sender=EdtRuaIdQR) Then
        LblRuaQR.Caption := ''
     Else
        LblRuaCE.Caption := '';
     if TEdit(Sender).Text <> '' then Begin
        ObjEnderecoRuaCtrl := TEnderecoRuaCtrl.Create();
        ObjEnderecoRuaCtrl.ObjEnderecoRua := ObjEnderecoRuaCtrl.GetEnderecoRua(StrToIntDef(TEdit(Sender).Text, 0), '', '', 1)[0];
        if (Sender=EdtRuaId) then
           LblRua.Caption := ObjEnderecoRuaCtrl.ObjEnderecoRua.Descricao
        Else if (Sender=EdtRuaIdQR) then
           LblRuaQR.Caption := ObjEnderecoRuaCtrl.ObjEnderecoRua.Descricao
        Else
           LblRuaCE.Caption := ObjEnderecoRuaCtrl.ObjEnderecoRua.Descricao;
        ObjEnderecoRuaCtrl.Free;
     End;
  End
  Else if ((Sender=EdtArmazemId) and (not EdtArmazemId.ReadOnly)) or
          ((Sender=EdtArmazemIdCE) and (not EdtArmazemIdCE.ReadOnly)) then Begin
     If Sender=EdtArmazemId then
        LblArmazem.Caption := ''
     Else
        LblArmazem.Caption := '';
     if TEdit(Sender).Text <> '' then Begin
        ObjDesenhoArmazemCtrl := TDesenhoArmazemCtrl.Create();
        JsonArrayArmazem := ObjDesenhoArmazemCtrl.GetDesenhoArmazem(StrToIntDef(TEdit(Sender).Text, 0), '', 1);
        if JsonArrayArmazem.Items[0].TryGetValue('Erro', vErro) then Begin
           ShowErro('Erro: '+vErro);
           TEdit(Sender).Clear;
           TEdit(Sender).SetFocus;
        End
        Else Begin
          If Sender = EdtArmazemId then
             LblArmazem.Caption := ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Descricao
          Else
             LblArmazemCE.Caption := ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Descricao;
        End;
        JsonArrayArmazem := Nil;
        ObjDesenhoArmazemCtrl.Free;
     End;
  End;
end;

procedure TFrmEnderecamento.EdtPesoExit(Sender: TObject);
begin
  inherited;
  if (StrToIntDef(EdtPeso.Text, 0) < 0) then begin
     EdtPeso.SetFocus;
     ShowErro('Peso inválido!');
     EdtPeso.Clear;
  end;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamento.EdtPickingAtualChange(Sender: TObject);
begin
  inherited;
  EdtProdutoVinculado.Clear;
  LblPickingAtual.Caption := '...';
  EdtEstoquePicking.Clear;
  EdtPickingNovo.Clear;
  LblPickingNovo.Caption := '...';
  SbSalvarTransferenciaPicking.Visible := False;
end;

procedure TFrmEnderecamento.EdtPickingAtualExit(Sender: TObject);
Var ObjEndereco : TEnderecoCtrl;
    ArrayJsonEndereco : TJsonArray;
    vErro : String;
    vEnderecoId : Integer;
begin
  inherited;
  if EdtPickingAtual.Text = '' then Exit;
  //ArrayJsonEndereco := TJsonArray.Create;
  ObjEndereco := TEnderecoCtrl.Create;
  ArrayJsonEndereco := ObjEndereco.GetEnderecoJson(0, 2, 0, 0, EdtPickingAtual.Text, EdtPickingAtual.Text, 'T', 99, 0, 0);
  if ArrayJsonEndereco.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro('Endereço de Picking não encontrado!');
     EdtPickingAtual.Clear;
     EdtPickingAtual.SetFocus;
  End
  Else Begin
    If ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') = 0 then Begin
       ShowErro('Picking('+EdtPickingAtual.Text+') não está em uso!');
       EdtPickingAtual.Clear;
       EdtPickingAtual.SetFocus;
    End
    Else Begin
       EdtProdutoVinculado.Text  := ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('codproduto')+' - '+
                                   ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
       EdtEstoquePicking.Text    := (ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde')).ToString;
       EdtQtdeTransferencia.Text := (ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdetransferencia')).ToString;
       EdtSaldoPicking.Text      := (ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde')+
                                     ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdetransferencia')).ToString;
       LblTransferenciaEstoque.Visible := ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde') <> 0;
       If ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'U' then
          LblPickingAtual.Caption := 'Único'
       Else if ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'I' then
          LblPickingAtual.Caption := 'Impar'
       Else if ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'P' then
          LblPickingAtual.Caption := 'Par'
       Else LblPickingAtual.Caption := '---';
       LblPickingAtual.Caption := LblPickingAtual.Caption + ' ' +
                                  ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
       vEnderecoId := ArrayJsonEndereco.Items[0].GetValue<Integer>('enderecoid');
       //ArrayJsonEndereco := Nil;
       //ObjEndereco.Free;
       //If Not CheckReserva(vEnderecoId) then Begin
       If ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva') > 0 then Begin
          ShowErro('Transferência não permitida. Estoque reservado para produção.');
          EdtPickingAtual.Clear;
       End;
       exit;
    End;
  End;
  ArrayJsonEndereco := Nil;
  ObjEndereco.Free;
end;

procedure TFrmEnderecamento.EdtPickingNovoChange(Sender: TObject);
begin
  inherited;
  LblPickingNovo.Caption := '...';
  SbSalvarTransferenciaPicking.Visible := False;
end;

procedure TFrmEnderecamento.EdtPickingNovoExit(Sender: TObject);
Var ObjEnderecoCtrl : TEnderecoCtrl;
    ArrayJsonEndereco : TJsonArray;
    vErro : String;
begin
  inherited;
  if EdtPickingNovo.Text = '' then Exit;
  if EdtPickingNovo.Text = EdtPickingAtual.Text then Begin
     EdtPickingNovo.Clear;
     EdtPickingNovo.SetFocus;
     ShowErro('Para transferência é preciso informar um novo picking!');
     Exit;
  End;
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EdtPickingNovo.Text, EdtPickingNovo.Text, 'L', 1, 0, 0);
  if ArrayJsonEndereco.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro('Picking(Novo) não encontrado ou já vinculado a outro produto.');
     EdtPickingNovo.Clear;
     EdtPickingNovo.SetFocus;
  End
  Else Begin
    If ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') > 0 then Begin
       ShowErro('Picking('+EdtPickingNovo.Text+') já utilizado. Produto: '+ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('codproduto')+' - '+
                                ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('descricao'));
       EdtPickingNovo.Clear;
       EdtPickingNovo.SetFocus;
    End;
    If ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'U' then
       LblPickingNovo.Caption := 'Único'
    Else if ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'I' then
       LblPickingNovo.Caption := 'Impar'
    Else if ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'P' then
       LblPickingNovo.Caption := 'Par'
    Else LblPickingNovo.Caption := '---';
    LblPickingNovo.Caption := LblPickingAtual.Caption + ' ' +
                              ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
    SbSalvarTransferenciaPicking.Visible := True;
  End;
  ArrayJsonEndereco := Nil;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmEnderecamento.EdtRuaIdChange(Sender: TObject);
begin
  inherited;
  LblRua.Caption := '';
end;

procedure TFrmEnderecamento.EdtRuaInicialCEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmEnderecamento.EdtZonaIdAtivaDesativaChange(Sender: TObject);
begin
  inherited;
  LblZonaAtivaDesativa.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtZonaIdAtivaDesativaExit(Sender: TObject);
Var ObjEnderecoZonaCtrl : TEnderecamentoZonaCtrl;
    ReturnLstZona       : TObjectList<TEnderecamentoZona>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  if TJvComboEdit(Sender).Text = '' then Exit;
  ObjEnderecoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  ReturnLstZona       := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrtoIntDef(TJvComboEdit(Sender).Text, 0), '', 0);
  if ReturnLstZona.Count <= 0 then Begin
     TJvComboEdit(Sender).Clear;
     ShowErro('Zona('+TJvComboEdit(Sender).Text+') não encontrada!');
     TJvComboEdit(Sender).SetFocus;
  End
  else Begin
    if Sender = EdtZonaIdAtivaDesativa then
       LblZonaAtivaDesativa.Caption   := ReturnLstZona.Items[0].Descricao
    Else if (Sender = EdtZonaIdMudarZona) then
       LblZonaMudarZona.Caption   := ReturnLstZona.Items[0].Descricao
    Else if (Sender = EdtZonaIdNova) then
       LblZonaNova.Caption   := ReturnLstZona.Items[0].Descricao
    Else if Sender = EdtZonaIdCubagem then
       LblZonaCubagem.Caption     := ReturnLstZona.Items[0].Descricao
    Else if Sender = EdtZonaIdExcluir then
       LblZonaExcluir.Caption     := ReturnLstZona.Items[0].Descricao
    Else if Sender = EdtZonaIdRemoverVinculo then
       LblZonaRemoverVinculo.Caption     := ReturnLstZona.Items[0].Descricao
    Else if Sender = EdtZonaIdQR then Begin
       if ReturnLstZona.Items[0].EstruturaId <> 2 then Begin
          ShowErro('Informe uma zona de Picking.');
          EdtZonaIdQR.Clear;
          EdtZonaIdQR.SetFocus;
          Exit;
       End;
       LblZonaQR.Caption := ReturnLstZona.Items[0].Descricao;
    End;
  End;
  ReturnLstZona := Nil;
  FreeAndNil(ObjEnderecoZonaCtrl);
end;

procedure TFrmEnderecamento.EdtZonaIdCEChange(Sender: TObject);
begin
  inherited;
  LblZonaCE.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '';
end;

procedure TFrmEnderecamento.EdtZonaIdCubagemChange(Sender: TObject);
begin
  inherited;
  LblZonaCubagem.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtZonaIdExcluirChange(Sender: TObject);
begin
  inherited;
  LblZonaExcluir.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtZonaIdMudarZonaChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtZonaIdMudarZona then
    LblZonaMudarZona.Caption := ''
  Else LblZonaNova.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtZonaIdQRChange(Sender: TObject);
begin
  inherited;
  LblZonaQR.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.EdtZonaIdRemoverVinculoChange(Sender: TObject);
begin
  inherited;
  LblZonaRemoverVinculo.Caption := '';
  LimparLstManutencao;
end;

procedure TFrmEnderecamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
  FrmEnderecamento := nil;
end;

procedure TFrmEnderecamento.FormCreate(Sender: TObject);
begin
  inherited;
  TabListagem.TabVisible := False;
  vEnderecoEdit := '';
  SelAtivaDesativa := False;
  With LstCadastro do Begin
    ColWidths[0]  := 70+Trunc(70*ResponsivoVideo);
    ColWidths[1]  := 150+Trunc(150*ResponsivoVideo);
    ColWidths[2]  := 150+Trunc(150*ResponsivoVideo);
    ColWidths[3]  := 120+Trunc(120*ResponsivoVideo);
    ColWidths[4]  := 60+Trunc(60*ResponsivoVideo);
    ColWidths[5]  := 70+Trunc(70*ResponsivoVideo);
    ColWidths[6]  := 120+Trunc(120*ResponsivoVideo);
    ColWidths[7]  := 80+Trunc(80*ResponsivoVideo);
    ColWidths[8]  := 80+Trunc(80*ResponsivoVideo);
    ColWidths[9]  := 100+Trunc(100*ResponsivoVideo);
    ColWidths[10] := 200+Trunc(200*ResponsivoVideo);
    ColWidths[11] := 40+Trunc(40*ResponsivoVideo);
    Alignments[0, 0]  := taRightJustify;
    FontStyles[0, 0]  := [FsBold];
    Alignments[4, 0]  := taCenter;
    Alignments[5, 0]  := taCenter;
    Alignments[7, 0]  := taRightJustify;
    Alignments[8, 0]  := taRightJustify;
    Alignments[11, 0] := taCenter;
  End;

//  LstCadastro.FixedRows := 0;
//  LstCadastro.RowCount  := 1;
//  GetListaEnderecos(0, 0, 3, '', '');
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.MudarPickingEstoquePallet = 0 then
     LblObs1RemVinculo.Caption := 'Obs: O Saldo do picking é composto pelo estoque físico acrescido do estoque de reposição disponível para trasferência. Estoque Pulmão adicionado ao Saldo.'
  Else
     LblObs1RemVinculo.Caption := 'Obs: O Saldo do picking é composto pelo estoque físico acrescido do estoque de reposição disponível para trasferência.';
  TabManutencaoOnOff(99);
  GetEstrutura;
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamento CD')) then Begin
     PanWin8.Color   := clGray;
     PanWin8.Enabled := False;
  End;
end;

procedure TFrmEnderecamento.FormShow(Sender: TObject);
begin
  inherited;
  PgcBase.ActivePage := TabPrincipal;
end;

procedure TFrmEnderecamento.GetEndereco(Sender: TObject; pLstManutencao : TAdvStringGrid);
Var ObjEnderecoCtrl : TEnderecoCtrl;
    ArrayJsonEndereco : TJsonArray;
    vErro    : String;
    xRetorno, vEstruturaId, vEstoquePulmao : Integer;
begin
  pLstManutencao.RowCount := 1;
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
     if CbEstruturaAtivaDesativa.ItemIndex < 0 then vEstruturaId := 0;
     ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, vEstruturaId,
                                                          StrToIntDef(EdtZonaIdAtivaDesativa.Text, 0), 0,
                                                          EdtEnderecoIniAtiva.Text, EdtEnderecoFinAtiva.Text,
                                                          'T', 99, 0, 0);
  End
  Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
     if CbEstruturaMudarZona.ItemIndex < 0 then vEstruturaId := 0;
     ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, vEstruturaId,
                                                          StrToIntDef(EdtZonaIdMudarZona.Text, 0), 0,
                                                          EdtEnderecoIniMudarZona.Text, EdtEnderecoFinMudarZona.Text,
                                                          'T', 99, 0, 0);
  End
  Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
     if CbEstruturaCubagem.ItemIndex < 0 then vEstruturaId := 0;
     ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, vEstruturaId,
                                                          StrToIntDef(EdtZonaIdCubagem.Text, 0), 0,
                                                          EdtEnderecoIniCubagem.Text, EdtEnderecoFinCubagem.Text,
                                                          'T', 99, 0);
  End
  Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
     if CbEstruturaExcluir.ItemIndex < 0 then vEstruturaId := 0;
     ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, vEstruturaId,
                                                          StrToIntDef(EdtZonaIdExcluir.Text, 0), 0,
                                                          EdtEnderecoIniExcluir.Text, EdtEnderecoFinExcluir.Text,
                                                          'L', 99, 0, 0);
  End
  Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
     if CbEstruturaRemoverVinculo.ItemIndex < 0 then vEstruturaId := 0;
     ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 2,
                                                          StrToIntDef(EdtZonaIdRemoverVinculo.Text, 0), 0,
                                                          EdtEnderecoIniRemoverVinculo.Text, EdtEnderecoFinRemoverVinculo.Text,
                                                          'O', 99, 0, 0);
  End
  Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
     ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 2,
                                                          StrToIntDef(EdtZonaIdQR.Text, 0), 0,
                                                          EdtEnderecoQRInicial.Text, EdtEnderecoQRFinal.Text, 'T', 99, 0, 99);
  End;
  if ArrayJsonEndereco.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro('Não foram encontrado(s) dados para o relatório');
     LimparManutencao;
  End
  Else Begin
     pLstManutencao.RowCount  := ArrayJsonEndereco.Count+1;
     pLstManutencao.FixedRows := 1;
     For xRetorno := 1 to pLstManutencao.RowCount - 1 do Begin
       if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
          pLstManutencao.AddDataImage(5, xRetorno, 0, haCenter,vaTop);
          pLstManutencao.AddDataImage(12, xRetorno, 0, haCenter,vaTop);
          pLstManutencao.AddDataImage(13, xRetorno, 0, haCenter,vaTop);
       End
       Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
          pLstManutencao.AddDataImage(7, xRetorno, 0, haCenter,vaTop);
          pLstManutencao.AddDataImage(8, xRetorno, 0, haCenter,vaTop);
          pLstManutencao.AddDataImage(9, xRetorno, 0, haCenter,vaTop);
       End
       Else Begin
          pLstManutencao.AddDataImage( 3, xRetorno, 0, haCenter,vaTop);
          pLstManutencao.AddDataImage( 9, xRetorno, 0, haCenter,vaTop);
          pLstManutencao.AddDataImage(10, xRetorno, 0, haCenter,vaTop);
       End;
     End;
     for XRetorno := 0 to Pred(ArrayJsonEndereco.Count) do Begin
       if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
          pLstManutencao.Cells[ 0, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid').ToString;
          pLstManutencao.Cells[ 1, xRetorno+1] := EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
          pLstManutencao.Cells[ 2, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
          //pLstManutencao.Cells[ 3, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
          pLstManutencao.Cells[ 5, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('pickingfixo');
          pLstManutencao.Cells[ 6, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
          if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') <> 0then begin
             pLstManutencao.Cells[ 9, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('codproduto');
             pLstManutencao.Cells[10, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
          end
          Else Begin
             pLstManutencao.Cells[ 9, xRetorno+1] := '';
             pLstManutencao.Cells[10, xRetorno+1] := '';
          End;
          pLstManutencao.Cells[11, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('qtde');
          pLstManutencao.Cells[12, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('status');
          pLstManutencao.Cells[13, xRetorno+1] := '0';

          pLstManutencao.Alignments[0, 0] := taRightJustify;
          pLstManutencao.FontStyles[0, 0] := [FsBold];
          pLstManutencao.Alignments[1, 0] := taCenter;
          pLstManutencao.Alignments[2, 0] := taCenter;
          pLstManutencao.Alignments[5, 0] := taRightJustify;
          pLstManutencao.Alignments[1, 0] := taRightJustify;
          pLstManutencao.Alignments[8, 0] := taCenter;
          pLstManutencao.Alignments[9, 0] := taCenter;
       End
       Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
          pLstManutencao.Cells[ 0, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid').ToString;
          pLstManutencao.Cells[ 1, xRetorno+1] := EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
          pLstManutencao.Cells[ 2, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('ruaid');
          pLstManutencao.Cells[ 3, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
          pLstManutencao.Cells[ 4, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
          pLstManutencao.Cells[ 5, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('volume');
          pLstManutencao.Cells[ 6, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('Curva');
          pLstManutencao.Cells[ 7, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('status');
          pLstManutencao.Cells[ 8, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('bloqueado');
          pLstManutencao.Cells[ 9, xRetorno+1] := '1';

          pLstManutencao.Alignments[0, xRetorno+1] := taRightJustify;
          pLstManutencao.FontStyles[0, xRetorno+1] := [FsBold];
          pLstManutencao.Alignments[1, xRetorno+1] := taCenter;
          pLstManutencao.Alignments[5, xRetorno+1] := taRightJustify;
          pLstManutencao.Alignments[6, xRetorno+1] := taCenter;
          pLstManutencao.Alignments[7, xRetorno+1] := taCenter;
          pLstManutencao.Alignments[8, xRetorno+1] := taCenter;
       End
       Else Begin
          pLstManutencao.Cells[ 0, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid').ToString;
          pLstManutencao.Cells[ 1, xRetorno+1] := EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
          pLstManutencao.Cells[ 2, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
          //pLstManutencao.Cells[ 3, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
          pLstManutencao.Cells[ 3, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('pickingfixo');
          pLstManutencao.Cells[ 4, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
          if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') <> 0then begin
             pLstManutencao.Cells[5, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('codproduto');
             pLstManutencao.Cells[6, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
          end
          Else Begin
             pLstManutencao.Cells[5, xRetorno+1] := '';
             pLstManutencao.Cells[6, xRetorno+1] := '';
          End;
          if FrmeXactWMS.ConfigWMS.ObjConfiguracao.mudarPickingEstoquePallet = 0 then  Begin
             pLstManutencao.Cells[7, xRetorno+1] := (ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde')+
                                                     ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdetransferencia')+
                                                     ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao')-
                                                     ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdesegregado')).ToString();
             pLstManutencao.Cells[8, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('qtdereserva');
             vEstoquePulmao := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao') -
                               ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdesegregado');
          End
          Else Begin
             pLstManutencao.Cells[7, xRetorno+1] := (ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde')+
                                                     ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdetransferencia')).ToString();
             pLstManutencao.Cells[8, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('qtdereserva');
             vEstoquePulmao := 0;
          End;
          pLstManutencao.Cells[9, xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('status');
          if ((PgcManutencao.ActivePage = TabManutencaoAtivaDesativa) or
              (PgcManutencao.ActivePage = TabManutencaoExcluir)) and
             ((ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') <> 0) or
              ((ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde') <> 0) or
               (ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva') <> 0))) or
             ((PgcManutencao.ActivePage = TabManutencaoRemoverVinculo) and
             ((ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde') <> 0) or
              (ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva') <> 0) or
              (ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdetransferencia') <> 0) or
              (vEstoquePulmao<>0) )) then
             pLstManutencao.Cells[10, xRetorno+1] := '0'
          Else
             pLstManutencao.Cells[10, xRetorno+1] := '1';
          pLstManutencao.Alignments[ 0, xRetorno+1] := taRightJustify;
          pLstManutencao.FontStyles[ 0, xRetorno+1] := [FsBold];
          pLstManutencao.Alignments[ 1, xRetorno+1] := taCenter;
          pLstManutencao.Alignments[ 3, xRetorno+1] := taCenter;
          pLstManutencao.Alignments[ 5, xRetorno+1] := taRightJustify;
          pLstManutencao.Alignments[ 7, xRetorno+1] := taRightJustify;
          pLstManutencao.Alignments[ 8, xRetorno+1] := taRightJustify;
          pLstManutencao.Alignments[ 9, xRetorno+1] := taCenter;
          pLstManutencao.Alignments[10, xRetorno+1] := taCenter;
       End;
     End;
     if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
        SbSalvarAtivaDesativa.Caption := 'Salvar';
        ImgSbAtivaDesativa.picture.BitMap := ImgSaveManut.Picture.BitMap;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
        SbSalvarMudarZona.Caption := 'Salvar';
        ImgSbMudarZona.picture.BitMap := ImgSaveManut.Picture.BitMap;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
        SbSalvarCubagem.Caption := 'Salvar';
        ImgSbCubagem.picture.BitMap := ImgSaveManut.Picture.BitMap;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
        SbSalvarExcluir.Caption := 'Salvar';
        ImgSbExcluir.picture.BitMap := ImgSaveManut.Picture.BitMap;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
        SbSalvarRemoverVinculo.Caption := 'Salvar';
        ImgSbRemoverVinculo.picture.BitMap := ImgSaveManut.Picture.BitMap;
     End
     Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
        BtnSalvarQuebraRua.Caption := 'Salvar';
        ImgSaveQR.picture.BitMap   := ImgSaveManut.Picture.BitMap;
        LabelRuaQR.Visible := True;
        EdtRuaIdQR.Visible := True;
        LblRuaQR.Visible   := True;
        BtnPesqRuaQR.Visible := True;
     End;
     AtualizarTotal(pLstManutencao);
  End;
  ArrayJsonEndereco := Nil;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmEnderecamento.GetEstrutura;
Var ObjEnderecoEstruturaCtrl : TEnderecoEstruturaCtrl;
    ReturnLstEstrutura       : TObjectList<TEnderecoEstrutura>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create();
  ReturnLstEstrutura       := ObjEnderecoEstruturaCtrl.GetEnderecoEstrutura(0, '', 0);
  CbEstruturaAtivaDesativa.Items.Clear;
  CbEstruturaAtivaDesativa.Items.Add('');
  CbEstruturaMudarZona.Items.Clear;
  CbEstruturaMudarZona.Items.Add('');
  CbEstruturaCubagem.Items.Clear;
  CbEstruturaCubagem.Items.Add('');
  CbEstruturaExcluir.Items.Clear;
  CbEstruturaExcluir.Items.Add('');
  CbEstruturaRemoverVinculo.Items.Clear;
  CbEstruturaRemoverVinculo.Items.Add('');
  For xRetorno := 0 to Pred(ReturnLstEstrutura.Count) do Begin
    CbEstruturaAtivaDesativa.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
    CbEstruturaMudarZona.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
    CbEstruturaCubagem.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
    CbEstruturaExcluir.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
    CbEstruturaRemoverVinculo.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
  End;
  try
    ObjEnderecoEstruturaCtrl.Free;
  Except
    ShowMessage('Erro apagando Objeto Estrutura.');
  end;
  CbEstruturaAtivaDesativa.ItemIndex    := 0;
end;

Function TFrmEnderecamento.GetListaEnderecos(pEnderecoId, pEstruturaId, pZonaId : Integer; pEnderecoIni, pEnderecoFin : String) : Boolean;
Var ObjEnderecoCtrl : TEnderecoCtrl;
    xLista, xImg    : Integer;
    LstEnderecos    : TObjectList<TEndereco>;
    ObjProdutoCtrl  : TProdutoCtrl;
begin
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  LstEnderecos := ObjEnderecoCtrl.GetEndereco(pEnderecoId, pEstruturaId, pZonaId, 0, pEnderecoIni, pEnderecoFin, 'T', 2, 0, 1);
  Result := (LstEnderecos.Count >= 1) and (LstEnderecos[0].EnderecoId<>0);
  If LstEnderecos.Count >= 1 then  Begin
     LstCadastro.RowCount := LstEnderecos.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount do Begin
       LstCadastro.AddDataImage( 5, xImg, 0, haCenter, vaTop);
       LstCadastro.AddDataImage(11, xImg, 0, haCenter, vaTop);
     End;
     For xLista := 0 To LstEnderecos.Count-1 do begin
       With LstEnderecos[xLista] do Begin
         LstCadastro.Cells[ 0, xLista+1] := EnderecoId.ToString();
         LstCadastro.Cells[ 1, xLista+1] := Descricao;
         LstCadastro.Cells[ 2, xLista+1] := EnderecoEstrutura.Descricao;
         LstCadastro.Cells[ 3, xLista+1] := EnderecoRua.Descricao;
         LstCadastro.Cells[ 4, xLista+1] := EnderecoRua.Lado;
         LstCadastro.Cells[ 5, xLista+1] := EnderecoEstrutura.PickingFixo.ToString;
         LstCadastro.Cells[ 6, xLista+1] := EnderecamentoZona.Descricao;
         LstCadastro.Cells[ 7, xLista+1] := Volume.ToString();
         LstCadastro.Cells[ 8, xLista+1] := Capacidade.ToString();
         LstCadastro.Cells[ 9, xLista+1] := EnderecoEstrutura.Mascara;
         if Produtoid <> 0 then Begin
            ObjProdutoCtrl := TProdutoCtrl.Create();
            LstCadastro.Cells[10, xLista+1] := ProdutoId.ToString+' '+ObjProdutoCtrl.GetProduto(ProdutoId.ToString())[0].Descricao;
            ObjProdutoCtrl.Free;
         End
         Else LstCadastro.Cells[10, xLista+1] := '';
         LstCadastro.Cells[11, xLista+1] := Status.ToString;
        End;
       LstCadastro.Alignments[ 0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[ 0, xLista+1] := [FsBold];
       LstCadastro.Alignments[ 2, xLista+1] := taCenter;
       LstCadastro.Alignments[11, xLista+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  LstEnderecos := Nil;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmEnderecamento.GetListaLstCadastro;
begin
  inherited;
  PgcBase.ActivePage := TabPrincipal;
  //GetListaEnderecos(0, 0, 3, '', '');
end;

procedure TFrmEnderecamento.HeaderLstManutencao(pLstManutencao : TAdvStringGrid);
begin
  if (PgcManutencao.ActivePage = TabManutencaoAtivaDesativa) or (PgcManutencao.ActivePage = TabManutencaoMudarZona) or
     (PgcManutencao.ActivePage = TabManutencaoExcluir) or (PgcManutencao.ActivePage = TabManutencaoRemoverVinculo)
       then begin
     pLstManutencao.ColWidths[0] := 80+Trunc(80*ResponsivoVideo);
     pLstManutencao.ColWidths[1] := 100+Trunc(100*ResponsivoVideo);
     pLstManutencao.ColWidths[2] :=  80+Trunc(80*ResponsivoVideo);
     pLstManutencao.ColWidths[3] :=  50+Trunc(50*ResponsivoVideo);
     pLstManutencao.ColWidths[4] := 120+Trunc(120*ResponsivoVideo);
     pLstManutencao.ColWidths[5] :=  70+Trunc(70*ResponsivoVideo);
     pLstManutencao.ColWidths[6] := 150+Trunc(150*ResponsivoVideo);
     pLstManutencao.ColWidths[7] :=  80+Trunc(80*ResponsivoVideo);
     pLstManutencao.ColWidths[8] :=  70+Trunc(70*ResponsivoVideo);
     pLstManutencao.ColWidths[9] :=  70+Trunc(70*ResponsivoVideo);
     pLstManutencao.ColWidths[10] := 40+Trunc(40*ResponsivoVideo);
     pLstManutencao.Alignments[0, 0] := taRightJustify;
     pLstManutencao.FontStyles[0, 0] := [FsBold];
     pLstManutencao.Alignments[3, 0] := taCenter;
     pLstManutencao.Alignments[5, 0] := taRightJustify;
     pLstManutencao.Alignments[7, 0] := taRightJustify;
     pLstManutencao.Alignments[8, 0] := taRightJustify;
     pLstManutencao.Alignments[9, 0] := taCenter;
     pLstManutencao.Alignments[10, 0] := taCenter;
  End
  Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
     With LstManutencaoCubagem do Begin
       ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);
       ColWidths[1] := 100+Trunc(100*ResponsivoVideo);
       ColWidths[2] := 110+Trunc(110*ResponsivoVideo);
       ColWidths[3] :=  60+Trunc(60*ResponsivoVideo);
       ColWidths[4] :=  60+Trunc(60*ResponsivoVideo);
       ColWidths[5] :=  60+Trunc(60*ResponsivoVideo);
       ColWidths[6] := 150+Trunc(150*ResponsivoVideo);
       ColWidths[7] :=  70+Trunc(70*ResponsivoVideo);
       ColWidths[8] :=  70+Trunc(70*ResponsivoVideo);
       ColWidths[9] :=  70+Trunc(70*ResponsivoVideo);
       ColWidths[10] := 200+Trunc(200*ResponsivoVideo);
       ColWidths[11] :=  70+Trunc(70*ResponsivoVideo);
       ColWidths[12] :=  50+Trunc(50*ResponsivoVideo);
       ColWidths[13] :=  50+Trunc(50*ResponsivoVideo);
       Alignments[0, 0] := taRightJustify;
       FontStyles[0, 0] := [FsBold];
       Alignments[1, 0] := taCenter;
       Alignments[5, 0] := taCenter;
       Alignments[7, 0] := taRightJustify;
       Alignments[8, 0] := taRightJustify;
       Alignments[9, 0] := taRightJustify;
       Alignments[11, 0] := taRightJustify;
       Alignments[12, 0] := taCenter;
       Alignments[13, 0] := taCenter;
     End;
  End
  Else if PgcManutencao.ActivePage = TabCreateAddress then Begin
     With LstCreateAddress do Begin
        ColWidths[0]  := 120+Trunc(120*ResponsivoVideo);
        ColWidths[1]  :=  50+Trunc(50*ResponsivoVideo);
        ColWidths[2]  :=  50+Trunc(50*ResponsivoVideo);
        ColWidths[3]  :=  50+Trunc(50*ResponsivoVideo);
        ColWidths[4]  :=  50+Trunc(50*ResponsivoVideo);
        ColWidths[5]  := 160+Trunc(160*ResponsivoVideo);
        ColWidths[6]  :=  50+Trunc(50*ResponsivoVideo);
        ColWidths[7]  :=  50+Trunc(50*ResponsivoVideo);
        Alignments[0, 0]  := taCenter;
        FontStyles[0, 0]  := [FsBold];
        Alignments[1, 0]  := taCenter;
        Alignments[2, 0]  := taCenter;
        Alignments[3, 0]  := taCenter;
        Alignments[4, 0]  := taCenter;
        Alignments[5, 0]  := taCenter;
        Alignments[6, 0]  := taCenter;
        Alignments[7, 0]  := taCenter;
     End;
  End
  Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
     With LstQuebraRua do Begin
        ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
        ColWidths[1]  :=  80+Trunc(80*ResponsivoVideo);
        ColWidths[2]  :=  45+Trunc(45*ResponsivoVideo);
        ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
        ColWidths[4]  := 140+Trunc(140*ResponsivoVideo);
        ColWidths[5]  :=  70+Trunc(70*ResponsivoVideo);
        ColWidths[6]  :=  40+Trunc(40*ResponsivoVideo);
        ColWidths[7]  :=  40+Trunc(40*ResponsivoVideo);
        ColWidths[8]  :=  70+Trunc(70*ResponsivoVideo);
        ColWidths[9]  :=  40+Trunc(40*ResponsivoVideo);
        Alignments[0, 0]  := taRightJustify;
        FontStyles[0, 0]  := [FsBold];
        Alignments[1, 0]  := taCenter;
        Alignments[5, 0]  := taRightJustify;
        Alignments[6, 0]  := taCenter;
        Alignments[7, 0]  := taCenter;
        Alignments[8, 0]  := taCenter;
        Alignments[9, 0]  := taCenter;
     End;
  End
  Else If 1 = 2 then  Begin
     With pLstManutencao do Begin
       ColWidths[ 0] :=  80+Trunc(80*ResponsivoVideo);
       ColWidths[ 1] := 100+Trunc(100*ResponsivoVideo);
       ColWidths[ 2] := 110+Trunc(110*ResponsivoVideo);
       ColWidths[ 3] :=  60+Trunc(60*ResponsivoVideo);
       ColWidths[ 4] := 150+Trunc(150*ResponsivoVideo);
       ColWidths[ 5] :=  80+Trunc(80*ResponsivoVideo);
       ColWidths[ 6] := 300+Trunc(300*ResponsivoVideo);
       ColWidths[ 7] :=  50+Trunc(50*ResponsivoVideo);
       ColWidths[ 8] :=  55+Trunc(55*ResponsivoVideo);
       ColWidths[ 9] :=  50+Trunc(50*ResponsivoVideo);
       ColWidths[10] :=  50+Trunc(50*ResponsivoVideo);
       Alignments[ 0, 0] := taRightJustify;
       FontStyles[ 0, 0] := [FsBold];
       Alignments[ 1, 0] := taCenter;
       Alignments[ 3, 0] := taCenter;
       Alignments[ 5, 0] := taRightJustify;
       Alignments[ 7, 0] := taRightJustify;
       Alignments[ 8, 0] := taRightJustify;
       Alignments[ 9, 0] := taCenter;
       Alignments[10, 0] := taCenter;
     End;
  End;
end;

procedure TFrmEnderecamento.JsonToDataSet_ShowDados(pJsonArrayEndereco: TJsonArray);
begin
  If FDMemEnderecamentos.Active then
     FDMemEnderecamentos.EmptyDataSet;
  FDMemEnderecamentos.Close;
  FDMemEnderecamentos.Open;
  FDMemEnderecamentos.Append;
  FDMemEnderecamentos.FieldByName('EnderecoId').AsInteger := pJsonArrayEndereco.Items[0].GetValue<Integer>('enderecoid');
  FDMemEnderecamentos.FieldByName('Descricao').AsString   := pJsonArrayEndereco.Items[0].GetValue<String>('descricao');
  FDMemEnderecamentos.FieldByName('Altura').AsFloat       := pJsonArrayEndereco.Items[0].GetValue<Double>('altura');
  FDMemEnderecamentos.FieldByName('Largura').AsFloat      := pJsonArrayEndereco.Items[0].GetValue<Double>('largura');
  FDMemEnderecamentos.FieldByName('Comprimento').AsFloat       := pJsonArrayEndereco.Items[0].GetValue<Double>('comprimento');
  FDMemEnderecamentos.FieldByName('Volume').AsFloat  := pJsonArrayEndereco.Items[0].GetValue<Double>('volume');
  FDMemEnderecamentos.FieldByName('Capacidade').AsFloat   := pJsonArrayEndereco.Items[0].GetValue<Double>('capacidade');
  FDMemEnderecamentos.FieldByName('Status').AsInteger     := pJsonArrayEndereco.Items[0].GetValue<Integer>('status');
  FDMemEnderecamentos.FieldByName('Ocupacao').AsFloat     := pJsonArrayEndereco.Items[0].GetValue<Double>('Ocupacao');
  FDMemEnderecamentos.FieldByName('Curva').AsString       := pJsonArrayEndereco.Items[0].GetValue<String>('Curva');
  FDMemEnderecamentos.FieldByName('BloqueioInventario').AsString := pJsonArrayEndereco.Items[0].GetValue<String>('bloqueioinventario');
  FDMemEnderecamentos.FieldByName('EstruturaId').AsInteger := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('estruturaid');
  FDMemEnderecamentos.FieldByName('Estrutura').AsString    := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
  FDMemEnderecamentos.FieldByName('PickingFixo').AsInteger := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('pickingfixo');
  FDMemEnderecamentos.FieldByName('Mascara').AsString      := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara');
  FDMemEnderecamentos.FieldByName('RuaId').AsInteger       := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ruaid');
  FDMemEnderecamentos.FieldByName('Rua').AsString          := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
  FDMemEnderecamentos.FieldByName('Lado').AsString         := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado');
  FDMemEnderecamentos.FieldByName('Ordem').AsInteger       := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ordem');
  FDMemEnderecamentos.FieldByName('ZonaId').AsInteger      := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid');
  FDMemEnderecamentos.FieldByName('Zona').AsString         := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
  FDMemEnderecamentos.FieldByName('EstoqueTipoId').AsInteger := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('estoquetipoid');
  FDMemEnderecamentos.FieldByName('ProdutoSNGPC').AsInteger  := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('produtosngpc');
  FDMemEnderecamentos.FieldByName('ArmazemId').AsInteger     := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('desenhoarmazem').GetValue<Integer>('Id');
  FDMemEnderecamentos.FieldByName('Armazem').AsString        := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('desenhoarmazem').GetValue<String>('descricao');
  FDMemEnderecamentos.FieldByName('ProdutoId').AsInteger   := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid');
  FDMemEnderecamentos.FieldByName('CodProduto').AsInteger  := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
  FDMemEnderecamentos.FieldByName('Produto').AsString      := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
  FDMemEnderecamentos.FieldByName('Qtde').AsInteger        := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde');
  FDMemEnderecamentos.FieldByName('QtdePulmao').AsInteger  := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao');
//  FDMemEnderecamentos.FieldByName('QtdeReserva').AsInteger := pJsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva');
  FDMemEnderecamentos.Post;
  ShowDados;
end;

procedure TFrmEnderecamento.EdtFaixaInicialEnderecoChange(Sender: TObject);
begin
  inherited;
  //PnlBlocoEnderecoCreate.Visible := (EdtFaixaInicialEndereco.Text='') and (EdtFaixaFinalEndereco.text='');
  ClearBlocoEnderecoCreate;
  if EdtFaixaInicialEndereco.Text <> '' then Begin
     EdtRuaInicialCE.Text    := Copy(EdtFaixaInicialEndereco.Text, 1, 2);
     EdtPredioInicialCE.Text := Copy(EdtFaixaInicialEndereco.Text, 3, 2);
     EdtNivelInicialCE.Text  := Copy(EdtFaixaInicialEndereco.Text, 5, 2);
     EdtAptoInicialCE.Text   := Copy(EdtFaixaInicialEndereco.Text, 7, 3);
  End;
  if EdtFaixaFinalEndereco.Text <> '' then Begin
     EdtRuaFinalCE.Text    := Copy(EdtFaixaFinalEndereco.Text, 1, 2);
     EdtPredioFinalCE.Text := Copy(EdtFaixaFinalEndereco.Text, 3, 2);
     EdtNivelFinalCE.Text  := Copy(EdtFaixaFinalEndereco.Text, 5, 2);
     EdtAptoFinalCE.Text   := Copy(EdtFaixaFinalEndereco.Text, 7, 3);
  End;
end;

procedure TFrmEnderecamento.Limpar;
begin
  inherited;
  EnabledButtons := False;
  EdtEndereco.ReadOnly := False;
  if Not EdtEstruturaId.Enabled then Begin
     EdtEstruturaId.Clear;
     EdtEndereco.Clear;
  End;
  EdtEstruturaId.Clear;
  EdtRuaId.Clear;
  EdtZonaId.Clear;
  EdtArmazemId.Clear;
  EdtPeso.Value          := 0;
  EdtAltura.Value        := 0;
  EdtLargura.Value       := 0;
  EdtComprimento.Value   := 0;
  EdtVolume.Value        := 0;
  ChkCadastro.Checked    := False;
  ChkBloqueado.Checked   := False;
  ChkBloqueioInventario.CheckEd := False;
  LblEstrutura.Caption   := '...';
  LblRua.Caption         := '...';
  LblZona.Caption        := '...';
  LblArmazem.Caption     := '...';
  ShCadastro.Brush.Color := ClRed;
  ShCadastro.Pen.Color   := ClRed;
  vEnderecoEdit := '';
end;

procedure TFrmEnderecamento.limparCreateAddress;
begin
  LstCreateAddress.RowCount := 1;
  If FDMemCreateMultiploEndereco.Active then
     FDMemCreateMultiploEndereco.EmptyDataSet;
  FDMemCreateMultiploEndereco.Close;
end;

procedure TFrmEnderecamento.LimparLstManutencao;
Var LstManutencao : TAdvStringGrid;
begin
  if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
     ImgSbAtivaDesativa.Picture.Bitmap   := ImgPesqManut.Picture.Bitmap;
     SbSalvarAtivaDesativa.Caption := 'Buscar Endereços';
     LstManutencaoAtivaDesativa.RowCount := 1;
     LstManutencao := LstManutencaoAtivaDesativa;
     LblTotRegistroOnOff.Caption := '0';
  End
  Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
     ImgSbMudarZona.Picture.Bitmap   := ImgPesqManut.Picture.Bitmap;
     SbSalvarMudarZona.Caption := 'Buscar Endereços';
     LstManutencaoMudarZona.RowCount := 1;
     LstManutencao := LstManutencaoMudarZona;
     LblTotRegistroMudarZona.Caption := '0';
  End
  Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
     ImgSbCubagem.Picture.Bitmap   := ImgPesqManut.Picture.Bitmap;
     SbSalvarCubagem.Caption := 'Buscar Endereços';
     LstManutencaoCubagem.RowCount := 1;
     LstManutencao := LstManutencaoCubagem;
     LblTotRegistroCubagem.Caption := '0';
  End
  Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
     ImgSbExcluir.Picture.Bitmap   := ImgPesqManut.Picture.Bitmap;
     SbSalvarExcluir.Caption := 'Buscar Endereços';
     LstManutencaoExcluir.RowCount := 1;
     LstManutencao := LstManutencaoExcluir;
     LblTotRegistroExcluir.Caption := '0';
  End
  Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
     ImgSbRemoverVinculo.Picture.Bitmap := ImgPesqManut.Picture.Bitmap;
     SbSalvarRemoverVinculo.Caption := 'Buscar Endereços';
     LstManutencaoRemoverVinculo.RowCount := 1;
     LstManutencao := LstManutencaoRemoverVinculo;
     LblTotRegistroRemoverPicking.Caption := '0';
  End
  Else if PgcManutencao.ActivePage = TabCreateAddress then Begin
     ImgSimularCreateAddress.Picture.Bitmap := ImgPesqManut.Picture.Bitmap;
     SbSimularCreateAddress.Caption := '      Simular Endereços';
     SbSalvarCreateAddress.Visible  := False;
     LstCreateAddress.RowCount := 1;
     LstManutencao := LstCreateAddress;
  End
  Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
     ImgSaveQR.Picture.Bitmap := ImgPesqManut.Picture.Bitmap;
     BtnSalvarQuebraRua.Caption := '      Buscar Endereços';
     LstQuebraRua.RowCount := 1;
     LstManutencao := LstQuebraRua;
  End;
  HeaderLstManutencao(LstManutencao);
end;

procedure TFrmEnderecamento.LimparManutencao;
begin
  if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
     SbSalvarAtivaDesativa.Caption := 'Buscar Endereços';
     EdtZonaIdAtivaDesativa.Clear;
     LblZonaAtivaDesativa.Caption := '';
     EdtEnderecoIniAtiva.Clear;
     EdtEnderecoFinAtiva.Clear;
     ChkManutencaoAtivar.Checked    := False;
     ChkManutencaoDesativar.Checked := False;
     ChkBloquear.Checked    := False;
     ChkDesbloquear.Checked := False;
     LimparLstManutencao;
     CbEstruturaAtivaDesativa.SetFocus;
  End
  Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
     LimparLstManutencao;
     EdtZonaIdMudarZona.Clear;
     LblZonaMudarZona.Caption := '';
     EdtEnderecoIniMudarZona.Clear;
     EdtEnderecoFinMudarZona.Clear;
     EdtZonaIdNova.Clear;
     LblZonaNova.Caption := '';
     LstManutencaoMudarZona.RowCount := 1;
     CbEstruturaMudarZona.SetFocus;
  End
  Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
     LimparLstManutencao;
     EdtZonaIdCubagem.Clear;
     LblZonaCubagem.Caption := '';
     EdtEnderecoIniCubagem.Clear;
     EdtEnderecoFinCubagem.Clear;
     EdtPesoManutencao.Clear;
     EdtAlturaManutencao.Clear;
     EdtLarguraManutencao.Clear;
     EdtComprimentoManutencao.Clear;
     EdtVolumeManutencao.Clear;
     CbEstruturaCubagem.SetFocus;
  End
  Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
     LimparLstManutencao;
     EdtZonaIdExcluir.Clear;
     LblZonaExcluir.Caption := '';
     EdtEnderecoIniExcluir.Clear;
     EdtEnderecoFinExcluir.Clear;
     CbEstruturaExcluir.SetFocus;
  End
  Else if PgcManutencao.ActivePage = TabManutencaoTransferenciaPicking then Begin
     EdtPickingAtual.Clear;
     EdtProdutoVinculado.Clear;
     EdtEstoquePicking.Clear;
     EdtPickingNovo.Clear;
     SbSalvarTransferenciaPicking.Visible := False;
     EdtPickingAtual.SetFocus;
     LblTransferenciaEstoque.Visible := False;
  End
  Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
     LimparLstManutencao;
     EdtZonaIdRemoverVinculo.Clear;
     LblZonaRemoverVinculo.Caption := '';
     EdtEnderecoIniRemoverVinculo.Clear;
     EdtEnderecoFinRemoverVinculo.Clear;
     LstManutencaoRemoverVinculo.RowCount := 1;
     EdtZonaIdRemoverVinculo.SetFocus;
  End
  Else If PgcManutencao.ActivePage = TabCreateAddress then Begin
     EdtArmazemIdCE.Clear;
     EdtEstruturaIdCE.Clear;
     EdtZonaIdCE.Clear;
     EdtRuaIdCe.Clear;
     EdtFaixaInicialEndereco.Clear;
     EdtFaixaFinalEndereco.Clear;
     EdtRuaInicialCE.Clear;
     EdtRuaFinalCE.Clear;
     EdtPredioInicialCE.Clear;
     EdtPredioFinalCE.Clear;
     EdtNivelInicialCE.Clear;
     EdtNivelFinalCE.Clear;
     EdtAptoInicialCE.Clear;
     EdtAptoFinalCE.Clear;
     EdtIntervaloAp.Text    := '';
     EdtAlturaCE.Value      := 0;
     EdtLarguraCE.Value     := 0;
     EdtComprimentoCE.Value := 0;
     EdtLarguraCE.Value     := 0;
     EdtVolumeCE.Value      := 0;
  End
  Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
     LimparLstManutencao;
     EdtZonaIdQR.Clear;
     LblZonaQR.Caption := '';
     EdtEnderecoQRInicial.Clear;
     EdtEnderecoQRFinal.Clear;
     EdtRuaIdQR.Clear;
     LblRuaQR.Caption := '';
     LstQuebraRua.RowCount := 1;
     EdtZonaIdQR.SetFocus;
     LabelRuaQR.Visible   := False;
     EdtRuaIdQR.Visible   := False;
     LblRuaQR.Visible     := False;
     BtnPesqRuaQR.Visible := False;
  End
end;

procedure TFrmEnderecamento.LstManutencaoAtivaDesativaClickCell(Sender: TObject;
  ARow, ACol: Integer);
Var xEndereco, xLinhaADV : Integer;
begin
  inherited;
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;
  if ((PgcManutencao.ActivePage = TabManutencaoCubagem) and  (aCol = 13)) or
     ((PgcManutencao.ActivePage <> TabManutencaoCubagem) and  (aCol = 10)) or
     ((PgcManutencao.ActivePage <> TabManutencaoCubagem) and  (aCol = 9)) then Begin
     if (aRow = 0) then Begin
        For xEndereco := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if (((//((PgcManutencao.ActivePage = TabManutencaoAtivaDesativa) And (Not ChkManutencaoAtivar.Checked)) or
                (PgcManutencao.ActivePage = TabManutencaoExcluir)) and
                ((StrToIntDef(TAdvStringGrid(Sender).Cells[5, xEndereco], 0) <> 0) or
                 ((TAdvStringGrid(Sender).Cells[7, xEndereco].ToInteger() <> 0)))) or
            ((PgcManutencao.ActivePage = TabManutencaoRemoverVinculo) and
              ((TAdvStringGrid(Sender).Cells[7, xEndereco].ToInteger<>0) or
               (TAdvStringGrid(Sender).Cells[8, xEndereco].ToInteger<>0)))) then
             //1 = 1
          Else Begin
             if SelAtivaDesativa then Begin
                if PgcManutencao.ActivePage = TabManutencaoCubagem then
                   TAdvStringGrid(Sender).Cells[13, xEndereco] := '0'
                Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then
                   TAdvStringGrid(Sender).Cells[ 9, xEndereco] := '0'
                Else Begin
                   TAdvStringGrid(Sender).Cells[10, xEndereco] := '0';
                End;
             End
             Else Begin
                if (PgcManutencao.ActivePage = TabManutencaoCubagem) or
                   ((PgcManutencao.ActivePage = TabManutencaoAtivaDesativa) and (ChkManutencaoAtivar.Checked)) or
                   (PgcManutencao.ActivePage = TabQuebraRuaPicking) then Begin
                   if (PgcManutencao.ActivePage = TabManutencaoCubagem) then
                      TAdvStringGrid(Sender).Cells[13, xEndereco] := '1'
                   Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then
                      TAdvStringGrid(Sender).Cells[ 9, xEndereco] := '1'
                   Else
                      TAdvStringGrid(Sender).Cells[ 10, xEndereco] := '1'
                End
                Else Begin
                   If ((TAdvStringGrid(Sender).Cells[7, xEndereco].ToInteger() <> 0) or
                       (TAdvStringGrid(Sender).Cells[8, xEndereco].ToInteger() <> 0)) Then
                   TAdvStringGrid(Sender).Cells[10, xEndereco] := '0'
                Else
                   TAdvStringGrid(Sender).Cells[10, xEndereco] := '1';
                End;
             End;
          End;
        End;
        SelAtivaDesativa := Not SelAtivaDesativa;
     End
     Else Begin
       if (((((PgcManutencao.ActivePage = TabManutencaoAtivaDesativa) And ((Not ChkManutencaoAtivar.Checked) and
                                                                           (Not ChkManutencaoDesativar.Checked) and
                                                                           (Not ChkBloquear.Checked) and (Not ChkDesbloquear.Checked) )) or
              (PgcManutencao.ActivePage = TabManutencaoExcluir)) and ((StrToIntDef(TAdvStringGrid(Sender).Cells[5, aRow], 0) <> 0) or
                                                                      (TAdvStringGrid(Sender).Cells[7, aRow].ToInteger() <> 0))) or
              ((PgcManutencao.ActivePage = TabManutencaoRemoverVinculo) and ((TAdvStringGrid(Sender).Cells[7, aRow].ToInteger<>0) or
                                                                             (TAdvStringGrid(Sender).Cells[8, aRow].ToInteger<>0)))) then
          Exit;
       if (PgcManutencao.ActivePage = TabManutencaoCubagem) then Begin
          If (StrToIntDef(TAdvStringGrid(Sender).Cells[13, aRow], 0) = 0) then
             TAdvStringGrid(Sender).Cells[13, aRow] := '1'
          Else
             TAdvStringGrid(Sender).Cells[13, aRow] := '0';
       End
       Else if (PgcManutencao.ActivePage = TabQuebraRuaPicking) then Begin
          If (StrToIntDef(TAdvStringGrid(Sender).Cells[9, aRow], 0) = 0) then
             TAdvStringGrid(Sender).Cells[9, aRow] := '1'
          Else
             TAdvStringGrid(Sender).Cells[9, aRow] := '0';
       End
       Else if (PgcManutencao.ActivePage <> TabManutencaoCubagem) then Begin
          If (StrToIntDef(TAdvStringGrid(Sender).Cells[10, aRow], 0) = 0) then
             TAdvStringGrid(Sender).Cells[10, aRow] := '1'
          Else
             TAdvStringGrid(Sender).Cells[10, aRow] := '0';
       End;
     End;
     if PgcManutencao.ActivePage <> TabQuebraRuaPicking then
        AtualizarTotal(TAdvStringGrid(Sender));
  End;
end;

procedure TFrmEnderecamento.MostraCreateAddress;
Var xLinha : Integer;
begin
  LstCreateAddress.RowCount := FDMemCreateMultiploEndereco.RecordCount+1;
  if LstCreateAddress.RowCount>1 then
     LstCreateAddress.FixedRows := 1;
  xLinha := 1;
  while Not FDMemCreateMultiploEndereco.Eof do Begin
    LstCreateAddress.AddDataImage(6, xLinha, 1, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstCreateAddress.AddDataImage(7, xLinha, 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
    Inc(xLinha);
    FDMemCreateMultiploEndereco.Next;
  End;
  FDMemCreateMultiploEndereco.First;
  xLinha := 1;
  SbSalvarCreateAddress.Visible := FDMemCreateMultiploEndereco.RecordCount > 1;
  while Not FDMemCreateMultiploEndereco.Eof do Begin
    LstCreateAddress.Cells[0, xLinha] := FDMemCreateMultiploEndereco.FieldByName('Endereco').AsString;
    LstCreateAddress.Cells[1, xLinha] := Copy(FDMemCreateMultiploEndereco.FieldByName('Endereco').AsString,  1, 2);
    LstCreateAddress.Cells[2, xLinha] := Copy(FDMemCreateMultiploEndereco.FieldByName('Endereco').AsString,  4, 2);
    LstCreateAddress.Cells[3, xLinha] := Copy(FDMemCreateMultiploEndereco.FieldByName('Endereco').AsString,  7, 2);
    LstCreateAddress.Cells[4, xLinha] := Copy(FDMemCreateMultiploEndereco.FieldByName('Endereco').AsString, 10, 3);
    LstCreateAddress.Cells[5, xLinha] := LblZonaCE.Caption;
    LstCreateAddress.Cells[6, xLinha] := '1';
    LstCreateAddress.Cells[7, xLinha] := '2';
    LstCreateAddress.Colors[1, xLinha] := clWhite;
    LstCreateAddress.Colors[2, xLinha] := clWhite;
    LstCreateAddress.Colors[3, xLinha] := clWhite;
    LstCreateAddress.Colors[4, xLinha] := clWhite;
    LstCreateAddress.Colors[5, xLinha] := clWhite;
    LstCreateAddress.Alignments[0, xLinha]  := taCenter;
    LstCreateAddress.FontStyles[0, xLinha]  := [FsBold];
    LstCreateAddress.Alignments[1, xLinha]  := taCenter;
    LstCreateAddress.Alignments[2, xLinha]  := taCenter;
    LstCreateAddress.Alignments[3, xLinha]  := taCenter;
    LstCreateAddress.Alignments[4, xLinha]  := taCenter;
    LstCreateAddress.Alignments[5, xLinha]  := taCenter;
    LstCreateAddress.Alignments[6, xLinha]  := taCenter;
    LstCreateAddress.Alignments[7, xLinha]  := taCenter;
    Inc(xLinha);
    FDMemCreateMultiploEndereco.Next;
  End;
  ShowMessage('Serão criados '+FDMemCreateMultiploEndereco.RecordCount.ToString()+' endereços.');
end;

procedure TFrmEnderecamento.mostraSimulacaoEndereco;
Var ContRua, ContPredio, ContNivel, ContGav, TotEndCreate : Integer;
    VEndereco : String;
    procedure Step(var loop: integer; step: integer);
    begin
      loop := loop + step - 1;
    end;
begin
  if FDMemCreateMultiploEndereco.Active then
     FDMemCreateMultiploEndereco.EmptyDataSet;
  FDMemCreateMultiploEndereco.Close;
  FDMemCreateMultiploEndereco.Open;
  TotEndCreate := 0;
  For ContRua := StrToIntDef(EdtRuaInicialCE.Text, 0) to StrToIntDef(EdtRuaFinalCE.Text, 0) do
    For ContPredio := StrToIntDef(EdtPredioInicialCE.Text, 0) to StrToIntDef(EdtPredioFinalCE.Text, 0) do
      For ContNivel := StrToIntDef(EdtNivelInicialCE.Text, 0) to StrToIntDef(EdtNivelFinalCE.Text, 0) do
        For ContGav := StrToIntDef(EdtAptoInicialCE.Text, 0) to StrToIntDef(EdtAptoFinalCE.Text, 0) do Begin
          vEndereco := FormatFloat('00', ContRua)+FormatFloat('00', ContPredio)+FormatFloat('00', ContNivel)+FormatFloat('000', ContGav);
          vEndereco := EnderecoMask(vEndereco, vMascaraEndereco, True);
          if FDMemCreateMultiploEndereco.Locate('Endereco', vEndereco, []) = False then Begin
             With FDMemCreateMultiploEndereco do Begin
               Append;
               FieldByName('Endereco').AsString := vEndereco;
               //if TEndereco.SearchEndereco(0, StringReplace(vEndereco, '.', '', [rfReplaceAll])) then
               //   FieldByName('Status').AsInteger   := 0 //Pesquisar Endereco 0-Novo 1-Existe
               //Else FieldByName('Status').AsInteger := 1; //Pesquisar Endereco 0-Novo 1-Existe
               FieldByName('Peso').AsFloat        := StrToFloatDef(EdtPesoCE.Text, 0);
               FieldByName('Altura').AsFloat      := StrToFloatDef(EdtAlturaCE.Text, 0);
               FieldByName('Largura').AsFloat     := StrToFloatDef(EdtLarguraCE.Text, 0);
               FieldByName('Comprimento').AsFloat := StrToFloatDef(EdtComprimentoCE.Text, 0);
               FieldByName('Volume').AsFloat      := StrToFloatDef(EdtVolumeCE.Text, 0);
             End;
             TotEndCreate := TotEndCreate + 1;
          End;
          if StrToIntDef(EdtIntervaloAp.Text, 0) > 0 then Begin
             Step(ContGav, StrToIntDef(EdtIntervaloAp.Text, 0));
             if ContGav > StrToIntDef(EdtAptoFinalCE.Text, 0) then
                Break;
          End;
        End;
  if Not FDMemCreateMultiploEndereco.IsEmpty then
     FDMemCreateMultiploEndereco.First;
  MostraCreateAddress;
end;

procedure TFrmEnderecamento.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtEnderecoId.Text := LstCadastro.Cells[0, aRow];
  EdtEnderecoIdExit(EdtEnderecoId);
end;

function TFrmEnderecamento.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para pesquisar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaEnderecos(StrToIntDef(EdtConteudoPesq.Text, 0), 0, 0, '', '')
        else raise Exception.Create('Endereço Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then
        Result := GetListaEnderecos(0, 0, 0, EdtConteudoPesq.Text, EdtConteudoPesq.Text)
     Else if CbCampoPesq.ItemIndex = 2 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaEnderecos(0, StrToIntDef(EdtConteudoPesq.Text, 0), 0, '', '')
        else raise Exception.Create('Estrutura Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 3 then
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaEnderecos(0, 0, StrToIntDef(EdtConteudoPesq.Text, 0), '', '')
        else raise Exception.Create('Zona Id inválido para pesquisar!');
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmEnderecamento.PgcBaseChange(Sender: TObject);
begin
  inherited;
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamentos - Manutenção') then Begin
     PgcBase.ActivePageIndex := 1;
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  End;
end;

procedure TFrmEnderecamento.RgManutencaoClick(Sender: TObject);
begin
  inherited;
  TabManutencaoOnOff(RgManutencao.ItemIndex);
end;

function TFrmEnderecamento.SalvarReg: Boolean;
Var vErro : String;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  ObjEnderecoCtrl.ObjEndereco.EnderecoId  := StrToIntDef(EdtEnderecoId.Text, 0);
  ObjEnderecoCtrl.ObjEndereco.Descricao := EdtEndereco.Text;
  ObjEnderecoCtrl.ObjEndereco.EnderecoRua.RuaId := StrToIntDef(EdtRuaId.Text,0);
  ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId := StrToIntDef(EdtEstruturaId.Text, 0);
  ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId      := StrToIntDef(EdtZonaId.Text, 0);
  ObjEnderecoCtrl.ObjEndereco.DesenhoArmazem.Id := StrToIntDef(EdtArmazemId.Text, 0);
  ObjEnderecoCtrl.ObjEndereco.Altura      := EdtAltura.Value;
  ObjEnderecoCtrl.ObjEndereco.Largura     := EdtLargura.Value;
  ObjEnderecoCtrl.ObjEndereco.Comprimento := EdtComprimento.Value;
  ObjEnderecoCtrl.ObjEndereco.Volume      := EdtVolume.Value;
  ObjEnderecoCtrl.ObjEndereco.Capacidade  := EdtPeso.Value;
  If ChkCadastro.Checked Then
     ObjEnderecoCtrl.ObjEndereco.Status := 1
  Else
     ObjEnderecoCtrl.ObjEndereco.Status := 0;
  If ChkBloqueado.Checked Then
     ObjEnderecoCtrl.ObjEndereco.Bloqueado := 1
  Else
     ObjEnderecoCtrl.ObjEndereco.Bloqueado := 1;
  If Not ObjEnderecoCtrl.Salvar.TryGetValue('Erro', vErro) then Begin
     ObjEnderecoCtrl.ObjEndereco.EnderecoId := 0;
     Result := True
  End
  Else Result := False;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmEnderecamento.SbSalvarCreateAddressClick(Sender: TObject);
Var ObjEnderecoCtrl   : TEnderecoCtrl;
    JsonObjectRetorno : TJsonObject;
    xEndereco : Integer;
    vErro     : String;
    vColor    : TColor;
    xTotalEnderecoCreate : Integer;
begin
  inherited;
  xTotalEnderecoCreate := 0;
  ObjEnderecoCtrl := TEnderecoCtrl.Create;
  for xEndereco := 1 to Pred(LstCreateAddress.RowCount) do Begin
    //Verificar no Grid se Endereço não existe para criar
    ObjEnderecoCtrl.ObjEndereco.EnderecoId := 0;
    ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId := StrToIntDef(EdtEstruturaIdCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.EnderecoRua.RuaId             := StrToIntDef(EdtRuaIdCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId      := StrToIntDef(EdtZonaIdCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.Descricao                     := StringReplace(LstCreateAddress.Cells[0, xEndereco], '.', '', [rfReplaceAll]);
    ObjEnderecoCtrl.ObjEndereco.DesenhoArmazem.Id             := StrToIntDef(EdtArmazemIdCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.Altura                        := StrToIntDef(EdtAlturaCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.Largura                       := StrToIntDef(EdtLarguraCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.Comprimento                   := StrToIntDef(EdtComprimentoCE.Text, 0);
    ObjEnderecoCtrl.ObjEndereco.Capacidade                    := StrToIntDef(EdtPesoCE.Text, 0);
    JsonObjectRetorno := ObjEnderecoCtrl.Salvar;
    if JsonObjectRetorno.TryGetValue('Erro', vErro) then Begin
       LstCreateAddress.Cells[6, xEndereco] := '0';
       vColor := clRed;
    End
    Else Begin
      vColor := $00DFFFDF;
      inc(xTotalEnderecoCreate);
    End;
    LstCreateAddress.Row := xEndereco;
    LstCreateAddress.Colors[1, xEndereco] := vColor;
    LstCreateAddress.Colors[2, xEndereco] := vColor;
    LstCreateAddress.Colors[3, xEndereco] := vColor;
    LstCreateAddress.Colors[4, xEndereco] := vColor;
    LstCreateAddress.Colors[5, xEndereco] := vColor;
  End;
  ShowMessage('Processo concluído! '+xTotalEnderecoCreate.ToString()+' criado(s).');
  SbSalvarCreateAddress.visible := False;
  ObjEnderecoCtrl.Free;
  ClearBlocoEnderecoCreate;
end;

procedure TFrmEnderecamento.SbSalvarExcluirClick(Sender: TObject);
Var ObjEnderecoCtrl : TEnderecoCtrl;
    JsonManutencao    : TJsonObject;
    JsonArrayTipoAcao : TJsonArray; //Ativar/Desatibar/<Des>Bloquear
    ArrayJsonEndereco : TJsonArray;
    xEndereco         : Integer;
    vErro             : String;
begin
  inherited;
  if Trim(TPanel(Sender).Caption) = 'Buscar Endereços' then Begin
     if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
        GetEndereco(Sender, LstManutencaoAtivaDesativa);
        //Else SalvarAtivaDesativa;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
        GetEndereco(Sender, LstManutencaoMudarZona);
        //Else SalvarMudarZona;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
        GetEndereco(Sender, LstManutencaoCubagem);
        //Else SalvarMudarZona;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
        GetEndereco(Sender, LstManutencaoExcluir);
        //Else SalvarMudarZona;
     End
     Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
        GetEndereco(Sender, LstManutencaoRemoverVinculo);
        //Else SalvarMudarZona;
     End
     Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
        if EdtZonaIdQR.Text = '' then Begin
           ShowErro('Informe uma Zona de Picking.');
           EdtZonaIdQR.SetFocus;
           Exit;
        End;
        GetEndereco(Sender, LstQuebraRua);
        //Else SalvarMudarZona;
     End;
  End
  Else Begin
    if PgcManutencao.ActivePage = TabManutencaoAtivaDesativa then Begin
       if (Not ChkManutencaoAtivar.Checked) and (Not ChkManutencaodesativar.Checked) and
          (Not ChkBloquear.Checked) and (Not ChkDesbloquear.Checked) then
          raise Exception.Create('Informe a ação desejada. Ativar ou Desativar.');
       If StrToIntDef(LblTotRegistroOnOff.Caption, 0) <= 0 then Begin
         ShowErro('Selecione os endereços para aplicar a manutenção.');
         Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonArrayTipoAcao := TJsonArray.Create;
       JsonManutencao.AddPair('operacao', 'AtivaDesativa');
       if ChkManutencaoAtivar.Checked then
          JsonArrayTipoAcao.AddElement(TJsonObject.Create.AddPair('acao', 'ativar'))
       Else if ChkManutencaoDesativar.Checked then
          JsonArrayTipoAcao.AddElement(TJsonObject.Create.AddPair('acao', 'desativar'));
       if ChkBloquear.Checked then
          JsonArrayTipoAcao.AddElement(TJsonObject.Create.AddPair('acao', 'bloquear'))
       Else if ChkDesbloquear.Checked then
          JsonArrayTipoAcao.AddElement(TJsonObject.Create.AddPair('acao', 'desbloquear'));
       JsonManutencao.AddPair('acao', JsonArrayTipoAcao);
       ArrayJsonEndereco := TJsonArray.Create;
       for xEndereco := 1 to Pred(LstManutencaoAtivaDesativa.RowCount) do Begin
         if LstManutencaoAtivaDesativa.Cells[10, xEndereco] = '1' then
            ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', StringReplace(LstManutencaoAtivaDesativa.Cells[1, xEndereco], '.','', [rfReplaceAll])));
       End;
    End
    Else if PgcManutencao.ActivePage = TabManutencaoMudarZona then Begin
       If EdtZonaIdNova.Text = '' then
          raise Exception.Create('Informe a nova zona para o endereços selecionados');
       If StrToIntDef(LblTotRegistroMudarZona.Caption, 0) <= 0 then Begin
         ShowErro('Selecione os endereços para aplicar a manutenção.');
         Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonManutencao.AddPair('operacao', 'MudarZona');
       JsonManutencao.AddPair('zonaid', TJsonNumber.Create(StrToIntDef(EdtZonaIdNova.Text, 0)));
       ArrayJsonEndereco := TJsonArray.Create;
       for xEndereco := 1 to Pred(LstManutencaoMudarZona.RowCount) do Begin
         if LstManutencaoMudarZona.Cells[10, xEndereco] = '1' then
            ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', StringReplace(LstManutencaoMudarZona.Cells[1, xEndereco], '.','', [rfReplaceAll])));
       End;
    End
    Else if PgcManutencao.ActivePage = TabManutencaoCubagem then Begin
       If StrToIntDef(LblTotRegistroCubagem.Caption, 0) <= 0 then Begin
         ShowErro('Selecione os endereços para aplicar a manutenção.');
         Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonManutencao.AddPair('operacao', 'Cubagem');
       JsonManutencao.AddPair('altura',      TJsonNumber.Create(EdtAlturaManutencao.Value));
       JsonManutencao.AddPair('largura',     TJsonNumber.Create(EdtLarguraManutencao.Value));
       JsonManutencao.AddPair('comprimento', TJsonNumber.Create(EdtComprimentoManutencao.Value));
       JsonManutencao.AddPair('peso',        TJsonNumber.Create(EdtPesoManutencao.Value));
       ArrayJsonEndereco := TJsonArray.Create;
       for xEndereco := 1 to Pred(LstManutencaoCubagem.RowCount) do Begin
         if LstManutencaoCubagem.Cells[13, xEndereco] = '1' then
            ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', StringReplace(LstManutencaoCubagem.Cells[1, xEndereco], '.','', [rfReplaceAll])));
       End;
    End
    Else if PgcManutencao.ActivePage = TabManutencaoExcluir then Begin
       If StrToIntDef(LblTotRegistroExcluir.Caption, 0) <= 0 then Begin
         ShowErro('Selecione os endereços para aplicar a manutenção.');
         Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonManutencao.AddPair('operacao', 'Excluir');
       ArrayJsonEndereco := TJsonArray.Create;
       for xEndereco := 1 to Pred(LstManutencaoExcluir.RowCount) do Begin
         if LstManutencaoExcluir.Cells[10, xEndereco] = '1' then
            ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', StringReplace(LstManutencaoExcluir.Cells[1, xEndereco], '.','', [rfReplaceAll])));
       End;
    End
    Else if PgcManutencao.ActivePage = TabManutencaoTransferenciaPicking then Begin
       if ((EdtPickingAtual.Text = '') or (EdtPickingNovo.Text = '')) then Begin
          ShowErro('Informe o Picking Atual e Novo para realizar a transferência.');
          Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonManutencao.AddPair('operacao', 'Transferencia');
       JsonManutencao.AddPair('picking', EdtPickingAtual.Text);
       JsonManutencao.AddPair('pickingnovo', EdtPickingNovo.Text);
       ArrayJsonEndereco := TJsonArray.Create;
        ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', ''));
    End
    Else if PgcManutencao.ActivePage = TabManutencaoRemoverVinculo then Begin
       If StrToIntDef(LblTotRegistroRemoverPicking.Caption, 0) <= 0 then Begin
         ShowErro('Selecione os endereços para aplicar a manutenção.');
         Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonManutencao.AddPair('operacao', 'RemoverVinculo');
       ArrayJsonEndereco := TJsonArray.Create;
       for xEndereco := 1 to Pred(LstManutencaoRemoverVinculo.RowCount) do Begin
         if LstManutencaoRemoverVinculo.Cells[10, xEndereco] = '1' then
            ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', StringReplace(LstManutencaoRemoverVinculo.Cells[1, xEndereco], '.','', [rfReplaceAll])));
       End;
    End
    Else if PgcManutencao.ActivePage = TabQuebraRuaPicking then Begin
       if StrToIntDef(EdtZonaIdQR.Text, 0) <= 0 then Begin
         ShowErro('Informe a Zona/Setor para Quebra de Rua.');
         Exit;
       End;
       if StrToIntDef(EdtZonaIdQR.Text, 0) <= 0 then Begin
         ShowErro('Informe a Rua para Quebra de Picking.');
         Exit;
       End;
       If (LstQuebraRua.RowCount <= 1) then Begin
         ShowErro('Selecione os endereços para aplicar a manutenção de Quebra de Rua.');
         Exit;
       End;
       JsonManutencao := TJsonObject.Create;
       JsonManutencao.AddPair('operacao', 'QuebraRuaPicking');
       JsonManutencao.AddPair('ruaid', TJsonNumber.Create(StrToIntDef(EdtRuaIdQR.Text, 0)));
       ArrayJsonEndereco := TJsonArray.Create;
       for xEndereco := 1 to Pred(LstQuebraRua.RowCount) do Begin
         if LstQuebraRua.Cells[9, xEndereco] = '1' then
            ArrayJsonEndereco.AddElement(TJsonObject.Create.AddPair('endereco', StringReplace(LstQuebraRua.Cells[1, xEndereco], '.','', [rfReplaceAll])));
       End;
    End;
    if (ArrayJsonEndereco.Count > 0) then Begin
       JsonManutencao.AddPair('lista', ArrayJsonEndereco);
       ObjEnderecoCtrl := TEnderecoCtrl.Create;
       If ObjEnderecoCtrl.Manutencao(JsonManutencao).TryGetValue('Erro', vErro) then
          ShowErro(verro)
       Else ShowOk('Manutenção realizada com sucesso!');
       ObjEnderecoCtrl.Free
    End
    Else Begin
      ShowErro('Não foi selecionado dados para manutenção!');
      JsonManutencao.Free;
      Exit;
    End;
    JsonManutencao.Free;
    LimparManutencao;
  End;
end;

procedure TFrmEnderecamento.SbSimularCreateAddressClick(Sender: TObject);
begin
  inherited;
  if EdtIntervaloAp.Text = '' then Begin
     ShowErro('Informe o intervalo entre Apart./Gaveta ou informe 0(Zero) para sequencial!!!');
     EdtIntervaloAp.SetFocus;
     Exit;
  End;
  if StrToIntDef(EdtArmazemIdCE.Text, 0) <= 0 then Begin
     ShowErro('Informe o Armazém no qual será criado os endereços!!!');
     EdtArmazemIdCE.SetFocus;
     Exit;
  End
  Else if StrToIntDef(EdtEstruturaIdCE.Text, 0) <= 0 then Begin
     ShowErro('Informe a Estrutura dos endereços para criar!!!');
     EdtEstruturaIdCE.SetFocus;
     Exit;
  End
  Else if StrToIntDef(EdtZonaIdCE.Text, 0) = 0 then Begin
     ShowErro('Informe o Setor/Zona referente aos endereços');
     EdtZonaIdCE.SetFocus;
     Exit;
  End
  Else if StrToIntDef(EdtRuaIdCe.Text, 0) = 0 then Begin
     ShowErro('Informe a Rua física referente aos endereços');
     EdtRuaIdCe.SetFocus;
     Exit;
  End
  Else If (EdtFaixaInicialEndereco.Text<>'') and (EdtFaixaFinalEndereco.Text='') then Begin
     ShowErro('Informe o Endereço Final da Faixa a ser criada');
     EdtFaixaFinalEndereco.SetFocus;
     Exit;
  End
  Else If (EdtFaixaInicialEndereco.Text='') and (EdtFaixaFinalEndereco.Text<>'') then Begin
     ShowErro('Informe o Endereço Inicial da Faixa a ser criada');
     EdtFaixaInicialEndereco.SetFocus;
     Exit;
  End
  Else If PnlBlocoEnderecoCreate.Visible then Begin
     if StrToIntDef(EdtRuaInicialCE.Text, 0) <= 0 then Begin
        ShowErro('Rua inicial inválida!!!');
        EdtRuaInicialCE.SetFocus;
        Exit;
     End
     else if StrToIntDef(EdtPredioInicialCE.Text, 0) <= 0 then Begin
        ShowErro('Prédio inicial inválida!!!');
        EdtPredioInicialCE.SetFocus;
        Exit;
     End
     Else if (StrToIntDef(EdtEstruturaIdCE.Text, 0) <> 2) and (StrToIntDef(EdtNivelInicialCE.Text, 0) <= 0) then Begin
        ShowErro('Nível inicial inválida!!!');
        EdtAptoFinalCE.SetFocus;
        Exit;
     End
     Else If StrToIntDef(EdtAptoInicialCE.Text, 0) <= 0 then Begin
        ShowErro('Apto/Gaveta inicial inválido!!!');
        EdtAptoInicialCE.SetFocus;
        Exit;
     End;
  End;
  mostraSimulacaoEndereco;
end;

procedure TFrmEnderecamento.ShowDados;
begin
  inherited;
  If EdtEnderecoId.Text='' then
     EdtEnderecoId.Text := FdMemEnderecamentos.FieldByName('EnderecoId').AsString;
  EdtEndereco.Text      := FdMemEnderecamentos.FieldByName('Descricao').AsString;
  EdtEstruturaId.Text   := FdMemEnderecamentos.FieldByName('EstruturaId').AsString;
  LblEstrutura.Caption  := FdMemEnderecamentos.FieldByName('Estrutura').AsString;
  EdtRuaId.Text         := FdMemEnderecamentos.FieldByName('RuaId').AsString;
  LblRua.Caption        := FdMemEnderecamentos.FieldByName('Rua').AsString;
  EdtZonaId.Text        := FdMemEnderecamentos.FieldByName('ZonaId').AsString;
  LblZona.Caption       := FdMemEnderecamentos.FieldByName('Zona').AsString;
  EdtArmazemId.Text     := FdMemEnderecamentos.FieldByName('ArmazemId').AsString;
  LblArmazem.Caption    := FdMemEnderecamentos.FieldByName('Armazem').AsString;
  EdtPeso.Value         := FdMemEnderecamentos.FieldByName('Capacidade').AsFloat;
  EdtAltura.Value       := FdMemEnderecamentos.FieldByName('Altura').AsFloat;
  EdtLargura.Value      := FdMemEnderecamentos.FieldByName('Largura').AsFloat;
  EdtComprimento.Value  := FdMemEnderecamentos.FieldByName('Comprimento').AsFloat;
  EdtVolume.Value       := (FdMemEnderecamentos.FieldByName('Altura').AsFloat*
                            FdMemEnderecamentos.FieldByName('Largura').AsFloat*
                            FdMemEnderecamentos.FieldByName('comprimento').AsFloat);
  ChkCadastro.Checked   := FdMemEnderecamentos.FieldByName('Status').AsInteger = 1;
  ChkBloqueioInventario.Checked := FdMemEnderecamentos.FieldByName('BloqueioInventario').AsInteger = 1;
  if ChkCadastro.Checked then Begin
    ShCadastro.Brush.Color := ClGreen;
    ShCadastro.Pen.Color   := ClGreen;
  End
  Else Begin
    ShCadastro.Brush.Color := ClRed;
    ShCadastro.Pen.Color   := ClRed;
  End;
end;

procedure TFrmEnderecamento.TabListagemShow(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmEnderecamento.TabManutencaoAtivaDesativaShow(Sender: TObject);
begin
  inherited;
  if Sender = TabManutencaoAtivaDesativa then Begin
     CbEstruturaAtivaDesativa.Enabled := True;
     EdtZonaIdAtivaDesativa.ReadOnly  := False;
     GbEnderecoAtivaDesativa.Enabled  := True;
     EdtEnderecoIniAtiva.ReadOnly     := False;
     EdtEnderecoFinAtiva.ReadOnly     := False;
     ChkManutencaoAtivar.Enabled      := True;
     ChkManutencaoDesativar.Enabled   := True;
     ChkBloquear.Enabled              := True;
     ChkDesbloquear.Enabled           := True;
  End
  Else if Sender = TabManutencaoMudarZona then Begin
     CbEstruturaMudarZona.Enabled     := True;
     EdtZonaIdMudarZona.ReadOnly      := False;
     GbEnderecoMudarZona.Enabled      := True;
     EdtEnderecoIniMudarZona.ReadOnly := False;
     EdtEnderecoFinMudarZona.ReadOnly := False;
     EdtZonaIdNova.ReadOnly           := False;
  End
  Else if Sender = TabManutencaoCubagem then Begin
     CbEstruturaCubagem.Enabled        := True;
     EdtZonaIdCubagem.ReadOnly         := False;
     GbEnderecoCubagem.Enabled         := True;
     EdtEnderecoIniCubagem.ReadOnly    := False;
     EdtEnderecoFinCubagem.ReadOnly    := False;
     EdtPesoManutencao.ReadOnly        := False;
     EdtAlturaManutencao.ReadOnly      := False;
     EdtLarguraManutencao.ReadOnly     := False;
     EdtComprimentoManutencao.ReadOnly := False;
     EdtVolumeManutencao.Clear;
  End
  Else if Sender = TabManutencaoExcluir then Begin
     CbEstruturaExcluir.Enabled     := True;
     EdtZonaIdExcluir.ReadOnly      := False;
     GbEnderecoExcluir.Enabled      := True;
     EdtEnderecoIniExcluir.ReadOnly         := False;
     EdtEnderecoFinExcluir.ReadOnly         := False;
  End
  Else if Sender = TabManutencaoTransferenciaPicking then Begin
     EdtPickingAtual.ReadOnly := False;
     EdtPickingNovo.ReadOnly  := False;
     EdtPickingNovo.SetFocus;
     SbSalvarTransferenciaPicking.Visible   := False;
  End
  Else if Sender = TabManutencaoRemoverVinculo then Begin
     CbEstruturaRemoverVinculo.Enabled     := True;
     EdtZonaIdRemoverVinculo.ReadOnly      := False;
     GbEnderecoRemoverVinculo.Enabled      := True;
     EdtEnderecoIniRemoverVinculo.ReadOnly := False;
     EdtEnderecoFinRemoverVinculo.ReadOnly := False;
     EdtZonaIdRemoverVinculo.ReadOnly      := False;
  End
  Else if Sender = TabQuebraRuaPicking then Begin
     EdtZonaIdQr.ReadOnly             := False;
     EdtEnderecoQRInicial.ReadOnly    := False;
     EdtEnderecoQRFinal.ReadOnly      := False;
     EdtZonaIdRemoverVinculo.ReadOnly := False;
     EdtRuaIdQR.ReadOnly              := False;
  End
  Else if Sender = TabCreateAddress then Begin
     EdtArmazemIdCE.Text := '1';
     EdtArmazemIdCE.SetFocus;
     EdtArmazemIdCE.ReadOnly          := False;
     EdtEstruturaIdCE.ReadOnly        := False;
     EdtZonaIdCE.ReadOnly             := False;
     EdtRuaIdCe.ReadOnly              := False;
     EdtFaixaInicialEndereco.ReadOnly := False;
     EdtFaixaFinalEndereco.ReadOnly   := False;
     EdtRuaInicialCE.ReadOnly         := False;
     EdtRuaFinalCE.ReadOnly           := False;
     EdtPredioInicialCE.ReadOnly      := False;
     EdtPredioFinalCE.ReadOnly        := False;
     EdtNivelInicialCE.ReadOnly       := False;
     EdtNivelFinalCE.ReadOnly         := False;
     EdtAptoInicialCE.ReadOnly        := False;
     EdtAptoFinalCE.ReadOnly          := False;
     EdtIntervaloAp.ReadOnly          := False;
     EdtAlturaCE.ReadOnly             := False;
     EdtLarguraCE.ReadOnly            := False;
     EdtComprimentoCE.ReadOnly        := False;
     EdtLarguraCE.ReadOnly            := False;
     EdtVolumeCE.ReadOnly             := False;
  End;
  LimparManutencao;
//  if PgcManutencao.ActivePageIndex < 3 then
//     LimparLstManutencao;
end;

procedure TFrmEnderecamento.TabManutencaoEnderecoShow(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamentos - Manutenção')) then Begin
     ShowErro('Acesso não autorizado a esta funcionalidade!');
     PgcBase.ActivePage := tabPrincipal;
     Exit;
  End;
  inherited;
  RgManutencao.Enabled := True;
end;

procedure TFrmEnderecamento.TabManutencaoOnOff(pTabVisible : Integer);
begin
  TabManutencaoAtivaDesativa.TabVisible  := pTabVisible = 0;
  TabManutencaoMudarZona.TabVisible      := pTabVisible = 1;
  TabManutencaoCubagem.TabVisible        := pTabVisible = 2;
  TabManutencaoExcluir.TabVisible        := pTabVisible = 3;
  TabManutencaoTransferenciaPicking.TabVisible := pTabVisible = 4;
  TabManutencaoRemoverVinculo.TabVisible := pTabVisible = 5;
  TabCreateAddress.TabVisible            := pTabVisible = 6;
  TabQuebraRuaPicking.TabVisible         := pTabVisible = 7;
  TabManutencaoChoice.TabVisible         := pTabVisible = 99;
  Case pTabVisible Of
    0: PgcManutencao.ActivePage := TabManutencaoAtivaDesativa;
    1: PgcManutencao.ActivePage := TabManutencaoMudarZona;
    2: PgcManutencao.ActivePage := TabManutencaoCubagem;
    3: PgcManutencao.ActivePage := TabManutencaoExcluir;
    4: PgcManutencao.ActivePage := TabManutencaoTransferenciaPicking;
    5: PgcManutencao.ActivePage := TabManutencaoRemoverVinculo;
    6: PgcManutencao.ActivePage := TabCreateAddress;
    7: PgcManutencao.ActivePage := TabQuebraRuaPicking;
    99: PgcManutencao.ActivePage := TabManutencaoChoice;
  End;
  TabManutencaoAtivaDesativaShow(PgcManutencao.ActivePage);
end;

procedure TFrmEnderecamento.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  if EdtEndereco.Enabled then
     EdtEndereco.SetFocus;
end;

end.
