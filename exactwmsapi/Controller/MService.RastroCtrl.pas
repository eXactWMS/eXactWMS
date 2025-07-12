{
  RastroCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
Unit MService.RastroCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  RastroClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TRastrosCtrl = Class
  Private
    // Funções de Validação
    FRastro: TRastro;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjRastro: TRastro Read FRastro Write FRastro;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlRastro }

uses MService.RastroDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/rastro', Get).Get('/rastro/:Rastroid', GetID)
    .Get('/rastro/:id/:descricao', GetDescricao).Post('/rastro', Insert)
    .Put('/rastro/:id', Update).Delete('/rastro/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RastroDAO: TRastroDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      RastroDAO := TRastroDao.Create;
      Res.Send<TJSonArray>(RastroDAO.GetID(0)).Status(THTTPStatus.ok);
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
    FreeAndNil(RastroDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RastroDAO: TRastroDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      RastroDAO := TRastroDao.Create;
      Res.Send<TJSonArray>(RastroDAO.GetDescricao(Req.Params.Items['descricao']))
        .Status(THttpStatus.Created);
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
    FreeAndNil(RastroDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RastroDAO: TRastroDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      RastroDAO := TRastroDao.Create;
      if StrToInt64Def(Req.Params.Items['rastroid'], 0) > 0 then
        Res.Send<TJSonArray>
          (RastroDAO.GetID(StrToIntDef(Req.Params.Items['rastroid'], 0)))
          .Status(THttpStatus.Created)
      Else
        Res.Send<TJSonArray>(RastroDAO.GetDescricao(Req.Params.Items['rastroid']))
          .Status(THttpStatus.Created);
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
    FreeAndNil(RastroDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjRastro: TJSONObject;
  RastroDAO: TRastroDao;
begin
  Try
    Try
      ObjRastro := TJSONObject.Create;
      ObjRastro := Req.Body<TJSONObject>;
      RastroDAO := TRastroDao.Create;
      RastroDAO.InsertUpdate(GetValueInjSon(ObjRastro, 'rastroid').ToInteger(),
        GetValueInjSon(ObjRastro, 'descricao'));
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
    if Assigned(ObjRastro) then
       FreeAndNil(ObjRastro);
    FreeAndNil(RastroDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjRastro: TJSONObject;
  RastroDAO: TRastroDao;
begin
  Try
    Try
      ObjRastro := TJSONObject.Create;
      ObjRastro := Req.Body<TJSONObject>;
      RastroDAO := TRastroDao.Create;
      RastroDAO.InsertUpdate(StrToIntDef(Req.Params.Items['rastroid'], 0),
        Req.Params.Items['descricao']);
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
    if Assigned(ObjRastro) then
       FreeAndNil(ObjRastro);
    FreeAndNil(RastroDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  RastroDAO: TRastroDao;
begin
  Try
    Try
      RastroDAO := TRastroDao.Create;
      RastroDAO.Delete(StrToIntDef(Req.Params.Items['rastroid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(RastroDAO);
  End;
end;

constructor TRastrosCtrl.Create;
begin
  FRastro := TRastro.Create;
end;

destructor TRastrosCtrl.Destroy;
begin
  FreeAndNil(FRastro);
  inherited;
end;

End.
