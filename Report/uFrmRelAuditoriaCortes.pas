unit uFrmRelAuditoriaCortes;

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
  JvExMask, JvSpin, JvToolEdit, DataSet.Serialize, Generics.Collections, System.Json, Rest.Types,
  PedidoVolumeCtrl, Vcl.DialogMessage;

type
  TFrmRelAuditoriaCortes = class(TFrmReportBase)
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
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    LblLinha: TLabel;
    EdtLinhaId: TEdit;
    BtnPesqLinha: TBitBtn;
    GbTipoVolume: TGroupBox;
    CbTipoVolume: TComboBox;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    FdMemPesqGeralSequencia: TIntegerField;
    FdMemPesqGeralTipo: TStringField;
    FdMemPesqGeralData: TDateField;
    FdMemPesqGeralLoteId: TIntegerField;
    FdMemPesqGeralLote: TStringField;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralQuantidade: TIntegerField;
    FdMemPesqGeralQtdAtendida: TIntegerField;
    FdMemPesqGeralCorte: TIntegerField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralCorteFinal: TIntegerField;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralUsuarioId: TIntegerField;
    FdMemPesqGeralNome: TStringField;
    FdMemPesqGeralCodPessoaERP: TIntegerField;
    FdMemPesqGeralRazao: TStringField;
    FdMemPesqGeralRotaId: TIntegerField;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralProduto: TStringField;
    procedure EdtPedidoIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure EdtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPedidoIdExit(Sender: TObject);
    procedure EdtLinhaIdExit(Sender: TObject);
  private
    { Private declarations }
    vCodProduto : Integer;
  Protected
    procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelAuditoriaCortes: TFrmRelAuditoriaCortes;

implementation

{$R *.dfm}

Uses uFrmeXactWMS, uFuncoes, RotaCtrl, PessoaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas,
  Views.Pequisa.Processos, ProcessoCtrl, Views.Pequisa.Produtos, ProdutoCtrl;

procedure TFrmRelAuditoriaCortes.BtnPesqClienteClick(Sender: TObject);
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

procedure TFrmRelAuditoriaCortes.BtnPesqProcessoClick(Sender: TObject);
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

procedure TFrmRelAuditoriaCortes.BtnPesqProdutoClick(Sender: TObject);
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

procedure TFrmRelAuditoriaCortes.BtnPesqRotaClick(Sender: TObject);
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

procedure TFrmRelAuditoriaCortes.EdtCodProdutoExit(Sender: TObject);
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
  End
  Else Begin
     LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
     vCodProduto        := JsonProduto.GetValue<Integer>('codproduto');
  End;
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmRelAuditoriaCortes.EdtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelAuditoriaCortes.EdtDestinatarioExit(Sender: TObject);
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
     EdtDestinatario.SetFocus;
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
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  FreeAndNil(ObjPessoaCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelAuditoriaCortes.EdtLinhaIdExit(Sender: TObject);
begin
  if EdtLinhaId.Text = '' then Exit;  
  inherited;
  if StrToIntDef(EdtLinhaId.Text, 0) <= 0 then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Id('+EdtLinhaId.Text+') da Linha inválido!' );
     EdtLinhaId.Clear;
     EdtLinhaId.SetFocus;
     Exit;
  end;
end;

procedure TFrmRelAuditoriaCortes.EdtPedidoIdChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtRotaId then lblRota.Caption := '...'
  Else if Sender = EdtCodProduto then Begin
     vCodProduto := 0;
     lblProduto.Caption := '...';
  End
  Else if Sender = EdtDestinatario then LblDestinatario.Caption := '...'
  Else if Sender = EdtProcessoId then lblProcesso.Caption := '...'
  Else if Sender = EdtLinhaId then LblLinha.Caption := '...' ;
  Limpar;
end;

procedure TFrmRelAuditoriaCortes.EdtPedidoIdExit(Sender: TObject);
begin
  if (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoId.Text, 0) <= 0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoId.Text+') do Pedido inválido!');
     EdtPedidoId.Clear;
     EdtPedidoId.SetFocus;
     Exit;
  End;
  inherited;
end;

procedure TFrmRelAuditoriaCortes.EdtProcessoIdExit(Sender: TObject);
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

procedure TFrmRelAuditoriaCortes.EdtRotaIdExit(Sender: TObject);
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
     EdtRotaId.SEtFocus;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     Player('toast4');
     EdtRotaId.Clear;
     EdtRotaId.SEtFocus;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  ReturnLstRota := Nil;
  FreeAndNil(ObjRotaCtrl);
  ExitFocus(Sender);
end;

procedure TFrmRelAuditoriaCortes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelAuditoriaCortes := Nil;
end;

