unit uFrmDshRecebimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, DataSet.Serialize,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, System.JSON, REST.Json, Rest.Types,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf, Math,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, Vcl.OleCtrls, SHDocVw, EntradaCtrl;

type
  TFrmDshRecebimentos = class(TFrmReportBase)
    GbDtPedido: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GbAtualizarDsh: TGroupBox;
    CbTime: TComboBox;
    GbDshPanel: TPanel;
    Label25: TLabel;
    Panel5: TPanel;
    Shape7: TShape;
    Label9: TLabel;
    LblTotCheckIn: TLabel;
    Image1: TImage;
    LblPercCheckin: TLabel;
    Panel6: TPanel;
    Shape8: TShape;
    Label10: TLabel;
    LblTotDevolucao: TLabel;
    LblPercDevolucao: TLabel;
    Image2: TImage;
    Panel1: TPanel;
    Shape9: TShape;
    Label11: TLabel;
    LblTotSegregado: TLabel;
    LblPercSegregado: TLabel;
    Image3: TImage;
    PnlPendencia: TPanel;
    Shape1: TShape;
    Label12: TLabel;
    LblTotPendencia: TLabel;
    LblPercPendente: TLabel;
    Image4: TImage;
    PnlDemanda: TPanel;
    Shape2: TShape;
    Label4: TLabel;
    LblTotDemanda: TLabel;
    Image5: TImage;
    PnlWebBrowser: TPanel;
    WebBrowser1: TWebBrowser;
    PnlCancelado: TPanel;
    Shape3: TShape;
    Label5: TLabel;
    LblTotCancelado: TLabel;
    lblPercCancelado: TLabel;
    Image6: TImage;
    PnlPedidos: TPanel;
    Label8: TLabel;
    PnlPedidoPendencia: TPanel;
    Shape10: TShape;
    Label22: TLabel;
    LblTotPedidoPendente: TLabel;
    LblPercPedPendente: TLabel;
    Image10: TImage;
    PntPedidoDemanda: TPanel;
    Shape11: TShape;
    Label26: TLabel;
    LblTotPedidoDemanda: TLabel;
    Image11: TImage;
    PnlPedidoCancelado: TPanel;
    Shape12: TShape;
    Label28: TLabel;
    LblTotPedidoCancelado: TLabel;
    LblPercPedCancelado: TLabel;
    Image12: TImage;
    LstCheckInUsuario: TAdvStringGrid;
    GbDtProducao: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    EdtProducaoInicial: TJvDateEdit;
    EdtProducaoFinal: TJvDateEdit;
    Bevel1: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EdtTolerancia: TEdit;
    EdtMeta: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowGraphic;
    Procedure ShowUserCheckIn;
    procedure ThreadTerminate(Sender: TObject);
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmDshRecebimentos: TFrmDshRecebimentos;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS;

procedure TFrmDshRecebimentos.EdtInicioChange(Sender: TObject);
begin
  inherited;
  GbDtPedido.Enabled   := (EdtProducaoInicial.Text = '  /  /    ') and (EdtProducaoInicial.Text = '  /  /    ');
  GbDtProducao.Enabled := (EdtInicio.Text = '  /  /    ') and (EdtTermino.Text = '  /  /    ');
  PnlPedidos.Visible   := GbDtPedido.Enabled;
end;

procedure TFrmDshRecebimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmDshRecebimentos := Nil;
end;

procedure TFrmDshRecebimentos.FormCreate(Sender: TObject);
begin
  inherited;
//  WebBrowser1.Top   := GbDshPanel.Top+GbDshPanel.Height+20;
//  WebBrowser1.Align := AlBottom;
end;

