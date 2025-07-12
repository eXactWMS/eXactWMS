unit uTEntrada;

interface

uses uTFornecedor, uTHistorico, uTSegregadoMotivo, Datasnap.DBClient,
     uTEstoque, uTImpressora, uTProduto, UTEndereco, uTLote, uDmCadastroGeral;

type
  TTipoAcao = (taSomar, taSubstituir);
  TTipoLista = (tlEntrada, tlSegregados, tlDevolvidos);

  TEntradaTipoConferencia = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarTipos: OleVariant;
  end;

  TEntradaTipo = class
    private
      FCodigo: Integer;
      FNome: string;
      FEstoque: TTipoEstoque;
      FTipoConferencia: TEntradaTipoConferencia;

      procedure setTipoConferencia(pTipoConferencia: TEntradaTipoConferencia);
      procedure ValidarDados;
    public
      property Codigo: Integer                            read FCodigo            write FCodigo;
      property Nome: string                               read FNome              write FNome;
      property Estoque: TTipoEstoque                      read FEstoque           write FEstoque;
      property TipoConferencia: TEntradaTipoConferencia   read FTipoConferencia   write setTipoConferencia;

      constructor Create;
      destructor Destroy; override;

      class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
      class function  ListarTipos: OleVariant;
      class function  PegarTipo(pCodigo: Integer): TEntradaTipo;

      procedure Salvar(pHistorico: THistorico);
  end;

  TEntradaStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarStatus: OleVariant;
  end;

  TEntrada = class
    private
      FCodigo: Integer;
      FData: TDateTime;
      FNotaFiscal: string;
      FDataNotaFiscal: TDateTime;
      FDataConferencia: TDateTime;
      FFornecedor: TFornecedor;
      FTipo: TEntradaTipo;
      FStatus: TEntradaStatus;
      FImpressao: TImpressaoStatus;
      FMotivoSegregado: TSegregadoMotivo;

      FCodigoTipo: Integer;
      FCodigoFornecedor: Integer;

      function  getFornecedor: TFornecedor;
      function  getTipo: TEntradaTipo;
      procedure setFornecedor(pFornecedor: TFornecedor);
      procedure setTipo(pTipoEntrada: TEntradaTipo);

      procedure AtualizarStatus;
      procedure LimparLotesValidadeMinima;
      procedure SalvarEntrada(pCodigoUsuario: Integer);
      procedure SalvarDevolucoes(pCodigoProduto: Int64; pCodigoUsuario: Integer);
      procedure SalvarLotes(pCodigoProduto: Int64; pCodigoUsuario: Integer);
      procedure SalvarProdutos(pCodigoUsuario: Integer);
      procedure SalvarSegregados(pCodigoProduto: Int64; pCodigoUsuario: Integer);
      procedure ValidarDados;
    public
      property Codigo: Integer                    read FCodigo             write FCodigo;
      property Data: TDateTime                    read FData               write FData;
      property NotaFiscal: string                 read FNotaFiscal         write FNotaFiscal;
      property DataNotaFiscal: TDateTime          read FDataNotaFiscal     write FDataNotaFiscal;
      property DataConferencia: TDateTime         read FDataConferencia    write FDataConferencia;
      property Fornecedor: TFornecedor            read getFornecedor       write setFornecedor;
      property Tipo: TEntradaTipo                 read getTipo             write setTipo;
      property Status: TEntradaStatus             read FStatus             write FStatus;
      property Impressao: TImpressaoStatus        read FImpressao          write FImpressao;
      property MotivoSegregado: TSegregadoMotivo  read FMotivoSegregado    write FMotivoSegregado;

      destructor Destroy; override;

      class function AcompanharConferencia: OleVariant;
      class function AcompanharConferenciaFornecedor(pCodigo: Integer): OleVariant;
      class function AcompanharConferenciaPedido(pCodigo: Integer): OleVariant;
      class function PegarEntrada(pCodigo: string): TEntrada;
      class function Pesquisar(pCodigo, pDataEntrada, pNotaFiscal, pDataNotaFiscal, pCodigoFornecedor, pFornecedor,
                               pCodigoEntradaTipo, pCodigoEntradaStatus, pCodigoImpressaoStatus, pCodigoProduto: string): OleVariant;
      class function RelatorioEficiencia(pDataInicial, pDataFinal: string): OleVariant;
      class function RelatorioEficienciaDiario(pMes, pAno: Integer; pTipo : Integer = -1): OleVariant;
      class function RelatorioEficienciaMensal(pAno: Integer; pTipo : Integer = 0): OleVariant;
      class function RelatorioEntradaPorProduto(pCodigoProduto: Int64; pCodigoLote, pDataInicial, pDataFinal: string): OleVariant;
      class function RelatorioLotesDivergentes(pCodigo, pDataEntrada, pNotaFiscal, pDataNotaFiscal, pCodigoEntradaTipo,
                                               pCodigoFornecedor, pCodigoProduto: string): OleVariant;
      class function RelatorioLotesDivergentesLotes(pCodigoEntrada: Integer): OleVariant;
      class function RelatorioLotesDivergentesProdutos(pCodigoEntrada: Integer): OleVariant;
      class function RelatorioProdutividadeGeral(pDataInicial, pDataFinal: string): OleVariant;
      class function RelatorioProdutividadeIndividual(pDataInicial, pDataFinal: string): OleVariant;
      class function RelatorioProdutividadeIndividualDiario(pMes, pAno, pCodigoUsuario: Integer): OleVariant;
      class function RelatorioProdutividadeIndividualMensal(pAno, pCodigoUsuario: Integer): OleVariant;
      class function RelatorioValidadeMinima(pCodEntrada, pDataInicial, pDataFinal, pCodTipo, pNotaFiscal,
                                             pCodFornecedor, pCodProduto: string): OleVariant;
      Class function RelatorioProducao(vData: tDateTime): OleVariant; static;
      class function RelatorioProducaoExcl(vData: tDateTime): OleVariant; static;
      class function RelatorioProducaoVolume(vData: tDateTime): OleVariant; static;
      class function RelatorioProducaoTempo(vData: tDateTime): OleVariant; static;

      procedure AlterarImpressaoStatus(pCodigoStatus: Integer);
      procedure AlterarTipoEntrada(pCodigoTipo: Integer);
      procedure ConferirDevolucao(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pCodigoMotivo, pQuantidade: Integer; pAcao: TTipoAcao);
      procedure ConferirLote(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pQuantidade: Integer; pAcao: TTipoAcao);
      procedure ConferirLoteAbaixoValidadeMinima(pCodigoLote, pCodigoUsuario: Integer; pDataVencimento, pDataValidadeMinima: TDateTime);
      procedure ConferirSegregado(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pCodigoMotivo, pQuantidade: Integer; pAcao: TTipoAcao);
      procedure Excluir(pHistorico: THistorico);
      procedure ExcluirDevolucao(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pCodigoMotivo: Integer);
      procedure ExcluirLote(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario: Integer);
      procedure ExcluirSegregado(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pCodigoMotivo: Integer);
      procedure LimparConferencia;
      function  ListarDevolvidos(pCodigoProduto: Int64; pCodigoUsuario: Integer): OleVariant;
      function  ListarLotes(pCodigoProduto: Int64; pCodigoUsuario: Integer): OleVariant;
      function  ListarProdutos: OleVariant;
      function  ListarSegregados(pCodigoProduto: Int64; pCodigoUsuario: Integer): OleVariant;
      function  ListarUsuarios(pTipoLista: TTipoLista; pCodigoProduto: Int64): OleVariant;
      function  LocalizarLote(pProduto: TProduto; pCodigoUsuario: Integer; pLote, pDataVencimento: string): TLote;
      function  PlanilhaCegaEANs: OleVariant;
      function  PlanilhaCegaLotes: OleVariant;
      function  PlanilhaCegaProdutos: OleVariant;
      procedure Salvar(pHistorico: THistorico);
      procedure VerificarValidades(pCodigoUsuario: Integer);
      //Graficos - TWebChart
      class function GraficosEficiencia(pDataInicial, pDataFinal: string; Tipo : Integer): OleVariant;

  end;

implementation

uses uDmEntrada, SysUtils, DB, DateUtils,
     Forms, Windows, System.Classes, uTMovtoEstoque, System.Variants, Vcl.Controls,
     uFuncoes, FireDAC.Comp.Client;

{ TEntrada }

class function TEntrada.AcompanharConferencia: OleVariant;
begin
  dmEntrada.qryAcompanharConferencia.Close;
  dmEntrada.qryAcompanharConferencia.Open;

  Result := dmEntrada.dspAcompanharConferencia.Data;
end;

class function TEntrada.AcompanharConferenciaFornecedor(pCodigo: Integer): OleVariant;
begin
  dmEntrada.qryAcompanharConferenciaFornecedor.Close;
  dmEntrada.qryAcompanharConferenciaFornecedor.Parameters.ParamByName('pCdFornecedor').Value := pCodigo;
  dmEntrada.qryAcompanharConferenciaFornecedor.Open;

  Result := dmEntrada.dspAcompanharConferenciaFornecedor.Data;
end;

class function TEntrada.AcompanharConferenciaPedido(pCodigo: Integer): OleVariant;
begin
  dmEntrada.qryAcompanharConferenciaPedido.Close;
  dmEntrada.qryAcompanharConferenciaPedido.Parameters.ParamByName('pCdEntrada').Value := pCodigo;
  dmEntrada.qryAcompanharConferenciaPedido.Open;

  Result := dmEntrada.dspAcompanharConferenciaPedido.Data;
end;

procedure TEntrada.AlterarImpressaoStatus(pCodigoStatus: Integer);
begin
  dmEntrada.qryAlterarImpressaoStatus.Close;
  dmEntrada.qryAlterarImpressaoStatus.Parameters.ParamByName('pCdImpressaoStatus').Value := pCodigoStatus;
  dmEntrada.qryAlterarImpressaoStatus.Parameters.ParamByName('pCdEntrada').Value         := Self.Codigo;
  dmEntrada.qryAlterarImpressaoStatus.ExecSQL;

  FImpressao.Codigo := pCodigoStatus;
