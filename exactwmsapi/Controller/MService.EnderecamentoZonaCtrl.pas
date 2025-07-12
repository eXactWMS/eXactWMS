{
  MService.enderecamentoZonaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.enderecamentoZonaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  enderecamentoZonaClass, Exactwmsservice.lib.utils,
  Horse,
  Horse.utils.ClientIP,
  System.JSON;

Type
  TipoConsulta = (Resumida, Completa);

  TenderecamentoZonaCtrl = Class
  Private
    // Fun��es de Valida��o
    FenderecamentoZona: TenderecamentoZona;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjenderecamentoZona: TenderecamentoZona Read FenderecamentoZona
      Write FenderecamentoZona;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEnderecamentoZona4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetZonas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetZonaPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlenderecamentoZona }

uses MService.enderecamentoZonaDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/enderecamentozona', Get);
  THorse.Get('/v1/enderecamentozona/:zonaid', GetID);
  THorse.Get('/v1/enderecamentozona4D', GetEnderecamentoZona4D);
  THorse.Get('/v1/enderecamentozona/:zonaid/:descricao', GetDescricao);
  THorse.Get('/v1/enderecamentozona/estrutura', Estrutura);
  THorse.Post('/v1/enderecamentozona', Insert);
  THorse.Put('/v1/enderecamentozona/:zonaid', Update);
  THorse.Delete('/v1/enderecamentozona/:zonaid', Delete);
  THorse.Get('v1/enderecamentozona/montarpaginacao', MontarPaginacao);
  THorse.Get('v1/enderecamentozona/zonapicking/:zonaid/:pickingfixo/:disponivel', GetZonaPicking);
  THorse.Get('v1/zonas', GetZonas)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  enderecamentoZonaDAO: TenderecamentoZonaDAO;
Begin
  Try
    Try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      Res.Send<TJSonArray>(enderecamentoZonaDAO.Estrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var JsonArrayRetorno     : TJsonArray;
    enderecamentoZonaDAO : TenderecamentoZonaDAO;
begin
  Try
    Try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      JsonArrayRetorno := enderecamentoZonaDAO.GetID(0);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);;
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  enderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      Res.Send<TJSonArray>(enderecamentoZonaDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var JsonArrayRetorno     : TJsonArray;
    enderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      JsonArrayRetorno := enderecamentoZonaDAO.GetID(StrToIntDef(Req.Params.Items['zonaid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
end;

Procedure GetEnderecamentoZona4D(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  enderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    Try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      Res.Send(enderecamentoZonaDAO.GetZona4D(Req.Query.Dictionary));
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
    FreeAndNil(enderecamentoZonaDAO);
  End;
End;

Procedure GetZonaPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EnderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      Res.Send<TJSonArray>(enderecamentoZonaDAO.GetZonaPicking(StrToIntDef(Req.Params.Items['zonaid'], 0),
                           StrToIntDef(Req.Params.Items['pickingfixo'], 0),
                           StrToIntDef(Req.Params.Items['disponivel'], 0))).Status(THttpStatus.Created);
    Except On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
End;

procedure GetZonas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EnderecamentoZonaDAO: TenderecamentoZonaDAO;
    JsonArrayRetorno : TJsonArray;
    JsonArrayErro    : TjsonArray;
    HrInicioLog: int64;
Begin
  Try
    HrInicioLog := GetCurrentTime;
    try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      JsonArrayRetorno := enderecamentoZonaDAO.GetZonas(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/zonas', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/zonas', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        403, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  enderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    Try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      enderecamentoZonaDAO.InsertUpdate(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var EnderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    Try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      enderecamentoZonaDAO.InsertUpdate(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var ObjArray: TJSONObject;
    EnderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    Try
      enderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      enderecamentoZonaDAO.Delete(StrToIntDef(Req.Params.Items['zonaid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
end;

constructor TenderecamentoZonaCtrl.Create;
begin
  FenderecamentoZona := TenderecamentoZona.Create;
end;

destructor TenderecamentoZonaCtrl.Destroy;
begin
  FreeAndNil(FenderecamentoZona);
  inherited;
end;

procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecamentoZonaDAO: TenderecamentoZonaDAO;
begin
  Try
    Try
      EnderecamentoZonaDAO := TenderecamentoZonaDAO.Create;
      Res.Send<TJSONObject>(EnderecamentoZonaDAO.MontarPaginacao).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(enderecamentoZonaDAO);
  End;
end;

End.
