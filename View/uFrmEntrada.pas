unit uFrmEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, JvSpin, Math,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, acImage, acPNG, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Buttons,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvToolEdit, System.Json, Generics.Collections, ImagePicker
  , OperacaoTipoClass, OperacaoTipoCtrl, DataSet.Serialize, dxSkinsCore,
  dxSkinsDefaultPainters, JvBaseEdits, ACBrETQ, ACBrBase, ACBrBAL, ACBrDevice, ACBrETQClass,
  dxCameraControl, Vcl.ComCtrls, Vcl.DBGrids, IniFiles
  , EntradaCtrl
  , EntradaItensCtrl
  , pessoaCtrl
  , ProdutoClass, ProdutoCtrl
  , LotesClass, LoteCtrl
  , UsuarioCtrl
  , EnderecoCtrl, FireDAC.Stan.Async, FireDAC.DApt, uFrmAutorizarOperacao,
  RastroCtrl;

type
  TStatusEntrada = (StRecebido, StCheckIn, StFinalizacao, StConcluido);
  TAutorizarAltLote = (poNenhuma, poTodos, poZona, poProduto);
  TSolicitarAutorizacao = (poNenhum, poAlteraLote, poShelfLife, poDivergencia);

  TFrmEntrada = class(TFrmBase)
    GroupBox2: TGroupBox;
    Shape10: TShape;
    Shape9: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    LblResItens: TLabel;
    LblResSKU: TLabel;
    LblResCheckIn: TLabel;
    LblResEstado: TLabel;
    LblResPlanCega: TLabel;
    LblResInicioCheckIn: TLabel;
    LblResRecebido: TLabel;
    Shape11: TShape;
    Label12: TLabel;
    LblResIntegracaoERP: TLabel;
    Label11           : TLabel;
    LblResEncCheckIn  : TLabel;
    PnlItensEntrada: TPanel;
    AdvSGItensEntrada : TAdvStringGrid;
    PnlCheckIn        : TPanel;
    EdtProdutoCheckIn : TLabeledEdit;
    BitBtn3           : TBitBtn;
    LblProdCheckIn    : TLabel;
    BtnVoltar: TsImage;
    LblTituloCheckIn  : TLabel;
    ChkSNGPCCheckIn   : TCheckBox;
    EdtPickingCheckIn : TLabeledEdit;
    BitBtn4: TBitBtn;
    GbItemCubagem: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EdtPesoCheckIn: TJvCalcEdit;
    EdtAlturaCheckIn: TJvCalcEdit;
    EdtLarguraCheckIn: TJvCalcEdit;
    EdtComprimentoCheckIn: TJvCalcEdit;
    EdtVolumeCheckIn: TJvCalcEdit;
    GbItemLote: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    EdtDtFabricacao: TJvDateEdit;
    EdtDtVencimento: TJvDateEdit;
    EdtLoteCheckIn: TEdit;
    GbItemEmbPrimaria: TGroupBox;
    LblUnidPrimCheckIn: TLabel;
    Label22: TLabel;
    EdtQtdUnidPrimCheckIn: TJvCalcEdit;
    GbItemEmbSecundaria: TGroupBox;
    LblUnidSecCheckIn: TLabel;
    Label23: TLabel;
    EdtQtdUnidSecCheckIn: TJvCalcEdit;
    GbItemTotalEntrada: TGroupBox;
    LblQtdTotCheckIn: TLabel;
    Label21: TLabel;
    EdtQtdTotCheckIn: TJvCalcEdit;
    ImgSaveCheckIn: TsImage;
    LblSaveCheckIn: TLabel;
    ImgCancelCheckIn: TsImage;
    LblCancelCheckIn: TLabel;
    PnlHeaderEntrada: TPanel;
    EdtEntradaId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    CbOperacaoTipo: TComboBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EdtDocumentoNr: TLabeledEdit;
    EdtDocumentoData: TJvDateEdit;
    Panel1: TPanel;
    EdtPessoaId: TLabeledEdit;
    BitBtn2: TBitBtn;
    LblFornecedor: TLabel;
    Label13: TLabel;
    LblProcesso: TLabel;
    GroupBox3: TGroupBox;
    LblUnidade: TLabel;
    EdtUnidadeId: TLabeledEdit;
    BitBtn1: TBitBtn;
    EdtQtdUnid: TLabeledEdit;
    GroupBox4: TGroupBox;
    LblUnidadeSecundaria: TLabel;
    EdtUnidadeSecundariaId: TLabeledEdit;
    BitBtn5: TBitBtn;
    EdtFatorConversao: TLabeledEdit;
    PnlReport: TPanel;
    EdtRegistroERP: TLabeledEdit;
    PnlAutorizarAltLote: TPanel;
    Panel3: TPanel;
    Label24: TLabel;
    BtnClosePnlAutorizar: TBitBtn;
    edtSenhaAutAltLote: TLabeledEdit;
    EdtUsuarioIdAutAltLote: TLabeledEdit;
    LblUsuario: TLabel;
    SpeedButton1: TSpeedButton;
    BtnAutorizarAltLote: TPanel;
    BtnLogin: TShape;
    LblLogin: TLabel;
    PnlDevolucaoSegregado: TPanel;
    Panel4: TPanel;
    Label25: TLabel;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    LblProdutoDevSeg: TLabel;
    Label27: TLabel;
    EdtFabricacaoDevSeg: TJvDateEdit;
    Label28: TLabel;
    EdtVencimentoDevSeg: TJvDateEdit;
    Label29: TLabel;
    CbLotesDevSeg: TComboBox;
    GbDevolucaoSegregado: TGroupBox;
    RbDevolucao: TRadioButton;
    RbSegregado: TRadioButton;
    EdtProdutoIdDevSeg: TLabeledEdit;
    Label30: TLabel;
    EdtQtdeDevSeg: TJvCalcEdit;
    BtnSalvarDevolucaoSegregado: TsImage;
    Label31: TLabel;
    CbMotivo: TComboBox;
    Label26: TLabel;
    BtnGroupNota: TsImage;
    TabGroupNota: TcxTabSheet;
    PnlGroupNotaLeft: TPanel;
    PnlTitGroupSelection: TPanel;
    PnlAgrupamento: TPanel;
    BtnCapturarPeso: TBitBtn;
    ACBrBAL1: TACBrBAL;
    Label5: TLabel;
    PnlBtnCheckIn: TPanel;
    BtnCancelarPreEntrada: TPanel;
    ShpBtnExcluirPedido: TShape;
    SpbBtnExcluirPedido: TSpeedButton;
    PnlBtnCancelarPreEntrada: TPanel;
    ImgBtnExcluirPedido: TImage;
    BtnStartCheckIn: TPanel;
    ShpBtnIniciarCheckIn: TShape;
    SpbBtnIniciarCheckIn: TSpeedButton;
    PnlBtnIniciarCheckIn: TPanel;
    ImgBtnIniciarCheckIn: TImage;
    BtnCancelarCheckIn: TPanel;
    ShpBtnCancelarCheckIn: TShape;
    SpbBtnCancelarCheckIn: TSpeedButton;
    PnlBtnCancelarCheckIn: TPanel;
    ImgBtnCancelarCheckIn: TImage;
    BtnFinalizarCheckIn: TPanel;
    ShpBtnFinalizarCheckIn: TShape;
    SpbBtnFinalizaCheckIn: TSpeedButton;
    PnlBtnFinalizarCheckIn: TPanel;
    ImgBtnFinalizarCheckIn: TImage;
    BtnDivergencia: TPanel;
    ShpBtnDivergencia: TShape;
    SpbBtnDivergencia: TSpeedButton;
    PnlBtnDivergencia: TPanel;
    ImgBtnDivergencia: TImage;
    BtnTagProduto: TPanel;
    ShpBtnTagProduto: TShape;
    SpbBtnTagProduto: TSpeedButton;
    PnlTagProduto: TPanel;
    ImgBtnTagProduto: TImage;
    BtnEspelho: TPanel;
    ShpBtnEspelho: TShape;
    SpbBtnEspelho: TSpeedButton;
    PnlBtnEspelho: TPanel;
    ImgBtnEspelho: TImage;
    TabProdutoSemPicking: TcxTabSheet;
    GroupBox13: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox14: TGroupBox;
    Label53: TLabel;
    Label54: TLabel;
    EdtPedidoId: TEdit;
    EdtDoctoNrPSP: TEdit;
    GroupBox15: TGroupBox;
    EdtCodPessoa: TLabeledEdit;
    BtnPesqFornecedor: TBitBtn;
    LblPessoa: TLabel;
    LblTotRegCaption: TLabel;
    grpEntradas: TGroupBox;
    DbgProdutoSemPicking: TDBGrid;
    LblTotRegSemPicking: TLabel;
    FDMemProdutoSemPicking: TFDMemTable;
    DsProdutoSemPicking: TDataSource;
    LblTitGroup: TLabel;
    EdtCodFornecedorGroup: TLabeledEdit;
    LblFornecedorGroup: TLabel;
    LstNotasGroup: TAdvStringGrid;
    BtnPesqCodFornecedorGroup: TBitBtn;
    PnlBotGroup: TPanel;
    BtnSalvarAgrupamento: TPanel;
    ShpBtnSalvarAgrupamento: TShape;
    SbBtnSalvarAgrupamento: TSpeedButton;
    PnlBtnSalvarAgrupamento: TPanel;
    ImgBtnSalvarAgrupamento: TImage;
    BtnCancelarAgrupamento: TPanel;
    ShpBtnCancelarAgrupamento: TShape;
    SbBtnCancelarAgrupamento: TSpeedButton;
    PnlBtnCancelarAgrupamento: TPanel;
    ImgBtnCancelarAgrupamento: TImage;
    Panel2: TPanel;
    Label32: TLabel;
    LstAgrupamentoLista: TAdvStringGrid;
    LstAgrupamentoNotas: TAdvStringGrid;
    FDMemAgupamentoLista: TFDMemTable;
    FDMemAgrupamentoNotas: TFDMemTable;
    ImgVisualizarQtdxMml: TImage;
    FDMemProdutoSemPickingCodProduto: TIntegerField;
    FDMemProdutoSemPickingDescricao: TStringField;
    FDMemProdutoSemPickingunidadesecundariasigla: TStringField;
    FDMemProdutoSemPickingUnidCxa: TIntegerField;
    FDMemProdutoSemPickingQtdCxa: TIntegerField;
    FDMemProdutoSemPickingVolume: TFloatField;
    FDMemProdutoSemPickingAltura: TFloatField;
    FDMemProdutoSemPickingLargura: TFloatField;
    FDMemProdutoSemPickingComprimento: TFloatField;
    FDMemProdutoSemPickingPesoLiquido: TFloatField;
    FDMemProdutoSemPickingPicking: TStringField;
    GroupBox5: TGroupBox;
    CbRastroTipo: TComboBox;
    FdMemEntrada: TFDMemTable;
    FdMemEntradaPedidoId: TIntegerField;
    FdMemEntradaAgrupamentoId: TIntegerField;
    FdMemEntradaOperacaoTipoId: TIntegerField;
    FdMemEntradaOperacaoTipo: TStringField;
    FdMemEntradaPessoaId: TIntegerField;
    FdMemEntradaCodPessoaERP: TIntegerField;
    FdMemEntradaRazao: TStringField;
    FdMemEntradaFantasia: TStringField;
    FdMemEntradaDocumentoNr: TStringField;
    FdMemEntradaDocumentoData: TDateField;
    FdMemEntradaRegistroERP: TStringField;
    FdMemEntradaDtInclusao: TDateField;
    FdMemEntradaHrInclusao: TTimeField;
    FdMemEntradaArmazemId: TIntegerField;
    FdMemEntradaStatus: TIntegerField;
    FdMemEntradaProcessoId: TIntegerField;
    FdMemEntradaProcesso: TStringField;
    FdMemEntradaQtdXml: TIntegerField;
    FdMemEntradaQtdCheckIn: TIntegerField;
    FdMemEntradaQtdDevolvida: TIntegerField;
    FdMemEntradaQtdSegregada: TIntegerField;
    FdMemEntradaProcessoCheckIn: TIntegerField;
    FDMemEntradaProduto: TFDMemTable;
    IntegerField1: TIntegerField;
    FDMemEntradaProdutoProdutoId: TIntegerField;
    FDMemEntradaProdutoCodProduto: TIntegerField;
    FDMemEntradaProdutoDescricao: TStringField;
    FDMemEntradaProdutoPicking: TStringField;
    FDMemEntradaProdutoMascara: TStringField;
    FDMemEntradaProdutoQtdXml: TIntegerField;
    FDMemEntradaProdutoQtdCheckIn: TIntegerField;
    FDMemEntradaProdutoQtdDevolvida: TIntegerField;
    FDMemEntradaProdutoQtdSegregada: TIntegerField;
    FDMemEntradaProdutoFatorConversao: TIntegerField;
    FDMemEntradaProdutoSNGPC: TIntegerField;
    FDMemEntradaProdutoZonaId: TIntegerField;
    FDMemEntradaProdutoZona: TStringField;
    FDMemEntradaProdutoZonaSNGPC: TIntegerField;
    FDMemEntradaProdutoRastroId: TIntegerField;
    FDMemEntradaProdutounidadesecundariaid: TIntegerField;
    FDMemEntradaProdutounidadesecundariaDescricao: TStringField;
    FDMemEntradaProdutoUnidadeId: TIntegerField;
    FDMemEntradaProdutoUnidade: TStringField;
    FDMemEntradaProdutoPesoLiquido: TFloatField;
    FDMemEntradaProdutoAltura: TFloatField;
    FDMemEntradaProdutoLargura: TFloatField;
    FDMemEntradaProdutoComprimento: TFloatField;
    FDMemEntradaProdutoVolume: TFloatField;
    FDMemEntradaLote: TFDMemTable;
    IntegerField4: TIntegerField;
    FDMemEntradaLoteDescrLote: TStringField;
    FDMemEntradaLoteFabricacao: TDateField;
    FDMemEntradaLoteVencimento: TDateField;
    FDMemEntradaProdutoEnderecoId: TIntegerField;
    FDMemEntradaProdutoProdutoSNGPC: TIntegerField;
    FDMemSegregadoCausa: TFDMemTable;
    FDMemEntradaProdutoMesEntradaMinima: TIntegerField;
    Shape2: TShape;
    LblResFinalizado: TLabel;
    Label34: TLabel;
    FdMemEntradaRecebido: TStringField;
    FdMemEntradaCheckInInicio: TStringField;
    FdMemEntradaCheckInTermino: TStringField;
    FdMemEntradaFinalizado: TStringField;
    FdMemEntradaDevolvidoERP: TStringField;
    CbFormatoEtqArmazenagem: TComboBox;
    LblFormatoEtqArmazenagem: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEntradaIdExit(Sender: TObject);
    procedure EdtPessoaIdChange(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdtProdutoCheckInExit(Sender: TObject);
    procedure EdtProdutoCheckInKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtPesoCheckInKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtProdutoCheckInEnter(Sender: TObject);
    procedure ImgCancelCheckInClick(Sender: TObject);
    procedure ImgCancelCheckInMouseEnter(Sender: TObject);
    procedure ImgCancelCheckInMouseLeave(Sender: TObject);
    procedure ImgSaveCheckInMouseEnter(Sender: TObject);
    procedure ImgSaveCheckInMouseLeave(Sender: TObject);
    procedure EdtAlturaCheckInExit(Sender: TObject);
    procedure EdtDtVencimentoExit(Sender: TObject);
    procedure EdtQtdUnidPrimCheckInExit(Sender: TObject);
    procedure ImgSaveCheckInClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure AdvSGItensEntradaGetEditorProp(Sender: TObject; ACol,
      ARow: Integer; AEditLink: TEditLink);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure AdvSGItensEntradaGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure AdvSGItensEntradaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtLoteCheckInExit(Sender: TObject);
    procedure SpbBtnFinalizaCheckInClick(Sender: TObject);
    procedure CbOperacaoTipoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure EdtQtdUnidSecCheckInKeyPress(Sender: TObject; var Key: Char);
    procedure AdvSGItensEntradaGetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEntradaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEntradaIdEnter(Sender: TObject);
    procedure CbOperacaoTipoExit(Sender: TObject);
    procedure EdtEntradaIdChange(Sender: TObject);
    procedure EdtPickingCheckInExit(Sender: TObject);
    procedure EdtQtdUnidPrimCheckInChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtQtdTotCheckInKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQtdUnidPrimCheckInKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure BtnClosePnlAutorizarClick(Sender: TObject);
    procedure BtnLoginMouseEnter(Sender: TObject);
    procedure BtnLoginMouseLeave(Sender: TObject);
    procedure LblLoginClick(Sender: TObject);
    procedure EdtUsuarioIdAutAltLoteExit(Sender: TObject);
    procedure EdtUsuarioIdAutAltLoteKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn6Click(Sender: TObject);
    procedure BtnSalvarDevolucaoSegregadoClick(Sender: TObject);
    procedure CbLotesDevSegClick(Sender: TObject);
    procedure RbDevolucaoClick(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure SpbBtnExcluirPedidoClick(Sender: TObject);
    procedure SpbBtnIniciarCheckInClick(Sender: TObject);
    procedure SpbBtnCancelarCheckInClick(Sender: TObject);
    procedure SpbBtnDivergenciaClick(Sender: TObject);
    procedure SpbBtnTagProdutoClick(Sender: TObject);
    procedure SpbBtnEspelhoClick(Sender: TObject);
    procedure BtnGroupNotaClick(Sender: TObject);
    procedure BtnPesqFornecedorClick(Sender: TObject);
    procedure EdtCodPessoaExit(Sender: TObject);
    procedure DbgProdutoSemPickingDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtCodPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure TabListagemShow(Sender: TObject);
    procedure EdtDtFabricacaoExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EdtCodFornecedorGroupExit(Sender: TObject);
    procedure EdtCodFornecedorGroupChange(Sender: TObject);
    procedure LstNotasGroupClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure SbBtnCancelarAgrupamentoClick(Sender: TObject);
    procedure SbBtnSalvarAgrupamentoClick(Sender: TObject);
    procedure TabGroupNotaShow(Sender: TObject);
    procedure LblClearFilterClick(Sender: TObject);
    procedure LstAgrupamentoListaClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure LstAgrupamentoNotasClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure ImgVisualizarQtdxMmlClick(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure EdtCodFornecedorGroupKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CbRastroTipoClick(Sender: TObject);
    procedure AdvSGItensEntradaDblClick(Sender: TObject);
    procedure EdtAlturaCheckInChange(Sender: TObject);
    procedure EdtProdutoIdDevSegKeyPress(Sender: TObject; var Key: Char);
    procedure CbRastroTipoExit(Sender: TObject);
    procedure CbRastroTipoEnter(Sender: TObject);
    procedure DbgProdutoSemPickingTitleClick(Column: TColumn);
  private
    { Private declarations }
    //ObjEntradaCtrl        : TEntradaCtrl;
    ObjProdutoCheckIn     : TProduto;
    LstOperacaoTipo       : TObjectList<TOperacaoTipo>;
    ObjUsuarioAltLoteCtrl : TUsuarioCtrl;
    //Dados para CheckIn
    vTotXML, vTotCheckIn, vTotDev, vTotSegr : Integer;
    StatusEntrada        : TStatusEntrada;
    AutorizarAltLote     : TAutorizarAltLote;
    SolicitarAutorizacao : TSolicitarAutorizacao;
    vRespAltLoteId       : Integer;
    vTotalNotaAgrupada   : Integer;
    pAgrupamentoId       : Integer;
    vTimeEtiqueta        : Integer;
    vTemperatura         : Integer;
    Function GetListaEntrada(pPedidoId : Integer = 0; pPessoaId : Integer = 0; pDocumento : String = '';
             pRazao : String = ''; pRegistroERP : String = ''; pDtNotaFiscal : TDateTime = 0;
             pPendente : Integer = 1; pAgrupamentoId : Integer = 0; pCodProduto : String = '0'; pDescrProduto : String = '') : Boolean;
    Function GetProduto(pProdutoId : String) : TProduto;
    Procedure GetListaEntradaItens;
    Procedure PreencherListaItens;
    Procedure AtivarEditCheckIn;
    Procedure ClearEditCheckIn;
    Function SaveItemCheckIn : Boolean;
    function GetCodigoERP(pCodigoERP: String): TProduto;
    Procedure EditCheckInRead;
    Procedure SetStatusEntrada;
    Function SalvarCheckAPI(pLote : String; pFabricacao, pVencimento : TDateTime;
             pQtdCheckIn, pQtdDevolvida, pQtdSegregada, pCausaId : Integer) : Boolean;
    Function CalcularQuantidade : Boolean;
    Function StatusCheckInItem(pIdProduto : Integer) : TColor;
    procedure PreencherListaProduto;
    Function TagProdutoOnOff : Boolean;
    Function VerifyAutoration : Boolean;
    Procedure AtivarPanelAutorizacao;
    Procedure PnlAutorizarAltLoteHide;
    Procedure AtivarPanelDevolucaoSegregado;
    Procedure HidePanelDevolucaoSegregado;
    Procedure OnEditDevSeg;
    Procedure ClearEditDevSeg;
    Procedure ReturnEntradalote;
    Function ExistDevolutionSegregation : Boolean;
    Function ValidarDivergenciaCheckin : Boolean;
    procedure ReturnValidaShelfLife;
    Procedure LimparProdutoSemPicking;
    Procedure PesquisarProdutoSemPicking;
    Function ValidarQuantidade : Boolean;
    Procedure GetNotasFornecedorGroup(pCodFornecedor : Integer);
    Procedure LimparNotasGroup;
    Procedure GetAgrupamentoLista(pAgrupamento, pCodPessoaERP : Integer);
    Procedure MontaListaAgrupamentoNotas;
    Function VerificarSeLoteExiste : Boolean;
    Procedure ReturnFinalizarEntrada;
    Procedure GetProdutoControle;
    Procedure GetSegregadoCausa;
    procedure ThreadAtualizarRastroTerminate(Sender: TObject);
    Procedure SetCampoRastro;
    Procedure OpenEntrada;
    function SaveItemCheckInOLD: Boolean;
    Procedure ValidarUpdateProduto;
    procedure SalvarCheckInItemOLD(xItem, pCausaId: Integer);
    Procedure GetProdutoLoteDevolucao;
    procedure AtualizaRastreabilidade;
    Procedure ConfigACBrETQ;
    Procedure EtqArmazenagem(pCodProduto : Integer);
    procedure PrintTagArmazenagem5x10etqEpl2(pJsonArray: TJsonArray);
    procedure PrintTagArmazenagem8x10etqEpl2(pJsonArray: TJsonArray);
    procedure PrintTagArmazenagem5x10etqPpla(pJsonArray: TJsonArray);
    procedure PrintTagArmazenagem8x10etqPpla(pJsonArray: TJsonArray);
  Protected
    Function DeleteReg : Boolean; OverRide;
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
    Procedure filtraritens(CodProdutoERP : Integer);
  end;

var
  FrmEntrada: TFrmEntrada;

implementation

{$R *.dfm}

uses uFrmeXactWMS, uFuncoes, UFrmConfirmacao, uFrmRelEspelhoEntrada,
  uFrmRelTagProduto, typinfo, ACBrUtil, ACBrDeviceSerial, ProdutoCodBarrasCtrl,
  Vcl.DialogMessage, Views.Pequisa.Pessoas, SegregadoCausaCtrl;

{ TFrmEntrada }

procedure EmptyKeyQueue;
var Msg: TMsg;
begin
while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE or PM_NOYIELD) do;
end;


procedure TFrmEntrada.AdvSGItensEntradaClickCell(Sender: TObject; ARow, ACol: Integer);
Var ObjEntradaItensCtrl : TEntradaItensCtrl;
    xColVisible, xColVisibleXML, xLotes : Integer;
begin
  if Arow = 0 then Begin
     LstCadastroClickCell(Sender, aRow, aCol);
     Exit;
  End;
  if (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Visualizar Quantidade Recebida(XML) - Recebimentos')) then Begin
     xColVisible    := 2;
     xColVisibleXML := 0;
  End
  Else Begin
     xColVisible := 0;
     xColVisibleXML := 0;
  End;

  If (((FdMemEntrada.FieldByName('Status').AsInteger < 2) and (aCol = 9+xColVisible)) or
           ((FdMemEntrada.FieldByName('Status').AsInteger = 2) and (aCol = 9)))and (aRow > 0) and //(FdMemEntrada.FieldByName('Status').AsInteger < 2) and
           (AdvSGItensEntrada.Ints[7-xColVisibleXML, aRow] =
           (AdvSGItensEntrada.Ints[8-xColVisibleXML, aRow]+AdvSGItensEntrada.Ints[9-xColVisibleXML, aRow]+
            AdvSGItensEntrada.Ints[10-xColVisibleXML, aRow])) then Begin
     EtqArmazenagem(AdvSGItensEntrada.Ints[1, aRow]);
     Exit;
  End;

  if (aCol in [7+xColVisible, 8+xColVisible]) and (pAgrupamentoId <> 0) and ((FdMemEntrada.FieldByName('Status').AsInteger < 2)) then Begin
     ShowErro('Operação não permitida. Recebimento pertence ao Agupramento: '+pAgrupamentoId.ToString);
     Exit;
  End;
  inherited;
  if (aCol = 7+xColVisible) and (FdMemEntrada.FieldByName('Status').AsInteger < 2) and ((AdvSGItensEntrada.Cells[8, ARow].ToInteger()+
                                 AdvSGItensEntrada.Cells[9, ARow].ToInteger()+AdvSGItensEntrada.Cells[10, ARow].ToInteger())<>0) and
                                 (Application.MessageBox(pWideChar('Produto: '+AdvSGItensEntrada.Cells[1, ARow]+' - '+
                                 AdvSGItensEntrada.Cells[2, ARow]+'?'), 'Reiniciar CheckIn do Item',
     MB_ICONQUESTION + MB_YESNO) = mrYes) then Begin
     If ObjEntradaItensCtrl.DelCheckIn(FdMemEntrada.FieldByName('PedidoId').AsInteger, AdvSGItensEntrada.Ints[1, ARow]) then
        GetListaEntradaItens;
  End
  Else If (aCol = 8+xColVisible) and (aRow > 0) and (FdMemEntrada.FieldByName('Status').AsInteger < 2) and
          ((AdvSGItensEntrada.Ints[7-xColVisibleXML, aRow] -
           (AdvSGItensEntrada.Ints[8-xColVisibleXML, aRow]+AdvSGItensEntrada.Ints[9-xColVisibleXML, aRow]+AdvSGItensEntrada.Ints[10-xColVisibleXML, aRow]))>0) then Begin
     if FdMemEntradaProduto.Locate('CodProduto', AdvSGItensEntrada.Ints[1, ARow], []) then Begin
        AtivarPanelDevolucaoSegregado;
        GetProdutoLoteDevolucao;
     End
     Else
        ShowErro('Não foi possível pegar os dados do produto!');
     //Buscar os Lotes
  End;
{  Else If (((FdMemEntrada.FieldByName('Status').AsInteger < 2) and (aCol = 9+xColVisible)) or
           ((FdMemEntrada.FieldByName('Status').AsInteger = 2) and (aCol = 9)))and (aRow > 0) and //(FdMemEntrada.FieldByName('Status').AsInteger < 2) and
           (AdvSGItensEntrada.Ints[7-xColVisibleXML, aRow] =
           (AdvSGItensEntrada.Ints[8-xColVisibleXML, aRow]+AdvSGItensEntrada.Ints[9-xColVisibleXML, aRow]+
            AdvSGItensEntrada.Ints[10-xColVisibleXML, aRow])) then Begin
     EtqArmazenagem(AdvSGItensEntrada.Ints[1, aRow]);
  End;
}end;

procedure TFrmEntrada.AdvSGItensEntradaDblClick(Sender: TObject);
begin
  inherited;
  if (BtnStartCheckIn.Visible) and (FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno = 1) then Begin
     If FdMemEntradaProduto.Locate('CodProduto', AdvSGItensEntrada.Ints[1, AdvSGItensEntrada.row], []) then Begin
        SpbBtnIniciarCheckInClick(SpbBtnIniciarCheckIn);
        EdtProdutoCheckIn.Text := AdvSGItensEntrada.Cells[1, AdvSGItensEntrada.row];
        SelectNext(ActiveControl, true, true);
     End;
  End;
end;

procedure TFrmEntrada.AdvSGItensEntradaGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
Var BckColor : TColor;
begin
  inherited;
  EXIT;
  if (AdvSGItensEntrada.Cells[ACol, ARow] <> '') and (ACol > 4) and (ARow>0) then Begin
//     showmessage(AdvSGItensEntrada.Cells[0, ARow]+'   '+AdvSGItensEntrada.Cells[1, ARow]) ;
     BckColor := StatusCheckInItem(AdvSGItensEntrada.Ints[1, ARow]);
     if (BckColor = ClGreen) and (AdvSGItensEntrada.Ints[8, ARow]+AdvSGItensEntrada.Ints[8, ARow]+AdvSGItensEntrada.Ints[10, ARow] = 0) then
       ABrush.Color := ClRed
     Else if (AdvSGItensEntrada.Ints[8, ARow]+AdvSGItensEntrada.Ints[9, ARow]+AdvSGItensEntrada.Ints[10, ARow] = 0) then
       ABrush.Color := clWhite
     Else ABrush.Color := BckColor;
     //AFont.Color := ColorGrid2.ForegroundColor;
  End;
end;

procedure TFrmEntrada.AdvSGItensEntradaGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
Var I : Integer;
begin
//  inherited;
  if not Assigned(AEditLink) then
    Exit;
  If aCol In [12] then begin
     with (aEditLink.GetEditControl as TImagePicker) do begin
       BeginUpdate;
         Items.Clear;
         for i := 0 to 1 do
           Items.Add.ImageIndex := i;
       EndUpdate;
     end;
 end;
end;

procedure TFrmEntrada.AdvSGItensEntradaGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
   if (Not aCol In [1, 2, 3, 4]) then
      AdvSGItensEntrada.EditLink:=el1
   Else
      AdvSGItensEntrada.EditLink:=el6;
   if acol in [12] then aEditor:=edCustom;
end;

procedure TFrmEntrada.AtivarEditCheckIn;
Var OnOff : Boolean;
begin
  EdtProdutoCheckIn.Enabled := Not EdtProdutoCheckIn.Enabled;
  OnOff := EdtProdutoCheckIn.Enabled;
  ChkSNGPCCheckIn.Enabled       := Not OnOff;
  if EdtPickingCheckIn.Text = '' then
     EdtPickingCheckIn.Enabled  := Not OnOff;
  EdtPesoCheckIn.Enabled        := Not OnOff;
  EdtAlturaCheckIn.Enabled      := Not OnOff;
  EdtLarguraCheckIn.Enabled     := Not OnOff;
  EdtComprimentoCheckIn.Enabled := Not OnOff;
  EdtVolumeCheckIn.ReadOnly     := True;
  EdtVolumeCheckIn.Enabled      := Not OnOff;
  EdtLoteCheckIn.Enabled        := Not OnOff;
  EdtDtFabricacao.Enabled       := Not OnOff;
  EdtDtVencimento.Enabled       := Not OnOff;
  EdtQtdUnidPrimCheckIn.Enabled := Not OnOff;
  if (Assigned(ObjProdutoCheckIn)) and (Not OnOff) and
     (FdMemEntradaProduto.Active) and
     (FdMemEntradaProduto.FieldByname('FatorConversao').AsInteger>1) then
     EdtQtdUnidSecCheckIn.Enabled  := Not OnOff
  Else
     EdtQtdUnidSecCheckIn.Enabled      := False;
  EdtQtdTotCheckIn.ReadOnly     := True;
  EdtQtdTotCheckIn.Enabled      := Not OnOff;
  GbItemLote.Enabled            := True;
  ImgCancelCheckIn.Visible      := Not OnOff;
  ImgSaveCheckIn.Visible        := Not OnOff;
  LblCancelCheckIn.Visible      := Not OnOff;
  LblSaveCheckIn.Visible        := Not OnOff;
  ImgSaveCheckIn.Enabled        := True;
  LblSaveCheckIn.Enabled        := True;
  ImgCancelCheckIn.Enabled      := True;
  LblCancelCheckIn.Enabled      := True;
end;

procedure TFrmEntrada.AtivarPanelAutorizacao;
begin
  FrmAutorizarOperacao := TFrmAutorizarOperacao.Create(Application);
  FrmAutorizarOperacao.LblVersao.Caption := 'Versão: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
  if SolicitarAutorizacao = poAlteraLote then Begin
     FrmAutorizarOperacao.LblAutorizarOperacao.Caption := 'Entrada com Novo Lote';
     FrmAutorizarOperacao.Autorizar_Funcionalidade := 'Recebimentos - Alteração Lotes';
     End
  Else If SolicitarAutorizacao = poShelfLife then Begin
     FrmAutorizarOperacao.LblAutorizarOperacao.Caption := 'Produto com Shelf-Life fora de padrão';
     FrmAutorizarOperacao.Autorizar_Funcionalidade := 'Permitir Recebimento fora do Shelf-Life';
     End
  Else if SolicitarAutorizacao = poDivergencia then Begin
     FrmAutorizarOperacao.LblAutorizarOperacao.Caption := 'Entrada com Devolução/Segregado';
     FrmAutorizarOperacao.Autorizar_Funcionalidade := 'Recebimento - Finalizar com Devolução e Segregado';
  End;
  if (FrmAutorizarOperacao.ShowModal = mrOk) then begin
     if SolicitarAutorizacao = poAlteraLote then
        ReturnEntradaLote
     Else If SolicitarAutorizacao = poShelfLife then
        ReturnValidaShelfLife
     Else if SolicitarAutorizacao = poDivergencia then
        ReturnFinalizarEntrada;
  End
  Else Begin
     SpbBtnFinalizaCheckIn.Enabled := True;
     ShowMessage('Acesso não autorizado!');
     if SolicitarAutorizacao = poAlteraLote then EdtLoteCheckIn.SetFocus
     Else if SolicitarAutorizacao = poShelfLife then  EdtDtVencimento.SetFocus;
  End;
  FrmAutorizarOperacao := Nil;
end;

procedure TFrmEntrada.AtivarPanelDevolucaoSegregado;
Var xEsp : Integer;
begin
  PnlDevolucaoSegregado.Left := ((PnlItensEntrada.Width  - PnlDevolucaoSegregado.Width) Div 2);
  PnlDevolucaoSegregado.Top  := ((PnlItensEntrada.Height - PnlDevolucaoSegregado.Height) Div 2);
  PnlDevolucaoSegregado.Visible := True;
  ClearEditCheckIn;
  OnEditDevSeg;

  //exit;

  TThread.CreateAnonymousThread(procedure
  Var xLeft, xPosLeft, xTime : Integer;
  begin
    xLeft    :=  (PnlDevolucaoSegregado.Width*-1);
    xPosLeft := PnlDevolucaoSegregado.Left; //((PnlDevolucaoSegregado.Width - PnlDevolucaoSegregado.Width) Div 2);
    while xLeft <= xPosLeft do Begin
      TThread.Synchronize(nil, procedure
      begin
        PnlDevolucaoSegregado.Left := xLeft;
      End);
      xLeft := xLeft + 10;
    end;
  end).Start;
end;

procedure TFrmEntrada.BtnClosePnlAutorizarClick(Sender: TObject);
begin
  inherited;
  PnlCheckIn.Enabled          := True;
  //EdtLoteCheckIn.SetFocus;
  PnlAutorizarAltLoteHide;
  EdtLoteCheckIn.Clear;
  EdtLoteCheckIn.SetFocus;
  SolicitarAutorizacao  := poNenhum;
end;

procedure TFrmEntrada.BitBtn12Click(Sender: TObject);
Var TimeOut : Integer ;
begin
   try
      TimeOut := StrToInt( '2000' ) ;
   except
      TimeOut := 2000 ;
   end ;
   ACBrBAL1.LePeso( TimeOut );
end;

procedure TFrmEntrada.BitBtn2Click(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtCodFornecedorGroup.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.somenteDisponivelAgrupamento := True;
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtCodFornecedorGroup.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtCodFornecedorGroupExit(EdtCodFornecedorGroup);
    End;
  finally
    Try FreeAndNil(FrmPesquisaPessoas) Except End;
  end;
end;

procedure TFrmEntrada.BitBtn6Click(Sender: TObject);
begin
  inherited;
  PnlDevolucaoSegregado.Enabled          := True;
  ClearEditDevSeg;
  //PreencherListaItens;
  GetListaEntradaItens;
  HidePanelDevolucaoSegregado;
end;

procedure TFrmEntrada.BtnCancelarClick(Sender: TObject);
begin
  if (1=1) or (BtnStartCheckIn.Visible) then
     inherited
  Else begin
    With TFrmConfirmacao.Create(Self) do Try
      Mensag1.Caption := 'Cancelar CheckIn';
      Mensag2.Caption := 'Os Itens já conferidos serão perdidos!';
      ImgOk.Visible   := True;
      If ShowModal = MrOk Then Begin
         PnlCheckIn.Visible      := False;
         ClearEditCheckIn;
         if ImgSaveCheckIn.Visible then
            AtivarEditCheckIn;
         //ativarbotoes;
         PnlBtnCheckIn.Visible   := False;
         BtnStartCheckIn.Visible := False;
         BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible); //and (ObjEntradaCtrl.Entrada.Status <> 3);
      End;
    Finally
      Free;
    end;
  End;
end;

procedure TFrmEntrada.BtnEditarClick(Sender: TObject);
begin
  if FdMemEntrada.FieldByName('Status').AsInteger = 2 then
     raise Exception.Create('CheckIn concluído. Não é permitido alteração.')
  Else if FdMemEntrada.FieldByName('Status').AsInteger = 3 then
     raise Exception.Create('Pedido Cancelado. Não é permitido alteração.');
  inherited;
  PnlBtnCheckIn.Visible      := True;
  BtnStartCheckIn.Visible    := True;
  BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible); //and (ObjEntradaCtrl.Entrada.Status <> 3);
end;

procedure TFrmEntrada.BtnExportarStandClick(Sender: TObject);
begin
//  inherited;
  if PgcBase.ActivePage = TabProdutoSemPicking then Begin
     if (Not FDMemProdutoSemPicking.Active) or (FDMemProdutoSemPicking.IsEmpty) then
         raise Exception.Create('Não há dados para exportar!');
      if (BtnExportarStand.Grayed) or (FDMemProdutoSemPicking.IsEmpty) then Exit;
      Try
        DsProdutoSemPicking.DataSet := nil;
        ExportarExcel(FDMemProdutoSemPicking);
        DsProdutoSemPicking.DataSet := FDMemProdutoSemPicking;
      Except
    //    result := False;
        raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
      End;
  End;
end;

procedure TFrmEntrada.BtnGroupNotaClick(Sender: TObject);
begin
  inherited;
  if Not BtnSalvar.Enabled then begin
     TabGroupNota.TabVisible := True;
     PgcBase.ActivePage      := TabGroupNota
  End;
end;

procedure TFrmEntrada.SpbBtnFinalizaCheckInClick(Sender: TObject);
Var vImpressaoTag : Boolean;
begin
  if pAgrupamentoId <> 0 then Begin
     ShowErro('Operação não permitida. Recebimento pertence ao Agupramento: '+pAgrupamentoId.ToString);
     Exit;
  End;
  inherited;
  BtnFinalizarCheckIn.Enabled := False;
  Try
    vImpressaoTag := True;
    If TagProdutoOnOff Then Begin
       With TFrmConfirmacao.Create(Self) do Try
         Mensag1.Caption := 'Imprimir Etiqueta?';
         Mensag2.Caption := 'Na entrada existe produtos controlados!';
         ImgOk.Visible   := True;
         If ShowModal = MrOk Then Begin
            SpbBtnTagProdutoClick(BtnTagProduto);
            vImpressaoTag := False;
         End
         Else
            vImpressaoTag := True;
       Finally
         Free;
       end;
    End;
  Except On E: Exception do Begin
    BtnFinalizarCheckIn.Enabled := True;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
  if Not vImpressaoTag then Begin
     BtnFinalizarCheckIn.Enabled := True;
     Exit;
  End;
  if (Not ValidarDivergenciaCheckin) and (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Finalizar com Devolução e Segregado')) then Begin
     ShowErro('CheckIn informou quantidade para Segregado/Devolução. Solicite acesso para finalizar.');
     SolicitarAutorizacao := poDivergencia;
     AtivarPanelAutorizacao;
     BtnFinalizarCheckIn.Enabled := True;
     Exit;
  End
  Else
     ReturnFinalizarEntrada;
end;

procedure TFrmEntrada.BtnIncluirClick(Sender: TObject);
begin
  if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadProdutoIncluir = 0) then
     raise Exception.Create('Operação não permitida!');
  inherited;
end;

procedure TFrmEntrada.BtnLoginMouseEnter(Sender: TObject);
begin
  inherited;
  BtnLogin.Pen.Color   := $00ECDECE; //Azul
  BtnLogin.Brush.Color := $004080FF; //Chocolate
  LblLogin.Font.Color  := $00ECDECE;
  LblLogin.Color       := $004080FF;
end;

procedure TFrmEntrada.BtnLoginMouseLeave(Sender: TObject);
begin
  inherited;
  BtnLogin.Pen.Color   := $004080FF; //Azul
  BtnLogin.Brush.Color := $00ECDECE; //Chocolate
  LblLogin.Font.Color  := $004080FF;
  LblLogin.Color       := $00ECDECE;
end;

procedure TFrmEntrada.BtnPesqFornecedorClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtCodPessoa.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtCodPessoa.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtCodPessoaExit(EdtCodPessoa);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmEntrada.BtnPesquisarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabProdutoSemPicking then
     PesquisarProdutoSemPicking
  Else
     inherited;
end;

procedure TFrmEntrada.BtnSalvarClick(Sender: TObject);
begin
  if BtnFinalizarCheckIn.Visible then
     raise Exception.Create('Click no botão '+#34+'Finalizar CheckIn'+#34+'!');
  inherited;
  PnlBtnCheckIn.Visible   := False;
  BtnStartCheckIn.Visible := False;
  BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible) and (FdMemEntrada.FieldByName('Status').AsInteger <> 3);
end;

procedure TFrmEntrada.BtnVoltarClick(Sender: TObject);
begin
  inherited;
  EdtProdutoCheckIn.Clear;
  PnlBtnCheckIn.Visible   := True;
  BtnStartCheckIn.Visible := True;
  if PnlCheckIn.Visible then
     BtnCancelarCheckIn.Visible     := (BtnStartCheckIn.Visible); //and (ObjEntradaCtrl.Entrada.Status <> 3);
  PnlCheckIn.Visible             := False;
  AdvSGItensEntrada.FilterActive := False;
  PnlHeaderEntrada.Enabled       := True;
  ClearEditCheckIn;
  EdtProdutoCheckIn.Enabled      := True;
  AtivarEditCheckIn;
end;

Function TFrmEntrada.CalcularQuantidade : Boolean;
Var vQtdeTotal       : Int64;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  Result := False;
  LblQtdTotCheckIn.Caption := '';
  EdtQtdTotCheckIn.Value := EdtQtdUnidPrimCheckIn.Value +
                            (EdtQtdUnidSecCheckIn.Value*
                             FdMemEntradaProduto.FieldByName('FatorConversao').AsInteger);
  vQtdeTotal := 0;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInItem = 0 then
     vQtdeTotal := Trunc(EdtQtdTotCheckIn.Value)+vTotCheckIn+vTotDev+vTotSegr
  Else
     vQtdeTotal := Trunc(EdtQtdTotCheckIn.Value)+            vTotDev+vTotSegr;
  if FdMemEntradaProduto.FieldByName('QtdXml').AsInteger < vQtdeTotal then Begin
     EdtQtdUnidPrimCheckIn.Clear;
     EdtQtdUnidSecCheckIn.Clear;
     EdtQtdUnidPrimCheckIn.SetFocus;
     ShowErro('CheckIn com erro. Quantidade total do CheckIn maior que quantidade no documento.');
  End
  else Begin
     if EdtQtdUnidSecCheckIn.Value > 0 then
        LblQtdTotCheckIn.Caption := EdtQtdUnidSecCheckIn.Value.ToString()+' '+LblUnidSecCheckIn.Caption+' ';
     if EdtQtdUnidPrimCheckIn.Value > 0 then
        LblQtdTotCheckIn.Caption := LblQtdTotCheckIn.Caption + EdtQtdUnidPrimCheckIn.Value.ToString()+' '+LblUnidPrimCheckIn.Caption;

     Result := ValidarQuantidade; //Certificar que informações no banco não foram alteradas por outro usuário/computador
  End;
end;

procedure TFrmEntrada.CbLotesDevSegClick(Sender: TObject);
Var xProdlotes : Integer;
    vTotCheckIn : Integer;
begin
  inherited;
  //SUBSTITUIR OBJENTRADACTRL
  //14Nov23
  if (Not RbDevolucao.Checked) and (Not RbSegregado.Checked) then Begin
     CbLotesDevSeg.ItemIndex := -1;
     raise Exception.Create('Selecione o tipo de movimentação!');
  End;
  EdtQtdeDevSeg.Tag := 0;
  EdtQtdeDevSeg.Tag := FdMemEntradaProduto.FieldByName('QtdXml').AsInteger-
                       (FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+
                        FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                        FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger);
  If FdMemEntradaLote.Locate('DescrLote', CbLotesDevSeg.Text, []) then Begin
     EdtFabricacaoDevSeg.Text := FdMemEntradaLote.FieldByName('Fabricacao').AsString;
     EdtVencimentoDevSeg.Text := FdMemEntradaLote.FieldByName('Vencimento').AsString;
  End
  Else Begin
     ShowErro('Lote inválido!');
     CbLotesDevSeg.SetFocus;
  End;
{  for xProdLotes := 0 to pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
    if (ObjEntradaCtrl.Entrada.Itens[xProdLotes].ProdutoLotes.Produto.CodProduto = StrToIntDef(EdtProdutoIdDevSeg.Text, 0)) Then Begin
       If (ObjEntradaCtrl.Entrada.Itens[xProdLotes].ProdutoLotes.Lotes.DescrLote = CbLotesDevSeg.Text) then Begin
          EdtFabricacaoDevSeg.Text := DateToStr(ObjEntradaCtrl.Entrada.Itens[xProdLotes].ProdutoLotes.Lotes.Fabricacao);
          EdtVencimentoDevSeg.Text := DateToStr(ObjEntradaCtrl.Entrada.Itens[xProdLotes].ProdutoLotes.Lotes.Vencimento);
       End;
       EdtQtdeDevSeg.Tag        := EdtQtdeDevSeg.Tag + (ObjEntradaCtrl.Entrada.Itens[xProdLotes].QtdXml -
                                  (ObjEntradaCtrl.Entrada.Itens[xProdLotes].QtdCheckIn+
                                   ObjEntradaCtrl.Entrada.Itens[xProdLotes].QtdSegregada+
                                   ObjEntradaCtrl.Entrada.Itens[xProdLotes].QtdDevolvida));
    End;
   End;
}end;

procedure TFrmEntrada.CbOperacaoTipoClick(Sender: TObject);
Var xOpTipo : Integer;
begin
  inherited;
  for xOpTipo := 0 to LstOperacaoTipo.Count-1 do Begin
    if LstOperacaoTipo[xOpTipo].Descricao = CbOperacaoTipo.Text then Begin
       FdMemEntrada.Edit;
       FdMemEntrada.FieldByName('OperacaoTipoId').AsInteger := LstOperacaoTipo[xOpTipo].OperacaoTipoId;
       FdMemEntrada.FieldByName('Operacao').AsString        := LstOperacaoTipo[xOpTipo].Descricao;
       FdMemEntrada.Post;
       Break;
    End;
  End;
end;

procedure TFrmEntrada.CbOperacaoTipoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

Procedure TFrmEntrada.AtualizaRastreabilidade;
Var TH : TThread;
Begin
  TH := TThread.CreateAnonymousThread(procedure
  Var ObjProdutoCtrl : TProdutoCtrl;
      JsonArrayAtualiza  : TJsonArray;
      vErro : String;
  begin
    if (CbRastroTipo.ItemIndex+1 <> ObjProdutoCheckIn.Rastro.RastroId) then Begin
       ObjProdutoCtrl := TProdutoCtrl.Create;
       JsonArrayAtualiza := ObjProdutoCtrl.AtualizarRastreabilidade(ObjProdutoCheckIn.IdProduto,
                      CbRastroTipo.ItemIndex+1);
       if Not JsonArrayAtualiza.Items[0].TryGetValue('Erro', vErro) then Begin
          FdMemEntradaProduto.Edit;
          FdMemEntradaProduto.FieldByName('RastroId').AsInteger := CbRastroTipo.ItemIndex+1;
          FdMemEntradaProduto.Post;
{          TThread.Synchronize(TThread.CurrentThread, procedure
          begin
            SetCampoRastro;
          end);
}       End
       Else
         CbRastroTipo.ItemIndex := FdMemEntradaProduto.FieldByName('RastroId').AsInteger-1;
       JsonArrayAtualiza := Nil;
       ObjProdutoCtrl.Free;
    End;
  end);
  TH.OnTerminate := ThreadAtualizarRastroTerminate;
  TH.Start;
End;

procedure TFrmEntrada.CbRastroTipoClick(Sender: TObject);
Var TH : TThread;
begin
  inherited;
end;

procedure TFrmEntrada.CbRastroTipoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(CbRastroTipo);
end;

procedure TFrmEntrada.CbRastroTipoExit(Sender: TObject);
begin
  inherited;
  SetCampoRastro;
  ExitFocus(CbRastroTipo);
end;

procedure TFrmEntrada.ThreadAtualizarRastroTerminate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then begin
     CbRastroTipo.ItemIndex := ObjProdutoCheckIn.Rastro.RastroId-1;
     CbRastroTipo.SetFocus;
     ShowErro('Não foi possível mudar a rastreabilidade. '+Exception(TThread(sender).FatalException).Message, 'alerta');
     Exit;
  end;
end;

procedure TFrmEntrada.ClearEditCheckIn;
begin
  EdtProdutoCheckIn.ReadOnly  := False;
  LblProdCheckIn.Caption      := '...';
  ChkSNGPCCheckIn.Checked     := False;
  EdtPickingCheckIn.Text      := '';
  EdtPesoCheckIn.Value        := 0;
  EdtAlturaCheckIn.Value      := 0;
  EdtLarguraCheckIn.Value     := 0;
  EdtComprimentoCheckIn.Value := 0;
  EdtVolumeCheckIn.Value      := 0;
  EdtLoteCheckIn.Clear;
  EdtDtFabricacao.Clear;
  EdtDtVencimento.Clear;
  EdtQtdUnidPrimCheckIn.Value := 0;
  EdtQtdUnidSecCheckIn.Value  := 0;
  EdtQtdTotCheckIn.Value      := 0;
  LblUnidPrimCheckIn.Caption  := '';
  LblUnidSecCheckIn.Caption   := '';
  LblQtdTotCheckIn.Caption    := '';
  if Assigned(ObjUsuarioAltLoteCtrl) then
     ObjUsuarioAltLoteCtrl.ObjUsuario.limpar;
end;

procedure TFrmEntrada.ClearEditDevSeg;
begin
  EdtProdutoIdDevSeg.Clear;
  RbDevolucao.Checked := False;
  RbSegregado.Checked := False;
  CbLotesDevSeg.Items.Clear;
  EdtFabricacaoDevSeg.Clear;
  EdtVencimentoDevSeg.Clear;
  CbMotivo.ItemIndex := -1;
  EdtQtdeDevSeg.Clear;
  EdtQtdeDevSeg.Tag := 0;
  if EdtProdutoIdDevSeg.Text = '' then
     EdtProdutoIdDevSeg.SetFocus
  Else
     PnlDevolucaoSegregado.SetFocus;
end;

procedure TFrmEntrada.ConfigACBrETQ;
var vlIni: TIniFile;
begin
  vlIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.ini');
  try
    CbModeloConfigPrinter.ItemIndex   := CbModeloConfigPrinter.Items.IndexOf(vlIni.ReadString('PRINTER', 'EtqCodBarra_Modelo', FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra));
    CbPortaConfigPrinter.ItemIndex    := CbPortaConfigPrinter.Items.IndexOf(vlIni.ReadString('PRINTER',  'EtqCodBarra_Porta' , FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra));
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra := CbModeloConfigPrinter.Text;
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra  := CbPortaConfigPrinter.Text;
  finally
    vlIni.Free;
  end;

  with ACBrETQConfig do
  begin
     Desativar;
     DPI           := TACBrETQDPI(2);
     LimparMemoria := True;
     Temperatura   := vTemperatura;
     Velocidade    := -1;
     BackFeed      := TACBrETQBackFeed(-1);
     Unidade       := etqMilimetros; //etqDecimoDeMilimetros;
     MargemEsquerda:= 0;
     Origem        := TACBrETQOrigem(1); //cbOrigem.ItemIndex);
     PaginaDeCodigo:= TACBrETQPaginaCodigo(2);
     Porta         := CbPortaConfigPrinter.Text;
     Modelo        := TACBrETQModelo(CbModeloConfigPrinter.ItemIndex);
  end;
end;

procedure TFrmEntrada.DbgProdutoSemPickingDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    If (FdMemProdutoSemPicking.RecNo Mod 2 = 0) then   //Query dos itens
       Canvas.Brush.Color := ClWhite // Pedido não finalizado
    Else  Canvas.Brush.Color := $00F5EFE7; //Pedido Finalizado
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TFrmEntrada.DbgProdutoSemPickingTitleClick(Column: TColumn);
begin
  inherited;
  OrdenarMemTable(FDMemProdutoSemPicking, Column.FieldName);
end;

function TFrmEntrada.DeleteReg: Boolean;
Begin
  Inherited;
end;

procedure TFrmEntrada.EditCheckInRead;
begin
  EdtProdutoCheckIn.ReadOnly      := False;
  EdtPickingCheckIn.ReadOnly      := False;
  EdtPesoCheckIn.ReadOnly         := False;
  EdtAlturaCheckIn.ReadOnly       := False;
  EdtLarguraCheckIn.ReadOnly      := False;
  EdtComprimentoCheckIn.ReadOnly  := False;
  EdtVolumeCheckIn.ReadOnly       := False;
  EdtVolumeCheckIn.ReadOnly       := False;
  EdtLoteCheckIn.ReadOnly         := False;
  EdtDtFabricacao.ReadOnly        := False;
  EdtDtVencimento.ReadOnly        := False;
  EdtQtdUnidPrimCheckIn.ReadOnly  := False;
  EdtQtdUnidSecCheckIn.ReadOnly   := False;
  EdtQtdTotCheckIn.ReadOnly       := False;
  EdtQtdTotCheckIn.ReadOnly       := False;
end;

procedure TFrmEntrada.EdtAlturaCheckInChange(Sender: TObject);
begin
  inherited;
  EdtVolumeCheckIn.Value := EdtAlturaCheckIn.value*EdtLarguraCheckIn.Value*EdtComprimentoCheckIn.Value;
end;

procedure TFrmEntrada.EdtAlturaCheckInExit(Sender: TObject);
begin
  if Not (TEdit(Sender).ReadOnly)  then Begin
     if ((Sender=EdtAlturaCheckIn) or (Sender=EdtLarguraCheckIn)) and (StrToFloatDef(TEdit(Sender).Text, 0) > 2000) then Begin
        ShowErro('Medidas fora do padrão(2Mt)');
        TEdit(Sender).SetFocus;
        Exit;
     End
     Else if (Sender=EdtComprimentoCheckIn) and (StrToFloatDef(TEdit(Sender).Text, 0) > 3000) then Begin
        ShowErro('Medidas fora do padrão(3Mt)');
        EdtComprimentoCheckIn.SetFocus;
        Exit;
     End
     Else if (Sender=EdtPesoCheckIn) and (StrToFloatDef(TEdit(Sender).Text, 0) > 50000) then Begin
        ShowErro('Peso fora do padrão(50Kg)');
        EdtComprimentoCheckIn.SetFocus;
        Exit;
     End;
  End;
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtCodFornecedorGroupChange(Sender: TObject);
begin
  inherited;
  LimparNotasGroup;
end;

procedure TFrmEntrada.EdtCodFornecedorGroupExit(Sender: TObject);
Var ObjPessoaCtrl    : TPessoaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  if EdtCodFornecedorGroup.Text = '' then Exit;
  LblFornecedorGroup.Caption := '';
  LstNotasGroup.RowCount := 1;
  if StrToIntDef(EdtCodFornecedorGroup.Text, 0) <= 0 then Begin
     LblFornecedor.Caption := '';
     ShowErro( '😢Fornecedor('+EdtCodFornecedorGroup.Text+') não encontrado!' );
     EdtCodFornecedorGroup.Clear;
     EdtCodFornecedorGroup.SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  JsonArrayRetorno := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtCodFornecedorGroup.text, 0), '', '', 2, 0);
  if (JsonArrayRetorno.Count <= 0) or (JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblFornecedor.Caption := '';
     if JsonArrayRetorno.Count > 0 then
        ShowErro('Erro: '+vErro)
     Else
        ShowErro('😢Fornecedor('+EdtCodFornecedorGroup.Text+') não encontrado!' );
     EdtCodFornecedorGroup.Clear;
     EdtCodFornecedorGroup.SetFocus;
  end
  Else Begin
     LblFornecedorGroup.Caption := (JsonArrayRetorno.Items[0] as TJSONObject).GetValue<String>('razao');
     GetNotasFornecedorGroup(StrToIntDef(EdtCodFornecedorGroup.Text, 0));
     GetAgrupamentoLista(0, StrToIntDef(EdtCodFornecedorGroup.Text, 0));
  End;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtCodFornecedorGroupKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (EdtCodFornecedorGroup.text='') then
     GetAgrupamentoLista(0, 0);
end;

procedure TFrmEntrada.EdtCodPessoaExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtCodPessoa.Text = '' then Begin
     LblPessoa.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodPessoa.Text, 0) <= 0 then Begin
     LblPessoa.Caption := '';
     ShowErro( '😢Fornecedor('+EdtCodPessoa.Text+') não encontrado!' );
     EdtCodPessoa.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtCodPessoa.text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblPessoa.Caption := '';
     ShowErro( '😢Fornecedor('+EdtCodPessoa.Text+') não encontrado!' );
     EdtCodPessoa.Clear;
  end
  Else
     LblPessoa.Caption := ReturnjsonArray.Items[0].GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtCodPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  LblPessoa.Caption := '...';
