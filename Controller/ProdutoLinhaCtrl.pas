{
   ProdutoLinhaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit ProdutoLinhaCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     ProdutoLinhaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TProdutoLinhaCtrl = Class
  Private
    //Funções de Validação
    FObjProdutoLinha : TProdutoLinha;
    LstProdutoLinha : TObjectList<TProdutoLinha>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function GetProdutoLinha(pProdutoLinhaId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1)  : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function ImportDados(pId : Integer; pSigla, pDescricao : String; pAtivo : Integer) : Boolean;
    Class Function DelProdutoLinha(pProdutoLinhaId : Integer) : Boolean;
    Property ObjProdutoLinha  : TProdutoLinha Read FObjProdutoLinha Write FObjProdutoLinha;
  End;

implementation

{ tCtrlProdutoLinha }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tProdutoLinhaCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjProdutoLinha do Begin
    if Descricao = '' then raise Exception.Create('Informe o Nome do Fabricante!');

  End;
  Result := True;
End;

constructor TProdutoLinhaCtrl.Create;
begin
  FObjProdutoLinha := TProdutoLinha.Create;
end;

class function TProdutoLinhaCtrl.DelProdutoLinha(pProdutoLinhaId : Integer): Boolean;
Var JsonArrayErro : TJsonArray;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtolinha/{produtolinhaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtolinhaid', pProdutoLinhaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else Begin
//    JsonArrayErro := (DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray);
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray).Items[0].GetValue<String>('Erro'));
  End;
end;

destructor TProdutoLinhaCtrl.Destroy;
begin
  FObjProdutoLinha.Free;
  inherited;
end;

Function tProdutoLinhaCtrl.GetProdutoLinha(pProdutoLinhaId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;
Var vResourceURI, pCompl : String;
Begin
  DmeXactWMS.ResetRest;
  pCompl := '?';
  vResourceURI := 'v1/produtolinha';
  if (pProdutoLinhaId > 0) then Begin
     vResourceURI := vResourceURI + pCompl + 'produtolinhaid='+pProdutoLinhaId.Tostring();
     pCompl := '&';
  End;
  if (pDescricao<>'') then Begin
     vResourceURI := vResourceURI + pCompl + 'descricao='+pDescricao;
     pCompl := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
  End;
End;

function TProdutoLinhaCtrl.ImportDados(pId: Integer; pSigla, pDescricao: String;
  pAtivo: Integer): Boolean;
Var JsonObjectImport : TJsonObject;
begin
  JsonObjectImport := TJsonObject.Create;
  JsonObjectImport.AddPair('sigla', pSigla)
  .AddPair('descricao', pDescricao)
  .AddPair('status', TJsonNumber.Create(1));
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(JsonObjectImport.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtolinha/import';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True //DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Else
     result := False;
  JsonObjectImport.Free;
end;

Function tProdutoLinhaCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonArrayProdutoLinha : TJsonArray;
Begin
  Result := True;
  jSonArrayProdutoLinha := TJsonArray.Create;
  jSonArrayProdutoLinha.AddElement(TJson.ObjectToJsonObject(ObjProdutoLinha));
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonArrayProdutoLinha.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtolinha';
  DmeXactWMS.RESTRequestWMS.Method := rmPUT;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True //DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Else
     result := False;
  jSonArrayProdutoLinha.Free;
End;

End.

