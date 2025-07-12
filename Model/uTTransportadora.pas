unit uTTransportadora;

interface

uses uTHistorico;

type
  TTransportadoraStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarStatus: OleVariant;
  end;

  TTransportadora = class
  private
    FCodigo: Integer;
    FNome: string;
    FStatus: TTransportadoraStatus;

    procedure setStatus(pStatus: TTransportadoraStatus);

    procedure ValidarDados;
  public
    property Codigo: Integer                read FCodigo  write FCodigo;
    property Nome: string                   read FNome    write FNome;
    property Status: TTransportadoraStatus  read FStatus  write setStatus;

    destructor Destroy; override;

    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function  PegarTransportadora(pCodigo: Integer): TTransportadora;
    class function  Pesquisar(pCodigo, pTransportadora, pStatus: string): OleVariant;

    procedure Salvar(pHistorico: THistorico);
  end;

implementation

{ TTransportadora }

uses uDmTransportadora, SysUtils, DBClient, DB;

destructor TTransportadora.Destroy;
begin
  FreeAndNil(FStatus);

  inherited;
end;

class procedure TTransportadora.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmTransportadora.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmTransportadora.qryExcluir.Connection.BeginTrans;

    dmTransportadora.qryExcluir.Close;
    dmTransportadora.qryExcluir.Parameters.ParamByName('pCdTransportadora').Value := pCodigo;
    dmTransportadora.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro da Transportadora';

    pHistorico.Salvar;

    dmTransportadora.qryExcluir.Connection.CommitTrans;
  except
    dmTransportadora.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão desta Transportadora.');
  end;
end;

class function TTransportadora.PegarTransportadora(pCodigo: Integer): TTransportadora;
var
  vlTransportadora: TTransportadora;
  vlStatus: TTransportadoraStatus;
begin

  dmTransportadora.qryPegar.Close;
  dmTransportadora.qryPegar.Parameters.ParamByName('pCdTransportadora').Value := pCodigo;
  dmTransportadora.qryPegar.Open;

  if (dmTransportadora.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código da Transportadora inválido!');
    end;

  //////////////// Criação do Objeto Status //////////////////
  vlStatus        := TTransportadoraStatus.Create;
  vlStatus.Codigo := dmTransportadora.qryPegar.FieldByName('cdTransportadoraStatus').AsInteger;
  vlStatus.Nome   := dmTransportadora.qryPegar.FieldByName('nmTransportadorastatus').AsString;
  ////////////////////////////////////////////////////////////

  vlTransportadora        := TTransportadora.Create;
  vlTransportadora.Codigo := dmTransportadora.qryPegar.FieldByName('cdTransportadora').AsInteger;
  vlTransportadora.Nome   := dmTransportadora.qryPegar.FieldByName('nmTransportadora').AsString;
  vlTransportadora.Status := vlStatus;

  Result := vlTransportadora;
end;

class function TTransportadora.Pesquisar(pCodigo, pTransportadora, pStatus: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
  	begin
      pCodigo := '%';
  	end;

  if (Trim(pTransportadora) = '') then
  	begin
      pTransportadora := '%';
  	end;

  if (Trim(pStatus) = '') then
  	begin
      pStatus := '%';
  	end;

  dmTransportadora.qryPesquisar.Close;
  dmTransportadora.qryPesquisar.Parameters.ParamByName('pCdTransportadora').Value       := pCodigo;
  dmTransportadora.qryPesquisar.Parameters.ParamByName('pCdTransportadoraStatus').Value := pStatus;
  dmTransportadora.qryPesquisar.Parameters.ParamByName('pNmTransportadora').Value       := '%' + pTransportadora + '%';
  dmTransportadora.qryPesquisar.Open;

  Result := dmTransportadora.dspPesquisar.Data;
end;

procedure TTransportadora.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de nova Transportadora: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Cadastro da Transportadora: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmTransportadora.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmTransportadora.qrySalvar.Connection.BeginTrans;

    dmTransportadora.qrySalvar.Close;
    dmTransportadora.qrySalvar.Parameters.ParamByName('pCdTransportadora').Value       := FCodigo;
    dmTransportadora.qrySalvar.Parameters.ParamByName('pCdTransportadoraStatus').Value := FStatus.Codigo;
    dmTransportadora.qrySalvar.Parameters.ParamByName('pNmTransportadora').Value       := FNome;
    dmTransportadora.qrySalvar.Open;

    FCodigo := dmTransportadora.qrySalvar.FieldByName('cdTransportadora').AsInteger;

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmTransportadora.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmTransportadora.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TTransportadora.setStatus(pStatus: TTransportadoraStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

procedure TTransportadora.ValidarDados;
begin
  if (FStatus.Codigo = 2) then // 2 = Inativo
    begin
      dmTransportadora.qryVinculos.Close;
      dmTransportadora.qryVinculos.Parameters.ParamByName('pCdTransportadora').Value := FCodigo;
      dmTransportadora.qryVinculos.Open;

      if (dmTransportadora.qryVinculos.IsEmpty = False) then
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Esta Transportadora possui vínculos com Rotas ou Cargas que estão ativas.');
        end;
    end;
end;

class function TTransportadoraStatus.ListarStatus: OleVariant;
begin
  dmTransportadora.qryListarTranspStatus.Close;
  dmTransportadora.qryListarTranspStatus.Open;

  Result := dmTransportadora.dspListarTranspStatus.Data;
end;

end.
