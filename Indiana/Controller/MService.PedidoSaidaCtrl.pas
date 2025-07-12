{
  EntradasCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PedidoSaidaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PedidoSaidaClass, Exactwmsservice.lib.utils,
  Horse,
  Horse.utils.ClientIP,
  System.JSON; // , uTHistorico\;

Type
  TipoConsulta = (Resumida, Completa);

  TPedidoSaidaCtrl = Class
  Private
    // Funções de Validação
    FPedidoSaida: TPedidoSaida;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjPedidoSaida: TPedidoSaida Read FPedidoSaida Write FPedidoSaida;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPedidoAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPedidoParaCargas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetClientesRotaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDocumento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DeletePedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Processamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Buscar Pedidos para Cubagem
Procedure PedidoProcessar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Buscar Pedidos para Cubagem
Procedure PedidoPrintTag(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Buscar Pedidos para Impressao de Tag
procedure RegistrarProcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEstoqueCaixaFechada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CreateVolumeCaixaFechada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetLoteParaVolumeFracionado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEstoqueCaixaFracionada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CreateVolumeCaixaFracionada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPedidoResumoAtendimento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CancelarCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Levar para Service de Reposicao
Procedure GetProdutoReposicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProdutoSemPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelRupturaAbastecimento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelColetaPulmao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelApanhePicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelAnaliseRessuprimento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelAnaliseRessuprimentoVolume(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoEnderecoColeta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoGerar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoDemanda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoDemandaCapacidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoDemandaColeta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ReposicaoSalvar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PostReposicaoModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DeleteReposicaoModelo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDashBoard0102(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProducaoPendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDashBoard030405(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetDashBoard06(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCortes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetResumoProducao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetMovimentacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEvolucaoAtendimentoPed(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEvolucaoAtendimentoVol(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEvolucaoAtendimentoUnid(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEvolucaoAtendimentoUnidZona(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetEvolucaoAtendimentoUnidEmbalagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DeleteReservaCorrecao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetPedidoProcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoAutomatica(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoAutomaticaColeta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetConsultaReposicao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetConsultaReposicaoProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAuditoriaSaidaPorProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetSaidaPorProdutoBalanceamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutReposicaoSalvarItemColetado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutReposicaoTransferenciaPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutReposicaoFinalizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelAtendimentoRota(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelAtendimentoDestinatario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelAtendimentoZona(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutAtualizarNFPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutAtualizarNFPedidoV2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetReposicaoHistorico(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelReposicaoTransfPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAnaliseColeta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelHistoricoTransferenciaPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ReposicaoCancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ReposicaoExcluir(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ReposicaoRegistrarInUse(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutRegistrarProcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetMotivoExclusaoPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Getmotivoexclusaopedido4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPedidoSaida }

uses MService.PedidoSaidaDAO, uFuncoes, Services.PedidoSaida;

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/saida', Get).Get('/saida/:pedidoid', GetID)
    .Get('/saida/pendente', GetPendente)
    .Get('/saida/pedidocubagem_caixafechada/:pedidoid', GetEstoqueCaixaFechada)
    .Get('/saida/loteparavolumefracionado/:pedidoid', GetLoteParaVolumeFracionado)
    .Get('/saida/pedidocubagem_caixafracionada/:pedidoid', GetEstoqueCaixaFracionada)
    .Get('/saida/documento/:documentonr/:pessoaid', GetDocumento)
    .Get('/saida/estrutura', Estrutura)
    .Get('/saida/pedido', GetPedidoAll)
    .Get('/saida/pedidoparacargas', GetPedidoParaCargas)
    .Get('/saida/resumoatendimento/:pedidoid/:divergencia/:datainicial/:datafinal', GetPedidoResumoAtendimento)
    .Get('/saida/clientesrotacarga', GetClientesRotaCarga)
    .Post('/saida', Insert)
    .Put('/saida/:pedidoid', Update)
    .Put('/saida/processo', RegistrarProcesso)
    .Delete('/saida/:pedidoid', Delete)
    .Delete('/saida', DeletePedido)
    .Delete('/saida/cancelarcubagem/:pedidoid', CancelarCubagem)
    .Patch('/saida/cancelar', Cancelar)
    .Get('/saida/cubagem', PedidoProcessar)
    .Get('/saida/printtag', PedidoPrintTag)
    .Get('/saida/processamento', Processamento) // Pegar pedidos para Processamento
    .Post('/saida/gerarvolumecaixafechada', CreateVolumeCaixaFechada)
    .Post('/saida/gerarvolumecaixafracionada', CreateVolumeCaixaFracionada)
    .Get('/reposicao/produtos', GetProdutoReposicao)
    .Get('/saida/produtosempicking', GetProdutoSemPicking)
    .Get('/pedido/rupturaabastecimento', GetRelRupturaAbastecimento)
    .Get('/pedido/coletapulmao', GetRelColetaPulmao)
    .Get('/pedido/apanhepicking', GetRelApanhePicking)
    .Get('/reposicao/gerar', GetReposicaoGerar)
    .Get('/reposicao/demanda', GetReposicaoDemanda)
    .Get('/reposicao/demandacapacidade', GetReposicaoDemandaCapacidade)
    .Get('/reposicao/demanda/coleta/:tipogeracao', GetReposicaoDemandaColeta)
    .Get('/reposicao/enderecocoleta', GetReposicaoEnderecoColeta)
    .Post('reposicao/salvar', ReposicaoSalvar)
    .Put('reposicao/salvar', ReposicaoSalvar)
    .Get('/reposicao/modelo/:modeloid', GetReposicaoModelo)
    .Post('reposicao/modelo', PostReposicaoModelo)
    .Delete('/reposicao/modelo/:modeloid', DeleteReposicaoModelo)
    .Get('/pedido/analiseressuprimento', GetRelAnaliseRessuprimento)
    .Get('/pedido/analiseressuprimentovolume', GetRelAnaliseRessuprimentoVolume)
    .Get('/pedido/cortes', GetCortes)
    .Get('/pedido/dashboard0102', GetDashBoard0102) //
    .Get('/pedido/dashboard030405', GetDashBoard030405)
    .Get('/pedido/producaopendente', GetProducaoPendente)
    .Get('/pedido/dashboard06', GetDashBoard06)
    .Get('/pedido/resumoproducao', GetResumoProducao)
    .Get('/pedido/movimentacao', GetMovimentacao)
    .Get('/pedido/dsboard/evolucaoatendimentoped', GetEvolucaoAtendimentoPed)
    .Get('/pedido/dsboard/evolucaoatendimentovol', GetEvolucaoAtendimentoVol)
    .Get('/pedido/dsboard/evolucaoatendimentounid', GetEvolucaoAtendimentoUnid)
    .Get('/pedido/dsboard/evolucaoatendimentounidzona', GetEvolucaoAtendimentoUnidZona)
    .Get('/pedido/dsboard/evolucaoatendimentounidembalagem', GetEvolucaoAtendimentoUnidEmbalagem)
    .Delete('/pedido/reservacorrecao', DeleteReservaCorrecao)
    .Get('/pedido/processo/:pedidoid', GetPedidoProcesso)
    .Get('/pedido/ReposicaoAutomatica', GetReposicaoAutomatica)
    .Get('/pedido/ReposicaoAutomaticacoleta', GetReposicaoAutomaticaColeta)
    .Get('/reposicao/consulta', GetConsultaReposicao)
    .Get('/reposicao/consulta/:reposicaoid', GetConsultaReposicaoProduto)
    .Put('/reposicao/salvaritemcoletado', PutReposicaoSalvarItemColetado)
    .Put('/reposicao/ReposicaoTransferenciaPicking', PutReposicaoTransferenciaPicking)
    .Put('/reposicao/finalizar', PutReposicaoFinalizar)
    .Get('/pedido/saidaporproduto', GetAuditoriaSaidaPorProduto)
    .Get('/pedido/saidaporproduto/banlanceamento', GetSaidaPorProdutoBalanceamento)
    .Get('/pedido/atedimento/rota', GetRelAtendimentoRota)
    .Get('/pedido/atedimento/destinatario', GetRelAtendimentoDestinatario)
    .Get('/pedido/atedimento/zona', GetRelAtendimentoZona)
    .Get('/reposicao/historico', GetReposicaoHistorico)
    .Get('/reposicao/transferencia', GetRelReposicaoTransfPicking)
    .Get('/reposicao/analisecoleta', GetAnaliseColeta)
    .Get('/reposicao/historicotransferencia', GetRelHistoricoTransferenciaPicking)
    .Delete('/reposicao/cancelar', ReposicaoCancelar)
    .Delete('/reposicao/delete', ReposicaoExcluir)
    .Put('reposicao/registrarinuse/:reposicaoid/:usuarioid/:terminal', ReposicaoRegistrarInUse)
    .Put('pedido/registrarprocesso', PutRegistrarProcesso)
    .Put('/pedido/nfeerp', PutAtualizarNFPedido)
    .Get('/pedido/motivoexclusao', GetMotivoExclusaoPedido)
    .Get('/motivoexclusaopedido4D', Getmotivoexclusaopedido4D)
    .Prefix('v2')
    .Put('/pedido/nfeerp', PutAtualizarNFPedidoV2) //Mais de um NF por Pedido e dados complementares
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
Begin
   PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try

      Res.Send<TJSonArray>(PedidoSaidaDAO.Estrutura)
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetEvolucaoAtendimentoPed(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  AQueryParam : TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vRotaId     : Integer;
  vZonaId     : Integer;
  vZonaIdStr  : String;
  vParamsOk   : Integer;
  JsonErro    : TJSonArray;
  JsonRetorno : TJSonArray;
  HrInicioLog : TTime;
begin
  PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    JsonRetorno := TJSonArray.Create;
    Try
      HrInicioLog := Time;
      vDataIni := 0;
      vDataFin := 0;
      vRotaId := 0;;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/pedido/dsboard/evolucaoatendimentoped', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonErro.Count.ToString + ' Registros.',
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(JsonErro);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('datainicio') then Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonErro := TJSonArray.Create();
          JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          'v1/pedido/dsboard/evolucaoatendimentoped', Trim(Req.Params.Content.Text), Req.Body, '', 'Data Inicial dos Pedidos é inválida!',
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(JsonErro);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafinal']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonErro := TJSonArray.Create();
          JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          'v1/pedido/dsboard/evolucaoatendimentoped', Trim(Req.Params.Content.Text), Req.Body, '', 'Erro: Data Final dos Pedidos é inválida!',
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('rotaid') then Begin
         vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('zonaid') then Begin
         vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
         vParamsOk := vParamsOk + 1;
      End
      Else
         vZonaId := 0;
      if AQueryParam.ContainsKey('zonaidstr') then Begin
         vZonaIdStr := AQueryParam.Items['zonaidstr'];
         vParamsOk := vParamsOk + 1;
      End
      Else
         vZonaIdStr := '';
      if vParamsOk <> AQueryParam.Count then Begin
         JsonErro := TJSonArray.Create();
         JsonErro.AddElement(TJSONObject.Create.AddPair('Erro', 'Parâmetros da consulta definidos incorretamente!'));
         Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedido/dsboard/evolucaoatendimentoped', Trim(Req.Params.Content.Text), Req.Body, '','Retorno: ' + JsonErro.Count.ToString + ' Registros.',
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End
      Else Begin
        JsonRetorno := PedidoSaidaDAO.GetEvolucaoAtendimentoPed(vDataIni, vDataFin, vRotaId, vZonaId, vZonaIdStr);
        Res.Send<TJSonArray>(JsonRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentoped', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.',
                        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except On E: Exception do
      Begin
        JsonErro := TJSonArray.Create;
        JsonErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentoped', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetEvolucaoAtendimentoVol(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoSaidaDAO: TPedidoSaidaDAO;
    AQueryParam : TDictionary<String, String>;
    vDataIni, vDataFin: TDateTime;
    vZonaIdStr  : String;
    vRotaId     : Integer;
    vParamsOk   : Integer;
    JsonErro: TJSonArray;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog : TTime;
begin
  PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try
      HrInicioLog := Time;
      vDataIni    := 0;
      vDataFin    := 0;
      vZonaIdStr  := '';
      vRotaId     := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentovol', Trim(Req.Params.Content.Text), Req.Body, '', 'Parâmetros da consulta não definidos!',
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        jsonErro := Nil;
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('datainicio') then Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonErro := TJSonArray.Create();
          JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/pedido/dsboard/evolucaoatendimentovol', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonErro.Count.ToString + ' Registros.',
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          jsonErro := Nil;
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafinal']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonErro := TJSonArray.Create();
          JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/pedido/dsboard/evolucaoatendimentovol', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonErro.Count.ToString + ' Registros.',
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          JsonErro := Nil;
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('zonaidstr') then Begin
        vZonaIdStr := AQueryParam.Items['zonaidstr'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaid') then Begin
         vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then
      Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentovol', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonErro.Count.ToString + ' Registros.',
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        JsonErro := Nil;
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      JsonArrayRetorno := PedidoSaidaDAO.GetEvolucaoAtendimentoVol(vDataIni, vDataFin, vRotaId, vZonaIdStr);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/dsboard/evolucaoatendimentovol', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonErro := TJSonArray.Create;
        JsonErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentovol', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        JsonErro := Nil;
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetMotivoExclusaoPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PedidoSaidaDAO: TPedidoSaidaDAO;
    JsonArrayErro: TJSonArray;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
   PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try
      HrInicioLog := Time;
      JsonArrayRetorno := PedidoSaidaDAO.GetMotivoExclusaoPedido;
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure Getmotivoexclusaopedido4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PedidoSaidaDAO    : TPedidoSaidaDAO;
    JsonObjectRetorno : TJsonObject;
    HrInicioLog: TTime;
begin
   PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try
      HrInicioLog := Time;
      JsonObjectRetorno := PedidoSaidaDAO.Getmotivoexclusaopedido4D(Req.Query.Dictionary);
      Res.Send<TJsonObject>(JsonObjectRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/motivoexclusaopedido4D', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonObjectRetorno.ToString,
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/motivoexclusaopedido4D', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetEvolucaoAtendimentoUnid(Req: THorseRequest; Res: THorseResponse;  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vZonaId: Integer;
  vRotaId: Integer;
  vParamsOk: Integer;
  JsonArrayErro: TJSonArray;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
   PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try
      HrInicioLog := Time;
      vDataIni := 0;
      vDataFin := 0;
      vZonaId := 0;
      vRotaId := 0;
      AQueryParam := Req.Query.Dictionary;

      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/pedido/dsboard/evolucaoatendimentounid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayErro.Count.ToString + ' Registros.', 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('datainicio') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/saida', Trim(Req.Params.Content.Text), Req.Body, '',
            'Retorno: ' + JsonArrayErro.Count.ToString + ' Registros.', 403,
            ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
            Req.Headers['versao']);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then
      Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafinal']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Final dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/pedido/dsboard/evolucaoatendimentounid',
            Trim(Req.Params.Content.Text), Req.Body, '', 'Data Final inválida!',
            403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '
            + Req.Headers['versao']);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('zonaid') then
      Begin
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaid') then
      Begin
        vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta definidos incorretamente!')));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
          Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayErro.Count.ToString + ' Registros.', 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      JsonArrayRetorno := PedidoSaidaDAO.GetEvolucaoAtendimentoUnid(vDataIni, vDataFin, vZonaId, vRotaId);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetEvolucaoAtendimentoUnidZona(Req: THorseRequest; Res: THorseResponse;  Next: TProc);
var PedidoSaidaDAO: TPedidoSaidaDAO;
    AQueryParam        : TDictionary<String, String>;
    vDataIni, vDataFin : TDateTime;
    vZonaIdStr         : String;
    vRotaId            : Integer;
    vParamsOk          : Integer;
    JsonArrayErro      : TJSonArray;
    JsonArrayRetorno   : TJSonArray;
    HrInicioLog        : TTime;
begin
  PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try
      HrInicioLog := Time;
      vDataIni    := 0;
      vDataFin    := 0;
      vZonaIdStr  := '';
      vRotaId     := 0;
      AQueryParam := Req.Query.Dictionary;

      If AQueryParam.Count <= 0 then Begin
         JsonArrayErro := TJSonArray.Create();
         JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
         Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedido/dsboard/evolucaoatendimentounid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayErro.Count.ToString + ' Registros.',
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(PedidoSaidaDAO);
         Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('datainicio') then Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicio']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/pedido/dsboard/evolucaoatendimentounid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayErro.Count.ToString + ' Registros.',
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafinal']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonArrayErro := TJSonArray.Create();
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.BadRequest);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedido/dsboard/evolucaoatendimentounid', Trim(Req.Params.Content.Text), Req.Body, '', 'Data Final inválida!',
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('zonaidstr') then Begin
         vZonaIdStr := AQueryParam.Items['zonaidstr'];
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaid') then Begin
         vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then Begin
         JsonArrayErro := TJSonArray.Create();
         JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
         Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.BadRequest);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedido/dsboard/evolucaoatendimentounid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayErro.Count.ToString + ' Registros.',
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(PedidoSaidaDAO);
         Exit;
      End;
      JsonArrayRetorno := PedidoSaidaDAO.GetEvolucaoAtendimentoUnidZona(vDataIni, vDataFin, vRotaId, vZonaIdStr);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/dsboard/evolucaoatendimentounid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentounid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetEvolucaoAtendimentoUnidEmbalagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoSaidaDAO: TPedidoSaidaDAO;
    AQueryParam : TDictionary<String, String>;
    vDataIni, vDataFin: TDateTime;
    vZonaIdStr  : String;
    vRotaId     : Integer;
    vParamsOk   : Integer;
    vTipo       : String;
    JsonErro    : TJSonArray;
    JsonArrayRetorno : TJSonArray;
    HrInicioLog      : TTime;
begin
  PedidoSaidaDAO := TPedidoSaidaDAO.Create;
  Try
    Try
      HrInicioLog := Time;
      vDataIni    := 0;
      vDataFin    := 0;
      vZonaIdStr  := '';
      vRotaId     := 0;
      vTipo       := '';
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
         JsonErro := TJSonArray.Create();
         JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
         Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],  0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedido/dsboard/evolucaoatendimentounidembalagem', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonErro.Count.ToString + ' Registros.',
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(JsonErro);
         FreeAndNil(PedidoSaidaDAO);
         Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('datainicio') then Begin
         Try
           vDataIni := StrToDate(AQueryParam.Items['datainicio']);
           vParamsOk := vParamsOk + 1;
         Except
           JsonErro := TJSonArray.Create();
           JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
           Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/pedido/dsboard/evolucaoatendimentounidembalagem', Trim(Req.Params.Content.Text), Req.Body, '', 'Data Inicial inválida!',
                           403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           FreeAndNil(PedidoSaidaDAO);
           Exit;
         End;
      End;
      if AQueryParam.ContainsKey('datafinal') then Begin
         Try
           vDataFin := StrToDate(AQueryParam.Items['datafinal']);
           vParamsOk := vParamsOk + 1;
         Except
           JsonErro := TJSonArray.Create();
           JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida')));
           Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/pedido/dsboard/evolucaoatendimentounidembalagem', Trim(Req.Params.Content.Text), Req.Body, '', 'Data Final inválida!',
                           403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           FreeAndNil(PedidoSaidaDAO);
           Exit;
         End;
      End;
      if AQueryParam.ContainsKey('zonaidstr') then Begin
         vZonaIdStr := AQueryParam.Items['zonaidstr'];
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaid') then Begin
         vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('tipo') then Begin
         vTipo := AQueryParam.Items['tipo'];
         vParamsOk := vParamsOk + 1;
      End
      else
         vParamsOk := -1;
      if vParamsOk <> AQueryParam.Count then Begin
         JsonErro := TJSonArray.Create();
         JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
         Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/pedido/dsboard/evolucaoatendimentounidembalagem', Trim(Req.Params.Content.Text), Req.Body, '', 'Parâmetros inválidos!',
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(PedidoSaidaDAO);
         Exit;
      End;
      JsonArrayRetorno := PedidoSaidaDAO.GetEvolucaoAtendimentoUnidEmbalagem(vDataIni, vDataFin, vRotaId, vTipo, vZonaIdStr);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/dsboard/evolucaoatendimentounidembalagem', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/dsboard/evolucaoatendimentounidembalagem', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure CancelarCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonErro: TJSonArray;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.CancelarCubagem
        (Req.Params.Items['pedidoid'].ToInteger());
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/saida/cancelarcubagem/:pedidoid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonErro := TJSonArray.Create;
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/cancelarcubagem/:pedidoid', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

procedure CreateVolumeCaixaFechada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjPedidoSaidaDAO: TPedidoSaidaDAO;
  JsonRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonRetorno := ObjPedidoSaidaDAO.CreateVolumeCaixaFechada(Req.Body<TJSonArray>);
      Res.Send<TJSonArray>(JsonRetorno).Status(THttpStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      'v1/saida/gerarvolumecaixafechada', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonRetorno := TJSonArray.Create;
        JsonRetorno.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        'v1/saida/gerarvolumecaixafechada', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    If Assigned(ObjPedidoSaidaDAO) then
       FreeAndNil(ObjPedidoSaidaDAO);
  End;
end;

procedure CreateVolumeCaixaFracionada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonRetorno := PedidoSaidaDAO.CreateVolumeCaixaFracionada(Req.Body<TJSonArray>);
      Res.Send<TJSonArray>(JsonRetorno).Status(THttpStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida/gerarvolumecaixafracionada', Trim(Req.Params.Content.Text), Copy(Req.Body, 1, 8000), '', 'Retorno: ' + JsonRetorno.Count.ToString +' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        jsonRetorno := TjsonArray.Create;
        JsonRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message + #13 + #10 + 'Verifique a estrutura do json!')));
        Res.Send<TJSonArray>(JsonRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/gerarvolumecaixafracionada', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    PedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Try
      JsonRetorno := PedidoSaidaDAO.GetID(0);
      Res.Send<TJSonArray>(JsonRetorno).Status(THttpStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonRetorno := TJSonArray.Create;
        JsonRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure GetDocumento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetDocumento
        (Req.Params.Items['documentonr'], Req.Params.Items['pessoaid']
        .ToInteger);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/saida/documento/:documentonr/:pessoaid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        JsonArrayRetorno := TJSonArray.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/saida/documento/:documentonr/:pessoaid',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    HrInicioLog := Time;
    try
      if Req.Params.ContainsKey('pedidoid') then
      Begin
        PedidoSaidaDAO := TPedidoSaidaDAO.Create;
        JsonArrayRetorno := PedidoSaidaDAO.GetID
          (StrToIntDef(Req.Params.Items['pedidoid'], 0));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End
      Else
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetro inexistente na requisição.')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '',
          'Parâmetros Inválidos!', 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        JsonArrayRetorno := TJSonArray.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetPedidoAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  TestePedido: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vDocumentoNr, vRegistroERP, vRazao, vNotaFiscalERP: String;
  vPedidoId, vCodigoERP, vPessoaId, vRotaId, vRotaIdfinal, vZonaId: Integer;
  vProcessoId, vMontarCarga, vPedidoPendente, vCargaId: Integer;
  vCodProduto: Int64;
  vParamsOk: Integer;
  JsonErro: TJSonArray;

  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    try
      vPedidoId := 0;
      vDataIni := 0;
      vDataFin := 0;
      vDocumentoNr := '';
      vRegistroERP := '';
      vCodigoERP := 0;
      vPessoaId := 0;
      vRazao := '';
      vRotaId := 0;
      vRotaIdfinal := 0;
      vZonaId := 0;
      vProcessoId := 0;
      vMontarCarga := 0;
      vCodProduto := 0;
      vPedidoPendente := 0;
      vCargaId := 0;
      vNotaFiscalERP := '';
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('dataini') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['dataini']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonErro := TJSonArray.Create;
          JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafin') then Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafin']);
          vParamsOk := vParamsOk + 1;
        Except
          JsonErro := TJSonArray.Create;
          JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
          Res.Send<TJSonArray>(JsonErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('pedidoid') then Begin
        vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codigoerp') then Begin
        vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('pessoaid') then Begin
        vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('documentonr') then Begin
        vDocumentoNr := AQueryParam.Items['documentonr'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('razao') then Begin
        vRazao := AQueryParam.Items['razao'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('registroerp') then Begin
        vRegistroERP := AQueryParam.Items['registroerp'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaid') then Begin
        vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaidfinal') then Begin
        vRotaIdfinal := StrToIntDef(AQueryParam.Items['rotaidfinal'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('zonaid') then Begin
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('processoid') then Begin
        vProcessoId := StrToIntDef(AQueryParam.Items['processoid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('montarcarga') then Begin
        vMontarCarga := StrToIntDef(AQueryParam.Items['montarcarga'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codproduto') then Begin
        vCodProduto := StrToInt64Def(AQueryParam.Items['codproduto'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('pedidopendente') then Begin
        vPedidoPendente := StrToInt64Def(AQueryParam.Items['pedidopendente'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('cargaid') then Begin
        vCargaId := StrToInt64Def(AQueryParam.Items['cargaid'], 0);
        Inc(vParamsOk);
      End;
      if AQueryParam.ContainsKey('notafiscalerp') then Begin
        vNotaFiscalERP := AQueryParam.Items['notafiscalerp'];
        Inc(vParamsOk);
      End;

      if vParamsOk <> AQueryParam.Count then Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.Forbidden);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.GetPedidoAll(vPedidoId, vDataIni, vDataFin, vCodigoERP, vPessoaId, vRazao, vDocumentoNr, vRegistroERP, vRotaId,
                          vRotaIdfinal, vZonaId, vProcessoId, vMontarCarga, vCodProduto, vPedidoPendente, vCargaId, vNotaFiscalERP);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida/pedido',
                      Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
                      ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonErro := TJSonArray.Create;
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
                        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetPedidoParaCargas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  TestePedido: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vDocumentoNr, vRegistroERP, vRazao : String;
  vPedidoId, vCodigoERP, vPessoaId, vRotaId, vRotaIdfinal, vZonaId: Integer;
  vMontarCarga, vCargaId, vParamsOk : Integer;
  JsonErro: TJSonArray;

  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    try
      vPedidoId := 0;
      vDataIni := 0;
      vDataFin := 0;
      vDocumentoNr := '';
      vRegistroERP := '';
      vCodigoERP := 0;
      vPessoaId := 0;
      vRazao := '';
      vRotaId := 0;
      vRotaIdfinal := 0;
      vZonaId := 0;
      vMontarCarga := 0;
      vCargaId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
         JsonErro := TJSonArray.Create();
         JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos!')));
         Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
         FreeAndNil(LService);
         Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('dataini') then Begin
         Try
           vDataIni := StrToDate(AQueryParam.Items['dataini']);
           vParamsOk := vParamsOk + 1;
         Except
           JsonErro := TJSonArray.Create;
           JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
           Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                           403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           FreeAndNil(LService);
           Exit;
         End;
      End;
      if AQueryParam.ContainsKey('datafin') then Begin
         Try
           vDataFin := StrToDate(AQueryParam.Items['datafin']);
           vParamsOk := vParamsOk + 1;
         Except
           JsonErro := TJSonArray.Create;
           JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
           Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                           403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           FreeAndNil(LService);
           Exit;
         End;
      End;
      if AQueryParam.ContainsKey('pedidoid') then Begin
         vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codigoerp') then Begin
         vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('pessoaid') then Begin
         vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('documentonr') then Begin
         vDocumentoNr := AQueryParam.Items['documentonr'];
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('razao') then Begin
         vRazao := AQueryParam.Items['razao'];
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('registroerp') then Begin
         vRegistroERP := AQueryParam.Items['registroerp'];
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaid') then Begin
         vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('rotaidfinal') then Begin
         vRotaIdfinal := StrToIntDef(AQueryParam.Items['rotaidfinal'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('zonaid') then Begin
         vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('montarcarga') then Begin
         vMontarCarga := StrToIntDef(AQueryParam.Items['montarcarga'], 0);
         vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('cargaid') then Begin
         vCargaId := StrToInt64Def(AQueryParam.Items['cargaid'], 0);
         Inc(vParamsOk);
      End;
      if vParamsOk <> AQueryParam.Count then Begin
         JsonErro := TJSonArray.Create();
         JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta definidos incorretamente!')));
         Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.Forbidden);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/saida/pedido', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]),
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(LService);
         Exit;
      End;
      JsonArrayRetorno := LService.GetPedidoParaCargas(vPedidoId, vDataIni, vDataFin, vCodigoERP, vPessoaId, vRazao, vDocumentoNr, vRegistroERP, vRotaId,
                                                       vRotaIdfinal, vZonaId, vMontarCarga, vCargaId);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida/pedidoparacargas', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonErro := TJSonArray.Create;
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/pedidoparacargas', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetPedidoResumoAtendimento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PedidoSaidaDAO: TPedidoSaidaDAO;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetPedidoResumoAtendimento(StrToIntDef(Req.Params.Items['pedidoid'], 0),
                          StrToIntDef(Req.Params.Items['divergencia'], 0), 0, 0);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida/resumoatendimento/:pedidoid/:divergencia/:datainicial/:datafinal', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/resumoatendimento/:pedidoid/:divergencia/:datainicial/:datafinal', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetClientesRotaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var JsonErro: TJSonArray;
    PedidoSaidaDAO: TPedidoSaidaDAO;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    PedidoSaidaDAO := TPedidoSaidaDAO.Create;
    try
      If Req.Query.Count <= 0 then
      Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/clientesrotacarga', Trim(Req.Params.Content.Text),
          Req.Body, '', JsonErro.ToString(), 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End
      Else
      Begin;
        JsonArrayRetorno := PedidoSaidaDAO.GetClientesRotaCarga(Req.Query.Dictionary);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/clientesrotacarga', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
                        ' Registros.', 201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/clientesrotacarga', Trim(Req.Params.Content.Text), Req.Body, '',
                        E.Message, 500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

procedure GetPendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  HrInicioLog: TTime;
  JsonArrayRetorno: TJSonArray;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetPendente;
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/saida/pendente', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/pendente', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetEstoqueCaixaFechada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var PedidoSaidaDAO: TPedidoSaidaDAO;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetEstoqueCaixaFechada(StrToIntDef(Req.Params.Items['pedidoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida/pedidocubagem_caixafechada/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201,  ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/pedidocubagem_caixafechada/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetLoteParaVolumeFracionado(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetLoteParaVolumeFracionado
        (StrToIntDef(Req.Params.Items['pedidoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/saida/loteparavolumefracionado/:pedidoid',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Verifique a estrutura do json!')));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/loteparavolumefracionado/:pedidoid',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetEstoqueCaixaFracionada(Req: THorseRequest; Res: THorseResponse;Next: TProc);
var PedidoSaidaDAO: TPedidoSaidaDAO;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    PedidoSaidaDAO := TPedidoSaidaDAO.Create;
    try
      JsonArrayRetorno := PedidoSaidaDAO.GetEstoqueCaixaFracionada(StrToIntDef(Req.Params.Items['pedidoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida/pedidocubagem_caixafracionada/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message + #13 + #10 + 'Verifique a estrutura do json!')));
        Res.Status(500).Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/pedidocubagem_caixafracionada/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPedidoSaida: TJSONObject;
  PedidoSaidaDAO: TPedidoSaidaDAO;
begin
  Try
    Try
      jsonPedidoSaida := TJSONObject.Create;
      jsonPedidoSaida := Req.Body<TJSONObject>;
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      PedidoSaidaDAO.PedidoSaida := PedidoSaidaDAO.PedidoSaida.JsonToClass
        (jsonPedidoSaida.ToString());
      if PedidoSaidaDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Verifique a estrutura do json!')))
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(jsonPedidoSaida);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPedidoSaida: TJSONObject;
  PedidoSaidaDAO: TPedidoSaidaDAO;
begin
  Try
    Try
      jsonPedidoSaida := TJSONObject.Create;
      jsonPedidoSaida := Req.Body<TJSONObject>;
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      PedidoSaidaDAO.InsertUpdate(GetValueInjSon(jsonPedidoSaida, 'pedidoid')
        .ToInteger(), GetValueInjSon(jsonPedidoSaida, 'operacaotipoid')
        .ToInteger(), GetValueInjSon(jsonPedidoSaida, 'pessoaid').ToInteger(),
        GetValueInjSon(jsonPedidoSaida, 'documentonr'),
        StrToIntDef(GetValueInjSon(jsonPedidoSaida, 'documentodata'), 0), 0);
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
    FreeAndNil(jsonPedidoSaida);
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      PedidoSaidaDAO.Cancelar(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro Cancelado com Sucesso!'))).Status(THttpStatus.NoContent);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida/cancelar', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace((TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro Cancelado com Sucesso!'))).ToString, #39, '', [rfReplaceAll]),
        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/saida/cancelar', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                       500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      PedidoSaidaDAO.PedidoSaida.PedidoId :=
        StrToIntDef(Req.Params.Items['Pedidoid'], 0);
      PedidoSaidaDAO.Delete;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/saida/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace((TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).ToString, #39, '', [rfReplaceAll]),
        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure DeletePedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServicePedidoSaida;
    JsonArrayReq, JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      JsonArrayReq := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSonArray;
      LService := TServicePedidoSaida.Create;
      JsonArrayRetorno := LService.DeletePedido(JsonArrayReq);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/saida', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetPedidoProcesso(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetPedidoProcesso
        (StrToIntDef(Req.Params.Items['pedidoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/processo/:pedidoid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/processo/:pedidoid', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure Processamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vPedidoId, vCodigoERP, vProcessoId, vRotaId, vRotaIdfinal, vZonaId, vRecebido,
    vCubagem, vEtiqueta: Integer;
  ErroJsonArray: TJSonArray;
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    Try
      // Processos - Etapas dos Pedidos
      vPedidoId    := 0;
      vDataIni     := 0;
      vDataFin     := 0;
      vCodigoERP   := 0;
      vProcessoId  := 0;
      vRotaId      := 0;
      vRotaIdfinal := 0;
      vZonaId      := 0;
      vRecebido    := 0;
      vCubagem     := 0;
      vEtiqueta    := 0;
      AQueryParam  := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
         ErroJsonArray := TJSonArray.Create;
         ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os parâmetros para cubagem!')));
         Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/saida/processamento', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]),
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         ErroJsonArray := Nil;
      End
      Else Begin
         if AQueryParam.ContainsKey('dataini') then
            vDataIni := StrToDate(AQueryParam.Items['dataini']);
         if AQueryParam.ContainsKey('datafin') then
            vDataFin := StrToDate(AQueryParam.Items['datafin']);
         if vDataIni > vDataFin then Begin
            ErroJsonArray := TJSonArray.Create;
            ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Período para Cubagem inválido')));
            Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
            Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                            '/v1/saida/processamento', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]),
                            403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
            ErroJsonArray := Nil;
            Exit;
         End;
         if AQueryParam.ContainsKey('pedidoid') then
            vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
         if AQueryParam.ContainsKey('codigoerp') then
            vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
         if AQueryParam.ContainsKey('processoid') then
            vProcessoId := AQueryParam.Items['processoid'].ToInteger();
         if AQueryParam.ContainsKey('rotaid') then
            vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
         if AQueryParam.ContainsKey('rotaidfinal') then
            vRotaIdfinal := StrToIntDef(AQueryParam.Items['rotaidfinal'], 0);
         if AQueryParam.ContainsKey('zonaid') then
            vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
         if AQueryParam.ContainsKey('recebido') then
            vRecebido := StrToInt(AQueryParam.Items['recebido']);
         if AQueryParam.ContainsKey('cubagem') then
            vCubagem := StrToInt(AQueryParam.Items['cubagem']);
         if AQueryParam.ContainsKey('etiqueta') then
            vEtiqueta := StrToInt(AQueryParam.Items['etiqueta']);
         JsonArrayRetorno := TJSonArray.Create;
         JsonArrayRetorno := LService.PedidoParaProcessamento(vPedidoId, vCodigoERP, vDataIni, vDataFin,
                             vProcessoId, vRotaId, vRotaIdfinal, vZonaId, vRecebido, vCubagem, vEtiqueta);
         Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/saida/processamento', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                         201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        ErroJsonArray := TJSonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/processamento', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure PedidoProcessar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vDocumentoNr, vRegistroERP, vRazao: String;
  vPedidoId, vCodigoERP, vPessoaId, vRotaId, vRotaIdfinal, vZonaId: Integer;
  vProcessoId, vRecebido, vCubagem, vEtiqueta, vPrintTag, vEmbalagem: Integer;
  JsonArrayRetorno: TJSonArray;
  ErroJsonArray: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      // Processos - Etapas dos Pedidos
      vPedidoId := 0;
      vDataIni := 0;
      vDataFin := 0;
      vDocumentoNr := '';
      vRegistroERP := '';
      vCodigoERP := 0;
      vPessoaId := 0;
      vRazao := '';
      vRotaId := 0;
      vRotaIdfinal := 0;
      vZonaId := 0;
      vProcessoId := 0;
      vRecebido := 0;
      vCubagem := 0;
      vEtiqueta := 0;
      vPrintTag := 2;
      vEmbalagem := 2;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        ErroJsonArray := TJSonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os parâmetros para cubagem!')));
        Res.Send<TJSonArray>(ErroJsonArray)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/cubagem', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]), 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        ErroJsonArray := Nil;
      End
      Else
      Begin
        if AQueryParam.ContainsKey('dataini') then
          vDataIni := StrToDate(AQueryParam.Items['dataini']);
        if AQueryParam.ContainsKey('datafin') then
          vDataFin := StrToDate(AQueryParam.Items['datafin']);
        if vDataIni > vDataFin then
        Begin
          ErroJsonArray := TJSonArray.Create;
          ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Período para Cubagem inválido')));
          Res.Send<TJSonArray>(ErroJsonArray)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/saida/cubagem', Trim(Req.Params.Content.Text), Req.Body, '',
            StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]), 403,
            ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
            Req.Headers['versao']);
          ErroJsonArray := Nil;
          Exit;
        End;
        if AQueryParam.ContainsKey('pedidoid') then
          vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('codigoerp') then
          vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
        if AQueryParam.ContainsKey('pessoaid') then
          vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
        if AQueryParam.ContainsKey('documentonr') then
          vDocumentoNr := AQueryParam.Items['documentonr'];
        if AQueryParam.ContainsKey('razao') then
          vRazao := AQueryParam.Items['razao'];
        if AQueryParam.ContainsKey('registroerp') then
          vRegistroERP := AQueryParam.Items['registroerp'];
        if AQueryParam.ContainsKey('rotaid') then
          vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        if AQueryParam.ContainsKey('rotaid') then
          vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        if AQueryParam.ContainsKey('rotaidfinal') then
          vRotaIdfinal := StrToIntDef(AQueryParam.Items['rotaidfinal'], 0);
        if AQueryParam.ContainsKey('zonaid') then
          vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        if AQueryParam.ContainsKey('processoid') then
          vProcessoId := AQueryParam.Items['processoid'].ToInteger();
        if AQueryParam.ContainsKey('recebido') then
          vRecebido := StrToInt(AQueryParam.Items['recebido']);
        if AQueryParam.ContainsKey('cubagem') then
          vCubagem := StrToInt(AQueryParam.Items['cubagem=0']);
        if AQueryParam.ContainsKey('etiqueta') then
          vEtiqueta := StrToInt(AQueryParam.Items['etiqueta']);
        if AQueryParam.ContainsKey('printtag') then
          vPrintTag := StrToInt(AQueryParam.Items['printtag']);
        if AQueryParam.ContainsKey('embalagem') then
          vEmbalagem := StrToInt(AQueryParam.Items['embalagem']);
        PedidoSaidaDAO := TPedidoSaidaDAO.Create;
        JsonArrayRetorno := PedidoSaidaDAO.PedidoProcessar(vPedidoId, vDataIni,
          vDataFin, vCodigoERP, vPessoaId, vDocumentoNr, vRazao, vRegistroERP,
          vRotaId, vRotaIdfinal, vZonaId, vProcessoId, vRecebido, vCubagem,
          vEtiqueta, vPrintTag, vEmbalagem);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/cubagem', Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    Except
      on E: Exception do
      Begin
        ErroJsonArray := TJSonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(ErroJsonArray)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/cubagem', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure PedidoPrintTag(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PedidoSaidaDAO: TPedidoSaidaDAO;
    AQueryParam: TDictionary<String, String>;
    vDataIni, vDataFin: TDateTime;
    vRazao: String;
    vPedidoId, vPedidoVolumeId, vCodigoERP, vPessoaId, vRotaId, vRotaIdfinal,
      vZonaId: Integer;
    vProcessoId, vRecebido, vCubagem, vEtiqueta, vPrintTag, vEmbalagem: Integer;
    ErroJsonArray: TJSonArray;
    HrInicioLog: TTime;
    JsonArrayRetorno: TJSonArray;
begin
  Try
    HrInicioLog := Time;
    Try
      // Processos - Etapas dos Pedidos
      vPedidoId       := 0;
      vPedidoVolumeId := 0;
      vDataIni        := 0;
      vDataFin        := 0;
      vCodigoERP      := 0;
      vPessoaId       := 0;
      vRazao          := '';
      vRotaId         := 0;
      vRotaIdfinal    := 0;
      vZonaId         := 0;
      vProcessoId     := 0;
      vRecebido       := 0;
      vCubagem        := 0;
      vEtiqueta       := 0;
      vPrintTag       := 2;
      vEmbalagem      := 2;
      AQueryParam     := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then Begin
        ErroJsonArray := TJSonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os parâmetros para cubagem!')));
        Res.Send<TJSonArray>(ErroJsonArray)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/printtag', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]),
                        403, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End
      Else Begin
        if AQueryParam.ContainsKey('dataini') then
           vDataIni := StrToDate(AQueryParam.Items['dataini']);
        if AQueryParam.ContainsKey('datafin') then
           vDataFin := StrToDate(AQueryParam.Items['datafin']);
        if vDataIni > vDataFin then Begin
           ErroJsonArray := TJSonArray.Create;
           ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Período para impressão de Tag inválido!')));
           Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                          '/v1/saida/printtag', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(ErroJsonArray.ToString, #39, '', [rfReplaceAll]),
                          403,((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+ Req.Headers['versao']);
           Exit;
        End;
        if AQueryParam.ContainsKey('pedidoid') then
           vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
        if AQueryParam.ContainsKey('pedidovolumeid') then
           vPedidoVolumeId := StrToIntDef(AQueryParam.Items['pedidovolumeid'], 0);
        if AQueryParam.ContainsKey('codigoerp') then
           vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
        if AQueryParam.ContainsKey('pessoaid') then
           vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
        if AQueryParam.ContainsKey('razao') then
           vRazao := AQueryParam.Items['razao'];
        if AQueryParam.ContainsKey('rotaid') then
           vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        if AQueryParam.ContainsKey('rotaid') then
           vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
        if AQueryParam.ContainsKey('rotaidfinal') then
           vRotaIdfinal := StrToIntDef(AQueryParam.Items['rotaidfinal'], 0);
        if AQueryParam.ContainsKey('zonaid') then
           vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0);
        if AQueryParam.ContainsKey('processoid') then
           vProcessoId := AQueryParam.Items['processoid'].ToInteger();
        if AQueryParam.ContainsKey('recebido') then
           vRecebido := StrToInt(AQueryParam.Items['recebido']);
        if AQueryParam.ContainsKey('cubagem') then
           vCubagem := StrToInt(AQueryParam.Items['cubagem']);
        if AQueryParam.ContainsKey('etiqueta') then
           vEtiqueta := StrToInt(AQueryParam.Items['etiqueta']);
        if AQueryParam.ContainsKey('printtag') then
           vPrintTag := StrToInt(AQueryParam.Items['printtag']);
        if AQueryParam.ContainsKey('embalagem') then
           vEmbalagem := StrToInt(AQueryParam.Items['embalagem']);
        PedidoSaidaDAO   := TPedidoSaidaDAO.Create;
        JsonArrayRetorno := PedidoSaidaDAO.PedidoPrintTag(vPedidoId, vPedidoVolumeId,
                            vDataIni, vDataFin, vCodigoERP, vPessoaId, vRazao, vRotaId,
                            vRotaIdfinal, vZonaId, vProcessoId, vRecebido, vCubagem,
                            vEtiqueta, vPrintTag, vEmbalagem);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/printtag', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '+Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        ErroJsonArray := TJSonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(ErroJsonArray).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/printtag', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetRelAtendimentoRota(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    AQueryParam := Req.Query.Dictionary;
    If AQueryParam.Count <> 2 then
    Begin
      JsonArrayErro := TJSonArray.Create();
      JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
        'Parâmetros da consulta não definidos!')));
      Res.Send<TJSonArray>(JsonArrayErro)
        .Status(THttpStatus.InternalServerError);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/atedimento/rota', Trim(Req.Params.Content.Text), Req.Body,
        '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
      JsonArrayErro := Nil;
      Exit;
    End;
    Try
      if AQueryParam.ContainsKey('datainicial') then
        vDataIni := StrToDate(AQueryParam.Items['datainicial']);
      if AQueryParam.ContainsKey('datafinal') then
        vDataFin := StrToDate(AQueryParam.Items['datafinal']);
      if vDataIni > vDataFin then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período para Cubagem inválido')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        JsonArrayErro := Nil;
        Exit;
      End;
      JsonArrayRetorno := LService.GetRelAtendimentoRota(vDataIni, vDataFin);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/atedimento/rota', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/atedimento/rota', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetRelAtendimentoDestinatario(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    AQueryParam := Req.Query.Dictionary;
    Try
      If AQueryParam.Count <> 2 then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/atedimento/destinatario', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      if AQueryParam.ContainsKey('datainicial') then
        vDataIni := StrToDate(AQueryParam.Items['datainicial']);
      if AQueryParam.ContainsKey('datafinal') then
        vDataFin := StrToDate(AQueryParam.Items['datafinal']);
      if vDataIni > vDataFin then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período para Cubagem inválido')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/atedimento/destinatario', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        Exit;
      End;
      JsonArrayRetorno := LService.GetRelAtendimentoDestinatario(vDataIni,
        vDataFin);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/atedimento/destinatario', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/atedimento/destinatario', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetRelAtendimentoZona(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    AQueryParam := Req.Query.Dictionary;
    If AQueryParam.Count <> 2 then
    Begin
      JsonArrayErro := TJSonArray.Create();
      JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
        'Parâmetros da consulta não definidos!')));
      Res.Send<TJSonArray>(JsonArrayErro)
        .Status(THttpStatus.InternalServerError);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/atedimento/zona', Trim(Req.Params.Content.Text), Req.Body,
        '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
      JsonArrayErro := Nil;
      Exit;
    End;
    Try
      if AQueryParam.ContainsKey('datainicial') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['datainicial']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/pedido/atedimento/zona', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          JsonArrayErro := Nil;
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then
      Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafinal']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Final inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/pedido/atedimento/zona', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          JsonArrayErro := Nil;
          Exit;
        End;
      End;
      if vDataIni > vDataFin then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período para Cubagem inválido')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/atedimento/zona', Trim(Req.Params.Content.Text), Req.Body,
          '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        JsonArrayErro := Nil;
        Exit;
      End;
      LService := TServicePedidoSaida.Create;
      JsonArrayRetorno := LService.GetRelAtendimentoZona(vDataIni, vDataFin);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/atedimento/zona', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/atedimento/zona', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetReposicaoAutomatica(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetReposicaoAutomatica
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/ReposicaoAutomatica', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/ReposicaoAutomatica', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetReposicaoAutomaticaColeta(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetReposicaoAutomaticaColeta
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/ReposicaoAutomaticacoleta', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/ReposicaoAutomaticacoleta', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetConsultaReposicao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
  vErro: String;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetConsultaReposicao(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/reposicao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayRetorno.ToString, 500, ((Time - HrInicioLog) / 1000),
                         Req.Headers['appname'] + '_V: ' + Req.Headers['versao'])
      Else
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/reposicao/consulta', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/consulta', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;

end;

Procedure GetConsultaReposicaoProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetConsultaReposicaoProduto
        (StrToIntDef(Req.Params.Items['reposicaoid'], 0));
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/consulta/:reposicaoid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/consulta/:reposicaoid', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

procedure GetProdutoSemPicking(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjPedidoSaidaDAO  : TPedidoSaidaDAO;
  AQueryParam        : TDictionary<String, String>;
  vDataIni, vDataFin : TDateTime;
  vDocumentoNr, vRegistroERP, vRazao: String;
  vPedidoId, vCodigoERP, vPessoaId, vRotaId, vRecebido, vCubagem, vEtiqueta, vverificarEstoque: Integer;
  JsonArrayRetorno   : TJSonArray;
  HrInicioLog        : TTime;
begin
  Try
    ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
    Try
      HrInicioLog  := Time;
      // Processos - Etapas dos Pedidos
      vPedidoId    := 0;
      vDataIni     := 0;
      vDataFin     := 0;
      vDocumentoNr := '';
      vRegistroERP := '';
      vCodigoERP   := 0;
      vPessoaId    := 0;
      vRazao       := '';
      vRotaId      := 0;
      vverificarEstoque := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Defina os parâmetros para cubagem!')));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/saida/produtosempicking', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
                        [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(ObjPedidoSaidaDAO);
        Exit;
      End;
      if AQueryParam.ContainsKey('dataini') then
        vDataIni := StrToDate(AQueryParam.Items['dataini']);
    Except
      begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Data inicial inválida!')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/produtosempicking', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(ObjPedidoSaidaDAO);
        Exit;
      end;
    End;
    Try
      if AQueryParam.ContainsKey('datafin') then
        vDataFin := StrToDate(AQueryParam.Items['datafin']);
      if vDataIni > vDataFin then
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período inválido para o relatório!')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/produtosempicking', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(ObjPedidoSaidaDAO);
        Exit;
      End;
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Data Final inválida!')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        ObjPedidoSaidaDAO := TPedidoSaidaDAO.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/produtosempicking', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(ObjPedidoSaidaDAO);
        Exit;
      End;
    End;
    Try
      if AQueryParam.ContainsKey('pedidoid') then
         vPedidoId := StrToIntDef(AQueryParam.Items['pedidoid'], 0);
      if AQueryParam.ContainsKey('codigoerp') then
         vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
      if AQueryParam.ContainsKey('pessoaid') then
         vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
      if AQueryParam.ContainsKey('documentonr') then
         vDocumentoNr := AQueryParam.Items['documentonr'];
      if AQueryParam.ContainsKey('razao') then
         vRazao := AQueryParam.Items['razao'];
      if AQueryParam.ContainsKey('registroerp') then
         vRegistroERP := AQueryParam.Items['registroerp'];
      if AQueryParam.ContainsKey('rotaid') then
         vRotaId := StrToIntDef(AQueryParam.Items['rotaid'], 0);
      if AQueryParam.ContainsKey('verificarestoque') then
         vverificarEstoque := StrToIntDef(AQueryParam.Items['verificarestoque'], 0);

      // Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Cubagem realizada com sucesso!'))).Status(THTTPStatus.Created);
      JsonArrayRetorno := ObjPedidoSaidaDAO.ProdutoSemPicking(vPedidoId, vDataIni, vDataFin, vCodigoERP, vPessoaId,
                          vDocumentoNr, vRazao, vRegistroERP, vRotaId, vRecebido, vCubagem, vEtiqueta, vverificarEstoque);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/saida/produtosempicking', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/produtosempicking', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(ObjPedidoSaidaDAO);
  End;
end;

Procedure ReposicaoCancelar(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoSaida.Create;
      JsonArrayRetorno := LService.ReposicaoCancelar
        (TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0)
        as TJSONObject);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/cancelar', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/cancelar', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure ReposicaoExcluir(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoSaida.Create;
      JsonArrayRetorno := LService.ReposicaoExcluir
        (TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0)
        as TJSONObject);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/delete', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/delete', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure ReposicaoRegistrarInUse(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Res.Send('').Status(THttpStatus.Created);
  Exit;
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoSaida.Create;
      JsonArrayRetorno := LService.ReposicaoRegistrarInUse
        (StrToIntDef(Req.Params.Items['reposicaoid'], 0),
        StrToIntDef(Req.Params.Items['usuarioid'], 0),
        Req.Params.Items['terminal']);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
        Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port, '/v1/saida',
          Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure RegistrarProcesso(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      PedidoSaidaDAO.PedidoSaida.PedidoId :=
        StrToIntDef(Req.Params.Items['documento'], 0);
      // PedidoSaidaDAO.Delete;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/saida/processo', Trim(Req.Params.Content.Text), Req.Body, '',
        StringReplace(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!')).ToString, #39, '', [rfReplaceAll]),
        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/saida/processo', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message)).ToString, #39, '', [rfReplaceAll]), 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

constructor TPedidoSaidaCtrl.Create;
begin
  FPedidoSaida := TPedidoSaida.Create;
end;

destructor TPedidoSaidaCtrl.Destroy;
begin
  FreeAndNil(FPedidoSaida);
  inherited;
end;

Procedure GetCortes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetCortes(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/cortes', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/cortes', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure DeleteReservaCorrecao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.DeleteReservaCorrecao();
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/reservacorrecao', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/reservacorrecao', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetResumoProducao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetResumoProducao
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/resumoproducao', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/resumoproducao', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetSaidaPorProdutoBalanceamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetSaidaPorProdutoBalanceamento(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/saidaporproduto/balanceamento', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/saidaporproduto/balanceamento', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetAuditoriaSaidaPorProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetAuditoriaSaidaPorProduto
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/saidaporproduto', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/saidaporproduto', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetMovimentacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetMovimentacao(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/movimentacao', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/movimentacao', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetProdutoReposicao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetProdutoReposicao
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/produtos', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/produtos', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetRelApanhePicking(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetRelApanhePicking
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/apanhepicking', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/apanhepicking', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetRelColetaPulmao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetRelColetaPulmao
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/coletapulmao', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/coletapulmao', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetRelRupturaAbastecimento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  pDataIni, pDataFin: TDateTime;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      AQueryParam := Req.Query.Dictionary;
      if AQueryParam.Items['dataini'] = '0' then
        pDataIni := 0
      Else
        pDataIni := StrToDate(AQueryParam.Items['dataini']);
      if AQueryParam.Items['datafin'] = '0' then
        pDataFin := 0
      Else
        pDataFin := StrToDate(AQueryParam.Items['datafin']);
      JsonArrayRetorno := PedidoSaidaDAO.GetRelRupturaAbastecimento(pDataIni,
        pDataFin);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/rupturaabastecimento', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/rupturaabastecimento', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetRelAnaliseRessuprimento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetRelAnaliseRessuprimento
        (Req.Query.Dictionary, False);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/analiseressuprimento', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/analiseressuprimento', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetRelAnaliseRessuprimentoVolume(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetRelAnaliseRessuprimento
        (Req.Query.Dictionary, True);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/analiseressuprimentovolume', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/analiseressuprimentovolume',
          Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetReposicaoEnderecoColeta(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  vData: TDateTime;
  vZonaId: Integer;
  vEnderecoInicial, vEnderecoFinal: String;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    PedidoSaidaDAO := TPedidoSaidaDAO.Create;
    HrInicioLog := Time;
    Try
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 4 then
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos corretamente!')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/enderecocoleta', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      If AQueryParam.ContainsKey('zonaid') then
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0)
      Else
        vZonaId := 0;
      If AQueryParam.ContainsKey('enderecoinicial') then
        vEnderecoInicial := AQueryParam.Items['enderecoinicial']
      Else
        vEnderecoInicial := '';
      If AQueryParam.ContainsKey('enderecofinal') then
        vEnderecoFinal := AQueryParam.Items['enderecofinal']
      Else
        vEnderecoFinal := '';
      if AQueryParam.ContainsKey('data') then
      Begin
        Try
          vData := StrToDate(AQueryParam.Items['data']);
        Except
          JsonArrayRetorno := TJSonArray.Create;
          JsonArrayRetorno.AddElement
            (TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial é inválida!')));
          Res.Send<TJSonArray>(JsonArrayRetorno)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/enderecocoleta', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(PedidoSaidaDAO);
          Exit;
        End;
      End
      Else
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos corretamente!')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/enderecocoleta', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      JsonArrayRetorno := PedidoSaidaDAO.GetReposicaoEnderecoColeta(vData,
        vZonaId, vEnderecoInicial, vEnderecoFinal);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/enderecocoleta', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/enderecocoleta', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetReposicaoDemanda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServicePedidoSaida;
    JsonArrayRetorno: TJSonArray;
    AQueryParam: TDictionary<String, String>;
    vData: TDateTime;
    vZonaId: Integer;
    vTipoGeracao: String;
    vEnderecoInicial, vEnderecoFinal: String;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoSaida.Create;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 4 then Begin
         JsonArrayRetorno := TJSonArray.Create();
         JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos corretamente!')));
         Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         '/v1/reposicao/demanda', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                         403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
         FreeAndNil(LService);
         Exit;
      End;
      if AQueryParam.ContainsKey('zonaid') then
         vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0)
      Else
         vZonaId := 0;
      if AQueryParam.ContainsKey('pickinginicial') then
         vEnderecoInicial := AQueryParam.Items['pickinginicial']
      else
         vEnderecoInicial := '';
      if AQueryParam.ContainsKey('pickingfinal') then
         vEnderecoFinal := AQueryParam.Items['pickingfinal']
      else
         vEnderecoFinal := '';
      if AQueryParam.ContainsKey('tipogeracao') then
         vTipoGeracao := AQueryParam.Items['tipogeracao']
      Else
         vTipoGeracao := '';
      if AQueryParam.ContainsKey('data') then Begin
         Try
           vData := StrToDate(AQueryParam.Items['data']);
         Except Begin
           JsonArrayRetorno := TJSonArray.Create;
           JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
           Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/reposicao/demanda', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                           403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           FreeAndNil(LService);
           Exit;
           End;
         End;
      End
      Else
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Parâmetros da consulta não definidos corretamente!')));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                       '/v1/reposicao/demanda', Trim(Req.Params.Content.Text), Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '', [rfReplaceAll]),
                       403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.GetReposicaoDemanda(vData, vZonaId, vEnderecoInicial, vEnderecoFinal, vTipoGeracao);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/reposicao/demanda', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/reposicao/demanda', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetReposicaoDemandaCapacidade(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vPercDownMaxPicking: Integer;
  vZonaId: Integer;
  vNegativo: Integer;
  vEnderecoInicial, vEnderecoFinal: String;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoSaida.Create;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 5 then
      Begin
        JsonArrayRetorno := TJSonArray.Create();
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos corretamente!')));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/demandacapacidade', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayRetorno.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      vPercDownMaxPicking :=
        StrToIntDef(AQueryParam.Items['percdownmaxpicking'], 0);
      if AQueryParam.ContainsKey('zonaid') then
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0)
      Else
        vZonaId := 0;
      if AQueryParam.ContainsKey('pickinginicial') then
        vEnderecoInicial := AQueryParam.Items['pickinginicial']
      else
        vEnderecoInicial := '';
      if AQueryParam.ContainsKey('pickingfinal') then
        vEnderecoFinal := AQueryParam.Items['pickingfinal']
      else
        vEnderecoFinal := '';
      if AQueryParam.ContainsKey('negativo') then
        vNegativo := AQueryParam.Items['negativo'].ToInteger()
      Else
        vNegativo := 1;
      JsonArrayRetorno := LService.GetReposicaoCapacidade(vPercDownMaxPicking,
        vZonaId, vEnderecoInicial, vEnderecoFinal, vNegativo);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/demandacapacidade', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/demandacapacidade', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetReposicaoDemandaColeta(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServicePedidoSaida;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      LService := TServicePedidoSaida.Create;
      JsonArrayRetorno := LService.GetReposicaoDemandaColeta(Req.Params.Items['tipogeracao']);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/reposicao/demanda/coleta/:tipogeracao', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/reposicao/demanda/coleta/:tipogeracao', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetReposicaoGerar(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  AQueryParam: TDictionary<String, String>;
  vData: TDateTime;
  vZonaId: Integer;
  vEnderecoInicial, vEnderecoFinal: String;
  JsonErro: TJSonArray;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    PedidoSaidaDAO := TPedidoSaidaDAO.Create;
    HrInicioLog := Time;
    Try
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 4 then
      Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos corretamente!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.Created);
        PedidoSaidaDAO := TPedidoSaidaDAO.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/gerar', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]), 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      if AQueryParam.ContainsKey('zonaid') then
        vZonaId := StrToIntDef(AQueryParam.Items['zonaid'], 0)
      Else
        vZonaId := 0;
      if AQueryParam.ContainsKey('enderecoinicial') then
        vEnderecoInicial := AQueryParam.Items['enderecoinicial']
      else
        vEnderecoInicial := '';
      if AQueryParam.ContainsKey('enderecofinal') then
        vEnderecoFinal := AQueryParam.Items['enderecofinal']
      else
        vEnderecoFinal := '';
      if AQueryParam.ContainsKey('data') then
      Begin
        Try
          vData := StrToDate(AQueryParam.Items['data']);
        Except
          Begin
            JsonErro := TJSonArray.Create;
            JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
              'Data Inicial dos Pedidos é inválida!')));
            Res.Send<TJSonArray>(JsonErro)
              .Status(THttpStatus.InternalServerError);
            PedidoSaidaDAO := TPedidoSaidaDAO.Create;
            Tutil.SalvarLog(Req.MethodType,
              StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
              ClientIP(Req), THorse.Port, '/v1/reposicao/gerar',
              Trim(Req.Params.Content.Text), Req.Body, '',
              StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]), 403,
              ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
              Req.Headers['versao']);
            FreeAndNil(PedidoSaidaDAO);
            Exit;
          End;
        End;
      End
      Else
      Begin
        JsonErro := TJSonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos corretamente!')));
        Res.Send<TJSonArray>(JsonErro).Status(THttpStatus.InternalServerError);
        PedidoSaidaDAO := TPedidoSaidaDAO.Create;
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/gerar', Trim(Req.Params.Content.Text), Req.Body, '',
          StringReplace(JsonErro.ToString, #39, '', [rfReplaceAll]), 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(PedidoSaidaDAO);
        Exit;
      End;
      JsonArrayRetorno := PedidoSaidaDAO.GetReposicaoGerar(vData, vZonaId,
        vEnderecoInicial, vEnderecoFinal);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/gerar', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonErro.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/gerar', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure PutAtualizarNFPedido(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayReq, JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoSaida.Create;
    Try
      JsonArrayReq := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSonArray;
      JsonArrayRetorno := LService.AtualizarNFPedido(JsonArrayReq);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/nfeerp', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                      201, ((Time - HrInicioLog) / 1000), 'Integracao');
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('pedido', TJsonNumber.Create(0)).AddPair('nfe', '')
          .AddPair('mensagem', E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/nfeerp', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), 'Integracao');
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure PutRegistrarProcesso(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.PutRegistrarProcesso(TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSONObject);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pedido/registrarprocesso/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: '+JsonArrayRetorno.Count.ToString+' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', 'Não foi o processo atual do Pedido! '+E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pedido/registrarprocesso/:pedidoid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure PutAtualizarNFPedidoV2(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayReq, JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    LService := TServicePedidoSaida.Create;
    Try
      JsonArrayReq := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSonArray;
      JsonArrayRetorno := LService.AtualizarNFPedidoV2(JsonArrayReq);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v2/pedido/nfeerp', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), 'Integracao');
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('status', '500')
                        .AddPair('pedido', TJsonNumber.Create(0)).AddPair('nfe', '')
                        .AddPair('mensagem', E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
                 Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                 '/v2/pedido/nfeerp', Trim(Req.Params.Content.Text), Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000), 'Integracao');
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure PutReposicaoTransferenciaPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var LService: TServicePedidoSaida;
    JsonTransferencia: TJSONObject;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
    Erro: Boolean;
    nTentativa: Integer;
begin
  nTentativa := 1;
  Repeat
    Erro := True;
    Try
      HrInicioLog := Time;
      LService := TServicePedidoSaida.Create;
      Try
        JsonTransferencia := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSONObject;
        JsonArrayRetorno := LService.ReposicaoTransferenciaPicking(JsonTransferencia);
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/reposicao/ReposicaoTransferenciaPicking', Trim(Req.Params.Content.Text), Req.Body, '',
                        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.',
                        201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        Erro := False;
      Except on E: Exception do Begin
        //Inc(nTentativa);
        if nTentativa > 3 then Begin
           JsonArrayRetorno := TJSonArray.Create;
           JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
           Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
           Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                           '/v1/reposicao/ReposicaoTransferenciaPicking', Trim(Req.Params.Content.Text), Req.Body, '', E.Message+'. Tentativa: '+nTentativa.ToString(),
                           500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
           Erro := False;
        End
        Else Begin
          Inc(nTentativa);
          Sleep(200);
          If nTentativa > 3 then
             Erro := False;
        End;
        End;
      End;
    Finally
      FreeAndNil(LService);
    End;
  Until (Erro = False);
End;

Procedure PutReposicaoSalvarItemColetado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PedidoSaidaDAO: TPedidoSaidaDAO;
    JsonArrayRetorno: TJSonArray;
    HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.ReposicaoSalvarItemColetado(Req.Body<TJSonArray>);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/reposicao/salvaritemcoletado', Trim(Req.Params.Content.Text), Req.Body, '',
                      'Retorno: ' + JsonArrayRetorno.Count.ToString+' Registros.',
                      201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/reposicao/salvaritemcoletado', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure PutReposicaoFinalizar(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.ReposicaoFinalizar
        (Req.Body<TJSonArray>);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/finalizar', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/finalizar', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure ReposicaoSalvar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.ReposicaoSalvar(Req.Body<TJSONObject>);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/salvar', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/salvar', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure DeleteReposicaoModelo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.DeleteReposicaoModelo
        (Req.Params.Items['modeloid'].ToInteger);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/modelo/:modeloid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/modelo/:modeloid', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
end;

Procedure GetReposicaoModelo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetReposicaoModelo
        (Req.Params.Items['modeloid'].ToInteger);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/modelo/:modeloid', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/modelo/:modeloid', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure PostReposicaoModelo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    Try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.PostReposicaoModelo
        (Req.Body<TJSONObject>);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/modelo', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/modelo', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetDashBoard0102(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSONObject;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetDashBoard0102(Req.Query.Dictionary);
      Res.Send<TJSONObject>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/dashboard0102', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message));
        Res.Send<TJSONObject>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/dashboard0102', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetProducaoPendente(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetProducaoPendente;
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Ok);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/producaopendente', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/producaopendente', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetDashBoard030405(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetDashBoard030405
        (Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/dashboard030405', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/dashboard030405', Trim(Req.Params.Content.Text), Req.Body,
          '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetDashBoard06(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PedidoSaidaDAO: TPedidoSaidaDAO;
  JsonArrayRetorno: TJSonArray;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      PedidoSaidaDAO := TPedidoSaidaDAO.Create;
      JsonArrayRetorno := PedidoSaidaDAO.GetDashBoard06(Req.Query.Dictionary);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/pedido/dashboard06', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Não foi possível salvar a reposição! ' +
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/pedido/dashboard06', Trim(Req.Params.Content.Text), Req.Body, '',
          E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(PedidoSaidaDAO);
  End;
End;

Procedure GetAnaliseColeta(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDataInicial, vDataFinal: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    AQueryParam := Req.Query.Dictionary;
    If AQueryParam.Count <= 0 then
    Begin
      JsonArrayErro := TJSonArray.Create();
      JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
        'Parâmetros da consulta não definidos!')));
      Res.Send<TJSonArray>(JsonArrayErro)
        .Status(THttpStatus.InternalServerError);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/analisecoleta', Trim(Req.Params.Content.Text), Req.Body,
        '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
      FreeAndNil(LService);
      Exit;
    End;
    Try
      vDataInicial := 0;
      vDataFinal := 0;
      if AQueryParam.ContainsKey('datainicial') then
      Begin
        Try
          vDataInicial := StrToDate(AQueryParam.Items['datainicial']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/analisecoleta', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then
      Begin
        Try
          vDataFinal := StrToDate(AQueryParam.Items['datafinal']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Final inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/analisecoleta', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if vDataInicial > vDataFinal then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período das reposições inválido!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/analisecoleta', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.GetAnaliseColeta(AQueryParam);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/analisecoleta', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/analisecoleta', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetRelHistoricoTransferenciaPicking(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDataInicial, vDataFinal: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    Try
      HrInicioLog := Time;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/historicotransferencia', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      vDataInicial := 0;
      vDataFinal := 0;
      if AQueryParam.ContainsKey('datainicial') then
      Begin
        Try
          vDataInicial := StrToDate(AQueryParam.Items['datainicial']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/historicotransferencia',
            Trim(Req.Params.Content.Text), Req.Body, '',
            StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
            ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
            Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then
      Begin
        Try
          vDataFinal := StrToDate(AQueryParam.Items['datafinal']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Final inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/historicotransferencia',
            Trim(Req.Params.Content.Text), Req.Body, '',
            StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
            ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
            Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if vDataInicial > vDataFinal then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período das reposições inválido!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/historicotransferencia', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.GetRelHistoricoTransferenciaPicking
        (AQueryParam);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/historicotransferencia', Trim(Req.Params.Content.Text),
        Req.Body, '', 'Retorno: ' + JsonArrayRetorno.Count.ToString +
        ' Registros.', 201, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/historicotransferencia', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetRelReposicaoTransfPicking(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDataInicial, vDataFinal: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    LService := TServicePedidoSaida.Create;
    HrInicioLog := Time;
    AQueryParam := Req.Query.Dictionary;
    If AQueryParam.Count <= 0 then
    Begin
      JsonArrayErro := TJSonArray.Create();
      JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
        'Parâmetros da consulta não definidos!')));
      Res.Send<TJSonArray>(JsonArrayErro)
        .Status(THttpStatus.InternalServerError);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/transferencia', Trim(Req.Params.Content.Text), Req.Body,
        '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]), 403,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
      FreeAndNil(LService);
      Exit;
    End;
    Try
      vDataInicial := 0;
      vDataFinal := 0;
      if AQueryParam.ContainsKey('datainicial') then
      Begin
        Try
          vDataInicial := StrToDate(AQueryParam.Items['datainicial']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/transferencia', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafinal') then
      Begin
        Try
          vDataFinal := StrToDate(AQueryParam.Items['datafinal']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Final inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/transferencia', Trim(Req.Params.Content.Text),
            Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
            [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
            Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if vDataInicial > vDataFinal then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período das reposições inválido!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/transferencia', Trim(Req.Params.Content.Text),
          Req.Body, '', StringReplace(JsonArrayErro.ToString, #39, '',
          [rfReplaceAll]), 403, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.RelReposicaoTransfPicking(AQueryParam);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/transferencia', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/transferencia', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure GetReposicaoHistorico(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  LService: TServicePedidoSaida;
  JsonArrayRetorno: TJSonArray;
  JsonArrayErro: TJSonArray;
  AQueryParam: TDictionary<String, String>;
  vDtReposicaoInicial, vDtReposicaoFinal: TDateTime;
  HrInicioLog: TTime;
begin
  Try
    HrInicioLog := Time;
    AQueryParam := Req.Query.Dictionary;
    LService := TServicePedidoSaida.Create;
    Try
      If AQueryParam.Count <= 0 then
      Begin
        JsonArrayErro := TJSonArray.Create();
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta não definidos!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/historico', Trim(Req.Params.Content.Text), Req.Body,
          '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      if AQueryParam.ContainsKey('dtreposicaoinicial') then
      Begin
        Try
          vDtReposicaoInicial :=
            StrToDate(AQueryParam.Items['dtreposicaoinicial']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Inicial inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/historico', Trim(Req.Params.Content.Text), Req.Body,
            '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
            403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '
            + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('dtreposicaofinal') then
      Begin
        Try
          vDtReposicaoFinal := StrToDate(AQueryParam.Items['dtreposicaofinal']);
        Except
          JsonArrayErro := TJSonArray.Create;
          JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
            'Data Final inválida!')));
          Res.Send<TJSonArray>(JsonArrayErro)
            .Status(THttpStatus.InternalServerError);
          Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
            0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
            '/v1/reposicao/historico', Trim(Req.Params.Content.Text), Req.Body,
            '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
            403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: '
            + Req.Headers['versao']);
          FreeAndNil(LService);
          Exit;
        End;
      End;
      if vDtReposicaoInicial > vDtReposicaoFinal then
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Período das reposições inválido!')));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/historico', Trim(Req.Params.Content.Text), Req.Body,
          '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
          403, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
        FreeAndNil(LService);
        Exit;
      End;
      JsonArrayRetorno := LService.GetReposicaoHistorico(AQueryParam);
      Res.Send<TJSonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/reposicao/historico', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
        Req.Headers['versao']);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/reposicao/historico', Trim(Req.Params.Content.Text), Req.Body,
          '', StringReplace(JsonArrayErro.ToString, #39, '', [rfReplaceAll]),
          500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' +
          Req.Headers['versao']);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

End.
