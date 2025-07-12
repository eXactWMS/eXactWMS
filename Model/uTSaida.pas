unit uTSaida;

interface

uses uTCliente, uTCarga, uTHistorico, FireDAC.Comp.Client,
  uDmCadastroGeral, System.Classes, FireDAC.Comp.DataSet, Dialogs;

type
  TSaidaStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function Listar: OleVariant;
  end;

  TSaidaTipo = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarTipos: OleVariant;
  end;

  TSaida = class
  private
    FCodigo: Int64;
    FData: TDateTime;
    FDocumento: string;
    FTipo: TSaidaTipo;
    FStatus: TSaidaStatus;
    FCodigoCliente: Integer;
    FCliente: TCliente;
    FCodigoCarga: Integer;
    FCarga: TCarga;

    function  getCarga: TCarga;
    function  getCliente: TCliente;
    procedure setCarga(pCarga: TCarga);
    procedure setCliente(pCliente: TCliente);

    procedure RegistrarSaidaDosProdutos(pHistorico: THistorico);
  public
    property Codigo: Int64          read FCodigo      write FCodigo;
    property Data: TDateTime        read FData        write FData;
    property Documento: string      read FDocumento   write FDocumento;
    property Tipo: TSaidaTipo       read FTipo        write FTipo;
    property Status: TSaidaStatus   read FStatus      write FStatus;
    property Cliente: TCliente      read getCliente   write setCliente;
    property Carga: TCarga          read getCarga     write setCarga;

    constructor Create;
    destructor Destroy; override;

    class function  AcompanharConferencia(pDataSaida, pSetor: string): OleVariant;
    class function  AcompanharConferenciaCliente(pDataSaida, pSetor: string; pCodigoCliente: Integer) : OleVariant;
    class function  AcompanharConferenciaRota(pDataSaida, pSetor: string; pCodigoRota: Integer)       : OleVariant;
    class function  AcompanharConferenciaSaida(pCodigoSaida: Int64): OleVariant;
    class procedure Excluir(pCodigo: Int64; pHistorico: THistorico);
    class procedure IntegrarComERP(pCodigo: Int64);
    Class Function  ListarSaidasCliente(pCodCliente : Integer) : OleVariant;
    Class Function  ListarSaidasVolumesCliente(pSaida : Integer) : OleVariant;
    Class Function  ListarSaidasProdutoCliente(pCdVolume : Integer) : OleVariant;

    class function  ListarVolumesEmExpedicao: OleVariant;
    class function  ListarSaidasProcessar(pCodigoTipo: Integer; pCodigo, pDocumento, pDataInicial, pDataFinal,
                                          pRotaInicial, pRotaFinal, pSetor, pStatus,
                                          pCliente: string; Reprocessar : Boolean = False; Imprimir : Boolean = False; pTipoCaixa : Integer = 99) : OleVariant;
    class function  EtiquetaSeparacao(pCodigoTipo: Integer; pCodigo, pDocumento, pDataInicial, pDataFinal,
                                          pRotaInicial, pRotaFinal, pSetor, pStatus,
                                          pCliente: string; Imprimir : Boolean = False) : OleVariant; //Caixa Fechada
    Class Function EtqSeparacaoFracionada(vCdSaida : Integer) : OleVariant; //Fracionados
    Class Function EtqFracionadaPorSetor(pCdVolume, pEnderecoSetor: Integer) : Boolean;
    class function  PegarSaida(pCodigo: Int64): TSaida;
    class function  Pesquisar(pCodigo, pDataInicial, pDataFinal, pDocumento, pCaixa, pLacre,
                              pRotaInicial, pRotaFinal, pTipo, pSetor, pStatus, pCliente: string)      : OleVariant;
    class function  RelatorioAtendimentoCrossDocking(pCodProduto: Int64)     : OleVariant;
    class function  RelatorioEficienciaSeparacao(pDataInicial, pDataFinal    : string): OleVariant;
    class function  RelatorioFaltas(pDataInicial, pDataFinal: string)        : OleVariant;
    class function  RelatorioProdutividadeGeral(pDataInicial, pDataFinal     : string): OleVariant;
    class function  RelatorioProdutividadeIndividual(pCodigoUsuario, pTipo   : Integer): OleVariant;
    class function  RelatorioProdutividadeSeparacao(pDataInicial, pDataFinal : string): OleVariant;
    class function  RelatorioReconferencia(pDataInicial, pDataFinal: string; pCdUsuario : String = '%'; pEndSetor : Integer = 0) : OleVariant;
    class function  RelatorioSaidaPorProduto(pCodigoProduto : Int64; pCodigoLote, pDataInicial, pDataFinal: string): OleVariant;
    class function ProducaoDiaria(pMes, PAno: Integer)      : OleVariant; static;     //GSS em 18/07/2016
    class function ProdDiaItem(pMes, PAno: Integer): OleVariant; static;
    class function ProducaoDiariaExcl(pMes, PAno: Integer)  : OleVariant; static; //GSS em 19/07/2016
    Class Function ProdutoSemPicking(Saida : Integer) : Boolean;
    Class Function RelAnalisePorCliente(pDataInicial, pDataFinal, pCdSaidaTipo,
          pCdSaidaStatus, pCdEnderecoSetor, pCdCliente : String; pCdRotaInicial, pCdRotaFinal : Integer) : OleVariant;
    class procedure VerificarPendenciasCrossDocking;
    Class Procedure ExcluirRessuprimento(vCdSaida : Int64);

    procedure AtualizarStatus;
    procedure Cancelar(pHistorico: THistorico);
    procedure ExcluirVolumes;
    function  Integrada: Boolean;
    function  ListarCaixaFechada: OleVariant;
    function  ListarCaixaFracionada: OleVariant;
    function  ListarItens: OleVariant;
    function  ListarItensCrossDocking: OleVariant;
    function  ListarVolumes: OleVariant;
    function  ListarVolumesConferenciaCarga: OleVariant;
    procedure RegistrarCarregamento(pHistorico: THistorico);
    procedure RegistrarEmExpedicao(pHistorico: THistorico);
    procedure RegistrarEmTransito(pHistorico: THistorico);
    procedure RegistrarEntrega(pHistorico: THistorico);
    procedure RegistrarProcessamento(pHistorico: THistorico);
  end;

implementation

{ TSaida }

uses uDmSaida, DB, DBClient, SysUtils, uTSaidaVolume, uTMovtoEstoque, uTEstoque,
  uFuncoes;

