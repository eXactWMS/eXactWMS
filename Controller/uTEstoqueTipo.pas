unit uTEstoqueTipo;

interface

type
    TEstoqueTipo = class
      private
        FCodigo: Integer;
        FNome: string;
      public
        property Codigo: Integer  read FCodigo  write FCodigo;
        property Nome: string     read FNome    write FNome;

        class function ListarTipos: OleVariant;
    end;

implementation

{ TEstoqueTipo }

uses uDmEstoqueTipo;

class function TEstoqueTipo.ListarTipos: OleVariant;
begin
  dmEstoqueTipo.qryListarTipos.Close;
  dmEstoqueTipo.qryListarTipos.Open;

  Result := dmEstoqueTipo.dspListarTipos.Data;
end;

end.
