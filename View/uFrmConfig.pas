unit uFrmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, JvComponentBase,
  JvComputerInfoEx, acPNG, acImage;

type
  TfrmParametrosCadastrar = class(TfrmPadrao)
    lstGrupos: TListBox;
    pgcParametros: TPageControl;
    pgEntrada: TTabSheet;
    chkPermitirAlterarTipo: TCheckBox;
    edtEntradaValidadeMinimaPadrao: TLabeledEdit;
    GroupBox1: TGroupBox;
    grpEficiencia: TGroupBox;
    edtEntradaIndicadoresEficienciaMeta: TLabeledEdit;
    edtEntradaIndicadoresEficienciaAceitavel: TLabeledEdit;
    pgSaida: TTabSheet;
    chkExibirDadosCliente: TCheckBox;
    pgExpedicao: TTabSheet;
    chkHabilitarConferenciaManual: TCheckBox;
    lblTipoConferencia: TLabel;
    cbbTipoConferencia: TComboBox;
    chkHabilitarRegistroEntregaManual: TCheckBox;
    chkPermitirDigitacaoColetor: TCheckBox;
    chkHabilitarConferenciaCaixaFechadaDesktop: TCheckBox;
    edtSaidaEficienciaMinima: TLabeledEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    edtSaidaIndicadoresProdutividadeMeta: TLabeledEdit;
    edtSaidaIndicadoresProdutividadeAceitavel: TLabeledEdit;
    chkExibirEstoquePendenciaConferencia: TCheckBox;
    chkBuscarAreaEspera: TCheckBox;
    lblTipoSeparacao: TLabel;
    cbbTipoSeparacao: TComboBox;
    chkImprimirQuebraLote: TCheckBox;
    lblTipoIdentificacaoVolume: TLabel;
    cbbTipoIdentificacaoVolume: TComboBox;
    cbbOrdemSeparacao: TComboBox;
    Label1: TLabel;
    pgCrossDocking: TTabSheet;
    chkConferirSeparacao: TCheckBox;
    edtSaidaValidadeMinimaPadrao: TLabeledEdit;
    ChkSeparacaoColetor: TCheckBox;
    ChkSeparacaoConferencia: TCheckBox;
    TabSistema: TTabSheet;
    ChkInvExMotivoDiv: TCheckBox;
    EdtAnoVencProdCtrlEntr: TLabeledEdit;
    ChksaiRegistrarSeparacao: TCheckBox;
    ChkArmazenagemVisualizarEstoque: TCheckBox;
    ChkReposicaoColetor: TCheckBox;
    ChkSeparacaoConferenciaColetor: TCheckBox;
    ChkForcarBeepConferencia: TCheckBox;
    EdtSkuBeep: TLabeledEdit;
    Bevel1: TBevel;
    Label2: TLabel;
    procedure chkPermitirAlterarTipoClick(Sender: TObject);
    procedure edtEntradaValidadeMinimaPadraoChange(Sender: TObject);
    procedure edtEntradaValidadeMinimaPadraoKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lstGruposClick(Sender: TObject);
    procedure edtEntradaIndicadoresEficienciaMetaChange(Sender: TObject);
    procedure edtEntradaIndicadoresEficienciaAceitavelChange(
      Sender: TObject);
    procedure chkExibirDadosClienteClick(Sender: TObject);
    procedure chkHabilitarConferenciaManualClick(Sender: TObject);
    procedure cbbTipoConferenciaClick(Sender: TObject);
    procedure chkHabilitarRegistroEntregaManualClick(Sender: TObject);
    procedure chkPermitirDigitacaoColetorClick(Sender: TObject);
    procedure chkHabilitarConferenciaCaixaFechadaDesktopClick(
      Sender: TObject);
    procedure edtSaidaEficienciaMinimaChange(Sender: TObject);
    procedure edtSaidaIndicadoresProdutividadeMetaChange(Sender: TObject);
    procedure edtSaidaIndicadoresProdutividadeAceitavelChange(
      Sender: TObject);
    procedure chkExibirEstoquePendenciaConferenciaClick(Sender: TObject);
    procedure chkBuscarAreaEsperaClick(Sender: TObject);
    procedure cbbTipoSeparacaoClick(Sender: TObject);
    procedure chkImprimirQuebraLoteClick(Sender: TObject);
    procedure cbbTipoIdentificacaoVolumeClick(Sender: TObject);
    procedure cbbOrdemSeparacaoClick(Sender: TObject);
    procedure chkConferirSeparacaoClick(Sender: TObject);
    procedure edtSaidaValidadeMinimaPadraoChange(Sender: TObject);
    procedure ChkSeparacaoColetorClick(Sender: TObject);
    procedure ChkSeparacaoConferenciaClick(Sender: TObject);
    procedure ChkInvExMotivoDivClick(Sender: TObject);
    procedure EdtAnoVencProdCtrlEntrChange(Sender: TObject);
    procedure ChksaiRegistrarSeparacaoClick(Sender: TObject);
    procedure ChkArmazenagemVisualizarEstoqueClick(Sender: TObject);
    procedure ChkReposicaoColetorClick(Sender: TObject);
    procedure ChkSeparacaoConferenciaColetorClick(Sender: TObject);
    procedure ChkForcarBeepConferenciaClick(Sender: TObject);
    procedure EdtSkuBeepChange(Sender: TObject);
  private
    { Private declarations }
    vgParametros: TClientDataSet;

    procedure AlterarParametro(pNome, pValor: string);
    procedure AtualizarParametros;
    function  PegarParametro(pNome: string): string;
  protected
    procedure Habilitar; override;
    procedure Limpar; override;
    procedure SalvarRegistro; override;
  public
    { Public declarations }
    procedure Cancelar; override;
  end;

