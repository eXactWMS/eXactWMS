unit uFrmRelCaixaEmbalagemRastreamento;

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
  dxCameraControl, acPNG, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, DataSet.Serialize, Vcl.DialogMessage,
  Generics.Collections, System.Json, Rest.Types, JvBaseEdits, cxClasses,
  cxCustomData, cxStyles, cxEdit, cxCustomPivotGrid, cxDBPivotGrid;

type
  TFrmRelCaixaEmbalagemRastreamento = class(TFrmReportBase)
    GroupBox14: TGroupBox;
    Label45: TLabel;
    Label46: TLabel;
    EdtDtPedidoInicial: TJvDateEdit;
    EdtDtPedidoFinal: TJvDateEdit;
    GroupBox12: TGroupBox;
    Label25: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatarioId: TEdit;
    BtnPesqDestinatario: TBitBtn;
    GroupBox11: TGroupBox;
    Label23: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnProcesso: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EdtNumSequenciaCxaInicial: TEdit;
    Label3: TLabel;
    EdtNumSequenciaCxaFinal: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdtCaixaTotal: TJvCalcEdit;
    EdtCaixaLoja: TJvCalcEdit;
    EdtCaixaDisponivel: TJvCalcEdit;
    EdtCaixaInativa: TJvCalcEdit;
    FdMemPesqGeralEmbalagemId: TIntegerField;
    FdMemPesqGeralNumSequencia: TIntegerField;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralDocumentoData: TDateField;
    FdMemPesqGeralCodPessoaERP: TIntegerField;
    FdMemPesqGeralFantasia: TStringField;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralDtProcesso: TDateField;
    FdMemPesqGeralSituacao: TStringField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralIdentificacao: TStringField;
    TabCuboRastreamento: TcxTabSheet;
    cxDBPivotGrid1: TcxDBPivotGrid;
    pvEmbalagemId: TcxDBPivotGridField;
    pvNumSequencia: TcxDBPivotGridField;
    pvPedidoId: TcxDBPivotGridField;
    PvDocumentoData: TcxDBPivotGridField;
    pvCodPessoaERP: TcxDBPivotGridField;
    pvFantasia: TcxDBPivotGridField;
    pvSituacao: TcxDBPivotGridField;
    PvDescricao: TcxDBPivotGridField;
    pvIdentificacao: TcxDBPivotGridField;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    pvPedidoVolumeId: TcxDBPivotGridField;
    FdMemPesqGeralTCaixa: TIntegerField;
    pvTCaixa: TcxDBPivotGridField;
    FdMemPesqGeralRota: TStringField;
    GroupBox9: TGroupBox;
    Label19: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    pcRota: TcxDBPivotGridField;
    procedure BtnProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure EdtDtPedidoInicialChange(Sender: TObject);
    procedure EdtDestinatarioIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDestinatarioIdExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqDestinatarioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaListaRastreamento;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelCaixaEmbalagemRastreamento: TFrmRelCaixaEmbalagemRastreamento;

implementation

{$R *.dfm}

uses uFrmeXactWMS, uFuncoes, Views.Pequisa.Processos, ProcessoCtrl, PessoaCtrl, Views.Pequisa.Pessoas,
  EmbalagemCaixaCtrl, Views.Pequisa.Rotas, RotaCtrl;