end;

procedure TFrmEntrada.EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex = 1 then SoNumeros(Key);
end;

procedure TFrmEntrada.EdtDtFabricacaoExit(Sender: TObject);
begin
  inherited;
  if (EdtDtFabricacao.Text='') or (EdtDtFabricacao.Text='  /  /  ') or
     (EdtDtFabricacao.Text='  /  /    ') then
     Exit;
  if Length(TEdit(Sender).Text) = 8 then
     TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
  Try
    if Length(TEdit(Sender).Text) = 8 then
       TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
    StrToDate(EdtDtFabricacao.Text);
    if (StrToDate(TEdit(Sender).Text) < StrToDate('01/01/1990')) or
       (StrToDate(TEdit(Sender).Text) > StrToDate('19/08/2130')) then
       raise Exception.Create('Dt.Fabricação inválida!');
  Except
    EdtDtFabricacao.SetFocus;
    ShowErro('Data de fabricação do lote inválida');
    EdtDtFabricacao.SetFocus;
  End;
  if StrToDate(EdtDtFabricacao.Text) > Date() then Begin
     ShowErro('Data de Fabrição não pode ser maior que hoje.');
     EdtDtFabricacao.SetFocus;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtDtVencimentoExit(Sender: TObject);
begin
  inherited;
  if (EdtDtVencimento.Text='') or (EdtDtVencimento.Text='  /  /  ') or (EdtDtVencimento.Text='  /  /    ') or
     (CbRastroTipo.ItemIndex = 0) then
     Exit;
  Try
    if Length(TEdit(Sender).Text) = 8 then
       TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
    StrToDate(TEdit(Sender).Text);
    if StrToDate(TEdit(Sender).Text) > StrToDate('19/08/2130') then
       raise Exception.Create('Dt.Vencimento inválida!');
  Except
    EdtDtFabricacao.SetFocus;
    ShowErro('Data de Vencimento do lote inválida');
    EdtDtVencimento.SetFocus;
    Exit;
  End;
  if (CbRastroTipo.ItemIndex = 2) and
     ((EdtDtFabricacao.Text='') or (EdtDtFabricacao.Text='  /  /  ') or (EdtDtFabricacao.Text='  /  /    ')) then Begin
     ShowErro('Informe a Data de Fabricação do produto!');
     EdtDtFabricacao.SetFocus;
     Exit;
  End
  Else If (CbRastroTipo.ItemIndex = 1) then Begin
     EdtLoteCheckIn.Text := Copy(EdtDtVencimento.Text, Length(EdtDtVencimento.Text)-1, 2)+
                            Copy(EdtDtVencimento.Text, 4, 2)+
                            Copy(EdtDtVencimento.Text, 1, 2);
