unit extawms.model.pedidosProducer.pedidoDto;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TPedidoDto = class
  private

    FPedidoId: Integer;

  published

    property PedidoId: Integer read FPedidoId write FPedidoId;

  end;

  TPedidosDto = class(TJsonDTO)
  private
    [JSONName('Pedidos'), JSONMarshalled(False)]
    FPedidosDtoArray: TArray<TPedidoDto>;
    [GenericListReflect]
    FPedidosDto: TObjectList<TPedidoDto>;
    function GetPedidos: TObjectList<TPedidoDto>;
  protected
    function GetAsJson: string; override;
  published
    property Pedidos: TObjectList<TPedidoDto> read GetPedidos;
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

function TPedidosDto.GetPedidos: TObjectList<TPedidoDto>;
begin
  Result := ObjectList<TPedidoDto>(FPedidosDto, FPedidosDtoArray);
end;

function TPedidosDto.GetAsJson: string;
begin
  RefreshArray<TPedidoDto>(FPedidosDto, FPedidosDtoArray);
  Result := inherited;
end;

end.
