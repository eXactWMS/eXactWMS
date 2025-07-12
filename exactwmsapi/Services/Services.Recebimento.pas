unit Services.Recebimento;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS, exactwmsservice.lib.utils,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  Services.Produto, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI,
  exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

Const SqlEntrada = 'Declare @PedidoId Integer        = :pPedidoId' + sLineBreak +
      'Declare @CodPessoaERP Integer      = :pCodPessoaERP' + sLineBreak +
      'Declare @DocumentoNr VarChar(20)   = :pDocumentoNr' + sLineBreak +
      'Declare @Razao VarChar(100)        = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36)   = :pRegistroERP' + sLineBreak +
      'Declare @Pendente Integer          = :pPendente' + sLineBreak +
      'Declare @AgrupamentoId Integer     = :pAgrupamentoId' + sLineBreak +
      'Declare @CodBarra Varchar(25)      = :pCodProduto'+sLineBreak+
      'Declare @DescrProduto Varchar(100) = :pDescrProduto'+sLineBreak+
      'Declare @CodProduto Integer        = Coalesce((Select Top 1 CodProduto From PRoduto Prd '+sLineBreak+
      '                                               Inner join ProdutoCodBarras Pc On Pc.ProdutoId = Prd.IdProduto'+sLineBreak+
		  '					                                      Where TRY_CAST(Pc.CodBarras AS BIGINT) IS NOt NULL and (Cast(CodProduto as varchar(25)) = @CodBarra or Pc.CodBarras = @CodBarra) and cast(Pc.CodBarras as Bigint)>0), 0)'+sLineBreak+
      'Declare @DtNotaFiscal DateTime   = :pDtNotaFiscal'+sLineBreak+
      ''+sLineBreak+
      'if object_id ('+#39+'tempdb..#Entrada'+#39+') is not null drop table #Entrada'+sLineBreak+
      'if object_id ('+#39+'tempdb..#Agrupamento'+#39+') is not null drop table #Agrupamento'+sLineBreak+
      'if object_id ('+#39+'tempdb..#CheckIn'+#39+') is not null drop table #CheckIn'+sLineBreak+
      'if object_id ('+#39+'tempdb..#ProdutoDescricao'+#39+') is not null drop table #ProdutoDescricao'+sLineBreak+
      'if object_id ('+#39+'tempdb..#PedidoProduto'+#39+') is not null drop table #PedidoProduto'+sLineBreak+
      'if object_id ('+#39+'tempdb..#EntradaProcesso'+#39+') is not null drop table #EntradaProcesso'+sLineBreak+
     // 'if object_id ('+#39+'tempdb..#MaxProcesso'+#39+') is not null drop table #MaxProcesso'+sLineBreak+
      ''+sLineBreak+
     // 'SELECT Ped.PedidoId, MAX(De.ProcessoId) AS MaxProcessoId Into #MaxProcesso'+sLineBreak+
     // 'FROM DocumentoEtapas De'+sLineBreak+
     // 'INNER JOIN Pedido Ped ON De.Documento = Ped.uuid'+sLineBreak+
     // 'WHERE De.Status = 1 and OperacaoTipoId = 3'+sLineBreak+
     // 'GROUP BY  Ped.PedidoId'+sLineBreak+
      ''+sLineBreak+
      'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid,'+sLineBreak+
      '       P.CodPessoaERP, P.Razao, Ped.DocumentoNr, Rd.Data as DocumentoData, Ped.RegistroERP,'+sLineBreak+
      '	   Ped.DtInclusao, Ped.HrInclusao, ArmazemId, Ped.Status, PN.agrupamentoid, Ped.Uuid, MP.MaxProcessoId Into #Entrada'+sLineBreak+
      'From pedido Ped'+sLineBreak+
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId'+sLineBreak+
      'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId'+sLineBreak+
      'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData'+sLineBreak+
      'Left Join PedidoAgrupamentoNotas PN On PN.PedidoId = Ped.PedidoId'+sLineBreak+
      'Cross Apply (Select Top 1 ProcessoId MaxProcessoId'+sLineBreak+
      '             From DocumentoEtapas'+sLineBreak+
      '			        where Documento = Ped.UUid and Status = 1'+sLineBreak+
      '			        Order by ProcessoId Desc) MP '+sLineBreak+
     // 'inner join #MaxProcesso MP ON MP.PedidoId = Ped.PedidoId'+sLineBreak+
      'Where (@PedidoId = 0 or Ped.PedidoId = @PedidoId) and Ped.OperacaoTipoId = 3 and'+sLineBreak+
      '      (@CodPessoaERP = 0 or P.CodPessoaERP = @CodPessoaERP) and'+sLineBreak+
      '      (@DocumentoNr = '+#39+#39+' or Ped.DocumentoNr = @DocumentoNr) and'+sLineBreak+
      '      (@Razao = '+#39+#39+' or P.Razao Like @Razao) and'+sLineBreak+
      '      (@RegistroERP = '+#39+#39+' or Ped.RegistroERP = @RegistroERP)'+sLineBreak+
      '      And (@DtNotaFiscal = 0 or Rd.Data = @DtNotaFiscal)'+sLineBreak+
      '      And (@AgrupamentoId=0 or @AgrupamentoId=PN.agrupamentoid)'+sLineBreak+
      '      and (@Pendente <> 1 or (@Pendente = 1 and MP.MaxProcessoId < 5))'+sLineBreak+
      '	     And Mp.MaxProcessoId <> 31'+sLineBreak+
      ''+sLineBreak+
//      'Select Ent.*, De.ProcessoId, De.Descricao as Processo Into #EntradaProcesso'+sLineBreak+
//      'From #Entrada Ent'+sLineBreak+
//      'join vDocumentoEtapas DE On De.Documento = Ent.Uuid'+sLineBreak+
//      '     and De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento )'+sLineBreak+
//      'Where (@Pendente = 0 or (De.ProcessoId in (1,4)))'+sLineBreak+
//      '  And De.ProcessoId <> 31'+sLineBreak+
//      ''+sLineBreak+
      'Select Pi.PedidoId, COUNT(*) TotalProduto Into #PedidoProduto'+sLineBreak+
      'from #Entrada Ent'+sLineBreak+
      'Inner Join PedidoItens Pi On Pi.PedidoId = Ent.PedidoId'+sLineBreak+
      'Inner join vProdutoLotes Pl On Pl.LoteId = Pi.LoteId'+sLineBreak+
      'Where (@CodProduto=0 or @CodProduto = Pl.CodProduto)'+sLineBreak+
      '  And (@DescrProduto = '#39+'%%'+#39+' or Pl.Descricao like @DescrProduto)'+sLineBreak+
      ''+sLineBreak+
      'Group by Pi.PedidoId'+sLineBreak+
      ''+sLineBreak+
      '--Select Ent.PedidoId, Pa.AgrupamentoId Into #Agrupamento'+sLineBreak+
      '--from  #Entrada Ent'+sLineBreak+
      '--Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = Ent.PedidoId'+sLineBreak+
      ''+sLineBreak+
//      'Select PI.PedidoId, IsNull(COUNT(*), 0) TItens Into #ProdutoDescricao'+sLineBreak+
//      'From PedidoItens Pi'+sLineBreak+
//      'inner Join #Entrada Ent On Ent.PedidoId = Pi.PedidoId'+sLineBreak+
//      'inner Join vProdutoLotes Prd ON Prd.LoteId = Pi.LoteId'+sLineBreak+
//      'where (@DescrProduto = '+#39+'%%'+#39+' or Prd.Descricao like @DescrProduto)'+sLineBreak+
//      'Group by Pi.PedidoId'+sLineBreak+
      //Pegar CheckIn
      ''+sLineBreak+
      'Select Ent.PedidoId, Sum(Pi.QtdXml) QtdXml, sum(IsNull(Pi.QtdCheckin, 0)+'+sLineBreak+
      '                         IsNull(Pi.QtdDevolvida, 0)+IsNull(Pi.QtdSegregada, 0)) QtdCheckIn Into #CheckIn'+sLineBreak+
      'from  #Entrada Ent'+sLineBreak+
      'Left Join PedidoItens Pi on Pi.PedidoId = Ent.PedidoId'+sLineBreak+
      'Group By Ent.PedidoId'+sLineBreak+
      ''+sLineBreak+
      'Select Ent.PedidoId, Ent.OperacaoTipoId, Ent.OperacaoTipo, Ent.Pessoaid, Ent.CodPessoaERP, Ent.Razao, Ent.DocumentoNr,'+sLineBreaK+
      '       Format(Ent.DocumentoData, '+#39+'dd/MM/yyyy'+#39+') DocumentoData, Ent.RegistroERP, Format(RE.Data, '+#39+'dd/MM/yyyy'+#39+') DtInclusao,'+sLineBreaK+
      '	      CONVERT(VARCHAR, RH.Hora ,8) as HrInclusao, Ent.ArmazemId, Ent.Status, Ent.MaxProcessoId ProcessoId, Pe.Descricao Processo,'+sLineBreaK+
      '	      IsNull(Ent.AgrupamentoId, 0) AgrupamentoId, Chk.QtdXml , Chk.QtdCheckIn'+sLineBreak+
      'From #Entrada Ent'+sLineBreak+
      '--Inner Join #MaxProcesso Mp On Mp.PedidoId = Ent.PedidoId'+sLineBreak+
      '--Left join #Agrupamento PA On Pa.PedidoId = Ent.PedidoId'+sLinebreak+
      'Left Join #CheckIn Chk On Chk.PedidoId = Ent.Pedidoid'+slineBreak+
      'Left Join #PedidoProduto Prd On Prd.PedidoId = Ent.PedidoId'+sLineBreak+
      'Inner Join Rhema_Data RE On Re.IdData = Ent.DtInclusao'+sLineBreak+
      'Inner Join Rhema_Hora RH On Rh.IdHora = Ent.Hrinclusao'+sLineBreak+
      'Inner Join ProcessoEtapas PE On Pe.ProcessoId = Ent.MaxProcessoId'+sLineBreak+
      'Where (@AgrupamentoId = 0 or Ent.AgrupamentoId = @AgrupamentoId or '+sLineBreak+
      '      (@AgrupamentoId=-1 and Ent.agrupamentoid Is Null))'+sLineBreak+
      '  And ((@DescrProduto = '+#39+'%%'+#39+' and @CodProduto=0) or Prd.TotalProduto > 0)'+sLineBreak+
      'Order by Ent.PedidoId';

Const
  SqlEntradaItens =
    'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.ProdutoId, Prd.CodProduto CodigoERP, Pl.DescrLote'
    + #13 + #10 + ', FORMAT(DF.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as Fabricacao' + #13 + #10 + ', FORMAT(DV.Data, ' + #39 + 'dd/MM/yyyy' +
    #39 + ') as Vencimento  ' + #13 + #10 + ', FORMAT(RD.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtEntrada  ' + #13 + #10 +
    ', Rh.Hora HrEntrada, ' + #13 + #10 +
    'PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, PIt.QtdSegregada, ' + #13 +
    #10 + 'Prd.Descricao DescrProduto, PIt.PrintEtqControlado' + #13 + #10 +
    'From PedidoItens PIt' + #13 + #10 +
    'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + #13 + #10 +
    'Left Join Rhema_Data DF On DF.IdData = Pl.Fabricacao ' + #13 + #10 +
    'Left Join Rhema_Data DV On DV.IdData = Pl.Vencimento ' + #13 + #10 +
    'Inner join Rhema_Data RD on Rd.IdData = Pl.DtEntrada' + #13 + #10 +
    'Left Join Rhema_Hora RH on Rh.IdHora = Pl.HrEntrada' + #13 + #10 +
    'Inner join Produto Prd On Prd.IdProduto = Pl.ProdutoId' + #13 + #10 +
    'Where PedidoId = @pPedido';

