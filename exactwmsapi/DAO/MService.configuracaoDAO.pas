{
  Micro Servico - DAO - tipooperacaoDAO
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.configuracaoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, DataSet.Serialize,
  System.JSON, REST.JSON, Math, exactwmsservice.lib.connection,
  exactwmsservice.dao.base, exactwmsservice.lib.utils, IniFiles;

type
  TconfiguracaoDao = class(TBasicDao)
  private

  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pJsonConfiguracao: TJsonObject): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function Backup: TJsonObject;
    Function ManutencaoLog: TJsonObject;
    Function GetVersion: TJsonObject;
    Function UpdateEmpresa(pJsonConfiguracao: TJsonObject): TJsonObject;

  end;

implementation

//uses uSistemaControl;

{ TconfiguracaoDao }

function TconfiguracaoDao.Backup: TJsonObject;
Var
  FDStoredProc1: TFDStoredProc;
  FIndexConneXactWMS: Integer;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  FDStoredProc1 := TFDStoredProc.Create(nil);
  try
    Query.Connection := Connection;
    Try
      FDStoredProc1.connection := Connection;// FConexao.DB;
      FDStoredProc1.StoredProcName := 'Backup_Automatico';
      FDStoredProc1.ExecProc;
      Result := TJsonObject.Create;
      Result := TJsonObject.Create(TJSONPair.Create('Ok',
        'Backup realizado com sucesso!'));
      Query.Sql.Add('Update Configuracao set BackupBd = GetDate()');
      Query.ExecSql;
    Except ON E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  finally
    Query.Free;
    FreeAndNil(FDStoredProc1);
  end;
end;

constructor TconfiguracaoDao.Create;
begin
  inherited;
end;

