unit uFrmAuditoriaSaidaPorProduto;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, JvToolEdit, DataSet.Serialize, Generics.Collections, System.Json, Rest.Types,
  dxCameraControl, PedidoVolumeCtrl;

type
  TFrmAuditoriaSaidaPorProduto = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoId: TEdit;
    EdtRessuprimento: TEdit;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    GbLote: TGroupBox;
    LblLote: TLabel;
    EdtDescrLote: TEdit;
    FdMemPesqGeralData: TDateField;
    FdMemPesqGeralCodPessoaERP: TIntegerField;
    FdMemPesqGeralFantasia: TStringField;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralRessuprimento: TStringField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralDescrLote: TStringField;
    FdMemPesqGeralVencimento: TDateField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FdMemPesqGeralMascara: TStringField;
    Label4: TLabel;
    LblQtdSuprida: TLabel;
    LstLotesAuditoria: TAdvStringGrid;
    TabBalanceamento: TcxTabSheet;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EdtDtInicioBalanceamento: TJvDateEdit;
    EdtDtTerminoBalanceamento: TJvDateEdit;
    LstBalanceamento: TAdvStringGrid;
    Label7: TLabel;
    LblTotRegistroBalanceamento: TLabel;
    GroupBox15: TGroupBox;
    Label24: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZonaVolume: TBitBtn;
    FDMemBalanceamento: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInicioChange(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtPedidoIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesqZonaVolumeClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure TabBalanceamentoShow(Sender: TObject);
    procedure LstBalanceamentoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure EdtPedidoIdExit(Sender: TObject);
  private
    { Private declarations }
    vCodProduto : Integer;
  Protected
    Procedure Imprimir; OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure MontalistaLote(pCodproduto : integer);
    Procedure MontaListaBalanceamento;
    Procedure PesquisarDados; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
    Procedure LimparLstAdvReport;
    procedure ImprimirRelatorios;
  end;

var
  FrmAuditoriaSaidaPorProduto: TFrmAuditoriaSaidaPorProduto;

implementation

{$R *.dfm}

Uses uFuncoes, Views.Pequisa.Produtos, ProdutoCtrl, PedidoSaidaCtrl, Vcl.DialogMessage,Views.Pequisa.EnderecamentoZonas,
  EnderecamentoZonaCtrl;

procedure TFrmAuditoriaSaidaPorProduto.BtnExportarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then Begin
     FdMemPesqGeral.FieldByName('DescrLote').Visible := False;
     FdMemPesqGeral.FieldByName('Vencimento').Visible := False;
     FdMemPesqGeral.FieldByName('PedidoVolumeId').Visible := False;
     inherited;
  End
  Else Begin
     if (Not FDMemBalanceamento.Active) or (FDMemBalanceamento.IsEmpty) then
        raise Exception.Create('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) or (FDMemBalanceamento.IsEmpty) then Exit;
     Try
       ExportarExcel(FDMemBalanceamento);
     Except
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End;
end;

procedure TFrmAuditoriaSaidaPorProduto.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if EdtCodProduto.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmAuditoriaSaidaPorProduto.BtnPesqZonaVolumeClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  vCodProduto := 0;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     JsonProduto := Nil;
     Exit;
  End;
  vCodProduto  := JsonProduto.GetValue<Integer>('codproduto');
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtInicioChange(Sender: TObject);
begin
  inherited;
  if sender = EdtCodProduto then Begin
     LblProduto.Caption := '';
     vCodProduto := 0;
  End;
  LimparLstAdvReport;
  Limpar;
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtPedidoIdExit(Sender: TObject);
begin
  inherited;
  if (Sender=EdtPedidoId) and (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoId.Text, 0)<=0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoId.Text+') de Pedido inválido!');
     EdtPedidoId.Clear;
  End
  Else if (Sender=EdtRessuprimento) and (EdtRessuprimento.Text<>'') and (StrToIntDef(EdtRessuprimento.Text, 0)<=0) then Begin
     EdtRessuprimento.SetFocus;
     ShowErro('Ressuprimento('+EdtRessuprimento.Text+') inválido!');
     EdtRessuprimento.Clear;
  End
  Else if (Sender=EdtCodProduto) and (EdtCodProduto.Text<>'') and (StrToIntDef(EdtCodProduto.Text, 0)<=0) then Begin
     EdtCodProduto.SetFocus;
     ShowErro('Código('+EdtRessuprimento.Text+') de produto inválido!');
     EdtCodProduto.Clear;
     vCodProduto := 0;
  End;
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtPedidoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtZonaIdExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblZona.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblZona.Caption := '';
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
  End
  Else
     LblZona.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonArrayZona := Nil;
  ObjEnderecamentoZonaCtrl.Free;
end;

procedure TFrmAuditoriaSaidaPorProduto.FdMemPesqGeralCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByname('EnderecoFormatado').AsString := EnderecoMask(FdMemPesqGeral.FieldByName('endereco').AsString,
                                                  FdMemPesqGeral.FieldByName('mascara').AsString, True);
end;

procedure TFrmAuditoriaSaidaPorProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmAuditoriaSaidaPorProduto := Nil;
end;

procedure TFrmAuditoriaSaidaPorProduto.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LstReport.ColWidths[0]  := 100+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[1]  :=  70+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[2]  := 200+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  70+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[5]  := 100+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[6]  :=  70+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[7]  := 250+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[8]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[9]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.Alignments[0, 0]  := taCenter;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taCenter;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.FontStyles[9, 0] := [FsBold];

  LstLotesAuditoria.ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);
  LstLotesAuditoria.ColWidths[1] :=  90+Trunc(90*ResponsivoVideo);
  LstLotesAuditoria.ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
  LstLotesAuditoria.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);
  LstLotesAuditoria.ColWidths[4] :=  70+Trunc(70*ResponsivoVideo);
  LstLotesAuditoria.ColWidths[5] :=  80+Trunc(80*ResponsivoVideo);
  LstLotesAuditoria.ColWidths[6] :=  80+Trunc(80*ResponsivoVideo);
  LstLotesAuditoria.Alignments[0, 0] := taRightJustify;
  LstLotesAuditoria.FontStyles[0, 0] := [FsBold];
  LstLotesAuditoria.Alignments[3, 0] := taCenter;
  LstLotesAuditoria.Alignments[4, 0] := taRightJustify;
  LstLotesAuditoria.Alignments[5, 0] := taCenter;
  LstLotesAuditoria.FontStyles[4, 0] := [FsBold];
  LstLotesAuditoria.RowCount := 1;
