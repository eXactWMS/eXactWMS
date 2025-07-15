program PedidosProducer;

{$APPTYPE CONSOLE}

{$R *.res}
uses
  Horse,
  Horse.Jhonson,
  Horse.GBSwagger,
  System.SysUtils,
  exactwms.controller.pedidosProducer in 'controller\exactwms.controller.pedidosProducer.pas',
  exctwms.swagger.pedidos in 'swagger\exctwms.swagger.pedidos.pas',
  extawms.model.pedidosProducer.pedido in 'model\extawms.model.pedidosProducer.pedido.pas',
  Pkg.Json.DTO in 'model\Pkg.Json.DTO.pas',
  exectwms.services.gerarPedidos in 'services\exectwms.services.gerarPedidos.pas',
  extawms.model.pedidosProducer.pedidoDto in 'model\extawms.model.pedidosProducer.pedidoDto.pas';

begin
  THorse
    .Use(Jhonson);

  THorse
    .Use(HorseSwagger(Format('%s/swagger/doc/html', ['v1']), Format('%s/swagger/doc/json', ['v1'])));

  THorse
    .Group
    .Prefix('v1')
    .Get('ping',
      procedure(Req: THorseRequest; Res: THorseResponse)
      begin
        Res.Send('pong')
      end
    );

  THorse.Listen(9000);
end.
