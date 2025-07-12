unit uTSaidaVolume;

interface

uses uTSaida, uTSaidaVolumeStatus, uTCaixaTipo, uTCaixa, uTHistorico, DBClient,
  uDmCadastroGeral, Dialogs, System.Variants;

type
  TSaidaVolumeErroTipo = class
  private
  public
  end;

  TSaidaVolumeErro = class
  private
  public
    class procedure RegistrarErroConferencia(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
    class procedure RegistrarErroSeparacao(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
    class function  RelatorioErrosConferencia(pDataInicial, pDataFinal: string): OleVariant;
    class function  RelatorioErrosSeparacao(pDataInicial, pDataFinal: string): OleVariant;
  end;

  TSaidaVolume = class
  private
    FCodigo: Int64;
    FNumero: Integer;
    FStatus: TSaidaVolumeStatus;
    FSaida: TSaida;
    FTipoCaixa: TCaixaTipo;
    FCaixa: TCaixa;

    FCodigoStatus: Integer;
    FCodigoSaida: Int64;
    FCodigoTipoCaixa: Integer;
    FCodigoCaixa: Int64;

    function getCaixa: TCaixa;
    function getSaida: TSaida;
    function getStatus: TSaidaVolumeStatus;
    function getTipoCaixa: TCaixaTipo;

    procedure setCaixa(pCaixa: TCaixa);
    procedure setSaida(pSaida: TSaida);
    procedure setStatus(pStatus: TSaidaVolumeStatus);
    procedure setTipoCaixa(pTipoCaixa: TCaixaTipo);

    procedure AtualizarQuantidadesAtendidas;
    procedure AtualizarStatus;
    procedure CancelarItens(pHistorico: THistorico);
    procedure DesvincularCaixa;
    procedure DesvincularCarga;
    procedure FinalizarConferencia;
    procedure InserirReservasConferido;
    procedure LimparConferenciaProduto(pCodigoProduto: Int64);
    procedure LimparLacres;
    procedure LimparLotes;
    procedure MoverReservasParaExpedicao;
    procedure MovimentarItensParaExpedicao(pCodigoUsuario: Integer);
    procedure RegistrarReconferencia(pCodigoFuncao: Integer; pHistorico: THistorico);
  public
    property Codigo: Int64               read FCodigo       write FCodigo;
    property Numero: Integer             read FNumero       write FNumero;
    property Saida: TSaida               read getSaida      write setSaida;
    property TipoCaixa: TCaixaTipo       read getTipoCaixa  write setTipoCaixa;
    property Caixa: TCaixa               read getCaixa      write setCaixa;
    property Status: TSaidaVolumeStatus  read getStatus     write setStatus;

    destructor Destroy; override;

    class function CriarVolume(pCodigoSaida: Int64; pTipoCaixa: Integer): TSaidaVolume;
    class function PegarVolume(pCodigo: string): TSaidaVolume;
    class function RelatorioStatus(pData, pSaida, pRota, pSetor, pTipoCaixa: string): OleVariant;

    procedure AjustarLotes(pCodigoProduto: Int64; pQtdProduto, pQtdConferida: Integer; pLotes: OleVariant);
    procedure AlterarStatus(pCodigoStatus: Integer; pHistorico: THistorico);
    function  CaixaFechada: Boolean;
    procedure CancelarConferencia(pHistorico: THistorico);
    procedure CancelarReconferencia(pHistorico: THistorico);
    function  CriarVolumeExtra(pHistorico: THistorico; pCodigoStatus: Integer): string;
    function CriarVolumeExtraColetor(pHistorico: THistorico): string;
    function  CriarVolumeExtraCrossDocking(pHistorico: THistorico; pConferir: boolean): string;
    procedure ConferirItem(pCodigoLote, pQuantidade: Integer);
    procedure ConferirItemCrossDocking(pCodigoProduto: Int64; pQtAtendida, pQtAnterior: Integer; pHistorico: THistorico);
    procedure ExcluirReservas;
    procedure IniciarNovaConferencia;
    procedure InserirLote(pCodigoLote, pTipoEstoque, pEndereco, pQuantidade: Integer);
    procedure InserirProduto(pCodigoProduto: Int64; pQuantidade, pEmbalagem: Integer);
    procedure InserirReservas;
    function  ListarConferenciaLotes: OleVariant;
    function  ListarConferenciaProdutos: OleVariant;
    function  ListarEstoquePendenciaConferencia: OleVariant;
    function  ListarHistorico: OleVariant;
    function  ListarItens: OleVariant;
    function  ListarItensImpressao: OleVariant;
    Class Function ImpressaoDivergencia : OleVariant;
    Class Function ImpressaoDivergenciaEstoque(pCdProduto : Integer) : OleVariant;
    class function ImpressaoDivergenciaProdutos(pCdVolume : Integer) : OleVariant;
    Class Procedure ImpressaoDivergenciaAtualizaStatus(vCdCaixa, vCdVolume : Integer);
    procedure LimparConferencia;
    function  ListarLacres: OleVariant;
    procedure RegistrarCancelamento(pHistorico: THistorico; pValidarIntegracao: Boolean = True);
    procedure RegistrarCarregamento(pHistorico: THistorico);
    procedure RegistrarConferido(pHistorico: THistorico);
    procedure RegistrarConferidoCrossDocking(pHistorico: THistorico);
    procedure RegistrarEmConferencia(pHistorico: THistorico);
    procedure RegistrarEmExpedicao(pHistorico: THistorico);
    procedure RegistrarEmReconferencia(pHistorico: THistorico);
    procedure RegistrarEmSeparacao(pHistorico: THistorico);
    procedure RegistrarEmTransito(pHistorico: THistorico);
    procedure RegistrarEntrega(pHistorico: THistorico);
    procedure RegistrarImpresso(pHistorico: THistorico);
    procedure RegistrarInicializado(pHistorico: THistorico; pReservarLote: Boolean; SeparacaoColetor : Boolean = False);
    procedure RegistrarProcessado(pHistorico: THistorico);
    procedure RegistrarReconferido(pHistorico: THistorico);
    procedure RegistrarSeparado(pHistorico: THistorico);
    function  RelatorioQuebraLote: OleVariant;
    procedure ReservarLotes;
    function  ValidarLacre(pNumeroLacre: string): Boolean;
    function  ValidarUsuarioConferencia(pCodigoUsuario: Integer): Boolean;
    procedure VincularCaixa(pCaixa: TCaixa);
    procedure VincularLacres(pLacres: TClientDataSet);
    Function GetVolumeStatus (pCdVolume : Integer) : TSaidaVolumeStatus;
    class function  IndicadorSeparacao(pDataInicial, pDataFinal : String;
                    pCdUsuario : Integer; Filtro : String) : OleVariant;
    class function IndAnaliticoSep(pDataInicial, pDataFinal: String;
      pCdUsuario: Integer; Filtro: String): OleVariant; static;
    Class Function RelatorioAnaliseUsuario(pCdUsuario : Integer; pDataInicial, pDataFinal : String) : OleVariant;
    Class Function GetSeparacaoVolumePrd(pCdVolume : Int64; pInicio : Boolean) : OleVariant;
    Class Function GetVolumeLotes(pCdVolume, pCdProduto : Int64) : OleVariant;
    Procedure SalvaItemSeparacao(PCdProduto: Int64; pQtde, pCdUsuario, pConferencia : Integer);
    Class Procedure SalvaAjusteLoteColetor(vClientDataSet : TClientDataSet; pCdUsuario : Integer);
    Procedure CancelarSeparacao;
  end;

implementation

{ TSaidaVolume }

uses uDmSaidaVolume, DB, SysUtils, uTMovtoEstoque, uTEndereco,
  uTConfig, uFuncoes, uTEstoque; //uTEstoqueTipo, uTEstoqueReserva;

procedure TSaidaVolume.AjustarLotes(pCodigoProduto: Int64; pQtdProduto, pQtdConferida: Integer; pLotes: OleVariant);
var
  vlLotes: TClientDataSet;
begin
  vlLotes := TClientDataSet.Create(nil);

  try
    vlLotes.Close;

    vlLotes.Aggregates.Add;
    vlLotes.Aggregates.Items[0].AggregateName := 'ttlSolicitado';
    vlLotes.Aggregates.Items[0].Expression    := 'SUM(qtSolicitada)';
    vlLotes.Aggregates.Items[0].Active        := True;

    vlLotes.AggregatesActive := True;
    vlLotes.Filter           := '(cdProduto = ' + IntToStr(pCodigoProduto) + ')';
    vlLotes.Filtered         := True;
    vlLotes.Data             := pLotes;

    if (vlLotes.Aggregates.Find('ttlSolicitado').Value <> pQtdProduto) then
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'A soma das quantidades dos Lotes deve ser igual à quantidade do Produto.');
      end;

    dmSaidaVolume.qryAjustarLote.Connection.Execute('SET NOCOUNT ON;');
    dmSaidaVolume.qryAjustarLote.Connection.BeginTrans;

    try
      LimparConferenciaProduto(pCodigoProduto);

      vlLotes.First;
      while (vlLotes.Eof = False) do
        begin
          {-----------------------------------------------------------
          -- Processo para redistribuir as quantidades conferidas
          -- de acordo com as novas quantidades solicitadas
          ------------------------------------------------------------}
          vlLotes.Edit;

          if (vlLotes.FieldByName('qtSolicitada').AsInteger < pQtdConferida) then
            begin
              vlLotes.FieldByName('qtConferida').Value := vlLotes.FieldByName('qtSolicitada').AsInteger;

              pQtdConferida := pQtdConferida - vlLotes.FieldByName('qtSolicitada').AsInteger;
            end
          else
            begin
              vlLotes.FieldByName('qtConferida').Value := pQtdConferida;

              pQtdConferida := 0;
            end;

          vlLotes.Post;
          {------------------------------------------------------------}

          dmSaidaVolume.qryAjustarLote.Close;
          dmSaidaVolume.qryAjustarLote.Parameters.ParamByName('pCdVolume').Value      := Self.Codigo;
          dmSaidaVolume.qryAjustarLote.Parameters.ParamByName('pCdLote').Value        := vlLotes.FieldByName('cdLote').AsInteger;
          dmSaidaVolume.qryAjustarLote.Parameters.ParamByName('pCdEstoqueTipo').Value := vlLotes.FieldByName('cdEstoqueTipo').AsInteger;
          dmSaidaVolume.qryAjustarLote.Parameters.ParamByName('pCdEndereco').Value    := vlLotes.FieldByName('cdEndereco').AsInteger;
          dmSaidaVolume.qryAjustarLote.Parameters.ParamByName('pQtSolicitada').Value  := vlLotes.FieldByName('qtSolicitada').AsInteger;
          dmSaidaVolume.qryAjustarLote.Parameters.ParamByName('pQtConferida').Value   := vlLotes.FieldByName('qtConferida').AsInteger;
          dmSaidaVolume.qryAjustarLote.ExecSQL;

          vlLotes.Next;
        end;

      dmSaidaVolume.qryAjustarLote.Connection.CommitTrans;
    except on e: Exception do
      begin
        dmSaidaVolume.qryAjustarLote.Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(vlLotes);
  end;
end;

procedure TSaidaVolume.AlterarStatus(pCodigoStatus: Integer; pHistorico: THistorico);
var vlTransacaoInterna: Boolean;
    vlStatus: string;
    Problema  : Boolean;
    Tentativa : Integer;
begin
  Repeat
    vlTransacaoInterna := False;
    With dmSaidaVolume.qryAlterarStatus do Begin
      try
        if Not (Connection.InTransaction) then Begin
           vlTransacaoInterna := True;
           Connection.Execute('SET NOCOUNT ON;');
           Connection.BeginTrans;
        end;
        if (pCodigoStatus <= 100) then Begin
           Close;
           Parameters.ParamByName('pCdVolume').Value       := Self.Codigo;
           Parameters.ParamByName('pCdVolumeStatus').Value := pCodigoStatus;
           Parameters.ParamByName('pCdUsuario').Value      := pHistorico.CodigoUsuario;
           if (pHistorico.DataHora = 0) then
              Parameters.ParamByName('pDataHora').Value    := ''
           else
              Parameters.ParamByName('pDataHora').Value := FormatDateTime('yyyy-mm-dd HH:MM:SS', pHistorico.DataHora);
           Open;
           vlStatus := FieldByName('nmVolumeStatus').AsString;
           FreeAndNil(Self.FStatus);
           Self.FCodigoStatus := pCodigoStatus;
           Self.Saida.AtualizarStatus;
        end
        else vlStatus := pHistorico.Observacao;

        pHistorico.CodigoFuncao   := 30; // 30 = Saída - Histórico
        pHistorico.CodigoRegistro := Self.Codigo;
        pHistorico.Observacao     := vlStatus;
        pHistorico.Salvar;

        if (vlTransacaoInterna = True) then
            Connection.CommitTrans;
        Problema := False;
      except on E: Exception do begin
        if (vlTransacaoInterna = True) then
           dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
        Inc(Tentativa);
        Sleep(1000);
        if Tentativa > 5 then
           raise Exception.Create(e.Message);
        end;
      end;
    End;
  Until (Not Problema) or (Tentativa > 5);
end;

procedure TSaidaVolume.AtualizarQuantidadesAtendidas;
begin
  dmSaidaVolume.qryAtualizarQuantidadesAtendidas.Close;
  dmSaidaVolume.qryAtualizarQuantidadesAtendidas.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryAtualizarQuantidadesAtendidas.ExecSQL;
end;

procedure TSaidaVolume.AtualizarStatus;
begin
  dmSaidaVolume.qryAtualizarStatus.Close;
  dmSaidaVolume.qryAtualizarStatus.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryAtualizarStatus.Open;

  FreeAndNil(Self.FStatus);

  Self.FCodigoStatus := dmSaidaVolume.qryAtualizarStatus.FieldByName('cdVolumeStatus').AsInteger;
end;

function TSaidaVolume.CaixaFechada: Boolean;
begin
  Result := Self.TipoCaixa.Codigo = 0;
end;

procedure TSaidaVolume.CancelarConferencia(pHistorico: THistorico);
begin
  AtualizarStatus;

  if (Self.Status.Codigo = 5) then // 5 = Em Conferência
    begin
      dmSaidaVolume.qryCancelarConferencia.Connection.Execute('SET NOCOUNT ON;');
      dmSaidaVolume.qryCancelarConferencia.Connection.BeginTrans;

      try
        LimparConferencia;

        dmSaidaVolume.qryCancelarConferencia.Close;
        dmSaidaVolume.qryCancelarConferencia.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
        dmSaidaVolume.qryCancelarConferencia.ExecSQL;

        AlterarStatus(4, pHistorico); // Separado (4)

        dmSaidaVolume.qryCancelarConferencia.Connection.CommitTrans;
      except on e: Exception do
        begin
          dmSaidaVolume.qryCancelarConferencia.Connection.RollbackTrans;
          raise Exception.Create(e.Message);
        end;
      end;
    end;
end;

procedure TSaidaVolume.CancelarItens(pHistorico: THistorico);
begin
  dmSaidaVolume.qryCancelarItens.Close;
  dmSaidaVolume.qryCancelarItens.Parameters.ParamByName('pCdVolume').Value  := Self.Codigo;
  dmSaidaVolume.qryCancelarItens.Parameters.ParamByName('pCdUsuario').Value := pHistorico.CodigoUsuario;
  dmSaidaVolume.qryCancelarItens.ExecSQL;
end;

procedure TSaidaVolume.CancelarReconferencia(pHistorico: THistorico);
begin
  dmSaidaVolume.qryCancelarReconferencia.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryCancelarReconferencia.Connection.BeginTrans;

  try
    LimparConferencia;

    dmSaidaVolume.qryCancelarReconferencia.Close;
    dmSaidaVolume.qryCancelarReconferencia.Parameters.ParamByName('pCdVolume').Value  := Self.Codigo;
    dmSaidaVolume.qryCancelarReconferencia.Parameters.ParamByName('pCdUsuario').Value := pHistorico.CodigoUsuario;
    dmSaidaVolume.qryCancelarReconferencia.ExecSQL;

    dmSaidaVolume.qryCancelarReconferencia.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryCancelarReconferencia.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

Procedure TSaidaVolume.CancelarSeparacao;
begin
  Try
    dmSaidaVolume.QryCancelarSeparacao.Connection.Execute('SET NOCOUNT ON;');
    dmSaidaVolume.QryCancelarSeparacao.Connection.BeginTrans;
    With DmSaidaVolume.QryCancelarSeparacao do Begin
      Close;
      Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
      ExecSql;
      Connection.CommitTrans;
    End;
  Except on E:Exception do  Begin
    dmSaidaVolume.QryCancelarSeparacao.Connection.RollbackTrans;
    raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TSaidaVolume.ConferirItem(pCodigoLote, pQuantidade: Integer);
begin
Try
  dmSaidaVolume.qryConferirItem.Close;
  dmSaidaVolume.qryConferirItem.Parameters.ParamByName('pCdVolume').Value    := Self.Codigo;
  dmSaidaVolume.qryConferirItem.Parameters.ParamByName('pCdLote').Value      := pCodigoLote;
  dmSaidaVolume.qryConferirItem.Parameters.ParamByName('pQtConferida').Value := pQuantidade;
  dmSaidaVolume.qryConferirItem.ExecSQL;
Except on e: Exception do Begin
  raise Exception.Create(E.Message);
  End;
end;
end;

procedure TSaidaVolume.ConferirItemCrossDocking(pCodigoProduto: Int64;
  pQtAtendida, pQtAnterior: Integer; pHistorico: THistorico);
var
  vlQtLote: Integer;
begin
  dmSaidaVolume.qryVerificarCrossDocking.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryVerificarCrossDocking.Connection.BeginTrans;

  try
    LimparConferenciaProduto(pCodigoProduto);

    if (pQtAtendida > 0) then
      begin
        dmSaidaVolume.qryVerificarCrossDocking.Close;
        dmSaidaVolume.qryVerificarCrossDocking.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
        dmSaidaVolume.qryVerificarCrossDocking.Open;

        if (dmSaidaVolume.qryVerificarCrossDocking.IsEmpty = True) or
           (dmSaidaVolume.qryVerificarCrossDocking.FieldByName('qtProduto').AsInteger < (pQtAtendida - pQtAnterior)) then
          begin
            raise Exception.Create('Quantidade inválida!' + sLineBreak +
                                   'A quantidade informada está acima da quantidade disponível no estoque.' + sLineBreak + sLineBreak +
                                   'Qtd. Disponível: ' + FloatToStrF(dmSaidaVolume.qryVerificarCrossDocking.FieldByName('qtProduto').AsInteger, ffNumber, 15, 0) + sLineBreak +
                                   'Qtd. Informada: ' + FloatToStrF(pQtAtendida, ffNumber, 15, 0));
          end;

        dmSaidaVolume.qryVerificarCrossDocking.Sort := 'dtVencimento';

        dmSaidaVolume.qryVerificarCrossDocking.First;
        while (dmSaidaVolume.qryVerificarCrossDocking.Eof = False) and (pQtAtendida > 0) do
          begin
            if (pQtAtendida > dmSaidaVolume.qryVerificarCrossDocking.FieldByName('qtLote').AsInteger) then
              begin
                vlQtLote := dmSaidaVolume.qryVerificarCrossDocking.FieldByName('qtLote').AsInteger;
              end
            else
              begin
                vlQtLote := pQtAtendida;
              end;

            dmSaidaVolume.qryConferirItemCrossDocking.Close;
            dmSaidaVolume.qryConferirItemCrossDocking.Parameters.ParamByName('pCdVolume').Value    := Self.Codigo;
            dmSaidaVolume.qryConferirItemCrossDocking.Parameters.ParamByName('pCdLote').Value      := dmSaidaVolume.qryVerificarCrossDocking.FieldByName('cdLote').Value;
            dmSaidaVolume.qryConferirItemCrossDocking.Parameters.ParamByName('pQtConferida').Value := vlQtLote;
            dmSaidaVolume.qryConferirItemCrossDocking.ExecSQL;

            pQtAtendida := pQtAtendida - vlQtLote;

            dmSaidaVolume.qryVerificarCrossDocking.Next;
          end;

        AtualizarStatus;

        case Self.Status.Codigo of
          1: // 1 = Processado
            begin
              AlterarStatus(3, pHistorico); // 3 = Em Separação
            end;
        end;
      end;

    dmSaidaVolume.qryVerificarCrossDocking.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryVerificarCrossDocking.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

class function TSaidaVolume.CriarVolume(pCodigoSaida: Int64; pTipoCaixa: Integer): TSaidaVolume;
begin
  dmSaidaVolume.qryCriarVolume.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryCriarVolume.Connection.BeginTrans;

  try
    dmSaidaVolume.qryCriarVolume.Close;
    dmSaidaVolume.qryCriarVolume.Parameters.ParamByName('pCdSaida').Value     := pCodigoSaida;
    dmSaidaVolume.qryCriarVolume.Parameters.ParamByName('pCdCaixaTipo').Value := pTipoCaixa;
    dmSaidaVolume.qryCriarVolume.Open;

    Result := PegarVolume(dmSaidaVolume.qryCriarVolume.FieldByName('cdVolume').AsString);

    dmSaidaVolume.qryCriarVolume.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryCriarVolume.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

function TSaidaVolume.CriarVolumeExtra(pHistorico: THistorico; pCodigoStatus: Integer): string;
var
  vlCodigo: string;
  vlNovoVolume: TSaidaVolume;
  vlTransacaoInterna: Boolean;
begin
  Result             := '';
  vlTransacaoInterna := False;

  if (dmSaidaVolume.qryCriarVolumeExtra.Connection.InTransaction = False) then
    begin
      dmSaidaVolume.qryCriarVolumeExtra.Connection.Execute('SET NOCOUNT ON;');
      dmSaidaVolume.qryCriarVolumeExtra.Connection.BeginTrans;

      vlTransacaoInterna := True;
    end;

  try
    dmSaidaVolume.qryCriarVolumeExtra.Close;
    dmSaidaVolume.qryCriarVolumeExtra.Parameters.ParamByName('pCdVolume').Value       := Self.Codigo;
    dmSaidaVolume.qryCriarVolumeExtra.Parameters.ParamByName('pCdVolumeStatus').Value := pCodigoStatus;
    dmSaidaVolume.qryCriarVolumeExtra.Open;

    vlCodigo     := dmSaidaVolume.qryCriarVolumeExtra.FieldByName('cdVolume').AsString;
    vlNovoVolume := PegarVolume(vlCodigo);

    vlNovoVolume.AlterarStatus(pCodigoStatus, pHistorico);

    FreeAndNil(vlNovoVolume);

    if (vlTransacaoInterna = True) then
      begin
        dmSaidaVolume.qryCriarVolumeExtra.Connection.CommitTrans;
      end;

    Result := vlCodigo;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmSaidaVolume.qryCriarVolumeExtra.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

function TSaidaVolume.CriarVolumeExtraColetor(pHistorico: THistorico): string;
var vlTransacaoInterna: Boolean;
begin
  Result             := '';
  vlTransacaoInterna := False;
  With dmSaidaVolume.qryCriarVolumeExtraColetor do Begin
    if (Connection.InTransaction = False) then begin
       Connection.Execute('SET NOCOUNT ON;');
       Connection.BeginTrans;
       vlTransacaoInterna := True;
    end;
    try
      Close;
      Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
      Open;
      Result := FieldByName('cdVolume').AsString;
      if (vlTransacaoInterna = True) then
         Connection.CommitTrans;
    except on e: Exception do
      Begin
        if (vlTransacaoInterna = True) then
           Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

function TSaidaVolume.CriarVolumeExtraCrossDocking(pHistorico: THistorico; pConferir: boolean): string;
begin
  dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;

  try
    Self.CriarVolumeExtra(pHistorico, 3); // 3 = Em Separação
    Self.RegistrarSeparado(pHistorico);

    if (pConferir = False) then // Se não for obrigatória a conferência
      begin
        Self.RegistrarConferidoCrossDocking(pHistorico);
      end;

    dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

destructor TSaidaVolume.Destroy;
begin
  FreeAndNil(FSaida);
  FreeAndNil(FTipoCaixa);
  FreeAndNil(FCaixa);
  FreeAndNil(FStatus);

  inherited;
end;

procedure TSaidaVolume.DesvincularCaixa;
begin
  dmSaidaVolume.qryDesvincularCaixa.Close;
  dmSaidaVolume.qryDesvincularCaixa.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryDesvincularCaixa.ExecSQL;
end;

procedure TSaidaVolume.DesvincularCarga;
begin
  dmSaidaVolume.qryDesvincularCarga.Close;
  dmSaidaVolume.qryDesvincularCarga.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryDesvincularCarga.ExecSQL;
end;

procedure TSaidaVolume.ExcluirReservas;
begin
  dmSaidaVolume.qryExcluirReservaVolume.Close;
  dmSaidaVolume.qryExcluirReservaVolume.Parameters.ParamByName('pCdVolume').Value := Self.FCodigo;
  dmSaidaVolume.qryExcluirReservaVolume.ExecSQL;
end;

procedure TSaidaVolume.FinalizarConferencia;
begin
  dmSaidaVolume.qryFinalizarConferencia.Close;
  dmSaidaVolume.qryFinalizarConferencia.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryFinalizarConferencia.ExecSQL;
end;

function TSaidaVolume.getCaixa: TCaixa;
begin
  if (Assigned(FCaixa) = False) and (FCodigoCaixa > 0) then
     setCaixa(TCaixa.PegarCaixa(FCodigoCaixa));
  Result := FCaixa;
end;

function TSaidaVolume.getSaida: TSaida;
begin
  if (Assigned(FSaida) = False) and (FCodigoSaida > 0) then
     setSaida(TSaida.PegarSaida(FCodigoSaida));
  Result := FSaida;
end;

class function TSaidaVolume.GetSeparacaoVolumePrd(pCdVolume : Int64; pInicio : Boolean): OleVariant;
begin
  With DmSaidaVolume.QrySeparacaoVolumePrd do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value := pCdVolume;
    Parameters.ParamByName('pInicio').Value   := pInicio;
    Open;
  End;
  Result := dmSaidaVolume.DspSeparacaoVolumePrd.Data;
end;

function TSaidaVolume.getStatus: TSaidaVolumeStatus;
begin
  if (Assigned(FStatus) = False) and (FCodigoStatus > 0) then
     SetStatus(TSaidaVolumeStatus.PegarStatus(FCodigoStatus));
  Result := FStatus;
end;

function TSaidaVolume.getTipoCaixa: TCaixaTipo;
begin
  if (Assigned(FTipoCaixa) = False) and (FCodigoTipoCaixa >= 0) then
     setTipoCaixa(TCaixaTipo.PegarTipoCaixa(FCodigoTipoCaixa));
  Result := FTipoCaixa;
end;

class function TSaidaVolume.GetVolumeLotes(pCdVolume,
  pCdProduto: Int64): OleVariant;
begin
  With dmSaidaVolume.QryVolumeLotes do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value  := pCdVolume;
    Parameters.ParamByName('pCdProduto').Value := pCdProduto;
    Open;
  End;
  Result := dmSaidaVolume.DspVolumeLotes.Data;
end;

function TSaidaVolume.GetVolumeStatus(pCdVolume: Integer): TSaidaVolumeStatus;
begin
  Result := TSaidaVolumeStatus.Create;
  With DmSaidaVolume.QryGetVolumeStatus do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value := pCdVolume;
    Open;
    Result.Codigo := FieldByName('CdVolumeStatus').AsInteger;
    Result.Nome   := FieldByName('NmVolumeStatus').AsString;
    Close;
  End;
end;

Class function TSaidaVolume.ImpressaoDivergencia : OleVariant;
begin
  With DmSaidaVolume.QryImpressaoDivergencia do Begin
    Close;
    Open;
  End;
  Result := dmSaidaVolume.DspImpressaoDivergencia.Data;
end;

Class procedure TSaidaVolume.ImpressaoDivergenciaAtualizaStatus(vCdCaixa,
  vCdVolume: Integer);
begin
  With DmSaidaVolume.QryImpressaoDivergenciaAtualizaStatus do Begin
    Close;
    Parameters.ParamByName('pCdCaixa').Value := vCdCaixa;
    Parameters.ParamByName('pCdVolume').Value := vCdVolume;
    Try ExecSql Finally End;
  End;
end;

class function TSaidaVolume.ImpressaoDivergenciaEstoque(pCdProduto : Integer) : OleVariant;
begin
  With DmSaidaVolume.QryImpressaoDivergenciaEstoque do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value := pCdProduto;
    Open;
  End;
  Result := dmSaidaVolume.DspImpressaoDivergenciaEstoque.Data;
end;

Class function TSaidaVolume.ImpressaoDivergenciaProdutos(pCdVolume : Integer) : OleVariant;
begin
  With DmSaidaVolume.QryImpressaoDivergenciaProduto do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value := pCdVolume;
    Open;
  End;
  Result := dmSaidaVolume.DspImpressaoDivergenciaProduto.Data;
end;

class function TSaidaVolume.IndAnaliticoSep(pDataInicial, pDataFinal: String;
  pCdUsuario: Integer; Filtro : String): OleVariant;
begin
  With DmSaidaVolume.QryIndAnaliticoSep do Begin
    Close;
    Parameters.ParamByName('pData1').Value := pDataInicial;
    Parameters.ParamByName('pData2').Value := pDataFinal;
    Parameters.ParambyName('pCdUsuario').Value := pCdUsuario;
    if Filtro<>'' then
       Sql.Strings[10] := ' and '+Filtro
    Else Sql.Strings[10] := ' -- ';
    if DebugHook <> 0 then Sql.SaveToFile('IndAnaliticoSep.Sql');

    Open;
  End;
  Result := dmSaidaVolume.DspIndAnaliticoSep.Data;
end;

class function TSaidaVolume.IndicadorSeparacao(pDataInicial, pDataFinal: String;
  pCdUsuario: Integer; Filtro : String): OleVariant;
begin
  With DmSaidaVolume.QryIndicadorSeparacao do Begin
    Close;
    Parameters.ParamByName('pData1').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDataInicial));
    Parameters.ParamByName('pData2').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDataFinal));
    Parameters.ParambyName('pCdUsuario').Value := pCdUsuario;
    if Filtro<>'' then
       Sql.Strings[11] := ' and '+Filtro
    Else Sql.Strings[11] := ' -- ';
    Sql.Strings[30] := Sql.Strings[11];
    Open;
  End;
  Result := dmSaidaVolume.DspIndicadorSeparacao.Data;
