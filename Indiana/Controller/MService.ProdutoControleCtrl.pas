{
   ProdutoControleCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
Unit MService.ProdutoControleCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils,  Generics.Collections,
     ProdutoControleClass,
     Horse,
     System.JSON;//, uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);
  TProdutoControlesCtrl = Class
  Private
    //Funções de Validação
    FProdutoControle : TProdutoControle;
  Public
    //Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjProdutoControle : TProdutoControle Read FProdutoControle Write FProdutoControle;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlProdutoControle }

uses MService.ProdutoControleDAO, uFuncoes;

//uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse
    .Group
    .Prefix('v1')
    .Get('/produtocontrole', Get)
    .Get('/produtocontrole/:ProdutoControleid', GetID)
    .Get('/produtocontrole/:id/:descricao', GetDescricao)
    .Post('/produtocontrole', Insert)
    .Put('/produtocontrole/:id', Update)
    .Delete('/produtocontrole/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ProdutoControleDAO : TProdutoControleDao;
begin
  ProdutoControleDAO := TProdutoControleDAO.Create;
  Res.Send<TJSonArray>(ProdutoControleDAO.GetId(0));
  ProdutoControleDAO.Destroy;

//  FDAO := TDAOGeneric<TProduto>.New;
//  Res.Send<TJSonArray>(FDAO.Find);
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ProdutoControleDAO : TProdutoControleDao;
begin
  try
    ProdutoControleDAO := TProdutoControleDAO.Create;
    Res.Send<TJSonArray>(ProdutoControleDAO.GetDescricao(Req.Params.Items['descricao'])).Status(THttpStatus.Created);
    ProdutoControleDAO.Destroy;
  Except On E: Exception do Begin
    res.Status(404);
    End;
  end;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ProdutoControleDAO : TProdutoControleDao;
begin
  try
    ProdutoControleDAO := TProdutoControleDAO.Create;
    if StrToInt64Def(Req.Params.Items['ProdutoControleid'] ,0) > 0 then
       Res.Send<TJSonArray>(ProdutoControleDAO.GetId(StrToIntDef(Req.Params.Items['ProdutoControleid'] ,0))).Status(THttpStatus.Created)
    Else
       Res.Send<TJSonArray>(ProdutoControleDAO.GetDescricao(Req.Params.Items['ProdutoControleid'])).Status(THttpStatus.Created);
    ProdutoControleDAO.Destroy;
  Except On E: Exception do Begin
    res.Status(404);
    End;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjProdutoControle : TJSONObject;
    ProdutoControleDAO : TProdutoControleDao;
begin
  Try
    ObjProdutoControle := tJsonObject.Create;
    ObjProdutoControle := req.Body<tJsonObject>;
    ProdutoControleDAO := TProdutoControleDao.Create;
    ProdutoControleDAO.InsertUpdate(GetValueInjSon(ObjProdutoControle, 'ProdutoControleid').ToInteger(),
                                GetValueInjSon(ObjProdutoControle, 'descricao') );
    ObjProdutoControle := Nil;
    ObjProdutoControle.DisposeOf;
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
  Except on E: Exception do Begin
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
  ProdutoControleDAO := Nil;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjProdutoControle : TJSONObject;
    ProdutoControleDAO : TProdutoControleDao;
begin
  Try
    ObjProdutoControle := tJsonObject.Create;
    ObjProdutoControle := req.Body<tJsonObject>;
    ProdutoControleDAO := TProdutoControleDao.Create;
    ProdutoControleDAO.InsertUpdate(StrToIntDef(Req.Params.Items['ProdutoControleid'], 0),
                                     Req.Params.Items['descricao'] );
    ObjProdutoControle := Nil;
    ObjProdutoControle.DisposeOf;
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.Created);
  Except on E: Exception do Begin
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
  ProdutoControleDAO := Nil;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjArray : TJSONObject;
    ProdutoControleDAO : TProdutoControleDao;
begin
  Try
    ProdutoControleDAO := TProdutoControleDao.Create;
    ProdutoControleDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
  Except on E: Exception do Begin
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
end;

constructor TProdutoControlesCtrl.Create;
begin
  FProdutoControle := TProdutoControle.Create;
end;

destructor TProdutoControlesCtrl.Destroy;
begin
  FProdutoControle.Free;
  inherited;
end;

End.

