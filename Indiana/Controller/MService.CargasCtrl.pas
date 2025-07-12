{
  VolumeEmbalagemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.CargasCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  CargasClass,
  Horse,
  Horse.Utils.ClientIP,
  System.Types,
  System.JSON,
  System.JSON.Types;

Type

  TCargasCtrl = Class
  Private
    FCarga: TCargas;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjCarga: TCargas Read FCarga Write FCarga;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCargaCarregarPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCargaCarregarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCargaCarregarVolumes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCargaCarregarVolumesPessoa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure CancelarCarregamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure CancelarConferencia(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure CancelarCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);

Procedure CargaCarregamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CargaCarregamentoFinalizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaHearder(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPessoas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPedidosRomaneio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaNotaFiscal(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPedidoVolumes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetMapaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CargaLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PedidosParaCargas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PedidosParaCargasNFs(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelAnaliseConsolidada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetResumoCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutAtualizarStatus(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetConfereCargaHeader(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetConfereCargaBody(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaAnaliseCubagemPorProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
//Integração de Cargas - Terceiros para conferência inlocl
Procedure IntegracaoImportaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure IntegracaoListaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlVolumeEmbalagem }

uses MService.CargasDAO, uFuncoes, exactwmsservice.lib.utils;

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/cargas', Get)
    .Get('/cargas4D', Get4D)
    .Get('/cargas/clientes/:cargaid', GetCargaCarregarClientes)
    .Get('/cargas/pedidos/:cargaid', GetCargaCarregarPedidos)
    .Get('/cargas/volumes/:cargaid/:pessoaid', GetCargaCarregarVolumesPessoa)
    .Delete('/cargas/cancelarcarregamento/:cargaid', CancelarCarregamento)
    .Delete('/cargas/cancelarconferencia/:cargaid', CancelarConferencia)
    .Post('/cargas', Insert)
    .Put('/cargas/:cargaid', Update)
    .Post('/cargas/carregamento', CargaCarregamento) // Registrar Carregamento
    .Put('/cargas/carregamentofinalizar', CargaCarregamentoFinalizar)
    .Delete('/cargas/:cargaid', Delete)
    .Get('/cargas/hearder/:cargaid', GetCargaHearder)
    .Get('/cargas/pessoas/:cargaid/:processo', GetCargaPessoas)
    .Get('/cargas/pedidos/:cargaid/:pessoaid/:processo', GetCargaPedidos)
    .Get('/cargas/pedidos/romaneio/:cargaid/:pessoaid/:processo', GetCargaPedidosRomaneio)
    .Get('/cargas/notafiscal/:cargaid', GetCargaNotaFiscal)
  // .Get('/cargas/volumes/:cargaid/:processo', GetCargaPedidoVolumes)     //
    .Get('/cargas/conferirvolumes/:cargaid/:processo', GetCargaPedidoVolumes)
  // GetCargaCarregarVolumes)
    .Get('/cargas/mapacarga/:cargaid', GetMapaCarga)
    .Get('/cargas/lista/:cargaid/:rotaid/:processoid/:pendente/:processo', CargaLista)
    .Put('/cargas/cancelar', CancelarCarga)
    .Get('/cargas/pedidosparacarga', PedidosParaCargas)
    .Get('/cargas/pedidosparacarganfs', PedidosParaCargasNFs)
    .Get('/cargas/analiseconsolidada', GetRelAnaliseConsolidada)
    .Get('/cargas/resumo', GetResumoCarga)
    .Put('/cargas/atualizarstatus', PutAtualizarStatus)
    .Get('/carga/conferencia/header', GetConfereCargaHeader)
    .Get('/carga/conferencia/body', GetConfereCargaBody)
    .Get('carga/analisecubagemporproduto/:cargaid/:embalagem', GetCargaAnaliseCubagemPorProduto)

    .Get('/carga/integracao', IntegracaoImportaCarga)
    .Get('/carga/integracao/lista', IntegracaoListaCarga)

end;

Procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargasDAO: TCargasDao;
begin
  Try
    Try
      ObjCargasDAO := TCargasDao.Create;
      Res.Send(ObjCargasDAO.Get4D(Req.Query.Dictionary)).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
      FreeAndNil(ObjCargasDAO);
  End;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  HrInicioLog := Time;
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.Get(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                      '/v1/cargas', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create.AddPair('Erro', E.Message));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/cargas', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

Procedure GetCargaAnaliseCubagemPorProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: Ttime;
begin
  HrInicioLog := Time;
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaAnaliseCubagemPorProduto(StrToIntDef(Req.Params.Items['cargaid'], 0),
                                                                        StrToIntDef(Req.Params.Items['embalagem'], 2));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                      '/v1/carga/analisecubagemporproduto/:cargaid/:embalagem', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/carga/analisecubagemporproduto/:cargaid/:embalagem', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetRelAnaliseConsolidada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var ObjCargaDAO      : TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog      : Ttime;
begin
  HrInicioLog := Time;
  Try
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetRelAnaliseConsolidada(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                      '/v1/cargas/analiseconsolidada', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/cargas/analiseconsolidada', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetResumoCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno: TJsonArray;
    JsonArrayErro: TJsonArray;
    HrInicioLog      : Ttime;
begin
  HrInicioLog := Time;
  Try
    ObjCargaDAO := TCargasDao.Create;
    Try
      JsonArrayRetorno := ObjCargaDAO.GetResumoCarga(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);;
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                      '/v1/cargas/resumo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/cargas/resumo', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

procedure GetCargaCarregarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO      : TCargasDao;
    JsonArrayRetorno : TjsoNArray;
    HrInicioLog      : Ttime;
begin
  HrInicioLog := Time;
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaCarregarClientes(StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                      '/v1/cargas/clientes/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/cargas/clientes/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

Procedure GetConfereCargaHeader(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetConfereCargaHeader(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/carga/conferencia/header', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/carga/conferencia/header', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetConfereCargaBody(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetConfereCargaBody(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/carga/conferencia/header', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/carga/conferencia/body', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

procedure GetCargaCarregarPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjCargaDAO      : TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog      : TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaCarregarPedidos(StrToIntDef(Req.Params.Items['cargaid'], 0))).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/pedidos/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/pedidos/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure GetCargaCarregarVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog      : TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaCarregarVolumes(StrToIntDef(Req.Params.Items['cargaid'], 0), 0, Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/carregarvolumes/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/carregarvolumes/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure GetCargaCarregarVolumesPessoa(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog      : TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaCarregarVolumes(StrToIntDef(Req.Params.Items['cargaid'], 0), StrToIntDef(Req.Params.Items['pessoaid'], 0),
                                                              Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/volumes/:cargaid/:pessoaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/volumes/:cargaid/:pessoaid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog      : TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.InsertUpdate(0, Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('cargaid', TJsonNumber.Create(JsonArrayRetorno.Items[0].GetValue<Integer>('cargaid')))).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Criado com sucesso: '+TJSONObject.Create.AddPair('cargaid', TJsonNumber.Create(JsonArrayRetorno.Items[0].GetValue<Integer>('cargaid'))).ToString(),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJsonObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog      : TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.InsertUpdate(StrToIntDef(Req.Params.Items['cargaid'], 0), Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Registro Alterado com Sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJsonObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;end;

procedure CargaCarregamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonObjectRetorno : TJsonObject;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonObjectRetorno := ObjCargaDAO.CargaCarregamento(Req.Body<TJSONObject>);
      Res.Send<TJSonObject>(JsonObjectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/carregamento', Trim(Req.Params.Content.Text), Req.Body, '', JsonObjectRetorno.ToString(),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonObjectRetorno := TJSonObject.Create;
        JsonObjectRetorno := TJSONObject.Create(TJSONPair.Create('Erro', E.Message));
        Res.Send<TJSonObject>(JsonObjectRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/carregamento', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure CargaCarregamentoFinalizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CargaCarregamentoFinalizar(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Carregamento Finalizado com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/carregamentofinalizar', Trim(Req.Params.Content.Text), Req.Body, '', 'Carregamento Finalizado com Sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/carregamentofinalizar', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

Procedure CancelarCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CancelarCarga(TJSONObject.ParseJSONValue(Req.Body) as TJSONObject);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Carregamento Cancelado com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/cancelar', Trim(Req.Params.Content.Text), Req.Body, '', 'Carregamento Cancelado com Sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
   Except on E: Exception do
     Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/cancelar', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
     End;
   End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

procedure CancelarCarregamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CancelarCarregamento(StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Carregamento Cancelado com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/cancelarcarregamento/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Carregamento Cancelado com Sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/cancelarcarregamento/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure CancelarConferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var ObjCargaDAO: TCargasDao;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CancelarConferencia(StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Conferência Cancelado com Sucesso!'))).Status(THTTPStatus.ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/cancelarconferencia/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Carregamento Cancelado com Sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/cancelarconferencia/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO       : TCargasDao;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.Delete(StrToIntDef(Req.Params.Items['cargaid'], 0), (TJSONObject.ParseJSONValue(Req.Body) as TJSONObject));
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('Ok', 'Excluído com sucesso!')).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Excluído com sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

constructor TCargasCtrl.Create;
begin
  FCarga := TCargas.Create;
end;

destructor TCargasCtrl.Destroy;
begin
  FCarga.Free;
  inherited;
end;

Procedure GetCargaHearder(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaHearder(StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/hearder/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/hearder/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPessoas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaPessoas(StrToIntDef(Req.Params.Items['cargaid'], 0), Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/pessoas/:cargaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/pessoas/:cargaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
     Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaPedidos(StrToIntDef(Req.Params.Items['cargaid'], 0),
                           StrToIntDef(Req.Params.Items['pessoaid'], 0), Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/pedidos/:cargaid/:pessoaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/pedidos/:cargaid/:pessoaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaNotaFiscal(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
  JsonRetorno: TJsonArray;
  JsonErro: TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      If StrToIntDef(Req.Params.Items['cargaid'], 0) <= 0 then
      Begin
        JsonErro := TJsonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Par�metros da consulta(Id da Carga) n�o definido!')));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, 'v1/cargas/notafiscal/:cargaid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          'Par�metros da consulta(Id da Carga) n�o definido!', 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
        JsonErro := Nil;
        ObjCargaDAO.Free;
        Exit;
      End;
      ObjCargaDAO := TCargasDao.Create;
      JsonRetorno := ObjCargaDAO.GetCargaNotaFiscal
        (StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJsonArray>(JsonRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
        0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/cargas/notafiscal/:cargaid', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonErro := TJsonArray.Create;
        JsonErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/saida', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
        JsonErro := Nil;
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPedidosRomaneio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaPedidosRomaneio(StrToIntDef(Req.Params.Items['cargaid'], 0),
                           StrToIntDef(Req.Params.Items['pessoaid'], 0), Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                     '/v1/cargas/pedidos/romaneio/:cargaid/:pessoaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                     201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/cargas/pedidos/romaneio/:cargaid/:pessoaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPedidoVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var ObjCargaDAO      : TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetCargaPedidoVolumes(StrToIntDef(Req.Params.Items['cargaid'], 0),
                           Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/cargas/conferirvolumes/:cargaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/cargas/conferirvolumes/:cargaid/:processo', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure CargaLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.CargaLista(StrToIntDef(Req.Params.Items['cargaid'], 0), StrToIntDef(Req.Params.Items['rotaid'], 0),
                                                 StrToIntDef(Req.Params.Items['processoid'], 0), StrToIntDef(Req.Params.Items['pendente'], 0),
                                                 Req.Params.Items['processo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/lista/:cargaid/:rotaid/:processoid/:pendente/:processo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/lista/:cargaid/:rotaid/:processoid/:pendente/:processo', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetMapaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.GetMapaCarga(StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/mapacarga/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/mapacarga/:cargaid', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure PedidosParaCargas(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.PedidosParaCargas(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/pedidosparacarga', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/pedidosparacarga', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure PedidosParaCargasNFs(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.PedidosParaCargasNFs(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/pedidosparacarganfs', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/pedidosparacarganfs', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure PutAtualizarStatus(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.PutAtualizarStatus(Req.Body<TJSONObject>);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/cargas/atualizarstatus', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/cargas/atualizarstatus', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure IntegracaoImportaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.IntegracaoImportaCarga(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/carga/integracao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/carga/integracao', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure IntegracaoListaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjCargaDAO: TCargasDao;
    JsonArrayRetorno : TJsonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjCargaDAO      := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.IntegracaoListaCarga(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/carga/integracao/lista', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/carga/integracao/lista', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

End.
