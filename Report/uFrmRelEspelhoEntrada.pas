unit uFrmRelEspelhoEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, Generics.Collections,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, System.JSON, REST.Json, Rest.Types
  , EntradaCtrl
  , EntradaItensCtrl, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ,
  dxCameraControl;

type
  TStatusEntrada = (StRecebido, StCheckIn, StFinalizacao, StConcluido);

  TFrmRelEspelhoEntrada = class(TFrmReportBase)
    EdtEntradaId: TLabeledEdit;
    EdtDocumentoNr: TLabeledEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtDtCheckInIni: TJvDateEdit;
    EdtDtCheckInFin: TJvDateEdit;
    GroupBox2: TGroupBox;
    EdtRegistroERP: TLabeledEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    EdtDtDoctoIni: TJvDateEdit;
    EdtDtDoctoFin: TJvDateEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtEntradaIdChange(Sender: TObject);
    procedure EdtEntradaIdExit(Sender: TObject);
    procedure EdtEntradaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEntradaIdEnter(Sender: TObject);
    procedure EdtDtDoctoIniExit(Sender: TObject);
  private
    { Private declarations }
    StatusEntrada : TStatusEntrada;
    Procedure Limpar;
  public
    { Public declarations }
    pDivergencia  : Integer;
    pCallDirect   : Boolean; //True se chamado direto no menu principal, False se chamado de outro Form(Entrada)
  end;

var
  FrmRelEspelhoEntrada: TFrmRelEspelhoEntrada;

implementation

{$R *.dfm}

uses FuncionalidadeClass, uFuncoes;

procedure TFrmRelEspelhoEntrada.BtnPesquisarStandClick(Sender: TObject);
Var ObjEntradaCtrl : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro  : String;
    xItens : Integer;
    pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckInDtFin: TDateTime;
    vColorFont : TColor;
