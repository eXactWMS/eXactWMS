unit DesenhoArmazemDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, DesenhoArmazemClass, System.JSON, REST.Json, Rest.Types;

Type

  TDesenhoArmazemDao = class
  private
    FDesenhoArmazem : TDesenhoArmazem;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetDesenhoArmazem(pArmazemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : tjsonObject;
    Property ObjDesenhoArmazem : TDesenhoArmazem Read FDesenhoArmazem Write FDesenhoArmazem;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TDesenhoArmazemDao.Create;
begin
  Self.FDesenhoArmazem := TDesenhoArmazem.Create;
end;

function TDesenhoArmazemDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/desenhoarmazem/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.ObjDesenhoArmazem.Id.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TDesenhoArmazemDao.GetDesenhoArmazem(pArmazemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjDesenhoArmazem  : TDesenhoArmazem;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pArmazemId = 0) and (pDescricao = '') then //and (pLado in [' ', 'U']) then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/desenhoarmazem'
  Else if (pArmazemId <> 0) then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/desenhoarmazem/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pArmazemId.Tostring());
  End
  Else if (pDescricao <> '') then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/desenhoarmazem/0/{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TDesenhoArmazemDao.Salvar: tjsonObject;
Var jSonDesenhoArmazem : TJsonObject;
begin
  jSonDesenhoArmazem := tJson.ObjectToJsonObject(Self.FDesenhoArmazem);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonDesenhoArmazem.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjDesenhoArmazem.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/desenhoarmazem';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/desenhoarmazem/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.FDesenhoArmazem.Id.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonDesenhoArmazem);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
