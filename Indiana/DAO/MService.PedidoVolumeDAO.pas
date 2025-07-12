unit MService.PedidoVolumeDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option,
  PedidoVolumeClass, Web.HTTPApp, exactwmsservice.lib.utils,
  exactwmsservice.lib.connection, exactwmsservice.dao.base;

type

  TPedidoVolumeDao = class(TBasicDao)
  private

    FPedidoVolume: TPedidoVolume;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
    Function AtualizarKardex(pQuery: TFdQuery;
      pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pEstoqueTipoIdDestino, pQuantidade, pEnderecoIdDestino,
      pUsuarioId: Integer; pObservacaoOrigem, pObservacaoDestino,
      pNomeEstacao: String; pEstoqueInicial: Integer): Boolean;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function RegistrarDocumentoEtapa(pJsonDocumentoEtapa: TJsonObject) : TJsonArray;
    Function RegistrarDocumentoEtapaComBaixaEstoque(pJsonDocumentoEtapa : TJsonObject): TJsonArray;
    Function Salvar: Boolean;
    Function GetVolume(pPedidoId, pPedidoVolumeId, pSequencia, pOrdem: Integer; pEmbalagem: String): TJsonArray;
    Function GetVolumeProduto(pPedidoVolumeId: Integer): TJsonArray;
    Function GetVolumeProdutoReconferencia(pPedidoVolumeId: Integer) : TJsonArray;
    Function GetVolumeProdutoSeparacao(pPedidoVolumeId: Integer): TJsonArray;
    Function GetVolumeLote(pPedidoVolumeId: Integer): TJsonArray;
    Function GetPedidoVolumeEtapas(pPedidoVolumeId: Integer): TJsonArray;
    Function GetVolumeProdutoLotes(pPedidoVolumeId, pProdutoid: Integer) : TJsonArray;
    function GetPedidoVolumeSeparacao(pPedidoId: Integer; pPedidoVolumeId: Integer): TJsonArray;
    Function VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId: Integer) : TJsonArray;
    Function EtiquetaPorVolume(pPedidoVolumeId: Integer): TJsonArray;
    Function identificavolumecxafechada(pPedidoVolumeId: Integer): TJsonArray;
    Function Cancelar(pConexao: TFDConnection; pJsonObject: TJsonObject) : TJsonArray;
    Function Delete: Boolean;
    Function MapaSeparacao(pPedidoId: Integer; pPedidoVolumeId: Integer) : TJsonArray;
    Function VolumeExpedicao: TJsonArray;
    Function VolumeExpedido: TJsonArray;
    Function AtualizarConferencia(pJsonArray: TJsonArray; pConneXactWMS: TFDConnection): TJsonArray;
    Function AtualizarConferenciaSemLotes(pJsonArray: TJsonArray; pConneXactWMS: TFDConnection): TJsonArray;
    Function FinalizarConferenciaComRegistro(pJsonObjectFinalizar: TJsonObject; pConneXactWMS: TFDConnection): TJsonArray;
    Function GerarVolumeExtra(pPedidoVolumeId, pUsuarioId: Integer): TJsonArray;
    Function SaveApanheProdutos(pJsonArray: TJsonArray): TJsonArray;
    Function MapaSeparacaoLista(const AParams: TDictionary<string, string>) : TJsonArray;
    Function DshCheckOut(Const AParams: TDictionary<String, String>) : TJsonArray;
    function GetProducaoDiariaPorLoja(const AParams : TDictionary<String, String>): TJsonObject;
    Function GetProducaoDiariaPorRota(Const AParams : TDictionary<String, String>): TJsonObject;
    Function GetProducaoDiariaPorRua(Const AParams: TDictionary<String, String>) : TJsonObject;
    Function GetProducaoDiariaPorSetor(Const AParams : TDictionary<String, String>): TJsonObject;
    Function GetVolumeConsulta(Const AParams: TDictionary<String, String>) : TJsonArray;
    Function GetVolumeConsultaLotes(Const AParams: TDictionary<String, String>) : TJsonArray;

    Property ObjPedidoVolume: TPedidoVolume Read FPedidoVolume Write FPedidoVolume;
  end;

implementation

uses uSistemaControl, Constants, MService.EstoqueDAO;

{ TClienteDao }

constructor TPedidoVolumeDao.Create;
begin
  ObjPedidoVolume := TPedidoVolume.Create;
  inherited;
end;

function TPedidoVolumeDao.Delete: Boolean;
var
  vSql: String;
  FIndexConnExact: Integer;
begin
  Result := False;
  try
    vSql := 'Delete from PedidoVolumes where PedidoVolumeId= ' +
      Self.ObjPedidoVolume.PedidoVolumeId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumes - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPedidoVolumeDao.Destroy;
begin
  ObjPedidoVolume.Free;
  inherited;
end;

function TPedidoVolumeDao.DshCheckOut(const AParams : TDictionary<String, String>): TJsonArray;
var ObjJson: TJsonObject;
    vDataIni, vDataFin: TDateTime;
    vParamsOk: Integer;
begin
  vDataIni := 0;
  vDataFin := 0;
  vParamsOk := 0;
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlDshCheckOut);
    if AParams.ContainsKey('datainicialpedido') then
    Begin
      Try
        Fconexao.Query.ParamByName('pDataInicialpedido').Value :=
          StrToDate(AParams.Items['datainicialpedido']);
        vParamsOk := vParamsOk + 1;
      Except
        Begin
          Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
            'Data Inicial dos Pedidos é inválida!')));
          Exit;
        End;
      End;
    End
    Else
      Fconexao.Query.ParamByName('pDataInicialPedido').Value := 0;
    if AParams.ContainsKey('datafinalpedido') then
    Begin
      Try
        Fconexao.Query.ParamByName('pDataFinalPedido').Value :=
          StrToDate(AParams.Items['datafinalpedido']);
        vParamsOk := vParamsOk + 1;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data Final dos Pedidos é inválida!')));
        Exit;
      End;
    End
    Else
      Fconexao.Query.ParamByName('pDataFinalPedido').Value := 0;
    if AParams.ContainsKey('datainicialproducao') then
    Begin
      Try
        Fconexao.Query.ParamByName('pDataInicialproducao').Value :=
          StrToDate(AParams.Items['datainicialproducao']);
        vParamsOk := vParamsOk + 1;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data Inicial da Produção é inválida!')));
        Exit;
      End;
    End
    Else
      Fconexao.Query.ParamByName('pDataInicialProducao').Value := 0;
    if AParams.ContainsKey('datafinalproducao') then
    Begin
      Try
        Fconexao.Query.ParamByName('pDataFinalProducao').Value :=
          StrToDate(AParams.Items['datafinalproducao']);
        vParamsOk := vParamsOk + 1;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data Final da Produção é inválida!')));
        Exit;
      End;
    End
    Else
      Fconexao.Query.ParamByName('pDataFinalProducao').Value := 0;
    if AParams.ContainsKey('usuarioid') then
      Fconexao.Query.ParamByName('pUsuarioId').Value := AParams.Items['usuarioid'].ToInteger()
    Else
      Fconexao.Query.ParamByName('pUsuarioId').Value := 0;
    if AParams.ContainsKey('embalagemid') then
       Fconexao.Query.ParamByName('pEmbalagemId').Value := AParams.Items['embalagemid'].ToInteger()
    Else
      Fconexao.Query.ParamByName('pEmbalagemId').Value := 99;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('DhsCheckOut.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
    End
    else
    Begin
      // TDataSetSerializeConfig.GetInstance.DateInputIsUTC := True;
      // TDataSetSerializeConfig.GetInstance.Export.FormatDateTime := 'yyyy-mm-dd hh:nn:ss.zzz';
      Result := Fconexao.Query.ToJSONArray();
    End;
  Except
    ON E: Exception do
    Begin

      raise Exception.Create('Tabela: DshCheckOut - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

// Identificação Etiqueta Volume Caixa Fracionada
function TPedidoVolumeDao.EtiquetaPorVolume(pPedidoVolumeId: Integer) : TJsonArray;
var ObjJson: TJsonObject;
begin
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlEtiquetaPorVolume);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    If DebugHook <> 0 then
       Fconexao.Query.Sql.SaveToFile('EtiquetaPorVolumeFrac.Sql');
    Fconexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
    End
    Else
       Result := FConexao.Query.ToJSONArray()
  Except On E: Exception do
    Begin
      raise Exception.Create('Tabela: Mapa Separação - '+
            StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoVolumeDao.FinalizarConferenciaComRegistro(pJsonObjectFinalizar : TJsonObject; pConneXactWMS: TFDConnection): TJsonArray;
Var xProd, vQtdConferida: Integer;
    VQry, vQryAtualiza: TFdQuery;
    FIndexConnExact: Integer;
    pNewConnection: Boolean;
    pJsonArray: TJsonArray;
    vVolumeIdExtra: Integer;
    vPedidoVolumeId: Integer;
    JsonArrayVolumeExtra: TJsonArray;
begin
  vVolumeIdExtra := 0;
  pJsonArray := pJsonObjectFinalizar.GetValue<TJsonArray>('itens');
  vPedidoVolumeId := pJsonArray.Items[0].GetValue<Integer>('pedidovolumeid');
  pNewConnection := False;
  if pConneXactWMS = Nil then Begin
     pConneXactWMS := Fconexao.DB;
     pNewConnection := True;
  End;
  VQry := TFdQuery.Create(Nil);
  try
    VQry.connection := pConneXactWMS;
    If pNewConnection Then
       VQry.connection.StartTransaction;
    vQryAtualiza := Fconexao.GetQuery;

    Result := TJsonArray.Create();
    VQry.Sql.Add('select Prd.IdProduto ProdutoId, Prd.CodProduto, Vl.LoteId, Vl.EnderecoId, Vl.Quantidade, Vl.QtdSuprida');
    VQry.Sql.Add('From PedidoVolumeLotes VL');
    VQry.Sql.Add('Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId');
    VQry.Sql.Add('Inner Join Produto Prd on Prd.IdProduto = Pl.ProdutoId');
    VQry.Sql.Add('Where Prd.CodProduto = :pCodProduto and Vl.PedidoVolumeId = :pPedidoVolumeId');
    vQryAtualiza.Sql.Add('Update PedidoVolumeLotes ');
    vQryAtualiza.Sql.Add('   Set QtdSuprida  = :pQtdSuprida');
    vQryAtualiza.Sql.Add('Where LoteId = :pLoteId and PedidoVolumeId = :pPedidoVolumeId');
    vQryAtualiza.Sql.Add('Insert Into PedidoOperacao (pedidovolumeid, loteid, enderecoid, quantidade,	qtdsuprida,	processoetapaid,');
    vQryAtualiza.Sql.Add('                           	data,	hora,	usuarioid,	estacao) Values ');
    vQryAtualiza.Sql.Add('                           (:poperpedidovolumeid, :poperloteid, :poperenderecoid, :poperquantidade,	:poperqtdsuprida,	');
    vQryAtualiza.Sql.Add('                           	(Select Processoid from ProcessoEtapas where Descricao = :poperprocessoetapa), :poperdata,	:poperhora,	:poperusuarioid,	:poperestacao)');
    Try
      for xProd := 0 to Pred(pJsonArray.Count) do Begin
        VQry.Close();
        VQry.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
        VQry.ParamByName('pPedidoVolumeId').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
        VQry.Open;
        vQtdConferida := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
        // Quantidade Suprida
        While (Not VQry.Eof) do Begin // and (vQtdConferida>0)
          vQryAtualiza.Close;
          vQryAtualiza.ParamByName('pPedidoVolumeId').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteid').Value := VQry.FieldByName('LoteId').AsInteger;
          if vQtdConferida >= VQry.FieldByName('Quantidade').AsInteger then Begin
             vQryAtualiza.ParamByName('pQtdSuprida').Value := VQry.FieldByName('Quantidade').AsInteger;
             vQtdConferida := vQtdConferida - VQry.FieldByName('Quantidade').AsInteger;
             vQryAtualiza.ParamByName('poperquantidade').Value := VQry.FieldByName('Quantidade').AsInteger;
          End
          Else Begin;
             vQryAtualiza.ParamByName('pQtdSuprida').Value := vQtdConferida;
             vQryAtualiza.ParamByName('poperquantidade').Value := vQtdConferida;
             vQryAtualiza.ParamByName('poperqtdsuprida').Value := vQtdConferida;
             vQtdConferida := 0;
          End;
          // Gravar acompanhamento da operacao para análise de resultados
          vQryAtualiza.ParamByName('poperPedidoVolumeId').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('poperLoteid').Value := VQry.FieldByName('LoteId').AsInteger;
          vQryAtualiza.ParamByName('poperEnderecoid').Value := VQry.FieldByName('EnderecoId').AsInteger;
          // pJsonArray.Items[xProd].GetValue<Integer>('enderecoid');
          vQryAtualiza.ParamByName('poperquantidade').Value := VQry.FieldByName('Quantidade').AsInteger;
          vQryAtualiza.ParamByName('poperqtdsuprida').Value := pJsonArray.Items[xProd].GetValue<Integer>('quantidade');
          vQryAtualiza.ParamByName('poperUsuarioId').Value := pJsonArray.Items[xProd].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pOperData').Value := FormatdateTime('YYYY-MM-DD', StrToDate(pJsonArray.Items[xProd].GetValue<String>('data')));
          // pJsonArray.Items[xProd].GetValue<String>('data'); //
          vQryAtualiza.ParamByName('pOperHora').Value := pJsonArray.Items[xProd].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('poperestacao').Value := pJsonArray.Items[xProd].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('poperprocessoetapa').Value := pJsonArray.Items[xProd].GetValue<String>('processoetapa');

          If DebugHook <> 0 Then
             vQryAtualiza.Sql.SaveToFile('AtualizacaoReservar.Sql');
          vQryAtualiza.ExecSQL;
          VQry.Next
        End;
      End;
      //Atualizar a Caixa/Baget usada no volume
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Declare @PedidoVolumeId Integer = '+vPedidoVolumeId.ToString());
      vQry.Sql.Add('Declare @CaixaEmbalagemId Integer = IsNull((Select CaixaEmbalagemId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId And CaixaEmbalagemId Is Not Null), 0)');
      vQry.Sql.Add('if @CaixaEmbalagemId > 0');
      vQry.Sql.Add('Begin');
      vQry.Sql.Add('    Update CaixaEmbalagem');
      vQry.Sql.Add('    Set PedidoVolumeId = CASE');
      vQry.Sql.Add('                            WHEN CaixaEmbalagemId = @CaixaEmbalagemId THEN @PedidoVolumeId');
      vQry.Sql.Add('                            ELSE NULL');
      vQry.Sql.Add('                         END');
      vQry.Sql.Add('    Where PedidoVolumeId = @PedidoVolumeId OR CaixaEmbalagemId = @CaixaEmbalagemId');
      vQry.Sql.Add('End');
      vQry.ExecSQL;

      // Gerar Volume Extra
      if pJsonObjectFinalizar.GetValue<Integer>('volumeextra') = 1 then Begin
         // JsonArrayVolumeExtra := GerarVolumeExtra(vPedidoVolumeId, pJsonObjectFinalizar.GetValue<Integer>('usuarioid'));
         VQry.Close;
         VQry.Sql.Clear;
         VQry.Sql.Add(TuEvolutConst.SqlGerarVolumeExtra);
         VQry.ParamByName('pPedidoVolumeId').Value := vPedidoVolumeId;
         VQry.ParamByName('pUsuarioId').Value := pJsonObjectFinalizar.GetValue<Integer>('usuarioid');
         VQry.Open;
         vVolumeIdExtra := VQry.FieldByName('PedidoVolumeId').AsInteger;
      End;
      VQry.Close;
      VQry.Sql.Clear;
      VQry.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '+ 'PedidoVolumeId = '+vPedidoVolumeId.ToString() + ')');
      VQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      VQry.ParamByName('pProcessoId').Value := pJsonObjectFinalizar.GetValue<Integer>('processoid');
      VQry.ParamByName('pUsuarioId').Value  := pJsonObjectFinalizar.GetValue<Integer>('usuarioid');
      VQry.ParamByName('pTerminal').Value   := pJsonObjectFinalizar.GetValue<String>('terminal');
      VQry.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('volumeextra', tjsonNumber.Create(vVolumeIdExtra)));
      if pNewConnection then
         VQry.connection.commit;
      VQry.Close;
    Except ON E: Exception do
      Begin
        If pNewConnection Then
           VQry.connection.Rollback;
        VQry.Close;
        vQryAtualiza.Close;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Atualizar Conferência - ' + TUtil.TratarExcessao(E.Message))));
      End;
    end;
  finally
    FreeAndNil(VQry)
  end;