end;

procedure TEntrada.AlterarTipoEntrada(pCodigoTipo: Integer);
begin
  dmEntrada.qryAlterarTipoEntrada.Close;
  dmEntrada.qryAlterarTipoEntrada.Parameters.ParamByName('pCdEntrada').Value     := Self.Codigo;
  dmEntrada.qryAlterarTipoEntrada.Parameters.ParamByName('pCdEntradaTipo').Value := pCodigoTipo;
  dmEntrada.qryAlterarTipoEntrada.ExecSQL;
end;

procedure TEntrada.AtualizarStatus;
begin
  dmEntrada.qryAtualizarStatus.Close;
  dmEntrada.qryAtualizarStatus.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryAtualizarStatus.Open;

  if (Assigned(Self.FStatus) = False) then
    begin
      Self.FStatus := TEntradaStatus.Create;
    end;

  Self.FStatus.Codigo := dmEntrada.qryAtualizarStatus.FieldByName('cdEntradaStatus').AsInteger;
  Self.FStatus.Nome   := dmEntrada.qryAtualizarStatus.FieldByName('nmEntradaStatus').AsString;
end;

procedure TEntrada.ConferirDevolucao(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario,
  pCodigoMotivo, pQuantidade: Integer; pAcao: TTipoAcao);
var
  vlProdutos: TClientDataSet;
  vlDevolvidos: TClientDataSet;
  vlTransacaoInterna: Boolean;
  vlQtdDivergente: Integer;
begin
  if (pQuantidade <= 0) then
    begin
      raise Exception.Create('Quantidade do Lote inválida!' + sLineBreak +
                             'A quantidade do lote deve ser maior do que zero.');
    end;

  vlProdutos   := TClientDataSet.Create(nil);
  vlDevolvidos := TClientDataSet.Create(nil);

  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmEntrada.qryConferirDevolucao.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmEntrada.qryConferirDevolucao.Connection.Execute('SET NOCOUNT ON;');
        dmEntrada.qryConferirDevolucao.Connection.BeginTrans;
      end;

    try
      vlProdutos.Close;
      vlProdutos.Data := ListarProdutos;

      if (vlProdutos.Locate('cdProduto', pCodigoProduto, []) = False) then
        begin
          raise Exception.Create('Produto inválido!' + sLineBreak +
                                 'O produto selecionado foi removido desta Entrada.');
        end
      else
        begin
          vlQtdDivergente := vlProdutos.FieldByName('qtDivergente').AsInteger;
        end;

      vlDevolvidos.Close;

      case pAcao of
        taSomar:      vlDevolvidos.Data := ListarDevolvidos(pCodigoProduto, pCodigoUsuario);
        taSubstituir: vlDevolvidos.Data := ListarDevolvidos(pCodigoProduto, 0); // 0 = Todos os usuários
      end;

      if (vlDevolvidos.Locate('cdLote;cdDevolucaoMotivo', VarArrayOf([pCodigoLote, pCodigoMotivo]), []) = True) then
        begin
          vlQtdDivergente := vlQtdDivergente + vlDevolvidos.FieldByName('qtDevolvida').AsInteger;
        end;

      if (pQuantidade > vlQtdDivergente) then
        begin
          raise Exception.Create('Quantidade do Lote inválida!' + sLineBreak +
                                 'A quantidade total dos Lotes está acima da quantidade do Produto.');
        end;
    finally
      FreeAndNil(vlProdutos);
      FreeAndNil(vlDevolvidos);
    end;

    dmEntrada.qryConferirDevolucao.Close;
    dmEntrada.qryConferirDevolucao.Parameters.ParamByName('pCdEntrada').Value         := Self.Codigo;
    dmEntrada.qryConferirDevolucao.Parameters.ParamByName('pCdLote').Value            := pCodigoLote;
    dmEntrada.qryConferirDevolucao.Parameters.ParamByName('pCdUsuario').Value         := pCodigoUsuario;
    dmEntrada.qryConferirDevolucao.Parameters.ParamByName('pCdDevolucaoMotivo').Value := pCodigoMotivo;
    dmEntrada.qryConferirDevolucao.Parameters.ParamByName('pQtDevolvida').Value       := pQuantidade;
    dmEntrada.qryConferirDevolucao.Parameters.ParamByName('pAcao').Value              := Ord(pAcao);
    dmEntrada.qryConferirDevolucao.ExecSQL;

    dmEntrada.qryAtualizarQuantidades.Close;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
    dmEntrada.qryAtualizarQuantidades.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryConferirDevolucao.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryConferirDevolucao.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.ConferirLote(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pQuantidade: Integer; pAcao: TTipoAcao);
var
  vlTotal: Integer;
  vlProdutos: TClientDataSet;
  vlLotes: TClientDataSet;
  vlTransacaoInterna: Boolean;
  vlQtdDivergente: Integer;
begin
  if (pQuantidade < 0) then
    begin
      raise Exception.Create('Quantidade do Lote inválida!' + sLineBreak +
                             'A quantidade do lote não pode ser menor que zero.');
    end;

  vlTotal    := pQuantidade;
  vlProdutos := TClientDataSet.Create(nil);
  vlLotes    := TClientDataSet.Create(nil);

  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmEntrada.qryConferirLote.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmEntrada.qryConferirLote.Connection.Execute('SET NOCOUNT ON;');
        dmEntrada.qryConferirLote.Connection.BeginTrans;
      end;

    try
      vlProdutos.Close;
      vlProdutos.Data := ListarProdutos;

      if (vlProdutos.Locate('cdProduto', pCodigoProduto, []) = False) then
        begin
          raise Exception.Create('Produto inválido!' + sLineBreak +
                                 'O produto selecionado foi removido desta Entrada.');
        end
      else
        begin
          vlQtdDivergente := vlProdutos.FieldByName('qtDivergente').AsInteger;
        end;

      vlLotes.Close;
      vlLotes.Data := ListarLotes(pCodigoProduto, 0); // 0 = Todos os usuários

      if (vlLotes.Locate('cdLote', pCodigoLote, []) = True) then
        begin
          vlQtdDivergente := vlQtdDivergente + vlLotes.FieldByName('qtEntrada').AsInteger;

          case pAcao of
            taSomar: vlTotal := pQuantidade + vlLotes.FieldByName('qtEntrada').AsInteger;
          end;
        end;

      if (vlTotal > vlQtdDivergente) then
        begin
          raise Exception.Create('Quantidade do Lote inválida!' + sLineBreak +
                                 'A quantidade total dos Lotes está acima da quantidade do Produto.');
        end;
    finally
      FreeAndNil(vlProdutos);
      FreeAndNil(vlLotes);
    end;

    case pAcao of
      taSomar: vlTotal := pQuantidade;
    end;

    dmEntrada.qryConferirLote.Close;
    dmEntrada.qryConferirLote.Parameters.ParamByName('pCdEntrada').Value  := Self.Codigo;
    dmEntrada.qryConferirLote.Parameters.ParamByName('pCdLote').Value     := pCodigoLote;
    dmEntrada.qryConferirLote.Parameters.ParamByName('pCdUsuario').Value  := pCodigoUsuario;
    dmEntrada.qryConferirLote.Parameters.ParamByName('pQtEntrada').Value  := vlTotal;
    dmEntrada.qryConferirLote.Parameters.ParamByName('pAcao').Value       := Ord(pAcao);
    dmEntrada.qryConferirLote.ExecSQL;

    dmEntrada.qryAtualizarQuantidades.Close;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
    dmEntrada.qryAtualizarQuantidades.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryConferirLote.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryConferirLote.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.ConferirLoteAbaixoValidadeMinima(pCodigoLote, pCodigoUsuario: Integer;
  pDataVencimento, pDataValidadeMinima: TDateTime);
begin
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.Close;
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.Parameters.ParamByName('pCdEntrada').Value        := Self.Codigo;
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.Parameters.ParamByName('pCdLote').Value           := pCodigoLote;
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.Parameters.ParamByName('pCdUsuario').Value        := pCodigoUsuario;
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.Parameters.ParamByName('pDtVencimento').Value     := FormatDateTime('yyyy-mm-dd', pDataVencimento);
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.Parameters.ParamByName('pDtValidadeMinima').Value := FormatDateTime('yyyy-mm-dd', pDataValidadeMinima);
  dmEntrada.qryConferirLoteAbaixoValidadeMinima.ExecSQL;
end;

procedure TEntrada.ConferirSegregado(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario,
  pCodigoMotivo, pQuantidade: Integer; pAcao: TTipoAcao);
var
  vlProdutos: TClientDataSet;
  vlSegregados: TClientDataSet;
  vlTransacaoInterna: Boolean;
  vlQtdDivergente: Integer;
  VlTotal        : Integer;