//  LstLotesAuditoria.Width := (100+120+12+100+90+100);
//  LstLotesAuditoria.Width := LstLotesAuditoria.Width+Trunc(LstLotesAuditoria.Width*ResponsivoVideo)+(20+LstLotesAuditoria.Width);

  LstBalanceamento.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
  LstBalanceamento.ColWidths[1] := 380+Trunc(380*ResponsivoVideo);
  LstBalanceamento.ColWidths[2] :=  90+Trunc(90*ResponsivoVideo);
  LstBalanceamento.ColWidths[3] := 220+Trunc(220*ResponsivoVideo);
  LstBalanceamento.ColWidths[4] :=  90+Trunc(90*ResponsivoVideo);
  LstBalanceamento.ColWidths[5] :=  90+Trunc(90*ResponsivoVideo);
  LstBalanceamento.Alignments[0, 0] := taRightJustify;
  LstBalanceamento.FontStyles[0, 0] := [FsBold];
  LstBalanceamento.Alignments[2, 0] := taCenter;
  LstBalanceamento.Alignments[5, 0] := taRightJustify;
end;

procedure TFrmAuditoriaSaidaPorProduto.FormShow(Sender: TObject);
begin
  inherited;
  EdtInicio.SetFocus;
end;

procedure TFrmAuditoriaSaidaPorProduto.Imprimir;
begin
  inherited;

end;

