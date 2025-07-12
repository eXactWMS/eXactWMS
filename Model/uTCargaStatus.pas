unit uTCargaStatus;

interface

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

implementation

uses uDmCargaStatus;

{ TCargaStatus }

class function TCargaStatus.ListarStatus: OleVariant;
begin
  dmCargaStatus.qryListar.Close;
  dmCargaStatus.qryListar.Open;

  Result := dmCargaStatus.dspListar.Data;
end;

end.
