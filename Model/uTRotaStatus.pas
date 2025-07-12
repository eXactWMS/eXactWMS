unit uTRotaStatus;

interface

type
  TRotaStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

implementation

{ TRotaStatus }

uses uDmRotaStatus;

class function TRotaStatus.ListarStatus: OleVariant;
begin
  dmRotaStatus.qryListar.Close;
  dmRotaStatus.qryListar.Open;

  Result := dmRotaStatus.dspListar.Data;
end;

end.
