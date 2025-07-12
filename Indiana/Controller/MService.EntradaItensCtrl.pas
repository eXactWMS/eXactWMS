{
  EntradasCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}

unit MService.EntradaItensCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections,
  EntradaItensClass,
  Horse,
  System.JSON;

Type
  TipoConsulta = (Resumida, Completa);

  TEntradaItensCtrl = Class
  Private
    // Funções de Validação
    FEntradaItens: TEntradaItens;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEntradaItens: TEntradaItens Read FEntradaItens
      Write FEntradaItens;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetEntradaItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetProdutoTag(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProdutoTagByProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DelCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEntrada }

uses uEntradaItensDAO, uFuncoes, Services.Recebimento;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/entradaitens', Get)
    .Get('/entradaitens/:entradaitemid', GetID)
    .Get('/entradaitens/:entradaid/:produtoid/:loteid', GetEntradaItens)
    .Get('/entradaitens/produto/:entradaid', GetEntradaProduto)
    .Get('/entradaitens/produtotag', GetProdutoTag)
    .Get('/entradaitens/produtotagbyproduto', GetProdutoTagByProduto)
    .Post('/entradaitens', Insert).Put('/entradaitens/:entradaitensid', Update)
    .Delete('/entradaitens/:entradaitensid', Delete)
    .Delete('/entradaitens/delcheckin/:pedidoid/:pedidoitemid', DelCheckIn)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaItensDAO: TEntradaItensDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      EntradaItensDAO := TEntradaItensDao.Create;
      Res.Send<TJSonArray>(EntradaItensDAO.GetID(0)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
end;

procedure GetEntradaItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaItensDAO: TEntradaItensDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      EntradaItensDAO := TEntradaItensDao.Create;
      Res.Send<TJSonArray>(EntradaItensDAO.GetEntradaItens(Req.Params.Items
        ['entradaid'].ToInteger(), Req.Params.Items['produtoid'].ToInteger(),
        Req.Params.Items['loteid'].ToInteger)).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaItensDAO: TEntradaItensDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      EntradaItensDAO := TEntradaItensDao.Create;
      Res.Send<TJSonArray>
        (EntradaItensDAO.GetID(StrToIntDef(Req.Params.Items['entradaitemid'], 0)))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
end;

Procedure GetEntradaProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EntradaItensDAO: TEntradaItensDao;
    JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      EntradaItensDAO := TEntradaItensDao.Create;
      Res.Send<TJSonArray>(EntradaItensDAO.GetEntradaProduto(Req.Params.Items['entradaid'].ToInteger())).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
End;

Procedure GetProdutoTag(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaItensDAO: TEntradaItensDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      EntradaItensDAO := TEntradaItensDao.Create;
      Res.Send<TJSonArray>(EntradaItensDAO.GetProdutoTag(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
End;

Procedure GetProdutoTagByProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.GetProdutoTagByProduto(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjEntradaItens: TJSONObject;
  EntradaItensDAO: TEntradaItensDao;
begin
  Try
    Try
      ObjEntradaItens := TJSONObject.Create;
      ObjEntradaItens := Req.Body<TJSONObject>;
      EntradaItensDAO := TEntradaItensDao.Create;
      EntradaItensDAO.InsertUpdate(GetValueInjSon(ObjEntradaItens,
        'entradaitemid').ToInteger(), GetValueInjSon(ObjEntradaItens, 'entradaid')
        .ToInteger(), GetValueInjSon(ObjEntradaItens, 'loteid').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtdxml').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtdcheckin').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtddevolvida').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtdsegregada').ToInteger());
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
    FreeAndNil(ObjEntradaItens);
    FreeAndNil(EntradaItensDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjEntradaItens: TJSONObject;
  EntradaItensDAO: TEntradaItensDao;
begin
  Try
    Try
      ObjEntradaItens := TJSONObject.Create;
      ObjEntradaItens := Req.Body<TJSONObject>;
      EntradaItensDAO := TEntradaItensDao.Create;
      EntradaItensDAO.InsertUpdate(999999,
        // 999999 Para Forcar o Put GetValueInjSon(ObjEntradaItens, 'entradaitemid').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'entradaid').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'loteid').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtdxml').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtdcheckin').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtddevolvida').ToInteger(),
        GetValueInjSon(ObjEntradaItens, 'qtdsegregada').ToInteger());
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
    FreeAndNil(ObjEntradaItens);
    FreeAndNil(EntradaItensDAO);
  End;
end;

Procedure DelCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var EntradaItensDAO: TEntradaItensDao;
begin
  Try
    Try
      EntradaItensDAO := TEntradaItensDao.Create;
      EntradaItensDAO.EntradaItens.EntradaId     := StrToIntDef(Req.Params.Items['pedidoid'], 0);
      EntradaItensDAO.EntradaItens.EntradaItemId := StrToIntDef(Req.Params.Items['pedidoitemid'], 0);
      EntradaItensDAO.DelCheckIn;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
End;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EntradaItensDAO: TEntradaItensDao;
begin
  Try
    Try
      EntradaItensDAO := TEntradaItensDao.Create;
      EntradaItensDAO.EntradaItens.EntradaItemId :=
        StrToIntDef(Req.Params.Items['entradaitensid'], 0);
      If EntradaItensDAO.Delete then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent)
      Else
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Não foi po´ssível excluir o Registro!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EntradaItensDAO);
  End;
end;

constructor TEntradaItensCtrl.Create;
begin
  FEntradaItens := TEntradaItens.Create;
end;

destructor TEntradaItensCtrl.Destroy;
begin
  FreeAndNil(FEntradaItens);
  inherited;
end;

End.
