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
begin
  try
    FConexao.Query.Close;
    FConexao.Query.SQL.Add('DECLARE @RetryCount INT = 3; -- Número máximo de tentativas ');
    FConexao.Query.SQL.Add('DECLARE @CurrentRetry INT = 0; ');
    FConexao.Query.SQL.Add(' ');
    FConexao.Query.SQL.Add('WHILE @CurrentRetry < @RetryCount ');
    FConexao.Query.SQL.Add('Begin ');
    FConexao.Query.SQL.Add('  BEGIN TRY ');
    FConexao.Query.SQL.Add('    Delete Pv ');
    FConexao.Query.SQL.Add('    from PedidoVOlumes Pv ');
    FConexao.Query.SQL.Add('    left Join PedidoVolumeLotes Vl --With (NoLock) ');
    FConexao.Query.SQL.Add('	                               On Vl.PedidoVolumeId = Pv.PedidoVolumeId ');
    FConexao.Query.SQL.Add('    where Vl.PedidoVOlumeId Is Null ');
    FConexao.Query.SQL.Add('	Break; ');
    FConexao.Query.SQL.Add('  End Try ');
    FConexao.Query.SQL.Add('  Begin Catch ');
    FConexao.Query.SQL.Add('    IF ERROR_NUMBER() = 1205 Begin ');
    FConexao.Query.SQL.Add('	   SET @CurrentRetry = @CurrentRetry + 1; ');
    FConexao.Query.SQL.Add('       PRINT '+#39+'DeadLock Detectado!'+#39+'+ CAST(@CurrentRetry AS NVARCHAR(10)); ');
    FConexao.Query.SQL.Add('       WAITFOR DELAY '+#39+'00:00:00.100'+#39+'; ');
    FConexao.Query.SQL.Add('	End; ');
    FConexao.Query.SQL.Add('  End Catch ');
    FConexao.Query.SQL.Add('End; ');
    FConexao.Query.SQL.Add(' ');
    FConexao.Query.SQL.Add('--Begin Tran ');
    FConexao.Query.SQL.Add(';With ');
    FConexao.Query.SQL.Add('PedTmp as ( ');
    FConexao.Query.SQL.Add('select Ped.PedidoId, ProcMax.ProcessoId ');
    FConexao.Query.SQL.Add('From Pedido Ped ');
    FConexao.Query.SQL.Add('CROSS APPLY (select top 1 ProcessoId ');
    FConexao.Query.SQL.Add('             From DocumentoEtapas ');
    FConexao.Query.SQL.Add('			 where Documento = Ped.Uuid ');
    FConexao.Query.SQL.Add('			   and Status = 1 ');
    FConexao.Query.SQL.Add('			 Order by ProcessoId Desc) ProcMax ');
    FConexao.Query.SQL.Add('Where ProcMax.ProcessoId < 13 and Ped.OperacaoTipoId = 2) ');
    FConexao.Query.SQL.Add(' ');
    FConexao.Query.SQL.Add(', VolTmp as (select Pv.PedidoId, ProcMax.ProcessoId ');
    FConexao.Query.SQL.Add('From PedidoVOlumes Pv ');
    FConexao.Query.SQL.Add('Inner Join PedTmp Ped On Ped.PedidoId = Pv.PedidoId ');
    FConexao.Query.SQL.Add('CROSS APPLY (select top 1 ProcessoId ');
    FConexao.Query.SQL.Add('             From DocumentoEtapas ');
    FConexao.Query.SQL.Add('			 where Documento = Pv.Uuid ');
    FConexao.Query.SQL.Add('			   and Status = 1 ');
    FConexao.Query.SQL.Add('			 Order by ProcessoId Desc) ProcMax) ');
    FConexao.Query.SQL.Add(' ');
    FConexao.Query.SQL.Add(' ');
    FConexao.Query.SQL.Add(', VlmEtapas as (Select Pv.PedidoId, Min(ProcessoId) ProcessoId ');
    FConexao.Query.SQL.Add('               From VolTmp Pv ');
    FConexao.Query.SQL.Add('			   Group by Pv.PedidoId) ');
    FConexao.Query.SQL.Add(' ');
    FConexao.Query.SQL.Add('Insert Into DocumentoEtapas ');
    FConexao.Query.SQL.Add('select Ped.uuid, Pv.ProcessoID, 1, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), ');
    FConexao.Query.SQL.Add('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), '+#39+'Atualizacao Manual'+#39+', 1 ');
    FConexao.Query.SQL.Add('From VlmEtapas PV ');
    FConexao.Query.SQL.Add('Inner join Pedido Ped On Ped.PedidoId = Pv.PedidoId ');
    FConexao.Query.SQL.Add('where Pv.Processoid >= 13');
    If DebugHook <> 0 Then
       FConexao.Query.SQL.SaveToFile('AtualizarProcesso.Sql');
    FConexao.Query.ExecSQL;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Manutenção realizada com sucesso!'));
  Except On E: Exception do
    raise Exception.Create('Processo: AtualizarProcesso('+pPedidoId.ToString()+') - '+TUtil.TratarExcessao(E.Message));
  end;
end;

function TPedidoSaidaDao.Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
var
  // vQryPedido, vQryVolumes2: TFDQuery;
  vSql: String;
  ObjPedidoVolumeDAO: TPedidoVolumeDAO;
  JsonVolumeCancelar: TJsonObject;
begin
  Result := False;
  Try
    try
      // Chamar Rotina de Cancelamento de Cubagem
      FConexao.Query.connection.StartTransaction;
      FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
      FConexao.Query.Close;
      FConexao.Query.SQL.Add('Select PedidoVolumeId From PedidoVolumes Where PedidoId = ' +
                             pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString);
      FConexao.Query.Open();
      ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
      while Not FConexao.Query.Eof do Begin
        JsonVolumeCancelar := TJsonObject.Create;
        JsonVolumeCancelar.AddPair('pedidoVolumeId', TJsonNumber.Create(FConexao.Query.FieldByName('PedidoVolumeId').Asinteger));
        JsonVolumeCancelar.AddPair('usuarioid', TJsonNumber.Create(pJsonPedidoCancelar.GetValue<String>('usuarioid')));
        JsonVolumeCancelar.AddPair('terminal', pJsonPedidoCancelar.GetValue<String>('terminal'));
        Try
          ObjPedidoVolumeDAO.Cancelar(FConexao.DB, JsonVolumeCancelar);
        Except On E: Exception do
          raise Exception.Create('Processo: CancelarVolumes - ' + TUtil.TratarExcessao(E.Message));
        End;
        FConexao.Query.Next;
      End;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.Sql.Add('Update Pedido Set Status = 3 ');
      FConexao.Query.Sql.Add('Where PedidoId = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString);
      FConexao.Query.Sql.Add('  and OperacaoTipoId = 2');
      FConexao.Query.Sql.Add('Update DocumentoEtapas Set Status = 0'); //01062024 nao cancelar volume já cancelado
      FConexao.Query.Sql.Add('Where Documento = (Select Uuid from Pedido ');
      FConexao.Query.Sql.Add('                   Where Pedidoid = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString() );
      FConexao.Query.Sql.Add('  And ProcessoId = 15');
      FConexao.Query.Sql.Add('Insert Into DocumentoEtapas Values ');
      FConexao.Query.Sql.Add('     ( Cast((Select Uuid from Pedido ');
      FConexao.Query.Sql.Add('             Where Pedidoid = '+pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString()+
                                                            ') as UNIQUEIDENTIFIER), ');
      FConexao.Query.Sql.Add('       15, ' +pJsonPedidoCancelar.GetValue<Integer>('usuarioid').ToString() + ', ');
      FConexao.Query.Sql.Add('       '+SqlDataAtual + ', ' + SqlHoraAtual + ', GetDate(), ');
      FConexao.Query.Sql.Add('       '+QuotedStr(pJsonPedidoCancelar.GetValue<String>('terminal')) + ', 1)');
      FConexao.Query.ExecSQL(vSql);
      Result := True;
      FConexao.Query.connection.Commit;
    Except
      On E: Exception do
      Begin
        FConexao.Query.connection.Rollback;
        raise Exception.Create('Processo: CancelarPedido - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(JsonVolumeCancelar);
    FreeAndNil(ObjPedidoVolumeDAO);
  End;
end;

function TPedidoSaidaDao.CancelarCubagem(pPedidoId: Integer): TjSonArray;
Var
  vTransaction: Boolean;
begin
  FConexao.Query.connection.StartTransaction;
  Result := TjSonArray.Create;
  try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlCancelarCubagemPedido);
    FConexao.Query.ParamByName('pPedido').Value := pPedidoId;
    FConexao.Query.ExecSQL;
    FConexao.Query.connection.Commit;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Resultado', 'Cancelamento de Cubagem realizado com sucess!')));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Não foi possível cancelar a cubagem do pedido. ' + E.Message);
    End;
  end;
end;

constructor TPedidoSaidaDao.Create;
begin
  PedidoSaida := TPedidoSaida.Create;
  PedidoSaida.ListProduto := TObjectList<TPedidoProduto>.Create();
  inherited;;
end;

function TPedidoSaidaDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Pedido where PedidoId = ' +
      Self.PedidoSaida.PedidoId.ToString + ' and OperacaoTipoId = 2';
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception Do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.DeleteReposicaoModelo(pModeloId: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add('Delete ReposicaoModelo');
    FConexao.Query.SQL.Add('Where ReposicaoModeloId = :pModeloId');
    FConexao.Query.ParamByName('pModeloId').Value := pModeloId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('DelteReposicaoModelo.Sql');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok',
      'Registro excluído com sucesso!')));
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
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
  FreeAndNil(PedidoSaida.ListProduto); //.Free;
  FreeANdNil(PedidoSaida); //.Free;
  inherited;
end;

function TPedidoSaidaDao.Estrutura: TjSonArray;
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
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
  Else
     Result := FConexao.Query.ToJSONArray();
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
Begin
  FConexao.Query.connection.StartTransaction;
  Result := TjSonArray.Create;
  StartProc := True;
  Try
    For xArray := 0 to Pred(pJsonArray.Count) do Begin
      jsonVolume := pJsonArray.Items[xArray] as TJsonObject;
      For xVolume := 1 to jsonVolume.GetValue<Integer>('qtvolume') do Begin // Criando o Volume
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add(TuEvolutConst.SqlCreateVolume);
        FConexao.Query.ParamByName('pPedidoId').Value    := jsonVolume.GetValue<Integer>('pedidoid');
        FConexao.Query.ParamByName('pEmbalagemId').Value := 0;
        FConexao.Query.ParamByName('pTerminal').Value    := jsonVolume.GetValue<String>('terminal');
        FConexao.Query.ParamByName('pUsuarioId').Value   := jsonVolume.GetValue<String>('usuarioid');
        vGuuid := TGUID.NewGuid.ToString();
        FConexao.Query.ParamByName('pNewId').Value := vGuuid;
        if DebugHook <> 0 then
           FConexao.Query.SQL.SaveToFile('CreateVolume.Sql');
        Try
          FConexao.Query.ExecSQL; // Definindo os Lotes do Volume
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add(TuEvolutConst.SqlGerarVolumeLoteCaixaFechada);
          FConexao.Query.ParamByName('pNewId').Value           := vGuuid;
          FConexao.Query.ParamByName('pLoteId').Value          := jsonVolume.GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value      := jsonVolume.GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value   := jsonVolume.GetValue<Integer>('estoquetipoid');
          FConexao.Query.ParamByName('pQuantidade').Value      := jsonVolume.GetValue<Integer>('quantidade');
          FConexao.Query.ParamByName('pEmbalagemPadrao').Value := jsonVolume.GetValue<Integer>('embalagempadrao');
          FConexao.Query.ParamByName('pTerminal').Value        := jsonVolume.GetValue<String>('terminal');
          FConexao.Query.ParamByName('pUsuarioId').Value       := jsonVolume.GetValue<String>('usuarioid');
          FConexao.Query.ExecSQL;
        Except ON E: Exception do
          Begin
            raise Exception.Create('PedidoId = ' + jsonVolume.GetValue<Integer>('pedidoid').ToString + ' ' + E.Message);
          End;
        End;
      End;
      // Reserva de Estoque
      Try
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add ('--PedidoSaidaDao.CreateVolumeCaixaFechada - Reserva de Estoque');
        FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
        FConexao.Query.ParamByName('pLoteId').Value        := jsonVolume.GetValue<Integer>('loteid');
        FConexao.Query.ParamByName('pEnderecoId').Value    := jsonVolume.GetValue<Integer>('enderecoid');
        FConexao.Query.ParamByName('pEstoqueTipoId').Value := 6;
        FConexao.Query.ParamByName('pQuantidade').Value    := jsonVolume.GetValue<Integer>('quantidade') * jsonVolume.GetValue<Integer>('qtvolume');
        FConexao.Query.ParamByName('pUsuarioId').Value     := jsonVolume.GetValue<String>('usuarioid');
        FConexao.Query.ExecSQL;
      Except ON E: Exception do
        Begin
          raise Exception.Create(E.Message);
        End;
      end;
      jsonVolume := Nil;
    End;
    FConexao.Query.connection.Commit;
    Result.AddElement(TJsonObject.Create.AddPair('Resultado', 'Volume(s) criado com sucesso!'));
    FConexao.Query.Close;
  Except On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
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
begin
  FConexao.Query.connection.StartTransaction;
  Result := TjSonArray.Create;
  StartProc := True;
  Try
    For xArray := 0 to Pred(pJsonArray.Count) do Begin
      jsonVolume := pJsonArray.Items[xArray] as TJsonObject;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add(TuEvolutConst.SqlCreateVolume);
      FConexao.Query.ParamByName('pPedidoId').Value := jsonVolume.GetValue<Integer>('pedidoid');
      pPedidoId := jsonVolume.GetValue<Integer>('pedidoid');
      FConexao.Query.ParamByName('pEmbalagemId').Value := jsonVolume.GetValue<Integer>('embalagemid');
      pTerminal := jsonVolume.GetValue<String>('terminal');
      pUsuarioId := jsonVolume.GetValue<Integer>('usuarioid');
      FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
      FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      ArrayJsonVolumeLotes := jsonVolume.Get('lotes').JsonValue as TjSonArray;
      vGuuid := TGUID.NewGuid.ToString();
      FConexao.Query.ParamByName('pNewId').Value := vGuuid;
      // ClipBoard.AsText := vGuuid;
      FConexao.Query.ExecSQL;
      try
        // Definindo os Lotes do Volume
        for xLotes := 0 to Pred(ArrayJsonVolumeLotes.Count) do Begin
          jsonVolumeLotes := ArrayJsonVolumeLotes.Items[xLotes] as TJsonObject;
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add(TuEvolutConst.SqlGerarVolumeLoteCaixaFechada);
          FConexao.Query.ParamByName('pNewId').Value := vGuuid;
          FConexao.Query.ParamByName('pLoteId').Value := jsonVolumeLotes.GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value := jsonVolumeLotes.GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value := jsonVolumeLotes.GetValue<Integer>('estoquetipoid');
          FConexao.Query.ParamByName('pQuantidade').Value := jsonVolumeLotes.GetValue<Integer>('quantidade');
          FConexao.Query.ParamByName('pEmbalagemPadrao').Value := jsonVolumeLotes.GetValue<Integer>('embalagempadrao');
          FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
          FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
          FConexao.Query.ExecSQL;
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add('--PedidoSaidaDao.CreateVolumeCaixaFracionada');
          FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
          FConexao.Query.SQL.Add('-- EnderecoId = ' + jsonVolumeLotes.GetValue<Integer>('enderecoid').ToString());
          FConexao.Query.ParamByName('pLoteId').Value := jsonVolumeLotes.GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value := jsonVolumeLotes.GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value := 6;
          FConexao.Query.ParamByName('pQuantidade').Value := jsonVolumeLotes.GetValue<Integer>('quantidade');
          FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
          FConexao.Query.ExecSQL;
        End;
      Except ON E: Exception do
        Begin
          raise Exception.Create(E.Message);
        End;
      end;
      // End;
    End;
    // ProdutoId	EmbPrim	EmbSec	MesSaidaMinima	LoteId	Vencimento	EnderecoId	Endereco	Estrutura	Qtde	DtEntrada	HrEntrada	EstoqueTipoId	TipoEstoque	Producao	Distribuicao	CxaFechada
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+jsonVolume.GetValue<Integer>('pedidoid').ToString + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    if jsonVolume.GetValue<Integer>('reprocessado') = 0 then
       FConexao.Query.ParamByName('pProcessoId').Value := 2
    else
       FConexao.Query.ParamByName('pProcessoId').Value := 21;
    FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
    FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    FConexao.Query.connection.Commit;
    Result.AddElement(TJsonObject.Create.AddPair('Resultado', 'Volume(s) criado com sucesso!'));
    FConexao.Query.Close;
  Except On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.GetEstoqueCaixaFechada(pPedidoId: Integer): TjSonArray;
var vSql : String;
    jsonEstoqueDisponivel : TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoqueCubagemCxaFechada);
    // Pegar Estoque para Processar Caixa Fechada
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EstoqueCaixaFechada.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não há cálculo para caixa fechada!'));
       Exit;
    End;
    With FConexao.Query do
      While Not FConexao.Query.Eof do Begin
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
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.GetEstoqueCaixaFracionada(pPedidoId: Integer) : TjSonArray;
var vSql: String;
    jsonEstoqueDisponivel: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoqueVolumeCaixaFracionada);
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EstoqueFracionado.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Pedido(' + pPedidoId.ToString() + '). Sem cálculo para Fracionado!!'));
    End
    Else
       Result := FConexao.Query.ToJSONArray(); // Alterado em 26/07/23
  Except ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoPed(const pDataInicio, pDataTermino: TDateTime; pRotaId, pZonaId: Integer; pZonaIdStr : String): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add('declare @DtInicio DateTime = :pDtInicio');
    FConexao.Query.SQL.Add('Declare @DtTermino DateTime = :pDtTermino');
    FConexao.Query.SQL.Add('Declare @RotaId Integer = :pRotaId');
    FConexao.Query.SQL.Add('if object_id ('+#39+'tempdb..#Pedidos'+#39+') is not null drop table #Pedidos');
    FConexao.Query.SQL.Add('if object_id ('+#39+'tempdb..#PedidoResumo'+#39+') is not null drop table #PedidoResumo');
    FConexao.Query.SQL.Add('Select Rd.Data,De.ProcessoId, Count(*) As Total Into #Pedidos');
    FConexao.Query.SQL.Add('From Pedido Ped');
    FConexao.Query.SQL.Add('Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId');
    FConexao.Query.SQL.Add('Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId');
    FConexao.Query.SQL.Add('Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid');
    FConexao.Query.SQL.Add('Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData');
    FConexao.Query.SQL.Add('Inner join (Select Distinct PedidoId');
    FConexao.Query.SQL.Add('            From PedidoProdutos Pp');
    FConexao.Query.SQL.Add('					  Inner Join vProduto Prd On Prd.IdProduto = Pp.ProdutoId');
    if pZonaIdstr <> '' then
       FConexao.Query.SQL.Add('            Where ZonaId in ('+pZonaIdStr+') ) Vl On Vl.PedidoId = Ped.PedidoId')
    Else
       FConexao.Query.SQL.Add('                                             ) Vl On Vl.PedidoId = Ped.PedidoId');
    FConexao.Query.SQL.Add('where DE.ProcessoId = (Select Max(ProcessoId) From vDocumentoEtapas Where Documento = Ped.uuid)');
    FConexao.Query.SQL.Add('  and Ped.OperacaoTipoId = 2');
    FConexao.Query.SQL.Add('  and (@DtInicio = 0 or Rd.Data >= @DtInicio)');
    FConexao.Query.SQL.Add('  and (@DtTermino = 0 or Rd.Data <= @DtTermino)');
    FConexao.Query.SQL.Add('  And (@RotaId = 0 or Rp.rotaid = @RotaId)');
    FConexao.Query.SQL.Add('  And De.ProcessoId <> 31');
    FConexao.Query.SQL.Add('Group By Rd.Data, Ped.PedidoId, De.ProcessoId');
    FConexao.Query.SQL.Add('select Ped.Data, (Case When Ped.ProcessoId = 1 then 1');
    FConexao.Query.SQL.Add('		   	                              When Ped.Processoid in (2, 22) then 2');
    FConexao.Query.SQL.Add('		                                  When Ped.ProcessoId in (3, 7, 8) then 3');
    FConexao.Query.SQL.Add('		                                  When Ped.ProcessoId in (9, 10, 11, 12) then 4');
    FConexao.Query.SQL.Add('			                                When Ped.ProcessoId = 15 then 6');
    FConexao.Query.SQL.Add(' 			                                Else 5 End) as Processoid, Ped.Total Into #PedidoResumo');
    FConexao.Query.SQL.Add('From #Pedidos Ped');
    FConexao.Query.SQL.Add('Select Data, Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+');
    FConexao.Query.Sql.Add('             Coalesce([5], 0)+Coalesce([6], 0) As '+#39+'Demanda'+#39+',');
    FConexao.Query.SQL.Add('       COALESCE ([1], 0) AS '+#39+'Recebido'+#39);
    FConexao.Query.SQL.Add('     , COALESCE ([2], 0) AS '+#39+'Cubagem'+#39);
    FConexao.Query.SQL.Add('     , COALESCE ([3], 0) AS '+#39+'Apanhe'+#39);
    FConexao.Query.SQL.Add('     , COALESCE ([4], 0) AS '+#39+'CheckOut'+#39);
    FConexao.Query.SQL.Add('     , COALESCE ([5], 0) AS '+#39+'Expedicao'+#39);
    FConexao.Query.SQL.Add('     , COALESCE ([6], 0) AS '+#39+'Cancelado'+#39+', Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /');
    FConexao.Query.SQL.Add('       Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+');
    FConexao.Query.SQL.Add('       Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia');
    FConexao.Query.SQL.Add('FROM   (SELECT Data, ProcessoId, Total');
    FConexao.Query.SQL.Add('        FROM #PedidoResumo as P) AS Tbl PIVOT (sum(Total)');
    FConexao.Query.SQL.Add('		            FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt');
    FConexao.Query.SQL.Add('Order by Data');
    if pDataInicio = 0 then
       FConexao.Query.ParamByName('pDtInicio').Value := pDataInicio
    Else
       FConexao.Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
       FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
       FConexao.Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.SQL.Add('--DtInicio = ' + FormatDateTime('YYYY-MM-DD', pDataInicio));
    FConexao.Query.SQL.Add('--DtTermino = ' + FormatDateTime('YYYY-MM-DD', pDataTermino));
    FConexao.Query.SQL.Add('--RotaId = ' + pRotaId.ToString);
    FConexao.Query.SQL.Add('--ZonaId = ' + pZonaId.ToString);
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoPed.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados));
    End
    Else
       Result := FConexao.Query.ToJSONArray;
  Except On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
            '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnid(const pDataInicio,
  pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoUnid);
    if pDataInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := 0
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoUnid.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidZona(const pDataInicio,
  pDataTermino: TDateTime; pRotaId: Integer; pZonaIdStr : String): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add( GetSqlEvolucaoAtendimentoUnidadesZona(pZonaIdStr));//TuEvolutConst.SqlGetEvolucaoAtendimentoUnidZona);
    if pDataInicio = 0 then
       FConexao.Query.ParamByName('pDtInicio').Value := 0
    Else
       FConexao.Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
       FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
       FConexao.Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pRotaId').Value       := pRotaId;
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoUnidZona.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
    End
    Else
       Result := FConexao.Query.ToJSONArray;
  Except On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
                             '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidEmbalagem(const pDataInicio, pDataTermino: TDateTime;
         pRotaId: Integer; pTipo, pZonaIdStr : String) : TjSonArray;
begin
  Try
    if pTipo = 'Unid' then
       FConexao.Query.SQL.Add(GetSqlAtendimentoUnidadesPorEmbalagem(pZonaIdStr)) //TuEvolutConst.SqlGetEvolucaoAtendimentoUnidEmbalagem)
    Else
       FConexao.Query.SQL.Add(GetSqlAtendimentoVolumesPorEmbalagem(pZonaIdStr)); //TuEvolutConst.SqlGetEvolucaoAtendimentoVolEmbalagem);
//    FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoVolEmbalagemteste.Sql');
    if pDataInicio = 0 then
       FConexao.Query.ParamByName('pDtInicio').Value := 0
    Else
       FConexao.Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
       FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
       FConexao.Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pZonaId').Value := StrToIntDef(pZonaIdStr, 0);
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoUnidEmbalagem.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Evolução do Ressuprimento(Detalhes).'))
    End
    Else
       Result := FConexao.Query.ToJSONArray;
  Except On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoVol(const pDataInicio,
  pDataTermino: TDateTime; pRotaId: Integer; pZonaIdStr : String): TjSonArray;
begin
  Try
    //FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoVol);
    FConexao.Query.SQL.Add(GetSqlAtendimentoVolumes(pZonaIdStr));
    If DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoVolTeste.Sql');

    if pDataInicio = 0 then
       FConexao.Query.ParamByName('pDtInicio').Value := pDataInicio
    Else
       FConexao.Query.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
       FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
       FConexao.Query.ParamByName('pDtTermino').Value := FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pZonaId').Value := StrToIntDef(pZonaIdStr, 0);
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoVol.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados));
    End
    Else
       Result := FConexao.Query.ToJSONArray;
  Except On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashBoard0102(Const AParams
  : TDictionary<string, string>): TJsonObject;
Var
  pDtInicio, pDtTermino: TDate;
begin
  Try
    Result := TJsonObject.Create;
    pDtInicio := 0;
    pDtTermino := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashboad0102);
    if AParams.ContainsKey('dtinicio') then
      pDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      pDtTermino := StrToDate(AParams.Items['dttermino']);
    if pDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio);
    if pDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := pDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('DashBoard0102.Sql');
    FConexao.Query.Open;
    Result.AddPair('diario', FConexao.Query.ToJSONArray);
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashboad0102);
    FConexao.Query.ParamByName('pDtInicio').Value := (pDtInicio - 31);
    FConexao.Query.ParamByName('pDtTermino').Value := (pDtInicio - 1);
    FConexao.Query.Open;
    Result.AddPair('mensal', FConexao.Query.ToJSONArray);
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashBoard030405(Const AParams
  : TDictionary<string, string>): TjSonArray;
