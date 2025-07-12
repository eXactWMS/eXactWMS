unit uFrmChekOut_Sobra;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons, Generics.Collections,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, ACBrBarCode, JvToolEdit, JvBaseEdits, Rest.Json, System.Json, Rest.Types,
  dxCameraControl;

type
  TFrmCheckOut_Sobras = class(TFrmReportBase)
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralQuantidade: TIntegerField;
    EdtProdutoId: TJvCalcEdit;
    Label4: TLabel;
    LblEan: TACBrBarCode;
    LblProduto: TLabel;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralEanPrincipal: TStringField;
    FdMemPesqGeralUsuario: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdtProdutoIdExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    Procedure Limpar;
    Procedure BuscaProdutoDaLista(pRow : Integer);
  Protected
    Procedure Imprimir; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCheckOut_Sobras: TFrmCheckOut_Sobras;

implementation

{$R *.dfm}

uses ProdutoCtrl, FuncionalidadeClass, uFuncoes, uFrmeXactWMS;

procedure TFrmCheckOut_Sobras.BuscaProdutoDaLista(pRow : Integer);
begin
  FdMemPesqGeral.Locate('CodProduto', LstReport.Cells[1, pRow], []);
end;

procedure TFrmCheckOut_Sobras.EdtProdutoIdExit(Sender: TObject);
Var vProdutoId, pQtdCheckOut   : Integer;
    vCodDigitado     : String;
    ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayProduto : TJsonArray;
    vErro            : String;
    xListProd        : Integer;
    xLinSel          : Integer;
