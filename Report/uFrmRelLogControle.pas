unit uFrmRelLogControle;

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
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, System.Generics.Collections,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, System.JSON, REST.Json, Rest.Types, DataSet.Serialize,
  Vcl.OleCtrls, SHDocVw, View.WebCharts;

type
  TFrmRelLogControle = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    Label4: TLabel;
    EdtTerminal: TEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BtnPesqUsuario: TBitBtn;
    ChkLogErroOnly: TCheckBox;
    Label5: TLabel;
    EdtRequisicao: TEdit;
    CbVerbo: TComboBox;
    Label6: TLabel;
    TabDashBoard: TcxTabSheet;
    WebBrowser1: TWebBrowser;
    WebCharts1: TWebCharts;
    FdMemDashBoardRequisiscao: TFDMemTable;
    FdMemDashBoardRequisiscaoLabel: TStringField;
    FdMemDashBoardRequisiscaoValue: TIntegerField;
    FdMemDashBoardRequisiscaoRGB: TStringField;
    FdMemDashBoardAdvertencia: TFDMemTable;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    FdMemDashBoardErro: TFDMemTable;
    StringField3: TStringField;
    IntegerField2: TIntegerField;
    StringField4: TStringField;
    PnlGrafico: TPanel;
    BtnRefresh: TsImage;
    PnDshlRequisicao: TPanel;
    LblTotalRequisicao: TLabel;
    PnlTitRequisicao: TPanel;
    BvRequisicao: TBevel;
    PnlDshAdvertencia: TPanel;
    LblTotalAdvertencia: TLabel;
    PnlTitAdvertencia: TPanel;
    BvAdvertencia: TBevel;
    PnlDshErro: TPanel;
    LblTotalErro: TLabel;
    PnlTitErro: TPanel;
    BvErro: TBevel;
    GbAtualizarDsh: TGroupBox;
    CbTime: TComboBox;
    TmDashBoard: TTimer;
    procedure BtnPesqUsuarioClick(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabDashBoardShow(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnRefreshClick(Sender: TObject);
    procedure TmDashBoardTimer(Sender: TObject);
    procedure CbTimeClick(Sender: TObject);
  private
    { Private declarations }
    Procedure GetLogDashBoard;
    Procedure ShowGrafico;
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelLogControle: TFrmRelLogControle;

implementation

{$R *.dfm}

Uses Views.Pequisa.Usuarios, UsuarioCtrl, LogControleCtrl, Vcl.DialogMessage, Charts.Types, TypInfo;

procedure TFrmRelLogControle.BtnFecharClick(Sender: TObject);
begin
  inherited;
  GetLogDashBoard;
end;

procedure TFrmRelLogControle.BtnPesquisarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then
     inherited;
end;

procedure TFrmRelLogControle.BtnPesqUsuarioClick(Sender: TObject);
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

procedure TFrmRelLogControle.BtnRefreshClick(Sender: TObject);
begin
  inherited;
  GetLogDashBoard;
end;

procedure TFrmRelLogControle.CbTimeClick(Sender: TObject);
begin
  inherited;
  TmDashBoard.Enabled := False;
  case CbTime.ItemIndex of
    1: TmDashBoard.Interval := 60000;
    2: TmDashBoard.Interval := Trunc(1.5*60000);
    3: TmDashBoard.Interval := 2*60000;
    4: TmDashBoard.Interval := Trunc(2.5*60000);
    5: TmDashBoard.Interval := 3*60000;
    6: TmDashBoard.Interval := 4*60000;
    7: TmDashBoard.Interval := 5*60000;
    8: TmDashBoard.Interval := 10*60000;
  end;
  TmDashBoard.Enabled := CbTime.ItemIndex > 0;
end;

procedure TFrmRelLogControle.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelLogControle.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  if sender = EdtUsuarioId  then Lblusuario.Caption := '';
  Limpar;
end;

procedure TFrmRelLogControle.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl   : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro  : String;
begin
  inherited;
  LblUsuario.Caption := '';
  if (Not EdtUsuarioId.ReadOnly) and (EdtUsuarioId.Text <> '') then Begin
     ObjUsuarioCtrl   := TUsuarioCtrl.Create();
     JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) Then begin
        ShowErro(vErro);
        EdtUsuarioId.Clear;
        EdtUsuarioId.SetFocus;
     End
     Else
        LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
     JsonArrayRetorno := Nil;
     ObjUsuarioCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelLogControle.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelLogControle := Nil;
end;

procedure TFrmRelLogControle.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0] :=   60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[1] :=   80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[2] :=   90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[3] :=  180+Trunc(180*ResponsivoVideo);
  LstReport.ColWidths[4] :=  100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[5] :=   40+Trunc(40*ResponsivoVideo);
  LstReport.ColWidths[6] :=   80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[7] :=   40+Trunc(40*ResponsivoVideo);
  LstReport.ColWidths[8] :=  180+Trunc(180*ResponsivoVideo);
  LstReport.ColWidths[9] :=  100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[10] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[11] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[12] := 180+Trunc(180*ResponsivoVideo);
  LstReport.ColWidths[13] :=  50+Trunc(50*ResponsivoVideo);
  LstReport.ColWidths[14] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[15] := 140+Trunc(140*ResponsivoVideo);
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[1, 0] := taCenter;
  LstReport.Alignments[2, 0] := taCenter;
  LstReport.Alignments[3, 0] := taLeftJustify;
  LstReport.Alignments[4, 0] := taLeftJustify;
  LstReport.Alignments[5, 0] := taLeftJustify;
  LstReport.Alignments[6, 0] := taLeftJustify;
  LstReport.Alignments[7, 0] := taLeftJustify;
  LstReport.Alignments[8, 0] := taLeftJustify;
  LstReport.Alignments[9, 0] := taLeftJustify;
  LstReport.Alignments[10, 0] := taLeftJustify;
  LstReport.Alignments[11, 0] := taLeftJustify;
  LstReport.Alignments[12, 0] := taLeftJustify;
  LstReport.Alignments[13, 0] := taLeftJustify;
  LstReport.Alignments[14, 0] := taCenter;
  LstReport.Alignments[15, 0] := taLeftJustify;
  CbTime.Enabled := True;
