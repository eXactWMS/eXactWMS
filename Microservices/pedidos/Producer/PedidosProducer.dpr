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
  extawms.model.pedidosProducer.pedidoDto in 'model\extawms.model.pedidosProducer.pedidoDto.pas',
  uFuncoes in '..\common\uFuncoes.pas',
  RabbitConsumer in '..\common\RabbitConsumer.pas',
  uDmBase in '..\dao\uDmBase.pas' {DmBase: TDataModule},
  uDmeXactWMS in '..\dao\uDmeXactWMS.pas' {DmeXactWMS: TDataModule};

var
     strlog:string;
begin
  THorse
    .Use(Jhonson);

  THorse
    .Use(HorseSwagger(Format('%s/swagger/doc/html', ['v1']), Format('%s/swagger/doc/json', ['v1'])));


     strlog :=
 '-------------------------------------------------------------------------------------'+ #13#10+
 '-------------------------------------------------------------------------------------'+ #13#10+
 ''  + #13#10+
 '/ ___|| ____|  _ \ \   / /_ _/ ___| ____|  |  _ \| ____|  _ \_ _|  _ \ / _ \/ ___|   '+  #13#10+
 '\___ \|  _| | |_) \ \ / / | | |   |  _|    | |_) |  _| | | | | || | | | | | \___ \   '+  #13#10+
 ' ___) | |___|  _ < \ V /  | | |___| |___   |  __/| |___| |_| | || |_| | |_| |___) |  '+  #13#10+
 '|____/|_____|_| \_\ \_/  |___\____|_____|  |_|   |_____|____/___|____/ \___/|____/   '+  #13#10+
 ''  + #13#10+
 '--------------------------------------------------------------------------------------'+ #13#10+
 '              producer              v 1.0.1'  + #13#10+
 '--------------------------------------------------------------------------------------';
    Writeln(strlog);
     Writeln('Iniciando worker...');


    gravalog('Carregando configuracoes...');
    DmeXactWMS := TDmeXactWMS.create(Nil);
    gravalog('Configuracoes carregadas');

    FRabitmqObj := TRabitmqObj.create;
    gravalog('Iniciando comunicacao com mensageria');
    FRabitmqObj.Start();
  THorse.Listen(9000);
end.