var
  frmParametrosCadastrar: TfrmParametrosCadastrar;

implementation

{$R *.dfm}

uses uFuncoes, uTConfig;

{ TfrmParametrosCadastrar }

procedure TfrmParametrosCadastrar.AlterarParametro(pNome, pValor: string);
begin
  if (vgParametros.Locate('nmParametro', pNome, []) = False) then
    begin
      raise Exception.Create('Parâmetro "' + pNome + '" não encontrado!');
    end;

  vgParametros.Edit;
  vgParametros.FieldByName('vlParametro').Value := pValor;
  vgParametros.Post;
end;

procedure TfrmParametrosCadastrar.AtualizarParametros;
begin
  FreeAndNil(vgParametros);

  vgParametros := TClientDataSet.Create(nil);

  vgParametros.Close;
  vgParametros.Data := TConfig.AtualizarParametros;
end;

procedure TfrmParametrosCadastrar.Cancelar;
begin
  inherited;

  Close;
end;

procedure TfrmParametrosCadastrar.cbbOrdemSeparacaoClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiOrdemSeparacao', cbbOrdemSeparacao.Text);
end;

procedure TfrmParametrosCadastrar.cbbTipoConferenciaClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('expTipoConferencia', IntToStr(cbbTipoConferencia.ItemIndex));
end;

procedure TfrmParametrosCadastrar.cbbTipoIdentificacaoVolumeClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiTipoIdentificacaoVolume', cbbTipoIdentificacaoVolume.Text);
end;

procedure TfrmParametrosCadastrar.cbbTipoSeparacaoClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiTipoSeparacao', cbbTipoSeparacao.Text);
end;

procedure TfrmParametrosCadastrar.ChkArmazenagemVisualizarEstoqueClick(
  Sender: TObject);
begin
  inherited;
  AlterarParametro('ArmazenagemVisualizarEstoque', IntToStr(Ord(ChkArmazenagemVisualizarEstoque.Checked)));
end;

procedure TfrmParametrosCadastrar.chkBuscarAreaEsperaClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiBuscarAreaEspera', IntToStr(Ord(chkBuscarAreaEspera.Checked)));
end;

procedure TfrmParametrosCadastrar.chkConferirSeparacaoClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('crsConferirSeparacao', IntToStr(Ord(chkConferirSeparacao.Checked)));
end;

