unit Services.SaidaIntegracao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, System.StrUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections, uFuncoes,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

Const
  SqlSaidaIntegracaoConsulta = ';With' + sLineBreak +
  // 'Ped as (Select * From VPedidos Where Status in( 2, 5)), '+sLineBreak+
    'Ped as (Select De.ProcessoId, Ped.* From VPedidos Ped' + sLineBreak +
    '        Inner Join vDocumentoEtapas De On De.Documento = ped.Uuid' + sLineBreak +
    '                                          De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) '+sLineBreak+
    '        Where Ped.Status <= 2' + sLineBreak +
    '		      and Ped.OperacaoTipoId = 2 and De.ProcessoId >= 13),'+ sLineBreak +
    'TotCheckIn as (Select PI.PedidoId, Coalesce(Sum(QtdXML), 0) QtdXml, Coalesce(Sum(QtdCheckIn), 0) QtdCheckIn, ' + sLineBreak +
    '                Coalesce(Sum(QtdDevolvida), 0) QtdDevolvida, Coalesce(Sum(QtdSegregada), 0) QtdSegregada'+sLineBreak +
    'From PedidoItens PI' + sLineBreak +
    'Inner Join Ped P ON P.PedidoId = PI.PedidoId' + sLineBreak +
    'Group by PI.PedidoId) ' + sLineBreak + 'Select P.*, TC.*' + sLineBreak +
    'From Ped P' + sLineBreak +
    'Left Join TotCheckIn TC On Tc.PedidoId = P.PedidoId'; // CheckIn Concluído

Const SqlSaidaInsert =
      'Begin Try' + sLineBreak +
      '  If Not Exists (Select PedidoId From Pedido '+sLineBreak+
      '                 Where PessoaId = @PessoaId '+sLineBreak+
      '                   and DocumentoNr = @DocumentoNr and RegistroERP = @RegistroERP) Begin'+sLineBreak +
      '     Insert Into Pedido (OperacaoTipoId, operacaonaturezaid, PessoaId, DocumentoNr, '+sLineBreak+
      '                         DocumentoOriginal, DocumentoData, DtInclusao, HrInclusao,	'+sLineBreak +
      '                         ArmazemId, RegistroERP, Status, uuid) Values (@OperacaoTipoId, '+sLineBreak+
      '                         (select operacaonaturezaid From OperacaoNatureza where Descricao = @OperacaoNatureza), '+sLineBreak +
      '                         @PessoaId, @DocumentoNr, @DocumentoOriginal, @DocumentoData, '+sLineBreak +
      '                         (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+sLineBreak +
      '                         (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),'+sLineBreak+
      '                         1, @RegistroERP, 0, NewId())'+sLineBreak +
      '     Insert Into DocumentoEtapas Values ((select uuid from pedido where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and RegistroERP = @RegistroERP), '+sLineBreak+
      '                                         1, Null, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),  ' + sLineBreak +
      '                                         (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '+sLineBreak+
      '                                         GetDate(), ' + #39 + 'IntegracaoERP' + #39 + ', 1)' +sLineBreak +
      '  End' + sLineBreak +
      '  Else Begin ' + sLineBreak +
      '     Delete from PedidoProdutos '+sLineBreak+
      '     Where PedidoId = (Select Pedidoid From Pedido Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and OperacaoTipoid = @OperacaoTipoId and RegistroERP = @RegistroERP)'+sLineBreak +
      '     Update Pedido' + sLineBreak +
      '        Set OperacaoTipoId = @OperacaoTipoId' + sLineBreak +
      '          , DocumentoData  = @DocumentoData' + sLineBreak +
      '          , ArmazemId      = 1' + sLineBreak +
      '          , RegistroERP    = @RegistroERP' + sLineBreak +
      '     Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and OperacaoTipoid = @OperacaoTipoId'+sLineBreak+
      '       and RegistroERP = @RegistroERP'+sLineBreak +
      '  End' + sLineBreak + sLineBreak +
      '  Select PedidoId From Pedido '+sLineBreak+
      '  Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and OperacaoTipoid = @OperacaoTipoId'+sLineBreak +
      'End'+sLineBreak+
      'Try Begin Catch' + sLineBreak +
      '  DECLARE @ErrorMsg NVARCHAR(4000);' + sLineBreak +
      '  DECLARE @ErrSeverity INT;' + sLineBreak +
      '  DECLARE @ErrState INT;'+sLineBreak +
      '  SELECT @ErrorMsg = Error_message(), @ErrSeverity = Error_severity(), @ErrState = Error_state(); '+sLineBreak +
      '	 RAISERROR (@ErrorMsg, @ErrSeverity, @ErrState )' +sLineBreak +
      'End Catch;';

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
  TServiceSaidaIntegracao = class(TBasicDao)
  private
    { Private declarations }

  public
    { Public declarations }
    Function Consulta: TJsonArray;
    Function ConsultaV2(pVersao: String): TJsonArray;
    function Insert(ArraySaidas: TJsonArray; pVersao: String): TJsonArray;
    Function Retorno(pPedido: String; pVersao: String): TJsonArray;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServiceSaidaIntegracao: TServiceSaidaIntegracao;