function TconfiguracaoDao.Delete(pId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    Try
      vSql := 'Delete from configuracao where Id = ' + pId.ToString;
      Query.ExecSql(vSql);
      Result := True;
    Except On E: Exception do
        raise Exception.Create(E.Message);
    end;
  Finally
    Query.Free;
  End;
end;

destructor TconfiguracaoDao.Destroy;
begin
  inherited;
end;

function TconfiguracaoDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select Cfg.*, TEnd.Descricao EnderecoVolumeExpedidoCancelado,'+sLineBreak+
              '       (select Producao From EstoqueTipo Where id = 1) BuscarStage' + sLineBreak +
              'From configuracao Cfg' + sLineBreak;
      vSql := vSql + 'Left Join Enderecamentos TEnd On Tend.EnderecoId = Cfg.EnderecoIdVolumeExpedidoCancelado';
      Query.Open(vSql);
      Result := Query.ToJsonArray;
    Except On E: Exception do
        raise Exception.Create('Processo: '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TconfiguracaoDao.GetVersion: TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('select * from ConfigUpdate');
      Query.Sql.Add('Where Version = (select MAX(Version) from ConfigUpdate)');
      Query.Open;
      if Query.IsEmpty then
      Begin
        Result := TJsonObject.Create;
        Result.AddPair('Erro', 'Sem dados de atualização de versão.');
      End
      Else
        Result := Query.ToJSONObject;
    Except ON E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TconfiguracaoDao.InsertUpdate(pJsonConfiguracao: TJsonObject) : TjSonArray;
var Query : TFdQuery;
    vEnderecoSegregadoId: String;
    vEnderecoIdVolumeExpedidoCancelado: String;
    vEnderecoIdStage, vEnderecoIdStageSNGPC: String;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
      try
        If pJsonConfiguracao.GetValue<Integer>('enderecoSegregadoId') = 0 then
          vEnderecoSegregadoId := 'Null'
        Else
          vEnderecoSegregadoId := pJsonConfiguracao.GetValue<Integer>('enderecoSegregadoId').ToString;
        If pJsonConfiguracao.GetValue<Integer>('enderecoIdVolumeExpedidoCancelado') = 0 then
          vEnderecoIdVolumeExpedidoCancelado := 'Null'
        Else
          vEnderecoIdVolumeExpedidoCancelado := pJsonConfiguracao.GetValue<Integer>('enderecoIdVolumeExpedidoCancelado').ToString;
        If pJsonConfiguracao.GetValue<Integer>('enderecoIdStage') = 0 then
          vEnderecoIdStage := 'Null'
        Else
          vEnderecoIdStage := pJsonConfiguracao.GetValue<Integer>('enderecoIdStage').ToString;
        If pJsonConfiguracao.GetValue<Integer>('enderecoIdStageSngpc') = 0 then
          vEnderecoIdStageSNGPC := 'Null'
        Else
          vEnderecoIdStageSNGPC := pJsonConfiguracao.GetValue<Integer>('enderecoIdStageSngpc').ToString;
        Query.Sql.Add('Update configuracao ' + sLineBreak +
          '   Set CadClienteIncluir = ' + pJsonConfiguracao.GetValue<Integer>('cadClienteIncluir').ToString + sLineBreak +
          '     , CadFornecedorIncluir = ' + pJsonConfiguracao.GetValue<Integer>('cadFornecedorIncluir').ToString + sLineBreak +
          '     , CadProdutoIncluir = ' + pJsonConfiguracao.GetValue<Integer>('cadProdutoIncluir').ToString + sLineBreak +
          '     , CadEntradaIncluir = ' + pJsonConfiguracao.GetValue<Integer>('cadEntradaIncluir').ToString + sLineBreak +
          '     , CadRastroIdProdNovo = ' + pJsonConfiguracao.GetValue<Integer>('cadRastroIdProdNovo').ToString + sLineBreak +
          '     , AutorizarAltLote    = ' + pJsonConfiguracao.GetValue<Integer>('autorizarAltLote').ToString + sLineBreak +
          '     , ShelflifeRecebimento = ' + pJsonConfiguracao.GetValue<Integer>('shelfLifeRecebimento').ToString + sLineBreak +
          '     , ShelflifeExpedicao   = ' + pJsonConfiguracao.GetValue<Integer>('shelfLifeExpedicao').ToString + sLineBreak +
          '     , EntradaBloqueioVencimento = ' +pJsonConfiguracao.GetValue<Integer>('entradaBloqueioVencimento').ToString + sLineBreak +
          '     , SaidaBloqueioVencimento = ' + pJsonConfiguracao.GetValue<Integer>('saidaBloqueioVencimento').ToString + sLineBreak +
          '     , StatusFornecedor = ' + pJsonConfiguracao.GetValue<Integer>('statusFornecedor').ToString + sLineBreak +
          '     , StatusCliente = ' + pJsonConfiguracao.GetValue<Integer>('statusCliente').ToString + sLineBreak +
          '     , TagProdutoEntrada = ' + pJsonConfiguracao.GetValue<Integer>('tagProdutoEntrada').ToString + sLineBreak +
          '     , EnderecarProdutoEntrada = ' + pJsonConfiguracao.GetValue<Integer>('enderecarProdutoEntrada').ToString + sLineBreak +
          '     , EnderecoSegregadoid = ' + vEnderecoSegregadoId + sLineBreak +
          '     , EnderecoIdVolumeExpedidoCancelado = ' + vEnderecoIdVolumeExpedidoCancelado + sLineBreak +
          '     , EnderecoIdStage = ' + vEnderecoIdStage + sLineBreak +
          '     , EnderecoIdStageSNGPC = ' + vEnderecoIdStageSNGPC + sLineBreak +
          '     , BalancaPrecisao  = ' + pJsonConfiguracao.GetValue<Integer>('balancaPrecisao').ToString + sLineBreak +
          '     , EsteiraDesvioRota = ' + pJsonConfiguracao.GetValue<Integer>('esteiraDesvioRota').ToString + sLineBreak +
          '     , EsteiraDesvioAuditoria = ' + pJsonConfiguracao.GetValue<Integer>('esteiraDesvioAuditoria').ToString + sLineBreak +
          '     , EsteiraTipoDesvioAuditoria = ' + pJsonConfiguracao.GetValue<Integer>('esteiraTipoDesvioAuditoria').ToString + sLineBreak +
          '     , PickingByLight = ' + pJsonConfiguracao.GetValue<Integer>('pickingByLight').ToString + sLineBreak +
          '     , PickginByLightModelo = ' + pJsonConfiguracao.GetValue<Integer>('pickingByLightModelo').ToString() + sLineBreak +
          '     , PickingByVoice = ' + pJsonConfiguracao.GetValue<Integer>('pickingByVoice').ToString + sLineBreak +
          '     , PickginByVoiceModelo = ' + pJsonConfiguracao.GetValue<Integer>('pickingByVoiceModelo').ToString() + sLineBreak +
          '     , CheckInItem = ' + pJsonConfiguracao.GetValue<Integer>('checkInItem').ToString + sLineBreak +
          '     , ModeloPrinterCodBarra = ' + QuotedStr(pJsonConfiguracao.GetValue<String>('modeloPrinterCodBarra')) + sLineBreak +
          '     , PortaPrinterCodBarra = ' + QuotedStr(pJsonConfiguracao.GetValue<String>('portaPrinterCodBarra')) + sLineBreak +
          '     , ModeloPrinterGerencial = ' + QuotedStr(pJsonConfiguracao.GetValue<String>('modeloPrinterGerencial')) + sLineBreak +
          '     , PortaPrinterGerencial     = ' + QuotedStr(pJsonConfiguracao.GetValue<String>('portaPrinterGerencial')) + sLineBreak +
          '     , MesesParaPreVencido       = ' + pJsonConfiguracao.GetValue<Integer>('mesesParaPreVencido').ToString +
          '     , MudarPickingEstoquePallet = ' + pJsonConfiguracao.GetValue<Integer>('mudarPickingEstoquePallet').ToString +sLineBreak +
          '     , RegApanhe = ' + pJsonConfiguracao.GetValue<Integer>('regApanhe').ToString + sLineBreak +
          '     , LoteApanhe          = ' + pJsonConfiguracao.GetValue<Integer>('loteApanhe').ToString + sLineBreak +
          // Definir se parametro geral ou vinculado a Zona do Endereço como na reposição
          '     , SeparacaoCodInterno = ' + pJsonConfiguracao.GetValue<Integer>('separacaoCodInterno').ToString + sLineBreak +
          '     , ApanheConsolidado = ' + pJsonConfiguracao.GetValue<Integer>('apanheConsolidado').ToString + sLineBreak +
          '     , ModeloEtqVolume = ' + pJsonConfiguracao.GetValue<Integer>('modeloEtqVolume').ToString + sLineBreak +
          '     , PrinterEtqVolumeExtraAuto = ' + pJsonConfiguracao.GetValue<Integer>('printerEtqVolumeExtraAuto').ToString + sLineBreak +
          '     , BeepProdIndividual =  ' + pJsonConfiguracao.GetValue<Integer>('beepProdIndividual').ToString + sLineBreak +
          '     , BeepIndividualLimiteUnid       = ' + pJsonConfiguracao.GetValue<Integer>('beepIndividualLimiteUnid').ToString + sLineBreak +
          '     , LacreSeguranca                 = ' + pJsonConfiguracao.GetValue<Integer>('lacreSeguranca').ToString + sLineBreak +
          '     , IdentCaixaApanhe               = ' + pJsonConfiguracao.GetValue<Integer>('identCaixaApanhe').ToString + sLineBreak +
          '     , OmitirUnidEtqVolume            = ' + pJsonConfiguracao.GetValue<Integer>('omitirUnidEtqVolume').ToString + sLineBreak +
          '     , ReconferirCorteReconferencia         = ' + pJsonConfiguracao.GetValue<Integer>('reconferirCorteReconferencia').ToString + sLineBreak +
          '     , ExigirReconferenciaToExpedicao = ' +pJsonConfiguracao.GetValue<Integer>('exigirReconferenciaToExpedicao').ToString + sLineBreak +
          '     , VolumeAuditoria                = '+pJsonConfiguracao.GetValue<Integer>('volumeAuditoria').ToString + sLineBreak +
          '     , CorteSupervisionado       = ' +pJsonConfiguracao.GetValue<Integer>('corteSupervisionado').ToString + sLineBreak +
          '     , CargaEmTransito           = ' +pJsonConfiguracao.GetValue<Integer>('cargaEmTransito').ToString + sLineBreak +
          '     , VolCxaFechadaExpedicao    = ' + pJsonConfiguracao.GetValue<Integer>('volCxaFechadaExpedicao').ToString + sLineBreak +
          '     , VolCxaFracionadaExpedicao = ' + pJsonConfiguracao.GetValue<Integer>('volCxaFracionadaExpedicao').ToString + sLineBreak +
          '     , InventarioForcarMaxContagem    = ' + pJsonConfiguracao.GetValue<Integer>('inventarioForcarMaxContagem').ToString + sLineBreak +
          '     , InventarioDivergenciaSegregado = ' + pJsonConfiguracao.GetValue<Integer>('inventarioDivergenciaSegregado').ToString +
          '     , IntegrarAjusteERP              = ' + pJsonConfiguracao.GetValue<Integer>('integrarAjusteERP').ToString +
          '     , InventarioAjustePadrao         = ' + pJsonConfiguracao.GetValue<Integer>('inventarioAjustePadrao').ToString +
          '     , TagVolumeOrdem                 = ' + pJsonConfiguracao.GetValue<Integer>('tagVolumeOrdem').ToString +
          '     , ReCheckOutUsuario              = ' + pJsonConfiguracao.GetValue<Integer>('reCheckOutUsuario').ToString +
          '     , ReposicaoColetor               = ' + pJsonConfiguracao.GetValue<Integer>('reposicaoColetor').ToString +
          '     , ReposicaoAutomatica            = ' + pJsonConfiguracao.GetValue<Integer>('reposicaoAutomatica').ToString +
          '     , ReposicaoColetaParaPicking     = ' + pJsonConfiguracao.GetValue<Integer>('reposicaoColetaParaPicking').ToString +
          '     , AtivarBackup                   = ' +  pJsonConfiguracao.GetValue<Integer>('ativarBackup').ToString +
          '     , URLUpdateApk = ' + QuotedStr(pJsonConfiguracao.GetValue<String>('urlUpdateAPK')));
          //Produtividade
          Query.Sql.Add('     , ArmazenagemMeta               = ' + pJsonConfiguracao.GetValue<Integer>('armazenagemMeta').Tostring);
          Query.Sql.Add('     , ArmazenagemTolerancia         = ' + pJsonConfiguracao.GetValue<Integer>('armazenagemTolerancia').Tostring);
          Query.Sql.Add('     , SeparacaoFracionadoMeta       = ' + pJsonConfiguracao.GetValue<Integer>('separacaoFracionadoMeta').Tostring);
          Query.Sql.Add('     , SeparacaoFracionadoTolerancia = ' + pJsonConfiguracao.GetValue<Integer>('separacaoFracionadoTolerancia').ToString);
          Query.Sql.Add('     , CheckoutFracionadoMeta        = ' + pJsonConfiguracao.GetValue<Integer>('checkoutFracionadoMeta').ToString);
          Query.Sql.Add('     , CheckoutFracionadoTolerancia  = ' + pJsonConfiguracao.GetValue<Integer>('checkoutFracionadoTolerancia').ToString);
          Query.Sql.Add('     , CheckoutCxaFechadaMeta        = ' + pJsonConfiguracao.GetValue<Integer>('checkoutCxaFechadaMeta').ToString);
          Query.Sql.Add('     , CheckoutCxaFechadaTolerancia  = ' + pJsonConfiguracao.GetValue<Integer>('checkoutCxaFechadaTolerancia').ToString);
          Query.Sql.Add('     , ExpedicaoMeta                 = ' + pJsonConfiguracao.GetValue<Integer>('expedicaoMeta').ToString);
          Query.Sql.Add('     , ExpedicaoTolerancia           = ' + pJsonConfiguracao.GetValue<Integer>('expedicaoTolerancia').ToString);
          Query.Sql.Add('     , ReposicaoColetaMeta           = ' + pJsonConfiguracao.GetValue<Integer>('reposicaoColetaMeta').ToString);
          Query.Sql.Add('     , ReposicaoColetaTolerancia     = ' + pJsonConfiguracao.GetValue<Integer>('reposicaoColetaTolerancia').ToString);
          Query.Sql.Add('     , CheckInMeta                   = ' + pJsonConfiguracao.GetValue<Integer>('checkInMeta').ToString);
          Query.Sql.Add('     , CheckInTolerancia             = ' + pJsonConfiguracao.GetValue<Integer>('checkInTolerancia').ToString);
          Query.Sql.Add('');
          Query.Sql.Add('Update EstoqueTipo Set Producao = '+pJsonConfiguracao.GetValue<Integer>('buscarStage').ToString+' Where Id = 1');
        If DebugHook <> 0 then
          Query.Sql.SaveToFile('UpdConfiguracao.Sql');
        Query.ExecSql;
        Result := Query.ToJsonArray;
      Except ON E: Exception do
        Begin
          raise Exception.Create(E.Message);
        End;
      end;
  Finally
    Query.Free;
  End;
end;

function TconfiguracaoDao.ManutencaoLog: TJsonObject;
var Query : TFdQuery;
    I, j: Integer;
    SearchRec: TSearchRec;
    PathFile: String;
    nameFile: string;
    vDataFile: TDateTime;
    BancoDados : String;
    ArqIni : TIniFile;
begin
  if GetEnvironmentVariable('RHEMA_DB_HOST') <> '' then
     BancoDados := GetEnvironmentVariable('RHEMA_DB_DATABASE')
  Else Begin
     ArqIni     := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini');
     BancoDados := ArqIni.ReadString('BD', 'DataBase', 'eXactWMS');
     if assigned(ArqIni) then
        FreeAndNil(ArqIni);
  End;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    PathFile := ExtractFileDir(GetModuleName(HInstance)) + PathDelim + 'Log' + PathDelim;
    try
      I := FindFirst(PathFile + '*.Log', 0, SearchRec);
      while I = 0 do begin
        nameFile := SearchRec.Name;
        vDataFile := SearchRec.TimeStamp;
        // vDataFile := SearchRec.FindData.ftLastWriteTime);
        // if FileTimeToDTime(SearchRec.FindData.ftLastWriteTime) < Date() - 10 then
        if vDataFile < (Date() - 10) then Begin
           DeleteFile(pWideChar(PathFile + SearchRec.Name));
        End;
        I := FindNext(SearchRec);
      end;
      Query.Sql.Add('deleteMore:');
      Query.Sql.Add('DELETE TOP(2000)  FROM RequestResponse WHERE data <= GetDate()-15');
      Query.Sql.Add('IF EXISTS(SELECT top 1 ' + #39 + 'x' + #39 + ' FROM RequestResponse WHERE data <= GetDate()-15  )');
      Query.Sql.Add('    goto deleteMore');
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('ManutencaoLog.Sql');
      Query.ExecSql;
      Result := TJsonObject.Create.AddPair('Ok', 'Log(s) apagado(s).');

//expurgo de dados - JsonIntegracao
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('BACKUP LOG '+BancoDados+' TO DISK = '+#39+'NUL'+#39);
      Query.Sql.Add('declare @id Integer = 0 ');
      Query.Sql.Add('set  @id =  (Select Max(Id) From JsonIntegracao)-2000');
      Query.Sql.Add('');
      Query.Sql.Add('-- contador de execuções');
      Query.Sql.Add('declare @contador int');
      Query.Sql.Add('set @contador = 0');
      Query.Sql.Add('');
      Query.Sql.Add('-- laço com a ação desejada');
      Query.Sql.Add('deleteMore:');
      Query.Sql.Add('Begin');
      Query.Sql.Add('  DELETE TOP(10000) FROM JsonIntegracao WHERE Id < @id');
      Query.Sql.Add('  CHECKPOINT;  -- Força a gravação dos dados em disco para evitar inchaço do log');
      Query.Sql.Add('  WAITFOR DELAY '+#39+'00:00:01'+#39+'; -- Pequena pausa para evitar travamentos');
      Query.Sql.Add('  set @contador = @contador + 1');
      Query.Sql.Add('  --print '+#39+'rodada '+#39+' + cast(@contador as varchar(10)) + '+#39+'- 10000 registros excluídos'+#39);
      Query.Sql.Add('End');
      Query.Sql.Add('');
      Query.Sql.Add('IF EXISTS(SELECT top 1 '+#39+'x'+#39+' FROM JsonIntegracao WHERE Id < @id )');
      Query.Sql.Add('    goto deleteMore');
      Query.ExecSql;
    except On E: Exception Do
      Begin
        raise Exception.Create('Log - '+E.Message);
      End;
    end;
  finally
    Query.Free;
  end;
end;

function TconfiguracaoDao.UpdateEmpresa(pJsonConfiguracao: TJsonObject): TJsonObject;
Var vErro : String;
begin
  If Not pJsonConfiguracao.TryGetValue('empresa', vErro) then
     Raise Exception.Create('Informe a empresa!');
  If Not pJsonConfiguracao.TryGetValue('cripto', vErro) then
     Raise Exception.Create('Informe o tipo de operação!');
  Result := TJsonObject.Create;
  if pJsonConfiguracao.GetValue<integer>('cripto') = 0 then
     Result.AddPair('criptografado', TUtil.CripDescripText(pJsonConfiguracao.GetValue<string>('empresa'), 'Rhemasys Soluções', True ))
  Else
     Result.AddPair('criptografado', TUtil.CripDescripText(pJsonConfiguracao.GetValue<string>('empresa'), 'Rhemasys Soluções', False ));
end;

end.
