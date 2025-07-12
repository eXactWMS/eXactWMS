unit uTCarga;

interface

uses uTRota, uTMotorista, uTCaminhao, uTHistorico, FireDAC.Comp.Client, System.Classes,
  Dialogs, uDmCadastroGeral, System.SysUtils, System.Variants;

type
  TCargaStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

  TCarga = class
  private
    FCodigo: Integer;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FDataExpedicao: TDateTime;
    FCodigoRota: Integer;
    FCodigoMotorista: Integer;
    FCodigoCaminhao: Integer;
    FRota: TRota;
    FMotorista: TMotorista;
    FCaminhao: TCaminhao;
    FStatus: TCargaStatus;
    FVolumeCaminhao: Int64;
    FCapacidadeCaminhao: Int64;
    FVolumeCarga: Int64;
    FPesoCarga: Int64;

    function  getRota: TRota;
    function  getMotorista: TMotorista;
    function  getCaminhao: TCaminhao;
    procedure setCaminhao(pCaminhao: TCaminhao);
    procedure setMotorista(pMotorista: TMotorista);
    procedure setStatus(pStatus: TCargaStatus);
    procedure setRota(pRota: TRota);

    procedure AlterarStatus(pCodigoStatus: Integer; pHistorico: THistorico);
    procedure AlterarStatusSaidas(pCodigoStatus: Integer; pHistorico: THistorico);
    procedure LimparConferencia;
    procedure RegistrarVolumePeso;
    procedure SalvarClientes(pClientes: OleVariant);
    procedure SalvarSaidas(pSaidas: OleVariant);
    procedure SalvarSetores(pSetores: OleVariant);
    procedure SalvarTipos(pTipos: OleVariant);
    procedure ValidarDados(pCodigoRota, pCodigoMotorista, pCodigoCaminhao: Integer);
  public
    property Codigo: Integer            read FCodigo              write FCodigo;
    property DataInicial: TDateTime     read FDataInicial         write FDataInicial;
    property DataFinal: TDateTime       read FDataFinal           write FDataFinal;
    property DataExpedicao: TDateTime   read FDataExpedicao       write FDataExpedicao;
    property Rota: TRota                read getRota              write setRota;
    property Motorista: TMotorista      read getMotorista         write setMotorista;
    property Caminhao: TCaminhao        read getCaminhao          write setCaminhao;
    property Status: TCargaStatus       read FStatus              write setStatus;
    property VolumeCaminhao: Int64      read FVolumeCaminhao      write FVolumeCaminhao;
    property CapacidadeCaminhao: Int64  read FCapacidadeCaminhao  write FCapacidadeCaminhao;
    property VolumeCarga: Int64         read FVolumeCarga         write FVolumeCarga;
    property PesoCarga: Int64           read FPesoCarga           write FPesoCarga;

    destructor Destroy; override;

    class function  AcompanharCarregamento: OleVariant;
    class function  AcompanharCarregamentoCarga(pCodigo: Integer): OleVariant;
    class function  AcompanharCarregamentoCliente(pCodigo: Integer): OleVariant;
    class function  AcompanharCarregamentoRota(pCodigo: Integer): OleVariant;
    class function  AcompanharCarregamentoSaida(pCodigo: Integer): OleVariant;
    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function  PegarCarga(pCodigo: Integer): TCarga;
    class function  Pesquisar(pCodigo, pData, pCodigoRota, pMotorista, pCaminhao, pPlaca, pTransportadora: string; pCdStatus : Integer): OleVariant;
    class function  RelatorioProdutividade(pDataInicial, pDataFinal: string): OleVariant;
    class function  RelatorioCargaStatus(pCodigo, pData, pCodigoRota, pMotorista, pCaminhao, pPlaca, pTransportadora: string): OleVariant; //; pDataCarga : TDateTime

    procedure AtualizarStatus;
    procedure CancelarCarregamento(pHistorico: THistorico);
    procedure CancelarConferencia(pHistorico: THistorico);
    procedure CarregarVolume(pCodigoVolume: Int64; pHistorico: THistorico);
    procedure ConferirVolume(pCodigoVolume: Int64; pHistorico: THistorico);
    function  FiltrarSaidas(pCodigoRota: Integer; pTipos, pSetores, pClientes: OleVariant; pDataInicial, pDataFinal: TDateTime): OleVariant;
    function  ListarClientes(pAtivo: string): OleVariant;
    function  ListarClientesRegistroEntrega: OleVariant;
    function  ListarSaidas: OleVariant;
    function  ListarSaidasConferencia(pCodigoCliente: Integer): OleVariant;
    function  ListarSetores: OleVariant;
    function  ListarTiposSaida: OleVariant;
    procedure RegistrarConferencia(pCodigoStatus: Integer; pHistorico: THistorico);
    procedure RegistrarEntrega(pClientes: OleVariant; pHistorico: THistorico);
    procedure RegistrarSaida(pHistorico: THistorico);
    procedure Salvar(pCodigoRota, pCodigoMotorista, pCodigoCaminhao: Integer; pTipos, pSetores, pClientes, pSaidas: OleVariant; pHistorico: THistorico);
    procedure ValidarConferencia;
  end;

