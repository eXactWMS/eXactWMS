unit Controller.Produto;

interface

uses
  Horse,
  System.JSON,
  IdHashMessageDigest,
  Model.Entity.Produto;

procedure Registry(App : THorse);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

Var  ObjProduto : Model.Entity.Produto.TProduto;


procedure Registry(App : THorse);
begin
  App.Get('/produto', Get);
  App.Get('/produto/:id', GetID);
  App.Get('/Produto/:Descricao', GetDescricao);
  App.Post('/produto', Insert);
  App.Put('/produto/:id', Update);
  App.Delete('/produto/:id', Delete);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
//var  FDAO : iDAOGeneric<TProduto>;
begin
//  ObjProduto.;

//  FDAO := TDAOGeneric<TProduto>.New;
//  Res.Send<TJSonArray>(FDAO.Find);
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
//var   FDAO : iDAOGeneric<TProduto>;
Begin
//  FDAO := TDAOGeneric<TProduto>.New;
//  Res.Send<TJSONObject>(FDAO.Find(Req.Params.Items['descricao']))
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var   //FDAO : iDAOGeneric<TProduto>;
  id : String;
begin
id := Req.Params.Items['id'];
//  FDAO := TDAOGeneric<TProduto>.New;
//  Res.Send<TJSONObject>(FDAO.Find(Req.Params.Items['id']))
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

end;


end.
