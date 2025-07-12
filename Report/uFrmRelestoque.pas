unit uFrmRelestoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, Generics.Collections,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, Vcl.Buttons, System.JSON, REST.Json, Rest.Types, DataSet.Serialize
  , ProdutoCtrl, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ, JvToolEdit,
  dxCameraControl, Vcl.Samples.Spin, System.DateUtils, JvBaseEdits;

type
  TFrmRelEstoque = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    BtnSchProduto: TBitBtn;
    LblProduto: TLabel;
    GroupBox2: TGroupBox;
    LblZona: TLabel;
    BtnSchZona: TBitBtn;
    GbEstrutura: TGroupBox;
    LblEstrutura: TLabel;
    BtnSchEstrutura: TBitBtn;
    RbEstoque: TRadioGroup;
    RbResumo: TRadioGroup;
    GroupBox4: TGroupBox;
    LblEndereco: TLabel;
    BtnSchEndereco: TBitBtn;
    GroupBox5: TGroupBox;
    CbEstoqueTipo: TComboBox;
    EdtProdutoId: TEdit;
    EdtEndereco: TEdit;
    EdtEstruturaId: TEdit;
    EdtZonaId: TEdit;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralUnidadeSecundariaSigla: TStringField;
    FdMemPesqGeralFatorConversao: TIntegerField;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralEstrutura: TStringField;
    FdMemPesqGeralZona: TStringField;
    FdMemPesqGeralDescrLote: TStringField;
    FdMemPesqGeralVencimento: TDateField;
    FdMemPesqGeralProducao: TIntegerField;
    FdMemPesqGeralQtdEspera: TIntegerField;
    FdMemPesqGeralQtdProducao: TIntegerField;
    FdMemPesqGeralReserva: TIntegerField;
    FdMemPesqGeralSaldo: TIntegerField;
    FdMemPesqGeralQtdCrosDocking: TIntegerField;
    FdMemPesqGeralSegregado: TIntegerField;
    FdMemPesqGeralExpedicao: TIntegerField;
    FdMemPesqGeralEmbalagem: TStringField;
    TabMovimentacaoInterna: TcxTabSheet;
    GroupBox6: TGroupBox;
    LblProdutoMovInterna: TLabel;
    BtnSearchProdMovInterna: TBitBtn;
    EdtCodProduto: TEdit;
    GroupBox7: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox8: TGroupBox;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BitBtn2: TBitBtn;
    LstMovimentacaoInterna: TAdvStringGrid;
    Label5: TLabel;
    LblTotMovInterna: TLabel;
    FDMemMovimentacaoInterna: TFDMemTable;
    FDMemMovimentacaoInternaData: TDateField;
    FDMemMovimentacaoInternaHora: TStringField;
    FDMemMovimentacaoInternaCodProduto: TIntegerField;
    FDMemMovimentacaoInternaDescricao: TStringField;
    FDMemMovimentacaoInternaDescrLote: TStringField;
    FDMemMovimentacaoInternaOrigem: TStringField;
    FDMemMovimentacaoInternaQtde: TIntegerField;
    FDMemMovimentacaoInternaDestino: TStringField;
    FDMemMovimentacaoInternaUsuario: TStringField;
    FDMemMovimentacaoInternaEstacao: TStringField;
    FDMemMovimentacaoInternaSaldoFinalOrigem: TIntegerField;
    FDMemMovimentacaoInternaSaldoFinalDestino: TIntegerField;
    FDMemMovimentacaoInternaMascaraOrigem: TStringField;
    FDMemMovimentacaoInternaMascaraDestino: TStringField;
    FDMemMovimentacaoInternaOrigemFormatado: TStringField;
    FDMemMovimentacaoInternaDestinoFormatado: TStringField;
    frxReportMovimentacaoInterna: TfrxReport;
    frxDBDataset2: TfrxDBDataset;
    FDMemMovimentacaoInternaEmabalagem: TStringField;
    FDMemMovimentacaoInternaObservarOrigem: TStringField;
    FDMemMovimentacaoInternaVencimento: TDateField;
    FDMemMovimentacaoInternaQtdMovimentada: TIntegerField;
    FDMemMovimentacaoInternaSaldoInicialDestino: TIntegerField;
    GroupBox9: TGroupBox;
    Label2: TLabel;
    LblQtdeMov: TLabel;
    FdMemPesqGeralDtUltimaMovimentacao: TDateField;
    GroupBox10: TGroupBox;
    LblEnderecoOrigem: TLabel;
    EdtEnderecoOrigem: TEdit;
    BtnPesqEnderecoOrigem: TBitBtn;
    GroupBox11: TGroupBox;
    ChkArmazenamento: TCheckBox;
    ChkMovInterna: TCheckBox;
    EdtEnderecoDestino: TEdit;
    BtnPesqEnderecoDestino: TBitBtn;
    LblEnderecoDestino: TLabel;
    RgOrdem: TRadioGroup;
    FdMemPesqGeralQtdeTransfPicking: TIntegerField;
    GbVencimento: TGroupBox;
    CbMesInicial: TComboBox;
    SEAnoInicial: TSpinEdit;
    SEAnoFinal: TSpinEdit;
    CbMesFinal: TComboBox;
    Label6: TLabel;
    FdMemPesqGeralMesVencimento: TIntegerField;
    FdMemPesqGeralAnoVencimento: TIntegerField;
    FdMemPesqGeralPicking: TStringField;
    FdMemPesqGeralmascara: TStringField;
    FdMemPesqGeralmascarapicking: TStringField;
    FdMemPesqGeralDtInclusao: TDateField;
    FdMemPesqGeralBloqueado: TIntegerField;
    TabEstoqueSemMovimentacao: TcxTabSheet;
    LstEstoqueSemMovimentacao: TAdvStringGrid;
    LblRegTot: TLabel;
    LblRegEstSemMovimentacao: TLabel;
    GroupBox3: TGroupBox;
    LblPesqZonaEstSemMov: TLabel;
    BtnPesqZonaEstSemMov: TBitBtn;
    EdtZonaIdEstSemMov: TEdit;
    GroupBox12: TGroupBox;
    EdtPeriodo: TJvCalcEdit;
    Label8: TLabel;
    LblTotEst: TLabel;
    LblTotEstSemMovimentacao: TLabel;
    FDMemEstoqueSemMovimentacao: TFDMemTable;
    FDMemEstoqueSemMovimentacaoCodigoERP: TIntegerField;
    FDMemEstoqueSemMovimentacaoProduto: TStringField;
    FDMemEstoqueSemMovimentacaoEmbalagem: TStringField;
    FDMemEstoqueSemMovimentacaoZonaId: TIntegerField;
    FDMemEstoqueSemMovimentacaoZona: TStringField;
    FDMemEstoqueSemMovimentacaoEstoque: TIntegerField;
    FDMemEstoqueSemMovimentacaoUltEntrada: TDateField;
    FDMemEstoqueSemMovimentacaoUltSaida: TDateField;
    GroupBox13: TGroupBox;
    Label12: TLabel;
    LblProdutoSemMovto: TLabel;
    EdtCodProdutoSemMovto: TEdit;
    BtnPesqProdutoSemMovto: TBitBtn;
    FdMemPesqGeralHrInclusao: TTimeField;
    procedure BtnSchProdutoClick(Sender: TObject);
    procedure EdtProdutoIdExit(Sender: TObject);
    procedure EdtProdutoIdChange(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure BtnSchEnderecoClick(Sender: TObject);
    procedure EdtEnderecoChange(Sender: TObject);
    procedure EdtEstruturaIdChange(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtEstruturaIdExit(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnSchEstruturaClick(Sender: TObject);
    procedure BtnSchZonaClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtProdutoIdKeyPress(Sender: TObject; var Key: Char);
    procedure RbEstoqueClick(Sender: TObject);
    procedure CbEstoqueTipoChange(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure FDMemMovimentacaoInternaAfterClose(DataSet: TDataSet);
    procedure LstMovimentacaoInternaClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure FDMemMovimentacaoInternaCalcFields(DataSet: TDataSet);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure EdtEnderecoOrigemChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BtnPesqProdutoSemMovtoClick(Sender: TObject);
    procedure EdtCodProdutoSemMovtoExit(Sender: TObject);
    procedure EdtZonaIdEstSemMovExit(Sender: TObject);
  private
    { Private declarations }
    vCodProduto, vCodProdutoMov, vEnderecoId : Integer;
    Procedure PesquisarMovimentacaoInterna;
    Procedure PesquisarEstoqueSemMovimentacao;
    Procedure MontaListaEstoqueSemMovimentacao;

    Procedure ImprimirMovimentacaoInterna;
    procedure MontaLstMovimentacaoInterna;
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelEstoque: TFrmRelEstoque;

implementation

{$R *.dfm}

uses Views.Pequisa.Produtos, Views.Pequisa.Endereco, EnderecoCtrl,
  EnderecamentoEstruturaCtrl, EnderecamentoZonaCtrl, Views.Pequisa.Usuarios,
  Views.Pequisa.EnderecamentoEstruturas, Views.Pequisa.EnderecamentoZonas,
  EstoqueCtrl, uFuncoes, UsuarioCtrl, uFrmeXactWMS, Vcl.DialogMessage;

procedure TFrmRelEstoque.BitBtn2Click(Sender: TObject);
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

procedure TFrmRelEstoque.BtnExportarStandClick(Sender: TObject);
begin
   Try
     if PgcBase.ActivePage = TabPrincipal then Begin
        if RbEstoque.itemIndex = 3 then Begin
           FdMemPesqGeral.FieldByName('ProdutoId').Visible := False;
           FdMemPesqGeral.FieldByName('UnidadeSecundariaSigla').Visible := False;
           FdMemPesqGeral.FieldByName('FatorConversao').Visible := False;
           FdMemPesqGeral.FieldByName('EnderecoId').Visible := False;
           FdMemPesqGeral.FieldByName('Endereco').Visible := False;
           FdMemPesqGeral.FieldByName('Estrutura').Visible := False;
           FdMemPesqGeral.FieldByName('Zona').Visible := False;
           FdMemPesqGeral.FieldByName('DescrLote').Visible := False;
           FdMemPesqGeral.FieldByName('Vencimento').Visible := False;
           FdMemPesqGeral.FieldByName('Producao').Visible := False;
           FdMemPesqGeral.FieldByName('QtdEspera').Visible := False;
           FdMemPesqGeral.FieldByName('QtdProducao').Visible := False;
           FdMemPesqGeral.FieldByName('QtdeTransfPicking').Visible := False;
           FdMemPesqGeral.FieldByName('Reserva').Visible := False;
           FdMemPesqGeral.FieldByName('QtdCrosdocking').Visible := False;
           FdMemPesqGeral.FieldByName('Segregado').Visible := False;
           FdMemPesqGeral.FieldByName('Expedicao').Visible := False;
           FdMemPesqGeral.FieldByName('Embalagem').Visible := False;
           FdMemPesqGeral.FieldByName('DtUltimaMovimentacao').Visible := False;
        End
        Else Begin

        End;
        inherited; //ExportarExcel(FdMemPesqGeral)
     End
     Else if PgcBase.ActivePage = TabMovimentacaoInterna then
        ExportarExcel(FDMemMovimentacaoInterna)
     Else
        ExportarExcel(FDMemEstoqueSemMovimentacao);
   Except
     raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional e se o MS-Excel está instalado.');
   End;
end;

procedure TFrmRelEstoque.BtnImprimirStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then
     inherited
  Else ImprimirMovimentacaoInterna;
end;

procedure TFrmRelEstoque.BtnPesqProdutoSemMovtoClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       if Sender = BtnPesqProdutoSemMovto then Begin
          EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
          EdtCodProdutoExit(EdtCodproduto);
       End
       Else Begin
          EdtCodProdutoSemMovto.Text := FrmPesquisaProduto.Tag.ToString();
          //EdtCodProdutoSemMovtoExit(EdtCodProdutoSemMovto);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  End;
end;

procedure TFrmRelEstoque.BtnPesquisarStandClick(Sender: TObject);
begin
  inherited;

//  BtnImprimirStand.Enabled := True;
//  BtnImprimirStand.Grayed  := False;
//  BtnExportarStand.Grayed  := False;

end;

procedure TFrmRelEstoque.BtnSchEnderecoClick(Sender: TObject);
Var vEnderecoId     : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
    vEndereco       : String;
begin
//  inherited;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       if Sender = BtnSchEndereco then
          vEnderecoId := FrmPesquisaEndereco.Tag
       Else If Sender = BtnPesqEnderecoOrigem then
          vEnderecoId := FrmPesquisaEndereco.Tag
       Else if Sender = BtnPesqEnderecoDestino then
          vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       vEndereco := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
       if Sender = BtnSchEndereco then Begin
          EdtEndereco.Text := vEndereco;
          EdtEnderecoExit(EdtEndereco);
       End
       Else If Sender = BtnPesqEnderecoOrigem then Begin
          EdtEnderecoOrigem.Text := vEndereco;
          EdtEnderecoExit(EdtEnderecoOrigem);
       End
       Else if Sender = BtnPesqEnderecoDestino then Begin
          EdtEnderecoDestino.Text := vEndereco;
          EdtEnderecoExit(EdtEnderecoDestino);
       End;
       ObjEnderecoCtrl := Nil;
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmRelEstoque.BtnSchEstruturaClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaEnderecamentoEstruturas := TFrmPesquisaEnderecamentoEstruturas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoEstruturas.ShowModal = mrOk) then  Begin
       EdtEstruturaId.Text := FrmPesquisaEnderecamentoEstruturas.Tag.ToString();
       EdtEstruturaIdExit(EdtEstruturaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoEstruturas);
  end;
end;

procedure TFrmRelEstoque.BtnSchProdutoClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then  Begin
       if Sender = BtnSchProduto then Begin
          EdtProdutoId.Text := FrmPesquisaProduto.Tag.ToString();
          EdtProdutoIdExit(EdtProdutoId);
       End
       Else Begin
          EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
          EdtCodProdutoExit(EdtCodProduto);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelEstoque.BtnSchZonaClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       if PgcBase.ActivePage = TabPrincipal then Begin
          EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdExit(EdtZonaIdEstSemMov);
       End
       Else Begin
          EdtZonaIdEstSemMov.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaIdEstSemMovExit(EdtZonaIdEstSemMov);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelEstoque.CbEstoqueTipoChange(Sender: TObject);
begin
  inherited;
  Limpar;
{  LstReport.UnHideColumn(8);
  LstReport.UnHideColumn(10);
  LstReport.UnHideColumn(11);
  LstReport.UnHideColumn(12);
  LstReport.UnHideColumn(13);
  LstReport.UnHideColumn(14);
}  LstReport.UnHideColumnsAll;
  if CbEstoqueTipo.ItemIndex > 0 then Begin
     if CbEstoqueTipo.ItemIndex = 1 then Begin
        LstReport.HideColumn(10);
        LstReport.HideColumn(11);
        LstReport.HideColumn(14);
        LstReport.HideColumn(15);
        LstReport.HideColumn(16);
     End;
     If CbEstoqueTipo.ItemIndex <> 2 then
        LstReport.HideColumn(13);
     If CbEstoqueTipo.ItemIndex <> 3 then
        LstReport.HideColumn(14);
     if CbEstoqueTipo.ItemIndex = 3 then Begin
        LstReport.HideColumns(9, 12);
     End;
  End;
end;

procedure TFrmRelEstoque.EdtCodProdutoExit(Sender: TObject);
Var JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProdutoMovInterna.Caption := '';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProdutoMovInterna.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  if JsonProduto.GetValue<Integer>('codproduto') <= 0 then Begin
     ShowErro('Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     JsonProduto := Nil;
     Exit;
  End;
  LblProdutoMovInterna.Caption := JsonProduto.GetValue<String>('descricao');
  vCodProdutoMov := JsonProduto.GetValue<Integer>('codproduto');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmRelEstoque.EdtCodProdutoSemMovtoExit(Sender: TObject);
Var vErro : String;
    JsonProduto : TJsonObject;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if StrToInt64Def(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Código do produto('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(TEdit(Sender).Text);
  if JsonProduto.TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Código do Produto('+TEdit(Sender).Text+') não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else
     LblProdutoSemMovto.Caption := JsonProduto.GetValue<String>('descricao');
  JsonProduto := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelEstoque.EdtEnderecoChange(Sender: TObject);
begin
  inherited;
  LblEndereco.Caption := '...';
  vEnderecoId := 0;
  Limpar;
end;

procedure TFrmRelEstoque.EdtEnderecoExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vEndereco        : String;
begin
  inherited;
   if Sender = EdtEndereco then
      LblEndereco.Caption := ''
   Else if Sender = EdtEnderecoOrigem then
      LblEnderecoOrigem.Caption := ''
   Else if Sender = EdtEnderecoDestino then
      LblEnderecoDestino.Caption := '';
   if TEdit(Sender).Text  = '' then Exit;
   ObjEnderecoCtrl := TEnderecoCtrl.Create();
   JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, TEdit(Sender).Text, TEdit(Sender).Text, 'T', 2, 0, 1);
   if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
      EdtProdutoId.Text := '';
      TEdit(Sender).SetFocus;
      ShowErro('Endereço não encontrado!');
   End
   Else Begin
      vEnderecoId := JsonArrayRetorno.Items[0].GetValue<Integer>('enderecoid');
      vEndereco   := (JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecoestrutura')).GetValue<String>('descricao')+' - '+
                     (JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecamentozona')).GetValue<String>('descricao');
      if Sender = EdtEndereco then
         LblEndereco.Caption := vEndereco
      Else if Sender = EdtEndereco then
         LblEnderecoOrigem.Caption := vEndereco
      Else if Sender = EdtEndereco then
         LblEnderecoDestino.Caption := vEndereco;
   End;
   JsonArrayRetorno := Nil;
   ObjEnderecoCtrl.Free;
end;

procedure TFrmRelEstoque.EdtEnderecoOrigemChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtEnderecoOrigem then
     LblEnderecoOrigem.Caption := ''
  Else LblEnderecoDestino.Caption := '';
  Limpar;
end;

procedure TFrmRelEstoque.EdtEstruturaIdChange(Sender: TObject);
begin
  inherited;
  LblEstrutura.Caption := '...';
  Limpar;
end;

procedure TFrmRelEstoque.EdtEstruturaIdExit(Sender: TObject);
Var ObjEnderecoEstruturaCtrl  : TEnderecoEstruturaCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  if (EdtEstruturaId.Text<>'') and (StrToIntDef(EdtEstruturaId.Text, 0) <= 0) then Begin
     EdtEstruturaId.SetFocus;
     ShowErro('Id ('+EdtEstruturaId.Text+') da Estrutura inválida!');
     EdtEstruturaId.Clear;
     Exit;
  End;
  inherited;
   LblEstrutura.Caption := '';
   if StrToIntDef(EdtEstruturaId.Text, 0) <= 0 then Exit;
   ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create();
   ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura.EstruturaId := StrToIntDef(EdtEstruturaId.Text, 0);
   JsonArrayRetorno := ObjEnderecoEstruturaCtrl.GetEnderecoEstruturaJson(StrToIntDef(EdtEstruturaId.Text, 0), '', 0);
   if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
      EdtEstruturaId.Text := '';
      EdtEstruturaId.SetFocus;
      ObjEnderecoEstruturaCtrl.DisposeOf;
      raise Exception.Create('Estrutura não encontrada!');
   End;
   LblEstrutura.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
   ObjEnderecoEstruturaCtrl.DisposeOf;
end;

procedure TFrmRelEstoque.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
  if (Sender=ChkArmazenamento) and ChkArmazenamento.Checked then
     ChkMovInterna.Checked := False;
  if (Sender=ChkMovInterna) and ChkMovInterna.Checked then
     ChkArmazenamento.Checked := False;
end;

procedure TFrmRelEstoque.EdtProdutoIdChange(Sender: TObject);
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then Begin
     LblProduto.Caption := '...';
     vCodProduto := 0;
  End
  Else If Sender = EdtCodProduto then Begin
     LblProdutoMovInterna.Caption := '...';
     vCodProdutoMov := 0;
  End
  Else if Sender = EdtZonaIdEstSemMov then Begin
    LblPesqZonaEstSemMov.Caption := '';
  End
  Else If Sender = EdtCodProdutoSemMovto then
     LblProdutoSemMovto.Caption := '';
  Limpar;
end;

procedure TFrmRelEstoque.EdtProdutoIdExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    ObjProdutoCtrl   : TProdutoCtrl;
    vErro, vCodDig   : String;
    vProdutoDigitado : Integer;
begin
  if (EdtProdutoId.Text <> '') and (StrToInt64Def(EdtProdutoId.Text, 0) <= 0) then Begin
     EdtProdutoId.SetFocus;
     ShowErro('Código('+EdtProdutoId.Text+') de Produto inválido!');
     EdtProdutoid.SetFocus;
     Exit;
  End;
  inherited;
  LblProduto.Caption  := '';
  if EdtProdutoId.Text = '' then Exit;
  vProdutoDigitado := tProdutoCtrl.GetCodProdEan(EdtProdutoId.Text);
  if vProdutoDigitado = 0 then Begin
     vCodDig := EdtProdutoId.Text;
     EdtProdutoId.Clear;
     raise Exception.Create('Produto não encontrado! Verifique o Código/Ean('+vCodDig+')');
  End;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  JsonArrayRetorno := ObjProdutoCtrl.FindProduto(vProdutoDigitado.ToString, '', '', 0, 0);
  if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtProdutoId.Text := '';
     EdtProdutoId.SetFocus;
     JsonArrayRetorno := Nil;
     ObjProdutoCtrl.Free;
     //JsonArrayRetorno.DisposeOf;
     raise Exception.Create('Produto não encontrado!');
  End;
  vCodProduto        := JsonArrayRetorno.Items[0].GetValue<Integer>('idProduto');
  LblProduto.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  ObjProdutoCtrl.Free;
  JsonArrayRetorno := Nil;
end;

procedure TFrmRelEstoque.EdtProdutoIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelEstoque.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  LblUsuario.Caption := '';
  Limpar;
end;

procedure TFrmRelEstoque.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if (EdtUsuarioId.Text <> '') and (StrToIntDef(EdtUsuarioId.Text, 0) <= 0) then Begin
     EdtUsuarioId.SetFocus;
     ShowErro('Id('+EdtUsuarioId.Text+') do Usuário inválido!');
     EdtUsuarioId.SetFocus;
     Exit;
  End;
  inherited;
  if StrToIntDef(EdtUsuarioId.Text, 0) = 0 then Exit;
  ObjUsuarioCtrl   := TUsuarioCtrl.Create;
  JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro'+vErro)
  Else
     LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
  JsonArrayRetorno   := Nil;
  FreeAndNil(ObjUsuarioCtrl);
end;

procedure TFrmRelEstoque.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '...';
  Limpar;
end;

procedure TFrmRelEstoque.EdtZonaIdEstSemMovExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl  : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  LblPesqZonaEstSemMov.Caption := '';
  if StrToIntDef(EdtZonaIdEstSemMov.Text, 0) <= 0 then Exit;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create();
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(StrToIntDef(EdtZonaIdEstSemMov.Text, 0), '', 0);
  if JsonArrayRetorno.Count < 1 Then Begin
     EdtZonaIdEstSemMov.Text := '';
     EdtZonaIdEstSemMov.SetFocus;
     ObjEnderecamentoZonaCtrl.Free;
     JsonArrayRetorno := Nil;
     raise Exception.Create('Zona não encontrada!');
  End;
  LblPesqZonaEstSemMov.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  ObjEnderecamentoZonaCtrl.Free;
  JsonArrayRetorno := Nil;
end;

procedure TFrmRelEstoque.EdtZonaIdExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl  : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if (EdtZonaId.Text<>'') and (StrToIntDef(EdtZonaId.Text, 0) <= 0) then Begin
     EdtZonaId.SetFocus;
     ShowErro('Id ('+EdtZonaId.Text+') da Zona inválida!');
     EdtZonaId.Clear;
     Exit;
  End;
  inherited;
  LblZona.Caption := '';
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Exit;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create();
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(StrToIntDef(EdtZonaId.Text, 0), '', 0);
  if (JsonArrayRetorno.Count < 1) or (JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro))Then Begin
     EdtZonaId.Text := '';
     EdtZonaId.SetFocus;
     ObjEnderecamentoZonaCtrl.Free;
     JsonArrayRetorno := Nil;
     raise Exception.Create('Zona não encontrada!');
  End;
  LblZona.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  ObjEnderecamentoZonaCtrl.Free;
  JsonArrayRetorno := Nil;
end;

procedure TFrmRelEstoque.FDMemMovimentacaoInternaAfterClose(DataSet: TDataSet);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelEstoque.FDMemMovimentacaoInternaCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FDMemMovimentacaoInterna.FieldByName('Origem').AsString <> '' then
     FDMemMovimentacaoInterna.FieldByName('OrigemFormatado').AsString  := EnderecoMask(FDMemMovimentacaoInterna.FieldByName('Origem').AsString,  FDMemMovimentacaoInterna.FieldByName('MascaraOrigem').AsString, True);
  if FDMemMovimentacaoInterna.FieldByName('Destino').AsString <> '' then
     FDMemMovimentacaoInterna.FieldByName('DestinoFormatado').AsString := EnderecoMask(FDMemMovimentacaoInterna.FieldByName('Destino').AsString, FDMemMovimentacaoInterna.FieldByName('MascaraDestino').AsString, True);
end;

procedure TFrmRelEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRelEstoque := Nil;
end;

procedure TFrmRelEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[1]  := 300+Trunc(300*ResponsivoVideo);
  LstReport.ColWidths[2]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[3]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[5]  := 100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[6]  := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[7]  := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[8]  :=  70+Trunc(70*ResponsivoVideo); //Vencimento
  LstReport.ColWidths[9]  :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[10] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[11] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[12] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[13] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[14] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[15] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[16] :=  100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[17] :=  110+Trunc(110*ResponsivoVideo);
  LstReport.ColWidths[18] :=  100+Trunc(100*ResponsivoVideo);
  LstReport.Alignments[ 0, 0] := taRightJustify;
  LstReport.FontStyles[ 0, 0] := [FsBold];
  LstReport.Alignments[ 8, 0]  := taCenter;
  LstReport.Alignments[ 9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0]  := taRightJustify;
  LstReport.Alignments[11, 0]  := taRightJustify;
  LstReport.Alignments[12, 0]  := taRightJustify;
  LstReport.Alignments[13, 0]  := taRightJustify;
  LstReport.FontStyles[14, 0] := [FsBold];
  LstReport.Alignments[14, 0]  := taRightJustify;
  LstReport.Alignments[15, 0]  := taRightJustify;
  LstReport.Alignments[16, 0]  := taRightJustify;
  LstReport.Alignments[17, 0]  := taCenter;
  LstReport.Alignments[18, 0]  := taCenter;
  LstReport.Align         := AlBottom;
  LstReport.RowCount      := 1;
  CbEstoqueTipo.ItemIndex := 4;
  RbEstoque.ItemIndex     := 0;
  RbResumo.ItemIndex      := 0;
  RgOrdem.ItemIndex       := 0;
  LstMovimentacaoInterna.ColWidths[0]  := 100+Trunc(100*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[1]  :=  50+Trunc(50*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[2]  :=  70+Trunc(70*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[3]  := 250+Trunc(250*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[4]  :=  70+Trunc(70*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[5]  := 250+Trunc(250*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[6]  := 100+Trunc(100*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[7]  :=  90+Trunc(90*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[8]  :=  90+Trunc(90*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[9]  :=  60+Trunc(60*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[10] :=  70+Trunc(70*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[11] :=  70+Trunc(70*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[12] :=  90+Trunc(90*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[13] :=  60+Trunc(60*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[14] :=  70+Trunc(70*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[15] := 130+Trunc(130*ResponsivoVideo);
  LstMovimentacaoInterna.ColWidths[16] := 100+Trunc(100*ResponsivoVideo);
  LstMovimentacaoInterna.Alignments[ 0, 0] := taCenter;
  LstMovimentacaoInterna.FontStyles[ 0, 0] := [FsBold];
  LstMovimentacaoInterna.Alignments[ 1, 0] := taCenter;
  LstMovimentacaoInterna.Alignments[ 2, 0] := taRightJustify;
  LstMovimentacaoInterna.Alignments[ 8, 0] := taCenter;
  LstMovimentacaoInterna.Alignments[ 9, 0] := taRightJustify;
  LstMovimentacaoInterna.Alignments[10, 0] := taRightJustify;
  LstMovimentacaoInterna.FontStyles[10, 0] := [FsBold];
  LstMovimentacaoInterna.Alignments[11, 0] := taRightJustify;
  LstMovimentacaoInterna.Alignments[12, 0] := taCenter;
  LstMovimentacaoInterna.Alignments[13, 0] := taRightJustify;
  LstMovimentacaoInterna.Alignments[14, 0] := taRightJustify;

  LstEstoqueSemMovimentacao.ColWidths[0] :=  70+Trunc(70*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[1] := 350+Trunc(350*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[2] := 140+Trunc(140*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[3] :=  60+Trunc(60*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[4] := 230+Trunc(230*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[5] :=  70+Trunc(70*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[6] :=  80+Trunc(80*ResponsivoVideo);
  LstEstoqueSemMovimentacao.ColWidths[7] :=  80+Trunc(80*ResponsivoVideo);
  LstEstoqueSemMovimentacao.Alignments[ 0, 0] := taRightJustify;
  LstEstoqueSemMovimentacao.FontStyles[ 0, 0] := [FsBold];
  LstEstoqueSemMovimentacao.Alignments[ 3, 0] := taRightJustify;
  LstEstoqueSemMovimentacao.Alignments[ 5, 0] := taRightJustify;
  LstEstoqueSemMovimentacao.FontStyles[ 5, 0] := [FsBold];
  LstEstoqueSemMovimentacao.Alignments[ 6, 0] := taCenter;
  LstEstoqueSemMovimentacao.Alignments[ 7, 0] := taCenter;

  CbMesInicial.itemIndex := MonthOf( Now() )-1;
  SEAnoInicial.Value     := YearOf( Now() );
  CbMesFinal.itemIndex   := MonthOf( Now() )-1;
  SEAnoFinal.Value       := YearOf( Now() );
end;

procedure TFrmRelEstoque.ImprimirMovimentacaoInterna;
begin
  if FDMemMovimentacaoInterna.IsEmpty then Begin
     ShowErro('Não há dados para imprimir.');
  End
  Else Begin;
     With frxReportMovimentacaoInterna do Begin
       Variables['vModulo']  := QuotedStr(pChar(Application.Title));
       Variables['vVersao']  := QuotedStr(Versao);
       Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
     End;
     frxPDFExport1.FileName     := 'RelMovimentacaoInterna.pdf';
     frxPDFExport1.DefaultPath  := FrmeXactWMS.PathApp + '\';
     frxPDFExport1.ShowDialog   := False;
     frxPDFExport1.ShowProgress := False;
     frxPDFExport1.OverwritePrompt := False;
     frxReportMovimentacaoInterna.PrepareReport(True);
     frxReportMovimentacaoInterna.Export(frxPDFExport1);
     frxReportMovimentacaoInterna.ShowReport;
  End
end;

procedure TFrmRelEstoque.Limpar;
begin
  if PgcBase.ActivePage = TabPrincipal then
     inherited
  else if PgcBase.ActivePage = TabMovimentacaoInterna then Begin
     LstMovimentacaoInterna.ClearRect(0, 1, LstMovimentacaoInterna.ColCount-1, LstMovimentacaoInterna.RowCount-1);
     LstMovimentacaoInterna.RowCount := 1;
     LblTotMovInterna.Caption := '0';
     LblQtdeMov.Caption := '0';
  End
  Else Begin
     LstEstoqueSemMovimentacao.ClearRect(0, 1, LstEstoqueSemMovimentacao.ColCount-1, LstEstoqueSemMovimentacao.RowCount-1);
     LstEstoqueSemMovimentacao.RowCount := 1;
     LblRegEstSemMovimentacao.Caption   := '0';
     LblTotEstSemMovimentacao.Caption   := '0';
  End;
end;

procedure TFrmRelEstoque.LstMovimentacaoInternaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  LstMovimentacaoInterna.Row := aRow;
  if (aRow = 0) and (aCol <= 9) then Begin
     LstMovimentacaoInterna.SortSettings.Column := aCol;
     LstMovimentacaoInterna.QSort;
  End

end;

procedure TFrmRelEstoque.LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  LstReport.Row := aRow;
  if (aRow = 0) then Begin //and (aCol <= 8)
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelEstoque.MontaListaEstoqueSemMovimentacao;
Var xMov, vQtdeEstoque : Integer;
begin
  xMov := 1;
  FDMemEstoqueSemMovimentacao.Open;
  FDMemEstoqueSemMovimentacao.First;
  While Not FDMemEstoqueSemMovimentacao.Eof do Begin
    LstEstoqueSemMovimentacao.Cells[0, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('CodigoERP').AsString;
    LstEstoqueSemMovimentacao.Cells[1, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('Produto').AsString;
    LstEstoqueSemMovimentacao.Cells[2, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('Embalagem').AsString;
    LstEstoqueSemMovimentacao.Cells[3, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('ZonaId').AsString;
    LstEstoqueSemMovimentacao.Cells[4, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('Zona').AsString;
    LstEstoqueSemMovimentacao.Cells[5, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('Estoque').AsString;
    LstEstoqueSemMovimentacao.Cells[6, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('UltEntrada').AsString;
    LstEstoqueSemMovimentacao.Cells[7, xMov] := FDMemEstoqueSemMovimentacao.FieldByName('UltSaida').AsString;
    vQtdeEstoque := vQtdeEstoque + FDMemEstoqueSemMovimentacao.FieldByName('Estoque').AsInteger;
    LstEstoqueSemMovimentacao.Alignments[ 0, xMov] := taRightJustify;
    LstEstoqueSemMovimentacao.FontStyles[ 0, xMov] := [FsBold];
    LstEstoqueSemMovimentacao.Alignments[ 3, xMov] := taRightJustify;
    LstEstoqueSemMovimentacao.Alignments[ 5, xMov] := taRightJustify;
    LstEstoqueSemMovimentacao.FontStyles[ 5, xMov] := [FsBold];
    LstEstoqueSemMovimentacao.Alignments[ 6, xMov] := taCenter;
    LstEstoqueSemMovimentacao.Alignments[ 7, xMov] := taCenter;
    Inc(xMov);
    FDMemEstoqueSemMovimentacao.Next;
  End;
  LblTotEstSemMovimentacao.Caption := FDMemEstoqueSemMovimentacao.RecordCount.ToString();
  LblTotEstSemMovimentacao.Caption := vQtdeEstoque.ToString();
end;

procedure TFrmRelEstoque.MontaLstMovimentacaoInterna;
Var xMov, vQtdeMov : Integer;
begin
  xMov := 1;
  FDMemMovimentacaoInterna.Open;
  FDMemMovimentacaoInterna.First;
  While Not FDMemMovimentacaoInterna.Eof do Begin
    LstMovimentacaoInterna.Cells[0, xMov] := FDMemMovimentacaoInterna.FieldByName('data').AsString;
    LstMovimentacaoInterna.Cells[1, xMov] := FDMemMovimentacaoInterna.FieldByName('hora').AsString;
    LstMovimentacaoInterna.Cells[2, xMov] := FDMemMovimentacaoInterna.FieldByName('CodProduto').AsString;
    LstMovimentacaoInterna.Cells[3, xMov] := FDMemMovimentacaoInterna.FieldByName('Descricao').AsString;
    LstMovimentacaoInterna.Cells[4, xMov] := FDMemMovimentacaoInterna.FieldByName('Embalagem').AsString;
    LstMovimentacaoInterna.Cells[5, xMov] := FDMemMovimentacaoInterna.FieldByName('ObservacaoOrigem').AsString;
    LstMovimentacaoInterna.Cells[6, xMov] := FDMemMovimentacaoInterna.FieldByName('Lote').AsString;
    LstMovimentacaoInterna.Cells[7, xMov] := FDMemMovimentacaoInterna.FieldByName('Vencimento').AsString;
    LstMovimentacaoInterna.Cells[8, xMov] := FDMemMovimentacaoInterna.FieldByName('OrigemFormatado').AsString;
    LstMovimentacaoInterna.Cells[9, xMov] := FDMemMovimentacaoInterna.FieldByName('EstDisponivel').AsString;
    LstMovimentacaoInterna.Cells[10, xMov] := FDMemMovimentacaoInterna.FieldByName('QtdMovimentada').AsString;
    LstMovimentacaoInterna.Cells[11, xMov] := FDMemMovimentacaoInterna.FieldByName('SaldoFinalOrigem').AsString;
    LstMovimentacaoInterna.Cells[12, xMov] := FDMemMovimentacaoInterna.FieldByName('DestinoFormatado').AsString;
    LstMovimentacaoInterna.Cells[13, xMov] := FDMemMovimentacaoInterna.FieldByName('SaldoInicialDestino').AsString;
    LstMovimentacaoInterna.Cells[14, xMov] := FDMemMovimentacaoInterna.FieldByName('SaldoFinalDestino').AsString;
    LstMovimentacaoInterna.Cells[15, xMov] := FDMemMovimentacaoInterna.FieldByName('Usuario').AsString;
    LstMovimentacaoInterna.Cells[16, xMov] := FDMemMovimentacaoInterna.FieldByName('Estacao').AsString;
    vQtdeMov := vQtdeMov + FDMemMovimentacaoInterna.FieldByName('QtdMovimentada').AsInteger;
    LstMovimentacaoInterna.Alignments[ 0, xMov] := taCenter;
    LstMovimentacaoInterna.FontStyles[ 0, xMov] := [FsBold];
    LstMovimentacaoInterna.Alignments[ 1, xMov] := taCenter;
    LstMovimentacaoInterna.Alignments[ 2, xMov] := taRightJustify;
    LstMovimentacaoInterna.Alignments[ 8, xMov] := taCenter;
    LstMovimentacaoInterna.Alignments[ 9, xMov] := taRightJustify;
    LstMovimentacaoInterna.Alignments[10, xMov] := taRightJustify;
    LstMovimentacaoInterna.FontStyles[10, xMov] := [FsBold];
    LstMovimentacaoInterna.Alignments[11, xMov] := taRightJustify;
    LstMovimentacaoInterna.Alignments[12, xMov] := taCenter;
    LstMovimentacaoInterna.Alignments[13, xMov] := taRightJustify;
    LstMovimentacaoInterna.Alignments[14, xMov] := taRightJustify;
    Inc(xMov);
    FDMemMovimentacaoInterna.Next;
  End;
  LblQtdeMov.Caption := vQtdeMov.ToString();
end;

procedure TFrmRelEstoque.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xProd : Integer;
    Teste : String;
begin
  xProd := 0;
  if //(RbEstoque.itemIndex = 2) or
     (RbEstoque.itemIndex = 3) then begin
     LstReport.HideColumns(4, 12);
     LstReport.HideColumns(14, 16);
     LstReport.Cells[3, 0]  := 'Vencimento';
     LstReport.ColWidths[3] :=  120+Trunc(120*ResponsivoVideo);
  end
  Else Begin
     LstReport.Cells[3, 0]  := 'Embalagem';
     LstReport.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);
  End;
  While Not FdMemPesqGeral.Eof do Begin
    //LstReport.Cells[0, xProd+1]  := FdMemPesqGeral.FieldByName('produtoid').AsString;
    LstReport.Cells[0, xProd+1]  := FdMemPesqGeral.FieldByName('codproduto').AsString;
    LstReport.Cells[1, xProd+1]  := FdMemPesqGeral.FieldByName('descricao').AsString;
    LstReport.Cells[2, xProd+1]  := EnderecoMask(FdMemPesqGeral.FieldByName('picking').AsString,
                                                 FdMemPesqGeral.FieldByName('mascarapicking').AsString, True);
    LstReport.Cells[3, xProd+1]  := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    if (RbEstoque.itemIndex = 3) then
       LstReport.Cells[3, xProd+1]  := NomeMes(FdMemPesqGeral.FieldByName('MesVencimento').AsInteger, 0)+'/'+
                                       FdMemPesqGeral.FieldByName('AnoVencimento').AsString
    Else
       LstReport.Cells[3, xProd+1] := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Cells[4, xProd+1]  := EnderecoMask(FdMemPesqGeral.FieldByName('endereco').AsString,
                                     FdMemPesqGeral.FieldByName('mascara').AsString, True);
    if FdMemPesqGeral.FieldByName('bloqueado').AsInteger = 1 then
        LstReport.Colors[4, xProd+1] := clYellow
    Else
       LstReport.Colors[4, xProd+1] := LstReport.Colors[12, LstReport.Row];

    LstReport.Cells[5, xProd+1]  := FdMemPesqGeral.FieldByName('estrutura').AsString;
    LstReport.Cells[6, xProd+1]  := FdMemPesqGeral.FieldByName('zona').AsString;
    LstReport.Cells[7, xProd+1]  := FdMemPesqGeral.FieldByName('descrlote').AsString;
    LstReport.Cells[8, xProd+1]  := FdMemPesqGeral.FieldByName('vencimento').AsString;
    LstReport.Cells[9, xProd+1] := FdMemPesqGeral.FieldByName('qtdespera').AsString;
    LstReport.Cells[10, xProd+1] := FdMemPesqGeral.FieldByName('QtdeTransfPicking').AsString;
    LstReport.Cells[11, xProd+1] := FdMemPesqGeral.FieldByName('qtdproducao').AsString;
    LstReport.Cells[12, xProd+1] := FdMemPesqGeral.FieldByName('reserva').AsString;
    LstReport.Cells[13, xProd+1] := FdMemPesqGeral.FieldByName('saldo').AsString;
    if FdMemPesqGeral.FieldByName('Saldo').AsInteger < 0 then
        LstReport.Colors[13, xProd+1] := ClRed
    Else
       LstReport.Colors[13, xProd+1] := LstReport.Colors[12, LstReport.Row];
    LstReport.Cells[14, xProd+1] := FdMemPesqGeral.FieldByName('qtdcrosdocking').AsString;
    LstReport.Cells[15, xProd+1] := FdMemPesqGeral.FieldByName('segregado').AsString;
    LstReport.Cells[16, xProd+1] := FdMemPesqGeral.FieldByName('Expedicao').AsString;
    LstReport.Cells[17, xProd+1] := FdMemPesqGeral.FieldByName('DtInclusao').AsString+' '+
                                    Copy(FdMemPesqGeral.FieldByName('HrInclusao').AsString, 1, 5)+'h';
    LstReport.Cells[18, xProd+1] := FdMemPesqGeral.FieldByName('DtUltimaMovimentacao').AsString;
    LstReport.Alignments[0, xProd+1]  := taRightJustify;
    LstReport.Alignments[8, xProd+1]  := taCenter;
    LstReport.Alignments[9, xProd+1] := taRightJustify;
    LstReport.Alignments[10, xProd+1] := taRightJustify; //Transferencia de Picking
    LstReport.Alignments[11, xProd+1] := taRightJustify;
    LstReport.Alignments[12, xProd+1] := taRightJustify;
    LstReport.Alignments[13, xProd+1] := taRightJustify;
    LstReport.FontStyles[13, xProd+1] := [FsBold];
    LstReport.Alignments[14, xProd+1] := taRightJustify;
    LstReport.Alignments[15, xProd+1] := taRightJustify;
    LstReport.Alignments[16, xProd+1] := taRightJustify;
    LstReport.Alignments[17, xProd+1] := taCenter;
    LstReport.Alignments[18, xProd+1] := taCenter;
    Inc(xProd);
    FdMemPesqGeral.Next;
  End;
  inherited;
end;

procedure TFrmRelEstoque.PesquisarDados;
Var ObjEstoqueCtrl : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    vOrderelatorio : string;
    vDataInicial, vDataFinal : TDateTime;
begin
  if PgcBase.ActivePage = TabMovimentacaoInterna then Begin
     PesquisarMovimentacaoInterna;
     Exit;
  End;
  if PgcBase.ActivePage = TabEstoqueSemMovimentacao then Begin
     PesquisarEstoqueSemMovimentacao;
     Exit;
  End;
  if (EdtProdutoId.Text<>'') and (LblProduto.Caption= '...') then
     EdtProdutoIdExit(EdtProdutoId);
  if (EdtProdutoId.Text <> '') and (StrToInt64Def(EdtProdutoId.Text, 0) <= 0) then Begin
     EdtProdutoId.SetFocus;
     ShowErro('Código('+EdtProdutoId.Text+') de Produto inválido!');
     EdtProdutoid.SetFocus;
     Exit;
  End;
  if (EdtEstruturaId.Text<>'') and (StrToIntDef(EdtEstruturaId.Text, 0) <= 0) then begin
     EdtEstruturaId.SetFocus;
     ShowErro('Id('+EdtEstruturaId.Text+') da estrutura inválida!');
     EdtEstruturaId.Clear;
     Exit;
  End;
  if (EdtZonaId.Text<>'') and (StrToIntdef(EdtZonaId.Text, 0) <= 0) then begin
     EdtZonaId.SetFocus;
     ShowErro('Id('+EdtZonaId.Text+') da Zona/Setor inválido!');
     EdtZonaId.Clear;
     Exit;
  End;
  inherited;
  TDialogMessage.ShowWaitMessage('Aguarde!!! Relatório sendo gerado...',
    procedure
    Var pPreVencido, pVencido : Boolean;
    Begin
      ObjEstoqueCtrl := TEstoqueCtrl.Create();
      pPreVencido    := RbEstoque.ItemIndex = 2;
      pVencido       := RbEstoque.ItemIndex = 3;
      If RbEstoque.ItemIndex = 4 then
         JsonArrayRetorno := ObjEstoqueCtrl.GetRelEstoqueSemPicking(vCodProduto, 0, vEnderecoId,
                               StrToIntDef(EdtZonaId.Text, 0), CbEstoqueTipo.ItemIndex, 2, 2, 'S', 'S', 0, RgOrdem.ItemIndex)
      Else if RbResumo.ItemIndex = 0 then
         JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueEnderecoPorTipoDetalhes(vCodProduto, vEnderecoId,
                               StrToIntDef(EdtEstruturaId.Text, 0), StrToIntDef(EdtZonaId.Text, 0),
                               CbEstoqueTipo.ItemIndex, 'S', 'S', pPreVencido, pVencido, 0, RgOrdem.ItemIndex)
      Else if RbResumo.ItemIndex = 1 then
         JsonArrayRetorno := ObjEstoqueCtrl.GetRelEstoqueLotePorTipo(vCodProduto, 0, vEnderecoId,
                               StrToIntDef(EdtZonaId.Text, 0), CbEstoqueTipo.ItemIndex, 2, 2, 'S', 'S', 0, RgOrdem.ItemIndex)
      Else if (RbEstoque.ItemIndex = 3) then Begin
         vDataInicial := StrToDate('01/'+FormatFloat('00', CbMesInicial.ItemIndex+1)+'/'+SeAnoInicial.Value.ToString());
         vDataFinal   := StrToDate('01/'+FormatFloat('00', CbMesFinal.ItemIndex+1)+'/'+SeAnoFinal.Value.ToString());
         vDataFinal   := StrToDate(FormatFloat('00', DaysInMonth(vDataFinal))+Copy(DateToStr(vDataFinal), 3, 8));
         JsonArrayRetorno := ObjEstoqueCtrl.GetEstoquePreOrVencido(vCodProduto, StrToIntDef(EdtZonaId.Text, 0),
                               False, True, vDataInicial, vDataFinal);
      End
      Else
         JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueSaldo(vCodProduto, vEnderecoId,
                               StrToIntDef(EdtEstruturaId.Text, 0), StrToIntDef(EdtZonaId.Text, 0),
                               CbEstoqueTipo.ItemIndex, 'S', 'S', pPreVencido, pVencido, 0, RgOrdem.ItemIndex);
      if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
         EdtProdutoId.SetFocus;
         ObjEstoqueCtrl.Free;
         JsonArrayRetorno := Nil;
         ShowErro(vErro);
         Exit;
      End;
      If FdMemPesqGeral.Active then
         FdMemPesqGeral.EmptyDataSet;
      FdMemPesqGeral.Close;
      FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
      FdMemPesqGeral.Open;
      if RbEstoque.ItemIndex = 1 then Begin
         FdmemPesqGeral.Filter   := 'Saldo < 0';
         FdMemPesqgeral.Filtered := True;
      End;
      if RbEstoque.ItemIndex = 3 then Begin
         FdmemPesqGeral.Filter   := 'Vencimento < '#39+FormatDateTime('DD/MM/YYYY', Now())+#39;
         FdMemPesqgeral.Filtered := True;
      End;
      MontarLstAdvReport(JsonArrayRetorno);
      JsonArrayRetorno := Nil;
      FreeAndNil(ObjEstoqueCtrl);
    End);
end;

procedure TFrmRelEstoque.PesquisarEstoqueSemMovimentacao;
Var ObjEstoqueCtrl : TEstoqueCtrl;
    JsonArrayEstoqueSemMovimentacao  : TJsonArray;
    vErro : String;
    vDtInicio, vDtFinal       : TDateTime;
begin
  if (EdtCodProdutoSemMovto.Text<>'') and (StrToInt64Def(EdtCodProdutoSemMovto.Text, 0) <= 0) then Begin
     EdtCodProdutoSemMovto.SetFocus;
     ShowErro('Código('+EdtCodProdutoSemMovto.Text+') de Produto inválido!');
     EdtCodProdutoSemMovto.Clear;
     Exit;
  End;
  if (EdtZonaIdEstSemMov.Text<>'') and (StrToInt64Def(EdtZonaIdEstSemMov.Text, 0) <= 0) then Begin
     EdtZonaIdEstSemMov.SetFocus;
     ShowErro('Id('+EdtZonaIdEstSemMov.Text+') da Zona/Setor inválido!');
     EdtZonaIdEstSemMov.Clear;
     Exit;
  End;
  inherited;
  TDialogMessage.ShowWaitMessage('Aguarde!!! Relatório sendo gerado...',
    procedure
    Begin
      ObjEstoqueCtrl     := TEstoqueCtrl.Create();
      JsonArrayEstoqueSemMovimentacao   := ObjEstoqueCtrl.GetEstoqueSemMovimentacao(StrToIntDef(EdtZonaIdEstSemMov.Text, 0),
                                                                                    StrToIntDef(EdtPeriodo.Text, 0),
                                                                                    StrToIntDef(EdtCodProdutoSemMovto.Text, 0));
      if JsonArrayEstoqueSemMovimentacao.Items[0].TryGetValue<String>('Erro', vErro) then Begin
         EdtZonaIdEstSemMov.SetFocus;
         ShowErro(vErro);
         LstEstoqueSemMovimentacao.FixedRows := 0;
         LstEstoqueSemMovimentacao.ClearRect(0, 1, LstEstoqueSemMovimentacao.ColCount-1, LstEstoqueSemMovimentacao.RowCount-1);
         LstEstoqueSemMovimentacao.RowCount := 1;
         BtnImprimirStand.Grayed  := True;
         BtnExportarStand.Enabled := False;
         BtnExportarStand.Grayed  := True;
      End
      Else Begin
         If FDMemEstoqueSemMovimentacao.Active then
            FDMemEstoqueSemMovimentacao.EmptyDataSet;
         FDMemEstoqueSemMovimentacao.Close;
         FDMemEstoqueSemMovimentacao.LoadFromJSON(JsonArrayEstoqueSemMovimentacao, False);
         if Not FDMemEstoqueSemMovimentacao.IsEmpty then Begin
            LstEstoqueSemMovimentacao.RowCount := FDMemEstoqueSemMovimentacao.RecordCount+1;
            LblRegEstSemMovimentacao.Caption   := FDMemEstoqueSemMovimentacao.RecordCount.ToString;
            LstEstoqueSemMovimentacao.FixedRows := 1;
            BtnImprimirStand.Grayed  := False;
            BtnExportarStand.Enabled := True;
            BtnExportarStand.Grayed  := False;
            MontaListaEstoqueSemMovimentacao;
         End
         Else
            ShowErro('Sem dados para gerar o relatório.');
      End;
      JsonArrayEstoqueSemMovimentacao := Nil;
      ObjEstoqueCtrl.Free;
    End);
end;

procedure TFrmRelEstoque.PesquisarMovimentacaoInterna;
Var ObjEstoqueCtrl : TEstoqueCtrl;
    JsonArrayMovInternaRetorno  : TJsonArray;
    vErro : String;
    vDtInicio, vDtFinal       : TDateTime;
begin
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial da produção inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       vDtFinal := 0
    Else vDtFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final da produção inválida!'+#13+#10+E.Message);
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período da produção Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  if (EdtCodProduto.Text<>'') and (StrToInt64Def(EdtCodProduto.Text, 0) <= 0) then begin
     EdtCodProduto.SetFocus;
     ShowErro('Código('+EdtCodProduto.Text+') do Produto inválido!');
     EdtCodProduto.Clear;
     Exit;
  End;
  if (EdtUsuarioId.Text<>'') and (StrToIntDef(EdtUsuarioId.Text, 0) <= 0) then begin
     EdtUsuarioId.SetFocus;
     ShowErro('Id('+EdtUsuarioId.Text+') do Usuário inválido!');
     EdtUsuarioId.Clear;
     Exit;
  End;

  inherited;
  TDialogMessage.ShowWaitMessage('Aguarde!!! Relatório sendo gerado...',
    procedure
    Var vArmazenagem, vMovInterna : Integer;
    Begin
      vArmazenagem := Ord(ChkArmazenamento.Checked);
      vMovInterna  := Ord(ChkMovInterna.Checked);
      ObjEstoqueCtrl     := TEstoqueCtrl.Create();
      JsonArrayMovInternaRetorno   := ObjEstoqueCtrl.GetMovimentacaoInterna(vCodProdutoMov,
                                      vDtInicio, vDtFinal, StrToIntDef(EdtUsuarioId.Text, 0), EdtEnderecoOrigem.Text, EdtEnderecoDestino.Text, vArmazenagem, vMovInterna);
      if JsonArrayMovInternaRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
         EdtCodProduto.SetFocus;
         ShowErro(vErro);
         LstMovimentacaoInterna.FixedRows := 0;
         LstMovimentacaoInterna.ClearRect(0, 1, LstMovimentacaoInterna.ColCount-1, LstMovimentacaoInterna.RowCount-1);
         LstMovimentacaoInterna.RowCount := 1;
         BtnImprimirStand.Grayed  := True;
         BtnExportarStand.Enabled := False;
         BtnExportarStand.Grayed  := True;
      End
      Else Begin
         If FDMemMovimentacaoInterna.Active then
            FDMemMovimentacaoInterna.EmptyDataSet;
         FDMemMovimentacaoInterna.Close;
         FDMemMovimentacaoInterna.LoadFromJSON(JsonArrayMovInternaRetorno, False);
         if Not FDMemMovimentacaoInterna.IsEmpty then Begin
            LstMovimentacaoInterna.RowCount := FDMemMovimentacaoInterna.RecordCount+1;
            LblTotMovInterna.Caption        := FDMemMovimentacaoInterna.RecordCount.ToString;
            LstMovimentacaoInterna.FixedRows := 1;
            BtnImprimirStand.Grayed  := False;
            BtnExportarStand.Enabled := True;
            BtnExportarStand.Grayed  := False;
            MontaLstMovimentacaoInterna;
         End
         Else
            ShowErro('Sem dados para gerar o relatório.');
      End;
      JsonArrayMovInternaRetorno := Nil;
      ObjEstoqueCtrl.Free;
    End);
end;

procedure TFrmRelEstoque.RbEstoqueClick(Sender: TObject);
begin
  inherited;
  Limpar;
  LstReport.UnHideColumnsAll;
  if CbEstoqueTipo.ItemIndex > 0 then Begin
     If CbEstoqueTipo.ItemIndex <> 2 then
        LstReport.HideColumn(15);
     If CbEstoqueTipo.ItemIndex <> 3 then
        LstReport.HideColumn(16);
     if CbEstoqueTipo.ItemIndex = 3 then Begin
        LstReport.HideColumns(11, 14);
     End;
  End;
  GbVencimento.Visible := (RbEstoque.ItemIndex = 3);
  RbResumo.Visible     := Not GbVencimento.Visible;
  if Not RbResumo.Visible then
     RbResumo.ItemIndex := 2
end;

end.
