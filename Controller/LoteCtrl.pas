{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit LoteCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
      LotesClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TLoteCtrl = Class
  Private
    //Funções de Validação
    FObjLote : TLote;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindLote(pProdutoId : Integer = 0; pLoteId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray; //TObjectList<TLote>;
    Function GetProdutoLote(pProdutoId : Integer = 0; pLote : String = '*'; pShowErro : Integer = 1) : TObjectList<TLote>;
    Function GetProdutoLoteJson(pProdutoId : Integer = 0; pLote : String = '*'; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function SalvarLote(pJsonlote : TJsonObject) : TJSONObject;  //(pHistorico: THistorico)
    Function GetLoteResumo(pProdutoId: Integer; pLote : String; pAgrupado : Integer): TJsonArray;
    Function Correcaolote(pJsonObjectLoteAltecao : TJsonObject) : TJsonArray;
    Class Function DelLote(pIdLote : Integer) : Boolean;
    Property ObjLote  : TLote Read FObjLote Write FObjLote;
  End;

implementation

{ tCtrlLote }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tLoteCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjLote do Begin
    if DescrLote = '' then raise Exception.Create('Informe a descrição do Lote!');
    if (Fabricacao= 0) or (Fabricacao = StrToDate('  /  /    ')) then
       raise Exception.Create('Informe a Data de Fabricação do Lote!');
    if (Vencimento = 0) or (Vencimento = StrToDate('  /  /    ')) then
       raise Exception.Create('Informe a Data de Vencimento do Lote!');
  End;
  Result := True;
End;

function TLoteCtrl.Correcaolote(
  pJsonObjectLoteAltecao: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote/correcaolote';
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObjectLoteAltecao.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

constructor TLoteCtrl.Create;
begin
  FObjLote := TLote.Create;
end;

class function TLoteCtrl.DelLote(pIdLote : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdLote.ToString());
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

destructor TLoteCtrl.Destroy;
begin
  FreeAndNil(FObjLote);
  inherited;
end;

Function tLoteCtrl.FindLote(pProdutoId : Integer; pLoteId : Integer; pDescricao: String; pShowErro : Integer): tJsonArray;// TObjectList<TLote>;
Var //LstLote : TObjectList<TLote>;
    //JsonRetorno : TJSONArray;
    jSonObj     : tJsonObject;
    xItens      : Integer;
Begin
  //LstLote := TObjectList<TLote>.Create;
  //Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote/{produtoid}/{loteid}/{descricao}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat

          jSonObj := tJsonObject.Create;
          jSonObj := Result.Items[xItens] as TJSONObject;

          FObjLote := Self.FObjLote.JsonToClass(JsonObj.ToString());

          jSonObj := Nil;
          jSonObj.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

     End
     Else If pShowErro = 1 then
       Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);

  //LstLote.Add(GetLoteBD(Completa));
  //Result := LstLote;
End;

function TLoteCtrl.GetProdutoLote(pProdutoId: Integer; pLote : String; pShowErro : Integer): TObjectList<TLote>;
Var ReturnJson : TJsonArray;
    JsonLote   : TJsonObject;
    xItensLote : Integer;
begin
  Result := TObjectList<TLote>.Create;
  ReturnJson := FindLote(pProdutoId, 0, pLote, 0);
  if ReturnJson.Count >= 1 then Begin
     xItensLote := 0;
     repeat
       JsonLote := tJsonObject.Create;
       JsonLote := ReturnJson.Items[xItensLote] as TJSONObject;
       ObjLote  := ObjLote.JsonToClass(JsonLote.ToString());
       ObjLote.Fabricacao := StrToDate(JsonLote.GetValue<String>('fabricacao'));
       ObjLote.Vencimento := StrToDate(JsonLote.GetValue<String>('vencimento'));
       Result.Add(ObjLote);
       JsonLote := Nil;
       JsonLote.DisposeOf;
       Inc(xItensLote);
     until (xItensLote > Pred(ReturnJson.Count));
  End
  Else If pShowErro = 1 then
     Raise Exception.Create('Não existe lote(s) deste produto!');
end;

function TLoteCtrl.GetProdutoLoteJson(pProdutoId: Integer; pLote: String;
  pShowErro: Integer): TJsonArray;
Var ReturnJson : TJsonArray;
    JsonLote   : TJsonObject;
    xItensLote : Integer;
begin
  ReturnJson := FindLote(pProdutoId, 0, pLote, 0);
  if ReturnJson.Count < 1 then Begin
     ReturnJson.AddElement(TJsonObject.Create.AddPair('Erro', 'Lote não encontrado.'));
  End;
  Result := ReturnJson;
end;

function TLoteCtrl.GetLoteResumo(pProdutoId: Integer; pLote: String; pAgrupado : Integer): TJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote/resumo/{produtoid}/{descricao}/{agrupado}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pLote);
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupado', pAgrupado.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

Function tLoteCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonLote : TJsonObject;
Begin
  Result := True;
  //jSonLote := tJson.ObjectToJsonObject(ObjLote);
  JsonLote := TJsonObject.Create;
  JsonLote.AddPair('produtoid',  TJsonNumber.Create(ObjLote.ProdutoId));
  JsonLote.AddPair('codigoerp',  TJsonNumber.Create(ObjLote.CodigoERP));
  JsonLote.AddPair('loteid'   ,  TJsonNumber.Create(ObjLote.LoteId));
  JsonLote.AddPair('descrlote',  ObjLote.DescrLote);
  JsonLote.AddPair('fabricacao', DateToStr(ObjLote.Fabricacao));
  JsonLote.AddPair('vencimento', DateToStr(ObjLote.Vencimento));
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonLote.ToJson, ContentTypeFromString('application/json'));
  if ObjLote.LoteId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', ObjLote.LoteId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonLote);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TLoteCtrl.SalvarLote(pJsonlote : TJsonObject) : TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonLote.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/lote/salvar';
  DmeXactWMS.RESTRequestWMS.Method   := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  pJSonLote.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

End.

