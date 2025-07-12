unit uEntradaDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EntradaClass, System.JSON, REST.Json, Rest.Types;

Type

  TEntradaDao = class
  private
    FEntrada : TEntrada;
  public
    constructor Create;
    Destructor Destroy; OverRide;
    Function GetHeader(pEntradaId, pAgrupamentoId: Integer): TJsonArray;
    Function GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId, pCodProduto : Integer) : TJsonArray;
    Function GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId, pCodProduto : Integer) : TJsonArray;
    Function CancelarEntrada(pJsonPedidoCancelar : TJsonObject) : Boolean;
    Function Delete(pJsonPedidoCancelar : TJsonObject) : Boolean;
    Function SalvarCheckInItem(pAgrupamentoId : Integer; pJsonEntrada : TJsonObject) : TJsonObject;
    Function FinalizarCheckIn(pjsonEntrada : TJsonObject) : Boolean;
    Function FinalizarAgrupamentonotas(pJsonEntrada: TJsonObject) : TJsonArray;
    Function Pesquisar(pEntradaId : Integer = 0; pCodPessoaERP : Integer = 0; pDocumentoNr : String = '';
                        pRazao : String = ''; pRegistroERP : STring = ''; pDtNotaFiscal : TDateTime = 0;
                        pPendente : Integer = 0; pAgrupamentoId : Integer = 0;
                        pBasico : Boolean = False; pCodProduto : String = '0'; pDescrProduto : String = '') : tJsonArray;
    Function Salvar : Boolean;
    Property Entrada : TEntrada Read FEntrada Write FEntrada;
    Function MontarPaginacao : TJsonObject;
    Function RegistrarDocumentoEtapa(pDocumentoEtapaId : Integer) : TJsonArray;
    Function GetPlanilhaCega(pEntradaId : Integer) : TJsonArray;
    Function GetEspelho(pPedidoId: Integer; pDocumentoNr, pRegistroERP: String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckinDtFin: TDateTime; pDivergencia : Integer): TJsonArray;
    Function GetEntradaOcorrencia(pPedidoId: Integer; pDocumentoNr, pRegistroERP: String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckinDtFin: TDateTime): TJsonArray;
    Function GetResumoCheckIn(pEntradaId: Integer): TJsonArray;
    Function GetMovimentacao(pPedidoId: Integer; pDataInicial, pDataFinal: TDateTime; pProdutoId: Integer): TJsonArray;
    Function GetRelRecebimento(pPedidoId: Integer; pCodigoERP : Integer; pPessoaId : Integer; pDataIni, pDataFin, pDataFinalizacaoInicio, pDataFinalizacaoTermino : TDateTime;
                           pDocumentoNr, pRazao, pRegistroERP : String; pProcessoId : Integer; pCodProduto : Int64; pPedidoPendente : Integer) : tJsonArray;
    Function GetEtiquetaArmazenagem(pDtInicio, pDtTermino : TDateTime;
             pPedidoId : Integer; pDocumentoNr : String; pZonaId, pCodProduto, pSintetico : Integer) : TjsonArray;
    Function GetRelDshRecebimentos(pRecebimentoInicial, pRecebimentoFinal, pProducaoInicial, pProducaoFinal : TDateTime) : TJsonArray;
    Function GetEntradaProduto(pPedidoId, pAgrupamentoId : Integer) : TJsonArray;

    Function GetEntradaLotes(pPedidoId, pAgrupamentoId, pCodProduto, pLoteId : Integer) : TJsonArray;
    Function GetEntradaItens(pPedidoId, pAgrupamentoId : Integer) : TJsonArray;
    Function ExcluirPreEntrada(pJsonArray : TJsonArray) : TjsonArray;
    Function GetValidaQtdCheckIn(pPedidoid, pCodProduto: Integer): TjsonArray;
    Function GetProdutoSemPicking(pDataInicial, pDataFinal: TDateTime;
             pPedidoId, pCodPessoaERP: Integer; pDocumentoNr: String): TJsonArray;
    Function SalvarAgrupamento(pAgrupamentojsonArray: TJsonArray): TjsonArray;
    Function GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP : Integer): TJsonArray;
    Function GetAgrupamentoPedido(pAgrupamentoId, pPedidoId : Integer): TJsonArray;
    Function GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer): TjsonArray;
    Function GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer): TjsonArray;
    Function GetAgrupamentoFatorarProduto(pAgrupamentoId: Integer): TjsonArray;
    Function GetAgrupamentoCheckIn(pAgrupamentoId : Integer) : TJsonArray;
    Function DelCancelarCheckInAgrupamento(pAgrupamentoId : Integer) : TJsonArray;

    Function DeleteAgrupamento(pAgrupamentoId, pPedidoId: Integer): TJsonArray;
    Function GetAcompanhamentoCheckIn(pPedidoId, pCodPessoaERP: Integer; pDataInicial, pDataFinal: TDateTime): TJsonArray;
    Function GetDshCheckIn(pDataInicial, pDataFinal, pDtProducaoInicial, pDtProducaoFinal : TDateTime): TJsonArray;
    Function AgrupamentoCheckInReiniciar(pAgrupamentoId: Integer): TjsonArray;
    Function ValidarCheckInAgrupamentoFinalizar(pAgrupamentoId : Integer) : TJsonArray;

  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes;

