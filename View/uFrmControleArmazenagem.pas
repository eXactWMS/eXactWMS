unit uFrmControleArmazenagem;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
 cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
 FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
 FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
 System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
 FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
 Vcl.Imaging.jpeg, acImage, acPNG, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Buttons,
 AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.DBGrids,
 Vcl.ComCtrls, EnderecoClass, EnderecoCtrl, ProdutoCtrl, System.Rtti, System.Bindings.Outputs,
 Vcl.Bind.Editors, Generics.Collections, DataSet.Serialize, Data.Bind.EngExt,
 Vcl.Bind.DBEngExt, Data.Bind.Components, System.Json,
 Data.Bind.DBScope
 , EstoqueClass, EstoqueCtrl, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits,
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  dxCameraControl, FireDAC.Stan.StorageBin;

type
 TTipoMovimentacao  = (poNenhum, poAbastecimentoPicking, poPulmao, poRetidadaStage, poSegregado);

 TFrmControleArmazenagem = class(TFrmBase)
  Label2: TLabel;
  CbRetiraEstoque: TComboBox;
  PnlDisponibilidade: TPanel;
  DBGrid2: TDBGrid;
  Panel5: TPanel;
    PnlMovimentacao: TPanel;
  EdtEnderecoOrigem: TLabeledEdit;
  EdtProduto: TLabeledEdit;
  LblProdutoOrigem: TLabel;
  LblProdutoPicking: TLabel;
  Label16: TLabel;
  LblVencimento: TLabel;
  EdtEnderecoDestino: TLabeledEdit;
  LblEnderecoOrigem: TLabel;
  Bevel3: TBevel;
  LblEstoqueOrigem: TLabel;
  Label22: TLabel;
  LblDestino: TLabel;
  PnlTipoMovimentacao: TPanel;
  LblZonaOrigem: TLabel;
  Label14: TLabel;
  CbLote: TComboBox;
  FdMemPesqGeralProdutoId: TIntegerField;
  FdMemPesqGeralCodigoERP: TIntegerField;
  FdMemPesqGeralProduto: TStringField;
  FdMemPesqGeralLoteId: TIntegerField;
  BindSourceDB1: TBindSourceDB;
  BindingsList1: TBindingsList;
  LinkFillControlToField1: TLinkFillControlToField;
  FdMemPesqGeralLote: TStringField;
  FdMemPesqGeralVencimento: TDateField;
    FdMemEstoqueOrigem: TFDMemTable;
  IntegerField1: TIntegerField;
  IntegerField2: TIntegerField;
  StringField1: TStringField;
  IntegerField3: TIntegerField;
  DateField1: TDateField;
    FdMemEstoqueOrigemMesSaidaMinima: TIntegerField;
    FdMemEstoqueOrigemQtdUnid: TIntegerField;
    FdMemEstoqueOrigemFatorConversao: TIntegerField;
    FdMemEstoqueOrigemEnderecoId: TIntegerField;
    FdMemEstoqueOrigemEndereco: TStringField;
    FdMemEstoqueOrigemEstruturaId: TIntegerField;
    FdMemEstoqueOrigemEstrutura: TStringField;
    FdMemEstoqueOrigemPickingFixo: TIntegerField;
    FdMemEstoqueOrigemStatus: TIntegerField;
    FdMemEstoqueOrigemZonaId: TIntegerField;
    FdMemEstoqueOrigemZona: TStringField;
    FdMemEstoqueOrigemQtdeProducao: TIntegerField;
    FdMemEstoqueOrigemQtdeReserva: TIntegerField;
    FdMemEstoqueOrigemQtde: TIntegerField;
    FdMemEstoqueOrigemEstoqueTipoId: TIntegerField;
    FdMemEstoqueOrigemDtEntrada: TDateField;
    FdMemEstoqueOrigemHrEntrada: TTimeField;
    FdMemEstoqueOrigemHorario: TDateTimeField;
    FdMemEstoqueOrigemProducao: TIntegerField;
    FdMemEstoqueOrigemDistribuicao: TIntegerField;
    FdMemEstoqueOrigemOrdem: TIntegerField;
    FdMemEstoqueOrigemFabricacao: TDateField;
    FdMemEstoqueOrigemEmbPrim: TStringField;
    FdMemEstoqueOrigemEmbSec: TStringField;
    FdMemEstoqueOrigemDescrLote: TStringField;
    FdMemEstoqueOrigemEstoqueTipo: TStringField;
    FdMemEstoqueOrigemUsuarioId: TIntegerField;
    Label15: TLabel;
    EdtEstoqueLoteDisponivel: TJvCalcEdit;
    FdMemEstoqueOrigemUnidadeId: TIntegerField;
    FdMemEstoqueOrigemUnidadeSecundariaId: TIntegerField;
    Label17: TLabel;
    EdtQtdMovimentacao: TJvCalcEdit;
    FdMemEstoqueDestino: TFDMemTable;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField2: TStringField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    StringField5: TStringField;
    DateField2: TDateField;
    DateField3: TDateField;
    IntegerField12: TIntegerField;
    StringField6: TStringField;
    IntegerField13: TIntegerField;
    StringField7: TStringField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    IntegerField16: TIntegerField;
    StringField8: TStringField;
    IntegerField17: TIntegerField;
    IntegerField18: TIntegerField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    StringField9: TStringField;
    IntegerField21: TIntegerField;
    IntegerField22: TIntegerField;
    DateField4: TDateField;
    TimeField1: TTimeField;
    DateTimeField1: TDateTimeField;
    IntegerField23: TIntegerField;
    IntegerField24: TIntegerField;
    LblZonaDestino: TLabel;
    BtnReabastecerPicking: TPanel;
    ImgReabastecerPicking: TsImage;
    Label19: TLabel;
    BtnMovimentaPulmao: TPanel;
    ImgPulmao: TsImage;
    Label20: TLabel;
    BtnSegregado: TPanel;
    ImgSegregado: TsImage;
    LblSegregado: TLabel;
    Panel3: TPanel;
    LblTpMov: TLabel;
    LblTipoMovimentacao: TLabel;
    FDMemEnderecoOrigem: TFDMemTable;
    FDMemEnderecoDestino: TFDMemTable;
    dsEnderecoOrigem: TDataSource;
    DBGrid1: TDBGrid;
    DsEstoqueOrigem: TDataSource;
    DsEstoqueDestino: TDataSource;
    BtnRetiradaStage: TPanel;
    ImgStage: TsImage;
    Label18: TLabel;
    LblMotivoSegregado: TLabel;
    CbMotivo: TComboBox;
    EdtLote: TEdit;
    LblConfirmaPallet: TLabel;
    BtnSalvarSegregado: TPanel;
    sImage1: TsImage;
    FDMemSegregadoCausa: TFDMemTable;
    FDMemSegregadoCausaSegregadoCausaId: TIntegerField;
    FDMemSegregadoCausaDescricao: TStringField;
    ChkPalletInteiro: TCheckBox;
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEnderecoOrigemExit(Sender: TObject);
    procedure EdtQtdMovimentacaoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtProdutoExit(Sender: TObject);
    procedure CbLoteChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtEnderecoDestinoExit(Sender: TObject);
    procedure TabListagemShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtEnderecoOrigemEnter(Sender: TObject);
    procedure CbLoteExit(Sender: TObject);
    procedure EdtQtdMovimentacaoExit(Sender: TObject);
    procedure EdtEnderecoOrigemChange(Sender: TObject);
    procedure EdtProdutoChange(Sender: TObject);
    procedure BtnReabastecerPickingClick(Sender: TObject);
    procedure BtnMovimentaPulmaoClick(Sender: TObject);
    procedure BtnSegregadoClick(Sender: TObject);
    procedure BtnRetiradaStageClick(Sender: TObject);
    procedure EdtLoteExit(Sender: TObject);
    procedure CbLoteClick(Sender: TObject);
    procedure EdtLoteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtEnderecoDestinoChange(Sender: TObject);
    procedure EdtEnderecoDestinoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtEnderecoDestinoEnter(Sender: TObject);
    procedure EdtEnderecoOrigemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CbMotivoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChkPalletInteiroClick(Sender: TObject);
    procedure BtnSalvarSegregadoClick(Sender: TObject);
 private
    { Private declarations }
    ObjEnderecoCtrl, ObjEnderecoDestinoCtrl : TEnderecoCtrl;
    ObjProdutoCtrl: tProdutoCtrl;
    TipoMovimentacao : TTipoMovimentacao;
    vConfirmaPallet : String;
    vZonaOrigem : Integer;
    Procedure PesquisarClickInLstCadastro(ACol, ARow: Integer); OverRide;
    Procedure GetListaMovimentacao(pUsuarioId : Integer; pDataInicial, pDataFinal : TDateTime; pCodigoERP : Integer; pNomeEstacao, pOrigem, pDestino : String; pShowErro : Integer);
    Procedure ClearMovimentacao(Sender: TObject);
    Procedure GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pProducao, pDistribuicao: Integer; Sender : TObject);
    Procedure DefinirLabelTipoMovimentacao;
    Procedure GetListaEndereco(pEnderecoId : Integer = 0; pEstruturaID : Integer = 0;
                               pZonaId : Integer = 0; pEnderecoIni : String = ''; pEnderecoFin: String = '');
    Procedure ConfirmarMovimentacao(pOrigem, pDestino : String);
    Procedure LimparMovimentacaoProduto;
    Function ValidaMovimentacao : Boolean;
    Function VerificarLoteFIFOparaPicking : Boolean;
    Procedure SalvarMovimentacao;
    Procedure MotivoSegregadoOnOff(pOnOff : Boolean);
 Protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
 public
  { Public declarations }
 end;

