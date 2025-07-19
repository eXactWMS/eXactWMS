unit exectwms.services.gerarPedidos;

interface

uses
  Horse,
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  RabbitConsumer,
  Horse.GBSwagger.Register,
  Horse.GBSwagger.controller,
  System.JSON.Serializers,
  REST.JSON,
  uDmeXactWMS,
  extawms.model.pedidosProducer.pedidoDto,
  extawms.model.pedidosProducer.pedido,
  GBSwagger.Path.Attributes;

type
  TgerarPedidos = class
  public
    function gerar(list: string): Boolean;
  end;

implementation

{ TgerarPedidos }

function TgerarPedidos.gerar(list: string): Boolean;
var
  LfilaProc: string;
  LPeidoId: String;
  Lzona: string;
  Index: integer;
begin
  result := false;
  DmeXactWMS.QryTemp.sql.Clear;
  DmeXactWMS.QryTemp.sql.Add('select                                        ');
  DmeXactWMS.QryTemp.sql.Add('  Ez.ZonaId,                                  ');
  DmeXactWMS.QryTemp.sql.Add('  Ped.PedidoId,                               ');
  DmeXactWMS.QryTemp.sql.Add('  Ez.FilaProc                                 ');
  DmeXactWMS.QryTemp.sql.Add('From Pedido Ped                               ');
  DmeXactWMS.QryTemp.sql.Add('inner join PedidoProdutos PP on               ');
  DmeXactWMS.QryTemp.sql.Add('  PP.PedidoId = Ped.PedidoId      ');
  DmeXactWMS.QryTemp.sql.Add('Inner Join Produto Prd on                     ');
  DmeXactWMS.QryTemp.sql.Add(' Prd.IdProduto = PP.ProdutoId                 ');
  DmeXactWMS.QryTemp.sql.Add('Inner join Enderecamentos TEnd On             ');
  DmeXactWMS.QryTemp.sql.Add('  TEnd.EnderecoId = Prd.EnderecoId            ');
  DmeXactWMS.QryTemp.sql.Add('inner join EnderecamentoZonas Ez ON           ');
  DmeXactWMS.QryTemp.sql.Add('  Ez.ZonaId = TEnd.ZonaId                     ');
  DmeXactWMS.QryTemp.sql.Add('Inner join Rhema_Data Rd On                   ');
  DmeXactWMS.QryTemp.sql.Add('Rd.IdData = Ped.DocumentoData                 ');
  DmeXactWMS.QryTemp.sql.Add('Cross Apply (Select Top 1 ProcessoId          ');
  DmeXactWMS.QryTemp.sql.Add('             From DocumentoEtapas De          ');
  DmeXactWMS.QryTemp.sql.Add('			 where Documento = Ped.uuid             ');
  DmeXactWMS.QryTemp.sql.Add('			 Order by ProcessoId Desc) De           ');
  DmeXactWMS.QryTemp.sql.Add('Where De.ProcessoId in (1,2)                  ');
  if Length( list) > 6 then

  DmeXactWMS.QryTemp.sql.Add('  and Ped.PedidoId in (' + list +
    ')              ')
  else
     DmeXactWMS.QryTemp.sql.Add(' And Rd.Data >= ''2025-06-01'' and Rd.Data <= ''2025-06-13''');
  DmeXactWMS.QryTemp.sql.Add('Group By Ez.ZonaId, Ped.PedidoId, Ez.FilaProc ');
  DmeXactWMS.QryTemp.sql.Add('order by Ez.FilaProc,Ped.PedidoId');
  DmeXactWMS.QryTemp.Open();
  while not DmeXactWMS.QryTemp.eof do
  begin
    LfilaProc := DmeXactWMS.QryTemp.FieldByName('FilaProc').AsString;
    LPeidoId := DmeXactWMS.QryTemp.FieldByName('PedidoId').AsString;
    Lzona := DmeXactWMS.QryTemp.FieldByName('ZonaId').AsString;
    RabbitConsumer.FRabitmqObj.publishMessage(LfilaProc,
      '{"zona":"' + Lzona + '" ,"pedidoId":' + LPeidoId + '}');

    DmeXactWMS.QryTemp.Next;
  end;

end;

end.