implementation

uses Constants;

{ TServiceSaidaIntegracao }

function TServiceSaidaIntegracao.Consulta: TJsonArray;
begin

end;

function TServiceSaidaIntegracao.ConsultaV2(pVersao: String): TJsonArray;
begin // Processo lento
  Try
    Result := TJsonArray.Create;
    FConexao.Query.Sql.Add(TuEvolutConst.jsonSaidaRetornoCheckInFinalizadoV2);
    FConexao.Query.ParamByName('pVersao').Value := pVersao;
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ConsutaSaidaIntegracao_Service_' + pVersao
        + '.Sql');
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('ConsultaRetorno').AsString = '') then Begin
       Result.AddElement(TJsonObject.Create.AddPair('status', IfThen(pVersao = 'V2', '200', '200')).AddPair('pedidoid',
                         TJsonNumber.Create(0)).AddPair('documentoerp', '').AddPair('mensagem', TuEvolutConst.QrySemDados));
    End
    Else Begin
      Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno').AsString), 0) as TJsonArray;
    End;
  Except On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('pedidoid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
        .AddPair('mensagem', E.Message));
    End;
  End;
end;

constructor TServiceSaidaIntegracao.Create;
begin
  inherited;
end;

destructor TServiceSaidaIntegracao.Destroy;
begin

  inherited;
end;

function TServiceSaidaIntegracao.Insert(ArraySaidas: TJsonArray;
  pVersao: String): TJsonArray;
var
  vQryInsert, vQryDestinatario: TFdQuery;
  vQryPedStatus, vQryProduto: TFdQuery;
  vQryProdutoCodBarras, vQryItens: TFdQuery;
  // FIndexConneXactWMs : Integer;
  // FConneXactWMS      : TFdConnection;
  xSaida, xItens, vSaidaId: Integer;
  jsonDestinatario: TJsonObject;
  JsonRetorno: TJsonObject;
  jsonItens: TJsonArray;
  vEmbalagemPadrao: Integer;
  vCnpj: String;
  vOperacaoNatureza, vDocumentoOriginal: String;
