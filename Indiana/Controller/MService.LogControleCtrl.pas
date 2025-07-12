{
  MService.EnderecoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.LogControleCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Exactwmsservice.lib.utils,
  Horse,
  Horse.utils.ClientIP,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TLogControleCtrl = Class
  Private
    // Fun��es de Valida��o
    //FLogControle: TLogControle;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    //Property ObjLogControle: TLogControle Read FLogControle Write FLogControle;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses MService.LogControleDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse
    .Group.Prefix('v1')
    .Get('/logcontrole', Get);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LogControleDAO: TLogControleDAO;
  AQueryParam  : TDictionary<String, String>;
  pDataInicio, pDataTermino : TDateTime;
  pUsuarioId   : Integer;
  pTerminal    : String;
  pSomenteErro : Integer;
  JsonArrayRetorno, JsonArrayErro : TJsonArray;
  HrInicioLog: TTime;
Begin
  Try
    HrInicioLog := Time;
    LogControleDAO := TLogControleDAO.Create;
    Try
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os parâmetros para pesquisar os endere�os.'))).Status(THttpStatus.Created);
         Exit;
      End;
      pDataInicio  := 0;
      pDataTermino := 0;
      pUsuarioId   := 0;
      pTerminal    := '';
      pSomenteErro := 0;
      if AQueryParam.ContainsKey('datainicio') then Begin
         pDataInicio  := StrToDate(AQueryParam.Items['datainicio']);
      End;
      if AQueryParam.ContainsKey('datatermino') then Begin
         pDataTermino := StrToDate(AQueryParam.Items['datatermino']);
      End;
      if AQueryParam.ContainsKey('usuarioid') then
         pUsuarioId := AQueryParam.Items['usuarioid'].ToInteger;
      if AQueryParam.ContainsKey('terminal') then
         pTerminal := AQueryParam.Items['terminal'];
      if AQueryParam.ContainsKey('somenteerro') then
         pSomenteErro := AQueryParam.Items['somenteerro'].ToInteger;
      JsonArrayRetorno := LogControleDAO.Get(pDataInicio, pDataTermino, pUsuarioId, pTerminal, pSomenteErro);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THTTPStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/logcontrole/get', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Ok); //ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/logcontrole/get', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LogControleDAO);
  End;
End;
{ TLogControleCtrl }

constructor TLogControleCtrl.Create;
begin
//
end;

destructor TLogControleCtrl.Destroy;
begin
//
  inherited;
end;

end.
