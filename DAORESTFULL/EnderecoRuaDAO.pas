unit EnderecoRuaDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EnderecamentoRuaClass, System.JSON, REST.Json, Rest.Types;

Type

  TEnderecoRuaDao = class
  private
    FEnderecoRua : TEnderecoRua;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetEnderecoRua(pEnderecoRuaId : Integer = 0; pDescricao : String = ''; pLado : String = 'U'; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : tjsonObject;
    Property ObjEnderecoRua : TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TEnderecoRuaDao.Create;
begin
  Self.FEnderecoRua := TEnderecoRua.Create;
end;

function TEnderecoRuaDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecorua/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.ObjEnderecoRua.RuaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TEnderecoRuaDao.GetEnderecoRua(pEnderecoRuaId : Integer = 0; pDescricao : String = ''; pLado : String = 'U'; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjEnderecoRua  : TEnderecoRua;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pEnderecoRuaId = 0) and (pDescricao = '') then //and (pLado in [' ', 'U']) then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecorua'
  Else if (pEnderecoRuaId > 0) then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecorua/{ruaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('ruaid', pEnderecoRuaId.ToString());
  End
  Else if (pDescricao <> '') then Begin
     if pLado = '' then Begin
        DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecorua/{descricao}';
        DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
     End
     Else Begin
        DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecolado/{descricao}/{lado}';
        DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
        DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('lado', pLado);
     End;
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TEnderecoRuaDao.Salvar: tjsonObject;
Var jSonEnderecoRua : TJsonObject;
begin
  jSonEnderecoRua := tJson.ObjectToJsonObject(Self.FEnderecoRua);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEnderecoRua.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjEnderecoRua.RuaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecorua';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecorua/{ruaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('ruaid', Self.FEnderecoRua.RuaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonEnderecoRua);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