begin
  if (pQuantidade <= 0) then
    begin
      raise Exception.Create('Quantidade do Lote inválida!' + sLineBreak +
                             'A quantidade do lote deve ser maior do que zero.');
    end;

  vlProdutos   := TClientDataSet.Create(nil);
  vlSegregados := TClientDataSet.Create(nil);

  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmEntrada.qryConferirSegregado.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmEntrada.qryConferirSegregado.Connection.Execute('SET NOCOUNT ON;');
        dmEntrada.qryConferirSegregado.Connection.BeginTrans;
      end;

    try
      vlProdutos.Close;
      vlProdutos.Data := ListarProdutos;

      if (vlProdutos.Locate('cdProduto', pCodigoProduto, []) = False) then
        begin
          raise Exception.Create('Produto inválido!' + #13 +
                                 'O produto selecionado foi removido desta Entrada.');
        end
      else
        begin
          vlQtdDivergente := vlProdutos.FieldByName('qtDivergente').AsInteger;
        end;

      vlSegregados.Close;

      case pAcao of

        taSomar:      Begin
          vlSegregados.Data := ListarSegregados(pCodigoProduto, pCodigoUsuario);
          VlTotal := pQuantidade +  VlSegregados.FieldByName('QtSegregada').AsInteger; //GSS em 11-08-2016
        End;
        taSubstituir: vlSegregados.Data := ListarSegregados(pCodigoProduto, 0); // 0 = Todos os usuários


      end;

      if (vlSegregados.Locate('cdLote;cdSegregadoMotivo', VarArrayOf([pCodigoLote, pCodigoMotivo]), []) = True) then
        begin
          vlQtdDivergente := vlQtdDivergente + vlSegregados.FieldByName('qtSegregada').AsInteger;
        end;

      if (pQuantidade > vlQtdDivergente) then
        begin
          raise Exception.Create('Quantidade do Lote inválida!' + #13 +
                                 'A quantidade total dos Lotes está acima da quantidade do Produto.');
        end;
    finally
      FreeAndNil(vlProdutos);
      FreeAndNil(vlSegregados);
    end;

    dmEntrada.qryConferirSegregado.Close;
    dmEntrada.qryConferirSegregado.Parameters.ParamByName('pCdEntrada').Value         := Self.Codigo;
    dmEntrada.qryConferirSegregado.Parameters.ParamByName('pCdLote').Value            := pCodigoLote;
    dmEntrada.qryConferirSegregado.Parameters.ParamByName('pCdUsuario').Value         := pCodigoUsuario;
    dmEntrada.qryConferirSegregado.Parameters.ParamByName('pCdSegregadoMotivo').Value := pCodigoMotivo;
    dmEntrada.qryConferirSegregado.Parameters.ParamByName('pQtSegregada').Value       := pQuantidade;  // VlTotal; //GSS em 11-08-2016
    dmEntrada.qryConferirSegregado.Parameters.ParamByName('pAcao').Value              := Ord(pAcao);
    dmEntrada.qryConferirSegregado.ExecSQL;

    dmEntrada.qryAtualizarQuantidades.Close;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
    dmEntrada.qryAtualizarQuantidades.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryConferirSegregado.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryConferirSegregado.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

destructor TEntrada.Destroy;
begin
  FreeAndNil(Self.FFornecedor);
  FreeAndNil(Self.FTipo);
  FreeAndNil(Self.FStatus);
  FreeAndNil(Self.FImpressao);
  FreeAndNil(Self.FMotivoSegregado);

  inherited;
end;

procedure TEntrada.Excluir(pHistorico: THistorico);
begin
  AtualizarStatus;

  if (Self.Status.Codigo <> 1) then // 1 = Pendente
  	begin
  		raise Exception.Create('Operação inválida!' + #13 +
                             'A Entrada selecionada não pode ser excluída.' + #13 + #13 +
                             'Status atual: ' + Self.Status.Nome);
  	end;

  dmEntrada.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
  dmEntrada.qryExcluir.Connection.BeginTrans;

  try
    dmEntrada.qryExcluir.Close;
    dmEntrada.qryExcluir.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := Self.Codigo;
    pHistorico.Observacao     := 'Exclusão da Entrada';

    pHistorico.Salvar;

    dmEntrada.qryExcluir.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmEntrada.qryExcluir.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.ExcluirDevolucao(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pCodigoMotivo: Integer);
var
  vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmEntrada.qryExcluirDevolucao.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmEntrada.qryExcluirDevolucao.Connection.Execute('SET NOCOUNT ON;');
        dmEntrada.qryExcluirDevolucao.Connection.BeginTrans;
      end;

    dmEntrada.qryExcluirDevolucao.Close;
    dmEntrada.qryExcluirDevolucao.Parameters.ParamByName('pCdEntrada').Value         := Self.Codigo;
    dmEntrada.qryExcluirDevolucao.Parameters.ParamByName('pCdLote').Value            := pCodigoLote;
    dmEntrada.qryExcluirDevolucao.Parameters.ParamByName('pCdUsuario').Value         := pCodigoUsuario;
    dmEntrada.qryExcluirDevolucao.Parameters.ParamByName('pCdDevolucaoMotivo').Value := pCodigoMotivo;
    dmEntrada.qryExcluirDevolucao.ExecSQL;

    dmEntrada.qryAtualizarQuantidades.Close;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
    dmEntrada.qryAtualizarQuantidades.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryExcluirDevolucao.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryExcluirDevolucao.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.ExcluirLote(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario: Integer);
var
  vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmEntrada.qryExcluirLote.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmEntrada.qryExcluirLote.Connection.Execute('SET NOCOUNT ON;');
        dmEntrada.qryExcluirLote.Connection.BeginTrans;
      end;

    dmEntrada.qryExcluirLote.Close;
    dmEntrada.qryExcluirLote.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryExcluirLote.Parameters.ParamByName('pCdLote').Value    := pCodigoLote;
    dmEntrada.qryExcluirLote.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
    dmEntrada.qryExcluirLote.ExecSQL;

    dmEntrada.qryAtualizarQuantidades.Close;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
    dmEntrada.qryAtualizarQuantidades.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryExcluirLote.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryExcluirLote.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.ExcluirSegregado(pCodigoProduto: Int64; pCodigoLote, pCodigoUsuario, pCodigoMotivo: Integer);
var
  vlCodigoMotivo: string;
  vlTransacaoInterna: Boolean;
begin
  if (pCodigoMotivo = 0) then
    begin
      vlCodigoMotivo := '%';
    end
  else
    begin
      vlCodigoMotivo := IntToStr(pCodigoMotivo);
    end;

  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmEntrada.qryExcluirSegregado.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmEntrada.qryExcluirSegregado.Connection.Execute('SET NOCOUNT ON;');
        dmEntrada.qryExcluirSegregado.Connection.BeginTrans;
      end;

    dmEntrada.qryExcluirSegregado.Close;
    dmEntrada.qryExcluirSegregado.Parameters.ParamByName('pCdEntrada').Value         := Self.Codigo;
    dmEntrada.qryExcluirSegregado.Parameters.ParamByName('pCdLote').Value            := pCodigoLote;
    dmEntrada.qryExcluirSegregado.Parameters.ParamByName('pCdUsuario').Value         := pCodigoUsuario;
    dmEntrada.qryExcluirSegregado.Parameters.ParamByName('pCdSegregadoMotivo').Value := vlCodigoMotivo;
    dmEntrada.qryExcluirSegregado.ExecSQL;

    dmEntrada.qryAtualizarQuantidades.Close;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryAtualizarQuantidades.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
    dmEntrada.qryAtualizarQuantidades.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryExcluirSegregado.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryExcluirSegregado.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

function TEntrada.getFornecedor: TFornecedor;
begin
  if (Assigned(Self.FFornecedor) = False) and (Self.FCodigoFornecedor >= 0) then
    begin
      setFornecedor(TFornecedor.PegarFornecedor(Self.FCodigoFornecedor));
    end;

  Result := Self.FFornecedor;
end;

function TEntrada.getTipo: TEntradaTipo;
begin
  if (Assigned(Self.FTipo) = False) and (Self.FCodigoTipo > 0) then
    begin
      setTipo(TEntradaTipo.PegarTipo(Self.FCodigoTipo));
    end;

  Result := Self.FTipo;
end;

procedure TEntrada.LimparConferencia;
var
  vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;

  if (dmEntrada.qryLimparConferencia.Connection.InTransaction = False) then
    begin
      vlTransacaoInterna := True;

      dmEntrada.qryLimparConferencia.Connection.Execute('SET NOCOUNT ON;');
      dmEntrada.qryLimparConferencia.Connection.BeginTrans;
    end;

  try
    dmEntrada.qryLimparConferencia.Close;
    dmEntrada.qryLimparConferencia.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
    dmEntrada.qryLimparConferencia.ExecSQL;

    if (vlTransacaoInterna = True) then
      begin
        dmEntrada.qryLimparConferencia.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmEntrada.qryLimparConferencia.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.LimparLotesValidadeMinima;
begin
  dmEntrada.qryLimparLotesValidadeMinima.Close;
  dmEntrada.qryLimparLotesValidadeMinima.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryLimparLotesValidadeMinima.ExecSQL;
end;

function TEntrada.ListarDevolvidos(pCodigoProduto: Int64; pCodigoUsuario: Integer): OleVariant;
begin
  dmEntrada.qryListarDevolvidos.Close;
  dmEntrada.qryListarDevolvidos.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryListarDevolvidos.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmEntrada.qryListarDevolvidos.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
  dmEntrada.qryListarDevolvidos.Open;

  Result := dmEntrada.dspListarDevolvidos.Data;
end;

function TEntrada.ListarLotes(pCodigoProduto: Int64; pCodigoUsuario: Integer): OleVariant;
begin
  dmEntrada.qryListarLotes.Close;
  dmEntrada.qryListarLotes.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryListarLotes.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmEntrada.qryListarLotes.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
  dmEntrada.qryListarLotes.Open;

  Result := dmEntrada.dspListarLotes.Data;
end;

function TEntrada.ListarProdutos: OleVariant;
begin
  dmEntrada.qryListarProdutos.Close;
  dmEntrada.qryListarProdutos.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryListarProdutos.Open;

  Result := dmEntrada.dspListarProdutos.Data;
end;

function TEntrada.ListarSegregados(pCodigoProduto: Int64; pCodigoUsuario: Integer): OleVariant;
begin
  dmEntrada.qryListarSegregados.Close;
  dmEntrada.qryListarSegregados.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryListarSegregados.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmEntrada.qryListarSegregados.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
  dmEntrada.qryListarSegregados.Open;

  Result := dmEntrada.dspListarSegregados.Data;
end;

