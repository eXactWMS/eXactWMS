unit uFrmInventario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, Generics.Collections,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, DataSet.Serialize, System.JSON, REST.Json, Rest.Types
  , InventarioCtrl
  , ProcessoCtrl, System.Math, ACBrBase, ACBrETQ, Vcl.DialogMessage,
  dxCameraControl, Vcl.WinXCtrls;

type
  TInventarioTipo = (poUndefined, poGeografico,  poPrioritario, poCiclíco);

  TFrmInventario = class(TFrmBase)
    Label2: TLabel;
    EdtInventarioId: TEdit;
    Label3: TLabel;
    EdtDataCriacao: TJvDateEdit;
    EdtDataLiberar: TLabel;
    EdtDataLiberacao: TJvDateEdit;
    LblProcesso: TLabel;
    Label4: TLabel;
    PnlZona: TPanel;
    LstZona: TAdvStringGrid;
    Label6: TLabel;
    FDMemEnderecoDisponivel: TFDMemTable;
    FDMemEnderecoSelecao: TFDMemTable;
    FDMemEnderecoSelecaoEnderecoId: TIntegerField;
    FDMemEnderecoSelecaoDescricao: TStringField;
    FDMemEnderecoSelecaoEstrutura: TStringField;
    FDMemEnderecoSelecaoMascara: TStringField;
    FDMemEnderecoSelecaoZona: TStringField;
    FDMemEnderecoDisponivelEnderecoId: TIntegerField;
    FDMemEnderecoDisponivelDescricao: TStringField;
    FDMemEnderecoDisponivelEstrutura: TStringField;
    FDMemEnderecoDisponivelMascara: TStringField;
    FDMemEnderecoDisponivelZona: TStringField;
    FDMemEnderecoDisponivelativo: TIntegerField;
    FDMemEnderecoSelecaoAtivo: TIntegerField;
    EdtMotivo: TEdit;
    Label9: TLabel;
    TabContagem: TcxTabSheet;
    PnlTopAcompanhamento: TPanel;
    PnlEnderecoContagem: TPanel;
    PnlEnderecoContagemTit: TPanel;
    PnlPnlTitEndContDivergente: TPanel;
    PnlPnlTitEndContEmContagem: TPanel;
    PnlPnlTitEndContConcluido: TPanel;
    LstEnderecoContagem: TAdvStringGrid;
    FDMemEndereco: TFDMemTable;
    FDMemEnderecoAtivo: TIntegerField;
    FDMemEnderecoEnderecoId: TIntegerField;
    FDMemEnderecoDescricao: TStringField;
    FDMemEnderecoEstrutura: TStringField;
    FDMemEnderecoMascara: TStringField;
    FDMemEnderecoZona: TStringField;
    FDMemEnderecoStatus: TStringField;
    BtnInventarioCancelar: TPanel;
    sImage2: TsImage;
    PnlTopResumo: TPanel;
    LblEnderecoTotal: TLabel;
    EdtEnderecoTotal: TEdit;
    Label11: TLabel;
    EdtEnderecoNaoContado: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    EdtEnderecoEmContagem: TEdit;
    EdtEnderecoConcluido: TEdit;
    LblEnderecoNaoContado: TLabel;
    LblEnderecoEmContagem: TLabel;
    LblEnderecoConcluido: TLabel;
    FdMemLoteInventariado: TFDMemTable;
    FdMemLoteInventariadoItemId: TIntegerField;
    FdMemLoteInventariadoInventarioId: TIntegerField;
    FdMemLoteInventariadoEnderecoId: TIntegerField;
    FdMemLoteInventariadoEndereco: TStringField;
    FdMemLoteInventariadoProdutoId: TIntegerField;
    FdMemLoteInventariadoCodProduto: TIntegerField;
    FdMemLoteInventariadoLoteId: TIntegerField;
    FdMemLoteInventariadoDescrLote: TStringField;
    FdMemLoteInventariadoFabricacao: TDateField;
    FdMemLoteInventariadoVencimento: TDateField;
    FdMemLoteInventariadoEstoqueInicial: TIntegerField;
    FdMemLoteInventariadoContagemId: TIntegerField;
    FdMemLoteInventariadoQuantidade: TIntegerField;
    FdMemLoteInventariadoStatus: TStringField;
    FdMemLoteInventariadoAutomatico: TIntegerField;
    FdMemLoteInventariadoDescricao: TStringField;
    FdMemLoteInventariadoQtdContagem: TIntegerField;
    TabApuracao: TcxTabSheet;
    PnlTopApuracao: TPanel;
    LstApuracao: TAdvStringGrid;
    FdMemApuracao: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField1: TStringField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField2: TStringField;
    IntegerField6: TIntegerField;
    StringField3: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    StringField4: TStringField;
    IntegerField11: TIntegerField;
    PnlTopApuracaoDetalhe: TPanel;
    Label23: TLabel;
    Label25: TLabel;
    LblProcesso_Apuracao: TLabel;
    Label24: TLabel;
    EdtDtInventario_Apuracao: TJvDateEdit;
    Panel1: TPanel;
    BtnInventarioFechar: TPanel;
    sImage1: TsImage;
    PgcTipoInventario: TcxPageControl;
    TabTipoGeografico: TcxTabSheet;
    TabTipoProduto: TcxTabSheet;
    PnlEndereco: TPanel;
    PnlEnderecoDisponivel: TPanel;
    LblEnderecoDisponivel: TLabel;
    LstEnderecoDisponivel: TAdvStringGrid;
    PnlDivisor01: TPanel;
    BtnSelDelete: TBitBtn;
    BtnSelInsert: TBitBtn;
    PnlEnderecoSelecao: TPanel;
    LblEnderecoSelecao: TLabel;
    LstEnderecoSelecao: TAdvStringGrid;
    PnlFiltroEndereco: TPanel;
    Label5: TLabel;
    LblEstrutura: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtEstruturaId: TEdit;
    BtnSchEstrutura: TBitBtn;
    EdtEnderecoInicial: TEdit;
    BtnPesqEnderecoInicial: TBitBtn;
    EdtEnderecoFinal: TEdit;
    BtnPesqEnderecoFinal: TBitBtn;
    PnlProduto: TPanel;
    PnlProdutoDisponivel: TPanel;
    LblProdutoDisponivel: TLabel;
    LstProdutoDisponivel: TAdvStringGrid;
    PnlProdutoRemove: TPanel;
    BtnProdutoRemove: TBitBtn;
    FDMemProdutoDisponivel: TFDMemTable;
    FDMemProdutoSelecao: TFDMemTable;
    FDMemProdutoDisponivelProdutoId: TIntegerField;
    FDMemProdutoDisponivelDescricao: TStringField;
    FDMemProdutoDisponivelPicking: TStringField;
    FDMemProdutoDisponivelZona: TStringField;
    FDMemProdutoSelecaoProdutoId: TIntegerField;
    FDMemProdutoSelecaoCodigoERP: TIntegerField;
    FDMemProdutoDisponivelCodigoERP: TIntegerField;
    FDMemProdutoSelecaoDescricao: TStringField;
    FDMemProdutoSelecaoZona: TStringField;
    FDMemProdutoSelecaoPicking: TStringField;
    Label30: TLabel;
    EdtProdutoInicial: TEdit;
    BtnPesqProdutoInicial: TBitBtn;
    EdtProduto: TEdit;
    BtnInsertProduto: TBitBtn;
    FDMemProdutoDisponivelSngpc: TIntegerField;
    RbInventarioTipo: TRadioGroup;
    FDMemProdutoDisponivelmascara: TStringField;
    TabTerceirizada: TcxTabSheet;
    Label26: TLabel;
    EdtFileName: TEdit;
    SbGerarArquivo: TPanel;
    sImage5: TsImage;
    GbFileType: TGroupBox;
    ChkProduto: TCheckBox;
    ChkEndereco: TCheckBox;
    ChkCabecalho: TCheckBox;
    Label27: TLabel;
    LblRegistro: TLabel;
    LblEstoqueImport: TLabel;
    Label31: TLabel;
    imgLancamentoOk: TImageList;
    BtnInconsistencia: TButton;
    ChkAnalisarInconsistencia: TCheckBox;
    ChkAtualizarPicking: TCheckBox;
    CbTipoAjuste: TComboBox;
    Label28: TLabel;
    FDMemProdutoDisponivelStatus: TStringField;
    BtnOpenDirTerceirizada: TsImage;
    OpenDlgArqTerceirizada: TOpenDialog;
    LblInventarioId_Apuracao: TLabel;
    Label10: TLabel;
    LblInventarioId_Contagem: TLabel;
    Button1: TButton;
    LblDtFinalizacao: TLabel;
    EdtDtFinalizacao: TJvDateEdit;
    LblHoraFechamento: TLabel;
    EdtPesqEndereco: TSearchBox;
    TabModeloPreDefinido: TcxTabSheet;
    RgTipoContagemPreDefinido: TRadioGroup;
    LstZonaPreDefinido: TAdvStringGrid;
    Label14: TLabel;
    EdtModeloPreDefinido: TEdit;
    GbFiltroContagemPreDefinido: TGroupBox;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label32: TLabel;
    EdtEstruturaIdPreDefinido: TEdit;
    BtnPesqEstruturaPreDefinido: TBitBtn;
    LblEstruturaPreDefinido: TLabel;
    Label34: TLabel;
    EdtEnderecoInicialPreDefinido: TEdit;
    EdtEnderecoFinalPreDefinido: TEdit;
    Label35: TLabel;
    BtnPesqEnderecoInicialPreDefinido: TBitBtn;
    BtnPesqEnderecoFinalPreDefinido: TBitBtn;
    Label40: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    EdtRuaInicialModelo: TEdit;
    EdtRuaFinalModelo: TEdit;
    ChkRuaParModelo: TCheckBox;
    ChkRuaImparModelo: TCheckBox;
    Label41: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    EdtPredioInicialModelo: TEdit;
    EdtPredioFinalModelo: TEdit;
    ChkPredioParModelo: TCheckBox;
    ChkPredioImparModelo: TCheckBox;
    Label42: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    EdtNivelInicialModelo: TEdit;
    EdtNivelFinalModelo: TEdit;
    ChkNivelParModelo: TCheckBox;
    ChkNivelImparModelo: TCheckBox;
    Label43: TLabel;
    EdtAptoInicialModelo: TEdit;
    Label49: TLabel;
    EdtAptoFinalModelo: TEdit;
    Label48: TLabel;
    ChkAptoParModelo: TCheckBox;
    ChkAptoImparModelo: TCheckBox;
    LstModeloPredefinido: TAdvStringGrid;
    Label22: TLabel;
    FDMemInventarioModelo: TFDMemTable;
    EdtZonaIdPreDefinido: TEdit;
    BtnPesqZonaPreDefinido: TBitBtn;
    LblZonaPreDefinido: TLabel;
    Label29: TLabel;
    FdMemEnderecoModelo: TFDMemTable;
    BtnConferiModelo: TBitBtn;
    LblObsModeloReposicao: TLabel;
    BtnGerarInventarioModeloPreDefinido: TPanel;
    sImage3: TsImage;
    PnlEnderecoModeloPreDefinido: TPanel;
    LstEnderecoModeloPreDefinido: TAdvStringGrid;
    PnlTitEnderecoModeloPreDefinido: TPanel;
    FdMemApuracaoContagemIniciada: TStringField;
    FDMemEnderecoDisponivelZonaId: TIntegerField;
    FDMemEnderecoDisponivelReservadoInventario: TIntegerField;
    FdMemApuracaoAjuste: TIntegerField;
    PnlContagemAjuste: TPanel;
    PnlResumoContagem: TPanel;
    Label21: TLabel;
    LstContagemLote: TAdvStringGrid;
    PnlDetalheAjuste: TPanel;
    LstDetalheAjuste: TAdvStringGrid;
    PnlTopAjuste: TPanel;
    LblEnderecoContagem: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LblLote: TLabel;
    LblProdutoContagem: TLabel;
    EdtEnderecoContagem: TEdit;
    EdtEstoqueInicial: TEdit;
    EdtContagem: TEdit;
    CbEnderecoStatus: TComboBox;
    EdtSaldo: TEdit;
    EdtAjuste: TEdit;
    EdtLote: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEstruturaIdChange(Sender: TObject);
    procedure EdtEstruturaIdExit(Sender: TObject);
    procedure BtnSchEstruturaClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure LstZonaClick(Sender: TObject);
    procedure LstZonaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtInventarioIdChange(Sender: TObject);
    procedure EdtInventarioIdExit(Sender: TObject);
    procedure BtnPesqEnderecoInicialClick(Sender: TObject);
    procedure EdtEnderecoFinalExit(Sender: TObject);
    procedure BtnPesqEnderecoFinalClick(Sender: TObject);
    procedure EdtEnderecoInicialExit(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure LstEnderecoDisponivelClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure EdtEnderecoInicialKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSelInsertClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LstEnderecoSelecaoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnSelDeleteClick(Sender: TObject);
    procedure BtnInventarioCancelarClick(Sender: TObject);
    procedure BtnInventarioFecharClick(Sender: TObject);
    procedure LstDetalheAjusteClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstEnderecoContagemClick(Sender: TObject);
    procedure LstEnderecoContagemClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure LstDetalheAjusteClick(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure BtnPesqProdutoFinalClick(Sender: TObject);
    procedure EdtProdutoInicialEnter(Sender: TObject);
    procedure EdtProdutoInicialExit(Sender: TObject);
    procedure BtnInsertProdutoClick(Sender: TObject);
    procedure EdtProdutoInicialChange(Sender: TObject);
    procedure LstProdutoDisponivelClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure BtnProdutoRemoveClick(Sender: TObject);
    procedure RbInventarioTipoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnInsertProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnInsertProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnInsertProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChkProdutoClick(Sender: TObject);
    procedure ChkEnderecoClick(Sender: TObject);
    procedure SbGerarArquivoClick(Sender: TObject);
    //procedure BtnOpeFileClick(Sender: TObject);
    procedure TabimportacaoCSVShow(Sender: TObject);
    procedure BtnImportaFileClick(Sender: TObject);
    procedure DbgImportaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BtnInconsistenciaClick(Sender: TObject);
    procedure BtnOpenDirTerceirizadaClick(Sender: TObject);
    procedure EdtProdutoInicialKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtInventarioIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure TabContagemShow(Sender: TObject);
    procedure EdtPesqEnderecoInvokeSearch(Sender: TObject);
    procedure PgcBaseChange(Sender: TObject);
    procedure EdtEnderecoInicialPreDefinidoChange(Sender: TObject);
    procedure EdtEnderecoFinalPreDefinidoChange(Sender: TObject);
    procedure EdtRuaInicialModeloExit(Sender: TObject);
    procedure TabModeloPreDefinidoShow(Sender: TObject);
    procedure LstModeloPredefinidoDblClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure EdtModeloPreDefinidoExit(Sender: TObject);
    procedure EdtModeloPreDefinidoChange(Sender: TObject);
    procedure EdtModeloPreDefinidoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtZonaIdPreDefinidoExit(Sender: TObject);
    procedure BtnPesqZonaPreDefinidoClick(Sender: TObject);
    procedure EdtZonaIdPreDefinidoChange(Sender: TObject);
    procedure BtnConferiModeloClick(Sender: TObject);
    procedure EdtRuaInicialModeloChange(Sender: TObject);
    procedure ChkRuaParModeloClick(Sender: TObject);
    procedure LstModeloPredefinidoClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure BtnGerarInventarioModeloPreDefinidoClick(Sender: TObject);
    procedure EdtRuaInicialModeloKeyPress(Sender: TObject; var Key: Char);
    procedure FdMemApuracaoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    SelZona, SelDisponivel, SelSelecao, SelModelo : Boolean;
    ObjInventarioCtrl : TInventarioCtrl;
    InventarioTipo    : TInventarioTipo;
    InventarioNaoIniciado : Boolean;
    Procedure GetEnderecamentoZonas;
    Procedure MontaListaEnderecoDisponivel;
    Procedure MontaListaEnderecoSelecao;
    Procedure MontaListaEnderecoContado;
    Procedure MontaListaProdutoContado;
    Procedure AtualizaEnderecoSelecao;
    Function GetListainventario(pInventarioId : Integer; pDataCriacao, pDataFinalizacao : TDateTime; pDataCancelamento : TDateTime; pProcessoId : Integer; pTipo : Integer; pPendente : Integer) : Boolean;
    Procedure GetInventarioEndereco;
    Procedure GetInventarioProduto;
    Procedure ClearDetalheAjuste;
    Procedure BuscarInventarioInicial;
    procedure MontaListaLoteInventariado;
    Procedure GetContagemLote(pItem : Integer);
    Procedure ShowLoteContado;
    Procedure GetApuracao;
    Procedure MontaListaApuracao;
    Procedure SelecionarEnderecoPorListaZona;
    Procedure SelecionarProdutoPorListaZona;
    Procedure MontaListaProdutoDisponivel(pSearchInventario : Boolean = False);
    Procedure DefineInventarioTipo;
    Procedure AtivarPnlProduto(OnOff : Boolean);
    Procedure DefineField;
    Procedure ShowFinalizacao(OnOff : Boolean);
    Procedure LimparPreDefinido;
    Function ShowInventarioModeloLista(pModeloId, pShowErro : Integer) : TJsonArray;
    Procedure ShowInventarioModelo;
    Procedure GetEnderecoZonaPreDefinido;
    procedure GetEnderecoZonaPreDefinidoClear;
    Procedure FiltraEnderecoPreDefinido;
    Procedure MontaEnderecoModeloPreDefinido;
    Procedure validarFiltroModeloPreDefinido(Sender : TObject);
  Protected
    Function DeleteReg : Boolean; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure Limpar; OverRide;
    Procedure OpenFileImport; OverRide;
    Procedure ProcessarFileImport; OverRide;
    Procedure Imprimir; OverRide;
  public
    { Public declarations }
  end;

var
  FrmInventario: TFrmInventario;

implementation

{$R *.dfm}

uses EnderecoCtrl, EnderecamentoEstruturaCtrl, EnderecamentoZonaCtrl,
  Views.Pequisa.Endereco, Views.Pequisa.EnderecamentoEstruturas, Views.Pequisa.EnderecamentoZonas, uFuncoes,
  ProdutoCtrl, uFrmeXactWMS, EstoqueCtrl, LoteCtrl;

procedure EmptyKeyQueue;
var
  LMessage: TMsg;
begin
  while PeekMessage(LMessage, 0, $0100, $0109, 1 or 2) do
      ;
end;

procedure EmptyMouseQueue;
var
  LMessage: TMsg;
begin
  while PeekMessage(LMessage, 0, $0200, $020E, 1 or 2) do
      ;
end;

procedure TFrmInventario.AtivarPnlProduto(OnOff: Boolean);
begin
  EdtProdutoInicial.ReadOnly    := Not OnOff;
  BtnPesqProdutoInicial.Enabled := OnOff;
  BtnInsertProduto.Enabled      := OnOff;
  PnlProdutoRemove.Enabled      := OnOff;
end;

procedure TFrmInventario.AtualizaEnderecoSelecao;
begin
{
   If FdMemPesqGeral.Active then
      FdmemPesqGeral.EmptyDataSet;
   FdMemPesqGeral.Close;
   FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
   LstEnderecoSelecao.RowCount  := JsonArrayRetorno.Count+1;
   LstEnderecoSelecao.FixedRows := 1;
}
end;

procedure TFrmInventario.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if BtnCancelar.Grayed then Begin
     RbInventarioTipo.ItemIndex := -1;
     RbInventarioTipo.Enabled := False;
     DefineInventarioTipo;
     BtnExportarStand.Grayed  := False;
     BtnExportarStand.Enabled := True;
  End;
end;

procedure TFrmInventario.BtnConferiModeloClick(Sender: TObject);
begin
  if EdtEstruturaIdPreDefinido.Text = '' then Begin
     ShowErro('Informe o Tipo de Estrutura para contagem!');
     Exit;
  End;
  inherited;
  FiltraEnderecoPreDefinido
end;

procedure TFrmInventario.BtnEditarClick(Sender: TObject);
Var ObjProcessoCtrl  : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
    vProcessoId      : Integer;
    vErro            : String;
begin
  if PgcBase.ActivePage = TabPrincipal then Begin
     JsonArrayRetorno := ObjProcessoCtrl.GetProcesso('Inventario - Gerado');
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro(vErro);
        Exit;
     End;
     vProcessoId := JsonArrayRetorno.Items[0].GetValue<Integer>('codigo');
     if ObjInventarioCtrl.ObjInventario.ProcessoId <> vProcessoId then Begin
        ShowErro('Inventário não pode ser Editado.');
        //JsonArrayRetorno.DisposeOf;
        Exit;
     End;
     //JsonArrayRetorno.DisposeOf;
     inherited;
     PnlZona.Enabled     := True;
     if InventarioTipo = poGeografico then
        PnlEndereco.Enabled := True
     Else If InventarioTipo = poPrioritario Then
        AtivarPnlProduto(True);
     LstCadastro.Alignments[0 ,0] := taRightJustify;
     LstCadastro.FontStyles[0, 0] := [FsBold];
     GetEnderecamentoZonas;
     EdtDataCriacao.Enabled := False;
     EdtDataLiberacao.SetFocus;
     TabContagem.TabVisible   := False;
     TabApuracao.TabVisible   := False;
     RbInventarioTipo.Enabled := False;
     BtnExportarStand.Grayed  := True;
     BtnExportarStand.Enabled := False;
     ShowFinalizacao(False);
  End
  Else Begin
     if EdtModeloPreDefinido.Text = '' then
        ShowErro('Selecione um Modelo para Editar!')
     Else Begin
        inherited;
        TabPrincipal.TabVisible := False;
        TabModeloPreDefinido.TabVisible := True;
        PgcBase.ActivePage := TabModeloPreDefinido;
        RgTipoContagemPreDefinido.Enabled := False;
        EdtEstruturaIdPreDefinido.SetFocus;
        BtnConferiModelo.Enabled      := True;
        LblObsModeloReposicao.Visible := True;
        BtnGerarInventarioModeloPreDefinido.Visible := BtnSalvar.Grayed;
     End;
  End;
end;

procedure TFrmInventario.BtnExcluirClick(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Inventário - Excluir') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  if ObjInventarioCtrl.ObjInventario.processoid > 123 then
     if ObjInventarioCtrl.ObjInventario.processoid = 133 then
        raise Exception.Create('Exclusão não permitida! Cancele o inventário')
     Else
        raise Exception.Create('Exclusão não permitida!');
  inherited;
end;

procedure TFrmInventario.BtnExportarStandClick(Sender: TObject);
begin
//  inherited;
  If (BtnSalvar.Grayed) and (PgcBase.ActivePage <> TabApuracao) then Begin
     TabTerceirizada.TabVisible := True;
     PgcBase.ActivePage         := TabTerceirizada;
     GbFileType.Enabled         := True;
     ChkProduto.Enabled         := True;
     ChkEndereco.Enabled        := True;
     SbGerarArquivo.Visible     := True;
  End
  Else Begin
     if (Not FdMemApuracao.Active) or (FdMemApuracao.IsEmpty) then
        raise Exception.Create('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) or (FdMemApuracao.IsEmpty) then Exit;
     Try
       ExportarExcel(FdMemApuracao);
     Except
   //    result := False;
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End;
end;

procedure TFrmInventario.BtnGerarInventarioModeloPreDefinidoClick(Sender: TObject);
Var xModelo : Integer;
    vTotalInventario : integer;
    vErroInventario  : Integer;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  vTotalInventario := 0;
  vErroInventario  := 0;
  for xModelo := 1 to Pred(LstModeloPreDefinido.RowCount) do Begin
    if LstModeloPredefinido.Ints[0, xModelo] = 1 then Begin
       Inc(vTotalInventario);
       Break;
    End;
  End;
  if vTotalInventario < 1 then
     ShowMSG('Selecione pelo menos 1 modelo para gerar inventário!')
  Else Begin
     vTotalInventario := 0;
     for xModelo := 1 to Pred(LstModeloPreDefinido.RowCount) do Begin
       if LstModeloPredefinido.Ints[0, xModelo] = 1 then Begin
          JsonArrayRetorno := ObjInventarioCtrl.GerarNovoInventarioModelo(LstModeloPredefinido.Ints[1, xModelo]);
          if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
             LstModeloPredefinido.Colors[1, xModelo] := ClRed;
             ShowErro('Não foi possível geral inventário do Modelo: '+LstModeloPredefinido.Cells[1, xModelo]);
             Inc(vErroInventario);
          End
          else
             Inc(vTotalInventario);
          JsonArrayRetorno := Nil;
       End;
     End;
     if vTotalInventario < 1 then
        ShowErro('Não foi gerado inventário(s). '+vErroInventario.ToString+' apresentou erros.')
     Else Begin
        if vErroInventario > 0 then
           ShowOk('Gerado '+vTotalInventario.ToString()+' inventário(s) e '+vTotalInventario.ToString()+' com Erros!')
        Else
           ShowOk('Gerado '+vTotalInventario.ToString()+' inventário(s) com sucesso!');
     End;
  End;
end;

procedure TFrmInventario.BtnImportaFileClick(Sender: TObject);
begin
  inherited;
  ChkCabecalho.Checked     := False;
  LblRegistro.Caption      := '0';
  LblEstoqueImport.Caption := '0';
  BtnImport.Visible        := False;
end;

procedure TFrmInventario.BtnIncluirClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabModeloPreDefinido then Begin
     inherited;
     TabPrincipal.TabVisible := False;
     TabModeloPreDefinido.TabVisible := True;
     PgcBase.ActivePage := TabModeloPreDefinido;
     RgTipoContagemPreDefinido.Enabled := False;
     EdtEstruturaIdPreDefinido.SetFocus;
     BtnConferiModelo.Enabled      := True;
     LblObsModeloReposicao.Visible := True;
     BtnGerarInventarioModeloPreDefinido.Visible := BtnSalvar.Grayed;
     ChkRuaParModelo.Checked   := True;
     ChkRuaImparModelo.Checked := True;
     ChkPredioParModelo.Checked   := True;
     ChkPredioImparModelo.Checked := True;
     ChkNivelParModelo.Checked   := True;
     ChkNivelImparModelo.Checked := True;
     ChkAptoParModelo.Checked   := True;
     ChkAptoImparModelo.Checked := True;
  End
  Else Begin
     inherited;
     TabModeloPreDefinido.TabVisible := False;
     GetEnderecamentoZonas;
     CbTipoAjuste.ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioAjustePadrao;
     PnlZona.Enabled     := True;
     EdtDataCriacao.text := DateToStr(Now);
     EdtDataCriacao.Enabled := False;
     EdtDataLiberacao.SetFocus;
     BtnExportarStand.Grayed  := True;
     BtnExportarStand.Enabled := False;
     ShowFinalizacao(False);
     CbTipoAjuste.Enabled := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Inventários - Modificar Ajuste Padrão');
  End;
end;

procedure TFrmInventario.BtnInconsistenciaClick(Sender: TObject);
begin
  inherited;
  FdMemPesqGeral.Filter   := '(Picking = 0) or (Produto = 0)';
  FdmemPesqGeral.Filtered := True;
  Try
    DsPesqGeral.DataSet := nil;
    ExportarExcel(FdMemPesqGeral);
    DsPesqGeral.DataSet := FdMemPesqGeral;
  Except
//    result := False;
    raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
  End;
  FdMemPesqGeral.Filter   := '';
  FdmemPesqGeral.Filtered := False;
end;

procedure TFrmInventario.BtnInsertProdutoClick(Sender: TObject);
Var ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro      : String;
    xProduto   : Integer;
    vProdFound : Boolean;
begin
  keybd_event(VK_F2, 0, 0, 0);
  inherited;
  if (EdtProdutoInicial.Text='') or (StrToInt64Def(EdtProdutoInicial.Text, 0)<=0) then Begin
     ShowErro('Informe o código/ean do produto.');
     EdtProdutoInicial.SetFocus;
     Exit;
  End;
  ObjProdutoCtrl := TProdutoCtrl.Create();
  JsonArrayRetorno := ObjProdutoCtrl.GetProdutoList(0, StrToIntDef(EdtProdutoInicial.Text, 0), 0, 0, '');
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtProdutoInicial.SetFocus;
     FreeAndNil(ObjProdutoCtrl);
     raise Exception.Create('Erro: '+vErro);
  End;
//  for xProduto := 0 to Pred(JsonArrayRetorno.Count) do Begin
       FdMemProdutoDisponivel.Append;
       FdMemProdutoDisponivel.FieldByName('Produtoid').AsInteger := JsonArrayRetorno.Items[0].GetValue<Integer>('produtoid');
       FdMemProdutoDisponivel.FieldByName('CodigoERP').AsInteger := JsonArrayRetorno.Items[0].GetValue<Integer>('codigoerp');
       FdMemProdutoDisponivel.FieldByName('Descricao').AsString  := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
       FdMemProdutoDisponivel.FieldByName('Picking').AsString    := JsonArrayRetorno.Items[0].GetValue<String>('endereco');
       FdMemProdutoDisponivel.FieldByName('Zona').AsString       := JsonArrayRetorno.Items[0].GetValue<String>('zona');
       FdMemProdutoDisponivel.FieldByName('Sngpc').AsInteger     := JsonArrayRetorno.Items[0].GetValue<Integer>('sngpc', 0);
       FdMemProdutoDisponivel.Post;
//    End;
       MontaListaProdutoDisponivel;
  ObjProdutoCtrl.Free;
  EdtProdutoInicial.Clear;
  EdtProdutoInicial.SetFocus;
  EdtProdutoInicial.SetFocus;
end;

procedure TFrmInventario.BtnInsertProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  exit;
  key := 0;
  keybd_event(VK_F2, 0, 0, 0);
  inherited;
  EdtProdutoInicial.SetFocus;
end;

procedure TFrmInventario.BtnInsertProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  exit;
  key := #0;
  keybd_event(VK_F2, 0, 0, 0);
  inherited;
  EdtProdutoInicial.SetFocus;
end;

procedure TFrmInventario.BtnInsertProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  exit;
  Key := 0;
  EdtProdutoInicial.SetFocus;
end;

procedure TFrmInventario.BtnInventarioCancelarClick(Sender: TObject);
begin
  inherited;
  if BtnInventarioCancelar.Color = ClGray then Begin
     ShowOk('Função inativa');
     Exit;
  End;
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Inventário - Cancelar') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  if BtnInventarioCancelar.Color = ClGray then Begin
     ShowErro('Função inativa. Complete a contagem do inventário!');
     Exit;
  End;
  If ObjInventarioCtrl.Cancelar then Begin
     ShowOk('Inventário cancelado com sucesso!');
     EdtInventarioIdExit(EdtInventarioId);
  End
  Else
     ShowErro('Não foi possível cancelar o inventário.');
end;

procedure TFrmInventario.BtnInventarioFecharClick(Sender: TObject);
begin
  inherited;
  if BtnInventarioFechar.Color = ClGray then Begin
     ShowErro('Função inativa. Complete a contagem do inventário!');
     Exit;
  End;
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Inventário - Apuração Gerar') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  If ObjInventarioCtrl.InventarioFechar then Begin
     ShowOk('Inventário Fechado com sucesso!');
     EdtInventarioIdExit(EdtInventarioId);
  End
  Else
     ShowErro('Não foi possível Fechar o inventário.');
end;

procedure TFrmInventario.BtnOpenDirTerceirizadaClick(Sender: TObject);
begin
  inherited;
  if OpenDlgArqTerceirizada.execute then
     EdtFileName.Text := OpenDlgArqTerceirizada.FileName;
end;

procedure TFrmInventario.OpenFileImport; //BtnOpeFileClick(Sender: TObject);
var ArquivoCSV: TextFile;
    Linha, vErro      : String;
    I : Integer;
    vReg, vEstoqueImport : Integer;
    ObjProdutoCtrl    : TProdutoCtrl;
    ObjEnderecoCtrl   : TEnderecoCtrl;
    ArrayJsonEndereco : TJsonArray;
    ArrayJsonProduto  : TJsonArray;
    vInconsistencia   : Boolean;
    vProdutoId, vEnderecoId : Integer;
  Function MontaValor: String;
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
  AssignFile(ArquivoCSV, EdtFileIimport.Text);
  LblAguardeImportacaoCSV.Visible := True;
  FdMemPesqGeral.DisableControls;
  try
    TmImportacaoCSV.Enabled := True;
    Reset(ArquivoCSV);
    if ChkCabecalho.Checked then
       Readln(ArquivoCSV, Linha);    //Pular Cabecalho
    vReg            := 0;
    vEstoqueImport  := 0;
    vInconsistencia := False;
    while not Eoln(ArquivoCSV) do begin
      Readln(ArquivoCSV, Linha);
      I := 0;
      //vCdProduto := MontaValor;
      FdMemPesqGeral.Append;
      FdMemPesqGeral.FieldByName('CodProduto').AsInteger := StrToInt64(MontaValor);
      FdMemPesqGeral.FieldByName('Endereco').AsString    := MontaValor;
      FdMemPesqGeral.FieldByname('Quantidade').AsInteger := StrToIntDef(MontaValor, 0);
      ObjEnderecoCtrl := TEnderecoCtrl.Create;
      ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, FdMemPesqGeral.FieldByName('Endereco').AsString, FdMemPesqGeral.FieldByName('Endereco').AsString, 'T', 99, 0, 0);
      if Not (ArrayJsonEndereco.Items[0].TryGetValue('Erro', vErro)) then
         vEnderecoId := ArrayJsonEndereco.Items[0].GetValue<Integer>('enderecoid')
      Else vEnderecoid := 0;
      FdMemPesqGeral.FieldByname('EnderecoId').AsInteger := vEnderecoId;
      if (ChkAnalisarInconsistencia.Checked) or (ChkAtualizarPicking.Checked) then Begin
          if (ArrayJsonEndereco.Items[0].TryGetValue('Erro', vErro)) then
             FdMemPesqGeral.FieldByname('Picking').AsInteger    := 0
          Else
          if (ArrayJsonEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('pickingfixo')='1') and
             (ArrayJsonEndereco.Items[0].GetValue<TjsonObject>('produto').GetValue<Integer>('codproduto')<>FdMemPesqGeral.FieldByName('CodProduto').AsInteger) then
             if ChkAtualizarPicking.Checked then Begin
                FdMemPesqGeral.FieldByname('Picking').AsInteger    := 1;
                ObjProdutoCtrl := TProdutoCtrl.Create;
                vProdutoId       := ObjProdutoCtrl.GetProdutoJson(FdMemPesqGeral.FieldByName('CodProduto').AsString).Items[0].GetValue<Integer>('idProduto');
                ArrayJsonProduto := ObjProdutoCtrl.EnderecarProduto(vProdutoId, vEnderecoId);
                if (ArrayJsonProduto.Items[0].TryGetValue('Erro', vErro)) then
                   FdMemPesqGeral.FieldByname('Picking').AsInteger    := 0;
                ObjProdutoCtrl.Free;
             End
             Else
                FdMemPesqGeral.FieldByname('Picking').AsInteger    := 0
          Else
             FdMemPesqGeral.FieldByname('Picking').AsInteger    := 1;
          ObjEnderecoCtrl.Free;
      End;
      ObjProdutoCtrl := TProdutoCtrl.Create;
      ArrayJsonProduto := ObjProdutoCtrl.GetCodigoERPJson(FdMemPesqGeral.FieldByname('CodProduto').AsString, 0);
      if (ArrayJsonProduto.Items[0].TryGetValue('Erro', vErro)) or (ArrayJsonProduto.Items[0].GetValue<Integer>('codProduto')=0) then begin
         FdMemPesqGeral.FieldByname('Produto').AsInteger   := 0;
         FdMemPesqGeral.FieldByname('ProdutoId').AsInteger := 0;
      End
      Else Begin
         FdMemPesqGeral.FieldByname('Produto').AsInteger := 1;
         FdMemPesqGeral.FieldByname('ProdutoId').AsInteger    := ArrayJsonProduto.Items[0].GetValue<Integer>('idProduto');
      End;
      ObjProdutoCtrl.Free;
      If (FdMemPesqGeral.FieldByname('Picking').AsInteger = 0) or (FdMemPesqGeral.FieldByname('Produto').AsInteger = 0) then
         vInconsistencia := True;
      Inc(vReg);
//      TThread.Synchronize(nil, procedure
//      begin
//        LblAguardeImportacaoCSV.Caption := 'AGUARDE!!!! Lendo o arquivo. '+vReg.ToString();
//      End);
      vEstoqueImport := vEstoqueImport + FdMemPesqGeral.FieldByname('Quantidade').AsInteger;
      Application.ProcessMessages;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.EnableControls;
  FdMemPesqGeral.First;
  //LblImportaCSV.Caption   := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled   := False;
  LblAguardeImportacaoCSV.Visible := False;
  LblRegistro.Caption       := vReg.ToString();
  LblEstoqueImport.Caption  := vEstoqueImport.ToString();
  BtnImport.Visible         := true; //(Not vInconsistencia) and (FdMemPesqGeral.RecordCount>0);
  BtnInconsistencia.Visible := vInconsistencia;
end;

procedure TFrmInventario.BtnPesqEnderecoFinalClick(Sender: TObject);
Var vEnderecoId     : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  if (BtnSalvar.Grayed) then Exit;
//  inherited;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       if Sender = BtnPesqEnderecoFinal then Begin
          EdtEnderecoFinal.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
          EdtEnderecoFinalExit(EdtEnderecoFinal);
       End
       Else Begin
          EdtEnderecoFinalPreDefinido.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
          EdtEnderecoFinalExit(EdtEnderecoFinalPreDefinido);
       End;
       ObjEnderecoCtrl := Nil;
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmInventario.BtnPesqEnderecoInicialClick(Sender: TObject);
Var vEnderecoId : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  if (BtnSalvar.Grayed) then Exit;
//  inherited;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       if Sender = BtnPesqEnderecoInicial then Begin
          EdtEnderecoInicial.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 1, 0, 1)[0].Descricao;
          EdtEnderecoFinal.SetFocus;
       End
       Else Begin
          EdtEnderecoInicialPreDefinido.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 1, 0, 1)[0].Descricao;
          EdtEnderecoFinalPreDefinido.SetFocus;
       End;
       ObjEnderecoCtrl := Nil;
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmInventario.BtnPesqProdutoFinalClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;


end;

procedure TFrmInventario.BtnPesqZonaPreDefinidoClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  if BtnSalvar.Grayed then Exit;
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaIdPreDefinido.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
       EdtZonaIdPreDefinidoExit(EdtZonaIdPreDefinido);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmInventario.BtnProdutoRemoveClick(Sender: TObject);
Var xProd : Integer;
begin
  if (BtnSalvar.Grayed) then Exit;
  inherited;
  for xProd := 1 to Pred(LstProdutoDisponivel.RowCount) do
    if LstProdutoDisponivel.Cells[6, xProd].ToInteger = 1 then Begin
       if FDMemProdutoDisponivel.Locate('CodigoERP', LstProdutoDisponivel.Cells[0, xProd], []) then Begin
          FDMemProdutoDisponivel.Delete;
    End;
  End;
  MontaListaProdutoDisponivel;
  EdtProdutoinicial.SetFocus;
end;

procedure TFrmInventario.BtnSalvarClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then Begin
     inherited;
     if BtnSalvar.Grayed then Begin
        RbInventarioTipo.ItemIndex := -1;
        RbInventarioTipo.Enabled := False;
        DefineInventarioTipo;
        BtnExportarStand.Grayed  := False;
        BtnExportarStand.Enabled := True;
     End;
  End
  Else Begin
     inherited;
     PgcBase.ActivePage := TabModeloPreDefinido;
     ShowInventarioModeloLista(0, 0);
  End;
end;

procedure TFrmInventario.BtnSchEstruturaClick(Sender: TObject);
begin
  if (BtnSalvar.Grayed) then Exit;
  inherited;
  FrmPesquisaEnderecamentoEstruturas := TFrmPesquisaEnderecamentoEstruturas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoEstruturas.ShowModal = mrOk) then  Begin
       if Sender = BtnSchEstrutura then
          EdtEstruturaId.Text := FrmPesquisaEnderecamentoEstruturas.Tag.ToString()
       Else
          EdtEstruturaIdPreDefinido.Text := FrmPesquisaEnderecamentoEstruturas.Tag.ToString();
       EdtEstruturaIdExit(EdtEstruturaIdPreDefinido);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoEstruturas);
  end;
