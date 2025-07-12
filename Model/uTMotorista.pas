unit uTMotorista;

interface

uses uTHistorico, uTTransportadora;

type
  TMotoristaStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

  TMotorista = class
  private
    FCodigo: Integer;
    FNome: string;
    FCPF: string;
    FStatus: TMotoristaStatus;
    FCodigoTransportadora: Integer;
    FTransportadora: TTransportadora;

    function  getTransportadora: TTransportadora;
    procedure setStatus(pStatus: TMotoristaStatus);
    procedure setTransportadora(pTransportadora: TTransportadora);

    procedure SalvarTelefones(pTelefones: OleVariant);
    procedure ValidarDados;
  public
    property Codigo: Integer                  read FCodigo            write FCodigo;
    property Nome: string                     read FNome              write FNome;
    property CPF: string                      read FCPF               write FCPF;
    property Status: TMotoristaStatus         read FStatus            write setStatus;
    property Transportadora: TTransportadora  read getTransportadora  write setTransportadora;

    destructor Destroy; override;

    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function  PegarMotorista(pCodigo: Integer): TMotorista;
    class function  Pesquisar(pCodigo, pNome, pCPF, pStatus, pCodigoTransportadora: string): OleVariant;

    function  ListarTelefones: OleVariant;
    procedure Salvar(pTelefones: OleVariant; pHistorico: THistorico);
  end;

implementation

uses SysUtils, uDmMotorista, DBClient, DB, uFuncoes;

{ TMotorista }

destructor TMotorista.Destroy;
begin
  FreeAndNil(FStatus);
  FreeAndNil(FTransportadora);

  inherited;
end;

class procedure TMotorista.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmMotorista.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmMotorista.qryExcluir.Connection.BeginTrans;

    dmMotorista.qryExcluir.Close;
    dmMotorista.qryExcluir.Parameters.ParamByName('pCdMotorista').Value := pCodigo;
    dmMotorista.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro do Motorista';

    pHistorico.Salvar;

    dmMotorista.qryExcluir.Connection.CommitTrans;
  except
    dmMotorista.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste motorista.');
  end;
end;

function TMotorista.getTransportadora: TTransportadora;
begin
  if (Assigned(FTransportadora) = False) and (FCodigoTransportadora > 0) then
    begin
      setTransportadora(TTransportadora.PegarTransportadora(FCodigoTransportadora));
    end;

  Result := FTransportadora;
end;

function TMotorista.ListarTelefones: OleVariant;
begin
  dmMotorista.qryListarTelefones.Close;
  dmMotorista.qryListarTelefones.Parameters.ParamByName('pCdMotorista').Value := FCodigo;
  dmMotorista.qryListarTelefones.Open;

  Result := dmMotorista.dspListarTelefones.Data;
end;

class function TMotorista.PegarMotorista(pCodigo: Integer): TMotorista;
var
  vlMotorista: TMotorista;
  vlStatus: TMotoristaStatus;
