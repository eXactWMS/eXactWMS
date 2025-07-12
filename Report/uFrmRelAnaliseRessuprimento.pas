unit uFrmRelAnaliseRessuprimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, DataSet.Serialize, System.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, Vcl.Buttons, JvToolEdit, Vcl.DBGrids, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.ComCtrls, ACBrBase, ACBrETQ, dxCameraControl,
  EnderecamentoZonaCtrl, Views.Pequisa.EnderecamentoZonas;

type
  TFrmRelAnaliseRessuprimento = class(TFrmReportBase)
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
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    BtnPesqCliente: TBitBtn;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    LblRegistro: TLabel;
    Label4: TLabel;
    LblDemanda: TLabel;
    LblCubagem: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    LblApanhe: TLabel;
    Labelchekcou: TLabel;
    LblCheckout: TLabel;
    LblExpedicao: TLabel;
    Label11: TLabel;
    FdMemPesqGeralPessoaid: TIntegerField;
    FdMemPesqGeralCodPessoaERP: TIntegerField;
    FdMemPesqGeralRazao: TStringField;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralRecebido: TIntegerField;
    FdMemPesqGeralCubagem: TIntegerField;
    FdMemPesqGeralApanhe: TIntegerField;
    FdMemPesqGeralCheckOut: TIntegerField;
    FdMemPesqGeralExpedicao: TIntegerField;
    FdMemPesqGeralCancelado: TIntegerField;
    FdMemPesqGeralMedProducao: TFloatField;
    Label8: TLabel;
    LblCancelado: TLabel;
    GbAnalise: TGroupBox;
    RbAnalisePedido: TRadioButton;
    RbAnaliseVolumes: TRadioButton;
    GbZona: TGroupBox;
    Label10: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    LblZona: TLabel;
    RbAnalisaVolumeZonas: TRadioButton;
    FdMemPesqGeralFantasia: TStringField;
    Label12: TLabel;
    Shape1: TShape;
    Label14: TLabel;
    Shape2: TShape;
    Label15: TLabel;
    Label16: TLabel;
    Shape3: TShape;
    Label17: TLabel;
    Shape4: TShape;
    Label18: TLabel;
    LblTotIAP: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInicioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure LstCadastroDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure RbAnalisePedidoClick(Sender: TObject);
    procedure EdtZonaIdEnter(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    Procedure MontaListaAnalise;
  public
    { Public declarations }
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar; OverRide;
  end;

var
  FrmRelAnaliseRessuprimento: TFrmRelAnaliseRessuprimento;

implementation

{$R *.dfm}

Uses PedidoSaidaCtrl, PessoaCtrl, RotaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas,
  uFuncoes;

procedure TFrmRelAnaliseRessuprimento.BtnPesqClienteClick(Sender: TObject);
begin
  inherited;
  if EdtDestinatario.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioExit(EdtDestinatario);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmRelAnaliseRessuprimento.BtnPesqRotaClick(Sender: TObject);
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

procedure TFrmRelAnaliseRessuprimento.BtnPesqZonaClick(Sender: TObject);
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

procedure TFrmRelAnaliseRessuprimento.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtDestinatario.Text = '' then Begin
     LblDestinatario.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblDestinatario.Caption := '';
     ObjPessoaCtrl   := Nil;
     ReturnjsonArray := Nil;
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ObjPessoaCtrl   := Nil;
  ReturnjsonArray := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelAnaliseRessuprimento.EdtInicioChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtRotaId then
     LblRota.Caption := ''
  Else If Sender = EdtDestinatario Then
     LblDestinatario.Caption := '';
  LblRegistro.caption    := '';
  LblDemanda.Caption     := '';
  LblCubagem.Caption     := '';
  LblApanhe.Caption      := '';
  LblCheckOut.Caption    := '';
  LblExpedicao.Caption   := '';
  LblCancelado.Caption   := '';
  LstReport.RowCount     := 1;
  FdMemPesqGeral.Close;
  ImprimirExportar(False);
end;

procedure TFrmRelAnaliseRessuprimento.EdtRotaIdExit(Sender: TObject);
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
     Player('toast4');
     ShowErro( '😢Rota('+EdtRotaId.Text+') inválida!' );
     EdtRotaId.Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     Player('toast4');
     ShowErro( '😢Rota não('+EdtRotaId.Text+') encontrado!');
     EdtRotaId.Clear;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  ReturnLstRota := Nil;
  ObjRotaCtrl   := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelAnaliseRessuprimento.EdtZonaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRelAnaliseRessuprimento.EdtZonaIdExit(Sender: TObject);
Var ObjZonaCtrl     : TEnderecamentoZonaCtrl;
    JsonArrayReturn : TJsonArray;
    vErro : String;
begin
  inherited;
  if EdtZonaId.Text = '' then Begin
     LblZona.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Begin
     LblZona.Caption := '';
     Player('alarme');
     ShowErro( '😢Zona('+EdtZonaId.Text+') inválida!' );
     EdtZonaId.Clear;
     Exit;
  end;
  ObjZonaCtrl   := TEnderecamentoZonaCtrl.Create;
  JsonArrayReturn := ObjZonaCtrl.FindEnderecamentoZona(StrToIntDef(EdtZonaId.text, 0), '', 0);
  if (JsonArrayReturn.Items[0].TryGetValue('Erro', vErro)) then Begin
     LblZona.Caption := '';
     Player('alarme');
     ShowErro( '😢Zona não('+EdtZonaId.Text+') encontrada!');
     EdtZonaId.Clear;
  end
  Else
     LblZona.Caption := JsonArrayReturn.Items[0].GetValue<String>('descricao');
  JsonArrayReturn := Nil;
  ObjZonaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelAnaliseRessuprimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.Close;
  FrmRelAnaliseRessuprimento := Nil;
end;

procedure TFrmRelAnaliseRessuprimento.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 60;
  LstReport.ColWidths[1]  := 80;
  LstReport.ColWidths[2]  := 320;
  LstReport.ColWidths[3]  := 150;
  LstReport.ColWidths[4]  := 60;
  LstReport.ColWidths[5]  := 60;
  LstReport.ColWidths[6]  := 60;
  LstReport.ColWidths[7]  := 60;
  LstReport.ColWidths[8]  := 60;
  LstReport.ColWidths[9]  := 70;
  LstReport.ColWidths[10] := 75;
  LstReport.ColWidths[11] := 50;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
  LstReport.Alignments[11, 0] := taRightJustify;
  LblRegistro.caption    := '';
  LblDemanda.Caption     := '';
  LblCubagem.Caption     := '';
  LblApanhe.Caption      := '';
  LblCheckOut.Caption    := '';
  LblExpedicao.Caption   := '';
  LblCancelado.Caption   := '';
  LstReport.FixedRows    := 0;
  LstReport.RowCount     := 1;
end;

procedure TFrmRelAnaliseRessuprimento.FormShow(Sender: TObject);
begin
  inherited;
  EdtInicio.SetFocus;
end;

procedure TFrmRelAnaliseRessuprimento.Limpar;
begin
  inherited;
  LblTotIAP.Caption := '0,00%';
end;

procedure TFrmRelAnaliseRessuprimento.LstCadastroDblClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
//
end;

procedure TFrmRelAnaliseRessuprimento.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelAnaliseRessuprimento.MontaListaAnalise;
Var vDemanda, vCubagem, vApanhe, vCheckout, vExpedicao, vCancelado, vIndiceIAP : Integer;
begin
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  BtnImprimirStand.Grayed := False;
  BtnExportarStand.Grayed := False;
  LstReport.FixedRows := 1;
  LblRegistro.Caption := FormatFloat('0', FdMemPesqGeral.RecordCount);
  vDemanda   := 0;
  vCubagem   := 0;
  vApanhe    := 0;
  vCheckout  := 0;
  vExpedicao := 0;
  vCancelado := 0;
  vIndiceIAP := 0;
  while Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.Recno.ToString;
    LstReport.Cells[1, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[2, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[3, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Rota').AsString;
    LstReport.Cells[4, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Demanda').AsString;
    LstReport.Cells[5, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Recebido').AsString;
    LstReport.Cells[6, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Cubagem').AsString;
    LstReport.Cells[7, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Apanhe').AsString;
    LstReport.Cells[8, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('CheckOut').AsString;
    LstReport.Cells[9, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Expedicao').AsString;
    LstReport.Cells[10, FdMemPesqGeral.RecNo]  := FdMemPesqGeral.FieldByName('Cancelado').AsString;
    LstReport.Cells[11, FdMemPesqGeral.RecNo]  := FormatFloat('0.0', FdMemPesqGeral.FieldByName('MedProducao').AsFloat);
    vDemanda   := vDemanda   + FdMemPesqGeral.FieldByName('Demanda').AsInteger;
    vCubagem   := vCubagem   + FdMemPesqGeral.FieldByName('Cubagem').AsInteger;
    vApanhe    := vApanhe    + FdMemPesqGeral.FieldByName('Apanhe').AsInteger;
    vCheckout  := vCheckout  + FdMemPesqGeral.FieldByName('CheckOut').AsInteger;
    vExpedicao := vExpedicao + FdMemPesqGeral.FieldByName('Expedicao').AsInteger;
    vCancelado := vCancelado + FdMemPesqGeral.FieldByName('Cancelado').AsInteger;

    if FdMemPesqGeral.FieldByName('MedProducao').AsFloat >= 100 then Begin
       LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClGreen;
       Inc(vIndiceIAP);
    End
    Else If FdMemPesqGeral.FieldByName('MedProducao').AsFloat >= 90 then
      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClYellow
    Else If FdMemPesqGeral.FieldByName('MedProducao').AsFloat > 0 then
      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClRed
    Else
      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClWhite;
//    if FdMemPesqGeral.FieldByName('Demanda').AsInteger > (FdMemPesqGeral.FieldByName('Expedicao').AsInteger+FdMemPesqGeral.FieldByName('Cancelado').AsInteger) then
//       LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClRed
//    Else If FdMemPesqGeral.FieldByName('Demanda').AsInteger = (FdMemPesqGeral.FieldByName('Expedicao').AsInteger+FdMemPesqGeral.FieldByName('Cancelado').AsInteger) then
//      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClGreen
//    Else
///      LstReport.Colors[11, FdMemPesqGeral.RecNo] := ClWhite;
    LstReport.Alignments[0, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.FontStyles[0, FdmemPesqGeral.Recno] := [FsBold];
    LstReport.Alignments[1, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[4, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[5, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[6, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[7, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[8, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[9, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[10, FdMemPesqGeral.RecNo] := taRightJustify;
    LstReport.Alignments[11, FdMemPesqGeral.RecNo] := taRightJustify;
    FdMemPesqGeral.Next;
  End;
  LblDemanda.Caption   := FormatFloat('0', vDemanda);
  LblCubagem.Caption   := FormatFloat('0', vCubagem);
  LblApanhe.Caption    := FormatFloat('0', vApanhe);
  LblCheckout.Caption  := FormatFloat('0', vCheckOut);
  LblExpedicao.Caption := FormatFloat('0', vExpedicao);
  LblCancelado.Caption := FormatFloat('0', vCancelado);
  LblTotIAP.Caption := FormatFloat('0.00', vIndiceIAP / FdMemPesqGeral.RecordCount * 100)+'%';
  ImprimirExportar(True);
end;

procedure TFrmRelAnaliseRessuprimento.PesquisarDados;
Var aParams : TDictionary<String, String>;
    ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonArrayRetorno   : TjsonArray;
begin
  if (Not RbAnalisePedido.Checked) and (Not RbAnaliseVolumes.Checked) then Begin
     ShowErro('Selecione o tipo de Análise!');
     Exit;
  End;
  inherited;
  aParams := TDictionary<String, String>.Create;
  if (EdtInicio.Text='  /  /    ') and (EdtTermino.Text='  /  /    ') and (StrToIntDef(EdtRotaId.Text,0)=0) and
     (StrToIntDef(EdtDestinatario.Text,0)=0) Then
     raise Exception.Create('Aplique filtro para a pesquisa!');
  if EdtInicio.Text <> '  /  /    ' then
     AParams.Add('dtinicio', EdtInicio.Text);
  if EdtTermino.Text <> '  /  /    ' then
     AParams.Add('dttermino', EdtTermino.Text);
  if StrToIntDef(EdtRotaId.Text,0)>0 then
     AParams.Add('rotaid', EdtRotaId.Text);
  if StrToIntDef(EdtDestinatario.Text,0)>0 then
     AParams.Add('codpessoaerp', EdtDestinatario.Text);
  if StrToIntDef(EdtZonaId.Text,0)>0 then
     AParams.Add('zonaid', EdtZonaId.Text);
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
  Try
    if RbAnalisePedido.Checked then
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetRelAnaliseRessuprimento(aParams, False)
    Else Begin
       RbAnaliseVolumes.Checked;
       JsonArrayRetorno := ObjPedidoSaidaCtrl.GetRelAnaliseRessuprimento(aParams, True);
    End;
    FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
    if FdMemPesqGeral.IsEmpty then
       ShowErro('Não foram encontrados dados de acordo com os filtros aplicados.')
    Else
       MontaListaAnalise;
  Except On E: Exception do begin
    ShowMessage('Erro: '+E.Message);
    end;
  End;
  JsonArrayRetorno := Nil;
  ObjPedidoSaidaCtrl.Free;
  FreeAndNil(aParams);
end;

procedure TFrmRelAnaliseRessuprimento.RbAnalisePedidoClick(Sender: TObject);
begin
  inherited;
  GbZona.Visible := (RbAnaliseVolumes.Checked) or (RbAnalisaVolumeZonas.Checked);
end;

end.
