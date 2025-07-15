unit extawms.model.pedidosProducer.pedidoGerarDto;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TPedidosDto = class
  private

    FPedidoId: Integer;

  published

    property PedidoId: Integer read FPedidoId write FPedidoId;

  end;

  TPedidosDto = class(TJsonDTO)
  private
    [JSONName('Pedidos'), JSONMarshalled(False)]
    FPedidosDtoArray: TArray<TPedidos>;
    [GenericListReflect]
    FPedidosDto: TObjectList<TPedidos>;
    function GetPedidos: TObjectList<TPedidosDto>;
  protected
    function GetAsJson: string; override;
  published
    property Pedidos: TObjectList<TPedidosDto> read GetPedidos;
  public
    destructor Destroy; override;
  end;

implementation

{ TPedidosDto }

destructor TPedidosDto.Destroy;
begin
  GetPedidos.Free;
  inherited;
end;

function TPedidosDto.GetPedidos: TObjectList<TPedidos>;
begin
  Result := ObjectList<TPedidosDto>(FPedidosDto, FPedidosDtoArray);
end;

function TPedidosDto.GetAsJson: string;
begin
  RefreshArray<TPedidosDto>(FPedidosDtoDto, FPedidosDtoArray);
  Result := inherited;
end;

end.
