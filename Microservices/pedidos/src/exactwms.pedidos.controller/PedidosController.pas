unit PedidosController;

interface

uses
  classes,
  GerarPedido,
  GerarPedidoCaixaFechada,
  GerarPedidoCaixaFracionada,
  FireDAC.Comp.Client,
  EstoqueCaixaFechada,
  Rest.Json,
  System.Json,
  PedidoClass,
  Rest.Types,
  ufuncoes,
  PedidoSaidaCtrl,
  System.SysUtils;

type
  TpedidoDto = class
    PedidoId: string;
    Status: string;
  end;

type
  TPedidosController = class
  private
  public
    class procedure ProcessarPedido(infoPedido: string);
    class function Pedido_CancelarCubagem(PedidoId: string):Boolean;

  end;

implementation

{ TPedidosController }
class function TPedidosController.Pedido_CancelarCubagem(PedidoId: string):Boolean;
begin
   result:=false;
  with TPedidoSaidaCtrl.Create do
  begin
    Pedido_CancelarCubagem(strtoint(PedidoId));
    result:=true;
    free;
  end;
end;

class procedure TPedidosController.ProcessarPedido(infoPedido: string);

var
  itime: Ttime;
  vRepeteProcessamento: boolean;
  vErroProcessamento: boolean;
  qryestoqueCaixaFechada: TFDMemTable;
  gerarCaixaFechada: TGerarPedidoCaixaFechada;
  GerarPedidoCaixaFracionada: TGerarPedidoCaixaFracionada;
  ObjPedidoCtrl: TPedidoSaidaCtrl;
  JsonArrayRetorno: TJsonArray;
  verro: string;
  pedido: TpedidoDto;
begin

  itime := now;
  pedido := TJson.JsonToObject<TpedidoDto>((infoPedido));
  if (pedido = nil) or (pedido.PedidoId = '') then
  begin
    gravalog('parametros do pedido invalido ' + infoPedido);
    exit;
  end;
  gravalog('tentando cancelar pedido ' + infoPedido);
  if not TPedidosController.Pedido_CancelarCubagem(pedido.PedidoId )then
  begin
     gravalog('pedido nao pode ser cancelado ' + infoPedido);
     exit;
  end;
  TPedidosController.Pedido_CancelarCubagem(pedido.PedidoId);
  qryestoqueCaixaFechada := TFDMemTable.Create(Nil);
  GerarPedidoCaixaFracionada := TGerarPedidoCaixaFracionada.Create;
  try
    Try
      vRepeteProcessamento := False;
      vErroProcessamento := False;
      gravalog('iniciando  geracao do pedido caixa fechada ' + infoPedido);
      If TEstoqueCaixaFechada.gerar(pedido.PedidoId, pedido.Status,
        qryestoqueCaixaFechada) then
      Begin
        if (Not qryestoqueCaixaFechada.IsEmpty) then
        Begin
          Repeat
            vErroProcessamento := gerarCaixaFechada.gerar(pedido.PedidoId,
              qryestoqueCaixaFechada);
            If (vErroProcessamento) and (Not vRepeteProcessamento) then
            Begin
              vRepeteProcessamento := True;
              TPedidosController.Pedido_CancelarCubagem(pedido.PedidoId);
            End
            Else
              vRepeteProcessamento := False;
          Until Not vRepeteProcessamento;
        End
        else
          gravalog('        -> Sem estoque caixa fechada  ' + pedido.PedidoId);
      end;
      if Not vErroProcessamento then
      Begin
        gravalog('iniciando geracao do pedido caixa fracionada ' + infoPedido);
        vErroProcessamento := GerarPedidoCaixaFracionada.gerar
          (strtoint(pedido.PedidoId),

          ((Pos('PROCESSADO', UpperCase(pedido.Status)) > 0) or
          (Pos('ETIQUETA', UpperCase(pedido.Status)) > 0) or
          (Pos('RE-PROCESSADO', UpperCase(pedido.Status)) > 0)));
        if Not vErroProcessamento then
        Begin
          ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
          JsonArrayRetorno := ObjPedidoCtrl.PutRegistrarProcesso
            (strtoint(pedido.PedidoId), 2);
          if JsonArrayRetorno.Items[0].TryGetValue('Erro', verro) then
          Begin
            gravalog('        -> geracao caixa fechada com erro de processamento'
              + verro);
            TPedidosController.Pedido_CancelarCubagem(pedido.PedidoId);
          End;
          JsonArrayRetorno := Nil;
          ObjPedidoCtrl.free;
        End
        Else
        Begin
          gravalog('        -> geracao caixa fracionada com erro de processamento'
            + verro);
          TPedidosController.Pedido_CancelarCubagem(pedido.PedidoId);

        End;
      End
      Else
      Begin
        TPedidosController.Pedido_CancelarCubagem(pedido.PedidoId);
        gravalog('        -> geracao caixa fechada com erro de processamento' +
          verro);
      End;

    Except
      On E: Exception do
      Begin
        Pedido_CancelarCubagem(pedido.PedidoId);
        raise Exception.Create(E.Message);
      End
    End;
  finally
    gravalog('Peido finalizado' + infoPedido + 'tempo gasto ' +
      FormatDateTime('hh:nn:ss.zzz', now - itime));
    gravalog('free objects controler ..');
    FreeAndNil(qryestoqueCaixaFechada);
    FreeAndNil(GerarPedidoCaixaFracionada);
  end;
end;

end.
