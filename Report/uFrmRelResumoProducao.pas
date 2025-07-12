unit uFrmRelResumoProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, JvToolEdit, Vcl.StdCtrls, frxExportXLS,
  frxClass, frxExportPDF, frxExportMail, frxExportImage, frxExportHTML,
  frxDBSet, frxExportBaseDialog, frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  acPNG, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, DataSet.Serialize, Generics.Collections, System.Json, Rest.Types,
  dxCameraControl;

type
  TFrmRelResumoProducao = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    EdtUsuarioId: TEdit;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    Lblusuario: TLabel;
    BtnPesqUsuario: TBitBtn;
    FdMemPesqGeralData: TDateField;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralUsuarioId: TIntegerField;
    FdMemPesqGeralUsuario: TStringField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    Label4: TLabel;
    LblTotUnid: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EdtDtPedidoIni: TJvDateEdit;
    EdtDtPedidoFin: TJvDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure EdtProcessoIdChange(Sender: TObject);
    procedure EdtUsuarioIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure EdtDtPedidoFinExit(Sender: TObject);
    procedure EdtDtPedidoIniChange(Sender: TObject);
    procedure BtnPesqUsuarioClick(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaResumoProducao(pJsonArrayRetorno : TJsonArray);
  public
    { Public declarations }
  end;

var
  FrmRelResumoProducao: TFrmRelResumoProducao;

implementation

{$R *.dfm}

Uses Views.Pequisa.Processos, Views.Pequisa.Pessoas, FuncionalidadeClass,
  uFuncoes, ProcessoCtrl, PedidoSaidaCtrl, UsuarioCtrl, Views.Pequisa.Usuarios;

procedure TFrmRelResumoProducao.BtnPesqUsuarioClick(Sender: TObject);
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

procedure TFrmRelResumoProducao.BtnImprimirStandClick(Sender: TObject);
Var vFiltro : String;
begin
  vFiltro := 'Perído: ';
  If EdtInicio.Text <> '  /  /    ' then
     vFiltro := vFiltro+EdtInicio.Text
  Else vFiltro := vFiltro+'... a ';
  If EdtTermino.Text <> '  /  /    ' then
     vFiltro := vFiltro+EdtTermino.Text
  Else vFiltro := vFiltro+'...';
  If EdtUsuarioId.Text <> '' then
     vFiltro := vFiltro+'  Usuário: '+EdtusuarioId.Text+' '+LblUsuario.Caption;
  If EdtProcessoId.Text <> '' then
     vFiltro := vFiltro+'  Processo: '+EdtProcessoId.Text+' '+LblProcesso.Caption;
  frxReport1.Variables['vFiltro'] := QuotedStr(vFiltro);
  inherited;
end;

procedure TFrmRelResumoProducao.BtnPesqProcessoClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtProcessoId.ReadOnly then Exit;
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

procedure TFrmRelResumoProducao.BtnPesquisarStandClick(Sender: TObject);
Var vDtInicio, vDtFinal        : TDateTime;
    vDtPedidoIni, vDtPedidoFin : TDateTime;
    vErro : String;
    JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
begin
  if (EdtUsuarioId.Text<>'') and (StrToIntDef(EdtUsuarioId.Text, 0)<=0) then Begin
     EdtUsuarioId.SetFocus;
     ShowErro('Id('+EdtUsuarioId.Text+') do Usuário inválido!');
     EdtUsuarioId.Clear;
     Exit;
  End;
  if (EdtProcessoId.Text<>'') and (StrToIntDef(EdtProcessoId.Text, 0)<=0) then Begin
     EdtProcessoId.SetFocus;
     ShowErro('Id('+EdtProcessoId.Text+') do Processo inválido!');
     EdtProcessoId.Clear;
     Exit;
  End;
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial da produção inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       vDtFinal := 0
    Else vDtFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final da produção inválida!'+#13+#10+E.Message);
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período  da produção Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
//Data dos Ressuprimentos
  Try
    If EdtDtPedidoIni.Text = '  /  /    ' then
       vDtPedidoIni := 0
    Else vDtPedidoIni :=StrToDate(EdtDtPedidoIni.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial dos ressuprimentos inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtPedidoFin.Text = '  /  /    ' then
       vDtPedidoFin := 0
    Else vDtPedidoFin := StrToDate(EdtDtPedidoFin.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final da produção inválida!'+#13+#10+E.Message);
  End;
  if (vDtPedidoIni <> 0) and (vDtPedidoFin<>0) then Begin
     Try
       if StrToDate(EdtDtPedidoIni.Text) > StrToDate(EdtDtPedidoFin.Text) then
          raise Exception.Create('Período da produção Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  LblTotUnid.Caption := '';
  LimparLstAdvReport;
  ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
  JsonArrayRetorno := ObjPedidoCtrl.GetResumoProducao(vDtInicio, vDtFinal, StrToIntDef(EdtProcessoId.Text, 0), StrToIntDef(EdtUsuarioId.Text, 0), vDtPedidoIni, vDtPedidoFin);
  if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
     Player('toast4');
     LstReport.ClearRect(0, 1, LstReport.ColCount-1, LstReport.RowCount-1);
     LstReport.RowCount := 1;
  End
  Else Begin
    If FdMemPesqGeral.Active then
       FdmemPesqGeral.EmptyDataSet;
    FdMemPesqGeral.Close;
    FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
    MontaResumoProducao(JsonArrayRetorno);
  End;
  JsonArrayRetorno := Nil;
  ObjPedidoCtrl.Free;
end;

procedure TFrmRelResumoProducao.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  LblProcesso.Caption  := '';
end;

procedure TFrmRelResumoProducao.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if (EdtUsuarioId.Text<>'') and (StrToIntDef(EdtUsuarioId.Text, 0)<=0) then Begin
     EdtUsuarioId.SetFocus;
     ShowErro('Id('+EdtUsuarioId.Text+') do Usuário inválido!');
     EdtUsuarioId.Clear;
     Exit;
  End;
  inherited;
  if StrToIntDef(EdtUsuarioId.Text, 0) = 0 then Exit;
  ObjUsuarioCtrl := TUsuarioCtrl.Create;
  JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro'+vErro)
  Else
     LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
  JsonArrayRetorno := Nil;
  ObjUsuarioCtrl.Free;
end;

procedure TFrmRelResumoProducao.EdtUsuarioIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  LimparLstAdvReport;
end;

procedure TFrmRelResumoProducao.EdtDtPedidoFinExit(Sender: TObject);
begin
  inherited;
  Try
  if (EdtDtPedidoFin.Text<>'  /  /    ') and (StrToDate(EdtDtPedidoIni.Text)>StrToDate(EdtDtPedidoFin.Text)) then Begin
     ShowErro('Data('+EdtDtPedidoFin.Text+') final do(s) ressuprimento(s) é inválida!');
     EdtDtPedidoFin.Clear;
     EdtDtPedidoFin.SetFocus;
     Exit;
  End;
  Except On E: Exception do Begin
    EdtDtPedidoIni.Clear;
    EdtDtPedidoFin.Clear;
    EdtDtPedidoIni.SetFocus;
    ShowErro('Erro: Data inválida!');
    End;
  End;
end;

procedure TFrmRelResumoProducao.EdtDtPedidoIniChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelResumoProducao.EdtProcessoIdChange(Sender: TObject);
begin
  inherited;
  LblProcesso.Caption := '';
end;

procedure TFrmRelResumoProducao.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  if (EdtProcessoId.Text<>'') and (StrToIntDef(EdtProcessoId.Text, 0)<=0) then Begin
     EdtProcessoId.SetFocus;
     ShowErro('Id('+EdtProcessoId.Text+') do Processo inválido!');
     EdtProcessoId.Clear;
     Exit;
  End;
  inherited;
  if EdtProcessoId.Text = '' then Begin
     LblProcesso.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtProcessoId.Text, 0) <= 0 then Begin
     LblProcesso.Caption := '';
     Player('toast4');
     ShowErro( '😢Processo('+EdtProcessoId.Text+') inválido!' );
     EdtProcessoId.Clear;
     Exit;
  end;
  ObjProcessoCtrl  := TProcessoCtrl.Create;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(EdtProcessoId.text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     Player('toast4');
     ShowErro( '😢Processo não('+EdtProcessoId.Text+') encontrado!');
     EdtProcessoId.Clear;
  end
  Else
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  //FreeAndNil(JsonArrayRetorno);
  FreeAndNil(ObjProcessoCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelResumoProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelResumoProducao := Nil;
end;

procedure TFrmRelResumoProducao.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[1] := 70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[2] := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[3] :=  50+Trunc(50*ResponsivoVideo);
  LstReport.ColWidths[4] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[5] := 70+Trunc(70*ResponsivoVideo);
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.Alignments[1, 0] := taRightJustify;
  LstReport.Alignments[3, 0] := taRightJustify;
  LstReport.Alignments[5, 0] := taRightJustify;
end;

procedure TFrmRelResumoProducao.MontaResumoProducao(
  pJsonArrayRetorno: TJsonArray);
Var xRecno, vTotUnid : Integer;
begin
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  If LstReport.RowCount > 1 Then LstReport.FixedRows := 1;
  //LblRegistro.Caption := FormatFloat('#0', FdMemPesqGeral.RecordCount);
  xRecno   := 1;
  vTotUnid := 0;
  while Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRecno] := FdMemPesqGeral.FieldByName('Data').AsString;
    LstReport.Cells[1, xRecno] := FdMemPesqGeral.FieldByName('ProcessoId').AsString;
    LstReport.Cells[2, xRecno] := FdMemPesqGeral.FieldByName('Processo').AsString;
    LstReport.Cells[3, xRecno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString;
    LstReport.Cells[4, xRecno] := FdMemPesqGeral.FieldByName('usuario').AsString;
    LstReport.Cells[5, xRecno] := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    vTotUnid := vTotUnid + FdMemPesqGeral.FieldByName('QtdSuprida').AsInteger;
    LstReport.FontStyles[0, xRecno] := [FsBold];
    LstReport.Alignments[0, xRecno] := taRightJustify;
    LstReport.Alignments[1, xRecno] := taRightJustify;
    LstReport.Alignments[3, xRecno] := taRightJustify;
    LstReport.Alignments[5, xRecno] := taRightJustify;
    inc(xRecno);
    FdMemPesqGeral.Next;
  End;
  LblTotUnid.Caption := vTotUnid.ToString;
  ImprimirExportar(True);
end;

end.
