{
  LotesCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
Unit MService.LotesCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  LotesClass,
  Horse, Horse.utils.ClientIP,
  System.Types,
  System.JSON,
  System.JSON.Types; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TLotesCtrl = Class
  Private
    // Fun��es de Valida��o
    FLote: TLote;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjLote: TLote Read FLote Write FLote;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetLoteResumo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutCorrecaoLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlLote }

uses MService.LoteDAO, uFuncoes, exactwmsservice.lib.utils;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/lote', Get)
    .Get('/lote/:id', GetID)
    .Get('/lote/:produtoid/:loteid/:descricao', GetDescricao)
    .Get('/lote/resumo/:produtoid/:descricao/:agrupado', GetLoteResumo)
    .Put('/lote/correcaolote', PutCorrecaoLote)
    .Get('/lote/estrutura', Estrutura)
    .Post('/lote', Insert)
    .Put('/lote/:id', Update)
    .Post('/lote/salvar', SalvarLote).Delete('/lote/:id', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LoteDAO: TLoteDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    HrInicioLog := Time;
    Try
      LoteDAO := TLoteDAO.Create;
      JsonArrayRetorno := LoteDAO.Estrutura;
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/lote/estrutura',
        Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/lote/estrutura',
          Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString(),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LoteDAO);
  End;

End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LoteDAO: TLoteDAO;
  JsonArrayRetorno : TJsonArray;
  JsonArrayErro : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LoteDAO := TLoteDAO.Create;
      JsonArrayRetorno := LoteDAO.GetID(0);
      Res.Send<TJSonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + jsonArrayRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
          Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayErro.ToString(),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LoteDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LoteDAO: TLoteDAO;
  JsonArrayRetorno, JsonArrayErro : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      LoteDAO := TLoteDAO.Create;
      JsonArrayRetorno := LoteDAO.GetDescricao(Req.Params.Items['produtoid'].ToInteger(),
                                               Req.Params.Items['loteid'].ToInteger(),
                                               Req.Params.Items['descricao']);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + jsonArrayRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
          Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayErro.ToString(),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LoteDAO);
  End;
End;

Procedure GetLoteResumo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LoteDAO: TLoteDAO;
    JsonArrayRetorno: TJSonArray;
    JsonArrayErro: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      LoteDAO := TLoteDAO.Create;
      if StrToIntDef(Req.Params.Items['agrupado'], 0) = 0 then
         JsonArrayRetorno := LoteDAO.GetLoteResumo(Req.Params.Items['produtoid'].ToInteger(), Req.Params.Items['descricao'])
      Else
        JsonArrayRetorno := LoteDAO.GetLoteResumoAgrupado(Req.Params.Items['produtoid'].ToInteger(), Req.Params.Items['descricao']);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    end;
  Finally
    FreeAndNil(LoteDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LoteDAO: TLoteDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno, JsonArrayErro : TJsonArray;
begin
  Try
    HrInicioLog := Time;
    try
      LoteDAO := TLoteDAO.Create;
      JsonArrayRetorno := LoteDAO.GetID(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + jsonArrayRetorno.Count.ToString + ' Registros.',
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
          Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayErro.ToString(),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LoteDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjLote: TJSONObject;
  LoteDAO: TLoteDAO;
begin
  Try
    Try
      ObjLote := TJSONObject.Create;
      ObjLote := Req.Body<TJSONObject>;
      LoteDAO := TLoteDAO.Create;
      LoteDAO.InsertUpdate(GetValueInjSon(ObjLote, 'loteid').ToInteger(),
        GetValueInjSon(ObjLote, 'produtoid').ToInteger(),
        GetValueInjSon(ObjLote, 'descrlote'),
        StrToDate(GetValueInjSon(ObjLote, 'fabricacao')),
        StrToDate(GetValueInjSon(ObjLote, 'vencimento')));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjLote);
    FreeAndNil(LoteDAO);
  End;
end;

procedure SalvarLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjLote: TJSONObject;
  LoteDAO: TLoteDAO;
begin
  Try
    Try
      ObjLote := TJSONObject.Create;
      ObjLote := Req.Body<TJSONObject>;
      LoteDAO := TLoteDAO.Create;
      Res.Send<TJSONObject>(LoteDAO.SalvarLote(0, GetValueInjSon(ObjLote,
        'produtoid').ToInteger(), GetValueInjSon(ObjLote, 'descrlote'),
        StrToDate(GetValueInjSon(ObjLote, 'fabricacao')),
        StrToDate(GetValueInjSon(ObjLote, 'vencimento'))))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjLote);
    FreeAndNil(LoteDAO);
  End;
End;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonLote: TJSONObject;
  LoteDAO: TLoteDAO;
begin
  Try
    Try
      JsonLote := Req.Body<TJSONObject>;
      LoteDAO := TLoteDAO.Create;
      LoteDAO.InsertUpdate(JsonLote.GetValue<Integer>('loteid'),
        JsonLote.GetValue<Integer>('produtoid'),
        JsonLote.GetValue<String>('descrlote'),
        StrToDate(JsonLote.GetValue<String>('fabricacao')),
        StrToDate(JsonLote.GetValue<String>('vencimento')));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(JsonLote);
    FreeAndNil(LoteDAO);
  End;
end;

Procedure PutCorrecaoLote(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LoteDAO: TLoteDAO;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    Try
      LoteDAO := TLoteDAO.Create;
      JsonArrayRetorno := LoteDAO.PutCorrecaoLote
        ((TJSONObject.ParseJSONValue(Req.Body) as TJSONObject));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LoteDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LoteDAO: TLoteDAO;
begin
  Try
    Try
      LoteDAO := TLoteDAO.Create;
      LoteDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LoteDAO);
  End;
end;

constructor TLotesCtrl.Create;
begin
  FLote := TLote.Create;
end;

destructor TLotesCtrl.Destroy;
begin
  FreeAndNil(FLote);
  inherited;
end;

End.
