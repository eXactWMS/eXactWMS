{
  MService.DesenhoArmazemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.DesenhoArmazemCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  DesenhoArmazemClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TDesenhoArmazemCtrl = Class
  Private
    // Fun��es de Valida��o
    FDesenhoArmazem: TDesenhoArmazem;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjDesenhoArmazem: TDesenhoArmazem Read FDesenhoArmazem
      Write FDesenhoArmazem;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDesenhoArmazem4D(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlDesenhoArmazem }

uses MService.DesenhoArmazemDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/desenhoarmazem', Get);
  THorse.Get('/v1/desenhoarmazem/:id', GetID);
  THorse.Get('/v1/desenhoarmazem/:id/:descricao', GetDescricao);
  THorse.Get('/v1/desenhoarmazem4D', GetDesenhoArmazem4D);
  THorse.Post('/v1/desenhoarmazem', Insert);
  THorse.Put('/v1/desenhoarmazem/:id', Update);
  THorse.Delete('/v1/desenhoarmazem/:id', Delete);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    Try
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      Res.Send<TJSonArray>(DesenhoArmazemDAO.GetID(0)).Status(THTTPStatus.OK);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(DesenhoArmazemDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    try
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      Res.Send<TJSonArray>(DesenhoArmazemDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(DesenhoArmazemDAO);
  End;
End;

procedure GetDesenhoArmazem4D(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    Try
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      Res.Send(DesenhoArmazemDAO.GetDesenhoArmazem4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(DesenhoArmazemDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    try
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      Res.Send<TJSonArray>(DesenhoArmazemDAO.GetID
        (StrToIntDef(Req.Params.Items['id'], 0))).Status(THttpStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(DesenhoArmazemDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JSonDesenhoArmazem: TJSONObject;
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    Try
      JSonDesenhoArmazem := TJSONObject.Create;
      JSonDesenhoArmazem := Req.Body<TJSONObject>;
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      DesenhoArmazemDAO.InsertUpdate(GetValueInjSon(JSonDesenhoArmazem, 'id')
        .ToInteger, // ObjDesenhoArmazem.Get('descricao').JsonValue.Value
        GetValueInjSon(JSonDesenhoArmazem, 'descricao'),
        GetValueInjSon(JSonDesenhoArmazem, 'status').ToInteger);
      JSonDesenhoArmazem := Nil;
      JSonDesenhoArmazem.DisposeOf;
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
    FreeAndNil(DesenhoArmazemDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjDesenhoArmazem: TJSONObject;
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    Try
      ObjDesenhoArmazem := Req.Body<TJSONObject>;
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      DesenhoArmazemDAO.InsertUpdate(StrToIntDef(Req.Params.Items['id'], 0),
        GetValueInjSon(ObjDesenhoArmazem, 'descricao'),
        GetValueInjSon(ObjDesenhoArmazem, 'status').ToInteger);
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
    FreeAndNil(DesenhoArmazemDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  DesenhoArmazemDAO: TDesenhoArmazemDao;
begin
  Try
    Try
      DesenhoArmazemDAO := TDesenhoArmazemDao.Create;
      DesenhoArmazemDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
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
    FreeAndNil(DesenhoArmazemDAO);
  End;
end;

constructor TDesenhoArmazemCtrl.Create;
begin
  FDesenhoArmazem := TDesenhoArmazem.Create;
end;

destructor TDesenhoArmazemCtrl.Destroy;
begin
  FDesenhoArmazem.Free;
  inherited;
end;

End.
