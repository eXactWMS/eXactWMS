unit EnderecoEstruturaDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EnderecoEstruturaClass, System.JSON, REST.Json, Rest.Types;

Type

  TEnderecoEstruturaDAO = class
  private
    FEnderecoEstrutura : TEnderecoEstrutura;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetEnderecoEstrutura(pEnderecoEstruturaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : tjsonObject;
    Property ObjEnderecoEstrutura : TEnderecoEstrutura Read FEnderecoEstrutura Write FEnderecoEstrutura;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TEnderecoEstruturaDao.Create;
begin
  Self.FEnderecoEstrutura := TEnderecoEstrutura.Create;
end;

function TEnderecoEstruturaDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecoestrutura/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.ObjEnderecoEstrutura.EstruturaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TEnderecoEstruturaDao.GetEnderecoEstrutura(pEnderecoEstruturaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjEnderecoEstrutura  : TEnderecoEstrutura;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pEnderecoEstruturaId = 0) and (pDescricao = '') then //and (pLado in [' ', 'U']) then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecoestrutura'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecoestrutura/{id}/{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pEnderecoEstruturaId.ToString());
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TEnderecoEstruturaDao.Salvar: tjsonObject;
Var jSonEnderecoEstrutura : TJsonObject;
begin
  jSonEnderecoEstrutura := tJson.ObjectToJsonObject(Self.FEnderecoEstrutura);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEnderecoEstrutura.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjEnderecoEstrutura.EstruturaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecoestrutura';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecoestrutura/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.FEnderecoEstrutura.EstruturaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonEnderecoEstrutura);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