class function TSaida.AcompanharConferencia(pDataSaida, pSetor: string): OleVariant;
begin
  if (RemoverEspacos(RemoverCaracteres(pDataSaida)) = '') then
    begin
      pDataSaida := '%'
    end
  else
    begin
      try
        pDataSaida := FormatDateTime('yyyy-mm-dd', StrToDate(pDataSaida));
      except
        raise Exception.Create('Data da Saída inválida!');
      end;
    end;

  ValidarParametroTexto(pSetor);

  dmSaida.qryAcompanharConferencia.Close;
  dmSaida.qryAcompanharConferencia.Parameters.ParamByName('pDtSaida').Value         := pDataSaida;
  dmSaida.qryAcompanharConferencia.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaida.qryAcompanharConferencia.Open;

  Result := dmSaida.dspAcompanharConferencia.Data;
end;

class function TSaida.AcompanharConferenciaCliente(pDataSaida, pSetor: string; pCodigoCliente: Integer): OleVariant;
begin
  if (RemoverEspacos(RemoverCaracteres(pDataSaida)) = '') then
    begin
      pDataSaida := '%'
    end
  else
    begin
      try
        pDataSaida := FormatDateTime('yyyy-mm-dd', StrToDate(pDataSaida));
      except
        raise Exception.Create('Data da Saída inválida!');
      end;
    end;

  ValidarParametroTexto(pSetor);

  dmSaida.qryAcompanharConferenciaCliente.Close;
  dmSaida.qryAcompanharConferenciaCliente.Parameters.ParamByName('pDtSaida').Value         := pDataSaida;
  dmSaida.qryAcompanharConferenciaCliente.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaida.qryAcompanharConferenciaCliente.Parameters.ParamByName('pCdCliente').Value       := pCodigoCliente;
  dmSaida.qryAcompanharConferenciaCliente.Open;

  Result := dmSaida.dspAcompanharConferenciaCliente.Data;
end;

class function TSaida.AcompanharConferenciaRota(pDataSaida, pSetor: string; pCodigoRota: Integer): OleVariant;
begin
  if (RemoverEspacos(RemoverCaracteres(pDataSaida)) = '') then
    begin
      pDataSaida := '%'
    end
  else
    begin
      try
        pDataSaida := FormatDateTime('yyyy-mm-dd', StrToDate(pDataSaida));
      except
        raise Exception.Create('Data da Saída inválida!');
      end;
    end;

  ValidarParametroTexto(pSetor);

  dmSaida.qryAcompanharConferenciaRota.Close;
  dmSaida.qryAcompanharConferenciaRota.Parameters.ParamByName('pDtSaida').Value         := pDataSaida;
  dmSaida.qryAcompanharConferenciaRota.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaida.qryAcompanharConferenciaRota.Parameters.ParamByName('pCdRota').Value          := pCodigoRota;
  dmSaida.qryAcompanharConferenciaRota.Open;

  Result := dmSaida.dspAcompanharConferenciaRota.Data;
end;

class function TSaida.AcompanharConferenciaSaida(pCodigoSaida: Int64): OleVariant;
begin
  dmSaida.qryAcompanharConferenciaSaida.Close;
  dmSaida.qryAcompanharConferenciaSaida.Parameters.ParamByName('pCdSaida').Value := pCodigoSaida;
  dmSaida.qryAcompanharConferenciaSaida.Open;

  Result := dmSaida.dspAcompanharConferenciaSaida.Data;
end;

procedure TSaida.AtualizarStatus;
begin

  dmSaida.qryAtualizarStatus.Close;
  dmSaida.qryAtualizarStatus.Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
  dmSaida.qryAtualizarStatus.Open;

  Self.Status.Codigo := dmSaida.qryAtualizarStatus.FieldByName('cdSaidaStatus').AsInteger;
  Self.Status.Nome   := dmSaida.qryAtualizarStatus.FieldByName('nmSaidaStatus').AsString;

  exit; //Trecho abaixo com uso de FdQuery



//GSS em 16092016
  DmSaida.AtualizarStatus(Self.Codigo);
  Self.Status.Codigo := dmSaida.QryPesquisa.FieldByName('cdSaidaStatus').AsInteger;
  Self.Status.Nome   := dmSaida.QryPesquisa.FieldByName('nmSaidaStatus').AsString;
{   dmSaida.qryAtualizarStatus.Close;
   dmSaida.qryAtualizarStatus.Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
   dmSaida.qryAtualizarStatus.Open;
   Self.Status.Codigo := dmSaida.qryAtualizarStatus.FieldByName('cdSaidaStatus').AsInteger;
   Self.Status.Nome   := dmSaida.qryAtualizarStatus.FieldByName('nmSaidaStatus').AsString;
}end;

procedure TSaida.Cancelar(pHistorico: THistorico);
var
  vlVolumes: TClientDataSet;
  vlVolume: TSaidaVolume;
  vlSaida: TSaida;
  vlErro: string;
begin
  AtualizarStatus;

  case Self.Status.Codigo of
    5, 6: // Finalizada (5) ou Cancelada (6)
      begin
        vlErro := 'Operação não permitida!' + sLineBreak;

        case Self.Status.Codigo of
          5: vlErro := vlErro + 'Esta Saída já foi Finalizada!';
          6: vlErro := vlErro + 'Esta Saída já foi Cancelada!';
        end;

        raise Exception.Create(vlErro);
      end;

    else
      begin
        vlVolumes := TClientDataSet.Create(nil);

        try
          vlVolumes.Close;
          vlVolumes.Data := ListarVolumes;

          if (vlVolumes.IsEmpty = True) then
            begin
              raise Exception.Create('Operação inválida!' + sLineBreak +
                                     'Esta Saída não possui volumes para ser cancelada. Tente Excluir a Saída');
            end;

          vlVolumes.IndexFieldNames := 'cdVolumeStatus';

          vlVolumes.First;

          if (vlVolumes.FieldByName('cdVolumeStatus').AsInteger = 8) then // Carregado (8)
            begin
              raise Exception.Create('Operação não permitida!' + sLineBreak +
                                     'Esta Saída já foi Carregada!');
            end;

          vlVolumes.Filter   := '(cdVolumeStatus <> 8) and (cdVolumeStatus <> 9) and (cdVolumeStatus <> 10) and (cdVolumeStatus <> 11)';
          vlVolumes.Filtered := True;

          try
            dmSaida.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
            dmSaida.qryExcluir.Connection.BeginTrans;

            vlVolumes.First;
            while (vlVolumes.Eof = False) do
              begin
                vlVolume := TSaidaVolume.Create;
                vlSaida  := TSaida.Create;

                try
                  vlVolume.Codigo := vlVolumes.FieldByName('cdVolume').AsLargeInt;
                  vlSaida.Codigo  := Self.Codigo;
                  vlVolume.Saida  := vlSaida;

                  vlVolume.RegistrarCancelamento(pHistorico, False);
                  vlVolumes.Next;
                finally
                  FreeAndNil(vlVolume);
                end;
              end;

            dmSaida.qryExcluir.Connection.CommitTrans;

            IntegrarComERP(FCodigo);
          except on e: Exception do
            begin
              if (dmSaida.qryExcluir.Connection.InTransaction = True) then
                begin
                  dmSaida.qryExcluir.Connection.RollbackTrans;
                end;

              raise Exception.Create(e.Message);
            end;
          end;
        finally
          FreeAndNil(vlVolumes);
          AtualizarStatus;
        end;
      end;
  end;
