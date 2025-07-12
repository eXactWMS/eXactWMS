unit uFrmRelBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, frxClass,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxDBSet, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxExportImage, frxExportHTML,
  frxExportPDF, Vcl.DBCtrls, JvDBControls, jvCombobox, JvDBCombobox,
  JvToolEdit, JvBaseEdits, JvCheckBox, System.Math, frxExportCSV, uFuncoes,
  frxExportMail, Datasnap.DBClient, acPNG, frxExportXLS, frxExportXML,
  frxExportBaseDialog, Vcl.Grids, Vcl.DBGrids, acImage; //, frxChart;
      //frxExportMail,
type
  TFrmRelBase = class(TForm)
    frxReport1: TfrxReport;
    PnHeader: TPanel;
    LblForm: TLabel;
    QryPesquisa: TFDQuery;
    frxDBDataset1: TfrxDBDataset;
    frxHTMLExport1: TfrxHTMLExport;
    frxJPEGExport1: TfrxJPEGExport;
    Panel3: TPanel;
    Label25: TLabel;
    Panel4: TPanel;
    Label26: TLabel;
    frxCSVExport1: TfrxCSVExport;
    frxMailExport1: TfrxMailExport;
    frxPDFExport1: TfrxPDFExport;
    CdsRelBase: TClientDataSet;
    frxXLSExport1: TfrxXLSExport;
    PnlTopFilter: TPanel;
    PnlMenuRel: TPanel;
    BtnExcelRelatorio: TsImage;
    BtnPrintRelatorio: TsImage;
    BtnGerarRelatorio: TsImage;
    Button2: TsImage;
    BtnPDFRelatorio: TsImage;
    DBGrid1: TDBGrid;
    DsPesquisa: TDataSource;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EnterFocus(Sender: TObject);
    procedure ExitFocus(Sender: TObject);
    Procedure LimpaField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxPDFExport1BeginExport(Sender: TObject);
    procedure BtnSairStandClick(Sender: TObject);
    procedure BtnPrintRelatorioClick(Sender: TObject);
    procedure CdsRelBaseAfterClose(DataSet: TDataSet);
    procedure CdsRelBaseAfterOpen(DataSet: TDataSet);
    procedure QryPesquisaAfterOpen(DataSet: TDataSet);
    procedure QryPesquisaAfterClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelBase: TFrmRelBase;

implementation

{$R *.dfm}

uses uFrmeXactWMS, UDmeXactWMS;

procedure TFrmRelBase.FormCreate(Sender: TObject);
begin
  if width < 710 then width := 710;
  Top    := Round(FrmeXactWMS.Top+FrmeXactWMS.PnlTopRhemaSys.Height)+30;
  Left   := FrmeXactWMS.Left+FrmeXactWMS.MenuSplit.Width+10;
  Height := Round(FrmeXactWMS.Height-(FrmeXactWMS.PnlTopRhemaSys.Height+38));
  Width  := FrmeXactWMS.Width - (FrmeXactWMS.MenuSplit.Width+18);


// http://anaprogramadorajunior.blogspot.com.br/2013/10/fastreport-no-delphi.html
//  LblForm.Caption  := Caption;
//Abaixo corrigir erro de Exportacao no PDF
// http://obrunno.blogspot.com.br/2016/04/fastreport-5-erro-de-violacao-de-acesso.html
  frxMailExport1.defaultpath := ExtractFilePath(Application.ExeName)+'\Relatorio';
  frxPDFExport1.DefaultPath  := ExtractFilePath(Application.ExeName)+'\Relatorio';
  FrxMailExport1.Lines.Clear;
  FrxMailExport1.Lines.Add('Email enviado para RhemaSYS');
  With FrxReport1 do Begin
//    Variables['vModulo']  := QuotedStr(pChar(Application.Title));
//    Variables['vVersao']  := QuotedStr(Versao);
//    Variables['vUsuario'] := QuotedStr(FrmeXactWMS.vgUsuario.Nome);
  End;
end;

procedure TFrmRelBase.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key Of
     13: Begin
         Key := 0;
         SelectNext(ActiveControl,True,True);
         End;
     27: Begin
         Close;
     End;
   end;
end;

procedure TFrmRelBase.FormShow(Sender: TObject);
Var xComp : Integer;
begin
(*
   for xComp := 0 to ComponentCount -1 do Begin
       if (Components[xComp] is tJvDbComboEdit) then tJvDbComboEdit(Components[xComp]).Glyph.LoadFromFile(FrmDataReyLoja.PathApp+'Images32x32\Search32x32.Bmp')
       Else if (Components[xComp] is tJvComboEdit) then tJvComboEdit(Components[xComp]).Glyph.LoadFromFile(FrmDataReyLoja.PathApp+'Images32x32\Search32x32.Bmp');
   end;

*)end;

procedure TFrmRelBase.frxPDFExport1BeginExport(Sender: TObject);
begin
  frxPDFExport1.FileName := Caption+'.Pdf';
end;

