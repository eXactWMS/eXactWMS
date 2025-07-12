unit uFrmRelResumoSeparacao;

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
  JvToolEdit, dxCameraControl, EnderecamentoZonaCtrl;

type
  TFrmRelResumoSeparacao = class(TFrmReportBase)
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
    FdMemPesqGeralApanhe: TIntegerField;
    FdMemPesqGeralInicio: TTimeField;
    FdMemPesqGeralTermino: TTimeField;
    FdMemPesqGeralHoraTrabalhada: TStringField;
    FdMemPesqGeralUnidadePorHora: TIntegerField;
    FdMemPesqGeralVolumePorHora: TIntegerField;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdtMeta: TEdit;
    EdtTolerancia: TEdit;
    FdMemPesqGeralMeta: TIntegerField;
    FdMemPesqGeralTolerancia: TIntegerField;
    Label5: TLabel;
    Label8: TLabel;
    LblTotalVolumes: TLabel;
    LbltotalDemanda: TLabel;
    Label9: TLabel;
    LblTotalSeparacao: TLabel;
    GbPeriodoPedido: TGroupBox;
    Label10: TLabel;
    Label13: TLabel;
    EdtInicioPedido: TJvDateEdit;
    EdtTerminoPedido: TJvDateEdit;
    Bevel1: TBevel;
    GroupBox15: TGroupBox;
    Label24: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZonaVolume: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInicioProducaoChange(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesqUsuarioClick(Sender: TObject);
    procedure BtnPesqZonaVolumeClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
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
  FrmRelResumoSeparacao: TFrmRelResumoSeparacao;

implementation

{$R *.dfm}

Uses Views.Pequisa.Processos, uFuncoes, ProcessoCtrl, UsuarioCtrl, Vcl.DialogMessage,
  PedidoVolumeSeparacaoCtrl, Views.Pequisa.Usuarios, Views.Pequisa.EnderecamentoZonas;

procedure TFrmRelResumoSeparacao.BtnPesqUsuarioClick(Sender: TObject);
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

procedure TFrmRelResumoSeparacao.BtnPesqZonaVolumeClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelResumoSeparacao.BtnPesqProcessoClick(Sender: TObject);
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

procedure TFrmRelResumoSeparacao.EdtInicioProducaoChange(Sender: TObject);
begin
  inherited;
  if sender = EdtUsuarioId  then Lblusuario.Caption := '';
  if Sender = EdtProcessoId then LblProcesso.Caption := '';
  if (Sender = EdtInicioPedido) or (Sender = EdtTerminoPedido) then
     GbPeriodoProducao.Enabled := (EdtInicioPedido.Text = '  /  /    ') and (EdtTerminoPedido.Text='  /  /    ');
  if (Sender = EdtInicioProducao) or (Sender = EdtTerminoProducao) then
     GbPeriodoPedido.Enabled := (EdtInicioProducao.Text = '  /  /    ') and (EdtTerminoProducao.Text='  /  /    ');

  LimparLstAdvReport;
  Limpar;
end;

procedure TFrmRelResumoSeparacao.EdtProcessoIdExit(Sender: TObject);
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

procedure TFrmRelResumoSeparacao.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
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

procedure TFrmRelResumoSeparacao.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '';
  Limpar;
end;

procedure TFrmRelResumoSeparacao.EdtZonaIdExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblZona.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblZona.Caption := '';
     ShowErro( '😢Código de Zona('+TEdit(Sender).Text+') inválido!' );
     ExitFocus(Sender);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  JsonArrayZona := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(TEdit(Sender).Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Erro : '+vErro);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ExitFocus(Sender);
  End
  Else
     LblZona.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonArrayZona := Nil;
  ObjEnderecamentoZonaCtrl.Free;
end;

Procedure TFrmRelResumoSeparacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelResumoSeparacao := Nil;
end;

procedure TFrmRelResumoSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 100+Trunc(100*ResponsivoVideo);
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.ColWidths[1]  :=  50+Trunc(50*ResponsivoVideo);
  LstReport.ColWidths[2]  := 180+Trunc(180*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[5]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[6]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[7]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[8]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[9]  :=  85+Trunc(85*ResponsivoVideo);
  LstReport.ColWidths[10] :=  70+Trunc(70*ResponsivoVideo);
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

procedure TFrmRelResumoSeparacao.Imprimir;
begin
  inherited;

end;

procedure TFrmRelResumoSeparacao.ImprimirRelatorios;
begin

end;

procedure TFrmRelResumoSeparacao.Limpar;
begin
  inherited;
  EdtMeta.Clear;
  EdtTolerancia.Clear;
  LblTotalVolumes.Caption   := '0';
  LbltotalDemanda.Caption   := '0';
  LblTotalSeparacao.Caption := '0';
end;

procedure TFrmRelResumoSeparacao.LimparLstAdvReport;
begin
  inherited;
end;

procedure TFrmRelResumoSeparacao.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelResumoSeparacao.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xRetorno : Integer;
    vTotalVolumes,
    vTotalDemanda,
    vTotalSeparacao : Integer;
begin
  inherited;
  vTotalVolumes   := 0;
  vTotalDemanda   := 0;
  vTotalSeparacao := 0;
  LstReport.RowCount       := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRetorno := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRetorno] := FdMemPesqGeral.FieldByName('data').AsString;
    LstReport.Cells[1, xRetorno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString;
    LstReport.Cells[2, xRetorno] := FdMemPesqGeral.FieldByName('nome').AsString;
    LstReport.Cells[3, xRetorno] := FdMemPesqGeral.FieldByName('QtdVolume').AsString;
    LstReport.Cells[4, xRetorno] := FdMemPesqGeral.FieldByName('demanda').AsString;
    LstReport.Cells[5, xRetorno] := FdMemPesqGeral.FieldByName('apanhe').AsString;
    vTotalVolumes   := vTotalVolumes + FdMemPesqGeral.FieldByName('QtdVolume').AsInteger;
    vTotalDemanda   := vTotalDemanda + FdMemPesqGeral.FieldByName('Demanda').AsInteger;
    vTotalSeparacao := vTotalSeparacao + FdMemPesqGeral.FieldByName('Apanhe').AsInteger;;
    if FdMemPesqGeral.FieldByName('demanda').AsInteger = FdMemPesqGeral.FieldByName('apanhe').AsInteger then
       LstReport.Colors[5, xRetorno] := ClGreen
    Else if FdMemPesqGeral.FieldByName('demanda').AsInteger > FdMemPesqGeral.FieldByName('apanhe').AsInteger then
       LstReport.Colors[5, xRetorno] := ClYellow
    Else if FdMemPesqGeral.FieldByName('demanda').AsInteger > FdMemPesqGeral.FieldByName('apanhe').AsInteger then
       LstReport.Colors[5, xRetorno] := ClRed;
    LstReport.FontStyles[5, xRetorno] := [fsBold];
    LstReport.Cells[6, xRetorno] := Copy(FdMemPesqGeral.FieldByName('inicio').AsString, 1, 8);
    LstReport.Cells[7, xRetorno] := Copy(FdMemPesqGeral.FieldByName('Termino').AsString, 1, 8);
    LstReport.Cells[8, xRetorno] := FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString;
    FdMemPesqGeral.Edit;
    FdMemPesqGeral.FieldByName('VolumePorHora').AsInteger  := CalcUnidHr(FdMemPesqGeral.FieldByName('QtdVolume').AsInteger, FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString );
    FdMemPesqGeral.FieldByName('UnidadePorHora').AsInteger := CalcUnidHr(FdMemPesqGeral.FieldByName('Apanhe').AsInteger, FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString );
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
    LstReport.Alignments[9, xRetorno] := taRightJustify;
    LstReport.Alignments[10, xRetorno] := taRightJustify;
    FdMemPesqGeral.Next;
    Inc(xRetorno);
  End;
  LblTotalVolumes.Caption   := vTotalVolumes.ToString;
  LblTotalDemanda.Caption   := vTotalDemanda.ToString;
  LblTotalSeparacao.Caption := vTotalSeparacao.ToString;
end;

procedure TFrmRelResumoSeparacao.PesquisarDados;
Var vErro   : String;
    pProcessoId      : Integer;
    JsonArrayRetorno : TJsonArray;
    vDataInicialPedido, vDataFinalPedido     : TDateTime;
    vDataInicialProducao, vDataFinalProducao : TDateTime;
    ObjVolumeSeparacaoCtrl    : TVolumeSeparacaoCtrl;
begin
  inherited;
  if (EdtInicioPedido.Text = '  /  /    ') and (EdtTerminoPedido.Text = '  /  /    ') and
     (EdtInicioProducao.Text = '  /  /    ') and (EdtInicioProducao.Text = '  /  /    ')then Begin
     ShowErro('Informe um período para gerar o Relatório!');
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
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
    begin
      ObjVolumeSeparacaoCtrl := TVolumeSeparacaoCtrl.Create;
      //JsonArrayRetorno := ObjVolumeSeparacaoCtrl.GetResumoSeparacao(vDataInicialPedido, vDataFinalPedido, vDataInicialProducao, vDataFinalProducao, StrToIntDef(EdtusuarioId.Text, 0), 7);//StrToIntDef(EdtProcessoId.Text, 0));
      JsonArrayRetorno := ObjVolumeSeparacaoCtrl.GetDSHSeparacao(vDataInicialPedido, vDataFinalPedido, vDataInicialProducao, vDataFinalProducao, StrToIntDef(EdtusuarioId.Text, 0), StrToIntDef(EdtZonaId.Text, 0));
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         JsonArrayRetorno := Nil;
         ShowErro('😢Erro: '+vErro);
         LimparLstAdvReport
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdmemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
        FdmemPesqGeral.Open;
        //LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
      End;
      JsonArrayRetorno := Nil;
      ObjVolumeSeparacaoCtrl.Free;
    End);
end;

end.
