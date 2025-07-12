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
    FdMemEvolucao: TFDMemTable;
    DataSource1: TDataSource;
    LstZona: TAdvStringGrid;
    FDMemZona: TFDMemTable;
    FDMemZonaZonaid: TIntegerField;
    FDMemZonaDescricao: TStringField;
    FDMemZonaAtivo: TIntegerField;
    Label5: TLabel;
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
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure LstZonaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
  public
    { Public declarations }
  private
    { Private declarations }
    pTipoResumo : Integer; //0 = Data 1 - Zona
    SelZona : Boolean;
    Procedure MontaListaEvolucao;
    Procedure MontaDSHDetalhes;
    Procedure ThreadValidarPesquisarDados(Sender: TObject);
    Procedure ColumnHeader(pTipo : integer);
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

procedure TFrmRelEvolucaoRessuprimentos.BtnPesquisarStandClick(Sender: TObject);
begin
  Limpar;
  inherited;
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
  ColumnHeader(pTipoResumo);
  Limpar;
  exit;
  if CbTipoAnalise.ItemIndex = 0 then Begin
     GroupBox2.Enabled := False;
     EdtZonaId.Clear;
     GroupBox2.Visible := False;
  End
  else Begin
     GroupBox2.Enabled := True;
     GroupBox2.Visible := False;
  End;
end;