end;

procedure TSaidaVolume.IniciarNovaConferencia;
Var Problema  : Boolean;
    Tentativa : Integer;
begin
  Problema  := True;
  Tentativa := 1;
  Repeat
    dmSaidaVolume.qryIniciarConferencia.Connection.Execute('SET NOCOUNT ON;');
    dmSaidaVolume.qryIniciarConferencia.Connection.BeginTrans;

    try
      LimparConferencia;

      dmSaidaVolume.qryIniciarConferencia.Close;
      dmSaidaVolume.qryIniciarConferencia.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
      dmSaidaVolume.qryIniciarConferencia.ExecSQL;

      dmSaidaVolume.qryIniciarConferencia.Connection.CommitTrans;
      Problema := False;
    except on e: Exception do
      begin
        dmSaidaVolume.qryIniciarConferencia.Connection.RollbackTrans;
        Inc(Tentativa);
        sleep(1000);
        if Tentativa > 5 then Begin
           raise Exception.Create(e.Message);
        End;
      end;
    end;
  Until (Not Problema) or (Tentativa > 5);
end;

procedure TSaidaVolume.InserirLote(pCodigoLote, pTipoEstoque, pEndereco, pQuantidade: Integer);
begin
  dmSaidaVolume.qryInserirLote.Close;
  dmSaidaVolume.qryInserirLote.Parameters.ParamByName('pCdVolume').Value      := Self.Codigo;
  dmSaidaVolume.qryInserirLote.Parameters.ParamByName('pCdLote').Value        := pCodigoLote;
  dmSaidaVolume.qryInserirLote.Parameters.ParamByName('pCdEstoqueTipo').Value := pTipoEstoque;
  dmSaidaVolume.qryInserirLote.Parameters.ParamByName('pCdEndereco').Value    := pEndereco;
  dmSaidaVolume.qryInserirLote.Parameters.ParamByName('pQtSolicitada').Value  := pQuantidade;
  dmSaidaVolume.qryInserirLote.ExecSQL;