var
 FrmControleArmazenagem: TFrmControleArmazenagem;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS;

{ TFrmControleArmazenagem }

procedure EmptyKeyQueue;
var Msg: TMsg;
begin
while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE or PM_NOYIELD) do;
end;

procedure TFrmControleArmazenagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 inherited;
 if Assigned(ObjEnderecoCtrl) then
    FreeAndNil(ObjEnderecoCtrl);
 if Assigned(ObjEnderecoDestinoCtrl) then
    FreeAndNil(ObjEnderecoDestinoCtrl);
 if Assigned(ObjProdutoCtrl) then
    FreeAndNil(ObjProdutoCtrl);
 FrmControleArmazenagem := Nil;
end;

procedure TFrmControleArmazenagem.FormCreate(Sender: TObject);
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro   : String;
    xMotivo : Integer;
begin
  inherited;
  TipoMovimentacao := poNenhum;
  LstCadastro.ColWidths[0]  := 60;
  LstCadastro.ColWidths[1]  := 70;
  LstCadastro.ColWidths[2]  := 200;
  LstCadastro.ColWidths[3]  := 40;
  LstCadastro.ColWidths[4]  := 90;
  LstCadastro.ColWidths[5]  := 80;
  LstCadastro.ColWidths[6]  := 140;
  LstCadastro.ColWidths[7]  := 100;
  LstCadastro.ColWidths[8]  := 50;
  LstCadastro.ColWidths[9]  := 50;
  LstCadastro.ColWidths[10] := 50;
  LstCadastro.ColWidths[11] := 100;
  LstCadastro.ColWidths[12] := 70;
  LstCadastro.ColWidths[13] := 70;
  LstCadastro.ColWidths[14] := 100;
  LstCadastro.ColWidths[15] := 80;
  LstCadastro.ColWidths[16] := 80;
  LstCadastro.Alignments[0,  0] := taRightJustify;
  LstCadastro.Alignments[1,  0] := taRightJustify;
  LstCadastro.Alignments[3,  0] := taRightJustify;
  LstCadastro.Alignments[5,  0] := taCenter;
  LstCadastro.Alignments[8,  0] := taRightJustify;
  LstCadastro.Alignments[9,  0] := taRightJustify;
  LstCadastro.Alignments[10, 0] := taRightJustify;
  LstCadastro.Alignments[11, 0] := taRightJustify;
  LstCadastro.Alignments[12, 0] := taRightJustify;
  LstCadastro.Alignments[13, 0] := taRightJustify;
 // GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date());
 // LstCadastro.SortSettings.Column := 1;
 // LstCadastro.QSort;
 // AdvGridLookupBar1.Column := 1;
  SetReadOnly;
  ObjEnderecoCtrl        := TEnderecoCtrl.Create();
  ObjEnderecoDestinoCtrl := TEnderecoCtrl.Create();
  ObjProdutoCtrl         := tProdutoCtrl.Create();
  CbMotivo.Items.Clear;
  ObjEstoqueCtrl         := TEstoqueCtrl.Create;
  JsonArrayRetorno       := ObjEstoqueCtrl.GetMotivoMovimentacaoSegregado(1); //Somente Ativos
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     JsonArrayRetorno := Nil;
     ObjEstoqueCtrl.Free;
     Exit;
  End
  Else Begin
     if (FDMemSegregadoCausa.Active) then
        FDMemSegregadoCausa.EmptyDataSet;
     FDMemSegregadoCausa.Close;
     FDMemSegregadoCausa.loadFromJson(JsonArrayRetorno, False);
     for xMotivo := 0 to Pred(JsonArrayRetorno.Count) do
       CbMotivo.Items.Add(JsonArrayRetorno.Items[xmotivo].GetValue<String>('descricao'));
     JsonArrayRetorno := Nil;
     ObjEstoqueCtrl.Free;
  End;
End;

procedure TFrmControleArmazenagem.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
   if Key = Vk_F2 then Exit;
   if Key = Vk_F3 then Exit;
   if Key = Vk_F4 then Exit;
   if Key = Vk_F5 then Exit;
   if Key = Vk_F6 then Exit;
   if Key = Vk_F7 then Exit;
   if Key = Vk_F10 then Exit;
   if Key = Vk_F12 then Exit;
   if Sender = EdtEnderecoDestino then Exit
   Else inherited;
}  If (Key = VK_F9) and (vLastErro <> '') then ShowErro(vLastErro);
end;

procedure TFrmControleArmazenagem.FormShow(Sender: TObject);
begin
  inherited;
  ClearMovimentacao(EdtEnderecoDestino);
end;

procedure TFrmControleArmazenagem.GetEstoque(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao: Integer; Sender : TObject);
Var ObjEstoqueCtrl : TEstoqueCtrl;
    xReturn        : Integer;
    LstEstoque     : TObjectList<TEstoque>;
    vEstoque       : Integer;
