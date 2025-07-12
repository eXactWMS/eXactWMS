unit uVolumeEmbalagemDAO;

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
    Function GetVolumeEmbalagemMultipla(pVolumeEmbalagemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Property VolumeEmbalagem : TVolumeEmbalagem Read FVolumeEmbalagem Write FVolumeEmbalagem;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TVolumeEmbalagemDao.Create;
begin
  Self.FVolumeEmbalagem := TVolumeEmbalagem.Create;
end;

function TVolumeEmbalagemDao.Delete : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeembalagem/{volumeembalagemid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', Self.VolumeEmbalagem.EmbalagemId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
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
  DmeXactWMS.ResetRest;
  if (pVolumeEmbalagemId <> 0) or (pDescricao<>'') then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeembalagem/{volumeembalagemid}';
     if pVolumeEmbalagemId <> 0 then
        DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', pVolumeEmbalagemId.ToString())
     else DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', pDescricao);
//  End
//  else if pDescricao <> '' then Begin
//       DmeXactWMS.RESTRequestWMS.Resource := 'v1/VolumeEmbalagem/{VolumeEmbalagemid}/{descricao}';
//       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('VolumeEmbalagemid', '0');
//       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End
  Else if pVolumeEmbalagemId = 0 then
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeembalagem';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TVolumeEmbalagemDao.GetVolumeEmbalagemMultipla(pVolumeEmbalagemId: Integer; pDescricao: String;
  pShowErro: Integer): tJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeembalagemmultipla/{volumeembalagemid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', Self.FVolumeEmbalagem.EmbalagemId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmGET;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TVolumeEmbalagemDao.Salvar: Boolean;
Var jSonVolumeEmbalagem : TJsonObject;
begin
  Result := False;
  jSonVolumeEmbalagem := tJson.ObjectToJsonObject(Self.FVolumeEmbalagem);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonVolumeEmbalagem.ToJson, ContentTypeFromString('application/json'));
  if Self.VolumeEmbalagem.EmbalagemId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeembalagem';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeembalagem/{volumeembalagemid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('volumeembalagemid', Self.FVolumeEmbalagem.EmbalagemId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonVolumeEmbalagem);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
