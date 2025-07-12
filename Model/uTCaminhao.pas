unit uTCaminhao;

interface

uses uTTransportadora, uTHistorico;

type
  TCaminhaoStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarStatus: OleVariant;
  end;

  TCaminhao = class
  private
    FCodigo: Integer;
    FNome: string;
    FPlaca: string;
    FAltura: Single;
    FLargura: Single;
    FComprimento: Single;
    FVolume: Int64;
    FAproveitamento: Integer;
    FCapacidade: Int64;
    FStatus: TCaminhaoStatus;
    FCodigoTransportadora: Integer;
    FTransportadora: TTransportadora;

    function  getTransportadra: TTransportadora;
    procedure setStatus(pStatus: TCaminhaoStatus);
    procedure setTransportadora(pTransportadora: TTransportadora);
    procedure ValidarDados;
  public
    property Codigo: Integer                  read FCodigo          write FCodigo;
    property Nome: string                     read FNome            write FNome;
    property Placa: string                    read FPlaca           write FPlaca;
    property Altura: Single                   read FAltura          write FAltura;
    property Largura: Single                  read FLargura         write FLargura;
    property Comprimento: Single              read FComprimento     write FComprimento;
    property Volume: Int64                    read FVolume;
    property Aproveitamento: Integer          read FAproveitamento  write FAproveitamento;
    property Capacidade: Int64                read FCapacidade      write FCapacidade;
    property Status: TCaminhaoStatus          read FStatus          write setStatus;
    property Transportadora: TTransportadora  read getTransportadra write setTransportadora;

    destructor Destroy; override;

    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function PegarCaminhao(pCodigo: Integer): TCaminhao;
    class function Pesquisar(pCodigo, pNome, pPlaca, pStatus, pCodigoTransportadora: string): OleVariant;

    function  CalcularVolume(pAltura, pLargura, pComprimento: Single): Int64;
    procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses SysUtils, DBClient, DB, uDmCaminhao, uFuncoes;

{ TCaminhao }

function TCaminhao.CalcularVolume(pAltura, pLargura, pComprimento: Single): Int64;
begin
  Result := Trunc(pAltura * pLargura * pComprimento);
end;

destructor TCaminhao.Destroy;
begin
  FreeAndNil(Self.FStatus);
  FreeAndNil(Self.FTransportadora);

  inherited;
end;

class procedure TCaminhao.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmCaminhao.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmCaminhao.qryExcluir.Connection.BeginTrans;

    dmCaminhao.qryExcluir.Close;
    dmCaminhao.qryExcluir.Parameters.ParamByName('pCdCaminhao').Value := pCodigo;
    dmCaminhao.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro do Caminhão';

    pHistorico.Salvar;

    dmCaminhao.qryExcluir.Connection.CommitTrans;
  except
    dmCaminhao.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste caminhão.');
  end;
end;

function TCaminhao.getTransportadra: TTransportadora;
begin
  if (Assigned(Self.FTransportadora) = False) and (Self.FCodigoTransportadora > 0) then
    begin
      setTransportadora(TTransportadora.PegarTransportadora(Self.FCodigoTransportadora));
    end;

  Result := Self.FTransportadora;
end;

class function TCaminhao.PegarCaminhao(pCodigo: Integer): TCaminhao;
var
  vlCaminhao: TCaminhao;
  vlStatus: TCaminhaoStatus;