begin
  if ((TipoMovimentacao = poAbastecimentoPicking) and (Sender = EdtEnderecoOrigem)) or
     (TipoMovimentacao <> poAbastecimentoPicking) then
     LblConfirmaPallet.Caption := '';
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  if (Sender=EdtEnderecoOrigem) or (Sender=CbLote) or (Sender=EdtLote)then
     if (TipoMovimentacao = poAbastecimentoPicking) then
        LstEstoque   := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'S', 'S', 0)
     Else LstEstoque   := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'N', 'N', 0)
  Else
     if (TipoMovimentacao = poAbastecimentoPicking) then
        LstEstoque := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'N', 'N', 0)
     Else LstEstoque := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'S', 'S', 0);
  vEstoque       := 0;
  if (LstEstoque.Count <= 0) and (((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
                                  ((Sender = EdtEnderecoDestino) and (TipoMovimentacao=poAbastecimentoPicking)))then Begin
     ClearMovimentacao(EdtEnderecoDestino);
     if TipoMovimentacao = poAbastecimentoPicking then
        raise Exception.Create('Não há estoque disponível para o Abastecimento.')
     Else raise Exception.Create('Não há estoque Disponível para Movimentação.');
  End;
  if ((pProdutoId <> 0) and (TipoMovimentacao <> poAbastecimentoPicking)) or
     ((TipoMovimentacao = poAbastecimentoPicking) and (pProdutoId=0)) then Begin
     For xReturn := 0 To LstEstoque.Count-1 do
       vEstoque := vEstoque + LstEstoque[xReturn].Qtde;
     LblEstoqueOrigem.Caption := FormatFloat('0', vEstoque);
  End;
  if ((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
     ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking)) then Begin
     if not (FdMemEstoqueOrigem.Active) then
        FdMemEstoqueOrigem.Open;
     FdMemEstoqueOrigem.EmptyDataSet;
     EdtLote.Clear;
     CbLote.Items.Clear;
  End
  Else Begin
     if not (FdMemEstoqueDestino.Active) then
        FdMemEstoqueDestino.Open;
     FdMemEstoqueDestino.EmptyDataSet;
  End;
  CbLote.Enabled             := True;
  EdtLote.Enabled            := True;
  EdtEnderecoDestino.Enabled := True;
  if ((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
       ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking)) then Begin
     EdtLote.Clear;;
     CbLote.Items.Clear;
  End;
  for xReturn := 0 to Pred(LstEstoque.Count) do Begin
    if ((Sender = EdtEnderecoOrigem)  and (TipoMovimentacao <> poAbastecimentoPicking)) or
       ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking))  then Begin
       FdMemEstoqueOrigem.Append;
       FdMemEstoqueOrigem.FieldByName('ProdutoId').AsInteger      := LstEstoque[xReturn].produtoid;
       FdMemEstoqueOrigem.FieldByName('CodigoERP').AsInteger      := LstEstoque[xReturn].codigoerp;
       FdMemEstoqueOrigem.FieldByName('Produto').AsString         := LstEstoque[xReturn].produto;
       FdMemEstoqueOrigem.FieldByName('Unidadeid').AsInteger      := LstEstoque[xReturn].UnidadeId;
       FdMemEstoqueOrigem.FieldByName('UnidadeSecundariaId').AsInteger := LstEstoque[xReturn].UnidadeSecundariaId;
       FdMemEstoqueOrigem.FieldByName('EmbPrim').AsString         := LstEstoque[xReturn].Embprim;
       FdMemEstoqueOrigem.FieldByName('EmbSec').AsString          := LstEstoque[xReturn].embsec;
       FdMemEstoqueOrigem.FieldByName('QtdUnid').AsInteger        := LstEstoque[xReturn].qtdunid;
       FdMemEstoqueOrigem.FieldByName('FatorConversao').AsInteger := LstEstoque[xReturn].fatorconversao;
       FdMemEstoqueOrigem.FieldByName('MesSaidaMinima').AsInteger := LstEstoque[xReturn].messaidaminima;
       FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger         := LstEstoque[xReturn].loteid;
       FdMemEstoqueOrigem.FieldByName('DescrLote').AsString       := LstEstoque[xReturn].Descrlote;
       FdMemEstoqueOrigem.FieldByName('Fabricacao').AsDateTime    := LstEstoque[xReturn].fabricacao;
       FdMemEstoqueOrigem.FieldByName('Vencimento').AsDateTime    := LstEstoque[xReturn].vencimento;
       FdMemEstoqueOrigem.FieldByName('EnderecoId').AsInteger     := LstEstoque[xReturn].enderecoid;
       FdMemEstoqueOrigem.FieldByName('Endereco').AsString        := LstEstoque[xReturn].endereco;
       FdMemEstoqueOrigem.FieldByName('EstruturaId').AsInteger    := LstEstoque[xReturn].estruturaid;
       FdMemEstoqueOrigem.FieldByName('Estrutura').AsString       := LstEstoque[xReturn].estrutura;
       FdMemEstoqueOrigem.FieldByName('PickingFixo').AsInteger    := LstEstoque[xReturn].pickingfixo;
       FdMemEstoqueOrigem.FieldByName('Status').AsInteger         := LstEstoque[xReturn].status;
       FdMemEstoqueOrigem.FieldByName('ZonaID').AsInteger         := LstEstoque[xReturn].zonaid;
       FdMemEstoqueOrigem.FieldByName('Zona').AsString            := LstEstoque[xReturn].zona;
       FdMemEstoqueOrigem.FieldByName('QtdeProducao').AsInteger   := LstEstoque[xReturn].QtdeProducao;
       FdMemEstoqueOrigem.FieldByName('QtdeReserva').AsInteger    := LstEstoque[xReturn].QtdeReserva;
       FdMemEstoqueOrigem.FieldByName('Qtde').AsInteger           := LstEstoque[xReturn].qtde;
       FdMemEstoqueOrigem.FieldByName('EstoqueTipoId').AsInteger  := LstEstoque[xReturn].EstoqueTipoId;
       FdMemEstoqueOrigem.FieldByName('EstoqueTipo').AsString     := LstEstoque[xReturn].EstoqueTipo;
       FdMemEstoqueOrigem.FieldByName('Producao').AsInteger       := LstEstoque[xReturn].producao;
       FdMemEstoqueOrigem.FieldByName('Distribuicao').AsInteger   := LstEstoque[xReturn].distribuicao;
       FdMemEstoqueOrigem.FieldByName('DtEntrada').AsDateTime     := LstEstoque[xReturn].dtentrada;
       FdMemEstoqueOrigem.FieldByName('HrEntrada').AsDateTime     := LstEstoque[xReturn].HrEntrada;
       FdMemEstoqueOrigem.FieldByName('Horario').AsDateTime       := LstEstoque[xReturn].Horario;
       FdMemEstoqueOrigem.FieldByName('UsuarioId').AsInteger      := LstEstoque[xReturn].UsuarioId;
       FdMemEstoqueOrigem.FieldByName('Ordem').AsInteger          := LstEstoque[xReturn].Ordem;
       FdMemEstoqueOrigem.Post;
       if pProdutoId <> 0 then Begin
          if TipoMovimentacao = poAbastecimentoPicking then Begin
             if FdMemEstoqueOrigem.IsEmpty then
                raise Exception.Create('Não existe estoque disponível para reabastecer Picking!');
             CbLote.Items.Clear;
             EdtLote.Clear;
             CbLote.Items.Add(FdmemEstoqueOrigem.FieldByName('DescrLote').AsString);
             if FdMemEstoqueOrigem.RecordCount = 1 then Begin
                CbLote.ItemIndex           := 0;
                CbLoteChange(CbLote);
                EdtLote.Text := CbLote.Text;
                EdtEnderecoDestino.Text    := FdMemEstoqueOrigem.FieldByName('Endereco').AsString;
                CbLote.Enabled             := False;
                EdtLote.Enabled            := False;
                EdtEnderecoDestino.Enabled := True;
                EdtQtdMovimentacao.Enabled := True;
                edtQtdMovimentacao.SetFocus;
             End;
             Break;
          End
          Else
          CbLote.Items.Add(LstEstoque[xReturn].Descrlote);
       End;
    End
    Else Begin
       FdMemEstoqueDestino.Append;
       FdMemEstoqueDestino.FieldByName('ProdutoId').AsInteger      := LstEstoque[xReturn].produtoid;
       FdMemEstoqueDestino.FieldByName('CodigoERP').AsInteger      := LstEstoque[xReturn].codigoerp;
       FdMemEstoqueDestino.FieldByName('Produto').AsString         := LstEstoque[xReturn].produto;
       FdMemEstoqueDestino.FieldByName('Unidadeid').AsInteger      := LstEstoque[xReturn].UnidadeId;
       FdMemEstoqueDestino.FieldByName('UnidadeSecundariaId').AsInteger := LstEstoque[xReturn].UnidadeSecundariaId;
       FdMemEstoqueDestino.FieldByName('EmbPrim').AsString         := LstEstoque[xReturn].Embprim;
       FdMemEstoqueDestino.FieldByName('EmbSec').AsString          := LstEstoque[xReturn].embsec;
       FdMemEstoqueDestino.FieldByName('QtdUnid').AsInteger        := LstEstoque[xReturn].qtdunid;
       FdMemEstoqueDestino.FieldByName('FatorConversao').AsInteger := LstEstoque[xReturn].fatorconversao;
       FdMemEstoqueDestino.FieldByName('MesSaidaMinima').AsInteger := LstEstoque[xReturn].messaidaminima;
       FdMemEstoqueDestino.FieldByName('LoteId').AsInteger         := LstEstoque[xReturn].loteid;
       FdMemEstoqueDestino.FieldByName('DescrLote').AsString       := LstEstoque[xReturn].Descrlote;
       FdMemEstoqueDestino.FieldByName('Fabricacao').AsDateTime    := LstEstoque[xReturn].fabricacao;
       FdMemEstoqueDestino.FieldByName('Vencimento').AsDateTime    := LstEstoque[xReturn].vencimento;
       FdMemEstoqueDestino.FieldByName('EnderecoId').AsInteger     := LstEstoque[xReturn].enderecoid;
       FdMemEstoqueDestino.FieldByName('Endereco').AsString        := LstEstoque[xReturn].endereco;
       FdMemEstoqueDestino.FieldByName('EstruturaId').AsInteger    := LstEstoque[xReturn].estruturaid;
       FdMemEstoqueDestino.FieldByName('Estrutura').AsString       := LstEstoque[xReturn].estrutura;
       FdMemEstoqueDestino.FieldByName('PickingFixo').AsInteger    := LstEstoque[xReturn].pickingfixo;
       FdMemEstoqueDestino.FieldByName('Status').AsInteger         := LstEstoque[xReturn].status;
       FdMemEstoqueDestino.FieldByName('ZonaID').AsInteger         := LstEstoque[xReturn].zonaid;
       FdMemEstoqueDestino.FieldByName('Zona').AsString            := LstEstoque[xReturn].zona;
       FdMemEstoqueDestino.FieldByName('QtdeProducao').AsInteger   := LstEstoque[xReturn].QtdeProducao;
       FdMemEstoqueDestino.FieldByName('QtdeReserva').AsInteger    := LstEstoque[xReturn].QtdeReserva;
       FdMemEstoqueDestino.FieldByName('Qtde').AsInteger           := LstEstoque[xReturn].qtde;
       FdMemEstoqueDestino.FieldByName('EstoqueTipoId').AsInteger  := LstEstoque[xReturn].EstoqueTipoId;
       FdMemEstoqueDestino.FieldByName('EstoqueTipo').AsString     := LstEstoque[xReturn].EstoqueTipo;
       FdMemEstoqueDestino.FieldByName('Producao').AsInteger       := LstEstoque[xReturn].producao;
       FdMemEstoqueDestino.FieldByName('Distribuicao').AsInteger   := LstEstoque[xReturn].distribuicao;
       FdMemEstoqueDestino.FieldByName('DtEntrada').AsDateTime     := LstEstoque[xReturn].dtentrada;
       FdMemEstoqueDestino.FieldByName('HrEntrada').AsDateTime     := LstEstoque[xReturn].HrEntrada;
       FdMemEstoqueDestino.FieldByName('Horario').AsDateTime       := LstEstoque[xReturn].Horario;
       FdMemEstoqueDestino.FieldByName('UsuarioId').AsInteger      := LstEstoque[xReturn].UsuarioId;
       FdMemEstoqueDestino.FieldByName('Ordem').AsInteger          := LstEstoque[xReturn].Ordem;
       FdMemEstoqueDestino.IndexFieldNames := 'Vencimento';
       FdMemEstoqueDestino.First;
    End;
  End;
  if ((CbLote.Items.Count = 1) or (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2)) and (Sender=EdtEnderecoOrigem) then Begin
      if (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2) and (TipoMovimentacao <> poSegregado) then Begin
         CbLote.ItemIndex := Pred(CbLote.Items.Count);
         EdtLote.Text := Cblote.Text;
         EdtLoteExit(EdtLote);
         EdtLote.Enabled := False;
         CbLote.Enabled  := False;
         EdtQtdMovimentacao.SetFocus;
      End
      Else begin
        CbLote.ItemIndex := -1;
        EdtLote.Clear;
        EdtLote.SetFocus;
      end;
  End
  Else Begin
     if Not (TipoMovimentacao in [poAbastecimentoPicking]) then Begin
        if (EdtProduto.Text = '') then
           EdtProduto.SetFocus
        Else Begin
           if Not ((Sender=EdtEnderecoDestino) and (TipoMovimentacao = poSegregado)) then
              EdtLote.setFocus //EdtProduto.SetFocus
        End;
     End
     Else begin
        EdtQtdMovimentacao.SetFocus;
        LblConfirmaPallet.Caption := 'Confirme o Pallet:'+#13+EdtEnderecoDestino.Text;
        vConfirmaPallet           := EdtEnderecoDestino.Text;
        EdtEnderecoDestino.Clear;
     end;
  End;
