unit extawms.model.pedidosProducer.gerar;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TPedidos = class
  private
    FFilaProc: string;
    FPedidoId: Integer;
    FZona: Integer;
  published
    property FilaProc: string read FFilaProc write FFilaProc;
    property PedidoId: Integer read FPedidoId write FPedidoId;
    property Zona: Integer read FZona write FZona;
  end;

  TPedidosProducerRequest = class(TJsonDTO)
  private
    [JSONName('Pedidos'), JSONMarshalled(False)]
    FPedidosArray: TArray<TPedidos>;
    [GenericListReflect]
    FPedidos: TObjectList<TPedidos>;
    function GetPedidos: TObjectList<TPedidos>;
  protected
    function GetAsJson: string; override;
  published
    property Pedidos: TObjectList<TPedidos> read GetPedidos;
  public
    destructor Destroy; override;
  end;

implementation

{ TPedidosProducerRequest }

destructor TPedidosProducerRequest.Destroy;
begin
  GetPedidos.Free;
  inherited;
end;

function TPedidosProducerRequest.GetPedidos: TObjectList<TPedidos>;
begin
  Result := ObjectList<TPedidos>(FPedidos, FPedidosArray);
end;

function TPedidosProducerRequest.GetAsJson: string;
begin
  RefreshArray<TPedidos>(FPedidos, FPedidosArray);
  Result := inherited;
end;

end.
