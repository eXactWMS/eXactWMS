{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
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
var
  vSql: String;
begin
  Result := False;
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
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    begin
      raise Exception.Create('Tabela - Entrada(Cancelar): ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]','', [rfReplaceAll]));
    end;
  end;
end;

constructor TEntradaDao.Create;
begin
  Entrada := TEntrada.Create; // Desativado em 13/08/2023
  inherited;
end;

function TEntradaDao.Delete(pJsonPedidoDelete: TJsonObject): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Pedido where PedidoId = ' +
      Self.Entrada.EntradaId.ToString;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    vSql := 'Update Pedido Set Status = 3 ' + #13 + #10 + 'where PedidoId = ' +
      Self.Entrada.EntradaId.ToString + ' and OperacaoTipoId = 3' + sLineBreak +
      'Insert Into DocumentoEtapas Values ' + sLineBreak +
      ' ( Cast((Select Uuid from Pedido Where Pedidoid = ' +
      Self.Entrada.EntradaId.ToString() + ') as UNIQUEIDENTIFIER), ' +
      sLineBreak + '15, ' + pJsonPedidoDelete.GetValue<Integer>('usuarioid')
      .ToString() + ', ' + TuEvolutConst.SqlDataAtual + ', ' +
      TuEvolutConst.SqlHoraAtual + ', GetDate(), ' +
      QuotedStr(pJsonPedidoDelete.GetValue<String>('terminal')) + ', 1)';
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ExecSQL;
    Result := True;
  Except
    On E: Exception do
    begin
      raise Exception.Create('Tabela - Entrada(Excluir): ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TEntradaDao.Destroy;
begin
  FEntrada.Free;
  inherited;
end;

function TEntradaDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Pedido') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    While Not FConexao.Query.Eof do
    Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna',
        LowerCase(FConexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo', LowerCase(FConexao.Query.FieldByName('Tipo')
        .AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
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
    Try
      vQry := FConexao.GetQuery;
      vQry.connection.StartTransaction;
      EntradaId := pJsonEntrada.GetValue<Integer>('pedido');
      vQryKardex := FConexao.GetQuery;
      vQryItens := FConexao.GetQuery;
      vQryItens.SQL.Add('select PI.*, Rd.Data, Rh.hora ');
      vQryItens.SQL.Add('From PedidoItensCheckIn PI');
      vQryItens.SQL.Add
        ('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
      vQryItens.SQL.Add
        ('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
      vQryItens.SQL.Add('where PedidoId = ' + EntradaId.ToString());
      vQryItens.Open;
      jsonArrayItens := TjSonArray.Create;
      jsonArrayItens := pJsonEntrada.Get('itens').JsonValue as TjSonArray;
      // for xItens := 0 to jsonArrayItens.Count-1 do Begin
      vQryItens.First;
      while Not vQryItens.Eof do
      Begin
        LoteId := vQryItens.FieldByName('LoteId').AsInteger;
        vQry.Close;
        vQry.SQL.Clear;
        vQry.SQL.Add('select LoteId, ');
        vQry.SQL.Add
          ('       (Case When RastroId = 3 then (Select EnderecoIdStageSNGPC From Configuracao)');
        vQry.SQL.Add
          ('	         Else (Select EnderecoIdStage From Configuracao) End) EnderecoIdStage');
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
        DescrLote := '';
        Fabricacao := '0';
        Vencimento := '0';
        DtEntrada := '0';
        HrEntrada := '0';
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
        raise Exception.Create('Erro: ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQry.Close;
    vQryItens.Close;
    vQryKardex.Close;
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
var
  vSql: String;
begin
  try
    vSql := vSql + SqlEntrada;
    FConexao.Query.SQL.Add(SqlEntrada);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumento;
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pPendente').Value := 0;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TEntradaDao.GetEntrada(pEntradaId, pPessoaId: Integer;
  pDocumentoNr: String; pShowErro: Integer): TjSonArray;
begin
  //
end;

function TEntradaDao.GetEspelho(const AParams: TDictionary<string, string>)
  : TjSonArray;
Var
  vParams, pPedidoId, pDivergencia: Integer;
  pDocumentoNr, pRegistroERP: String;
  pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckInDtFin: TDate;
begin
  vParams := 0;
  pPedidoId := 0;
  pDocumentoNr := '';
  pRegistroERP := '';
  pDoctoDataIni := 0;
  pDoctoDataFin := 0;
  pCheckInDtIni := 0;
  pCheckInDtFin := 0;
  pDivergencia := 0;
  if AParams.ContainsKey('pedidoid') then
  Begin
    pPedidoId := AParams.Items['pedidoid'].ToInt64;
    Inc(vParams);
  End;
  if AParams.ContainsKey('documentonr') then
  Begin
    pDocumentoNr := AParams.Items['documentonr'];
    Inc(vParams);
  End;
  if AParams.ContainsKey('registroerp') then
  Begin
    pRegistroERP := AParams.Items['registroerp'];
    Inc(vParams);
  End;
  if AParams.ContainsKey('doctodataini') then
  Begin
    pDoctoDataIni := StrToDate(AParams.Items['doctodataini']);
    Inc(vParams);
  End;
  if AParams.ContainsKey('doctodatafin') then
  Begin
    pDoctoDataFin := StrToDate(AParams.Items['doctodatafin']);
    Inc(vParams);
  End;
  if AParams.ContainsKey('checkindtini') then
  Begin
    pCheckInDtIni := StrToDate(AParams.Items['checkindtini']);
    Inc(vParams);
  End;
  if AParams.ContainsKey('checkindtfin') then
  Begin
    pCheckInDtFin := StrToDate(AParams.Items['checkindtfin']);
    Inc(vParams);
  End;
  if AParams.ContainsKey('divergencia') then
  Begin
    pDivergencia := AParams.Items['divergencia'].ToInteger;
    Inc(vParams);
  End;
  if vParams <= 0 then
  Begin
    Result := TjSonArray.Create();
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Parâmetros das pesquisa não definidos.'));
    Exit;
  End;
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEspelhoEntrada);
    FConexao.Query.ParamByname('ppedidoid').Value := pPedidoId;
    FConexao.Query.ParamByname('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByname('pRegistroERP').Value := pRegistroERP;
    if pDoctoDataIni = 0 then
      FConexao.Query.ParamByname('pDoctoDataIni').Value := pDoctoDataIni
    Else
      FConexao.Query.ParamByname('pDoctoDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDoctoDataIni);
    if pDoctoDataFin = 0 then
      FConexao.Query.ParamByname('pDoctoDataFin').Value := pDoctoDataFin
    Else
      FConexao.Query.ParamByname('pDoctoDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDoctoDataFin);
    if pCheckInDtIni = 0 then
      FConexao.Query.ParamByname('pCheckInDtIni').Value := pCheckInDtIni
    Else
      FConexao.Query.ParamByname('pCheckInDtIni').Value :=
        FormatDateTime('YYYY-MM-DD', pCheckInDtIni);
    if pCheckInDtFin = 0 then
      FConexao.Query.ParamByname('pCheckInDtFin').Value := pCheckInDtFin
    Else
      FConexao.Query.ParamByname('pCheckInDtFin').Value :=
        FormatDateTime('YYYY-MM-DD', pCheckInDtFin);
    FConexao.Query.ParamByname('pDivergencia').Value := pDivergencia;
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('Espelho.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.toJsonArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
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
  Try
    Result := TjSonArray.Create;
    vQry := FConexao.GetQuery;
    vQryItens := FConexao.GetQuery;
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
      while Not vQry.Eof do
      Begin
        Entrada.EntradaId := vQry.FieldByName('PedidoId').AsInteger;
        Entrada.OperacaoTipo.OperacaoTipoId := vQry.FieldByName('OperacaoTipoId')
          .AsInteger;
        Entrada.OperacaoTipo.Descricao :=
          vQry.FieldByName('OperacaoTipo').AsString;
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
        vSqlItens := 'Declare @pPedido Integer = ' + vQry.FieldByName('PedidoId')
          .AsString + SqlEntradaItens;
        vQryItens.Open(vSqlItens);

        ObjEntradaItensDAO := TEntradaItensDAO.Create;
        try
        EntradaItensDAO := ObjEntradaItensDAO.GetEntradaItens
          (vQryItens.FieldByName('PedidoId').AsInteger);
        for vItens := 0 to EntradaItensDAO.Count - 1 do
        Begin
          ObjEntradaItens := ObjEntradaItens.JsonToClass
            (EntradaItensDAO.Items[vItens].ToString());
          Entrada.Itens.Add(ObjEntradaItens);
        End;
        finally
          FreeAndNil(ObjEntradaItensDAO)
        end;
        Result.AddElement(tJson.ObjectToJsonObject(Entrada,
          [joDateFormatISO8601]));
        vQry.Next;
      End;
    Except ON E: Exception do
      Begin
        vQry.Close;
        raise Exception.Create(TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQry.Close;
    vQryItens.Close;
  End;
end;

function TEntradaDao.GetMovimentacao(const AParams: TDictionary<string, string>) : TjSonArray;
Var vParams, pPedidoId, pProdutoId: Integer;
    pDoctoDataIni, pDoctoDataFin: TDate;
begin
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
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetMovimentacaoRecebimento);
    FConexao.Query.ParamByname('ppedidoid').Value := pPedidoId;
    if pDoctoDataIni = 0 then
      FConexao.Query.ParamByname('pDataInicial').Value := pDoctoDataIni
    Else
      FConexao.Query.ParamByname('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD', pDoctoDataIni);
    if pDoctoDataFin = 0 then
      FConexao.Query.ParamByname('pDataFinal').Value := pDoctoDataFin
    Else
      FConexao.Query.ParamByname('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', pDoctoDataFin);
    FConexao.Query.ParamByname('pProdutoId').Value := pProdutoId;
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('MovimentacaoRecebimentos.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.toJsonArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TEntradaDao.GetRelRecebimento(pPedidoId: Integer;
  pDataIni, pDataFin, pDataFinalizacaoInicio, pDataFinalizacaoTermino : TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr, pRegistroERP: String; pProcessoId, pCodProduto: Int64;
  pPedidoPendente: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
//--https://imasters.com.br/sql-server/sql-principais-funcoes-internas-do-sql-server-parte-ii
//Tratamento de Data e Hora
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelRecebimento);
    FConexao.Query.ParamByname('pPedidoId').Value   := pPedidoId;
    if pDataIni = 0 then
       FConexao.Query.ParamByname('pDataIni').Value := pDataIni
    Else
       FConexao.Query.ParamByname('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
       FConexao.Query.ParamByname('pDataFin').Value := pDataFin
    Else
       FConexao.Query.ParamByname('pDataFin').Value                := FormatDateTime('YYYY-MM-DD', pDataFin);;
    if pDataFinalizacaoInicio = 0 then
       FConexao.Query.ParamByname('pDataFinalizacaoInicio').Value  := pDataFinalizacaoInicio
    Else
       FConexao.Query.ParamByname('pDataFinalizacaoInicio').Value  := FormatDateTime('YYYY-MM-DD', pDataFinalizacaoInicio);
    if pDataFinalizacaoTermino = 0 then
       FConexao.Query.ParamByname('pDataFinalizacaoTermino').Value := pDataFinalizacaoTermino
    Else
       FConexao.Query.ParamByname('pDataFinalizacaoTermino').Value := FormatDateTime('YYYY-MM-DD', pDataFinalizacaoTermino);;
    FConexao.Query.ParamByname('pCodigoERP').Value      := pCodigoERP;
    FConexao.Query.ParamByname('pPessoaId').Value       := pPessoaId;
    FConexao.Query.ParamByname('pDocumentoNr').Value    := pDocumentoNr;
    FConexao.Query.ParamByname('pRazao').Value          := '%' + pRazao + '%';
    FConexao.Query.ParamByname('pRegistroERP').Value    := pRegistroERP;
    FConexao.Query.ParamByname('pProcessoId').Value     := pProcessoId;
    FConexao.Query.ParamByname('pCodProduto').Value     := pCodProduto;
    FConexao.Query.ParamByname('pPedidoPendente').Value := pPedidoPendente;
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('RelRecebimento.Sql');
    FConexao.Query.ParamByname('pOperacaoTipoId').Value := 3;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutConst.QrySemDados)));
    End
    Else
       Result := FConexao.Query.toJsonArray();
  Except On E: Exception do Begin
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
             StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))));
    End;
  end;
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
  Try
    Try
      Result := TjSonArray.Create;
      vQry := FConexao.GetQuery;
      vQry.ResourceOptions.CmdExecTimeout := 30000 * 5;
      vQryItens := FConexao.GetQuery;
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
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TUtil.TratarExcessao(E.Message)));
        raise Exception.Create(TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQry.Close;
    vQryItens.Close;
  End;
end;

function TEntradaDao.PlanilhaCega(pPedidoId: Integer): TjSonArray;
var
  vQry, vQryCodBarras: TFdQuery;
  jsonItens, JsonCodBarras: TJsonObject;
begin
  Try
    Result := TjSonArray.Create;
    vQry := FConexao.GetQuery;
    vQryCodBarras := FConexao.GetQuery;
    vQry.SQL.Add(TuEvolutConst.SqlConsPlanilhaCega);
    vQry.ParamByname('pPedidoId').Value := pPedidoId;
    vQry.Open;
    If vQry.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      While Not vQry.Eof do
      Begin
        jsonItens := TJsonObject.Create;
        jsonItens.AddPair('produtoid',
          TJsonNumber.Create(vQry.FieldByName('ProdutoId').AsInteger));
        jsonItens.AddPair('codigoerp',
          TJsonNumber.Create(vQry.FieldByName('CodigoERP').AsInteger));
        jsonItens.AddPair('descrproduto', vQry.FieldByName('DescrProduto')
          .AsString);
        jsonItens.AddPair('endereco', vQry.FieldByName('EnderecoDescricao')
          .AsString);
        jsonItens.AddPair('embalagemprim', vQry.FieldByName('UnidadeSigla')
          .AsString);
        jsonItens.AddPair('qtdunid',
          TJsonNumber.Create(vQry.FieldByName('QtdUnid').AsInteger));
        jsonItens.AddPair('embalagemsec',
          vQry.FieldByName('UnidadeSecundariaSigla').AsString);
        jsonItens.AddPair('qtdsec', TJsonNumber.Create(vQry.FieldByName('QtdUnid')
          .AsInteger * vQry.FieldByName('FatorConversao').AsInteger));
        jsonItens.AddPair('pesoliquido',
          TJsonNumber.Create(vQry.FieldByName('PesoLiquido').AsInteger));
        jsonItens.AddPair('altura', TJsonNumber.Create(vQry.FieldByName('Altura')
          .AsInteger));
        jsonItens.AddPair('largura',
          TJsonNumber.Create(vQry.FieldByName('Largura').AsInteger));
        jsonItens.AddPair('comprimento',
          TJsonNumber.Create(vQry.FieldByName('Comprimento').AsInteger));
        jsonItens.AddPair('volume', TJsonNumber.Create(vQry.FieldByName('Volume')
          .AsInteger));

        jsonItens.AddPair('descrlote', vQry.FieldByName('DescrLote').AsString);
        jsonItens.AddPair('fabricacao', vQry.FieldByName('Fabricacao').AsString);
        jsonItens.AddPair('vencimento', vQry.FieldByName('Vencimento').AsString);
        jsonItens.AddPair('dtentrada', vQry.FieldByName('DtEntrada').AsString);
        jsonItens.AddPair('hrentrada', vQry.FieldByName('HrEntrada').AsString);
        jsonItens.AddPair('qtdxml', TJsonNumber.Create(vQry.FieldByName('QtdXml')
          .AsInteger));
        vQryCodBarras.Close;
        vQryCodBarras.SQL.Clear;
        vQryCodBarras.SQL.Add(TuEvolutConst.SqlProdutoEan);
        vQryCodBarras.ParamByname('pProdutoId').Value :=
          vQry.FieldByName('ProdutoId').AsInteger;
        vQryCodBarras.ParamByname('pStatus').Value := 1;
        vQryCodBarras.Open();
        if Not vQryCodBarras.IsEmpty then
        Begin
          While Not vQryCodBarras.Eof do
          Begin
            JsonCodBarras := TJsonObject.Create;
            JsonCodBarras.AddPair('codbarrasid',
              TJsonNumber.Create(vQryCodBarras.FieldByName('CodBarrasId')
              .AsInteger));
            JsonCodBarras.AddPair('produtoid',
              TJsonNumber.Create(vQryCodBarras.FieldByName('ProdutoId')
              .AsInteger));
            JsonCodBarras.AddPair('codbarras',
              vQryCodBarras.FieldByName('CodBarras').AsString);
            JsonCodBarras.AddPair('unidadesembalagem',
              TJsonNumber.Create(vQryCodBarras.FieldByName('UnidadesEmbalagem')
              .AsInteger));
            JsonCodBarras.AddPair('dtinclusao',
              vQryCodBarras.FieldByName('DtInclusao').AsString);
            JsonCodBarras.AddPair('hrinclusao',
              vQryCodBarras.FieldByName('HrInclusao').AsString);
            JsonCodBarras.AddPair('principal',
              TJsonNumber.Create(vQryCodBarras.FieldByName('Principal')
              .AsInteger));
            JsonCodBarras.AddPair('status',
              TJsonNumber.Create(vQryCodBarras.FieldByName('Status').AsInteger));
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

function TEntradaDao.RegistrarDocumentoEtapa(pJsonDocumentoEtapa: TJsonObject)
  : TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where ' +
      'PedidoId = ' + pJsonDocumentoEtapa.GetValue<Integer>('pedidoid')
      .ToString() + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    FConexao.Query.ParamByname('pProcessoId').Value :=
      pJsonDocumentoEtapa.GetValue<Integer>('processoid');
    FConexao.Query.ParamByname('pUsuarioId').Value :=
      pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
    FConexao.Query.ParamByname('pTerminal').Value :=
      pJsonDocumentoEtapa.GetValue<String>('estacao');
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: RegistrarDocumentoEtapa - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEntradaDao.InsertUpdate(pPedidoId, pOperacaoTipoId,
  pPessoaId: Integer; pDocumentoNr: String; pDocumentoData: TDate;
  pArmazemId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pPedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('
        + pOperacaoTipoId.ToString() + ', ' + pPessoaId.ToString() + ', ' +
        QuotedStr(pDocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + '), ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', ' +
        pArmazemId.ToString()
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        pOperacaoTipoId.ToString() + '   , PessoaId      = ' +
        pPessoaId.ToString() + '   , DocumentoNr   = ' + QuotedStr(pDocumentoNr)
        + '   , DocumentoData = ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + ')' +
        '   , DtInclusao    = ' + TuEvolutConst.SqlDataAtual +
        '   , HrInclusao    = ' + TuEvolutConst.SqlHoraAtual +
        '   , ArmazemId     = ' + pArmazemId.ToString() + ' where EntradaId = '
        + pPedidoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TEntradaDao.MontarPaginacao: TJsonObject;
var
  vSql: String;
begin
  Result := TJsonObject.Create;
  try
    FConexao.Query.Open
      ('Select Count(*) Paginacao From Pedido Where OperacaoTipoId = 3');
    Result.AddPair('paginacao',
      TJsonNumber.Create(FConexao.Query.FieldByName('Paginacao').AsInteger));
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', E.Message);
    End;
  end;
end;

function TEntradaDao.Salvar: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    if Self.Entrada.EntradaId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('
        + Self.Entrada.OperacaoTipo.OperacaoTipoId.ToString() + ', ' +
        Self.Entrada.Pessoa.PessoaId.ToString() + ', ' +
        QuotedStr(Self.Entrada.DocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', Self.Entrada.DocumentoData) + #39 + '), ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', ' +
        Self.Entrada.ArmazemId.ToString()
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        Self.Entrada.OperacaoTipo.OperacaoTipoId.ToString() +
        '   , PessoaId      = ' + Self.Entrada.Pessoa.PessoaId.ToString() +
        '   , DocumentoNr   = ' + QuotedStr(Self.Entrada.DocumentoNr) +
        '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = '
        + #39 + FormatDateTime('YYYY-MM-DD', Self.Entrada.DocumentoData) + #39 +
        ')' + '   , DtInclusao    = ' + TuEvolutConst.SqlDataAtual +
        '   , HrInclusao    = ' + TuEvolutConst.SqlHoraAtual +
        '   , ArmazemId     = ' + Self.Entrada.ArmazemId.ToString() +
        ' where EntradaId = ' + Self.Entrada.EntradaId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TEntradaDao.SalvarCheckInItem(pJsonEntrada: TJsonObject): TJsonObject;
Var
  jsonEntradaItem: TJsonObject;
  jsonArrayItens: TjSonArray;
  xItens: Integer;
  vSql: String;
  EntradaId, EntradaItemId, ProdutoId, LoteId: Integer;
  DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada, vTerminal,
    vErro: String;
  QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada, UsuarioId,
    RespAltLoteId: Integer;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    EntradaId := pJsonEntrada.GetValue<Integer>('pedido');
    // jsonArrayItens := tjsonArray.Create;
    jsonArrayItens := pJsonEntrada.Get('itens').JsonValue as TjSonArray;
    for xItens := 0 to jsonArrayItens.Count - 1 do
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      jsonEntradaItem := jsonArrayItens.Items[xItens] as TJsonObject;
      EntradaItemId := jsonEntradaItem.GetValue<Integer>('entradaitemid');
      ProdutoId := jsonEntradaItem.GetValue<Integer>('produtoid');
      LoteId := jsonEntradaItem.GetValue<Integer>('loteid');
      DescrLote := jsonEntradaItem.GetValue<String>('descrlote');
      Fabricacao := jsonEntradaItem.GetValue<string>('fabricacao');
      Vencimento := jsonEntradaItem.GetValue<string>('vencimento');
      DtEntrada := jsonEntradaItem.GetValue<string>('dtentrada');
      HrEntrada := jsonEntradaItem.GetValue<string>('hrentrada');
      QtdXml := jsonEntradaItem.GetValue<Integer>('qtdxml');
      QtdCheckIn := jsonEntradaItem.GetValue<Integer>('qtdcheckin');
      QtdDevolvida := jsonEntradaItem.GetValue<Integer>('qtddevolvida');
      QtdSegregada := jsonEntradaItem.GetValue<Integer>('qtdsegregada');
      UsuarioId := jsonEntradaItem.GetValue<Integer>('usuarioid');
      RespAltLoteId := jsonEntradaItem.GetValue<Integer>('respaltloteid');
      if jsonEntradaItem.TryGetValue('terminal', vErro) then
        vTerminal := jsonEntradaItem.GetValue<String>('terminal')
      Else
        vTerminal := '';

      // Salvar no banco
      vSql := 'Declare @EntradaId Integer = ' + EntradaId.ToString() +
        sLineBreak + 'Declare @EntradaItemId Integer = ' +
        EntradaItemId.ToString() + sLineBreak +
        'Declare @ProdutoId Integer     = ' + ProdutoId.ToString() + sLineBreak
        + 'Declare @LoteId Integer = ' + LoteId.ToString + sLineBreak +
        'Declare @DescrLote VarChar(30) = ' + #39 + DescrLote + #39 + sLineBreak
        + 'Declare @Fabricacao Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(Fabricacao)) + #39 + sLineBreak +
        'Declare @Vencimento Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(Vencimento)) + #39 + sLineBreak +
        'Declare @DtEntrada  Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(DtEntrada)) + #39 + sLineBreak + 'Declare @HrEntrada  Time = '
        + #39 + HrEntrada + #39 + sLineBreak + 'Declare @QtdXml     Integer = '
        + QtdXml.ToString() + sLineBreak + 'Declare @QtdCheckIn Integer = ' +
        QtdCheckIn.ToString() + sLineBreak + 'Declare @QtdDevolvida Integer = '
        + QtdDevolvida.ToString() + sLineBreak +
        'Declare @QtdSegregada Integer = ' + QtdSegregada.ToString() +
        sLineBreak + 'Declare @Usuarioid Integer    = ' + UsuarioId.ToString() +
        sLineBreak + 'Declare @RespAltLoteId Integer = ' +
        RespAltLoteId.ToString() + sLineBreak +
        'Declare @Terminal Varchar(50) = ' + QuotedStr(vTerminal) + #13 + #10;
      // Cadastrar Lote Novo
      vSql := vSql + 'If @LoteId = 0' + sLineBreak +
        '   Set @LoteId = Coalesce((Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote), 0)'
        + #13 + #10;
      vSql := vSql + 'If @LoteId = 0 Begin' + sLineBreak +
        '   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, ' +
        '(Select IdData From Rhema_Data Where Data = @Fabricacao), ' +
        '(Select IdData From Rhema_Data Where Data = @Vencimento), ' +
        '(Select IdData From Rhema_Data Where Data = @DtEntrada), ' +
        '(Select IdHora From Rhema_Hora Where Hora = @HrEntrada), NewId())' +
        sLineBreak +
        '  Set @LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)'
        + sLineBreak + 'End;' + #13 + #10;
      // Novo Lote não pertencente ao XML origiginal
      vSql := vSql +
        'If ((@EntradaItemId = 0) or (Not Exists (Select PedidoItemId From PedidoItens where PedidoId = @EntradaId))) Begin'
        + sLineBreak +
      // @EntradaItemId está vindo com valor indevido... permitindo salvar apenas o CheckIn, sem atualizar os Itens
        '   Insert Into PedidoItens Values (@EntradaId, @LoteId, @QtdXml, @QtdCheckIn, @QtdDevolvida, @QtdSegregada, 0, newid())'
        + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
        '   Update PedidoItens Set QtdCheckIn = QtdCheckIn+@QtdCheckIn, QtdDevolvida = QtdDevolvida+@QtdDevolvida, QtdSegregada = QtdSegregada+@QtdSegregada Where PedidoItemId = @EntradaItemId'
        + sLineBreak + 'End;' + sLineBreak + sLineBreak;
      vSql := vSql +
        'Insert Into PedidoItensCheckIn Values (@EntradaId, @LoteId, @UsuarioId, @QtdXml, @QtdCheckIn, '
        + sLineBreak +
        '   @QtdDevolvida, @QtdSegregada, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'
        + sLineBreak +
        '   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), (Case When @RespAltLoteId = 0 then Null Else '
        + '   @RespAltLoteId End), NewId(), @Terminal)';

      // Clipboard.Clear;
      // try Clipboard.AsText := vSql; Except End;
      FConexao.Query.SQL.Add(vSql);
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('SalvarCheckin.Sql');
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.connection.Commit;

    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Select PI.Pedidoitemid, PI.loteid, PI.qtdcheckin, PI.qtddevolvida, PI.qtdsegregada ');
    FConexao.Query.SQL.Add('From PedidoItens PI');
    FConexao.Query.SQL.Add
      ('Inner Join ProdutoLotes PL ON Pl.LoteId = Pi.LoteId and Pl.ProdutoId = '
      + ProdutoId.ToString() + ' and Pl.DescrLote = ' + QuotedStr(DescrLote));
    FConexao.Query.SQL.Add('Where Pi.pedidoid = ' + EntradaId.ToString());
    FConexao.Query.Open();
    Result := TJsonObject.Create;
    With Result do
    Begin
      AddPair('pedidoitemid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PedidoItemId')
        .AsInteger));
      AddPair('loteid', TJsonNumber.Create(FConexao.Query.FieldByName('LoteId')
        .AsInteger));
      AddPair('qtdcheckin',
        TJsonNumber.Create(FConexao.Query.FieldByName('QtdCheckIn').AsInteger));
      AddPair('qtddevolvida',
        TJsonNumber.Create(FConexao.Query.FieldByName('QtdDevolvida')
        .AsInteger));
      AddPair('qtdsegregada',
        TJsonNumber.Create(FConexao.Query.FieldByName('QtdSegregada')
        .AsInteger));
    End;
    // jsonEntradaItem.Free;
    // jsonArrayItens.Free;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      // Result := tJsonObject.Create(TJSONPair.Create('Erro', E.Message));
      raise Exception.Create('Erro no CheckIn: ' + E.Message);
    End;
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
    pQryKardex.ParamByname('pOperacaoTipoId').Value := pOperacaoTipoId;
    pQryKardex.ParamByname('pLoteId').Value := pLoteId;
    pQryKardex.ParamByname('pEnderecoId').Value := pEnderecoId;
    pQryKardex.ParamByname('pEstoqueTipoId').Value := pEstoqueTipoId;
    pQryKardex.ParamByname('pEstoqueTipoIdDestino').Value :=
      pEstoqueTipoIdDestino;
    pQryKardex.ParamByname('pQuantidade').Value := pQuantidade;
    pQryKardex.ParamByname('pObservacaoOrigem').Value := pObservacaoOrigem;
    pQryKardex.ParamByname('pEnderecoIdDestino').Value := pEnderecoIdDestino;
    pQryKardex.ParamByname('pObservacaoDestino').Value := pObservacaoDestino;
    pQryKardex.ParamByname('pUsuarioId').Value := pUsuarioId;
    pQryKardex.ParamByname('pNomeEstacao').Value := pNomeEstacao;
    pQryKardex.ParamByname('pEstoqueInicial').Value := pEstoqueInicial;
    If DebugHook <> 0 then
      pQryKardex.SQL.SaveToFile('AtKardex.Sql');
    pQryKardex.ExecSQL;
    Result := True;
    pQryKardex.Close;
    // 
  Except
    ON E: Exception do
    Begin
      pQryKardex.Close;
      // 
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