end;

// http://www.linhadecodigo.com.br/artigo/666/trabalhando-com-isolation-level-e-hints.aspx
function TPedidoVolumeDao.AtualizarConferencia(pJsonArray: TJsonArray;
  pConneXactWMS: TFDConnection): TJsonArray;
Var
  xProd, vQtdConferida: Integer;
  VQry, vQryAtualiza: TFdQuery;
  FIndexConnExact: Integer;
  pNewConnection: Boolean;
  vErro: String;
begin
  try
    pNewConnection := False;
    if pConneXactWMS = Nil then Begin
       pConneXactWMS := Fconexao.DB;
       pNewConnection := True;
    End;
    vQry := Fconexao.GetQuery;
    vQry.connection := pConneXactWMS;
    If pNewConnection Then
       vQry.connection.StartTransaction;
    vQryAtualiza := Fconexao.GetQuery;
    vQryAtualiza.connection := pConneXactWMS;
    Result := TJsonArray.Create();
    vQry.Sql.Add('select Prd.IdProduto ProdutoId, Prd.CodProduto, Vl.LoteId, Vl.EnderecoId, Vl.Quantidade, Vl.QtdSuprida');
    vQry.Sql.Add('From PedidoVolumeLotes VL');
    vQry.Sql.Add('Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId');
    vQry.Sql.Add('Inner Join Produto Prd on Prd.IdProduto = Pl.ProdutoId');
    vQry.Sql.Add('Where Prd.CodProduto = :pCodProduto and Vl.PedidoVolumeId = :pPedidoVolumeId');
    // Baixa de Estoque deve ocorrer pela reserva
    vQryAtualiza.Sql.Add('Update Estoque');
    vQryAtualiza.Sql.Add('  Set Qtde = Qtde - E.QtdSuprida + :pQtdeRes');
    vQryAtualiza.Sql.Add('From');
    vQryAtualiza.Sql.Add('  (Select LoteId, EnderecoId, QtdSuprida');
    vQryAtualiza.Sql.Add('   From PedidoVolumeLotes');
    vQryAtualiza.Sql.Add('   Where LoteId = :pLoteIdRes and PedidoVolumeId = :pPedidoVolumeIdRes ) E');
    vQryAtualiza.Sql.Add('Where 1 = 2 and Estoque.LoteId = :pLoteIdEst and Estoque.EnderecoId = E.EnderecoId and  Estoque.EstoqueTipoId = 6');

    vQryAtualiza.Sql.Add('Update PedidoVolumeLotes ');
    vQryAtualiza.Sql.Add('   Set QtdSuprida = :pQtdSuprida');
    vQryAtualiza.Sql.Add('     , DtInclusao = (Select IdData From Rhema_Data where Data = :pDtSeparacao)');
    vQryAtualiza.Sql.Add('     , HrInclusao = (Select IdHora From Rhema_Hora where Hora = Substring(:pHrSeparacao, 1, 5))');
    vQryAtualiza.Sql.Add('     , UsuarioId  = :pUsuarioid');
    vQryAtualiza.Sql.Add('     , Terminal   = :pTerminal');
    vQryAtualiza.Sql.Add('Where LoteId = :pLoteId and PedidoVolumeId = :pPedidoVolumeId');

    vQryAtualiza.Sql.Add('Insert Into PedidoOperacao (pedidovolumeid, loteid, enderecoid, quantidade,	qtdsuprida,	processoetapaid,');
    vQryAtualiza.Sql.Add('                           	data,	hora,	usuarioid,	estacao) Values ');
    vQryAtualiza.Sql.Add('                            (:poperpedidovolumeid, :poperloteid, :poperenderecoid, :poperquantidade,	:poperqtdsuprida,	');
    vQryAtualiza.Sql.Add('                           	(Select Processoid from ProcessoEtapas where Descricao = :poperprocessoetapa), :poperdata,	:poperhora,	:poperusuarioid,	:poperestacao)');
    Try
      for xProd := 0 to Pred(pJsonArray.Count) do
      Begin
        if pJsonArray.Items[xProd].TryGetValue('enderecoid', vErro) then Begin
           vQryAtualiza.Sql.Add('update PedidoVolumeSeparacao Set EnderecoId = '+pJsonArray.Items[xProd].GetValue<Integer>('enderecoid').ToString);
           vQryAtualiza.Sql.Add('Where PedidoVOlumeId = ' + pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid').ToString);
        End;
        vQry.Close();
        vQry.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
        vQry.ParamByName('pPedidoVolumeId').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
        vQry.Open;
        vQtdConferida := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
        While (Not vQry.Eof) do Begin // and (vQtdConferida>0)
          vQryAtualiza.Close;
          vQryAtualiza.ParamByName('pLoteIdRes').Value          := pJsonArray.Items[xProd].GetValue<Integer>('loteid');
          vQryAtualiza.ParamByName('pPedidoVolumeIdRes').Value  := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteIdEst').Value          := pJsonArray.Items[xProd].GetValue<Integer>('loteid');
          vQryAtualiza.ParamByName('pPedidoVolumeId').Value     := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteid').Value             := pJsonArray.Items[xProd].GetValue<Integer>('loteid');
          vQryAtualiza.ParamByName('pUsuarioId').Value          := pJsonArray.Items[xProd].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pDtSeparacao').Value        := FormatdateTime('YYYY-MM-DD', StrToDate(pJsonArray.Items[xProd].GetValue<String>('data')));
          vQryAtualiza.ParamByName('pHrSeparacao').Value        := pJsonArray.Items[xProd].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('pTerminal').Value           := pJsonArray.Items[xProd].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('pQtdeRes').Value            := pJsonArray.Items[xProd].GetValue<Integer>('demanda'); // vQtdConferida;
          vQryAtualiza.ParamByName('pQtdSuprida').Value         := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
          vQryAtualiza.ParamByName('poperquantidade').Value     := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
          vQryAtualiza.ParamByName('poperqtdsuprida').Value     := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
          vQtdConferida := 0;
          vQryAtualiza.ParamByName('poperPedidoVolumeId').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('poperLoteid').Value         := pJsonArray.Items[xProd].GetValue<Integer>('loteid');
          vQryAtualiza.ParamByName('poperEnderecoid').Value     := pJsonArray.Items[xProd].GetValue<Integer>('enderecoid');
          vQryAtualiza.ParamByName('poperquantidade').Value     := pJsonArray.Items[xProd].GetValue<Integer>('demanda');
          vQryAtualiza.ParamByName('poperqtdsuprida').Value     := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
          vQryAtualiza.ParamByName('poperUsuarioId').Value      := pJsonArray.Items[xProd].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pOperData').Value           := FormatdateTime('YYYY-MM-DD', StrToDate(pJsonArray.Items[xProd].GetValue<String>('data')));
          vQryAtualiza.ParamByName('pOperHora').Value           := pJsonArray.Items[xProd].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('poperestacao').Value        := pJsonArray.Items[xProd].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('poperprocessoetapa').Value  := pJsonArray.Items[xProd].GetValue<String>('processoetapa');
          If DebugHook <> 0 then
             vQryAtualiza.Sql.SaveToFile('AtualizacaoReserva.Sql');
          vQryAtualiza.ExecSQL;
          vQry.Next
        End;
      End;
      if pNewConnection then
         vQry.connection.commit;
      vQry.Close;
      vQryAtualiza.Close;
    Except
      ON E: Exception do
      Begin
        If pNewConnection Then
          VQry.connection.Rollback;
        VQry.Close;
        vQryAtualiza.Close;

        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Atualizar Conferência - ' + StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]))))
      End;
    end;
  finally
    VQry.Close;
    vQryAtualiza.Close;
  end;
end;

function TPedidoVolumeDao.AtualizarConferenciaSemLotes(pJsonArray: TJsonArray;
  pConneXactWMS: TFDConnection): TJsonArray;
Var
  xProd, vQtdConferida: Integer;
  VQry, vQryAtualiza: TFdQuery;
  FIndexConnExact: Integer;
  pNewConnection: Boolean;
begin
  pNewConnection := False;

  if pConneXactWMS = Nil then
  Begin
    pConneXactWMS := Fconexao.DB;
    pNewConnection := True;
  End;
  VQry := TFdQuery.Create(Nil);
  try
    VQry.connection := pConneXactWMS;
    If pNewConnection Then
    Begin
      VQry.connection.StartTransaction;
    End;
    vQryAtualiza := Fconexao.GetQuery;
    vQryAtualiza.connection := pConneXactWMS;
    Result := TJsonArray.Create();
    VQry.Sql.Add
      ('select Prd.IdProduto ProdutoId, Prd.CodProduto, Vl.LoteId, Vl.EnderecoId, Vl.Quantidade, Vl.QtdSuprida');
    VQry.Sql.Add('From PedidoVolumeLotes VL');
    VQry.Sql.Add('Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId');
    VQry.Sql.Add('Inner Join Produto Prd on Prd.IdProduto = Pl.ProdutoId');
    VQry.Sql.Add
      ('Where Prd.CodProduto = :pCodProduto and Vl.PedidoVolumeId = :pPedidoVolumeId');

    // vQryAtualiza.Sql.Add('Update Estoque');
    // vQryAtualiza.Sql.Add('  Set Qtde = Qtde - E.QtdSuprida + :pQtdeRes');
    // vQryAtualiza.Sql.Add('From');
    // vQryAtualiza.Sql.Add('  (Select LoteId, EnderecoId, QtdSuprida');
    // vQryAtualiza.Sql.Add('   From PedidoVolumeLotes');
    // vQryAtualiza.Sql.Add('   Where LoteId = :pLoteIdRes and PedidoVolumeId = :pPedidoVolumeIdRes ) E');
    // vQryAtualiza.Sql.Add('Where 1 = 2 and Estoque.LoteId = :pLoteIdEst and Estoque.EnderecoId = E.EnderecoId and  Estoque.EstoqueTipoId = 6');

    vQryAtualiza.Sql.Add('Update PedidoVolumeLotes ');
    vQryAtualiza.Sql.Add('   Set QtdSuprida  = :pQtdSuprida');
    // vQryAtualiza.Sql.Add('      , DtInclusao = (Select IdData From Rhema_Data where Data = :pDtSeparacao)');
    // vQryAtualiza.SQL.Add('      , HrInclusao = (Select IdHora From Rhema_Hora where Hora = Substring(:pHrSeparacao, 1, 5))');
    // vQryAtualiza.SQL.Add('      , UsuarioId  = :pUsuarioid');
    // vQryAtualiza.SQL.Add('      , Terminal   = :pTerminal');
    vQryAtualiza.Sql.Add
      ('Where LoteId = :pLoteId and PedidoVolumeId = :pPedidoVolumeId');

    vQryAtualiza.Sql.Add
      ('Insert Into PedidoOperacao (pedidovolumeid, loteid, enderecoid, quantidade,	qtdsuprida,	processoetapaid,');
    vQryAtualiza.Sql.Add
      ('                           	data,	hora,	usuarioid,	estacao) Values ');
    vQryAtualiza.Sql.Add
      ('                           (:poperpedidovolumeid, :poperloteid, :poperenderecoid, :poperquantidade,	:poperqtdsuprida,	');
    vQryAtualiza.Sql.Add
      ('                           	(Select Processoid from ProcessoEtapas where Descricao = :poperprocessoetapa), :poperdata,	:poperhora,	:poperusuarioid,	:poperestacao)');
    Try
      for xProd := 0 to Pred(pJsonArray.Count) do
      Begin
        VQry.Close();
        VQry.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd]
          .GetValue<Integer>('codproduto');
        VQry.ParamByName('pPedidoVolumeId').Value := pJsonArray.Items[xProd]
          .GetValue<Integer>('pedidovolumeid');
        /// vQry.SQL.SaveToFile('GetVolumeLote.Sql');
        VQry.Open;
        vQtdConferida := pJsonArray.Items[xProd].GetValue<Integer>
          ('qtdsuprida');
        // Quantidade Suprida
        While (Not VQry.Eof) do
        Begin // and (vQtdConferida>0)
          vQryAtualiza.Close;
          // vQryAtualiza.ParamByName('pLoteIdRes').Value         := vQry.FieldByName('LoteId').AsInteger;
          // vQryAtualiza.ParamByName('pPedidoVolumeIdRes').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          // vQryAtualiza.ParamByName('pLoteIdEst').Value         := vQry.FieldByName('LoteId').AsInteger;

          vQryAtualiza.ParamByName('pPedidoVolumeId').Value :=
            pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteid').Value :=
            VQry.FieldByName('LoteId').AsInteger;
          // vQryAtualiza.ParamByName('pUsuarioId').Value    := pJsonArray.Items[xProd].GetValue<Integer>('usuarioid');
          // vQryAtualiza.ParamByName('pDtSeparacao').Value  := FormatdateTime('YYYY-MM-DD', StrToDate(pJsonArray.Items[xProd].GetValue<String>('data')));  //pJsonArray.Items[xProd].GetValue<String>('data'); //
          // vQryAtualiza.ParamByName('pHrSeparacao').Value  := pJsonArray.Items[xProd].GetValue<String>('horariotermino');
          // vQryAtualiza.ParamByName('pTerminal').Value     := pJsonArray.Items[xProd].GetValue<String>('terminal');

          if vQtdConferida >= VQry.FieldByName('Quantidade').AsInteger then
          Begin
            // vQryAtualiza.ParamByName('pQtdeRes').Value    := vQry.FieldByName('Quantidade').AsInteger;
            vQryAtualiza.ParamByName('pQtdSuprida').Value :=
              VQry.FieldByName('Quantidade').AsInteger;
            vQtdConferida := vQtdConferida - VQry.FieldByName('Quantidade')
              .AsInteger;
            vQryAtualiza.ParamByName('poperquantidade').Value :=
              VQry.FieldByName('Quantidade').AsInteger;

          End
          Else
          Begin;
            // vQryAtualiza.ParamByName('pQtdeRes').Value        := vQtdConferida;
            vQryAtualiza.ParamByName('pQtdSuprida').Value := vQtdConferida;
            vQryAtualiza.ParamByName('poperquantidade').Value := vQtdConferida;
            vQryAtualiza.ParamByName('poperqtdsuprida').Value := vQtdConferida;

            vQtdConferida := 0;
          End;
          // Gravar acompanhamento da operacao para análise de resultados
          vQryAtualiza.ParamByName('poperPedidoVolumeId').Value :=
            pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('poperLoteid').Value :=
            VQry.FieldByName('LoteId').AsInteger;
          vQryAtualiza.ParamByName('poperEnderecoid').Value :=
            VQry.FieldByName('EnderecoId').AsInteger;
          // pJsonArray.Items[xProd].GetValue<Integer>('enderecoid');
          vQryAtualiza.ParamByName('poperquantidade').Value :=
            VQry.FieldByName('Quantidade').AsInteger;
          vQryAtualiza.ParamByName('poperqtdsuprida').Value :=
            pJsonArray.Items[xProd].GetValue<Integer>('quantidade');
          vQryAtualiza.ParamByName('poperUsuarioId').Value :=
            pJsonArray.Items[xProd].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pOperData').Value :=
            FormatdateTime('YYYY-MM-DD',
            StrToDate(pJsonArray.Items[xProd].GetValue<String>('data')));
          // pJsonArray.Items[xProd].GetValue<String>('data'); //
          vQryAtualiza.ParamByName('pOperHora').Value := pJsonArray.Items[xProd]
            .GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('poperestacao').Value :=
            pJsonArray.Items[xProd].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('poperprocessoetapa').Value :=
            pJsonArray.Items[xProd].GetValue<String>('processoetapa');

          If DebugHook <> 0 Then
            vQryAtualiza.Sql.SaveToFile('AtualizacaoReservar.Sql');
          vQryAtualiza.ExecSQL;
          VQry.Next
          { If (vQtdConferida = 0 and (Not vQry.Eof)) then Begin
            while Not vQry.Eof do
            vQry.Next;
            End;
          } End;
      End;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Checkout registrado com sucesso!'));
      if pNewConnection then
        VQry.connection.commit;
      VQry.Close;
    Except
      ON E: Exception do
      Begin
        If pNewConnection Then
          VQry.connection.Rollback;
        VQry.Close;

        vQryAtualiza.Close;

        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Atualizar Conferência - ' + StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]))))
      End;
    end;
  finally
    VQry.Close;
    vQryAtualiza.Close;
    FreeAndNil(VQry);
  end;

