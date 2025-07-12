unit uTSegregadoMotivo;

interface

uses uTHistorico;

type
  TSegregadoMotivo = class
    private
      FCodigo: Integer;
      FNome: string;

      procedure ValidarDados;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
      class function  ListarMotivoByProd(pCdProduto : Int64): OleVariant;
      class function  Pesquisar(pCodigo, pNome: string): OleVariant;

      procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses SysUtils, DB, DBClient, uDmSegregadoMotivo;

{ TSegregadoMotivo }

class procedure TSegregadoMotivo.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmSegregadoMotivo.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmSegregadoMotivo.qryExcluir.Connection.BeginTrans;

    dmSegregadoMotivo.qryExcluir.Close;
    dmSegregadoMotivo.qryExcluir.Parameters.ParamByName('pCdSegregadoMotivo').Value := pCodigo;
    dmSegregadoMotivo.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Motivo de Segregado';

    pHistorico.Salvar;

    dmSegregadoMotivo.qryExcluir.Connection.CommitTrans;
  except
    dmSegregadoMotivo.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste Motivo.');
  end;
end;

class function TSegregadoMotivo.ListarMotivoByProd(pCdProduto : Int64): OleVariant;
begin
  With DmSegregadoMotivo.QryListaMotivoByProd do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value := pCdProduto;
    Open;
  End;
  Result := dmSegregadoMotivo.DspQryListaMotivoByProd.Data;
end;

class function TSegregadoMotivo.Pesquisar(pCodigo, pNome: string): OleVariant;
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

  dmSegregadoMotivo.qryPesquisar.Close;
  dmSegregadoMotivo.qryPesquisar.Parameters.ParamByName('pCdSegregadoMotivo').Value := pCodigo;
  dmSegregadoMotivo.qryPesquisar.Parameters.ParamByName('pNmSegregadoMotivo').Value := pNome;
  dmSegregadoMotivo.qryPesquisar.Open;

  Result := dmSegregadoMotivo.dspPesquisar.Data;
end;

procedure TSegregadoMotivo.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de Novo Motivo de Segregação: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Motivo de Segregação: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmSegregadoMotivo.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmSegregadoMotivo.qrySalvar.Connection.BeginTrans;

    dmSegregadoMotivo.qrySalvar.Close;
    dmSegregadoMotivo.qrySalvar.Parameters.ParamByName('pCdSegregadoMotivo').Value := FCodigo;
    dmSegregadoMotivo.qrySalvar.Parameters.ParamByName('pNmSegregadoMotivo').Value := FNome;
    dmSegregadoMotivo.qrySalvar.Open;

    FCodigo := dmSegregadoMotivo.qrySalvar.FieldByName('cdSegregadoMotivo').AsInteger;

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmSegregadoMotivo.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmSegregadoMotivo.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TSegregadoMotivo.ValidarDados;
var
  vlPesquisar: TClientDataSet;
begin
  if (FCodigo < 0) then
    begin
      raise Exception.Create('Código do Motivo de Segregação inválido!');
    end;

  FNome := Trim(FNome);

  if (FNome = '') then
    begin
      raise Exception.Create('Informe o Nome do Motivo de Segregação!');
    end;

  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Data := Pesquisar('', FNome);

    if (vlPesquisar.IsEmpty = False) then
      begin
        if (vlPesquisar.FieldByName('cdSegregadoMotivo').AsInteger <> FCodigo) then
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
