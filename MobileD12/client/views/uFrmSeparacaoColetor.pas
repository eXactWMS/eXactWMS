Unit uFrmSeparacaoColetor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, System.Diagnostics,
  FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, System.IOUtils,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  System.JSON, REST.Json, Rest.Types, DataSet.Serialize, Math,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Edit, FMX.ScrollBox, uMyTabOrderClassHelper,
  FMX.Grid, FMX.ListView, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, System.Generics.Collections,
  FMX.Media, FMX.ListBox, FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.DialogService, ksTypes,
  ksLoadingIndicator, EstoqueCtrl, PedidoVolumeCtrl, LoteCtrl;

type
  TOperacaoTipo = (poAbertura, poFinalizar);
  TFrmSeparacaoColetor = class(TFrmBase)
    EdtVolumeId: TEdit;
    Label1: TLabel;
    LytSeparacao: TLayout;
    LytDetalheVolume: TLayout;
    Layout02: TLayout;
    Label3: TLabel;
    LblPedido: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Label5: TLabel;
    LblRota: TLabel;
    Layout5: TLayout;
    LblDestino: TLabel;
    Label7: TLabel;
    EdtDtPedido: TEdit;
    Label8: TLabel;
    LytDigitacaoApanhe: TLayout;
    LytBeepProduto: TLayout;
    Label9: TLabel;
    EdtProduto: TEdit;
    LytQtdDemanda: TLayout;
    Label10: TLabel;
    EdtQtdDemanda: TEdit;
    LytUnid: TLayout;
    Label12: TLabel;
    EdtUnid: TEdit;
    LytQtdApanhe: TLayout;
    Label11: TLabel;
    EdtQtdApanhe: TEdit;
    MPlayer: TMediaPlayer;
    Line2: TLine;
    Line1: TLine;
    Line3: TLine;
    Line4: TLine;
    FdMemProdutos: TFDMemTable;
    FdMemProdutosPedidoVolumeId: TIntegerField;
    FdMemProdutosProdutoId: TIntegerField;
    FdMemProdutosCodProduto: TIntegerField;
    FdMemProdutosDescricao: TStringField;
    FdMemProdutosEnderecoId: TIntegerField;
    FdMemProdutosEnderecoDescricao: TStringField;
    FdMemProdutosEmbalagemPadrao: TIntegerField;
    FdMemProdutosQtdSuprida: TIntegerField;
    FdMemProdutosMascara: TStringField;
    RctApanhe: TRectangle;
    RctCabecalho: TRectangle;
    EdtEmbalagemId: TEdit;
    Line5: TLine;
    LblEmbalagemId: TLabel;
    FdMemProdutosDemanda: TIntegerField;
    FdMemProdutosUsuarioId: TIntegerField;
    FdMemProdutosQtdApanhe: TIntegerField;
    FdMemProdutosData: TDateField;
    FdMemProdutoshorario: TTimeField;
    FdMemProdutosQtdCorte: TIntegerField;
    FdMemProdutosEmbalagem: TStringField;
    FdMemProdutosHorarioTermino: TTimeField;
    ActFuncoes: TActionList;
    ActConfirmarCorte: TAction;
    ActCancelar: TAction;
    ActVolumeExtra: TAction;
    ActCancelarApanhe: TAction;
    ActDelLoteAjuste: TAction;
    Line6: TLine;
    Layout01: TLayout;
    LytHeaderApanhe: TLayout;
    LytLoteApanhe: TLayout;
    LytFooter: TLayout;
    LytRodape: TLayout;
    RctRodape: TRectangle;
    LytRodapeLeft: TLayout;
    Rectangle1: TRectangle;
    Label2: TLabel;
    LytSkuVolume: TLayout;
    LblSkuVolume: TLabel;
    LytRodapeRight: TLayout;
    Rectangle2: TRectangle;
    Label4: TLabel;
    Layout1: TLayout;
    LblSkuSeparada: TLabel;
    LytTeclaFuncao: TLayout;
    RctF3: TRectangle;
    LblF3: TLabel;
    RctF7: TRectangle;
    LblF7: TLabel;
    RctF8: TRectangle;
    LblF8: TLabel;
    RctF9: TRectangle;
    LblF9: TLabel;
    RctF5: TRectangle;
    LblF5: TLabel;
    RctF6: TRectangle;
    LblF6: TLabel;
    LytProduto: TLayout;
    RctProduto: TRectangle;
    LblProduto: TLabel;
    Label6: TLabel;
    LytEndereco: TLayout;
    LblEndereco: TLabel;
    VsbLotes: TVertScrollBox;
    LytLotesItem: TLayout;
    retOffset: TRectangle;
    RctLoteItem: TRectangle;
    Label15: TLabel;
    Label16: TLabel;
    LblLote: TLabel;
    LblVencimento: TLabel;
    LblQuantidade: TLabel;
    Label19: TLabel;
    EdtLoteSeparacao: TEdit;
    Line7: TLine;
    Label13: TLabel;
    TabSubstituirLote: TTabItem;
    LytProdutoSubstituir: TLayout;
    Layout6: TLayout;
    LblCodProdutoSubstituto: TLabel;
    EdtCodProdutoSubstituto: TEdit;
    LnCodProdutoSubstituto: TLine;
    Layout8: TLayout;
    Label18: TLabel;
    EdtDemandaSubstituto: TEdit;
    Layout9: TLayout;
    Label20: TLabel;
    EdtUnidSubstituto: TEdit;
    LytProdutoDescricaoSubstituir: TLayout;
    RctProdutoDescricaoSubstituir: TRectangle;
    LblProdutoDescricaoSubstituir: TLabel;
    LblTitProdutoDescricaoSubstituir: TLabel;
    LytSubstituicao: TLayout;
    RctLoteSubstituir: TRectangle;
    Label22: TLabel;
    CbLoteSubstituto: TComboBox;
    LblLoteVencimento: TLabel;
    LblTitLoteVencimento: TLabel;
    Label23: TLabel;
    LblLoteFabricacao: TLabel;
    LblTitLoteFabricacao: TLabel;
    LytQtdeSubstituto: TLayout;
    LblQtdeSubstituto: TLabel;
    EdtQtdeSubstituto: TEdit;
    Line8: TLine;
    SbSalvarLoteSubstituto: TSpeedButton;
    PthSalvarLoteSubstituto: TPath;
    LblSaveLoteSubstituto: TLabel;
    LytBottomSaveSubstituicao: TLayout;
    SbSalvarSubstituicao: TSpeedButton;
    PthSalvarSubstituicao: TPath;
    LblSalvarSubstituicao: TLabel;
    LytBottomCancel: TLayout;
    lytBottomSave: TLayout;
    SbCancelarSubstituicao: TSpeedButton;
    PthCancelarSubstituicao: TPath;
    LblCancelarSubstituicao: TLabel;
    Layout2: TLayout;
    LytLotesSubstituicao: TLayout;
    LstLoteSubstituicao: TListView;
    FDMemVolumeLotes: TFDMemTable;
    RctDetProduto: TRectangle;
    Label17: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    FDMemEstoqueLotes: TFDMemTable;
    FDMemLoteSubstituicao: TFDMemTable;
    FDMemLoteSubstituicaoIdProduto: TIntegerField;
    FDMemLoteSubstituicaoCodProduto: TIntegerField;
    FDMemLoteSubstituicaoLoteId: TIntegerField;
    FDMemLoteSubstituicaoLote: TStringField;
    FDMemLoteSubstituicaoDemanda: TIntegerField;
    FDMemLoteSubstituicaoEmbalagemPadrao: TIntegerField;
    FDMemLoteSubstituicaoUsuarioId: TIntegerField;
    FDMemLoteSubstituicaoTerminal: TStringField;
    FDMemLoteSubstituicaoFabricacao: TStringField;
    FDMemLoteSubstituicaoVencimento: TStringField;
    FDMemLoteSubstituicaoDtInclusao: TStringField;
    FDMemLoteSubstituicaoHrInclusao: TStringField;
    ActGerarVolumeExtra: TAction;
    ActCancelarVolumeExtra: TAction;
    FdMemProdutosZonaId: TIntegerField;
    FdMemProdutosZona: TStringField;
    FdMemProdutosLoteReposicao: TIntegerField;
    FdMemProdutosLoteSeparacao: TIntegerField;
    FDMemVolumeLotesIdProduto: TIntegerField;
    FDMemVolumeLotesCodProduto: TIntegerField;
    FDMemVolumeLotesLoteId: TIntegerField;
    FDMemVolumeLotesLote: TStringField;
    FDMemVolumeLotesFabricacao: TDateField;
    FDMemVolumeLotesVencimento: TDateField;
    FDMemVolumeLotesDemanda: TIntegerField;
    FDMemVolumeLotesEmbalagemPadrao: TIntegerField;
    FDMemVolumeLotesDtInclusao: TDateField;
    FDMemVolumeLotesHrInclusao: TTimeField;
    FDMemVolumeLotesUsuarioid: TIntegerField;
    FDMemVolumeLotesTerminal: TStringField;
    FDMemVolumeLotesQtdSuprida: TIntegerField;
    FDMemVolumeLotesQtdApanhe: TIntegerField;
    FDMemVolumeLotesQtdCorte: TIntegerField;
    FDMemVolumeLotesData: TDateField;
    FDMemVolumeLotesHorarioInicio: TTimeField;
    FDMemVolumeLotesHorarioTermino: TTimeField;
    Label14: TLabel;
    LblApanhe: TLabel;
    Image1: TImage;
    FDMemLoteSubstituicaoQtdSuprida: TIntegerField;
    FDMemLoteSubstituicaoData: TDateField;
    FDMemLoteSubstituicaoHorarioInicio: TTimeField;
    FDMemLoteSubstituicaoHorarioTermino: TTimeField;
    EdtLoteSubstituir: TEdit;
    Line9: TLine;
    LytApanheLoteF3: TLayout;
    LblQtdeApanheLoteF3: TLabel;
    EdtQtdeApanheLoteF3: TEdit;
    Line10: TLine;
    LblCaixaVolume: TLabel;
    FDMemVolumeSeparacao: TFDMemTable;
    FDMemVolumeSeparacaovolumeseparacaoid: TIntegerField;
    FDMemVolumeSeparacaocaixaembalagemid: TIntegerField;
    FDMemVolumeSeparacaooperacao: TIntegerField;
    FDMemVolumeSeparacaopedidovolumeid: TIntegerField;
    FDMemVolumeSeparacaoenderecoid: TIntegerField;
    FDMemVolumeSeparacaousuarioid: TIntegerField;
    FDMemVolumeSeparacaodtinicio: TDateField;
    FDMemVolumeSeparacaohrinicio: TTimeField;
    FDMemVolumeSeparacaodtfinalizacao: TDateField;
    FDMemVolumeSeparacaohrfinalizacao: TTimeField;
    FDMemVolumeSeparacaodivergencia: TIntegerField;
    FDMemVolumeEan: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    FDMemVolumeEanCodBarras: TStringField;
    FDMemVolumeEanUnidadesEmbalagem: TIntegerField;
    LytSubstituicaoInativa: TLayout;
    RctSubstituicaoInativa: TRectangle;
    LblSubstituicaoInativa: TLabel;
    FdMemProdutosQtdSeparada: TIntegerField;
    EdtDesativarDigitacao: TEdit;
    SpeedButton1: TSpeedButton;
    Path1: TPath;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure CabecalhoPedido(pPedidoId : Integer; pRazao, pDocumentoData : String; pRotaid : Integer);
    procedure FormActivate(Sender: TObject);
    procedure EdtProdutoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtEmbalagemIdKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtEmbalagemIdValidate(Sender: TObject; var Text: string);
    procedure EdtQtdApanheKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ActConfirmarCorteExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActCancelarApanheExecute(Sender: TObject);
    procedure ActDelLoteAjusteExecute(Sender: TObject);
    procedure EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure BtnLogInClick(Sender: TObject);
    procedure PthCloseAutClick(Sender: TObject);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure LstLoteSubstituicaoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure EdtCodProdutoSubstitutoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodProdutoSubstitutoTyping(Sender: TObject);
    procedure CbLoteSubstitutoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtQtdeSubstitutoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure LstLoteSubstituicaoItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure SbCancelarSubstituicaoClick(Sender: TObject);
    procedure CbLoteSubstitutoChange(Sender: TObject);
    procedure SbSalvarLoteSubstitutoClick(Sender: TObject);
    procedure SbSalvarSubstituicaoClick(Sender: TObject);
    procedure ActGerarVolumeExtraExecute(Sender: TObject);
    procedure ActCancelarVolumeExtraExecute(Sender: TObject);
    procedure EdtLoteSeparacaoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtProdutoChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure LytBtnMenuClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure RctF5Click(Sender: TObject);
    procedure RctF6Click(Sender: TObject);
    procedure RctF7Click(Sender: TObject);
    procedure LblF3Click(Sender: TObject);
    procedure RctF8Click(Sender: TObject);
    procedure EdtLoteSubstituirKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtLoteSubstituirExit(Sender: TObject);
    procedure RctF9Click(Sender: TObject);
    procedure EdtQtdeApanheLoteF3Validate(Sender: TObject; var Text: string);
    procedure EdtVolumeIdTyping(Sender: TObject);
    procedure RctF3Click(Sender: TObject);
    procedure EdtEmbalagemIdKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure EdtVolumeIdKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure EdtProdutoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
  private
    { Private declarations }
    LogOffCaixa            : Boolean;
    StartSeparacao         : Boolean;
    vTimeSeparation : TStopWatch;
    F3Press : Boolean; //Informado a quantidade
    vVolumeSeparacaoId   : Integer;
    vQtdCorte            : Integer;
    OperacaoTipo         : TOperacaoTipo;
    OpenSeparacaoVolume  : Boolean; // Indica se está iniciando a Separacao para registro da sequencia
    vApanheConsolidadoSetor : Boolean;
    pPanelDigitarProduto : Boolean;
    DivergenciaNoVolume  : Boolean;
    vTituloForm : String;
    vFinalizarColeta     : Boolean;
    CodConfirmacao       : integer;
    vVolumeExtraGerado   : Integer;
    vCtrlErroFinalizacao : Integer;
    vEnderecoIdSeparado  : Integer; //Endereco Inicial para Separacao
    vTotSeparadoBeforeLogOff : Integer;
    Function AutorizarCorte : Boolean;
    Procedure BuscarVolumeLotesParaSeparacao(pEnderecoInicial : Integer);
    Function ValidarVolume : Boolean;
    Procedure ThreadValidarVolumeTerminate(Sender : TObject);
    Procedure Limpar(pDigitarProduto : Boolean);
    procedure LimparCabecalhoPedido;
    Procedure LimparLoteSubstituicao;
    Procedure ShowProdutoParaSeparacao;
    Procedure FinalizarSeparacao;
    Function RegistrarAberturaSeparacao(pVolumeSeparacaoId, pOperacao, pUsuarioId : Integer) : Boolean;
    Procedure MontaListaLotes(pLoadLotes : Boolean = True);
    procedure LimparLista(Sender: TObject; AVertScroll: TVertScrollBox;
      ARectBase: string);
    procedure LimparListaLayout;
    procedure OnSelecionarLotes(Sender: TObject);
    Procedure LogOff;
    function ConfCorte: Boolean;
    Procedure ConfirmarGeracaoVolumeExtra;
    Procedure ConfirmarGeracaoVolumeExtraForcado;
    Procedure GetLotesSubstituto;
    Procedure MontaLoteSubstituto;
    Procedure atualizarTotalSeparacao;
    Procedure CallAlteracaoLotes;
    Procedure ResetVolume;
    procedure FinalizarComDivergencia;
    Procedure RedistribuirApanheParaLotes;
    procedure ConfirmarCancelamentoDeVolume;
    procedure CancelarVolumeSemApanhe;
    Procedure AtualizarSubstituicaoLotes;
    function GetVolumeComDivergencia: Boolean;
    Procedure GerarVolumeExtraDeExcesso;
    Procedure ThreadGerarVolumeExtraDeExcessoTerminate(Sender : TObject);
    Procedure SalvarItemColetaSqLite(pPedidoVolumeId : Integer; pCodProduto : Integer; pLote : String; pQuantidade : Integer);
    Procedure AtualizarSaldoColetado(pEnderecoId : Integer);
    //tabelas SqLite
    Procedure InsertVolumeProdutoSqlLite;
    Procedure InsertVolumeLoteSqlLite;
    Procedure OpenVolumeProduto(pPedidoVolumeId, pCodProduto : Integer);
    Procedure OpenVolumeLote(pPedidoVolumeId, pCodProduto : Integer);
    Procedure PutColetaAPI(pGerarVolumeExtra : Boolean); //Enviar Coleta para o Banco de Dados Via APi
    Procedure SalvarCorteSqlLite;
    Procedure GetVolumeEan;
    procedure ThreadTerminateFinalizarSeparacao(Sender: TObject);
    procedure ThreadTerminateLogOff(Sender: TObject);
    procedure ConfirmaResetVolume(pPedidoVolumeId: Integer);
    Procedure ThreaConfirmaResetVolumeTerminate(Sender : TObject);
    Procedure AtualizarContagem(pForcado : Boolean);
    Procedure LimparTabelaSqLite;
    Function ValidaLoteSeparado : Boolean;
    Procedure totalizarColeta(pPedidoVolumeId : Integer);
    Procedure ZerarLoteParaExtraExcesso;
    Procedure AtualizarLotesSubstituicaoSqLite;
    Procedure RepeatFinalizacao(vErro : String);
    Function GetProdutoSeparado : Integer;
    Procedure PreencherDadosSeparacao(pJsonArray : TJsonArray);
    Procedure ConfirmadoVolumeExtra(pGerarVolumeExtra : Boolean);
    procedure RegistrarColetaProduto;
    function ValidarColetaProduto: Boolean;
    procedure VerificarFinalizacaoOrContinuidadeSeparacao(pForcado : Boolean);
    Function ValidarColetaLote : Boolean;
    procedure ConfirmarResetVolume;
  Protected
    Procedure PermitirAcessoCtrlSeg; OverRide;
    Procedure LiberarFuncaoBloqueada; OverRide;
    Procedure ConfirmacaoExecute; OverRide;
    Procedure ConfirmacaoCancel; OverRide;
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
  end;

var
  FrmSeparacaoColetor: TFrmSeparacaoColetor;

implementation

{$R *.fmx}

uses uFrmeXactWMS, uDmClient, Notificacao, uFuncoes, uLibThread, U_MsgD,
  ProdutoCtrl, EmbalagemCaixaCtrl, PedidoVolumeSeparacaoCtrl, uDmeXactWMS;

procedure TFrmSeparacaoColetor.ActConfirmarCorteExecute(Sender: TObject);
begin
  inherited;
  MsgD.CloseMsgD;
  if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1 then
     vQtdCorte := StrToIntDef(EdtQtdDemanda.Text, 0) - StrToIntDef(EdtQtdApanhe.Text, 0)
  else vQtdCorte := StrToIntDef(EdtQtdDemanda.Text, 0);
  vQtdCorte := vQtdCorte * FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger;
  AtualizarContagem(False); //10/09
  vQtdCorte := 0;
end;

procedure TFrmSeparacaoColetor.ActDelLoteAjusteExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrmSeparacaoColetor.PutColetaAPI(pGerarVolumeExtra : Boolean); //salvar a coleta no servidor
Var JsonApanhe : TJsonObject;
    JsonRegSeparacao    : TJsonObject;
    JsonArrayLoteApanhe : TJsonArray;
    vErro : String;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonRetorno         : TJsonArray;
    pRetornoVolumeExtra : String;