begin
  dmMotorista.qryPegar.Close;
  dmMotorista.qryPegar.Parameters.ParamByName('pCdMotorista').Value := pCodigo;
  dmMotorista.qryPegar.Open;

  if (dmMotorista.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Motorista não encontrado!');
    end;

  ///////// Criação do Objeto Status /////////////
  vlStatus        := TMotoristaStatus.Create;
  vlStatus.Codigo := dmMotorista.qryPegar.FieldByName('cdMotoristaStatus').AsInteger;
  vlStatus.Nome   := dmMotorista.qryPegar.FieldByName('nmMotoristaStatus').AsString;
  ////////////////////////////////////////////////

  vlMotorista        := TMotorista.Create;
  vlMotorista.Codigo := dmMotorista.qryPegar.FieldByName('cdMotorista').AsInteger;
  vlMotorista.Nome   := dmMotorista.qryPegar.FieldByName('nmMotorista').AsString;
  vlMotorista.CPF    := dmMotorista.qryPegar.FieldByName('CPF').AsString;
  vlMotorista.Status := vlStatus;

  vlMotorista.FCodigoTransportadora := dmMotorista.qryPegar.FieldByName('cdTransportadora').AsInteger;

  Result := vlMotorista;
end;

class function TMotorista.Pesquisar(pCodigo, pNome, pCPF, pStatus, pCodigoTransportadora: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  if (Trim(pCPF) = '') then
    begin
      pCPF := '%';
    end;

  if (Trim(pStatus) = '') then
    begin
      pStatus := '%';
    end;

  if (Trim(pCodigoTransportadora) = '') then
    begin
      pCodigoTransportadora := '%';
    end;

  dmMotorista.qryPesquisar.Close;
  dmMotorista.qryPesquisar.Parameters.ParamByName('pCdMotorista').Value       := pCodigo;
  dmMotorista.qryPesquisar.Parameters.ParamByName('pCdMotoristaStatus').Value := pStatus;
  dmMotorista.qryPesquisar.Parameters.ParamByName('pNmMotorista').Value       := '%' + pNome + '%';
  dmMotorista.qryPesquisar.Parameters.ParamByName('pCPF').Value               := pCPF;
  dmMotorista.qryPesquisar.Parameters.ParamByName('pCdTransportadora').Value  := pCodigoTransportadora;
  dmMotorista.qryPesquisar.Open;

  Result := dmMotorista.dspPesquisar.Data;
end;

procedure TMotorista.Salvar(pTelefones: OleVariant; pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de novo Motorista: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Cadastro do Motorista: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmMotorista.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmMotorista.qrySalvar.Connection.BeginTrans;

    dmMotorista.qrySalvar.Close;
    dmMotorista.qrySalvar.Parameters.ParamByName('pCdMotorista').Value       := FCodigo;
    dmMotorista.qrySalvar.Parameters.ParamByName('pCdMotoristaStatus').Value := FStatus.Codigo;;
    dmMotorista.qrySalvar.Parameters.ParamByName('pCdTransportadora').Value  := FCodigoTransportadora;
    dmMotorista.qrySalvar.Parameters.ParamByName('pNmMotorista').Value       := FNome;
    dmMotorista.qrySalvar.Parameters.ParamByName('pCPF').Value               := FCPF;
    dmMotorista.qrySalvar.Open;

    FCodigo := dmMotorista.qrySalvar.FieldByName('cdMotorista').AsInteger;

    SalvarTelefones(pTelefones);

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmMotorista.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmMotorista.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TMotorista.SalvarTelefones(pTelefones: OleVariant);
var
  vlTelefones: TClientDataSet;
begin
  dmMotorista.qryExcluirTelefones.Close;
  dmMotorista.qryExcluirTelefones.Parameters.ParamByName('pCdMotorista').Value := FCodigo;
  dmMotorista.qryExcluirTelefones.ExecSQL;

  vlTelefones := TClientDataSet.Create(nil);
  try
    vlTelefones.Close;
    vlTelefones.Data := pTelefones;

    vlTelefones.First;
    while (vlTelefones.Eof = False) do
      begin
        dmMotorista.qryInserirTelefone.Close;
        dmMotorista.qryInserirTelefone.Parameters.ParamByName('pCdMotorista').Value := FCodigo;
        dmMotorista.qryInserirTelefone.Parameters.ParamByName('pTelefone').Value    := vlTelefones.FieldByName('Telefone').AsString;
        dmMotorista.qryInserirTelefone.Parameters.ParamByName('pObservacao').Value  := vlTelefones.FieldByName('Observacao').AsString;
        dmMotorista.qryInserirTelefone.ExecSQL;

        vlTelefones.Next;
      end;
  finally
    FreeAndNil(vlTelefones);
  end;
end;

procedure TMotorista.setStatus(pStatus: TMotoristaStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

procedure TMotorista.setTransportadora(pTransportadora: TTransportadora);
begin
  FreeAndNil(FTransportadora);

  FTransportadora := pTransportadora;

  if (Assigned(FTransportadora) = True) then
    begin
      FCodigoTransportadora := FTransportadora.Codigo;
    end
  else
    begin
      FCodigoTransportadora := 0;
    end;
end;

procedure TMotorista.ValidarDados;
var
  vlPesquisar: TClientDataSet;
begin
  if (FStatus.Codigo = 2) then // 2 = Inativo
    begin
      dmMotorista.qryVinculos.Close;
      dmMotorista.qryVinculos.Parameters.ParamByName('pCdMotorista').Value := FCodigo;
      dmMotorista.qryVinculos.Open;

      if (dmMotorista.qryVinculos.IsEmpty = False) then
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Este Motorista possui vínculos com Rotas ou Cargas que estão ativas.');
        end;
    end;

  if (RemoverCaracteres(FCPF) <> '00000000000') then
    begin
      if (ValidarCPF(RemoverCaracteres(FCPF)) = False) then
        begin
          raise Exception.Create('O CPF digitado é inválido!');
        end
      else
        begin
          vlPesquisar := TClientDataSet.Create(nil);

          try
            vlPesquisar.Close;
            vlPesquisar.Data := Pesquisar('', '', FCPF, '', '');

            if (vlPesquisar.IsEmpty = False) then
              begin
                if (vlPesquisar.FieldByName('cdMotorista').AsInteger <> FCodigo) then
                  begin
                    raise Exception.Create('Operação não permitida!' + #13 +
                                           'O CPF informado já está cadastrado para outro Motorista.' + #13 + #13 +
                                           'Código: ' + vlPesquisar.FieldByName('cdMotorista').AsString + #13 +
                                           'Nome: ' + vlPesquisar.FieldByName('nmMotorista').AsString + #13 +
                                           'Transportadora: ' + vlPesquisar.FieldByName('nmTransportadora').AsString);
                  end;
              end;
          finally
            FreeAndNil(vlPesquisar);
          end;
        end;
    end;
end;

class function TMotoristaStatus.ListarStatus: OleVariant;
begin
  dmMotorista.qryListarMotoristaStatus.Close;
  dmMotorista.qryListarMotoristaStatus.Open;

  Result := dmMotorista.dspListarMotoristaStatus.Data;
end;

end.
