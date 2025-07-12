unit FuncionalidadeDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, FuncionalidadeClass, System.JSON, REST.Json, Rest.Types;

Type

  TFuncionalidadeDao = class
  private
    FFuncionalidade : TFuncionalidade;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetFuncionalidade(pFuncionalidade : string = ''; pShowErro : Integer = 1) : tJsonArray;
    Function GetTopicoFuncionalidades(pTopicoId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : tjsonObject;
    Function SalvarTopicoFuncionalidade(pTopicoId, pFuncionalidadeId, pStatus: Integer) : tjsonObject;
    Property ObjFuncionalidade : TFuncionalidade Read FFuncionalidade Write FFuncionalidade;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TFuncionalidadeDao.Create;
begin
  Self.FFuncionalidade := TFuncionalidade.Create;
end;

function TFuncionalidadeDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/funcionalidade/{funcionalidadeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('funcionalidadeid', Self.ObjFuncionalidade.FuncionalidadeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro de Tópicos!');
end;

function TFuncionalidadeDao.GetFuncionalidade(pFuncionalidade : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjFuncionalidade  : TFuncionalidade;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pFuncionalidade = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/funcionalidade'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/funcionalidade/{funcionalidade}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('funcionalidade', pFuncionalidade);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TFuncionalidadeDao.GetTopicoFuncionalidades(pTopicoId,
  pShowErro: Integer): tJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/topicofuncionalidades/{topicoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('topicoid', pTopicoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TFuncionalidadeDao.Salvar: tjsonObject;
Var jSonFuncionalidade : TJsonObject;
begin
  jSonFuncionalidade := tJson.ObjectToJsonObject(Self.FFuncionalidade);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonFuncionalidade.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjFuncionalidade.FuncionalidadeId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/funcionalidade';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/funcionalidade/{funcionalidadeid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('funcionalidadeid', Self.FFuncionalidade.FuncionalidadeId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonFuncionalidade);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TFuncionalidadeDao.SalvarTopicoFuncionalidade(pTopicoId,
  pFuncionalidadeId, pStatus: Integer): tjsonObject;
Var jSonTopicoFuncionalidade : TJsonObject;
begin
  jSonTopicoFuncionalidade := TJsonObject.Create;
  JsonTopicoFuncionalidade.AddPair('topicoid', TJSONNumber.Create(pTopicoId));
  JsonTopicoFuncionalidade.AddPair('funcionalidadeid', TJSONNumber.Create(pFuncionalidadeId));
  JsonTopicoFuncionalidade.AddPair('status', TJSONNumber.Create(pStatus));
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonTopicoFuncionalidade.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/topicofuncionalidade';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonTopicoFuncionalidade);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
