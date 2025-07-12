{
  LaboratoriosCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.LaboratoriosCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  LaboratoriosClass,
  Horse, Horse.utils.ClientIP,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TLaboratoriosCtrl = Class
  Private
    // Funções de Validação
    FLaboratorio: TLaboratorio;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjLaboratorio: TLaboratorio Read FLaboratorio Write FLaboratorio;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ImportDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlLaboratorio }

uses uLaboratorioDAO, uFuncoes, exactwmsservice.lib.utils;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
        .Get('/laboratorio', Get)
        .Get('/laboratorio/:id', GetID)
        .Get('/laboratorio4D', Get4D)
        .Get('/laboratorio/:id/:descricao', GetDescricao)
        .Get('/laboratorio/estrutura', Estrutura)
        .Post('/laboratorio', Insert).Put('/laboratorio/:id', Update)
        .Delete('/laboratorio/:id', Delete)
        .Get('/laborotorio/montarpaginacao', MontarPaginacao)
        .Put('/laboratorio/importdados', ImportDados)
        .Post('/fabricante/import', Import)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LaboratorioDAO: TLaboratorioDAO;
  JsonArrayRetorno, JsonArrayErro : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LaboratorioDAO := TLaboratorioDAO.Create;
      JsonArrayRetorno := LaboratorioDAO.Estrutura;
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/estrutura',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString,
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
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LaboratorioDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LaboratorioDAO: TLaboratorioDAO;
  JsonArrayRetorno : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LaboratorioDAO := TLaboratorioDAO.Create;
      JsonArrayRetorno := LaboratorioDAO.GetID(0);
      Res.Send<TJSonArray>(JsonArrayRetorno);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/get',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString,
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/get',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LaboratorioDAO);
  End;
end;

procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LaboratorioDAO: TLaboratorioDAO;
  JsonObjectRetorno : TJsonObject;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      LaboratorioDAO := TLaboratorioDAO.Create;
      JsonObjectRetorno := LaboratorioDAO.GetId4D(Req.Query.Dictionary);
      Res.Send<TJsonObject>(JsonObjectRetorno).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Send<TJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LaboratorioDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LaboratorioDAO: TLaboratorioDAO;
  JsonArrayRetorno : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      LaboratorioDAO   := TLaboratorioDAO.Create;
      JsonArrayRetorno := TJsonArray.Create;
      Res.Send<TJSonArray>(LaboratorioDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/getdescricao',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString,
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/getdescricao',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LaboratorioDAO);
  End; 
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LaboratorioDAO: TLaboratorioDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    HrInicioLog := Time;
    try
      LaboratorioDAO := TLaboratorioDAO.Create;
      JsonArrayRetorno := LaboratorioDAO.GetID(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/getdescricao',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString,
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/getdescricao',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LaboratorioDAO);
  End; 
end;

Procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LaboratorioDAO: TLaboratorioDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    HrInicioLog := Time;
    try
      LaboratorioDAO := TLaboratorioDAO.Create;
      Res.Send<TJSonArray>(LaboratorioDAO.Import(Req.Body<TJSonArray>)).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/laboratorio/getdescricao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: Registro importado com Sucesso!',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/laboratorio/getdescricao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LaboratorioDAO);
  End; 
End;

Procedure ImportDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LaboratorioDAO: TLaboratorioDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    HrInicioLog := Time;
    try
      LaboratorioDAO := TLaboratorioDAO.Create;
      Res.Send<TJSonArray>(LaboratorioDAO.ImportDados(Req.Body<TJSonArray>))
        .Status(THttpStatus.Created);
          Tutil.SalvarLog(Req.MethodType,
        StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
        ClientIP(Req), THorse.Port, '/v1/laboratorio/getdescricao',
        Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString,
        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/laboratorio/getdescricao',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    end
  Finally
    FreeAndNil(LaboratorioDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjJson: TJSONObject;
  LaboratorioDAO: TLaboratorioDAO;
begin
  Try
    Try
      ObjJson := TJSONObject.Create;
      ObjJson := Req.Body<TJSONObject>;
      LaboratorioDAO := TLaboratorioDAO.Create;
      LaboratorioDAO.Laboratorio := LaboratorioDAO.Laboratorio.JsonToClass
        (ObjJson.ToString());
      if LaboratorioDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Não foi possível Salvar o Registro!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjJson);
    FreeAndNil(LaboratorioDAO);
  End; 
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjLaboratorio: TJSONObject;
  LaboratorioDAO: TLaboratorioDAO;
begin
  Try
    Try
      ObjLaboratorio := TJSONObject.Create;
      ObjLaboratorio := Req.Body<TJSONObject>;
      LaboratorioDAO := TLaboratorioDAO.Create;
      LaboratorioDAO.InsertUpdate(StrToIntDef(Req.Params.Items['id'], 0),
        // Objlaboratorio.Get('descricao').JsonValue.Value
        GetValueInjSon(ObjLaboratorio, 'nome'), GetValueInjSon(ObjLaboratorio,
        'fone'), GetValueInjSon(ObjLaboratorio, 'email'),
        GetValueInjSon(ObjLaboratorio, 'homepage'), GetValueInjSon(ObjLaboratorio,
        'status').ToInteger);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjLaboratorio);
    FreeAndNil(LaboratorioDAO);
  End; 
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  LaboratorioDAO: TLaboratorioDAO;
begin
  Try
    Try
      LaboratorioDAO := TLaboratorioDAO.Create;
      LaboratorioDAO.Laboratorio.IdLaboratorio :=
        StrToIntDef(Req.Params.Items['id'], 0);
      LaboratorioDAO.Delete;
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
    FreeAndNil(LaboratorioDAO);
  End; 
end;

procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LaboratorioDAO: TLaboratorioDAO;
begin
  Try
    Try
      LaboratorioDAO := TLaboratorioDAO.Create;
      Res.Send<TJSONObject>(LaboratorioDAO.MontarPaginacao)
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LaboratorioDAO);
  End; 
end;

constructor TLaboratoriosCtrl.Create;
begin
  FLaboratorio := TLaboratorio.Create;
end;

destructor TLaboratoriosCtrl.Destroy;
begin
  FreeAndNil(FLaboratorio);
  inherited;
end;

End.