end;

procedure TSaidaVolume.InserirProduto(pCodigoProduto: Int64; pQuantidade, pEmbalagem: Integer);
begin
  dmSaidaVolume.qryInserirProduto.Close;
  dmSaidaVolume.qryInserirProduto.Parameters.ParamByName('pCdVolume').Value     := Self.Codigo;
  dmSaidaVolume.qryInserirProduto.Parameters.ParamByName('pCdProduto').Value    := pCodigoProduto;
  dmSaidaVolume.qryInserirProduto.Parameters.ParamByName('pQtSolicitada').Value := pQuantidade;
  dmSaidaVolume.qryInserirProduto.Parameters.ParamByName('pQtEmbalagem').Value  := pEmbalagem;
  dmSaidaVolume.qryInserirProduto.ExecSQL;
end;

procedure TSaidaVolume.InserirReservas;
var vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;
  With DmSaidaVolume.qryInserirReservaVolume do Begin
    if (Not Connection.InTransaction) then Begin
       vlTransacaoInterna := True;
       Connection.Execute('SET NOCOUNT ON;');
       Connection.BeginTrans;
    end;

    try
      ExcluirReservas;

      Close;
      Parameters.ParamByName('pCdVolume').Value := Self.FCodigo;
      ExecSQL;

      if (vlTransacaoInterna) then
         Connection.CommitTrans;
    except on e: Exception do
      begin
        if (vlTransacaoInterna = True) then
           Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

