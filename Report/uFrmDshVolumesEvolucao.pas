unit uFrmDshVolumesEvolucao;

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
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, PedidoVolumeCtrl, Vcl.Samples.Gauges, JvToolEdit,
  System.Generics.Collections, DataSet.Serialize, System.Json, Rest.Types,
  PessoaCtrl, EnderecamentoZonaCtrl;

type
  TFrmDshVolumesEvolucao = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EdtInicio: TJvDateEdit;
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
    GroupBox3: TGroupBox;
    PnlPendente: TPanel;
    Label4: TLabel;
    LblPendente: TLabel;
    Label18: TLabel;
    PgrCubagem: TGauge;
    PnlApanhe: TPanel;
    Label7: TLabel;
    LblApanhe: TLabel;
    Label19: TLabel;
    PgrApanhe: TGauge;
    PnlCheckOut: TPanel;
    Label6: TLabel;
    LblCheckOut: TLabel;
    Label20: TLabel;
    PgrCheckOut: TGauge;
    PnlExpedicao: TPanel;
    Label15: TLabel;
    LblExpedicao: TLabel;
    Label21: TLabel;
    PgrExpedicao: TGauge;
    PnlCortes: TPanel;
    Label11: TLabel;
    LblCortes: TLabel;
    Label23: TLabel;
    PgrCortes: TGauge;
    PnlCancelado: TPanel;
    Label16: TLabel;
    LblCancelado: TLabel;
    Label22: TLabel;
    PgrCancelado: TGauge;
    PnlEficiencia: TPanel;
    Label8: TLabel;
    LblEficiencia: TLabel;
    Label24: TLabel;
    Label40: TLabel;
    CbTipoAnalise: TComboBox;
    GroupBox2: TGroupBox;
    Label41: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    Label3: TLabel;
    CbAtualizacao: TComboBox;
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure EdtRotaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure EdtInicioEnter(Sender: TObject);
    procedure EdtInicioExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtRotaIdChange(Sender: TObject);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
  public
    { Public declarations }
  private
    { Private declarations }
    Procedure MontaListaEvolucao;
    Procedure MontaDSHDetalhes;
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
  end;

var
  FrmDshVolumesEvolucao: TFrmDshVolumesEvolucao;

implementation

{$R *.dfm}

uses Views.Pequisa.Pessoas, Views.Pequisa.Rotas, Views.Pequisa.EnderecamentoZonas, uFuncoes, RotaCtrl;

{ TFrmDshVolumesEvolucao }

procedure TFrmDshVolumesEvolucao.BtnPesqClienteClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
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
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmDshVolumesEvolucao.BtnPesqRotaClick(Sender: TObject);
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

procedure TFrmDshVolumesEvolucao.BtnPesqZonaClick(Sender: TObject);
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

procedure TFrmDshVolumesEvolucao.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  LblDestinatario.Caption := '';
  Limpar;
end;

procedure TFrmDshVolumesEvolucao.EdtDestinatarioExit(Sender: TObject);
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
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmDshVolumesEvolucao.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmDshVolumesEvolucao.EdtInicioEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmDshVolumesEvolucao.EdtInicioExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmDshVolumesEvolucao.EdtRotaIdChange(Sender: TObject);
begin
  inherited;
  LblRota.Caption := '';
  Limpar;
end;

procedure TFrmDshVolumesEvolucao.EdtRotaIdExit(Sender: TObject);
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
     ShowErro( '😢Rota('+EdtRotaId.Text+') inválida!' );
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

procedure TFrmDshVolumesEvolucao.EdtRotaIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmDshVolumesEvolucao.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '';
  Limpar;
end;

procedure TFrmDshVolumesEvolucao.EdtZonaIdExit(Sender: TObject);
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
     ShowErro( '😢Zona('+EdtZonaId.Text+') inválida!' );
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

procedure TFrmDshVolumesEvolucao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmDshVolumesEvolucao := Nil;
end;

procedure TFrmDshVolumesEvolucao.FormCreate(Sender: TObject);
begin
  inherited;
  CbTipoAnalise.ItemIndex := 0;
  CbAtualizacao.ItemIndex := 0;
end;

procedure TFrmDshVolumesEvolucao.Limpar;
begin
  inherited;
  LblPendente.Caption      := '0';
  LblApanhe.Caption        := '0';
  LblCheckout.Caption      := '0';
  LblExpedicao.Caption     := '0';
  LblCancelado.Caption     := '0';
  LblCortes.Caption        := '0';
  PgrCubagem.Progress      := 0;
  PgrApanhe.Progress       := 0;
  PgrCheckOut.Progress     := 0;
  PgrExpedicao.Progress    := 0;
  PgrCancelado.Progress    := 0;
  PgrCortes.Progress       := 0;
  LblEficiencia.Caption            := '0%';
  LstReport.ClearRect(0, 1, LstReport.ColCount-1, LstReport.RowCount-1);
