unit MService.PedidoVolumeSeparacaoDAO;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  PedidoVolumeSeparacaoClass, Web.HTTPApp, exactwmsservice.lib.utils,
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

type

  TPedidoVolumeSeparacaoDao = class(TBasicDao)
  private
    //
    
    FVolumeSeparacao: TVolumeSeparacao;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
    Function CheckFinalizacaoCheckInPedido(pPedidoVolumeId: Integer): Integer;
    Procedure AlterarStatusVolume(pPedidoVolumeId: Integer; pNewStatus: Integer;
      pUsuarioId: Integer; pTerminal: String);
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pEstacao: String; pConsolidado: Integer): Integer;
    Function SaveSeparacao(JsonSeparacao: tjsonObject): Boolean;
    function GetId(pCaixaEmbalagemId: Integer; pPedidoVolumeId: Integer;
      pOperacao: Integer): TjSonArray;
    Function GetResumoSeparacao(aParams: TDictionary<String, String>)
      : TjSonArray;
    Function GetDshSeparacao(aParams: TDictionary<String, String>): TjSonArray;
    Function GetDesempenhoExpedicao(aParams: TDictionary<String, String>)
      : TjSonArray;
    Function Delete: Boolean;
   
    Property ObjVolumeSeparacao: TVolumeSeparacao Read FVolumeSeparacao
      Write FVolumeSeparacao;
  end;

implementation

uses uSistemaControl, Constants, MService.PedidoVolumeDAO, System.SysUtils;

{ TClienteDao }

procedure TPedidoVolumeSeparacaoDao.AlterarStatusVolume(pPedidoVolumeId
  : Integer; pNewStatus: Integer; pUsuarioId: Integer; pTerminal: String);
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Add(TuEvolutConst.AtualizaStatusPedido);
    FConexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
    FConexao.Query.ExecSql;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TPedidoVolumeSeparacaoDao.CheckFinalizacaoCheckInPedido(pPedidoVolumeId
  : Integer): Integer;
begin
  FConexao.Query.SQL.Add
    ('Declare @PedidoId Integer = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = '
    + pPedidoVolumeId.ToString + ')');
  FConexao.Query.SQL.Add('Select Min(ProcessoId) As PedidoVolumeStatus');
  FConexao.Query.SQL.Add('From');
  FConexao.Query.SQL.Add('(select De.Documento, Max(De.ProcessoId) Processoid');
  FConexao.Query.SQL.Add('from DocumentoEtapas De');
  FConexao.Query.SQL.Add('Inner join PedidoVolumes PV On PV.Uuid = De.Documento');
  FConexao.Query.SQL.Add
    ('where Pv.PedidoId = @PedidoId and De.Status = 1 and De.Status <> 6');
  FConexao.Query.SQL.Add('Group By De.Documento) as DoctoEt');
  FConexao.Query.Open;
  Result := FConexao.Query.FieldByName('PedidoVolumeStatus').AsInteger;
end;

constructor TPedidoVolumeSeparacaoDao.Create;
begin
  ObjVolumeSeparacao := TVolumeSeparacao.Create;
  inherited;
end;

function TPedidoVolumeSeparacaoDao.Delete: Boolean;
begin
  Result := False;
  try
    FConexao.Query.ExecSql('Delete from PedidoVolumeSeparacao where VolumeSeparacaoId = ' +
                           Self.ObjVolumeSeparacao.VolumeSeparacaoId.ToString);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeSeparacao - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPedidoVolumeSeparacaoDao.Destroy;
begin
  ObjVolumeSeparacao.free;
  
  inherited;
end;

function TPedidoVolumeSeparacaoDao.GetId(pCaixaEmbalagemId: Integer;
  pPedidoVolumeId: Integer; pOperacao: Integer): TjSonArray;