//     EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2).ToString();
     if (StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2) < (StrToInt(Copy(DateToStr(Now()), 7, 4))) then
        EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2).ToString
     Else
        EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(DateToStr(Now()), 7, 4))-2).ToString;
  End;
  if Length(TEdit(Sender).Text) = 8 then
     TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
  if (EdtDtVencimento.Text<>'  /  /    ') Then Begin
     If (StrToDate(EdtDtVencimento.Text)<Now()) or (StrToDate(EdtDtVencimento.Text)<=StrToDate(EdtDtFabricacao.Text)) then
        raise Exception.Create('Não é permitido a entrada de produto vencido!')
     else If DaysBetween(StrToDate(FormatDateTime('dd/mm/yyyy', Now())), StrToDate(EdtDtVencimento.Text)) < (FdMemEntradaProduto.FieldByName('MesEntradaMinima').AsFloat*30) then Begin
        if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Permitir Recebimento fora do Shelf-Life') then Begin
           SolicitarAutorizacao := poShelfLife;
           AtivarPanelAutorizacao;
        End;
       //raise Exception.Create('Vencimento menor que ShelfLife do Produto.!');
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtEntradaIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtEntradaId.ReadOnly) then //and (StrToIntDef(EdtEntradaId.Text, 0)<>ObjEntradaCtrl.Entrada.EntradaId) then
     Limpar;
end;

procedure TFrmEntrada.EdtEntradaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmEntrada.EdtEntradaIdExit(Sender: TObject);
//Var LstEntrada : TObjectList<TEntradaCtrl>;
Begin
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtEntradaIdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Begin
     if (EdtEntradaId.Text = '') then Exit;
     if (StrToIntDef(EdtEntradaId.Text, 0) <= 0) then Begin
        ShowErro('Informe um Id de Entrada válido!');
        EdtEntradaId.Clear;
        EdtEntradaId.SetFocus;
        Exit;
     End;
     OpenEntrada;
  End;
  inherited;
  SoNumeros(Key);
end;

procedure TFrmEntrada.EdtInicioChange(Sender: TObject);
begin
  inherited;
  LimparProdutoSemPicking;
  BtnImprimirStand.Grayed := True;
end;

procedure TFrmEntrada.EdtLoteCheckInExit(Sender: TObject);
Var ObjLoteCtrl : TLoteCtrl;
    LstLotes    : TObjectList<TLote>;
begin
  inherited;
  if Not (EdtLoteCheckIn.ReadOnly) and (EdtLoteCheckIn.Text<>'') then Begin
     if Not ValidarLote(EdtLoteCheckIn.Text) then Begin
        EdtLoteCheckIn.SetFocus;
        ShowErro('Erro: Lote('+EdtLoteCheckIn.Text+') inválido!');
        EdtLoteCheckIn.Clear;
        Exit;
     End;
     ObjLoteCtrl := TLoteCtrl.Create;
     LstLotes := ObjLoteCtrl.GetProdutoLote(ObjProdutoCheckIn.IdProduto, EdtLoteCheckIn.Text, 0);
     if LstLotes.Count > 0 then
        ObjLoteCtrl.ObjLote  := LstLotes[0]
     Else Begin
       If Application.MessageBox(pWideChar('Deseja criar um novo lote('+EdtLoteCheckIn.Text+')?'), 'Novo Lote',
         MB_ICONQUESTION + MB_YESNO) = mrNo then Begin
         EdtLoteCheckIn.Clear;
         EdtLoteCheckIn.SetFocus;
       End
       Else Begin
          EdtDtFabricacao.SetFocus;
       End;
     End;
     if ObjLoteCtrl.ObjLote.Fabricacao <> 0 then
        EdtDtFabricacao.Text := DateToStr(ObjLoteCtrl.ObjLote.Fabricacao)
     Else EdtDtFabricacao.Clear;
     if ObjLoteCtrl.ObjLote.Vencimento <> 0 then
        EdtDtVencimento.Text := DateToStr(ObjLoteCtrl.ObjLote.Vencimento)
     Else EdtDtVencimento.Clear;
     ObjLoteCtrl.Free;
//     if (EdtLoteCheckIn.Text<>'') and (AutorizarAltLote in [poTodos, poZona, poProduto]) then
//        VerifyAutoration;
     if (Not VerificarSeLoteExiste) and (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimentos - Alteração Lotes')) Then Begin
         if AutorizarAltLote = poTodos then Begin
            SolicitarAutorizacao := poAlteraLote;
            AtivarPanelAutorizacao;
         End
         Else  If (AutorizarAltLote in [poZona, poProduto]) then
            VerifyAutoration;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtPesoCheckInKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_ESCAPE: Begin
      EdtProdutoCheckIn.Clear;
      AtivarEditCheckIn;
      ClearEditCheckIn;
      EdtProdutoCheckIn.SetFocus;
    End;
    VK_RETURN: Begin

    End;
  end;
end;

procedure TFrmEntrada.EdtPessoaIdChange(Sender: TObject);
begin
  inherited;
  LblFornecedor.Caption := '...';
end;

procedure TFrmEntrada.EdtPickingCheckInExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    RetornoJsonArray : TJsonArray;
    vEndereco        : String;
    ObjProdutoCtrl   : TProdutoCtrl;
    vErro : String;
begin
  inherited;
  if (Not EdtPickingCheckIn.ReadOnly) then Begin
     //ObjProdutoCtrl.ObjProduto.Endereco := TEndereco.Create;
     if (EdtPickingCheckIn.Text<>'') and (EdtPickingCheckIn.Text <> EnderecoMask(ObjProdutoCheckIn.Endereco.Descricao, '', False)) Then Begin
        Try
          vEndereco := EdtPickingCheckIn.Text;
          ObjEnderecoCtrl  := TEnderecoCtrl.Create;
          RetornoJsonArray := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EnderecoMask(EdtPickingCheckIn.Text, '', False), EnderecoMask(EdtPickingCheckIn.Text, '', False), 'T', 2, 0, 0);
          if (RetornoJsonArray.Count < 1) or (RetornoJsonArray.Items[0].TryGetValue('Erro', vErro)) then Begin
             EdtPickingCheckIn.Text := '';
             raise Exception.Create('Endereço '+EnderecoMask(vEndereco, '999999999', False)+' não encontrado!');
          End;
          If RetornoJsonArray.Items[0].GetValue<Integer>('status') = 0 then Begin
             EdtPickingCheckIn.Text := '';
             raise Exception.Create('Endereco('+EnderecoMask(vEndereco, '999999999', True)+') inativo! Não pode ser utilizado');
          End
          Else If RetornoJsonArray.Items[0].GetValue<Integer>('enderecoid') = 0 then Begin
             EdtPickingCheckIn.Text := '';
             raise Exception.Create('Endereco('+EnderecoMask(vEndereco, '', True)+') inexistente');
          End
          Else if ((RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> 0) and
                  ((RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> ObjProdutoCheckIn.IdProduto) then Begin
             EdtPickingCheckIn.Text := '';
             raise Exception.Create('Picking inválido, já utilizado pelo Produto: '+
                                    (RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<String>('produtoid')+' '+
                                    (RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<String>('descricao') );
          End
          Else Begin
//            ObjEnderecoCtrl.ObjEndereco := RetornoJsonArray.Items[0] as TJSONObject;
            ObjEnderecoCtrl.ObjEndereco := ObjEnderecoCtrl.ObjEndereco.JsonToClass((RetornoJsonArray.Items[0] as TJSONObject).ToString());
            ObjProdutoCheckIn.Endereco := ObjEnderecoCtrl.ObjEndereco;
          End;
          EdtPickingCheckIn.Text := EnderecoMask(EdtPickingCheckIn.Text, FdMemEntradaProduto.FieldByName('Mascara').AsString, True);
          ObjProdutoCtrl := TProdutoCtrl.Create;
          If ObjProdutoCtrl.EnderecarProduto(FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger,
                                          ObjEnderecoCtrl.ObjEndereco.EnderecoId).Items[0].TryGetValue('Erro', vErro) Then Begin
             ShowErro('Não foi possível endereçar o produto!');
             EdtPickingCheckIn.Clear;
             EdtPickingCheckIn.SetFocus;
          End
          Else Begin
             FdMemEntradaProduto.Edit;
             FdMemEntradaProduto.FieldByName('EnderecoId').AsInteger   := ObjEnderecoCtrl.ObjEndereco.EnderecoId;
             FdMemEntradaProduto.FieldByName('Picking').AsString       := ObjEnderecoCtrl.ObjEndereco.Descricao;
             FdMemEntradaProduto.FieldByName('ZonaId').AsInteger       := ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId;
             FdMemEntradaProduto.FieldByName('Zona').AsString          := ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.Descricao;
             FdMemEntradaProduto.FieldByName('ProdutoSNGPC').AsInteger := ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ProdutoSNGPC;
             FdMemEntradaProduto.Post;
          End;
          RetornoJsonArray := Nil;
          ObjEnderecoCtrl.Free;
          ObjProdutoCtrl.Free;
        Except On E: Exception do  Begin
             If Assigned(RetornoJsonArray) Then RetornoJsonArray := Nil;
             If Assigned(ObjEnderecoCtrl)  then ObjEnderecoCtrl.Free;
             If Assigned(ObjProdutoCtrl)   then ObjProdutoCtrl.Free;
             raise Exception.Create('Erro no Endereçamento: '+EnderecoMask(EdtPickingCheckIn.Text, '', False)+sLineBreak+E.Message);
          End;
        End;
        if CbRastroTipo.ItemIndex = 2 then
           EdtLoteCheckIn.SetFocus
        Else if CbRastroTipo.ItemIndex = 1 then Begin
           EdtLoteCheckIn.Enabled := False;
           EdtDtFabricacao.SetFocus;
        End
        Else if CbRastroTipo.ItemIndex = 0 then Begin
           GbItemLote.Enabled := False;
           EdtQtdUnidPrimCheckIn.SetFocus;
        End;
        if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CubagemProdutoEntrada = 1) and (EdtVolumeCheckIn.Value = 512) then
           EdtAlturaCheckIn.SetFocus;
     End
     Else if (EdtComprimentoCheckIn.Text<>'') and (FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecarProdutoEntrada = 1) then Begin
       EdtPickingCheckIn.SetFocus;
       ShowErro('Você precisa endereçar o produto.');
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtProdutoCheckInEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmEntrada.EdtProdutoCheckInExit(Sender: TObject);
begin
  inherited;
  if (EdtProdutoCheckIn.Text<>'') and (StrToInt64Def(EdtProdutoCheckIn.Text, 0) <= 0 ) then Begin
     ShowErro('Código de produto('+EdtProdutoCheckIn.Text+') inválido!');
     EdtProdutoCheckIn.Clear;
     EdtProdutoCheckIn.SetFocus;
     Exit;
  End;
  if (Sender=EdtProdutoCheckIn) and (EdtProdutoCheckIn.Text <> '') and (Not EdtProdutoCheckIn.ReadOnly) then Begin
     //ObjProdutoCheckIn.Limpar;
     ObjProdutoCheckIn := GetCodigoERP(EdtProdutoCheckIn.Text);  //GetProduto(EdtProdutoCheckIn.Text);
     if Assigned(ObjProdutoCheckIn) and (ObjProdutoCheckIn.IdProduto <> 0) then With ObjProdutoCheckIn do Begin
        If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno = 0) and
           (StrToInt64Def(EdtProdutoCheckIn.Text, 0) = ObjProdutoCheckIn.CodProduto) then Begin
           EdtProdutoCheckIn.SetFocus;
           ShowErro('Scanear o EAN do produto!');
           Exit;
        End;
        LblProdCheckIn.Caption  := FdMemEntradaProduto.FieldByName('Descricao').AsString;
        if (FdMemEntradaProduto.FieldByName('SNGPC').AsInteger = 1) or
           (FdMemEntradaProduto.FieldByName('ZonaSNGPC').AsInteger = 1) then
           ChkSNGPCCheckIn.Checked := True
        Else
           ChkSNGPCCheckIn.Checked := False;
        EdtPickingCheckIn.Text  := FdMemEntradaProduto.FieldByName('Picking').AsString;
        EdtFatorConversao.Text  := FdMemEntradaProduto.FieldByName('FatorConversao').AsString;
        EdtPesoCheckIn.Value    := FdMemEntradaProduto.FieldByName('PesoLiquido').AsFloat;
        EdtAlturaCheckIn.Value  := FdMemEntradaProduto.FieldByName('Altura').AsFloat;
        EdtLarguraCheckIn.Value := FdMemEntradaProduto.FieldByName('Largura').AsFloat;
        EdtComprimentoCheckIn.Value  := FdMemEntradaProduto.FieldByName('Comprimento').AsFloat;
        EdtVolumeCheckIn.Value       := FdMemEntradaProduto.FieldByName('Volume').AsFloat;
        EdtUnidadeId.Text            := FdMemEntradaProduto.FieldByName('UnidadeId').AsString;
        LblUnidade.Caption           := FdMemEntradaProduto.FieldByName('Unidade').AsString;
        EdtUnidadeSecundariaId.Text  := FdMemEntradaProduto.FieldByName('UnidadeSecundariaId').AsString;
        LblUnidadeSecundaria.Caption := FdMemEntradaProduto.FieldByName('UnidadeSecundariaDescricao').AsString;
        CbRastroTipo.ItemIndex       := FdMemEntradaProduto.FieldByName('RastroId').AsInteger-1;
        LblUnidPrimCheckIn.Caption   := FdMemEntradaProduto.FieldByName('Unidade').AsString;
        LblUnidSecCheckIn.Caption    := FdMemEntradaProduto.FieldByName('UnidadeSecundariaDescricao').AsString+
                                        ' x '+FdMemEntradaProduto.FieldByName('FatorConversao').AsInteger.ToString();
        AtivarEditCheckIn;
        CbRastroTipo.Enabled := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Permitir definir rastreabilidade');
        GroupBox5.Enabled    := CbRastroTipo.Enabled;
     End
     Else Begin
        ShowErro('Produto não pertence ao documento!');
        EdtProdutoCheckIn.Clear;
        EdtProdutoCheckIn.SetFocus;
        Exit;
     End;
     SetCampoRastro;
     if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CubagemProdutoEntrada > 0) and
        ((EdtVolumeCheckIn.Value = 0) or (EdtVolumeCheckIn.Value = 512)) then Begin
        GbItemCubagem.Enabled := True;
        GbItemCubagem.TabStop := True;
        if //(FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecarProdutoEntrada = 0) and
           (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CubagemProdutoEntrada in [1, 2]) then
           EdtAlturaCheckIn.SetFocus;
     End
     Else Begin
        GbItemCubagem.Enabled := False;
        GbItemCubagem.TabStop := False;
     End;
  End
  Else If EdtProdutoCheckIn.Text = '' then
     If PnlCheckIn.Visible then EdtProdutoCheckIn.SetFocus;
  ExitFocus(Sender);
end;

procedure TFrmEntrada.EdtProdutoCheckInKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Sender=EdtProdutoCheckIn) and (Not EdtProdutoCheckIn.ReadOnly) then
     ClearEditCheckIn;
  if (key = VK_ESCAPE) and (Not EdtProdutoCheckIn.ReadOnly) then Begin
     if EdtProdutoCheckIn.Text = '' then
        BtnCancelarClick(BtnCancelar)
     Else EdtProdutoCheckIn.Clear;
  End;
  if (Key = 13) and (EdtProdutoCheckIn.Text = '') then
     EdtProdutoCheckIn.SetFocus;
//  Else if Key = VK_RETURN then Begin
//     Key := 0;
//     SelectNext(ActiveControl,True,True);
//  End;
end;

procedure TFrmEntrada.EdtQtdTotCheckInKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then Begin
     if ((EdtQtdUnidSecCheckIn.Enabled) and (Not EdtQtdUnidSecCheckIn.ReadOnly)) or
        ((Not EdtQtdUnidSecCheckIn.Enabled) and (Not EdtQtdUnidPrimCheckIn.ReadOnly)) then begin
        //CalcularQuantidade;
        if (Sender = EdtQtdUnidSecCheckIn) or (Sender=EdtQtdUnidPrimCheckIn) then
           ImgSaveCheckInClick(ImgSaveCheckIn);
     end;
  End;
end;

procedure TFrmEntrada.EdtQtdUnidPrimCheckInChange(Sender: TObject);
begin
  inherited;
  EdtQtdTotCheckIn.Value := EdtQtdUnidPrimCheckIn.Value + (EdtQtdUnidSecCheckIn.Value*ObjProdutoCheckIn.FatorConversao);
end;

procedure TFrmEntrada.EdtQtdUnidPrimCheckInExit(Sender: TObject);
begin
  if tJvCalcEdit(Sender).Value < 0 then
     raise Exception.Create('Quantidade inválida!');
  if (Sender = EdtQtdeDevSeg) and (EdtQtdeDevSeg.Value > EdtQtdeDevSeg.Tag) then Begin
     EdtQtdeDevSeg.Clear;
     raise Exception.Create('Quantidade excedida. Máximo permitido: '+EdtQtdeDevSeg.Tag.ToString());
  End;
  inherited;
end;

procedure TFrmEntrada.EdtQtdUnidPrimCheckInKeyPress(Sender: TObject;
  var Key: Char);