function TEntrada.ListarUsuarios(pTipoLista: TTipoLista; pCodigoProduto: Int64): OleVariant;
begin
  case pTipoLista of
    tlEntrada: // Listar os Lotes da Entrada
      begin
        dmEntrada.qryListarUsuariosLote.Close;
        dmEntrada.qryListarUsuariosLote.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
        dmEntrada.qryListarUsuariosLote.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
        dmEntrada.qryListarUsuariosLote.Open;

        Result := dmEntrada.dspListarUsuariosLote.Data;
      end;

    tlSegregados: // Listar os Lotes Segregados
      begin
        dmEntrada.qryListarUsuariosSegregado.Close;
        dmEntrada.qryListarUsuariosSegregado.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
        dmEntrada.qryListarUsuariosSegregado.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
        dmEntrada.qryListarUsuariosSegregado.Open;

        Result := dmEntrada.dspListarUsuariosSegregado.Data;
      end;

    tlDevolvidos: // Listar os Lotes Devolvidos
      begin
        dmEntrada.qryListarUsuariosDevolucao.Close;
        dmEntrada.qryListarUsuariosDevolucao.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
        dmEntrada.qryListarUsuariosDevolucao.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
        dmEntrada.qryListarUsuariosDevolucao.Open;

        Result := dmEntrada.dspListarUsuariosDevolucao.Data;
      end;
  end;
end;

function TEntrada.LocalizarLote(pProduto: TProduto; pCodigoUsuario: Integer; pLote, pDataVencimento: string): TLote;
var
  vlLote: TLote;
  vlLotes: TClientDataSet;
begin
  Result  := nil;
  vlLotes := TClientDataSet.Create(nil);

  try
    vlLotes.Close;
    vlLotes.Data := ListarLotes(pProduto.Codigo, 0); // 0 = Todos os usuários

    case pProduto.Controle.Codigo of
      2, 3: // Controle por Vencimento (2) ou por Entrada (3)
        begin
          pLote := FormatDateTime('yymmdd', StrToDate(pDataVencimento));
        end;
    end;

    if (vlLotes.Locate('nmLote', pLote, []) = True) then
      begin
        vlLote                := TLote.Create;
        vlLote.Codigo         := vlLotes.FieldByName('cdLote').AsInteger;
        vlLote.Lote           := vlLotes.FieldByName('nmLote').AsString;
        vlLote.LoteAntigo     := vlLote.Lote;
        vlLote.DataFabricacao := vlLotes.FieldByName('dtFabricacao').AsDateTime;
        vlLote.DataVencimento := vlLotes.FieldByName('dtVencimento').AsDateTime;
        vlLote.Produto        := TProduto.PegarProduto(IntToStr(pProduto.Codigo));
      end
    else
      begin
        case pProduto.Controle.Codigo of
          1, 2: // Controle por Lote (1) ou por Vencimento (2)
            begin
              raise Exception.Create('Lote inválido!' + #13 +
                                     'O Lote informado não faz parte desta Entrada ou foi removido.');
            end;

          3: // Controle por Entrada (3)
            begin
              vlLote                := TLote.Create;
              vlLote.Codigo         := 0;
              vlLote.DataFabricacao := Now;
              vlLote.DataVencimento := IncYear(Now, 10);
              vlLote.Lote           := FormatDateTime('yymmdd', vlLote.DataVencimento);
              vlLote.LoteAntigo     := vlLote.Lote;
              vlLote.Produto        := TProduto.PegarProduto(IntToStr(pProduto.Codigo));

              vlLote.Salvar;

              ConferirLote(pProduto.Codigo, vlLote.Codigo, pCodigoUsuario, 0, taSomar);
            end;
        end;
      end;

    Result := vlLote;
  finally
    FreeAndNil(vlLotes);
  end;
end;

class function TEntrada.PegarEntrada(pCodigo: string): TEntrada;
var
  vlCodigo: Integer;
  vlEntrada: TEntrada;
  vlStatus: TEntradaStatus;
  vlImpressao: TImpressaoStatus;
  vlMotivo: TSegregadoMotivo;
begin
  try
    vlCodigo := StrToInt(pCodigo);
  except
    raise Exception.Create('Código da Entrada inválido!');
  end;

  dmEntrada.qryPegar.Close;
  dmEntrada.qryPegar.Parameters.ParamByName('pCdEntrada').Value := vlCodigo;
  dmEntrada.qryPegar.Open;

  if (dmEntrada.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Entrada não encontrada!');
    end;

  /////////// Crição do Objeto Status ////////////
  vlStatus        := TEntradaStatus.Create;
  vlStatus.Codigo := dmEntrada.qryPegar.FieldByName('cdEntradaStatus').AsInteger;
  vlStatus.Nome   := dmEntrada.qryPegar.FieldByName('nmEntradaStatus').AsString;
  ////////////////////////////////////////////////

  /////////// Crição do Objeto Impressão ////////////
  vlImpressao        := TImpressaoStatus.Create;
  vlImpressao.Codigo := dmEntrada.qryPegar.FieldByName('cdImpressaoStatus').AsInteger;
  vlImpressao.Nome   := dmEntrada.qryPegar.FieldByName('nmImpressaoStatus').AsString;
  ///////////////////////////////////////////////////

  /////////// Crição do Objeto Motivo do Segregado ////////////
  vlMotivo := nil;

  if (dmEntrada.qryPegar.FieldByName('cdSegregadoMotivo').AsInteger <> 0) then
    begin
      vlMotivo        := TSegregadoMotivo.Create;
      vlMotivo.Codigo := dmEntrada.qryPegar.FieldByName('cdSegregadoMotivo').AsInteger;
      vlMotivo.Nome   := dmEntrada.qryPegar.FieldByName('nmSegregadoMotivo').AsString;
    end;
  /////////////////////////////////////////////////////////////

  vlEntrada                 := TEntrada.Create;
  vlEntrada.Codigo          := dmEntrada.qryPegar.FieldByName('cdEntrada').AsInteger;
  vlEntrada.Data            := dmEntrada.qryPegar.FieldByName('dtEntrada').AsDateTime;
  vlEntrada.NotaFiscal      := dmEntrada.qryPegar.FieldByName('nrNotaFiscal').AsString;
  vlEntrada.DataNotaFiscal  := dmEntrada.qryPegar.FieldByName('dtNotaFiscal').AsDateTime;
  vlEntrada.DataConferencia := dmEntrada.qryPegar.FieldByName('dtConferencia').AsDateTime;
  vlEntrada.Status          := vlStatus;
  vlEntrada.Impressao       := vlImpressao;

  if (Assigned(vlMotivo) = True) then
    begin
      vlEntrada.MotivoSegregado := vlMotivo;
    end;

  vlEntrada.FCodigoTipo       := dmEntrada.qryPegar.FieldByName('cdEntradaTipo').AsInteger;
  vlEntrada.FCodigoFornecedor := dmEntrada.qryPegar.FieldByName('cdFornecedor').AsInteger;

  Result := vlEntrada;
end;

class function TEntrada.Pesquisar(pCodigo, pDataEntrada, pNotaFiscal, pDataNotaFiscal, pCodigoFornecedor,
  pFornecedor, pCodigoEntradaTipo, pCodigoEntradaStatus, pCodigoImpressaoStatus, pCodigoProduto: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end
  else
    begin
      pDataNotaFiscal  := '';
      pDataEntrada     := '';
    end;

  if (Trim(pNotaFiscal) = '') then
    begin
      pNotaFiscal := '%';
    end
  else
    begin
      pDataNotaFiscal  := '';
      pDataEntrada     := '';
    end;

  if (Trim(pCodigoFornecedor) = '') then
  	begin
      pCodigoFornecedor := '%';
  	end;

  if (Trim(pFornecedor) = '') then
    begin
      pFornecedor := '%';
    end;

  if (Trim(pCodigoEntradaTipo) = '') then
  	begin
  		pCodigoEntradaTipo := '%';
  	end;

  if (Trim(pCodigoEntradaStatus) = '') then
  	begin
  		pCodigoEntradaStatus := '%';
  	end;

  if (Trim(pCodigoImpressaoStatus) = '') then
  	begin
      pCodigoImpressaoStatus := '%';
  	end;

  if (Trim(pCodigoProduto) = '') then
    begin
      pCodigoProduto := '%';
    end;

  if (Trim(pDataEntrada) = '') then
    begin
      pDataEntrada := '%';
    end
  else
    begin
      try
        pDataEntrada := FormatDateTime('yyyy-mm-dd', StrToDate(pDataEntrada));
      except
        raise Exception.Create('Data da Entrada inválida!');
      end;
    end;

  if (Trim(pDataNotaFiscal) = '') then
    begin
      pDataNotaFiscal := '%';
    end
  else
    begin
      try
        pDataNotaFiscal := FormatDateTime('yyyy-mm-dd', StrToDate(pDataNotaFiscal));
      except
        raise Exception.Create('Data da Nota Fiscal inválida!');
      end;
    end;

  dmEntrada.qryPesquisar.Close;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pCdEntrada').Value         := pCodigo;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pDtEntrada').Value         := pDataEntrada;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pNrNotaFiscal').Value      := '%' + pNotaFiscal;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pDtNotaFiscal').Value      := pDataNotaFiscal;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pCdFornecedor').Value      := pCodigoFornecedor;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pNmFornecedor').Value      := '%' + pFornecedor + '%';
  dmEntrada.qryPesquisar.Parameters.ParamByName('pCdEntradaTipo').Value     := pCodigoEntradaTipo;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pCdEntradaStatus').Value   := pCodigoEntradaStatus;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pCdImpressaoStatus').Value := pCodigoImpressaoStatus;
  dmEntrada.qryPesquisar.Parameters.ParamByName('pCdProduto').Value         := pCodigoProduto;
  dmEntrada.qryPesquisar.Prepared := True;
  dmEntrada.qryPesquisar.Open;

  Result := dmEntrada.dspPesquisar.Data;
end;

function TEntrada.PlanilhaCegaEANs: OleVariant;
begin
  dmEntrada.qryPlanilhaCegaEANs.Close;
  dmEntrada.qryPlanilhaCegaEANs.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryPlanilhaCegaEANs.Open;

  Result := dmEntrada.dspPlanilhaCegaEANs.Data;
end;

