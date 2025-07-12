unit uTCaminhaoStatus;

interface

type
  TCaminhaoStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarStatus: OleVariant;
  end;

implementation

{ TCaminhaoStatus }

uses uDmCaminhaoStatus;

class function TCaminhaoStatus.ListarStatus: OleVariant;
begin
  dmCaminhaoStatus.qryListar.Close;
  dmCaminhaoStatus.qryListar.Open;

  Result := dmCaminhaoStatus.dspListar.Data;
end;

end.