function TEntradaDao.AgrupamentoCheckInReiniciar(pAgrupamentoId: Integer): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentocheckinreiniciar/{agrupamentoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := rmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaDao.CancelarEntrada(pJsonPedidoCancelar : TJsonObject) : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/cancelar';
  DmeXactWMS.RestRequestWMS.AddBody(pJsonPedidoCancelar.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method  := rmPatch;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível cancelar a entrada!!!');
end;

constructor TEntradaDao.Create;
begin
  Self.FEntrada := TEntrada.Create;
end;

function TEntradaDao.DelCancelarCheckInAgrupamento(
  pAgrupamentoId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentocheckinreiniciar/{agrupamentoid}'; //delcancelarcheckinagrupamento
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := rmDELETE;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaDao.Delete(pJsonPedidoCancelar : TJsonObject): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada';
  DmeXactWMS.RestRequestWMS.AddBody(pJsonPedidoCancelar.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TEntradaDao.DeleteAgrupamento(pAgrupamentoId,
  pPedidoId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamento/{agrupamentoid}/{pedidoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

destructor TEntradaDao.Destroy;
begin
  Self.FEntrada.Free;
  inherited;
end;

function TEntradaDao.ExcluirPreEntrada(pJsonArray: TJsonArray): TjsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonArray.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/excluirpreentrada';
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

function TEntradaDao.FinalizarAgrupamentonotas(
  pJsonEntrada: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonEntrada.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/finalizaragrupamentonotas';
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TEntradaDao.FinalizarCheckIn(pjsonEntrada: TJsonObject): Boolean;
Var msg : String;
begin
  Try
    Result := False;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonEntrada.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/finalizarcheckin';
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Msg :=    DmeXactWMS.RESTResponseWMS.Content;//   StatusText;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TEntradaDao.GetAcompanhamentoCheckIn(pPedidoId, pCodPessoaERP: Integer;
  pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var vLim : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vLim := '?';
    Result := TJsonArray.Create;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/acompanhamentocheckin';
    if pPedidoId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'pedidoid='+pPedidoId.ToString;
       vLim := '&';
    end;
    if pCodPessoaERP <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'codpessoaerp='+pCodPessoaERP.ToString;
       vLim := '&';
    end;
    if pDataInicial <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'datainicial='+DateToStr(pDataInicial);
       vLim := '&';
    end;
    if pDataFinal <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'datafinal='+DateToStr(pDataFinal);
       vLim := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TEntradaDao.GetAgrupamentoCheckIn(pAgrupamentoId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/getagrupamentocheckin/{agrupamentoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaDao.GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentofatorarlote/{agrupamentoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaDao.GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentofatorarpedidolotes/{agrupamentoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

//Get Produtos com saldo(QtdXml) incompleto
function TEntradaDao.GetAgrupamentoFatorarProduto(pAgrupamentoId: Integer): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentofatorarproduto/{agrupamentoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Raise Exception.Create( E.Message);
    End;
  End;
end;

function TEntradaDao.GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP : Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentolista?agrupamentoid='+
                                        pAgrupamentoId.ToString()+'&codpessoaerp='+pCodPessoaERP.ToString();
  DmeXactWMS.RESTRequestWMS.Method  := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [ 200, 201]) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetAgrupamentoPedido(pAgrupamentoId,
  pPedidoId : Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/agrupamentopedido?agrupamentoid='+
                                        pAgrupamentoId.ToString()+'&pedidoid='+pPedidoId.ToString();
  DmeXactWMS.RESTRequestWMS.Method  := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [ 200, 201]) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    //raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetDshCheckIn(pDataInicial, pDataFinal, pDtProducaoInicial, pDtProducaoFinal : TDateTime): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  Try
    vCompl := '?';
    vResourceURI := 'v1/entrada/dshcheckin';
    if pDataInicial <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    end;
    if pDataFinal <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    end;
    if pDtProducaoInicial <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'producaoinicial='+DateToStr(pDtProducaoInicial);
       vCompl := '&';
    end;
    if pDtproducaoFinal <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'producaofinal='+DateToStr(pDtproducaoFinal);
       vCompl := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
  End;
  End;
end;

function TEntradaDao.GetEntradaItens(pPedidoId, pAgrupamentoId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/itens?pedidoid='+pPedidoId.ToString()+'&agrupamentoid='+pAgrupamentoId.ToString();
  DmeXactWMS.RESTRequestWMS.Method  := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): TJsonArray;
Var vLim : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vLim := '?';
    Result := TJsonArray.Create;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/itens/lotecheckin';
    if pPedidoId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'pedidoid='+pPedidoId.ToString;
       vLim := '&';
    end;
    if pAgrupamentoId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'agrupamentoid='+pAgrupamentoId.ToString;
       vLim := '&';
    end;
    if pCodProduto <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'codproduto='+pCodProduto.ToString;
       vLim := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TEntradaDao.GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): TJsonArray;
Var vLim : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vLim := '?';
    Result := TJsonArray.Create;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/lotedevolucao';
    if pPedidoId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'pedidoid='+pPedidoId.ToString;
       vLim := '&';
    end;
    if pAgrupamentoId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'agrupamentoid='+pAgrupamentoId.ToString;
       vLim := '&';
    end;
    if pCodProduto <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'codproduto='+pCodProduto.ToString;
       vLim := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TEntradaDao.GetEntradaLotes(pPedidoId, pAgrupamentoId, pCodProduto,
  pLoteId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/lotes?pedidoid='+pPedidoId.ToString()+'&agrupamentoid='+pAgrupamentoId.ToString();
  if pCodProduto <> 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&codproduto='+pCodProduto.ToString();
  if pLoteId <> 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&loteid='+pLoteId.ToString();
  DmeXactWMS.RESTRequestWMS.Method  := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetEntradaOcorrencia(pPedidoId: Integer; pDocumentoNr,
  pRegistroERP: String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni,
  pCheckinDtFin: TDateTime): TJsonArray;
Var vResourceURI : String;
    vComplemento : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vComplemento := '?';
    vResourceURI := 'v1/entrada/ocorrencia';
    if pPedidoId <> 0 then Begin
       vResourceURI := vResourceURI+vComplemento+'pedidoid='+pPedidoId.ToString();
       vComplemento := '&';
    End;
    if pDocumentoNr <> '' then Begin
       vResourceURI := vResourceURI+vComplemento+'documentonr='+pDocumentoNr;
       vComplemento := '&';
    End;
    if pRegistroERP <> '' then Begin
       vResourceURI := vResourceURI+vComplemento+'registroerp='+pRegistroERP;
       vComplemento := '&';
    End;
    if pDoctoDataIni <> 0 then Begin
       vResourceURI := vResourceURI+vComplemento+'doctoodataini='+DateToStr(pDoctoDataIni);
       vComplemento := '&';
    End;
    if pDoctoDataFin <> 0 then Begin
       vResourceURI := vResourceURI+vComplemento+'doctoodatafin='+DateToStr(pDoctoDataFin);
       vComplemento := '&';
    End;
    if pCheckInDtIni <> 0 then Begin
       vResourceURI := vResourceURI+vComplemento+'checkindtini='+DateToStr(pCheckInDtIni);
       vComplemento := '&';
    End;
    if pCheckInDtFin <> 0 then Begin
       vResourceURI := vResourceURI+vComplemento+'checkindtfin='+DateToStr(pCheckInDtFin);
       vComplemento := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaDao.GetEntradaProduto(pPedidoId, pAgrupamentoId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/produto?pedidoid='+pPedidoId.ToString()+'&agrupamentoid='+pAgrupamentoId.ToString();
  DmeXactWMS.RESTRequestWMS.Method  := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetEspelho(pPedidoId: Integer; pDocumentoNr,
  pRegistroERP: String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni,
  pCheckinDtFin: TDateTime; pDivergencia : Integer): TJsonArray;
Var vResourceURI : String;
    vComplemento : String;
begin
  vResourceURI := 'v1/entrada/espelho?divergencia='+pDivergencia.Tostring;
  if pPedidoId <> 0 then Begin
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
     vComplemento := '&';
  End;
  if pDocumentoNr <> '' then
     vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
  if pRegistroERP <> '' then
     vResourceURI := vResourceURI+'&registroerp='+pRegistroERP;
  if pDoctoDataIni <> 0 then
     vResourceURI := vResourceURI+'&doctoodataini='+pRegistroERP;
  if pDoctoDataFin <> 0 then
     vResourceURI := vResourceURI+'&doctoodatafin='+pRegistroERP;
  if pCheckInDtIni <> 0 then
     vResourceURI := vResourceURI+'&checkindtini='+pRegistroERP;
  if pCheckInDtFin <> 0 then
     vResourceURI := vResourceURI+'&checkindtfin='+pRegistroERP;
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetEtiquetaArmazenagem(pDtInicio, pDtTermino: TDateTime;
  pPedidoId: Integer; pDocumentoNr: String; pZonaId, pCodProduto,
  pSintetico: Integer): TjsonArray;
Var vResourceURI, vCompl : String;
begin
  vCompl := '?';
  vResourceURI := 'v1/entrada/etiquetaarmazenagem';
  if pDtInicio <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'dtinicio='+DateToStr(pDtInicio);//FormatDateTime('YYYY-MM-DD', pDtInicio);
     vCompl := '&';
  end;
  if pDtTermino <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'dttermino='+DateToStr(pDtTermino);//FormatDateTime('YYYY-MM-DD', pDtTermino);
     vCompl := '&';
  end;
  if pPedidoId <> 0 then  Begin
     vResourceURI := vResourceURI+vCompl+'pedidoid='+pPedidoId.ToString();
     vCompl := '&';
  end;
  if pDocumentoNr <> '' then Begin
     vResourceURI := vResourceURI+vCompl+'documentonr='+pDocumentoNr;
     vCompl := '&';
  end;
  if pZonaId <> 0 then Begin
     vResourceURI := vResourceURI+vCompl+'zonaid='+pZonaId.ToString();
     vCompl := '&';
  end;
  if pCodProduto <> 0 then Begin
     vResourceURI := vResourceURI+vCompl+'codproduto='+pCodProduto.ToString();
     vCompl := '&';
  end;
  if pSintetico <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'sintetico=1';
     vCompl := '&';
  end;
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetHeader(pEntradaId, pAgrupamentoId: Integer): TJsonArray;
Var vLim : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vLim := '?';
    Result := TJsonArray.Create;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/header';
    if pEntradaId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'pedidoid='+pEntradaId.ToString;
       vLim := '&';
    end;
    if pAgrupamentoId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'agrupamentoid='+pAgrupamentoId.ToString;
       vLim := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TEntradaDao.GetMovimentacao(pPedidoId: Integer; pDataInicial,
  pDataFinal: TDateTime; pProdutoId: Integer): TJsonArray;
Var vLim : String;
begin
  vLim := '?';
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/movimentacao';
  if pPedidoId <> 0 then begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'pedidoid='+pPedidoId.ToString;
     vLim := '&';
  end;
  if pDataInicial<> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'datainicial='+DateToStr(pDataInicial);
     vLim := '&';
  End;
  if pDataFinal <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'datafinal='+DateToStr(pDataFinal);
     vLim := '&';
  End;
  if pProdutoId <> 0 then begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'produtoid='+pProdutoId.ToString;
     vLim := '&';
  end;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
end;

function TEntradaDao.GetPlanilhaCega(pEntradaId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/planilhacega/{pedidoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pEntradaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.GetProdutoSemPicking(pDataInicial, pDataFinal: TDateTime;
  pPedidoId, pCodPessoaERP: Integer; pDocumentoNr: String): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  vCompl := '?';
  vResourceURI := 'v1/entrada/produtosempicking';
  if pDataInicial <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datainicial='+DateToStr(pDataInicial);
     vCompl := '&';
  end;
  if pDataFinal <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datafinal='+DateToStr(pDataFinal);
     vCompl := '&';
  end;
  if pPedidoId <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'pedidoid='+pPedidoId.ToString();
     vCompl := '&';
  end;
  if pCodPessoaERP <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'codpessoaerp='+pCodPessoaERP.ToString();
     vCompl := '&';
  end;
  if pDocumentoNr <> '' then begin
     vResourceURI := vResourceURI+vCompl+'documentonr='+pDocumentoNr;
     vCompl := '&';
  end;
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

function TEntradaDao.GetRelDshRecebimentos(pRecebimentoInicial, pRecebimentoFinal, pProducaoInicial, pProducaoFinal : TDateTime): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  Try
    vCompl := '?';
    vResourceURI := 'v1/entrada/dshrecebimento';
    if pRecebimentoInicial <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datainicial='+DateToStr(pRecebimentoInicial);//FormatDateTime('YYYY-MM-DD', pDtInicio);
       vCompl := '&';
    end;
    if pRecebimentoFinal <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datafinal='+DateToStr(pRecebimentoFinal);//FormatDateTime('YYYY-MM-DD', pDtTermino);
       vCompl := '&';
    end;
    if pProducaoInicial <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'producaoinicial='+DateToStr(pProducaoInicial);//FormatDateTime('YYYY-MM-DD', pDtInicio);
       vCompl := '&';
    end;
    if pProducaoFinal <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'producaofinal='+DateToStr(pProducaoFinal);//FormatDateTime('YYYY-MM-DD', pDtTermino);
       vCompl := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  End;
end;

function TEntradaDao.GetRelRecebimento(pPedidoId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin, pDataFinalizacaoInicio, pDataFinalizacaoTermino : TDateTime; pDocumentoNr, pRazao,
  pRegistroERP: String; pProcessoId: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer): tJsonArray;
Var vResourceURI    : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/entrada/relrecebimento?';
    vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
    if pCodigoERP <> 0 then
       vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
    if pPessoaId <> 0 then
       vResourceURI := vResourceURI+'&pessoaid='+pPessoaId.ToString();
    if pDataIni <> 0 then
       vResourceURI := vResourceURI+'&dataini='+DateToStr(pDataIni);
    if pDataFin <> 0 then
       vResourceURI := vResourceURI+'&datafin='+DateToStr(pDataFin);
    if pDataFinalizacaoInicio <> 0 then
       vResourceURI := vResourceURI+'&datafinalizacaoinicio='+DateToStr(pDataFinalizacaoInicio);
    if pDataFinalizacaoTermino <> 0 then
       vResourceURI := vResourceURI+'&datafinalizacaotermino='+DateToStr(pDataFinalizacaoTermino);
    if pDocumentoNR <> '' then
       vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
    if pRazao <> '' then
       vResourceURI := vResourceURI+'&razao='+pRazao;
    if pRegistroERP <> '' then
       vResourceURI := vResourceURI+'&registroerp='+pRegistroERP;
    if pProcessoId <> 0 then
       vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString;
    if pCodProduto <> 0 then
       vResourceURI := vResourceURI+'&codproduto='+pCodProduto.ToString;
    if pPedidoPendente <> 0 then
       vResourceURI := vResourceURI+'&pedidopendente='+pPedidoPendente.ToString;
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaDao.GetResumoCheckIn(pEntradaId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/resumocheckin/{entradaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('entradaid', pEntradaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TEntradaDao.GetValidaQtdCheckIn(pPedidoid,
  pCodProduto: Integer): TjsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/validarqtdcheckin/{pedidoid}/{codproduto}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoid.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codproduto', pCodProduto.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  End
  Else Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
  End;
end;

function TEntradaDao.MontarPaginacao: TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/montarpaginacao';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonObject;
  End
  Else
    raise Exception.Create('não foi possível definir paginação.');
end;

function TEntradaDao.Pesquisar(pEntradaId : Integer = 0; pCodPessoaERP : Integer = 0; pDocumentoNr : String = '';
                                pRazao : String = ''; pRegistroERP : STring = ''; pDtNotaFiscal : TDateTime = 0;
                                pPendente : Integer = 0; pAgrupamentoId : Integer = 0;
                                pBasico : Boolean = False; pCodProduto : String = '0'; pDescrProduto : String = ''): tJsonArray;
Var vResourceURI    : String;
    Teste : Integer;
begin
  Result := TJsonArray.Create;
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/entrada/pesquisar?';
    vResourceURI := vResourceURI+'&PedidoId='+pEntradaId.ToString();
    if pCodPessoaERP <> 0 then
       vResourceURI := vResourceURI+'&codpessoaerp='+pCodPessoaERP.ToString();
    if pDocumentoNR <> '' then
       vResourceURI := vResourceURI+'&DocumentoNr='+pDocumentoNr;
    if pRazao <> '' then
       vResourceURI := vResourceURI+'&Razao='+pRazao;
    if pRegistroERP <> '' then
       vResourceURI := vResourceURI+'&RegistroERP='+pRegistroERP;
    if pDtNotaFiscal <> 0 then
       vResourceURI := vResourceURI+'&dtnotafiscal='+DateToStr(pDtNotaFiscal);
    if pDescrProduto <> '' then
       vResourceURI := vResourceURI+'&descrproduto='+pDescrProduto;
    //if pPendente <> 0 then
       vResourceURI := vResourceURI+'&pendente='+pPendente.ToString();
    vResourceURI := vResourceURI+'&codproduto='+pCodProduto;
    if pBasico then
       vResourceURI := vResourceURI+'&basico=1';
    if pAgrupamentoId <> 0 then
       vResourceURI := vResourceURI+'&agrupamentoid='+pAgrupamentoId.ToString();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method  := RmGet;
    DmeXactWMS.RESTRequestWMS.Timeout := DmeXactWMS.RESTRequestWMS.Timeout*10;
    DmeXactWMS.RESTRequestWMS.Execute;  //Processo lento
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except ON E: Exception do
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
  End;
//    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.RegistrarDocumentoEtapa(
  pDocumentoEtapaId: Integer): TJsonArray;
Var JsonDocumento : TJsonObject;
begin
  JsonDocumento := tJsonObject.Create;
  JsonDocumento.AddPair('pedidoid', Entrada.EntradaId.ToString());
  JsonDocumento.AddPair('processoid', pDocumentoEtapaId.Tostring());
  JsonDocumento.AddPair('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
  JsonDocumento.AddPair('estacao', NomeDoComputador);
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonDocumento.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/registrardocumentoetapa';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else Begin
    JsonDocumento := Nil;
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  End;
  JsonDocumento := Nil;
end;

function TEntradaDao.Salvar: Boolean;
Var jSonEntrada : TJsonObject;
begin
  Result := False;
  jSonEntrada := tJson.ObjectToJsonObject(Self.FEntrada);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEntrada.ToJson, ContentTypeFromString('application/json'));
  if Self.Entrada.EntradaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.FEntrada.EntradaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonEntrada);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEntradaDao.SalvarAgrupamento(
  pAgrupamentojsonArray : TJsonArray): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pAgrupamentojsonArray.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/salvaragrupamento';
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
      raise Exception.Create(DmeXactWMS.RESTResponseWMS.StatusText);
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  End;

end;

//Retornar um Json com Atualização do Item
function TEntradaDao.SalvarCheckInItem(pAgrupamentoId : Integer; pJsonEntrada: TJsonObject): TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonEntrada.ToJson, ContentTypeFromString('application/json'));
    if PAgrupamentoId = 0 then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/SalvarCheckInItem'
    Else
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/SalvarCheckInItemAgrupamento';
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Except ON E: Exception do
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  End;
end;

function TEntradaDao.ValidarCheckInAgrupamentoFinalizar(
  pAgrupamentoId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/entrada/validarcheckinagrupamentofinalizar/{agrupamentoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('agrupamentoid', pAgrupamentoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := rmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

end.
