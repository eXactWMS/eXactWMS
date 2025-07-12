{
   EnderecamentoRuaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EstoqueCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EstoqueClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TEstoqueCtrl = Class
  Private
    //Funções de Validação
    FObjEstoque      : TEstoque;
  Public
    constructor Create;
    Destructor Destroy;
    //Rotinas Pública (CRUD)
    Function VerificaDados(ObjEstoque : TEstoque) : Boolean;
    Function GetEstoque(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : TObjectList<TEstoque>;
    Function GetEstoqueJson(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : TJsonArray;
    Function GetEstoqueLotePorTipo(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : TJsonArray;
    function GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pZonaId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado,
      pNegativo: String; pShowErro: Integer; pOrdem : Integer): TJsonArray;
    Function GetEstoqueEnderecoPorTipo(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0; pEstoqueTipoId : Integer = 0;
                        pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : TJsonArray;
    Function GetEstoqueEnderecoPorTipoDetalhes(pProdutoId : Integer = 0; pEnderecoId : Integer = 0; pEstruturaId : Integer = 0;
                        pZonaId : Integer = 0; pEstoqueTipoId : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pPreVencido : Boolean = False; pVencido : Boolean = False; pShowErro : Integer = 1; pOrdem : Integer = 0) : TJsonArray;
    Function GetEstoqueSaldo(pProdutoId : Integer = 0; pEnderecoId : Integer = 0; pEstruturaId : Integer = 0;
                        pZonaId : Integer = 0; pEstoqueTipoId : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pPreVencido : Boolean = False; pVencido : Boolean = False; pShowErro : Integer = 1; pOrdem : Integer = 0) : TJsonArray;
    Function GetEstoquePreOrVencido(pCodProduto, pZonaId : Integer; pPreVencido, pVencido : Boolean; pDataInicial, pDataFinal : TDateTime) : TJsonArray;
    function GetRelEstoqueSemPicking(pProdutoId, pLoteId, pEnderecoId, pZonaId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado,
      pNegativo: String; pShowErro: Integer; pOrdem : Integer): TJsonArray;
    Function Salvar(pJsonEstoqueKardex : tJsonObject) : tjsonObject;  //(pHistorico: THistorico)
    Function DelEstoque : Boolean;
    Function GetListaMovimentacao(pUsuarioId : Integer; pDataInicial, pDataFinal : TDateTime; pCodigoERP : Integer; pTerminal, pOrigem, pDestino : String; pShowErro : Integer) : TJsonArray;
    Function GetMovimentacaoInterna(pCodProduto : Integer; pDataInicial, pDataFinal : TDate; pUsuarioId : Integer; pEnderecoOrigem, pEnderecoDestino : String; pArmazenagem, pMovInterna : Integer) : TjsonArray;
    Function GetEstoqueSemMovimentacao(pZonaId, pPeriodo, pCodProduto : Integer) : TjsonArray;
    Function GetListaTransferencia : TJsonArray;
    Function GetEstoqueProduto(pProdutoId, pCodProduto : Integer) : TJsonArray;
    Function GetMotivoMovimentacaoSegregado(pAtivo : Integer) : TJsonArray;
    Function ValidarMovimentacaoPallet(pProdutoId, pEnderecoId : Integer; pLote : String) : TJsonArray;
    Function GetControleArmazenagem(pDataInicial, pDataFinal : TDateTime; vCodProduto : Integer; pDocumentoNr : String; pEnderecoId, pUsuarioId, pTipoRelatorio : Integer) : TJsonArray;
    Function SalvarEstoqueChecklist(pJsonCheckList : TJsonObject) : TJsonArray;
    Function GetPulmaoTransferencia(pEnderecoId : Integer; pEndereco : String) : TJsonArray;
    Function PutPulmaoTransferencia(pEnderecoIdOrigem, pEnderecoIdDestino : Integer) : TJsonArray;
    Function GetEstoqueZona(pCodProduto, pZonaId, pCausaId : Integer) : TJsonArray;
    Function GetEstoqueReservaProduto(pCodProduto : Integer) : TJsonArray;

    Property ObjEstoque : TEstoque Read FObjEstoque Write FObjEstoque;
  End;

implementation

{ tCtrlEstoque }

uses EstoqueDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

function TEstoqueCtrl.ValidarMovimentacaoPallet(pProdutoId,
  pEnderecoId: Integer; pLote: String): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result := ObjEstoqueDAO.ValidarMovimentacaoPallet(pProdutoId, pEnderecoId, pLote);
  ObjEstoqueDAO.Free;
end;

Function tEstoqueCtrl.VerificaDados(ObjEstoque : TEstoque) : Boolean;
Begin
  Result := False;
  With ObjEstoque do Begin
    if EnderecoId = 0 then
       raise Exception.Create('Informe o endereço para armazenagem do Estoque!');
    if (LoteId <= 0) then
       raise Exception.Create('Informe o Lote do Estoque para armazenagem!');
    if (ProdutoId <= 0) then
       raise Exception.Create('Informe o Produto referente ao Estoque para armazenagem!');
  End;
  Result := True;
End;

function TEstoqueCtrl.GetControleArmazenagem(pDataInicial, pDataFinal: TDateTime;
  vCodProduto: Integer; pDocumentoNr: String; pEnderecoId,
  pUsuarioId, pTipoRelatorio : Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  Try
    ObjEstoqueDAO := TEstoqueDAO.Create;
    Try
      Result := ObjEstoqueDAO.GetControleArmazenagem(pDataInicial, pDataFinal,
                vCodProduto, pDocumentoNr, pEnderecoId, pUsuarioId, pTipoRelatorio);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    ObjEstoqueDAO.Free;
  End;
end;

constructor TEstoqueCtrl.Create;
begin
  Inherited;
  FObjEstoque      := TEstoque.Create;
end;

function TEstoqueCtrl.DelEstoque : Boolean;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  ObjEstoqueDAO.ObjEstoque.ProdutoId  := Self.ObjEstoque.ProdutoId;
  ObjEstoqueDAO.ObjEstoque.LoteId     := Self.ObjEstoque.LoteId;
  ObjEstoqueDAO.ObjEstoque.EnderecoId := Self.ObjEstoque.EnderecoId;
  Result := ObjEstoqueDAO.Delete;
  if Result then Begin
     Self.ObjEstoque.ProdutoId  := 0;
     Self.ObjEstoque.LoteId     := 0;
     Self.ObjEstoque.EnderecoId := 0;
  End;
  ObjEstoqueDAO.Free;
end;

destructor TEstoqueCtrl.Destroy;
begin
  FObjEstoque.Free;
  Inherited;
end;

Function tEstoqueCtrl.GetEstoque(pProdutoId : Integer = 0; pLoteId : Integer = 0; pEnderecoId : Integer = 0;
                                 pEstoqueTipoId : Integer = 0; pProducao : Integer = 0; pDistribuicao : Integer = 0; pZerado : String = 'S'; pNegativo : String = 'S'; pShowErro : Integer = 1) : TObjectList<TEstoque>;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
    xItensEstoque : Integer;
    ObjEst : TEstoque;
    vErro  : String;
begin
  Try
    ObjEstoqueDAO := TEstoqueDAO.Create;
    ReturnJson := ObjEstoqueDAO.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, pZerado, pNegativo, pShowErro);
  {
     if ReturnJson.Items[0].TryGetValue<String>('Erro', vErro) then Begin
        ObjEstoqueDAO := Nil;
        ObjEstoqueDAO.DisposeOf;
        //ReturnJson    := Nil;
        Raise Exception.Create('Estoque não encontrado!');
     End;
  }
    Result     := TObjectList<TEstoque>.Create;
    if Not ReturnJson.Items[0].TryGetValue<String>('Erro', vErro) then Begin
       For xItensEstoque := 0 To Pred(ReturnJson.Count) do Begin
  //       jsonEstoque := ReturnJson.Items[xItensEstoque] as TJSONObject;
         ObjEst := TEstoque.Create;
         ObjEst.ProdutoId := ReturnJson.Get(xItensEstoque).GetValue<Integer>('produtoid', 0);
         ObjEst.CodigoERP := ReturnJson.Get(xItensEstoque).GetValue<Integer>('codigoerp');
         ObjEst.Produto   := ReturnJson.Get(xItensEstoque).GetValue<String>('produto');
         ObjEst.UnidadeId := ReturnJson.Get(xItensEstoque).GetValue<Integer>('unidadeid');
         ObjEst.UnidadeSecundariaId := ReturnJson.Get(xItensEstoque).GetValue<Integer>('unidadedecundariaid');
         ObjEst.EmbPrim   := ReturnJson.Get(xItensEstoque).GetValue<String>('embprim');
         ObjEst.EmbSec    := ReturnJson.Get(xItensEstoque).GetValue<String>('embsec');
         ObjEst.QtdUnid   := ReturnJson.Get(xItensEstoque).GetValue<Integer>('qtdunid', 0);
         ObjEst.FatorConversao := ReturnJson.Get(xItensEstoque).GetValue<Integer>('fatorconversao', 0);
         ObjEst.MesSaidaMinima := ReturnJson.Get(xItensEstoque).GetValue<Integer>('messaidaminima', 0);
         ObjEst.LoteId      := ReturnJson.Get(xItensEstoque).GetValue<Integer>('loteid', 0);
         ObjEst.DescrLote   := ReturnJson.Get(xItensEstoque).GetValue<String>('descrlote');
         ObjEst.Fabricacao  := StrtoDate(ReturnJson.Get(xItensEstoque).GetValue<String>('fabricacao'));
         ObjEst.Vencimento  := StrToDate(ReturnJson.Get(xItensEstoque).GetValue<String>('vencimento'));
         ObjEst.EnderecoId  := ReturnJson.Get(xItensEstoque).GetValue<Integer>('enderecoid', 0);
         ObjEst.Endereco    := ReturnJson.Get(xItensEstoque).GetValue<String>('endereco');
         ObjEst.Estruturaid := ReturnJson.Get(xItensEstoque).GetValue<Integer>('estruturaid', 0);
         ObjEst.Estrutura   := ReturnJson.Get(xItensEstoque).GetValue<String>('estrutura');
         ObjEst.PickingFixo := ReturnJson.Get(xItensEstoque).GetValue<Integer>('pickingfixo', 0);
         ObjEst.Status      := ReturnJson.Get(xItensEstoque).GetValue<Integer>('status', 0);
         ObjEst.ZonaID      := ReturnJson.Get(xItensEstoque).GetValue<Integer>('zonaid', 0);
         ObjEst.Zona        := ReturnJson.Get(xItensEstoque).GetValue<String>('zona');
         ObjEst.QtdeProducao := ReturnJson.Get(xItensEstoque).GetValue<Integer>('qtdeproducao', 0);
         ObjEst.QtdeReserva  := ReturnJson.Get(xItensEstoque).GetValue<Integer>('qtdereserva', 0);
         ObjEst.Qtde         := ReturnJson.Get(xItensEstoque).GetValue<Integer>('qtde', 0);
         ObjEst.EstoqueTipoId := ReturnJson.Get(xItensEstoque).GetValue<Integer>('estoquetipoid', 0);
         ObjEst.EstoqueTipo   := ReturnJson.Get(xItensEstoque).GetValue<String>('estoquetipo');
         ObjEst.Producao      := ReturnJson.Get(xItensEstoque).GetValue<Integer>('producao', 0);
         ObjEst.Distribuicao  := ReturnJson.Get(xItensEstoque).GetValue<Integer>('distribuicao', 0);
         ObjEst.DtEntrada     := StrToDate(ReturnJson.Get(xItensEstoque).GetValue<String>('dtentrada'));
         ObjEst.HrEntrada     := StrToTime(ReturnJson.Get(xItensEstoque).GetValue<String>('hrentrada'));
         ObjEst.Horario       := StrToDateTime(ReturnJson.Get(xItensEstoque).GetValue<String>('horario'));
         ObjEst.UsuarioId     := ReturnJson.Get(xItensEstoque).GetValue<Integer>('usuarioid', 0);
         ObjEst.Ordem         := ReturnJson.Get(xItensEstoque).GetValue<Integer>('ordem', 0);
         ObjEst.Mascara       := ReturnJson.Get(xItensEstoque).GetValue<String>('mascara');
  //       ObjEstoque  := ObjEstoque.JsonToClass(JsonEstoque.ToString());
         Result.Add(ObjEst);
         //jsonEstoque := Nil;
         //jsonEstoque.DisposeOf;
       End;
    End
    Else if pShowErro = 1 then Begin
       ObjEstoqueDAO.Free;
       Raise Exception.Create('Estoque não encontrado!');
    End;
  Except On E: Exception do Begin
     ObjEstoqueDAO.Free;
     Raise Exception.Create(E.Message);
     End;
  End;
  ObjEstoqueDAO.Free;
End;

function TEstoqueCtrl.GetEstoqueEnderecoPorTipo(pProdutoId, pLoteId,
  pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String;
  pShowErro: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetEstoqueEnderecoPorTipo(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, pZerado, pNegativo, pShowErro);
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetEstoqueEnderecoPorTipoDetalhes(pProdutoId, pEnderecoId,
  pEstruturaId, pZonaId, pEstoqueTipoId : Integer; pZerado, pNegativo : String;
  pPreVencido : Boolean; pVencido : Boolean;  pShowErro: Integer; pOrdem : Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Try
    Try
      Result := ObjEstoqueDAO.GetEstoqueEnderecoPorTipoDetalhes(pProdutoId, pEnderecoId, pEstruturaId, pZonaId, pEstoqueTipoId, pZerado, pNegativo, pPreVencido, pVencido, pShowErro, pOrdem);
    Except on E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjEstoqueDAO);
  End;
end;

function TEstoqueCtrl.GetEstoqueJson(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String;  pShowErro: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result := ObjEstoqueDAO.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, pZerado, pNegativo, pShowErro);
  ObjEstoqueDAO.Free;
end;

Function TEstoqueCtrl.GetEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String;  pShowErro: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
    jsonEstoque   : tjsonObject;
    xItensEstoque : Integer;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, pZerado, pNegativo, pShowErro);
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetEstoquePreOrVencido(pCodProduto, pZonaId: Integer;
  pPreVencido, pVencido: Boolean; pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetEstoquePreOrVencido(pCodProduto, pZonaId, pPreVencido, pVencido, pDataInicial, pDataFinal);
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetEstoqueProduto(pProdutoId,
  pCodProduto: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  try
    ObjEstoqueDAO := TEstoqueDAO.Create;
    Result        := ObjEstoqueDAO.GetEstoqueProduto(pProdutoId, pCodProduto);
    ObjEstoqueDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  end;
end;

function TEstoqueCtrl.GetEstoqueReservaProduto(
  pCodProduto: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Try
    Try
      Result := ObjEstoqueDAO.GetEstoqueReservaProduto(pCodProduto);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjEstoqueDAO);
  End;
end;

Function TEstoqueCtrl.GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pZonaId,
  pEstoqueTipoId, pProducao, pDistribuicao : Integer; pZerado, pNegativo : String;  pShowErro: Integer; pOrdem : Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
    jsonEstoque   : tjsonObject;
    xItensEstoque : Integer;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Try
    Try
      Result := ObjEstoqueDAO.GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pZonaId,
                pEstoqueTipoId, pProducao, pDistribuicao, pZerado, pNegativo, pShowErro, pOrdem);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjEstoqueDAO);
  End;
end;

function TEstoqueCtrl.GetRelEstoqueSemPicking(pProdutoId, pLoteId, pEnderecoId,
  pZonaId, pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado,
  pNegativo: String; pShowErro, pOrdem: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
    jsonEstoque   : tjsonObject;
    xItensEstoque : Integer;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetRelEstoqueSemPicking(pProdutoId, pLoteId,
                   pEnderecoId, pZonaId, pEstoqueTipoId, pProducao, pDistribuicao,
                   pZerado, pNegativo, pShowErro, pOrdem);
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.PutPulmaoTransferencia(pEnderecoIdOrigem,
  pEnderecoIdDestino: Integer): TJsonArray;
Var ObjEstoqueCtrl : TEstoqueCtrl;
Var ObjEstoqueDAO : TEstoqueDAO;
Begin
  Try
    Try
      ObjEstoqueDAO := TEstoqueDAO.Create;
      ObjEstoqueDAO.ObjEstoque := ObjEstoque;
      Result := ObjEstoqueDAO.PutPulmaoTransferencia(pEnderecoIdOrigem, pEnderecoIdDestino);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjEstoqueDAO);
  End;
end;

function TEstoqueCtrl.GetEstoqueSaldo(pProdutoId, pEnderecoId, pEstruturaId, pZonaId, pEstoqueTipoId: Integer; pZerado, pNegativo: String; pPreVencido,
  pVencido: Boolean; pShowErro: Integer; pOrdem : Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetEstoqueSaldo(pProdutoId, pEnderecoId, pEstruturaId, pZonaId, pEstoqueTipoId, pZerado, pNegativo, pPreVencido, pVencido, pShowErro, pOrdem);
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetEstoqueSemMovimentacao(pZonaId, pPeriodo, pCodProduto: Integer): TjsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
    jsonEstoque   : tjsonObject;
    xItensEstoque : Integer;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetRelEstoqueSemMovimentacao(pZonaid, pPeriodo, pCodProduto);
  FreeAndNil(ObjEstoqueDAO);
end;

function TEstoqueCtrl.GetEstoqueZona(pCodProduto, pZonaId, pCausaId : Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  Try
    Try
      ObjEstoqueDAO := TEstoqueDAO.Create;
      Result := ObjEstoqueDAO.GetEstoqueZona(pCodProduto, pZonaId, pCausaId);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
   FreeAndNil(ObjEstoqueDAO);
  End;
end;

function TEstoqueCtrl.GetListaMovimentacao(pUsuarioId: Integer; pDataInicial,
  pDataFinal: TDateTime; pCodigoERP : Integer; pTerminal, pOrigem, pDestino : String; pShowErro : Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    vErro         : String;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result        := ObjEstoqueDAO.GetListaMovimentacao(pUsuarioId, pDataInicial, pDataFinal, pCodigoERP, pTerminal, pOrigem, pDestino);
  if (pShowErro = 1) and (Result.Items[0].TryGetValue<String>('Erro', vErro)) then
     raise Exception.Create('Erro: '+Result.Get(0).GetValue<String>('Erro'));
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetListaTransferencia: TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result := ObjEstoqueDAO.GetListaTransferencia;
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetMotivoMovimentacaoSegregado(
  pAtivo: Integer): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  Try
    ObjEstoqueDAO := TEstoqueDAO.Create;
    Result := ObjEstoqueDAO.GetMotivoMovimentacaoSegregado(pAtivo);
    ObjEstoqueDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEstoqueCtrl.GetMovimentacaoInterna(pCodProduto: Integer; pDataInicial,
  pDataFinal: TDate; pUsuarioId: Integer; pEnderecoOrigem, pEnderecoDestino : String; pArmazenagem, pMovInterna : Integer): TjsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
    ReturnJson    : TJsonArray;
begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  Result := ObjEstoqueDAO.GetMovimentacaoInterna(pCodProduto, pDataInicial, pDataFinal, pUsuarioId, pEnderecoOrigem, pEnderecoDestino, pArmazenagem, pMovInterna);
  ObjEstoqueDAO.Free;
end;

function TEstoqueCtrl.GetPulmaoTransferencia(pEnderecoId: Integer; pEndereco : String): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
Begin
  Try
    Try
      ObjEstoqueDAO := TEstoqueDAO.Create;
      ObjEstoqueDAO.ObjEstoque := ObjEstoque;
      Result := ObjEstoqueDAO.GetPulmaoTransferencia(pEnderecoId, pEndereco);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjEstoqueDAO);
  End;
end;

Function tEstoqueCtrl.Salvar(pJsonEstoqueKardex : tJsonObject) : tjsonObject;       //(pHistorico: THistorico)
Var ObjEstoqueDAO : TEstoqueDAO;
Begin
  ObjEstoqueDAO := TEstoqueDAO.Create;
  ObjEstoqueDAO.ObjEstoque := ObjEstoque;
  Result := ObjEstoqueDAO.Salvar(pJsonEstoqueKardex);
  ObjEstoqueDAO.Free;
End;

function TEstoqueCtrl.SalvarEstoqueChecklist(pJsonCheckList: TJsonObject): TJsonArray;
Var ObjEstoqueDAO : TEstoqueDAO;
begin
  Try
    ObjEstoqueDAO := TEstoqueDAO.Create;
    Result := ObjEstoqueDAO.SalvarEstoqueChecklist(pJsonCheckList);
    ObjEstoqueDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

End.
