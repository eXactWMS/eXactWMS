unit SegregadoCausaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
     Generics.Collections, OperacaoTipoClass, Rest.Json, System.Json, Rest.Types;

Type
  TSegregadoCausaCtrl = Class
  Private
    //
  Public
    //constructor Create;
    //destructor Destroy; override;
    Function GetSegregadoCausa(pSegregadoCausaId : Integer = 0; pDescricao : String = ''; pStatus : Integer = 99) : tJsonArray;
    Function Salvar(pJsonArray : TJsonArray) : Boolean;
    Function Delete(pSegregadoCausaId : Integer) : Boolean;
  End;

implementation

uses uDmeXactWMS;

Function TSegregadoCausaCtrl.GetSegregadoCausa(pSegregadoCausaId : Integer; pDescricao : String; pStatus : Integer) : tJsonArray;
Var vResourceURI, pCompl : String;
Begin
  DmeXactWMS.ResetRest;
  pCompl := '?';
  vResourceURI := 'v1/segregadocausa';
  if (pSegregadoCausaId > 0) then Begin
     vResourceURI := vResourceURI + pCompl + 'id='+pSegregadoCausaId.Tostring();
     pCompl := '&';
  End;
  if (pDescricao<>'') then Begin
     vResourceURI := vResourceURI + pCompl + 'descricao='+pDescricao;
     pCompl := '&';
  End;
  if (pStatus<>99) then Begin
     vResourceURI := vResourceURI + pCompl + 'status='+pStatus.ToString;
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

Function TSegregadoCausaCtrl.Salvar(pJsonArray : TJsonArray) : Boolean;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.Resource := 'v1/segregadocausa';
  DmeXactWMS.RestRequestWMS.AddBody(pJsonArray.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
//  FreeAndNil(jSonEndereco);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True //DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Else
     result := False;
End;

Function TSegregadoCausaCtrl.Delete(pSegregadoCausaId : Integer) : Boolean;
Begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/segregadocausa/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pSegregadoCausaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    Result := False;
End;

end.
