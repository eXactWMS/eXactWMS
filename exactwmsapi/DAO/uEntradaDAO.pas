unit uEntradaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error, FireDAC.Stan.Option,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  ProdutoClass, LotesClass, MService.ProdutoDAO, EntradaClass,
  EntradaItensClass, uEntradaItensDAO, MService.EstoqueDAO, exactwmsservice.lib.utils,
  exactwmsservice.lib.connection, exactwmsservice.dao.base;

// Const SqlDataAtual = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';
// Const SqlHoraAtual = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';
Const
  SqlEntrada = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
    'Declare @Pessoaid Integer = :pPessoaId' + sLineBreak +
    'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
    'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
    'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
    'Declare @Pendente Integer = :pPendente' + sLineBreak +
    'Declare @CodProduto Integer = :pCodProduto'+sLineBreak+
    'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid, P.CodPessoaERP, P.Razao, '
    + 'Ped.DocumentoNr, FORMAT(Rd.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as DocumentoData, Ped.RegistroERP ' + ', FORMAT(RE.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtInclusao, Rh.Hora as HrInclusao ' +
    ', ArmazemId, Ped.Status, De.ProcessoId, De.Descricao as Processo ' +
    'From pedido Ped ' +
    'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId ' +
    'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId ' +
    'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData ' +
    'Inner Join Rhema_Data RE On Re.IdData = Ped.DtInclusao ' +
    'Inner Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao ' + sLineBreak +
    'Inner Join vDocumentoEtapas De on De.Documento = Pv.uuid and '+sLineBreak+
    '                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento) '+sLineBreak+
    'Where (@PedidoId = 0 or Ped.PedidoId = @PedidoId) and Ped.OperacaoTipoId = 3 and '+ sLineBreak +
    '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and ' +sLineBreak +
    '      (@DocumentoNr = '+#39+#39+' or Ped.DocumentoNr = @DocumentoNr) and ' + sLineBreak +
    '      (@Razao = '+#39 + #39 + ' or P.Razao Like @Razao) and ' + sLineBreak +
    '      (@RegistroERP = ' + #39 + #39 + ' or Ped.RegistroERP = @RegistroERP)'+sLineBreak +
    '      --And De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'+sLineBreak +
    '      And (@Pendente = 0 or (De.ProcessoId in (1,4)))';

  // Retiraro o 5, ver se não gera impacto no retorno da integração

Const
  SqlEntradaItens =
    'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.ProdutoId, Prd.CodProduto CodigoERP, Pl.DescrLote'
    + #13 + #10 + ', FORMAT(DF.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as Fabricacao' + #13 + #10 + ', FORMAT(DV.Data, ' + #39 + 'dd/MM/yyyy' +
    #39 + ') as Vencimento  ' + #13 + #10 + ', FORMAT(RD.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtEntrada  ' + #13 + #10 +
    ', Rh.Hora HrEntrada, ' + #13 + #10 +
    'PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, PIt.QtdSegregada, ' + #13 +
    #10 + 'Prd.Descricao DescrProduto' + #13 + #10 + 'From PedidoItens PIt' +
    #13 + #10 + 'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + #13 +
    #10 + 'Inner join Produto Prd On Prd.IdProduto = Pl.ProdutoId' + #13 + #10 +
    ' Inner Join Rhema_Data DF On DF.IdData = Pl.Fabricacao ' + #13 + #10 +
    ' Inner Join Rhema_Data DV On DV.IdData = Pl.Vencimento ' + #13 + #10 +
    'Inner join Rhema_Data RD on Rd.IdData = Pl.DtEntrada' + #13 + #10 +
    'Inner Join Rhema_Hora RH on Rh.IdHora = Pl.HrEntrada' + #13 + #10 +
    'Where PedidoId = @pPedido';

type

  TEntradaDao = class(TBasicDao)
  private
    FEntrada: TEntrada;
    
    function AtualizarKardex(pQryKardex: TFdQuery;
      pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pEstoqueTipoIdDestino, pQuantidade, pEnderecoIdDestino,
      pUsuarioId: Integer; pObservacaoOrigem, pObservacaoDestino,
      pNomeEstacao: String; pEstoqueInicial: Integer): Boolean;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoId, pOperacaoTipoId, pPessoaId: Integer;
      pDocumentoNr: String; pDocumentoData: TDate; pArmazemId: Integer)
      : TjSonArray;
    Function Salvar: Boolean;
    function GetId(pPedidoId: Integer): TjSonArray;
    function GetDescricao(pPedidoId: Integer; pDocumento: String;
      pPessoaId: Integer): TjSonArray;
    function Pesquisar(pPedidoId, pPessoaId: Integer;
      pDocumento, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
      pPendente: Integer; pAgrupamentoId: Integer; pBasico: Boolean;
      pCodProduto : String = '0'): TjSonArray;
    Function GetEspelho(const AParams: TDictionary<string, string>): TjSonArray;
    Function Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
    Function Delete(pJsonPedidoDelete: TJsonObject): Boolean;
    Function GetEntrada(pEntradaId: Integer = 0; pPessoaId: Integer = 0;
      pDocumentoNr: String = ''; pShowErro: Integer = 1): TjSonArray;
    Property Entrada: TEntrada Read FEntrada Write FEntrada;
    Function SalvarCheckInItem(pJsonEntrada: TJsonObject): TJsonObject;
    Function FinalizarCheckIn(pJsonEntrada: TJsonObject): Boolean;
    Function MontarPaginacao: TJsonObject;
    Function Estrutura: TjSonArray;
    Function RegistrarDocumentoEtapa(pJsonDocumentoEtapa: TJsonObject) : TjSonArray;
    Function PlanilhaCega(pPedidoId: Integer): TjSonArray;
    Function GetMovimentacao(const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetRelRecebimento(pPedidoId: Integer; pDataIni, pDataFin, pDataFinalizacaoInicio, pDataFinalizacaoTermino : TDate;
      pCodigoERP, pPessoaId: Integer;
      pRazao, pDocumentoNr, pRegistroERP: String;
      pProcessoId, pCodProduto: Int64; pPedidoPendente: Integer): TjSonArray;
    Function GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP: Integer) : TjSonArray;
    Function GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer)       : TjSonArray;
    Function GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer)   : TjSonArray;
    Function GetAgrupamentoPedido(pAgrupamentoId, pPedidoId: Integer)    : TJSonArray;

  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TEntradaDao.Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Update DocumentoEtapas Set Status = 0'+sLineBreak+
              'Where Documento = (Select Uuid from Pedido '+sLineBreak+
              '                   Where Pedidoid = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString()+')'+sLineBreak+
              '  And ProcessoId = 15'+sLineBreak+
              'Update Pedido Set Status = 3 '+sLineBreak+
              'Where PedidoId = ' + pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString + sLineBreak +
              '  and OperacaoTipoId = 3' + sLineBreak +
              '   Insert Into DocumentoEtapas Values (' + sLineBreak +
              '     Cast((Select Uuid from Pedido Where Pedidoid = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString() +
                         ') as UNIQUEIDENTIFIER), ' + sLineBreak +
              '     15, '+pJsonPedidoCancelar.GetValue<Integer>('usuarioid').ToString() + ', ' +sLineBreak+
              '    '+TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual+', GetDate(), '+
              '    '+QuotedStr(pJsonPedidoCancelar.GetValue<String>('terminal')) + ', 1)';
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      begin
        raise Exception.Create('Processo: Recebimento(Cancelar) - '+TUtil.TratarExcessao(E.Message));
      end;
    end;
  Finally
    Query.Free;
  End;
