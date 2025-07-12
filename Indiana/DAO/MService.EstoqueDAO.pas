unit MService.EstoqueDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error, Web.HTTPApp,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option, exactwmsservice.lib.utils,
  EstoqueClass, exactwmsservice.lib.connection, exactwmsservice.dao.base;

type

  TEstoqueDao = class(TBasicDao)
  private

    FOptionsJson: TJsonOptions; //
    FEstoque: TEstoque;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pjsonEstoque: TJsonObject): Boolean;
    Function SalvarEstoqueChecklist(pJsonCheckList: TJsonObject): TJsonArray;
    function Get(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao,
      pDistribuicao: Integer; pZerado, pNegativo: String): TJsonArray;
    function GetEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer;
      pZerado, pNegativo: String): TJsonArray;
    function GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId, pZonaId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer;
      pZerado, pNegativo: String): TJsonArray;
    function GetEstoqueEnderecoPorTipo(pProdutoId, pLoteId, pEnderecoId,
      pEstoqueTipoId, pProducao, pDistribuicao: Integer;
      pZerado, pNegativo: String): TJsonArray;
    Function GetEstoqueEnderecoPorTipoDetalhes(Const AParams
      : TDictionary<string, string>): TJsonArray;
    Function GetEstoqueSemMovimentacao(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetEstoqueSemPicking(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetRelEstoqueSaldo(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetRelEstoquePreOrVencido(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetEstoqueProduto(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetEstoqueZona(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function Delete: Boolean;
    Function AtualizarKardex(pQryKardex: TFdQuery;
      pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pEstoqueTipoIdDestino, pQuantidade, pEnderecoIdDestino,
      pUsuarioId: Integer; pObservacaoOrigem, pObservacaoDestino,
      pNomeEstacao: String; pEstoqueInicial: Integer): Boolean;
    Function ConsultaKardex(pUsuarioId: Integer;
      pDataInicial, pDataFinal: TDateTime; pCodigoERP: Integer;
      pNomeEstacao, pOrigem, pDestino: String): TJsonArray;
    Function GetListaTransferencia: TJsonArray;
    Function GetControleArmazenagem(Const AParams: TDictionary<string, string>)
      : TJsonArray;
    Function GetMovimentacaoInterna(pUsuarioId: Integer;
      pDataInicial, pDataFinal: TDate; pCodProduto: Integer;
      pEnderecoOrigem, pEnderecoDestino: String;
      pArmazenagem, pMovInterna: Integer): TJsonArray;
    Function GetMotivoMovimentacaoSegregado(pAtivo: Integer): TJsonArray;
    Function ValidarMovimentacaoPallet(Const AParams : TDictionary<string, string>): TJsonArray;
    Function GetPulmaoTransferencia(pEnderecoid : Integer; pEndereco : String) : TjsonArray;
    Function PutPulmaoTransferencia(pEnderecoidOrigem, pEnderecoIdDestino : Integer) : TjsonArray;

    Property ObjEstoque: TEstoque Read FEstoque Write FEstoque;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

Function TEstoqueDao.AtualizarKardex(pQryKardex: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String;
  pEstoqueInicial: Integer): Boolean;
Var
  vQryKardex: TFdQuery;
  vTransaction: Boolean;

begin
  // Query vem preparada na Chamada da Função
  vQryKardex := pQryKardex;
  Try
    vTransaction := False;
    vQryKardex.Sql.Clear;
    vQryKardex.Sql.Add(TuEvolutConst.SqlKardexInsUpd);
    vQryKardex.ParamByName('pOperacaoTipoId').Value := pOperacaoTipoId;
    vQryKardex.ParamByName('pLoteId').Value := pLoteId;
    vQryKardex.ParamByName('pEnderecoId').Value := pEnderecoId;
    vQryKardex.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value :=
      pEstoqueTipoIdDestino;
    vQryKardex.ParamByName('pQuantidade').Value := pQuantidade;
    vQryKardex.ParamByName('pObservacaoOrigem').Value := pObservacaoOrigem;
    vQryKardex.ParamByName('pEnderecoIdDestino').Value := pEnderecoIdDestino;
    vQryKardex.ParamByName('pObservacaoDestino').Value := pObservacaoDestino;
    vQryKardex.ParamByName('pUsuarioId').Value := pUsuarioId;
    vQryKardex.ParamByName('pNomeEstacao').Value := pNomeEstacao;
    vQryKardex.ParamByName('pEstoqueInicial').Value := pEstoqueInicial;
    If DebugHook <> 0 then
      vQryKardex.Sql.SaveToFile('AtualizarKardex.Sql');
    vQryKardex.ExecSQL;
    Result := True;
    vQryKardex.Close;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TEstoqueDao.ConsultaKardex(pUsuarioId: Integer;
  pDataInicial, pDataFinal: TDateTime; pCodigoERP: Integer;
  pNomeEstacao, pOrigem, pDestino: String): TJsonArray;
var
  JsonKardex: TJsonObject;
begin
  Result := TJsonArray.Create;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlConsultaKardex);
    FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    FConexao.Query.ParamByName('pDataInicial').Value := pDataInicial;
    FConexao.Query.ParamByName('pDataFinal').Value := pDataFinal;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    FConexao.Query.ParamByName('pNomeEstacao').Value := pNomeEstacao;
    FConexao.Query.ParamByName('pOrigem').Value := pOrigem;
    FConexao.Query.ParamByName('pDestino').Value := pDestino;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há dados para gerar o Kardex'));
    End
    Else
      While Not FConexao.Query.Eof do
      Begin
        // Criar Json Manual
        JsonKardex := TJsonObject.Create;
        JsonKardex.AddPair('produtoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProdutoId')
          .AsInteger));
        JsonKardex.AddPair('codigoerp',
          TJsonNumber.Create(FConexao.Query.FieldByName('CodigoERP')
          .AsInteger));
        JsonKardex.AddPair('descricao', FConexao.Query.FieldByName('Descricao')
          .AsString);
        JsonKardex.AddPair('loteid',
          TJsonNumber.Create(FConexao.Query.FieldByName('LoteId').AsInteger));
        JsonKardex.AddPair('descrlote', FConexao.Query.FieldByName('DescrLote')
          .AsString);
        JsonKardex.AddPair('vencimento',
          FConexao.Query.FieldByName('vencimento').AsString);
        JsonKardex.AddPair('estoquetipo',
          FConexao.Query.FieldByName('EstoqueTipo').AsString);
        JsonKardex.AddPair('enderecoorigem',
          FConexao.Query.FieldByName('EnderecoOrigem').AsString);
        JsonKardex.AddPair('mascaraorigem',
          FConexao.Query.FieldByName('MascaraOrigem').AsString);
        JsonKardex.AddPair('saldoinicialorigem',
          FConexao.Query.FieldByName('SaldoInicialOrigem').AsString);
        JsonKardex.AddPair('retirada', FConexao.Query.FieldByName('Retirada')
          .AsString);
        JsonKardex.AddPair('destino', FConexao.Query.FieldByName('Destino')
          .AsString);
        JsonKardex.AddPair('mascaradestino',
          FConexao.Query.FieldByName('MascaraDestino').AsString);
        JsonKardex.AddPair('saldoinicialdestino',
          FConexao.Query.FieldByName('SaldoInicialDestino').AsString);
        JsonKardex.AddPair('nomeestacao',
          FConexao.Query.FieldByName('NomeEstacao').AsString);
        JsonKardex.AddPair('usuario', FConexao.Query.FieldByName('Usuario')
          .AsString);
        JsonKardex.AddPair('data', FConexao.Query.FieldByName('Data').AsString);
        JsonKardex.AddPair('hora', FConexao.Query.FieldByName('Hora').AsString);
        Result.AddElement(JsonKardex);
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Erro: Consulta Kardex - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

constructor TEstoqueDao.Create;
begin
  FOptionsJson := [joDateIsUTC, joDateFormatISO8601];
  ObjEstoque := TEstoque.Create;
  FConexao := TConnection.Create();
end;

function TEstoqueDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Estoque where LoteId= ' +
      Self.ObjEstoque.LoteId.ToString + ' and ' + 'EnderecoId = ' +
      Self.ObjEstoque.EnderecoId.ToString() + ' and EstoqueTipoId = ' +
      Self.ObjEstoque.EstoqueTipoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TEstoqueDao.Destroy;
begin
  ObjEstoque.Free;
  inherited;
end;

function TEstoqueDao.Get(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId,
  pProducao, pDistribuicao: Integer; pZerado, pNegativo: String): TJsonArray;
var
  JsonEstoque: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoque);
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    FConexao.Query.ParamByName('pLoteId').Value := pLoteId;
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    FConexao.Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    FConexao.Query.ParamByName('pProducao').Value := pProducao;
    FConexao.Query.ParamByName('pDistribuicao').Value := pDistribuicao;
    FConexao.Query.ParamByName('pZerado').Value := pZerado;
    FConexao.Query.ParamByName('pNegativo').Value := pNegativo;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('GetEstoque.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      While Not FConexao.Query.Eof do
      Begin
        // Criar Json Manual
        JsonEstoque := TJsonObject.Create;
        JsonEstoque.AddPair('produtoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProdutoId')
          .AsInteger));
        JsonEstoque.AddPair('codigoerp',
          TJsonNumber.Create(FConexao.Query.FieldByName('CodigoERP')
          .AsInteger));
        JsonEstoque.AddPair('produto', FConexao.Query.FieldByName('Produto')
          .AsString);
        JsonEstoque.AddPair('unidadeid',
          TJsonNumber.Create(FConexao.Query.FieldByName('UnidadeId')
          .AsInteger));
        JsonEstoque.AddPair('unidadedecundariaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('UnidadeSecundariaId')
          .AsInteger));
        JsonEstoque.AddPair('embprim',
          FConexao.Query.FieldByName('UnidadeDescricao').AsString);
        JsonEstoque.AddPair('embsec',
          FConexao.Query.FieldByName('UnidadeSecundariaDescricao').AsString);
        JsonEstoque.AddPair('qtdunid',
          TJsonNumber.Create(FConexao.Query.FieldByName('QtdUnid').AsInteger));
        JsonEstoque.AddPair('fatorconversao',
          TJsonNumber.Create(FConexao.Query.FieldByName('FatorConversao')
          .AsInteger));
        JsonEstoque.AddPair('messaidaminima',
          TJsonNumber.Create(FConexao.Query.FieldByName('MesSaidaMinima')
          .AsInteger));
        JsonEstoque.AddPair('loteid',
          TJsonNumber.Create(FConexao.Query.FieldByName('LoteId').AsInteger));
        JsonEstoque.AddPair('descrlote', FConexao.Query.FieldByName('DescrLote')
          .AsString);
        JsonEstoque.AddPair('fabricacao',
          DateToStr(FConexao.Query.FieldByName('Fabricacao').AsDateTime));
        JsonEstoque.AddPair('vencimento',
          DateToStr(FConexao.Query.FieldByName('Vencimento').AsDateTime));
        JsonEstoque.AddPair('enderecoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('EnderecoId')
          .AsInteger));
        JsonEstoque.AddPair('endereco', FConexao.Query.FieldByName('Endereco')
          .AsString);
        JsonEstoque.AddPair('estruturaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('EstruturaId')
          .AsInteger));
        JsonEstoque.AddPair('estrutura', FConexao.Query.FieldByName('Estrutura')
          .AsString);
        JsonEstoque.AddPair('pickingfixo',
          TJsonNumber.Create(FConexao.Query.FieldByName('PickingFixo')
          .AsInteger));
        JsonEstoque.AddPair('status',
          TJsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
        JsonEstoque.AddPair('zonaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ZonaId').AsInteger));
        JsonEstoque.AddPair('zona', FConexao.Query.FieldByName('Zona')
          .AsString);
        JsonEstoque.AddPair('qtdeproducao',
          TJsonNumber.Create(FConexao.Query.FieldByName('QtdeProducao')
          .AsInteger));
        JsonEstoque.AddPair('qtdereserva',
          TJsonNumber.Create(FConexao.Query.FieldByName('QtdeReserva')
          .AsInteger));
        JsonEstoque.AddPair('qtde',
          TJsonNumber.Create(FConexao.Query.FieldByName('Qtde').AsInteger));
        // Saldo Estoque
        JsonEstoque.AddPair('estoquetipoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('EstoqueTipoId')
          .AsInteger));
        JsonEstoque.AddPair('estoquetipo',
          FConexao.Query.FieldByName('EstoqueTipo').AsString);
        JsonEstoque.AddPair('producao',
          TJsonNumber.Create(FConexao.Query.FieldByName('Producao').AsInteger));
        JsonEstoque.AddPair('distribuicao',
          TJsonNumber.Create(FConexao.Query.FieldByName('Distribuicao')
          .AsInteger));
        JsonEstoque.AddPair('dtentrada',
          DateToStr(FConexao.Query.FieldByName('DtEntrada').AsDateTime));
        if FConexao.Query.FieldByName('hrentrada').AsString = '' then
          JsonEstoque.AddPair('hrentrada', '00:00:00')
        Else
          JsonEstoque.AddPair('hrentrada',
            TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('HrEntrada')
            .AsString, 1, 8))));
        if FConexao.Query.FieldByName('horario').AsString = '' then
          JsonEstoque.AddPair('horario', '00:00:00')
        Else
          JsonEstoque.AddPair('horario',
            Copy(TimeToStr(FConexao.Query.FieldByName('horario')
            .AsDateTime), 1, 8));
        // TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('horario').AsString,1,8))));
        JsonEstoque.AddPair('usuarioid',
          TJsonNumber.Create(FConexao.Query.FieldByName('UsuarioId')
          .AsInteger));
        JsonEstoque.AddPair('ordem',
          TJsonNumber.Create(FConexao.Query.FieldByName('Ordem').AsInteger));
        JsonEstoque.AddPair('mascara', FConexao.Query.FieldByName('Mascara')
          .AsString);
        // Result := FConexao.Query.ToJSONArray();
        Result.AddElement(JsonEstoque);
        // tJson.ObjectToJsonObject(ObjEstoque, [joDateIsUTC, joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
    // JsonEstoque.Free;

  Except
    ON E: Exception do
    Begin
      JsonEstoque.Free;
      raise Exception.Create('Processo: Estoque - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetControleArmazenagem(Const AParams
  : TDictionary<string, string>): TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetControleArmazenagem);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pDataInicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pDataFinal').Value := 0;
    if AParams.ContainsKey('documentonr') then
      FConexao.Query.ParamByName('pDocumentoNr').Value :=
        AParams.Items['docummentonr']
    Else
      FConexao.Query.ParamByName('pDocumentoNr').Value := '';
    if AParams.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value :=
        StrToIntDef(AParams.Items['codproduto'], 0)
    Else
      FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if AParams.ContainsKey('enderecodestinoid') then
      FConexao.Query.ParamByName('pEnderecoDestinoId').Value :=
        StrToIntDef(AParams.Items['enderecodestinoid'], 0)
    Else
      FConexao.Query.ParamByName('pEnderecoDestinoId').Value := 0;
    if AParams.ContainsKey('tipomovimentacao') then
       FConexao.Query.ParamByName('pTipoMovimentacao').Value := StrToIntDef(AParams.Items['tipomovimentacao'], 0)
    Else
       FConexao.Query.ParamByName('pTipoMovimentacao').Value := 1;
    if AParams.ContainsKey('usuarioid') then
       FConexao.Query.ParamByName('pUsuarioId').Value := StrToIntDef(AParams.Items['usuarioid'], 0)
    Else
       FConexao.Query.ParamByName('pUsuarioId').Value := 0;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('ControleArmazenagem.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Erro: GetControleArmazenagem - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]','', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueSemMovimentacao(
  const AParams: TDictionary<string, string>): TJsonArray;
//var xObjJson: TJsonObject;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoqueSemMovimentacao);
    if AParams.ContainsKey('codproduto') then
       FConexao.Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger
    Else
       FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaid').Value := AParams.Items['zonaid'].ToInteger
    Else
       FConexao.Query.ParamByName('pZonaid').Value := 0;
    if AParams.ContainsKey('periodo') then
       FConexao.Query.ParamByName('pPeriodo').Value := AParams.Items['periodo'].ToInteger
    Else
       FConexao.Query.ParamByName('pPeriodo').Value := 0;
{    if AParams.ContainsKey('enderecoinicial') then
       FConexao.Query.ParamByName('pEnderecoInicial').Value := AParams.Items['enderecoinicial']
    Else
       FConexao.Query.ParamByName('pEnderecoInicial').Value := '';
    if AParams.ContainsKey('enderecofinal') then
       FConexao.Query.ParamByName('pEnderecoFinal').Value := AParams.Items['enderecofinal']
    Else
       FConexao.Query.ParamByName('pEnderecoInicial').Value := '';
}    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('EstoqueSemMovimentacao.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque sem movimentação nesse período.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque Sem Picking - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueSemPicking(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoqueSemPicking);
    if AParams.ContainsKey('produtoid') then
      FConexao.Query.ParamByName('pProdutoid').Value :=
        AParams.Items['produtoid'].ToInteger
    Else
      FConexao.Query.ParamByName('pProdutoid').Value := 0;
    if AParams.ContainsKey('loteidid') then
      FConexao.Query.ParamByName('pLoteid').Value := AParams.Items['loteid']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pLoteid').Value := 0;
    if AParams.ContainsKey('enderecoid') then
      FConexao.Query.ParamByName('pEnderecoId').Value :=
        AParams.Items['enderecoid'].ToInteger
    Else
      FConexao.Query.ParamByName('pEnderecoId').Value := 0;
    if AParams.ContainsKey('estruturaid') then
      FConexao.Query.ParamByName('pEstruturaid').Value :=
        AParams.Items['estruturaid'].ToInteger
    Else
      FConexao.Query.ParamByName('pEstruturaid').Value := 0;
    if AParams.ContainsKey('estoquetipoid') then
      FConexao.Query.ParamByName('pEstoquetipoId').Value :=
        AParams.Items['estoquetipoid'].ToInteger
    Else
      FConexao.Query.ParamByName('pEstoquetipoId').Value := 0;
    if AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pzonaid').Value := AParams.Items['zonaid']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pZonaid').Value := 0;
    if AParams.ContainsKey('zerado') and (AParams.Items['zerado'] = 'N') then
      FConexao.Query.Sql.Add
        (' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) <> 0)');
    if AParams.ContainsKey('negativo') and (AParams.Items['negativo'] = 'N')
    then
      FConexao.Query.Sql.Add
        (' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) > 0)');
    if AParams.ContainsKey('prevencido') and (AParams.Items['prevencido'] = '1')
    then
      FConexao.Query.Sql.Add
        (' 		      and (EET.Vencimento > GetDate() and EET.Vencimento <= GetDate()+(Select MesesParaPreVencido*30 From Configuracao))');
    if AParams.ContainsKey('vencido') and (AParams.Items['vencido'] = '1') then
      FConexao.Query.Sql.Add(' 		      and (EET.Vencimento <= GetDate())');
    FConexao.Query.Sql.Add('Order by Descricao');
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('EstoqueSemPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há estoque estoque disponível.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque Sem Picking - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueZona(const AParams: TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    SqlWhere: String;
begin
  try
    FConexao.Query.Sql.Add('Declare @ProdutoId Integer  = :pProdutoId');
    FConexao.Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
    FConexao.Query.Sql.Add('Declare @ZonaId     Integer = :pZonaId');
//    FConexao.Query.Sql.Add('Declare @CausaId    Integer = :pCausaId');
    FConexao.Query.Sql.Add('select ProdutoId, CodigoERP CodProduto, LoteId, DescrLote, Fabricacao, Vencimento, Produto Descricao, Sum(QtdeProducao) QtdeProducao, SUM(Qtde) Saldo');
    FConexao.Query.Sql.Add('from vEstoque');
    FConexao.Query.Sql.Add('where EstoqueTipoId in (1, 4)');
    FConexao.Query.Sql.Add('  And (@ProdutoId = 0 or ProdutoId = @ProdutoId)');
    FConexao.Query.Sql.Add('  And (@CodProduto = 0 or CodigoERP = @CodProduto)');
    FConexao.Query.Sql.Add('  And (@ZonaId = 0 or ZonaId = @ZonaId)');
    //FConexao.Query.Sql.Add('  And (@CausaId = 0 or Causadd = @CausaId)');
    FConexao.Query.Sql.Add('Group by ProdutoId, CodigoERP, LoteId, DescrLote, Fabricacao, Vencimento, Produto');
    if AParams.ContainsKey('produtoid') then
       FConexao.Query.ParamByName('pProdutoid').Value := StrToIntDef(AParams.Items['produtoid'], 0)
    Else
       FConexao.Query.ParamByName('pProdutoid').Value := 0;
    if AParams.ContainsKey('codproduto') then
       FConexao.Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
    Else
       FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaId').Value := StrToIntDef(AParams.Items['zonaid'], 0)
    Else
       FConexao.Query.ParamByName('pZonaId').Value := 0;
//    if AParams.ContainsKey('causaid') then
//       FConexao.Query.ParamByName('pCausaId').Value := StrToIntDef(AParams.Items['causaid'], 0)
//    Else
//       FConexao.Query.ParamByName('pCausaId').Value := 0;
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('EstoqueProduto.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueEnderecoPorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado, pNegativo: String)
  : TJsonArray;
var
  xObjJson: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoqueEnderecoPorTipo);
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    FConexao.Query.ParamByName('pLoteId').Value := pLoteId;
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    FConexao.Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    FConexao.Query.ParamByName('pProducao').Value := pProducao;
    FConexao.Query.ParamByName('pDistribuicao').Value := pDistribuicao;
    FConexao.Query.ParamByName('pZerado').Value := pZerado;
    FConexao.Query.ParamByName('pNegativo').Value := pNegativo;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('GetEstoqueEnderecoPorTipo.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há estoque estoque disponível.'))
    Else
      while Not FConexao.Query.Eof do
      Begin
        // Criar Json Manual
        xObjJson := TJsonObject.Create;
        xObjJson.AddPair('produtoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProdutoId')
          .AsInteger));
        xObjJson.AddPair('codproduto',
          TJsonNumber.Create(FConexao.Query.FieldByName('CodigoERP')
          .AsInteger));
        xObjJson.AddPair('produto', FConexao.Query.FieldByName('Produto')
          .AsString);
        xObjJson.AddPair('picking', FConexao.Query.FieldByName('Picking')
          .AsString);
        xObjJson.AddPair('endereco', FConexao.Query.FieldByName('Endereco')
          .AsString);
        xObjJson.AddPair('estrutura', FConexao.Query.FieldByName('Estrutura')
          .AsString);
        xObjJson.AddPair('loteid',
          TJsonNumber.Create(FConexao.Query.FieldByName('LoteId').AsInteger));
        xObjJson.AddPair('descrlote', FConexao.Query.FieldByName('DescrLote')
          .AsString);
        xObjJson.AddPair('fabricacao', FConexao.Query.FieldByName('Fabricacao')
          .AsString);
        xObjJson.AddPair('vencimento', FConexao.Query.FieldByName('Vencimento')
          .AsString);
        // Horario
        xObjJson.AddPair('stage',
          TJsonNumber.Create(FConexao.Query.FieldByName('Stage').AsInteger));
        xObjJson.AddPair('crossdocking',
          TJsonNumber.Create(FConexao.Query.FieldByName('Crossdocking')
          .AsInteger));
        xObjJson.AddPair('segregado',
          TJsonNumber.Create(FConexao.Query.FieldByName('Segregado')
          .AsInteger));
        xObjJson.AddPair('producao',
          TJsonNumber.Create(FConexao.Query.FieldByName('producao').AsInteger));
        xObjJson.AddPair('expedicao',
          TJsonNumber.Create(FConexao.Query.FieldByName('expedicao')
          .AsInteger));
        xObjJson.AddPair('reserva',
          TJsonNumber.Create(FConexao.Query.FieldByName('Reserva').AsInteger));
        xObjJson.AddPair('saldo',
          TJsonNumber.Create(FConexao.Query.FieldByName('Saldo').AsInteger));
        xObjJson.AddPair('mascara', FConexao.Query.FieldByName('Mascara')
          .AsString);
        Result.AddElement(xObjJson);
        FConexao.Query.Next;
      End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Endereço por Tipo de Estoque) - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueEnderecoPorTipoDetalhes(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
begin
  try
    if (AParams.ContainsKey('estoquetipoid')) and (AParams.Items['estoquetipoid'].ToInteger = 6) then
       FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoqueEnderecoPorTipoDetalhesReserva)
    Else
       FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoqueEnderecoPorTipoDetalhes);
    if AParams.ContainsKey('produtoid') then begin
       FConexao.Query.Sql.Add(' 		      and Prd.IdProduto = :produtoid ');
       FConexao.Query.ParamByName('produtoid').Value := AParams.Items['produtoid'];
    end;
    if AParams.ContainsKey('enderecoid') then begin
       FConexao.Query.Sql.Add(' 		      and EET.EnderecoId = :EnderecoId');
       FConexao.Query.ParamByName('enderecoid').Value := AParams.Items['enderecoid'];
    end;
    if AParams.ContainsKey('estruturaid') then begin
       FConexao.Query.Sql.Add(' 		      and Ve.estruturaid = :estruturaid');
       FConexao.Query.ParamByName('estruturaid').Value := AParams.Items['estruturaid'];
    end;
    // if AParams.ContainsKey('estoquetipoid') then begin
    // FConexao.Query.SQL.Add(' 		      and Ve.EstoqueTipoId = :EstoqueTipoId');
    // FConexao.Query.ParamByName('estoquetipoid').Value := AParams.Items['estoquetipoid'];
    // end;
    if AParams.ContainsKey('zonaid') then begin
       FConexao.Query.Sql.Add(' 		      and Ve.ZonaId = :zonaid');
       FConexao.Query.ParamByName('zonaid').Value := AParams.Items['zonaid'];
    end;
    if AParams.ContainsKey('zerado') and (AParams.Items['zerado'] = 'N') then
       FConexao.Query.Sql.Add(' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) <> 0)');
    if AParams.ContainsKey('negativo') and (AParams.Items['negativo'] = 'N') then
       FConexao.Query.Sql.Add(' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) > 0)');
    if AParams.ContainsKey('prevencido') and (AParams.Items['prevencido'] = '1') then begin
       FConexao.Query.Sql.Add(' 		      and (EET.Vencimento > GetDate() and EET.Vencimento <= GetDate()+(Select MesesParaPreVencido*30 From Configuracao))');
    end;
    if AParams.ContainsKey('vencido') and (AParams.Items['vencido'] = '1') then
       FConexao.Query.Sql.Add(' 		      and (EET.Vencimento <= GetDate())');
    if (AParams.ContainsKey('estoquetipoid')) then begin
       if (AParams.Items['estoquetipoid'].ToInteger < 5) then
          FConexao.Query.ParamByName('pEstoqueTipoId').Value := AParams.Items['estoquetipoid'].ToInteger;
    end
    else
       FConexao.Query.ParamByName('pEstoqueTipoId').Value := 0;
    if (AParams.ContainsKey('estoquetipoid')) and (AParams.Items['estoquetipoid'].ToInteger = 6) then
       FConexao.Query.Sql.Add('Order by EET.ProdutoId, EET.Endereco')
    Else Begin
      if (AParams.ContainsKey('estoquetipoid')) then Begin
         If (AParams.Items['ordem'].ToInteger = 0) then
            FConexao.Query.Sql.Add('Order by Prd.CodProduto, Ve.Endereco, Mov.Data')
         Else If (AParams.Items['ordem'].ToInteger = 1) then
            FConexao.Query.Sql.Add('Order by Prd.Descricao, EET.Vencimento, Ve.Endereco, Mov.Data')
         Else If (AParams.Items['ordem'].ToInteger = 2) then
            FConexao.Query.Sql.Add('Order by Ve.Endereco, Prd.Descricao, EET.Vencimento, Mov.Data')
         Else If (AParams.Items['ordem'].ToInteger = 3) then
            FConexao.Query.Sql.Add('Order by EET.Vencimento, Prd.Descricao, Ve.Endereco, Mov.Data')
         Else If (AParams.Items['ordem'].ToInteger = 4) then
            FConexao.Query.Sql.Add('Order by Mov.Data, Prd.Descricao, EET.Vencimento, Ve.Endereco')
    End
    Else
       FConexao.Query.Sql.Add('Order by EET.ProdutoId, Ve.Endereco');
    End;
    If DebugHook <> 0 Then Begin
       if (AParams.ContainsKey('estoquetipoid')) and (AParams.Items['estoquetipoid'].ToInteger = 6) then
          FConexao.Query.Sql.SaveToFile('EstoqueEndTipoDetalheReserva.Sql')
       Else FConexao.Query.Sql.SaveToFile('EstoqueEndTipoDetalhe.Sql');
    End;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do Begin
       raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - ' + StringReplace(E.Message,
                              '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado, pNegativo: String) : TJsonArray;