begin
  inherited;
  LstReport.RowCount := 1;
  //FdMemPesqGeral.Close;
  BtnImprimirStand.Grayed := True;
  Try
    If EdtDtDoctoIni.Text = '  /  /    ' then
       pDoctoDataIni := 0
    Else pDoctoDataIni := StrToDate(EdtDtDoctoIni.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial do Documeto inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtDoctoFin.Text = '  /  /    ' then
       pDoctoDataFin := 0
    Else pDoctoDataFin := StrToDate(EdtDtDoctoFin.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final do Documeto inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtCheckInIni.Text = '  /  /    ' then
       pCheckInDtIni := 0
    Else pCheckInDtIni := StrToDate(EdtDtCheckInIni.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial do CheckIn inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtCheckInFin.Text = '  /  /    ' then
       pCheckInDtFin := 0
    Else pCheckInDtFin := StrToDate(EdtDtCheckInFin.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final do CheckIn inválida!'+#13+#10+E.Message);
  End;
  ObjEntradaCtrl := TEntradaCtrl.Create();
  JsonArrayRetorno   := ObjEntradaCtrl.GetEspelho(StrToIntDef(EdtEntradaId.Text, 0), EdtDocumentoNr.Text,
                        EdtRegistroERP.Text, pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckInDtFin, pDivergencia, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtEntradaId.SetFocus;
     //ObjEntradaCtrl.DisposeOf;
     if pCallDirect then
        ShowErro(vErro)
     Else Begin
        ShowMessage('Não há registro de divergência para pesquisa.');
        Close;
     End;
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
  if Not FdMemPesqGeral.IsEmpty then Begin
     LstReport.RowCount  := FdMemPesqGeral.RecordCount+1;
     LstReport.FixedRows := 1;
     BtnImprimirStand.Grayed := False;
  End;
  xItens := 0;
  While Not FdMemPesqGeral.Eof do Begin
    if (FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger+FdMemPesqGeral.FieldByName('QtdDevolvida').Asinteger+
        FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger) = 0 then
       vColorFont := ClRed
    Else vColorFont := clBlack;
    LstReport.FontColors[0, xItens+1] := vColorFont;
    LstReport.FontColors[1, xItens+1] := vColorFont;
    LstReport.FontColors[2, xItens+1] := vColorFont;
    LstReport.FontColors[3, xItens+1] := vColorFont;
    LstReport.FontColors[4, xItens+1] := vColorFont;
    LstReport.FontColors[5, xItens+1] := vColorFont;
    LstReport.FontColors[6, xItens+1] := vColorFont;
    LstReport.FontColors[7, xItens+1] := vColorFont;
    LstReport.FontColors[8, xItens+1] := vColorFont;
    LstReport.Cells[0, xItens+1] := FdMemPesqGeral.FieldByName('produtoid').AsString;;
    LstReport.Cells[1, xItens+1] := FdMemPesqGeral.FieldByName('codproduto').AsString;
    LstReport.Cells[2, xItens+1] := FdMemPesqGeral.FieldByName('descricao').AsString;
    LstReport.Cells[3, xItens+1] := FdMemPesqGeral.FieldByName('descrlote').AsString;
    LstReport.Cells[4, xItens+1] := FdMemPesqGeral.FieldByName('vencimento').AsString;
    LstReport.Cells[5, xItens+1] := FdMemPesqGeral.FieldByName('QtdXml').AsString;
    LstReport.Cells[6, xItens+1] := FdMemPesqGeral.FieldByName('QtdCheckIn').AsString;
    LstReport.Cells[7, xItens+1] := FdMemPesqGeral.FieldByName('QtdDevolvida').AsString;
    LstReport.Cells[8, xItens+1] := FdMemPesqGeral.FieldByName('QtdSegregada').AsString;
    LstReport.Alignments[0, xItens+1] := taRightJustify;
    LstReport.FontStyles[0, xItens+1] := [FsBold];
    LstReport.Alignments[1, xItens+1] := taRightJustify;
    LstReport.Alignments[4, xItens+1] := taCenter;
    LstReport.Alignments[5, xItens+1] := taRightJustify;
    LstReport.Alignments[6, xItens+1] := taRightJustify;
    LstReport.Alignments[7, xItens+1] := taRightJustify;
    LstReport.Alignments[8, xItens+1] := taRightJustify;
    Inc(xItens);
    FdMemPesqGeral.Next;
  End;
  //ObjEntradaCtrl.DisposeOf;
end;

procedure TFrmRelEspelhoEntrada.EdtDtDoctoIniExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmRelEspelhoEntrada.EdtEntradaIdChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelEspelhoEntrada.EdtEntradaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRelEspelhoEntrada.EdtEntradaIdExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    ObjEntradaCtrl   : TEntradaCtrl;
    vErro            : String;
begin
  inherited;
  if (Not EdtEntradaId.ReadOnly) and (EdtEntradaid.text<>'') and (ObjEntradaCtrl.Entrada.EntradaId<>StrToIntDef(EdtEntradaId.Text,0)) then Begin
     Limpar;
     ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtEntradaId.Text, 0);
     ObjEntradaCtrl := ObjEntradaCtrl.GetEntrada(StrToIntDef(EdtEntradaId.Text, 0), 0, EdtDocumentoNr.Text, '',EdtRegistroERP.Text, 0, 1)[0];
     if ObjEntradaCtrl.Entrada.EntradaId > 0 then Begin
        StatusEntrada := TStatusEntrada(ObjEntradaCtrl.Entrada.Status);
        //ShowDados;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelEspelhoEntrada.EdtEntradaIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelEspelhoEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelEspelhoEntrada := Nil;
end;

procedure TFrmRelEspelhoEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0] :=  60;
  LstReport.ColWidths[1] :=  90;
  LstReport.ColWidths[2] :=  230;
  LstReport.ColWidths[3] :=  100;
  LstReport.ColWidths[4] :=  90;
  LstReport.ColWidths[5] :=  70;
  LstReport.ColWidths[6] :=  70;
  LstReport.ColWidths[7] :=  70;
  LstReport.ColWidths[8] :=  70;
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[1, 0] := taRightJustify;
  LstReport.Alignments[4, 0] := taCenter;
  LstReport.Alignments[5, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taRightJustify;
  LstReport.Alignments[7, 0] := taRightJustify;
  LstReport.Alignments[8, 0] := taRightJustify;
  LstReport.RowCount := 1;
  pDivergencia := 0;
  pCallDirect  := True;
end;

procedure TFrmRelEspelhoEntrada.Limpar;
begin
  BtnImprimirStand.Grayed := True;
  FdMemPesqGeral.Close;
  LstReport.RowCount      := 1;
end;

end.
