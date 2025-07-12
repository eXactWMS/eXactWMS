unit PessoaEnderecoDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PessoaClass, System.JSON, REST.Json, Rest.Types;

Type

  TPessoaEnderecoDao = class
  private
    FPessoaEndereco : TPessoaEndereco;
  public
    constructor Create;
    Function GetPessoaEndereco(pId : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Property PessoaEndereco : TPessoaEndereco Read FPessoaEndereco Write FPessoaEndereco;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TPessoaEnderecoDao.Create;
begin
  Self.FPessoaEndereco := TPessoaEndereco.Create;
end;

function TPessoaEnderecoDao.Delete : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoaendereco/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.PessoaEndereco.Id.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TPessoaEnderecoDao.GetPessoaEndereco(pId : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 1): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPessoaEndereco  : TPessoaEndereco;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoaendereco/{id}/{pessoaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPessoaEnderecoDao.Salvar: Boolean;
Var jSonPessoaEndereco : TJsonObject;
begin
  Result := False;
  jSonPessoaEndereco := tJson.ObjectToJsonObject(Self.FPessoaEndereco);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPessoaEndereco.ToJson, ContentTypeFromString('application/json'));
  if Self.PessoaEndereco.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoaendereco';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoaendereco/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.FPessoaEndereco.Id.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPessoaEndereco);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