procedure TFrmAuditoriaSaidaPorProduto.ImprimirRelatorios;
begin

end;

procedure TFrmAuditoriaSaidaPorProduto.Limpar;
begin
  inherited;
  LblQtdSuprida.Caption := '0';
  LstLotesAuditoria.clearRect(0, 1, LstLotesAuditoria.ColCount-1, LstLotesAuditoria.RowCount-1);
end;

procedure TFrmAuditoriaSaidaPorProduto.LimparLstAdvReport;
begin
  if PgcBase.ActivePage = TabPrincipal then Begin
     if FdMemPesqGeral.Active then
        FdmemPesqGeral.EmptyDataSet;
     FdMemPesqGeral.Close;
     If LstReport.RowCount > 1 then Begin
        LstReport.ClearRect(0, 1, LstReport.ColCount-1, LstReport.RowCount-1);
        LstReport.RowCount       := 1;
        BtnImprimirStand.Enabled := False;
        BtnImprimirStand.Grayed  := True;
        BtnExportarStand.Enabled := False;
        BtnExportarStand.Grayed  := True;
     End;
  End
  Else Begin
     LblTotRegistroBalanceamento.Caption := '0';
     if FDMemBalanceamento.Active then
        FDMemBalanceamento.EmptyDataSet;
     FDMemBalanceamento.Close;
     If LstBalanceamento.RowCount > 1 then Begin
        LstBalanceamento.ClearRect(0, 1, LstBalanceamento.ColCount-1, LstBalanceamento.RowCount-1);
        LstBalanceamento.RowCount       := 1;
        BtnImprimirStand.Enabled := False;
        BtnImprimirStand.Grayed  := True;
        BtnExportarStand.Enabled := False;
        BtnExportarStand.Grayed  := True;
     End;
  End;
end;

