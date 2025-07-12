 unit PedidoVolumeDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PedidoVolumeClass, System.JSON, REST.Json, Rest.Types, System.Generics.Collections;

Type

  TPedidoVolumeDao = class
  private
    FPedidoVolume : TPedidoVolume;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetVolume(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pEmbalagem : String = 'T'; pZonaId : Integer = 0) : TJsonArray;
    Function GetOpenVolumeParaSeparacao(pEmbalagemId, pPedidoVolumeId, pUsuarioId: Integer) : tJsonArray;
    Function GetVolumeRegistrarExpedicao(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetVolumePrintTag(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pZonaId : Integer = 0; pPrintTag : Integer = 0; pEmbalagem : Integer = 0) : TJsonArray;
    Function GetVolumeProdutos(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetVolumeProdutosReconferencia(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetVolumeLotes(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetPedidoVolumeSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function MapaSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0) : tJsonArray;
    Function RegistrarDocumentoEtapa(pDocumentoEtapaId : Integer) : TJsonArray;
    Function CaixaSeparacao(pCaixaEmbalagemId: Integer): TJsonArray;
    Function RegistrarDocumentoEtapaComBaixaEstoque(pDocumentoEtapaId, pOrigemCheckout : Integer) : TJsonArray;
    function RegistrarDocumentoEtapaSemBaixaEstoque(pDocumentoEtapaId, pOrigemCheckout: Integer): TJsonArray;
    Function VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId, pZonaId, pPrintTag, pEmbalagem : Integer) : tjsonArray;
    Function EtiquetasPorVolume(pPedidoVolumeId : Integer) : tjsonArray;
    Function PrintEtiquetaPorRua(pJsonEtiqueta: TJsonObject): TJsonArray;
    Function IdentificaVolumeCxaFechada(pPedidoVolumeId : Integer) : TJsonArray;
    Function Salvar : tjsonObject;
    Function VolumeExpedicao(pCodPessoaERP : Integer = 0; pRotaId : Integer = 0): TjsonArray;
    Function VolumeExpedido    : TJsonArray;
    Function VolumeExpedidoDia : TJsonArray;
    Function AtualizarConferencia( pJsonArray : TJsonArray) : TJsonArray;
    Function FinalizarConferenciaComRegistro( pJsonFinalizacao : TJsonObject) : TJsonArray;
    Function GerarVolumeExtra(pJsonArrayProdutoCorte : TJsonArray) : TJsonArray;
    Function CancelarVolume(pJsonObject : TJsonObject) : TJsonArray;
    Function GetVolumeEtapas(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetMapaSeparacaoLista(pPedidoIdInicial, pPedidoIdFinal, pPedidoVolumeIdInicial,
            pPedidoVolumeIdFinal, pRotaId, pCodPessoaErp : Integer; pDtPedidoInicial, pDtPedidoFinal : TDateTime) : TJsonArray;
    function GetDshCheckOut(pDataInicialPedido, pDataFinalPedido,
         pDataInicialProducao, pDataFinalProducao : TDateTime; pUsuarioId, pEmbalagemId, pReCheckout : Integer): TJsonArray;
    Function GetAuditoriaVolumes(pDtInicio, pDtFInal: TDateTime; pPedidoId: Integer; pDocumentoNr: String;
                                 pRotaId, pDestinatarioId, pProcessoId, pCodProduto, pZonaId, pTipoVolume, pUsuarioId : Integer): TJsonArray;
    Function GetAuditoriaCortes(pDtInicio, pDtFInal: TDateTime; pPedidoId: Integer; pDocumentoNr: String;
                                 pRotaId, pDestinatarioId, pProcessoId, pCodProduto, pLinhaId, pTipoVolume, pUsuarioId : Integer): TJsonArray;
    Function VolumeLoteSubstituicao(pJsonObjectLoteSubstituto: TJsonObject): TJsonArray;
    Function DshVolumeEvolucao_Quantidade(aParams : TDictionary<String, String>) : TJsonArray;
    Function DshVolumeEvolucao_Unidades(aParams : TDictionary<String, String>) : TJsonArray;
    Function ResetSeparacao(pPedidoVolumeId : Integer) : TjsonArray;
    Function GetVolumeComDivergencia(pPedidoVolumeId, pEnderecoId : Integer): TJsonArray;
    Function GetPedidoVolumeProduto(pPedidoid, pCodProduto : Integer) : TJsonArray;
    Function GetProducaoDiariaPorLoja(pDataInicial, pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
    Function GetProducaoDiariaPorRota(pDataInicial, pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
    Function GetProducaoDiariaPorRua(pDataInicial, pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
    Function GetProducaoDiariaPorSetor(pDataInicial, pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
    Function GetVolumeConsulta(pDataInicial, pDataFinal: TDateTime; pPedidoId, pPedidoVolumeId: Integer;
                               pDocumentoNr: String; pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto,
                               pZonaId , pPendente : Integer; pEmbalagem : String): TJsonArray;
    Function GetVolumeExcel(pDataInicial, pDataFinal: TDateTime; pPedidoId, pPedidoVolumeId: Integer;
                            pDocumentoNr: String; pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto,
                            pZonaId , pPendente : Integer; pEmbalagem : String): TJsonArray;
    Function GetVolumeConsultaLotes(pDataInicial, pDataFinal: TDateTime; pPedidoId, pPedidoVolumeId: Integer;
                               pDocumentoNr: String; pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto,
                               pZonaId , pPendente : Integer; pEmbalagem : String): TJsonArray;
    Function GetVolumeProdutosParaSeparacao(pPedidoId, pPedidoVolumeId: Integer): TJsonArray;
    Function GetVolumeEAN(pPedidoVolumeId: Integer): TJsonArray;
    Function SaveApanheProduto(pJsonApanhe: TJsonArray): TJsonArray;
    Function SalvarColetaComRegistro(pJsonColetaRegistro : TJsonObject) : TJsonArray;
    Function SalvarUltimoEnderecoColetado(pPedidoVolumeId, pEnderecoId : Integer) : TJSonArray;
    Function GetPedidoCxaFechadaCheckOut(pPedidoVolumeId : Integer) : TjsonObject;
    Function VolumeLacres(pJsonObjectLacres: TJsonObject): TJsonArray;
    Function VolumeLacresCarga(pCargaId : Integer): TJsonArray;
    Function DesfazerInicioCheckOutOpen(pPedidoVolumeId : Integer) : TJsonArray;

    Property ObjPedidoVolume : TPedidoVolume Read FPedidoVolume Write FPedidoVolume;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes;//, FuncionalidadeClass;

function TPedidoVolumeDao.AtualizarConferencia(pJsonArray: TJsonArray): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonArray.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/atualizarconferenciasemlotes';
    DmeXactWMS.RESTRequestWMS.Method   := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.CaixaSeparacao(
  pCaixaEmbalagemId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/{pedidovolumeid}/{caixaembalagemid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid',   Self.ObjPedidoVolume.PedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', pCaixaEmbalagemId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmPost;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
end;

function TPedidoVolumeDao.CancelarVolume(pJsonObject: TJsonObject): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/cancelar/{pedidovolumeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', Self.ObjPedidoVolume.PedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPUT;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Else
     Result :=  DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
end;

constructor TPedidoVolumeDao.Create;
begin
  Self.FPedidoVolume := TPedidoVolume.Create;
end;

function TPedidoVolumeDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidoid/{pedidovolumeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', Self.ObjPedidoVolume.PedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TPedidoVolumeDao.DesfazerInicioCheckOutOpen(pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/desfazeriniciocheckoutopen/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidovolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeDao.DshVolumeEvolucao_Quantidade(
  aParams: TDictionary<String, String>): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/dshvolumeevolucao_quantidade?';
    if aParams.ContainsKey('datainicio') then
       vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
    if aParams.ContainsKey('rotaid') then
       vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
    if aParams.ContainsKey('zonaid') then
       vResourceURI := vResourceURI+'&zonaid='+aParams.Items['zonaid'];
    if aParams.ContainsKey('codpessoaerp') then
       vResourceURI := vResourceURI+'&codpessoaerp='+aParams.Items['codpessoaerp'];
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except
    raise Exception.Create(DmeXactWMS.RESTResponseWMS.StatusText);
  End;
end;

function TPedidoVolumeDao.DshVolumeEvolucao_Unidades(
  aParams: TDictionary<String, String>): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/dshvolumeevolucao_unidades?';
    if aParams.ContainsKey('datainicio') then
       vResourceURI := vResourceURI+'&datainicio='+aParams.Items['datainicio'];
    if aParams.ContainsKey('rotaid') then
       vResourceURI := vResourceURI+'&rotaid='+aParams.Items['rotaid'];
    if aParams.ContainsKey('zonaid') then
       vResourceURI := vResourceURI+'&zonaid='+aParams.Items['zonaid'];
    if aParams.ContainsKey('codpessoaerp') then
       vResourceURI := vResourceURI+'&codpessoaerp='+aParams.Items['codpessoaerp'];
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except
    raise Exception.Create(DmeXactWMS.RESTResponseWMS.StatusText);
  End;
end;

function TPedidoVolumeDao.EtiquetasPorVolume(pPedidoVolumeId: Integer): tjsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/etiquetaporvolume/{pedidovolumeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidovolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.FinalizarConferenciaComRegistro(pJsonFinalizacao: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonFinalizacao.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/finalizarconferenciacomregistro';
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.GetVolume(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pEmbalagem : String = 'T'; pZonaId : Integer = 0): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/{pedidoid}/{pedidovolumeid}/{sequencia}/{ordem}/{embalagem}/{zonaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('sequencia', pSequencia.ToString());
    DmExactWMS.RestRequestWMS.params.AddUrlSegment('ordem', pOrdem.ToString());
    DmExactWMS.RestRequestWMS.params.AddUrlSegment('embalagem', pEmbalagem);
    DmExactWMS.RestRequestWMS.params.AddUrlSegment('zonaid', pZonaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeDao.GetVolumeComDivergencia(pPedidoVolumeId, pEnderecoId : Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/volumecomdivergencia/{pedidovolumeid}/{enderecoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
end;

function TPedidoVolumeDao.GetVolumeConsulta(pDataInicial, pDataFinal: TDateTime;
  pPedidoId, pPedidoVolumeId: Integer; pDocumentoNr: String; pSequencia,
  pCodPessoa, pProcessoId, pRotaId, pCodProduto, pZonaId, pPendente : Integer; pEmbalagem : String): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/consulta?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    if pPedidoId <> 0 then
       vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
    if pPedidoVolumeId <> 0 then
       vResourceURI := vResourceURI+'&pedidovolumeid='+pPedidoVolumeId.ToString();
    if pDocumentoNr <> '' then
       vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
    if pSequencia <> 0 then
       vResourceURI := vResourceURI+'&sequencia='+pSequencia.ToString();
    if pCodPessoa <> 0 then
       vResourceURI := vResourceURI+'&codpessoa='+pCodPessoa.ToString();
    if pProcessoId <> 0 then
       vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString();
    if pRotaId <> 0 then
       vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString();
    if pCodProduto <> 0 then
       vResourceURI := vResourceURI+'&codproduto='+pCodProduto.ToString();
    if pZonaId <> 0 then
       vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString();
    vResourceURI := vResourceURI+'&pendente='+pPendente.ToString();
    vResourceURI := vResourceURI+'&embalagem='+pEmbalagem;
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*5;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetVolumeExcel(pDataInicial, pDataFinal: TDateTime;
  pPedidoId, pPedidoVolumeId: Integer; pDocumentoNr: String; pSequencia,
  pCodPessoa, pProcessoId, pRotaId, pCodProduto, pZonaId, pPendente : Integer; pEmbalagem : String): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/excel?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    if pPedidoId <> 0 then
       vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
    if pPedidoVolumeId <> 0 then
       vResourceURI := vResourceURI+'&pedidovolumeid='+pPedidoVolumeId.ToString();
    if pDocumentoNr <> '' then
       vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
    if pSequencia <> 0 then
       vResourceURI := vResourceURI+'&sequencia='+pSequencia.ToString();
    if pCodPessoa <> 0 then
       vResourceURI := vResourceURI+'&codpessoa='+pCodPessoa.ToString();
    if pProcessoId <> 0 then
       vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString();
    if pRotaId <> 0 then
       vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString();
    if pCodProduto <> 0 then
       vResourceURI := vResourceURI+'&codproduto='+pCodProduto.ToString();
    if pZonaId <> 0 then
       vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString();
    vResourceURI := vResourceURI+'&pendente='+pPendente.ToString();
    vResourceURI := vResourceURI+'&embalagem='+pEmbalagem;
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*5;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetVolumeConsultaLotes(pDataInicial,
  pDataFinal: TDateTime; pPedidoId, pPedidoVolumeId: Integer;
  pDocumentoNr: String; pSequencia, pCodPessoa, pProcessoId, pRotaId,
  pCodProduto, pZonaId, pPendente: Integer; pEmbalagem: String): TJsonArray;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/consultalotes?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    if pPedidoId <> 0 then
       vResourceURI := vResourceURI+'&pedidoid='+pPedidoId.ToString();
    if pPedidoVolumeId <> 0 then
       vResourceURI := vResourceURI+'&pedidovolumeid='+pPedidoVolumeId.ToString();
    if pDocumentoNr <> '' then
       vResourceURI := vResourceURI+'&documentonr='+pDocumentoNr;
    if pSequencia <> 0 then
       vResourceURI := vResourceURI+'&sequencia='+pSequencia.ToString();
    if pCodPessoa <> 0 then
       vResourceURI := vResourceURI+'&codpessoa='+pCodPessoa.ToString();
    if pProcessoId <> 0 then
       vResourceURI := vResourceURI+'&processoid='+pProcessoId.ToString();
    if pRotaId <> 0 then
       vResourceURI := vResourceURI+'&rotaid='+pRotaId.ToString();
    if pCodProduto <> 0 then
       vResourceURI := vResourceURI+'&codproduto='+pCodProduto.ToString();
    if pZonaId <> 0 then
       vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString();
    vResourceURI := vResourceURI+'&pendente='+pPendente.ToString();
    vResourceURI := vResourceURI+'&embalagem='+pEmbalagem;
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetVolumeEAN(pPedidoVolumeId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/ean/{pedidovolumeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  End
end;

Function TPedidoVolumeDao.GetVolumeEtapas(pPedidoVolumeId: Integer): TJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/etapas/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
  //Else
  //  raise Exception.Create('não foi possível definir paginação.');
end;

function TPedidoVolumeDao.GetVolumeLotes(pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/lotes/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeDao.VolumeLacres(
  pJsonObjectLacres: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody( pJsonObjectLacres.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/lacres';
    DmeXactWMS.RESTRequestWMS.Method := rmPOST;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.VolumeLacresCarga(pCargaId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/lacres/carga/{cargaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('cargaid', pCargaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmGET;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.VolumeLoteSubstituicao(pJsonObjectLoteSubstituto : TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObjectLoteSubstituto.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/lotesubstituicao';
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

//Yod HeVav He
function TPedidoVolumeDao.GetVolumePrintTag(pPedidoId, pPedidoVolumeId,
  pSequencia, pOrdem, pZonaId, pPrintTag, pEmbalagem: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeprinttag/{pedidoid}/{pedidovolumeid}/{sequencia}/{ordem}/{zonaid}/{printtag}/{embalagem}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('sequencia', pSequencia.ToString());
  DmExactWMS.RestRequestWMS.params.AddUrlSegment('ordem', pOrdem.ToString());
  DmExactWMS.RestRequestWMS.params.AddUrlSegment('zonaid', pZonaId.ToString());
  DmExactWMS.RestRequestWMS.params.AddUrlSegment('printtag', pPrintTag.ToString());
  DmExactWMS.RestRequestWMS.params.AddUrlSegment('embalagem', pEmbalagem.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
end;

function TPedidoVolumeDao.GetVolumeProdutos(pPedidoVolumeId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/produto/{pedidovolumeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  End
 // Else
 //   raise Exception.Create('não foi possível definir paginação.');
end;

function TPedidoVolumeDao.GetVolumeProdutosParaSeparacao(pPedidoId,
  pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    if (pPedidoId = 0) and (pPedidoVolumeId<>0) then Begin
       //RESTRequest1.Resource := 'v1/pedidovolumeseparacao/{pedidovolumeid}';
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/produtoseparacao/{pedidovolumeid}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    End
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolumeseparacao/{pedidoid}/{pedidovolumeid}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.GetVolumeProdutosReconferencia(
  pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/produto/reconferencia/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.GetVolumeRegistrarExpedicao(
  pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/volumeregistrarexpedicao/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidovolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.IdentificaVolumeCxaFechada(
  pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/identificavolumecxafechada/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidovolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
End;

function TPedidoVolumeDao.GerarVolumeExtra(pJsonArrayProdutoCorte : TJsonArray): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/gerarvolumeextra/{pedidovolumeid}/{usuarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', Self.ObjPedidoVolume.PedidovolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
  DmeXactWMS.RestRequestWMS.AddBody(pJsonArrayProdutoCorte.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method := rmPost;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.GetAuditoriaCortes(pDtInicio, pDtFInal: TDateTime;
  pPedidoId: Integer; pDocumentoNr: String; pRotaId, pDestinatarioId,
  pProcessoId, pCodProduto, pLinhaId, pTipoVolume,
  pUsuarioId: Integer): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/auditoriacorte/analitico';
    vCompl := '?';
    if pDtInicio <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datainicial='+DateToStr(pDtInicio);
       vCompl := '&';
    end;
    if pDtFinal <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datafinal='+DateToStr(pDtFinal);
       vCompl := '&';
    end;
    if pPedidoId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'pedidoid='+pPedidoId.ToString();
       vCompl := '&';
    end;
    if pDocumentoNr <> '' then begin
       vResourceURI := vResourceURI+vCompl+'documentonr='+pDocumentoNr;
       vCompl := '&';
    end;
    if pRotaId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'rotaid='+pRotaId.ToString();
       vCompl := '&';
    end;
    if pDestinatarioId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'codpessoaerp='+pDestinatarioId.ToString();
       vCompl := '&';
    end;
    if pProcessoId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'processoid='+pProcessoId.ToString();
       vCompl := '&';
    end;
    if pCodProduto <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'codproduto='+pCodProduto.ToString();
       vCompl := '&';
    end;
    if pLinhaId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'linhaid='+pLinhaId.ToString();
       vCompl := '&';
    end;
    if pTipoVolume <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'tipovolume='+pTipoVolume.ToString();
       vCompl := '&';
    end;
    if pUsuarioId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'usuarioid='+pTipoVolume.ToString();
       vCompl := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*4;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeDao.GetAuditoriaVolumes(pDtInicio, pDtFinal: TDateTime;
  pPedidoId: Integer; pDocumentoNr: String; pRotaId, pDestinatarioId, pProcessoId,
  pCodProduto, pZonaId, pTipoVolume, pUsuarioId : Integer): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/auditoriariavolume';
    vCompl := '?';
    if pDtInicio <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datainicial='+DateToStr(pDtInicio);
       vCompl := '&';
    end;
    if pDtFinal <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'datafinal='+DateToStr(pDtFinal);
       vCompl := '&';
    end;
    if pPedidoId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'pedidoid='+pPedidoId.ToString();
       vCompl := '&';
    end;
    if pDocumentoNr <> '' then begin
       vResourceURI := vResourceURI+vCompl+'documentonr='+pDocumentoNr;
       vCompl := '&';
    end;
    if pRotaId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'rotaid='+pRotaId.ToString();
       vCompl := '&';
    end;
    if pDestinatarioId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'codpessoaerp='+pDestinatarioId.ToString();
       vCompl := '&';
    end;
    if pProcessoId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'processoid='+pProcessoId.ToString();
       vCompl := '&';
    end;
    if pCodProduto <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'codproduto='+pCodProduto.ToString();
       vCompl := '&';
    end;
    if pZonaId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'zonaid='+pZonaId.ToString();
       vCompl := '&';
    end;
    if pTipoVolume <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'tipovolume='+pTipoVolume.ToString();
       vCompl := '&';
    end;
    if pUsuarioId <> 0 then begin
       vResourceURI := vResourceURI+vCompl+'usuarioid='+pTipoVolume.ToString();
       vCompl := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.TimeOut := DmeXactWMS.RESTRequestWMS.TimeOut*4;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.GetDshCheckOut(pDataInicialPedido, pDataFinalPedido,
         pDataInicialProducao, pDataFinalProducao: TDateTime;
  pUsuarioId, pEmbalagemId, pReCheckout: Integer): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/pedidovolume/dshcheckout';
  vCompl := '?';
  if pDataInicialPedido <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datainicialpedido='+DateToStr(pDataInicialPedido);
     vCompl := '&';
  end;
  if pDataFinalPedido <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datafinalpedido='+DateToStr(pDataFinalPedido);
     vCompl := '&';
  end;
  if pDataInicialProducao <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datainicialproducao='+DateToStr(pDataInicialProducao);
     vCompl := '&';
  end;
  if pDataFinalProducao <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datafinalproducao='+DateToStr(pDataFinalProducao);
     vCompl := '&';
  end;
  if pUsuarioId <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'usuarioid='+pUsuarioId.ToString();
     vCompl := '&';
  end;
  vResourceURI := vResourceURI+vCompl+'recheckout='+pRecheckOut.ToString();
  vResourceURI := vResourceURI+vCompl+'embalagemid='+pEmbalagemId.ToString();
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.GetMapaSeparacaoLista(pPedidoIdInicial, pPedidoIdFinal,
  pPedidoVolumeIdInicial, pPedidoVolumeIdFinal, pRotaId, pCodPessoaErp: Integer;
  pDtPedidoInicial, pDtPedidoFinal: TDateTime): TJsonArray;
Var vResourceURI, vCompl : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/pedidovolume/mapaseparacaolista';
  vCompl := '?';
  if pPedidoIdInicial <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'pedidoidinicial='+pPedidoIdInicial.ToString();
     vCompl := '&';
  end;
  if pPedidoIdFinal <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'pedidoidfinal='+pPedidoIdFinal.ToString();
     vCompl := '&';
  end;
  if pPedidoVolumeIdInicial <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'pedidovolumeidinicial='+pPedidoVolumeIdInicial.ToString();
     vCompl := '&';
  end;
  if pPedidoVolumeIdFinal <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'pedidovolumeidfinal='+pPedidoVolumeIdFinal.ToString();
     vCompl := '&';
  end;
  if pRotaId <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'rotaid='+pRotaId.ToString();
     vCompl := '&';
  end;
  if pCodPessoaERP <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'codpessoaerp='+pCodPessoaERP.ToString();
     vCompl := '&';
  end;
  if pDtPedidoInicial <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datainicial='+DateToStr(pDtPedidoInicial);
     vCompl := '&';
  end;
  if pDtPedidoFinal <> 0 then begin
     vResourceURI := vResourceURI+vCompl+'datafinal='+DateToStr(pDtPedidoFinal);
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

function TPedidoVolumeDao.GetOpenVolumeParaSeparacao(pEmbalagemId,
  pPedidoVolumeId, pUsuarioId: Integer): tJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/openvolumeparaseparacao/{caixaid}/{pedidovolumeid}/{usuarioid}/{terminal}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaid', pEmbalagemId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', pUsuarioId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('terminal', NomeDoComputador);
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetPedidoCxaFechadaCheckOut(
  pPedidoVolumeId: Integer): TjsonObject;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoVolume  : TPedidoVolume;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/getpedidocxafechadacheckout/{pedidovolumeid}/{usuarioid}/{terminal}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('terminal', NomeDoComputador);
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TjsonObject
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetPedidoVolumeProduto(pPedidoid,
  pCodProduto: Integer): TJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoVolume  : TPedidoVolume;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/produtolote/{pedidoid}/{codproduto}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codproduto', pCodProduto.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetPedidoVolumeSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjPedidoVolume  : TPedidoVolume;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pPedidoId = 0) and (pPedidoVolumeId <> 0) then Begin

     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolumeseparacao/{pedidovolumeid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolumeseparacao/{pedidoid}/{pedidovolumeid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  End;
//  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.GetProducaoDiariaPorLoja(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/producaodiariaporloja?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    vResourceURI := vResourceURI+'&estruturaid='+pEstruturaId.ToString();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorRota(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/producaodiariaporrota?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    vResourceURI := vResourceURI+'&estruturaid='+pEstruturaId.ToString();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorRua(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/producaodiariaporrua?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    vResourceURI := vResourceURI+'&estruturaid='+pEstruturaId.ToString();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorSetor(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var vResourceURI : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/pedidovolume/producaodiariaporsetor?';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
    vResourceURI := vResourceURI+'&estruturaid='+pEstruturaId.ToString();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.MapaSeparacao(pPedidoId, pPedidoVolumeId: Integer): tJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/mapaseparacao/{pedidoid}/{pedidovolumeid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeDao.PrintEtiquetaPorRua(pJsonEtiqueta: TJsonObject): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonEtiqueta.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/etiquetaporrua';
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.RegistrarDocumentoEtapa(
  pDocumentoEtapaId: Integer): TJsonArray;
Var JsonDocumento : TJsonObject;
begin
  JsonDocumento := tJsonObject.Create;
  JsonDocumento.AddPair('pedidovolumeid', ObjPedidoVolume.PedidoVolumeId.ToString());
  JsonDocumento.AddPair('processoid', pDocumentoEtapaId.Tostring());
  JsonDocumento.AddPair('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
  JsonDocumento.AddPair('estacao', NomeDoComputador);
  DmeXactWMS.ResetRest; //Adicionado em 04/11/2022
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonDocumento.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/registrardocumentoetapa';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  FreeAndNil(JsonDocumento);
end;

function TPedidoVolumeDao.RegistrarDocumentoEtapaComBaixaEstoque(
  pDocumentoEtapaId, pOrigemCheckout: Integer): TJsonArray;
Var JsonDocumento : TJsonObject;
begin
  Try
    JsonDocumento := tJsonObject.Create;
    JsonDocumento.AddPair('pedidovolumeid', ObjPedidoVolume.PedidoVolumeId.ToString());
    JsonDocumento.AddPair('processoid', pDocumentoEtapaId.Tostring());
    JsonDocumento.AddPair('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
    JsonDocumento.AddPair('estacao', NomeDoComputador);
    JsonDocumento.AddPair('origemcheckout', TJsonNumber.Create(pOrigemCheckOut));

    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(jSonDocumento.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/registrardocumentoetapacombaixaestoque';
    DmeXactWMS.RESTRequestWMS.Method := rmPOST;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
    JsonDocumento.Free;
  Except On E: Exception do Begin
    JsonDocumento.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.RegistrarDocumentoEtapaSemBaixaEstoque(pDocumentoEtapaId, pOrigemCheckout: Integer): TJsonArray;
Var JsonDocumento : TJsonObject;
begin
  Try
    JsonDocumento := tJsonObject.Create;
    JsonDocumento.AddPair('pedidovolumeid', ObjPedidoVolume.PedidoVolumeId.ToString());
    JsonDocumento.AddPair('processoid', pDocumentoEtapaId.Tostring());
    JsonDocumento.AddPair('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
    JsonDocumento.AddPair('estacao', NomeDoComputador);
    JsonDocumento.AddPair('origemcheckout', TJsonNumber.Create(pOrigemCheckOut));
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(jSonDocumento.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/registrardocumentoetapasembaixaestoque';
    DmeXactWMS.RESTRequestWMS.Method := rmPOST;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
    JsonDocumento.Free;
  Except On E: Exception do Begin
    JsonDocumento.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.ResetSeparacao(pPedidoVolumeId: Integer): TjsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/resetseparacao/{pedidovolumeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

Function TPedidoVolumeDao.Salvar: tjsonObject;
Var jSonPedidoVolume : TJsonObject;
begin
  jSonPedidoVolume := tJson.ObjectToJsonObject(Self.FPedidoVolume);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPedidoVolume.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjPedidoVolume.PedidoVolumeId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('PedidoVolumeId', Self.FPedidoVolume.PedidoVolumeId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPedidoVolume);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.SalvarUltimoEnderecoColetado(pPedidoVolumeId,
  pEnderecoId: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/salvarultimoenderecocoletado/{pedidovolumeid}/{enderecoid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeDao.SalvarColetaComRegistro(pJsonColetaRegistro: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/salvarcoletacomregistro';
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonColetaRegistro.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create('SCCR001 - '+E.Message);
  End;
end;

function TPedidoVolumeDao.SaveApanheProduto(
  pJsonApanhe: TJsonArray): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/saveapanheprodutos';
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonApanhe.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeDao.VolumeExpedicao(pCodPessoaERP, pRotaId : Integer) : TjsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/expedicao/{codpessoaerp}/{rotaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codpessoaerp', pCodPessoaERP.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', pRotaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.VolumeExpedido: TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/expedido';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPedidoVolumeDao.VolumeExpedidoDia: TJsonArray;
begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/pedidovolume/expedidodia/{usuarioid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeDao.VolumeParaEtiquetas(pPedidoid, pPedidoVolumeId, pZonaId, pPrintTag, pEmbalagem : Integer): tjsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/volumeparaetiquetas/{pedidoid}/{pedidovolumeid}/{zonaid}/{printtag}/{embalagem}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pZonaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('printtag', pPrintTag.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('embalagem', pEmbalagem.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.