procedure TfrmParametrosCadastrar.chkExibirDadosClienteClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiExibirDadosCliente', IntToStr(Ord(chkExibirDadosCliente.Checked)));
end;

procedure TfrmParametrosCadastrar.chkExibirEstoquePendenciaConferenciaClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiExibirEstoquePendenciaConferencia', IntToStr(Ord(chkExibirEstoquePendenciaConferencia.Checked)));
end;

procedure TfrmParametrosCadastrar.ChkForcarBeepConferenciaClick(
  Sender: TObject);
begin
  inherited;
  AlterarParametro('Forçar Beepagem de Produto Individual', IntToStr(Ord(ChkForcarBeepConferencia.Checked)));
  EdtSkuBeep.Enabled := ChkForcarBeepConferencia.Checked;
  if Not EdtskuBeep.Enabled then Begin
     EdtSkuBeep.Text := '0';
     AlterarParametro('SKU mínimo para Beep Individual', '0');
  End;
end;

procedure TfrmParametrosCadastrar.chkHabilitarConferenciaCaixaFechadaDesktopClick(
  Sender: TObject);
begin
  inherited;

  AlterarParametro('saiHabilitarConferenciaCaixaFechadaDesktop', IntToStr(Ord(chkHabilitarConferenciaCaixaFechadaDesktop.Checked)));
end;

procedure TfrmParametrosCadastrar.chkHabilitarConferenciaManualClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('expHabilitarConferenciaManual', IntToStr(Ord(chkHabilitarConferenciaManual.Checked)));

  lblTipoConferencia.Enabled := chkHabilitarConferenciaManual.Checked;
  cbbTipoConferencia.Enabled := chkHabilitarConferenciaManual.Checked;
end;

procedure TfrmParametrosCadastrar.chkHabilitarRegistroEntregaManualClick(
  Sender: TObject);
begin
  inherited;

  AlterarParametro('expHabilitarRegistroEntregaManual', IntToStr(Ord(chkHabilitarRegistroEntregaManual.Checked)));
end;

procedure TfrmParametrosCadastrar.chkImprimirQuebraLoteClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('saiImprimirQuebraLote', IntToStr(Ord(chkImprimirQuebraLote.Checked)));
end;

procedure TfrmParametrosCadastrar.ChkInvExMotivoDivClick(Sender: TObject);
begin
  inherited;
  AlterarParametro('ExMotivoDivergência', IntToStr(Ord(ChkInvExMotivoDiv.Checked)));
end;

procedure TfrmParametrosCadastrar.chkPermitirAlterarTipoClick(Sender: TObject);
begin
  inherited;

  AlterarParametro('entPermitirAlterarTipo', IntToStr(Ord(chkPermitirAlterarTipo.Checked)));
end;

procedure TfrmParametrosCadastrar.chkPermitirDigitacaoColetorClick(
  Sender: TObject);
begin
  inherited;

  AlterarParametro('expPermitirDigitacaoColetor', IntToStr(Ord(chkPermitirDigitacaoColetor.Checked)));
end;

procedure TfrmParametrosCadastrar.ChkReposicaoColetorClick(Sender: TObject);
begin
  inherited;
  AlterarParametro('ReposicaoColetor', IntToStr(Ord(ChkReposicaoColetor.Checked)));
end;

procedure TfrmParametrosCadastrar.ChksaiRegistrarSeparacaoClick(
  Sender: TObject);
begin
  inherited;
  AlterarParametro('saiRegistrarSeparacao', IntToStr(Ord(ChksaiRegistrarSeparacao.Checked)));
end;

procedure TfrmParametrosCadastrar.ChkSeparacaoColetorClick(Sender: TObject);
begin
  inherited;
  AlterarParametro('separacaocoletor', IntToStr(Ord(ChkseparacaoColetor.Checked)));
end;

procedure TfrmParametrosCadastrar.ChkSeparacaoConferenciaClick(Sender: TObject);
begin
  inherited;
  AlterarParametro('SeparacaoConferencia', IntToStr(Ord(ChkseparacaoConferencia.Checked)));
