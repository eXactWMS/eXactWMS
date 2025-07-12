{
  EntradaIntegracaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.IntegracaoSaidaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  // ClipBrd,
  // SaidaIntegracaoClass,
  Horse,
  Horse.Utils.ClientIP, Exactwmsservice.lib.Utils,
  System.JSON, Services.SaidaIntegracao; // , uTHistorico;

{ Type
  TipoConsulta = (Resumida, Completa);
  SaidaIntegracaoCtrl = Class
  Private
  //Funções de Validação
  FSaidaIntegracao : SaidaIntegracao;
  Public
  //Rotinas Pública (CRUD)
  constructor Create;
  destructor Destroy; override;
  Property ObjSaidaIntegracao : SaidaIntegracao Read FSaidaIntegracao Write FSaidaIntegracao;
  End;
}
procedure Registry;
procedure Consulta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ConsultaV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ConsultaV3(Req: THorseRequest; Res: THorseResponse; Next: TProc);

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InsertV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);

procedure Retorno(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure RetornoV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure RetornoV3(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlSaidaIntegracao }

uses MService.SaidaIntegracaoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
        .Get('/saidaintegracao/consulta', Consulta)
        .Put('/saidaintegracao', Insert)
        .Put('/saidaintegracao/retorno/:pedido', Retorno)
        .Prefix('v2')
        .Get('/saidaintegracao/consulta', ConsultaV2)
        .Put('/saidaintegracao', InsertV2)
        .Put('/saidaintegracao/retorno/:pedido', RetornoV2)
        .Prefix('v3')
        .Get('/saidaintegracao/consulta', ConsultaV3)
        .Put('/saidaintegracao/retorno/:pedido', RetornoV3)
end;

procedure Consulta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArray: TJsonArray;
begin
  Try
    Try
      JsonArray := TJsonArray.Create;
      JsonArray.AddElement(TjsonObject.Create.AddPair('Erro',
        'Rota desativada. use a versão 2: v2/saidaintegracao/consulta'));
      Res.Status(404).Send<TJsonArray>(JsonArray);
      JsonArray := Nil;
    Except
      On E: Exception do
      Begin
        JsonArray.AddElement(TjsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArray);
      End;
    End;
  Finally
    FreeAndNil(JsonArray);
  End;
end;

procedure ConsultaV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceSaidaIntegracao;
  JsonArrayRetorno: TJsonArray;
  vStatus: String;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    Try
      LService := TServiceSaidaIntegracao.Create;
      JsonArrayRetorno := LService.ConsultaV2('V2');
      if (JsonArrayRetorno.Items[0].TryGetValue('status', vStatus)) and
        (vStatus.ToInteger > 299) then
      Begin
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      begin
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      end;
    Except on E: Exception do Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create.AddPair('status', '500')
                        .AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
                        .AddPair('mensagem', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/entradaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure ConsultaV3(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceSaidaIntegracao;
  JsonArrayRetorno: TJsonArray;
  vStatus: String;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    Try
      LService := TServiceSaidaIntegracao.Create;
      JsonArrayRetorno := LService.ConsultaV2('V3');
      if (JsonArrayRetorno.Items[0].TryGetValue('status', vStatus)) and (vStatus.ToInteger > 299) then Begin
         Res.Status(500).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v3/saidaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                         500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else begin
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v3/saidaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      end;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create.AddPair('status', '500')
                        .AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
                        .AddPair('mensagem', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v3/saidaintegracao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ArrayJsonSaidaIntegracao: TJsonArray;
  JsonArrayRetorno: TJsonArray;
  SaidaIntegracaoDAO: TSaidaIntegracaoDao;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    Try
      ArrayJsonSaidaIntegracao := TjsonObject.ParseJSONValue(Req.Body) as TJsonArray;
      if ArrayJsonSaidaIntegracao = Nil then
         raise Exception.Create('Arquivo JSON inválido!');
      { else if TJSONObject.ParseJSONValue(Req.Body) Is TJsonArray then
        ShowMessage('Recebido Array')
        Else ShowMEssage('Recebido TJSONObject');
      } SaidaIntegracaoDAO := TSaidaIntegracaoDao.Create;
      JsonArrayRetorno := SaidaIntegracaoDAO.Insert(ArrayJsonSaidaIntegracao, 'V1');
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saidaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      ArrayJsonSaidaIntegracao := Nil;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saidaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(SaidaIntegracaoDAO);
  End;
end;

procedure InsertV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ArrayJsonSaidaIntegracao: TJsonArray;
  SaidaIntegracaoDAO: TSaidaIntegracaoDao;
  LService: TServiceSaidaIntegracao;
  JsonArrayRetorno: TJsonArray;
  vStatus: String;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    Try
      LService := TServiceSaidaIntegracao.Create;
      JsonArrayRetorno := LService.Insert(TjsonObject.ParseJSONValue(Req.Body) as TJsonArray, 'V2');
      if (JsonArrayRetorno.Items[0].TryGetValue('status', vStatus)) and
        (vStatus.ToInteger > 299) then
      Begin
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create.AddPair('status', '500')
                        .AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
                        .AddPair('mensagem', E.Message));
        Res.Send<TJsonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure Retorno(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonArray: TJsonArray;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    Try
      JsonArray := TJsonArray.Create;
      JsonArray.AddElement(TjsonObject.Create.AddPair('Erro', 'Rota desativada. use a versão 2: v2/saidaintegracao/retorno/:pedido'));
      Res.Status(500).Send<TJsonArray>(JsonArray);
    Except on E: Exception do
      Begin
        JsonArray.AddElement(TjsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArray);
      End;
    End;
  Finally
    //FreeAndNil(JsonArray);
  End;
end;

procedure RetornoV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var // jsonSaidaIntegracao : TJSONObject;
  SaidaIntegracaoDAO: TSaidaIntegracaoDao;
  JsonArrayRetorno: TJsonArray;
  vStatus: String;
  LService: TServiceSaidaIntegracao;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    Try
      LService := TServiceSaidaIntegracao.Create;
      JsonArrayRetorno := LService.Retorno(Req.Params.Items['pedido'], 'V2');
      if (JsonArrayRetorno.Items[0].TryGetValue('status', vStatus)) and (vStatus.ToInteger > 299) then
      Begin
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao/retorno/:pedido', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else Begin
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao/retorno/:pedido', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                        200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create.AddPair('status', '500')
                        .AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
                        .AddPair('mensagem', E.Message));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v2/saidaintegracao/retorno/:pedido', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure RetornoV3(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  SaidaIntegracaoDAO: TSaidaIntegracaoDao;
  JsonArrayRetorno: TJsonArray;
  vStatus: String;
  LService: TServiceSaidaIntegracao;
  HrInicioLog: Int64;
begin
  HrInicioLog := getCurrentTime;
  Try
    LService := TServiceSaidaIntegracao.Create;
    Try
      JsonArrayRetorno := LService.Retorno(Req.Params.Items['pedido'], 'V3');
      if (JsonArrayRetorno.Items[0].TryGetValue('status', vStatus)) and (vStatus.ToInteger > 299) then
      Begin
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v3/saidaintegracao/retorno/:pedido', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else Begin
        Res.Status(200).Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v3/saidaintegracao/retorno/:pedido', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TjsonObject.Create.AddPair('status', '500')
                        .AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
                        .AddPair('mensagem', E.Message));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v3/saidaintegracao/retorno/:pedido', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

End.