end;

procedure TFrmControleArmazenagem.GetListaEndereco(pEnderecoId, pEstruturaID,
  pZonaId: Integer; pEnderecoIni, pEnderecoFin: String);
begin
  FdMemEnderecoOrigem.LoadFromJson(ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, '', '', 'T', 2, 0, 1), False);
  FDMemEnderecoOrigem.IndexFieldNames:= 'descricao'; //Descrição do Endereço
end;

procedure TFrmControleArmazenagem.GetListaLstCadastro;
begin
  inherited;
  GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), 0, '', '', '', 0);
end;

procedure TFrmControleArmazenagem.GetListaMovimentacao(pUsuarioId : Integer; pDataInicial, pDataFinal : TDateTime; pCodigoERP : Integer; pNomeEstacao, pOrigem, pDestino : String; pShowErro : Integer);
Var ObjEstoqueCtrl  : TEstoqueCtrl;
    ReturnJsonArray : TJsonArray;
    xListaKardex    : Integer;
    vErro           : String;
begin
  ObjEstoqueCtrl  := TEstoqueCtrl.Create;
  ReturnJsonArray := ObjEstoqueCtrl.GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), pCodigoERP, pNomeEstacao, pOrigem, pDestino, 0);
  if (ReturnJsonArray.Items[0].TryGetValue<String>('Erro', vErro)) then  Begin