begin
  soNumeros(Key);
  inherited;
  if (key = #13) and (tJvCalcEdit(Sender).Text<>'') then Begin
     Key := #0;
     keybd_event(VK_F2, 0, 0, 0);
     if ((Sender=EdtQtdUnidSecCheckIn)  and (EdtQtdUnidSecCheckIn.Enabled) and (Not EdtQtdUnidSecCheckIn.ReadOnly)) or
        ((Sender=EdtQtdUnidPrimCheckIn) and (EdtQtdUnidPrimCheckIn.Enabled) and (Not EdtQtdUnidPrimCheckIn.ReadOnly)) then begin
        //CalcularQuantidade;
        if (Sender = EdtQtdUnidSecCheckIn) or (Sender=EdtQtdUnidPrimCheckIn) then Begin
           ImgSaveCheckInClick(ImgSaveCheckIn);
           if (PnlCheckIn.Visible) and (EdtProdutoCheckIn.Enabled) then EdtProdutoCheckIn.SetFocus;
        End;
     end
     Else If (Sender=EdtQtdeDevSeg) and (StrToInt64Def(EdtQtdeDevSeg.Text, 0) > 0) then
       BtnSalvarDevolucaoSegregadoClick(BtnSalvarDevolucaoSegregado);
  End;
end;

procedure TFrmEntrada.EdtQtdUnidSecCheckInKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
{
   if (Sender = EdtQtdUnidSecCheckIn) and (Key = #13) and (EdtQtdUnidPrimCheckIn.Value+EdtQtdUnidSecCheckIn.Value>0) then begin
      Key := #0;
      ImgSaveCheckInClick(ImgSaveCheckIn);
   end;
}
end;

procedure TFrmEntrada.EdtUsuarioIdAutAltLoteExit(Sender: TObject);
Var vErro : String;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  if EdtUsuarioIdAutAltLote.Text <> '' then Begin
     JsonArrayRetorno := ObjUsuarioAltLoteCtrl.FindUsuario(EdtUsuarioIdAutAltLote.Text, 0);
     if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
        raise Exception.Create(vErro);
     End;
     //ObjUsuarioAltLoteCtrl.ObjUsuario := ObjUsuarioAltLoteCtrl.ObjUsuario.JsonToClass((JsonArrayRetorno.Items[0] as TJsonObject).ToString);
     LblUsuario.Caption := ObjUsuarioAltLoteCtrl.ObjUsuario.Nome;
     JsonArrayRetorno := Nil;
  End;
end;

procedure TFrmEntrada.EdtUsuarioIdAutAltLoteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     SelectNext(ActiveControl, True, True);
end;

procedure TFrmEntrada.EtqArmazenagem(pCodProduto : integer);
Var ObjEntradaEtqCtrl : TEntradaCtrl;
    JsonArrayRetorno  : TJsonArray;
    vErro : String;
begin
    if CbFormatoEtqArmazenagem.ItemIndex < 0 then Begin
       ShowErro('Selecione o formato da Etiqueta');
       CbFormatoEtqArmazenagem.SetFocus;
       Exit;
    End;
    ObjEntradaEtqCtrl := TEntradaCtrl.Create;
    JsonArrayRetorno  := ObjEntradaEtqCtrl.GetEtiquetaArmazenagem(0, 0, StrToIntDef(EdtEntradaId.Text, 0),
                         '', 0, pCodProduto, 0);
    if not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqPpla' ) then Begin
          If CbFormatoEtqArmazenagem.ItemIndex = 0 Then
             PrintTagArmazenagem5x10etqPpla( JsonArrayRetorno )
          Else
             PrintTagArmazenagem8x10etqPpla( JsonArrayRetorno );
       End
       Else If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqEpl2' ) then Begin
          If CbFormatoEtqArmazenagem.ItemIndex = 0 then
             PrintTagArmazenagem5x10etqEpl2( JsonArrayRetorno )
          Else
             PrintTagArmazenagem8x10etqEpl2( JsonArrayRetorno );
       End;
    End
    else
       ShowErro('Erro: '+vErro);
    JsonArrayRetorno  := Nil;
    ObjEntradaEtqCtrl := nil;
end;

function TFrmEntrada.ExistDevolutionSegregation: Boolean;
begin
  Result := False;
end;

procedure TFrmEntrada.filtraritens(CodProdutoERP: Integer);
Var xProd : Integer;
begin
  AdvSGItensEntrada.FilterActive := false;
  AdvSGItensEntrada.Filter.Clear;
  with AdvSGItensEntrada.Filter.Add do
  begin
    condition := CodProdutoERP.ToString();
    column := 1;
    operation := foNone;
  end;
  AdvSGItensEntrada.FilterActive := true;
  vTotXML      := 0;
  vTotCheckIn  := 0;
  vTotDev      := 0;
  vTotSegr     := 0;
  for xProd := 1 to AdvSGItensEntrada.RowCount-1 do Begin
    vTotXML      := vTotXml     + AdvSGItensEntrada.Cells[7, xProd].ToInteger();
    vTotCheckIn  := vTotCheckIn + AdvSGItensEntrada.Cells[8, xProd].ToInteger();
    vTotDev      := vTotDev     + AdvSGItensEntrada.Cells[9, xProd].ToInteger();
    vTotSegr     := vTotSegr    + AdvSGItensEntrada.Cells[10, xProd].ToInteger();
  End;
end;

procedure TFrmEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmEntrada := Nil;
end;

procedure TFrmEntrada.FormCreate(Sender: TObject);
Var xItens : Integer;
    ObjOperacaoTipoCtrl : TOperacaoTipoCtrl;
    vlIni : TIniFile;
begin
  inherited;
  vlIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.ini');
  try
    vTimeEtiqueta := vlIni.ReadInteger('PRINTER',  'TimeEtq' , 500);
    vTemperatura  := vlIni.ReadInteger('PRINTER',  'Temperatura' , 10);
    CbFormatoEtqArmazenagem.ItemIndex := vlIni.ReadInteger('PRINTER',  'FormatoEtqArmazenagem' , -1);
  finally
    vlIni.Free;
  end;
  ClearEditCheckIn;
  ObjProdutoCheckIn := TProduto.Create;
  xItens := ObjProdutoCheckIn.IdProduto;
  //FEntradaItens := TEntradaItensCtrl.Create;
  //ObjProdutoCtrl          := TProdutoCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0]  :=  90+Trunc(90*ResponsivoVideo);;
    ColWidths[1]  := 100+Trunc(100*ResponsivoVideo);;
    ColWidths[2]  :=  70+Trunc(70*ResponsivoVideo);;
    ColWidths[3]  := 250+Trunc(250*ResponsivoVideo);;
    ColWidths[4]  := 85+Trunc(85*ResponsivoVideo);;
    ColWidths[5]  :=  80+Trunc(80*ResponsivoVideo);;
    ColWidths[6]  :=  80+Trunc(80*ResponsivoVideo);;
    ColWidths[7]  :=  65+Trunc(65*ResponsivoVideo);;
    ColWidths[8]  :=  65+Trunc(65*ResponsivoVideo);;
    ColWidths[9]  := 120+Trunc(120*ResponsivoVideo);;
    ColWidths[10] :=  70+Trunc(70*ResponsivoVideo);;
    ColWidths[11] :=  50+Trunc(50*ResponsivoVideo);;
    ColWidths[12] :=  60+Trunc(60*ResponsivoVideo);;
  End;
  LstCadastro.Alignments[ 0, 0] := taRightJustify;
  LstCadastro.FontStyles[ 0, 0] := [FsBold];
  LstCadastro.Alignments[ 2, 0] := taRightJustify;
  LstCadastro.Alignments[ 5, 0] := taCenter;
  LstCadastro.Alignments[ 6, 0] := taCenter;
  LstCadastro.Alignments[ 7, 0] := taCenter;
  LstCadastro.Alignments[ 8, 0] := taRightJustify;
  LstCadastro.Alignments[10, 0] := taRightJustify;
  LstCadastro.Alignments[11, 0] := taRightJustify;
  LstCadastro.Alignments[12, 0] := taRightJustify;
  LstCadastro.HideColumn(1);

  With AdvSGItensEntrada do Begin
    ColWidths[0]  :=  40+Trunc(40*ResponsivoVideo);
    ColWidths[1]  :=  65+Trunc(65*ResponsivoVideo);
    ColWidths[2]  := 280+Trunc(280*ResponsivoVideo);
    ColWidths[3]  :=  90+Trunc(90*ResponsivoVideo);
    ColWidths[4]  := 120+Trunc(120*ResponsivoVideo);
    ColWidths[5]  :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[6]  :=  75+Trunc(75*ResponsivoVideo);
    ColWidths[7]  :=  50+Trunc(50*ResponsivoVideo);
    ColWidths[8]  :=  50+Trunc(50*ResponsivoVideo);
    ColWidths[9]  :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[10] :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[11] :=  60+Trunc(70*ResponsivoVideo);
    ColWidths[12] :=  40+Trunc(40*ResponsivoVideo);
    ColWidths[13] :=  50+Trunc(50*ResponsivoVideo);
    ColWidths[14] :=  40+Trunc(40*ResponsivoVideo);
    Alignments[0,  0] := taRightJustify;
    FontStyles[0,  0] := [FsBold];
    Alignments[3,  0] := taCenter;
    Alignments[5,  0] := taCenter;
    Alignments[6,  0] := taCenter;
    Alignments[7,  0] := taRightJustify;
    Alignments[9,  0] := taRightJustify;
    Alignments[10, 0] := taRightJustify;
    Alignments[11, 0] := taRightJustify;
    Alignments[12, 0] := taCenter;
    Alignments[13, 0] := taCenter;
    Alignments[14, 0] := taCenter;
  End;
  LstAgrupamentoLista.ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[1] :=  70+Trunc(70*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[2] := 200+Trunc(200*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[3] := 100+Trunc(100*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[4] :=  80+Trunc(80*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[5] :=  65+Trunc(65*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[6] :=  65+Trunc(65*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[7] :=  60+Trunc(60*ResponsivoVideo);;
  LstAgrupamentoLista.ColWidths[8] :=  40+Trunc(40*ResponsivoVideo);;
  LstAgrupamentoLista.Alignments[0, 0] := taRightJustify;
  LstAgrupamentoLista.FontStyles[0, 0] := [FsBold];
  LstAgrupamentoLista.Alignments[5, 0] := taRightJustify;
  LstAgrupamentoLista.Alignments[6, 0] := taRightJustify;
  LstAgrupamentoLista.Alignments[7, 0] := taRightJustify;
  LstAgrupamentoLista.Alignments[8, 0] := taCenter;

  LstAgrupamentoNotas.ColWidths[0] :=   90+Trunc( 90*ResponsivoVideo);;
  LstAgrupamentoNotas.ColWidths[1] :=  120+Trunc(120*ResponsivoVideo);;
  LstAgrupamentoNotas.ColWidths[2] :=   80+Trunc( 80*ResponsivoVideo);;
  LstAgrupamentoNotas.ColWidths[3] :=   60+Trunc( 60*ResponsivoVideo);;
  LstAgrupamentoNotas.ColWidths[4] :=   40+Trunc( 40*ResponsivoVideo);;
  LstAgrupamentoNotas.Alignments[0, 0] := taRightJustify;
  LstAgrupamentoNotas.FontStyles[0, 0] := [FsBold];
  LstAgrupamentoNotas.Alignments[2, 0] := taCenter;
  LstAgrupamentoNotas.Alignments[3, 0] := taRightJustify;
  LstAgrupamentoNotas.Alignments[4, 0] := taCenter;

  AdvSGItensEntrada.HideColumn(4);
  AdvSGItensEntrada.HideColumn(5);
  AdvSGItensEntrada.HideColumn(6);

  if Not (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Visualizar Quantidade Recebida(XML) - Recebimentos')) then Begin
     AdvSGItensEntrada.HideColumn(7);
     AdvSGItensEntrada.HideColumn(11);
  End
  Else Begin
     AdvSGItensEntrada.UnHideColumn(7);
     AdvSGItensEntrada.UnHideColumn(11);
  End;
  LstNotasGroup.ColWidths[0] := 80+Trunc(80*ResponsivoVideo);;
  LstNotasGroup.ColWidths[1] := 250+Trunc(250*ResponsivoVideo);;
  LstNotasGroup.ColWidths[2] := 100+Trunc(100*ResponsivoVideo);;
  LstNotasGroup.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);;
  LstNotasGroup.ColWidths[4] :=  40+Trunc(40*ResponsivoVideo);;
  LstNotasGroup.Alignments[0, 0] := taRightJustify;
  LstNotasGroup.FontStyles[0, 0] := [FsBold];
  LstNotasGroup.Alignments[3, 0] := taCenter;
  LstNotasGroup.Alignments[4, 0] := taCenter;
  PnlGroupNotaLeft.Width := LstNotasGroup.ColWidths[0]+LstNotasGroup.ColWidths[1]+LstNotasGroup.ColWidths[2]+
                            LstNotasGroup.ColWidths[3]+LstNotasGroup.ColWidths[4]+35;
  //Buscar Dados Complementares
  ObjOperacaoTipoCtrl := TOperacaoTipoCtrl.Create;
  LstOperacaoTipo     := ObjOperacaoTipoCtrl.GetOperacaoTipo;
  CbOperacaoTipo.Items.Clear;
  for xItens := 0 to LstOperacaoTipo.Count-1 do
    CbOperacaoTipo.Items.Add(LstOperacaoTipo[xItens].Descricao);
  FreeAndNil(ObjOperacaoTipoCtrl);
  PnlCheckIn.Align := AlClient;
  vRespAltLoteId   := 0;
  AutorizarAltLote := TAutorizarAltLote(FrmeXactWMS.ConfigWMS.ObjConfiguracao.AutorizarAltLote); //TagProdutoEntrada);
  ObjUsuarioAltLoteCtrl := TUsuarioCtrl.Create();
  PnlReport.Top         := PnlBtnCheckIn.Top;
  GetProdutoControle;
  GetSegregadoCausa; //Segregado e Devolução
  ConfigACBrETQ;
end;

procedure TFrmEntrada.FormDestroy(Sender: TObject);
begin
  If Assigned(ObjProdutoCheckIn) then
     ObjProdutoCheckIn.Free;
  if Assigned(ObjUsuarioAltLoteCtrl) then
     ObjUsuarioAltLoteCtrl.Free;
  inherited;
end;

procedure TFrmEntrada.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_ESCAPE) and (PnlCheckIn.Visible) then
     if (Not EdtProdutoCheckIn.Enabled)  then
        Exit
     Else
        ShowMessage('Pressione o botao voltar!')
  Else //if Not PnlCheckIn.Visible then
     inherited;
end;

Function TFrmEntrada.GetListaEntrada(pPedidoId : Integer = 0; pPessoaId: Integer = 0;
                                     pDocumento : String = ''; pRazao : String = '';
                                     pRegistroERP : String = ''; pDtNotaFiscal : TDateTime = 0;
                                     pPendente : Integer = 1; pAgrupamentoId : Integer = 0;
                                     pCodProduto : String = '0'; pDescrProduto : String = ''): Boolean;
Var xLista           : Integer;
    JsonArrayEntrada : TJsonArray;
    vErro            : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  try
    LstCadastro.RowCount := 1;
    Result := False;
    ObjEntradaCtrl       := TEntradaCtrl.Create;
    JsonArrayEntrada     := ObjEntradaCtrl.GetEntradaBasica(pPedidoId, pPessoaId, PDocumento, pRazao,
                            pRegistroERP, pDtNotaFiscal, pPendente, pAgrupamentoId, pCodProduto, pDescrProduto);
    if JsonArrayEntrada.Items[0].TryGetValue('Erro', vErro) then begin
       ShowErro('Erro: '+vErro);
       JsonArrayEntrada := Nil;
       ObjEntradaCtrl.Free;
       Exit;
    End;
    LstCadastro.RowCount  := JsonArrayEntrada.Count+1;
    LstCadastro.Fixedrows := 1;
    Result := True;
    For xLista := 0 To Pred(JsonArrayEntrada.Count) do begin
      LstCadastro.Cells[0, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<Integer>('pedidoid').ToString();
      LstCadastro.Cells[1, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('operacaotipo');
      LstCadastro.Cells[2, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<Integer>('codpessoaerp').ToString();
      LstCadastro.Cells[3, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('razao');
      LstCadastro.Cells[4, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('documentonr');
      LstCadastro.Cells[5, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('documentodata');  // GetValueInjSon(jSonObj, 'documentodata');
      LstCadastro.Cells[6, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('dtinclusao');// GetValueInjSon(jSonObj, 'dtinclusao');
      LstCadastro.Cells[7, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('hrinclusao');// GetValueInjSon(jSonObj, 'hrinclusao');
      LstCadastro.Cells[8, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<Integer>('armazemid').ToString();
      LstCadastro.Cells[9, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('processo'); //'Recebido'
      if JsonArrayEntrada.Items[xLista].GetValue<Integer>('agrupamentoid') <> 0 then
         LstCadastro.Cells[10, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<Integer>('agrupamentoid').ToString()
      Else LstCadastro.Cells[10, xLista+1] := '';
      LstCadastro.Cells[11, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('qtdxml'); //'Recebido'
      if JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdcheckin') > 0 then Begin
         LstCadastro.Cells[12, xLista+1] := FormatFloat('##0.00', (JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdcheckin')/
                                                                   JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdxml')*100))+'%';
      End
      Else
         LstCadastro.Cells[12, xLista+1] := '';
      if JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdcheckin') = 0 then Begin
         LstCadastro.Colors[9, xLista+1] := clWhite;
         LstCadastro.FontStyles[9, xLista+1] := [];
      End
      Else if (JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdcheckin')>0) and
           (JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdcheckin') < JsonArrayEntrada.Items[xLista].GetValue<Integer>('qtdxml')) then Begin
         LstCadastro.Colors[9, xLista+1] := clYellow;
         LstCadastro.FontStyles[9, xLista+1] := [fsBold];
      End
      Else Begin
         LstCadastro.Colors[9, xLista+1] := $00006C00;
         LstCadastro.FontStyles[9, xLista+1] := [fsBold];
      End;
      LstCadastro.Alignments[0, xLista+1] := taRightJustify;
      LstCadastro.FontStyles[0, xLista+1] := [FsBold];
      LstCadastro.Alignments[2, xLista+1] := taRightJustify;
      LstCadastro.Alignments[5, xLista+1] := taCenter;
      LstCadastro.Alignments[6, xLista+1] := taCenter;
      LstCadastro.Alignments[7, xLista+1] := taCenter;
      LstCadastro.Alignments[8, xLista+1] := taRightJustify;
      LstCadastro.Alignments[10, xLista+1] := taRightJustify;
      LstCadastro.Alignments[11, xLista+1] := taRightJustify;
      LstCadastro.Alignments[12, xLista+1] := taRightJustify;
    end;
    MontarPaginacao(ObjEntradaCtrl.MontarPaginacao);
    JsonArrayEntrada := Nil;
    ObjEntradaCtrl.Free;
  Except On E: Exception do Begin
    ShowErro('Erro: '+E.Message);
    JsonArrayEntrada := Nil;
    ObjEntradaCtrl.Free;
    End;
  End;
end;

procedure TFrmEntrada.GetListaEntradaItens;
Var ObjEntradaItensCtrl : TEntradaItensCtrl;
    JsonArrayRetorno    : TJsonArray;
    vErro : String;
begin
  ObjEntradaItensCtrl := TEntradaItensCtrl.Create;
  JsonArrayRetorno    := ObjEntradaItensCtrl.GetEntradaProduto(FdMemEntrada.FieldByName('PedidoId').AsInteger);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     EdtEntradaId.SetFocus;
  End
  Else Begin
     if AdvSGItensEntrada.RowCount > 1 then
        AdvSGItensEntrada.RemoveRows(1, AdvSGItensEntrada.RowCount-1);
     AdvSGItensEntrada.RowCount := 1;
     If FdMemEntradaProduto.Active then
        FdMemEntradaProduto.EmptyDataSet;
     FdMemEntradaProduto.Close;
     FdMemEntradaProduto.LoadFromJson(JsonArrayRetorno, False);
     PreencherListaProduto;
  End;
  JsonArrayRetorno := Nil;
  ObjEntradaItensCtrl.Free;
end;

procedure TFrmEntrada.GetListaLstCadastro;
Begin
  inherited;
  GetListaEntrada;
end;

procedure TFrmEntrada.GetNotasFornecedorGroup(pCodFornecedor: Integer);
Var xLista           : Integer;
    JsonArrayEntrada : TJsonArray;
    vErro            : String;
    ObjLocalEntrada  : TEntradaCtrl;
begin
  LstNotasGroup.RowCount  := 1;
  ObjLocalEntrada  := TEntradaCtrl.Create;
  try
    JsonArrayEntrada     := ObjLocalEntrada.GetEntradaBasica(0, pCodFornecedor, '', '', '', 0, 1, 0, '', '');
    if JsonArrayEntrada.Items[0].TryGetValue('Erro', vErro) then
       ShowErro('Erro: '+vErro)
    Else Begin
       LstNotasGroup.RowCount  := JsonArrayEntrada.Count+1;
       LstNotasGroup.FixedRows := 1;
       for xLista := 1 to JsonArrayEntrada.Count do
         LstNotasGroup.AddDataImage(4, xLista, 0, haCenter, vaTop);
       for xLista := 0 to Pred(JsonArrayEntrada.Count) do Begin
         LstNotasGroup.Cells[0, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<Integer>('pedidoid').ToString();
         LstNotasGroup.Cells[1, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('razao');
         LstNotasGroup.Cells[2, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('documentonr');
         LstNotasGroup.Cells[3, xLista+1] := JsonArrayEntrada.Items[xLista].GetValue<String>('documentodata');
         LstNotasGroup.Cells[4, xLista+1] := '0';
         LstNotasGroup.Alignments[0, xLista+1] := taRightJustify;
         LstNotasGroup.FontStyles[0, xLista+1] := [FsBold];
         LstNotasGroup.Alignments[3, xLista+1] := taCenter;
         LstNotasGroup.Alignments[4, xLista+1] := taCenter;
       End;
    End;
    JsonArrayEntrada := Nil;
    ObjLocalEntrada.Free;
  Except On E: Exception do Begin
    JsonArrayEntrada := Nil;
    ObjLocalEntrada.Free;
    ShowErro('Erro: '+E.Message);
    End;
  End
end;

procedure TFrmEntrada.GetAgrupamentoLista(pAgrupamento, pCodPessoaERP: Integer);
Var JsonAgrupamentoLista : TJsonArray;
    vErro  : String;
    xLista : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  If FDMemAgupamentoLista.Active then
     FDMemAgupamentoLista.EmptyDataSet;
  FDMemAgupamentoLista.Close;
  If FDMemAgrupamentoNotas.Active then
     FDMemAgrupamentoNotas.EmptyDataSet;
  FDMemAgrupamentoNotas.Close;
  LstAgrupamentoLista.ClearRect(0, 1, LstAgrupamentoLista.ColCount-1, LstAgrupamentoLista.RowCount-1);
  LstAgrupamentoLista.RowCount := 1;
  LstAgrupamentoNotas.ClearRect(0, 1, LstAgrupamentoNotas.ColCount-1, LstAgrupamentoNotas.RowCount-1);
  LstAgrupamentoNotas.RowCount := 1;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonAgrupamentoLista := ObjEntradaCtrl.GetAgrupamentoLista(pAgrupamento, pCodPessoaERP);
  if Not JsonAgrupamentoLista.Items[0].TryGetValue('Erro', vErro) then Begin
     FDMemAgupamentoLista.LoadFromJSON(JsonAgrupamentoLista, False);
     FDMemAgrupamentoNotas.LoadFromJSON(JsonAgrupamentoLista.Items[0].GetValue<TJsonArray>('pedidos'), False);
     LstAgrupamentoLista.RowCount  := FDMemAgupamentoLista.RecordCount+1;
     LstAgrupamentoLista.FixedRows := 1;
     for xLista := 1 to FDMemAgupamentoLista.RecordCount do
       LstAgrupamentoLista.AddDataImage(8, xlista, 2, haCenter, vaTop);
     for xLista := 1 to FDMemAgupamentoLista.RecordCount do Begin
       LstAgrupamentoLista.Cells[0, xLista] := FDMemAgupamentoLista.FieldByName('AgrupamentoId').AsString;
       LstAgrupamentoLista.Cells[1, xLista] := FDMemAgupamentoLista.FieldByName('CodPessoaERP').AsString;
       LstAgrupamentoLista.Cells[2, xLista] := FDMemAgupamentoLista.FieldByName('Fantasia').AsString;
       LstAgrupamentoLista.Cells[3, xLista] := FDMemAgupamentoLista.FieldByName('Usuario').AsString;
       LstAgrupamentoLista.Cells[4, xLista] := FDMemAgupamentoLista.FieldByName('Data').AsString;
       LstAgrupamentoLista.Cells[5, xLista] := FDMemAgupamentoLista.FieldByName('QtdXml').AsString;
       LstAgrupamentoLista.Cells[6, xLista] := FDMemAgupamentoLista.FieldByName('QtdCheckIn').AsString;
       LstAgrupamentoLista.Cells[7, xLista] := FormatFloat('0.00', FDMemAgupamentoLista.FieldByName('PercConferencia').AsFloat)+'%';
       LstAgrupamentoLista.Cells[8, xLista] := '2';
//       LstAgrupamentoLista.Cells[5, xLista] := FDMemAgupamentoLista.FieldByName('Hora').AsString;
//       LstAgrupamentoLista.Cells[6, xLista] := FDMemAgupamentoLista.FieldByName('Terminal').AsString;
       LstAgrupamentoLista.Alignments[0, xLista] := taRightJustify;
       LstAgrupamentoLista.FontStyles[0, xLista] := [FsBold];
       LstAgrupamentoLista.Alignments[5, xLista] := taRightJustify;
       LstAgrupamentoLista.Alignments[6, xLista] := taRightJustify;
       LstAgrupamentoLista.Alignments[7, xLista] := taRightJustify;
       LstAgrupamentoLista.Alignments[8, xLista] := taCenter;
       FDMemAgupamentoLista.Next;
     End;
     MontaListaAgrupamentoNotas;
  End;
  JsonAgrupamentoLista := Nil;
  ObjEntradaCtrl.Free;
end;

function TFrmEntrada.GetCodigoERP(pCodigoERP: String): TProduto;
Var ObjProdutoCtrl    : TProdutoCtrl;
    JsonArrayRetorno  : TJsonArray;
    xListaProd        : Integer;
    vCodigoERP        : Integer;
    vErro             : String;
    ObjCodBarrasCtrl  : TProdutoCodBarrasCtrl;
    LstCodBarras      : TObjectList<TProdutoCodBarrasCtrl>;
    ObjEntradaCtrl   : TEntradaCtrl;
begin

//Substituir OBJENTRADACTRL
//14Nov23
{  for xListaProd := 0 to Pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
    if ObjEntradaCtrl.Entrada.Itens[xListaProd].ProdutoLotes.Produto.CodProduto.ToString() = pCodigoERP then Begin
       Result := ObjEntradaCtrl.Entrada.Itens[xListaProd].ProdutoLotes.Produto;
       Break
    End;
  End;
}
  Result := TProduto.Create;
  FdMemEntradaProduto.First;
  if (StrToIntDef(pCodigoERP, 0)=0) or (Not FdMemEntradaProduto.Locate('CodProduto', pCodigoERP, [])) then Begin
     ObjProdutoCtrl := TProdutoCtrl.Create();
     JsonArrayRetorno := ObjProdutoCtrl.FindProduto('0', pCodigoERP, '', 0, 0);
     if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
        EdtProdutoCheckIn.Clear;
        EdtProdutoCheckIn.SetFocus;
        ShowErro('Codigo de produto inválido!!!');
        JsonArrayRetorno := Nil;
        ObjProdutoCtrl.Free;
        Exit;
     End;
     vCodigoERP := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto');
     JsonArrayRetorno := Nil;
     ObjProdutoCtrl.Free;
     if (Not FdMemEntradaProduto.Locate('CodProduto', vCodigoERP, [])) then Begin
        ShowErro('Produto inválido ou não pertence a esta Entrada.');
        EdtProdutoCheckIn.Clear;
        EdtProdutoCheckIn.SetFocus;
        Exit;
     End;
  End;
  Result.IdProduto  := FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger;
  Result.CodProduto := FdMemEntradaProduto.FieldByName('CodProduto').AsInteger;
  Exit;



  for xListaProd := 0 to Pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
    if ObjEntradaCtrl.Entrada.Itens[xListaProd].ProdutoLotes.Produto.CodProduto = vCodigoERP then Begin
       Result := ObjEntradaCtrl.Entrada.Itens[xListaProd].ProdutoLotes.Produto;
       Break
    End;
  End;
  if Result.IdProduto > 0 then Begin
     ObjCodBarrasCtrl := TProdutoCodBarrasCtrl.Create();
     LstCodBarras := ObjCodBarrasCtrl.GetProdutoCodBarras(0, 0, EdtProdutoCheckIn.Text, 0);
     if LstCodBarras.Count > 0 then Begin
        if (Result.FatorConversao > 1) and (LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem = Result.FatorConversao) then
           EdtQtdUnidSecCheckIn.Text := LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem.ToString();
//        Else
//           EdtQtdUnidPrimCheckIn.Text := LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem.ToString();
     End;
     LstCodBarras := Nil;
     ObjCodBarrasCtrl.Free;
  End;
  //JsonArrayRetorno := Nil;
  //ObjProdutoCtrl.Free;
end;

function TFrmEntrada.GetProduto(pProdutoId: String): TProduto;
Var ObjProdutoCtrl : TProdutoCtrl;
begin
  ObjProdutoCtrl := TProdutoCtrl.Create();
//  Result := TPRoduto.Create;
  Result := ObjProdutoCtrl.GetProduto(pProdutoId)[0];
  ObjProdutoCtrl := Nil;
end;

procedure TFrmEntrada.GetProdutoControle;
Var ObjRastroCtrl    : TRastroCtrl;
    JsonArrayRetorno : TJsonArray;
    xRastro : Integer;
begin
  ObjRastroCtrl    := TRastroCtrl.Create;
  JsonArrayRetorno := ObjRastroCtrl.GetRastroJson(0, '');
  CbRastroTipo.Items.Clear;
  for xRastro := 0 to JsonArrayRetorno.Count-1 do
    CbRastroTipo.Items.Add(JsonArrayRetorno.Items[xRastro].GetValue<String>('descricao'));
  JsonArrayRetorno := Nil;
  ObjRastroCtrl.Free;
end;

procedure TFrmEntrada.GetProdutoLoteDevolucao;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    xLotes : Integer;
    vErro  : String;
begin
  If FdMemEntradaLote.Active then
     FdMemEntradaLote.EmptyDataSet;
  FdMemEntradaLote.Close;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonArrayRetorno := ObjEntradaCtrl.GetEntradaLoteDevolucao(FdMemEntrada.FieldByName('PedidoId').AsInteger,
                                                           FdMemEntrada.FieldByName('AgrupamentoId').AsInteger,
                                                           FdMemEntradaProduto.FieldByName('CodProduto').AsInteger);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else Begin
     FdMemEntradaLote.LoadFromJson(JsonArrayRetorno, False);
     EdtProdutoIdDevSeg.Text  := FdMemEntradaProduto.FieldByName('CodProduto').AsString;
     LblProdutoDevSeg.Caption := FdMemEntradaProduto.FieldByName('Descricao').AsString;
     CbLotesDevSeg.Items.Clear;
     for xLotes := 0 to Pred(JsonArrayRetorno.Count) do
       CbLotesDevSeg.Items.Add(JsonArrayRetorno.Items[xLotes].GetValue<String>('descrlote'));
     GbDevolucaoSegregado.SetFocus;
  End;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl.Free;
end;

procedure TFrmEntrada.GetSegregadoCausa;
Var JsonArrayRetorno : TJsonArray;
    ObjSegregaCausaCtrl : TSegregadoCausaCtrl;
    vErro : String;
begin
  If FdMemSegregadoCausa.Active then
     FdMemSegregadoCausa.EmptyDataSet;
  FdMemSegregadoCausa.Close;
  ObjSegregaCausaCtrl := TSegregadoCausaCtrl.Create;
  JsonArrayRetorno := ObjSegregaCausaCtrl.GetSegregadoCausa(0, '', 1);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowMSG(vErro)
  Else Begin
     FDMemSegregadoCausa.LoadFromJSON(JsonArrayRetorno, False);
     cbMotivo.Items.Clear;
     FDMemSegregadoCausa.First;
     while Not FDMemSegregadoCausa.Eof do Begin
       CbMotivo.Items.Add(FDMemSegregadoCausa.FieldByName('Descricao').AsString);
       FDMemSegregadoCausa.Next;
     End;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjSegregaCausaCtrl);
end;

procedure TFrmEntrada.HidePanelDevolucaoSegregado;
begin
  TThread.CreateAnonymousThread(procedure
  Var xLeft, xTime : Integer;
  begin
    xLeft := PnlDevolucaoSegregado.Left;
    while xLeft <= PnlItensEntrada.Width do Begin
      TThread.Synchronize(nil, procedure
      begin
        PnlDevolucaoSegregado.Left := xLeft;
        if PnlDevolucaoSegregado.Left >= PnlItensEntrada.Width then
           PnlDevolucaoSegregado.Visible := False;
      End);
      xLeft := xLeft + 10;
    end;
  end).Start;
end;

procedure TFrmEntrada.EdtProdutoIdDevSegKeyPress(Sender: TObject;
  var Key: Char);
Var xProdLote : Integer;
Begin
  inherited;
  if EdtProdutoIdDevSeg.Text = '' then Exit;
  if Key = #13 then Begin
     if (EdtProdutoIdDevSeg.Text<>'') and (StrToIntDef(EdtProdutoIdDevSeg.Text, 0) <= 0 ) then Begin
        ShowErro('Código de produto('+EdtProdutoIdDevSeg.Text+') inválido!');
        EdtProdutoIdDevSeg.Clear;
        EdtProdutoIdDevSeg.SetFocus;
        Exit;
     End;
     ObjProdutoCheckIn := GetCodigoERP(EdtProdutoIdDevSeg.Text);
     if ObjProdutoCheckIn.IdProduto = 0 then Begin
        EdtProdutoIdDevSeg.Clear;
        EdtProdutoIdDevSeg.SetFocus;
     End
     else
        GetProdutoLoteDevolucao;
  End;
end;

procedure TFrmEntrada.LblClearFilterClick(Sender: TObject);
begin
  inherited;
  CbCampoPesq.ItemIndex := 2;
end;

procedure TFrmEntrada.LblLoginClick(Sender: TObject);
begin
  inherited;
  if (EdtUsuarioIdAutAltLote.Text='') or (EdtSenhaAutAltLote.Text='') then
     raise Exception.Create('Infrorme o login para autorizar o procedimento!');
  if Md5Texto(edtSenhaAutAltLote.Text) = ObjUsuarioAltLoteCtrl.ObjUsuario.Senha then begin
     if ((SolicitarAutorizacao = poAlteraLote) and (ObjUsuarioAltLoteCtrl.AcessoFuncionalidade('Recebimentos - Alteração Lotes'))) then
        ReturnEntradaLote
     Else if ((SolicitarAutorizacao = poShelfLife) and (ObjUsuarioAltLoteCtrl.AcessoFuncionalidade('Permitir Recebimento fora do Shelf-Life'))) then
        ReturnValidaShelfLife
     Else if ((SolicitarAutorizacao = poDivergencia) and (ObjUsuarioAltLoteCtrl.AcessoFuncionalidade('Recebimento - Finalizar com Devolução e Segregado'))) then
        ReturnFinalizarEntrada
     Else
        raise Exception.Create('Usuário não autorizado para liberar acesso!');
  End
  Else Begin
     edtSenhaAutAltLote.SetFocus;
     raise Exception.Create('Login e/ou Senha não confere!');
  end;
End;

procedure TFrmEntrada.Limpar;
begin
  EnabledButtons := False;
  if (Not EdtEntradaId.Enabled) then
     EdtEntradaId.Clear;
  BtnVoltarClick(BtnVoltar);
  PnlHeaderEntrada.Enabled    := True;
  EdtDocumentoNr.Clear;
  EdtDocumentoData.Clear;
  EdtRegistroERP.Clear;
  EdtPessoaId.Clear;
  LblFornecedor.Caption       := '';
  LblResItens.Caption         := '';
  LblResSKU.Caption           := '';
  LblResCheckIn.Caption       := '';
  LblResEstado.Caption        := '';
  LblResPlanCega.Caption      := '';
  LblResRecebido.Caption      := '';
  LblResInicioCheckIn.Caption := '';
  LblResEncCheckIn.Caption    := '';
  LblResFinalizado.Caption    := '';
  LblResIntegracaoERP.Caption := '';
  LblProcesso.Caption         := '';
  AdvSGItensEntrada.RowCount  := 1;
  ImgCancelCheckIn.Visible    := False;
  ImgSaveCheckIn.Visible      := False;
  LblCancelCheckIn.Visible    := False;
  LblSaveCheckIn.Visible      := False;
  BtnStartCheckIn.Visible     := False;
  BtnFinalizarCheckIn.Visible := False;
//  BtnCancelarCheckIn.Visible  := (BtnStartCheckIn.Visible) and (FdMemEntrada.FieldByName('Status').AsInteger <> 3)
//  Else
  BtnCancelarCheckIn.Visible  := (BtnStartCheckIn.Visible);
  PnlReport.Visible           := False;
  TabGroupNota.TabVisible     := False;
  PnlBtnCheckIn.Visible       := False;
  LimparNotasGroup;
end;

procedure TFrmEntrada.LimparNotasGroup;
begin
  LstNotasGroup.RowCount     := 1;
  LblFornecedorGroup.Caption := '';
  PnlBotGroup.Visible        := False;
  vTotalNotaAgrupada         := 0;
end;

procedure TFrmEntrada.LimparProdutoSemPicking;
begin
  If FDMemProdutoSemPicking.Active then
     FDMemProdutoSemPicking.EmptyDataSet;
  FDMemProdutoSemPicking.Close;
  BtnImprimirStand.Grayed := True;
end;

procedure TFrmEntrada.LstAgrupamentoListaClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xCol, xRow : Integer;
    vErro : String;
    JsonAgrupamentoLista     : TJsonArray;
    JsonArrayRetornoExcluido : TJsonArray;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  inherited;
  LstAgrupamentoLista.Row := aRow;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  If (aRow>0) and (aCol<8) then Begin
     If FDMemAgrupamentoNotas.Active then
        FDMemAgrupamentoNotas.EmptyDataSet;
     FDMemAgrupamentoNotas.Close;
     ObjEntradaCtrl := TEntradaCtrl.Create;
     JsonAgrupamentoLista := ObjEntradaCtrl.GetAgrupamentoLista(StrToIntDef(LstAgrupamentoLista.Cells[0, aRow], 0), 0);
     if Not JsonAgrupamentoLista.Items[0].TryGetValue('Erro', vErro) then Begin
        FDMemAgrupamentoNotas.LoadFromJSON(JsonAgrupamentoLista.Items[0].GetValue<TJsonArray>('pedidos'), False);
        MontaListaAgrupamentoNotas;
     End;
     JsonAgrupamentoLista := Nil;
  End
  Else if (aRow>0) and (aCol=8) then Begin
     if Confirmacao('Cancelamento...', 'Cancelar o agrupamento('+LstAgrupamentoLista.Cells[0, aRow]+')?', True) then Begin
        JsonArrayRetornoExcluido := ObjEntradaCtrl.DeleteAgrupamento(StrToIntDef(LstAgrupamentoLista.Cells[0, aRow], 0), 0);
        if JsonArrayRetornoExcluido.Items[0].TryGetValue('Erro', vErro) then
           ShowErro('Não foi possível excluir o agrupamento. '+vErro)
        Else Begin
          LstAgrupamentoNotas.ClearRect(0, 1, LstAgrupamentoNotas.ColCount-1, LstAgrupamentoNotas.RowCount-1);
          LstAgrupamentoNotas.RowCount := 1;
          GetAgrupamentoLista(0, StrToIntDef(EdtCodFornecedorGroup.Text, 0));
          ShowOk('Agupramento excluído com sucesso!');
        End;
        JsonArrayRetornoExcluido := NIl;
     End;
  End;
  ObjEntradaCtrl.Free;
end;

procedure TFrmEntrada.LstAgrupamentoNotasClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  inherited;
  if (aCol = 4) then Begin
     if Confirmacao('Cancelamento...', 'Retirar a entrada('+LstAgrupamentoNotas.Cells[0, aRow]+') do Agrupamento', True) then Begin
        ObjEntradaCtrl   := TEntradaCtrl.Create;
        JsonArrayRetorno := ObjEntradaCtrl.DeleteAgrupamento(StrToIntDef(LstAgrupamentoLista.Cells[0, LstAgrupamentoLista.Row], 0), StrToIntDef(LstAgrupamentoNotas.Cells[0, aRow], 0));
        if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
           ShowErro('Não foi possível excluir a Entrada do agrupamento. '+vErro)
        Else Begin
          if LstAgrupamentoNotas.RowCount = 2 then
             GetAgrupamentoLista(0, 0)
          Else
             LstAgrupamentoListaClickCell(LstAgrupamentoNotas, LstAgrupamentoLista.Row, 0);
          ShowOk('Entrada/Documento retirado do Agupramento com sucesso!');
        End;
        JsonArrayRetorno := NIl;
        ObjEntradaCtrl.Free;
     End;
  End;
end;

procedure TFrmEntrada.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
Var I : Integer;
begin
//  inherited;
  if not Assigned(AEditLink) then
    Exit;
  If aCol = 11 then begin
     with (aEditLink.GetEditControl as TImagePicker) do begin
       BeginUpdate;
       Items.Clear;
       //if aCol = 4 then Begin
//          for i := 0 to 1 do
            Items.Add.ImageIndex := 2;
       //End
       //Else Items.Add.ImageIndex := 2;
       EndUpdate;
     end;
  end;
end;

procedure TFrmEntrada.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if acol in [1..5] then
     aEditor:=edCustom;
end;

procedure TFrmEntrada.LstNotasGroupClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xNotas, xSelecao : Integer;
begin
  inherited;
  if LstNotasGroup.RowCount <= 1 then Exit;
  if (aCol = 4) then Begin
     if (aRow = 0) then Begin
        xSelecao := StrToIntDef(LstNotasGroup.Cells[4, 1], 0);
        For xNotas := 1 to Pred(LstNotasGroup.RowCount) do
          if xSelecao = 1 then Begin
             LstNotasGroup.Cells[4, xNotas] := '0';
             Dec(vTotalNotaAgrupada);
          End
          Else Begin
             LstNotasGroup.Cells[4, xNotas] := '1';
             Inc(vTotalNotaAgrupada);
          End
     End
     Else Begin
       if StrToIntDef(LstNotasGroup.Cells[4, aRow], 0) = 0 then Begin
          LstNotasGroup.Cells[4, aRow] := '1';
          Inc(vTotalNotaAgrupada);
       End
       Else Begin
         LstNotasGroup.Cells[4, aRow] := '0';
         Dec(vTotalNotaAgrupada);
       End;
     End;
  End;
  //PnlBotGroup.Visible := vTotalNotaAgrupada > 0;
  PnlBotGroup.Visible := False;
  For xSelecao := 1 to LstNotasGroup.RowCount do Begin
    if LstNotasGroup.Cells[4, xSelecao] = '1' then Begin
       PnlBotGroup.Visible := True;
       Break;
    End;
  End;
end;

procedure TFrmEntrada.MontaListaAgrupamentoNotas;
Var xNotas : Integer;
begin
  LstAgrupamentoNotas.RowCount := 1;
  LstAgrupamentoNotas.ClearRect(0, 1, LstAgrupamentoNotas.ColCount-1, LstAgrupamentoNotas.RowCount-1);
  if FDMemAgrupamentoNotas.IsEmpty then Exit;
  LstAgrupamentoNotas.RowCount  := FDMemAgrupamentoNotas.RecordCount+1;
  LstAgrupamentoNotas.FixedRows := 1;
  for xNotas := 1 to FDMemAgrupamentoNotas.RecordCount do
    LstAgrupamentoNotas.AddDataImage(4, xNotas, 2, haCenter, vaTop);
  for xNotas := 1 to FDMemAgrupamentoNotas.RecordCount do Begin
    LstAgrupamentoNotas.Cells[0, xNotas] := FDMemAgrupamentoNotas.FieldByName('PedidoId').AsString;
    LstAgrupamentoNotas.Cells[1, xNotas] := FDMemAgrupamentoNotas.FieldByName('DocumentoNr').AsString;
    LstAgrupamentoNotas.Cells[2, xNotas] := FDMemAgrupamentoNotas.FieldByName('DocumentoData').AsString;
    LstAgrupamentoNotas.Cells[3, xNotas] := FDMemAgrupamentoNotas.FieldByName('QtdXml').AsString;
    LstAgrupamentoNotas.Cells[4, xNotas] := '2';
    LstAgrupamentoNotas.Alignments[0, xNotas] := taRightJustify;
    LstAgrupamentoNotas.FontStyles[0, xNotas] := [FsBold];
    LstAgrupamentoNotas.Alignments[2, xNotas] := taCenter;
    LstAgrupamentoNotas.Alignments[3, xNotas] := taRightJustify;
    LstAgrupamentoNotas.Alignments[4, xNotas] := taCenter;
    FDMemAgrupamentoNotas.Next;
  End;
end;

procedure TFrmEntrada.OnEditDevSeg;
begin
  EdtprodutoIdDevSeg.ReadOnly := False;
  EdtProdutoIdDevSeg.SetFocus;
  GbDevolucaoSegregado.Enabled := True;
  CbLotesDevSeg.Enabled := True;
  EdtFabricacaoDevSeg.ReadOnly := True;
  EdtVencimentoDevSeg.ReadOnly := True;
  CbMotivo.Enabled         := True;
  EdtQtdeDevSeg.ReadOnly   := False;
  RbDevolucao.Enabled      := True;
  RbSegregado.Enabled      := True;
end;

procedure TFrmEntrada.OpenEntrada;
Var xTeste : Integer;
    ObjPedido : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro  : String;
begin
  inherited;
  if (Not EdtEntradaId.ReadOnly) and (EdtEntradaid.text<>'') then Begin //and (ObjEntradaCtrl.Entrada.EntradaId<>StrToIntDef(EdtEntradaId.Text,0))
     Limpar;
//     ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtEntradaId.Text, 0);
     TDialogMessage.ShowWaitMessage('Aguarde!!! Buscando dados para CheckIn...',
       procedure
       begin
         If FdMemEntrada.Active then
            FdMemEntrada.EmptyDataSet;
         FdMemEntrada.Close;
         ObjPedido := TEntradaCtrl.Create;
         JsonArrayRetorno := ObjPedido.GetHeader(StrToIntDef(EdtEntradaId.Text, 0), 0);
         if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
            EdtEntradaId.Clear;
            EdtEntradaId.SetFocus;
            ShowErro('Erro: '+vErro);
         End
         Else Begin
            FdMemEntrada.LoadFromJson(JsonArrayRetorno, False);
            ShowDados;
            //Buscar Itens da Entrada para o Grid de Lotes
            GetListaEntradaItens;
            AdvSGItensEntrada.SetFocus;
         End;
         JsonArrayRetorno := Nil;
         FreeAndNil(ObjPedido);

       End);
  End;
end;

procedure TFrmEntrada.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtEntradaId.Text  := LstCadastro.Cells[aCol, aRow];
  PgcBase.ActivePage := TabPrincipal;
  OpenEntrada; //EdtEntradaIdExit(EdtEntradaId);
  FrmEntrada.Enabled := False;
  FrmEntrada.Enabled := True;
end;

function TFrmEntrada.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if pConteudo = '0' then raise Exception.Create('conteúdo inválido para pesquisar!');
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then Begin
        ShowErro('Selecione o campo para procurar!');
        CbCampoPesq.SetFocus;
        Exit;
     End
     Else If (CbCampoPesq.ItemIndex = 5) then Begin
       Try
         StrToDate(EdtConteudoPesq.Text);
       Except
         ShowErro('Data Inválida para pesquisa.');
         CbCampoPesq.SetFocus;
         Exit;
       End;
     End;
     Try
       if CbCampoPesq.ItemIndex = 0 then //0 Id
          if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
             Result := GetListaEntrada(StrToInt(EdtConteudoPesq.Text), 0, '', '', '', 0, 0, 0, '0', '')
          else raise Exception.Create('Id inválido para pesquisar!')
       Else if (CbCampoPesq.ItemIndex = 1) and (StrToIntDef(EdtConteudoPesq.Text, 0)>0) then //Código ERP
          Result := GetListaEntrada(0, StrToInt(EdtConteudoPesq.Text), '', '', '', 0, 1, 0, '0', '')
       Else if CbCampoPesq.ItemIndex = 2 then //Documento Nr
          Result := GetListaEntrada(0, 0, EdtConteudoPesq.Text, '', '', 0, 0, 0, '0', '')
       Else if CbCampoPesq.ItemIndex = 3 then //Razao
          Result := GetListaEntrada(0, 0, '', EdtConteudoPesq.Text, '', 0, 1, 0, '0', '')
       Else if CbCampoPesq.ItemIndex = 4 then //RegistroERP
          Result := GetListaEntrada(0, 0, '', '', EdtConteudoPesq.Text, 0, 1, 0, '0', '')
       Else if CbCampoPesq.ItemIndex = 5 then //Data Nota Fiscal
          Result := GetListaEntrada(0, 0, '', '', '', StrToDate(EdtConteudoPesq.Text), 1, 0, '0', '')
       Else if CbCampoPesq.ItemIndex = 6 then //Data Nota Fiscal
          Result := GetListaEntrada(0, 0, '', '', '', 0, 1, StrToIntDef(EdtConteudoPesq.Text, 0), '0', '')
       Else if CbCampoPesq.ItemIndex = 7 then //Agrupamento
          Result := GetListaEntrada(0, 0, '', '', '', 0, 1, 0, EdtConteudoPesq.Text, '')
       Else if CbCampoPesq.ItemIndex = 8 then //Agrupamento
          Result := GetListaEntrada(0, 0, '', '', '', 0, 1, 0, '0', EdtConteudoPesq.Text);
     Except On E: Exception do
        ShowErro('Erro: '+E.Message);
     End;
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmEntrada.PesquisarProdutoSemPicking;
Var vDataInicial, vDataFinal : TDateTime;
    vErro      : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  BtnExportarStand.Grayed := True;
  BtnImprimirStand.Grayed := True;
  If FDMemProdutoSemPicking.Active then
     FDMemProdutoSemPicking.EmptyDataSet;
  FDMemProdutoSemPicking.Close;
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDataInicial := 0
    Else vDataInicial :=StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial inválida!');
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       vDataFinal := 0
    Else vDataFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final inválida!');
  End;
  if (vDataInicial <> 0) and (vDataFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  TDialogMessage.ShowWaitMessage('Buscando Dados...',
    procedure
    Var JsonArrayRetorno : TJsonArray;
    begin
      LblTotRegSemPicking.Caption := '';
      ObjEntradaCtrl   := TEntradaCtrl.Create;
      JsonArrayRetorno := ObjEntradaCtrl.GetProdutoSemPicking(vDataInicial, vDataFinal, StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtCodPessoa.Text, 0), EdtDoctoNrPSP.Text);
      if JsonArrayRetorno.Items[0].tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         BtnImprimirStand.Grayed := False;
      End
      Else Begin
        FDMemProdutoSemPicking.LoadFromJson(JsonArrayRetorno, False);
        BtnExportarStand.Grayed := False;
        BtnImprimirStand.Grayed := False;
      End;
      JsonArrayRetorno := Nil;
      ObjEntradaCtrl.Free;
      LblTotRegSemPicking.Caption := FormatFloat('0', FDMemProdutoSemPicking.RecordCount);
    End);
end;

procedure TFrmEntrada.PnlAutorizarAltLoteHide;
begin
  TThread.CreateAnonymousThread(procedure
  Var xLeft, xTime : Integer;
  begin
    //for xLeft := PnlAutorizarAltLote.Left to PnlItensEntrada.Width do begin
    xLeft := PnlAutorizarAltLote.Left;
    while xLeft <= PnlItensEntrada.Width do Begin
      TThread.Synchronize(nil, procedure
      begin
        PnlAutorizarAltLote.Left := xLeft;
        if PnlAutorizarAltLote.Left >= PnlItensEntrada.Width then
           PnlAutorizarAltLote.Visible := False;
      End);
      //for xTime := 0 to 5 do
      xLeft := xLeft + 10;
    end;
  end).Start;
end;

procedure TFrmEntrada.PreencherListaProduto;
Var xLista : Integer;
    vSKU, vCheckIn : Integer;
    vErro : String;
Begin
  vSKU     := 0;
  vCheckIn := 0;
  LblResEstado.Font.Color := ClBlack;
  AdvSGItensEntrada.FilterActive := False;
  AdvSGItensEntrada.RowCount  := FdMemEntradaProduto.RecordCount+1;
  AdvSGItensEntrada.FixedRows := 1;
  For xLista := 1 to FdMemEntradaProduto.RecordCount do Begin
    AdvSGItensEntrada.AddDataImage(12, xLista, 2, haCenter, vaTop);
    AdvSGItensEntrada.AddDataImage(13, xLista, 4, haCenter, vaTop);
    AdvSGItensEntrada.AddDataImage(14, xLista, 6, haCenter, vaTop);
  End;
  xLista := 0;
  FdMemEntradaProduto.First;
  While Not FdMemEntradaProduto.Eof Do Begin
     AdvSGItensEntrada.Cells[0, xLista+1]  := xLista.ToString();
     AdvSGItensEntrada.Cells[1, xLista+1]  := FdMemEntradaProduto.FieldByName('codproduto').AsString;  //Lote.ProdutoId.ToString();
     AdvSGItensEntrada.Cells[2, xLista+1]  := FdMemEntradaProduto.FieldByName('descricao').AsString;
     AdvSGItensEntrada.Cells[3, xLista+1]  := EnderecoMask(FdMemEntradaProduto.FieldByName('picking').AsString,
                                                           FdMemEntradaProduto.FieldByName('mascara').AsString, True);
     AdvSGItensEntrada.Cells[7, xLista+1]  := FdMemEntradaProduto.FieldByName('qtdxml').AsString;
     vSKU := vSKU + FdMemEntradaProduto.FieldByName('qtdxml').AsInteger;
     AdvSGItensEntrada.Cells[8, xLista+1]  := FdMemEntradaProduto.FieldByName('qtdcheckin').AsString;
     AdvSGItensEntrada.Cells[9, xLista+1]  := FdMemEntradaProduto.FieldByName('qtdsegregada').AsString;
     AdvSGItensEntrada.Cells[10, xLista+1] := FdMemEntradaProduto.FieldByName('qtddevolvida').AsString;
     AdvSGItensEntrada.Cells[11, xLista+1] := (FdMemEntradaProduto.FieldByName('qtdxml').AsInteger-
                                               (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
                                                FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
                                                FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger)).ToString();
     if FdMemEntrada.FieldByName('qtdxml').AsInteger > 0 then
        AdvSGItensEntrada.Cells[11, xLista+1] := (FdMemEntradaProduto.FieldByName('qtdxml').AsInteger-
                                                  (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
                                                  FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
                                                  FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger)).ToString()
     Else AdvSGItensEntrada.Cells[11, xLista+1] := '0';
     AdvSGItensEntrada.Cells[12, xLista+1] := 2.ToString();
     AdvSGItensEntrada.Cells[13, xLista+1] := 4.ToString();
     if (FdMemEntradaProduto.FieldByName('qtdxml').AsInteger = (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
                                                               FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
                                                               FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger)) then
        AdvSGItensEntrada.Cells[14, xLista+1] := 7.ToString()
     Else
        AdvSGItensEntrada.Cells[14, xLista+1] := 6.ToString();
     vCheckIn := vCheckIn + (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
                             FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
                             FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger);
     if (FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
                             FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger>0) then Begin
        AdvSGItensEntrada.FontColors[ 2, xLista+1] := ClRed;
        AdvSGItensEntrada.FontColors[ 9, xLista+1] := ClRed;
        AdvSGItensEntrada.FontColors[10, xLista+1] := ClRed;
        AdvSGItensEntrada.FontStyles[ 2, xLista+1] := [FsBold];
        AdvSGItensEntrada.FontStyles[ 9, xLista+1] := [FsBold];
        AdvSGItensEntrada.FontStyles[10, xLista+1] := [FsBold];
     End
     Else Begin
        AdvSGItensEntrada.FontColors[ 2, xLista+1] := AdvSGItensEntrada.FontColors[ 1, xLista+1];
        AdvSGItensEntrada.FontColors[ 9, xLista+1] := AdvSGItensEntrada.FontColors[ 1, xLista+1];
        AdvSGItensEntrada.FontColors[10, xLista+1] := AdvSGItensEntrada.FontColors[ 1, xLista+1];
        AdvSGItensEntrada.FontStyles[ 2, xLista+1] := [];
        AdvSGItensEntrada.FontStyles[ 9, xLista+1] := [];
        AdvSGItensEntrada.FontStyles[10, xLista+1] := [];
     End;
     if (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
         FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
         FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger) > FdMemEntradaProduto.FieldByName('qtdxml').AsInteger then Begin
        AdvSGItensEntrada.Colors[ 8, xLista+1] := ClRed;
        AdvSGItensEntrada.Colors[ 9, xLista+1] := ClRed;
        AdvSGItensEntrada.Colors[10, xLista+1] := ClRed;
     End
     Else if (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
              FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
              FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger) = FdMemEntradaProduto.FieldByName('qtdxml').AsInteger then Begin
        AdvSGItensEntrada.Colors[ 8, xLista+1] := ClGreen;
        AdvSGItensEntrada.Colors[ 9, xLista+1] := ClGreen;
        AdvSGItensEntrada.Colors[10, xLista+1] := ClGreen;
     End
     Else if (FdMemEntradaProduto.FieldByName('qtdcheckin').AsInteger+
              FdMemEntradaProduto.FieldByName('qtdsegregada').AsInteger+
              FdMemEntradaProduto.FieldByName('qtddevolvida').AsInteger) = 0 then Begin
        AdvSGItensEntrada.Colors[ 8, xLista+1] := ClWhite;
        AdvSGItensEntrada.Colors[ 9, xLista+1] := ClWhite;
        AdvSGItensEntrada.Colors[10, xLista+1] := ClWhite;
     End
     Else Begin
        AdvSGItensEntrada.Colors[ 8, xLista+1] := clYellow;
        AdvSGItensEntrada.Colors[ 9, xLista+1] := clYellow;
        AdvSGItensEntrada.Colors[10, xLista+1] := clYellow;
     End;
     AdvSGItensEntrada.Alignments[0, xLista+1] := taRightJustify;
     AdvSGItensEntrada.FontStyles[0, xLista+1] := [FsBold];
     AdvSGItensEntrada.Alignments[ 1, xLista+1] := taRightJustify;
     AdvSGItensEntrada.Alignments[ 3, xLista+1] := taCenter;
     AdvSGItensEntrada.Alignments[ 5, xLista+1] := taCenter;
     AdvSGItensEntrada.Alignments[ 6, xLista+1] := taCenter;
     AdvSGItensEntrada.Alignments[ 7, xLista+1] := taRightJustify;
     AdvSGItensEntrada.Alignments[ 8, xLista+1] := taRightJustify;
     AdvSGItensEntrada.Alignments[ 9, xLista+1] := taRightJustify;
     AdvSGItensEntrada.Alignments[10, xLista+1] := taRightJustify;
     AdvSGItensEntrada.Alignments[11, xLista+1] := taRightJustify;
     FdMemEntradaProduto.Next;
     inc(xLista);
  End;
  AdvSGItensEntrada.SortSettings.Column := 1;
  AdvSGItensEntrada.QSort;
  LblResItens.Caption   := (AdvSGItensEntrada.RowCount-1).ToString();
  LblResSKU.Caption     := vSku.ToString();
  LblResCheckIn.Caption := vCheckIn.ToString();
  PnlReport.Visible     := False;
  AdvSGItensEntrada.UnHideRow(12);
  AdvSGItensEntrada.UnHideRow(13);
  if FdMemEntrada.FieldByName('Status').AsInteger in [0, 1] then Begin
     if vCheckIn = 0 then
        StatusEntrada := StRecebido // LblResEstado.Caption := 'Recebido'
     else If vCheckIn < vSKU then
        StatusEntrada := StCheckIn //LblResEstado.Caption := 'Em CheckIn'
     else If (vSKU - vCheckIn) = 0 then
        StatusEntrada := StFinalizacao; // LblResEstado.Caption := 'Finalização';
     SetStatusEntrada;
     if ((vSKU - vCheckIn) = 0) and (PnlCheckIn.Visible) then
        BtnVoltarClick(BtnVoltar);
     BtnStartCheckIn.Visible    := ((vSKU - vCheckIn) > 0) and (Not PnlCheckIn.Visible) and (FdMemEntrada.RecordCount>0);
     BtnFinalizarCheckIn.Visible := (Not BtnStartCheckIn.Visible) and (StatusEntrada = StFinalizacao); //(ObjEntradaCtrl.Entrada.Status < 2);
     BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible or BtnFinalizarCheckIn.Visible);
     AdvSGItensEntrada.UnHideColumn(12);
     AdvSGItensEntrada.UnHideColumn(13);
     PnlBtnCheckIn.Visible := BtnStartCheckIn.Visible;
  End
  Else Begin
    if FdMemEntrada.FieldByName('Status').AsInteger in [2, 4] then Begin
       LblResEstado.Caption := 'Finalizado';
       PnlReport.Visible := True;
       TagProdutoOnOff;
    End
    else If FdMemEntrada.FieldByName('Status').AsInteger = 3 then Begin
       LblResEstado.Caption    := 'Cancelado';
       LblResEstado.Font.Color := ClRed;
    End;
    PnlBtnCheckIn.Visible       := False;
    BtnStartCheckIn.Visible     := False;
    BtnFinalizarCheckIn.Visible := False;
    BtnCancelarCheckIn.Visible  := (BtnStartCheckIn.Visible or BtnFinalizarCheckIn.Visible);
    AdvSGItensEntrada.HideColumn(12);
    AdvSGItensEntrada.HideColumn(13);
  End;
End;

procedure TFrmEntrada.PrintTagArmazenagem5x10etqEpl2(pJsonArray: TJsonArray);
begin

end;

procedure TFrmEntrada.PrintTagArmazenagem5x10etqPpla(pJsonArray: TJsonArray);
Var xJsonEtq, xEtq, EtqCxaFechada : Integer;
    vTipoEtiqueta : String;
  Procedure PrintEtq(JsonEtq : TJsonObject; pQuant : Integer);
  Var Lin, EtqPrint : Integer;
      vEndereco     : String;
  Begin
    Try
      ACBrETQConfig.DPI           := TACBrETQDPI(0);
      ACBrETQConfig.Temperatura   := vTemperatura;
      With ACBrETQConfig do Begin
        Ativar;
        IniciarEtiqueta;
        Lin := 5;
        ImprimirTexto(orNormal, 3, 1, 1, 48+Lin,  7, JsonEtq.GetValue<String>('zona'), 0, True); // Copy(JsonEtq.GetValue<String>('zona'), 1, 20)
        ImprimirBarras(orNormal, barCODE128, 2, 2, 45+Lin, 70, JsonEtq.GetValue<String>('codproduto'), 8, becNAO);
        ImprimirTexto(orNormal, 2, 1, 1, 45+Lin,  7, 'Impressão:', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, 42+Lin,  80, JsonEtq.GetValue<String>('codproduto'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, 42+Lin, 7, DateToStr(Date())+ ' '+Copy(TimeToStr(Time()), 1, 5)+'h', 0, False);
        //ImprimirCaixa(Lin+15, 5, 95, 12, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, 38+Lin, 7, 'Produto', 0, False);
        ImprimirTexto(orNormal, 3, 1, 1, 34+Lin, 7, Copy(JsonEtq.GetValue<String>('descricao'), 1, 45), 0, False);
        ImprimirTexto(orNormal, 3, 1, 1, 30+Lin, 7, COpy(JsonEtq.GetValue<String>('descricao'), 46, 45), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, 27+Lin,  7, 'Lote', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, 27+Lin, 37, 'Fabricação', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, 27+Lin, 57, 'Vencimento', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, 27+Lin, 80, 'Quantidade', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, 22+Lin,  7, JsonEtq.GetValue<String>('descrlote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, 22+Lin, 37, JsonEtq.GetValue<String>('fabricacao'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, 22+Lin, 57, JsonEtq.GetValue<String>('vencimento'), 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, 22+Lin, 77, Repl(' ',6-Length(pQuant.ToString))+pQuant.ToString, 0, False);

        ImprimirCaixa(Lin+39, 5, 95, 17, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+40,  7, 'Documento', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+40, 45, 'Data', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+43,  7, JsonEtq.GetValue<String>('documentonr'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+43, 45, JsonEtq.GetValue<String>('data'), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+48, 7, 'Fornecedor', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+51, 7, Copy(JsonEtq.GetValue<String>('fantasia'), 1, 60), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+57, 15, 'Picking', 0, False);
        ImprimirTexto(orNormal, 4, 3, 4, Lin+60, 7, EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, 2, 82, 'eXactWMS®', 0, False);
//DESATIVAR PARA BRASIL
        if Pos('BRASIL', UpperCase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa)) <= 0 then Begin
           if (vTipoEtiqueta = 'F') Then // JsonEtq.GetValue<Integer>('tipoetiqueta') = 1 then
              ImprimirTexto(orNormal, 2, 1, 2, 2, 10, 'Fracionados', 0, False)
           Else
              ImprimirTexto(orNormal, 2, 1, 2, 2, 10, 'Cxa.Fechada', 0, False);
        End;
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
      End;
    Except On E: Exception do Begin
      ShowErro('Erro: Problema de comunicação com impressora...'+#13+E.Message);
      End;
    End;
  End;
Begin
  for xJsonEtq := 0 to Pred(pJsonArray.Count) do Begin
    //Caixa Fechada
    for EtqCxaFechada := 1 to pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdcxafechada') do Begin
      vTipoEtiqueta := 'C'; //Caixa Fechada
      PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('fatorconversao'));
    End;
    //Fracionados
    if pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada') > 0 then Begin
       vTipoEtiqueta := 'F'; //Caixa Fracionada
       PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada'));
    End;
  End;
end;

procedure TFrmEntrada.PrintTagArmazenagem8x10etqEpl2(pJsonArray: TJsonArray);
Var xJsonEtq, xEtq, EtqCxaFechada : Integer;
    vTipoEtiqueta : String;
  Procedure PrintEtq(JsonEtq : TJsonObject; pQuant : Integer);
  Var Lin, EtqPrint : Integer;
      vEndereco     : String;
  Begin
    Try
      ACBrETQConfig.DPI           := TACBrETQDPI(0);
      ACBrETQConfig.Temperatura   := vTemperatura;
      With ACBrETQConfig do Begin
        Ativar;
        IniciarEtiqueta;
        Lin := 1;
//PedidoId	DocumentoNr	Data	CodPessoaERP	Razao	Fantasia	QtdItens	(Nenhum nome de coluna)
//          ImprimirCaixa(LinIni, ColIni, Largura(col), Altura(Lin), Espessura 1, Espessura 1);
        ImprimirCaixa(Lin,  5, 50, 14, 0, 0);
        ImprimirCaixa(Lin, 55, 45, 14, 0, 0);
        ImprimirTexto(orNormal, 3, 1, 1, Lin+2,  7, JsonEtq.GetValue<String>('zona'), 0, True);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+6,  7, 'Impressão:', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+9, 18, DateToStr(Date()), 0, False);
        ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+2, 60, JsonEtq.GetValue<String>('codproduto'), 8, becSIM);
//Produto
        ImprimirCaixa(Lin+15, 5, 95, 12, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+16, 7, 'Produto', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+19, 7, Copy(JsonEtq.GetValue<String>('descricao'), 1, 60), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+23, 7, COpy(JsonEtq.GetValue<String>('descricao'), 61, 40), 0, False);
//Lote
        ImprimirCaixa(Lin+28, 5, 95, 9, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29,  7, 'Lote', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 37, 'Fabricação', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 57, 'Vencimento', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 80, 'Quantidade', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+32,  7, JsonEtq.GetValue<String>('descrlote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+32, 37, JsonEtq.GetValue<String>('fabricacao'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+32, 57, JsonEtq.GetValue<String>('vencimento'), 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+32, 74, Repl(' ',6-Length(pQuant.ToString))+pQuant.ToString, 0, False);

//Fornecedor - Pedido
        ImprimirCaixa(Lin+39, 5, 95, 17, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+40,  7, 'Documento', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+40, 45, 'Data', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+43,  7, JsonEtq.GetValue<String>('documentonr'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+43, 45, JsonEtq.GetValue<String>('data'), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+48, 7, 'Fornecedor', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+51, 7, Copy(JsonEtq.GetValue<String>('fantasia'), 1, 60), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+57, 7, 'Picking', 0, False);
        ImprimirTexto(orNormal, 4, 3, 4, Lin+60, 7, EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, 72, 82, 'eXactWMS®', 0, False);
//DESATIVAR PARA BRASIL
        if Pos('BRASIL', UpperCase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa)) <= 0 then Begin
           if (vTipoEtiqueta = 'F') Then // JsonEtq.GetValue<Integer>('tipoetiqueta') = 1 then
              ImprimirTexto(orNormal, 2, 2, 2, 73, 10, 'Fracionados', 0, False)
           Else
              ImprimirTexto(orNormal, 2, 2, 2, 73, 10, 'Cxa.Fechada', 0, False);
        End;
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
      End;
    Except On E: Exception do Begin
      ShowErro('Erro: Problema de comunicação com impressora...'+#13+E.Message);
      End;
    End;
  End;
Begin
  for xJsonEtq := 0 to Pred(pJsonArray.Count) do Begin
    //Caixa Fechada
    for EtqCxaFechada := 1 to pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdcxafechada') do Begin
      vTipoEtiqueta := 'C'; //Caixa Fechada
      PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('fatorconversao'));
    End;
    //Fracionados
    if pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada') > 0 then Begin
       vTipoEtiqueta := 'F'; //Caixa Fracionada
       PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada'));
    End;
  End;
end;

procedure TFrmEntrada.PrintTagArmazenagem8x10etqPpla(pJsonArray: TJsonArray);
Var xJsonEtq, xEtq, EtqCxaFechada : Integer;
    vTipoEtiqueta : String;
  Procedure PrintEtq(JsonEtq : TJsonObject; pQuant : Integer);
  Var Lin, EtqPrint : Integer;
      vEndereco     : String;
  Begin
    Try
      ACBrETQConfig.DPI           := TACBrETQDPI(0);
      ACBrETQConfig.Temperatura   := vTemperatura;
      With ACBrETQConfig do Begin
        Ativar;
        IniciarEtiqueta;
        Lin := 72;
        ImprimirTexto(orNormal, 3, 1, 1, Lin-2,   7, JsonEtq.GetValue<String>('zona'), 0, True);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-6,   7, 'Impressão:', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-6,  23, DateToStr(Date())+ ' '+Copy(TimeToStr(Time()), 1, 5)+'h', 0, False);
        ImprimirBarras(orNormal, barCODE128, 3,   2, Lin-7, 60, JsonEtq.GetValue<String>('codproduto'), 8, becNAO);
        ImprimirTexto(orNormal, 2, 1, 2, Lin-12, 65, JsonEtq.GetValue<String>('codproduto'), 0, False);
//Produto               R     C   W    H
        ImprimirCaixa(Lin-31, 5, 915, 345, 2, 2);   //LIn = 40
        //ImprimirCaixa(Lin-33, 5, 915, 360, 2, 2);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-12, 7, 'Produto', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-15, 7, Copy(JsonEtq.GetValue<String>('descricao'), 1, 60), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-17, 7, COpy(JsonEtq.GetValue<String>('descricao'), 61, 40), 0, False);
        //Lin = 47
        ImprimirTexto(orNormal, 2, 1, 1, Lin-25,  7, 'Lote', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-25, 37, 'Fabricação', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-25, 57, 'Vencimento', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin-25, 80, 'Quantidade', 0, False);
        //Lin = 42
        ImprimirTexto(orNormal, 2, 2, 1, Lin-30,  7, JsonEtq.GetValue<String>('descrlote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin-30, 37, JsonEtq.GetValue<String>('fabricacao'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin-30, 57, JsonEtq.GetValue<String>('vencimento'), 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin-30, 70, Repl(' ',6-Length(pQuant.ToString))+pQuant.ToString, 0, False);
//Fornecedor - Pedido
        //Lin
        ImprimirCaixa(Lin-50, 5, 915, 185, 2, 2); //40
        ImprimirTexto(orNormal, 2, 1, 1, Lin-35,  7, 'Documento', 0, False); //Lin=37
        ImprimirTexto(orNormal, 2, 1, 1, Lin-35, 45, 'Data', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin-40,  7, EdtDocumentoNr.Text, 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin-40, 45, EdtDocumentoData.Text, 0, False); //Lin = 32

        ImprimirTexto(orNormal, 2, 1, 1, Lin-44, 7, 'Fornecedor', 0, False); //28
        ImprimirTexto(orNormal, 2, 1, 2, Lin-49, 7, Copy(LblFornecedor.Caption, 1, 60), 0, False); //Lin =26

        //Lin = 32
        ImprimirTexto(orNormal, 2, 1, 1, Lin-54, 7, 'Picking', 0, False);
        ImprimirTexto(orNormal, 4, 2, 2, Lin-64, 7, EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True), 0, False);

//DESATIVAR PARA BRASIL
        if Pos('BRASIL', UpperCase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa)) <= 0 then Begin
           if (vTipoEtiqueta = 'F') Then // JsonEtq.GetValue<Integer>('tipoetiqueta') = 1 then
              ImprimirTexto(orNormal, 2, 2, 2, 2, 10, 'Fracionados', 0, False)
           Else
              ImprimirTexto(orNormal, 2, 2, 2, 2, 10, 'Cxa.Fechada', 0, False);
        End;
        ImprimirTexto(orNormal, 2, 1, 1, 1, 82, 'eXactWMS®', 0, False);
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
      End;
    Except On E: Exception do Begin
      ShowErro('Erro: Problema de comunicação com impressora...'+#13+E.Message);
      End;
    End;
  End;
Begin
  for xJsonEtq := 0 to Pred(pJsonArray.Count) do Begin
    //Caixa Fechada
    for EtqCxaFechada := 1 to pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdcxafechada') do Begin
      vTipoEtiqueta := 'C'; //Caixa Fechada
      PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('fatorconversao'));
    End;
    //Fracionados
    if pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada') > 0 then Begin
       vTipoEtiqueta := 'F'; //Caixa Fracionada
       PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada'));
    End;
  End;
end;

procedure TFrmEntrada.RbDevolucaoClick(Sender: TObject);
begin
  inherited;
  if RbDevolucao.Checked then
     Label26.Caption := 'Motivo da Devolução'
  Else Label26.Caption := 'Motivo da Segregação';
  CbLotesDevSeg.ItemIndex := -1;
  if RbDevolucao.Checked then Begin

  End
  Else
  Begin

  End;
end;

procedure TFrmEntrada.ReturnEntradalote;
begin
  EmptyKeyQueue;
  keybd_event(VK_F2, 0, 0, 0);
  PnlCheckIn.Enabled := True;
  EdtDtFabricacao.SetFocus;
  PnlAutorizarAltLoteHide;
end;

procedure TFrmEntrada.ReturnFinalizarEntrada;
var jsonObjEnt, jsonObjEntItem : TJSONObject;
    jsonArrayEntItem           : TJSONArray;
    xEntItens                  : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTITUIR OBJENTRADACTRL
//14Nov23
  jsonObjEnt := TJSONObject.Create;
  With jsonObjEnt do Begin
    AddPair('pedido', TJSONNumber.Create(StrToIntDef(EdtEntradaId.Text, 0)));
    AddPair('operacaoid', TJSONNumber.Create(FdMemEntrada.FieldByName('OperacaoTipoId').AsInteger));
    AddPair('operacaodescricao', FdMemEntrada.FieldByName('OperacaoTipo').AsString);
    AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMs.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    AddPair('terminal', NomeDoComputador);
  End;
  // Itens...
  jsonArrayEntItem := TJSONArray.Create;
  jsonObjEnt.AddPair('itens', jsonArrayEntItem);
  Try
  If ObjEntradaCtrl.FinalizarCheckIn(jsonObjEnt) then Begin
     GetListaEntrada(0);
     BtnFinalizarCheckIn.Enabled := True;
     BtnFinalizarCheckIn.Visible := False;
     BtnCancelarCheckIn.Visible := False;
     Application.MessageBox('Finalização Concluída.', 'Finalizar CheckIn', MB_ICONINFORMATION+MB_OK);
  End
  Else Begin
     ShowErro('Não foi possível Finalizar o CheckIn!');
     BtnFinalizarCheckIn.Enabled := True;
  End;
  Except On E: Exception do Begin
     ShowErro('Erro: '+E.Message);
     BtnFinalizarCheckIn.Enabled := True;
     End;
  End;
  //Linhas abaixo alteradas em 23/02/2023
  //jsonObjEnt.Free;
  jsonObjEnt     := Nil;
  jsonObjEntItem := Nil;
  jsonArrayEntItem.Free;
end;

procedure TFrmEntrada.ReturnValidaShelfLife;
begin
  EmptyKeyQueue;
  keybd_event(VK_F2, 0, 0, 0);
  PnlCheckIn.Enabled := True;
  EdtQtdUnidPrimCheckIn.SetFocus;
  PnlAutorizarAltLoteHide;
end;

procedure TFrmEntrada.PreencherListaItens;
Var xLista : Integer;
   ObjProduto      : TProduto;
   vSKU, vCheckIn : Integer;
   ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTIUTIR OBJENTRADACTRL
//14Nov23
  vSKU     := 0;
  vCheckIn := 0;
  AdvSGItensEntrada.FilterActive := False;
  if AdvSGItensEntrada.RowCount > 1 then Begin
     AdvSGItensEntrada.RemoveRows(1, AdvSGItensEntrada.RowCount-1);
     AdvSGItensEntrada.RowCount := 1;
  End;
  If ObjEntradaCtrl.Entrada.Itens.Count >= 1 then Begin
     AdvSGItensEntrada.RowCount  := ObjEntradaCtrl.Entrada.Itens.Count+1;
     AdvSGItensEntrada.FixedRows := 1;
  End;
  for xLista := 1 to AdvSGItensEntrada.RowCount - 1 do Begin
    AdvSGItensEntrada.AddDataImage(12, xLista, 2, haCenter, vaTop);
    AdvSGItensEntrada.AddDataImage(13, xLista, 4, haCenter, vaTop);
  End;
  For xLista := 0 To ObjEntradaCtrl.Entrada.Itens.Count-1 do begin
    With ObjEntradaCtrl.Entrada.Itens[xLista] do Begin
      ObjProduto := GetProduto(ProdutoLotes.Lotes.ProdutoId.ToString());
      AdvSGItensEntrada.Cells[0, xLista+1]  := entradaitemid.ToString();
      AdvSGItensEntrada.Cells[1, xLista+1]  := ObjProduto.CodProduto.ToString();  //Lote.ProdutoId.ToString();
      AdvSGItensEntrada.Cells[2, xLista+1]  := ObjProduto.Descricao;
{
       if ProdutoLotes.Lotes.DescrLote <> 'SL' then begin
          AdvSGItensEntrada.Cells[3, xLista+1]  := ProdutoLotes.Lotes.DescrLote;
          AdvSGItensEntrada.Cells[4, xLista+1]  := DateToStr(ProdutoLotes.Lotes.Fabricacao);
          AdvSGItensEntrada.Cells[5, xLista+1]  := DateToStr(ProdutoLotes.Lotes.Vencimento);
       End
       Else Begin
          AdvSGItensEntrada.Cells[3, xLista+1]  := '';
          AdvSGItensEntrada.Cells[4, xLista+1]  := '';
          AdvSGItensEntrada.Cells[5, xLista+1]  := '';
       End;
}
      AdvSGItensEntrada.Cells[7, xLista+1]  := QtdXML.ToString();
      vSKU := vSKU + QtdXML;
      AdvSGItensEntrada.Cells[ 8, xLista+1]  := QtdCheckIn.ToString();
      AdvSGItensEntrada.Cells[ 9, xLista+1]  := QtdSegregada.ToString();
      AdvSGItensEntrada.Cells[10, xLista+1]  := QtdDevolvida.ToString();

      if (QtdCheckIn+QtdSegregada+QtdDevolvida) >= QtdXML then Begin
         AdvSGItensEntrada.Colors[ 8, xLista+1] := ClGreen;
         AdvSGItensEntrada.Colors[ 9, xLista+1] := ClGreen;
         AdvSGItensEntrada.Colors[10, xLista+1] := ClGreen;
      End
      Else if (QtdCheckIn+QtdSegregada+QtdDevolvida) = 0 then Begin
         AdvSGItensEntrada.Colors[ 8, xLista+1] := ClWhite;
         AdvSGItensEntrada.Colors[ 9, xLista+1] := ClWhite;
         AdvSGItensEntrada.Colors[10, xLista+1] := ClWhite;
      End
      Else Begin
         AdvSGItensEntrada.Colors[ 8, xLista+1] := clYellow;
         AdvSGItensEntrada.Colors[ 9, xLista+1] := clYellow;
         AdvSGItensEntrada.Colors[10, xLista+1] := clYellow;
      End;

      if QtdXML > 0 then
         AdvSGItensEntrada.Cells[11, xLista+1] := IntToStr(QtdXML-(QtdCheckIn+Qtdsegregada+QtdDevolvida))
      Else AdvSGItensEntrada.Cells[11, xLista+1] := '0';
      AdvSGItensEntrada.Cells[12, xLista+1] := '2';
    //AdvSGItensEntrada.AddDataImage(11, xLista+1, 3, haCenter,vaTop);
      vCheckIn := vCheckIn + (QtdCheckIn+Qtdsegregada+QtdDevolvida);
      //ObjProduto := Nil;
    End;
    AdvSGItensEntrada.Alignments[0, xLista+1] := taRightJustify;
    AdvSGItensEntrada.FontStyles[0, xLista+1] := [FsBold];
    AdvSGItensEntrada.Alignments[ 1, xLista+1] := taRightJustify;
    AdvSGItensEntrada.Alignments[ 6, xLista+1] := taCenter;
    AdvSGItensEntrada.Alignments[ 7, xLista+1] := taCenter;
    AdvSGItensEntrada.Alignments[ 8, xLista+1] := taRightJustify;
    AdvSGItensEntrada.Alignments[ 8, xLista+1] := taRightJustify;
    AdvSGItensEntrada.Alignments[ 9, xLista+1] := taRightJustify;
    AdvSGItensEntrada.Alignments[10, xLista+1] := taRightJustify;
    AdvSGItensEntrada.Alignments[11, xLista+1] := taRightJustify;
  end;
  AdvSGItensEntrada.SortSettings.Column := 1;
  AdvSGItensEntrada.QSort;
  LblResItens.Caption := (AdvSGItensEntrada.RowCount-1).ToString();
  LblResSKU.Caption   := vSku.ToString();
  LblResCheckIn.Caption := vCheckIn.ToString();
  if (ObjEntradaCtrl.Entrada.Status in [0, 1]) and (ObjEntradaCtrl.Entrada.ProcessoId <> 31)then Begin
     if vCheckIn = 0 then
        StatusEntrada := StRecebido // LblResEstado.Caption := 'Recebido'
     else If vCheckIn < vSKU then
        StatusEntrada := StCheckIn //LblResEstado.Caption := 'Em CheckIn'
     else If (vSKU - vCheckIn) = 0 then
        StatusEntrada := StFinalizacao; // LblResEstado.Caption := 'Finalização';
     SetStatusEntrada;
     if ((vSKU - vCheckIn) = 0) and (PnlCheckIn.Visible) then
        BtnVoltarClick(BtnVoltar);
     BtnStartCheckIn.Visible    := ((vSKU - vCheckIn) > 0) and (Not PnlCheckIn.Visible) and (ObjEntradaCtrl.Entrada.Itens.Count>0);
     BtnFinalizarCheckIn.Visible := (Not BtnStartCheckIn.Visible) and (StatusEntrada = StFinalizacao); //and (ObjEntradaCtrl.Entrada.Status <> 3);
     BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible or BtnFinalizarCheckIn.Visible); //and (ObjEntradaCtrl.Entrada.Status <> 3);
     PnlBtnCheckIn.Visible      := BtnStartCheckIn.Visible;
  End
  Else Begin
    if ObjEntradaCtrl.Entrada.Status in [2, 4] then
       LblResEstado.Caption := 'Finalizado'
    else If ObjEntradaCtrl.Entrada.Status = 3 then
       LblResEstado.Caption := 'Documento Cancelado';
    BtnStartCheckIn.Visible    := False;
    BtnFinalizarCheckIn.Visible := False;
    BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible or BtnFinalizarCheckIn.Visible);
    PnlBtnCheckIn.Visible      := False;
  End;
//  AdvGLItensEntrada.Invalidate;
end;

Function TFrmEntrada.SalvarCheckAPI(pLote : String; pFabricacao, pVencimento : TDateTime;
         pQtdCheckIn, pQtdDevolvida, pQtdSegregada, pCausaId : Integer) : Boolean;
var JsonPedido, JsonProdutoLote : TJSONObject;
    JsonArrayItens              : TJSONArray;
    jsonRetorno                 : TJsonObject;
    vErro : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  inherited;
  Result := False;
  JsonArrayItens := TJSONArray.Create;
  JsonPedido := TJSONObject.Create;
  With JsonPedido do Begin
    AddPair('pedido', TJSONNumber.Create(StrToIntDef(EdtEntradaId.Text, 0)));
    AddPair('operacaoid', TJSONNumber.Create(FdMemEntrada.FieldByName('OperacaoTipoId').AsInteger));
    AddPair('operacaodescricao', FdMemEntrada.FieldByName('OperacaoTipo').AsString);
  End;
  // Itens...
  JsonProdutoLote := TJSONObject.Create;
  With JsonProdutoLote do Begin
    AddPair('produtoid',     TJsonNumber.Create(FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger));
    AddPair('descrlote',     pLote);
    AddPair('fabricacao',    DateToStr(pFabricacao));
    AddPair('vencimento',    DateToStr(pVencimento));
    AddPair('dtentrada',     DateToStr(Now()));
    AddPair('hrentrada',     TimeToStr(Time()));
    AddPair('qtdxml',        tJSONNumber.Create(FdMemEntradaProduto.FieldByName('QtdXml').AsInteger));
    AddPair('qtdcheckin',    tJSONNumber.Create(pQtdCheckIn));
    AddPair('qtddevolvida',  tJSONNumber.Create(pQtdDevolvida));
    AddPair('qtdsegregada',  tJSONNumber.Create(pQtdSegregada));
    AddPair('causaid',       tJSONNumber.Create(pCausaId));
    AddPair('usuarioid',     tJSONNumber.Create(FrmeXactWMS.ObjusuarioCtrl.ObjUsuario.UsuarioId));
    AddPair('respaltloteid', tJSONNumber.Create(ObjUsuarioAltLoteCtrl.ObjUsuario.Usuarioid));
    AddPair('terminal',      NomeDoComputador);
    vRespAltLoteId := 0;
  End;
  JsonArrayItens.AddElement(JsonProdutoLote);
  JsonPedido.AddPair('itens', JsonArrayItens);
  //Pegar Retorno e Analisar
  ObjEntradaCtrl := TEntradaCtrl.Create;
  jsonRetorno    := ObjEntradaCtrl.SalvarCheckInItem(0, JsonPedido);
  if JsonRetorno.TryGetValue<String>('Erro', vErro) then Begin
     Result := False;
     ShowErro('Erro: '+JsonRetorno.GetValue<String>('Erro'));
  End
  Else
     Result := True;
  JsonProdutoLote := Nil;
  JsonArrayItens  := Nil;
  JsonPedido.Free;
end;

procedure TFrmEntrada.SalvarCheckInItemOLD(xItem, pCausaId : Integer);
var jsonObjEnt, jsonObjEntItem : TJSONObject;
    jsonArrayEntItem           : TJSONArray;
    jsonRetorno                : TJsonObject;
    vErro : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  inherited;
(*  jsonObjEnt := TJSONObject.Create;
  With jsonObjEnt do Begin
    AddPair('pedido', TJSONNumber.Create(StrToIntDef(EdtEntradaId.Text, 0)));
    AddPair('operacaoid', TJSONNumber.Create(ObjEntradaCtrl.Entrada.OperacaoTipo.OperacaoTipoId));
    AddPair('operacaodescricao', ObjEntradaCtrl.Entrada.OperacaoTipo.Descricao);
  End;
  // Itens...
  jsonArrayEntItem := TJSONArray.Create;
  if (ObjEntradaCtrl.Entrada.Itens[xItem].QtdCheckIn+
     ObjEntradaCtrl.Entrada.Itens[xItem].QtdDevolvida+
     ObjEntradaCtrl.Entrada.Itens[xItem].QtdSegregada) > 0 then Begin
     jsonObjEntItem := TJSONObject.Create;
     With jsonObjEntItem do Begin
       AddPair('entradaitemid', tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].EntradaItemId));
       AddPair('produtoid',     tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Produto.IdProduto));
       AddPair('loteid',        tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.LoteId));
       AddPair('descrlote',     ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.DescrLote);
       AddPair('fabricacao',    DateToStr(ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.Fabricacao));
       AddPair('vencimento',    DateToStr(ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.Vencimento));
       AddPair('dtentrada',     DateToStr(ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.dtentrada));
       AddPair('hrentrada',     TimeToStr(ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.hrentrada));
       AddPair('qtdxml',        tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].QtdXml));
       AddPair('qtdcheckin',    tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].QtdCheckIn));
       AddPair('qtddevolvida',  tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].QtdDevolvida));
       AddPair('qtdsegregada',  tJSONNumber.Create(ObjEntradaCtrl.Entrada.Itens[xItem].QtdSegregada));
       AddPair('causaid',       tJSONNumber.Create(pCausaId));
       AddPair('usuarioid',     tJSONNumber.Create(FrmeXactWMS.ObjusuarioCtrl.ObjUsuario.UsuarioId));
       AddPair('respaltloteid', tJSONNumber.Create(ObjUsuarioAltLoteCtrl.ObjUsuario.Usuarioid));
       AddPair('terminal',      NomeDoComputador);
       vRespAltLoteId := 0;
     End;
     jsonArrayEntItem.AddElement(jsonObjEntItem);
  End;
  jsonObjEnt.AddPair('itens', jsonArrayEntItem);
  //Pegar Retorno e Analisar
  ObjEntradaCtrl := TEntradaCtrl.Create;
  jsonRetorno    := ObjEntradaCtrl.SalvarCheckInItem(0, jsonObjEnt);
  if not jsonRetorno.TryGetValue<String>('Erro', vErro) then Begin
     ObjEntradaCtrl.Entrada.Itens[xItem].EntradaItemId := jsonRetorno.GetValue<Integer>('pedidoitemid');
     ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.LoteId := jsonRetorno.GetValue<Integer>('loteid');
     jsonArrayEntItem.Free;
     ObjEntradaCtrl.Free;
     //JsonObjEnt.Free;
  End
  Else Begin
    //jsonRetorno := Nil;
    jsonArrayEntItem.Free;
    ObjEntradaCtrl.Free;
    //JsonObjEnt.Free;
    raise Exception.Create('Ocorreu um erro ao salvar o item!'+#13+#10+#13+#10+
                           jsonRetorno.GetValue<String>('Erro'));
  End;
*)
end;

function TFrmEntrada.SalvarReg: Boolean;
Var ObjEntradaCtrl   : TEntradaCtrl;
begin
  Result := False;
  if (ExistDevolutionSegregation) and (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Finalizar com Devolução e Segregado')) then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  FdMemEntrada.FieldByName('EntradaId').AsInteger      := StrToInt(EdtEntradaId.Text);
  FdMemEntrada.FieldByName('OperacaoTipoId').AsInteger := CbOperacaoTipo.ItemIndex;
  FdMemEntrada.FieldByName('DocumentoNr').AsString     := EdtDocumentoNr.Text;
  FdMemEntrada.FieldByName('DocumentoData').AsDateTime := StrToDate(EdtDocumentoData.Text);
  FdMemEntrada.FieldByName('PessoaId').AsInteger       := StrToIntDef(EdtPessoaId.Text, 0);
  Result := ObjEntradaCtrl.Salvar;
  if Result then ObjEntradaCtrl.Entrada.EntradaId := 0;
end;

Function TFrmEntrada.SaveItemCheckIn : Boolean;
Var X : Integer;
    vLoteNovo : Boolean;
    ObjEntradaItensCtrl : TEntradaitensCtrl;
    vLote, vLote2 : String;
    vFabricacao, vVencimento : TDate;
    vQtdCheckIn, vQtdDevolvida, vQtdSegregada, xTeste : Integer;
    xCount : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  Result := False;
  Try
    if CbRastroTipo.ItemIndex < 0 then  Begin
       CbRastroTipo.SetFocus;
       Exit
    End;
    if CbRastroTipo.ItemIndex = 0 then  Begin
       vLote       := 'SL';
       vFabricacao := Now();
       vVencimento := now()+(360*10);
    End
    Else If (CbRastroTipo.ItemIndex = 1) or (CbRastroTipo.ItemIndex = 2) then  Begin
       if (CbRastroTipo.ItemIndex = 2) and (EdtDtFabricacao.Text = '  /  /    ') then Begin
          EdtDtFabricacao.SetFocus;
          ShowErro('Informe a data de Fabricação!');
          Exit;
       End;
       if (EdtDtVencimento.Text = '  /  /    ') then Begin
          EdtDtVencimento.SetFocus;
          ShowErro('Informe a data de Vencimento!');
          Exit;
       End;
       if CbRastroTipo.ItemIndex = 1 then
          vLote  := Copy(EdtDtVencimento.Text, 9, 2)+Copy(EdtDtVencimento.Text, 4, 2)+Copy(EdtDtVencimento.Text, 1, 2)
       Else
          vLote  := EdtLoteCheckIn.Text;
       vFabricacao := StrToDate(EdtDtFabricacao.Text);
       vVencimento := StrToDate(EdtDtVencimento.Text);
    End
    Else Begin
       vLote       := 'SL';
       vFabricacao := Now();
       vVencimento := now()+(360*10);
    End;
    ValidarUpdateProduto; //Salvar Cubagem do Produto;
    If (Not SalvarCheckAPI(vLote, vFabricacao, vVencimento,
                              Trunc(EdtQtdTotCheckIn.Value), //Qtde.Checkin
                              0, 0, //Qtde. Devolvida e Segregada
                              0)) then Begin
       Result := False;
       Exit;
    End;
    ImgSaveCheckIn.Enabled := True;
    LblSaveCheckIn.Enabled := True;
    ClearEditCheckIn;
    AtivarEditCheckIn;
    EdtProdutoCheckIn.Clear;
    If PnlCheckIn.Visible then EdtProdutoCheckIn.SetFocus;
    GetListaEntradaItens;
    If FdMemEntrada.FieldByName('ProcessoId').AsInteger < 4 then Begin
       FdMemEntrada.Edit;
       FdMemEntrada.FieldByName('ProcessoId').AsInteger := 4;
       FdMemEntrada.Post;
    End;
//    if FdMemEntrada.FieldByName('ProcessoId').AsInteger <> 4 then
//       ObjEntradaCtrl.RegistrarDocumentoEtapa(4);
    Result := True;
  Except On E: Exception do Begin
    Result := False;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

Function TFrmEntrada.SaveItemCheckInOLD : Boolean;
Var X : Integer;
    vLoteNovo : Boolean;
    ObjEntradaItensCtrl : TEntradaitensCtrl;
    vLote, vLote2 : String;
    vFabricacao, vVencimento : TDate;
    vQtdCheckIn, vQtdDevolvida, vQtdSegregada, xTeste : Integer;
    xCount : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTITUIR OJBENTRADACTRL
//14Nov23
(*  Result := False;
  Try
    if FdMemEntrada.FieldByName('RastroId').AsInteger = 1 then  Begin
       vLote       := 'SL';
       vFabricacao := Now();
       vVencimento := now()+(360*10);
    End
    Else If FdMemEntrada.FieldByName('RastroId').AsInteger in [2,3] then  Begin
      if FdMemEntrada.FieldByName('RastroId').AsInteger = 2 then
         vLote  := Copy(EdtDtVencimento.Text, 9, 2)+Copy(EdtDtVencimento.Text, 4, 2)+Copy(EdtDtVencimento.Text, 1, 2)
      Else
         vLote  := EdtLoteCheckIn.Text;
      vFabricacao := StrToDate(EdtDtFabricacao.Text);
      vVencimento := StrToDate(EdtDtVencimento.Text);
    End
    Else Begin
       vLote       := 'SL';
       vFabricacao := Now();
       vVencimento := now()+(360*10);
    End;
    for X := 0 to Pred(ObjEntradaCtrl.Entrada.Itens.Count) do With ObjEntradaCtrl.Entrada.Itens[X] do Begin
      vLoteNovo := True;
      vLote2 :=  ProdutoLotes.Lotes.DescrLote;
      If (ObjEntradaCtrl.Entrada.Itens[X].ProdutoLotes.Produto.IdProduto = ObjProdutoCheckIn.IdProduto) and
         (ProdutoLotes.Lotes.DescrLote = vLote) then Begin
             xTeste := ObjEntradaCtrl.Entrada.Itens[x].EntradaItemId;
             ProdutoLotes.Produto.SNGPC       := ChkSNGPCCheckIn.Checked;
             ProdutoLotes.Produto.Endereco.EnderecoId := 0; //Buscar o Codigo do Endereço de Picking - GetEndereco
             ProdutoLotes.Produto.Peso        := Trunc(EdtPesoCheckIn.Value);
             ProdutoLotes.Produto.Altura      := Trunc(EdtAlturaCheckIn.Value);
             ProdutoLotes.Produto.Largura     := Trunc(EdtLarguraCheckIn.Value);
             ProdutoLotes.Produto.Comprimento := Trunc(EdtComprimentoCheckIn.Value);
             ProdutoLotes.Lotes.Fabricacao := vFabricacao;
             ProdutoLotes.Lotes.Vencimento := vVencimento;
             ProdutoLotes.Lotes.DtEntrada  := Now();
             //o Tipo Adicional ou Ultimo lancamento deve ser verificado no SQL
             {if FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInItem = 0 then
                QtdCheckIn := QtdCheckIn + Trunc(EdtQtdTotCheckIn.Value)
             Else
                QtdCheckIn      := Trunc(EdtQtdTotCheckIn.Value);}
             vQtdCheckIn   := QtdCheckIn;
             vQtdDevolvida := QtdDevolvida;
             vQtdSegregada := QtdSegregada;
             QtdCheckIn      := Trunc(EdtQtdTotCheckIn.Value);
             QtdDevolvida    := 0;
             QtdSegregada    := 0;
             vLoteNovo       := False;
             SalvarCheckInItem(X, 0); //Posicao do Item no Objeto ObjEntradaCtrl.Entrada.Itens
             QtdCheckIn   := vQtdCheckIn + Trunc(EdtQtdTotCheckIn.Value);
             QtdDevolvida := vQtdDevolvida;
             QtdSegregada := vQtdSegregada;
             Break;
      End;
    End;
    if vLoteNovo then Begin
       ObjEntradaItensCtrl := TEntradaItensCtrl.Create;
       ObjEntradaItensCtrl.EntradaItens.Create;
       ObjProdutoCheckIn.SNGPC       := ChkSNGPCCheckIn.Checked;
       ObjProdutoCheckIn.Endereco.EnderecoId := 0; //Buscar o Codigo do Endereço de Picking - GetEndereco
       ObjProdutoCheckIn.Peso        := Trunc(EdtPesoCheckIn.Value);
       ObjProdutoCheckIn.Altura      := Trunc(EdtAlturaCheckIn.Value);
       ObjProdutoCheckIn.Largura     := Trunc(EdtLarguraCheckIn.Value);
       ObjProdutoCheckIn.Comprimento := Trunc(EdtComprimentoCheckIn.Value);
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Produto := ObjProdutoCheckIn;
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Lotes.ProdutoId  := ObjProdutoCheckIn.IdProduto;
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Lotes.CodigoERP  := ObjProdutoCheckIn.CodProduto;
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Lotes.DescrLote  := vLote;
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Lotes.Fabricacao := vFabricacao;
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Lotes.Vencimento := vVencimento;
       ObjEntradaItensCtrl.EntradaItens.ProdutoLotes.Lotes.DtEntrada  := Now();
       ObjEntradaItensCtrl.EntradaItens.QtdCheckIn      := Trunc(EdtQtdTotCheckIn.Value);
       ObjEntradaItensCtrl.EntradaItens.QtdDevolvida    := 0;
       ObjEntradaItensCtrl.EntradaItens.QtdSegregada    := 0;
       ObjEntradaCtrl.Entrada.Itens.Add(ObjEntradaItensCtrl.EntradaItens); //Verificar se deveria incluir apenas o lote no produto ou permanecer incluindo um novo item(Produto)
       SalvarCheckInItem(ObjEntradaCtrl.Entrada.Itens.Count-1, 0);
    End;
    ImgSaveCheckIn.Enabled := True;
    LblSaveCheckIn.Enabled := True;
    ClearEditCheckIn;
    AtivarEditCheckIn;
    EdtProdutoCheckIn.Clear;
    If PnlCheckIn.Visible then EdtProdutoCheckIn.SetFocus;
    xCount :=ObjEntradaCtrl.Entrada.Itens.Count;
    GetListaEntradaItens;
    if ObjEntradaCtrl.Entrada.ProcessoId <> 4 then
       ObjEntradaCtrl.RegistrarDocumentoEtapa(4);
    Result := True;
  Except On E: Exception do Begin
    Result := False;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
*)
end;

procedure TFrmEntrada.SbBtnCancelarAgrupamentoClick(Sender: TObject);
begin
  inherited;
  EdtCodFornecedorGroup.Clear;
  LimparNotasGroup;
end;

procedure TFrmEntrada.SbBtnSalvarAgrupamentoClick(Sender: TObject);
Var AgrupamentojsonArray : TjsonArray;
    xNotas           : integer;
    RetornoJsonArray : TjsonArray;
    vErro            : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  inherited;
  if Confirmacao('Salvar', 'Cofirma o agrupamento?', true) then Begin
     AgrupamentojsonArray := TJsonArray.Create;
     for xNotas := 0 to Pred(LstNotasGroup.RowCount) do Begin
       if LstNotasGroup.Cells[4, xNotas] = '1' then Begin
          AgrupamentojsonArray.AddElement(TJsonObject.Create.AddPair('pedidoid', TJsonNumber.Create(StrToInt(LstNotasGroup.Cells[0, xNotas])))
                                                            .AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMs.ObjUsuarioCtrl.ObjUsuario.UsuarioId))
                                                            .AddPair('terminal', NomeDoComputador)
                                                            .AddPair('data', DateToStr(Date()))
                                                            .AddPair('hora', TimeToStr(Time()))
                                                            .AddPair('status', TJsonNumber.Create(1))  );
       End;
     End;
     if AgrupamentoJsonArray.Count < 2 then
        ShowErro('Para o agrupamento é necessário mais de uma nota!')
     Else Begin
        ObjEntradaCtrl   := TEntradaCtrl.Create;
        RetornoJsonArray := ObjEntradaCtrl.SalvarAgrupamento(AgrupamentojsonArray);
        if RetornoJsonArray.TryGetValue('Erro', vErro) then
           ShowErro(vErro)
        Else Begin
          EdtCodFornecedorGroup.Clear;
          LimparNotasGroup;
          ShowOk('Agrupamento salvo com sucesso!');
          GetAgrupamentoLista(0, 0);
        End;
     End;
     RetornoJsonArray := Nil;
     AgrupamentoJsonArray.Free;
     ObjEntradaCtrl.Free;
  End;
end;

procedure TFrmEntrada.SetCampoRastro;
begin
  EdtDtFabricacao.TabStop := True;
  GbItemLote.Enabled      := True;
  EdtLoteCheckIn.clear;
  EdtDtFabricacao.Clear;
  EdtDtVencimento.Clear;
  case CbRastroTipo.ItemIndex Of
    0: Begin
         GbItemLote.Enabled := False;
         EdtQtdUnidPrimCheckIn.SetFocus;
         GbItemLote.Enabled := False;
       End;
    1: Begin
         EdtLoteCheckIn.Enabled  := False;
         EdtDtFabricacao.Enabled := False;
         EdtDtFabricacao.TabStop := False;
         EdtDtVencimento.SetFocus;
       End;
    2: Begin
         EdtLoteCheckin.Enabled  := True;
         EdtDtFabricacao.Enabled := True;
         EdtDtVencimento.Enabled := True;
         EdtLoteCheckIn.SetFocus
       End;
  end;
end;

procedure TFrmEntrada.SetStatusEntrada;
begin
  if FdMemEntrada.FieldByName('Status').AsInteger <> 3 then Begin
//     ObjEntradaCtrl.Entrada.Status := Ord(StatusEntrada);
  End;
  if TStatusEntrada(FdMemEntrada.FieldByName('Status').AsInteger) = StRecebido Then LblResEstado.Caption := 'Recebido'
  else If TStatusEntrada(FdMemEntrada.FieldByName('Status').AsInteger) = StCheckIn Then LblResEstado.Caption := 'Em CheckIn'
  else If TStatusEntrada(FdMemEntrada.FieldByName('Status').AsInteger) = StFinalizacao Then LblResEstado.Caption := 'Finalização'
  Else LblResEstado.Caption := 'Concluído';
end;

procedure TFrmEntrada.ShowDados;
Var JsonArrayRetorno : TJsonArray;
    vDataHora, vErro : String;
begin
  inherited;
  StatusEntrada := TStatusEntrada(FdMemEntrada.FieldByName('Status').AsInteger);
  With FdMemEntrada do Begin
//    EdtEntradaId.Text        := FdMemEntrada.FieldByName('PedidoId').AsString;
    CbOperacaoTipo.ItemIndex    := CbOperacaoTipo.Items.IndexOf(FdMemEntrada.FieldByName('OperacaoTipo').AsString);
    EdtDocumentoNr.Text         := FdMemEntrada.FieldByName('DocumentoNr').AsString;
    EdtDocumentoData.Text       := FdMemEntrada.FieldByName('DocumentoData').AsString;
    EdtPessoaId.Text            := FdMemEntrada.FieldByName('CodPessoaERP').AsString;
    LblFornecedor.Caption       := FdMemEntrada.FieldByName('Fantasia').AsString;
    vDataHora := DateEUAtoBr(Copy(FdMemEntrada.FieldByName('Recebido').AsString, 1, 10));
    vDataHora := vDataHora+' '+Copy(FdMemEntrada.FieldByName('Recebido').AsString, 12, 8)+'h';
    LblResRecebido.Caption      := vDataHora;
    vDataHora := DateEUAtoBr(Copy(FdMemEntrada.FieldByName('CheckInInicio').AsString, 1, 10));
    vDataHora := vDataHora+' '+Copy(FdMemEntrada.FieldByName('CheckInInicio').AsString, 12, 8)+'h';
    if FdMemEntrada.FieldByName('CheckInInicio').AsString <> '' then
       LblResInicioCheckIn.Caption := vDataHora;
    vDataHora := DateEUAtoBr(Copy(FdMemEntrada.FieldByName('CheckInTermino').AsString, 1, 10));
    vDataHora := vDataHora+' '+Copy(FdMemEntrada.FieldByName('CheckInTermino').AsString, 12, 8)+'h';
    if FdMemEntrada.FieldByName('CheckInTermino').AsString <> '' then
       LblResEncCheckIn.Caption    := vDataHora;
    vDataHora := DateEUAtoBr(Copy(FdMemEntrada.FieldByName('Finalizado').AsString, 1, 10));
    vDataHora := vDataHora+' '+Copy(FdMemEntrada.FieldByName('Finalizado').AsString, 12, 8)+'h';
    if FdMemEntrada.FieldByName('Finalizado').AsString <> '' then
       LblResFinalizado.Caption    := vDataHora;
    vDataHora := DateEUAtoBr(Copy(FdMemEntrada.FieldByName('DevolvidoERP').AsString, 1, 10));
    vDataHora := vDataHora+' '+Copy(FdMemEntrada.FieldByName('DevolvidoERP').AsString, 12, 8)+'h';
    if FdMemEntrada.FieldByName('DevolvidoERP').AsString <> '' then
       LblResIntegracaoERP.Caption := vDataHora;
    LblProcesso.Caption         := FdMemEntrada.FieldByName('Processo').AsString;
    pAgrupamentoId              := FdMemEntrada.FieldByName('AgrupamentoId').AsInteger;
  End;
end;

procedure TFrmEntrada.BtnSalvarDevolucaoSegregadoClick(Sender: TObject);
Var xProdLotes : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
    vQtdDevolucao, vQtdSegregada : Integer;
    vCodMotivoDevSeg : Integer;
begin
  inherited;
  if CbLotesDevSeg.ItemIndex < 0 then begin
     if RbDevolucao.Checked then
        raise Exception.Create('Selecione o Lote que deseja Devolver.')
     Else raise Exception.Create('Selecione o Lote que deseja Segregar.');
  end;
  if CbMotivo.ItemIndex < 0 then
     raise Exception.Create('Informe o motivo da operação.');
  if EdtQtdeDevSeg.Value <= 0 then
     raise Exception.Create('Informe uma quantidade válida.');
  FDMemSegregadoCausa.First;
  If FDMemSegregadoCausa.Locate('Descricao', CbMotivo.Items.Strings[CbMotivo.ItemIndex], []) then
     vCodMotivoDevSeg := FDMemSegregadoCausa.FieldByName('segregadocausaid').AsInteger
  Else Begin
     CbMotivo.SetFocus;
     raise Exception.Create('Motivo Inválido!');
  End;
  vQtdDevolucao := 0;
  vQtdSegregada := 0;
  if RbDevolucao.Checked then
     vQtdDevolucao := StrToInt64Def(EdtQtdeDevSeg.Text, 0) //ObjEntradaCtrl.Entrada.Itens[xProdLotes].QtdDevolvida := StrToIntDef(EdtQtdeDevSeg.Text, 0)
  Else
     vQtdSegregada := StrToInt64Def(EdtQtdeDevSeg.Text, 0); //ObjEntradaCtrl.Entrada.Itens[xProdLotes].QtdSegregada := StrToIntDef(EdtQtdeDevSeg.Text, 0);
  If (Not SalvarCheckAPI(CbLotesDevSeg.Text, StrToDate(EdtFabricacaoDevSeg.Text), StrToDate(EdtVencimentoDevSeg.Text),
                            0, //Qtde.Checkin
                            vQtdDevolucao, vQtdSegregada, //Qtde. Devolvida e Segregada
                            vCodMotivoDevSeg)) then Begin
     Exit;
  End
  Else Begin
     ClearEditDevSeg;
     //PreencherListaItens;
     GetListaEntradaItens
  End;
end;

procedure TFrmEntrada.SpbBtnCancelarCheckInClick(Sender: TObject);
Var ObjEntradaItensCtrl : TEntradaItensCtrl;
    xLista : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTITUIR OBJENTRADACTRL
//14Nov23
  if pAgrupamentoId <> 0 then Begin
     ShowErro('Operação não permitida. Recebimento pertence ao Agupramento: '+pAgrupamentoId.ToString);
     Exit;
  End;
  inherited;
  With TFrmConfirmacao.Create(Self) do Try
    Mensag1.Caption := 'Cancelar CheckIn?';
    Mensag2.Caption := 'Os Itens já conferidos serão perdidos!';
    ImgOk.Visible   := True;
    If ShowModal = MrOk Then Begin
       ObjEntradaItensCtrl := TEntradaItensCtrl.Create;
       If ObjEntradaItensCtrl.DelCheckIn(FdMemEntrada.FieldByName('PedidoId').AsInteger, 0) Then
          GetListaEntradaItens;
       ObjEntradaItensCtrl.Free;

{       for xLista := 0 to ObjEntradaCtrl.Entrada.Itens.Count-1 do Begin
         ObjEntradaCtrl.Entrada.Itens[xLista].QtdCheckIn   := 0;
         ObjEntradaCtrl.Entrada.Itens[xLista].QtdDevolvida := 0;
         ObjEntradaCtrl.Entrada.Itens[xLista].QtdSegregada := 0;
         AdvSGItensEntrada.Cells[8, xLista+1] := '0';
         AdvSGItensEntrada.Cells[9, xLista+1] := '0';
         AdvSGItensEntrada.Cells[10, xLista+1] := '0';
         AdvSGItensEntrada.Cells[11, xLista+1] := AdvSGItensEntrada.Cells[6, xLista+1];
       End;
       PreencherListaItens;
}    End;
  Finally
    Free;
  end;
end;

procedure TFrmEntrada.SpbBtnDivergenciaClick(Sender: TObject);
begin
  inherited;
  if (Assigned(FrmRelEspelhoEntrada) = False) then
     FrmRelEspelhoEntrada := TFrmRelEspelhoEntrada.Create(Application);
  try
    FrmRelEspelhoEntrada.pCallDirect := False;
    if Sender = BtnEspelho then Begin
       FrmRelEspelhoEntrada.Module       := 'Entrada';
       FrmRelEspelhoEntrada.ModuleMenu   := 'Espelho';//+#39+'s';
       FrmRelEspelhoEntrada.pDivergencia := 0;
    End
    Else Begin
       FrmRelEspelhoEntrada.Module     := 'Entrada';
       FrmRelEspelhoEntrada.ModuleMenu := 'Divergência em CheckIn';//+#39+'s';
       FrmRelEspelhoEntrada.pDivergencia := 1;
    End;
    FrmRelEspelhoEntrada.Show;
    FrmRelEspelhoEntrada.EdtEntradaId.Text := EdtEntradaId.Text;
    FrmRelEspelhoEntrada.BtnPesquisarStandClick(BtnPesquisarStand);
  except on e: Exception do
    begin
      FreeAndNil(FrmRelEspelhoEntrada);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmEntrada.SpbBtnEspelhoClick(Sender: TObject);
begin
  inherited;
  if (Assigned(FrmRelEspelhoEntrada) = False) then
     FrmRelEspelhoEntrada := TFrmRelEspelhoEntrada.Create(Application);
  try
    FrmRelEspelhoEntrada.pCallDirect := False;
    if Sender = SpbBtnEspelho then Begin
       FrmRelEspelhoEntrada.Module       := 'Entrada';
       FrmRelEspelhoEntrada.ModuleMenu   := 'Espelho';//+#39+'s';
       FrmRelEspelhoEntrada.pDivergencia := 0;
    End
    Else Begin
       FrmRelEspelhoEntrada.Module     := 'Entrada';
       FrmRelEspelhoEntrada.ModuleMenu := 'Divergência em CheckIn';//+#39+'s';
       FrmRelEspelhoEntrada.pDivergencia := 1;
    End;
    FrmRelEspelhoEntrada.Show;
    FrmRelEspelhoEntrada.EdtEntradaId.Text := EdtEntradaId.Text;
    FrmRelEspelhoEntrada.BtnPesquisarStandClick(BtnPesquisarStand);
  except on e: Exception do
    begin
      FreeAndNil(FrmRelEspelhoEntrada);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmEntrada.SpbBtnExcluirPedidoClick(Sender: TObject);
Var pJsonCancelar : TJsonObject;
Var xPedido, xPedSelecionado : Integer;
    JsonArrayEntrada   : TJsonArray;
    JsonArrayRetorno   : TJsonArray;
    JsonObjectPedido   : TJsonObject;
    vErro : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  if StrToIntDef(EdtEntradaId.Text, 0) <= 0 then Begin
     ShowErro('Pesquisa o documento antes de Excluir.');
     EdtEntradaId.SetFocus;
     Exit;
  End
  Else if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimentos - Excluir Pre-Entrada') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  With TFrmConfirmacao.Create(Self) do Try
    Mensag1.Caption := 'Cancelar CheckIn';
    Mensag2.Caption := 'Os Itens já conferidos serão perdidos!';
    ImgOk.Visible   := True;
    If ShowModal = MrOk Then Begin
       JsonArrayEntrada  := TJsonArray.Create;
       JsonObjectPedido := TJsonObject.Create;
       JsonObjectPedido.AddPair('pedidoid', TJsonNumber.Create(FdMemEntrada.FieldByName('PedidoId').AsInteger));
       JsonObjectPedido.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
       JsonObjectPedido.AddPair('terminal', NomeDoComputador);
       JsonArrayEntrada.AddElement(JsonObjectPedido);
       ObjEntradaCtrl   := TEntradaCtrl.Create;
       JsonArrayRetorno := ObjEntradaCtrl.ExcluirPreEntrada(JsonArrayEntrada);
       If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
          ShowErro('Erro: '+vErro)
       Else Begin
          EdtEntradaId.Clear;
          Limpar;
          ShowOk('Exclusão realizada com sucesso!');
       End;
       JsonArrayEntrada := NIl;
       ObjEntradaCtrl.Free;
    End;
  Finally
    Free;
  end;
end;

procedure TFrmEntrada.SpbBtnIniciarCheckInClick(Sender: TObject);
begin
  if pAgrupamentoId <> 0 then Begin
     ShowErro('Operação não permitida. Recebimento pertence ao Agupramento: '+pAgrupamentoId.ToString);
     Exit;
  End;
  inherited;
  PnlBtnCheckIn.Visible      := False;
  BtnStartCheckIn.Visible    := False;
  BtnCancelarCheckIn.Visible := (BtnStartCheckIn.Visible); //and (ObjEntradaCtrl.Entrada.Status <> 3);
  PnlCheckIn.Visible         := True;
  PnlHeaderEntrada.Enabled   := False;
  EdtQtdTotCheckIn.Enabled   := False;
  EditCheckInRead;
  EdtProdutoCheckIn.Enabled  := False;
  AtivarEditCheckIn;
  EdtProdutoCheckIn.SetFocus;
end;

procedure TFrmEntrada.SpbBtnTagProdutoClick(Sender: TObject);
begin
  inherited;
  if (Assigned(FrmRelTagProduto) = False) then
     FrmRelTagProduto := TFrmRelTagProduto.Create(Application);
  try
    FrmRelTagProduto.Module     := 'Relatórios';
    FrmRelTagProduto.ModuleMenu := 'Produtos - TAG de Controlados';//+#39+'s';
    FrmRelTagProduto.EdtPedidoId.Text := EdtEntradaId.text;
    FrmRelTagProduto.BtnPesquisarStandClick(BtnPesquisarStand);
    FrmRelTagProduto.ShowModal;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelTagProduto);
      raise Exception.Create(e.Message);
    end;
  end;
end;

function TFrmEntrada.StatusCheckInItem(pIdProduto: Integer): TColor;
Var xLista : Integer;
    vQtdXML, vTotCheckIn : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTITUIR OBJENTRADACTRL
//14Nov23
  vQtdXML     := 0;
  vTotCheckIn := 0;
  For xLista := 0 To ObjEntradaCtrl.Entrada.Itens.Count-1 do begin
    With ObjEntradaCtrl.Entrada.Itens[xLista] do Begin
      If ProdutoLotes.Lotes.ProdutoId = pIdProduto then Begin
         vQtdXML     := vQtdXML + QtdXML;
         vTotCheckIn := vTotCheckIn + (QtdCheckIn+QtdSegregada+QtdDevolvida);
      End;
    End;
  End;
  Result := clWhite;
  if vQtdXML = vTotCheckIn then
     Result := clGreen
  else if vTotCheckIn > 0 then
     Result := ClYellow;
end;

procedure TFrmEntrada.TabGroupNotaShow(Sender: TObject);
begin
  inherited;
  GetAgrupamentoLista(0, 0);
end;

procedure TFrmEntrada.TabListagemShow(Sender: TObject);
begin
  inherited;
  CbCampoPesq.ItemIndex := 2;
end;

Function TFrmEntrada.TagProdutoOnOff : Boolean;
Var xProd : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTITUIR OBJENTRADACTRL
//14Nov23
  //0 - Nao Imprimir
  //1 - Todos
  //2 - Por Zona
  //3 - Por Produto/SNGPC
  BtnTagProduto.Visible := False;
  Result                := False;
  BtnTagProduto.Visible := FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 1;
  If FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 2 Then Begin
     FdMemEntradaProduto.First;
     while Not FdMemEntradaProduto.Eof do Begin
       if (FdMemEntradaProduto.FieldByName('Picking').Asstring = '') or
          (FdMemEntradaProduto.FieldByName('SNGPC').AsInteger = 1)then Begin
          BtnTagProduto.Visible := True;
          Result := True;
          Break;
       End;
       FdMemEntradaProduto.Next
     End;
{    For xProd := 0 To Pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
      if (ObjEntradaCtrl.Entrada.Itens[xProd].ProdutoLotes.Produto.Endereco.EnderecoId = 0) or
         (ObjEntradaCtrl.Entrada.Itens[xProd].ProdutoLotes.Produto.Endereco.EnderecamentoZona.ProdutoSNGPC = 1)then Begin
         BtnTagProduto.Visible := True;
         Result := True;
         Break;
      End;
    End;
}  End;
//  BtnTagProduto.Visible :=
  If FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 3 then Begin
     while Not FdMemEntradaProduto.Eof do Begin
       if (FdMemEntradaProduto.FieldByName('SNGPC').AsInteger = 1)then Begin
          BtnTagProduto.Visible := True;
          Result := True;
          Break;
       End;
       FdMemEntradaProduto.Next
     End;
{       For xProd := 0 To Pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
       if ObjEntradaCtrl.Entrada.Itens[xProd].ProdutoLotes.Produto.SNGPC then Begin
          BtnTagProduto.Visible := True;
          Result := True;
          Break;
       End;
     End;
}  End;
end;

function TFrmEntrada.ValidarDivergenciaCheckin: Boolean;
Var xItem : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  Result := True;
  FdMemEntradaProduto.First;
  FdMemEntradaProduto.Filter   := 'QtdDevolvida > 0 or QtdSegregada > 0';
  FdMemEntradaProduto.Filtered := True;
  Result := FdMemEntradaProduto.IsEmpty;
  FdMemEntradaProduto.Filter   := '';
  FdMemEntradaProduto.Filtered := False;
  FdMemEntradaProduto.First;



{  for xItem := 0 to Pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
    if (ObjEntradaCtrl.Entrada.Itens[xItem].QtdDevolvida+ObjEntradaCtrl.Entrada.Itens[xItem].QtdSegregada > 0) then Begin
       if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Finalizar com Devolução e Segregado') then
          Result := False;
       Break;
    End;
  End;
}end;

function TFrmEntrada.ValidarQuantidade: Boolean;
Var ValidarQuantidadeJsonArray : TJsonArray;
    vQtdTotCheckIn, vQtdeErro : Integer;
    vErro : String;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  Result := False;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  ValidarQuantidadeJsonArray := ObjEntradaCtrl.GetValidaQtdCheckIn(StrToIntDef(EdtEntradaId.Text, 0), ObjProdutoCheckIn.CodProduto );
  //vErro := ObjEntradaCtrl.Entrada.EntradaId.ToString;
  if (Not ValidarQuantidadeJsonArray.Items[0].TryGetValue('Erro', vErro)) then Begin
     if ValidarQuantidadeJsonArray.Items[0].GetValue<Integer>('qtdcheckin')+
               StrToInt64Def(EdtQtdTotCheckIn.Text, 0) > FdMemEntradaProduto.FieldByName('QtdXml').AsInteger then begin
        Result := False;
        vQtdeErro := ValidarQuantidadeJsonArray.Items[0].GetValue<Integer>('qtdcheckin');
        EdtProdutoCheckIn.Text := '';
        ClearEditCheckIn;
        ShowErro('Atenção: Atualize a entrada. CheckIn já realizado(Qtde= '+vQtdeErro.ToString()+')!');
        GetListaEntradaItens;
     End
     Else Result := True;
  End
  Else
    Result := True;
  ValidarQuantidadeJsonArray := Nil;
  ObjEntradaCtrl.Free;
end;

procedure TFrmEntrada.ValidarUpdateProduto;
Var ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  If (FdMemEntradaProduto.FieldByName('PesoLiquido').Value = EdtPesoCheckIn.Value) and
     (FdMemEntradaProduto.FieldByName('Altura').Value      = EdtAlturaCheckIn.Value) and
     (FdMemEntradaProduto.FieldByName('Largura').Value     = EdtLarguraCheckIn.Value) and
     (FdMemEntradaProduto.FieldByName('Comprimento').Value = EdtComprimentoCheckIn.Value) and
     (FdMemEntradaProduto.FieldByName('Volume').Value      = EdtVolumeCheckIn.Value) then
      Exit;
  FdMemEntradaProduto.Edit;
  FdMemEntradaProduto.FieldByName('PesoLiquido').Value := EdtPesoCheckIn.Value;
  FdMemEntradaProduto.FieldByName('Altura').Value      := EdtAlturaCheckIn.Value;
  FdMemEntradaProduto.FieldByName('Largura').Value     := EdtLarguraCheckIn.Value;
  FdMemEntradaProduto.FieldByName('Comprimento').Value := EdtComprimentoCheckIn.Value;
  FdMemEntradaProduto.FieldByName('Volume').Value      := EdtVolumeCheckIn.Value;
  FdMemEntradaProduto.Post;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  //Atualizar o Cadastro de Produto com a nova Cubagem
  //Atualização para Integrar com ERP
  JsonArrayRetorno := ObjProdutoCtrl.AtualizarCubagem(FdMemEntradaProduto.FieldByName('CodProduto').AsInteger,
                                                  EdtPesoCheckIn.Value,
                                                  EdtAlturaCheckIn.Value,
                                                  EdtLarguraCheckIn.Value,
                                                  EdtComprimentoCheckIn.Value,
                                                  FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId,
                                                  NomeDoComputador);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Não foi possível salvar a cubagem do Produto!');
  JsonArrayRetorno := Nil;
  ObjProdutoCtrl.Free;
end;

Function TFrmEntrada.VerificarSeLoteExiste;
Var xProdLotes : Integer;
    ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  Result := False;
  ObjEntradaCtrl   := TEntradaCtrl.Create;
  JsonArrayRetorno := ObjEntradaCtrl.GetEntradaLoteCheckIn(FdMemEntrada.FieldByName('PedidoId').AsInteger,
                                                           FdMemEntrada.FieldByName('AgrupamentoId').AsInteger,
                                                           FdMemEntradaProduto.FieldByName('CodProduto').AsInteger);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     for xProdLotes := 0 to Pred(JsonArrayRetorno.Count) do Begin
       if JsonArrayRetorno.Items[xProdLotes].GetValue<String>('lote') = EdtLoteCheckIn.Text then Begin
          Result := True;
          Break;
       End;
     End;
  End;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl.Free;
end;

Function TFrmEntrada.VerifyAutoration : Boolean;
Var xItem         : Integer;
    BlockedAccess : Boolean;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
//SUBSTITUIR OBJENTRADACTRL
//14Nov23
  BlockedAccess := True;
  Result        := False;
  for xItem := 0 to Pred(ObjEntradaCtrl.Entrada.Itens.Count) do Begin
    if (ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Produto.IdProduto=ObjProdutoCheckIn.IdProduto) and
       (ObjEntradaCtrl.Entrada.Itens[xItem].ProdutoLotes.Lotes.DescrLote=EdtLoteCheckIn.Text) then Begin
         BlockedAccess := False;
         Break;
    End;
  End;
  if ((BlockedAccess) and (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimentos - Alteração Lotes'))) and
     ((ObjProdutoCheckIn.Endereco.EnderecoId = 0) or
      ((AutorizarAltLote = poZona) and (ObjProdutoCheckIn.Endereco.EnderecamentoZona.ProdutoSNGPC=1)) or
      ((AutorizarAltLote = poProduto) and (ObjProdutoCheckIn.SNGPC))) then Begin
     SolicitarAutorizacao := poAlteraLote;
     AtivarPanelAutorizacao;
     Result := True;
  End;
end;

procedure TFrmEntrada.ImgVisualizarQtdxMmlClick(Sender: TObject);
begin
  inherited;
  FrmeXactWMS.NewLogIn;
  if Not (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Visualizar Quantidade Recebida(XML) - Recebimentos')) then Begin
     AdvSGItensEntrada.HideColumn( 7);
     AdvSGItensEntrada.HideColumn(11);
  End
  else Begin
    AdvSGItensEntrada.UnHideColumn(7);
    AdvSGItensEntrada.UnHideColumn(11);
  End;
  GetListaEntradaItens;
End;

procedure TFrmEntrada.ImgCancelCheckInClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox('Deseja cancelar o CheckIn desse produto?', 'CheckIn de Produtos', MB_ICONQUESTION + MB_YESNO) = mrYes then Begin
     ClearEditCheckIn;
     AdvSGItensEntrada.Filter.RemoveColumnFilter(1);
     AdvSGItensEntrada.FilterActive := False;
     AtivarEditCheckIn;
     EdtProdutoCheckIn.Clear;
     EdtProdutoCheckIn.SetFocus;
  End;
end;

procedure TFrmEntrada.ImgCancelCheckInMouseEnter(Sender: TObject);
begin
  inherited;
  LblCancelCheckIn.Font.Style := [fsItalic];
end;

procedure TFrmEntrada.ImgCancelCheckInMouseLeave(Sender: TObject);
begin
  inherited;
  LblCancelCheckIn.Font.Style := [];
end;

procedure TFrmEntrada.ImgSaveCheckInClick(Sender: TObject);
Var vMsg : String;
begin
  inherited;
//  if (EdtLoteCheckIn.Text<>'') and (AutorizarAltLote in [poTodos, poZona, poProduto]) then
//      If VerifyAutoration then Exit;
  If Not CalcularQuantidade then Begin
     Exit;
  End;
  vMsg := '';
  if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecarProdutoEntrada = 1) and
     (EdtPickingCheckIn.Text = '') then Begin
     vMsg := 'Necessário endereçar o produto.';
     EdtPickingCheckIn.SetFocus;
  End;
  if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CubagemProdutoEntrada = 1) and
     (EdtVolumeCheckIn.Value <= 0) then
     vMsg := 'Necessário Cubagem do produto.';
  if EdtLarguraCheckIn.Value = 0 then
     vmsg := 'Informe a cubagem do produto.';
  if (CbRastroTipo.ItemIndex = 2) and (Not EdtLoteCheckIn.ReadOnly) and (EdtLoteCheckIn.Text='') then
     raise Exception.Create('Informe o lote do produto.');
  if EdtQtdTotCheckIn.Value <= 0 then
     vMsg := 'Quantidade de itens conferida é inválida.';
  if EdtDtFabricacao.Text = '' then
     vMsg := 'Informe a Data de Fabricação do Lote.';
  if EdtDtVencimento.Text = '' then
     vMsg := 'Informe a Data de Vencimento do Produto.';
  if EdtQtdTotCheckIn.Value <= 0 then
     vMsg := 'Quantidade inválida para esse CheckIn.';
  if ((FdMemEntradaProduto.FieldByName('ProdutoSNGPC').AsInteger = 1) or
     (FdMemEntradaProduto.FieldByName('ZonaSNGPC').AsInteger = 1) or
     (CbRastroTipo.ItemIndex = 2)) and
     (EdtLoteCheckIn.Text='') then Begin
     edtLoteCheckIn.SetFocus;
     vMsg := 'Informe o lote do produto!';
  End;

//  if Not validarQuantidade then Begin
//     ClearEditCheckIn;
//     Exit;
//  End;
  if vmsg <> '' then Begin
     ImgSaveCheckIn.Enabled := True;
     LblSaveCheckIn.Enabled := True;
     ShowErro(vMsg);
  End
  Else if EdtQtdTotCheckIn.Value > 0 then Begin
     If SaveItemCheckIn then Begin
        AtualizaRastreabilidade;
        AdvSGItensEntrada.FilterActive := False;
        ImgSaveCheckIn.Enabled := False;
        LblSaveCheckIn.Enabled := False;
        If PnlCheckIn.Visible then EdtProdutoCheckIn.SetFocus;
     End
     Else
        ShowErro('Não foi possível salvar o CheckIn. tente novamente!');
  End;
end;

procedure TFrmEntrada.ImgSaveCheckInMouseEnter(Sender: TObject);
begin
  inherited;
  LblSaveCheckIn.Font.Style := [fsItalic];
end;

procedure TFrmEntrada.ImgSaveCheckInMouseLeave(Sender: TObject);
begin
  inherited;
  LblSaveCheckIn.Font.Style := [];
end;

end.
