unit uTProdutoControle;

interface

uses SysUtils, uTHistorico;  //, uDmClient

Type
{$Region Tipo de Controle de Produto}
  TProdutoControle = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      Constructor Create(cCodigo : Integer; cNome : String = ''); Reintroduce;
    Published
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarControles : OleVariant;
      class function PegarProdutoControle(pCodigo: Integer ) : TProdutoControle ; OverLoad;
  end;

  TArrayListaProdutoControle = Array Of TProdutoControle;

  TListaProdutoControle = Class
  private
    FItems: TArrayListaProdutoControle;
    procedure SetItems(const Value: TArrayListaProdutoControle);
    Published
      Property Items : TArrayListaProdutoControle read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TProdutoControle) : Integer;
  End;
{$EndRegion}


implementation

{ TProdutoControle }

constructor TProdutoControle.Create(cCodigo: Integer; cNome: String);
begin
  FCodigo := cCodigo;
  FNome   := cNome;
end;

class function TProdutoControle.ListarControles: OleVariant;
begin

end;

class function TProdutoControle.PegarProdutoControle(
  pCodigo: Integer): TProdutoControle;
begin

end;

{ TListaProdutoControle }

function TListaProdutoControle.Add(Item: TProdutoControle): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaProdutoControle.SetItems(
  const Value: TArrayListaProdutoControle);
begin
  FItems := Value;
end;

function TListaProdutoControle.Size: Integer;
begin
  Result := Length(FItems);
end;

end.
