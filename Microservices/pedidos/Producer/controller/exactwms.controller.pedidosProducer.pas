unit exactwms.controller.pedidosProducer;

interface

// {"Zona":9,"PedidoId":1,"FilaProc":"PICKING ATB/PSICO/GELADEIRA"}
uses
  Horse,
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  Horse.GBSwagger.Register,
  Horse.GBSwagger.controller,
  System.JSON.Serializers,
  REST.Json,
  extawms.model.pedidosProducer.pedidoDto,
  extawms.model.pedidosProducer.pedido,
  GBSwagger.Path.Attributes;

type

  [SwagPath('v1', 'Pedidos')]
  TControllerPedidos = class(THorseGBSwagger)
  private
  public
    [SwagPost('Gerar', 'Geração de pedidos via mensageria')]
    [SwagParamBody('Itens', TPedidosDto, 'Informe os pedidos')]
    [SwagResponse(200, '', 'Retorno com sucesso')]
    procedure gerar();
  end;

implementation

{ TControllerPedidos }

procedure TControllerPedidos.gerar();
var
  Dados: TPedidosDto;
  Pedido: TPedidoDto;

  Msg: string;
begin
  dados:= rest.Json.TJson.JsonToObject<TPedidosDto>(FRequest.Body);

  try
    Msg := 'Processando pedidos: ' + sLineBreak;


    for Pedido in Dados.Pedidos do
    begin
 
    end;

    FResponse.Send('ok pedidos gerados');
  finally

    Dados.Free;
  end;
end;

initialization

THorseGBSwaggerRegister.RegisterPath(TControllerPedidos);

end.
