{
  ProdutoTipoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
Unit MService.ProdutoTipoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  ProdutoTipoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TProdutoTiposCtrl = Class
  Private
    // Funções de Validação
    FProdutoTipo: TProdutoTipo;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjProdutoTipo: TProdutoTipo Read FProdutoTipo Write FProdutoTipo;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlProdutoTipo }

uses MService.ProdutoTipoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/produtotipo', Get)
    .Get('/produtotipo/:produtotipoid', GetID)
    .Get('/produtotipo/:id/:descricao', GetDescricao)
    .Post('/produtotipo', Insert)
    .Put('/produtotipo/:id', Update)
    .Delete('/produtotipo/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoTipoDAO: TProdutoTipoDao;
  JsoNArrayRetorno : TJsonArray;
begin
  Try
    Try
      ProdutoTipoDAO := TProdutoTipoDao.Create;
      Res.Send<TJSonArray>(ProdutoTipoDAO.GetID(0)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(ProdutoTipoDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoTipoDAO: TProdutoTipoDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      ProdutoTipoDAO := TProdutoTipoDao.Create;
      Res.Send<TJSonArray>(ProdutoTipoDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(ProdutoTipoDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoTipoDAO: TProdutoTipoDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      ProdutoTipoDAO := TProdutoTipoDao.Create;
      if StrToInt64Def(Req.Params.Items['produtotipoid'], 0) > 0 then
        Res.Send<TJSonArray>
          (ProdutoTipoDAO.GetID(StrToIntDef(Req.Params.Items['produtotipoid'], 0))
          ).Status(THttpStatus.Created)
      Else
        Res.Send<TJSonArray>(ProdutoTipoDAO.GetDescricao(Req.Params.Items
          ['produtotipoid'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(ProdutoTipoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjProdutoTipo: TJSONObject;
  ProdutoTipoDAO: TProdutoTipoDao;
begin
  Try
    ProdutoTipoDAO := TProdutoTipoDAO.Create;
    Try
      ObjProdutoTipo := Req.Body<TJSONObject>;
      ProdutoTipoDAO.InsertUpdate(GetValueInjSon(ObjProdutoTipo, 'id').ToInteger(), GetValueInjSon(ObjProdutoTipo, 'descricao'),
        GetValueInjSon(ObjProdutoTipo, 'Sigla'),
        ObjProdutoTipo.GetValue<Integer>('status'));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoTipoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjProdutoTipo: TJSONObject;
  ProdutoTipoDAO: TProdutoTipoDao;
begin
  Try
    Try
      ObjProdutoTipo := Req.Body<TJSONObject>;
      ProdutoTipoDAO := TProdutoTipoDao.Create;
      ProdutoTipoDAO.InsertUpdate(StrToIntDef(Req.Params.Items['id'], 0),
        ObjProdutoTipo.GetValue<String>('descricao'),
        ObjProdutoTipo.GetValue<String>('sigla'),
        ObjProdutoTipo.GetValue<Integer>('status'));
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
    FreeAndNil(ProdutoTipoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  ProdutoTipoDAO: TProdutoTipoDao;
begin
  Try
    Try
      ProdutoTipoDAO := TProdutoTipoDao.Create;
      If ProdutoTipoDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0)) Then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Alterado com Sucesso!'))).Status(THttpStatus.Ok)
      Else
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
           'Não foi possível Exclui o Registro!'))).Status(THttpStatus.InternalServerError);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoTipoDAO);
  End;
end;

constructor TProdutoTiposCtrl.Create;
begin
  FProdutoTipo := TProdutoTipo.Create;
end;

destructor TProdutoTiposCtrl.Destroy;
begin
  FreeAndNil(FProdutoTipo);
  inherited;
end;

End.