end;

function TPedidoVolumeDao.Cancelar(pConexao: TFDConnection;
  pJsonObject: TJsonObject): TJsonArray;
var
  PedidoVolumeDAO: TJsonArray;
  vTransacao: Boolean;
  pNewConexao: Boolean;
  Qry: TFdQuery;
begin
  Result := TJsonArray.Create;
  if pConexao = Nil then
  Begin
    pConexao := Fconexao.DB;
    pNewConexao := True;
  End
  Else
    pNewConexao := False;
  vTransacao := False;
  Qry := TFdQuery.Create(Nil);
  Qry.connection := pConexao;
  Try
    If Not Fconexao.Query.connection.InTransaction then
    Begin
      Fconexao.Query.connection.StartTransaction;
      vTransacao := True;
    End;
    try
      Fconexao.Query.Sql.Add('Declare @PedidoId Integer = ' +pJsonObject.GetValue<Integer>('pedidoId').ToString());
      Fconexao.Query.Sql.Add('Declare @PedidoVolumeId Integer = '+pJsonObject.GetValue<Integer>('pedidoVolumeId').ToString());
      Fconexao.Query.Sql.Add('Declare @UsuarioId Integer    = '+pJsonObject.GetValue<Integer>('usuarioid').ToString());
      Fconexao.Query.Sql.Add('Declare @Terminal VarChar(50) = '+QuotedStr(pJsonObject.GetValue<String>('terminal')));
      Fconexao.Query.Sql.Add('--Volumes Não expedido');
      Fconexao.Query.Sql.Add('Update Est Set LoteId = Vl.LoteId, Qtde = Qtde - Vl.QtdSuprida');
      Fconexao.Query.Sql.Add('	From Estoque Est');
      Fconexao.Query.Sql.Add('	Inner Join (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      Fconexao.Query.Sql.Add('                from PedidoVolumeLotes Vl');
      Fconexao.Query.Sql.Add('                Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      Fconexao.Query.Sql.Add('				            Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid and');
      Fconexao.Query.Sql.Add('                                                 De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento)');
      Fconexao.Query.Sql.Add('                Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      Fconexao.Query.Sql.Add('                      (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      Fconexao.Query.Sql.Add('					                 DE.ProcessoId < 13');
      Fconexao.Query.Sql.Add('                Group by LoteId, EnderecoId) Vl On Vl.LoteId = Est.LoteId and Vl.EnderecoId=Est.EnderecoId');
      Fconexao.Query.Sql.Add('	Where Est.EstoqueTipoId = 6');
      Fconexao.Query.Sql.Add('--Volume Expedido');
      Fconexao.Query.Sql.Add('Update Est Set Qtde = Qtde + Vl.QtdSuprida');
      Fconexao.Query.Sql.Add('	From Estoque Est');
      Fconexao.Query.Sql.Add('	Inner Join (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      Fconexao.Query.Sql.Add('             from PedidoVolumeLotes Vl');
      Fconexao.Query.Sql.Add('             Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      Fconexao.Query.Sql.Add('				         Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      Fconexao.Query.Sql.Add('                                           De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento)');
      Fconexao.Query.Sql.Add('             Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      Fconexao.Query.Sql.Add('                   (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      Fconexao.Query.Sql.Add('					              DE.ProcessoId >= 13 and DE.ProcessoId <> 15');
      Fconexao.Query.Sql.Add('             Group by LoteId, EnderecoId) Vl On Vl.LoteId = Est.LoteId');
      Fconexao.Query.Sql.Add('	Where est.EnderecoId = (Select EnderecoidVolumeExpedidoCancelado From Configuracao)');
      Fconexao.Query.Sql.Add('Insert Into Estoque select Vl.LoteId, (Select EnderecoidVolumeExpedidoCancelado From Configuracao), 1, SUM(QtdSuprida),');
      Fconexao.Query.Sql.Add('							   (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Fconexao.Query.Sql.Add('							   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
      Fconexao.Query.Sql.Add('							   Null, Null, Null, Null');
      Fconexao.Query.Sql.Add('    from (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      Fconexao.Query.Sql.Add('          from PedidoVolumeLotes Vl');
      Fconexao.Query.Sql.Add('          Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      Fconexao.Query.Sql.Add('				      Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      Fconexao.Query.Sql.Add('                                           De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento)');
      Fconexao.Query.Sql.Add('          Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      Fconexao.Query.Sql.Add('                (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      Fconexao.Query.Sql.Add('					           DE.ProcessoId >= 13 and DE.ProcessoId <> 15');
      Fconexao.Query.Sql.Add('          Group by LoteId, EnderecoId) Vl');
      Fconexao.Query.Sql.Add('	   Left Join Estoque Est On Est.LoteId = Vl.Loteid And Est.EnderecoId = (Select EnderecoidVolumeExpedidoCancelado From Configuracao)');
      Fconexao.Query.Sql.Add('	   where Est.LoteId Is Null');
      Fconexao.Query.Sql.Add('	   Group by Vl.LoteId, Vl.EnderecoId');
      Fconexao.Query.Sql.Add('--Registrar Cancelamento');
      Fconexao.Query.Sql.Add('Insert Into DocumentoEtapas');
      Fconexao.Query.Sql.Add('   Select Uuid, 15, (Case When @UsuarioId=0 Then Null Else @UsuarioId End),');
      Fconexao.Query.Sql.Add('          (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Fconexao.Query.Sql.Add('		  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
      Fconexao.Query.Sql.Add('		  GetDate(), @Terminal, 1');
      Fconexao.Query.Sql.Add('   From PedidoVolumes Pv'); //01062024 nao cancelar volume já cancelado
      Fconexao.Query.Sql.Add('   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid');
      Fconexao.Query.Sql.Add('   where (@PedidoId = 0 or @PedidoId = PedidoId) and');
      Fconexao.Query.Sql.Add('         (@PedidoVolumeId = 0 or @PedidoVolumeId = PedidoVolumeId) and');
      Fconexao.Query.Sql.Add('          De.ProcessoId = (Select Max(ProcessoId) From DocumentoEtapas where documento = pv.uuid) And De.ProcessoId <> 15');
      //Limpar a caixa/Baget utilizado pelo Volume
      Fconexao.Query.Sql.Add('Update CaixaEmbalagem Set PedidoVOlumeId = Null Where PedidoVolumeId = @PedidoVolumeId');

      Fconexao.Query.Sql.Add('Insert Into DocumentoEtapas Values ((Select Uuid From Pedido Where PedidoId = ');
      Fconexao.Query.Sql.Add('                                    (Case when @PedidoId = 0 then ');
      Fconexao.Query.Sql.Add('                                    (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId) Else @PedidoId End) ),');
      Fconexao.Query.Sql.Add('       (select Coalesce(Min(DE.ProcessoId), 15)');
      Fconexao.Query.Sql.Add('        From PedidoVolumes PV');
      Fconexao.Query.Sql.Add('        Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId');
      Fconexao.Query.Sql.Add('        Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      Fconexao.Query.Sql.Add('        where (Pv.PedidoId = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId))');
      Fconexao.Query.Sql.Add('	              ),');
      Fconexao.Query.Sql.Add('       @UsuarioId, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Fconexao.Query.Sql.Add('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), @Terminal, 1)');
      if DebugHook <> 0 then
         Fconexao.Query.Sql.SaveToFile('VolumeCancelar.Sql');
      Fconexao.Query.ExecSQL;
      if vTransacao then
         Fconexao.Query.connection.commit;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Volume Cancelado com sucesso!')));
    Except ON E: Exception do
      Begin
        If vTransacao then
           Fconexao.Query.connection.Rollback;
       raise Exception.Create('Tabela: PedidoVolumes - '+StringReplace(E.Message,
                              '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
      End;
    end;
  Finally
    FreeAndNil(Qry);
  End;
end;

function TPedidoVolumeDao.GetVolume(pPedidoId, pPedidoVolumeId, pSequencia,
  pOrdem: Integer; pEmbalagem: String): TJsonArray;
var
  jsonVolume, JsonPedido, JsonDestino, JsonRota: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlVolume);
    Fconexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.ParamByName('pSequencia').Value := pSequencia;
    Fconexao.Query.ParamByName('pOrdem').Value := pOrdem;
    Fconexao.Query.ParamByName('pEmbalagem').Value := pEmbalagem;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('PedidoVolumes.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      While Not Fconexao.Query.Eof do
      Begin
        jsonVolume := TJsonObject.Create;
        jsonVolume.AddPair('pedidoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoId').AsInteger));
        jsonVolume.AddPair('pedidovolumeid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoVolumeId')
          .AsInteger));
        jsonVolume.AddPair('volumetipo',
          Fconexao.Query.FieldByName('VolumeTipo').AsString);
        jsonVolume.AddPair('embalagem', Fconexao.Query.FieldByName('embalagem')
          .AsString);
        jsonVolume.AddPair('descricao', Fconexao.Query.FieldByName('descricao')
          .AsString);
        jsonVolume.AddPair('identificacao',
          Fconexao.Query.FieldByName('Identificacao').AsString);
        jsonVolume.AddPair('tara',
          tjsonNumber.Create(Fconexao.Query.FieldByName('Tara').AsInteger));
        jsonVolume.AddPair('sequencia',
          tjsonNumber.Create(Fconexao.Query.FieldByName('Sequencia')
          .AsInteger));
        jsonVolume.AddPair('volumecaixa',
          tjsonNumber.Create(Fconexao.Query.FieldByName('VolumeCaixa')
          .AsInteger));
        jsonVolume.AddPair('processoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('ProcessoId')
          .AsInteger));
        jsonVolume.AddPair('processo', Fconexao.Query.FieldByName('Processo')
          .AsString);
        jsonVolume.AddPair('usuarioid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('UsuarioId')
          .AsInteger));
        jsonVolume.AddPair('usuario', Fconexao.Query.FieldByName('Usuario')
          .AsString);
        jsonVolume.AddPair('demanda',
          tjsonNumber.Create(Fconexao.Query.FieldByName('Demanda').AsInteger));
        jsonVolume.AddPair('qtdsuprida',
          tjsonNumber.Create(Fconexao.Query.FieldByName('QtdSuprida')
          .AsInteger));
        jsonVolume.AddPair('carregamentoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('CarregamentoId')
          .AsInteger));
        JsonPedido := TJsonObject.Create;
        JsonDestino := TJsonObject.Create;
        JsonRota := TJsonObject.Create;
        JsonPedido.AddPair('pedidoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoId').AsInteger));
        JsonPedido.AddPair('documentodata', FormatdateTime('YYYY-MM-DD',
          Fconexao.Query.FieldByName('DocumentoData').AsDateTime));
        JsonDestino.AddPair('pessoaid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PessoaId').AsInteger));
        JsonDestino.AddPair('razao', Fconexao.Query.FieldByName('Razao')
          .AsString);
        JsonRota.AddPair('rotaid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('Rotaid').AsInteger));
        JsonRota.AddPair('rota', Fconexao.Query.FieldByName('Rota').AsString);
        JsonRota.AddPair('ordem',
          tjsonNumber.Create(Fconexao.Query.FieldByName('Ordem').AsInteger));
        jsonVolume.AddPair('pedido', JsonPedido);
        jsonVolume.AddPair('destino', JsonDestino);
        jsonVolume.AddPair('rota', JsonRota);
        jsonVolume.AddPair('ruaid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('RuaId').AsInteger));
        jsonVolume.AddPair('rua', Fconexao.Query.FieldByName('Rua').AsString);
        jsonVolume.AddPair('zona', Fconexao.Query.FieldByName('Zona').AsString);
        jsonVolume.AddPair('predioinicial',
          Fconexao.Query.FieldByName('PredioInicial').AsString);
        Result.AddElement(jsonVolume);
        Fconexao.Query.Next;
      End;
    // FreeAndNil(JsonPedido);
    // FreeAndNil(JsonDestino);
    // FreeAndNil(JsonRota);
    // FreeAndNil(JsonVolume);
  Except
    ON E: Exception do
    Begin
      try

        If Assigned(JsonPedido) Then
          JsonPedido.Free;
        If Assigned(JsonDestino) Then
          JsonDestino.Free;
        If Assigned(JsonRota) Then
          JsonRota.Free;
        If Assigned(jsonVolume) Then
          jsonVolume.Free; //
      except

      end;

      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoVolumeDao.GetVolumeConsulta(const AParams : TDictionary<String, String>): TJsonArray;
Var vParamCount : Integer;
begin
  try
    vParamCount := 0;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetVolumeConsulta);
    If AParams.ContainsKey('datainicial') then Begin
       Fconexao.Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pDataInicial').Value := 0;
    If AParams.ContainsKey('datafinal') then Begin
       Fconexao.Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pDataFinal').Value := 0;
    if AParams.ContainsKey('pedidoid') then Begin
       Fconexao.Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pPedidoId').Value := 0;
    if AParams.ContainsKey('pedidovolumeid') then Begin
       Fconexao.Query.ParamByName('pPedidoVolumeId').Value := AParams.Items['pedidovolumeid'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pPedidoVolumeId').Value := 0;
    if AParams.ContainsKey('documentonr') then Begin
       Fconexao.Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr'];
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pDocumentoNr').Value := '';
    if AParams.ContainsKey('sequencia') then Begin
       Fconexao.Query.ParamByName('pSequencia').Value := AParams.Items['sequencia'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pSequencia').Value := 0;
    if AParams.ContainsKey('codpessoa') then Begin
       Fconexao.Query.ParamByName('pCodPessoa').Value := AParams.Items['codpessoa'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pCodPessoa').Value := 0;
    if AParams.ContainsKey('processoid') then Begin
       Fconexao.Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pProcessoId').Value := 0;
    if AParams.ContainsKey('rotaid') then Begin
       Fconexao.Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pRotaId').Value := 0;
    if AParams.ContainsKey('codproduto') then Begin
       Fconexao.Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pCodProduto').Value := 0;
    if AParams.ContainsKey('zonaid') then Begin
       Fconexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger();
       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pZonaId').Value := 0;
    if AParams.ContainsKey('pendente') then Begin
       Fconexao.Query.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
       if AParams.Items['pendente'].ToInteger() <> 0 then
          Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pPendente').Value := 0;
    if AParams.ContainsKey('embalagem') then Begin
       Fconexao.Query.ParamByName('pEmbalagem').Value := AParams.Items['embalagem'];
//       Inc(vParamCount);
    End
    Else
       Fconexao.Query.ParamByName('pEmbalagem').Value := 'T';
    Fconexao.Query.ParamByName('pOrdem').Value := 0;
    if vParamCount <= 0 then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Informe o filtro para pesquisa'));
    End
    Else Begin
      if DebugHook <> 0 then
         Fconexao.Query.Sql.SaveToFile('VolumeConsulta.Sql');
      Fconexao.Query.Open;
      if Fconexao.Query.Isempty then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Fconexao.Query.ToJSONArray;
    End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetVolumeConsulta - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetVolumeConsultaLotes(const AParams: TDictionary<String, String>): TJsonArray;
begin
   try
    Fconexao.Query.Sql.Add(TuEvolutConst.GetVolumeConsultaLotes);
    If AParams.ContainsKey('datainicial') then
       Fconexao.Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
       Fconexao.Query.ParamByName('pDataInicial').Value := 0;
    If AParams.ContainsKey('datafinal') then
       Fconexao.Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
       Fconexao.Query.ParamByName('pDataFinal').Value := 0;
    if AParams.ContainsKey('pedidoid') then
       Fconexao.Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pPedidoId').Value := 0;
    if AParams.ContainsKey('pedidovolumeid') then
       Fconexao.Query.ParamByName('pPedidoVolumeId').Value := AParams.Items['pedidovolumeid'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pPedidoVolumeId').Value := 0;
    if AParams.ContainsKey('documentonr') then
       Fconexao.Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr']
    Else
       Fconexao.Query.ParamByName('pDocumentoNr').Value := '';
    if AParams.ContainsKey('sequencia') then
       Fconexao.Query.ParamByName('pSequencia').Value := AParams.Items['sequencia'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pSequencia').Value := 0;
    if AParams.ContainsKey('codpessoa') then
       Fconexao.Query.ParamByName('pCodPessoa').Value := AParams.Items['codpessoa'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pCodPessoa').Value := 0;
    if AParams.ContainsKey('processoid') then
       Fconexao.Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pProcessoId').Value := 0;
    if AParams.ContainsKey('rotaid') then
       Fconexao.Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pRotaId').Value := 0;
    if AParams.ContainsKey('codproduto') then
       Fconexao.Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pCodProduto').Value := 0;
    if AParams.ContainsKey('zonaid') then
       Fconexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pZonaId').Value := 0;
    if AParams.ContainsKey('pendente') then
       Fconexao.Query.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger()
    Else
       Fconexao.Query.ParamByName('pPendente').Value := 0;
    if AParams.ContainsKey('embalagem') then
       Fconexao.Query.ParamByName('pEmbalagem').Value := AParams.Items['embalagem']
    Else
       Fconexao.Query.ParamByName('pEmbalagem').Value := 'T';
    Fconexao.Query.ParamByName('pOrdem').Value := 0;
    if DebugHook <> 0 then
       Fconexao.Query.Sql.SaveToFile('VolumeConsultaLotes.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
    End
    Else
      Result := Fconexao.Query.ToJSONArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetVolumeConsulta - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetVolumeLote(pPedidoVolumeId: Integer): TJsonArray;
begin
  Try
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeLote);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.Open;
    If DebugHook <> 0 then
       Fconexao.Query.Sql.SaveToFile('PedidoVOlumeLotes.Sql');
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
    End
    Else
      Result := Fconexao.Query.ToJSONArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeLotes - ' +StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoVolumeDao.GetVolumeProduto(pPedidoVolumeId: Integer)
  : TJsonArray;
Var
  JsonVolumeProduto: TJsonObject;
  FIndexConnExact: Integer;
begin
  Result := TJsonArray.Create;
  Try
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProduto);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      While Not Fconexao.Query.Eof do
      Begin // Lotes do Volume
        JsonVolumeProduto := TJsonObject.Create();
        JsonVolumeProduto.AddPair('pedidovolumeid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoVolumeId')
          .AsInteger));
        JsonVolumeProduto.AddPair('produtoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('ProdutoId')
          .AsInteger));
        JsonVolumeProduto.AddPair('codproduto',
          tjsonNumber.Create(Fconexao.Query.FieldByName('CodProduto')
          .AsInteger));
        JsonVolumeProduto.AddPair('codbarras',
          Fconexao.Query.FieldByName('CodBarras').AsString);
        JsonVolumeProduto.AddPair('descricao',
          Fconexao.Query.FieldByName('Descricao').AsString);
        JsonVolumeProduto.AddPair('unidadesecundariasigla',
          Fconexao.Query.FieldByName('UnidadeSecundariaSigla').AsString);
        JsonVolumeProduto.AddPair('endereco',
          Fconexao.Query.FieldByName('Endereco').AsString);
        JsonVolumeProduto.AddPair('mascara',
          Fconexao.Query.FieldByName('Mascara').AsString);
        JsonVolumeProduto.AddPair('demanda',
          tjsonNumber.Create(Fconexao.Query.FieldByName('demanda').AsInteger));
        JsonVolumeProduto.AddPair('embalagempadrao',
          tjsonNumber.Create(Fconexao.Query.FieldByName('EmbalagemPadrao')
          .AsInteger));
        JsonVolumeProduto.AddPair('qtdsuprida',
          tjsonNumber.Create(Fconexao.Query.FieldByName('QtdSuprida')
          .AsInteger));
        Result.AddElement(JsonVolumeProduto);
        Fconexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeProdutos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoVolumeDao.GetVolumeProdutoLotes(pPedidoVolumeId,
  pProdutoid: Integer): TJsonArray;
Var
  JsonVolumeProduto: TJsonObject;
begin
  Result := TJsonArray.Create;
  Try
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoLotes);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.ParamByName('pProdutoId').Value := pProdutoid;
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      Result := Fconexao.Query.ToJSONArray;

  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeProdutoLotes - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;

  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetVolumeProdutoReconferencia(pPedidoVolumeId
  : Integer): TJsonArray;
Var
  JsonVolumeProduto: TJsonObject;
begin
  Result := TJsonArray.Create;
  Try
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoReconferencia);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      While Not Fconexao.Query.Eof do
      Begin // Lotes do Volume
        JsonVolumeProduto := TJsonObject.Create();
        JsonVolumeProduto.AddPair('pedidovolumeid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoVolumeId')
          .AsInteger));
        JsonVolumeProduto.AddPair('produtoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('ProdutoId')
          .AsInteger));
        JsonVolumeProduto.AddPair('codproduto',
          tjsonNumber.Create(Fconexao.Query.FieldByName('CodProduto')
          .AsInteger));
        JsonVolumeProduto.AddPair('codbarras',
          Fconexao.Query.FieldByName('CodBarras').AsString);
        JsonVolumeProduto.AddPair('descricao',
          Fconexao.Query.FieldByName('Descricao').AsString);
        JsonVolumeProduto.AddPair('unidadesecundariasigla',
          Fconexao.Query.FieldByName('UnidadeSecundariaSigla').AsString);
        JsonVolumeProduto.AddPair('endereco',
          Fconexao.Query.FieldByName('Endereco').AsString);
        JsonVolumeProduto.AddPair('mascara',
          Fconexao.Query.FieldByName('Mascara').AsString);
        JsonVolumeProduto.AddPair('demanda',
          tjsonNumber.Create(Fconexao.Query.FieldByName('demanda').AsInteger));
        JsonVolumeProduto.AddPair('embalagempadrao',
          tjsonNumber.Create(Fconexao.Query.FieldByName('EmbalagemPadrao')
          .AsInteger));
        JsonVolumeProduto.AddPair('qtdsuprida',
          tjsonNumber.Create(Fconexao.Query.FieldByName('QtdSuprida')
          .AsInteger));
        Result.AddElement(JsonVolumeProduto);
        Fconexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeProdutos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetVolumeProdutoSeparacao(pPedidoVolumeId: Integer)
  : TJsonArray;
Var
  JsonVolumeProduto: TJsonObject;
begin
  Result := TJsonArray.Create;
  Try
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoSeparacao);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('PedidoVolumeProdutoSeparacao.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      Result := Fconexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeProdutoSeparacao - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

// Identificação Etiqueta Volume Caixa Fechada
function TPedidoVolumeDao.identificavolumecxafechada(pPedidoVolumeId: Integer) : TJsonArray;
var ObjJson: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlIdentificaVolumeCxaFechada);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    if DebugHook <> 0 then
       Fconexao.Query.Sql.SaveToFile('IdentificaVolumecxaFechada.Sql');
    Fconexao.Query.Open;
    while Not Fconexao.Query.Eof do
      With Fconexao.Query do
      Begin
        ObjJson := TJsonObject.Create;
        ObjJson.AddPair('pedidoid', tjsonNumber.Create(FieldByName('PedidoId').AsInteger));
        ObjJson.AddPair('documentooriginal', FieldByName('DocumentoOriginal').AsString);
        ObjJson.AddPair('pedidovolumeid', tjsonNumber.Create(FieldByName('PedidoVolumeId').AsInteger));
        ObjJson.AddPair('dtpedido', DateToStr(FieldByName('DtPedido').AsDateTime));
        ObjJson.AddPair('sequencia', tjsonNumber.Create(FieldByName('sequencia').AsInteger));
        ObjJson.AddPair('codpessoaerp', tjsonNumber.Create(FieldByName('CodPessoaERP').AsInteger));
        ObjJson.AddPair('razao', FieldByName('Fantasia').AsString);
        ObjJson.AddPair('fantasia', FieldByName('Fantasia').AsString);
        ObjJson.AddPair('rotaid', tjsonNumber.Create(FieldByName('RotaId').AsInteger));
        ObjJson.AddPair('rotas', FieldByName('Rotas').AsString);
        ObjJson.AddPair('Produtoid', tjsonNumber.Create(FieldByName('ProdutoId').AsInteger));
        ObjJson.AddPair('codproduto', tjsonNumber.Create(FieldByName('CodProduto').AsInteger));
        ObjJson.AddPair('descricao', FieldByName('Descricao').AsString);
        ObjJson.AddPair('picking', FieldByName('Picking').AsString);
        ObjJson.AddPair('lote', FieldByName('DescrLote').AsString);
        ObjJson.AddPair('vencimento', DateToStr(FieldByName('Vencimento').AsDateTime));
        ObjJson.AddPair('qtdsuprida', tjsonNumber.Create(FieldByName('QtdSuprida').AsInteger));
        ObjJson.AddPair('endereco', FieldByName('Endereco').AsString);
        ObjJson.AddPair('zona', FieldByName('Zona').AsString);
        ObjJson.AddPair('processoid', tjsonNumber.Create(FieldByName('ProcessoId').AsInteger));
        ObjJson.AddPair('processoetapa', FieldByName('ProcessoEtapa').AsString);
        ObjJson.AddPair('totalvolumes', tjsonNumber.Create(FieldByName('TotalVolumes').AsInteger));
        ObjJson.AddPair('logradouro', FieldByName('Logradouro').AsString);
        Result.AddElement(ObjJson);
        Fconexao.Query.Next;
      End;
  Except ON E: Exception do Begin
    raise Exception.Create('Tabela: Mapa Separação - '+StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GerarVolumeExtra(pPedidoVolumeId, pUsuarioId: Integer)
  : TJsonArray;
Var
  xProd, vQtdConferida: Integer;
begin
  Try
    // vQry.Connection.StartTransaction;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGerarVolumeExtra);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('VolumeExtra.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := Fconexao.Query.ToJSONArray;
    // vQry.Connection.commit;
  Except
    ON E: Exception do
    Begin
      // vQry.Connection.Rollback;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Gerar Volume Extra - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))))
    End;
  end;
end;

function TPedidoVolumeDao.GetPedidoVolumeEtapas(pPedidoVolumeId: Integer)
  : TJsonArray;
Var
  JsonVolumeHistorico: TJsonObject;
begin
  Try
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeEtapas);
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := Fconexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeHistorico - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetPedidoVolumeSeparacao(pPedidoId: Integer;
  pPedidoVolumeId: Integer): TJsonArray;
var vQry, vQryLotes: TFdQuery;
    ObjJson: TJsonObject;
    PedidoVolumeItensDAO: TJsonArray;
    ObjVolumeLotes: TPedidoVolumeLote;
begin
  if (pPedidoId = 0) and (pPedidoVolumeId = 0) then
     raise Exception.Create('Identificação de Pedido/volume não informado!');
  // Informe a Amanda
  Result := TJsonArray.Create;
  VQry := Fconexao.GetQuery;
  vQryLotes := Fconexao.GetQuery;
  try
    VQry.Sql.Add(TuEvolutConst.SqlPedidoVolume);
    VQry.ParamByName('pPedidoId').Value := pPedidoId;
    VQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    if DebugHook <> 0 then
       vQry.Sql.SaveToFile('VolumeParaSeparacao.Sql');
    VQry.Open;
    while Not VQry.Eof do
      With ObjPedidoVolume do
      Begin
        PedidoVolumeId                 := vQry.FieldByName('PedidoVolumeId').AsInteger;
        VolumeEmbalagem.EmbalagemId    := vQry.FieldByName('EmbalagemId').AsInteger;
        VolumeEmbalagem.Descricao      := vQry.FieldByName('Descricao').AsString;
        VolumeEmbalagem.Tipo           := vQry.FieldByName('Tipo').AsString;
        VolumeEmbalagem.TipoDescricao  := vQry.FieldByName('TipoDescricao').AsString;
        VolumeEmbalagem.Altura         := vQry.FieldByName('Altura').AsFloat;
        VolumeEmbalagem.Largura        := vQry.FieldByName('Largura').AsFloat;
        VolumeEmbalagem.Comprimento    := vQry.FieldByName('Comprimento').AsFloat;
        VolumeEmbalagem.Volume         := vQry.FieldByName('Volume').AsFloat;
        VolumeEmbalagem.Aproveitamento := VQry.FieldByName('Aproveitamento').AsInteger;
        VolumeEmbalagem.Tara           := VQry.FieldByName('Tara').AsFloat;
        VolumeEmbalagem.Capacidade     := VQry.FieldByName('Capacidade').AsFloat;
        VolumeEmbalagem.QtdLacres      := VQry.FieldByName('QtdLacres').AsInteger;
        VolumeEmbalagem.CodBarras      := VQry.FieldByName('CodBarras').AsInteger;
        VolumeEmbalagem.Disponivel     := VQry.FieldByName('Disponivel').AsInteger;
        VolumeEmbalagem.PrecoCusto     := VQry.FieldByName('PrecoCusto').AsFloat;
        // VolumeEmbalagem.DtInclusao     := vQry.FieldByName('DtInclusao').AsDateTime;
        // VolumeEmbalagem.HrInclusao     := vQry.FieldByName('HrInclusao').AsDateTime;
        VolumeEmbalagem.Status := VQry.FieldByName('Status').AsInteger;
        Pedido.PedidoId := VQry.FieldByName('PedidoId').AsInteger;
        Pedido.DocumentoData := VQry.FieldByName('DtPedido').AsDateTime;
        Pedido.RegistroERP := VQry.FieldByName('RegistroERP').AsString;
        Pedido.Pessoa.PessoaId := VQry.FieldByName('PessoaId').AsInteger;
        Pedido.Pessoa.Razao := VQry.FieldByName('Razao').AsString;
        NumSequencia := VQry.FieldByName('Sequencia').AsInteger;
        CaixaEmbalagem.CaixaEmbalagemId := VQry.FieldByName('CaixaEmbalagemId').AsInteger;
        ProcessoEtapaId := VQry.FieldByName('ProcessoId').AsInteger;
        ProcessoEtapa := VQry.FieldByName('Processo').AsString;
        Status := VQry.FieldByName('Status').AsInteger;
        // Pegar os lotes do Volume
        vQryLotes.Close;
        vQryLotes.Sql.Clear;
        vQryLotes.Sql.Add(TuEvolutConst.SqlPedidoVolumeLote);
        vQryLotes.ParamByName('pPedidoVolumeId').Value := vQry.FieldByName('PedidoVolumeId').AsInteger;
        vQryLotes.Open;
        while Not vQryLotes.Eof do With Lotes do
          Begin // Lotes do Volume
            ObjVolumeLotes := TPedidoVolumeLote.Create();
            ObjVolumeLotes.PedidoVolumeLoteId      := vQryLotes.FieldByName('PedidoVolumeLoteId').AsInteger;
            ObjVolumeLotes.PedidoVolumeId          := vQryLotes.FieldByName('PedidoVolumeId').AsInteger;
            ObjVolumeLotes.Lote.Produto.IdProduto  := vQryLotes.FieldByName('ProdutoId').AsInteger;
            ObjVolumeLotes.Lote.Produto.CodProduto := vQryLotes.FieldByName('CodProduto').AsInteger;
            ObjVolumeLotes.Lote.Produto.Descricao  := vQryLotes.FieldByName('Descricao').AsString;
            ObjVolumeLotes.Lote.Produto.IdProduto  := vQryLotes.FieldByName('ProdutoId').AsInteger;
            ObjVolumeLotes.Lote.Produto.CodProduto := vQryLotes.FieldByName('CodProduto').AsInteger;
            ObjVolumeLotes.Lote.Lotes.LoteId       := vQryLotes.FieldByName('LoteId').AsInteger;
            ObjVolumeLotes.Lote.Lotes.DescrLote    := vQryLotes.FieldByName('DescrLote').AsString;
            ObjVolumeLotes.Lote.Lotes.Vencimento   := vQryLotes.FieldByName('Vencimento').AsDateTime;
            ObjVolumeLotes.Endereco.EnderecoId     := vQryLotes.FieldByName('EnderecoId').AsInteger;
            ObjVolumeLotes.Endereco.Descricao      := vQryLotes.FieldByName('Endereco').AsString;
            ObjVolumeLotes.Endereco.EnderecoRua.RuaId     := vQryLotes.FieldByName('RuaId').AsInteger;
            ObjVolumeLotes.Endereco.EnderecoRua.Descricao := vQryLotes.FieldByName('Rua').AsString;
            ObjVolumeLotes.Endereco.EnderecoEstrutura.EstruturaId := vQryLotes.FieldByName('EstruturaId').AsInteger;
            ObjVolumeLotes.Endereco.EnderecoEstrutura.Descricao   := vQryLotes.FieldByName('Estrutura').AsString;
            ObjVolumeLotes.Endereco.EnderecoEstrutura.Mascara     := vQryLotes.FieldByName('Mascara').AsString;
            ObjVolumeLotes.EstoqueTipoId := vQryLotes.FieldByName('EstoqueTipoId').AsInteger;
            ObjVolumeLotes.EstoqueTipo   := vQryLotes.FieldByName('EstoqueTipo').AsString;
            ObjVolumeLotes.Quantidade := vQryLotes.FieldByName('Demanda').AsInteger; // Quantidade
            ObjVolumeLotes.EmbalagemPadrao := vQryLotes.FieldByName('EmbalagemPadrao').AsInteger;
            ObjVolumeLotes.QtdSuprida := vQryLotes.FieldByName('QtdSuprida').AsInteger;
            ObjVolumeLotes.DtInclusao := vQryLotes.FieldByName('DtInclusao').AsDateTime;
            ObjVolumeLotes.HrInclusao := vQryLotes.FieldByName('HrInclusao').AsDateTime;
            ObjVolumeLotes.Terminal   := vQryLotes.FieldByName('Terminal').AsString;
            ObjVolumeLotes.Usuario.UsuarioId := vQryLotes.FieldByName('UsuarioId').AsInteger;
            ObjVolumeLotes.Usuario.Nome      := vQryLotes.FieldByName('Nome').AsString;
            ObjVolumeLotes.Processado := 0;
            vQryLotes.Next;
            ObjPedidoVolume.Lotes.Add(ObjVolumeLotes);
          End;
        Result.AddElement(tJson.ObjectToJsonObject(ObjPedidoVolume, [joDateFormatISO8601]));
        VQry.Next;
      End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumes - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
  vQry.Close;
  vQryLotes.Close;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorLoja(const AParams
  : TDictionary<String, String>): TJsonObject;
begin
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
    If AParams.ContainsKey('datainicial') then
      Fconexao.Query.ParamByName('pDataInicial').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      Fconexao.Query.ParamByName('pDataInicial').Value := 0;
    If AParams.ContainsKey('datafinal') then
      Fconexao.Query.ParamByName('pDataFinal').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      Fconexao.Query.ParamByName('pDataFinal').Value := 0;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('Erro', TuEvolutConst.QrySemDados)
    End
    Else
    Begin // Get Detalhes das Produção por Rua
      Result := Fconexao.Query.ToJSONObject();
      Fconexao.Query.Close;
      Fconexao.Query.Sql.Clear;
      Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorLoja);
      If AParams.ContainsKey('datainicial') then
        Fconexao.Query.ParamByName('pDataInicial').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
        Fconexao.Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
        Fconexao.Query.ParamByName('pDataFinal').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Fconexao.Query.ParamByName('pDataFinal').Value := 0;
      If AParams.ContainsKey('estruturaid') then
        Fconexao.Query.ParamByName('pEstruturaId').Value :=
          AParams.Items['estruturaid'].ToInteger()
      Else
        Fconexao.Query.ParamByName('pEstruturaId').Value := 0;
      if DebugHook <> 0 then
        Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorLoja.Sql');
      Fconexao.Query.Open;
      Result.AddPair('detalhe', Fconexao.Query.ToJSONArray());
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetProducaoDiariaPorLoja - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorRota(const AParams
  : TDictionary<String, String>): TJsonObject;