end;

constructor TSaida.Create;
begin
  FTipo   := TSaidaTipo.Create;
  FStatus := TSaidaStatus.Create;
end;

destructor TSaida.Destroy;
begin
  FreeAndNil(FTipo);
  FreeAndNil(FStatus);
  FreeAndNil(FCliente);
  FreeAndNil(FCarga);

  inherited;
end;

class function TSaida.EtiquetaSeparacao(pCodigoTipo: Integer; pCodigo,
  pDocumento, pDataInicial, pDataFinal, pRotaInicial, pRotaFinal, pSetor,
  pStatus, pCliente: string; Imprimir: Boolean): OleVariant;    //Caixa Fechada
begin
  pDataInicial := Trim(pDataInicial);
  pDataFinal   := Trim(pDataFinal);
  pRotaInicial := Trim(pRotaInicial);
  pRotaFinal   := Trim(pRotaFinal);

  ValidarParametroTexto(pCodigo);

  if (Trim(pCodigo) <> '%') then
    begin
      pDataInicial := '';
      pDataFinal   := '';
      pRotaInicial := '';
      pRotaFinal   := '';
    end;

  ValidarParametroTexto(pDocumento);

  if (Trim(pDocumento) <> '%') then
    begin
      pDataInicial := '';
      pDataFinal   := '';
      pRotaInicial := '';
      pRotaFinal   := '';
    end;

  if (pDataInicial = '') or (pDataFinal = '') then
    begin
      if (pDataInicial = '') then
        begin
          pDataInicial := pDataFinal;
        end
      else
        begin
          pDataFinal := pDataInicial;
        end;
    end;

  if (pDataInicial <> '') then
    begin
      try
        pDataInicial := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));
      except
        raise Exception.Create('Data Inicial inválida!');
      end;
    end
  else if (pCodigo <> '%') or (pDocumento <> '%') then
    begin
      pDataInicial := '2000-01-01'
    end
  else
    begin
      raise Exception.Create('Data Inicial inválida!');
    end;

  if (pDataFinal <> '') then
    begin
      try
        pDataFinal := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));
      except
        raise Exception.Create('Data Final inválida!');
      end;
    end
  else if (pCodigo <> '%') or (pDocumento <> '%') then
    begin
      pDataFinal := '3000-01-01';
    end
  else
    begin
      raise Exception.Create('Data Final inválida!');
    end;

  if (pRotaInicial = '') or (pRotaFinal = '') then
    begin
      if (pRotaInicial = '') then
        begin
          pRotaInicial := pRotaFinal
        end
      else
        begin
          pRotaFinal := pRotaInicial;
        end;
    end;

  if (Trim(pRotaInicial) = '') then
    begin
      pRotaInicial := '0';
    end;

  if (Trim(pRotaFinal) = '') then
    begin
      pRotaFinal := '99999999';
    end;

  ValidarParametroTexto(pSetor);
  ValidarParametroTexto(pStatus);
  ValidarParametroTexto(pCliente);

  dmSaida.QryEtiquetaSeparacao.Close;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdSaidaTipo').Value     := pCodigoTipo;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdSaida').Value         := pCodigo;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pNrDocumento').Value     := '%' + pDocumento + '%';
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pDataInicial').Value     := pDataInicial;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pDataFinal').Value       := pDataFinal;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdRotaInicial').Value   := pRotaInicial;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdRotaFinal').Value     := pRotaFinal;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdSaidaStatus').Value   := pStatus;
  dmSaida.QryEtiquetaSeparacao.Parameters.ParamByName('pCdCliente').Value       := pCliente;
  dmSaida.QryEtiquetaSeparacao.Open;

  Result := dmSaida.DspEtiquetaSeparacao.Data;
end;

class function TSaida.EtqFracionadaPorSetor(pCdVolume, pEnderecoSetor: Integer): Boolean;
begin
  With DmSaida.QryEtqFracionadaPorSetor do Begin
    Close;
    Parameters.ParamByName('pCdVolume').Value        := pCdVolume;
    Parameters.ParamByName('pCdEnderecoSetor').Value := pEnderecoSetor;
    Open;
    Result := Not IsEmpty;
    Close;
  End;
end;

class function TSaida.EtqSeparacaoFracionada(vCdSaida: Integer): OleVariant;
begin
  dmSaida.QryEtqSeparacaoFracionada.Close;
  dmSaida.QryEtqSeparacaoFracionada.Parameters.ParamByName('pCdSaida').Value := vCdSaida;
  Result := dmSaida.DspEtqSeparacaoFracionada.Data;
end;

class procedure TSaida.Excluir(pCodigo: Int64; pHistorico: THistorico);
var
  vlVolumes: TClientDataSet;
  vlSaida: TSaida;
begin
  vlVolumes := TClientDataSet.Create(nil);
  vlSaida   := TSaida.Create;

  try
    vlSaida.Codigo := pCodigo;

    vlVolumes.Close;
    vlVolumes.Data := vlSaida.ListarVolumes;

    if (vlVolumes.IsEmpty = False) then
      begin
        raise Exception.Create('Operação não permitida!' + #13 +
                               'Esta Saída já foi processada e não pode ser excluída. Tente Cancelar a Saída.');
      end;

    try
      dmSaida.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
      dmSaida.qryExcluir.Connection.BeginTrans;

      dmSaida.qryExcluir.Close;
      dmSaida.qryExcluir.Parameters.ParamByName('pCdSaida').Value := pCodigo;
      dmSaida.qryExcluir.ExecSQL;

      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.CodigoFuncao   := 30; // 30 - Cadastrar Saída - Histórico
      pHistorico.Observacao     := 'Excluída';
      pHistorico.Salvar;

      dmSaida.qryExcluir.Connection.CommitTrans;
    except on e: Exception do
      begin
        dmSaida.qryExcluir.Connection.RollbackTrans;

        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(vlVolumes);
    FreeAndNil(vlSaida);
  end;
end;