procedure TFrmRelBase.EnterFocus(Sender: TObject);
begin
(*
   if activecontrol is TDbedit then Begin
      TDbEdit(Sender).Color := $00BFFFFF;
      TDbEdit(Sender).Font.Style := [FsBold];
      End
   Else if activecontrol is TEdit then Begin
      TEdit(Sender).Color := $00BFFFFF;
      TEdit(Sender).Font.Style := [FsBold];
      End
   else if ActiveControl is TJvDbComboEdit then BEgin
      TJvDbComboEdit(Sender).Color := $00BFFFFF;
      TJvDbComboEdit(Sender).Font.Style := [FsBold];
      End
   else if ActiveControl is TJvComboEdit then BEgin
      TJvComboEdit(Sender).Color := $00BFFFFF;
      TJvComboEdit(Sender).Font.Style := [FsBold];
      End
   else if ActiveControl is TJvDbDateEdit then Begin
      TJvDbDateEdit(Sender).Color := $00BFFFFF;
      TJvDbDateEdit(Sender).Font.Style := [FsBold];
      End
   else if ActiveControl is TJvDateEdit then Begin
      TJvDateEdit(Sender).Color := $00BFFFFF;
      TJvDateEdit(Sender).Font.Style := [FsBold];
      End
   Else if ActiveControl is TJvDbCalcEdit then Begin
      TJvDbCalcEdit(Sender).Color := $00BFFFFF;
      TJvDbCalcEdit(Sender).Font.Style := [FsBold];
      End
   Else if ActiveControl is TJvCalcEdit then Begin
      TJvCalcEdit(Sender).Color := $00BFFFFF;
      TJvCalcEdit(Sender).Font.Style := [FsBold];
      End
   Else if ActiveControl is TLabeledEdit then Begin
      TLabeledEdit(Sender).Color := $00BFFFFF;
      TLabeledEdit(Sender).Font.Style := [FsBold];
   End;

*)end;

procedure TFrmRelBase.ExitFocus(Sender: TObject);
begin
  (*
   if activecontrol is TDbedit then Begin TDbEdit(Sender).Color := ClWindow; TDbEdit(Sender).Font.Style := []; End
    else if ActiveControl is TJvDbComboEdit then Begin TJvDbComboEdit(Sender).Color := ClWindow; TJvDbComboEdit(Sender).Font.Style := []; End
    else if ActiveControl is TJvDbDateEdit then Begin TJvDbDateEdit(Sender).Color := clWindow; TJvDbDateEdit(Sender).Font.Style := []; End
    Else if ActiveControl is TJvDbCalcEdit then Begin TJvDbCalcEdit(Sender).Color := ClWindow; TJvDbCalcEdit(Sender).Font.Style := []; End;
    TDbEdit(Sender).Color := ClWindow;
    TDbEdit(Sender).Font.Style := [];

 *)end;

procedure TFrmRelBase.LimpaField;
Var xComp : Integer;
begin
(*
   for xComp := 0 to ComponentCount -1 do Begin
       if (Components[xComp] is tJvDbComboEdit) then tJvDbComboEdit(Components[xComp]).Clear
       Else if (Components[xComp] is tJvComboEdit) then tJvComboEdit(Components[xComp]).Clear
       Else if (Components[xComp] is tComboBox) then tComboBox(Components[xComp]).ItemIndex := -1
       Else if (Components[xComp] is tJvComboBox) then TJvComboBox(Components[xComp]).ItemIndex := -1
       Else if (Components[xComp] is tEdit) then tEdit(Components[xComp]).Clear
       Else if (Components[xComp] is tJvCalcEdit) then tJvCalcEdit(Components[xComp]).Clear
       Else if (Components[xComp] is tJvCheckBox) then tJvCheckBox(Components[xComp]).Checked := False
       Else if (Components[xComp] is tJvDbCalcEdit) then tJvDbCalcEdit(Components[xComp]).Clear
       Else if (Components[xComp] is TJvDateEdit) then TJvDateEdit(Components[xComp]).Clear
       Else if (Components[xComp] is tRadioButton) then tRadioButton(Components[xComp]).Checked := False
       Else if (Components[xComp] is tRadioGroup) then tRadioGroup(Components[xComp]).ItemIndex := -1
       Else if (Components[xComp] is tMemo) then TMemo(Components[xComp]).Clear
   end;

*)end;

procedure TFrmRelBase.QryPesquisaAfterClose(DataSet: TDataSet);
begin
  BtnPrintRelatorio.Grayed := True;
  BtnExcelRelatorio.Grayed := True;
  BtnPDFRelatorio.Grayed   := True;
end;

procedure TFrmRelBase.QryPesquisaAfterOpen(DataSet: TDataSet);
begin
  BtnPrintRelatorio.Grayed := QryPesquisa.IsEmpty;
  BtnExcelRelatorio.Grayed := QryPesquisa.IsEmpty;
  BtnPDFRelatorio.Grayed   := QryPesquisa.IsEmpty;
end;

procedure TFrmRelBase.BtnPrintRelatorioClick(Sender: TObject);
begin
  if BtnPrintRelatorio.Grayed  then exit;

//http://anaprogramadorajunior.blogspot.com.br/2013/10/fastreport-no-delphi.html
  FrxReport1.ShowReport;
(* Apenas Exportar
frxPDFExport.FileName := sArquivo + '.pdf';
frxPDFExport.DefaultPath := sCaminho + '\';
frxPDFExport.ShowDialog := False;
frxPDFExport.ShowProgress := False;
frxPDFExport.OverwritePrompt := False;
frxRelPedido.PrepareReport(True);
frxRelPedido.Export(frxPDFExport);*)
end;

procedure TFrmRelBase.BtnSairStandClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRelBase.CdsRelBaseAfterClose(DataSet: TDataSet);
begin
  BtnPrintRelatorio.Grayed := True;
  BtnExcelRelatorio.Grayed := True;
  BtnPDFRelatorio.Grayed   := True;
end;

procedure TFrmRelBase.CdsRelBaseAfterOpen(DataSet: TDataSet);
begin
  BtnPrintRelatorio.Grayed := CdsRelBase.IsEmpty;
  BtnExcelRelatorio.Grayed := CdsRelBase.IsEmpty;
  BtnPDFRelatorio.Grayed   := CdsRelBase.IsEmpty;
end;

end.

