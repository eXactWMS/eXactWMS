unit uTCaixaMotivoRetirada;

interface

uses uTHistorico;

type
  TCaixaMotivoRetirada = class
  private
    FCodigo: Integer;
    FNome: string;

    procedure ValidarDados;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function  Pesquisar(pCodigo, pNome: string): OleVariant;

    procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses SysUtils, DBClient, DB, uDmCaixaMotivoRetirada;

{ TCaixaMotivoRetirada }

class procedure TCaixaMotivoRetirada.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmCaixaMotivoRetirada.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmCaixaMotivoRetirada.qryExcluir.Connection.BeginTrans;

    dmCaixaMotivoRetirada.qryExcluir.Close;
    dmCaixaMotivoRetirada.qryExcluir.Parameters.ParamByName('pCdCaixaMotivoRetirada').Value := pCodigo;
    dmCaixaMotivoRetirada.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Motivo de Retirada de Caixa';

    pHistorico.Salvar;

    dmCaixaMotivoRetirada.qryExcluir.Connection.CommitTrans;
  except
    dmCaixaMotivoRetirada.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste Motivo.');
  end;
end;

class function TCaixaMotivoRetirada.Pesquisar(pCodigo, pNome: string): OleVariant;
begin
  pCodigo := Trim(pCodigo);
  pNome   := Trim(pNome);

  if (pCodigo = '') then
    begin
      pCodigo := '%';
    end;

  if (pNome = '') then
    begin
      pNome := '%';
    end;

  dmCaixaMotivoRetirada.qryPesquisar.Close;
  dmCaixaMotivoRetirada.qryPesquisar.Parameters.ParamByName('pCdCaixaMotivoRetirada').Value := pCodigo;
  dmCaixaMotivoRetirada.qryPesquisar.Parameters.ParamByName('pNmCaixaMotivoRetirada').Value := pNome;
  dmCaixaMotivoRetirada.qryPesquisar.Open;

  Result := dmCaixaMotivoRetirada.dspPesquisar.Data;
end;

procedure TCaixaMotivoRetirada.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de Novo Motivo de Retirada de Caixa: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Motivo de Retirada de Caixa: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmCaixaMotivoRetirada.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmCaixaMotivoRetirada.qrySalvar.Connection.BeginTrans;

    dmCaixaMotivoRetirada.qrySalvar.Close;
    dmCaixaMotivoRetirada.qrySalvar.Parameters.ParamByName('pCdCaixaMotivoRetirada').Value := FCodigo;
    dmCaixaMotivoRetirada.qrySalvar.Parameters.ParamByName('pNmCaixaMotivoRetirada').Value := FNome;
    dmCaixaMotivoRetirada.qrySalvar.Open;

    FCodigo := dmCaixaMotivoRetirada.qrySalvar.FieldByName('cdCaixaMotivoRetirada').AsInteger;

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmCaixaMotivoRetirada.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmCaixaMotivoRetirada.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCaixaMotivoRetirada.ValidarDados;
var
  vlPesquisar: TClientDataSet;
begin
  FNome := Trim(FNome);

  if (FNome = '') then
    begin
      raise Exception.Create('Informe o Nome do Motivo de Retirada de Caixa!');
    end;

  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Data := Pesquisar('', FNome);

    if (vlPesquisar.IsEmpty = False) then
      begin
        if (vlPesquisar.FieldByName('cdCaixaMotivoRetirada').AsInteger <> FCodigo) then
          begin
            raise Exception.Create('Motivo inválido!' + #13 +
                                   'Já existe outro motivo registrado com essa descrição.');
          end;
      end;
  finally
    FreeAndNil(vlPesquisar);
  end;
end;

end.
