unit uTReposicaoStatus;

interface

type

  TReposicaoStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function PegarStatus(pCodigo: Integer): TReposicaoStatus;
    Class Function ListaStatus : OleVariant;
  end;

implementation

{ TReposicaoStatus }

uses uDmReposicaoStatus, System.SysUtils, DB;

class function TReposicaoStatus.ListaStatus: OleVariant;
begin
  dmReposicaoStatus.QryListarStatus.Close;
  DmReposicaoStatus.QryListarStatus.Open;
  Result := dmReposicaoStatus.DspListarStatus.Data;
end;

class function TReposicaoStatus.PegarStatus(pCodigo: Integer): TReposicaoStatus;
var
  vlStatus: TReposicaoStatus;
begin
  dmReposicaoStatus.qryPegar.Close;
  dmReposicaoStatus.qryPegar.Parameters.ParamByName('pCdReposicaoStatus').Value := pCodigo;
  dmReposicaoStatus.qryPegar.Open;

  if (dmReposicaoStatus.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Status da Reposição não encontrado!');
    end;

  vlStatus        := TReposicaoStatus.Create;
  vlStatus.Codigo := dmReposicaoStatus.qryPegar.FieldByName('cdReposicaoStatus').AsInteger;
  vlStatus.Nome   := dmReposicaoStatus.qryPegar.FieldByName('nmReposicaoStatus').AsString;

  Result := vlStatus;
end;

end.