begin
  vCodDigitado := EdtProdutoId.Text;
  if (EdtProdutoId.Text <> '') then Begin
     ObjProdutoCtrl := TProdutoCtrl.Create;
     JsonArrayProduto := ObjProdutoCtrl.FindProduto('0', EdtProdutoId.Text, '', 0, 0);
     if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then Begin
        EdtProdutoId.Clear;
        EdtProdutoid.SetFocus;
        ShowErro('Produto('+vCodDigitado+') não encontrado!');
        Exit;
     End;
     LblProduto.Caption := JsonArrayProduto.Items[0].GetValue<String>('descricao');
     LblEan.Text := JsonArrayProduto.Items[0].GetValue<String>('eanPrincipal');
     If FdMemPesqGeral.Locate('Produtoid', JsonArrayProduto.Items[0].GetValue<Integer>('idProduto'), []) Then Begin
        FdMemPesqGeral.Edit;
        FdMemPesqGeral.FieldByName('Quantidade').AsInteger := FdMemPesqGeral.FieldByName('Quantidade').AsInteger + 1;
        FdMemPesqGeral.Post;
        for xListProd := 1 to Pred(LstReport.RowCount) do Begin
          if LstReport.Cells[0, xListProd].ToInteger = FdMemPesqGeral.FieldByName('ProdutoId').AsInteger then Begin
             xLinSel := xListProd;
             Break;
          End;
        End;
     End
     Else Begin
        FdMemPesqGeral.Append;
        FdMemPesqGeral.FieldByname('ProdutoId').AsInteger   := JsonArrayProduto.Items[0].GetValue<Integer>('idProduto');
        FdMemPesqGeral.FieldByname('CodProduto').AsInteger  := JsonArrayProduto.Items[0].GetValue<Integer>('codProduto');
        FdMemPesqGeral.FieldByname('Descricao').AsString    := JsonArrayProduto.Items[0].GetValue<String>('descricao');
        FdMemPesqGeral.FieldByname('EnderecoId').AsInteger  := JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco').GetValue<Integer>('enderecoId');
        FdMemPesqGeral.FieldByname('Endereco').AsString     := EnderecoMask(JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco').GetValue<String>('descricao'),
                                                               JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco').GetValue<TJsonObject>('enderecoEstrutura').GetValue<String>('mascara'), True);
        FdMemPesqGeral.FieldByName('Quantidade').AsInteger  := 1;
        FdMemPesqGeral.FieldByname('EanPrincipal').AsString := JsonArrayProduto.Items[0].GetValue<String>('eanPrincipal');
        FdMempesqGeral.FieldByName('Usuario').AsString      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome;
        FdMemPesqGeral.Post;
        LstReport.RowCount := LstReport.RowCount + 1;
        LstReport.Cells[0, LstReport.RowCount-1] := FdMemPesqGeral.FieldByName('ProdutoId').AsString;
        LstReport.Cells[1, LstReport.RowCount-1] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
        LstReport.Cells[2, LstReport.RowCount-1] := FdMemPesqGeral.FieldByName('Descricao').AsString;
        LstReport.Cells[3, LstReport.RowCount-1] := FdMemPesqGeral.FieldByName('Endereco').AsString;
        LstReport.AddDataImage(7, LstReport.RowCount-1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
        LstReport.AddDataImage(8, LstReport.RowCount-1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
        LstReport.Cells[7, LstReport.RowCount-1] := '5';
        LstReport.Cells[8, LstReport.RowCount-1] := '6';
        xLinSel := LstReport.RowCount-1;
     End;
     LstReport.SelectRows(xLinSel, 1);
     LstReport.Cells[4, xLinSel] := FdMemPesqGeral.FieldByName('Quantidade').AsString;
     LstReport.Cells[5, xLinSel] := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome;
     LstReport.Cells[6, xLinSel] := NomeDoComputador;
     LstReport.Alignments[0, xLinSel] := taRightJustify;
     LstReport.FontStyles[0, xLinSel] := [FsBold];
     LstReport.Alignments[1, xLinSel] := taRightJustify;
     LstReport.Alignments[3, xLinSel] := taCenter;
     LstReport.Alignments[4, xLinSel] := taRightJustify;
     LstReport.Alignments[7, xLinSel] := taCenter;
     LstReport.Alignments[8, xLinSel] := taCenter;
     EdtProdutoId.Clear;
     EdtProdutoId.SetFocus;
     FreeAndNil(ObjProdutoCtrl);
     //BtnImprimirStand.Grayed  := False;
     //BtnImprimirStand.Enabled := True;
     ImprimirExportar(True);
     LstReport.FixedRows      := 1;
     Player('concluido');
  End;
end;

procedure TFrmCheckOut_Sobras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmCheckOut_Sobras := Nil;
end;

procedure TFrmCheckOut_Sobras.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
{
   if LstReport.RowCount > 1 then Begin
      CanClose := False;
      raise Exception.Create('Imprima ou cancele o relatório criado!');
   End;
}
  inherited;
end;

procedure TFrmCheckOut_Sobras.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0] :=  80;
  LstReport.ColWidths[1] :=  75;
  LstReport.ColWidths[2] := 300;
  LstReport.ColWidths[3] := 100;
  LstReport.ColWidths[4] :=  65;
  LstReport.ColWidths[5] := 150;
  LstReport.ColWidths[6] := 130;
  LstReport.ColWidths[7] :=  40;
  LstReport.ColWidths[8] :=  40;
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.Alignments[3, 0] := taCenter;
  LstReport.Alignments[4, 0] := taRightJustify;
  LstReport.Alignments[7, 0] := taCenter;
  LstReport.Alignments[8, 0] := taCenter;
end;

procedure TFrmCheckOut_Sobras.FormShow(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmCheckOut_Sobras.Imprimir;
begin
  inherited;

end;

procedure TFrmCheckOut_Sobras.Limpar;
begin
  LimparLstAdvReport;
  EdtProdutoId.Clear;
  LblEan.Text := '';
  EdtProdutoid.Enabled := True;
  if not (FdMemPesqGeral.Active) then
     FdMemPesqGeral.Open;
  FdMemPesqGeral.EmptyDataSet;
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
  EdtProdutoId.SetFocus;
  LstReport.RowCount := 1;
end;

procedure TFrmCheckOut_Sobras.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if LstReport.RowCount <= 1 then Exit;
  if (aCol in [7, 8]) then Begin
     BuscaProdutoDaLista(aRow);
     if aCol = 7 then Begin
        FdMemPesqGeral.Edit;
        FdMemPesqGeral.FieldByname('Quantidade').AsInteger := FdMemPesqGeral.FieldByname('Quantidade').AsInteger + 1;
        LstReport.Cells[4, aRow] := FdMemPesqGeral.FieldByname('Quantidade').AsString;
        FdMemPesqGeral.Post;
   End
     Else Begin
        if FdMemPesqGeral.FieldByname('Quantidade').AsInteger = 1 then begin
           FdMemPesqGeral.Delete;
           LstReport.RemoveRows(aRow, 1);
        end
        Else Begin
          FdMemPesqGeral.Edit;
          FdMemPesqGeral.FieldByname('Quantidade').AsInteger := FdMemPesqGeral.FieldByname('Quantidade').AsInteger - 1;
          LstReport.Cells[4, aRow] := FdMemPesqGeral.FieldByname('Quantidade').AsString;
          FdMemPesqGeral.Post;
      End;
     End;
  End;
end;

end.