class procedure TSaida.ExcluirRessuprimento(vCdSaida: Int64);
var vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;

  if (dmSaida.QryExcluirRessuprimento.Connection.InTransaction = False) then
    begin
      vlTransacaoInterna := True;

      dmSaida.QryExcluirRessuprimento.Connection.Execute('SET NOCOUNT ON;');
      dmSaida.QryExcluirRessuprimento.Connection.BeginTrans;
    end;

  try
    With DmSaida.QryExcluirRessuprimento do Begin
      Close;
      Parameters.ParamByName('pCdSaida').Value := vCdSaida;
      ExecSql;
      if (vlTransacaoInterna = True) then
         Connection.CommitTrans;
    End;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = False) then
         dmSaida.QryExcluirRessuprimento.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaida.ExcluirVolumes;
var vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;
  With dmSaida.qryExcluirVolumes do Begin
    if (Not Connection.InTransaction) then begin
        vlTransacaoInterna := True;
        Connection.Execute('SET NOCOUNT ON;');
        Connection.BeginTrans;
    end;
    try
      With dmSaida.qryExcluirReservaSaida do begin
        Close;
        Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
        ExecSQL;
      end;
      Close;
      Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
      ExecSQL;
      if (vlTransacaoInterna = True) then
         Connection.CommitTrans;
    except on e: Exception do
      begin
        if (vlTransacaoInterna = False) then
           Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

function TSaida.getCarga: TCarga;
begin
  if (Assigned(FCarga) = False) and (FCodigoCarga > 0) then
    begin
      setCarga(TCarga.PegarCarga(FCodigoCarga));
    end;

  Result := FCarga;
end;

function TSaida.getCliente: TCliente;
begin
  if (Assigned(FCliente) = False) and (FCodigoCliente > 0) then
    begin
      setCliente(TCliente.PegarCliente(FCodigoCliente));
    end;

  Result := FCliente;
end;

function TSaida.Integrada: Boolean;
begin
  Result := False;

  Self.AtualizarStatus;

  if (Self.Status.Codigo in [4, 5, 6]) then // Em Expedição (4), Finalizada (5) ou Cancelada (6)
    begin
      Result := True;
    end;
end;

class procedure TSaida.IntegrarComERP(pCodigo: Int64);
begin
  dmSaida.qryIntegrarComERP.Close;
  dmSaida.qryIntegrarComERP.Parameters.ParamByName('pCdSaida').Value := pCodigo;
  dmSaida.qryIntegrarComERP.ExecSQL;
end;

function TSaida.ListarCaixaFechada: OleVariant;
begin
  dmSaida.qryListarCaixaFechada.Close;
  dmSaida.qryListarCaixaFechada.Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
  dmSaida.qryListarCaixaFechada.Open;

  Result := dmSaida.dspListarCaixaFechada.Data;
end;

function TSaida.ListarCaixaFracionada: OleVariant;
begin
  dmSaida.qryListarCaixaFracionada.Close;
  dmSaida.qryListarCaixaFracionada.Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
  dmSaida.qryListarCaixaFracionada.Open;

  Result := dmSaida.dspListarCaixaFracionada.Data;
end;

function TSaida.ListarItens: OleVariant;
begin
  dmSaida.qryListarItens.Close;
  dmSaida.qryListarItens.Parameters.ParamByName('pCdSaida').Value := FCodigo;
  dmSaida.qryListarItens.Open;

  Result := dmSaida.dspListarItens.Data;
end;

function TSaida.ListarItensCrossDocking: OleVariant;
begin
  dmSaida.qryListarItensCrossDocking.Close;
  dmSaida.qryListarItensCrossDocking.Parameters.ParamByName('pCdSaida').Value := FCodigo;
  dmSaida.qryListarItensCrossDocking.Open;

  Result := dmSaida.dspListarItensCrossDocking.Data;
end;

Class Function  TSaida.ListarSaidasCliente(pCodCliente : Integer) : OleVariant;
Begin
  With DmSaida.QryListarSaidasCliente do begin
    Close;
    Parameters.ParamByName('pCodCliente').Value := pCodCliente;
    Open;
    Result := DmSaida.DspListarSaidasCliente.Data;
  End;
end;

class function TSaida.ListarSaidasProcessar(pCodigoTipo: Integer; pCodigo, pDocumento, pDataInicial, pDataFinal,
  pRotaInicial, pRotaFinal, pSetor, pStatus, pCliente: string; Reprocessar : Boolean = False; Imprimir : Boolean = False; pTipoCaixa : Integer = 99): OleVariant;
begin
  pDataInicial := Trim(pDataInicial);
  pDataFinal   := Trim(pDataFinal);
  pRotaInicial := Trim(pRotaInicial);
  pRotaFinal   := Trim(pRotaFinal);

  ValidarParametroTexto(pCodigo);

  if (Trim(pCodigo) <> '%') then
    begin
      pDataInicial := '';
      pDataFinal   := '';
      pRotaInicial := '';
      pRotaFinal   := '';
    end;

  ValidarParametroTexto(pDocumento);

  if (Trim(pDocumento) <> '%') then
    begin
      pDataInicial := '';
      pDataFinal   := '';
      pRotaInicial := '';
      pRotaFinal   := '';
    end;

  if (pDataInicial = '') or (pDataFinal = '') then
    begin
      if (pDataInicial = '') then
        begin
          pDataInicial := pDataFinal;
        end
      else
        begin
          pDataFinal := pDataInicial;
        end;
    end;

  if (pDataInicial <> '') then
    begin
      try
        pDataInicial := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));
      except
        raise Exception.Create('Data Inicial inválida!');
      end;
    end
  else if (pCodigo <> '%') or (pDocumento <> '%') then
    begin
      pDataInicial := '2000-01-01'
    end
  else
    begin
      raise Exception.Create('Data Inicial inválida!');
    end;

  if (pDataFinal <> '') then
    begin
      try
        pDataFinal := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));
      except
        raise Exception.Create('Data Final inválida!');
      end;
    end
  else if (pCodigo <> '%') or (pDocumento <> '%') then
    begin
      pDataFinal := '3000-01-01';
    end
  else
    begin
      raise Exception.Create('Data Final inválida!');
    end;

  if (pRotaInicial = '') or (pRotaFinal = '') then
    begin
      if (pRotaInicial = '') then
        begin
          pRotaInicial := pRotaFinal
        end
      else
        begin
          pRotaFinal := pRotaInicial;
        end;
    end;

  if (Trim(pRotaInicial) = '') then
    begin
      pRotaInicial := '0';
    end;

  if (Trim(pRotaFinal) = '') then
    begin
      pRotaFinal := '99999999';
    end;

  ValidarParametroTexto(pSetor);
  ValidarParametroTexto(pStatus);
  ValidarParametroTexto(pCliente);

  dmSaida.qryListarSaidasProcessar.Close;
  DmSaida.qryListarSaidasProcessar.Sql.Strings[46] := '--';
  if Imprimir then
     DmSaida.qryListarSaidasProcessar.Sql.Strings[46] := '   and (Exists (Select CdSaida From TbSaidaVolume SV Where SV.CdSaida = Sai.cdSaida))';
