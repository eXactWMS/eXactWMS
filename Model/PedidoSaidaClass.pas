unit PedidoSaidaClass;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections, PedidoClass,
  PedidoProdutoClass;

type

  TPedidoSaida = class(TPedido)
  private
    FProduto: TObjectList<TPedidoProduto>;
  Protected
  Public
    // constructor Create;
    // Destructor Destroy; OverRide;
    // http://www.activedelphi.com.br/forum/viewtopic.php?t=72648&sid=143f45840f077863eb7bbc51fe422c77
    Function ClassToJson(Const ObjPedido: TPedidoSaida): String; reintroduce;
    Function JsonToClass(JSON: String): TPedidoSaida; reintroduce;
    Property ListProduto: TObjectList<TPedidoProduto> Read FProduto
      Write FProduto;
  End;

implementation

{ TPedidoSaida }

function TPedidoSaida.ClassToJson(const ObjPedido: TPedidoSaida): String;
begin
  Result := tJson.ObjectToJsonString(ObjPedido);
end;

// constructor TPedidoSaida.Create;
// begin
// ListProduto   := TObjectList<TPedidoProduto>.Create();
// end;

// destructor TPedidoSaida.Destroy;
// begin
// ListProduto := Nil;
// inherited;
// end;

function TPedidoSaida.JsonToClass(JSON: String): TPedidoSaida;
begin
  Result := TPedidoSaida.Create;
  if Not Assigned(ListProduto) then
    ListProduto := TObjectList<TPedidoProduto>.Create();
  Result := tJson.JsonToObject<TPedidoSaida>(JSON, [joDateFormatUnix])
end;

end.
