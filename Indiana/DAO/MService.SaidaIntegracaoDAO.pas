unit MService.SaidaIntegracaoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error, FireDAC.Stan.Option,
  System.StrUtils, DataSet.Serialize, System.JSON, REST.JSON,
  Generics.Collections, Web.HTTPApp, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

Const
  SqlSaidaIntegracaoConsulta = ';With' + sLineBreak +
    'Ped as (Select De.ProcessoId, Ped.* From VPedidos Ped' + sLineBreak +
    '        Inner Join vDocumentoEtapas De On De.Documento = ped.Uuid'+sLineBreak+
    '                                          De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) '+sLineBreak+
    '        Where Ped.Status <= 2 and Ped.OperacaoTipoId = 2 and De.ProcessoId >= 13),'+sLineBreak +
    'TotCheckIn as (Select PI.PedidoId, Coalesce(Sum(QtdXML), 0) QtdXml, Coalesce(Sum(QtdCheckIn), 0) QtdCheckIn, '+sLineBreak +
    '                Coalesce(Sum(QtdDevolvida), 0) QtdDevolvida, Coalesce(Sum(QtdSegregada), 0) QtdSegregada'+sLineBreak +
    'From PedidoItens PI' + sLineBreak +
    'Inner Join Ped P ON P.PedidoId = PI.PedidoId' + sLineBreak +
    'Group by PI.PedidoId) ' + sLineBreak +
    'Select P.*, TC.*' + sLineBreak +
    'From Ped P' + sLineBreak +
    'Left Join TotCheckIn TC On Tc.PedidoId = P.PedidoId'; // CheckIn Concluído

Const
  SqlSaidaInsert = 'Begin Try' + sLineBreak +
    '  If Not Exists (Select PedidoId From Pedido Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and RegistroERP = @RegistroERP) Begin'
    + sLineBreak +
    '     Insert Into Pedido (OperacaoTipoId, operacaonaturezaid, PessoaId, DocumentoNr, DocumentoOriginal, DocumentoData, DtInclusao, HrInclusao,	'
    + sLineBreak +
    '                         ArmazemId, RegistroERP, Status, uuid) Values (@OperacaoTipoId, (select operacaonaturezaid From OperacaoNatureza where Descricao = @OperacaoNatureza), '
    + sLineBreak +
    '                         @PessoaId, @DocumentoNr, @DocumentoOriginal, @DocumentoData, '
    + sLineBreak +
    '                                (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '
    + sLineBreak +
    '                                (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), 1, @RegistroERP, 0, NewId())'
    + sLineBreak +
    '     Insert Into DocumentoEtapas Values ((select uuid from pedido where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and RegistroERP = @RegistroERP), 1, '
    + sLineBreak +
    '                                         Null, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),  '
    + sLineBreak +
    '            (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '
    + sLineBreak + '            GetDate(), ' + #39 + 'IntegracaoERP' + #39 +
    ', 1)' + sLineBreak + '  End' + sLineBreak + '  Else Begin ' + sLineBreak +
    '    --Retirar o Erro Forçado abaixo por depender do Status do PEdido' +
    sLineBreak + '    --RAISERROR (' + #39 +
    'Não é permitido o reenvio deste ressuprimento.' + #39 + ', 16, 1 );' +
    sLineBreak +
    '    Delete from PedidoProdutos Where PedidoId = (Select Pedidoid From Pedido Where PessoaId = @PessoaId and '
    + sLineBreak +
    '                                     DocumentoNr = @DocumentoNr and OperacaoTipoid = @OperacaoTipoId and RegistroERP = @RegistroERP)'
    + sLineBreak + '    Update Pedido Set' + sLineBreak +
    '       OperacaoTipoId = @OperacaoTipoId' + sLineBreak +
    '      ,DocumentoData  = @DocumentoData' + sLineBreak +
    '      ,ArmazemId      = 1' + sLineBreak +
    '      , RegistroERP   = @RegistroERP' + sLineBreak +
    '    Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and OperacaoTipoid = @OperacaoTipoId and RegistroERP = @RegistroERP'
    + sLineBreak + '   End' + sLineBreak + sLineBreak +
    'Select PedidoId From Pedido Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and OperacaoTipoid = @OperacaoTipoId'
    + sLineBreak + 'End Try' + sLineBreak + 'Begin Catch' + sLineBreak +
    '  DECLARE @ErrorMsg NVARCHAR(4000);' + sLineBreak +
    '  DECLARE @ErrSeverity INT;' + sLineBreak + '  DECLARE @ErrState INT;' +
    sLineBreak +
    '  SELECT @ErrorMsg = Error_message(), @ErrSeverity = Error_severity(), @ErrState = Error_state(); '
    + sLineBreak + '	 RAISERROR (@ErrorMsg, @ErrSeverity, @ErrState )' +
    sLineBreak + 'End Catch;';

