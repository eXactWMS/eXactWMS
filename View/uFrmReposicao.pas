unit uFrmReposicao;

interface

uses
  System.StrUtils, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, FireDAC.Stan.Intf, Vcl.DialogMessage,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.ImageList, Vcl.ImgList, AsgLinks,
  AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid,
  cxPC, Vcl.Mask, JvExMask, JvSpin, JvToolEdit, Generics.Collections, System.Json, Rest.Types
  , PedidoSaidaCtrl, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ,
  JvBaseEdits, dxCameraControl;     //, Service.ReposicaoModelo

type
  TProcessoReposicao = (poNenhum, poGeracao, poIniciada, poFinalizada, poCancelada);
  TReposicaoTipo     = (poRepoNenhum, poRepoDemanda, poRepoCapacidade, poAutomatica, poCorretiva);

  TFrmReposicao = class(TFrmBase)
    Label2: TLabel;
    EdtDtRessuprimento: TJvDateEdit;
    Label11: TLabel;
    EdtreposicaoId: TEdit;
    GroupBox2: TGroupBox;
    EdtProcessoId: TEdit;
    EdtDtReposicao: TJvDateEdit;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    LstReposicaoItens: TAdvStringGrid;
    FDMemReposicaoItens: TFDMemTable;
    FDMemReposicaoItensProdutoId: TIntegerField;
    FDMemReposicaoItensReposicaoId: TIntegerField;
    FDMemReposicaoItensCodProduto: TIntegerField;
    FDMemReposicaoItensDescricao: TStringField;
    FDMemReposicaoItensEnderecoId: TIntegerField;
    FDMemReposicaoItensEnderecoDescricao: TStringField;
    FDMemReposicaoItensZonaId: TIntegerField;
    FDMemReposicaoItensZonaDescricao: TStringField;
    FDMemReposicaoEnderecoColeta: TFDMemTable;
    IntegerField2: TIntegerField;
    FDMemReposicaoEnderecoColetaFatorConversao: TIntegerField;
    FDMemReposicaoEnderecoColetaEmbSec: TIntegerField;
    FDMemReposicaoEnderecoColetaLoteId: TIntegerField;
    FDMemReposicaoEnderecoColetaDescrLote: TStringField;
    FDMemReposicaoEnderecoColetaVencimento: TDateField;
    FDMemReposicaoEnderecoColetaEnderecoId: TIntegerField;
    FDMemReposicaoEnderecoColetaEndereco: TStringField;
    FDMemReposicaoEnderecoColetaZonaId: TIntegerField;
    FDMemReposicaoEnderecoColetaQtde: TIntegerField;
    FDMemReposicaoEnderecoColetaEstoqueTipoId: TIntegerField;
    FDMemReposicaoEnderecoColetaDtEntrada: TDateField;
    FDMemReposicaoEnderecoColetaHrEntrada: TTimeField;
    FDMemReposicaoEnderecoColetaQtdRepo: TIntegerField;
    LstReposicaoEnderecoColeta: TAdvStringGrid;
    Label7: TLabel;
    EdtEnderecoInicial: TEdit;
    BtnPesqEnderecoInicial: TBitBtn;
    EdtEnderecoFinal: TEdit;
    BtnPesqEnderecoFinal: TBitBtn;
    Label8: TLabel;
    Label3: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    LblZona: TLabel;
    FDMemReposicaoItensQtdSuprida: TIntegerField;
    FDMemReposicaoItensDisponivel: TIntegerField;
    FDMemReposicaoItensReabastecer: TIntegerField;
    FDMemReposicaoEnderecoColetaCodProduto: TIntegerField;
    FDMemReposicaoEnderecoColetaEmbalagem: TStringField;
    FDMemReposicaoEnderecoColetaUnidadeSecundariaDescricao: TStringField;
    FDMemReposicaoEnderecoColetaZona: TStringField;
    FDMemReposicaoItensEmbalagem: TStringField;
    FDMemReposicaoItensEmbalagemPadrao: TIntegerField;
    FDMemReposicaoAutomaticaColeta: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField3: TIntegerField;
    StringField1: TStringField;
    IntegerField5: TIntegerField;
    StringField2: TStringField;
    IntegerField6: TIntegerField;
    StringField3: TStringField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    StringField4: TStringField;
    FDMemReposicaoAutomaticaColetaPickingId: TIntegerField;
    FDMemReposicaoAutomaticaColetaPicking: TStringField;
    FDMemReposicaoAutomaticaColetaMascaraPicking: TStringField;
    FDMemReposicaoAutomaticaColetaMascara: TStringField;
    FDMemReposicaoAutomaticaColetaCodProduto: TIntegerField;
    FDMemReposicaoAutomaticaColetaDescrLote: TStringField;
    FDMemReposicaoAutomaticaColetaVencimento: TDateField;
    FDMemReposicaoAutomaticaColetaDemanda: TIntegerField;
    FDMemReposicaoAutomaticaColetaReposicao: TIntegerField;
    FDMemReposicaoAutomatica: TFDMemTable;
    IntegerField4: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField10: TIntegerField;
    StringField5: TStringField;
    IntegerField11: TIntegerField;
    StringField6: TStringField;
    StringField7: TStringField;
    IntegerField12: TIntegerField;
    StringField8: TStringField;
    StringField10: TStringField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    IntegerField17: TIntegerField;
    FDMemReposicaoAutomaticaColetaLoteId: TIntegerField;
    DsReposicaoColeta: TDataSource;
    FdMemReposicaoColeta: TFDMemTable;
    IntegerField13: TIntegerField;
    FdMemReposicaoColetaProdutoId: TIntegerField;
    FdMemReposicaoColetaCodProduto: TIntegerField;
    FdMemReposicaoColetaDescricao: TStringField;
    FdMemReposicaoColetaEmbalagem: TStringField;
    FdMemReposicaoColetaFatorConversao: TIntegerField;
    FdMemReposicaoColetaPickingId: TIntegerField;
    FdMemReposicaoColetaPicking: TStringField;
    FdMemReposicaoColetaMascaraPicking: TStringField;
    FdMemReposicaoColetaEnderecoId: TIntegerField;
    FdMemReposicaoColetaEndereco: TStringField;
    FdMemReposicaoColetaMascara: TStringField;
    FdMemReposicaoColetaZonaId: TIntegerField;
    FdMemReposicaoColetaZona: TStringField;
    FdMemReposicaoColetaLoteId: TIntegerField;
    FdMemReposicaoColetaDescrLote: TStringField;
    FdMemReposicaoColetaVencimento: TDateField;
    FdMemReposicaoColetaDemanda: TIntegerField;
    FdMemReposicaoColetaEstoqueTipoId: TIntegerField;
    FdMemReposicaoColetaReposicao: TIntegerField;
    FdMemReposicaoColetaUsuarioId: TIntegerField;
    FdMemReposicaoColetaNome: TStringField;
    FdMemReposicaoColetaTerminal: TStringField;
    FdMemReposicaoColetaDtColeta: TDateField;
    FdMemReposicaoColetaHrColeta: TStringField;
    FDMemReposicaoProduto: TFDMemTable;
    IntegerField16: TIntegerField;
    IntegerField18: TIntegerField;
    IntegerField19: TIntegerField;
    StringField9: TStringField;
    IntegerField21: TIntegerField;
    StringField12: TStringField;
    StringField13: TStringField;
    IntegerField22: TIntegerField;
    IntegerField23: TIntegerField;
    StringField16: TStringField;
    DsReposicaoProduto: TDataSource;
    FDMemReposicaoProdutoDemanda: TIntegerField;
    FDMemReposicaoProdutoReposicao: TIntegerField;
    TabReposicaoColeta: TcxTabSheet;
    PnlRegistroColeta: TPanel;
    LstRegistroColeta: TAdvStringGrid;
    FdMemReposicaoColetaDisponivel: TIntegerField;
    EdtProcesso: TEdit;
    FDMemReposicaoAutomaticaColetaEstoqueTipoId: TIntegerField;
    PnlTopRegistroColeta: TPanel;
    Label6: TLabel;
    EdtCodProduto: TEdit;
    Label13: TLabel;
    Label9: TLabel;
    EdtEndereco: TEdit;
    LblEndereColeta: TLabel;
    EdtDescrLote: TEdit;
    Label15: TLabel;
    BtnColetaAutomatica: TPanel;
    sImage1: TsImage;
    EdtVencimento: TEdit;
    Label16: TLabel;
    EdtPicking: TEdit;
    EdtZona: TEdit;
    Label14: TLabel;
    EdtProduto: TEdit;
    Label10: TLabel;
    Label12: TLabel;
    EdtEmbalagem: TEdit;
    EdtDemanda: TJvCalcEdit;
    Label17: TLabel;
    EdtDisponivel: TJvCalcEdit;
    Label18: TLabel;
    Label19: TLabel;
    EdtAbastecimento: TJvCalcEdit;
    Bevel2: TBevel;
    Bevel1: TBevel;
    CbTipoReposicao: TComboBox;
    Label5: TLabel;
    BtnProcessarReposicao: TBitBtn;
    GroupBox3: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    EdtRuaInicial: TEdit;
    EdtRuaFinal: TEdit;
    Label23: TLabel;
    EdtPredioInicial: TEdit;
    EdtPredioFinal: TEdit;
    Label24: TLabel;
    EdtNivelInicial: TEdit;
    EdtNivelFinal: TEdit;
    Label25: TLabel;
    EdtAptoInicial: TEdit;
    EdtAptoFinal: TEdit;
    ChkNivelPar: TCheckBox;
    ChkNivelImpar: TCheckBox;
    ChkAptoPar: TCheckBox;
    ChkAptoImpar: TCheckBox;
    ChkPredioPar: TCheckBox;
    ChkPredioImpar: TCheckBox;
    ChkRuaPar: TCheckBox;
    ChkRuaImpar: TCheckBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    TabReposicaoModelo: TcxTabSheet;
    Label32: TLabel;
    EdtModeloId: TEdit;
    Label33: TLabel;
    CbTipoReposicaoModelo: TComboBox;
    GroupBox4: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    LblZonaModelo: TLabel;
    EdtEnderecoInicialModelo: TEdit;
    BtnPesqEndIniModelo: TBitBtn;
    EdtEnderecoFinalModelo: TEdit;
    BtnPesqEndFinalModelo: TBitBtn;
    EdtZonaIdModelo: TEdit;
    BtnPesqZonaModelo: TBitBtn;
    GroupBox5: TGroupBox;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    EdtRuaInicialModelo: TEdit;
    EdtRuaFinalModelo: TEdit;
    EdtPredioInicialModelo: TEdit;
    EdtPredioFinalModelo: TEdit;
    EdtNivelInicialModelo: TEdit;
    EdtNivelFinalModelo: TEdit;
    EdTAptoInicialModelo: TEdit;
    EdTAptoFinalModelo: TEdit;
    ChkNivelParModelo: TCheckBox;
    ChkNivelImparModelo: TCheckBox;
    ChkAptoParModelo: TCheckBox;
    ChkAptoImparModelo: TCheckBox;
    ChkPredioParModelo: TCheckBox;
    ChkPredioImparModelo: TCheckBox;
    ChkRuaParModelo: TCheckBox;
    ChkRuaImparModelo: TCheckBox;
    Label50: TLabel;
    EdtDtModelo: TJvDateEdit;
    DbgEnderecoModelo: TDBGrid;
    LblTotEndereco: TLabel;
    PnlTitModelo: TPanel;
    LblTitModelo: TLabel;
    BtnConferiModelo: TBitBtn;
    FDMemEnderecoModelo: TFDMemTable;
    DsEnderecoModelo: TDataSource;
    FDMemEnderecoModeloEnderecoId: TIntegerField;
    FDMemEnderecoModeloEndereco: TStringField;
    FDMemEnderecoModeloEnderecoFormatado: TStringField;
    FDMemEnderecoModeloProduto: TStringField;
    FDMemEnderecoModeloAltura: TFloatField;
    FDMemEnderecoModeloLargura: TFloatField;
    FDMemEnderecoModeloComprimento: TFloatField;
    FDMemEnderecoModeloVolume: TFloatField;
    FDMemEnderecoModeloCapacidade: TFloatField;
    FDMemEnderecoModeloZona: TStringField;
    FDMemEnderecoModeloQtde: TIntegerField;
    FDMemEnderecoModeloQtdePulmao: TIntegerField;
    DbgModeloPreDefinidos: TDBGrid;
    Label37: TLabel;
    imgAtivo: TImageList;
    FDMemModeloPreDefinido: TFDMemTable;
    DsModeloPreDefido: TDataSource;
    FDMemModeloPreDefinidoReposicaoModeloId: TIntegerField;
    FDMemModeloPreDefinidoData: TDateField;
    FDMemModeloPreDefinidoHora: TTimeField;
    FDMemModeloPreDefinidoTipo: TIntegerField;
    FDMemModeloPreDefinidoZonaId: TIntegerField;
    FDMemModeloPreDefinidoPickingInicial: TStringField;
    FDMemModeloPreDefinidoPickingFinal: TStringField;
    FDMemModeloPreDefinidoRuaInicial: TStringField;
    FDMemModeloPreDefinidoRuaFinal: TStringField;
    FDMemModeloPreDefinidoRuaPar: TIntegerField;
    FDMemModeloPreDefinidoRuaImpar: TIntegerField;
    FDMemModeloPreDefinidoPredioInicial: TStringField;
    FDMemModeloPreDefinidoPredioFinal: TStringField;
    FDMemModeloPreDefinidoPredioImpar: TIntegerField;
    FDMemModeloPreDefinidoPredioPar: TIntegerField;
    FDMemModeloPreDefinidoNivelInicial: TStringField;
    FDMemModeloPreDefinidoNivelFinal: TStringField;
    FDMemModeloPreDefinidoNivelImpar: TIntegerField;
    FDMemModeloPreDefinidoNivelPar: TIntegerField;
    FDMemModeloPreDefinidoAptoInicial: TStringField;
    FDMemModeloPreDefinidoAptoFinal: TStringField;
    FDMemModeloPreDefinidoAptoImpar: TIntegerField;
    FDMemModeloPreDefinidoAptoPar: TIntegerField;
    FDMemModeloPreDefinidoUsuarioId: TIntegerField;
    FDMemModeloPreDefinidoUsuario: TStringField;
    FDMemModeloPreDefinidoTerminal: TStringField;
    FDMemModeloPreDefinidoZona: TStringField;
    FDMemTable1: TFDMemTable;
    IntegerField20: TIntegerField;
    IntegerField24: TIntegerField;
    IntegerField25: TIntegerField;
    StringField11: TStringField;
    IntegerField26: TIntegerField;
    StringField14: TStringField;
    StringField15: TStringField;
    IntegerField27: TIntegerField;
    StringField17: TStringField;
    StringField18: TStringField;
    IntegerField28: TIntegerField;
    IntegerField29: TIntegerField;
    IntegerField30: TIntegerField;
    LblPickingReposicao: TLabel;
    LblPalletColeta: TLabel;
    FDMemEnderecoModeloMascara: TStringField;
    BtnGerarReposicaoPreDefinida: TPanel;
    sImage2: TsImage;
    FDMemModeloPreDefinidoAcao: TIntegerField;
    Label51: TLabel;
    EdtDtPedidoGerarReposicao: TJvDateEdit;
    ChkSelecionarModelo: TCheckBox;
    DsMemReposicaoAutomaticaAfterClose: TDataSource;
    Panel1: TPanel;
    sImage3: TsImage;
    LblObsModeloReposicao: TLabel;
    GroupBox6: TGroupBox;
    Label52: TLabel;
    EdtPercDownMaxPicking: TJvCalcEdit;
    ChkNegativo: TCheckBox;
    Label53: TLabel;
    FDMemDemandaCxaFechada_Saldo: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnPesqEnderecoInicialClick(Sender: TObject);
    procedure BtnPesqEnderecoFinalClick(Sender: TObject);
    procedure EdtEnderecoInicialExit(Sender: TObject);
    procedure EdtEnderecoFinalExit(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnProcessarReposicaoClick(Sender: TObject);
    procedure LstReposicaoItensClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtDtRessuprimentoChange(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdtreposicaoIdExit(Sender: TObject);
    procedure EdtreposicaoIdChange(Sender: TObject);
    procedure LstRegistroColetaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstRegistroColetaDblClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure TabReposicaoColetaShow(Sender: TObject);
    procedure EdtEnderecoEnter(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnColetaAutomaticaClick(Sender: TObject);
    procedure PgcBaseChange(Sender: TObject);
    procedure FDMemEnderecoModeloAfterClose(DataSet: TDataSet);
    procedure BtnConferiModeloClick(Sender: TObject);
    procedure DbgEnderecoModeloDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DbgModeloPreDefinidosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure TabReposicaoModeloShow(Sender: TObject);
    procedure DbgModeloPreDefinidosDblClick(Sender: TObject);
    procedure EdtModeloIdExit(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FDMemReposicaoAutomaticaColetaAfterClose(DataSet: TDataSet);
    procedure FDMemReposicaoAutomaticaAfterClose(DataSet: TDataSet);
    procedure FdMemReposicaoColetaAfterClose(DataSet: TDataSet);
    procedure FDMemReposicaoProdutoAfterClose(DataSet: TDataSet);
    procedure FDMemEnderecoModeloCalcFields(DataSet: TDataSet);
    procedure EdtRuaInicialKeyPress(Sender: TObject; var Key: Char);
    procedure BtnGerarReposicaoPreDefinidaClick(Sender: TObject);
    procedure LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure DbgModeloPreDefinidosCellClick(Column: TColumn);
    procedure ChkSelecionarModeloClick(Sender: TObject);
  private
    { Private declarations }
    ProcessoReposicao : TProcessoReposicao;
    ReposicaoTipo     : TReposicaoTipo;
    vPermitirCancelar, vPermitirExcluir : Boolean;
    Procedure CalcularColeta;
    Procedure MontarListaReposicao;
    Procedure MontaListaColeta(aRow : integer);
    Procedure GetEnderecoColeta(pData : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String);
    Procedure GetReposicaoColeta;
    procedure LimparGrids;
    Function GetListaReposicaoPendente(pDataInicial, pDataFinal : TDateTime; pReposicaoId : Integer) : Boolean;
    Procedure MontaLstCadastro(JsonArrayRetorno : TJsonArray);
    Procedure GetReposicaoProduto;
    Procedure GetReposicaoShow;
    Procedure PosicionaRegistroColeta(aRow : Integer);
    procedure ClearRegistroColeta;
    Procedure SalvarColeta;
    Procedure ColorLst(pRow : Integer);
    Procedure FinalizarColeta; //Enviar para Servidor o Registro da Coleta
    Procedure MarkCheck(pOnOff : Boolean);
    Procedure LimparReposicaoModelo;
    Procedure ShowDadosModelo;
    Procedure GetListaReposicaoModelo;
    Procedure FiltrarEnderecoColeta;
    Procedure GetEstoqueColeta;
    Procedure AplicarFiltroColeta;
    Procedure PreencherCamposReposicao; //Gerar Reposição Automática
    Procedure SelecionarModelo(pSelecionar : Integer);
    Function ReposicaoSelecionada : Integer;
    Procedure DeduzirDemandaCxaFechada(pCodProduto : Integer );
  Protected
    Procedure Limpar; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Procedure ShowDados; OverRide;
    Function DeleteReg : Boolean;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmReposicao: TFrmReposicao;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS, Views.Pequisa.Endereco, Views.Pequisa.EnderecamentoEstruturas,
     Views.Pequisa.EnderecamentoZonas, EnderecoCtrl, EnderecamentoZonaCtrl, EstoqueCtrl;

procedure TFrmReposicao.AplicarFiltroColeta;
Var vRuaEnd, vPredioEnd, vNivelEnd, vAptoEnd : Integer;
begin
  FDMemReposicaoAutomaticaColeta.First;
  while Not FDMemReposicaoAutomaticaColeta.Eof do Begin
    vRuaEnd    := StrtoIntDef(Copy(FDMemReposicaoAutomaticaColeta.FieldByName('Endereco').AsString,1,2), 0);
    vPredioEnd := StrtoIntDef(Copy(FDMemReposicaoAutomaticaColeta.FieldByName('Endereco').AsString,3,2), 0);
    vNivelEnd  := StrtoIntDef(Copy(FDMemReposicaoAutomaticaColeta.FieldByName('Endereco').AsString,5,2), 0);
    vAptoEnd   := StrtoIntDef(Copy(FDMemReposicaoAutomaticaColeta.FieldByName('Endereco').AsString,7,3), 0);
    if (vRuaEnd =0) or
       (((EdtRuaInicial.Text='') or ((EdtRuaInicial.Text <> '') and (vRuaEnd >= StrToIntDef(EdtRuaInicial.Text, 0)))) and
        ((EdtRuaFinal.Text='')   or ((EdtRuaFinal.Text <> '')   and (vRuaEnd <= StrToIntDef(EdtRuaFinal.Text, 0)))) And
        ((((vRuaEnd Mod 2) = 0) and (ChkRuaPar.Checked)) or (((vRuaEnd Mod 2) = 1) and (ChkRuaImpar.Checked))) and
        ((EdtPredioInicial.Text='') or ((EdtPredioInicial.Text <> '') and (vPredioEnd >= StrToIntDef(EdtPredioInicial.Text, 0)))) and
        ((EdtPredioFinal.Text='')   or ((EdtPredioFinal.Text <> '')   and (vPredioEnd <= StrToIntDef(EdtPredioFinal.Text, 0)))) And
        ((((vPredioEnd Mod 2) = 0) and (ChkPredioPar.Checked)) or (((vPredioEnd Mod 2) = 1) and (ChkPredioImpar.Checked))) and
        ((EdtNivelInicial.Text='')  or ((EdtNivelInicial.Text <> '')  and (vNivelEnd >= StrToIntDef(EdtNivelInicial.Text, 0)))) and
        ((EdtNivelFinal.Text='')    or ((EdtNivelFinal.Text <> '')    and (vNivelEnd <= StrToIntDef(EdtNivelFinal.Text, 0)))) And
        ((((vNivelEnd Mod 2) = 0) and (ChkNivelPar.Checked)) or (((vNivelEnd Mod 2) = 1) and (ChkNivelImpar.Checked))) and
        ((EdtAptoInicial.Text='')   or ((EdtAptoInicial.Text <> '')   and (vAptoEnd >= StrToIntDef(EdtAptoInicial.Text, 0)))) and
        ((EdtAptoFinal.Text='')     or ((EdtAptoFinal.Text <> '')     and (vAptoEnd <= StrToIntDef(EdtAptoFinal.Text, 0)))) And
        ((((vAptoEnd Mod 2) = 0) and (ChkAptoPar.Checked)) or (((vAptoEnd Mod 2) = 1) and (ChkAptoImpar.Checked))) ) Then
       FDMemReposicaoAutomaticaColeta.Next
    Else
       FDMemReposicaoAutomaticaColeta.Delete;
  End;
end;

procedure TFrmReposicao.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  BtnProcessarReposicao.Enabled := BtnCancelar.Enabled;
end;

procedure TFrmReposicao.BtnEditarClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabReposicaoModelo then begin
     inherited;
     TabPrincipal.TabVisible       := False;
     TabReposicaoModelo.TabVisible := True;
     PgcBase.ActivePage            := TabReposicaoModelo;
     EdtEnderecoInicialModelo.SetFocus;
     BtnConferiModelo.Enabled      := True;
     LblObsModeloReposicao.Visible := True;
  end
  Else Begin
     inherited;
     BtnProcessarReposicao.Enabled := True;
  End;
end;

procedure TFrmReposicao.BtnExcluirClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then
     inherited
  Else Begin
     If (TsImage(sender).Enabled=False) or (TsImage(sender).Grayed) then Exit;
     if EdtModeloId.Text = '' then
        raise Exception.Create('Você deve selecionar um modelo de pré-disponível.');
      if (ConfirmaManutencao('Del')) and (DeleteReg) then Begin
         LimparReposicaoModelo;
         MessageDlg('Modelo Excluído com sucesso.', mtConfirmation, [MbOk], 0);
      End;
  End;
end;

procedure TFrmReposicao.BtnGerarReposicaoPreDefinidaClick(Sender: TObject);
Var ObjReposicaoCtrl       : TPedidoSaidaCtrl;
    JsonArrayReposicao     : TJsonArray;
    JsonArrayDemandaColeta : TJsonArray;
    JsonObjectReposicao    : TJsonObject;
    vErro                  : String;
    vModeloId, vReposicaoGerada       : Integer;
    vTotalReposicaoErro : Integer;
begin
  if EdtDtPedidoGerarReposicao.Text = '  /  /    ' then Begin
     ShowErro('Informe a data dos Pedidos para Gerar a(s) Reposição.');
     Exit;
  End;
  inherited;
  if ReposicaoSelecionada <= 0 then Begin
     ShowErro('Selecione pelo menos 1 modelo para calcular.');
     Exit;
  End;
  if Confirmacao('Reposição Automática.', 'Deseja Calcular '+ReposicaoSelecionada().ToString+' reposição?', True) then Begin
     ProcessoReposicao := poGeracao;
     vReposicaoGerada := 0;
     fdmemModeloPreDefinido.First;
     while Not fdmemModeloPreDefinido.Eof do Begin
       //Preencher Campos
       EdtDtRessuprimento.Text := EdtDtPedidoGerarReposicao.Text;
       CbTipoReposicao.ItemIndex := 1;
       if fdmemModeloPreDefinido.FieldByName('Acao').AsInteger = 1 then Begin
          PreencherCamposReposicao;
          TDialogMessage.ShowWaitMessage('Processando Modelo ('+fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsString+'). Calculando a coleta...',
            procedure
            Var xDemanda, xDisponivel, xRecnoDem : Integer;
            begin
              ObjReposicaoCtrl   := TPedidoSaidaCtrl.Create;
              JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoDemanda(StrToDate(EdtDtRessuprimento.Text),
                                    StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text, 'A');
              //Demanda Cxa.Fechada X Estoque Disponível nos Pallet
              if Not JsonArrayReposicao.Items[0].TryGetValue<String>('Erro', vErro) then Begin
                 If FDMemDemandaCxaFechada_Saldo.Active then
                    FDMemDemandaCxaFechada_Saldo.EmptyDataSet;
                 FDMemDemandaCxaFechada_Saldo.Close;
                 FDMemDemandaCxaFechada_Saldo.LoadFromJson(JsonArrayReposicao, False);
                 //Buscar Endereço para Coleta dos produtos que precisam de Reposição
                 JsonArrayDemandaColeta := ObjReposicaoCtrl.GetReposicaoDemandaColeta('A');
                 if Not JsonArrayDemandaColeta.Items[0].TryGetValue<String>('Erro', vErro) then Begin
                    If FDMemReposicaoAutomaticaColeta.Active then
                       FDMemReposicaoAutomaticaColeta.EmptyDataSet;
                    FDMemReposicaoAutomaticaColeta.Close;
                    FDMemReposicaoAutomaticaColeta.LoadFromJson(JsonArrayDemandaColeta, False);

                    //Calcular Onde e Quanto pegar em cada Pallet
                    FiltrarEnderecoColeta;
                    //if FDMemReposicaoAutomaticacoleta.Locate('CodProduto',  31152, []) then Begin
                    //   xDemanda := FDMemReposicaoAutomaticacoleta.FieldByName('Demanda').AsInteger;
                    //   xDisponivel := FDMemReposicaoAutomaticacoleta.FieldByName('Disponivel').AsInteger;
                    //End;
                    xRecnoDem := FDMemReposicaoAutomaticacoleta.RecordCount;
                    FDMemReposicaoAutomaticacoleta.First;
                    FDMemReposicaoAutomaticacoleta.Filter := 'Disponivel>0';
                    FDMemReposicaoAutomaticacoleta.Filtered := True;
                    xRecnoDem := FDMemReposicaoAutomaticacoleta.RecordCount;
                    JsonObjectReposicao := TJsonObject.Create;
                    JsonObjectReposicao.AddPair('reposicaoid', TJsonNumber.Create(StrToIntDef(EdtReposicaoId.Text, 0)));
                    JsonObjectReposicao.AddPair('dtressuprimento', EdtDtRessuprimento.Text);
                    JsonObjectReposicao.AddPair('reposicaotipo', TJsonNumber.Create(Ord(ReposicaoTipo)));
                    JsonObjectReposicao.AddPair('zonaid', TJsonNumber.Create(StrToIntDef(EdtZonaId.Text, 0)));
                    JsonObjectReposicao.AddPair('enderecoinicial', EdtEnderecoInicial.Text);
                    JsonObjectReposicao.AddPair('enderecofinal', EdtEnderecoFinal.Text);
                    JsonObjectReposicao.AddPair('processoid', TJsonNumber.Create(Ord(ProcessoReposicao)));
                    JsonObjectReposicao.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
                    JsonObjectReposicao.AddPair('terminal', NomeDoComputador );
                    JsonObjectReposicao.AddPair('reposicaomodeloid', TJsonNumber.Create(fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsInteger));
                    JsonObjectReposicao.AddPair('coleta', FDMemReposicaoAutomaticacoleta.ToJSONArray());
                    vModeloId := fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsInteger;
                    If (FDMemReposicaoAutomaticacoleta.IsEmpty()) then
                       ShowMSG('Sem Estoque para coleta do modelo('+fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsString+') de Reposição!')
                    Else If (Not ObjReposicaoCtrl.SalvarReposicao(JsonObjectReposicao)) then Begin
                       ShowErro('Erro: Modelo('+fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsString+') de Reposição não foi salvo!');
                       Inc(vTotalReposicaoErro);
                    End
                    Else
                       Inc(vReposicaoGerada);
                    FDMemReposicaoAutomaticacoleta.Filter   := 'Disponivel>0';
                    FDMemReposicaoAutomaticacoleta.Filtered := False;
                 End;
              End
              Else Begin
                 TThread.Synchronize(nil, procedure
                 begin
                   ShowERRO('Modelo de Reposição '+fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsString+'. Recalcule! '+vErro);
                 End);
                 Inc(vTotalReposicaoErro);
              End;
            End);
       End;
       fdmemModeloPreDefinido.Next;
     End;
     if vTotalReposicaoErro > 0 then
        ShowOk('Concluído. Gerado: '+vReposicaoGerada.ToString+' Reposição.   '+vTotalReposicaoErro.ToString()+' com Erro(s).')
     Else
        ShowOk('Concluído. Gerado: '+vReposicaoGerada.ToString+' Reposição.');
  End;
end;

procedure TFrmReposicao.BtnIncluirClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabReposicaoModelo then begin
     inherited;
     TabPrincipal.TabVisible         := False;
     TabReposicaoModelo.TabVisible   := True;
     PgcBase.ActivePage              := TabReposicaoModelo;
     EdtModeloId.Enabled             := False;
     CbTipoReposicaoModelo.Enabled   := False;
     EdtDtModelo.Text                := DateToStr(Now());
     EdtDtModelo.ReadOnly            := True;
     CbTipoReposicaoModelo.ItemIndex := 1;
     if EdtZonaIdModelo.Visible then
        EdtZonaIdModelo.SetFocus
     Else
        EdtEnderecoInicialModelo.SetFocus;
     MarkCheck(True);
     BtnConferiModelo.Enabled      := True;
     LblObsModeloReposicao.Visible := True;
  end
  Else
  Begin
     inherited;
     EdtReposicaoId.Enabled := False;
     ProcessoReposicao   := TProcessoReposicao(1);
     EdtProcesso.Text    := 'Geração';
     EdtDtReposicao.Text := DateToStr(Now());
     BtnProcessarReposicao.Enabled := True;
     EdtDtRessuprimento.SetFocus;
     MarkCheck(True);
     TabReposicaoModelo.TabVisible := False;
  End;
end;

procedure TFrmReposicao.BtnPesqEnderecoFinalClick(Sender: TObject);
Var vEnderecoId     : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  if BtnSalvar.Grayed then Exit;
//  inherited;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       if Sender = BtnPesqEnderecoFinal then Begin
          EdtEnderecoFinal.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
          EdtEnderecoFinalExit(EdtEnderecoFinal);
          EdtEnderecoFinal.SetFocus;
       End
       Else if Sender = BtnPesqEndFinalModelo then Begin
          EdtEnderecoFinalModelo.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
          EdtEnderecoFinalExit(EdtEnderecoFinalModelo);
          EdtEnderecoFinalModelo.SetFocus;
       End;
       FreeAndNil(ObjEnderecoCtrl);
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmReposicao.BtnPesqEnderecoInicialClick(Sender: TObject);
Var vEnderecoId : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  if BtnSalvar.Grayed then Exit;
//  inherited;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       if Sender = BtnPesqEnderecoInicial then Begin
          EdtEnderecoInicial.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
          EdtEnderecoInicial.SetFocus;
       End
       Else if Sender = BtnPesqEndIniModelo then Begin
          EdtEnderecoInicialModelo.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
          EdtEnderecoInicialModelo.SetFocus;
       End;
       FreeAndNil(ObjEnderecoCtrl);
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmReposicao.BtnPesquisarStandClick(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    JsonArrayEnderecoColeta : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
    vData            : TDateTime;
    vErro            : String;
    xItens           : Integer;
begin
exit;
  if BtnSalvar.Enabled then Begin
     Try
       If EdtDtRessuprimento.Text = '  /  /    ' then
          vData := 0
       Else vData := StrToDate(EdtDtRessuprimento.Text);
     Except On E: Exception do
       raise Exception.Create('Erro: Data dos ressuprimentos inválida!'+#13+#10+E.Message);
     End;
     JsonArrayRetorno := ObjPedidoCtrl.GetReposicaoGerar(vData, StrTointDef(EdtZonaId.Text, 0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text);
     if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
        ShowErro('😢Erro: '+vErro);
        Player('toast4');
        LstReposicaoItens.ClearRect(0, 1, LstReposicaoItens.ColCount-1, LstReposicaoItens.RowCount-1);
        LstReposicaoItens.RowCount := 1;
     End;
     If FDMemReposicaoItens.Active then
        FDMemReposicaoItens.EmptyDataSet;
     FDMemReposicaoItens.Close;
     FDMemReposicaoItens.LoadFromJson(JsonArrayRetorno, False);
     LstReposicaoItens.RowCount := FdmemReposicaoItens.RecordCount+1;
     for xItens := 1 to FdmemReposicaoItens.RecordCount do begin
       LstReposicaoItens.Cells[0, xItens] := FdMemReposicaoItens.FieldByName('ProdutoId').AsString;
       LstReposicaoItens.Cells[1, xItens] := FdMemReposicaoItens.FieldByName('CodProduto').AsString;
       LstReposicaoItens.Cells[2, xItens] := FdMemReposicaoItens.FieldByName('Descricao').AsString;
       LstReposicaoItens.Cells[3, xItens] := FdMemReposicaoItens.FieldByName('EnderecoDescricao').AsString;
       LstReposicaoItens.Cells[4, xItens] := FdMemReposicaoItens.FieldByName('ZonaDescricao').AsString;
       LstReposicaoItens.Cells[5, xItens] := FdMemReposicaoItens.FieldByName('FatorConversao').AsString;
       LstReposicaoItens.Cells[6, xItens] := FdMemReposicaoItens.FieldByName('QtdReposicao').AsString;
       LstReposicaoItens.Alignments[0, xItens]  := taRightJustify;
       LstReposicaoItens.FontStyles[0, xItens]  := [FsBold];
       LstReposicaoItens.Alignments[5, xItens]  := taRightJustify;
       LstReposicaoItens.Alignments[6, xItens]  := taRightJustify;
       LstReposicaoItens.Alignments[7, xItens]  := taRightJustify;
       FdMemReposicaoItens.Next;
     end;
     //JsonArrayRetorno.DisposeOf;
//Buscar Endereco para Coleta
     //JsonArrayEnderecoColeta := ObjPedidoCtrl.GetReposicaoEnderecoColeta(vData);
     if JsonArrayEnderecoColeta.Get(0).tryGetValue<String>('Erro', vErro) then Begin
        ShowErro('😢Erro: '+vErro);
        Player('toast4');
        LstReposicaoEnderecoColeta.ClearRect(0, 1, LstReposicaoEnderecoColeta.ColCount-1, LstReposicaoEnderecoColeta.RowCount-1);
        LstReposicaoEnderecoColeta.RowCount := 1;
     End;
     If FDMemReposicaoEnderecoColeta.Active then
        FDMemReposicaoEnderecoColeta.EmptyDataSet;
     FDMemReposicaoEnderecoColeta.Close;
     FDMemReposicaoEnderecoColeta.LoadFromJson(JsonArrayEnderecoColeta, False);
     CalcularColeta;
  End
  Else
    inherited;
end;

procedure TFrmReposicao.BtnPesqZonaClick(Sender: TObject);
Var vZonaId       : Integer;
    ObjZonaCtrl   : TEnderecamentoZonaCtrl;
    ArrayJsonZona : TJsonArray;
    vErro         : String;
begin
//  inherited;
  if BtnSalvar.Grayed then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
//       ObjZonaCtrl := TEnderecamentoZonaCtrl.Create();
       vZonaId     := FrmPesquisaEnderecamentoZonas.Tag;
       ArrayJsonZona := ObjZonaCtrl.GetEnderecamentoZonaJson(vZonaId, '', 0);
       if ArrayJsonZona.Items[0].TryGetValue('Erro', vErro) then Begin
          ShowErro(vErro);
          if Sender = BtnPesqZona then
             EdtZonaId.Clear
          Else
             EdtZonaIdModelo.Clear;
       End
       Else Begin
         if Sender = BtnPesqZona then Begin
            EdtZonaId.Text := vZonaId.ToString;
            LblZona.Caption := ArrayJsonZona.Items[0].GetValue<String>('descricao')
         End
         Else Begin
            EdtZonaIdModelo.Text := vZonaId.ToString;
            LblZonaModelo.Caption := ArrayJsonZona.Items[0].GetValue<String>('descricao');
         End;
       End;
       //ObjZonaCtrl.DisposeOf;
       if Sender = BtnPesqZona then
          EdtZonaId.SetFocus
       Else EdtZonaIdModelo.SetFocus;
       ArrayJsonZona := Nil;
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmReposicao.BtnColetaAutomaticaClick(Sender: TObject);
Var xColeta : Integer;
begin
  inherited;
  for xColeta := 1 to Pred(LstRegistroColeta.RowCount) do Begin
    LstRegistroColeta.Cells[10, xColeta] := LstRegistroColeta.Cells[8, xColeta];
    FdMemReposicaoColeta.Recno := xColeta;
    FdMemReposicaoColeta.Edit;
    FdMemReposicaoColeta.FieldByName('Reposicao').Value := LstRegistroColeta.Cells[8, xColeta].ToInteger;
    FdMemReposicaoColeta.FieldByName('UsuarioId').Value := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
    FdMemReposicaoColeta.FieldByName('Nome').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome;
    FdMemReposicaoColeta.FieldByName('Terminal').Value  := NomeDoComputador;
    FdMemReposicaoColeta.FieldByName('DtColeta').Value  := DateToStr(Now());
    FdMemReposicaoColeta.FieldByName('HrColeta').Value  := TimeToStr(Time());
    FdMemReposicaoColeta.Post;
  End;
  FinalizarColeta;
end;

procedure TFrmReposicao.BtnConferiModeloClick(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
    vRuaParImpar,vPredioParImpar : Integer;
    vNivelParImpar,vAptoParImpar : Integer;
begin
  inherited;
//   if ((Sender=EdtEnderecoInicial) and (EdtEnderecoInicial.Text  = '')) or
//      ((Sender=EdtEnderecoInicialModelo) and (EdtEnderecoInicialModelo.Text  = '')) then Exit;
   ObjEnderecoCtrl := TEnderecoCtrl.Create();
   if FDMemEnderecoModelo.Active then
      FDMemEnderecoModelo.EmptyDataSet;
   FDMemEnderecoModelo.Close;
   if (EdtRuaInicial.Text+EdtRuaFinal.Text<>'') and (Not ChkRuaPar.Checked) and (ChkRuaImpar.Checked) then Begin
      ShowErro('Selecione o lado das Ruas');
      EdtRuaInicial.SetFocus;
      Exit;
   End;
   vRuaParImpar    := 2;
   vPredioParImpar := 2;
   vNivelParImpar  := 2;
   vAptoParImpar   := 2;
{   if (ChkRuaPar.Checked) and (ChkRuaImpar.Checked) then
       vRuaParImpar := 2
    Else if (ChkRuaPar.Checked) then
       vRuaParImpar := 0
    Else
       vRuaParImpar := 1;
    if (EdtPredioInicial.Text+EdtPredioFinal.Text<>'') and (Not ChkPredioPar.Checked) and (ChkPredioImpar.Checked) then Begin
       ShowErro('Selecione o lado ds Prédios');
       EdtPredioInicial.SetFocus;
       Exit;
    End;
    if (ChkPredioPar.Checked) and (ChkPredioImpar.Checked) then
       vPredioParImpar := 2
    Else if (ChkRuaPar.Checked) then
       vPredioParImpar := 0
    Else
       vPredioParImpar := 1;
    if (EdtNivelInicial.Text+EdtNivelFinal.Text<>'') and (Not ChkNivelPar.Checked) and (ChkNivelImpar.Checked) then Begin
       ShowErro('Selecione o lado dos Níveis');
       EdtNivelInicial.SetFocus;
       Exit;
    End;
    if (ChkNivelPar.Checked) and (ChkNivelImpar.Checked) then
       vNivelParImpar := 2
    Else if (ChkNivelPar.Checked) then
       vNivelParImpar := 0
    Else
       vNivelParImpar := 1;
    if (EdtAptoInicial.Text+EdtAptoFinal.Text<>'') and (Not ChkAptoPar.Checked) and (ChkAptoImpar.Checked) then Begin
       ShowErro('Selecione o lado dos Apartamentos');
       EdtAptoInicial.SetFocus;
       Exit;
    End;
    if (ChkAptoPar.Checked) and (ChkAptoImpar.Checked) then
       vAptoParImpar := 2
    Else if (ChkAptoPar.Checked) then
       vAptoParImpar := 0
    Else
       vAptoParImpar := 1;
}   JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoToReposicao(StrToIntDef(EdtZonaIdModelo.Text, 0),
                       EdtEnderecoInicialModelo.Text, EdtEnderecoFinalModelo.Text,
                       '', '', vRuaParImpar,
                       '', '', vPredioParImpar,
                       '', '', vNivelParImpar,
                       '', '', vAptoParImpar);
   if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
      if Sender = EdtEnderecoInicial then
         EdtEnderecoInicial.SetFocus
      Else
         EdtEnderecoInicialModelo.SetFocus;
      JsonArrayRetorno := Nil;
      ObjEnderecoCtrl.Free;
      ShowErro('Endereço não encontrado ou estrutura diferente de Picking!');
      FDMemEnderecoModelo.Close;
      Exit;
   End;
   FDMemEnderecoModelo.LoadFromJSON(JsonArrayRetorno, False);
   LblTotEndereco.Caption := 'Picking(s) para repor: '+FDMemEnderecoModelo.RecordCount.ToString();
   JsonArrayRetorno := Nil;
   ObjEnderecoCtrl.Free;
end;

procedure TFrmReposicao.BtnProcessarReposicaoClick(Sender: TObject);
Var ObjReposicaoCtrl   : TPedidoSaidaCtrl;
    JsonArrayReposicao : TJsonArray;
    vErro              : String;
    vDataReposicao     : TDateTime;
begin
  inherited;
  LstReposicaoItens.RowCount          := 1;
  LstReposicaoEnderecoColeta.RowCount := 1;
  if (CbTipoReposicao.ItemIndex > 4) or (CbTipoReposicao.ItemIndex <= 0) then Begin
     ShowErro('Selecione o tipo de reposição.');
     Exit;
  End;
  if (CbTipoReposicao.ItemIndex = 1) and (CbTipoReposicao.ItemIndex < 3) and (EdtDtRessuprimento.Text = '  /  /    ') then Begin
     ShowErro('Informe a data da demanda dos ressuprimentos.');
     Exit;
  End;
  Try
    if (CbTipoReposicao.ItemIndex = 1) and  (EdtDtRessuprimento.Text <> '  /  /    ') then
       StrToDate(EdtDtRessuprimento.Text);
  Except Begin
    ShowErro('Data da demanda dos ressuprimentos é inválida!');
    EdtDtRessuprimento.Clear;
    EdtDtRessuprimento.SetFocus;
    Exit;
    End;
  End;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    begin
      ObjReposicaoCtrl := TPedidoSaidaCtrl.Create;
      if CbTipoReposicao.ItemIndex = 3 then Begin
         if (EdtDtRessuprimento.Text = '  /  /    ') then
            vDataReposicao := 0
         Else
            vDataReposicao := StrToDate(EdtDtRessuprimento.Text);
         JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoAutomatica(vDataReposicao,
                                                StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text,
                                                EdtEnderecoFinal.Text, 0);
      End
      Else if CbTipoReposicao.ItemIndex = 1 then Begin //Demanda  Buscar Produtos que precisam de reposição
         if (EdtDtRessuprimento.Text = '  /  /    ') then begin
            ShowErro('Informe a data dos pedidos para cálculos de reposição de picking!');
            EdtDtRessuprimento.SetFocus;
            ObjReposicaoCtrl.Free;
            Exit;
         End
         Else   //Reposição Por Demanda - Buscar Produtos que precisam de reposição
            vDataReposicao := StrToDate(EdtDtRessuprimento.Text);
         JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoDemanda(StrToDate(EdtDtRessuprimento.Text),
                               StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text, 'M');
      End
      Else if CbTipoReposicao.ItemIndex = 2 then Begin //Demanda-Capacidade  Buscar Produtos que precisam de reposição
         if (EdtPercDownMaxPicking.Value <= 0) then begin
            ShowErro('Percentual da necessidade de Reposição invalido!');
            EdtPercDownMaxPicking.SetFocus;
            ObjReposicaoCtrl.Free;
            Exit;
         End;
//         Else   //Reposição Por Demanda - Buscar Produtos que precisam de reposição
//            vDataReposicao := StrToDate(EdtDtRessuprimento.Text);
         JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoDemandaCapacidade(StrToIntDef(EdtPercDownMaxPicking.Text, 0),
                               StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text, Ord(ChkNegativo.Checked));
      End
      Else
         JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoGerar(StrToDate(EdtDtRessuprimento.Text), StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text);
      if JsonArrayReposicao.Items[0].TryGetValue<String>('Erro', vErro) then Begin
         EdtZonaId.SetFocus;
         JsonArrayReposicao := Nil;
         ObjReposicaoCtrl.Free;
         raise Exception.Create('Não foi possível gerar a reposição.'+#13+vErro);
      End
      Else Begin
         If FDMemDemandaCxaFechada_Saldo.Active then
            FDMemDemandaCxaFechada_Saldo.EmptyDataSet;
         FDMemDemandaCxaFechada_Saldo.Close;
         FDMemDemandaCxaFechada_Saldo.LoadFromJson(JsonArrayReposicao, False);
      End;
      if CbTipoReposicao.ItemIndex in [1, 2, 3] then Begin
         If FDMemReposicaoAutomatica.Active then
            FDMemReposicaoAutomatica.EmptyDataSet;
         FDMemReposicaoAutomatica.Close;
         FDMemReposicaoAutomatica.LoadFromJson(JsonArrayReposicao, False);
         //MontarListaReposicaoAutomatica;
         LblPickingReposicao.Caption := 'Picking para Repor: '+FormatFloat('#0', FDMemReposicaoAutomatica.RecordCount);
         MontarListaReposicao ;
         //GetEnderecoColeta(StrToDate(EdtDtRessuprimento.Text), StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text);
      End
      Else Begin
         If FDMemReposicaoItens.Active then
            FDMemReposicaoItens.EmptyDataSet;
         FDMemReposicaoItens.Close;
         FDMemReposicaoItens.LoadFromJson(JsonArrayReposicao, False);
         MontarListaReposicao;
         GetEnderecoColeta(StrToDate(EdtDtRessuprimento.Text), StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text);
      End;
      JsonArrayReposicao := Nil;
      ObjReposicaoCtrl.Free;
      if CbTipoReposicao.ItemIndex in [1, 2, 3] then  //Buscar os portas Pallet onde deverá ocorrer a coleta
         GetReposicaoColeta;
   End);
end;

procedure TFrmReposicao.BtnSalvarClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then Begin
     if (CbTipoReposicao.ItemIndex<2) and (EdtDtRessuprimento.Text = '  /  /    ') then
        raise Exception.Create('Inforrme a Data dos Ressuprimentos base e mande pesquisa para gerar a reposição.');
     if (LstReposicaoItens.RowCount=1) or (LstReposicaoEnderecoColeta.RowCount=1) then
        raise Exception.Create('É preciso processar/gerar a reposição antes de salvar!');
     inherited;
     BtnProcessarReposicao.Enabled := BtnSalvar.Enabled;
  End
  Else Begin
     if (EdtEnderecoInicialModelo.Text+EdtEnderecoFinalModelo.Text='') then Begin
        ShowErro('Informe a faixa de Picking para reposição!');
        EdtEnderecoInicialModelo.SetFocus;
        Exit;
     End;
     if FDMemEnderecoModelo.IsEmpty then Begin
        ShowErro('Não há endereços para reposição! Click no Botão Conferir para verificar.');
        EdtEnderecoInicialModelo.SetFocus;
        Exit;
     End;
     if ((Not ChkRuaParModelo.Checked) and (Not ChkRuaImparModelo.Checked)) then Begin
        ShowErro('Informe pelo menos Rua Par ou Impar!');
        EdtEnderecoInicialModelo.SetFocus;
        Exit;
     End;
     if ((Not ChkPredioParModelo.Checked) and (Not ChkPredioImparModelo.Checked)) then Begin
        ShowErro('Informe pelo menos um lado Par ou Impar!');
        EdtEnderecoInicialModelo.SetFocus;
        Exit;
     End;
     if ((Not ChkNivelParModelo.Checked) and (Not ChkNivelImparModelo.Checked)) then Begin
        ShowErro('Informe pelo menos um Nível Par ou Impar!');
        EdtEnderecoInicialModelo.SetFocus;
        Exit;
     End;
     if ((Not ChkAptoParModelo.Checked) and (Not ChkAptoImparModelo.Checked)) then Begin
        ShowErro('Informe pelo menos um lado Par ou Impar!');
        EdtEnderecoInicialModelo.SetFocus;
        Exit;
     End;
     inherited;
     PgcBase.ActivePage := TabReposicaoModelo;
  End;
end;

procedure TFrmReposicao.CalcularColeta;
Var vProdutoId, vQtdReposicao, xItens : Integer;
begin
  FDMemReposicaoItens.First;
  While Not FdMemReposicaoItens.Eof do Begin
     vProdutoId    := FdMemReposicaoItens.FieldByName('ProdutoId').AsInteger;
     vQtdReposicao := FdMemReposicaoItens.FieldByName('QtdReposicao').AsInteger;
     FdMemReposicaoEnderecoColeta.Filter   := 'ProdutoId = '+vProdutoId.ToString();
     FdMemReposicaoEnderecoColeta.Filtered := True;
     While (vQtdReposicao>0) and (Not FdMemReposicaoEnderecoColeta.Eof) do Begin
        if vQtdReposicao > FdMemReposicaoEnderecoColeta.FieldByName('Qtde').AsInteger then Begin
           FdMemReposicaoEnderecoColeta.Edit;
           FdMemReposicaoEnderecoColeta.FieldByName('QtdRepo').AsInteger := FdMemReposicaoEnderecoColeta.FieldByName('Qtde').AsInteger;
           vQtdReposicao := vQtdReposicao - FdMemReposicaoEnderecoColeta.FieldByName('Qtde').AsInteger;
           FdMemReposicaoEnderecoColeta.Post;
        End
        Else Begin
           FdMemReposicaoEnderecoColeta.Edit;
           FdMemReposicaoEnderecoColeta.FieldByName('QtdRepo').AsInteger := vQtdReposicao;
           vQtdReposicao := 0;
           FdMemReposicaoEnderecoColeta.Post;
        End;
        FdMemReposicaoEnderecoColeta.Next;
     End;
     FdMemReposicaoEnderecoColeta.Filter   := '';
     FdMemReposicaoEnderecoColeta.Filtered := False;
     FdMemReposicaoItens.Next;
  End;
  FdMemReposicaoEnderecoColeta.First;
  FdMemReposicaoEnderecoColeta.Filter   := 'QtdRepo > 0';
  FdMemReposicaoEnderecoColeta.Filtered := True;
  LstReposicaoEnderecoColeta.RowCount := FDMemReposicaoEnderecoColeta.RecordCount+1;
  for xItens := 1 to FDMemReposicaoEnderecoColeta.RecordCount do begin
    LstReposicaoEnderecoColeta.Cells[0, xItens] := FDMemReposicaoEnderecoColeta.FieldByName('Endereco').AsString;
    LstReposicaoEnderecoColeta.Cells[1, xItens] := FDMemReposicaoEnderecoColeta.FieldByName('ProdutoId').AsString;
    LstReposicaoEnderecoColeta.Cells[2, xItens] := FDMemReposicaoEnderecoColeta.FieldByName('DescrLote').AsString;
    LstReposicaoEnderecoColeta.Cells[3, xItens] := FDMemReposicaoEnderecoColeta.FieldByName('Vencimento').AsString;
    LstReposicaoEnderecoColeta.Cells[4, xItens] := FDMemReposicaoEnderecoColeta.FieldByName('Qtde').AsString;
    LstReposicaoEnderecoColeta.Cells[5, xItens] := FDMemReposicaoEnderecoColeta.FieldByName('QtdRepo').AsString;
    LstReposicaoEnderecoColeta.Alignments[0, xItens] := taCenter;
    LstReposicaoEnderecoColeta.FontStyles[0, xItens] := [FsBold];
    LstReposicaoEnderecoColeta.Alignments[1, xItens] := taRightJustify;
    LstReposicaoEnderecoColeta.Alignments[3, xItens] := taCenter;
    LstReposicaoEnderecoColeta.Alignments[4, xItens] := taRightJustify;
    LstReposicaoEnderecoColeta.Alignments[5, xItens] := taRightJustify;
    FDMemReposicaoEnderecoColeta.Next;
  end;
end;

procedure TFrmReposicao.ChkSelecionarModeloClick(Sender: TObject);
begin
  inherited;
  if ChkSelecionarModelo.Checked then
     SelecionarModelo(1)
  else SelecionarModelo(0);
end;

procedure TFrmReposicao.ClearRegistroColeta;
begin
  EdtCodProduto.Clear;
  EdtProduto.Clear;
  EdtPicking.Clear;
  EdtEmbalagem.Clear;
  EdtZona.Clear;
  EdtEndereco.Clear;
  LblEndereColeta.Caption := '';
  EdtDescrLote.Clear;
  EdtVencimento.Clear;
  EdtDemanda.Clear;
  EdtDisponivel.Clear;
  EdtAbastecimento.Clear;
end;

procedure TFrmReposicao.ColorLst(pRow: Integer);
begin
  if LstRegistroColeta.Cells[10, pRow].ToInteger() = 0 Then
     LstRegistroColeta.Colors[8, pRow] := ClRed
  Else if LstRegistroColeta.Cells[10, pRow].ToInteger() >= LstRegistroColeta.Cells[8, pRow].ToInteger() then
     LstRegistroColeta.Colors[8, pRow] := ClGreen
  Else if LstRegistroColeta.Cells[10, pRow].ToInteger() < LstRegistroColeta.Cells[8, pRow].ToInteger() then
     LstRegistroColeta.Colors[8, pRow] := ClYellow;
  LstRegistroColeta.Colors[ 9, pRow] := LstRegistroColeta.Colors[8, pRow];
  LstRegistroColeta.Colors[10, pRow] := LstRegistroColeta.Colors[8, pRow];
end;

procedure TFrmReposicao.DbgEnderecoModeloDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    If (FdMemEnderecoModelo.RecNo Mod 2 = 0) then   //Query dos itens
       Canvas.Brush.Color := $00F5EFE7 // Pedido não finalizado
    Else  Canvas.Brush.Color := $00FFCF9F; //Pedido Finalizado
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TFrmReposicao.DbgModeloPreDefinidosCellClick(Column: TColumn);
begin
  inherited;
  if Column.FieldName = 'Acao' then Begin
     if fdmemModeloPreDefinido.FieldByName('Acao').AsInteger = 0 then
        SelecionarRegistroFdMem(fdmemModeloPreDefinido, 'Acao')
     Else if fdmemModeloPreDefinido.FieldByName('Acao').AsInteger = 1 then
        SelecionarRegistroFdMem(fdmemModeloPreDefinido, 'Acao');
  End;
end;

procedure TFrmReposicao.DbgModeloPreDefinidosDblClick(Sender: TObject);
begin
  inherited;
  if BtnSalvar.Enabled then Exit;
  If fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsInteger <> 0 then
     ShowDadosModelo;
end;

procedure TFrmReposicao.DbgModeloPreDefinidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    If (fdmemModeloPreDefinido.RecNo Mod 2 = 0) then   //Query dos itens
       Canvas.Brush.Color := $00F5EFE7 // Pedido não finalizado
    Else  Canvas.Brush.Color := $00FFCF9F; //Pedido Finalizado
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
  if (Column.FieldName = 'RuaImpar') or (Column.FieldName = 'RuaPar') or
     (Column.FieldName = 'PredioImpar') or (Column.FieldName = 'PredioPar') or
     (Column.FieldName = 'NivelImpar') or (Column.FieldName = 'NivelPar') or
     (Column.FieldName = 'AptoImpar') or (Column.FieldName = 'AptoPar') or
     (Column.FieldName = 'AptoImpar') or (Column.FieldName = 'Acao') then
      ExibirCheckBox(Column, DbgModeloPreDefinidos, ImgAtivo, Rect);
end;

procedure TFrmReposicao.DeduzirDemandaCxaFechada(pCodProduto: Integer);
Var vDisponivelSemBloqueio : Integer;
    vSaldoCxaFechada       : Integer;
    xRecno                 : Integer;
begin
  FDMemDemandaCxaFechada_Saldo.First;
  FDMemDemandaCxaFechada_Saldo.Locate('Produtoid', pCodProduto, []);
  vSaldoCxaFechada := FDMemDemandaCxaFechada_Saldo.FieldByName('CxaFechada').AsInteger; //FDMemDemandaCxaFechada_Saldo.FieldByName('SaldoPalletCxaFechada').AsInteger;
  xRecno := FDMemReposicaoAutomaticaColeta.RecNo;
  FDMemReposicaoAutomaticaColeta.Filter   := 'ProdutoId = '+PCodProduto.ToString();
  FDMemReposicaoAutomaticaColeta.Filtered := True;
  while not (FDMemReposicaoAutomaticaColeta.Eof) and (vSaldoCxaFechada>0) do Begin
    vDisponivelSemBloqueio := (Trunc(FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger /
                                     FDMemReposicaoAutomaticaColeta.FieldByName('Embalagem').AsInteger)*
                                     FDMemReposicaoAutomaticaColeta.FieldByName('Embalagem').AsInteger);
    if vSaldoCxaFechada >= vDisponivelSemBloqueio then Begin
       FDMemReposicaoAutomaticaColeta.Edit;
       FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger := FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger -
                                                                             vDisponivelSemBloqueio;
       vSaldoCxaFechada := vSaldoCxaFechada - vDisponivelSemBloqueio;
    End
    Else Begin
       FDMemReposicaoAutomaticaColeta.Edit;
       FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger := FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger -
                                                                             vSaldoCxaFechada;
       vSaldoCxaFechada := 0;
    End;
    FDMemReposicaoAutomaticaColeta.Next;
  End;
  FDMemReposicaoAutomaticaColeta.Filter   := '';
  FDMemReposicaoAutomaticaColeta.Filtered := False;
  FDMemReposicaoAutomaticaColeta.Recno := xRecno;
end;

function TFrmReposicao.DeleteReg: Boolean;
Var JsonArrayModelo  : TJsonArray;
    JsonArrayRetorno : TJsonArray;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
    pJsonExcluir     : TJsonObject;
    vErro : String;
begin
  if PgcBase.ActivePage = TabReposicaoModelo then Begin
     Result := False;
     JsonArrayModelo := ObjReposicaoCtrl.DeleteReposicaoModelo(StrToIntDef(EdtModeloId.Text, 0));
     if Not JsonArrayModelo.Items[0].TryGetValue('Erro', vErro) then Begin
        Result := True;
        GetListaReposicaoModelo;
     End
     else
        ShowErro('Erro: '+vErro);
     JsonArrayModelo := Nil;
  End
  else Begin
    ObjReposicaoCtrl := TPedidoSaidaCtrl.Create;
    pJsonExcluir    := TJsonObject.Create;
    pJsonExcluir.AddPair('reposicaoid', TJsonNumber.Create(StrToInt(EdtReposicaoId.Text)));
    pJsonExcluir.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    pJsonExcluir.AddPair('terminal', NomeDoComputador);
    JsonArrayRetorno := ObjReposicaoCtrl.ReposicaoExcluir(pJsonExcluir);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Não foi possível Excluir. Erro: '+vErro);
       Result := False;
       Limpar;
    End
    else Begin
       ShowOk('Reposição excluída com sucesso!');
       Result := True;
       Limpar;
    End;
    JsonArrayModelo := Nil;
    ObjReposicaoCtrl.Free;
  End;
end;

procedure TFrmReposicao.EdtDtRessuprimentoChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtZonaId  then
     LblZona.Caption := '';
  LimparGrids;
  EdtDtRessuprimento.ReadOnly := False;
  if CbTipoReposicao.ItemIndex = 0 then
     ReposicaoTipo := poRepoNenhum
  Else if CbTipoReposicao.ItemIndex = 1 then
     ReposicaoTipo := poRepoDemanda
  Else if CbTipoReposicao.ItemIndex = 2 then Begin
     ReposicaoTipo := poRepoCapacidade;
     EdtDtRessuprimento.Clear;
     EdtDtRessuprimento.ReadOnly := True;
  End
  Else if CbTipoReposicao.ItemIndex = 3 then
     ReposicaoTipo := poAutomatica
  Else if CbTipoReposicao.ItemIndex = 3 then
     ReposicaoTipo := poCorretiva;
end;

procedure TFrmReposicao.EdtEnderecoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmReposicao.EdtEnderecoExit(Sender: TObject);
Var vEnderecoColeta : String;
begin
  inherited;
  if (Sender = EdtEndereco) and (EdtEndereco.Text<>'') then Begin
     if EdtEndereco.Text <> StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then Begin
        vEnderecoColeta := EdtEndereco.Text;
        EdtEndereco.Clear;
        EdtEndereco.SetFocus;
        raise Exception.Create('Erro: Endereço'+vEnderecoColeta+' de coleta inválido!');
     End;
     GetEstoqueColeta;
  End;
  ExitFocus(Sender);
end;

procedure TFrmReposicao.EdtEnderecoFinalExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  Exit;
  if ((Sender=EdtEnderecoFinal) and (EdtEnderecoFinal.Text  = '')) or
     ((Sender=EdtEnderecoFinalModelo) and (EdtEnderecoFinalModelo.Text  = '')) then Exit;
  ObjEnderecoCtrl := TEnderecoCtrl.Create();
  if Sender = EdtEnderecoFinal then
     JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EdtEnderecoFinal.Text, EdtEnderecoFinal.Text, 'T', 2, 0, 0)
  Else JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EdtEnderecoFinalModelo.Text, EdtEnderecoFinalModelo.Text, 'T', 2, 0, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     if Sender = EdtEnderecoFinal then Begin
        EdtEnderecoFinal.Clear;
        EdtEnderecoFinal.SetFocus;
     End
     Else Begin
        EdtEnderecoFinalModelo.Clear;
        EdtEnderecoFinalModelo.SetFocus;
     End;
     JsonArrayRetorno := Nil;
     ObjEnderecoCtrl.Free;
     raise Exception.Create('Endereço não encontrado ou estrutura diferente de Picking!');
  End;
  JsonArrayRetorno := Nil;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmReposicao.EdtEnderecoInicialExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  exit;
   if ((Sender=EdtEnderecoInicial) and (EdtEnderecoInicial.Text  = '')) or
      ((Sender=EdtEnderecoInicialModelo) and (EdtEnderecoInicialModelo.Text  = '')) then Exit;
   ObjEnderecoCtrl := TEnderecoCtrl.Create();
   if Sender = EdtEnderecoInicial then
     JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EdtEnderecoInicial.Text, EdtEnderecoInicial.Text, 'T', 2, 0, 0)
   Else JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EdtEnderecoInicialModelo.Text, EdtEnderecoInicialModelo.Text, 'T', 2, 0, 0);
   if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
      if Sender = EdtEnderecoInicial then Begin
         EdtEnderecoInicial.SetFocus;
         EdtEnderecoInicial.Clear;
      End
      Else begin
         EdtEnderecoInicialModelo.SetFocus;
         EdtEnderecoInicialModelo.Clear;
      end;
      JsonArrayRetorno := Nil;
      ObjEnderecoCtrl.Free;
      raise Exception.Create('Endereço não encontrado ou estrutura diferente de Picking!');
   End;
   JsonArrayRetorno := Nil;
   ObjEnderecoCtrl.Free;
end;

procedure TFrmReposicao.EdtModeloIdExit(Sender: TObject);
begin
  inherited;
  if EdtModeloId.Text <> '' then Begin
     if fdmemModeloPreDefinido.Locate('reposicaomodeloid', EdtModeloId.Text, []) then
        ShowDadosModelo
     Else
        ShowErro('Não foi encontrado modelo com o Id informado!');
  End;
end;

procedure TFrmReposicao.EdtreposicaoIdChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtReposicaoId then
     Limpar
  Else LimparReposicaoModelo;
End;

procedure TFrmReposicao.EdtreposicaoIdExit(Sender: TObject);
begin
  inherited;
  if (Not EdtReposicaoId.ReadOnly) and (EdtReposicaoId.Text<>'') and (LstReposicaoItens.RowCount = 1) then Begin // and (StrToInt64Def(EdtCodProduto.Text,0)<>ObjProdutoCtrl.ObjProduto.CodProduto)
     Limpar;
     if StrToInt64Def(EdtReposicaoId.Text, 0) <= 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     //ObjProdutoCtrl.GetCodigoERP(EdtCodProduto.Text);
     GetReposicaoShow;
  End;
  ExitFocus(Sender);
end;

procedure TFrmReposicao.EdtRuaInicialKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmReposicao.EdtZonaIdExit(Sender: TObject);
Var ObjZonaCtrl      : TEnderecamentoZonaCtrl;
    JsonArrayZona : TJsonArray;
    vErro            : String;
begin
  inherited;
  if ((Sender = EdtZonaId) and ((EdtZonaId.Text  = '') or (EdtZonaId.ReadOnly))) or
     ((Sender = EdtZonaIdModelo) and ((EdtZonaIdModelo.Text  = '') or (EdtZonaIdModelo.ReadOnly))) then Exit;
  if StrToIntDef(TEdit(Sender).Text, 0) = 0 then Begin
     ShowErro('Setor('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Text := '';
     Exit;
  End;
  ObjZonaCtrl   := TEnderecamentoZonaCtrl.Create();
  if Sender = EdtZonaId then
     JsonArrayZona := ObjZonaCtrl.GetEnderecamentoZonaJson(StrToIntDef(EdtZonaId.Text, 0), '', 0)
  Else
     JsonArrayZona := ObjZonaCtrl.GetEnderecamentoZonaJson(StrToIntDef(EdtZonaIdModelo.Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     if Sender = EdtZonaId then Begin
        EdtZonaId.SetFocus;
        EdtZonaId.Clear;
     End
     Else if Sender = EdtZonaId then Begin
        EdtZonaIdModelo.SetFocus;
        EdtZonaIdModelo.Clear;
     End;
     JsonArrayZona := Nil;
     ObjZonaCtrl.Free;
     raise Exception.Create('Zona não encontrada!');
  End;
  if Sender = EdtZonaId then
     LblZona.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao')
  Else LblZonaModelo.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  JsonArrayZona   := Nil;
  ObjZonaCtrl.Free;
end;

procedure TFrmReposicao.FDMemEnderecoModeloAfterClose(DataSet: TDataSet);
begin
  inherited;
  LblTotEndereco.Caption := 'Picking(s) para repor: 0';
end;

procedure TFrmReposicao.FDMemEnderecoModeloCalcFields(DataSet: TDataSet);
begin
  inherited;
  FDMemEnderecoModelo.FieldByName('EnderecoFormatado').AsString := EnderecoMask(FDMemEnderecoModelo.FieldByName('Endereco').AsString, FDMemEnderecoModelo.FieldByName('Mascara').AsString, True);
end;

procedure TFrmReposicao.FDMemReposicaoAutomaticaAfterClose(DataSet: TDataSet);
begin
  inherited;
  LblPickingReposicao.Caption := 'Picking para Repor: 0';
end;

procedure TFrmReposicao.FDMemReposicaoAutomaticaColetaAfterClose(
  DataSet: TDataSet);
begin
  inherited;
  LblPalletColeta.Caption := 'Endereço para Coleta: 0';
end;

procedure TFrmReposicao.FdMemReposicaoColetaAfterClose(DataSet: TDataSet);
begin
  inherited;
  LblPalletColeta.Caption := 'Endereço para Coleta: 0';
end;

procedure TFrmReposicao.FDMemReposicaoProdutoAfterClose(DataSet: TDataSet);
begin
  inherited;
  LblPickingReposicao.Caption := 'Picking para Repor: 0';
end;

procedure TFrmReposicao.FiltrarEnderecoColeta;
Var vCodProduto, vDemanda : Integer;
    xRecno : Integer;
    vDisponivel_Embalagem : Integer;
begin
  vCodProduto := 0;
  vDemanda    := 0;
  FDMemReposicaoAutomaticaColeta.First;
  While Not FDMemReposicaoAutomaticaColeta.Eof do Begin
    if (DebugHook <> 0) and (FDMemReposicaoAutomaticaColeta.FieldByName('CodProduto').AsInteger = 54778) then
       ShowMessage('Acompanhar aqui...');
    if vCodProduto <> FDMemReposicaoAutomaticaColeta.FieldByName('CodProduto').AsInteger then Begin
       DeduzirDemandaCxaFechada(FDMemReposicaoAutomaticaColeta.FieldByName('ProdutoId').AsInteger);
       vCodProduto := FDMemReposicaoAutomaticaColeta.FieldByName('CodProduto').AsInteger;
       vDemanda    := FDMemReposicaoAutomaticaColeta.FieldByName('Demanda').AsInteger;
    End;
    If FDMemReposicaoAutomaticaColeta.FieldByName('embalagempadrao').AsInteger > 1 Then
       vDisponivel_Embalagem := (Trunc(FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger /
                                    FDMemReposicaoAutomaticaColeta.FieldByName('embalagempadrao').AsInteger))*
                                    FDMemReposicaoAutomaticaColeta.FieldByName('embalagempadrao').AsInteger
    Else
      vDisponivel_Embalagem := FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger;
    if (vDemanda > 0) and (vDisponivel_Embalagem >= FDMemReposicaoAutomaticaColeta.FieldByName('embalagempadrao').AsInteger) then Begin
       if vDemanda > FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger then Begin
          vDemanda := vDemanda - vDisponivel_Embalagem; //FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger;
          FDMemReposicaoAutomaticaColeta.Edit;
          FDMemReposicaoAutomaticaColeta.FieldByName('Demanda').AsInteger := vDisponivel_Embalagem;
                                                      //FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger;
       End
       Else Begin
          FDMemReposicaoAutomaticaColeta.Edit;
          FDMemReposicaoAutomaticaColeta.FieldByName('Demanda').AsInteger := vDemanda;
          vDemanda := 0;
       End;
    End
    Else If (FDMemReposicaoAutomaticaColeta.FieldByName('EmbalagemPadrao').AsInteger>1) then Begin
       FDMemReposicaoAutomaticaColeta.Edit;
       FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsInteger := 0;
    End;
    xRecno := FDMemReposicaoAutomaticaColeta.RecNo;
    FDMemReposicaoAutomaticaColeta.Next;
    If (vDemanda = 0) then Begin
       While (Not FDMemReposicaoAutomaticaColeta.Eof) and (FDMemReposicaoAutomaticaColeta.FieldByName('CodProduto').AsInteger=vCodProduto) Do Begin
         FDMemReposicaoAutomaticaColeta.Delete;
         FDMemReposicaoAutomaticaColeta.RecNo := xRecno;
         FDMemReposicaoAutomaticaColeta.Next;
       End;
    End;
  End;
  AplicarFiltroColeta;
end;

procedure TFrmReposicao.FinalizarColeta;
Var JsonArrayColeta : TJsonArray;
    JsonColeta      : TJsonObject;
    xColeta         : integer;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
begin
  JsonArrayColeta := TJsonArray.Create;
//  for xColeta := 1 to Pred(LstRegistroColeta.RowCount) do Begin
  FdMemReposicaoColeta.First;
  while Not FdMemReposicaoColeta.Eof do Begin
    JsonColeta := TJsonObject.Create;
    JsonColeta.AddPair('reposicaoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger));
    JsonColeta.AddPair('produtoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger));
    JsonColeta.AddPair('codproduto', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger));
    JsonColeta.AddPair('pickingid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('PickingId').AsInteger));
    JsonColeta.AddPair('loteid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('LoteId').AsInteger));
    JsonColeta.AddPair('enderecoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger));
    JsonColeta.AddPair('estoquetipoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('EstoqueTipoId').AsInteger));
    JsonColeta.AddPair('qtde', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('Demanda').AsInteger));
    JsonColeta.AddPair('qtdrepo', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('Reposicao').AsInteger));
    JsonColeta.AddPair('usuarioid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('UsuarioId').AsInteger));
    JsonColeta.AddPair('terminal', FdMemReposicaoColeta.FieldByName('Terminal').AsString);
    JsonColeta.AddPair('dtentrada', DateToStr(FdMemReposicaoColeta.FieldByName('Dtcoleta').AsDateTime));
    JsonColeta.AddPair('hrentrada', FdMemReposicaoColeta.FieldByName('hrColeta').AsString);
    JsonArrayColeta.AddElement(JsonColeta);
    FdMemReposicaoColeta.Next;
  End;
  If ObjReposicaoCtrl.reposicaofinalizar(JsonArrayColeta) Then Begin
     Confirmacao('Reposição de Picking/Cuba(s)', 'Coleta da reposição('+EdtReposicaoId.Text+') finalizada!', False);
     PgcBase.ActivePage := TabPrincipal;
     JsonArrayColeta.Free;
     ClearRegistroColeta;
     Limpar;
  End;
end;

procedure TFrmReposicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmReposicao := Nil;
end;

procedure TFrmReposicao.FormCreate(Sender: TObject);
begin
  inherited;
  LstCadastro.ColWidths[ 0] :=  70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[ 1] :=  80+Trunc(80*ResponsivoVideo);
  LstCadastro.ColWidths[ 2] :=  70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[ 3] := 120+Trunc(120*ResponsivoVideo);
  LstCadastro.ColWidths[ 4] :=  70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[ 5] :=  70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[ 6] := 120+Trunc(120*ResponsivoVideo);
  LstCadastro.ColWidths[ 7] := 100+Trunc(100*ResponsivoVideo);;
  LstCadastro.ColWidths[ 8] :=  80+Trunc(80*ResponsivoVideo);
  LstCadastro.ColWidths[ 9] := 140+Trunc(140*ResponsivoVideo);
  LstCadastro.ColWidths[ 10] := 80+Trunc(80*ResponsivoVideo);
  LstCadastro.ColWidths[ 11] := 60+Trunc(60*ResponsivoVideo);
  LstCadastro.ColWidths[ 12] := 60+Trunc(60*ResponsivoVideo);
  LstCadastro.ColWidths[ 13] := 60+Trunc(60*ResponsivoVideo);
  LstCadastro.ColWidths[ 14] := 40+Trunc(40*ResponsivoVideo);
  LstCadastro.Alignments[ 0, 0] := taRightJustify;
  LstCadastro.FontStyles[ 0, 0] := [FsBold];
  LstCadastro.Alignments[ 1, 0] := taCenter;
  LstCadastro.Alignments[ 4, 0] := taCenter;
  LstCadastro.Alignments[ 5, 0] := taCenter;
  LstCadastro.Alignments[ 8, 0] := taCenter;
  LstCadastro.Alignments[10, 0] := taRightJustify;
  LstCadastro.Alignments[11, 0] := taRightJustify;
  LstCadastro.Alignments[12, 0] := taRightJustify;
  LstCadastro.Alignments[13, 0] := taRightJustify;
  LstCadastro.Alignments[14, 0] := taCenter;
  LstCadastro.HideColumn(7);

  LstReposicaoItens.ColWidths[0]  := 85+Trunc(85*ResponsivoVideo);;
  LstReposicaoItens.ColWidths[1]  := 250+Trunc(250*ResponsivoVideo);
  LstReposicaoItens.ColWidths[2]  := 90+Trunc(90*ResponsivoVideo);
  LstReposicaoItens.ColWidths[3]  := 150+Trunc(150*ResponsivoVideo);
  LstReposicaoItens.ColWidths[4]  := 65+Trunc(65*ResponsivoVideo);
  LstReposicaoItens.ColWidths[5]  := 90+Trunc(90*ResponsivoVideo);
  LstReposicaoItens.Alignments[0, 0] := taRightJustify;
  LstReposicaoItens.FontStyles[0, 0] := [FsBold];
  LstReposicaoItens.Alignments[2, 0] := taCenter;
  LstReposicaoItens.Alignments[4, 0] := taRightJustify;
  LstReposicaoItens.Alignments[5, 0] := taRightJustify;
  LstReposicaoItens.RowCount         := 1;

  LstReposicaoEnderecoColeta.ColWidths[0] :=  90+Trunc(90*ResponsivoVideo);
  LstReposicaoEnderecoColeta.ColWidths[1] :=  80+Trunc(80*ResponsivoVideo);
  LstReposicaoEnderecoColeta.ColWidths[2] := 120+Trunc(120*ResponsivoVideo);
  LstReposicaoEnderecoColeta.ColWidths[3] := 80+Trunc(80*ResponsivoVideo);
  LstReposicaoEnderecoColeta.ColWidths[4] := 80+Trunc(80*ResponsivoVideo);
  LstReposicaoEnderecoColeta.ColWidths[5] := 90+Trunc(90*ResponsivoVideo);
  LstReposicaoEnderecoColeta.Alignments[0, 0] := taCenter;
  LstReposicaoEnderecoColeta.FontStyles[0, 0] := [FsBold];
  LstReposicaoEnderecoColeta.Alignments[1, 0] := taRightJustify;
  LstReposicaoEnderecoColeta.Alignments[4, 0] := taRightJustify;
  LstReposicaoEnderecoColeta.Alignments[5, 0] := taRightJustify;
  LstReposicaoEnderecoColeta.RowCount := 1;

  LstRegistroColeta.ColWidths[0]  :=  85+Trunc(85*ResponsivoVideo);
  LstRegistroColeta.ColWidths[1]  := 250+Trunc(250*ResponsivoVideo);
  LstRegistroColeta.ColWidths[2]  :=  90+Trunc(90*ResponsivoVideo);
  LstRegistroColeta.ColWidths[3]  :=  90+Trunc(90*ResponsivoVideo);
  LstRegistroColeta.ColWidths[4]  := 120+Trunc(120*ResponsivoVideo);
  LstRegistroColeta.ColWidths[5]  :=  90+Trunc(90*ResponsivoVideo);
  LstRegistroColeta.ColWidths[6]  := 120+Trunc(120*ResponsivoVideo);
  LstRegistroColeta.ColWidths[7]  :=  80+Trunc(80*ResponsivoVideo);
  LstRegistroColeta.ColWidths[8]  :=  60+Trunc(60*ResponsivoVideo);
  LstRegistroColeta.ColWidths[9]  :=  70+Trunc(70*ResponsivoVideo);
  LstRegistroColeta.ColWidths[10] :=  80+Trunc(80*ResponsivoVideo);

  LstRegistroColeta.Alignments[ 0, 0] := taRightJustify;
  LstRegistroColeta.FontStyles[ 0, 0] := [FsBold];
  LstRegistroColeta.Alignments[ 2, 0] := taCenter;
  LstRegistroColeta.Alignments[ 5, 0] := taCenter;
  LstRegistroColeta.Alignments[ 7, 0] := taCenter;
  LstRegistroColeta.Alignments[ 8, 0] := taRightJustify;
  LstRegistroColeta.Alignments[ 9, 0] := taRightJustify;
  LstRegistroColeta.Alignments[10, 0] := taRightJustify;

  ProcessoReposicao := TProcessoReposicao(0);
  ReposicaoTipo     := TReposicaoTipo(0);
  vPermitirCancelar := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposição - Cancelar');
  vPermitirExcluir  := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposição - Excluir');
  DbgModeloPreDefinidos.Columns[0].Width :=  60;
  DbgModeloPreDefinidos.Columns[3].Width:= 110;
  DbgModeloPreDefinidos.Columns[4].Width := 110;
end;

procedure TFrmReposicao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 27) and ((Sender = EdtEndereco) or (Sender = EdtAbastecimento)) then
     //ClearRegistroColeta
  Else if (Key = 13) and (ActiveControl.Name = 'EdtAbastecimento') then Begin
     if EdtEndereco.Text <>  StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then Begin
        EdtEndereco.Clear;
        EdtAbastecimento.Text := '';
        EdtEndereco.SetFocus;
        raise Exception.Create('Erro: Endereço de coleta inválido');
     End;
     Key := 0;
     if EdtAbastecimento.Text = '' then Begin
        EdtAbastecimento.Text := '';
        EdtAbastecimento.SetFocus;
        raise Exception.Create('Erro: Informe a quantidade coletada ou 0(Zero)');
     End;
     if EdtAbastecimento.Value < 0 then Begin
        EdtAbastecimento.Text := '';
        EdtAbastecimento.SetFocus;
        raise Exception.Create('Erro: Quantidade de Coleta inválida');
     End;
     if (EdtAbastecimento.Value > EdtDisponivel.Value) then Begin
        EdtAbastecimento.Text := '';
        EdtAbastecimento.SetFocus;
        raise Exception.Create('Erro: Não há estoque disponível para transferência.');
     End;
     SalvarColeta;
  End
  Else
    inherited;
end;

procedure TFrmReposicao.GetEnderecoColeta(pData : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String);
Var ObjEnderecoColetaCtrl   : TPedidoSaidaCtrl;
    JsonArrayEnderecoColeta : TJsonArray;
    vErro : String;
begin
//Buscar Endereco para Coleta
  JsonArrayEnderecoColeta := ObjEnderecoColetaCtrl.GetReposicaoEnderecoColeta(pData, pZonaId, pEnderecoInicial, pEnderecoFinal);
  if JsonArrayEnderecoColeta.Get(0).tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
     Player('toast4');
     LstReposicaoEnderecoColeta.ClearRect(0, 1, LstReposicaoEnderecoColeta.ColCount-1, LstReposicaoEnderecoColeta.RowCount-1);
     LstReposicaoEnderecoColeta.RowCount := 1;
  End
  Else Begin
     If FDMemReposicaoEnderecoColeta.Active then
        FDMemReposicaoEnderecoColeta.EmptyDataSet;
     FDMemReposicaoEnderecoColeta.Close;
     FDMemReposicaoEnderecoColeta.LoadFromJson(JsonArrayEnderecoColeta, False);
  End;
  JsonArrayEnderecoColeta := Nil;
end;

procedure TFrmReposicao.GetEstoqueColeta;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueJson(FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger,
                      FdMemReposicaoColeta.FieldByName('LoteId').AsInteger,
                      FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger, 0, 1, 1,
                      'N', 'N', 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     EdtDisponivel.Value := 0
  Else
     if JsonArrayRetorno.Items[0].GetValue<Integer>('qtdereserva') >= FdMemReposicaoColeta.FieldByName('Demanda').AsInteger then
        EdtDisponivel.Value := JsonArrayRetorno.Items[0].GetValue<Integer>('qtde')+FdMemReposicaoColeta.FieldByName('Demanda').AsInteger
     Else EdtDisponivel.Value := JsonArrayRetorno.Items[0].GetValue<Integer>('qtde')+JsonArrayRetorno.Items[0].GetValue<Integer>('qtdereserva');
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmReposicao.GetListaLstCadastro;
begin
  inherited;
  GetListaReposicaoPendente(0, 0, 0);
end;

procedure TFrmReposicao.GetListaReposicaoModelo;
Var JsonArrayModelo : TJsonArray;
    ObjPedidoCtrl : TPedidoSaidaCtrl;
    vErro : String;
begin
  if fdmemModeloPreDefinido.Active then
     fdmemModeloPreDefinido.EmptyDataSet;
  fdmemModeloPreDefinido.Close;
  JsonArrayModelo := ObjPedidoCtrl.GetReposicaoModelo(0);
  if Not JsonArrayModelo.Items[0].TryGetValue('Erro', vErro) then Begin
     fdmemModeloPreDefinido.LoadFromJSON(JsonArrayModelo, False);
     FDMemModeloPreDefinido.First;
     ChkSelecionarModelo.Visible := Not fdmemModeloPreDefinido.IsEmpty;
     SelecionarModelo(1);
  End;
  JsonArrayModelo := Nil;
end;

Function TFrmReposicao.GetListaReposicaoPendente(pDataInicial, pDataFinal : TDateTime; pReposicaoId : Integer) : Boolean;
Var vErro : String;
    vRecebido, vCubagem, vEtiqueta : Integer;
    vResultado : Boolean;
begin
  Result := False;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var ObjReposicaoCtrl : TPedidoSaidaCtrl;
        JsonArrayRetorno : TJsonArray;
    begin
      ObjReposicaoCtrl := TPedidoSaidaCtrl.Create;
      JsonArrayRetorno := ObjReposicaoCtrl.GetConsultaReposicao(pDataInicial, pDataFinal, pReposicaoId, 0, 1, 0);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
         LstCadastro.RowCount := 1;
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdMemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdMemPesqGeral.LoadFromJson(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header'), False);
        MontaLstCadastro(JsonArrayRetorno);
        vResultado := True;
      end;
      JsonArrayRetorno := Nil;
      ObjReposicaoCtrl.Free;
    End);
    Result := vResultado;
end;

procedure TFrmReposicao.GetReposicaoColeta;
Var ObjReposicaoCtrl   : TPedidoSaidaCtrl;
    JsonArrayReposicao : TJsonArray;
    vErro              : String;
    vDataReposicao     : TDateTime;
begin
  inherited;
  ObjReposicaoCtrl := TPedidoSaidaCtrl.Create;
  if CbTipoReposicao.ItemIndex in [1, 2] then //Aplicar o Filtro e subfiltro para Coleta
    JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoDemandaColeta('M') //Buscar Endereço para Coleta dos produtos que precisam de Reposição
  Else if CbTipoReposicao.ItemIndex = 3 then Begin
     if (EdtDtRessuprimento.Text = '  /  /    ') then
        vDataReposicao := 0
     Else
        vDataReposicao := StrToDate(EdtDtRessuprimento.Text);
     JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoAutomaticaColeta(vDataReposicao,
                                            StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text,
                                            EdtEnderecoFinal.Text, 0);
  End
  Else
     JsonArrayReposicao := ObjReposicaoCtrl.GetReposicaoGerar(StrToDate(EdtDtRessuprimento.Text), StrToIntDef(EdtZonaId.Text,0), EdtEnderecoInicial.Text, EdtEnderecoFinal.Text);
  if JsonArrayReposicao.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtZonaId.SetFocus;
     EdtZonaId.Clear;
     JsonArrayReposicao := Nil;
     ObjReposicaoCtrl.Free;
     raise Exception.Create('Não foi possível pegar os endereços para Coleta.'+#13+vErro);
  End;
  if CbTipoReposicao.ItemIndex in [1, 2, 3] then Begin
     If FDMemReposicaoAutomaticaColeta.Active then
        FDMemReposicaoAutomaticaColeta.EmptyDataSet;
     FDMemReposicaoAutomaticaColeta.Close;
     FDMemReposicaoAutomaticaColeta.LoadFromJson(JsonArrayReposicao, False);
     FiltrarEnderecoColeta; //Deixa apenas os endereços necessário para suprir os picking's
     LblPalletColeta.Caption := 'Endereço para Coleta: '+FormatFloat('#0', FDMemReposicaoAutomaticaColeta.RecordCount);
     MontaListaColeta(0);
  End;
  JsonArrayReposicao := Nil;
  ObjReposicaoCtrl.Free;
end;

procedure TFrmReposicao.GetReposicaoProduto;
Var ObjReposicaoProdutoCtrl   : TPedidoSaidaCtrl;
    JsonArrayReposicaoProduto : TJsonArray;
    vErro : String;
begin
  ObjReposicaoProdutoCtrl    := TPedidoSaidaCtrl.Create;
  Try
    JsonArrayReposicaoProduto := ObjReposicaoProdutoCtrl.GetConsultaReposicaoProduto(StrToIntDef(EdtReposicaoId.Text, 0));
    if Not JsonArrayReposicaoProduto.Get(0).tryGetValue<String>('Erro', vErro) then Begin
       FdMemReposicaoProduto.LoadFromJSON(JsonArrayReposicaoProduto, False);
       ShowDados;
       BtnImprimirStand.Enabled := True;
       BtnImprimirStand.Grayed  := False;
       BtnExportarStand.Grayed  := False;
    End
    Else
       ShowErro('Erro: '+vErro);
    JsonArrayReposicaoProduto := Nil;
    ObjReposicaoProdutoCtrl.Free;
  Except On E: Exception do Begin
    ShowErro('Ocorreu um erro na pesquisa. Tente novamente!');
    JsonArrayReposicaoProduto := Nil;
    if Assigned(ObjReposicaoProdutoCtrl) Then
       ObjReposicaoProdutoCtrl.Free;
    End;
  End;
end;

procedure TFrmReposicao.GetReposicaoShow;
Var //vDtInicio, vDtFinal : TDateTime;
    vErro   : String;
    pProcessoId      : Integer;
    vZonaId : Integer;
begin
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  LimparGrids;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
        xBody     : Integer;
        vZonaNull : String;
        JsonArrayRetorno : TJsonArray;
        ObjPedidoCtrl    : TPedidoSaidaCtrl;
        vDtRessuprimento : String;
    begin
      ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
      JsonArrayRetorno := ObjPedidoCtrl.GetConsultaReposicao(0, 0, StrToIntDef(EdtReposicaoId.Text, 0), 0, 99, 0);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LstReposicaoItens.ClearRect(0, 1, LstReposicaoItens.ColCount-1, LstReposicaoItens.RowCount-1);
         LstReposicaoItens.RowCount := 1;
         LstReposicaoEnderecoColeta.ClearRect(0, 1, LstReposicaoEnderecoColeta.ColCount-1, LstReposicaoEnderecoColeta.RowCount-1);
         LstReposicaoEnderecoColeta.RowCount := 1;
         JsonArrayRetorno := Nil;
         ObjPedidoCtrl.Free;
      End
      Else Begin
         xRetorno := 0;
         if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento') <> '') and
            (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento') <> 'null') then begin
            vDtRessuprimento := JsonArrayRetorno.Items[xRetorno].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento');
            vDtRessuprimento := Copy(vDtRessuprimento, 9, 2)+'/'+Copy(vDtRessuprimento, 6, 2)+'/'+Copy(vDtRessuprimento, 1, 4);
            EdtDtRessuprimento.Text := vDtRessuprimento;
            end;
         CbTipoReposicao.ItemIndex := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('reposicaotipo');
         if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('zonaid') <> '') then begin
             EdtZonaId.Text  := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('zonaid');
             LblZona.Caption := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('zona');
         end;
         if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('enderecoinicial') <> '') Then
            EdtEnderecoInicial.Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('enderecoinicial');
         if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('enderecofinal') <> '') Then
            EdtEnderecoFinal.Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('enderecofinal');
         if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao') <> '') and
            (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao') <> '') then
            EdtDtReposicao.Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao');
         EdtProcessoId.Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('processoid');
         EdtProcesso.Text   := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('processo');


        FdMemReposicaoColeta.Open;
        for xRetorno := 0 to Pred(JsonArrayRetorno.Count) do Begin
          //Dados da Coleta
          for xBody := 0 to Pred(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Count) do Begin
            FdMemReposicaoColeta.Append;
            FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger    := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicaoid');
            FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('produtoid');
            FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger     := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('codproduto');
            FdMemReposicaoColeta.FieldByName('Descricao').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descricao');
            FdMemReposicaoColeta.FieldByName('Embalagem').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('embalagem');
            FdMemReposicaoColeta.FieldByName('FatorConversao').AsInteger := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('fatorconversao');
            if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('pickingid') <> '' then
               FdMemReposicaoColeta.FieldByName('PickingId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('pickingid');
            FdMemReposicaoColeta.FieldByName('Picking').AsString         := EnderecoMask(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('picking'),
                                                                                         JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking'), True);
            FdMemReposicaoColeta.FieldByName('MascaraPicking').AsString  := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking');
            FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger     := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('enderecoid');
            FdMemReposicaoColeta.FieldByName('Endereco').AsString        := EnderecoMask(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('endereco'),
                                                                                         JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascara'), True);
            FdMemReposicaoColeta.FieldByName('Mascara').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascara');
            FdMemReposicaoColeta.FieldByName('ZonaId').AsInteger       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('zonaid');
            FdMemReposicaoColeta.FieldByName('Zona').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('zona');
            FdMemReposicaoColeta.FieldByName('LoteId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('loteid');
            FdMemReposicaoColeta.FieldByName('DescrLote').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descrlote');
            FdMemReposicaoColeta.FieldByName('Vencimento').AsDateTime      := StrToDate(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('vencimento'));
            FdMemReposicaoColeta.FieldByName('Demanda').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('demanda');
            if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('estoquetipoid') <> '' then
               FdMemReposicaoColeta.FieldByName('estoquetipoid').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<integer>('estoquetipoid');
            if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('reposicao') <> '' then
               FdMemReposicaoColeta.FieldByName('Reposicao').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicao');
            if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('usuarioid') <> '' then
               FdMemReposicaoColeta.FieldByName('UsuarioId').Asinteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<integer>('usuarioid');
            FdMemReposicaoColeta.FieldByName('Nome').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('nome');
            FdMemReposicaoColeta.FieldByName('Terminal').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('terminal');
            if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<string>('dataentrada') <> '' then
               FdMemReposicaoColeta.FieldByName('DtColeta').AsDateTime      := StrToDate(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('dataentrada'));
            FdMemReposicaoColeta.FieldByName('HrColeta').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('hrentrada');
            FdMemReposicaoColeta.Post;
          End;
        End;
        GetReposicaoProduto;
        JsonArrayRetorno := Nil;
        ObjPedidoCtrl.Free;
      End;
    End);
end;

procedure TFrmReposicao.Limpar;
begin
  inherited;
  if Not (EdtReposicaoId.Enabled) then
     EdtReposicaoId.Clear;
  EdtReposicaoId.Enabled  := True;
  EdtDtRessuprimento.Text := '  /  /    ';
  EdtProcesso.Clear;
  EdtProcessoId.Clear;
  EdtDtReposicao.Text     := '  /  /    ';
  EdtZonaId.Clear;
  LblZona.Caption := '';
  EdtEnderecoInicial.Clear;
  EdtEnderecoFinal.Clear;
  CbTipoReposicao.ItemIndex := -1;
  MarkCheck(False);
  EdtRuaInicial.Clear;
  EdtRuaFinal.Clear;
  EdtPredioInicial.Clear;
  EdtPredioFinal.Clear;
  EdtNivelInicial.Clear;
  EdtNivelFinal.Clear;
  EdtAptoinicial.clear;
  EdtAptoFinal.Clear;
  LimparGrids;
  LstReposicaoItens.ClearRect(0, 1, LstReposicaoItens.ColCount-1, LstReposicaoItens.RowCount-1);
  LstReposicaoItens.RowCount := 1;
  LstReposicaoEnderecoColeta.ClearRect(0, 1, LstReposicaoEnderecoColeta.ColCount-1, LstReposicaoEnderecoColeta.RowCount-1);
  LstReposicaoEnderecoColeta.RowCount := 1;
  TabPrincipal.TabVisible := True;
  TabReposicaoColeta.TabVisible := False;
  TabReposicaoModelo.TabVisible := True;
  FDMemEnderecoModelo.Close;
  BtnExportarStand.Grayed  := True;
  BtnExportarStand.Enabled := False;
end;

Procedure TFrmReposicao.LimparGrids;
Begin
  If FDMemReposicaoItens.Active then
     FDMemReposicaoItens.EmptyDataSet;
  FDMemReposicaoItens.Close;
  LstReposicaoItens.ClearRect(0, 1, LstReposicaoItens.ColCount-1, LstReposicaoItens.RowCount-1);
  LstReposicaoItens.RowCount := 1;
  If FDMemReposicaoEnderecoColeta.Active then
     FDMemReposicaoEnderecoColeta.EmptyDataSet;
  FDMemReposicaoEnderecoColeta.Close;
  LstReposicaoEnderecoColeta.ClearRect(0, 1, LstReposicaoEnderecoColeta.ColCount-1, LstReposicaoEnderecoColeta.RowCount-1);
  LstReposicaoEnderecoColeta.RowCount := 1;
  If FDMemReposicaoAutomatica.Active then
     FDMemReposicaoAutomatica.EmptyDataSet;
  FDMemReposicaoAutomatica.Close;
  If FDMemReposicaoAutomaticaColeta.Active then
     FDMemReposicaoAutomaticaColeta.EmptyDataSet;
  FDMemReposicaoAutomaticaColeta.Close;

  If FdMemReposicaoColeta.Active then
     FdMemReposicaoColeta.EmptyDataSet;
  FdMemReposicaoColeta.Close;
  FdMemReposicaoColeta.CreateDataSet;
  If FdMemReposicaoProduto.Active then
     FdMemReposicaoProduto.EmptyDataSet;
  FdMemReposicaoProduto.Close;
  FdMemReposicaoProduto.CreateDataSet;
  LstRegistroColeta.ClearRect(0, 1, LstRegistroColeta.ColCount-1, LstRegistroColeta.RowCount-1);
  LstRegistroColeta.RowCount := 1;
End;

procedure TFrmReposicao.LimparReposicaoModelo;
begin
  if Not (EdtModeloId.Enabled) then
     EdtModeloId.Clear;
  EdtmodeloId.Enabled  := True;
  EdtDtModelo.Text := '  /  /    ';
  CbTipoReposicaoModelo.ItemIndex := 1;
  EdtZonaId.Clear;
  EdtEnderecoInicialModelo.Clear;
  EdtEnderecoFinalModelo.Clear;
  EdtRuaInicialModelo.Clear;
  EdtRuaFinalModelo.Clear;
  EdtPredioInicialModelo.Clear;
  EdtPredioFinalModelo.Clear;
  EdtNivelInicialModelo.Clear;
  EdtNivelFinalModelo.Clear;
  EdtAptoinicialModelo.clear;
  EdtAptoFinalModelo.Clear;
  BtnConferiModelo.Enabled := False;
  FDMemEnderecoModelo.Close;
  LblObsModeloReposicao.Visible := False;
end;

procedure TFrmReposicao.LstCadastroClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ObjReposicaoCtrl : TPedidoSaidaCtrl;
    JsonArrayRetorno : TJsonArray;
    pJsonCancelar    : TJsonObject;
    vErro : String;
begin
  inherited;
  if (ACol = 13) and (ARow>0) and (TAdvStringGrid(Sender).Cells[14, aRow]='2') then Begin
     If Confirmacao('Cancelamento.', 'Deseja cancelar a Reposição('+TAdvStringGrid(Sender).Cells[0, aRow]+')?', True) then begin
        ObjReposicaoCtrl := TPedidoSaidaCtrl.Create;
        pJsonCancelar    := TJsonObject.Create;
        pJsonCancelar.AddPair('reposicaoid', TJsonNumber.Create(StrToInt(TAdvStringGrid(Sender).Cells[0, aRow])));
        pJsonCancelar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
        pJsonCancelar.AddPair('terminal', NomeDoComputador);
        JsonArrayRetorno := ObjReposicaoCtrl.ReposicaoCancelar(pJsonCancelar);
        if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
           ShowErro('Não foi possível cancelar. Erro: '+vErro)
        Else Begin
          GetListaLstCadastro;
        End;
     end;
  End;
end;

procedure TFrmReposicao.LstRegistroColetaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  inherited;
  LstRegistroColeta.Row := aRow;
end;

procedure TFrmReposicao.LstRegistroColetaDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if (aRow > 0) and (PnlTopRegistroColeta.Enabled) then Begin
     PosicionaRegistroColeta(aRow);
     FdMemReposicaoColeta.RecNo := aRow;
  End;
end;

procedure TFrmReposicao.LstReposicaoItensClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var  xCol, xRow : Integer;
 xVal : String;
begin
  inherited;
  LstReposicaoItens.Row := aRow;
  if (aRow = 0) and (aCol in [0, 1, 2, 3]) then Begin
     LstReposicaoItens.SortSettings.Column := aCol;
     LstReposicaoItens.QSort;
  End;
//  Else if (aCol=0) and (aRow>0) then
//     MontalistaColeta(aRow);
end;

procedure TFrmReposicao.MarkCheck(pOnOff: Boolean);
begin
  if PgcBase.ActivePage = TabPrincipal then Begin
     ChkRuaPar.Checked      := pOnOff;
     ChkRuaImpar.Checked    := pOnOff;
     ChkPredioPar.Checked   := pOnOff;
     ChkPredioImpar.Checked := pOnOff;
     ChkNivelPar.Checked    := pOnOff;
     ChkNivelImpar.Checked  := pOnOff;
     ChkAptoPar.Checked     := pOnOff;
     ChkAptoImpar.Checked   := pOnOff;
  End
  Else Begin
     ChkRuaParModelo.Checked      := pOnOff;
     ChkRuaImparModelo.Checked    := pOnOff;
     ChkPredioParModelo.Checked   := pOnOff;
     ChkPredioImparModelo.Checked := pOnOff;
     ChkNivelParModelo.Checked    := pOnOff;
     ChkNivelImparModelo.Checked  := pOnOff;
     ChkAptoParModelo.Checked     := pOnOff;
     ChkAptoImparModelo.Checked   := pOnOff;
  End;
end;

procedure TFrmReposicao.MontalistaColeta(aRow: integer);
Var xReg : Integer;
begin
  FDMemReposicaoAutomaticaColeta.First;
  if aRow > 0 then Begin
     FDMemReposicaoAutomaticaColeta.Filter   := 'CodProduto = '+LstReposicaoItens.Cells[0, aRow];
     FDMemReposicaoAutomaticaColeta.Filtered := True;
  End;
  LstReposicaoEnderecoColeta.RowCount     := FDMemReposicaoAutomaticaColeta.RecordCount+1;
  xReg := 1;
  while Not FDMemReposicaoAutomaticaColeta.Eof do Begin
    LstReposicaoEnderecoColeta.FixedRows := 1;
    LstReposicaoEnderecoColeta.Cells[0, xReg] := EnderecoMask(FDMemReposicaoAutomaticaColeta.FieldByName('Endereco').AsString,
                                                 FDMemReposicaoAutomaticaColeta.FieldByName('Mascara').AsString, True);
    LstReposicaoEnderecoColeta.Cells[1, xReg] := FDMemReposicaoAutomaticaColeta.FieldByName('CodProduto').AsString;
    LstReposicaoEnderecoColeta.Cells[2, xReg] := FDMemReposicaoAutomaticaColeta.FieldByName('DescrLote').AsString;
    LstReposicaoEnderecoColeta.Cells[3, xReg] := FDMemReposicaoAutomaticaColeta.FieldByName('Vencimento').AsString;
    LstReposicaoEnderecoColeta.Cells[4, xReg] := FDMemReposicaoAutomaticaColeta.FieldByName('Demanda').AsString;
//    LstReposicaoEnderecoColeta.Cells[4, xReg] := FDMemReposicaoAutomaticaColeta.FieldByName('Disponivel').AsString;
    LstReposicaoEnderecoColeta.Cells[5, xReg] := FDMemReposicaoAutomaticaColeta.FieldByName('Reposicao').AsString;
    LstReposicaoEnderecoColeta.Alignments[0, xReg]  := taCenter;
    LstReposicaoEnderecoColeta.FontStyles[0, xReg]  := [FsBold];
    LstReposicaoEnderecoColeta.Alignments[1, xReg]  := taRightJustify;
    LstReposicaoEnderecoColeta.Alignments[3, xReg]  := taCenter;
    LstReposicaoEnderecoColeta.Alignments[4, xReg]  := taRightJustify;
//    LstReposicaoEnderecoColeta.Alignments[4, xReg]  := taRightJustify;
    LstReposicaoEnderecoColeta.Alignments[5, xReg]  := taRightJustify;
    FDMemReposicaoAutomaticaColeta.Next;
    Inc(xReg);
  End;
  FDMemReposicaoAutomaticaColeta.Filtered := False;
end;

procedure TFrmReposicao.MontaLstCadastro(JsonArrayRetorno : TJsonArray);
Var xRetorno : Integer;
begin
  if JsonArrayRetorno.Count = 0 then Begin
     LstCadastro.RowCount  := 1;
     Exit;
  End;
  LstCadastro.RowCount  := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Count+1;
  LstCadastro.FixedRows := 1;
  for xRetorno := 1 to JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Count do Begin
    if vPermitirCancelar then
       LstCadastro.AddDataImage(14, xRetorno, 2, TCellHAlign.haCenter, TCellVAlign.vaTop)
    Else
       LstCadastro.AddDataImage(14, xRetorno, 3, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  for xRetorno := 0 to Pred(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Count) do Begin
    LstCadastro.Cells[0, xRetorno+1]      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('reposicaoid').ToString();
    if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento') <> '') and
       (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento') <> 'null') then
       LstCadastro.Cells[1, xRetorno+1] := DateEUAtoBr(Copy(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento'),1,10));
    LstCadastro.Cells[2, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('tipo');
    if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('zonaid') <> '') then
        LstCadastro.Cells[3, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('zona');
    if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('enderecoinicial') <> '') Then
       LstCadastro.Cells[4, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('enderecoinicial');
    if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('enderecofinal') <> '') Then
       LstCadastro.Cells[5, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('enderecofinal');
    LstCadastro.Cells[6, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('usuarioreposicao');
    LstCadastro.Cells[7, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('terminal');
    if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao') <> '') and
       (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao') <> '') then
       LstCadastro.Cells[8, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao');
    LstCadastro.Cells[ 9, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('processo');
    LstCadastro.Cells[10, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('demanda').Tostring();
    LstCadastro.Cells[11, xRetorno+1] := FormatFloat('##0.00', (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('coleta') /
                                                                JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('demanda'))*100)+'%';
    LstCadastro.Cells[12, xRetorno+1] := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('totalendereco').Tostring();
    if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('totalenderecocoleta') > 0 then Begin
       LstCadastro.Cells[13, xRetorno+1] := FormatFloat('##0.00', (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('totalenderecocoleta') /
                                                                   JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('totalendereco'))*100)+'%';
    End
    Else
       LstCadastro.Cells[13, xRetorno+1] := '';
    if vPermitirCancelar then
       LstCadastro.Cells[14, xRetorno+1] := '2'
    Else LstCadastro.Cells[14, xRetorno+1] := '3';
    LstCadastro.Alignments[0,  xRetorno+1] := taRightJustify;
    LstCadastro.FontStyles[0,  xRetorno+1] := [FsBold];
    LstCadastro.Alignments[1,  xRetorno+1] := taCenter;
    LstCadastro.Alignments[4,  xRetorno+1] := taCenter;
    LstCadastro.Alignments[5,  xRetorno+1] := taCenter;
    LstCadastro.Alignments[8,  xRetorno+1] := taCenter;
    LstCadastro.Alignments[10, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[11, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[12, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[13, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[14, xRetorno+1] := taCenter;
  End;
  BtnExportarStand.Grayed  := False;
  BtnExportarStand.Enabled := True;
end;

procedure TFrmReposicao.MontarListaReposicao;
Var xItens   : Integer;
    vMascara : String;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  if CbTipoReposicao.ItemIndex = 22 then Begin
     FdMemReposicaoItens.First;
     LstReposicaoItens.RowCount := 1;
     If Not FdMemReposicaoItens.Eof Then Begin
        LstReposicaoItens.RowCount  := FdmemReposicaoItens.RecordCount+1;
        LstReposicaoItens.FixedRows := 1;
        ObjEnderecoCtrl := TEnderecoCtrl.Create();
        vMascara := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, FdMemReposicaoItens.FieldByName('Endereco').AsString,
                                        FdMemReposicaoItens.FieldByName('Endereco').AsString, 'T', 2, 0, 0).
                                        Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara');
        for xItens := 1 to FdmemReposicaoItens.RecordCount do begin
          LstReposicaoItens.Cells[0, xItens] := FdMemReposicaoItens.FieldByName('CodProduto').AsString;
          LstReposicaoItens.Cells[1, xItens] := FdMemReposicaoItens.FieldByName('Descricao').AsString;
          LstReposicaoItens.Cells[2, xItens] := EnderecoMask(FdMemReposicaoItens.FieldByName('Endereco').AsString,
                                                vMascara, True);
          LstReposicaoItens.Cells[3, xItens] := FdMemReposicaoItens.FieldByName('Zona').AsString;
          LstReposicaoItens.Cells[4, xItens] := FdMemReposicaoItens.FieldByName('Demanda').AsString;
          LstReposicaoItens.Cells[5, xItens] := FdMemReposicaoItens.FieldByName('Disponivel').AsString;
          LstReposicaoItens.Cells[6, xItens] := FdMemReposicaoItens.FieldByName('Reposicao').AsString;
          LstReposicaoItens.Alignments[0, xItens]  := taRightJustify;
          LstReposicaoItens.FontStyles[0, xItens]  := [FsBold];
          LstReposicaoItens.Alignments[2, xItens]  := taCenter;
          LstReposicaoItens.Alignments[4, xItens]  := taRightJustify;
          LstReposicaoItens.Alignments[5, xItens]  := taRightJustify;
          LstReposicaoItens.Alignments[6, xItens]  := taRightJustify;
          FdMemReposicaoItens.Next;
        end;
        ObjEnderecoCtrl.Free;
     End;
  End
  Else Begin
     FdMemReposicaoAutomatica.First;
     LstReposicaoItens.RowCount := 1;
     If Not FdMemReposicaoAutomatica.Eof Then Begin
        LstReposicaoItens.RowCount  := FdMemReposicaoAutomatica.RecordCount+1;
        LstReposicaoItens.FixedRows := 1;
        for xItens := 1 to FdMemReposicaoAutomatica.RecordCount do begin
          LstReposicaoItens.Cells[0, xItens] := FdMemReposicaoAutomatica.FieldByName('CodProduto').AsString;
          LstReposicaoItens.Cells[1, xItens] := FdMemReposicaoAutomatica.FieldByName('Descricao').AsString;
          LstReposicaoItens.Cells[2, xItens] := EnderecoMask(FdMemReposicaoAutomatica.FieldByName('Picking').AsString,
                                                             FdMemReposicaoAutomatica.FieldByName('MascaraPicking').AsString, True);
          LstReposicaoItens.Cells[3, xItens] := FdMemReposicaoAutomatica.FieldByName('Zona').AsString;
          LstReposicaoItens.Cells[4, xItens] := FdMemReposicaoAutomatica.FieldByName('Demanda').AsString;
          LstReposicaoItens.Cells[5, xItens] := FdMemReposicaoAutomatica.FieldByName('Reposicao').AsString;;
          LstReposicaoItens.Alignments[0, xItens]  := taRightJustify;
          LstReposicaoItens.FontStyles[0, xItens]  := [FsBold];
          LstReposicaoItens.Alignments[2, xItens]  := taCenter;
          LstReposicaoItens.Alignments[4, xItens]  := taRightJustify;
          LstReposicaoItens.Alignments[5, xItens]  := taRightJustify;
          FdMemReposicaoAutomatica.Next;
        end;
     End;
  End;
end;

procedure TFrmReposicao.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  Limpar;
  edtReposicaoId.Text := LstCadastro.Cells[aCol, aRow];
  edtReposicaoIdExit(edtReposicaoId);
end;

function TFrmReposicao.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Begin
        if StrToIntDef(EdtConteudoPesq.Text, 0) = 0 then
           raise Exception.Create('Conteúdo(Id) inválido para pesquisa.')
        Else Result := GetListaReposicaoPendente(0, 0, StrToInt(EdtConteudoPesq.Text))
     End
     Else If CbCampoPesq.ItemIndex = 1 then Begin
        Try
          StrToDate(EdtConteudoPesq.Text);
          Result := GetListaReposicaoPendente(StrToDate(EdtConteudoPesq.Text), 0, 0);
        Except
          ShowErro('Data inválida!!!');
        End;
     End
     Else If CbCampoPesq.ItemIndex = 2 then Begin
       ShowErro('Pesquisa em desenvolvimento!');
     End;
     If Result then
        EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmReposicao.PgcBaseChange(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmReposicao.PosicionaRegistroColeta(aRow : Integer);
begin
  EdtCodProduto.Text      := LstRegistroColeta.Cells[ 0, aRow];
  EdtProduto.Text         := LstRegistroColeta.Cells[ 1, aRow];
  EdtPicking.Text         := LstRegistroColeta.Cells[ 2, aRow];
  EdtEmbalagem.Text       := LstRegistroColeta.Cells[ 3, aRow];
  EdtZona.Text            := LstRegistroColeta.Cells[ 4, aRow];
  LblEndereColeta.Caption := LstRegistroColeta.Cells[ 5, aRow];
  EdtDescrLote.Text       := LstRegistroColeta.Cells[ 6, aRow];
  EdtVencimento.Text      := LstRegistroColeta.Cells[ 7, aRow];
  EdtDemanda.Text         := LstRegistroColeta.Cells[ 8, aRow];
  EdtDisponivel.Text      := LstRegistroColeta.Cells[ 9, aRow];
  EdtAbastecimento.Text   := LstRegistroColeta.Cells[10, aRow];
  EdtEndereco.SetFocus;
end;

procedure TFrmReposicao.PreencherCamposReposicao;
begin
  EdtZonaId.Text := fdmemModeloPreDefinido.FieldByName('ZonaId').AsString;
  EdtEnderecoInicial.Text := fdmemModeloPreDefinido.FieldByName('PickingInicial').AsString;
  EdtEnderecoFinal.Text   := fdmemModeloPreDefinido.FieldByName('PickingFinal').AsString;
  EdtRuaInicial.Text      := fdmemModeloPreDefinido.FieldByName('RuaInicial').AsString;
  EdtRuaFinal.Text        := fdmemModeloPreDefinido.FieldByName('RuaFinal').AsString;
  ChkRuaImpar.Checked     := fdmemModeloPreDefinido.FieldByName('RuaImpar').AsInteger = 1;
  ChkRuaPar.Checked       := fdmemModeloPreDefinido.FieldByName('RuaPar').AsInteger = 1;
  EdtPredioInicial.Text   := fdmemModeloPreDefinido.FieldByName('PredioInicial').AsString;
  EdtPredioFinal.Text     := fdmemModeloPreDefinido.FieldByName('PredioFinal').AsString;
  ChkPredioImpar.Checked  := fdmemModeloPreDefinido.FieldByName('PredioImpar').AsInteger = 1;
  ChkPredioPar.Checked    := fdmemModeloPreDefinido.FieldByName('PredioPar').AsInteger = 1;
  EdtNivelInicial.Text    := fdmemModeloPreDefinido.FieldByName('NivelInicial').AsString;
  EdtNivelFinal.Text      := fdmemModeloPreDefinido.FieldByName('NivelFinal').AsString;
  ChkNivelImpar.Checked   := fdmemModeloPreDefinido.FieldByName('NivelImpar').AsInteger = 1;
  ChkNivelPar.Checked     := fdmemModeloPreDefinido.FieldByName('NivelPar').AsInteger = 1;
  EdtAptoInicial.Text     := fdmemModeloPreDefinido.FieldByName('AptoInicial').AsString;
  EdtAptoFinal.Text       := fdmemModeloPreDefinido.FieldByName('AptoFinal').AsString;
  ChkAptoImpar.Checked    := fdmemModeloPreDefinido.FieldByName('AptoImpar').AsInteger = 1;
  ChkAptoPar.Checked      := fdmemModeloPreDefinido.FieldByName('AptoPar').AsInteger = 1;
end;

function TFrmReposicao.ReposicaoSelecionada: Integer;
begin
  fdmemModeloPreDefinido.First;
  Result := 0;
  while Not fdmemModeloPreDefinido.Eof do Begin
    if fdmemModeloPreDefinido.FieldByName('Acao').AsInteger = 1 then
       Inc(Result);
    fdmemModeloPreDefinido.Next;
  End;
end;

procedure TFrmReposicao.SalvarColeta;
begin
  LstRegistroColeta.Cells[10, LstRegistroColeta.Row]  := Trunc(EdtAbastecimento.Value).ToString;
  ColorLst(LstRegistroColeta.Row);
  FdMemReposicaoColeta.Edit;
  FdMemReposicaoColeta.FieldByName('Reposicao').Value := Trunc(EdtAbastecimento.Value);
  FdMemReposicaoColeta.FieldByName('UsuarioId').Value := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  FdMemReposicaoColeta.FieldByName('Nome').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome;
  FdMemReposicaoColeta.FieldByName('Terminal').Value  := NomeDoComputador;
  FdMemReposicaoColeta.FieldByName('DtColeta').Value  := DateToStr(Now());
  FdMemReposicaoColeta.FieldByName('HrColeta').Value  := TimeToStr(Time());
  FdMemReposicaoColeta.Post;
  FdMemReposicaoColeta.Next;
  ClearRegistroColeta;
  if FdMemReposicaoColeta.Eof then Begin
     FinalizarColeta;
  End
  Else begin
    LstRegistroColeta.Row := FdMemReposicaoColeta.RecNo;
    PosicionaRegistroColeta(LstRegistroColeta.Row);
  end;
end;

function TFrmReposicao.SalvarReg: Boolean;
Var JsonReposicao : TJsonObject;
    JsonArrayItens, JsonArrayEndereco : TJsonArray;
    ObjPedidoCtrl : TPedidoSaidaCtrl;
begin
  JsonReposicao := TJsonObject.Create;
  if PgcBase.ActivePage = TabPrincipal then Begin
     JsonReposicao.AddPair('reposicaoid', TJsonNumber.Create(StrToIntDef(EdtReposicaoId.Text, 0)));
     JsonReposicao.AddPair('dtressuprimento', EdtDtRessuprimento.Text);
     JsonReposicao.AddPair('reposicaotipo', TJsonNumber.Create(Ord(ReposicaoTipo)));
     jsonReposicao.AddPair('zonaid', TJsonNumber.Create(StrToIntDef(EdtZonaId.Text, 0)));
     jsonReposicao.AddPair('enderecoinicial', EdtEnderecoInicial.Text);
     jsonReposicao.AddPair('enderecofinal', EdtEnderecoFinal.Text);
     JsonReposicao.AddPair('processoid', TJsonNumber.Create(Ord(ProcessoReposicao)));
     JsonReposicao.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
     JsonReposicao.AddPair('terminal', NomeDoComputador );
     JsonReposicao.AddPair('coleta', FDMemReposicaoAutomaticacoleta.ToJSONArray());
     Result := ObjPedidoCtrl.SalvarReposicao(JsonReposicao);
  End
  Else Begin
     //Salvando o modelo
     JsonReposicao.AddPair('modeloid', TJsonNumber.Create(StrToIntDef(EdtModeloId.Text, 0)));
     JsonReposicao.AddPair('reposicaotipo', TJsonNumber.Create(1));
     jsonReposicao.AddPair('zonaid', TJsonNumber.Create(StrToIntDef(EdtZonaIdModelo.Text, 0)));
     jsonReposicao.AddPair('pickinginicial', EdtEnderecoInicialModelo.Text);
     jsonReposicao.AddPair('pickingfinal', EdtEnderecoFinalModelo.Text);
     jsonReposicao.AddPair('ruainicial', EdtRuaInicialModelo.Text);
     jsonReposicao.AddPair('ruafinal',   EdtRuaFinalModelo.Text);
     jsonReposicao.AddPair('ruapar',     TJsonNumber.Create(Ord(ChkRuaParModelo.Checked)));
     jsonReposicao.AddPair('ruaimpar',  TJsonNumber.Create(Ord(ChkRuaImparModelo.Checked)));
     jsonReposicao.AddPair('predioinicial', EdtPredioInicialModelo.Text);
     jsonReposicao.AddPair('prediofinal',   EdtPredioFinalModelo.Text);
     jsonReposicao.AddPair('prediopar',     TJsonNumber.Create(Ord(ChkPredioParModelo.Checked)));
     jsonReposicao.AddPair('predioimpar',  TJsonNumber.Create(Ord(ChkPredioImparModelo.Checked)));
     jsonReposicao.AddPair('nivelinicial', EdtNivelInicialModelo.Text);
     jsonReposicao.AddPair('nivelfinal',   EdtNivelFinalModelo.Text);
     jsonReposicao.AddPair('nivelpar',     TJsonNumber.Create(Ord(ChkNivelParModelo.Checked)));
     jsonReposicao.AddPair('nivelimpar',  TJsonNumber.Create(Ord(ChkNivelImparModelo.Checked)));
     jsonReposicao.AddPair('aptoinicial', EdtAptoInicialModelo.Text);
     jsonReposicao.AddPair('aptofinal',   EdtAptoFinalModelo.Text);
     jsonReposicao.AddPair('aptopar',     TJsonNumber.Create(Ord(ChkAptoParModelo.Checked)));
     jsonReposicao.AddPair('aptoimpar',  TJsonNumber.Create(Ord(ChkAptoImparModelo.Checked)));
     JsonReposicao.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
     JsonReposicao.AddPair('terminal', NomeDoComputador );
     Result := ObjPedidoCtrl.SalvarReposicaoModelo(JsonReposicao);
     if Result then Begin
        GetListaReposicaoModelo;
        PgcBase.ActivePage := TabReposicaoModelo;
     End;
  End;
  JsonReposicao.Free;
end;

procedure TFrmReposicao.SelecionarModelo(pSelecionar: Integer);
begin
  DsModeloPreDefido.DataSet := nil;
  fdmemModeloPreDefinido.First;
  While Not fdmemModeloPreDefinido.Eof do Begin
    fdmemModeloPreDefinido.Edit;
    fdmemModeloPreDefinido.FieldByName('Acao').AsInteger := pSelecionar;
    fdmemModeloPreDefinido.Next;
  End;
  fdmemModeloPreDefinido.First;
  DsModeloPreDefido.DataSet := fdmemModeloPreDefinido;
end;

procedure TFrmReposicao.ShowDados;
Var vRow : Integer;
begin
  inherited;
  LstReposicaoItens.RowCount  := FdMemReposicaoProduto.RecordCount+1;
  LstReposicaoItens.FixedRows := 1;
  LstReposicaoEnderecoColeta.RowCount  := FdMemReposicaoColeta.RecordCount+1;
  LstReposicaoEnderecoColeta.FixedRows := 1;
  LstRegistroColeta.RowCount  := FdMemReposicaoColeta.RecordCount+1;
  LstRegistroColeta.FixedRows := 1;
  vRow := 1;
  FdMemReposicaoProduto.First;
  LblPickingReposicao.Caption := 'Picking para Repor: '+FormatFloat('#0', FdMemReposicaoProduto.RecordCount);
  While Not FdMemReposicaoProduto.Eof do Begin
    LstReposicaoItens.Cells[0, vRow] := FdMemReposicaoProduto.FieldByName('CodProduto').AsString;
    LstReposicaoItens.Cells[1, vRow] := FdMemReposicaoProduto.FieldByName('Descricao').AsString;
    LstReposicaoItens.Cells[2, vRow] := EnderecoMask(FdMemReposicaoProduto.FieldByName('picking').AsString,
                                                     FdMemReposicaoProduto.FieldByName('mascarapicking').AsString, True);
    LstReposicaoItens.Cells[3, vRow] := FdMemReposicaoProduto.FieldByName('Zona').AsString;
    LstReposicaoItens.Cells[4, vRow] := FdMemReposicaoProduto.FieldByName('Demanda').AsString;
    LstReposicaoItens.Cells[5, vRow] := FdMemReposicaoProduto.FieldByName('Reposicao').AsString;
    LstReposicaoItens.Alignments[0, vRow] := taRightJustify;
    LstReposicaoItens.FontStyles[0, vRow] := [FsBold];
    LstReposicaoItens.Alignments[2, vRow] := taCenter;
    LstReposicaoItens.Alignments[4, vRow] := taRightJustify;
    LstReposicaoItens.Alignments[5, vRow] := taRightJustify;
    Inc(vRow);
    FdMemReposicaoProduto.Next;
  End;
  vRow := 1;
  FdMemReposicaoColeta.First;
  LblPalletColeta.Caption := 'Endereço para Coleta: '+FormatFloat('#0', FdMemReposicaoColeta.RecordCount);
  While Not FdMemReposicaoColeta.Eof do Begin
    LstReposicaoEnderecoColeta.Cells[0, vRow] := EnderecoMask(FdMemReposicaoColeta.FieldByName('Endereco').AsString,
                                                              FdMemReposicaoColeta.FieldByName('Mascara').AsString, True);
    LstReposicaoEnderecoColeta.Cells[1, vRow] := FdMemReposicaoColeta.FieldByName('CodProduto').AsString;
    LstReposicaoEnderecoColeta.Cells[2, vRow] := FdMemReposicaoColeta.FieldByName('DescrLote').AsString;
    LstReposicaoEnderecoColeta.Cells[3, vRow] := FdMemReposicaoColeta.FieldByName('Vencimento').AsString;
    LstReposicaoEnderecoColeta.Cells[4, vRow] := FdMemReposicaoColeta.FieldByName('Demanda').AsString;
    LstReposicaoEnderecoColeta.Cells[5, vRow] := FdMemReposicaoColeta.FieldByName('Reposicao').AsString;
    LstReposicaoEnderecoColeta.Alignments[0, vRow] := taCenter;
    LstReposicaoEnderecoColeta.FontStyles[0, vRow] := [FsBold];
    LstReposicaoEnderecoColeta.Alignments[3, vRow] := taRightJustify;
    LstReposicaoEnderecoColeta.Alignments[4, vRow] := taRightJustify;

    LstRegistroColeta.Cells[ 0, vRow] := FdMemReposicaoColeta.FieldByName('CodProduto').AsString;
    LstRegistroColeta.Cells[ 1, vRow] := FdMemReposicaoColeta.FieldByName('Descricao').AsString;
    LstRegistroColeta.Cells[ 2, vRow] := EnderecoMask(FdMemReposicaoColeta.FieldByName('Picking').AsString,
                                                      FdMemReposicaoColeta.FieldByName('MascaraPicking').AsString, True);
    LstRegistroColeta.Cells[ 3, vRow] := FdMemReposicaoColeta.FieldByName('Embalagem').AsString;
    LstRegistroColeta.Cells[ 4, vRow] := FdMemReposicaoColeta.FieldByName('Zona').AsString;
    LstRegistroColeta.Cells[ 5, vRow] := EnderecoMask(FdMemReposicaoColeta.FieldByName('Endereco').AsString,
                                                      FdMemReposicaoColeta.FieldByName('Mascara').AsString, True);
    LstRegistroColeta.Cells[ 6, vRow] := FdMemReposicaoColeta.FieldByName('DescrLote').AsString;
    LstRegistroColeta.Cells[ 7, vRow] := FdMemReposicaoColeta.FieldByName('Vencimento').AsString;
    LstRegistroColeta.Cells[ 8, vRow] := FdMemReposicaoColeta.FieldByName('Demanda').AsString;
    LstRegistroColeta.Cells[ 9, vRow] := FdMemReposicaoColeta.FieldByName('Disponivel').AsString;
    LstRegistroColeta.Cells[10, vRow] := FdMemReposicaoColeta.FieldByName('Reposicao').AsString;
    LstRegistroColeta.Alignments[ 0, vRow] := taRightJustify;
    LstRegistroColeta.FontStyles[ 0, vRow] := [FsBold];
    LstRegistroColeta.Alignments[ 2, vRow] := taCenter;
    LstRegistroColeta.Alignments[ 5, vRow] := taCenter;
    LstRegistroColeta.Alignments[ 7, vRow] := taCenter;
    LstRegistroColeta.Alignments[ 8, vRow] := taRightJustify;
    LstRegistroColeta.Alignments[ 9, vRow] := taRightJustify;
    LstRegistroColeta.Alignments[10, vRow] := taRightJustify;
    Inc(vRow);
    FdMemReposicaoColeta.Next;
  End;
  TabReposicaoColeta.TabVisible := (StrToIntDef(EdtProcessoId.text, 0) <> 30);
  PnlTopRegistroColeta.Enabled  := ((EdtProcesso.Text = 'Reposição - Criada') or (EdtProcesso.Text = 'Reposição - Em Coleta'));
//Coleta Automatica desativado para evitar problemas
//  BtnColetaAutomatica.Visible   :=  PnlTopRegistroColeta.Enabled;

//  TabReposicaoColeta.TabVisible := (EdtProcesso.Text = 'Reposição - Criada') or
//                                   (EdtProcesso.Text = 'Reposição - Em Coleta');
end;

procedure TFrmReposicao.ShowDadosModelo;
begin
  EnabledButtons   := True;
  EdtModeloId.Text := fdmemModeloPreDefinido.FieldByName('ReposicaoModeloId').AsString;
  EdtDtModelo.Text := fdmemModeloPreDefinido.FieldByName('Data').AsString;
  EdtZonaIdModelo.Text := fdmemModeloPreDefinido.FieldByName('ZonaId').AsString;
  EdtEnderecoInicialModelo.Text := fdmemModeloPreDefinido.FieldByName('PickingInicial').AsString;
  EdtEnderecoFinalModelo.Text   := fdmemModeloPreDefinido.FieldByName('PickingFinal').AsString;
  EdtRuaInicialModelo.Text      := fdmemModeloPreDefinido.FieldByName('RuaInicial').AsString;
  EdtRuaFinalModelo.Text        := fdmemModeloPreDefinido.FieldByName('RuaFinal').AsString;
  ChkRuaImparModelo.Checked     := fdmemModeloPreDefinido.FieldByName('RuaImpar').AsInteger = 1;
  ChkRuaParModelo.Checked       := fdmemModeloPreDefinido.FieldByName('RuaPar').AsInteger = 1;
  EdtPredioInicialModelo.Text   := fdmemModeloPreDefinido.FieldByName('PredioInicial').AsString;
  EdtPredioFinalModelo.Text     := fdmemModeloPreDefinido.FieldByName('PredioFinal').AsString;
  ChkPredioImparModelo.Checked  := fdmemModeloPreDefinido.FieldByName('PredioImpar').AsInteger = 1;
  ChkPredioParModelo.Checked    := fdmemModeloPreDefinido.FieldByName('PredioPar').AsInteger = 1;
  EdtNivelInicialModelo.Text    := fdmemModeloPreDefinido.FieldByName('NivelInicial').AsString;
  EdtNivelFinalModelo.Text      := fdmemModeloPreDefinido.FieldByName('NivelFinal').AsString;
  ChkNivelImparModelo.Checked   := fdmemModeloPreDefinido.FieldByName('NivelImpar').AsInteger = 1;
  ChkNivelParModelo.Checked     := fdmemModeloPreDefinido.FieldByName('NivelPar').AsInteger = 1;
  EdtAptoInicialModelo.Text     := fdmemModeloPreDefinido.FieldByName('AptoInicial').AsString;
  EdtAptoFinalModelo.Text       := fdmemModeloPreDefinido.FieldByName('AptoFinal').AsString;
  ChkAptoImparModelo.Checked    := fdmemModeloPreDefinido.FieldByName('AptoImpar').AsInteger = 1;
  ChkAptoParModelo.Checked      := fdmemModeloPreDefinido.FieldByName('AptoPar').AsInteger = 1;
  BtnConferiModeloClick(BtnConferiModelo);
end;

procedure TFrmReposicao.TabReposicaoColetaShow(Sender: TObject);
begin
  inherited;
  LstRegistroColeta.Row := 1;
  FdMemReposicaoColeta.First;
  If StrToIntDef(EdtProcessoId.Text, 0) <= 27 then
     PosicionaRegistroColeta(1);
  if  (DebugHook<>0) or (Pos('BRASIL', UpperCase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa)) > 0) or
     (Pos('MORIFARMA', UpperCase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa)) > 0) then
     BtnColetaAutomatica.Visible := True
  Else
     BtnColetaAutomatica.Visible := False;
end;

procedure TFrmReposicao.TabReposicaoModeloShow(Sender: TObject);
begin
  inherited;
  ChkSelecionarModelo.Checked := True;
  GetListaReposicaoModelo;
end;

end.
