unit uFrmRelRupturaAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, DataSet.Serialize,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar, Generics.Collections,
  System.Json, Rest.Types, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, JvToolEdit, ACBrBase, ACBrETQ,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxCameraControl;

type
  TFrmRelRupturaAbastecimento = class(TFrmReportBase)
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralQuantidade: TIntegerField;
    FdMemPesqGeralEmbalagem: TIntegerField;
    FdMemPesqGeralEstoque: TIntegerField;
    FdMemPesqGeralIdProduto: TIntegerField;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    Label14: TLabel;
    EdtDtInicial: TJvDateEdit;
    EdtDtFinal: TJvDateEdit;
    procedure FormDestroy(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaListaRuptura;
  public
    { Public declarations }
  end;

var
  FrmRelRupturaAbastecimento: TFrmRelRupturaAbastecimento;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl;

procedure TFrmRelRupturaAbastecimento.BtnPesquisarStandClick(Sender: TObject);
Var ObjPedidoCtrl      : TPedidoSaidaCtrl;
    JsonArrayRetorno   : TJsonArray;
    vErro              : String;
    pDataIni, pDataFin : TDateTime;
begin
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
  if EdtDtInicial.Text = '  /  /    ' then
     pDataIni := 0
  Else pDataIni := StrToDate(EdtDtInicial.Text);
  if EdtDtFinal.Text = '  /  /    ' then
     pDataIni := 0
  Else pDataFin := StrToDate(EdtDtFinal.Text);
  ObjPedidoCtrl := TPedidoSaidaCtrl.Create();
  jsonArrayRetorno := ObjPedidoCtrl.GetRelRupturaAbastecimento(pDataIni, pDataFin);
  if JsonArrayRetorno.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro(verro);
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
  FreeAndNil(ObjPedidoCtrl);
  BtnImprimirStand.Grayed  := False;
  BtnImprimirStand.Enabled := True;
  MontaListaRuptura;
end;

procedure TFrmRelRupturaAbastecimento.FormCreate(Sender: TObject);
begin
  inherited;
  EdtDtInicial.ReadOnly := False;
  EdtDtFinal.ReadOnly   := False;
  LstReport.ColWidths[0]  := 70;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.ColWidths[1]  := 80;
  LstReport.ColWidths[2]  := 250;
  LstReport.ColWidths[3]  := 70;
  LstReport.ColWidths[4]  := 70;
  LstReport.ColWidths[5]  := 70;
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
end;

procedure TFrmRelRupturaAbastecimento.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmRelRupturaAbastecimento := Nil;
end;

procedure TFrmRelRupturaAbastecimento.MontaListaRuptura;
Var xPed, xCorte : Integer;
begin
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  LblTotRegistro.Caption := FormatFloat('#0', FdMemPesqGeral.RecordCount);
  xCorte := 0;
  xPed   := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xPed] := FdMemPesqGeral.FieldByName('IdProduto').AsString;
    LstReport.Cells[1, xPed] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[2, xPed] := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[3, xPed] := FdMemPesqGeral.FieldByName('Quantidade').AsString;
    LstReport.Cells[4, xPed] := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Cells[5, xPed] := FdMemPesqGeral.FieldByName('Estoque').AsString;
    LstReport.Alignments[0, xPed] := taRightJustify;
    LstReport.FontStyles[0, xPed] := [FsBold];
    LstReport.Alignments[1, xPed] := taRightJustify;
    LstReport.Alignments[3, xPed] := taRightJustify;
    LstReport.Alignments[5, xPed] := taRightJustify;
    Inc(xPed);
    FdMemPesqGeral.Next;
  End;
//  LblItens.Caption     := FormatFloat('#0', xItens);
//  LblDemanda.Caption   := FormatFloat('#0', xDemanda);
//  LblPerda.Caption     := FormatFloat('#0', xPerda);
//  LblPercPerda.Caption := FormatFloat(',0.00',(xPerda / xDemanda * 100))+'%'
end;

end.