end;

procedure TFrmRelLogControle.GetLogDashBoard;
begin
 TDialogMessage.ShowWaitMessage('Buscando Dados das ocorrências...',
  procedure
  Var ObjLogControleCtrl : TLogControleCtrl;
      JsonArrayRetorno   : TJsonArray;
      vErro : String;
      xLog  : Integer;
      xTotalRequisicao, xTotalAdvertencia, xTotalErro : Integer;
  Begin
    BtnRefresh.Enabled := False;
    If FdMemDashBoardRequisiscao.Active then
       FdMemDashBoardRequisiscao.EmptyDataSet;
    FdMemDashBoardRequisiscao.Close;
    If FdMemDashBoardAdvertencia.Active then
       FdMemDashBoardAdvertencia.EmptyDataSet;
    FdMemDashBoardAdvertencia.Close;
    If FdMemDashBoardErro.Active then
       FdMemDashBoardErro.EmptyDataSet;
    FdMemDashBoardErro.Close;
    ObjLogControleCtrl   := TLogControleCtrl.Create;
    JsonArrayRetorno := ObjLogControleCtrl.GetLogDashBoard;
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
       ShowErro(vErro)
    Else Begin
       xTotalRequisicao  := 0;
       xTotalAdvertencia := 0;
       xTotalErro        := 0;
       FdMemDashBoardRequisiscao.Open;
       FdMemDashBoardAdvertencia.Open;
       FdMemDashBoardErro.Open;
       For xLog := 0 to Pred(JsonArrayRetorno.Count) do Begin
         xTotalRequisicao  := xTotalRequisicao +JsonArrayRetorno.Items[xLog].GetValue<Integer>('totalreq', 0);
         xTotalAdvertencia := xTotalAdvertencia+JsonArrayRetorno.Items[xLog].GetValue<Integer>('totaladv', 0);
         xTotalErro        := xTotalErro+JsonArrayRetorno.Items[xLog].GetValue<Integer>('totalerro', 0);
         FdMemDashBoardRequisiscao.Append;
         FdMemDashBoardRequisiscao.FieldByName('Label').Value := JsonArrayRetorno.Items[xLog].GetValue<String>('hora');
         FdMemDashBoardRequisiscao.FieldByName('Value').Value := JsonArrayRetorno.Items[xLog].GetValue<Integer>('totalreq');
         FdMemDashBoardRequisiscao.FieldByName('RGB').Value   := '0, 0, 255';
         FdMemDashBoardAdvertencia.Append;
         FdMemDashBoardAdvertencia.FieldByName('Label').Value := JsonArrayRetorno.Items[xLog].GetValue<String>('hora');
         FdMemDashBoardAdvertencia.FieldByName('Value').Value := JsonArrayRetorno.Items[xLog].GetValue<Integer>('totaladv');
         FdMemDashBoardAdvertencia.FieldByName('RGB').Value   := '255, 255, 0';
         FdMemDashBoardErro.Append;
         FdMemDashBoardErro.FieldByName('Label').Value := JsonArrayRetorno.Items[xLog].GetValue<String>('hora');
         FdMemDashBoardErro.FieldByName('Value').Value := JsonArrayRetorno.Items[xLog].GetValue<Integer>('totalerro');
         FdMemDashBoardErro.FieldByName('RGB').Value   := '255, 0, 0';
       End;
       LblTotalrequisicao.Caption  := xTotalRequisicao.ToString();
       LblTotalAdvertencia.Caption := xTotalAdvertencia.ToString();
       LblTotalErro.Caption        := xTotalErro.ToString();
       FdMemDashBoardRequisiscao.First;
       FdMemDashBoardAdvertencia.First;
       FdMemDashBoardErro.First;
       ShowGrafico;
    End;
    BtnRefresh.Enabled := True;
    JsonArrayRetorno := Nil;
    FreeAndNil(ObjLogControleCtrl);
  End);
