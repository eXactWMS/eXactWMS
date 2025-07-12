unit uTEntradaTipoConferencia;

interface

type
  TEntradaTipoConferencia = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarTipos: OleVariant;
  end;

implementation

{ TEntradaTipo }

uses uDmEntradaTipoConferencia;

class function TEntradaTipoConferencia.ListarTipos: OleVariant;
begin
  dmEntradaTipoConferencia.qryListar.Close;
  dmEntradaTipoConferencia.qryListar.Open;

  Result := dmEntradaTipoConferencia.dspListar.Data;
end;

end.
