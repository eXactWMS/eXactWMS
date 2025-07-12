{
  RotaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
Unit MService.RotaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  RotaClass,
  Horse,
  System.Types,
  System.JSON,
  System.JSON.Types;

Type

  TRotaCtrl = Class
  Private
    FRota: TRota;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjRota: TRota Read FRota Write FRota;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetParticipante(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetParticipanteRota(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure RotaParticipante(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure RotaOnOff(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DelParticipante(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProducaoDiaria(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlRota }

uses MService.RotaDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/rota', Get)
    .Get('/rotas4D', Get4D)
    .Get('/rota/:rotaid', GetID)
    .Get('/rota/participante/:rotaid/:pessoaid', GetParticipante)
    .Get('/rota/participante/:rotaid', GetParticipanteRota)
    .Post('/rota', Insert)
    .Post('/rota/rotaparticipante', RotaParticipante)
    .Put('/rota/:rotaid', Update)
    .Put('/rota/rotaonoff/:rotaid', RotaOnOff)
    .Delete('/rota/:rotaid', Delete)
    .Delete('/rota/participante/:pessoaid', DelParticipante)
    .Get('rota/producao', GetProducaoDiaria)
end;

procedure RotaOnOff(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RotaDAO: TRotaDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      RotaDAO := TRotaDao.Create;
      Res.Send<TJSonArray>
        (RotaDAO.RotaOnOff(StrToIntDef(Req.Params.Items['rotaid'], 0)))
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
    FreeAndNil(RotaDAO);
  End;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RotaDAO: TRotaDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      Res.Send<TJSonArray>(RotaDAO.GetID('0')).Status(THTTPStatus.Ok);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
end;

procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var RotaDAO: TRotaDao;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      Res.Send(RotaDAO.Get4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
end;

procedure GetParticipante(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RotaDAO: TRotaDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      RotaDAO := TRotaDao.Create;
      Res.Send<TJSonArray>(RotaDAO.GetParticipante(Req.Params.Items['rotaid']
        .ToInteger(), Req.Params.Items['pessoaid'].ToInteger()))
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
    FreeAndNil(RotaDAO);
  End;
End;

procedure GetParticipanteRota(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  RotaDAO: TRotaDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
  try
    RotaDAO := TRotaDao.Create;
    Res.Send<TJSonArray>(RotaDAO.GetParticipante(Req.Params.Items['rotaid']
      .ToInteger(), 0)).Status(THttpStatus.Created);
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
    FreeAndNil(RotaDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RotaDAO: TRotaDao;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      RotaDAO := TRotaDao.Create;
      Res.Send<TJSonArray>(RotaDAO.GetID(Req.Params.Items['rotaid']))
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
    FreeAndNil(RotaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  RotaDAO: TRotaDao;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      // RotaDAO.ObjRota := RotaDAO.ObjRota.JsonToClass(req.Body<tJsonObject>.ToJson);
      RotaDAO.InsertUpdate(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
end;

Procedure GetProducaoDiaria(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var RotaDAO           : TRotaDao;
    JsonObjectRetorno : TJsonObject;
    AParams           : TDictionary<string, string>;
Begin
  Try
    Try
      aParams := TDictionary<string, string>.Create;
      aParams := Req.Query.Dictionary;
      RotaDAO := TRotaDao.Create;
      if AParams.ContainsKey('datainicial') then Begin
         Try
           StrToDate(AParams.Items['datainicial'])
         Except Begin
           Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial inválida!'))).Status(THttpStatus.ExpectationFailed);
           Exit
           End;
         End;
      End
      Else Begin
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Parêmetros da requisição inválido(s)!'))).Status(THttpStatus.ExpectationFailed);
         Exit
      End;
      if AParams.ContainsKey('datafinal') then Begin
         Try
           StrToDate(AParams.Items['datafinal'])
         Except
           Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final inválida!'))).Status(THttpStatus.ExpectationFailed);
           Exit
         End;
      End
      Else Begin
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Parêmetros da requisição inválido(s)!'))).Status(THttpStatus.ExpectationFailed);
         Exit
      End;
      JsonObjectRetorno := RotaDAO.GetProducaoDiaria(StrToDate(AParams.Items['datainicial']), StrToDate(AParams.Items['datafinal']));
      Res.Send<TJsonObject>(JsonObjectRetorno).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
End;

Procedure RotaParticipante(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  RotaDAO: TRotaDao;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      // RotaDAO.ObjRota := RotaDAO.ObjRota.JsonToClass(req.Body<tJsonObject>.ToJson);
      RotaDAO.RotaParticipante(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Participante da rota alterado com Sucesso!')))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
End;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  RotaDAO: TRotaDao;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      // RotaDAO.ObjRota := RotaDAO.ObjRota.JsonToClass(req.Body<tJsonObject>.ToJson);
      RotaDAO.InsertUpdate(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var // ObjArray : TJSONObject;
  RotaDAO: TRotaDao;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      If RotaDAO.Delete(StrToIntDef(Req.Params.Items['rotaid'], 0)) Then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Excluído com Sucesso!'))).Status(THttpStatus.Created)
      Else
         raise Exception.Create('Não foi possível Excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
end;

Procedure DelParticipante(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var // ObjArray : TJSONObject;
  RotaDAO: TRotaDao;
begin
  Try
    Try
      RotaDAO := TRotaDao.Create;
      If RotaDAO.DeleteParticipante(StrToIntDef(Req.Params.Items['pessoaid'], 0)) Then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Participante Excluído com Sucesso!'))).Status(THttpStatus.Created)
      Else
        raise Exception.Create('Não foi possível excluir o Participante da Rota!');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(RotaDAO);
  End;
end;

constructor TRotaCtrl.Create;
begin
  FRota := TRota.Create;
end;

destructor TRotaCtrl.Destroy;
begin
  FreeAndNil(FRota);
  inherited;
end;

End.