var xObjJson: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEstoqueLotePorTipo);
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    FConexao.Query.ParamByName('pLoteId').Value := pLoteId;
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    // FConexao.Query.ParamByName('pZonaId').Value        := pZonaId;
    FConexao.Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    FConexao.Query.ParamByName('pProducao').Value := pProducao;
    FConexao.Query.ParamByName('pDistribuicao').Value := pDistribuicao;
    FConexao.Query.ParamByName('pZerado').Value := pZerado;
    FConexao.Query.ParamByName('pNegativo').Value := pNegativo;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('GetEstoqueLotePorTipo.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há estoque estoque disponível.'))
    Else
      while Not FConexao.Query.Eof do
      Begin
        // Criar Json Manual
        xObjJson := TJsonObject.Create;
        xObjJson.AddPair('produtoid', TJsonNumber.Create(FConexao.Query.FieldByName('ProdutoId').AsInteger));
        xObjJson.AddPair('loteid', TJsonNumber.Create(FConexao.Query.FieldByName('LoteId').AsInteger));
        xObjJson.AddPair('fatorconversao', TJsonNumber.Create(FConexao.Query.FieldByName('FatorConversao').AsInteger));
        xObjJson.AddPair('descrlote', FConexao.Query.FieldByName('DescrLote').AsString);
        xObjJson.AddPair('zonaid', TJsonNumber.Create(FConexao.Query.FieldByName('ZonaId').AsInteger));
        xObjJson.AddPair('zona', FConexao.Query.FieldByName('Zona').AsString);
        xObjJson.AddPair('fabricacao', FConexao.Query.FieldByName('Fabricacao').AsString);
        xObjJson.AddPair('vencimento', FConexao.Query.FieldByName('Vencimento').AsString);
        // Horario
        xObjJson.AddPair('stage', TJsonNumber.Create(FConexao.Query.FieldByName('Stage').AsInteger));
        xObjJson.AddPair('crossdocking', TJsonNumber.Create(FConexao.Query.FieldByName('Crossdocking').AsInteger));
        xObjJson.AddPair('segregado', TJsonNumber.Create(FConexao.Query.FieldByName('Segregado').AsInteger));
        xObjJson.AddPair('producao', TJsonNumber.Create(FConexao.Query.FieldByName('producao').AsInteger));
        xObjJson.AddPair('expedicao', TJsonNumber.Create(FConexao.Query.FieldByName('expedicao').AsInteger));
        xObjJson.AddPair('reserva', TJsonNumber.Create(FConexao.Query.FieldByName('Reserva').AsInteger));
        xObjJson.AddPair('saldo', TJsonNumber.Create(FConexao.Query.FieldByName('Saldo').AsInteger));
        xObjJson.AddPair('dtultimamovimentacao', FConexao.Query.FieldByName('DtUltimaMovimentacao').AsString);
        Result.AddElement(xObjJson);
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Lote por Tipo de Estoque) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetEstoqueProduto(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    SqlWhere: String;
begin
  try
    FConexao.Query.Sql.Add('Declare @ProdutoId Integer = :pProdutoId');
    FConexao.Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
    FConexao.Query.Sql.Add('select ProdutoId, CodigoERP CodProduto, LoteId, DescrLote, Fabricacao, Vencimento, Produto Descricao, Sum(QtdeProducao) QtdeProducao, SUM(Qtde) Saldo');
    FConexao.Query.Sql.Add('from vEstoque');
    FConexao.Query.Sql.Add('where EstoqueTipoId in (1, 4)');
    FConexao.Query.Sql.Add('  And (@ProdutoId = 0 or Produtoid = @ProdutoId)');
    FConexao.Query.Sql.Add('  And (@CodProduto = 0 or CodigoERP = @CodProduto)');
    FConexao.Query.Sql.Add('Group by ProdutoId, CodigoERP, LoteId, DescrLote, Fabricacao, Vencimento, Produto');
    if AParams.ContainsKey('produtoid') then
       FConexao.Query.ParamByName('pProdutoid').Value := StrToIntDef(AParams.Items['produtoid'], 0)
    Else
       FConexao.Query.ParamByName('pProdutoid').Value := 0;
    if AParams.ContainsKey('codproduto') then
       FConexao.Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
    Else
       FConexao.Query.ParamByName('pCodProduto').Value := 0;
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('EstoqueProduto.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetListaTransferencia: TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add('Select * from vReposicaoTransferencia');
    FConexao.Query.Sql.Add('Order by CodProduto, Vencimento');
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('EstoqueListaTransferencia.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Erro: Consulta Kardex - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetMotivoMovimentacaoSegregado(pAtivo: Integer)
  : TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add('Declare @Ativo Integer = ' + pAtivo.ToString);
    FConexao.Query.Sql.Add
      ('Select segregadocausaid, descricao, status From SegregadoCausa');
    FConexao.Query.Sql.Add('Where @Ativo >= 2 or @Ativo = Status');
    FConexao.Query.Sql.Add('Order by Descricao');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há dados para gerar o relatório'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Erro: GetMotivoMovimentacaoSegregado - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetMovimentacaoInterna(pUsuarioId: Integer;
  pDataInicial, pDataFinal: TDate; pCodProduto: Integer;
  pEnderecoOrigem, pEnderecoDestino: String; pArmazenagem, pMovInterna: Integer)
  : TJsonArray;
var
  JsonKardex: TJsonObject;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetRelMovimentacaointerna);
    FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    if pDataInicial = 0 then
      FConexao.Query.ParamByName('pDataInicial').Value := 0
    Else
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicial);
    if pDataFinal = 0 then
      FConexao.Query.ParamByName('pDataFinal').Value := 0
    Else
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFinal);
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    FConexao.Query.ParamByName('pEnderecoOrigem').Value := pEnderecoOrigem;
    FConexao.Query.ParamByName('pEnderecoDestino').Value := pEnderecoDestino;
    FConexao.Query.ParamByName('pArmazenagem').Value := pArmazenagem;
    FConexao.Query.ParamByName('pMovInterna').Value := pMovInterna;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EstoqueMovInterna.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Erro: Movimentação Interna - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetPulmaoTransferencia(pEnderecoid: Integer; pEndereco : String): TjsonArray;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.GetPulmaoTransferencia);
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    if pEndereco <> '0' then
       FConexao.Query.ParamByName('pEndereco').Value   := pEndereco
    Else
       FConexao.Query.ParamByName('pEndereco').Value   := '';
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('GetPulmaoTransferencia.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não há estoque em Pulmão para Transferêcia.'));
    End
    Else If FConexao.Query.FieldByName('QtdeReserva').AsInteger > 0 then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Movimentação não permitida, existe reserva pendente.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetPulmaoTransferencia(Lote por Tipo de Estoque) - ' + Tutil.TratarExcessao(E.Message));
    End;
  end;