Var
  pDtInicio, pDtTermino: TDate;
begin
  Try
    pDtInicio := 0;
    pDtTermino := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashboard030405);
    if AParams.ContainsKey('dtinicio') then
      pDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      pDtTermino := StrToDate(AParams.Items['dttermino']);
    if pDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio);
    if pDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := pDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino);
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashBoard06(Const AParams
  : TDictionary<string, string>): TjSonArray;
Var
  pDtInicio, pDtTermino: TDate;
Begin
  Try
    pDtInicio := 0;
    pDtTermino := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashBoard06);
    if AParams.ContainsKey('dtinicio') then
      pDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      pDtTermino := StrToDate(AParams.Items['dttermino']);
    if pDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio);
    if pDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := pDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino);
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDocumento(pDocumento: String; pPessoaId: Integer)
  : TjSonArray;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := 0;
    FConexao.Query.ParamByName('pDataIni').Value := 0;
    FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumento;
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := 0;
    FConexao.Query.ParamByName('pOPeracaoTipoId').Value := 2;
    FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.ParamByName('pProcessoId').Value := 0;
    FConexao.Query.ParamByName('pMontarCarga').Value := 2;
    FConexao.Query.ParamByName('pCodProduto').Value := 0;
    FConexao.Query.ParamByName('pPedidoPendente').Value := 0;
    FConexao.Query.ParamByName('pCargaId').Value := 0;
    FConexao.Query.ParamByName('pNotaFiscalERP').Value := '';
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoDocumento.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', TUtil.TratarExcessao(E.Message))));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashproducaodiaria(pDataInicial, pDataFInal: TDateTime): TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetDashproducaodiaria);
    FConexao.Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
    FConexao.Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataFinal);
    If DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('DshProducaoDiariaUnidades.Sql');
    FConexao.Query.Open();
    If FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except On E: Exception do
    raise Exception.Create(TUtil.TratarExcessao(E.Message));
  End;
