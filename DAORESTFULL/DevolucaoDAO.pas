unit DevolucaoDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PedidoSaidaClass, System.JSON, REST.Json, Rest.Types, System.Generics.Collections;

Type

  TDevolucaoDao = class
  private
    FDevolucao : TPedidoSaida;
  public
    constructor Create;
    Function CancelarDevolucao : Boolean;
    Function Delete    : Boolean;
    Function GetDevolucao(pDevolucaoId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = '') : tJsonArray;
    Function Salvar    : Boolean;
    Property Devolucao : TPedidoSaida Read FDevolucao Write FDevolucao;
    function GetPendente: tJsonArray;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

function TDevolucaoDAO.CancelarDevolucao : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/devolucao/cancelar/{devolucaoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('devolucaoid', Self.Devolucao.PedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível cancelar!!!');
end;

constructor TDevolucaoDao.Create;
begin
  Self.FDevolucao := TPedidoSaida.Create;
end;

function TDevolucaoDAO.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/devolucao/{devolucaoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('devolucaoid', Self.Devolucao.PedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TDevolucaoDAO.GetDevolucao(pDevolucaoId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = ''): tJsonArray;
Var vComplemento : String;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/devolucao';
    vComplemento := '?';
    if pDevolucaoId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'devolucaoid='+pDevolucaoId.ToString();
       vComplemento := '&';
    End;
    if pPessoaId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'pessoaid='+pPessoaId.ToString();
       vComplemento := '&';
    End;
    if pDocumentoNr <> ''then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'documentonr='+pPessoaId.ToString();
       vComplemento := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TDevolucaoDAO.GetPendente : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoSaida  : TPedidoSaida;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/pendente';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TDevolucaoDAO.Salvar: Boolean;
Var jSonPedidoSaida : TJsonObject;
begin
  Result := False;
  jSonPedidoSaida := tJson.ObjectToJsonObject(Self.FDevolucao);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPedidoSaida.ToJson, ContentTypeFromString('application/json'));
  if Self.Devolucao.PedidoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/devolucao';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/devolucao/{devolucaoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('devolucaoid', Self.FDevolucao.PedidoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPedidoSaida);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