//     ShowErro(ReturnJsonArray.Items[0].GetValue<String>('Erro'));
     Exit; //raise Exception.Create('Erro: '+ReturnJsonArray.Get(0).GetValue<String>('Erro'));
  End;
  LstCadastro.RowCount := ReturnJsonArray.Count+1;
  For xListaKardex := 0 To Pred(ReturnJsonArray.Count) do begin
    LstCadastro.Cells[0, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<Integer>('produtoid').ToString();
    LstCadastro.Cells[1, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<Integer>('codigoerp').ToString();
    LstCadastro.Cells[2, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<String>('descricao');
    LstCadastro.Cells[3, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<Integer>('loteid').ToString();
    LstCadastro.Cells[4, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<String>('descrlote');
    LstCadastro.Cells[5, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<String>('vencimento');
    LstCadastro.Cells[6, xListaKardex+1]  := ReturnJsonArray.Get(xListaKardex).GetValue<String>('estoquetipo');
    LstCadastro.Cells[7, xListaKardex+1]  := EnderecoMask(ReturnJsonArray.Get(xListaKardex).GetValue<String>('enderecoorigem'),
                                                          ReturnJsonArray.Get(xListaKardex).GetValue<String>('mascaraorigem'), True);
    LstCadastro.Cells[8, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<Integer>('saldoinicialorigem').ToString();
    LstCadastro.Cells[9, xListaKardex+1]  := ReturnJsonArray.Items[xListaKardex].GetValue<Integer>('retirada').ToString();
    LstCadastro.Cells[10, xListaKardex+1] := (StrToIntDef(LstCadastro.Cells[8, xListaKardex+1], 0)-StrToIntDef(LstCadastro.Cells[9, xListaKardex+1], 0)).ToString();
    LstCadastro.Cells[11, xListaKardex+1] := EnderecoMask(ReturnJsonArray.Items[xListaKardex].GetValue<String>('destino'),
                                                          ReturnJsonArray.Items[xListaKardex].GetValue<String>('mascaradestino'), True) ;
    LstCadastro.Cells[12, xListaKardex+1] := ReturnJsonArray.Items[xListaKardex].GetValue<Integer>('saldoinicialdestino').ToString();
    LstCadastro.Cells[13, xListaKardex+1] := (StrToIntDef(LstCadastro.Cells[12, xListaKardex+1], 0)+StrToIntDef(LstCadastro.Cells[8,xListaKardex+1], 0)).ToString;
    LstCadastro.Cells[14, xListaKardex+1] := ReturnJsonArray.Items[xListaKardex].GetValue<String>('nomeestacao');
    LstCadastro.Cells[15, xListaKardex+1] := ReturnJsonArray.Items[xListaKardex].GetValue<String>('data');
    LstCadastro.Cells[16, xListaKardex+1] := ReturnJsonArray.Items[xListaKardex].GetValue<String>('hora');
    LstCadastro.Alignments[0, xListaKardex+1]  := taRightJustify;
    LstCadastro.Alignments[1, xListaKardex+1]  := taRightJustify;
    LstCadastro.Alignments[3, xListaKardex+1]  := taRightJustify;
    LstCadastro.Alignments[5, xListaKardex+1]  := taCenter;
    LstCadastro.Alignments[8, xListaKardex+1]  := taRightJustify;
    LstCadastro.Alignments[9, xListaKardex+1]  := taRightJustify;
    LstCadastro.Alignments[10, xListaKardex+1]  := taRightJustify;
    LstCadastro.Alignments[11, xListaKardex+1] := taRightJustify;
    LstCadastro.Alignments[12, xListaKardex+1] := taRightJustify;
    LstCadastro.Alignments[13, xListaKardex+1] := taRightJustify;
//    LstCadastro.FontStyles[0, xLista+1]   := [FsBold];
   end;
end;

procedure TFrmControleArmazenagem.BtnReabastecerPickingClick(Sender: TObject);
begin
  inherited;
  TipoMovimentacao := poAbastecimentoPicking;
  DefinirLabelTipoMovimentacao;
end;

procedure TFrmControleArmazenagem.BtnRetiradaStageClick(Sender: TObject);
begin
  inherited;
  TipoMovimentacao := poRetidadaStage;
  DefinirLabelTipoMovimentacao;
end;

procedure TFrmControleArmazenagem.BtnSalvarSegregadoClick(Sender: TObject);
Var vOrigem, vDestino : String;
begin
  inherited;
  if (CbMotivo.Itemindex < 0) then Begin
     ShowErro('Informe da segregação do produto/lote');
     CbMotivo.SetFocus;
  End
  Else Begin
     vOrigem  := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
     vDestino := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
     ConfirmarMovimentacao(vOrigem, vDestino);
  End;
end;

procedure TFrmControleArmazenagem.BtnSegregadoClick(Sender: TObject);
begin
  inherited;
  TipoMovimentacao := poSegregado;
  DefinirLabelTipoMovimentacao;
end;

procedure TFrmControleArmazenagem.CbLoteChange(Sender: TObject);
begin
  inherited;
  EdtQtdMovimentacao.Clear;
   EdtEnderecoDestino.Clear;
  If FdMemEstoqueOrigem.Locate('ProdutoId;DescrLote', VarArrayOf([ObjProdutoCtrl.ObjProduto.IdProduto, CbLote.text]), []) then Begin
     LblVencimento.Caption          := FdMemEstoqueOrigem.FieldByName('Vencimento').AsString;
     EdtEstoqueLoteDisponivel.Value := FdMemEstoqueOrigem.FieldByName('Qtde').AsInteger;
    // edtQtdMovimentacao.MaxValue    := FdMemEstoqueOrigem.FieldByName('Qtde').AsInteger;
  End
  Else raise Exception.Create('Lote não encontrado');
end;

procedure TFrmControleArmazenagem.CbLoteClick(Sender: TObject);
begin
  inherited;
  EdtLote.Text := CbLote.text;
end;

procedure TFrmControleArmazenagem.CbLoteExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.CbMotivoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var vOrigem, vDestino : String;
begin
  inherited;
  if (key = 13) then Begin
     if (CbMotivo.Itemindex < 0) then Begin
        ShowErro('Informe da segregação do produto/lote');
        CbMotivo.SetFocus;
     End
     Else Begin
        vOrigem  := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
        vDestino := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
        ConfirmarMovimentacao(vOrigem, vDestino);
     End;
  End;
end;

procedure TFrmControleArmazenagem.ChkPalletInteiroClick(Sender: TObject);
begin
  inherited;
  if ChkPalletInteiro.Checked = True then Begin

  End
  Else Begin

  End;
end;

procedure TFrmControleArmazenagem.ClearMovimentacao(Sender: TObject);
begin
  if Not (Sender = EdtEnderecoOrigem) then Begin
     If (PgcBase.ActivePage = TabPrincipal) and (PnlMovimentacao.Visible) then Begin
        If TipoMovimentacao = poRetidadaStage then
           EdtProduto.SetFocus
        Else Begin
           EdtEnderecoOrigem.Clear;
           EdtEnderecoOrigem.SetFocus;
        end;
     End;
  End;
  LblEnderecoOrigem.Caption := '';
  LblZonaOrigem.Caption     := '';
  LblDestino.Caption        := '';
  LblZonaDestino.Caption    := '';
  LblEstoqueOrigem.Caption  := '';
  LblVencimento.Caption     := '';
  LblProdutoOrigem.Caption  := '';
  LblProdutoPicking.Caption := '';
  EdtProduto.Clear;
  EdtLote.Clear;
  CbLote.Items.Clear;
  EdtQtdMovimentacao.Clear;
  EdtEnderecoDestino.Clear;
  LblConfirmaPallet.Caption := '';
  vConfirmaPallet           := '';
  EdtEstoqueLoteDisponivel.Clear;
  if (FdMemEstoqueOrigem.Active) then Begin
     FdMemEstoqueOrigem.EmptyDataSet;
     FdMemEstoqueOrigem.Close;
  End;
  if (FdMemEstoqueDestino.Active) then Begin
     FdMemEstoqueDestino.EmptyDataSet;
     FdMemEstoqueDestino.Close;
  End;
  ChkPalletInteiro.Checked := False;
  ChkPalletInteiro.Visible := False;
end;

procedure TFrmControleArmazenagem.ConfirmarMovimentacao(pOrigem, pDestino : String);
Var MsgConfirmacao    : String;
begin
  if Not ValidaMovimentacao() then Exit;
  MsgConfirmacao := 'Confirma Movimentação?';
  if (CbMotivo.Visible) and (CbMotivo.ItemIndex < 0) then Begin
     CbMotivo.SetFocus;
     raise Exception.Create('Informe o motivo da segregação do produto.');
  End;
  if (TipoMovimentacao = poSegregado) and (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId<>3) then
     MsgConfirmacao := 'Confirma Retidada do Segregado?'
  Else if (TipoMovimentacao <> poSegregado) and (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId=3) then
     MsgConfirmacao := 'Confirma Inserção no Segregado?';
  if (MessageBox(Handle, PWideChar('   Produto: '+LblProdutoOrigem.Caption+#13+#13+
                                   '      Lote: '+EdtLote.Text+'   Vencto: '+LblVencimento.Caption+#13+#13+
                                   '      Qtde: '+EdtQtdMovimentacao.Text+#13+#13+
                                   'De(Origem): '+pOrigem+#13+#13+
                                   '      Para: '+pDestino
                                   ) , pWideChar(MsgConfirmacao), MB_ICONQUESTION + MB_YESNO) = mrNo) then Begin
    if TipoMovimentacao = poAbastecimentoPicking then
       ClearMovimentacao(EdtEnderecoDestino)
    Else LimparMovimentacaoProduto;
    Exit;//Abort;
  End;
  EmptyKeyQueue;
  SalvarMovimentacao;
  MotivoSegregadoOnOff(False);
//  SalvarMovimentacao_AtualizaEstoque;
end;

procedure TFrmControleArmazenagem.DefinirLabelTipoMovimentacao;
Var LstEndereco : TObjectList<TEndereco>;
begin
  ClearMovimentacao(EdtEnderecoOrigem);
  PnlMovimentacao.Visible   := True;
  EdtEnderecoOrigem.Enabled := True;
  EdtEnderecoOrigem.Enabled := True;
  EdtEnderecoOrigem.Text := '';
  case TipoMovimentacao of
    poNenhum: Begin
       LblTipoMovimentacao.caption := '...';
       PnlMovimentacao.Visible := False;
       EdtEnderecoOrigem.SetFocus;
    End;
    poAbastecimentoPicking: Begin
      LblTipoMovimentacao.caption := 'Reabastecendo Picking';
      EdtEnderecoOrigem.EditLabel.Caption  := 'Picking Destino';
      EdtEnderecoDestino.EditLabel.Caption := 'Pulmão Origem';
      EdtEnderecoOrigem.SetFocus;
    end;
    poPulmao: Begin
      LblTipoMovimentacao.caption := 'Movimentando do Pulmão';
      EdtEnderecoOrigem.EditLabel.Caption := 'Local de Origem';
      EdtEnderecoDestino.EditLabel.Caption := 'Destino';
      EdtEnderecoOrigem.SetFocus;
    End;
    poRetidadaStage: Begin
      LblTipoMovimentacao.caption := 'Armazenando';
      EdtEnderecoOrigem.EditLabel.Caption  := 'Stage - Origem';
      EdtEnderecoDestino.EditLabel.Caption := 'Destino';
      //EdtEnderecoOrigem.Enabled := False;
      LstEndereco := ObjEnderecoCtrl.GetEndereco(0, 0, 1, 0, '', '', 'T', 2, 0, 1);
      if LstEndereco[0].EnderecoId <=0 then
         raise Exception.Create('Não existe endereço na Stage');
      if LstEndereco.Count = 1 then Begin
         ObjEnderecoCtrl.ObjEndereco := ObjEnderecoCtrl.GetEndereco(0, 0, 1, 0, '', '', 'T', 2, 0, 0)[0];
         if ObjEnderecoCtrl.ObjEndereco.Status = 0 then Begin
            ShowErro('Endereço('+EdtEnderecoOrigem.Text+') inativo! Não pode ser utilizado.');
            EdtEnderecoOrigem.Clear;
            exit;
         End;
         EdtEnderecoOrigem.Text      := LstEndereco[0].Descricao;
         EdtEnderecoOrigemExit(EdtEnderecoOrigem);
         //GetEstoque(0, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 1, 1, EdtEnderecoOrigem);
         if FdMemEstoqueOrigem.IsEmpty then
            raise Exception.Create('Não há estoque disponível na Stage para retirar.');
         EdtEnderecoOrigem.Enabled   := False;
         EdtProduto.SetFocus;
      End
      Else EdtEnderecoOrigem.SetFocus;
    End;
    poSegregado: Begin
      LblTipoMovimentacao.caption := 'Estoque Segregado';
      EdtEnderecoOrigem.EditLabel.Caption  := 'Origem';
      EdtEnderecoDestino.EditLabel.Caption := 'Destino';
      EdtEnderecoOrigem.SetFocus;
    End;
  end;
end;

procedure TFrmControleArmazenagem.EdtEnderecoDestinoChange(Sender: TObject);
begin
  inherited;
  LblDestino.Caption     := '';
  LblZonaDestino.Caption := '';
end;

procedure TFrmControleArmazenagem.EdtEnderecoDestinoEnter(Sender: TObject);
begin
  inherited;
  if EdtQtdMovimentacao.Value <= 0 then Begin
     ShowErro('Informe a quantidade!');
     EdtQtdMovimentacao.SetFocus;
  End;
  EnterFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtEnderecoDestinoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtEnderecoDestinoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var vOrigem, vDestino : String;
    vZonaId           : Integer;
    ObjEstoqueCtrl    : TEstoqueCtrl;
    JsonArrayRetorno  : TJsonArray;
    vErro, vEndereco  : String;
begin
  inherited;
  if (Key in [0..9, Ord('A')..Ord('Z'), ord('a')..Ord('z')]) and (EdtQtdMovimentacao.Text = '') then Begin
     if EdtProduto.Text = '' then ShowErro('Informe o Produto ser movimentado!')
     Else if EdtLote.Text='' then ShowErro('Informe o Lote a ser movimentado!')
     Else ShowErro('Informe a quantidade a ser movimentada!');
     Key := 0;
     if EdtProduto.Text = '' then EdtProduto.SetFocus
     Else if EdtLote.Text='' then EdtLote.SetFocus
     Else EdtQtdMovimentacao.SetFocus;
  End

  Else If (Key = 13) and (EdtEnderecoDestino.Text<>'') then Begin
     key := 0;
     if EdtQtdMovimentacao.Value <= 0 Then Begin
        ShowErro('Quantidade Inválida!');
        EdtQtdMovimentacao.SetFocus;
        Key := 0;
        Exit;
     End;
     if (TipoMovimentacao = poAbastecimentoPicking) and (EdtEnderecoDestino.Text <> vConfirmaPallet) Then Begin
        Key := 0;
        ShowErro('Porta Pallet inválido para esta operação');
        EdtEnderecoDestino.Clear;
        EdtEnderecoDestino.SetFocus;
        exit;
     End;
     vZonaId := 0;
     if (TipoMovimentacao = poSegregado) and (vZonaOrigem <> 3) then
        vZonaId := 3;
     //FdMemEstoqueOrigem.First;    //Retirado em 22/02 devido Movimentação Estoque permitir enviar para Picking Lote com vencimento maior
     if (TipoMovimentacao = poAbastecimentoPicking) and (Not FdMemEstoqueOrigem.Locate('Endereco', EdtEnderecoDestino.Text, [])) then
        raise Exception.Create('Endereço inválido! Não há estoque disponível para movimentação.');
     if EdtEnderecoDestino.Text = EdtEnderecoOrigem.Text then Begin
        EdtEnderecoDestino.Clear;
        ExitFocus(Sender);
        raise Exception.Create('Não é permitido movimentar para o mesmo endereço.');
     End;
     ObjEnderecoDestinoCtrl.ObjEndereco := ObjEnderecoDestinoCtrl.GetEndereco(0, 0, vZonaId, 0,
                                           EdtEnderecoDestino.Text, EdtEnderecoDestino.Text, 'T', 99, 0, 1)[0];
     vEndereco := EdtEnderecoDestino.Text;
     if ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId > 0 then With ObjEnderecoDestinoCtrl.ObjEndereco do Begin
        if Status = 0 then Begin
           EdtEnderecoDestino.Clear;
           EdtEnderecoDestino.SetFocus;
           ExitFocus(Sender);
           raise Exception.Create('Endereço('+vEndereco+') inativo! Não pode ser utilizado.');
        End;
        if Bloqueado = 1 then Begin
           EdtEnderecoDestino.Clear;
           EdtEnderecoDestino.SetFocus;
           ExitFocus(Sender);
           raise Exception.Create('Endereço('+vEndereco+') bloqueado para uso.');
        End;
        if BloqueioInventario = 1 then Begin
           EdtEnderecoOrigem.Clear;
           EdtEnderecoDestino.SetFocus;
           raise Exception.Create('Endereço('+vEndereco+') bloqueado para inventariar.');
        End;
        LblDestino.Caption := EnderecoMask(Descricao, EnderecoEstrutura.Mascara, True)+
                                     '   Rua: ' + EnderecoRua.Descricao + ' Lado: ' + EnderecoRua.Lado;
        if EnderecamentoZona.ZonaId = 1 then Begin
           LblZonaDestino.Caption := 'Zona: Stage(Área de Espera)';
        End
        Else if EnderecamentoZona.ZonaId = 2 then Begin
           LblZonaDestino.Caption := 'Zona: Crossdocking';
        End
        Else if EnderecamentoZona.ZonaId = 3 then Begin
           LblZonaDestino.Caption := 'Zona: Segregados';
        End
        Else Begin
           LblZonaDestino.Caption := 'Zona: ' + EnderecamentoZona.Descricao;
        End;
     End;

     If (TipoMovimentacao = poSegregado) and (ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId<>3) and
        (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId<>3) then Begin
        raise Exception.Create('Operação não permitida... Defina:'+#13+
                               'Origem Segregado - Retirar ou'+#13+
                               'Destino Segregado - Incluir.');
     End;
     if (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) Then Begin
        if ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId <> ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId then Begin
           EdtEnderecoDestino.Clear;
           EdtEnderecoDestino.SetFocus;
           ShowErro('Operação não permitida. Picking Destino pertence a outro produto');
           Exit;
        End;
        If (Not VerificarLoteFIFOparaPicking) then
           Exit;
     End;
     //Não permitir movimentação para Zona Diferente da pre-definida no Cadastro do Produto
     if (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 1) and  (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId > 3) and
        ((ObjProdutoCtrl.ObjProduto.EnderecamentoZona.ZonaId<>0) and
          (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId <> ObjProdutoCtrl.ObjProduto.EnderecamentoZona.ZonaId) ) then Begin
        ShowMSG('Não é permitido a movimentação para essa Zona/Setor.');
        EdtEnderecoDestino.Clear;
        EdtEnderecoDestino.SetFocus;
        Exit;
     End;
    // Pegar estoque disponível no Endereeço de origem
     if TipoMovimentacao <> poAbastecimentoPicking then Begin
        If (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) then
           If (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) then Begin
              EdtEnderecoDestino.Clear;
              raise Exception.Create('Não é permitido movimentar de um Picking para outro Picking.');
           End
           Else If (ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId = 0) then Begin
              EdtEnderecoDestino.Clear;
              raise Exception.Create('Picking inválido! Produto não está vinculado a um picking.')
           End
           else If (ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId <> ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId) then Begin
              EdtEnderecoDestino.Clear;
              raise Exception.Create('Picking não pertence ao produto da movimentação.');
           End;
        GetEstoque(0, 0, ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId, 0, 2, 2, EdtEnderecoDestino);
        //FdMemEstoqueDestino.First;  //Retirado em 22/02 devido Movimentação Estoque permitir enviar para Picking Lote com vencimento maior
        if (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 0) and
           (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId > 3) then Begin
           ObjEstoqueCtrl   := TEstoqueCtrl.Create;
           JsonArrayRetorno := ObjEstoqueCtrl.ValidarMovimentacaoPallet(ObjProdutoCtrl.ObjProduto.IdProduto,
                                                                        ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId,
                                                                        CbLote.Items.Strings[CbLote.ItemIndex]);
           if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
              EdtEnderecoDestino.SetFocus;
              ShowErro('Atenção: '+vErro+'('+EdtEnderecoDestino.Text+')', 'alarme');
              EdtEnderecoDestino.Clear;
              JsonArrayRetorno := Nil;
              ObjEstoqueCtrl.Free;
              Exit;
           End;
           JsonArrayRetorno := Nil;
           ObjEstoqueCtrl.Free;
        End;
        vOrigem  := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
        vDestino := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
     End
     Else begin //Inversão do Endereco Origem e Destino devido o fato do estoque ser destinado ao picking primeiro endereço digitado.
        vOrigem  := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
        vDestino := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
     end;
     if (TipoMovimentacao = poSegregado) Then Begin
        //(ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 3) then Begin
        MotivoSegregadoOnOff(True);
     End
     Else Begin
        MotivoSegregadoOnOff(False);
        ConfirmarMovimentacao(vOrigem, vDestino);
     End;
  End;
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemChange(Sender: TObject);
begin
  inherited;
  ClearMovimentacao(Sender);
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemExit(Sender: TObject);
Var vZonaId : Integer;
    VEndereco : String;
begin
  inherited;
  if EdtEnderecoOrigem.Text = '' then Exit;
  vEndereco := EdtEnderecoOrigem.Text;
  If TipoMovimentacao = poRetidadaStage then vZonaId := 1
  //Else If TipoMovimentacao = poSegregado then vZonaId := 3
  Else vZonaId := 0;
  ObjEnderecoCtrl.ObjEndereco := ObjEnderecoCtrl.GetEndereco(0, 0, vZonaId, 0, EdtEnderecoOrigem.Text, EdtEnderecoOrigem.Text, 'T', 2, 0, 1)[0];
  if ObjEnderecoCtrl.ObjEndereco.EnderecoId > 0 then With ObjEnderecoCtrl.ObjEndereco do Begin
     if Status = 0 then Begin
        raise Exception.Create('Endereço('+vEndereco+') inativo! Não pode ser utilizado.');
     End;
     if Bloqueado = 1 then Begin
        raise Exception.Create('Endereço('+vEndereco+') bloqueado para uso!');
     End;
     if BloqueioInventario = 1 then Begin
        EdtEnderecoOrigem.Clear;
        raise Exception.Create('Endereço('+vEndereco+') bloqueado para inventariar.');
     End;
     LblEnderecoOrigem.Caption := EnderecoMask(Descricao, EnderecoEstrutura.Mascara, True)+
                                  '   Rua: ' + EnderecoRua.Descricao + ' Lado: ' + EnderecoRua.Lado;
     vZonaOrigem := ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId;
     if ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 1 then Begin
        LblZonaOrigem.Caption := 'Zona: Stage(Área de Espera)';
        PnlTipoMovimentacao.Caption := 'Origem: Stage(Área de Espera)';
     End
     Else if ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 2 then Begin
        LblZonaOrigem.Caption := 'Zona: Crossdocking';
        PnlTipoMovimentacao.Caption := 'Origem: Crossdocking';
     End
     Else if ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 3 then Begin
        LblZonaOrigem.Caption := 'Zona: Segregados';
        PnlTipoMovimentacao.Caption := 'Origem: Segregados';
     End
     Else Begin
        LblZonaOrigem.Caption := 'Zona: ' + EnderecamentoZona.Descricao;
        PnlTipoMovimentacao.Caption := 'Origem: ' + EnderecoEstrutura.Descricao;
     End;
     if (TipoMovimentacao = poPulmao) and (ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId = 1) then begin
        ShowMessage('Para retirar da Stage utlize a opção '+#34+'ARMAZENAR!'+#34+'.');
        EdtEnderecoOrigem.Clear;
        EdtEnderecoOrigem.SetFocus;
        Exit;
     end
     Else if (TipoMovimentacao = poPulmao) and (ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId = 3) then begin
        ShowMessage('Para retirar do Segregado utlize a opção '+#34+'SEGREGADO!'+#34+'.');
        EdtEnderecoOrigem.Clear;
        EdtEnderecoOrigem.SetFocus;
        Exit;
     end;
  End;
  EdtProduto.Enabled := True;
  if (TipoMovimentacao = poAbastecimentoPicking) or (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2) Then Begin
     If (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId <> 2) then Begin
        EdtEnderecoOrigem.Clear;
        EdtEnderecoOrigem.SetFocus;
        Raise Exception.Create('Endereço('+vEndereco+') inválido! Informe um endereço de Picking!');
     End;
     if ObjEnderecoCtrl.ObjEndereco.ProdutoId = 0 then Begin
        EdtEnderecoOrigem.Clear;
        EdtEnderecoOrigem.SetFocus;
        raise Exception.Create('Não há produto vinculado a este endereço'+vEndereco+').');
     End;
     //GetEstoque(0, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 2, 0, EdtEnderecoOrigem);
     EdtProduto.Text    := ObjEnderecoCtrl.ObjEndereco.CodProduto.ToString;
     EdtProdutoExit(EdtProduto);
     EdtProduto.Enabled := False;
     if CbLote.Enabled then
        EdtLote.SetFocus;
  End
  Else
     GetEstoque(0, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 2, 2, EdtEnderecoOrigem);
  if (TipoMovimentacao = poAbastecimentoPicking) then
     EdtQtdMovimentacao.SetFocus
  Else Begin
     if (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2) then
        EdtQtdMovimentacao.SetFocus
     Else Begin
        EdtProduto.SetFocus;
        if DebugHook <> 0 then //Retirar para producao
           ChkPalletInteiro.Visible := ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 1;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
     SelectNext(ActiveControl, True, True);
end;

procedure TFrmControleArmazenagem.EdtLoteExit(Sender: TObject);
begin
  inherited;
  if (EdtLote.Text<>'') then Begin
     CbLote.ItemIndex := CbLote.Items.IndexOf(EdtLote.Text);
     if CbLote.ItemIndex < 0 then Begin
        EdtLote.Clear;
        ShowErro('Lote não arquivado ou indisponível para movimentação.');
        EdtLote.SetFocus;
     End
     Else CbLoteChange(CbLote);
  End;
  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtLoteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key in [0..9, Ord('A')..Ord('Z'), Ord('a')..Ord('z')]) and (EdtProduto.Text = '') then Begin
     ShowErro('Informe o Produto para ser movimentado!');
     Key := 0;
     EdtProduto.SetFocus;
  End
  Else If key in [13, 9] then SelectNext(ActiveControl,True,True);
//  inherited;
end;

procedure TFrmControleArmazenagem.EdtProdutoChange(Sender: TObject);
begin
  inherited;
  LblDestino.Caption        := '';
  LblZonaDestino.Caption    := '';
  if TipoMovimentacao <> poAbastecimentoPicking then
     LblEstoqueOrigem.Caption  := '';
  LblVencimento.Caption     := '';
  LblProdutoOrigem.Caption  := '';
  LblProdutoPicking.Caption := '';
  CbLote.Items.Clear;
  EdtLote.Clear;
  EdtQtdMovimentacao.Clear;
  EdtEnderecoDestino.Clear;
  EdtEstoqueLoteDisponivel.Clear;
end;

procedure TFrmControleArmazenagem.EdtProdutoExit(Sender: TObject);
Var vCodProduto : Integer;
    vCodDig     : String;
begin
  inherited;
  if EdtProduto.Text = '' then Exit;
  if (StrToInt64Def(EdtProduto.Text, 0)) = 0 then Begin
     EdtProduto.Clear;
     EdtProduto.SetFocus;
     raise Exception.Create('Código inválido!');
  End;
  vCodDig := edtProduto.Text;
  if EdtEnderecoOrigem.Text = '' then Begin
     EdtProduto.Clear;
     EdtProduto.SetFocus;
     raise Exception.Create('Informe o Endereço de Origem!');
  End;
  vCodProduto := tProdutoCtrl.GetCodProdEan(EdtProduto.Text);
  if vCodProduto <> 0 then Begin
     ObjProdutoCtrl.FindProduto(vCodProduto.ToString, '0', '', 1);
     if ObjProdutoCtrl.ObjProduto.Status = 0 then
      raise Exception.Create('Produto inativo, não pode sofrer movimentação!');
     if (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) and
        (ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId <> ObjEnderecoCtrl.ObjEndereco.EnderecoId) then Begin
        EdtProduto.Clear;
        raise Exception.Create('Produto('+vCodDig+') não pertence ao Picking de origem para movimentação');
     End;
     LblProdutoOrigem.Caption  := ObjProdutoCtrl.ObjProduto.Descricao;
     LblProdutoPicking.Caption := EnderecoMask(ObjProdutoCtrl.ObjProduto.Endereco.Descricao, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoEstrutura.Mascara, True)+ //ObjProdutoCtrl.ObjProduto.Endereco.Descricao +
                                  '     Unid.Prim: ' + ObjProdutoCtrl.ObjProduto.Unid.Descricao + '(' +
                                  ObjProdutoCtrl.ObjProduto.QtdUnid.ToString() + ')' + '    Uni.Sec: ' +
                                  ObjProdutoCtrl.ObjProduto.UnidSecundaria.Descricao + ' C/ ' +
                                  ObjProdutoCtrl.ObjProduto.FatorConversao.ToString();
     if TipoMovimentacao = poAbastecimentoPicking then
        GetEstoque(vCodProduto, 0, 0, 0, 1, 1, EdtEnderecoDestino)
     Else GetEstoque(vCodProduto, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 2, 2, EdtEnderecoOrigem);
  End
  Else Begin
     EdtProduto.Clear;
     Edtproduto.SetFocus;
     raise Exception.Create('Produto não encontrado. Verifique o Código/Ean('+vCodDig+').');
  End;
  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtQtdMovimentacaoExit(Sender: TObject);
begin
  inherited;
  if EdtQtdMovimentacao.Text <> '' then Begin
     if EdtQtdMovimentacao.Value < 0 then
        raise Exception.Create('Quantidade inválida para movimentação.')
     Else if EdtQtdMovimentacao.Value > EdtEstoqueLoteDisponivel.Value then
        raise Exception.Create('Quantidade inválida, maior que estoque disponível.')
     Else If EdtQtdMovimentacao.Value > 0 then Begin
        if Not EdtEnderecoDestino.Enabled then
           EdtEnderecoDestinoExit(EdtEnderecoDestino);
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtQtdMovimentacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If key in [#13, #9] then Begin
     SelectNext(ActiveControl,True,True);
     Exit;
  End;
  SoNumeros(Key);
  if (Key in ['0'..'9']) and (EdtLote.Text = '') then Begin
     ShowErro('Informe o Lote para ser movimentado!');
     Key := #0;
     if EdtProduto.Text='' then EdtProduto.SetFocus
     Else EdtLote.SetFocus;
  End; //EdtQtdMovimentacaoExit(EdtQtdMovimentacao);
end;

procedure TFrmControleArmazenagem.LimparMovimentacaoProduto;
begin
  EdtLote.Clear;
  CbLote.ItemIndex := -1;
  EdtQtdMovimentacao.Value := 0;
  EdtEstoqueLoteDisponivel.Value := 0;
  EdtEnderecoDestino.Clear;
  EdtLote.SetFocus;
end;

procedure TFrmControleArmazenagem.LstCadastroGetEditorProp(Sender: TObject;
  ACol, ARow: Integer; AEditLink: TEditLink);
begin
 inherited;
 if not Assigned(AEditLink) then
    Exit;
end;

procedure TFrmControleArmazenagem.MotivoSegregadoOnOff(pOnOff: Boolean);
begin
  CbMotivo.Visible           := pOnOff;
  BtnSalvarSegregado.Visible := pOnOff;
  LblMotivoSegregado.Visible := pOnOff;
  If pOnOff Then CbMotivo.SetFocus
  Else CbMotivo.ItemIndex := -1;
end;

procedure TFrmControleArmazenagem.PesquisarClickInLstCadastro(ACol,
  ARow: Integer);
begin
 inherited;
 // Montar a Pesquisa
end;

function TFrmControleArmazenagem.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if pConteudo = '0' then raise Exception.Create('conteúdo inválido para pesquisar!');
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if (CbCampoPesq.ItemIndex = 0) and (StrToIntDef(EdtConteudoPesq.Text, 0)>0) then //0 Id 1-Criar no server consulta por Cod.ERP
        GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), StrToIntDef(EdtConteudoPesq.Text, 0), '', '', '', 1)
     Else if CbCampoPesq.ItemIndex = 1 then
        if Length(EdtConteudoPesq.Text) < 3 then
          raise Exception.Create('você deve digitar pelo menos 3 character!')
        Else GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), 0, EdtConteudoPesq.Text, '', '', 1)
     Else if CbCampoPesq.ItemIndex = 2 then
        if Length(EdtConteudoPesq.Text) < 3 then
          raise Exception.Create('você deve digitar pelo menos 3 character!')
        Else GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), 0, '', EdtConteudoPesq.Text, '', 1)
     Else if CbCampoPesq.ItemIndex = 3 then
        if Length(EdtConteudoPesq.Text) < 3 then
          raise Exception.Create('você deve digitar pelo menos 3 character!')
        Else GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), 0, '', '', EdtConteudoPesq.Text, 1);
     EdtConteudoPesq.Clear;
  End;
  if Result = False then
     raise Exception.Create('Não econtrei dados da pesquisa!');
{  GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), 0, '', '', '');
 Cód.Produto
 Terminal
 Origem
 Destino}