end;

function TEstoqueDao.PutPulmaoTransferencia(pEnderecoidOrigem, pEnderecoIdDestino : Integer): TjsonArray;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.PutPulmaoTransferencia);
    FConexao.Query.ParamByName('pEnderecoIdOrigem').Value  := pEnderecoIdOrigem;
    FConexao.Query.ParamByName('pEnderecoIdDestino').Value := pEnderecoIdDestino;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('GetPulmaoTransferencia.Sql');
    FConexao.Query.ExecSql;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Transferência efetuada com sucesso!'))
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: PutPulmaoTransferencia - '+Tutil.TratarExcessao(E.Message));
    End;
  end;
end;

function TEstoqueDao.GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
  pZonaId, pEstoqueTipoId, pProducao, pDistribuicao: Integer;
  pZerado, pNegativo: String): TJsonArray;
//var xObjJson: TJsonObject;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlRelEstoqueLotePorTipo);
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    FConexao.Query.ParamByName('pLoteId').Value := pLoteId;
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    FConexao.Query.ParamByName('pProducao').Value := pProducao;
    FConexao.Query.ParamByName('pDistribuicao').Value := pDistribuicao;
    FConexao.Query.ParamByName('pZerado').Value := pZerado;
    FConexao.Query.ParamByName('pNegativo').Value := pNegativo;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('GetRelEstoqueLotePorTipo.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Lote por Tipo de Estoque) - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetRelEstoqueSaldo(const AParams
  : TDictionary<string, string>): TJsonArray;
