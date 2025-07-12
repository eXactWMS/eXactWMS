unit uTCaixaStatus;

interface

type
  TCaixaStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

implementation

{ TCaixaStatus }

uses uDmCaixaStatus;

class function TCaixaStatus.ListarStatus: OleVariant;
begin
  dmCaixaStatus.qryListar.Close;
  dmCaixaStatus.qryListar.Open;

  Result := dmCaixaStatus.dspListar.Data;
end;

end.
