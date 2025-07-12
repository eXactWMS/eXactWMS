unit uPedidoSaidaDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PedidoSaidaClass, System.JSON, REST.Json, Rest.Types, System.Generics.Collections;

Type

  TPedidoSaidaDao = class
  private
    //FPedidoSaida : TPedidoSaida;
  public
    constructor Create;
    Function CancelarPedidoSaida(pJsonPedidoCancelar : TJsonObject) : Boolean;
    Function Delete(pJsonArrayPedido : TJsonArray) : TJsonArray;
    Function SalvarCheckInItem(pjsonPedidoSaida : TJsonObject) : TJsonObject;
    Function GetPedidoSaida(pPedidoId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function PedidoCubagem(pPedidoId : Integer = 0) : tJsonArray;
    Function Pedido_CancelarCubagem(pPedidoId : Integer) : tjsonArray;
    Function PedidoCubagemVolume_CaixaFracionada(pPedidoId: Integer) : tjsonArray;
    Function PedidoParaProcessamento(pPedidoId, pCodigoERP : Integer;
             pDataIni, pDataFin: TDateTime; pProcessoId, pRotaId, pRotaIdFinal, pZonaId, pRecebido, pCubagem, pEtiqueta: Integer): TJsonArray;
    Function PedidoProcessar(pPedidoId: Int64; pCodigoERP : Int64; pPessoaId : Int64; pDataIni, pDataFin : TDateTime;
                           pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pRotaIdFinal, pZonaId : Int64; pProcessoId : Integer; pRecebido, pCubagem,
                           pEtiqueta : Integer; pProcessar : Boolean; pMontarCarga : Integer; pCodProduto : Int64;
                           pPedidoPendente : Integer; pCargaId : Int64; pNotaFiscalERP : String; pPrintTag, pEmbalagem : Integer) : tJsonArray;
    Function PedidoParaCargas(pPedidoId, pCodigoERP, pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pDocumentoNr, pRazao,
                              pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId, pMontarCarga, pCargaId: Integer): TJsonArray;
    Function PedidoPrintTag(pPedidoId, pPedidoVolumeId : Integer; pCodigoERP : Integer; pPessoaId : Integer; pDataIni, pDataFin : TDateTime;
                           pRazao : String; pRotaId, pRotaIdFinal, pZonaId, pPrintTag, pEmbalagem : Integer) : tJsonArray;
    Function PedidoProdutoSemPicking(pPedidoId: Integer; pCodigoERP : Integer; pPessoaId : Integer; pDataIni, pDataFin : TDateTime;
                           pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pProcessoId : Integer; pRecebido, pCubagem, pEtiqueta : Integer; pProcessar, pVerificarEstoque : Boolean) : tJsonArray;
    Function PedidoResumoAtendimento(pPedidoId : Integer = 0; pDivergencia : Integer = 0; pDataInicial : TDate = 0; pDataFinal : TDate = 0) : TjsonArray;
    Function GetClientesRotaCarga(pPessoaId : Integer; pRazao : String; pDataIni, pDataFin : TDateTime; pRotaId, pProcessoId : Integer) : TJsonArray;
    Function GetCortes(pDataIni, pDataFin : TDateTime; pPedidoId, pProdutoId : Integer; pSintetico, pZonaId, pCodPessoaERP, pRotaId : Integer; pDocumentoNr : String) : TJsonArray;
    Function Salvar(pPedidoId : Integer) : Boolean;
    //Property PedidoSaida : TPedidoSaida Read FPedidoSaida Write FPedidoSaida;
    function GetPedidoPendente: tJsonArray;

    Function GerarVolume(pjsonVolume : TJsonArray; pTipoVolume : String): tJsonArray;

    Function MontarPaginacao : TJsonObject;

    Function GetProdutoResposicao(pData : TDateTime) : tJsonArray;

    Function GetRelRupturaAbastecimento(pDataIni, pDataFin : TDateTime) : TJsonArray;

    Function GetRelColetaPulmao(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId, pZonaId : Integer) : TJsonArray;

    Function GetRelApanhePicking(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId : Integer) : TJsonArray;

    Function GetRelAnaliseRessuprimento(aParams: TDictionary<String, String>; pVolume : Boolean): TJsonArray;

    Function GetReposicaoGerar(pData : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String) : TJsonArray;
    Function GetReposicaoDemanda(pDataPedido : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal, pTipoGeracao : String) : TJsonArray;
    Function GetReposicaoDemandaCapacidade(pPercDownMaxPicking, pZonaId : Integer; pEnderecoInicial, pEnderecoFinal: String; pNegativo: Integer): TJsonArray;
    Function GetReposicaoDemandaColeta(pTipoGeracao : String) : TJsonArray;

    Function GetReposicaoEnderecoColeta(pData : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String) : TJsonArray;

    Function SalvarReposicao(pJsonReposicao: TJsonObject): Boolean;

    function SalvarReposicaoModelo(pJsonReposicao: TJsonObject): Boolean;
    Function GetReposicaoModelo(pModeloId : Integer) : TJsonArray;
    Function DeleteReposicaoModelo(pModeloId: Integer): TJsonArray;

    Function GetDashBoard0102(pDtInicio, pDtTermino: TDate): TJsonObject;

    Function GetDashBoard030405(pDtInicio, pDtTermino: TDate): TJsonArray;

    Function GetDashBoard06(pDtInicio, pDtTermino: TDate): TJsonArray;
    Function GetResumoProducao(pDtInicio, pDtTermino: TDate; pProcessoId, pUsuarioId: Integer; pDtPedidoIni, pDtPedidoFin : TDate) : TJsonArray;
    Function GetMovimentacao(pPedidoId : Integer; pDataInicio, pDataFinal : TDateTime; pProdutoId : Integer) : TJsonArray;
    Function GetEvolucaoAtendimentoPed(aParams: TDictionary<String, String>)  : TJsonArray;
    Function GetEvolucaoAtendimentoUnid(aParams: TDictionary<String, String>) : TJsonArray;
    Function GetEvolucaoAtendimentoUnidZona(aParams: TDictionary<String, String>) : TJsonArray;
    Function GetEvolucaoAtendimentoUnidEmbalagem(aParams: TDictionary<String, String>; pTipo : String) : TJsonArray;
    Function GetEvolucaoAtendimentoVol(aParams: TDictionary<String, String>)  : TJsonArray;
    Function DeleteReservaCorrecao : TJsonArray;
    Function GetPedidoProcesso(pPedidoId : Integer) : TJsonArray; //Buscar Processos/histórico do(s) pedido(s)
    Function GetReposicaoAutomatica(pDataReposicao : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String; pStatus : Integer) : TJsonArray;
    Function GetReposicaoAutomaticaColeta(pDataReposicao : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String; pStatus : Integer) : TJsonArray;
    Function GetConsultaReposicao(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId, pPendente, pUsuarioId : Integer) : TJsonArray;
    Function GetReposicaoProduto(pReposicaoId : Integer) : TJsonArray;
    Function ReposicaoSalvarItemColetado(pJsonColeta : TJsonArray) : Boolean;
    Function ReposicaoTransferenciaPicking(PJsonTransferencia : TJsonObject) : TJsonArray;
    Function ReposicaoFinalizar(pJsonColeta : TJsonArray): Boolean;
    Function GetAuditoriaSaidaPorProduto(pDataInicial, pDataFinal: TDateTime; pPedidoId: Integer; pRessuprimento: String; pCodProduto: Integer;
                                         pDescrLote: String) : TJsonArray;
    Function GetSaidaPorProdutoBalanceamento(pDataInicio, pDataTermino: TDateTime; pZonaId : Integer) : TJsonArray;
    Function GetReposicaoHistorico( pJsonArray : TjsonArray ) : TJsonArray;
    Function GetAnaliseColeta(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                              pPendente, pUsuarioId: Integer; pModeloReport: String; pDivergencia, pNaoColetado : Integer; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
    Function RelReposicaoTransfPicking(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                                       pPendente, pUsuarioId: Integer; pModeloReport: String; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
    Function GetRelHistoricoTransferenciaPicking(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                              pPendente, pUsuarioId: Integer; pModeloReport: String; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
    Function GetReposicaoColetaProdutividade(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                              pPendente, pUsuarioId: Integer; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
    Function ReposicaoCancelar(pJsonObjectReposicao : TJsonObject) : TJsonArray;
    Function ReposicaoRegistrarInUse(pReposicaoId, pUsuarioId: Integer): TJsonArray;
    Function ReposicaoExcluir(pJsonObjectExcluir : TJsonObject) : TJsonArray;
    Function GetMotivoExclusaoPedido : TjsonArray;
    Function PutRegistrarProcesso(pPedidoId, pProcessoId: Integer): TJsonArray;
    Function GetDashProducaoDiaria(pDataInicial, pDataFinal: TDateTime): TJsonArray;
    Function GetDashProducaoDiariaZona(pDataInicial, pDataFinal: TDateTime): TJsonArray;
    Function AtualizarProcesso(pPedidoId : Integer) : TJsonArray;

  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes;

function TPedidoSaidaDao.GetAnaliseColeta(pDataInicial, pDataFinal: TDateTime;
         pReposicaoId, pProcessoId, pPendente, pUsuarioId: Integer; pModeloReport: String; pDivergencia, pNaoColetado : Integer; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
Var ObjPedidoSaida  : TPedidoSaida;
    vCompl : String;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/reposicao/analisecoleta';
    vCompl := '?';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pReposicaoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'reposicaoid='+pReposicaoId.ToString;
       vCompl := '&';
    End;
    if pProcessoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'processoid='+pProcessoId.ToString;
       vCompl := '&';
    End;
    if pPendente <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'pendente='+pPendente.ToString;
       vCompl := '&';
    End;
    if pUsuarioId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'usuarioid='+pusuarioId.ToString;
       vCompl := '&';
    End;
    if pModeloReport <> '' then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'modelo='+pModeloReport;
       vCompl := '&';
    End;
    if pDivergencia <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'divergencia='+pDivergencia.ToString;
       vCompl := '&';
    End;
    if pNaoColetado <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'naocoletado='+pNaoColetado.ToString;
       vCompl := '&';
    End;
    if pCodProduto <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'codproduto='+pCodProduto.ToString;
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'zonaid='+pZonaId.ToString;
       vCompl := '&';
    End;
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
//    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
//    Else
//      raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  Except ON E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TPedidoSaidaDao.GetAuditoriaSaidaPorProduto(pDataInicial,
  pDataFinal: TDateTime; pPedidoId: Integer; pRessuprimento: String;
  pCodProduto: Integer; pDescrLote: String): TJsonArray;
Var ObjPedidoSaida  : TPedidoSaida;
    vCompl : String;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/pedido/saidaporproduto';
    vCompl := '?';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pPedidoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'pedidoid='+pPedidoId.ToString;
       vCompl := '&';
    End;
    if pressuprimento <> '' then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'ressuprimento='+pRessuprimento;
       vCompl := '&';
    End;
    if pCodProduto <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'codproduto='+pCodProduto.ToString;
       vCompl := '&';
    End;
    if pDescrLote <> '' then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'descrlote='+pDescrLote;
       vCompl := '&';
    End;
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
    if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
       Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
    Else
      raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
  Except ON E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

Function TPedidoSaidaDao.GetClientesRotaCarga(pPessoaId: Integer; pRazao : String; pDataIni,
  pDataFin: TDateTime; pRotaId, pProcessoId: Integer): TJsonArray;
Var ObjPedidoSaida  : TPedidoSaida;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/clientesrotacarga?';
    if pPessoaId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&pessoaid='+pPessoaId.ToString();
    if pRazao <> '' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&razao='+pRazao;
    if pDataIni <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&dataini='+DateToStr(pDataIni);
    if pDataFin <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&datafin='+DateToStr(pDataFin);
    if pProcessoId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&processoid='+pProcessoId.ToString;
    if pRotaId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&rotaid='+pRotaId.ToString();
    DmeXactWMS.RESTRequestWMS.Resource := StringReplace(DmeXactWMS.RESTRequestWMS.Resource, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RestRequestWMS.Params.AddHeader('usuario', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
    {$IfDef Android}
       DmeXactWMS.RestRequestWMS.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
    {$else}
       DmeXactWMS.RestRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
    {$Endif}
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
      raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  Except ON E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoProduto(pReposicaoId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/consulta/{reposicaoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('reposicaoid', pReposicaoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else Begin
    Result := TJSonArray.Create;
    Result.AddElement(DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject);
  End;
end;

function TPedidoSaidaDao.GetConsultaReposicao(pDataInicial, pDataFinal : TDateTime;
  pReposicaoId, pProcessoId, pPendente, pUsuarioId : Integer): TJsonArray;
Var vComplemento : String;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/consulta';
  vComplemento := '?';
  if pDataInicial <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'datainicial='+DateToStr(pDataInicial);
     vComplemento := '&';
  End;
  if pDataFinal <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'datafinal='+DateToStr(pDataFinal);
     vComplemento := '&';
  End;
  if pReposicaoId <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'reposicaoid='+pReposicaoId.Tostring();
     vComplemento := '&';
  End;
  if pProcessoId <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'processoid='+pProcessoId.Tostring();
     vComplemento := '&';
  End;
  if pPendente <> 99 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'pendente='+pPendente.Tostring();
     vComplemento := '&';
  End;
  if pUsuarioId <> 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'usuarioid='+pUsuarioId.Tostring();
     vComplemento := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else Begin
     Result := TJsonArray.Create;
     Result.AddElement(DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject);
  End;
end;

function TPedidoSaidaDao.GetCortes(pDataIni, pDataFin : TDateTime; pPedidoId,
  pProdutoId : Integer; pSintetico, pZonaid, pCodPessoaERP, pRotaId : Integer; pDocumentoNr : String) : TJsonArray;
Var vResource : String;
begin
  Result := TJsonArray.Create;
  Try
    DmeXactWMS.ResetRest('R');
    vResource := 'v1/pedido/cortes?';
    if pDataIni <> 0 then
       vResource :=  vResource+'&dataini='+DateToStr(pDataIni);
    if pDataFin <> 0 then
       vResource :=  vResource+'&datafin='+DateToStr(pDataFin);
    if pPedidoId <> 0 then
       vResource :=  vResource+'&pedidoid='+pPedidoId.ToString;
    if pProdutoId <> 0 then
       vResource :=  vResource+'&codproduto='+pProdutoId.ToString;
    if pSintetico <> 0 then
       vResource :=  vResource+'&sintetico='+pSintetico.ToString;
    if pZonaId <> 0 then
       vResource :=  vResource+'&zonaid='+pzonaid.ToString;
    if pCodPessoaERP <> 0 then
       vResource :=  vResource+'&codpessoaerp='+pCodPessoaERP.ToString;
    if pDocumentoNr <> '' then
       vResource :=  vResource+'&documentonr='+pDocumentoNr;
    if pRotaId <> 0 then
       vResource :=  vResource+'&rotaid='+pRotaId.ToString;
    vResource := StringReplace(vResource, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RequestReport.Resource := vResource;
    DmeXactWMS.RequestReport.Method   := RmGet;
    DmeXactWMS.RequestReport.Timeout := 30000*4;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;

  End;
end;

function TPedidoSaidaDao.AtualizarProcesso(pPedidoId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedido/atualizarprocesso/{pedidoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method  := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

Function TPedidoSaidaDao.CancelarPedidoSaida(pJsonPedidoCancelar : TJsonObject) : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/cancelar';
  DmeXactWMS.RestRequestWMS.AddBody(pJsonPedidoCancelar.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method  := rmPatch;
  DmeXactWMS.RESTRequestWMS.Timeout := 30000*20;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível cancelar!!!');
end;

constructor TPedidoSaidaDao.Create;
begin
  //Self.FPedidoSaida := TPedidoSaida.Create;
end;

function TPedidoSaidaDao.Delete(pJsonArrayPedido : TJsonArray) : TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonArrayPedido.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida';
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

function TPedidoSaidaDao.DeleteReposicaoModelo(pModeloId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/modelo/{modeloid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('modeloid', pModeloId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
//  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
//     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

function TPedidoSaidaDao.DeleteReservaCorrecao: TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedido/reservacorrecao';
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
    Result := DmeXactWMS.RESTResponseWMS.JsonValue as TJsonArray;
end;

function TPedidoSaidaDao.GetPedidoSaida(pPedidoId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = ''; pShowErro : Integer = 1): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoSaida  : TPedidoSaida;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pPedidoId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/{pedidoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  End
  else if (pPessoaId <> 0) or (pDocumentoNr <> '') then Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/documento/{documentonr}/{pessoaid}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('documentonr', pDocumentoNr);
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString());
  End
  Else if pPedidoId = 0 then Begin
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/{pedidoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', '0');
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.GetProdutoResposicao(pData: TDateTime): tJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/reposicao/produtos?';
  if pData <> 0 then
     vResourceURI := vResourceURI+'&datapedido='+DateToStr(pData);
  DmeXactWMS.RESTRequestWMS.Resource := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.GetRelAnaliseRessuprimento(
  aParams: TDictionary<String, String>; pVolume : Boolean): TJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest('R');
  if Not pVolume then
     vResourceURI := 'v1/pedido/analiseressuprimento?'
  Else vResourceURI := 'v1/pedido/analiseressuprimentovolume?';
  if aParams.ContainsKey('dtinicio') then
     vResourceURI := vResourceURI+'&dtinicio='+aParams.Items['dtinicio'];
  if aParams.ContainsKey('dttermino') then
     vResourceURI := vResourceURI+'&dttermino='+aParams.Items['dttermino'];
  if aParams.ContainsKey('rotaid') then
     vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
  if aParams.ContainsKey('codpessoaerp') then
     vResourceURI := vResourceURI+'&codpessoaerp='+aParams.Items['codpessoaerp'];
  if aParams.ContainsKey('zonaid') then
     vResourceURI := vResourceURI+'&zonaid='+aParams.Items['zonaid'];
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetRelApanhePicking(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId : Integer) : TJsonArray;
Var vResource : String;
begin
  DmeXactWMS.ResetRest;
  vResource := 'v1/pedido/apanhepicking?';
  if pDataInicio <> 0 then
     vResource :=  vResource+'&dataini='+DateToStr(pDataInicio);
  if pDataFinal <> 0 then
     vResource :=  vResource+'&datafin='+DateToStr(pDataFinal);
  if pCodPessoaERP <> 0 then
     vResource :=  vResource+'&codpessoaerp='+pCodPessoaERP.ToString();
  if pRotaId <> 0 then
     vResource :=  vResource+'&rotaid='+pRotaId.ToString();
  vResource := StringReplace(vResource, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RESTRequestWMS.Resource := vResource;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.GetRelColetaPulmao(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId, pZonaId : Integer) : TJsonArray;
Var vResource : String;
begin
  Try
    DmeXactWMS.ResetRest('R');
    vResource := 'v1/pedido/coletapulmao?';
    if pDataInicio <> 0 then
       vResource :=  vResource+'&dataini='+DateToStr(pDataInicio);
    if pDataFinal <> 0 then
       vResource :=  vResource+'&datafin='+DateToStr(pDataFinal);
    if pCodPessoaERP <> 0 then
       vResource :=  vResource+'&codpessoaerp='+pCodPessoaERP.ToString();
    if pRotaId <> 0 then
       vResource :=  vResource+'&rotaid='+pRotaId.ToString();
    if pZonaId <> 0 then
       vResource :=  vResource+'&zonaid='+pZonaId.ToString();
    vResource := StringReplace(vResource, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RequestReport.Resource := vResource;
    DmeXactWMS.RequestReport.Method   := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray;
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetRelHistoricoTransferenciaPicking(pDataInicial,
  pDataFinal: TDateTime; pReposicaoId, pProcessoId, pPendente,
  pUsuarioId: Integer; pModeloReport: String; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
Var ObjPedidoSaida  : TPedidoSaida;
    vCompl : String;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest('');
    DmeXactWMS.RequestReport.Resource := 'v1/reposicao/historicotransferencia';
    vCompl := '?';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pReposicaoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'reposicaoid='+pReposicaoId.ToString;
       vCompl := '&';
    End;
    if pProcessoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'processoid='+pProcessoId.ToString;
       vCompl := '&';
    End;
    if pPendente <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'pendente='+pPendente.ToString;
       vCompl := '&';
    End;
    if pUsuarioId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'usuarioid='+pusuarioId.ToString;
       vCompl := '&';
    End;
    if pModeloReport <> '' then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'modelo='+pModeloReport;
       vCompl := '&';
    End;
    if pCodProduto <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'codproduto='+pCodProduto.ToString;
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'zonaid='+pZonaId.ToString;
       vCompl := '&';
    End;
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except ON E: Exception do
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
  End;
end;

function TPedidoSaidaDao.GetRelRupturaAbastecimento(pDataIni, pDataFin : TDateTime) : TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/pedido/rupturaabastecimento?dataini='+DateToStr(pDataIni)+'&datafin='+DateToStr(pDataFin);
    DmeXactWMS.RequestReport.Method   := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoAutomatica(pDataReposicao: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String;
  pStatus: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedido/ReposicaoAutomatica?data='+DateToStr(pDataReposicao)+
                                          '&status='+pStatus.Tostring;
    if pZonaId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&zonaid='+pZonaId.ToString;
    if pEnderecoInicial <> '' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&enderecoinicial='+pEnderecoInicial;
    if pEnderecoFinal <> '' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&enderecofinal='+pEnderecoFinal;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoAutomaticaColeta(pDataReposicao: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String;
  pStatus: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedido/ReposicaoAutomaticacoleta?data='+DateToStr(pDataReposicao)+'&status='+pStatus.Tostring;
    if pZonaId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&zonaid='+pZonaId.ToString;
    if pEnderecoInicial <> '' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&enderecoinicial='+pEnderecoInicial;
    if pEnderecoFinal <> '' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&enderecofinal='+pEnderecoFinal;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoColetaProdutividade(pDataInicial,
  pDataFinal: TDateTime; pReposicaoId, pProcessoId, pPendente,
  pUsuarioId: Integer; pCodProduto, pZonaId: Integer): TJsonArray;
Var ObjPedidoSaida  : TPedidoSaida;
    vCompl : String;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest('');
    DmeXactWMS.RequestReport.Resource := 'v1/reposicao/coletaprodutividade';
    vCompl := '?';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pReposicaoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'reposicaoid='+pReposicaoId.ToString;
       vCompl := '&';
    End;
    if pProcessoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'processoid='+pProcessoId.ToString;
       vCompl := '&';
    End;
    if pPendente <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'pendente='+pPendente.ToString;
       vCompl := '&';
    End;
    if pUsuarioId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'usuarioid='+pusuarioId.ToString;
       vCompl := '&';
    End;
    if pCodProduto <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'codproduto='+pCodProduto.ToString;
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'zonaid='+pZonaId.ToString;
       vCompl := '&';
    End;
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoDemanda(pDataPedido: TDateTime;
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal, pTipoGeracao : String): TJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/demanda?data='+DateToStr(pDataPedido);
    if pZonaId<>0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&zonaid='+pZonaId.ToString;
    if pEnderecoInicial<>'' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&pickinginicial='+pEnderecoInicial;
    if pEnderecoFinal<>'' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&pickingfinal='+pEnderecoFinal;
    DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&tipogeracao='+pTipoGeracao;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Timeout := DmeXactWMS.RESTRequestWMS.Timeout*10;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
     raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoDemandaCapacidade(pPercDownMaxPicking,
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String;
  pNegativo: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/demandacapacidade?percdownmaxpicking='+pPercDownMaxPicking.ToString();
    if pZonaId<>0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&zonaid='+pZonaId.ToString;
    if pEnderecoInicial<>'' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&pickinginicial='+pEnderecoInicial;
    if pEnderecoFinal<>'' then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&pickingfinal='+pEnderecoFinal;
    DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&negativo='+pNegativo.ToString();
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Timeout := DmeXactWMS.RESTRequestWMS.Timeout*10;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoSaidaDao.GetReposicaoDemandaColeta(pTipoGeracao : String): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/demanda/coleta/{tipogeracao}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('tipogeracao', pTipoGeracao);
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

//Usado para reposição por capacidade
function TPedidoSaidaDao.GetReposicaoEnderecoColeta(
  pData: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/enderecocoleta?data='+DateToStr(pData);
  if pZonaId <> 0 then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&zonaid='+pZonaId.ToString();
  if pEnderecoInicial <> '' then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&enderecoinicial='+pEnderecoInicial;
  if pEnderecoFinal <> '' then
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '&enderecofinal='+pEnderecoFinal;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.GetReposicaoGerar(pData: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/gerar?data='+DateToStr(pData);
  if pZonaId<>0 then
     DmeXactWMS.RESTRequestWMS.Resource := '?zonaid='+pZonaId.ToString;
  if pEnderecoInicial<>'' then
     DmeXactWMS.RESTRequestWMS.Resource := '?enderecoinicial='+pEnderecoInicial;
  if pEnderecoFinal<>'' then
     DmeXactWMS.RESTRequestWMS.Resource := '?enderecofinal='+pEnderecoFinal;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.GetReposicaoHistorico(
  pJsonArray: TjsonArray): TJsonArray;
begin

end;

function TPedidoSaidaDao.GetReposicaoModelo(pModeloId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/reposicao/modelo/{modeloid}';
  DmeXactWMS.RequestReport.Params.AddUrlSegment('modeloid', pModeloId.ToString());
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
//  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
//     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.ResponseReport.JSONValue as tjsonArray;
//  End;
end;

function TPedidoSaidaDao.GetResumoProducao(pDtInicio, pDtTermino: TDate;
  pProcessoId, pUsuarioId: Integer; pDtPedidoIni, pDtPedidoFin : Tdate): TJsonArray;
Var vLim : String;
begin
  vLim := '?';
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/pedido/resumoproducao';
  if pDtInicio<>0 then Begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'datainicial='+DateToStr(pDtInicio);
     vLim := '&';
  End;
  if pDtTermino<>0 then Begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'datafinal='+DateToStr(pDtTermino);
     vLim := '&';
  End;
  if pProcessoId <> 0 then begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'processoid='+pProcessoId.ToString;
     vLim := '&';
  end;
  if pUsuarioId <> 0 then begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'usuarioid='+pUsuarioId.ToString;
     vLim := '&';
  end;
  if pDtPedidoIni<>0 then Begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'dtpedidoini='+DateToStr(pDtPedidoIni);
     vLim := '&';
  End;
  if pDtPedidoFin<>0 then Begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'dtpedidofin='+DateToStr(pDtPedidoFin);
     vLim := '&';
  End;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.ResponseReport.StatusText));
end;

function TPedidoSaidaDao.GetSaidaPorProdutoBalanceamento(pDataInicio,
  pDataTermino: TDateTime; pZonaId: Integer): TJsonArray;
Var vCompl : String;
begin
  Try
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/pedido/saidaporproduto/banlanceamento';
    vCompl := '?';
    if pDataInicio <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datainicio='+DateToStr(pDataInicio);
       vCompl := '&';
    End;
    if pDataTermino <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datatermino='+DateToStr(pDataTermino);
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'zonaid='+pZonaId.ToString;
       vCompl := '&';
    End;
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.MontarPaginacao: TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/montarpaginacao';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonObject;
  End;
  //Else
  //  raise Exception.Create('não foi possível definir paginação.');
end;

function TPedidoSaidaDao.GerarVolume(pjsonVolume: TJsonArray; pTipoVolume : String): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoSaida  : TPedidoSaida;
begin
  Try
    DmeXactWMS.ResetRest;
    if pTipoVolume = 'FC' then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/gerarvolumecaixafechada'
    Else DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/gerarvolumecaixafracionada';
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*5;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pjsonVolume.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPost;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray  ;
    writeln('     ->retorno ' + result.ToString) ;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

Function TPedidoSaidaDao.GetDashBoard0102(pDtInicio,
  pDtTermino: TDate): TJsonObject;
begin
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/pedido/dashboard0102?dtinicio='+DateToStr(pDtInicio)+'&dttermino='+DateToStr(pDtTermino);
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetDashBoard030405(pDtInicio,
  pDtTermino: TDate): TJsonArray;
Begin
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/pedido/dashboard030405?dtinicio='+DateToStr(pDtInicio)+'&dttermino='+DateToStr(pDtTermino);
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJsonArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetDashBoard06(pDtInicio,
  pDtTermino: TDate): TJsonArray;
begin
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/pedido/dashboard06?dtinicio='+DateToStr(pDtInicio)+'&dttermino='+DateToStr(pDtTermino);
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJsonArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetDashProducaoDiaria(pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/pedido/dashproducaodiaria?datainicial='+DateToStr(pDataInicial)+'&datafinal='+DateToStr(pDataFinal);
    DmeXactWMS.RequestReport.Method   := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.GetDashProducaoDiariaZona(pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/pedido/dashproducaodiaria/zona?datainicial='+DateToStr(pDataInicial)+'&datafinal='+DateToStr(pDataFinal);
    DmeXactWMS.RequestReport.Method   := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoPed(
  aParams: TDictionary<String, String>): TJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/pedido/dsboard/evolucaoatendimentoped?';
  if aParams.ContainsKey('datainicio') then
     vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
  if aParams.ContainsKey('datafinal') then
     vResourceURI := vResourceURI+'&datafinal='+aParams.Items['datafinal'];
  if aParams.ContainsKey('rotaid') then
     vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
  if aParams.ContainsKey('zonaid') then
     vResourceURI := vResourceURI+'&zonaid='+aParams.Items['zonaid'];
  if aParams.ContainsKey('zonaid') then
     vResourceURI := vResourceURI+'&zonaid='+aParams.Items['zonaid'];
  if aParams.ContainsKey('zonaidstr') then
     vResourceURI := vResourceURI+'&zonaidstr='+aParams.Items['zonaidstr'];
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnid(aParams: TDictionary<String, String>): TJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/pedido/dsboard/evolucaoatendimentounid?';
  if aParams.ContainsKey('datainicio') then
     vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
  if aParams.ContainsKey('datafinal') then
     vResourceURI := vResourceURI+'&datafinal='+aParams.Items['datafinal'];
  if aParams.ContainsKey('zonaid') then
     vResourceURI := vResourceURI+'&zonaid='+aParams.Items['zonaid'];
  if aParams.ContainsKey('rotaid') then
     vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidZona(aParams: TDictionary<String, String>): TJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/pedido/dsboard/evolucaoatendimentounidzona?';
  if aParams.ContainsKey('datainicio') then
     vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
  if aParams.ContainsKey('datafinal') then
     vResourceURI := vResourceURI+'&datafinal='+aParams.Items['datafinal'];
  if aParams.ContainsKey('zonaidstr') then
     vResourceURI := vResourceURI+'&zonaidstr='+aParams.Items['zonaidstr'];
  if aParams.ContainsKey('rotaid') then
     vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidEmbalagem(
  aParams: TDictionary<String, String>; pTipo : String): TJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/pedido/dsboard/evolucaoatendimentounidembalagem?';
  if aParams.ContainsKey('datainicio') then
     vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
  if aParams.ContainsKey('datafinal') then
     vResourceURI := vResourceURI+'&datafinal='+aParams.Items['datafinal'];
  if aParams.ContainsKey('zonaidstr') then
     vResourceURI := vResourceURI+'&zonaidstr='+aParams.Items['zonaidstr'];
  if aParams.ContainsKey('rotaid') then
     vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
  if ptipo = 'Unid' then
     vResourceURI := vResourceURI+'&tipo='+'Unid'
  Else vResourceURI := vResourceURI+'&tipo='+'Vol';
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoVol(
  aParams: TDictionary<String, String>): TJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/pedido/dsboard/evolucaoatendimentovol?';
  if aParams.ContainsKey('datainicio') then
     vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
  if aParams.ContainsKey('datafinal') then
     vResourceURI := vResourceURI+'&datafinal='+aParams.Items['datafinal'];
  if aParams.ContainsKey('zonaidstr') then
     vResourceURI := vResourceURI+'&zonaidstr='+aParams.Items['zonaidstr'];
  if aParams.ContainsKey('rotaid') then
     vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetMotivoExclusaoPedido: TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/pedido/motivoexclusao';
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaDao.GetMovimentacao(pPedidoId: Integer; pDataInicio,
  pDataFinal: TDateTime; pProdutoId: Integer): TJsonArray;
Var vLim : String;
begin
  vLim := '?';
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/pedido/movimentacao';
  if pPedidoId <> 0 then begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'pedidoid='+pPedidoId.ToString;
     vLim := '&';
  end;
  if pDataInicio<>0 then Begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'datainicial='+DateToStr(pDataInicio);
     vLim := '&';
  End;
  if pDataFinal<>0 then Begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'datafinal='+DateToStr(pDataFinal);
     vLim := '&';
  End;
  if pProdutoId <> 0 then begin
     DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vLim+'produtoid='+pProdutoId.ToString;
     vLim := '&';
  end;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.ResponseReport.StatusText));
end;

function TPedidoSaidaDao.GetPedidoPendente : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoSaida  : TPedidoSaida;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/saida/pendente';
  DmeXactWMS.RequestReport.Method := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.GetPedidoProcesso(pPedidoId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/pedido/processo/{pedidoid}';
  DmeXactWMS.RequestReport.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) or
     (DmeXactWMS.ResponseReport.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.ResponseReport.JSONValue as tjsonArray;
  End;
end;

function TPedidoSaidaDao.PedidoParaCargas(pPedidoId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pDocumentoNr, pRazao,
  pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId, pMontarCarga,
  pCargaId: Integer): TJsonArray;
Var vResourceURI : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Timeout := 60000;
  vResourceURI := 'v1/saida/pedidoparacargas?';
  if pPedidoId <> 0 then
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
  if pCodigoERP <> 0 then
     vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
  if pPessoaId <> 0 then
     vResourceURI := vResourceURI+'&pessoaid='+pPessoaId.ToString();
  if pDataIni <> 0 then
     vResourceURI := vResourceURI+'&dataini='+DateToStr(pDataIni);
  if pDataFin <> 0 then
     vResourceURI := vResourceURI+'&datafin='+DateToStr(pDataFin);
  if pDocumentoNR <> '' then
     vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
  if pRazao <> '' then
     vResourceURI := vResourceURI+'&razao='+pRazao;
  if pRegistroERP <> '' then
     vResourceURI := vResourceURI+'&registroerp='+pRegistroERP;
  if pRotaId <> 0 then
     vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString;
  if pRotaIdFinal <> 0 then
     vResourceURI := vResourceURI+'&rotaidfinal='+pRotaIdFinal.ToString;
  if pZonaId <> 0 then
     vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString;
  vResourceURI := vResourceURI+'&montarcarga='+pmontarCarga.ToString;
  if pCargaId <> 0 then
     vResourceURI := vResourceURI+'&cargaid='+pCargaId.ToString;
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  //DmExactWMS.RequestReport.Timeout := 30000*5;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.PedidoParaProcessamento(pPedidoId, pCodigoERP: Integer;
  pDataIni, pDataFin: TDateTime; pProcessoId, pRotaId, pRotaIdFinal, pZonaId, pRecebido, pCubagem,
  pEtiqueta: Integer): TJsonArray;
Var vResourceURI : String;
    vTimeOut     : Integer;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/saida/processamento?';
  if pPedidoId <> 0 then
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
  if pCodigoERP <> 0 then
     vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
  if pDataIni <> 0 then
     vResourceURI := vResourceURI+'&dataini='+DateToStr(pDataIni);
  if pDataFin <> 0 then
     vResourceURI := vResourceURI+'&datafin='+DateToStr(pDataFin);
  if pProcessoId <> 0 then
     vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString;
  if pRotaId <> 0 then
     vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString;
  if pRotaIdFinal <> 0 then
     vResourceURI := vResourceURI+'&rotaidfinal='+pRotaIdFinal.ToString;
  if pZonaId <> 0 then
     vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString;
  vResourceURI := vResourceURI + '&recebido='+pRecebido.ToString();
  vResourceURI := vResourceURI + '&cubagem='+pCubagem.ToString();
  vResourceURI := vResourceURI + '&etiqueta='+pEtiqueta.ToString();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  vTimeOut := DmExactWMS.RequestReport.Timeout;
  DmExactWMS.RequestReport.Timeout := 30000*5;
  DmeXactWMS.RequestReport.Execute;
  DmExactWMS.RequestReport.Timeout := vTimeOut;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.PedidoPrintTag(pPedidoId, pPedidoVolumeId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pRazao : String;
  pRotaId, pRotaIdFinal, pZonaId, pPrintTag, pEmbalagem: Integer): tJsonArray;
Var vResourceURI : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/saida/printtag?';
  if pPedidoId <> 0 then
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
  if pPedidoVolumeId <> 0 then
     vResourceURI := vResourceURI+'&pedidovolumeid='+pPedidoVolumeId.ToString();
  if pCodigoERP <> 0 then
     vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
  //if pPessoaId <> 0 then
  //   vResourceURI := vResourceURI+'&pessoaid='+pPessoaId.ToString();
  if pDataIni <> 0 then
     vResourceURI := vResourceURI+'&dataini='+DateToStr(pDataIni);
  if pDataFin <> 0 then
     vResourceURI := vResourceURI+'&datafin='+DateToStr(pDataFin);
  //if pRazao <> '' then
  //   vResourceURI := vResourceURI+'&razao='+pRazao;
  if pRotaId <> 0 then
     vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString;
  if pRotaIdFinal <> 0 then
     vResourceURI := vResourceURI+'&rotaidfinal='+pRotaIdFinal.ToString;
  if pZonaId <> 0 then
     vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString;
  vResourceURI := vResourceURI + '&printtag='+pPrintTag.ToString();
  vResourceURI := vResourceURI + '&embalagem='+pEmbalagem.ToString();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmExactWMS.RequestReport.Timeout := 30000*5;
  DmeXactWMS.RequestReport.Execute;
  Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
end;

function TPedidoSaidaDao.PedidoProcessar(pPedidoId: Int64; pCodigoERP : Int64; pPessoaId : Int64; pDataIni, pDataFin : TDateTime;
                           pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pRotaIdFinal, pZonaId : Int64; pProcessoId : Integer; pRecebido, pCubagem,
                           pEtiqueta : Integer; pProcessar : Boolean; pMontarCarga : Integer; pCodProduto : Int64;
                           pPedidoPendente : Integer; pCargaId : Int64; pNotaFiscalERP : String; pPrintTag, pEmbalagem : Integer): tJsonArray;
Var vResourceURI : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Timeout := 90000;
  ///v1/saida/cubagem?DataIni=01/05/2021&DataFin=21/05/21
  if pProcessar then
     vResourceURI := 'v1/saida/cubagem?'
  else
     vResourceURI := 'v1/saida/pedido?';
  if pPedidoId <> 0 then
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
  if pCodigoERP <> 0 then
     vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
  if pPessoaId <> 0 then
     vResourceURI := vResourceURI+'&pessoaid='+pPessoaId.ToString();
  if pDataIni <> 0 then
     vResourceURI := vResourceURI+'&dataini='+DateToStr(pDataIni);
  if pDataFin <> 0 then
     vResourceURI := vResourceURI+'&datafin='+DateToStr(pDataFin);
  if pDocumentoNR <> '' then
     vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
  if pRazao <> '' then
     vResourceURI := vResourceURI+'&razao='+pRazao;
  if pRegistroERP <> '' then
     vResourceURI := vResourceURI+'&registroerp='+pRegistroERP;
  if pRotaId <> 0 then
     vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString;
  if pRotaIdFinal <> 0 then
     vResourceURI := vResourceURI+'&rotaidfinal='+pRotaIdFinal.ToString;
  if pZonaId <> 0 then
     vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString;
  if pProcessoId <> 0 then
     vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString;
  if pCodProduto <> 0 then
     vResourceURI := vResourceURI+'&codproduto='+pCodProduto.ToString;
  vResourceURI := vResourceURI+'&montarcarga='+pmontarCarga.ToString;
  if pCargaId <> 0 then
     vResourceURI := vResourceURI+'&cargaid='+pCargaId.ToString;
  if pProcessar then Begin
     vResourceURI := vResourceURI + '&recebido='+pRecebido.ToString();
     vResourceURI := vResourceURI + '&cubagem='+pCubagem.ToString();
     vResourceURI := vResourceURI + '&etiqueta='+pEtiqueta.ToString();
     vResourceURI := vResourceURI + '&printtag='+pPrintTag.ToString();
     vResourceURI := vResourceURI + '&embalagem='+pEmbalagem.ToString();
  End;
  if pPedidoPendente <> 0 then
     vResourceURI := vResourceURI+'&pedidopendente='+pPedidoPendente.ToString;
  if PNotaFiscalERP <> '' then
     vResourceURI := vResourceURI+'&notafiscalerp='+pNotaFiscalERP;
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  //DmExactWMS.RequestReport.Timeout := 30000*5;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.PedidoProdutoSemPicking(pPedidoId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pDocumentoNr, pRazao,
  pRegistroERP: String; pRotaId, pProcessoId, pRecebido, pCubagem,
  pEtiqueta: Integer; pProcessar, pVerificarEstoque : Boolean): tJsonArray;
Var vResourceURI    : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  vResourceURI := 'v1/saida/produtosempicking?';
  if pPedidoId <> 0 then
     vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
  if pCodigoERP <> 0 then
     vResourceURI := vResourceURI+'&codigoerp='+pCodigoERP.ToString();
  if pPessoaId <> 0 then
     vResourceURI := vResourceURI+'&pessoaid='+pPessoaId.ToString();
//  if (pDataIni <> 0) and (pDataFin<>0) then
//     vResourceURI := vResourceURI+'&DataFin='+DateToStr(pDataFin)  else
  if pDataIni <> 0 then
     vResourceURI := vResourceURI+'&dataini='+DateToStr(pDataIni);
//  Else
  if pDataFin <> 0 then
     vResourceURI := vResourceURI+'&datafin='+DateToStr(pDataFin);
//  else vResourceURI := 'v1/saida/cubagem?';
  if pDocumentoNR <> '' then
     vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
  if pRazao <> '' then
     vResourceURI := vResourceURI+'&razao='+pRazao;
  if pRegistroERP <> '' then
     vResourceURI := vResourceURI+'&registroerp='+pRegistroERP;
  if pRotaId <> 0 then
     vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString;
  if pProcessoId <> 0 then
     vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString;
  if pProcessar then Begin
     vResourceURI := vResourceURI + '&recebido='+pRecebido.ToString();
     vResourceURI := vResourceURI + '&cubagem='+pCubagem.ToString();
     vResourceURI := vResourceURI + '&etiqueta='+pEtiqueta.ToString();
  End;
  if pVerificarEstoque then
     vResourceURI := vResourceURI + '&verificarestoque='+1.ToString()
  Else
     vResourceURI := vResourceURI + '&verificarestoque='+0.ToString();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RequestReport.Resource := vResourceURI;
  DmeXactWMS.RequestReport.Method   := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.PedidoResumoAtendimento(pPedidoId,
  pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TjsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.Resource := 'v1/saida/resumoatendimento/{pedidoid}/{divergencia}/{datainicial}/{datafinal}';
  DmeXactWMS.RequestReport.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RequestReport.Params.AddUrlSegment('divergencia', pDivergencia.ToString());
  DmeXactWMS.RequestReport.Params.AddUrlSegment('datainicial', '0');//DateToStr(pDataInicial));
  DmeXactWMS.RequestReport.Params.AddUrlSegment('datafinal', '0'); //DateToStr(pDataFinal));
  DmeXactWMS.RequestReport.Method := RmGet;
  DmeXactWMS.RequestReport.Execute;
  if (DmeXactWMS.ResponseReport.StatusCode = 200) or (DmeXactWMS.ResponseReport.StatusCode = 201) Then
     Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.ResponseReport.StatusText);
end;

function TPedidoSaidaDao.Pedido_CancelarCubagem(pPedidoId: Integer): tjsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/cancelarcubagem/{pedidoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
    //raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.PutRegistrarProcesso(pPedidoId, pProcessoId: Integer): TJsonArray;
Var pJsonRegistro : TJsonObject;
begin
  Try
    pJsonRegistro := TJsonObject.Create;
    pJsonRegistro.AddPair('pedidoid', TJsonNumber.Create(pPedidoId));
    pJsonRegistro.AddPair('processoid', TJsonNumber.Create(pProcessoId));
     {$IfDef Android}
       pJsonRegistro.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
    {$else}
       pJsonRegistro.AddPair('terminal', NomeDoComputador);
    {$Endif}
    pJsonRegistro.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonRegistro.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedido/registrarprocesso';
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.RelReposicaoTransfPicking(pDataInicial,
  pDataFinal: TDateTime; pReposicaoId, pProcessoId, pPendente,
  pUsuarioId: Integer; pModeloReport: String; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
Var ObjPedidoSaida  : TPedidoSaida;
    vCompl : String;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest('R');
    DmeXactWMS.RequestReport.Resource := 'v1/reposicao/transferencia';
    vCompl := '?';
    if pDataInicial <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datainicial='+DateToStr(pDataInicial);
       vCompl := '&';
    End;
    if pDataFinal <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'datafinal='+DateToStr(pDataFinal);
       vCompl := '&';
    End;
    if pReposicaoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'reposicaoid='+pReposicaoId.ToString;
       vCompl := '&';
    End;
    if pProcessoId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'processoid='+pProcessoId.ToString;
       vCompl := '&';
    End;
    if pPendente <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'pendente='+pPendente.ToString;
       vCompl := '&';
    End;
    if pUsuarioId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'usuarioid='+pusuarioId.ToString;
       vCompl := '&';
    End;
    if pModeloReport <> '' then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'modelo='+pModeloReport;
       vCompl := '&';
    End;
    if pCodProduto <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'codproduto='+pCodProduto.ToString;
       vCompl := '&';
    End;
    if pZonaId <> 0 then Begin
       DmeXactWMS.RequestReport.Resource := DmeXactWMS.RequestReport.Resource+vCompl+'zonaid='+pZonaId.ToString;
       vCompl := '&';
    End;
    DmeXactWMS.RequestReport.Method := RmGet;
    DmeXactWMS.RequestReport.Execute;
    Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
  Except ON E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TPedidoSaidaDao.ReposicaoCancelar(
  pJsonObjectReposicao: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObjectReposicao.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/cancelar';
    DmeXactWMS.RESTRequestWMS.Method := rmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.ReposicaoExcluir(pJsonObjectExcluir : TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObjectExcluir.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/delete';
    DmeXactWMS.RESTRequestWMS.Method := rmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.ReposicaoFinalizar(pJsonColeta: TJsonArray): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonColeta.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/finalizar';
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201]) then //= 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.ReposicaoRegistrarInUse(pReposicaoId,
  pUsuarioId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/registrarinuse/{reposicaoid}/{usuarioid}/{terminal}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('reposicaoid', pReposicaoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', pUsuarioId.ToString());
  {$IfDef Android}
     DmeXactWMS.RestRequestWMS.Params.AddUrlSegment('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
  {$else}
     DmeXactWMS.RestRequestWMS.Params.AddUrlSegment('terminal', NomeDoComputador);
  {$Endif}
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

function TPedidoSaidaDao.ReposicaoSalvarItemColetado(
  pJsonColeta: TJsonArray): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonColeta.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/salvaritemcoletado';
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201]) then //= 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.ReposicaoTransferenciaPicking(
  PJsonTransferencia: TJsonObject): TJsonArray;
begin
  DmeXactWMS.ResetRest('R');
  DmeXactWMS.RequestReport.ClearBody;
  DmeXactWMS.RequestReport.AddBody(PJsonTransferencia.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RequestReport.Resource := 'v1/reposicao/ReposicaoTransferenciaPicking';
  DmeXactWMS.RequestReport.Method := rmPut;
  DmeXactWMS.RequestReport.Execute;
  Result := DmeXactWMS.ResponseReport.JSONValue as TJSONArray
end;

function TPedidoSaidaDao.PedidoCubagem(pPedidoId: Integer): tJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/pedidocubagem_caixafechada/{pedidoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TPedidoSaidaDao.PedidoCubagemVolume_CaixaFracionada(
  pPedidoId: Integer): tjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/pedidocubagem_caixafracionada/{pedidoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

function TPedidoSaidaDao.Salvar(pPedidoId : Integer): Boolean;
Var jSonPedidoSaida : TJsonObject;
begin
  Result := False;
//  jSonPedidoSaida := tJson.ObjectToJsonObject(Self.FPedidoSaida);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPedidoSaida.ToJson, ContentTypeFromString('application/json'));
  if pPedidoId = 0 then Begin   //Self.PedidoSaida.PedidoId
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/saida/{pedidoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString); //Self.FPedidoSaida.PedidoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPedidoSaida);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.SalvarCheckInItem(
  pjsonPedidoSaida: TJsonObject): TJsonObject;
begin

end;

function TPedidoSaidaDao.SalvarReposicao(pJsonReposicao: TJsonObject): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.TimeOut := DmeXactWMS.RestRequestWMS.TimeOut*10;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonReposicao.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/salvar';
  if pJsonReposicao.GetValue<Integer>('reposicaoid') = 0 then
     DmeXactWMS.RESTRequestWMS.Method := rmPOST
  Else
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201]) then //= 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoSaidaDao.SalvarReposicaoModelo(pJsonReposicao: TJsonObject): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.Timeout := DmeXactWMS.RestRequestWMS.Timeout*10;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonReposicao.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/reposicao/modelo';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201]) then //= 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject).GetValue<String>('Erro'));
end;

end.