procedure TSaidaVolume.InserirReservasConferido;
Var vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;
  With DmSaidaVolume.qryInserirVolumeConferido do Begin
    if (Not Connection.InTransaction) then begin
       vlTransacaoInterna := True;
       Connection.Execute('SET NOCOUNT ON;');
       Connection.BeginTrans;
    end;

    try
      ExcluirReservas;      //Excluir Estoque Reserva lançado anteriormente
      //Inserir as Novas Reservas de Acordo com a nova TbSaidaVolumeLote atualizada pela Conferência
      Close;
      Parameters.ParamByName('pCdVolume').Value := Self.FCodigo;
      ExecSQL;
      if (vlTransacaoInterna) then
         Connection.CommitTrans;
    except on e: Exception do begin
      if (vlTransacaoInterna = True) then
         Connection.RollbackTrans;
      raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

procedure TSaidaVolume.LimparConferencia;
begin
//  GSS em 16092016 - Apaga o volume que estava em uso na Tabela TbSaidaVolumeConferencia
   dmSaidaVolume.qryLimparConferencia.Close;
   dmSaidaVolume.qryLimparConferencia.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
   dmSaidaVolume.qryLimparConferencia.ExecSQL;
end;

procedure TSaidaVolume.LimparConferenciaProduto(pCodigoProduto: Int64);
begin
  dmSaidaVolume.qryLimparConferenciaProduto.Close;
  dmSaidaVolume.qryLimparConferenciaProduto.Parameters.ParamByName('pCdVolume').Value  := Self.Codigo;
  dmSaidaVolume.qryLimparConferenciaProduto.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmSaidaVolume.qryLimparConferenciaProduto.ExecSQL;
end;

procedure TSaidaVolume.LimparLacres;
begin
  dmSaidaVolume.qryLimparLacres.Close;
  dmSaidaVolume.qryLimparLacres.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryLimparLacres.ExecSQL;
end;