function TEntrada.PlanilhaCegaLotes: OleVariant;
begin
  dmEntrada.qryPlanilhaCegaLotes.Close;
  dmEntrada.qryPlanilhaCegaLotes.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryPlanilhaCegaLotes.Open;

  Result := dmEntrada.dspPlanilhaCegaLotes.Data;
end;

function TEntrada.PlanilhaCegaProdutos: OleVariant;
begin
  dmEntrada.qryPlanilhaCegaProdutos.Close;
  dmEntrada.qryPlanilhaCegaProdutos.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryPlanilhaCegaProdutos.Open;

  Result := dmEntrada.dspPlanilhaCegaProdutos.Data;
end;

class function TEntrada.RelatorioEficiencia(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmEntrada.qryRelatorioEficiencia.Close;
  dmEntrada.qryRelatorioEficiencia.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmEntrada.qryRelatorioEficiencia.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmEntrada.qryRelatorioEficiencia.Open;

  Result := dmEntrada.dspRelatorioEficiencia.Data;
end;

class function TEntrada.GraficosEficiencia(pDataInicial, pDataFinal: string; Tipo : Integer): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmEntrada.QryGrafEficienciaNotas.Close;
  dmEntrada.QryGrafEficienciaNotas.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd', vlDataInicial);
  dmEntrada.QryGrafEficienciaNotas.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd', vlDataFinal);
  dmEntrada.QryGrafEficienciaNotas.Parameters.ParamByName('pTipo').Value        := Tipo;
  dmEntrada.QryGrafEficienciaNotas.Open;

  Result := dmEntrada.DspGrafEficienciaNotas.Data;
end;

class function TEntrada.RelatorioEficienciaDiario(pMes, pAno : Integer; pTipo : Integer): OleVariant;
var
  vlDataInicial: TDateTime;
begin
  try
    vlDataInicial := EncodeDate(pAno, pMes, 1);
  except
    raise Exception.Create('Operação inválida!' + #13 +
                           'O Mês e o Ano informados não formam uma data válida.');
  end;
  if pTipo >= 0 then Begin
     dmEntrada.QryGrafEficienciaDiaria.Close;
     dmEntrada.QryGrafEficienciaDiaria.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
//     dmEntrada.QryGrafEficienciaDiaria.Parameters.ParamByName('pTipo').Value        := pTipo;
     dmEntrada.QryGrafEficienciaDiaria.Open;
     Result := dmEntrada.DspGrafEficienciaDiaria.Data;
  End
  Else Begin
     dmEntrada.qryRelatorioEficienciaDiario.Close;
     dmEntrada.qryRelatorioEficienciaDiario.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
     dmEntrada.qryRelatorioEficienciaDiario.Open;

     Result := dmEntrada.dspRelatorioEficienciaDiario.Data;
  End;
end;

class function TEntrada.RelatorioProducao(vData : tDateTime): OleVariant;
Var vlTransacaoInterna : Boolean;
begin
  if (dmEntrada.qryRelatorioProducao.Connection.InTransaction = False) then Begin
     vlTransacaoInterna := True;
     dmEntrada.qryRelatorioProducao.Connection.Execute('SET NOCOUNT ON;');
     dmEntrada.qryRelatorioProducao.Connection.BeginTrans;
  end;
  Try
    dmEntrada.qryRelatorioProducao.Close;
    dmEntrada.qryRelatorioProducao.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vData);
    dmEntrada.qryRelatorioProducao.Open;
    Result := dmEntrada.dspRelatorioProducao.Data;
    if (vlTransacaoInterna = True) then
        dmEntrada.qryRelatorioProducao.Connection.CommitTrans;
  except on e: Exception do begin
      if (vlTransacaoInterna = True) then dmEntrada.qryRelatorioProducao.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

class function TEntrada.RelatorioProducaoExcl(vData : tDateTime): OleVariant;
Var vlTransacaoInterna : Boolean;
begin
  if (dmEntrada.qryRelatorioProducaoExcl.Connection.InTransaction = False) then Begin
     vlTransacaoInterna := True;
     dmEntrada.qryRelatorioProducaoExcl.Connection.Execute('SET NOCOUNT ON;');
     dmEntrada.qryRelatorioProducaoExcl.Connection.BeginTrans;
  end;
  Try
    dmEntrada.qryRelatorioProducaoExcl.Close;
    dmEntrada.qryRelatorioProducaoExcl.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vData);
    dmEntrada.qryRelatorioProducaoExcl.Open;
    Result := dmEntrada.dspRelatorioProducaoExcl.Data;
    if (vlTransacaoInterna = True) then
        dmEntrada.qryRelatorioProducaoExcl.Connection.CommitTrans;
  except on e: Exception do begin
      if (vlTransacaoInterna = True) then dmEntrada.qryRelatorioProducaoExcl.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

class function TEntrada.RelatorioProducaoVolume(vData : tDateTime): OleVariant;
Var vlTransacaoInterna : Boolean;
begin
  if (dmEntrada.qryRelatorioProducaoVolume.Connection.InTransaction = False) then Begin
     vlTransacaoInterna := True;
     dmEntrada.qryRelatorioProducaoVolume.Connection.Execute('SET NOCOUNT ON;');
     dmEntrada.qryRelatorioProducaoVolume.Connection.BeginTrans;
  end;
  Try
    dmEntrada.qryRelatorioProducaoVolume.Close;
    dmEntrada.qryRelatorioProducaoVolume.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vData);
    dmEntrada.qryRelatorioProducaoVolume.Open;
    Result := dmEntrada.dspRelatorioProducaoVolume.Data;
    if (vlTransacaoInterna = True) then
        dmEntrada.qryRelatorioProducaoVolume.Connection.CommitTrans;
  except on e: Exception do begin
      if (vlTransacaoInterna = True) then dmEntrada.qryRelatorioProducaoVolume.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

class function TEntrada.RelatorioProducaoTempo(vData : tDateTime): OleVariant;
Var vlTransacaoInterna : Boolean;
begin
  if (dmEntrada.qryConferirDevolucao.Connection.InTransaction = False) then Begin
     vlTransacaoInterna := True;
     dmEntrada.qryRelatorioProducaoTempo.Connection.Execute('SET NOCOUNT ON;');
     dmEntrada.qryRelatorioProducaoTempo.Connection.BeginTrans;
  end;
  Try
    dmEntrada.qryRelatorioProducaoTempo.Close;
    dmEntrada.qryRelatorioProducaoTempo.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 23:59:59', vData);
    If DebugHook <> 0 then dmEntrada.qryRelatorioProducaoTempo.SQL.SaveToFile('TempoProducao.Txt');
    dmEntrada.qryRelatorioProducaoTempo.Open;
    Result := dmEntrada.dspRelatorioProducaoTempo.Data;
    if (vlTransacaoInterna = True) then
        dmEntrada.qryRelatorioProducaoTempo.Connection.CommitTrans;
  except on e: Exception do begin
      if (vlTransacaoInterna = True) then dmEntrada.qryRelatorioProducaoTempo.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

class function TEntrada.RelatorioEficienciaMensal(pAno: Integer; pTipo : Integer): OleVariant;
var
  vlDataInicial: TDateTime;
begin
  try
    vlDataInicial := EncodeDate(pAno, 1, 1);
  except
    raise Exception.Create('Operação inválida!' + #13 +
                           'O Ano informado não forma uma data válida.');
  end;
  if pTipo = 0 then Begin
     dmEntrada.qryRelatorioEficienciaMensal.Close;
     dmEntrada.qryRelatorioEficienciaMensal.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
     dmEntrada.qryRelatorioEficienciaMensal.Open;
     Result := dmEntrada.dspRelatorioEficienciaMensal.Data;
  End
  Else Begin
     dmEntrada.QryGraphEficienciaMensal.Close;
     dmEntrada.QryGraphEficienciaMensal.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
     dmEntrada.QryGraphEficienciaMensal.Parameters.ParamByName('pTipo').Value := pTipo;
     dmEntrada.QryGraphEficienciaMensal.Open;
     Result := dmEntrada.DspGraphEficienciaMensal.Data;
  End;
end;

class function TEntrada.RelatorioEntradaPorProduto(pCodigoProduto: Int64;
  pCodigoLote, pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  if pDataInicial = '  /  /    ' then pDataInicial := '01/01/1800';
  if pDataFinal   = '  /  /    ' then pDataFinal   := '31/12/3000';
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;
  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;
  if (pCodigoLote = '') then
    begin
      pCodigoLote := '%';
    end;
  dmEntrada.qryRelatorioEntradaPorProduto.Close;
  if pCodigoProduto = 0 then
    dmEntrada.qryRelatorioEntradaPorProduto.Parameters.ParamByName('pCdProduto').Value   := '%'
  Else
     dmEntrada.qryRelatorioEntradaPorProduto.Parameters.ParamByName('pCdProduto').Value   := pCodigoProduto;
  dmEntrada.qryRelatorioEntradaPorProduto.Parameters.ParamByName('pCdLote').Value      := pCodigoLote;
  dmEntrada.qryRelatorioEntradaPorProduto.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmEntrada.qryRelatorioEntradaPorProduto.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmEntrada.qryRelatorioEntradaPorProduto.Open;
  Result := dmEntrada.dspRelatorioEntradaPorProduto.Data;
end;

class function TEntrada.RelatorioLotesDivergentes(pCodigo, pDataEntrada,
  pNotaFiscal, pDataNotaFiscal, pCodigoEntradaTipo, pCodigoFornecedor,
  pCodigoProduto: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end
  else
    begin
      pDataNotaFiscal  := '';
      pDataEntrada     := '';
    end;

  if (Trim(pNotaFiscal) = '') then
    begin
      pNotaFiscal := '%';
    end
  else
    begin
      pDataNotaFiscal  := '';
      pDataEntrada     := '';
    end;

  if (Trim(pCodigoEntradaTipo) = '') then
  	begin
  		pCodigoEntradaTipo := '%';
  	end;

  if (Trim(pCodigoFornecedor) = '') then
  	begin
      pCodigoFornecedor := '%';
  	end;

  if (Trim(pCodigoProduto) = '') then
    begin
      pCodigoProduto := '%';
    end;

  if (Trim(pDataEntrada) = '') then
    begin
      pDataEntrada := '%';
    end
  else
    begin
      try
        pDataEntrada := FormatDateTime('yyyy-mm-dd', StrToDate(pDataEntrada));
      except
        raise Exception.Create('Data da Entrada inválida!');
      end;
    end;

  if (Trim(pDataNotaFiscal) = '') then
    begin
      pDataNotaFiscal := '%';
    end
  else
    begin
      try
        pDataNotaFiscal := FormatDateTime('yyyy-mm-dd', StrToDate(pDataNotaFiscal));
      except
        raise Exception.Create('Data da Nota Fiscal inválida!');
      end;
    end;

  dmEntrada.qryRelatorioLotesDivergentes.Close;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pCdEntrada').Value     := pCodigo;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pDtEntrada').Value     := pDataEntrada;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pNrNotaFiscal').Value  := '%' + pNotaFiscal;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pDtNotaFiscal').Value  := pDataNotaFiscal;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pCdEntradaTipo').Value := pCodigoEntradaTipo;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pCdFornecedor').Value  := pCodigoFornecedor;
  dmEntrada.qryRelatorioLotesDivergentes.Parameters.ParamByName('pCdProduto').Value     := pCodigoProduto;
  dmEntrada.qryRelatorioLotesDivergentes.Open;

  Result := dmEntrada.dspRelatorioLotesDivergentes.Data;