end;

procedure TFrmControleArmazenagem.SalvarMovimentacao;
Var jsonEstoque,
    jsonKardex,
    jsonEstoqueKardex : tJsonObject;
    JsonArrayEstoque,
    JsonArrayKardex   : tJsonArray;
    ObjEstoqueCtrl    : TEstoqueCtrl;
    vMotivoSegregado  : Integer;
    JsonObjectRetorno : TJsonObject;
    vErro : String;
begin
  keybd_event(VK_F2, 0, 0, 0);
  ObjEstoqueCtrl   := TEstoqueCtrl.Create;
  JsonEstoque      := tJsonObject.Create;
  JsonArrayEstoque := tJsonArray.Create;
  JsonArrayKardex  := tJsonArray.Create;

  With jsonEstoque do Begin //Origem
    AddPair('loteid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger));
    AddPair('enderecoid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('EnderecoId').AsInteger));
    AddPair('estoquetipoid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('EstoqueTipoId').AsInteger));
    Addpair('qtde', TJSONNumber.Create(EdtQtdMovimentacao.Value*-1));
    AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
    AddPair('nomeestacao', NomeDoComputador);
    AddPair('validarestoqueorigem', TJsonNumber.Create(1));
    if (TipoMovimentacao = poSegregado) and (FdMemEstoqueOrigem.FieldByName('ZonaId').AsInteger=3) then Begin
       vMotivoSegregado := 0;
       if FDMemSegregadoCausa.Locate('Descricao', CbMotivo.Items[CbMotivo.ItemIndex], []) then
          vMotivoSegregado := FDMemSegregadoCausa.FieldByName('segregadocausaid').AsInteger;
       jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(vMotivoSegregado));
       jsonEstoque.AddPair('operacaosegregado', '-');
    End
    Else Begin
       jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(0));
       jsonEstoque.AddPair('operacaosegregado', '');
    End;
  End;
  JsonArrayEstoque.AddElement(jsonEstoque);

  JsonEstoque := tJsonObject.Create;
  With jsonEstoque do Begin //Destino
    AddPair('loteid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger));
    if TipoMovimentacao = poAbastecimentoPicking then Begin
       AddPair('enderecoid', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecoId));
       AddPair('estoquetipoid', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId));
    End
    Else Begin
       AddPair('enderecoid', TJSONNumber.Create(ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId));
       AddPair('estoquetipoid', TJSONNumber.Create(ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId));
    End;
    Addpair('qtde', TJSONNumber.Create(EdtQtdMovimentacao.Value));
    AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
    AddPair('nomeestacao', NomeDoComputador);
    if (TipoMovimentacao = poSegregado) and
       (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId=3) then Begin
       vMotivoSegregado := 0;
       if FDMemSegregadoCausa.Locate('Descricao', CbMotivo.Items[CbMotivo.ItemIndex], []) then
          vMotivoSegregado := FDMemSegregadoCausa.FieldByName('segregadocausaid').AsInteger;
       jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(vMotivoSegregado));
       jsonEstoque.AddPair('operacaosegregado', '+');
    End
    Else Begin
       jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(0));
       jsonEstoque.AddPair('operacaosegregado', '');
    End;
  End;
  JsonArrayEstoque.AddElement(jsonEstoque);

  JsonKardex := tJsonObject.Create;
  With jsonKardex do Begin
    AddPair('operacaotipoid', TJSONNumber.Create(8));
    AddPair('loteid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger));
    if TipoMovimentacao = poAbastecimentoPicking then
       AddPair('enderecoid', TJSONNumber.Create(ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId))
    Else
       AddPair('enderecoid', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecoId));
    AddPair('estoquetipoid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('EstoqueTipoId').AsInteger));
    if TipoMovimentacao = poAbastecimentoPicking then
       AddPair('estoquetipoiddestino', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId))
    Else
       AddPair('estoquetipoiddestino', TJSONNumber.Create(ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId));
    Addpair('quantidade', TJSONNumber.Create(EdtQtdMovimentacao.Value));
    if TipoMovimentacao = poAbastecimentoPicking then
       AddPair('enderecoiddestino', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecoId))
    Else
       AddPair('enderecoiddestino', TJSONNumber.Create(ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId));
    AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
    if TipoMovimentacao = poAbastecimentoPicking then Begin
       AddPair('observacaoorigem',  'Movimentação interna '+ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId.ToString+'-->' );
       AddPair('observacaodestino', 'Movimentação interna -->'+ObjEnderecoCtrl.ObjEndereco.EnderecoId.ToString );
    End
    Else Begin
       AddPair('observacaoorigem',  'Movimentação interna '+ObjEnderecoCtrl.ObjEndereco.EnderecoId.ToString+'-->' );
       AddPair('observacaodestino', 'Movimentação interna -->'+ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId.ToString );
    End;
    AddPair('nomeestacao', NomeDoComputador);
  End;
  JsonArrayKardex.AddElement(jsonKardex);
  JsonEstoqueKardex := tJsonObject.create;
  JsonEstoqueKardex.AddPair('estoque', jsonArrayEstoque);
  JsonEstoqueKardex.AddPair('kardex', jsonArraykardex);
  JsonObjectRetorno := ObjEstoqueCtrl.Salvar(jsonEstoqueKardex);
  FreeAndNil(JsonEstoque);
  FreeAndNil(JsonKardex);
  FreeAndNil(ObjEstoqueCtrl);
  ClearMovimentacao(EdtEnderecoDestino);
  if JsonObjectRetorno.TryGetValue('Erro', vErro ) then  Begin
     EdtEnderecoOrigem.SetFocus;
     ShowErro('Erro: '+vErro);
  End
  Else
    ShowOk('Movimentação realizada!');
  JsonObjectRetorno := Nil;
