{
  PedidoVolumeSeparacaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PedidoVolumeSeparacaoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PedidoVolumeSeparacaoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type

  TVolumeSeparacaoCtrl = Class
  Private
    // Funções de Validação
    FVolumeSeparacao: TVolumeSeparacao;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjPedidoVolumeSeparacao: TVolumeSeparacao Read FVolumeSeparacao
      Write FVolumeSeparacao;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Finalizar a Separacao
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Finalizar a Separacao
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SaveSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetResumoSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDshSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDesempenhoExpedicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure FinalizarSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPedidoVolumeSeparacao }

uses MService.PedidoVolumeSeparacaoDAO, uFuncoes, Services.PedidoVolume,
  Horse.Utils.ClientIP, exactwmsservice.lib.utils;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group
    .Prefix('v1')
    .Get('/volumeseparacao', Get)
    .Get('/volumeseparacao/:caixaembalagemid/:pedidovolumeid/:operacao', GetId)
    .Post('/volumeseparacao', Insert) // Abertura Separacao
    .Put('/volumeseparacao/:volumeseparacaoid', Update) // Finalizar Separacao
    .Put('/pedidovolume/finalizarseparacao', FinalizarSeparacao)
  // Finalizar Apanhe sem DAO
    .Delete('/volumeseparacao/:volumeseparacaoid', Delete)
    .Post('/volumeseparacao/savecheckin', SaveSeparacao)
    .Get('/resumoseparacao', GetResumoSeparacao)
    .Get('/dshseparacao', GetDshSeparacao)
    .Get('/desempenhoexpedicao', GetDesempenhoExpedicao);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    Try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      Res.Send<TJSonArray>(PedidoVolumeSeparacaoDAO.GetId(0, 0, 0)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

procedure GetDesempenhoExpedicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var JsonArrayRetorno : TJsonArray;
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  JsonArrayErro : TjsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      JsonArrayRetorno := PedidoVolumeSeparacaoDAO.GetDesempenhoExpedicao(Req.Query.Dictionary);
      Res.Status(200).Send<TJSonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/desempenhoexpedicao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/desempenhoexpedicao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                         500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
End;

Procedure GetDshSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      JsonArrayRetorno := PedidoVolumeSeparacaoDAO.GetDshSeparacao(Req.Query.Dictionary);
      Res.Status(200).Send<TJSonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/dshseparacao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/dshseparacao',
                        Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                         500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
End;

procedure GetResumoSeparacao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      JsonArrayRetorno := PedidoVolumeSeparacaoDAO.GetResumoSeparacao
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJSonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/resumoseparacao',
        Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]), 200,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/resumoseparacao',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  JsonArrayErro : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      Res.Send<TJSonArray>(PedidoVolumeSeparacaoDAO.GetId(Req.Params.Items
        ['caixaembalagemid'].ToInteger, Req.Params.Items['pedidovolumeid']
        .ToInteger, Req.Params.Items['operacao'].ToInteger))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayErro);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/resumoseparacao',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  ReturnVolumeSeparacaoId: Integer;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      PedidoVolumeSeparacaoDAO.ObjVolumeSeparacao :=
        PedidoVolumeSeparacaoDAO.ObjVolumeSeparacao.JsonToClass
        (Req.Body<TJSONObject>.ToString());
      ReturnVolumeSeparacaoId := PedidoVolumeSeparacaoDAO.Salvar
        (Req.Body<TJSONObject>.GetValue<String>('estacao'), 0);
      if ReturnVolumeSeparacaoId > 0 then
        Res.Status(200).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('volumeseparacaoid',
          ReturnVolumeSeparacaoId.ToString())));
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

procedure SaveSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonCheckIn: TJSONObject;
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      jsonCheckIn := TJSONObject.Create;
      jsonCheckIn := Req.Body<TJSONObject>;
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      If PedidoVolumeSeparacaoDAO.SaveSeparacao(jsonCheckIn) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Ok'))).Status(THttpStatus.Created)
      Else
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Erro'))).Status(THttpStatus.InternalServerError);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

Procedure FinalizarSeparacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServicePedidoVolume;
    JsonObjectRetorno: TJSONObject;

    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoVolume.Create;
      JsonObjectRetorno := LService.FinalizarSeparacao((TJSONObject.ParseJSONValue(Req.Body) as TJSONObject));
      Res.Send<TJSONObject>(JsonObjectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedidovolume/finalizarseparacao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonObjectRetorno.ToString,
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/pedidovolume/finalizarseparacao',
                        Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPedidoVolumeSeparacao: TJSONObject;
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
  ReturnVolumeSeparacaoId: Integer;
  pConsolidado: Integer;
begin
  Try
    Try
      jsonPedidoVolumeSeparacao := Req.Body<TJSONObject>;
      // (TJSONObject.ParseJSONValue(Req.Body) as TJSONObject)
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      PedidoVolumeSeparacaoDAO.ObjVolumeSeparacao :=
        PedidoVolumeSeparacaoDAO.ObjVolumeSeparacao.JsonToClass
        (jsonPedidoVolumeSeparacao.ToString());
      pConsolidado := 0;
      jsonPedidoVolumeSeparacao.TryGetValue('consolidado', pConsolidado);

      ReturnVolumeSeparacaoId := PedidoVolumeSeparacaoDAO.Salvar
        (jsonPedidoVolumeSeparacao.GetValue<String>('estacao'), pConsolidado);

      jsonPedidoVolumeSeparacao.AddPair('volumeseparacaoid',
        ReturnVolumeSeparacaoId.ToString());
      jsonPedidoVolumeSeparacao.AddPair('Resultado',
        'Registro salvo com Sucesso!');
      if ReturnVolumeSeparacaoId > 0 then
        Res.Send<TJSONObject>(jsonPedidoVolumeSeparacao)
          .Status(THttpStatus.Created)
      Else
         Res.Send<TJSONObject>(TJsonObject.Create.AddPair('Erro', 'Erro') ).Status(THttpStatus.InternalServerError);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  PedidoVolumeSeparacaoDAO: TPedidoVolumeSeparacaoDAO;
begin
  Try
    Try
      PedidoVolumeSeparacaoDAO := TPedidoVolumeSeparacaoDAO.Create;
      PedidoVolumeSeparacaoDAO.ObjVolumeSeparacao.VolumeSeparacaoid :=
        StrToIntDef(Req.Params.Items['volumeseparacaoid'], 0);
      If PedidoVolumeSeparacaoDAO.Delete Then
         Res.Status(200).Send<TJSONObject>
           (TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro excluído com Sucesso!'))).Status(THttpStatus.Created)
      Else
         Res.Status(200).Send<TJSONObject>
           (TJSONObject.Create(TJSONPair.Create('Erro',
           'Não foi possível Excluir o Registro!'))).Status(THttpStatus.InternalServerError);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PedidoVolumeSeparacaoDAO);
  End;
end;

constructor TVolumeSeparacaoCtrl.Create;
begin
  FVolumeSeparacao := TVolumeSeparacao.Create;
end;

destructor TVolumeSeparacaoCtrl.Destroy;
begin
  FreeAndNil(FVolumeSeparacao);
  inherited;
end;

End.