end;

procedure TfrmParametrosCadastrar.ChkSeparacaoConferenciaColetorClick(
  Sender: TObject);
begin
  inherited;
  AlterarParametro('Ativar Conferência Automática', IntToStr(Ord(ChkSeparacaoConferenciaColetor.Checked)));
end;

procedure TfrmParametrosCadastrar.EdtAnoVencProdCtrlEntrChange(Sender: TObject);
begin
  inherited;
  if (Trim(EdtAnoVencProdCtrlEntr.Text) = '') then begin
      EdtAnoVencProdCtrlEntr.Text := '0';
      EdtAnoVencProdCtrlEntr.SelectAll;
  end;
  AlterarParametro('AnoVencProdCtrlEntr', EdtAnoVencProdCtrlEntr.Text);
end;

procedure TfrmParametrosCadastrar.edtEntradaIndicadoresEficienciaAceitavelChange(
  Sender: TObject);
begin
  inherited;

  if (Trim(edtEntradaIndicadoresEficienciaAceitavel.Text) = '') then
    begin
      edtEntradaIndicadoresEficienciaAceitavel.Text := '0';
      edtEntradaIndicadoresEficienciaAceitavel.SelectAll;
    end
  else if (StrToInt(edtEntradaIndicadoresEficienciaAceitavel.Text) > 100) then
    begin
      edtEntradaIndicadoresEficienciaAceitavel.Text := '100';
      edtEntradaIndicadoresEficienciaAceitavel.SelectAll;
    end;

  AlterarParametro('entIndicadoresEficienciaAceitavel', edtEntradaIndicadoresEficienciaAceitavel.Text);
end;

procedure TfrmParametrosCadastrar.edtEntradaIndicadoresEficienciaMetaChange(
  Sender: TObject);
begin
  inherited;

  if (Trim(edtEntradaIndicadoresEficienciaMeta.Text) = '') then
    begin
      edtEntradaIndicadoresEficienciaMeta.Text := '0';
      edtEntradaIndicadoresEficienciaMeta.SelectAll;
    end
  else if (StrToInt(edtEntradaIndicadoresEficienciaMeta.Text) > 100) then
    begin
      edtEntradaIndicadoresEficienciaMeta.Text := '100';
      edtEntradaIndicadoresEficienciaMeta.SelectAll;
    end;

  AlterarParametro('entIndicadoresEficienciaMeta', edtEntradaIndicadoresEficienciaMeta.Text);
end;

procedure TfrmParametrosCadastrar.edtEntradaValidadeMinimaPadraoChange(
  Sender: TObject);
begin
  inherited;

  if (Trim(edtEntradaValidadeMinimaPadrao.Text) = '') then
    begin
      edtEntradaValidadeMinimaPadrao.Text := '0';
      edtEntradaValidadeMinimaPadrao.SelectAll;
    end;

  AlterarParametro('entValidadeMinimaPadrao', edtEntradaValidadeMinimaPadrao.Text);
end;

procedure TfrmParametrosCadastrar.edtEntradaValidadeMinimaPadraoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  SoNumeros(Key);
end;

procedure TfrmParametrosCadastrar.edtSaidaEficienciaMinimaChange(Sender: TObject);
begin
  inherited;

  if (Trim(edtSaidaEficienciaMinima.Text) = '') then
    begin
      edtSaidaEficienciaMinima.Text := '0';
      edtSaidaEficienciaMinima.SelectAll;
    end
  else if (StrToInt(edtSaidaEficienciaMinima.Text) > 100) then
    begin
      edtSaidaEficienciaMinima.Text := '100';
      edtSaidaEficienciaMinima.SelectAll;
    end;

  AlterarParametro('saiEficienciaMinima', edtSaidaEficienciaMinima.Text);
end;