procedure TFrmRelCaixaEmbalagemRastreamento.BtnPesqDestinatarioClick(
  Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
   if ((Sender=BtnPesqDestinatario) and (EdtDestinatarioId.ReadOnly)) then Exit;
   FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatarioId.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioIdExit(EdtDestinatarioId);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.BtnPesqRotaClick(
  Sender: TObject);
begin
  inherited;
  if ((Sender=BtnPesqRota) and (EdtRotaId.ReadOnly))  then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       EdtRotaId.Text := FrmPesquisaRotas.Tag.ToString();
       EdtRotaIdExit(EdtRotaId);
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.BtnProcessoClick(
  Sender: TObject);
begin
  inherited;
   if ((Sender=BtnProcesso) and (EdtProcessoId.ReadOnly)) then Exit;
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

procedure TFrmRelCaixaEmbalagemRastreamento.EdtDestinatarioIdExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(TEdit(Sender).text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     if Sender = EdtDestinatarioId then
        LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia');
  ReturnjsonArray := Nil;
  FreeAndNil(ObjPessoaCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelCaixaEmbalagemRastreamento.EdtDestinatarioIdKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelCaixaEmbalagemRastreamento.EdtDtPedidoInicialChange(
  Sender: TObject);
begin
  inherited;
  Limpar;
  if Sender = EdtDestinatarioId then
     LblDestinatario.Caption := ''
  Else If Sender = EdtProcessoId then
     LblProcesso.Caption := '';
end;

procedure TFrmRelCaixaEmbalagemRastreamento.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  LblProcesso.Caption := '';
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Processo('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjProcessoCtrl  := TProcessoCtrl.Create;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(TEdit(Sender).text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     ShowErro( '😢Processo não('+TEdit(Sender).Text+') encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     if Sender = EdtProcessoId then
        LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjProcessoCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelCaixaEmbalagemRastreamento.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblRota.Caption := '';
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     ShowErro( '😢Rota('+TEdit(Sender).Text+') inválida!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     ShowErro('Rota não encontrada!');
     TEdit(Sender).Clear;
  end
  Else Begin
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  End;
  ReturnLstRota := Nil;
  FreeAndNil(ObjRotaCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelCaixaEmbalagemRastreamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelCaixaEmbalagemRastreamento := Nil;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.FormCreate(Sender: TObject);
Var ObjEmbalagemCaixaCtrl : TCaixaEmbalagemCtrl;
    JsonArrayRetorno      : TJsonArray;
    xTotal : integer;
    vErro  : String;
begin
  inherited;
  LstReport.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[1]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[2]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[5]  := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[6]  := 200+Trunc(200*ResponsivoVideo);
  LstReport.ColWidths[7]  := 110+Trunc(110*ResponsivoVideo);
  LstReport.ColWidths[8]  := 180+Trunc(180*ResponsivoVideo);
  LstReport.ColWidths[9]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[2, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taCenter;
  LstReport.Alignments[4, 0]  := taRightJustify;
  EdtCaixaDisponivel.Text := '0';
  EdtCaixaLoja.Text       := '0';
  EdtCaixaDisponivel.Text := '0';
  EdtCaixaInativa.Text    := '0';
  ObjEmbalagemCaixaCtrl := TCaixaEmbalagemCtrl.Create;
  JsonArrayRetorno      := ObjEmbalagemCaixaCtrl.GetCaixaResumo;
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then
     ShowMSG('Erro: '+vErro)
  Else Begin
     For xTotal := 0 to Pred(JsonArrayRetorno.Count) do Begin
       if JsonArrayRetorno.Items[xTotal].GetValue<String>('tipo') = 'Disponivel' then
          EdtCaixaDisponivel.Text := JsonArrayRetorno.Items[xTotal].GetValue<String>('total')
       Else if JsonArrayRetorno.Items[xTotal].GetValue<String>('tipo') = 'Inativa' then
          EdtCaixaInativa.Text := JsonArrayRetorno.Items[xTotal].GetValue<String>('total')
       Else if JsonArrayRetorno.Items[xTotal].GetValue<String>('tipo') = 'Ocupada' then
          EdtCaixaLoja.Text := JsonArrayRetorno.Items[xTotal].GetValue<String>('total')
       Else if JsonArrayRetorno.Items[xTotal].GetValue<String>('tipo') = 'Total' then
          EdtCaixaTotal.Text := JsonArrayRetorno.Items[xTotal].GetValue<String>('total');
     End;
  End;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.Imprimir;
Begin
    frxPDFExport1.Title    := 'Análise Consolidada para Cargas';
    frxPDFExport1.FileName := 'AnaliseConsolidadaCargas.Pdf';
    frxPDFExport1.ShowDialog      := False;
    frxPDFExport1.ShowProgress    := False;
    frxPDFExport1.OverwritePrompt := False;
  inherited;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.Limpar;
begin
  inherited;
  TabCuboRastreamento.TabVisible := False;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.MontaListaRastreamento;
Var xRow : Integer;
begin
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  ImprimirExportar(True);
  FdMemPesqGeral.First;
  xRow := 1;
  while Not FdMempesqGeral.Eof do Begin
    LstReport.Cells[ 0, xRow] := FdMemPesqGeral.FieldByName('NumSequencia').AsString;
    LstReport.Cells[ 1, xRow] := FdMemPesqGeral.FieldByName('PedidoVolumeId').AsString;
    LstReport.Cells[ 2, xRow] := FdMemPesqGeral.FieldByName('PedidoId').AsString;
    LstReport.Cells[ 3, xRow] := FdMemPesqGeral.FieldByName('DocumentoData').AsString;  //DateEUAtoBr(F);
    LstReport.Cells[ 4, xRow] := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[ 5, xRow] := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[ 6, xRow] := FdMemPesqGeral.FieldByName('Rota').AsString;
    LstReport.Cells[ 7, xRow] := FdMemPesqGeral.FieldByName('Situacao').AsString;
    LstReport.Cells[ 8, xRow] := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[ 9, xRow] := FdMemPesqGeral.FieldByName('Identificacao').AsString;
    LstReport.Alignments[0, xRow] := taRightJustify;
    LstReport.FontStyles[0, xRow] := [FsBold];
    LstReport.Alignments[1, xRow] := taRightJustify;
    LstReport.Alignments[2, xRow] := taRightJustify;
    LstReport.Alignments[3, xRow] := taCenter;
    LstReport.Alignments[4, xRow] := taRightJustify;
    Inc(xRow);
    FdMemPesqGeral.Next;
  End;
  TabCuboRastreamento.TabVisible := True;
end;

procedure TFrmRelCaixaEmbalagemRastreamento.PesquisarDados;
Var pDtPedidoInicial, pDtPedidoFinal : TDateTime;
    ObjEmbalagemCaixaCtrl : TCaixaEmbalagemCtrl;
    JsonArrayRetorno      : TJsonArray;
    vErro : String;
begin
  inherited;
  Limpar;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  if EdtDtPedidoInicial.Text <> '  /  /    ' then
     pDtPedidoInicial := StrToDate(EdtDtPedidoInicial.Text)
  Else
     pDtPedidoInicial := 0;
  if EdtDtPedidoFinal.Text <> '  /  /    ' then
     pDtPedidoFinal := StrToDate(EdtDtPedidoFinal.Text)
  Else
     pDtPedidoFinal := 0;
  TDialogMessage.ShowWaitMessage('Buscando Dados...',
    procedure
    begin
      ObjEmbalagemCaixaCtrl   := TCaixaEmbalagemCtrl.Create;
      JsonArrayRetorno := ObjEmbalagemCaixaCtrl.GetRastreamento(pDtPedidoInicial, pDtPedidoFinal,
                          StrToIntDef(EdtDestinatarioId.Text, 0), StrToIntDef(EdtProcessoId.Text,0), StrToIntDef(EdtRotaId.Text, 0),
                          StrToIntDef(EdtNumSequenciaCxaInicial.Text, 0), StrToIntDef(EdtNumSequenciaCxaFinal.Text, 0));
      if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
         ShowErro(vErro)
      Else if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then
         ShowMSG(vErro)
      Else Begin
         FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
         MontaListaRastreamento;
         JsonArrayRetorno := Nil;
         FreeAndNil(ObjEmbalagemCaixaCtrl);
      End;
    End);
end;

end.
