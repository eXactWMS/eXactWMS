unit MService.PedidoSaidaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Math, FireDAC.Stan.Intf,
  FireDAC.Phys.Intf,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option, Web.HTTPApp, LotesClass, MService.ProdutoDAO,
  PedidoSaidaClass, PedidoProdutoClass, MService.PedidoProdutoDAO,
  exactwmsservice.lib.connection, exactwmsservice.lib.utils,
  exactwmsservice.dao.base;

type

  TPedidoSaidaDao = class(TBasicDao)
  private
    //
    FPedidoSaida: TPedidoSaida;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoId, pOperacaoTipoId, pPessoaId: Integer;
      pDocumentoNr: String; pDocumentoData: TDate; pArmazemId: Integer)
      : TjSonArray;
    Function Salvar: Boolean;
    function GetId(pPedidoId: Integer): TjSonArray;
    function GetPedidoAll(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer;
      pRazao, pDocumentoNr, pRegistroERP: String;
      pRotaId, pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
      pPedidoPendente: Integer): TjSonArray;
    Function GetPedidoResumoAtendimento(pPedidoId: Integer;
      pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TjSonArray;
    Function GetClientesRotaCarga(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetPendente: TjSonArray;
    function GetDocumento(pDocumento: String; pPessoaId: Integer): TjSonArray;
    Function Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Function PedidoProcessar(pPedidoId: Int64; pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Int64;
             pDocumentoNr, pRazao, pRegistroERP: String; pRotaId: Int64; pRotaIdFinal: Int64; pZonaId: Int64; pProcessoId: Integer;
             pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer) : TjSonArray;
    Function PedidoPrintTag(pPedidoId: Integer; pPedidoVolumeId: Integer;
      pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer; pRazao: String;
      pRotaId: Integer; pRotaIdFinal: Integer; pZonaId: Integer;
      pProcessoId: Integer; pRecebido, pCubagem, pEtiqueta, pPrintTag,
      pEmbalagem: Integer): TjSonArray;
    Function ProdutoSemPicking(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer; pDocumentoNr, pRazao, pRegistroERP: String; pRotaId: Integer;
      pRecebido, pCubagem, pEtiqueta, pverificarEstoque: Integer): TjSonArray;
    Function GetEstoqueCaixaFechada(pPedidoId: Integer): TjSonArray;
    Function CreateVolumeCaixaFechada(pJsonArray: TjSonArray): TjSonArray;
    Function GetLoteParaVolumeFracionado(pPedidoId: Integer): TjSonArray;
    Function GetEstoqueCaixaFracionada(pPedidoId: Integer): TjSonArray;
    Function CreateVolumeCaixaFracionada(pJsonArray: TjSonArray): TjSonArray;
    Function CancelarCubagem(pPedidoId: Integer): TjSonArray;
    Function GetProdutoReposicao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetCortes(Const AParams: TDictionary<string, string>): TjSonArray;
    Function GetRelRupturaAbastecimento(pDataIni, pDataFin: TDateTime)
      : TjSonArray;
    Function GetRelColetaPulmao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetRelApanhePicking(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetRelAnaliseRessuprimento(Const AParams
      : TDictionary<string, string>; pVolume: Boolean): TjSonArray;
    Function GetDashBoard0102(Const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function GetProducaoPendente: TjSonArray;
    Function GetDashBoard030405(Const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetDashBoard06(Const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetReposicaoGerar(pData: TDate; pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
    Function GetReposicaoEnderecoColeta(pData: TDate; pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
    Function ReposicaoSalvar(pJsonReposicao: TJsonObject): TjSonArray;
    Function PostReposicaoModelo(pJsonReposicao: TJsonObject): TjSonArray;
    Function GetReposicaoModelo(pModeloId: Integer): TjSonArray;
    Function DeleteReposicaoModelo(pModeloId: Integer): TjSonArray;
    Function ReposicaoSalvarItemColetado(pJsonReposicao: TjSonArray) : TjSonArray;
    Function ReposicaoFinalizar(pJsonReposicao: TjSonArray): TjSonArray;
    Function GetResumoProducao(Const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetAuditoriaSaidaPorProduto(Const AParams : TDictionary<string, string>): TjSonArray;
    Function GetSaidaPorProdutoBalanceamento(Const AParams : TDictionary<string, string>): TjSonArray;
    Function GetMovimentacao(Const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetEvolucaoAtendimentoPed(Const pDataInicio, pDataTermino: TDateTime; pRotaId, pZonaId : Integer; pZonaIdStr : String): TjSonArray;
    Function GetEvolucaoAtendimentoVol(Const pDataInicio, pDataTermino: TDateTime; pRotaId: Integer; pZonaIdStr : String) : TjSonArray;
    Function GetEvolucaoAtendimentoUnid(Const pDataInicio, pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer)   : TjSonArray;
    Function GetEvolucaoAtendimentoUnidZona(Const pDataInicio, pDataTermino: TDateTime; pRotaId: Integer; pZonaIdStr : String) : TjSonArray;
    Function GetEvolucaoAtendimentoUnidEmbalagem(Const pDataInicio, pDataTermino: TDateTime;
                                                 pRotaId: Integer; pTipo, pZonaIdStr : String): TjSonArray;
    Function DeleteReservaCorrecao: TjSonArray;
    Function GetPedidoProcesso(pPedidoId: Integer): TjSonArray;
    Property PedidoSaida: TPedidoSaida Read FPedidoSaida Write FPedidoSaida;
    Function GetReposicaoAutomatica(Const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetReposicaoAutomaticaColeta(Const AParams : TDictionary<string, string>): TjSonArray;
    Function GetConsultaReposicao(Const AParams: TDictionary<string, string>): TjSonArray;
    Function GetConsultaReposicaoProduto(pReposicaoId: Integer): TjSonArray;
    Function PutRegistrarProcesso(pJsonObject: TJsonObject): TjSonArray;
    Function GetMotivoExclusaoPedido : TJsonArray;
    Function Getmotivoexclusaopedido4D(const AParams: TDictionary<string, string>) : TJsonObject;

    Function GetSqlEvolucaoAtendimentoUnidadesZona(pZonaIdStr : String) : String;
    Function GetSqlAtendimentoUnidadesPorEmbalagem(pZonaIdStr : String) : String;
    Function GetSqlAtendimentoVolumesPorEmbalagem(pZonaIdStr : String) : String;
    Function GetSqlAtendimentoVolumes(pZonaIdStr : String) : String;
    Function GetDashproducaodiaria(pDataInicial, pDataFInal : TDateTime) : TJsonArray;
    Function GetDashproducaodiariaZona(pDataInicial, pDataFInal : TDateTime) : TJsonArray;
    Function AtualizarProcesso(pPedidoId : Integer) : TJsonArray;

  end;

implementation

uses uSistemaControl, Constants,
  MService.PedidoVolumeDAO;

{ TClienteDao }

function TPedidoSaidaDao.AtualizarProcesso(pPedidoId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Close;
      Query.SQL.Add('DECLARE @RetryCount INT = 3; -- Número máximo de tentativas ');
      Query.SQL.Add('DECLARE @CurrentRetry INT = 0; ');
      Query.SQL.Add(' ');
      Query.SQL.Add('WHILE @CurrentRetry < @RetryCount ');
      Query.SQL.Add('Begin ');
      Query.SQL.Add('  BEGIN TRY ');
      Query.SQL.Add('    Delete Pv ');
      Query.SQL.Add('    from PedidoVOlumes Pv ');
      Query.SQL.Add('    left Join PedidoVolumeLotes Vl --With (NoLock) ');
      Query.SQL.Add('	                               On Vl.PedidoVolumeId = Pv.PedidoVolumeId ');
      Query.SQL.Add('    where Vl.PedidoVOlumeId Is Null ');
      Query.SQL.Add('	Break; ');
      Query.SQL.Add('  End Try ');
      Query.SQL.Add('  Begin Catch ');
      Query.SQL.Add('    IF ERROR_NUMBER() = 1205 Begin ');
      Query.SQL.Add('	   SET @CurrentRetry = @CurrentRetry + 1; ');
      Query.SQL.Add('       PRINT '+#39+'DeadLock Detectado!'+#39+'+ CAST(@CurrentRetry AS NVARCHAR(10)); ');
      Query.SQL.Add('       WAITFOR DELAY '+#39+'00:00:00.100'+#39+'; ');
      Query.SQL.Add('	End; ');
      Query.SQL.Add('  End Catch ');
      Query.SQL.Add('End; ');
      Query.SQL.Add(' ');
      Query.SQL.Add('--Begin Tran ');
      Query.SQL.Add(';With ');
      Query.SQL.Add('PedTmp as ( ');
      Query.SQL.Add('select Ped.PedidoId, ProcMax.ProcessoId ');
      Query.SQL.Add('From Pedido Ped ');
      Query.SQL.Add('CROSS APPLY (select top 1 ProcessoId ');
      Query.SQL.Add('             From DocumentoEtapas ');
      Query.SQL.Add('			 where Documento = Ped.Uuid ');
      Query.SQL.Add('			   and Status = 1 ');
      Query.SQL.Add('			 Order by ProcessoId Desc) ProcMax ');
      Query.SQL.Add('Where ProcMax.ProcessoId < 13 and Ped.OperacaoTipoId = 2) ');
      Query.SQL.Add(' ');
      Query.SQL.Add(', VolTmp as (select Pv.PedidoId, ProcMax.ProcessoId ');
      Query.SQL.Add('From PedidoVOlumes Pv ');
      Query.SQL.Add('Inner Join PedTmp Ped On Ped.PedidoId = Pv.PedidoId ');
      Query.SQL.Add('CROSS APPLY (select top 1 ProcessoId ');
      Query.SQL.Add('             From DocumentoEtapas ');
      Query.SQL.Add('			 where Documento = Pv.Uuid ');
      Query.SQL.Add('			   and Status = 1 ');
      Query.SQL.Add('			 Order by ProcessoId Desc) ProcMax) ');
      Query.SQL.Add(' ');
      Query.SQL.Add(' ');
      Query.SQL.Add(', VlmEtapas as (Select Pv.PedidoId, Min(ProcessoId) ProcessoId ');
      Query.SQL.Add('               From VolTmp Pv ');
      Query.SQL.Add('			   Group by Pv.PedidoId) ');
      Query.SQL.Add(' ');
      Query.SQL.Add('Insert Into DocumentoEtapas ');
      Query.SQL.Add('select Ped.uuid, Pv.ProcessoID, 1, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), ');
      Query.SQL.Add('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), '+#39+'Atualizacao Manual'+#39+', 1 ');
      Query.SQL.Add('From VlmEtapas PV ');
      Query.SQL.Add('Inner join Pedido Ped On Ped.PedidoId = Pv.PedidoId ');
      Query.SQL.Add('where Pv.Processoid >= 13');
      If DebugHook <> 0 Then
         Query.SQL.SaveToFile('AtualizarProcesso.Sql');
      Query.ExecSQL;
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Manutenção realizada com sucesso!'));
    Except On E: Exception do
      raise Exception.Create('Processo: AtualizarProcesso('+pPedidoId.ToString()+') - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
var vSql: String;
    ObjPedidoVolumeDAO: TPedidoVolumeDAO;
    JsonVolumeCancelar: TJsonObject;
    Query : TFdQuery;
begin
  Result := False;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      try
        // Chamar Rotina de Cancelamento de Cubagem
        Query.connection.StartTransaction;
        //Query.connection.TxOptions.Isolation := xiReadCommitted;
        Query.Close;
        Query.SQL.Add('Select PedidoVolumeId From PedidoVolumes Where PedidoId = ' +
                              pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString);
        Query.Open();
        ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
        while Not Query.Eof do Begin
          JsonVolumeCancelar := TJsonObject.Create;
          JsonVolumeCancelar.AddPair('pedidoVolumeId', TJsonNumber.Create(Query.FieldByName('PedidoVolumeId').Asinteger));
          JsonVolumeCancelar.AddPair('usuarioid', TJsonNumber.Create(pJsonPedidoCancelar.GetValue<String>('usuarioid')));
          JsonVolumeCancelar.AddPair('terminal', pJsonPedidoCancelar.GetValue<String>('terminal'));
          Try
            ObjPedidoVolumeDAO.Cancelar(Connection, JsonVolumeCancelar);
          Except On E: Exception do
            raise Exception.Create('Processo: CancelarVolumes - ' + TUtil.TratarExcessao(E.Message));
          End;
          Query.Next;
          FreeAndNil(JsonVolumeCancelar);
          FreeAndNil(ObjPedidoVolumeDAO);
        End;
        Query.Close;
        Query.SQL.Clear;
        Query.Sql.Add('Update Pedido Set Status = 3 ');
        Query.Sql.Add('Where PedidoId = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString);
        Query.Sql.Add('  and OperacaoTipoId = 2');
        Query.Sql.Add('Update DocumentoEtapas Set Status = 0'); //01062024 nao cancelar volume já cancelado
        Query.Sql.Add('Where Documento = (Select Uuid from Pedido ');
        Query.Sql.Add('                   Where Pedidoid = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString() );
        Query.Sql.Add('  And ProcessoId = 15');
        Query.Sql.Add('Insert Into DocumentoEtapas Values ');
        Query.Sql.Add('     ( Cast((Select Uuid from Pedido ');
        Query.Sql.Add('             Where Pedidoid = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString()+
                                                              ') as UNIQUEIDENTIFIER), ');
        Query.Sql.Add('       15, ' +pJsonPedidoCancelar.GetValue<Integer>('usuarioid').ToString() + ', ');
        Query.Sql.Add('       '+SqlDataAtual + ', ' + SqlHoraAtual + ', GetDate(), ');
        Query.Sql.Add('       '+QuotedStr(pJsonPedidoCancelar.GetValue<String>('terminal')) + ', 1)');
        Query.ExecSQL(vSql);
        Result := True;
        Query.connection.Commit;
      Except
        On E: Exception do
        Begin
          Query.connection.Rollback;
          raise Exception.Create('Processo: CancelarPedido - ' +TUtil.TratarExcessao(E.Message));
        End;
      end;
    Finally
      //Colocado acima no Laco While
      //FreeAndNil(JsonVolumeCancelar);
      //FreeAndNil(ObjPedidoVolumeDAO);
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.CancelarCubagem(pPedidoId: Integer): TjSonArray;
Var vTransaction: Boolean;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlCancelarCubagemPedido);
      Query.ParamByName('pPedido').Value := pPedidoId;
      Query.ExecSQL;
      Query.connection.Commit;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Resultado', 'Cancelamento de Cubagem realizado com sucess!')));
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Não foi possível cancelar a cubagem do pedido. ' + E.Message);
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

constructor TPedidoSaidaDao.Create;
begin
  PedidoSaida := TPedidoSaida.Create;
  PedidoSaida.ListProduto := TObjectList<TPedidoProduto>.Create();
  inherited;;
end;

function TPedidoSaidaDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Pedido where PedidoId = ' + Self.PedidoSaida.PedidoId.ToString + ' and OperacaoTipoId = 2';
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception Do
      Begin
        raise Exception.Create('Processo: PedidoSaida/Delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.DeleteReposicaoModelo(pModeloId: Integer): TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Delete ReposicaoModelo');
      Query.SQL.Add('Where ReposicaoModeloId = :pModeloId');
      Query.ParamByName('pModeloId').Value := pModeloId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('DelteReposicaoModelo.Sql');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Registro excluído com sucesso!')));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida/DeleteReposicaoModelo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.DeleteReservaCorrecao: TjSonArray;
begin
  Try
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Função não usada...'));
  Except
    On E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPedidoSaidaDao.Destroy;
begin
  FreeAndNil(PedidoSaida.ListProduto);
  FreeANdNil(PedidoSaida);
  inherited;
end;

function TPedidoSaidaDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('Pedido') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
       Result := Query.ToJSONArray();
  Finally
    FreeAndNil(Query);
  End;
end;

// revisar Try Except
Function TPedidoSaidaDao.CreateVolumeCaixaFechada(pJsonArray: TjSonArray) : TJsonArray;
Var xArray: Integer;
    xQtdVolume: Integer;
    xVolume: Integer;
    jsonVolume: TJsonObject;
    vSql: String;
    vGuuid: string;
    StartProc: Boolean;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    StartProc := True;
    Try
      For xArray := 0 to Pred(pJsonArray.Count) do Begin
        jsonVolume := pJsonArray.Items[xArray] as TJsonObject;
        For xVolume := 1 to jsonVolume.GetValue<Integer>('qtvolume') do Begin // Criando o Volume
          Query.Close;
          Query.SQL.Clear;
          Query.SQL.Add(TuEvolutConst.SqlCreateVolume);
          Query.ParamByName('pPedidoId').Value    := jsonVolume.GetValue<Integer>('pedidoid');
          Query.ParamByName('pEmbalagemId').Value := 0;
          Query.ParamByName('pTerminal').Value    := jsonVolume.GetValue<String>('terminal');
          Query.ParamByName('pUsuarioId').Value   := jsonVolume.GetValue<String>('usuarioid');
          vGuuid := TGUID.NewGuid.ToString();
          Query.ParamByName('pNewId').Value := vGuuid;
          if DebugHook <> 0 then
             Query.SQL.SaveToFile('CreateVolume.Sql');
          Try
            Query.ExecSQL; // Definindo os Lotes do Volume
            Query.Close;
            Query.SQL.Clear;
            Query.SQL.Add(TuEvolutConst.SqlGerarVolumeLoteCaixaFechada);
            Query.ParamByName('pNewId').Value           := vGuuid;
            Query.ParamByName('pLoteId').Value          := jsonVolume.GetValue<Integer>('loteid');
            Query.ParamByName('pEnderecoId').Value      := jsonVolume.GetValue<Integer>('enderecoid');
            Query.ParamByName('pEstoqueTipoId').Value   := jsonVolume.GetValue<Integer>('estoquetipoid');
            Query.ParamByName('pQuantidade').Value      := jsonVolume.GetValue<Integer>('quantidade');
            Query.ParamByName('pEmbalagemPadrao').Value := jsonVolume.GetValue<Integer>('embalagempadrao');
            Query.ParamByName('pTerminal').Value        := jsonVolume.GetValue<String>('terminal');
            Query.ParamByName('pUsuarioId').Value       := jsonVolume.GetValue<String>('usuarioid');
            Query.ExecSQL;
          Except ON E: Exception do
            Begin
              raise Exception.Create('PedidoId = ' + jsonVolume.GetValue<Integer>('pedidoid').ToString + ' ' + E.Message);
            End;
          End;
        End;
        // Reserva de Estoque
        Try
          Query.Close;
          Query.SQL.Clear;
          Query.SQL.Add ('--PedidoSaidaDao.CreateVolumeCaixaFechada - Reserva de Estoque');
          Query.SQL.Add(TuEvolutConst.SqlEstoque);
          Query.ParamByName('pLoteId').Value        := jsonVolume.GetValue<Integer>('loteid');
          Query.ParamByName('pEnderecoId').Value    := jsonVolume.GetValue<Integer>('enderecoid');
          Query.ParamByName('pEstoqueTipoId').Value := 6;
          Query.ParamByName('pQuantidade').Value    := jsonVolume.GetValue<Integer>('quantidade') * jsonVolume.GetValue<Integer>('qtvolume');
          Query.ParamByName('pUsuarioId').Value     := jsonVolume.GetValue<String>('usuarioid');
          Query.ExecSQL;
        Except ON E: Exception do
          Begin
            raise Exception.Create(E.Message);
          End;
        end;
        jsonVolume := Nil;
      End;
      Query.connection.Commit;
      Result.AddElement(TJsonObject.Create.AddPair('Resultado', 'Volume(s) criado com sucesso!'));
      Query.Close;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

// Revisar Try Except
function TPedidoSaidaDao.CreateVolumeCaixaFracionada(pJsonArray: TjSonArray) : TjSonArray;
Var xArray: Integer;
    xQtdVolume: Integer;
    xVolume, xLotes: Integer;
    jsonVolume, jsonVolumeLotes: TJsonObject;
    ArrayJsonVolumeLotes: TjSonArray;
    vSql: String;
    vGuuid: string;
    StartProc: Boolean;
    pTerminal: string;
    pUsuarioId: Integer;
    pPedidoId: Integer;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    StartProc := True;
    Try
      For xArray := 0 to Pred(pJsonArray.Count) do Begin
        jsonVolume := pJsonArray.Items[xArray] as TJsonObject;
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add(TuEvolutConst.SqlCreateVolume);
        Query.ParamByName('pPedidoId').Value := jsonVolume.GetValue<Integer>('pedidoid');
        pPedidoId := jsonVolume.GetValue<Integer>('pedidoid');
        Query.ParamByName('pEmbalagemId').Value := jsonVolume.GetValue<Integer>('embalagemid');
        pTerminal := jsonVolume.GetValue<String>('terminal');
        pUsuarioId := jsonVolume.GetValue<Integer>('usuarioid');
        Query.ParamByName('pTerminal').Value := pTerminal;
        Query.ParamByName('pUsuarioId').Value := pUsuarioId;
        ArrayJsonVolumeLotes := jsonVolume.Get('lotes').JsonValue as TjSonArray;
        vGuuid := TGUID.NewGuid.ToString();
        Query.ParamByName('pNewId').Value := vGuuid;
        // ClipBoard.AsText := vGuuid;
        Query.ExecSQL;
        try
          // Definindo os Lotes do Volume
          for xLotes := 0 to Pred(ArrayJsonVolumeLotes.Count) do Begin
            jsonVolumeLotes := ArrayJsonVolumeLotes.Items[xLotes] as TJsonObject;
            Query.Close;
            Query.SQL.Clear;
            Query.SQL.Add(TuEvolutConst.SqlGerarVolumeLoteCaixaFechada);
            Query.ParamByName('pNewId').Value := vGuuid;
            Query.ParamByName('pLoteId').Value := jsonVolumeLotes.GetValue<Integer>('loteid');
            Query.ParamByName('pEnderecoId').Value := jsonVolumeLotes.GetValue<Integer>('enderecoid');
            Query.ParamByName('pEstoqueTipoId').Value := jsonVolumeLotes.GetValue<Integer>('estoquetipoid');
            Query.ParamByName('pQuantidade').Value := jsonVolumeLotes.GetValue<Integer>('quantidade');
            Query.ParamByName('pEmbalagemPadrao').Value := jsonVolumeLotes.GetValue<Integer>('embalagempadrao');
            Query.ParamByName('pTerminal').Value := pTerminal;
            Query.ParamByName('pUsuarioId').Value := pUsuarioId;
            Query.ExecSQL;
            Query.Close;
            Query.SQL.Clear;
            Query.SQL.Add('--PedidoSaidaDao.CreateVolumeCaixaFracionada');
            Query.SQL.Add(TuEvolutConst.SqlEstoque);
            Query.SQL.Add('-- EnderecoId = ' + jsonVolumeLotes.GetValue<Integer>('enderecoid').ToString());
            Query.ParamByName('pLoteId').Value := jsonVolumeLotes.GetValue<Integer>('loteid');
            Query.ParamByName('pEnderecoId').Value := jsonVolumeLotes.GetValue<Integer>('enderecoid');
            Query.ParamByName('pEstoqueTipoId').Value := 6;
            Query.ParamByName('pQuantidade').Value := jsonVolumeLotes.GetValue<Integer>('quantidade');
            Query.ParamByName('pUsuarioId').Value := pUsuarioId;
            Query.ExecSQL;
          End;
        Except ON E: Exception do
          Begin
            raise Exception.Create(E.Message);
          End;
        end;
        // End;
      End;
      // ProdutoId	EmbPrim	EmbSec	MesSaidaMinima	LoteId	Vencimento	EnderecoId	Endereco	Estrutura	Qtde	DtEntrada	HrEntrada	EstoqueTipoId	TipoEstoque	Producao	Distribuicao	CxaFechada
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+jsonVolume.GetValue<Integer>('pedidoid').ToString + ')');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      if jsonVolume.GetValue<Integer>('reprocessado') = 0 then
         Query.ParamByName('pProcessoId').Value := 2
      else
         Query.ParamByName('pProcessoId').Value := 21;
      Query.ParamByName('pTerminal').Value := pTerminal;
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.connection.Commit;
      Result.AddElement(TJsonObject.Create.AddPair('Resultado', 'Volume(s) criado com sucesso!'));
      Query.Close;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEstoqueCaixaFechada(pPedidoId: Integer): TjSonArray;
var vSql : String;
    jsonEstoqueDisponivel : TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlEstoqueCubagemCxaFechada);
      // Pegar Estoque para Processar Caixa Fechada
      Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EstoqueCaixaFechada.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não há cálculo para caixa fechada!'));
         Exit;
      End;
      With Query do
        While Not Query.Eof do Begin
          jsonEstoqueDisponivel := TJsonObject.Create();
          jsonEstoqueDisponivel.AddPair('produtoid', TJsonNumber.Create(FieldByName('produtoid').Asinteger));
          jsonEstoqueDisponivel.AddPair('embprim', TJsonNumber.Create(FieldByName('embprim').Asinteger));
          jsonEstoqueDisponivel.AddPair('embsec', TJsonNumber.Create(FieldByName('embsec').Asinteger));
          jsonEstoqueDisponivel.AddPair('fatorconversao', TJsonNumber.Create(FieldByName('FatorConversao').Asinteger));
          jsonEstoqueDisponivel.AddPair('messaidaminima', TJsonNumber.Create(FieldByName('messaidaminima').Asinteger));
          jsonEstoqueDisponivel.AddPair('loteid', TJsonNumber.Create(FieldByName('loteid').Asinteger));
          jsonEstoqueDisponivel.AddPair('vencimento', FieldByName('Vencimento').AsString);  // Usar Funcao DateEUAToBrasil  e retirar o laco na Funcao GetEstoqueCxaFechada no Processamento do Pedido
          jsonEstoqueDisponivel.AddPair('enderecoid', TJsonNumber.Create(FieldByName('enderecoid').Asinteger));
          jsonEstoqueDisponivel.AddPair('qtdpedido', TJsonNumber.Create(FieldByName('qtdpedido').Asinteger));
          jsonEstoqueDisponivel.AddPair('embalagempadrao', TJsonNumber.Create(FieldByName('EmbalagemPadrao').Asinteger));
          jsonEstoqueDisponivel.AddPair('qtde', TJsonNumber.Create(FieldByName('qtde').Asinteger));
          jsonEstoqueDisponivel.AddPair('bloqueado', TJsonNumber.Create(0));
          jsonEstoqueDisponivel.AddPair('dtentrada', FieldByName('dtentrada').AsString);
          jsonEstoqueDisponivel.AddPair('hrentrada', FieldByName('hrentrada').AsString);
          jsonEstoqueDisponivel.AddPair('estoquetipoid', TJsonNumber.Create(FieldByName('EstoqueTipoId').Asinteger));
          Result.AddElement(jsonEstoqueDisponivel);
          Next;
        End;
      // ProdutoId	EmbPrim	EmbSec	MesSaidaMinima	LoteId	Vencimento	EnderecoId	Endereco	Estrutura	Qtde	DtEntrada	HrEntrada	EstoqueTipoId	TipoEstoque	Producao	Distribuicao	CxaFechada
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEstoqueCaixaFracionada(pPedidoId: Integer) : TjSonArray;
var vSql: String;
    jsonEstoqueDisponivel: TJsonObject;
    Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlEstoqueVolumeCaixaFracionada);
      Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EstoqueFracionado.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Pedido(' + pPedidoId.ToString() + '). Sem cálculo para Fracionado!!'));
      End
      Else
         Result := Query.ToJSONArray(); // Alterado em 26/07/23
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoPed(const pDataInicio, pDataTermino: TDateTime; pRotaId, pZonaId: Integer; pZonaIdStr : String): TjSonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('declare @DtInicio DateTime = :pDtInicio');
      Query.SQL.Add('Declare @DtTermino DateTime = :pDtTermino');
      Query.SQL.Add('Declare @RotaId Integer = :pRotaId');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#Pedidos'+#39+') is not null drop table #Pedidos');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#PedidoResumo'+#39+') is not null drop table #PedidoResumo');
      Query.SQL.Add('Select Rd.Data,De.ProcessoId, Count(*) As Total Into #Pedidos');
      Query.SQL.Add('From Pedido Ped');
      Query.SQL.Add('Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId');
      Query.SQL.Add('Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId');
      Query.SQL.Add('Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid');
      Query.SQL.Add('Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData');
      Query.SQL.Add('Inner join (Select Distinct PedidoId');
      Query.SQL.Add('            From PedidoProdutos Pp');
      Query.SQL.Add('					  Inner Join vProduto Prd On Prd.IdProduto = Pp.ProdutoId');
      if pZonaIdstr <> '' then
         Query.SQL.Add('            Where ZonaId in ('+pZonaIdStr+') ) Vl On Vl.PedidoId = Ped.PedidoId')
      Else
         Query.SQL.Add('                                             ) Vl On Vl.PedidoId = Ped.PedidoId');
      Query.SQL.Add('where DE.ProcessoId = (Select Max(ProcessoId) From vDocumentoEtapas Where Documento = Ped.uuid)');
      Query.SQL.Add('  and Ped.OperacaoTipoId = 2');
      Query.SQL.Add('  and (@DtInicio = 0 or Rd.Data >= @DtInicio)');
      Query.SQL.Add('  and (@DtTermino = 0 or Rd.Data <= @DtTermino)');
      Query.SQL.Add('  And (@RotaId = 0 or Rp.rotaid = @RotaId)');
      Query.SQL.Add('  And De.ProcessoId <> 31');
      Query.SQL.Add('Group By Rd.Data, Ped.PedidoId, De.ProcessoId');
      Query.SQL.Add('select Ped.Data, (Case When Ped.ProcessoId = 1 then 1');
      Query.SQL.Add('		   	                              When Ped.Processoid in (2, 22) then 2');
      Query.SQL.Add('		                                  When Ped.ProcessoId in (3, 7, 8) then 3');
      Query.SQL.Add('		                                  When Ped.ProcessoId in (9, 10, 11, 12) then 4');
      Query.SQL.Add('			                                When Ped.ProcessoId = 15 then 6');
      Query.SQL.Add(' 			                                Else 5 End) as Processoid, Ped.Total Into #PedidoResumo');
      Query.SQL.Add('From #Pedidos Ped');
      Query.SQL.Add('Select Data, Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+');
      Query.Sql.Add('             Coalesce([5], 0)+Coalesce([6], 0) As '+#39+'Demanda'+#39+',');
      Query.SQL.Add('       COALESCE ([1], 0) AS '+#39+'Recebido'+#39);
      Query.SQL.Add('     , COALESCE ([2], 0) AS '+#39+'Cubagem'+#39);
      Query.SQL.Add('     , COALESCE ([3], 0) AS '+#39+'Apanhe'+#39);
      Query.SQL.Add('     , COALESCE ([4], 0) AS '+#39+'CheckOut'+#39);
      Query.SQL.Add('     , COALESCE ([5], 0) AS '+#39+'Expedicao'+#39);
      Query.SQL.Add('     , COALESCE ([6], 0) AS '+#39+'Cancelado'+#39+', Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /');
      Query.SQL.Add('       Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+');
      Query.SQL.Add('       Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia');
      Query.SQL.Add('FROM   (SELECT Data, ProcessoId, Total');
      Query.SQL.Add('        FROM #PedidoResumo as P) AS Tbl PIVOT (sum(Total)');
      Query.SQL.Add('		            FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt');
      Query.SQL.Add('Order by Data');
      if pDataInicio = 0 then
         Query.ParamByName('pDtInicio').Value := pDataInicio
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
      if pDataTermino = 0 then
         Query.ParamByName('pDtTermino').Value := 0
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.SQL.Add('--DtInicio = ' + FormatDateTime('YYYY-MM-DD', pDataInicio));
      Query.SQL.Add('--DtTermino = ' + FormatDateTime('YYYY-MM-DD', pDataTermino));
      Query.SQL.Add('--RotaId = ' + pRotaId.ToString);
      Query.SQL.Add('--ZonaId = ' + pZonaId.ToString);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EvolucaoAtendimentoPed.Sql');
      Query.Open;
      if Query.IsEmpty Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnid(const pDataInicio,
  pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoUnid);
      if pDataInicio = 0 then
         Query.ParamByName('pDtInicio').Value := 0
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
      if pDataTermino = 0 then
         Query.ParamByName('pDtTermino').Value := 0
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pRotaId').Value := pRotaId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EvolucaoAtendimentoUnid.Sql');
       Query.Open;
      if Query.IsEmpty Then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
      End
      Else
        Result := Query.ToJSONArray;
    Except
      On E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidZona(const pDataInicio,
  pDataTermino: TDateTime; pRotaId: Integer; pZonaIdStr : String): TjSonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add( GetSqlEvolucaoAtendimentoUnidadesZona(pZonaIdStr));//TuEvolutConst.SqlGetEvolucaoAtendimentoUnidZona);
      if pDataInicio = 0 then
         Query.ParamByName('pDtInicio').Value := 0
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
      if pDataTermino = 0 then
         Query.ParamByName('pDtTermino').Value := 0
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
      Query.ParamByName('pRotaId').Value       := pRotaId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EvolucaoAtendimentoUnidZona.Sql');
      Query.Open;
      if Query.IsEmpty Then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida - '+Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidEmbalagem(const pDataInicio, pDataTermino: TDateTime;
         pRotaId: Integer; pTipo, pZonaIdStr : String) : TjSonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if pTipo = 'Unid' then
         Query.SQL.Add(GetSqlAtendimentoUnidadesPorEmbalagem(pZonaIdStr)) //TuEvolutConst.SqlGetEvolucaoAtendimentoUnidEmbalagem)
      Else
         Query.SQL.Add(GetSqlAtendimentoVolumesPorEmbalagem(pZonaIdStr)); //TuEvolutConst.SqlGetEvolucaoAtendimentoVolEmbalagem);
  //    FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoVolEmbalagemteste.Sql');
      if pDataInicio = 0 then
         Query.ParamByName('pDtInicio').Value := 0
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
      if pDataTermino = 0 then
         Query.ParamByName('pDtTermino').Value := 0
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pZonaId').Value := StrToIntDef(pZonaIdStr, 0);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EvolucaoAtendimentoUnidEmbalagem.Sql');
      Query.Open;
      if Query.IsEmpty Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Evolução do Ressuprimento(Detalhes).'))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoVol(const pDataInicio,
  pDataTermino: TDateTime; pRotaId: Integer; pZonaIdStr : String): TjSonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      //FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoVol);
      Query.SQL.Add(GetSqlAtendimentoVolumes(pZonaIdStr));
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('EvolucaoAtendimentoVolTeste.Sql');
      if pDataInicio = 0 then
         Query.ParamByName('pDtInicio').Value := pDataInicio
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
      if pDataTermino = 0 then
         Query.ParamByName('pDtTermino').Value := 0
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pZonaId').Value := StrToIntDef(pZonaIdStr, 0);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EvolucaoAtendimentoVol.Sql');
      Query.Open;
      if Query.IsEmpty Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: GetEvolucaoAtendimentoVol - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetDashBoard0102(Const AParams
  : TDictionary<string, string>): TJsonObject;
Var pDtInicio, pDtTermino: TDate;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      pDtInicio := 0;
      pDtTermino := 0;
      Query.SQL.Add(TuEvolutConst.SqlDashboad0102);
      if AParams.ContainsKey('dtinicio') then
         pDtInicio := StrToDate(AParams.Items['dtinicio']);
      if AParams.ContainsKey('dttermino') then
         pDtTermino := StrToDate(AParams.Items['dttermino']);
      if pDtInicio = 0 then
         Query.ParamByName('pDtInicio').Value := pDtInicio
      Else
        Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDtInicio);
      if pDtTermino = 0 then
         Query.ParamByName('pDtTermino').Value := pDtTermino
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDtTermino);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('DashBoard0102.Sql');
      Query.Open;
      Result.AddPair('diario', Query.ToJSONArray);
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlDashboad0102);
      Query.ParamByName('pDtInicio').Value := (pDtInicio - 31);
      Query.ParamByName('pDtTermino').Value := (pDtInicio - 1);
      Query.Open;
      Result.AddPair('mensal', Query.ToJSONArray);
    Except On E: Exception do
      Begin
        raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetDashBoard030405(Const AParams
  : TDictionary<string, string>): TjSonArray;
Var pDtInicio, pDtTermino: TDate;
    Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
     Try
      pDtInicio := 0;
      pDtTermino := 0;
      Query.SQL.Add(TuEvolutConst.SqlDashboard030405);
      if AParams.ContainsKey('dtinicio') then
         pDtInicio := StrToDate(AParams.Items['dtinicio']);
      if AParams.ContainsKey('dttermino') then
         pDtTermino := StrToDate(AParams.Items['dttermino']);
      if pDtInicio = 0 then
         Query.ParamByName('pDtInicio').Value := pDtInicio
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDtInicio);
      if pDtTermino = 0 then
         Query.ParamByName('pDtTermino').Value := pDtTermino
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDtTermino);
      Query.Open;
      Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: GetEvolucaoAtendimentoVol - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetDashBoard06(Const AParams
  : TDictionary<string, string>): TjSonArray;
Var pDtInicio, pDtTermino: TDate;
    Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      pDtInicio := 0;
      pDtTermino := 0;
      Query.SQL.Add(TuEvolutConst.SqlDashBoard06);
      if AParams.ContainsKey('dtinicio') then
         pDtInicio := StrToDate(AParams.Items['dtinicio']);
      if AParams.ContainsKey('dttermino') then
         pDtTermino := StrToDate(AParams.Items['dttermino']);
      if pDtInicio = 0 then
         Query.ParamByName('pDtInicio').Value := pDtInicio
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDtInicio);
      if pDtTermino = 0 then
         Query.ParamByName('pDtTermino').Value := pDtTermino
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDtTermino);
      Query.Open;
      Result := Query.ToJSONArray;
    Except On E: Exception do Begin
       raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - '+TUtil.TratarExcessao(E.Message));
       End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetDocumento(pDocumento: String; pPessoaId: Integer) : TjSonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
     Query.SQL.Add(TuEvolutConst.SqlPedido);
     Query.ParamByName('pPedidoId').Value := 0;
     Query.ParamByName('pDataIni').Value := 0;
     Query.ParamByName('pDataFin').Value := 0;
     Query.ParamByName('pCodigoERP').Value := 0;
     Query.ParamByName('pPessoaId').Value := pPessoaId;
     Query.ParamByName('pDocumentoNr').Value := pDocumento;
     Query.ParamByName('pRazao').Value := '';
     Query.ParamByName('pRegistroERP').Value := '';
     Query.ParamByName('pRotaId').Value := 0;
     Query.ParamByName('pRotaIdFinal').Value := 0;
     Query.ParamByName('pOPeracaoTipoId').Value := 2;
     Query.ParamByName('pZonaId').Value := 0;
     Query.ParamByName('pProcessoId').Value := 0;
     Query.ParamByName('pMontarCarga').Value := 2;
     Query.ParamByName('pCodProduto').Value := 0;
     Query.ParamByName('pPedidoPendente').Value := 0;
     Query.ParamByName('pCargaId').Value := 0;
     Query.ParamByName('pNotaFiscalERP').Value := '';
     if DebugHook <> 0 then
        Query.SQL.SaveToFile('PedidoDocumento.Sql');
     Query.Open;
     if Query.IsEmpty then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
     End
     Else
       Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        Raise Exception.Create('Processo: PedidoSaida/GetDocumeto - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetDashproducaodiaria(pDataInicial, pDataFInal: TDateTime): TJsonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetDashproducaodiaria);
      Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
      Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataFinal);
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('DshProducaoDiariaUnidades.Sql');
      Query.Open();
      If Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      raise Exception.Create('Processo: GetDashProdutoDiaria - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetDashproducaodiariaZona(pDataInicial,
  pDataFInal: TDateTime): TJsonArray;
Var Query : TFdQuery;
begin
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetDashproducaodiariaZona);
      Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
      Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataFinal);
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('DshProducaoDiariaUnidades.Sql');
      Query.Open();
      If Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      raise Exception.Create('Processo: GetDashProducaoDiariaZona - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetId(pPedidoId: Integer): TjSonArray;
var
  ObjPedidoProduto: TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlPedido);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pDataIni').Value := 0;
      Query.ParamByName('pDataFin').Value := 0;
      Query.ParamByName('pCodigoERP').Value := 0;

      Query.ParamByName('pPessoaId').Value := 0;
      Query.ParamByName('pDocumentoNr').Value := '';
      Query.ParamByName('pRazao').Value := '';
      Query.ParamByName('pRegistroERP').Value := '';
      Query.ParamByName('pRotaId').Value := 0;
      Query.ParamByName('pRotaIdFinal').Value := 0;
      Query.ParamByName('pZonaId').Value := 0;
      Query.ParamByName('pOperacaoTipoId').Value := 2;
      Query.ParamByName('pProcessoId').Value := 0;
      Query.ParamByName('pMontarCarga').Value := 2;
      Query.ParamByName('pCodProduto').Value := 0;
      Query.ParamByName('pPedidoPendente').Value := 0;
      Query.ParamByName('pCargaId').Value := 0;
      Query.ParamByName('pNotaFiscalERP').Value := '';

      if pPedidoId = 0 then
         Query.ParamByName('pPedidoPendente').Value := 1;
      Query.Open;
      if Query.IsEmpty then
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          TuEvolutConst.QrySemDados)))
      Else
        while Not Query.Eof do
        Begin
          PedidoSaida.PedidoId := Query.FieldByName('PedidoId').Asinteger;
          PedidoSaida.OperacaoTipo.OperacaoTipoId := Query.FieldByName('OperacaoTipoId').Asinteger;
          PedidoSaida.OperacaoTipo.Descricao := Query.FieldByName('OperacaoTipo').AsString;
          PedidoSaida.Pessoa.PessoaId := Query.FieldByName('PessoaId').Asinteger;
          PedidoSaida.Pessoa.Razao := Query.FieldByName('Razao').AsString;
          PedidoSaida.DocumentoNr := Query.FieldByName('DocumentoNr').AsString;
          PedidoSaida.DocumentoData := Query.FieldByName('DocumentoData').AsDateTime;
          PedidoSaida.DtInclusao := Query.FieldByName('DtInclusao').AsDateTime;
          PedidoSaida.HrInclusao := Query.FieldByName('HrInclusao').AsDateTime;
          PedidoSaida.ArmazemId := Query.FieldByName('ArmazemId').Asinteger;
          PedidoSaida.Status := Query.FieldByName('Status').Asinteger;
          PedidoSaida.uuid := Query.FieldByName('uuid').AsString;
          // vQryProduto.Open('Declare @Pedido Integer = '+FConexao.Query.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
          ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
          ArrayPedidoProdutoDAO := ObjPedidoSaidaItensDAO.GetId(pPedidoId);
          // vQryProduto.FieldByName('PedidoId').AsInteger);
          for vItens := 0 to ArrayPedidoProdutoDAO.Count - 1 do Begin
            ObjPedidoProduto := ObjPedidoProduto.JsonToClass(ArrayPedidoProdutoDAO.Items[vItens].ToString());
            PedidoSaida.ListProduto.Add(ObjPedidoProduto);
          End;
          Result.AddElement(TJson.ObjectToJsonObject(PedidoSaida, [joDateFormatISO8601]));
          FreeAndNil(ObjPedidoSaidaItensDAO);
          Query.Next;
        End;
      ObjPedidoProduto := Nil;
      ArrayPedidoProdutoDAO := nil;
    Except ON E: Exception do
      Begin
        ObjPedidoProduto := Nil;
        ArrayPedidoProdutoDAO := nil;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetLoteParaVolumeFracionado(pPedidoId: Integer) : TjSonArray;
var vSql: String;
    jsonEstoqueDisponivel: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      // Query.SQL.Add(TuEvolutConst.SqlGetLoteParaVolumeFracionado);
      // clipboard.AsText := FConexao.Query.SQL.Text;
      Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('LoteParaVolumeFracionado.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Pedido(' + pPedidoId.ToString() + ') indisponível para Cubagem!')));
      End
      Else
        Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Processo: GetLoteParaVolumeFracionado - ', E.Message)));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetMotivoExclusaoPedido: TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('Select * from MEP');
      Query.SQL.Add('Order by Descricao');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('MEP.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Sem Cadastro de Motivos para Exclusão.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Processo: GetMotivoExclusaoPedido', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.Getmotivoexclusaopedido4D(const AParams: TDictionary<string, string>): TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
Begin
  Result := TJsonObject.Create();
  QryPesquisa    := TFdQuery.Create(Nil);
  QryRecordCount := TFdQuery.Create(Nil);
  Try
    QryPesquisa.Connection    := Connection;
    QryRecordCount.Connection := Connection;
    QryPesquisa.SQL.Add('Select * from MEP where 1 = 1');
    QryRecordCount.SQL.Add('Select Count(MotivoId) cReg From MEP where 1=1');
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by Descricao');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.toJsonArray());
    QryRecordCount.Open();
    Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  finally
    FreeAndNil(QryPesquisa);
    FreeAndNil(QryRecordCount);
  end;
end;

function TPedidoSaidaDao.GetMovimentacao(const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetMovimentacaoRessuprimento);
      if AParams.ContainsKey('pedidoid') then
         Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid'].ToInteger()
      Else
         Query.ParamByName('pPedidoId').Value := 0;
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
        Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
        Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
        Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('produtoid') then
         Query.ParamByName('pProdutoid').Value := AParams.Items['produtoid'].ToInteger()
      Else
         Query.ParamByName('pProdutoId').Value := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('MovimentacaoRessuprimento.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para gerar o Resumo da Produção.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro: PedidoSaida/GetMovimentacao', TUtil.TratarExcessao(E.Message))));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetPedidoAll(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr, pRegistroERP: String;
  pRotaId, pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer): TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlPedido);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni = 0 then
         Query.ParamByName('pDataIni').Value := pDataIni
      Else
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
      if pDataFin = 0 then
         Query.ParamByName('pDataFin').Value := pDataFin
      Else
         Query.ParamByName('pDataFin').Value  := FormatDateTime('YYYY-MM-DD', pDataFin);
      Query.ParamByName('pCodigoERP').Value   := pCodigoERP;
      Query.ParamByName('pPessoaId').Value    := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRazao').Value       := '%' + pRazao + '%';
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      Query.ParamByName('pRotaId').Value      := pRotaId;
      Query.ParamByName('pProcessoId').Value  := pProcessoId;
      Query.ParamByName('pMontarCarga').Value := pMontarCarga;
      Query.ParamByName('pCodProduto').Value  := pCodProduto;
      Query.ParamByName('pPedidoPendente').Value := pPedidoPendente;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoAll.Sql');
      Query.ParamByName('pOperacaoTipoId').Value := 2;
      // FConexao.Query.ResourceOptions.CmdExecMode := amAsync;
      Query.Open;
      // while FConexao.Query.Command.State = csExecuting do begin
      // do something while query is executing
      // end;
      // FConexao.Query.ResourceOptions.CmdExecMode := amBlocking;
      if Query.IsEmpty then
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
        while Not Query.Eof do Begin
          JsonRetorno := TJsonObject.Create();
          JsonRetorno.AddPair('pedidoid', TJsonNumber.Create(Query.FieldByName('PedidoId').Asinteger));
          JsonRetorno.AddPair('operacaotipoid', TJsonNumber.Create(Query.FieldByName('OperacaoTipoId').Asinteger));
          JsonRetorno.AddPair('operacao', Query.FieldByName('OperacaoTipo').AsString);
          JsonRetorno.AddPair('pessoaid', TJsonNumber.Create(Query.FieldByName('PessoaId').Asinteger));
          JsonRetorno.AddPair('codpessoaerp', TJsonNumber.Create(Query.FieldByName('CodPessoaErp').Asinteger));
          JsonRetorno.AddPair('razao', Query.FieldByName('Razao').AsString);
          JsonRetorno.AddPair('documentooriginal', Query.FieldByName('DocumentoOriginal').AsString);
          JsonRetorno.AddPair('documentonr', Query.FieldByName('DocumentoNr').AsString);
          JsonRetorno.AddPair('documentodata', DateToStr(Query.FieldByName('DocumentoData').AsDateTime));
          JsonRetorno.AddPair('dtinclusao', DateToStr(Query.FieldByName('DtInclusao').AsDateTime));
          JsonRetorno.AddPair('hrinclusao', TimeToStr(StrToTime(Copy(Query.FieldByName('HrInclusao').AsString, 1, 8))));
          JsonRetorno.AddPair('armazemid', TJsonNumber.Create(Query.FieldByName('ArmazemId').Asinteger));
          JsonRetorno.AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').Asinteger));
          JsonRetorno.AddPair('rotaid', TJsonNumber.Create(Query.FieldByName('RotaId').Asinteger));
          JsonRetorno.AddPair('rota', Query.FieldByName('Rota').AsString);
          JsonRetorno.AddPair('processoid', TJsonNumber.Create(Query.FieldByName('ProcessoId').Asinteger));
          JsonRetorno.AddPair('dtprocesso', Query.FieldByName('DtProcesso').AsString);
          JsonRetorno.AddPair('etapa', Query.FieldByName('Etapa').AsString);
          JsonRetorno.AddPair('cargaid', TJsonNumber.Create(Query.FieldByName('CargaId').Asinteger));
          JsonRetorno.AddPair('processoidcarga', TJsonNumber.Create(Query.FieldByName('ProcessoIdCarga').Asinteger));
          JsonRetorno.AddPair('processocarga', Query.FieldByName('ProcessoCarga').AsString);
          JsonRetorno.AddPair('carregamentoid', TJsonNumber.Create(Query.FieldByName('CarregamentoId').Asinteger));
          JsonRetorno.AddPair('picking', TJsonNumber.Create(Query.FieldByName('Picking').Asinteger));
          JsonRetorno.AddPair('itens', TJsonNumber.Create(Query.FieldByName('Itens').Asinteger));
          JsonRetorno.AddPair('demanda', TJsonNumber.Create(Query.FieldByName('Demanda').Asinteger));
          JsonRetorno.AddPair('qtdsuprida', TJsonNumber.Create(Query.FieldByName('QtdSuprida').Asinteger));
          JsonRetorno.AddPair('registroerp', Query.FieldByName('RegistroERP').AsString);
          JsonRetorno.AddPair('uuid', Query.FieldByName('uuid').AsString);
          JsonRetorno.AddPair('tvolumes', TJsonNumber.Create(Query.FieldByName('TVolCxaFechada').Asinteger+
                              Query.FieldByName('TVOlFracionado').Asinteger+Query.FieldByName('Cancelado').Asinteger));
          JsonRetorno.AddPair('tvolCxaFechada', TJsonNumber.Create(Query.FieldByName('TVolCxaFechada').Asinteger));
          JsonRetorno.AddPair('tvolFracionado', TJsonNumber.Create(Query.FieldByName('TVOlFracionado').Asinteger));
          JsonRetorno.AddPair('cancelado', TJsonNumber.Create(Query.FieldByName('Cancelado').Asinteger));
          JsonRetorno.AddPair('peso', TJsonNumber.Create(Query.FieldByName('Peso').AsFloat));
          JsonRetorno.AddPair('volcm3', TJsonNumber.Create(Query.FieldByName('VolCm3').AsFloat));
          JsonRetorno.AddPair('volm3', TJsonNumber.Create(Query.FieldByName('Volm3').AsFloat));
          JsonRetorno.AddPair('processado', TJsonNumber.Create(Query.FieldByName('Processado').Asinteger));
          JsonRetorno.AddPair('concluido', TJsonNumber.Create(Query.FieldByName('Concluido').Asinteger));
          Result.AddElement(JsonRetorno);
          // tJson.ObjectToJsonObject(PedidoSaida, [joDateFormatISO8601]));
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;