end;

class function TEntrada.RelatorioLotesDivergentesLotes(pCodigoEntrada: Integer): OleVariant;
begin
  dmEntrada.qryRelatorioLotesDivergentesLotes.Close;
  dmEntrada.qryRelatorioLotesDivergentesLotes.Parameters.ParamByName('pCdEntrada').Value := pCodigoEntrada;
  dmEntrada.qryRelatorioLotesDivergentesLotes.Open;

  Result := dmEntrada.dspRelatorioLotesDivergentesLotes.Data;
end;

class function TEntrada.RelatorioLotesDivergentesProdutos(pCodigoEntrada: Integer): OleVariant;
begin
  dmEntrada.qryRelatorioLotesDivergentesProdutos.Close;
  dmEntrada.qryRelatorioLotesDivergentesProdutos.Parameters.ParamByName('pCdEntrada').Value := pCodigoEntrada;
  dmEntrada.qryRelatorioLotesDivergentesProdutos.Open;

  Result := dmEntrada.dspRelatorioLotesDivergentesProdutos.Data;
end;

class function TEntrada.RelatorioProdutividadeGeral(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmEntrada.qryRelatorioProdutividadeGeral.Close;
  dmEntrada.qryRelatorioProdutividadeGeral.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmEntrada.qryRelatorioProdutividadeGeral.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmEntrada.qryRelatorioProdutividadeGeral.Open;

  Result := dmEntrada.dspRelatorioProdutividadeGeral.Data;
end;

class function TEntrada.RelatorioProdutividadeIndividual(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmEntrada.qryRelatorioProdutividadeIndividual.Close;
  dmEntrada.qryRelatorioProdutividadeIndividual.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmEntrada.qryRelatorioProdutividadeIndividual.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmEntrada.qryRelatorioProdutividadeIndividual.Open;

  Result := dmEntrada.dspRelatorioProdutividadeIndividual.Data;
end;

class function TEntrada.RelatorioProdutividadeIndividualDiario(pMes, pAno, pCodigoUsuario: Integer): OleVariant;
var
  vlDataInicial: TDateTime;
begin
  try
    vlDataInicial := EncodeDate(pAno, pMes, 1);
  except
    raise Exception.Create('Operação inválida!' + #13 +
                           'O Mês e o Ano informados não formam uma data válida.');
  end;

  dmEntrada.qryRelatorioProdutividadeIndividualDiario.Close;
  dmEntrada.qryRelatorioProdutividadeIndividualDiario.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmEntrada.qryRelatorioProdutividadeIndividualDiario.Parameters.ParamByName('pCdUsuario').Value   := pCodigoUsuario;
  dmEntrada.qryRelatorioProdutividadeIndividualDiario.Open;

  Result := dmEntrada.dspRelatorioProdutividadeIndividualDiario.Data;
end;

class function TEntrada.RelatorioProdutividadeIndividualMensal(pAno, pCodigoUsuario: Integer): OleVariant;
var
  vlDataInicial: TDateTime;
begin
  try
    vlDataInicial := EncodeDate(pAno, 1, 1);
  except
    raise Exception.Create('Operação inválida!' + #13 +
                           'O Ano informado não forma uma data válida.');
  end;

  dmEntrada.qryRelatorioProdutividadeIndividualMensal.Close;
  dmEntrada.qryRelatorioProdutividadeIndividualMensal.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmEntrada.qryRelatorioProdutividadeIndividualMensal.Parameters.ParamByName('pCdUsuario').Value   := pCodigoUsuario;
  dmEntrada.qryRelatorioProdutividadeIndividualMensal.Open;

  Result := dmEntrada.dspRelatorioProdutividadeIndividualMensal.Data;
end;

class function TEntrada.RelatorioValidadeMinima(pCodEntrada, pDataInicial,pDataFinal, pCodTipo, pNotaFiscal,
  pCodFornecedor, pCodProduto: string): OleVariant;
begin
  if (Trim(pCodEntrada) = '') then
    begin
      pCodEntrada := '%';
    end
  else
    begin
      pDataInicial := '';
      pDataFinal   := '';
    end;

  if (Trim(pNotaFiscal) = '') then
    begin
      pNotaFiscal := '%';
    end
  else
    begin
      pDataInicial := '';
      pDataFinal   := '';
    end;

  ValidarParametroTexto(pCodTipo);
  ValidarParametroTexto(pCodFornecedor);
  ValidarParametroTexto(pCodProduto);

  if (Trim(pDataInicial) = '') then
    begin
      pDataInicial := '01/01/1900';
    end;

  try
    pDataInicial := FormatDateTime('yyyy-mm-dd 00:00:00', StrToDate(pDataInicial));
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  if (Trim(pDataFinal) = '') then
    begin
      pDataFinal := FormatDateTime('dd/mm/yyyy', IncYear(Now, 10));
    end;

  try
    pDataFinal := FormatDateTime('yyyy-mm-dd 23:59:59', StrToDate(pDataFinal));
  except
    raise Exception.Create('Data Final inválida!');
  end;

  dmEntrada.qryValidadeMinima.Close;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pCdEntrada').Value     := pCodEntrada;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pDataInicial').Value   := pDataInicial;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pDataFinal').Value     := pDataFinal;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pCdEntradaTipo').Value := pCodTipo;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pNrNotaFiscal').Value  := pNotaFiscal;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pCdFornecedor').Value  := pCodFornecedor;
  dmEntrada.qryValidadeMinima.Parameters.ParamByName('pCdProduto').Value     := pCodProduto;
  dmEntrada.qryValidadeMinima.Open;

  Result := dmEntrada.dspValidadeMinima.Data;
end;

procedure TEntrada.Salvar(pHistorico: THistorico);
var
  vlEntrada: TEntrada;
begin
  ValidarDados;

  try
    dmEntrada.qrySalvarEntrada.Connection.Execute('SET NOCOUNT ON;');
    dmEntrada.qrySalvarEntrada.Connection.BeginTrans;

    vlEntrada := PegarEntrada(IntToStr(Self.Codigo));

    if (vlEntrada.Status.Codigo <> 1) then
      begin
        raise Exception.Create('Operação cancelada!' + #13 +
                               'Esta Entrada já foi salva por outro usuário.');
      end;

    SalvarProdutos(pHistorico.CodigoUsuario);
    SalvarEntrada(pHistorico.CodigoUsuario);
    LimparLotesValidadeMinima;
    LimparConferencia;

    pHistorico.CodigoRegistro := Self.Codigo;
    pHistorico.Observacao     := 'Registro de Entrada';
    pHistorico.Salvar;

    dmEntrada.qrySalvarEntrada.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmEntrada.qrySalvarEntrada.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntrada.SalvarEntrada(pCodigoUsuario: Integer);
begin
  dmEntrada.qrySalvarEntrada.Close;
  dmEntrada.qrySalvarEntrada.Parameters.ParamByName('pCdEntrada').Value       := Self.Codigo;
  dmEntrada.qrySalvarEntrada.Parameters.ParamByName('pCdEntradaTipo').Value   := Self.Tipo.Codigo;
  dmEntrada.qrySalvarEntrada.Parameters.ParamByName('pCdEntradaStatus').Value := 2; // 2 = Conferido;

  if (Assigned(Self.FMotivoSegregado) = True) then
  	begin
      dmEntrada.qrySalvarEntrada.Parameters.ParamByName('pCdSegregadoMotivo').Value := Self.MotivoSegregado.Codigo;
  	end
  else
  	begin
  	  dmEntrada.qrySalvarEntrada.Parameters.ParamByName('pCdSegregadoMotivo').Value := 0;
  	end;

  dmEntrada.qrySalvarEntrada.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
  dmEntrada.qrySalvarEntrada.ExecSQL;
end;

procedure TEntrada.SalvarDevolucoes(pCodigoProduto: Int64; pCodigoUsuario: Integer);
var
  vlLotes: TClientDataSet;
  vlMovimentacao: TMovimentacao;
  vProduto  : TPRoduto;
