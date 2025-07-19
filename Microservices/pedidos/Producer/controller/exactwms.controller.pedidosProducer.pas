unit exactwms.controller.pedidosProducer;

interface

// {"Zona":9,"PedidoId":1,"FilaProc":"PICKING ATB/PSICO/GELADEIRA"}
uses
  Horse,
  exectwms.services.gerarPedidos,
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  Horse.GBSwagger.Register,
  Horse.GBSwagger.controller,
  System.JSON.Serializers,
  REST.JSON,
  extawms.model.pedidosProducer.pedidoDto,
  extawms.model.pedidosProducer.pedido,
  GBSwagger.Path.Attributes;

type

  [SwagPath('v1', 'Pedidos')]
  TControllerPedidos = class(THorseGBSwagger)
  private
    FlistPedidos: TstringList;
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
  pedido: TPedidoDto;
  LGerar: TgerarPedidos;
  LpedidosList: string;
  Msg: string;
begin
  Dados := REST.JSON.TJson.JsonToObject<TPedidosDto>(FRequest.Body);

  try
    Msg := 'Processando pedidos: ' + sLineBreak;
    FlistPedidos := TstringList.create;
    for pedido in Dados.Pedidos do
    begin

      if LpedidosList = '' then
        LpedidosList := (inttostr(pedido.PedidoId))
      else
        LpedidosList := LpedidosList + ',' + (inttostr(pedido.PedidoId))
    end;
    LGerar := TgerarPedidos.create;
    LGerar.gerar(LpedidosList);
    FreeAndNil(LGerar);
    FResponse.Send('ok pedidos gerados');
  finally
    Dados.Free;
  end;
end;

initialization

THorseGBSwaggerRegister.RegisterPath(TControllerPedidos);

end.
