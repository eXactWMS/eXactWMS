unit ProdutoCodBarrasDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, ProdutoCodBarrasClass, System.JSON, REST.Json, Rest.Types;

Type

  TProdutoCodBarrasDao = class
  private
    FProdutoCodBarras : TProdutoCodBarras;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetProdutoCodBarras(pProdutoCodBarrasId : Integer = 0; pProdutoId : Integer = 0; pCodBarras : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : Boolean;
    Property ProdutoCodBarras : TProdutoCodBarras Read FProdutoCodBarras Write FProdutoCodBarras;
  end;

implementation

Uses UDmeXactWMS;

{ TProdutoCodBarrasDao }

constructor TProdutoCodBarrasDao.Create;
begin
  Self.ProdutoCodBarras := TProdutoCodBarras.Create;
  DmeXactWMS.ResetRest;
end;

function TProdutoCodBarrasDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtocodbarras/{codbarrasid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codbarrasid', Self.ProdutoCodBarras.CodBarrasid.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     //ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TProdutoCodBarrasDao.GetProdutoCodBarras(pProdutoCodBarrasId : Integer = 0; pProdutoId : Integer = 0;
pCodBarras : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
begin
  if pCodBarras = '' then pCodBarras := '*';
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtocodbarras/{codbarrasid}/{produtoid}/{codbarras}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codbarrasid', pProdutoCodBarrasId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codbarras', pCodBarras);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TProdutoCodBarrasDao.Salvar: Boolean;
Var jSonProdutoCodBarras : TJsonObject;
begin
  jSonProdutoCodBarras := TJsonObject.Create; // tJson.ObjectToJsonObject(Self);
  JsonProdutoCodBarras.AddPair('codbarrasid', TJsonNumber.Create(Self.ProdutoCodBarras.CodBarrasId));
  JsonProdutoCodBarras.AddPair('produtoid',   TJsonNumber.Create(Self.ProdutoCodBarras.ProdutoId));
  JsonProdutoCodBarras.AddPair('codbarras',   Self.ProdutoCodBarras.CodBarras);
  JsonProdutoCodBarras.AddPair('unidadesembalagem', TJsonNumber.Create(Self.ProdutoCodBarras.UnidadesEmbalagem));
  JsonProdutoCodBarras.AddPair('principal', TJsonNumber.Create(Self.ProdutoCodBarras.Principal));
  JsonProdutoCodBarras.AddPair('status', TJsonNumber.Create(Self.ProdutoCodBarras.Status));
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.AddBody(jSonProdutoCodBarras.ToJson, ContentTypeFromString('application/json'));
  if Self.ProdutoCodBarras.CodBarrasId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtocodbarras';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtocodbarras/{codbarrasid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codbarrasid', Self.ProdutoCodBarras.CodBarrasId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonProdutoCodBarras);
  Result := ((DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201));
end;

end.
