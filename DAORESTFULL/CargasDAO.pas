unit CargasDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, CargasClass, System.JSON, REST.Json, DataSet.Serialize, Rest.Types;

Type

  TCargasDao = class
  private
    FObjCargas : TCargas;
  public
    constructor Create;
    destructor Destroy; override;
    Function GetCargas(pCargaId : Integer; pDataInicial, pDataFinal : TDateTime;
                       pRota, pRotaIdFinal, pTransportadora, pMotorista : String; pVeiculoId : Integer; pPlaca, pProcesso : String) : tJsonArray;
    Function GetPedidosParaCargas(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : tJsonArray;
    Function GetPedidosParaCargasNFs(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : tJsonArray;
    Function GetCargaCarregarClientes(Const pCargaId, pShowErro  : Integer) : TJsonArray;
    Function GetCargaCarregarPedidos(Const pCargaId, pShowErro  : Integer) : TJsonArray;
    Function GetCargaCarregarVolumes(const pCargaId : Integer; pProcesso : String; pShowErro: Integer) : TJsonArray;
    Function CancelarCarregamento : TJsonObject;
    Function CancelarConferencia  : TJsonObject;
    Function CancelarCarga(const pJsonObject: TJsonObject): TJsonObject;
    Function Salvar(pJsonCarga : TJsonObject) : TJsonObject;
    Function Delete : TJsonObject;
    Function RegistrarCarregamento(pJsonCarregamento : TJsonObject) : TJsonObject;
    Function FinalizarCarregamento(pJsonFinalizar : TJsonObject) : TJsonObject;
    Function GetCargaHeader(pCargaId : Integer) : TJsonArray;
    Function GetCargaPessoas(pCargaId : Integer; pProcesso : String) : TJsonArray;
    Function GetCargaPedidos(pCargaId : Integer = 0; pPessoaId : Integer = 0; pProcesso : String = 'ALL') : TJsonArray;
    Function GetCargaNF(pCargaId : Integer = 0) : TJsonArray;
    Function GetCargaPedidosRomaneio(pCargaId : Integer = 0; pPessoaId : Integer = 0; pProcesso : String = 'ALL') : TJsonArray;
    Function GetCargaPedidoVolumes(pCargaId : Integer = 0; pProcesso : String = 'ALL') : TJsonArray;
    Function GetCargaPedidoVolumesConferencia(pCargaId : Integer = 0; pProcesso : String = 'ALL') : TJsonArray;
    function GetCargaPessoasPedidos(pCargaId: Integer): TJsonArray;
    Function Lista(pCargaId, pRotaId, pProcessoId, pPendente : Integer; pProcesso : String) : TJsonArray;
    Function ResumoCarga(pDataInicial, pDataFinal: TDateTime; pRotaIdInicial, pRotaIdFinal, pProcessoId, pPendente: integer): TJsonArray;
    Function GetRelAnaliseConsolidada(pPedidoId: Integer; pDataInicial,
             pDataFinal: TDateTime; pDocumentoNr : String; pRotaInicialId, pRotaFinalId, pZonaId, pDestinatarioId,
             pSomenteExpedido, pOrdem: Integer): TjsonArray;
    Function AtualizarStatus(pJsonObject : TJsonObject) : TJsonArray;
    Function GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem : Integer) : TJsonArray;
    Property ObjCargas : TCargas Read FObjCargas Write FObjCargas;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes;

function TCargasDao.AtualizarStatus(pJsonObject: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/atualizarstatus';
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement( TJsonObject.Create.AddPair('Erro', E.Message) );
    End;
  End;
end;

function TCargasDao.CancelarCarga(const pJsonObject: TJsonObject): TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/cancelar';
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
  Except On E: Exception do Begin
    Result := TJsonObject.Create.AddPair('Erro', E.Message);
    End;
  End;
end;

function TCargasDao.CancelarCarregamento: TJsonObject;
begin
  Result := TJsonObject.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/cancelarcarregamento/{cargaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', Self.ObjCargas.CargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
//  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
//     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
//  End
//  Else
//    raise Exception.Create('não foi possível Cancelar o Carregamento');
end;

function TCargasDao.CancelarConferencia: TJsonObject;
begin
  Result := TJsonObject.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/cancelarconferencia/{cargaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', Self.ObjCargas.CargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
  End
  Else
    raise Exception.Create('não foi possível Cancelar a Conferência da Carga.');
end;

constructor TCargasDao.Create;
begin
  Self.FObjCargas := TCargas.Create;
end;

function TCargasDao.Delete : TJsonObject;
Var pJsonDelete : TjsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/{cargaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', Self.ObjCargas.CargaId.ToString());
    pJsonDelete:= TJsonObject.Create();
    pJsonDelete.AddPair('cargaid', TJsonNumber.Create(Self.ObjCargas.CargaId));
    pJsonDelete.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    pJsonDelete.AddPair('terminal', NomeDoComputador);
    DmeXactWMS.RestRequestWMS.AddBody(pJsonDelete.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    pJsonDelete.Free;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
  Except On E: Exception do Begin
    Result := TJsonObject.Create.AddPair('Erro', E.Message)
    End;
  End;
end;

destructor TCargasDao.Destroy;
begin
  FObjCargas := Nil;
  inherited;
end;

function TCargasDao.FinalizarCarregamento(
  pJsonFinalizar: TJsonObject): TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonFinalizar.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/carregamentofinalizar';
  DmeXactWMS.RESTRequestWMS.Method := rmPUT;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
end;

function TCargasDao.GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem: Integer): TJsonArray;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/carga/analisecubagemporproduto/{cargaid}/{embalagem}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('embalagem', pEmbalagem.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TCargasDao.GetCargaCarregarClientes(const pCargaId,
  pShowErro: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/clientes/{cargaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaCarregarPedidos(const pCargaId, pShowErro: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/pedidos/{cargaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaCarregarVolumes(const pCargaId : Integer; pProcesso : String; pShowErro: Integer) : TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
//  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/volumes/{cargaid}/{processo}';
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/conferirvolumes/{cargaid}/{processo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid',  pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo',  pProcesso);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaHeader(pCargaId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/hearder/{cargaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaNF(pCargaId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/notafiscal/{cargaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCargasDao.GetCargaPedidos(pCargaId, pPessoaId : Integer; pProcesso : String): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/pedidos/{cargaid}/{pessoaid}/{processo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaPedidosRomaneio(pCargaId, pPessoaId: Integer;
  pProcesso: String): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/pedidos/romaneio/{cargaid}/{pessoaid}/{processo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaPedidoVolumes(pCargaId: Integer; pProcesso : String): TJsonArray;
Begin
  //Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/conferirvolumes/{cargaid}/{processo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaPedidoVolumesConferencia(pCargaId: Integer; pProcesso : String): TJsonArray;
Begin
  //Result := TJsonArray.Create;
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*3;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/volumes/conferencia/{cargaid}/{processo}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso);
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TCargasDao.GetCargaPessoasPedidos(pCargaId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/mapacarga/{cargaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetCargaPessoas(pCargaId: Integer; pProcesso : String): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/pessoas/{cargaid}/{processo}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso); //Substituir pelo parametro
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Raise Exception.Create(E.Message);
    End;
  End;
end;

function TCargasDao.GetCargas(pCargaId : Integer; pDataInicial, pDataFinal : TDateTime;
                       pRota, pRotaIdFinal, pTransportadora, pMotorista : String; pVeiculoId : Integer; pPlaca, pProcesso : String): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCargas  : TCargas;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas?id='+pCargaId.ToString();
  if pDataInicial <> 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&datainicial='+DateToStr(pDataInicial);
  if pDataFinal <> 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&datafinal='+DateToStr(pDataFinal);
  if StrToIntDef(pRota, 0) > 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&rotaid='+pRota;
  if StrToIntDef(pRotaIdFinal, 0) > 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&rotaidfinal='+pRotaIdFinal;
  if StrToIntDef(pProcesso, 0) > 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&processoid='+pProcesso;
//  if pDataInicial <> 0 then
//     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&datainicial='+DateToStr(pDataInicial);
//  if pDataFinal <> 0 then
//     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&datafinal='+DateToStr(pDataFinal);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.GetPedidosParaCargas(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCargas   : TCargas;
    vCompl      : String;
begin
  Try
    vCompl := '?';
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/pedidosparacarga';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pCodPessoaERP <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'codpessoaerp='+pCodPessoaERP.ToString();
       vCompl := '&';
    End;
    if pRota <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'rotaid='+pRota.ToString();
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'zonaid='+pZonaId.ToString();
       vCompl := '&';
    End;
    if pProcesso > 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'processoid='+pProcesso.ToString();
       vCompl := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*4;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except on E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TCargasDao.GetPedidosParaCargasNFs(pDataInicial, pDataFinal: TDateTime;
  pCodPessoaERP, pRota, pZonaId, pProcesso: integer): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCargas   : TCargas;
    vCompl      : String;
begin
  vCompl := '?';
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/pedidosparacarganfs';
  if pDataInicial <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
     vCompl := '&';
  End;
  if pDataFinal <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
     vCompl := '&';
  End;
  if pCodPessoaERP <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'codpessoaerp='+pCodPessoaERP.ToString();
     vCompl := '&';
  End;
  if pRota <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'rotaid='+pRota.ToString();
     vCompl := '&';
  End;
  if pZonaId <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'zonaid='+pZonaId.ToString();
     vCompl := '&';
  End;
  if pProcesso > 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'processoid='+pProcesso.ToString();
     vCompl := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Timeout := 30000*4;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

function TCargasDao.GetRelAnaliseConsolidada(pPedidoId: Integer; pDataInicial,
  pDataFinal: TDateTime; pDocumentoNr: String; pRotaInicialId, pRotaFinalId,
  pZonaId, pDestinatarioId, pSomenteExpedido, pOrdem: Integer): TjsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCargas   : TCargas;
    vCompl      : String;
begin
  vCompl := '?';
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.TimeOut := DmeXactWMS.RESTRequestWMS.TimeOut*8;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/analiseconsolidada';
//    if pPedidoId <> 0 then Begin
//       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'pedidoid='+pPedidoId.ToString();
//       vCompl := '&';
//    End;
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
//    if pDocumentoNr <> '' then Begin
//       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'documentonr='+pDocumentoNr;
//       vCompl := '&';
//    End;
    if pRotaInicialId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'rotainicialid='+pRotaInicialId.ToString();
       vCompl := '&';
    End;
    if pRotaFinalId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'rotafinalid='+pRotaFinalId.ToString();
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'zonaid='+pZonaId.ToString();
       vCompl := '&';
    End;
    if pDestinatarioId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'codpessoa='+pDestinatarioId.ToString();
       vCompl := '&';
    End;
    if pSomenteExpedido > 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'somenteexpedido='+pSomenteExpedido.ToString();
       vCompl := '&';
    End;
//    if pProcessoId > 0 then Begin
//       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'processoid='+pProcessoId.ToString();
//       vCompl := '&';
//    End;
    if pOrdem <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'ordem='+pOrdem.ToString();
       vCompl := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCargasDao.Lista(pCargaId, pRotaId, pProcessoId, pPendente: Integer; pProcesso : String): TJsonArray;
Var vCompl : String;
begin
  Try
    vCompl := '?';
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/lista/{cargaid}/{rotaid}/{processoid}/{pendente}/{processo}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', pRotaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processoid', pProcessoId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pendente', pPendente.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('processo', pProcesso);
    DmeXactWMS.RESTRequestWMS.Method := rmGET;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCargasDao.RegistrarCarregamento(
  pJsonCarregamento: TJsonObject): TJsonObject;
begin
//  Result := TJsonObject.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonCarregamento.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/carregamento';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create(DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCargasDao.ResumoCarga(pDataInicial, pDataFinal: TDateTime;
  pRotaIdInicial, pRotaIdFinal, pProcessoId, pPendente: integer): TJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCargas   : TCargas;
    vCompl      : String;
begin
  vCompl := '?';
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.TimeOut := DmeXactWMS.RESTRequestWMS.TimeOut*8;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/resumo';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pRotaIdInicial <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'rotainicial='+pRotaIdInicial.ToString();
       vCompl := '&';
    End;
    if pRotaIdFinal <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'rotafinal='+pRotaIdFinal.ToString();
       vCompl := '&';
    End;
    if pProcessoId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'processoid='+pProcessoId.ToString();
       vCompl := '&';
    End;
    if pPendente <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vCompl+'pendente='+pPendente.ToString();
       vCompl := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCargasDao.Salvar(pJsonCarga : TJsonObject): TJsonObject;
//Var jSonCargas : TJsonObject;
begin
  //jSonCargas := tJson.ObjectToJsonObject(Self.ObjCargas);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonCarga.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjCargas.CargaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/cargas/{cargaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', Self.ObjCargas.CargaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  //FreeAndNil(pJsonCarga);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
