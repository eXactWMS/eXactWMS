unit InventarioDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, InventarioClass, System.JSON, REST.Json, Rest.Types;

Type

  TInventarioDao = class
  private
    FInventario : TInventario;
  public
    constructor Create;
    Function Delete : Boolean;
    Function Cancelar : Boolean;
    Function GetInventario(pInventarioId : Integer; pDataCriacao, pDataFinalizacao,
             pDataCancelamento : TDateTime; pProcessoId : Integer; pTipo : Integer;
             pPendente : Integer; pProdutoId : Integer; pDataCriacaoFinal : TDateTime) : tJsonArray;
    Function GetPendente : TJsonArray;
    Function GetContagem(pItem : Integer) : TJsonArray;
    Function GetInventarioItens(pInventarioId : Integer) : TJsonArray;
    Function GetLoteInventariado(pInventarioId, pEnderecoId, pProdutoId, pTipo, pShowErro : Integer) : TJsonArray;
    Function Salvar(pListaEndereco : TJsonArray) : TJsonObject;
    Function ZerarEndereco(pInventarioId, pEnderecoId, pProdutoId  : Integer) : TJsonObject;
    Function SaveContagem(pJsonArrayContagem : TJsonArray) : TJsonObject;
    Function InventarioFechar :  Boolean;
    Function LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer): TJsonArray;
    Function GetDshInventarios(pDataInicial, pDataFinal: TDateTime; pInventarioIdInicial, pInventarioIdFinal: Integer): TJsonObject;
    Function SalvarModeloInventario(pJsonObject: TJsonObject): TJsonArray;
    Function GetModeloLista(pModeloId: Integer): TJsonArray;
    Function CongelarEstoqueInicial(pInventarioId, pInventarioTipo : Integer): TJsonArray;
    Function GerarNovoInventarioModelo(pModeloId: integer): TJsonArray;
    Function GetAjusteRelatorio(pInventarioId: Integer; pDataCriacaoInicial, pDataCriacaoFinal,
                                pDataFinalizacaoInicial, pDataFinalizacaoFinal: TDateTime;
                                pProcessoid, PInventarioTipo, pPendente, pProdutoId : Integer): TJsonArray;
    Property ObjInventario : TInventario Read FInventario Write FInventario;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFuncoes, uFrmeXactWMS;

