unit uFrmRelListaInventario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, System.JSON, REST.Json, Rest.Types, DataSet.Serialize,
  JvToolEdit, ProdutoCtrl, Vcl.WinXCtrls, Math;

type
  TInventarioTipo = (poUndefined, poGeografico,  poPrioritario, poCiclíco);

  TFrmRelListaInventario = class(TFrmReportBase)
    Label3: TLabel;
    EdtDataCriacao: TJvDateEdit;
    RbInventarioTipo: TRadioGroup;
    ChkSomentePendente: TCheckBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    Label2: TLabel;
    EdtDataCriacaoFinal: TJvDateEdit;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    FDMemEndereco: TFDMemTable;
    FDMemEnderecoAtivo: TIntegerField;
    FDMemEnderecoEnderecoId: TIntegerField;
    FDMemEnderecoDescricao: TStringField;
    FDMemEnderecoEstrutura: TStringField;
    FDMemEnderecoMascara: TStringField;
    FDMemEnderecoZona: TStringField;
    FDMemEnderecoStatus: TStringField;
    FDMemProdutoDisponivel: TFDMemTable;
    FDMemProdutoDisponivelProdutoId: TIntegerField;
    FDMemProdutoDisponivelCodigoERP: TIntegerField;
    FDMemProdutoDisponivelDescricao: TStringField;
    FDMemProdutoDisponivelPicking: TStringField;
    FDMemProdutoDisponivelmascara: TStringField;
    FDMemProdutoDisponivelZona: TStringField;
    FDMemProdutoDisponivelSngpc: TIntegerField;
    FDMemProdutoDisponivelStatus: TStringField;
    FdMemLoteInventariado: TFDMemTable;
    FdMemLoteInventariadoItemId: TIntegerField;
    FdMemLoteInventariadoInventarioId: TIntegerField;
    FdMemLoteInventariadoEnderecoId: TIntegerField;
    FdMemLoteInventariadoEndereco: TStringField;
    FdMemLoteInventariadoProdutoId: TIntegerField;
    FdMemLoteInventariadoCodProduto: TIntegerField;
    FdMemLoteInventariadoDescricao: TStringField;
    FdMemLoteInventariadoLoteId: TIntegerField;
    FdMemLoteInventariadoDescrLote: TStringField;
    FdMemLoteInventariadoFabricacao: TDateField;
    FdMemLoteInventariadoVencimento: TDateField;
    FdMemLoteInventariadoEstoqueInicial: TIntegerField;
    FdMemLoteInventariadoContagemId: TIntegerField;
    FdMemLoteInventariadoQuantidade: TIntegerField;
    FdMemLoteInventariadoQtdContagem: TIntegerField;
    FdMemLoteInventariadoStatus: TStringField;
    FdMemLoteInventariadoAutomatico: TIntegerField;
    FdMemAjusteRelatorio: TFDMemTable;
    PgcListaInventario: TcxPageControl;
    TabListaInventario: TcxTabSheet;
    LstListaInventario: TAdvStringGrid;
    TabAcompanhamentoContagem: TcxTabSheet;
    PnlEnderecoContagem: TPanel;
    PnlEnderecoContagemTit: TPanel;
    PnlPnlTitEndContDivergente: TPanel;
    PnlPnlTitEndContEmContagem: TPanel;
    PnlPnlTitEndContConcluido: TPanel;
    EdtPesqEndereco: TSearchBox;
    LstEnderecoContagem: TAdvStringGrid;
    PnlContagemAjuste: TPanel;
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
    PnlResumoContagem: TPanel;
    Label21: TLabel;
    LstContagemLote: TAdvStringGrid;
    TabAjuste: TcxTabSheet;
    LstAjusteRelatorio: TAdvStringGrid;
    Label5: TLabel;
    FDMemRelatorioLista: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField3: TIntegerField;
    StringField3: TStringField;
    IntegerField4: TIntegerField;
    StringField4: TStringField;
    DateField1: TDateField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField5: TStringField;
    StringField6: TStringField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    DateTimeField5: TDateTimeField;
    StringField7: TStringField;
    DateTimeField6: TDateTimeField;
    DateField2: TDateField;
    TimeField1: TTimeField;
    StringField8: TStringField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    ChkExportarApuracaoGeral: TCheckBox;
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtProcessoIdChange(Sender: TObject);
    procedure RbInventarioTipoClick(Sender: TObject);
    procedure EdtDataCriacaoChange(Sender: TObject);
    procedure ChkSomentePendenteClick(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoChange(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtProcessoIdKeyPress(Sender: TObject; var Key: Char);
    procedure TabAcompanhamentoContagemShow(Sender: TObject);
    procedure EdtPesqEnderecoInvokeSearch(Sender: TObject);
    procedure LstEnderecoContagemClick(Sender: TObject);
    procedure LstListaInventarioDblClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure LstListaInventarioClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstDetalheAjusteClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstDetalheAjusteClick(Sender: TObject);
    procedure LstEnderecoContagemClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure TabListaInventarioShow(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure PgcListaInventarioChange(Sender: TObject);
  private
    { Private declarations }
    vProdutoId     : Integer;
    InventarioTipo : TInventarioTipo;
    Procedure MontaListaInventario;
    Procedure ClearDetalheAjuste;
    Procedure MontaListaEnderecoContado;
    Procedure MontaListaProdutoContado;
    Procedure GetInventarioEndereco(pInventarioId : Integer);
    Procedure GetInventarioProduto(pInventarioId : Integer);
    Procedure BuscarInventarioInicial(pInventarioId : Integer);
    Procedure MontaListaLoteInventariado;
    Procedure ShowLoteContado;
    Procedure GetContagemLote(pItem : Integer);
    Procedure GetAjusteRelatorio(pInventarioId : Integer);
    Procedure MontarAjusteRelatorio;
    Procedure PovoarFdmMemRelatorioLista;
    Procedure ExportarApuração;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelListaInventario: TFrmRelListaInventario;

implementation

{$R *.dfm}

{ TFrmRelListaInventario }

Uses uFuncoes, uFrmeXactWMS, InventarioCtrl, Views.Pequisa.Processos, Views.Pequisa.Produtos, ProcessoCtrl;

procedure TFrmRelListaInventario.BtnExportarStandClick(Sender: TObject);
begin
  if PgcListaInventario.ActivePageIndex = 0 then
     inherited
  Else if PgcListaInventario.ActivePageIndex = 2 then
     ExportarApuração;
end;

procedure TFrmRelListaInventario.BtnPesqProcessoClick(Sender: TObject);
begin
  inherited;
  if ((Sender=BtnPesqProcesso) and (EdtProcessoId.ReadOnly)) or
     ((Sender=BtnPesqProcesso) and (EdtProcessoId.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaProcessos := TFrmPesquisaProcessos.Create(Application);
  try
    if (FrmPesquisaProcessos.ShowModal = mrOk) then Begin
       EdtProcessoId.Text := FrmPesquisaProcessos.Tag.ToString;
       EdtProcessoIdExit(EdtProcessoId);
    End;
  finally
    FreeAndNil(FrmPesquisaProcessos);
  end;
end;

procedure TFrmRelListaInventario.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodproduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelListaInventario.BuscarInventarioInicial(pInventarioId : Integer);
Var JsonArrayLoteInventariado : TJsonArray;
    vErro : String;
    xLote : Integer;
    ObjInventarioCtrl : TInventarioCtrl;
begin
   ObjInventarioCtrl := TInventarioCtrl.Create;
   if InventarioTipo = poGeografico then
      JsonArrayLoteInventariado := ObjInventarioCtrl.GetLoteInventariado(pInventarioId, FdmemEndereco.FieldByName('EnderecoId').AsInteger, 0, 0, 0)
   Else
      JsonArrayLoteInventariado := ObjInventarioCtrl.GetLoteInventariado(pInventarioId, 0, FDMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger, 1, 0);
  if Not JsonArrayLoteInventariado.Items[0].TryGetValue('Erro', vErro) then Begin
     If FdMemLoteInventariado.Active then
        FdMemLoteInventariado.EmptyDataSet;
     FdMemLoteInventariado.Close;
     FdMemLoteInventariado.LoadFromJSON(JsonArrayLoteInventariado, False);
     MontaListaLoteInventariado;
  End;
  JsonArrayLoteInventariado := Nil;
  FreeAndNil(ObjInventarioCtrl);
end;

procedure TFrmRelListaInventario.ChkSomentePendenteClick(Sender: TObject);
begin
  inherited;
  Limpar;
  LstListaInventario.RowCount := 1;
  LstListaInventario.clearRect(0, 1, LstListaInventario.ColCount-1, LstListaInventario.RowCount-1);
  PgcListaInventario.ActivePage := TabListaInventario;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

procedure TFrmRelListaInventario.ClearDetalheAjuste;
begin
  EdtEnderecoContagem.Clear;
  EdtLote.Clear;
  CbEnderecoStatus.ItemIndex := -1;
  EdtEstoqueInicial.Clear;
  EdtContagem.Clear;
  EdtAjuste.Clear;
  EdtSaldo.Clear;
end;

procedure TFrmRelListaInventario.EdtCodProdutoChange(Sender: TObject);
begin
  inherited;
  Limpar;
  vProdutoId := 0;
  LblProduto.Caption := '...';
  LstListaInventario.RowCount := 1;
  LstListaInventario.clearRect(0, 1, LstListaInventario.ColCount-1, LstListaInventario.RowCount-1);
  PgcListaInventario.ActivePage := TabListaInventario;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

procedure TFrmRelListaInventario.EdtCodProdutoExit(Sender: TObject);
Var JsonProduto : TJsonObject;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if StrToInt64Def(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Código do produto('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(TEdit(Sender).Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+TEdit(Sender).Text+') não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else
     LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  JsonProduto := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelListaInventario.EdtDataCriacaoChange(Sender: TObject);
begin
  inherited;
  Limpar;
  LstListaInventario.RowCount := 1;
  LstListaInventario.clearRect(0, 1, LstListaInventario.ColCount-1, LstListaInventario.RowCount-1);
  PgcListaInventario.ActivePage := TabListaInventario;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

procedure TFrmRelListaInventario.EdtPesqEnderecoInvokeSearch(Sender: TObject);
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

procedure TFrmRelListaInventario.EdtProcessoIdChange(Sender: TObject);
begin
  inherited;
  Limpar;
  LblProcesso.Caption := '...';
  LstListaInventario.RowCount := 1;
  LstListaInventario.clearRect(0, 1, LstListaInventario.ColCount-1, LstListaInventario.RowCount-1);
  PgcListaInventario.ActivePage := TabListaInventario;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

procedure TFrmRelListaInventario.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
Begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  LblProcesso.Caption := '';
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Processo('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjProcessoCtrl  := TProcessoCtrl.Create;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(TEdit(Sender).text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo não('+TEdit(Sender).Text+') encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  JsonArrayRetorno := Nil;
  ObjProcessoCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelListaInventario.EdtProcessoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelListaInventario.ExportarApuração;
Var ObjInventarioCtrl : TInventarioCtrl;
    JsonArrayAjuste   : TJsonArray;
    vErro             : String;
    pDataCriacao        : TDateTime;
    pDataCriacaoFinal   : TDateTime;
    pTipoInventario     : Integer;
    pPendente           : Integer;
begin
  If FdMemAjusteRelatorio.Active then
     FdMemAjusteRelatorio.EmptyDataSet;
  FdMemAjusteRelatorio.Close;
  if EdtDataCriacao.Text <>'  /  /    ' then
     pDataCriacao := StrToDate(EdtDataCriacao.Text)
  Else
     pDataCriacao := 0;
  if EdtDataCriacaoFinal.Text <>'  /  /    ' then
     pDataCriacaoFinal := StrToDate(EdtDataCriacaoFinal.Text)
  Else
     pDataCriacaoFinal := 0;
  case RbInventarioTipo.ItemIndex of
    0: pTipoInventario := 1;
    1: pTipoInventario := 2;
    2: pTipoInventario := 0;
  end;
  if ChkSomentePendente.Checked then
     pPendente := 1
  Else
     pPendente := 0;
  ObjInventarioCtrl   := TInventarioCtrl.Create;
  Try
    If FdMemAjusteRelatorio.Active then
       FdMemAjusteRelatorio.EmptyDataSet;
    FdMemAjusteRelatorio.Close;
    ObjInventarioCtrl := TInventarioCtrl.Create;
    JsonArrayAjuste   := ObjInventarioCtrl.GetAjusteRelatorio(0, pDataCriacao,
                         pDataCriacaoFinal, 0, 0, StrToIntDef(EdtProcessoId.Text, 0), PTipoInventario,
                         pPendente, vProdutoId );
    if JsonArrayAjuste.Items[0].TryGetValue('Erro', vErro) then
       ShowErro('Erro: '+vErro)
    Else if JsonArrayAjuste.Items[0].TryGetValue('MSG', vErro) then
       ShowMSG('Erro: '+vErro)
    Else Begin
       FdMemAjusteRelatorio.LoadFromJSON(JsonArrayAjuste, False);
       Try
         ExportarExcel(FdMemAjusteRelatorio);
       Except
         raise Exception.Create('Não foi possível exportar a Apuração para Excel... Verifique o Sistema Operacional.');
       End;
    End;
  Finally
    JsonArrayAjuste := Nil;
    FreeAndNil(ObjInventarioCtrl);
  End;
end;

procedure TFrmRelListaInventario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  vProdutoId := 0;
  FrmRelListaInventario := Nil;
end;

procedure TFrmRelListaInventario.FormCreate(Sender: TObject);
begin
  inherited;
  RbInventarioTipo.ItemIndex := 2;
  LstListaInventario.ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);;
  LstListaInventario.ColWidths[1] := 100+Trunc(100*ResponsivoVideo);;
  LstListaInventario.ColWidths[2] := 200+Trunc(200*ResponsivoVideo);;
  LstListaInventario.ColWidths[3] := 190+Trunc(190*ResponsivoVideo);;
  LstListaInventario.ColWidths[4] := 115+Trunc(115*ResponsivoVideo);; //Criado Por
  LstListaInventario.ColWidths[5] := 90+Trunc(90*ResponsivoVideo);;
  LstListaInventario.ColWidths[6] := 115+Trunc(115*ResponsivoVideo);;
  LstListaInventario.ColWidths[7] := 200+Trunc(200*ResponsivoVideo);; //Dt.Processo
  LstListaInventario.ColWidths[8] := 115+Trunc(115*ResponsivoVideo);; //usuario
  LstListaInventario.ColWidths[9] := 115+Trunc(115*ResponsivoVideo);;
  LstListaInventario.ColWidths[10] := 115+Trunc(115*ResponsivoVideo);;
  LstListaInventario.ColWidths[11] := 200+Trunc(200*ResponsivoVideo);;
  LstListaInventario.ColWidths[12] := 115+Trunc(115*ResponsivoVideo);;
  LstListaInventario.ColWidths[13] := 200+Trunc(200*ResponsivoVideo);;
  LstListaInventario.Alignments[0, 0] := taRightJustify;
  LstListaInventario.FontStyles[0, 0] := [FsBold];
  LstListaInventario.Alignments[4, 0] := taCenter;
  LstListaInventario.Alignments[6, 0] := taCenter;
  LstListaInventario.Alignments[8, 0] := taCenter;
  LstListaInventario.Alignments[9, 0] := taCenter;
  LstListaInventario.Alignments[10, 0] := taCenter;
  LstListaInventario.Alignments[12, 0] := taCenter;
//Lista Endereço Contados
  LstEnderecoContagem.ColWidths[0] := 110+Trunc(110*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
  LstEnderecoContagem.Alignments[0 ,0] := taRightJustify;
  LstEnderecoContagem.FontStyles[0, 0] := [FsBold];
  PnlEnderecoContagem.Width := LstEnderecoContagem.ColWidths[0]+LstEnderecoContagem.ColWidths[1]+LstEnderecoContagem.ColWidths[2]+25;
  //Ajustes - Relatórios
  LstAjusteRelatorio.ColWidths[0]  :=  70+Trunc(70*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[1]  :=  80+Trunc(80*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[2]  := 280+Trunc(280*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[4]  := 130+Trunc(130*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[5]  := 100+Trunc(100*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[6]  :=  70+Trunc(70*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[7]  :=  60+Trunc(60*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[8]  := 100+Trunc(100*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[9]  := 130+Trunc(130*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[10] := 60+Trunc(60*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[11] := 80+Trunc(80*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[12] := 80+Trunc(80*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[13] := 80+Trunc(80*ResponsivoVideo);
  LstAjusteRelatorio.ColWidths[14] := 80+Trunc(80*ResponsivoVideo);
  LstAjusteRelatorio.Alignments[0, 0]  := taRightJustify;
  LstAjusteRelatorio.FontStyles[0, 0]  := [FsBold];
  LstAjusteRelatorio.Alignments[3, 0]  := taCenter;
  LstAjusteRelatorio.Alignments[8, 0]  := taCenter;
  LstAjusteRelatorio.Alignments[6, 0]  := taRightJustify;
  LstAjusteRelatorio.Alignments[7, 0]  := taRightJustify;
  LstAjusteRelatorio.Alignments[10, 0] := taCenter;
  LstAjusteRelatorio.Alignments[11, 0] := taCenter;
  LstAjusteRelatorio.Alignments[12, 0] := taCenter;
  LstAjusteRelatorio.Alignments[13, 0] := taCenter;
  LstAjusteRelatorio.Alignments[14, 0] := taCenter;

  PgcListaInventario.ActivePage := TabListaInventario;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

procedure TFrmRelListaInventario.GetAjusteRelatorio(pInventarioId: Integer);
Var ObjInventarioCtrl : TInventarioCtrl;
    JsonArrayAjuste   : TJsonArray;
    vErro             : String;
begin
  Try
    LstAjusteRelatorio.RowCount := 1;
    If FdMemAjusteRelatorio.Active then
       FdMemAjusteRelatorio.EmptyDataSet;
    FdMemAjusteRelatorio.Close;
    ObjInventarioCtrl := TInventarioCtrl.Create;
    JsonArrayAjuste   := ObjInventarioCtrl.GetAjusteRelatorio(pInventarioId);
    if JsonArrayAjuste.Items[0].TryGetValue('Erro', vErro) then
       ShowErro('Erro: '+vErro)
  //  Else if JsonArrayAjuste.Items[0].TryGetValue('MSG', vErro) then
  //     ShowMSG('Erro: '+vErro)
    Else Begin
       FdMemAjusteRelatorio.LoadFromJSON(JsonArrayAjuste, False);
       MontarAjusteRelatorio;
    End;
  Finally
    JsonArrayAjuste := Nil;
    FreeAndNil(ObjInventarioCtrl);
  End;
end;

procedure TFrmRelListaInventario.GetContagemLote(pItem: Integer);
Var JsonArrayContagem : TJsonArray;
    xContagem         : Integer;
    vErro             : String;
    ObjInventarioCtrl : TInventarioCtrl;
begin
  ObjInventarioCtrl := TInventarioCtrl.Create;
  JsonArrayContagem := ObjInventarioCtrl.GetContagem(pItem, 0);
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
  JsonArrayContagem := Nil;
  FreeAndNil(ObjInventarioCtrl);
end;

procedure TFrmRelListaInventario.GetInventarioEndereco(pInventarioId : Integer);
Var JsonArrayItens : TJsonArray;
    vErro  : String;
    xItens : Integer;
    ObjInventarioCtrl : TInventarioCtrl;
begin
    JsonArrayItens := ObjInventarioCtrl.GetInventarioItens(pInventarioId, 0);
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
         FdMemProdutoDisponivel.FieldByName('Zona').AsString       := JsonArrayItens.Items[xItens].GetValue<String>('zona');
         FdMemProdutoDisponivel.FieldByName('Sngpc').Asinteger     := JsonArrayItens.Items[xItens].GetValue<Integer>('sngpc');
         FdMemProdutoDisponivel.FieldByName('Status').AsString     := JsonArrayItens.Items[xItens].GetValue<String>('status');
       End;
       If JsonArrayItens.Count > 0 then
          FdMemProdutoDisponivel.Post;
       MontaListaEnderecoContado;
    End;
end;

procedure TFrmRelListaInventario.GetInventarioProduto(pInventarioId : Integer);
Var JsonArrayItens : TJsonArray;
    vErro  : String;
    xItens : Integer;
    ObjInventarioCtrl : TInventarioCtrl;
begin
  ObjInventarioCtrl := TInventarioCtrl.Create;
  JsonArrayItens    := ObjInventarioCtrl.GetInventarioItens(pInventarioId, 0);
  if JsonArrayItens.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Não há Itens para contagem no inventário.'+#13+vErro);
     JsonArrayItens := Nil;
     FreeAndNil(ObjInventarioCtrl);
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
  JsonArrayItens := Nil;
  FreeAndNil(ObjInventarioCtrl);
end;

procedure TFrmRelListaInventario.Imprimir;
begin
  With FrxReport1 do Begin
    Variables['vModulo']  := QuotedStr(pChar(Application.Title));
    Variables['vVersao']  := QuotedStr(Versao);
    Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
  End;
  frxPDFExport1.ShowDialog := False;
  FrxReport1.PrepareReport();
  inherited;
//  FrxReport1.ShowReport;
end;

procedure TFrmRelListaInventario.LstDetalheAjusteClick(Sender: TObject);
begin
  inherited;
  if (TAdvStringGrid(Sender).Row > 0) and (TAdvStringGrid(Sender).Cells[0, TAdvStringGrid(Sender).Row] <> '') then Begin
     GetContagemLote(TAdvStringGrid(Sender).Cells[0, TAdvStringGrid(Sender).Row].ToInteger());
     if InventarioTipo = poGeografico then
        FdMemLoteInventariado.Locate('CodProduto; DescrLote', VarArrayOf([TAdvStringGrid(Sender).Cells[1, TAdvStringGrid(Sender).Row], TAdvStringGrid(Sender).Cells[3, TAdvStringGrid(Sender).Row]]), [loPartialKey])
     Else FdMemLoteInventariado.Locate('Endereco; DescrLote', VarArrayOf([TAdvStringGrid(Sender).Cells[1, TAdvStringGrid(Sender).Row], TAdvStringGrid(Sender).Cells[3, TAdvStringGrid(Sender).Row]]), [loPartialKey]);
     ShowLoteContado;
  End
  Else If (TAdvStringGrid(Sender).Row > 0) then
    TAdvStringGrid(Sender).Row := TAdvStringGrid(Sender).Row-1;
end;

procedure TFrmRelListaInventario.LstDetalheAjusteClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
end;

procedure TFrmRelListaInventario.LstEnderecoContagemClick(Sender: TObject);
Var aRow : Integer;
begin
  inherited;
  aRow := TAdvStringGrid(Sender).Row;
  if (aRow > 0) Then Begin
     LstDetalheAjuste.RowCount := 1;
     LstContagemLote.RowCount  := 1;
     LstDetalheAjuste.ClearRect(0, 1, LstDetalheAjuste.ColCount-1, LstDetalheAjuste.RowCount-1);
     LstContagemLote.ClearRect( 0, 1, LstContagemLote.ColCount-1 , LstContagemLote.RowCount-1);
     If (InventarioTipo = poGeografico) then Begin
        FdMemEndereco.Locate('Descricao', StringReplace(TAdvStringGrid(Sender).Cells[0, aRow], '.', '', [rfReplaceAll]), []);
        if FdMemEndereco.FieldByName('Status').AsString <> 'I' then
           BuscarInventarioInicial(LstListaInventario.Ints[0, LstListaInventario.Row]);
     End
     Else Begin
        FDMemProdutoDisponivel.Locate('CodigoERP', StringReplace(TAdvStringGrid(Sender).Cells[0, aRow], '.', '', [rfReplaceAll]), []);
        if FDMemProdutoDisponivel.FieldByName('Status').AsString <> 'I' then
           BuscarInventarioInicial(LstListaInventario.Ints[0, LstListaInventario.Row]);
     End;
  End;
end;

procedure TFrmRelListaInventario.LstEnderecoContagemClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  If aRow = 0 then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
end;

procedure TFrmRelListaInventario.LstListaInventarioClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstListaInventario.SortSettings.Column := aCol;
     LstListaInventario.QSort;
     Exit;
  End
  Else
     LstListaInventario.Row := aRow;
end;

procedure TFrmRelListaInventario.LstListaInventarioDblClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  if aRow < 1 then Exit;
  inherited;
  TabAcompanhamentoContagem.TabVisible := True;
  TabAjuste.TabVisible := LstListaInventario.Cells[3, aRow] = 'Inventario - Finalizado';
  ClearDetalheAjuste;
  LstListaInventario.Row := aRow;
  if LstListaInventario.Cells[1, aRow] = 'Por Endereco' then
     InventarioTipo := poGeografico
  Else
     InventarioTipo := poPrioritario;
  if InventarioTipo = poGeografico then
     GetInventarioEndereco(LstListaInventario.Ints[0, aRow])
  Else If (InventarioTipo = poPrioritario) then
     GetInventarioProduto(LstListaInventario.Ints[0, aRow]);
  PgcListaInventario.ActivePage := TabAcompanhamentoContagem;
  if TabAjuste.TabVisible then
     GetAjusteRelatorio(LstListaInventario.Ints[0, aRow]);
end;

procedure TFrmRelListaInventario.MontaListaEnderecoContado;
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
  LstEnderecoContagem.ColWidths[0] := 110+Trunc(110*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[1] := 150+Trunc(150*ResponsivoVideo);
  LstEnderecoContagem.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
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
end;

procedure TFrmRelListaInventario.MontaListaInventario;
Var xRecno : Integer;
begin
  FdMemPesqGeral.First;
  xRecno := 1;
  LstListaInventario.RowCount  := FdMemPesqGeral.RecordCount+1;
  LstListaInventario.FixedRows := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstListaInventario.Cells[0, xRecno] := FdMemPesqGeral.FieldByName('inventarioid').AsString;
    LstListaInventario.Cells[1, xRecno] := FdMemPesqGeral.FieldByName('tipo').AsString;
    LstListaInventario.Cells[2, xRecno] := FdMemPesqGeral.FieldByName('Motivo').AsString;
    LstListaInventario.Cells[3, xRecno] := FdMemPesqGeral.FieldByName('Processo').AsString;
    LstListaInventario.Cells[4, xRecno] := FdMemPesqGeral.FieldByName('DataLiberacao').AsString;
    LstListaInventario.Cells[5, xRecno] := FdMemPesqGeral.FieldByName('Ajuste').AsString;
    LstListaInventario.Cells[6, xRecno] := FdMemPesqGeral.FieldByName('Gerado').AsString;
    LstListaInventario.Cells[7, xRecno] := FdMemPesqGeral.FieldByName('UsuarioGerador').AsString;
    LstListaInventario.Cells[8, xRecno] := FdMemPesqGeral.FieldByName('MinContagem').AsString;
    LstListaInventario.Cells[9, xRecno] := FdMemPesqGeral.FieldByName('MaxContagem').AsString;
    LstListaInventario.Cells[10, xRecno] := FdMemPesqGeral.FieldByName('Cancelado').AsString;
    LstListaInventario.Cells[11, xRecno] := FdMemPesqGeral.FieldByName('UsuarioCancelamento').AsString;
    LstListaInventario.Cells[12, xRecno] := FdMemPesqGeral.FieldByName('Apurado').AsString;
    LstListaInventario.Cells[13, xRecno] := FdMemPesqGeral.FieldByName('UsuarioApuracao').AsString;

    LstListaInventario.Alignments[0, xRecno] := taRightJustify;
    LstListaInventario.FontStyles[0, xRecno] := [FsBold];
    LstListaInventario.Alignments[4, xRecno] := taCenter;
    LstListaInventario.Alignments[6, xRecno] := taCenter;
    LstListaInventario.Alignments[8, xRecno] := taCenter;
    LstListaInventario.Alignments[9, xRecno] := taCenter;
    LstListaInventario.Alignments[10, xRecno] := taCenter;
    LstListaInventario.Alignments[12, xRecno] := taCenter;
    FdMemPesqGeral.Next;
    Inc(xRecno);
  End;
end;

procedure TFrmRelListaInventario.MontaListaLoteInventariado;
Var xEndereco : Integer;
    VTotContAnterior, vTotContAtual : Integer;
begin
  FdMemLoteInventariado.First;
  LstDetalheAjuste.RowCount  := 1;  //FdMemLoteInventariado.RecordCount+1;
  if FdMemLoteInventariado.RecordCount < 1 then Exit;
//  For xEndereco := 1 to FdMemLoteInventariado.RecordCount do
//    LstDetalheAjuste.AddDataImage(3, xEndereco, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xEndereco := 1;
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

procedure TFrmRelListaInventario.MontaListaProdutoContado;
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
{  LblEnderecoTotal.Caption      := 'Produto(s)';
  EdtEnderecoTotal.Text         := FDMemProdutoDisponivel.recordCount.ToString();
  EdtEnderecoNaoContado.Text    := vProdutoNContado.ToString();
  EdtEnderecoEmContagem.Text    := vProdutoEmContagem.ToString();
  EdtEnderecoConcluido.Text     := vProdutoConcluido.ToString();
  LblEnderecoNaoContado.Caption := FormatFloat('##0.0', RoundTo(vProdutoNContado/FDMemProdutoDisponivel.recordCount*100, -2))+'%';
  LblEnderecoEmContagem.Caption := FormatFloat('##0.0', RoundTo(vProdutoEmcontagem/FDMemProdutoDisponivel.recordCount*100, -2))+'%';
  LblEnderecoConcluido.Caption  := FormatFloat('##0.0', RoundTo(vProdutoConcluido/FDMemProdutoDisponivel.recordCount*100, -2))+'%';
}  FDMemProdutoDisponivel.First;
end;

procedure TFrmRelListaInventario.MontarAjusteRelatorio;
Var xRow : Integer;
begin
  LstAjusteRelatorio.RowCount  := FdMemAjusteRelatorio.RecordCount+1;
  LstAjusteRelatorio.FixedRows := 1;
  FdMemAjusteRelatorio.First;
  xRow := 1;
  for xRow := 1 to Pred(LstAjusteRelatorio.RowCount) do
    LstAjusteRelatorio.AddDataImage(10, xRow, 0, haCenter, vaTop);
  xRow := 1;
  While Not FdMemAjusteRelatorio.Eof do Begin
    LstAjusteRelatorio.Cells[0, xRow] := FdMemAjusteRelatorio.FieldByName('InventarioId').AsString;
    LstAjusteRelatorio.Cells[1, xRow] := FdMemAjusteRelatorio.FieldByName('CodProduto').AsString;
    LstAjusteRelatorio.Cells[2, xRow] := FdMemAjusteRelatorio.FieldByName('Descricao').AsString;
    LstAjusteRelatorio.Cells[3, xRow] := FdMemAjusteRelatorio.FieldByName('Picking').AsString;
    LstAjusteRelatorio.Cells[4, xRow] := FdMemAjusteRelatorio.FieldByName('ZonaPicking').AsString;
    LstAjusteRelatorio.Cells[5, xRow] := FdMemAjusteRelatorio.FieldByName('Lote').AsString;
    LstAjusteRelatorio.Cells[6, xRow] := FdMemAjusteRelatorio.FieldByName('Contagem').AsString;
    LstAjusteRelatorio.Cells[7, xRow] := FdMemAjusteRelatorio.FieldByName('Ajuste').AsString;
    LstAjusteRelatorio.Cells[8, xRow] := FdMemAjusteRelatorio.FieldByName('Endereco').AsString;
    LstAjusteRelatorio.Cells[9, xRow] := FdMemAjusteRelatorio.FieldByName('ZonaContagem').AsString;
    if FdMemAjusteRelatorio.FieldByName('Status').AsInteger in [0, 2] then
       LstAjusteRelatorio.Cells[10, xRow] := '0'
    Else LstAjusteRelatorio.Cells[10, xRow] := '1';
    LstAjusteRelatorio.Cells[11, xRow] := FdMemAjusteRelatorio.FieldByName('DataCriacao').AsString;
    LstAjusteRelatorio.Cells[12, xRow] := FdMemAjusteRelatorio.FieldByName('HoraCriacao').AsString;
    LstAjusteRelatorio.Cells[13, xRow] := FdMemAjusteRelatorio.FieldByName('DataFinalizacao').AsString;
    LstAjusteRelatorio.Cells[14, xRow] := FdMemAjusteRelatorio.FieldByName('HoraFinalizacao').AsString;
    LstAjusteRelatorio.Alignments[0, xRow]  := taRightJustify;
    LstAjusteRelatorio.FontStyles[0, xRow]  := [FsBold];
    LstAjusteRelatorio.Alignments[3, xRow]  := taCenter;
    LstAjusteRelatorio.Alignments[6, xRow]  := taRightJustify;
    LstAjusteRelatorio.Alignments[7, xRow]  := taRightJustify;
    LstAjusteRelatorio.Alignments[8, xRow]  := taCenter;
    LstAjusteRelatorio.Alignments[10, xRow] := taCenter;
    LstAjusteRelatorio.Alignments[11, xRow] := taCenter;
    LstAjusteRelatorio.Alignments[12, xRow] := taCenter;
    LstAjusteRelatorio.Alignments[13, xRow] := taCenter;
    LstAjusteRelatorio.Alignments[14, xRow] := taCenter;
    FdMemAjusteRelatorio.Next;
    Inc(xRow);
  End;
end;

procedure TFrmRelListaInventario.PesquisarDados;
Var JsonArrayInventario : tJsonArray;
    xInventario         : Integer;
    vErro               : String;
    ObjInventarioCtrl   : TInventarioCtrl;
    pDataCriacao        : TDateTime;
    pDataCriacaoFinal   : TDateTime;
    pTipoInventario     : Integer;
    pPendente           : Integer;
begin
  inherited;
  Limpar;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  if EdtDataCriacao.Text <>'  /  /    ' then
     pDataCriacao := StrToDate(EdtDataCriacao.Text)
  Else
     pDataCriacao := 0;
  if EdtDataCriacaoFinal.Text <>'  /  /    ' then
     pDataCriacaoFinal := StrToDate(EdtDataCriacaoFinal.Text)
  Else
     pDataCriacaoFinal := 0;
  case RbInventarioTipo.ItemIndex of
    0: pTipoInventario := 1;
    1: pTipoInventario := 2;
    2: pTipoInventario := 0;
  end;
  if ChkSomentePendente.Checked then
     pPendente := 1
  Else
     pPendente := 0;
  ObjInventarioCtrl   := TInventarioCtrl.Create;
  JsonArrayInventario := ObjInventarioCtrl.getInventario(0, pDataCriacao, 0, 0, StrToIntDef(EdtProcessoId.Text, 0),
                         pTipoInventario, pPendente, vProdutoId, 0, pDataCriacaoFinal);
  if JsonArrayInventario.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     JsonArrayInventario := Nil;
     ObjInventarioCtrl.Free;
     Exit;
  End;
  LstCadastro.RowCount := JsonArrayInventario.Count+1;
  FdMemPesqGeral.LoadFromJSON(JsonArrayInventario, False);
  PovoarFdmMemRelatorioLista;
  MontaListaInventario;
  JsonArrayInventario := Nil;
  FreeAndNil(ObjInventarioCtrl);
end;

procedure TFrmRelListaInventario.PgcListaInventarioChange(Sender: TObject);
begin
  inherited;
  ChkExportarApuracaoGeral.Visible := PgcListaInventario.ActivePageIndex = 2;
end;

procedure TFrmRelListaInventario.PovoarFdmMemRelatorioLista;
begin
  FdMemPesqGeral.First;
  FDMemRelatorioLista.Open;
  While Not FdMemPesqGeral.Eof do Begin
    FDMemRelatorioLista.Append;
    FdMemRelatorioLista.FieldByName('InventarioId').AsInteger       := FdMemPesqGeral.FieldByName('InventarioId').AsInteger;
    FdMemRelatorioLista.FieldByName('InventarioTipoId').AsInteger   := FdMemPesqGeral.FieldByName('InventarioTipo').AsInteger;
    FdMemRelatorioLista.FieldByName('Tipo').AsString                := FdMemPesqGeral.FieldByName('Tipo').AsString;
    FdMemRelatorioLista.FieldByName('TipoAjuste').AsInteger         := FdMemPesqGeral.FieldByName('TipoAjuste').AsInteger;
    FdMemRelatorioLista.FieldByName('Ajuste').AsString              := FdMemPesqGeral.FieldByName('Ajuste').AsString;
    FdMemRelatorioLista.FieldByName('ProcessoId').AsInteger         := FdMemPesqGeral.FieldByName('ProcessoId').AsInteger;
    FdMemRelatorioLista.FieldByName('Processo').AsString            := FdMemPesqGeral.FieldByName('Processo').AsString;
    FdMemRelatorioLista.FieldByName('DataCriacao').AsDateTime       := StrToDate(DateEUAToBr(FdMemPesqGeral.FieldByName('DataCriacao').AsString));
    FdMemRelatorioLista.FieldByName('Gerado').AsDateTime            := StrToDateTime(FdMemPesqGeral.FieldByName('Gerado').AsString);
    FdMemRelatorioLista.FieldByName('UsuarioGerador').AsString      := FdMemPesqGeral.FieldByName('UsuarioGerador').AsString;
    FdMemRelatorioLista.FieldByName('Usuario').AsString             := FdMemPesqGeral.FieldByName('Usuario').AsString;
    if FdMemPesqGeral.FieldByName('MinContagem').AsString<>'' then
       FdMemRelatorioLista.FieldByName('MinContagem').AsDateTime       := StrToDateTime(FdMemPesqGeral.FieldByName('MinContagem').AsString);
    if FdMemPesqGeral.FieldByName('MaxContagem').AsString<>'' then
       FdMemRelatorioLista.FieldByName('MaxContagem').AsDateTime       := StrToDateTime(FdMemPesqGeral.FieldByName('MaxContagem').AsString);
    if FdMemPesqGeral.FieldByName('Cancelado').AsString <> '' then
       FdMemRelatorioLista.FieldByName('Cancelado').AsDateTime         := StrToDateTime(FdMemPesqGeral.FieldByName('Cancelado').AsString);
    FdMemRelatorioLista.FieldByName('UsuarioCancelamento').AsString := FdMemPesqGeral.FieldByName('UsuarioCancelamento').AsString;
    if FdMemPesqGeral.FieldByName('Apurado').AsString <> '' then
       FdMemRelatorioLista.FieldByName('Apurado').AsDateTime           := StrToDateTime(FdMemPesqGeral.FieldByName('Apurado').AsString);
    if FdMemPesqGeral.FieldByName('DataFechamento').AsString <> '' then
       FdMemRelatorioLista.FieldByName('DataFechamento').AsDateTime    := StrToDate(DateEuaToBr(FdMemPesqGeral.FieldByName('DataFechamento').AsString));
    if FdMemPesqGeral.FieldByName('HoraFechamento').AsString <> '' then
       FdMemRelatorioLista.FieldByName('HoraFechamento').AsDateTime    := FdMemPesqGeral.FieldByName('HoraFechamento').AsDateTime;
    FdMemRelatorioLista.FieldByName('UsuarioApuracao').AsString     := FdMemPesqGeral.FieldByName('UsuarioApuracao').AsString;
    FdMemRelatorioLista.FieldByName('SaldoInicial').AsInteger       := FdMemPesqGeral.FieldByName('SaldoInicial').AsInteger;
    FdMemRelatorioLista.FieldByName('TotalEnderecoBloqueado').AsInteger := FdMemPesqGeral.FieldByName('TotalEnderecoBloqueado').AsInteger;
    FdMemRelatorioLista.FieldByName('TotalProdutoBloqueado').AsInteger  := FdMemPesqGeral.FieldByName('TotalProdutoBloqueado').AsInteger;
    FdMemPesqGeral.Next;
  End;
end;

procedure TFrmRelListaInventario.RbInventarioTipoClick(Sender: TObject);
begin
  inherited;
  Limpar;
  LstListaInventario.RowCount := 1;
  LstListaInventario.clearRect(0, 1, LstListaInventario.ColCount-1, LstListaInventario.RowCount-1);
  PgcListaInventario.ActivePage := TabListaInventario;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

procedure TFrmRelListaInventario.ShowLoteContado;
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

procedure TFrmRelListaInventario.TabAcompanhamentoContagemShow(Sender: TObject);
begin
  inherited;
  EdtPesqEndereco.ReadOnly := False;
end;

procedure TFrmRelListaInventario.TabListaInventarioShow(Sender: TObject);
begin
  inherited;
  TabAcompanhamentoContagem.TabVisible := False;
  TabAjuste.TabVisible := False;
end;

end.
