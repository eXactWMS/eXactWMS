unit PerfilDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PerfilClass, System.JSON, REST.Json, Rest.Types;

Type

  TPerfilDao = class
  private
    FPerfil : TPerfil;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetPerfil(pPerfil : string = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : tjsonObject;
    Function ControleAcessoTopicos : TJsonObject;
    Function ControleAcessoFuncionalidades(pListaTopicos : String) : TJsonObject;
    Function SalvarAcesso(pJsonObject : TJsonObject) : Boolean;
    Function AtualizarPermissao(pPerfilId : Integer) : TJsonArray;
    Property ObjPerfil : TPerfil Read FPerfil Write FPerfil;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

function TPerfilDao.AtualizarPermissao(pPerfilId : Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/atualizar/{perfilid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfilid', pPerfilId.Tostring());
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPerfilDao.ControleAcessoFuncionalidades(pListaTopicos : String): TJsonObject;
begin
  Result := TJsonObject.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/controleacessofuncionalidades/{perfilid}/{listatopicos}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfilid', Self.ObjPerfil.PerfilId.Tostring());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('listatopicos', pListaTopicos);
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TjsonObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPerfilDao.ControleAcessoTopicos: TJsonObject;
begin
  Result := TJsonObject.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/controleacessotopicos/{perfilid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfilid', Self.ObjPerfil.PerfilId.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TjsonObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Constructor TPerfilDao.Create;
begin
  Self.FPerfil := TPerfil.Create;
end;

function TPerfilDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/{perfilid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfilid', Self.ObjPerfil.PerfilId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o Perfil de usuário(s)!');
end;

function TPerfilDao.GetPerfil(pPerfil : String = ''; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPerfil  : TPerfil;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil';
  if pPerfil = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/{perfil}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfil', pPerfil);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TPerfilDao.Salvar: tjsonObject;
Var jSonPerfil : TJsonObject;
begin
  Try
    jSonPerfil := tJson.ObjectToJsonObject(Self.FPerfil);
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(jSonPerfil.ToJson, ContentTypeFromString('application/json'));
    if Self.ObjPerfil.PerfilId = 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil';
       DmeXactWMS.RESTRequestWMS.Method := rmPOST;
    End
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/{perfilid}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfilid', Self.FPerfil.PerfilId.ToString());
       DmeXactWMS.RESTRequestWMS.Method := rmPut;
    End;
    DmeXactWMS.RESTRequestWMS.Execute;
    FreeAndNil(jSonPerfil);
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TPerfilDao.SalvarAcesso(pJsonObject: TJsonObject): Boolean;
begin
  Result := False;
//  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/perfil/salvaracesso/{perfilid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('perfilid', ObjPerfil.PerfilId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