var
  xObjJson: TJsonObject;
  SqlWhere: String;
begin
  try
    FConexao.Query.Sql.Add('Select Est.*, Mov.Data DtUltimaMovimentacao');
    FConexao.Query.Sql.Add('From (select CodigoERP CodProduto, Produto Descricao, SUM(Qtde) Saldo');
    FConexao.Query.Sql.Add('      from vEstoque');
    FConexao.Query.Sql.Add('      where EstoqueTipoId in (1, 4)');
    if AParams.ContainsKey('produtoid') then
       SqlWhere := SqlWhere + ' And Produtoid = ' + AParams.Items['produtoid'];
    if AParams.ContainsKey('enderecoid') then
       SqlWhere := SqlWhere + ' And EnderecoId = ' + AParams.Items['enderecoid'];
    if AParams.ContainsKey('estruturaid') then
       SqlWhere := SqlWhere + ' And Estruturaid = ' + AParams.Items['estruturaid'];
    if AParams.ContainsKey('zonaid') then
       SqlWhere := SqlWhere + ' And ZonaId = ' + AParams.Items['zonaid'];
    if AParams.ContainsKey('zerado') and (AParams.Items['zerado'] = 'N') then
       SqlWhere := SqlWhere + ' And (QtdEspera + QtdProducao - Reserva) <> 0)';
    if AParams.ContainsKey('negativo') and (AParams.Items['negativo'] = 'N') then
       SqlWhere := SqlWhere + ' And (QtdEspera + QtdProducao - Reserva) > 0)';
    if AParams.ContainsKey('prevencido') and (AParams.Items['prevencido'] = '1') then
       SqlWhere := SqlWhere+' And (EET.Vencimento > GetDate() and EET.Vencimento <= GetDate()+(Select MesesParaPreVencido*30 From Configuracao))';
    if AParams.ContainsKey('vencido') and (AParams.Items['vencido'] = '1') then
       SqlWhere := SqlWhere + ' And (Vencimento <= GetDate())';
    if SqlWhere <> '' then
       FConexao.Query.Sql.Add(SqlWhere);
    FConexao.Query.Sql.Add('      Group by CodigoERP, Produto) Est');
    FConexao.Query.Sql.Add(TuEvolutConst.SqlRelEstoqueSaldo);
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('EstoqueSaldo.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há Estoque disponível.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEstoqueDao.GetRelEstoquePreOrVencido(
  const AParams: TDictionary<string, string>): TJsonArray;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlRelEstoquePreOrVencido);
    if AParams.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
    Else
      FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := StrToIntDef(AParams.Items['zonaid'], 0)
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    if AParams.ContainsKey('prevencido') then
      FConexao.Query.ParamByName('pPreVencido').Value := StrToIntDef(AParams.Items['prevencido'], 0)
    Else
      FConexao.Query.ParamByName('pPreVencido').Value := 0;
    if AParams.ContainsKey('vencido') then
      FConexao.Query.ParamByName('pVencido').Value := StrToIntDef(AParams.Items['vencido'], 0)
    Else
      FConexao.Query.ParamByName('pVencido').Value := 0;
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pDataInicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pDataFinal').Value := 0;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('EstoquePreOrVencido.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há Estoque Vencido no período informado.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

