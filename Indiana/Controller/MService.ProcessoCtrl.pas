unit MService.ProcessoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections,
  // ProcessoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TProcessoCtrl = Class
  Private
    // Funções de Validação
    // FProcesso : TProcessoWMS;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    // Property ObjProcesso: TProcessoWMS Read FProcesso Write FProcesso;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tProcessoCtrl }

uses MService.ProcessoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/processo', Get).Get('/processo4D', Get4D)
    .Get('/processo/:id', GetID).Get('/processo/:id/:descricao', GetDescricao)
    .Post('/processo', Insert).Put('/processo/:id', Update)
    .Delete('/processo/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProcessoDAO: TProcessoDao;
  ErroJsonArray : TjsonArray;
begin
  Try
    Try
      ProcessoDAO := TProcessoDao.Create;
      Res.Send<TJSonArray>(ProcessoDAO.GetID(0));
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(ProcessoDAO);
  End;
end;

procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProcessoDAO: TProcessoDao;
begin
  Try
    Try
      ProcessoDAO := TProcessoDao.Create;
      Res.Send<TJSonObject>(ProcessoDAO.Get4D(Req.Query.Dictionary));
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProcessoDAO);
  End;
End;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProcessoDAO: TProcessoDao;
  ErroJsonArray : TjsonArray;
begin
  try
    Try
    ProcessoDAO := TProcessoDao.Create;
    Res.Send<TJSonArray>(ProcessoDAO.GetDescricao(Req.Params.Items['descricao'])
      ).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(ProcessoDAO);
  End;

End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProcessoDAO: TProcessoDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      ProcessoDAO := TProcessoDao.Create;
      Res.Send<TJSonArray>(ProcessoDAO.GetID(StrToInt64Def(Req.Params.Items['id'],
        0))).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(ProcessoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonProcesso: TJSonObject;
  ProcessoDAO: TProcessoDao;
begin
  Try
    Try
      if Req.Body.IsEmpty then
        raise Exception.Create('Json com dados não enviado ao servidor!');
      JsonProcesso := TJSonObject.Create;
      JsonProcesso := Req.Body<TJSonObject>;
      ProcessoDAO := TProcessoDao.Create;
      ProcessoDAO.InsertUpdate(GetValueInjSon(JsonProcesso, 'id').ToInt64,
        GetValueInjSon(JsonProcesso, 'descricao'), GetValueInjSon(JsonProcesso,
        'processo'), 1);
      Res.Send<TJSonObject>(TJSonObject.Create(TJSONPair.Create('Resultado',
        'Cadastro de Processos Salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(JsonProcesso);
    FreeAndNil(ProcessoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjProcesso: TJSonObject;
  ProcessoDAO: TProcessoDao;
begin
  Try
    Try
      if Req.Body.IsEmpty then
        raise EHorseException.New.Error('Json com dados não enviado ao servidor!');
      ObjProcesso := TJSonObject.Create;
      ObjProcesso := Req.Body<TJSonObject>;
      ProcessoDAO := TProcessoDao.Create;
      ProcessoDAO.InsertUpdate(StrToInt64Def(Req.Params.Items['id'], 0),
        GetValueInjSon(ObjProcesso, 'descricao'), GetValueInjSon(ObjProcesso,
        'processo'), 1);
      Res.Send<TJSonObject>(TJSonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjProcesso);
    FreeAndNil(ProcessoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSonObject;
  ProcessoDAO: TProcessoDao;
begin
  Try
    Try
      ProcessoDAO := TProcessoDao.Create;
      If ProcessoDAO.Delete(StrToInt64Def(Req.Params.Items['id'], 0)) Then
         Res.Send<TJSonObject>(TJSonObject.Create(TJSONPair.Create('Resultado',
           'Registro Excluído com Sucesso!'))).Status(THttpStatus.NoContent)
      Else
         Res.Send<TJSonObject>(TJSonObject.Create(TJSONPair.Create('Resultado',
           'Não foi possível Excluir o Registro!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProcessoDAO);
  End;
end;

constructor TProcessoCtrl.Create;
begin
  // FProcesso := TProcessoWMS.Create;
end;

destructor TProcessoCtrl.Destroy;
begin
  // FProcesso.Free;
  inherited;
end;

End.
