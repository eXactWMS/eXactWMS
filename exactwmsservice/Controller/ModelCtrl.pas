{
   LotesCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit ModelCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils,  Generics.Collections,
     [NomeClass]Class,
     Horse,
     System.JSON;//, uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);
  T[NomeClass]Ctrl = Class
  Private
    //Funções de Validação
    F[NomeClass] : T[NomeClass];
  Public
    //Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property Obj[NomeClass] : T[NomeClass] Read F[NomeClass] Write F[NomeClass];
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrl[NomeClass] }

uses u[NomeClass]DAO, uFuncoes;

//uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse
    .Group
    .Prefix('v1')
    .Get('/[NomeClass]', Get)
    .Get('/[NomeClass]/:id', GetID)
    .Get('/[NomeClass]/:id/:descricao', GetDescricao)
    .Post('/[NomeClass]', Insert)
    .Put('/[NomeClass]/:id', Update)
    .Delete('/[NomeClass]/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var [NomeClass]DAO : T[NomeClass]Dao;
begin
  [NomeClass]DAO := T[NomeClass]DAO.Create;
  Res.Send<TJSonArray>([NomeClass]DAO.GetId(0));
  [NomeClass]DAO.Destroy;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var [NomeClass]DAO : T[NomeClass]Dao;
begin
  try
    [NomeClass]DAO := T[NomeClass]DAO.Create;
    Res.Send<TJSonArray>([NomeClass]DAO.GetDescricao(Req.Params.Items['descricao'])).Status(THttpStatus.Created);
    [NomeClass]DAO.Destroy;
  Except On E: Exception do Begin
    res.Status(404);
    End;
  end;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var [NomeClass]DAO : T[NomeClass]Dao;
begin
  try
    [NomeClass]DAO := T[NomeClass]DAO.Create;
    Res.Send<TJSonArray>([NomeClass]DAO.GetId(StrToIntDef(Req.Params.Items['id'] ,0))).Status(THttpStatus.Created);
    [NomeClass]DAO.Destroy;
  Except On E: Exception do Begin
    res.Status(404);
    End;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjJson        : TJSONObject;
    [NomeClass]DAO : T[NomeClass]Dao;
begin
  Try
    ObjJson := tJsonObject.Create;
    ObjJson := req.Body<tJsonObject>;
    [NomeClass]DAO := T[NomeClass]Dao.Create;

    [NomeClass]DAO.[NomeClass]    := [NomeClass]DAO.[NomeClass].JsonToClass(ObjJson.ToString());
    if [NomeClass]DAO.Salvar then
       Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    ObjJson := Nil;
    ObjJson.DisposeOf;
    [NomeClass]DAO := Nil;
    [NomeClass]DAO.DisposeOf;
  Except on E: Exception do Begin
    ObjJson := Nil;
    ObjJson.DisposeOf;
    [NomeClass]DAO := Nil;
    [NomeClass]DAO.DisposeOf;
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'E.Message'))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var Json[NomeClass] : TJSONObject;
    [NomeClass]DAO : T[NomeClass]Dao;
    Obj[NomeClass] : T[NomeClass];
begin
  Try
    Json[NomeClass] := tJsonObject.Create;
    Json[NomeClass] := req.Body<tJsonObject>;
    [NomeClass]DAO := T[NomeClass]Dao.Create;
    Obj[NomeClass] := Self.FObj[NomeClass].JsonToClass(Json[NomeClass].ToString());
    [NomeClass]DAO.Salvar;
{     InsertUpdate(StrToIntDef(Req.Params.Items['id'], 0),
                                 GetValueInjSon(Obj[NomeClass], 'nome'),
                                 GetValueInjSon(Obj[NomeClass], 'fone'),
                                 GetValueInjSon(Obj[NomeClass], 'email'),
                                 GetValueInjSon(Obj[NomeClass], 'homepage'),
                                 GetValueInjSon(Obj[NomeClass], 'status').ToInteger);
}    jSon[NomeClass] := Nil;
    jSon[NomeClass].DisposeOf;
    Obj[NomeClass] := Nil;
    Obj[NomeClass].DisposeOf;
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.Created);
  Except on E: Exception do Begin
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'E.Message'))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
  [NomeClass]DAO := Nil;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjArray : TJSONObject;
    [NomeClass]DAO : T[NomeClass]Dao;
begin
  Try
    [NomeClass]DAO := T[NomeClass]Dao.Create;
    [NomeClass]DAO.[NomeClass].[NomeClass]Id := StrToIntDef(Req.Params.Items['id'], 0);
    [NomeClass]DAO.Delete;
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
  Except on E: Exception do Begin
    Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'E.Message'))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
end;

constructor T[NomeClass]Ctrl.Create;
begin
  F[NomeClass] := T[NomeClass].Create;
end;

destructor T[NomeClass]Ctrl.Destroy;
begin
  F[NomeClass].Free;
  inherited;
end;

End.

