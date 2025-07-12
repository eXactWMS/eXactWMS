{
  InventarioCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 23/02/2022
  Projeto: RhemaWMS
}
unit MService.InventarioCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  InventarioClass, Exactwmsservice.lib.utils,
  Horse,
  Horse.utils.ClientIP,
  System.JSON; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TInventarioCtrl = Class
  Private
    // Funções de Validação
    FInventario: TInventario;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjInventario: TInventario Read FInventario Write FInventario;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetLoteInventariado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ZerarEndereco(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SaveContagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure InventarioFechar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Pendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Contagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ApuracaoInventarioEndereco(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ApuracaoInventarioProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure LimparContagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetInventarioConsultaIntegracao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutInventarioIntegracao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutInventarioIntegracaoLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDSHAcompanhamentoContagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarModeloInventario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetModeloInventarioLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CongelarEstoqueInicial(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GerarNovoInventarioModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelatorioAjuste(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlInventario }

uses MService.InventarioDAO, uFuncoes, Services.Inventario;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/inventario', Get)
    .Get('/inventario/:inventarioid', GetId)
    .Get('/inventario/itens/:inventarioid', GetItens)
    .Get('/inventario/loteinventariado', GetLoteInventariado)
    .Post('/inventario', Insert)
    .Post('/inventario/zerarendereco/:inventarioid/:enderecoid/:produtoid', ZerarEndereco)
    .Post('/inventario/savecontagem', SaveContagem)
    .Put('/inventario/:inventarioid', Update)
    .Delete('/inventario/cancelar', Cancelar)
    .Delete('/inventario/:inventarioid', Delete)
    .Get('/inventario/pendente', Pendente)
    .Get('/inventario/contagem/:item', Contagem)
    .Post('/inventario/fechar', InventarioFechar)
    .Post('/inventario/apuracao/endereco', ApuracaoInventarioEndereco)

    .Post('/inventario/apuracao/produto', ApuracaoInventarioProduto)
    .Put('/inventario/limparcontagem/:inventarioid/:enderecoid/:produtoid', LimparContagem)
    .Get('/inventario/integracao/consulta', GetInventarioConsultaIntegracao)
    .Put('/inventario/integracao/:inventarioid', PutInventarioIntegracao)
    .Put('/inventario/integracaolote/:inventarioid', PutInventarioIntegracaoLote)
    .Get('/inventario/dshcontageminventario', GetDSHAcompanhamentoContagem)
    .Post('/inventario/salvarmodeloinventario', SalvarModeloInventario)
    .Get('/inventario/modelo/lista/:modeloid', GetModeloInventarioLista)
    .Post('/inventario/congelarestoqueinicial/:inventarioid/:inventariotipo', CongelarEstoqueInicial)
    .Post('/inventario/gerarnovoinventariomodelo/:modeloid/:usuarioid/:pterminal', GerarNovoInventarioModelo)
    .Get('/inventario/relatorio/ajuste', GetRelatorioAjuste)
end;

Procedure ApuracaoInventarioEndereco(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var InventarioDAO: TInventarioDao;
    LService: TServiceInventario;
    JsonArrayRetorno: TJsonArray;
    JsonArrayErro: TJsonArray;
    HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    Try
      LService := TServiceInventario.Create;
      JsonArrayRetorno := LService.ApuracaoInventarioEndereco(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/apuracao/endereco', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString +
                      ' Registros.', 200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/apuracao/endereco', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayErro.ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure ApuracaoInventarioProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  InventarioDAO: TInventarioDao;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.ApuracaoInventarioProduto
        (Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/ApuracaoInventarioProduto', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 200, calculaTempoProcesso(HrInicioLog),
        Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/ApuracaoInventarioProduto', Trim(Req.Params.Content.Text),
          Req.Body, '', JsonArrayRetorno.ToString(), 500,
          calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    Try
      InventarioDAO := TInventarioDao.Create;
      JsonArrayRetorno := InventarioDAO.GetInventario(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/inventario',
                      Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      JsonArrayRetorno := Nil;
    Except on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario', Trim(Req.Params.Content.Text), Req.Body, '',
          JsonArrayErro.ToString(), 500, calculaTempoProcesso(HrInicioLog),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
        JsonArrayErro := Nil;
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var InventarioDAO: TInventarioDao;
begin
  Res.Send<tJsonObject>(tJsonObject.Create.AddPair('Erro', 'Chame a rota inventario/get com parâmetros.')).Status(THttpStatus.Created);
end;

Procedure GetInventarioConsultaIntegracao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var InventarioDAO: TInventarioDao;
    JsonArrayRetorno: TJsonArray;
    ErroJsonArray: TJsonArray;
    HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.GetInventarioConsultaIntegracao;
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                  '/v1/inventario/integracao/consulta', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 200, calculaTempoProcesso(HrInicioLog),
        Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create.AddPair('status', '500')
          .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(ErroJsonArray)
          .Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario/integracao/consulta', Trim(Req.Params.Content.Text),
          Req.Body, '', ErroJsonArray.ToString(), 500,
          calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure GetDSHAcompanhamentoContagem(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceInventario;
  JsonObjectRetorno: tJsonObject;
  JsonArrayErro: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    Try
      LService := TServiceInventario.Create;
      JsonObjectRetorno := LService.GetDSHAcompanhamentoContagem
        (Req.Query.Dictionary);
      Res.Send<tJsonObject>(JsonObjectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/inventario/dshcontageminventario', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonObjectRetorno.Count.ToString +
        ' Registros.', 200, calculaTempoProcesso(HrInicioLog),
        Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.Created);
        // THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario/dshcontageminventario', Trim(Req.Params.Content.Text),
          Req.Body, '', tJsonObject.Create(TJSONPair.Create('Erro', E.Message))
          .ToString(), 500, calculaTempoProcesso(HrInicioLog),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var InventarioDAO: TInventarioDao;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.GetItens(Req.Params.Items['inventarioid'].ToInteger());
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/itens/:inventarioid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/itens/:inventarioid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure GetLoteInventariado(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.GetLoteInventariado(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/loteinventariado', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/loteinventariado', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonObjectRetorno: tJsonObject;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonObjectRetorno := InventarioDAO.InsertUpdate(Req.Body<tJsonObject>);
      Res.Send<tJsonObject>(JsonObjectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario', Trim(Req.Params.Content.Text), Req.Body, '', JsonObjectRetorno.ToString(),
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Status(500).Send<tJsonObject> (tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

procedure LimparContagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.LimparContagem
        (Req.Params.Items['inventarioid'].ToInteger(),
        Req.Params.Items['enderecoid'].ToInteger(),
        Req.Params.Items['produtoid'].ToInteger());
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);;
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/inventario/limparcontagem/:inventarioid/:enderecoid/:produtoid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 200, calculaTempoProcesso(HrInicioLog),
        Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/limparcontagem/:inventarioid/:enderecoid/:produtoid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

Procedure PutInventarioIntegracao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var InventarioDAO: TInventarioDao;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.PutInventarioIntegracao
        (Req.Params.Items['inventarioid']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);;
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/integracao/:inventarioid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create.AddPair('status', '500')
                        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/integracao/:inventarioid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure PutInventarioIntegracaoLote(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.PutInventarioIntegracaoLote(Req.Params.Items['inventarioid']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);;
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                     '/v1/inventario/integracao/:inventarioid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                     200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create.AddPair('status', '500')
                        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/integracao/:inventarioid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonObjectRetorno: tJsonObject;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonObjectRetorno := tJsonObject.Create;
      Res.Send<tJsonObject>(InventarioDAO.InsertUpdate(Req.Body<tJsonObject>))
        .Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/inventario/:inventarioid', Trim(Req.Params.Content.Text),
        Req.Body, '', JsonObjectRetorno.ToString(), 200,
        calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<tJsonObject>
          (tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario/:inventarioid', Trim(Req.Params.Content.Text),
          Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString(), 500, calculaTempoProcesso(HrInicioLog),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

Procedure SaveContagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonObjectRetorno: tJsonObject;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    Try
      InventarioDAO := TInventarioDao.Create;
      JsonObjectRetorno := InventarioDAO.SaveContagem(Req.Body<TJsonArray>);
      Res.Send<tJsonObject>(JsonObjectRetorno).Status(THttpStatus.Created);;
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/savecontagem', Trim(Req.Params.Content.Text), Req.Body, '', JsonObjectRetorno.ToString(),
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/savecontagem', Trim(Req.Params.Content.Text), Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure ZerarEndereco(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonOjbectRetorno: tJsonObject;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonOjbectRetorno := InventarioDAO.ZerarContagem
        (Req.Params.Items['inventarioid'].ToInteger(),
        Req.Params.Items['enderecoid'].ToInteger(),
        Req.Params.Items['produtoid'].ToInteger());
      Res.Send<tJsonObject>(JsonOjbectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/inventario/zerarendereco/:inventarioid/:enderecoid/:produtoid', Trim(Req.Params.Content.Text),
        Req.Body, '', JsonOjbectRetorno.ToString(), 200,
        calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      JsonOjbectRetorno := Nil;
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario/zerarendereco/:inventarioid/:enderecoid/:produtoid', Trim(Req.Params.Content.Text),
          Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString(), 500, calculaTempoProcesso(HrInicioLog),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var // ObjArray      : TJSONObject;
  InventarioDAO: TInventarioDao;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      InventarioDAO.Cancelar(Req.Query.Dictionary);
      Res.Status(200).Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro excluído com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/inventario/cancelar', Trim(Req.Params.Content.Text), Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro excluído com Sucesso!'))).ToString(),
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/cancelar', Trim(Req.Params.Content.Text), Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

Procedure InventarioFechar(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      InventarioDAO.InventarioFechar(Req.Query.Dictionary);
      Res.Status(200).Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Inventário fechado com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1//inventario/fechar', Trim(Req.Params.Content.Text), Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro excluído com Sucesso!'))).ToString(),
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1//inventario/fechar', Trim(Req.Params.Content.Text), Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).ToString(),
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure CongelarEstoqueInicial(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.CongelarEstoqueInicial(StrToIntDef(Req.Params.Items['inventarioid'], 0), StrToIntDef(Req.Params.Items['inventariotipo'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/congelarestoqueinicial/:inventarioid/:pinventariotipo', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/congelarestoqueinicial/:inventarioid/:pinventariotipo', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

Procedure GerarNovoInventarioModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.GerarNovoInventarioModelo(StrToIntDef(Req.Params.Items['modeloid'], 0),
                                                                  StrToIntDef(Req.Params.Items['usuarioid'], 0),
                                                                  Req.Params.Items['terminal']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/gerarnovoinventariomodelo/:modeloid/:usuarioid/:pterminal', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/gerarnovoinventariomodelo/:modeloid/:usuarioid/:pterminal', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

Procedure Contagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.Contagem(StrToIntDef(Req.Params.Items['item'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/contagem/:item', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      200, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/contagem/:item', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
End;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: tJsonObject;
  InventarioDAO: TInventarioDao;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      InventarioDAO.Delete(StrToIntDef(Req.Params.Items['inventarioid'], 0));
      Res.Status(200).Send<tJsonObject>
        (tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro excluído com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/inventario/:inventarioid', Trim(Req.Params.Content.Text),
        Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro excluído com Sucesso!'))).ToString(), 200,
        calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario/:inventarioid', Trim(Req.Params.Content.Text),
          Req.Body, '', (tJsonObject.Create(TJSONPair.Create('Erro', E.Message))
          ).ToString(), 500, calculaTempoProcesso(HrInicioLog),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

constructor TInventarioCtrl.Create;
begin
  FInventario := TInventario.Create;
end;

destructor TInventarioCtrl.Destroy;
begin
  FreeAndNil(FInventario);
  inherited;
end;

procedure Pendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  InventarioDAO: TInventarioDao;
  JsonArrayRetorno: TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    InventarioDAO := TInventarioDao.Create;
    Try
      JsonArrayRetorno := InventarioDAO.GetPendente;
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/inventario',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
        calculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create.AddPair('Erro',
          E.Message));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/inventario', Trim(Req.Params.Content.Text), Req.Body, '',
          JsonArrayRetorno.ToString, 500, calculaTempoProcesso(HrInicioLog),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(InventarioDAO);
  End;
end;

Procedure SalvarModeloInventario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ObjEnderecoDAO : TInventarioDAO;
    HrInicioLog: int64;
    JsonArrayRetorno, JsonArrayErro : TJsonArray;
Begin
  Try
    HrInicioLog := getCurrentTime;
    try
      ObjEnderecoDAO := TInventarioDAO.Create;
      JsonArrayRetorno := ObjEnderecoDAO.SalvarModeloInventario(Req.Body<TJSONObject>);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/salvarmodeloinventario', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
                      201, calculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Ok); //ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/salvarmodeloinventario', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        403, calculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjEnderecoDAO);
  End;
End;

Procedure GetModeloInventarioLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EnderecoDAO: TInventarioDAO;
    JsonArrayRetorno, JsonArrayErro : TJsonArray;
    HrInicioLog: int64;
Begin
  Try
    HrInicioLog := getCurrentTime;
    EnderecoDAO := TInventarioDAO.Create;
    Try
      JsonArrayRetorno := EnderecoDAO.GetModeloInventarioLista(StrToIntDef(Req.Params.Items['modeloid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/modelo/lista/:modeloid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, calculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Ok); //ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/modelo/lista/:modeloid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure GetRelatorioAjuste(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EnderecoDAO: TInventarioDAO;
    JsonArrayRetorno, JsonArrayErro : TJsonArray;
    HrInicioLog: int64;
Begin
  Try
    HrInicioLog := getCurrentTime;
    EnderecoDAO := TInventarioDAO.Create;
    Try
      JsonArrayRetorno := EnderecoDAO.GetRelatorioAjuste(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/inventario/relatorio/ajuste', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, calculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Ok); //ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/inventario/relatorio/ajuste', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, calculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

End.
