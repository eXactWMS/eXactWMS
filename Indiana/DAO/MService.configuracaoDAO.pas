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
  exactwmsservice.dao.base;

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
  end;

implementation

uses uSistemaControl;

{ TconfiguracaoDao }

function TconfiguracaoDao.Backup: TJsonObject;
Var
  FDStoredProc1: TFDStoredProc;
  FIndexConneXactWMS: Integer;
begin
  FDStoredProc1 := TFDStoredProc.Create(nil);
  try
    Try
      FDStoredProc1.connection := FConexao.DB;
      FDStoredProc1.StoredProcName := 'Backup_Automatico';
      FDStoredProc1.ExecProc;
      Result := TJsonObject.Create;
      Result := TJsonObject.Create(TJSONPair.Create('Ok',
        'Backup realizado com sucesso!'));
      FConexao.Query.Sql.Add('Update Configuracao set BackupBd = GetDate()');
      FConexao.Query.ExecSql;
    Except
      ON E: Exception do
      Begin
        FDStoredProc1.Free;
        raise Exception.Create(E.Message);
      End;
    end;
  finally
    FreeAndNil(FDStoredProc1);
  end;
end;

constructor TconfiguracaoDao.Create;
begin
  inherited;
end;

function TconfiguracaoDao.Delete(pId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  Try
    vSql := 'Delete from configuracao where Id = ' + pId.ToString;
    FConexao.Query.ExecSql(vSql);
    Result := True;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TconfiguracaoDao.Destroy;
begin
  inherited;
end;

function TconfiguracaoDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'select Cfg.*, TEnd.Descricao EnderecoVolumeExpedidoCancelado, (select Producao From EstoqueTipo Where id = 1) BuscarStage' +
      sLineBreak + 'From configuracao Cfg' + sLineBreak;
    vSql := vSql +
      'Left Join Enderecamentos TEnd On Tend.EnderecoId = Cfg.EnderecoIdVolumeExpedidoCancelado';
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.ToJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TconfiguracaoDao.GetVersion: TJsonObject;
begin
  Try
    FConexao.Query.connection := FConexao.DB;
    FConexao.Query.Sql.Add('select * from ConfigUpdate');
    FConexao.Query.Sql.Add
      ('Where Version = (select MAX(Version) from ConfigUpdate)');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('Erro', 'Sem dados de atualização de versão.');
    End
    Else
      Result := FConexao.Query.ToJSONObject;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TconfiguracaoDao.InsertUpdate(pJsonConfiguracao: TJsonObject)
  : TjSonArray;
var
  vEnderecoSegregadoId: String;
  vEnderecoIdVolumeExpedidoCancelado: String;
  vEnderecoIdStage, vEnderecoIdStageSNGPC: String;
begin
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
    FConexao.Query.Sql.Add('Update configuracao ' + sLineBreak +
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
      FConexao.Query.Sql.Add('');
      FConexao.Query.Sql.Add('Update EstoqueTipo Set Producao = '+pJsonConfiguracao.GetValue<Integer>('buscarStage').ToString+' Where Id = 1');


    // if StrToDate(pJsonConfiguracao.GetValue<String>('backupBd')) = 0 then
    // vQry.SQL.Add('     , BackupBd = Null')
    // Else vQry.SQL.Add('     , BackupBd = '+#39+FormatDateTime('YYYY-MM-DD', StrToDate(pJsonConfiguracao.GetValue<String>('backupBd')))+#39);
    If DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('UpdConfiguracao.Sql');
    FConexao.Query.ExecSql;
    Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TconfiguracaoDao.ManutencaoLog: TJsonObject;
var
  I, j: Integer;
  SearchRec: TSearchRec;
  PathFile: String;
  nameFile: string;
  vDataFile: TDateTime;
  FconexaoLog: TConnection;
begin
  // Result := TJsonObject.Create.AddPair('Ok', 'Log(s) apagado(s).');
  // exit;

  FconexaoLog := TConnection.Create(1);
  FConexao.Sender:=Self;
  try
    PathFile := ExtractFileDir(GetModuleName(HInstance)) + PathDelim + 'Log' +
      PathDelim;
    try
      I := FindFirst(PathFile + '*.Log', 0, SearchRec);
      while I = 0 do
      begin
        nameFile := SearchRec.Name;
        vDataFile := SearchRec.TimeStamp;
        // vDataFile := SearchRec.FindData.ftLastWriteTime);
        // if FileTimeToDTime(SearchRec.FindData.ftLastWriteTime) < Date() - 10 then
        if vDataFile < (Date() - 10) then
        Begin
          DeleteFile(pWideChar(PathFile + SearchRec.Name));
        End;
        I := FindNext(SearchRec);
      end;
      FconexaoLog.Query.Sql.Add('deleteMore:');
      FconexaoLog.Query.Sql.Add
        ('DELETE TOP(2000)  FROM RequestResponse WHERE data <= GetDate()-15');
      FconexaoLog.Query.Sql.Add('IF EXISTS(SELECT top 1 ' + #39 + 'x' + #39 +
        ' FROM RequestResponse WHERE data <= GetDate()-30  )');
      FconexaoLog.Query.Sql.Add('    goto deleteMore');
      FconexaoLog.Query.ExecSql;
      Result := TJsonObject.Create.AddPair('Ok', 'Log(s) apagado(s).');

    except
      On E: Exception Do
      Begin

        raise Exception.Create(E.Message);
      End;
    end;
  finally
    FreeAndNil(FconexaoLog);
  end;
end;

end.