procedure TFrmRelEvolucaoRessuprimentos.ColumnHeader(pTipo : integer);
begin
  LstReport.ColCount := 10;
  If (pTipo = 0) or (CbTipoAnalise.ItemIndex = 0) then Begin //<> 2) then Begin
     LstReport.Cells[0, 0]   := 'Data';
     LstReport.ColWidths[0]  := 100+Trunc(100*ResponsivoVideo);
     LstReport.Alignments[0, 0]  := taCenter;
     LstReport.FontStyles[0, 0]  := [FsBold];
  End
  Else Begin
     LstReport.Cells[0, 0]   := 'Zona/Setor';
     LstReport.ColWidths[0]  := 240+Trunc(240*ResponsivoVideo);
     LstReport.Alignments[0, 0]  := taLeftJustify;
     LstReport.FontStyles[0, 0]  := [FsBold];
  end;
  LstReport.ColWidths[1]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[2]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[5]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[6]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[7]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[8]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[9]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[2, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;

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
  if ((Sender = EdtInicio) or (Sender = EdtTermino)) and (TJvDateEdit(Sender).Text <> '  /  /    ') then Begin
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
     ObjRotaCtrl.Free;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
//  ReturnLstRota.Free;
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
  FrmRelEvolucaoRessuprimentos := Nil;
end;

procedure TFrmRelEvolucaoRessuprimentos.FormCreate(Sender: TObject);
Var ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    xZona: Integer;
begin
  inherited;
  pTipoResumo := 1;
  ColumnHeader(pTipoResumo);
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
  LstZona.ColWidths[0]  := 60;
  LstZona.ColWidths[1]  := 160;
  LstZona.ColWidths[2]  :=  40;
  LstZona.Alignments[0, 0] := taRightJustify;
  LstZona.FontStyles[0, 0] := [FsBold];
  LstZona.Alignments[2, 0] := taCenter;

  ObjEnderecamentoZonaCtrl   := TEnderecamentoZonaCtrl.Create;
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetZonas(0, 2, 2, '');
  LstZona.RowCount := 1;
  if Not (JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) then Begin
     If FDMemZona.Active then
        FDMemZona.EmptyDataSet;
     FDMemZona.Close;
     FDMemZona.LoadFromJSON(JsonArrayRetorno, False);
     FDMemZona.First;
     While Not FDMemZona.Eof do Begin
       FDMemZona.Edit;
       FDMemZona.FieldByName('Ativo').AsInteger := 1;
       FDMemZona.Next;
     End;
     FDMemZona.First;
     LstZona.RowCount  := JsonArrayRetorno.Count+1;
     LStZona.FixedRows := 1;
     for xZona := 1 to JsonArrayRetorno.Count do
       LstZona.AddDataImage( 2, xZona, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
     for xZona := 0 to Pred(JsonArrayRetorno.Count) do Begin
       LstZona.Cells[0, xZona+1] := JsonArrayRetorno.Items[xZona].GetValue<Integer>('zonaid').ToString();
       LstZona.Cells[1, xZona+1] := JsonArrayRetorno.Items[xZona].GetValue<String>('descricao');
       LstZona.Cells[2, xZona+1] := '1';
       LstZona.Alignments[0, xZona+1] := taRightJustify;
       LstZona.FontStyles[0, xZona+1] := [FsBold];
       LstZona.Alignments[2, xZona+1] := taCenter;
     End;
  End;
  SelZona := True;
  JsonArrayRetorno := Nil;
  ObjEnderecamentoZonaCtrl.Free;
end;

procedure TFrmRelEvolucaoRessuprimentos.FormShow(Sender: TObject);
begin
  inherited;
  EdtInicio.SetFocus;
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

procedure TFrmRelEvolucaoRessuprimentos.LstZonaClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xZona : Integer;
begin
  inherited;
  if LstZona.RowCount <= 1 then Exit;
  Limpar;
  if (aCol = 2) then Begin
     if (aRow = 0) and (LstZona.RowCount>1) then Begin
        For xZona := 1 to Pred(LstZona.RowCount) do Begin
          if SelZona then Begin
             LstZona.Cells[2, xZona] := '0';
          End
          Else Begin
             LstZona.Cells[2, xZona] := '1';
          End;
        End;
        FDMemZona.First;
        While Not FDMemZona.Eof do Begin
          FDMemZona.Edit;
          if SelZona then
             FDMemZona.FieldByName('Ativo').AsInteger := 0
          Else
             FDMemZona.FieldByName('Ativo').AsInteger := 1;
          FDMemZona.Next
        End;
        SelZona := Not SelZona;
     End
     Else Begin
       if StrToIntDef(LstZona.Cells[2, aRow], 0) = 0 then
          LstZona.Cells[2, aRow] := '1'
       Else
         LStZona.Cells[2, aRow] := '0';
       FDMemZona.First;
       If FDMemZona.Locate('ZonaId', LstZona.Cells[0, aRow], []) then Begin
          FDMemZona.Edit;
          FDMemZona.FieldByName('Ativo').AsInteger := LStZona.ints[2, aRow];
       End;
     End;
  End;
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
  LblCxaFechadaCubagem.Caption  := FormatFloat('###,##0', vPgrCxaFechadaCubagem);
  PgrCxaFechadaCubagem.Progress := vPgrCxaFechadaCubagem;
  LblFracionadoCubagem.Caption  := FormatFloat('###,##0', vPgrFracionadoCubagem);
  PgrFracionadoCubagem.Progress := vPgrFracionadoCubagem;
  LblCxaFechadaApanhe.Caption  := FormatFloat('###,##0', vPgrCxaFechadaApanhe);
  PgrCxaFechadaApanhe.Progress := vPgrCxaFechadaApanhe;
  LblFracionadoApanhe.Caption  := FormatFloat('###,##0', vPgrFracionadoApanhe);
  PgrFracionadoApanhe.Progress := vPgrFracionadoApanhe;
  LblCxaFechadaCheckOut.Caption  := FormatFloat('###,##0', vPgrCxaFechadaCheckOut);
  PgrCxaFechadaCheckOut.Progress := vPgrCxaFechadaCheckOut;
  LblFracionadoCheckOut.Caption  := FormatFloat('###,##0', vPgrFracionadoCheckOut);
  PgrFracionadoCheckOut.Progress := vPgrFracionadoCheckOut;
  LblCxaFechadaExpedicao.Caption  := FormatFloat('###,##0', vPgrCxaFechadaExpedicao);
  PgrCxaFechadaExpedicao.Progress := vPgrCxaFechadaExpedicao;
  LblFracionadoExpedicao.Caption  := FormatFloat('###,##0', vPgrFracionadoExpedicao);
  PgrFracionadoExpedicao.Progress := vPgrFracionadoExpedicao;

  EXIT;

  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;

  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;

  //Apanhe
  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;

  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;
  //CheckOut
  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;

  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;
  //Expedição
  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;

  TThread.CreateAnonymousThread(procedure
    Var xValor, xValorMax, xInc : Integer;
    begin
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
    end).Start;
end;

procedure TFrmRelEvolucaoRessuprimentos.MontaListaEvolucao;
Var vDemanda, vRecebido, vCubagem, vApanhe, vCheckout, vExpedicao, vCancelado, vCortes : Integer;
begin
  LstReport.RowCount := FdMemEvolucao.RecordCount+1;
  BtnImprimirStand.Grayed := False;
  LstReport.FixedRows := 1;
  LblRegistro.Caption := FormatFloat('0', FdMemEvolucao.RecordCount);
  vRecebido  := 0;
  vDemanda   := 0;
  vCubagem   := 0;
  vApanhe    := 0;
  vCheckout  := 0;
  vExpedicao := 0;
  vCancelado := 0;
  vCortes    := 0;
  while Not FdMemEvolucao.Eof do Begin
    if (pTipoResumo = 0) Or (CbTipoAnalise.ItemIndex<1) Then Begin //>2) then Begin
       LstReport.Cells[0, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Data').AsString;
       LstReport.Cells[1, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Demanda').AsString;
       LstReport.Cells[2, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Recebido').AsString;
       LstReport.Cells[3, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Cubagem').AsString;
       LstReport.Cells[4, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Apanhe').AsString;
       LstReport.Cells[5, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('CheckOut').AsString;
       LstReport.Cells[6, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Expedicao').AsString;
       LstReport.Cells[7, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Cancelado').AsString;
       LstReport.Cells[8, FdMemEvolucao.RecNo]  := (FdMemEvolucao.FieldByName('Demanda').AsInteger-
                                                     (FdMemEvolucao.FieldByName('Recebido').AsInteger+
                                                      FdMemEvolucao.FieldByName('Cubagem').AsInteger+
                                                      FdMemEvolucao.FieldByName('Apanhe').AsInteger+
                                                      FdMemEvolucao.FieldByName('CheckOut').AsInteger+
                                                      FdMemEvolucao.FieldByName('Expedicao').AsInteger)-
                                                      FdMemEvolucao.FieldByName('Cancelado').AsInteger ).ToString;
       LstReport.Cells[9, FdMemEvolucao.RecNo]  := FormatFloat('0.00', FdMemEvolucao.FieldByName('Eficiencia').AsFloat);
       vDemanda   := vDemanda   + FdMemEvolucao.FieldByName('Demanda').AsInteger;
       vRecebido  := vRecebido  + FdMemEvolucao.FieldByName('Recebido').AsInteger;
       vCubagem   := vCubagem   + FdMemEvolucao.FieldByName('Cubagem').AsInteger;
       vApanhe    := vApanhe    + FdMemEvolucao.FieldByName('Apanhe').AsInteger;
       vCheckout  := vCheckout  + FdMemEvolucao.FieldByName('CheckOut').AsInteger;
       vExpedicao := vExpedicao + FdMemEvolucao.FieldByName('Expedicao').AsInteger;
       vCancelado := vCancelado + FdMemEvolucao.FieldByName('Cancelado').AsInteger;
       vCortes    := vCortes    + (FdMemEvolucao.FieldByName('Demanda').AsInteger-
                                  (FdMemEvolucao.FieldByName('Recebido').AsInteger+
                                   FdMemEvolucao.FieldByName('Cubagem').AsInteger+
                                   FdMemEvolucao.FieldByName('Apanhe').AsInteger+
                                   FdMemEvolucao.FieldByName('CheckOut').AsInteger+
                                   FdMemEvolucao.FieldByName('Expedicao').AsInteger)-
                                   FdMemEvolucao.FieldByName('Cancelado').AsInteger );
       if FdMemEvolucao.FieldByName('Eficiencia').AsFloat = 100 then
          LstReport.Colors[9, FdMemEvolucao.RecNo] := ClGreen
       Else If FdMemEvolucao.FieldByName('Eficiencia').AsFloat > 90 then
         LstReport.Colors[9, FdMemEvolucao.RecNo] := clYellow
       Else If FdMemEvolucao.FieldByName('Expedicao').AsFloat > 0 then
         LstReport.Colors[9, FdMemEvolucao.RecNo] := ClRed
       Else
         LstReport.Colors[9, FdMemEvolucao.RecNo] := LstReport.Colors[8, FdMemEvolucao.RecNo];;
    End
    Else Begin
       LstReport.Cells[0, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Zona').AsString;
       LstReport.Cells[1, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('Demanda').AsString;
       LstReport.Cells[2, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('NProcessado').AsString;
       LstReport.Cells[3, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('QtdProcessada').AsString;
       If CbTipoAnalise.ItemIndex = 2 then
           LstReport.Cells[4, FdMemEvolucao.RecNo]  := (FdMemEvolucao.FieldByName('qtdimpresso').AsInteger+FdMemEvolucao.FieldByName('QtdSeparacao').AsInteger).ToString()
       Else
           LstReport.Cells[4, FdMemEvolucao.RecNo]  := (FdMemEvolucao.FieldByName('QtdSeparacao').AsInteger).ToString();
       LstReport.Cells[5, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('QtdCheckOut').AsString;
       LstReport.Cells[6, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('QtdExpedido').AsString;
       LstReport.Cells[7, FdMemEvolucao.RecNo]  := FdMemEvolucao.FieldByName('QtdCancelada').AsString;
       LstReport.Cells[8, FdMemEvolucao.RecNo]  := (FdMemEvolucao.FieldByName('QtdCorte').AsInteger+FdMemEvolucao.FieldByName('CorteAutomatico').AsInteger).ToString();
       LstReport.Cells[9, FdMemEvolucao.RecNo]  := FormatFloat('0.', Round(FdMemEvolucao.FieldByName('QtdExpedido').AsFloat/FdMemEvolucao.FieldByName('Demanda').AsFloat*100));
       vDemanda   := vDemanda   + FdMemEvolucao.FieldByName('Demanda').AsInteger;
       vRecebido  := vRecebido  + FdMemEvolucao.FieldByName('NProcessado').AsInteger;
       vCubagem   := vCubagem   + FdMemEvolucao.FieldByName('QtdProcessada').AsInteger;
       If CbTipoAnalise.ItemIndex = 2 then
           vApanhe    := vApanhe    + FdMemEvolucao.FieldByName('qtdimpresso').AsInteger+FdMemEvolucao.FieldByName('QtdSeparacao').AsInteger
       Else
           vApanhe    := vApanhe    + FdMemEvolucao.FieldByName('QtdSeparacao').AsInteger;
       vCheckout  := vCheckout  + FdMemEvolucao.FieldByName('QtdCheckOut').AsInteger;
       vExpedicao := vExpedicao + FdMemEvolucao.FieldByName('QtdExpedido').AsInteger;
       vCancelado := vCancelado + FdMemEvolucao.FieldByName('QtdCancelada').AsInteger;
       vCortes    := vCortes    + FdMemEvolucao.FieldByName('QtdCorte').AsInteger+FdMemEvolucao.FieldByName('CorteAutomatico').AsInteger;
       if Round(FdMemEvolucao.FieldByName('QtdExpedido').AsFloat/FdMemEvolucao.FieldByName('Demanda').AsFloat*100) = 100 then
          LstReport.Colors[9, FdMemEvolucao.RecNo] := ClGreen
       Else If Round(FdMemEvolucao.FieldByName('QtdExpedido').AsFloat/FdMemEvolucao.FieldByName('Demanda').AsFloat*100) > 90 then
         LstReport.Colors[9, FdMemEvolucao.RecNo] := clYellow
       Else If FdMemEvolucao.FieldByName('QtdExpedido').AsFloat > 0 then
         LstReport.Colors[9, FdMemEvolucao.RecNo] := ClRed
       Else
         LstReport.Colors[9, FdMemEvolucao.RecNo] := LstReport.Colors[8, FdMemEvolucao.RecNo];
    End;
    LstReport.Alignments[0, FdMemEvolucao.RecNo] := taLeftJustify;
    LstReport.FontStyles[0, FdMemEvolucao.Recno] := [FsBold];
    LstReport.Alignments[1, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[2, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[3, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[4, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[5, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[6, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[7, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[8, FdMemEvolucao.RecNo] := taRightJustify;
    LstReport.Alignments[9, FdMemEvolucao.RecNo] := taRightJustify;
    FdMemEvolucao.Next;
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
//  if (CbTipoAnalise.ItemIndex in [1, 2]) then //   RbVolume.Checked) or (RbUnidade.Checked) then
//     MontaDSHDetalhes;
end;

procedure TFrmRelEvolucaoRessuprimentos.PesquisarDados;
Var aParams : TDictionary<String, String>;
    TH : TThread;
    pListaZonaIdStr, xCompl : String;
begin
  inherited;
  EdtInicioExit(EdtInicio);
  EdtInicioExit(EdtTermino);
  if (EdtInicio.Text = '  /  /    ') and (EdtTermino.Text = '  /  /    ') then Begin
     ShowErro('Informe o períod para analíse!');
     Exit;
  End;
  if (EdtInicio.Text <> '  /  /    ') and (EdtTermino.Text <> '  /  /    ') and (StrToDate(EdtTermino.Text) < StrToDate(EdtInicio.Text)) then
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
  pListaZonaIdStr := '';
  xCompl := '';
  FdMemZona.Filter   := 'Ativo = 0';
  FdMemZona.Filtered := True;
  FdMemZona.First;
  if Not FdMemZona.IsEmpty() then Begin
     FdMemZona.Filter   := '';
     FdMemZona.Filtered := False;
     FdMemZona.First;
     while Not FdMemZona.Eof do Begin
        if FdMemZona.FieldByName('Ativo').AsInteger = 1 then Begin
           pListaZonaIdStr := pListaZonaIdStr+xCompl+FdMemZona.FieldByName('ZonaId').AsString;
           xCompl := ', ';
        End;
        FdMemZona.Next;
     End;
  End
  Else Begin
    FdMemZona.Filter   := '';
    FdMemZona.Filtered := False;
  End;
  if pListaZonaidStr <> '' then
     AParams.Add('zonaidstr', pListaZonaIdStr);
  If FdMemEvolucao.Active then  Begin
     FdMemEvolucao.EmptyDataSet;
     FdMemEvolucao.FieldDefs.Clear;
  End;
  FdMemEvolucao.Close;
  If FdMemDetalheEvolucao.Active then
     FdMemDetalheEvolucao.EmptyDataSet;
  FdMemDetalheEvolucao.Close;
  TH := TThread.CreateAnonymousThread(procedure
  Var JsonArrayRetorno        : TJsonArray;
      JsonArrayRetornoDetalhe : TJsonArray;
      ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
      vErro : String;
      pErro : Boolean;
  begin
    TThread.Synchronize(nil, procedure
    Begin
      FrmRelEvolucaoRessuprimentos.Enabled := False;
    End);
    pErro := False;
    ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
    if CbTipoAnalise.ItemIndex = 0 then Begin
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoPed(aParams);
       if (Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) and (Not JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro)) then
          FdMemEvolucao.LoadFromJson(JsonArrayRetorno, False)
       else
          pErro := True;
    End
    Else if CbTipoAnalise.ItemIndex = 1 then Begin
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoVol(aParams);
       if (Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) and (Not JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro)) then Begin
          FdMemEvolucao.LoadFromJson(JsonArrayRetorno, False);
          JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidEmbalagem(aParams, 'Vol');
          if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
             FdMemDetalheEvolucao.LoadFromJson(JsonArrayRetorno, False);
       End
       Else
          pErro := True;
    End
    Else if CbTipoAnalise.ItemIndex = 2 then Begin
       if (pTipoResumo = 0) or (CbTipoAnalise.ItemIndex <> 2) then
          JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnid(aParams)
       Else
          JsonArrayRetorno := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidZona(aParams);
       if (Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) and (Not JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro)) then Begin
          FdMemEvolucao.LoadFromJson(JsonArrayRetorno, False);
          JsonArrayRetornoDetalhe := ObjPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidEmbalagem(aParams, 'Unid');
          if Not JsonArrayRetornoDetalhe.Items[0].TryGetValue('Erro', vErro) then
             FdMemDetalheEvolucao.LoadFromJson(JsonArrayRetornoDetalhe, False);
       End
       Else
          pErro := True;
    End;
    if Not pErro then Begin
       if ((CbTipoAnalise.ItemIndex<>2) and JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) or ((CbTipoAnalise.Itemindex = 2) and JsonArrayRetornoDetalhe.Items[0].TryGetValue('Erro', vErro)) then Begin
          JsonArrayRetorno := Nil;
          JsonArrayRetornoDetalhe := Nil;
          ObjPedidoSaidaCtrl.Free;
          aParams := Nil;
          Raise Exception.Create('Erro: '+vErro);
       End
       Else Begin
          if FdMemEvolucao.IsEmpty then begin
             JsonArrayRetorno := Nil;
             JsonArrayRetornoDetalhe := Nil;
             ObjPedidoSaidaCtrl.Free;
             aParams := Nil;
             raise Exception.Create('Não foram encontrados dados de acordo com os filtros aplicados.');
          End;
          FdMemEvolucao.Open(); //Dados do Painel
          if CbTipoAnalise.ItemIndex > 0 then
             FdMemDetalheEvolucao.Open(); //Dados Painel Lateral -Embalagens
          MontaListaEvolucao;
       End;
    End
    Else Begin
       JsonArrayRetornoDetalhe := Nil;
       JsonArrayRetorno := Nil;
       ObjPedidoSaidaCtrl.Free;
       aParams := Nil;
       Raise Exception.Create(vErro);
    End;
    JsonArrayRetornoDetalhe := Nil;
    JsonArrayRetorno := Nil;
    ObjPedidoSaidaCtrl.Free;
    aParams := Nil;
  end);
  TH.OnTerminate := ThreadValidarPesquisarDados;
  TH.Start;
end;

procedure TFrmRelEvolucaoRessuprimentos.ThreadValidarPesquisarDados(
  Sender: TObject);
begin
  FrmRelEvolucaoRessuprimentos.Enabled := True;
  if Assigned(TThread(Sender).FatalException) then begin
     ShowErro(Exception(TThread(sender).FatalException).Message, 'alerta');
     Exit;
  end;
  if (CbTipoAnalise.ItemIndex in [1, 2]) then //   RbVolume.Checked) or (RbUnidade.Checked) then
     MontaDSHDetalhes;
end;

end.