begin
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
    If AParams.ContainsKey('datainicial') then
      Fconexao.Query.ParamByName('pDataInicial').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      Fconexao.Query.ParamByName('pDataInicial').Value := 0;
    If AParams.ContainsKey('datafinal') then
      Fconexao.Query.ParamByName('pDataFinal').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      Fconexao.Query.ParamByName('pDataFinal').Value := 0;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('Erro', TuEvolutConst.QrySemDados)
    End
    Else
    Begin // Get Detalhes das Produção por Rua
      Result := Fconexao.Query.ToJSONObject();
      Fconexao.Query.Close;
      Fconexao.Query.Sql.Clear;
      Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRota);
      If AParams.ContainsKey('datainicial') then
        Fconexao.Query.ParamByName('pDataInicial').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
        Fconexao.Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
        Fconexao.Query.ParamByName('pDataFinal').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Fconexao.Query.ParamByName('pDataFinal').Value := 0;
      If AParams.ContainsKey('estruturaid') then
        Fconexao.Query.ParamByName('pEstruturaId').Value :=
          AParams.Items['estruturaid'].ToInteger()
      Else
        Fconexao.Query.ParamByName('pEstruturaId').Value := 0;
      if DebugHook <> 0 then
        Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorRota.Sql');
      Fconexao.Query.Open;
      Result.AddPair('detalhe', Fconexao.Query.ToJSONArray());
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetProducaoDiariaPorRua - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorRua(const AParams
  : TDictionary<String, String>): TJsonObject;
