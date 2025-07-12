unit ProcessoDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, ProcessoClass, System.JSON, REST.Json, Rest.Types;

Type

  TProcessoDao = class
  private
    FProcesso : TProcesso;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetProcesso(pProcesso : string = ''; pShowErro : Integer = 1) : tJsonArray;
    Function GetProcessoIncremental(pProcesso : string = '') : tJsonArray;
    Function Salvar : tjsonObject;
    Property ObjProcesso : TProcesso Read FProcesso Write FProcesso;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TProcessoDao.Create;
begin
  Self.FProcesso := TProcesso.Create;
end;

function TProcessoDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo/{processoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processoid', Self.ObjProcesso.Id.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201, 204]) Then
     Result := True
  Else
    raise Exception.Create('não foi possível excluir o registro de Processos!');
end;

function TProcessoDao.GetProcesso(pProcesso : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjProcesso  : TProcesso;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo';
  if pProcesso = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo'
  Else Begin
     if (pProcesso='0') or (StrToIntDef(pProcesso, 0) > 0) then
        DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo/{processoid}'
     Else DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo/0/{processoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processoid', pProcesso);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TProcessoDao.GetProcessoIncremental(pProcesso: string): tJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pProcesso = '' then pProcesso := '*';
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo/incremental/{processo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

Function TProcessoDao.Salvar: tjsonObject;
Var jSonProcesso : TJsonObject;
begin
  jSonProcesso := tJson.ObjectToJsonObject(Self.FProcesso);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonProcesso.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjProcesso.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/processo/{processoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('Processoid', Self.FProcesso.Id.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonProcesso);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.