end;

procedure TFrmInventario.BtnSelDeleteClick(Sender: TObject);
begin
  inherited;
  FdMemEnderecoSelecao.Filter   := 'Ativo = 1';
  FdMemEnderecoSelecao.Filtered := True;
  if FdMemEnderecoSelecao.IsEmpty then Begin
     FdMemEnderecoSelecao.Filter   := '';
     FdMemEnderecoSelecao.Filtered := False;
     ShowErro('Não há endereço para ser retirado da contagem');
     Exit;
  End;
  if Not FdMemEnderecoSelecao.IsEmpty then Begin
     While Not FdMemEnderecoSelecao.Eof do
       If FdMemEnderecoSelecao.FieldByName('Ativo').AsInteger = 1 then
          FdMemEnderecoSelecao.Delete
       else
          FdMemEnderecoSelecao.Next;
  End;
  FdMemEnderecoSelecao.Filter   := '';
  FdMemEnderecoSelecao.Filtered := False;
  SelecionarEnderecoPorListaZona;
  MontaListaEnderecoDisponivel;
  MontaListaEnderecoSelecao;
end;

procedure TFrmInventario.BtnSelInsertClick(Sender: TObject);
begin
  inherited;
  if (Not FdMemEnderecoDisponivel.Active) or (LstEnderecoDisponivel.RowCount<=1) then Begin
     ShowErro('Selecione os endereços');
     Exit;
  End;
  FdMemEnderecoDisponivel.First;
  FdMemEnderecoDisponivel.Filter   := 'Ativo = 1';
  FdmemEnderecoDisponivel.Filtered := True;
  if FdmemEnderecoDisponivel.IsEmpty then Begin
     FdMemEnderecoDisponivel.Filter   := '';
     FdMemEnderecoDisponivel.Filtered := False;
     ShowErro('Selecione 1(um) ou mais endereço para contagem');
     Exit;
  End;
  while Not FdMemEnderecoDisponivel.Eof do Begin
    if (FdMemEnderecoDisponivel.FieldByName('ZonaId').AsInteger > 1) and
       (FdMemEnderecoDisponivel.FieldByName('ReservadoInventario').AsInteger <> 1) then Begin
       FdMemEnderecoSelecao.Append;
       FdMemEnderecoSelecao.FieldByName('Ativo').AsInteger      := 0;//FdMemEnderecoDisponivel.FieldByName('Ativo').AsInteger;
       FdMemEnderecoSelecao.FieldByName('EnderecoId').AsInteger := FdMemEnderecoDisponivel.FieldByName('EnderecoId').AsInteger;
       FdMemEnderecoSelecao.FieldByName('Descricao').AsString   := FdMemEnderecoDisponivel.FieldByName('Descricao').AsString;
       FdMemEnderecoSelecao.FieldByName('Estrutura').AsString   := FdMemEnderecoDisponivel.FieldByName('Estrutura').AsString;
       FdMemEnderecoSelecao.FieldByName('Mascara').AsString     := FdMemEnderecoDisponivel.FieldByName('Mascara').AsString;
       FdMemEnderecoSelecao.FieldByName('Zona').AsString        := FdMemEnderecoDisponivel.FieldByName('Zona').AsString;
       FdMemEnderecoSelecao.Post;
    End;
    FdMemEnderecoDisponivel.Next;
  End;
  FdMemEnderecoDisponivel.First;
  while Not FdMemEnderecoDisponivel.Eof do Begin
    If FdMemEnderecoDisponivel.FieldByName('Ativo').AsInteger = 1 Then
       FdMemEnderecoDisponivel.Delete
    Else FdMemEnderecoDisponivel.Next;
  End;
  FdMemEnderecoDisponivel.Filter   := '';
  FdmemEnderecoDisponivel.Filtered := False;
  MontaListaEnderecoDisponivel();
  MontaListaEnderecoSelecao();
end;

procedure TFrmInventario.BuscarInventarioInicial;
Var JsonArrayLoteInventariado : TJsonArray;
    vErro : String;
    xLote : Integer;
begin
   if InventarioTipo = poGeografico then
      JsonArrayLoteInventariado := ObjInventarioCtrl.GetLoteInventariado(ObjInventarioCtrl.ObjInventario.InventarioId, FdmemEndereco.FieldByName('EnderecoId').AsInteger, 0, 0, 0)
   Else
      JsonArrayLoteInventariado := ObjInventarioCtrl.GetLoteInventariado(ObjInventarioCtrl.ObjInventario.InventarioId, 0, FDMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger, 1, 0);
  if Not JsonArrayLoteInventariado.Items[0].TryGetValue('Erro', vErro) then Begin
     If FdMemLoteInventariado.Active then
        FdMemLoteInventariado.EmptyDataSet;
     FdMemLoteInventariado.Close;
     FdMemLoteInventariado.LoadFromJSON(JsonArrayLoteInventariado, False);
     MontaListaLoteInventariado;
  End;
end;

procedure TFrmInventario.ChkEnderecoClick(Sender: TObject);
begin
  inherited;
  ChkProduto.Checked := Not ChkEndereco.Checked;
  if ChkEndereco.Checked then Begin
     EdtFileName.Text := ExtractFilePath(Application.ExeName)+'Relatorio\Enderecamentos.Csv';
     OpenDlgArqTerceirizada.FileName := ExtractFilePath(Application.ExeName)+'Relatorio\Enderecamentos.Csv';
  End;
end;

procedure TFrmInventario.ChkProdutoClick(Sender: TObject);
begin
  inherited;
  ChkEndereco.Checked := Not ChkProduto.Checked;
  if ChkProduto.Checked Then Begin
     EdtFileName.Text := ExtractFilePath(Application.ExeName)+'Relatorio\Cadproduto.Csv';
     OpenDlgArqTerceirizada.FileName := ExtractFilePath(Application.ExeName)+'Relatorio\Enderecamentos.Csv';
  End;
end;

procedure TFrmInventario.ChkRuaParModeloClick(Sender: TObject);
begin
  inherited;
  LstEnderecoModeloPreDefinido.RowCount := 1;
end;

procedure TFrmInventario.ClearDetalheAjuste;
begin
  EdtEnderecoContagem.Clear;
  EdtLote.Clear;
  CbEnderecoStatus.ItemIndex := -1;
  EdtEstoqueInicial.Clear;
  EdtContagem.Clear;
  EdtAjuste.Clear;
  EdtSaldo.Clear;