//  vEndereco : TEndereco;
begin
  vlLotes := TClientDataSet.Create(nil);

  try
    vlLotes.Close;
    vlLotes.Data := ListarDevolvidos(pCodigoProduto, 0);

    vlLotes.First;
    while (vlLotes.Eof = False) do
      begin
        if (vlLotes.FieldByName('qtDevolvida').AsInteger > 0) then
          begin
            vlMovimentacao := TMovimentacao.Create;

            try
              vlMovimentacao.Codigo        := 0;
              vlMovimentacao.CodigoUsuario := pCodigoUsuario;
              vlMovimentacao.CodigoLote    := vlLotes.FieldByName('cdLote').AsInteger;;
              vlMovimentacao.CodigoMotivo  := vlLotes.FieldByName('cdDevolucaoMotivo').AsInteger;

              case Ord(Self.Tipo.Estoque) of
                1, 3: // Área de Espera (1) ou Segregado (3)
                  begin
                    vlMovimentacao.EstoqueOrigem := Espera; //.Codigo := 1;
                    vlMovimentacao.Origem               := 'Área de Espera';
                  end;

                2: // CrossDocking
                  begin
                    vlMovimentacao.EstoqueOrigem := CrossDocking; //.Codigo := 2;
                    vlMovimentacao.Origem               := 'Cross Docking';
                  end;
                6: //Picking
                  begin
                    vlMovimentacao.EstoqueOrigem := Picking; //.Codigo := 6;
                    vProduto  := tProduto.Create;
                    vProduto  := tProduto.PegarProduto(IntToStr(pCodigoProduto));
//                    vEndereco := vProduto.Endereco;
                    if (Assigned(vProduto.Endereco) = True) then
                       VlMovimentacao.CodigoEnderecoDestino := vProduto.Endereco.Codigo;   //vEndereco.Codigo;
                    vlMovimentacao.Origem               := 'Picking (Dev Loja) '+vProduto.Endereco.Endereco;
                    FreeAndNil(vProduto);
                  end;
              end;
              //Avaliar o Destino na nova estrutura
              vlMovimentacao.EstoqueDestino        := TipoUndefined; //.Codigo := 0;
              vlMovimentacao.Destino               := 'Devolução';
              vlMovimentacao.QtdMovimentada        := vlLotes.FieldByName('qtDevolvida').AsInteger;
              vlMovimentacao.OperacaoEstoque       := Saida; // 3 = Saída

              vlMovimentacao.Salvar;
            finally
              FreeAndNil(vlMovimentacao);
            end;
          end;

        vlLotes.Next;
      end;
  finally
    FreeAndNil(vlLotes);
  end;

  dmEntrada.qrySalvarDevolucao.Close;
  dmEntrada.qrySalvarDevolucao.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qrySalvarDevolucao.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmEntrada.qrySalvarDevolucao.ExecSQL;
end;

procedure TEntrada.SalvarLotes(pCodigoProduto: Int64; pCodigoUsuario: Integer);
var
  vlLotes: TClientDataSet;
  vlMovimentacao: TMovimentacao;
  vlQtdTotal: Integer;
  vProduto  : TPRoduto;
begin
  vlLotes := TClientDataSet.Create(nil);

  try
    vlLotes.Close;
    vlLotes.Data := ListarLotes(pCodigoProduto, 0); // 0 = Todos os usuários

    vlLotes.First;
    while (vlLotes.Eof = False) do
      begin
        vlQtdTotal := 0;
        vlQtdTotal := vlQtdTotal + vlLotes.FieldByName('qtEntrada').AsInteger;
        vlQtdTotal := vlQtdTotal + vlLotes.FieldByName('qtDevolvida').AsInteger;
        vlQtdTotal := vlQtdTotal + vlLotes.FieldByName('qtSegregada').AsInteger;

        if (vlQtdTotal > 0) then
          begin
            vlMovimentacao := TMovimentacao.Create;

            try
              vlMovimentacao.Codigo               := 0;
              vlMovimentacao.CodigoUsuario        := pCodigoUsuario;
              vlMovimentacao.CodigoLote           := vlLotes.FieldByName('cdLote').AsInteger;
              vlMovimentacao.EstoqueOrigem        := TipoUndefined; //.Codigo := 0;
              vlMovimentacao.Origem               := 'Entrada n.: ' + IntToStr(FCodigo);

              case Ord(Self.Tipo.Estoque) of
                1, 3: // Área de Espera (1) ou Segregado (3)
                  begin
                    vlMovimentacao.EstoqueDestino := Espera; //.Codigo := 1;
                    vlMovimentacao.Destino               := 'Área de Espera';
                  end;

                2: // CrossDocking
                  begin
                    vlMovimentacao.EstoqueDestino := CrossDocking; //.Codigo := 2;
                    vlMovimentacao.Destino               := 'Cross Docking';
                  end;

                6: //Picking - Devolução de Loja
                  Begin
                    VlMovimentacao.EstoqueDestino := Picking; //.Codigo := 6;
                    vProduto  := tProduto.Create;
                    vProduto  := tProduto.PegarProduto(IntToStr(pCodigoProduto));
                    if (Assigned(vProduto.Endereco) = True) then
                        VlMovimentacao.CodigoEnderecoDestino := vProduto.Endereco.Codigo;
                    VlMovimentacao.Destino               := 'Picking(Dev Loja) '+vProduto.Endereco.Endereco;
                  end;
              end;

              vlMovimentacao.QtdMovimentada  := vlQtdTotal;
              vlMovimentacao.OperacaoEstoque := Entrada; // 1 = Entrada

              vlMovimentacao.Salvar;
              if Assigned(vProduto) then FreeAndNil(vproduto);
            finally
              FreeAndNil(vlMovimentacao);
            end;
          end;

        vlLotes.Next;
      end;
  finally
    FreeAndNil(vlLotes);
  end;

  dmEntrada.qrySalvarLote.Close;
  dmEntrada.qrySalvarLote.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qrySalvarLote.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmEntrada.qrySalvarLote.ExecSQL;
end;

procedure TEntrada.SalvarProdutos(pCodigoUsuario: Integer);
var
  vlProdutos: TClientDataSet;
  vlLotes: TClientDataSet;
begin
  vlProdutos := TClientDataSet.Create(nil);

  try
    vlProdutos.Close;
    vlProdutos.Data := ListarProdutos;

    vlProdutos.First;
    while (vlProdutos.Eof = False) do
      begin
        if (Self.Tipo.TipoConferencia.Codigo = 3) then Begin// Se for Conferência Por Nota
            vlLotes := TClientDataSet.Create(nil);

            try
              vlLotes.Close;
              vlLotes.Data := ListarLotes(vlProdutos.FieldByName('cdProduto').AsLargeInt, 0); // 0 = Todos os usuários

              vlLotes.First;
              while (vlLotes.Eof = False) do
                begin
                  case Ord(Self.Tipo.Estoque) of
                    1, 2, 6: // Área de Espera (1) ou CrossDocking (2) ou Picking (6)
                      begin
                        ConferirLote(
                          vlProdutos.FieldByName('cdProduto').AsLargeInt
                          , vlLotes.FieldByName('cdLote').AsInteger
                          , pCodigoUsuario
                          , vlLotes.FieldByName('qtNotaFiscal').AsInteger
                          , taSubstituir
                        );
                      end;

                    3: // Segregado
                      begin
                        ConferirSegregado(
                          vlProdutos.FieldByName('cdProduto').AsLargeInt
                          , vlLotes.FieldByName('cdLote').AsInteger
                          , pCodigoUsuario
                          , Self.MotivoSegregado.Codigo
                          , vlLotes.FieldByName('qtNotaFiscal').AsInteger
                          , taSubstituir
                        );
                      end;
                  end;

                  vlLotes.Next;
                end;
            finally
              FreeAndNil(vlLotes);
            end;
        end;

        //// Manter comandos abaixo na sequência: Lotes, Segregados, Devoluções
        SalvarLotes(vlProdutos.FieldByName('cdProduto').AsLargeInt, pCodigoUsuario);
        SalvarSegregados(vlProdutos.FieldByName('cdProduto').AsLargeInt, pCodigoUsuario);
        SalvarDevolucoes(vlProdutos.FieldByName('cdProduto').AsLargeInt, pCodigoUsuario);
        /////////////////////////////////////////////////////////////////////////////////

        vlProdutos.Next;
      end;
  finally
    FreeAndNil(vlProdutos);
  end;
end;

procedure TEntrada.SalvarSegregados(pCodigoProduto: Int64; pCodigoUsuario: Integer);
var
  vlLotes: TClientDataSet;
  vlMovimentacao: TMovimentacao;
begin
  vlLotes := TClientDataSet.Create(nil);

  try
    vlLotes.Close;
    vlLotes.Data := ListarSegregados(pCodigoProduto, 0); // 0 = Todos os usuários

    vlLotes.First;
    while (vlLotes.Eof = False) do
      begin
        if (vlLotes.FieldByName('qtSegregada').AsInteger > 0) then
          begin
            vlMovimentacao := TMovimentacao.Create;

            try
              vlMovimentacao.Codigo        := 0;
              vlMovimentacao.CodigoUsuario := pCodigoUsuario;
              vlMovimentacao.CodigoLote    := vlLotes.FieldByName('cdLote').AsInteger;;
              vlMovimentacao.CodigoMotivo  := vlLotes.FieldByName('cdSegregadoMotivo').AsInteger;

              case Ord(Self.Tipo.Estoque) of
                1, 3: // Área de Espera ou Segregado
                  begin
                    vlMovimentacao.EstoqueOrigem := Espera; //.Codigo := 1;
                    vlMovimentacao.Origem               := 'Área de Espera';
                  end;

                2: // CrossDocking
                  begin
                    vlMovimentacao.EstoqueOrigem := CrossDocking; //.Codigo := 2;
                    vlMovimentacao.Origem               := 'Cross Docking';
                  end;

                6: //Picking - Devolução de Loja
                  Begin
                    VlMovimentacao.EstoqueOrigem := Picking; //.Codigo  := 6;
                    VlMovimentacao.Origem                := 'Picking';
