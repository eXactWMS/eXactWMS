unit uTCaixaTipoStatus;

interface

type
  TCaixaTipoStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

implementation

{ TCaixaTipoStatus }

uses uDmCaixaTipoStatus;

class function TCaixaTipoStatus.ListarStatus: OleVariant;
begin
  dmCaixaTipoStatus.qryListar.Close;
  dmCaixaTipoStatus.qryListar.Open;

  Result := dmCaixaTipoStatus.dspListar.Data;
end;

end.
