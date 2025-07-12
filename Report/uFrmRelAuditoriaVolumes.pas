unit uFrmRelAuditoriaVolumes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, Generics.Collections, System.Json, Rest.Types,
  PedidoVolumeCtrl, Vcl.DialogMessage, EnderecamentoZonaCtrl;

type
  TFrmRelAuditoriaVolumes = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoId: TEdit;
    EdtDocumentoNr: TEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    BtnPesqCliente: TBitBtn;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    GbTipoVolume: TGroupBox;
    CbTipoVolume: TComboBox;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralData: TDateField;
    FdMemPesqGeralDocumentoNr: TStringField;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    FdMemPesqGeralSequencia: TIntegerField;
    FdMemPesqGeralEmbalagem: TStringField;
    FdMemPesqGeralTipo: TStringField;
    FdMemPesqGeralCaixaEmbalagemId: TIntegerField;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralCodPessoaERP: TIntegerField;
    FdMemPesqGeralRotaId: TIntegerField;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralRazao: TStringField;
    FdMemPesqGeralPapelao: TIntegerField;
    GroupBox8: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    LblTotCxaFechada: TLabel;
    LblTotCxaPlastica: TLabel;
    Label8: TLabel;
    LblTotCxaPapelao: TLabel;
    LblPercCxaPlastica: TLabel;
    LblPercCxaFechada: TLabel;
    LblPercCxaPapelao: TLabel;
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPedidoIdChange(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure EdtPedidoIdExit(Sender: TObject);
  private
    { Private declarations }
    vCodProduto : Integer;
    Procedure LimparDetalhes;
  Protected
    Procedure Limpar; OverRide;
    procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure PesquisarDados; OverRide;
    Procedure Imprimir; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelAuditoriaVolumes: TFrmRelAuditoriaVolumes;

implementation

{$R *.dfm}

Uses uFrmeXactWMS, uFuncoes, RotaCtrl, PessoaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas,
  Views.Pequisa.Processos, ProcessoCtrl, Views.Pequisa.Produtos, ProdutoCtrl, Views.Pequisa.EnderecamentoZonas;

procedure TFrmRelAuditoriaVolumes.BtnPesqClienteClick(Sender: TObject);
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

procedure TFrmRelAuditoriaVolumes.BtnPesqProcessoClick(Sender: TObject);
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

procedure TFrmRelAuditoriaVolumes.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if EdtCodProduto.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelAuditoriaVolumes.BtnPesqRotaClick(Sender: TObject);
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

procedure TFrmRelAuditoriaVolumes.BtnPesqZonaClick(Sender: TObject);
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

procedure TFrmRelAuditoriaVolumes.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
  End
  Else Begin
     LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
     vCodProduto := JsonProduto.GetValue<Integer>('codproduto');
  End;
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmRelAuditoriaVolumes.EdtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelAuditoriaVolumes.EdtDestinatarioExit(Sender: TObject);
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
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') inválido!' );
     EdtDestinatario.Clear;
     EdtDestinatario.SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     EdtDestinatario.SetFocus;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelAuditoriaVolumes.EdtPedidoIdChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtRotaId then lblRota.Caption := '...'
  Else if Sender = EdtCodProduto then Begin
     lblProduto.Caption := '...';
     vCodProduto := 0;
  End
  Else if Sender = EdtDestinatario then LblDestinatario.Caption := '...'
  Else if Sender = EdtProcessoId then lblProcesso.Caption := '...'
  Else if Sender = EdtZonaId then LblZona.Caption := '...' ;
  Limpar;
end;

procedure TFrmRelAuditoriaVolumes.EdtPedidoIdExit(Sender: TObject);
begin
  inherited;
  if (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoId.Text, 0) <= 0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoId.Text+') do Pedido inválido!');
     EdtPedidoId.Clear;
     Exit;
  End;
end;

