{
   PedidoSaidaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit PedidoSaidaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     PedidoSaidaClass, Rest.Json, System.Json, Rest.Types, PedidoProdutoCtrl, System.Generics.Collections;

Type
  TipoConsulta = (Resumida, Completa);

  TPedidoSaidaCtrl = Class
  Private
    //Funções de Validação
    FPedidoSaida      : TPedidoSaida;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function CancelarPedidoSaida(pJsonPedidoCancelar : TJsonObject) : Boolean;
    Function VerificaDados(ObjPedidoSaida : TPedidoSaida) : Boolean;
    Function GetPedido(pPedidoId : Integer = 0; pshowErro : Integer = 0) : TJsonArray;
    Function GetPedidoSaida(pPedidoId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = ''; pShowErro : Integer = 1) : TObjectList<TPedidoSaidaCtrl>;
    Function GetPedidoPendente : TObjectList<TPedidoSaidaCtrl>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function DelPedidoSaida(pJsonArrayPedido : TJsonArray) : TJsonArray;
    Function PedidoParaProcessamento(pPedidoId: Integer; pCodigoERP : Integer; pDataIni, pDataFin : TDateTime;
                                     pProcessoId, pRotaId, pRotaIdFinal, pZonaId : Integer; pRecebido, pCubagem, pEtiqueta : Integer)  : TJsonArray;
    Function PedidoProcessar(pPedidoId: int64; pCodigoERP, pPessoaId : int64; pDataIni, pDataFin : TDateTime;
                             pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pRotaIdFinal, pZonaId : Int64; pProcessoId : Integer; pRecebido,
                             pCubagem, pEtiqueta : Integer; pProcessar : Boolean; pMontarCarga : Integer; pCodProduto : Int64;
                             pPedidoPendente : Integer; pCargaId : Int64; pNotaFiscalERP : String; pPrintTag, pEmbalagem : Integer) : TJsonArray;
    Function PedidoParaCargas(pPedidoId: Integer; pCodigoERP, pPessoaId : Integer; pDataIni, pDataFin : TDateTime;
                             pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pRotaIdFinal, pZonaId, pMontarCarga : Integer; pCargaId : Integer) : TJsonArray;
    Function PedidoPrintTag(pPedidoId, pPedidoVolumeId : Integer; pCodigoERP, pPessoaId : Integer; pDataIni, pDataFin : TDateTime;
                             pRazao : String; pRotaId, pRotaIdFinal, pZonaId, pPrintTag, pEmbalagem : Integer) : TJsonArray;
    Function PedidoProdutoSemPicking(pPedidoId: Integer; pCodigoERP, pPessoaId : Integer; pDataIni, pDataFin : TDateTime;
                             pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pProcessoId : Integer; pRecebido,
                             pCubagem, pEtiqueta : Integer; pProcessar, pVerificarEstoque : Boolean) : TJsonArray;
    Function GetPedidoResumoAtendimento(pPedidoId : Integer = 0; pDivergencia : Integer = 0; pDataInicial : TDate = 0; pDataFinal : TDate = 0) : TJsonArray;
    Function GetClientesRotaCarga(pPessoaId : Integer; pRazao : String; pDataIni, pDataFin : TDateTime;
                             pRotaId, pProcessoId : Integer) : TJsonArray;
    Function GerarVolume(pjsonVolume : TJsonArray; pTipoVolume : String) : tJsonArray;
    Function PedidoCubagem(pPedidoId : Integer) : tjsonArray; //Caixa Fechada
    Function PedidoCubagemVolume_CaixaFracionada(pPedidoId: Integer) : tjsonArray; //Caixa Fracionada
    Function Pedido_CancelarCubagem(pPedidoId: Integer) : tJsonArray;
    Function MontarPaginacao : Integer;
    Function GetProdutoReposicao(pData : TDateTime; pShowErro : Integer) : TJsonArray;
    Function GetRelRupturaAbastecimento(pDataInicial, pDataFinal : TDateTime) : TJsonArray;
    Function GetRelColetaPulmao(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId, pZonaId : Integer) : TJsonArray;
    Function GetRelApanhePicking(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId : Integer) : TJsonArray;
    Function GetRelAnaliseRessuprimento(aParams : TDictionary<String, String>; pVolume : Boolean) : TJsonArray;
    Function GetReposicaoGerar(pData :  TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String) : TJsonArray;
    Function GetReposicaoDemanda(pDataPedido :  TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal, pTipoGeracao : String) : TJsonArray; //pTipoGeracao: <A>utomática  <M>anual
    Function GetReposicaoDemandaCapacidade(pPercDownMaxPicking, pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String; pNegativo : Integer) : TJsonArray;
    Function GetReposicaoDemandaColeta(pTipoGeracao : String) : TJsonArray;
    Function GetReposicaoEnderecoColeta(pData :  TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String) : TJsonArray;
    Function SalvarReposicao(pJsonReposicao :TJsonObject) : Boolean;
    Function GetReposicaoModelo(pModeloId : Integer) : TJsonArray;
    function SalvarReposicaoModelo(pJsonReposicao: TJsonObject): Boolean;
    Function DeleteReposicaoModelo(pModeloId : Integer) : TJsonArray;
    Function GetDashBoard0102(pDtInicio, pDtTermino : TDate) : TJsonObject;
    Function GetDashBoard030405(pDtInicio, pDtTermino : TDate) : TJsonArray;
    Function GetDashBoard06(pDtInicio, pDtTermino : TDate) : TJsonArray;
    Function GetResumoProducao(pDtInicio, pDtTermino : TDate; pProcessoId : Integer; pUsuarioId : Integer; pDtPedidoIni, pDtPedidoFin : TDate) : TJsonArray;
    Function GetCortes(pDataIni, pDataFin : TDateTime; pPedidoId, pCodProduto : Integer; pSintetico, pZonaId, pCodPessoaERP, pRotaId : Integer; pDocumentoNr : String) : TJsonArray;
    Function GetMovimentacao(pPedidoId: Integer; pDataInicio, pDataFinal: TDateTime; pProdutoId: Integer): TJsonArray;
    Function GetEvolucaoAtendimentoPed(aParams : TDictionary<String, String>) : TJsonArray;
    Function GetEvolucaoAtendimentoUnid(aParams : TDictionary<String, String>) : TJsonArray;
    Function GetEvolucaoAtendimentoUnidZona(aParams : TDictionary<String, String>) : TJsonArray;
    Function GetEvolucaoAtendimentoVol(aParams : TDictionary<String, String>) : TJsonArray;
    Function GetEvolucaoAtendimentoUnidEmbalagem(aParams : TDictionary<String, String>; pTipo : String) : TJsonArray;  //Unid-Uniades Vol-Volumes
    Function DeleteReservaCorrecao : TjsonArray;
    Function GetPedidoProcesso(pPedidoId : Integer) : TjsonArray;
    Function GetReposicaoAutomatica(pDataReposicao : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String; pStatus : Integer) : TJsonArray;
    Function GetReposicaoAutomaticaColeta(pDataReposicao : TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String; pStatus : Integer) : TJsonArray;
    Function GetConsultaReposicao(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId, pPendente, pUsuarioId : Integer) : TJsonArray;
    Function GetConsultaReposicaoProduto(pReposicaoId : Integer) : TJsonArray;
    Function PutReposicaoFinalizar(pJsonObject : TJsonObject) : TJsonArray;
    Function ReposicaoTransferenciaPicking(PJsonTransferencia : TjsonObject) : TjsonArray;
    Function reposicaoSalvarItemColetado(pJsonColeta : TJsonArray) : Boolean;
    Function reposicaoFinalizar(pJsonColeta : TJsonArray) : Boolean;
    Function GetAuditoriaSaidaPorProduto(pDataInicial, pDataFinal : TDateTime; pPedidoId : Integer;
                                         pRessuprimento : String; pCodProduto : Integer; pDescrLote : String) : TJsonArray;
    Function GetSaidaPorProdutoBalanceamento(pDataInicio, pDataTermino : TDateTime; pZonaId : integer) : TJsonArray;
    Function GetReposicaoHistorico(pJsonArray : TjsonArray) : TJsonArray;
    Function GetAnaliseColeta(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                              pPendente : Integer; pUsuarioId : Integer; pModeloReport : String; pDivergencia, pNaoColetado : Integer; pCodProduto : Integer; pZonaId : Integer) : TJsonArray;
    Function RelReposicaoTransfPicking(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                                       pPendente : Integer; pUsuarioId : Integer; pModeloReport : String; pCodProduto : Integer; pZonaId : Integer) : TJsonArray;
    Function GetRelHistoricoTransferenciaPicking(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                                       pPendente : Integer; pUsuarioId : Integer; pModeloReport : String; pCodProduto : Integer; pZonaId : Integer) : TJsonArray;
    Function GetReposicaoColetaProdutividade(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId,
                                       pPendente : Integer; pUsuarioId : Integer; pCodProduto : Integer; pZonaId : Integer) : TJsonArray;
    Function ReposicaoCancelar(pJsonObjectReposicao : TJsonObject) : TJsonArray;
    Function ReposicaoExcluir(pJsonObjectExcluir : TJsonObject) : TJsonArray;
    Function ReposicaoRegistrarInUse(pReposicaoId, pUsuarioId : Integer) : TJsonArray;
    Function PutRegistrarProcesso(pPedidoId, pProcessoId : Integer) : TJsonArray;
    Function GetMotivoExclusaoPedido : TJsonArray;
    Function GetDashProducaoDiaria(pDataInicial, pDataFinal : TDateTime) : TJsonArray;
    Function GetDashProducaoDiariaZona(pDataInicial, pDataFinal : TDateTime) : TJsonArray;
    Function AtualizarProcesso(pPedidoId : Integer) : TJsonArray;

    Property PedidoSaida : TPedidoSaida Read FPedidoSaida Write FPedidoSaida;

  End;

implementation

{ tCtrlPedidoSaida }

uses uPedidoSaidaDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

function TPedidoSaidaCtrl.GetDashBoard0102(pDtInicio,
  pDtTermino: TDate): TJsonObject;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetDashBoard0102(pDtInicio, pDtTermino);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonObject.Create.AddPair('Erro', E.Message);
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetAnaliseColeta(pDataInicial, pDataFinal : TDateTime;
  pReposicaoId, pProcessoId, pPendente, pUsuarioId: Integer; pModeloReport: String; pDivergencia,
  pNaoColetado : Integer; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetAnaliseColeta(pDataInicial, pDataFinal, pReposicaoId, pProcessoId,
              pPendente, pUsuarioId, pModeloReport, pDivergencia, pNaoColetado, pCodProduto, pZonaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetAuditoriaSaidaPorProduto(pDataInicial,
  pDataFinal: TDateTime; pPedidoId: Integer; pRessuprimento: String;
  pCodProduto: Integer; pDescrLote: String) : TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetAuditoriaSaidaPorProduto(pDataInicial,
              pDataFinal, pPedidoId, pRessuprimento, pCodProduto, pDescrLote);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetClientesRotaCarga(pPessoaId: Integer; pRazao : String; pDataIni,
  pDataFin: TDateTime; pRotaId, pProcessoId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetClientesRotaCarga(pPessoaId, pRazao, pDataIni, pDataFin, pRotaId, pProcessoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetCortes(pDataIni, pDataFin: TDateTime; pPedidoId,
  pCodProduto : Integer; pSintetico, pZonaId, pCodPessoaERP, pRotaId : Integer; pDocumentoNr : String): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetCortes(pDataIni, pDataFin, pPedidoId, pCodProduto, pSintetico, pZonaId, pCodPessoaERP, pRotaId, pDocumentoNr);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

Function tPedidoSaidaCtrl.VerificaDados(ObjPedidoSaida : TPedidoSaida) : Boolean;
Begin
  Result := False;
  With ObjPedidoSaida do Begin
    if OperacaoTipo.OperacaoTipoId = 0 then
       raise Exception.Create('Informe o Tipo da Operação!');
    if (Pessoa.PessoaId = 0) then
       raise Exception.Create('Informe o fornecedor!');
  End;
  Result := True;
End;

function TPedidoSaidaCtrl.AtualizarProcesso(pPedidoId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Try
      Result := ObjPedidoSaidaDAO.AtualizarProcesso(pPedidoId);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      ObjPedidoSaidaDAO.Free;
      End;
    End;
  Finally
    FreeANdNil(ObjPedidoSaidaDAO);
  End;
end;

function TPedidoSaidaCtrl.CancelarPedidoSaida(pJsonPedidoCancelar : TJsonObject): Boolean;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Result := False;
  ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Result := ObjPedidoSaidaDAO.CancelarPedidoSaida(pJsonPedidoCancelar);
  if Result then
     Self.PedidoSaida.PedidoId := 0;
  ObjPedidoSaidaDAO.Free;
end;

constructor TPedidoSaidaCtrl.Create;
begin
  FPedidoSaida      := TPedidoSaida.Create;
end;

function TPedidoSaidaCtrl.DeleteReposicaoModelo(pModeloId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.DeleteReposicaoModelo(pModeloId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.DeleteReservaCorrecao : TjsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.DeleteReservaCorrecao;
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.DelPedidoSaida(pJsonArrayPedido : TJsonArray) : TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Result := ObjPedidoSaidaDAO.Delete(pJsonArrayPedido);
  ObjPedidoSaidaDAO.Free;
end;

destructor TPedidoSaidaCtrl.Destroy;
begin
  FPedidoSaida.Free;
  inherited;
end;

function TPedidoSaidaCtrl.GerarVolume(pjsonVolume : TJsonArray; pTipoVolume : String): tJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GerarVolume(pjsonVolume, pTipoVolume);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

Function TPedidoSaidaCtrl.GetDashBoard030405(pDtInicio,
  pDtTermino: TDate): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetDashBoard030405(pDtInicio, pDtTermino);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetDashBoard06(pDtInicio, pDtTermino: TDate): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetDashBoard06(pDtInicio, pDtTermino);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    ObjPedidoSaidaDAO.Free;
  End;
end;

function TPedidoSaidaCtrl.GetDashProducaoDiaria(pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetDashProducaoDiaria(pDataInicial, pDataFinal);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    ObjPedidoSaidaDAO.Free;
  End;
end;

function TPedidoSaidaCtrl.GetDashProducaoDiariaZona(pDataInicial,
  pDataFinal: TDateTime): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetDashProducaoDiariaZona(pDataInicial, pDataFinal);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    ObjPedidoSaidaDAO.Free;
  End;
end;

function TPedidoSaidaCtrl.GetEvolucaoAtendimentoPed(
  aParams: TDictionary<String, String>): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetEvolucaoAtendimentoPed(aParams);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetEvolucaoAtendimentoUnid(aParams: TDictionary<String, String>): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetEvolucaoAtendimentoUnid(aParams);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidZona(aParams: TDictionary<String, String>): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetEvolucaoAtendimentoUnidZona(aParams);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetEvolucaoAtendimentoVol(aParams: TDictionary<String, String>): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetEvolucaoAtendimentoVol(aParams);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetMotivoExclusaoPedido: TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetMotivoExclusaoPedido;
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    ObjPedidoSaidaDAO.Free;
  End;
end;

function TPedidoSaidaCtrl.GetEvolucaoAtendimentoUnidEmbalagem(
  aParams: TDictionary<String, String>; pTipo : String): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetEvolucaoAtendimentoUnidEmbalagem(aParams, pTipo);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetMovimentacao(pPedidoId: Integer; pDataInicio,
  pDataFinal: TDateTime; pProdutoId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetMovimentacao(pPedidoId, pDataInicio, pDataFinal, pProdutoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetPedido(pPedidoId, pshowErro: Integer): TJsonArray;
begin
  Result := PedidoProcessar(pPedidoId, 0, 0, 0, 0, '', '', '', 0, 0, 0, 0, 0, 0, 0,
            False, 2, 0, 0, 0, '', 2, 2);
end;

function TPedidoSaidaCtrl.GetPedidoPendente: TObjectList<TPedidoSaidaCtrl>;
Var ReturnJson  : TJsonArray;
    JsonPedidoSaida : TJsonObject;
    xItens      : Integer;
    ObjPedidoSaidaCtrl  : TPedidoSaidaCtrl;
    Var ObjPedidoSaidaDAO    : TPedidoSaidaDAO;
begin
  Try
    Result     := TObjectList<TPedidoSaidaCtrl>.Create;

    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    //ObjPedidoSaidaDAO.PedidoSaida.PedidoId := Self.PedidoSaida.PedidoId;
    ReturnJson := ObjPedidoSaidaDAO.GetPedidoPendente;
    ObjPedidoSaidaDAO.Free;
    if ReturnJson.Count >= 1 then Begin
       xItens := 0;
       repeat
         ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
         JsonPedidoSaida    := tJsonObject.Create;
         JsonPedidoSaida    := ReturnJson.Items[xItens] as TJSONObject;
         ObjPedidoSaidaCtrl.FPedidoSaida := Self.FPedidoSaida.JsonToClass(JsonPedidoSaida.ToString());
         Result.Add(ObjPedidoSaidaCtrl);
         JsonPedidoSaida.Free;
         ObjPedidoSaidaCtrl .Free;
         xItens := xItens + 1;
       until (xItens > Pred(ReturnJson.Count));
    End
    Else Raise Exception.Create('Não foram encontrado Pedido(s) Pendente!');
  Except ON E: Exception do Begin
    Raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.GetPedidoProcesso(pPedidoId: Integer): TjsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
Begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetPedidoProcesso(pPedidoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

Function tPedidoSaidaCtrl.GetPedidoSaida(pPedidoId : Integer = 0; pPessoaId : Integer = 0;
                                  pDocumentoNr : String = ''; pShowErro : Integer = 1): TObjectList<TPedidoSaidaCtrl>;
Var ReturnJson  : TJsonArray;
    JsonPedidoSaida : TJsonObject;
    xItens      : Integer;
    ObjPedidoSaidaCtrl  : TPedidoSaidaCtrl;
    Var ObjPedidoSaidaDAO    : TPedidoSaidaDAO;
begin
  Try
    Result     := TObjectList<TPedidoSaidaCtrl>.Create;

    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    //ObjPedidoSaidaDAO.PedidoSaida.PedidoId := Self.PedidoSaida.PedidoId;
    ReturnJson := ObjPedidoSaidaDAO.GetPedidoSaida(pPedidoId, pPessoaId, pDocumentoNr, pShowErro);
    ObjPedidoSaidaDAO.Free;
    if ReturnJson.Count >= 1 then Begin
       xItens := 0;
       repeat
         ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
         JsonPedidoSaida    := tJsonObject.Create;
         JsonPedidoSaida    := ReturnJson.Items[xItens] as TJSONObject;
         ObjPedidoSaidaCtrl.FPedidoSaida    := Self.FPedidoSaida.JsonToClass(JsonPedidoSaida.ToString());
         Result.Add(ObjPedidoSaidaCtrl);
         JsonPedidoSaida.Free;
         ObjPedidoSaidaCtrl.Free;
         xItens := xItens + 1;
       until (xItens > Pred(ReturnJson.Count));
    End
    Else Raise Exception.Create('Pedido(s) não encontrado!');
  Except On E: Exception do
    raise Exception.Create('Err: '+E.Message);
  End;
End;

function TPedidoSaidaCtrl.GetProdutoReposicao(pData: TDateTime;
  pShowErro: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetProdutoResposicao(pData);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetRelAnaliseRessuprimento(
  aParams: TDictionary<String, String>; pVolume : Boolean): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetRelAnaliseRessuprimento(aParams, pVolume);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.GetRelApanhePicking(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId : Integer) : TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetRelApanhePicking(pDataInicio, pDataFinal, pCodPessoaERP, pRotaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetRelColetaPulmao(pDataInicio, pDataFinal : TDateTime; pCodPessoaERP : Integer; pRotaId,pZonaId : Integer) : TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetRelColetaPulmao(pDataInicio, pDataFinal, pCodPessoaERP, pRotaId, pZonaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetRelHistoricoTransferenciaPicking(pDataInicial,
  pDataFinal: TDateTime; pReposicaoId, pProcessoId, pPendente,
  pUsuarioId: Integer; pModeloReport: String; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetRelHistoricoTransferenciaPicking(pDataInicial, pDataFinal, pReposicaoId, pProcessoId,
              pPendente, pUsuarioId, pModeloReport, pCodProduto, pZonaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetRelRupturaAbastecimento(pDataInicial, pDataFinal : TDateTime) : TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetRelRupturaAbastecimento(pDataInicial, pDataFinal);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjPedidoSaidaDAO);
  End;
end;

Function TPedidoSaidaCtrl.GetReposicaoAutomatica(pDataReposicao: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String;
  pStatus: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetReposicaoAutomatica(pDataReposicao, pZonaId, pEnderecoInicial, pEnderecoFinal, pStatus);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjPedidoSaidaDAO);
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoAutomaticaColeta(
  pDataReposicao: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String; pStatus: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetReposicaoAutomaticaColeta(pDataReposicao, pZonaId, pEnderecoInicial, pEnderecoFinal, pStatus);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjPedidoSaidaDAO);
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoColetaProdutividade(pDataInicial,
  pDataFinal: TDateTime; pReposicaoId, pProcessoId, pPendente,
  pUsuarioId: Integer; pCodProduto, pZonaId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoColetaProdutividade(pDataInicial, pDataFinal, pReposicaoId, pProcessoId,
              pPendente, pUsuarioId, pCodProduto, pZonaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    FreeAndNil(ObjPedidoSaidaDAO);
    End;
  End;

end;

function TPedidoSaidaCtrl.GetReposicaoDemanda(pDataPedido: TDateTime;
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal, pTipoGeracao: String): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetReposicaoDemanda(pDataPedido, pZonaId, pEnderecoInicial, pEnderecoFinal, pTipoGeracao);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    ObjPedidoSaidaDAO.Free;
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoDemandaCapacidade(
  pPercDownMaxPicking, pZonaId : Integer; pEnderecoInicial, pEnderecoFinal: String;
  pNegativo: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoDemandaCapacidade(pPercDownMaxPicking, pZonaId, pEnderecoInicial, pEnderecoFinal, pNegativo);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoDemandaColeta(pTipoGeracao : String): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoDemandaColeta(pTipoGeracao);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

Function TPedidoSaidaCtrl.GetConsultaReposicao(pDataInicial, pDataFinal : TDateTime; pReposicaoId, pProcessoId, pPendente, pUsuarioId : Integer) : TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetConsultaReposicao(pDataInicial, pDataFinal, pReposicaoId, pProcessoId, pPendente, pUsuarioId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetConsultaReposicaoProduto(
  pReposicaoId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoProduto(pReposicaoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoEnderecoColeta(
  pData: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoEnderecoColeta(pData, pZonaId, pEnderecoInicial, pEnderecoFinal);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
End;

function TPedidoSaidaCtrl.GetReposicaoGerar(pData: TDateTime; pZonaId : Integer; pEnderecoInicial, pEnderecoFinal : String): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoGerar(pData, pZonaId, pEnderecoInicial, pEnderecoFinal);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoHistorico(
  pJsonArray: TjsonArray): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoHistorico( pJsonArray );
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetReposicaoModelo(pModeloId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetReposicaoModelo(pModeloId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetResumoProducao(pDtInicio, pDtTermino: TDate;
  pProcessoId, pUsuarioId: Integer; pDtPedidoIni, pDtPedidoFin : TDate): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.GetResumoProducao(pDtInicio, pDtTermino, pProcessoId, pUsuarioId, pDtPedidoIni, pDtPedidoFin);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetSaidaPorProdutoBalanceamento(pDataInicio, pDataTermino: TDateTime; pZonaId: integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      Result := ObjPedidoSaidaDAO.GetSaidaPorProdutoBalanceamento(pDataInicio, pDataTermino, pZonaId);
    Except ON E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjPedidoSaidaDAO);
  End;
end;

function TPedidoSaidaCtrl.MontarPaginacao: Integer;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.MontarPaginacao.GetValue<integer>('paginacao', 1);;
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoCubagem(pPedidoId: Integer): tjsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoCubagem(pPedidoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoCubagemVolume_CaixaFracionada(
  pPedidoId: Integer): tjsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoCubagemVolume_CaixaFracionada(pPedidoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoParaCargas(pPedidoId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pDocumentoNr, pRazao,
  pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId, pMontarCarga,
  pCargaId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoParaCargas(pPedidoId, pCodigoERP, pPessoaId, pDataIni, pDataFin, pDocumentoNr,
                                pRazao, pRegistroERP, pRotaId, pRotaIdFinal, pZonaId, pMontarCarga, pCargaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoParaProcessamento(pPedidoId, pCodigoERP : Integer;
         pDataIni, pDataFin: TDateTime; pProcessoId, pRotaId, pRotaIdFinal, pZonaId, pRecebido, pCubagem, pEtiqueta: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoParaProcessamento(pPedidoId, pCodigoERP, pDataIni,
              pDataFin, pProcessoId, pRotaId, pRotaIdFinal, pZonaId, pRecebido, pCubagem, pEtiqueta);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoPrintTag(pPedidoId, pPedidoVolumeId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pRazao: String; pRotaId,
  pRotaIdFinal, pZonaId, pPrintTag, pEmbalagem: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoPrintTag(pPedidoId, pPedidoVolumeId, pCodigoERP, pPessoaId, pDataIni, pDataFin,
                                pRazao, pRotaId, pRotaIdFinal, pZonaId, pPrintTag, pEmbalagem);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoProcessar(pPedidoId: Int64; pCodigoERP, pPessoaId : Int64; pDataIni, pDataFin : TDateTime;
                           pDocumentoNr, pRazao, pRegistroERP : String; pRotaId, pRotaIdFinal, pZonaId : Int64; pProcessoId : Integer; pRecebido, pCubagem, pEtiqueta : Integer;
                           pProcessar : Boolean; pMontarCarga : Integer; pCodProduto : Int64; pPedidoPendente : Integer; pCargaId : Int64; pNotaFiscalERP : String; pPrintTag, pEmbalagem : Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoProcessar(pPedidoId, pCodigoERP, pPessoaId, pDataIni, pDataFin, pDocumentoNr,
                                pRazao, pRegistroERP, pRotaId, pRotaIdFinal, pZonaId, pProcessoId, pRecebido, pCubagem, pEtiqueta,
                                pProcessar, pMontarCarga, pCodProduto, pPedidoPendente, pCargaId, pNotaFiscalERP, pPrintTag, pEmbalagem);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PedidoProdutoSemPicking(pPedidoId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pDocumentoNr, pRazao,
  pRegistroERP: String; pRotaId, pProcessoId, pRecebido, pCubagem,
  pEtiqueta: Integer; pProcessar, pVerificarEstoque: Boolean): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoProdutoSemPicking(pPedidoId, pCodigoERP, pPessoaId, pDataIni, pDataFin, pDocumentoNr, pRazao, pRegistroERP,
                                                        pRotaId, pProcessoId, pRecebido, pCubagem, pEtiqueta, pProcessar, pVerificarEstoque);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.GetPedidoResumoAtendimento(pPedidoId,
  pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PedidoResumoAtendimento(pPedidoId, pDivergencia, pDataInicial, pDataFinal);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.Pedido_CancelarCubagem(
  pPedidoId: Integer): tJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.Pedido_CancelarCubagem(pPedidoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PutRegistrarProcesso(pPedidoId,
  pProcessoId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.PutRegistrarProcesso(pPedidoid, pProcessoId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.PutReposicaoFinalizar(
  pJsonObject: TJsonObject): TJsonArray;
begin

end;

function TPedidoSaidaCtrl.RelReposicaoTransfPicking(pDataInicial,
  pDataFinal: TDateTime; pReposicaoId, pProcessoId, pPendente,
  pUsuarioId: Integer; pModeloReport: String; pCodProduto : Integer; pZonaId : Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.RelReposicaoTransfPicking(pDataInicial, pDataFinal, pReposicaoId, pProcessoId, pPendente, pUsuarioId, pModeloReport, pCodProduto, pZonaId);
    ObjPedidoSaidaDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoSaidaDAO.Free;
    End;
  End;
end;

function TPedidoSaidaCtrl.ReposicaoCancelar(
  pJsonObjectReposicao: TJsonObject): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.ReposicaoCancelar(pJsonObjectReposicao);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaCtrl.ReposicaoExcluir(pJsonObjectExcluir : TJsonObject): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.ReposicaoExcluir(pJsonObjectExcluir);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaCtrl.reposicaoFinalizar(
  pJsonColeta: tJsonArray): Boolean;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.reposicaoFinalizar(pJsonColeta);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.ReposicaoRegistrarInUse(pReposicaoId,
  pUsuarioId: Integer): TJsonArray;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    //ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.ReposicaoRegistrarInUse(pReposicaoId, pUsuarioId);
    //ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.reposicaoSalvarItemColetado(
  pJsonColeta: TJsonArray): Boolean;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.reposicaoSalvarItemColetado(pJsonColeta);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.ReposicaoTransferenciaPicking(
  PJsonTransferencia: TjsonObject): TjsonArray;
Var ObjPedidoSaidaDAO  : TPedidoSaidaDAO;
Begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.ReposicaoTransferenciaPicking(PJsonTransferencia);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

Function tPedidoSaidaCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var ObjPedidoSaidaDAO  : TPedidoSaidaDAO;
Begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.Salvar(Self.FPedidoSaida.PedidoId);
    if Result then
       Self.PedidoSaida.PedidoId := 0;
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
End;

function TPedidoSaidaCtrl.SalvarReposicao(pJsonReposicao: TJsonObject): Boolean;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.SalvarReposicao(pJsonReposicao);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

function TPedidoSaidaCtrl.SalvarReposicaoModelo(pJsonReposicao: TJsonObject): Boolean;
Var ObjPedidoSaidaDAO : TPedidoSaidaDAO;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Result := ObjPedidoSaidaDAO.SalvarReposicaoModelo(pJsonReposicao);
    ObjPedidoSaidaDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoSaidaDAO.Free;
    raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

End.

