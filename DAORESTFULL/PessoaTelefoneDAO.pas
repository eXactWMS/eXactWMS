unit PessoaTelefoneDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PessoaClass, System.JSON, REST.Json, Rest.Types;

Type

  TPessoaTelefoneDao = class
  private
    FPessoaTelefone : TPessoaTelefone;
  public
    constructor Create;
    Function GetPessoaTelefone(pIndFone : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Property PessoaTelefone : TPessoaTelefone Read FPessoaTelefone Write FPessoaTelefone;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TPessoaTelefoneDao.Create;
begin
  Self.FPessoaTelefone := TPessoaTelefone.Create;
end;

function TPessoaTelefoneDao.Delete : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoatelefone/{indfone}/{pessoaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('indfone', Self.PessoaTelefone.IndFone.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', Self.PessoaTelefone.PessoaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o Trelefone do contato.');
end;

function TPessoaTelefoneDao.GetPessoaTelefone(pIndFone : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 1): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPessoaTelefone  : TPessoaTelefone;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoatelefone/{indfone}/{pessoaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('indfone', pIndFone.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPessoaTelefoneDao.Salvar: Boolean;
Var jSonPessoaTelefone : TJsonObject;
begin
  Result := False;
  jSonPessoaTelefone := tJson.ObjectToJsonObject(Self.FPessoaTelefone);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPessoaTelefone.ToJson, ContentTypeFromString('application/json'));
  if Self.PessoaTelefone.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoatelefone';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoatelefone/{indfone}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('idfone', Self.FPessoaTelefone.IndFone.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPessoaTelefone);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
