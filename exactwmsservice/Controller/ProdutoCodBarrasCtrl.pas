{
  ProdutoCodBarrasCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit ProdutoCodBarrasCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  ProdutoCodBarrasClass,
  Horse, Horse.Utils.ClientIP,
  System.JSON, exactwmsservice.lib.utils; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TProdutoCodBarrasCtrl = Class
  Private
    // Funções de Validação
    FProdutoCodBarras: TProdutoCodBarras;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjProdutoCodBarras: TProdutoCodBarras Read FProdutoCodBarras
      Write FProdutoCodBarras;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCodBarras(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlProdutoCodBarras }

uses ProdutoCodBarrasDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/produtocodbarras', Get)
    .Get('/produtocodbarras/:codbarrasid/:produtoid/:codbarras', GetCodBarras)
    .Post('/produtocodbarras', Insert)
    .Put('/produtocodbarras/:codbarrasid', Update)
    .Delete('/produtocodbarras/:codbarrasid', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
    JsonArrayRetorno,
    RetornoErro : TJsonArray;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      JsonArrayRetorno    := ProdutoCodBarrasDAO.GetProdutoCodBarras(0, 0, 'Null');
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/produtocodbarras', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/produtocodbarras', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
end;

procedure GetCodBarras(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
  RetornoErro : TJsonArray;
begin
  Try
    try
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      Res.Send<TJSonArray>(ProdutoCodBarrasDAO.GetProdutoCodBarras(Req.Params.Items['codbarrasid'].ToInteger(),
                                                                   Req.Params.Items['produtoid'].ToInteger(),
                                                                   Req.Params.Items['codbarras']))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjJson: TJSONObject;
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
begin
  Try
    Try
      ObjJson := Req.Body<TJSONObject>;
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      ProdutoCodBarrasDAO.ProdutoCodBarras :=
        ProdutoCodBarrasDAO.ProdutoCodBarras.JsonToClass(ObjJson.ToString());
      if ProdutoCodBarrasDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        raise Exception.Create('Não foi possível Salvar o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    if Assigned(ObjJson) then
       FreeAndNil(ObjJSon);
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonProdutoCodBarras: TJSONObject;
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
  ObjProdutoCodBarras: TProdutoCodBarras;
begin
  Try
    Try
      JsonProdutoCodBarras := Req.Body<TJSONObject>;
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      ProdutoCodBarrasDAO.ProdutoCodBarras :=
        ProdutoCodBarrasDAO.ProdutoCodBarras.JsonToClass
        (JsonProdutoCodBarras.ToString());
      // ObjProdutoCodBarras := ProdutoCodBarrasDAO.ProdutoCodBarras.JsonToClass(JsonProdutoCodBarras.ToString());
      if ProdutoCodBarrasDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        raise Exception.Create('Error Não possível Salvar o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    if Assigned(JsonProdutoCodBarras) then
       FreeAndNil(JsonProdutoCodBarras);
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
begin
  Try
    Try
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      ProdutoCodBarrasDAO.ProdutoCodBarras.CodBarrasId :=
        StrToIntDef(Req.Params.Items['codbarrasid'], 0);
      If ProdutoCodBarrasDAO.Delete then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Alterado com Sucesso!'))).Status(THttpStatus.Ok)
      Else
         raise Exception.Create('Não foi possível Excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
end;

constructor TProdutoCodBarrasCtrl.Create;
begin
  FProdutoCodBarras := TProdutoCodBarras.Create;
end;

destructor TProdutoCodBarrasCtrl.Destroy;
begin
  FreeAndNil(FProdutoCodBarras);
  inherited;
end;

End.
