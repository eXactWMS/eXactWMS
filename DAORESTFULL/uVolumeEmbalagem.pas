unit uVolumeEmbalagem;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, VolumeEmbalagemClass, System.JSON, REST.Json, Rest.Types;

Type

  TVolumeEmbalagemDao = class
  private
    FVolumeEmbalagem : TVolumeEmbalagem;
  public
    constructor Create;
    Function GetVolumeEmbalagem(pVolumeEmbalagemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Property VolumeEmbalagem : TVolumeEmbalagem Read FVolumeEmbalagem Write FVolumeEmbalagem;
  end;

implementation

{ TLaboratorioDao }

uses UDmuEvolut;

constructor TVolumeEmbalagemDao.Create;
begin
  Self.FVolumeEmbalagem := TVolumeEmbalagem.Create;
end;

function TVolumeEmbalagemDao.Delete : Boolean;
begin
  Result := False;
  DmuEvolut.ResetRest;
  DmuEvolut.RESTRequestWMS.Resource := 'v1/volumeembalagem/{volumeembalagemid}';
  DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', Self.VolumeEmbalagem.VolumeEmbalagemId.ToString());
  DmuEvolut.RESTRequestWMS.Method := RmDelete;
  DmuEvolut.RESTRequestWMS.Execute;
  if (DmuEvolut.RESTResponseWMS.StatusCode = 200) or (DmuEvolut.RESTResponseWMS.StatusCode = 201) or
     (DmuEvolut.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TVolumeEmbalagemDao.GetVolumeEmbalagem(pVolumeEmbalagemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjVolumeEmbalagem  : TVolumeEmbalagem;
begin
  Result := TJsonArray.Create;
  DmuEvolut.ResetRest;
  if (pVolumeEmbalagemId <> 0) or (pDescricao<>'') then  Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/volumeembalagem/{volumeembalagemid}';
     if pVolumeEmbalagemId <> 0 then
        DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', pVolumeEmbalagemId.ToString())
     else DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', pDescricao);
//  End
//  else if pDescricao <> '' then Begin
//       DmuEvolut.RESTRequestWMS.Resource := 'v1/VolumeEmbalagem/{VolumeEmbalagemid}/{descricao}';
//       DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('VolumeEmbalagemid', '0');
//       DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End
  Else if pVolumeEmbalagemId = 0 then
    DmuEvolut.RESTRequestWMS.Resource := 'v1/volumeembalagem';
  DmuEvolut.RESTRequestWMS.Method := RmGet;
  DmuEvolut.RESTRequestWMS.Execute;
  if (DmuEvolut.RESTResponseWMS.StatusCode = 200) or (DmuEvolut.RESTResponseWMS.StatusCode = 201) Then
     Result := DmuEvolut.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmuEvolut.RESTResponseWMS.StatusText);
end;

function TVolumeEmbalagemDao.Salvar: Boolean;
Var jSonVolumeEmbalagem : TJsonObject;
begin
  Result := False;
  jSonVolumeEmbalagem := tJson.ObjectToJsonObject(Self.FVolumeEmbalagem);
  DmuEvolut.ResetRest;
  DmuEvolut.RestRequestWMS.ClearBody;
  DmuEvolut.RestRequestWMS.AddBody(jSonVolumeEmbalagem.ToJson, ContentTypeFromString('application/json'));
  if Self.VolumeEmbalagem.VolumeEmbalagemId = 0 then Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/volumeembalagem';
     DmuEvolut.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/volumeembalagem/{volumeembalagemid}';
     DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', Self.FVolumeEmbalagem.VolumeEmbalagemId.ToString());
     DmuEvolut.RESTRequestWMS.Method := rmPut;
  End;
  DmuEvolut.RESTRequestWMS.Execute;
  FreeAndNil(jSonVolumeEmbalagem);
  if (DmuEvolut.RESTResponseWMS.StatusCode = 200) or (DmuEvolut.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Ocorreu um erro: '+DmuEvolut.RESTResponseWMS.StatusText);
end;

end.