Const
  SqlSaidaItensInsert =
    'If Not Exists (Select PedidoItemId From PedidoItens Where PedidoId = @PedidoId and LoteId = @LoteId) Begin'
    + sLineBreak +
    '   Insert Into PedidoItens (PedidoId, LoteId, QtdXML, uuid) Values (@PedidoId, @LoteId, @QtdXML, 0, NewId())'
    + sLineBreak + 'End' + sLineBreak + 'Else Begin ' + sLineBreak +
    '  Update PedidoItens Set' + sLineBreak + '     QtdXML = @QtdXML' +
    sLineBreak + '  Where PedidoId = @PedidoId and LoteId = @LoteId' +
    sLineBreak + 'End;';

type

  TSaidaIntegracaoDao = class(TBasicDao)
  private

    Procedure SalvarDestinatario(pCodigo: Integer = 0; pRazao: String = '';
      pFantasia: String = ''; pCnpj: String = ''; pEmail: String = '';
      pHomePage: String = ''; FConexao: TConnection = Nil);
    Procedure SalvarProduto(pCodProduto: Integer = 0; pDescricao: String = '';
      pSiglaUnidPrimaria: String = 'Un'; pQtdUnidPrimaria: Integer = 1;
      pSiglaUnidSecundaria: String = 'Un'; pFatorConversao: Integer = 1;
      pLaboratorioId: Integer = 0; pPeso: Integer = 1; pLiquido: Integer = 0;
      pPerigoso: Integer = 0; pInflamavel: Integer = 0; pAltura: Integer = 8;
      pLargura: Integer = 8; pComprimento: Integer = 8;
      pMesEntradaMinima: Integer = 0; pMesSaidaMinima: Integer = 0;
      pEan: String = ''; FConexao: TConnection = Nil);

    Procedure SalvarProdutoCodbarras(pCodProdutoERP: Integer = 0;
      pEan: String = ''; FConexao: TConnection = Nil);

    Function SalvarSaida(pPedidoId: Integer = 0; pPessoaId: Integer = 0;
      pOperacaoNatureza: String = ''; pDocumentoNr: String = '';
      pDocumentoData: String = ''; pRegistroERP: String = '';
      pArmazemId: Integer = 0; pDocumentoOriginal: String = '';
      FConexao: TConnection = Nil): Integer;
    Procedure SalvarSaidaItens(pPedidoId, pCodProduto: Integer;
      pQuantidade: Integer; pEmbalagemPadrao: Integer; FConexao: TConnection);
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Consulta: TJsonArray;
    Function ConsultaV2: TJsonArray;
    function Insert(ArraySaidas: TJsonArray; pVersao: String): TJsonArray;
    Function Retorno(pPedido: String; pVersao: String): TJsonArray;
    Procedure RegistrarRetorno(pSaidaId: Integer);

  end;

implementation

uses uSistemaControl, Constants, uFuncoes;