implementation

{ TCarga }

uses uDmCarga, DBClient, DB, uTTransportadora, uTSaida, uFuncoes;

class function TCarga.AcompanharCarregamento: OleVariant;
begin
  dmCarga.qryAcompanharCarregamento.Close;
  dmCarga.qryAcompanharCarregamento.Open;

  Result := dmCarga.dspAcompanharCarregamento.Data;
end;

class function TCarga.AcompanharCarregamentoCarga(pCodigo: Integer): OleVariant;
begin
  dmCarga.qryAcompanharCarregamentoCarga.Close;
  dmCarga.qryAcompanharCarregamentoCarga.Parameters.ParamByName('pCdCarga').Value := pCodigo;
  dmCarga.qryAcompanharCarregamentoCarga.Open;

  Result := dmCarga.dspAcompanharCarregamentoCarga.Data;
end;

class function TCarga.AcompanharCarregamentoCliente(pCodigo: Integer): OleVariant;
begin
  dmCarga.qryAcompanharCarregamentoCliente.Close;
  dmCarga.qryAcompanharCarregamentoCliente.Parameters.ParamByName('pCdCliente').Value := pCodigo;
  dmCarga.qryAcompanharCarregamentoCliente.Open;

  Result := dmCarga.dspAcompanharCarregamentoCliente.Data;
end;

class function TCarga.AcompanharCarregamentoRota(pCodigo: Integer): OleVariant;
begin
  dmCarga.qryAcompanharCarregamentoRota.Close;
  dmCarga.qryAcompanharCarregamentoRota.Parameters.ParamByName('pCdRota').Value := pCodigo;
  dmCarga.qryAcompanharCarregamentoRota.Open;

  Result := dmCarga.dspAcompanharCarregamentoRota.Data;
end;

class function TCarga.AcompanharCarregamentoSaida(pCodigo: Integer): OleVariant;
begin
  dmCarga.qryAcompanharCarregamentoSaida.Close;
  dmCarga.qryAcompanharCarregamentoSaida.Parameters.ParamByName('pCdSaida').Value := pCodigo;
  dmCarga.qryAcompanharCarregamentoSaida.Open;

  Result := dmCarga.dspAcompanharCarregamentoSaida.Data;
end;

procedure TCarga.AlterarStatus(pCodigoStatus: Integer; pHistorico: THistorico);
var
  vlTransacaoInterna: Boolean;