begin
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
    If AParams.ContainsKey('datainicial') then
      Fconexao.Query.ParamByName('pDataInicial').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      Fconexao.Query.ParamByName('pDataInicial').Value := 0;
    If AParams.ContainsKey('datafinal') then
      Fconexao.Query.ParamByName('pDataFinal').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      Fconexao.Query.ParamByName('pDataFinal').Value := 0;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('Erro', TuEvolutConst.QrySemDados)
    End
    Else
    Begin // Get Detalhes das Produção por Rua
      Result := Fconexao.Query.ToJSONObject();
      Fconexao.Query.Close;
      Fconexao.Query.Sql.Clear;
      Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaBody);
      If AParams.ContainsKey('datainicial') then
        Fconexao.Query.ParamByName('pDataInicial').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
        Fconexao.Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
        Fconexao.Query.ParamByName('pDataFinal').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Fconexao.Query.ParamByName('pDataFinal').Value := 0;
      If AParams.ContainsKey('estruturaid') then
        Fconexao.Query.ParamByName('pEstruturaId').Value :=
          AParams.Items['estruturaid'].ToInteger()
      Else
        Fconexao.Query.ParamByName('pEstruturaId').Value := 0;
      if DebugHook <> 0 then
        Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorRuaBody.Sql');
      Fconexao.Query.Open;
      Result.AddPair('detalhe', Fconexao.Query.ToJSONArray());
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetProducaoDiariaPorRua - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorSetor(const AParams
  : TDictionary<String, String>): TJsonObject;