procedure TFrmAuditoriaSaidaPorProduto.LstBalanceamentoClickCell(
  Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  If aRow = 0 then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  Try TAdvStringGrid(Sender).Row := aRow; Except End;
end;

procedure TFrmAuditoriaSaidaPorProduto.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno    : TjsonArray;
    vErro : String;
    xLote : Integer;
begin
  inherited;
  if aRow < 1 then Exit;
  LstLotesAuditoria.RowCount := 1;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  JsonArrayRetorno    := ObjPedidoVolumeCtrl.GetPedidoVolumeProduto(LstReport.Cells[3, aRow].ToInteger(),
                                                                    LstReport.Cells[6, aRow].ToInteger() );
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else Begin
     LstLotesAuditoria.RowCount  := JsonArrayRetorno.Count+1;
     LstLotesAuditoria.FixedRows := 1;
     for xLote := 0 to Pred(JsonArrayRetorno.Count) do Begin
       LstLotesAuditoria.Cells[0, xLote+1] := JsonArrayRetorno.Items[xLote].GetValue<String>('pedidovolumeid');
       LstLotesAuditoria.Cells[1, xLote+1] := JsonArrayRetorno.Items[xLote].GetValue<String>('embalagem');
       LstLotesAuditoria.Cells[2, xLote+1] := JsonArrayRetorno.Items[xLote].GetValue<String>('lote');
       LstLotesAuditoria.Cells[3, xLote+1] := JsonArrayRetorno.Items[xLote].GetValue<String>('vencimento');
       LstLotesAuditoria.Cells[4, xLote+1] := JsonArrayRetorno.Items[xLote].GetValue<String>('qtdsuprida');
       LstLotesAuditoria.Cells[5, xLote+1] := EnderecoMask(JsonArrayRetorno.Items[xLote].GetValue<String>('endereco'),
                                                           JsonArrayRetorno.Items[xLote].GetValue<String>('mascara'), True);
       LstLotesAuditoria.Cells[6, xLote+1] := JsonArrayRetorno.Items[xLote].GetValue<String>('processo');
       LstLotesAuditoria.Alignments[0, xLote+1] := taRightJustify;
       LstLotesAuditoria.FontStyles[0, xLote+1] := [FsBold];
       LstLotesAuditoria.Alignments[3, xLote+1] := taCenter;
       LstLotesAuditoria.Alignments[4, xLote+1] := taRightJustify;
       LstLotesAuditoria.Alignments[5, xLote+1] := taCenter;
       LstLotesAuditoria.FontStyles[4, xLote+1] := [FsBold];
     End;
  End;
  JsonArrayRetorno := Nil;
  ObjPedidoVolumeCtrl.Free;
end;

procedure TFrmAuditoriaSaidaPorProduto.MontaListaBalanceamento;
Var xRetorno : Integer;
begin
  LstBalanceamento.RowCount  := FDMemBalanceamento.RecordCount+1;
  LstBalanceamento.FixedRows := 1;
  xRetorno := 1;
  LblQtdSuprida.Caption := '0';
  LblTotRegistroBalanceamento.Caption :=  FDMemBalanceamento.RecordCount.ToString();
  While Not FDMemBalanceamento.Eof do Begin
    LstBalanceamento.Cells[0, xRetorno] := FDMemBalanceamento.FieldByName('CodProduto').AsString;
    LstBalanceamento.Cells[1, xRetorno] := FDMemBalanceamento.FieldByName('Descricao').AsString;
    LstBalanceamento.Cells[2, xRetorno] := FDMemBalanceamento.FieldByName('Endereco').AsString;
    LstBalanceamento.Cells[3, xRetorno] := FDMemBalanceamento.FieldByName('Zona').AsString;
    LstBalanceamento.Cells[4, xRetorno] := FDMemBalanceamento.FieldByName('Curva').AsString;
    LstBalanceamento.Cells[5, xRetorno] := FDMemBalanceamento.FieldByName('QtdSuprida').AsString;
    LstBalanceamento.Alignments[0, xRetorno] := taRightJustify;
    LstBalanceamento.FontStyles[0, xRetorno] := [FsBold];
    LstBalanceamento.Alignments[2, xRetorno] := taCenter;
    LstBalanceamento.Alignments[5, xRetorno] := taRightJustify;
    FDMemBalanceamento.Next;
    Inc(xRetorno);
  End;
  BtnImprimirStand.Enabled := True;
  BtnImprimirStand.Grayed  := False;
  BtnExportarStand.Enabled := True;
  BtnExportarStand.Grayed  := False;
end;

procedure TFrmAuditoriaSaidaPorProduto.MontalistaLote(pCodproduto: integer);
begin

end;

procedure TFrmAuditoriaSaidaPorProduto.MontarLstAdvReport(
  pJsonArray: TJsonArray);
Var xRetorno : Integer;
    vTotQtdSuprida : integer;
begin
  inherited;
  LstReport.RowCount       := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRetorno := 1;
  LblQtdSuprida.Caption := '0';
  vTotQtdSuprida := 0;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRetorno]  := FdMemPesqGeral.FieldByName('data').AsString;
    LstReport.Cells[1, xRetorno]  := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[2, xRetorno]  := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[3, xRetorno]  := FdMemPesqGeral.FieldByName('PedidoId').AsString;
    LstReport.Cells[4, xRetorno]  := FdMemPesqGeral.FieldByName('Ressuprimento').AsString;
    LstReport.Cells[5, xRetorno]  := FdMemPesqGeral.FieldByName('Processo').AsString;
    LstReport.Cells[6, xRetorno]  :=  FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[7, xRetorno]  := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[8, xRetorno] := EnderecoMask(FdMemPesqGeral.FieldByName('endereco').AsString,
                                                 FdMemPesqGeral.FieldByName('mascara').AsString, True);
    LstReport.Cells[9, xRetorno] := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    vTotQtdSuprida := vTotQtdSuprida + FdMemPesqGeral.FieldByName('QtdSuprida').AsInteger;
    LstReport.Alignments[0, xRetorno] := taRightJustify;
    LstReport.FontStyles[0, xRetorno] := [FsBold];
    LstReport.Alignments[1, xRetorno] := taRightJustify;
    LstReport.Alignments[3, xRetorno] := taRightJustify;
    LstReport.Alignments[4, xRetorno] := taRightJustify;
    LstReport.Alignments[6, xRetorno] := taRightJustify;
    LstReport.Alignments[8, xRetorno] := taCenter;
    LstReport.Alignments[9, xRetorno] := taRightJustify;
    LstReport.FontStyles[9, xRetorno] := [FsBold];
    FdMemPesqGeral.Next;
    Inc(xRetorno);
  End;
  LblQtdSuprida.Caption := vTotQtdSuprida.ToString;