(*
   Else If ((Not Reprocessar) and (pSetor <> '%')) then
     DmSaida.qryListarSaidasProcessar.Sql.Strings[46] := '   and (Not Exists (Select Sv.CdVolume From TbSaidaVolume SV'+
         ' Inner Join TbSaidaVolumeProduto VP On Vp.CdVolume = SV.cdVolume'+
         ' Inner Join VwProduto Prd ON Prd.CdProduto = Vp.CdProduto'+
         ' Where SV.CdSaida = Sai.CdSaida and Prd.cdEnderecoSetor = @CdEnderecoSetor))';

*)  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdSaidaTipo').Value     := pCodigoTipo;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdSaida').Value         := pCodigo;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pNrDocumento').Value     := '%' + pDocumento + '%';
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pDataInicial').Value     := pDataInicial;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pDataFinal').Value       := pDataFinal;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdRotaInicial').Value   := pRotaInicial;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdRotaFinal').Value     := pRotaFinal;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdSaidaStatus').Value   := pStatus;
  dmSaida.qryListarSaidasProcessar.Parameters.ParamByName('pCdCliente').Value       := pCliente;
  dmSaida.qryListarSaidasProcessar.Sql.SaveToFile('ProcessarSaida.Txt');
  dmSaida.qryListarSaidasProcessar.Open;
  Result := dmSaida.dspListarSaidasProcessar.Data;
end;

class function TSaida.ListarSaidasProdutoCliente(
  pCdVolume: Integer): OleVariant;
begin
  dmSaida.QryListarSaidasProdCliente.Close;
  dmSaida.QryListarSaidasProdCliente.Parameters.ParamByName('pCdVolume').Value := pCdVolume;
  dmSaida.QryListarSaidasProdCliente.Open;
  Result := dmSaida.DspListarSaidasProdCliente.Data;
end;

class function TSaida.ListarSaidasVolumesCliente(pSaida: Integer): OleVariant;
begin
  dmSaida.qryListarVolumes.Close;
  dmSaida.qryListarVolumes.Parameters.ParamByName('pCdSaida').Value := pSaida;
  dmSaida.qryListarVolumes.Open;
  Result := dmSaida.dspListarVolumes.Data;
end;

function TSaida.ListarVolumes: OleVariant;
begin
  dmSaida.qryListarVolumes.Close;
  dmSaida.qryListarVolumes.Parameters.ParamByName('pCdSaida').Value := Self.FCodigo;
  dmSaida.qryListarVolumes.Open;

  Result := dmSaida.dspListarVolumes.Data;
end;

function TSaida.ListarVolumesConferenciaCarga: OleVariant;
begin
  dmSaida.qryListarVolumesConferenciaCarga.Close;
  dmSaida.qryListarVolumesConferenciaCarga.Parameters.ParamByName('pCdSaida').Value := Self.FCodigo;
  dmSaida.qryListarVolumesConferenciaCarga.Open;

  Result := dmSaida.dspListarVolumesConferenciaCarga.Data;
end;

class function TSaida.ListarVolumesEmExpedicao: OleVariant;
begin
  dmSaida.qryListarVolumesEmExpedicao.Close;
  dmSaida.qryListarVolumesEmExpedicao.Open;

  Result := dmSaida.dspListarVolumesEmExpedicao.Data;
end;

class function TSaida.PegarSaida(pCodigo: Int64): TSaida;
var vlSaida : TSaida;
begin
//Marcar Numero de Vezes    1
  dmSaida.qryPegar.Close;
  dmSaida.qryPegar.Parameters.ParamByName('pCdSaida').Value := pCodigo;
  dmSaida.qryPegar.Open;

  if (dmSaida.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código da Saída('+IntToStr(pCodigo)+') não encontrado!');
    end;

  vlSaida           := TSaida.Create;
  vlSaida.Codigo    := dmSaida.qryPegar.FieldByName('cdSaida').AsLargeInt;
  vlSaida.Data      := dmSaida.qryPegar.FieldByName('dtSaida').AsDateTime;
  vlSaida.Documento := dmSaida.qryPegar.FieldByName('nrDocumento').AsString;

  vlSaida.Tipo.Codigo    := dmSaida.qryPegar.FieldByName('cdSaidaTipo').AsInteger;
  vlSaida.Tipo.Nome      := dmSaida.qryPegar.FieldByName('nmSaidaTipo').AsString;

  vlSaida.Status.Codigo  := dmSaida.qryPegar.FieldByName('cdSaidaStatus').AsInteger;
  vlSaida.Status.Nome    := dmSaida.qryPegar.FieldByName('nmSaidaStatus').AsString;

  vlSaida.FCodigoCliente := dmSaida.qryPegar.FieldByName('cdCliente').AsInteger;
  vlSaida.FCodigoCarga   := dmSaida.qryPegar.FieldByName('cdCarga').AsInteger;

  Result := vlSaida;
end;

class function TSaida.Pesquisar(pCodigo, pDataInicial, pDataFinal, pDocumento, pCaixa, pLacre,
  pRotaInicial, pRotaFinal, pTipo, pSetor, pStatus, pCliente: string): OleVariant;
begin
  pDataInicial := Trim(pDataInicial);
  pDataFinal   := Trim(pDataFinal);
  pRotaInicial := Trim(pRotaInicial);
  pRotaFinal   := Trim(pRotaFinal);

  ValidarParametroTexto(pCodigo);

  if (Trim(pCodigo) <> '%') then
    begin
      pDataInicial := '';
      pDataFinal   := '';
    end;

  ValidarParametroTexto(pDocumento);

  if (Trim(pDocumento) <> '%') then
    begin
      pDataInicial := '';
      pDataFinal   := '';
    end;

  if (pDataInicial = '') or (pDataFinal = '') then
    begin
      if (pDataInicial = '') then
        begin
          pDataInicial := pDataFinal;
        end
      else
        begin
          pDataFinal := pDataInicial;
        end;
    end;

  if (pDataInicial = '') then
    begin
      pDataInicial := '1900-01-01'
    end
  else
    begin
      try
        pDataInicial := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));
      except
        raise Exception.Create('Data Inicial inválida!');
      end;
    end;

  if (pDataFinal = '') then
    begin
      pDataFinal := '3000-01-01';
    end
  else
    begin
      try
        pDataFinal := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));
      except
        raise Exception.Create('Data Final inválida!');
      end;
    end;

  ValidarParametroTexto(pCaixa);
  ValidarParametroTexto(pLacre);

  if (pRotaInicial = '') or (pRotaFinal = '') then
    begin
      if (pRotaInicial = '') then
        begin
          pRotaInicial := pRotaFinal
        end
      else
        begin
          pRotaFinal := pRotaInicial;
        end;
    end;

  if (Trim(pRotaInicial) = '') then
    begin
      pRotaInicial := '0';
    end;

  if (Trim(pRotaFinal) = '') then
    begin
      pRotaFinal := '99999999';
    end;

  ValidarParametroTexto(pTipo);
  ValidarParametroTexto(pSetor);
  ValidarParametroTexto(pStatus);
  ValidarParametroTexto(pCliente);

  dmSaida.qryPesquisar.Close;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdSaida').Value         := pCodigo;
  dmSaida.qryPesquisar.Parameters.ParamByName('pDtSaidaInicial').Value  := pDataInicial;
  dmSaida.qryPesquisar.Parameters.ParamByName('pDtSaidaFinal').Value    := pDataFinal;
  dmSaida.qryPesquisar.Parameters.ParamByName('pNrDocumento').Value     := '%' + pDocumento + '%';
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdCaixa').Value         := pCaixa;
  dmSaida.qryPesquisar.Parameters.ParamByName('pNrLacre').Value         := pLacre;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdRotaInicial').Value   := pRotaInicial;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdRotaFinal').Value     := pRotaFinal;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdSaidaTipo').Value     := pTipo;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdSaidaStatus').Value   := pStatus;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmSaida.qryPesquisar.Parameters.ParamByName('pCdCliente').Value       := pCliente;
  dmSaida.qryPesquisar.Open;

  Result := dmSaida.dspPesquisar.Data;
