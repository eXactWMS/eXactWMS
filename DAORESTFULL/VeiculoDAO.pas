unit VeiculoDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, VeiculoClass, System.JSON, REST.Json, Rest.Types;

Type

  TVeiculoDao = class
  private
    //FObjVeiculo : TVeiculo;
  public
    constructor Create;
    destructor Destroy; override;
    Function GetVeiculo(pVeiculoId : Integer; pPlaca : String; pTransportadoraId : Integer) : tJsonArray;
    Function Salvar(Const ObjVeiculo : TVeiculo) : Boolean;
    Function Delete(pVeiculoId : Integer) : Boolean;
    //Property ObjVeiculo : TVeiculo Read FObjVeiculo Write FObjVeiculo;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TVeiculoDao.Create;
begin
  //Self.FObjVeiculo := TVeiculo.Create;
end;

function TVeiculoDao.Delete(pVeiculoId : Integer) : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/veiculo/{veiculoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('veiculoid', pVeiculoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TVeiculoDao.Destroy;
begin
//  FObjVeiculo := Nil;
  inherited;
end;

function TVeiculoDao.GetVeiculo(pVeiculoId : Integer; pPlaca : String; pTransportadoraId : Integer) : tJsonArray;
Var vCompl : String;
begin
  vCompl := '?';
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/veiculo';
  if (pVeiculoId <> 0) then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'veiculoid='+pVeiculoId.ToString();
     vCompl := '&';
  End;
  if (pPlaca <> '') then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'placa='+pPlaca;
     vCompl := '&';
  End;
  if (pTransportadoraId <> 0) then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'transportadoraid='+pTransportadoraId.ToString();
     vCompl := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TVeiculoDao.Salvar(Const ObjVeiculo : TVeiculo) : Boolean;
Var jSonVeiculo : TJsonObject;
begin
  Result := False;
  //jSonVeiculo := tJson.ObjectToJsonObject(Self.FObjVeiculo);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(tJson.ObjectToJsonObject(ObjVeiculo).ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/veiculo';
  if ObjVeiculo.VeiculoId = 0 then
     DmeXactWMS.RESTRequestWMS.Method := rmPOST
  Else
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