begin
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
    If AParams.ContainsKey('datainicial') then
      Fconexao.Query.ParamByName('pDataInicial').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      Fconexao.Query.ParamByName('pDataInicial').Value := 0;
    If AParams.ContainsKey('datafinal') then
      Fconexao.Query.ParamByName('pDataFinal').Value :=
        FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      Fconexao.Query.ParamByName('pDataFinal').Value := 0;
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('Erro', TuEvolutConst.QrySemDados)
    End
    Else
    Begin // Get Detalhes das Produção por Zona
      Result := Fconexao.Query.ToJSONObject();
      Fconexao.Query.Close;
      Fconexao.Query.Sql.Clear;
      Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorZona);
      If AParams.ContainsKey('datainicial') then
        Fconexao.Query.ParamByName('pDataInicial').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
        Fconexao.Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
        Fconexao.Query.ParamByName('pDataFinal').Value :=
          FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Fconexao.Query.ParamByName('pDataFinal').Value := 0;
      If AParams.ContainsKey('estruturaid') then
        Fconexao.Query.ParamByName('pEstruturaId').Value :=
          AParams.Items['estruturaid'].ToInteger()
      Else
        Fconexao.Query.ParamByName('pEstruturaId').Value := 0;
      if DebugHook <> 0 then
        Fconexao.Query.Sql.SaveToFile('ProducaoDiariaPorSetor.Sql');
      Fconexao.Query.Open;
      Result.AddPair('detalhe', Fconexao.Query.ToJSONArray());
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetProducaoDiariaPorSetor - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.MapaSeparacao(pPedidoId, pPedidoVolumeId: Integer)
  : TJsonArray;