end;

procedure TFrmRelLogControle.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xLines : Integer;
begin
  LstReport.RowCount  := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  FdMemPesqGeral.First;
  xLines := 0;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xLines+1] := FdMemPesqGeral.FieldByName('idreq').AsString;
    LstReport.Cells[1, xLines+1] := FdMemPesqGeral.FieldByName('data').AsString;
    LstReport.Cells[2, xLines+1] := FdMemPesqGeral.FieldByName('hora').AsString;
    LstReport.Cells[3, xLines+1] := FdMemPesqGeral.FieldByName('nome').AsString;
    LstReport.Cells[4, xLines+1] := FdMemPesqGeral.FieldByName('terminal').AsString;
    LstReport.Cells[5, xLines+1] := FdMemPesqGeral.FieldByName('verbo').AsString;
    LstReport.Cells[6, xLines+1] := FdMemPesqGeral.FieldByName('ipclient').AsString;
    LstReport.Cells[7, xLines+1] := FdMemPesqGeral.FieldByName('port').AsString;
    LstReport.Cells[8, xLines+1] := FdMemPesqGeral.FieldByName('url').AsString;
    LstReport.Cells[9, xLines+1] := FdMemPesqGeral.FieldByName('params').AsString;
    LstReport.Cells[10, xLines+1] := FdMemPesqGeral.FieldByName('body').AsString;
    LstReport.Cells[11, xLines+1] := FdMemPesqGeral.FieldByName('responsestr').AsString;
    LstReport.Cells[12, xLines+1] := FdMemPesqGeral.FieldByName('responsejson').AsString;
    LstReport.Cells[13, xLines+1] := FdMemPesqGeral.FieldByName('respstatus').AsString;
//    LstReport.Cells[14, xLines+1] := FdMemPesqGeral.FieldByName('timeexecution').AsString;
    LstReport.Cells[14, xLines+1] := TimeToStr(FdMemPesqGeral.FieldByName('timeexecution').AsFloat);

    LstReport.Cells[15, xLines+1] := FdMemPesqGeral.FieldByName('appname').AsString;
    LstReport.Alignments[0, xLines+1] := taRightJustify;
    LstReport.FontStyles[0, xLines+1] := [FsBold];
    LstReport.Alignments[1, xLines+1] := taCenter;
    LstReport.Alignments[2, xLines+1] := taCenter;
    LstReport.Alignments[3, xLines+1] := taLeftJustify;
    LstReport.Alignments[4, xLines+1] := taLeftJustify;
    LstReport.Alignments[5, xLines+1] := taLeftJustify;
    LstReport.Alignments[6, xLines+1] := taLeftJustify;
    LstReport.Alignments[7, xLines+1] := taLeftJustify;
    LstReport.Alignments[8, xLines+1] := taLeftJustify;
    LstReport.Alignments[9, xLines+1] := taLeftJustify;
    LstReport.Alignments[10, xLines+1] := taLeftJustify;
    LstReport.Alignments[11, xLines+1] := taLeftJustify;
    LstReport.Alignments[12, xLines+1] := taLeftJustify;
    LstReport.Alignments[13, xLines+1] := taLeftJustify;
    LstReport.Alignments[14, xLines+1] := taCenter;
    LstReport.Alignments[15, xLines+1] := taLeftJustify;
    FdMemPesqGeral.Next;
    Inc(xLines);
  End;
  inherited;
