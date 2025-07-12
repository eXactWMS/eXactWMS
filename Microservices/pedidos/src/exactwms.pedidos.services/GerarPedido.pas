unit GerarPedido;

interface
  uses
  classes,
  System.SysUtils;
  type
     TGerarPedido =class
       public
          class function Gerar(pedidoInfo:string):boolean; overload;
       private
     end;
implementation


{ TGerarPedido }

class function TGerarPedido.Gerar(pedidoInfo: string):boolean;
begin
 //gravalog('    -> Geraçao do pedido '+pedidoInfo);
end;

end.