end;

function TPedidoSaidaDao.GetPedidoProcesso(pPedidoId: Integer): TjSonArray;
Var JsonVolumeHistorico: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlPedidoProcesso);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoProcesso.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoProcesso - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetPedidoResumoAtendimento(pPedidoId: Integer;
  pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetPedidoResumoAtendimento);
      Query.ParamByName('pPedidoId').Value    := pPedidoId;
      Query.ParamByName('pDivergencia').Value := pDivergencia;
      Query.ParamByName('pDataInicial').Value := 0;
      Query.ParamByName('pDataFinal').Value   := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoResumoAtendimento.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
        raise Exception.Create('Processo: GetPedidoResumoAtendimento - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetAuditoriaSaidaPorProduto(const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetAuditoriaSaidaPorProduto);
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('pedidoid') then
         Query.ParamByName('pPedidoid').Value := AParams.Items['pedidoid'].ToInteger()
      Else
         Query.ParamByName('pPedidoId').Value := 0;
      if AParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := AParams.Items['codproduto'].ToInteger()
      Else
         Query.ParamByName('pusuarioid').Value := 0;
      if AParams.ContainsKey('descrlote') then
         Query.ParamByName('pDescrLote').Value := AParams.Items['descrlote']
      Else
        Query.ParamByName('pDescrLote').Value := '';
      if AParams.ContainsKey('ressuprimento') then
         Query.ParamByName('pRessuprimento').Value := AParams.Items['ressuprimento']
      Else
        Query.ParamByName('pRessuprimento').Value := '';
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('SaidaPorProduto.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
        Result := Query.ToJSONArray;
    Except ON E: Exception do
      raise Exception.Create('Processo: GetAuditoriaSaidaPorProduto - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetClientesRotaCarga(const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
   Try
      Query.SQL.Add(TuEvolutConst.SqlPedidoCarga);
      If AParams.ContainsKey('pedidoid') then
         Query.ParamByName('pPedidoId').AsLargeInt := AParams.Items['pedidoid'].ToInt64
      Else
         Query.ParamByName('pPedidoId').Value := 0;
      Try
        if AParams.ContainsKey('dataini') then
           Query.ParamByName('pDataIni').Value := StrToDate(AParams.Items['dataini'])
        Else
           Query.ParamByName('pDataIni').Value := 0;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
        Exit;
      End;
      Try
        if AParams.ContainsKey('datafin') then
           Query.ParamByName('pDataFin').Value := StrToDate(AParams.Items['datafin'])
        Else
           Query.ParamByName('pDataFin').Value := 0;
      Except
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
        Exit;
      End;
      If AParams.ContainsKey('pessoaid') then
         Query.ParamByName('pPessoaId').AsLargeInt := AParams.Items['pessoaid'].ToInt64
      Else
         Query.ParamByName('pPessoaId').Value := 0;
      If AParams.ContainsKey('razao') then
         Query.ParamByName('pRazao').AsString := AParams.Items['razao']
      Else
         Query.ParamByName('pRazao').AsString := '';
      If AParams.ContainsKey('rotaid') then
         Query.ParamByName('pRotaId').AsLargeInt := AParams.Items['rotaid'].ToInteger()
      Else
         Query.ParamByName('pRotaId').Value := 0;
      Query.ParamByName('pOperacaoTipoId').Asinteger := 2;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoCarga.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create();
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não há dados para gerar o relatório')));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do Begin
      raise Exception.Create('Processo: ClientesRotaCargas - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetConsultaReposicao(Const AParams : TDictionary<string, string>): TjSonArray;
var vQryBasico, vQry: TFDQuery;
    vErroBody : TJsonArray;
begin
  Try
    vQryBasico := TFdQuery.Create(Nil);
    vQry := TFdQuery.Create(Nil);
    Try
      vQryBasico.Connection := Connection;
      vQry.Connection       := Connection;
      vQryBasico.SQL.Add(TuEvolutConst.SqlGetConsultaReposicaoBasico);
      vQry.SQL.Add(TuEvolutConst.SqlGetConsultaReposicao);
      if AParams.ContainsKey('datainicial') then Begin
         vQryBasico.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
         vQry.ParamByName('pdatainicial').Value       := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
      End
      Else Begin
         vQryBasico.ParamByName('pdatainicial').Value := 0;
         vQry.ParamByName('pdatainicial').Value       := 0;
      End;
      if AParams.ContainsKey('datafinal') then Begin
         vQryBasico.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
         vQry.ParamByName('pdatafinal').Value       := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
      End
      Else Begin
         vQryBasico.ParamByName('pdatafinal').Value := 0;
         vQry.ParamByName('pdatafinal').Value       := 0;
      End;
      if AParams.ContainsKey('reposicaoid') then Begin
         vQryBasico.ParamByName('pReposicaoId').Value := AParams.Items['reposicaoid'].ToInteger();
         vQry.ParamByName('pReposicaoId').Value       := AParams.Items['reposicaoid'].ToInteger();
      End
      Else Begin
         vQryBasico.ParamByName('pReposicaoId').Value := 0;
         vQry.ParamByName('pReposicaoId').Value       := 0;
      End;
      if AParams.ContainsKey('processoid') then Begin
         vQryBasico.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
         vQry.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
      End
      Else Begin
         vQryBasico.ParamByName('pProcessoId').Value := 0;
         vQry.ParamByName('pProcessoId').Value       := 0;
      End;
      if AParams.ContainsKey('pendente') then Begin
         vQryBasico.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
         vQry.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
      End
      Else Begin
         vQryBasico.ParamByName('pPendente').Value := 99;
         vQry.ParamByName('pPendente').Value       := 99;
      End;
      if AParams.ContainsKey('usuarioid') then Begin
         vQryBasico.ParamByName('pUsuarioId').Value := AParams.Items['usuarioid'].ToInteger();
         vQry.ParamByName('pUsuarioId').Value := AParams.Items['usuarioid'].ToInteger();
      End
      Else Begin
         vQryBasico.ParamByName('pUsuarioId').Value := 0;
         vQry.ParamByName('pUsuarioId').Value       := 0;
      End;
      if DebugHook <> 0 then
         vQryBasico.SQL.SaveToFile('ReposicaoConsultaBasico.Sql');
      vQryBasico.Open();
      if vQryBasico.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
      End
      Else Begin
         if DebugHook <> 0 then
            vQry.SQL.SaveToFile('ReposicaoConsulta.Sql');
         vQry.Open();
         if vQry.IsEmpty then Begin
            Result := TjSonArray.Create;
            vErroBody := TJsonArray.Create;
            vErroBody.AddElement(TJsonObject.Create.AddPair('Erro', 'Reposição sem itens para coleta.'));
            Result.AddElement(TJsonObject.Create.AddPair('header', vQryBasico.ToJSONArray())
                                                .AddPair('body', vErroBody ));
        End
        Else Begin
           Result := TjSonArray.Create;
           Result.AddElement(TJsonObject.Create.AddPair('header', vQryBasico.ToJSONArray()).AddPair('body', vQry.ToJSONArray()));
        End;
      End;
      vQryBasico.Close;
      vQry.Close;
    Except On E: Exception do Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TUTil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(vQryBasico);
    FreeAndNil(vQry);
  End;
end;

function TPedidoSaidaDao.GetConsultaReposicaoProduto(pReposicaoId: Integer) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetConsultaReposicaoProduto);
      Query.ParamByName('pReposicaoId').Value := pReposicaoId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoConsultaProduto.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ConsultaReposicaoProduto - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetCortes(const AParams: TDictionary<string, string>) : TjSonArray;
var JsonProduto: TJsonObject;
    pPedidoId, pCodProduto: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if AParams.ContainsKey('sintetico') then
         Query.SQL.Add(TuEvolutConst.SqlGetPedidoCortesSintetico)
      Else
         Query.SQL.Add(TuEvolutConst.SqlGetPedidoCortes);
      if AParams.ContainsKey('dataini') then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if AParams.ContainsKey('datafin') then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
      Else
         Query.ParamByName('pDataFin').Value := 0;
      pPedidoId   := 0;
      pCodProduto := 0;
      if AParams.ContainsKey('pedidoid') then
         pPedidoId := AParams.Items['pedidoid'].ToInteger;
      if AParams.ContainsKey('codproduto') then
         pCodProduto := AParams.Items['codproduto'].ToInteger;
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AParams.ContainsKey('codpessoaerp') then
         Query.ParamByName('pCodPessoaERP').Value := AParams.Items['codpessoaerp'].ToInteger
      Else
         Query.ParamByName('pCodPessoaERP').Value := 0;
      if AParams.ContainsKey('rotaid') then
         Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger
      Else
         Query.ParamByName('pRotaId').Value := 0;
      if AParams.ContainsKey('documentonr') then
         Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr']
      Else
         Query.ParamByName('pDocumentoNr').Value := '';

      if DebugHook <> 0 then
         if AParams.ContainsKey('sintetico') then
            Query.SQL.SaveToFile('CortesSintetico.Sql')
         Else
            Query.SQL.SaveToFile('CortesAnalitico.Sql');
      Query.ResourceOptions.CmdExecTimeout := 30000*3;
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Corte - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetPendente: TjSonArray;
var
  vSql: String;
  ObjPedidoProduto: TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := TuEvolutConst.SqlPedidoProcessar;
      Query.SQL.Add(vSql);
      Query.ParamByName('pPedidoId').Value := 0;
      Query.ParamByName('pDataIni').Value := 0;
      Query.ParamByName('pDataFin').Value := 0;
      Query.ParamByName('pCodigoERP').Value := 0;
      Query.ParamByName('pPessoaId').Value := 0;
      Query.ParamByName('pDocumentoNr').Value := '';
      Query.ParamByName('pRazao').Value := '';
      Query.ParamByName('pRegistroERP').Value := '';
      Query.ParamByName('pRotaId').Value := 0;
      Query.ParamByName('pRotaIdFinal').Value := 0;
      Query.ParamByName('pZonaId').Value := 0;
      Query.ParamByName('pProcessoId').Value := 1;
      Query.ParamByName('pRecebido').Value := 1;
      Query.ParamByName('pCubagem').Value := 0;
      Query.ParamByName('pEtiqueta').Value := 0;
      Query.ParamByName('pPrintTag').Value := 2;
      Query.ParamByName('pEmbalagem').Value := 2;
      // Todos os pedidos disponíveis para processamento
      // vSql := vSql + ' Where PedidoId = '+pPedidoId.ToString+' and Ped.OperacaoTipoId = 2';
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
        While Not Query.Eof do Begin
          PedidoSaida.PedidoId                    := Query.FieldByName('PedidoId').Asinteger;
          PedidoSaida.OperacaoTipo.OperacaoTipoId := Query.FieldByName('OperacaoTipoId').Asinteger;
          PedidoSaida.OperacaoTipo.Descricao      := Query.FieldByName('OperacaoTipo').AsString;
          PedidoSaida.Pessoa.PessoaId             := Query.FieldByName('PessoaId').Asinteger;
          PedidoSaida.Pessoa.Razao                := Query.FieldByName('Razao').AsString;
          PedidoSaida.DocumentoNr                 := Query.FieldByName('DocumentoNr').AsString;
          PedidoSaida.DocumentoData               := Query.FieldByName('DocumentoData').AsDateTime;
          PedidoSaida.DtInclusao                  := Query.FieldByName('DtInclusao').AsDateTime;
          PedidoSaida.HrInclusao                  := Query.FieldByName('HrInclusao').AsDateTime;
          PedidoSaida.ArmazemId                   := Query.FieldByName('ArmazemId').Asinteger;
          PedidoSaida.Status                      := Query.FieldByName('Status').Asinteger;
          PedidoSaida.uuid                        := Query.FieldByName('uuid').AsString;
          // vQryProduto.Open('Declare @Pedido Integer = '+Query.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
          ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
          ArrayPedidoProdutoDAO := ObjPedidoSaidaItensDAO.GetId(0);
          // vQryProduto.FieldByName('PedidoId').AsInteger);
          for vItens := 0 to ArrayPedidoProdutoDAO.Count - 1 do Begin
            ObjPedidoProduto := ObjPedidoProduto.JsonToClass(ArrayPedidoProdutoDAO.Items[vItens].ToString());
            PedidoSaida.ListProduto.Add(ObjPedidoProduto);
          End;
          Result.AddElement(tJson.ObjectToJsonObject(PedidoSaida, [joDateFormatISO8601]));
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    ObjPedidoProduto      := Nil;
    ArrayPedidoProdutoDAO := nil;
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetProducaoPendente: TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetProducaoPendente);
      Query.Open;
      Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetProdutoReposicao(const AParams : TDictionary<string, string>): TjSonArray;
var JsonProduto: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('Select ProdutoId, CodProduto, Descricao, EnderecoId, Endereco, FatorConversao, EmbalagemPadrao, ');
      Query.SQL.Add('       Quantidade, Fracionado, EstPicking, (Fracionado-EstPicking) QtdReposicao');
      Query.SQL.Add('From');
      Query.SQL.Add('   (Select PP.ProdutoId, Prd.CodProduto, Prd.Descricao, TEnd.EnderecoId, TEnd.Descricao Endereco, Prd.FatorConversao, PP.EmbalagemPadrao,');
      Query.SQL.Add('           Sum(PP.Quantidade) Quantidade,');
      Query.SQL.Add('           Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade /  Prd.FatorConversao) Else 0 End)) CaixaFechada ,');
      Query.SQL.Add('		         Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End)) Fracionado');
      Query.SQL.Add('           , Est.Estoque EstPicking--, ((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End) - Est.Estoque) As QtdReposicao');
      Query.SQL.Add('   From Pedido Ped');
      Query.SQL.Add('   Inner Join PedidoProdutos PP ON PP.PedidoId = Ped.PedidoId');
      Query.SQL.Add('			Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId');
      Query.SQL.Add('			Left Join Enderecamentos TEnd On TEnd.EnderecoId = Prd.EnderecoId');
      Query.SQL.Add('   Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData');
      Query.Sql.Add('Inner Join vDocumentoEtapas De on De.Documento = Pv.uuid and --De.Horario = DeM.horario and');
      Query.Sql.Add('                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento) --and Horario = De.Horario) ');
      Query.SQL.Add('			Left Join (Select ProdutoId, SUM(Qtde) Estoque ');
      Query.SQL.Add('              From vEstoqueProducao ');
      Query.SQL.Add('              where PickingFixo = 1');
      Query.SQL.Add('              Group by ProdutoId) Est ON Est.ProdutoId = PP.ProdutoId');
      Query.SQL.Add('			Where De.ProcessoId <> 15');
      Query.SQL.Add('		   and Ped.OperacaoTipoId = 2');
      if AParams.ContainsKey('datapedido') then begin
         Query.SQL.Add(' 		      and Dp.Data = :DataPedido ');
         Query.ParamByName('datapedido').Value := AParams.Items['datapedido'];
      end;
      Query.SQL.Add('			Group by PP.ProdutoId, Prd.CodProduto, Prd.Descricao, TEnd.EnderecoId, ');
      Query.SQL.Add('            TEnd.Descricao, Prd.FatorConversao, PP.EmbalagemPadrao, Est.Estoque');
      Query.SQL.Add(') as ProdReposicao');
      // Query.SQL.Add('where (Fracionado-EstPicking) > 0');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

Function TPedidoSaidaDao.GetRelAnaliseRessuprimento(const AParams : TDictionary<string, string>; pVolume: Boolean): TjSonArray;
var vDtInicio, vDtTermino: TDate;
    vRotaId: Integer;
    vPessoaId: Integer;
    Query : TFdQuery;
begin
  vDtInicio := 0;
  vDtTermino := 0;
  vRotaId := 0;
  vPessoaId := 0;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if pVolume then
         Query.SQL.Add(TuEvolutConst.SqlRelAnaliseRessuprimentoVolume)
      Else
         Query.SQL.Add(TuEvolutConst.SqlRelAnaliseRessuprimento);
      if AParams.ContainsKey('dtinicio') then
         vDtInicio := StrToDate(AParams.Items['dtinicio']);
      if AParams.ContainsKey('dttermino') then
         vDtTermino := StrToDate(AParams.Items['dttermino']);
      if vDtInicio = 0 then
         Query.ParamByName('pDtInicio').Value := vDtInicio
      Else
         Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', vDtInicio);
      if vDtTermino = 0 then
         Query.ParamByName('pDtTermino').Value := vDtTermino
      Else
         Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', vDtTermino);
      if AParams.ContainsKey('rotaid') then
         vRotaId := StrToIntDef(AParams.Items['rotaid'], 0);
      Query.ParamByName('pRotaId').Value := vRotaId;
      if AParams.ContainsKey('codpessoaerp') then
         vPessoaId := StrToIntDef(AParams.Items['codpessoaerp'], 0);
      if (pVolume) then Begin
        If (AParams.ContainsKey('zonaid')) then
           Query.ParamByName('pZonaId').Value := StrToIntDef(AParams.Items['zonaid'], 0)
        Else
           Query.ParamByName('pZonaId').Value := 0;
      End;
      Query.ParamByName('pCodPessoaERP').Value := vPessoaId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('AnaliseRessuprimentos.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: AnaliseRessuprimento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetRelApanhePicking(Const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelApahaPicking);
      if AParams.ContainsKey('dataini') then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if AParams.ContainsKey('datafin') then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
      Else
         Query.ParamByName('pDataFin').Value := 0;
      if AParams.ContainsKey('codpessoaerp') then
         Query.ParamByName('pCodPessoaERP').Value := StrToIntDef(AParams.Items['codpessoaerp'], 0)
      Else
         Query.ParamByName('pCodPessoaERP').Value := 0;
      if AParams.ContainsKey('rotaid') then
         Query.ParamByName('pRotaId').Value := StrToIntDef(AParams.Items['rotaid'], 0)
      Else
         Query.ParamByName('pRotaId').Value := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ApanhePicking.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: RelApanhePicking - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetRelColetaPulmao(Const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelColetaPulmao);
      if AParams.ContainsKey('dataini') then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if AParams.ContainsKey('datafin') then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
      Else
         Query.ParamByName('pDataFin').Value := 0;
      if AParams.ContainsKey('codpessoaerp') then
         Query.ParamByName('pCodPessoaERP').Value := StrToIntDef(AParams.Items['codpessoaerp'], 0)
      Else
         Query.ParamByName('pCodPessoaERP').Value := 0;
      if AParams.ContainsKey('rotaid') then
         Query.ParamByName('pRotaId').Value := StrToIntDef(AParams.Items['rotaid'], 0)
      Else
         Query.ParamByName('pRotaId').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pzonaid').Value := StrToIntDef(AParams.Items['zonaid'], 0)
      Else
        Query.ParamByName('pzonaid').Value := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ColetaPulmao.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do Begin
      raise Exception.Create('Processo: RelColetaPulmao - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetRelRupturaAbastecimento(pDataIni,
  pDataFin: TDateTime): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelRupturaAbastecimento);
      if pDataIni = 0 then
         Query.ParamByName('pDataIni').Value := 0
      Else
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
      if pDataFin = 0 then
         Query.ParamByName('pDataFin').Value := 0
      Else
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin);
      Query.Open();
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('RupturaAbastecimento.Sql');
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: RelRupturaAbastecimento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetReposicaoAutomatica(const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetReposicaoAutomatica);
      Try
        If AParams.ContainsKey('data') then
           if StrToDate(AParams.Items['data']) = 0 then
             Query.ParamByName('pDataReposicao').Value := 0
          Else
             Query.ParamByName('pDataReposicao').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['data']))
        Else
           Query.ParamByName('pDataReposicao').Value := 0;
      Except
        Begin
          Result := TjSonArray.Create;
          Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data de Reposição inválida!')));
          Exit;
        End;
      End;
      If AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger
      Else
         Query.ParamByName('pZonaId').Value := 0;
      If AParams.ContainsKey('enderecoinicial') then
         Query.ParamByName('penderecoinicial').Value := AParams.Items['enderecoinicial']
      Else
         Query.ParamByName('penderecoinicial').Value := '';
      If AParams.ContainsKey('enderecofinal') then
         Query.ParamByName('penderecofinal').Value := AParams.Items['enderecofinal']
      Else
         Query.ParamByName('penderecofinal').Value := '';
      Query.ParamByName('pStatus').Value := 0;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoAutomatica.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não há dados para gerar Coleta da Reposição')));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoAutomatica - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetReposicaoAutomaticaColeta(const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetReposicaoAutomaticaColeta);
      Try
        If AParams.ContainsKey('data') then
          if StrToDate(AParams.Items['data']) = 0 then
             Query.ParamByName('pDataReposicao').Value := 0
          Else
             Query.ParamByName('pDataReposicao').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['data']))
        Else
           Query.ParamByName('pDataReposicao').Value := 0;
      Except
        Begin
          Result := TjSonArray.Create;
          Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data de Reposição inválida!')));
          Exit;
        End;
      End;
      If AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger
      Else
         Query.ParamByName('pZonaId').Value := 0;
      If AParams.ContainsKey('enderecoinicial') then
         Query.ParamByName('penderecoinicial').Value := AParams.Items['enderecoinicial']
      Else
         Query.ParamByName('penderecoinicial').Value := '';
      If AParams.ContainsKey('enderecofinal') then
         Query.ParamByName('penderecofinal').Value := AParams.Items['enderecofinal']
      Else
         Query.ParamByName('penderecofinal').Value := '';
      Query.ParamByName('pStatus').Value := 0;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoAutomaticaColeta.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não há dados para gerar Coleta da Reposição')));
         Exit;
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoAutomaticaColeta - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetReposicaoEnderecoColeta(pData: TDate;
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.GetReposicaoEnderecoColeta);
      Query.ParamByName('pDataPedido').Value := FormatDateTime('YYYY-MM-DD', pData);
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pEnderecoInicial').Value := pEnderecoInicial;
      Query.ParamByName('pEnderecoFinal').Value := pEnderecoFinal;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoColetaEndereco.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoEnderecoColeta - '+Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetReposicaoGerar(pData: TDate; pZonaId: Integer;
  pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlGetGerarReposicao);
      // Query.Sql.Add('Order by Prd.ZonaDescricao, Prd.Descricao');
      Query.ParamByName('pDataPedido').Value := FormatDateTime('YYYY-MM-DD', pData);
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pEnderecoIni').Value := pEnderecoInicial;
      Query.ParamByName('pEnderecoFin').Value := pEnderecoFinal;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoGerar.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)))
      End
      Else
        Result := Query.ToJSONArray;
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetReposicaoModelo(pModeloId: Integer): TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Declare @ModeloId Integer = :pModeloId');
      Query.SQL.Add('Select * from vReposicaoModelo');
      Query.SQL.Add('Where (@ModeloId = 0 or ReposicaoModeloId = @ModeloId)');
      Query.ParamByName('pModeloId').Value := pModeloId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoModelo.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoModelo - '+TUtil.TratarExcessao(e.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetResumoProducao(Const AParams : TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetResumoOperacao);
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('processoid') then
         Query.ParamByName('pprocessoid').Value := AParams.Items['processoid'].ToInteger()
      Else
        Query.ParamByName('pprocessoid').Value := 0;
      if AParams.ContainsKey('usuarioid') then
         Query.ParamByName('pusuarioid').Value := AParams.Items['usuarioid'].ToInteger()
      Else
        Query.ParamByName('pusuarioid').Value := 0;
      if AParams.ContainsKey('dtpedidoini') then
         Query.ParamByName('pDtPedidoIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidoini']))
      Else
        Query.ParamByName('pDtPedidoIni').Value := 0;
      if AParams.ContainsKey('dtpedidofin') then
         Query.ParamByName('pdtpedidofin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidofin']))
      Else
        Query.ParamByName('pdtpedidofin').Value := 0;
      If DebugHook <> 0 Then
         Query.SQL.SaveToFile('ResumoProducao.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para gerar o Resumo da Produção.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: ResumoProducao - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetSqlAtendimentoVolumes(pZonaIdStr: String): String;
begin
  Result := 'declare @DtInicio DateTime  = :pDtInicio' +sLineBreak+
            'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
            'Declare @RotaId Integer     = :pRotaid' + sLineBreak +
            'Declare @ZonaId Integer     = :pZonaId' + sLineBreak +
            'if object_id ('+#39+'tempdb..#PedidoVolumes'+#39+') is not null Drop table #PedidoVolumes'+sLineBreak+
            'if object_id ('+#39+'tempdb..#PedidoVolumeResumo'+#39+') is not null Drop table #PedidoVolumeResumo'+sLineBreak+
            'if object_id ('+#39+'tempdb..#VolumeFinal'+#39+') is not null Drop table #VolumeFinal'+sLineBreak+
            'Select Vl.ZonaId, Z.Descricao Zona, De.ProcessoId, Count(*) As Total Into #PedidoVolumes'+sLineBreak+
            'From Pedido Ped'+sLineBreak+
            'Left Join RotaPessoas Rp On Rp.pessoaid = Ped.PessoaId'+sLineBreak+
            'inner Join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId'+sLineBreak+
            'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData'+sLineBreak+

            'Outer Apply (Select Top 1 Pl.ZonaId'+sLineBreak+
            '            From PedidoVolumeLotes Vl'+sLineBreak+
            '			Inner join vProdutoLotes Pl on Pl.LoteId = Vl.LoteId'+sLineBreak+
            '			Left join enderecamentos TEnd ON Tend.EnderecoId = Vl.EnderecoId'+sLineBreak+
            '			Where PedidoVolumeId = Pv.PedidoVolumeId'+sLineBreak+
            '			Order By Pl.ZonaId Desc) Vl'+sLineBreak+
            'Left Join EnderecamentoZonas Z On Z.ZonaId = Vl.ZonaID'+sLineBreak+
            'Cross Apply (Select Top 1 ProcessoId'+sLineBreak+
            '             From vDocumentoEtapas'+sLineBreak+
            '			 Where Documento = Pv.uuid'+sLineBreak+
            '			 Order by ProcessoId Desc) De'+sLineBreak+

            'where Ped.OperacaoTipoId = 2'+sLineBreak+
            '      and (@DtInicio = 0 or Rd.Data >= @DtInicio)'+sLineBreak+
            '      and (@DtTermino = 0 or Rd.Data <= @DtTermino)'+sLineBreak+
            '      And (@RotaId = 0 or Rp.rotaid = @RotaId)'+sLineBreak+
            '      And ProcessoId <> 31'+sLineBreak+
            '      Group By Vl.ZonaId, Z.Descricao, De.ProcessoId'+sLineBreak+
            ''+sLineBreak+
            '		select ZonaId, Zona,'+sLineBreak+
            '              (Case When Pv.ProcessoId = 1 then 1'+sLineBreak+
            '		   	      When Pv.Processoid in (2, 22) then 2'+sLineBreak+
            '		          When Pv.ProcessoId in (3, 4, 5, 6, 7, 8) then 3'+sLineBreak+
            '		          When Pv.ProcessoId in (9, 10, 11, 12) then 4'+sLineBreak+
            '			      When Pv.ProcessoId = 15 then 6'+sLineBreak+
            '			      Else 5'+sLineBreak+
            '		       End) as Processoid, Pv.Total Into #PedidoVolumeResumo'+sLineBreak+
            'From #PedidoVolumes Pv'+sLineBreak+
            ''+sLineBreak+
            'SELECT ZonaId, Zona, ProcessoId, Total Into #VolumeFinal'+sLineBreak+
            'From #PedidoVolumeResumo'+sLineBreak+
            'where (@Zonaid = 0 or ZonaId = @ZonaId)'+sLineBreak+
            ''+sLineBreak+
            'Select IsNull(ZonaId, 0) Zonaid, IsNull(Zona, '+#39+'PICKING MODIFICADO'+#39+') Zona,'+sLineBreak+
            '       Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '+#39+'Demanda'+#39+','+sLineBreak+
            '       COALESCE ([1], 0) AS '+#39+'NProcessado'+#39+', COALESCE ([2], 0) AS '+#39+'QtdProcessada'+#39+', COALESCE ([3], 0) AS '+#39+'QtdSeparacao'+#39+','+sLineBreak+
            '       COALESCE ([4], 0) AS '+#39+'QtdCheckOut'+#39+', COALESCE ([5], 0) AS '+#39+'QtdExpedido'+#39+','+sLineBreak+
            '       COALESCE ([6], 0) AS '+#39+'QtdCancelada'+#39+', 0 as QtdCorte, 0 as CorteAutomatico, Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /'+sLineBreak+
            '       Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+'+sLineBreak+
            '       Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia'+sLineBreak+
            'FROM   #VolumeFinal AS Tbl PIVOT (sum(Total)'+sLineBreak+
            '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt'+sLineBreak+
            ''+sLineBreak+
            'Order by ZonaId';
end;

function TPedidoSaidaDao.GetSaidaPorProdutoBalanceamento(
  const AParams: TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetAuditoriaSaidaPorProdutoBalanceamento);
      if AParams.ContainsKey('datainicio') then
         Query.ParamByName('pdatainicio').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicio']))
      Else
         Query.ParamByName('pdatainicio').Value := 0;
      if AParams.ContainsKey('datatermino') then
         Query.ParamByName('pdataTermino').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datatermino']))
      Else
         Query.ParamByName('pDataTermino').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      Query.SQL.Add('--datainicio = '+Query.ParamByName('pdatainicio').AsString);
      Query.SQL.Add('--dataternino = '+Query.ParamByName('pdatatermino').AsString);
      Query.SQL.Add('--zonaid = '+Query.ParamByName('pzonaid').AsString);

      if DebugHook <> 0 then
         Query.SQL.SaveToFile('SaidaPorProdutoBalanceamento.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('MSG', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
        raise Exception.Create('Processo: SaidaPorProdutoBalacamento - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.GetSqlAtendimentoUnidadesPorEmbalagem(pZonaIdStr : String) : String;
begin
  Result := 'declare @DtInicio  DateTime = :pDtInicio' + sLineBreak +
            'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
            'Declare @RotaId Integer = :pRotaId' + sLineBreak +
            'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
            'if object_id ('+#39+'tempdb..#Pedidos'+#39+') is not null drop table #Pedidos'+sLineBreak+
            'Select Pv.EmbalagemId, De.ProcessoId, Sum(Pvl.qtdSuprida) Total Into #Pedidos'+sLineBreak+
            'From PedidoVolumeLotes Pvl'+sLineBreak+
            'Inner Join vProdutoLotes Pl On Pl.LoteId = Pvl.LoteId'+sLineBreak+
            'Inner join PedidoVolumes Pv On Pv.PedidoVolumeId = Pvl.PedidoVolumeId'+sLineBreak+
            'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId'+sLineBreak+
            'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId'+sLineBreak+
            'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId'+sLineBreak+
            'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid'+sLineBreak+
            'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData'+sLineBreak+
            'where DE.ProcessoId = (Select Max(ProcessoId) From vDocumentoEtapas'+sLineBreak+
            '                       where Documento = Pv.uuid) and Ped.OperacaoTipoId = 2'+sLineBreak+
            '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'+sLineBreak+
            '	  and ProcessoId <= 15'+sLineBreak+
            '      And (@RotaId = 0 or Rp.rotaid = @RotaId)';
  If pZonaIdStr <> '' then
     Result := Result+sLineBreak+'      And ( Pl.ZonaId in ('+pZonaIdStr+') )';
  Result := Result+sLineBreak+'Group By Pv.EmbalagemId, De.ProcessoId'+sLineBreak+
            ''+sLineBreak+
            'Select EmbalagemId, COALESCE ([2], 0) AS '+#39+'Cubagem'+#39+', COALESCE ([3], 0) AS '+#39+'Apanhe'+#39+', '+sLineBreak+
            '       COALESCE ([4], 0) AS '+#39+'CheckOut'+#39+', COALESCE ([5], 0) AS '+#39+'Expedicao'+#39+', '+sLineBreak+
            '       COALESCE ([6], 0) AS '+#39+'Cancelado'+#39+sLineBreak+
            'FROM   (SELECT EmbalagemId, ProcessoId, Total'+sLineBreak+
            '        FROM (select EmbalagemId,'+sLineBreak+
            '              (Case When Ped.ProcessoId = 1 then 1'+sLineBreak+
            '		   	      When Ped.Processoid in (2, 22) then 2'+sLineBreak+
            '		          When Ped.ProcessoId in (3, 7, 8) then 3'+sLineBreak+
            '		          When Ped.ProcessoId in (9, 10, 11, 12) then 4'+sLineBreak+
            '			      When Ped.ProcessoId = 15 then 6'+sLineBreak+
            '			      When Ped.ProcessoId = 99 then 7'+sLineBreak+
            '			      Else 5'+sLineBreak+
            '		       End) as Processoid, Ped.Total'+sLineBreak+
            'From #Pedidos as Ped) as P) AS Tbl PIVOT (sum(Total)'+sLineBreak+
            '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6], [7])) AS Pvt'+sLineBreak+
            'Order by EmbalagemId';
end;

function TPedidoSaidaDao.GetSqlAtendimentoVolumesPorEmbalagem(pZonaIdStr : String) : String;
begin
  Result := 'declare @DtInicio DateTime = :pDtInicio'+sLineBreak+
            'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
            'Declare @RotaId Integer = :pRotaId'+sLineBreak+
            'Declare @ZonaId Integer = :pZonaId'+sLineBreak+
            'if object_id ('+#39+'tempdb..#PedidoVolumes'+#39+') is not null Drop table #PedidoVolumes'+sLineBreak+
            'if object_id ('+#39+'tempdb..#PedidoVolumeResumo'+#39+') is not null Drop table #PedidoVolumeResumo'+sLineBreak+
            'if object_id ('+#39+'tempdb..#VolumeFinal'+#39+') is not null Drop table #VolumeFinal' + sLineBreak +
            'Select Pv.EmbalagemId, De.ProcessoId, Count(*) As Total Into #PedidoVolumes'+sLineBreak+
            'From Pedido Ped'+sLineBreak+
            'Left Join RotaPessoas Rp On Rp.pessoaid = Ped.PessoaId'+sLineBreak+
            'inner Join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId'+sLineBreak+
            'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData'+sLineBreak+
            'Outer Apply (Select Top 1 Pl.ZonaId'+sLineBreak+
            '            From PedidoVolumeLotes Vl'+sLineBreak+
            '			Inner join vProdutoLotes Pl on Pl.LoteId = Vl.LoteId'+sLineBreak+
            '			Left join enderecamentos TEnd ON Tend.EnderecoId = Vl.EnderecoId'+sLineBreak+
            '			Where PedidoVolumeId = Pv.PedidoVolumeId'+sLineBreak+
            '			Order By Pl.ZonaId Desc) Vl'+sLineBreak+
            'Left Join EnderecamentoZonas Z On Z.ZonaId = Vl.ZonaID'+sLineBreak+
            'Cross Apply (Select Top 1 ProcessoId'+sLineBreak+
            '             From vDocumentoEtapas'+sLineBreak+
            '			        Where Documento = Pv.uuid'+sLineBreak+
            '			        Order by ProcessoId Desc) De'+sLineBreak+
            'where Ped.OperacaoTipoId = 2'+sLineBreak+
            '  and (@DtInicio = 0 or Rd.Data >= @DtInicio)'+sLineBreak+
            '  and (@DtTermino = 0 or Rd.Data <= @DtTermino)'+sLineBreak+
            '  And (@RotaId = 0 or Rp.rotaid = @RotaId)'+sLineBreak+
            '  And ProcessoId <> 31'+sLineBreak+
            '  And (@Zonaid = 0 or Vl.ZonaId = @ZonaId)'+sLineBreak+
            'Group By Pv.EmbalagemId,  De.ProcessoId'+sLineBreak+
            ''+sLineBreak+
            'select EmbalagemId, '+sLineBreak+
            '       (Case When Pv.ProcessoId = 1 then 1'+sLineBreak+
            '		   	      When Pv.Processoid in (2, 22) then 2'+sLineBreak+
            '		          When Pv.ProcessoId in (3, 7, 8) then 3'+sLineBreak+
            '		          When Pv.ProcessoId in (9, 10, 11, 12) then 4'+sLineBreak+
            '			        When Pv.ProcessoId = 15 then 6'+sLineBreak+
            '			        Else 5'+sLineBreak+
            '		     End) as Processoid, Pv.Total Into #PedidoVolumeResumo'+sLineBreak+
            'From #PedidoVolumes Pv'+sLineBreak+
            ''+sLineBreak+
            'SELECT EmbalagemId, ProcessoId, Total Into #VolumeFinal'+sLineBreak+
            'From #PedidoVolumeResumo'+sLineBreak+
            ''+sLineBreak+
            'Select EmbalagemId, '+sLineBreak+
            '       Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '+#39+'Demanda'+#39+', '+sLineBreak+
            '       COALESCE ([1], 0) AS '+#39+'Recebido'+#39+', COALESCE ([2], 0) AS '+#39+'Cubagem'+#39+', COALESCE ([3], 0) AS '+#39+'Apanhe'+#39+', '+sLineBreak+
            '       COALESCE ([4], 0) AS '+#39+'CheckOut'+#39+', COALESCE ([5], 0) AS '+#39+'Expedicao'+#39+', '+sLineBreak+
            '       COALESCE ([6], 0) AS '+#39+'Cancelado'+#39+', Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /'+sLineBreak+
            '       Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+'+sLineBreak+
            '       Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia'+sLineBreak+
            'FROM   #VolumeFinal AS Tbl PIVOT (sum(Total)                                             '+sLineBreak+
            '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt'+sLineBreak+
            'Order by EmbalagemId';
end;

function TPedidoSaidaDao.GetSqlEvolucaoAtendimentoUnidadesZona(pZonaIdStr: String): String;
begin
  Result := 'declare @DtInicio DateTime = :pDtInicio'+sLineBreak+
            'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
            'Declare @RotaId Integer = :pRotaId'+sLineBreak+
            '' + sLineBreak +
            'if object_id ('+#39+'tempdb..#Pedido'+#39+') is not null Drop table #Pedido'+sLineBreak+
            'if object_id ('+#39+'tempdb..#PedProd'+#39+') is not null Drop table #PedProd'+sLineBreak+
            'if object_id ('+#39+'tempdb..#PP'+#39+') is not null Drop table #PP'+sLineBreak+
            'if object_id ('+#39+'tempdb..#CanceladoNProcessado'+#39+') is not null Drop table #CanceladoNProcessado'+sLineBreak+
            'if object_id ('+#39+'tempdb..#VolumeLotes'+#39+') is not null Drop table #VolumeLotes'+sLineBreak+
            'if object_id ('+#39+'tempdb..#CorteAutomatico'+#39+') is not null Drop table #CorteAutomatico'+sLineBreak+
            'if object_id ('+#39+'tempdb..#VolumeProcessado'+#39+') is not null Drop table #VolumeProcessado'+sLineBreak+
            'if object_id ('+#39+'tempdb..#ProdZonas'+#39+') is not null Drop table #ProdZonas'+sLineBreak+
            ''+sLineBreak+
            'Select Ped.PedidoId,Ped.Processoid Into #Pedido'+sLineBreak+
            'From vPedidos Ped'+sLineBreak+
            'where Ped.OperacaoTipoId = 2'+sLineBreak+
            '  And (@DtInicio = 0 or Ped.DocumentoData >= @DtInicio)'+sLineBreak+
            '  and (@DtTermino = 0 or Ped.DocumentoData <= @DtTermino)'+sLineBreak+
            '  and (@RotaID = 0 or Ped.RotaId = @RotaId)'+sLineBreak+
            '  And ProcessoId <> 31'+sLineBreak+
            'Group By Ped.pedidoId, Ped.Processoid'+sLineBreak+
            ''+sLineBreak+
            'Select PP.PedidoId, IsNull(ZonaId, 0) ZonaId, Quantidade Into #ProdZonas'+sLineBreak+
            'From PedidoProdutos PP'+sLineBreak+
            'Inner Join #Pedido Ped on Ped.PedidoId = PP.Pedidoid'+sLineBreak+
            'Inner join vProduto Prd On Prd.IdProduto = PP.ProdutoId';
  If pZonaIdStr <> '' then
     Result := Result + sLineBreak+'Where Prd.ZonaId in ('+pZonaIdStr+')';
  Result := Result+sLineBreak+
            'select Ped.PedidoId, Ped.ProcessoId, PP.ZonaId, Sum(PP.Quantidade) as Demanda,'+sLineBreak+
            '       sum(Case when Ped.ProcessoId = 1 then PP.Quantidade Else 0 End) NProcessado Into #PedProd'+sLineBreak+
            'From #Pedido Ped'+sLineBreak+
            'Inner join #ProdZonas PP on PP.PedidoId = Ped.PedidoId'+sLineBreak+
            'Group by Ped.PedidoId, Ped.ProcessoId, PP.ZonaId'+sLineBreak+
            ''+sLineBreak+
            'select Pv.PedidoId, IsNull(Pl.ZonaId, 0) ZonaId, Sum(Vl.Quantidade) Quantidade Into #VolumeProcessado'+sLineBreak+
            'From PedidoVolumeLotes Vl'+sLineBreak+
            'Inner join PEdidoVOlumes Pv On Pv.PedidoVOlumeId = Vl.PedidoVolumeId'+sLineBreak+
            'Inner join #Pedido Ped On ped.PedidoId = Pv.PedidoId'+sLineBreak+
            'Inner join vProdutoLotes Pl on Pl.Loteid = vl.Loteid'+sLineBreak+
            'where ped.ProcessoId > 1'+sLineBreak+
            'Group by Pv.PedidoId, Pl.ZonaId'+sLineBreak+
            ''+sLineBreak+
            'Select IsNull(PP.ZonaId, 0) ZonaId, PP.Demanda Demanda , sum(PP.Demanda-IsNull(Vl.Quantidade, 0)) Corte  Into #CorteAutomatico'+sLineBreak+
            'from #PedProd PP'+sLineBreak+
            'Left Join #VolumeProcessado Vl on Vl.PedidoId = PP.PedidoId and Vl.Zonaid = Pp.ZonaId'+sLineBreak+
            'Where PP.Demanda <> isNull(Vl.Quantidade, 0) and'+sLineBreak+
            '      PP.ProcessoId > 1'+sLineBreak+
            'Group by Pp.Zonaid, PP.Demanda'+sLineBreak+
            ''+sLineBreak+
            'select pp.Pedidoid, IsNull(Pp.Zonaid, 0) ZonaId, sum(Pp.Demanda) CanceladoNProcessado Into #CanceladoNProcessado'+sLineBreak+
            'From #PedProd Pp'+sLineBreak+
            'Left Join PedidoVOlumes Pv On Pv.PedidoId = Pp.PedidoId'+sLineBreak+
            'where pv.pedidoid is Null and Pp.Processoid = 15'+sLineBreak+
            'Group by Pp.PedidoId, Pp.ZonaID'+sLineBreak+
            ''+sLineBreak+
            'select IsNull(Pl.Zonaid, 0) ZonaId,'+sLineBreak+
            '       sum(Vl.Quantidade) Quantidade, -- SELECT * FROM PROCESSOETAPAS'+sLineBreak+
            '	   Sum(Case When De.ProcessoId = 2 then Vl.Quantidade Else 0 End) QtdProcessada,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId = 3 then Vl.Quantidade Else 0 End) QtdImpresso,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId in (7,8) then Vl.Quantidade Else 0 End) QtdSeparacao,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId in (9, 10, 11, 12) then Vl.QtdSuprida Else 0 End) QtdCheckOut,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId >= 13 and De.ProcessoId <> 15 then Vl.QtdSuprida Else 0 End) QtdExpedido,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId <> 15 then Vl.Quantidade Else 0 End) QtdAtendimento,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId = 15 then Vl.Quantidade Else 0 End) QtdCancelada,'+sLineBreak+
            '	   Sum(Case When De.ProcessoId <> 15 then Vl.Quantidade-Vl.QtdSuprida Else 0 End) QtdCorte'+sLineBreak+
            '       Into #VolumeLotes'+sLineBreak+
            'From #Pedido Ped'+sLineBreak+
            'Inner Join PedidoVOlumes Pv On Pv.PedidoId = Ped.PedidoId'+sLineBreak+
            'Inner join PedidoVOlumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'+sLineBreak+
            'Inner join vProdutoLotes Pl on Pl.LoteId = Vl.LoteId'+sLineBreak+
            'Inner join vDocumentoEtapas De on De.Documento = Pv.Uuid'+sLineBreak+
            'Where De.ProcessoId = (Select Max(ProcessoId) From vDocumentoetapas where Documento = Pv.Uuid)'+sLineBreak+
            'Group by Pl.Zonaid'+sLineBreak+
            ''+sLineBreak+
            'select IsNull(dem.ZonaId, 0) Zonaid, IsNull(Z.Descricao, '+#39+'SEM PICKING'+#39+') Zona, Dem.Demanda, IsNull(Dem.NProcessado, 0) NProcessado,'+sLineBreak+
            '       IsNull(CNP.CanceladoNProcessado, 0) CanceladoNProcessado, IsNull(Vl.QtdProcessada, 0) QtdProcessada,'+sLineBreak+
            '	   IsNull(Vl.QtdImpresso, 0) QtdImpresso, IsNull(Vl.QtdSeparacao, 0) QtdSeparacao, IsNull(Vl.QtdCheckOut, 0) QtdCheckOut,'+sLineBreak+
            '	   IsNull(Vl.QtdExpedido, 0) QtdExpedido, IsNull(Vl.QtdAtendimento, 0) QtdAtendimento, IsNull(Vl.QtdCancelada, 0) QtdCancelada,'+sLineBreak+
            '	   IsNull(Vl.QtdCorte, 0) QtdCorte, IsNull(Ca.CorteAutomatico, 0) CorteAutomatico'+sLineBreak+
            'From (Select ZonaId, Sum(Demanda) Demanda, Sum(NProcessado) NProcessado'+sLineBreak+
            '      From #PedProd'+sLineBreak+
            '      Group by ZonaId) Dem'+sLineBreak+
            'Left join EnderecamentoZonas Z on Z.Zonaid = Dem.ZonaId'+sLineBreak+
            'Left Join (Select Zonaid, Sum(CanceladoNProcessado) CanceladoNProcessado'+sLineBreak+
            '           from #CanceladoNProcessado'+sLineBreak+
            '		   Group by ZonaId) CNP On Cnp.ZonaId = Dem.ZonaId'+sLineBreak+
            'Left Join (select ZonaId, Sum(QtdProcessada) QtdProcessada, Sum(QtdImpresso) QtdImpresso, Sum(QtdSeparacao) QtdSeparacao,'+sLineBreak+
            '                  Sum(QtdCheckOut) QtdCheckOut, Sum(QtdExpedido) QtdExpedido, Sum(QtdAtendimento) QtdAtendimento,'+sLineBreak+
            '				  Sum(QtdCancelada) QtdCancelada, Sum(QtdCorte) QtdCorte'+sLineBreak+
            '           From #VolumeLotes'+sLineBreak+
            '		   Group by ZonaId) VL On Vl.ZonaId = Dem.ZonaId'+sLineBreak+
            'Left Join (select ZonaId, sum(Corte) CorteAutomatico from #CorteAutomatico Group by ZonaId) Ca on IsnUll(Ca.ZonaId, 0) = IsNull(Dem.ZonaId, 0)';
end;

function TPedidoSaidaDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TPedidoSaidaDao.InsertUpdate(pPedidoId, pOperacaoTipoId,
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
        vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('+sLineBreaK+
                pOperacaoTipoId.ToString() + ', ' + pPessoaId.ToString() + ', ' + QuotedStr(pDocumentoNr) + ', ' +sLineBreak+
                '(select IdData From Rhema_Data where Data = ' + #39 + FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + '), ' +sLineBreak+
                SqlDataAtual + ', ' + SqlHoraAtual + ', ' + pArmazemId.ToString()
      Else
        vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +sLineBreak+
                pOperacaoTipoId.ToString() + '   , PessoaId      = ' +sLineBreak+
                pPessoaId.ToString() + '   , DocumentoNr   = ' + QuotedStr(pDocumentoNr)+sLineBreak+
                '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = ' + #39 + FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + ')' +
                // '   , DtInclusao    = '+SqlDataAtual+'   , HrInclusao    = '+SqlHoraAtual+
                '   , ArmazemId     = ' + IfThen(pArmazemId = 0, 'Null', pArmazemId.ToString())+sLineBreak+
                ' where PedidoId = ' + pPedidoId.ToString + ' and OperacaoTipoId = 2';
      Query.ExecSQL(vSql);
      Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoSaida/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

Function TPedidoSaidaDao.PedidoProcessar(pPedidoId: Int64;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Int64;
  pDocumentoNr, pRazao, pRegistroERP: String; pRotaId: Int64;
  pRotaIdFinal: Int64; pZonaId: Int64; pProcessoId: Integer;
  pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer): TjSonArray;
var
  vSql: String;
  // ObjPedidoProduto       : TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  // ArrayPedidoProdutoDAO  : TJsonArray;
  JsonArrayPedidos, jsonArrayRotas, JsonArrayPessoas: TjSonArray;
  JsonRetorno, jsonPedido, jsonOperacao, jsonNatureza, jsonRota,
    jsonPessoa: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := TuEvolutConst.SqlPedidoProcessar;
      // ClipBoard.Astext := vSql;
      Query.SQL.Add(vSql);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pCodigoERP').Value := pCodigoERP;
      if pDataIni <> 0 then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
         Query.ParamByName('pDataFin').Value := 0;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pProcessoid').Value := pProcessoId;
      Query.ParamByName('pRecebido').Value := pRecebido;
      Query.ParamByName('pCubagem').Value := pCubagem;
      Query.ParamByName('pEtiqueta').Value := pEtiqueta;
      Query.ParamByName('pPrintTag').Value := pPrintTag;
      Query.ParamByName('pEmbalagem').Value := pEmbalagem;
      // Clipboard.AsText := FConexao.Query.Text;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoProcessar.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não há dados para gerar o relatório')));
         Exit;
      End;
      JsonArrayPedidos := TjSonArray.Create;
      while Not Query.Eof do Begin
        jsonPedido := TJsonObject.Create;
        jsonOperacao := TJsonObject.Create;
        jsonNatureza := TJsonObject.Create;
        jsonPessoa := TJsonObject.Create;
        jsonPedido.AddPair('pedidoid', TJsonNumber.Create(Query.FieldByName('PedidoId').Asinteger));
        jsonPedido.AddPair('processoid', TJsonNumber.Create(Query.FieldByName('ProcessoId').Asinteger));
        jsonPedido.AddPair('processoetapa', Query.FieldByName('ProcessoEtapa').AsString);
        jsonPedido.AddPair('statusmin', TJsonNumber.Create(Query.FieldByName('StatusMin').Asinteger));
        jsonPedido.AddPair('statusmax', TJsonNumber.Create(Query.FieldByName('StatusMax').Asinteger));
        jsonOperacao.AddPair('operacaotipoid', TJsonNumber.Create(Query.FieldByName('OperacaoTipoId').Asinteger));
        jsonOperacao.AddPair('descricao', Query.FieldByName('OperacaoTipo').AsString);
        jsonPedido.AddPair('operacaotipo', jsonOperacao);
        jsonPessoa.AddPair('pessoaid', TJsonNumber.Create(Query.FieldByName('PessoaId').Asinteger));
        jsonPessoa.AddPair('codpessoaerp', TJsonNumber.Create(Query.FieldByName('CodPessoaERP').Asinteger));
        jsonPessoa.AddPair('razao', Query.FieldByName('Razao').AsString);
        jsonPessoa.AddPair('fantasia', Query.FieldByName('Fantasia').AsString);
        jsonPessoa.AddPair('rotaid', TJsonNumber.Create(Query.FieldByName('RotaId').Asinteger));
        jsonPessoa.AddPair('rota', Query.FieldByName('Rota').AsString);
        jsonPedido.AddPair('pessoa', jsonPessoa);
        jsonPedido.AddPair('documentonr', Query.FieldByName('DocumentoNr').AsString);
        jsonPedido.AddPair('documentodatar', DateToStr(Query.FieldByName('DocumentoData').AsDateTime));
        // FormatDateTime('YYYY-MM-DD', Query.FieldByName('DocumentoData').AsDateTime));
        jsonPedido.AddPair('dtinclusao', FormatDateTime('YYYY-MM-DD', Query.FieldByName('DtInclusao').AsDateTime));
        jsonPedido.AddPair('hrinclusao', Query.FieldByName('HrInclusao').AsString);
        // FormatDateTime('hh:mm', Query.FieldByName('HrInclusao').AsDateTime));
        jsonPedido.AddPair('armazemid', TJsonNumber.Create(Query.FieldByName('ArmazemId').Asinteger));
        jsonPedido.AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').Asinteger));
        jsonPedido.AddPair('qtdproduto', TJsonNumber.Create(Query.FieldByName('QtdProdutos').Asinteger));
        jsonPedido.AddPair('peso', TJsonNumber.Create(Query.FieldByName('peso').Asinteger));
        jsonPedido.AddPair('volume', TJsonNumber.Create(Query.FieldByName('volume').AsFloat));
        jsonPedido.AddPair('registroerp', Query.FieldByName('RegistroERP').AsString);
        jsonPedido.AddPair('picking', Query.FieldByName('Picking').AsString);
        jsonPedido.AddPair('uuid', Query.FieldByName('uuid').AsString);
        JsonArrayPedidos.AddElement(jsonPedido);
        Query.Next;
      End;
      Query.Close;
      Query.SQL.Clear;
      // Buscar As Rotas
      vSql := TuEvolutConst.SqlPedidoRotas;
      Query.SQL.Add(vSql);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni <> 0 then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
        Query.ParamByName('pDataFin').Value := 0;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRazao').Value := pRazao;
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pProcessoId').Value := pProcessoId;
      Query.ParamByName('pRecebido').Value := pRecebido;
      Query.ParamByName('pCubagem').Value := pCubagem;
      Query.ParamByName('pEtiqueta').Value := pEtiqueta;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoRotas.Sql');
       Query.Open();
      jsonArrayRotas := TjSonArray.Create;
      while Not Query.Eof do Begin
        jsonRota := TJsonObject.Create();
        jsonRota.AddPair('rotaid', TJsonNumber.Create(Query.FieldByName('RotaId').Asinteger));
        jsonRota.AddPair('descricao', Query.FieldByName('Descricao').AsString);
        jsonArrayRotas.AddElement(jsonRota);
        Query.Next;
      End;
      Query.Close;
      Query.SQL.Clear;
      // Buscar As Pessoas/Destinatário
      vSql := TuEvolutConst.SqlPedidoPessoa;
      Query.SQL.Add(vSql);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni <> 0 then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
        Query.ParamByName('pDataFin').Value := 0;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRazao').Value := pRazao;
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pProcessoId').Value := pProcessoId;
      Query.ParamByName('pRecebido').Value := pRecebido;
      Query.ParamByName('pCubagem').Value := pCubagem;
      Query.ParamByName('pEtiqueta').Value := pEtiqueta;
      Query.Open();
      JsonArrayPessoas := TjSonArray.Create;
      while Not Query.Eof do Begin
        jsonPessoa := TJsonObject.Create();
        jsonPessoa.AddPair('pessoaid', TJsonNumber.Create(Query.FieldByName('PessoaId').Asinteger));
        jsonPessoa.AddPair('codpessoaerp', TJsonNumber.Create(Query.FieldByName('CodPessoaERP').Asinteger));
        jsonPessoa.AddPair('razao', Query.FieldByName('Razao').AsString);
        jsonPessoa.AddPair('rotaid', TJsonNumber.Create(Query.FieldByName('RotaId').Asinteger));
        JsonArrayPessoas.AddElement(jsonPessoa);
        Query.Next;
      End;
      Query.Close;
      JsonRetorno := TJsonObject.Create;
      JsonRetorno.AddPair('pedido', JsonArrayPedidos);
      JsonRetorno.AddPair('rota', jsonArrayRotas);
      JsonRetorno.AddPair('pessoa', JsonArrayPessoas);
      Result := TjsonArray.Create;
      Result.AddElement(JsonRetorno);
      // ClipBoard.AsText := JsonRetorno.ToString();
    Except on E: Exception do
      Begin
        raise Exception.Create('Erro na cubagem: '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

Function TPedidoSaidaDao.PedidoPrintTag(pPedidoId: Integer;
  pPedidoVolumeId: Integer; pDataIni, pDataFin: TDate;
  pCodigoERP, pPessoaId: Integer; pRazao: String; pRotaId: Integer;
  pRotaIdFinal: Integer; pZonaId: Integer; pProcessoId: Integer;
  pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlPedidoPrintTag);
      if (pRotaId > 0) or (pRotaIdFinal > 0) then
         Query.SQL.Add('Order by RotaId, PedidoId')
      Else
          Query.SQL.Add('Order by PedidoId');
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.ParamByName('pCodigoERP').Value := pCodigoERP;
      if pDataIni = 0 then
         Query.ParamByName('pDataIni').Value := pDataIni
      Else
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
      if pDataFin = 0 then
         Query.ParamByName('pDataFin').Value := pDataFin
      Else
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin);
      //FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
      //FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pPrintTag').Value := pPrintTag;
      Query.ParamByName('pEmbalagem').Value := pEmbalagem;
      // Clipboard.AsText := FConexao.Query.Text;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PedidoPrintTag.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não há dados para gerar o relatório')));
         Exit;
      End
      Else
         Result := Query.ToJSONArray();
    Except
      on E: Exception do
      Begin
        raise Exception.Create('Erro na cubagem: ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;

end;

function TPedidoSaidaDao.PostReposicaoModelo(pJsonReposicao: TJsonObject)
  : TjSonArray;
Var
  vZonaId, vPickingInicial, vPickingFinal: String;
  vRuaInicial, vRuaFinal: String;
  vRuaPar, vRuaImpar: Integer;
  vPredioInicial, vPredioFinal: String;
  vPredioPar, vPredioImpar: Integer;
  vNivelInicial, vNivelFinal: String;
  vNivelPar, vNivelImpar: Integer;
  vAptoInicial, vAptoFinal: String;
  vAptoPar, vAptoImpar: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if pJsonReposicao.GetValue<String>('pickinginicial') = '' then
        vPickingInicial := 'Null'
      Else
        vPickingInicial := #39 + pJsonReposicao.GetValue<String>
          ('pickinginicial') + #39;
      if pJsonReposicao.GetValue<String>('pickingfinal') = '' then
        vPickingFinal := 'Null'
      Else
        vPickingFinal := #39 + pJsonReposicao.GetValue<String>
          ('pickingfinal') + #39;
      if pJsonReposicao.GetValue<String>('zonaid') = '0' then
        vZonaId := 'Null'
      Else
        vZonaId := pJsonReposicao.GetValue<String>('zonaid');
      if pJsonReposicao.GetValue<String>('ruainicial') = '' then
        vRuaInicial := 'Null'
      Else
        vRuaInicial := #39 + pJsonReposicao.GetValue<String>('ruainicial') + #39;
      if pJsonReposicao.GetValue<String>('ruafinal') = '' then
        vRuaFinal := 'Null'
      Else
        vRuaFinal := #39 + pJsonReposicao.GetValue<String>('ruafinal') + #39;
      vRuaImpar := pJsonReposicao.GetValue<Integer>('ruaimpar');
      vRuaPar := pJsonReposicao.GetValue<Integer>('ruapar');
      if pJsonReposicao.GetValue<String>('predioinicial') = '' then
        vPredioInicial := 'Null'
      Else
        vPredioInicial := #39 + pJsonReposicao.GetValue<String>
          ('predioinicial') + #39;
      if pJsonReposicao.GetValue<String>('prediofinal') = '' then
        vPredioFinal := 'Null'
      Else
        vPredioFinal := #39 + pJsonReposicao.GetValue<String>
          ('prediofinal') + #39;
      vPredioImpar := pJsonReposicao.GetValue<Integer>('predioimpar');
      vPredioPar := pJsonReposicao.GetValue<Integer>('prediopar');
      if pJsonReposicao.GetValue<String>('nivelinicial') = '' then
        vNivelInicial := 'Null'
      Else
        vNivelInicial := #39 + pJsonReposicao.GetValue<String>
          ('nivelinicial') + #39;
      if pJsonReposicao.GetValue<String>('nivelfinal') = '' then
        vNivelFinal := 'Null'
      Else
        vNivelFinal := #39 + pJsonReposicao.GetValue<String>('nivelfinal') + #39;
      vNivelImpar := pJsonReposicao.GetValue<Integer>('nivelimpar');
      vNivelPar := pJsonReposicao.GetValue<Integer>('nivelpar');
      if pJsonReposicao.GetValue<String>('aptoinicial') = '' then
        vAptoInicial := 'Null'
      Else
        vAptoInicial := #39 + pJsonReposicao.GetValue<String>
          ('aptoinicial') + #39;
      if pJsonReposicao.GetValue<String>('aptofinal') = '' then
        vAptoFinal := 'Null'
      Else
        vAptoFinal := #39 + pJsonReposicao.GetValue<String>('aptofinal') + #39;
      vAptoImpar := pJsonReposicao.GetValue<Integer>('aptoimpar');
      vAptoPar := pJsonReposicao.GetValue<Integer>('aptopar');
      Query.Close;
      Query.SQL.Clear;
      if pJsonReposicao.GetValue<Integer>('modeloid') = 0 then Begin
         Query.SQL.Add('Declare @ModeloId Integer = 0');
         Query.SQL.Add('Insert Into ReposicaoModelo Values (');
         Query.SQL.Add('GetDate(), GetDate(), 1, ' + vZonaId + ', ' + vPickingInicial + ', ' +
                       vPickingFinal + ', ' + vRuaInicial + ', ' + vRuaFinal + ', ' + vRuaImpar.ToString() + ', ' +
                       vRuaPar.ToString() + ', ' + vPredioInicial + ', ' + vPredioFinal + ', ' +
                       vPredioImpar.ToString() + ', ' + vPredioPar.ToString() + ', ' +
                       vNivelInicial + ', ' + vNivelFinal + ', ' + vNivelImpar.ToString() +
                       ', ' + vNivelPar.ToString() + ', ' + vAptoInicial + ', ' + vAptoFinal +
                       ', ' + vAptoImpar.ToString() + ', ' + vAptoPar.ToString() + ', ' +
                       pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
                       pJsonReposicao.GetValue<String>('terminal') + #39 + ')');
        Query.SQL.Add('Set @ModeloId = SCOPE_IDENTITY()');
        Query.SQL.Add('Select @ModeloId as ModeloId');
      End
      Else
      begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Update ReposicaoModelo Set ');
        Query.SQL.Add('   Data = GetDate()');
        Query.SQL.Add('   , hora = GetDate()');
        Query.SQL.Add('   , ZonaId        = ' + vZonaId);
        Query.SQL.Add('   , PickingInicial = ' + vPickingInicial);
        Query.SQL.Add('   , PickingFinal   = ' + vPickingFinal);
        Query.SQL.Add('   , RuaInicial   = ' + vRuaInicial);
        Query.SQL.Add('   , RuaFinal     = ' + vRuaFinal);
        Query.SQL.Add('   , RuaImpar     = ' + vRuaImpar.ToString());
        Query.SQL.Add('   , Ruapar       = ' + vRuaPar.ToString());
        Query.SQL.Add('   , PredioInicial = ' + vPredioInicial);
        Query.SQL.Add('   , PredioFinal   = ' + vPredioFinal);
        Query.SQL.Add('   , PredioImpar   = ' + vPredioImpar.ToString());
        Query.SQL.Add('   , Prediopar     = ' + vPredioPar.ToString());
        Query.SQL.Add('   , NivelInicial  = ' + vNivelInicial);
        Query.SQL.Add('   , NivelFinal    = ' + vNivelFinal);
        Query.SQL.Add('   , NivelImpar    = ' + vNivelImpar.ToString());
        Query.SQL.Add('   , Nivelpar      = ' + vNivelPar.ToString());
        Query.SQL.Add('   , AptoInicial   = ' + vAptoInicial);
        Query.SQL.Add('   , AptoFinal     = ' + vAptoFinal);
        Query.SQL.Add('   , AptoImpar     = ' + vAptoImpar.ToString());
        Query.SQL.Add('   , Aptopar       = ' + vAptoPar.ToString());
        Query.SQL.Add('   , UsuarioId     = ' + pJsonReposicao.GetValue<Integer>('usuarioid').ToString());
        Query.SQL.Add('   , Terminal      = ' + #39 + pJsonReposicao.GetValue<String>('terminal') + #39);
        Query.SQL.Add('Where ReposicaoModeloId = ' + pJsonReposicao.GetValue<Integer>('modeloid').ToString());
        Query.SQL.Add('Select * From ReposicaoModelo where ReposicaoModeloId = ' + pJsonReposicao.GetValue<Integer>('modeloid').ToString());
      end;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposicaoModeloSalvar.Sql');
      Query.Open;
      Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ReposisaoModelo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.ProdutoSemPicking(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pRotaId, pRecebido, pCubagem,
  pEtiqueta, pverificarEstoque: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      // ClipBoard.Astext := vSql;
      Query.SQL.Add(TuEvolutConst.SqlGetProdutoSemPicking);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni <> 0 then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
         Query.ParamByName('pDataFin').Value := 0;
      Query.ParamByName('pCodigoERP').Value := pCodigoERP;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
      Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
      Query.ParamByName('pRegistroERP').Value := pRegistroERP;
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pRecebido').Value := pRecebido;
      Query.ParamByName('pCubagem').Value := 0; // pCubagem;
      Query.ParamByName('pEtiqueta').Value := pEtiqueta;
      Query.ParamByName('pVerificarEstoque').Value := pverificarEstoque;
      // Clipboard.AsText := FConexao.Query.Text;
      If DebugHook <> 0 Then
         Query.SQL.SaveToFile('ProdutoSemPicking.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ProdutoSemPicking - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.PutRegistrarProcesso(pJsonObject: TJsonObject) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+ pJsonObject.GetValue<Integer>('pedidoid').ToString + ')');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      Query.ParamByName('pProcessoId').Value := pJsonObject.GetValue<Integer>('processoid');
      Query.ParamByName('pTerminal').Value   := pJsonObject.GetValue<String>('terminal');
      Query.ParamByName('pUsuarioId').Value  := pJsonObject.GetValue<String>('usuarioid');
      Query.ExecSQL;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Registro realizado com sucesso!'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Não foi possível Finalizar o registro da coleta. '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.ReposicaoFinalizar(pJsonReposicao: TjSonArray) : TjSonArray;
Var vTransaction: Boolean;
    xColeta: Integer;
    vReposicaoId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      xColeta := 0;
      vReposicaoId := pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
      // SOMENTE PARA REPOSIÇÃO AUTOMÀTICA SEM COLETA (Brasil)
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Update Reposicao Set ProcessoId = (Select ProcessoId From ProcessoEtapas where Descricao = '+
                    #39 + 'Reposição - Finalizada' + #39 + ') Where ReposicaoId = ' + vReposicaoId.ToString());
      Query.ExecSQL;
      Query.connection.Commit;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', '201'));
    Except On E: Exception do
      Begin
        if vTransaction then
           Query.connection.Rollback;
        raise Exception.Create('Não foi possível Finalizar o registro da coleta.'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.ReposicaoSalvar(pJsonReposicao: TJsonObject) : TjSonArray;
Var JsonArrayItens, JsonArrayEndereco: TjSonArray;
    vGuuid: string;
    xItens, xEndereco, vReposicaoId: Integer;
    vTransaction: Boolean;
    vDataReposicao, vZonaId, vEnderecoInicial, vEnderecoFinal: String;
    vReposicaoModeloId: String;
    vProdutoId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      vGuuid := TGUID.NewGuid.ToString();
      Query.connection.StartTransaction;
      Query.connection.TxOptions.Isolation := xiReadCommitted;
      if pJsonReposicao.GetValue<String>('zonaid') = '0' then
         vZonaId := 'Null'
      Else
         vZonaId := pJsonReposicao.GetValue<String>('zonaid');
      if pJsonReposicao.GetValue<String>('enderecoinicial') = '' then
         vEnderecoInicial := 'Null'
      Else
         vEnderecoInicial := pJsonReposicao.GetValue<String>('enderecoinicial');
      if pJsonReposicao.GetValue<String>('enderecofinal') = '' then
         vEnderecoFinal := 'Null'
      Else
         vEnderecoFinal := pJsonReposicao.GetValue<String>('enderecofinal');
      Query.Close;
      Query.SQL.Clear;
      if Not pJsonReposicao.tryGetValue('reposicaomodeloid', vReposicaoModeloId)
      then
        vReposicaoModeloId := 'Null'
      Else
        vReposicaoModeloId := pJsonReposicao.GetValue<String>
          ('reposicaomodeloid');
      if pJsonReposicao.GetValue<Integer>('reposicaoid') = 0 then
      Begin
        if (pJsonReposicao.GetValue<String>('dtressuprimento') = '') or (pJsonReposicao.GetValue<String>('dtressuprimento') = '  /  /    ') then
           vDataReposicao := 'Null'
        Else
           vDataReposicao := #39 + FormatDateTime('YYYY-MM-DD', StrToDate(pJsonReposicao.GetValue<String>('dtressuprimento'))) + #39;
         Query.SQL.Add('Declare @NewId Varchar(38) = ' + QuotedStr(vGuuid));
        Query.SQL.Add('Declare @ProcessoId Integer = ' + pJsonReposicao.GetValue<Integer>('processoid').ToString());
        Query.SQL.Add('Set @ProcessoId = (select ProcessoId From PRocessoEtapas ');
        Query.SQL.Add('where descricao = (Case when @ProcessoId = 1 then ' + #39 + 'Reposição - Criada' + #39);
        Query.SQL.Add('                        when @ProcessoId = 2 then ' + #39 + 'Reposição - Em Coleta' + #39);
        Query.SQL.Add('						when @ProcessoId = 3 then ' + #39 + 'Reposição - Finalizada' + #39);
        Query.SQL.Add('                        Else ' + #39 + 'Reposição - Cancelada' + #39 + ' End))');
        Query.SQL.Add('Insert Into Reposicao Values (');
        Query.SQL.Add(vDataReposicao + ', ' + pJsonReposicao.GetValue<Integer>('reposicaotipo').ToString() + ', @ProcessoId, ' +
                      vZonaId + ', ' + vEnderecoInicial + ', ' + vEnderecoFinal + ', ' +
                      pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
                      pJsonReposicao.GetValue<String>('terminal') + #39 + ', ' +
                      'GetDate(), (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()), 12, 12)), '
                      + vReposicaoModeloId + ', ' + 'Null, Null, Cast(@NewId AS UNIQUEIDENTIFIER)');
        Query.SQL.Add(')');
        Query.SQL.Add('Select * From Reposicao where Uuid = @NewId');
      End
      Else begin
        vReposicaoId := pJsonReposicao.GetValue<Integer>('reposicaoid');
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Update Reposicao Set ');
        Query.SQL.Add('   DtRessuprimento = ' + #39 + FormatDateTime('YYYY-MM-DD', StrToDate(pJsonReposicao.GetValue<String>('dtressuprimento'))) + #39);
        Query.SQL.Add('   , ReposicaoTipo = ' + pJsonReposicao.GetValue<Integer>('reposicaotipo').ToString());
        Query.SQL.Add('   , ZonaId        = ' + vZonaId);
        Query.SQL.Add('   , EnderecoInicial = ' + vEnderecoInicial);
        Query.SQL.Add('   , EnderecoFinal   = ' + vEnderecoFinal);
        Query.SQL.Add('   , ReposicaoModeloId = ' + vReposicaoModeloId);
        // FConexao.Query.SQL.Add('   , ProcessoId    = '+pJsonReposicao.GetValue<Integer>('processoid').ToString());
        Query.SQL.Add('   , UsuarioId     = ' + pJsonReposicao.GetValue<Integer>('usuarioid').ToString());
        Query.SQL.Add('Where ReposicaoId = ' + pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
        Query.SQL.Add('Select * From Reposicao where ReposicaoId = ' + pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
      end;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ReposiocaoSalvar.Sql');
      Query.Open;
      Result := Query.ToJSONArray();
      // Salvar os Endereços da Coleta
      JsonArrayEndereco := pJsonReposicao.GetValue<TjSonArray>('coleta');
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Delete From ReposicaoEnderecoColeta Where ReposicaoId = ' + pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
      Query.ExecSQL;
      For xEndereco := 0 to Pred(JsonArrayEndereco.Count) do Begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Insert Into ReposicaoEnderecoColeta (reposicaoid, produtoid, loteid, enderecoid, EstoqueTipoId, EstoqueDisponivel, Qtde) Values (');
        Query.SQL.Add(Result.Items[0].GetValue<Integer>('reposicaoid').ToString() + ', ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('produtoid').ToString() + ', ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('loteid').ToString() + ', ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('enderecoid').ToString() + ', ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('estoquetipoid').ToString() + ', ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('disponivel').ToString() + ', ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('demanda').ToString());
        Query.SQL.Add(')');
        Query.SQL.Add('Update PedidoReposicao ' + '    Set Status = 1 Where LoteId = ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('loteid').ToString() + '  And Enderecoid = ' +
                      JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('enderecoid').ToString());
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('SalvarReposicaoEndereco.Sql');
        Query.ExecSQL;
      End;
      // Incluir na Reserva quando tipo for por Demanda
      if pJsonReposicao.GetValue<Integer>('reposicaotipo') = 1 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('Update Est');
         Query.SQL.Add('   Set Qtde = Est.Qtde + RC.Qtde');
         Query.SQL.Add('from ReposicaoEnderecoColeta RC');
         Query.SQL.Add('Inner Join Estoque Est On Est.LoteId = RC.LoteId and Est.EnderecoId = RC.EnderecoId and Est.EstoqueTipoId = 6');
         Query.SQL.Add('where reposicaoid = ' + Result.Items[0].GetValue<Integer>('reposicaoid').ToString());

         Query.SQL.Add('Insert Into Estoque');
         Query.SQL.Add('select RC.LoteId, RC.EnderecoId, 6, RC.Qtde, ' + TuEvolutConst.SqlDataAtual + ', ' +
                                TuEvolutConst.SqlHoraAtual + ', ' + pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', Null, Null, Null');
         Query.SQL.Add('from ReposicaoEnderecoColeta RC');
         Query.SQL.Add('Left Join Estoque Est On Est.LoteId = RC.LoteId and Est.EnderecoId = RC.EnderecoId and Est.EstoqueTipoId = 6');
         Query.SQL.Add('where reposicaoid = ' + Result.Items[0].GetValue<Integer>('reposicaoid').ToString() + ' and Est.LoteId Is Null');
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('ReposicaoDemandaReserva.Sql');
        Query.ExecSQL;
      End;
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Não foi possível Gerar a reposição.'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.ReposicaoSalvarItemColetado(pJsonReposicao: TjSonArray) : TjSonArray;
Var vTransaction: Boolean;
    xColeta: Integer;
    vReposicaoId: Integer;
    vEstoqueTipoId: Integer;
    vQtdeReserva: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      // vGuuid := TGUID.NewGuid.ToString();
      Query.connection.StartTransaction;
      xColeta := 0;
      for xColeta := 0 to Pred(pJsonReposicao.Count) do Begin
        // Baixar Estoque
        if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') > 0) and
           (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid') <> '') and
           (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid') <> '0') then Begin
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado');
           Query.SQL.Add(TuEvolutConst.SqlEstoque);
           Query.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
           Query.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
           Query.ParamByName('pEstoqueTipoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
           Query.ParamByName('pQuantidade').Value    := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') * -1);
           Query.ParamByName('pUsuarioId').Value     := (pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid'));
           if DebugHook <> 0 then
              Query.SQL.SaveToFile('SqlReposicaoBaixarEstoque.Sql');
           if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') > 0) then
              Query.ExecSQL;
          // Baixar Reserva
           Query.Close;
           Query.SQL.Clear;
           Query.SQL.Add('Select Coalesce(Qtde, 0) Qtde From Estoque');
           Query.SQL.Add('Where LoteId = ' + pJsonReposicao.Get(xColeta).GetValue<String>('loteid'));
           Query.SQL.Add('  And EnderecoId = ' + pJsonReposicao.Get(xColeta).GetValue<String>('enderecoid'));
           Query.SQL.Add('  And EstoqueTipoId = 6');
           Query.Open;
           vQtdeReserva := Query.FieldByName('Qtde').Asinteger;
           if Query.FieldByName('Qtde').Asinteger > 0 then Begin
              Query.Close;
              Query.SQL.Clear;
              Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado');
              Query.SQL.Add(TuEvolutConst.SqlEstoque);
              Query.ParamByName('pLoteId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
              Query.ParamByName('pEnderecoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
              Query.ParamByName('pEstoqueTipoId').Value := 6;
              if vQtdeReserva >= (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde')) then
                 Query.ParamByName('pQuantidade').Value := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') * -1)
              Else
                Query.ParamByName('pQuantidade').Value := (vQtdeReserva * -1);
              Query.ParamByName('pUsuarioId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
              if DebugHook <> 0 then Begin
                 Query.SQL.Add('-- pLoteId = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid').ToString());
                 Query.SQL.Add('-- pEnderecoId = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid').ToString());
                 Query.SQL.Add('-- pQuantidadeId = ' + (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') * -1).ToString());
                 Query.SQL.SaveToFile('SqlReposicaoBaixarReserva.Sql');
             End;
             Query.ExecSQL;
           End;
          // Transferir para o Picking
           if pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') > 0 then Begin
              Query.Close;
              Query.SQL.Clear;
              Query.SQL.Add('Select Coalesce(ReposicaoColetaParaPicking, 0) ReposicaoColetaParaPicking From Configuracao');
              Query.Open;
             If Query.FieldByName('ReposicaoColetaParaPicking').Asinteger = 0 then
                vEstoqueTipoId := 7
             Else
                vEstoqueTipoId := 4; //pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
              Query.Close;
              Query.SQL.Clear;
              if vEstoqueTipoId = 7 then Begin
                 Query.SQL.Add(TuEvolutConst.SqlReposicaoSalvarItemColetado);
                 // SqlReposicaoEstoqueTransferencia);
                 Query.ParamByName('pLoteId').Value           := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
                 Query.ParamByName('pEnderecoId').Value       := pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
                 Query.ParamByName('pReposicaoId').Value      := pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
                 Query.ParamByName('pEnderecoOrigemId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
                 Query.ParamByName('pEstoqueTipoId').Value    := vEstoqueTipoId;
                 Query.ParamByName('pQuantidade').Value       := pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
                 Query.ParamByName('pUsuarioId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
                 Query.ParamByName('pTerminal').Value         := pJsonReposicao.Get(xColeta).GetValue<String>('terminal');
              End
              Else Begin
                 Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado  EstoqueTipoId <> 7');
                 Query.SQL.Add(TuEvolutConst.SqlEstoque);
                 Query.ParamByName('pLoteId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
                 Query.ParamByName('pEnderecoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
                 Query.ParamByName('pEstoqueTipoId').Value := vEstoqueTipoId;
                 Query.ParamByName('pQuantidade').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
                 Query.ParamByName('pUsuarioId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
              End;
              if DebugHook <> 0 then
                 Query.SQL.SaveToFile('SqlReposicaoTransfPicking.Sql');
              Query.ExecSQL;
           End;
        End;
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Update ReposicaoEnderecoColeta');
        Query.SQL.Add('  Set QtdRepo = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo').ToString());
        Query.SQL.Add('    , UsuarioId = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid').ToString());
        Query.SQL.Add('    , Terminal  = ' + QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('terminal')));
        Query.SQL.Add('    , DtEntrada = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(pJsonReposicao.Get(xColeta).GetValue<String>('dtentrada')))));
        Query.SQL.Add('    , HrEntrada = ' + QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('hrentrada')));
        Query.SQL.Add('Where ReposicaoId = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid').ToString);
        Query.SQL.Add('  And ProdutoId = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('produtoid').ToString);
        Query.SQL.Add('  And Loteid = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid').ToString());
        Query.SQL.Add('  And EnderecoId = ' + pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid').ToString());
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('SqlReposicaoEnderecoColeta.Sql');

        Query.ExecSQL;
        vReposicaoId := pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
        // Registrar no Kardex
      End;
      Query.connection.Commit;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', '201'));
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoSaidaDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.PedidoSaida.PedidoId = 0 then Begin
         vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, RegistroERP, DtInclusao, HrInclusao, ArmazemId) Values ('+sLineBreak+
                  Self.PedidoSaida.OperacaoTipo.OperacaoTipoId.ToString() + ', ' + Self.PedidoSaida.Pessoa.PessoaId.ToString() + ', ' +sLineBreak+
                  QuotedStr(Self.PedidoSaida.DocumentoNr) + ', ' + '(select IdData From Rhema_Data where Data = ' + #39 +sLineBreak+
                  FormatDateTime('YYYY-MM-DD', Self.PedidoSaida.DocumentoData) + #39 + '), ' + #39 + Self.PedidoSaida.RegistroERP + #39 + ', '+sLineBreak+
                  SqlDataAtual + ', ' + SqlHoraAtual + ', ' + IfThen(Self.PedidoSaida.ArmazemId = 0, 'Null', Self.PedidoSaida.ToString()) + ')';
      End
      Else Begin
         vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
                 Self.PedidoSaida.OperacaoTipo.OperacaoTipoId.ToString() +
                 '   , PessoaId      = ' + Self.PedidoSaida.Pessoa.PessoaId.ToString() +
                 '   , DocumentoNr   = ' + QuotedStr(Self.PedidoSaida.DocumentoNr) +
                 '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = '
                 + #39 + FormatDateTime('YYYY-MM-DD', Self.PedidoSaida.DocumentoData) +
                 #39 + ')' + '   , RegistroERP   = ' +
                 QuotedStr(Self.PedidoSaida.RegistroERP) + '   , ArmazemId     = ' +
                 Self.PedidoSaida.ArmazemId.ToString() + ' where PedidoId = ' +
                 Self.PedidoSaida.PedidoId.ToString + ' and OperacaoTipoId = 2';
      End;
      Query.ExecSQL(vSql);
      Result := True;
    Except
      On E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;

end;

end.