end;

procedure TFrmInventario.DbgImportaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    If (FdMemPesqGeral.RecNo Mod 2 = 0) then   //Query dos itens
       Canvas.Brush.Color    := $00FBF9F7     //$00FFCACA // Pedido não finalizado
    Else  Canvas.Brush.Color := $00F5EFE7; //$00FFE8E8; //Pedido Finalizado
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
  if (Column.FieldName = 'Produto') then
      ExibirCheckBox(Column, DbgImporta, ImglancamentoOk, Rect);
  if (Column.FieldName = 'Picking') then
      ExibirCheckBox(Column, DbgImporta, ImglancamentoOk, Rect);
end;

procedure TFrmInventario.DefineField;
begin
//  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
//  End;
  with FdMemPesqGeral.FieldDefs do begin
     Add('Codproduto',ftInteger,0,False);
     Add('Endereco',ftString, 11,False);
     Add('Quantidade', FtInteger, 0, False);
     Add('Picking', FtInteger, 0, False);
     Add('Produto', FtInteger, 0, False);
     Add('Enderecoid', FtInteger, 0, False);
     Add('ProdutoId', FtInteger, 0, False);
  End;
  FdMemPesqGeral.CreateDataSet;
  FdMemPesqGeral.Open;
//  Dbgimporta.Col
end;

procedure TFrmInventario.DefineInventarioTipo;
begin
  TabTipoGeografico.TabVisible := False;
  TabTipoProduto.TabVisible    := False;
  InventarioTipo    := poUndefined;
  if RbInventarioTipo.ItemIndex = 0 then Begin
     InventarioTipo    := poGeografico;
     PgcTipoInventario.ActivePage := TabTipoGeografico;
     TabTipoGeografico.TabVisible := True;
     LblForm.Caption := 'Inventário - Por Endereço';
  End
  Else if RbInventarioTipo.ItemIndex = 1 then Begin
     InventarioTipo := poPrioritario;
     PgcTipoInventario.ActivePage := TabTipoProduto;
     TabTipoProduto.TabVisible    := True;
     LblForm.Caption := 'Inventário - Por Produto';
  End;
  if InventarioTipo = poGeografico then Begin
     If FdMemEnderecoSelecao.Active then
        FdMemEnderecoSelecao.EmptyDataSet;
     FdMemEnderecoSelecao.Close;
     FdMemEnderecoSelecao.Open;
     PnlEndereco.Enabled := True;
  End
  Else If InventarioTipo = poPrioritario then Begin
     If FDMemProdutoDisponivel.Active then
        FDMemProdutoDisponivel.EmptyDataSet;
     FDMemProdutoDisponivel.Close;
     FDMemProdutoDisponivel.Open;
     AtivarPnlProduto(BtnSalvar.Enabled);
     //EdtProdutoInicial.SetFocus;
  End;
end;

function TFrmInventario.DeleteReg: Boolean;
begin
  Result := ObjInventarioCtrl.Delete
end;

procedure TFrmInventario.EdtEnderecoFinalExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  if TEdit(Sender).Text  = '' then Exit;
  ObjEnderecoCtrl := TEnderecoCtrl.Create();
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, StrToIntDef(EdtEstruturaIdPreDefinido.Text, 0), StrToIntDef(EdtZonaIdPreDefinido.Text, 0), 0, TEdit(Sender).Text, TEdit(Sender).Text, 'T', 99, 99, 1, 0);   //GetEnderecoPorListaZonaJson;  //
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ShowErro('Endereço Final não encontrado!');
  End
  Else if JsonArrayRetorno.Items[0].GetValue<Integer>('reservadoinventario') = 1 then Begin
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ShowErro('Endereço já incluso em outro inventário!');
  End
  Else Begin
    if Sender = EdtEnderecoFInal then
       SelecionarEnderecoPorListaZona;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjEnderecoCtrl);
end;

procedure TFrmInventario.EdtEnderecoFinalPreDefinidoChange(Sender: TObject);
begin
  inherited;
  LstEnderecoModeloPreDefinido.RowCount := 1;
  if EdtEnderecoFinalPreDefinido.Text <> '' then Begin
{     if StrToIntDef(Copy(EdtEnderecoFinalPreDefinido.Text,1,2), 0) > 0 then
        EdtRuaFinalModelo.Text    := Copy(EdtEnderecoFinalPreDefinido.Text,1,2);
     if StrToIntDef(Copy(EdtEnderecoFinalPreDefinido.Text,3,2), 0) > 0 then
        EdtPredioFinalModelo.Text := Copy(EdtEnderecoFinalPreDefinido.Text,3,2);
     if StrToIntDef(Copy(EdtEnderecoFinalPreDefinido.Text,5,2), 0) > 0 then
        EdtNivelFinalModelo.Text  := Copy(EdtEnderecoFinalPreDefinido.Text,5,2);
     if StrToIntDef(Copy(EdtEnderecoFinalPreDefinido.Text,7,3), 0) > 0 then
        EdtAptoFinalModelo.Text   := Copy(EdtEnderecoFinalPreDefinido.Text,7,3);
}  End
  Else Begin
     EdtRuaFinalModelo.Clear;
     EdtPredioFinalModelo.Clear;
     EdtNivelFinalModelo.Clear;
     EdtAptoFinalModelo.Clear;
  End;
end;

procedure TFrmInventario.EdtEnderecoInicialExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  if TEdit(Sender).Text  = '' then Exit;
  ObjEnderecoCtrl := TEnderecoCtrl.Create();
  if PgcBase.ActivePage = TabPrincipal then
     JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, StrToIntDef(EdtEstruturaIdPreDefinido.Text, 0), 0, 0, TEdit(Sender).Text, TEdit(Sender).Text, 'T', 99, 99, 1, 0)
  Else
     JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, StrToIntDef(EdtEstruturaIdPreDefinido.Text, 0), StrToIntDef(EdtZonaIdPreDefinido.Text, 0), 0, TEdit(Sender).Text, TEdit(Sender).Text, 'T', 1, 99, 1, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ShowErro('Endereço Inicial não encontrado!');
  End
  Else if JsonArrayRetorno.Items[0].GetValue<Integer>('reservadoinventario') = 1 then Begin
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ShowErro('Endereço já incluso em outro inventário!');
  End
  Else Begin
     if Sender = EdtEnderecoInicial then
        SelecionarEnderecoPorListaZona;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjEnderecoCtrl);
end;

procedure TFrmInventario.EdtEnderecoInicialKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then Begin
     SelectNext(ActiveControl, True, True);
     Exit;
  End;
  inherited;
  if Sender = EdtEnderecoInicial then
     EdtEnderecoFinal.Clear
  Else
     EdtEnderecoFinalPreDefinido.Clear;
end;

procedure TFrmInventario.EdtEnderecoInicialPreDefinidoChange(Sender: TObject);
begin
  inherited;
  //LimparPreDefinido;
  LstEnderecoModeloPreDefinido.RowCount := 1;
  if EdtEnderecoInicialPreDefinido.Text <> '' then Begin
{     if StrToIntDef(Copy(EdtEnderecoInicialPreDefinido.Text,1,2), 0) > 0 then
        EdtRuaInicialModelo.Text    := Copy(EdtEnderecoInicialPreDefinido.Text,1,2);
     if StrToIntDef(Copy(EdtEnderecoInicialPreDefinido.Text,3,2), 0) > 0 then
        EdtPredioInicialModelo.Text := Copy(EdtEnderecoInicialPreDefinido.Text,3,2);
     if StrToIntDef(Copy(EdtEnderecoInicialPreDefinido.Text,5,2), 0) > 0 then
        EdtNivelInicialModelo.Text  := Copy(EdtEnderecoInicialPreDefinido.Text,5,2);
     if StrToIntDef(Copy(EdtEnderecoInicialPreDefinido.Text,7,3), 0) > 0 then
        EdtAptoInicialModelo.Text   := Copy(EdtEnderecoInicialPreDefinido.Text,7,3);
}  End
  Else Begin
     EdtRuaInicialModelo.Clear;
     EdtPredioInicialModelo.Clear;
     EdtNivelInicialModelo.Clear;
     EdtAptoInicialModelo.Clear;
  End;
end;

procedure TFrmInventario.EdtEstruturaIdChange(Sender: TObject);
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then Begin
     LblEstrutura.Caption := '...';
     EdtEnderecoInicial.Clear;
     EdtEnderecoFinal.Clear;
  End
  Else Begin
    LblEstruturaPreDefinido.Caption := '';
    LstEnderecoModeloPreDefinido.RowCount := 1;
  End
end;

procedure TFrmInventario.EdtEstruturaIdExit(Sender: TObject);
Var ObjEnderecoEstruturaCtrl  : TEnderecoEstruturaCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
   if Sender = EdtEstruturaId then
       LblEstrutura.Caption := '...'
   Else
       LblEstruturaPreDefinido.Caption := '...';
   if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Exit;
   ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create();
   ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura.EstruturaId := StrToIntDef(TEdit(Sender).Text, 0);
   JsonArrayRetorno := ObjEnderecoEstruturaCtrl.GetEnderecoEstruturaJson(StrToIntDef(TEdit(Sender).Text, 0), '', 0);
   if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
      TEdit(Sender).Text := '';
      TEdit(Sender).SetFocus;
      ObjEnderecoEstruturaCtrl.DisposeOf;
      raise Exception.Create('Estrutura não encontrada!');
   End;
   if Sender = EdtEstruturaId then
      LblEstrutura.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao')
   Else
      LblEstruturaPreDefinido.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
   JsonArrayRetorno := Nil;
   FreeAndNil(ObjEnderecoEstruturaCtrl);
   SelecionarEnderecoPorListaZona;
end;

procedure TFrmInventario.EdtInventarioIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtInventarioId.ReadOnly) and (StrToIntDef(EdtInventarioId.Text, 0)<>ObjInventarioCtrl.ObjInventario.InventarioId) then Begin
     Limpar;
     RbInventarioTipo.ItemIndex := -1;
     DefineInventarioTipo;
  End;
end;

procedure TFrmInventario.EdtInventarioIdExit(Sender: TObject);
Var JsonArrayInventario : TJsonArray;
    vErro : String;
begin
  inherited;
  if (Not EdtInventarioId.ReadOnly) and (EdtInventarioId.Text<>'') and (StrToIntDef(EdtInventarioId.Text,0)<>ObjInventarioCtrl.ObjInventario.InventarioId) then Begin
     Limpar;
     if StrToIntDef(EdtInventarioId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtInventarioId.Text+') inválido!');
     JsonArrayInventario := ObjInventarioCtrl.GetInventario(StrToIntDef(EdtInventarioId.Text, 0), 0, 0, 0, 0, 0, 0); //Ord(InventarioTipo),0);
     if JsonArrayInventario.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro(vErro);
        EdtInventarioId.Text := '';
        EdtInventarioId.SetFocus;
     End;
     ObjInventarioCtrl.ObjInventario := ObjInventarioCtrl.ObjInventario.JsonToClass((JsonArrayInventario.Items[0] as TJsonObject).ToString);
     InventarioNaoIniciado := JsonArrayInventario.Items[0].GetValue<Integer>('saldoinicial', 0) <= 0;
     Try
       ObjInventarioCtrl.ObjInventario.datacriacao    := StrToDate(DateEUAToBr((JsonArrayInventario.Items[0] as TJsonObject).GetValue<String>('datacriacao')));
       if (JsonArrayInventario.Items[0] as TJsonObject).GetValue<String>('datafechamento') <> '' then Begin
          ObjInventarioCtrl.ObjInventario.DataFechamento := StrToDate(DateEUAToBr((JsonArrayInventario.Items[0] as TJsonObject).GetValue<String>('datafechamento')));
          ObjInventarioCtrl.ObjInventario.horaFechamento := StrToTime(Copy((JsonArrayInventario.Items[0] as TJsonObject).GetValue<String>('horafechamento'), 1, 8));
       End;
     Except
     End;
     if ObjInventarioCtrl.ObjInventario.InventarioId > 0 then
        ShowDados;
  End;
  //JsonArrayInventario.Free;
end;

procedure TFrmInventario.EdtInventarioIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (TEdit(Sender).Text<>'') then Begin
     SelectNext(ActiveControl, True, True);
     Exit;
  End;
end;

procedure TFrmInventario.EdtModeloPreDefinidoChange(Sender: TObject);
begin
  inherited;
  LimparPreDefinido;
end;

procedure TFrmInventario.EdtModeloPreDefinidoExit(Sender: TObject);
begin
  inherited;
  if EdtModeloPreDefinido.Text = '' then Exit;
  FDMemInventarioModelo.First;
  if FDMemInventarioModelo.Locate('modeloid', EdtModeloPreDefinido.Text, []) then
     ShowInventarioModelo;
end;

procedure TFrmInventario.EdtModeloPreDefinidoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then EdtModeloPreDefinidoExit(EdtModeloPreDefinido);  
end;

procedure TFrmInventario.EdtPesqEnderecoInvokeSearch(Sender: TObject);
Var xRow   : Integer;
    vFound : BOolean;
begin
  inherited;
  if EdtPesqEndereco.Text <> '' then Begin
     vFound := False;
     for xRow := 1 to (LstEnderecoContagem.RowCount) do Begin
       if StringReplace(LstEnderecoContagem.Cells[0, xRow], '.', '', [rfReplaceAll]) = EdtPesqEndereco.Text then Begin
          LstEnderecoContagem.Row := xRow;
          vFound := True;
          Break;
       End;
     End;
     if Not vFound then Begin
        if InventarioTipo = poGeografico then
           ShowErro('Endereço não localizado nesse inventário!')
        Else
           ShowErro('Produto não localizado nesse inventário!');
     End;
     EdtPesqEndereco.Clear;
  End;
end;

procedure TFrmInventario.EdtProdutoInicialChange(Sender: TObject);
begin
  inherited;
  EdtProduto.Clear;
end;

Procedure TFrmInventario.EdtProdutoInicialEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(TEdit(Sender));
end;

procedure TFrmInventario.EdtProdutoInicialExit(Sender: TObject);
Var ObjProdutoCtrl : TProdutoCtrl;
    xProd : Integer;
begin
  if EdtProdutoInicial.Text = '' then Exit;
  inherited;
  ExitFocus(TEdit(Sender));
  if (TEdit(Sender).Text = '') or (Sender = BtnInsertProduto) then Exit;
  if StrToInt64Def(TEdit(Sender).Text, 0) <= 0 then
     raise Exception.Create('Código de Produto inválido para pesquisa!');
  //ObjProdutoCtrl.GetCodigoERP(EdtCodProduto.Text);
  ObjProdutoCtrl := TProdutoCtrl.Create;
  ObjProdutoCtrl.FindProduto('0', TEdit(Sender).Text, '', 0, 0);
  if ObjProdutoCtrl.ObjProduto.IdProduto <= 0 then Begin
     ShowErro('Produto não encontrado!');
     TEdit(Sender).SetFocus;
  end;
  EdtProduto.Text := ObjProdutoCtrl.ObjProduto.Descricao;
  if FDMemProdutoDisponivel.Locate('CodigoERP', ObjProdutoCtrl.ObjProduto.CodProduto, []) then Begin
     ShowErro('Produto já incluso na contagem');
     EdtProdutoInicial.Clear;
     EdtProdutoInicial.SetFocus;
  End
  Else Begin
    EdtProdutoInicial.OnChange := nil;
    EdtProdutoInicial.Text     := ObjProdutoCtrl.ObjProduto.CodProduto.ToString();
    EdtProdutoInicial.OnChange := EdtProdutoInicialChange;
    //BtnInsertProduto.SetFocus;
  End;
  FreeAndNil(ObjProdutoCtrl);
  //SelecionarProdutoPorListaZona;
end;

procedure TFrmInventario.EdtProdutoInicialKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if (Key = #13) and (EdtProdutoInicial.text='') then Begin
      Key := #0;
      keybd_event(VK_F2, 0, 0, 0);
      EdtProdutoInicial.SetFocus;
   End;
end;

procedure TFrmInventario.EdtRuaInicialModeloChange(Sender: TObject);
begin
  inherited;
  LstEnderecoModeloPreDefinido.RowCount := 1;
end;

procedure TFrmInventario.EdtRuaInicialModeloExit(Sender: TObject);
begin
  inherited;
  if (TEdit(Sender).Text = '') or (TEdit(Sender).ReadOnly) then Exit;
  if (TEdit(Sender).name = 'EdtAptoInicialModelo') or (TEdit(Sender).name = 'EdtAptoFinalModelo') then
     TEdit(Sender).Text := Repl('0', 2-Length(TEdit(Sender).Text))+ TEdit(Sender).Text
  Else
     TEdit(Sender).Text := Repl('0', 2-Length(TEdit(Sender).Text))+ TEdit(Sender).Text;
  validarFiltroModeloPreDefinido(TEdit(Sender));
end;

procedure TFrmInventario.EdtRuaInicialModeloKeyPress(Sender: TObject;
  var Key: Char);
begin
  SoNumeros(Key);
  inherited;
  if Key = #13 then
     SelectNext(ActiveControl, true, true);
end;

procedure TFrmInventario.EdtZonaIdPreDefinidoChange(Sender: TObject);
begin
  inherited;
  LblZonaPreDefinido.Caption := '';
  LstEnderecoModeloPreDefinido.RowCount := 1;
  //GetEnderecoZonaPreDefinidoClear;
end;

procedure TFrmInventario.EdtZonaIdPreDefinidoExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblZonaPreDefinido.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblZonaPreDefinido.Caption := '';
     ShowErro( '😢Código de Zona('+TEdit(Sender).Text+') inválido!' );
     ExitFocus(Sender);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  JsonArrayZona := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(TEdit(Sender).Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Erro : '+vErro);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ExitFocus(Sender);
  End
  Else
     LblZonaPreDefinido.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonArrayZona := Nil;
  FreeAndNil(ObjEnderecamentoZonaCtrl);
  if (PgcBase.ActivePage = TabModeloPreDefinido) and (StrToIntDef(EdtZonaIdPreDefinido.Text, 0)>0) then Begin
     if Not EdtZonaIdPreDefinido.ReadOnly then Begin
        GetEnderecoZonaPreDefinido;
     End;
  End;
end;

procedure TFrmInventario.FdMemApuracaoCalcFields(DataSet: TDataSet);
begin
  inherited;
  FdMemApuracao.FieldByName('Ajuste').AsInteger := FdMemApuracao.FieldByName('EstoqueInicial').AsInteger-
                                                   FdMemApuracao.FieldByName('QtdContagem').AsInteger;
end;

procedure TFrmInventario.FiltraEnderecoPreDefinido;
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
    ObjEnderecoCtrl : TEnderecoCtrl;
Begin
  //GetEnderecoZonaPreDefinidoClear;
  ObjEnderecoCtrl := TEnderecoCtrl.Create();
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoModelo(
                      StrToIntDef(EdtEstruturaIdPreDefinido.Text, 0),
                      StrToIntDef(EdtZonaIdPreDefinido.Text, 0),
                      EdtEnderecoInicialPreDefinido.Text, EdtEnderecoFinalPreDefinido.Text,
                      EdtRuaInicialModelo.Text, EdtRuaFinalModelo.Text, Ord(ChkRuaParModelo.Checked), Ord(ChkRuaImparModelo.Checked),
                      EdtPredioInicialModelo.Text, EdtPredioFinalModelo.Text, Ord(ChkPredioParModelo.Checked), Ord(ChkPredioImparModelo.Checked),
                      EdtNivelInicialModelo.Text, EdtNivelFinalModelo.Text, Ord(ChkNivelParModelo.Checked), Ord(ChkNivelImparModelo.Checked),
                      EdtAptoInicialModelo.Text, EdtAptoFinalModelo.Text, Ord(ChkAptoParModelo.Checked), Ord(ChkAptoImparModelo.Checked) );
  if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then Begin
     //EdtZonaIdPreDefinido.Clear;
     //EdtZonaIdPreDefinido.SetFocus;
     ShowMSG('Não há endereços disponível para esse modelo!');
  End
  Else if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     EdtZonaIdPreDefinido.Clear;
     EdtZonaIdPreDefinido.SetFocus;
     ShowErro('Endereço Inicial não encontrado!');
  End
  Else Begin
    If FdMemEnderecoModelo.Active then
       FdMemEnderecoModelo.EmptyDataSet;
    FdMemEnderecoModelo.Close;
    FdMemEnderecoModelo.LoadFromJSON(JsonArrayRetorno, False);
    MontaEnderecoModeloPreDefinido;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjEnderecoCtrl);
end;

procedure TFrmInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmInventario := Nil;
end;

procedure TFrmInventario.FormCreate(Sender: TObject);
begin
  inherited;
  //LstReport.SelectRows(xLinSel, 1); selecionar Linha do LstAdv
  InventarioTipo := poUndefined;
  ObjInventarioCtrl := TInventarioCtrl.Create;
  LstCadastro.ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);
  LstCadastro.ColWidths[1] := 100+Trunc(100*ResponsivoVideo);
  LstCadastro.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
  LstCadastro.ColWidths[3] := 120+Trunc(120*ResponsivoVideo);
  LstCadastro.ColWidths[4] := 250+Trunc(250*ResponsivoVideo);
  LstCadastro.ColWidths[5] := 230+Trunc(230*ResponsivoVideo);
  LstCadastro.ColWidths[6] := 170+Trunc(170*ResponsivoVideo);
  LstCadastro.Alignments[0 ,0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];

  LstZona.ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);
  LstZona.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstZona.ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
  LstZona.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);
  LstZona.ColWidths[4] :=  50+Trunc(50*ResponsivoVideo);
  LstZona.Alignments[0 ,0] := taRightJustify;
  LstZona.FontStyles[0, 0] := [FsBold];
  LstZona.RowCount := 1;
  PnlZona.Width := LstZona.ColWidths[0]+LstZona.ColWidths[1]+LstZona.ColWidths[2]+
                   LstZona.ColWidths[3]+LstZona.ColWidths[4]+30;

  LstZonaPreDefinido.ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);
  LstZonaPreDefinido.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstZonaPreDefinido.ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
  LstZonaPreDefinido.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);
  LstZonaPreDefinido.ColWidths[4] :=  50+Trunc(50*ResponsivoVideo);
  LstZonaPreDefinido.Alignments[0 ,0] := taRightJustify;
  LstZonaPreDefinido.FontStyles[0, 0] := [FsBold];
  LstZonaPreDefinido.RowCount := 1;
  LstZonaPreDefinido.Width := LstZonaPreDefinido.ColWidths[0]+LstZonaPreDefinido.ColWidths[1]+
                              LstZonaPreDefinido.ColWidths[2]+LstZonaPreDefinido.ColWidths[3]+
                              LstZonaPreDefinido.ColWidths[4]+30;

  LstEnderecoDisponivel.ColWidths[0] := 110+Trunc(110*ResponsivoVideo);
  LstEnderecoDisponivel.ColWidths[1] := 130+Trunc(130*ResponsivoVideo);
  LstEnderecoDisponivel.ColWidths[2] := 150+Trunc(150*ResponsivoVideo);
  LstEnderecoDisponivel.ColWidths[3] :=  45+Trunc(45*ResponsivoVideo);
  LblEnderecoDisponivel.Align := alClient;
  LstEnderecoDisponivel.Alignments[0 ,0] := taCenter;
  LstEnderecoDisponivel.FontStyles[0, 0] := [FsBold];
  LstEnderecoDisponivel.Alignments[3 ,0] := taCenter;
  LstEnderecoDisponivel.RowCount := 1;
  LstEnderecoDisponivel.HideColumn(4);
  LstEnderecoDisponivel.HideColumn(5);
  PnlEnderecoDisponivel.Width := LstEnderecoDisponivel.ColWidths[0]+LstEnderecoDisponivel.ColWidths[1]+
                                 LstEnderecoDisponivel.ColWidths[2]+LstEnderecoDisponivel.ColWidths[3]+30;
  LstProdutoDisponivel.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
  LstProdutoDisponivel.ColWidths[1] := 250+Trunc(250*ResponsivoVideo);
  LstProdutoDisponivel.ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
  LstProdutoDisponivel.ColWidths[3] := 150+Trunc(150*ResponsivoVideo);
  LstProdutoDisponivel.ColWidths[4] :=  60+Trunc(60*ResponsivoVideo);
  LstProdutoDisponivel.ColWidths[5] :=  80+Trunc(80*ResponsivoVideo);
  LstProdutoDisponivel.ColWidths[6] :=  60+Trunc(60*ResponsivoVideo);
  //LstProdutoDisponivel.Align        := alClient;
  LstProdutoDisponivel.Alignments[0, 0] := taRightJustify;
  LstProdutoDisponivel.FontStyles[0, 0] := [FsBold];
  LstProdutoDisponivel.Alignments[4, 0] := taCenter;
  LstProdutoDisponivel.Alignments[5, 0] := taCenter;
  LstProdutoDisponivel.Alignments[6, 0] := taCenter;
  LstProdutoDisponivel.RowCount := 1;
  LstProdutoDisponivel.HideColumn(7);
  PnlProdutoDisponivel.Width := LstProdutoDisponivel.ColWidths[0]+LstProdutoDisponivel.ColWidths[1]+LstProdutoDisponivel.ColWidths[2]+
                                LstProdutoDisponivel.ColWidths[3]+LstProdutoDisponivel.ColWidths[4]+LstProdutoDisponivel.ColWidths[5]+
                                LstProdutoDisponivel.ColWidths[6]+30;

  LstEnderecoSelecao.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
  LstEnderecoSelecao.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstEnderecoSelecao.ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
  LstEnderecoSelecao.ColWidths[3] :=  50+Trunc(50*ResponsivoVideo);
  LblEnderecoSelecao.Align := alClient;
  LstEnderecoSelecao.Alignments[0 ,0] := taCenter;
  LstEnderecoSelecao.FontStyles[0, 0] := [FsBold];
  LstEnderecoSelecao.RowCount := 1;
  LstEnderecoSelecao.HideColumn(4);
  PnlEnderecoSelecao.Width := LstEnderecoSelecao.ColWidths[0]+LstEnderecoSelecao.ColWidths[1]+
                              LstEnderecoSelecao.ColWidths[2]+LstEnderecoSelecao.ColWidths[3]+30;
  SelZona       := False;
  SelDisponivel := False;
  SelSelecao    := False;
