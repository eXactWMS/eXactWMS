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
    Function GetVolumeExcel(Const AParams: TDictionary<String, String>) : TJsonArray;

    Property ObjPedidoVolume: TPedidoVolume Read FPedidoVolume Write FPedidoVolume;
  end;

implementation

uses Constants, MService.EstoqueDAO; //uSistemaControl,

{ TClienteDao }

constructor TPedidoVolumeDao.Create;
begin
  ObjPedidoVolume := TPedidoVolume.Create;
  inherited;
end;

function TPedidoVolumeDao.Delete: Boolean;
var vSql: String;
    FIndexConnExact: Integer;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from PedidoVolumes where PedidoVolumeId= ' + Self.ObjPedidoVolume.PedidoVolumeId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumes/Delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TPedidoVolumeDao.Destroy;
begin
  FreeAndNil(ObjPedidoVolume);
  inherited;
end;

function TPedidoVolumeDao.DshCheckOut(const AParams : TDictionary<String, String>): TJsonArray;
var ObjJson: TJsonObject;
    vDataIni, vDataFin: TDateTime;
    vParamsOk: Integer;
    Query : TFdQuery;
begin
  vDataIni := 0;
  vDataFin := 0;
  vParamsOk := 0;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlDshCheckOut);
      if AParams.ContainsKey('datainicialpedido') then Begin
        Try
          Query.ParamByName('pDataInicialpedido').Value := StrToDate(AParams.Items['datainicialpedido']);
          vParamsOk := vParamsOk + 1;
        Except
          Begin
            Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
            Exit;
          End;
        End;
      End
      Else
        Query.ParamByName('pDataInicialPedido').Value := 0;
      if AParams.ContainsKey('datafinalpedido') then Begin
        Try
          Query.ParamByName('pDataFinalPedido').Value := StrToDate(AParams.Items['datafinalpedido']);
          vParamsOk := vParamsOk + 1;
        Except
          Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
          Exit;
        End;
      End
      Else
          Query.ParamByName('pDataFinalPedido').Value := 0;
      if AParams.ContainsKey('datainicialproducao') then Begin
         Try
           Query.ParamByName('pDataInicialproducao').Value := StrToDate(AParams.Items['datainicialproducao']);
           vParamsOk := vParamsOk + 1;
         Except
           Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Inicial da Produção é inválida!')));
           Exit;
         End;
      End
      Else
         Query.ParamByName('pDataInicialProducao').Value := 0;
      if AParams.ContainsKey('datafinalproducao') then Begin
         Try
           Query.ParamByName('pDataFinalProducao').Value := StrToDate(AParams.Items['datafinalproducao']);
           vParamsOk := vParamsOk + 1;
         Except
           Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Final da Produção é inválida!')));
           Exit;
         End;
      End
      Else
         Query.ParamByName('pDataFinalProducao').Value := 0;
      if AParams.ContainsKey('usuarioid') then
         Query.ParamByName('pUsuarioId').Value := AParams.Items['usuarioid'].ToInteger()
      Else
        Query.ParamByName('pUsuarioId').Value := 0;
      if AParams.ContainsKey('embalagemid') then
         Query.ParamByName('pEmbalagemId').Value := AParams.Items['embalagemid'].ToInteger()
      Else
         Query.ParamByName('pEmbalagemId').Value := 99;
      if (AParams.ContainsKey('recheckout')) and (AParams.Items['recheckout'].ToInteger()=1) then
         Query.ParamByName('pProcessoId').Value := 12
      Else
         Query.ParamByName('pProcessoId').Value := 10;
      if DebugHook <> 0 then
        Query.Sql.SaveToFile('DhsCheckOut.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: DshCheckOut - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

// Identificação Etiqueta Volume Caixa Fracionada
function TPedidoVolumeDao.EtiquetaPorVolume(pPedidoVolumeId: Integer) : TJsonArray;
var ObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlEtiquetaPorVolume);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      If DebugHook <> 0 then
         Query.Sql.SaveToFile('EtiquetaPorVolumeFrac.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray()
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: EtiquetaPorVolume - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
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
  Result := TJsonArray.Create();
  vVolumeIdExtra    := 0;
  Try
  pJsonArray        := pJsonObjectFinalizar.GetValue<TJsonArray>('itens');
  vPedidoVolumeId   := pJsonArray.Items[0].GetValue<Integer>('pedidovolumeid');
  pNewConnection    := False;
  Except
    Raise Exception.Create('Processo: Parâmetros inválidos!');
  End;
  if pConneXactWMS = Nil then Begin
     If Connection = Nil then
        Raise Exception.Create('Processo: FinalizarConferenciaComRegistro - Conexão com banco de dados inválida!');
     pConneXactWMS  := Connection;
     pNewConnection := True;
  End;
  VQry         := TFdQuery.Create(Nil);
  vQryAtualiza := TFdQuery.Create(Nil);
  try
    VQry.connection         := pConneXactWMS;
    vQryAtualiza.Connection := vQry.Connection;
    VQry.Connection.ResourceOptions.CmdExecTimeout := 120000;
    vQryAtualiza.Connection.ResourceOptions.CmdExecTimeout := 120000;
    If pNewConnection Then
       VQry.connection.StartTransaction;
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
             vQryAtualiza.ParamByName('poperqtdsuprida').Value := VQry.FieldByName('Quantidade').AsInteger;
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
    Except ON E: Exception do
      Begin
        If pNewConnection Then
           VQry.connection.Rollback;
//        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'FinalizarConferenciaComRegistro - ' + TUtil.TratarExcessao(E.Message))));
        Raise Exception.Create('FinalizarConferenciaComRegistro - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  finally
//    Try
      Try
        FreeAndNil(VQry);
      Except on E: Exception do
        Raise Exception.Create('FinalizarConferenciaComRegistro - vQry.Free');
      End;
      Try
        FreeAndNil(vQryAtualiza);
      Except on E: Exception do
        Raise Exception.Create('FinalizarConferenciaComRegistro - vQryAtualiza.Free');
      End;
//    Except
//      Raise;
//    End;
  end;
end;

// http://www.linhadecodigo.com.br/artigo/666/trabalhando-com-isolation-level-e-hints.aspx
function TPedidoVolumeDao.AtualizarConferencia(pJsonArray: TJsonArray;
  pConneXactWMS: TFDConnection): TJsonArray;
Var xProd, vQtdConferida: Integer;
    VQry, vQryAtualiza: TFdQuery;
    FIndexConnExact: Integer;
    pNewConnection: Boolean;
    vErro: String;
begin
  Result := TJsonArray.Create();
  try
    pNewConnection := False;
    if pConneXactWMS = Nil then Begin
       pConneXactWMS := Connection;
       pNewConnection := True;
    End;
    vQry         := TFdQuery.Create(Nil);
    vQryAtualiza := TFdQuery.Create(Nil);
    vQry.connection := pConneXactWMS;
    vQryAtualiza.connection := pConneXactWMS;
    If pNewConnection Then
       vQry.connection.StartTransaction;
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
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Conferência Atualizaca com sucesso!')));
      End;
      if pNewConnection then
         vQry.connection.commit;
    Except ON E: Exception do
      Begin
        If pNewConnection Then
           VQry.connection.Rollback;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Atualizar Conferência - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  finally
    FreeAndNil(VQry);
    FreeAndNil(vQryAtualiza);
  end;
end;

function TPedidoVolumeDao.AtualizarConferenciaSemLotes(pJsonArray: TJsonArray;
  pConneXactWMS: TFDConnection): TJsonArray;
Var xProd, vQtdConferida: Integer;
    VQry, vQryAtualiza: TFdQuery;
    FIndexConnExact: Integer;
    pNewConnection: Boolean;
begin
  Result := TJsonArray.Create();
  pNewConnection := False;
  if pConneXactWMS = Nil then Begin
    pConneXactWMS  := Connection;
    pNewConnection := True;
  End;
  VQry         := TFdQuery.Create(Nil);
  vQryAtualiza := TFdQuery.Create(Nil);
  try
    VQry.connection         := pConneXactWMS;
    vQryAtualiza.connection := pConneXactWMS;
    If pNewConnection Then Begin
       VQry.connection.StartTransaction;
    End;
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
        /// vQry.SQL.SaveToFile('GetVolumeLote.Sql');
        VQry.Open;
        vQtdConferida := pJsonArray.Items[xProd].GetValue<Integer>('qtdsuprida');
        // Quantidade Suprida
        While (Not VQry.Eof) do Begin // and (vQtdConferida>0)
          vQryAtualiza.Close;
          vQryAtualiza.ParamByName('pPedidoVolumeId').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteid').Value := VQry.FieldByName('LoteId').AsInteger;
          if vQtdConferida >= VQry.FieldByName('Quantidade').AsInteger then Begin
            // vQryAtualiza.ParamByName('pQtdeRes').Value    := vQry.FieldByName('Quantidade').AsInteger;
            vQryAtualiza.ParamByName('pQtdSuprida').Value := VQry.FieldByName('Quantidade').AsInteger;
            vQtdConferida := vQtdConferida - VQry.FieldByName('Quantidade').AsInteger;
            vQryAtualiza.ParamByName('poperquantidade').Value := VQry.FieldByName('Quantidade').AsInteger;
          End
          Else Begin;
            // vQryAtualiza.ParamByName('pQtdeRes').Value        := vQtdConferida;
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
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Checkout registrado com sucesso!'));
      if pNewConnection then
         VQry.connection.commit;
      VQry.Close;
    Except ON E: Exception do
      Begin
        If pNewConnection Then
           VQry.connection.Rollback;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Processo: AtualizarConferenciaSemLotes - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  finally
    FreeAndNil(VQry);
    FreeAndNil(vQryAtualiza);
  end;

end;

function TPedidoVolumeDao.Cancelar(pConexao: TFDConnection; pJsonObject: TJsonObject): TJsonArray;
var
  PedidoVolumeDAO: TJsonArray;
  vTransacao: Boolean;
  pNewConexao: Boolean;
  Qry: TFdQuery;
begin
  Result := TJsonArray.Create;
  if pConexao = Nil then
  Begin
    pConexao := Connection;
    pNewConexao := True;
  End
  Else
    pNewConexao := False;
  vTransacao := False;
  Qry := TFdQuery.Create(Nil);
  Try
    Qry.connection := pConexao;
    If Not Qry.connection.InTransaction then Begin
       Qry.connection.StartTransaction;
       vTransacao := True;
    End;
    try
      Qry.Sql.Add('Declare @PedidoId Integer = ' +pJsonObject.GetValue<Integer>('pedidoId').ToString());
      Qry.Sql.Add('Declare @PedidoVolumeId Integer = '+pJsonObject.GetValue<Integer>('pedidoVolumeId').ToString());
      Qry.Sql.Add('Declare @UsuarioId Integer    = '+pJsonObject.GetValue<Integer>('usuarioid').ToString());
      Qry.Sql.Add('Declare @Terminal VarChar(50) = '+QuotedStr(pJsonObject.GetValue<String>('terminal')));
      Qry.Sql.Add('--Volumes Não expedido');
      Qry.Sql.Add('Update Est Set LoteId = Vl.LoteId, Qtde = Qtde - Vl.QtdSuprida');
      Qry.Sql.Add('	From Estoque Est');
      Qry.Sql.Add('	Inner Join (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      Qry.Sql.Add('                from PedidoVolumeLotes Vl');
      Qry.Sql.Add('                Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      Qry.Sql.Add('				            Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid and');
      Qry.Sql.Add('                                                 De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento)');
      Qry.Sql.Add('                Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      Qry.Sql.Add('                      (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      Qry.Sql.Add('					                 DE.ProcessoId < 13');
      Qry.Sql.Add('                Group by LoteId, EnderecoId) Vl On Vl.LoteId = Est.LoteId and Vl.EnderecoId=Est.EnderecoId');
      Qry.Sql.Add('	Where Est.EstoqueTipoId = 6');
      Qry.Sql.Add('--Volume Expedido');
      Qry.Sql.Add('Update Est Set Qtde = Qtde + Vl.QtdSuprida');
      Qry.Sql.Add('	From Estoque Est');
      Qry.Sql.Add('	Inner Join (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      Qry.Sql.Add('             from PedidoVolumeLotes Vl');
      Qry.Sql.Add('             Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      Qry.Sql.Add('				         Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      Qry.Sql.Add('                                           De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento)');
      Qry.Sql.Add('             Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      Qry.Sql.Add('                   (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      Qry.Sql.Add('					              DE.ProcessoId >= 13 and DE.ProcessoId <> 15');
      Qry.Sql.Add('             Group by LoteId, EnderecoId) Vl On Vl.LoteId = Est.LoteId');
      Qry.Sql.Add('	Where est.EnderecoId = (Select EnderecoidVolumeExpedidoCancelado From Configuracao)');
      Qry.Sql.Add('Insert Into Estoque select Vl.LoteId, (Select EnderecoidVolumeExpedidoCancelado From Configuracao), 1, SUM(QtdSuprida),');
      Qry.Sql.Add('							   (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Qry.Sql.Add('							   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
      Qry.Sql.Add('							   Null, Null, Null, Null');
      Qry.Sql.Add('    from (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      Qry.Sql.Add('          from PedidoVolumeLotes Vl');
      Qry.Sql.Add('          Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      Qry.Sql.Add('				      Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      Qry.Sql.Add('                                           De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento)');
      Qry.Sql.Add('          Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      Qry.Sql.Add('                (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      Qry.Sql.Add('					           DE.ProcessoId >= 13 and DE.ProcessoId <> 15');
      Qry.Sql.Add('          Group by LoteId, EnderecoId) Vl');
      Qry.Sql.Add('	   Left Join Estoque Est On Est.LoteId = Vl.Loteid And Est.EnderecoId = (Select EnderecoidVolumeExpedidoCancelado From Configuracao)');
      Qry.Sql.Add('	   where Est.LoteId Is Null');
      Qry.Sql.Add('	   Group by Vl.LoteId, Vl.EnderecoId');
      Qry.Sql.Add('--Registrar Cancelamento');
      Qry.Sql.Add('Insert Into DocumentoEtapas');
      Qry.Sql.Add('   Select Uuid, 15, (Case When @UsuarioId=0 Then Null Else @UsuarioId End),');
      Qry.Sql.Add('          (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Qry.Sql.Add('		  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
      Qry.Sql.Add('		  GetDate(), @Terminal, 1');
      Qry.Sql.Add('   From PedidoVolumes Pv'); //01062024 nao cancelar volume já cancelado
      Qry.Sql.Add('   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid');
      Qry.Sql.Add('   where (@PedidoId = 0 or @PedidoId = PedidoId) and');
      Qry.Sql.Add('         (@PedidoVolumeId = 0 or @PedidoVolumeId = PedidoVolumeId) and');
      Qry.Sql.Add('          De.ProcessoId = (Select Max(ProcessoId) From DocumentoEtapas where documento = pv.uuid) And De.ProcessoId <> 15');
      //Limpar a caixa/Baget utilizado pelo Volume
      Qry.Sql.Add('Update CaixaEmbalagem Set PedidoVOlumeId = Null Where PedidoVolumeId = @PedidoVolumeId');
      Qry.Sql.Add('Insert Into DocumentoEtapas Values ((Select Uuid From Pedido Where PedidoId = ');
      Qry.Sql.Add('                                    (Case when @PedidoId = 0 then ');
      Qry.Sql.Add('                                    (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId) Else @PedidoId End) ),');
      Qry.Sql.Add('       (select Coalesce(Min(DE.ProcessoId), 15)');
      Qry.Sql.Add('        From PedidoVolumes PV');
      Qry.Sql.Add('        Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId');
      Qry.Sql.Add('        Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      Qry.Sql.Add('        where (Pv.PedidoId = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId))');
      Qry.Sql.Add('	              ),');
      Qry.Sql.Add('       @UsuarioId, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Qry.Sql.Add('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), @Terminal, 1)');
      if DebugHook <> 0 then
         Qry.Sql.SaveToFile('VolumeCancelar.Sql');
      Qry.ExecSQL;
      if vTransacao then
         Qry.connection.commit;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Volume Cancelado com sucesso!')));
    Except ON E: Exception do
      Begin
        If vTransacao then
           Qry.connection.Rollback;
       raise Exception.Create('Tabela: PedidoVolumesCancelar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Qry.Close;
  End;
end;

function TPedidoVolumeDao.GetVolume(pPedidoId, pPedidoVolumeId, pSequencia,
  pOrdem: Integer; pEmbalagem: String): TJsonArray;
var JsonVolume, JsonPedido, JsonDestino, JsonRota: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlVolume);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.ParamByName('pSequencia').Value := pSequencia;
      Query.ParamByName('pOrdem').Value := pOrdem;
      Query.ParamByName('pEmbalagem').Value := pEmbalagem;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('PedidoVolumes.Sql');
      Query.Open;
      if Query.Isempty then
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
        While Not Query.Eof do Begin
          jsonVolume := TJsonObject.Create;
          jsonVolume.AddPair('pedidoid', tjsonNumber.Create(Query.FieldByName('PedidoId').AsInteger));
          jsonVolume.AddPair('pedidovolumeid', tjsonNumber.Create(Query.FieldByName('PedidoVolumeId').AsInteger));
          jsonVolume.AddPair('volumetipo', Query.FieldByName('VolumeTipo').AsString);
          jsonVolume.AddPair('embalagem', Query.FieldByName('embalagem').AsString);
          jsonVolume.AddPair('descricao', Query.FieldByName('descricao').AsString);
          jsonVolume.AddPair('identificacao', Query.FieldByName('Identificacao').AsString);
          jsonVolume.AddPair('tara', tjsonNumber.Create(Query.FieldByName('Tara').AsInteger));
          jsonVolume.AddPair('sequencia', tjsonNumber.Create(Query.FieldByName('Sequencia').AsInteger));
          jsonVolume.AddPair('volumecaixa', tjsonNumber.Create(Query.FieldByName('VolumeCaixa').AsInteger));
          jsonVolume.AddPair('processoid', tjsonNumber.Create(Query.FieldByName('ProcessoId').AsInteger));
          jsonVolume.AddPair('processo', Query.FieldByName('Processo').AsString);
          jsonVolume.AddPair('usuarioid', tjsonNumber.Create(Query.FieldByName('UsuarioId').AsInteger));
          jsonVolume.AddPair('usuario', Query.FieldByName('Usuario').AsString);
          jsonVolume.AddPair('demanda', tjsonNumber.Create(Query.FieldByName('Demanda').AsInteger));
          jsonVolume.AddPair('qtdsuprida', tjsonNumber.Create(Query.FieldByName('QtdSuprida').AsInteger));
          jsonVolume.AddPair('carregamentoid', tjsonNumber.Create(Query.FieldByName('CarregamentoId').AsInteger));
          JsonPedido := TJsonObject.Create;
          JsonDestino := TJsonObject.Create;
          JsonRota := TJsonObject.Create;
          JsonPedido.AddPair('pedidoid', tjsonNumber.Create(Query.FieldByName('PedidoId').AsInteger));
          JsonPedido.AddPair('documentodata', FormatdateTime('YYYY-MM-DD', Query.FieldByName('DocumentoData').AsDateTime));
          JsonDestino.AddPair('pessoaid', tjsonNumber.Create(Query.FieldByName('PessoaId').AsInteger));
          JsonDestino.AddPair('razao', Query.FieldByName('Razao').AsString);
          JsonRota.AddPair('rotaid', tjsonNumber.Create(Query.FieldByName('Rotaid').AsInteger));
          JsonRota.AddPair('rota', Query.FieldByName('Rota').AsString);
          JsonRota.AddPair('ordem', tjsonNumber.Create(Query.FieldByName('Ordem').AsInteger));
          jsonVolume.AddPair('pedido', JsonPedido);
          jsonVolume.AddPair('destino', JsonDestino);
          jsonVolume.AddPair('rota', JsonRota);
          jsonVolume.AddPair('ruaid', tjsonNumber.Create(Query.FieldByName('RuaId').AsInteger));
          jsonVolume.AddPair('rua', Query.FieldByName('Rua').AsString);
          jsonVolume.AddPair('zona', Query.FieldByName('Zona').AsString);
          jsonVolume.AddPair('predioinicial', Query.FieldByName('PredioInicial').AsString);
          Result.AddElement(jsonVolume);
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        try
          If Assigned(JsonPedido) Then
             FreeAndNil(JsonPedido);
          If Assigned(JsonDestino) Then
             FreeAndNil(JsonDestino);
          If Assigned(JsonRota) Then
             FreeAndNil(JsonRota);
          If Assigned(jsonVolume) Then
             FreeAndNil(jsonVolume);
        except

        end;
        Raise Exception.Create('Processo: PedidoVolume - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeConsulta(const AParams : TDictionary<String, String>): TJsonArray;
Var vParamCount : Integer;
    Query : TFdQuery;
begin
  vParamCount := 0;
  Query       := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetVolumeConsulta);
      If AParams.ContainsKey('datainicial') then Begin
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then Begin
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if AParams.ContainsKey('pedidoid') then Begin
         Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pPedidoId').Value := 0;
      if AParams.ContainsKey('pedidovolumeid') then Begin
         Query.ParamByName('pPedidoVolumeId').Value := AParams.Items['pedidovolumeid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pPedidoVolumeId').Value := 0;
      if AParams.ContainsKey('documentonr') then Begin
         Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr'];
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pDocumentoNr').Value := '';
      if AParams.ContainsKey('sequencia') then Begin
         Query.ParamByName('pSequencia').Value := AParams.Items['sequencia'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pSequencia').Value := 0;
      if AParams.ContainsKey('codpessoa') then Begin
         Query.ParamByName('pCodPessoa').Value := AParams.Items['codpessoa'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pCodPessoa').Value := 0;
      if AParams.ContainsKey('processoid') then Begin
         Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if AParams.ContainsKey('rotaid') then Begin
         Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pRotaId').Value := 0;
      if AParams.ContainsKey('codproduto') then Begin
         Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('zonaid') then Begin
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AParams.ContainsKey('pendente') then Begin
         Query.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
         if AParams.Items['pendente'].ToInteger() <> 0 then
            Inc(vParamCount);
      End
      Else
         Query.ParamByName('pPendente').Value := 0;
      if AParams.ContainsKey('embalagem') then Begin
         Query.ParamByName('pEmbalagem').Value := AParams.Items['embalagem'];
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pEmbalagem').Value := 'T';
      Query.ParamByName('pOrdem').Value := 0;
      if vParamCount <= 0 then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Informe o filtro para pesquisa'));
      End
      Else Begin
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('VolumeConsulta.Sql');
        Query.Open;
        if Query.Isempty then Begin
           Result := TJsonArray.Create;
           Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
        End
        Else
          Result := Query.ToJSONArray;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetVolumeConsulta - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeConsultaLotes(const AParams: TDictionary<String, String>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.GetVolumeConsultaLotes);
      If AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if AParams.ContainsKey('pedidoid') then
         Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid'].ToInteger()
      Else
         Query.ParamByName('pPedidoId').Value := 0;
      if AParams.ContainsKey('pedidovolumeid') then
         Query.ParamByName('pPedidoVolumeId').Value := AParams.Items['pedidovolumeid'].ToInteger()
      Else
         Query.ParamByName('pPedidoVolumeId').Value := 0;
      if AParams.ContainsKey('documentonr') then
         Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr']
      Else
         Query.ParamByName('pDocumentoNr').Value := '';
      if AParams.ContainsKey('sequencia') then
         Query.ParamByName('pSequencia').Value := AParams.Items['sequencia'].ToInteger()
      Else
         Query.ParamByName('pSequencia').Value := 0;
      if AParams.ContainsKey('codpessoa') then
         Query.ParamByName('pCodPessoa').Value := AParams.Items['codpessoa'].ToInteger()
      Else
         Query.ParamByName('pCodPessoa').Value := 0;
      if AParams.ContainsKey('processoid') then
         Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger()
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if AParams.ContainsKey('rotaid') then
         Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger()
      Else
         Query.ParamByName('pRotaId').Value := 0;
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger()
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AParams.ContainsKey('pendente') then
         Query.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger()
      Else
         Query.ParamByName('pPendente').Value := 0;
      if AParams.ContainsKey('embalagem') then
         Query.ParamByName('pEmbalagem').Value := AParams.Items['embalagem']
      Else
         Query.ParamByName('pEmbalagem').Value := 'T';
      Query.ParamByName('pOrdem').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetVolumeConsultaLotes.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetVolumeConsultaLotes - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeExcel(const AParams: TDictionary<String, String>): TJsonArray;
Var vParamCount : Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vParamCount := 0;
      Query.Sql.Add(TuEvolutConst.SqlGetVolumeExcel);
      If AParams.ContainsKey('datainicial') then Begin
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then Begin
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if AParams.ContainsKey('pedidoid') then Begin
         Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pPedidoId').Value := 0;
      if AParams.ContainsKey('pedidovolumeid') then Begin
         Query.ParamByName('pPedidoVolumeId').Value := AParams.Items['pedidovolumeid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pPedidoVolumeId').Value := 0;
      if AParams.ContainsKey('documentonr') then Begin
         Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr'];
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pDocumentoNr').Value := '';
      if AParams.ContainsKey('sequencia') then Begin
         Query.ParamByName('pSequencia').Value := AParams.Items['sequencia'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pSequencia').Value := 0;
      if AParams.ContainsKey('codpessoa') then Begin
         Query.ParamByName('pCodPessoa').Value := AParams.Items['codpessoa'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pCodPessoa').Value := 0;
      if AParams.ContainsKey('processoid') then Begin
         Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if AParams.ContainsKey('rotaid') then Begin
         Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pRotaId').Value := 0;
      if AParams.ContainsKey('codproduto') then Begin
         Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AParams.ContainsKey('zonaid') then Begin
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger();
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AParams.ContainsKey('pendente') then Begin
         Query.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
         if AParams.Items['pendente'].ToInteger() <> 0 then
            Inc(vParamCount);
      End
      Else
         Query.ParamByName('pPendente').Value := 0;
      if AParams.ContainsKey('embalagem') then Begin
         Query.ParamByName('pEmbalagem').Value := AParams.Items['embalagem'];
         Inc(vParamCount);
      End
      Else
         Query.ParamByName('pEmbalagem').Value := 'T';
      Query.ParamByName('pOrdem').Value := 0;
      if vParamCount <= 0 then Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Informe o filtro para pesquisa'));
      End
      Else Begin
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('VolumeExcel.Sql');
        Query.Open;
        if Query.Isempty then Begin
           Result := TJsonArray.Create;
           Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
        End
        Else
          Result := Query.ToJSONArray;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: VolumeExcel - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeLote(pPedidoVolumeId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeLote);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.Open;
      If DebugHook <> 0 then
         Query.Sql.SaveToFile('PedidoVOlumeLotes.Sql');
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
        Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeLotes - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeProduto(pPedidoVolumeId: Integer) : TJsonArray;
Var
  JsonVolumeProduto: TJsonObject;
  FIndexConnExact: Integer;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProduto);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
        While Not Query.Eof do Begin // Lotes do Volume
          JsonVolumeProduto := TJsonObject.Create();
          JsonVolumeProduto.AddPair('pedidovolumeid', tjsonNumber.Create(Query.FieldByName('PedidoVolumeId').AsInteger));
          JsonVolumeProduto.AddPair('produtoid', tjsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
          JsonVolumeProduto.AddPair('codproduto', tjsonNumber.Create(Query.FieldByName('CodProduto').AsInteger));
          JsonVolumeProduto.AddPair('codbarras', Query.FieldByName('CodBarras').AsString);
          JsonVolumeProduto.AddPair('descricao', Query.FieldByName('Descricao').AsString);
          JsonVolumeProduto.AddPair('unidadesecundariasigla', Query.FieldByName('UnidadeSecundariaSigla').AsString);
          JsonVolumeProduto.AddPair('endereco', Query.FieldByName('Endereco').AsString);
          JsonVolumeProduto.AddPair('mascara', Query.FieldByName('Mascara').AsString);
          JsonVolumeProduto.AddPair('demanda', tjsonNumber.Create(Query.FieldByName('demanda').AsInteger));
          JsonVolumeProduto.AddPair('embalagempadrao', tjsonNumber.Create(Query.FieldByName('EmbalagemPadrao').AsInteger));
          JsonVolumeProduto.AddPair('qtdsuprida', tjsonNumber.Create(Query.FieldByName('QtdSuprida').AsInteger));
          Result.AddElement(JsonVolumeProduto);
          Query.Next;
        End;
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeProdutos - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeProdutoLotes(pPedidoVolumeId,
  pProdutoid: Integer): TJsonArray;
Var JsonVolumeProduto: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoLotes);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.ParamByName('pProdutoId').Value := pProdutoid;
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeProdutoLotes - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeProdutoReconferencia(pPedidoVolumeId : Integer): TJsonArray;
Var JsonVolumeProduto: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoReconferencia);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
        While Not Query.Eof do
        Begin // Lotes do Volume
          JsonVolumeProduto := TJsonObject.Create();
          JsonVolumeProduto.AddPair('pedidovolumeid', tjsonNumber.Create(Query.FieldByName('PedidoVolumeId').AsInteger));
          JsonVolumeProduto.AddPair('produtoid', tjsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
          JsonVolumeProduto.AddPair('codproduto', tjsonNumber.Create(Query.FieldByName('CodProduto').AsInteger));
          JsonVolumeProduto.AddPair('codbarras', Query.FieldByName('CodBarras').AsString);
          JsonVolumeProduto.AddPair('descricao', Query.FieldByName('Descricao').AsString);
          JsonVolumeProduto.AddPair('unidadesecundariasigla', Query.FieldByName('UnidadeSecundariaSigla').AsString);
          JsonVolumeProduto.AddPair('endereco', Query.FieldByName('Endereco').AsString);
          JsonVolumeProduto.AddPair('mascara', Query.FieldByName('Mascara').AsString);
          JsonVolumeProduto.AddPair('demanda', tjsonNumber.Create(Query.FieldByName('demanda').AsInteger));
          JsonVolumeProduto.AddPair('embalagempadrao', tjsonNumber.Create(Query.FieldByName('EmbalagemPadrao').AsInteger));
          JsonVolumeProduto.AddPair('qtdsuprida', tjsonNumber.Create(Query.FieldByName('QtdSuprida').AsInteger));
          Result.AddElement(JsonVolumeProduto);
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: VolumeProdutoReconferencia - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetVolumeProdutoSeparacao(pPedidoVolumeId: Integer) : TJsonArray;
Var JsonVolumeProduto: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoSeparacao);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('PedidoVolumeProdutoSeparacao.Sql');
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeProdutoSeparacao - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

// Identificação Etiqueta Volume Caixa Fechada
function TPedidoVolumeDao.identificavolumecxafechada(pPedidoVolumeId: Integer) : TJsonArray;
var ObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlIdentificaVolumeCxaFechada);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('IdentificaVolumecxaFechada.Sql');
      Query.Open;
      while Not Query.Eof do
        With Query do Begin
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
          ObjJson.AddPair('ordem', FieldByName('ordem').AsString);
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
          Query.Next;
        End;
    Except ON E: Exception do Begin
      raise Exception.Create('Tabela: identificavolumecxafechada - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GerarVolumeExtra(pPedidoVolumeId, pUsuarioId: Integer) : TJsonArray;
Var xProd, vQtdConferida: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      // vQry.Connection.StartTransaction;
      Query.Sql.Add(TuEvolutConst.SqlGerarVolumeExtra);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('VolumeExtra.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro','Gerar Volume Extra - '+TUtil.TratarExcessao(E.Message))))
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetPedidoVolumeEtapas(pPedidoVolumeId: Integer) : TJsonArray;
Var JsonVolumeHistorico: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlPedidoVolumeEtapas);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeEtapas - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetPedidoVolumeSeparacao(pPedidoId: Integer; pPedidoVolumeId: Integer): TJsonArray;
var vQry, vQryLotes: TFdQuery;
    ObjJson: TJsonObject;
    PedidoVolumeItensDAO: TJsonArray;
    ObjVolumeLotes: TPedidoVolumeLote;
    Query : TFdQuery;
begin
  vQry      := TFDQuery.Create(nil);
  vQryLotes := TFDQuery.Create(nil);
  Try
    vQry.Connection      := Connection;
    vQryLotes.Connection := Connection;
    if (pPedidoId = 0) and (pPedidoVolumeId = 0) then
       raise Exception.Create('Identificação de Pedido/volume não informado!');
    // Informe a Amanda
    Result := TJsonArray.Create;
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
        raise Exception.Create('Tabela: PedidoVolumeSeparacao - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(vQry);
    FreeAndNil(vQryLotes);
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorLoja(const AParams : TDictionary<String, String>): TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
      If AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
        Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonObject.Create;
         Result.AddPair('Erro', TuEvolutConst.QrySemDados)
      End
      Else Begin // Get Detalhes das Produção por Rua
        Result := Query.ToJSONObject();
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorLoja);
        If AParams.ContainsKey('datainicial') then
           Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
        Else
           Query.ParamByName('pDataInicial').Value := 0;
        If AParams.ContainsKey('datafinal') then
           Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
        Else
           Query.ParamByName('pDataFinal').Value := 0;
        If AParams.ContainsKey('estruturaid') then
           Query.ParamByName('pEstruturaId').Value := AParams.Items['estruturaid'].ToInteger()
        Else
           Query.ParamByName('pEstruturaId').Value := 0;
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('ProducaoDiariaPorLoja.Sql');
        Query.Open;
        Result.AddPair('detalhe', Query.ToJSONArray());
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ProducaoDiariaPorLoja - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorRota(const AParams : TDictionary<String, String>): TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
      If AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
       Query.Open;
      if Query.Isempty then Begin
         Result := TJsonObject.Create;
         Result.AddPair('Erro', TuEvolutConst.QrySemDados)
      End
      Else Begin // Get Detalhes das Produção por Rua
        Result := Query.ToJSONObject();
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRota);
        If AParams.ContainsKey('datainicial') then
           Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
        Else
           Query.ParamByName('pDataInicial').Value := 0;
        If AParams.ContainsKey('datafinal') then
           Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
        Else
          Query.ParamByName('pDataFinal').Value := 0;
        If AParams.ContainsKey('estruturaid') then
           Query.ParamByName('pEstruturaId').Value := AParams.Items['estruturaid'].ToInteger()
        Else
           Query.ParamByName('pEstruturaId').Value := 0;
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('ProducaoDiariaPorRota.Sql');
        Query.Open;
        Result.AddPair('detalhe', Query.ToJSONArray());
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ProducaoDiariaPorRota - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorRua(const AParams : TDictionary<String, String>): TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
      If AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Query.ParamByName('pDataFinal').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonObject.Create;
         Result.AddPair('Erro', TuEvolutConst.QrySemDados)
      End
      Else
      Begin // Get Detalhes das Produção por Rua
        Result := Query.ToJSONObject();
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaBody);
        If AParams.ContainsKey('datainicial') then
          Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
        Else
          Query.ParamByName('pDataInicial').Value := 0;
        If AParams.ContainsKey('datafinal') then
          Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
        Else
          Query.ParamByName('pDataFinal').Value := 0;
        If AParams.ContainsKey('estruturaid') then
           Query.ParamByName('pEstruturaId').Value := AParams.Items['estruturaid'].ToInteger()
        Else
           Query.ParamByName('pEstruturaId').Value := 0;
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('ProducaoDiariaPorRuaBody.Sql');
        Query.Open;
        Result.AddPair('detalhe', Query.ToJSONArray());
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ProducaoDiariaPorRua - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.GetProducaoDiariaPorSetor(const AParams : TDictionary<String, String>): TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorRuaHeader);
      If AParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      If AParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Query.ParamByName('pDataFinal').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProducaoDiariaPorRuaHeader.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonObject.Create;
         Result.AddPair('Erro', TuEvolutConst.QrySemDados)
      End
      Else Begin // Get Detalhes das Produção por Zona
        Result := Query.ToJSONObject();
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add(TuEvolutConst.SqlGetProducaoDiariaPorZona);
        If AParams.ContainsKey('datainicial') then
           Query.ParamByName('pDataInicial').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
        Else
           Query.ParamByName('pDataInicial').Value := 0;
        If AParams.ContainsKey('datafinal') then
           Query.ParamByName('pDataFinal').Value := FormatdateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
        Else
           Query.ParamByName('pDataFinal').Value := 0;
        If AParams.ContainsKey('estruturaid') then
           Query.ParamByName('pEstruturaId').Value := AParams.Items['estruturaid'].ToInteger()
        Else
           Query.ParamByName('pEstruturaId').Value := 0;
        if DebugHook <> 0 then
          Query.Sql.SaveToFile('ProducaoDiariaPorSetor.Sql');
        Query.Open;
        Result.AddPair('detalhe', Query.ToJSONArray());
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetProducaoDiariaPorSetor - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.MapaSeparacao(pPedidoId, pPedidoVolumeId: Integer) : TJsonArray;
var ObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlMapaSeparacao);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('MapaSeparacao.Sql');
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'))
      Else
        While Not Query.Eof do
          With Query do Begin
            ObjJson := TJsonObject.Create;
            ObjJson.AddPair('pedidoid', tjsonNumber.Create(FieldByName('PedidoId').AsInteger));
            ObjJson.AddPair('documentonr', FieldByName('DocumentoNr').AsString);
            ObjJson.AddPair('data', DateToStr(FieldByName('Data').AsDateTime));
            ObjJson.AddPair('pedidovolumeid', tjsonNumber.Create(FieldByName('PedidoVolumeId').AsInteger));
            ObjJson.AddPair('sequencia', tjsonNumber.Create(FieldByName('Sequencia').AsInteger));
            ObjJson.AddPair('pessoaid', tjsonNumber.Create(FieldByName('PessoaId').AsInteger));
            ObjJson.AddPair('codpessoaerp', tjsonNumber.Create(FieldByName('CodPessoaERP').AsInteger));
            ObjJson.AddPair('razao', FieldByName('Razao').AsString);
            ObjJson.AddPair('rotaid', tjsonNumber.Create(FieldByName('rotaid').AsInteger));
            ObjJson.AddPair('rotadescricao', FieldByName('RotaDescricao').AsString);
            ObjJson.AddPair('endereco', FieldByName('Endereco').AsString);
            ObjJson.AddPair('mascara', FieldByName('Mascara').AsString);
            ObjJson.AddPair('rua', FieldByName('Rua').AsString);
            ObjJson.AddPair('zona', FieldByName('Zona').AsString);
            ObjJson.AddPair('descrlote', FieldByName('DescrLote').AsString);
            ObjJson.AddPair('vencimento', DateToStr(FieldByName('Vencimento').AsDateTime));
            ObjJson.AddPair('produtoid', tjsonNumber.Create(FieldByName('ProdutoId').AsInteger));
            ObjJson.AddPair('codproduto', tjsonNumber.Create(FieldByName('CodProduto').AsInteger));
            ObjJson.AddPair('produtodescricao', FieldByName('ProdutoDescricao').AsString);
            ObjJson.AddPair('ean', FieldByName('Ean').AsString);
            ObjJson.AddPair('quantidade', tjsonNumber.Create(FieldByName('quantidade').AsInteger));
            ObjJson.AddPair('unidade', FieldByName('Unidade').AsString);
            ObjJson.AddPair('embalagempadrao', tjsonNumber.Create(FieldByName('EmbalagemPadrao').AsInteger));
            ObjJson.AddPair('volumetipo', FieldByName('VolumeTipo').AsString);
            Result.AddElement(ObjJson);
            Query.Next;
          End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Mapa Separação - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.MapaSeparacaoLista(const AParams : TDictionary<string, string>): TJsonArray;
Var
  pPedidoIdInicial, pPedidoIdFinal, pPedidoVolumeIdInicial: Integer;
  pPedidoVolumeIdFinal, pRotaId, pCodPessoaErp, pOrdem: Integer;
  pDtPedidoInicial, pDtPedidoFinal: TDateTime;
  Query : TFdQuery;
begin
  pPedidoIdInicial       := 0;
  pPedidoIdFinal         := 0;
  pPedidoVolumeIdInicial := 0;
  pPedidoVolumeIdFinal   := 0;
  pRotaId                := 0;
  pCodPessoaErp          := 0;
  pDtPedidoInicial       := 0;
  pDtPedidoFinal         := 0;
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if AParams.ContainsKey('pedidoidinicial') then
         pPedidoIdInicial := AParams.Items['pedidoidinicial'].ToInteger;
      if AParams.ContainsKey('pedidoidfinal') then
         pPedidoIdFinal := AParams.Items['pedidoidfinal'].ToInteger;
      if AParams.ContainsKey('pedidovolumeidinicial') then
         pPedidoVolumeIdInicial := AParams.Items['pedidovolumeidinicial'].ToInteger;
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
      Query.Sql.Add(TuEvolutConst.SqlMapaSeparacaoLista);
      Query.ParamByName('pPedidoIdInicial').Value := pPedidoIdInicial;
      Query.ParamByName('pPedidoIdFinal').Value := pPedidoIdFinal;
      Query.ParamByName('pPedidoVolumeIdInicial').Value := pPedidoVolumeIdInicial;
      Query.ParamByName('pPedidoVolumeIdFinal').Value   := pPedidoVolumeIdFinal;
      Query.ParamByName('pCodPessoaERP').Value := pCodPessoaErp;
      Query.ParamByName('pRotaId').Value := pRotaId;
      if pDtPedidoInicial <> 0 then
       Query.ParamByName('pDtPedidoInicial').Value := FormatdateTime('YYYY-MM-DD', pDtPedidoInicial)
      Else
        Query.ParamByName('pDtPedidoInicial').Value := 0;
      if pDtPedidoFinal <> 0 then
         Query.ParamByName('pDtPedidoFinal').Value := FormatdateTime('YYYY-MM-DD', pDtPedidoFinal)
      Else
         Query.ParamByName('pDtPedidoFinal').Value := 0;
      If DebugHook <> 0 Then
        Query.Sql.SaveToFile('MapaSeparacaoLista.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Mapa Separação Lista - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

//Verificar como Chamadas tratam o Retorno
function TPedidoVolumeDao.RegistrarDocumentoEtapa(pJsonDocumentoEtapa : TJsonObject): TJsonArray;
Var vQry, vQryPedStatus: TFdQuery;
begin
  Try
    Result        := TJsonArray.Create;
    vQry          := TFdQuery.Create(Nil);
    vQryPedStatus := TFdQuery.Create(Nil);
    try
      vQry.Connection          := Connection;
      vQryPedStatus.Connection := Connection;
      VQry.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes'+sLineBreak+
                   '                                  where '+'PedidoVolumeId = ' + pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid').ToString() + ')');
      VQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      VQry.ParamByName('pProcessoId').Value := pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      VQry.ParamByName('pUsuarioId').Value := pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      VQry.ParamByName('pTerminal').Value := pJsonDocumentoEtapa.GetValue<String>('estacao');
      VQry.ExecSQL;
      VQry.Close;
      vQryPedStatus.Close;
      vQryPedStatus.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
      vQryPedStatus.ParamByName('pPedidoVolumeId').Value := pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
      vQryPedStatus.ParamByName('pUsuarioId').Value := pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQryPedStatus.ParamByName('pTerminal').Value := pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQryPedStatus.ExecSQL;
    Except ON E: Exception do Begin
        raise Exception.Create('Tabela: RegistrarDocumentoEtapa - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(VQry);
    FreeAndNil(vQryPedStatus);
  End;
end;

Function TPedidoVolumeDao.RegistrarDocumentoEtapaComBaixaEstoque
  (pJsonDocumentoEtapa: TJsonObject): TJsonArray;
Var VQry, vQryVolumeLotes, vQryEstoque, vQryPedStatus, vQryKardex: TFdQuery;
    ObjEstoqueDAO: TEstoqueDAO;
    vEstoqueInicial: Integer;
begin
  Result := TJsonArray.Create;
  VQry            := TFdQuery.Create(Nil);
  vQryEstoque     := TFdQuery.Create(Nil);
  vQryVolumeLotes := TFdQuery.Create(Nil);
  vQryPedStatus   := TFdQuery.Create(Nil);
  vQryKardex      := TFdQuery.Create(Nil);
  try
    VQry.Connection            := Connection;
    vQryEstoque.Connection     := Connection;
    vQryVolumeLotes.Connection := Connection;
    vQryPedStatus.Connection   := Connection;
    vQryKardex.Connection      := Connection;
    VQry.connection.StartTransaction;
    try
      VQry.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes');
      vQry.SQL.Add('                                  Where PedidoVolumeId = ' + pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid').ToString() + ')');
      VQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      VQry.ParamByName('pProcessoId').Value := pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      VQry.ParamByName('pUsuarioId').Value  := pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      VQry.ParamByName('pTerminal').Value   := pJsonDocumentoEtapa.GetValue<String>('estacao');
      VQry.ExecSQL;
      // BaixarEstoque
      vQryVolumeLotes.Close;
      vQryVolumeLotes.Sql.Clear;
      vQryVolumeLotes.Sql.Add('Select LoteId, EnderecoId, EstoqueTipoId, QtdSuprida');
      vQryVolumeLotes.Sql.Add('From PedidoVolumeLotes');
      vQryVolumeLotes.Sql.Add('where PedidoVolumeId ='+pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid').ToString+' and QtdSuprida > 0');
      vQryVolumeLotes.Open;
      While Not vQryVolumeLotes.Eof do Begin
        // Pegar Saldo inicial do Lote
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add('select Qtde From Estoque');
        vQryEstoque.Sql.Add('Where LoteId = ' + vQryVolumeLotes.FieldByName('LoteId').AsString);
        vQryEstoque.Sql.Add('  And EnderecoId = ' + vQryVolumeLotes.FieldByName('EnderecoId').AsString);
        vQryEstoque.Sql.Add('  And EstoqueTipoId = ' + vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString);
        vQryEstoque.Open;
        vEstoqueInicial := vQryEstoque.FieldByName('Qtde').AsInteger;
        // Baixar Estoque Reserva
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add('If Exists (Select LoteId From Estoque');
        vQryEstoque.Sql.Add('           Where EstoqueTipoId = 6 and LoteId = '+vQryVolumeLotes.FieldByName('LoteId').AsString);
        vQryEstoque.Sql.Add('             and EnderecoId = ' + vQryVolumeLotes.FieldByName('EnderecoId').AsString+') Begin');
        // Verificar se Estoque Saldo Estoque Reservado maior que zero, senão Delete
        vQryEstoque.Sql.Add('   Update Estoque Set Qtde = Qtde - ' + vQryVolumeLotes.FieldByName('QtdSuprida').AsString);
        vQryEstoque.Sql.Add('   Where EstoqueTipoId = 6 and LoteId = '+vQryVolumeLotes.FieldByName('LoteId').AsString);
        vQryEstoque.Sql.Add('     and EnderecoId = ' + vQryVolumeLotes.FieldByName('EnderecoId').AsString);
        vQryEstoque.Sql.Add('End');

        // Baixar Estoque Produção
        vQryEstoque.Sql.Add('If Exists (Select LoteId From Estoque');
        vQryEstoque.Sql.Add('Where EstoqueTipoId = ' + vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString +
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
        vQryEstoque.Sql.Add('   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) Values (');
        vQryEstoque.Sql.Add('         ' + vQryVolumeLotes.FieldByName('LoteId').AsString + ', ' +
                            vQryVolumeLotes.FieldByName('EnderecoId').AsString+', ' +
                            vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString + ', '+
                            (vQryVolumeLotes.FieldByName('QtdSuprida').AsInteger * (-1)).ToString + ', ' +
                            TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ')');
        vQryEstoque.Sql.Add('End;');
        vQryEstoque.ExecSQL;
        AtualizarKardex(vQryKardex, 2, vQryVolumeLotes.FieldByName('LoteId').AsInteger,
                        vQryVolumeLotes.FieldByName('EnderecoId').AsInteger,
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
      vQryPedStatus.ParamByName('pPedidoVolumeId').Value := pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
      VQry.ParamByName('pUsuarioId').Value               := pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      VQry.ParamByName('pTerminal').Value                := pJsonDocumentoEtapa.GetValue<string>('estacao');
      vQryPedStatus.ExecSQL;
      VQry.connection.commit;
      VQry.Close;
    Except ON E: Exception do
      Begin
        VQry.connection.Rollback;
        raise Exception.Create('Tabela: RegistrarDocumentoEtapaComBaixaEstoque - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  finally
    FreeAndNil(VQry);
    FreeAndNil(vQryEstoque);
    FreeAndNil(vQryVolumeLotes);
    FreeAndNil(vQryPedStatus);
    FreeAndNil(vQryKardex);
  end;
end;

function TPedidoVolumeDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.ObjPedidoVolume.PedidoVolumeId <> 0 then
      Begin
        vSql := ' Update PedidoVolumes ' + '     Set VolumeEmbalagem = ' + QuotedStr(Self.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId.ToString()) +
                '   , PedidoId            = ' + QuotedStr(Self.ObjPedidoVolume.Pedido.PedidoId.ToString()) +
                '   , NumSequencia        = ' + Self.ObjPedidoVolume.NumSequencia.
                ToString() + '   , CaixaEmbalagem      = ' +
                Self.ObjPedidoVolume.CaixaEmbalagem.CaixaEmbalagemId.ToString() +
                ' where PedidoVolumeId = ' +
                Self.ObjPedidoVolume.PedidoVolumeId.ToString;
      End;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoVolume/salvar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.SaveApanheProdutos(pJsonArray: TJsonArray) : TJsonArray;
Var JsonApanheLotes: TJsonObject;
    JsonArrayLotes: TJsonArray;
    xProd, vQtdConferida: Integer;
    xLotes: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    Result := TJsonArray.Create();
    Try
      AtualizarConferencia(pJsonArray, Connection);
      // Registrar os dados do Apanhe
      Query.connection.commit;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Coleta Salva com sucesso!'));
    Except ON E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create(E.Message);
      End;
    end;
  finally
    Query.Close;
  end;
end;


// Transferido para LService
function TPedidoVolumeDao.VolumeExpedicao: TJsonArray;
var jsonVolume: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Result := TJsonArray.Create;
      Query.Sql.Add(TuEvolutConst.SqlVolumeEmExpedicao);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ExpedicaoVOlume');
      Query.Open();
      if Query.Isempty() then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      Else
        While Not Query.Eof do Begin
          jsonVolume := TJsonObject.Create;
          jsonVolume.AddPair('pedidoid', tjsonNumber.Create(Query.FieldByName('PedidoId').AsInteger));
          jsonVolume.AddPair('pedidovolumeid', tjsonNumber.Create(Query.FieldByName('PedidoVolumeId').AsInteger));
          jsonVolume.AddPair('volumetipo', tjsonNumber.Create(Query.FieldByName('VolumeTipo').AsInteger));
          jsonVolume.AddPair('embalagem', Query.FieldByName('Embalagem').AsString);
          jsonVolume.AddPair('processo', Query.FieldByName('Processo').AsString);
          jsonVolume.AddPair('razao', Query.FieldByName('Razao').AsString);
          jsonVolume.AddPair('documentodata', Query.FieldByName('data').AsString);
          jsonVolume.AddPair('rotaid', Query.FieldByName('rotaid').AsString);
          Result.AddElement(jsonVolume);
          Query.Next();
        End;
    Except ON E: Exception do
      Begin
        FreeAndNil(jsonVolume);
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Consulta VolumeExpedicao - '+TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.VolumeExpedido: TJsonArray;
var jsonVolume: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Result := TJsonArray.Create;
      Query.Open(TuEvolutConst.SqlVolumemExpedido);
      if Query.Isempty() then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      Else
        While Not Query.Eof do
        Begin
          jsonVolume := TJsonObject.Create;
          jsonVolume.AddPair('pedidoid', tjsonNumber.Create(Query.FieldByName('PedidoId').AsInteger));
          jsonVolume.AddPair('pedidovolumeid', tjsonNumber.Create(Query.FieldByName('PedidoVolumeId').AsInteger));
          jsonVolume.AddPair('volumetipo', tjsonNumber.Create(Query.FieldByName('VolumeTipo').AsInteger));
          jsonVolume.AddPair('embalagem', Query.FieldByName('Embalagem').AsString);
          jsonVolume.AddPair('processo', Query.FieldByName('Processo').AsString);
          Result.AddElement(jsonVolume);
          Query.Next();
        End;
    Except ON E: Exception do
      Begin
        FreeAndNil(jsonVolume);
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Consulta VolumeExpedido - '+TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeDao.VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId : Integer): TJsonArray;
var ObjJson: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlVolumeParaEtiquetas);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.Open;
      while Not Query.Eof do
        With Query do Begin
          ObjJson := TJsonObject.Create;
          ObjJson.AddPair('pedidovolumeid', tjsonNumber.Create(FieldByName('PedidoVolumeId').AsInteger));
          ObjJson.AddPair('embalagemid', tjsonNumber.Create(FieldByName('EmbalagemId').AsInteger));
          ObjJson.AddPair('processoid', tjsonNumber.Create(FieldByName('ProcessoId').AsInteger));
          Result.AddElement(ObjJson);
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        FreeAndNil(ObjJson);
        raise Exception.Create('Processo: Volumes para Etiquetas - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
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
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: PedidoVolumes/AtualizarKardex - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

end.