// Fechamento da Transacao depois de matar a vQryestoque em 29/11/2023
// GSS
function TEstoqueDao.Salvar(pjsonEstoque: TJsonObject): Boolean;
var vQryEstoque: TFdQuery;
    vQryKardex: TFdQuery;
    jsonArrayEstoque, JsonArrayKardex: TJsonArray;
    JsonKardex: TJsonObject;
    xEstoque, xKardex: Integer;
    vValidarEstoqueOrigem: String;
    vEstoqueInicial: Integer;
begin
  vQryEstoque := FConexao.GetQuery;
  vQryEstoque.connection.StartTransaction;
  vQryKardex := FConexao.GetQuery;
  try
    jsonArrayEstoque := pjsonEstoque.GetValue<TJsonArray>('estoque');
    for xEstoque := 0 to Pred(jsonArrayEstoque.Count) do
    Begin
      if jsonArrayEstoque.Get(xEstoque).TryGetValue('validarestoqueorigem',
        vValidarEstoqueOrigem) then
      Begin
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add('Select Coalesce(Qtde, 0) Qtde From Estoque');
        vQryEstoque.Sql.Add('Where LoteId        = ' + jsonArrayEstoque.Items[xEstoque].GetValue<String>('loteid'));
        vQryEstoque.Sql.Add('  And EnderecoId    = ' + jsonArrayEstoque.Items[xEstoque].GetValue<String>('enderecoid'));
        vQryEstoque.Sql.Add('  And EstoqueTipoId = ' + jsonArrayEstoque.Items[xEstoque].GetValue<String>('estoquetipoid'));
        If DebugHook <> 0 then
           vQryEstoque.Sql.SaveToFile('ValidarEstoque.Sql');
        vQryEstoque.Open();
        if vQryEstoque.FieldByName('Qtde').AsInteger < (jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('qtde') * -1) then
          raise Exception.Create('Saldo(' + vQryEstoque.FieldByName('Qtde').AsString + ') Estoque Insuficiente para movimentar!');
        vEstoqueInicial := vQryEstoque.FieldByName('Qtde').AsInteger;
      End;
      // Pegar o Saldo Inicial do Estoque
      vQryEstoque.Close;
      vQryEstoque.Sql.Clear;
      vQryEstoque.Sql.Add('Select Qtde from Estoque where LoteId = :pLoteId and EnderecoId = :pEnderecoId and EstoqueTipoId = :pEstoqueTipoId');
      vQryEstoque.ParamByName('pLoteId').Value        := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('loteid');
      vQryEstoque.ParamByName('pEnderecoId').Value    := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('enderecoid');
      vQryEstoque.ParamByName('pEstoqueTipoId').Value := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('estoquetipoid');
      // vQryEstoque.Open;
      // vEstoqueInicial := vQryEstoque.FieldByName('Qtde').AsInteger;
      vQryEstoque.Close;
      vQryEstoque.Sql.Clear;
      vQryEstoque.Sql.Add('--EstoqueDao.Salvar');
      vQryEstoque.Sql.Add(TuEvolutConst.SqlEstoque);
      vQryEstoque.ParamByName('pLoteId').Value        := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('loteid');
      vQryEstoque.ParamByName('pEnderecoId').Value    := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('enderecoid');
      vQryEstoque.ParamByName('pEstoqueTipoId').Value := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('estoquetipoid');
      vQryEstoque.ParamByName('pQuantidade').Value    := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('qtde');
      vQryEstoque.ParamByName('pUsuarioId').Value     := jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('usuarioid');
      vQryEstoque.ExecSQL;
      if jsonArrayEstoque.Items[xEstoque].GetValue<Integer>('motivosegregado') > 0 then Begin
         vQryEstoque.Close;
         vQryEstoque.Sql.Clear;
         if jsonArrayEstoque.Items[xEstoque].GetValue<String>('operacaosegregado') = '+' then Begin
            vQryEstoque.Sql.Add('Insert into SegregadoHistorico (Data, Hora, SegregadoCausaId, LoteId, EnderecoId, QtdSegregada, UsuarioId, Terminal, uuid) Values (');
            vQryEstoque.Sql.Add('       GetDate(), GetDate(), ' + jsonArrayEstoque.Items[xEstoque].GetValue<String>('motivosegregado') + ', ');
            vQryEstoque.Sql.Add('       ' + jsonArrayEstoque.Get(xEstoque).GetValue<String>('loteid') + ', ');
            vQryEstoque.Sql.Add('       ' + jsonArrayEstoque.Get(xEstoque).GetValue<String>('enderecoid') + ', ');
            vQryEstoque.Sql.Add('       ' + jsonArrayEstoque.Get(xEstoque).GetValue<String>('qtde') + ', ');
            vQryEstoque.Sql.Add('       ' + jsonArrayEstoque.Get(xEstoque).GetValue<String>('usuarioid') + ', ');
            vQryEstoque.Sql.Add('       ' + #39 + jsonArrayEstoque.Get(xEstoque).GetValue<String>('nomeestacao') + #39 + ', ');
            vQryEstoque.Sql.Add('       NewId())');
         End
         Else Begin
            vQryEstoque.Sql.Add('DECLARE @QuantidadeRestante Int = '+(jsonArrayEstoque.Get(xEstoque).GetValue<Integer>('qtde')*-1).ToString());
            vQryEstoque.Sql.Add('Declare @SegregadoCausaId   Int = '+jsonArrayEstoque.Items[xEstoque].GetValue<String>('motivosegregado'));
            vQryEstoque.Sql.Add('Declare @LoteId             Int = '+jsonArrayEstoque.Get(xEstoque).GetValue<String>('loteid'));
            vQryEstoque.Sql.Add('Declare @EnderecoId         Int = '+jsonArrayEstoque.Get(xEstoque).GetValue<String>('enderecoid'));
            vQryEstoque.Sql.Add('WHILE @QuantidadeRestante > 0 ');
            vQryEstoque.Sql.Add('BEGIN');
            vQryEstoque.Sql.Add('-- Seleciona o lançamento mais antigo com quantidade disponível');
            vQryEstoque.Sql.Add('DECLARE @SegregadoId INT, @Quantidade INT;');
            vQryEstoque.Sql.Add('SELECT TOP 1 @SegregadoId = SegregadoId, @Quantidade = qtdsegregada');
            vQryEstoque.Sql.Add('FROM segregadohistorico');
            vQryEstoque.Sql.Add('WHERE LoteId = @LoteId AND qtdsegregada > 0');
            vQryEstoque.Sql.Add('  and segregadocausaid = @SegregadoCausaId');
            vQryEstoque.Sql.Add('  and Enderecoid = @EnderecoId');
            vQryEstoque.Sql.Add('ORDER BY Data;');
            vQryEstoque.Sql.Add('IF @SegregadoId IS NULL');
            vQryEstoque.Sql.Add('BEGIN');
            vQryEstoque.Sql.Add('-- Não há mais lançamentos disponíveis para baixa');
            vQryEstoque.Sql.Add('  BREAK;');
            vQryEstoque.Sql.Add('END');
            vQryEstoque.Sql.Add('-- Calcula a quantidade a ser baixada neste lançamento');
            vQryEstoque.Sql.Add('DECLARE @QuantidadeParaBaixarNesteLancamento INT;');
            vQryEstoque.Sql.Add('SET @QuantidadeParaBaixarNesteLancamento = CASE');
            vQryEstoque.Sql.Add('    WHEN @QuantidadeRestante >= @Quantidade THEN @Quantidade');
            vQryEstoque.Sql.Add('    ELSE @QuantidadeRestante');
            vQryEstoque.Sql.Add('    END;');
            vQryEstoque.Sql.Add('-- Atualiza a quantidade no lançamento');
            vQryEstoque.Sql.Add('UPDATE segregadohistorico');
            vQryEstoque.Sql.Add('   SET qtdsegregada = qtdsegregada - @QuantidadeParaBaixarNesteLancamento');
            vQryEstoque.Sql.Add('WHERE SegregadoId = @SegregadoId;');
            vQryEstoque.Sql.Add('-- Atualiza a quantidade restante para baixar');
            vQryEstoque.Sql.Add('SET @QuantidadeRestante = @QuantidadeRestante - @QuantidadeParaBaixarNesteLancamento;');
            vQryEstoque.Sql.Add('END');
            vQryEstoque.Sql.Add('	delete segregadohistorico where qtdsegregada = 0');
         End;
         If DebugHook <> 0 Then
            vQryEstoque.Sql.SaveToFile('SegregadoHistorico.Sql');
         vQryEstoque.ExecSQL;
      End;
    End;
    JsonArrayKardex := pjsonEstoque.GetValue<TJsonArray>('kardex');
    for xKardex := 0 to Pred(JsonArrayKardex.Count) do
    Begin
      // jsonKardex := pJsonEstoque.GetValue<TJsonObject>('kardex');
      Try
        AtualizarKardex(vQryKardex, JsonArrayKardex.Get(xKardex)
          .GetValue<Integer>('operacaotipoid'), JsonArrayKardex.Get(xKardex)
          .GetValue<Integer>('loteid'), JsonArrayKardex.Get(xKardex)
          .GetValue<Integer>('enderecoid'), JsonArrayKardex.Get(xKardex)
          .GetValue<Integer>('estoquetipoid'), JsonArrayKardex.Get(xKardex)
          .GetValue<Integer>('estoquetipoiddestino'),
          JsonArrayKardex.Get(xKardex).GetValue<Integer>('quantidade'),
          JsonArrayKardex.Get(xKardex).GetValue<Integer>('enderecoiddestino'),
          JsonArrayKardex.Get(xKardex).GetValue<Integer>('usuarioid'),
          JsonArrayKardex.Get(xKardex).GetValue<String>('observacaoorigem'),
          JsonArrayKardex.Get(xKardex).GetValue<String>('observacaodestino'),
          JsonArrayKardex.Get(xKardex).GetValue<String>('nomeestacao'),
          vEstoqueInicial);
      Except ON E: Exception do
        Begin
          raise Exception.Create(E.Message);
        End;
      End;
    End;
    Result := True;
    vQryEstoque.Close;
    vQryEstoque.connection.Commit;

  Except
    ON E: Exception do
    Begin
      vQryEstoque.connection.Rollback;

      raise Exception.Create(E.Message);
    End;
  end;
end;

function TEstoqueDao.SalvarEstoqueChecklist(pJsonCheckList: TJsonObject) : TJsonArray;
var
  vQry, vQryItens: TFdQuery;
  JsonArrayCheckList: TJsonArray;
  xItens: Integer;

  vCheckListId: Integer;
  vInventarioId: Integer;
  // Dados para Inventário
  pDataLiberacao: String;
  pProcessoId: Integer;
  pJsonInventario: TJsonObject;
  pJsonArrayEndereco: TJsonArray;
  vSql: String;
  vComplemento: String;
  xEndereco: Integer;
begin
  vQry := FConexao.GetQuery;
  vQryItens := FConexao.GetQuery;
  vQry.connection.StartTransaction;
  try
    vQry.Close;
    vQry.Sql.Clear;
    vQry.Sql.Add('Declare @CheckListId Integer = 0');
    vQry.Sql.Add
      ('Insert Into EstoqueCheckList (data,	hora,	usuarioid,	terminal,	inventarioid) values (');
    vQry.Sql.Add('GetDate(), GetDate(), ' + pJsonCheckList.GetValue<Integer>
      ('usuarioid').ToString() + ', ' +
      QuotedStr(pJsonCheckList.GetValue<String>('terminal')) + ', Null)');
    vQry.Sql.Add('Set @CheckListId = SCOPE_IDENTITY()');
    vQry.Sql.Add('Select @CheckListId as CheckListId');
    vQry.Open;
    vCheckListId := vQry.FieldByName('CheckListId').AsInteger;
    JsonArrayCheckList := pJsonCheckList.GetValue<TJsonArray>('checklist');
    for xItens := 0 to Pred(JsonArrayCheckList.Count) do
    Begin
      vQryItens.Close;
      vQryItens.Sql.Clear;
      vQryItens.Sql.Add
        ('Insert Into estoquechecklistItem (checklistid,	loteid,	saldo,	contagem) values (');
      vQryItens.Sql.Add(vCheckListId.ToString() +
        ', (Select LoteId From ProdutoLotes Where ProdutoId = :pProdutoId ');
      vQryItens.Sql.Add
        ('       and DescrLote = :pDescrLote), :pQtde, :pContagem)');
      vQryItens.ParamByName('pProdutoId').Value := JsonArrayCheckList.Items
        [xItens].GetValue<Integer>('produtoid');
      vQryItens.ParamByName('pDescrLote').Value := JsonArrayCheckList.Items
        [xItens].GetValue<String>('descrlote');
      vQryItens.ParamByName('pQtde').Value := JsonArrayCheckList.Items[xItens]
        .GetValue<Integer>('qtde');
      vQryItens.ParamByName('pContagem').Value := JsonArrayCheckList.Items
        [xItens].GetValue<Integer>('qtdchecklist');
      vQryItens.ExecSQL;
    End;
    if pJsonCheckList.GetValue<TJsonObject>('inventario').Count > 0 then
    Begin
      vQry.Close;
      vQry.Close;
      vQry.Sql.Clear;
      pDataLiberacao := 'Null';
      vQry.Open('(select processoid from processoetapas where descricao = ' +
        QuotedStr('Inventario - Gerado') + ')');
      pProcessoId := vQry.FieldByName('ProcessoId').AsInteger;
      vQry.Close;
      vQry.Sql.Clear;
      pJsonInventario := pJsonCheckList.GetValue<TJsonObject>('inventario');
      if pJsonInventario.GetValue<Integer>('inventarioid') = 0 then
      Begin
        vSql := 'Declare @uuid UNIQUEIDENTIFIER = NewId()' + sLineBreak +
          'Insert Into Inventarios (inventariotipo, motivo, dataliberacao, ' +
          'tipoajuste, status, uuid) OUTPUT Inserted.InventarioId Values (' +
          sLineBreak + pJsonInventario.GetValue<Integer>('inventariotipo')
          .ToString() + ', ' +
          QuotedStr(pJsonInventario.GetValue<String>('motivo')) + ', ' +
          pDataLiberacao + ', ' + pJsonInventario.GetValue<Integer>
          ('tipoajuste').ToString() + ', ' + pJsonInventario.GetValue<Integer>
          ('status').ToString() + ', @uuid)' + sLineBreak;
      End;
      vQry.Sql.Add(vSql);
      vQry.Open;
      vInventarioId := vQry.FieldByName('InventarioId').AsInteger;
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where '
        + 'InventarioId = ' + vInventarioId.ToString() + ')');
      vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      vQry.ParamByName('pTerminal').Value := pJsonCheckList.GetValue<String>
        ('terminal');
      vQry.ParamByName('pProcessoId').Value := pProcessoId;
      vQry.ParamByName('pUsuarioId').Value := pJsonCheckList.GetValue<Integer>
        ('usuarioid');
      vQry.ExecSQL;
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Delete From InventarioItens Where InventarioId = ' +
        vInventarioId.ToString());
      vQry.ExecSQL;
      pJsonArrayEndereco := pJsonInventario.GetValue<TJsonArray>('endereco');
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add
        ('Insert into InventarioItens (InventarioId, EnderecoId, ProdutoId) Values ');
      vComplemento := '';
      For xEndereco := 0 to Pred(pJsonArrayEndereco.Count) do
      Begin
        vQry.Sql.Add('       ' + vComplemento + '(' + vInventarioId.ToString() +
          ', ' + pJsonArrayEndereco.Items[xEndereco].GetValue<Integer>
          ('enderecoid').ToString + ', Null )');
        vComplemento := ', ';
      End;
      vQry.ExecSQL;
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Delete from InventarioInicial Where inventarioid = ' +
        vInventarioId.ToString());
      vQry.Sql.Add('Insert Into InventarioInicial');
      vQry.Sql.Add('select II.InventarioId, II.enderecoid, ');
      vQry.Sql.Add
        ('       Est.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
      vQry.Sql.Add('       Coalesce(Est.QtdeProducao, 0) EstoqueInicial, ' + #39
        + 'I' + #39 + ' Status, 1 as Automatico');
      vQry.Sql.Add('from inventarioitens II');
      vQry.Sql.Add('Left Join vestoque Est on Est.EnderecoId = II.enderecoid');
      vQry.Sql.Add('where II.inventarioid = ' + vInventarioId.ToString());
      vQry.ExecSQL;
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Update EstoqueCheckList Set InventarioId = ' +
        vInventarioId.ToString());
      vQry.ExecSQL;
      pJsonInventario := Nil;
      pJsonArrayEndereco := Nil;
    End
    Else
      vInventarioId := 0; // Verificar se deve gerar inventário
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('checklistid',
      TJsonNumber.Create(vCheckListId)).AddPair('inventarioid',
      TJsonNumber.Create(vInventarioId)));
    vQry.Close;
    vQry.connection.Commit;
  Except
    ON E: Exception do
    Begin
      vQry.Close;
      vQry.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
  end;
