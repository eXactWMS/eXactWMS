program MicroservicesPedidos;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  PedidosController in 'exactwms.pedidos.controller\PedidosController.pas',
  GerarPedido in 'exactwms.pedidos.services\GerarPedido.pas',
  GerarPedidoCaixaFechada in 'exactwms.pedidos.services\GerarPedidoCaixaFechada.pas',
  GerarPedidoCaixaFracionada in 'exactwms.pedidos.services\GerarPedidoCaixaFracionada.pas',
  EstoqueCaixaFechada in 'exactwms.pedidos.services\EstoqueCaixaFechada.pas',
  PedidoVolumeCtrl in 'exactwms.pedidos.controller\PedidoVolumeCtrl.pas',
  ConfiguracaoClass in '..\..\common\ConfiguracaoClass.pas',
  RabbitConsumer in '..\..\common\RabbitConsumer.pas',
  uFrmeXactWMS in '..\..\common\uFrmeXactWMS.pas',
  uFuncoes in '..\..\common\uFuncoes.pas',
  uDmBase in '..\..\dao\uDmBase.pas' {DmBase: TDataModule},
  uDmeXactWMS in '..\..\dao\uDmeXactWMS.pas' {DmeXactWMS: TDataModule},
  uPedidoSaidaDAO in '..\..\dao\uPedidoSaidaDAO.pas';

var
  fila: string;
   strlog:string;
begin
  try

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
 '                            v 1.0.1'  + #13#10+
 '--------------------------------------------------------------------------------------';
    Writeln(strlog);
     Writeln('Iniciando worker...');
    // implementar aqqui de que fila vai ler atravez de um ini ou leitura de um banco
    fila:=GetEnvironmentVariable('RABBIT_FILA');
    if fila = '' then
      fila := 'Zona Picking Conveniencia';
    // podem ser lidas varias filas ao mesmo tempo
    Writeln('worker iniciado fila > ' + fila);
    gravalog('Carregando configuracoes...');
    DmeXactWMS := TDmeXactWMS.create(Nil);
    gravalog('Configuracoes carregadas');
    uFrmeXactWMS.FrmeXactWMS := TFrmeXactWMS.create();
    FRabitmqObj := TRabitmqObj.create;
    gravalog('Iniciando comunicacao com mensageria');
    FRabitmqObj.Start();
    FRabitmqObj.consumirFila(fila, TPedidosController.ProcessarPedido);
    while True do
      Sleep(1000);
  except
    on E: Exception do
      gravalog(E.Message);
  end;

end.