end;

procedure TFrmRelLogControle.PesquisarDados;
Var JsonArrayRetorno   : tJsonArray;
    vErro              : String;
    ObjLogControleCtrl : TLogControleCtrl;
    vDataInicio, vDataTermino : TDateTime;
    vSomenteErro       : Integer;
begin
  inherited;
  Limpar;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  TDialogMessage.ShowWaitMessage('Buscando Dados dos Log'+#39+'s...',
  procedure
  Begin
    if (ChkLogErroOnly.Checked) then
       vSomenteErro := 1
    Else
       vSomenteErro := 0;
    if EdtInicio.Text = '  /  /    ' then
       vDataInicio := 0
    Else
       vDataInicio := StrToDate(EdtInicio.Text);
    if EdtTermino.Text = '  /  /    ' then
       vDataTermino := 0
    Else
       vDataTermino := StrToDate(EdtTermino.Text);
    ObjLogControleCtrl   := TLogControleCtrl.Create;
    JsonArrayRetorno := ObjLogControleCtrl.GetLogControle(vDataInicio, vDataTermino,
                        StrTointDef(EdtUsuarioId.Text, 0), EdtTerminal.Text, EdtRequisicao.Text, CbVerbo.ItemIndex, vSomenteErro);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
       ShowErro(vErro)
    Else Begin
       LstReport.RowCount := JsonArrayRetorno.Count+1;
       FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
    End;
    JsonArrayRetorno := Nil;
    FreeAndNil(ObjLogControleCtrl);
  End);
end;

procedure TFrmRelLogControle.ShowGrafico;
{Var ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonDashBoard0102  : TJsonObject;
    JsonDashBoard030405, JsonDashBoard06 : TJsonArray;
    xRetorno : Integer;
}Begin
TThread.Synchronize(TThread.CurrentThread, procedure
begin
  WebCharts1

  .NewProject
  .Rows
  .tag
  .add(
    WebCharts1
    .ContinuosProject
       .Charts
         ._ChartType(line)
           .Attributes
             .Name('LogReq')
             .ColSpan(12)
             .Options
               .SemiCircule(True)
             .&End
             .Heigth(180)
             .Options
                .Title
                  .fontSize(14)
                  .Text('Log de Requisições')
                .&End
             .&End
                 .DataSet
                   .textLabel('Requisição')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoardRequisiscao)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('0, 0, 255')
                 .&End
                 .DataSet
                   .textLabel('Advertencia')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoardAdvertencia)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('255, 255, 0')
                 .&End
                 .DataSet
                   .textLabel('Erro')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoardErro)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('255,0,0')
                 .&End
           .&End
         .&End
         .HTML
    )
  .&End
  .&End
  .WebBrowser(WebBrowser1)
  .Generated;
End);
{  JsonDashBoard0102   := Nil;
  JsonDashBoard030405 := Nil;
  JsonDashBoard06     := Nil;
  ObjPedidoSaidaCtrl  := Nil;
}end;

procedure TFrmRelLogControle.TabDashBoardShow(Sender: TObject);
begin
  inherited;
  WebBrowser1.Height := self.Height - (PnlDshErro.Top + PnlErro.Height+250);
  WebBrowser1.Repaint;
  GetLogDashBoard;
end;

procedure TFrmRelLogControle.TmDashBoardTimer(Sender: TObject);
begin
  inherited;
  BtnRefreshClick(BtnRefresh);
end;

end.
