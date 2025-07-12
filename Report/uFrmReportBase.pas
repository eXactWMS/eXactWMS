unit uFrmReportBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, Vcl.Mask,
  JvExMask, JvSpin, System.JSON, REST.Json, Rest.Types, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase,
  ACBrETQ, Vcl.Printers, dxCameraControl;

type
  TFrmReportBase = class(TFrmBase)
    frxCSVExport1: TfrxCSVExport;
    frxDBDataset1: TfrxDBDataset;
    frxHTMLExport1: TfrxHTMLExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxMailExport1: TfrxMailExport;
    frxPDFExport1: TfrxPDFExport;
    frxReport1: TfrxReport;
    frxXLSExport1: TfrxXLSExport;
    LstReport: TAdvStringGrid;
    LblTotRegCaption: TLabel;
    LblTotRegistro: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LstCadastroClick(Sender: TObject);
    procedure LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstCadastroDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure LstCadastroRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure FdMemPesqGeralAfterClose(DataSet: TDataSet);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
  Protected
    Procedure Imprimir; OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); Dynamic;
    Procedure PesquisarDados; Dynamic;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
    Procedure LimparLstAdvReport;
    procedure ImprimirRelatorios;
    Procedure ConfigPrinterGerencial;
  end;

var
  FrmReportBase: TFrmReportBase;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS;

procedure TFrmReportBase.BtnPesquisarStandClick(Sender: TObject);
begin
//  inherited;
  PesquisarDados;
  if (FdMemPesqGeral.Active) and (Not FdMemPesqGeral.IsEmpty) and (PgcBase.ActivePage = TabPrincipal) then
     MontarLstAdvReport(Nil);
end;

procedure TFrmReportBase.ConfigPrinterGerencial;
Var xPrinter : integer;
begin
  Printer.PrinterIndex := -1;
  For xPrinter := 0 to Printer.printers.Count-1 do begin
     If LowerCase(Printer.Printers[xPrinter]) = Lowercase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterGerencial) then begin
        //Altera a classe printer padrão
        if ( Printer.PrinterIndex <> xPrinter ) then begin
           Printer.PrinterIndex := xPrinter;
           frxReport1.PrintOptions.Printer := FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterGerencial
        end;
        break;
     end;
  End;
end;

procedure TFrmReportBase.FdMemPesqGeralAfterClose(DataSet: TDataSet);
begin
  inherited;
  LblTotRegistro.Caption := FormatFloat('######0', 0);
end;

procedure TFrmReportBase.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.RowCount := 1;
  tablistagem.TabVisible := False;
  frxMailExport1.defaultpath := ExtractFilePath(Application.ExeName)+'\Relatorio';
  frxPDFExport1.DefaultPath  := ExtractFilePath(Application.ExeName)+'\Relatorio';
  FrxMailExport1.Lines.Clear;
  FrxMailExport1.Lines.Add('Email enviado para Rhemasys Soluções');
  With FrxReport1 do Begin
    Variables['vModulo']  := QuotedStr(pChar(Application.Title));
    Variables['vVersao']  := QuotedStr(Versao);
    Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
  End;
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  If DebugHook = 0 then
     ConfigPrinterGerencial
end;

procedure TFrmReportBase.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;
  Timer2.Enabled  := False;
  FrmeXactWMS.Tempo := 0;
  case Key Of
     Vk_F5: if BtnFechar.Enabled   then ImgCloseClick(ImgClose);   //BtnFecharClick(BtnFechar);
     13: Begin
           Key := 0;
           SelectNext(ActiveControl,True,True);
         End;
     27: BtnFecharClick(BtnFechar);
     VK_F9:  if vLastErro <> '' then ShowErro(vLastErro);
     Vk_F10: BtnPesquisarStandClick(BtnPesquisarStand); //ConsGeral
     Vk_F12: BtnImprimirStandClick(BtnImprimirStand); //Relatorios
   end;
end;

procedure TFrmReportBase.Imprimir;
begin
  inherited;
  ImprimirRelatorios;
end;

procedure TFrmReportBase.ImprimirRelatorios;
begin
//  if LstReport.RowCount<=1 then
//     raise Exception.Create('Não há dados para gerar o relatório.');
  inherited;
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

procedure TFrmReportBase.Limpar;
begin
  inherited;
  LimparLstAdvReport;
  LblTotRegistro.Caption     := '0';
  ImprimirExportar(False);
end;

procedure TFrmReportBase.LimparLstAdvReport;
begin
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
end;

procedure TFrmReportBase.LstCadastroClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmReportBase.LstCadastroClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  inherited;

end;

procedure TFrmReportBase.LstCadastroDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  inherited;

end;

procedure TFrmReportBase.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
begin
//  inherited;

end;

procedure TFrmReportBase.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
//  inherited;

end;

procedure TFrmReportBase.LstCadastroRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
//  inherited;

end;

procedure TFrmReportBase.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  If aRow = 0 then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  Try TAdvStringGrid(Sender).Row := aRow; Except End;
end;

procedure TFrmReportBase.MontarLstAdvReport(pJsonArray : TJsonArray);
begin
  //FdMemPesqGeral.fielddeflist --Exibir campos da query
  BtnImprimirStand.Enabled := FdMemPesqGeral.RecordCount >= 1;
  BtnImprimirStand.Grayed  := Not BtnImprimirStand.Enabled;
  BtnExportarStand.Enabled := FdMemPesqGeral.RecordCount >= 1;
  BtnExportarStand.Grayed  := Not BtnImprimirStand.Enabled;
  if FdMemPesqGeral.IsEmpty then Exit;
  LstReport.RowCount  := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
end;

procedure TFrmReportBase.PesquisarDados;
begin
  inherited;
  //Limpar; //
  LimparLstAdvReport;
  FdMemPesqGeral.Filter   := '';
  FdmemPesqGeral.Filtered := False;
end;

end.
