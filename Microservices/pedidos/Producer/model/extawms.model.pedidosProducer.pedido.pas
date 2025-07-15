unit extawms.model.pedidosProducer.pedido;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TPedido = class
  private
    FFilaProc: string;
    FPedidoId: Integer;
    FZona: Integer;
  published
    property FilaProc: string read FFilaProc write FFilaProc;
    property PedidoId: Integer read FPedidoId write FPedidoId;
    property Zona: Integer read FZona write FZona;
  end;

  TPedidos = class(TJsonDTO)
  private
    [JSONName('Pedidos'), JSONMarshalled(False)]
    FPedidosArray: TArray<TPedido>;
    [GenericListReflect]
    FPedidos: TObjectList<TPedido>;
    function GetPedidos: TObjectList<TPedido>;
  protected
    function GetAsJson: string; override;
  published
    property Pedidos: TObjectList<TPedido> read GetPedidos;
  public
    destructor Destroy; override;
  end;

implementation

{ TPedidos }

destructor TPedidos.Destroy;
begin
  GetPedidos.Free;
  inherited;
end;

function TPedidos.GetPedidos: TObjectList<TPedido>;
begin
  Result := ObjectList<TPedido>(FPedidos, FPedidosArray);
end;

function TPedidos.GetAsJson: string;
begin
  RefreshArray<TPedido>(FPedidos, FPedidosArray);
  Result := inherited;
end;

end.