procedure TFrmRelAuditoriaVolumes.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl  : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  if EdtProcessoId.Text = '' then Begin
     LblProcesso.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtProcessoId.Text, 0) <= 0 then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo('+EdtProcessoId.Text+') inválido!' );
     EdtProcessoId.Clear;
     EdtProcessoId.SetFocus;
     Exit;
  end;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(EdtProcessoId.text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo não('+EdtProcessoId.Text+') encontrado!');
     EdtProcessoId.Clear;
     EdtProcessoId.SetFocus;
  end
  Else
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  JsonArrayRetorno := Nil;
  ObjProcessoCtrl  := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelAuditoriaVolumes.EdtRotaIdExit(Sender: TObject);
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
     EdtRotaId.SetFocus;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     ShowErro( '😢Rota('+EdtRotaId.Text+') não encontrada!' );
     EdtRotaId.Clear;
     EdtRotaId.SetFocus;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
//  ReturnLstRota.Free;
  FreeAndNil(ObjRotaCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelAuditoriaVolumes.EdtZonaIdExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if EdtZonaId.Text = '' then Begin
     LblZona.Caption := '';
     ExitFocus(EdtZonaid);
     Exit;
  End;
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Begin
     LblZona.Caption := '';
     ShowErro( '😢Código('+EdtZonaId.Text+') de Zona/Setor inválido!' );
     EdtZonaId.Clear;
     EdtZonaId.SetFocus;
  end;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  JsonArrayZona := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(TEdit(Sender).Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Erro : '+vErro);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else Begin
     LblZona.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
     EdtZonaId.Text;
  End;
  JsonArrayZona := Nil;
  ObjEnderecamentoZonaCtrl.Free;
end;

procedure TFrmRelAuditoriaVolumes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelAuditoriaVolumes := Nil;
end;

procedure TFrmRelAuditoriaVolumes.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0 ;
  LstReport.ColWidths[0]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[1]  :=  85+Trunc(85*ResponsivoVideo);
  LstReport.ColWidths[2]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  50+Trunc(50*ResponsivoVideo);
  LstReport.ColWidths[5]  := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[6]  :=  45+Trunc(45*ResponsivoVideo);
  LstReport.ColWidths[7]  :=  55+Trunc(55*ResponsivoVideo);
  LstReport.ColWidths[8]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[9]  := 160+Trunc(160*ResponsivoVideo);
  LstReport.ColWidths[10] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[11] := 150+Trunc(150*ResponsivoVideo);
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[1, 0] := taCenter;
  LstReport.Alignments[3, 0] := taRightJustify;
  LstReport.Alignments[4, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taCenter;
  LstReport.Alignments[7, 0] := taCenter;
  CbTipoVolume.ItemIndex     := 0;
end;

procedure TFrmRelAuditoriaVolumes.Imprimir;
begin
  inherited;

end;

procedure TFrmRelAuditoriaVolumes.Limpar;
begin
  inherited;
  LimparDetalhes;
end;

procedure TFrmRelAuditoriaVolumes.LimparDetalhes;
begin
  LblTotCxaFechada.Caption   := '0';
  LblTotCxaPlastica.Caption  := '0';
  LblTotCxaPapelao.Caption   := '0';
  LblPercCxaFechada.Caption  := '0,00';
  LblPercCxaPlastica.Caption := '0,00';
  LblPercCxaPapelao.Caption  := '0,00';
end;

procedure TFrmRelAuditoriaVolumes.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xReg : Integer;
    TotCxaFechada, TotCxaPlastica, TotCxaPapelao : Integer;
begin
  inherited;
  FdMemPesqGeral.First;
  TotCxaFechada  := 0;
  TotCxaPlastica := 0;
  TotCxaPapelao  := 0;
  for xReg := 1 to FdMemPesqGeral.RecordCount do begin
    LstReport.AddDataImage( 6, xReg, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstReport.AddDataImage( 7, xReg, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  end;
  xReg := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xReg] := FdMemPesqGeral.FieldByName('pedidoid').AsString;
    LstReport.Cells[1, xReg] := FdMemPesqGeral.FieldByName('Data').AsString;
    LstReport.Cells[2, xReg] := FdMemPesqGeral.FieldByName('DocumentoNr').AsString;
    LstReport.Cells[3, xReg] := FdMemPesqGeral.FieldByName('PedidoVolumeId').AsString;
    LstReport.Cells[4, xReg] := FdMemPesqGeral.FieldByName('Sequencia').AsString;
    LstReport.Cells[5, xReg] := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    if FdMemPesqGeral.FieldByName('Tipo').AsString = 'N' then
       LstReport.Cells[6, xReg] := '0'
    Else LstReport.Cells[6, xReg] := '1';
    LstReport.Cells[7, xReg]  := FdMemPesqGeral.FieldByName('Papelao').AsString;
    LstReport.Cells[8, xReg]  := FdMemPesqGeral.FieldByName('CaixaEmbalagemId').AsString;
    LstReport.Cells[9, xReg]  := FdMemPesqGeral.FieldByName('ProcessoId').AsString+' '+FdMemPesqGeral.FieldByName('Processo').AsString;
    LstReport.Cells[10, xReg] := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString+' '+FdMemPesqGeral.FieldByName('Razao').AsString;
    LstReport.Cells[11, xReg] := FdMemPesqGeral.FieldByName('RotaId').AsString+' '+FdMemPesqGeral.FieldByName('Rota').AsString;
    if FdMemPesqGeral.FieldByName('Embalagem').AsString = 'Cxa.Fechada' then
       Inc(TotCxaFechada)
    Else if (FdMemPesqGeral.FieldByName('Embalagem').AsString = 'Fracionados') and
         (FdMemPesqGeral.FieldByName('Papelao').AsInteger = 0) then
       Inc(TotCxaPlastica)
    Else if (FdMemPesqGeral.FieldByName('Embalagem').AsString = 'Fracionados') and
         (FdMemPesqGeral.FieldByName('Papelao').AsInteger = 1) then
       Inc(TotCxaPapelao);
    if FdMemPesqGeral.FieldByName('RotaId').AsInteger = 0 then Begin
       LstReport.Colors[11, xReg] := ClRed;
    End
    Else begin
       LstReport.Colors[11, xReg] := LstReport.Colors[2, xReg];
    end;
    if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 8 then
       LstReport.Colors[9, xReg] := $00B0FFFF
    Else if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger in [10, 12] then
       LstReport.Colors[9, xReg] := $006FB7FF
    Else If FdMemPesqGeral.FieldByName('ProcessoId').AsInteger in [13, 14] then
       LstReport.Colors[9, xReg] := $00006C00
    Else If FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 15 then
       LstReport.Colors[9, xReg] := ClRed
    Else LstReport.Colors[9, xReg] := LstReport.Colors[2, xReg];
    LstReport.Alignments[0, xReg]  := taRightJustify;
    LstReport.FontStyles[0, xReg]  := [FsBold];
    LstReport.Alignments[1, xReg]  := taCenter;
    LstReport.Alignments[3, xReg]  := taRightJustify;
    LstReport.Alignments[4, xReg]  := taRightJustify;
    LstReport.Alignments[6, xReg]  := taCenter;
    LstReport.Alignments[7, xReg]  := taCenter;
    FdMemPesqGeral.Next;
    Inc(xReg);
  End;
  LblTotCxaFechada.Caption   := TotCxaFechada.ToString;
  LblTotCxaPlastica.Caption  := TotCxaPlastica.ToString;
  LblTotCxaPapelao.Caption   := TotCxaPapelao.ToString;
  LblPercCxaFechada.Caption  := FormatFloat('##0.00', TotCxaFechada/StrToIntDef(LblTotRegistro.caption, 0)*100)+'%';
  LblPercCxaPlastica.Caption := FormatFloat('##0.00', TotCxaPlastica/StrToIntDef(LblTotRegistro.caption, 0)*100)+'%';
  LblPercCxaPapelao.Caption  := FormatFloat('##0.00', TotCxaPapelao/StrToIntDef(LblTotRegistro.caption, 0)*100)+'%';
end;

procedure TFrmRelAuditoriaVolumes.PesquisarDados;
Var vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vRecebido, vCubagem, vEtiqueta, pTipoVolume, pUsuarioId : Integer;
begin
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  if (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoId.Text, 0) <= 0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoId.Text+') do Pedido inválido!');
     EdtPedidoId.Clear;
     EdtPedidoId.SetFocus;
     Exit;
  End;
  if (EdtCodProduto.Text<>'') and (StrToInt64Def(EdtCodProduto.Text, 0) <= 0) then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     Exit;
  end;
  if (EdtDestinatario.Text<>'') and (StrToIntDef(EdtDestinatario.Text, 0) <= 0) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') inválido!' );
     EdtDestinatario.Clear;
     EdtDestinatario.SetFocus;
     Exit;
  end;
  if (EdtRotaId.Text<>'') and (StrToIntDef(EdtRotaId.Text, 0) <= 0)then Begin
     LblRota.Caption := '';
     ShowErro( '😢Rota('+EdtRotaId.Text+') inválida!' );
     EdtRotaId.Clear;
     EdtRotaId.SetFocus;
     Exit;
  end;
  if (EdtProcessoId.Text<>'') and (StrToIntDef(EdtProcessoId.Text, 0) <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo('+EdtProcessoId.Text+') inválido!' );
     EdtProcessoId.Clear;
     EdtProcessoId.SetFocus;
     Exit;
  end;
  if (EdtZonaId.Text<>'') and (StrToIntDef(EdtZonaId.Text, 0) <= 0) then Begin
     LblZona.Caption := '';
     ShowErro( '😢Código('+EdtZonaId.Text+') de Zona/Setor inválido!' );
     EdtZonaId.Clear;
     EdtZonaId.SetFocus;
  end;
  if (EdtInicio.Text = '  /  /    ') or (EdtTermino.Text = '  /  /    ') then Begin
     EdtInicio.SetFocus;
     ShowErro('Informe o período do relatório.');
     Exit;
  End;
  Try
    vDtInicio :=StrToDate(EdtInicio.Text);
  Except On E: Exception do Begin
    EdtInicio.SetFocus;
    raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
    End;
  End;
  Try
    vDtFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do Begin
    EdtTermino.SetFocus;
    raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
    End;
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  pUsuarioId := 0; //StrToIntDef(EdtUsuarioId.Text, 0);
  TDialogMessage.ShowWaitMessage('Buscando Dados...',
    procedure
    Var JsonArrayRetorno : TJsonArray;
        ObjPedidoVolumeCtrl    : TPedidoVolumeCtrl;
    begin
      ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
      JsonArrayRetorno := ObjPedidoVolumeCtrl.GetAuditoriaVolumes(vDtInicio, vDtFInal,
                          StrToIntDef(EdtPedidoId.Text, 0), EdtDocumentoNr.Text, StrToIntDef(EdtRotaId.Text, 0),
                          StrToIntDef(EdtDestinatario.Text, 0), StrToIntDef(EdtProcessoId.Text, 0),
                          vCodProduto, StrToIntDef(EdtZonaId.Text, 0), CbTipoVolume.ItemIndex,
                          pUsuarioId ); //
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
        MontarLstAdvReport(JsonArrayRetorno);
      End;
      JsonArrayRetorno := Nil;
      ObjPedidoVolumeCtrl.Free;
    End);
end;

end.