var
  ObjJson: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlMapaSeparacao);
    Fconexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    If DebugHook <> 0 Then
      Fconexao.Query.Sql.SaveToFile('MapaSeparacao.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para a consulta.'))
    Else
      While Not Fconexao.Query.Eof do
        With Fconexao.Query do
        Begin
          ObjJson := TJsonObject.Create;
          ObjJson.AddPair('pedidoid',
            tjsonNumber.Create(FieldByName('PedidoId').AsInteger));
          ObjJson.AddPair('documentonr', FieldByName('DocumentoNr').AsString);
          ObjJson.AddPair('data', DateToStr(FieldByName('Data').AsDateTime));
          ObjJson.AddPair('pedidovolumeid',
            tjsonNumber.Create(FieldByName('PedidoVolumeId').AsInteger));
          ObjJson.AddPair('sequencia',
            tjsonNumber.Create(FieldByName('Sequencia').AsInteger));
          ObjJson.AddPair('pessoaid',
            tjsonNumber.Create(FieldByName('PessoaId').AsInteger));
          ObjJson.AddPair('codpessoaerp',
            tjsonNumber.Create(FieldByName('CodPessoaERP').AsInteger));
          ObjJson.AddPair('razao', FieldByName('Razao').AsString);
          ObjJson.AddPair('rotaid', tjsonNumber.Create(FieldByName('rotaid')
            .AsInteger));
          ObjJson.AddPair('rotadescricao', FieldByName('RotaDescricao')
            .AsString);
          ObjJson.AddPair('endereco', FieldByName('Endereco').AsString);
          ObjJson.AddPair('mascara', FieldByName('Mascara').AsString);
          ObjJson.AddPair('rua', FieldByName('Rua').AsString);
          ObjJson.AddPair('zona', FieldByName('Zona').AsString);
          ObjJson.AddPair('descrlote', FieldByName('DescrLote').AsString);
          ObjJson.AddPair('vencimento',
            DateToStr(FieldByName('Vencimento').AsDateTime));
          ObjJson.AddPair('produtoid',
            tjsonNumber.Create(FieldByName('ProdutoId').AsInteger));
          ObjJson.AddPair('codproduto',
            tjsonNumber.Create(FieldByName('CodProduto').AsInteger));
          ObjJson.AddPair('produtodescricao', FieldByName('ProdutoDescricao')
            .AsString);
          ObjJson.AddPair('ean', FieldByName('Ean').AsString);
          ObjJson.AddPair('quantidade',
            tjsonNumber.Create(FieldByName('quantidade').AsInteger));
          ObjJson.AddPair('unidade', FieldByName('Unidade').AsString);
          ObjJson.AddPair('embalagempadrao',
            tjsonNumber.Create(FieldByName('EmbalagemPadrao').AsInteger));
          ObjJson.AddPair('volumetipo', FieldByName('VolumeTipo').AsString);
          Result.AddElement(ObjJson);
          Fconexao.Query.Next;
        End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Mapa Separação - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.MapaSeparacaoLista(const AParams
  : TDictionary<string, string>): TJsonArray;
Var
  pPedidoIdInicial, pPedidoIdFinal, pPedidoVolumeIdInicial: Integer;
  pPedidoVolumeIdFinal, pRotaId, pCodPessoaErp, pOrdem: Integer;
  pDtPedidoInicial, pDtPedidoFinal: TDateTime;
begin
  pPedidoIdInicial := 0;
  pPedidoIdFinal := 0;
  pPedidoVolumeIdInicial := 0;
  pPedidoVolumeIdFinal := 0;
  pRotaId := 0;
  pCodPessoaErp := 0;
  pDtPedidoInicial := 0;
  pDtPedidoFinal := 0;
  Result := TJsonArray.Create;
  Try
    if AParams.ContainsKey('pedidoidinicial') then
      pPedidoIdInicial := AParams.Items['pedidoidinicial'].ToInteger;
    if AParams.ContainsKey('pedidoidfinal') then
      pPedidoIdFinal := AParams.Items['pedidoidfinal'].ToInteger;
    if AParams.ContainsKey('pedidovolumeidinicial') then
      pPedidoVolumeIdInicial := AParams.Items['pedidovolumeidinicial']
        .ToInteger;
    if AParams.ContainsKey('pedidovolumeidfinal') then
      pPedidoVolumeIdFinal := AParams.Items['pedidovolumeidfinal'].ToInteger;
    if AParams.ContainsKey('rotaid') then
      pRotaId := AParams.Items['rotaid'].ToInteger;
    if AParams.ContainsKey('codpessoaerp') then
      pCodPessoaErp := AParams.Items['codpessoaerp'].ToInteger;
    if AParams.ContainsKey('datainicial') then
      pDtPedidoInicial := StrToDate(AParams.Items['datainicial']);
    if AParams.ContainsKey('datafinal') then
      pDtPedidoFinal := StrToDate(AParams.Items['datafinal']);
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlMapaSeparacaoLista);
    Fconexao.Query.ParamByName('pPedidoIdInicial').Value := pPedidoIdInicial;
    Fconexao.Query.ParamByName('pPedidoIdFinal').Value := pPedidoIdFinal;
    Fconexao.Query.ParamByName('pPedidoVolumeIdInicial').Value :=
      pPedidoVolumeIdInicial;
    Fconexao.Query.ParamByName('pPedidoVolumeIdFinal').Value :=
      pPedidoVolumeIdFinal;
    Fconexao.Query.ParamByName('pCodPessoaERP').Value := pCodPessoaErp;
    Fconexao.Query.ParamByName('pRotaId').Value := pRotaId;
    if pDtPedidoInicial <> 0 then
      Fconexao.Query.ParamByName('pDtPedidoInicial').Value :=
        FormatdateTime('YYYY-MM-DD', pDtPedidoInicial)
    Else
      Fconexao.Query.ParamByName('pDtPedidoInicial').Value := 0;
    if pDtPedidoFinal <> 0 then
      Fconexao.Query.ParamByName('pDtPedidoFinal').Value :=
        FormatdateTime('YYYY-MM-DD', pDtPedidoFinal)
    Else
      Fconexao.Query.ParamByName('pDtPedidoFinal').Value := 0;
    If DebugHook <> 0 Then
      Fconexao.Query.Sql.SaveToFile('MapaSeparacaoLista.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para a consulta.'));
    End
    Else
      Result := Fconexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Mapa Separação Lista - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.RegistrarDocumentoEtapa(pJsonDocumentoEtapa
  : TJsonObject): TJsonArray;
Var
  VQry, vQryPedStatus: TFdQuery;
begin
  Result := TJsonArray.Create;
  VQry := Fconexao.GetQuery;
  vQryPedStatus := Fconexao.GetQuery;
  try
    VQry.Sql.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '
      + 'PedidoVolumeId = ' + pJsonDocumentoEtapa.GetValue<Integer>
      ('pedidovolumeid').ToString() + ')');
    VQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    VQry.ParamByName('pProcessoId').Value :=
      pJsonDocumentoEtapa.GetValue<Integer>('processoid');
    VQry.ParamByName('pUsuarioId').Value :=
      pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
    VQry.ParamByName('pTerminal').Value := pJsonDocumentoEtapa.GetValue<String>
      ('estacao');
    VQry.ExecSQL;
    VQry.Close;
    vQryPedStatus.Close;
    vQryPedStatus.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
    vQryPedStatus.ParamByName('pPedidoVolumeId').Value :=
      pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
    Fconexao.Query.ParamByName('pUsuarioId').Value :=
      pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
    Fconexao.Query.ParamByName('pTerminal').Value :=
      pJsonDocumentoEtapa.GetValue<String>('estacao');
    vQryPedStatus.ExecSQL;

  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: RegistrarDocumentoEtapa - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

Function TPedidoVolumeDao.RegistrarDocumentoEtapaComBaixaEstoque
  (pJsonDocumentoEtapa: TJsonObject): TJsonArray;
Var
  VQry, vQryVolumeLotes, vQryEstoque, vQryPedStatus, vQryKardex: TFdQuery;
  ObjEstoqueDAO: TEstoqueDAO;
  vEstoqueInicial: Integer;