begin
  Try
    Try
      DmeXactWMS.QryFinalizarVolumeLote.Close;
      DmeXactWMS.QryFinalizarVolumeLote.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
      DmeXactWMS.QryFinalizarVolumeLote.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
      If DebugHook <> 0 then
         DmeXactWMS.QryFinalizarVolumeLote.Sql.SaveToFile('PutColetaAPI.Sql');
      DmeXactWMS.QryFinalizarVolumeLote.Open();
      //if DmeXactWMS.QryFinalizarVolumeLote.IsEmpty then
      //   Exit;
      DmeXactWMS.QryFinalizarVolumeLote.First;
      JsonRegSeparacao    := TJsonObject.Create;
      JsonArrayLoteApanhe := TJsonArray.Create;
      while Not DmeXactWMS.QryFinalizarVolumeLote.Eof do Begin
        JsonApanhe := TJsonObject.Create();
        //Atualizar pelo lote evitando calculo no Servidor;
        JsonApanhe.AddPair('pedidovolumeid', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('PedidoVolumeId').AsInteger));
        JsonApanhe.AddPair('produtoid', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('ProdutoId').AsInteger));
        JsonApanhe.AddPair('loteid', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('LoteId').AsInteger));
        JsonApanhe.AddPair('enderecoid', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('EnderecoId').AsInteger));
        JsonApanhe.AddPair('codproduto', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('CodProduto').asInteger));
        JsonApanhe.AddPair('demanda', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('Demanda').AsInteger));
        JsonApanhe.AddPair('qtdsuprida', TJsonNumber.Create(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('QtdSuprida').AsInteger));//-vQtdCorte));
        JsonApanhe.AddPair('data', Copy(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('Data').AsString, 9, 2)+'/'+
                                   Copy(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('Data').AsString, 6, 2)+'/'+
                                   Copy(DmeXactWMS.QryFinalizarVolumeLote.FieldByName('Data').AsString, 1, 4)); //FormatDateTime('YYYY-MM-DD', FdMemProdutos.FieldByName('Data').AsDateTime));
        JsonApanhe.AddPair('horarioinicio',  DmeXactWMS.QryFinalizarVolumeLote.FieldByName('HorarioInicio').AsString);
        JsonApanhe.AddPair('horariotermino', DmeXactWMS.QryFinalizarVolumeLote.FieldByName('HorarioTermino').AsString);
        JsonApanhe.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
        JsonApanhe.AddPair('processoetapa', 'Apanhe - Separação');
        {$IfDef Android}
           JsonApanhe.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
           JsonApanhe.AddPair('estacao', IMEI);
        {$else}
           JsonApanhe.AddPair('terminal', NomeDoComputador);
           JsonApanhe.AddPair('estacao', NomeDoComputador);
        {$ENdif}
        JsonArrayLoteApanhe.AddElement(JsonApanhe);
        DmeXactWMS.QryFinalizarVolumeLote.Next;
      End;
      ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
      JsonRegSeparacao.AddPair('volumeseparacaoid', TJsonNumber.Create(vVolumeSeparacaoid));
      JsonRegSeparacao.AddPair('pedidovolumeid', TJsonNumber.Create(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger));
      JsonRegSeparacao.AddPair('operacao', TJsonNumber.Create(Ord(OperacaoTipo)));
      If (FdMemProdutos.Bof) or (FdMemProdutos.RecNo = 1) or (OperacaoTipo = poFinalizar) Then
         JsonRegSeparacao.AddPair('enderecoid', '0')
      Else Begin
         FdMemProdutos.Prior;
         JsonRegSeparacao.AddPair('enderecoid', TJsonNumber.Create(FdMemProdutos.FieldByName('EnderecoId').AsInteger));
         FdMemProdutos.Next;
      End;
      JsonRegSeparacao.AddPair('coleta', JsonArrayLoteApanhe);
      JsonRegSeparacao.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
      {$IfDef Android}
         JsonRegSeparacao.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
      {$else}
         JsonRegSeparacao.AddPair('terminal', NomeDoComputador);
      {$EndIf}
      if (FrmeXactWMS.ConfigWMS.ApanheConsolidado=1) and (vApanheConsolidadoSetor) then
         JsonRegSeparacao.AddPair('consolidado', TJsonNumber.Create(1))
      Else
         JsonRegSeparacao.AddPair('consolidado', TJsonNumber.Create(0));
      if pGerarVolumeExtra then
         JsonRegSeparacao.AddPair('volumeextra', 'YES')
      Else JsonRegSeparacao.AddPair('volumeextra', 'NO');
      JsonRetorno := ObjPedidoVolumeCtrl.SalvarColetaComRegistro(JsonRegSeparacao);
      if JsonRetorno.Items[0].TryGetValue('Erro', vErro) then
         Raise Exception.Create('Erro: SCCR003 - '+vErro);
      Try
        DmeXactWMS.QryDelVolumeProdutoLote.Close;
        DmeXactWMS.QryDelVolumeProdutoLote.ParamByName('PedidoVolumeIdPrd').Value  := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
        DmeXactWMS.QryDelVolumeProdutoLote.ParamByName('PedidoVolumeIdLote').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
        DmeXactWMS.QryDelVolumeProdutoLote.ExecSql;
      Except
      End;
      if (pGerarVolumeExtra) then Begin
         TThread.Synchronize(TThread.CurrentThread, procedure
         begin
           If (JsonRetorno.Items[0].TryGetValue('volumeextra', pRetornoVolumeExtra)) then
              MensagemStand('Volume Extra Gerado: '+pRetornoVolumeExtra)
           Else
              ShowErro('Não foi possível Gerar Volume Extra.');
         end);
      End;
    Except On E: Exception do Begin
      Raise Exception.Create('SCCR004 - '+E.Message);  //Era usado o ShowErro
      End;
    End;
  Finally
//    If Assigned(JsonRetorno) then
//       FreeAndNil(JsonRetorno);
//    If Assigned(JsonApanhe) then
//       FreeAndNil(JsonApanhe);
//    If Assigned(JsonArrayLoteApanhe) then
//       FreeAndNil(JsonArrayLoteApanhe);
//    If Assigned(JsonRegSeparacao) then
//       FreeAndNil(JsonRegSeparacao);
    If Assigned(JsonApanhe) then
       JsonApanhe  := Nil;
    JsonArrayLoteApanhe := Nil;
    JsonRetorno := Nil;
    JsonRegSeparacao := Nil;
    If Assigned(ObjPedidoVolumeCtrl) then
       FreeAndNil(ObjPedidoVolumeCtrl);
  End;
  TThread.Synchronize(TThread.CurrentThread, procedure
  begin
    Try
      Limpar(True);
    Except On E:Exception Do
      Raise Exception.Create('SCCR005 - '+E.Message);  //Era usado o ShowErro
    End;
  end);
end;

procedure TFrmSeparacaoColetor.ActGerarVolumeExtraExecute(Sender: TObject);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayVolumeExtra    : TJsonArray;
    vErro : String;
    pJsonArrayProdutoCorte : TjsonArray;
begin
  inherited;

  pJsonArrayProdutoCorte := TjsonArray.Create;
  OperacaoTipo := poFinalizar;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
  JsonArrayVolumeExtra   := ObjPedidoVolumeCtrl.GerarVolumeExtra(pJsonArrayProdutoCorte);
  pJsonArrayProdutoCorte.Free;
  if Not JsonArrayVolumeExtra.Items[0].TryGetValue('Erro', vErro) then Begin
     If RegistrarAberturaSeparacao(vVolumeSeparacaoId, Ord(operacaotipo), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) Then Begin
        StartSeparacao     := False;
        DmeXactWMS.QryDelVolumeProdutoLote.Close;
        DmeXactWMS.QryDelVolumeProdutoLote.ParamByName('PedidoVolumeIdPrd').Value  := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
        DmeXactWMS.QryDelVolumeProdutoLote.ParamByName('PedidoVolumeIdLote').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
        DmeXactWMS.QryDelVolumeProdutoLote.ExecSql;
        vVolumeExtraGerado := JsonArrayVolumeExtra.Items[0].Value.ToInteger();
        ChgTabDet.Execute;
        Limpar(False);
        MensagemStand( 'Volume Extra Gerado: '+JsonArrayVolumeExtra.Items[0].Value);
        vVolumeSeparacaoId := 0;
     End
     Else Begin
        ChgTabDet.Execute;
        ShowErro('Erro. Não foi possível gerar o Volume Extra.', 'alerta');
     End;
  End
  Else Begin
    ChgTabDet.Execute;
    if (LytLoteApanhe.Visible) and (EdtProduto.Text<>'') then
       SetCampoDefault('EdtLoteSeparacao')
    Else
       SetCampoDefault('EdtProduto');
    ShowErro('Erro: '+vErro, 'alerta');
  End;
  JsonArrayVolumeExtra := Nil;
  ObjPedidoVolumeCtrl.Free;
end;

Procedure TFrmSeparacaoColetor.CancelarVolumeSemApanhe;
Var ObjPedidoVolumeCtrl      : TPedidoVolumeCtrl;
    JsonArrayVolumeExtra     : TJsonArray;
    JsonObjectCancelarVolume : TJsonObject;
    vErro : String;
begin
  inherited;
  OperacaoTipo := poFinalizar;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  JsonObjectCancelarVolume := TJsonObject.Create;
  JsonObjectCancelarVolume.AddPair('pedidoId', TJsonNumber.Create(0));
  JsonObjectCancelarVolume.AddPair('pedidoVolumeId', TJsonNumber.Create(StrToIntDef(EdtVolumeId.Text, 0)));
  JsonObjectCancelarVolume.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonObjectCancelarVolume.AddPair('terminal', NomeDoComputador);
  ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
  If RegistrarAberturaSeparacao(vVolumeSeparacaoId, Ord(operacaotipo), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) Then Begin
     JsonArrayVolumeExtra   := ObjPedidoVolumeCtrl.CancelarVolume(JsonObjectCancelarVolume);
     if Not JsonArrayVolumeExtra.Items[0].TryGetValue('Erro', vErro) then Begin
        vVolumeSeparacaoId := 0;
        StartSeparacao     := False;
        MensagemStand('Volume Cancelado com sucesso');
        Limpar(False);
     End
     Else
        ShowErro('Não foi possível Cancelar o Volume!', 'alerta');
  End
  Else
     ShowErro('Erro. Não foi possível cancelar!', 'alerta');
  JsonObjectCancelarVolume.Free;
  JsonArrayVolumeExtra := Nil;
  ObjPedidoVolumeCtrl.Free;
End;

procedure TFrmSeparacaoColetor.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtProduto' then Begin
     EdtProduto.ReadOnly       := False;
     EdtLoteSeparacao.ReadOnly := False;
     EdtProduto.Text := '';
     DelayEdSetFocus(EdtProduto);
  End
  Else if CampoDefault = 'EdtEmbalagemId' then Begin
     EdtEmbalagemId.Text := '';
     DelayEdSetFocus(EdtEmbalagemId);
  End
  Else if CampoDefault = 'EdtVolumeId' then Begin
     EdtVolumeId.Text := '';
     DelayEdSetFocus(EdtVolumeId);
  End
  Else if CampoDefault = 'EdtLoteSeparacao' then Begin
     EdtProduto.ReadOnly       := False;
     EdtLoteSeparacao.ReadOnly := False;
     EdtLoteSeparacao.Text := '';
     DelayEdSetFocus(EdtLoteSeparacao);
  End
  Else if CampoDefault = 'EdtQtdApanhe' then Begin
    EdtProduto.ReadOnly       := False;
    EdtLoteSeparacao.ReadOnly := False;
    EdtQtdApanhe.Text := '';
    DelayEdSetFocus(EdtQtdApanhe);
    EdtQtdApanhe.ReadOnly := False;
  End
  Else if CampoDefault = 'EdtQtdeApanheLoteF3' then Begin
    EdtProduto.ReadOnly       := False;
    EdtLoteSeparacao.ReadOnly := False;
    EdtQtdeApanheLoteF3.Text := '';
    DelayEdSetFocus(EdtQtdeApanheLoteF3);
    EdtQtdeApanheLoteF3.ReadOnly := False;
  End;
end;

procedure TFrmSeparacaoColetor.AtualizarContagem(pForcado : Boolean);
Var vQtdSuprida : Integer;
    vQtdApanheAtual, vQtdDigitada : Integer;
    vLote : String;
    vQuantidade, vQtdF3Press : Integer;
    ExibirMsgRaise : Boolean;
begin
  vQtdF3Press := 0;
  ExibirMsgRaise := True;
  if vQtdCorte = 0 then Begin
     If F3Press then Begin
        if Not LytLoteApanhe.Visible then //Sem identifação de Lotes
           vQuantidade := StrToIntDef(EdtQtdApanhe.Text, 0)*FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger
        Else
           vQuantidade := StrToIntDef(EdtQtdeApanheLoteF3.Text, 0)*FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger;
        vQtdF3Press := vQuantidade;
        if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0 then
           vQtdcorte := FdMemProdutos.FieldByName('Demanda').AsInteger - vQuantidade;
     End
     Else Begin
        if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0  then Begin
           if Not LytLoteApanhe.Visible then //Sem identifação de Lotes
              vQuantidade := FdMemProdutos.FieldByName('Demanda').AsInteger
           Else //Separação Com Identificação de Lotes
              vQuantidade := FDMemVolumeLotes.FieldByName('Demanda').AsInteger;
        End
        Else Begin
           vQuantidade := FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger;
        End;
     End;
  End
  Else begin
     if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1 then
        vQuantidade := 0
     Else Begin
        If F3Press then Begin
           vQuantidade := StrToIntDef(EdtQtdApanhe.Text, 0);
           vQtdF3Press := vQuantidade;
        End
        Else Begin
           vQuantidade := 0;
        End;
     End;
  End;
  dmeXactWMS.QryVolumeProdutoSalvar.Close;
  if F3Press then
     DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('F3Press').Value := 1
  Else
     DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('F3Press').Value := 0;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('CodProduto').Value     := FdMemProdutos.FieldByName('CodProduto').Asinteger;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('Quantidade').Value     := vQuantidade;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('QtdCorte').Value       := vQtdCorte;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('QtdF3Press').Value     := vQtdF3Press;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  //Salvar a coleta do Lotes quando identificado(controlado)
  if EdtLoteSeparacao.Text <> '' then Begin
     dmeXactWMS.QryVolumeLoteSalvar.Close;
     if F3Press then
        DmeXactWMS.QryVolumeLoteSalvar.ParamByName('F3Press').Value := 1
     Else
        DmeXactWMS.QryVolumeLoteSalvar.ParamByName('F3Press').Value := 0;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('CodProduto').Value     := FdMemProdutos.FieldByName('CodProduto').Asinteger;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Lote').Value           := EdtLoteSeparacao.Text;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Quantidade').Value     := vQuantidade;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('QtdCorte').Value       := vQtdCorte;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('QtdF3Press').Value     := vQtdF3Press;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  End;
  vQtdCorte := 0;
  EdtQtdeApanheLoteF3.Text := '';
  F3Press := False;
  Try
    DmeXactWMS.FdWmsSqlLite.StartTransaction;
    DmeXactWMS.QryVolumeProdutoSalvar.ExecSQL;
    if EdtLoteSeparacao.Text <> '' then
       if vQtdCorte = 0 then
          DmeXactWMS.QryVolumeLoteSalvar.ExecSQL
       Else
          DmeXactWMS.QryVolumeCorteLote.ExecSQL;
    //Atualizar Tela
    OpenVolumeProduto(FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger, FdMemProdutos.FieldByName('CodProduto').Asinteger);
    EdtQtdApanhe.Text := (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger Div DmeXactWMS.QryPesquisa.FieldByName('EmbalagemPadrao').AsInteger).ToString();
//13102023
    if ((DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger +
        DmeXactWMS.QryPesquisa.FieldByName('QtdCorte').AsInteger) = FdMemProdutos.FieldByName('Demanda').Asinteger) then Begin
       If (Not LytLoteApanhe.Visible) and(DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger>0) then
          RedistribuirApanheParaLotes
       Else With DmeXactWMS.QryVolumeCorteLote do Begin
         Close;
         ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger;
         ParamByName('CodProduto').value     := FdMemProdutos.FieldByName('CodProduto').Asinteger;
         ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
         eXecSql;
       End;;
    End
    else if ((DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger + DmeXactWMS.QryPesquisa.FieldByName('QtdCorte').AsInteger) = FdMemProdutos.FieldByName('Demanda').Asinteger) then Begin
       MensagemStand('Quantidade Maior que Demanda!');
       VerificarFinalizacaoOrContinuidadeSeparacao(pForcado);
       ExibirMsgRaise := False;
       raise Exception.Create('Quantidade Maior que Demanda!');
    End
    Else if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0 then
       RedistribuirApanheParaLotes;
    DmeXactWMS.FdWmsSqlLite.Commit;
    EdtProduto.ReadOnly       := False;
    EdtLoteSeparacao.ReadOnly := False;
    if (not LytLoteApanhe.Visible) then Begin
       EdtProduto.Text := '';
       DelayEdSetFocus(Edtproduto);
    End
    Else Begin
      EdtLoteSeparacao.Text := '';
      if EdtProduto.Text = '' then
         DelayEdSetFocus(EdtProduto)
      Else DelayEdSetFocus(EdtLoteSeparacao);
    End;
//13/10/2023  - Levar essa parte para uma função e replicar ela na validacao de quantidade acima
  Except On E: Exception do Begin
    DmeXactWMS.FdWmsSqlLite.Rollback;
    MontaListaLotes(True);
    EdtProduto.ReadOnly       := False;
    EdtLoteSeparacao.ReadOnly := False;
    if (LytLoteApanhe.Visible) and (EdtProduto.Text<>'') then
       SetCampoDefault('EdtLoteSeparacao')
    Else
       SetCampoDefault('EdtProduto');
    if exibirMsgRaise then ShowErro('Erro: '+E.Message);
    Exit;
    End;
  End;
  VerificarFinalizacaoOrContinuidadeSeparacao(pForcado);
end;

Procedure TFrmSeparacaoColetor.VerificarFinalizacaoOrContinuidadeSeparacao(pForcado : Boolean);
Begin
    OpenVolumeProduto(FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger, FdMemProdutos.FieldByName('CodProduto').Asinteger);
    EdtQtdApanhe.Text := (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger Div DmeXactWMS.QryPesquisa.FieldByName('EmbalagemPadrao').AsInteger).ToString();
    if (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger +
        DmeXactWMS.QryPesquisa.FieldByName('QtdCorte').AsInteger) >= FdMemProdutos.FieldByName('Demanda').Asinteger then Begin
       if not pForcado then Begin
          FdMemProdutos.Next;
          if FdMemProdutos.Eof then Begin
             Try FinalizarSeparacao Except End;
             Exit;
          End
          Else Begin
            Limpar(True);
            ShowProdutoParaSeparacao;
          End;
       End;
    End
    Else
       MontaListaLotes(True);
    atualizarTotalSeparacao;
End;

