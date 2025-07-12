{
  EntradasCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EntradaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  EntradaClass,
  Horse,
  Horse.Utils.ClientIP,
  exactwmsservice.lib.Utils,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TEntradaCtrl = Class
  Private
    // Fun��es de Valida��o
    FEntrada: TEntrada;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEntrada: TEntrada Read FEntrada Write FEntrada;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Pesquisar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure FinalizarCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure SalvarCheckInItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure SalvarCheckInItemAgrupamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure RegistrarProcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure PlanilhaCega(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEspelho(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetOcorrencias(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetResumoCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetMovimentacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelRecebimento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEtiquetaArmazenagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);

procedure PesquisarService(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelDshRecebimentos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaProdutoSemPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ExcluirPreEntrada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CancelarNFeERP(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetValidarQtdCheckin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarAgrupamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAgrupamentoLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAgrupamentoPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Faturar Lotes P�s CheckIn Agrupameto
Procedure GetAgrupamentoFatorarLoteXML(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAgrupamentoFatorarPedidoLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAgrupamentoCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CancelarCheckInProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DeleteAgrupamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure RegPrintEtqProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Header(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaLoteCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEntradaLoteDevolucao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAcompanhamentoCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDshUserCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DelAgrupamentocheckinreiniciar(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEntrada }

uses uEntradaDAO, uFuncoes, Services.Recebimento;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/entrada', Get)
    .Get('/entrada/:entradaid', GetID)
    .Get('/entrada/:entradaid/:documentonr/:pessoaid', GetDescricao)
    .Get('/entrada/estrutura', Estrutura)
    .Post('/entrada', Insert)
    .Post('/entrada/registrardocumentoetapa', RegistrarProcesso)
    .Put('/entrada/:entradaid', Update)
    .Put('/entrada/finalizarcheckin', FinalizarCheckIn)
    .Put('/entrada/SalvarCheckInItem', SalvarCheckInItem)
    .Put('/entrada/SalvarCheckInItemAgrupamento', SalvarCheckInItemAgrupamento)
    .Delete('/entrada', Delete)
    .Patch('/entrada/cancelar', Cancelar)
    .Get('/entrada/pesquisar', PesquisarService) //
    .Get('/entrada/montarpaginacao', MontarPaginacao)
    .Get('/entrada/planilhacega/:pedidoid', PlanilhaCega)
    .Get('/entrada/espelho', GetEspelho)
    .Get('/entrada/resumocheckin/:entradaid', GetResumoCheckIn)
    .Get('/entrada/movimentacao', GetMovimentacao)
    .Get('entrada/relrecebimento', GetRelRecebimento)

    .Get('/entrada/pesquisarservice', PesquisarService)
    .Get('/entrada/etiquetaarmazenagem', GetEtiquetaArmazenagem)
    .Get('/entrada/dshrecebimento', GetRelDshRecebimentos)
    .Get('/entrada/produto', GetEntradaProduto)
    .Get('/entrada/lotes', GetEntradaLotes)
    .Get('/entrada/itens', GetEntradaItens)
    .Get('/entrada/produtosempicking', GetEntradaProdutoSemPicking)
    .Delete('/entrada/excluirpreentrada', CancelarNFeERP) //ExcluirPreEntrada)
    .Delete('/entrada/cancelarnfeerp', CancelarNFeERP)
    .Get('/entrada/validarqtdcheckin/:pedidoid/:codproduto', GetValidarQtdCheckin)
    .Put('/entrada/salvaragrupamento', SalvarAgrupamento)
    .Get('/entrada/agrupamentolista', GetAgrupamentoLista)
    .Get('/entrada/agrupamentopedido', GetAgrupamentoPedido)
    .Get('/entrada/agrupamentofatorarlote/:agrupamentoid', GetAgrupamentoFatorarLoteXML)
    .Get('/entrada/agrupamentofatorarpedidolotes/:agrupamentoid', GetAgrupamentoFatorarPedidoLotes)
    .Get('/entrada/getagrupamentocheckin/:agrupamentoid', GetAgrupamentoCheckIn)
    .Delete('/entrada/cancelarcheckinproduto/:agrupamentoid/:pedidoid/:codproduto', CancelarCheckInProduto)
    .Delete('/entrada/agrupamento/:agrupamentoid/:pedidoid', DeleteAgrupamento)
    .Delete('/entrada/agrupamentocheckinreiniciar/:agrupamentoid', DelAgrupamentocheckinreiniciar)
    .Put('/entrada/regprintetqproduto/:pedidoid/:loteid', RegPrintEtqProduto)
    .Get('/entrada/header', Header) //
    .Get('/entrada/itens/lotecheckin', GetEntradaLoteCheckIn)
    .Get('/entrada/lotedevolucao', GetEntradaLoteDevolucao)
    .Get('/entrada/ocorrencia', GetOcorrencias)
    .Get('/entrada/acompanhamentocheckin', GetAcompanhamentoCheckIn)
    .Get('/entrada/dshcheckin', GetDshUserCheckIn);

end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSonArray>(EntradaDAO.Estrutura).Status(THttpStatus.Created);
  Except
    On E: Exception do
    Begin
      ErroJsonArray := TJSonArray.Create;
      ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
        E.Message)));
      Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
    End;
  end;
  Finally
    FreeAndNil(EntradaDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSonArray>(EntradaDAO.GetID(0)).Status(THTTPStatus.OK);
  Except
    On E: Exception do
    Begin
      ErroJsonArray := TJSonArray.Create;
      ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
        E.Message)));
      Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
    End;
  end;
  Finally
    FreeAndNil(EntradaDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
  ErroJsonArray: TJSonArray;
begin
  Try
    try
      EntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSonArray>(EntradaDAO.GetDescricao(Req.Params.Items['entradaid']
        .ToInteger(), Req.Params.Items['documentonr'],
        Req.Params.Items['pessoaid'].ToInteger)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJSonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(EntradaDAO);
  End;
End;

Procedure GetDshUserCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServiceRecebimento;
    JsonArrayRetorno: TJSonArray;
    vPedidoId, vAgrupamentoId, vCodProduto, vLoteId: Integer;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      If Req.Query.Count <= 0 then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os parâmetros da Pesquisa!'))).Status(THttpStatus.Created)
      Else Begin
        JsonArrayRetorno := LService.GetDshUserCheckIn(Req.Query.Dictionary);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/dshcheckin', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/dshcheckin', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
  FreeAndNil(LService);
End;

Procedure GetEntradaLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServiceRecebimento;
    JsonArrayRetorno: TJSonArray;
    vPedidoId, vAgrupamentoId, vCodProduto, vLoteId: Integer;
    AQueryParam: TDictionary<String, String>;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      vPedidoId := 0;
      vAgrupamentoId := 0;
      vCodProduto := 0;
      vLoteId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os par�metros para pegar os produtos!'))).Status(THttpStatus.Created)
      Else Begin
        if AQueryParam.ContainsKey('pedidoid') then
           vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
           vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        if AQueryParam.ContainsKey('codproduto') then
           vCodProduto := StrToIntDef(AQueryParam.Items['codproduto'], 0);
        if AQueryParam.ContainsKey('loteid') then
           vLoteId := StrToIntDef(AQueryParam.Items['loteid'], 0);
        JsonArrayRetorno := LService.GetEntradaLotes(vPedidoId, vAgrupamentoId, vCodProduto, vLoteId);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/lotes', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                        200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/lotes', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
  FreeAndNil(LService);
End;

Procedure Header(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vAgrupamentoId: Integer;
  AQueryParam: TDictionary<String, String>;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      vPedidoId := 0;
      vAgrupamentoId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')))
          .Status(THttpStatus.Created)
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        JsonArrayRetorno := LService.Header(vPedidoId, vAgrupamentoId);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/header', Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.', 200,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/header', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
  FreeAndNil(LService);
End;

Procedure GetAcompanhamentoCheckIn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vCodPessoaERP: Integer;
  vDataInicial, vDataFinal: TDateTime;
  AQueryParam: TDictionary<String, String>;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      vPedidoId := 0;
      vCodPessoaERP := 0;
      vDataInicial := 0;
      vDataFinal := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count < 1 then
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')))
          .Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/acompanhamentocheckin', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')).ToString, #39, '',
          [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('codpessoaerp') then
          vCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        if AQueryParam.ContainsKey('datainicial') then
          vDataInicial := StrToDate(AQueryParam.Items['datainicial']);
        if AQueryParam.ContainsKey('datafinal') then
          vDataFinal := StrToDate(AQueryParam.Items['datafinal']);
        JsonArrayRetorno := LService.GetAcompanhamentoCheckIn(vPedidoId,
          vCodPessoaERP, vDataInicial, vDataFinal);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/acompanhamentocheckin', Trim(Req.Params.Content.Text),
          Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.', 200, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/header', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
        JsonArrayRetorno := Nil;
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetEntradaLoteCheckIn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vCodProduto: Integer;
  vAgrupamentoId: Integer;
  AQueryParam: TDictionary<String, String>;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      vPedidoId := 0;
      vCodProduto := 0;
      vAgrupamentoId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count < 2 then
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')))
          .Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/itens/lotecheckin', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')).ToString, #39, '',
          [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('codproduto') then
          vCodProduto := StrToIntDef(AQueryParam.Items['codproduto'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        JsonArrayRetorno := LService.GetEntradaLoteCheckIn(vPedidoId,
          vAgrupamentoId, vCodProduto);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/itens/lotecheckin', Trim(Req.Params.Content.Text),
          Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.', 200, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/header', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetEntradaLoteDevolucao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vCodProduto: Integer;
  vAgrupamentoId: Integer;
  AQueryParam: TDictionary<String, String>;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      vPedidoId := 0;
      vCodProduto := 0;
      vAgrupamentoId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count < 2 then
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')))
          .Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/itens/lotecheckin', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')).ToString, #39, '',
          [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('codproduto') then
          vCodProduto := StrToIntDef(AQueryParam.Items['codproduto'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        JsonArrayRetorno := LService.GetEntradaLoteDevolucao(vPedidoId,
          vAgrupamentoId, vCodProduto);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/lotedevolucao', Trim(Req.Params.Content.Text), Req.Body,
          '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
          200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/lotedevolucao', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
        JsonArrayRetorno := Nil;
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetOcorrencias(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vCodProduto: Integer;
  vDocumentoNr, vRegistroERP: String;
  vDataInicial, vDataFinal: TDateTime;
  vDataCheckInInicial: TDateTime;
  vDataCheckInFinal: TDateTime;
  AQueryParam: TDictionary<String, String>;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    LService := TServiceRecebimento.Create;
    Try
      vPedidoId := 0;
      vDocumentoNr := '';
      vRegistroERP := '';
      vDataInicial := 0;
      vDataFinal := 0;
      vDataCheckInInicial := 0;
      vDataCheckInFinal := 0;
      vCodProduto := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count < 1 then
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')))
          .Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/ocorrencia', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')).ToString, #39, '',
          [rfReplaceAll]), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('documentonr') then
          vDocumentoNr := AQueryParam.Items['documentonr'];
        if AQueryParam.ContainsKey('registroerp') then
          vRegistroERP := AQueryParam.Items['registroerp'];
        if AQueryParam.ContainsKey('datainicial') then
          vDataInicial := StrToDate(AQueryParam.Items['datainicial']);
        if AQueryParam.ContainsKey('datafinal') then
          vDataFinal := StrToDate(AQueryParam.Items['datafinal']);
        if AQueryParam.ContainsKey('codproduto') then
          vCodProduto := StrToIntDef(AQueryParam.Items['codproduto'], 0);
        if AQueryParam.ContainsKey('datainicial') then
          vDataCheckInInicial :=
            StrToDate(AQueryParam.Items['checkindatainicial']);
        if AQueryParam.ContainsKey('datafinal') then
          vDataCheckInFinal := StrToDate(AQueryParam.Items['checkindatafinal']);
        JsonArrayRetorno := LService.GetOcorrencias(vPedidoId, vDocumentoNr,
          vRegistroERP, vCodProduto, vDataInicial, vDataFinal,
          vDataCheckInInicial, vDataCheckInFinal);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/lotedevolucao', Trim(Req.Params.Content.Text), Req.Body,
          '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.', 200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/entrada/ocorrencia', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetEntradaProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vAgrupamentoId: Integer;
  AQueryParam: TDictionary<String, String>;
Begin
  Try
    LService := TServiceRecebimento.Create;
    Try
      vPedidoId := 0;
      vAgrupamentoId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os produtos!')))
          .Status(THttpStatus.Created)
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        JsonArrayRetorno := LService.GetEntradaProduto(vPedidoId, vAgrupamentoId);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetEntradaItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vPedidoId, vAgrupamentoId: Integer;
  AQueryParam: TDictionary<String, String>;
Begin
  Try
    LService := TServiceRecebimento.Create;
    Try
      vPedidoId := 0;
      vAgrupamentoId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pegar os itens!')))
          .Status(THttpStatus.Created)
      Else
      Begin
        // if aQueryParam.ContainsKey('pedidoid') then
        vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        JsonArrayRetorno := LService.GetEntradaItens(vPedidoId, vAgrupamentoId);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetEntradaProdutoSemPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServiceRecebimento;
    JsonArrayRetorno: TJSonArray;
    JsonArrayErro: TJSonArray;
    AQueryParam: TDictionary<String, String>;
    vDataInicial, vDataFinal: TDateTime;
    vPedidoId, vCodPessoaERP: Integer;
    vDocumentoNr: String;
Begin
  Try
    vPedidoId := 0;
    vCodPessoaERP := 0;
    vDocumentoNr := '';
    LService := TServiceRecebimento.Create;
    Try
      AQueryParam := Req.Query.Dictionary;
      Begin
        AQueryParam := Req.Query.Dictionary;
        if AQueryParam.ContainsKey('datainicial') then
          vDataInicial := StrToDate(AQueryParam.Items['datainicial'])
        Else
          vDataInicial := 0;
        if AQueryParam.ContainsKey('datafinalal') then
          vDataFinal := StrToDate(AQueryParam.Items['datafinalal'])
        Else
          vDataFinal := 0;
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('codpessoaerp') then
          vCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        if AQueryParam.ContainsKey('documentonr') then
          vDocumentoNr := AQueryParam.Items['documentonr'];
        JsonArrayRetorno := LService.GetEntradaProdutoSemPicking(vDataInicial,
          vDataFinal, vPedidoId, vCodPessoaERP, vDocumentoNr);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure RegPrintEtqProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.RegPrintEtqProduto
        (StrToIntDef(Req.Params.Items['pedidoid'], 0),
        StrToIntDef(Req.Params.Items['loteid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure SalvarAgrupamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.SalvarAgrupamento(Req.Body<TJSonArray>);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetValidarQtdCheckin(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.ValidarQtdCheckIn
        (StrToIntDef(Req.Params.Items['pedidoid'], 0),
        StrToIntDef(Req.Params.Items['codproduto'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure CancelarNFeERP(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayReq, JsonArrayRetorno: TJSonArray;
Begin
  Try
    LService := TServiceRecebimento.Create;
    Try
      JsonArrayReq := TJSONObject.ParseJSONValue
        (TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSonArray;
      JsonArrayRetorno := LService.CancelarNFeERP(JsonArrayReq);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure CancelarCheckInProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.CancelarCheckInProduto(StrToIntDef(Req.Params.Items['agrupamentoid'], 0),
                                   StrToIntDef(Req.Params.Items['pedidoid'], 0), StrToIntDef(Req.Params.Items['codproduto'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure DelAgrupamentocheckinreiniciar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServiceRecebimento;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.DelAgrupamentocheckinreiniciar(StrToIntDef(Req.Params.Items['agrupamentoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/entrada/agrupamentocheckinreiniciar/:agrupamentoid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
  Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/agrupamentocheckinreiniciar/:agrupamentoid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;


Procedure DeleteAgrupamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc); // Itens da Entrada
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.DeleteAgrupamento
        (StrToIntDef(Req.Params.Items['agrupamentoid'], 0),
        StrToIntDef(Req.Params.Items['pedidoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure ExcluirPreEntrada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServiceRecebimento;
    JsonArrayReq, JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    LService := TServiceRecebimento.Create;
    Try
      JsonArrayReq := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSonArray;
      JsonArrayRetorno := LService.ExcluirPreEntrada(JsonArrayReq);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/entrada/excluirpreentrada', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/excluirpreentrada', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure GetEspelho(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      If Req.Query.Count <= 0 then
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Par�metros da consulta n�o definidos!')));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Exit;
      End;
      Res.Send<TJSonArray>(EntradaDAO.GetEspelho(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EntradaDAO);
  End;
End;

Procedure GetResumoCheckIn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := TJSonArray.Create;
      JsonArrayRetorno := LService.GetResumoCheckIn(Req.Params.Items['entradaid'].ToInteger());
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetEtiquetaArmazenagem(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var // PedidoEntradaDAO : TEntradaDao;
  AQueryParam: TDictionary<String, String>;
  vPedidoId, vZonaId, vCodProduto, vSintetico: Integer;
  vDocumentoNr: String;
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vDtInicio, vDtTermino: TDateTime;
begin
  Try
    LService := TServiceRecebimento.Create;
    Try
      // Processos - Etapas dos Pedidos
      vPedidoId := 0;
      vDocumentoNr := '';
      vZonaId := 0;
      vCodProduto := 0;
      vSintetico := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para cubagem!'))).Status(THttpStatus.Created)
      Else
      Begin
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('documentonr') then
          vDocumentoNr := AQueryParam.Items['documentonr'];
        if AQueryParam.ContainsKey('zonaid') then
          vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        if AQueryParam.ContainsKey('codproduto') then
          vCodProduto := StrToIntDef(AQueryParam.Items['codproduto'], 0);
        if AQueryParam.ContainsKey('sintetico') then
          vSintetico := 1;
        if AQueryParam.ContainsKey('dtinicio') then
          vDtInicio := StrToDate(AQueryParam.Items['dtinicio'])
        Else
          vDtInicio := 0;
        if AQueryParam.ContainsKey('dtinicio') then
          vDtTermino := StrToDate(AQueryParam.Items['dttermino'])
        Else
          vDtTermino := 0;
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno := LService.GetEtiquetaArmazenagem(vPedidoId,
          vDocumentoNr, vZonaId, vCodProduto, vSintetico, vDtInicio, vDtTermino);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetMovimentacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      If Req.Query.Count <= 0 then
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Exit;
      End;
      JsonArrayRetorno := EntradaDAO.GetMovimentacao(Req.Query.Dictionary);
      Res.Status(200).Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(EntradaDAO);
  End;
end;

procedure Pesquisar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoEntradaDAO: TEntradaDAO;
  AQueryParam: TDictionary<String, String>;
  vDocumentoNr, vRazao, vRegistroERP: String;
  vPedidoId, vPessoaId, vPendente, vAgrupamentoId : Integer;
  vCodProduto : String;
  vDtNotaFiscal: TDateTime;
  vBasico: Boolean;
begin
  Try
    PedidoEntradaDAO := TEntradaDAO.Create;
    Try
      // Processos - Etapas dos Pedidos
      vPedidoId := 0;
      vPessoaId := 0;
      vDocumentoNr := '';
      vRazao := '';
      vRegistroERP := '';
      vPendente := 0;
      vAgrupamentoId := 0;
      vDtNotaFiscal := 0;
      vBasico := False;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os parâmetros para cubagem!'))).Status(THttpStatus.Created)
      Else
      Begin
        if AQueryParam.ContainsKey('PedidoId') then
          vPedidoId := StrToIntDef(AQueryParam.Items['PedidoId'], 0);
        if AQueryParam.ContainsKey('PessoaId') then
          vPessoaId := StrToIntDef(AQueryParam.Items['PessoaId'], 0);
        if AQueryParam.ContainsKey('DocumentoNr') then
          vDocumentoNr := AQueryParam.Items['DocumentoNr'];
        if AQueryParam.ContainsKey('Razao') then
          vRazao := AQueryParam.Items['Razao'];
        if AQueryParam.ContainsKey('RegistroERP') then
          vRegistroERP := AQueryParam.Items['RegistroERP'];
        if AQueryParam.ContainsKey('dtnotafiscal') then
          vDtNotaFiscal := StrToIntDef(AQueryParam.Items['dtnotafiscal'], 0);
        if AQueryParam.ContainsKey('pendente') then
          vPendente := StrToIntDef(AQueryParam.Items['pendente'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        if AQueryParam.ContainsKey('basico') then
          if AQueryParam.Items['basico'] = '1' then
            vBasico := True
          Else
            vBasico := False;
        // Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Cubagem realizada com sucesso!'))).Status(THTTPStatus.Created);
  {$REGION CubagemPedido}
        // Como Criar Region
  {$ENDREGION}
        if AQueryParam.ContainsKey('codproduto') then
          vCodProduto := AQueryParam.Items['codproduto'];
        Res.Send<TJSonArray>(PedidoEntradaDAO.Pesquisar(vPedidoId, vPessoaId,
          vDocumentoNr, vRazao, vRegistroERP, vDtNotaFiscal, vPendente,
          vAgrupamentoId, vBasico, vCodProduto)).Status(THttpStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(PedidoEntradaDAO);
  End;
End;

procedure PesquisarService(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoEntradaDAO: TEntradaDAO;
    AQueryParam: TDictionary<String, String>;
    vDocumentoNr, vRazao, vRegistroERP: String;
    vPedidoId, vCodPessoaERP, vPendente, vAgrupamentoId: Integer;
    vDtNotaFiscal: TDateTime;
    vCodProduto, vDescrProduto : String;
    vBasico: Boolean;
    LService: TServiceRecebimento;
    JsonArrayRetorno: TJSonArray;
begin
  Try
    Try
      // Processos - Etapas dos Pedidos
      LService       := TServiceRecebimento.Create;
      vPedidoId      := 0;
      vCodPessoaERP  := 0;
      vDocumentoNr   := '';
      vRazao         := '';
      vRegistroERP   := '';
      vPendente      := 0;
      vAgrupamentoId := 0;
      vCodProduto    := '0';
      vDescrProduto  := '';
      vBasico        := False;
      vDtNotaFiscal  := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os parâmetros para cubagem!'))).Status(THttpStatus.Created)
      Else
      Begin
        if AQueryParam.ContainsKey('PedidoId') then
           vPedidoId := StrToIntDef(AQueryParam.Items['PedidoId'], 0);
        if AQueryParam.ContainsKey('codpessoaerp') then
           vCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        if AQueryParam.ContainsKey('DocumentoNr') then
           vDocumentoNr := AQueryParam.Items['DocumentoNr'];
        if AQueryParam.ContainsKey('Razao') then
           vRazao := AQueryParam.Items['Razao'];
        if AQueryParam.ContainsKey('RegistroERP') then
           vRegistroERP := AQueryParam.Items['RegistroERP'];
        if AQueryParam.ContainsKey('dtnotafiscal') then
           vDtNotaFiscal := StrToDate(AQueryParam.Items['dtnotafiscal']);
        if AQueryParam.ContainsKey('codproduto') then
           vCodProduto := AQueryParam.Items['codproduto'];
        if AQueryParam.ContainsKey('descrproduto') then
           vDescrProduto := AQueryParam.Items['descrproduto'];
        if AQueryParam.ContainsKey('pendente') then
           vPendente := StrToIntDef(AQueryParam.Items['pendente'], 0);
        if AQueryParam.ContainsKey('agrupamentoid') then
           vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        if AQueryParam.ContainsKey('basico') then
           if AQueryParam.Items['basico'] = '1' then
              vBasico := True
            Else
              vBasico := False;
        JsonArrayRetorno := LService.Pesquisar(vPedidoId, vCodPessoaERP, vDocumentoNr, vRazao,
                            vRegistroERP, vDtNotaFiscal, vPendente, vAgrupamentoId, vCodProduto, vDescrProduto, vBasico, 0);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetRelDshRecebimentos(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var // PedidoEntradaDAO : TEntradaDao;
  AQueryParam: TDictionary<String, String>;
  vRecebimentoInicial, vRecebimentoFinal: TDateTime;
  vProducaoInicial, vProducaoFinal : TDateTime;
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      vRecebimentoInicial := 0;
      vRecebimentoFinal   := 0;
      vProducaoInicial    := 0;
      vProducaoFinal      := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os parâmetros para gerar o dashboard!'))).Status(THttpStatus.Created)
      Else Begin
        if AQueryParam.ContainsKey('datainicial') then
           vRecebimentoInicial := StrToDate(AQueryParam.Items['datainicial']);
        if AQueryParam.ContainsKey('datafinal') then
           vRecebimentoFinal := StrToDate(AQueryParam.Items['datafinal']);
        if AQueryParam.ContainsKey('producaoinicial') then
           vProducaoInicial := StrToDate(AQueryParam.Items['producaoinicial']);
        if AQueryParam.ContainsKey('producaofinal') then
           vProducaoFinal := StrToDate(AQueryParam.Items['producaofinal']);
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno := LService.DshRecebimentos(vRecebimentoInicial, vRecebimentoFinal, vProducaoInicial, vProducaoFinal);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure PlanilhaCega(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
Begin
  Try
    try
      EntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSonArray>(EntradaDAO.PlanilhaCega
        (StrToIntDef(Req.Params.Items['pedidoid'], 0)))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));;
      End;
    end;
  Finally
    FreeAndNil(EntradaDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EntradaDAO: TEntradaDAO;
begin
  Try
    try
      EntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSonArray>
        (EntradaDAO.GetID(StrToIntDef(Req.Params.Items['entradaid'], 0)))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));;
      End;
    end;
  Finally
    FreeAndNil(EntradaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjEntrada: TJSONObject;
  EntradaDAO: TEntradaDAO;
begin
  tRY
    Try
      ObjEntrada := TJSONObject.Create;
      ObjEntrada := Req.Body<TJSONObject>;
      EntradaDAO := TEntradaDAO.Create;
      EntradaDAO.Entrada := EntradaDAO.Entrada.JsonToClass(ObjEntrada.ToString());
      if EntradaDAO.Salvar then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
            'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'N�o foi poss�vel inserir o Registro!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjEntrada);
    FreeAndNil(EntradaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjEntrada: TJSONObject;
  EntradaDAO: TEntradaDAO;
begin
  Try
    Try
      ObjEntrada := TJSONObject.Create;
      ObjEntrada := Req.Body<TJSONObject>;
      EntradaDAO := TEntradaDAO.Create;
      EntradaDAO.InsertUpdate(GetValueInjSon(ObjEntrada, 'Entradaid').ToInteger(),
        GetValueInjSon(ObjEntrada, 'operacaotipoid').ToInteger(),
        GetValueInjSon(ObjEntrada, 'pessoatipoid').ToInteger(),
        GetValueInjSon(ObjEntrada, 'documentonr'),
        StrToIntDef(GetValueInjSon(ObjEntrada, 'documentodata'), 0), 0);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjEntrada);
    FreeAndNil(EntradaDAO);
  End;
end;

procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EntradaDAO: TEntradaDAO;
begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      EntradaDAO.Cancelar(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Entrada Cancelada com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EntradaDAO);
  End;
end;

Procedure GetAgrupamentoLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServiceRecebimento;
    JsonArrayRetorno: TJSonArray;
    vAgrupamentoId, vCodPessoaERP: Integer;
    AQueryParam: TDictionary<String, String>;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      vAgrupamentoId := 0;
      vCodPessoaERP := 0;
      AQueryParam := Req.Query.Dictionary;
      JsonArrayRetorno := TJSonArray.Create;
      If AQueryParam.Count <= 0 then Begin
         JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro', 'Defina os par�metros para pegar pedidos do Agrupamento!'));
         Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End
      Else Begin
        if AQueryParam.ContainsKey('agrupamentoid') then
           vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        if AQueryParam.ContainsKey('codpessoaerp') then
           vCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        JsonArrayRetorno := LService.GetAgrupamentoLista(vAgrupamentoId, vCodPessoaERP);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetAgrupamentoPedido(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServiceRecebimento;
  JsonArrayRetorno: TJSonArray;
  vAgrupamentoId, vPedidoId: Integer;
  AQueryParam: TDictionary<String, String>;
Begin
  Try
    Try
      LService := TServiceRecebimento.Create;
      vAgrupamentoId := 0;
      vPedidoId := 0;
      AQueryParam := Req.Query.Dictionary;
      JsonArrayRetorno := TJSonArray.Create;
      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          'Defina os par�metros para pegar pedidos do Agrupamento!'));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End
      Else
      Begin
        if AQueryParam.ContainsKey('agrupamentoid') then
          vAgrupamentoId := StrToIntDef(AQueryParam.Items['agrupamentoid'], 0);
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        JsonArrayRetorno := LService.GetAgrupamentoPedido(vAgrupamentoId,
          vPedidoId);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EntradaDAO: TEntradaDAO;
begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      EntradaDAO.Entrada.EntradaId :=
        StrToIntDef(Req.Params.Items['entradaid'], 0);
      EntradaDAO.Delete(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EntradaDAO);
  End;
end;

procedure RegistrarProcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var EntradaDAO: TEntradaDAO;
begin
  Try
    Try
      EntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSonArray>(EntradaDAO.RegistrarDocumentoEtapa(Req.Body<TJSONObject>)).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(EntradaDAO);
  End;
End;

 Procedure GetRelRecebimento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ObjEntradaDAO: TEntradaDAO;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin, vDataFinalizacaoInicio, vDataFinalizacaoTermino : TDateTime;
  vDocumentoNr, vRegistroERP, vRazao: String;
  vPedidoId, vCodigoERP, vPessoaId, vProcessoId, vPedidoPendente: Integer;
  vCodProduto: Int64;
  vParamsOk: Integer;
  JsonArrayRetorno, JsonArrayErro: TJSonArray;
begin
  Try
    try
      ObjEntradaDAO := TEntradaDAO.Create;
      vPedidoId := 0;
      vDataIni := 0;
      vDataFin := 0;
      vDataFinalizacaoInicio  := 0;
      vDataFinalizacaoTermino := 0;
      vDocumentoNr := '';
      vRegistroERP := '';
      vCodigoERP := 0;
      vPessoaId := 0;
      vRazao := '';
      vProcessoId := 0;
      vCodProduto := 0;
      vPedidoPendente := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Par�metros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('dataini') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['dataini']);
          vParamsOk := vParamsOk + 1;
        Except Begin
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
          Exit;
          End;
        End;
      End;
      if AQueryParam.ContainsKey('datafin') then
      Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafin']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos inválida!')));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinalizacaoinicio') then
      Begin
        Try
          vDataFinalizacaoInicio := StrToDate(AQueryParam.Items['datafinalizacaoinicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial da Finalizacção dos pedidos é inválida!')));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinalizacaotermino') then
      Begin
        Try
          vDataFinalizacaoTermino := StrToDate(AQueryParam.Items['datafinalizacaotermino']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final da Finalização dos Pedidos  é inválida!')));
          Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('pedidoid') then
      Begin
        vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codigoerp') then
      Begin
        vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('pessoaid') then
      Begin
        vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('documentonr') then
      Begin
        vDocumentoNr := AQueryParam.Items['documentonr'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('razao') then
      Begin
        vRazao := AQueryParam.Items['razao'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('registroerp') then
      Begin
        vRegistroERP := AQueryParam.Items['registroerp'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('processoid') then
      Begin
        vProcessoId := StrToIntDef(AQueryParam.Items['processoid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codproduto') then
      Begin
        vCodProduto := StrToInt64Def(AQueryParam.Items['codproduto'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('pedidopendente') then
      Begin
        vPedidoPendente := StrToInt64Def(AQueryParam.Items['pedidopendente'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
        Exit;
      End;
      Res.Send<TJSonArray>(ObjEntradaDAO.GetRelRecebimento(vPedidoId, vDataIni, vDataFin, vDataFinalizacaoInicio, vDataFinalizacaoTermino,
                           vCodigoERP, vPessoaId, vRazao, vDocumentoNr, vRegistroERP, vProcessoId, vCodProduto, vPedidoPendente)).Status(THttpStatus.Created);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(ObjEntradaDAO);
  End;
end;

procedure SalvarCheckInItemAgrupamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonObjectRetorno: TJSONObject;
    LService: TServiceRecebimento;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      JsonObjectRetorno := LService.SalvarCheckInItemAgrupamento(Req.Body<TJSONObject>);
      Res.Send<TJsonObject>(JsonObjectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/entrada/SalvarCheckInItemAgrupamento', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonObjectRetorno.Count.ToString +' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJsonObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/entrada/dshcheckin', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    JsonObjectRetorno := Nil;
    FreeAndNil(LService);
  End;
end;

procedure SalvarCheckInItem(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  jsonEntrada: TJSONObject;
  LService: TServiceRecebimento;
  EntradaDAO: TEntradaDAO;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      jsonEntrada := LService.SalvarCheckInItem(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(jsonEntrada).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/entrada/SalvarCheckInItem', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonEntrada.Count.ToString +' Registros.',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                     '/v1/entrada/SalvarCheckInItem', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                     500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetAgrupamentoFatorarLoteXML(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayRetorno: TJSonArray;
    LService: TServiceRecebimento;
begin
  Try
    LService := TServiceRecebimento.Create;
    Try
      JsonArrayRetorno := LService.GetAgrupamentoFatorarLoteXML(StrToIntDef(Req.Params.Items['agrupamentoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetAgrupamentoCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayRetorno: TJSonArray;
    LService: TServiceRecebimento;
begin
  try
    Try
      LService := TServiceRecebimento.Create;
      JsonArrayRetorno := LService.GetAgrupamentoCheckIn(StrToIntDef(Req.Params.Items['agrupamentoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetAgrupamentoFatorarPedidoLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonArrayRetorno: TJSonArray;
    LService: TServiceRecebimento;
begin
  try
    LService := TServiceRecebimento.Create;
    Try
      JsonArrayRetorno := LService.GetAgrupamentoFatorarPedidoLotes(StrToIntDef(Req.Params.Items['agrupamentoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure FinalizarCheckIn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var EntradaDAO: TEntradaDAO;
    LService: TServiceRecebimento;
    HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      LService := TServiceRecebimento.Create;
      If LService.FinalizarCheckIn(Req.Body<TJSONObject>) then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Finalização do CheckIn concluída com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/entrada/finalizarcheckin', Trim(Req.Params.Content.Text), Req.Body, '', 'Finalização do CheckIn concluída com Sucesso!',
                      200, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except on E: Exception do Begin
      Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/entrada/finalizarcheckin', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                      500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  Try
    Try
      ObjEntradaDAO := TEntradaDAO.Create;
      Res.Send<TJSONObject>(ObjEntradaDAO.MontarPaginacao)
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(ObjEntradaDAo);
  End;
end;

constructor TEntradaCtrl.Create;
begin
  FEntrada := TEntrada.Create;
end;

destructor TEntradaCtrl.Destroy;
begin
  FreeAndNil(FEntrada);
  inherited;
end;

End.
