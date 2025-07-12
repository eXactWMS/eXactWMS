unit PedidoVolumeSeparacaoDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PedidoVolumeSeparacaoClass, System.JSON, REST.Json, Rest.Types;

Type

  TVolumeSeparacaoDao = class
  private
    FVolumeSeparacao : TVolumeSeparacao;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetVolumeSeparacao(pCaixaEmbalagemId : Integer = 0; pPedidoVolumeId : Integer = 0; pOperacao : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function FinalizarSeparacao : tjsonObject;
    Function SaveSeparacao(JsonSeparacao : tjsonObject) : tjsonObject;
    Function GetResumoSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao, pDataFinalProducao : TDateTime; pUsuarioId : Integer; pProcessoId : Integer) : TJsonArray;
    Function GetDSHSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao, pDataFinalProducao : TDateTime; pUsuarioId : Integer; pZonaId : Integer) : TJsonArray;
    Function GetDesempenhoExpedicao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao, pDataFinalProducao : TDateTime; pUsuarioId, pAnalise : Integer; pEmbalagemId : Integer) : TJsonArray;
    Property ObjVolumeSeparacao : TVolumeSeparacao Read FVolumeSeparacao Write FVolumeSeparacao;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFuncoes;

constructor TVolumeSeparacaoDao.Create;
begin
  Self.FVolumeSeparacao := TVolumeSeparacao.Create;
end;

function TVolumeSeparacaoDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeseparacao/{volumeseparacaoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeseparacaoid', Self.ObjVolumeSeparacao.VolumeSeparacaoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TVolumeSeparacaoDao.GetDesempenhoExpedicao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao,
  pDataFinalProducao: TDateTime; pUsuarioId, pAnalise : Integer; pEmbalagemId : Integer): TJsonArray;
Var  vResourceURI, vCompl    : String;
begin
  DmeXactWMS.ResetRest;
  vCompl := '?';
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/desempenhoexpedicao';
  if pDataInicialPedido <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datainicialpedido='+DateToStr(pDataInicialPedido);
     vCompl := '&';
  End;
  if pDataFinalPedido <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datafinalpedido='+DateToStr(pDataFinalPedido);
     vCompl := '&';
  End;
  if pDataInicialProducao <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datainicialproducao='+DateToStr(pDataInicialProducao);
     vCompl := '&';
  End;
  if pDataFinalProducao <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datafinalproducao='+DateToStr(pDataFinalProducao);
     vCompl := '&';
  End;
  if pUsuarioId > 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'usuarioid='+pUsuarioId.Tostring;
     vCompl := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'analise='+pAnalise.Tostring;
  vCompl := '&';
  DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'embalagemid='+pEmbalagemId.Tostring;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  End
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TVolumeSeparacaoDao.GetDSHSeparacao(pDataInicialPedido,
  pDataFinalPedido, pDataInicialProducao, pDataFinalProducao: TDateTime;
  pUsuarioId, pZonaId: Integer): TJsonArray;
Var  vResourceURI, vCompl    : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vCompl := '?';
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/dshseparacao';
    if pDataInicialPedido <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datapedidoinicial='+DateToStr(pDataInicialPedido);
       vCompl := '&';
    End;
    if pDataFinalPedido <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datapedidofinal='+DateToStr(pDataFinalPedido);
       vCompl := '&';
    End;
    if pDataInicialProducao <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'dataproducaoinicial='+DateToStr(pDataInicialProducao);
       vCompl := '&';
    End;
    if pDataFinalProducao <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'dataproducaofinal='+DateToStr(pDataFinalProducao);
       vCompl := '&';
    End;
    if pUsuarioId > 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'usuarioid='+pUsuarioId.Tostring;
       vCompl := '&';
    End;
    if pZonaId > 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'zonaid='+pZonaId.Tostring;
       vCompl := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception Do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TVolumeSeparacaoDao.GetResumoSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao,
  pDataFinalProducao: TDateTime; pUsuarioId, pProcessoId: Integer): TJsonArray;
Var  vResourceURI, vCompl    : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vCompl := '?';
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/resumoseparacao';
    if pDataInicialPedido <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datainicialpedido='+DateToStr(pDataInicialPedido);
       vCompl := '&';
    End;
    if pDataFinalPedido <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datafinalpedido='+DateToStr(pDataFinalPedido);
       vCompl := '&';
    End;
    if pDataInicialProducao <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datainicialproducao='+DateToStr(pDataInicialProducao);
       vCompl := '&';
    End;
    if pDataFinalProducao <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'datafinalproducao='+DateToStr(pDataFinalProducao);
       vCompl := '&';
    End;
    if pUsuarioId > 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'usuarioid='+pUsuarioId.Tostring;
       vCompl := '&';
    End;
  //  if pProcessoId < 0 then
    DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource +vCompl+'processoid='+pProcessoId.ToString();
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception Do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TVolumeSeparacaoDao.GetVolumeSeparacao(pCaixaEmbalagemId : Integer = 0; pPedidoVolumeId : Integer = 0;
pOperacao : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjVolumeSeparacao  : TVolumeSeparacao;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeseparacao/{caixaembalagemid}/{pedidovolumeid}/{operacao}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', pCaixaEmbalagemId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacao', pOperacao.ToString());

  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TVolumeSeparacaoDao.FinalizarSeparacao: tjsonObject;
Var jSonVolumeSeparacao : TJsonObject;
begin
  jSonVolumeSeparacao := tJson.ObjectToJsonObject(Self.FVolumeSeparacao);
  JsonVolumeSeparacao.AddPair('estacao', NomeDoComputador);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonVolumeSeparacao.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjVolumeSeparacao.VolumeSeparacaoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeseparacao';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeseparacao/{volumeseparacaoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeseparacaoid', Self.FVolumeSeparacao.VolumeSeparacaoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
  FreeAndNil(jSonVolumeSeparacao);
end;

Function TVolumeSeparacaoDao.SaveSeparacao(JsonSeparacao : tjsonObject) : tjsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jsonSeparacao.toJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeseparacao/savecheckin';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
//  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
//  Else
//    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
