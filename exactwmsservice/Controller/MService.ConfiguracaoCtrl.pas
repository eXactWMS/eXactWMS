{
  MService.ConfiguracaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.ConfiguracaoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  // ConfiguracaoClass,
  Horse,
  Horse.Utils.ClientIP,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TConfiguracaoCtrl = Class
  Private
    // Funções de Validação
    // FConfiguracao : TConfiguracaoWMS;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    // Property ObjConfiguracao: TConfiguracaoWMS Read FConfiguracao Write FConfiguracao;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DoBackup(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ManutencaoLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVersion(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure UpdateEmpresa(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tConfiguracaoCtrl }

uses MService.ConfiguracaoDAO, uFuncoes, exactwmsservice.lib.utils;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/configuracao', Get);
  // App.Get('/Configuracao/:id', GetID);
  // App.Get('/Configuracao/:id/:descricao', GetDescricao);
  THorse.Post('/v1/configuracao', Insert);
  THorse.Put('/v1/configuracao', Update);
  THorse.Delete('/v1/configuracao/:id', Delete);
  THorse.Get('/v1/backup', DoBackup);
  THorse.Delete('/v1/manutencaolog', ManutencaoLog);
  THorse.Get('/v1/getversion', GetVersion);
  THorse.Get('/v1/updateempresa', UpdateEmpresa);
end;

Procedure DoBackup(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      Res.Send<TjsonObject>(ConfiguracaoDAO.Backup);
      ConfiguracaoDAO.Free;
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          'Não foi possível realizar o backup. ' + E.Message)))
          .Status(THTTPStatus.ExpectationFailed);
        ConfiguracaoDAO.Free;
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var ConfiguracaoDAO: TConfiguracaoDao;
    HrInicioLog: Ttime;
    JsonArrayRetorno : TJsonArray;
begin
    HrInicioLog := Time;
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      JsonArrayRetorno := ConfiguracaoDAO.GetId(0);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/configuracao', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do Begin
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/configuracao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                      500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

Procedure GetVersion(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ConfiguracaoDAO: TConfiguracaoDao;
  JsonObjectRetorno: TjsonObject;
begin
  Try
    ConfiguracaoDAO := TConfiguracaoDao.Create;
    Try
      JsonObjectRetorno := ConfiguracaoDAO.GetVersion;
      Res.Send<TjsonObject>(JsonObjectRetorno).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjConfiguracao: TjsonObject;
    ConfiguracaoDAO: TConfiguracaoDao;
    JsonArrayRetorno: TJsonArray;
    HrInicioLog: Ttime;
begin
  HrInicioLog := Time;
  Try
    Try
      ObjConfiguracao := TjsonObject.Create;
      ObjConfiguracao := Req.Body<TjsonObject>;
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      // ConfiguracaoDAO.InsertUpdate(GetValueInjSon(ObjConfiguracao, 'id').ToInteger, //Objpessoatipo.Get('descricao').JsonValue.Value
      // GetValueInjSon(ObjConfiguracao, 'pessoatipo').ToInteger );
      ObjConfiguracao := Nil;
      ObjConfiguracao.DisposeOf;
      Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/configuracao', Trim(Req.Params.Content.Text), Req.Body, '', TjsonObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!')).ToString,
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/configuracao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                      500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonConfiguracao: TjsonObject;
    ConfiguracaoDAO: TConfiguracaoDao;
    HrInicioLog: Ttime;
begin
  HrInicioLog := Time;
  Try
    Try
      JsonConfiguracao := TjsonObject.Create;
      JsonConfiguracao := Req.Body<TjsonObject>;
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      ConfiguracaoDAO.InsertUpdate(JsonConfiguracao);
      Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado', 'Configurações salva com Sucesso!'))).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/configuracao', Trim(Req.Params.Content.Text), Req.Body, '', TjsonObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!')).ToString,
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      JsonConfiguracao := Nil;
    Except on E: Exception do
      Begin
        JsonConfiguracao := Nil;
        Res.Send<TjsonObject>(TjsonObject.Create.AddPair('Erro', E.Message)).Status(THTTPStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/configuracao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                      500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

Procedure UpdateEmpresa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      Res.Send<TjsonObject>(ConfiguracaoDAO.UpdateEmpresa(TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSonObject)).Status(THTTPStatus.OK);
    Except on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
End;

Procedure ManutencaoLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      Res.Send<TjsonObject>(ConfiguracaoDAO.ManutencaoLog).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
End;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TjsonObject;
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      ConfiguracaoDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

constructor TConfiguracaoCtrl.Create;
begin
  // FConfiguracao := TConfiguracaoWMS.Create;
end;

destructor TConfiguracaoCtrl.Destroy;
begin
  // FConfiguracao.Free;
  inherited;
end;

End.