var
  PedidoVolumeSeparacaoItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoVolumeCheckIn);
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value := pCaixaEmbalagemId;
    FConexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    FConexao.Query.ParamByName('pOperacao').Value := pOperacao;
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
      Result.AddElement(tjsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      while Not FConexao.Query.Eof do
        With ObjVolumeSeparacao do
        Begin
          VolumeSeparacaoId := FConexao.Query.FieldByName('VolumeSeparacaoId').AsInteger;
          CaixaEmbalagemId := FConexao.Query.FieldByName('CaixaEmbalagemId').AsInteger;
          Operacao := FConexao.Query.FieldByName('Operacao').AsInteger;
          // 0-Aberto   1-Finalizado
          PedidoVolumeId := FConexao.Query.FieldByName('PedidoVolumeId').AsInteger;
          EnderecoId := FConexao.Query.FieldByName('EnderecoId').AsInteger;
          UsuarioId := FConexao.Query.FieldByName('UsuarioId').AsInteger;
          DtInicio := FConexao.Query.FieldByName('DtInicio').AsInteger;
          HrInicio := FConexao.Query.FieldByName('HrInicio').AsInteger;
          DtFinalizacao := FConexao.Query.FieldByName('DtFinalizacao').AsInteger;
          HrFinalizacao := FConexao.Query.FieldByName('HrFinalizacao').AsInteger;
          Divergencia := FConexao.Query.FieldByName('Divergencia').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjVolumeSeparacao,
            [joDateFormatISO8601]));
          FConexao.Query.Next;
        End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoVolumeSeparacao(Caixas) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoVolumeSeparacaoDao.GetDesempenhoExpedicao(aParams: TDictionary<String, String>): TjSonArray;
var vParamOk: Integer;
    vData: TDateTime;