end;

procedure TSaida.RegistrarCarregamento(pHistorico: THistorico);
var
  vlVolumes: TClientDataSet;
  vlVolume: TSaidaVolume;
  vlSaida: TSaida;
begin
  vlVolumes := TClientDataSet.Create(nil);

  try
    vlVolumes.Close;
    vlVolumes.Data := ListarVolumes;

    vlVolumes.Filter   := '(cdVolumeStatus <> 11)'; // 11 = Cancelado
    vlVolumes.Filtered := True;

    vlVolumes.First;
    while (vlVolumes.Eof = False) do
      begin
        vlVolume := TSaidaVolume.Create;
        vlSaida  := TSaida.Create;

        try
          vlVolume.Codigo := vlVolumes.FieldByName('cdVolume').AsLargeInt;
          vlSaida.Codigo  := Self.Codigo;
          vlVolume.Saida  := vlSaida;

          vlVolume.RegistrarCarregamento(pHistorico);
          vlVolumes.Next;
        finally
          FreeAndNil(vlVolume);        
        end;
      end;
  finally
    FreeAndNil(vlVolumes);
  end;
end;

procedure TSaida.RegistrarEmExpedicao(pHistorico: THistorico);
var
  vlVolumes: TClientDataSet;
  vlVolume: TSaidaVolume;
  vlSaida: TSaida;
begin
  vlVolumes := TClientDataSet.Create(nil);

  try
    vlVolumes.Close;
    vlVolumes.Data := ListarVolumes;

    vlVolumes.Filter   := '(cdVolumeStatus <> 11)'; // 11 = Cancelado
    vlVolumes.Filtered := True;

    vlVolumes.First;
    while (vlVolumes.Eof = False) do
      begin
        vlVolume := TSaidaVolume.Create;
        vlSaida  := TSaida.Create;

        try
          vlVolume.Codigo := vlVolumes.FieldByName('cdVolume').AsLargeInt;
          vlSaida.Codigo  := Self.Codigo;
          vlVolume.Saida  := vlSaida;

          vlVolume.AlterarStatus(7, pHistorico); // Apenas altera o status, não movimenta os produtos
          vlVolumes.Next;
        finally
          FreeAndNil(vlVolume);        
        end;
      end;
  finally
    FreeAndNil(vlVolumes);
  end;
end;

procedure TSaida.RegistrarEmTransito(pHistorico: THistorico);
var
  vlTransacaoInterna: Boolean;
//  vlVolumes: TClientDataSet;
  vlVolumes: TClientDataSet;
  vlVolume: TSaidaVolume;
  vlSaida: TSaida;
//  QryMemVolume : TFdMemTable;
  xCodSql : tStringList;