procedure TfrmParametrosCadastrar.edtSaidaIndicadoresProdutividadeAceitavelChange(Sender: TObject);
begin
  inherited;

  if (Trim(edtSaidaIndicadoresProdutividadeAceitavel.Text) = '') then
    begin
      edtSaidaIndicadoresProdutividadeAceitavel.Text := '0';
      edtSaidaIndicadoresProdutividadeAceitavel.SelectAll;
    end;

  AlterarParametro('saiIndicadoresProdutividadeAceitavel', edtSaidaIndicadoresProdutividadeAceitavel.Text);
end;

procedure TfrmParametrosCadastrar.edtSaidaIndicadoresProdutividadeMetaChange(Sender: TObject);
begin
  inherited;

  if (Trim(edtSaidaIndicadoresProdutividadeMeta.Text) = '') then
    begin
      edtSaidaIndicadoresProdutividadeMeta.Text := '0';
      edtSaidaIndicadoresProdutividadeMeta.SelectAll;
    end;

  AlterarParametro('saiIndicadoresProdutividadeMeta', edtSaidaIndicadoresProdutividadeMeta.Text);
end;

procedure TfrmParametrosCadastrar.edtSaidaValidadeMinimaPadraoChange(Sender: TObject);
begin
  inherited;

  if (Trim(edtSaidaValidadeMinimaPadrao.Text) = '') then
    begin
      edtSaidaValidadeMinimaPadrao.Text := '0';
      edtSaidaValidadeMinimaPadrao.SelectAll;
    end;

  AlterarParametro('saiValidadeMinimaPadrao', edtSaidaValidadeMinimaPadrao.Text);
end;

procedure TfrmParametrosCadastrar.EdtSkuBeepChange(Sender: TObject);
begin
  inherited;
  AlterarParametro('SKU mínimo para Beep Individual', IntToStr(StrToIntDef(EdtSkuBeep.Text, 0)));
end;

procedure TfrmParametrosCadastrar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  frmParametrosCadastrar := nil;
end;

procedure TfrmParametrosCadastrar.FormCreate(Sender: TObject);
begin
  inherited;

  vgCodigoFuncao := 3; // 3 = Cadastrar Parâmetro

  lstGrupos.ItemIndex := 0;
  lstGruposClick(Sender);

  Limpar;
  Habilitar;
end;

procedure TfrmParametrosCadastrar.Habilitar;
begin
  inherited;

  HabilitarAtalhos([aSalvar, aCancelar]);
end;