end;

constructor TEntradaDao.Create;
begin
  Entrada := TEntrada.Create; // Desativado em 13/08/2023
  inherited;
end;

function TEntradaDao.Delete(pJsonPedidoDelete: TJsonObject): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Pedido where PedidoId = ' +
        Self.Entrada.EntradaId.ToString;
      Query.Close;
      Query.SQL.Clear;
      vSql := 'Update Pedido Set Status = 3 ' + #13 + #10 + 'where PedidoId = ' +
              Self.Entrada.EntradaId.ToString + ' and OperacaoTipoId = 3' + sLineBreak +
              'Insert Into DocumentoEtapas Values ' + sLineBreak +
              '       ( Cast((Select Uuid from Pedido Where Pedidoid = ' + Self.Entrada.EntradaId.ToString() + ') as UNIQUEIDENTIFIER), ' + sLineBreak +
              '       15, ' + pJsonPedidoDelete.GetValue<Integer>('usuarioid').ToString() + ', ' + TuEvolutConst.SqlDataAtual + ', ' + sLineBreak+
              TuEvolutConst.SqlHoraAtual + ', GetDate(), ' + QuotedStr(pJsonPedidoDelete.GetValue<String>('terminal')) + ', 1)';
      Query.SQL.Add(vSql);
      Query.ExecSQL;
      Result := True;
    Except On E: Exception do
      begin
        raise Exception.Create('Processo: Recebimento/delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TEntradaDao.Destroy;
begin
  FEntrada.Free;
  inherited;
end;

function TEntradaDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('Pedido') +sLineBreak+
               ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do Begin
        vRegEstrutura := TJsonObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.FinalizarCheckIn(pJsonEntrada: TJsonObject): Boolean;
Var
  jsonEntradaItem: TJsonObject;
  jsonArrayItens: TjSonArray;
  xItens: Integer;
  vQry, vQryItens, vQryKardex: TFdQuery;
  vSql: String;
  EntradaId, EntradaItemId, ProdutoId, LoteId: Integer;
  DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada: String;
  QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada: Integer;
  ObjEstoqueDAO: TEstoqueDAO;
  FIndexConneXactWMS: Integer;
  vEnderecoIdStage: Integer;
  vEstoqueInicial: Integer;
begin
  Result := False;
  Try
    vQry       := TFdQuery.Create(Nil);
    vQryItens  := TFdQuery.Create(Nil);
    vQryKardex := TFdQuery.Create(Nil);
    Try
      vQry.Connection       := Connection;
      vQryKardex.Connection := Connection;
      vQryItens.Connection  := Connection;
      vQry.connection.StartTransaction;
      EntradaId := pJsonEntrada.GetValue<Integer>('pedido');
      vQryItens.SQL.Add('select PI.*, Rd.Data, Rh.hora ');
      vQryItens.SQL.Add('From PedidoItensCheckIn PI');
      vQryItens.SQL.Add('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
      vQryItens.SQL.Add('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
      vQryItens.SQL.Add('Where PedidoId = ' + EntradaId.ToString());
      vQryItens.Open;
      jsonArrayItens := TjSonArray.Create;
      jsonArrayItens := pJsonEntrada.Get('itens').JsonValue as TjSonArray;
      vQryItens.First;
      while Not vQryItens.Eof do Begin
        LoteId := vQryItens.FieldByName('LoteId').AsInteger;
        vQry.Close;
        vQry.SQL.Clear;
        vQry.SQL.Add('select LoteId, ');
        vQry.SQL.Add('       (Case When RastroId = 3 then (Select EnderecoIdStageSNGPC From Configuracao)');
        vQry.SQL.Add('	         Else (Select EnderecoIdStage From Configuracao) End) EnderecoIdStage');
        vQry.SQL.Add('from vProdutoLotes');
        vQry.SQL.Add('where LoteId = :pLoteId');
        vQry.ParamByname('pLoteId').Value := LoteId;
        vQry.Open();
        vEnderecoIdStage := vQry.FieldByName('EnderecoIdStage').AsInteger;
        // Pegar Saldo inicial do Lote
        vQry.Close;
        vQry.SQL.Clear;
        vQry.SQL.Add('select Qtde From Estoque');
        vQry.SQL.Add('Where LoteId = ' + LoteId.ToString());
        vQry.SQL.Add('  And EnderecoId = ' + vEnderecoIdStage.ToString());
        vQry.SQL.Add('  And EstoqueTipoId = 1');
        vQry.Open;
        vEstoqueInicial := vQry.FieldByName('Qtde').AsInteger;
        vQry.Close;
        vQry.SQL.Clear;
        jsonEntradaItem := jsonArrayItens.Items[xItens] as TJsonObject;
        EntradaItemId := 0;
        ProdutoId := 0;
        // LoteId        := vQryItens.FieldByName('LoteId').AsInteger;
        DescrLote  := '';
        Fabricacao := '0';
        Vencimento := '0';
        DtEntrada  := '0';
        HrEntrada  := '0';
        QtdXml := vQryItens.FieldByName('QtdXml').AsInteger;
        QtdCheckIn := vQryItens.FieldByName('QtdCheckIn').AsInteger;
        QtdDevolvida := vQryItens.FieldByName('QtdDevolvida').AsInteger;
        QtdSegregada := vQryItens.FieldByName('QtdSegregada').AsInteger;
        // Salvar no banco
        vSql := 'Declare @EntradaId Integer       = '+EntradaId.ToString()+sLineBreak +
                'Declare @LoteId Integer          = '+LoteId.ToString + sLineBreak+
                'Declare @QtdXml     Integer      = '+QtdXml.ToString() + sLineBreak +
                'Declare @QtdCheckIn Integer      = '+QtdCheckIn.ToString() + sLineBreak +
                'Declare @QtdDevolvida Integer    = '+QtdDevolvida.ToString()+sLineBreak +
                'Declare @QtdSegregada Integer    = '+QtdSegregada.ToString() + sLineBreak +
                'Declare @EnderecoIdStage Integer = '+vEnderecoIdStage.ToString();
        vSql := vSql+
                'If Exists (Select LoteId From Estoque Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage) Begin'+sLineBreak +
                '   Update Estoque Set Qtde = Qtde + @QtdCheckIn Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage'+sLineBreak +
                'End' + sLineBreak +
                'Else Begin' + sLineBreak +
                '   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) '+sLineBreak +
                '          Values (@LoteId, @EnderecoIdStage, 1, @QtdCheckIn, '+sLineBreak +
                '                (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+sLineBreak +
                '                        (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) )'+sLineBreak +
                'End;';
        vSql := vSql +
                'If @QtdSegregada > 0 Begin' + sLineBreak +
                '	  If Exists (Select LoteId From Estoque Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)) Begin'+sLineBreak +
                '	     Update Estoque Set Qtde = Qtde + @QtdSegregada '+
                '      Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)'+sLineBreak +
                '	  End' + sLineBreak +
                '   Else Begin' + sLineBreak +
                '      Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) Values (@LoteId, (Select EnderecoSegregadoId From Configuracao), 3, @QtdSegregada,'+sLineBreak +
                '						    	(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak +
                '						    	(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) )'+sLineBreak +
                '   End;' + sLineBreak +
                'End;';
        vQry.SQL.Add(vSql);
        if DebugHook <> 0 then
           vQry.SQL.SaveToFile('FinalizarCheckIn_AtEstoque'+LoteId.ToString+ '.Sql');
        vQry.ExecSQL;
        AtualizarKardex(vQryKardex, 3, LoteId, vEnderecoIdStage, 1, 1, QtdCheckIn, 1, jsonEntradaItem.GetValue<Integer>('usuarioid', 0),
                       'Recebimento Pedido: ' + EntradaId.ToString(), 'Stage - Área de Armazenagem(Espera)', jsonEntradaItem.GetValue<String>('nomeestacao', ''), vEstoqueInicial);
        vQryItens.Next;
      End;
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add('Update Pedido Set Status = 2 where pedidoid = '+EntradaId.ToString());
      vQry.ExecSQL;
      Result := True;
      vQry.connection.Commit;
    Except On E: Exception do
      Begin
        vQry.connection.Rollback;
        Result := False;
        raise Exception.Create('Processo: Recebimento/finalizarcheckin -' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQry.Free;
    vQryItens.Free;
    vQryKardex.Free;
  End;
end;

function TEntradaDao.GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer)
  : TjSonArray;
begin

end;

function TEntradaDao.GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer)
  : TjSonArray;
begin

end;

function TEntradaDao.GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP: Integer)
  : TjSonArray;
begin

end;

function TEntradaDao.GetAgrupamentoPedido(pAgrupamentoId, pPedidoId: Integer)
  : TjSonArray;
begin

end;

function TEntradaDao.GetDescricao(pPedidoId: Integer; pDocumento: String;
  pPessoaId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := vSql + SqlEntrada;
      Query.SQL.Add(SqlEntrada);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value := pDocumento;
      Query.ParamByName('pRazao').Value := '';
      Query.ParamByName('pRegistroERP').Value := '';
      Query.ParamByName('pPendente').Value := 0;
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.toJsonArray;
    Except On E: Exception do
        raise Exception.Create('Processo: Recebimento/getdescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.GetEntrada(pEntradaId, pPessoaId: Integer;
  pDocumentoNr: String; pShowErro: Integer): TjSonArray;
begin
  //
end;

function TEntradaDao.GetEspelho(const AParams: TDictionary<string, string>) : TjSonArray;
Var vParams, pPedidoId, pDivergencia: Integer;
    pDocumentoNr, pRegistroERP: String;
    pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckInDtFin: TDate;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    vParams := 0;
    pPedidoId := 0;
    pDocumentoNr := '';
    pRegistroERP := '';
    pDoctoDataIni := 0;
    pDoctoDataFin := 0;
    pCheckInDtIni := 0;
    pCheckInDtFin := 0;
    pDivergencia := 0;
    if AParams.ContainsKey('pedidoid') then Begin
       pPedidoId := AParams.Items['pedidoid'].ToInt64;
       Inc(vParams);
    End;
    if AParams.ContainsKey('documentonr') then Begin
       pDocumentoNr := AParams.Items['documentonr'];
       Inc(vParams);
    End;
    if AParams.ContainsKey('registroerp') then Begin
       pRegistroERP := AParams.Items['registroerp'];
       Inc(vParams);
    End;
    if AParams.ContainsKey('doctodataini') then Begin
       pDoctoDataIni := StrToDate(AParams.Items['doctodataini']);
       Inc(vParams);
    End;
    if AParams.ContainsKey('doctodatafin') then Begin
       pDoctoDataFin := StrToDate(AParams.Items['doctodatafin']);
       Inc(vParams);
    End;
    if AParams.ContainsKey('checkindtini') then Begin
       pCheckInDtIni := StrToDate(AParams.Items['checkindtini']);
       Inc(vParams);
    End;
    if AParams.ContainsKey('checkindtfin') then Begin
       pCheckInDtFin := StrToDate(AParams.Items['checkindtfin']);
       Inc(vParams);
    End;
    if AParams.ContainsKey('divergencia') then Begin
       pDivergencia := AParams.Items['divergencia'].ToInteger;
       Inc(vParams);
    End;
    if vParams <= 0 then Begin
       Result := TjSonArray.Create();
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Parâmetros das pesquisa não definidos.'));
       Exit;
    End;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetEspelhoEntrada);
      Query.ParamByname('ppedidoid').Value := pPedidoId;
      Query.ParamByname('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByname('pRegistroERP').Value := pRegistroERP;
      if pDoctoDataIni = 0 then
         Query.ParamByname('pDoctoDataIni').Value := pDoctoDataIni
      Else
         Query.ParamByname('pDoctoDataIni').Value := FormatDateTime('YYYY-MM-DD', pDoctoDataIni);
      if pDoctoDataFin = 0 then
         Query.ParamByname('pDoctoDataFin').Value := pDoctoDataFin
      Else
         Query.ParamByname('pDoctoDataFin').Value := FormatDateTime('YYYY-MM-DD', pDoctoDataFin);
      if pCheckInDtIni = 0 then
         Query.ParamByname('pCheckInDtIni').Value := pCheckInDtIni
      Else
         Query.ParamByname('pCheckInDtIni').Value := FormatDateTime('YYYY-MM-DD', pCheckInDtIni);
      if pCheckInDtFin = 0 then
         Query.ParamByname('pCheckInDtFin').Value := pCheckInDtFin
      Else
         Query.ParamByname('pCheckInDtFin').Value := FormatDateTime('YYYY-MM-DD', pCheckInDtFin);
      Query.ParamByname('pDivergencia').Value := pDivergencia;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('Espelho.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.toJsonArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/espelho - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.GetId(pPedidoId: Integer): TjSonArray;
var
  vQry, vQryItens: TFdQuery;
  vSql, vSqlItens: String;
  ObjJson: TJsonObject;
  ObjEntradaItens: TEntradaItens;
  ObjEntradaItensDAO: TEntradaItensDAO;
  ObjProdutoDAO: TProdutoDAO;
  ObjLote: TLote;
  vItens, vProdutoId: Integer;
  EntradaItensDAO: TjSonArray;
begin
  vQry      := TFDQuery.Create(nil);
  vQryItens := TFDQuery.Create(nil);
  Try
    Result := TjSonArray.Create;
    vQry.Connection      := Connection;
    vQryItens.Connection := Connection;
    try
      vSql := SqlEntrada;
      vQry.SQL.Add(SqlEntrada);
      vQry.ParamByname('pPedidoId').Value := pPedidoId;
      vQry.ParamByname('pPessoaId').Value := 0;
      vQry.ParamByname('pDocumentoNr').Value := '';
      vQry.ParamByname('pRazao').Value := '';
      vQry.ParamByname('pRegistroERP').Value := '';
      vQry.ParamByname('pPendente').Value := 0;
      if pPedidoId = 0 then
         vQry.ParamByname('pPendente').Value := 1;
      vQry.Open();
      // VQry.Open(vSql);
      while Not vQry.Eof do Begin
        Entrada.EntradaId := vQry.FieldByName('PedidoId').AsInteger;
        Entrada.OperacaoTipo.OperacaoTipoId := vQry.FieldByName('OperacaoTipoId').AsInteger;
        Entrada.OperacaoTipo.Descricao := vQry.FieldByName('OperacaoTipo').AsString;
        Entrada.Pessoa.PessoaId := vQry.FieldByName('PessoaId').AsInteger;
        Entrada.Pessoa.Razao := vQry.FieldByName('Razao').AsString;
        Entrada.DocumentoNr := vQry.FieldByName('DocumentoNr').AsString;
        Entrada.DocumentoData := vQry.FieldByName('DocumentoData').AsDateTime;
        Entrada.DtInclusao := vQry.FieldByName('DtInclusao').AsDateTime;
        Entrada.HrInclusao := vQry.FieldByName('HrInclusao').AsDateTime;
        Entrada.ArmazemId := vQry.FieldByName('ArmazemId').AsInteger;
        Entrada.Status := vQry.FieldByName('Status').AsInteger;
        Entrada.ProcessoId := vQry.FieldByName('ProcessoId').AsInteger;
        Entrada.Processo := vQry.FieldByName('Processo').AsString;
        vSqlItens := 'Declare @pPedido Integer = ' + vQry.FieldByName('PedidoId').AsString + SqlEntradaItens;
        vQryItens.Open(vSqlItens);
        ObjEntradaItensDAO := TEntradaItensDAO.Create;
        try
        EntradaItensDAO := ObjEntradaItensDAO.GetEntradaItens(vQryItens.FieldByName('PedidoId').AsInteger);
        for vItens := 0 to EntradaItensDAO.Count - 1 do Begin
          ObjEntradaItens := ObjEntradaItens.JsonToClass(EntradaItensDAO.Items[vItens].ToString());
          Entrada.Itens.Add(ObjEntradaItens);
        End;
        finally
          FreeAndNil(ObjEntradaItensDAO)
        end;
        Result.AddElement(tJson.ObjectToJsonObject(Entrada, [joDateFormatISO8601]));
        vQry.Next;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/getid - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQry.Free;
    vQryItens.Free;
  End;
end;

function TEntradaDao.GetMovimentacao(const AParams: TDictionary<string, string>) : TjSonArray;
Var vParams, pPedidoId, pProdutoId: Integer;
    pDoctoDataIni, pDoctoDataFin: TDate;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    vParams := 0;
    pPedidoId := 0;
    pDoctoDataIni := 0;
    pDoctoDataFin := 0;
    pProdutoId := 0;
    if AParams.ContainsKey('pedidoid') then Begin
       pPedidoId := AParams.Items['pedidoid'].ToInt64;
       Inc(vParams);
    End;
    if AParams.ContainsKey('datainicial') then Begin
       pDoctoDataIni := StrToDate(AParams.Items['datainicial']);
       Inc(vParams);
    End;
    if AParams.ContainsKey('datafinal') then Begin
       pDoctoDataFin := StrToDate(AParams.Items['datafinal']);
       Inc(vParams);
    End;
    if AParams.ContainsKey('produtoid') then Begin
       pProdutoId := StrToIntDef(AParams.Items['produtoid'], 0);
       Inc(vParams);
    End;
    if vParams <= 0 then Begin
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Parâmetros das pesquisa não definidos.'));
       Exit;
    End;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetMovimentacaoRecebimento);
      Query.ParamByname('ppedidoid').Value := pPedidoId;
      if pDoctoDataIni = 0 then
         Query.ParamByname('pDataInicial').Value := pDoctoDataIni
      Else
         Query.ParamByname('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDoctoDataIni);
      if pDoctoDataFin = 0 then
         Query.ParamByname('pDataFinal').Value := pDoctoDataFin
      Else
         Query.ParamByname('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', pDoctoDataFin);
      Query.ParamByname('pProdutoId').Value := pProdutoId;
      If DebugHook <> 0 Then
         Query.SQL.SaveToFile('MovimentacaoRecebimentos.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.toJsonArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/movimentacao - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.GetRelRecebimento(pPedidoId: Integer;
  pDataIni, pDataFin, pDataFinalizacaoInicio, pDataFinalizacaoTermino : TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr, pRegistroERP: String; pProcessoId, pCodProduto: Int64;
  pPedidoPendente: Integer): TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
//--https://imasters.com.br/sql-server/sql-principais-funcoes-internas-do-sql-server-parte-ii
//Tratamento de Data e Hora
    try
      Query.SQL.Add(TuEvolutConst.SqlRelRecebimento);
      Query.ParamByname('pPedidoId').Value   := pPedidoId;
      if pDataIni = 0 then
         Query.ParamByname('pDataIni').Value := pDataIni
      Else
         Query.ParamByname('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
      if pDataFin = 0 then
         Query.ParamByname('pDataFin').Value := pDataFin
      Else
         Query.ParamByname('pDataFin').Value                := FormatDateTime('YYYY-MM-DD', pDataFin);;
      if pDataFinalizacaoInicio = 0 then
         Query.ParamByname('pDataFinalizacaoInicio').Value  := pDataFinalizacaoInicio
      Else
         Query.ParamByname('pDataFinalizacaoInicio').Value  := FormatDateTime('YYYY-MM-DD', pDataFinalizacaoInicio);
      if pDataFinalizacaoTermino = 0 then
         Query.ParamByname('pDataFinalizacaoTermino').Value := pDataFinalizacaoTermino
      Else
         Query.ParamByname('pDataFinalizacaoTermino').Value := FormatDateTime('YYYY-MM-DD', pDataFinalizacaoTermino);;
      Query.ParamByname('pCodigoERP').Value      := pCodigoERP;
      Query.ParamByname('pPessoaId').Value       := pPessoaId;
      Query.ParamByname('pDocumentoNr').Value    := pDocumentoNr;
      Query.ParamByname('pRazao').Value          := '%' + pRazao + '%';
      Query.ParamByname('pRegistroERP').Value    := pRegistroERP;
      Query.ParamByname('pProcessoId').Value     := pProcessoId;
      Query.ParamByname('pCodProduto').Value     := pCodProduto;
      Query.ParamByname('pPedidoPendente').Value := pPedidoPendente;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('RelRecebimento.Sql');
      Query.ParamByname('pOperacaoTipoId').Value := 3;
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.toJsonArray();
    Except On E: Exception do Begin
        Raise Exception.Create('Processo: Recebimento/relrecebimento - '+TUtil.TratarExcessao(E.Message))
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.Pesquisar(pPedidoId, pPessoaId: Integer;
  pDocumento, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
  pPendente: Integer; pAgrupamentoId: Integer; pBasico: Boolean;
  pCodProduto : String = '0'): TjSonArray;
var
  vQry, vQryItens: TFdQuery;
  vSql, vSqlItens: String;
  ObjJson: TJsonObject;
  ObjEntradaItens: TEntradaItens;
  ObjEntradaItensDAO: TEntradaItensDAO;
  ObjProdutoDAO: TProdutoDAO;
  ObjLote: TLote;
  vItens, vProdutoId: Integer;
  EntradaItensDAO: TjSonArray;
begin
  vQry      := TFdQuery.Create(Nil);
  vQryItens := TFdQuery.Create(Nil);
  Try
    vQry.Connection      := Connection;
    vQryItens.Connection := Connection;
    Try
      Result := TjSonArray.Create;
      vQry.ResourceOptions.CmdExecTimeout := 30000 * 5;
      vQryItens.ResourceOptions.CmdExecTimeout := 30000 * 5;
      vQry.SQL.Add(SqlEntrada);
      vQry.ParamByname('pPedidoId').Value := pPedidoId;
      vQry.ParamByname('pPessoaId').Value := pPessoaId;
      vQry.ParamByname('pDocumentoNr').Value := pDocumento;
      vQry.ParamByname('pRazao').Value := '%' + pRazao + '%';
      vQry.ParamByname('pRegistroERP').Value := pRegistroERP;
      if pDtNotaFiscal = 0 then
        vQry.ParamByname('pDtNotaFiscal').Value := 0
      Else
        vQry.ParamByname('pDtNotaFiscal').Value := pDtNotaFiscal;
      vQry.ParamByName('pCodProduto').Value     := pCodProduto;
      if DebugHook <> 0 then
         vQry.SQL.SaveToFile('EntradaPesquisar.Sql');
      vQry.Open;
      if vQry.IsEmpty then
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados))
      Else if pBasico then
        Result := vQry.toJsonArray
      Else
        while Not vQry.Eof do
        Begin
          Entrada.EntradaId := vQry.FieldByName('PedidoId').AsInteger;
          Entrada.OperacaoTipo.OperacaoTipoId :=
            vQry.FieldByName('OperacaoTipoId').AsInteger;
          Entrada.OperacaoTipo.Descricao :=
            vQry.FieldByName('OperacaoTipo').AsString;
          Entrada.Pessoa.PessoaId := vQry.FieldByName('PessoaId').AsInteger;
          Entrada.Pessoa.CodPessoa := vQry.FieldByName('CodPessoaERP').AsInteger;
          Entrada.Pessoa.Razao := vQry.FieldByName('Razao').AsString;
          Entrada.DocumentoNr := vQry.FieldByName('DocumentoNr').AsString;
          Entrada.DocumentoData := vQry.FieldByName('DocumentoData').AsDateTime;
          Entrada.RegistroERP := vQry.FieldByName('RegistroERP').AsString;
          Entrada.DtInclusao := vQry.FieldByName('DtInclusao').AsDateTime;
          Entrada.HrInclusao := vQry.FieldByName('HrInclusao').AsDateTime;
          Entrada.ArmazemId := vQry.FieldByName('ArmazemId').AsInteger;
          Entrada.Status := vQry.FieldByName('Status').AsInteger;
          Entrada.ProcessoId := vQry.FieldByName('ProcessoId').AsInteger;
          Entrada.Processo := vQry.FieldByName('Processo').AsString;
          vSqlItens := 'Declare @pPedido Integer = ' +
            vQry.FieldByName('PedidoId').AsString + SqlEntradaItens;
          vQryItens.Open(vSqlItens);
          if Not vQryItens.IsEmpty then
          Begin
            ObjEntradaItensDAO := TEntradaItensDAO.Create;
            Try
              EntradaItensDAO := ObjEntradaItensDAO.GetEntradaItens
                (vQryItens.FieldByName('PedidoId').AsInteger);
            Except
              On E: Exception do
              Begin
                vQry.Close;
                vQryItens.Close;
                raise Exception.Create('Ocorreu um erro de acesso ao servidor.');
              End;
            End;
            for vItens := 0 to EntradaItensDAO.Count - 1 do
            Begin
              // ObjEntradaItens := ObjEntradaItens.JsonToClass(EntradaItensDAO.Items[vItens].ToString());
              try
                ObjEntradaItens := TEntradaItens.Create;
              Except
                On E: Exception do
                Begin
                  vQry.Close;
                  vQryItens.Close;
                  raise Exception.Create('Erro Criando transf objeto item nr ' +
                    vItens.ToString);
                End;
              end;
              try
                ObjEntradaItens.EntradaId := EntradaItensDAO.Items[vItens]
                  .GetValue<Integer>('entradaId');
                ObjEntradaItens.EntradaItemId := EntradaItensDAO.Items[vItens]
                  .GetValue<Integer>('entradaItemId');
                ObjEntradaItens.ProdutoLotes.Produto :=
                  TProduto.JsonToClass(EntradaItensDAO.Items[vItens]
                  .GetValue<TJsonObject>('produtoLotes').GetValue<TJsonObject>
                  ('produto').ToString());
                ObjEntradaItens.ProdutoLotes.Lotes :=
                  TLote.JsonToClass(EntradaItensDAO.Items[vItens]
                  .GetValue<TJsonObject>('produtoLotes').GetValue<TJsonObject>
                  ('lotes').ToString());
                ObjEntradaItens.QtdXml := EntradaItensDAO.Items[vItens]
                  .GetValue<Integer>('qtdXml');
                ObjEntradaItens.QtdCheckIn := EntradaItensDAO.Items[vItens]
                  .GetValue<Integer>('qtdCheckIn');
                ObjEntradaItens.QtdDevolvida := EntradaItensDAO.Items[vItens]
                  .GetValue<Integer>('qtdDevolvida');
                ObjEntradaItens.QtdSegregada := EntradaItensDAO.Items[vItens]
                  .GetValue<Integer>('qtdSegregada');
              Except
                On E: Exception do
                Begin
                  raise Exception.Create('Erro transf objeto item nr ' +
                    vItens.ToString);
                End;
              end;
              Entrada.Itens.Add(ObjEntradaItens);
            End;
          End;
          Result.AddElement(tJson.ObjectToJsonObject(Entrada,
            [joDateFormatISO8601]));
          vQry.Next;
        End;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/pesquisar - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQry.Free;
    vQryItens.Free;
  End;
end;

function TEntradaDao.PlanilhaCega(pPedidoId: Integer): TjSonArray;
var
  vQry, vQryCodBarras: TFdQuery;
  jsonItens, JsonCodBarras: TJsonObject;
begin
  vQry          := TFdQuery.Create(Nil);
  vQryCodBarras := TFdQuery.Create(Nil);
  Try
    Result := TjSonArray.Create;
    vQry.Connection          := Connection;
    vQryCodBarras.Connection := Connection;
    vQry.SQL.Add(TuEvolutConst.SqlConsPlanilhaCega);
    vQry.ParamByname('pPedidoId').Value := pPedidoId;
    vQry.Open;
    If vQry.IsEmpty then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
    Else
      While Not vQry.Eof do Begin
        jsonItens := TJsonObject.Create;
        jsonItens.AddPair('produtoid', TJsonNumber.Create(vQry.FieldByName('ProdutoId').AsInteger));
        jsonItens.AddPair('codigoerp', TJsonNumber.Create(vQry.FieldByName('CodigoERP').AsInteger));
        jsonItens.AddPair('descrproduto', vQry.FieldByName('DescrProduto').AsString);
        jsonItens.AddPair('endereco', vQry.FieldByName('EnderecoDescricao').AsString);
        jsonItens.AddPair('embalagemprim', vQry.FieldByName('UnidadeSigla').AsString);
        jsonItens.AddPair('qtdunid', TJsonNumber.Create(vQry.FieldByName('QtdUnid').AsInteger));
        jsonItens.AddPair('embalagemsec', vQry.FieldByName('UnidadeSecundariaSigla').AsString);
        jsonItens.AddPair('qtdsec', TJsonNumber.Create(vQry.FieldByName('QtdUnid').AsInteger * vQry.FieldByName('FatorConversao').AsInteger));
        jsonItens.AddPair('pesoliquido', TJsonNumber.Create(vQry.FieldByName('PesoLiquido').AsInteger));
        jsonItens.AddPair('altura', TJsonNumber.Create(vQry.FieldByName('Altura').AsInteger));
        jsonItens.AddPair('largura', TJsonNumber.Create(vQry.FieldByName('Largura').AsInteger));
        jsonItens.AddPair('comprimento', TJsonNumber.Create(vQry.FieldByName('Comprimento').AsInteger));
        jsonItens.AddPair('volume', TJsonNumber.Create(vQry.FieldByName('Volume').AsInteger));
        jsonItens.AddPair('descrlote', vQry.FieldByName('DescrLote').AsString);
        jsonItens.AddPair('fabricacao', vQry.FieldByName('Fabricacao').AsString);
        jsonItens.AddPair('vencimento', vQry.FieldByName('Vencimento').AsString);
        jsonItens.AddPair('dtentrada', vQry.FieldByName('DtEntrada').AsString);
        jsonItens.AddPair('hrentrada', vQry.FieldByName('HrEntrada').AsString);
        jsonItens.AddPair('qtdxml', TJsonNumber.Create(vQry.FieldByName('QtdXml').AsInteger));
        vQryCodBarras.Close;
        vQryCodBarras.SQL.Clear;
        vQryCodBarras.SQL.Add(TuEvolutConst.SqlProdutoEan);
        vQryCodBarras.ParamByname('pProdutoId').Value := vQry.FieldByName('ProdutoId').AsInteger;
        vQryCodBarras.ParamByname('pStatus').Value := 1;
        vQryCodBarras.Open();
        if Not vQryCodBarras.IsEmpty then Begin
          While Not vQryCodBarras.Eof do Begin
            JsonCodBarras := TJsonObject.Create;
            JsonCodBarras.AddPair('codbarrasid', TJsonNumber.Create(vQryCodBarras.FieldByName('CodBarrasId').AsInteger));
            JsonCodBarras.AddPair('produtoid', TJsonNumber.Create(vQryCodBarras.FieldByName('ProdutoId').AsInteger));
            JsonCodBarras.AddPair('codbarras', vQryCodBarras.FieldByName('CodBarras').AsString);
            JsonCodBarras.AddPair('unidadesembalagem', TJsonNumber.Create(vQryCodBarras.FieldByName('UnidadesEmbalagem').AsInteger));
            JsonCodBarras.AddPair('dtinclusao', vQryCodBarras.FieldByName('DtInclusao').AsString);
            JsonCodBarras.AddPair('hrinclusao', vQryCodBarras.FieldByName('HrInclusao').AsString);
            JsonCodBarras.AddPair('principal', TJsonNumber.Create(vQryCodBarras.FieldByName('Principal').AsInteger));
            JsonCodBarras.AddPair('status', TJsonNumber.Create(vQryCodBarras.FieldByName('Status').AsInteger));
            vQryCodBarras.Next;
          End;
          jsonItens.AddPair('codbarras', JsonCodBarras);
        End
        Else
        Begin
          JsonCodBarras := TJsonObject.Create;
          jsonItens.AddPair('codbarras', JsonCodBarras);
        End;
        Result.AddElement(jsonItens);
        vQry.Next;
      End;
  Finally
    vQry.Close;
    vQryCodBarras.Close;
  End;
end;

function TEntradaDao.RegistrarDocumentoEtapa(pJsonDocumentoEtapa: TJsonObject) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    try
      Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where ' + 'PedidoId = ' + pJsonDocumentoEtapa.GetValue<Integer>('pedidoid').ToString() + ')');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      Query.ParamByname('pProcessoId').Value := pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      Query.ParamByname('pUsuarioId').Value := pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      Query.ParamByname('pTerminal').Value := pJsonDocumentoEtapa.GetValue<String>('estacao');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Documento Registrado com sucesso!'));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Recebimento/registrardocumentoetapa - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.InsertUpdate(pPedidoId, pOperacaoTipoId,
  pPessoaId: Integer; pDocumentoNr: String; pDocumentoData: TDate;
  pArmazemId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pPedidoId = 0 then
         vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('+sLineBreak+
                 pOperacaoTipoId.ToString() + ', ' + pPessoaId.ToString() + ', ' + QuotedStr(pDocumentoNr) + ', ' +
                 '(select IdData From Rhema_Data where Data = ' + #39 + FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + '), ' +
                 TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', ' + pArmazemId.ToString()
      Else
         vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' + pOperacaoTipoId.ToString() +
                 '   , PessoaId      = ' + pPessoaId.ToString() + '   , DocumentoNr   = ' + QuotedStr(pDocumentoNr)+sLineBreak+
                 '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = ' + #39 + FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + ')' +
                 '   , DtInclusao    = ' + TuEvolutConst.SqlDataAtual +
                 '   , HrInclusao    = ' + TuEvolutConst.SqlHoraAtual +
                 '   , ArmazemId     = ' + pArmazemId.ToString() + ' where EntradaId = ' + pPedidoId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except ON E: Exception do
        raise Exception.Create('Processo: Recebimento/insetupdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TEntradaDao.MontarPaginacao: TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TJsonObject.Create;
    try
      Query.Open('Select Count(*) Paginacao From Pedido Where OperacaoTipoId = 3');
      Result.AddPair('paginacao', TJsonNumber.Create(Query.FieldByName('Paginacao').AsInteger));
    Except On E: Exception do
      Begin
        Result.AddPair('Erro', 'Processo: Recewbimento/montapagin - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    QUery.Free;
  End;
end;

function TEntradaDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.Entrada.EntradaId = 0 then
         vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('+sLineBreak+
                 Self.Entrada.OperacaoTipo.OperacaoTipoId.ToString() + ', ' + Self.Entrada.Pessoa.PessoaId.ToString() + ', ' +sLineBreak+
                 QuotedStr(Self.Entrada.DocumentoNr) + ', ' + '(select IdData From Rhema_Data where Data = ' + #39 + FormatDateTime('YYYY-MM-DD', Self.Entrada.DocumentoData) + #39 + '), ' +sLineBreak+
                 TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', ' + Self.Entrada.ArmazemId.ToString()
       Else
         vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' + Self.Entrada.OperacaoTipo.OperacaoTipoId.ToString() +sLineBreak+
                 '   , PessoaId      = ' + Self.Entrada.Pessoa.PessoaId.ToString()+sLineBreak+
                 '   , DocumentoNr   = ' + QuotedStr(Self.Entrada.DocumentoNr)+sLineBreak+
                 '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = ' + #39 + FormatDateTime('YYYY-MM-DD', Self.Entrada.DocumentoData) + #39 +')'+sLineBreak+
                 '   , DtInclusao    = ' + TuEvolutConst.SqlDataAtual +
                 '   , HrInclusao    = ' + TuEvolutConst.SqlHoraAtual +
                 '   , ArmazemId     = ' + Self.Entrada.ArmazemId.ToString() +
                 'Where EntradaId = ' + Self.Entrada.EntradaId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
        raise Exception.Create('Processo: Recebimento/salvar - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    QUery.Free;
  End;
end;

function TEntradaDao.SalvarCheckInItem(pJsonEntrada: TJsonObject): TJsonObject;
Var jsonEntradaItem: TJsonObject;
    jsonArrayItens: TjSonArray;
    xItens: Integer;
    vSql: String;
    EntradaId, EntradaItemId, ProdutoId, LoteId: Integer;
    DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada, vTerminal, vErro: String;
    QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada, UsuarioId, RespAltLoteId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      EntradaId := pJsonEntrada.GetValue<Integer>('pedido');
      jsonArrayItens := pJsonEntrada.Get('itens').JsonValue as TjSonArray;
      for xItens := 0 to jsonArrayItens.Count - 1 do Begin
        Query.Close;
        Query.SQL.Clear;
        jsonEntradaItem := jsonArrayItens.Items[xItens] as TJsonObject;
        EntradaItemId   := jsonEntradaItem.GetValue<Integer>('entradaitemid');
        ProdutoId       := jsonEntradaItem.GetValue<Integer>('produtoid');
        LoteId          := jsonEntradaItem.GetValue<Integer>('loteid');
        DescrLote       := jsonEntradaItem.GetValue<String>('descrlote');
        Fabricacao      := jsonEntradaItem.GetValue<string>('fabricacao');
        Vencimento      := jsonEntradaItem.GetValue<string>('vencimento');
        DtEntrada       := jsonEntradaItem.GetValue<string>('dtentrada');
        HrEntrada       := jsonEntradaItem.GetValue<string>('hrentrada');
        QtdXml          := jsonEntradaItem.GetValue<Integer>('qtdxml');
        QtdCheckIn      := jsonEntradaItem.GetValue<Integer>('qtdcheckin');
        QtdDevolvida    := jsonEntradaItem.GetValue<Integer>('qtddevolvida');
        QtdSegregada    := jsonEntradaItem.GetValue<Integer>('qtdsegregada');
        UsuarioId       := jsonEntradaItem.GetValue<Integer>('usuarioid');
        RespAltLoteId   := jsonEntradaItem.GetValue<Integer>('respaltloteid');
        if jsonEntradaItem.TryGetValue('terminal', vErro) then
           vTerminal := jsonEntradaItem.GetValue<String>('terminal')
        Else
           vTerminal := '';
         // Salvar no banco
        vSql := 'Declare @EntradaId Integer = ' + EntradaId.ToString() + sLineBreak +
                'Declare @EntradaItemId Integer = ' + EntradaItemId.ToString() + sLineBreak +
                'Declare @ProdutoId Integer     = ' + ProdutoId.ToString() + sLineBreak+
                'Declare @LoteId Integer = ' + LoteId.ToString + sLineBreak +
                'Declare @DescrLote VarChar(30) = ' + #39 + DescrLote + #39 + sLineBreak+
                'Declare @Fabricacao Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(Fabricacao)) + #39 + sLineBreak +
                'Declare @Vencimento Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(Vencimento)) + #39 + sLineBreak +
                'Declare @DtEntrada  Date = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(DtEntrada)) + #39 + sLineBreak +
                'Declare @HrEntrada  Time = ' + #39 + HrEntrada + #39 + sLineBreak +
                'Declare @QtdXml     Integer = ' + QtdXml.ToString() + sLineBreak +
                'Declare @QtdCheckIn Integer = ' + QtdCheckIn.ToString() + sLineBreak +
                'Declare @QtdDevolvida Integer = ' + QtdDevolvida.ToString() + sLineBreak +
                'Declare @QtdSegregada Integer = ' + QtdSegregada.ToString() + sLineBreak +
                'Declare @Usuarioid Integer    = ' + UsuarioId.ToString() + sLineBreak +
                'Declare @RespAltLoteId Integer = ' + RespAltLoteId.ToString() + sLineBreak +
                'Declare @Terminal Varchar(50) = ' + QuotedStr(vTerminal) + sLineBreak;
              // Cadastrar Lote Novo
        vSql := vSql + 'If @LoteId = 0' + sLineBreak +
                       '   Set @LoteId = Coalesce((Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote), 0)';
        vSql := vSql + 'If @LoteId = 0 Begin' + sLineBreak +
                       '   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, ' + sLineBreak +
                       '   (Select IdData From Rhema_Data Where Data = @Fabricacao), ' + sLineBreak +
                       '   (Select IdData From Rhema_Data Where Data = @Vencimento), ' + sLineBreak +
                       '   (Select IdData From Rhema_Data Where Data = @DtEntrada), ' + sLineBreak +
                       '   (Select IdHora From Rhema_Hora Where Hora = @HrEntrada), NewId())' + sLineBreak +
                       '   Set @LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)' + sLineBreak +
                       'End;' + #13 + #10;
        // Novo Lote não pertencente ao XML origiginal
        vSql := vSql + 'If ((@EntradaItemId = 0) or (Not Exists (Select PedidoItemId From PedidoItens where PedidoId = @EntradaId))) Begin' + sLineBreak +
                       '   Insert Into PedidoItens Values (@EntradaId, @LoteId, @QtdXml, @QtdCheckIn, @QtdDevolvida, @QtdSegregada, 0, newid())' + sLineBreak +
                       'End' + sLineBreak +
                       'Else Begin' + sLineBreak +
                       '   Update PedidoItens Set QtdCheckIn = QtdCheckIn+@QtdCheckIn, QtdDevolvida = QtdDevolvida+@QtdDevolvida, QtdSegregada = QtdSegregada+@QtdSegregada Where PedidoItemId = @EntradaItemId'+sLineBreak +
                       'End;' + sLineBreak + sLineBreak;
        vSql := vSql + 'Insert Into PedidoItensCheckIn Values (@EntradaId, @LoteId, @UsuarioId, @QtdXml, @QtdCheckIn, '+sLineBreak +
                       '   @QtdDevolvida, @QtdSegregada, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak +
                       '   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), (Case When @RespAltLoteId = 0 then Null Else @RespAltLoteId End), NewId(), @Terminal)';
         Query.SQL.Add(vSql);
         if DebugHook <> 0 then
            Query.SQL.SaveToFile('SalvarCheckin.Sql');
         Query.ExecSQL;
         FreeAndNil(jsonEntradaItem); //Observar se não estoura AC
      End;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Select PI.Pedidoitemid, PI.loteid, PI.qtdcheckin, PI.qtddevolvida, PI.qtdsegregada ');
      Query.SQL.Add('From PedidoItens PI');
      Query.SQL.Add('Inner Join ProdutoLotes PL ON Pl.LoteId = Pi.LoteId and Pl.ProdutoId = '+ProdutoId.ToString() + ' and Pl.DescrLote = ' + QuotedStr(DescrLote));
      Query.SQL.Add('Where Pi.pedidoid = ' + EntradaId.ToString());
      Query.Open();
      Result := TJsonObject.Create;
      With Result do Begin
        AddPair('pedidoitemid', TJsonNumber.Create(Query.FieldByName('PedidoItemId').AsInteger));
        AddPair('loteid', TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
        AddPair('qtdcheckin', TJsonNumber.Create(Query.FieldByName('QtdCheckIn').AsInteger));
        AddPair('qtddevolvida', TJsonNumber.Create(Query.FieldByName('QtdDevolvida').AsInteger));
        AddPair('qtdsegregada', TJsonNumber.Create(Query.FieldByName('QtdSegregada').AsInteger));
      End;
      Try FreeAndNil(jsonArrayItens); Except End;    //Observar se não estoura AC
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: Recebimento/salvarcheckinitem: ' + E.Message);
      End;
    End;
  Finally
    Query.Free;
  End;
end;

Function TEntradaDao.AtualizarKardex(pQryKardex: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String;
  pEstoqueInicial: Integer): Boolean;
begin
  //
  // Fconexao      := TConnection.create(0);
  Try
    pQryKardex.Close;
    pQryKardex.SQL.Clear;
    pQryKardex.SQL.Add(TuEvolutConst.SqlKardexInsUpd);
    pQryKardex.ParamByname('pOperacaoTipoId').Value       := pOperacaoTipoId;
    pQryKardex.ParamByname('pLoteId').Value               := pLoteId;
    pQryKardex.ParamByname('pEnderecoId').Value           := pEnderecoId;
    pQryKardex.ParamByname('pEstoqueTipoId').Value        := pEstoqueTipoId;
    pQryKardex.ParamByname('pEstoqueTipoIdDestino').Value := pEstoqueTipoIdDestino;
    pQryKardex.ParamByname('pQuantidade').Value           := pQuantidade;
    pQryKardex.ParamByname('pObservacaoOrigem').Value     := pObservacaoOrigem;
    pQryKardex.ParamByname('pEnderecoIdDestino').Value    := pEnderecoIdDestino;
    pQryKardex.ParamByname('pObservacaoDestino').Value    := pObservacaoDestino;
    pQryKardex.ParamByname('pUsuarioId').Value            := pUsuarioId;
    pQryKardex.ParamByname('pNomeEstacao').Value          := pNomeEstacao;
    pQryKardex.ParamByname('pEstoqueInicial').Value       := pEstoqueInicial;
    If DebugHook <> 0 then
       pQryKardex.SQL.SaveToFile('AtKardex.Sql');
    pQryKardex.ExecSQL;
    Result := True;
    pQryKardex.Close;
  Except ON E: Exception do
    Begin
      pQryKardex.Close;
      raise Exception.Create('Processo: Recebimento/atualizarkardex - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

end.