end;

procedure TFrmControleArmazenagem.BtnMovimentaPulmaoClick(Sender: TObject);
begin
  inherited;
  TipoMovimentacao := poPulmao;
  DefinirLabelTipoMovimentacao;
end;

procedure TFrmControleArmazenagem.TabListagemShow(Sender: TObject);
begin
  inherited;
  GetListaMovimentacao(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId, Date(), Date(), 0, '', '', '', 1);
  AdvGridLookupBar1.Column := 1;
end;

Function TFrmControleArmazenagem.ValidaMovimentacao : Boolean;
begin
  Result := True;
  if EdtQtdMovimentacao.Value <= 0 then Begin
     ShowErro('Quantidade inválida');
     EdtQtdMovimentacao.SetFocus;
     Result := False;
  End
end;

function TFrmControleArmazenagem.VerificarLoteFIFOparaPicking: Boolean;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    xReturn          : Integer;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  Result := True;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueJson(ObjProdutoCtrl.ObjProduto.IdProduto, 0, 0, 0, 1, 1, 'N', 'N', 0);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     for xReturn := 0 to Pred(JsonArrayRetorno.Count) do Begin
       if StrToDate(JsonArrayRetorno.Items[xReturn].GetValue<String>('vencimento')) < FdMemEstoqueOrigem.FieldByName('Vencimento').AsDateTime then Begin
          If TipoMovimentacao = poRetidadaStage then
          Else Begin
             LimparMovimentacaoProduto;
             ShowErro('Movimentação inválida... Picking exige movimentar o lote com menor vencimento. End: '+JsonArrayRetorno.Items[xReturn].GetValue<String>('endereco')+' Lt: '+JsonArrayRetorno.Items[xReturn].GetValue<String>('descrlote'));
             Result := False;
             Break;
          End;
       End;
     End;
  End;
end;

end.
