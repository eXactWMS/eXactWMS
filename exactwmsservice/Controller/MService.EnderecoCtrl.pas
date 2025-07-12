{
  MService.EnderecoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EnderecoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  EnderecoClass, Exactwmsservice.lib.utils,
  Horse,
  Horse.utils.ClientIP,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TEnderecoCtrl = Class
  Private
    // Fun��es de Valida��o
    FEndereco: TEndereco;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEndereco: TEndereco Read FEndereco Write FEndereco;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetEndereco4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEnderecoToReposicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetEstrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetZona(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure EnderecoBloquear(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure EnderecoBloqueioDeUso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPickingMask(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure manutencao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ExportFile(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPadraoMovimentacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReUsoPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEnderecoOcupacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutDesvincularPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEnderecoModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEndereco }

uses MService.EnderecoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse
    .Group.Prefix('v1')
    .Get('/endereco', Get)
    .Get('/endereco/:enderecoid', GetID)
    .Get('/endereco/lista', GetLista)
    .Get('/enderecotoreposicao', GetEnderecoToReposicao)
    .Get('/endereco/pickingmask', GetPickingMask)
    .Get('/endereco/estrutura/:estruturaid', GetEstrutura)
    .Get('/endereco/zona/:zonaid', GetZona)
    .Get('/endereco/estrutura', Estrutura)
    .Post('/endereco', Insert)
    .Put('/endereco/:enderecoid', Update)
    .Put('/endereco/bloquear', EnderecoBloquear)
    .Put('/endereco/enderecobloqueiodeuso', EnderecoBloqueioDeUso)
    .Delete('/endereco/:enderecoid', Delete)
    .Get('/endereco/montarpaginacao', MontarPaginacao)
    .Get('/endereco4D', GetEndereco4D)
    .Put('endereco/manutencao', manutencao)
    .Get('endereco/exportfile', ExportFile)
    .Get('/endereco/padraomovimentacao', GetPadraoMovimentacao)
    .Get('/endereco/getreusopicking/:zonaid/:dias', GetReUsoPicking)
    .Put('/endereco/desvincular', PutDesvincularPicking)
    .Get('/endereco/ocupacao', GetEnderecoOcupacao)
    .Get('/endereco/enderecomodelo', GetEnderecoModelo)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
Begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.Estrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(EnderecoDAO);
  End;
End;

Procedure GetEnderecoToReposicao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
  AQueryParam: TDictionary<String, String>;
  pZonaId: Integer;
  pEnderecoIni, pEnderecoFin: String;
  pRuaInicial, pRuaFinal: String;
  pPredioInicial, pPredioFinal: String;
  pNivelInicial, pNivelFinal: String;
  pAptoInicial, pAptoFinal: String;
  pRuaParImpar, pPredioParImpar, pNivelParImpar, pAptoParImpar: Integer;
  JsonArrayErro: TJSonArray;
Begin
  Try
    Try
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pesquisar os endere�os.')))
          .Status(THttpStatus.Created);
      pZonaId := 0;
      pEnderecoIni := '';
      pEnderecoFin := '';
      pRuaInicial := '';
      pRuaFinal := '';
      pRuaParImpar := 2;
      pPredioInicial := '';
      pPredioFinal := '';
      pPredioParImpar := 2;
      pNivelInicial := '';
      pNivelFinal := '';
      pNivelParImpar := 2;
      pAptoInicial := '';
      pAptoFinal := '';
      pAptoParImpar := 2;
      if AQueryParam.ContainsKey('zonaid') then
        pZonaId := AQueryParam.Items['zonaid'].ToInteger;
      if AQueryParam.ContainsKey('enderecoini') then
        pEnderecoIni := AQueryParam.Items['enderecoini'];
      if AQueryParam.ContainsKey('enderecofin') then
        pEnderecoFin := AQueryParam.Items['enderecofin'];
      if AQueryParam.ContainsKey('ruainicial') then
        pRuaInicial := AQueryParam.Items['ruainicial'];
      if AQueryParam.ContainsKey('ruafinal') then
        pRuaFinal := AQueryParam.Items['ruafinal'];
      If AQueryParam.ContainsKey('ruaparimpar') then
        pRuaParImpar := AQueryParam.Items['ruaparimpar'].ToInteger;
      if AQueryParam.ContainsKey('predioinicial') then
        pPredioInicial := AQueryParam.Items['predioinicial'];
      if AQueryParam.ContainsKey('prediofinal') then
        pPredioFinal := AQueryParam.Items['prediofinal'];
      If AQueryParam.ContainsKey('predioparimpar') then
        pRuaParImpar := AQueryParam.Items['predioparimpar'].ToInteger;
      if AQueryParam.ContainsKey('nivelinicial') then
        pNivelInicial := AQueryParam.Items['nivelinicial'];
      if AQueryParam.ContainsKey('nivelfinal') then
        pNivelFinal := AQueryParam.Items['nivelfinal'];
      If AQueryParam.ContainsKey('nivelparimpar') then
        pNivelParImpar := AQueryParam.Items['nivelparimpar'].ToInteger;
      if AQueryParam.ContainsKey('aptoinicial') then
        pAptoInicial := AQueryParam.Items['aptoinicial'];
      if AQueryParam.ContainsKey('aptofinal') then
        pAptoFinal := AQueryParam.Items['aptofinal'];
      If AQueryParam.ContainsKey('aptoparimpar') then
        pAptoParImpar := AQueryParam.Items['aptoparimpar'].ToInteger;
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetEnderecoToReposicao(pZonaId,
        pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal, pRuaParImpar,
        pPredioInicial, pPredioFinal, pPredioParImpar, pNivelInicial, pNivelFinal,
        pNivelParImpar, pAptoInicial, pAptoFinal, pAptoParImpar));
    Except on E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure EnderecoBloquear(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
  jsonEndereco: TJSonArray;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      EnderecoDAO.EnderecoBloquear(Req.Body<TJSonArray>);
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
    FreeAndNil(enderecoDAO);
  End;
end;

Procedure GetEnderecoModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var EnderecoDAO      : TEnderecoDAO;
    JsonArrayRetorno : TJsonArray;
    JsonArrayErro    : TJsonArray;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      JsonArrayRetorno := EnderecoDAO.GetEnderecoModelo(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsoNArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
end;

Procedure EnderecoBloqueioDeUso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var EnderecoDAO  : TEnderecoDAO;
    JsonEndereco : TJsonArray;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      EnderecoDAO.EnderecoBloqueioDeUso(Req.Body<TJSonArray>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Bloqueio/Desbloqueio de Endereço realizado com Sucesso!'))).Status(THttpStatus.Created);
    Except On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
end;

Procedure GetEnderecoOcupacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var EnderecoDAO: TEnderecoDAO;
    JsonArrayRetorno : TJsonArray;
    JsonArrayErro    : TjsonArray;
    HrInicioLog: TTime;
Begin
  Try
    HrInicioLog := Time;
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      JsonArrayRetorno := EnderecoDAO.GetEnderecoOcupacao(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/endereco/ocupacao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: EHorseException do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/endereco/ocupacao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure ExportFile(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
Begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.ExportFile(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      on E: EHorseException do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

procedure GetLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
  AQueryParam: TDictionary<String, String>;
  pEnderecoId, pEstruturaId, pZonaId, pRuaId, pStatus, pBloqueado: Integer;
  pEnderecoIni, pEnderecoFin, pOcupacaoEndereco, pListaZona, pCurva: String;
  pBuscaParcial : Integer;
  JsonArrayRetorno, JsonArrayErro : TJsonArray;
  JsonObjectRetorno : TJsonObject;
  HrInicioLog: TTime;
  pLimit, pOffSet : Integer;
Begin
  Try
    HrInicioLog := Time;
    EnderecoDAO := TEnderecoDAO.Create;
    Try
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os par�metros para pesquisar os endere�os.'))).Status(THttpStatus.Created);
         Exit;
      End;
      pEnderecoId   := 0;
      pEstruturaId  := 0;
      pZonaId       := 0;
      pRuaId        := 0;
      pEnderecoIni  := '';
      pEnderecoFin  := '';
      pListaZona    := '';
      pCurva        := '';
      pBuscaParcial := 0;
      pLimit        := 0;
      pOffSet       := 0;
      if AQueryParam.ContainsKey('enderecoid') then
         pEnderecoId := AQueryParam.Items['enderecoid'].ToInteger;
      if AQueryParam.ContainsKey('estruturaid') then
         pEstruturaId := AQueryParam.Items['estruturaid'].ToInteger;
      if AQueryParam.ContainsKey('zonaid') then
         pZonaId := AQueryParam.Items['zonaid'].ToInteger;
      if AQueryParam.ContainsKey('ruaid') then
         pRuaId := AQueryParam.Items['ruaid'].ToInteger;
      if AQueryParam.ContainsKey('enderecoini') then
         pEnderecoIni := AQueryParam.Items['enderecoini'];
      if AQueryParam.ContainsKey('enderecofin') then
         pEnderecoFin := AQueryParam.Items['enderecofin'];
      If AQueryParam.ContainsKey('ocupacaoendereco') then
         pOcupacaoEndereco := AQueryParam.Items['ocupacaoendereco']
      Else
         pOcupacaoEndereco := 'T';
      if AQueryParam.ContainsKey('listazona') then
         pListaZona := AQueryParam.Items['listazona'];
      if AQueryParam.ContainsKey('curva') then
         pCurva := AQueryParam.Items['curva'];
      If AQueryParam.ContainsKey('status') then
         pStatus := AQueryParam.Items['status'].ToInteger
      Else
         pStatus := 99;
      If AQueryParam.ContainsKey('bloqueado') then
         pBloqueado := AQueryParam.Items['bloqueado'].ToInteger
      Else
         pBloqueado := 0;
      If AQueryParam.ContainsKey('buscaparcial') then
         pBuscaParcial := AQueryParam.Items['buscaparcial'].ToInteger;
      If AQueryParam.ContainsKey('limit') then
         pLimit := AQueryParam.Items['limit'].ToInteger;
      If AQueryParam.ContainsKey('offset') then
         pOffSet := AQueryParam.Items['offset'].ToInteger;
      If (pLimit = 0) and (pOffSet=0) then Begin
         JsonArrayRetorno := EnderecoDAO.GetLista(pEnderecoId, pEstruturaId, pZonaId, pRuaId, pEnderecoIni, pEnderecoFin,
                                                  pOcupacaoEndereco, pStatus, pBloqueado, pListaZona, pCurva, pBuscaParcial, pLimit, pOffSet);
         Res.Send<TJSonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/endereco/lista', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                         201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End
      Else Begin
         JsonArrayRetorno := EnderecoDAO.GetLista(pEnderecoId, pEstruturaId, pZonaId, pRuaId, pEnderecoIni, pEnderecoFin,
                                                  pOcupacaoEndereco, pStatus, pBloqueado, pListaZona, pCurva, pBuscaParcial, pLimit, pOffSet);
         JsonObjectRetorno := TJsonObject.Create;
         JsonObjectRetorno.AddPair('endereco', JsonArrayRetorno);
         JsonObjectRetorno.AddPair('recodcount', TJsonNumber.Create(EnderecoDAO.GetListaRecordCount(pEnderecoId, pEstruturaId, pZonaId, pRuaId, pEnderecoIni, pEnderecoFin,
                                                  pOcupacaoEndereco, pStatus, pBloqueado, pListaZona, pCurva, pBuscaParcial, pLimit, pOffSet)));
         Res.Send<TJsonObject>(JsonObjectRetorno).Status(THTTPStatus.Ok);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/endereco/lista', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                         201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        If (pLimit = 0) and (pOffSet=0) then Begin
          JsonArrayErro := TJsonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Ok); //ExpectationFailed);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/endereco/lista', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
        End
      Else begin
          Res.Send<TJsonObject>(TJSONObject.Create.AddPair('Erro', E.Message)).Status(THttpStatus.Ok); //ExpectationFailed);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/endereco/lista', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      end;
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetID('0'));
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
end;

procedure GetEstrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetEstrutura(StrToIntDef(Req.Params.Items['estruturaid'], 0))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetID(Req.Params.Items['enderecoid']))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
end;

procedure GetEndereco4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send(EnderecoDAO.GetEndereco4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
end;

Procedure GetPadraoMovimentacao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
  Result: TJSonArray;
Begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetMotivoMovimentacaoSegregado).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Result := TJSonArray.Create;
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJSonArray>(Result);
      End;
    end;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure GetPickingMask(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
Begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetPickingMask)
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure GetReUsoPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
  JsonArrayErro: TJSonArray;
Begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>(EnderecoDAO.GetReUsoPicking(StrToIntDef(Req.Params.Items['zonaid'], 0),
                           StrToIntDef(Req.Params.Items['dias'], 0))).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEndereco: TJSONObject;
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      EnderecoDAO.InsertUpdate(Req.Body<TJSONObject>);
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
    FreeAndNil(enderecoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEndereco: TJSONObject;
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      EnderecoDAO.InsertUpdate(Req.Body<TJSONObject>);
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
    FreeAndNil(enderecoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    Try
      EnderecoDAO := TEnderecoDAO.Create;
      EnderecoDAO.Delete(StrToIntDef(Req.Params.Items['enderecoid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
end;

constructor TEnderecoCtrl.Create;
begin
  FEndereco := TEndereco.Create;
end;

destructor TEnderecoCtrl.Destroy;
begin
  FreeAndNil(FEndereco);
  inherited;
end;

procedure GetZona(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSonArray>
        (EnderecoDAO.GetZona(StrToIntDef(Req.Params.Items['zonaid'], 0)))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure manutencao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EnderecoDAO: TEnderecoDAO;
    HrInicioLog: TTime;
    JsonArrayErro : TJsonArray;
Begin
  Try
    HrInicioLog := Time;
    try
      EnderecoDAO := TEnderecoDAO.Create;
      EnderecoDAO.manutencao(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/endereco/manutencao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: Manutenção realizada com Sucesso!',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Ok); //ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/endereco/manutencao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      Res.Send<TJSONObject>(EnderecoDAO.MontarPaginacao)
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

Procedure PutDesvincularPicking(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  JsonArrayRetorno: TJSonArray;
  EnderecoDAO: TEnderecoDAO;
begin
  Try
    try
      EnderecoDAO := TEnderecoDAO.Create;
      JsonArrayRetorno := EnderecoDAO.PutDesvincularPicking(Req.Body<TJSonArray>);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement
          (TJSONObject.Create(TJSONPair.Create('Resultado', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecoDAO);
  End;
End;

End.
