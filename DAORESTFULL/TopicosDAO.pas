unit TopicosDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, TopicosClass, System.JSON, REST.Json, Rest.Types;

Type

  TTopicosDao = class
  private
    FTopicos : TTopicos;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetTopicos(pTopico : string = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : tjsonObject;
    Property ObjTopicos : TTopicos Read FTopicos Write FTopicos;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TTopicosDao.Create;
begin
  Self.FTopicos := TTopicos.Create;
end;

function TTopicosDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/topico/{topicoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('topicoid', Self.ObjTopicos.TopicoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro de Tópicos!');
end;

function TTopicosDao.GetTopicos(pTopico : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjTopicos  : TTopicos;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pTopico = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/topico'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/topico/{topico}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('topico', pTopico);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TTopicosDao.Salvar: tjsonObject;
Var jSonTopicos : TJsonObject;
begin
  jSonTopicos := tJson.ObjectToJsonObject(Self.FTopicos);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonTopicos.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjTopicos.TopicoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/topico';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/topico/{topicoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('topicoid', Self.FTopicos.TopicoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonTopicos);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