procedure TSaidaVolume.LimparLotes;
begin
  Try
  dmSaidaVolume.qryLimparLotes.Close;
  dmSaidaVolume.qryLimparLotes.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryLimparLotes.ExecSQL;
  Except On E: Exception do
    raise Exception.Create('Erro ao atualizar Lotes conforme conferência!!!');
  End;
end;

function TSaidaVolume.ListarConferenciaLotes: OleVariant;
begin
Try
  dmSaidaVolume.qryListarConferenciaLotes.Close;
  dmSaidaVolume.qryListarConferenciaLotes.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryListarConferenciaLotes.Open;

  Result := dmSaidaVolume.dspListarConferenciaLotes.Data;
Except on e: Exception do Begin
  raise Exception.Create(e.Message);
End;
End;
end;

function TSaidaVolume.ListarConferenciaProdutos: OleVariant;
begin
Try
  dmSaidaVolume.qryListarConferenciaProdutos.Close;
  dmSaidaVolume.qryListarConferenciaProdutos.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryListarConferenciaProdutos.Open;

  Result := dmSaidaVolume.dspListarConferenciaProdutos.Data;
Except on e: Exception do Begin
  raise Exception.Create(E.Message);
End;
End;
end;

function TSaidaVolume.ListarEstoquePendenciaConferencia: OleVariant;
begin
  dmSaidaVolume.qryListarEstoquePendenciaConferencia.Close;
  dmSaidaVolume.qryListarEstoquePendenciaConferencia.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryListarEstoquePendenciaConferencia.Open;
  Result := dmSaidaVolume.dspListarEstoquePendenciaConferencia.Data;
end;

function TSaidaVolume.ListarHistorico: OleVariant;
begin
  Result := THistorico.Pesquisar(30, Self.Codigo);
end;

function TSaidaVolume.ListarItens: OleVariant;
begin
  dmSaidaVolume.qryListarItens.Close;
  dmSaidaVolume.qryListarItens.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryListarItens.Open;

  Result := dmSaidaVolume.dspListarItens.Data;
end;

function TSaidaVolume.ListarItensImpressao: OleVariant;
begin
  dmSaidaVolume.qryListarItensImpressao.Close;
  dmSaidaVolume.qryListarItensImpressao.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryListarItensImpressao.Open;
  Result := dmSaidaVolume.dspListarItensImpressao.Data;
end;

function TSaidaVolume.ListarLacres: OleVariant;
begin
  dmSaidaVolume.qryListarLacres.Close;
  dmSaidaVolume.qryListarLacres.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryListarLacres.Open;

  Result := dmSaidaVolume.dspListarLacres.Data;
end;

procedure TSaidaVolume.MoverReservasParaExpedicao;
var vlTransacaoInterna: Boolean;
    Problema  : Boolean;
    Tentativa : Integer;
begin
  Problema := True;
  With DmSaidaVolume.qryInserirVolumeExpedicao do Begin
    Repeat
      vlTransacaoInterna := False;
      if (Not Connection.InTransaction) then begin
         vlTransacaoInterna := True;
         Connection.Execute('SET NOCOUNT ON;');
         Connection.BeginTrans;
      end;
      try
        ExcluirReservas;
        Close;
        Parameters.ParamByName('pCdVolume').Value := Self.FCodigo;
        ExecSQL;
        if (vlTransacaoInterna = True) then
           Connection.CommitTrans;
        Problema := False;
      except on e: Exception do begin
         if (vlTransacaoInterna = True) then
            Connection.RollbackTrans;
         Inc(Tentativa);
         Sleep(500);
         if Tentativa > 5 then
            raise Exception.Create(e.Message);
         end;
      end;
    Until (Not Problema) or (Tentativa > 5);
  End;
end;

procedure TSaidaVolume.MovimentarItensParaExpedicao(pCodigoUsuario: Integer);
var
  vlItens: TClientDataSet;
  vlMovimentacao: TMovimentacao;
begin

  vlItens := TClientDataSet.Create(nil);

  try
    vlItens.Close;
    vlItens.Data := ListarItens;

    vlItens.Filter   := '(qtAtendida > 0)';
    vlItens.Filtered := True;

    if (vlItens.IsEmpty = True) then
      begin
        raise Exception.Create('Operação não permitida!' + #13 +
                               'O Volume informado não possui nenhum item.');
      end;

//  dmSaidaVolume.qryMovimentarItensExpedicao.Close;
//  dmSaidaVolume.qryMovimentarItensExpedicao.Parameters.ParamByName('pCdVolume').Value  := FCodigo;
//  dmSaidaVolume.qryMovimentarItensExpedicao.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
//  dmSaidaVolume.qryMovimentarItensExpedicao.ExecSQL;

    vlItens.First;
    while (vlItens.Eof = False) do
      begin
        vlMovimentacao := TMovimentacao.Create;

        try
          vlMovimentacao.Codigo               := 0;
          vlMovimentacao.CodigoUsuario        := pCodigoUsuario;
          vlMovimentacao.CodigoLote           := vlItens.FieldByName('cdLote').AsInteger;
          vlMovimentacao.EstoqueOrigem        := TEstoque.SetarTipoEstoque(vlItens.FieldByName('cdEstoqueTipo').AsInteger);
          vlMovimentacao.CodigoEnderecoOrigem := vlItens.FieldByName('cdEndereco').AsInteger;

          case vlMovimentacao.EstoqueOrigem of
            Espera: vlMovimentacao.Origem := 'Área de Espera'; // 1 = Área de Espera
            CrossDocking: vlMovimentacao.Origem := 'Cross Docking';  // 2 = Cross Docking
            Producao: vlMovimentacao.Origem := 'Endereço nº: ' + TEndereco.FormatarEndereco(vlItens.FieldByName('nmEndereco').AsString, vlItens.FieldByName('endMascara').AsString); // Estoque de Produção
          end;

          vlMovimentacao.EstoqueDestino := Expedicao ; // 5 = Expedição
          vlMovimentacao.CodigoEnderecoDestino := 0;
          vlMovimentacao.Destino               := 'Expedição';
          vlMovimentacao.QtdMovimentada        := vlItens.FieldByName('qtAtendida').AsInteger;
          vlMovimentacao.OperacaoEstoque       := Interna; // 2 = Interna
          vlMovimentacao.Salvar;
        finally
          FreeAndNil(vlMovimentacao);
        end;

        vlItens.Next;
      end;
  finally
    FreeAndNil(vlItens);
  end;
end;

class function TSaidaVolume.PegarVolume(pCodigo: string): TSaidaVolume;
var
  vlSaida: Int64;
  vlNumero: Integer;
  vlPosicao: Integer;
  vlVolume: TSaidaVolume;
begin
  if (Trim(pCodigo) = '') then
      raise Exception.Create('Código Inválido!')
  else Begin
    vlPosicao := AnsiPos('.', pCodigo);
    if (vlPosicao > 0) then Begin
        try
          vlPosicao := vlPosicao - 1;
          vlSaida   := StrToInt64(Copy(pCodigo, 0, vlPosicao));
          vlPosicao := vlPosicao + 2;
          vlNumero  := StrToInt(Copy(pCodigo, vlPosicao, Length(pCodigo)));
        except
          raise Exception.Create('Código Inválido!');
        end;
        pCodigo := '0';
    end
  end;
  With dmSaidaVolume.qryPegar do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value := pCodigo;
    Parameters.ParamByName('pCdSaida').Value  := vlSaida;
    Parameters.ParamByName('pNrVolume').Value := vlNumero;
    Open;
    if (IsEmpty = True) then
       raise Exception.Create('Código do Volume não encontrado!');
    vlVolume        := TSaidaVolume.Create;
    vlVolume.Codigo := FieldByName('cdVolume').AsLargeInt;
    vlVolume.Numero := FieldByName('nrVolume').AsInteger;

    vlVolume.FCodigoStatus    := FieldByName('cdVolumeStatus').AsInteger;
    vlVolume.FCodigoSaida     := FieldByName('cdSaida').AsLargeInt;
    vlVolume.FCodigoTipoCaixa := FieldByName('cdCaixaTipo').AsInteger;
    vlVolume.FCodigoCaixa     := FieldByName('cdCaixa').AsLargeInt;
  End;
  Result := vlVolume;
end;

procedure TSaidaVolume.RegistrarCancelamento(pHistorico: THistorico; pValidarIntegracao: Boolean = True);
var
  vlTransacaoInterna: Boolean;