procedure TFrmSeparacaoColetor.AtualizarLotesSubstituicaoSqLite;
Var vLote : String;
begin
  DmexactWMS.QryVolumeLote.Close;
  DmexactWMS.QryVolumeLote.Sql.Clear;
  DmexactWMS.QryVolumeLote.Sql.Add('Select * from PedidoVolumeLote');
  DmeXactWMS.QryVolumeLote.SQL.Add('Where PedidoVolumeid = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
  DmeXactWMS.QryVolumeLote.Sql.Add('  And CodProduto = '+FdMemProdutos.FieldByName('CodProduto').AsString);
  DmeXactWMS.QryVolumeLote.Open;
  DmeXactWMS.FdWmsSqlLite.StartTransaction;
  Try
    //Apagar Lotes que foram substituídos
    While Not DmeXactWMS.QryVolumeLote.Eof do Begin
      vLote := DmeXactWMS.QryVolumeLote.FieldByName('Lote').AsString;
      FDMemLoteSubstituicao.First;
      if Not FDMemLoteSubstituicao.Locate('Lote', vLote, []) then Begin
         DmeXactWMS.QryPesquisa.Close;
         DmeXactWMS.QryPesquisa.Sql.Clear;
         DmeXactWMS.QryPesquisa.Sql.Add('Delete from PedidoVolumeLote');
         DmeXactWMS.QryPesquisa.Sql.Add('Where PedidoVolumeid = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
         DmeXactWMS.QryPesquisa.Sql.Add('  And CodProduto = '+FdMemProdutos.FieldByName('CodProduto').AsString);
         DmeXactWMS.QryPesquisa.Sql.Add('  And Lote = '+#39+vLote+#39);
         DmeXactWMS.QryPesquisa.ExecSql;
      End;
      DmeXactWMS.QryVolumeLote.Next;
    End;
//Incluir novos Lotes e alterar Demanda dos existentes
    FDMemLoteSubstituicao.First;
    while Not FDMemLoteSubstituicao.Eof do Begin
      vLote := FDMemLoteSubstituicao.FieldByName('Lote').AsString;
      DmeXactWMS.QryPesquisa.Close;
      DmeXactWMS.QryPesquisa.Sql.Clear;
      If DmeXactWMS.QryVolumeLote.Locate('Lote', vLote, []) then Begin
         DmeXactWMS.QryPesquisa.Sql.Add('Update PedidoVolumeLote');
         DmeXactWMS.QryPesquisa.Sql.Add('   Set Demanda = '+FDMemLoteSubstituicao.FieldByName('Demanda').AsString);
         DmeXactWMS.QryPesquisa.Sql.Add('Where PedidoVolumeId = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
         DmeXactWMS.QryPesquisa.Sql.Add('  And CodProduto = '+FdMemProdutos.FieldByName('CodProduto').AsString);
         DmeXactWMS.QryPesquisa.Sql.Add('  And Lote = '+#39+FDMemLoteSubstituicao.FieldByName('Lote').AsString+#39);
      End
      Else Begin
         DmeXactWMS.QryPesquisa.Sql.Add('Insert Into PedidoVolumeLote (PedidoVolumeId, CodProduto, LoteId, Lote, Fabricacao, Vencimento, ');
         DmeXactWMS.QryPesquisa.Sql.Add('                              Demanda, EmbalagemPadrao, DtInclusao, HrInclusao, UsuarioId, Terminal,');
         DmeXactWMS.QryPesquisa.Sql.Add('                              QtdSuprida, QtdApanhe, QtdCorte, Data, HorarioInicio, HorarioTermino)');
         DmeXactWMS.QryPesquisa.Sql.Add('  Values (');
         DmeXactWMS.QryPesquisa.Sql.Add(FdMemProdutos.FieldByName('PedidoVolumeId').AsString+', '+
                                        FdMemProdutos.FieldByName('CodProduto').AsString+', '+
                                        FDMemLoteSubstituicao.FieldByName('LoteId').AsString+', '+
                                        #39+FDMemLoteSubstituicao.FieldByName('Lote').AsString+#39+', '+
                                        #39+FDMemLoteSubstituicao.FieldByName('Fabricacao').AsString+#39+', '+
                                        #39+FDMemLoteSubstituicao.FieldByName('Vencimento').AsString+#39+', '+
                                        FDMemLoteSubstituicao.FieldByName('Demanda').AsString+', '+
                                        FDMemLoteSubstituicao.FieldByName('EmbalagemPadrao').AsString+', '+
                                        'date('+#39+'now'+#39+'), time('+#39+'now'+#39+', '+#39+'localtime'+#39+'), '+   //#39+FDMemLoteSubstituicao.FieldByName('DtInclusao').AsString+#39+', '+
                                        //#39+FDMemLoteSubstituicao.FieldByName('HrInclusao').AsString+#39+', '+
                                        '0, '+#39+#39+', 0, 0, 0, 0, 0, 0 )');
      End;
      DmeXactWMS.QryPesquisa.ExecSql;
      FDMemLoteSubstituicao.Next;
    End;
    DmeXactWMS.FdWmsSqlLite.Commit;
  Except On E: Exception do Begin
    DmeXactWMS.FdWmsSqlLite.Rollback;
    if DebugHook <> 0 then
       DmeXactWMS.QryPesquisa.Sql.SaveToFile('AtualizaLoteSubstituicao.Sql');
    raise Exception.Create('Erro na atualização dos lotes');
    End;
  End;
end;

procedure TFrmSeparacaoColetor.AtualizarSaldoColetado(pEnderecoId: Integer);
begin
  If DmeXactWMS.QryGetVolumeProduto.Locate('EnderecoId', pEnderecoId, []) then Begin
     FdMemProdutos.Edit;
     FdMemProdutos.FieldByName('QtdSuprida').AsInteger := DmeXactWMS.QryGetVolumeProduto.FieldByName('QtdSuprida').AsInteger;
     FdMemProdutos.Post
  End;
end;

procedure TFrmSeparacaoColetor.AtualizarSubstituicaoLotes;
Var ReturnJsonArray : TjsonArray;
    vErro : String;
begin
  ReturnJsonArray := DmClient.GetVolumeProdutoLotes(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger,
                                                    FdMemProdutos.FieldByName('Produtoid').AsInteger) ;
  If (ReturnJsonArray.Items[0].TryGetValue('Erro', vErro)) then Begin
     ShowErro(verro);
  End
  Else Begin
    If FDMemVolumeLotes.Active then
       FDMemVolumeLotes.EmptyDataSet;
    FDMemVolumeLotes.Close;
    FDMemVolumeLotes.LoadFromJSON(ReturnJsonArray, False);
  End;
  FDMemLoteSubstituicao.First;
  while Not FDMemLoteSubstituicao.Eof do Begin
    if FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger > 0 then Begin
       If FDMemVolumeLotes.Locate('codproduto;lote',
          VarArrayOf([FDMemLoteSubstituicao.FieldByName('CodProduto').AsString,
                      FDMemLoteSubstituicao.FieldByName('Lote').AsString]), []) then Begin
          FDMemVolumeLotes.Edit;
          FDMemVolumeLotes.FieldByName('QtdSuprida').AsInteger := FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger;
          FDMemVolumeLotes.Post;
       End;
    End;
    FDMemLoteSubstituicao.Next;
  End;
  ReturnJsonArray := Nil;
end;

procedure TFrmSeparacaoColetor.atualizarTotalSeparacao;
//Var xRecno          : Integer;
//    vtotalSeparacao : Integer;
begin
  With DmeXactWMS.QryPesquisa do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select Sum(Demanda) Demanda, Sum(QtdSuprida) QtdSeparada');
    Sql.Add('from pedidovolumeproduto');
    Sql.Add('where PedidoVolumeId = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
    Open;
    LblSkuVolume.Text   := FieldByName('Demanda').AsString;
    LblSkuSeparada.Text := FieldByName('QtdSeparada').AsString;
    Close;
  End;
end;

procedure TFrmSeparacaoColetor.ActCancelarApanheExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrmSeparacaoColetor.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  if LytLoteApanhe.Visible then
     DelayedSetFocus(EdtLoteSeparacao)
  else DelayedSetFocus(EdtProduto);
end;

procedure TFrmSeparacaoColetor.ActCancelarVolumeExtraExecute(Sender: TObject);
begin
  inherited;
  if not vFinalizarColeta then Begin// (FdMemProdutos.Eof) then Begin
     DelayEdSetFocus(EdtProduto);
     Exit;
  End;
  OperacaoTipo := poFinalizar;
  If RegistrarAberturaSeparacao(vVolumeSeparacaoId, Ord(operacaotipo), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) then Begin
     vVolumeSeparacaoId := 0;
     StartSeparacao     := False;
     Limpar(False);
  End;
end;

function TFrmSeparacaoColetor.AutorizarCorte: Boolean;
begin
  Result := True;
  if FrmeXactWMS.ConfigWMS.ApanheConsolidado = 1 then Begin
     If (FrmeXactWMS.ConfigWMS.CorteSupervisionado = 1) and
        (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Separação - Supervisionar Corte')) then Begin
        funcaoParaAutorizar := 'Separação - Supervisionar Corte';
        AtivarPanelSeguranca;
     End
     Else Result := ConfCorte;
  End;
end;

Function TFrmSeparacaoColetor.ConfCorte : Boolean;
begin
  Result := False;
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Confirmar Corte';
  if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1 then
     MsgD.Text   := 'Deseja Cortar '+IntToStr(((StrToIntDef(EdtQtdDemanda.Text, 0)-StrToIntDef(EdtQtdApanhe.Text, 0)))*
                                      FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger )+' unid. ?'
  Else MsgD.Text := 'Deseja Cortar '+IntToStr(StrToIntDef(EdtQtdDemanda.Text, 0)*FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger)+' unid. ?';

  MsgD.ActionOk   := ActConfirmarCorte;
  MsgD.ActionCancel := ActCancelar;
  MsgD.TypeInfo   := tMsgDInformation;

  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

procedure TFrmSeparacaoColetor.ConfirmacaoCancel;
Var JsonArrayRetorno : TJsonArray;
begin
  inherited;
  case CodConfirmacao Of
    1: Begin
       OperacaoTipo := poFinalizar;
       ConfirmadoVolumeExtra(False);
       ChgTabDet.Execute;
       Exit;
    End;
    2: Begin
       FdMemProdutos.First;
       With DmeXactWMS.QryPesquisa do Begin
         Close;
         Sql.Clear;
         Sql.Add('Update PedidoVolumeProduto Set QtdSuprida= 0, QtdCorte = 0');
         Sql.Add('Where PedidoVolumeId = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
         Sql.Add('  And CodProduto = '+FdMemProdutos.FieldByName('CodProduto').AsString+';');
         Sql.Add('Update PedidoVolumeLote Set QtdSuprida= 0, QtdCorte = 0');
         Sql.Add('Where PedidoVolumeId = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
         Sql.Add('  And CodProduto = '+FdMemProdutos.FieldByName('CodProduto').AsString+';');
         ExecSql;
         Close;
       End;
       ShowProdutoParaSeparacao;
       ChgTabDet.Execute;
       ShowOk('Último item reiniciado.');
    End;
    3: Begin
       if (Not LytLoteApanhe.Visible) or (EdtProduto.Text='') then
          DelayEdSetFocus(EdtProduto)
       Else DelayEdSetFocus(EdtLoteSeparacao);
       ChgTabDet.Execute;
    End;
    4: Begin
       ShowOk('Vc deve clicar em SIM para Finalizar!');
    End;
    5: Begin
       PgcPrincipal.ActiveTab := TabDetalhes;
    End
    Else
       ChgTabDet.Execute;
  end;
end;

procedure TFrmSeparacaoColetor.ConfirmacaoExecute;
Var Th : TThread;
begin
  inherited;
  case CodConfirmacao Of
    1: Begin
       OperacaoTipo := poFinalizar;
       ConfirmadoVolumeExtra(True);
       ChgTabDet.Execute; //PgcPrincipal.ActiveTab := TabDetalhes;
    End;
    2: Begin
       CancelarVolumeSemApanhe;
       ChgTabDet.Execute; //PgcPrincipal.ActiveTab := TabDetalhes;
    End;
    3: Begin  //Pressionado F9 para Extra de Excesso/Falta
       EdtLoteSeparacao.Text := '';
       if (Not FdMemProdutos.Eof) and (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and
          (StrToIntDef(EdtQtdApanhe.Text, 0) > 0) then Begin
           vQtdCorte := FdMemProdutos.FieldByName('Demanda').AsInteger -
                        StrToIntDef(EdtQtdApanhe.Text, 0);
          LytLoteApanhe.Visible := (FdMemProdutos.FieldByName('LoteSeparacao').AsInteger = 1) and (vApanheConsolidadoSetor);
          AtualizarContagem(True);
          FdMemProdutos.Next;
       End;
       while Not FdMemProdutos.Eof do Begin
         LytLoteApanhe.Visible := False;
         vQtdCorte := FdMemProdutos.FieldByName('Demanda').AsInteger;
         ZerarLoteParaExtraExcesso;
         FdMemProdutos.Next;
       End;
       OperacaoTipo := poFinalizar;
       ConfirmadoVolumeExtra(True);
       ChgTabDet.Execute;
    End;
    4: Begin
       Try
         FinalizarSeparacao;
         ChgTabDet.Execute; //PgcPrincipal.ActiveTab := TabDetalhes;
       Except

       End;
    End;
    5: Begin
       ConfirmaResetVolume(StrToIntDef(EdtVolumeId.Text, 0));
       PgcPrincipal.ActiveTab := TabDetalhes;
       ShowOk('Reset realizado!');
    End
    Else
       ChgTabDet.Execute; //PgcPrincipal.ActiveTab := TabDetalhes;
  end;
end;

procedure TFrmSeparacaoColetor.ConfirmadoVolumeExtra(pGerarVolumeExtra : Boolean);
Var Th : TThread;
begin
  inherited;
  Th := TThread.CreateAnonymousThread(procedure
  Begin
    PutColetaAPI(pGerarVolumeExtra);
  End);
  Th.OnTerminate := ThreadTerminateLogOff;
  Th.Start;
end;

procedure TFrmSeparacaoColetor.FinalizarComDivergencia;
begin
  CodConfirmacao := 20000;
  LblTituloConfirmacao.Text := 'Divergência(s) no Volume.';
  LblTituloFoot.Text        := 'Volume com corte(s) de produtos.';
  LblMensagem1.Text := 'Finalizar com Divergência?';
  LblMensagem2.Text := 'os cortes serão registrado no volume.';
//  PgcPrincipal.ActiveTab := TabConfirmacao;
  ChgTabConFirmacao.Execute;
end;

Procedure TFrmSeparacaoColetor.ConfirmarCancelamentoDeVolume;
Begin
  CodConfirmacao := 2;
  LblTituloConfirmacao.Text := 'Cancelar Extra';
  LblTituloFoot.Text        := 'Não houve Apanhe de produto(s) neste volume.';
  LblMensagem1.Text := 'Cancelar Volume?';
  LblMensagem2.Text := 'Ocorreu corte total em todos os produtos.';
//  PgcPrincipal.ActiveTab := TabConfirmacao;
  ChgTabConfirmacao.Execute;
End;

procedure TFrmSeparacaoColetor.ConfirmarGeracaoVolumeExtra;
begin
  CodConfirmacao := 1;
  LblTituloConfirmacao.Text := 'Volume Extra';
  LblTituloFoot.Text        := 'Divergências serão lançadas em novo volume.';
  LblMensagem1.Text := 'Gerar Volume Extra?';
  LblMensagem2.Text := 'Existe Divergência na coleta.';
  //PgcPrincipal.ActiveTab := TabConfirmacao;
  ChgTabConfirmacao.Execute;
end;

procedure TFrmSeparacaoColetor.ConfirmarGeracaoVolumeExtraForcado;
begin
  CodConfirmacao := 3;
  LblTituloConfirmacao.Text := 'Volume Extra - Excesso';
  LblTituloFoot.Text        := 'Divergência(s) e não coletados serão lançadas em novo volume.';
  LblMensagem1.Text := 'Gerar Volume Extra de Excesso?';
  LblMensagem2.Text := 'Volume será gerado devido excesso na caixa.';
  //PgcPrincipal.ActiveTab := TabConfirmacao;
  ChgTabConfirmacao.Execute;
end;

procedure TFrmSeparacaoColetor.ConfirmarResetVolume;
begin
  CodConfirmacao := 5;
  LblTituloConfirmacao.Text := 'Resetar Volume';
  LblTituloFoot.Text        := 'Produtos já coletar retornar ao Picking.';
  LblMensagem1.Text := 'Resetar Volume?';
  LblMensagem2.Text := 'Toda a coleta será desfeita.';
  //PgcPrincipal.ActiveTab := TabConfirmacao;
  ChgTabConfirmacao.Execute;
end;

procedure TFrmSeparacaoColetor.BtnLogInClick(Sender: TObject);
begin
  FuncionalidadeCtrlSeg := 'Separação - Supervisionar Corte';
  inherited;
end;

procedure TFrmSeparacaoColetor.BuscarVolumeLotesParaSeparacao(pEnderecoInicial : Integer);
Var JsonArrayRetorno    : TjsonArray;
    vDemanda, vSeparado : Integer;
    xRecno              : Integer;
    vPosicaoInicial     : Boolean;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vAbertura           : Boolean;
    vErro : String;
begin
//  JsonArrayRetorno := DmClient.BuscarVolumeProdutosParaSeparacao(0, StrToIntDef(EdtVolumeId.Text, 0));
  vAbertura := True;
  If FdMemProdutos.Active then
     FdMemProdutos.EmptyDataSet;
  FdMemProdutos.Close;
  DmeXactWMS.QryGetVolumeProduto.Close;
  DmeXactWMS.QryGetVolumeProduto.ParamByName('PedidoVolumeId').Value := StrToIntDef(EdtVolumeId.Text, 0);
  DmeXactWMS.QryGetVolumeProduto.Open;
  if DmeXactWMS.QryGetVolumeProduto.IsEmpty then Begin
     vAbertura := True;
     JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeProdutosParaSeparacao(0, StrToIntDef(EdtVolumeId.Text, 0));
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro('Erro: '+vErro);
        JsonArrayRetorno := Nil;
        Limpar(False);
        Exit;
     End;
     FdMemProdutos.LoadFromJson(JsonArrayRetorno, False);
     InsertVolumeProdutoSqlLite;
     FdMemProdutos.First;
     JsonArrayRetorno := Nil;
  End
  Else Begin
    vAbertura := False;
    JsonArrayRetorno := DmeXactWMS.QryGetVolumeProduto.ToJSONArray;
    FdMemProdutos.LoadFromJson(JsonArrayRetorno, False);
    FdMemProdutos.First;
    if pEnderecoInicial > 0 then Begin//Recuperar último endereço coletado, quando sair sem RegistrarSeparacao
       FdMemProdutos.Locate('EnderecoId', pEnderecoInicial, []);
       FdMemProdutos.Next;
       if FdMemprodutos.Eof then Begin
          JsonArrayRetorno := Nil;
          MensagemStand('Coleta completa. Finalizado Vol: '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
          sleep(1000);
          FinalizarSeparacao;
          exit;
       End;
    End;
    while Not FdMemProdutos.Eof do Begin
      if (FdMemProdutos.FieldByName('UsuarioId').AsInteger = 0) then
         Break
      Else if (FdMemProdutos.FieldByname('QtdSuprida').AsInteger+
         FdMemProdutos.FieldByname('QtdCorte').AsInteger < FdMemProdutos.FieldByname('Demanda').AsInteger) then Begin
         Break;
      End;
      if (FdMemProdutos.FieldByname('QtdSuprida').AsInteger+
          FdMemProdutos.FieldByname('QtdCorte').AsInteger >= FdMemProdutos.FieldByname('Demanda').AsInteger) then
         pEnderecoInicial := FdMemProdutos.FieldByName('EnderecoId').AsInteger;
      FdMemProdutos.Next;
    End;
    JsonArrayRetorno := Nil;
  End;
  GetVolumeEan;
  vDemanda  := 0;
  vSeparado := 0;
  vPosicaoInicial := False;
  FdMemProdutos.First;
  if pEnderecoInicial <> 0 then Begin
     If FdMemProdutos.Locate('EnderecoId', pEnderecoInicial, []) then Begin
        FdMemProdutos.Next;
        if FdMemProdutos.Eof then Begin
           MensagemStand('Coleta completa. Finalizado Vol: '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString);
           FinalizarSeparacao;
        End;
     End;
     xRecno := FdMemProdutos.Recno;
     while Not FdMemProdutos.Eof do Begin
       FdMemProdutos.Edit;
       FdMemProdutos.FieldByName('QtdSuprida').AsInteger := 0;
       FdMemProdutos.Post;
       FdMemProdutos.Next;
     End;
     FdMemProdutos.Recno := xRecno;
  End
  Else If vAbertura then Begin
    xRecno := FdMemProdutos.Recno;
    while Not FdMemProdutos.Eof do Begin
      FdMemProdutos.Edit;
      FdMemProdutos.FieldByName('QtdSuprida').AsInteger := 0;
      FdMemProdutos.Post;
      FdMemProdutos.Next;
    End;
    FdMemProdutos.Recno := xRecno;
  End;
  JsonArrayRetorno := Nil;
  if pEnderecoInicial <> 0 then
     AtualizarSaldoColetado(FdMemProdutos.FieldByName('EnderecoId').AsInteger);
  atualizarTotalSeparacao;
  Limpar(True);
  ShowProdutoParaSeparacao;
end;

procedure TFrmSeparacaoColetor.CabecalhoPedido(pPedidoId: Integer; pRazao,
  pDocumentoData: String; pRotaid: Integer);
begin
  LblPedido.Text   := pPedidoId.ToString();
  LblDestino.Text  := pRazao;
  EdtDtPedido.Text := Copy(pDocumentoData, 9, 2)+'/'+Copy(pDocumentoData, 6, 2)+'/'+Copy(pDocumentoData, 1, 4);
  LblRota.Text     := pRotaId.ToString();
end;

procedure TFrmSeparacaoColetor.CallAlteracaoLotes;
begin
  PgcPrincipal.ActiveTab := TabSubstituirLote;
  CbLoteSubstituto.Visible := False;
  LimparLoteSubstituicao;
  EdtCodProdutoSubstituto.Text := FdMemProdutos.FieldByName('CodProduto').AsString;
  EdtCodProdutoSubstituto.Tag  := FdMemProdutos.FieldByName('CodProduto').AsInteger;
  LblProdutoDescricaoSubstituir.Text := FdMemProdutos.FieldByName('Descricao').AsString;
  if FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger = 1 then
     EdtUnidSubstituto.Text := 'Unid'
  Else EdtUnidSubstituto.Text := 'Cxa C/'+FdMemProdutos.FieldByName('EmbalagemPadrao').AsString;
  if LytLoteApanhe.Visible then
     EdtDemandaSubstituto.Text   := GetProdutoSeparado.ToString()  //(FdMemProdutos.FieldByName('Demanda').AsInteger-
                                    // FdMemProdutos.FieldByName('QtdSuprida').AsInteger).ToString
  Else EdtDemandaSubstituto.Text := FdMemProdutos.FieldByName('Demanda').AsString;
  DelayEdSetFocus(EdtLoteSubstituir);//   CbLoteSubstituto);
  if FdMemLoteSubstituicao.Active then
     FDMemLoteSubstituicao.EmptyDataSet;
  FDMemLoteSubstituicao.Close;
  FDMemLoteSubstituicao.Open;
  FDMemLoteSubstituicao.CopyDataSet(FDMemVolumeLotes);
  GetLotesSubstituto;
end;

procedure TFrmSeparacaoColetor.CbLoteSubstitutoChange(Sender: TObject);
begin
  inherited;
  if CbLoteSubstituto.ItemIndex < 0 then Exit;
  if FDMemEstoqueLotes.Locate('DescrLote', CbLoteSubstituto.Items[CbLoteSubstituto.ItemIndex], []) then Begin
     LblLoteFabricacao.Text := FDMemEstoqueLotes.FieldByName('Fabricacao').AsString;
     LblLoteVencimento.Text := FDMemEstoqueLotes.FieldByName('Vencimento').AsString;
  End;
end;

procedure TFrmSeparacaoColetor.CbLoteSubstitutoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then Begin
     Key := 0;
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
  End;
end;

Procedure TFrmSeparacaoColetor.LimparCabecalhoPedido;
Begin
  LblPedido.Text   := '';
  LblDestino.Text  := '';
  EdtDtPedido.Text := '';
  LblRota.Text     := '';
End;

procedure TFrmSeparacaoColetor.EdtCodProdutoSubstitutoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
Var JsonObjectProduto : TJsonObject;
    vCodSubstituto    : Integer;
    vCodBarra         : String;
begin
  inherited;
  If (key = vkReturn) and (EdtCodProdutoSubstituto.Text<>'') then Begin
     If (StrToInt64Def(EdtCodProdutoSubstituto.Text, 0)>0) Then Begin
        JsonObjectProduto := DmClient.GetCodProdEan(EdtCodProdutoSubstituto.Text);
        vCodSubstituto := JsonObjectProduto.GetValue<Integer>('produtoid');
        if (vCodSubstituto <> 0) and (EdtCodProdutoSubstituto.Text <> JsonObjectProduto.GetValue<String>('ean')) then Begin
           EdtCodProdutoSubstituto.Text := '';
           DelayEdSetFocus(EdtCodProdutoSubstituto);
           MensagemStand('Informe o Ean/Código do produto!');
           Exit;
        End;
        if vCodSubstituto <> FdMemProdutos.FieldByName('ProdutoId').AsInteger then  Begin
           vCodBarra := EdtCodProdutoSubstituto.Text;
           EdtCodProdutoSubstituto.Text := '';
           raise Exception.Create('Produto('+vCodBarra+') não encontrado!');
        End
        Else Begin
           LblProdutoDescricaoSubstituir.Text := FdMemProdutos.FieldByName('Descricao').AsString;
           EdtDemandaSubstituto.Text          := FdMemProdutos.FieldByName('Demanda').AsString;
           if FdMemProdutos.FieldByName('EmbalagemPadrao').Asinteger = 1 then
              EdtUnidSubstituto.Text             := FdMemProdutos.FieldByName('Embalagem').AsString
           Else EdtUnidSubstituto.Text := FdMemProdutos.FieldByName('EmbalagemPadrao').AsString;
           GetLotesSubstituto;
        End;
        JsonObjectProduto := Nil;
     End
     Else Begin
        EdtCodProdutoSubstituto.Text := '';
        DelayedSetFocus(EdtCodProdutoSubstituto);
        raise Exception.Create('Código produto inválido!');
     End;
  End;
end;

procedure TFrmSeparacaoColetor.EdtCodProdutoSubstitutoTyping(Sender: TObject);
begin
  inherited;
  LimparLoteSubstituicao;
end;

procedure TFrmSeparacaoColetor.EdtEmbalagemIdKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmSeparacaoColetor.EdtEmbalagemIdKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkF2 then Begin
     FrmeXactWMS.BrnMenuClick(Sender);
     Exit;
  End;
  inherited;
//  if (key = 13) and (EdtEmbalagemId.Text<>'') then
//     DelayedSetFocus(EdtVolumeid);
end;

procedure TFrmSeparacaoColetor.EdtEmbalagemIdValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if (EdtEmbalagemId.Text = '') then
     Exit
  Else if EdtEmbalagemId.Text = '0' then
     DelayEdSetFocus(EdtVolumeId)
  Else if StrToIntDef(EdtEmbalagemId.Text, 0) > 0 then
     ValidarVolume
  Else Begin
     SetCampoDefault('EdtEmbalagemId');
     ShowErro('Númeração de Caixa Inválida!');
  End;
end;

procedure TFrmSeparacaoColetor.EdtLoteSeparacaoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  If key = vkReturn then Begin
     if EdtLoteSeparacao.Text = '' then DelayEdSetFocus(EdtLoteSeparacao);
     DelayEdSetFocus(EdtDesativarDigitacao);
     if (EdtLoteSeparacao.Text = '') or (Not ValidarColetaLote) then Begin
        DelayEdSetFocus(EdtLoteSeparacao);
        Exit;
     End
     Else
        AtualizarContagem(False); //SalvarItemColetado;
  End
  Else If (Key = VkF3) and (EdtProduto.Text<>'') then Begin
      if ((FrmeXactWMS.ConfigWMS.ApanheConsolidado = 0) or (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0) or
         ((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and (StrToIntDef(EdtQtdDemanda.Text,0)>FrmeXactWMS.ConfigWMS.BeepIndividualLimiteUnid))) then Begin
         F3Press := True;
         if LytLoteApanhe.Visible then Begin
           EdtQtdeApanheLoteF3.ReadOnly := False;
           DelayedSetFocus(EdtQtdeApanheLoteF3);
         End
         Else Begin
           EdtQtdApanhe.ReadOnly := False;
           DelayedSetFocus(EdtQtdApanhe);
         End;
     End;
  End
  Else if (Key= VkF6) then
     AutorizarCorte
  Else if (Key = vkF7) and (pPanelDigitarProduto) then Begin
     CallAlteracaoLotes;
  End
  Else if (Key = vkF8) then Begin
    //If (StartSeparacao) then
       ResetVolume;
  End
  Else if (Key = vkF9) then Begin
    If (Not GetVolumeComDivergencia) then Begin
       totalizarColeta(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger);
       if (FdMemProdutos.RecordCount = 1) and (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then Begin
          ConfirmarCancelamentoDeVolume;
          Exit;
       End
       Else if (Not LytLoteApanhe.Visible) or (EdtProduto.Text='') then
          SetCampoDefault('EdtProduto')
       Else SetCampoDefault('EdtLoteSeparacao');
       ShowErro('Volume Extra não permitido!');
       Exit;
    End;
    If (pPanelDigitarProduto) then Begin
       if (FdMemProdutos.RecordCount = 1) and (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then
          ConfirmarCancelamentoDeVolume
       Else
          ConfirmarGeracaoVolumeExtraForcado;
    End;
  End;
end;

Function TFrmSeparacaoColetor.ValidarColetaLote : Boolean;
Begin
  Result := False;
  If (EdtLoteSeparacao.Text <> '') and (EdtProduto.Text = '') then Begin
     EdtLoteSeparacao.Text := '';
     SetCampoDefault('EdtProduto');
     ShowErro('Beep o produto!', 'alerta');
     EdtProduto.ReadOnly := False;
     EdtLoteSeparacao.ReadOnly := False;
     Exit;
  End;
  FDMemVolumeLotes.First;
  if Not FDMemVolumeLotes.Locate('codproduto;lote', VarArrayOf([FdMemProdutos.FieldByName('CodProduto').AsString, EdtLoteSeparacao.Text]), []) then Begin
     SetCampoDefault('EdtLoteSeparacao');
     ShowErro('Lote('+EdtLoteSeparacao.Text+') inválido para o Volume!', 'alarme');
     EdtLoteSeparacao.ReadOnly := False;
     EdtProduto.ReadOnly := False;
     Exit;
  End;
  Result := ValidaLoteSeparado;
End;

procedure TFrmSeparacaoColetor.EdtLoteSubstituirExit(Sender: TObject);
begin
  inherited;
  if EdtLoteSubstituir.Text = '' then Exit;
  if FDMemEstoqueLotes.Locate('DescrLote', EdtLoteSubstituir.Text, []) then Begin
     LblLoteFabricacao.Text := FDMemEstoqueLotes.FieldByName('Fabricacao').AsString;
     LblLoteVencimento.Text := FDMemEstoqueLotes.FieldByName('Vencimento').AsString;
     DelayEdSetFocus(EdtQtdeSubstituto);
  End
  Else Begin
     ShowErro('Lote('+EdtLoteSubstituir.Text+') inválido!', 'alerta');
     DelayEdSetFocus(EdtLoteSubstituir);
  End;
end;

procedure TFrmSeparacaoColetor.EdtLoteSubstituirKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  If Key = 13 then Begin
     Key := 0;
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
  End;
end;

procedure TFrmSeparacaoColetor.EdtProdutoChange(Sender: TObject);
begin
  inherited;
  EdtLoteSeparacao.Text := '';
end;

procedure TFrmSeparacaoColetor.EdtProdutoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmSeparacaoColetor.EdtProdutoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
Var vCod : Integer;
    vCodBarra, vErro   : String;
    vQtdSuprida        : Integer;
    ObjProdutoCtrl     : TProdutoCtrl;
begin
  inherited;
  If (Key = vkReturn) and (EdtProduto.Text<>'') then Begin
     If (FrmeXactWMS.ConfigWMS.SeparacaoCodInterno = 0) and
        (EdtProduto.Text = FdMemProdutos.FieldByName('CodProduto').AsString) then Begin
        SetCampoDefault('EdtProduto');
        ShowErro('Scanear o EAN do produto!');
        Exit;
     End;
     DelayEdSetFocus(EdtDesativarDigitacao);
     if (StrToInt64Def(EdtEmbalagemId.Text, 0) <> 0) and
        (StrToInt64Def(EdtProduto.Text, 0) = StrToInt64Def(EdtEmbalagemId.Text, 0))then Begin
        LogOff;
        Exit;
     End
     Else if (Not ValidarColetaProduto) then Begin
        DelayEdSetFocus(EdtProduto);
        Exit;
     End
     Else
        RegistrarColetaProduto;
  End
  Else If Key = vkF2 then
    FrmeXactWMS.BrnMenuClick(Sender)
  Else If Key = vkF3 then Begin
    if ((FrmeXactWMS.ConfigWMS.ApanheConsolidado = 0) or (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0) or
       ((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and (StrToIntDef(EdtQtdDemanda.Text,0)>FrmeXactWMS.ConfigWMS.BeepIndividualLimiteUnid))) then Begin
       F3Press := True;
       if LytLoteApanhe.Visible then Begin
         EdtQtdeApanheLoteF3.ReadOnly := False;
         DelayedSetFocus(EdtQtdeApanheLoteF3);
         EdtProduto.ReadOnly       := False;
         EdtLoteSeparacao.ReadOnly := False;
       End
       Else Begin
         EdtQtdApanhe.ReadOnly := False;
         DelayedSetFocus(EdtQtdApanhe);
         EdtProduto.ReadOnly       := False;
         EdtLoteSeparacao.ReadOnly := False;
       End;
    End;
  End
  Else If Key = vkF5 then Begin
     DelayEdSetFocus(EdtDesativarDigitacao);
     If (StrToIntDef(EdtQtdApanhe.text, 0) = 0) or (OperacaoTipo = poFinalizar) Or
        (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0) then
        LogOff
     Else Begin
        if (Not LytLoteApanhe.Visible) or (EdtProduto.Text='') then
           SetCampoDefault('EdtProduto')
        Else
           SetCampoDefault('EdtLoteSeparacao');
        MensagemStand('Para fazer Logoff, conclua separação do item.');
     End;
  End
  Else If Key = vkF6 then AutorizarCorte
  Else If Key = vkF7 then Begin
    If (pPanelDigitarProduto) then
       CallAlteracaoLotes;
  End
  Else If Key = vkF9 then Begin
    vTotSeparadoBeforeLogOff := 0;
    If (Not GetVolumeComDivergencia) then Begin
       totalizarColeta(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger);
       if (FdMemProdutos.RecordCount = 1) and (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then Begin
          ConfirmarCancelamentoDeVolume;
          Exit;
       End
       Else If (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger)+vTotSeparadoBeforeLogOff = 0 Then Begin
          ShowErro('Não há itens separado. Cancele o Pedido!');
          Exit;
       End;
      End;
    If (pPanelDigitarProduto) then Begin
       if (FdMemProdutos.RecordCount = 1) and (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then
          ConfirmarCancelamentoDeVolume
       Else Begin
          ConfirmarGeracaoVolumeExtraForcado;
       End;
    End;
  End
  Else If Key = vkF8 then Begin
    DelayEdSetFocus(EdtDesativarDigitacao);
    ResetVolume;
  End;
end;

Function TFrmSeparacaoColetor.ValidarColetaProduto : Boolean;
Var vCod : Integer;
    vCodBarra, vErro : String;
Begin
  Result := False;
  if Length(EdtProduto.Text) > 25 then Begin
     SetCampoDefault('EdtProduto');
     ShowErro('Código/Ean inválido!');
     Exit;
  End
  Else If (StrToInt64Def(EdtProduto.Text, 0)<=0) Then Begin
     SetCampoDefault('EdtProduto');
     ShowErro('Código Produto ('+EdtProduto.Text+') inválido!', 'apito');
     Exit;
  End
  Else Begin
     vCod := 0;
     vCodBarra := EdtProduto.Text;
     If StrToInt64Def(EdtProduto.Text, 0) <> FdMemProdutos.FieldByName('CodProduto').AsLargeInt then Begin
        FdMemVolumeEAN.First;
        If FdMemVolumeEAN.Locate('CodBarras', EdtProduto.Text, []) then Begin
           vCod := FdMemVolumeEAN.FieldByName('ProdutoId').AsInteger;
           if FdMemVolumeEAN.FieldByName('ProdutoId').AsInteger = FdMemProdutos.FieldByName('ProdutoId').AsInteger then
              EdtProduto.Text := FdMemProdutos.FieldByName('CodProduto').AsString;
        End;
     End
     Else
        vCod := FdMemProdutos.FieldByName('ProdutoId').AsInteger;
     If vCod = 0 then Begin
        EdtProduto.Text := '';
        SetCampoDefault('EdtProduto');
        ShowErro('Código/EAN('+vCodBarra+') de produto inválido!', 'apito');
        Exit;
     End;
     if vCod <> FdMemProdutos.FieldByName('ProdutoId').AsInteger then  Begin
        SetCampoDefault('EdtProduto');
        ShowErro('Produto('+vCodBarra+') incorreto para Separação!', 'apito');
        Exit;
     End;
  End;
  if ((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0) and (StrToIntDef(EdtQtdApanhe.Text, 0)   > (FdMemProdutos.FieldByName('Demanda').AsInteger Div FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger))) or
     ((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and (StrToIntDef(EdtQtdApanhe.Text, 0)+IfThen(F3Press, 0 , 1) > (FdMemProdutos.FieldByName('Demanda').AsInteger Div FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger))) then Begin
     EdtProduto.Text := '';
     DelayedSetFocus(EdtProduto);
     MensagemStand('Quantidade maior que demanda. Qtde não alterada.');
     AtualizarContagem(False);
     //Vefificar mudanca de Produto para Coleta
     Exit;
  End
  Else if StrToIntDef(EdtQtdApanhe.Text, 0) < 0 then Begin
     EdtProduto.Text := '';
     EdtQtdApanhe.Text := '0';
     DelayedSetFocus(EdtQtdApanhe);
     MensagemStand('Quantidade inválida. Informe corretamente(0 a '+FdMemProdutos.FieldByName('Demanda').AsString+').');
     Exit;
  End;
  Result := True;
End;

Procedure TFrmSeparacaoColetor.RegistrarColetaProduto;
Begin
  If FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0 then
     vQtdCorte := FdMemProdutos.FieldByName('Demanda').AsInteger - (StrToIntDef(EdtQtdApanhe.Text, 0)*FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger);
  if LytLoteApanhe.Visible then
     DelayEdSetFocus(EdtLoteSeparacao)
  Else
     AtualizarContagem(False);
End;

procedure TFrmSeparacaoColetor.EdtQtdApanheKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = vkReturn) and (Not EdtQtdApanhe.ReadOnly) then
     if (Not LytLoteApanhe.Visible) or (EdtProduto.Text='') then
        DelayedSetFocus(EdtProduto)
     else
        DelayEdSetFocus(EdtLoteSeparacao);
end;

procedure TFrmSeparacaoColetor.EdtQtdeApanheLoteF3Validate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtQtdeApanheLoteF3.Text = '' then Begin
     F3Press := False;
     EdtQtdeApanheLoteF3.ReadOnly := True;
     if (Not LytLoteApanhe.Visible) or (EdtProduto.Text = '') then
        DelayEdSetFocus(EdtProduto)
     Else
        DelayEdSetFocus(EdtLoteSeparacao);
     Exit;
  End;
  if StrToIntDef(EdtQtdeApanheLoteF3.Text, 0) <= 0 then Begin
     SetCampoDefault('EdtQtdeApanheLoteF3');
     ShowErro('Quantidade inválida');
     Exit;
  End;
  DelayEdSetFocus(EdtLoteSeparacao);
end;

procedure TFrmSeparacaoColetor.EdtQtdeSubstitutoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  If Key = 13 then Begin
     Key := 0;
     if StrToIntDef(EdtQtdeSubstituto.Text, 0) <= 0 then Begin
        ShowErro('Quantidade inválida!');
        EdtQtdeSubstituto.Text := '';
        DelayEdSetFocus(EdtQtdeSubstituto);
     End
     Else if StrToIntDef(EdtQtdeSubstituto.Text, 0) > FdMemProdutos.FieldByName('Demanda').AsInteger then Begin
        ShowErro('Quantidade superior a demanda! Exclua lote(s) na grid abaixo.');
        EdtQtdeSubstituto.Text := '';
        DelayEdSetFocus(EdtQtdeSubstituto);
     End;
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     if Sender = EdtQtdeSubstituto then
        SbSalvarLoteSubstitutoClick(SbSalvarLoteSubstituto);
  End;
end;

procedure TFrmSeparacaoColetor.EdtVolumeIdKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmSeparacaoColetor.EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkF2 then Begin
     FrmeXactWMS.BrnMenuClick(Sender);
     Exit;
  End;
  inherited;
  if (Length(EdtVolumeId.Text)>20) or (StrToIntDef(EdtVolumeId.Text, 0) = 0) then Exit;
  vCtrlErroFinalizacao := 1;
  if key = 13 then Begin
     if StrToIntDef(EdtVolumeId.Text, 0) < 0 then Begin
        SetCampoDefault('EdtVolumeId');
        ShowErro('Id de Volume inválido');
        Exit;
     End;
     If (FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1) and ((StrToIntDef(EdtEmbalagemId.Text, 0)<0) or (EdtEmbalagemId.Text=''))then Begin
        DelayedSetFocus(EdtEmbalagemId);
     End
     Else
        ValidarVolume;
  End;
end;

procedure TFrmSeparacaoColetor.EdtVolumeIdTyping(Sender: TObject);
begin
  inherited;
  if (EdtEmbalagemid.Text='') and (FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1) then Begin
     EdtVolumeid.text := '';
     DelayEdSetFocus(EdtEmbalagemId);
  End;
end;

Function TFrmSeparacaoColetor.GetVolumeComDivergencia : Boolean;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno    : TJsonArray;
    vErro : String;
Begin
  Try
    Result := False;
    ObjPedidoVolumeCtrl := TPEdidoVolumeCtrl.Create;
    JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeComDivergencia( FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger, vEnderecoIdSeparado );
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Erro: '+vErro);
       Result := False
    End
    Else Begin
      vTotSeparadoBeforeLogOff := JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida');
      if (JsonArrayRetorno.Items[0].GetValue<Integer>('quantidade') >
         JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida')) and (JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida')>0) then //and
         Result := True
{      Else Begin
         totalizarColeta(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger);
         if ((DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger>0) and
             (DmeXactWMS.QryPesquisa.FieldByName('Demanda').AsInteger > DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger)) or
             (DmeXactWMS.QryPesquisa.FieldByName('QtdCorte').AsInteger>0) then
            Result := True;
      End;
}    End;
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
  Except ON E: Exception do Begin
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
    raise Exception.Create(E.Message);
    End;
  End;
End;

procedure TFrmSeparacaoColetor.GetVolumeEan;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  If FdMemVolumeEAN.Active then
     FdMemVolumeEAN.EmptyDataSet;
  FdMemVolumeEAN.Close;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeEAn(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger);
  if JsonArrayRetorno.TryGetValue('Erro', vErro) then
     ShowErro('Não foi possível pegar os EAN.')
  Else
     FdMemVolumeEAN.LoadFromJSON(JsonArrayRetorno, False);
  FdMemVolumeEAN.Open;
  JsonArrayRetorno := Nil;
  ObjPedidoVolumeCtrl.Free;
end;

procedure TFrmSeparacaoColetor.FinalizarSeparacao;
Var xRecno, vTotalApanhe : Integer;
    Th : TThread;
begin
  OperacaoTipo := poFinalizar;
  DmeXactWMS.QryVolumeDivergencia.Close;
  DmeXactWMS.QryVolumeDivergencia.ParamByName('pPedidoVolumeId').Value := StrToIntDef(EdtVolumeId.Text, 0);
  DmeXactWMS.QryVolumeDivergencia.Open;
  If (DmeXactWMS.QryVolumeDivergencia.FieldByName('QtdSuprida').AsInteger < DmeXactWMS.QryVolumeDivergencia.FieldByName('Demanda').AsInteger) then Begin
     FdMemProdutos.Filter   := '';
     FdMemProdutos.Filtered := False;
     if //(FdMemProdutos.RecordCount = 1) and
        (DmeXactWMS.QryVolumeDivergencia.FieldByName('QtdSuprida').AsInteger=0) then
        ConfirmarCancelamentoDeVolume
     Else
        ConfirmarGeracaoVolumeExtra;
     Exit
  End
  Else Begin
     FdMemProdutos.Filter   := '';
     FdMemProdutos.Filtered := False;
  End;
   ShowLoading;
  Th := TThread.CreateAnonymousThread(procedure
  Begin
    OperacaoTipo := poFinalizar;
    Try
//      raise Exception.Create('Erro Forjado pelo Genilson');
      PutColetaAPI(False);
    Except On E: Exception do
      Raise Exception.Create(E.Message);
    End;
  End);
  Th.OnTerminate := ThreadTerminateFinalizarSeparacao;
  Th.Start;
end;

procedure TFrmSeparacaoColetor.FormActivate(Sender: TObject);
begin
  inherited;
  if StartSeparacao then
     DelayedSetFocus(EdtProduto)
  Else
     if FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1 then
        DelayedsetFocus(EdtEmbalagemId)
     Else DelayedSetFocus(EdtVolumeId);

end;

procedure TFrmSeparacaoColetor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  vTimeSeparation.Stop;
  FrmSeparacaoColetor := Nil;
end;

procedure TFrmSeparacaoColetor.FormCreate(Sender: TObject);
begin
  inherited;
  //EdtDesativarDigitacao.Visible := False;
  StartSeparacao := False;
  Limpar(False);
  PgcPrincipal.ActiveTab := TabDetalhes;
  vPosLblUsuario := LblUsuarioCtrlSeg.Position.Y;
  vPosLblSenha   := lblSenhaCtrlSeg.Position.Y;
  vApanheConsolidadoSetor := FrmeXactWMS.ConfigWMS.ApanheConsolidado = 1;
  LytLoteApanhe.Visible   := False;
  LblAtivo.Visible        := False;
  CircleStatus.Visible    := False;
  LblCaixaVolume.Visible  := False;
  if EdtVolumeId.Text = '' then Begin
     DmeXactWMS.QryPesquisa.Close;
     DmeXactWMS.QryPesquisa.Sql.Clear;
     DmexactWMS.QryPesquisa.SQL.Add('select PedidoVOlumeId');
     DmexactWMS.QryPesquisa.SQL.Add('from PedidoVolumeProduto');
     DmeXactWMS.QryPesquisa.Sql.Add('Group By PedidoVolumeId');
     DmexactWMS.QryPesquisa.SQL.Add('Order By PedidoVolumeId Desc;');
     DmexactWMS.QryPesquisa.Open;
     if Not DmexactWMS.QryPesquisa.IsEmpty then Begin
        MensagemStand('Volume pendente: '+DmexactWMS.QryPesquisa.FieldByName('PedidoVolumeId').AsString);
        If (FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1) and ((StrToIntDef(EdtEmbalagemId.Text, 0)<0) or (EdtEmbalagemId.Text=''))then
           DelayEdSetFocus(EdtEmbalagemId)
        Else
           DelayEdSetFocus(EdtVolumeId);
     End;
     DmexactWMS.QryPesquisa.Close;
  End;
end;

procedure TFrmSeparacaoColetor.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
//  inherited;
  If Key = vkF2 then
     FrmeXactWMS.BrnMenuClick(Sender);
end;

procedure TFrmSeparacaoColetor.GerarVolumeExtraDeExcesso;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayVolumeExtra   : TJsonArray;
    vErro : String;
    pJsonArrayProdutoCorte : TjsonArray;
    TH : TThread;
    TESTE : Boolean;
begin
  Teste := LytLoteApanhe.Visible;
  ksLoadingIndicator1.ShowLoading;
  TH := TThread.CreateAnonymousThread(procedure
  Begin
    EdtLoteSeparacao.Text := '';
    if (Not FdMemProdutos.Eof) and (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and
       (StrToIntDef(EdtQtdApanhe.Text, 0) > 0) then Begin
        vQtdCorte := FdMemProdutos.FieldByName('Demanda').AsInteger -
                     StrToIntDef(EdtQtdApanhe.Text, 0);
       LytLoteApanhe.Visible := (FdMemProdutos.FieldByName('LoteSeparacao').AsInteger = 1) and (vApanheConsolidadoSetor);
       AtualizarContagem(True);
       FdMemProdutos.Next;
    End;
    while Not FdMemProdutos.Eof do Begin
      LytLoteApanhe.Visible := False;
      vQtdCorte := FdMemProdutos.FieldByName('Demanda').AsInteger;
      ZerarLoteParaExtraExcesso;
      FdMemProdutos.Next;
    End;

    pJsonArrayProdutoCorte := TjsonArray.Create;
    While Not FdMemProdutos.Eof do Begin
      pJsonArrayProdutoCorte.Add(TJsonObject.Create.AddPair('produtoid',
                                 TJsonNumber.Create(FdMemProdutos.FieldByName('ProdutoId').AsInteger)) );
      FdMemProdutos.Next;
    End;
    putColetaAPI(True);
    OperacaoTipo := poFinalizar;
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    JsonArrayVolumeExtra   := ObjPedidoVolumeCtrl.GerarVolumeExtra(pJsonArrayProdutoCorte);
    vVolumeExtraGerado := JsonArrayVolumeExtra.Items[0].Value.ToInteger();
    if Not JsonArrayVolumeExtra.Items[0].TryGetValue('Erro', vErro) then Begin
       operacaoTipo := poFinalizar;
       If Not RegistrarAberturaSeparacao(vVolumeSeparacaoId, Ord(operacaotipo), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) then Begin
          raise Exception.Create('Erro: Não foi possível finalizar o volume.');
       End;
    End
    Else
       Raise exception.Create('Não foi possível gerar o Volume Extra de Excesso');
    JsonArrayVolumeExtra := Nil;
    ObjPedidoVolumeCtrl.Free;
    pJsonArrayProdutoCorte.Free;
  End);
  TH.OnTerminate := ThreadGerarVolumeExtraDeExcessoTerminate;
  TH.Start;
end;

procedure TFrmSeparacaoColetor.GetLotesSubstituto;
Var JsonArrayLotes : TJsonArray;
    //ObjEstoqueCtrl : TEstoqueCtrl;
    ObjLoteCtrl    : TLoteCtrl;
    vErro          : String;
begin
  If FDMemEstoqueLotes.Active then
     FDMemEstoqueLotes.EmptyDataSet;
  FDMemEstoqueLotes.Close;
//  ObjEstoqueCtrl := TEstoqueCtrl.Create;
//  jsonArrayLotes := ObjEstoqueCtrl.GetEstoqueProduto(FdMemProdutos.FieldByName('ProdutoId').AsInteger, FdMemProdutos.FieldByName('CodProduto').AsInteger);
  ObjLoteCtrl := TLoteCtrl.Create;
  jsonArrayLotes := ObjLoteCtrl.FindLote(FdMemProdutos.FieldByName('ProdutoId').AsInteger, 0, '*');
  if JsonArrayLotes.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
  End
  Else
     FDMemEstoqueLotes.LoadFromJson(jsonArrayLotes, False);
  FDMemEstoqueLotes.First;
  CbLoteSubstituto.Items.Clear;
  while Not FDMemEstoqueLotes.Eof do Begin
    CbLoteSubstituto.Items.Add(FDMemEstoqueLotes.FieldByName('DescrLote').AsString);
    FDMemEstoqueLotes.Next;
  End;
  MontaLoteSubstituto;
  DelayEdSetFocus(EdtLoteSubstituir);// CbLoteSubstituto);
  jsonArrayLotes := Nil;
  ObjLoteCtrl.Free;
  //ObjEstoqueCtrl.Free;
end;

function TFrmSeparacaoColetor.GetProdutoSeparado: Integer;
begin
  DmeXactWMS.QryPesquisa.Close;
  DmeXactWMS.QryPesquisa.Sql.Clear;
  DmeXactWMS.QryPesquisa.Sql.Add('Select Sum(Demanda-QtdSuprida) QtdSuprida From PedidoVolumeProduto');
  DmeXactWMS.QryPesquisa.Sql.Add('Where PedidoVolumeId = :pPedidoVolumeId');
  DmeXactWMS.QryPesquisa.Sql.Add('  And CodProduto = :pCodProduto');
  DmeXactWMS.QryPesquisa.ParamByName('pPedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
  DmeXactWMS.QryPesquisa.ParamByName('pCodProduto').Value     := FdMemProdutos.FieldByName('CodProduto').AsInteger;
  DmeXactWMS.QryPesquisa.Open;
  Result := DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger;
  DmeXactWMS.QryPesquisa.Close;
end;

procedure TFrmSeparacaoColetor.Image1Click(Sender: TObject);
begin
  inherited;
  FrmeXactWMS.BrnMenuClick(Sender);
end;

procedure TFrmSeparacaoColetor.InsertVolumeLoteSqlLite;
Var vLotes, vNParams : Integer;
    ReturnJsonArray  : TjsonArray;
    vErro            : String;
begin
  ReturnJsonArray := DmClient.GetVolumeProdutoLotes(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger, 0) ;
  If (ReturnJsonArray.Items[0].TryGetValue('Erro', vErro)) then Begin
     ShowErro(verro);
  End
  Else Begin
    With DmeXactWMS.QryVolumeLote do Begin
      Close;
      Sql.Clear;
      Sql.Add('Delete From pedidovolumelote where pedidovolumeid = '+FdMemProdutos.FieldByName('pedidovolumeid').AsString+';');
      ExecSql;
      Close;
      Sql.Clear;
      SQL.Add('insert into PedidoVolumeLote values (:pedidovolumeid, :codproduto, :loteid, :lote');
      Sql.Add('            ,:fabricacao, :vencimento, :demanda, :embalagempadrao, :dtinclusao, :hrinclusao');
      Sql.Add('            ,:usuarioid, :terminal, :qtdsuprida, :qtdapanhe, :qtdcorte, :data, :horarioinicio, :horariotermino)');
      Params.ArraySize := ReturnJsonArray.Count;
      //Prepare;
      For vLotes := 0 to Pred(ReturnJsonArray.Count) do Begin
        Params[0].Values[vLotes]  := FdMemProdutos.FieldByName('pedidovolumeid').AsInteger;
        Params[1].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<Integer>('codproduto');
        Params[2].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<Integer>('loteid');
        Params[3].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<String>('lote');
        Params[4].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<String>('fabricacao');
        Params[5].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<String>('vencimento');
        Params[6].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<Integer>('demanda');
        Params[7].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<Integer>('embalagempadrao');
        Params[8].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<String>('dtinclusao');
        Params[9].Values[vLotes]  := ReturnJsonArray.Items[vLotes].GetValue<String>('hrinclusao');
        Params[10].Values[vLotes] := 0;
        Params[11].Values[vLotes] := '';
        Params[12].Values[vLotes] := 0;
        Params[13].Values[vLotes] := 0;
        Params[14].Values[vLotes] := 0;
        Params[15].Values[vLotes] := 0;
        Params[16].Values[vLotes] := 0;
        Params[17].Values[vLotes] := 0;
      End;
      Execute(Params.ArraySize, 0);
    End;
  End;
end;

procedure TFrmSeparacaoColetor.InsertVolumeProdutoSqlLite;
Var vNParams         : Integer;
    vEnderecoInicial : Integer;
    vtotalSeparacao  : Integer;
begin
  vtotalSeparacao := 0;
  vEnderecoInicial := FdMemVolumeSeparacao.FieldByName('enderecoId').AsInteger;
  FdMemProdutos.First;
  With DmeXactWMS.QryVolumeProduto do Begin
    Close;
    Sql.Clear;
    Sql.Add('Delete From pedidovolumeproduto where pedidovolumeid = '+FdMemProdutos.FieldByName('pedidovolumeid').AsString+';');
    ExecSql;
    Close;
    Sql.Clear;
    SQL.Add('insert into PedidoVolumeProduto values (:pedidovolumeid, :produtoid, :codproduto, :descricao');
    Sql.Add('  , :enderecoid, :endereco, :mascara, :embalagem, :embalagempadrao, :demanda, :qtdsuprida');
    Sql.Add('  , :usuarioid, :qtdapanhe, :qtdcorte, :data, :horarioinicio, :horariotermino');
    Sql.Add('  , :zonaid, :zona, :lotereposicao, :loteseparacao)');
    Params.ArraySize := FdMemProdutos.RecordCount;
    //Prepare;
    vNParams := 0;
    while not FdMemProdutos.Eof do begin
      Params[0].Values[vNParams]  := FdMemProdutos.FieldByName('pedidovolumeid').AsInteger;
      Params[1].Values[vNParams]  := FdMemProdutos.FieldByName('produtoid').Asinteger;
      Params[2].Values[vNParams]  := FdMemProdutos.FieldByName('codproduto').AsInteger;
      Params[3].Values[vNParams]  := FdMemProdutos.FieldByName('descricao').AsString;
      Params[4].Values[vNParams]  := FdMemProdutos.FieldByName('enderecoid').Asinteger;
      Params[5].Values[vNParams]  := FdMemProdutos.FieldByName('endereco').AsString;
      Params[6].Values[vNParams]  := FdMemProdutos.FieldByName('mascara').AsString;
      Params[7].Values[vNParams]  := FdMemProdutos.FieldByName('embalagem').AsString;
      Params[8].Values[vNParams]  := FdMemProdutos.FieldByName('embalagempadrao').Asinteger;
      Params[9].Values[vNParams]  := FdMemProdutos.FieldByName('demanda').AsInteger;
      if (vEnderecoInicial > 0) then Begin
         Params[10].Values[vNParams] := FdMemProdutos.FieldByName('qtdsuprida').AsInteger; //FdMemProdutos.FieldByName('qtdseparada').AsInteger;
         vtotalSeparacao := vtotalSeparacao + FdMemProdutos.FieldByName('qtdsuprida').AsInteger; //FdMemProdutos.FieldByName('qtdseparada').AsInteger;
      End
      Else Params[10].Values[vNParams] := 0;
      if vEnderecoInicial =  FdMemProdutos.FieldByName('enderecoId').AsInteger then
         vEnderecoInicial := 0;
      Params[11].Values[vNParams] := FdMemProdutos.FieldByName('usuarioid').AsInteger;
      Params[12].Values[vNParams] := FdMemProdutos.FieldByName('qtdapanhe').AsInteger;
      Params[13].Values[vNParams] := FdMemProdutos.FieldByName('qtdcorte').AsInteger;
      Params[14].Values[vNParams] := FdMemProdutos.FieldByName('data').AsDateTime;
      Params[15].Values[vNParams] := 0; //FdMemProdutos.FieldByName('horarioinicio').AsDateTime;
      Params[16].Values[vNParams] := 0; //FdMemProdutos.FieldByName('horariotermino').AsDateTime;
      Params[17].Values[vNParams] := FdMemProdutos.FieldByName('zonaid').AsInteger;
      Params[18].Values[vNParams] := FdMemProdutos.FieldByName('zona').AsString;
      Params[19].Values[vNParams] := FdMemProdutos.FieldByName('lotereposicao').AsInteger;
      Params[20].Values[vNParams] := FdMemProdutos.FieldByName('loteseparacao').AsInteger; //??????
      FdMemProdutos.Next;
      Inc(vNParams);
    end;
    Execute(Params.ArraySize, 0);
    InsertVolumeLoteSqlLite;
  End;
  FdMemProdutos.First;
  LblSkuSeparada.Text := (StrToIntDef(LblSkuSeparada.Text, 0)+vtotalSeparacao).ToString();
end;

procedure TFrmSeparacaoColetor.SalvarCorteSqlLite;
begin
  DmeXactWMS.QryPesquisa.Close;
  DmeXactWMS.QryPesquisa.Sql.Clear;
  DmeXactWMS.QryPesquisa.Sql.Add('Update PedidoVolumeProduto ');
  DmeXactWMS.QryPesquisa.Sql.Add('  Set QtdCorte = Demanda - QtdSuprida,');
  DmeXactWMS.QryPesquisa.Sql.Add('      usuarioid = '+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString+',');
  DmeXactWMS.QryPesquisa.Sql.Add('      data = date('+#39+'now'+#39+'),');
  DmeXactWMS.QryPesquisa.Sql.Add('      horarioinicio = (case horarioinicio');
  DmeXactWMS.QryPesquisa.Sql.Add('                        when 0 then time('+#39+'now'+#39+', '+#39+'localtime'+#39+')');
  DmeXactWMS.QryPesquisa.Sql.Add('                        else horarioinicio');
  DmeXactWMS.QryPesquisa.Sql.Add('                     End),');
  DmeXactWMS.QryPesquisa.Sql.Add('      horariotermino   = time('+#39+'now'+#39+', '+#39+'localtime'+#39+')');
  DmeXactWMS.QryPesquisa.Sql.Add('where PedidoVolumeid = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString+
             ' and codproduto = '+FdMemProdutos.FieldByName('CodProduto').AsString+' and QtdSuprida < Demanda;');

  DmeXactWMS.QryPesquisa.Sql.Add('Update PedidoVolumeLote');
  DmeXactWMS.QryPesquisa.Sql.Add('  Set QtdCorte = Demanda - QtdSuprida,');
  DmeXactWMS.QryPesquisa.Sql.Add('        usuarioid = '+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString+',');
  DmeXactWMS.QryPesquisa.Sql.Add('        data = date('+#39+'now'+#39+'),');
  DmeXactWMS.QryPesquisa.Sql.Add('        horarioinicio = (case horarioinicio');
  DmeXactWMS.QryPesquisa.Sql.Add('                           when 0 then time('+#39+'now'+#39+', '+#39+'localtime'+#39+')');
  DmeXactWMS.QryPesquisa.Sql.Add('                           else horarioinicio');
  DmeXactWMS.QryPesquisa.Sql.Add('                         End),');
  DmeXactWMS.QryPesquisa.Sql.Add('        horariotermino   = time('+#39+'now'+#39+', '+#39+'localtime'+#39+')');
  DmeXactWMS.QryPesquisa.Sql.Add('where PedidoVolumeid = '+FdMemProdutos.FieldByName('PedidoVolumeId').AsString+
             ' and codproduto = '+FdMemProdutos.FieldByName('CodProduto').AsString+' and QtdSuprida < Demanda;');
//  if DebugHook <> 0 then DmeXactWMS.QryPesquisa.Sql.SaveToFile('CorteSqLite.Sql');
  DmeXactWMS.QryPesquisa.eXecSql;
end;

procedure TFrmSeparacaoColetor.SalvarItemColetaSqLite(pPedidoVolumeId : Integer; pCodProduto : Integer; pLote : String; pQuantidade : Integer);
begin
  dmeXactWMS.QryVolumeProdutoSalvar.Close;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('PedidoVolumeId').Value := pPedidoVolumeId;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('CodProduto').Value     := pCodProduto;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('Quantidade').Value     := pQuantidade;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  DmeXactWMS.QryVolumeProdutoSalvar.ExecSql;
  if pLote <> '' then Begin
     dmeXactWMS.QryVolumeLoteSalvar.Close;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('PedidoVolumeId').Value := pPedidoVolumeId;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('CodProduto').Value     := pCodProduto;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Lote').Value           := pLote;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Quantidade').Value     := pQuantidade;
     DmeXactWMS.QryVolumeLoteSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
     DmeXactWMS.QryVolumeLoteSalvar.ExecSql;
  End;
end;

procedure TFrmSeparacaoColetor.SbCancelarSubstituicaoClick(Sender: TObject);
begin
  inherited;
  EdtCodProdutoSubstituto.Text := '';
  LimparLoteSubstituicao;
  PgcPrincipal.ActiveTab := TabDetalhes;
  DelayEdSetFocus(EdtProduto);
end;

procedure TFrmSeparacaoColetor.SbSalvarLoteSubstitutoClick(Sender: TObject);
Var item  : TListViewItem;
    txt   : TListItemText;
    img   : TListItemImage;
    Cor   : Cardinal;
    xQtdeTotal : Integer;
begin
  if StrToIntDef(EdtQtdeSubstituto.Text, 0) > StrToIntDef(EdtDemandaSubstituto.Text, 0) then Begin
     ShowErro('Inválido! Quantidade maior que Demanda. Exclua lote(s) na grid abaixo!');
     DelayEdSetFocus(EdtDemandaSubstituto);
     Exit;
  End;
  xQtdeTotal := 0;
  FDMemLoteSubstituicao.First;
  while Not FDMemLoteSubstituicao.Eof do Begin
    if FDMemLoteSubstituicao.FieldByName('Lote').AsString <> EdtLoteSubstituir.Text then // CbLoteSubstituto.Items[CbLoteSubstituto.ItemIndex] then
       xQtdeTotal := xQtdeTotal + (FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger-
                                   FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger);
    FDMemLoteSubstituicao.Next;
  End;
  if xQtdeTotal+StrToIntDef(EdtQtdeSubstituto.Text, 0) > StrToIntDef(EdtDemandaSubstituto.Text, 0) then Begin
     ShowErro('Quantidade maior que Demanda. Exclua lote(s) na grid abaixo!');
     DelayEdSetFocus(EdtDemandaSubstituto);
     Exit;
  End;
  inherited;
  FDMemLoteSubstituicao.First;
  if FDMemLoteSubstituicao.Locate('LoteId', FDMemEstoqueLotes.FieldByName('LoteId').AsString, []) then Begin
     FDMemLoteSubstituicao.Edit;
     FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger := StrToIntDef(EdtQtdeSubstituto.Text, 0)+
                                                               (FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger-
                                                                FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger)+
                                                               FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger;
     FDMemLoteSubstituicao.Post;
  End
  Else Begin
     FDMemLoteSubstituicao.Append;
     FDMemLoteSubstituicao.FieldByName('Idproduto').AsInteger       := FdMemProdutos.FieldByName('ProdutoId').AsInteger;
     FDMemLoteSubstituicao.FieldByName('Codproduto').AsInteger      := FdMemProdutos.FieldByName('CodProduto').AsInteger;
     FDMemLoteSubstituicao.FieldByName('Loteid').AsInteger          := FDMemEstoqueLotes.FieldByName('LoteId').AsInteger;
     FDMemLoteSubstituicao.FieldByName('lote').AsString             := FDMemEstoqueLotes.FieldByName('DescrLote').AsString;
     FDMemLoteSubstituicao.FieldByName('Fabricacao').AsString       := FDMemEstoqueLotes.FieldByName('Fabricacao').AsString;
     FDMemLoteSubstituicao.FieldByName('Vencimento').AsString       := FDMemEstoqueLotes.FieldByName('Vencimento').AsString;
     FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger         := StrToIntDef(EdtQtdeSubstituto.Text, 0)+
                                                                       FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger;
     FDMemLoteSubstituicao.FieldByName('Embalagempadrao').AsInteger := FDMemVolumeLotes.FieldByName('EmbalagemPadrao').AsInteger;
     FDMemLoteSubstituicao.Post;
  End;
  CbLoteSubstituto.ItemIndex := -1;
  EdtLoteSubstituir.Text     := '';
  EdtQtdeSubstituto.Text     := '';
  LblLoteFabricacao.Text     := '';
  LblLoteVencimento.Text     := '';
  MontaLoteSubstituto;
  DelayEdSetFocus(EdtLoteSubstituir);//  CbLoteSubstituto);
  if LytSubstituicaoInativa.Visible then
     LblSubstituicaoInativa.Text := 'Click no botão '+#4+'Atualizar Lotes para finalizar'+#34+#13+#10+
                                    'para refazer, exclua do grid abaixo.';
end;

procedure TFrmSeparacaoColetor.SbSalvarSubstituicaoClick(Sender: TObject);
Var JsonArrayLoteSubstituto  : TJsonArray;
    JsonObjectLoteSubstituto : TJsonObject;
    JsonObjectSalvar         : TjsonObject;
    JsonArrayRetorno         : TJsonArray;
    ObjPedidoVolumeCtrl      : TPedidoVolumeCtrl;
    vErro : String;
    vTotalSubstituto : Integer;
    vTotalSuprido    : Integer;
begin
  inherited;
  //Enviar Dados para API atualizar o banco e Get e Monta Lista com novos Lotes
  FDMemLoteSubstituicao.First;
  vTotalSubstituto := 0;
  While (not FDMemLoteSubstituicao.Eof) do Begin
     vTotalSubstituto := vTotalSubstituto + FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger-FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger;
     FDMemLoteSubstituicao.Next;
  End;
  if (vTotalSubstituto <> (EdtDemandaSubstituto.Text).ToInteger) then Begin
     ShowErro('Quantidade de substituição diferente da pendência(Demanda).', 'alarme');
     DelayEdSetFocus(EdtQtdeSubstituto);
     Exit;
  End;
  FDMemLoteSubstituicao.First;
  JsonArrayLoteSubstituto := TJsonArray.Create;
  while Not FDMemLoteSubstituicao.Eof do Begin
    JsonObjectLoteSubstituto := TJsonObject.Create;
    JsonObjectLoteSubstituto.AddPair('pedidovolumeid', TJsonNumber.Create(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger));
    JsonObjectLoteSubstituto.AddPair('loteid', TJsonNumber.Create(FDMemLoteSubstituicao.FieldByName('LoteId').AsInteger));
    JsonObjectLoteSubstituto.AddPair('enderecoid', TJsonNumber.Create(FdMemProdutos.FieldByName('EnderecoId').AsInteger));
    JsonObjectLoteSubstituto.AddPair('quantidade', TJsonNumber.Create(FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger));
    JsonObjectLoteSubstituto.AddPair('embalagempadrao', TJsonNumber.Create(FDMemProdutos.FieldByName('EmbalagemPadrao').AsInteger));
    JsonObjectLoteSubstituto.AddPair('qtdsuprida', TJsonNumber.Create(FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger));
    JsonArrayLoteSubstituto.Add(JsonObjectLoteSubstituto);
    FDMemLoteSubstituicao.Next;
  End;
  JsonObjectSalvar := TjsonObject.Create;
  JsonObjectSalvar.AddPair('pedidovolumeid', TJsonNumber.Create(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger));
  JsonObjectSalvar.AddPair('produtoid', TJsonNumber.Create(FdMemProdutos.FieldByName('ProdutoId').AsInteger));
  JsonObjectSalvar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  {$IfDef Android}
     JsonObjectSalvar.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
  {$else}
    JsonObjectSalvar.AddPair('terminal', NomeDoComputador);
  {$ENdif}
  JsonObjectSalvar.AddPair('lotes', JsonArrayLoteSubstituto);
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  JsonArrayRetorno    := ObjPedidoVolumeCtrl.VolumeLoteSubstituicao( JsonObjectSalvar );
  if JsonArrayRetorno.TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     DelayEdSetFocus(EdtLoteSubstituir);//  CbLoteSubstituto);
  End
  Else Begin
     EdtCodProdutoSubstituto.Text := '';
     LimparLoteSubstituicao;
     PgcPrincipal.ActiveTab := TabDetalhes;
//     if LytLoteApanhe.Visible then begin
        AtualizarSubstituicaoLotes;
        //Atualizar SqLite
        AtualizarLotesSubstituicaoSqLite;
        if EdtProduto.Text <> '' then
           DelayEdSetFocus(EdtLoteSeparacao)
//     end
        Else
           DelayEdSetFocus(EdtProduto);
     MontaListaLotes(False);
  End;
  JsonObjectLoteSubstituto := Nil;
  JsonArrayLoteSubstituto   := Nil;
  JsonObjectSalvar.Free;
  JsonArrayRetorno          := NIl;
  ObjPedidoVolumeCtrl.Free;
end;

procedure TFrmSeparacaoColetor.ShowProdutoParaSeparacao;
begin
  LblEndereco.Text := EnderecoMask(FdMemProdutos.FieldByName('Endereco').AsString,
                                     FdMemProdutos.FieldByName('Mascara').AsString, True);
  LblProduto.Text := FdMemProdutos.FieldByName('CodProduto').AsString+'  '+FdMemProdutos.FieldByName('Descricao').AsString;
  if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1 then
     EdtQtdApanhe.Text := (FdMemProdutos.FieldByName('QtdSuprida').AsInteger Div FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger).ToString
  Else EdtQtdApanhe.Text := (FdMemProdutos.FieldByName('Demanda').AsInteger Div FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger).ToString();
  EdtQtdDemanda.Text := (FdMemProdutos.FieldByName('Demanda').AsInteger Div FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger).ToString();
  if FdMemProdutos.FieldByName('EmbalagemPadrao').AsInteger = 1 then
     EdtUnid.Text := FdMemProdutos.FieldByName('EmbalagemPadrao').AsString+' Unid'
  else EdtUnid.Text := 'Cxa c/ '+FdMemProdutos.FieldByName('EmbalagemPadrao').AsString+')';
  MontaListaLotes; //Pegar do SqLite
//registrando dados inicial do apanhe
  FdMemProdutos.Edit;
  FdMemProdutos.FieldByName('Data').AsDateTime          := Now();
  FdmemProdutos.FieldByName('horarioinicio').AsDateTime := Time();
  FdMemProdutos.Post;
  DelayedSetFocus(EdtProduto);
  F3Press   := False;
  EdtQtdApanhe.ReadOnly := True;
  vQtdCorte := 0;
  LytLoteApanhe.Visible := (FdMemProdutos.FieldByName('LoteSeparacao').AsInteger = 1) and (vApanheConsolidadoSetor);
end;

procedure TFrmSeparacaoColetor.ThreaConfirmaResetVolumeTerminate(
  Sender: TObject);
begin
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then begin
        ShowErro(Exception(TThread(sender).FatalException).Message);
        exit;
     end;
  end;
  vVolumeSeparacaoId := 0;
  StartSeparacao     := False;
  Limpar(False);
end;

procedure TFrmSeparacaoColetor.ThreadValidarVolumeTerminate(Sender: TObject);
begin
  ksLoadingIndicator1.HideLoading;
  LytDetalheVolume.Enabled := True;
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then begin
        EdtEmbalagemId.Text := '';
        EdtVolumeId.text    := '';
        if (FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1) and (EdtVolumeId.Text='')then
           SetCampoDefault('EdtEmbalagemId')
        Else
           SetCampoDefault('EdtVolumeId');
        ShowErro(Exception(TThread(sender).FatalException).Message, 'alerta');
        exit;
     end;
  end;
//GetInicioSeparacao não é mais usado, partindo direto para ShowProdutoParaSeparacao
//  if EdtVolumeId.Text <> '' then
//     GetInicioSeparacao
//  Else
  If (EdtEmbalagemId.Text = '') and (FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1) then
     DelayEdSetFocus(EdtEmbalagemId)
  Else
     DelayEdSetFocus(EdtVolumeid);
end;

procedure TFrmSeparacaoColetor.totalizarColeta(pPedidoVolumeId: Integer);
begin
  With DmeXactWMS.QryPesquisa do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select sum(Demanda) Demanda, Sum(QtdSuprida) QtdSuprida, Sum(QtdCorte) QtdCorte');
    Sql.Add('From PedidoVolumeProduto');
    Sql.Add('where PedidoVolumeId = :pPedidoVolumeId');
    paramByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Open;
  end;
end;

procedure TFrmSeparacaoColetor.ThreadGerarVolumeExtraDeExcessoTerminate(
  Sender: TObject);
begin
  ksLoadingIndicator1.HideLoading;
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then begin
        SetCampoDefault('EdtProduto');
        ShowErro(Exception(TThread(sender).FatalException).Message, 'alerta');
        exit;
     end;
  end;
  vVolumeSeparacaoId := 0;
  StartSeparacao     := False;
  MensagemStand( 'Volume Extra Excesso: '+vVolumeExtraGerado.ToString());
  Limpar(False);
  If (FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1) then
     DelayEdSetFocus(EdtEmbalagemId)
  Else
     DelayEdSetFocus(EdtVolumeId);
  ChgTabDet.Execute;
end;

procedure TFrmSeparacaoColetor.ThreadTerminateLogOff(Sender: TObject);
begin
  LogOffCaixa := False;
  if Sender is TThread then Begin
     if Assigned(TThread(Sender).FatalException) then Begin
        if (LytLoteApanhe.Visible) And (EdtProduto.Text<>'') then
           SetCampoDefault('EdtLoteSeparacao')
        Else
           SetCampoDefault('EdtProduto');
        ShowErro('Erro no LogOff! '+Exception(TThread(sender).FatalException).Message, 'alarme');
        Exit;
     end;
  End;
  vVolumeSeparacaoId  := 0;
  StartSeparacao      := False;
  EdtEmbalagemId.Text := '';
  Limpar(False);
end;

procedure TFrmSeparacaoColetor.ThreadTerminateFinalizarSeparacao(Sender: TObject);
Var xRecno, xvTotalApanhe : Integer;
    xVolume, vErro : String;
begin
  HideLoading;
  if Sender is TThread then Begin
     if Assigned(TThread(Sender).FatalException) then Begin
        if (Not LytLoteApanhe.Visible) or (StrToIntDef(EdtQtdDemanda.Text, 0)>=StrToIntDef(EdtQtdApanhe.Text, 0)) or
           (EdtProduto.Text='') then
           SetCampoDefault('EdtProduto')
        Else
           SetCampoDefault('EdtLoteSeparacao');
        if vCtrlErroFinalizacao < 3 then Begin
           TThread.Synchronize(Nil,
           procedure ()
           begin
                ShowOk('Estamos tentando finalizar o volume('+vCtrlErroFinalizacao.ToString()+')');
                Sleep(1000);
           end);
           Inc(vCtrlErroFinalizacao);
           FinalizarSeparacao;
        End
        Else Begin
          vCtrlErroFinalizacao := 1;
          vErro := StringReplace(Exception(TThread(sender).FatalException).Message,
                   'REST request failed: java.net.ConnectException:', '', []);
          ShowErro('Erro na finalização do Volume!'+#13+vErro, 'alerta');
          RepeatFinalizacao(vErro);
        End;
        Exit;
     end;
  End;
  xVolume := EdtVolumeId.Text;
  Try
    if (GetVolumeComDivergencia) Then begin //or (Not FdMemProdutos.IsEmpty) then Begin
       totalizarColeta(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger);
       if (FdMemProdutos.RecordCount = 1) and (dmExactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then
          ConfirmarCancelamentoDeVolume
       Else
          ConfirmarGeracaoVolumeExtra;
    End
    Else Begin
      OperacaoTipo := poFinalizar;
      If (1 = 1) then Begin //RegistrarAberturaSeparacao(vVolumeSeparacaoId, Ord(operacaotipo), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) Then Begin
         DmeXactWMS.QryDelVolumeProdutoLote.Close;
         DmeXactWMS.QryDelVolumeProdutoLote.ParamByName('PedidoVolumeIdPrd').Value  := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
         DmeXactWMS.QryDelVolumeProdutoLote.ParamByName('PedidoVolumeIdLote').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
         DmeXactWMS.QryDelVolumeProdutoLote.ExecSql;
         FdMemProdutos.Filter   := '';
         FdMemProdutos.Filtered := False;
         FdMemProdutos.Recno    := xRecno;
         vVolumeSeparacaoId := 0;
         StartSeparacao     := False;
         Limpar(False);
         ShowOk('Separação Concluída!', 'concluido');
      End
      Else
         ShowErro('Não foi possível finalizar.', 'alerta');
    End;
  Except On E: Exception do Begin
    If (LytLoteApanhe.Visible) and (EdtProduto.Text<>'') then
       SetCampoDefault('EdtLoteSeparacao')
    Else
       SetCampoDefault('EdtProduto');
    ShowErro('Erro: '+E.Message);
    End;
  End
end;

procedure TFrmSeparacaoColetor.LblF3Click(Sender: TObject);
begin
  inherited;
  if ((FrmeXactWMS.ConfigWMS.ApanheConsolidado = 0) or (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0) or
      ((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and (StrToIntDef(EdtQtdDemanda.Text,0)>FrmeXactWMS.ConfigWMS.BeepIndividualLimiteUnid))) then Begin
      F3Press := True;
      if Not LytLoteApanhe.Visible then Begin
         EdtQtdApanhe.ReadOnly := False;
         DelayedSetFocus(EdtQtdApanhe);
      end
      Else Begin
         EdtQtdeApanheLoteF3.ReadOnly := False;
         DelayedSetFocus(EdtQtdeApanheLoteF3);
      end;
  End;
end;

procedure TFrmSeparacaoColetor.LiberarFuncaoBloqueada;
begin
  inherited;
  Confcorte;
end;

procedure TFrmSeparacaoColetor.Limpar(pDigitarProduto: Boolean);
begin
  LogOffCaixa := False;
  pPanelDigitarProduto := pDigitarProduto;
  vFinalizarColeta     := False;
  if Not pDigitarProduto then Begin
     LimparTabelaSqLite;
     LytDetalheVolume.Visible := True;
//     LytSeparacao.Visible     := Not FrmeXactWMS.ConfigWMS.EcraColetor = 1;
     LblCaixaVolume.Visible   := False;

     EdtEmbalagemId.Text := '';
     if FrmeXactWMS.ConfigWMS.IdentCaixaApanhe = 1 then Begin
        LblEmbalagemId.Visible := True;
        EdtEmbalagemId.Visible := True;
        DelayedSetFocus(EdtEmbalagemId);
     End
     Else Begin
        EdtEmbalagemId.Visible := False;
        LblEmbalagemId.Visible := False;
        DelayedSetFocus(EdtVolumeId);
     End;
     LblEndereco.Text       := '';
     LblProduto.Text        := '';
     EdtVolumeId.Text       := '';
     LblSkuVolume.Text      := '';
     LblSkuSeparada.Text    := '';
     EdtLoteSeparacao.Text  := '';
     LytLoteApanhe.Visible  := False;
     RctCabecalho.Enabled   := True;
     RctApanhe.Enabled      := False;
     LytSeparacao.Visible   := True;
     LblCaixaVolume.Visible := False;
     LimparCabecalhoPedido;
     If FdMemVolumeSeparacao.Active then
        FdMemVolumeSeparacao.EmptyDataSet;
     FdMemVolumeSeparacao.Close;
  End
  Else Begin
//     LytDetalheVolume.Visible := Not FrmeXactWMS.ConfigWMS.EcraColetor = 1;
     LytSeparacao.Visible     := True;
//     LblCaixaVolume.Visible   := FrmeXactWMS.ConfigWMS.EcraColetor = 1;

     RctCabecalho.Enabled := False;
     RctApanhe.Enabled    := True;
     DelayedSetFocus(EdtProduto);
  End;
  EdtProduto.Text     := '';
  EdtQtdDemanda.Text  := '';
  EdtUnid.Text        := '';
  EdtQtdApanhe.Text   := '';
  vQtdCorte           := 0;
  OperacaoTipo        := poAbertura;
  Self.LimparLista(FrmeXactWMS, VsbLotes, LytLotesItem.Name);
end;

procedure TFrmSeparacaoColetor.LimparLista(Sender: TObject;
  AVertScroll: TVertScrollBox; ARectBase: string);
var
  I      : Integer;
  lFrame : Tlayout;
begin
  //Pesquisar e deixar isso no formulário padrão de listas.
  AVertScroll.BeginUpdate;
  for I := Pred(AVertScroll.Content.ChildrenCount) downto 0 do
  begin
    if (AVertScroll.Content.Children[I] is Tlayout) then
    begin
      if not (Tlayout(AVertScroll.Content.Children[I]).Name = LytLotesItem.Name) then
      begin
        lFrame := (AVertScroll.Content.Children[I] as Tlayout);
        lFrame.DisposeOf;
        lFrame := nil;
      end;
    end;
  end;
  AVertScroll.EndUpdate;
end;

procedure TFrmSeparacaoColetor.LimparListaLayout;
var
  I      : Integer;
  lFrame : TLayout;
  teste : String;
begin
  //Pesquisar e deixar isso no formulário padrão de listas.
  VsbLotes.BeginUpdate;
  for I := Pred(VsbLotes.Content.ChildrenCount) downto 0 do
  begin
    Teste := VsbLotes.Content.Children[I].Name;
    if (VsbLotes.Content.Children[I] is TLayout) then
    begin
      if not (TLayout(VsbLotes.Content.Children[I]).Name =LytLotesItem.Name) then
      begin
        lFrame := (VsbLotes.Content.Children[I] as TLayout);
        lFrame.DisposeOf;
        lFrame := nil;
      end;
    end;
  end;
  VsbLotes.EndUpdate;
end;

procedure TFrmSeparacaoColetor.LimparLoteSubstituicao;
begin
  EdtDemandaSubstituto.Text := '';
  EdtUnidSubstituto.Text    := '';
  LblProdutoDescricaoSubstituir.Text := '';
  CbLoteSubstituto.Items.Clear;
  EdtLoteSubstituir.Text := '';
  LblLoteFabricacao.Text := '';
  LblLoteVencimento.Text := '';
  EdtQtdeSubstituto.Text := '';
  LstLoteSubstituicao.Items.Clear;
end;

procedure TFrmSeparacaoColetor.LimparTabelaSqLite;
begin
  if EdtVolumeId.Text='' then Exit;
  With DmeXactWMS.QryPesquisa do Begin
    Close;
    Sql.Clear;
    Sql.Add('Delete From pedidovolumeproduto where pedidovolumeid = '+EdtVolumeId.Text+';');
    Sql.Add('Delete From pedidovolumelote where pedidovolumeid = '+EdtVolumeId.Text+';');
    ExecSql;
  End;
end;

procedure TFrmSeparacaoColetor.LogOff;
Var TH : TThread;
begin
  EdtProduto.ReadOnly       := False;
  EdtLoteSeparacao.ReadOnly := False;
  if (OperacaoTipo = poFinalizar) or (FdMemProdutos.Eof) then Begin
     Operacaotipo := poFinalizar;
     Exit;
  End;
  LogOffCaixa := True;
  Th := TThread.CreateAnonymousThread(procedure
  Begin
    PutColetaAPI(False);
  End);
  Th.OnTerminate := ThreadTerminateLogOff;
  Th.Start;
end;

procedure TFrmSeparacaoColetor.LstLoteSubstituicaoItemClick(
  const Sender: TObject; const AItem: TListViewItem);
Var TxtItem : TListItemText;
Var xCount  : Integer;
Teste : String;
begin
  inherited;
{  xCount := LstLoteSubstituicao.Items.Count;
  Teste := AItem.Text;
  Teste := IntToStr(LstLoteSubstituicao.Selected.Index+1);
  if xCount > 0 then Begin
     If (TxtItem.Text <> '') then
        ShowMessage('Clicado em '+TListItemText(LstLoteSubstituicao.Items[AItem.Index].Objects.FindDrawable('LInvLote')).Text);

  End;
}
end;

procedure TFrmSeparacaoColetor.LstLoteSubstituicaoItemClickEx(
  const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  inherited;
  If ItemObject.Name = 'ImgLoteExcluirSel' then Begin
     LstLoteSubstituicao.Enabled := False;
     TDialogService.MessageDialog('Confirma exclusão do Lote ' +
                                  LstLoteSubstituicao.Items[ItemIndex].TagString + ' ?',
                    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        var vqtd : Integer;
        begin
          if AResult = mrYes then Begin
             //LstLoteSubstituicao.Items.Delete(ItemIndex);
             if FDMemLoteSubstituicao.Locate('Lote', LstLoteSubstituicao.Items[ItemIndex].TagString, []) then Begin
                if (FdMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger=0) then
                    FDMemLoteSubstituicao.Delete
                Else Begin
                  FdMemLoteSubstituicao.Edit;
                  vQtd := FdMemLoteSubstituicao.FieldByName('Demanda').AsInteger;
                  vQtd := FdMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger;
                  FdMemLoteSubstituicao.FieldByName('Demanda').AsInteger := FdMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger;
                  vQtd := FdMemLoteSubstituicao.FieldByName('Demanda').AsInteger;
                  FdMemLoteSubstituicao.Post;
                End;
                FDMemLoteSubstituicao.Refresh;
                MontaLoteSubstituto;
                DelayEdSetFocus(EdtLoteSubstituir);//  CbLoteSubstituto);
             End;
             LstLoteSubstituicao.Enabled := True;
          End
          else LstLoteSubstituicao.Enabled := True;
        end);
     //   ShowErro('Item não excluído!');
  End;
end;

procedure TFrmSeparacaoColetor.LytBtnMenuClick(Sender: TObject);
begin
  showmessage('Btn Clicado');
  inherited;
  if FrmeXactWMS.MultiView1.IsShowed then
     FrmeXactWMS.MultiView1.HideMaster
  Else FrmeXactWMS.MultiView1.ShowMaster;
end;

procedure TFrmSeparacaoColetor.MontaListaLotes(pLoadLotes : Boolean);
//Var ReturnJsonArray : TJsonArray;
Begin
{
   DmeXactWMS.QryGetVolumeLote.Close;
   DmeXactWMS.QryGetVolumeLote.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
   DmeXactWMS.QryGetVolumeLote.ParamByName('CodProduto').Value     := FdMemProdutos.FieldByName('CodProduto').AsInteger;
   DmeXactWMS.QryGetVolumeLote.Open;
   pLoadLotes := False;
}
  TLibrary.CustomThread(
    procedure ()
    begin
      //Start do processamento
      TThread.Synchronize(TThread.CurrentThread,
      procedure ()
      begin
        Self.VsbLotes.Visible := False;
        Self.VsbLotes.BeginUpdate;
        Self.LimparLista(FrmeXactWMS, VsbLotes, LytLotesItem.Name);
      end);
    end,
    procedure ()
    var
      LFrame        : TLayout;
      LPos          : Single;
      X : Integer;
      vErro : String;
      ReturnJsonArray : TJsonArray;
    begin
      //Processamento principal
      LPos                      := 8;
      LytLotesItem.Visible     := False;
      if pLoadLotes then Begin
//         ReturnJsonArray := DmClient.GetVolumeProdutoLotes(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger,
//                                                        FdMemProdutos.FieldByName('Produtoid').AsInteger) ;
         DmeXactWMS.QryGetVolumeLote.Close;
         DmeXactWMS.QryGetVolumeLote.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
         DmeXactWMS.QryGetVolumeLote.ParamByName('CodProduto').Value     := FdMemProdutos.FieldByName('CodProduto').AsInteger;
         DmeXactWMS.QryGetVolumeLote.Open;
         ReturnJsonArray := DmeXactWMS.QryGetVolumeLote.ToJSONArray;
      End;
      If (pLoadLotes) and (ReturnJsonArray.Items[0].TryGetValue('Erro', vErro)) then Begin
         TThread.Synchronize(TThread.CurrentThread,
         procedure ()
         begin
           ShowErro(verro);
         end);
         //Tratar o Erro
      End
      Else Begin
        if pLoadLotes then Begin
           If FDMemVolumeLotes.Active then
              FDMemVolumeLotes.EmptyDataSet;
           FDMemVolumeLotes.Close;
           FDMemVolumeLotes.LoadFromJSON(ReturnJsonArray, False);
        End;
        if Not FdMemVolumeLotes.Active then Begin
           TThread.Synchronize(TThread.CurrentThread,
           procedure ()
           begin
             ShowErro('Sem lotes do produto. Avise ao Líderes do eXactWMS');
           end);
           FdMemVolumeLotes.Open;
        End;
        FdMemVolumeLotes.First;
        //for X := 0 to Pred(ReturnJsonArray.Count) do  Begin
        while Not FdMemVolumeLotes.Eof do Begin
          //Preencher os dados
          TThread.Synchronize(TThread.CurrentThread,
          procedure ()
          begin
            Self.LblLote.Text       := FdMemVolumeLotes.FieldByName('lote').AsString;
            Self.LblVencimento.Text := FdMemVolumeLotes.FieldByName('Vencimento').AsString;//Copy(FdMemVolumeLotes.FieldByName('vencimento').AsString, 9, 2)+'/'+
                                       //Copy(FdMemVolumeLotes.FieldByName('vencimento').AsString, 6, 2)+'/'+
                                       //Copy(FdMemVolumeLotes.FieldByName('vencimento').AsString, 1, 4);
            Self.LblQuantidade.Text := FdMemVolumeLotes.FieldByName('demanda').AsString;
            Self.LblApanhe.Text     := FormatFloat('###0', FdMemVolumeLotes.FieldByName('qtdsuprida').AsInteger);

            LytLotesItem.Tag        := X; //DM.QryCidadesCID_ID.AsInteger;

            LFrame                  := TLayout(LytLotesItem.Clone(VsbLotes));
            LFrame.Parent           := VsbLotes;
            LFrame.Height           := LytLotesItem.Height - 4;
            LFrame.Width            := LytLotesItem.Width;

            LFrame.Position.X       := 4;
            LFrame.Position.Y       := LPos;
            LFrame.Margins.Left     := 4;
            LFrame.Margins.Top      := 4;
            LFrame.Margins.Bottom   := 4;
            LFrame.Margins.Right    := 4;
          End);

          for var I : Integer := 0 to Pred(LFrame.ComponentCount) do
          begin
            if LFrame.Components[I] is TSpeedButton then
            begin
              TThread.Synchronize(
                TThread.CurrentThread,
                procedure ()
                begin
                  TSpeedButton(LFrame.Components[I]).OnClick := OnSelecionarLotes;
                end
              );
              break;
            end;
          end;
          LFrame.Visible := True;
          LPos           := LPos + LytLotesItem.Height + 4;

          FdMemVolumeLotes.Next;
        end;
      End;
      if pLoadLotes then
         ReturnJsonArray := Nil;
    end,
    procedure ()
    begin
      //Complete
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
//          TLoading.Hide;
          Self.VsbLotes.EndUpdate;
          Self.VsbLotes.Visible := True;
        end
      );
    end,
    procedure (const AException : string)
    begin
//      TLoading.Hide;
      Self.VsbLotes.EndUpdate;
      Self.VsbLotes.Visible := True;
      MensagemStand(AException);
    end,
    True
  );
end;

procedure TFrmSeparacaoColetor.MontaLoteSubstituto;
Var item : TListViewItem;
    txt : TListItemText;
    img : TListItemImage;
    Cor : Cardinal;
    xTotsubstituto : Integer;
begin
  //FdMemLoteInventariado.Filter   := 'EnderecoId = '+EdtEndereco.Tag.ToString();
  //FdMemLoteInventariado.Filtered := True;
  FDMemLoteSubstituicao.First;
  LstLoteSubstituicao.BeginUpdate;
  LstLoteSubstituicao.Items.Clear;
  xTotsubstituto := 0;
  While Not FDMemLoteSubstituicao.Eof do Begin
    if (FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger-
                   FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger) > 0 then Begin
       item := LstLoteSubstituicao.Items.Add;
       item.Objects.Clear;
       item.TagString := FDMemLoteSubstituicao.FieldByName('Lote').AsString;
       with item do begin
         // Status do Endereço...
         img := TListItemImage(Objects.FindDrawable('ImgFdoLoteInventariado'));
         img.PlaceOffset.X := 0;
         img.PlaceOffset.Y := 0;
         img.Width := 320;
         img.Height := 25;
         //img.ScalingMode := TImageScalingMode.Stretch;
         img := TListItemImage(Objects.FindDrawable('ImgLoteExcluirSel'));
         img.Bitmap := ImgLstRecycledChocolate.Bitmap;
         Img.TagString := FDMemLoteSubstituicao.FieldByName('Lote').AsString;

         // Setor...
         txt := TListItemText(Objects.FindDrawable('LInvLote'));
         txt.Text := FDMemLoteSubstituicao.FieldByName('Lote').AsString;
         txt.Font.Size := 14;
         //txt.Height    := 21;
         //Txt.Width     := 85;
         //txt.Font.Style := [TFontStyle.fsBold];
         //txt.PlaceOffset.X := 110;
         //txt.PlaceOffset.Y :=   2;
         txt.TagString     := FDMemLoteSubstituicao.FieldByName('LoteId').AsString;

         txt := TListItemText(Objects.FindDrawable('LInvVencimento'));
         txt.Text := FDMemLoteSubstituicao.FieldByName('Vencimento').AsString;
         txt.Font.Size :=  14;
         //txt.Height    :=  21;
         //Txt.Width     := 100;
         //txt.Font.Style := [TFontStyle.fsBold];
         //txt.PlaceOffset.X := 180;
         //txt.PlaceOffset.Y := 2;

         txt := TListItemText(Objects.FindDrawable('LInvQuant'));
         //txt.Text := FDMemLoteSubstituicao.FieldByName('Demanda').AsString;
         txt.Text := (FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger-
                      FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger).ToString;
         txt.Font.Size := 14;
         txt.Font.Style := [TFontStyle.fsBold];
         xTotsubstituto := xTotsubstituto + (FDMemLoteSubstituicao.FieldByName('Demanda').AsInteger-
                                             FDMemLoteSubstituicao.FieldByName('QtdSuprida').AsInteger);
       end;
    End;
    FDMemLoteSubstituicao.Next;
  End;
  LstLoteSubstituicao.EndUpdate;
  LytSubstituicaoInativa.Visible := xTotsubstituto >= StrToIntDef(EdtDemandaSubstituto.Text, 0);
  if LytSubstituicaoInativa.Visible then
     DelayEdSetFocus(SbSalvarSubstituicao)
  Else DelayEdSetFocus(EdtLoteSubstituir); //Trocar por mensagem autocnfirmação.
end;

procedure TFrmSeparacaoColetor.OnSelecionarLotes(Sender: TObject);
Begin

end;

procedure TFrmSeparacaoColetor.OpenVolumeLote(pPedidoVolumeId,
  pCodProduto: Integer);
begin
  DmeXactWMS.QryPesquisaVolumeLote.Close;
  DmeXactWMS.QryPesquisaVolumeLote.Sql.Clear;
  DmeXactWMS.QryPesquisaVolumeLote.Sql.Add('Select * from PedidoVolumeLote where PedidoVolumeId = :pPedidoVolumeId and CodProduto = :pCodProduto');
  DmeXactWMS.QryPesquisaVolumeLote.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
  DmeXactWMS.QryPesquisaVolumeLote.ParamByName('pCodProduto').Value     := pCodProduto;
  DmeXactWMS.QryPesquisaVolumeLote.Open;
end;

procedure TFrmSeparacaoColetor.OpenVolumeProduto(pPedidoVolumeId,
  pCodProduto: Integer);
begin
  DmeXactWMS.QryPesquisa.Close;
  DmeXactWMS.QryPesquisa.Sql.Clear;
  DmeXactWMS.QryPesquisa.Sql.Add('Select * from PedidoVolumeProduto where PedidoVolumeId = :pPedidoVolumeId and CodProduto = :pCodProduto');
  DmeXactWMS.QryPesquisa.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
  DmeXactWMS.QryPesquisa.ParamByName('pCodProduto').Value     := pCodProduto;
  DmeXactWMS.QryPesquisa.Open;
end;

procedure TFrmSeparacaoColetor.PermitirAcessoCtrlSeg;
begin
  inherited;
  if funcaoParaAutorizar_Liberada then
     ConfCorte;
end;

procedure TFrmSeparacaoColetor.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if PgcPrincipal.ActiveTab = TabSubstituirLote then
     LblTituloForm.Text := 'Substituir Lote. Volume: '+EdtVolumeId.Text
  Else Begin
     if Not pPanelDigitarProduto then
        LblTituloForm.Text := 'Separação de Produtos'
     Else //if FdMemProdutos.FieldByName('volumetipo').AsInteger = 0 then Begin
        LblTituloForm.Text := vTituloForm; //'Separação de Produtos - Cxa.Fechada';
//     End
//     Else LblTituloForm.Text := 'Separação de Produtos - Fracionados';
  End;
end;

procedure TFrmSeparacaoColetor.PreencherDadosSeparacao(pJsonArray : TJsonArray);
begin
  FdmemVolumeSeparacao.Open;
  FdMemVolumeSeparacao.Append;
  FdMemVolumeSeparacao.FieldByName('VolumeSeparacaoId').AsInteger := pJsonArray.Items[0].GetValue<Integer>('volumeseparacaoid', 0);
  FdMemVolumeSeparacao.FieldByName('CaixaEmbalagemId').AsInteger  := pJsonArray.Items[0].GetValue<Integer>('caixaembalagemid', 0);
  FdMemVolumeSeparacao.FieldByName('Operacao').AsInteger          := pJsonArray.Items[0].GetValue<Integer>('operacao');
  FdMemVolumeSeparacao.FieldByName('PedidoVolumeId').AsInteger    := pJsonArray.Items[0].GetValue<Integer>('pedidovolumeid');
  FdMemVolumeSeparacao.FieldByName('EnderecoId').AsInteger        := pJsonArray.Items[0].GetValue<Integer>('enderecoidseparacao', 0);
  FdMemVolumeSeparacao.FieldByName('UsuarioId').AsInteger         := pJsonArray.Items[0].GetValue<Integer>('usuarioidseparacao', 0);
  FdMemVolumeSeparacao.Post;
end;

procedure TFrmSeparacaoColetor.PthCloseAutClick(Sender: TObject);
begin
  inherited;
  DelayEdSetFocus(EdtProduto);
end;

procedure TFrmSeparacaoColetor.RctF3Click(Sender: TObject);
begin
  inherited;
  if ((FrmeXactWMS.ConfigWMS.ApanheConsolidado = 0) or (FrmeXactWMS.ConfigWMS.BeepProdIndividual = 0) or
     ((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and (StrToIntDef(EdtQtdDemanda.Text,0)>FrmeXactWMS.ConfigWMS.BeepIndividualLimiteUnid))) then Begin
     F3Press := True;
     if LytLoteApanhe.Visible then Begin
       EdtQtdeApanheLoteF3.ReadOnly := False;
       DelayedSetFocus(EdtQtdeApanheLoteF3);
       EdtProduto.ReadOnly       := False;
       EdtLoteSeparacao.ReadOnly := False;
     End
     Else Begin
       EdtQtdApanhe.ReadOnly := False;
       DelayedSetFocus(EdtQtdApanhe);
       EdtProduto.ReadOnly       := False;
       EdtLoteSeparacao.ReadOnly := False;
     End;
  End;
end;

procedure TFrmSeparacaoColetor.RctF5Click(Sender: TObject);
begin
  inherited;
  if (StrToIntDef(EdtQtdApanhe.text, 0) = 0) then
     LogOff;
end;

procedure TFrmSeparacaoColetor.RctF6Click(Sender: TObject);
begin
  inherited;
  AutorizarCorte;
end;

procedure TFrmSeparacaoColetor.RctF7Click(Sender: TObject);
begin
  inherited;
  If (pPanelDigitarProduto) then
     CallAlteracaoLotes;
end;

procedure TFrmSeparacaoColetor.RctF8Click(Sender: TObject);
begin
  inherited;
  ResetVolume
end;

procedure TFrmSeparacaoColetor.RctF9Click(Sender: TObject);
begin
  inherited;
  If (Not GetVolumeComDivergencia) then Begin
     totalizarColeta(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger);
     if (FdMemProdutos.RecordCount = 1) and (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then Begin
        ConfirmarCancelamentoDeVolume;
        Exit;
     End;
  End;
  If (pPanelDigitarProduto) then Begin
     if (FdMemProdutos.RecordCount = 1) and (DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger=0) then
        ConfirmarCancelamentoDeVolume
     Else
        ConfirmarGeracaoVolumeExtraForcado;
  End;
end;

procedure TFrmSeparacaoColetor.RedistribuirApanheParaLotes;
Var vQtdApanhe  : Integer;
    vCodProduto : Integer;
    vQtdLote    : Integer;
begin
  //pegar e salvar dados no SqLite
  OpenVolumeProduto(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger, FdMemProdutos.FieldByName('CodProduto').AsInteger);
  vQtdApanhe  := DmeXactWMS.QryPesquisa.FieldByName('QtdSuprida').AsInteger;
  vCodProduto := FdMemProdutos.FieldByName('CodProduto').AsInteger;
  FDMemVolumeLotes.First;
  OpenVolumeLote(FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger, FdMemProdutos.FieldByName('CodProduto').AsInteger);
  while (Not DmeXactWMS.QryPesquisaVolumeLote.Eof) and (vQtdApanhe>0) do Begin
    if DmeXactWMS.QryPesquisaVolumeLote.FieldByName('Demanda').AsInteger >= vQtdApanhe then Begin
       vQtdLote   := vQtdApanhe;
       vQtdApanhe := 0;
    End
    Else Begin
       vQtdLote   := DmeXactWMS.QryPesquisaVolumeLote.FieldByName('Demanda').AsInteger;
       vQtdApanhe := vQtdApanhe - DmeXactWMS.QryPesquisaVolumeLote.FieldByName('Demanda').AsInteger;
    End;
    dmeXactWMS.QryVolumeLoteSalvar.Close;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('CodProduto').Value     := FdMemVolumeLotes.FieldByName('CodProduto').AsInteger;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Lote').Value           := DmeXactWMS.QryPesquisaVolumeLote.FieldByName('Lote').AsString;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('F3Press').Value        := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Quantidade').Value     := vQtdLote;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('QtdCorte').Value       := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('QtdF3Press').Value     := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
    DmeXactWMS.QryVolumeLoteSalvar.ExecSql;
    DmeXactWMS.QryPesquisaVolumeLote.Next;
  End;
  while (Not DmeXactWMS.QryPesquisaVolumeLote.Eof) do Begin
    dmeXactWMS.QryVolumeLoteSalvar.Close;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').AsInteger;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('CodProduto').Value     := FdMemVolumeLotes.FieldByName('CodProduto').AsInteger;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Lote').Value           := DmeXactWMS.QryPesquisaVolumeLote.FieldByName('Lote').AsString;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('F3Press').Value        := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('Quantidade').Value     := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('QtdCorte').Value       := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('QtdF3Press').Value     := 0;
    DmeXactWMS.QryVolumeLoteSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
    DmeXactWMS.QryVolumeLoteSalvar.ExecSql;
    DmeXactWMS.QryPesquisaVolumeLote.Next;
  end;
end;

Function TFrmSeparacaoColetor.RegistrarAberturaSeparacao(pVolumeSeparacaoId, pOperacao, pUsuarioId : Integer) : Boolean;
Var JsonAberturaSeparacao : TjsonObject;
    JsonRetorno : TJsonObject;
    vErro : String;
begin
  Try
    Result := False;
    JsonAberturaSeparacao := TJsonObject.Create;
    JsonAberturaSeparacao.AddPair('volumeseparacaoid', TJsonNumber.Create(pVolumeSeparacaoId));
    JsonAberturaSeparacao.AddPair('caixaembalagemid', TJsonNumber.Create(StrToIntDef(EdtEmbalagemId.Text, 0)));
    JsonAberturaSeparacao.AddPair('operacao', TJsonNumber.Create(pOperacao)); //0-Aberto   1-Finalizado
    JsonAberturaSeparacao.AddPair('pedidovolumeid', TJsonNumber.Create(StrToIntDef(EdtVolumeId.Text, 0)));
    if pVolumeSeparacaoId = 0 then Begin
       JsonAberturaSeparacao.AddPair('enderecoid', TJsonNumber.Create(0));
       JsonAberturaSeparacao.AddPair('divergencia', TJsonNumber.Create(0));
    End
    Else Begin
       if pOperacao = 0 then Begin
          if (OpenSeparacaoVolume) then
             If (FdMemProdutos.Bof) or (FdMemProdutos.RecNo = 1) Then
                JsonAberturaSeparacao.AddPair('enderecoid', '0')
             Else Begin
                if FdMemProdutos.RecNo = 1 then
                   JsonAberturaSeparacao.AddPair('enderecoid', TJsonNumber.Create(FdMemProdutos.FieldByName('EnderecoId').AsInteger))
                Else Begin
                   FdMemProdutos.Prior;
                   JsonAberturaSeparacao.AddPair('enderecoid', TJsonNumber.Create(FdMemProdutos.FieldByName('EnderecoId').AsInteger));
                   FdMemProdutos.Next;
                End;
             End
          Else Begin
            JsonAberturaSeparacao.AddPair('enderecoid', TJsonNumber.Create(FdMemProdutos.FieldByName('EnderecoId').AsInteger));
          End;
       End
       Else Begin
          JsonAberturaSeparacao.AddPair('enderecoid', TJsonNumber.Create(0));
          if (FrmeXactWMS.ConfigWMS.ApanheConsolidado=1) and (vApanheConsolidadoSetor) then
             JsonAberturaSeparacao.AddPair('consolidado', TJsonNumber.Create(1))
          Else
             JsonAberturaSeparacao.AddPair('consolidado', TJsonNumber.Create(0))
       End;
       JsonAberturaSeparacao.AddPair('divergencia', TJsonNumber.Create(0));
    End;
    JsonAberturaSeparacao.AddPair('usuarioid', TJsonNumber.Create(pUsuarioId));
    JsonRetorno := DmClient.RegistrarAberturaSeparacao(vVolumeSeparacaoId, JsonAberturaSeparacao);
    if JsonRetorno.TryGetValue('Erro', vErro) then Begin
       if Not LogOffCaixa then
          ShowErro('Erro: '+vErro)
       Else
          raise Exception.Create(vErro);
    end
    Else Begin
       vVolumeSeparacaoId := JsonRetorno.GetValue<Integer>('volumeseparacaoid');
       Result := True;
    End;
    LogOffCaixa := False;
    JsonRetorno := Nil;
    Try JsonAberturaSeparacao.Free Except End;
  Except On E: Exception do Begin
    Result := False;
    if LogOffCaixa then
       raise Exception.Create(E.Message)
    Else
       Limpar(False);
    LogOffCaixa := False;
    End;
  End;
end;

procedure TFrmSeparacaoColetor.RepeatFinalizacao(vErro : String);
begin
  CodConfirmacao := 4;
  LblTituloConfirmacao.Text := 'Finalizar Processo.';
  LblTituloFoot.Text        := 'Repita o processo de Finalização.';
  LblMensagem1.Text := 'Finalizar Separação?';
  LblMensagem2.Text := 'Erro na finalização. Repita.'+#13+vErro;
//  PgcPrincipal.ActiveTab := TabConfirmacao;
  ChgTabConFirmacao.Execute;
end;

procedure TFrmSeparacaoColetor.ResetVolume;
begin
  If (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Separação - Resetar Volume')) then Begin
     ShowErro('Usuário não autorizado!', 'alarme');
     Exit;
  End;

  CodConfirmacao := 5;
  ConfirmarResetVolume;
  exit;

  TDialogService.MessageDialog('Resetar o volume('+EdtVolumeId.Text+')?',
               TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
   procedure(const AResult: TModalResult)
   begin
     if AResult = mrYes then Begin
        ConfirmaResetVolume(StrToIntDef(EdtVolumeId.Text, 0));
     End;
   End);
end;

Procedure TFrmSeparacaoColetor.ConfirmaResetVolume(pPedidoVolumeId : Integer);
Var TH : TThread;
Begin
  TH := TThread.CreateAnonymousThread(procedure
  Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
      JsonArrayRetorno : TJsonArray;
      vErro : String;
  begin
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    JsonArrayRetorno := ObjPedidoVolumeCtrl.ResetSeparacao;
    if JsonArrayRetorno.TryGetValue('Erro', vErro) then Begin
       JsonArrayRetorno := Nil;
       ObjPedidoVolumeCtrl.Free;
       Raise Exception.Create(vErro);
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
    With DmeXactWMS.QryPesquisa do Begin
      Close;
      Sql.Clear;
      Sql.Add('Delete From pedidovolumeproduto where pedidovolumeid = '+EdtVolumeId.Text+';');
      Sql.Add('Delete From pedidovolumelote where pedidovolumeid = '+EdtVolumeId.Text+';');
      ExecSql;
    End;
  End);
  TH.OnTerminate := ThreaConfirmaResetVolumeTerminate;
  TH.Start;
End;

function TFrmSeparacaoColetor.ValidaLoteSeparado: Boolean;
begin
  Result := False;
  With DmeXactWMS.QryPesquisa do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select * from PedidoVolumeLote ');
    Sql.Add('Where PedidoVolumeId = :pPedidoVolumeId and CodProduto = :pCodProduto and Lote = :pLote');
    ParamByName('pPedidoVolumeId').Value := EdtVolumeId.Text;
    ParamByName('pCodProduto').Value     := EdtProduto.Text;
    ParamByName('pLote').Value           := EdtLoteSeparacao.Text;
    Open;
    if (((FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1) and (Not F3Press) and
         (FieldByName('QtdSuprida').AsInteger+1>FieldByName('Demanda').AsInteger))) then Begin
       Result := False;
       if (LytLoteApanhe.Visible) and (EdtProduto.Text<>'') then
          SetCampoDefault('EdtLoteSeparacao')
       Else
          SetCampoDefault('EdtProduto');
       ShowErro('Lote('+EdtLoteSeparacao.Text+') já separado!');
       //Avançar Produto para Separação.
       //VerificarFinalizacaoOrContinuidadeSeparacao(False);
    end
    Else If ((F3Press) and (StrToIntDef(EdtQtdeApanheLoteF3.Text, 0) > (FieldByName('Demanda').AsInteger))) then Begin
       Result := False;
       SetCampoDefault('EdtQtdeApanheLoteF3');
       ShowErro('Quantidade('+EdtQtdeApanheLoteF3.Text+') inválida para o lote!');
    end
    Else
       Result := True;
  end;
end;

Function TFrmSeparacaoColetor.ValidarVolume : Boolean;
Var JsonArrayVolume : TJsonArray;
    vErro, vProcesso    : String;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    TH : TThread;
begin
  Result := False;
  ksLoadingIndicator1.ShowLoading;
  TH := TThread.CreateAnonymousThread(procedure
  Var jArray  : TJsonArray;
      vTpErro : String;
      vCaixaSeparacao : String;
  begin
    Try
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        LytDetalheVolume.Enabled := False;
      End);
      ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
      JsonArrayVolume := ObjPedidoVolumeCtrl.GetOpenVolumeParaSeparacao(StrTointDef(EdtEmbalagemId.Text, 0),
                                                                        StrTointDef(EdtVolumeId.Text, 0),
                                                                        FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId );
      //ObjPedidoVolumeCtrl.GetVolume(0, StrTointDef(EdtVolumeId.Text, 0), 0, 0, 'T', 0);
      if (JsonArrayVolume.Items[0].TryGetValue('Erro', vErro)) then Begin
         vTpErro := 'Erro: ';
         Raise Exception.Create(vErro);
      end
      Else if (JsonArrayVolume.Items[0].TryGetValue('MSG', vErro)) then Begin
         vTpErro := 'Atenção: ';
         Raise Exception.Create(vErro);
      End;
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
         if (EdtVolumeId.Text='') and (JsonArrayVolume.Items[0].TryGetValue('caixaseparacao', vCaixaSeparacao)) then
            DelayEdSetFocus(EdtVolumeId)
         Else Begin
            if EdtVolumeid.Text = '' then
               EdtVolumeId.Text := JsonArrayVolume.Items[0].GetValue<String>('pedidovolumeid');
            vVolumeSeparacaoId := JsonArrayVolume.Items[0].GetValue<Integer>('volumeseparacaoid');
            CabecalhoPedido(JsonArrayVolume.Items[0].GetValue<Integer>('pedidoid'),
                            JsonArrayVolume.Items[0].GetValue<String>('fantasia'),
                            JsonArrayVolume.Items[0].GetValue<String>('documentodata'),
                            JsonArrayVolume.Items[0].GetValue<Integer>('rotaid') );
            PreencherDadosSeparacao(JsonArrayVolume);
            vEnderecoIdSeparado := JsonArrayVolume.Items[0].GetValue<Integer>('enderecoidseparacao');
            BuscarVolumeLotesParaSeparacao(JsonArrayVolume.Items[0].GetValue<Integer>('enderecoidseparacao'));
         End;
      End);
      JsonArrayVolume := Nil;
      FreeAndNil(ObjPedidoVolumeCtrl);
    Except On E: Exception do Begin
      JsonArrayVolume := Nil;
      FreeAndNil(ObjPedidoVolumeCtrl);
      raise Exception.Create(vTpErro+E.Message);
      End;
    end;
  End);
  Th.OnTerminate := ThreadValidarVolumeTerminate;
  TH.Start;
end;


procedure TFrmSeparacaoColetor.ZerarLoteParaExtraExcesso;
begin
  dmeXactWMS.QryVolumeProdutoSalvar.Close;
  if F3Press then
     DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('F3Press').Value := 1
  Else
     DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('F3Press').Value := 0;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('CodProduto').Value     := FdMemProdutos.FieldByName('CodProduto').Asinteger;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('Quantidade').Value     := 0;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('QtdCorte').Value       := vQtdCorte;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('QtdF3Press').Value     := 0;
  DmeXactWMS.QryVolumeProdutoSalvar.ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  With DmeXactWMS.QryVolumeCorteLote do Begin
    Close;
    ParamByName('PedidoVolumeId').Value := FdMemProdutos.FieldByName('PedidoVolumeId').Asinteger;
    ParamByName('CodProduto').value     := FdMemProdutos.FieldByName('CodProduto').Asinteger;
    ParamByName('UsuarioId').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  End;
  DmeXactWMS.QryVolumeProdutoSalvar.ExecSql;
  DmeXactWMS.QryVolumeCorteLote.ExecSql;
end;

End.