end;

function TPedidoSaidaDao.GetDashproducaodiariaZona(pDataInicial,
  pDataFInal: TDateTime): TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetDashproducaodiariaZona);
    FConexao.Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
    FConexao.Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataFinal);
    If DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('DshProducaoDiariaUnidades.Sql');
    FConexao.Query.Open();
    If FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except On E: Exception do
    raise Exception.Create(TUtil.TratarExcessao(E.Message));
  End;
end;

function TPedidoSaidaDao.GetId(pPedidoId: Integer): TjSonArray;
var
  ObjPedidoProduto: TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pDataIni').Value := 0;
    FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;

    FConexao.Query.ParamByName('pPessoaId').Value := 0;
    FConexao.Query.ParamByName('pDocumentoNr').Value := '';
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := 0;
    FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.ParamByName('pOperacaoTipoId').Value := 2;
    FConexao.Query.ParamByName('pProcessoId').Value := 0;
    FConexao.Query.ParamByName('pMontarCarga').Value := 2;
    FConexao.Query.ParamByName('pCodProduto').Value := 0;
    FConexao.Query.ParamByName('pPedidoPendente').Value := 0;
    FConexao.Query.ParamByName('pCargaId').Value := 0;
    FConexao.Query.ParamByName('pNotaFiscalERP').Value := '';

    if pPedidoId = 0 then
      FConexao.Query.ParamByName('pPedidoPendente').Value := 1;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      while Not FConexao.Query.Eof do
      Begin
        PedidoSaida.PedidoId := FConexao.Query.FieldByName('PedidoId')
          .Asinteger;
        PedidoSaida.OperacaoTipo.OperacaoTipoId :=
          FConexao.Query.FieldByName('OperacaoTipoId').Asinteger;
        PedidoSaida.OperacaoTipo.Descricao := FConexao.Query.FieldByName
          ('OperacaoTipo').AsString;
        PedidoSaida.Pessoa.PessoaId := FConexao.Query.FieldByName('PessoaId')
          .Asinteger;
        PedidoSaida.Pessoa.Razao := FConexao.Query.FieldByName('Razao')
          .AsString;
        PedidoSaida.DocumentoNr := FConexao.Query.FieldByName
          ('DocumentoNr').AsString;
        PedidoSaida.DocumentoData := FConexao.Query.FieldByName('DocumentoData')
          .AsDateTime;
        PedidoSaida.DtInclusao := FConexao.Query.FieldByName('DtInclusao')
          .AsDateTime;
        PedidoSaida.HrInclusao := FConexao.Query.FieldByName('HrInclusao')
          .AsDateTime;
        PedidoSaida.ArmazemId := FConexao.Query.FieldByName('ArmazemId')
          .Asinteger;
        PedidoSaida.Status := FConexao.Query.FieldByName('Status').Asinteger;
        PedidoSaida.uuid := FConexao.Query.FieldByName('uuid').AsString;
        // vQryProduto.Open('Declare @Pedido Integer = '+FConexao.Query.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
        ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
        ArrayPedidoProdutoDAO := ObjPedidoSaidaItensDAO.GetId(pPedidoId);
        // vQryProduto.FieldByName('PedidoId').AsInteger);
        for vItens := 0 to ArrayPedidoProdutoDAO.Count - 1 do
        Begin
          ObjPedidoProduto := ObjPedidoProduto.JsonToClass
            (ArrayPedidoProdutoDAO.Items[vItens].ToString());
          PedidoSaida.ListProduto.Add(ObjPedidoProduto);
        End;
        Result.AddElement(tJson.ObjectToJsonObject(PedidoSaida,
          [joDateFormatISO8601]));
        ObjPedidoSaidaItensDAO.Free;
        FConexao.Query.Next;
      End;
    ObjPedidoProduto := Nil;
    ArrayPedidoProdutoDAO := nil;
  Except
    ON E: Exception do
    Begin
      ObjPedidoProduto := Nil;
      ArrayPedidoProdutoDAO := nil;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetLoteParaVolumeFracionado(pPedidoId: Integer)
  : TjSonArray;
var
  vSql: String;
  jsonEstoqueDisponivel: TJsonObject;