procedure TFrmRelAuditoriaCortes.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LstReport.ColWidths[0]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[1]  :=  50+Trunc(50*ResponsivoVideo);
  LstReport.ColWidths[2]  :=  45+Trunc(45*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  85+Trunc(85*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[5]  := 220+Trunc(220*ResponsivoVideo);
  LstReport.ColWidths[6]  := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[7]  := 100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[8]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[9]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[10] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[11] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[12] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[13] := 150+Trunc(150*ResponsivoVideo);
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[2, 0]  := taCenter;
  LstReport.Alignments[3, 0]  := taCenter;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
end;

procedure TFrmRelAuditoriaCortes.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xReg : Integer;
begin
  inherited;
  FdMemPesqGeral.First;
  for xReg := 1 to FdMemPesqGeral.RecordCount do
    LstReport.AddDataImage( 2, xReg, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xReg := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xReg] := FdMemPesqGeral.FieldByName('PedidoVolumeId').AsString;
    LstReport.Cells[1, xReg] := FdMemPesqGeral.FieldByName('Sequencia').AsString;
    if FdMemPesqGeral.FieldByName('Tipo').AsString = 'N' then
       LstReport.Cells[2, xReg] := '0'
    Else LstReport.Cells[2, xReg] := '1';
    LstReport.Cells[ 3, xReg] := FdMemPesqGeral.FieldByName('Data').AsString;
    LstReport.Cells[ 4, xReg] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[ 5, xReg] := FdMemPesqGeral.FieldByName('Produto').AsString;
    LstReport.Cells[ 6, xReg] := FdMemPesqGeral.FieldByName('Lote').AsString;
    LstReport.Cells[ 7, xReg] := FdMemPesqGeral.FieldByName('Endereco').AsString;
    LstReport.Cells[ 8, xReg] := FdMemPesqGeral.FieldByName('Quantidade').AsString;
    LstReport.Cells[ 9, xReg] := FdMemPesqGeral.FieldByName('Corte').AsString;
    LstReport.Cells[10, xReg] := FdMemPesqGeral.FieldByName('CorteFinal').AsString;
    LstReport.Cells[11, xReg] := FdMemPesqGeral.FieldByName('Nome').AsString;
    LstReport.Cells[12, xReg] := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString+' '+FdMemPesqGeral.FieldByName('Razao').AsString;
    LstReport.Cells[13, xReg] := FdMemPesqGeral.FieldByName('RotaId').AsString+' '+FdMemPesqGeral.FieldByName('Rota').AsString;
    if FdMemPesqGeral.FieldByName('RotaId').AsInteger = 0 then Begin
       LstReport.Colors[13, xReg] := ClRed;
    End
    Else begin
       LstReport.Colors[13, xReg] := LstReport.Colors[2, xReg];
    end;
    LstReport.Alignments[0, xReg]  := taRightJustify;
    LstReport.FontStyles[0, xReg]  := [FsBold];
    LstReport.Alignments[1, xReg]  := taRightJustify;
    LstReport.Alignments[2, xReg]  := taCenter;
    LstReport.Alignments[3, xReg]  := taCenter;
    LstReport.Alignments[4, xReg]  := taRightJustify;
    LstReport.Alignments[8, xReg]  := taRightJustify;
    LstReport.Alignments[9, xReg]  := taRightJustify;
    LstReport.Alignments[10, xReg] := taRightJustify;
    FdMemPesqGeral.Next;
    Inc(xReg);
  End;
end;

procedure TFrmRelAuditoriaCortes.PesquisarDados;
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
  if (EdtRotaId.Text<>'') and (StrToIntDef(EdtRotaId.Text, 0) <= 0) then Begin
     LblRota.Caption := '';
     ShowErro( '😢Rota('+EdtRotaId.Text+') inválida!' );
     EdtRotaId.Clear;
     EdtRotaId.SEtFocus;
     Exit;
  end;
  if (EdtDestinatario.Text<>'') and (StrToIntDef(EdtDestinatario.Text, 0) <= 0) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     EdtDestinatario.SetFocus;
     Exit;
  end;
  if (EdtProcessoId.Text<>'') and (StrToIntDef(EdtProcessoId.Text, 0) <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo('+EdtProcessoId.Text+') inválido!' );
     EdtProcessoId.Clear;
     EdtProcessoId.SetFocus;
     Exit;
  end;
  if (EdtLinhaId.Text<>'') and (StrToIntDef(EdtLinhaId.Text, 0) <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Id('+EdtLinhaId.Text+') da Linha inválido!' );
     EdtLinhaId.Clear;
     EdtLinhaId.SetFocus;
     Exit;
  end;
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       vDtFinal := 0
    Else vDtFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  If CbTipoVolume.ItemIndex < 0 then
     raise Exception.Create('Selecione o tipo de volume para auditar.');
  pUsuarioId := 0;//StrToIntDef(EdtUsuarioId.Text, 0);
  TDialogMessage.ShowWaitMessage('Buscando Dados...',
    procedure
    Var JsonArrayRetorno : TJsonArray;
        ObjPedidoVolumeCtrl    : TPedidoVolumeCtrl;
    begin
      ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
      JsonArrayRetorno := ObjPedidoVolumeCtrl.GetAuditoriaCortes(vDtInicio, vDtFInal,
                          StrToIntDef(EdtPedidoId.Text, 0), EdtDocumentoNr.Text, StrToIntDef(EdtRotaId.Text, 0),
                          StrToIntDef(EdtDestinatario.Text, 0), StrToIntDef(EdtProcessoId.Text, 0),
                          vCodProduto, StrToIntDef(EdtLinhaId.Text, 0),
                          CbTipoVolume.ItemIndex, pUsuarioId);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         //JsonArrayRetorno := Nil;
         //ObjPedidoCtrl.Free;
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
