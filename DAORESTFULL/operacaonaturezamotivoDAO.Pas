{
   operacaonaturezamotivoDAO.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 28/03/2022
   Projeto: eXactWMS
}

unit operacaonaturezamotivoDAO;

interface

uses
  System.SysUtils, operacaonaturezamotivoClass, System.JSON, REST.Json, Rest.Types, System.Generics.Collections;

Type

  ToperacaonaturezamotivoDao = class
  private
    Foperacaonaturezamotivo : Toperacaonaturezamotivo;
  public
    constructor Create;
    Function Cancelaroperacaonaturezamotivo : Boolean;
    Function Delete    : Boolean;
    Function Getoperacaonaturezamotivo(pmotivoid : Integer = 0) : TJsonArray;
    Function Salvar    : Boolean;
    Property Objoperacaonaturezamotivo : Toperacaonaturezamotivo Read Foperacaonaturezamotivo Write Foperacaonaturezamotivo;
  end;

implementation

{ ToperacaonaturezamotivoDao }

uses UDmeXactWMS;

Function ToperacaonaturezamotivoDAO.Cancelaroperacaonaturezamotivo : Boolean;
Begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonaturezamotivo/cancelar/{motivoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('motivoid', Self.Objoperacaonaturezamotivo.motivoid.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível cancelar!!!');
End;

constructor ToperacaonaturezamotivoDao.Create;
begin
  Self.Foperacaonaturezamotivo := Toperacaonaturezamotivo.Create;
end;

Function ToperacaonaturezamotivoDAO.Delete: Boolean;
Begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonaturezamotivo/{motivoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('motivoid', Self.Objoperacaonaturezamotivo.motivoid.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
End;

Function ToperacaonaturezamotivoDAO.Getoperacaonaturezamotivo(pmotivoid : Integer = 0) : TJsonArray;
Var vComplemento : String;
Begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonaturezamotivo';
  vComplemento := '?';
  If pmotivoid <> 0 Then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'motivoid='+pmotivoid.ToString();
     vComplemento := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function ToperacaonaturezamotivoDAO.Salvar: Boolean;
Var jSonoperacaonaturezamotivo : TJsonObject;
begin
  Result := False;
  jSonoperacaonaturezamotivo := tJson.ObjectToJsonObject(Self.Foperacaonaturezamotivo);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonoperacaonaturezamotivo.ToJson, ContentTypeFromString('application/json'));
  if Self.Objoperacaonaturezamotivo.motivoid = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonaturezamotivo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonaturezamotivo/{motivoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('motivoid', Self.Objoperacaonaturezamotivo.motivoid.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonoperacaonaturezamotivo);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.