begin
  vlTransacaoInterna := False;

  try
    if (dmCarga.qryAlterarStatus.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmCarga.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
        dmCarga.qryAlterarStatus.Connection.BeginTrans;
      end;

    dmCarga.qryAlterarStatus.Close;
    dmCarga.qryAlterarStatus.Parameters.ParamByName('pCdCargaStatus').Value := pCodigoStatus;
    dmCarga.qryAlterarStatus.Parameters.ParamByName('pCdCarga').Value       := FCodigo;
    dmCarga.qryAlterarStatus.ExecSQL;

    case pCodigoStatus of
      2: pHistorico.Observacao := 'Conferência da Carga inicializada';
      3: pHistorico.Observacao := 'Conferência da Carga finalizada';
      4: pHistorico.Observacao := 'Carregamento da Carga inicializado';
      5: pHistorico.Observacao := 'Carregamento da Carga finalizado';
      6: pHistorico.Observacao := 'Carga em trânsito';
      7: pHistorico.Observacao := 'Carga entregue';
    end;

    pHistorico.CodigoRegistro := FCodigo;
    pHistorico.CodigoFuncao   := 29; // 29 - Cadastrar Carga
    pHistorico.Salvar;

    if (vlTransacaoInterna = True) then
      begin
        dmCarga.qryAlterarStatus.Connection.CommitTrans;
      end;
  except on E: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmCarga.qryAlterarStatus.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.AlterarStatusSaidas(pCodigoStatus: Integer; pHistorico: THistorico);
var
//  QryMemSaidas: TFdMemTable;
  vlSaidas: TClientDataSet;
  vlSaida: TSaida;
  xCodSql : tStringList;
begin
  vlSaidas := TClientDataSet.Create(nil);

  try
    vlSaidas.Close;
    vlSaidas.Data := ListarSaidas;

    vlSaidas.First;
    while (vlSaidas.Eof = False) do
      begin
        vlSaida := TSaida.PegarSaida(vlSaidas.FieldByName('cdSaida').AsLargeInt);

        case pCodigoStatus of
          7: vlSaida.RegistrarEmExpedicao(pHistorico);  // 7  = Em Expedição
          8: vlSaida.RegistrarCarregamento(pHistorico); // 8  = Carregado
          9: vlSaida.RegistrarEmTransito(pHistorico);   // 9  = Em Trânsito
        end;

        FreeAndNil(vlSaida);
        vlSaidas.Next;
      end;
  finally
    FreeAndNil(vlSaidas);
  end;
end;

procedure TCarga.AtualizarStatus;
begin
  dmCarga.qryAtualizarStatus.Close;
  dmCarga.qryAtualizarStatus.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryAtualizarStatus.Open;

  if (Assigned(FStatus) = False) then
    begin
      FStatus := TCargaStatus.Create;
    end;

  FStatus.Codigo := dmCarga.qryAtualizarStatus.FieldByName('cdCargaStatus').AsInteger;
  FStatus.Nome   := dmCarga.qryAtualizarStatus.FieldByName('nmCargaStatus').AsString;
end;

procedure TCarga.CancelarCarregamento(pHistorico: THistorico);
begin
  dmCarga.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmCarga.qryAlterarStatus.Connection.BeginTrans;

  try
    AtualizarStatus;

    case FStatus.Codigo of
      4: // Carregando
        begin
          LimparConferencia;
        end;

      5, 6, 7: // Carregada (5), Em Trânsito (6), Entregue (7)
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Esta Carga já foi Carregada/Finalizada.');
        end;
    end;

    pHistorico.Observacao := 'Carregamento da Carga cancelado';

    AlterarStatus(1, pHistorico);

    dmCarga.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmCarga.qryAlterarStatus.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.CancelarConferencia(pHistorico: THistorico);
begin
  dmCarga.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmCarga.qryAlterarStatus.Connection.BeginTrans;

  try
    AtualizarStatus;

    case FStatus.Codigo of
      4: // Carregando
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Esta Carga já está sendo Carregada.');
        end;

      5, 6, 7: // Carregada (5), Em Trânsito (6), Entregue (7)
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Esta Carga já foi Carregada/Finalizada.');
        end;
    end;

    pHistorico.Observacao := 'Conferência da Carga cancelada';

    LimparConferencia;
    AlterarStatus(1, pHistorico);

    dmCarga.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmCarga.qryAlterarStatus.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.CarregarVolume(pCodigoVolume: Int64;
  pHistorico: THistorico);
begin
  dmCarga.qryConferirVolume.Close;
  dmCarga.qryConferirVolume.Parameters.ParamByName('pCdCarga').Value  := FCodigo;
  dmCarga.qryConferirVolume.Parameters.ParamByName('pCdVolume').Value := pCodigoVolume;
  dmCarga.qryConferirVolume.Open;

  if (dmCarga.qryConferirVolume.FieldByName('Conferido').AsInteger = 1) then
    begin
      raise Exception.Create('O Volume informado já foi carregado!');
    end;

  if (FStatus.Codigo <> 4) then
    begin
      AlterarStatus(4, pHistorico);
    end;
end;

procedure TCarga.ConferirVolume(pCodigoVolume: Int64; pHistorico: THistorico);
begin
  dmCarga.qryConferirVolume.Close;
  dmCarga.qryConferirVolume.Parameters.ParamByName('pCdCarga').Value  := FCodigo;
  dmCarga.qryConferirVolume.Parameters.ParamByName('pCdVolume').Value := pCodigoVolume;
  dmCarga.qryConferirVolume.Open;

  if (dmCarga.qryConferirVolume.FieldByName('Conferido').AsInteger = 1) then
    begin
      raise Exception.Create('O Volume informado já foi conferido!');
    end;

  if (FStatus.Codigo <> 2) then
    begin
      AlterarStatus(2, pHistorico);
    end;
end;

destructor TCarga.Destroy;
begin
  FreeAndNil(FRota);
  FreeAndNil(FMotorista);
  FreeAndNil(FCaminhao);
  FreeAndNil(FStatus);
  inherited;
end;

class procedure TCarga.Excluir(pCodigo: Integer; pHistorico: THistorico);
var
  vlCarga: TCarga;
begin
  try
    dmCarga.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmCarga.qryExcluir.Connection.BeginTrans;

    dmCarga.qryAtualizarStatus.Close;
    dmCarga.qryAtualizarStatus.Parameters.ParamByName('pCdCarga').Value := pCodigo;
    dmCarga.qryAtualizarStatus.Open;

    case dmCarga.qryAtualizarStatus.FieldByName('cdCargaStatus').AsInteger of
      5: // Carregada (5)
        begin
          vlCarga := TCarga.Create;

          try
            vlCarga.Codigo := pCodigo;
            vlCarga.AlterarStatusSaidas(7, pHistorico); // Retornar os volumes para o status "Em Expedição"
          finally
            FreeAndNil(vlCarga);
          end;
        end;

      6, 7: // Em Trânsito (6), Entregue (7)
        begin
          raise Exception.Create('Operação inválida!' + #13 +
                                 'A Carga selecionada já foi Finalizada e por isto não pode ser excluída.');
        end;
    end;

    dmCarga.qryExcluir.Close;
    dmCarga.qryExcluir.Parameters.ParamByName('pCdCarga').Value := pCodigo;
    dmCarga.qryExcluir.ExecSQL;

    pHistorico.CodigoFuncao   := 29; // 29 = Carga - Cadastrar
    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro da Carga';

    pHistorico.Salvar;

    dmCarga.qryExcluir.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmCarga.qryExcluir.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

function TCarga.FiltrarSaidas(pCodigoRota: Integer; pTipos, pSetores, pClientes: OleVariant;
  pDataInicial, pDataFinal: TDateTime): OleVariant;
var
  vlTipos: TClientDataSet;
  vlSetores: TClientDataSet;
  vlClientes: TClientDataSet;
  vlCondicao: string;
begin
  vlCondicao := '';

  vlClientes := TClientDataSet.Create(nil);

  try
    vlClientes.Close;
    vlClientes.Data := pClientes;

    vlClientes.Filter   := '(Ativo = 1)';
    vlClientes.Filtered := True;

    if (vlClientes.IsEmpty = True) then
      begin
        raise Exception.Create('Operação não permitida!' + #13 +
                               'Selecione pelo menos um Cliente para filtrar as Saídas.');
      end;

    vlCondicao := vlCondicao + ' and sai.cdCliente in (';

    vlClientes.First;
    while (vlClientes.Eof = False) do
      begin
        vlCondicao := vlCondicao + vlClientes.FieldByName('cdCliente').AsString + ', ';
        vlClientes.Next;
      end;

    vlCondicao := vlCondicao + ')';
    vlCondicao := StringReplace(vlCondicao, ', )', ')', [rfReplaceAll]);
  finally
    FreeAndNil(vlClientes);
  end;

  vlTipos := TClientDataSet.Create(nil);

  try
    vlTipos.Close;
    vlTipos.Data := pTipos;

    vlTipos.Filter   := '(Ativo = 1)';
    vlTipos.Filtered := True;

    if (vlTipos.IsEmpty = False) then
      begin
        vlCondicao := vlCondicao + ' and sai.cdSaidaTipo in (';

        vlTipos.First;
        while (vlTipos.Eof = False) do
          begin
            vlCondicao := vlCondicao + vlTipos.FieldByName('cdSaidaTipo').AsString + ', ';
            vlTipos.Next;
          end;

        vlCondicao := vlCondicao + ')';
        vlCondicao := StringReplace(vlCondicao, ', )', ')', [rfReplaceAll]);
      end;
  finally
    FreeAndNil(vlTipos);
  end;

  vlSetores := TClientDataSet.Create(nil);

  try
    vlSetores.Close;
    vlSetores.Data := pSetores;

    vlSetores.Filter   := '(Ativo = 1)';
    vlSetores.Filtered := True;

    if (vlSetores.IsEmpty = False) then
      begin
        vlCondicao := vlCondicao + ' and prd.cdEnderecoSetor in (';

        vlSetores.First;
        while (vlSetores.Eof = False) do
          begin
            vlCondicao := vlCondicao + vlSetores.FieldByName('cdEnderecoSetor').AsString + ', ';
            vlSetores.Next;
          end;

        vlCondicao := vlCondicao + ')';
        vlCondicao := StringReplace(vlCondicao, ', )', ')', [rfReplaceAll]);
      end;
  finally
    FreeAndNil(vlSetores);
  end;

  dmCarga.qryFiltrarSaidas.Close;
  dmCarga.qryFiltrarSaidas.Parameters.ParamByName('pCdCarga').Value   := FCodigo;
  dmCarga.qryFiltrarSaidas.Parameters.ParamByName('pDtInicial').Value := FormatDateTime('yyyy-mm-dd', pDataInicial);
  dmCarga.qryFiltrarSaidas.Parameters.ParamByName('pDtFinal').Value   := FormatDateTime('yyyy-mm-dd', pDataFinal);
  dmCarga.qryFiltrarSaidas.SQL.Strings[37]                            := vlCondicao;
  dmCarga.qryFiltrarSaidas.Prepared                                   := True;
  dmCarga.qryFiltrarSaidas.Open;
  Result := dmCarga.dspFiltrarSaidas.Data;
end;

function TCarga.getCaminhao: TCaminhao;
begin
  if (Assigned(FCaminhao) = False) then
    begin
      setCaminhao(TCaminhao.PegarCaminhao(FCodigoCaminhao));
    end;

  Result := FCaminhao;
end;

function TCarga.getMotorista: TMotorista;
begin
  if (Assigned(FMotorista) = False) then
    begin
      setMotorista(TMotorista.PegarMotorista(FCodigoMotorista));
    end;

  Result := FMotorista;
end;

function TCarga.getRota: TRota;
begin
  if (Assigned(FRota) = False) then
    begin
      setRota(TRota.PegarRota(FCodigoRota));
    end;

  Result := FRota;
end;

procedure TCarga.LimparConferencia;
begin
  dmCarga.qryLimparConferencia.Close;
  dmCarga.qryLimparConferencia.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryLimparConferencia.ExecSQL;
end;

function TCarga.ListarClientes(pAtivo: string): OleVariant;
begin
  if (Trim(pAtivo) = '') then
    begin
      pAtivo := '%';
    end;

  dmCarga.qryListarClientes.Close;
  dmCarga.qryListarClientes.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryListarClientes.Parameters.ParamByName('pAtivo').Value   := pAtivo;
  dmCarga.qryListarClientes.Open;

  Result := dmCarga.dspListarClientes.Data;
end;

function TCarga.ListarClientesRegistroEntrega: OleVariant;
begin
  dmCarga.qryListarClientesRegistroEntrega.Close;
  dmCarga.qryListarClientesRegistroEntrega.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryListarClientesRegistroEntrega.Open;

  Result := dmCarga.dspListarClientesRegistroEntrega.Data;
end;

function TCarga.ListarSaidas: OleVariant;
begin
  dmCarga.qryListarSaidas.Close;
  dmCarga.qryListarSaidas.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryListarSaidas.Open;

  Result := dmCarga.dspListarSaidas.Data;
end;

function TCarga.ListarSaidasConferencia(pCodigoCliente: Integer): OleVariant;
begin
  dmCarga.qryListarSaidasConferencia.Close;
  dmCarga.qryListarSaidasConferencia.Parameters.ParamByName('pCdCarga').Value   := FCodigo;
  dmCarga.qryListarSaidasConferencia.Parameters.ParamByName('pCdCliente').Value := pCodigoCliente;
  dmCarga.qryListarSaidasConferencia.Open;

  Result := dmCarga.dspListarSaidasConferencia.Data;
end;

function TCarga.ListarSetores: OleVariant;
begin
  dmCarga.qryListarSetores.Close;
  dmCarga.qryListarSetores.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryListarSetores.Open;

  Result := dmCarga.dspListarSetores.Data;
end;

function TCarga.ListarTiposSaida: OleVariant;
begin
  dmCarga.qryListarTipos.Close;
  dmCarga.qryListarTipos.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryListarTipos.Open;

  Result := dmCarga.dspListarTipos.Data;
end;

class function TCarga.PegarCarga(pCodigo: Integer): TCarga;
var vlCarga  : TCarga;
    vlStatus : TCargaStatus;
begin
  With DmCarga.qryPegar do Begin
    Close;
    Parameters.ParamByName('pCdCarga').Value := pCodigo;
    Open;
    if (IsEmpty = True) then
      begin
        raise Exception.Create('Código da Carga não encontrado!');
      end;

    //////////// Criação d Objeto Status ////////////////
    vlStatus        := TCargaStatus.Create;
    vlStatus.Codigo := FieldByName('cdCargaStatus').AsInteger;
    vlStatus.Nome   := FieldByName('nmCargaStatus').AsString;
    /////////////////////////////////////////////////////

    vlCarga                    := TCarga.Create;
//    Result                     := TCarga.Create;
    vlCarga.Codigo             := FieldByName('cdCarga').AsInteger;
    vlCarga.DataInicial        := FieldByName('dtInicial').AsDateTime;
    vlCarga.DataFinal          := FieldByName('dtFinal').AsDateTime;
    vlCarga.Status             := vlStatus;
    vlCarga.VolumeCaminhao     := FieldByName('VolumeCaminhao').AsLargeInt;
    vlCarga.CapacidadeCaminhao := FieldByName('CapacidadeCaminhao').AsLargeInt;
    vlCarga.VolumeCarga        := FieldByName('VolumeCarga').AsLargeInt;
    vlCarga.PesoCarga          := FieldByName('PesoCarga').AsLargeInt;

    if (FieldByName('dtExpedicao').IsNull = False) then
        vlCarga.DataExpedicao  := FieldByName('dtExpedicao').AsDateTime
    else vlCarga.DataExpedicao := 0;
    vlCarga.FCodigoRota      := FieldByName('cdRota').AsInteger;
    vlCarga.FCodigoMotorista := FieldByName('cdMotorista').AsInteger;
    vlCarga.FCodigoCaminhao  := FieldByName('cdCaminhao').AsInteger;
//    FreeAndNil(vlStatus);
  End;
  Result := vlCarga;
end;

class function TCarga.Pesquisar(pCodigo, pData, pCodigoRota, pMotorista,
  pCaminhao, pPlaca, pTransportadora: string; pCdStatus : Integer): OleVariant;
begin
  ValidarParametroTexto(pCodigo);

  if (Trim(pCodigo) <> '%') then
    begin
      pData := '';
    end;

  if (Trim(pData) <> '') then
    begin
      try
        pData := ' and ''' + FormatDateTime('yyyy-mm-dd', StrToDate(pData)) + ''' between crg.dtInicial and crg.dtFinal';
      except
        raise Exception.Create('Data inválida!');
      end;
    end;

  ValidarParametroTexto(pCodigoRota);
  ValidarParametroTexto(pMotorista);
  ValidarParametroTexto(pCaminhao);
  ValidarParametroTexto(pPlaca);
  ValidarParametroTexto(pTransportadora);
  With DmCarga.qryPesquisar do Begin
    Close;
    Parameters.ParamByName('pCdCarga').Value        := pCodigo;
    Parameters.ParamByName('pCdRota').Value         := pCodigoRota;
    Parameters.ParamByName('pMotorista').Value      := pMotorista;
    Parameters.ParamByName('pCaminhao').Value       := pCaminhao;
    Parameters.ParamByName('pPlaca').Value          := '%' + pPlaca + '%';
    Parameters.ParamByName('pTransportadora').Value := pTransportadora;
    Parameters.ParamByName('pCdStatus').Value       := pCdStatus;
    SQL.Strings[54]                      := pData; //Estava na linha[44]
    Prepared        := True;
    Open;
  End;
  Result := dmCarga.dspPesquisar.Data;
end;

procedure TCarga.RegistrarConferencia(pCodigoStatus: Integer; pHistorico: THistorico);
begin
  dmCarga.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmCarga.qryAlterarStatus.Connection.BeginTrans;

  try
    AtualizarStatus;

    if (pCodigoStatus = 3) then // 3 = Conferida
      begin
        if (FStatus.Codigo = 4) then
          begin
            raise Exception.Create('Operação não permitida!' + #13 +
                                   'Esta Carga já está sendo Carregada!');
          end;
      end;

    if (FStatus.Codigo in [5, 6, 7]) then // Carregada (5), Em Trânsito (6), Entregue (7)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Esta Carga já foi Carregada/Finalizada por outro Usuário.');
      end;

    if (pCodigoStatus = 5) then // 5 = Carregada
      begin
        AlterarStatusSaidas(8, pHistorico); // 8 = Carregada
        RegistrarVolumePeso;
      end;

    LimparConferencia;
    AlterarStatus(pCodigoStatus, pHistorico);

    dmCarga.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmCarga.qryAlterarStatus.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.RegistrarEntrega(pClientes: OleVariant; pHistorico: THistorico);
var
  vlClientes: TClientDataSet;
  vlSaidas: TClientDataSet;
  vlSaida: TSaida;
begin
  dmCarga.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmCarga.qryAlterarStatus.Connection.BeginTrans;

  try
    vlClientes := TClientDataSet.Create(nil);
    vlSaidas   := TClientDataSet.Create(nil);

    try
      vlClientes.Close;
      vlClientes.Data := pClientes;

      vlSaidas.Close;
      vlSaidas.Data := ListarSaidas;

      vlSaidas.First;
      while (vlSaidas.Eof = False) do
        begin
          vlSaida := TSaida.PegarSaida(vlSaidas.FieldByName('cdSaida').AsLargeInt);

          try
            vlClientes.Locate('cdCliente', vlSaida.Cliente.Codigo, []);

            pHistorico.DataHora := vlClientes.FieldByName('DtEntrega').AsDateTime;

            vlSaida.RegistrarEntrega(pHistorico);
            vlSaidas.Next;
          finally
            FreeAndNil(vlSaida);
          end;
        end;
    finally
      FreeAndNil(vlSaidas);
      FreeAndNil(vlClientes);
    end;

    AlterarStatus(7, pHistorico); // 7 = Entregue

    dmCarga.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmCarga.qryAlterarStatus.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.RegistrarSaida(pHistorico: THistorico);
begin
  dmCarga.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmCarga.qryAlterarStatus.Connection.BeginTrans;

  try
    AtualizarStatus;     //Ok

    if (FStatus.Codigo in [6, 7]) then // Em Trânsito (6), Entregue (7)
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Esta Carga já foi Finalizada por outro Usuário.');
      end;

    AlterarStatusSaidas(9, pHistorico); // 9 = Volumes Em Trânsito
    AlterarStatus(6, pHistorico);       // 6 = Carga Em Trânsito

    dmCarga.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmCarga.qryAlterarStatus.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.RegistrarVolumePeso;
begin
  With dmCarga.qryRegistrarVolumePeso do Begin
    Close;
    Parameters.ParamByName('pCdCarga').Value := Self.Codigo;
    ExecSQL;
  End;
end;

class function TCarga.RelatorioCargaStatus(pCodigo, pData, pCodigoRota,
  pMotorista, pCaminhao, pPlaca, pTransportadora: string): OleVariant;
//  pDataCarga: TDateTime): OleVariant;
begin
  ValidarParametroTexto(pCodigo);

  if (Trim(pCodigo) <> '%') then
    begin
      pData := '';
    end;

  if (Trim(pData) <> '') then begin
      try
        pData := FormatDateTime('yyyy-mm-dd', StrToDate(pData));
      except
        raise Exception.Create('Data inválida!');
      end;
  end;
  ValidarParametroTexto(pCodigoRota);
  ValidarParametroTexto(pMotorista);
  ValidarParametroTexto(pCaminhao);
  ValidarParametroTexto(pPlaca);
  ValidarParametroTexto(pTransportadora);
  With DmCarga.QryRelatorioCargaStatus do Begin
    Close;
    Parameters.ParamByName('pCdCarga').Value        := pCodigo;
    Parameters.ParamByName('pCdRota').Value         := pCodigoRota;
    Parameters.ParamByName('pMotorista').Value      := pMotorista;
    Parameters.ParamByName('pCaminhao').Value       := pCaminhao;
    Parameters.ParamByName('pPlaca').Value          := '%' + pPlaca + '%';
    Parameters.ParamByName('pTransportadora').Value := pTransportadora;
    if pData <> '' then
       Parameters.ParamByName('pDataCarga').Value      := pData
    Else
       Parameters.ParamByName('pDataCarga').Value      := Null;
    Prepared        := True;
    Open;
  End;
  Result := dmCarga.DspRelatorioCargaStatus.Data;
end;

class function TCarga.RelatorioProdutividade(pDataInicial, pDataFinal: string): OleVariant;
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

  dmCarga.qryRelatorioProdutividade.Close;
  dmCarga.qryRelatorioProdutividade.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmCarga.qryRelatorioProdutividade.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmCarga.qryRelatorioProdutividade.Open;

  Result := dmCarga.dspRelatorioProdutividade.Data;
end;

procedure TCarga.Salvar(pCodigoRota, pCodigoMotorista, pCodigoCaminhao: Integer;
  pTipos, pSetores, pClientes, pSaidas: OleVariant; pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados(pCodigoRota, pCodigoMotorista, pCodigoCaminhao);

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de nova Carga';
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Cadastro da Carga';
    end;

  vlCodigo := FCodigo;

  try
    dmCarga.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmCarga.qrySalvar.Connection.BeginTrans;

    dmCarga.qrySalvar.Close;
    dmCarga.qrySalvar.Parameters.ParamByName('pCdCarga').Value     := FCodigo;
    dmCarga.qrySalvar.Parameters.ParamByName('pCdRota').Value      := FCodigoRota;
    dmCarga.qrySalvar.Parameters.ParamByName('pCdMotorista').Value := FCodigoMotorista;
    dmCarga.qrySalvar.Parameters.ParamByName('pCdCaminhao').Value  := FCodigoCaminhao;
    dmCarga.qrySalvar.Parameters.ParamByName('pDtInicial').Value   := FormatDateTime('yyyy-mm-dd', FDataInicial);
    dmCarga.qrySalvar.Parameters.ParamByName('pDtFinal').Value     := FormatDateTime('yyyy-mm-dd', FDataFinal);
    dmCarga.qrySalvar.Open;

    FCodigo := dmCarga.qrySalvar.FieldByName('cdCarga').AsInteger;

    AtualizarStatus;
    SalvarTipos(pTipos);
    SalvarSetores(pSetores);
    SalvarClientes(pClientes);
    SalvarSaidas(pSaidas);

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmCarga.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmCarga.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCarga.SalvarClientes(pClientes: OleVariant);
var
  vlClientes: TClientDataSet;
begin
  dmCarga.qryLimparClientes.Close;
  dmCarga.qryLimparClientes.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryLimparClientes.ExecSQL;

  vlClientes := TClientDataSet.Create(nil);
  try
    vlClientes.Close;
    vlClientes.Data := pClientes;

    vlClientes.Filter   := '(Ativo = 1)';
    vlClientes.Filtered := True;

    vlClientes.First;
    while (vlClientes.Eof = False) do
      begin
        dmCarga.qryInserirCliente.Close;
        dmCarga.qryInserirCliente.Parameters.ParamByName('pCdCarga').Value   := FCodigo;
        dmCarga.qryInserirCliente.Parameters.ParamByName('pCdCliente').Value := vlClientes.FieldByName('cdCliente').AsInteger;
        dmCarga.qryInserirCliente.ExecSQL;

        vlClientes.Next;
      end;
  finally
    FreeAndNil(vlClientes);
  end;
end;

procedure TCarga.SalvarSaidas(pSaidas: OleVariant);
var
  vlSaidas: TClientDataSet;
begin
  dmCarga.qryLimparSaidas.Close;
  dmCarga.qryLimparSaidas.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryLimparSaidas.ExecSQL;

  vlSaidas := TClientDataSet.Create(nil);
  try
    vlSaidas.Close;
    vlSaidas.Data := pSaidas;

    vlSaidas.Filter   := '(Ativo = 1)';
    vlSaidas.Filtered := True;

    if (vlSaidas.IsEmpty = True) then
      begin
        raise Exception.Create('Operação inválida!' + #13 +
                               'Selecione pelo menos 01 (um) pedido para fazer parte da Carga.');
      end;

    vlSaidas.First;
    while (vlSaidas.Eof = False) do
      begin
        dmCarga.qryInserirSaida.Close;
        dmCarga.qryInserirSaida.Parameters.ParamByName('pCdCarga').Value := FCodigo;
        dmCarga.qryInserirSaida.Parameters.ParamByName('pCdSaida').Value := vlSaidas.FieldByName('cdSaida').AsInteger;
        dmCarga.qryInserirSaida.ExecSQL;

        vlSaidas.Next;
      end;
  finally
    FreeAndNil(vlSaidas);
  end;
end;

procedure TCarga.SalvarSetores(pSetores: OleVariant);
var
  vlSetores: TClientDataSet;
begin
  dmCarga.qryLimparSetores.Close;
  dmCarga.qryLimparSetores.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryLimparSetores.ExecSQL;

  vlSetores := TClientDataSet.Create(nil);
  try
    vlSetores.Close;
    vlSetores.Data := pSetores;

    vlSetores.Filter   := '(Ativo = 1)';
    vlSetores.Filtered := True;

    vlSetores.First;
    while (vlSetores.Eof = False) do
      begin
        dmCarga.qryInserirSetor.Close;
        dmCarga.qryInserirSetor.Parameters.ParamByName('pCdCarga').Value         := FCodigo;
        dmCarga.qryInserirSetor.Parameters.ParamByName('pCdEnderecoSetor').Value := vlSetores.FieldByName('cdEnderecoSetor').AsInteger;
        dmCarga.qryInserirSetor.ExecSQL;

        vlSetores.Next;
      end;
  finally
    FreeAndNil(vlSetores);
  end;
end;

procedure TCarga.SalvarTipos(pTipos: OleVariant);
var
  vlTipos: TClientDataSet;
begin
  dmCarga.qryLimparTipos.Close;
  dmCarga.qryLimparTipos.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryLimparTipos.ExecSQL;

  vlTipos := TClientDataSet.Create(nil);
  try
    vlTipos.Close;
    vlTipos.Data := pTipos;

    vlTipos.Filter   := '(Ativo = 1)';
    vlTipos.Filtered := True;

    vlTipos.First;
    while (vlTipos.Eof = False) do
      begin
        dmCarga.qryInserirTipo.Close;
        dmCarga.qryInserirTipo.Parameters.ParamByName('pCdCarga').Value     := FCodigo;
        dmCarga.qryInserirTipo.Parameters.ParamByName('pCdSaidaTipo').Value := vlTipos.FieldByName('cdSaidaTipo').AsInteger;
        dmCarga.qryInserirTipo.ExecSQL;

        vlTipos.Next;
      end;
  finally
    FreeAndNil(vlTipos);
  end;
end;

procedure TCarga.setCaminhao(pCaminhao: TCaminhao);
begin
  FreeAndNil(FCaminhao);

  FCaminhao := pCaminhao;

  if (Assigned(FCaminhao) = True) then
    begin
      FCodigoCaminhao := FCaminhao.Codigo;
    end
  else
    begin
      FCodigoCaminhao := 0;
    end;
end;

procedure TCarga.setMotorista(pMotorista: TMotorista);
begin
  FreeAndNil(FMotorista);

  FMotorista := pMotorista;

  if (Assigned(FMotorista) = True) then
    begin
      FCodigoMotorista := FMotorista.Codigo;
    end
  else
    begin
      FCodigoMotorista := 0;
    end;
end;

procedure TCarga.setRota(pRota: TRota);
begin
  FreeAndNil(FRota);

  FRota := pRota;

  if (Assigned(FRota) = True) then
    begin
      FCodigoRota := FRota.Codigo;
    end
  else
    begin
      FCodigoRota := 0;
    end;
end;

procedure TCarga.setStatus(pStatus: TCargaStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

procedure TCarga.ValidarConferencia;
begin
  dmCarga.qryValidarConferencia.Close;
  dmCarga.qryValidarConferencia.Parameters.ParamByName('pCdCarga').Value := FCodigo;
  dmCarga.qryValidarConferencia.Open;

  if (dmCarga.qryValidarConferencia.IsEmpty = False) then
    begin
      raise Exception.Create('Operação não permitida!' + #13 +
                             'A Carga não foi totalmente conferida.');
    end;
end;

procedure TCarga.ValidarDados(pCodigoRota, pCodigoMotorista, pCodigoCaminhao: Integer);
begin
  ////////// Validar Rota /////////////
  try
    Rota := TRota.PegarRota(pCodigoRota);
  except
    raise Exception.CreateHelp('Rota não encontrada!' + #13 +
                               'A Rota selecionada não existe ou foi excluída. Selecione outra Rota para continuar o cadastro.', 1);
  end;

  if (Rota.Status.Codigo = 2) then // 2 = Rota Inativa
    begin
      raise Exception.CreateHelp('Rota inválida!' + #13 +
                                 'A Rota selecionada foi inativada. Selecione outra Rota para continuar o cadastro.', 1);
    end;
  //////////////////////////////////////////////


  ////////// Validar Motorista /////////////
  try
    Motorista := TMotorista.PegarMotorista(pCodigoMotorista);
  except
    raise Exception.CreateHelp('Motorista não encontrado!' + #13 +
                               'O Motorista selecionado não existe ou foi excluído. Selecione outro Motorista para continuar o cadastro.', 2);
  end;

  if (Motorista.Status.Codigo = 2) then // 2 = Motorista Inativo
    begin
      raise Exception.CreateHelp('Motorista inválido!' + #13 +
                                 'O Motorista selecionado foi inativado. Selecione outro Motorista para continuar o cadastro.', 2);
    end;
  //////////////////////////////////////////////

  ////////// Validar Caminhão /////////////
  try
    Caminhao := TCaminhao.PegarCaminhao(pCodigoCaminhao);
  except
    raise Exception.CreateHelp('Caminhão não encontrado!' + #13 +
                               'O Caminhão selecionado não existe ou foi excluído. Selecione outro Caminhão para continuar o cadastro.', 3);
  end;

  if (Caminhao.Status.Codigo = 2) then // 2 = Caminhão Inativo
    begin
      raise Exception.CreateHelp('Caminhão inválido!' + #13 +
                                 'O Caminhão selecionado foi inativado. Selecione outro Caminhão para continuar o cadastro.', 3);
    end;
  //////////////////////////////////////////////
end;

class function TCargaStatus.ListarStatus: OleVariant;
begin
  dmCarga.qryListarCargaStatus.Close;
  dmCarga.qryListarCargaStatus.Open;

  Result := dmCarga.dspListarCargaStatus.Data;
end;

end.
