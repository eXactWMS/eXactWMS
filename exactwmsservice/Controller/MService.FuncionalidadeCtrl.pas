{
  FuncionalidadeCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.FuncionalidadeCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  FuncionalidadeClass,
  Horse,
  System.JSON; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TFuncionalidadeCtrl = Class
  Private
    // Funções de Validação
    FFuncionalidade: TFuncionalidade;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjFuncionalidade: TFuncionalidade Read FFuncionalidade
      Write FFuncionalidade;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetFuncionalidade4D(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure TopicoFuncionalidades(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure SalvarTopicoFuncionalidade(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlFuncionalidade }

uses MService.FuncionalidadeDAO, uFuncoes;

procedure Registry;
begin
  THorse.Group
    .Prefix('v1')
    .Get('/funcionalidade', Get)
    .Get('/funcionalidade/:funcionalidadeid', GetId)
    .Get('/funcionalidade4D', GetFuncionalidade4D)
    .Get('/funcionalidade/estrutura', Estrutura)
    .Post('/funcionalidade', Insert)
    .Put('/funcionalidade/:fucionalidadeid', Update)
    .Delete('/funcionalidade/:funcionalidadeid', Delete)
    .Get('/topicofuncionalidades/:topicoid', TopicoFuncionalidades)
    .Post('/topicofuncionalidade', SalvarTopicoFuncionalidade)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FuncionalidadeDAO: TFuncionalidadeDAO;
  JsonArrayRetorno : TJsonArray;
Begin
  Try
    Try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      Res.Send<TJSonArray>(FuncionalidadeDAO.Estrutura)
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FuncionalidadeDAO: TFuncionalidadeDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      Res.Send<TJSonArray>(FuncionalidadeDAO.GetId('0'));
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

procedure GetFuncionalidade4D(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  FuncionalidadeDAO: TFuncionalidadeDAO;
Begin
  Try
    try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      Res.Status(200).Send<TJSONObject>(FuncionalidadeDAO.GetFuncionalidade4D
        (Req.Query.Dictionary));
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    end;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
End;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FuncionalidadeDAO: TFuncionalidadeDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      Res.Send<TJSonArray>(FuncionalidadeDAO.GetId(Req.Params.Items
        ['funcionalidadeid'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  FuncionalidadeDAO: TFuncionalidadeDAO;
begin
  Try
    Try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      if FuncionalidadeDAO.Salvar(Req.Body<TJSONObject>) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Não foi possível Salvar o Registro!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  FuncionalidadeDAO: TFuncionalidadeDAO;
begin
  Try
    Try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      if FuncionalidadeDAO.Salvar(Req.Body<TJSONObject>) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  FuncionalidadeDAO: TFuncionalidadeDAO;
begin
  Try
    Try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      FuncionalidadeDAO.ObjFuncionalidade.Funcionalidadeid :=
        StrToIntDef(Req.Params.Items['funcionalidadeid'], 0);
      If FuncionalidadeDAO.Delete Then
         Res.Status(200).Send<TJSONObject>
           (TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro excluído com Sucesso!'))).Status(THttpStatus.Created)
      Else
         Res.Status(200).Send<TJSONObject>
           (TJSONObject.Create(TJSONPair.Create('Resultado',
           'Não foi possível Excluir o Registro!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

procedure TopicoFuncionalidades(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  FuncionalidadeDAO: TFuncionalidadeDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      Res.Send<TJSonArray>(FuncionalidadeDAO.TopicoFuncionalidades
        (Req.Params.Items['topicoid'].ToInteger)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

procedure SalvarTopicoFuncionalidade(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  jsonTopicoFuncionalidade: TJSONObject;
  FuncionalidadeDAO: TFuncionalidadeDAO;
  pTopicoId, pFuncionalidadeId, pStatus: Integer;
begin
  Try
    Try
      jsonTopicoFuncionalidade := Req.Body<TJSONObject>;
      pTopicoId := jsonTopicoFuncionalidade.GetValue<Integer>('topicoid');
      pFuncionalidadeId := jsonTopicoFuncionalidade.GetValue<Integer>
        ('funcionalidadeid');
      pStatus := jsonTopicoFuncionalidade.GetValue<Integer>('status');
      FuncionalidadeDAO := TFuncionalidadeDAO.Create;
      if FuncionalidadeDAO.SalvarTopicoFuncionalidade(pTopicoId,
        pFuncionalidadeId, pStatus) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(FuncionalidadeDAO);
  End;
end;

constructor TFuncionalidadeCtrl.Create;
begin
  FFuncionalidade := TFuncionalidade.Create;
end;

destructor TFuncionalidadeCtrl.Destroy;
begin
  FreeAndNil(FFuncionalidade);
  inherited;
end;

End.
