{
  PedidoVolumeCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PedidoVolumeCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PedidoVolumeClass, Exactwmsservice.lib.utils,
  Horse, Horse.utils.ClientIP, System.JSON; // , uTHistorico;

Type

  TPedidoVolumeCtrl = Class
  Private
    // Funções de Validação
    FPedidoVolume: TPedidoVolume;

  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjPedidoVolume: TPedidoVolume Read FPedidoVolume
      Write FPedidoVolume;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetVolume(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetOpenVolumeParaSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetVolumePrintTag(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetVolumeProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetVolumeProdutoReconferencia(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetVolumeProdutoSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetVolumeLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeProdutoLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPedidoVolumeSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure MapaSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure VolumeParaEtiquetas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure EtiquetaVolumePorRua(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Identificacao para Etiqueta volume Caixa Fracionada
Procedure EtiquetaPorVolume(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Identificacao para Etiqueta volume Caixa Fechada
Procedure identificavolumecxafechada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure RegistrarDocumentoEtapa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure RegistrarDocumentoEtapaComBaixaEstoque(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure RegistrarDocumentoEtapaSemBaixaEstoque(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure VolumeExpedicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure VolumeExpedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure VolumeExpedidoDia(Req : THorseRequest; Res : THorseResponse; Next : TProc);
Procedure SaveApanheProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarColetaComRegistro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarConferencia(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarConferenciaSemLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure FinalizarConferenciaComRegistro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GerarVolumeExtra(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GerarVolumeExtra2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPedidoVolumeEtapas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure MapaSeparacaoLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DshCheckout(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAuditoriaVolumes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAuditoriaCorteAnalitico(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure VolumeLoteSubstituicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CaixaSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Getdshvolumeevolucao_quantidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Getdshvolumeevolucao_Unidades(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ResetSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeComDivergencia(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPedidoVolumeProdutoLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProducaoDiariaPorLoja(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProducaoDiariaPorRua(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProducaoDiariaPorSetor(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProducaoDiariaPorRota(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeConsulta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeConsultaLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeExcel(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeEAN(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure salvarultimoenderecocoletado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVolumeRegistrarExpedicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPedidoCxaFechadaCheckOut(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PostVolumeLacres(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PostVolumeLacresCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DesfazerInicioCheckOutOpen(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPedidoVolume }

uses MService.PedidoVolumeDAO, uFuncoes, Services.PedidoVolume;

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/pedidovolume', Get)                 // pedidovolume/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:embalagem/:zonaid
    .Get('/pedidovolume/openvolumeparaseparacao/:caixaid/:pedidovolumeid/:usuarioid/:terminal', GetOpenVolumeParaSeparacao)
    .Get('/pedidovolumeseparacao/:pedidovolumeid', GetVolumeSeparacao)
    .Get('/pedidovolumeseparacao/:pedidoid/:pedidovolumeid', GetPedidoVolumeSeparacao)
    .Get('/pedidovolume/volumeregistrarexpedicao/:pedidovolumeid', GetVolumeRegistrarExpedicao)
    .Get('/pedidovolume/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:embalagem/:zonaid', GetVolume)
    .Get('/volumeprinttag/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:zonaid/:printtag/:embalagem', GetVolumePrintTag)
    .Get('/pedidovolume/produto/:pedidovolumeid', GetVolumeProduto)
    .Get('/pedidovolume/produto/reconferencia/:pedidovolumeid', GetVolumeProdutoReconferencia)
    .Get('/pedidovolume/produtolote/:pedidoid/:codproduto', GetPedidoVolumeProdutoLote)
    .Get('/pedidovolume/produtoseparacao/:pedidovolumeid', GetVolumeProdutoSeparacao) // GENILSON
    .Get('/pedidovolume/lotes/:pedidovolumeid', GetVolumeLote)
    .Get('/pedidovolume/produtolotes/:pedidovolumeid/:produtoid', GetVolumeProdutoLotes)
    .Get('/pedidovolume/etapas/:pedidovolumeid', GetPedidoVolumeEtapas)
    .Post('/pedidovolume/registrardocumentoetapa', RegistrarDocumentoEtapa)
    .Post('/pedidovolume/registrardocumentoetapacombaixaestoque', RegistrarDocumentoEtapaComBaixaEstoque)
    .Post('/pedidovolume/registrardocumentoetapasembaixaestoque', RegistrarDocumentoEtapaSemBaixaEstoque)
    .Put('/pedidovolume/:pedidovolumeid', Update)
    .Put('/pedidovolume/cancelar/:pedidovolumeid', Cancelar)
    .Delete('/pedidovolume/:pedidovolumeid', Delete)
    .Get('/mapaseparacao/:pedidoid/:pedidovolumeid', MapaSeparacao)
    .Get('/volumeparaetiquetas/:pedidoid/:pedidovolumeid/:zonaid/:printtag/:embalagem', VolumeParaEtiquetas)
    .Get('/etiquetaporvolume/:pedidovolumeid', EtiquetaPorVolume) // Identificação Etiqueta Volume Caixa Fracionada
    .Get('pedidovolume/etiquetaporrua', EtiquetaVolumePorRua)
    .Get('/identificavolumecxafechada/:pedidovolumeid', identificavolumecxafechada) // Identificação Etiqueta Volume Caixa Fechada
    .Get('/pedidovolume/expedicao/:codpessoaerp/:rotaid', VolumeExpedicao)
    .Get('/pedidovolume/expedido', VolumeExpedido)
    .Get('/pedidovolume/expedidodia/:usuarioid', VolumeExpedidoDia)
    .Put('/pedidovolume/saveapanheprodutos', SaveApanheProdutos)
    .Put('/pedidovolume/salvarcoletacomregistro', SalvarColetaComRegistro)
    .Put('/pedidovolume/atualizarconferencia', AtualizarConferencia)
    .Put('/pedidovolume/atualizarconferenciasemlotes', AtualizarConferenciaSemLotes)
    .Put('/pedidovolume/finalizarconferenciacomregistro', FinalizarConferenciaComRegistro)
    .Post('/pedidovolume/gerarvolumeextra/:pedidovolumeid', GerarVolumeExtra)
    .Post('/pedidovolume/gerarvolumeextra/:pedidovolumeid/:usuarioid', GerarVolumeExtra2).Get('/pedidovolume/mapaseparacaolista', MapaSeparacaoLista)
    .Get('/pedidovolume/dshcheckout', DshCheckout)
    .Get('/pedidovolume/auditoriariavolume', GetAuditoriaVolumes)
    .Get('/pedidovolume/auditoriacorte/analitico', GetAuditoriaCorteAnalitico)
    .Put('/pedidovolume/lotesubstituicao', VolumeLoteSubstituicao)
    .Post('/caixaembalagem/:pedidovolumeid/:caixaembalagemid', CaixaSeparacao)
    .Get('/pedidovolume/dshvolumeevolucao_quantidade', Getdshvolumeevolucao_quantidade)
    .Get('/pedidovolume/dshvolumeevolucao_Unidades', Getdshvolumeevolucao_Unidades)
    .Put('/pedidovolume/resetseparacao/:pedidovolumeid', ResetSeparacao)
    .Get('/pedidovolume/volumecomdivergencia/:pedidovolumeid', GetVolumeComDivergencia).Get('/pedidovolume/producaodiariaporloja', GetProducaoDiariaPorLoja)
    .Get('/pedidovolume/producaodiariaporrua', GetProducaoDiariaPorRua)
    .Get('/pedidovolume/producaodiariaporsetor', GetProducaoDiariaPorSetor).Get('/pedidovolume/producaodiariaporrota', GetProducaoDiariaPorRota)
    .Get('/pedidovolume/consulta', GetVolumeConsulta)
    .Get('/pedidovolume/excel', GetVolumeExcel)
    .Get('/pedidovolume/consultalotes', GetVolumeConsultalotes)
    .Get('/pedidovolume/ean/:pedidovolumeid', GetVolumeEAN)
    .Get('/pedidovolume/salvarultimoenderecocoletado/:pedidovolumeid/:enderecoid', salvarultimoenderecocoletado)
    .Get('/pedidovolume/getpedidocxafechadacheckout/:pedidovolumeid/:usuarioid/:terminal', GetPedidoCxaFechadaCheckOut)
    .Post('/pedidovolume/lacres', PostVolumeLacres)
    .Get('/pedidovolume/lacres/carga/:cargaid', PostVolumeLacresCarga)
    .Delete('/pedidovolume/desfazeriniciocheckoutopen/:pedidovolumeid', DesfazerInicioCheckOutOpen)

end;

Procedure AtualizarConferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
  JsonArrayReq: TJsonArray;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[216 - AtualizarConferencia] executando ');
    Try
      JsonArrayRetorno := TJsonArray.Create;; // Req.Body<TJsonArray>;
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      // Req.Body<TJsonArray> ;
      JsonArrayRetorno := PedidoVolumeDAO.AtualizarConferencia
        (TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0)
        as TJsonArray, Nil);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/atualizarconferencia', Trim(Req.Params.Content.Text),
        Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
        [rfReplaceAll]), 200, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Tutil.Gravalog('[234 - AtualizarConferencia] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/atualizarconferencia', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure AtualizarConferenciaSemLotes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[263- AtualizarConferenciaSemLotes] executando');
    Try
      JsonArrayRetorno := TJsonArray.Create;; // Req.Body<TJsonArray>;
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.AtualizarConferenciaSemLotes
        (Req.Body<TJsonArray>, Nil);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/atualizarconferenciasemlotes',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Tutil.Gravalog('[AtualizarConferenciaSemLotes] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/atualizarconferenciasemlotes',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure FinalizarConferenciaComRegistro(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
Var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[309-FinalizarConferenciaComRegistro] executando');
    Try
      JsonArrayRetorno := TJsonArray.Create;; // Req.Body<TJsonArray>;
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.FinalizarConferenciaComRegistro(Req.Body<TJSONObject>, Nil);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                     '/v1/pedidovolume/finalizarconferenciacomregistro', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                     200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[FinalizarConferenciaComRegistro] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/pedidovolume/finalizarconferenciacomregistro', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                       500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GerarVolumeExtra(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno, JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[354-GerarVolumeExtra] executando');
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.GerarVolumeExtra
        (Req.Params.Items['pedidovolumeid'].ToInteger(), 1,
        TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0)
        as TJsonArray);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/gerarvolumeextra/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[GerarVolumeExtra] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/gerarvolumeextra/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GerarVolumeExtra2(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[401 GerarVolumeExtra2] executando');
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.GerarVolumeExtra
        (Req.Params.Items['pedidovolumeid'].ToInteger(),
        Req.Params.Items['usuarioid'].ToInteger(),
        TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0)
        as TJsonArray);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/gerarvolumeextra/:pedidovolumeid/:usuarioid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[GerarVolumeExtra2] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/gerarvolumeextra/:pedidovolumeid/:usuarioid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure ResetSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonArrayErro: TJsonArray;
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[448-ResetSeparacao] executando');
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.ResetSeparacao
        (Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/resetseparacao/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[ResetSeparacao] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/resetseparacao/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure SalvarColetaComRegistro(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  PedidoVolumeDAO: TPedidoVolumeDAO;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[493-SalvarColetaComRegistro] executando ');
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.SalvarColetaComRegistro(Req.Body<TJSONObject>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/salvarcoletacomregistro', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[SalvarColetaComRegistro] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/salvarcoletacomregistro', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure SaveApanheProdutos(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  PedidoVolumeDAO: TPedidoVolumeDAO;
  HrInicioLog: Ttime;

begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[539 - SaveApanheProdutos] executando ');
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.SaveApanheProdutos(Req.Body<TJsonArray>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/saveapanheprodutos', Trim(Req.Params.Content.Text),
        Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
        [rfReplaceAll]), 200, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Tutil.Gravalog('[SaveApanheProdutos] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);

        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/saveapanheprodutos', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure EtiquetaVolumePorRua(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var JsonArrayRetorno: TJsonArray;
    LService: TServicePedidoVolume;
    JsonArrayErro: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Tutil.Gravalog('[583 EtiquetaVolumePorRua] executando');
    Try
      JsonArrayRetorno := LService.EtiquetaVolumePorRua(TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSONObject);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/etiquetaporrua', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                      ' Registros.', 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do Begin
        Tutil.Gravalog('[598 - EtiquetaVolumePorRua] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/pedidovolume/etiquetaporrua', Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
                       Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure VolumeParaEtiquetas(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[625-VolumeParaEtiquetas] executando');
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.VolumeParaEtiquetas
        (Req.Params.Items['pedidoid'].ToInteger(),
        Req.Params.Items['pedidovolumeid'].ToInteger(),
        Req.Params.Items['zonaid'].ToInteger(),
        Req.Params.Items['printtag'].ToInteger(),
        Req.Params.Items['embalagem'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/volumeparaetiquetas/:pedidoid/:pedidovolumeid/:zonaid/:printtag/:embalagem',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Tutil.Gravalog('[VolumeParaEtiquetas] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/volumeparaetiquetas/:pedidoid/:pedidovolumeid/:zonaid/:printtag/:embalagem',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure VolumeExpedicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PedidoVolumeDAO: TPedidoVolumeDAO;
    JsonArrayErro: TJsonArray;
    LService: TServicePedidoVolume;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[674- VolumeExpedicao] executando');
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.VolumeExpedicao(Req.Params.Items['codpessoaerp'].ToInteger(),
                                                   Req.Params.Items['rotaid'].ToInteger()) ;
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/expedicao', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[VolumeExpedicao] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/expedicao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure VolumeExpedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Tutil.Gravalog('[VolumeExpedido] terminal ' + ClientIP(Req));
    Try
      JsonArrayRetorno := LService.VolumeExpedido;
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/expedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      JsonArrayRetorno := Nil;
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[VolumeExpedido] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/expedido', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
        JsonArrayErro := Nil;
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure VolumeExpedidoDia(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayErro: TJsonArray;
    LService: TServicePedidoVolume;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Tutil.Gravalog('[VolumeExpedidoDia] terminal ' + ClientIP(Req));
    Try
      if StrToIntDef(Req.Params.Items['usuarioid'], 0) <= 0 Then
         Raise Exception.Create('Id de usuário inválido!');
      JsonArrayRetorno := LService.VolumeExpedidoDia(StrToIntDef(Req.Params.Items['usuarioid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/expedidodia', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      JsonArrayRetorno := Nil;
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[VolumeExpedidodia] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/expedidodia', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
        JsonArrayErro := Nil;
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure VolumeLoteSubstituicao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;

    Tutil.Gravalog('[VolumeLoteSubstituicao] terminal ' + ClientIP(Req));
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.VolumeLoteSubstituicao
        (Req.Body<TJSONObject>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/lotesubstituicao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[VolumeLoteSubstituicao] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/lotesubstituicao', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
                        [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure EtiquetaPorVolume(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoVolumeDAO: TPedidoVolumeDAO;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[EtiquetaPorVolume] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.EtiquetaPorVolume(Req.Params.Items['pedidovolumeid'].ToInteger());
      PedidoVolumeDAO.ObjPedidoVolume.PedidoVolumeId := Req.Params.Items['pedidovolumeid'].ToInteger();
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/etiquetaporvolume/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                      ' Registros.', 201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[EtiquetaPorVolume] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/etiquetaporvolume/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                        ' Registros.', 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure identificavolumecxafechada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[identificavolumecxafechada] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.identificavolumecxafechada(Req.Params.Items['pedidovolumeid'].ToInteger());
      PedidoVolumeDAO.ObjPedidoVolume.PedidoVolumeId := Req.Params.Items['pedidovolumeid'].ToInteger();
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/identificavolumecxafechada/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[identificavolumecxafechada] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/identificavolumecxafechada/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure CaixaSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[CaixaSeparacao] terminal ' + ClientIP(Req));
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.CaixaSeparacao
        (StrToIntDef(Req.Params.Items['pedidovolumeid'], 0),
        StrToIntDef(Req.Params.Items['caixaembalagemid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/caixaembalagem/:pedidovolumeid/:caixaembalagemid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[CaixaSeparacao] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/caixaembalagem/:pedidovolumeid/:caixaembalagemid',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var LService: TServicePedidoVolume;
    JsonArrayErro: TJsonArray;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Try
      If (Req.Body<TJSONObject>.GetValue<Integer>('pedidoId') = 0) and (Req.Body<TJSONObject>.GetValue<Integer>('pedidoVolumeId') = 0) then
         raise Exception.Create('Para Cancelamento informe o Pedido e/ou Volume!');

      JsonArrayRetorno := LService.Cancelar(Nil, Req.Body<TJSONObject>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/cancelar/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Reg.Cancelado(s).',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/cancelar/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[ControlPedidoVolumeGet] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetPedidoVolumeSeparacao(0, 0);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[ControlPedidoVolumeGet] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

procedure GetVolume(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.GetVolume(StrToIntDef(Req.Params.Items['pedidoid'], 0), StrToIntDef(Req.Params.Items['pedidovolumeid'], 0),
                                             StrToIntDef(Req.Params.Items['sequencia'], 0), StrToIntDef(Req.Params.Items['ordem'], 0),
                                             Req.Params.Items['embalagem'], StrToIntDef(Req.Params.Items['zonaid'], 0));
                                             Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:embalagem/:zonaid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[GetVolume] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', TUtil.TratarExcessao(E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:embalagem/:zonaid', Trim(Req.Params.Content.Text), Req.Body, '', TUtil.TratarExcessao(E.Message),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetOpenVolumeParaSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayErro: TJsonArray;
    LService: TServicePedidoVolume;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
    Erro: Boolean;
    nTentativa: Integer;
begin
  HrInicioLog := Time;
  Tutil.Gravalog('[1070-GetOpenVolumeParaSeparacao] terminal: ' + ClientIP(Req));
  nTentativa := 1;
  Repeat
    Erro := True;
    Try
      Try
        LService := TServicePedidoVolume.Create;
        JsonArrayRetorno := LService.GetOpenVolumeParaSeparacao(StrToIntDef(Req.Params.Items['caixaid'], 0),
                            StrToIntDef(Req.Params.Items['pedidovolumeid'], 0), StrToIntDef(Req.Params.Items['usuarioid'], 0),
                            Req.Params.Items['terminal']);
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/openvolumeparaseparacao/:caixaid/:pedidovolumeid/:usuarioid/:terminal',
                        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
                        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        Erro := False;
      Except on E: Exception do Begin
        Inc(nTentativa);
        if nTentativa > 3 then Begin
           Tutil.Gravalog('[GetOpenVolumeParaSeparacao] ' + E.Message);
           JsonArrayRetorno := TJsonArray.Create;
           JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
           Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/pedidovolume/openvolumeparaseparacao/:caixaid/:pedidovolumeid/:usuarioid/:terminal',
                           Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
                           [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           Erro := False;
        End
        Else Begin
          Inc(nTentativa);
          Sleep(50);
        End;
        End;
      End;
    Finally
      FreeAndNil(LService);
    End;
  Until (Erro = False);
End;

Procedure GetVolumeRegistrarExpedicao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1134-GetVolumeRegistrarExpedicao] terminal: ' +
      ClientIP(Req));
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.GetVolumeRegistrarExpedicao
        (StrToIntDef(Req.Params.Items['pedidovolumeid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/volumeregistrarexpedicao/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '','Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[GetVolumeRegistrarExpedicao] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/pedidovolume/volumeregistrarexpedicao/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                       500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetVolumePrintTag(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;
begin
  Try
    Tutil.Gravalog('[1199-GetVolumePrintTag] ' + ClientIP(Req));
    HrInicioLog := Time;
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.GetVolumePrintTag
        (StrToIntDef(Req.Params.Items['pedidoid'], 0),
        StrToIntDef(Req.Params.Items['pedidovolumeid'], 0),
        StrToIntDef(Req.Params.Items['sequencia'], 0),
        StrToIntDef(Req.Params.Items['ordem'], 0),
        StrToIntDef(Req.Params.Items['zonaid'], 0),
        StrToIntDef(Req.Params.Items['printtag'], 0),
        StrToIntDef(Req.Params.Items['embalagem'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/volumeprinttag/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:zonaid/:printtag/:embalagem',
                      Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1199-GetVolumePrintTag] ' + E.Message);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/volumeprinttag/:pedidoid/:pedidovolumeid/:sequencia/:ordem/:zonaid/:printtag/:embalagem', Trim(Req.Params.Content.Text),
                       Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
                       500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetAuditoriaCorteAnalitico(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var LService: TServicePedidoVolume;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[GetAuditoriaCorteAnalitico] terminal: ' + ClientIP(Req));
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := LService.GetAuditoriaCorteAnalitico(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/auditoriacorte/analitico', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[GetAuditoriaCorteAnalitico] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/auditoriacorte/analitico', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetAuditoriaVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServicePedidoVolume;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Tutil.Gravalog('[1273 -GetAuditoriaVolumes] terminal  ' + ClientIP(Req));
    Try
      JsonArrayRetorno := LService.GetAuditoriaVolumes(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/auditoriariavolume', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[GetAuditoriaVolumes] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/auditoriariavolume', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetPedidoVolumeEtapas(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('1313 GetPedidoVolumeEtapas] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetPedidoVolumeEtapas(StrToIntDef(Req.Params.Items['pedidovolumeid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno)
        .Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/etapas/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('GetPedidoVolumeEtapas] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/etapas/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

procedure GetVolumeLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    PedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Tutil.Gravalog('1357-GetVolumeLote] terminal ' + ClientIP(Req));
    Try
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeLote(StrToIntDef(Req.Params.Items['pedidovolumeid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/lotes/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString +
                      ' Registros.', 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('GetVolumeLote] ' + E.Message);
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/lotes/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

Procedure GetVolumeProdutoLotes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1401- GetVolumeProdutoLotes] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO  := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeProdutoLotes(StrToIntDef(Req.Params.Items['pedidovolumeid'], 0), StrToIntDef(Req.Params.Items['produtoid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/produtolotes/:pedidovolumeid/:produtoid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1419- GetVolumeProdutoLotes] ' + E.Message + ' Terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/produtolotes/:pedidovolumeid/:produtoid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

procedure GetVolumeProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1447-GetVolumeProduto] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeProduto(StrToIntDef(Req.Params.Items['pedidovolumeid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/produto/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1464 -GetVolumeProduto] ' + E.Message + ' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/pedidovolume/produto/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                       500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

procedure GetVolumeProdutoReconferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1492- GetVolumeProdutoReconferencia] terminal ' +
      ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeProdutoReconferencia(StrToIntDef(Req.Params.Items['pedidovolumeid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/produto/reconferencia/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1509-GetVolumeProdutoReconferencia] ' + E.Message +' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/produto/reconferencia/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

Procedure GetPedidoVolumeProdutoLote(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno, JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Tutil.Gravalog('[1538-GetPedidoVolumeProdutoLote] terminal ' + ClientIP(Req));
    Try
      JsonArrayRetorno := LService.GetPedidoVolumeProdutoLote(Req.Params.Items['pedidoid'].ToInteger(),
                          Req.Params.Items['codproduto'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/produtolote/:pedidoid/:codproduto', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1554-GetPedidoVolumeProdutoLote] ' + E.Message + 'terminal: ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/produtolote/:pedidoid/:codproduto', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetProducaoDiariaPorLoja(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonRetorno: TJSONObject;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1582- GetProducaoDiariaPorLoja] terminal ' +
      ClientIP(Req));
    PedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Try
      JsonRetorno := PedidoVolumeDAO.GetProducaoDiariaPorLoja
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJSONObject>(JsonRetorno)
        .Status(THTTPStatus.Created);
      // Ver Retorno e pegar total do Header
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/producaodiariaporloja', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1599-GetProducaoDiariaPorLoja] ' + E.Message +
          ' terminal ' + ClientIP(Req));
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/producaodiariaporloja',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetProducaoDiariaPorRua(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonRetorno: TJSONObject;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1626-GetProducaoDiariaPorRua] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      // Ver Retorno e pegar total do Header
      JsonRetorno := PedidoVolumeDAO.GetProducaoDiariaPorRua
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJSONObject>(JsonRetorno)
        .Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/producaodiariaporrua', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1643-GetProducaoDiariaPorRua] ' + E.Message +
          ' terminal ' + ClientIP(Req));
        Res.Status(500).Send<TJSONObject>
          ((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/producaodiariaporrua',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetProducaoDiariaPorRota(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonRetorno: TJSONObject;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1670- GetProducaoDiariaPorRua] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonRetorno := PedidoVolumeDAO.GetProducaoDiariaPorRota
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJSONObject>(JsonRetorno)
        .Status(THTTPStatus.Created);
      // Ver Retorno e pegar total do Header
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/producaodiariaporrota', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1687-GetProducaoDiariaPorRua] ' + E.Message +
          ' terminal' + ClientIP(Req));
        Res.Status(500).Send<TJSONObject>
          ((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/producaodiariaporrota',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetProducaoDiariaPorSetor(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonRetorno: TJSONObject;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1714-GetProducaoDiariaPorSetor] termonal ' +
      ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonRetorno := PedidoVolumeDAO.GetProducaoDiariaPorSetor
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJSONObject>(JsonRetorno)
        .Status(THTTPStatus.Created);
      // Ver Retorno e pegar total do Header
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/producaodiariaporsetor',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.', 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      begin
        Tutil.Gravalog('[1732-GetProducaoDiariaPorSetor] ' + E.Message +
          ' terminal:' + ClientIP(Req));
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/producaodiariaporsetor',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetVolumeConsulta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoVolumeDAO: TPedidoVolumeDAO;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1770-GetVolumeConsulta]  terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeConsulta(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/consulta', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                      ' Registros.', 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1770-GetVolumeConsulta] ' + E.Message + ' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/consulta', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetVolumeExcel(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoVolumeDAO: TPedidoVolumeDAO;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeExcel(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/excel', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                      ' Registros.', 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/excel', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetVolumeConsultaLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoVolumeDAO: TPedidoVolumeDAO;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1770-GetVolumeConsultaLotes]  terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeConsultaLotes(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/consultalotes', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                      ' Registros.', 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1770-GetVolumeConsulta] ' + E.Message + ' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/consultalotes', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure GetPedidoCxaFechadaCheckOut(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonObjectRetorno, JsonArrayErro: TJSONObject;
    LService: TServicePedidoVolume;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1813-GetPedidoCxaFechadaCheckOu] terminal '+ClientIP(Req));
    LService := TServicePedidoVolume.Create;
    Try
      JsonObjectRetorno := LService.GetPedidoCxaFechadaCheckOut(Req.Params.Items['pedidovolumeid'].ToInteger(),
                           Req.Params.Items['usuarioid'].ToInteger(),
                           Req.Params.Items['terminal']);
      Res.Status(200).Send<TJSONObject>(JsonObjectRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/getpedidocxafechadacheckout/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonObjectRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[1813-GetPedidoCxaFechadaCheckOu] ' + E.Message + 'terminal ' + ClientIP(Req));
        JsonObjectRetorno := TJSONObject.Create;
        JsonObjectRetorno.AddPair('Erro', E.Message);
        Res.Status(500).Send<TJSONObject>(JsonObjectRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/getpedidocxafechadacheckout/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetVolumeEAN(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonArrayRetorno, JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1853-GetVolumeEAN]  terminal' + ClientIP(Req));
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.GetVolumeEAN
        (Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/ean/:pedidovolumeid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 200, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1853-GetVolumeEAN] ' + E.Message + ' terminal ' +
          ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/ean/:pedidovolumeid', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure GetVolumeProdutoSeparacao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1889-GetVolumeProdutoSeparacao] terminal ' +
      ClientIP(Req));
    PedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Try
      JsonArrayRetorno := PedidoVolumeDAO.GetVolumeProdutoSeparacao
        (StrToIntDef(Req.Params.Items['pedidovolumeid'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/produtoseparacao/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1889-GetVolumeProdutoSeparacao] ' + E.Message +
          ' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/produtoseparacao/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

procedure GetVolumeSeparacao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1942-GetVolumeSeparacao] terminal ' + ClientIP(Req));
    try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := TJsonArray.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetPedidoVolumeSeparacao(0,
        Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno)
        .Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1//pedidovolumeseparacao/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1942-GetVolumeSeparacao] ' + E.Message + ' terminal' +
          ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1//pedidovolumeseparacao/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

procedure GetPedidoVolumeSeparacao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[1989-GetPedidoVolumeSeparacao] terminal ' + ClientIP(Req));
    try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := TJsonArray.Create;
      JsonArrayRetorno := PedidoVolumeDAO.GetPedidoVolumeSeparacao
        (Req.Params.Items['pedidoid'].ToInteger(),
        Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno)
        .Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolumeseparacao/:pedidoid/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[1989-GetPedidoVolumeSeparacao] ' + E.Message +
          ' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolumeseparacao/:pedidoid/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

Procedure MapaSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2035-MapaSeparacao] iterminal ' + ClientIP(Req));
    try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := TJsonArray.Create;
      JsonArrayRetorno := PedidoVolumeDAO.MapaSeparacao
        (Req.Params.Items['pedidoid'].ToInteger(),
        Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno)
        .Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/mapaseparacao/:pedidoid/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2035-MapaSeparacao] ' + E.Message + ' terminal ' +
          ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/mapaseparacao/:pedidoid/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
End;

Procedure MapaSeparacaoLista(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2081-MapaSeparacaoLista]  terminal ' + ClientIP(Req));
    try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      JsonArrayRetorno := TJsonArray.Create;
      JsonArrayRetorno := PedidoVolumeDAO.MapaSeparacaoLista
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno)
        .Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/gerarvolumeextra/:pedidovolumeid/:usuarioid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2081-MapaSeparacaoLista] ' + E.Message + ' terminal' +
          ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/gerarvolumeextra/:pedidovolumeid/:usuarioid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

Procedure PostVolumeLacres(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayRetorno: TJsonArray;
    LService: TServicePedidoVolume;
    JsonArrayErro: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := TJsonArray.Create;
      JsonArrayRetorno := LService.PostVolumeLacres(Req.Body<TJSONObject>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/lacres', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[2127-RegistrarDocumentoEtapa] ' + E.Message +' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/lacres', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure PostVolumeLacresCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayRetorno: TJsonArray;
    LService: TServicePedidoVolume;
    JsonArrayErro: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Try
      JsonArrayRetorno := TJsonArray.Create;
      If (StrToIntDef(Req.Params.Items['cargaid'], 0) <= 0) then
         Raise Exception.Create('Identificação de carga inválido');
      JsonArrayRetorno := LService.GetVolumeLacrescarga(StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/lacres/carga/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[2127-RegistrarDocumentoEtapa] ' + E.Message +' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/lacres/carga/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;


Procedure RegistrarDocumentoEtapa(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Try
      JsonArrayRetorno := TJsonArray.Create;
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.RegistrarDocumentoEtapa(Req.Body<TJSONObject>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/registrardocumentoetapa', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Tutil.Gravalog('[2127-RegistrarDocumentoEtapa] ' + E.Message +' terminal ' + ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/registrardocumentoetapa', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure RegistrarDocumentoEtapaComBaixaEstoque(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
  Erro: Boolean;
  nTentativa: Integer;
begin
  HrInicioLog := Time;
  Repeat
    nTentativa := 0;
    Erro := True;
    Try
      Try
        LService := TServicePedidoVolume.Create;
        JsonArrayRetorno := LService.RegistrarDocumentoEtapaComBaixaEstoque
          (Req.Body<TJSONObject>);
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/registrardocumentoetapacombaixaestoque',
          Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        Erro := False;
      Except on E: Exception do
        Begin
          Inc(nTentativa);
          if nTentativa > 3 then
          Begin
            Tutil.Gravalog('[2181-RegistrarDocumentoEtapaComBaixaEstoque] ' +
              E.Message + ' terminal ' + ClientIP(Req));
            JsonArrayRetorno := TJsonArray.Create;
            JsonArrayRetorno.AddElement
              (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
            Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
            Tutil.SalvarLog(Req.MethodType,
              StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
              ClientIP(Req), THorse.Port,
              '/v1/pedidovolume/registrardocumentoetapacombaixaestoque',
              Trim(Req.Params.Content.Text), Req.Body, '',
              StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
              500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] +
              '_V: ' + Req.Headers['versao']);
            Erro := False;
          End
          Else
          Begin
            Sleep(500);
          End;
        End;
      End;
    Finally
      FreeAndNil(LService);
    End;
  Until (Erro = False);
End;

Procedure RegistrarDocumentoEtapaSemBaixaEstoque(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonArrayRetorno : TJsonArray;
  LService         : TServicePedidoVolume;
  JsonArrayErro    : TJsonArray;
  HrInicioLog      : Ttime;
  Erro             : Boolean;
  nTentativa       : Integer;
begin
  HrInicioLog := Time;
  nTentativa  := 0;
  Repeat
    Erro := True;
    Tutil.Gravalog('[2240-RegistrarDocumentoEtapaSemBaixaEstoque] terminal ' + ClientIP(Req));
    Try
      Try
        LService := TServicePedidoVolume.Create;
        JsonArrayRetorno := LService.RegistrarDocumentoEtapaSemBaixaEstoque(Req.Body<TJSONObject>);
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/registrardocumentoetapasembaixaestoque', Trim(Req.Params.Content.Text), Req.Body, '',
                        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200, ((Time - HrInicioLog) / 1000),
                        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        Erro := False;
      Except on E: Exception do
        Begin
          Inc(nTentativa);
          if nTentativa > 3 then Begin
             Tutil.Gravalog('[2240-RegistrarDocumentoEtapaSemBaixaEstoque] ' + E.Message + ' terminal ' + ClientIP(Req));
             JsonArrayRetorno := TJsonArray.Create;
             JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
             Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
             Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                             '/v1/pedidovolume/registrardocumentoetapasembaixaestoque', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                             500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
             Erro := False;
          End
          Else
          Begin
            Inc(nTentativa);
            Sleep(300);
          End;
        End;
      End;
    Finally
      FreeAndNil(LService);
    End;
  Until (Erro = False);
End;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2316-Update] terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      PedidoVolumeDAO.ObjPedidoVolume :=
        PedidoVolumeDAO.ObjPedidoVolume.JsonToClass
        (Req.Body<TJSONObject>.ToString());
      if PedidoVolumeDAO.Salvar then
      Begin
        Res.Status(200).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/:pedidovolumeid', Trim(Req.Params.Content.Text),
          Req.Body, '', (TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).ToString(), 200,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End
      else
      Begin

        Res.Status(200).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro',
          'Ocorreu um erro desconhecido!'))).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/:pedidovolumeid', Trim(Req.Params.Content.Text),
          Req.Body, '', (TJSONObject.Create(TJSONPair.Create('Erro',
          'Erro desconhecido! Não foi possível salvar os dados'))).ToString(),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2316-Update] ' + E.Message + ' terminal ' +
          ClientIP(Req));
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2361-Update] ' + ' terminal ' + ClientIP(Req));
    Try
      PedidoVolumeDAO := TPedidoVolumeDAO.Create;
      PedidoVolumeDAO.ObjPedidoVolume.PedidoVolumeId :=
        StrToIntDef(Req.Params.Items['pedidovolumeid'], 0);
      PedidoVolumeDAO.Delete;
      Res.Status(200).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro excluído com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/:pedidovolumeid', Trim(Req.Params.Content.Text),
        Req.Body, '', (TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro excluído com Sucesso!'))).ToString(), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2361-Update] ' + E.Message + ' terminal ' +
          ClientIP(Req));
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/:pedidovolumeid', Trim(Req.Params.Content.Text),
          Req.Body, '',
          StringReplace((TJSONObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

Procedure Getdshvolumeevolucao_quantidade(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  AQueryParam: TDictionary<String, String>;
  vDataIni: TDateTime;
  vRotaId: Integer;
  vCodPessoaERP: Integer;
  vZonaId: Integer;
  vParamsOk: Integer;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2489-Getdshvolumeevolucao] terminal '+ClientIP(Req));
    LService := TServicePedidoVolume.Create;
    Try
      vDataIni := 0;
      vRotaId := 0;
      vCodPessoaERP := 0;
      vZonaId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin

        JsonArrayErro := TJsonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/dshvolumeevolucao_quantidade',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      vParamsOk := 0;

      if AQueryParam.ContainsKey('datainicio') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJsonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/pedidovolume/dshvolumeevolucao_quantidade',
            Trim(Req.Params.Content.Text), Req.Body, '',
            StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
            ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
            Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('rotaid') then
      Begin
        vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('zonaid') then
      Begin
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codpessoaerp') then
      Begin
        vCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then Begin
         JsonArrayErro := TJsonArray.Create();
         JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
         Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedidovolume/dshvolumeevolucao_quantidade', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(LService);
         Exit;
      End;
      JsonArrayRetorno := LService.Getdshvolumeevolucao_quantidade(vDataIni, vRotaId, vZonaId, vCodPessoaERP);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/dshvolumeevolucao_quantidade', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Tutil.Gravalog('[2489-Getdshvolumeevolucao] ' + E.Message +' terminal '+ClientIP(Req));
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/dshvolumeevolucao_quantidade', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure Getdshvolumeevolucao_Unidades(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  LService: TServicePedidoVolume;
  JsonArrayErro: TJsonArray;
  AQueryParam: TDictionary<String, String>;
  vDataIni: TDateTime;
  vRotaId: Integer;
  vCodPessoaERP: Integer;
  vZonaId: Integer;
  vParamsOk: Integer;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2611-Getdshvolumeevolucao_Unidades] terminal '+ClientIP(Req));
    LService := TServicePedidoVolume.Create;
    Try
      vDataIni := 0;
      vRotaId := 0;
      vCodPessoaERP := 0;
      vZonaId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayErro := TJsonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/dshvolumeevolucao_Unidades',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('datainicio') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJsonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/pedidovolume/dshvolumeevolucao_Unidades',
            Trim(Req.Params.Content.Text), Req.Body, '',
            StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
            ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
            Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('rotaid') then
      Begin
        vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('zonaid') then
      Begin
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codpessoaerp') then
      Begin
        vCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then
      Begin
        JsonArrayErro := TJsonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta definidos incorretamente!')));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/dshvolumeevolucao_Unidades',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.Getdshvolumeevolucao_Unidades(vDataIni,
        vRotaId, vZonaId, vCodPessoaERP);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/dshvolumeevolucao_Unidades',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2611-Getdshvolumeevolucao_Unidades] ' + E.Message +' terminal '+ClientIP(Req));
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/dshvolumeevolucao_Unidades',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure DesfazerInicioCheckOutOpen(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var LService: TServicePedidoVolume;
    JsonArrayErro: TJsonArray;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Try
      If (Req.Params.Items['pedidovolumeid'].ToInteger() <= 0) then
         raise Exception.Create('Id('+Req.Params.Items['pedidovolumeid']+') de Volume inválido!');
      JsonArrayRetorno := LService.DesfazerInicioCheckOutOpen(Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/desfazeriniciocheckoutopen/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Operação de (Re)CheckOut cancelada.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/DesfazerInicioCheckOutOpen/:pedidovolumeid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure DshCheckout(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoVolumeDAO: TPedidoVolumeDAO;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;
begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2669-DshCheckout] terminal '+ClientIP(Req));
    PedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Try
      If Req.Query.Dictionary.Count <= 0 then
      Begin
        JsonArrayErro := TJsonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/dshcheckout', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(PedidoVolumeDAO);
        Exit;
      End;
      JsonArrayRetorno := PedidoVolumeDAO.DshCheckout(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/dshcheckout', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2669-DshCheckout] ' + E.Message+ ' terminal '+ClientIP(Req));
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedidovolume/dshcheckout', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeDAO);
  End;
end;

Procedure GetVolumeComDivergencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  LService: TServicePedidoVolume;
  HrInicioLog: Ttime;

begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoVolume.Create;
    Tutil.Gravalog('[2714-GetVolumeComDivergencia] terminal '+ClientIP(Req));
    Try
      JsonArrayRetorno := LService.GetVolumeComDivergencia
        (Req.Params.Items['pedidovolumeid'].ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/volumecomdivergencia/:pedidovolumeid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Tutil.Gravalog('[2714-GetVolumeComDivergencia] ' + E.Message +' terminal '+ClientIP(Req));
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/volumecomdivergencia/:pedidovolumeid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 200,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure salvarultimoenderecocoletado(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServicePedidoVolume;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  HrInicioLog: Ttime;

begin
  Try
    HrInicioLog := Time;
    Tutil.Gravalog('[2761-salvarultimoenderecocoletado] terminal '+ClientIP(Req));
    Try
      LService := TServicePedidoVolume.Create;
      JsonArrayRetorno := LService.salvarultimoenderecocoletado
        (StrToIntDef(Req.Params.Items['pedidovolumeid'], 0),
        StrToIntDef(Req.Params.Items['enderecoid'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedidovolume/salvarultimoenderecocoletado/:pedidovolumeid/:enderecoid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Tutil.Gravalog('[2761-salvarultimoenderecocoletado] ' + E.Message +' terminal '+ClientIP(Req));
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedidovolume/salvarultimoenderecocoletado/:pedidovolumeid/:enderecoid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 200,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

constructor TPedidoVolumeCtrl.Create;
begin
  FPedidoVolume := TPedidoVolume.Create;
end;

destructor TPedidoVolumeCtrl.Destroy;
begin
  FreeAndNil(FPedidoVolume);
  inherited;
end;

End.