begin
  if (pValidarIntegracao = True) then
    begin
      if (Self.Saida.Integrada = True) then
        begin
          raise Exception.Create('Operação não permitida!' + sLineBreak +
                                 'Este Volume não pode ser cancelado porque a Saída já foi integrada com o ERP.');
        end;
    end;

  vlTransacaoInterna := False;

  try
    if (dmSaidaVolume.qryAlterarStatus.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
        dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;
      end;

    AtualizarStatus;

    case Self.FCodigoStatus of
      8, 9, 10, 11: // Carregado (8), Em Trânsito (9), Entregue (10), Cancelado (11)
        begin
          raise Exception.CreateHelp('Operação não permitida!' + sLineBreak +
                                     'Este Volume não pode ser cancelado.' + sLineBreak + sLineBreak +
                                     'Status Atual: ' + Self.Status.Nome, Self.Status.Codigo);
        end;
    end;

    ExcluirReservas;
    CancelarItens(pHistorico);
    AlterarStatus(11, pHistorico); // 11 = Cancelado
    DesvincularCaixa;
    DesvincularCarga; // manter este comando após a alteração do status
    LimparConferencia;
    AtualizarQuantidadesAtendidas;

    if (vlTransacaoInterna = True) then
      begin
        dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
      end;

    if (pValidarIntegracao = True) then
      begin
        TSaida.IntegrarComERP(Saida.Codigo);
      end;
  except on E: Exception do
    begin
      if (vlTransacaoInterna = True) and (dmSaidaVolume.qryAlterarStatus.Connection.InTransaction = True) then
        begin
          dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaidaVolume.RegistrarCarregamento(pHistorico: THistorico);
var
  vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;

  if (dmSaidaVolume.qryAlterarStatus.Connection.InTransaction = False) then
    begin
      vlTransacaoInterna := True;

      dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
      dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;
    end;

  try
    AlterarStatus(8, pHistorico); // 8 = Carregado
    LimparConferencia;

    if (vlTransacaoInterna = True) then
      begin
        dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaidaVolume.RegistrarConferido(pHistorico: THistorico);
begin
  AtualizarStatus;

  case Self.Status.Codigo of
    6, 7, 8: // Conferido(6), Em Expedição(7) ou Carregado(8)
      begin
        raise Exception.Create('Operação inválida!' + sLineBreak +
                               'Este Volume já foi Conferido.');
      end;

    9, 10: // Em Trânsito(9) ou Entregue(10)
      begin
        raise Exception.Create('Operação inválida!' + sLineBreak +
                               'Este Volume já foi Finalizado.');
      end;

    11: // Cancelado(11)
      begin
        raise Exception.Create('Operação inválida!' + sLineBreak +
                               'Este Volume já foi Cancelado.');
      end;
  end;
//Realizar Cortes quando conferência/Re-Conferência finalizada com pendência
  dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;

  try
    LimparLotes;     //Apaga os lotes processados do volume
    FinalizarConferencia; //Recria os Lotes do volume de acordo com a conferência
    InserirReservasConferido;
    AlterarStatus(6, pHistorico); // 6 = Conferido
    LimparConferencia;
    AtualizarQuantidadesAtendidas;

    dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaidaVolume.RegistrarConferidoCrossDocking(pHistorico: THistorico);
begin
  AlterarStatus(6, pHistorico); // Conferido (6)
end;

procedure TSaidaVolume.RegistrarEmConferencia(pHistorico: THistorico);
begin
  AlterarStatus(5, pHistorico); // Em Conferência (5)
end;

procedure TSaidaVolume.RegistrarEmExpedicao(pHistorico: THistorico);
Var Problema  : Boolean;
    Tentativa : Integer;
begin
  AtualizarStatus;

  case Self.FCodigoStatus of
    1, 2, 3, 4, 5: // Processado (1), Impresso (2), Em Separação (3), Separado (4), Em Conferência (5)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume precisa ser Separado/Conferido antes de ser Registrado na Expedição.');
      end;

    7, 8: // Em Expedição (7), Carregado (8)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume já foi Registrado na Expedição.');
      end;

    9, 10: // Em Trânsito (9), Entregue (10)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume já foi Finalizado.');
      end;

    11: // Cancelado (11)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume foi Cancelado.');
      end;
  end;
  Problema  := True;
  Tentativa := 1;
  Repeat
    dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
    dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;
    try
//    Processo LENTO - 28082017
      MoverReservasParaExpedicao;
      MovimentarItensParaExpedicao(pHistorico.CodigoUsuario);
      AlterarStatus(7, pHistorico); // 7 = Em Expedição
      LimparConferencia;
      dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
      Problema := False;
    except on e: Exception do
      begin
        dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
        Inc(Tentativa);
        Sleep(1000);
        if Tentativa > 5 then Begin
           if (Pos('deadlock', e.Message) > 0) then begin
              e.Message := 'Servidor ocupado!' + sLineBreak +
                           'O servidor não conseguiu processar sua solicitação. Tente novamente após alguns segundos.';
           end;
           raise Exception.Create(e.Message);
        End;
      end;
    end;
  Until (Not Problema) or (Tentativa > 5);
//Só Integra se todos os volumes tiverem Em Expedição
  TSaida.IntegrarComERP(Self.Saida.Codigo);
end;

procedure TSaidaVolume.RegistrarEmSeparacao(pHistorico: THistorico);
begin
  AlterarStatus(3, pHistorico); // Em Conferência (5)
end;

procedure TSaidaVolume.RegistrarEmReconferencia(pHistorico: THistorico);
begin
  RegistrarReconferencia(101, pHistorico); // 101 = Em Reconferência
end;

procedure TSaidaVolume.RegistrarEmTransito(pHistorico: THistorico);
var vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;
  With dmSaidaVolume.qryAlterarStatus do Begin
    if (Connection.InTransaction = False) then Begin
       vlTransacaoInterna := True;
       Connection.Execute('SET NOCOUNT ON;');
       Connection.BeginTrans;
    end;
    try
      if (Assigned(Self.Caixa) = True) then
         TCaixa.RegistrarEmLoja(Self.Caixa.Codigo);
      ExcluirReservas;  //ExcluirReservas; //GSS em 16092016
      AlterarStatus(9, pHistorico); // 9 = Em Trânsito  GSS em 22092016
      DmSaidaVolume.LimparConferencia(Self.Codigo); //LimparConferencia;
      if vlTransacaoInterna then Connection.CommitTrans;
    except on e: Exception do
      Begin
        if (vlTransacaoInterna = True) then
           Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

procedure TSaidaVolume.RegistrarEntrega(pHistorico: THistorico);
var
  vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;

  if (dmSaidaVolume.qryAlterarStatus.Connection.InTransaction = False) then
    begin
      vlTransacaoInterna := True;

      dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
      dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;
    end;

  try
    AlterarStatus(10, pHistorico); // 10 = Entregue
    LimparConferencia;

    if (vlTransacaoInterna = True) then
      begin
        dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaidaVolume.RegistrarImpresso(pHistorico: THistorico);
begin
  AlterarStatus(2, pHistorico); // 2 = Impresso
end;

procedure TSaidaVolume.RegistrarInicializado(pHistorico: THistorico; pReservarLote: Boolean; SeparacaoColetor : Boolean = False);
begin
  case Self.FCodigoStatus of
    1: // Processado (1)
      If Not SeparacaoColetor then begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume precisa ser Processado/Impresso antes da Inicialização.');
      end;

    3, 4, 5, 6: // Em Separação (3), Separado (4), Em Conferência (5), Conferido (6)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume já foi Inicializado.');
      end;

    7, 8: // Em Expedição (7), Carregado (8)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume já foi Registrado na Expedição.');
      end;

    9, 10: // Em Trânsito (9), Entregue (10)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume já foi Finalizado.');
      end;

    11: // Cancelado (11)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Este Volume foi Cancelado.');
      end;
  end;

  if (pReservarLote = False) then
    begin
      AlterarStatus(3, pHistorico); // 3 = Em Separação
    end
  else
    begin
      dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
      dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;

      try
        ReservarLotes;
        AlterarStatus(3, pHistorico); // 3 = Em Separação

        dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
      except on e: Exception do
        begin
          dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
          raise Exception.Create(e.Message);
        end;
      end;
    end;
end;

procedure TSaidaVolume.RegistrarProcessado(pHistorico: THistorico);
begin
  AlterarStatus(1, pHistorico); // Processado (1)
end;

procedure TSaidaVolume.RegistrarReconferencia(pCodigoFuncao: Integer; pHistorico: THistorico);
var vlStatus: string;
    vIniTransaction : Boolean;
begin
  vIniTransaction := False;
  if (dmSaidaVolume.qryRegistrarReconferencia.Connection.InTransaction = False) then Begin
     dmSaidaVolume.qryRegistrarReconferencia.Connection.Execute('SET NOCOUNT ON;');
     dmSaidaVolume.qryRegistrarReconferencia.Connection.BeginTrans;
     vIniTransaction := True;
  End;
  try

    dmSaidaVolume.qryRegistrarReconferencia.Close;
    dmSaidaVolume.qryRegistrarReconferencia.Parameters.ParamByName('pCdVolume').Value       := Self.Codigo;
    dmSaidaVolume.qryRegistrarReconferencia.Parameters.ParamByName('pCdVolumeStatus').Value := pCodigoFuncao;
    dmSaidaVolume.qryRegistrarReconferencia.Parameters.ParamByName('pCdUsuario').Value      := pHistorico.CodigoUsuario;
    dmSaidaVolume.qryRegistrarReconferencia.Open;

    vlStatus := dmSaidaVolume.qryRegistrarReconferencia.FieldByName('nmVolumeStatus').AsString;

    pHistorico.CodigoFuncao   := 30; // 30 = Cadastrar Saída - Histórico
    pHistorico.CodigoRegistro := Self.Codigo;
    pHistorico.Observacao     := vlStatus;
    pHistorico.Salvar;

    LimparConferencia;
    if vIniTransaction = True then
       dmSaidaVolume.qryRegistrarReconferencia.Connection.CommitTrans;
  except on e: Exception do
    begin
      if vIniTransaction = True Then
         dmSaidaVolume.qryRegistrarReconferencia.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaidaVolume.RegistrarReconferido(pHistorico: THistorico);
begin
//Realizar Cortes quando conferência/Re-Conferência finalizada com pendência
  dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;

  try
    LimparLotes;     //Apaga os lotes processados do volume
    FinalizarConferencia; //Recria os Lotes do volume de acordo com a conferência
    InserirReservasConferido;
    AtualizarQuantidadesAtendidas;
    RegistrarReconferencia(102, pHistorico); // 102 = Reconferido
    dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
//  RegistrarReconferencia(102, pHistorico); // 102 = Reconferido
end;

procedure TSaidaVolume.RegistrarSeparado(pHistorico: THistorico);
var
  vlTransacaoInterna: Boolean;
begin
  case Self.Saida.Tipo.Codigo of
    1:  // Tipo Saída Venda/Ressuprimento
      begin
        AlterarStatus(4, pHistorico); // Separado (4)
      end;

    2: // Tipo Saída Cross Docking
      begin
        vlTransacaoInterna := False;

        if (dmSaidaVolume.qryAlterarStatus.Connection.InTransaction = False) then
          begin
            vlTransacaoInterna := True;

            dmSaidaVolume.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
            dmSaidaVolume.qryAlterarStatus.Connection.BeginTrans;
          end;

        try
          LimparLotes;
          FinalizarConferencia;
          InserirReservasConferido;
          AlterarStatus(4, pHistorico); // Separado (4)
          LimparConferencia;
          AtualizarQuantidadesAtendidas;

          if (vlTransacaoInterna = True) then
            begin
              dmSaidaVolume.qryAlterarStatus.Connection.CommitTrans;
            end;
        except on e: Exception do
          begin
            if (vlTransacaoInterna = True) then
              begin
                dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
              end;

            raise Exception.Create(e.Message);
          end;
        end;
      end;
  end;
end;

class function TSaidaVolume.RelatorioAnaliseUsuario(pCdUsuario: Integer;
  pDataInicial, pDataFinal: String): OleVariant;
begin
  With dmSaidaVolume.QryRelatorioAnaliseUsuario do Begin
    Close;
    Parameters.ParamByName('pCdUsuario').Value := pCdUsuario;
    if pDataInicial = '' then Parameters.ParamByName('pDataInicial').Value := Null
    Else Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));;
    if pDataFinal = '' then Parameters.ParamByName('pDataFinal').Value := Null
    Else Parameters.ParamByName('pDataFinal').Value := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));;
    Open;
  End;
  Result := dmSaidaVolume.dspRelatorioAnaliseUsuario.Data;
