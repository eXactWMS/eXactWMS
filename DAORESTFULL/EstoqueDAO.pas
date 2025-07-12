unit EstoqueDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EstoqueClass, System.JSON, REST.Json, Rest.Types;

Type

  TEstoqueDao = class
  private
    FEstoque : TEstoque;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetEstoque(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : tJsonArray;
    Function GetEstoqueLotePorTipo(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : tJsonArray;
    function GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pZonaId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado,
      pNegativo: String; pShowErro: Integer; pOrdem : Integer): tJsonArray;
    Function GetEstoqueEnderecoPorTipo(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S';
                        pNegativo : String = 'S'; pShowErro : Integer = 1) : tJsonArray;
    Function GetEstoqueEnderecoPorTipoDetalhes(pProdutoId, pEnderecoId,
                        pEstruturaId, pZonaId, pEstoqueTipoId : Integer; pZerado, pNegativo : String; pPreVencido, pVencido : Boolean; pShowErro: Integer; pOrdem : Integer = 0) : TJsonArray;
    Function GetEstoqueSaldo(pProdutoId, pEnderecoId,
                        pEstruturaId, pZonaId, pEstoqueTipoId : Integer; pZerado, pNegativo : String; pPreVencido, pVencido : Boolean; pShowErro: Integer; pOrdem : Integer = 0) : TJsonArray;
    Function GetRelEstoqueSemMovimentacao(pZonaId, pPeriodo, pCodProduto : Integer) : TJsonArray;
    Function GetRelEstoqueSemPicking(pProdutoId, pLoteId, pEnderecoId, pZonaId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado,
      pNegativo: String; pShowErro: Integer; pOrdem : Integer): tJsonArray;
    Function Salvar(pJsonEstoqueKardex : tJsonObject) : tjsonObject;
    function GetListaMovimentacao(pUsuarioId: Integer; pDataInicial, pDataFinal: TDateTime;
                                  pCodigoERP : Integer; pNomeEstacao, pOrigem, pDestino : String): TJsonArray;
    Function GetMovimentacaoInterna(pCodProduto: Integer; pDtInicio, pDtFinal: TDate; pUsuarioId: Integer; pEnderecoOrigem, pEnderecoDestino : String; pArmazenagem, pMovInterna : Integer): TjsonArray;
    Function GetListaTransferencia : TjsonArray;
    Function GetEstoqueProduto(pProdutoId, pCodProduto : Integer) : TJsonArray;
    Function GetMotivoMovimentacaoSegregado(pAtivo : Integer) : TJsonArray;
    Function ValidarMovimentacaoPallet(pProdutoId, pEnderecoId: Integer; pLote: String): TJsonArray;
    Function GetControleArmazenagem(pDataInicial, pDataFinal: TDateTime; pCodProduto: Integer;
             pDocumentoNr: String; pEnderecoId, pUsuarioId, pTipoRelatorio : Integer): TJsonArray;
    Function SalvarEstoqueChecklist(pJsonCheckList: TJsonObject): TJsonArray;
    Function GetEstoquePreOrVencido(pCodProduto, pZonaId: Integer; pPreVencido, pVencido: Boolean; pDataInicial, pDataFinal: TDateTime): TJsonArray;
    Function GetPulmaoTransferencia(pEnderecoId: Integer; pEndereco : String): TJsonArray;
    Function PutPulmaoTransferencia(pEnderecoIdOrigem, pEnderecoIdDestino: Integer): TJsonArray;
    Function GetEstoqueZona(pCodProduto, pZonaId, pCausaId : Integer): TJsonArray;
    Function GetEstoqueReservaProduto(pCodProduto: Integer): TJsonArray;

    Property ObjEstoque : TEstoque Read FEstoque Write FEstoque;
  end;

implementation

{ TLaboratorioDao }

uses uFrmeXactWMS, UDmeXactWMS;

function TEstoqueDao.GetControleArmazenagem(pDataInicial, pDataFinal: TDateTime;
  pCodProduto: Integer; pDocumentoNr: String; pEnderecoId,
  pUsuarioId, pTipoRelatorio : Integer): TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vDelimiter   := '?';
    DmeXactWMS.ResetRest;
    if pTipoRelatorio = 0 then
       vResourceURI := 'v1/estoque/controlearmazenagem'
    Else
       vResourceURI := 'v1/estoque/controlearmazenagem/sintetico';
    if pDataInicial <> 0 then begin
       vResourceURI := vResourceURI + vDelimiter + 'datainicial='+DateToStr(pDataInicial);
       vDelimiter := '&';
    End;
    if pDataFinal <> 0 then begin
       vResourceURI := vResourceURI + vDelimiter + 'datafinal='+DateToStr(pDataFinal);
       vDelimiter := '&';
    End;
    if pCodProduto <> 0 then begin
       vResourceURI := vResourceURI + vDelimiter + 'codproduto='+pCodProduto.ToString();
       vDelimiter := '&';
    End;
    if pDocumentoNr <> '' then begin
       vResourceURI := vResourceURI + vDelimiter + 'documentonr='+pDocumentoNr;
       vDelimiter := '&';
    End;
    if pEnderecoId <> 0 then begin
       vResourceURI := vResourceURI + vDelimiter + 'enderecoid='+pEnderecoId.ToString();
       vDelimiter := '&';
    End;
    if pUsuarioId <> 0 then begin
       vResourceURI := vResourceURI + vDelimiter + 'usuarioid='+pUsuarioId.ToString();
       vDelimiter := '&';
    End;
    vResourceURI := vResourceURI + vDelimiter + 'tipomovimentacao=1';
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

constructor TEstoqueDao.Create;
begin
  Self.FEstoque := TEstoque.Create;
end;

function TEstoqueDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/{loteid}/{enderecoid}/{estoquetipoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', Self.ObjEstoque.LoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', Self.ObjEstoque.EnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('estoquetipoid', Self.ObjEstoque.ProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('Erro: Não foi possível excluir o registro');
end;

function TEstoqueDao.GetEstoque(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjEstoque  : TEstoque;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/{produtoid}/{loteid}/{enderecoid}/{estoquetipoid}/{producao}/{distribuicao}/{zerado}/{negativo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('estoquetipoid', pEstoqueTipoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('producao', pProducao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('distribuicao', pDistribuicao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zerado',   pZerado);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('negativo', pNegativo);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray).Items[0].GetValue<String>('Erro'));
end;

function TEstoqueDao.GetEstoqueEnderecoPorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String;  pShowErro: Integer): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjEstoque  : TEstoque;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoqueenderecoportipo';
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoqueenderecoportipo/{produtoid}/{loteid}/{enderecoid}/{estoquetipoid}/{producao}/{distribuicao}/{zerado}/{negativo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('estoquetipoid', pEstoqueTipoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('producao', pProducao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('distribuicao', pDistribuicao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zerado',   pZerado);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('negativo', pNegativo);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEstoqueDao.GetEstoqueEnderecoPorTipoDetalhes(pProdutoId, pEnderecoId,
  pEstruturaId, pZonaId, pEstoqueTipoId : Integer; pZerado, pNegativo : String; pPreVencido, pVencido : Boolean; pShowErro: Integer; pOrdem : Integer): TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/estoqueenderecoportipodetalhes';
    vDelimiter   := '?';
    if pProdutoId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'produtoid='+pProdutoId.ToString();
       vDelimiter   := '&';
    End;
    if pEnderecoId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'enderecoid='+pEnderecoId.ToString();
       vDelimiter   := '&';
    End;
    if pEstruturaId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'estruturaid='+pEstruturaId.ToString();
       vDelimiter   := '&';
    End;
    if pZonaId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString();
       vDelimiter   := '&';
    End;
    if pEstoqueTipoId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'estoquetipoid='+pEstoqueTipoId.ToString();
       vDelimiter   := '&';
    End;
    if pPreVencido then Begin
       vResourceURI := vResourceURI+vDelimiter+'prevencido=1';
       vDelimiter   := '&';
    End;
    if pVencido then Begin
       vResourceURI := vResourceURI+vDelimiter+'vencido=1';
       vDelimiter   := '&';
    End;
    vResourceURI := vResourceURI+vDelimiter+'&ordem='+pOrdem.ToString();
    vDelimiter := '&';
    vResourceURI := vResourceURI+vDelimiter+'&zerado='+pZerado;
    vDelimiter := '&';
    vResourceURI := vResourceURI+vDelimiter+'&negativo='+pNegativo;
    vDelimiter := '&';
    vResourceURI := StringReplace(StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]), '&&', '&', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  End;
end;

function TEstoqueDao.GetEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String; pShowErro: Integer): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjEstoque  : TEstoque;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoqueloteportipo/{produtoid}/{loteid}/{enderecoid}/{estoquetipoid}/{producao}/{distribuicao}/{zerado}/{negativo}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
//  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pZonaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('estoquetipoid', pEstoqueTipoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('producao', pProducao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('distribuicao', pDistribuicao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zerado', pZerado);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('negativo', pNegativo);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else if pShowErro = 1 then
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEstoqueDao.GetEstoquePreOrVencido(pCodProduto, pZonaId: Integer;
  pPreVencido, pVencido: Boolean; pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/estoque/preorvencido';
    vDelimiter   := '?';    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/preorvencido';
    if pCodProduto <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'codproduto='+pCodProduto.ToString();
       vDelimiter   := '&';
    End;
    if pZonaId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString();
       vDelimiter   := '&';
    End;
    if pPrevencido then
       vResourceURI := vResourceURI+vDelimiter+'prevencido='+1.ToString()
    Else
       vResourceURI := vResourceURI+vDelimiter+'prevencido='+0.ToString();
    vDelimiter   := '&';
    if pDataInicial <> 0 then
       vResourceURI := vResourceURI+vDelimiter+'datainicial='+DateToStr(pDataInicial);
    if pDataFinal <> 0 then
       vResourceURI := vResourceURI+vDelimiter+'datafinal='+DateToStr(pDataFinal);
    if pvencido then
       vResourceURI := vResourceURI+vDelimiter+'vencido='+1.ToString()
    Else
       vResourceURI := vResourceURI+vDelimiter+'vencido='+0.ToString();
    vDelimiter   := '&';
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueDao.GetEstoqueProduto(pProdutoId,
  pCodProduto: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/produto?produtoid='+pProdutoId.ToString()+
                                          '&codproduto='+pCodProduto.ToString();
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueDao.GetEstoqueReservaProduto(pCodProduto: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoquereservaproduto/{codproduto}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codproduto', pCodProduto.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmGET;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except on E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TEstoqueDao.GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pZonaId,
  pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String; pShowErro: Integer; pOrdem : Integer): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjEstoque  : TEstoque;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/lote/{produtoid}/{loteid}/{enderecoid}/{zonaid}/{estoquetipoid}/{producao}/{distribuicao}/{zerado}/{negativo}/{ordem}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('loteid', pLoteId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pZonaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('estoquetipoid', pEstoqueTipoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('producao', pProducao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('distribuicao', pDistribuicao.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zerado', pZerado);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('negativo', pNegativo);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('ordem', pOrdem.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else if pShowErro = 1 then
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEstoqueDao.GetRelEstoqueSemMovimentacao(pZonaId, pPeriodo, pCodProduto : Integer): TJsonArray;
Var jSonObj      : tJsonObject;
    xItens       : Integer;
    ObjEstoque   : TEstoque;
    vDelimiter   : String;
    vResourceURI : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/semmovimentacao';
  vDelimiter   := '?';
  if pZonaId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString();
     vDelimiter   := '&';
  End
  Else Begin
     vResourceURI := vResourceURI+vDelimiter+'zonaid=0';
     vDelimiter   := '&';
  End;
  if pPeriodo >= 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'periodo='+pPeriodo.ToString();
     vDelimiter   := '&';
  End
  else Begin
     vResourceURI := vResourceURI+vDelimiter+'periodo=60';
     vDelimiter   := '&';
  End;
  if pCodProduto <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'codproduto='+pCodProduto.ToString();
     vDelimiter   := '&';
  End
  Else Begin
     vResourceURI := vResourceURI+vDelimiter+'codproduto=0';
     vDelimiter   := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

function TEstoqueDao.GetRelEstoqueSemPicking(pProdutoId, pLoteId, pEnderecoId,
  pZonaId, pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado,
  pNegativo: String; pShowErro, pOrdem: Integer): tJsonArray;
Var jSonObj      : tJsonObject;
    xItens       : Integer;
    ObjEstoque   : TEstoque;
    vDelimiter   : String;
    vResourceURI : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoquesempicking';
  vDelimiter   := '?';
  if pProdutoId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'produtoid='+pProdutoId.ToString();
     vDelimiter   := '&';
  End;
  if pLoteId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'loteid='+pLoteId.ToString();
     vDelimiter   := '&';
  End;
  if pEnderecoId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'enderecoid='+pEnderecoId.ToString();
     vDelimiter   := '&';
  End;
  if pZonaId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString();
     vDelimiter   := '&';
  End;
  if pEstoqueTipoId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'estoquetipoid='+pEstoqueTipoId.ToString();
     vDelimiter   := '&';
  End;
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('ordem', pOrdem.ToString());
  DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else if pShowErro = 1 then
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEstoqueDao.PutPulmaoTransferencia(pEnderecoIdOrigem,
  pEnderecoIdDestino: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/pulmaotransferencia/{enderecoidorigem}/{enderecoiddestino}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoidorigem', pEnderecoIdOrigem.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoiddestino', pEnderecoIdDestino.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except on E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TEstoqueDao.GetEstoqueSaldo(pProdutoId, pEnderecoId, pEstruturaId,
  pZonaId, pEstoqueTipoId: Integer; pZerado, pNegativo: String; pPreVencido,
  pVencido: Boolean; pShowErro: Integer; pOrdem : Integer): TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/estoque/saldo';
  vDelimiter   := '?';
  if pProdutoId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'produtoid='+pProdutoId.ToString();
     vDelimiter   := '&';
  End;
  if pEnderecoId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'enderecoid='+pEnderecoId.ToString();
     vDelimiter   := '&';
  End;
  if pEstruturaId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'estruturaid='+pEstruturaId.ToString();
     vDelimiter   := '&';
  End;
  if pZonaId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString();
     vDelimiter   := '&';
  End;
  if pEstoqueTipoId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'estoquetipoid='+pEstoqueTipoId.ToString();
     vDelimiter   := '&';
  End;
  if pPreVencido then Begin
     vResourceURI := vResourceURI+vDelimiter+'prevencido=1';
     vDelimiter   := '&';
  End;
  if pVencido then Begin
     vResourceURI := vResourceURI+vDelimiter+'vencido=1';
     vDelimiter   := '&';
  End;
  vResourceURI := vResourceURI+vDelimiter+'&zerado='+pZerado;
  vDelimiter := '&';
  vResourceURI := vResourceURI+vDelimiter+'&negativo='+pNegativo;
  vDelimiter := '&';
  vResourceURI := vResourceURI+vDelimiter+'&ordem='+pOrdem.ToString();
  vDelimiter := '&';
  vResourceURI := StringReplace(StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]), '&&', '&', [rfReplaceAll]);
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEstoqueDao.GetEstoqueZona(pCodProduto, pZonaId, pCausaId : Integer): TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/estoque/zona';
    vDelimiter   := '?';
    if pCodProduto <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'codproduto='+pCodProduto.ToString();
       vDelimiter   := '&';
    End;
    if pZonaId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString();
       vDelimiter   := '&';
    End;
    if pCausaId <> 0 then Begin
       vResourceURI := vResourceURI+vDelimiter+'causaid='+pCausaId.ToString();
       vDelimiter   := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueDao.GetListaMovimentacao(pUsuarioId: Integer; pDataInicial,
  pDataFinal: TDateTime; pCodigoERP : Integer; pNomeEstacao, pOrigem, pDestino : String) : TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/estoque/kardex';
  vDelimiter   := '?';
  if pUsuarioId <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'usuarioid='+pUsuarioId.ToString();
     vDelimiter   := '&';
  End;
  if pDataInicial <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'datainicial='+FormatDateTime('DD/MM/YYYY', pDataInicial);
     vDelimiter   := '&';
  End;
  if pDataFinal <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'datafinal='+FormatDateTime('DD/MM/YYYY', pDataFinal);
     vDelimiter   := '&';
  End;
  if pCodigoERP <> 0 then Begin
     vResourceURI := vResourceURI+vDelimiter+'codigoerp='+pCodigoERP.ToString();
     vDelimiter   := '&';
  End;
  if pNomeEstacao <> '' then Begin
     vResourceURI := vResourceURI+vDelimiter+'nomeestacao='+#39+pNomeEstacao+#39;
     vDelimiter   := '&';
  End;
  if pOrigem <> '' then Begin
     vResourceURI := vResourceURI+vDelimiter+'origem='+pOrigem;
     vDelimiter   := '&';
  End;
  if pDestino <> '' then Begin
     vResourceURI := vResourceURI+vDelimiter+'destino='+pDestino;
     vDelimiter   := '&';
  End;

  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEstoqueDao.GetListaTransferencia: TjsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/listatransferencia';
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
  End;
end;

function TEstoqueDao.GetMotivoMovimentacaoSegregado(pAtivo: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/motivomovimentacaosegregado/{ativo}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('ativo', pAtivo.ToString());
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueDao.GetMovimentacaoInterna(pCodProduto: Integer; pDtInicio,
  pDtFinal: TDate; pUsuarioId: Integer; pEnderecoOrigem, pEnderecoDestino : String; pArmazenagem, pMovInterna : Integer): TjsonArray;
Var vLim : String;
begin
  Try
    vLim := '?';
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Timeout := 120000;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/movimentacaointerna';
    if pDtInicio<>0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'datainicial='+DateToStr(pDtInicio);
       vLim := '&';
    End;
    if pDtFinal<>0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'datafinal='+DateToStr(pDtFinal);
       vLim := '&';
    End;
    if pCodProduto <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'codproduto='+pCodProduto.ToString;
       vLim := '&';
    end;
    if pUsuarioId <> 0 then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'usuarioid='+pUsuarioId.ToString;
       vLim := '&';
    end;
    if pEnderecoOrigem <> '' then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'enderecoorigem='+pEnderecoOrigem;
       vLim := '&';
    end;
    if pEnderecoDestino <> '' then begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'enderecodestino='+pEnderecoDestino;
       vLim := '&';
    end;
    DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'armazenagem='+pArmazenagem.ToString;
    DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&movinterna='+pMovInterna.ToString;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
    End;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueDao.GetPulmaoTransferencia(pEnderecoId: Integer; pEndereco : String): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/pulmaotransferencia/{enderecoid}/{endereco}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('endereco',   pEndereco);
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
end;

Function TEstoqueDao.Salvar(pJsonEstoqueKardex : tJsonObject) : tjsonObject;
//Var jSonEstoque : TJsonObject;
begin
  //jSonEstoque := tJson.ObjectToJsonObject(Self.FEstoque);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonEstoqueKardex.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque';
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  //FreeAndNil(jSonEstoque);
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
end;

function TEstoqueDao.SalvarEstoqueChecklist(pJsonCheckList: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonCheckList.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/checklist';
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueDao.ValidarMovimentacaoPallet(pProdutoId, pEnderecoId: Integer;
  pLote: String): TJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/estoque/validarmovimentacaopallet'+
                                          '?enderecoid='+pEnderecoId.Tostring+
                                          '&produtoid='+pProdutoId.Tostring+
                                          '&lote='+pLote;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

end.