//Lista Endereço Contados
  LstEnderecoContagem.ColWidths[0] := 110+Trunc(110*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[3] :=  40+Trunc(40*ResponsivoVideo);
  LstEnderecoContagem.Alignments[0 ,0] := taRightJustify;
  LstEnderecoContagem.FontStyles[0, 0] := [FsBold];
  PnlEnderecoContagem.Width := LstEnderecoContagem.ColWidths[0]+LstEnderecoContagem.ColWidths[1]+
                               LstEnderecoContagem.ColWidths[2]+LstEnderecoContagem.ColWidths[3]+30;
//Lista Detalhe do Ajuste
//  PnlContagemAjuste.Left  := PnlEnderecoContagem.Left+PnlEnderecoContagem.Width;

  LstDetalheAjuste.ColWidths[0] :=  65+Trunc(65*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[1] :=  80+Trunc(80*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[2] := 250+Trunc(250*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[3] := 100+Trunc(100*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[4] :=  75+Trunc(75*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[5] :=  50+Trunc(50*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[6] :=  60+Trunc(60*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[7] :=  45+Trunc(45*ResponsivoVideo);
  LstDetalheAjuste.ColWidths[8] :=  40+Trunc(40*ResponsivoVideo);
  LstDetalheAjuste.Alignments[0 ,0] := taRightJustify;
  LstDetalheAjuste.FontStyles[0, 0] := [FsBold];
  LstDetalheAjuste.Alignments[1 ,0] := taRightJustify;
  LstDetalheAjuste.Alignments[5 ,0] := taRightJustify;
  LstDetalheAjuste.Alignments[6 ,0] := taRightJustify;
  LstDetalheAjuste.Alignments[7 ,0] := taRightJustify;
  LstDetalheAjuste.FontStyles[7, 0] := [FsBold];
  LstDetalheAjuste.Alignments[8 ,0] := taCenter;
//Lista Resumo da Contagem
  LstContagemLote.ColWidths[0] :=  65+Trunc(65*ResponsivoVideo);
  LstContagemLote.ColWidths[1] :=  60+Trunc(60*ResponsivoVideo);
  LstContagemLote.ColWidths[2] := 120+Trunc(120*ResponsivoVideo);
  LstContagemLote.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);
  LstContagemLote.ColWidths[4] :=  90+Trunc(90*ResponsivoVideo);
  LstContagemLote.ColWidths[5] := 160+Trunc(160*ResponsivoVideo);
  LstContagemLote.Alignments[0, 0] := taRightJustify;
  LstContagemLote.FontStyles[0, 0] := [FsBold];
  LstContagemLote.Alignments[1, 0] := taRightJustify;
  LstContagemLote.Alignments[3, 0] := taCenter;
  LstContagemLote.Alignments[4, 0] := taCenter;
//Lista Apuração
  LstApuracao.ColWidths[0] :=  95+Trunc(95*ResponsivoVideo);
  LstApuracao.ColWidths[1] :=  80+Trunc(80*ResponsivoVideo);
  LstApuracao.ColWidths[2] := 250+Trunc(250*ResponsivoVideo);
  LstApuracao.ColWidths[3] :=  90+Trunc(90*ResponsivoVideo);
  LstApuracao.ColWidths[4] := 100+Trunc(100*ResponsivoVideo);
  LstApuracao.ColWidths[5] :=  75+Trunc(75*ResponsivoVideo);
  LstApuracao.ColWidths[6] :=  50+Trunc(50*ResponsivoVideo);
  LstApuracao.ColWidths[7] :=  60+Trunc(60*ResponsivoVideo);
  LstApuracao.ColWidths[8] :=  45+Trunc(45*ResponsivoVideo);
  LstApuracao.Alignments[0 ,0] := taRightJustify;
  LstApuracao.FontStyles[0, 0] := [FsBold];
  LstApuracao.Alignments[1 ,0] := taRightJustify;
  LstApuracao.Alignments[6 ,0] := taRightJustify;
  LstApuracao.Alignments[7 ,0] := taRightJustify;
  LstApuracao.Alignments[8 ,0] := taRightJustify;
  LstApuracao.FontStyles[8, 0] := [FsBold];

  LstModeloPredefinido.ColWidths[ 0] :=  70+Trunc(70*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 1] :=  70+Trunc(70*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 2] :=  90+Trunc(90*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 3] :=  80+Trunc(80*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 4] :=  80+Trunc(80*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 5] := 60+Trunc(60*ResponsivoVideo); //Rua Inicial
  LstModeloPredefinido.ColWidths[ 6] := 60+Trunc(60*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 7] := 45+Trunc(45*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 8] := 45+Trunc(45*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[ 9] := 60+Trunc(60*ResponsivoVideo); //Predio Inicial
  LstModeloPredefinido.ColWidths[10] := 60+Trunc(60*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[11] := 50+Trunc(50*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[12] := 50+Trunc(50*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[13] := 60+Trunc(60*ResponsivoVideo); //Nivel Inicial
  LstModeloPredefinido.ColWidths[14] := 60+Trunc(60*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[15] := 50+Trunc(50*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[16] := 50+Trunc(50*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[17] := 60+Trunc(60*ResponsivoVideo); //Apto Inicial
  LstModeloPredefinido.ColWidths[17] := 60+Trunc(60*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[19] := 50+Trunc(50*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[20] := 50+Trunc(50*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[21] := 90+Trunc(90*ResponsivoVideo);
  LstModeloPredefinido.ColWidths[22] := 90+Trunc(90*ResponsivoVideo);
  LstModeloPredefinido.Alignments[0 ,0] := taCenter;
  LstModeloPredefinido.Alignments[1 ,0] := taRightJustify;
  LstModeloPredefinido.FontStyles[1, 0] := [FsBold];
  LstModeloPredefinido.Alignments[2 ,0] := taLeftJustify;
  LstModeloPredefinido.Alignments[3 ,0] := taCenter;
  LstModeloPredefinido.Alignments[4 ,0] := taCenter;
  LstModeloPredefinido.Alignments[5 ,0] := taCenter;
  LstModeloPredefinido.Alignments[6 ,0] := taCenter;
  LstModeloPredefinido.Alignments[7 ,0] := taCenter;
  LstModeloPredefinido.Alignments[8 ,0] := taCenter;
  LstModeloPredefinido.Alignments[9 ,0] := taCenter;
  LstModeloPredefinido.Alignments[10 ,0] := taCenter;
  LstModeloPredefinido.Alignments[11,0] := taCenter;
  LstModeloPredefinido.Alignments[12,0] := taCenter;
  LstModeloPredefinido.Alignments[13,0] := taCenter;
  LstModeloPredefinido.Alignments[14,0] := taCenter;
  LstModeloPredefinido.Alignments[15,0] := taCenter;
  LstModeloPredefinido.Alignments[16,0] := taCenter;
  LstModeloPredefinido.Alignments[17,0] := taCenter;
  LstModeloPredefinido.Alignments[18,0] := taCenter;
  LstModeloPredefinido.Alignments[19,0] := taCenter;
  LstModeloPredefinido.Alignments[20,0] := taCenter;
  LstModeloPredefinido.Alignments[21,0] := taCenter;
  LstModeloPredefinido.Alignments[22,0] := taCenter;

  TabTipoGeografico.TabVisible := False;
  TabTipoProduto.TabVisible    := False;
  RbInventarioTipo.ItemIndex := -1;
  OpenDlgArqTerceirizada.InitialDir := ExtractFilePath(Application.ExeName);
  ShowFinalizacao(False);
  PgcBase.ActivePage := TabListagem;
  TabModeloPreDefinido.TabVisible := DebugHook <> 0;
  SelModelo := False;
end;

procedure TFrmInventario.FormDestroy(Sender: TObject);
begin
  inherited;
  ObjInventarioCtrl.Free;
end;

procedure TFrmInventario.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;
end;

procedure TFrmInventario.FormShow(Sender: TObject);
begin
  inherited;
  PgcBase.ActivePage := TabListagem
end;

procedure TFrmInventario.GetApuracao;
Var JsonArrayApuracao : TJsonArray;
    vErro : String;
begin
  ImprimirExportar(False);
  if InventarioTipo = poGeografico then
     JsonArrayApuracao := ObjInventarioCtrl.GetLoteInventariado(ObjInventarioCtrl.ObjInventario.InventarioId, 0, 0, 1, 0)
  Else if InventarioTipo = poPrioritario then
     JsonArrayApuracao := ObjInventarioCtrl.GetLoteInventariado(ObjInventarioCtrl.ObjInventario.InventarioId, 0, 0, 2, 0);
  if Not JsonArrayApuracao.Items[0].TryGetValue('Erro', vErro) then Begin
     If FdMemApuracao.Active then
        FdMemApuracao.EmptyDataSet;
     FdMemApuracao.Close;
     FdMemApuracao.LoadFromJSON(JsonArrayApuracao, False);
     MontaListaApuracao;
  End;
  //Else
  //   ShowErro('Erro: '+vErro);
  JsonArrayApuracao := Nil;
end;

procedure TFrmInventario.GetContagemLote(pItem: Integer);
Var JsonArrayContagem : TJsonArray;
    xContagem         : Integer;
    vErro             : String;
begin
  JsonArrayContagem := ObjInventarioCtrl.GetContagem(pItem, 0);
  LstContagemLote.RowCount := 1;
  if Not JsonArrayContagem.Items[0].TryGetValue('Erro', vErro) then Begin
    LstContagemLote.RowCount  := JsonArrayContagem.Count+1;
    LstContagemLote.FixedRows := 1;
    for xContagem := 0 to Pred(JsonArrayContagem.Count) do begin
      LstContagemLote.Cells[0, xContagem+1] := JsonArrayContagem.Items[xContagem].GetValue<Integer>('contagemid').ToString();
      LstContagemLote.Cells[1, xContagem+1] := JsonArrayContagem.Items[xContagem].GetValue<Integer>('quantidade').ToString();
      LstContagemLote.Cells[2, xContagem+1] := JsonArrayContagem.Items[xContagem].GetValue<String>('estacao');
      LstContagemLote.Cells[3, xContagem+1] := JsonArrayContagem.Items[xContagem].GetValue<String>('data');
      LstContagemLote.Cells[4, xContagem+1] := JsonArrayContagem.Items[xContagem].GetValue<String>('hora');
      LstContagemLote.Cells[5, xContagem+1] := JsonArrayContagem.Items[xContagem].GetValue<String>('nome'); //Usuário
      LstContagemLote.Alignments[0, xContagem+1] := taRightJustify;
      LstContagemLote.FontStyles[0, xContagem+1] := [FsBold];
      LstContagemLote.Alignments[1, xContagem+1] := taRightJustify;
      LstContagemLote.Alignments[3, xContagem+1] := taCenter;
      LstContagemLote.Alignments[4, xContagem+1] := taCenter;
    End;
  End;
end;

procedure TFrmInventario.GetEnderecamentoZonas;
Var ObjEnderecamentoZonaCtrl  : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
    xZona : Integer;
    vErro : String;
begin
  inherited;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create();
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(0, '', 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) Then Begin
     FreeAndNil(ObjEnderecamentoZonaCtrl);
     LstZona.ClearRect(0, 1, LstZona.ColCount-1, LstZona.RowCount-1);
     LstZona.RowCount := 1;
     raise Exception.Create(vErro);
  End
  Else begin
    LstZona.ClearRect(0, 1, LstZona.ColCount-1, LstZona.RowCount-1);
    LstZona.RowCount  := JsonArrayRetorno.Count+1;
    LstZona.FixedRows := 1;
    for xZona := 0 to Pred(LstZona.RowCount) do
        LstZona.AddDataImage(4, xZona+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    for xZona := 0 to Pred(JsonArrayRetorno.Count) do Begin
      LstZona.Cells[0, xZona+1] := JsonArrayRetorno.Items[xZona].GetValue<Integer>('zonaid').ToString();
      LstZona.Cells[1, xZona+1] := JsonArrayRetorno.Items[xZona].GetValue<String>('descricao');
      LstZona.Cells[2, xZona+1] := JsonArrayRetorno.Items[xZona].GetValue<TJsonObject>('estoquetipo').GetValue<String>('descricao');
      LstZona.Cells[3, xZona+1] := JsonArrayRetorno.Items[xZona].GetValue<TJsonObject>('rastro').GetValue<String>('descricao');
      LstZona.Cells[4, xZona+1] := '0';
      LstZona.Alignments[0, xZona+1] := taRightJustify;
      LstZona.FontStyles[0, xZona+1] := [FsBold];
      LstZona.Alignments[4, xZona+1] := taCenter;
    End;
  end;
  ObjEnderecamentoZonaCtrl.DisposeOf;
end;

Procedure TFrmInventario.GetEnderecoZonaPreDefinido;
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
    ObjEnderecoCtrl : TEnderecoCtrl;
Begin
  //GetEnderecoZonaPreDefinidoClear;
  LstEnderecoModeloPreDefinido.RowCount := 1;
  ObjEnderecoCtrl := TEnderecoCtrl.Create();
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, StrToIntDef(EdtEstruturaIdPreDefinido.Text, 0), StrToIntDef(EdtZonaIdPreDefinido.Text, 0), 0, '', '', 'T', 99, 99, 0, 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     //EdtZonaIdPreDefinido.Clear;
     //EdtZonaIdPreDefinido.SetFocus;
     //ShowErro('Endereço(s) não encontrado(s)!');
  End
  Else Begin
     EdtEnderecoInicialPreDefinido.Text := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
     EdtEnderecoFinalPreDefinido.Text   := JsonArrayRetorno.Items[JsonArrayRetorno.Count-1].GetValue<String>('descricao');
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjEnderecoCtrl);
End;

procedure TFrmInventario.GetEnderecoZonaPreDefinidoClear;
begin
  EdtEnderecoInicialPreDefinido.Clear;
  EdtEnderecoFinalPreDefinido.Clear;
  EdtRuaInicialModelo.Clear;
  EdtRuaFinalModelo.Clear;
  ChkRuaParModelo.Checked   := False;
  ChkRuaImparModelo.Checked := False;
  EdtPredioInicialModelo.Clear;
  EdtPredioFinalModelo.Clear;
  ChkPredioParModelo.Checked   := False;
  ChkPredioImparModelo.Checked := False;
  EdtNivelInicialModelo.Clear;
  EdtNivelFinalModelo.Clear;
  ChkNivelParModelo.Checked   := False;
  ChkNivelImparModelo.Checked := False;
  EdtAptoInicialModelo.Clear;
  EdtAptoFinalModelo.Clear;
  ChkAptoParModelo.Checked   := False;
  ChkAptoImparModelo.Checked := False;
  LstEnderecoModeloPreDefinido.RowCount := 1;
end;

procedure TFrmInventario.GetInventarioEndereco;
Var JsonArrayItens : TJsonArray;
    vErro  : String;
    xItens : Integer;
begin
    JsonArrayItens := ObjInventarioCtrl.GetInventarioItens(ObjInventarioCtrl.ObjInventario.InventarioId, 0);
    if JsonArrayItens.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Não há Itens para contagem no inventário.'+#13+vErro);
       Exit;
    End;
    if InventarioTipo = poGeografico then Begin    
       FdMemEndereco.Close;
       FdMemEndereco.CreateDataSet;
       FdMemEndereco.EmptyDataSet;
       For xItens := 0 to JsonArrayItens.Count - 1 do Begin
         FdMemEndereco.Append;
         FdMemEndereco.FieldByName('Ativo').AsInteger      := 0;
         FdMemEndereco.FieldByName('EnderecoId').AsInteger := JsonArrayItens.Items[xItens].GetValue<Integer>('enderecoid');
         FdMemEndereco.FieldByName('Descricao').AsString   := JsonArrayItens.Items[xItens].GetValue<String>('endereco');
         FdMemEndereco.FieldByName('Estrutura').AsString   := JsonArrayItens.Items[xItens].GetValue<String>('estrutura');
         FdMemEndereco.FieldByName('Mascara').AsString     := JsonArrayItens.Items[xItens].GetValue<String>('mascara');
         FdMemEndereco.FieldByName('Zona').AsString        := JsonArrayItens.Items[xItens].GetValue<String>('zona');
         FdmemEndereco.FieldByName('Status').AsString      := JsonArrayItens.Items[xItens].GetValue<String>('status');
       End;
       If JsonArrayItens.Count > 0 then
          FdMemEndereco.Post;
       MontaListaEnderecoContado;
    End
    Else If InventarioTipo = poPrioritario then Begin
       FdMemProdutoDisponivel.Close;
       FdMemProdutoDisponivel.CreateDataSet;
       FdMemProdutoDisponivel.EmptyDataSet;
       For xItens := 0 to JsonArrayItens.Count - 1 do Begin
         FdMemProdutoDisponivel.Append;
         FdMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger := JsonArrayItens.Items[xItens].GetValue<Integer>('produtoid');
         FdMemProdutoDisponivel.FieldByName('CodigoERP').AsInteger := JsonArrayItens.Items[xItens].GetValue<Integer>('codigoerp');
         FdMemProdutoDisponivel.FieldByName('Descricao').AsString  := JsonArrayItens.Items[xItens].GetValue<String>('descricao');
         FdMemProdutoDisponivel.FieldByName('Picking').AsString    := JsonArrayItens.Items[xItens].GetValue<String>('picking');
//         FdMemProdutoDisponivel.FieldByName('Mascara').AsString     := JsonArrayItens.Items[xEndereco].GetValue<String>('mascara');
         FdMemProdutoDisponivel.FieldByName('Zona').AsString       := JsonArrayItens.Items[xItens].GetValue<String>('zona');
         FdMemProdutoDisponivel.FieldByName('Sngpc').Asinteger     := JsonArrayItens.Items[xItens].GetValue<Integer>('sngpc');
         FdMemProdutoDisponivel.FieldByName('Status').AsString     := JsonArrayItens.Items[xItens].GetValue<String>('status');
       End;
       If JsonArrayItens.Count > 0 then
          FdMemProdutoDisponivel.Post;
       MontaListaEnderecoContado;
    End;
end;

Procedure TFrmInventario.GetInventarioProduto;
Var JsonArrayItens : TJsonArray;
    vErro  : String;
    xItens : Integer;
begin
    JsonArrayItens := ObjInventarioCtrl.GetInventarioItens(ObjInventarioCtrl.ObjInventario.InventarioId, 0);
    if JsonArrayItens.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Não há Itens para contagem no inventário.'+#13+vErro);
       Exit;
    End;
    If InventarioTipo = poPrioritario then Begin
       FdMemProdutoDisponivel.Close;
       FdMemProdutoDisponivel.CreateDataSet;
       FdMemProdutoDisponivel.EmptyDataSet;
       For xItens := 0 to JsonArrayItens.Count - 1 do Begin
         FdMemProdutoDisponivel.Append;
         FdMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger := JsonArrayItens.Items[xItens].GetValue<Integer>('produtoid');
         FdMemProdutoDisponivel.FieldByName('CodigoERP').AsInteger := JsonArrayItens.Items[xItens].GetValue<Integer>('codigoerp');
         FdMemProdutoDisponivel.FieldByName('Descricao').AsString  := JsonArrayItens.Items[xItens].GetValue<String>('produto');
         FdMemProdutoDisponivel.FieldByName('Picking').AsString    := JsonArrayItens.Items[xItens].GetValue<String>('picking');
//         FdMemProdutoDisponivel.FieldByName('Mascara').AsString     := JsonArrayItens.Items[xEndereco].GetValue<String>('mascara');
         FdMemProdutoDisponivel.FieldByName('Zona').AsString       := JsonArrayItens.Items[xItens].GetValue<String>('zona');
         FdMemProdutoDisponivel.FieldByName('Sngpc').Asinteger     := JsonArrayItens.Items[xItens].GetValue<Integer>('sngpc');
         FdMemProdutoDisponivel.FieldByName('Status').AsString     := JsonArrayItens.Items[xItens].GetValue<String>('status');
       End;
       If JsonArrayItens.Count > 0 then
          FdMemProdutoDisponivel.Post;
       MontaListaProdutoContado;
    End;
End;

Function TFrmInventario.GetListainventario(pInventarioId: Integer;
  pDataCriacao, pDataFinalizacao: TDateTime; pDataCancelamento : TDateTime; pProcessoId: Integer; pTipo : Integer; pPendente : Integer) : Boolean;
Var JsonArrayInventario : tJsonArray;
    xInventario         : Integer;
    vErro               : String;
begin
  JsonArrayInventario := ObjInventarioCtrl.getInventario(pInventarioId, pDataCriacao, pDataFinalizacao,
                         pDataCancelamento, pProcessoId, pTipo, pPendente, 0, 0);
  if JsonArrayInventario.Items[0].TryGetValue('Erro', vErro) then Begin
     if Pos('Não foram', vErro) = 0 then
        ShowErro(vErro)
     else
        PgcBase.ActivePage := TabPrincipal;
     LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
     LstCadastro.RowCount := 1;
     Exit;
  End;
  LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
  LstCadastro.RowCount := JsonArrayInventario.Count+1;
  Result := LstCadastro.RowCount > 1;
  if LstCadastro.RowCount > 1 then Begin
     For xInventario := 0 To JsonArrayInventario.Count-1 do begin
      LstCadastro.Cells[0, xInventario+1] := JsonArrayInventario.Items[xInventario].GetValue<Integer>('inventarioid').ToString();
      LstCadastro.Cells[1, xInventario+1] := JsonArrayInventario.Items[xInventario].GetValue<String>('tipo');
      LstCadastro.Cells[2, xInventario+1] := JsonArrayInventario.Items[xInventario].GetValue<String>('processo');
      LstCadastro.Cells[3, xInventario+1] := DateTimeToStr(JsonArrayInventario.Items[xInventario].GetValue<TDateTime>('horario')); //JsonArrayInventario.Items[xInventario].GetValue<String>('gerado');
      LstCadastro.Cells[4, xInventario+1] := JsonArrayInventario.Items[xInventario].GetValue<String>('motivo');
      LstCadastro.Cells[5, xInventario+1] := JsonArrayInventario.Items[xInventario].GetValue<String>('usuario');
      //LstCadastro.Cells[6, xInventario+1] := JsonArrayInventario.Items[xInventario].GetValue<String>('terminal');
      LstCadastro.Alignments[0, xInventario+1] := taRightJustify;
      LstCadastro.FontStyles[0, xInventario+1] := [FsBold];
     end;
     LstCadastro.FixedRows := 1;
     // LstCadastro.SortSettings.Column := 1;
     //LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
     //MontarPaginacao(ObjUsuarioCtrl.MontarPaginacao);
  End;
  Limpar;
end;

procedure TFrmInventario.GetListaLstCadastro;
begin
  inherited;
  GetListaInventario(0, 0, 0, 0, 0, 0, 1); //Ord(InventarioTipo));
end;

procedure TFrmInventario.Imprimir;
begin
  inherited;

end;

procedure TFrmInventario.Limpar;
begin
  inherited;
  InventarioNaoIniciado := True;
  TabPrincipal.TabVisible         := True;
  TabModeloPreDefinido.TabVisible := True;
  EnabledButtons := False;
  if Not EdtInventarioId.Enabled then
     EdtInventarioId.Clear;
  If Assigned(ObjInventarioCtrl) Then
     ObjInventarioCtrl.ObjInventario.Limpar;
  EdtDataCriacao.Clear;
  EdtDataLiberacao.Clear;
  LblProcesso.Caption    := '';
  EdtEstruturaId.Clear;
  LblEstrutura.Caption   := '';
  CbTipoAjuste.ItemIndex := -1;
  ChkCadastro.Checked    := False;
  ShCadastro.Brush.Color := ClRed;
  ShCadastro.Pen.Color   := ClRed;
  EdtDataCriacao.Enabled := True;
  LblInventarioId_Apuracao.Caption := EdtInventarioId.Text;
  LblInventarioId_Contagem.Caption := EdtInventarioId.Text;
  LblProcesso_Apuracao.Caption     := LblProcesso.Caption;
  LstZona.ClearRect(0, 1, LstZona.ColCount-1, LstZona.RowCount-1);
  LstEnderecoSelecao.ClearRect(0, 1, LstEnderecoSelecao.ColCount-1, LstEnderecoSelecao.RowCount-1);
  LstEnderecoDisponivel.ClearRect(0, 1, LstEnderecoDisponivel.ColCount-1, LstEnderecoDisponivel.RowCount-1);
  LstZona.RowCount               := 1;
  LstEnderecoDisponivel.RowCount := 1;
  LstEnderecoSelecao.RowCount    := 1;
  PnlZona.Enabled     := False;
  PnlEndereco.Enabled := False;
  AtivarPnlProduto(False);
  LblEnderecoDisponivel.Caption := 'Endereço Disponível(0)';
  LblEnderecoSelecao.Caption    := 'Endereço(s) Selecionado para Contagem(0)';
  If FdMemEnderecoSelecao.Active then
     FdmemEnderecoSelecao.EmptyDataSet;
  FdMemEnderecoSelecao.Close;
  If FdMemEnderecoDisponivel.Active then
     FdmemEnderecoDisponivel.EmptyDataSet;
  FdMemEnderecoDisponivel.Close;
  If FdMemEndereco.Active then
     FdmemEndereco.EmptyDataSet;
  FdMemEndereco.Close;
  If FDMemProdutoDisponivel.Active then
     FDMemProdutoDisponivel.EmptyDataSet;
  FDMemProdutoDisponivel.Close;
  LstProdutoDisponivel.ClearRect(0, 1, LstProdutoDisponivel.ColCount-1, LstProdutoDisponivel.RowCount-1);
  LstEnderecoContagem.ClearRect(0, 1, LstEnderecoContagem.ColCount-1, LstEnderecoContagem.RowCount-1);
  LstDetalheAjuste.ClearRect(0, 1, LstDetalheAjuste.ColCount-1, LstDetalheAjuste.RowCount-1);
  LstContagemLote.ClearRect(0, 1, LstContagemLote.ColCount-1, LstContagemLote.RowCount-1);
  LstProdutoDisponivel.RowCount := 1;
  LstEnderecoContagem.RowCount  := 1;
  LstDetalheAjuste.RowCount     := 1;
  LstContagemLote.RowCount      := 1;
  TabContagem.TabVisible := False;
  TabApuracao.TabVisible := False;
  EdtEnderecoContagem.Text   := '';
  CbEnderecoStatus.ItemIndex := -1;
  ImprimirExportar(False);
  LblForm.Caption := 'Inventário';
  BtnExportarStand.Grayed    := False;
  BtnExportarStand.Enabled   := True;
  TabTerceirizada.TabVisible := False;
end;

procedure TFrmInventario.LimparPreDefinido;
begin
  //EdtEstruturaIdPreDefinido.Clear;
  LblEstruturaPreDefinido.Caption     := '';
  RgTipoContagemPreDefinido.ItemIndex := 0;
  EdtEnderecoInicialPreDefinido.Clear;
  EdtEnderecoFinalPreDefinido.Clear;
  EdtRuaInicialModelo.Clear;
  EdtRuaFinalModelo.Clear;
  ChkRuaParModelo.Checked   := False;
  ChkRuaImparModelo.Checked := False;
  EdtPredioInicialModelo.Clear;
  EdtPredioFinalModelo.Clear;
  ChkPredioParModelo.Checked   := False;
  ChkPredioImparModelo.Checked := False;
  EdtNivelInicialModelo.Clear;
  EdtNivelFinalModelo.Clear;
  ChkNivelParModelo.Checked   := False;
  ChkNivelImparModelo.Checked := False;
  EdtAptoInicialModelo.Clear;
  EdtAptoFinalModelo.Clear;
  ChkAptoParModelo.Checked   := False;
  ChkAptoImparModelo.Checked := False;
  LstEnderecoModeloPreDefinido.RowCount := 1;
  BtnConferiModelo.Enabled      := BtnSalvar.Enabled;
  LblObsModeloReposicao.Visible := BtnSalvar.Enabled;
  BtnGerarInventarioModeloPreDefinido.Visible := BtnSalvar.Grayed;
  PnlTitEnderecoModeloPreDefinido.Caption := 'Qtde Endereços: 0';
end;

procedure TFrmInventario.LstDetalheAjusteClick(Sender: TObject);
begin
  if LstDetalheAjuste.Cells[0, TAdvStringGrid(Sender).Row] = '' then Exit;
  inherited;
  if TAdvStringGrid(Sender).Row > 0 then Begin
     GetContagemLote(TAdvStringGrid(Sender).Cells[0, TAdvStringGrid(Sender).Row].ToInteger());
     if InventarioTipo = poGeografico then
        FdMemLoteInventariado.Locate('CodProduto; DescrLote', VarArrayOf([TAdvStringGrid(Sender).Cells[1, TAdvStringGrid(Sender).Row], TAdvStringGrid(Sender).Cells[3, TAdvStringGrid(Sender).Row]]), [loPartialKey])
     Else FdMemLoteInventariado.Locate('Endereco; DescrLote', VarArrayOf([TAdvStringGrid(Sender).Cells[1, TAdvStringGrid(Sender).Row], TAdvStringGrid(Sender).Cells[3, TAdvStringGrid(Sender).Row]]), [loPartialKey]);
     ShowLoteContado;
  End;
end;

procedure TFrmInventario.LstDetalheAjusteClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;

end;

procedure TFrmInventario.LstEnderecoContagemClick(Sender: TObject);
Var aRow : Integer;
begin
  inherited;
  aRow := TAdvStringGrid(Sender).Row;
  if (aRow > 0) Then Begin
     LstDetalheAjuste.ClearRect(0, 1, LstDetalheAjuste.ColCount-1, LstDetalheAjuste.RowCount-1);
     LstContagemLote.ClearRect(0, 1, LstContagemLote.ColCount-1, LstContagemLote.RowCount-1);
     LstDetalheAjuste.RowCount := 1;
     LstContagemLote.RowCount  := 1;
     If (InventarioTipo = poGeografico) then Begin
//     EdtEnderecoContagem.Text := TAdvStringGri(Sender).Cells[0, aRow];
        FdMemEndereco.Locate('Descricao', StringReplace(TAdvStringGrid(Sender).Cells[0, aRow], '.', '', [rfReplaceAll]), []);
        if FdMemEndereco.FieldByName('Status').AsString <> 'I' then
           BuscarInventarioInicial;
     End
     Else Begin
        FDMemProdutoDisponivel.Locate('CodigoERP', StringReplace(TAdvStringGrid(Sender).Cells[0, aRow], '.', '', [rfReplaceAll]), []);
        if FDMemProdutoDisponivel.FieldByName('Status').AsString <> 'I' then
           BuscarInventarioInicial;
     End;
  End;
end;

procedure TFrmInventario.LstEnderecoContagemClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var vOk : Boolean;
    JsonArrayLimpar : TJsonArray;
    vErro : String;
begin
  If aRow = 0 then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  inherited;
  vOk := False;
  TAdvStringGrid(Sender).Row := aRow;
  if (TAdvStringGrid(Sender)=LstEnderecoContagem) and (aRow > 0) and (aCol= 3) and (TAdvStringGrid(Sender).Cells[3, aRow].ToInteger()=2) and
     (ObjInventarioCtrl.ObjInventario.Processoid < 143) then Begin
//     if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     if InventarioTipo = poGeografico then Begin
        If FdMemEndereco.Locate('Descricao', StringReplace(LstEnderecoContagem.Cells[0, aRow], '.', '', [rfReplaceAll]), []) Then
           JsonArrayLimpar := ObjInventarioCtrl.LimparContagem(ObjInventarioCtrl.ObjInventario.InventarioId, FdMemEndereco.FieldByName('EnderecoId').AsInteger, 0);
     End
     Else if InventarioTipo = poPrioritario then Begin
        If FDMemProdutoDisponivel.Locate('CodigoERP', StringReplace(LstEnderecoContagem.Cells[0, aRow], '.', '', [rfReplaceAll]), []) Then
           JsonArrayLimpar := ObjInventarioCtrl.LimparContagem(ObjInventarioCtrl.ObjInventario.InventarioId,
                                                               0, FDMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger);
     End;
     if JsonArrayLimpar.items[0].TryGetValue('Erro', vErro) then Begin
        ShowOk('Não foi possível limpar a contagem.');
        Exit;
     End;
     vOk := True;
     TAdvStringGrid(Sender).Cells[3, aRow] := '3';
     LstEnderecoContagem.Colors[0, aRow] := ClWhite;
     LstEnderecoContagem.Colors[1, aRow] := ClWhite;
     LstEnderecoContagem.Colors[2, aRow] := ClWhite;
     ShowOk('Item liberado para contagem.');
     BtnInventarioFechar.Color   := ClGray;
     //BtnInventarioFechar.Enabled := False;
//     if Not vOk then
//        ShowErro('Não foi possível zerar a contagem do Item.');
  End;
end;

procedure TFrmInventario.LstEnderecoDisponivelClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xEndereco : Integer;
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0)  and (aCol<3) then Begin  //and (aCol in [0, 1, 7])
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  if LstEnderecoDisponivel.RowCount <= 1 then Exit;
  if (aCol = 3) then Begin
     if (aRow = 0) and (LstEnderecoDisponivel.RowCount>1) then Begin
        For xEndereco := 1 to Pred(LstEnderecoDisponivel.RowCount) do Begin
          if SelDisponivel then
             LstEnderecoDisponivel.Cells[3, xEndereco] := '0'
          Else if LstEnderecoDisponivel.Ints[5, xEndereco] = 0 then
             LstEnderecoDisponivel.Cells[3, xEndereco] := '1';
          If FdMemEnderecoDisponivel.Locate('EnderecoId', LstEnderecoDisponivel.Cells[4, xEndereco].ToInteger(), []) then Begin
             FdMemEnderecoDisponivel.Edit;
             FdMemEnderecoDisponivel.FieldByName('Ativo').AsInteger := LstEnderecoDisponivel.Cells[3, xEndereco].ToInteger();
             FdMemEnderecoDisponivel.Post;
          End;
        End;
        SelDisponivel := Not SelDisponivel;
     End
     Else Begin
       if (StrToIntDef(LstEnderecoDisponivel.Cells[3, aRow], 0) = 0) and
          (StrToIntDef(LstEnderecoDisponivel.Cells[5, aRow], 0) = 0) then Begin
          LstEnderecoDisponivel.Cells[3, aRow] := '1';
       End
       Else Begin
         LstEnderecoDisponivel.Cells[3, aRow] := '0';
       End;
       If FdMemEnderecoDisponivel.Locate('EnderecoId', LstEnderecoDisponivel.Cells[4, aRow].ToInteger(), []) Then Begin
          FdMemEnderecoDisponivel.Edit;
          FdMemEnderecoDisponivel.FieldByName('Ativo').AsInteger := LstEnderecoDisponivel.Cells[3, aRow].ToInteger();
          FdMemEnderecoDisponivel.Post;
       End;
     End;
  End;
end;

procedure TFrmInventario.LstEnderecoSelecaoClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xSelecao : Integer;
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0)  and (aCol<3) then Begin  //and (aCol in [0, 1, 7])
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  if LstEnderecoSelecao.RowCount <= 1 then Exit;
  if (aCol = 3) then Begin
     if (aRow = 0) and (LstEnderecoSelecao.RowCount>1) then Begin
        For xSelecao := 1 to Pred(LstEnderecoSelecao.RowCount) do Begin
          if SelSelecao then
             LstEnderecoSelecao.Cells[3, xSelecao] := '0'
          Else LstEnderecoSelecao.Cells[3, xSelecao] := '1';
          If FdMemEnderecoselecao.Locate('EnderecoId', LstEnderecoSelecao.Cells[4, xSelecao].ToInteger(), []) then Begin
             FdMemEnderecoselecao.Edit;
             FdMemEnderecoselecao.FieldByName('Ativo').AsInteger := LstEnderecoSelecao.Cells[3, xSelecao].ToInteger();
             FdMemEnderecoselecao.Post;
          End;
        End;
        SelSelecao := Not SelSelecao;
     End
     Else Begin
       if StrToIntDef(LstEnderecoSelecao.Cells[3, aRow], 0) = 0 then Begin
          LstEnderecoSelecao.Cells[3, aRow] := '1';
       End
       Else Begin
         LstEnderecoSelecao.Cells[3, aRow] := '0';
       End;
       If FdMemEnderecoselecao.Locate('EnderecoId', LstEnderecoSelecao.Cells[4, aRow].ToInteger(), []) Then Begin
          FdMemEnderecoselecao.Edit;
          FdMemEnderecoselecao.FieldByName('Ativo').AsInteger := LstEnderecoSelecao.Cells[3, aRow].ToInteger();
          FdMemEnderecoselecao.Post;
       End;
     End;
  End;
end;

procedure TFrmInventario.LstModeloPredefinidoClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xModelo : Integer;
begin
{
   If (aRow = 0) and (aCol <> 2) then Begin
      TAdvStringGrid(Sender).SortSettings.Column := aCol;
      TAdvStringGrid(Sender).QSort;
      Exit;
   End;
}
  inherited;
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;
  if (aCol = 0) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        For xModelo := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if SelModelo then Begin
             TAdvStringGrid(Sender).Cells[0, xModelo] := '0';
          End
          Else Begin
             TAdvStringGrid(Sender).Cells[0, xModelo] := '1';
          End;
        End;
        SelModelo := Not SelModelo;
     End
     Else Begin
       if StrToIntDef(TAdvStringGrid(Sender).Cells[0, aRow], 0) = 0 then
          TAdvStringGrid(Sender).Cells[0, aRow] := '1'
       Else
         TAdvStringGrid(Sender).Cells[0, aRow] := '0';
     End;
  End;
end;

procedure TFrmInventario.LstModeloPredefinidoDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if (Not BtnSalvar.Grayed) then Exit;
  inherited;
  if (LstModeloPreDefinido.RowCount <= 1) or (Arow<=0) then Exit;
  EdtModeloPreDefinido.Text := LstModeloPredefinido.Cells[1, aRow];
  EdtModeloPreDefinidoExit(EdtModeloPreDefinido);
  FiltraEnderecoPreDefinido;
end;

procedure TFrmInventario.LstProdutoDisponivelClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xProd : Integer;
begin
  inherited;
  LstProdutoDisponivel.Row := aRow;
  if (LstProdutoDisponivel.RowCount <= 1) or (Not BtnSalvar.Enabled) then Exit;
  if (aCol = 6) then Begin
     if (aRow = 0) and (LstProdutoDisponivel.RowCount>1) then Begin
        For xProd := 1 to Pred(LstProdutoDisponivel.RowCount) do Begin
          if SelDisponivel then
             LstProdutoDisponivel.Cells[aCol, xProd] := '0'
          Else LstProdutoDisponivel.Cells[aCol, xProd] := '1';
        End;
        SelDisponivel := Not SelDisponivel;
     End
     Else Begin
       if StrToIntDef(LstProdutoDisponivel.Cells[aCol, aRow], 0) = 0 then Begin
          LstProdutoDisponivel.Cells[aCol, aRow] := '1';
       End
       Else Begin
         LstProdutoDisponivel.Cells[aCol, aRow] := '0';
       End;
     End;
  End;
end;

procedure TFrmInventario.LstZonaClick(Sender: TObject);
begin
  inherited;
  LstZonaClickCell(Sender, LstZona.Row, 0);
end;

procedure TFrmInventario.LstZonaClickCell(Sender: TObject; ARow, ACol: Integer);
Var xZona : Integer;
begin
  inherited;
  if (PgcBase.ActivePage = TabPrincipal) and (Inventariotipo = poUndefined) and
     (((aRow = 0)  and (aCol<4)) or (aCol = 4)) then Begin
     ShowErro('Selecione o tipo de Inventário.');
     Exit;
  End;
  TAdvStringGrid(Sender).Row := aRow;
  if (PgcBase.ActivePage = TabPrincipal) and (aRow = 0)  and (aCol<4) then Begin  //and (aCol in [0, 1, 7])
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;
  if PgcBase.ActivePage = TabModeloPreDefinido then Begin
     For xZona := 1 to Pred(TAdvStringGrid(Sender).RowCount) do
       TAdvStringGrid(Sender).Cells[4, xZona] := '0';
  End;
  if (aCol = 4) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        For xZona := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if (SelZona) then Begin
             TAdvStringGrid(Sender).Cells[4, xZona] := '0';
          End
          Else If (TAdvStringGrid(Sender).Ints[0, xZona] > 3) then
            TAdvStringGrid(Sender).Cells[4, xZona] := '1';
        End;
        SelZona := Not SelZona;
     End
     Else Begin
       if TAdvStringGrid(Sender).Ints[0, aRow] > 3 then Begin
          if TAdvStringGrid(Sender).Ints[4, aRow] = 0 then
             TAdvStringGrid(Sender).Cells[4, aRow] := '1'
          Else
             TAdvStringGrid(Sender).Cells[4, aRow] := '0';
       End
       else
          ShowErro('Não é permitido inventaria a Zona: '+TAdvStringGrid(Sender).Cells[4, aRow]);
     End;
     if (PgcBase.ActivePage = TabPrincipal) and (InventarioTipo = poGeografico) then Begin
        EdtEnderecoInicial.Clear;
        EdtEnderecoFinal.Clear;
        EdtEstruturaId.Clear;
        SelecionarEnderecoPorListaZona;
     End
     Else If (PgcBase.ActivePage = TabPrincipal) then Begin
        EdtProdutoInicial.Clear;
        SelecionarProdutoPorListaZona;
     End
     Else Begin //Modelo Pre-Definido

     End;
  End;
end;

procedure TFrmInventario.MontaEnderecoModeloPreDefinido;
Var xRow : Integer;
begin
  FdMemEnderecoModelo.First;
  LstEnderecoModeloPreDefinido.RowCount  := FdMemEnderecoModelo.RecordCount+1;
  PnlTitEnderecoModeloPreDefinido.Caption := 'Qtde Endereços: '+FdMemEnderecoModelo.RecordCount.ToString();
  LstEnderecoModeloPreDefinido.FixedRows := 1;
  xRow := 1;
  For xRow := 1 to FdMemEnderecoModelo.RecordCount do Begin
    LstEnderecoModeloPreDefinido.AddDataImage(5, xRow, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstEnderecoModeloPreDefinido.AddDataImage(6, xRow, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  xRow := 1;
  While Not FdMemEnderecoModelo.Eof Do Begin
    LstEnderecoModeloPreDefinido.Cells[0, xRow] := FdMemEnderecoModelo.FieldByName('EnderecoId').AsString;
    LstEnderecoModeloPreDefinido.Cells[1, xRow] := FdMemEnderecoModelo.FieldByName('Endereco').AsString;
    LstEnderecoModeloPreDefinido.Cells[2, xRow] := FdMemEnderecoModelo.FieldByName('RuaId').AsString;
    LstEnderecoModeloPreDefinido.Cells[3, xRow] := FdMemEnderecoModelo.FieldByName('Zona').AsString;
    LstEnderecoModeloPreDefinido.Cells[4, xRow] := FdMemEnderecoModelo.FieldByName('Curva').AsString;
    LstEnderecoModeloPreDefinido.Cells[5, xRow] := FdMemEnderecoModelo.FieldByName('Status').AsString;
    LstEnderecoModeloPreDefinido.Cells[6, xRow] := FdMemEnderecoModelo.FieldByName('Bloqueado').AsString;
    LstEnderecoModeloPreDefinido.Alignments[0, xRow] := taRightJustify;
    LstEnderecoModeloPreDefinido.FontStyles[0, xRow] := [FsBold];
    LstEnderecoModeloPreDefinido.Alignments[5, xRow] := taCenter;
    LstEnderecoModeloPreDefinido.Alignments[6, xRow] := taCenter;
    Inc(xRow);
    FdMemEnderecoModelo.Next;
  End;
end;

procedure TFrmInventario.MontaListaApuracao;
Var xApuracao : Integer;
begin
  FdMemApuracao.First;
  LstApuracao.RowCount  := FdMemApuracao.RecordCount+1;
  if FdMemApuracao.RecordCount < 1 then Exit;
  LstApuracao.FixedRows := 1;
  xApuracao := 1;
  While Not FdMemApuracao.Eof do Begin
    LstApuracao.Cells[0, xApuracao] := FdMemApuracao.FieldByName('ItemId').AsString;
    LstApuracao.Cells[1, xApuracao] := FdMemApuracao.FieldByName('CodProduto').AsString;
    LstApuracao.Cells[2, xApuracao] := FdMemApuracao.FieldByName('Descricao').Asstring;
    LstApuracao.Cells[3, xApuracao] := FdMemApuracao.FieldByName('Endereco').Asstring;
    LstApuracao.Cells[4, xApuracao] := FdMemApuracao.FieldByName('DescrLote').Asstring;
    LstApuracao.Cells[5, xApuracao] := FdMemApuracao.FieldByName('Vencimento').AsString;
    LstApuracao.Cells[6, xApuracao] := FdMemApuracao.FieldByName('EstoqueInicial').AsString;
    if FdMemApuracao.FieldByName('ContagemIniciada').AsString = '' then Begin
       LstApuracao.Cells[7, xApuracao] := '';
       LstApuracao.Cells[8, xApuracao] := '';
    End
    Else Begin
       LstApuracao.Cells[7, xApuracao] := FdMemApuracao.FieldByName('QtdContagem').AsString;
       LstApuracao.Cells[8, xApuracao] := (FdMemApuracao.FieldByName('QtdContagem').Asinteger-FdMemApuracao.FieldByName('EstoqueInicial').Asinteger).ToString();
    End;
    If (FdMemApuracao.FieldByName('QtdContagem').Asinteger-FdMemApuracao.FieldByName('EstoqueInicial').Asinteger) > 0 then
       LstApuracao.FontColors[8, xApuracao] := Clnavy
    Else If (FdMemApuracao.FieldByName('QtdContagem').Asinteger-FdMemApuracao.FieldByName('EstoqueInicial').Asinteger) < 0 then
       LstApuracao.FontColors[8, xApuracao] := ClRed
    Else LstApuracao.FontColors[8, xApuracao] := LstApuracao.Colors[6, xApuracao];
    LstApuracao.Alignments[0, xApuracao] := taRightJustify;
    LstApuracao.FontStyles[0, xApuracao] := [FsBold];
    LstApuracao.Alignments[1, xApuracao] := taRightJustify;
    LstApuracao.Alignments[6, xApuracao] := taRightJustify;
    LstApuracao.Alignments[7, xApuracao] := taRightJustify;
    LstApuracao.Alignments[8, xApuracao] := taRightJustify;
    LstApuracao.FontStyles[8, xApuracao] := [FsBold];
    FdMemApuracao.Next;
    Inc(xApuracao);
  End;
  ImprimirExportar(True);
end;

procedure TFrmInventario.MontaListaEnderecoContado;
Var xEndereco           : Integer;
    vEnderecoNContado   : Integer;
    vEnderecoEmContagem : Integer;
    vEnderecoConcluido  : Integer;
begin
//Lista Endereço Contados
  ClearDetalheAjuste;
  LstEnderecoContagem.Cells[0,0] := 'Endereço';
  LstEnderecoContagem.Cells[1,0] := 'Estrutura';
  LstEnderecoContagem.Cells[2,0] := 'Zona';
  LstEnderecoContagem.Cells[3,0] := 'Ação';
  LstEnderecoContagem.ColWidths[0] := 110+Trunc(110*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[3] :=  40+Trunc(40*ResponsivoVideo);
  LstEnderecoContagem.Alignments[0 ,0] := taRightJustify;
  LstEnderecoContagem.FontStyles[0, 0] := [FsBold];

  FdMemEndereco.First;
  if FdMemEndereco.RecordCount < 1 then Exit;
  LstEnderecoContagem.RowCount  := FdMemEndereco.RecordCount+1;
  LstEnderecoContagem.FixedRows := 1;
  LstEnderecoContagem.FixedCols := 1;
  vEnderecoNContado   := 0;
  vEnderecoEmContagem := 0;
  vEnderecoConcluido  := 0;
  for xEndereco := 1 to Pred(LstEnderecoContagem.RowCount) do
    LstEnderecoContagem.AddDataImage(3, xEndereco, 2, haCenter, vaTop);
  xEndereco           := 1;
  While Not FdMemEndereco.Eof do Begin
    LstEnderecoContagem.Cells[0, xEndereco] := EnderecoMask(FdMemEndereco.FieldByName('Descricao').AsString, FdMemEndereco.FieldByName('Mascara').AsString, True);
    LstEnderecoContagem.Cells[1, xEndereco] := FdMemEndereco.FieldByName('Estrutura').AsString;
    LstEnderecoContagem.Cells[2, xEndereco] := FdMemEndereco.FieldByName('Zona').AsString;
    If (FdMemEndereco.FieldByName('Status').AsString <> 'I') and (ObjInventarioCtrl.ObjInventario.processoid < 143) then
       LstEnderecoContagem.Cells[3, xEndereco] := '2'
    Else
       LstEnderecoContagem.Cells[3, xEndereco] := '3';
    LstEnderecoContagem.Alignments[0, xEndereco] := taRightJustify;
    LstEnderecoContagem.FontStyles[0, xEndereco] := [FsBold];
    If FdMemEndereco.FieldByName('Status').AsString = 'I' then Begin
       LstEnderecoContagem.Colors[0, xEndereco] := ClWhite;
       LstEnderecoContagem.Colors[1, xEndereco] := ClWhite;
       LstEnderecoContagem.Colors[2, xEndereco] := ClWhite;
       inc(vEnderecoNContado);
    End
    Else If FdMemEndereco.FieldByName('Status').AsString = 'C' then Begin
       LstEnderecoContagem.Colors[0, xEndereco] := $0060E5E5;
       LstEnderecoContagem.Colors[1, xEndereco] := $0060E5E5;
       LstEnderecoContagem.Colors[2, xEndereco] := $0060E5E5;
       inc(vEnderecoEmContagem);
    End
    Else If FdMemEndereco.FieldByName('Status').AsString = 'F' then Begin
       LstEnderecoContagem.Colors[0, xEndereco] := $0032B932;
       LstEnderecoContagem.Colors[1, xEndereco] := $0032B932;
       LstEnderecoContagem.Colors[2, xEndereco] := $0032B932;
       inc(vEnderecoConcluido);
    End;
    FdMemEndereco.Next;
    Inc(xEndereco);
  End;
  FdMemEndereco.First;
  LblEnderecoTotal.Caption      := 'Endereço(s)';
  EdtEnderecoTotal.Text         := FdMemEndereco.recordCount.ToString();
  EdtEnderecoNaoContado.Text    := vEnderecoNContado.ToString();
  EdtEnderecoEmContagem.Text    := vEnderecoEmContagem.ToString();
  EdtEnderecoConcluido.Text     := vEnderecoConcluido.ToString();
  LblEnderecoNaoContado.Caption := FormatFloat('##0.0', RoundTo(vEnderecoNContado/FdMemEndereco.recordCount*100, -2))+'%';
  LblEnderecoEmContagem.Caption := FormatFloat('##0.0', RoundTo(vEnderecoEmcontagem/FdMemEndereco.recordCount*100, -2))+'%';
  LblEnderecoConcluido.Caption  := FormatFloat('##0.0', RoundTo(vEnderecoConcluido/FdMemEndereco.recordCount*100, -2))+'%';
  if (Pos('Finalizado', LblProcesso.Caption)>0) or (Pos('Cancelado', LblProcesso.Caption)>0) or
     (vEnderecoNContado>0) or (vEnderecoEmContagem>0) or (InventarioNaoIniciado) then
     BtnInventarioFechar.Color := clGray
  else BtnInventarioFechar.Color := $0077C03A;
  if (Pos('Finalizado', LblProcesso.Caption)>0) or (Pos('Cancelado', LblProcesso.Caption)>0) then
     BtnInventarioCancelar.Color := clGray
  else
     BtnInventarioCancelar.Color := ClRed;
  FdMemEndereco.First;
  //BuscarInventarioInicial;
end;

procedure TFrmInventario.MontaListaEnderecoDisponivel;
Var xEndereco        : Integer;
begin
  FdMemEnderecoDisponivel.First;
  LblEnderecoDisponivel.Caption := 'Endereço Disponível('+FdMemEnderecoDisponivel.RecordCount.ToString+')';
  LstEnderecoDisponivel.RowCount  := FdMemEnderecoDisponivel.RecordCount+1;
  if FdMemEnderecoDisponivel.RecordCount < 1 then Exit;
  LstenderecoDisponivel.FixedRows := 1;
  for xEndereco := 1 to Pred(LstEnderecoDisponivel.RowCount) do
    LstEnderecoDisponivel.AddDataImage(3, xEndereco, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xEndereco := 1;
  While Not FdMemEnderecoDisponivel.Eof do Begin
    LstEnderecoDisponivel.Cells[0, xEndereco] := EnderecoMask(FdMemEnderecoDisponivel.FieldByName('descricao').AsString,
                                                                FdMemEnderecoDisponivel.FieldByName('mascara').AsString, True);
    LstEnderecoDisponivel.Cells[1, xEndereco] := FdMemEnderecoDisponivel.FieldByName('Estrutura').AsString;
    LstEnderecoDisponivel.Cells[2, xEndereco] := FdMemEnderecoDisponivel.FieldByName('Zona').Asstring;
    LstEnderecoDisponivel.Cells[3, xEndereco] := '0';
    LstEnderecoDisponivel.Cells[4, xEndereco] := FdMemEnderecoDisponivel.FieldByName('enderecoid').AsString;
    LstEnderecoDisponivel.Cells[5, xEndereco] := FdMemEnderecoDisponivel.FieldByName('ReservadoInventario').AsString;
    If FdMemEnderecoDisponivel.FieldByName('ReservadoInventario').AsInteger = 1 then Begin
       LstEnderecoDisponivel.Colors[1, xEndereco] := ClRed;
       LstEnderecoDisponivel.Colors[2, xEndereco] := ClRed;
       LstEnderecoDisponivel.Colors[3, xEndereco] := ClRed;
       LstEnderecoDisponivel.Colors[4, xEndereco] := ClRed;
    End
    Else Begin
{       LstEnderecoDisponivel.Colors[1, xEndereco] := ClRed;
       LstEnderecoDisponivel.Colors[2, xEndereco] := ClRed;
       LstEnderecoDisponivel.Colors[3, xEndereco] := ClRed;
       LstEnderecoDisponivel.Colors[4, xEndereco] := ClRed;
}    End;
    LstEnderecoDisponivel.Alignments[0, xEndereco] := taRightJustify;
    LstEnderecoDisponivel.FontStyles[0, xEndereco] := [FsBold];
    FdMemEnderecoDisponivel.Next;
    Inc(xEndereco);
  End;
end;

procedure TFrmInventario.MontaListaEnderecoSelecao;
Var xEndereco : Integer;
begin
  FdMemEnderecoSelecao.First;
  LstEnderecoSelecao.RowCount  := FdMemEnderecoSelecao.RecordCount+1;
  if FdMemEnderecoSelecao.RecordCount < 1 then Exit;
  LstEnderecoSelecao.FixedRows := 1;
  For xEndereco := 1 to FdMemEnderecoSelecao.RecordCount do
    LstEnderecoSelecao.AddDataImage(3, xEndereco, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xEndereco := 1;
  LblEnderecoSelecao.Caption := 'Endereço(s) Selecionado para Contagem('+FdMemEnderecoSelecao.RecordCount.ToString+')';
  While Not FdMemEnderecoSelecao.Eof do Begin
    LstEnderecoSelecao.Cells[0, xEndereco] := EnderecoMask(FdMemEnderecoSelecao.FieldByName('descricao').AsString,
                                                                FdMemEnderecoSelecao.FieldByName('mascara').AsString, True);
    LstEnderecoSelecao.Cells[1, xEndereco] := FdMemEnderecoSelecao.FieldByName('Estrutura').AsString;
    LstEnderecoSelecao.Cells[2, xEndereco] := FdMemEnderecoSelecao.FieldByName('Zona').Asstring;
    LstEnderecoSelecao.Cells[3, xEndereco] := FdMemEnderecoSelecao.FieldByName('Ativo').Asstring;
    LstEnderecoSelecao.Cells[4, xEndereco] := FdMemEnderecoSelecao.FieldByName('enderecoid').AsString;
    LstEnderecoSelecao.Alignments[0, xEndereco] := taRightJustify;
    LstEnderecoSelecao.FontStyles[0, xEndereco] := [FsBold];
    FdMemEnderecoSelecao.Next;
    Inc(xEndereco);
  End;
end;

procedure TFrmInventario.MontaListaLoteInventariado;
Var xEndereco : Integer;
    VTotContAnterior, vTotContAtual : Integer;
begin
  FdMemLoteInventariado.First;
  LstDetalheAjuste.ClearRect(0, 1, LstDetalheAjuste.ColCount-1, LstDetalheAjuste.RowCount-1);
  LstDetalheAjuste.RowCount  := 1;  //FdMemLoteInventariado.RecordCount+1;
  if FdMemLoteInventariado.RecordCount < 1 then Exit;
  xEndereco := 1;
  LblEnderecoSelecao.Caption := 'Endereço(s) Selecionado para Contagem('+FdMemEnderecoSelecao.RecordCount.ToString+')';
  ShowLoteContado;
  VTotContAnterior := 0;
  vTotContAtual    := 0;
  While Not FdMemLoteInventariado.Eof do Begin
    if FdMemLoteInventariado.FieldByName('CodProduto').AsString <> '' then Begin
       LstDetalheAjuste.RowCount := LstDetalheAjuste.RowCount + 1;
       LstDetalheAjuste.Cells[0, xEndereco] := FdMemLoteInventariado.FieldByName('ItemId').AsString;
       If InventarioTipo = poGeografico Then
          LstDetalheAjuste.Cells[1, xEndereco] := FdMemLoteInventariado.FieldByName('CodProduto').AsString
       Else LstDetalheAjuste.Cells[1, xEndereco] := FdMemLoteInventariado.FieldByName('Endereco').AsString;
       LstDetalheAjuste.Cells[2, xEndereco] := FdMemLoteInventariado.FieldByName('Descricao').Asstring;
       LstDetalheAjuste.Cells[3, xEndereco] := FdMemLoteInventariado.FieldByName('DescrLote').Asstring;
       LstDetalheAjuste.Cells[4, xEndereco] := FdMemLoteInventariado.FieldByName('Vencimento').AsString;
       LstDetalheAjuste.Cells[5, xEndereco] := FdMemLoteInventariado.FieldByName('EstoqueInicial').AsString;
       LstDetalheAjuste.Cells[6, xEndereco] := FdMemLoteInventariado.FieldByName('QtdContagem').AsString;
       LstDetalheAjuste.Cells[7, xEndereco] := (FdMemLoteInventariado.FieldByName('QtdContagem').Asinteger-FdMemLoteInventariado.FieldByName('EstoqueInicial').Asinteger).ToString();
       LstDetalheAjuste.Cells[8, xEndereco] := FdMemLoteInventariado.FieldByName('status').AsString;
       If (FdMemLoteInventariado.FieldByName('QtdContagem').Asinteger-FdMemLoteInventariado.FieldByName('EstoqueInicial').Asinteger) > 0 then
          LstDetalheAjuste.FontColors[7, xEndereco] := Clnavy
       Else If (FdMemLoteInventariado.FieldByName('QtdContagem').Asinteger-FdMemLoteInventariado.FieldByName('EstoqueInicial').Asinteger) < 0 then
          LstDetalheAjuste.FontColors[7, xEndereco] := ClRed
       Else LstDetalheAjuste.FontColors[7, xEndereco] := LstDetalheAjuste.Colors[6, xEndereco];
       if True then

       If FdMemLoteInventariado.FieldByName('status').AsString = 'I2' then Begin
          LstDetalheAjuste.Colors[1, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[2, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[3, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[4, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[5, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[6, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[7, xEndereco] := ClWhite;
          LstDetalheAjuste.Colors[7, xEndereco] := ClWhite;
       End
       Else If FdMemLoteInventariado.FieldByName('status').AsString = 'C' then Begin
          LstDetalheAjuste.Colors[0, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[1, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[2, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[3, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[4, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[5, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[6, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[7, xEndereco] := $0060E5E5;
          LstDetalheAjuste.Colors[8, xEndereco] := $0060E5E5;
       End
       Else If FdMemLoteInventariado.FieldByName('status').AsString = 'F' then Begin
          LstDetalheAjuste.Colors[0, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[1, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[2, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[3, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[4, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[5, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[6, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[7, xEndereco] := $0032B932;
          LstDetalheAjuste.Colors[8, xEndereco] := $0032B932;
       End;

       VTotContAnterior := VTotContAnterior + FdMemLoteInventariado.FieldByName('EstoqueInicial').AsInteger;
       vTotContAtual    := vTotContAtual + FdMemLoteInventariado.FieldByName('QtdContagem').AsInteger;
       LstDetalheAjuste.Alignments[0, xEndereco] := taRightJustify;
       LstDetalheAjuste.FontStyles[0, xEndereco] := [FsBold];
       LstDetalheAjuste.Alignments[1, xEndereco] := taRightJustify;
       LstDetalheAjuste.Alignments[5, xEndereco] := taRightJustify;
       LstDetalheAjuste.Alignments[6, xEndereco] := taRightJustify;
       LstDetalheAjuste.Alignments[7, xEndereco] := taRightJustify;
       LstDetalheAjuste.FontStyles[7, xEndereco] := [FsBold];
       LstDetalheAjuste.Alignments[8, xEndereco] := taCenter;
       Inc(xEndereco);
    End;
    FdMemLoteInventariado.Next;
  End;
  LstDetalheAjuste.RowCount := LstDetalheAjuste.RowCount+1;
  LstDetalheAjuste.Cells[3, LstDetalheAjuste.RowCount-1] := 'TOTAL -->';
  LstDetalheAjuste.Cells[5, LstDetalheAjuste.RowCount-1] := vTotContAnterior.ToString();
  LstDetalheAjuste.Cells[6, LstDetalheAjuste.RowCount-1] := vTotContAtual.ToString();
  LstDetalheAjuste.Cells[7, LstDetalheAjuste.RowCount-1] := (vTotContAtual-vTotContAnterior).ToString();
  LstDetalheAjuste.Alignments[3, LstDetalheAjuste.RowCount-1] := taRightJustify;
  LstDetalheAjuste.Alignments[5, LstDetalheAjuste.RowCount-1] := taRightJustify;
  LstDetalheAjuste.Alignments[6, LstDetalheAjuste.RowCount-1] := taRightJustify;
  LstDetalheAjuste.Alignments[7, LstDetalheAjuste.RowCount-1] := taRightJustify;
  LstDetalheAjuste.FontStyles[3, LstDetalheAjuste.RowCount-1] := [FsBold];
  LstDetalheAjuste.FontStyles[5, LstDetalheAjuste.RowCount-1] := [FsBold];
  LstDetalheAjuste.FontStyles[6, LstDetalheAjuste.RowCount-1] := [FsBold];
  LstDetalheAjuste.FontStyles[7, LstDetalheAjuste.RowCount-1] := [FsBold];
  FdMemLoteInventariado.First;
  GetContagemLote(FdMemLoteInventariado.FieldByName('ItemId').Asinteger);
  if lstDetalheAjuste.RowCount > 1 then
     LstDetalheAjuste.FixedRows := 1;
end;

procedure TFrmInventario.MontaListaProdutoContado;
Var xProduto           : Integer;
    vProdutoNContado   : Integer;
    vProdutoEmContagem : Integer;
    vProdutoConcluido  : Integer;
begin
//Lista Endereço Contados
  ClearDetalheAjuste;
  LstEnderecoContagem.Cells[0,0] := 'Código';
  LstEnderecoContagem.Cells[1,0] := 'Descrição';
  LstEnderecoContagem.Cells[2,0] := 'Picking';
  LstEnderecoContagem.Cells[3,0] := 'Ação';
  LstEnderecoContagem.ColWidths[0] :=  90+Trunc(90*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[1] := 250+Trunc(250*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[2] :=  90+Trunc(90*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[3] :=  40+Trunc(40*ResponsivoVideo);
  LstEnderecoContagem.Alignments[0 ,0] := taRightJustify;
  LstEnderecoContagem.FontStyles[0, 0] := [FsBold];

  FDMemProdutoDisponivel.First;
  if FDMemProdutoDisponivel.RecordCount < 1 then Exit;
  LstEnderecoContagem.RowCount  := FDMemProdutoDisponivel.RecordCount+1;
  LstEnderecoContagem.FixedRows := 1;
  LstEnderecoContagem.FixedCols := 1;
  vProdutoNContado   := 0;
  vProdutoEmContagem := 0;
  vProdutoConcluido  := 0;
  for xProduto := 1 to Pred(LstEnderecoContagem.RowCount) do
    LstEnderecoContagem.AddDataImage(3, xProduto, 2, haCenter, vaTop);
  xProduto           := 1;
  While Not FDMemProdutoDisponivel.Eof do Begin
    LstEnderecoContagem.Cells[0, xProduto] := FDMemProdutoDisponivel.FieldByName('CodigoERP').AsString;
    LstEnderecoContagem.Cells[1, xProduto] := FDMemProdutoDisponivel.FieldByName('Descricao').AsString;
    LstEnderecoContagem.Cells[2, xProduto] := EnderecoMask(FDMemProdutoDisponivel.FieldByName('Picking').AsString,
                                                           FDMemProdutoDisponivel.FieldByName('Mascara').AsString, True);
    //FDMemProdutoDisponivel.FieldByName('Picking').AsString;
    If (FDMemProdutoDisponivel.FieldByName('Status').AsString <> 'I') and (ObjInventarioCtrl.ObjInventario.ProcessoId < 143) then
       LstEnderecoContagem.Cells[3, xProduto] := '2'
    Else LstEnderecoContagem.Cells[3, xProduto] := '3';
    LstEnderecoContagem.Alignments[0, xProduto] := taRightJustify;
    LstEnderecoContagem.FontStyles[0, xProduto] := [FsBold];
    If FDMemProdutoDisponivel.FieldByName('Status').AsString = 'I' then Begin
       LstEnderecoContagem.Colors[0, xProduto] := ClWhite;
       LstEnderecoContagem.Colors[1, xProduto] := ClWhite;
       LstEnderecoContagem.Colors[2, xProduto] := ClWhite;
       inc(vProdutoNContado);
    End
    Else If FDMemProdutoDisponivel.FieldByName('Status').AsString = 'C' then Begin
       LstEnderecoContagem.Colors[0, xProduto] := $0060E5E5;
       LstEnderecoContagem.Colors[1, xProduto] := $0060E5E5;
       LstEnderecoContagem.Colors[2, xProduto] := $0060E5E5;
       inc(vProdutoEmContagem);
    End
    Else If FDMemProdutoDisponivel.FieldByName('Status').AsString = 'F' then Begin
       LstEnderecoContagem.Colors[0, xProduto] := $0032B932;
       LstEnderecoContagem.Colors[1, xProduto] := $0032B932;
       LstEnderecoContagem.Colors[2, xProduto] := $0032B932;
       inc(vProdutoConcluido);
    End;
    FDMemProdutoDisponivel.Next;
    Inc(xProduto);
  End;
  LblEnderecoTotal.Caption      := 'Produto(s)';
  EdtEnderecoTotal.Text         := FDMemProdutoDisponivel.recordCount.ToString();
  EdtEnderecoNaoContado.Text    := vProdutoNContado.ToString();
  EdtEnderecoEmContagem.Text    := vProdutoEmContagem.ToString();
  EdtEnderecoConcluido.Text     := vProdutoConcluido.ToString();
  LblEnderecoNaoContado.Caption := FormatFloat('##0.0', RoundTo(vProdutoNContado/FDMemProdutoDisponivel.recordCount*100, -2))+'%';
  LblEnderecoEmContagem.Caption := FormatFloat('##0.0', RoundTo(vProdutoEmcontagem/FDMemProdutoDisponivel.recordCount*100, -2))+'%';
  LblEnderecoConcluido.Caption  := FormatFloat('##0.0', RoundTo(vProdutoConcluido/FDMemProdutoDisponivel.recordCount*100, -2))+'%';
  if (Pos('Finalizado', LblProcesso.Caption)>0) or (Pos('Cancelado', LblProcesso.Caption)>0) or
     (vProdutoNContado>0) or (vProdutoEmContagem>0) then
     BtnInventarioFechar.Color := clGray
  else BtnInventarioFechar.Color := $0077C03A;
  if (Pos('Finalizado', LblProcesso.Caption)>0) or (Pos('Cancelado', LblProcesso.Caption)>0) then
     BtnInventarioCancelar.Color := clGray
  else
     BtnInventarioCancelar.Color := ClRed;
  FDMemProdutoDisponivel.First;
end;

procedure TFrmInventario.MontaListaProdutoDisponivel(pSearchInventario : Boolean);
Var xProd : Integer;
begin
  FdMemProdutoDisponivel.First;
  LblProdutoDisponivel.Caption := 'Produto(s) Disponível('+FdMemProdutoDisponivel.RecordCount.ToString+')';
  LstProdutoDisponivel.RowCount  := FdMemProdutoDisponivel.RecordCount+1;
  if FdMemProdutoDisponivel.RecordCount < 1 then Exit;
  LstProdutoDisponivel.FixedRows := 1;
  for xProd := 1 to Pred(LstProdutoDisponivel.RowCount) do Begin
    LstProdutoDisponivel.AddDataImage(4, xProd, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstProdutoDisponivel.AddDataImage(6, xProd, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  xProd := 1;
  While Not FdMemProdutoDisponivel.Eof do Begin
    LstProdutoDisponivel.Cells[0, xProd] := FdMemProdutoDisponivel.FieldByName('CodigoERP').AsString;
    LstProdutoDisponivel.Cells[1, xProd] := FdMemProdutoDisponivel.FieldByName('Descricao').AsString;
    LstProdutoDisponivel.Cells[2, xProd] := EnderecoMask(FdMemProdutoDisponivel.FieldByName('picking').AsString,
                                                                FdMemEnderecoDisponivel.FieldByName('mascara').AsString, True);
    LstProdutoDisponivel.Cells[3, xProd] := FdMemProdutoDisponivel.FieldByName('zona').AsString;
    LstProdutoDisponivel.Cells[4, xProd] := FdMemProdutoDisponivel.FieldByName('Sngpc').AsString;
    //if pSearchInventario then
    //   LstProdutoDisponivel.Cells[5, xProd] := '1'
    //Else
    LstProdutoDisponivel.Cells[5, xProd] := '0'; //Indicar Reserva
    LstProdutoDisponivel.Cells[6, xProd] := '0';
    LstProdutoDisponivel.Cells[7, xProd] := FdMemProdutoDisponivel.FieldByName('produtoId').AsString;
//    LstProdutoDisponivel.Cells[4, xProd] := FdMemProdutoDisponivel.FieldByName('Status').AsString;;
    LstProdutoDisponivel.Alignments[0, xProd] := taRightJustify;
    LstProdutoDisponivel.FontStyles[0, xProd] := [FsBold];
    LstProdutoDisponivel.Alignments[4, xProd] := taCenter;
    LstProdutoDisponivel.Alignments[5, xProd] := taCenter;
    LstProdutoDisponivel.Alignments[6, xProd] := taCenter;
    FdMemProdutoDisponivel.Next;
    Inc(xProd);
  End;
end;

procedure TFrmInventario.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtInventarioId.Text := LstCadastro.Cells[0, aRow];
{
   if LstCadastro.Cells[1, aRow] = 'Por Endereço' then
      RbInventarioTipo.ItemIndex := 0
   Else
      RbInventarioTipo.ItemIndex := 1;
}
  EdtInventarioIdExit(EdtInventarioId);
end;

function TFrmInventario.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayProcesso : TJsonArray;
    vErro             : String;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListainventario(StrToIntDef(EdtConteudoPesq.Text, 0), 0, 0, 0, 0, Ord(InventarioTipo), 0)
        else raise Exception.Create('Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then Begin
        Try
           Result := GetListaInventario(0, StrToDate(EdtConteudoPesq.Text), 0, 0, 0, Ord(InventarioTipo), 0);
        Except
           raise Exception.Create('Data inválida para pesquisa!')
        End;
     End
     Else if CbCampoPesq.ItemIndex = 2 then
        Result := GetListaInventario(0, 0, 0, 0, StrToIntDef(EdtConteudoPesq.Text, 0), Ord(InventarioTipo), 0)
     Else if CbCampoPesq.ItemIndex = 3 then Begin
        JsonArrayProcesso := ObjProcessoCtrl.GetProcesso(EdtConteudoPesq.Text, 0);
        if JsonArrayProcesso.Items[0].TryGetValue('Erro', vErro) then Begin
           JsonArrayProcesso := Nil;
           raise Exception.Create('Id do Processo não encontrado!');
        End
        Else
           Result := GetListaInventario(0, 0, 0, 0, JsonArrayProcesso.Items[0].GetValue<Integer>('codigo'), Ord(InventarioTipo), 0);
        JsonArrayProcesso := Nil;
     End;
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmInventario.PgcBaseChange(Sender: TObject);
begin
  //inherited;

end;

procedure TFrmInventario.ProcessarFileImport;
Var ObjEstoqueCtrl : TEstoqueCtrl;
    ObjLoteCtrl    : TLoteCtrl;
    JsonLoteRetorno, JsonLote , JsonEstoque, JsonKardex, JsonEstoqueKardex : TJsonObject;
    JsonArrayEstoque, JsonArrayKardex : TjsonArray;
    vLoteId : Integer;
    vErro : String;
begin
  inherited;
  FdMemPesqGeral.First;
  while Not FdMemPesqGeral.Eof do Begin
    if //(FdMemPesqGeral.FieldByName('Picking').AsInteger=1) and
       (FdMemPesqGeral.FieldByName('Produto').AsInteger=1) and
       (FdMemPesqGeral.FieldByName('EnderecoId').AsInteger>0) then Begin
       JsonArrayEstoque := tJsonArray.Create;
       JsonArrayKardex  := tJsonArray.Create;
       JsonLote := TJsonObject.Create;
       JsonLote.AddPair('produtoid',  TJsonNumber.Create(FdMemPesqGeral.FieldByName('ProdutoId').AsInteger));
       JsonLote.AddPair('codigoerp',  TJsonNumber.Create(FdMemPesqGeral.FieldByName('CodProduto').AsInteger));
       JsonLote.AddPair('loteid'   ,  TJsonNumber.Create(0));
       JsonLote.AddPair('descrlote',  FormatDateTime('YYMMDD', now()));
       JsonLote.AddPair('fabricacao', FormatDateTime('DD/MM/YYY', now()));
       JsonLote.AddPair('vencimento', FormatDateTime('DD/MM/YYY', now()+733));
       JsonLoteRetorno := ObjLoteCtrl.SalvarLote(JsonLote);
       if JsonLoteRetorno.TryGetValue('Erro', vErro) then
          vLoteId := 0
       Else
          vLoteId := JsonLoteRetorno.GetValue<Integer>('loteid');
       //ObjLoteCtrl.Free;
       JsonEstoque := tJsonObject.Create;
       With jsonEstoque do Begin //Origem
         AddPair('loteid', TJSONNumber.Create(vLoteId));
         AddPair('enderecoid', TJSONNumber.Create(FdMemPesqGeral.FieldByName('EnderecoId').AsInteger));
         AddPair('estoquetipoid', TJSONNumber.Create(4));
         Addpair('qtde', TJSONNumber.Create(FdMemPesqGeral.FieldByName('Quantidade').AsInteger));
         AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
       End;
       JsonArrayEstoque.AddElement(jsonEstoque);
       //JsonKardex := tJsonObject.Create;
       //JsonArrayKardex.AddElement(jsonKardex);
       JsonEstoqueKardex := tJsonObject.create;
       JsonEstoqueKardex.AddPair('estoque', jsonArrayEstoque);
       JsonEstoqueKardex.AddPair('kardex', jsonArraykardex);
       ObjEstoqueCtrl.Salvar(jsonEstoqueKardex);
       JsonArrayEstoque.Free;
       JsonArrayKardex.Free;
    End;
    FdMemPesqGeral.Next;
  End;
  ShowOk('Importação concluída...');
end;

procedure TFrmInventario.RbInventarioTipoClick(Sender: TObject);
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then
     DefineInventarioTipo;
end;

function TFrmInventario.SalvarReg: Boolean;
Var vErro : String;
    JsonEndereco, JsonProduto : TJsonObject;
    JsonArrayInventarioCriar  : TJsonArray;
    JsonArrayRetorno          : TJsonArray;
    xItens                    : Integer;
    ObjJsonObjectModeloInventario : TJsonObject;
begin
  Result := False;
  if PgcBase.ActivePage = TabPrincipal then Begin
     If ((InventarioTipo = poGeografico) and (LstEnderecoSelecao.RowCount <= 1)) then Begin
        ShowErro('É necessário selecionar 1(um) ou mais endereço para contagem.');
        Exit;
     End;
     If ((InventarioTipo = poPrioritario) and (LstProdutoDisponivel.RowCount <= 1)) then Begin
        ShowErro('É necessário selecionar 1(um) ou mais Produtos para contagem.');
        Exit;
     End;
     If (CbTipoAjuste.ItemIndex < 0) then Begin
        CbTipoAjuste.SetFocus;
        ShowErro('É necessário selecionar o tipo de Ajuste.');
        Exit;
     End;
     ObjInventarioCtrl.ObjInventario.InventarioId   := StrToIntDef(EdtInventarioId.Text, 0);
     ObjInventarioCtrl.ObjInventario.DataCriacao    := StrToDate(EdtDataCriacao.Text);
     if EdtDataLiberacao.Text <> '  /  /    ' then
        ObjInventarioCtrl.ObjInventario.DataLiberacao  := StrToDate(EdtDataLiberacao.Text)
     Else ObjInventarioCtrl.ObjInventario.DataLiberacao  := 0;
     ObjInventarioCtrl.ObjInventario.InventarioTipo := Ord(InventarioTipo);
     ObjInventarioCtrl.ObjInventario.Motivo         := EdtMotivo.Text;
     ObjInventarioCtrl.ObjInventario.TipoAjuste     := CbTipoAjuste.itemIndex;
     ObjinventarioCtrl.ObjInventario.status         := 1;
     //JsonObjectEndereco := TJsonObject.Create;
     JsonArrayInventarioCriar := TJsonArray.Create;
     if InventarioTipo = poGeografico then Begin
        For xItens := 1 to Pred(LstEnderecoSelecao.RowCount) do Begin
           JsonEndereco := TJsonObject.Create;
          JsonEndereco.AddPair('enderecoid', TJsonNumber.Create(LstEnderecoSelecao.Cells[4, xItens].ToInteger));
          JsonArrayInventarioCriar.AddElement(JsonEndereco);
        End;
     End
     Else If InventarioTipo = poPrioritario then Begin
        For xItens := 1 to Pred(LstProdutoDisponivel.RowCount) do Begin
          JsonProduto := TJsonObject.Create;
          JsonProduto.AddPair('produtoid', TJsonNumber.Create(LstProdutoDisponivel.Cells[7, xItens].ToInteger));
          JsonArrayInventarioCriar.AddElement(JsonProduto);
        End;
     End;
     If Not ObjInventarioCtrl.Salvar(JsonArrayInventarioCriar).TryGetValue('Erro', verro) then Begin
        ObjInventarioCtrl.ObjInventario.InventarioId := 0;
        Result := True
     End
     Else Result := False;
     JsonArrayInventarioCriar := Nil;
  End 
  Else Begin
     if EdtEstruturaIdPreDefinido.Text = '' then Begin
        ShowErro('Informe o tipo de estrutura para contagem!');
     End
     Else if (EdtEnderecoInicialPreDefinido.Text = '') and
        (EdtEnderecoFinalPreDefinido.Text = '') and
        (EdtRuaInicialModelo.Text = '') and
        (EdtRuaFinalModelo.Text = '') and
        (ChkRuaParModelo.Checked = False) and
        (ChkRuaImparModelo.Checked = False) and
        (EdtPredioInicialModelo.Text = '') and
        (EdtPredioFinalModelo.Text = '') and
        (ChkPredioParModelo.Checked = False) and
        (ChkPredioImparModelo.Checked = False) and
        (EdtNivelInicialModelo.Text = '') and
        (EdtNivelFinalModelo.Text = '') and
        (ChkNivelParModelo.Checked = False) and
        (ChkNivelImparModelo.Checked = False) and
        (EdtAptoInicialModelo.Text = '') and
        (EdtAptoFinalModelo.Text = '') and
        (ChkAptoParModelo.Checked   = False) and
        (ChkAptoImparModelo.Checked = False) then
        ShowErro('Informe os dados para gerar inventário(Contagem)!')
     Else if LstEnderecoModeloPreDefinido.RowCount <= 1  then
        ShowErro('Confira os endereções do Modelo pré-definido!')
     Else Begin
       ObjJsonObjectModeloInventario := TJsonObject.Create;
       ObjJsonObjectModeloInventario.AddPair('modeloid', TJsonNumber.Create(StrToIntDef(EdtModeloPreDefinido.Text, 0)))
                                    .AddPair('estruturaid', EdtEstruturaIdPreDefinido.Text)
                                    .AddPair('zonaid', EdtZonaIdPreDefinido.Text)
                                    .AddPair('enderecoinicial', EdtEnderecoInicialPreDefinido.Text)
                                    .AddPair('enderecofinal', EdtEnderecoFinalPreDefinido.Text)
                                    .AddPair('ruainicial', EdtRuaInicialModelo.Text)
                                    .AddPair('ruafinal', EdtRuaFinalModelo.Text)
                                    .AddPair('ruapar', Ord(ChkRuaParModelo.Checked).ToString())
                                    .AddPair('ruaimpar', ord(ChkRuaImparModelo.Checked).ToString())
                                    .AddPair('predioinicial', EdtPredioInicialModelo.Text)
                                    .AddPair('prediofinal', EdtPredioFinalModelo.Text)
                                    .AddPair('prediopar', Ord(ChkPredioParModelo.Checked).ToString())
                                    .AddPair('predioimpar', Ord(ChkPredioImparModelo.Checked).ToString())
                                    .AddPair('nivelinicial', EdtNivelInicialModelo.Text)
                                    .AddPair('nivelfinal', EdtNivelFinalModelo.Text)
                                    .AddPair('nivelpar', Ord(ChkNivelParModelo.Checked).ToString())
                                    .AddPair('nivelimpar', Ord(ChkNivelImparModelo.Checked).ToString())
                                    .AddPair('aptoinicial', EdtAptoInicialModelo.Text)
                                    .AddPair('aptofinal', EdTAptoFinalModelo.Text)
                                    .AddPair('aptopar', Ord(ChkAptoParModelo.Checked).ToString())
                                    .AddPair('aptoimpar', Ord(ChkAptoImparModelo.Checked).ToString())
                                    .AddPair('terminal', NomeDoComputador)
                                    .AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
       JsonArrayRetorno := ObjInventarioCtrl.SalvarModeloInventario(ObjJsonObjectModeloInventario);
       if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
          ShowErro('Erro: '+vErro)
       Else Begin
         Result := True;
         ShowOk('Modelo Salvo com sucesso!');
       end;
       JsonArrayRetorno := Nil;
       FreeAndNil(ObjJsonObjectModeloInventario);
     End;
  End;
end;

procedure TFrmInventario.SbGerarArquivoClick(Sender: TObject);
Var ObjProdutoCtrl   : TProdutoCtrl;
    ObjEnderecoCtrl  : TEnderecoCtrl;
    ArquivoCSV       : TextFile;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if (Not ChkProduto.Checked) and (Not ChkEndereco.Checked) then
     raise Exception.Create('Selecione o arquivo a ser gerado!');
  inherited;
  Try
    TDialogMessage.ShowWaitMessage('Aguarde!!! Gerando o arquivo...',
      procedure
      begin
        if ChkProduto.Checked then Begin
           ObjProdutoCtrl := TProdutoCtrl.Create;
           JsonArrayRetorno := ObjProdutoCtrl.ExportFile('CodBarras, CodProduto, Descricao');
           if JsonArrayRetorno.items[0].TryGetValue('Erro', vErro) then
              ShowErro(vErro)
           Else Begin
              If FdMemPesqGeral.Active then
                 FdmemPesqGeral.EmptyDataSet;
              FdMemPesqGeral.Close;
              FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
              AssignFile(ArquivoCSV, EdtFilename.Text);
              ReWrite(ArquivoCSV);
              while Not FdMemPesqGeral.Eof do Begin
                WriteLn(ArquivoCSV, FdMemPesqGeral.FieldByName('CodBarras').AsString+';'+
                                    FdMemPesqGeral.FieldByName('CodProduto').AsString+';'+
                                    FdMemPesqGeral.FieldByName('Descricao').AsString  );
                FdMemPesqGeral.Next;
              End;

              CloseFile(ArquivoCSV);
              ShowOk('Arquivo '+EdtFilename.Text+' criado com sucesso!');
           End;
           ObjProdutoCtrl.Free;
        End
        Else if ChkEndereco.Checked then Begin
           ObjEnderecoCtrl := TEnderecoCtrl.Create;
           JsonArrayRetorno := ObjEnderecoCtrl.ExportFile('Endereco, (Case When PickingFixo = 1 then '+#39+'S'+#39+' Else '+#39+'N'+#39+' End) PickingFixo');
           if JsonArrayRetorno.items[0].TryGetValue('Erro', vErro) then
              ShowErro(vErro)
           Else Begin
              If FdMemPesqGeral.Active then
                 FdmemPesqGeral.EmptyDataSet;
              FdMemPesqGeral.Close;
              FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
              AssignFile(ArquivoCSV, EdtFilename.Text);
              ReWrite(ArquivoCSV);
              while Not FdMemPesqGeral.Eof do Begin
                WriteLn(ArquivoCSV, FdMemPesqGeral.FieldByName('Endereco').AsString+';'+
                                    FdMemPesqGeral.FieldByName('PickingFixo').AsString );
                FdMemPesqGeral.Next;
              End;

              CloseFile(ArquivoCSV);
              ShowOk('Arquivo '+EdtFilename.Text+' criado com sucesso!');
           End;
           ObjEnderecoCtrl.Free;
        End;
      End);
  Except ON E: Exception do
     ShowErro('Erro na geração do arquivo. '+E.Message);
  End;
end;

procedure TFrmInventario.SelecionarEnderecoPorListaZona;
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
    xZona, xEndereco : Integer;
    vListaZona       : String;
    vComplemento     : String;
    vEnderecoInicial, vEnderecoFinal : String;
begin
  vListaZona   := '';
  vComplemento := '';
  for xZona := 1 to Pred(LstZona.RowCount) do Begin
    if LstZona.Cells[4, xZona] = '1' then Begin
       vListaZona   := vListaZona + vComplemento + LstZona.Cells[0, xZona];
       vComplemento := ', ';
    End;
  End;
  if (EdtEnderecoInicial.Text  = '') and  (EdtEnderecoFinal.Text  = '') and (vListaZona='') then Begin
     LstEnderecoDisponivel.ClearRect(0, 1, LstEnderecoDisponivel.ColCount-1, LstEnderecoDisponivel.RowCount-1);
     LstEnderecoDisponivel.RowCount := 1;
     Exit;
  End;
  ObjEnderecoCtrl := TEnderecoCtrl.Create();
  vEnderecoinicial := EdtEnderecoInicial.Text;
  if (vEnderecoInicial <> '') and (EdtEnderecoFinal.Text='') then
     vEnderecoFinal := vEnderecoInicial
  Else vEnderecoFinal := EdtEnderecoFinal.Text;
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoPorListaZonaJson(0, StrToIntDef(EdtEstruturaId.Text, 0),
                      0, vEnderecoInicial, vEnderecoFinal, 'T', 1, vListaZona, 1);
  LstEnderecoDisponivel.ClearRect(0, 1, LstEnderecoDisponivel.ColCount-1, LstEnderecoDisponivel.RowCount-1);
  LstEnderecoDisponivel.RowCount := 1;
  LblEnderecoDisponivel.Caption := 'Endereço Disponível(0)';
  LblEnderecoSelecao.Caption    := 'Endereço(s) Selecionado para Contagem(0)';
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtEnderecoInicial.SetFocus;
     JsonArrayRetorno := Nil;
     ObjEnderecoCtrl.DisposeOf;
     raise Exception.Create('Faixa de Endereço não encontrado!');
  End;
  If FdMemEnderecoDisponivel.Active then
     FdmemEnderecoDisponivel.EmptyDataSet;
  FdMemEnderecoDisponivel.Close;
  FdMemEnderecoDisponivel.Open;
  for xEndereco := 0 to Pred(JsonArrayRetorno.Count) do Begin
    if (Not FdMemEnderecoSelecao.Locate('EnderecoId', JsonArrayRetorno.Items[xEndereco].GetValue<Integer>('enderecoid'), [])) then Begin
       if JsonArrayRetorno.Items[xEndereco].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid') > 3 then Begin
          FdMemEnderecoDisponivel.Append;
          FdMemEnderecoDisponivel.FieldByName('EnderecoId').AsInteger := JsonArrayRetorno.Items[xEndereco].GetValue<Integer>('enderecoid');
          FdmemEnderecoDisponivel.FieldByName('Descricao').AsString   := JsonArrayRetorno.Items[xEndereco].GetValue<String>('descricao');
          FdmemEnderecoDisponivel.FieldByName('Estrutura').AsString   := JsonArrayRetorno.Items[xEndereco].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
          FdMemEnderecoDisponivel.FieldByName('Mascara').AsString     := JsonArrayRetorno.Items[xEndereco].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara');
          FdMemEnderecoDisponivel.FieldByName('ZonaId').AsInteger     := JsonArrayRetorno.Items[xEndereco].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid');
          FdMemEnderecoDisponivel.FieldByName('Zona').AsString        := JsonArrayRetorno.Items[xEndereco].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
          FdMemEnderecoDisponivel.FieldByName('ReservadoInventario').AsInteger := JsonArrayRetorno.Items[xEndereco].GetValue<Integer>('reservadoinventario');
          FdMemEnderecoDisponivel.Post;
       End;
    End;
  End;
  MontaListaEnderecoDisponivel;
  JsonArrayRetorno := Nil;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmInventario.SelecionarProdutoPorListaZona;
Var ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
    xZona, vZonaId, xProduto  : Integer;
begin
  LstProdutoDisponivel.ClearRect(0, 1, LstProdutoDisponivel.ColCount-1, LstProdutoDisponivel.RowCount-1);
  LstProdutoDisponivel.RowCount := 1;
  LblProdutoDisponivel.Caption := 'Produto(s) Disponível(0)';
  for xZona := 1 to Pred(LstZona.RowCount) do Begin
    if LstZona.Cells[4, xZona] = '1' then Begin
       vZonaId := LstZona.Cells[0, xZona].ToInteger();
       ObjProdutoCtrl := TProdutoCtrl.Create();
       JsonArrayRetorno := ObjProdutoCtrl.GetProdutoList(0, 0, 0, vZonaId, '');
       if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
          EdtProdutoInicial.SetFocus;
          FreeAndNil(ObjProdutoCtrl);
          //raise Exception.Create('Erro: '+vErro);
       End
       Else Begin
          For xProduto := 0 to Pred(JsonArrayRetorno.Count) do Begin
            FdMemProdutoDisponivel.Append;
            FdMemProdutoDisponivel.FieldByName('Produtoid').AsInteger := JsonArrayRetorno.Items[xProduto].GetValue<Integer>('produtoid');
            FdMemProdutoDisponivel.FieldByName('CodigoERP').AsInteger := JsonArrayRetorno.Items[xProduto].GetValue<Integer>('codigoerp');
            FdMemProdutoDisponivel.FieldByName('Descricao').AsString  := JsonArrayRetorno.Items[xProduto].GetValue<String>('descricao');
            FdMemProdutoDisponivel.FieldByName('Picking').AsString    := JsonArrayRetorno.Items[xProduto].GetValue<String>('endereco');
            FdMemProdutoDisponivel.FieldByName('Zona').AsString       := JsonArrayRetorno.Items[xProduto].GetValue<String>('zona');
            FdMemProdutoDisponivel.FieldByName('Sngpc').AsInteger     := JsonArrayRetorno.Items[xProduto].GetValue<Integer>('sngpc');
            FdMemProdutoDisponivel.Post;
          End;
       End;
       FreeAndNil(ObjProdutoCtrl);
    End;
  End;
  if FdMemProdutoDisponivel.RecordCount >= 1 then
     MontaListaProdutoDisponivel
  else 
     raise Exception.Create('Erro: Não há endereços disponível na(s) Zona(s) selecionadas.');;
end;

procedure TFrmInventario.ShowDados;
Var ObjProcesso       : TProcessoCtrl;
    JsonArrayProcesso : TJsonArray;
    JsonArrayItens    : TJsonArray;
    vErro             : String;
    xEndereco         : Integer;
begin
  inherited;
  RbInventarioTipo.ItemIndex := ObjInventarioCtrl.ObjInventario.inventariotipo-1;
  CbTipoAjuste.ItemIndex     := ObjInventarioCtrl.ObjInventario.TipoAjuste;
  DefineInventarioTipo;
  if ObjInventarioCtrl.ObjInventario.DataCriacao = 0 then
     EdtDataCriacao.Clear
  Else EdtDataCriacao.Text   := DateToStr(ObjInventarioCtrl.ObjInventario.DataCriacao);
  if ObjInventarioCtrl.ObjInventario.DataLiberacao = 0 Then
     EdtDataLiberacao.Clear
  Else EdtDataLiberacao.Text := DateToStr(ObjInventarioCtrl.ObjInventario.DataLiberacao);
  EdtDtFinalizacao.Text     := DateToStr(ObjInventarioCtrl.ObjInventario.datafechamento);
  LblHoraFechamento.Caption := TimeToStr(ObjInventarioCtrl.ObjInventario.horafechamento);
  LblProcesso.Caption := ObjInventarioCtrl.ObjInventario.ProcessoId.ToString+' ';
  ObjProcesso := TProcessoCtrl.Create;
  JsonArrayProcesso := ObjProcesso.GetProcesso(ObjInventarioCtrl.ObjInventario.ProcessoId.ToString(), 0);
  if Not JsonArrayProcesso.Items[0].TryGetValue('Erro', vErro) then Begin
     LblProcesso.Caption := LblProcesso.Caption + ' '+
                            StringReplace(JsonArrayProcesso.Items[0].GetValue<String>('descricao'), 'Inventario - ', '', [rfReplaceAll]);
     ChkCadastro.Checked := JsonArrayProcesso.Items[0].GetValue<Integer>('status') = 1;
     ShowFinalizacao(ObjInventarioCtrl.ObjInventario.ProcessoId in [143, 153]);
     if ObjInventarioCtrl.ObjInventario.ProcessoId  = 153 then
        LblDtFinalizacao.Caption := 'Dt.Finalizado'
     Else
        LblDtFinalizacao.Caption := 'Dt.Cancelado';
  End;
  //JsonArrayProcesso.Free;
  ObjProcesso.Free;
  EdtMotivo.Text := ObjInventarioCtrl.ObjInventario.Motivo;
  JsonArrayItens := ObjInventarioCtrl.GetInventarioItens(ObjInventarioCtrl.ObjInventario.InventarioId, 0);
  If JsonArrayItens.Items[0].TryGetValue('Erro', vErro) then Begin
      ShowErro('Erro: '+vErro);
      JsonArrayItens.Free;
      Exit;
  end;
  if RbInventarioTipo.ItemIndex = 0 then Begin
     If FdMemEnderecoSelecao.Active then
        FdmemEnderecoSelecao.EmptyDataSet;
     FdMemEnderecoSelecao.Close;
     FdMemEnderecoSelecao.Open;
     for xEndereco := 0 to Pred(JsonArrayItens.Count) do Begin
       FdMemEnderecoSelecao.Append;
       FdMemEnderecoSelecao.FieldByName('Ativo').AsInteger      := 0;
       FdMemEnderecoSelecao.FieldByName('EnderecoId').AsInteger := JsonArrayItens.Items[xEndereco].GetValue<Integer>('enderecoid');
       FdMemEnderecoSelecao.FieldByName('Descricao').AsString   := JsonArrayItens.Items[xEndereco].GetValue<String>('endereco');
       FdMemEnderecoSelecao.FieldByName('Estrutura').AsString   := JsonArrayItens.Items[xEndereco].GetValue<String>('estrutura');
       FdMemEnderecoSelecao.FieldByName('Mascara').AsString     := JsonArrayItens.Items[xEndereco].GetValue<String>('mascara');
       FdMemEnderecoSelecao.FieldByName('Zona').AsString        := JsonArrayItens.Items[xEndereco].GetValue<String>('zona');
       FdMemEnderecoSelecao.Post;
     End;
     LstEnderecoSelecao.RowCount  := 1;
     MontaListaEnderecoSelecao;
  End
  Else If RbInventarioTipo.ItemIndex = 1 then Begin
     If FdMemProdutoDisponivel.Active then
        FdMemProdutoDisponivel.EmptyDataSet;
     FdMemProdutoDisponivel.Close;
     FdMemProdutoDisponivel.Open;
     for xEndereco := 0 to Pred(JsonArrayItens.Count) do Begin
       FdMemProdutoDisponivel.Append;
//       FdMemProdutoDisponivel.FieldByName('Ativo').AsInteger      := 0;
       FdMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger := JsonArrayItens.Items[xEndereco].GetValue<Integer>('produtoid');
       FdMemProdutoDisponivel.FieldByName('CodigoERP').AsInteger := JsonArrayItens.Items[xEndereco].GetValue<Integer>('codigoerp');
       FdMemProdutoDisponivel.FieldByName('Descricao').AsString  := JsonArrayItens.Items[xEndereco].GetValue<String>('produto');
       FdMemProdutoDisponivel.FieldByName('picking').AsString    := JsonArrayItens.Items[xEndereco].GetValue<String>('picking');
       FdMemProdutoDisponivel.FieldByName('Mascara').AsString    := JsonArrayItens.Items[xEndereco].GetValue<String>('mascara');
       FdMemProdutoDisponivel.FieldByName('Zona').AsString       := JsonArrayItens.Items[xEndereco].GetValue<String>('zona');
       FdMemProdutoDisponivel.FieldByName('Sngpc').Asinteger     := JsonArrayItens.Items[xEndereco].GetValue<Integer>('sngpc');
       FdMemProdutoDisponivel.Post;
     End;
     LstProdutoDisponivel.RowCount := 1;
     MontaListaProdutoDisponivel(True);
  End;
  TabContagem.TabVisible := True;
  TabApuracao.TabVisible := True;
  LstEnderecoContagem.RowCount := 1;
  if TabContagem.TabVisible then Begin
     if InventarioTipo = poGeografico then
        GetInventarioEndereco
     Else If (InventarioTipo = poPrioritario) then
        GetInventarioProduto;
  End;
  LblInventarioId_Apuracao.Caption := EdtInventarioId.Text;
  LblInventarioId_Contagem.Caption := EdtInventarioId.Text;
  LblProcesso_Apuracao.Caption     := LblProcesso.Caption;
  EdtDtInventario_Apuracao.Text    := EdtDataCriacao.Text;
  LstApuracao.RowCount := 1;
  GetApuracao;
end;

procedure TFrmInventario.ShowFinalizacao(OnOff: Boolean);
begin
  LblDtFinalizacao.Visible  := OnOff;
  EdtDtFinalizacao.Visible  := OnOff;
  LblHoraFechamento.Visible := OnOff;
end;

procedure TFrmInventario.ShowInventarioModelo;
begin
  //EdtModeloPreDefinido.Text := FDMemInventarioModelo.FieldByName('ModeloId').AsString;
  EdtEstruturaIdPreDefinido.Text       := FDMemInventarioModelo.FieldByName('EstruturaId').AsString;
  EdtEstruturaIdExit(EdtEstruturaIdPreDefinido);
  EdtEnderecoInicialPreDefinido.Text := FDMemInventarioModelo.FieldByName('EnderecoInicial').AsString;
  EdtEnderecoFinalPreDefinido.Text   := FDMemInventarioModelo.FieldByName('EnderecoFinal').AsString;
  EdtRuaInicialModelo.Text           := FDMemInventarioModelo.FieldByName('RuaInicial').AsString;
  EdtRuaFinalModelo.Text             := FDMemInventarioModelo.FieldByName('RuaFinal').AsString;
  ChkRuaParModelo.Checked            := FDMemInventarioModelo.FieldByName('RuaPar').AsInteger = 1;
  ChkRuaImparModelo.Checked          := FDMemInventarioModelo.FieldByName('RuaImpar').AsInteger = 1;
  EdtPredioInicialModelo.Text        := FDMemInventarioModelo.FieldByName('PredioInicial').AsString;
  EdtPredioFinalModelo.Text          := FDMemInventarioModelo.FieldByName('PredioFinal').AsString;
  ChkPredioParModelo.Checked         := FDMemInventarioModelo.FieldByName('PredioPar').AsInteger = 1;
  ChkPredioImparModelo.Checked       := FDMemInventarioModelo.FieldByName('PredioImpar').AsInteger = 1;
  EdtNivelInicialModelo.Text         := FDMemInventarioModelo.FieldByName('NivelInicial').AsString;
  EdtNivelFinalModelo.Text           := FDMemInventarioModelo.FieldByName('NivelFinal').AsString;
  ChkNivelParModelo.Checked          := FDMemInventarioModelo.FieldByName('NivelPar').AsInteger = 1;
  ChkNivelImparModelo.Checked        := FDMemInventarioModelo.FieldByName('NivelImpar').AsInteger = 1;
  EdtAptoInicialModelo.Text          := FDMemInventarioModelo.FieldByName('AptoInicial').AsString;
  EdtAptoFinalModelo.Text            := FDMemInventarioModelo.FieldByName('AptoFinal').AsString;
  ChkAptoParModelo.Checked           := FDMemInventarioModelo.FieldByName('AptoPar').AsInteger = 1;
  ChkAptoImparModelo.Checked         := FDMemInventarioModelo.FieldByName('AptoImpar').AsInteger = 1;
  EnabledButtons := True;
end;

function TFrmInventario.ShowInventarioModeloLista(pModeloId, pShowErro : Integer): TJsonArray;
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
    xLin  : Integer;
begin
  LstModeloPredefinido.RowCount := 1;
  JsonArrayRetorno := ObjInventarioCtrl.GetModeloLista(pModeloId);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     If pShowErro = 1 then ShowErro(vErro);
  End
  Else if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then Begin
     If pShowErro = 1 then ShowMSG(vErro);
  End
  Else Begin
     If FdMemInventarioModelo.Active then
        FdMemInventarioModelo.EmptyDataSet;
     FdMemInventarioModelo.Close;
     FdMemInventarioModelo.LoadFromJSON(JsonArrayRetorno, False);
     LstModeloPredefinido.RowCount := FDMemInventarioModelo.RecordCount+1;
     FDMemInventarioModelo.First;
     for xLin := 1 to FDMemInventarioModelo.RecordCount do Begin
       LstModeloPredefinido.AddDataImage( 0, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage( 7, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage( 8, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage(11, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage(12, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage(15, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage(16, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage(19, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstModeloPredefinido.AddDataImage(20, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
     End;
     xLin := 1;
     while Not FDMemInventarioModelo.Eof do Begin
       LstModeloPredefinido.Cells[ 0, xLin] := '0';
       LstModeloPredefinido.Cells[ 1, xLin] := FDMemInventarioModelo.FieldByName('ModeloId').AsString;
       if FDMemInventarioModelo.FieldByName('EstruturaId').AsString = '1' then
          LstModeloPredefinido.Cells[ 2, xLin] := 'Pulmão/Pallet'
       Else if FDMemInventarioModelo.FieldByName('EstruturaId').AsString = '2' then
          LstModeloPredefinido.Cells[ 2, xLin] := 'Picking'
       else
          LstModeloPredefinido.Cells[ 2, xLin] := FDMemInventarioModelo.FieldByName('EstruturaId').AsString;
       LstModeloPredefinido.Cells[ 3, xLin] := FDMemInventarioModelo.FieldByName('EnderecoInicial').AsString;
       LstModeloPredefinido.Cells[ 4, xLin] := FDMemInventarioModelo.FieldByName('EnderecoFinal').AsString;
       LstModeloPredefinido.Cells[ 5, xLin] := FDMemInventarioModelo.FieldByName('RuaInicial').AsString;
       LstModeloPredefinido.Cells[ 6, xLin] := FDMemInventarioModelo.FieldByName('RuaFinal').AsString;
       LstModeloPredefinido.Cells[ 7, xLin] := FDMemInventarioModelo.FieldByName('RuaPar').AsString;
       LstModeloPredefinido.Cells[ 8, xLin] := FDMemInventarioModelo.FieldByName('RuaImpar').AsString;
       LstModeloPredefinido.Cells[ 9, xLin] := FDMemInventarioModelo.FieldByName('PredioInicial').AsString;
       LstModeloPredefinido.Cells[10, xLin] := FDMemInventarioModelo.FieldByName('PredioFinal').AsString;
       LstModeloPredefinido.Cells[11, xLin] := FDMemInventarioModelo.FieldByName('PredioPar').AsString;
       LstModeloPredefinido.Cells[12, xLin] := FDMemInventarioModelo.FieldByName('PredioImpar').AsString;
       LstModeloPredefinido.Cells[13, xLin] := FDMemInventarioModelo.FieldByName('NivelInicial').AsString;
       LstModeloPredefinido.Cells[14, xLin] := FDMemInventarioModelo.FieldByName('NivelFinal').AsString;
       LstModeloPredefinido.Cells[15, xLin] := FDMemInventarioModelo.FieldByName('NivelPar').AsString;
       LstModeloPredefinido.Cells[16, xLin] := FDMemInventarioModelo.FieldByName('NivelImpar').AsString;
       LstModeloPredefinido.Cells[17, xLin] := FDMemInventarioModelo.FieldByName('AptoInicial').AsString;
       LstModeloPredefinido.Cells[18, xLin] := FDMemInventarioModelo.FieldByName('AptoFinal').AsString;
       LstModeloPredefinido.Cells[19, xLin] := FDMemInventarioModelo.FieldByName('AptoPar').AsString;
       LstModeloPredefinido.Cells[20, xLin] := FDMemInventarioModelo.FieldByName('AptoImpar').AsString;
       LstModeloPredefinido.Cells[21, xLin] := DateEUAtoBr(FDMemInventarioModelo.FieldByName('DtCriacao').AsString);
       if FDMemInventarioModelo.FieldByName('DtAlteracao').AsString <> '' then
          LstModeloPredefinido.Cells[22, xLin] := DateEUAtoBr(FDMemInventarioModelo.FieldByName('DtAlteracao').AsString)
       Else
          LstModeloPredefinido.Cells[22, xLin] := '';
       LstModeloPredefinido.Alignments[0 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[1 ,xLin] := taRightJustify;
       LstModeloPredefinido.FontStyles[1 ,xLin] := [FsBold];
       LstModeloPredefinido.Alignments[2 ,xLin] := taLeftJustify;
       LstModeloPredefinido.Alignments[3 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[4 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[5 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[6 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[7 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[8 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[9 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[10 ,xLin] := taCenter;
       LstModeloPredefinido.Alignments[11,xLin] := taCenter;
       LstModeloPredefinido.Alignments[12,xLin] := taCenter;
       LstModeloPredefinido.Alignments[13,xLin] := taCenter;
       LstModeloPredefinido.Alignments[14,xLin] := taCenter;
       LstModeloPredefinido.Alignments[15,xLin] := taCenter;
       LstModeloPredefinido.Alignments[16,xLin] := taCenter;
       LstModeloPredefinido.Alignments[17,xLin] := taCenter;
       LstModeloPredefinido.Alignments[18,xLin] := taCenter;
       LstModeloPredefinido.Alignments[19,xLin] := taCenter;
       LstModeloPredefinido.Alignments[20,xLin] := taCenter;
       LstModeloPredefinido.Alignments[21,xLin] := taCenter;
       LstModeloPredefinido.Alignments[22,xLin] := taCenter;
       FDMemInventarioModelo.Next;
       Inc(xLin);
     End;
  End;
  JsonArrayRetorno := Nil;
  BtnGerarInventarioModeloPreDefinido.Visible := LstModeloPredefinido.RowCount > 1;
end;

procedure TFrmInventario.ShowLoteContado;
Var vStatusContagem : String;
begin
  CbEnderecoStatus.ItemIndex := -1;
  if InventarioTipo = poGeografico then Begin
     LblEnderecoContagem.caption := 'Endereço';
     LblProdutoContagem.Visible  := False;
     LblLote.Visible := True;
     EdtLote.Visible := True;
     EdtEnderecoContagem.Text  := FdMemLoteInventariado.FieldByName('Endereco').AsString;
     EdtEnderecoContagem.Width := 115;
     vStatusContagem  := FdMemEndereco.FieldByName('Status').AsString;
      LstDetalheAjuste.UnHideColumn(2);
  End
  Else Begin
     LblEnderecoContagem.caption := 'Código';
     LblProdutoContagem.Visible  := True;
     LblLote.Visible := False;
     EdtLote.Visible := False;
     EdtEnderecoContagem.Text   := FDMemProdutoDisponivel.FieldByName('CodigoERP').AsString;
     LblProdutoContagem.Caption := FDMemProdutoDisponivel.FieldByName('Descricao').AsString;
     EdtEnderecoContagem.Width := 70;
     vStatusContagem := FDMemProdutoDisponivel.FieldByName('Status').AsString;
     LstDetalheAjuste.HideColumn(2);
  End;
  if vStatusContagem = 'I' then CbEnderecoStatus.ItemIndex := 0
  Else if vStatusContagem = 'C' then CbEnderecoStatus.ItemIndex := 1
  Else if vStatusContagem = 'F' then CbEnderecoStatus.ItemIndex := 2;
  EdtEstoqueInicial.Text := FdMemLoteInventariado.FieldByName('EstoqueInicial').AsString;
  EdtLote.Text           := FdMemLoteInventariado.FieldByName('DescrLote').AsString;
  EdtContagem.Text       := FdMemLoteInventariado.FieldByName('QtdContagem').AsString;
  EdtAjuste.Text         := (FdMemLoteInventariado.FieldByName('QtdContagem').Asinteger-FdMemLoteInventariado.FieldByName('EstoqueInicial').Asinteger).ToString();
  EdtSaldo.Text          := FdMemLoteInventariado.FieldByName('QtdContagem').AsString;
end;

procedure TFrmInventario.TabContagemShow(Sender: TObject);
begin
  inherited;
  EdtPesqEndereco.ReadOnly := False;
end;

procedure TFrmInventario.TabimportacaoCSVShow(Sender: TObject);
begin
  inherited;
  EdtFileIimport.Clear;
  ChkCabecalho.Checked       := False;
  RgTipoImportacao.ItemIndex := 0;
  LblRegistro.Caption        := '0';
  LblEstoqueImport.Caption   := '0';
end;

procedure TFrmInventario.TabModeloPreDefinidoShow(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
begin
  inherited;
  EdtModeloPreDefinido.SetFocus;
  LstEnderecoModeloPreDefinido.ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.ColWidths[1] :=  90+Trunc(90*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.ColWidths[2] :=  50+Trunc(50*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.ColWidths[3] := 180+Trunc(180*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.ColWidths[4] :=  60+Trunc(60*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.ColWidths[5] :=  60+Trunc(60*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.ColWidths[6] :=  60+Trunc(60*ResponsivoVideo);;
  LstEnderecoModeloPreDefinido.Alignments[0 ,0] := taRightJustify;
  LstEnderecoModeloPreDefinido.FontStyles[0, 0] := [FsBold];
  LstEnderecoModeloPreDefinido.Alignments[5 ,0] := taCenter;
  LstEnderecoModeloPreDefinido.Alignments[6 ,0] := taCenter;
  ShowInventarioModeloLista(0, 0);
end;

procedure TFrmInventario.validarFiltroModeloPreDefinido(Sender : TObject);
begin
  if StrToIntDef(TEdit(Sender).Text, 0) < 0 then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Conteúdo digitado inválido!');
  End
  Else If (StrToIntDef(EdtRuaInicialModelo.Text, 0)>0) and (StrToIntDef(EdtRuaFinalModelo.Text, 0)>0) and
          (StrToIntDef(EdtRuaInicialModelo.Text, 0) > StrToIntDef(EdtRuaFinalModelo.Text, 0)) then Begin
     EdtRuaInicialModelo.SetFocus;
     ShowErro('Rua Inicial inválido. Corrija!');
  End
  Else If (StrToIntDef(EdtPredioInicialModelo.Text, 0)>0) and (StrToIntDef(EdtPredioFinalModelo.Text, 0)>0) and
          (StrToIntDef(EdtPredioInicialModelo.Text, 0) > StrToIntDef(EdtPredioFinalModelo.Text, 0)) then Begin
     EdtPredioInicialModelo.SetFocus;
     ShowErro('Prédio Inicial inválido. Corrija!');
  End
  Else If (StrToIntDef(EdtNivelInicialModelo.Text, 0)>0) and (StrToIntDef(EdtNivelFinalModelo.Text, 0)>0) and
          (StrToIntDef(EdtNivelInicialModelo.Text, 0) > StrToIntDef(EdtNivelFinalModelo.Text, 0)) then Begin
     EdtNivelInicialModelo.SetFocus;
     ShowErro('Prédio Inicial inválido. Corrija!');
  End
  Else If (StrToIntDef(EdtAptoInicialModelo.Text, 0)>0) and (StrToIntDef(EdtAptoFinalModelo.Text, 0)>0) and
          (StrToIntDef(EdtAptoInicialModelo.Text, 0) > StrToIntDef(EdtAptoFinalModelo.Text, 0)) then Begin
     EdtAptoInicialModelo.SetFocus;
     ShowErro('Prédio Inicial inválido. Corrija!');
  End
end;

end.
