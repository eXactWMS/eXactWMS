{
  MService.UsuarioCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 22/04/2021
  Projeto: uEvolut
}
unit MService.UsuarioCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  UsuarioClass,
  Horse,
  Horse.Utils.ClientIP,
  System.JSON, Services.Usuarios, Exactwmsservice.lib.Utils; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TUsuarioCtrl = Class
  Private
    // Funções de Validação
    FUsuario: TUsuario;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjUsuario: TUsuario Read FUsuario Write FUsuario;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure LogIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetUsuario4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure FindLoginNome(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure acessoFuncionalidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AcessoTopico(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ControleAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure listaFuncionalidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure LogOnOff(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure UsuarioConectado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelUsuarioLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ImportCSV(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlUsuario }

uses MService.UsuarioDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/usuario', Get);
  THorse.Get('/v1/usuario/:Usuarioid', GetID);
  THorse.Get('/v1/login/:Usuarioid', LogIn);
  THorse.Get('/v1/usuario/:login/:nome', FindLoginNome);
  THorse.Post('/v1/usuario', Insert);
  THorse.Put('/v1/usuario/:Usuarioid', Update);
  THorse.Put('/v1/usuario', AtualizarSenha);
  THorse.Put('/v1/usuario/salvaracesso/:usuid', SalvarAcesso);
  THorse.Delete('/v1/usuario/:Usuarioid', Delete);
  THorse.Get('v1/usuario/funcionalidade/:usuarioid/:funcionalidade', acessoFuncionalidade);
  THorse.Get('v1/usuario/topico/:usuarioid/:topico', AcessoTopico);
  THorse.Get('v1/usuario/controleacesso/:usuarioid', ControleAcesso);
  THorse.Get('v1/usuario/listafuncionalidade/:usuarioid', listaFuncionalidade);
  THorse.Put('v1/usuario/logonoff', LogOnOff);
  THorse.Get('v1/usuario/conectado', UsuarioConectado);
  THorse.Get('v1/usuario/lista', GetRelUsuarioLista);
  THorse.Get('v1/usuario4D', GetUsuario4D);
  THorse.Post('v1/usuario/importcsv', ImportCSV)
end;

Procedure acessoFuncionalidade(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  ErroJsonArray: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<TJsonArray>(UsuarioDAO.acessoFuncionalidade
        (StrToIntDef(Req.Params.Items['usuarioid'], 0),
        Req.Params.Items['funcionalidade'])).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

Procedure AcessoTopico(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  ErroJsonArray: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<TJsonArray>(UsuarioDAO.AcessoTopico
        (StrToIntDef(Req.Params.Items['usuarioid'], 0),
        Req.Params.Items['topico'])).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

Procedure ControleAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var UsuarioDAO: TUsuarioDao;
    ErroJsonArray: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<tJsonObject>(UsuarioDAO.ControleAcesso(StrToIntDef(Req.Params.Items['usuarioid'], 0))).Status(THTTPStatus.Ok);
    Except On E: Exception do
      Begin
        Res.Status(500).Send<TJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UsuarioDAO: TUsuarioDao;
  ErroJsonArray: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<TJsonArray>(UsuarioDAO.GetID('0'));
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
end;

Procedure FindLoginNome(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UsuarioDAO: TUsuarioDao;
  ErroJsonArray: TJsonArray;
begin
  Try
    try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<TJsonArray>(UsuarioDAO.FindLoginNome(Req.Params.Items['login'],
        Req.Params.Items['nome'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Retorno, ErroJsonArray: TJsonArray;
  xParam: Integer;
  LService: TServiceUsuario;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    LService := TServiceUsuario.Create;
    try
      Retorno := LService.GetID(Req.Params.Items['Usuarioid']);
      Res.Send<TJsonArray>(Retorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(Retorno.ToString, #39, '', [rfReplaceAll]),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do Begin
      ErroJsonArray := TJsonArray.Create;
      ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]),
                      500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure LogIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Retorno, ErroJsonArray: TJsonArray;
  xParam: Integer;
  HrInicioLog: TTime;
  LService: TServiceUsuario;
begin
  Try
    HrInicioLog := Time;
    LService := TServiceUsuario.Create;
    try
      Retorno := LService.GetID(Req.Params.Items['Usuarioid']);
      Res.Send<TJsonArray>(Retorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
                      Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '',
                      StringReplace(Retorno.ToString, #39, '', [rfReplaceAll]), 201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure ImportCSV(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  JsonArrayRetorno: TJsonArray;
  ErroJsonArray: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      JsonArrayRetorno := UsuarioDAO.ImportCSV(Req.Body<TJsonArray>);
      Res.Status(201).Send<TJsonArray>(JsonArrayRetorno);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

Procedure AtualizarSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  pTesteJson: tJsonObject;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      pTesteJson := Req.Body<tJsonObject>;
      UsuarioDAO.AtualizarSenha(Req.Body<tJsonObject>);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjUsuario: tJsonObject;
  UsuarioDAO: TUsuarioDAO;
  JsonArrayRetorno : TJsonArray;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    UsuarioDAO := TUsuarioDao.Create;
    Try
      ObjUsuario := tJsonObject.Create;
      ObjUsuario := tJsonObject.ParseJSONValue(Req.Body) as tJsonObject;
      JsonArrayRetorno := UsuarioDAO.InsertUpdate(GetValueInjSon(ObjUsuario, 'Usuarioid').ToInteger, GetValueInjSon(ObjUsuario, 'login'),
                          GetValueInjSon(ObjUsuario, 'nome'), GetValueInjSon(ObjUsuario, 'Senha'), GetValueInjSon(ObjUsuario,'SenhaPadrao').ToInteger(),
                          GetValueInjSon(ObjUsuario, 'DiasSenhaValida').ToInteger(), GetValueInjSon(ObjUsuario, 'Email'),
                          ObjUsuario.GetValue<tJsonObject>('perfil').GetValue<Integer>('perfilId'), GetValueInjSon(ObjUsuario, 'status').ToInteger);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/usuario', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Resultado', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    if Assigned(ObjUsuario) then
       FreeAndNil(ObjUsuario);
    FreeAndNil(UsuarioDAO);
  End;
end;

procedure GetUsuario4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UsuarioDAO: TUsuarioDao;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Status(200).Send<tJsonObject>(UsuarioDAO.GetUsuario4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except On E: Exception do Begin
        Res.Status(500).Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
end;

Procedure GetRelUsuarioLista(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  JsonArrayRetorno: TJsonArray;
  ErroJsonArray: TJsonArray;
  vUsuarioId: Integer;
  vFuncionalidadeId: Integer;
  vPerfilId: Integer;
  vStatus: Integer;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    UsuarioDAO := TUsuarioDao.Create;
    Try
      UsuarioDAO := TUsuarioDao.Create;
      If Req.Query.Dictionary.Count <= 0 then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          'Defina os parâmetros para pesquisar os endereços.')))
          .Status(THttpStatus.Created);
        if Req.Query.Dictionary.ContainsKey('usuarioid') then
          vUsuarioId := Req.Query.Dictionary.Items['usuarioid'].ToInteger
        Else
          vUsuarioId := 0;
        if Req.Query.Dictionary.ContainsKey('funcionalidadeid') then
          vFuncionalidadeId := Req.Query.Dictionary.Items['funcionalidadeid']
            .ToInteger
        Else
          vFuncionalidadeId := 0;
        if Req.Query.Dictionary.ContainsKey('perfilid') then
          vPerfilId := Req.Query.Dictionary.Items['perfilid'].ToInteger
        Else
          vPerfilId := 0;
        if Req.Query.Dictionary.ContainsKey('status') then
          vStatus := Req.Query.Dictionary.Items['status'].ToInteger
        Else
          vStatus := 0;
        JsonArrayRetorno := UsuarioDAO.GetRelUsuarioLista(vUsuarioId, vFuncionalidadeId, vPerfilId, vStatus);
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/lista', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      Except On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/lista', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
end;

Procedure listaFuncionalidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  JsonArrayRetorno : TJsonArray;
  ErroJsonArray: TJsonArray;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      JsonArrayRetorno := UsuarioDAO.listaFuncionalidade(StrToIntDef(Req.Params.Items['usuarioid'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/listafuncionalidade/:usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/listafuncionalidade/:usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

Procedure LogOnOff(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  ErroJsonArray: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<TJsonArray>
        (UsuarioDAO.LogOnOff(tJsonObject.ParseJSONValue(Req.Body)
        as tJsonObject)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

Procedure SalvarAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  Retorno: TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Retorno := UsuarioDAO.SalvarAcesso(StrToIntDef(Req.Params.Items['usuid'], 0), Req.Body<tJsonObject>);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Controle de Acesso Rgistrado com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/usuario/salvaracesso/:usuid', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(Retorno.ToString, #39, '', [rfReplaceAll]),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Retorno := TJsonArray.Create;
        Retorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/salvaracesso/:usuid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonUsuario: tJsonObject;
    UsuarioDAO: TUsuarioDao;
    JsonArrayRetorno : TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      JsonUsuario := tJsonObject.ParseJSONValue(Req.Body) as tJsonObject;
      // req.Body<tJsonObject>;
      UsuarioDAO := TUsuarioDao.Create;
      JsonArrayRetorno := UsuarioDAO.InsertUpdate(StrToIntDef(Req.Params.Items['Usuarioid'], 0), GetValueInjSon(JsonUsuario, 'login'),
                                                  GetValueInjSon(JsonUsuario, 'nome'), GetValueInjSon(JsonUsuario, 'Senha'), GetValueInjSon(JsonUsuario,
                                                  'SenhaPadrao').ToInteger(), GetValueInjSon(JsonUsuario, 'DiasSenhaValida').ToInteger(),
                                                  GetValueInjSon(JsonUsuario, 'Email'), JsonUsuario.GetValue<tJsonObject>('perfil').GetValue<Integer>('perfilId'),
                                                  JsonUsuario.GetValue<Integer>('status'));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Resultado', E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    if Assigned(JsonUsuario) then
       FreeAndNil(JsonUsuario);
    FreeAndNil(UsuarioDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: tJsonObject;
  UsuarioDAO: TUsuarioDao;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      If UsuarioDAO.Delete(StrToIntDef(Req.Params.Items['Usuarioid'], 0)) then Begin
         Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Excluído com Sucesso!'))).Status(THttpStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', 'Registro Excluído com Sucesso!',
                         201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End
      Else Begin
         Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', 'Não foi possível excluir!'))).Status(THttpStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', 'Não foi possível excluir!',
                         500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/usuario/:Usuarioid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
end;

Procedure UsuarioConectado(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  UsuarioDAO: TUsuarioDao;
  RetornoErro: TJsonArray;
begin
  Try
    Try
      UsuarioDAO := TUsuarioDao.Create;
      Res.Send<TJsonArray>(UsuarioDAO.UsuarioConectado())
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(UsuarioDAO);
  End;
End;

constructor TUsuarioCtrl.Create;
begin
  FUsuario := TUsuario.Create;
end;

destructor TUsuarioCtrl.Destroy;
begin
  FreeAndNil(FUsuario);
  inherited;
end;

End.
