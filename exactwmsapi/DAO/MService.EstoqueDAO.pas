unit MService.EstoqueDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error, Web.HTTPApp,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option, exactwmsservice.lib.utils,
  EstoqueClass, exactwmsservice.lib.connection, exactwmsservice.dao.base,
  eXactWMS_Serialize.Parallel, DataSetJSONFrameworkRTTI;

type

  TEstoqueDao = class(TBasicDao)
  private

    FOptionsJson: TJsonOptions; //
    FEstoque: TEstoque;
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
    Function GetControleArmazenagem(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetControleArmazenagemSintetico(Const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetMovimentacaoInterna(pUsuarioId: Integer;
      pDataInicial, pDataFinal: TDate; pCodProduto: Integer;
      pEnderecoOrigem, pEnderecoDestino: String;
      pArmazenagem, pMovInterna: Integer): TJsonArray;
    Function GetMotivoMovimentacaoSegregado(pAtivo: Integer): TJsonArray;
    Function ValidarMovimentacaoPallet(Const AParams : TDictionary<string, string>): TJsonArray;
    Function GetPulmaoTransferencia(pEnderecoid : Integer; pEndereco : String) : TjsonArray;
    Function PutPulmaoTransferencia(pEnderecoidOrigem, pEnderecoIdDestino : Integer) : TjsonArray;
    Function EstoqueReservaProduto(pCodProduto : Integer) : TJsonArray;
    Property ObjEstoque: TEstoque Read FEstoque Write FEstoque;
  end;

implementation

uses Constants, System.Variants; //uSistemaControl,

{ TClienteDao }

Function TEstoqueDao.AtualizarKardex(pQryKardex: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String;
  pEstoqueInicial: Integer): Boolean;
Var vQryKardex: TFdQuery;
    vTransaction: Boolean;
begin
  // Query vem preparada na Chamada da Função
  Try
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
    Except ON E: Exception do
      Begin
        raise Exception.Create(TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
   //vQryKardex.Free;
  End;
end;

function TEstoqueDao.ConsultaKardex(pUsuarioId: Integer;
  pDataInicial, pDataFinal: TDateTime; pCodigoERP: Integer;
  pNomeEstacao, pOrigem, pDestino: String): TJsonArray;
var JsonKardex: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlConsultaKardex);
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.ParamByName('pDataInicial').Value := pDataInicial;
      Query.ParamByName('pDataFinal').Value := pDataFinal;
      Query.ParamByName('pCodigoERP').Value := pCodigoERP;
      Query.ParamByName('pNomeEstacao').Value := pNomeEstacao;
      Query.ParamByName('pOrigem').Value := pOrigem;
      Query.ParamByName('pDestino').Value := pDestino;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('KardexConsulta.Sql');
      Query.Open;
      if Query.IsEmpty then
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o Kardex'));
      End
      Else
        While Not Query.Eof do Begin
          // Criar Json Manual
          JsonKardex := TJsonObject.Create;
          JsonKardex.AddPair('produtoid', TJsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
          JsonKardex.AddPair('codigoerp', TJsonNumber.Create(Query.FieldByName('CodigoERP').AsInteger));
          JsonKardex.AddPair('descricao', Query.FieldByName('Descricao').AsString);
          JsonKardex.AddPair('loteid', TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
          JsonKardex.AddPair('descrlote', Query.FieldByName('DescrLote').AsString);
          JsonKardex.AddPair('vencimento', Query.FieldByName('vencimento').AsString);
          JsonKardex.AddPair('estoquetipo', Query.FieldByName('EstoqueTipo').AsString);
          JsonKardex.AddPair('enderecoorigem', Query.FieldByName('EnderecoOrigem').AsString);
          JsonKardex.AddPair('mascaraorigem', Query.FieldByName('MascaraOrigem').AsString);
          JsonKardex.AddPair('saldoinicialorigem', Query.FieldByName('SaldoInicialOrigem').AsString);
          JsonKardex.AddPair('retirada', Query.FieldByName('Retirada').AsString);
          JsonKardex.AddPair('destino', Query.FieldByName('Destino').AsString);
          JsonKardex.AddPair('mascaradestino', Query.FieldByName('MascaraDestino').AsString);
          JsonKardex.AddPair('saldoinicialdestino', Query.FieldByName('SaldoInicialDestino').AsString);
          JsonKardex.AddPair('nomeestacao', Query.FieldByName('NomeEstacao').AsString);
          JsonKardex.AddPair('usuario', Query.FieldByName('Usuario').AsString);
          JsonKardex.AddPair('data', Query.FieldByName('Data').AsString);
          JsonKardex.AddPair('hora', Query.FieldByName('Hora').AsString);
          Result.AddElement(JsonKardex);
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: Consulta Kardex - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

constructor TEstoqueDao.Create;
begin
  FOptionsJson := [joDateIsUTC, joDateFormatISO8601];
  ObjEstoque := TEstoque.Create;
  inherited;
end;

function TEstoqueDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Estoque where LoteId= ' +
              Self.ObjEstoque.LoteId.ToString + ' and ' + 'EnderecoId = ' +
              Self.ObjEstoque.EnderecoId.ToString() + ' and EstoqueTipoId = ' +
              Self.ObjEstoque.EstoqueTipoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except
      On E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque Delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TEstoqueDao.Destroy;
begin
  ObjEstoque.Free;
  inherited;
end;

function TEstoqueDao.EstoqueReservaProduto(pCodProduto: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlEstoqueReservaProduto);
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EstoqueReservaProduto.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não há dados para gerar o relatório'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: GetControleArmazenagemSintético - '+TUtil.TratarExcessao(E.Message) );
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.Get(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId,
  pProducao, pDistribuicao: Integer; pZerado, pNegativo: String): TJsonArray;
var JsonEstoque: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEstoque);
      Query.ParamByName('pProdutoId').Value     := pProdutoId;
      Query.ParamByName('pLoteId').Value        := pLoteId;
      Query.ParamByName('pEnderecoId').Value    := pEnderecoId;
      Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
      Query.ParamByName('pProducao').Value      := pProducao;
      Query.ParamByName('pDistribuicao').Value  := pDistribuicao;
      Query.ParamByName('pZerado').Value        := pZerado;
      Query.ParamByName('pNegativo').Value      := pNegativo;
      //if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetEstoque.Sql');
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      Else
        While Not Query.Eof do Begin
          // Criar Json Manual
          JsonEstoque := TJsonObject.Create;
          JsonEstoque.AddPair('produtoid', TJsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
          JsonEstoque.AddPair('codigoerp', TJsonNumber.Create(Query.FieldByName('CodigoERP').AsInteger));
          JsonEstoque.AddPair('produto', Query.FieldByName('Produto').AsString);
          JsonEstoque.AddPair('unidadeid', TJsonNumber.Create(Query.FieldByName('UnidadeId').AsInteger));
          JsonEstoque.AddPair('unidadedecundariaid', TJsonNumber.Create(Query.FieldByName('UnidadeSecundariaId').AsInteger));
          JsonEstoque.AddPair('embprim', Query.FieldByName('UnidadeDescricao').AsString);
          JsonEstoque.AddPair('embsec', Query.FieldByName('UnidadeSecundariaDescricao').AsString);
          JsonEstoque.AddPair('qtdunid', TJsonNumber.Create(Query.FieldByName('QtdUnid').AsInteger));
          JsonEstoque.AddPair('fatorconversao', TJsonNumber.Create(Query.FieldByName('FatorConversao').AsInteger));
          JsonEstoque.AddPair('messaidaminima', TJsonNumber.Create(Query.FieldByName('MesSaidaMinima').AsInteger));
          JsonEstoque.AddPair('loteid', TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
          JsonEstoque.AddPair('descrlote', Query.FieldByName('DescrLote').AsString);
          JsonEstoque.AddPair('fabricacao', DateToStr(Query.FieldByName('Fabricacao').AsDateTime));
          JsonEstoque.AddPair('vencimento', DateToStr(Query.FieldByName('Vencimento').AsDateTime));
          JsonEstoque.AddPair('enderecoid', TJsonNumber.Create(Query.FieldByName('EnderecoId').AsInteger));
          JsonEstoque.AddPair('endereco', Query.FieldByName('Endereco').AsString);
          JsonEstoque.AddPair('estruturaid', TJsonNumber.Create(Query.FieldByName('EstruturaId').AsInteger));
          JsonEstoque.AddPair('estrutura', Query.FieldByName('Estrutura').AsString);
          JsonEstoque.AddPair('pickingfixo', TJsonNumber.Create(Query.FieldByName('PickingFixo').AsInteger));
          JsonEstoque.AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
          JsonEstoque.AddPair('zonaid', TJsonNumber.Create(Query.FieldByName('ZonaId').AsInteger));
          JsonEstoque.AddPair('zona', Query.FieldByName('Zona').AsString);
          JsonEstoque.AddPair('qtdeproducao', TJsonNumber.Create(Query.FieldByName('QtdeProducao').AsInteger));
          JsonEstoque.AddPair('qtdereserva', TJsonNumber.Create(Query.FieldByName('QtdeReserva').AsInteger));
          JsonEstoque.AddPair('qtde', TJsonNumber.Create(Query.FieldByName('Qtde').AsInteger));
          // Saldo Estoque
          JsonEstoque.AddPair('estoquetipoid', TJsonNumber.Create(Query.FieldByName('EstoqueTipoId').AsInteger));
          JsonEstoque.AddPair('estoquetipo', Query.FieldByName('EstoqueTipo').AsString);
          JsonEstoque.AddPair('producao', TJsonNumber.Create(Query.FieldByName('Producao').AsInteger));
          JsonEstoque.AddPair('distribuicao', TJsonNumber.Create(Query.FieldByName('Distribuicao').AsInteger));
          JsonEstoque.AddPair('dtentrada', Query.FieldByName('DtEntrada').AsString); //DateToStr(FConexao.Query.FieldByName('DtEntrada').AsDateTime));
          if Query.FieldByName('hrentrada').AsString = '' then
             JsonEstoque.AddPair('hrentrada', '00:00:00')
          Else
             JsonEstoque.AddPair('hrentrada', TimeToStr(StrToTime(Copy(Query.FieldByName('HrEntrada').AsString, 1, 8))));
          if Query.FieldByName('horario').AsString = '' then
             JsonEstoque.AddPair('horario', '00:00:00')
          Else
             JsonEstoque.AddPair('horario', Copy(TimeToStr(Query.FieldByName('horario').AsDateTime), 1, 8));
          // TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('horario').AsString,1,8))));
          JsonEstoque.AddPair('usuarioid', TJsonNumber.Create(Query.FieldByName('UsuarioId').AsInteger));
          JsonEstoque.AddPair('ordem', TJsonNumber.Create(Query.FieldByName('Ordem').AsInteger));
          JsonEstoque.AddPair('mascara', Query.FieldByName('Mascara').AsString);
          // Result := Query.ToJSONArray();
          Result.AddElement(JsonEstoque);
          // tJson.ObjectToJsonObject(ObjEstoque, [joDateIsUTC, joDateFormatISO8601]));
          Query.Next;
        End;
      // JsonEstoque.Free;
    Except ON E: Exception do
      Begin
        //JsonEstoque.Free;
        raise Exception.Create('Processo: Estoque - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetControleArmazenagem(Const AParams : TDictionary<string, string>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetControleArmazenagem);
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if AParams.ContainsKey('documentonr') then
          Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr']
      Else
         Query.ParamByName('pDocumentoNr').Value := '';
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('enderecoid') then
         Query.ParamByName('pEnderecoDestinoId').Value := StrToIntDef(AParams.Items['enderecoid'], 0)
      Else
         Query.ParamByName('pEnderecoDestinoId').Value := 0;
      if AParams.ContainsKey('tipomovimentacao') then
         Query.ParamByName('pTipoMovimentacao').Value := StrToIntDef(AParams.Items['tipomovimentacao'], 0)
      Else
         Query.ParamByName('pTipoMovimentacao').Value := 1;
      if AParams.ContainsKey('usuarioid') then
         Query.ParamByName('pUsuarioId').Value := StrToIntDef(AParams.Items['usuarioid'], 0)
      Else
         Query.ParamByName('pUsuarioId').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ControleArmazenagem.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: GetControleArmazenagem - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetControleArmazenagemSintetico(
  const AParams: TDictionary<string, string>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetControleArmazenagemSintetico);
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if AParams.ContainsKey('documentonr') then
         Query.ParamByName('pDocumentoNr').Value := AParams.Items['docummentonr']
      Else
         Query.ParamByName('pDocumentoNr').Value := '';
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('enderecodestinoid') then
         Query.ParamByName('pEnderecoDestinoId').Value := StrToIntDef(AParams.Items['enderecodestinoid'], 0)
      Else
         Query.ParamByName('pEnderecoDestinoId').Value := 0;
      if AParams.ContainsKey('tipomovimentacao') then
         Query.ParamByName('pTipoMovimentacao').Value := StrToIntDef(AParams.Items['tipomovimentacao'], 0)
      Else
         Query.ParamByName('pTipoMovimentacao').Value := 1;
      if AParams.ContainsKey('usuarioid') then
         Query.ParamByName('pUsuarioId').Value := StrToIntDef(AParams.Items['usuarioid'], 0)
      Else
         Query.ParamByName('pUsuarioId').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ControleArmazenagemSintetico.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: GetControleArmazenagemSintético - '+TUtil.TratarExcessao(E.Message) );
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueSemMovimentacao(
  const AParams: TDictionary<string, string>): TJsonArray;
var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEstoqueSemMovimentacao);
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaid').Value := AParams.Items['zonaid'].ToInteger
      Else
         Query.ParamByName('pZonaid').Value := 0;
      if AParams.ContainsKey('periodo') then
         Query.ParamByName('pPeriodo').Value := AParams.Items['periodo'].ToInteger
      Else
         Query.ParamByName('pPeriodo').Value := 0;
  {    if AParams.ContainsKey('enderecoinicial') then
         Query.ParamByName('pEnderecoInicial').Value := AParams.Items['enderecoinicial']
      Else
         Query.ParamByName('pEnderecoInicial').Value := '';
      if AParams.ContainsKey('enderecofinal') then
         Query.ParamByName('pEnderecoFinal').Value := AParams.Items['enderecofinal']
      Else
         Query.ParamByName('pEnderecoInicial').Value := '';
  }    If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoqueSemMovimentacao.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque sem movimentação nesse período.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque Sem Picking - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueSemPicking(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEstoqueSemPicking);
      if AParams.ContainsKey('produtoid') then
        Query.ParamByName('pProdutoid').Value := AParams.Items['produtoid'].ToInteger
      Else
        Query.ParamByName('pProdutoid').Value := 0;
      if AParams.ContainsKey('loteidid') then
         Query.ParamByName('pLoteid').Value := AParams.Items['loteid'].ToInteger
      Else
         Query.ParamByName('pLoteid').Value := 0;
      if AParams.ContainsKey('enderecoid') then
         Query.ParamByName('pEnderecoId').Value := AParams.Items['enderecoid'].ToInteger
      Else
         Query.ParamByName('pEnderecoId').Value := 0;
      if AParams.ContainsKey('estruturaid') then
         Query.ParamByName('pEstruturaid').Value := AParams.Items['estruturaid'].ToInteger
      Else
        Query.ParamByName('pEstruturaid').Value := 0;
      if AParams.ContainsKey('estoquetipoid') then
         Query.ParamByName('pEstoquetipoId').Value := AParams.Items['estoquetipoid'].ToInteger
      Else
         Query.ParamByName('pEstoquetipoId').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pzonaid').Value := AParams.Items['zonaid'].ToInteger
      Else
         Query.ParamByName('pZonaid').Value := 0;
      if AParams.ContainsKey('zerado') and (AParams.Items['zerado'] = 'N') then
         Query.Sql.Add(' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) <> 0)');
      if AParams.ContainsKey('negativo') and (AParams.Items['negativo'] = 'N') then
         Query.Sql.Add(' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) > 0)');
      if AParams.ContainsKey('prevencido') and (AParams.Items['prevencido'] = '1') then
         Query.Sql.Add(' 		      and (EET.Vencimento > GetDate() and EET.Vencimento <= GetDate()+(Select MesesParaPreVencido*30 From Configuracao))');
      if AParams.ContainsKey('vencido') and (AParams.Items['vencido'] = '1') then
         Query.Sql.Add(' 		      and (EET.Vencimento <= GetDate())');
      Query.Sql.Add('Order by Descricao');
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoqueSemPicking.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque Sem Picking - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueZona(const AParams: TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    SqlWhere: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('Declare @ProdutoId Integer  = :pProdutoId');
      Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
      Query.Sql.Add('Declare @ZonaId     Integer = :pZonaId');
  //    Query.Sql.Add('Declare @CausaId    Integer = :pCausaId');
      Query.Sql.Add('select ProdutoId, CodigoERP CodProduto, LoteId, DescrLote, Fabricacao, Vencimento, Produto Descricao, Sum(QtdeProducao) QtdeProducao, SUM(Qtde) Saldo');
      Query.Sql.Add('from vEstoque');
      Query.Sql.Add('where EstoqueTipoId in (1, 4)');
      Query.Sql.Add('  And (@ProdutoId = 0 or ProdutoId = @ProdutoId)');
      Query.Sql.Add('  And (@CodProduto = 0 or CodigoERP = @CodProduto)');
      Query.Sql.Add('  And (@ZonaId = 0 or ZonaId = @ZonaId)');
      //Query.Sql.Add('  And (@CausaId = 0 or Causadd = @CausaId)');
      Query.Sql.Add('Group by ProdutoId, CodigoERP, LoteId, DescrLote, Fabricacao, Vencimento, Produto');
      if AParams.ContainsKey('produtoid') then
         Query.ParamByName('pProdutoid').Value := StrToIntDef(AParams.Items['produtoid'], 0)
      Else
         Query.ParamByName('pProdutoid').Value := 0;
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := StrToIntDef(AParams.Items['zonaid'], 0)
      Else
         Query.ParamByName('pZonaId').Value := 0;
  //    if AParams.ContainsKey('causaid') then
  //       FConexao.Query.ParamByName('pCausaId').Value := StrToIntDef(AParams.Items['causaid'], 0)
  //    Else
  //       FConexao.Query.ParamByName('pCausaId').Value := 0;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoqueProduto.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - '+TUtil.tratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueEnderecoPorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado, pNegativo: String) : TJsonArray;
var xObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Result := TjsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEstoqueEnderecoPorTipo);
      Query.ParamByName('pProdutoId').Value := pProdutoId;
      Query.ParamByName('pLoteId').Value := pLoteId;
      Query.ParamByName('pEnderecoId').Value := pEnderecoId;
      Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
      Query.ParamByName('pProducao').Value := pProducao;
      Query.ParamByName('pDistribuicao').Value := pDistribuicao;
      Query.ParamByName('pZerado').Value := pZerado;
      Query.ParamByName('pNegativo').Value := pNegativo;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetEstoqueEnderecoPorTipo.Sql');
      Query.Open;
      if Query.IsEmpty then
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'))
      Else
        while Not Query.Eof do Begin
          // Criar Json Manual
          xObjJson := TJsonObject.Create;
          xObjJson.AddPair('produtoid', TJsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
          xObjJson.AddPair('codproduto', TJsonNumber.Create(Query.FieldByName('CodigoERP').AsInteger));
          xObjJson.AddPair('produto', Query.FieldByName('Produto').AsString);
          xObjJson.AddPair('picking', Query.FieldByName('Picking').AsString);
          xObjJson.AddPair('endereco', Query.FieldByName('Endereco').AsString);
          xObjJson.AddPair('estrutura', Query.FieldByName('Estrutura').AsString);
          xObjJson.AddPair('loteid', TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
          xObjJson.AddPair('descrlote', Query.FieldByName('DescrLote').AsString);
          xObjJson.AddPair('fabricacao', Query.FieldByName('Fabricacao').AsString);
          xObjJson.AddPair('vencimento', Query.FieldByName('Vencimento').AsString);
          // Horario
          xObjJson.AddPair('stage', TJsonNumber.Create(Query.FieldByName('Stage').AsInteger));
          xObjJson.AddPair('crossdocking', TJsonNumber.Create(Query.FieldByName('Crossdocking').AsInteger));
          xObjJson.AddPair('segregado', TJsonNumber.Create(Query.FieldByName('Segregado').AsInteger));
          xObjJson.AddPair('producao', TJsonNumber.Create(Query.FieldByName('producao').AsInteger));
          xObjJson.AddPair('expedicao', TJsonNumber.Create(Query.FieldByName('expedicao').AsInteger));
          xObjJson.AddPair('reserva', TJsonNumber.Create(Query.FieldByName('Reserva').AsInteger));
          xObjJson.AddPair('saldo', TJsonNumber.Create(Query.FieldByName('Saldo').AsInteger));
          xObjJson.AddPair('mascara', Query.FieldByName('Mascara').AsString);
          Result.AddElement(xObjJson);
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque(GetEstoqueEnderecoPorTipo) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueEnderecoPorTipoDetalhes(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if (AParams.ContainsKey('estoquetipoid')) and (AParams.Items['estoquetipoid'].ToInteger = 6) then
         Query.Sql.Add(TuEvolutConst.SqlGetEstoqueEnderecoPorTipoDetalhesReserva)
      Else
         Query.Sql.Add(TuEvolutConst.SqlGetEstoqueEnderecoPorTipoDetalhes);
      if AParams.ContainsKey('produtoid') then begin
         Query.Sql.Add(' 		      and Prd.IdProduto = :produtoid ');
         Query.ParamByName('produtoid').Value := AParams.Items['produtoid'];
      end;
      if AParams.ContainsKey('enderecoid') then begin
         Query.Sql.Add(' 		      and EET.EnderecoId = :EnderecoId');
         Query.ParamByName('enderecoid').Value := AParams.Items['enderecoid'];
      end;
      if AParams.ContainsKey('estruturaid') then begin
         Query.Sql.Add(' 		      and Ve.estruturaid = :estruturaid');
         Query.ParamByName('estruturaid').Value := AParams.Items['estruturaid'];
      end;
      if AParams.ContainsKey('estoquetipoid') then begin
         Query.SQL.Add(' 		      and Ve.EstoqueTipoId = :EstoqueTipoId');
         Query.ParamByName('estoquetipoid').Value := AParams.Items['estoquetipoid'];
      end;
      if AParams.ContainsKey('zonaid') then begin
         Query.Sql.Add(' 		      and Ve.ZonaId = :zonaid');
         Query.ParamByName('zonaid').Value := AParams.Items['zonaid'];
      end;
      if AParams.ContainsKey('zerado') and (AParams.Items['zerado'] = 'N') then
         Query.Sql.Add(' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) <> 0)');
      if AParams.ContainsKey('negativo') and (AParams.Items['negativo'] = 'N') then
         Query.Sql.Add(' 		      and ((EET.QtdEspera + EET.QtdProducao - EET.Reserva) > 0)');
      if AParams.ContainsKey('prevencido') and (AParams.Items['prevencido'] = '1') then begin
         Query.Sql.Add(' 		      and (EET.Vencimento > GetDate() and EET.Vencimento <= GetDate()+(Select MesesParaPreVencido*30 From Configuracao))');
      end;
      if AParams.ContainsKey('vencido') and (AParams.Items['vencido'] = '1') then
         Query.Sql.Add(' 		      and (EET.Vencimento <= GetDate())');
      if (AParams.ContainsKey('estoquetipoid')) then begin
         if (AParams.Items['estoquetipoid'].ToInteger <= 5) then
            Query.ParamByName('pEstoqueTipoId').Value := AParams.Items['estoquetipoid'].ToInteger;
      end
      else
         Query.ParamByName('pEstoqueTipoId').Value := 0;
      if (AParams.ContainsKey('estoquetipoid')) and (AParams.Items['estoquetipoid'].ToInteger = 6) then
         Query.Sql.Add('Order by EET.ProdutoId, EET.Endereco')
      Else Begin
        if (AParams.ContainsKey('estoquetipoid')) then Begin
           If (AParams.Items['ordem'].ToInteger = 0) then
              Query.Sql.Add('Order by Prd.CodProduto, Ve.Endereco, Mov.Data')
           Else If (AParams.Items['ordem'].ToInteger = 1) then
              Query.Sql.Add('Order by Prd.Descricao, EET.Vencimento, Ve.Endereco, Mov.Data')
           Else If (AParams.Items['ordem'].ToInteger = 2) then
              Query.Sql.Add('Order by Ve.Endereco, Prd.Descricao, EET.Vencimento, Mov.Data')
           Else If (AParams.Items['ordem'].ToInteger = 3) then
              Query.Sql.Add('Order by EET.Vencimento, Prd.Descricao, Ve.Endereco, Mov.Data')
           Else If (AParams.Items['ordem'].ToInteger = 4) then
              Query.Sql.Add('Order by Mov.Data, Prd.Descricao, EET.Vencimento, Ve.Endereco')
           Else
              Query.Sql.Add('Order by EET.ProdutoId, Ve.Endereco');
      End
      Else
         Query.Sql.Add('Order by EET.ProdutoId, Ve.Endereco'); //Parece desnecessário
      End;
      If DebugHook <> 0 Then Begin
         if (AParams.ContainsKey('estoquetipoid')) and (AParams.Items['estoquetipoid'].ToInteger = 6) then
            Query.Sql.SaveToFile('EstoqueEndTipoDetalheReserva.Sql')
         Else Query.Sql.SaveToFile('EstoqueEndTipoDetalhe.Sql');
      End;
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do Begin
         raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao: Integer; pZerado, pNegativo: String) : TJsonArray;
var xObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEstoqueLotePorTipo);
      Query.ParamByName('pProdutoId').Value := pProdutoId;
      Query.ParamByName('pLoteId').Value := pLoteId;
      Query.ParamByName('pEnderecoId').Value := pEnderecoId;
      // Query.ParamByName('pZonaId').Value        := pZonaId;
      Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
      Query.ParamByName('pProducao').Value := pProducao;
      Query.ParamByName('pDistribuicao').Value := pDistribuicao;
      Query.ParamByName('pZerado').Value := pZerado;
      Query.ParamByName('pNegativo').Value := pNegativo;
   //   if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetEstoqueLotePorTipo.Sql');
      Query.Open;
      if Query.IsEmpty then
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'))
      Else
        while Not Query.Eof do
        Begin
          // Criar Json Manual
          xObjJson := TJsonObject.Create;
          xObjJson.AddPair('produtoid', TJsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
          xObjJson.AddPair('loteid', TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
          xObjJson.AddPair('fatorconversao', TJsonNumber.Create(Query.FieldByName('FatorConversao').AsInteger));
          xObjJson.AddPair('descrlote', Query.FieldByName('DescrLote').AsString);
          xObjJson.AddPair('zonaid', TJsonNumber.Create(Query.FieldByName('ZonaId').AsInteger));
          xObjJson.AddPair('zona', Query.FieldByName('Zona').AsString);
          xObjJson.AddPair('fabricacao', Query.FieldByName('Fabricacao').AsString);
          xObjJson.AddPair('vencimento', Query.FieldByName('Vencimento').AsString);
          // Horario
          xObjJson.AddPair('stage', TJsonNumber.Create(Query.FieldByName('Stage').AsInteger));
          xObjJson.AddPair('crossdocking', TJsonNumber.Create(Query.FieldByName('Crossdocking').AsInteger));
          xObjJson.AddPair('segregado', TJsonNumber.Create(Query.FieldByName('Segregado').AsInteger));
          xObjJson.AddPair('producao', TJsonNumber.Create(Query.FieldByName('producao').AsInteger));
          xObjJson.AddPair('expedicao', TJsonNumber.Create(Query.FieldByName('expedicao').AsInteger));
          xObjJson.AddPair('reserva', TJsonNumber.Create(Query.FieldByName('Reserva').AsInteger));
          xObjJson.AddPair('saldo', TJsonNumber.Create(Query.FieldByName('Saldo').AsInteger));
          xObjJson.AddPair('dtultimamovimentacao', Query.FieldByName('DtUltimaMovimentacao').AsString);
          Result.AddElement(xObjJson);
          Query.Next;
        End;
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque(GetEstoquLotePorTipo) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetEstoqueProduto(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    SqlWhere: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('Declare @ProdutoId Integer = :pProdutoId');
      Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
      Query.Sql.Add('select ProdutoId, CodigoERP CodProduto, LoteId, DescrLote, Fabricacao, Vencimento, Produto Descricao, Sum(QtdeProducao) QtdeProducao, SUM(Qtde) Saldo');
      Query.Sql.Add('from vEstoque');
      Query.Sql.Add('where EstoqueTipoId in (1, 4)');
      Query.Sql.Add('  And (@ProdutoId = 0 or Produtoid = @ProdutoId)');
      Query.Sql.Add('  And (@CodProduto = 0 or CodigoERP = @CodProduto)');
      Query.Sql.Add('Group by ProdutoId, CodigoERP, LoteId, DescrLote, Fabricacao, Vencimento, Produto');
      if AParams.ContainsKey('produtoid') then
         Query.ParamByName('pProdutoid').Value := StrToIntDef(AParams.Items['produtoid'], 0)
      Else
         Query.ParamByName('pProdutoid').Value := 0;
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoqueProduto.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque(GetEstoqueProduto) - ' + StringReplace(E.Message,
              '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetListaTransferencia: TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Select * from vReposicaoTransferencia');
      Query.Sql.Add('Order by CodProduto, Vencimento');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EstoqueListaTransferencia.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: Consulta Kardex - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetMotivoMovimentacaoSegregado(pAtivo: Integer) : TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Declare @Ativo Integer = ' + pAtivo.ToString);
      Query.Sql.Add('Select segregadocausaid, descricao, status From SegregadoCausa');
      Query.Sql.Add('Where @Ativo >= 2 or @Ativo = Status');
      Query.Sql.Add('Order by Descricao');
      Query.Open;
      if Query.IsEmpty then
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: GetMotivoMovimentacaoSegregado - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetMovimentacaoInterna(pUsuarioId: Integer;
  pDataInicial, pDataFinal: TDate; pCodProduto: Integer;
  pEnderecoOrigem, pEnderecoDestino: String; pArmazenagem, pMovInterna: Integer) : TJsonArray;
var JsonKardex: TJsonObject;
    Query : TFdQuery;
    StartTime, time2 : TDateTime;
    ElapsedTime: Double;
    JsonString : String;

function DataSetToJsonArrayDirect(DataSet: TFdQuery): TJSONArray;
var
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i: Integer;
begin
  JSONArray := TJSONArray.Create;
  DataSet.First;
  while not DataSet.Eof do
  begin
    JSONObject := TJSONObject.Create;
    for i := 0 to DataSet.FieldCount - 1 do
      JSONObject.AddPair(DataSet.Fields[i].FieldName, VarToStr(DataSet.Fields[i].Value));
    JSONArray.AddElement(JSONObject);
    DataSet.Next;
  end;
  Result := JSONArray;
end;

begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Connection.ResourceOptions.CmdExecTimeout := 120000;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetRelMovimentacaointerna);
      If pArmazenagem = 1 then
         Query.SQL.Add('  And (K.EnderecoId = 1 And EnderecoIdDestino Is Not Null)');
      If pMovInterna = 1 then
         Query.SQL.Add('  And (K.EnderecoId <> 1 and K.EnderecoIdDestino is Not Null)');
      If pDataInicial <> 0 then Begin
         Query.SQL.Add('  And (Dmov.Data >= :pDataInicial)');
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      End;
      If pDataFinal <> 0 then Begin
         Query.SQL.Add('  And (Dmov.Data <= :pDataFinal)');
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', pDataFinal);
      End;
      If pUsuarioId > 0 then Begin
         Query.SQL.Add('  And (U.UsuarioId <= :pUsuarioId)');
         Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      End;
      If pEnderecoOrigem <> '' then Begin
         Query.SQL.Add('  And (vEndO.Endereco = :pEnderecoOrigem)');
         Query.ParamByName('pEnderecoOrigem').Value := pEnderecoOrigem;
      End;
      If pEnderecoDestino <> '' then Begin
         Query.SQL.Add('  And (vEndD.Endereco = :pEnderecoDestino)');
         Query.ParamByName('pEnderecoDestino').Value := pEnderecoDestino;
      End;
      if pCodProduto > 0 then Begin
         Query.SQL.Add('  And (Pl.CodProduto = :pCodProduto)');
         Query.ParamByName('pCodProduto').Value := pCodProduto;
      End;
      Query.SQL.Add('Order by DMov.Data, HMov.Hora');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EstoqueMovInterna.Sql');
      Query.Open;
      if Query.IsEmpty then
      Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
      End
      Else Begin
//         StartTime := Now;
//         JsonString := TOptimizedParallelJsonSerializer.SerializeParallelOptimized(Query, 5000);
//         ElapsedTime := (Now - StartTime) * 24 * 60 * 60;// * 1000;
//         ShowMessage(Format('SerializeParallelOptimized: %.2f s', [ElapsedTime]));
//         Result := TJSONObject.ParseJSONValue(JsonString) as TJSONArray;

//         StartTime := Now;
         Result := Query.ToJSONArray();
//         Result := DataSetToJsonArrayDirect(Query);
//         ElapsedTime := (Now - StartTime) * 24 * 60 * 60;// * 1000;

         //JsonString := TOptimizedParallelJsonSerializer.SerializeUltraFast(Query);   //ClaudeAI
         //Result := TJSONObject.ParseJSONValue(JsonString) as TJSONArray;

         //ChatGPT
{         Var JSONFramework: TFDQueryJSON;
         StartTime := Now;
         JSONFramework := TFDQueryJSON.Create(Query);
         Result := JSONFramework.DataSetToJsonArray;
         ElapsedTime := (Now - StartTime) * 24 * 60 * 60;// * 1000;
}
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: Movimentação Interna - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetPulmaoTransferencia(pEnderecoid: Integer; pEndereco : String): TjsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.GetPulmaoTransferencia);
      Query.ParamByName('pEnderecoId').Value := pEnderecoId;
      if pEndereco <> '0' then
         Query.ParamByName('pEndereco').Value   := pEndereco
      Else
         Query.ParamByName('pEndereco').Value   := '';
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetPulmaoTransferencia.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não há estoque em Pulmão para Transferêcia.'));
      End
      Else If Query.FieldByName('QtdeReserva').AsInteger > 0 then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Movimentação não permitida, existe reserva pendente.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetPulmaoTransferencia - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.PutPulmaoTransferencia(pEnderecoidOrigem, pEnderecoIdDestino : Integer): TjsonArray;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.PutPulmaoTransferencia);
      Query.ParamByName('pEnderecoIdOrigem').Value  := pEnderecoIdOrigem;
      Query.ParamByName('pEnderecoIdDestino').Value := pEnderecoIdDestino;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetPulmaoTransferencia.Sql');
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Transferência efetuada com sucesso!'))
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: PutPulmaoTransferencia - '+Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetRelEstoqueLotePorTipo(pProdutoId, pLoteId, pEnderecoId,
  pZonaId, pEstoqueTipoId, pProducao, pDistribuicao: Integer;
  pZerado, pNegativo: String): TJsonArray;
//var xObjJson: TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlRelEstoqueLotePorTipo);
      Query.ParamByName('pProdutoId').Value := pProdutoId;
      Query.ParamByName('pLoteId').Value := pLoteId;
      Query.ParamByName('pEnderecoId').Value := pEnderecoId;
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
      Query.ParamByName('pProducao').Value := pProducao;
      Query.ParamByName('pDistribuicao').Value := pDistribuicao;
      Query.ParamByName('pZerado').Value := pZerado;
      Query.ParamByName('pNegativo').Value := pNegativo;
      if DebugHook <> 0 then
        Query.Sql.SaveToFile('GetRelEstoqueLotePorTipo.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há estoque estoque disponível.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetRelEstoqueLotePorTipo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetRelEstoqueSaldo(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    SqlWhere: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('Select Est.*, Mov.Data DtUltimaMovimentacao');
      Query.Sql.Add('From (select CodigoERP CodProduto, Produto Descricao, SUM(Qtde) Saldo');
      Query.Sql.Add('      from vEstoque');
      Query.Sql.Add('      where EstoqueTipoId in (1, 4)');
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
         Query.Sql.Add(SqlWhere);
      Query.Sql.Add('      Group by CodigoERP, Produto) Est');
      Query.Sql.Add(TuEvolutConst.SqlRelEstoqueSaldo);
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoqueSaldo.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há Estoque disponível.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetRelEstoqueSaldo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEstoqueDao.GetRelEstoquePreOrVencido(
  const AParams: TDictionary<string, string>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlRelEstoquePreOrVencido);
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := StrToIntDef(AParams.Items['codproduto'], 0)
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := StrToIntDef(AParams.Items['zonaid'], 0)
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AParams.ContainsKey('prevencido') then
         Query.ParamByName('pPreVencido').Value := StrToIntDef(AParams.Items['prevencido'], 0)
      Else
         Query.ParamByName('pPreVencido').Value := 0;
      if AParams.ContainsKey('vencido') then
         Query.ParamByName('pVencido').Value := StrToIntDef(AParams.Items['vencido'], 0)
      Else
         Query.ParamByName('pVencido').Value := 0;
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoquePreOrVencido.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há Estoque Vencido no período informado.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Estoque(Endereço por Tipo Detalhes) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free
  End;
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
  Result := False;
  Try
    vQryEstoque := TFdQuery.Create(Nil);
    vQryEstoque.Connection := Connection;
    vQryEstoque.connection.StartTransaction;
    vQryKardex := TFdQuery.Create(Nil);
    vQryKardex.Connection := Connection;
    try
      jsonArrayEstoque := pjsonEstoque.GetValue<TJsonArray>('estoque');
      for xEstoque := 0 to Pred(jsonArrayEstoque.Count) do Begin
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
      vQryEstoque.connection.Commit;
    Except ON E: Exception do
      Begin
        vQryEstoque.connection.Rollback;
        raise Exception.Create('Processo: Estoque/Salvar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQryEstoque.Free;
    vQryKardex.Free;
  End;
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
  Try
    vQry := TFdQuery.Create(Nil);
    vQry.Connection := Connection;
    vQryItens := TFdQuery.Create(Nil);
    vQryItens.Connection := Connection;
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
      if pJsonCheckList.GetValue<TJsonObject>('inventario').Count > 0 then Begin
        vQry.Close;
        vQry.Close;
        vQry.Sql.Clear;
        pDataLiberacao := 'Null';
        vQry.Open('(select processoid from processoetapas where descricao = '+ QuotedStr('Inventario - Gerado') + ')');
        pProcessoId := vQry.FieldByName('ProcessoId').AsInteger;
        vQry.Close;
        vQry.Sql.Clear;
        pJsonInventario := pJsonCheckList.GetValue<TJsonObject>('inventario');
        if pJsonInventario.GetValue<Integer>('inventarioid') = 0 then Begin
          vSql := 'Declare @uuid UNIQUEIDENTIFIER = NewId()' + sLineBreak +
                  'Insert Into Inventarios (inventariotipo, motivo, dataliberacao, '+
                  'tipoajuste, status, uuid) OUTPUT Inserted.InventarioId Values ('+sLineBreak +
                  pJsonInventario.GetValue<Integer>('inventariotipo').ToString() + ', '+sLineBreak+
                  QuotedStr(pJsonInventario.GetValue<String>('motivo')) + ', ' +sLineBreak+
                  pDataLiberacao + ', ' + pJsonInventario.GetValue<Integer>('tipoajuste').ToString() + ', '+sLineBreak+
                  pJsonInventario.GetValue<Integer>('status').ToString() + ', @uuid)' + sLineBreak;
        End;
        vQry.Sql.Add(vSql);
        vQry.Open;
        vInventarioId := vQry.FieldByName('InventarioId').AsInteger;
        vQry.Close;
        vQry.Sql.Clear;
        vQry.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios ');
        vQry.Sql.Add('Where '+'InventarioId = ' + vInventarioId.ToString() + ')');
        vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
        vQry.ParamByName('pTerminal').Value := pJsonCheckList.GetValue<String>('terminal');
        vQry.ParamByName('pProcessoId').Value := pProcessoId;
        vQry.ParamByName('pUsuarioId').Value := pJsonCheckList.GetValue<Integer>('usuarioid');
        vQry.ExecSQL;
        vQry.Close;
        vQry.Sql.Clear;
        vQry.Sql.Add('Delete From InventarioItens Where InventarioId = ' + vInventarioId.ToString());
        vQry.ExecSQL;
        pJsonArrayEndereco := pJsonInventario.GetValue<TJsonArray>('endereco');
        vQry.Close;
        vQry.Sql.Clear;
        vQry.Sql.Add('Insert into InventarioItens (InventarioId, EnderecoId, ProdutoId) Values ');
        vComplemento := '';
        For xEndereco := 0 to Pred(pJsonArrayEndereco.Count) do Begin
           vQry.Sql.Add('       ' + vComplemento + '(' + vInventarioId.ToString() +', ');
           vQry.SQL.Add(pJsonArrayEndereco.Items[xEndereco].GetValue<Integer>('enderecoid').ToString + ', Null )');
           vComplemento := ', ';
        End;
        vQry.ExecSQL;
        vQry.Close;
        vQry.Sql.Clear;
        vQry.Sql.Add('Delete from InventarioInicial Where inventarioid = ' + vInventarioId.ToString());
        vQry.Sql.Add('Insert Into InventarioInicial');
        vQry.Sql.Add('select II.InventarioId, II.enderecoid, ');
        vQry.Sql.Add('       Est.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
        vQry.Sql.Add('       Coalesce(Est.QtdeProducao, 0) EstoqueInicial, ' + #39+ 'I' + #39 + ' Status, 1 as Automatico');
        vQry.Sql.Add('from inventarioitens II');
        vQry.Sql.Add('Left Join vestoque Est on Est.EnderecoId = II.enderecoid');
        vQry.Sql.Add('where II.inventarioid = ' + vInventarioId.ToString());
        vQry.ExecSQL;
        vQry.Close;
        vQry.Sql.Clear;
        vQry.Sql.Add('Update EstoqueCheckList Set InventarioId = ' + vInventarioId.ToString());
        vQry.ExecSQL;
        pJsonInventario := Nil;
        pJsonArrayEndereco := Nil;
      End
      Else
        vInventarioId := 0; // Verificar se deve gerar inventário
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('checklistid', TJsonNumber.Create(vCheckListId))
            .AddPair('inventarioid', TJsonNumber.Create(vInventarioId)));
      vQry.connection.Commit;
    Except ON E: Exception do
      Begin
        vQry.connection.Rollback;
        raise Exception.Create('Processo: SalvarEstoqueCheckList - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQry.Free;
    vQryItens.Free;
  End;
end;

function TEstoqueDao.ValidarMovimentacaoPallet(const AParams : TDictionary<string, string>): TJsonArray;
var xObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('select LoteId From vEstoque');
      Query.Sql.Add('Where enderecoid = :pEnderecoId and ProdutoId = :pProdutoId and DescrLote <> :pLote');
      Query.ParamByName('pEnderecoId').Value := AParams.Items['enderecoid'].ToInteger;
      Query.ParamByName('pProdutoid').Value := AParams.Items['produtoid'].ToInteger;
      Query.ParamByName('pLote').Value := AParams.Items['lote'];
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('EstoqueSemPicking.Sql');
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Movimentação autorizada.'))
      Else
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não é permitido lotes diferentes do produto no mesmo Porta Pallet.'));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ValidarMovimentaçãoPallet - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