type
  TServiceRecebimento = class(TBasicDao)
  private
    { Private declarations }
    function AtualizarKardex(pQryKardex: TFdQuery;
      pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pEstoqueTipoIdDestino, pQuantidade, pEnderecoIdDestino,
      pUsuarioId: Integer; pObservacaoOrigem, pObservacaoDestino,
      pNomeEstacao: String): Boolean;
  public
    { Public declarations }
    function Pesquisar(pPedidoId, pCodPessoaERP: Integer;
      pDocumento, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
      pPendente: Integer; pAgrupamentoId: Integer; pCodProduto, pDescrProduto : String; pBasico: Boolean;
      pShowErro: Integer = 1): tJsonArray;
    Function GetEtiquetaArmazenagem(pPedidoId: Integer = 0;
      pDocumentoNr: String = ''; pZonaId: Integer = 0; pCodProduto: Integer = 0;
      pSintetico: Integer = 0; pDtInicio: TDateTime = 0;
      pDtTermino: TDateTime = 0): tJsonArray;
    Function DshRecebimentos(pRecebimentoInicial, pRecebimentoFinal,
                             pProducaoInicial, pProducaoFinal : TDateTime): tJsonArray;
    Function ExcluirPreEntrada(pJsonArray: tJsonArray): tJsonArray;
    Function CancelarNFeERP(pJsonArray: tJsonArray): tJsonArray;
    Function FinalizarCheckIn(pjsonEntrada: TJsonObject): Boolean;
    Function FinalizarAgrupamentoNotas(pjsonEntrada: TJsonObject): TJsonArray;
    Function GetEntradaProduto(pPedidoId, pAgrupamentoId: Integer): tJsonArray;
    Function GetEntradaLotes(pPedidoId, pAgrupamentoId, pCodProduto, pLoteId: Integer): tJsonArray;
    Function GetEntradaItens(pPedidoId, pAgrupamentoId: Integer): tJsonArray;
    function GetEntradaProdutoSemPicking(pDataInicial, pDataFinal: TDateTime; pPedidoId: Integer; pCodPessoaERP: Integer; pDocumentoNr: String) : tJsonArray;
    Function SalvarCheckInItem(pjsonEntrada: TJsonObject): TJsonObject;
    Function ValidarQtdCheckIn(pPedidoId, pCodProduto: Int64): tJsonArray;
    Function SalvarAgrupamento(pNotaAgrupamentoJsonArray: tJsonArray) : tJsonArray;
    Function GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP: Integer) : tJsonArray;
    Function GetAgrupamentoPedido(pAgrupamentoId, pPedidoId: Integer) : tJsonArray;
    Function SalvarCheckInItemAgrupamento(pJsonItemCheckIn: TJsonObject) : TJsonObject;
    Function GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer): tJsonArray;
    Function GetAgrupamentoFatorarProduto(pAgrupamentoId: Integer): tJsonArray;
    Function GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer) : tJsonArray;
    Function GetAgrupamentoCheckIn(pAgrupamentoId : Integer) : TJsonArray;
    Function DelCancelarCheckInAgrupamento(pAgrupamentoId: Integer) : TJsonArray;
    Function CancelarCheckInProduto(pAgrupamentoId, pPedidoId, pCodProduto: Integer): tJsonArray;
    Function DeleteAgrupamento(pAgrupamentoId, pPedidoId: Integer): tJsonArray;
    Function DelAgrupamentocheckinreiniciar(pAgrupamentoId : Integer) : tJsonArray;
    Function GetProdutoTagByProduto(aQuery: TDictionary<String, String>) : tJsonArray;
    Function RegPrintEtqProduto(pPedidoId, pLoteId: Integer): tJsonArray;
    Function GetResumoCheckIn(pEntradaId: Integer): tJsonArray;
    Function Header(pEntradaId, pAgrupamentoId: Integer): tJsonArray;
    Function GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId, pCodProduto: Integer): tJsonArray;
    Function GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId, pCodProduto: Integer): tJsonArray;
    Function GetOcorrencias(pPedidoId: Integer;
      pDocumentoNr, pRegistroERP: String; pCodProduto: Integer;
      pDataInicial, pDataFinal, pDataCheckInInicial, pDataCheckInFinal
      : TDateTime): tJsonArray;
    Function GetAcompanhamentoCheckIn(pPedidoId, pCodPessoaERP: Integer; pDataInicial, pDataFinal: TDateTime; pUsuarioId : Integer): tJsonArray;
    Function GetDshUserCheckIn(aQuery: TDictionary<String, String>): TJsonArray;
    Function ValidarCheckInAgrupamentoFinalizar(pAgrupamentoId : integer) : TJsonArray;
    Procedure CorrigirErroProdutoReEnvio(pAgrupamentoId : Integer);
    constructor Create;  overload;
    destructor Destroy; override;
  end;

var
  ServiceRecebimento: TServiceRecebimento;

implementation

uses Constants, EntradaItensClass, EntradaClass, ProdutoClass;

{ TProvidersBase1 }

function TServiceRecebimento.DelAgrupamentocheckinreiniciar(pAgrupamentoId: Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Result := tJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
      Query.Sql.Add('Delete Pi');
      Query.Sql.Add('from Pedidoitens Pi');
      Query.Sql.Add('Inner join PedidoAgrupamentoNotas Pn On Pn.Pedidoid = Pi.Pedidoid');
      Query.Sql.Add('where Pn.AgrupamentoId = @AgrupamentoId and Pi.QtdXml = 0');
      Query.Sql.Add('');
      Query.Sql.Add('Update Pi');
      Query.Sql.Add('   Set QtdCheckIn = 0, QtdDevolvida = 0, QtdSegregada = 0');
      Query.Sql.Add('from Pedidoitens Pi');
      Query.Sql.Add('Inner join PedidoAgrupamentoNotas Pn On Pn.Pedidoid = Pi.Pedidoid');
      Query.Sql.Add('where Pn.AgrupamentoId = @AgrupamentoId');
      Query.SQL.Add('Delete PC');
      Query.SQL.Add('from PedidoItensCheckIn PC');
      Query.SQL.Add('Inner join PedidoAgrupamentoNotas PN On PN.pedidoid = PC.PedidoId');
      Query.SQL.Add('Inner Join ProdutoLotes Pl On Pl.LoteId = PC.LoteId');
      Query.SQL.Add('where PN.agrupamentoid = @AgrupamentoId');
      Query.SQL.Add('');
      Query.Sql.Add('Update Ped Set Status = 1');
      Query.SQL.Add('From Pedido Ped');
      Query.SQL.Add('Inner Join PedidoAgrupamentonotas PAN On PAN.PedidoId = Ped.PedidoId');
      Query.SQL.Add('where PAN.agrupamentoid = @AgrupamentoId');
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create.AddPair('Status', TJsonNumber.Create(200)));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimmento/delagrupamentocheckinreiniciar - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.DelCancelarCheckInAgrupamento(
  pAgrupamentoId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
      Query.SQL.Add('Update Pi Set QtdCheckIn = 0, QtdDevolvida = 0, QtdSegregada = 0');
      Query.SQL.Add('from PedidoItens PI');
      Query.SQL.Add('Inner join PedidoAgrupamentoNotas PN On PN.pedidoid = PI.PedidoId');
      Query.SQL.Add('Inner Join ProdutoLotes Pl On Pl.LoteId = PI.LoteId');
      Query.SQL.Add('where PN.agrupamentoid = @AgrupamentoId');
      Query.SQL.Add('Delete Pi');
      Query.SQL.Add('from PedidoItensCheckIn PI');
      Query.SQL.Add('Inner join PedidoAgrupamentoNotas PN On PN.pedidoid = PI.PedidoId');
      Query.SQL.Add('Inner Join ProdutoLotes Pl On Pl.LoteId = PI.LoteId');
      Query.SQL.Add('where PN.agrupamentoid = @AgrupamentoId');
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('DelCancelarCheckInAgrupamento.Sql');
      Query.Delete;
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Checkin Agrupamento cancelado!'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getagrupamentocheckin - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.DeleteAgrupamento(pAgrupamentoId,
  pPedidoId: Integer): tJsonArray;
Var JsonArrayErro: tJsonArray;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := tJsonArray.Create;
      Query.Close;
      Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
      Query.Sql.Add('Declare @PedidoId      Integer = :pPedidoid');
      Query.Sql.Add('Delete PedidoAgrupamento where (AgrupamentoId=@AgrupamentoId and @PedidoId=0)');
      Query.Sql.Add('Delete PedidoAgrupamentoNotas Where (@AgrupamentoId=0 or @AgrupamentoId = AgrupamentoId) And PedidoId = @PedidoId ');
      Query.Sql.Add('Delete Pa');
      Query.Sql.Add('From PedidoAgrupamento Pa');
      Query.Sql.Add('Left Join PedidoAgrupamentoNotas PN ON PN.agrupamentoid = Pa.agrupamentoid');
      Query.Sql.Add('where Pa.agrupamentoid = @AgrupamentoId and Pn.AgrupamentoId Is Null');
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create.AddPair('Status', TJsonNumber.Create(200)));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/deleteagrupamento - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TServiceRecebimento.Destroy;
begin

  inherited;
end;

function TServiceRecebimento.DshRecebimentos(pRecebimentoInicial,
  pRecebimentoFinal, pProducaoInicial, pProducaoFinal : TDateTime): tJsonArray;
var vSql: String;
    JsonArrayResumo: tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlDshRecebimentos);
      if pRecebimentoInicial = 0 then
         Query.ParamByName('pRecebimentoInicial').Value := 0
      Else
         Query.ParamByName('pRecebimentoInicial').Value := pRecebimentoInicial;
      if pRecebimentoFinal = 0 then
         Query.ParamByName('pRecebimentoFinal').Value   := 0
      Else
         Query.ParamByName('pRecebimentoFinal').Value   := pRecebimentoFinal;
      if pProducaoInicial = 0 then
         Query.ParamByName('pProducaoInicial').Value    := 0
      Else
      Query.ParamByName('pProducaoInicial').Value    := pProducaoInicial;
      if pProducaoFinal = 0 then
         Query.ParamByName('pProducaoFinal').Value      := 0
      Else
         Query.ParamByName('pProducaoFinal').Value      := pProducaoFinal;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelDshRecebimento.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/dshrecebimento - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.AtualizarKardex(pQryKardex: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String): Boolean;
begin

end;

function TServiceRecebimento.CancelarCheckInProduto(pAgrupamentoId, pPedidoId,
  pCodProduto: Integer): tJsonArray;
Var JsonArrayErro: tJsonArray;
    Query : TFdQuery;
begin
  Result := tJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
      Query.Sql.Add('Declare @PedidoId      Integer = :pPedidoId');
      Query.Sql.Add('Declare @ProdutoId     Integer = Coalesce((Select IdProduto From Produto where CodProduto = :pCodProduto), 0)');
      Query.SQL.Add('if @AgrupamentoId = 0 Begin');
      Query.Sql.Add('   Delete Pc');
      Query.Sql.Add('   from PedidoItensCheckIn Pc');
      Query.Sql.Add('   Inner Join ProdutoLotes Pl on Pl.LoteId = Pc.LoteId');
      Query.Sql.Add('   Left Join PedidoAgrupamentoNotas Pn on Pn.pedidoid = Pc.PedidoId');
      Query.Sql.Add('   where (@AgrupamentoId=0 or Pn.agrupamentoid=@AgrupamentoId) and');
      Query.Sql.Add('         (@PedidoId=0 or Pc.PedidoId = @PedidoId) and');
      Query.Sql.Add('	        (@ProdutoId = 0 or Pl.ProdutoId = @ProdutoId)');
      Query.Sql.Add('');
      Query.Sql.Add('   Delete Pi');
      Query.Sql.Add('   from PedidoItens Pi');
      Query.Sql.Add('   Inner Join ProdutoLotes Pl on Pl.LoteId = Pi.LoteId');
      Query.Sql.Add('   Left Join PedidoAgrupamentoNotas Pn on Pn.pedidoid = Pi.PedidoId');
      Query.Sql.Add('   where (@AgrupamentoId=0 or Pn.agrupamentoid=@AgrupamentoId) and');
      Query.Sql.Add('         (@PedidoId=0 or Pi.PedidoId = @PedidoId) and');
      Query.Sql.Add('	        (@ProdutoId = 0 or Pl.ProdutoId = @ProdutoId) and QtdXml = 0');
      Query.Sql.Add('   Update Pi');
      Query.Sql.Add('      set QtdCheckIn = 0, QtdDevolvida = 0, QtdSegregada = 0');
      Query.Sql.Add('   from PedidoItens Pi');
      Query.Sql.Add('   Inner Join ProdutoLotes Pl on Pl.LoteId = Pi.LoteId');
      Query.Sql.Add('   Left Join PedidoAgrupamentoNotas Pn on Pn.pedidoid = Pi.PedidoId');
      Query.Sql.Add('   where (@AgrupamentoId=0 or Pn.agrupamentoid=@AgrupamentoId) and');
      Query.Sql.Add('         (@PedidoId=0 or Pi.PedidoId = @PedidoId) And');
      Query.Sql.Add('	       (@ProdutoId = 0 or Pl.ProdutoId = @ProdutoId)');
      Query.SQL.Add('End');
      Query.SQL.Add('Else Begin');
      Query.SQL.Add('  Delete PAC');
      Query.SQL.Add('  From PedidoItensCheckInAgrupamento PAC');
      Query.SQL.Add('  Inner join vProdutolotes Pl On Pl.LoteId = PAC.Loteid');
      Query.SQL.Add('  Where @Agrupamentoid = PAC.AgrupamentoId');
      Query.SQL.Add('    and (@ProdutoId = 0 or Pl.IdProduto = @ProdutoId)');
      Query.SQL.Add('End;');
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ParamByName('pPedidoId').Value      := pPedidoId;
      Query.ParamByName('pCodProduto').Value    := pCodProduto;
      If DebugHook<>0 then
         Query.SQL.SaveToFile('CancelarCheckInProduto.Sql');
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create.AddPair('Status', TJsonNumber.Create(200)));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/cancelarcheckinproduto - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.CancelarNFeERP(pJsonArray: tJsonArray): tJsonArray;
Var vQryDelete: TFdQuery;
    vQryValida: TFdQuery;
    xPedido: Integer;
    JsonArrayErro: tJsonArray;
