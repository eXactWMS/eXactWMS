unit uFrmRelEvolucaoRessuprimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections, DataSet.Serialize, System.Json,
  Rest.Types, uFrmReportBase, dxSkinsCore, dxSkinsDefaultPainters,
  dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, JvToolEdit, frxExportXLS,
  frxClass, frxExportPDF, frxExportMail, frxExportImage, frxExportHTML,
  frxDBSet, frxExportBaseDialog, frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  acPNG, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, Vcl.Samples.Gauges, dxCameraControl, EnderecamentoZonaCtrl;

type
  TFrmRelEvolucaoRessuprimentos = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    LblRegistro: TLabel;
    PnlDsh01: TPanel;
    PnlDsbDemanda: TPanel;
    Image1: TImage;
    Label9: TLabel;
    LblDshDemanda: TLabel;
    PnlDshCanceladoCortes: TPanel;
    Image3: TImage;
    Label12: TLabel;
    LblDshCanceladoCorte: TLabel;
    LblDshPercCanceladoCorte: TLabel;
    PnlDsbPendencia: TPanel;
    Image2: TImage;
    Label10: TLabel;
    LblDshPendencia: TLabel;
    LblDshPercPendencia: TLabel;
    PnlRecebido: TPanel;
    Label14: TLabel;
    LblRecebido: TLabel;
    PnlCubagem: TPanel;
    Label4: TLabel;
    LblCubagem: TLabel;
    PnlApanhe: TPanel;
    Label7: TLabel;
    LblApanhe: TLabel;
    PnlCheckOut: TPanel;
    Label6: TLabel;
    LblCheckOut: TLabel;
    PnlExpedicao: TPanel;
    Label15: TLabel;
    LblExpedicao: TLabel;
    PnlCortes: TPanel;
    Label11: TLabel;
    LblCortes: TLabel;
    PnlCancelado: TPanel;
    Label16: TLabel;
    LblCancelado: TLabel;
    PnlEficiencia: TPanel;
    Label8: TLabel;
    LblEficiencia: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    PgrExpedicao: TGauge;
    PgrRecebido: TGauge;
    PgrCubagem: TGauge;
    PgrApanhe: TGauge;
    PgrCheckOut: TGauge;
    PgrCancelado: TGauge;
    PgrCortes: TGauge;
    PnlPgrCubagem: TPanel;
    PgrFracionadoCubagem: TGauge;
    Label29: TLabel;
    PgrCxaFechadaCubagem: TGauge;
    Label28: TLabel;
    Label30: TLabel;
    PnlPgrApanhe: TPanel;
    PgrFracionadoApanhe: TGauge;
    Label31: TLabel;
    PgrCxaFechadaApanhe: TGauge;
    Label32: TLabel;
    Label33: TLabel;
    PnlPgrCheckOut: TPanel;
    PgrFracionadoCheckOut: TGauge;
    Label34: TLabel;
    PgrCxaFechadaCheckOut: TGauge;
    Label35: TLabel;
    Label36: TLabel;
    PnlPgrExpedicao: TPanel;
    PgrFracionadoExpedicao: TGauge;
    Label37: TLabel;
    PgrCxaFechadaExpedicao: TGauge;
    Label38: TLabel;
    Label39: TLabel;
    FdMemDetalheEvolucao: TFDMemTable;
    LblCxaFechadaCubagem: TLabel;
    LblFracionadoCubagem: TLabel;
    LblCxaFechadaApanhe: TLabel;
    LblFracionadoApanhe: TLabel;
    LblCxaFechadaCheckOut: TLabel;
    LblFracionadoCheckOut: TLabel;
    LblFracionadoExpedicao: TLabel;
    LblCxaFechadaExpedicao: TLabel;
    CbTipoAnalise: TComboBox;
    Label40: TLabel;
    GroupBox2: TGroupBox;
    Label41: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtInicioEnter(Sender: TObject);
    procedure EdtInicioExit(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure EdtRotaIdKeyPress(Sender: TObject; var Key: Char);
    procedure CbTipoAnaliseClick(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure EdtRotaIdChange(Sender: TObject);
  public
    { Public declarations }
  private
    { Private declarations }
    Procedure MontaListaEvolucao;
    Procedure MontaDSHDetalhes;
    Procedure ThreadValidarPesquisarDados(Sender: TObject);
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
  end;

var
  FrmRelEvolucaoRessuprimentos: TFrmRelEvolucaoRessuprimentos;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl, Views.Pequisa.Rotas, Views.Pequisa.EnderecamentoZonas, uFuncoes, RotaCtrl;

procedure TFrmRelEvolucaoRessuprimentos.BtnPesqRotaClick(Sender: TObject);
begin
  inherited;
  if EdtRotaId.ReadOnly then Exit;
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

procedure TFrmRelEvolucaoRessuprimentos.BtnPesqZonaClick(Sender: TObject);
begin
  inherited;
  if EdtZonaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelEvolucaoRessuprimentos.CbTipoAnaliseClick(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtInicioEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtInicioExit(Sender: TObject);
begin
  inherited;
  if (Sender = EdtInicio) or (Sender = EdtTermino) then Begin
     Try
       StrToDate(TJvDateEdit(Sender).Text);
     Except Begin
       if (Sender = EdtInicio) then
          raise Exception.Create('Data Inicial inválida!')
       Else raise Exception.Create('Data Final inválida!');
       End;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtRotaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption:= '';
  Limpar;
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if EdtRotaId.Text = '' then Begin
     LblRota.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtRotaId.Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     ShowErro('Rota('+EdtRotaId.Text+') inválida!' );
     EdtRotaId.Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     Player('toast4');
     EdtRotaId.Clear;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  ReturnLstRota := Nil;
  ObjRotaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtRotaIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '';
  Limpar;
end;

procedure TFrmRelEvolucaoRessuprimentos.EdtZonaIdExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  if EdtZonaId.Text = '' then Begin
     LblZona.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Begin
     LblZona.Caption := '';
     ShowErro('Zona('+EdtZonaId.Text+') inválida!' );
     EdtZonaId.Clear;
     EdtZonaId.setFocus;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl   := TEnderecamentoZonaCtrl.Create;
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(StrToIntDef(EdtZonaId.text, 0), '', 0);
  if (JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) then Begin
     LblZona.Caption := '';
     Player('toast4');
     EdtZonaId.Clear;
  end
  Else
     LblZona.Caption :=JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  JsonArrayRetorno := Nil;
  ObjEnderecamentoZonaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelEvolucaoRessuprimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //FrmRelEvolucaoRessuprimentos.Close;
  FrmRelEvolucaoRessuprimentos := Nil;
end;

procedure TFrmRelEvolucaoRessuprimentos.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 100;
  LstReport.ColWidths[1]  :=  80;
  LstReport.ColWidths[2]  :=  80;
  LstReport.ColWidths[3]  :=  80;
  LstReport.ColWidths[4]  :=  80;
  LstReport.ColWidths[5]  :=  80;
  LstReport.ColWidths[6]  :=  80;
  LstReport.ColWidths[7]  :=  80;
  LstReport.ColWidths[8]  :=  80;
  LstReport.ColWidths[9]  :=  80;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[2, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LblRegistro.caption      := '0';
  LblRecebido.Caption      := '0';
  LblCubagem.Caption       := '0';
  LblApanhe.Caption        := '0';
  LblCheckOut.Caption      := '0';
  LblExpedicao.Caption     := '0';
  LblCancelado.Caption     := '0';
  PgrRecebido.Progress     := 0;
  PgrCubagem.Progress      := 0;
  PgrApanhe.Progress       := 0;
  PgrCheckOut.Progress     := 0;
  PgrExpedicao.Progress    := 0;
  PgrCancelado.Progress    := 0;
  PgrCortes.Progress       := 0;
  LstReport.RowCount       := 1;
  CbTipoAnalise.Enabled    := True;
end;

procedure TFrmRelEvolucaoRessuprimentos.Limpar;
begin
  inherited;
  LblRegistro.Caption      := '0';
  LblRecebido.Caption      := '0';
  LblCubagem.Caption       := '0';
  LblApanhe.Caption        := '0';
  LblCheckout.Caption      := '0';
  LblExpedicao.Caption     := '0';
  LblCancelado.Caption     := '0';
  LblCortes.Caption        := '0';
  LblDshDemanda.Caption    := '0';
  PgrRecebido.Progress     := 0;
  PgrCubagem.Progress      := 0;
  PgrApanhe.Progress       := 0;
  PgrCheckOut.Progress     := 0;
  PgrExpedicao.Progress    := 0;
  PgrCancelado.Progress    := 0;
  PgrCortes.Progress       := 0;
  LblDshCanceladoCorte.Caption     := '0';
  LblDshPendencia.Caption          := '0';
  LblDshPercPendencia.Caption      := '0';
  LblDshPercCanceladoCorte.Caption := '0';
  LblEficiencia.Caption            := '0%';
  LstReport.ClearRect(0, 1, LstReport.ColCount-1, LstReport.RowCount-1);
  PgrCxaFechadaCubagem.BackColor := ClBtnFace;
  PgrFracionadoCubagem.BackColor := ClBtnFace;
  PgrCxaFechadaCubagem.Progress  := 0;
  PgrFracionadoCubagem.Progress  := 0;
  PgrCxaFechadaApanhe.BackColor := ClBtnFace;
  PgrFracionadoApanhe.BackColor := ClBtnFace;
  PgrCxaFechadaApanhe.Progress  := 0;
  PgrFracionadoApanhe.Progress  := 0;
  PgrCxaFechadaCheckOut.BackColor := ClBtnFace;
  PgrFracionadoCheckOut.BackColor := ClBtnFace;
  PgrCxaFechadaCheckOut.Progress  := 0;
  PgrFracionadoCheckOut.Progress  := 0;
  PgrCxaFechadaExpedicao.BackColor := ClBtnFace;
  PgrFracionadoExpedicao.BackColor := ClBtnFace;
  PgrCxaFechadaExpedicao.Progress  := 0;
  PgrFracionadoExpedicao.Progress  := 0;
  LblCxaFechadaCubagem.Caption     := '';
  LblFracionadoCubagem.Caption     := '';
  LblCxaFechadaApanhe.Caption      := '';
  LblFracionadoApanhe.Caption      := '';
  LblCxaFechadaCheckOut.Caption    := '';
  LblFracionadoCheckOut.Caption    := '';
  LblCxaFechadaExpedicao.Caption   := '';
  LblFracionadoExpedicao.Caption   := '';
end;

procedure TFrmRelEvolucaoRessuprimentos.MontaDSHDetalhes;
Var Cor1, Cor2 : TColor;
    vPgrCxaFechadaCubagem,
    vPgrFracionadoCubagem,
    vPgrCxaFechadaApanhe,
    vPgrFracionadoApanhe,
    vPgrCxaFechadaCheckOut,
    vPgrFracionadoCheckOut,
    vPgrCxaFechadaExpedicao,
    vPgrFracionadoExpedicao : Integer;
    xValor, xValorMax, xInc : Integer;
begin
  Cor1 := $000080FF;
  Cor2 := $00EAF4FF;
  PgrCxaFechadaCubagem.MaxValue   := StrToInt(StringReplace(LblCubagem.Caption, '.', '', [rfReplaceAll]));
  PgrFracionadoCubagem.MaxValue   := StrToInt(StringReplace(LblCubagem.Caption, '.', '', [rfReplaceAll]));
  PgrCxaFechadaApanhe.MaxValue    := StrToInt(StringReplace(LblApanhe.Caption, '.', '', [rfReplaceAll]));
  PgrFracionadoApanhe.MaxValue    := StrToInt(StringReplace(LblApanhe.Caption, '.', '', [rfReplaceAll]));
  PgrCxaFechadaCheckOut.MaxValue  := StrToInt(StringReplace(LblCheckOut.Caption, '.', '', [rfReplaceAll]));
  PgrFracionadoCheckOut.MaxValue  := StrToInt(StringReplace(LblCheckOut.Caption, '.', '', [rfReplaceAll]));
  PgrCxaFechadaExpedicao.MaxValue := StrToInt(StringReplace(LblExpedicao.Caption, '.', '', [rfReplaceAll]));
  PgrFracionadoExpedicao.MaxValue := StrToInt(StringReplace(LblExpedicao.Caption, '.', '', [rfReplaceAll]));
  vPgrCxaFechadaCubagem   := 0;
  vPgrFracionadoCubagem   := 0;
  vPgrCxaFechadaApanhe    := 0;
  vPgrFracionadoApanhe    := 0;
  vPgrCxaFechadaCheckOut  := 0;
  vPgrFracionadoCheckOut  := 0;
  vPgrCxaFechadaExpedicao := 0;
  vPgrFracionadoExpedicao := 0;
  FdMemDetalheEvolucao.First;
  if FdMemDetalheEvolucao.FieldByName('EmbalagemId').AsString = '' then Begin
     vPgrCxaFechadaCubagem   := FdMemDetalheEvolucao.FieldByName('Cubagem').AsInteger;
     vPgrCxaFechadaApanhe    := FdMemDetalheEvolucao.FieldByName('Apanhe').AsInteger;
     vPgrCxaFechadaCheckOut  := FdMemDetalheEvolucao.FieldByName('CheckOut').AsInteger;
     vPgrCxaFechadaExpedicao := FdMemDetalheEvolucao.FieldByName('Expedicao').AsInteger;
  End;
  FdMemDetalheEvolucao.Next;
  if FdMemDetalheEvolucao.FieldByName('EmbalagemId').AsString <> '' then Begin
     vPgrFracionadoCubagem   := FdMemDetalheEvolucao.FieldByName('Cubagem').AsInteger;
     vPgrFracionadoApanhe    := FdMemDetalheEvolucao.FieldByName('Apanhe').AsInteger;
     vPgrFracionadoCheckOut  := FdMemDetalheEvolucao.FieldByName('CheckOut').AsInteger;
     vPgrFracionadoExpedicao := FdMemDetalheEvolucao.FieldByName('Expedicao').AsInteger;
  End;
  //Cubagem
      xValor := 0;
      xInc := IfThenInt(vPgrCxaFechadaCubagem<=10000, (vPgrCxaFechadaCubagem Div 2), (vPgrCxaFechadaCubagem Div 5));
      Repeat
        TThread.Synchronize(TThread.CurrentThread, procedure
        begin
          LblCxaFechadaCubagem.Caption  := FormatFloat('###,##0', xValor);
          PgrCxaFechadaCubagem.Progress := xValor;
          if PgrCxaFechadaCubagem.ForeColor = Cor1 then
             PgrCxaFechadaCubagem.ForeColor := Cor2
          Else PgrCxaFechadaCubagem.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrCxaFechadaCubagem;
      TThread.Synchronize(nil, procedure
      begin
        LblCxaFechadaCubagem.Caption   := FormatFloat('###,##0', vPgrCxaFechadaCubagem);
        PgrCxaFechadaCubagem.Progress  := vPgrCxaFechadaCubagem;
        PgrCxaFechadaCubagem.ForeColor := Cor1;
      End);


      xValor := 0;
      xInc := IfThenInt(vPgrFracionadoCubagem<=10000, (vPgrFracionadoCubagem Div 2), (vPgrFracionadoCubagem Div 5));
      Repeat
        TThread.Synchronize(Nil, procedure //TThread.CurrentThread
        begin
          LblFracionadoCubagem.Caption  := FormatFloat('###,##0', xValor);
          PgrFracionadoCubagem.Progress := xValor;
          if PgrFracionadoCubagem.ForeColor    = Cor1 then
             PgrFracionadoCubagem.ForeColor   := Cor2
          Else PgrFracionadoCubagem.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrFracionadoCubagem;
      TThread.Synchronize(nil, procedure
      begin
        LblFracionadoCubagem.Caption  := FormatFloat('###,##0', vPgrFracionadoCubagem);
        PgrFracionadoCubagem.Progress  := vPgrFracionadoCubagem;
        PgrFracionadoCubagem.ForeColor := Cor1;
      End);

  //Apanhe
      xValor := 0;
      xInc := IfThenInt(vPgrCxaFechadaApanhe<=10000, (vPgrCxaFechadaApanhe Div 2), (vPgrCxaFechadaApanhe Div 5));
      Repeat
        TThread.Synchronize(Nil, procedure
        begin
          LblCxaFechadaApanhe.Caption  := FormatFloat('###,##0', xValor);
          PgrCxaFechadaApanhe.Progress := xValor;
          if PgrCxaFechadaApanhe.ForeColor = Cor1 then
             PgrCxaFechadaApanhe.ForeColor := Cor2
          Else PgrCxaFechadaApanhe.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrCxaFechadaApanhe;
      TThread.Synchronize(nil, procedure
      begin
        LblCxaFechadaApanhe.Caption  := FormatFloat('###,##0', vPgrCxaFechadaApanhe);
        PgrCxaFechadaApanhe.Progress  := vPgrCxaFechadaApanhe;
        PgrCxaFechadaApanhe.ForeColor := Cor1;
      End);

      xValor := 0;
      xInc := IfThenInt(vPgrFracionadoApanhe<=10000, (vPgrFracionadoApanhe Div 2), (vPgrFracionadoApanhe Div 5));
      Repeat
        TThread.Synchronize(nil, procedure
        begin
          LblFracionadoApanhe.Caption  := FormatFloat('###,##0', xValor);
          PgrFracionadoApanhe.Progress := xValor;
          if PgrFracionadoApanhe.ForeColor = Cor1 then
             PgrFracionadoApanhe.ForeColor := Cor2
          Else PgrFracionadoApanhe.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrFracionadoApanhe;
      TThread.Synchronize(nil, procedure
      begin
        LblFracionadoApanhe.Caption  := FormatFloat('###,##0', vPgrFracionadoApanhe);
        PgrFracionadoApanhe.Progress  := vPgrFracionadoApanhe;
        PgrFracionadoApanhe.ForeColor := Cor1;
      End);

  //CheckOut
      xValor := 0;
      xInc := IfThenInt(vPgrCxaFechadaCheckOut<=10000, (vPgrCxaFechadaCheckOut Div 2), (vPgrCxaFechadaCheckOut Div 5));
      Repeat
        TThread.Synchronize(nil, procedure
        begin
          LblCxaFechadaCheckOut.Caption  := FormatFloat('###,##0', xValor);
          PgrCxaFechadaCheckOut.Progress := xValor;
          if PgrCxaFechadaCheckOut.ForeColor = Cor1 then
             PgrCxaFechadaCheckOut.ForeColor := Cor2
          Else PgrCxaFechadaCheckOut.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrCxaFechadaCheckOut;
      TThread.Synchronize(nil, procedure
      begin
        LblCxaFechadaCheckOut.Caption  := FormatFloat('###,##0', vPgrCxaFechadaCheckOut);
        PgrCxaFechadaCheckOut.Progress  := vPgrCxaFechadaCheckOut;
        PgrCxaFechadaCheckOut.ForeColor := Cor1;
      End);

      xValor := 0;
      xInc := IfThenInt(vPgrFracionadoCheckOut<=10000, (vPgrFracionadoCheckOut Div 2), (vPgrFracionadoCheckOut Div 5));
      Repeat
        TThread.Synchronize(nil, procedure
        begin
          LblFracionadoCheckOut.Caption  := FormatFloat('###,##0', xValor);
          PgrFracionadoCheckOut.Progress := xValor;
          if PgrFracionadoCheckOut.ForeColor = Cor1 then
             PgrFracionadoCheckOut.ForeColor := Cor2
          Else PgrFracionadoCheckOut.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrFracionadoCheckOut;
      TThread.Synchronize(nil, procedure
      begin
        LblFracionadoCheckOut.Caption  := FormatFloat('###,##0', vPgrFracionadoCheckOut);
        PgrFracionadoCheckOut.Progress  := vPgrFracionadoCheckOut;
        PgrFracionadoCheckOut.ForeColor := Cor1;
      End);

  //Expedição
      xValor := 0;
      xInc := IfThenInt(vPgrCxaFechadaExpedicao<=10000, (vPgrCxaFechadaExpedicao Div 2), (vPgrCxaFechadaExpedicao Div 5));
      Repeat
        TThread.Synchronize(nil, procedure
        begin
          LblCxaFechadaExpedicao.Caption  := FormatFloat('###,##0', xValor);
          PgrCxaFechadaExpedicao.Progress := xValor;
          if PgrCxaFechadaExpedicao.ForeColor = Cor1 then
             PgrCxaFechadaExpedicao.ForeColor := Cor2
          Else PgrCxaFechadaExpedicao.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrCxaFechadaExpedicao;
      TThread.Synchronize(nil, procedure
      begin
        LblCxaFechadaExpedicao.Caption   := FormatFloat('###,##0', vPgrCxaFechadaExpedicao);
        PgrCxaFechadaExpedicao.Progress  := vPgrCxaFechadaExpedicao;
        PgrCxaFechadaExpedicao.ForeColor := Cor1;
      End);

      xValor := 0;
      xInc := IfThenInt(vPgrFracionadoExpedicao<=10000, (vPgrFracionadoExpedicao Div 2), (vPgrFracionadoExpedicao Div 5));
      Repeat
        TThread.Synchronize(nil, procedure
        begin
          LblFracionadoExpedicao.Caption  := FormatFloat('###,##0', xValor);
          PgrFracionadoExpedicao.Progress := xValor;
          if PgrFracionadoExpedicao.ForeColor = Cor1 then
             PgrFracionadoExpedicao.ForeColor := Cor2
          Else PgrFracionadoExpedicao.ForeColor := Cor1;
        End);
        Sleep(1);
        xValor := xValor + xInc;
      Until xValor > vPgrFracionadoExpedicao;
      TThread.Synchronize(nil, procedure
      begin
        LblFracionadoExpedicao.Caption   := FormatFloat('###,##0', vPgrFracionadoExpedicao);
        PgrFracionadoExpedicao.Progress  := vPgrFracionadoExpedicao;
        PgrFracionadoExpedicao.ForeColor := Cor1;
      End);
end;

procedure TFrmRelEvolucaoRessuprimentos.MontaListaEvolucao;
Var vDemanda, vRecebido, vCubagem, vApanhe, vCheckout, vExpedicao, vCancelado, vCortes : Integer;
begin
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  BtnImprimirStand.Grayed := False;
  LstReport.FixedRows := 1;
  LblRegistro.Caption := FormatFloat('0', FdMemPesqGeral.RecordCount);
  vRecebido  := 0;
  vDemanda   := 0;
  vCubagem   := 0;
  vApanhe    := 0;
  vCheckout  := 0;
  vExpedicao := 0;
  vCancelado := 0;
  vCortes    := 0;
  while Not FdMemPesqGeral.Eof do Begin
    //LstReport.Cells[0, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.Recno.ToString;
    LstReport.Cells[0, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Data').AsString;
    LstReport.Cells[1, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Demanda').AsString;
    LstReport.Cells[2, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Recebido').AsString;
    LstReport.Cells[3, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Cubagem').AsString;
    LstReport.Cells[4, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Apanhe').AsString;
    LstReport.Cells[5, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('CheckOut').AsString;
    LstReport.Cells[6, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Expedicao').AsString;
    LstReport.Cells[7, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Cancelado').AsString;
    LstReport.Cells[8, FdMemPesqGeral.RecNo]  := (FdMemPesqGeral.FieldByName('Demanda').AsInteger-
                                                  (FdMemPesqGeral.FieldByName('Recebido').AsInteger+
                                                   FdMemPesqGeral.FieldByName('Cubagem').AsInteger+
                                                   FdMemPesqGeral.FieldByName('Apanhe').AsInteger+
                                                   FdMemPesqGeral.FieldByName('CheckOut').AsInteger+
                                                   FdMemPesqGeral.FieldByName('Expedicao').AsInteger)-
                                                   FdMemPesqGeral.FieldByName('Cancelado').AsInteger ).ToString;
    LstReport.Cells[9, FdMemPesqGeral.RecNo]  := FormatFloat('0.00', FdMemPesqGeral.FieldByName('Eficiencia').AsFloat);
    vDemanda   := vDemanda   + FdMemPesqGeral.FieldByName('Demanda').AsInteger;
    vRecebido  := vRecebido  + FdMemPesqGeral.FieldByName('Recebido').AsInteger;
    vCubagem   := vCubagem   + FdMemPesqGeral.FieldByName('Cubagem').AsInteger;
    vApanhe    := vApanhe    + FdMemPesqGeral.FieldByName('Apanhe').AsInteger;
    vCheckout  := vCheckout  + FdMemPesqGeral.FieldByName('CheckOut').AsInteger;
    vExpedicao := vExpedicao + FdMemPesqGeral.FieldByName('Expedicao').AsInteger;
    vCancelado := vCancelado + FdMemPesqGeral.FieldByName('Cancelado').AsInteger;
    vCortes    := vCortes    + (FdMemPesqGeral.FieldByName('Demanda').AsInteger-
                               (FdMemPesqGeral.FieldByName('Recebido').AsInteger+
                                FdMemPesqGeral.FieldByName('Cubagem').AsInteger+
                                FdMemPesqGeral.FieldByName('Apanhe').AsInteger+
                                FdMemPesqGeral.FieldByName('CheckOut').AsInteger+
                                FdMemPesqGeral.FieldByName('Expedicao').AsInteger)-
                                FdMemPesqGeral.FieldByName('Cancelado').AsInteger );
    if FdMemPesqGeral.FieldByName('Eficiencia').AsFloat = 100 then
       LstReport.Colors[8, FdMemPesqGeral.RecNo] := ClGreen
    Else If FdMemPesqGeral.FieldByName('Eficiencia').AsFloat > 90 then
      LstReport.Colors[8, FdMemPesqGeral.RecNo] := clYellow
    Else If FdMemPesqGeral.FieldByName('Expedicao').AsFloat > 0 then
      LstReport.Colors[8, FdMemPesqGeral.RecNo] := ClRed;
//    if FdMemPesqGeral.FieldByName('Demanda').AsInteger > (FdMemPesqGeral.FieldByName('Expedicao').AsInteger+FdMemPesqGeral.FieldByName('Cancelado').AsInteger) then
//       LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClRed
//    Else If FdMemPesqGeral.FieldByName('Demanda').AsInteger = (FdMemPesqGeral.FieldByName('Expedicao').AsInteger+FdMemPesqGeral.FieldByName('Cancelado').AsInteger) then
//      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClGreen
//    Else
//      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClWhite;
    LstReport.Alignments[0, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.FontStyles[0, FdmemPesqGeral.Recno] := [FsBold];
    LstReport.Alignments[1, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[2, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[3, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[4, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[5, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[6, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[7, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[8, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[9, FdMemPesqGeral.RecNo] := taRightJustify;
    FdMemPesqGeral.Next;
  End;
  LblRecebido.Caption   := FormatFloat('#,##0', vRecebido);
  LblDshDemanda.Caption := FormatFloat('#,##0', vDemanda);
  LblCubagem.Caption    := FormatFloat('#,##0', vCubagem);
  LblApanhe.Caption     := FormatFloat('#,##0', vApanhe);
  LblCheckout.Caption   := FormatFloat('#,##0', vCheckOut);
  LblExpedicao.Caption  := FormatFloat('#,##0', vExpedicao);
  LblCancelado.Caption  := FormatFloat('#,##0', vCancelado);
  LblCortes.Caption     := FormatFloat('#,##0', vCortes);
  PgrRecebido.Progress  := Trunc((vRecebido / vDemanda) * 100 );
  PgrCubagem.Progress   := Trunc((vCubagem / vDemanda) * 100 );
  PgrApanhe.Progress    := Trunc((vApanhe / vDemanda) * 100 );
  PgrCheckOut.Progress  := Trunc((vCheckOut / vDemanda) * 100 );
  PgrExpedicao.Progress := Trunc((vExpedicao / vDemanda) * 100);
  PgrCancelado.Progress := Trunc((vCancelado / vDemanda) * 100 );
  PgrCortes.Progress    := Trunc((vCortes / vDemanda) * 100 );

  LblDshDemanda.Caption := FormatFloat('#,##0', vDemanda);
  LblEficiencia.Caption := FormatFloat('0.00', (vExpedicao / vDemanda) * 100 )+'%';
  if ((vExpedicao / vDemanda) * 100 ) >= 100 then
     LblEficiencia.Font.Color := ClGreen
  Else if ((vExpedicao / vDemanda) * 100 ) >= 90 then
     LblEficiencia.Font.Color := $004080FF
  Else
     LblEficiencia.Font.Color := clred;
  LblDshCanceladoCorte.Caption     := FormatFloat('#,##0', vCancelado+vCortes);
  LblDshPercCanceladoCorte.Caption := FormatFloat('0.00', ((vCancelado+vCortes)) / vDemanda * 100 )+'%';
  LblDshPendencia.Caption          := FormatFloat('#,##0', vDemanda-(vExpedicao+vCancelado+vCortes));
  LblDshPercPendencia.Caption      := FormatFloat('0.00', (vDemanda-(vExpedicao+vCancelado+vCortes)) / vDemanda * 100 )+'%';
  if (CbTipoAnalise.ItemIndex in [1, 2]) then //   RbVolume.Checked) or (RbUnidade.Checked) then
     MontaDSHDetalhes;
end;

procedure TFrmRelEvolucaoRessuprimentos.PesquisarDados;
Var aParams : TDictionary<String, String>;
    TH : TThread;
begin
  inherited;
  if StrToDate(EdtTermino.Text) < StrToDate(EdtInicio.Text) then
     raise Exception.Create('Data final não pode ser menor que Data Inicial.');
  if CbTipoAnalise.ItemIndex < 0 then
     raise Exception.Create('Selecione o tipo de evolução para análise.');
  aParams := TDictionary<String, String>.Create;
  if EdtInicio.Text <> '  /  /    ' then
     AParams.Add('datainicio', EdtInicio.Text);
  if EdtTermino.Text <> '  /  /    ' then
     AParams.Add('datafinal', EdtTermino.Text);
  if StrToIntDef(EdtRotaId.Text,0)>0 then
     AParams.Add('rotaid', EdtRotaId.Text);
  if StrToIntDef(EdtZonaId.Text,0)>0 then
     AParams.Add('zonaid', EdtZonaId.Text);
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  If FdMemDetalheEvolucao.Active then
     FdMemDetalheEvolucao.EmptyDataSet;
  FdMemDetalheEvolucao.Close;
  TH := TThread.CreateAnonymousThread(procedure
  Var JsonArrayRetorno   : TJsonArray;
      ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
      vErro : String;
  begin
    ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
    if CbTipoAnalise.ItemIndex = 0 then Begin
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoPed(aParams);
       if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
          FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False)
    End
    Else if CbTipoAnalise.ItemIndex = 1 then Begin
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoVol(aParams);
       if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
          FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
          JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidEmbalagem(aParams, 'Vol');
          if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
             FdMemDetalheEvolucao.LoadFromJson(JsonArrayRetorno, False);
       End;
    End
    Else if CbTipoAnalise.ItemIndex = 2 then Begin
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnid(aParams);
       if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
          FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
          JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidEmbalagem(aParams, 'Unid');
          if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
             FdMemDetalheEvolucao.LoadFromJson(JsonArrayRetorno, False);
       End;
    End;
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       JsonArrayRetorno := Nil;
       ObjPedidoSaidaCtrl.Free;
       raise Exception.Create('Erro: '+vErro);
    End
    Else Begin
       if FdMemPesqGeral.IsEmpty then begin
          JsonArrayRetorno := Nil;
          ObjPedidoSaidaCtrl.Free;
          aParams := Nil;
          raise Exception.Create('Não foram encontrados dados de acordo com os filtros aplicados.');
       End;
       MontaListaEvolucao;
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoSaidaCtrl.Free;
    aParams := Nil;
  end);
  TH.OnTerminate := ThreadValidarPesquisarDados;
  TH.Start;
end;

procedure TFrmRelEvolucaoRessuprimentos.ThreadValidarPesquisarDados(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then begin
     ShowErro(Exception(TThread(sender).FatalException).Message, 'alerta');
     Exit;
  end;
end;

end.