begin
  try
    // FConexao.Query.SQL.Add(TuEvolutConst.SqlGetLoteParaVolumeFracionado);
    // clipboard.AsText := FConexao.Query.SQL.Text;
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('LoteParaVolumeFracionado.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Pedido(' + pPedidoId.ToString() + ') indisponível para Cubagem!')));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TPedidoSaidaDao.GetMotivoExclusaoPedido: TJsonArray;
begin
  Try
    FConexao.Query.SQL.Add('Select * from MEP');
    FConexao.Query.SQL.Add('Order by Descricao');
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('MEP.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Sem Cadastro de Motivos para Exclusão.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
    End;
  End;

end;

function TPedidoSaidaDao.Getmotivoexclusaopedido4D(const AParams: TDictionary<string, string>): TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
Begin
  Try
    Result := TJsonObject.Create();
    QryPesquisa := FConexao.GetQuery;
    QryPesquisa.SQL.Add('Select * from MEP where 1 = 1');
    QryRecordCount := FConexao.GetQuery;
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
    QryPesquisa.Close;
    QryRecordCount.Close;
  end;
end;

function TPedidoSaidaDao.GetMovimentacao(const AParams : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetMovimentacaoRessuprimento);
    if AParams.ContainsKey('pedidoid') then
      FConexao.Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid']
        .ToInteger()
    Else
      FConexao.Query.ParamByName('pPedidoId').Value := 0;
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('produtoid') then
      FConexao.Query.ParamByName('pProdutoid').Value :=
        AParams.Items['produtoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pProdutoId').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('MovimentacaoRessuprimento.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para gerar o Resumo da Produção.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  End;
end;

function TPedidoSaidaDao.GetPedidoAll(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr, pRegistroERP: String;
  pRotaId, pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni = 0 then
       FConexao.Query.ParamByName('pDataIni').Value := pDataIni
    Else
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
       FConexao.Query.ParamByName('pDataFin').Value := pDataFin
    Else
       FConexao.Query.ParamByName('pDataFin').Value  := FormatDateTime('YYYY-MM-DD', pDataFin);
    FConexao.Query.ParamByName('pCodigoERP').Value   := pCodigoERP;
    FConexao.Query.ParamByName('pPessoaId').Value    := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value       := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value      := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value  := pProcessoId;
    FConexao.Query.ParamByName('pMontarCarga').Value := pMontarCarga;
    FConexao.Query.ParamByName('pCodProduto').Value  := pCodProduto;
    FConexao.Query.ParamByName('pPedidoPendente').Value := pPedidoPendente;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoAll.Sql');
    FConexao.Query.ParamByName('pOperacaoTipoId').Value := 2;
    // FConexao.Query.ResourceOptions.CmdExecMode := amAsync;
    FConexao.Query.Open;
    // while FConexao.Query.Command.State = csExecuting do begin
    // do something while query is executing
    // end;
    // FConexao.Query.ResourceOptions.CmdExecMode := amBlocking;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      while Not FConexao.Query.Eof do
      Begin
        JsonRetorno := TJsonObject.Create();
        JsonRetorno.AddPair('pedidoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('PedidoId').Asinteger));
        JsonRetorno.AddPair('operacaotipoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('OperacaoTipoId')
          .Asinteger));
        JsonRetorno.AddPair('operacao',
          FConexao.Query.FieldByName('OperacaoTipo').AsString);
        JsonRetorno.AddPair('pessoaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').Asinteger));
        JsonRetorno.AddPair('codpessoaerp',
          TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaErp')
          .Asinteger));
        JsonRetorno.AddPair('razao', FConexao.Query.FieldByName('Razao')
          .AsString);
        JsonRetorno.AddPair('documentooriginal',
          FConexao.Query.FieldByName('DocumentoOriginal').AsString);
        JsonRetorno.AddPair('documentonr',
          FConexao.Query.FieldByName('DocumentoNr').AsString);
        JsonRetorno.AddPair('documentodata',
          DateToStr(FConexao.Query.FieldByName('DocumentoData').AsDateTime));
        JsonRetorno.AddPair('dtinclusao',
          DateToStr(FConexao.Query.FieldByName('DtInclusao').AsDateTime));
        JsonRetorno.AddPair('hrinclusao',
          TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('HrInclusao')
          .AsString, 1, 8))));
        JsonRetorno.AddPair('armazemid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ArmazemId')
          .Asinteger));
        JsonRetorno.AddPair('status',
          TJsonNumber.Create(FConexao.Query.FieldByName('Status').Asinteger));
        JsonRetorno.AddPair('rotaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
        JsonRetorno.AddPair('rota', FConexao.Query.FieldByName('Rota')
          .AsString);
        JsonRetorno.AddPair('processoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoId')
          .Asinteger));
        JsonRetorno.AddPair('dtprocesso',
          FConexao.Query.FieldByName('DtProcesso').AsString);
        JsonRetorno.AddPair('etapa', FConexao.Query.FieldByName('Etapa')
          .AsString);
        JsonRetorno.AddPair('cargaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('CargaId').Asinteger));
        JsonRetorno.AddPair('processoidcarga',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoIdCarga')
          .Asinteger));
        JsonRetorno.AddPair('processocarga',
          FConexao.Query.FieldByName('ProcessoCarga').AsString);
        JsonRetorno.AddPair('carregamentoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('CarregamentoId')
          .Asinteger));
        JsonRetorno.AddPair('picking',
          TJsonNumber.Create(FConexao.Query.FieldByName('Picking').Asinteger));
        JsonRetorno.AddPair('itens',
          TJsonNumber.Create(FConexao.Query.FieldByName('Itens').Asinteger));
        JsonRetorno.AddPair('demanda',
          TJsonNumber.Create(FConexao.Query.FieldByName('Demanda').Asinteger));
        JsonRetorno.AddPair('qtdsuprida',
          TJsonNumber.Create(FConexao.Query.FieldByName('QtdSuprida')
          .Asinteger));
        JsonRetorno.AddPair('registroerp',
          FConexao.Query.FieldByName('RegistroERP').AsString);
        JsonRetorno.AddPair('uuid', FConexao.Query.FieldByName('uuid')
          .AsString);
        JsonRetorno.AddPair('tvolumes',
          TJsonNumber.Create(FConexao.Query.FieldByName('TVolCxaFechada')
          .Asinteger + FConexao.Query.FieldByName('TVOlFracionado').Asinteger +
          FConexao.Query.FieldByName('Cancelado').Asinteger));
        JsonRetorno.AddPair('tvolCxaFechada',
          TJsonNumber.Create(FConexao.Query.FieldByName('TVolCxaFechada')
          .Asinteger));
        JsonRetorno.AddPair('tvolFracionado',
          TJsonNumber.Create(FConexao.Query.FieldByName('TVOlFracionado')
          .Asinteger));
        JsonRetorno.AddPair('cancelado',
          TJsonNumber.Create(FConexao.Query.FieldByName('Cancelado')
          .Asinteger));
        JsonRetorno.AddPair('peso',
          TJsonNumber.Create(FConexao.Query.FieldByName('Peso').AsFloat));
        JsonRetorno.AddPair('volcm3',
          TJsonNumber.Create(FConexao.Query.FieldByName('VolCm3').AsFloat));
        JsonRetorno.AddPair('volm3',
          TJsonNumber.Create(FConexao.Query.FieldByName('Volm3').AsFloat));
        JsonRetorno.AddPair('processado',
          TJsonNumber.Create(FConexao.Query.FieldByName('Processado')
          .Asinteger));
        JsonRetorno.AddPair('concluido',
          TJsonNumber.Create(FConexao.Query.FieldByName('Concluido')
          .Asinteger));
        Result.AddElement(JsonRetorno);
        // tJson.ObjectToJsonObject(PedidoSaida, [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
  finally
    FConexao.Query.Close
  end;
end;

function TPedidoSaidaDao.GetPedidoProcesso(pPedidoId: Integer): TjSonArray;
Var
  JsonVolumeHistorico: TJsonObject;
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoProcesso);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoProcesso.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoProcesso - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetPedidoResumoAtendimento(pPedidoId: Integer;
  pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPedidoResumoAtendimento);
    FConexao.Query.ParamByName('pPedidoId').Value    := pPedidoId;
    FConexao.Query.ParamByName('pDivergencia').Value := pDivergencia;
    FConexao.Query.ParamByName('pDataInicial').Value := 0;
    FConexao.Query.ParamByName('pDataFinal').Value   := 0;
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('PedidoResumoAtendimento.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
  end;
end;

function TPedidoSaidaDao.GetAuditoriaSaidaPorProduto(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetAuditoriaSaidaPorProduto);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('pedidoid') then
      FConexao.Query.ParamByName('pPedidoid').Value := AParams.Items['pedidoid']
        .ToInteger()
    Else
      FConexao.Query.ParamByName('pPedidoId').Value := 0;
    if AParams.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value :=
        AParams.Items['codproduto'].ToInteger()
    Else
      FConexao.Query.ParamByName('pusuarioid').Value := 0;
    if AParams.ContainsKey('descrlote') then
      FConexao.Query.ParamByName('pDescrLote').Value :=
        AParams.Items['descrlote']
    Else
      FConexao.Query.ParamByName('pDescrLote').Value := '';
    if AParams.ContainsKey('ressuprimento') then
      FConexao.Query.ParamByName('pRessuprimento').Value :=
        AParams.Items['ressuprimento']
    Else
      FConexao.Query.ParamByName('pRessuprimento').Value := '';
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('SaidaPorProduto.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
  end;
end;

function TPedidoSaidaDao.GetClientesRotaCarga(const AParams : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoCarga);
    If AParams.ContainsKey('pedidoid') then
       FConexao.Query.ParamByName('pPedidoId').AsLargeInt := AParams.Items['pedidoid'].ToInt64
    Else
      FConexao.Query.ParamByName('pPedidoId').Value := 0;
    Try
      if AParams.ContainsKey('dataini') then
        FConexao.Query.ParamByName('pDataIni').Value := StrToDate(AParams.Items['dataini'])
      Else
        FConexao.Query.ParamByName('pDataIni').Value := 0;
    Except
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos é inválida!')));
      Exit;
    End;
    Try
      if AParams.ContainsKey('datafin') then
        FConexao.Query.ParamByName('pDataFin').Value := StrToDate(AParams.Items['datafin'])
      Else
        FConexao.Query.ParamByName('pDataFin').Value := 0;
    Except
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos é inválida!')));
      Exit;
    End;
    If AParams.ContainsKey('pessoaid') then
       FConexao.Query.ParamByName('pPessoaId').AsLargeInt := AParams.Items['pessoaid'].ToInt64
    Else
       FConexao.Query.ParamByName('pPessoaId').Value := 0;
    If AParams.ContainsKey('razao') then
       FConexao.Query.ParamByName('pRazao').AsString := AParams.Items['razao']
    Else
       FConexao.Query.ParamByName('pRazao').AsString := '';
    If AParams.ContainsKey('rotaid') then
       FConexao.Query.ParamByName('pRotaId').AsLargeInt := AParams.Items['rotaid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pOperacaoTipoId').Asinteger := 2;
    If DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('PedidoCarga.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não há dados para gerar o relatório')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do Begin
    raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetConsultaReposicao(Const AParams : TDictionary<string, string>): TjSonArray;
var vQryBasico, vQry: TFDQuery;
    vErroBody : TJsonArray;
begin
  Try
    Try
      vQryBasico := FConexao.GetQuery;
      vQry := FConexao.GetQuery;
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
    vQryBasico.Close;
    vQry.Close;
  End;
end;

function TPedidoSaidaDao.GetConsultaReposicaoProduto(pReposicaoId: Integer)
  : TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetConsultaReposicaoProduto);
    FConexao.Query.ParamByName('pReposicaoId').Value := pReposicaoId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoConsultaProduto.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para a consulta.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetCortes(const AParams: TDictionary<string, string>) : TjSonArray;
var JsonProduto: TJsonObject;
    pPedidoId, pCodProduto: Integer;
begin
  Try
    if AParams.ContainsKey('sintetico') then
       FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPedidoCortesSintetico)
    Else
       FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPedidoCortes);
    if AParams.ContainsKey('dataini') then
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
    Else
       FConexao.Query.ParamByName('pDataIni').Value := 0;
    if AParams.ContainsKey('datafin') then
       FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
    Else
       FConexao.Query.ParamByName('pDataFin').Value := 0;
    pPedidoId   := 0;
    pCodProduto := 0;
    if AParams.ContainsKey('pedidoid') then
       pPedidoId := AParams.Items['pedidoid'].ToInteger;
    if AParams.ContainsKey('codproduto') then
       pCodProduto := AParams.Items['codproduto'].ToInteger;
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger
    Else
       FConexao.Query.ParamByName('pZonaId').Value := 0;
    if AParams.ContainsKey('codpessoaerp') then
       FConexao.Query.ParamByName('pCodPessoaERP').Value := AParams.Items['codpessoaerp'].ToInteger
    Else
       FConexao.Query.ParamByName('pCodPessoaERP').Value := 0;
    if AParams.ContainsKey('rotaid') then
       FConexao.Query.ParamByName('pRotaId').Value := AParams.Items['rotaid'].ToInteger
    Else
       FConexao.Query.ParamByName('pRotaId').Value := 0;
    if AParams.ContainsKey('documentonr') then
       FConexao.Query.ParamByName('pDocumentoNr').Value := AParams.Items['documentonr']
    Else
       FConexao.Query.ParamByName('pDocumentoNr').Value := '';

    if DebugHook <> 0 then
       if AParams.ContainsKey('sintetico') then
          FConexao.Query.SQL.SaveToFile('CortesSintetico.Sql')
       Else
          FConexao.Query.SQL.SaveToFile('CortesAnalitico.Sql');
    FConexao.Query.ResourceOptions.CmdExecTimeout := 30000*3;
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create(TUtil.TratarExcessao(E.Message));
    End;
  End;
end;