begin
  vParamOk := 0;
  FConexao.Query.SQL.Add(TuEvolutConst.GetDesempenhoExpedicao);
  if aParams.ContainsKey('datainicialpedido') then begin
     Try
       if StrToDate(aParams.Items['datainicialpedido']) <> 0 then
          FConexao.Query.ParamByName('pDataPedidoInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datainicialpedido']))
       Else
          FConexao.Query.ParamByName('pDataPedidoInicial').Value := 0;
       Inc(vParamOk);
     Except
     End;
  end
  Else
     FConexao.Query.ParamByName('pDataPedidoInicial').Value := 0;
  if aParams.ContainsKey('datafinalpedido') then begin
     Try
       if StrToDate(aParams.Items['datafinalpedido']) <> 0 then
          FConexao.Query.ParamByName('pDataPedidoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datafinalpedido']))
       Else
          FConexao.Query.ParamByName('pDataPedidoFinal').Value := 0;
       Inc(vParamOk);
     Except
     End;
  end
  Else
    FConexao.Query.ParamByName('pDataPedidoFinal').Value := 0;
  if aParams.ContainsKey('datainicialproducao') then begin
    Try
      if StrToDate(aParams.Items['datainicialproducao']) <> 0 then
         FConexao.Query.ParamByName('pDataProducaoInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datainicialproducao']))
      Else
         FConexao.Query.ParamByName('pDataProducaoInicial').Value := 0;
      Inc(vParamOk);
    Except
    End;
  end
  Else
     FConexao.Query.ParamByName('pDataProducaoInicial').Value := 0;;
  if aParams.ContainsKey('datafinalproducao') then begin
    Try
      if StrToDate(aParams.Items['datafinalproducao']) <> 0 then
         FConexao.Query.ParamByName('pDataProducaoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datafinalproducao']))
      Else
         FConexao.Query.ParamByName('pDataProducaoFinal').Value := 0;
      Inc(vParamOk);
    Except
    End;
  end
  Else
     FConexao.Query.ParamByName('pDataProducaoFinal').Value := 0;;
  if aParams.ContainsKey('usuarioid') then Begin
     FConexao.Query.ParamByName('pUsuarioId').Value := aParams.Items['usuarioid'];
     Inc(vParamOk);
  end
  Else
     FConexao.Query.ParamByName('pUsuarioId').Value := 0;
  if aParams.ContainsKey('analise') then Begin
     FConexao.Query.ParamByName('pAnalise').Value := aParams.Items['analise'];
     Inc(vParamOk);
  end
  Else
     FConexao.Query.ParamByName('pAnalise').Value := 1;
  if aParams.ContainsKey('embalagemid') then Begin // embalagemid
     FConexao.Query.ParamByName('pEmbalagemId').Value := aParams.Items['embalagemid'];
     Inc(vParamOk);
  end
  Else
     FConexao.Query.ParamByName('pEmbalagemId').Value := 99;
  if vParamOk <> aParams.Count then begin
     Result := TJsonArray.Create;
     Result.AddElement(tjsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'));
  end
  Else
  begin
    If DebugHook <> 0 Then Begin
       FConexao.Query.SQL.Add('-- pDataPedidoInicial = ' + FConexao.Query.ParamByName('pDataPedidoInicial').AsString);
       FConexao.Query.SQL.Add('-- pDataPedidoFinal = ' + FConexao.Query.ParamByName('pDataPedidoFinal').AsString);
       FConexao.Query.SQL.Add('-- pDataProducaoInicial = ' +FConexao.Query.ParamByName('pDataProducaoInicial').AsString);
       FConexao.Query.SQL.Add('-- pDataProducaoFinal = ' + FConexao.Query.ParamByName('pDataProducaoFinal').AsString);
       FConexao.Query.SQL.Add('-- pUsuarioId = ' + FConexao.Query.ParamByName('pUsuarioId').AsString);
       FConexao.Query.SQL.Add('-- pAnalise = ' + FConexao.Query.ParamByName('pAnalise').AsString);
       FConexao.Query.SQL.Add('-- pEmbalagemId = ' + FConexao.Query.ParamByName('pEmbalagemId').AsString);
       If DebugHook <> 0 Then
          FConexao.Query.SQL.SaveToFile('DesepenhoExpedicao.Sql');
    End;
    FConexao.Query.Open();
    if FConexao.Query.Isempty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(tjsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
    Begin
      // TDataSetSerializeConfig.GetInstance.DateInputIsUTC    := False;
      // TDataSetSerializeConfig.GetInstance.DateTimeIsISO8601 := True;
      TDataSetSerializeConfig.GetInstance.Export.FormatDateTime := 'yyyy-mm-dd hh:nn:ss.zzz';
      Result := FConexao.Query.ToJSONArray;
    End;
  end;
end;

function TPedidoVolumeSeparacaoDao.GetDshSeparacao(aParams: TDictionary<String, String>): TjSonArray;
var vParamOk: Integer;
    vDataPedido, vDataProducao: TDateTime;
begin
  Try
    vParamOk := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDSHSeparacao);
    if aParams.ContainsKey('usuarioid') then Begin
       FConexao.Query.ParamByName('pUsuarioId').Value := aParams.Items['usuarioid'];
       Inc(vParamOk);
    end
    Else
       FConexao.Query.ParamByName('pUsuarioId').Value := 0;
    if aParams.ContainsKey('datapedidoinicial') then begin
      Try
        vDataPedido := StrToDate(aParams.Items['datapedidoinicial']);
        if vDataPedido <> 0 then
           FConexao.Query.ParamByName('pdatapedidoinicial').Value := FormatDateTime('YYYY-MM-DD',
                                                                     StrToDate(aParams.Items['datapedidoinicial']));
        Inc(vParamOk);
      Except
      End;
    end
    Else
      FConexao.Query.ParamByName('pdatapedidoinicial').Value := 0;
    if aParams.ContainsKey('datapedidofinal') then
    begin
      Try
        vDataPedido := StrToDate(aParams.Items['datapedidofinal']);
        if vDataPedido <> 0 then
        Begin
          FConexao.Query.ParamByName('pdatapedidofinal').Value := FormatDateTime('YYYY-MM-DD',
                                                                  StrToDate(aParams.Items['datapedidofinal']));
        End;
        Inc(vParamOk);
      Except
      End;
    end
    Else
      FConexao.Query.ParamByName('pdatapedidofinal').Value := 0;
    if aParams.ContainsKey('dataproducaoinicial') then begin
      Try
        vDataProducao := StrToDate(aParams.Items['dataproducaoinicial']);
        if vDataProducao <> 0 then
        Begin
          FConexao.Query.ParamByName('pdataproducaoinicial').Value := FormatDateTime('YYYY-MM-DD',
                                                                      StrToDate(aParams.Items['dataproducaoinicial']));
        End;
        Inc(vParamOk);
      Except
      End;
    end
    Else
      FConexao.Query.ParamByName('pdataproducaoinicial').Value := 0;
    if aParams.ContainsKey('dataproducaofinal') then
    begin
      Try
        vDataProducao := StrToDate(aParams.Items['dataproducaofinal']);
        if vDataProducao <> 0 then
        Begin
          FConexao.Query.ParamByName('pdataproducaofinal').Value := FormatDateTime('YYYY-MM-DD',
                                                                    StrToDate(aParams.Items['dataproducaofinal']));
        End;
        Inc(vParamOk);
      Except
      End;
    end
    Else
       FConexao.Query.ParamByName('pdataproducaofinal').Value := 0;
    if aParams.ContainsKey('zonaid') then begin
       if StrToIntDef(aParams.Items['zonaid'], 0) > 0 then Begin
          FConexao.Query.ParamByName('pZonaId').Value := aParams.Items['zonaid'];
       End;
       Inc(vParamOk);
    end
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    if vParamOk <> aParams.Count then Begin
       Result := TjSonArray.Create;
       Result.AddElement(tjsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'))
    End
    Else
    begin
      If DebugHook <> 0 Then
         FConexao.Query.SQL.SaveToFile('DSHSeparacao.Sql');
      FConexao.Query.Open();
      if FConexao.Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(tjsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := FConexao.Query.ToJSONArray;
    end;
  Except On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeSeparacaoDao.GetResumoSeparacao
  (aParams: TDictionary<String, String>): TjSonArray;
var
  vParamOk: Integer;
  vDataPedido, vDataProducao: TDateTime;
begin
  Try
    FConexao.Query.SQL.Add
      ('Select *, (select SeparacaoFracionadoMeta From Configuracao) Meta,');
    FConexao.Query.SQL.Add
      ('       (Select SeparacaoFracionadoTolerancia From Configuracao) Tolerancia');
    FConexao.Query.SQL.Add('From vResumoSeparacao Where 1 = 1');
    if aParams.ContainsKey('usuarioid') then
    Begin
      FConexao.Query.SQL.Add('and UsuarioId = :pUsuarioId');
      FConexao.Query.ParamByName('pUsuarioId').Value :=
        aParams.Items['usuarioid'];
      Inc(vParamOk);
    end;
    if aParams.ContainsKey('datainicialpedido') then
    begin
      Try
        vDataPedido := StrToDate(aParams.Items['datainicialpedido']);
        if vDataPedido <> 0 then
        Begin
          FConexao.Query.SQL.Add('and Data >= :pDataInicialPedido');
          FConexao.Query.ParamByName('pDataInicialPedido').Value :=
            FormatDateTime('YYYY-MM-DD',
            StrToDate(aParams.Items['datainicialpedido']));
        End;
        Inc(vParamOk);
      Except
      End;
    end;
    if aParams.ContainsKey('datafinalpedido') then
    begin
      Try
        vDataPedido := StrToDate(aParams.Items['datafinalpedido']);
        if vDataPedido <> 0 then
        Begin
          FConexao.Query.SQL.Add('and Data <= :pDataFinalPedido');
          FConexao.Query.ParamByName('pDataFinalPedido').Value :=
            FormatDateTime('YYYY-MM-DD',
            StrToDate(aParams.Items['datafinalpedido']));
        End;
        Inc(vParamOk);
      Except
      End;
    end;

    if aParams.ContainsKey('datainicialproducao') then
    begin
      Try
        vDataProducao := StrToDate(aParams.Items['datainicialproducao']);
        if vDataProducao <> 0 then
        Begin
          FConexao.Query.SQL.Add('and Dataproducao >= :pDataInicialproducao');
          FConexao.Query.ParamByName('pDataInicialproducao').Value :=
            FormatDateTime('YYYY-MM-DD',
            StrToDate(aParams.Items['datainicialproducao']));
        End;
        Inc(vParamOk);
      Except
      End;
    end;
    if aParams.ContainsKey('datafinalproducao') then
    begin
      Try
        vDataProducao := StrToDate(aParams.Items['datafinalproducao']);
        if vDataProducao <> 0 then
        Begin
          FConexao.Query.SQL.Add('and Dataproducao <= :pDataFinalproducao');
          FConexao.Query.ParamByName('pDataFinalproducao').Value :=
            FormatDateTime('YYYY-MM-DD',
            StrToDate(aParams.Items['datafinalproducao']));
        End;
        Inc(vParamOk);
      Except
      End;
    end;

    if aParams.ContainsKey('processoid') then
    begin
      if StrToIntDef(aParams.Items['processoid'], 0) > 0 then
      Begin
        FConexao.Query.SQL.Add('and ProcessoEtapaId = :pProcessoId');
        FConexao.Query.ParamByName('pProcessoId').Value :=
          aParams.Items['processoid'];
      End;
      Inc(vParamOk);
    end;
    if vParamOk <> aParams.Count then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(tjsonObject.Create.AddPair('Erro',
        'Parâmetros incorretos na requisição!'))
    End
    Else
    begin
      // qryPesquisa.SQL.Add('order by InventarioId');
      FConexao.Query.SQL.Add('Order by nome, data --Pedido, dataProducao');
      If DebugHook <> 0 Then
        FConexao.Query.SQL.SaveToFile('ResumoSeparacao.Sql');
      FConexao.Query.Open();
      if FConexao.Query.Isempty then
      Begin
        Result := TjSonArray.Create();
        Result.AddElement(tjsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados));
      End
      Else
        Result := FConexao.Query.ToJSONArray;
    end;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TPedidoVolumeSeparacaoDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TPedidoVolumeSeparacaoDao.Salvar(pEstacao: String;
  pConsolidado: Integer): Integer; // Finalizar a Separacao
var
  vSql: String;
  ObjPedidoVolumeDAO: TPedidoVolumeDAO;
  JsonRegVolume: tjsonObject;
begin
  try
    if Self.ObjVolumeSeparacao.VolumeSeparacaoId = 0 then
    Begin
      vSql := 'Insert Into PedidoVolumeSeparacao (CaixaEmbalagemId, PedidoVolumeId, Operacao, EnderecoId, '
        + 'Usuarioid, DtInicio, HrInicio, Divergencia) Values (' +
        Self.ObjVolumeSeparacao.CaixaEmbalagemId.ToString() + ', ' +
        Self.ObjVolumeSeparacao.PedidoVolumeId.ToString() + ', ' +
        Self.ObjVolumeSeparacao.Operacao.ToString() + ', ' +
        Self.ObjVolumeSeparacao.EnderecoId.ToString() + ', ' +
        IfThen(Self.ObjVolumeSeparacao.UsuarioId = 0, 'Null',
        Self.ObjVolumeSeparacao.UsuarioId.ToString()) + ', ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', 0)' + sLineBreak;
      vSql := vSql +
        'Select Coalesce(VolumeSeparacaoId, 0) VolumeSeparacaoId From PedidoVolumeSeparacao '
        + 'Where CaixaEmbalagemId = ' +
        Self.ObjVolumeSeparacao.CaixaEmbalagemId.ToString() +
        ' and PedidoVolumeId    = ' + Self.ObjVolumeSeparacao.PedidoVolumeId.
        ToString() + ' and UsuarioId = ' + Self.ObjVolumeSeparacao.UsuarioId.
        ToString() + ' and Operacao  = 0' + sLineBreak;
      if Self.ObjVolumeSeparacao.CaixaEmbalagemId <> 0 then
        vSql := vSql + 'Update PedidoVolumes Set CaixaEmbalagemId = ' +
          Self.ObjVolumeSeparacao.CaixaEmbalagemId.ToString() + sLineBreak +
          'Where PedidoVolumeId = ' + Self.ObjVolumeSeparacao.PedidoVolumeId.
          ToString() + sLineBreak;
    End
    Else
    Begin
      vSql := ' Update PedidoVolumeSeparacao ' + '   Set Operacao       = ' +
        Self.ObjVolumeSeparacao.Operacao.ToString() + '   , EnderecoId     = ' +
        Self.ObjVolumeSeparacao.EnderecoId.ToString() + '   , UsuarioId      = '
        + IfThen(Self.ObjVolumeSeparacao.Operacao = 0,
        IfThen(Self.ObjVolumeSeparacao.UsuarioId = 0, 'Null',
        Self.ObjVolumeSeparacao.UsuarioId.ToString()), 'Null') +
        IfThen(Self.ObjVolumeSeparacao.Operacao = 1, '   , DtFinalizacao  = ' +
        TuEvolutConst.SqlDataAtual, '') +
        IfThen(Self.ObjVolumeSeparacao.Operacao = 1, '   , HrFinalizacao  = ' +
        TuEvolutConst.SqlHoraAtual, '') + ' where VolumeSeparacaoId = ' +
        Self.ObjVolumeSeparacao.VolumeSeparacaoId.ToString + sLineBreak +
        '  Select ' + Self.ObjVolumeSeparacao.VolumeSeparacaoId.ToString +
        ' as VolumeSeparacaoId' + sLineBreak;
    End;
    FConexao.Query.SQL.Add(vSql);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('RegistrarSeparacao.Sql');
    FConexao.Query.Open();
    Result := FConexao.Query.FieldByName('VolumeSeparacaoId').AsInteger;

    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    if Self.ObjVolumeSeparacao.Operacao = 1 then
    Begin
      JsonRegVolume := tjsonObject.Create;
      JsonRegVolume.AddPair('pedidovolumeid',
        TJsonNumber.Create(Self.ObjVolumeSeparacao.PedidoVolumeId));
      if pConsolidado = 1 then
        JsonRegVolume.AddPair('processoid', TJsonNumber.Create(10))
      Else
        JsonRegVolume.AddPair('processoid', TJsonNumber.Create(8));
      JsonRegVolume.AddPair('usuarioid',
        TJsonNumber.Create(Self.ObjVolumeSeparacao.UsuarioId));
      JsonRegVolume.AddPair('estacao', pEstacao);
      ObjPedidoVolumeDAO.RegistrarDocumentoEtapa(JsonRegVolume);
    End
    Else If Self.ObjVolumeSeparacao.UsuarioId > 0 then
    Begin
      JsonRegVolume := tjsonObject.Create;
      JsonRegVolume.AddPair('pedidovolumeid',
        TJsonNumber.Create(Self.ObjVolumeSeparacao.PedidoVolumeId));
      JsonRegVolume.AddPair('processoid', TJsonNumber.Create(7));
      JsonRegVolume.AddPair('usuarioid',
        TJsonNumber.Create(Self.ObjVolumeSeparacao.UsuarioId));
      JsonRegVolume.AddPair('estacao', pEstacao);
      if Self.ObjVolumeSeparacao.EnderecoId = 0 then
        ObjPedidoVolumeDAO.RegistrarDocumentoEtapa(JsonRegVolume);
    End;
    JsonRegVolume := Nil;
    ObjPedidoVolumeDAO.free;
    if Self.ObjVolumeSeparacao.Operacao = 0 then
      AlterarStatusVolume(Self.ObjVolumeSeparacao.PedidoVolumeId, 9,
        Self.ObjVolumeSeparacao.UsuarioId, pEstacao)
    Else
    Begin
      if CheckFinalizacaoCheckInPedido(Self.ObjVolumeSeparacao.PedidoVolumeId)
        >= 10 then
        AlterarStatusVolume(Self.ObjVolumeSeparacao.PedidoVolumeId, 10,
          Self.ObjVolumeSeparacao.UsuarioId, pEstacao);
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoVolumeSeparacaoDao.SaveSeparacao(JsonSeparacao
  : tjsonObject): Boolean;
begin
  Result := False;
  try
    FConexao.Query.SQL.Add('Update PedidoVolumeLotes  ');
    FConexao.Query.SQL.Add('   Set  QtdSuprida = ' + JsonSeparacao.GetValue<Integer>
      ('qtdsuprida').ToString());
    FConexao.Query.SQL.Add('       ,DtInclusao = ' + TuEvolutConst.SqlDataAtual);
    FConexao.Query.SQL.Add('       ,HrInclusao = ' + TuEvolutConst.SqlHoraAtual);
    FConexao.Query.SQL.Add('       ,Terminal   = ' +
      QuotedStr(JsonSeparacao.GetValue<String>('estacao')));
    FConexao.Query.SQL.Add('Where PedidoVolumeLoteId = ' + JsonSeparacao.GetValue<Integer>
      ('pedidovolumeloteid').ToString());
    FConexao.Query.ExecSql;
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

Function TPedidoVolumeSeparacaoDao.TrataErroFireDac
  (pErro: EFDDBEngineException): String;
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
  Result := 'Tabela: PedidoVolumeSeparacao - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

end.