Function TInventarioDao.Cancelar: Boolean;
Var vResourceURI, vComplemento : String;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/inventario/cancelar';
  vResourceURI := vResourceURI+vcomplemento+'?inventarioid='+ObjInventario.InventarioId.Tostring;
  vResourceURI := vResourceURI+vcomplemento+'&terminal='+NomedoComputador;
  vResourceURI := vResourceURI+vcomplemento+'&usuarioid='+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString();
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TInventarioDao.CongelarEstoqueInicial(pInventarioId, pInventarioTipo : Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/congelarestoqueinicial/{inventarioid}/{inventariotipo}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventariotipo', pInventarioTipo.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmPost;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

constructor TInventarioDao.Create;
begin
  Self.FInventario := TInventario.Create;
end;

function TInventarioDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/{inventarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', Self.ObjInventario.InventarioId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro do Inventário!');
end;

function TInventarioDao.GerarNovoInventarioModelo(
  pModeloId: integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/gerarnovoinventariomodelo/{modeloid}/{usuarioid}/{terminal}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('modeloid',  pModeloId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('terminal',  NomeDoComputador);
    DmeXactWMS.RESTRequestWMS.Method := rmPost;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;
function TInventarioDao.GetAjusteRelatorio(pInventarioId: Integer;
  pDataCriacaoInicial, pDataCriacaoFinal, pDataFinalizacaoInicial, pDataFinalizacaoFinal: TDateTime;
  pProcessoid, PInventarioTipo, pPendente, pProdutoId : Integer): TJsonArray;
Var Compl : String;
begin
  Try
    Compl := '?';
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/relatorio/ajuste';
    if pInventarioId > 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'inventarioid='+pInventarioId.Tostring;
       Compl := '&';
    End;
    if pDataCriacaoInicial <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'datacriacaoinicial='+DateToStr(pDataCriacaoInicial);
       Compl := '&';
    End;
    if pDataCriacaoFinal <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'datacriacaofinal='+DateToStr(pDataCriacaoFinal);
       Compl := '&';
    End;
    if pDataFinalizacaoInicial <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'datafinalizacaoinicial='+DateToStr(pDataFinalizacaoInicial);
       Compl := '&';
    End;
    if pDataFinalizacaoFinal <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'datafinalizacaofinal='+DateToStr(pDataFinalizacaoFinal);
       Compl := '&';
    End;
    if pProcessoId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'processoid='+pProcessoId.ToString();
       Compl := '&';
    End;
    if pInventarioTipo <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'inventariotipo='+pInventarioTipo.ToString();
       Compl := '&';
    End;
    if pPendente <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'pendente='+pPendente.ToString();
       Compl := '&';
    End;
    if pProdutoId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + Compl + 'produtoid='+pProdutoId.ToString();
       Compl := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TInventarioDao.GetContagem(pItem : Integer) : TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/contagem/{item}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('item', pItem.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TInventarioDao.GetDshInventarios(pDataInicial, pDataFinal: TDateTime;
  pInventarioIdInicial, pInventarioIdFinal: Integer): TJsonObject;
Var vResourceURI, vComplemento : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/inventario/dshcontageminventario';
    vComplemento := '?';
    if pDataInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'datainicial='+DateToStr(pDataInicial);
       vComplemento := '&';
    End;
    if pDataFinal <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'datafinal='+DateToStr(pDataFinal);
       vComplemento := '&';
    End;
    if pInventarioIdInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'inventarioidinicial='+pInventarioIdInicial.ToString;
       vComplemento := '&';
    End;
    if pInventarioIdFinal <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'inventarioidfinal='+pInventarioIdFinal.ToString;
       vComplemento := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

function TInventarioDao.GetInventario(pInventarioId : Integer; pDataCriacao, pDataFinalizacao,
         pDataCancelamento : TDateTime; pProcessoId : Integer; pTipo : Integer;
         pPendente : Integer; pProdutoId : Integer; pDataCriacaoFinal : TDateTime) : tJsonArray;
Var jSonObj       : tJsonObject;
    xItens        : Integer;
    ObjInventario : TInventario;
    vResourceURI, vComplemento : String;
begin
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/inventario';
  vComplemento := '?';
  if pinventarioid <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'inventarioid='+pInventarioId.Tostring;
     vComplemento := '&';
  End;
  if pDataCriacao <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datacriacao='+FormatDateTime('YYYY-MM-DD', pDataCriacao);
     vComplemento := '&';
  End;
  if pDataCriacaoFinal <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datacriacaofinal='+FormatDateTime('YYYY-MM-DD', pDataCriacaoFinal);
     vComplemento := '&';
  End;
  if pDataFinalizacao <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datafinalizacao='+FormatDateTime('YYYY-MM-DD', pDataCriacao);
     vComplemento := '&';
  End;
  if pDataCancelamento <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datacancelamento='+FormatDateTime('YYYY-MM-DD', pDataCancelamento);
     vComplemento := '&';
  End;
  if pProcessoId <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'processoid='+pProcessoId.ToString();
     vComplemento := '&';
  End;
  if pTipo <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'tipo='+ptipo.ToString();
     vComplemento := '&';
  End;
  if pProdutoId <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'produtoid='+pProdutoId.ToString();
     vComplemento := '&';
  End;
  vResourceURI := vResourceURI+vcomplemento+'pendente='+pPendente.ToString();
  vComplemento := '&';
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

function TInventarioDao.GetInventarioItens(pInventarioId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/itens/{inventarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TInventarioDao.GetLoteInventariado(pInventarioId, pEnderecoId,
  pProdutoId, pTipo , pShowErro: Integer): TJsonArray;
Var jSonObj       : tJsonObject;
    xItens        : Integer;
    ObjInventario : TInventario;
    vResourceURI, vComplemento : String;
Begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/inventario/loteinventariado?tipo='+pTipo.ToString;
    vComplemento := '&';
    if pinventarioid <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'inventarioid='+pInventarioId.Tostring;
       vComplemento := '&';
    End;
    If pEnderecoId <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'enderecoid='+pEnderecoId.ToString();
       vComplemento := '&';
    End;
    if pProdutoId <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'produtoid='+pProdutoId.Tostring();
       vComplemento := '&';
    End;
    vResourceURI := vResourceURI+vcomplemento+'tipo='+pTipo.Tostring();
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TInventarioDao.GetModeloLista(pModeloId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/modelo/lista/{modeloid}'; //'v1/inventario/fechar';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('modeloid', pModeloId.Tostring());
    DmeXactWMS.RESTRequestWMS.Method := RmGET;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray).Items[0].GetValue<String>('Erro'));
  End;
end;

Function TInventarioDao.GetPendente: TJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/pendente';
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
      raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
End;

Function TInventarioDao.InventarioFechar: Boolean;
Var vResourceURI, vComplemento : String;
Begin
  Result := False;
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/inventario/apuracao/endereco'; //'v1/inventario/fechar';
    vResourceURI := vResourceURI+vcomplemento+'?inventarioid='+ObjInventario.InventarioId.Tostring;
    vResourceURI := vResourceURI+vcomplemento+'&terminal='+NomedoComputador;
    vResourceURI := vResourceURI+vcomplemento+'&usuarioid='+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString();
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmPost;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := True;
  Except ON E: Exception do Begin
    Result := False;
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray).Items[0].GetValue<String>('Erro'));
    End;
  End;
End;

function TInventarioDao.LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/limparcontagem/{inventarioid}/{enderecoid}/{produtoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.Tostring());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.Tostring());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TInventarioDao.Salvar(pListaEndereco : TJsonArray) : tjsonObject;
Var jSonInventario : TJsonObject;
Begin
  jSonInventario := tJson.ObjectToJsonObject(Self.FInventario);
  JsonInventario.AddPair('endereco', pListaEndereco);
  JsonInventario.AddPair('usuarioid', TJsonNumber.Create(FrmExactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonInventario.AddPair('terminal', NomeDoComputador());
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonInventario.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjInventario.InventarioId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/{inventarioid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', Self.FInventario.InventarioId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  jSonInventario.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject)
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TInventarioDao.SalvarModeloInventario(
  pJsonObject: TJsonObject): TJsonArray;
begin
  try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/salvarmodeloinventario';
    DmeXactWMS.RESTRequestWMS.Method := rmPOST;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray   
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  end;
end;

Function TInventarioDao.SaveContagem(
  pJsonArrayContagem: TJsonArray): TJsonObject;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonArrayContagem.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/savecontagem';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject)
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

Function TInventarioDao.ZerarEndereco(pInventarioId,
  pEnderecoId, pProdutoId : Integer): TJsonObject;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/zerarendereco/{inventarioid}/{enderecoid}/{produtoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid',  pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject)
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

end.