begin // Processo lento
  Result := TJsonArray.Create;
  if ArraySaidas = Nil then
  Begin
    JsonRetorno := TJsonObject.Create;
    JsonRetorno.AddPair('status', '500');
    JsonRetorno.AddPair('pedidoid', TJsonNumber.Create(0));
    JsonRetorno.AddPair('documentoerp', '');
    JsonRetorno.AddPair('mensagem', 'JsonArray enviado incorreto.');
    Result.AddElement(JsonRetorno);
    Exit;
  End;

  vQryInsert := FConexao.GetQuery;
  vQryDestinatario := FConexao.GetQuery;
  vQryPedStatus := FConexao.GetQuery;
  vQryProduto := FConexao.GetQuery;
  vQryProdutoCodBarras := FConexao.GetQuery;
  vQryItens := FConexao.GetQuery;
  vQryInsert.connection.StartTransaction;
  vQryInsert.connection.TxOptions.Isolation := xiReadCommitted;
  vQryInsert.Sql.Add('Insert Into JsonIntegracao Values (NewId(), ' + #39 +
    ArraySaidas.toString() + #39 + ')');
  If DebugHook <> 0 Then
    vQryInsert.Sql.SaveToFile('JsonIntegracao.Sql');
  vQryInsert.ExecSQL;
  if vQryInsert.Active then
    vQryInsert.Close;
  vQryInsert.Sql.Clear;
  for xSaida := 0 to Pred(ArraySaidas.Count) do
  Begin
    Try
      if pVersao = 'V1' then
      Begin
        vOperacaoNatureza := '';
        vDocumentoOriginal := '';
      End
      Else if pVersao = 'V2' then
      Begin
        if (AnsiIndexStr(UpperCase(ArraySaidas.Get(xSaida)
          .getValue<String>('natureza')), ['FATURA', 'PRÉ-FATURA']) >= 0) then
          vOperacaoNatureza := 'Pré-fatura'
        else
          vOperacaoNatureza := 'Ressuprimento';
        vDocumentoOriginal := ArraySaidas.Items[xSaida].getValue<String>
          ('documentooriginal');
      End;
      // Salvar Destinatário
      jsonDestinatario := ArraySaidas.Items[xSaida].getValue<TJsonObject>
        ('destinatario');
      vQryDestinatario.Sql.Add(TuEvolutConst.SqlSalvarDestinatario);
      vQryDestinatario.ParamByName('pPessoaTipoId').Value := 1;
      vQryDestinatario.ParamByName('pCodPessoaERP').Value :=
        jsonDestinatario.getValue<Integer>('destinatarioid');
      vQryDestinatario.ParamByName('pRazao').Value :=
        jsonDestinatario.getValue<String>('razao');
      vQryDestinatario.ParamByName('pFantasia').Value :=
        jsonDestinatario.getValue<String>('fantasia');
      vCnpj := jsonDestinatario.getValue<String>('cnpj');
      vQryDestinatario.ParamByName('pCnpjCpf').Value :=
        StringReplace(StringReplace(StringReplace(vCnpj, '.', '',
        [rfReplaceAll]), '-', '', [rfReplaceAll]), '/', '', [rfReplaceAll]);
      vQryDestinatario.ParamByName('pEmail').Value :=
        jsonDestinatario.getValue<String>('email');
      vQryDestinatario.ParamByName('pHomePage').Value := '';
      vQryDestinatario.ParamByName('pShelfLife').Value := 0;

      vQryDestinatario.ExecSQL;
      vQryDestinatario.Close;
      // Salvar o Pedido
      vQryPedStatus.Close;
      vQryPedStatus.Sql.Clear;
      vQryPedStatus.Sql.Add('Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = '+
                            jsonDestinatario.getValue<Integer>('destinatarioid').toString()+' and PessoaTipoId = 1)');
      vQryPedStatus.Sql.Add('Declare @DocumentoNr VarChar(20) = ' + QuotedStr(ArraySaidas.Get(xSaida).getValue<String>('documentonr')));
      vQryPedStatus.Sql.Add('Declare @RegistroERP Varchar(36) = ' + QuotedStr(ArraySaidas.Get(xSaida).getValue<String>('registroerp')));
      vQryPedStatus.Sql.Add('Select Ped.Pedidoid, DE.ProcessoId, Coalesce(Pv.StatusMin, 1) StatusMin, Coalesce(Pv.StatusMax, 1) StatusMax');
      vQryPedStatus.Sql.Add('From Pedido Ped');
      vQryPedStatus.Sql.Add('Left Join vDocumentoEtapas DE on DE.Documento = Ped.Uuid and ');
      vQryPedStatus.Sql.Add('                                 De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
      vQryPedStatus.Sql.Add('Left Join (Select Pv.PedidoId, Min(De.ProcessoId) StatusMin, Max(De.ProcessoId) StatusMax');
      vQryPedStatus.Sql.Add('           From PedidoVolumes Pv');
      vQryPedStatus.Sql.Add('		         Left Join vDocumentoEtapas DE on DE.Documento = Pv.Uuid and');
      vQryPedStatus.Sql.Add('                                            De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento )');
      vQryPedStatus.Sql.Add('		         Group By Pv.PedidoId) Pv ON Pv.PedidoId = Ped.Pedidoid');
      vQryPedStatus.Sql.Add('Where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and RegistroERP = @RegistroERP');
      vQryPedStatus.Open;
      if (Not vQryPedStatus.IsEmpty) and
        (vQryPedStatus.FieldByName('ProcessoId').AsInteger > 1) then
      Begin
        vQryPedStatus.Close;
        raise Exception.Create('Não é permitido o reenvio deste ressuprimento: '
          + ArraySaidas.Get(xSaida).getValue<String>('registroerp') + '.');

        JsonRetorno := TJsonObject.Create;
        if xSaida = 0 then
          JsonRetorno.AddPair('Retorno',
            'Erro: Não é permitido o reenvio deste ressuprimento.');
        JsonRetorno.AddPair('registroerp', ArraySaidas.Get(xSaida)
          .getValue<String>('registroerp'));
        Result.AddElement(JsonRetorno);
        vQryPedStatus.Close;

      End
      Else
      Begin;
        vQryPedStatus.Close;
        vQryInsert.Sql.Add('Declare @PedidoId Integer = ' +
          ArraySaidas.Get(xSaida).getValue<Integer>('saidaid', 0).toString());
        vQryInsert.Sql.Add
          ('Declare @OperacaoTipoId Integer = (Select OperacaoTipoId From OperacaoTipo Where Upper(Descricao) = '
          + QuotedStr(UpperCase('Saída')) + ')');
        vQryInsert.Sql.Add
          ('Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = '
          + jsonDestinatario.getValue<Integer>('destinatarioid').toString() +
          ' and PessoaTipoId = 1)');
        vQryInsert.Sql.Add('Declare @DocumentoNr VarChar(20) = ' +
          QuotedStr(ArraySaidas.Get(xSaida).getValue<String>('documentonr')));
        vQryInsert.Sql.Add
          ('Declare @DocumentoData Int = (Select IdData From Rhema_Data Where Data ='
          + #39 + ArraySaidas.Get(xSaida).getValue<String>('documentodata') +
          #39 + ')');
        vQryInsert.Sql.Add('Declare @RegistroERP Varchar(36) = ' +
          QuotedStr(ArraySaidas.Get(xSaida).getValue<String>('registroerp')));
        vQryInsert.Sql.Add('Declare @OperacaoNatureza VarChar(30) = ' +
          QuotedStr(vOperacaoNatureza));
        vQryInsert.Sql.Add('Declare @DocumentoOriginal Varchar(20)  = ' +
          QuotedStr(vDocumentoOriginal));
        vQryInsert.Sql.Add(SqlSaidaInsert);
        if DebugHook <> 0 then
          vQryInsert.Sql.SaveToFile('SaidaIns_Service.Sql');
        vQryInsert.Open;
        vSaidaId := vQryInsert.FieldByName('PedidoId').AsInteger;
        vQryInsert.Close;
        if vSaidaId > 0 then
        Begin
          jsonItens := ArraySaidas.Get(xSaida).getValue<TJsonArray>('itens');
          For xItens := 0 To Pred(jsonItens.Count) do
          Begin
            vQryProduto.Close;
            vQryProduto.Sql.Clear;
            vQryProduto.Sql.Add(TuEvolutConst.SqlInsProduto);
            vQryProduto.ParamByName('pCodProduto').Value :=
              jsonItens.Items[xItens].getValue<Integer>('produtoid', 0);
            vQryProduto.ParamByName('pDescricao').Value :=
              jsonItens.Items[xItens].getValue<String>('descricao');
            vQryProduto.ParamByName('pSiglaUnidPrimaria').Value := 'Un';
            vQryProduto.ParamByName('pQtdUnidPrimaria').Value := 1;
            vQryProduto.ParamByName('pSiglaUnidSecundaria').Value := 'Un';
            vQryProduto.ParamByName('pFatorConversao').Value :=
              jsonItens.Items[xItens].getValue<Integer>('embalagempadrao');
            vQryProduto.ParamByName('pLaboratorioId').Value := 0;
            vQryProduto.ParamByName('pPeso').Value := 1;
            vQryProduto.ParamByName('pLiquido').Value := 0;
            vQryProduto.ParamByName('pPerigoso').Value := 0;
            vQryProduto.ParamByName('pInflamavel').Value := 0;
            vQryProduto.ParamByName('pAltura').Value := 8;
            vQryProduto.ParamByName('pLargura').Value := 8;
            vQryProduto.ParamByName('pComprimento').Value := 8;
            vQryProduto.ParamByName('pEan').Value := jsonItens.Get(xItens)
              .getValue<String>('ean');
            vQryProduto.ExecSQL;
            vQryProduto.Close;
            vQryProdutoCodBarras.Close;
            vQryProdutoCodBarras.Sql.Clear;
            vQryProdutoCodBarras.Sql.Add(TuEvolutConst.SqlInsProdutoCodBarras);
            vQryProdutoCodBarras.ParamByName('pCodProdutoERP').Value :=
              jsonItens.Get(xItens).getValue<Integer>('produtoid', 0);
            vQryProdutoCodBarras.ParamByName('pCodBarras').Value :=
              jsonItens.Get(xItens).getValue<String>('ean');
            vQryProdutoCodBarras.Sql.Add('--pCodProdutoERP = ' +
              jsonItens.Get(xItens).getValue<Integer>('produtoid', 0).toString);
            vQryProdutoCodBarras.Sql.Add('--pCodBarras = ' +
              jsonItens.Get(xItens).getValue<String>('ean'));
            If DebugHook <> 0 Then
              vQryProdutoCodBarras.Sql.SaveToFile('CodBarras.Sql');
            vQryProdutoCodBarras.ExecSQL;
            vQryProdutoCodBarras.Close;
            if jsonItens.Get(xItens).getValue<Integer>('embalagempadrao', 0) >= 1
            then
              vEmbalagemPadrao := jsonItens.Get(xItens)
                .getValue<Integer>('embalagempadrao', 0)
            Else
              vEmbalagemPadrao := jsonItens.Get(xItens)
                .getValue<Integer>('embalagempadrao', 0);
            vQryItens.Close;
            vQryItens.Sql.Clear;
            vQryItens.Sql.Add(TuEvolutConst.SqlSalvarPedidoProduto);
            vQryItens.ParamByName('pPedidoId').Value := vSaidaId;
            vQryItens.ParamByName('pQuantidade').Value :=
              jsonItens.Items[xItens].getValue<Integer>('quantidade', 0);
            vQryItens.ParamByName('pEmbalagemPadrao').Value := vEmbalagemPadrao;
            vQryItens.ParamByName('pCodProduto').Value := jsonItens.Get(xItens)
              .getValue<Integer>('produtoid', 0);
            vQryItens.ParamByName('pItemId').Value :=
              StrToIntDef
              (GetValueInJson((jsonItens.Items[xItens] as TJsonObject),
              'itemid'), 0);
            // vQryItens.SQL.SaveToFile('SalvarPedidoProdutos.Sql');
            vQryItens.ExecSQL;
            vQryItens.Close;
          End;
        End;
        Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                          .AddPair('pedidoid', vSaidaId.toString).AddPair('documentoerp', ArraySaidas.Get(xSaida).getValue<String>('registroerp'))
                          .AddPair('mensagem', 'Ok!'));
      End;
      vQryInsert.connection.Commit;
    Except On E: Exception do Begin
      vQryInsert.connection.Rollback;
      vQryInsert.Close;
      JsonRetorno := TJsonObject.Create;
      JsonRetorno.AddPair('status', '500');
      JsonRetorno.AddPair('pedidoid', TJsonNumber.Create(0));
      JsonRetorno.AddPair('documentoerp', ArraySaidas.Get(xSaida).getValue<String>('registroerp'));
      JsonRetorno.AddPair('mensagem', E.Message);
      Result.AddElement(JsonRetorno);
      End;
    End;
  End;
end;

function TServiceSaidaIntegracao.Retorno(pPedido, pVersao: String): TJsonArray;
Var
  vQryRetorno, vQryRetornoVolumes, vQryRetornoLotes, vQryRegistrarRetorno : TFdQuery;
  JsonPedido, jsonDestinatario, jsonPedidoVolume, jsonPedidoProduto : TJsonObject;
  JsonPedidoLotes, tjsonPedidoVolumeLacres: TJsonObject;
  ArrayJsonVolumes, ArrayJsonProdutos, ArrayJsonLotes: TJsonArray;
  vCodProduto      : Integer;
  vQtdVolumes      : Integer;
  vPeso, vVolumem3 : Real;
  vItemIdERP       : Integer;
begin
  Result := TJsonArray.Create;
  Try
    vQryRetorno := FConexao.GetQuery;
    vQryRetornoVolumes := FConexao.GetQuery;
    vQryRetornoLotes := FConexao.GetQuery;
    vQryRegistrarRetorno := FConexao.GetQuery;
    vQryRetorno.Sql.Add(TuEvolutConst.SqlSaidaIntegracaoRetornoPedido);
    vQryRetorno.ParamByName('pPedido').Value := pPedido;
    if DebugHook <> 0 then
       vQryRetorno.Sql.SaveToFile('RetornoSaida.Sql');
    vQryRetorno.Open();
    if vQryRetorno.IsEmpty then Begin
       Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                         .AddPair('pedidoid', pPedido).AddPair('documentoerp', pPedido)
                         .AddPair('mensagem', TuEvolutConst.QrySemDados));
      Exit;
    End
    Else
      With vQryRetorno do
        While Not Eof do Begin
          JsonPedido := TJsonObject.Create;
          jsonDestinatario := TJsonObject.Create;
          jsonDestinatario.AddPair('destinatarioid', TJsonNumber.Create(vQryRetorno.FieldByName('DestinatarioId').AsInteger));
          jsonDestinatario.AddPair('razao', vQryRetorno.FieldByName('razao').AsString);
          jsonDestinatario.AddPair('fantasia', vQryRetorno.FieldByName('Fantasia').AsString);
          jsonDestinatario.AddPair('email', vQryRetorno.FieldByName('Email').AsString);
          JsonPedido.AddPair('identificacao', pVersao+'/Saidaintegracao/retorno/' + pPedido);
          JsonPedido.AddPair('pedidoid', TJsonNumber.Create(vQryRetorno.FieldByName('PedidoId').AsInteger));
          JsonPedido.AddPair('documentonr', vQryRetorno.FieldByName('DocumentoNr').AsString);
          if pVersao = 'V2' then
             JsonPedido.AddPair('documentooriginal', vQryRetorno.FieldByName('DocumentoOriginal').AsString);
          JsonPedido.AddPair('documentodata', FormatDateTime('YYYY-MM-DD', vQryRetorno.FieldByName('DocumentoData').AsDateTime));
          JsonPedido.AddPair('natureza', vQryRetorno.FieldByName('natureza').AsString);
          JsonPedido.AddPair('situacao', vQryRetorno.FieldByName('Situacao').AsString);
          JsonPedido.AddPair('registroerp', vQryRetorno.FieldByName('RegistroERP').AsString);
          JsonPedido.AddPair('destinatario', jsonDestinatario);
          vQryRetornoVolumes.Close;
          vQryRetornoVolumes.Sql.Clear;
          vQryRetornoVolumes.Sql.Add
            (TuEvolutConst.SqlSaidaIntegracaoRetornoVolume);
          vQryRetornoVolumes.ParamByName('pPedidoId').Value := vQryRetorno.FieldByName('PedidoId').AsInteger;
          vQryRetornoVolumes.Open;
          ArrayJsonVolumes := TJsonArray.Create;
          vQtdVolumes := 0;
          While Not vQryRetornoVolumes.Eof do begin
            jsonPedidoVolume := TJsonObject.Create;
            jsonPedidoVolume.AddPair('pedidovolumeid', TJsonNumber.Create(vQryRetornoVolumes.FieldByName('PedidoVolumeId').AsInteger));
            jsonPedidoVolume.AddPair('sequencia', TJsonNumber.Create(vQryRetornoVolumes.FieldByName('Sequencia').AsInteger));
            jsonPedidoVolume.AddPair('caixa', TJsonNumber.Create(vQryRetornoVolumes.FieldByName('EmbalagemId').AsInteger));
            jsonPedidoVolume.AddPair('lacres', '[]');
            // tjsonPedidoVolumeLacres);
            vQryRetornoLotes.Close;
            vQryRetornoLotes.Sql.Clear;
            vQryRetornoLotes.Sql.Add(TuEvolutConst.SqlSaidaIntegracaoRetornoVolumeLotes);
            vQryRetornoLotes.ParamByName('pPedidoVolumeId').Value := vQryRetornoVolumes.FieldByName('PedidoVolumeId').AsInteger;
            vQryRetornoLotes.Open;
            ArrayJsonProdutos := TJsonArray.Create;
            While Not vQryRetornoLotes.Eof do begin
              jsonPedidoProduto := TJsonObject.Create;
              jsonPedidoProduto.AddPair('produtoid', TJsonNumber.Create(vQryRetornoLotes.FieldByName('CodProduto').AsInteger));
              jsonPedidoProduto.AddPair('ean', vQryRetornoLotes.FieldByName('CodBarras').AsString);
              // Buscar em Query Resumo do produto
              jsonPedidoProduto.AddPair('qtdsuprida', TJsonNumber.Create(0));
              ArrayJsonLotes := TJsonArray.Create;
              vCodProduto := vQryRetornoLotes.FieldByName('CodProduto').AsInteger;
              vPeso     := 0;
              vVolumem3 := 0;
              while (not vQryRetornoLotes.Eof) and (vCodProduto = vQryRetornoLotes.FieldByName('CodProduto').AsInteger) do Begin
                jsonPedidoLotes := TJsonObject.Create;
                jsonPedidoLotes.AddPair('loteid', TJsonNumber.Create(vQryRetornoLotes.FieldByName('LoteId').AsInteger));
                jsonPedidoLotes.AddPair('descricao', vQryRetornoLotes.FieldByName('DescrLote').AsString);
                jsonPedidoLotes.AddPair('fabricacao', FormatDateTime('YYYY-MM-DD', vQryRetornoLotes.FieldByName('Fabricacao').AsDateTime));
                jsonPedidoLotes.AddPair('vencimento', FormatDateTime('YYYY-MM-DD', vQryRetornoLotes.FieldByName('vencimento').AsDateTime));
                if vQryRetornoLotes.FieldByName('QtdSuprida').AsInteger > vQryRetornoLotes.FieldByName('quantidade').AsInteger then
                   jsonPedidoLotes.AddPair('quantidade', TJsonNumber.Create(vQryRetornoLotes.FieldByName('quantidade').AsInteger))
                Else
                   jsonPedidoLotes.AddPair('QtdSuprida', TJsonNumber.Create(vQryRetornoLotes.FieldByName('QtdSuprida').AsInteger));
                jsonPedidoLotes.AddPair('embalagempadrao', TJsonNumber.Create(vQryRetornoLotes.FieldByName('embalagempadrao').AsInteger));
                jsonPedidoLotes.AddPair('quantidade', TJsonNumber.Create(vQryRetornoLotes.FieldByName('quantidade').AsInteger));
                ArrayJsonLotes.AddElement(jsonPedidoLotes);
                vPeso := vPeso + vQryRetornoLotes.FieldByName('Peso').AsFloat;
                vVolumem3 := vVolumem3 + vQryRetornoLotes.FieldByName('Volumem3').AsFloat;
                vItemIdERP := vQryRetornoLotes.FieldByName('ItemIdERP').AsInteger;
                vQryRetornoLotes.Next;
              End;
              jsonPedidoProduto.AddPair('peso', TJsonNumber.Create(vPeso));
              jsonPedidoProduto.AddPair('volume', TJsonNumber.Create(vVolumem3));
              jsonPedidoProduto.AddPair('itemid', TJsonNumber.Create(vItemIdERP));
              jsonPedidoProduto.AddPair('lotes', ArrayJsonLotes);
              // Lotes de um produto
              ArrayJsonProdutos.AddElement(jsonPedidoProduto);
              // Lista de Produtos
            end;
            jsonPedidoVolume.AddPair('produtos', ArrayJsonProdutos);
            // Lista de Produtos
            if Assigned(ArrayJsonVolumes) then
               ArrayJsonVolumes.AddElement(jsonPedidoVolume);
            Inc(vQtdVolumes);
            vQryRetornoVolumes.Next;
          end;
          // End;
          JsonPedido.AddPair('volumes', ArrayJsonVolumes);
          JsonPedido.AddPair('QtdVolume', TJsonNumber.Create(vQtdVolumes));
          Result.AddElement(JsonPedido);
          // tJson.ObjectToJsonObject(jsonRetorno, [joDateFormatISO8601]));
          if pVersao = 'V2' then Begin
            vQryRegistrarRetorno.Close;
            vQryRegistrarRetorno.Sql.Clear;
            vQryRegistrarRetorno.Sql.Add('Declare @Pedido Varchar(36) = :pPedido');
            vQryRegistrarRetorno.Sql.Add('Update Pedido Set Status = 5');
            vQryRegistrarRetorno.Sql.Add('Where (Cast(PEDIDOID as varchar(36)) = @Pedido or Cast(RegistroERP as VarChar(36)) = @Pedido)');
            vQryRegistrarRetorno.ParamByName('pPedido').Value := vQryRetorno.FieldByName('PedidoId').AsString;
            If DebugHook <> 0 Then
               vQryRegistrarRetorno.Sql.SaveToFile('RegistrarRetornoSaida.Sql');
            //vQryRegistrarRetorno.ExecSQL;
          End;
          Next;
        End;
  Except On E: Exception do Begin
    vQryRetorno.Close;
    if Assigned(vQryRetorno) then
       vQryRetorno.Free;
       Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                         .AddPair('pedidoid', pPedido).AddPair('documentoerp', pPedido)
                         .AddPair('mensagem', 'Integração Saída: Retorno - ' + StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll])));
    End;
  End;
end;

end.
