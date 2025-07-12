unit uTProdutoControle;

interface

type
  TProdutoControle = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarControles: OleVariant;
      class function PegarProdutoControle(pCodigo: Integer ) : TProdutoControle ; OverLoad;

  end;

implementation

{ TProdutoControle }

uses uDmProduto;

class function TProdutoControle.ListarControles: OleVariant;
begin
  dmProduto.qryListarProdControle.Close;
  dmProduto.qryListarProdControle.Open;

  Result := dmProduto.dspListarProdControle.Data;
end;

class function TProdutoControle.PegarProdutoControle(
  pCodigo: Integer): TProdutoControle;
Var xProdutoControle : TPRodutoControle;
begin
  xProdutoControle := tPRodutoControle.Create;
  DmProduto.QryPegarProdControle.Close;
  DmProduto.QryPegarProdControle.ParamByName('pProdutoControle').Value := pCodigo;
  DmProduto.QryPegarProdControle.Open;
  xProdutoControle.FCodigo := DmProduto.QryPegarProdControle.FieldByName('CdProdutoControle').AsInteger;
  xProdutoControle.FNome   := DmProduto.QryPegarProdControle.FieldByName('NmProdutoControle').AsString;
  Result := xProdutoControle;
  xProdutoControle := Nil;
end;

end.
