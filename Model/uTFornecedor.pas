unit uTFornecedor;

interface

uses uTHistorico;

type
  TFornecedor = class
    private
      FCodigo: Integer;
      FNome: string;
      FValidadeMinima: Integer;
    public
      property Codigo: Integer                read FCodigo                write FCodigo;
      property Nome: string                   read FNome                  write FNome;
      property ValidadeMinima: Integer        read FValidadeMinima        write FValidadeMinima;

      class function PegarFornecedor(pCodigo: Integer): TFornecedor;
      class function Pesquisar(pCodigo, pFornecedor: string): OleVariant;

      procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses uDmFornecedor, SysUtils, DBClient, DB;

{ TFornecedor }

class function TFornecedor.PegarFornecedor(pCodigo: Integer): TFornecedor;
var
  vlPesquisar: TClientDataSet;
  vlFornecedor: TFornecedor;
begin
  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Close;
    vlPesquisar.Data := Pesquisar(IntToStr(pCodigo), '');

    if (vlPesquisar.IsEmpty = True) then
    	begin
    		raise Exception.Create('Código do Fornecedor inválido!');
    	end;

    vlFornecedor                     := TFornecedor.Create;
    vlFornecedor.Codigo              := vlPesquisar.FieldByName('cdFornecedor').AsInteger;
    vlFornecedor.Nome                := vlPesquisar.FieldByName('nmFornecedor').AsString;
    vlFornecedor.ValidadeMinima      := vlPesquisar.FieldByName('ValidadeMinima').AsInteger;

    Result := vlFornecedor;
  finally
    FreeAndNil(vlPesquisar);
  end;
end;

class function TFornecedor.Pesquisar(pCodigo, pFornecedor: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
  	begin
      pCodigo := '%';
  	end;

  dmFornecedor.qryPesquisar.Close;
  dmFornecedor.qryPesquisar.Parameters.ParamByName('pCdFornecedor').Value   := pCodigo;
  dmFornecedor.qryPesquisar.Parameters.ParamByName('pNmFornecedor').Value   := '%' + pFornecedor + '%';
  dmFornecedor.qryPesquisar.Open;

  Result := dmFornecedor.dspPesquisar.Data;
end;

procedure TFornecedor.Salvar(pHistorico: THistorico);
begin
  dmFornecedor.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
  dmFornecedor.qrySalvar.Connection.BeginTrans;

  try
    dmFornecedor.qrySalvar.Close;
    dmFornecedor.qrySalvar.Parameters.ParamByName('pCdFornecedor').Value   := FCodigo;
    dmFornecedor.qrySalvar.Parameters.ParamByName('pValidadeMinima').Value := FValidadeMinima;
    dmFornecedor.qrySalvar.ExecSQL;

    pHistorico.CodigoRegistro := FCodigo;
    pHistorico.Observacao     := 'Alteração do Cadastro do Fornecedor';

    pHistorico.Salvar;

    dmFornecedor.qrySalvar.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmFornecedor.qrySalvar.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

end.