begin
  Result := TJsonArray.Create;
  VQry := Fconexao.GetQuery;
  vQryEstoque := Fconexao.GetQuery;
  vQryVolumeLotes := Fconexao.GetQuery;
  vQryPedStatus := Fconexao.GetQuery;
  vQryKardex := Fconexao.GetQuery;
  VQry.connection.StartTransaction;
  try

    try
      VQry.Sql.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '
        + 'PedidoVolumeId = ' + pJsonDocumentoEtapa.GetValue<Integer>
        ('pedidovolumeid').ToString() + ')');
      VQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      VQry.ParamByName('pProcessoId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      VQry.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      VQry.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      VQry.ExecSQL;
      // BaixarEstoque
      vQryVolumeLotes.Close;
      vQryVolumeLotes.Sql.Clear;
      vQryVolumeLotes.Sql.Add
        ('Select LoteId, EnderecoId, EstoqueTipoId, QtdSuprida');
      vQryVolumeLotes.Sql.Add('From PedidoVolumeLotes');
      vQryVolumeLotes.Sql.Add('where PedidoVolumeId =' +
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid').ToString +
        ' and QtdSuprida > 0');
      vQryVolumeLotes.Open;
      While Not vQryVolumeLotes.Eof do
      Begin
        // Pegar Saldo inicial do Lote
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add('select Qtde From Estoque');
        vQryEstoque.Sql.Add('Where LoteId = ' + vQryVolumeLotes.FieldByName
          ('LoteId').AsString);
        vQryEstoque.Sql.Add('  And EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString);
        vQryEstoque.Sql.Add('  And EstoqueTipoId = ' +
          vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString);
        vQryEstoque.Open;
        vEstoqueInicial := vQryEstoque.FieldByName('Qtde').AsInteger;

        // Baixar Estoque Reserva
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add
          ('If Exists (Select LoteId From Estoque Where EstoqueTipoId = 6' +
          ' and LoteId = ' + vQryVolumeLotes.FieldByName('LoteId').AsString +
          ' and EnderecoId = ' + vQryVolumeLotes.FieldByName('EnderecoId')
          .AsString + ') Begin');
        // Verificar se Estoque Saldo Estoque Reservado maior que zero, senão Delete
        vQryEstoque.Sql.Add('   Update Estoque Set Qtde = Qtde - ' +
          vQryVolumeLotes.FieldByName('QtdSuprida').AsString +
          '      Where EstoqueTipoId = 6 and LoteId = ' +
          vQryVolumeLotes.FieldByName('LoteId').AsString +
          '            and EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString);
        vQryEstoque.Sql.Add('End');

        // Baixar Estoque Produção

        vQryEstoque.Sql.Add('If Exists (Select LoteId From Estoque');
        vQryEstoque.Sql.Add('Where EstoqueTipoId = ' +
          vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString +
          '      and LoteId = ' + vQryVolumeLotes.FieldByName('LoteId').AsString
          + '      and EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString + ') Begin');
        vQryEstoque.Sql.Add('   Update Estoque Set Qtde = Qtde - ' +
          vQryVolumeLotes.FieldByName('QtdSuprida').AsString +
          '      Where EstoqueTipoId = ' + vQryVolumeLotes.FieldByName
          ('EstoqueTipoId').AsString + '            and LoteId = ' +
          vQryVolumeLotes.FieldByName('LoteId').AsString +
          '            and EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString);
        vQryEstoque.Sql.Add('   End');
        vQryEstoque.Sql.Add('Else Begin');
        vQryEstoque.Sql.Add
          ('   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) Values (');
        vQryEstoque.Sql.Add('         ' + vQryVolumeLotes.FieldByName('LoteId')
          .AsString + ', ' + vQryVolumeLotes.FieldByName('EnderecoId').AsString
          + ', ' + vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString + ', '
          + (vQryVolumeLotes.FieldByName('QtdSuprida').AsInteger * (-1))
          .ToString + ', ' + TuEvolutConst.SqlDataAtual + ', ' +
          TuEvolutConst.SqlHoraAtual + ')');
        vQryEstoque.Sql.Add('End;');
        vQryEstoque.ExecSQL;
        AtualizarKardex(vQryKardex, 2, vQryVolumeLotes.FieldByName('LoteId')
          .AsInteger, vQryVolumeLotes.FieldByName('EnderecoId').AsInteger,
          vQryVolumeLotes.FieldByName('EstoqueTipoId').AsInteger, 0,
          (vQryVolumeLotes.FieldByName('QtdSuprida').AsInteger), 0,
          pJsonDocumentoEtapa.GetValue<Integer>('usuarioid'),
          'Baixa Volume: ' + pJsonDocumentoEtapa.GetValue<Integer>
          ('pedidovolumeid').ToString(), 'Transferência para loja',
          pJsonDocumentoEtapa.GetValue<String>('estacao'), vEstoqueInicial);
        vQryVolumeLotes.Next;
      End;
      vQryPedStatus.Close;
      vQryPedStatus.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
      vQryPedStatus.ParamByName('pPedidoVolumeId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
      VQry.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      VQry.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<string>('estacao');
      vQryPedStatus.ExecSQL;
      VQry.connection.commit;
      VQry.Close;
    Except
      ON E: Exception do
      Begin
        VQry.connection.Rollback;
        VQry.Close;
        raise Exception.Create
          ('Tabela: RegistrarDocumentoEtapaComBaixaEstoque - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;

  finally
    VQry.Close;
    vQryEstoque.Close;
    vQryVolumeLotes.Close;
    vQryPedStatus.Close;
    vQryKardex.Close;
    Fconexao.Query.Close;

  end;
end;

function TPedidoVolumeDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.ObjPedidoVolume.PedidoVolumeId <> 0 then
    Begin
      vSql := ' Update PedidoVolumes ' + '     Set VolumeEmbalagem = ' +
        QuotedStr(Self.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId.ToString()) +
        '   , PedidoId            = ' +
        QuotedStr(Self.ObjPedidoVolume.Pedido.PedidoId.ToString()) +
        '   , NumSequencia        = ' + Self.ObjPedidoVolume.NumSequencia.
        ToString() + '   , CaixaEmbalagem      = ' +
        Self.ObjPedidoVolume.CaixaEmbalagem.CaixaEmbalagemId.ToString() +
        ' where PedidoVolumeId = ' +
        Self.ObjPedidoVolume.PedidoVolumeId.ToString;
    End;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoVolumeDao.SaveApanheProdutos(pJsonArray: TJsonArray)
  : TJsonArray;
Var
  JsonApanheLotes: TJsonObject;
  JsonArrayLotes: TJsonArray;
  xProd, vQtdConferida: Integer;
  VQry, vQryAtualiza: TFdQuery;
  xLotes: Integer;
begin
  Fconexao.Query.connection.StartTransaction;
  // vQryAtualiza := FConexao.GetQuery;
  // vQryAtualiza.Connection := Fconexao.DB;
  try
    Result := TJsonArray.Create();
    Try
      { JsonArrayLotes  := TJsonArray.Create();
        JsonApanheLotes := TjsonObject.Create();
        JsonApanheLotes.AddPair('pedidovolumeid', TJsonNumber.Create(pJsonArray.GetValue<integer>('pedidovolumeid')));
        JsonApanheLotes.AddPair('codproduto', TJsonNumber.Create(pJsonArray.GetValue<Integer>('codproduto')));
        JsonApanheLotes.AddPair('enderecoid', TJsonNumber.Create(pJsonArray.GetValue<Integer>('enderecoid')));
        JsonApanheLotes.AddPair('quantidade', TJsonNumber.Create(pJsonArray.GetValue<Integer>('qtdsuprida')));
        JsonAPanheLotes.AddPair('data', pJsonArray.GetValue<String>('data'));
        JsonAPanheLotes.AddPair('horariotermino', pJsonArray.GetValue<String>('horariotermino'));
        JsonApanheLotes.AddPair('usuarioid', TJsonNumber.Create(pJsonArray.GetValue<Integer>('usuarioid')));
        JsonApanhelotes.AddPair('terminal', pJsonArray.GetValue<String>('terminal'));
        JsonApanhelotes.AddPair('processoetapa', pJsonArray.GetValue<String>('processoetapa'));
        JsonArrayLotes.AddElement(JsonApanheLotes);
        AtualizarConferencia( JsonArrayLotes, Fconexao );
      } AtualizarConferencia(pJsonArray, Fconexao.DB);
      // Registrar os dados do Apanhe
      Fconexao.Query.connection.commit;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Coleta Salva com sucesso!'));
    Except
      ON E: Exception do
      Begin
        Fconexao.Query.connection.Rollback;
        raise Exception.Create(E.Message);
      End;
    end;
  finally
    VQry.Close;
    vQryAtualiza.Close;
  end;
end;

Function TPedidoVolumeDao.TrataErroFireDac(pErro: EFDDBEngineException): String;
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
  Result := 'Tabela: EnderecamentoRuas - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

// Transferido para LService
function TPedidoVolumeDao.VolumeExpedicao: TJsonArray;
var
  jsonVolume: TJsonObject;
begin
  try
    Result := TJsonArray.Create;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlVolumeEmExpedicao);
    if DebugHook <> 0 then
      Fconexao.Query.Sql.SaveToFile('ExpedicaoVOlume');
    Fconexao.Query.Open();
    if Fconexao.Query.Isempty() then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      While Not Fconexao.Query.Eof do
      Begin
        jsonVolume := TJsonObject.Create;
        jsonVolume.AddPair('pedidoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoId').AsInteger));
        jsonVolume.AddPair('pedidovolumeid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoVolumeId')
          .AsInteger));
        jsonVolume.AddPair('volumetipo',
          tjsonNumber.Create(Fconexao.Query.FieldByName('VolumeTipo')
          .AsInteger));
        jsonVolume.AddPair('embalagem', Fconexao.Query.FieldByName('Embalagem')
          .AsString);
        jsonVolume.AddPair('processo', Fconexao.Query.FieldByName('Processo')
          .AsString);
        jsonVolume.AddPair('razao', Fconexao.Query.FieldByName('Razao')
          .AsString);
        jsonVolume.AddPair('documentodata', Fconexao.Query.FieldByName('data')
          .AsString);
        jsonVolume.AddPair('rotaid', Fconexao.Query.FieldByName('rotaid')
          .AsString);
        Result.AddElement(jsonVolume);
        Fconexao.Query.Next();
      End;
  Except
    ON E: Exception do
    Begin
      jsonVolume.Free;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Consulta VolumeExpedicao - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.VolumeExpedido: TJsonArray;
var
  jsonVolume: TJsonObject;
begin
  try
    Result := TJsonArray.Create;
    Fconexao.Query.Open(TuEvolutConst.SqlVolumemExpedido);
    if Fconexao.Query.Isempty() then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      While Not Fconexao.Query.Eof do
      Begin
        jsonVolume := TJsonObject.Create;
        jsonVolume.AddPair('pedidoid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoId').AsInteger));
        jsonVolume.AddPair('pedidovolumeid',
          tjsonNumber.Create(Fconexao.Query.FieldByName('PedidoVolumeId')
          .AsInteger));
        jsonVolume.AddPair('volumetipo',
          tjsonNumber.Create(Fconexao.Query.FieldByName('VolumeTipo')
          .AsInteger));
        jsonVolume.AddPair('embalagem', Fconexao.Query.FieldByName('Embalagem')
          .AsString);
        jsonVolume.AddPair('processo', Fconexao.Query.FieldByName('Processo')
          .AsString);
        Result.AddElement(jsonVolume);
        Fconexao.Query.Next();
      End;
  Except
    ON E: Exception do
    Begin
      jsonVolume.Free;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Consulta VolumeExpedido - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
  Fconexao.Query.Close;
end;

function TPedidoVolumeDao.VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId
  : Integer): TJsonArray;
var
  ObjJson: TJsonObject;
begin
  Result := TJsonArray.Create;
  try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlVolumeParaEtiquetas);
    Fconexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    Fconexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    Fconexao.Query.Open;
    while Not Fconexao.Query.Eof do
      With Fconexao.Query do
      Begin
        ObjJson := TJsonObject.Create;
        ObjJson.AddPair('pedidovolumeid',
          tjsonNumber.Create(FieldByName('PedidoVolumeId').AsInteger));
        ObjJson.AddPair('embalagemid',
          tjsonNumber.Create(FieldByName('EmbalagemId').AsInteger));
        ObjJson.AddPair('processoid',
          tjsonNumber.Create(FieldByName('ProcessoId').AsInteger));
        Result.AddElement(ObjJson);
        Fconexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      ObjJson.Free;
      raise Exception.Create('Processo: Volumes para Etiquetas - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  Fconexao.Query.Close;
end;

Function TPedidoVolumeDao.AtualizarKardex(pQuery: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String;
  pEstoqueInicial: Integer): Boolean;
begin
  Try
    pQuery.Sql.Clear;
    pQuery.Sql.Add(TuEvolutConst.SqlKardexInsUpd);
    pQuery.ParamByName('pOperacaoTipoId').Value := pOperacaoTipoId;
    pQuery.ParamByName('pLoteId').Value := pLoteId;
    pQuery.ParamByName('pEnderecoId').Value := pEnderecoId;
    pQuery.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    pQuery.ParamByName('pEstoqueTipoIdDestino').Value := pEstoqueTipoIdDestino;
    pQuery.ParamByName('pQuantidade').Value := pQuantidade;
    pQuery.ParamByName('pObservacaoOrigem').Value := pObservacaoOrigem;
    pQuery.ParamByName('pEnderecoIdDestino').Value := pEnderecoIdDestino;
    pQuery.ParamByName('pObservacaoDestino').Value := pObservacaoDestino;
    pQuery.ParamByName('pUsuarioId').Value := pUsuarioId;
    pQuery.ParamByName('pNomeEstacao').Value := pNomeEstacao;
    pQuery.ParamByName('pEstoqueInicial').Value := pEstoqueInicial;
    If DebugHook <> 0 then
      pQuery.Sql.SaveToFile('AtKardex.Sql');
    pQuery.ExecSQL;
    Result := True;
    pQuery.Close;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