begin
  Result := tJsonArray.Create;
  vQryDelete := TFdQuery.Create(Nil);
  vQryValida := TFdQuery.Create(Nil);
  Try
    vQryDelete.Connection := COnnection;
    vQryValida.Connection := COnnection;
    Try
      vQryDelete.connection.StartTransaction;
      vQryDelete.Close;
      vQryDelete.Sql.Add('Declare @PedidoId VarChar(50) = :pPedidoId');
      vQryDelete.Sql.Add('Declare @UsuarioId Integer = Null'); // :pUsuarioId');
      vQryDelete.Sql.Add('Declare @Terminal Varchar(50) = :pTerminal');
      vQryDelete.Sql.Add('Update Pedido Set Status = 3 ');
      vQryDelete.Sql.Add('where ((Cast(PedidoId as VarChar(36)) = @PedidoId)');
      vQryDelete.Sql.Add('   or  (Cast(RegistroERP as VarChar(36)) = @PedidoId)) and OperacaoTipoId = 2');
      vQryDelete.Sql.Add('Update DocumentoEtapas Set Status = 0');
      vQryDelete.Sql.Add('Where (Documento = Cast((Select Uuid from Pedido Where ((Cast(PedidoId as VarChar(36)) = @PedidoId)');
      vQryDelete.Sql.Add('   or (RegistroERP = @PedidoId))) as UNIQUEIDENTIFIER)) and ProcessoId = 31');
      vQryDelete.Sql.Add('Insert Into DocumentoEtapas Values (');
      vQryDelete.Sql.Add('       Cast((Select Uuid from Pedido Where ((Cast(PedidoId as VarChar(36)) = @PedidoId) or (RegistroERP = @PedidoId))) as UNIQUEIDENTIFIER), ');
      vQryDelete.Sql.Add('       (Select ProcessoId From ProcessoEtapas ');
      vQryDelete.Sql.Add('        Where Descricao = ' + #39+'Documento Excluido'+#39+'), ');
      vQryDelete.Sql.Add('@UsuarioId, ' + TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', GetDate(), @Terminal, 1)');
      for xPedido := 0 to Pred(pJsonArray.Count) do Begin
        Try
          vQryValida.Close;
          vQryValida.Sql.Clear;
          vQryValida.Sql.Add('Declare @RegistroERP VarChar(36) = :pRegistroERP');
          vQryValida.Sql.Add('Declare @PedidoId VarChar(36)    = :pPedidoId');
          vQryValida.Sql.Add('select Ped.DocumentoNr, Ped.RegistroERP, De.ProcessoId, De.Descricao Processo, De.Horario, Ped.Status');
          vQryValida.Sql.Add('From pedido Ped');
          vQryValida.Sql.Add('Left join vDocumentoEtapas De On De.Documento = Ped.uuid');
          vQryValida.Sql.Add('where Ped.OperacaoTipoId = 3 And De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) and ');
          vQryValida.Sql.Add('      ((Cast(Ped.RegistroERP as VarChar(36)) = @RegistroERP) ');
          vQryValida.Sql.Add('       Or (Cast(PedidoId as VarChar(36))        = @PedidoId))');
          vQryValida.ParamByName('pRegistroERP').Value := pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
          vQryValida.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
          If DebugHook <> 0 Then
             vQryValida.Sql.SaveToFile('ValidaEntrada.Sql');
          vQryValida.Open;
          if (vQryValida.IsEmpty) then Begin
             Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                   .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                   .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                   .AddPair('mensagem', 'Documento não localizacado.'));
          End
          Else If ((vQryValida.FieldByName('ProcessoId').AsInteger > 4) or
            (vQryValida.FieldByName('Status').AsInteger = 2)) then Begin
            Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                  .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                  .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                  .AddPair('mensagem', 'Entrada não pode ser excluída. Processo: ' +vQryValida.FieldByName('Processo').AsString));
          End
          Else
          begin
            vQryDelete.Close;
            vQryDelete.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
            vQryDelete.ParamByName('pTerminal').Value := 'IntegracaoERP';
            If DebugHook <> 0 Then
               vQryDelete.Sql.SaveToFile('PedidoExcluir.Sql');
            vQryDelete.ExecSql;
            Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                  .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                  .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                  .AddPair('mensagem', 'Entrada excluída com sucesso'));
          end;
        Except On E: Exception do
          Begin
            Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                  .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                  .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                  .AddPair('mensagem', E.Message));
          End;
        End;
      End;
      vQryDelete.connection.Commit;
    Except On E: Exception do
      Begin
        vQryDelete.connection.Rollback;
        Result.AddElement(TJsonObject.Create.AddPair('status', '500')
              .AddPair('entradaid', TJsonNumber.Create(0))
              .AddPair('documentoerp', '')
              .AddPair('mensagem', TUtil.TratarExcessao(E.Message)) );
      End;
    End;
  Finally
    FreeAndNil(vQryDelete);
    FreeAndNil(vQryValida);
  End;
End;

procedure TServiceRecebimento.CorrigirErroProdutoReEnvio(
  pAgrupamentoId: Integer);