function TPedidoSaidaDao.GetPendente: TjSonArray;
var
  vSql: String;
  ObjPedidoProduto: TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    vSql := TuEvolutConst.SqlPedidoProcessar;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := 0;
    FConexao.Query.ParamByName('pDataIni').Value := 0;
    FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := 0;
    FConexao.Query.ParamByName('pDocumentoNr').Value := '';
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := 0;
    FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.ParamByName('pProcessoId').Value := 1;
    FConexao.Query.ParamByName('pRecebido').Value := 1;
    FConexao.Query.ParamByName('pCubagem').Value := 0;
    FConexao.Query.ParamByName('pEtiqueta').Value := 0;
    FConexao.Query.ParamByName('pPrintTag').Value := 2;
    FConexao.Query.ParamByName('pEmbalagem').Value := 2;
    // Todos os pedidos disponíveis para processamento
    // vSql := vSql + ' Where PedidoId = '+pPedidoId.ToString+' and Ped.OperacaoTipoId = 2';
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      While Not FConexao.Query.Eof do
      Begin
        PedidoSaida.PedidoId := FConexao.Query.FieldByName('PedidoId')
          .Asinteger;
        PedidoSaida.OperacaoTipo.OperacaoTipoId :=
          FConexao.Query.FieldByName('OperacaoTipoId').Asinteger;
        PedidoSaida.OperacaoTipo.Descricao := FConexao.Query.FieldByName
          ('OperacaoTipo').AsString;
        PedidoSaida.Pessoa.PessoaId := FConexao.Query.FieldByName('PessoaId')
          .Asinteger;
        PedidoSaida.Pessoa.Razao := FConexao.Query.FieldByName('Razao')
          .AsString;
        PedidoSaida.DocumentoNr := FConexao.Query.FieldByName
          ('DocumentoNr').AsString;
        PedidoSaida.DocumentoData := FConexao.Query.FieldByName('DocumentoData')
          .AsDateTime;
        PedidoSaida.DtInclusao := FConexao.Query.FieldByName('DtInclusao')
          .AsDateTime;
        PedidoSaida.HrInclusao := FConexao.Query.FieldByName('HrInclusao')
          .AsDateTime;
        PedidoSaida.ArmazemId := FConexao.Query.FieldByName('ArmazemId')
          .Asinteger;
        PedidoSaida.Status := FConexao.Query.FieldByName('Status').Asinteger;
        PedidoSaida.uuid := FConexao.Query.FieldByName('uuid').AsString;
        // vQryProduto.Open('Declare @Pedido Integer = '+FConexao.Query.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
        ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
        ArrayPedidoProdutoDAO := ObjPedidoSaidaItensDAO.GetId(0);
        // vQryProduto.FieldByName('PedidoId').AsInteger);
        for vItens := 0 to ArrayPedidoProdutoDAO.Count - 1 do
        Begin
          ObjPedidoProduto := ObjPedidoProduto.JsonToClass
            (ArrayPedidoProdutoDAO.Items[vItens].ToString());
          PedidoSaida.ListProduto.Add(ObjPedidoProduto);
        End;
        Result.AddElement(tJson.ObjectToJsonObject(PedidoSaida,
          [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
    ObjPedidoProduto := Nil;
    ArrayPedidoProdutoDAO := nil;
  Except
    ON E: Exception do
    Begin
      ObjPedidoProduto := Nil;
      ArrayPedidoProdutoDAO := nil;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetProducaoPendente: TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetProducaoPendente);
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetProdutoReposicao(const AParams : TDictionary<string, string>): TjSonArray;
var JsonProduto: TJsonObject;
begin
  Try
    FConexao.Query.SQL.Add('Select ProdutoId, CodProduto, Descricao, EnderecoId, Endereco, FatorConversao, EmbalagemPadrao, ');
    FConexao.Query.SQL.Add('       Quantidade, Fracionado, EstPicking, (Fracionado-EstPicking) QtdReposicao');
    FConexao.Query.SQL.Add('From');
    FConexao.Query.SQL.Add('   (Select PP.ProdutoId, Prd.CodProduto, Prd.Descricao, TEnd.EnderecoId, TEnd.Descricao Endereco, Prd.FatorConversao, PP.EmbalagemPadrao,');
    FConexao.Query.SQL.Add('           Sum(PP.Quantidade) Quantidade,');
    FConexao.Query.SQL.Add('           Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade /  Prd.FatorConversao) Else 0 End)) CaixaFechada ,');
    FConexao.Query.SQL.Add('		         Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End)) Fracionado');
    FConexao.Query.SQL.Add('           , Est.Estoque EstPicking--, ((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End) - Est.Estoque) As QtdReposicao');
    FConexao.Query.SQL.Add('   From Pedido Ped');
    FConexao.Query.SQL.Add('   Inner Join PedidoProdutos PP ON PP.PedidoId = Ped.PedidoId');
    FConexao.Query.SQL.Add('			Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId');
    FConexao.Query.SQL.Add('			Left Join Enderecamentos TEnd On TEnd.EnderecoId = Prd.EnderecoId');
    FConexao.Query.SQL.Add('   Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData');
//    FConexao.Query.Sql.Add('Inner join (Select Documento, Max(DataHora) horario From DocumentoEtapas Where Status = 1 Group by Documento) DeM On DeM.Documento = Pv.Uuid');
    FConexao.Query.Sql.Add('Inner Join vDocumentoEtapas De on De.Documento = Pv.uuid and --De.Horario = DeM.horario and');
    FConexao.Query.Sql.Add('                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento) --and Horario = De.Horario) ');
    //    FConexao.Query.SQL.Add('   Left  Join vDocumentoEtapas De On De.Documento = Ped.uuid');
    FConexao.Query.SQL.Add('			Left Join (Select ProdutoId, SUM(Qtde) Estoque ');
    FConexao.Query.SQL.Add('              From vEstoqueProducao ');
    FConexao.Query.SQL.Add('              where PickingFixo = 1');
    FConexao.Query.SQL.Add('              Group by ProdutoId) Est ON Est.ProdutoId = PP.ProdutoId');
    FConexao.Query.SQL.Add('			Where De.ProcessoId <> 15');
    FConexao.Query.SQL.Add('		   and Ped.OperacaoTipoId = 2');
    if AParams.ContainsKey('datapedido') then begin
       FConexao.Query.SQL.Add(' 		      and Dp.Data = :DataPedido ');
       FConexao.Query.ParamByName('datapedido').Value := AParams.Items['datapedido'];
    end;
    FConexao.Query.SQL.Add('			Group by PP.ProdutoId, Prd.CodProduto, Prd.Descricao, TEnd.EnderecoId, ');
    FConexao.Query.SQL.Add('            TEnd.Descricao, Prd.FatorConversao, PP.EmbalagemPadrao, Est.Estoque');
    FConexao.Query.SQL.Add(') as ProdReposicao');
    // FConexao.Query.SQL.Add('where (Fracionado-EstPicking) > 0');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

Function TPedidoSaidaDao.GetRelAnaliseRessuprimento(const AParams : TDictionary<string, string>; pVolume: Boolean): TjSonArray;
var vDtInicio, vDtTermino: TDate;
    vRotaId: Integer;
    vPessoaId: Integer;
begin
  vDtInicio := 0;
  vDtTermino := 0;
  vRotaId := 0;
  vPessoaId := 0;
  Try
    if pVolume then
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRelAnaliseRessuprimentoVolume)
    Else
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRelAnaliseRessuprimento);
    if AParams.ContainsKey('dtinicio') then
      vDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      vDtTermino := StrToDate(AParams.Items['dttermino']);
    if vDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := vDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', vDtInicio);
    if vDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := vDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', vDtTermino);
    if AParams.ContainsKey('rotaid') then
      vRotaId := StrToIntDef(AParams.Items['rotaid'], 0);
    FConexao.Query.ParamByName('pRotaId').Value := vRotaId;
    if AParams.ContainsKey('codpessoaerp') then
      vPessoaId := StrToIntDef(AParams.Items['codpessoaerp'], 0);
    if (pVolume) then
    Begin
      If (AParams.ContainsKey('zonaid')) then
        FConexao.Query.ParamByName('pZonaId').Value :=
          StrToIntDef(AParams.Items['zonaid'], 0)
      Else
        FConexao.Query.ParamByName('pZonaId').Value := 0;
    End;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := vPessoaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('AnaliseRessuprimentos.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetRelApanhePicking(Const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelApahaPicking);
    if AParams.ContainsKey('dataini') then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if AParams.ContainsKey('datafin') then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    if AParams.ContainsKey('codpessoaerp') then
      FConexao.Query.ParamByName('pCodPessoaERP').Value :=
        StrToIntDef(AParams.Items['codpessoaerp'], 0)
    Else
      FConexao.Query.ParamByName('pCodPessoaERP').Value := 0;
    if AParams.ContainsKey('rotaid') then
      FConexao.Query.ParamByName('pRotaId').Value :=
        StrToIntDef(AParams.Items['rotaid'], 0)
    Else
      FConexao.Query.ParamByName('pRotaId').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ApanhePicking.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetRelColetaPulmao(Const AParams : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelColetaPulmao);
    if AParams.ContainsKey('dataini') then
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
    Else
       FConexao.Query.ParamByName('pDataIni').Value := 0;
    if AParams.ContainsKey('datafin') then
       FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
    Else
       FConexao.Query.ParamByName('pDataFin').Value := 0;
    if AParams.ContainsKey('codpessoaerp') then
       FConexao.Query.ParamByName('pCodPessoaERP').Value := StrToIntDef(AParams.Items['codpessoaerp'], 0)
    Else
       FConexao.Query.ParamByName('pCodPessoaERP').Value := 0;
    if AParams.ContainsKey('rotaid') then
       FConexao.Query.ParamByName('pRotaId').Value := StrToIntDef(AParams.Items['rotaid'], 0)
    Else
       FConexao.Query.ParamByName('pRotaId').Value := 0;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pzonaid').Value := StrToIntDef(AParams.Items['zonaid'], 0)
    Else
      FConexao.Query.ParamByName('pzonaid').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ColetaPulmao.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do Begin
    raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetRelRupturaAbastecimento(pDataIni,
  pDataFin: TDateTime): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelRupturaAbastecimento);
    if pDataIni = 0 then
      FConexao.Query.ParamByName('pDataIni').Value := 0
    Else
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
      FConexao.Query.ParamByName('pDataFin').Value := 0
    Else
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin);
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('RupturaAbastecimento.Sql');
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoAutomatica(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetReposicaoAutomatica);
    Try
      If AParams.ContainsKey('data') then
        if StrToDate(AParams.Items['data']) = 0 then
          FConexao.Query.ParamByName('pDataReposicao').Value := 0
        Else
          FConexao.Query.ParamByName('pDataReposicao').Value :=
            FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['data']))
      Else
        FConexao.Query.ParamByName('pDataReposicao').Value := 0;
    Except
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data de Reposição inválida!')));
        Exit;
      End;
    End;
    If AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    If AParams.ContainsKey('enderecoinicial') then
      FConexao.Query.ParamByName('penderecoinicial').Value :=
        AParams.Items['enderecoinicial']
    Else
      FConexao.Query.ParamByName('penderecoinicial').Value := '';
    If AParams.ContainsKey('enderecofinal') then
      FConexao.Query.ParamByName('penderecofinal').Value :=
        AParams.Items['enderecofinal']
    Else
      FConexao.Query.ParamByName('penderecofinal').Value := '';
    FConexao.Query.ParamByName('pStatus').Value := 0;
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoAutomatica.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não há dados para gerar Coleta da Reposição')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoAutomaticaColeta(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetReposicaoAutomaticaColeta);
    Try
      If AParams.ContainsKey('data') then
        if StrToDate(AParams.Items['data']) = 0 then
          FConexao.Query.ParamByName('pDataReposicao').Value := 0
        Else
          FConexao.Query.ParamByName('pDataReposicao').Value :=
            FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['data']))
      Else
        FConexao.Query.ParamByName('pDataReposicao').Value := 0;
    Except
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data de Reposição inválida!')));
        Exit;
      End;
    End;
    If AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    If AParams.ContainsKey('enderecoinicial') then
      FConexao.Query.ParamByName('penderecoinicial').Value :=
        AParams.Items['enderecoinicial']
    Else
      FConexao.Query.ParamByName('penderecoinicial').Value := '';
    If AParams.ContainsKey('enderecofinal') then
      FConexao.Query.ParamByName('penderecofinal').Value :=
        AParams.Items['enderecofinal']
    Else
      FConexao.Query.ParamByName('penderecofinal').Value := '';
    FConexao.Query.ParamByName('pStatus').Value := 0;
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoAutomaticaColeta.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não há dados para gerar Coleta da Reposição')));
      Exit;
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoEnderecoColeta(pData: TDate;
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.GetReposicaoEnderecoColeta);
    FConexao.Query.ParamByName('pDataPedido').Value :=
      FormatDateTime('YYYY-MM-DD', pData);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pEnderecoInicial').Value := pEnderecoInicial;
    FConexao.Query.ParamByName('pEnderecoFinal').Value := pEnderecoFinal;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoColetaEndereco.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoGerar(pData: TDate; pZonaId: Integer;
  pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetGerarReposicao);
    // FConexao.Query.Sql.Add('Order by Prd.ZonaDescricao, Prd.Descricao');
    FConexao.Query.ParamByName('pDataPedido').Value :=
      FormatDateTime('YYYY-MM-DD', pData);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pEnderecoIni').Value := pEnderecoInicial;
    FConexao.Query.ParamByName('pEnderecoFin').Value := pEnderecoFinal;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoGerar.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoModelo(pModeloId: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add('Declare @ModeloId Integer = :pModeloId');
    FConexao.Query.SQL.Add('Select * from vReposicaoModelo');
    FConexao.Query.SQL.Add
      ('Where (@ModeloId = 0 or ReposicaoModeloId = @ModeloId)');
    FConexao.Query.ParamByName('pModeloId').Value := pModeloId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoModelo.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetResumoProducao(Const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetResumoOperacao);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pprocessoid').Value :=
        AParams.Items['processoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pprocessoid').Value := 0;
    if AParams.ContainsKey('usuarioid') then
      FConexao.Query.ParamByName('pusuarioid').Value :=
        AParams.Items['usuarioid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pusuarioid').Value := 0;
    if AParams.ContainsKey('dtpedidoini') then
      FConexao.Query.ParamByName('pDtPedidoIni').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidoini']))
    Else
      FConexao.Query.ParamByName('pDtPedidoIni').Value := 0;
    if AParams.ContainsKey('dtpedidofin') then
      FConexao.Query.ParamByName('pdtpedidofin').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidofin']))
    Else
      FConexao.Query.ParamByName('pdtpedidofin').Value := 0;
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('ResumoProducao.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para gerar o Resumo da Produção.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
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
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetAuditoriaSaidaPorProdutoBalanceamento);
    if AParams.ContainsKey('datainicio') then
       FConexao.Query.ParamByName('pdatainicio').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicio']))
    Else
       FConexao.Query.ParamByName('pdatainicio').Value := 0;
    if AParams.ContainsKey('datatermino') then
       FConexao.Query.ParamByName('pdataTermino').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datatermino']))
    Else
       FConexao.Query.ParamByName('pDataTermino').Value := 0;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.SQL.Add('--datainicio = '+FConexao.Query.ParamByName('pdatainicio').AsString);
    FConexao.Query.SQL.Add('--dataternino = '+FConexao.Query.ParamByName('pdatatermino').AsString);
    FConexao.Query.SQL.Add('--zonaid = '+FConexao.Query.ParamByName('pzonaid').AsString);

    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('SaidaPorProdutoBalanceamento.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('MSG', TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except ON E: Exception do
      raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
  end;
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
        SqlDataAtual + ', ' + SqlHoraAtual + ', ' + pArmazemId.ToString()
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        pOperacaoTipoId.ToString() + '   , PessoaId      = ' +
        pPessoaId.ToString() + '   , DocumentoNr   = ' + QuotedStr(pDocumentoNr)
        + '   , DocumentoData = ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + ')' +
      // '   , DtInclusao    = '+SqlDataAtual+
      // '   , HrInclusao    = '+SqlHoraAtual+
        '   , ArmazemId     = ' + IfThen(pArmazemId = 0, 'Null',
        pArmazemId.ToString()) + ' where PedidoId = ' + pPedidoId.ToString +
        ' and OperacaoTipoId = 2';
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
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
begin
  try
    vSql := TuEvolutConst.SqlPedidoProcessar;
    // ClipBoard.Astext := vSql;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pProcessoid').Value := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    FConexao.Query.ParamByName('pPrintTag').Value := pPrintTag;
    FConexao.Query.ParamByName('pEmbalagem').Value := pEmbalagem;
    // Clipboard.AsText := FConexao.Query.Text;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoProcessar.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não há dados para gerar o relatório')));
      Exit;
    End;
    JsonArrayPedidos := TjSonArray.Create;
    while Not FConexao.Query.Eof do
    Begin
      jsonPedido := TJsonObject.Create;
      jsonOperacao := TJsonObject.Create;
      jsonNatureza := TJsonObject.Create;
      jsonPessoa := TJsonObject.Create;
      jsonPedido.AddPair('pedidoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PedidoId').Asinteger));
      jsonPedido.AddPair('processoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoId').Asinteger));
      jsonPedido.AddPair('processoetapa',
        FConexao.Query.FieldByName('ProcessoEtapa').AsString);
      jsonPedido.AddPair('statusmin',
        TJsonNumber.Create(FConexao.Query.FieldByName('StatusMin').Asinteger));
      jsonPedido.AddPair('statusmax',
        TJsonNumber.Create(FConexao.Query.FieldByName('StatusMax').Asinteger));
      jsonOperacao.AddPair('operacaotipoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('OperacaoTipoId')
        .Asinteger));
      jsonOperacao.AddPair('descricao',
        FConexao.Query.FieldByName('OperacaoTipo').AsString);
      jsonPedido.AddPair('operacaotipo', jsonOperacao);
      jsonPessoa.AddPair('pessoaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').Asinteger));
      jsonPessoa.AddPair('codpessoaerp',
        TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaERP')
        .Asinteger));
      jsonPessoa.AddPair('razao', FConexao.Query.FieldByName('Razao').AsString);
      jsonPessoa.AddPair('fantasia', FConexao.Query.FieldByName('Fantasia')
        .AsString);
      jsonPessoa.AddPair('rotaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
      jsonPessoa.AddPair('rota', FConexao.Query.FieldByName('Rota').AsString);
      jsonPedido.AddPair('pessoa', jsonPessoa);
      jsonPedido.AddPair('documentonr',
        FConexao.Query.FieldByName('DocumentoNr').AsString);
      jsonPedido.AddPair('documentodatar',
        DateToStr(FConexao.Query.FieldByName('DocumentoData').AsDateTime));
      // FormatDateTime('YYYY-MM-DD', FConexao.Query.FieldByName('DocumentoData').AsDateTime));
      jsonPedido.AddPair('dtinclusao', FormatDateTime('YYYY-MM-DD',
        FConexao.Query.FieldByName('DtInclusao').AsDateTime));
      jsonPedido.AddPair('hrinclusao', FConexao.Query.FieldByName('HrInclusao')
        .AsString);
      // FormatDateTime('hh:mm', FConexao.Query.FieldByName('HrInclusao').AsDateTime));
      jsonPedido.AddPair('armazemid',
        TJsonNumber.Create(FConexao.Query.FieldByName('ArmazemId').Asinteger));
      jsonPedido.AddPair('status',
        TJsonNumber.Create(FConexao.Query.FieldByName('Status').Asinteger));
      jsonPedido.AddPair('qtdproduto',
        TJsonNumber.Create(FConexao.Query.FieldByName('QtdProdutos')
        .Asinteger));
      jsonPedido.AddPair('peso',
        TJsonNumber.Create(FConexao.Query.FieldByName('peso').Asinteger));
      jsonPedido.AddPair('volume',
        TJsonNumber.Create(FConexao.Query.FieldByName('volume').AsFloat));
      jsonPedido.AddPair('registroerp',
        FConexao.Query.FieldByName('RegistroERP').AsString);
      jsonPedido.AddPair('picking', FConexao.Query.FieldByName('Picking')
        .AsString);
      jsonPedido.AddPair('uuid', FConexao.Query.FieldByName('uuid').AsString);
      JsonArrayPedidos.AddElement(jsonPedido);
      FConexao.Query.Next;
    End;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    // Buscar As Rotas
    vSql := TuEvolutConst.SqlPedidoRotas;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := pRazao;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoRotas.Sql');
    FConexao.Query.Open();
    jsonArrayRotas := TjSonArray.Create;
    while Not FConexao.Query.Eof do
    Begin
      jsonRota := TJsonObject.Create();
      jsonRota.AddPair('rotaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
      jsonRota.AddPair('descricao', FConexao.Query.FieldByName('Descricao')
        .AsString);
      jsonArrayRotas.AddElement(jsonRota);
      FConexao.Query.Next;
    End;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    // Buscar As Pessoas/Destinatário
    vSql := TuEvolutConst.SqlPedidoPessoa;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := pRazao;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    FConexao.Query.Open();
    JsonArrayPessoas := TjSonArray.Create;
    while Not FConexao.Query.Eof do
    Begin
      jsonPessoa := TJsonObject.Create();
      jsonPessoa.AddPair('pessoaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').Asinteger));
      jsonPessoa.AddPair('codpessoaerp',
        TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaERP')
        .Asinteger));
      jsonPessoa.AddPair('razao', FConexao.Query.FieldByName('Razao').AsString);
      jsonPessoa.AddPair('rotaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
      JsonArrayPessoas.AddElement(jsonPessoa);
      FConexao.Query.Next;
    End;
    FConexao.Query.Close;
    JsonRetorno := TJsonObject.Create;
    JsonRetorno.AddPair('pedido', JsonArrayPedidos);
    JsonRetorno.AddPair('rota', jsonArrayRotas);
    JsonRetorno.AddPair('pessoa', JsonArrayPessoas);
    Result := TjsonArray.Create;
    Result.AddElement(JsonRetorno);
    // ClipBoard.AsText := JsonRetorno.ToString();
  Except
    on E: Exception do
    Begin
      raise Exception.Create('Erro na cubagem: ' + E.Message);
    End;
  end;
end;

Function TPedidoSaidaDao.PedidoPrintTag(pPedidoId: Integer;
  pPedidoVolumeId: Integer; pDataIni, pDataFin: TDate;
  pCodigoERP, pPessoaId: Integer; pRazao: String; pRotaId: Integer;
  pRotaIdFinal: Integer; pZonaId: Integer; pProcessoId: Integer;
  pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer): TjSonArray;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoPrintTag);
    if (pRotaId > 0) or (pRotaIdFinal > 0) then
       FConexao.Query.SQL.Add('Order by RotaId, PedidoId')
    Else
       FConexao.Query.SQL.Add('Order by PedidoId');
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    if pDataIni = 0 then
      FConexao.Query.ParamByName('pDataIni').Value := pDataIni
    Else
      FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
      FConexao.Query.ParamByName('pDataFin').Value := pDataFin
    Else
      FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin);
    //FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    //FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pPrintTag').Value := pPrintTag;
    FConexao.Query.ParamByName('pEmbalagem').Value := pEmbalagem;
    // Clipboard.AsText := FConexao.Query.Text;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoPrintTag.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não há dados para gerar o relatório')));
      Exit;
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    on E: Exception do
    Begin
      raise Exception.Create('Erro na cubagem: ' + E.Message);
    End;
  end;
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
begin
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
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    if pJsonReposicao.GetValue<Integer>('modeloid') = 0 then
    Begin
      FConexao.Query.SQL.Add('Declare @ModeloId Integer = 0');
      FConexao.Query.SQL.Add('Insert Into ReposicaoModelo Values (');
      FConexao.Query.SQL.Add('GetDate(), GetDate(), 1, ' + vZonaId + ', ' +
        vPickingInicial + ', ' + vPickingFinal + ', ' + vRuaInicial + ', ' +
        vRuaFinal + ', ' + vRuaImpar.ToString() + ', ' + vRuaPar.ToString() +
        ', ' + vPredioInicial + ', ' + vPredioFinal + ', ' +
        vPredioImpar.ToString() + ', ' + vPredioPar.ToString() + ', ' +
        vNivelInicial + ', ' + vNivelFinal + ', ' + vNivelImpar.ToString() +
        ', ' + vNivelPar.ToString() + ', ' + vAptoInicial + ', ' + vAptoFinal +
        ', ' + vAptoImpar.ToString() + ', ' + vAptoPar.ToString() + ', ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
        pJsonReposicao.GetValue<String>('terminal') + #39 + ')');
      FConexao.Query.SQL.Add('Set @ModeloId = SCOPE_IDENTITY()');
      FConexao.Query.SQL.Add('Select @ModeloId as ModeloId');
    End
    Else
    begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update ReposicaoModelo Set ');
      FConexao.Query.SQL.Add('   Data = GetDate()');
      FConexao.Query.SQL.Add('   , hora = GetDate()');
      FConexao.Query.SQL.Add('   , ZonaId        = ' + vZonaId);
      FConexao.Query.SQL.Add('   , PickingInicial = ' + vPickingInicial);
      FConexao.Query.SQL.Add('   , PickingFinal   = ' + vPickingFinal);
      FConexao.Query.SQL.Add('   , RuaInicial   = ' + vRuaInicial);
      FConexao.Query.SQL.Add('   , RuaFinal     = ' + vRuaFinal);
      FConexao.Query.SQL.Add('   , RuaImpar     = ' + vRuaImpar.ToString());
      FConexao.Query.SQL.Add('   , Ruapar       = ' + vRuaPar.ToString());
      FConexao.Query.SQL.Add('   , PredioInicial = ' + vPredioInicial);
      FConexao.Query.SQL.Add('   , PredioFinal   = ' + vPredioFinal);
      FConexao.Query.SQL.Add('   , PredioImpar   = ' + vPredioImpar.ToString());
      FConexao.Query.SQL.Add('   , Prediopar     = ' + vPredioPar.ToString());
      FConexao.Query.SQL.Add('   , NivelInicial  = ' + vNivelInicial);
      FConexao.Query.SQL.Add('   , NivelFinal    = ' + vNivelFinal);
      FConexao.Query.SQL.Add('   , NivelImpar    = ' + vNivelImpar.ToString());
      FConexao.Query.SQL.Add('   , Nivelpar      = ' + vNivelPar.ToString());
      FConexao.Query.SQL.Add('   , AptoInicial   = ' + vAptoInicial);
      FConexao.Query.SQL.Add('   , AptoFinal     = ' + vAptoFinal);
      FConexao.Query.SQL.Add('   , AptoImpar     = ' + vAptoImpar.ToString());
      FConexao.Query.SQL.Add('   , Aptopar       = ' + vAptoPar.ToString());
      FConexao.Query.SQL.Add('   , UsuarioId     = ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString());
      FConexao.Query.SQL.Add('   , Terminal      = ' + #39 +
        pJsonReposicao.GetValue<String>('terminal') + #39);
      FConexao.Query.SQL.Add('Where ReposicaoModeloId = ' +
        pJsonReposicao.GetValue<Integer>('modeloid').ToString());
      FConexao.Query.SQL.Add
        ('Select * From ReposicaoModelo where ReposicaoModeloId = ' +
        pJsonReposicao.GetValue<Integer>('modeloid').ToString());
    end;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoModeloSalvar.Sql');
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.ProdutoSemPicking(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pRotaId, pRecebido, pCubagem,
  pEtiqueta, pverificarEstoque: Integer): TjSonArray;
begin
  try
    // ClipBoard.Astext := vSql;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetProdutoSemPicking);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
      // FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
      // FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := 0; // pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    FConexao.Query.ParamByName('pVerificarEstoque').Value := pverificarEstoque;
    // Clipboard.AsText := FConexao.Query.Text;
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('ProdutoSemPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.PutRegistrarProcesso(pJsonObject: TJsonObject)
  : TjSonArray;
Begin
  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+
                           pJsonObject.GetValue<Integer>('pedidoid').ToString + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    FConexao.Query.ParamByName('pProcessoId').Value := pJsonObject.GetValue<Integer>('processoid');
    FConexao.Query.ParamByName('pTerminal').Value   := pJsonObject.GetValue<String>('terminal');
    FConexao.Query.ParamByName('pUsuarioId').Value  := pJsonObject.GetValue<String>('usuarioid');
    FConexao.Query.ExecSQL;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Registro realizado com sucesso!'));
  Except On E: Exception do
    Begin
      raise Exception.Create('Não foi possível Finalizar o registro da coleta. '+E.Message);
    End;
  End;
end;

function TPedidoSaidaDao.ReposicaoFinalizar(pJsonReposicao: TjSonArray)
  : TjSonArray;
Var
  vTransaction: Boolean;
  xColeta: Integer;
  vReposicaoId: Integer;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    xColeta := 0;
    vReposicaoId := pJsonReposicao.Get(xColeta)
      .GetValue<Integer>('reposicaoid');
    // SOMENTE PARA REPOSIÇÃO AUTOMÀTICA SEM COLETA (Brasil)
    { for xColeta := 0 to Pred(pJsonReposicao.Count) do Begin
      //Baixar Estoque
      if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') > 0) and
      (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid')<>'') and
      (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid')<>'0') then Begin
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(TuEvolutConst.SqlEstoque);
      vQry.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
      vQry.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
      vQry.ParamByName('pEstoqueTipoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
      vQry.ParamByName('pQuantidade').Value    := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo')*-1);
      vQry.ParamByName('pUsuarioId').Value     := (pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid'));
      vQry.ExecSQL;
      //Baixar Reserva
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(TuEvolutConst.SqlEstoque);
      vQry.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
      vQry.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
      vQry.ParamByName('pEstoqueTipoId').Value := 6;
      vQry.ParamByName('pQuantidade').Value    := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde')*-1);
      vQry.ParamByName('pUsuarioId').Value     := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
      vQry.ExecSQL;
      //Transferir para o Picking
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(TuEvolutConst.SqlEstoque);
      vQry.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
      vQry.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
      vQry.ParamByName('pEstoqueTipoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
      vQry.ParamByName('pQuantidade').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
      vQry.ParamByName('pUsuarioId').Value     := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
      vQry.ExecSQL;
      End;
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add('Update ReposicaoEnderecoColeta');
      vQry.SQL.Add('  Set QtdRepo = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo').ToString());
      vQry.SQL.Add('    , UsuarioId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid').ToString());
      vQry.SQL.Add('    , Terminal  = '+QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('terminal')));
      vQry.SQL.Add('    , DtEntrada = '+QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(pJsonReposicao.Get(xColeta).GetValue<String>('dtentrada')))));
      vQry.SQL.Add('    , HrEntrada = '+QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('hrentrada')));

      vQry.SQL.Add('Where ReposicaoId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid').ToString);
      vQry.SQL.Add('  And ProdutoId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('produtoid').ToString);
      vQry.Sql.Add('  And Loteid = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid').ToString());
      vQry.SQL.Add('  And EnderecoId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid').ToString());
      if DebugHook <> 0 then
      vQry.Sql.SaveToFile('SqlUpdateReposicaoColeta.Sql');

      vQry.ExecSQL;
      vReposicaoId := pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
      //Registrar no Kardex

      End;
    }
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Update Reposicao Set ProcessoId = (Select ProcessoId From ProcessoEtapas where Descricao = '
      + #39 + 'Reposição - Finalizada' + #39 + ') Where ReposicaoId = ' +
      vReposicaoId.ToString());
    FConexao.Query.ExecSQL;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', '201'));
  Except
    On E: Exception do
    Begin
      if vTransaction then
        FConexao.Query.connection.Rollback;
      raise Exception.Create('Não foi possível Finalizar o registro da coleta.'
        + sLineBreak + E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.ReposicaoSalvar(pJsonReposicao: TJsonObject)
  : TjSonArray;
Var
  JsonArrayItens, JsonArrayEndereco: TjSonArray;
  vGuuid: string;
  xItens, xEndereco, vReposicaoId: Integer;
  vTransaction: Boolean;

  vDataReposicao, vZonaId, vEnderecoInicial, vEnderecoFinal: String;
  vReposicaoModeloId: String;
  vProdutoId: Integer;
begin
  Try
    vGuuid := TGUID.NewGuid.ToString();
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
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
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    if Not pJsonReposicao.tryGetValue('reposicaomodeloid', vReposicaoModeloId)
    then
      vReposicaoModeloId := 'Null'
    Else
      vReposicaoModeloId := pJsonReposicao.GetValue<String>
        ('reposicaomodeloid');
    if pJsonReposicao.GetValue<Integer>('reposicaoid') = 0 then
    Begin
      if (pJsonReposicao.GetValue<String>('dtressuprimento') = '') or
        (pJsonReposicao.GetValue<String>('dtressuprimento') = '  /  /    ') then
        vDataReposicao := 'Null'
      Else
        vDataReposicao := #39 + FormatDateTime('YYYY-MM-DD',
          StrToDate(pJsonReposicao.GetValue<String>('dtressuprimento'))) + #39;
      FConexao.Query.SQL.Add('Declare @NewId Varchar(38) = ' +
        QuotedStr(vGuuid));
      FConexao.Query.SQL.Add('Declare @ProcessoId Integer = ' +
        pJsonReposicao.GetValue<Integer>('processoid').ToString());
      FConexao.Query.SQL.Add
        ('Set @ProcessoId = (select ProcessoId From PRocessoEtapas ');
      FConexao.Query.SQL.Add
        ('where descricao = (Case when @ProcessoId = 1 then ' + #39 +
        'Reposição - Criada' + #39);
      FConexao.Query.SQL.Add
        ('                        when @ProcessoId = 2 then ' + #39 +
        'Reposição - Em Coleta' + #39);
      FConexao.Query.SQL.Add('						when @ProcessoId = 3 then ' + #39 +
        'Reposição - Finalizada' + #39);
      FConexao.Query.SQL.Add('                        Else ' + #39 +
        'Reposição - Cancelada' + #39 + ' End))');
      FConexao.Query.SQL.Add('Insert Into Reposicao Values (');
      FConexao.Query.SQL.Add(vDataReposicao + ', ' +
        pJsonReposicao.GetValue<Integer>('reposicaotipo').ToString() + ', ' +
        '@ProcessoId, ' +
        // pJsonReposicao.GetValue<Integer>('processoid').ToString()+', '+
        vZonaId + ', ' + vEnderecoInicial + ', ' + vEnderecoFinal + ', ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
        pJsonReposicao.GetValue<String>('terminal') + #39 + ', ' +
        'GetDate(), (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()), 12, 12)), '
        + vReposicaoModeloId + ', ' + 'Null, Null, ' +
        // UsuarioIdInUse e TerminalInUse
        'Cast(@NewId AS UNIQUEIDENTIFIER)');
      FConexao.Query.SQL.Add(')');
      FConexao.Query.SQL.Add('Select * From Reposicao where Uuid = @NewId');
    End
    Else
    begin
      vReposicaoId := pJsonReposicao.GetValue<Integer>('reposicaoid');
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update Reposicao Set ');
      FConexao.Query.SQL.Add('   DtRessuprimento = ' + #39 +
        FormatDateTime('YYYY-MM-DD',
        StrToDate(pJsonReposicao.GetValue<String>('dtressuprimento'))) + #39);
      FConexao.Query.SQL.Add('   , ReposicaoTipo = ' +
        pJsonReposicao.GetValue<Integer>('reposicaotipo').ToString());
      FConexao.Query.SQL.Add('   , ZonaId        = ' + vZonaId);
      FConexao.Query.SQL.Add('   , EnderecoInicial = ' + vEnderecoInicial);
      FConexao.Query.SQL.Add('   , EnderecoFinal   = ' + vEnderecoFinal);
      FConexao.Query.SQL.Add('   , ReposicaoModeloId = ' + vReposicaoModeloId);
      // FConexao.Query.SQL.Add('   , ProcessoId    = '+pJsonReposicao.GetValue<Integer>('processoid').ToString());
      FConexao.Query.SQL.Add('   , UsuarioId     = ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString());
      FConexao.Query.SQL.Add('Where ReposicaoId = ' +
        pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
      FConexao.Query.SQL.Add('Select * From Reposicao where ReposicaoId = ' +
        pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
    end;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposiocaoSalvar.Sql');

    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray();
    // Salvar os Endereços da Coleta
    JsonArrayEndereco := pJsonReposicao.GetValue<TjSonArray>('coleta');
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Delete From ReposicaoEnderecoColeta Where ReposicaoId = ' +
      pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
    FConexao.Query.ExecSQL;
    For xEndereco := 0 to Pred(JsonArrayEndereco.Count) do Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Insert Into ReposicaoEnderecoColeta (reposicaoid, produtoid, loteid, enderecoid, EstoqueTipoId, EstoqueDisponivel, Qtde) Values (');
      FConexao.Query.SQL.Add(Result.Items[0].GetValue<Integer>('reposicaoid').ToString() + ', ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('produtoid').ToString() + ', ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('loteid').ToString() + ', ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('enderecoid').ToString() + ', ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('estoquetipoid').ToString() + ', ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('disponivel').ToString() + ', ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('demanda').ToString());
      FConexao.Query.SQL.Add(')');
      FConexao.Query.SQL.Add('Update PedidoReposicao ' + '    Set Status = 1 Where LoteId = ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('loteid').ToString() + '  And Enderecoid = ' +
                             JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('enderecoid').ToString());
      if DebugHook <> 0 then
         FConexao.Query.SQL.SaveToFile('SalvarReposicaoEndereco.Sql');
      // if JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('qtdrepo') > 0 then
      FConexao.Query.ExecSQL;
    End;
    // Incluir na Reserva quando tipo for por Demanda
    if pJsonReposicao.GetValue<Integer>('reposicaotipo') = 1 then
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update Est');
      FConexao.Query.SQL.Add('   Set Qtde = Est.Qtde + RC.Qtde');
      FConexao.Query.SQL.Add('from ReposicaoEnderecoColeta RC');
      FConexao.Query.SQL.Add('Inner Join Estoque Est On Est.LoteId = RC.LoteId and Est.EnderecoId = RC.EnderecoId and Est.EstoqueTipoId = 6');
      FConexao.Query.SQL.Add('where reposicaoid = ' + Result.Items[0].GetValue<Integer>('reposicaoid').ToString());

      FConexao.Query.SQL.Add('Insert Into Estoque');
      FConexao.Query.SQL.Add('select RC.LoteId, RC.EnderecoId, 6, RC.Qtde, ' + TuEvolutConst.SqlDataAtual + ', ' +
                              TuEvolutConst.SqlHoraAtual + ', ' + pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', Null, Null, Null');
      FConexao.Query.SQL.Add('from ReposicaoEnderecoColeta RC');
      FConexao.Query.SQL.Add('Left Join Estoque Est On Est.LoteId = RC.LoteId and Est.EnderecoId = RC.EnderecoId and Est.EstoqueTipoId = 6');
      FConexao.Query.SQL.Add('where reposicaoid = ' + Result.Items[0].GetValue<Integer>('reposicaoid').ToString() + ' and Est.LoteId Is Null');
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('ReposicaoDemandaReserva.Sql');
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.connection.Commit;
  Except On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Não foi possível Gerar a reposição.' + sLineBreak+E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.ReposicaoSalvarItemColetado(pJsonReposicao: TjSonArray) : TjSonArray;
Var
  vTransaction: Boolean;
  xColeta: Integer;
  vReposicaoId: Integer;
  vEstoqueTipoId: Integer;
  vQtdeReserva: Integer;
begin
  Try
    // vGuuid := TGUID.NewGuid.ToString();
    FConexao.Query.connection.StartTransaction;
    xColeta := 0;
    for xColeta := 0 to Pred(pJsonReposicao.Count) do
    Begin
      // Baixar Estoque
      if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') > 0) and
        (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid') <> '') and
        (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid') <> '0') then
      Begin
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado');
        FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
        FConexao.Query.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
        FConexao.Query.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
        FConexao.Query.ParamByName('pEstoqueTipoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
        FConexao.Query.ParamByName('pQuantidade').Value    := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') * -1);
        FConexao.Query.ParamByName('pUsuarioId').Value     := (pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid'));
        if DebugHook <> 0 then
           FConexao.Query.SQL.SaveToFile('SqlReposicaoBaixarEstoque.Sql');
        if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') > 0) then
           FConexao.Query.ExecSQL;
        // Baixar Reserva
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add('Select Coalesce(Qtde, 0) Qtde From Estoque');
        FConexao.Query.SQL.Add('Where LoteId = ' + pJsonReposicao.Get(xColeta).GetValue<String>('loteid'));
        FConexao.Query.SQL.Add('  And EnderecoId = ' + pJsonReposicao.Get(xColeta).GetValue<String>('enderecoid'));
        FConexao.Query.SQL.Add('  And EstoqueTipoId = 6');
        FConexao.Query.Open;
        vQtdeReserva := FConexao.Query.FieldByName('Qtde').Asinteger;
        if FConexao.Query.FieldByName('Qtde').Asinteger > 0 then Begin
           FConexao.Query.Close;
           FConexao.Query.SQL.Clear;
           FConexao.Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado');
           FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
           FConexao.Query.ParamByName('pLoteId').Value :=
             pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
           FConexao.Query.ParamByName('pEnderecoId').Value :=
             pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
           FConexao.Query.ParamByName('pEstoqueTipoId').Value := 6;
           if vQtdeReserva >= (pJsonReposicao.Get(xColeta)
             .GetValue<Integer>('qtde')) then
             FConexao.Query.ParamByName('pQuantidade').Value :=
               (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') * -1)
           Else
             FConexao.Query.ParamByName('pQuantidade').Value :=
               (vQtdeReserva * -1);
           FConexao.Query.ParamByName('pUsuarioId').Value :=
             pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
           if DebugHook <> 0 then
           Begin
             FConexao.Query.SQL.Add('-- pLoteId = ' + pJsonReposicao.Get(xColeta)
               .GetValue<Integer>('loteid').ToString());
             FConexao.Query.SQL.Add('-- pEnderecoId = ' +
               pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid')
               .ToString());
             FConexao.Query.SQL.Add('-- pQuantidadeId = ' +
               (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') * -1)
               .ToString());
             FConexao.Query.SQL.SaveToFile('SqlReposicaoBaixarReserva.Sql');
          End;
          FConexao.Query.ExecSQL;
        End;
        // Transferir para o Picking
        if pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') > 0 then
        Begin
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add('Select Coalesce(ReposicaoColetaParaPicking, 0) ReposicaoColetaParaPicking From Configuracao');
          FConexao.Query.Open;
          If FConexao.Query.FieldByName('ReposicaoColetaParaPicking').Asinteger = 0 then
             vEstoqueTipoId := 7
          Else
             vEstoqueTipoId := 4; //pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          if vEstoqueTipoId = 7 then Begin
             FConexao.Query.SQL.Add(TuEvolutConst.SqlReposicaoSalvarItemColetado);
             // SqlReposicaoEstoqueTransferencia);
             FConexao.Query.ParamByName('pLoteId').Value :=
               pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
             FConexao.Query.ParamByName('pEnderecoId').Value :=
               pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
             FConexao.Query.ParamByName('pReposicaoId').Value :=
               pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
             FConexao.Query.ParamByName('pEnderecoOrigemId').Value :=
               pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
             FConexao.Query.ParamByName('pEstoqueTipoId').Value :=
               vEstoqueTipoId;
             FConexao.Query.ParamByName('pQuantidade').Value :=
               pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
             FConexao.Query.ParamByName('pUsuarioId').Value :=
               pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
             FConexao.Query.ParamByName('pTerminal').Value :=
               pJsonReposicao.Get(xColeta).GetValue<String>('terminal');
          End
          Else Begin
             FConexao.Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado  EstoqueTipoId <> 7');
             FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
             FConexao.Query.ParamByName('pLoteId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
             FConexao.Query.ParamByName('pEnderecoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
             FConexao.Query.ParamByName('pEstoqueTipoId').Value := vEstoqueTipoId;
             FConexao.Query.ParamByName('pQuantidade').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
             FConexao.Query.ParamByName('pUsuarioId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
          End;
          if DebugHook <> 0 then
             FConexao.Query.SQL.SaveToFile('SqlReposicaoTransfPicking.Sql');
          FConexao.Query.ExecSQL;
        End;
      End;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update ReposicaoEnderecoColeta');
      FConexao.Query.SQL.Add('  Set QtdRepo = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('qtdrepo').ToString());
      FConexao.Query.SQL.Add('    , UsuarioId = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('usuarioid').ToString());
      FConexao.Query.SQL.Add('    , Terminal  = ' +
        QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('terminal')));
      FConexao.Query.SQL.Add('    , DtEntrada = ' +
        QuotedStr(FormatDateTime('YYYY-MM-DD',
        StrToDate(pJsonReposicao.Get(xColeta).GetValue<String>('dtentrada')))));
      FConexao.Query.SQL.Add('    , HrEntrada = ' +
        QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('hrentrada')));
      FConexao.Query.SQL.Add('Where ReposicaoId = ' +
        pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid').ToString);
      FConexao.Query.SQL.Add('  And ProdutoId = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('produtoid').ToString);
      FConexao.Query.SQL.Add('  And Loteid = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('loteid').ToString());
      FConexao.Query.SQL.Add('  And EnderecoId = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('enderecoid').ToString());
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('SqlReposicaoEnderecoColeta.Sql');

      FConexao.Query.ExecSQL;
      vReposicaoId := pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('reposicaoid');
      // Registrar no Kardex

    End;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', '201'));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.PedidoSaida.PedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, RegistroERP, DtInclusao, HrInclusao, ArmazemId) Values ('
        + Self.PedidoSaida.OperacaoTipo.OperacaoTipoId.ToString() + ', ' +
        Self.PedidoSaida.Pessoa.PessoaId.ToString() + ', ' +
        QuotedStr(Self.PedidoSaida.DocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', Self.PedidoSaida.DocumentoData) + #39 +
        '), ' + #39 + Self.PedidoSaida.RegistroERP + #39 + ', ' + SqlDataAtual +
        ', ' + SqlHoraAtual + ', ' +
      // Self.PedidoSaida.ArmazemId.ToString() //
        IfThen(Self.PedidoSaida.ArmazemId = 0, 'Null',
        Self.PedidoSaida.ToString()) + ')'
    Else
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
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;

end;

end.