end;

function TSaidaVolume.RelatorioQuebraLote: OleVariant;
begin
  dmSaidaVolume.qryRelatorioQuebraLote.Close;
  dmSaidaVolume.qryRelatorioQuebraLote.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryRelatorioQuebraLote.Open;

  Result := dmSaidaVolume.dspRelatorioQuebraLote.Data;
end;

class function TSaidaVolume.RelatorioStatus(pData, pSaida, pRota, pSetor, pTipoCaixa: string): OleVariant;
begin
  ValidarData(pData, 'Data');
  ValidarParametroTexto(pSaida);
  ValidarParametroTexto(pRota);
  ValidarParametroTexto(pSetor);
  ValidarParametroTexto(pTipoCaixa);

  dmSaidaVolume.qryRelatorioStatus.Close;
  dmSaidaVolume.qryRelatorioStatus.Parameters.ParamByName('pDtSaida').Value         := FormatDateTime('yyyy-mm-dd', StrToDate(pData));
  dmSaidaVolume.qryRelatorioStatus.Parameters.ParamByName('pCdSaida').Value         := pSaida;
  dmSaidaVolume.qryRelatorioStatus.Parameters.ParamByName('pCdRota').Value          := pRota;
  dmSaidaVolume.qryRelatorioStatus.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaidaVolume.qryRelatorioStatus.Parameters.ParamByName('pCdCaixaTipo').Value     := pTipoCaixa;
  dmSaidaVolume.qryRelatorioStatus.Open;

  Result := dmSaidaVolume.dspRelatorioStatus.Data;
end;

procedure TSaidaVolume.ReservarLotes;
var
  vlTransacaoInterna: Boolean;
  vlCodigoProduto: Int64;
  vlCodigoEnderecoProduto: Integer;
  vlQtdSolicitada: Integer;
  vlQtdEmbalagem: Integer;
  vlTipoSeparacao: string;
  vlCodigoLote: Integer;
  vlTipoEstoque: Integer;
  vlCodigoEnderecoEstoque: Integer;
  vlQtdEstoque: Integer;
  vlQuantidade: Integer;