end;

procedure TFrmDshVolumesEvolucao.MontaDSHDetalhes;
begin

end;

procedure TFrmDshVolumesEvolucao.MontaListaEvolucao;
Var vTotalPendente, vTotalSeparacao, vTotalCheckOut : Integer;
    vTotalExpedicao, vTotalCancelado, vTotalCortes, vTotalProducao : Integer;
begin
  vTotalPendente  := 0;
  vTotalSeparacao := 0;
  vTotalCheckOut  := 0;
  vTotalExpedicao := 0;
  vTotalCancelado := 0;
  vTotalCortes    := 0;
  vTotalProducao  := 0;
  FdMemPesqGeral.First;
  while Not FdMemPesqGeral.Eof do Begin
    if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 2 then
       vTotalPendente := vTotalPendente + FdMemPesqGeral.FieldByName('TotalVolume').AsInteger
    Else if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger < 9 then
       vTotalSeparacao := vTotalSeparacao + FdMemPesqGeral.FieldByName('TotalVolume').AsInteger
    Else if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger < 13 then
       vTotalCheckOut := vTotalCheckOut + FdMemPesqGeral.FieldByName('TotalVolume').AsInteger
    Else if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 15 then
       vTotalCancelado := vTotalCancelado + FdMemPesqGeral.FieldByName('TotalVolume').AsInteger
    Else //if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger > 11 then
       vTotalExpedicao := FdMemPesqGeral.FieldByName('TotalVolume').AsInteger;
    LblPendente.Caption   := vtotalPendente.ToString;
    LblApanhe.Caption     := vTotalSeparacao.ToString;
    LblCheckOut.Caption   := vTotalCheckOut.ToString;
    LblCancelado.Caption  := vTotalCancelado.ToString;
    LblExpedicao.Caption  := vTotalExpedicao.ToString;
    vTotalProducao := vTotalProducao +  FdMemPesqGeral.FieldByName('TotalVolume').AsInteger;
    FdMemPesqGeral.Next;
  End;
  LblEficiencia.Caption := FormatFloat('##0.00', vTotalExpedicao / (vTotalPendente+vTotalSeparacao+vTotalCheckOut+
                                       vTotalExpedicao+vTotalCancelado+vTotalCortes) * 100)+'%';
end;

procedure TFrmDshVolumesEvolucao.PesquisarDados;
Var aParams : TDictionary<String, String>;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno    : TJsonArray;
    vErro               : String;
begin
  inherited;
  if EdtInicio.Text = '  /  /    ' then Begin
     ShowErro('Informe a data!');
     Exit;
  End;
  Try StrToDate(EdtInicio.Text) Except raise Exception.Create('Data inválida!'); End;
  if CbTipoAnalise.ItemIndex < 0 then
     raise Exception.Create('Selecione o tipo de evolução para análise.');
  aParams := TDictionary<String, String>.Create;
  if EdtInicio.Text <> '  /  /    ' then
     AParams.Add('datainicio', EdtInicio.Text);
  if StrToIntDef(EdtRotaId.Text,0)>0 then
     AParams.Add('rotaid', EdtRotaId.Text);
  if StrToIntDef(EdtZonaId.Text,0)>0 then
     AParams.Add('zonaid', EdtZonaId.Text);
  if StrToIntDef(EdtDestinatario.Text, 0)>0 then
     AParams.Add('codpessoaerp', EdtDestinatario.Text);
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  if CbTipoAnalise.ItemIndex = 0 then
     JsonArrayRetorno := ObjPedidoVolumeCtrl.DshVolumeEvolucao_Quantidade(aParams)
  Else if CbTipoAnalise.ItemIndex = 1 then
     JsonArrayRetorno := ObjPedidoVolumeCtrl.DshVolumeEvolucao_Unidades(aParams);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro(vErro)
  Else begin
     FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
     if FdMemPesqGeral.IsEmpty then begin
        ObjPedidoVolumeCtrl.Free;
        JsonArrayRetorno := Nil;
        aParams.Free;
        raise Exception.Create('Não foram encontrados dados de acordo com os filtros aplicados.');
     End;
     MontaListaEvolucao;
  end;
  JsonArrayRetorno := Nil;
  ObjPedidoVolumeCtrl.Free;
  aParams.Free;
end;

end.
