unit uTReposicaoTipo;

interface

type

  TReposicaoTipo = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarTipos: OleVariant;
    class function PegarTipo(pCodigo: Integer): TReposicaoTipo;
  end;

implementation

{ TReposicaoTipo }

uses uDmReposicaoTipo, System.SysUtils, DB;

class function TReposicaoTipo.ListarTipos: OleVariant;
begin
  dmReposicaoTipo.qryListar.Close;
  dmReposicaoTipo.qryListar.Open;

  Result := dmReposicaoTipo.dspListar.Data;
end;

class function TReposicaoTipo.PegarTipo(pCodigo: Integer): TReposicaoTipo;
var
  vlTipo: TReposicaoTipo;
begin
  dmReposicaoTipo.qryPegar.Close;
  dmReposicaoTipo.qryPegar.Parameters.ParamByName('pCdReposicaoTipo').Value := pCodigo;
  dmReposicaoTipo.qryPegar.Open;

  if (dmReposicaoTipo.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Tipo da Reposição não encontrado!');
    end;

  vlTipo        := TReposicaoTipo.Create;
  vlTipo.Codigo := dmReposicaoTipo.qryPegar.FieldByName('cdReposicaoTipo').AsInteger;
  vlTipo.Nome   := dmReposicaoTipo.qryPegar.FieldByName('nmReposicaoTipo').AsString;

  Result := vlTipo;
end;

end.

