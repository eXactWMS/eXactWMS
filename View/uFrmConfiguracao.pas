unit uFrmConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.TypInfo,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC,
  ConfiguracaoCtrl, ACBrBase, ACBrETQ, ACBrDevice, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, JvToolEdit, JvBaseEdits, Vcl.Buttons,
  Generics.Collections, System.Json, Rest.Types,
  Vcl.ComCtrls, Vcl.DBGrids, dxCameraControl, EnderecoCtrl;

type
  TPickByLightModelo = (pcSSISCHAEFER, pcMecalux, pcPickToLight, pcAguia);

  TFrmConfiguracao = class(TFrmBase)
    ACBrETQ: TACBrETQ;
    TabImpressora: TcxTabSheet;
    TabIntegracao: TcxTabSheet;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    Label17: TLabel;
    CbModeloPrinterCodBar: TComboBox;
    GroupBox5: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    CbModeloPrinterGerencial: TComboBox;
    Label2: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CbIntPickingByVoice: TComboBox;
    CbIntPickingByLight: TComboBox;
    CbIntDesvioAuditoria: TComboBox;
    CbIntDesvioRota: TComboBox;
    CbIntBalancaPrecisao: TComboBox;
    LblTipoDesvio: TLabel;
    LblModeloPickingByLight: TLabel;
    LblModeloPickingByVoice: TLabel;
    CbIntPickingByVoiceModelo: TComboBox;
    CbIntPickingByLightModelo: TComboBox;
    CbIntDesvioAuditoriaTipo: TComboBox;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CbCadProduto: TComboBox;
    CbCadCliente: TComboBox;
    CbCadFornecedor: TComboBox;
    CbCadXmlEntrada: TComboBox;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CbBloqEntrValidade: TComboBox;
    CbBloqSaidaValidade: TComboBox;
    CbBloqStatusFornecedor: TComboBox;
    CbBloqStatusCliente: TComboBox;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    CbCheckInItem: TComboBox;
    Label20: TLabel;
    CbPreVencido: TComboBox;
    Label21: TLabel;
    GroupBox6: TGroupBox;
    Label22: TLabel;
    CbRegApanhe: TComboBox;
    Label23: TLabel;
    CbApanheConsolidado: TComboBox;
    Label24: TLabel;
    CbPrinterEtqVolumeExtraAuto: TComboBox;
    Label25: TLabel;
    CbCadRastroIdProdNovo: TComboBox;
    CbPortaPrinterCodBar: TComboBox;
    CbPortaPrinterGerencial: TComboBox;
    Label26: TLabel;
    CbEnderecarProdutoEntrada: TComboBox;
    GroupBox7: TGroupBox;
    Label27: TLabel;
    CbShelflifeRecebimento: TComboBox;
    Label28: TLabel;
    Label29: TLabel;
    CbShelflifeExpedicao: TComboBox;
    Label30: TLabel;
    Label32: TLabel;
    CbAutorizarAltLote: TComboBox;
    Label33: TLabel;
    CbBeepProdIndividual: TComboBox;
    Label34: TLabel;
    CbIdentCaixaApanhe: TComboBox;
    GroupBox8: TGroupBox;
    RbTagProduto0: TRadioButton;
    RbTagProduto2: TRadioButton;
    RbTagProduto3: TRadioButton;
    RbTagProduto1: TRadioButton;
    CbCubagemProdutoEntrada: TComboBox;
    Label35: TLabel;
    GroupBox9: TGroupBox;
    Label31: TLabel;
    EdtEnderecoSegregadoId: TEdit;
    EdtBeepIndividualLimiteUnid: TEdit;
    EdtBeepIndividualQtdMinima: TLabel;
    Label36: TLabel;
    CbCorteSupervisionado: TComboBox;
    GroupBox10: TGroupBox;
    ChkInventarioForcarMaxContagem: TCheckBox;
    ChkInventarioDivergenciaSegregado: TCheckBox;
    GroupBox11: TGroupBox;
    EdtIdentificacaoCD: TEdit;
    GbReposicao: TGroupBox;
    ChkReposicaoColetor: TCheckBox;
    ChkReposicaoAutomatica: TCheckBox;
    Label37: TLabel;
    CbLacreSeguranca: TComboBox;
    GroupBox12: TGroupBox;
    Label38: TLabel;
    EdtEnderecoIdStage: TEdit;
    GroupBox13: TGroupBox;
    Label39: TLabel;
    EdtEnderecoIdVolumeExpedidoCancelado: TEdit;
    GroupBox14: TGroupBox;
    Label40: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    CbTagVolumeOrdem: TComboBox;
    ComboBox2: TComboBox;
    ChkIntegrarAjusteERP: TCheckBox;
    GbReCheckOut: TGroupBox;
    Label41: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    CbReCheckOutUsuario: TComboBox;
    ComboBox3: TComboBox;
    Label46: TLabel;
    CbModeloEtqVolume: TComboBox;
    EdtEnderecoIdStageSNGPC: TEdit;
    Label47: TLabel;
    Label48: TLabel;
    CbVolCxaFechadaExpedicao: TComboBox;
    ChkReposicaoColetaParaPicking: TCheckBox;
    Label49: TLabel;
    CbSeparacaoCodigoInterno: TComboBox;
    Label50: TLabel;
    CbReconferirCorteReconferencia: TComboBox;
    Label51: TLabel;
    CbExigirReconferenciaToExpedicao: TComboBox;
    Label52: TLabel;
    CbInventarioAJustePadrao: TComboBox;
    Label53: TLabel;
    CbMudarPickingEstoquePallet: TComboBox;
    Label54: TLabel;
    CbVolumeAuditoria: TComboBox;
    CbOmitirUnidEtqVolume: TComboBox;
    Label55: TLabel;
    Label56: TLabel;
    CbVolCxaFracionadaExpedicao: TComboBox;
    Label57: TLabel;
    CbCargaEmTransito: TComboBox;
    Label58: TLabel;
    CbBuscarStage: TComboBox;
    TabProdutividade: TcxTabSheet;
    GroupBox15: TGroupBox;
    Label59: TLabel;
    Label60: TLabel;
    EdtArmanenagemMeta: TJvCalcEdit;
    Label61: TLabel;
    EdtArmanenagemTolerancia: TJvCalcEdit;
    Label62: TLabel;
    EdtSeparacaoFracionadoMeta: TJvCalcEdit;
    EdtSeparacaoFracionadoTolerancia: TJvCalcEdit;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    EdtCheckOutFracionadoMeta: TJvCalcEdit;
    EdtCheckOutFracionadoTolerancia: TJvCalcEdit;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    EdtCheckOutCxaFechadaMeta: TJvCalcEdit;
    Label69: TLabel;
    Label70: TLabel;
    EdtCheckOutCxaFechadaTolerancia: TJvCalcEdit;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    EdtExpedicaoTolerancia: TJvCalcEdit;
    EdtExpedicaoMeta: TJvCalcEdit;
    Label74: TLabel;
    EdtReposicaoColetaMeta: TJvCalcEdit;
    Label75: TLabel;
    Label76: TLabel;
    EdtReposicaoColetaTolerancia: TJvCalcEdit;
    Label77: TLabel;
    Label78: TLabel;
    EdtCheckInMeta: TJvCalcEdit;
    EdtCheckInTolerancia: TJvCalcEdit;
    Label79: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CbIntDesvioAuditoriaClick(Sender: TObject);
    procedure TabImpressoraShow(Sender: TObject);
    procedure PgcBaseChange(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure EdtEnderecoSegregadoIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtEnderecoIdVolumeExpedidoCanceladoExit(Sender: TObject);
  private
    { Private declarations }
    tpPickByLightModelo, tpPickByVoiceModelo : TPickByLightModelo;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure LimpaField; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure AfterCancelar; OverRide;
    Procedure filtraritens(CodProdutoERP : Integer);  public
    { Public declarations }
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation

{$R *.dfm}

uses uFrmeXactWMS, Printers, uFuncoes, ACBrETQClass;

procedure TFrmConfiguracao.AfterCancelar;
begin
  inherited;
  ShowDados;
end;

procedure TFrmConfiguracao.BtnPesquisarStandClick(Sender: TObject);
begin
//  inherited;
end;

procedure TFrmConfiguracao.BtnSalvarClick(Sender: TObject);
begin
  if CbCadRastroIdProdNovo.ItemIndex < 1 then
     raise Exception.Create('Defina o tipo de Rastreabilidade padrão para novos produtos.');
  inherited;
  TabListagem.TabVisible := False;
  ShowDados;
end;

procedure TFrmConfiguracao.CbIntDesvioAuditoriaClick(Sender: TObject);
begin
  inherited;
  if Sender = CbIntDesvioAuditoria then CbIntDesvioAuditoriaTipo.Visible := CbIntDesvioAuditoria.ItemIndex = 1;
  if Sender = CbIntPickingByLight then CbIntPickingByLightModelo.Visible := CbIntPickingByLight.ItemIndex = 1;
  if Sender = CbIntPickingByVoice then CbIntPickingByVoiceModelo.Visible := CbIntPickingByVoice.ItemIndex = 1;
  LblTipoDesvio.Visible           := CbIntDesvioAuditoriaTipo.Visible;
  LblModeloPickingByLight.Visible := CbIntPickingByLightModelo.Visible;
  LblModeloPickingByVoice.Visible := CbIntPickingByVoiceModelo.Visible;
end;

procedure TFrmConfiguracao.EdtEnderecoIdVolumeExpedidoCanceladoExit(
  Sender: TObject);
Var ObjEnderecoCtrl : TEnderecoCtrl;
    JsonArrayEndereco : TJsonArray;
    vErro : String;
begin
  if EdtEnderecoIdVolumeExpedidoCancelado.Text = '' then Exit;
  inherited;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdVolumeExpedidoCancelado <> 0 then Begin
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     JsonArrayEndereco := ObjEnderecoCtrl.GetEnderecoJson(FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdVolumeExpedidoCancelado, 0, 0, 0, '', '', 'T', 2, 0, 0);
     if Not JsonArrayEndereco.Items[0].TryGetValue('Erro', vErro) then Begin
        FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoVolumeExpedidoCancelado := EnderecoMask(JsonArrayEndereco.items[0].GetValue<String>('descricao'),
                                  JsonArrayEndereco.items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
     End;
     JsonArrayEndereco := Nil;
     ObjEnderecoCtrl.Free;
  End;
end;

procedure TFrmConfiguracao.EdtEnderecoSegregadoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  soNumeros(Key);
end;

procedure TFrmConfiguracao.filtraritens(CodProdutoERP: Integer);
begin
//
end;

procedure TFrmConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmConfiguracao := Nil;
end;

procedure TFrmConfiguracao.FormCreate(Sender: TObject);
Begin
  inherited;
  PgcBase.ActivePage     := TabPrincipal;//  TabSistema;
  TabListagem.TabVisible := False;
  ShowDados;
end;

procedure TFrmConfiguracao.GetListaLstCadastro;
begin
  inherited;
//
end;

procedure TFrmConfiguracao.LimpaField;
begin
  inherited;
//
end;

procedure TFrmConfiguracao.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
//
end;

function TFrmConfiguracao.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
//
end;

procedure TFrmConfiguracao.PgcBaseChange(Sender: TObject);
begin
//  inherited;

end;

function TFrmConfiguracao.SalvarReg: Boolean;
begin
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadClienteIncluir    := CbCadCliente.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadFornecedorIncluir := CbCadFornecedor.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadProdutoIncluir    := CbCadProduto.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadEntradaIncluir    :=CbCadXmlEntrada.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadRastroIdProdNovo  := CbCadRastroIdProdNovo.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.AutorizarAltLote     := CbAutorizarAltLote.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ShelflifeRecebimento := CbShelflifeRecebimento.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ShelflifeExpedicao   := CbShelflifeExpedicao.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EntradaBloqueioVencimento := CbBloqEntrValidade.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.SaidaBloqueioVencimento   := CbBloqSaidaValidade.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.StatusFornecedor          := CbBloqStatusFornecedor.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.StatusCliente             := CbBloqStatusCliente.ItemIndex;
  if RbTagProduto0.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada := 0
  Else if RbTagProduto1.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada := 1
  Else if RbTagProduto2.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada := 2
  Else if RbTagProduto3.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada := 3;

  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInItem               := CbCheckInItem.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.BuscarStage               := CbBuscarStage.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.MesesParaPreVencido       := CbPreVencido.ItemIndex;
  frmeXactWMS.ConfigWMS.ObjConfiguracao.MudarPickingEstoquePallet := CbMudarPickingEstoquePallet.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecarProdutoEntrada   := CbEnderecarProdutoEntrada.ItemIndex;
  FrmeXactWMs.ConfigWMS.ObjConfiguracao.CubagemProdutoEntrada     := CbCubagemProdutoEntrada.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoSegregadoId       := StrToIntDef(EdtEnderecoSegregadoId.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdVolumeExpedidoCancelado := StrToIntDef(EdtEnderecoIdVolumeExpedidoCancelado.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdStage           := StrToIntDef(EdtEnderecoidStage.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdStageSNGPC      := StrToIntDef(EdtEnderecoidStageSNGPC.Text, 0);
  //Apanhe - CheckOut
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.RegApanhe                  := CbRegApanhe.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ApanheConsolidado          := CbApanheConsolidado.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno        := CbSeparacaoCodigoInterno.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PrinterEtqVolumeExtraAuto  := CbPrinterEtqVolumeExtraAuto.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepProdIndividual         := CbBeepProdIndividual.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepIndividualLimiteUnid   := StrToIntDef(EdtBeepIndividualLimiteUnid.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe           := CbIdentCaixaApanhe.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.OmitirUnidEtqVolume        := CbOmitirUnidEtqVolume.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.LacreSeguranca             := CbLacreSeguranca.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume            := CbModeloEtqVolume.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CorteSupervisionado        := CbCorteSupervisionado.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CargaEmTransito            := CbCargaEmTransito.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolCxaFechadaExpedicao     := CbVolCxaFechadaExpedicao.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolCxaFracionadaExpedicao  := CbVolCxaFracionadaExpedicao.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReconferirCorteReconferencia   := CbReconferirCorteReconferencia.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExigirReconferenciaToExpedicao := CbExigirReconferenciaToExpedicao.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolumeAuditoria            := CbVolumeAuditoria.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra      := CbModeloPrinterCodBar.Text;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra       := CbPortaPrinterCodBar.Text;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterGerencial     := CbModeloPrinterGerencial.Text;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterGerencial      := CbPortaPrinterGerencial.Text;
  //Integração com Equipamentos
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.BalancaPrecisao            := CbIntBalancaPrecisao.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EsteiraDesvioRota          := CbIntDesvioRota.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EsteiraDesvioAuditoria     := CbIntDesvioAuditoria.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.EsteiraTipoDesvioAuditoria := CbIntDesvioAuditoriaTipo.ItemIndex;

  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByLight       := CbIntPickingByLight.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByVoice       := CbIntPickingByVoice.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByLightModelo := CbIntPickingByLightModelo.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByVoiceModelo := CbIntPickingByVoiceModelo.Itemindex;
  if ChkInventarioForcarMaxContagem.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioForcarMaxContagem := 1
  Else FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioForcarMaxContagem := 0;
  if ChkInventarioDivergenciaSegregado.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioDivergenciaSegregado := 1
  Else FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioDivergenciaSegregado := 0;
  if ChkintegrarAjusteERP.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.IntegrarAjusteERP := 1
  Else FrmeXactWMS.ConfigWMS.ObjConfiguracao.IntegrarAjusteERP := 0;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioAjustePadrao := CbInventarioAJustePadrao.ItemIndex-1;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagVolumeOrdem := CbTagVolumeOrdem.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReCheckOutUsuario := CbReCheckOutUsuario.ItemIndex;
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa := EdtIdentificacaoCD.Text;
  if ChkReposicaoColetor.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetor := 1
  Else FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetor := 0;
  if ChkReposicaoAutomatica.Checked then
     FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoAutomatica := 1
  Else FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoAutomatica := 0;//  if Result then
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaParaPicking := Ord(ChkReposicaoColetaParaPicking.Checked);
  //Produtividade
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInMeta                   := StrToIntDef(EdtCheckInMeta.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckinTolerancia             := StrToIntDef(EdtCheckInTolerancia.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ArmazenagemMeta               := StrToIntDef(EdtArmanenagemMeta.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ArmazenagemTolerancia         := StrToIntDef(EdtArmanenagemTolerancia.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoFracionadoMeta       := StrToIntDef(EdtSeparacaoFracionadoMeta.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoFracionadoTolerancia := StrToIntDef(EdtSeparacaoFracionadoTolerancia.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckoutFracionadoMeta        := StrToIntDef(EdtCheckoutFracionadoMeta.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckoutFracionadoTolerancia  := StrToIntDef(EdtCheckoutFracionadoTolerancia.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExpedicaoMeta                 := StrToIntDef(EdtExpedicaoMeta.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExpedicaoTolerancia           := StrToIntDef(EdtExpedicaoTolerancia.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaMeta           := StrToIntDef(EdtReposicaoColetaMeta.Text, 0);
  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaTolerancia     := StrToIntDef(EdtReposicaoColetaTolerancia.Text, 0);

  FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaParaPicking := Ord(ChkReposicaoColetaParaPicking.Checked);
  Result := FrmeXactWMS.ConfigWMS.Salvar;
     //FLaboratorio.ObjLaboratorio.IdLaboratorio := 0;
end;

procedure TFrmConfiguracao.ShowDados;
Var xModel : Integer;
begin
  inherited;
  // Definir impressora de Rede
  // https://forum.scriptbrasil.com.br/topic/186933-resolvido-como-setar-outra-impressora-em-runtime/
  // http://www.linhadecodigo.com.br/artigo/3465/classe-generica-para-transformar-tipos-enum-para-tstrings-em-delphi.aspx
  CbIntPickingByLightModelo.Items.Clear;
  CbIntPickingByVoiceModelo.Items.Clear;
  for xModel := 0 to 3 do begin //Ord(High(TPickByLightModelo)) do Begin
    CbIntPickingByLightModelo.Items.Add(GetEnumName(TypeInfo(TPickByLightModelo), ord(TPickByLightModelo(xModel))));
    CbIntPickingByVoiceModelo.Items.Add(GetEnumName(TypeInfo(TPickByLightModelo), ord(TPickByLightModelo(xModel))));
  End;
  CbCadCliente.ItemIndex           := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadClienteIncluir;
  CbCadFornecedor.ItemIndex        := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadFornecedorIncluir;
  CbCadProduto.ItemIndex           := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadProdutoIncluir;
  CbCadXmlEntrada.ItemIndex        := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadEntradaIncluir;
  CbCadRastroIdProdNovo.ItemIndex  := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadRastroIdProdNovo;
  CbAutorizarAltLote.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.AutorizarAltLote;
  CbShelflifeRecebimento.ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ShelflifeRecebimento;
  CbShelflifeExpedicao.ItemIndex   := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ShelflifeExpedicao;

  CbBloqEntrValidade.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EntradaBloqueioVencimento;
  CbBloqSaidaValidade.ItemIndex    := FrmeXactWMS.ConfigWMS.ObjConfiguracao.SaidaBloqueioVencimento;
  CbBloqStatusFornecedor.ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.StatusFornecedor;
  CbBloqStatusCliente.ItemIndex    := FrmeXactWMS.ConfigWMS.ObjConfiguracao.StatusCliente;
  RbTagProduto0.Checked := FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 0;
  RbTagProduto1.Checked := FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 1;
  RbTagProduto2.Checked := FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 2;
  RbTagProduto3.Checked := FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagProdutoEntrada = 3;

  CbCheckInItem.ItemIndex               := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInItem;
  CbBuscarStage.ItemIndex               := FrmeXactWMS.ConfigWMS.ObjConfiguracao.BuscarStage;
  CbPreVencido.ItemIndex                := FrmeXactWMS.ConfigWMS.ObjConfiguracao.MesesParaPreVencido;
  CbMudarPickingEstoquePallet.ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.MudarPickingEstoquePallet;
  CbCadRastroIdProdNovo.ItemIndex       := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadRastroIdProdNovo;
  CbAutorizarAltLote.ItemIndex          := FrmeXactWMS.ConfigWMS.ObjConfiguracao.AutorizarAltLote;
  CbEnderecarProdutoEntrada.ItemIndex   := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecarProdutoEntrada;
  CbCubagemProdutoEntrada.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CubagemProdutoEntrada;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoSegregadoId <> 0 then
     EdtEnderecoSegregadoId.Text        := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoSegregadoId.ToString
  Else EdtEnderecoSegregadoid.Clear;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdVolumeExpedidoCancelado <> 0 then
     EdtEnderecoIdVolumeExpedidoCancelado.Text      := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdVolumeExpedidoCancelado.ToString
  Else EdtEnderecoIdVolumeExpedidoCancelado.Clear;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdStage <> 0 then
     EdtEnderecoIdStage.Text      := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdStage.ToString
  Else EdtEnderecoIdStage.Clear;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdStageSNGPC <> 0 then
     EdtEnderecoIdStageSNGPC.Text      := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoIdStageSNGPC.ToString
  Else EdtEnderecoIdStageSNGPC.Clear;
  //Apanhe - CheckOut
  CbRegApanhe.ItemIndex                  := FrmeXactWMS.ConfigWMS.ObjConfiguracao.RegApanhe;
  CbApanheConsolidado.ItemIndex          := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ApanheConsolidado;
  CbSeparacaoCodigoInterno.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno;
  CbPrinterEtqVolumeExtraAuto .ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.PrinterEtqVolumeExtraAuto;
  CbBeepProdIndividual.ItemIndex         := FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepProdIndividual;
  EdtBeepIndividualLimiteUnid.Text       := FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepIndividualLimiteUnid.ToString();
  CbIdentCaixaApanhe.ItemIndex           := FrmeXactWMS.ConfigWMS.ObjCOnfiguracao.IdentCaixaApanhe;
  CbOmitirUnidEtqVolume.ItemIndex        := FrmeXactWMS.ConfigWMS.ObjCOnfiguracao.OmitirUnidEtqVolume;
  CbLacreSeguranca.itemIndex             := FrmeXactWMS.ConfigWMS.ObjConfiguracao.LacreSeguranca;
  CbModeloEtqVolume.ItemIndex            := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume;
  CbCorteSupervisionado.ItemIndex        := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CorteSupervisionado;
  CbCargaEmTransito.ItemIndex            := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CargaEmTransito;
  CbVolCxaFechadaExpedicao.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolCxaFechadaExpedicao;
  CbVolCxaFracionadaExpedicao.ItemIndex  := FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolCxaFracionadaExpedicao;
  CbReconferirCorteReconferencia.ItemIndex   := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReconferirCorteReconferencia;
  CbExigirReconferenciaToExpedicao.ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExigirReconferenciaToExpedicao;
  CbVolumeAuditoria.ItemIndex                := FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolumeAuditoria;
  CbModeloPrinterCodBar.ItemIndex    := CbModeloPrinterCodBar.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
  CbPortaPrinterCodBar.ItemIndex     := CbPortaPrinterGerencial.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra);
  CbModeloPrinterGerencial.ItemIndex := CbModeloPrinterGerencial.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterGerencial);
  CbPortaPrinterGerencial.ItemIndex  := CbPortaPrinterGerencial.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterGerencial);
  //Integração com Equipamentos
  CbIntBalancaPrecisao.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.BalancaPrecisao;
  CbIntDesvioRota.ItemIndex          := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EsteiraDesvioRota;
  CbIntDesvioAuditoria.ItemIndex     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EsteiraDesvioAuditoria;
  CbIntDesvioAuditoriaTipo.ItemIndex := FrmeXactWMS.ConfigWMS.ObjConfiguracao.EsteiraTipoDesvioAuditoria;

  tpPickByLightModelo := TPickByLightModelo(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByLightModelo);
  tpPickByVoiceModelo := TPickByLightModelo(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByVoiceModelo);
  CbIntPickingByLight.ItemIndex          := FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByLight;
  CbIntPickingByLightModelo.ItemIndex    := Ord(tpPickByLightModelo);
  CbIntPickingByVoice.ItemIndex          := FrmeXactWMS.ConfigWMS.ObjConfiguracao.PickingByVoice;
  CbIntPickingByVoiceModelo.ItemIndex    := Ord(tpPickByVoiceModelo);
  ChkInventarioForcarMaxContagem.Checked    := FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioForcarMaxContagem    = 1;
  ChkInventarioDivergenciaSegregado.Checked := FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioDivergenciaSegregado = 1;
  ChkIntegrarAjusteERP.Checked              := FrmeXactWMS.ConfigWMS.ObjConfiguracao.IntegrarAjusteERP = 1;
  CbInventarioAjustePadrao.ItemIndex        := FrmeXactWMS.ConfigWMS.ObjConfiguracao.InventarioAjustePadrao+1;
  CbTagVolumeOrdem.ItemIndex                := FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagVolumeOrdem;
  CbReCheckOutUsuario.Itemindex             := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReCheckOutUsuario;
  ChkReposicaoColetor.Checked               := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetor    = 1;
  ChkReposicaoAutomatica.Checked            := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoAutomatica = 1;
  ChkReposicaoColetaParaPicking.Checked     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaParaPicking = 1;
  EdtIdentificacaoCd.Text                   := FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa;
  //Produtividade
  EdtCheckInMeta.Text                       := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInMeta.ToString();
  EdtCheckInTolerancia.Text                 := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckInTolerancia.ToString();
  EdtArmanenagemMeta.Text                   := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ArmazenagemMeta.ToString();
  EdtArmanenagemTolerancia.Text             := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ArmazenagemTolerancia.ToString();
  EdtSeparacaoFracionadoMeta.Text           := FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoFracionadoMeta.ToString();
  EdtSeparacaoFracionadoTolerancia.Text     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoFracionadoTolerancia.ToString();
  EdtCheckOutFracionadoMeta.Text            := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckoutFracionadoMeta.ToString();
  EdtCheckOutFracionadoTolerancia.Text      := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckoutFracionadoTolerancia.ToString();
  EdtCheckOutCxaFechadaMeta.Text            := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckoutCxaFechadaMeta.ToString();
  EdtCheckOutCxaFechadaTolerancia.Text      := FrmeXactWMS.ConfigWMS.ObjConfiguracao.CheckoutCxaFechadaTolerancia.ToString();
  EdtExpedicaoMeta.Text                     := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExpedicaoMeta.ToString();
  EdtExpedicaoTolerancia.Text               := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExpedicaoTolerancia.ToString();
  EdtReposicaoColetaMeta.Text               := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaMeta.ToString();
  EdtReposicaoColetaTolerancia.Text         := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaTolerancia.ToString();
end;

procedure TFrmConfiguracao.TabImpressoraShow(Sender: TObject);
var
  I : TACBrETQModelo ;
  J: TACBrETQDPI;
  K: TACBrETQUnidade;
  L: TACBrETQBackFeed;
  M: Integer;
  N: TACBrETQOrigem;
  O: TACBrETQPaginaCodigo;
  xPrinter : Integer;
begin
  inherited;
  CbModeloPrinterCodBar.Items.Clear ;
  For I := Low(TACBrETQModelo) to High(TACBrETQModelo) do
     CbModeloPrinterCodBar.Items.Add( GetEnumName(TypeInfo(TACBrETQModelo), integer(I) ) ) ;
  CbModeloPrinterGerencial.Items := CbModeloPrinterCodBar.Items;
  CbPortaPrinterCodBar.Items.Clear;
  ACBrETQ.Device.AcharPortasSeriais( CbPortaPrinterCodBar.Items );

  {$IfDef MSWINDOWS}
   ACBrETQ.Device.WinUSB.FindUSBPrinters();
   for M := 0 to ACBrETQ.Device.WinUSB.DeviceList.Count-1 do
     CbPortaPrinterCodBar.Items.Add('USB:'+ACBrETQ.Device.WinUSB.DeviceList.Items[M].DeviceName);
  {$EndIf}
  CbPortaPrinterGerencial.Items := CbPortaPrinterCodBar.Items;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra <> '' then
     CbModeloPrinterCodBar.ItemIndex := CbModeloPrinterCodBar.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra<> '' then
     CbPortaPrinterCodBar.ItemIndex := CbPortaPrinterCodBar.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra);

   CbPortaPrinterGerencial.Items.Clear;
   Printer.PrinterIndex := -1;
   For xPrinter := 0 to Printer.printers.Count-1 do
     CbPortaPrinterGerencial.Items.Add(Printer.Printers[xPrinter]);
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterGerencial <> '' then
     CbModeloPrinterGerencial.ItemIndex := CbModeloPrinterGerencial.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterGerencial);
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterGerencial <> '' then
     CbPortaPrinterGerencial.ItemIndex := CbPortaPrinterGerencial.Items.IndexOf(FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterGerencial);
end;

end.