begin
  dmCaminhao.qryPegar.Close;
  dmCaminhao.qryPegar.Parameters.ParamByName('pCdCaminhao').Value := pCodigo;
  dmCaminhao.qryPegar.Open;

  if (dmCaminhao.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Caminhão não encontrado!');
    end;

  /////////// Criação do Objeto Status ///////////
  vlStatus        := TCaminhaoStatus.Create;
  vlStatus.Codigo := dmCaminhao.qryPegar.FieldByName('cdCaminhaoStatus').AsInteger;
  vlStatus.Nome   := dmCaminhao.qryPegar.FieldByName('nmCaminhaoStatus').AsString;
  ////////////////////////////////////////////////

  vlCaminhao                := TCaminhao.Create;
  vlCaminhao.Codigo         := dmCaminhao.qryPegar.FieldByName('cdCaminhao').AsInteger;
  vlCaminhao.Nome           := dmCaminhao.qryPegar.FieldByName('nmCaminhao').AsString;
  vlCaminhao.Placa          := dmCaminhao.qryPegar.FieldByName('Placa').AsString;
  vlCaminhao.Altura         := (dmCaminhao.qryPegar.FieldByName('Altura').AsFloat/ 100);
  vlCaminhao.Largura        := (dmCaminhao.qryPegar.FieldByName('Largura').AsFloat / 100);
  vlCaminhao.Comprimento    := (dmCaminhao.qryPegar.FieldByName('Comprimento').AsFloat / 100);
  vlCaminhao.FVolume        := (dmCaminhao.qryPegar.FieldByName('Volume').AsLargeInt div 1000000);
  vlCaminhao.Aproveitamento := dmCaminhao.qryPegar.FieldByName('Aproveitamento').AsInteger;
  vlCaminhao.Capacidade     := (dmCaminhao.qryPegar.FieldByName('Capacidade').AsLargeInt div 1000);
  vlCaminhao.Status         := vlStatus;

  vlCaminhao.FCodigoTransportadora := dmCaminhao.qryPegar.FieldByName('cdTransportadora').AsInteger;

  Result := vlCaminhao;
end;

class function TCaminhao.Pesquisar(pCodigo, pNome, pPlaca, pStatus, pCodigoTransportadora: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  if (Trim(pPlaca) = '') then
    begin
      pPlaca := '%';
    end;

  if (Trim(pStatus) = '') then
    begin
      pStatus := '%';
    end;

  if (Trim(pCodigoTransportadora) = '') then
    begin
      pCodigoTransportadora := '%';
    end;

  dmCaminhao.qryPesquisar.Close;
  dmCaminhao.qryPesquisar.Parameters.ParamByName('pCdCaminhao').Value       := pCodigo;
  dmCaminhao.qryPesquisar.Parameters.ParamByName('pCdCaminhaoStatus').Value := pStatus;
  dmCaminhao.qryPesquisar.Parameters.ParamByName('pNmCaminhao').Value       := '%' + pNome + '%';
  dmCaminhao.qryPesquisar.Parameters.ParamByName('pPlaca').Value            := '%' + pPlaca + '%';
  dmCaminhao.qryPesquisar.Parameters.ParamByName('pCdTransportadora').Value := pCodigoTransportadora;
  dmCaminhao.qryPesquisar.Open;

  Result := dmCaminhao.dspPesquisar.Data;
end;

procedure TCaminhao.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  FVolume := CalcularVolume(FAltura, FLargura, FComprimento);

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de novo Caminhão: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Cadastro do Caminhão: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmCaminhao.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmCaminhao.qrySalvar.Connection.BeginTrans;

    dmCaminhao.qrySalvar.Close;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pCdCaminhao').Value       := Self.Codigo;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pCdCaminhaoStatus').Value := Self.Status.Codigo;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pCdTransportadora').Value := Self.FCodigoTransportadora;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pNmCaminhao').Value       := Self.Nome;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pPlaca').Value            := Self.Placa;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pAltura').Value           := (Self.Altura * 100);
    dmCaminhao.qrySalvar.Parameters.ParamByName('pLargura').Value          := (Self.Largura * 100);
    dmCaminhao.qrySalvar.Parameters.ParamByName('pComprimento').Value      := (Self.Comprimento * 100);
    dmCaminhao.qrySalvar.Parameters.ParamByName('pVolume').Value           := (Self.Volume * 1000000);
    dmCaminhao.qrySalvar.Parameters.ParamByName('pAproveitamento').Value   := Self.Aproveitamento;
    dmCaminhao.qrySalvar.Parameters.ParamByName('pCapacidade').Value       := (Self.Capacidade * 1000);
    dmCaminhao.qrySalvar.Open;

    Self.Codigo := dmCaminhao.qrySalvar.FieldByName('cdCaminhao').AsInteger;

    pHistorico.CodigoRegistro := Self.Codigo;

    pHistorico.Salvar;

    dmCaminhao.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmCaminhao.qrySalvar.Connection.RollbackTrans;

      Self.Codigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCaminhao.setStatus(pStatus: TCaminhaoStatus);
begin
  FreeAndNil(Self.FStatus);

  Self.FStatus := pStatus;
end;

procedure TCaminhao.setTransportadora(pTransportadora: TTransportadora);
begin
  FreeAndNil(Self.FTransportadora);

  Self.FTransportadora := pTransportadora;

  if (Assigned(Self.FTransportadora) = True) then
    begin
      Self.FCodigoTransportadora := Self.FTransportadora.Codigo;
    end
  else
    begin
      Self.FCodigoTransportadora := 0
    end;
end;

procedure TCaminhao.ValidarDados;
var
  vlPesquisar: TClientDataSet;
begin
  if (Self.FCodigoTransportadora = 0) then
    begin
      raise Exception.Create('Informe a Transportadora!');
    end;

  if (Self.Aproveitamento <= 0) then
    begin
      raise Exception.Create('Aproveitamento do Baú inválido!');
    end;

  if (Self.Capacidade < 0) then
    begin
      raise Exception.Create('Capacidade do Baú inválida!');
    end;

  if (Self.Status.Codigo = 2) then // 2 = Inativo
    begin
      dmCaminhao.qryVinculos.Close;
      dmCaminhao.qryVinculos.Parameters.ParamByName('pCdCaminhao').Value := FCodigo;
      dmCaminhao.qryVinculos.Open;

      if (dmCaminhao.qryVinculos.IsEmpty = False) then
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Este Caminhão possui vínculos com Rotas ou Cargas que estão ativas.');
        end;
    end;

  if (RemoverCaracteres(RemoverEspacos(Self.Placa)) <> '') then
    begin
      vlPesquisar := TClientDataSet.Create(nil);

      try
        vlPesquisar.Close;
        vlPesquisar.Data := Pesquisar('', '', Self.Placa, '', '');

        if (vlPesquisar.IsEmpty = False) then
          begin
            if (vlPesquisar.FieldByName('cdCaminhao').AsInteger <> Self.Codigo) then
              begin
                raise Exception.Create('Operação não permitida!' + #13 +
                                       'A Placa informada já está cadastrada para outro Caminhão.' + #13 + #13 +
                                       'Código: ' + vlPesquisar.FieldByName('cdCaminhao').AsString + #13 +
                                       'Nome: ' + vlPesquisar.FieldByName('nmCaminhao').AsString + #13 +
                                       'Transportadora: ' + vlPesquisar.FieldByName('nmTransportadora').AsString);
              end;
          end;
      finally
        FreeAndNil(vlPesquisar);
      end;
    end;
end;

class function TCaminhaoStatus.ListarStatus: OleVariant;
begin
  dmCaminhao.qryListarCaminhaoStatus.Close;
  dmCaminhao.qryListarCaminhaoStatus.Open;

  Result := dmCaminhao.dspListarCaminhaoStatus.Data;
end;

end.