end;


Function TEstoqueDao.TrataErroFireDac(pErro: EFDDBEngineException): String;
begin
  case pErro.Kind of
    ekOther:
      Result := pErro.Message; // 'Operação com o Banco de Dados';
    ekNoDataFound:
      Result := 'Erro! Dados não encontrados';
    ekTooManyRows:
      Result := 'Excesso de Linhas';
    ekRecordLocked:
      Result := 'Registro com acesso bloqueado. Pode está sendo usado por outro processo.';
    ekUKViolated:
      Result := 'Tentativa de incluir registro já existente.';
    ekFKViolated:
      Result := 'Cadastro primário necessário inexistente.';
    ekObjNotExists:
      Result := 'Objeto não encontrado';
    ekUserPwdInvalid:
      Result := 'Usuário e/ou Senha inválido.';
    ekUserPwdExpired:
      Result := 'Usuário e/ou Senha expirou!';
    ekUserPwdWillExpire:
      Result := 'Usuário e/ou Senha prestes a expirar';
    ekCmdAborted:
      Result := 'Operação cancelada.';
    ekServerGone:
      Result := 'Servidor de Banco de Dados inexistente.';
    ekServerOutput:
      Result := 'Servidor de Banco de Dados parece está fora do ar.';
    ekArrExecMalfunc:
      Result := 'Operação mal sucedida.';
    ekInvalidParams:
      Result := 'Parâmetros inválidos para esta operação.';
  end;
  Result := 'Processo: EnderecamentoRuas - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

function TEstoqueDao.ValidarMovimentacaoPallet(const AParams
  : TDictionary<string, string>): TJsonArray;
var
  xObjJson: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add('select LoteId From vEstoque');
    FConexao.Query.Sql.Add
      ('Where enderecoid = :pEnderecoId and ProdutoId = :pProdutoId and DescrLote <> :pLote');
    FConexao.Query.ParamByName('pEnderecoId').Value :=
      AParams.Items['enderecoid'].ToInteger;
    FConexao.Query.ParamByName('pProdutoid').Value := AParams.Items['produtoid']
      .ToInteger;
    FConexao.Query.ParamByName('pLote').Value := AParams.Items['lote'];
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('EstoqueSemPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Movimentação autorizada.'))
    Else
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não é permitido lotes diferentes do produto no mesmo Porta Pallet.'));
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: ValidarMovimentaçãoPallet - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