begin
  vlTransacaoInterna := False;

  try
    if (dmSaida.qryExcluir.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmSaida.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
        dmSaida.qryExcluir.Connection.BeginTrans;
      end;

          vlVolumes := TClientDataSet.Create(nil);

    try
      vlVolumes.Close;
      vlVolumes.Data := ListarVolumes;

      vlVolumes.Filter   := '(cdVolumeStatus <> 11)'; // 11 = Cancelado
      vlVolumes.Filtered := True;

      vlVolumes.First;
      while (vlVolumes.Eof = False) do
        begin
          vlVolume := TSaidaVolume.Create;
          vlSaida  := TSaida.Create;

          try
            vlVolume.Codigo := vlVolumes.FieldByName('cdVolume').AsLargeInt;
            vlSaida.Codigo  := Self.Codigo;
            vlVolume.Saida  := vlSaida;

            vlVolume.RegistrarEmTransito(pHistorico);
            vlVolumes.Next;
          finally
            FreeAndNil(vlVolume);
          end;
        end;
    finally
      FreeAndNil(vlVolumes);
    end;


    RegistrarSaidaDosProdutos(pHistorico);           //Processo Demorado
    if (vlTransacaoInterna = True) then
      begin
        dmSaida.qryExcluir.Connection.CommitTrans;
      end;
  except on E: Exception do
    begin
      if (vlTransacaoInterna = True) and (dmSaida.qryExcluir.Connection.InTransaction = True) then
        begin
          dmSaida.qryExcluir.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSaida.RegistrarEntrega(pHistorico: THistorico);
var
  vlVolumes: TClientDataSet;
  vlVolume: TSaidaVolume;
  vlSaida: TSaida;
begin
  vlVolumes := TClientDataSet.Create(nil);

  try
    vlVolumes.Close;
    vlVolumes.Data := ListarVolumes;

    vlVolumes.Filter   := '(cdVolumeStatus <> 11)'; // 11 = Cancelado
    vlVolumes.Filtered := True;

    vlVolumes.First;
    while (vlVolumes.Eof = False) do
      begin
        vlVolume := TSaidaVolume.Create;
        vlSaida  := TSaida.Create;

        try
          vlVolume.Codigo := vlVolumes.FieldByName('cdVolume').AsLargeInt;
          vlSaida.Codigo  := Self.Codigo;
          vlVolume.Saida  := vlSaida;

          vlVolume.RegistrarEntrega(pHistorico);
          vlVolumes.Next;
        finally
          FreeAndNil(vlVolume);        
        end;
      end;
  finally
    FreeAndNil(vlVolumes);
  end;
end;

procedure TSaida.RegistrarProcessamento(pHistorico: THistorico);
var
  vlVolumes: TClientDataSet;
  vlVolume: TSaidaVolume;
  vlSaida: TSaida;
begin
  vlVolumes := TClientDataSet.Create(nil);

  try
    vlVolumes.Close;
    vlVolumes.Data := ListarVolumes;

    vlVolumes.Filter   := '(cdVolumeStatus = 1)'; // 1 = Processado
    vlVolumes.Filtered := True;

    vlVolumes.First;
    while (vlVolumes.Eof = False) do
      begin
        vlVolume := TSaidaVolume.Create;
        vlSaida  := TSaida.Create;

        try
          vlVolume.Codigo := vlVolumes.FieldByName('cdVolume').AsLargeInt;
          vlSaida.Codigo  := Self.Codigo;
          vlVolume.Saida  := vlSaida;

          vlVolume.RegistrarProcessado(pHistorico);
          vlVolumes.Next;
        finally
          FreeAndNil(vlVolume);
        end;
      end;
  finally
    FreeAndNil(vlVolumes);
  end;
end;

procedure TSaida.RegistrarSaidaDosProdutos(pHistorico: THistorico);
var
  vlMovimentacao: TMovimentacao;
begin
  With dmSaida.qryListarLotes do Begin
    Close;
    Parameters.ParamByName('pCdSaida').Value := Self.Codigo;
    Open;
    First;
    While (Eof = False) do Begin
      vlMovimentacao := TMovimentacao.Create;
      try
        vlMovimentacao.Codigo                := 0;
        vlMovimentacao.CodigoUsuario         := pHistorico.CodigoUsuario;
        vlMovimentacao.CodigoLote            := FieldByName('cdLote').AsInteger;
        vlMovimentacao.EstoqueOrigem         := Expedicao; // 5 = Expedição
        vlMovimentacao.Origem                := 'Expedição';
        vlMovimentacao.EstoqueDestino        := TipoUndefined; // 0 = Nulo
        vlMovimentacao.Destino               := 'Saída n.: ' + IntToStr(FCodigo);
        vlMovimentacao.QtdMovimentada        := FieldByName('qtAtendida').AsInteger;
        vlMovimentacao.OperacaoEstoque       := Saida; // 3 = Saída
        vlMovimentacao.Salvar;
      finally
        FreeAndNil(vlMovimentacao);
      end;
      Next;
    end;
  End;
end;

class function TSaida.RelAnalisePorCliente(pDataInicial, pDataFinal,
  pCdSaidaTipo, pCdSaidaStatus, pCdEnderecoSetor, pCdCliente: String;
  pCdRotaInicial, pCdRotaFinal: Integer): OleVariant;
begin
  With DmSaida.QryRelAnalisePorCliente do begin
    Close;
    Parameters.ParamByName('pDataInicial').Value     := FormatDateTime('YYYY-MM-DD', StrToDate(pDataInicial));
    Parameters.ParamByName('pDataFinal').Value       := FormatDateTime('YYYY-MM-DD', StrToDate(pDataFinal));
    Parameters.ParamByName('pCdSaidaTipo').Value     := pCdSaidaTipo;
    Parameters.ParamByName('pCdSaidaStatus').Value   := pCdSaidaStatus;
    Parameters.ParamByName('pCdEnderecoSetor').Value := pCdEnderecoSetor;
    Parameters.ParamByName('pCdCliente').Value      := pCdCliente;
    Parameters.ParamByName('pCdRotaInicial').Value   := pCdRotaInicial;
    Parameters.ParamByName('pCdRotaFinal').Value     := pCdRotaFinal;
    Open;
  end;
  Result := DmSaida.DspRelAnalisePorCliente.Data;
end;

class function TSaida.RelatorioAtendimentoCrossDocking(pCodProduto: Int64): OleVariant;
begin
  dmSaida.qryRelatorioAtendimentoCrossDocking.Close;
  dmSaida.qryRelatorioAtendimentoCrossDocking.Parameters.ParamByName('pCdProduto').Value := pCodProduto;
  dmSaida.qryRelatorioAtendimentoCrossDocking.Open;

  Result := dmSaida.dspRelatorioAtendimentoCrossDocking.Data;
end;

class function TSaida.RelatorioEficienciaSeparacao(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  vlDataInicial := ValidarData(pDataInicial, 'Data Inicial');
  vlDataFinal   := ValidarData(pDataFinal, 'Data Final');

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaida.qryRelatorioEficienciaSeparacao.Close;
  dmSaida.qryRelatorioEficienciaSeparacao.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaida.qryRelatorioEficienciaSeparacao.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaida.qryRelatorioEficienciaSeparacao.Open;

  Result := dmSaida.dspRelatorioEficienciaSeparacao.Data;
end;

class function TSaida.RelatorioFaltas(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  vlDataInicial := ValidarData(pDataInicial, 'Data Inicial');
  vlDataFinal   := ValidarData(pDataFinal, 'Data Final');

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaida.qryRelatorioFaltas.Close;
  dmSaida.qryRelatorioFaltas.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaida.qryRelatorioFaltas.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaida.qryRelatorioFaltas.Open;

  Result := dmSaida.dspRelatorioFaltas.Data;
end;

class function TSaida.ProducaoDiaria(pMes, PAno: Integer): OleVariant;
begin

  dmSaida.QryProducaoDiaria.Close;
  dmSaida.QryProducaoDiaria.Parameters.ParamByName('pMes').Value := pMes;
  dmSaida.QryProducaoDiaria.Parameters.ParamByName('pAno').Value := pAno;
  dmSaida.QryProducaoDiaria.Open;

  Result := dmSaida.dspProducaoDiaria.Data;
end;

class function TSaida.ProdDiaItem(pMes, PAno: Integer): OleVariant;
begin

  dmSaida.QryProdDiaItem.Close;
  dmSaida.QryProdDiaItem.Parameters.ParamByName('pMes').Value := pMes;
  dmSaida.QryProdDiaItem.Parameters.ParamByName('pAno').Value := pAno;
  dmSaida.QryProdDiaItem.Open;

  Result := dmSaida.dspProdDiaItem.Data;
end;

class function TSaida.ProducaoDiariaExcl(pMes, PAno: Integer): OleVariant;
begin
  dmSaida.QryProducaoDiariaExcl.Close;
  dmSaida.QryProducaoDiariaExcl.Parameters.ParamByName('pMes').Value := pMes;
  dmSaida.QryProducaoDiariaExcl.Parameters.ParamByName('pAno').Value := pAno;
  dmSaida.QryProducaoDiariaExcl.Open;

  Result := dmSaida.dspProducaoDiariaExcl.Data;
end;

class function TSaida.ProdutoSemPicking(Saida: Integer): Boolean;
begin
  With DmSaida.QryProdutoSemPicking do Begin
    Close;
    Parameters.ParamByName('pCdSaida').Value := Saida;
    Open;
    Result := IsEmpty();
  End;
end;

class function TSaida.RelatorioProdutividadeGeral(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  vlDataInicial := ValidarData(pDataInicial, 'Data Inicial');
  vlDataFinal   := ValidarData(pDataFinal, 'Data Final');

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaida.qryRelatorioProdutividadeGeral.Close;
  dmSaida.qryRelatorioProdutividadeGeral.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaida.qryRelatorioProdutividadeGeral.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  DmSaida.qryRelatorioProdutividadeGeral.Sql.SaveToFile('IndicadorProdu.Txt');
  dmSaida.qryRelatorioProdutividadeGeral.Open;

  Result := dmSaida.dspRelatorioProdutividadeGeral.Data;
end;

class function TSaida.RelatorioProdutividadeIndividual(pCodigoUsuario, pTipo: Integer): OleVariant;
begin
  case pTipo of
    0: // No Dia
      begin
        dmSaida.qryRelatorioProdutividadeIndividualNoDia.Close;
        dmSaida.qryRelatorioProdutividadeIndividualNoDia.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
        dmSaida.qryRelatorioProdutividadeIndividualNoDia.Open;

        Result := dmSaida.dspRelatorioProdutividadeIndividualNoDia.Data;
      end;

    1: // No Mês
      begin
        dmSaida.qryRelatorioProdutividadeIndividualNoMes.Close;
        dmSaida.qryRelatorioProdutividadeIndividualNoMes.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
        dmSaida.qryRelatorioProdutividadeIndividualNoMes.Open;

        Result := dmSaida.dspRelatorioProdutividadeIndividualNoMes.Data;
      end;

    2: // No Ano
      begin
        dmSaida.qryRelatorioProdutividadeIndividualNoAno.Close;
        dmSaida.qryRelatorioProdutividadeIndividualNoAno.Parameters.ParamByName('pCdUsuario').Value := pCodigoUsuario;
        dmSaida.qryRelatorioProdutividadeIndividualNoAno.Open;

        Result := dmSaida.dspRelatorioProdutividadeIndividualNoAno.Data;
      end;
  end;
end;

class function TSaida.RelatorioProdutividadeSeparacao(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  vlDataInicial := ValidarData(pDataInicial, 'Data Inicial');
  vlDataFinal   := ValidarData(pDataFinal, 'Data Final');

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaida.qryRelatorioProdutividadeSeparacao.Close;
  dmSaida.qryRelatorioProdutividadeSeparacao.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaida.qryRelatorioProdutividadeSeparacao.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaida.qryRelatorioProdutividadeSeparacao.Open;

  Result := dmSaida.dspRelatorioProdutividadeSeparacao.Data;
end;

class function TSaida.RelatorioReconferencia(pDataInicial, pDataFinal: string; pCdUsuario : String = '%'; pEndSetor : Integer = 0): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  vlDataInicial := ValidarData(pDataInicial, 'Data Inicial');
  vlDataFinal   := ValidarData(pDataFinal, 'Data Final');

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaida.qryRelatorioReconferencia.Close;
  dmSaida.qryRelatorioReconferencia.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaida.qryRelatorioReconferencia.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaida.qryRelatorioReconferencia.Parameters.ParamByName('pCdUsuario').Value   := pCdUsuario;
  dmSaida.qryRelatorioReconferencia.Parameters.ParamByName('pCdEnderecoSetor').Value   := pEndSetor;
  dmSaida.qryRelatorioReconferencia.Open;
  Result := dmSaida.dspRelatorioReconferencia.Data;
end;

class function TSaida.RelatorioSaidaPorProduto(pCodigoProduto: Int64; pCodigoLote, pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  vlDataInicial := ValidarData(pDataInicial, 'Data Inicial');
  vlDataFinal   := ValidarData(pDataFinal, 'Data Final');

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  ValidarParametroTexto(pCodigoLote);

  dmSaida.qryRelatorioSaidaPorProduto.Close;
  dmSaida.qryRelatorioSaidaPorProduto.Parameters.ParamByName('pCdProduto').Value   := pCodigoProduto;
  dmSaida.qryRelatorioSaidaPorProduto.Parameters.ParamByName('pCdLote').Value      := pCodigoLote;
  dmSaida.qryRelatorioSaidaPorProduto.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaida.qryRelatorioSaidaPorProduto.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaida.qryRelatorioSaidaPorProduto.Open;

  Result := dmSaida.dspRelatorioSaidaPorProduto.Data;
end;

procedure TSaida.setCarga(pCarga: TCarga);
begin
  FreeAndNil(FCarga);

  FCarga := pCarga;

  if (Assigned(FCarga) = True) then
    begin
      FCodigoCarga := FCarga.Codigo;
    end
  else
    begin
      FCodigoCarga := 0;
    end;
end;

procedure TSaida.setCliente(pCliente: TCliente);
begin
  FreeAndNil(FCliente);

  FCliente := pCliente;

  if (Assigned(FCliente) = True) then
    begin
      FCodigoCliente := FCliente.Codigo;
    end
  else
    begin
      FCodigoCliente := 0;
    end;
end;

class procedure TSaida.VerificarPendenciasCrossDocking;
begin
  dmSaida.qryVerificarPendenciasCrossDocking.Close;
  dmSaida.qryVerificarPendenciasCrossDocking.Open;

  if (dmSaida.qryVerificarPendenciasCrossDocking.IsEmpty = False) then
    begin
      raise Exception.Create('Operação inválida!' + sLineBreak +
                             'Existem ' + FloatToStrF(dmSaida.qryVerificarPendenciasCrossDocking.RecordCount, ffNumber, 15, 0) +
                             ' Saídas com a separação pendente. Finalize essas separações antes de processar novas Saídas.');
    end;
end;

class function TSaidaStatus.Listar: OleVariant;
begin
  dmSaida.qryListarSaidaStatus.Close;
  dmSaida.qryListarSaidaStatus.Open;

  Result := dmSaida.dspListarSaidaStatus.Data;
end;

class function TSaidaTipo.ListarTipos: OleVariant;
begin
  dmSaida.qryListarSaidaTipo.Close;
  dmSaida.qryListarSaidaTipo.Open;

  Result := dmSaida.dspListarSaidaTipo.Data;
end;

end.
