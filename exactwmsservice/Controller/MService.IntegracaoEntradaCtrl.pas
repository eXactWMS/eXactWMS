{
  EntradaIntegracaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.IntegracaoEntradaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  // ClipBrd,
  // EntradaIntegracaoClass,
  Horse,
  Horse.Utils.ClientIP,
  System.JSON; // , uTHistorico;

{ Type
  TipoConsulta = (Resumida, Completa);
  EntradaIntegracaoCtrl = Class
  Private
  //Funções de Validação
  FEntradaIntegracao : EntradaIntegracao;
  Public
  //Rotinas Pública (CRUD)
  constructor Create;
  destructor Destroy; override;
  Property ObjEntradaIntegracao : EntradaIntegracao Read FEntradaIntegracao Write FEntradaIntegracao;
  End;
}
procedure Registry;
procedure Consulta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Retorno(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEntradaIntegracao }

uses MService.EntradaIntegracaoDAO, uFuncoes, exactwmsservice.lib.utils;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').
     Get('/entradaintegracao/consulta', Consulta)
    .Put('/entradaintegracao', Insert)
    .Put('/entradaintegracao/retorno/:pedidoid', Retorno)
end;

procedure Consulta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaIntegracaoDAO: TEntradaIntegracaoDao;
  ErroJsonArray: TJsonArray;
  JsonRetornoArray: TJsonArray;
  vStatus: String;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      EntradaIntegracaoDAO := TEntradaIntegracaoDao.Create;
      JsonRetornoArray := EntradaIntegracaoDAO.Consulta;
      if (JsonRetornoArray.Items[0].TryGetValue('Erro', vStatus)) then Begin // and (vStatus.ToInteger() > 299) then
         Res.Status(500).Send<TJsonArray>(JsonRetornoArray);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                         '/v1/entradaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonRetornoArray.ToString,
                         500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
         Res.Status(200).Send<TJsonArray>(JsonRetornoArray);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                         '/v1/entradaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', JsonRetornoArray.ToString,
                         200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create.AddPair('status', '500')
                      .AddPair('entradaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
                      .AddPair('mensagem', E.Message));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/entradaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', e.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(EntradaIntegracaoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ArrayJsonEntradaIntegracao, ErroJsonArray: TJsonArray;
  EntradaIntegracaoDAO: TEntradaIntegracaoDao;
  JsonArrayRetorno: TJsonArray;
  JsonErro: tJsonObject;
  vErro: String;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      JsonArrayRetorno := TJsonArray.Create;
      ArrayJsonEntradaIntegracao := tJsonObject.ParseJSONValue(Req.Body) as TJsonArray;
      if ArrayJsonEntradaIntegracao = Nil then Begin
         JsonErro := tJsonObject.Create;
         JsonErro.AddPair('status', '500');
         JsonErro.AddPair('entradaid', TJsonNumber.Create(0));
         JsonErro.AddPair('documentoerp', '');
         JsonErro.AddPair('mensagem', 'JsonArray recebido é inválido! ');
         JsonArrayRetorno.AddElement(JsonErro);
         Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
         JsonArrayRetorno := Nil;
         exit;
      End;
      EntradaIntegracaoDAO := TEntradaIntegracaoDao.Create;
      JsonArrayRetorno := EntradaIntegracaoDAO.Insert(ArrayJsonEntradaIntegracao);
      if (JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) then Begin
         Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                         '/v1/entradaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                         500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/entradaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        JsonErro := tJsonObject.Create;
        JsonErro.AddPair('status', '500');
        JsonErro.AddPair('entradaid', TJsonNumber.Create(0));
        JsonErro.AddPair('documentoerp', '');
        JsonErro.AddPair('mensagem', E.Message);
        JsonArrayRetorno.AddElement(JsonErro);
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/entradaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(EntradaIntegracaoDAO);
  End;
end;

procedure Retorno(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ErroJsonArray: TJsonArray;
  JsonArrayRetorno: TJsonArray;
  EntradaIntegracaoDAO: TEntradaIntegracaoDao;
  vStatus: String;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      EntradaIntegracaoDAO := TEntradaIntegracaoDao.Create;
      JsonArrayRetorno := EntradaIntegracaoDAO.Retorno(Req.Params.Items['pedidoid']);
      if (JsonArrayRetorno.Items[0].TryGetValue('Erro', vStatus)) then Begin
          Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/entradaintegracao/retorno/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else Begin
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/entradaintegracao/retorno/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create.AddPair('status', '500')
          .AddPair('entradaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
          .AddPair('mensagem', E.Message));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), 'Integracao', ClientIP(Req), THorse.Port,
                        '/v1/entradaintegracao/retorno/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', e.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(EntradaIntegracaoDAO);
  End;
end;

End.