Var vQryReEnvioAgrupamento : TFdQuery;
begin
  vQryReEnvioAgrupamento := TFdQuery.Create(Nil);
  Try
    vQryReEnvioAgrupamento.Connection := Connection;
    Try
      vQryReEnvioAgrupamento.SQL.Add('Declare @AgrupamentoId Int = '+pAgrupamentoId.ToString());
      vQryReEnvioAgrupamento.SQL.Add(';With');
      vQryReEnvioAgrupamento.SQL.Add('Pc As (select Pl.CodProduto, Sum(QtdCheckIn) CheckIn, Sum(QtdDevolvida) Devol, Sum(QtdSegregada) Segr');
      vQryReEnvioAgrupamento.SQL.Add('from PedidoItensCheckInAgrupamento Pc');
      vQryReEnvioAgrupamento.SQL.Add('Inner join vProdutoLotes Pl on Pl.Loteid = Pc.Loteid');
      vQryReEnvioAgrupamento.SQL.Add('where Agrupamentoid = @AgrupamentoId');
      vQryReEnvioAgrupamento.SQL.Add('Group by Pl.CodProduto),');
      vQryReEnvioAgrupamento.SQL.Add('');
      vQryReEnvioAgrupamento.SQL.Add('Pi As (select Pl.CodProduto, Sum(QtdXml) QtdXml');
      vQryReEnvioAgrupamento.SQL.Add('from pedidoItens pi');
      vQryReEnvioAgrupamento.SQL.Add('Inner join Pedido Ped On Ped.Pedidoid = Pi.PedidoId');
      vQryReEnvioAgrupamento.SQL.Add('Inner join PedidoAgrupamentoNotas Pn On Pn.PedidoId = Pi.PedidoId');
      vQryReEnvioAgrupamento.SQL.Add('Inner join vProdutoLotes Pl on Pl.Loteid = Pi.Loteid');
      vQryReEnvioAgrupamento.SQL.Add('where Pn.Agrupamentoid = @AgrupamentoId');
      vQryReEnvioAgrupamento.SQL.Add('Group by Pl.CodProduto)');
      vQryReEnvioAgrupamento.SQL.Add('');
      vQryReEnvioAgrupamento.SQL.Add(', Pic as (Select Pc.CodProduto');
      vQryReEnvioAgrupamento.SQL.Add('          From Pc');
      vQryReEnvioAgrupamento.SQL.Add('		      Left Join Pi On Pi.CodProduto = Pc.Codproduto');
      vQryReEnvioAgrupamento.SQL.Add('		      where (Pi.CodProduto Is Null) )');
      vQryReEnvioAgrupamento.SQL.Add('');
      vQryReEnvioAgrupamento.SQL.Add('Delete Pca');
      vQryReEnvioAgrupamento.SQL.Add('From PedidoitensCheckInAgrupamento Pca');
      vQryReEnvioAgrupamento.SQL.Add('Inner join vProdutoLotes Pl On Pl.LoteId = Pca.LoteId');
      vQryReEnvioAgrupamento.SQL.Add('Inner join Pic On Pic.CodProduto = Pl.Codproduto');
      vQryReEnvioAgrupamento.SQL.Add('where Pca.agrupamentoid = @AgrupamentoId');
      If DebugHook <> 0 then
         vQryReEnvioAgrupamento.SQL.SaveToFile('CorrigirErroProdutoReEnvio.Sql');
      vQryReEnvioAgrupamento.ExecSQL;
    Except On E: Exception do
      Raise Exception.Create('Processo: CorrigirErroProdutoReEnvio - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(vQryReEnvioAgrupamento);
  End;
end;

constructor TServiceRecebimento.Create;
begin
  inherited;
end;

function TServiceRecebimento.ExcluirPreEntrada(pJsonArray: tJsonArray) : tJsonArray;
Var vQryDelete: TFdQuery;
    vQryValida: TFdQuery;
    xPedido: Integer;
    JsonArrayErro: tJsonArray;
begin
  Result := tJsonArray.Create;
  vQryDelete := TFdQuery.Create(Nil);
  vQryValida := TFdQuery.Create(Nil);
  Try
    vQryDelete.Connection := Connection;
    vQryValida.Connection := Connection;
    Try
      vQryDelete.connection.StartTransaction;
      vQryDelete.Close;
      vQryDelete.Sql.Add('Declare @PedidoId VarChar(50) = :pPedidoId');
      vQryDelete.Sql.Add('Declare @UsuarioId Integer = '+pJsonArray.Items[0].GetValue<Integer>('usuarioid').ToString());
      vQryDelete.Sql.Add('Declare @Terminal Varchar(50) = :pTerminal');
      vQryDelete.Sql.Add('Update Pedido Set Status = 3');
      vQryDelete.Sql.Add('where ((Cast(PedidoId as VarChar(36)) = @PedidoId)');
      vQryDelete.Sql.Add('   or  (Cast(RegistroERP as VarChar(36)) = @PedidoId))');
      vQryDelete.Sql.Add('      and OperacaoTipoId = 2');
      vQryDelete.SQL.Add('Update DocumentoEtapas Set Status = 0');
      vQryDelete.SQL.Add('Where (Documento = Cast((Select Uuid from Pedido');
      vQryDelete.Sql.Add('                        Where ((Cast(PedidoId as VarChar(36)) = @PedidoId)');
      vQryDelete.Sql.Add('   or (RegistroERP = @PedidoId))) as UNIQUEIDENTIFIER)) and ProcessoId = 31');
      vQryDelete.Sql.Add('Insert Into DocumentoEtapas Values (');
      vQryDelete.Sql.Add('       Cast((Select Uuid from Pedido Where ((Cast(PedidoId as VarChar(36)) = @PedidoId) or (RegistroERP = @PedidoId))) as UNIQUEIDENTIFIER), ');
      vQryDelete.Sql.Add('       (Select ProcessoId From ProcessoEtapas Where Descricao = '+#39+'Documento Excluido'+#39+'), ');
      vQryDelete.Sql.Add('@UsuarioId, ' + TuEvolutConst.SqlDataAtual + ', '+TuEvolutConst.SqlHoraAtual + ', GetDate(), @Terminal, 1)');
      for xPedido := 0 to Pred(pJsonArray.Count) do Begin
        Try
          vQryValida.Close;
          vQryValida.Sql.Clear;
          vQryValida.Sql.Add('Declare @RegistroERP VarChar(36) = :pRegistroERP');
          vQryValida.Sql.Add('Declare @PedidoId VarChar(36)    = :pPedidoId');
          vQryValida.Sql.Add('select Ped.DocumentoNr, Ped.RegistroERP, De.ProcessoId, De.Descricao Processo, De.Horario, Ped.Status');
          vQryValida.Sql.Add('From pedido Ped');
          vQryValida.Sql.Add('Left join vDocumentoEtapas De On De.Documento = Ped.uuid and');
          vQryValida.Sql.Add('                                 De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
          vQryValida.Sql.Add('where --DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and');
          vQryValida.Sql.Add('      Ped.OperacaoTipoId = 3 And');
          vQryValida.Sql.Add('      ((Cast(Ped.RegistroERP as VarChar(36)) = @RegistroERP) ');
          vQryValida.Sql.Add('       Or (Cast(PedidoId as VarChar(36))        = @PedidoId))');
          vQryValida.ParamByName('pRegistroERP').Value := pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
          vQryValida.ParamByName('pPedidoId').Value    := pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
          If DebugHook <> 0 Then
             vQryValida.Sql.SaveToFile('ValidaEntrada.Sql');
          vQryValida.Open;
          if (vQryValida.IsEmpty) then Begin
             Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                               .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                               .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                               .AddPair('mensagem', 'Documento não localizacado.'));
          End
          Else If ((vQryValida.FieldByName('ProcessoId').AsInteger > 4) or (vQryValida.FieldByName('Status').AsInteger = 2)) then Begin
             Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                               .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                               .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                               .AddPair('mensagem', 'Entrada não pode ser excluída. Processo: '+vQryValida.FieldByName('Processo').AsString));
          End
          Else begin
            vQryDelete.Close;
            vQryDelete.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
            vQryDelete.ParamByName('pTerminal').Value := pJsonArray.Items[xPedido].GetValue<String>('terminal');
            If DebugHook <> 0 Then
               vQryDelete.Sql.SaveToFile('PedidoExcluir.Sql');
            vQryDelete.ExecSql;
            Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                              .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                              .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                              .AddPair('mensagem', 'Entrada excluída com sucesso'));
          end;
        Except On E: Exception do
          Begin
            Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                              .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                              .AddPair('documentoerp', pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
                              .AddPair('mensagem', E.Message));
          End;
        End;
      End;
      vQryDelete.connection.Commit;
    Except On E: Exception do
      Begin
        vQryDelete.connection.Rollback;
        Result.AddElement(TJsonObject.Create.AddPair('status', '500')
              .AddPair('entradaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
              .AddPair('mensagem', E.Message));
      End;
    End;
  Finally
    FreeAndNil(vQryDelete);
    FreeAndNil(vQryValida);
  End;
end;

function TServiceRecebimento.FinalizarCheckIn(pjsonEntrada : TJsonObject): Boolean;
Var vQryFinalizar, vQryItens, vQryKardex: TFdQuery;
    EntradaId, vEnderecoIdStage: Integer;
    vSql: String;
    vRecno: Integer;
    vEstoqueInicial: Integer;
    vEnderecoSegregadoPadrao : Integer;
begin
  Result := False; // TJsonArray.Create;
  vQryFinalizar := TFdQuery.Create(Nil);
  vQryKardex    := TFdQuery.Create(Nil);
  vQryItens     := TFdQuery.Create(Nil);
  Try
    vQryFinalizar.Connection := Connection;
    vQryItens.Connection     := Connection;
    vQryKardex.Connection    := Connection;
    vQryFinalizar.connection.StartTransaction;
    vQryItens.Close;
    vQryItens.SQL.Clear;
    vQryItens.SQL.Add('Select EnderecoSegregadoId From Configuracao');
    vQryItens.Open();
    vEnderecoSegregadoPadrao := vQryItens.FieldByName('EnderecoSegregadoId').AsInteger;
    Try
      EntradaId := pjsonEntrada.GetValue<Integer>('pedido');
      vQryItens.connection := vQryFinalizar.connection;
      vQryItens.Close;
      vQryItens.Sql.Clear;
      vQryItens.Sql.Add('Select De.ProcessoId, Ped.Status ');
      vQryItens.Sql.Add('From Pedido Ped');
      vQryItens.Sql.Add('Inner join vDocumentoEtapas De On De.Documento = Ped.Uuid and');
      vQryItens.Sql.Add('                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
      vQryItens.Sql.Add('Where Ped.PedidoId = '+EntradaId.ToString());
      vQryItens.Open;
      if (vQryItens.FieldByName('ProcessoId').AsInteger = 5) or (vQryItens.FieldByName('Status').AsInteger = 2) then Begin
         vQryItens.Close;
         raise Exception.Create('Entrada já finalizada!!!');
      End;
      vQryItens.Close;
      vQryItens.Sql.Clear;
      vQryItens.Sql.Add('select PI.*, Rd.Data, Rh.hora ');
      vQryItens.Sql.Add('From PedidoItensCheckIn PI');
      vQryItens.Sql.Add('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
      vQryItens.Sql.Add('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
      vQryItens.Sql.Add('where PedidoId = ' + EntradaId.ToString());// + ' and Pi.QtdCheckIn > 0');
      vQryItens.Open;
      vRecno := vQryItens.RecordCount;
      vQryItens.First;
      while Not vQryItens.Eof do Begin
        // LoteId        := vQryItens.FieldByName('LoteId').AsInteger;
        vQryFinalizar.Close;
        vQryFinalizar.Sql.Clear;
        vQryFinalizar.Sql.Add('select LoteId, ');
        vQryFinalizar.Sql.Add('       (Case When SNGPC = 1 or ZonaSNGPC = 1 then (Select EnderecoIdStageSNGPC From Configuracao)');
        vQryFinalizar.Sql.Add('	            Else (Select EnderecoIdStage From Configuracao) End) EnderecoIdStage');
        vQryFinalizar.Sql.Add('from vProdutoLotes');
        vQryFinalizar.Sql.Add('where LoteId = :pLoteId');
        vQryFinalizar.ParamByName('pLoteId').Value := vQryItens.FieldByName('LoteId').AsInteger;
        vQryFinalizar.Open();
        vEnderecoIdStage := vQryFinalizar.FieldByName('EnderecoIdStage').AsInteger;
        // Pegar Saldo inicial do Lote
        vQryFinalizar.Close;
        vQryFinalizar.Sql.Clear;
        vQryFinalizar.Sql.Add('select Qtde From Estoque');
        vQryFinalizar.Sql.Add('Where LoteId = ' + vQryItens.FieldByName('LoteId').AsString);
        vQryFinalizar.Sql.Add('  And EnderecoId = ' + vEnderecoIdStage.ToString());
        vQryFinalizar.Sql.Add('  And EstoqueTipoId = 1');
        vQryFinalizar.Open;
        vEstoqueInicial := vQryFinalizar.FieldByName('Qtde').AsInteger;
        vQryFinalizar.Close;
        vQryFinalizar.Sql.Clear;
        vSql := 'Declare @EntradaId Integer = ' + EntradaId.ToString() + sLineBreak +
                'Declare @LoteId Integer = ' + vQryItens.FieldByName('LoteId').AsString + sLineBreak +
                'Declare @QtdXml     Integer = ' + vQryItens.FieldByName('QtdXml').AsString + sLineBreak +
                'Declare @QtdCheckIn Integer = ' + vQryItens.FieldByName('QtdCheckIn').AsString + sLineBreak +
                'Declare @QtdDevolvida Integer = ' + vQryItens.FieldByName('QtdDevolvida').AsString + sLineBreak +
                'Declare @QtdSegregada Integer = ' + vQryItens.FieldByName('QtdSegregada').AsString + sLineBreak +
                'Declare @EnderecoIdStage Integer = ' + vEnderecoIdStage.ToString();
        vSql := vSql +
                'If @QtdCheckIn > 0 Begin' + sLineBreak +
                '   If Exists (Select LoteId From Estoque Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage) Begin'+sLineBreak +
                '      Update Estoque Set Qtde = Qtde + @QtdCheckIn '+sLineBreak +
                '      	    , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+sLineBreak+
                '           , hralteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
                '         		, UsuarioIdAlt = '+vQryItens.FieldByName('UsuarioId').AsString+sLineBreak +
                '      Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage'+sLineBreak+
                '   End' + sLineBreak +
                '   Else Begin' + sLineBreak +
                '      Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao, UsuarioIdInc ) '+sLineBreak +
                '           Values (@LoteId, @EnderecoIdStage, 1, @QtdCheckIn, ' +sLineBreak +
                '                  (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+ sLineBreak +
                '                  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '+sLineBreak+
                '                  '+vQryItens.FieldByName('UsuarioId').AsString+' )'+sLineBreak +
                '   End;'+sLineBreak+
                'End;'+sLineBreak;
        vSql := vSql + 'If @QtdSegregada > 0 Begin' + sLineBreak +
                '   If Exists (Select LoteId From Estoque Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)) Begin'+ sLineBreak +
                '      Update Estoque Set Qtde = Qtde + @QtdSegregada '+sLineBreak +
                '      	    , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+sLineBreak+
                '           , hralteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
                '         		, UsuarioIdAlt = '+vQryItens.FieldByName('UsuarioId').AsString+sLineBreak +
                '      Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)'+sLineBreak+
                '   End' + sLineBreak +
                '	  Else Begin' + sLineBreak +
                '	     Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao, UsuarioIdInc ) Values (@LoteId, (Select EnderecoSegregadoId From Configuracao), 3, @QtdSegregada, '+sLineBreak +
                '						     (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak +
                '							    (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) '+sLineBreak +
                '         		, '+vQryItens.FieldByName('UsuarioId').AsString+' )'+sLineBreak +
                '   End;' + sLineBreak +
                '           '+sLineBreak+
                '   Insert Into SegregadoHistorico (Data, Hora, segregadocausaid, LoteId, EnderecoId, qtdsegregada, usuarioId, Terminal, Uuid) Values ('+sLineBreak+
                '        GetDate(), GetDate(), '+vQryItens.FieldByName('CausaId').AsString+', '+sLineBreak+
                '       '+vQryItens.FieldByName('LoteId').AsString+', '+vEnderecoSegregadoPadrao.ToString()+', @QtdSegregada, '+sLineBreak+
                '       '+vQryItens.FieldByName('UsuarioId').AsString+', '+sLineBreak+
                '       '+#39+vQryItens.FieldByName('UsuarioId').AsString+#39+', NewId() )'+sLineBreak+
                'End;';
        // try Clipboard.AsText := vSql; Except End;
        vQryFinalizar.Sql.Add(vSql);
        if DebugHook <> 0 then
          vQryFinalizar.Sql.SaveToFile('FinalizarCheckIn_AtEstoque' +
            vQryItens.FieldByName('LoteId').AsString + '.Sql');
        vQryFinalizar.ExecSql;
        vQryKardex.Close;
        vQryKardex.Sql.Clear;
        vQryKardex.Sql.Add(TuEvolutConst.SqlKardexInsUpd);
        vQryKardex.ParamByName('pOperacaoTipoId').Value       := 3;
        vQryKardex.ParamByName('pLoteId').Value               := vQryItens.FieldByName('LoteId').AsInteger;
        vQryKardex.ParamByName('pEnderecoId').Value           := vEnderecoIdStage;
        if vQryItens.FieldByName('QtdCheckIn').AsInteger > 0 then Begin
           vQryKardex.ParamByName('pObservacaoOrigem').Value     := 'Recebimento Pedido: ' + EntradaId.ToString();
           vQryKardex.ParamByName('pQuantidade').Value           := vQryItens.FieldByName('QtdCheckIn').AsInteger;
           vQryKardex.ParamByName('pEstoqueTipoId').Value        := 1;
           vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 1;
           vQryKardex.ParamByName('pEnderecoIdDestino').Value    := 1;
           vQryKardex.ParamByName('pObservacaoDestino').Value    := 'Stage - Área de Armazenagem(Espera)';
        End
        Else if vQryItens.FieldByName('QtdDevolvida').AsInteger > 0 then Begin
           vQryKardex.ParamByName('pObservacaoOrigem').Value     := 'Recebimento Pedido: ' + EntradaId.ToString()+' - DEVOLUÇÃO';
           vQryKardex.ParamByName('pQuantidade').Value           := vQryItens.FieldByName('QtdDevolvida').AsInteger;
           vQryKardex.ParamByName('pEstoqueTipoId').Value        := 1;
           vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 0;
           vQryKardex.ParamByName('pEnderecoIdDestino').Value    := 0;
           vQryKardex.ParamByName('pObservacaoDestino').Value    := 'Devolução Fornecedor';
        End
        Else if vQryItens.FieldByName('QtdSegregada').AsInteger > 0 then Begin
           vQryKardex.ParamByName('pObservacaoOrigem').Value     := 'Recebimento Pedido: ' + EntradaId.ToString()+' - SEGREGADO';
           vQryKardex.ParamByName('pQuantidade').Value           := vQryItens.FieldByName('QtdSegregada').AsInteger;
           vQryKardex.ParamByName('pEstoqueTipoId').Value        := 1;
           vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 3;
           vQryKardex.ParamByName('pEnderecoIdDestino').Value    := vEnderecoSegregadoPadrao;
           vQryKardex.ParamByName('pObservacaoDestino').Value    := 'Estoque Recebido - Segregado';
        End;
        vQryKardex.ParamByName('pUsuarioId').Value            := vQryItens.FieldByName('UsuarioId').AsInteger;
        vQryKardex.ParamByName('pNomeEstacao').Value          := vQryItens.FieldByName('Terminal').AsString;
        vQryKardex.ParamByName('pEstoqueInicial').Value       := vEstoqueInicial;
        If DebugHook <> 0 then
           vQryKardex.Sql.SaveToFile('AtKardex.Sql');
        if (vQryItens.FieldByName('QtdCheckIn').AsInteger > 0) or
           (vQryItens.FieldByName('QtdDevolvida').AsInteger > 0) or
           (vQryItens.FieldByName('QtdSegregada').AsInteger > 0) then
            vQryKardex.ExecSql;
        vQryItens.Next;
      End;
      // RegistrarDocumentoEtapa
      vQryFinalizar.Close;
      vQryFinalizar.Sql.Clear;
      vQryFinalizar.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+EntradaId.ToString() + ')');
      vQryFinalizar.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      vQryFinalizar.ParamByName('pProcessoId').Value := 5;
      vQryFinalizar.ParamByName('pUsuarioId').Value := pjsonEntrada.GetValue<Integer>('usuarioid');
      vQryFinalizar.ParamByName('pTerminal').Value := pjsonEntrada.GetValue<String>('terminal', '');
      vQryFinalizar.Sql.Add('');
      vQryFinalizar.Sql.Add('Update Pedido Set Status = 2 where pedidoid = ' + EntradaId.ToString());
      vQryFinalizar.ExecSql;
      vQryFinalizar.connection.Commit;
      Result := True;
    Except On E: Exception do
      Begin
        vQryFinalizar.connection.Rollback;
        raise Exception.Create('Processo: Recebimento/finalizarcheckinservice - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(vQryFinalizar);
    FreeAndNil(vQryItens);
    FreeAndNil(vQryKardex);
  End;
end;

Function TServiceRecebimento.FinalizarAgrupamentoNotas(pjsonEntrada: TJsonObject): TJsonArray;
Var vQryEntrada : TFdQuery;
    vQryFinalizar, vQryItens, vQryKardex: TFdQuery;
    EntradaId, vEnderecoIdStage: Integer;
    vSql: String;
    vRecno: Integer;
    vEstoqueInicial: Integer;
    vEnderecoSegregadoPadrao : Integer;
Begin
  vQryEntrada   := TFdQuery.Create(Nil);
  vQryFinalizar := TFdQuery.Create(Nil);
  vQryItens     := TFdQuery.Create(Nil);
  vQryKardex    := TFdQuery.Create(Nil);
  Try
    vQryEntrada.Connection   := Connection;
    vQryFinalizar.Connection := Connection;
    vQryItens.Connection     := Connection;
    vQryKardex.Connection    := Connection;
    Try
      vQryEntrada.Close;
      vQryEntrada.SQL.Clear;
      vQryEntrada.SQL.Add('Select EnderecoSegregadoId From Configuracao');
      vQryEntrada.Open();
      vEnderecoSegregadoPadrao := vQryEntrada.FieldByName('EnderecoSegregadoId').AsInteger;
      vQryEntrada.Close;
      vQryEntrada.SQL.Clear;
      vQryEntrada.SQL.Add('Select PAN.PedidoId, Ped.Status, De.ProcessoId');
      vQryEntrada.SQL.Add('From PedidoAgrupamentonotas PAN');
      vQryEntrada.SQL.Add('Inner join Pedido Ped On Ped.PedidoId = PAN.PedidoId');
      vQryEntrada.SQL.Add('Cross Apply (Select Top 1 ProcessoId');
      vQryEntrada.SQL.Add('             From DocumentoEtapas');
      vQryEntrada.SQL.Add('			 Where Documento = Ped.uuid and Status = 1');
      vQryEntrada.SQL.Add('			 Order by ProcessoId Desc) De');
      vQryEntrada.SQL.Add('Where AgrupamentoId = :pAgrupamentoId');
      vQryEntrada.ParamByName('pAgrupamentoId').Value := pJsonEntrada.GetValue<Integer>('agrupamentoid', 0);
      vQryEntrada.Open();
      if vQryEntrada.IsEmpty then Begin
         Raise  Exception.Create(TuEvolutConst.QrySemDados);
      End
      Else While Not vQryEntrada.Eof do Begin
        If (vQryEntrada.FieldByName('Status').AsInteger = 2) or (vQryEntrada.FieldByName('Processoid').AsInteger>4) then
           Raise Exception.Create('Entrada: '+vQryEntrada.FieldByName('PedidoId').AsString+' já finalizada! Solicite suporte Rhemasys Soluções.');
        vQryEntrada.Next;
      End;
      vQryEntrada.First;
      vQryEntrada.connection.StartTransaction;
      While Not vQryEntrada.Eof do Begin
         EntradaId := vQryEntrada.FieldByName('pedidoid').AsInteger;
         vQryItens.Close;
         vQryItens.Sql.Clear;
         vQryItens.Sql.Add('Select De.ProcessoId, Ped.Status ');
         vQryItens.Sql.Add('From Pedido Ped');
         vQryItens.Sql.Add('Inner join vDocumentoEtapas De On De.Documento = Ped.Uuid and');
         vQryItens.Sql.Add('                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
         vQryItens.Sql.Add('Where Ped.PedidoId = '+EntradaId.ToString());
         vQryItens.Open;
         if (vQryItens.FieldByName('ProcessoId').AsInteger = 5) or (vQryItens.FieldByName('Status').AsInteger = 2) then Begin
            vQryItens.Close;
            raise Exception.Create('Entrada já finalizada!!!');
         End;
         vQryItens.Close;
         vQryItens.Sql.Clear;
         vQryItens.Sql.Add('select PI.*, Rd.Data, Rh.hora ');
         vQryItens.Sql.Add('From PedidoItensCheckIn PI');
         vQryItens.Sql.Add('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
         vQryItens.Sql.Add('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
         vQryItens.Sql.Add('where PedidoId = ' + EntradaId.ToString());// + ' and Pi.QtdCheckIn > 0');
         vQryItens.Open;
         vRecno := vQryItens.RecordCount;
         vQryItens.First;
         while Not vQryItens.Eof do Begin
           // LoteId        := vQryItens.FieldByName('LoteId').AsInteger;
           vQryFinalizar.Close;
           vQryFinalizar.Sql.Clear;
           vQryFinalizar.Sql.Add('select LoteId, ');
           vQryFinalizar.Sql.Add('       (Case When SNGPC = 1 or ZonaSNGPC = 1 then (Select EnderecoIdStageSNGPC From Configuracao)');
           vQryFinalizar.Sql.Add('	            Else (Select EnderecoIdStage From Configuracao) End) EnderecoIdStage');
           vQryFinalizar.Sql.Add('from vProdutoLotes');
           vQryFinalizar.Sql.Add('where LoteId = :pLoteId');
           vQryFinalizar.ParamByName('pLoteId').Value := vQryItens.FieldByName('LoteId').AsInteger;
           vQryFinalizar.Open();
           vEnderecoIdStage := vQryFinalizar.FieldByName('EnderecoIdStage').AsInteger;
           // Pegar Saldo inicial do Lote
           vQryFinalizar.Close;
           vQryFinalizar.Sql.Clear;
           vQryFinalizar.Sql.Add('select Qtde From Estoque');
           vQryFinalizar.Sql.Add('Where LoteId = ' + vQryItens.FieldByName('LoteId').AsString);
           vQryFinalizar.Sql.Add('  And EnderecoId = ' + vEnderecoIdStage.ToString());
           vQryFinalizar.Sql.Add('  And EstoqueTipoId = 1');
           vQryFinalizar.Open;
           vEstoqueInicial := vQryFinalizar.FieldByName('Qtde').AsInteger;
           vQryFinalizar.Close;
           vQryFinalizar.Sql.Clear;
           vSql := 'Declare @EntradaId Integer = ' + EntradaId.ToString() + sLineBreak +
                   'Declare @LoteId Integer = ' + vQryItens.FieldByName('LoteId').AsString + sLineBreak +
                   'Declare @QtdXml     Integer = ' + vQryItens.FieldByName('QtdXml').AsString + sLineBreak +
                   'Declare @QtdCheckIn Integer = ' + vQryItens.FieldByName('QtdCheckIn').AsString + sLineBreak +
                   'Declare @QtdDevolvida Integer = ' + vQryItens.FieldByName('QtdDevolvida').AsString + sLineBreak +
                   'Declare @QtdSegregada Integer = ' + vQryItens.FieldByName('QtdSegregada').AsString + sLineBreak +
                   'Declare @EnderecoIdStage Integer = ' + vEnderecoIdStage.ToString();
           vSql := vSql +
                   'If @QtdCheckIn > 0 Begin' + sLineBreak +
                   '   If Exists (Select LoteId From Estoque Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage) Begin'+sLineBreak +
                   '      Update Estoque Set Qtde = Qtde + @QtdCheckIn '+sLineBreak +
                   '      	    , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+sLineBreak+
                   '           , hralteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
                   '         		, UsuarioIdAlt = '+vQryItens.FieldByName('UsuarioId').AsString+sLineBreak +
                   '      Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage'+sLineBreak+
                   '   End' + sLineBreak +
                   '   Else Begin' + sLineBreak +
                   '      Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao, UsuarioIdInc ) '+sLineBreak +
                   '           Values (@LoteId, @EnderecoIdStage, 1, @QtdCheckIn, ' +sLineBreak +
                   '                  (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+ sLineBreak +
                   '                  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '+sLineBreak+
                   '                  '+vQryItens.FieldByName('UsuarioId').AsString+' )'+sLineBreak +
                   '   End;'+sLineBreak+
                   'End;'+sLineBreak;
           vSql := vSql + 'If @QtdSegregada > 0 Begin' + sLineBreak +
                   '   If Exists (Select LoteId From Estoque Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)) Begin'+ sLineBreak +
                   '      Update Estoque Set Qtde = Qtde + @QtdSegregada '+sLineBreak +
                   '      	    , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+sLineBreak+
                   '           , hralteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
                   '         		, UsuarioIdAlt = '+vQryItens.FieldByName('UsuarioId').AsString+sLineBreak +
                   '      Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)'+sLineBreak+
                   '   End' + sLineBreak +
                   '	  Else Begin' + sLineBreak +
                   '	     Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao, UsuarioIdInc ) Values (@LoteId, (Select EnderecoSegregadoId From Configuracao), 3, @QtdSegregada, '+sLineBreak +
                   '						     (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak +
                   '							    (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) '+sLineBreak +
                   '         		, '+vQryItens.FieldByName('UsuarioId').AsString+' )'+sLineBreak +
                   '   End;' + sLineBreak +
                   '           '+sLineBreak+
                   '   Insert Into SegregadoHistorico (Data, Hora, segregadocausaid, LoteId, EnderecoId, qtdsegregada, usuarioId, Terminal, Uuid) Values ('+sLineBreak+
                   '        GetDate(), GetDate(), '+vQryItens.FieldByName('CausaId').AsString+', '+sLineBreak+
                   '       '+vQryItens.FieldByName('LoteId').AsString+', '+vEnderecoSegregadoPadrao.ToString()+', @QtdSegregada, '+sLineBreak+
                   '       '+vQryItens.FieldByName('UsuarioId').AsString+', '+sLineBreak+
                   '       '+#39+vQryItens.FieldByName('UsuarioId').AsString+#39+', NewId() )'+sLineBreak+
                   'End;';
           // try Clipboard.AsText := vSql; Except End;
           vQryFinalizar.Sql.Add(vSql);
           if DebugHook <> 0 then
              vQryFinalizar.Sql.SaveToFile('FinalizarCheckIn_AtEstoque' + vQryItens.FieldByName('LoteId').AsString + '.Sql');
           vQryFinalizar.ExecSql;
           vQryKardex.Close;
           vQryKardex.Sql.Clear;
           vQryKardex.Sql.Add(TuEvolutConst.SqlKardexInsUpd);
           vQryKardex.ParamByName('pOperacaoTipoId').Value       := 3;
           vQryKardex.ParamByName('pLoteId').Value               := vQryItens.FieldByName('LoteId').AsInteger;
           vQryKardex.ParamByName('pEnderecoId').Value           := vEnderecoIdStage;
           if vQryItens.FieldByName('QtdCheckIn').AsInteger > 0 then Begin
              vQryKardex.ParamByName('pObservacaoOrigem').Value     := 'Recebimento Pedido: ' + EntradaId.ToString();
              vQryKardex.ParamByName('pQuantidade').Value           := vQryItens.FieldByName('QtdCheckIn').AsInteger;
              vQryKardex.ParamByName('pEstoqueTipoId').Value        := 1;
              vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 1;
              vQryKardex.ParamByName('pEnderecoIdDestino').Value    := 1;
              vQryKardex.ParamByName('pObservacaoDestino').Value    := 'Stage - Área de Armazenagem(Espera)';
           End
           Else if vQryItens.FieldByName('QtdDevolvida').AsInteger > 0 then Begin
              vQryKardex.ParamByName('pObservacaoOrigem').Value     := 'Recebimento Pedido: ' + EntradaId.ToString()+' - DEVOLUÇÃO';
              vQryKardex.ParamByName('pQuantidade').Value           := vQryItens.FieldByName('QtdDevolvida').AsInteger;
              vQryKardex.ParamByName('pEstoqueTipoId').Value        := 1;
              vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 0;
              vQryKardex.ParamByName('pEnderecoIdDestino').Value    := 0;
              vQryKardex.ParamByName('pObservacaoDestino').Value    := 'Devolução Fornecedor';
           End
           Else if vQryItens.FieldByName('QtdSegregada').AsInteger > 0 then Begin
              vQryKardex.ParamByName('pObservacaoOrigem').Value     := 'Recebimento Pedido: ' + EntradaId.ToString()+' - SEGREGADO';
              vQryKardex.ParamByName('pQuantidade').Value           := vQryItens.FieldByName('QtdSegregada').AsInteger;
              vQryKardex.ParamByName('pEstoqueTipoId').Value        := 1;
              vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 3;
              vQryKardex.ParamByName('pEnderecoIdDestino').Value    := vEnderecoSegregadoPadrao;
              vQryKardex.ParamByName('pObservacaoDestino').Value    := 'Estoque Recebido - Segregado';
           End;
           vQryKardex.ParamByName('pUsuarioId').Value            := vQryItens.FieldByName('UsuarioId').AsInteger;
           vQryKardex.ParamByName('pNomeEstacao').Value          := vQryItens.FieldByName('Terminal').AsString;
           vQryKardex.ParamByName('pEstoqueInicial').Value       := vEstoqueInicial;
           If DebugHook <> 0 then
              vQryKardex.Sql.SaveToFile('AtKardex.Sql');
           if (vQryItens.FieldByName('QtdCheckIn').AsInteger > 0) or
              (vQryItens.FieldByName('QtdDevolvida').AsInteger > 0) or
              (vQryItens.FieldByName('QtdSegregada').AsInteger > 0) then
               vQryKardex.ExecSql;
           vQryItens.Next;
         End;
         vQryFinalizar.Close;
         vQryFinalizar.Sql.Clear;
         vQryFinalizar.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+EntradaId.ToString() + ')');
         vQryFinalizar.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
         vQryFinalizar.ParamByName('pProcessoId').Value := 5;
         vQryFinalizar.ParamByName('pUsuarioId').Value  := pjsonEntrada.GetValue<Integer>('usuarioid');
         vQryFinalizar.ParamByName('pTerminal').Value   := pjsonEntrada.GetValue<String>('terminal', '');
         vQryFinalizar.Sql.Add('');
         vQryFinalizar.Sql.Add('Update Pedido Set Status = 2 where pedidoid = ' + EntradaId.ToString());
         If DebugHook <> 0 then
            vQryFinalizar.SQL.SaveToFile('RegistarFInalizacaoNFAGrupada.Sql');
         vQryFinalizar.ExecSql;
         vQryEntrada.Next;
      End;
      vQryEntrada.connection.Commit;
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Agrupamento finalizdo com sucesso!'));
    Except On E: exception do Begin
      vQryEntrada.connection.Rollback;
      Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(vQryEntrada);
    FreeAndNil(vQryFinalizar);
    FreeAndNil(vQryItens);
    FreeAndNil(vQryKardex);
  End;
End;

function TServiceRecebimento.GetAcompanhamentoCheckIn(pPedidoId,
  pCodPessoaERP: Integer; pDataInicial, pDataFinal: TDateTime; pUsuarioId : Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetAcompanhamentoCheckIn);
      Query.ParamByName('pPedidoId').Value      := pPedidoId;
      Query.ParamByName('pCodPessoaERP').Value  := pCodPessoaERP;
      if pDataInicial = 0 then
         Query.ParamByName('pDataInicial').Value := 0
      Else
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      if pDataFinal = 0 then
         Query.ParamByName('pDataFinal').Value   := 0
      Else
         Query.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', pDataFinal);
      Query.ParamByName('pUsuarioId').Value      := pUsuarioId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaAcompanhamentoCheckIn.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/acompanhamentocheckin -'+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetAgrupamentoCheckIn(pAgrupamentoId: Integer): TJsonArray;
Var JsonArrayValidarAgrupamento : TJsonArray;
    vErro : String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      CorrigirErroProdutoReEnvio(pAgrupamentoId);
      JsonArrayValidarAgrupamento := ValidarCheckInAgrupamentoFinalizar(pAgrupamentoId);
      If Not JsonArrayValidarAgrupamento.Items[0].TryGetValue('Erro', vErro) then
         Raise Exception.Create('Divergência entre Qtd.Xml da NF e Qtde.Checkin!');
      Query.Close;
      Query.Sql.Clear;
      Query.SQL.Add('Declare @AgrupamentoId2 Integer = :pAgrupamentoId');
      Query.SQL.Add(';With');
      Query.SQL.Add('ChkAgrupado as (Select Pl.CodProduto, Pl.IdProduto ProdutoId, Pac.LoteId, Pl.Lote DescrLote, Rd.Data, ');// CheckInDtInicio,');
      Query.SQL.Add('                       Pac.UsuarioId, Rh.Hora, Pac.Terminal, Pac.QtdCheckIn, Pac.QtdDevolvida, Pac.QtdSegregada');
      Query.SQL.Add('                       , Pl.Data Fabricacao, Pl.Vencimento, Pac.CausaId, IsNull(Pac.RespAltLote, 0) RespAltLote');
      Query.SQL.Add('from PedidoItensCheckInAgrupamento Pac');
      Query.SQL.Add('Inner join vProdutoLotes Pl on Pl.Loteid = Pac.Loteid');
      Query.SQL.Add('Inner join Rhema_Data Rd On Rd.IdData = Pac.CheckInDtInicio');
      Query.SQL.Add('Inner join Rhema_Hora Rh On Rh.IdHora = Pac.CheckInHrInicio');
      Query.SQL.Add('Where AgrupamentoId = @AgrupamentoId2)');
      Query.SQL.Add('');
      Query.SQL.Add(', Itens as (Select PI.LoteId');
      Query.SQL.Add('            from PedidoItens PI');
      Query.SQL.Add('            Inner join PedidoAgrupamentoNotas PN On PN.pedidoid = PI.PedidoId');
      Query.SQL.Add('            where PN.agrupamentoid = @AgrupamentoId2');
      Query.SQL.Add('			Group by Pi.LoteId)');
      Query.SQL.Add('');
      Query.SQL.Add('select CA.*, (Case When I.LoteId IS Not Null then 1 Else 0 End) LoteExiste');
      Query.SQL.Add('From ChkAgrupado CA');
      Query.SQL.Add('Left Join Itens I On I.LoteId = CA.LoteId');
      Query.SQL.Add('Order By CA.ProdutoId, CA.LoteId, Data, Hora');
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('AgrupamentoCheckIn.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getagrupamentocheckin - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query)
  End;
end;

function TServiceRecebimento.GetAgrupamentoFatorarLoteXML(pAgrupamentoId : Integer): tJsonArray;
Var JsonObjectFatorarLoteXML: TJsonObject;
   Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetAgrupamentoFatorarLoteXML);
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('AgrupamentoFatorarLoteXML.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getagrupamentofatorarlotexml - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetAgrupamentoFatorarProduto(pAgrupamentoId : Integer): tJsonArray;
Var JsonObjectFatorarLoteXML: TJsonObject;
   Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetAgrupamentoFatorarProduto);
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetAgrupamentoFatorarProduto.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: GetAgrupamentoFatorarLoteXML - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer): tJsonArray;
Var JsonObjectFatorarLoteXML: TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.GetAgrupamentoFatorarPedidoLotes);
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('AgrupamentoFatorarPedidoLotes.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimetno/agrupamentopedidos - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP: Integer): tJsonArray;
Var vQryAgrupamentoLista: TFdQuery;
    vQryAgrupamentoPedido: TFdQuery;
    JsonObjectAgrupamento: TJsonObject;
begin
  Result := tJsonArray.Create;
  vQryAgrupamentoLista  := TFdQuery.Create(Nil);
  vQryAgrupamentoPedido := TFdQuery.Create(Nil);
  Try
    vQryAgrupamentoLista.Connection  := Connection;
    vQryAgrupamentoPedido.Connection := Connection;
    Try
      vQryAgrupamentoPedido.connection := vQryAgrupamentoLista.connection;
      vQryAgrupamentoLista.Sql.Add(TuEvolutConst.SqlGetAgrupamentoLista);
      vQryAgrupamentoLista.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      vQryAgrupamentoLista.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
      if DebugHook <> 0 then
         vQryAgrupamentoLista.Sql.SaveToFile('AgrupamentoLista.Sql');
      vQryAgrupamentoLista.Open;
      if vQryAgrupamentoLista.IsEmpty then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      Else
        while Not vQryAgrupamentoLista.Eof do Begin
          JsonObjectAgrupamento := TJsonObject.Create;
          JsonObjectAgrupamento.AddPair('agrupamentoid', TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('Agrupamentoid').AsInteger))
               .AddPair('codpessoaerp', TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('CodPessoaErp').AsInteger))
               .AddPair('fantasia', vQryAgrupamentoLista.FieldByName('fantasia').AsString)
               .AddPair('usuario', vQryAgrupamentoLista.FieldByName('usuario').AsString)
               .AddPair('data', vQryAgrupamentoLista.FieldByName('data').AsString)
               .AddPair('hora', vQryAgrupamentoLista.FieldByName('hora').AsString)
               .AddPair('terminal', vQryAgrupamentoLista.FieldByName('terminal').AsString)
               .AddPair('qtdxml', TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('qtdxml').AsInteger))
               .AddPair('qtdcheckin', TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('qtdcheckin').AsInteger))
               .AddPair('percconferencia', TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('percconferencia').AsFloat));
          // Pegar o detalhe(Pedidos)
          vQryAgrupamentoPedido.Close;
          vQryAgrupamentoPedido.Sql.Clear;
          vQryAgrupamentoPedido.Sql.Add(TuEvolutConst.SqlGetAgrupamentoPedidos);
          vQryAgrupamentoPedido.ParamByName('pAgrupamentoId').Value := vQryAgrupamentoLista.FieldByName('AgrupamentoId').AsInteger;
          vQryAgrupamentoPedido.ParamByName('pCodPessoaERP').Value := 0;
          if DebugHook <> 0 then
             vQryAgrupamentoPedido.Sql.SaveToFile('AgrupamentoPedidos.Sql');
          vQryAgrupamentoPedido.Open;
          if Not vQryAgrupamentoPedido.IsEmpty then
             JsonObjectAgrupamento.AddPair('pedidos', vQryAgrupamentoPedido.ToJSONArray)
          else
             JsonObjectAgrupamento.AddPair('pedidos', tJsonArray.Create);
          Result.AddElement(JsonObjectAgrupamento);
          vQryAgrupamentoLista.Next;
        End;
    Except On E: Exception do
      Begin
        vQryAgrupamentoLista.Close;
        raise Exception.Create('Processo: Recebimento/agrupamentopedidos - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(vQryAgrupamentoLista);
    FreeAndNil(vQryAgrupamentoPedido);
  End;
end;

function TServiceRecebimento.GetAgrupamentoPedido(pAgrupamentoId,
  pPedidoId: Integer): tJsonArray;
Var JsonObjectAgrupamento: TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Declare @PedidoId      Integer = :pPedidoId');
      Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
      Query.Sql.Add('Select * from PedidoAgrupamentoNotas');
      Query.Sql.Add('Where (@PedidoId = 0 or pedidoid = @PedidoId) And');
      Query.Sql.Add('      (@AgrupamentoId = 0 or agrupamentoid = @AgrupamentoId)');
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('AgrupamentoPedido.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/agrupamentopedidos - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetDshUserCheckIn(aQuery: TDictionary<String, String>): TJsonArray;
Var vRecebimentoInicial, vRecebimentoFinal : TDateTime;
    vProducaoInicial, vProducaoFinal       : TDateTime;
    vParamsOk : Integer;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      vRecebimentoInicial := 0;
      vRecebimentoFinal   := 0;
      vProducaoInicial    := 0;
      vProducaoFinal      := 0;
      if aQuery.Count <= 0 then
         raise Exception.Create('Informe os parâmetros da pesquisa!');
      if aQuery.ContainsKey('recebimentoinicial') then Begin
         vRecebimentoInicial := StrToDate(aQuery.Items['recebimentoinicial']);
         vParamsOk := vParamsOk + 1;
      End;
      if aQuery.ContainsKey('recebimentofinal') then Begin
         vRecebimentoFinal :=StrToDate(aQuery.Items['recebimentofinal']);
         vParamsOk := vParamsOk + 1;
      End;
      if aQuery.ContainsKey('producaoinicial') then Begin
         vProducaoInicial := StrToDate(aQuery.Items['producaoinicial']);
         vParamsOk := vParamsOk + 1;
      End;
      if aQuery.ContainsKey('producaofinal') then Begin
         vProducaoFinal :=StrToDate(aQuery.Items['producaofinal']);
         vParamsOk := vParamsOk + 1;
      End;
      Query.Sql.Add(TuEvolutConst.SqlDshUserCheckIn);
      if vRecebimentoInicial <> 0 then
         Query.ParamByName('pRecebimentoInicial').Value := FormatDateTime('YYYY-MM-DD', vRecebimentoInicial)
      Else
         Query.ParamByName('pRecebimentoInicial').Value := 0;
      if vRecebimentoFinal <> 0 then
         Query.ParamByName('pRecebimentoFinal').Value   := FormatDateTime('YYYY-MM-DD', vRecebimentoFinal)
      Else
         Query.ParamByName('pRecebimentoFinal').Value   := 0;

      if vProducaoInicial <> 0 then
         Query.ParamByName('pProducaoInicial').Value := FormatDateTime('YYYY-MM-DD', vProducaoInicial)
      Else
         Query.ParamByName('pProducaoInicial').Value := 0;
      if vProducaoFinal <> 0 then
         Query.ParamByName('pProducaoFinal').Value   := FormatDateTime('YYYY-MM-DD', vProducaoFinal)
      Else
         Query.ParamByName('pProducaoFinal').Value   := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('DshUserCheckIn.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getdshcheckin - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEntradaItens(pPedidoId, pAgrupamentoId: Integer) : tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetPedidoItens);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaItens.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getentradaitens - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetEntradaLoteCheckIn);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaLoteCheckIn.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := tJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/entradalotecheckin - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetEntradaLoteDevolucao);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaLoteDevolucao.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := tJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/entradalotedevolucao - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEntradaLotes(pPedidoId, pAgrupamentoId, pCodProduto, pLoteId: Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if pAgrupamentoId = 0 then
         Query.Sql.Add(TuEvolutConst.SqlGetEntradaLotes)
      else
         Query.Sql.Add(TuEvolutConst.SqlGetEntradaLotesAgrupamento);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      Query.ParamByName('pLoteId').Value := pLoteId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaLotes.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimo/getentradalote - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEntradaProdutoSemPicking(pDataInicial,
  pDataFinal: TDateTime; pPedidoId: Integer; pCodPessoaERP: Integer;
  pDocumentoNr: String): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetEntradaProdutoSemPicking);
      if pDataInicial = 0 then
         Query.ParamByName('pDataInicial').Value := 0
      Else
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      if pDataFinal = 0 then
         Query.ParamByName('pDataFinal').Value := 0
      Else
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', pDataFinal);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetEntradaProdutoSemPicking.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getentradaprodutosempicking - ');
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEntradaProduto(pPedidoId, pAgrupamentoId : Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if pAgrupamentoId > 0 then
         Query.Sql.Add(TuEvolutConst.SqlGetEntradaProdutoAgrupamento)
      Else
         Query.Sql.Add(TuEvolutConst.SqlGetEntradaProduto);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaProdutos.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getentradaprodutos - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetEtiquetaArmazenagem(pPedidoId: Integer;
  pDocumentoNr: String; pZonaId, pCodProduto, pSintetico: Integer;
  pDtInicio, pDtTermino: TDateTime): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := tJsonArray.Create;
      if pSintetico = 0 then
         Query.Sql.Add(TuEvolutConst.SqlRelEtiquetaArmazenagem)
      Else
         Query.Sql.Add(TuEvolutConst.SqlRelEtqArmazenagemResumo);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if pDtInicio <> 0 then
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDtInicio)
      Else
         Query.ParamByName('pDtInicio').Value := 0;
      if pDtTermino <> 0 then
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDtTermino)
      Else
         Query.ParamByName('pDtTermino').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EtqArmazenagem.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/etiquetaarmazenagem - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetOcorrencias(pPedidoId: Integer;
  pDocumentoNr, pRegistroERP: String; pCodProduto: Integer;
  pDataInicial, pDataFinal, pDataCheckInInicial, pDataCheckInFinal: TDateTime)
  : tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetEntradaOcorrencia);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if pDataInicial = 0 then
         Query.ParamByName('pDoctoDataIni').Value := 0
      Else
         Query.ParamByName('pDoctoDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      if pDataFinal = 0 then
         Query.ParamByName('pDoctoDataFin').Value := 0
      Else
         Query.ParamByName('pDoctoDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFinal);
      if pDataCheckInInicial = 0 then
         Query.ParamByName('pCheckInDtIni').Value := 0
      Else
         Query.ParamByName('pCheckInDtIni').Value := FormatDateTime('YYYY-MM-DD', pDataCheckInInicial);
      if pDataCheckInFinal = 0 then
         Query.ParamByName('pCheckInDtFin').Value := 0
      Else
         Query.ParamByName('pCheckInDtFin').Value := FormatDateTime('YYYY-MM-DD', pDataCheckInFinal);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaOcorrencias.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetProdutoTagByProduto(aQuery: TDictionary<String, String>): tJsonArray;
var vParamsOk, pPedidoId, pCodigoERP: Integer;
    pDocumentoNr, pRegistroERP: String;
    pDtDocumentoData, pDtCheckInFinalizacao: TDateTime;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    pPedidoId := 0;
    pCodigoERP := 0;
    pDocumentoNr := '';
    pRegistroERP := '';
    pDtDocumentoData := 0;
    pDtCheckInFinalizacao := 0;
    vParamsOk := 0;
    if aQuery.ContainsKey('pedidoid') then
    Begin
      pPedidoId := StrToIntDef(aQuery.Items['pedidoid'], 0);
      vParamsOk := vParamsOk + 1;
    End;
    if aQuery.ContainsKey('codigoerp') then
    Begin
      pCodigoERP := StrToIntDef(aQuery.Items['codigoerp'], 0);
      vParamsOk := vParamsOk + 1;
    End;
    if aQuery.ContainsKey('documentonr') then
    Begin
      pDocumentoNr := aQuery.Items['documentonr'];
      vParamsOk := vParamsOk + 1;
    End;
    if aQuery.ContainsKey('registroerp') then
    Begin
      pRegistroERP := aQuery.Items['registroerp'];
      vParamsOk := vParamsOk + 1;
    End;
    if aQuery.ContainsKey('documentodata') then
    Begin
      Try
        pDtDocumentoData := StrToDate(aQuery.Items['documentodata']);
        vParamsOk := vParamsOk + 1;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data dos Pedidos é inválida!')));
        Exit;
      End;
    End;
    if aQuery.ContainsKey('dtcheckinfinalizacao') then
    Begin
      Try
        pDtCheckInFinalizacao := StrToDate(aQuery.Items['dtcheckinfinalizacao']);
        vParamsOk := vParamsOk + 1;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data de finalização do CheckIn é inválida!')));
        Exit;
      End;
    End;
    if vParamsOk <> aQuery.Count then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Parâmetros da consulta definidos incorretamente!')));
      Exit;
    End;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetProdutoTagByProduto);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pCodigoERP').Value := pCodigoERP;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      if pDtDocumentoData = 0 then
         Query.ParamByName('pDtDocumentoData').Value := 0
      Else
         Query.ParamByName('pDtDocumentoData').Value := FormatDateTime('YYYY-MM-DD', pDtDocumentoData);
      if pDtCheckInFinalizacao = 0 then
         Query.ParamByName('pDtCheckInFinalizacao').Value := 0
      Else
         Query.ParamByName('pDtCheckInFinalizacao').Value := FormatDateTime('YYYY-MM-DD', pDtCheckInFinalizacao);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProdutoTagByProduto');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimeto/produtotagbyproduto - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.GetResumoCheckIn(pEntradaId: Integer): tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    if pEntradaId <= 0 then Begin
       Raise Exception.Create('Processo: ResumoCheckin - Informe o Id da Entrada.');
    End;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetResumoCheckIn);
      Query.ParamByName('pPedidoid').Value := pEntradaId;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('ResumoCheckIn.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.Header(pEntradaId, pAgrupamentoId: Integer) : tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlEntradaHeader);
      Query.ParamByName('pPedidoId').Value := pEntradaId;
      Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EntradaHeader.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/header - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.Pesquisar(pPedidoId, pCodPessoaERP: Integer;
  pDocumento, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
  pPendente: Integer; pAgrupamentoId: Integer; pCodProduto, pDescrProduto : String; pBasico: Boolean;
  pShowErro: Integer): tJsonArray;
var // VQry,
  vQryRecebimentos: TFdQuery;
  vQryItens: TFdQuery;
  vSql, vSqlItens: String;
  ObjJson: TJsonObject;
  vItens, vProdutoId: Integer;

  JsonRecebimento: TJsonObject;
  ObjEntrada: TEntrada;
  ObjEntradaItens: TEntradaItens;
  JsonArrayitens: tJsonArray;
  JsonArrayProduto: tJsonArray;
  LServiceProduto: TServiceProduto;
  aQueryParamProduto: TDictionary<String, String>;
begin // Processo lento
  vQryRecebimentos := TFdQuery.Create(Nil);
  vQryItens        := TFdQuery.Create(Nil);
  Try
    vQryRecebimentos.Connection := Connection;
    vQryItens.Connection        := Connection;
    Try
      vQryRecebimentos.Sql.Add(SqlEntrada);
      vQryRecebimentos.ParamByName('pPedidoId').Value      := pPedidoId;
      vQryRecebimentos.ParamByName('pCodPessoaERP').Value  := pCodPessoaERP;
      vQryRecebimentos.ParamByName('pDocumentoNr').Value   := pDocumento;
      vQryRecebimentos.ParamByName('pRazao').Value         := '%' + pRazao + '%';
      vQryRecebimentos.ParamByName('pRegistroERP').Value   := pRegistroERP;
      vQryRecebimentos.ParamByName('pCodProduto').Value    := pCodProduto;
      vQryRecebimentos.ParamByName('pDescrProduto').Value  := '%'+pDescrProduto+'%';
      vQryRecebimentos.ParamByName('pPendente').Value      := pPendente;
      vQryRecebimentos.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
      vQryRecebimentos.Sql.Add('--pAgrupamentoId = ' + pAgrupamentoId.ToString());
      if pDtNotaFiscal = 0 then
         vQryRecebimentos.ParamByName('pDtNotaFiscal').Value := 0
      Else
         vQryRecebimentos.ParamByName('pDtNotaFiscal').Value := FormatDateTime('YYYY-MM-DD', pDtNotaFiscal);
      if DebugHook <> 0 then
         vQryRecebimentos.Sql.SaveToFile('EntradaPesquisar.Sql');
      vQryRecebimentos.Open;
      if vQryRecebimentos.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else if pBasico then
         Result := vQryRecebimentos.ToJSONArray
      Else
      Begin
        Result := tJsonArray.Create;
        while Not vQryRecebimentos.Eof do Begin
          ObjEntrada := TEntrada.Create;
          ObjEntrada.EntradaId := vQryRecebimentos.FieldByName('PedidoId').AsInteger;
          ObjEntrada.OperacaoTipo.OperacaoTipoId := vQryRecebimentos.FieldByName('OperacaoTipoId').AsInteger;
          ObjEntrada.OperacaoTipo.Descricao := vQryRecebimentos.FieldByName('OperacaoTipo').AsString;
          ObjEntrada.Pessoa.PessoaId := vQryRecebimentos.FieldByName('PessoaId').AsInteger;
          ObjEntrada.Pessoa.CodPessoa := vQryRecebimentos.FieldByName('CodPessoaERP').AsInteger;
          ObjEntrada.Pessoa.Razao := vQryRecebimentos.FieldByName('Razao').AsString;
          ObjEntrada.DocumentoNr := vQryRecebimentos.FieldByName('DocumentoNr').AsString;
          ObjEntrada.DocumentoData := vQryRecebimentos.FieldByName('DocumentoData').AsDateTime;
          ObjEntrada.RegistroERP := vQryRecebimentos.FieldByName('RegistroERP').AsString;
          ObjEntrada.DtInclusao := vQryRecebimentos.FieldByName('DtInclusao').AsDateTime;
          ObjEntrada.HrInclusao := StrToTime(Copy(vQryRecebimentos.FieldByName('HrInclusao').AsString, 1, 8));
          ObjEntrada.ArmazemId := vQryRecebimentos.FieldByName('ArmazemId').AsInteger;
          ObjEntrada.Status := vQryRecebimentos.FieldByName('Status').AsInteger;
          ObjEntrada.ProcessoId := vQryRecebimentos.FieldByName('ProcessoId').AsInteger;
          ObjEntrada.Processo := vQryRecebimentos.FieldByName('Processo').AsString;
          vQryItens.Close;
          vQryItens.Sql.Clear;
          vQryItens.Sql.Add('Declare @pPedido  Integer = ' + ObjEntrada.EntradaId.ToString());
          vQryItens.Sql.Add('Declare @ProdutoId Integer = 0');
          vQryItens.Sql.Add('Declare @LoteId Integer    = 0');
          vQryItens.Sql.Add(SqlEntradaItens);
          vQryItens.Sql.Add('   and (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId)');
          vQryItens.Sql.Add('   and (@LoteId    = 0 or Pl.LoteId     = @LoteId) ');
          vQryItens.Sql.Add('Order by PIt.PedidoId, PIt.PedidoItemId');
          if DebugHook <> 0 then
             vQryItens.Sql.SaveToFile('PedidoItens.Sql');
          vQryItens.Open;
          vQryItens.First;
          vProdutoId := 0;
          if Not vQryItens.IsEmpty then
             While Not vQryItens.Eof do Begin
              ObjEntradaItens := TEntradaItens.Create;
              ObjEntradaItens.EntradaId := vQryItens.FieldByName('PedidoId').AsInteger;
              ObjEntradaItens.EntradaItemId := vQryItens.FieldByName('PedidoItemId').AsInteger;
              LServiceProduto := TServiceProduto.Create;
              aQueryParamProduto := TDictionary<String, String>.Create;
              aQueryParamProduto.Add('codigoerp', vQryItens.FieldByName('CodigoERP').AsString);
              JsonArrayProduto := LServiceProduto.GetProduto(aQueryParamProduto);
              ObjEntradaItens := TEntradaItens.Create;
              ObjEntradaItens.EntradaId := vQryItens.FieldByName('PedidoId').AsInteger;
              ObjEntradaItens.EntradaItemId := vQryItens.FieldByName('PedidoItemId').AsInteger;
              ObjEntradaItens.ProdutoLotes.Produto := TJson.JsonToObject<TProduto>(JsonArrayProduto.Items[0] as TJsonObject);
              ObjEntradaItens.ProdutoLotes.Lotes.LoteId     := vQryItens.FieldByName('LoteId').AsInteger;
              ObjEntradaItens.ProdutoLotes.Lotes.ProdutoId  := vQryItens.FieldByName('ProdutoId').AsInteger;
              ObjEntradaItens.ProdutoLotes.Lotes.CodigoERP  := vQryItens.FieldByName('CodigoERP').AsInteger;
              ObjEntradaItens.ProdutoLotes.Lotes.DescrLote  := vQryItens.FieldByName('descrLote').AsString;
              ObjEntradaItens.ProdutoLotes.Lotes.Fabricacao := vQryItens.FieldByName('Fabricacao').AsDateTime;
              ObjEntradaItens.ProdutoLotes.Lotes.Vencimento := vQryItens.FieldByName('Vencimento').AsDateTime;
              ObjEntradaItens.ProdutoLotes.Lotes.DtEntrada  := vQryItens.FieldByName('DtEntrada').AsDateTime;
              ObjEntradaItens.ProdutoLotes.Lotes.HrEntrada  := StrToTime(Copy(vQryItens.FieldByName('HrEntrada').AsString, 1, 8));
              ObjEntradaItens.ProdutoLotes.Lotes.QtdeDisponivel := 0;
              ObjEntradaItens.QtdXml       := vQryItens.FieldByName('QtdXml').AsInteger;
              ObjEntradaItens.QtdCheckIn   := vQryItens.FieldByName('QtdCheckIn').AsInteger;
              ObjEntradaItens.QtdDevolvida := vQryItens.FieldByName('QtdDevolvida').AsInteger;
              ObjEntradaItens.QtdSegregada := vQryItens.FieldByName('QtdSegregada').AsInteger;
              ObjEntradaItens.PrintEtqControlado := vQryItens.FieldByName('PrintEtqControlado').AsInteger;
              ObjEntrada.Itens.Add(ObjEntradaItens);
              vQryItens.Next;
            End;
          Result.AddElement(tJson.ObjectToJsonObject(ObjEntrada, [joDateFormatISO8601]));
          vQryRecebimentos.Next;
        End;
      End;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/pesquisa - '+TUTil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQryRecebimentos.Close;
    vQryItens.Close;
  End;
end;

function TServiceRecebimento.RegPrintEtqProduto(pPedidoId, pLoteId: Integer) : tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Clear;
      Query.Sql.Add('Update PedidoItens');
      Query.Sql.Add('  Set PrintEtqControlado = 1');
      Query.Sql.Add('Where PedidoId = ' + pPedidoId.ToString() + 'and LoteId = ' + pLoteId.ToString());
      Query.ExecSql;
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Registrar impressão Etiquetas Controlado - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.SalvarAgrupamento(pNotaAgrupamentoJsonArray
  : tJsonArray): tJsonArray;
Var xNotas: Integer;
    vAgrupamentoId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      Query.Sql.Clear;
      Query.Sql.Add('Declare @AgrupamentoId Integer = 0');
      Query.Sql.Add('Insert into PedidoAgrupamento Values (');
      Query.Sql.Add(pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<Integer>('usuarioid').ToString() + ', '+
                    #39+pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<String>('terminal')+#39+', ' +
                    #39 + FormatDateTime('YYYY-MM-DD', StrToDate(pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<String>('data')))+#39+', '+
                    #39 + FormatDateTime('hh:mm:ss', StrToTime(pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<String>('hora')))+#39 + ', 1 ');
      Query.Sql.Add(')');
      Query.Sql.Add('Set @AgrupamentoId = SCOPE_IDENTITY()');
      Query.Sql.Add('Select @AgrupamentoId As ItemId');
      Query.Open;
      vAgrupamentoId := Query.FieldByName('ItemId').AsInteger;
      for xNotas := 0 to Pred(pNotaAgrupamentoJsonArray.Count) do Begin
        Query.Sql.Clear;
        Query.Sql.Add('Insert into PedidoAgrupamentoNotas Values (');
        Query.Sql.Add(vAgrupamentoId.ToString + ',' + pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<Integer>('pedidoid').ToString());
        Query.Sql.Add(')');
        Query.ExecSql;
      End;
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: Salvar Agrupamento - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.SalvarCheckInItem(pjsonEntrada: TJsonObject) : TJsonObject;
Var jsonEntradaItem: TJsonObject;
    JsonArrayitens: tJsonArray;
    xItens: Integer;
    vSql: String;
    EntradaId, EntradaItemId, ProdutoId, LoteId: Integer;
    DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada: String;
    QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada, CausaId, UsuarioId, RespAltLoteId: Integer;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      EntradaId := pjsonEntrada.GetValue<Integer>('pedido');
      JsonArrayitens := pjsonEntrada.Get('itens').JsonValue as tJsonArray;
      For xItens := 0 to JsonArrayitens.Count - 1 do Begin
        jsonEntradaItem := JsonArrayitens.Items[xItens] as TJsonObject;
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Select Pl.ProdutoId, Sum(QtdXML) QtdXML, Sum(PI.qtdcheckin+PI.qtddevolvida+PI.qtdsegregada) TotalCheckIn');
        Query.Sql.Add('From PedidoItens PI');
        Query.Sql.Add('Inner Join ProdutoLotes PL ON Pl.LoteId = Pi.LoteId');
        Query.Sql.Add('Where Pi.pedidoid = ' + EntradaId.ToString()+' and Pl.ProdutoId = ' + jsonEntradaItem.GetValue<String>('produtoid'));
        Query.Sql.Add('Group By Pl.ProdutoId');
        If DebugHook <> 0 then
           Query.Sql.SaveToFile('ValidarCheckIn.Sql');
        Query.Open();
        if Query.FieldByName('QtdXml').AsInteger < (Query.FieldByName('TotalCheckIn').AsInteger +
                                                    jsonEntradaItem.GetValue<Integer>('qtdcheckin')+
                                                    jsonEntradaItem.GetValue<Integer>('qtddevolvida') +
                                                    jsonEntradaItem.GetValue<Integer>('qtdsegregada')) then
           raise Exception.Create('Quantidade CheckIn('+Query.FieldByName('TotalCheckIn').AsString +') maior que no XML!');
        Query.Close;
        Query.Sql.Clear;
        EntradaItemId := 0; // jsonEntradaItem.GetValue<integer>('entradaitemid');
        ProdutoId     := jsonEntradaItem.GetValue<Integer>('produtoid');
        LoteId        := 0; // jsonEntradaItem.GetValue<Integer>('loteid');
        DescrLote     := jsonEntradaItem.GetValue<String>('descrlote');
        Fabricacao    := jsonEntradaItem.GetValue<string>('fabricacao');
        Vencimento    := jsonEntradaItem.GetValue<string>('vencimento');
        DtEntrada     := jsonEntradaItem.GetValue<string>('dtentrada');
        HrEntrada     := jsonEntradaItem.GetValue<string>('hrentrada');
        QtdXml        := jsonEntradaItem.GetValue<Integer>('qtdxml');
        QtdCheckIn    := jsonEntradaItem.GetValue<Integer>('qtdcheckin');
        QtdDevolvida  := jsonEntradaItem.GetValue<Integer>('qtddevolvida');
        CausaId       := jsonEntradaItem.GetValue<Integer>('causaid');
        QtdSegregada  := jsonEntradaItem.GetValue<Integer>('qtdsegregada');
        UsuarioId     := jsonEntradaItem.GetValue<Integer>('usuarioid');
        RespAltLoteId := jsonEntradaItem.GetValue<Integer>('respaltloteid');
        // Salvar no banco
        Query.Sql.Add('Declare @EntradaId Integer = '+EntradaId.ToString());
        Query.Sql.Add('Declare @EntradaItemId Integer = '+EntradaItemId.ToString());
        Query.Sql.Add('Declare @ProdutoId Integer     = ' + ProdutoId.ToString());
        Query.Sql.Add('Declare @LoteId Integer        = ' + LoteId.ToString);
        Query.Sql.Add('Declare @DescrLote VarChar(30) = ' + #39 + DescrLote + #39);
        Query.Sql.Add('Declare @Fabricacao Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(Fabricacao)) + #39);
        Query.Sql.Add('Declare @Vencimento Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(Vencimento)) + #39);
        Query.Sql.Add('Declare @DtEntrada  Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(DtEntrada)) + #39);
        Query.Sql.Add('Declare @HrEntrada  Time = '+#39 + HrEntrada + #39);
        Query.Sql.Add('Declare @QtdXml     Integer    = '+QtdXml.ToString());
        Query.Sql.Add('Declare @QtdCheckIn Integer    = '+QtdCheckIn.ToString());
        Query.Sql.Add('Declare @QtdDevolvida Integer  = '+QtdDevolvida.ToString());
        Query.Sql.Add('Declare @QtdSegregada Integer  = ' + QtdSegregada.ToString());
        Query.Sql.Add('Declare @CausaId Integer       = ' + CausaId.ToString());
        Query.Sql.Add('Declare @Usuarioid Integer     = ' + UsuarioId.ToString());
        Query.Sql.Add('Declare @RespAltLoteId Integer = '+RespAltLoteId.ToString());
        Query.Sql.Add('Declare @Terminal Varchar(50)  = '+#39+jsonEntradaItem.GetValue<String>('terminal') + #39);
        Query.Sql.Add('If @LoteId = 0');
        Query.Sql.Add('   Set @LoteId = Coalesce((Select LoteId From ProdutoLotes');
        Query.Sql.Add('                           Where ProdutoId = @ProdutoId and DescrLote = @DescrLote), 0)');
        Query.Sql.Add('If @LoteId = 0 Begin');
        Query.Sql.Add('   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, ');
        Query.Sql.Add('          (Select IdData From Rhema_Data Where Data = @Fabricacao),');
        Query.Sql.Add('          (Select IdData From Rhema_Data Where Data = @Vencimento),');
        Query.Sql.Add('           '+TuEvolutConst.SqlDataAtual+', '+TuEvolutConst.SqlHoraAtual+', NewId())');
        Query.Sql.Add('   Set @LoteId = (Select LoteId From ProdutoLotes ');
        Query.Sql.Add('                  Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)');
        Query.Sql.Add('End');
        Query.Sql.Add('Else Begin');
        Query.Sql.Add('   Update ProdutoLotes Set');
        Query.Sql.Add('      Fabricacao = (Select IdData from Rhema_data Where Data = @Fabricacao),');
        Query.Sql.Add('      Vencimento = (Select IdData from Rhema_data Where Data = @Vencimento)');
        Query.Sql.Add('   Where LoteId = @LoteId');
        Query.Sql.Add('End;');
        // Novo Lote não pertencente ao XML origiginal
        Query.Sql.Add('Set @EntradaItemId = Coalesce((Select Pi.PedidoItemId From PedidoItens Pi');
        Query.Sql.Add('                               Inner join ProdutoLotes Pl On Pl.LoteId = Pi.LoteId');
        Query.Sql.Add('                               Where PedidoId = @EntradaId and Pl.ProdutoId = @ProdutoId and Pl.DescrLote = @DescrLote), 0)');
        Query.Sql.Add('If @EntradaItemId = 0 Begin');
        Query.Sql.Add('   Insert Into PedidoItens Values (@EntradaId, @LoteId, 0, @QtdCheckIn, @QtdDevolvida, @QtdSegregada, 0, newid())');
        Query.Sql.Add('   Set @QtdXML = 0');
        Query.Sql.Add('End');
        Query.Sql.Add('Else Begin');
        Query.Sql.Add('   Update PedidoItens Set ');
        Query.Sql.Add('      QtdCheckIn = QtdCheckIn+@QtdCheckIn');
        Query.Sql.Add('    , QtdDevolvida = QtdDevolvida+@QtdDevolvida');
        Query.Sql.Add('    , QtdSegregada = QtdSegregada+@QtdSegregada');
        Query.Sql.Add('   Where PedidoItemId = @EntradaItemId');
        Query.Sql.Add('End;');
        Query.Sql.Add('Insert Into PedidoItensCheckIn Values (@EntradaId, @LoteId, @UsuarioId,');
        Query.Sql.Add('       0, @QtdCheckIn, @QtdDevolvida, @QtdSegregada, @Causaid, ');
        Query.Sql.Add('       (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
        Query.Sql.Add('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
        Query.Sql.Add('       (Case When @RespAltLoteId = 0 then Null Else @RespAltLoteId End), NewId(), @Terminal)');
        Query.Sql.Add('If Not Exists (select DocumentoEtapaId');
        Query.Sql.Add('               From DocumentoEtapas');
        Query.Sql.Add('               where Documento = (Select UUid From Pedido Where PedidoId = @EntradaId)');
        Query.Sql.Add('                 and ProcessoId = 4 and Status = 1) Begin');
        Query.Sql.Add('   Insert Into DocumentoEtapas Values (');
        Query.Sql.Add('          Cast((Select Uuid from Pedido');
        Query.Sql.Add('                Where ((Cast(PedidoId as VarChar(36)) = @EntradaId))) as UNIQUEIDENTIFIER), ');
        Query.Sql.Add('          4, @UsuarioId, ' + TuEvolutConst.SqlDataAtual+', '+TuEvolutConst.SqlHoraAtual+',');
        Query.Sql.Add('          GetDate(), @Terminal, 1)');
        Query.Sql.Add('End;');
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('SalvarCheckin.Sql');
        Query.ExecSql;
      End;
      Query.connection.Commit;
      Try
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Select PI.Pedidoitemid, PI.loteid, PI.qtdcheckin, PI.qtddevolvida, PI.qtdsegregada ');
        Query.Sql.Add('From PedidoItens PI');
        Query.Sql.Add('Inner Join ProdutoLotes PL ON Pl.LoteId = Pi.LoteId and Pl.ProdutoId = '+ProdutoId.ToString() + ' and Pl.DescrLote = ' + QuotedStr(DescrLote));
        Query.Sql.Add('Where Pi.pedidoid = ' + EntradaId.ToString());
        Query.Open();
        Result := TJsonObject.Create;
        With Result do Begin
          AddPair('pedidoitemid', TJsonNumber.Create(Query.FieldByName('PedidoItemId').AsInteger));
          AddPair('loteid', TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
          AddPair('qtdcheckin', TJsonNumber.Create(Query.FieldByName('QtdCheckIn').AsInteger));
          AddPair('qtddevolvida', TJsonNumber.Create(Query.FieldByName('QtdDevolvida').AsInteger));
          AddPair('qtdsegregada', TJsonNumber.Create(Query.FieldByName('QtdSegregada').AsInteger));
        End;
      Except
        //Seguranca sem comprometer o resultado
        Result := TJsonObject.Create;
        With Result do Begin
          AddPair('pedidoitemid', TJsonNumber.Create(0));
          AddPair('loteid', TJsonNumber.Create(0));
          AddPair('qtdcheckin', TJsonNumber.Create(0));
          AddPair('qtddevolvida', TJsonNumber.Create(0));
          AddPair('qtdsegregada', TJsonNumber.Create(0));
        End;
      End;
      jsonEntradaItem := Nil;
      jsonArrayItens  := Nil;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: SalvarCheckInItem - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.SalvarCheckInItemAgrupamento(pJsonItemCheckIn : TJsonObject): TJsonObject;
Var vSql: String;
    vAgrupamentoId: Integer;
    xItens: Integer;
    JsonArrayitens: tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      vAgrupamentoId := pJsonItemCheckIn.GetValue<Integer>('agrupamentoid');
      JsonArrayitens := pJsonItemCheckIn.GetValue<tJsonArray>('itens');
      for xItens := 0 to Pred(JsonArrayitens.Count) do Begin
        Query.Close;
        Query.Sql.Clear;
        // Salvar no banco
        vSql := 'Declare @AgrupamentoId Integer = ' + vAgrupamentoId.ToString() +sLineBreak +
                'Declare @ProdutoId Integer     = ' + JsonArrayitens.Items[xItens].GetValue<string>('produtoid') + sLineBreak +
                'Declare @LoteId Integer = ' + JsonArrayitens.Items[xItens].GetValue<string>('loteid') + sLineBreak +
                'Declare @DescrLote VarChar(30) = ' + #39 + JsonArrayitens.Items[xItens].GetValue<string>('descrlote') + #39 + sLineBreak +
                'Declare @Fabricacao Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(JsonArrayitens.Items[xItens].GetValue<string>('fabricacao')))+#39+sLineBreak+
                'Declare @Vencimento Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(JsonArrayitens.Items[xItens].GetValue<string>('vencimento')))+ #39 + sLineBreak+
                'Declare @QtdCheckIn Integer = '+JsonArrayitens.Items[xItens].GetValue<Integer>('qtdcheckin').ToString()+sLineBreak +
                'Declare @QtdDevolvida Integer = ' + JsonArrayitens.Items[xItens].GetValue<Integer>('qtddevolvida').ToString() + sLineBreak +
                'Declare @QtdSegregada Integer = ' + JsonArrayitens.Items[xItens].GetValue<Integer>('qtdsegregada').ToString() + sLineBreak +
                'Declare @CausaId      Integer = ' + JsonArrayitens.Items[xItens].GetValue<Integer>('causaid').ToString() + sLineBreak +
                'Declare @Usuarioid Integer    = ' + JsonArrayitens.Items[xItens].GetValue<Integer>('usuarioid').ToString() + sLineBreak +
                'Declare @RespAltLoteId Integer = ' + JsonArrayitens.Items[xItens].GetValue<Integer>('respaltloteid').ToString() + sLineBreak +
               'Declare @Terminal Varchar(50) = '+QuotedStr(JsonArrayitens.Items[xItens].GetValue<string>('terminal')) +#13 + #10;
        // Cadastrar Lote Novo
        vSql := vSql +
                'If @LoteId = 0' + sLineBreak +
                '   Set @LoteId = Coalesce((Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote), 0)'+sLineBreak;
        vSql := vSql +
                'If @LoteId = 0 Begin' + sLineBreak +
                '   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, (Select IdData From Rhema_Data Where Data = @Fabricacao), ' +sLineBreak+
                '                                    (Select IdData From Rhema_Data Where Data = @Vencimento), ' +sLineBreak+
                '                                   '+TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual+', NewId())'+sLineBreak+
                '   Set @LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)'+sLineBreak +
                'End;'+sLineBreak;
        vSql := vSql +
                'Insert Into PedidoItensCheckInAgrupamento Values (@AgrupamentoId, @LoteId, @UsuarioId, @QtdCheckIn, '+sLineBreak +
                '   @QtdDevolvida, @QtdSegregada, @CausaId, '+TuEvolutConst.SqlDataAtual + ','+TuEvolutConst.SqlHoraAtual +sLineBreak+
                '  , (Case When @RespAltLoteId = 0 then Null Else @RespAltLoteId End), NewId(), @Terminal)';
        Query.Sql.Add(vSql);
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('SalvarCheckinAgrupamento.Sql');
        Query.ExecSql;
      End;
      Query.connection.Commit;
      Result := TJsonObject.Create;
      Result.AddPair('status', TJsonNumber.Create(200));
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: SalvarCheckInItemAgrupamento - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.ValidarCheckInAgrupamentoFinalizar(
  pAgrupamentoId: integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlValidarCheckInAgrupamentoFinalizar);
      Query.ParamByname('pAgrupamentoId').Value := pAgrupamentoId;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('ValidarCheckInAgrupamentoFinalizar.Sql');
      Query.Open;
      If Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJsonArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ValidarCheckInAgrupamentoFinalizar - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceRecebimento.ValidarQtdCheckIn(pPedidoId, pCodProduto: Int64)
  : tJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('select Pl.CodProduto, Sum(QtdCheckIn+QtdDevolvida+QtdSegregada) QtdCheckIn');
      Query.Sql.Add('From PedidoItensCheckIn PI');
      Query.Sql.Add('Inner Join vProdutoLotes Pl On Pl.LoteId = PI.Loteid');
      Query.Sql.Add('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
      Query.Sql.Add('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
      Query.Sql.Add('where PedidoId = :pPedidoId and Pl.CodProduto = :pCodProduto');
      Query.Sql.Add('Group by CodProduto');
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ValidarQtdCheckIn.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := tJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except
      On E: Exception do
      Begin
        raise Exception.Create('Processo: ValidarQtdCheckIn - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