procedure TfrmParametrosCadastrar.Limpar;
begin
  inherited;

  AtualizarParametros;

  // Entrada
  chkPermitirAlterarTipo.Checked                  := StrToInt(PegarParametro('entPermitirAlterarTipo')) = 1;
  edtEntradaValidadeMinimaPadrao.Text             := PegarParametro('entValidadeMinimaPadrao');
  EdtAnoVencProdCtrlEntr.Text                     := PegarParametro('AnoVencProdCtrlEntr');
  edtEntradaIndicadoresEficienciaMeta.Text        := PegarParametro('entIndicadoresEficienciaMeta');
  edtEntradaIndicadoresEficienciaAceitavel.Text   := PegarParametro('entIndicadoresEficienciaAceitavel');

  // Cross Docking
  chkConferirSeparacao.Checked := StrToInt(PegarParametro('crsConferirSeparacao')) = 1;

  // Saída
  chkBuscarAreaEspera.Checked                        := StrToInt(PegarParametro('saiBuscarAreaEspera')) = 1;
  chkExibirDadosCliente.Checked                      := StrToInt(PegarParametro('saiExibirDadosCliente')) = 1;
  chkExibirEstoquePendenciaConferencia.Checked       := StrToInt(PegarParametro('saiExibirEstoquePendenciaConferencia')) = 1;
  chkHabilitarConferenciaCaixaFechadaDesktop.Checked := StrToInt(PegarParametro('saiHabilitarConferenciaCaixaFechadaDesktop')) = 1;
  chkImprimirQuebraLote.Checked                      := StrToInt(PegarParametro('saiImprimirQuebraLote')) = 1;
  ChkSeparacaoColetor.Checked                        := StrToInt(PegarParametro('separacaocoletor')) = 1;
  ChkSeparacaoConferenciaColetor.Checked             := StrToInt(PegarParametro('Ativar Conferência Automática')) = 1;
  ChkForcarBeepConferencia.Checked                   := StrToInt(PegarParametro('Forçar Beepagem de Produto Individual')) = 1;
  EdtSkuBeep.Text                                    := PegarParametro('SKU mínimo para Beep Individual');
  ChkSeparacaoConferencia.Checked                    := StrToInt(PegarParametro('SeparacaoConferencia')) = 1;  //Desktop
  ChksaiRegistrarSeparacao.Checked                   := StrToInt(PegarParametro('saiRegistrarSeparacao')) = 1;
  cbbTipoIdentificacaoVolume.ItemIndex               := cbbTipoIdentificacaoVolume.Items.IndexOf(PegarParametro('saiTipoIdentificacaoVolume'));
  cbbTipoSeparacao.ItemIndex                         := cbbTipoSeparacao.Items.IndexOf(PegarParametro('saiTipoSeparacao'));
  cbbOrdemSeparacao.ItemIndex                        := cbbOrdemSeparacao.Items.IndexOf(PegarParametro('saiOrdemSeparacao'));
  edtSaidaEficienciaMinima.Text                      := PegarParametro('saiEficienciaMinima');
  edtSaidaIndicadoresProdutividadeMeta.Text          := PegarParametro('saiIndicadoresProdutividadeMeta');
  edtSaidaIndicadoresProdutividadeAceitavel.Text     := PegarParametro('saiIndicadoresProdutividadeAceitavel');
  edtSaidaValidadeMinimaPadrao.Text                  := PegarParametro('saiValidadeMinimaPadrao');

  // Expedição
  chkHabilitarConferenciaManual.Checked     := StrToInt(PegarParametro('expHabilitarConferenciaManual')) = 1;
  cbbTipoConferencia.ItemIndex              := StrToInt(PegarParametro('expTipoConferencia'));
  lblTipoConferencia.Enabled                := chkHabilitarConferenciaManual.Checked;
  cbbTipoConferencia.Enabled                := chkHabilitarConferenciaManual.Checked;
  chkHabilitarRegistroEntregaManual.Checked := StrToInt(PegarParametro('expHabilitarRegistroEntregaManual')) = 1;
  chkPermitirDigitacaoColetor.Checked       := StrToInt(PegarParametro('expPermitirDigitacaoColetor')) = 1;

  //Sistema - Geral
  ChkArmazenagemVisualizarEstoque.Checked := StrToInt(PegarParametro('ArmazenagemVisualizarEstoque')) = 1;
  ChkInvExMotivoDiv.Checked               := StrToInt(PegarParametro('ExMotivoDivergência')) = 1;
  ChkReposicaoColetor.Checked             := StrToInt(PegarParametro('ReposicaoColetor')) = 1;
end;

procedure TfrmParametrosCadastrar.lstGruposClick(Sender: TObject);
begin
  inherited;

  case lstGrupos.ItemIndex of
    0: pgcParametros.ActivePage := pgCrossDocking; // Cross Docking
    1: pgcParametros.ActivePage := pgEntrada;      // Entrada
    2: pgcParametros.ActivePage := pgExpedicao;    // Expedição
    3: pgcParametros.ActivePage := pgSaida;        // Saída
    4: pgcParametros.ActivePage := TabSistema;    // Sistema - Geral
  end;
end;

function TfrmParametrosCadastrar.PegarParametro(pNome: string): string;
begin
  if (vgParametros.Locate('nmParametro', pNome, []) = False) then
    begin
      raise Exception.Create('Parâmetro "' + pNome + '" não encontrado!');
    end;

  Result := vgParametros.FieldByName('vlParametro').AsString;
end;

procedure TfrmParametrosCadastrar.SalvarRegistro;
begin
  inherited;

  ExibirAguarde;

  try
    TConfig.SalvarParametros(vgParametros.Data, vgHistorico);
    AtualizarParametros;
  finally
    OcultarAguarde;
  end;
end;

end.
