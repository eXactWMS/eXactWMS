unit uFrmRelEtiquetaArmazenagem;

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
  JvExMask, JvSpin, JvToolEdit, Vcl.DialogMessage, Generics.Collections,
  System.Json, Rest.Types, DataSet.Serialize;

type
  TFrmRelEtiquetaArmazenagem = class(TFrmReportBase)
    GbPeriodo: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtDtInicio: TJvDateEdit;
    EdtDtTermino: TJvDateEdit;
    GbPedido: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoId: TEdit;
    EdtDocumentoNr: TEdit;
    GbProduto: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    GbZona: TGroupBox;
    Label13: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqRota: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtDtInicioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelEtiquetaArmazenagem: TFrmRelEtiquetaArmazenagem;

implementation

{$R *.dfm}

Uses Views.Pequisa.EnderecamentoZonas, Views.Pequisa.Produtos, uFuncoes,
  ProdutoCtrl, EnderecamentoZonaCtrl, EntradaCtrl;

procedure TFrmRelEtiquetaArmazenagem.BtnPesqProdutoClick(Sender: TObject);
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

procedure TFrmRelEtiquetaArmazenagem.BtnPesqRotaClick(Sender: TObject);
begin
  inherited;
  if EdtZonaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelEtiquetaArmazenagem.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     JsonProduto := Nil;
     Exit;
  End;
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmRelEtiquetaArmazenagem.EdtDtInicioChange(Sender: TObject);
begin
  inherited;
  LimparLstAdvReport;
end;

procedure TFrmRelEtiquetaArmazenagem.EdtZonaIdExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if EdtZonaId.Text = '' then Begin
     LblZona.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(EdtCodProduto.Text, 0) <= 0 then Begin
     LblZona.Caption := '';
     ShowErro( '😢Código de Zona('+EdtZonaId.Text+') inválido!' );
     EdtZonaId.Clear;
     EdtZonaId.SetFocus;
     Exit;
  end;
  JsonArrayZona := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(EdtZonaId.Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Código de Zona('+EdtZonaId.Text+') não encontrado!');
     EdtZonaId.Clear;
     EdtZonaId.SetFocus;
  End
  Else
     LblZona.Caption := JsonArrayZona.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonArrayZona := Nil;
end;

procedure TFrmRelEtiquetaArmazenagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelEtiquetaArmazenagem := Nil;
end;

procedure TFrmRelEtiquetaArmazenagem.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0] := 100;
  LstReport.ColWidths[1] := 100;
  LstReport.ColWidths[2] := 100;
  LstReport.ColWidths[3] :=  70;
  LstReport.ColWidths[4] := 250;
  LstReport.ColWidths[5] := 250;
  LstReport.ColWidths[6] := 70;
  LstReport.ColWidths[7] := 70;
  LstReport.ColWidths[8] := 45;
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[3, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taRightJustify;
  LstReport.Alignments[7, 0] := taRightJustify;
  LstReport.Alignments[8, 0] := taCenter;
end;

procedure TFrmRelEtiquetaArmazenagem.Limpar;
begin
  inherited;
  EdtDtInicio.Clear;
  EdtDtTermino.Clear;
  EdtPedidoId.Clear;
  EdtDocumentoNr.Clear;
  EdtCodProduto.Clear;
end;

procedure TFrmRelEtiquetaArmazenagem.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xPed, xRetorno : Integer;
begin
  inherited;
  LstReport.RowCount  := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRetorno := 1;
  for xPed := 1 to Pred(pJsonArray.Count) do
    LstReport.AddDataImage( 8, xPed, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRetorno] := FdMemPesqGeral.FieldByName('PedidoId').AsString;
    LstReport.Cells[1, xRetorno] := FdMemPesqGeral.FieldByName('DocumentoNr').AsString;
    LstReport.Cells[2, xRetorno] := FdMemPesqGeral.FieldByName('Data').AsString;
    LstReport.Cells[3, xRetorno] := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[4, xRetorno] := FdMemPesqGeral.FieldByName('Razao').AsString;
    LstReport.Cells[5, xRetorno] := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[6, xRetorno] := FdMemPesqGeral.FieldByName('QtdItens').AsString;
    LstReport.Cells[7, xRetorno] := FdMemPesqGeral.FieldByName('Qtde').AsString;
    LstReport.Cells[8, xRetorno] := '1';
    LstReport.Alignments[0, xRetorno] := taRightJustify;
    LstReport.FontStyles[0, xRetorno] := [FsBold];
    LstReport.Alignments[3, xRetorno] := taRightJustify;
    LstReport.Alignments[6, xRetorno] := taRightJustify;
    LstReport.Alignments[7, xRetorno] := taRightJustify;
    LstReport.Alignments[8, xRetorno] := taCenter;
    FdMemPesqGeral.Next;
    Inc(xRetorno);
  End;
end;

procedure TFrmRelEtiquetaArmazenagem.PesquisarDados;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    pDtInicio, pDtTermino : TDateTime;
    vErro : String;
begin
  inherited;
  if (EdtDtInicio.Text='') and (EdtDtTermino.Text='') and (EdtPedidoId.Text='') and
     (EdtDocumentoNr.Text='') and (EdtZonaId.Text='') and (EdtCodProduto.Text='') then Begin
     ShowErro('Aplique um filtro para pesquisa!');
     Exit;
  End;
  if EdtDtInicio.Text <> '  /  /    ' then
     pDtInicio := StrToDate(EdtDtInicio.Text)
  Else pDtInicio := 0;
  if EdtDtTermino.Text <> '  /  /    ' then
     pDtTermino := StrToDate(EdtDtTermino.Text)
  Else pDtTermino := 0;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
    begin
      ObjEntradaCtrl := TEntradaCtrl.Create;
      JsonArrayRetorno := ObjEntradaCtrl.GetEtiquetaArmazenagem(pDtInicio, pDtTermino, StrToIntDef(EdtPedidoId.Text, 0),
                          EdtDocumentoNr.Text, StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtCodProduto.Text, 0), 1);
      if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
         ShowErro('Erro: '+vErro);
         JsonArrayRetorno := Nil;
         ObjEntradaCtrl.Free;
         Exit;
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdmemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
        FdmemPesqGeral.Open;
      End;
      JsonArrayRetorno := Nil;
      ObjEntradaCtrl.Free;
    End);
end;

end.
