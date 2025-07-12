unit uLaboratorioDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, LaboratoriosClass, System.JSON, REST.Json, System.Generics.Collections, Rest.Types;

Type

  TLaboratorioDao = class
  private
    FLaboratorio : TLaboratorio;
    FMontarPaginacao: TJsonObject;
  public
    constructor Create;
//    Destructor Destroy; OverRide;
//    function InsertUpdate(pId: Integer; pNome, pFone, pEmail, pHomePage : String; pStatus : Integer): TjSonArray;
//    function GetId(pId: Integer): TjSonArray;
//    function GetDescricao(pNome : String) : tJsonArray;
    Function Delete : Boolean;
    Function GetLaboratorio(pIdLaboratorio : Integer = 0; pNome : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : Boolean;
    Function ImportDados(pJsonArray : TJsonArray) : Boolean;
    Property Laboratorio : TLaboratorio Read FLaboratorio Write FLaboratorio;
    Function MontarPaginacao : TJsonObject;
End;

implementation

Uses uDmeXactWMS;

{ TLaboratorioDao }

constructor TLaboratorioDao.Create;
begin
  Self.Laboratorio := TLaboratorio.Create;
  DmeXactWMS.ResetRest;
end;

function TLaboratorioDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.Laboratorio.IdLaboratorio.ToString());
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

function TLaboratorioDao.GetLaboratorio(pIdLaboratorio: Integer; pNome: String;
  pShowErro: Integer): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pIdLaboratorio <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdLaboratorio.ToString());
  End
  else
    if pNome = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio/{id}/{descricao}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdLaboratorio.ToString());
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pnome);
    End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TLaboratorioDao.ImportDados(pJsonArray: TJsonArray): Boolean;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.AddBody( pJsonArray.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/fabricante/import';
  DmeXactWMS.RESTRequestWMS.Method := RmPost;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(pJsonArray);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else Begin
    Result := False;
    //raise Exception.Create('Erro: '+pJsonArray.Items[0].GetValue<Integer>('idlaboratorio').ToString()+' '+pJsonArray.Items[0].GetValue<String>('nome'));
  End;

end;

Function TLaboratorioDao.MontarPaginacao : TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio/montarpaginacao';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonObject;
  End
  Else
    raise Exception.Create('não foi possível definir paginação.');
end;

function TLaboratorioDao.Salvar : Boolean;
Var jSonLaboratorio : TJsonObject;
begin
  jSonLaboratorio := tJson.ObjectToJsonObject(Laboratorio);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonLaboratorio.ToJson, ContentTypeFromString('application/json'));
  if Self.Laboratorio.IdLaboratorio = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/laboratorio/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.Laboratorio.IdLaboratorio.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := ((DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201));
end;

end.
