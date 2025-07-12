unit uEntradaItensDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EntradaItensClass, System.JSON, REST.Json, Rest.Types;

Type

  TEntradaItensDao = class
  private
    FEntradaItens : TEntradaItens;
  public
    constructor Create;
    Function Delete : Boolean;
    Function DelCheckIn(pEntradaId, pPedidoItemId : Integer) : Boolean;
    Function GetEntradaItens(pEntradaId :Integer = 0; pProdutoId : Integer =0; pLoteId : Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function GetEntradaProduto(pEntradaId :Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function GetProdutoTagClass(pPedidoId: Integer; pDocumentoNr: String; pDtDocumentoData: TDateTime; pRegistroERP: String;
                           pDtCheckInFinalizacao: TDateTime; pCodigoERP : Integer; pTagEstoque : Boolean): TJsonArray;
    Function Salvar : Boolean;
    Function CancelarCheckInProduto(pAgrupamentoId, pEntradaId, pCodProduto : Integer) : TJsonArray;
    Function RegPrintEtqProduto(pPedidoId, pLoteId: Integer): TJsonArray;
    Property EntradaItens : TEntradaItens Read FEntradaItens Write FEntradaItens;
  end;

implementation

Uses UDmeXactWMS;

{ TEntradaItensDao }

function TEntradaItensDao.CancelarCheckInProduto(pAgrupamentoId, pEntradaId, pCodProduto: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/cancelarcheckinproduto/{agrupamentoid}/{pedidoid}/{codproduto}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pEntradaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codproduto', pCodProduto.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

constructor TEntradaItensDao.Create;
begin
  Self.EntradaItens := TEntradaItens.Create;
  DmeXactWMS.ResetRest;
end;

function TEntradaItensDao.DelCheckIn(pEntradaId, pPedidoItemId : Integer) : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entradaitens/delcheckin/{pedidoid}/{pedidoitemid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pEntradaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoitemid', pPedidoItemId.ToString());
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

function TEntradaItensDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entradaitens/{entradaitensid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('entradaitensid', Self.EntradaItens.EntradaItemId.ToString());
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

function TEntradaItensDao.GetEntradaItens(pEntradaId :Integer = 0; pProdutoId : Integer =0; pLoteId : Integer = 0; pShowErro : Integer = 1) : TJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entradaitens/{entradaid}/{produtoid}/{loteid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('entradaid', pEntradaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaItensDao.GetEntradaProduto(pEntradaId,
  pShowErro: Integer): TJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entradaitens/produto/{entradaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('entradaid', pEntradaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaItensDao.GetProdutoTagClass(pPedidoId: Integer;
  pDocumentoNr: String; pDtDocumentoData: TDateTime; pRegistroERP: String;
  pDtCheckInFinalizacao: TDateTime; pCodigoERP : Integer; pTagEstoque : Boolean): TJsonArray;
Var vResourceURI : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pTagEstoque then
     vResourceURI := 'v1/entradaitens/produtotagbyproduto?'
  Else vResourceURI := 'v1/entradaitens/produtotag?';
  if ppedidoId <> 0 then
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
  if pDocumentoNr <> '' then
     vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
  if pDtDocumentoData <> 0 then
     vResourceURI := vResourceURI+'&documentodata='+DateToStr(pDtDocumentoData);
  if pRegistroERP <> '' then
     vResourceURI := vResourceURI+'&registroerp='+pRegistroERP;
  if pDtCheckInFinalizacao <> 0 then
     vResourceURI := vResourceURI+'&dtcheckinfinalizacao='+DateToStr(pDtCheckInFinalizacao);
  if pCodigoERP <> 0 then
     vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaItensDao.RegPrintEtqProduto(pPedidoId,
  pLoteId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/regprintetqproduto/{pedidoid}/{loteid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid',   pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

function TEntradaItensDao.Salvar: Boolean;
Var jSonEntradaItens : TJsonObject;
begin
  jSonEntradaItens := tJson.ObjectToJsonObject(Self);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEntradaItens.ToJson, ContentTypeFromString('application/json'));
  if Self.EntradaItens.EntradaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/{entradaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.EntradaItens.EntradaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonEntradaItens);
  Result := ((DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201));
end;

end.