{ TClienteDao }
function TSaidaIntegracaoDao.Consulta: TJsonArray;
begin
  Result := TJsonArray.Create;
  // vQry      := FConexao.CriarQuery();
  try
    FConexao.Query.Sql.Add(TuEvolutConst.jsonSaidaRetornoCheckInFinalizado);
    // SqlSaidaIntegracaoConsulta);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ConsultaSaidaRetorno.Sql');
    FConexao.Query.Open();
    if FConexao.Query.FieldByName('ConsultaRetorno').AsString = '' then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      Result := TJsonObject.ParseJSONValue
        (TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno')
        .AsString), 0) as TJsonArray;
    // jsonRetorno.Free;
  Except
    ON E: Exception do
    Begin
      // jsonRetorno.Free;
      raise Exception.Create('Processo: SaidaIntegracaoConsulta - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TSaidaIntegracaoDao.ConsultaV2: TJsonArray;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.jsonSaidaRetornoCheckInFinalizadoV2);
    // SqlSaidaIntegracaoConsulta);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ConsultaSaidaRetorno2.Sql');
    FConexao.Query.Open();
    if FConexao.Query.FieldByName('ConsultaRetorno').AsString = '' then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
    Begin
      Result := TJsonObject.ParseJSONValue
        (TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno')
        .AsString), 0) as TJsonArray;
    End;
    // jsonRetorno.Free;
  Except
    ON E: Exception do
    Begin
      // jsonRetorno.Free;
      raise Exception.Create('Processo: SaidaIntegracaoConsulta - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

constructor TSaidaIntegracaoDao.Create;
begin
  inherited;
end;

destructor TSaidaIntegracaoDao.Destroy;
begin

  inherited;
end;

function TSaidaIntegracaoDao.Insert(ArraySaidas: TJsonArray; pVersao: String) : TJsonArray;
var JsonItens: TJsonArray;
  // jsonProduto,
    jsonDestinatario: TJsonObject;
    xSaida, xItens, vSaidaId: Integer;
    vEmbalagemPadrao: Integer;
    vQryTransaction, vQryJson: TFDQuery;
    vOperacaoNatureza, vDocumentoOriginal: String;
    JsonRetorno: TJsonObject;
    FIndConeXact: Integer;
    ErroJson : String;
begin
  Result := TJsonArray.Create;
  Try
    vQryJson := FConexao.GetQuery;
    vQryJson.Sql.Add('Insert Into JsonIntegracao Values (NewId(), ' + #39 + ArraySaidas.toString() + #39 + ')');
    If DebugHook <> 0 Then
       vQryJson.Sql.SaveToFile('JsonIntegracao.Sql');
    vQryJson.ExecSQL;
  Except
     ErroJson := 'Json com Erro.';
  End;
  for xSaida := 0 to Pred(ArraySaidas.Count) do
  Begin
    Try
      vQryTransaction := FConexao.GetQuery;

      vQryTransaction.connection.StartTransaction;
      jsonDestinatario := ArraySaidas.Get(xSaida).GetValue<TJsonObject>('destinatario');
      ErroJson := 'SalvarDestinatario';
      SalvarDestinatario(jsonDestinatario.GetValue<Integer>('destinatarioid'),
                         jsonDestinatario.GetValue<String>('razao'),
                         jsonDestinatario.GetValue<String>('fantasia'),
                         jsonDestinatario.GetValue<String>('cnpj'),
                         jsonDestinatario.GetValue<String>('email'), '', FConexao);
      if pVersao = 'V1' then Begin
        vOperacaoNatureza := '';
        vDocumentoOriginal := '';
      End
      Else if pVersao = 'V2' then Begin
        if (AnsiIndexStr(UpperCase(ArraySaidas.Get(xSaida).GetValue<String>('natureza')), ['FATURA', 'PRÉ-FATURA']) >= 0) then
           vOperacaoNatureza := 'Pré-fatura'
        else
           vOperacaoNatureza := 'Ressuprimento';
        vDocumentoOriginal := ArraySaidas.Get(xSaida).GetValue<String>('documentooriginal');
      End;
      ErroJson := 'SalvarSaida';
      vSaidaId := SalvarSaida(ArraySaidas.Get(xSaida).GetValue<Integer>('saidaid', 0),
                              jsonDestinatario.GetValue<Integer>('destinatarioid'), vOperacaoNatureza,
                              ArraySaidas.Get(xSaida).GetValue<String>('documentonr'),
                              // Enviada com tratamento abaixo
                              ArraySaidas.Get(xSaida).GetValue<String>('documentodata'),
                              ArraySaidas.Get(xSaida).GetValue<String>('registroerp'), 0,
                              vDocumentoOriginal, FConexao);
      if vSaidaId > 0 then
      Begin
        JsonItens := ArraySaidas.Get(xSaida).GetValue<TJsonArray>('itens');
        For xItens := 0 To Pred(JsonItens.Count) do
        Begin
          ErroJson := 'SalvarProduto';
          SalvarProduto(JsonItens.Get(xItens).GetValue<Integer>('produtoid', 0),
            JsonItens.Get(xItens).GetValue<String>('descricao'), 'Un', 1, 'Un',
            JsonItens.Get(xItens).GetValue<Integer>('embalagempadrao'), 0, 1, 0,
            0, 0, 8, 8, 8, 0, 0, JsonItens.Get(xItens).GetValue<String>('ean'),
            FConexao);
          ErroJson := 'SalvarProdutoCodBarras';
          if StrToInt64Def(JsonItens.Get(xItens).GetValue<String>('ean'), 0) > 999999 then
             SalvarProdutoCodbarras(JsonItens.Get(xItens).GetValue<Integer>('produtoid', 0),
                                    JsonItens.Get(xItens).GetValue<String>('ean'), FConexao);
          if JsonItens.Get(xItens).GetValue<Integer>('embalagempadrao', 0) >= 1 then
             vEmbalagemPadrao := JsonItens.Get(xItens).GetValue<Integer>('embalagempadrao', 0)
          Else
             vEmbalagemPadrao := JsonItens.Get(xItens).GetValue<Integer>('embalagempadrao', 0);
          ErroJson := 'SalvarSaidaItens';
          SalvarSaidaItens(vSaidaId, JsonItens.Get(xItens)
            .GetValue<Integer>('produtoid', 0), JsonItens.Get(xItens)
            .GetValue<Integer>('quantidade', 0), vEmbalagemPadrao, FConexao);
        End;
        vQryTransaction.connection.Commit;
        JsonRetorno := TJsonObject.Create;
        if xSaida = 0 then
          JsonRetorno.AddPair('Retorno', 'Sucesso.');
        JsonRetorno.AddPair('SaidaId', vSaidaId.toString);
        Result.AddElement(JsonRetorno);
      End
      Else
      Begin
        vQryTransaction.connection.Rollback;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('SaidaId',
                          'Documento('+ArraySaidas.Get(xSaida).GetValue<String>('documentonr')+ ') não pode ser reenviado! ')));
      End;
    Except On E: Exception do
      Begin
        vQryTransaction.connection.Rollback;
        raise Exception.Create('Processo: SaidaIntegracaos: ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll])+ErroJson);
      End;
    end;
  End;
End;

procedure TSaidaIntegracaoDao.RegistrarRetorno(pSaidaId: Integer);
begin
  Try
    FConexao.Query.Sql.Add('Update Pedido Set Status = 5 Where PedidoId = ' +
      pSaidaId.toString());
    // Registrar Retorno em DocumentoEtapas
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: SaidaIntegracao - RegistrarRetorno: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TSaidaIntegracaoDao.Retorno(pPedido: String; pVersao: String)
  : TJsonArray;
var
  VQryPed, vQryPedVolumes, vQryPedidoLotes: TFDQuery;
  jsonPedido, jsonDestinatario, jsonPedidoVolume, jsonPedidoProduto
    : TJsonObject;
  jsonPedidoLotes, tjsonPedidoVolumeLacres: TJsonObject;
  ArrayJsonVolumes, ArrayJsonProdutos, ArrayJsonLotes: TJsonArray;
  vCodProduto, vQtdVolumes: Integer;
  vPeso, vVolumem3: Real;
begin
  Result := TJsonArray.Create;
  VQryPed := FConexao.GetQuery;
  vQryPedVolumes := FConexao.GetQuery;
  vQryPedidoLotes := FConexao.GetQuery;
  try
    VQryPed.Sql.Add(TuEvolutConst.SqlSaidaIntegracaoRetornoPedido);
    VQryPed.ParamByName('pPedido').Value := pPedido;
    if DebugHook <> 0 then
      VQryPed.Sql.SaveToFile('RetornoSaida.Sql');
    FConexao.Query.Open();
    Result := TJsonArray.Create();
    if VQryPed.isEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    With VQryPed do
      While Not Eof do
      Begin
        jsonPedido := TJsonObject.Create;

        jsonDestinatario := TJsonObject.Create;
        jsonDestinatario.AddPair('destinatarioid',
          tjsonNumber.Create(VQryPed.FieldByName('DestinatarioId').AsInteger));
        jsonDestinatario.AddPair('razao', VQryPed.FieldByName('razao')
          .AsString);
        jsonDestinatario.AddPair('fantasia', VQryPed.FieldByName('Fantasia')
          .AsString);
        // jsonDestinatario.AddPair('cnpj', vQryPed.FieldByName('cnpj').AsString);
        jsonDestinatario.AddPair('email', VQryPed.FieldByName('Email')
          .AsString);
        jsonPedido.AddPair('identificacao',
          pVersao + '/saidaintegracao/retorno/' + pPedido);
        jsonPedido.AddPair('pedidoid',
          tjsonNumber.Create(VQryPed.FieldByName('PedidoId').AsInteger));
        jsonPedido.AddPair('documentonr', VQryPed.FieldByName('DocumentoNr')
          .AsString);
        if pVersao = 'V2' then
          jsonPedido.AddPair('documentooriginal',
            VQryPed.FieldByName('DocumentoOriginal').AsString);
        jsonPedido.AddPair('documentodata', FormatDateTime('YYYY-MM-DD',
          VQryPed.FieldByName('DocumentoData').AsDateTime));
        jsonPedido.AddPair('natureza', VQryPed.FieldByName('natureza')
          .AsString);
        jsonPedido.AddPair('situacao', VQryPed.FieldByName('Situacao')
          .AsString);
        jsonPedido.AddPair('registroerp', VQryPed.FieldByName('RegistroERP')
          .AsString);
        jsonPedido.AddPair('destinatario', jsonDestinatario);
        vQryPedVolumes.Close;
        vQryPedVolumes.Sql.Clear;
        vQryPedVolumes.Sql.Add(TuEvolutConst.SqlSaidaIntegracaoRetornoVolume);
        vQryPedVolumes.ParamByName('pPedidoId').Value :=
          VQryPed.FieldByName('PedidoId').AsInteger;
        vQryPedVolumes.Open;
        ArrayJsonVolumes := TJsonArray.Create;
        vQtdVolumes := 0;
        While Not vQryPedVolumes.Eof do
        begin
          // tjsonPedidoVolumeLacres := tjsonObject.Create;
          jsonPedidoVolume := TJsonObject.Create;
          // if assigned(jsonpedidovolume) then
          // jsonPedidoVolume.AddPair('nome', 'genilson');
          jsonPedidoVolume.AddPair('pedidovolumeid',
            tjsonNumber.Create(vQryPedVolumes.FieldByName('PedidoVolumeId')
            .AsInteger));
          jsonPedidoVolume.AddPair('sequencia',
            tjsonNumber.Create(vQryPedVolumes.FieldByName('Sequencia')
            .AsInteger));
          jsonPedidoVolume.AddPair('caixa',
            tjsonNumber.Create(vQryPedVolumes.FieldByName('EmbalagemId')
            .AsInteger));
          jsonPedidoVolume.AddPair('lacres', '[]'); // tjsonPedidoVolumeLacres);
          vQryPedidoLotes.Close;
          vQryPedidoLotes.Sql.Clear;
          vQryPedidoLotes.Sql.Add
            (TuEvolutConst.SqlSaidaIntegracaoRetornoVolumeLotes);
          vQryPedidoLotes.ParamByName('pPedidoVolumeId').Value :=
            vQryPedVolumes.FieldByName('PedidoVolumeId').AsInteger;
          vQryPedidoLotes.Open;
          ArrayJsonProdutos := TJsonArray.Create;
          While Not vQryPedidoLotes.Eof do
          begin
            jsonPedidoProduto := TJsonObject.Create;
            jsonPedidoProduto.AddPair('produtoid',
              tjsonNumber.Create(vQryPedidoLotes.FieldByName('CodProduto')
              .AsInteger));
            jsonPedidoProduto.AddPair('ean',
              vQryPedidoLotes.FieldByName('CodBarras').AsString);
            // Buscar em Query Resumo do produto
            jsonPedidoProduto.AddPair('qtdsuprida', tjsonNumber.Create(0));
            ArrayJsonLotes := TJsonArray.Create;
            vCodProduto := vQryPedidoLotes.FieldByName('CodProduto').AsInteger;
            vPeso := 0;
            vVolumem3 := 0;
            while (not vQryPedidoLotes.Eof) and
              (vCodProduto = vQryPedidoLotes.FieldByName('CodProduto')
              .AsInteger) do
            Begin
              jsonPedidoLotes := TJsonObject.Create;
              jsonPedidoLotes.AddPair('loteid',
                tjsonNumber.Create(vQryPedidoLotes.FieldByName('LoteId')
                .AsInteger));
              jsonPedidoLotes.AddPair('descricao',
                vQryPedidoLotes.FieldByName('DescrLote').AsString);
              jsonPedidoLotes.AddPair('fabricacao', FormatDateTime('YYYY-MM-DD',
                vQryPedidoLotes.FieldByName('Fabricacao').AsDateTime));
              jsonPedidoLotes.AddPair('vencimento', FormatDateTime('YYYY-MM-DD',
                vQryPedidoLotes.FieldByName('vencimento').AsDateTime));
              if vQryPedidoLotes.FieldByName('QtdSuprida').AsInteger >
                vQryPedidoLotes.FieldByName('embalagempadrao').AsInteger then
                jsonPedidoLotes.AddPair('QtdSuprida',
                  tjsonNumber.Create(vQryPedidoLotes.FieldByName('Quantidade')
                  .AsInteger))
              Else
                jsonPedidoLotes.AddPair('QtdSuprida',
                  tjsonNumber.Create(vQryPedidoLotes.FieldByName('QtdSuprida')
                  .AsInteger));
              jsonPedidoLotes.AddPair('embalagempadrao',
                tjsonNumber.Create(vQryPedidoLotes.FieldByName
                ('embalagempadrao').AsInteger));
              jsonPedidoLotes.AddPair('quantidade',
                tjsonNumber.Create(vQryPedidoLotes.FieldByName('quantidade')
                .AsInteger));
              ArrayJsonLotes.AddElement(jsonPedidoLotes);
              vPeso := vPeso + vQryPedidoLotes.FieldByName('Peso').AsFloat;
              vVolumem3 := vVolumem3 + vQryPedidoLotes.FieldByName
                ('Volumem3').AsFloat;
              vQryPedidoLotes.Next;
            End;
            jsonPedidoProduto.AddPair('peso', tjsonNumber.Create(vPeso));
            jsonPedidoProduto.AddPair('volume', tjsonNumber.Create(vVolumem3));
            jsonPedidoProduto.AddPair('itemid',
              tjsonNumber.Create(vQryPedidoLotes.FieldByName('ItemIdERP')
              .AsInteger));
            jsonPedidoProduto.AddPair('lotes', ArrayJsonLotes);
            // Lotes de um produto
            ArrayJsonProdutos.AddElement(jsonPedidoProduto);
            // Lista de Produtos
          end;
          jsonPedidoVolume.AddPair('produtos', ArrayJsonProdutos);
          // Lista de Produtos
          if assigned(ArrayJsonVolumes) then
            ArrayJsonVolumes.AddElement(jsonPedidoVolume);
          Inc(vQtdVolumes);
          vQryPedVolumes.Next;

        end;
        // End;
        jsonPedido.AddPair('volumes', ArrayJsonVolumes);
        jsonPedido.AddPair('QtdVolume', tjsonNumber.Create(vQtdVolumes));
        Result.AddElement(jsonPedido);
        // tJson.ObjectToJsonObject(jsonRetorno, [joDateFormatISO8601]));
        Next;
      End;
    // ClipBoard.AsText := Result.ToString();
    RegistrarRetorno(VQryPed.FieldByName('PedidoId').AsInteger);

    //
    jsonPedido := Nil;
    jsonPedido.DisposeOf;
  Except
    ON E: Exception do
    Begin
      VQryPed.Close;

      //
      raise Exception.Create('Processo: SaidaIntegracaosRetorno - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Function TSaidaIntegracaoDao.SalvarSaida(pPedidoId, pPessoaId: Integer;
  pOperacaoNatureza, pDocumentoNr, pDocumentoData: String; pRegistroERP: String;
  pArmazemId: Integer; pDocumentoOriginal: String;
  FConexao: TConnection): Integer;
Var
  vQry: TFDQuery;
  vQryPedStatus: TFDQuery;
begin
  vQry := FConexao.GetQuery;
  vQryPedStatus := FConexao.GetQuery;
  Try
    vQryPedStatus.Close;
    vQryPedStatus.Sql.Clear;
    vQryPedStatus.Sql.Add('Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = ' + pPessoaId.toString() + ' and PessoaTipoId = 1)');
    vQryPedStatus.Sql.Add('Declare @DocumentoNr VarChar(20) = ' + QuotedStr(pDocumentoNr));
    vQryPedStatus.Sql.Add('Declare @RegistroERP Varchar(36) = ' + QuotedStr(pRegistroERP));
    vQryPedStatus.Sql.Add('Select Ped.Pedidoid, DE.ProcessoId, Coalesce(Pv.StatusMin, 1) StatusMin, Coalesce(Pv.StatusMax, 1) StatusMax');
    vQryPedStatus.Sql.Add('From Pedido Ped');
    vQryPedStatus.Sql.Add('Left Join vDocumentoEtapas DE on DE.Documento = Ped.Uuid and ');
    vQryPedStatus.Sql.Add('                                 De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
    vQryPedStatus.Sql.Add('Left Join (Select Pv.PedidoId, Min(De.ProcessoId) StatusMin, Max(De.ProcessoId) StatusMax');
    vQryPedStatus.Sql.Add('           From PedidoVolumes Pv');
    vQryPedStatus.Sql.Add('		         Left Join vDocumentoEtapas DE on DE.Documento = Pv.Uuid And');
    vQryPedStatus.Sql.Add('                                            De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
    vQryPedStatus.Sql.Add('		         Group By Pv.PedidoId) Pv ON Pv.PedidoId = Ped.Pedidoid');
    vQryPedStatus.Sql.Add('Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and RegistroERP = @RegistroERP');
    If DebugHook <> 0 Then
       vQryPedStatus.Sql.SaveToFile('IntegracaoSaida_PedStatus.Sql');
    vQryPedStatus.Open;
    if (Not vQryPedStatus.isEmpty) and (vQryPedStatus.FieldByName('ProcessoId').AsInteger > 1) then
       raise Exception.Create('Não é permitido o reenvio deste ressuprimento: ' + pRegistroERP + '.');
    vQryPedStatus.Close;
    vQryPedStatus.Sql.Clear;
    vQry.Sql.Add('Declare @PedidoId Integer = ' + pPedidoId.toString());
    vQry.Sql.Add('Declare @OperacaoTipoId Integer = (Select OperacaoTipoId From OperacaoTipo Where Upper(Descricao) = '+QuotedStr(UpperCase('Saída')) + ')');
    vQry.Sql.Add('Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = ' + pPessoaId.toString() + ' and PessoaTipoId = 1)');
    vQry.Sql.Add('Declare @DocumentoNr VarChar(20) = ' + QuotedStr(pDocumentoNr));
    vQry.Sql.Add('Declare @DocumentoData Int = (Select IdData From Rhema_Data Where Data =' + #39 + pDocumentoData + #39 + ')');
    vQry.Sql.Add('Declare @RegistroERP Varchar(36) = ' + QuotedStr(pRegistroERP));
    vQry.Sql.Add('Declare @OperacaoNatureza VarChar(30) = ' + QuotedStr(pOperacaoNatureza));
    vQry.Sql.Add('Declare @DocumentoOriginal Varchar(20)  = ' + QuotedStr(pDocumentoOriginal));
    vQry.Sql.Add(SqlSaidaInsert);
    If DebugHook <> 0 Then
       vQry.Sql.SaveToFile('SaidaIns.Sql');
    vQry.Open;
    Result := vQry.FieldByName('PedidoId').AsInteger;
    vQry.Close;;
  Except ON E: Exception do
    Begin
      vQry.Close;

      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

procedure TSaidaIntegracaoDao.SalvarSaidaItens(pPedidoId, pCodProduto: Integer;
  pQuantidade: Integer; pEmbalagemPadrao: Integer; FConexao: TConnection);
Var
  vQryItens: TFDQuery;
begin
  Try
    vQryItens := FConexao.GetQuery;
    vQryItens.Sql.Add(TuEvolutConst.SqlSalvarPedidoProduto);
    vQryItens.ParamByName('pPedidoId').Value := pPedidoId;
    vQryItens.ParamByName('pQuantidade').Value := pQuantidade;
    vQryItens.ParamByName('pEmbalagemPadrao').Value := pEmbalagemPadrao;
    vQryItens.ParamByName('pCodProduto').Value := pCodProduto;
    vQryItens.ParamByName('pItemid').Value     := 0;
    if DebugHook <> 0 then
       vQryItens.Sql.SaveToFile('IntSaida_PedidoItens.Sql');
    vQryItens.ExecSQL;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: SaidaIntegracaos - PedidoItens: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Procedure TSaidaIntegracaoDao.SalvarDestinatario(pCodigo: Integer;
  pRazao, pFantasia, pCnpj, pEmail, pHomePage: String; FConexao: TConnection);
Var
  vQry: TFDQuery;
begin
  vQry := FConexao.GetQuery;
  Try
    vQry.Sql.Add(TuEvolutConst.SqlSalvarDestinatario);
    vQry.ParamByName('pPessoaTipoId').Value := 1;
    vQry.ParamByName('pCodPessoaERP').Value := pCodigo;
    vQry.ParamByName('pRazao').Value := pRazao;
    vQry.ParamByName('pFantasia').Value := pFantasia;
    vQry.ParamByName('pCnpjCpf').Value :=
      StringReplace(StringReplace(StringReplace(pCnpj, '.', '', [rfReplaceAll]),
      '-', '', [rfReplaceAll]), '/', '', [rfReplaceAll]);
    vQry.ParamByName('pEmail').Value := pEmail;
    vQry.ParamByName('pHomePage').Value := pHomePage;
    vQry.ParamByName('pShelfLife').Value := 0;
    vQry.ExecSQL;
    vQry.Close;

  Except
    ON E: Exception do
    Begin

      raise Exception.Create('Processo: SaidaIntegracao - Destinatario: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

procedure TSaidaIntegracaoDao.SalvarProduto(pCodProduto: Integer;
  pDescricao, pSiglaUnidPrimaria: String; pQtdUnidPrimaria: Integer;
  pSiglaUnidSecundaria: String; pFatorConversao, pLaboratorioId, pPeso,
  pLiquido, pPerigoso, pInflamavel, pAltura, pLargura, pComprimento,
  pMesEntradaMinima, pMesSaidaMinima: Integer; pEan: String;
  FConexao: TConnection);
Var
  vQry: TFDQuery;
begin
  vQry := FConexao.GetQuery;
  Try
    vQry.Sql.Add(TuEvolutConst.SqlInsProduto);
    vQry.ParamByName('pCodProduto').Value          := pCodProduto;
    vQry.ParamByName('pDescricao').Value           := pDescricao;
    vQry.ParamByName('pSiglaUnidPrimaria').Value   := pSiglaUnidPrimaria;
    vQry.ParamByName('pQtdUnidPrimaria').Value     := pQtdUnidPrimaria;
    vQry.ParamByName('pSiglaUnidSecundaria').Value := pSiglaUnidSecundaria;
    vQry.ParamByName('pFatorConversao').Value      := pFatorConversao;
    vQry.ParamByName('pLaboratorioId').Value       := pLaboratorioId;
    vQry.ParamByName('pPeso').Value                := pPeso;
    vQry.ParamByName('pLiquido').Value             := pLiquido;
    vQry.ParamByName('pPerigoso').Value            := pPerigoso;
    vQry.ParamByName('pInflamavel').Value := pInflamavel;
    vQry.ParamByName('pAltura').Value := pAltura;
    vQry.ParamByName('pLargura').Value := pLargura;
    vQry.ParamByName('pComprimento').Value := pComprimento;
    vQry.ParamByName('pEan').Value := pEan;
    vQry.ExecSQL;
    vQry.Close;
  Except ON E: Exception do Begin
      vQry.Close;
      raise Exception.Create('Processo: SaidaIntegracaos - Produtos: ' + StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

procedure TSaidaIntegracaoDao.SalvarProdutoCodbarras(pCodProdutoERP: Integer;
  pEan: String; FConexao: TConnection);
Var
  vQry: TFDQuery;
begin
  vQry := FConexao.GetQuery;
  Try
    vQry.Sql.Add(TuEvolutConst.SqlInsProdutoCodBarras);
    vQry.ParamByName('pCodProdutoERP').Value := pCodProdutoERP;
    vQry.ParamByName('pCodBarras').Value := pEan;
    vQry.ExecSQL;
    vQry.Close;

  Except
    ON E: Exception do
    Begin
      vQry.Close;

      raise Exception.Create('Processo: SaidaIntegracas - Código de Barras(' +
        pCodProdutoERP.toString() + '): ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
