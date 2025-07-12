unit uTFabricante;

interface

type
  TFabricante = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function PegarFabricante(pCodigo: string): TFabricante;
      class function Pesquisar(pNome: string): OleVariant;
  end;

implementation

uses System.SysUtils, uDmFabricante, Data.DB;

{ TFabricante }

class function TFabricante.PegarFabricante(pCodigo: string): TFabricante;
var
  vlCodigo: Integer;
  vlFabricante: TFabricante;
begin
  try
    vlCodigo := StrToInt(pCodigo);
  except
    raise Exception.Create('Código do Fabricante inválido!');
  end;

  dmFabricante.qryPegar.Close;
  dmFabricante.qryPegar.Parameters.ParamByName('pCdFabricante').Value := vlCodigo;
  dmFabricante.qryPegar.Open;

  if (dmFabricante.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Fabricante não encontrado!');
    end;

  vlFabricante        := TFabricante.Create;
  vlFabricante.Codigo := dmFabricante.qryPegar.FieldByName('cdFabricante').Value;
  vlFabricante.Nome   := dmFabricante.qryPegar.FieldByName('nmFabricante').Value;

  Result := vlFabricante;
end;

class function TFabricante.Pesquisar(pNome: string): OleVariant;
begin
  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  dmFabricante.qryPesquisar.Close;
  dmFabricante.qryPesquisar.Parameters.ParamByName('pNmFabricante').Value := '%' + pNome + '%';
  dmFabricante.qryPesquisar.Open;

  Result := dmFabricante.dspPesquisar.Data;
end;

end.