procedure TFrmDshRecebimentos.Limpar;
begin
  inherited;
  CbTime.ItemIndex              := 7;
  LblTotPedidoDemanda.Caption   := '0';
  LblTotPedidoCancelado.Caption := '0';
  LblTotPedidoPendente.Caption  := '0';
  LblPercPedCancelado.Caption   := '0';
  LblPercPedPendente.Caption    := '0';
  LblTotDemanda.Caption         := '0';
  LblTotCheckIn.Caption         := '0';
  LblTotDevolucao.Caption       := '0';
  LblTotSegregado.Caption       := '0';
  LblTotCancelado.Caption       := '0';
  LblTotPendencia.Caption       := '0';
  LblPercCheckin.Caption        := '0';
  LblPercDevolucao.Caption      := '0';
  LblPercSegregado.Caption      := '0';
  lblPercCancelado.Caption      := '0';
  LblPercPendente.Caption       := '0';

  LstCheckInUsuario.ColWidths[ 0] :=  80+Trunc(80*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 1] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 2] := 250+Trunc(250*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 3] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 4] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 5] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 6] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 7] := 100+Trunc(100*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 8] := 100+Trunc(100*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[ 9] := 100+Trunc(100*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[10] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.ColWidths[11] :=  60+Trunc(60*ResponsivoVideo);
  LstCheckInUsuario.Alignments[ 0, 0] := taRightJustify;
  LstCheckInUsuario.FontStyles[ 0, 0] := [FsBold];
  LstCheckInUsuario.Alignments[ 1, 0] := taRightJustify;
  LstCheckInUsuario.Alignments[ 3, 0] := taRightJustify;
  LstCheckInUsuario.FontStyles[ 3, 0] := [FsBold];
  LstCheckInUsuario.Alignments[ 4, 0] := taRightJustify;
  LstCheckInUsuario.Alignments[ 5, 0] := taRightJustify;
  LstCheckInUsuario.Alignments[ 6, 0] := taRightJustify;
  LstCheckInUsuario.Alignments[ 7, 0] := taCenter;
  LstCheckInUsuario.Alignments[ 8, 0] := taCenter;
  LstCheckInUsuario.Alignments[ 9, 0] := taCenter;
  LstCheckInUsuario.Alignments[10, 0] := taRightJustify;
  LstCheckInUsuario.Alignments[11, 0] := taRightJustify;
  EdtMeta.Text       := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInMeta.ToString();
  EdtTolerancia.Text := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInTolerancia.ToString();
end;

procedure TFrmDshRecebimentos.PesquisarDados;
Var ObjEntradaCtrl : TEntradaCtrl;
    JsonArrayRecebimento : TJsonArray;
    vErro : String;
    vRecebimentoInicial, vRecebimentoFinal : TDateTime;
    vProducaoInicial, vProducaoFinal       : TDateTime;
begin
  inherited;
  vRecebimentoInicial := 0;
  vRecebimentoFinal   := 0;
  vProducaoInicial    := 0;
  vProducaoFinal      := 0;
  if (EdtInicio.Text = '  /  /    ') and (EdtTermino.Text = '  /  /    ') and
     (EdtProducaoInicial.Text = '  /  /    ') and (EdtProducaoFinal.Text = '  /  /    ')then Begin
     ShowErro('Informe o período para gerar o Dashboard.');
     Exit;
  End;
  Try
    if EdtInicio.Text <> '  /  /    ' then
       vRecebimentoInicial := StrToDate(EdtInicio.Text);
  Except
    ShowErro('Data Documento Inicial inválida');
    EdtInicio.SetFocus;
    Exit;
  End;
  Try
    if EdtTermino.Text <> '  /  /    ' then
       vRecebimentoFinal := StrToDate(EdtTermino.Text);
  Except
    ShowErro('Data Documento Final inválida');
    EdtTermino.SetFocus;
    Exit;
  End;
  Try
    if EdtProducaoInicial.Text <> '  /  /    ' then
       vProducaoInicial := StrToDate(EdtProducaoInicial.Text);
  Except
    ShowErro('Data Produção Inicial inválida');
    EdtInicio.SetFocus;
    Exit;
  End;
  Try
    if EdtProducaoFinal.Text <> '  /  /    ' then
       vProducaoFinal := StrToDate(EdtProducaoFinal.Text);
  Except
    ShowErro('Data Produção Final inválida');
    EdtTermino.SetFocus;
    Exit;
  End;
  if vRecebimentoInicial > vRecebimentoFinal then Begin
    ShowErro('Período de Recebimento inválido para gerar o Dashboard.');
    EdtInicio.SetFocus;
    Exit;
  End;
  if vProducaoInicial > vProducaoFinal then Begin
    ShowErro('Período de Produção inválido para gerar o Dashboard.');
    EdtInicio.SetFocus;
    Exit;
  End;
  Try
    ObjEntradaCtrl := TEntradaCtrl.Create;
    JsonArrayRecebimento := ObjEntradaCtrl.GetRelDshRecebimentos(vRecebimentoInicial, vRecebimentoFinal,
                                                                 vProducaoInicial, vProducaoFinal);
    if JsonArrayRecebimento.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Erro: '+vErro);
    End
    Else if JsonArrayRecebimento.Items[0].TryGetValue('MSG', vErro) then Begin
       ShowMSG(vErro);
    End
    Else Begin
      If FdMemPesqGeral.Active then
         FdMemPesqGeral.EmptyDataSet;
      FdMemPesqGeral.Close;
      FdMemPesqGeral.LoadFromJSON(JsonArrayRecebimento, False);
      If FdMemPesqGeral.FieldByName('TotPedido').AsInteger > 0 then
         ShowGraphic
      Else
         ShowMSG('Não há dados nesse período!');;
    End;
  Except On E: Exception do Begin
    JsonArrayRecebimento := Nil;
    FreeAndNil(ObjEntradaCtrl);
    End;
  End;
end;

procedure TFrmDshRecebimentos.ShowGraphic;
Var Th : TThread;
    vDataInicial, vDataFinal : TDateTime;
begin
  Th := TThread.CreateAnonymousThread(procedure
     begin
       While Not FdMemPesqGeral.Eof do Begin
         TThread.Synchronize(TThread.CurrentThread, procedure
         begin
           LblTotPedidoDemanda.Caption   := FdMemPesqGeral.FieldByName('TotPedido').AsString;
           LblTotPedidoCancelado.Caption := FdMemPesqGeral.FieldByName('PedCancelado').AsString;
           LblPercPedCancelado.Caption   := RoundTo(FdMemPesqGeral.FieldByName('PedCancelado').AsInteger / FdMemPesqGeral.FieldByName('TotPedido').AsInteger * 100, -2).ToString+'%';
           LblTotPedidoPendente.Caption  := FdMemPesqGeral.FieldByName('PedPendente').AsString;
           LblPercPedPendente.Caption    := RoundTo(FdMemPesqGeral.FieldByName('PedPendente').AsInteger / FdMemPesqGeral.FieldByName('TotPedido').AsInteger * 100, -2).ToString+'%';
           LblTotDemanda.Caption         := FdMemPesqGeral.FieldByName('QtdXml').AsString;
           LblTotCheckIn.Caption         := FdMemPesqGeral.FieldByName('QtdCheckIn').AsString;
           LblPercCheckin.Caption        := RoundTo(FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotDevolucao.Caption       := FdMemPesqGeral.FieldByName('QtdDevolvida').AsString;
           LblPercDevolucao.Caption      := RoundTo(FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotSegregado.Caption       := FdMemPesqGeral.FieldByName('QtdSegregada').AsString;
           LblPercSegregado.Caption      := RoundTo(FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotCancelado.Caption       := FdMemPesqGeral.FieldByName('QtdCancelado').AsString;
           LblPercCancelado.Caption      := RoundTo(FdMemPesqGeral.FieldByName('QtdCancelado').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotPendencia.Caption       := (FdMemPesqGeral.FieldByName('QtdXml').AsInteger -
                                            (FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger+
                                             FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+
                                             FdMemPesqGeral.FieldByName('QtdSegregada').Asinteger)).ToString;
           LblPercPendente.Caption  := RoundTo((FdMemPesqGeral.FieldByName('QtdXml').AsInteger -
                                              (FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger+
                                               FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+
                                               FdMemPesqGeral.FieldByName('QtdSegregada').Asinteger)) / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
         End);
         FdMemPesqGeral.Next;
       End;
       ShowUserCheckIn;
     End);
  Th.OnTerminate := ThreadTerminate;
  Th.Start;
end;

procedure TFrmDshRecebimentos.ShowUserCheckIn;
Var ObjEntradaUserCheckInCtrl : TEntradaCtrl;
    JsonArrayUserCheckIn : TJsonArray;
    vErro : String;
    xUser : Integer;
    vRecebimentoInicial, vRecebimentoFinal : TDateTime;
    vProducaoInicial,    vProducaoFinal    : TDateTime;
    vMinHora, vMaxHora : String;
    vQtdCheckIn, vQtdCaixa : Integer;
begin
  vRecebimentoInicial := 0;
  vRecebimentoFinal   := 0;
  vProducaoInicial    := 0;
  vProducaoFinal      := 0;
  if EdtInicio.Text <> '  /  /    ' then
     vRecebimentoInicial := StrToDate(EdtInicio.Text);
  if EdtTermino.Text <> '  /  /    ' then
     vRecebimentoFinal   := StrToDate(EdtTermino.Text);
  if EdtProducaoInicial.Text <> '  /  /    ' then
     vProducaoInicial    := StrToDate(EdtProducaoInicial.Text);
  if EdtProducaoFinal.Text <> '  /  /    ' then
     vProducaoFinal      := StrToDate(EdtProducaoFinal.Text);
  ObjEntradaUserCheckInCtrl := TEntradaCtrl.Create;
  JsonArrayUserCheckIn := ObjEntradaUserCheckInCtrl.GetDshCheckIn(vRecebimentoInicial, vRecebimentoFinal,
                                                                  vProducaoInicial, vProducaoFinal);
  if JsonArrayUserCheckIn.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
  End
  Else Begin
    LstCheckInUsuario.RowCount := JsonArrayUserCheckIn.Count+1;
    for xUser := 0 to Pred(JsonArrayUserCheckIn.Count) do Begin
      LstCheckInUsuario.Cells[0, xUser+1] := DateEUAToBr(JsonArrayUserCheckIn.Items[xUser].GetValue<String>('data'));
      LstCheckInUsuario.Cells[1, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('usuarioid').ToString();
      LstCheckInUsuario.Cells[2, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<String>('nome');
      LstCheckInUsuario.Cells[3, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtdcheckin').ToString();
      LstCheckInUsuario.Cells[4, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtddevolvida').ToString();
      LstCheckInUsuario.Cells[5, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtdsegregada').ToString();
      LstCheckInUsuario.Cells[6, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtdcaixa').ToString();
      vMinHora := JsonArrayUserCheckIn.Items[xUser].GetValue<String>('minhora');
      vMaxHora := JsonArrayUserCheckIn.Items[xUser].GetValue<String>('maxhora');
      LstCheckInUsuario.Cells[7, xUser+1] := Copy(vMinHora, 9, 2)+'/'+Copy(vMinHora, 6, 2)+'/'+Copy(vMinHora, 1, 4)+' '+Copy(vMinHora, 12, 5)+'h';
      LstCheckInUsuario.Cells[8, xUser+1] := Copy(vMaxHora, 9, 2)+'/'+Copy(vMaxHora, 6, 2)+'/'+Copy(vMaxHora, 1, 4)+' '+Copy(vMaxHora, 12, 5)+'h';
      LstCheckInUsuario.Cells[9, xUser+1] := JsonArrayUserCheckIn.Items[xUser].GetValue<String>('horatrabalho')+'h';
      vQtdCheckIn := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtdcheckin')+
                     JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtddevolvida')+
                     JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtdsegregada');
      if JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('calchora') = 1 then
         vQtdCheckIn := CalcUnidHr(vQtdCheckIn, JsonArrayUserCheckIn.Items[xUser].GetValue<String>('horatrabalho'));
      LstCheckInUsuario.Cells[10, xUser+1] := vQtdCheckIn.ToString;
      if vQtdCheckIn >= STrToIntDef(EdtMeta.Text, 0) then
         LstCheckInUsuario.Colors[10, xUser+1] := clGreen
      Else if vQtdCheckIn >= STrToIntDef(EdtTolerancia.Text, 0) then
         LstCheckInUsuario.Colors[10, xUser+1] := clYellow
      Else
         LstCheckInUsuario.Colors[10, xUser+1] := clRed;
      LstCheckInUsuario.FontStyles[10, xUser+1] := [fsBold];

      vQtdCaixa := JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('qtdcaixa');
      if JsonArrayUserCheckIn.Items[xUser].GetValue<Integer>('calchora') = 1 then
         vQtdCaixa := CalcUnidHr(vQtdCaixa, JsonArrayUserCheckIn.Items[xUser].GetValue<String>('horatrabalho'));
      LstCheckInUsuario.Cells[11, xUser+1] := vQtdCaixa.ToString();
      if vQtdCaixa >= STrToIntDef(EdtMeta.Text, 0) then
         LstCheckInUsuario.Colors[11, xUser+1] := clGreen
      Else if vQtdCaixa >= STrToIntDef(EdtTolerancia.Text, 0) then
         LstCheckInUsuario.Colors[11, xUser+1] := clYellow
      Else
         LstCheckInUsuario.Colors[11, xUser+1] := clRed;
      LstCheckInUsuario.FontStyles[11, xUser+1] := [fsBold];
      LstCheckInUsuario.Alignments[ 0, xUser+1] := taRightJustify;
      LstCheckInUsuario.FontStyles[ 0, xUser+1] := [FsBold];
      LstCheckInUsuario.Alignments[ 1, xUser+1] := taRightJustify;
      LstCheckInUsuario.Alignments[ 3, xUser+1] := taRightJustify;
      LstCheckInUsuario.FontStyles[ 3, xUser+1] := [FsBold];
      LstCheckInUsuario.Alignments[ 4, xUser+1] := taRightJustify;
      LstCheckInUsuario.Alignments[ 5, xUser+1] := taRightJustify;
      LstCheckInUsuario.Alignments[ 6, xUser+1] := taRightJustify;
      LstCheckInUsuario.Alignments[ 7, xUser+1] := taCenter;
      LstCheckInUsuario.Alignments[ 8, xUser+1] := taCenter;
      LstCheckInUsuario.Alignments[ 9, xUser+1] := taCenter;
      LstCheckInUsuario.Alignments[10, xUser+1] := taRightJustify;
      LstCheckInUsuario.Alignments[11, xUser+1] := taRightJustify;
    End;
  End;
  JsonArrayUserCheckIn := Nil;
  FreeAndNil(ObjEntradaUserCheckInCtrl);
end;

procedure TFrmDshRecebimentos.ThreadTerminate(Sender: TObject);
begin
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowErro(Exception(TThread(sender).FatalException).Message);
    end;
  end;
end;

end.