//                    VlMovimentacao.CodigoEnderecoDestino := ;
                  End;
              end;

              vlMovimentacao.EstoqueDestino := Segregado; //.Codigo := 3;
              vlMovimentacao.Destino               := 'Segregado';
              vlMovimentacao.QtdMovimentada        := vlLotes.FieldByName('qtSegregada').AsInteger;
              vlMovimentacao.OperacaoEstoque       := Saida; // 3 = Saída

              vlMovimentacao.Salvar;
            finally
              FreeAndNil(vlMovimentacao);
            end;
          end;

        vlLotes.Next;
      end;
  finally
    FreeAndNil(vlLotes);
  end;

  dmEntrada.qrySalvarSegregado.Close;
  dmEntrada.qrySalvarSegregado.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qrySalvarSegregado.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmEntrada.qrySalvarSegregado.ExecSQL;
end;

procedure TEntrada.setFornecedor(pFornecedor: TFornecedor);
begin
  FreeAndNil(Self.FFornecedor);

  Self.FFornecedor := pFornecedor;

  if (Assigned(Self.FFornecedor) = True) then
    begin
      Self.FCodigoFornecedor := Self.FFornecedor.Codigo;
    end
  else
    begin
      Self.FCodigoFornecedor := 0;
    end;
end;

procedure TEntrada.setTipo(pTipoEntrada: TEntradaTipo);
begin
  FreeAndNil(Self.FTipo);

  Self.FTipo := pTipoEntrada;

  if (Assigned(Self.FTipo) = True) then
    begin
      Self.FCodigoTipo := Self.FTipo.Codigo;
    end
  else
    begin
      Self.FCodigoTipo := 0;
    end;
end;

procedure TEntrada.ValidarDados;
var
  vlProdutos : TClientDataSet;
  xCodigo    : tStringList;
  vQuery     : TClientDataSet;
begin
  if (Self.Tipo.TipoConferencia.Codigo <> 3) then // Se não for Conferência Por Nota
    begin
      vlProdutos := TClientDataSet.Create(nil);

      try
        vlProdutos.Close;
        vlProdutos.Data := ListarProdutos;

        vlProdutos.Filter   := '(qtDivergente <> 0)';
        vlProdutos.Filtered := True;

        if (vlProdutos.IsEmpty = False) then
          begin
            raise Exception.Create('Produtos com Divergência!' + #13 +
                                   'Confira todos os produtos antes de confirmar a entrada');
          end;
      finally
        FreeAndNil(vlProdutos);
      end;
    end;
  if Self.Tipo.Estoque = Picking then Begin //.Codigo = 6
     xCodigo := tStringList.Create;
     xCodigo.Add('Select EntP.*, Prd.CdEndereco From tbEntradaProduto EntP with (NoLock)');
     xCodigo.Add('Inner Join TbProduto Prd On Prd.CdProduto = EntP.CdProduto and CdEndereco Is Null');
     xCodigo.Add('where CdEntrada = '+IntToStr(Self.Codigo));
     vQuery := TClientDataSet.Create(Nil);
     vQuery.Data := DmCadastroGeral.OpenSearch(xCodigo);
     if Not vQuery.IsEmpty then
        raise Exception.Create('Produtos sem Endereço de Picking.');
     FreeAndNil(xCodigo);
     FreeAndNil(vQuery);
  End;
end;

procedure TEntrada.VerificarValidades(pCodigoUsuario: Integer);
begin
  dmEntrada.qryVerificarValidades.Close;
  dmEntrada.qryVerificarValidades.Parameters.ParamByName('pCdEntrada').Value := Self.Codigo;
  dmEntrada.qryVerificarValidades.Open;

  if (dmEntrada.qryVerificarValidades.IsEmpty = False) then
    begin
      if (Application.MessageBox('Existem Lotes com Data de Vencimento abaixo da Validade Mínima!' + #13 +
                                 'O sistema irá REMOVER esses Lotes para nova conferência.' + #13 + #13 +
                                 'Deseja continuar?', 'Confirmação', MB_ICONWARNING + MB_YESNO) = mrNo) then
        begin
          Abort;
        end
      else
        begin
          dmEntrada.qryVerificarValidades.First;
          while (dmEntrada.qryVerificarValidades.Eof = False) do
            begin
              ConferirLote(
                dmEntrada.qryVerificarValidades.FieldByName('cdProduto').AsLargeInt
                , dmEntrada.qryVerificarValidades.FieldByName('cdLote').AsInteger
                , pCodigoUsuario
                , 0
                , taSubstituir
              );

              dmEntrada.qryVerificarValidades.Next;
            end;
        end;
    end;
end;

class function TEntradaStatus.ListarStatus: OleVariant;
begin
  dmEntrada.qryListarEntStatus.Close;
  dmEntrada.qryListarEntStatus.Open;

  Result := dmEntrada.dspListarEntStatus.Data;
end;

constructor TEntradaTipo.Create;
begin
  Self.FEstoque := TipoUndefined;
end;

destructor TEntradaTipo.Destroy;
begin
  FreeAndNil(Self.FEstoque);
  FreeAndNil(Self.FTipoConferencia);

  inherited;
end;

class procedure TEntradaTipo.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmEntrada.qryExcluirEntTipo.Connection.Execute('SET NOCOUNT ON;');
    dmEntrada.qryExcluirEntTipo.Connection.BeginTrans;

    dmEntrada.qryExcluirEntTipo.Close;
    dmEntrada.qryExcluirEntTipo.Parameters.ParamByName('pCdEntradaTipo').Value := pCodigo;
    dmEntrada.qryExcluirEntTipo.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Tipo de Entrada';

    pHistorico.Salvar;

    dmEntrada.qryExcluirEntTipo.Connection.CommitTrans;
  except
    dmEntrada.qryExcluirEntTipo.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste Tipo de Entrada.');
  end;
end;

class function TEntradaTipo.ListarTipos: OleVariant;
begin
  dmEntrada.qryListarEntTipo.Close;
  dmEntrada.qryListarEntTipo.Open;

  Result := dmEntrada.dspListarEntTipo.Data;
end;

class function TEntradaTipo.PegarTipo(pCodigo: Integer): TEntradaTipo;
var
  vlTipoEntrada: TEntradaTipo;
  vlTipoConferencia: TEntradaTipoConferencia;
begin
  dmEntrada.qryPegarEntTipo.Close;
  dmEntrada.qryPegarEntTipo.Parameters.ParamByName('pCdEntradaTipo').Value := pCodigo;
  dmEntrada.qryPegarEntTipo.Open;

  if (dmEntrada.qryPegarEntTipo.IsEmpty = True) then
    begin
      raise Exception.Create('Tipo de Entrada não encontrado!');
    end;

  /////////// Crição do Objeto Tipo de Conferência ////////////
  vlTipoConferencia        := TEntradaTipoConferencia.Create;
  vlTipoConferencia.Codigo := dmEntrada.qryPegarEntTipo.FieldByName('cdEntradaTipoConferencia').AsInteger;
  vlTipoConferencia.Nome   := dmEntrada.qryPegarEntTipo.FieldByName('nmEntradaTipoConferencia').AsString;
  /////////////////////////////////////////////////////////////

  vlTipoEntrada                 := TEntradaTipo.Create;
  vlTipoEntrada.Codigo          := dmEntrada.qryPegarEntTipo.FieldByName('cdEntradaTipo').AsInteger;
  vlTipoEntrada.Nome            := dmEntrada.qryPegarEntTipo.FieldByName('nmEntradaTipo').AsString;
  vlTipoEntrada.Estoque         := TEstoque.SetarTipoEstoque(dmEntrada.qryPegarEntTipo.FieldByName('cdEstoqueTipo').AsInteger);
  vlTipoEntrada.TipoConferencia := vlTipoConferencia;

  Result := vlTipoEntrada;
end;

procedure TEntradaTipo.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de Novo Tipo de Entrada: ' + Self.Nome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Tipo de Entrada: ' + Self.Nome;
    end;

  vlCodigo := FCodigo;

  try
    With dmEntrada.qrySalvarEntTipo do Begin
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;

      Close;
      Parameters.ParamByName('pCdEntradaTipo').Value            := Self.Codigo;
      Parameters.ParamByName('pNmEntradaTipo').Value            := Self.Nome;
      Parameters.ParamByName('pCdEstoqueTipo').Value            := Ord(Self.Estoque);
      Parameters.ParamByName('pCdEntradaTipoConferencia').Value := Self.TipoConferencia.Codigo;
      Open;

      Self.Codigo := FieldByName('cdEntradaTipo').AsInteger;

      pHistorico.CodigoRegistro := Self.Codigo;

      pHistorico.Salvar;

      Connection.CommitTrans;
    End;
  except on E: Exception do
    begin
      dmEntrada.qrySalvarEntTipo.Connection.RollbackTrans;

      Self.Codigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEntradaTipo.setTipoConferencia(pTipoConferencia: TEntradaTipoConferencia);
begin
  FreeAndNil(Self.FTipoConferencia);

  Self.FTipoConferencia := pTipoConferencia;
end;

procedure TEntradaTipo.ValidarDados;
var
  vlTiposEntrada: TClientDataSet;
begin
  if (Self.Codigo < 0) then
    begin
      raise Exception.Create('Código do Tipo de Entrada inválido!');
    end;

  Self.Nome := Trim(Self.Nome);

  if (Self.Nome = '') then
    begin
      raise Exception.Create('Informe o Nome do Tipo de Entrada!');
    end;

  vlTiposEntrada := TClientDataSet.Create(nil);

  try
    vlTiposEntrada.Data := ListarTipos;

    if (vlTiposEntrada.Locate('nmEntradaTipo', Self.Nome, []) = True) then
      begin
        if (vlTiposEntrada.FieldByName('cdEntradaTipo').AsInteger <> Self.Codigo) then
          begin
            raise Exception.Create('Tipo de Entrada inválido!' + #13 +
                                   'Já existe outro Tipo de Entrada registrado com essa descrição.');
          end;
      end;
  finally
    FreeAndNil(vlTiposEntrada);
  end;
end;

class function TEntradaTipoConferencia.ListarTipos: OleVariant;
begin
  dmEntrada.qryListarTipoConferencia.Close;
  dmEntrada.qryListarTipoConferencia.Open;

  Result := dmEntrada.dspListarTipoConferencia.Data;
end;

end.
