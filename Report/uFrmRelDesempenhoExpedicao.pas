unit uFrmRelDesempenhoExpedicao;

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
  JvSpin, DataSet.Serialize, Generics.Collections, System.Json, Rest.Types,
  JvToolEdit, dxCameraControl;

type
  TFrmRelDesempenhoExpedicao = class(TFrmReportBase)
    GbPeriodoProducao: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicioProducao: TJvDateEdit;
    EdtTerminoProducao: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BtnPesqUsuario: TBitBtn;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    FdMemPesqGeralData: TDateField;
    FdMemPesqGeralUsuarioId: TIntegerField;
    FdMemPesqGeralNome: TStringField;
    FdMemPesqGeralProcessoEtapaId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralQtdVolume: TIntegerField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralHoraTrabalhada: TStringField;
    FdMemPesqGeralUnidadePorHora: TIntegerField;
    FdMemPesqGeralVolumePorHora: TIntegerField;
    FdMemPesqGeralMeta: TIntegerField;
    FdMemPesqGeralTolerancia: TIntegerField;
    FdMemPesqGeralExpedido: TIntegerField;
    Label8: TLabel;
    LbltotalDemanda: TLabel;
    Label9: TLabel;
    LblTotalSeparacao: TLabel;
    Label5: TLabel;
    LblTotalVolumes: TLabel;
    GbPeriodoPedido: TGroupBox;
    Label10: TLabel;
    Label13: TLabel;
    EdtInicioPedido: TJvDateEdit;
    EdtTerminoPedido: TJvDateEdit;
    FdMemPesqGeralDataPedido: TDateField;
    GbAnalise: TGroupBox;
    RbDataPedido: TRadioButton;
    RbProducao: TRadioButton;
    GbIndiceProdutividade: TGroupBox;
    Label6: TLabel;
    EdtMeta: TEdit;
    Label7: TLabel;
    EdtTolerancia: TEdit;
    FdMemPesqGeralInicio: TDateTimeField;
    FdMemPesqGeralTermino: TDateTimeField;
    FdMemPesqGeralData2: TDateField;
    GroupBox2: TGroupBox;
    ChkCxaFechada: TCheckBox;
    ChkCxaFracionada: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInicioProducaoChange(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesqUsuarioClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure Imprimir; OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure PesquisarDados; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
    Procedure LimparLstAdvReport;
    procedure ImprimirRelatorios;
  end;

var
  FrmRelDesempenhoExpedicao: TFrmRelDesempenhoExpedicao;

implementation

{$R *.dfm}

Uses Views.Pequisa.Processos, uFuncoes, ProcessoCtrl, UsuarioCtrl, Vcl.DialogMessage,
  PedidoVolumeSeparacaoCtrl, Views.Pequisa.Usuarios;

procedure TFrmRelDesempenhoExpedicao.BtnPesqProcessoClick(Sender: TObject);
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

procedure TFrmRelDesempenhoExpedicao.BtnPesqUsuarioClick(Sender: TObject);
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

procedure TFrmRelDesempenhoExpedicao.EdtInicioProducaoChange(Sender: TObject);
begin
  inherited;
  if sender = EdtUsuarioId  then Lblusuario.Caption  := '';
  if Sender = EdtProcessoId then LblProcesso.Caption := '';
  if (Sender = EdtInicioPedido) or (Sender = EdtTerminoPedido) then
     GbPeriodoProducao.Enabled := (EdtInicioPedido.Text = '  /  /    ') and (EdtTerminoPedido.Text='  /  /    ');
  if (Sender = EdtInicioProducao) or (Sender = EdtTerminoProducao) then
     GbPeriodoPedido.Enabled := (EdtInicioProducao.Text = '  /  /    ') and (EdtTerminoProducao.Text='  /  /    ');
  RbDataPedido.Checked := GbPeriodoPedido.Enabled;
  RbProducao.Checked   := GbPeriodoProducao.Enabled;
  LimparLstAdvReport;
  Limpar;
end;

procedure TFrmRelDesempenhoExpedicao.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
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
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjProcessoCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelDesempenhoExpedicao.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl : TUsuarioCtrl;
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
  ObjUsuarioCtrl.Free;
end;

Procedure TFrmRelDesempenhoExpedicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelDesempenhoExpedicao := Nil;
end;

procedure TFrmRelDesempenhoExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 100;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.ColWidths[1]  := 50;
  LstReport.ColWidths[2]  := 180;
  LstReport.ColWidths[3]  :=  60;
  LstReport.ColWidths[4]  :=  60;
  LstReport.ColWidths[5]  :=  60;
  LstReport.ColWidths[6]  :=  135;
  LstReport.ColWidths[7]  :=  135;
  LstReport.ColWidths[8]  :=  90;
  LstReport.ColWidths[9]  :=  85;
  LstReport.ColWidths[10] :=  70;
  LstReport.Alignments[0, 0]  := taCenter;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taCenter;
  LstReport.Alignments[7, 0]  := taCenter;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
end;

procedure TFrmRelDesempenhoExpedicao.Imprimir;
begin
  inherited;

end;

procedure TFrmRelDesempenhoExpedicao.ImprimirRelatorios;
begin

end;

procedure TFrmRelDesempenhoExpedicao.Limpar;
begin
  inherited;
  EdtMeta.Clear;
  EdtTolerancia.Clear;
end;

procedure TFrmRelDesempenhoExpedicao.LimparLstAdvReport;
begin
  inherited;
end;

procedure TFrmRelDesempenhoExpedicao.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xRetorno : Integer;
    vTotalVolumes,
    vTotalDemanda,
    vTotalSeparacao : Integer;
begin
  inherited;
  LstReport.RowCount       := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRetorno := 1;
  vTotalVolumes   := 0;
  vTotalDemanda   := 0;
  vTotalSeparacao := 0;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRetorno] := FdMemPesqGeral.FieldByName('data').AsString;
    LstReport.Cells[1, xRetorno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString;
    LstReport.Cells[2, xRetorno] := FdMemPesqGeral.FieldByName('nome').AsString;
    LstReport.Cells[3, xRetorno] := FdMemPesqGeral.FieldByName('QtdVolume').AsString;
    LstReport.Cells[4, xRetorno] := FdMemPesqGeral.FieldByName('demanda').AsString;
    LstReport.Cells[5, xRetorno] := FdMemPesqGeral.FieldByName('Expedido').AsString;
    vTotalVolumes   := vTotalVolumes + FdMemPesqGeral.FieldByName('QtdVolume').AsInteger;
    vTotalDemanda   := vTotalDemanda + FdMemPesqGeral.FieldByName('Demanda').AsInteger;
    vTotalSeparacao := vTotalSeparacao + FdMemPesqGeral.FieldByName('Expedido').AsInteger;;
    if FdMemPesqGeral.FieldByName('demanda').AsInteger = FdMemPesqGeral.FieldByName('Expedido').AsInteger then
       LstReport.Colors[5, xRetorno] := ClGreen
    Else if FdMemPesqGeral.FieldByName('demanda').AsInteger > FdMemPesqGeral.FieldByName('Expedido').AsInteger then
       LstReport.Colors[5, xRetorno] := ClYellow
    Else if FdMemPesqGeral.FieldByName('demanda').AsInteger > FdMemPesqGeral.FieldByName('Expedido').AsInteger then
       LstReport.Colors[5, xRetorno] := ClRed;
    LstReport.FontStyles[5, xRetorno] := [fsBold];
    LstReport.Cells[6, xRetorno] := FdMemPesqGeral.FieldByName('inicio').AsString;//, 1, 8);
    LstReport.Cells[7, xRetorno] := FdMemPesqGeral.FieldByName('Termino').AsString;//, 1, 8);
    LstReport.Cells[8, xRetorno] := FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString;
    FdMemPesqGeral.Edit;
    FdMemPesqGeral.FieldByName('VolumePorHora').AsInteger  := CalcUnidHr(FdMemPesqGeral.FieldByName('QtdVolume').AsInteger, FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString );
    FdMemPesqGeral.FieldByName('UnidadePorHora').AsInteger := CalcUnidHr(FdMemPesqGeral.FieldByName('Expedido').AsInteger, FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString );
    FdMemPesqGeral.Post;
    LstReport.Cells[9, xRetorno] := FdMemPesqGeral.FieldByName('VolumePorHora').AsString;
    LstReport.Cells[10, xRetorno] := FdMemPesqGeral.FieldByName('UnidadeporHora').AsString;
    if FdMemPesqGeral.FieldByName('UnidadePorHora').AsInteger >= FdMemPesqGeral.FieldByName('Meta').AsInteger then
       LstReport.Colors[10, xRetorno] := ClGreen
    Else if FdMemPesqGeral.FieldByName('UnidadePorHora').AsInteger >= FdMemPesqGeral.FieldByName('Tolerancia').AsInteger then
       LstReport.Colors[10, xRetorno] := ClYellow
    Else //if FdMemPesqGeral.FieldByName('UnidadePorHora').AsInteger > FdMemPesqGeral.FieldByName('apanhe').AsInteger then
       LstReport.Colors[10, xRetorno] := ClRed;
    LstReport.FontStyles[10, xRetorno] := [fsBold];
    EdtMeta.Text       := FdMemPesqGeral.FieldByName('Meta').AsString;
    EdtTolerancia.Text := FdMemPesqGeral.FieldByName('Tolerancia').AsString;
    LstReport.Alignments[0, xRetorno]  := taRightJustify;
    LstReport.FontStyles[0, xRetorno]  := [FsBold];
    LstReport.Alignments[1, xRetorno]  := taRightJustify;
    LstReport.Alignments[3, xRetorno]  := taRightJustify;
    LstReport.Alignments[4, xRetorno]  := taRightJustify;
    LstReport.Alignments[5, xRetorno]  := taRightJustify;
    LstReport.FontStyles[5, xRetorno]  := [FsBold];
    LstReport.Alignments[6, xRetorno]  := taCenter;
    LstReport.Alignments[7, xRetorno]  := taCenter;
    LstReport.Alignments[8, xRetorno]  := taRightJustify;
    LstReport.Alignments[9, xRetorno]  := taRightJustify;
    LstReport.Alignments[10, xRetorno] := taRightJustify;
    LstReport.HideColumn(4);
    FdMemPesqGeral.Next;
    Inc(xRetorno);
  End;
  LblTotalVolumes.Caption   := vTotalVolumes.ToString;
  LblTotalDemanda.Caption   := vTotalDemanda.ToString;
  LblTotalSeparacao.Caption := vTotalSeparacao.ToString;
end;

procedure TFrmRelDesempenhoExpedicao.PesquisarDados;
Var vErro   : String;
    pProcessoId, vAnalise, vEmbalagemId      : Integer;
    JsonArrayRetorno       : TJsonArray;
    vDataInicialPedido, vDataFinalPedido     : TDateTime;
    vDataInicialProducao, vDataFinalProducao : TDateTime;
    ObjVolumeSeparacaoCtrl : TVolumeSeparacaoCtrl;
begin
  if (EdtInicioPedido.Text = '  /  /    ') and (EdtTerminoPedido.Text = '  /  /    ') and
     (EdtInicioProducao.Text = '  /  /    ') and (EdtTerminoProducao.Text = '  /  /    ') and
     (StrToIntDef(EdtUsuarioId.Text, 0) <= 0)  then Begin
     ShowErro('Informe o filtro para pesquisa!');
     Exit;
  End;
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  if EdtInicioPedido.Text = '  /  /    ' then
     vDataInicialPedido := 0
  Else vDataInicialPedido := StrToDate(EdtInicioPedido.Text);
  if EdtTerminoPedido.Text = '  /  /    ' then
     vDataFinalPedido := 0
  Else vDataFinalPedido := StrToDate(EdtTerminoPedido.Text);
  if EdtInicioProducao.Text = '  /  /    ' then
     vDataInicialProducao := 0
  Else vDataInicialProducao := StrToDate(EdtInicioProducao.Text);
  if EdtTerminoProducao.Text = '  /  /    ' then
     vDataFinalProducao := 0
  Else vDataFinalProducao := StrToDate(EdtTerminoProducao.Text);
  if (Not RbDataPedido.Checked) and (not RbProducao.Checked) then Begin
     ShowErro('Selecione o tipo de análise');
     EdtInicioProducao.SetFocus;
     Exit;
  End;
  if RbDataPedido.Checked then vAnalise := 0
  Else vAnalise := 1;
  if (not ChkCxaFechada.Checked) And (Not ChkCxaFracionada.Checked) then Begin
     ShowErro('Informe o tipo de embalagem para análise.');
     EdtInicioProducao.SetFocus;
     Exit;
  End;
  If (ChkCxaFechada.Checked) and (ChkCxaFracionada.Checked) then
     vEmbalagemId := 99
  Else if ChkCxaFechada.Checked then vEmbalagemId := 0
  Else If ChkCxaFracionada.Checked then vEmbalagemId := 1;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
    begin
      ObjVolumeSeparacaoCtrl := TVolumeSeparacaoCtrl.Create;
      JsonArrayRetorno := ObjVolumeSeparacaoCtrl.GetDesempenhoExpedicao(vDataInicialPedido, vDataFinalPedido,
                          vDataInicialProducao, vDataFinalProducao, StrToIntDef(EdtusuarioId.Text, 0), vAnalise, vEmbalagemId);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         JsonArrayRetorno := Nil;
         ShowErro('😢Erro: '+vErro);
         LimparLstAdvReport
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
//        TDataSetSerializeConfig.GetInstance.DateInputIsUTC    := False;
//        TDataSetSerializeConfig.GetInstance.DateTimeIsISO8601 := True;

        //TDataSetSerializeConfig.GetInstance.Export.FormatDateTime := 'yyyy-mm-dd  hh:nn:ss.zzz';
        FdmemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
        FdmemPesqGeral.Open;
        //LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
      End;
      JsonArrayRetorno := Nil;
      ObjVolumeSeparacaoCtrl.Free;
    End);
end;

end.