begin
  vlTransacaoInterna := False;

  try
    if (dmSaidaVolume.qryReservarLotes.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmSaidaVolume.qryReservarLotes.Connection.Execute('SET NOCOUNT ON;');
        dmSaidaVolume.qryReservarLotes.Connection.BeginTrans;
      end;

    LimparLotes;

    dmSaidaVolume.qryReservarLotes.Close;
    dmSaidaVolume.qryReservarLotes.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
    dmSaidaVolume.qryReservarLotes.Open;

    if (dmSaidaVolume.qryReservarLotes.IsEmpty = True) then
      begin
        raise Exception.Create('Operação inválida!' + sLineBreak +
                               'Não existe estoque disponível para nenhum dos itens deste Volume('+Self.Codigo.ToString()+').');
      end;

    dmSaidaVolume.qryReservarLotes.Sort := 'cdProduto, Ordem';

    vlCodigoProduto := 0;
    vlCodigoLote    := 0;

    dmSaidaVolume.qryReservarLotes.First;
    while (dmSaidaVolume.qryReservarLotes.Eof = False) do
      begin
        if (vlCodigoProduto <> dmSaidaVolume.qryReservarLotes.FieldByName('cdProduto').AsLargeInt) then
          begin
            vlCodigoProduto         := dmSaidaVolume.qryReservarLotes.FieldByName('cdProduto').AsLargeInt;
            vlCodigoEnderecoProduto := dmSaidaVolume.qryReservarLotes.FieldByName('cdEnderecoProduto').AsInteger;
            vlQtdSolicitada         := dmSaidaVolume.qryReservarLotes.FieldByName('qtSolicitada').AsInteger;
            vlQtdEmbalagem          := dmSaidaVolume.qryReservarLotes.FieldByName('qtEmbalagem').AsInteger;
            vlTipoSeparacao         := dmSaidaVolume.qryReservarLotes.FieldByName('TipoSeparacao').AsString;

            if (vlCodigoEnderecoProduto = 0) and (vlTipoSeparacao <> 'Pallet') then
              begin
                raise Exception.Create('Operação inválida!' + sLineBreak +
                                       'Este Volume('+Self.Codigo.ToString()+') possui Produtos sem cadastro de Endereço.' + sLineBreak +
                                       'Cadastre os endereços dos produtos antes de Inicializar a Separação.');
              end;
          end;

        if (vlCodigoLote <> dmSaidaVolume.qryReservarLotes.FieldByName('cdLote').AsInteger) or
           (vlCodigoEnderecoEstoque <> dmSaidaVolume.qryReservarLotes.FieldByName('cdEnderecoEstoque').AsInteger) or
           (vlTipoEstoque <> dmSaidaVolume.qryReservarLotes.FieldByName('cdEstoqueTipo').AsInteger) then
          begin
            vlTipoEstoque           := dmSaidaVolume.qryReservarLotes.FieldByName('cdEstoqueTipo').AsInteger;
            vlCodigoEnderecoEstoque := dmSaidaVolume.qryReservarLotes.FieldByName('cdEnderecoEstoque').AsInteger;
            vlCodigoLote            := dmSaidaVolume.qryReservarLotes.FieldByName('cdLote').AsInteger;
            vlQtdEstoque            := dmSaidaVolume.qryReservarLotes.FieldByName('qtDisponivel').AsInteger;
          end;

        while (vlQtdSolicitada >= vlQtdEmbalagem) and (vlQtdEstoque >= vlQtdEmbalagem) do
          begin
            if (vlQtdSolicitada < vlQtdEstoque) then
              begin
                vlQuantidade := vlQtdSolicitada;
              end
            else
              begin
                vlQuantidade := vlQtdEstoque;
              end;

            if (vlQuantidade > vlQtdEmbalagem) then
              begin
                vlQuantidade := Trunc(vlQuantidade / vlQtdEmbalagem) * vlQtdEmbalagem;
              end;

            if (vlQuantidade > 0) then
              begin
                if (vlTipoSeparacao = 'Pallet') then
                  begin
                    InserirLote(vlCodigoLote, vlTipoEstoque, vlCodigoEnderecoEstoque, vlQuantidade);
                  end
                else
                  begin
                    InserirLote(vlCodigoLote, 4, vlCodigoEnderecoProduto, vlQuantidade);
                  end;

                vlQtdSolicitada := vlQtdSolicitada - vlQuantidade;
                vlQtdEstoque    := vlQtdEstoque - vlQuantidade;
              end;
          end;

        dmSaidaVolume.qryReservarLotes.Next;
      end;

    InserirReservas;

    if (vlTransacaoInterna = True) then
      begin
        dmSaidaVolume.qryReservarLotes.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmSaidaVolume.qryReservarLotes.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

Class Procedure TSaidaVolume.SalvaAjusteLoteColetor(vClientDataSet: TClientDataSet; pCdUsuario : Integer);
Var vDelReserva : Integer;
begin
  With DmSaidaVolume.QrySalvaAjusteLoteColetor do Begin
    Try
       if Not (Connection.InTransaction) then Begin
          Connection.Execute('SET NOCOUNT ON;');
          Connection.BeginTrans;
       end;
      vClientDataSet.Open();
      vClientDataSet.First;
      vDelReserva := 1;
      While Not vClientDataSet.Eof do Begin
        Close;
        Parameters.ParamByName('pDelReserva').Value  := vDelReserva;
        Parameters.ParamByName('pCdVolume').Value    := vClientDataSet.FieldByName('CdVolume').AsLargeInt;
        Parameters.ParamByName('pCdUsuario').Value   := pCdUsuario;
        Parameters.ParamByName('pCdEndereco').Value  := vClientDataSet.FieldByName('CdEndereco').AsLargeInt;
        Parameters.ParamByName('pCdLote').Value      := vClientDataSet.FieldByName('CdLote').AsLargeInt;
        Parameters.ParamByName('pQtReservada').Value := vClientDataSet.FieldByName('QtSolicitada').AsLargeInt;
        Parameters.ParamByname('pCdProduto').Value   := vClientDataSet.FieldByName('CdProduto').AsLargeInt;
        ExecSQL;
        vClientDataSet.Next;
        vDelReserva := 0;
      End;
      if (Connection.InTransaction) then
          Connection.CommitTrans;
    except on E: Exception do
      begin
        if (Connection.InTransaction) then
           dmSaidaVolume.qryAlterarStatus.Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

procedure TSaidaVolume.SalvaItemSeparacao(PCdProduto: Int64; pQtde, pCdUsuario, pConferencia : Integer);
begin
  With DmSaidaVolume.QrySalvarItemSeparacao do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value  := Self.Codigo;
    Parameters.ParamByName('pCdProduto').Value := pCdProduto;
    Parameters.ParamByName('pQtde').value      := pQtde;
    Parameters.ParamByName('pCdUsuario').Value := pCdUsuario;
    Parameters.ParamByName('pConferencia').Value := pConferencia;
    ExecSql;
  End;
end;

procedure TSaidaVolume.setCaixa(pCaixa: TCaixa);
begin
  FreeAndNil(FCaixa);

  FCaixa := pCaixa;

  if (Assigned(FCaixa) = True) then
    begin
      FCodigoCaixa := FCaixa.Codigo;
    end
  else
    begin
      FCodigoCaixa := 0;
    end;
end;

procedure TSaidaVolume.setSaida(pSaida: TSaida);
begin
  FreeAndNil(FSaida);

  FSaida := pSaida;

  if (Assigned(FSaida) = True) then
    begin
      FCodigoSaida := FSaida.Codigo;
    end
  else
    begin
      FCodigoSaida := 0;
    end;
end;

procedure TSaidaVolume.setStatus(pStatus: TSaidaVolumeStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;

  if (Assigned(FStatus) = True) then
    begin
      FCodigoStatus := FStatus.Codigo;
    end
  else
    begin
      FCodigoStatus := 0;
    end;
end;

procedure TSaidaVolume.setTipoCaixa(pTipoCaixa: TCaixaTipo);
begin
  FreeAndNil(FTipoCaixa);

  FTipoCaixa := pTipoCaixa;

  if (Assigned(FTipoCaixa) = True) then
    begin
      FCodigoTipoCaixa := FTipoCaixa.Codigo;
    end
  else
    begin
      FCodigoTipoCaixa := -1;
    end;
end;

function TSaidaVolume.ValidarLacre(pNumeroLacre: string): Boolean;
begin
  dmSaidaVolume.qryValidarLacre.Close;
  dmSaidaVolume.qryValidarLacre.Parameters.ParamByName('pNrLacre').Value := pNumeroLacre;
  dmSaidaVolume.qryValidarLacre.Open;

  Result := dmSaidaVolume.qryValidarLacre.IsEmpty;
end;

function TSaidaVolume.ValidarUsuarioConferencia(pCodigoUsuario: Integer): Boolean;
begin
  dmSaidaVolume.qryValidarUsuarioConferencia.Close;
  dmSaidaVolume.qryValidarUsuarioConferencia.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
  dmSaidaVolume.qryValidarUsuarioConferencia.Open;

  Result := dmSaidaVolume.qryValidarUsuarioConferencia.Locate('cdUsuario', pCodigoUsuario, []);
end;

procedure TSaidaVolume.VincularCaixa(pCaixa: TCaixa);
begin
  if (Assigned(Self.Caixa) = False) or (Self.Caixa.Codigo <> pCaixa.Codigo) then
    begin
      case pCaixa.Status.Codigo of
        2: // Ocupada (2)
          begin
            if (1=2) and (Self.FCodigoCaixa <> pCaixa.Codigo) then //Permitir Usar mesma caixa da conferência.
               raise Exception.Create('Operação inválida!' + #13 +
                                   'A Caixa informada já está vinculada a outro Volume.');
          end;

        3, 4: // Em Loja (3), Retirada (4)
          begin
            TCaixa.RegistrarRetorno(pCaixa.Codigo);
          end;
      end;
    end;

  dmSaidaVolume.qryVincularCaixa.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryVincularCaixa.Connection.BeginTrans;

  try
    DesvincularCaixa;

    dmSaidaVolume.qryVincularCaixa.Close;
    dmSaidaVolume.qryVincularCaixa.Parameters.ParamByName('pCdCaixa').Value  := pCaixa.Codigo;
    dmSaidaVolume.qryVincularCaixa.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
    dmSaidaVolume.qryVincularCaixa.ExecSQL;

    setCaixa(pCaixa);

    dmSaidaVolume.qryVincularCaixa.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryVincularCaixa.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaidaVolume.VincularLacres(pLacres: TClientDataSet);
begin
  dmSaidaVolume.qryVincularLacre.Connection.Execute('SET NOCOUNT ON;');
  dmSaidaVolume.qryVincularLacre.Connection.BeginTrans;

  try
    LimparLacres;

    pLacres.First;
    while (pLacres.Eof = False) do
      begin
        if (ValidarLacre(pLacres.FieldByName('nrLacre').AsString) = False) then
          begin
            pLacres.Edit;
            pLacres.FieldByName('Erro').Value := 1;
            pLacres.Post;
          end
        else
          begin
            dmSaidaVolume.qryVincularLacre.Close;
            dmSaidaVolume.qryVincularLacre.Parameters.ParamByName('pCdVolume').Value := Self.Codigo;
            dmSaidaVolume.qryVincularLacre.Parameters.ParamByName('pNrLacre').Value  := pLacres.FieldByName('nrLacre').AsString;
            dmSaidaVolume.qryVincularLacre.ExecSQL;
          end;

        pLacres.Next;
      end;

    if (pLacres.Locate('Erro', 1, []) = True) then
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Existem lacres vinculados a outros Volumes.');
      end;

    dmSaidaVolume.qryVincularLacre.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmSaidaVolume.qryVincularLacre.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

class procedure TSaidaVolumeErro.RegistrarErroConferencia(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
begin
  With dmSaidaVolume.qryRegistrarErroConferencia do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value   := pCodigoVolume;
    Parameters.ParamByName('pCdProduto').Value  := pCodigoProduto;
    Parameters.ParamByName('pCdErroTipo').Value := pCodigoTipo;
    ExecSQL;
  End;
end;

class procedure TSaidaVolumeErro.RegistrarErroSeparacao(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
begin
  With dmSaidaVolume.qryRegistrarErroSeparacao do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value   := pCodigoVolume;
    Parameters.ParamByName('pCdProduto').Value  := pCodigoProduto;
    Parameters.ParamByName('pCdErroTipo').Value := pCodigoTipo;
    ExecSQL;
  End;
end;

class function TSaidaVolumeErro.RelatorioErrosConferencia(pDataInicial, pDataFinal: string): OleVariant;
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
  With dmSaidaVolume.qryRelatorioErrosConferencia do Begin
    Close;
    Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
    Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
    Open;
  End;
  Result := dmSaidaVolume.DspRelatorioErrosConferencia.Data;
end;

class function TSaidaVolumeErro.RelatorioErrosSeparacao(pDataInicial, pDataFinal: string): OleVariant;
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
  With dmSaidaVolume.qryRelatorioErrosSeparacao do Begin
    Close;
    Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
    Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
    Open;
  End;
  Result := dmSaidaVolume.dspRelatorioErrosSeparacao.Data;
end;

end.
