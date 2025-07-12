unit uFrmAuditoriaAcompanhamentoCheckIn;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls, DataSet.Serialize,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, EntradaCtrl,System.JSON, REST.Json, Rest.Types;

type
  TFrmAuditoriaAcompanhamentoCheckIn = class(TFrmReportBase)
    GroupBox5: TGroupBox;
    EdtPedidoId: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    EdtRegistroERP: TLabeledEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    EdtDataInicial: TJvDateEdit;
    EdtDataFinal: TJvDateEdit;
    GroupBox1: TGroupBox;
    EdtCodPessoaERP: TLabeledEdit;
    BtnPesqPessoa: TBitBtn;
    LblFornecedor: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    JvDateEdit1: TJvDateEdit;
    JvDateEdit2: TJvDateEdit;
    GroupBox3: TGroupBox;
    LblUsuario: TLabel;
    EdtUsuarioId: TLabeledEdit;
    BtnPesqUsuario: TBitBtn;
    GroupBox4: TGroupBox;
    LblProduto: TLabel;
    EdtCodProduto: TLabeledEdit;
    BtnPesqProduto: TBitBtn;
    Label4: TLabel;
    LblIPP: TLabel;
    procedure EdtPedidoIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqPessoaClick(Sender: TObject);
    procedure EdtCodPessoaERPExit(Sender: TObject);
    procedure EdtPedidoIdExit(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqUsuarioClick(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
  private
    { Private declarations }
    vCodProduto : Integer;
    Procedure MontaListaCheckIn;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmAuditoriaAcompanhamentoCheckIn: TFrmAuditoriaAcompanhamentoCheckIn;

implementation

{$R *.dfm}

Uses uFuncoes, PessoaCtrl, Views.Pequisa.Produtos, Views.Pequisa.Pessoas,
  ProdutoCtrl, Views.Pequisa.Usuarios, UsuarioCtrl;

procedure TFrmAuditoriaAcompanhamentoCheckIn.BtnPesqPessoaClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtCodPessoaERP.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtCodPessoaERPExit(EdtCodPessoaERP);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.BtnPesqProdutoClick(
  Sender: TObject);
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

procedure TFrmAuditoriaAcompanhamentoCheckIn.BtnPesqUsuarioClick(
  Sender: TObject);
begin
  inherited;
  if EdtUsuarioId.ReadOnly then Exit;
  inherited;
  FrmPesquisaUsuario := TFrmPesquisaUsuario.Create(Application);
  try
    if (FrmPesquisaUsuario.ShowModal = mrOk) then Begin
       EdtUsuarioId.Text := FrmPesquisaUsuario.Tag.ToString;
       EdtUsuarioIdExit(EdtUsuarioId);
    End;
  finally
    FreeAndNil(FrmPesquisaUsuario);
  end;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtCodPessoaERPExit(
  Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
     ShowErro( '😢Fornecedor('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(TEdit(Sender).text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
   ShowErro( '😢Fornecedor('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia')
  End;
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId     : Integer;
    ObjProdutoCtrl : TProdutoCtrl;
    JsonProduto    : TJsonObject;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if StrToInt64Def(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Código do produto('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  JsonProduto := TProdutoCtrl.GetEan(TEdit(Sender).Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  vCodProduto := JsonProduto.GetValue<Integer>('codproduto');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+TEdit(Sender).Text+') não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else
     LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  JsonProduto := Nil;
  FreeAndNil(ObjProdutoCtrl);
  ExitFocus(Sender);
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtPedidoIdChange(Sender: TObject);
begin
  inherited;
  Limpar;
  LblIPP.Caption:= '0,00%';
  if Sender = EdtCodPessoaERP then
     LblFornecedor.Caption := ''
  Else if Sender = EdtUsuarioId then
     LblUsuario.Caption := ''
  Else if Sender = EdtCodProduto then
     LblProduto.Caption := '';
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtPedidoIdExit(Sender: TObject);
begin
  inherited;
  if (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoid.Text,0) <= 0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoid.Text+') do Pedido inválido!');
     EdtPedidoId.Clear;
     Exit;
  End;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl  : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  if StrToIntDef(EdtUsuarioId.Text, 0) = 0 then Exit;
  ObjUsuarioCtrl := TUsuarioCtrl.Create;
  JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro'+vErro);
  End
  Else
     LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjUsuarioCtrl);
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmAuditoriaAcompanhamentoCheckIn := Nil;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[ 0] :=  90+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 1] := 380+Trunc(380*ResponsivoVideo);
  LstReport.ColWidths[ 2] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 3] := 110+Trunc(110*ResponsivoVideo);
  LstReport.ColWidths[ 4] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 5] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[ 6] := 100+Trunc(100*ResponsivoVideo); //Dt.Processo
  LstReport.ColWidths[ 7] := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[ 8] := 90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[ 9] := 90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[10] := 70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[11] := 70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[12] := 95+Trunc(95*ResponsivoVideo);
  LstReport.Alignments[ 0, 0] := taRightJustify;
  LstReport.FontStyles[ 0, 0] := [FsBold];
  LstReport.Alignments[ 2, 0] := taRightJustify;
  LstReport.Alignments[ 3, 0] := taRightJustify;
  LstReport.Alignments[ 4, 0] := taRightJustify;
  LstReport.Alignments[ 5, 0] := taRightJustify;
  LstReport.Alignments[ 6, 0] := taRightJustify;
  LstReport.Alignments[ 7, 0] := taRightJustify;
  LstReport.Alignments[ 8, 0] := taRightJustify;
  LstReport.Alignments[ 9, 0] := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
  LstReport.Alignments[11, 0] := taRightJustify;

  LstReport.Alignments[12, 0] := taRightJustify;
  LstReport.FontSizes[ 0, 0] := 12;
  LstReport.FontSizes[ 1, 0] := 12;
  LstReport.FontSizes[ 2, 0] := 12;
  LstReport.FontSizes[ 3, 0] := 12;
  LstReport.FontSizes[ 4, 0] := 12;
  LstReport.FontSizes[ 5, 0] := 12;
  LstReport.FontSizes[ 6, 0] := 12;
  LstReport.FontSizes[ 7, 0] := 12;
  LstReport.FontSizes[ 8, 0] := 12;
  LstReport.FontSizes[ 9, 0] := 12;
  LstReport.FontSizes[10, 0] := 12;
  LstReport.FontSizes[11, 0] := 12;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.Imprimir;
begin
  inherited;

end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.LstReportClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
     Exit;
  End
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.MontaListaCheckIn;
Var xRecno, vIPP : Integer;
begin
  FdMemPesqGeral.First;
  xRecno := 1;
  vIPP   := 0;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRecno]  := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[1, xRecno]  := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[2, xRecno]  := FdMemPesqGeral.FieldByName('TPedido').AsString;
    LstReport.Cells[3, xRecno]  := FdMemPesqGeral.FieldByName('Conferido').AsString;
    LstReport.Cells[4, xRecno]  := FdMemPesqGeral.FieldByName('Sku').AsString;
    LstReport.Cells[5, xRecno]  := FdMemPesqGeral.FieldByName('SkuConferido').AsString;
    LstReport.Cells[6, xRecno]  := FdMemPesqGeral.FieldByName('QtdXML').AsString;
    LstReport.Cells[7, xRecno]  := FdMemPesqGeral.FieldByName('QtdCheckIn').AsString;

    LstReport.Cells[8, xRecno]  := FdMemPesqGeral.FieldByName('QtdDevolvida').AsString;
    LstReport.Cells[9, xRecno]  := FdMemPesqGeral.FieldByName('QtdSegregada').AsString;
    LstReport.Cells[10, xRecno] := FdMemPesqGeral.FieldByName('PercDevolucao').AsString;
    LstReport.Cells[11, xRecno] := FdMemPesqGeral.FieldByName('PercSegregado').AsString;

    LstReport.Cells[12, xRecno] := FormatFloat('0.00', FdMemPesqGeral.FieldByName('PercProducao').AsFloat);// FdMemPesqGeral.FieldByName('UnidTotalCheckIn').AsInteger / FdMemPesqGeral.FieldByName('UnidQtdXML').AsInteger * 100);
    if FdMemPesqGeral.FieldByName('PercProducao').AsFloat = 100 then
       Inc(vIPP);
    LstReport.Alignments[0, xRecno]  := taRightJustify;
    LstReport.FontStyles[0, xRecno]  := [FsBold];
    LstReport.Alignments[2, xRecno]  := taRightJustify;
    LstReport.Alignments[3, xRecno]  := taRightJustify;
    LstReport.Alignments[4, xRecno]  := taRightJustify;
    LstReport.Alignments[5, xRecno]  := taRightJustify;
    LstReport.Alignments[6, xRecno]  := taRightJustify;
    LstReport.Alignments[7, xRecno]  := taRightJustify;
    LstReport.Alignments[8, xRecno]  := taRightJustify;
    LstReport.Alignments[9, xRecno]  := taRightJustify;
    LstReport.Alignments[10, xRecno] := taRightJustify;
    LstReport.Alignments[11, xRecno] := taRightJustify;
    LstReport.Alignments[12, xRecno] := taRightJustify;
    LstReport.FontSizes[0, xRecno] := 12;
    LstReport.FontSizes[1, xRecno] := 12;
    LstReport.FontSizes[2, xRecno] := 12;
    LstReport.FontSizes[3, xRecno] := 12;
    LstReport.FontSizes[4, xRecno] := 12;
    LstReport.FontSizes[5, xRecno] := 12;
    LstReport.FontSizes[6, xRecno] := 12;
    LstReport.FontSizes[7, xRecno] := 12;
    LstReport.FontSizes[8, xRecno] := 12;
    LstReport.FontSizes[9, xRecno] := 12;
    LstReport.FontSizes[10, xRecno] := 12;
    LstReport.FontSizes[11, xRecno] := 12;
    LstReport.FontSizes[12, xRecno] := 12;
    LstReport.FontStyles[1, xRecno] := [FsBold];
    LstReport.FontStyles[2, xRecno] := [FsBold];
    LstReport.FontStyles[3, xRecno] := [FsBold];
    LstReport.FontStyles[4, xRecno] := [FsBold];
    LstReport.FontStyles[5, xRecno] := [FsBold];
    LstReport.FontStyles[6, xRecno] := [FsBold];
    LstReport.FontStyles[7, xRecno] := [FsBold];
    LstReport.FontStyles[12, xRecno] := [FsBold];
    FdMemPesqGeral.Next;
    Inc(xRecno);
  End;
  LblIPP.Caption := FormatFloat('0.00', vIPP / FdMemPesqGeral.RecordCount * 100 )+'%';
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.PesquisarDados;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    pDataInicial     : TDateTime;
    pDataFinal       : TDateTime;
    vErro : String;
begin
  if (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoid.Text,0) <= 0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoid.Text+') do Pedido inválido!');
     EdtPedidoId.Clear;
     Exit;
  End;
  inherited;
  if (StrToIntDef(EdtPedidoId.Text, 0)=0) and (StrToIntDef(EdtCodPessoaERP.Text, 0)=0) and
     (EdtDataInicial.Text='  /  /    ') and (EdtDataFinal.Text='  /  /    ') Then Begin
     ShowErro('Informe os parâmetro para pesquisa.');
     EdtPedidoId.SetFocus;
     Exit;
  End;
  if EdtDataInicial.Text <>'  /  /    ' then
     pDataInicial := StrToDate(EdtDataInicial.Text)
  Else
     pDataInicial := 0;
  if EdtDataFinal.Text <>'  /  /    ' then
     pDataFinal := StrToDate(EdtDataFinal.Text)
  Else
     pDataFinal := 0;
  ObjEntradaCtrl   := TEntradaCtrl.Create;
  JsonArrayRetorno := ObjEntradaCtrl.GetAcompanhamentoCheckIn(StrToIntDef(EdtPedidoId.Text, 0),
                                                              StrToIntDef(EdtCodPessoaERP.Text, 0),
                                                              pDataInicial, pDataFinal);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     JsonArrayRetorno := Nil;
     ObjEntradaCtrl.Free;
     Exit;
  End;
  LstCadastro.RowCount := JsonArrayRetorno.Count+1;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
  MontaListaCheckIn;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl.Free;
end;

end.