end;

procedure TFrmAuditoriaSaidaPorProduto.PesquisarDados;
Var vDtInicio, vDtFinal : TDateTime;
    vErro   : String;
    JsonArrayRetorno : TJsonArray;
    vDataInicial, vDataFinal : TDateTime;
    ObjPedidoSaidaCtrl       : TPedidoSaidaCtrl;
begin
  if (Not (PgcBase.ActivePage = TabPrincipal)) and (Not (PgcBase.ActivePage = TabBalanceamento)) then Exit;
  If PgcBase.ActivePage = TabPrincipal then Begin
     if vCodProduto = 0 then Begin
        ShowErro('Informe o produto desejado!');
        Exit;
     End;
     if EdtInicio.Text = '  /  /    ' then
        vDataInicial := 0
     Else vDataInicial := StrToDate(EdtInicio.Text);
     if EdtTermino.Text = '  /  /    ' then
        vDataFinal := 0
     Else vDataFinal := StrToDate(EdtTermino.Text);
  End
  Else Begin
     if EdtDtInicioBalanceamento.Text = '  /  /    ' then
        vDataInicial := 0
     Else vDataInicial := StrToDate(EdtDtInicioBalanceamento.Text);
     if EdtDtTerminoBalanceamento.Text = '  /  /    ' then
        vDataFinal := 0
     Else vDataFinal := StrToDate(EdtDtTerminoBalanceamento.Text);
  End;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
    begin
      ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
      if PgcBase.ActivePage = TabPrincipal then
         JsonArrayRetorno := ObjPedidoSaidaCtrl.GetAuditoriaSaidaPorProduto(vDataInicial, vDataFinal,
                             StrToIntDef(EdtPedidoId.Text, 0), EdtRessuprimento.Text, vCodProduto, EdtDescrLote.Text)
      Else
         JsonArrayRetorno := ObjPedidoSaidaCtrl.GetSaidaPorProdutoBalanceamento(vDataInicial, vDataFinal, StrToIntDef(EdtZonaId.Text, 0));
      if JsonArrayRetorno.Get(0).tryGetValue<String>('MSG', vErro) then Begin
         JsonArrayRetorno := Nil;
         ShowMSG('😢Erro: '+vErro);
         LimparLstAdvReport
      End
      Else if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         JsonArrayRetorno := Nil;
         ShowErro('😢Erro: '+vErro);
         LimparLstAdvReport;
      End
      Else Begin
        if PgcBase.activePage = TabPrincipal then Begin
           If FdMemPesqGeral.Active then
              FdmemPesqGeral.EmptyDataSet;
           FdMemPesqGeral.Close;
           FdmemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
           FdmemPesqGeral.Open;
           //LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
        End
        Else Begin
           If FDMemBalanceamento.Active then
              FDMemBalanceamento.EmptyDataSet;
           FDMemBalanceamento.Close;
           FDMemBalanceamento.LoadFromJSON(JsonArrayRetorno, False);
           FDMemBalanceamento.Open;
           LblTotRegistro.Caption := FormatFloat('######0', FDMemBalanceamento.RecordCount);
           MontaListaBalanceamento;
        End;
      End;
      JsonArrayRetorno := Nil;
      ObjPedidoSaidaCtrl.Free;
    End);
end;

procedure TFrmAuditoriaSaidaPorProduto.TabBalanceamentoShow(Sender: TObject);
begin
  inherited;
  EdtDtInicioBalanceamento.SetFocus;
end;

end.
