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
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Add(TuEvolutConst.AtualizaStatusPedido);
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.ParamByName('pTerminal').Value := pTerminal;
      Query.ExecSql;
    Except ON E: Exception do
      raise Exception.Create('Processo: AlterarStatusVolume - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
   FreeAndNil(Query);
  End;
end;

function TPedidoVolumeSeparacaoDao.CheckFinalizacaoCheckInPedido(pPedidoVolumeId
  : Integer): Integer;
Var Query : TFdQuery;
begin
  Result := -1;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('Declare @PedidoId Integer = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = '+pPedidoVolumeId.ToString + ')');
      Query.SQL.Add('Select Min(ProcessoId) As PedidoVolumeStatus');
      Query.SQL.Add('From');
      Query.SQL.Add('(select De.Documento, Max(De.ProcessoId) Processoid');
      Query.SQL.Add('from DocumentoEtapas De');
      Query.SQL.Add('Inner join PedidoVolumes PV On PV.Uuid = De.Documento');
      Query.SQL.Add('where Pv.PedidoId = @PedidoId and De.Status = 1 and De.Status <> 6');
      Query.SQL.Add('Group By De.Documento) as DoctoEt');
      Query.Open;
      Result := Query.FieldByName('PedidoVolumeStatus').AsInteger;
    Except On E: Exception do
      Raise Exception.Create('Processo: FinalizacaoCheckInPedido - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

constructor TPedidoVolumeSeparacaoDao.Create;
begin
  ObjVolumeSeparacao := TVolumeSeparacao.Create;
  inherited;
end;

function TPedidoVolumeSeparacaoDao.Delete: Boolean;
Var Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.ExecSql('Delete from PedidoVolumeSeparacao where VolumeSeparacaoId = ' + Self.ObjVolumeSeparacao.VolumeSeparacaoId.ToString);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeSeparacaoDelete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TPedidoVolumeSeparacaoDao.Destroy;
begin
  FreeAndNil(ObjVolumeSeparacao);
  inherited;
end;

function TPedidoVolumeSeparacaoDao.GetId(pCaixaEmbalagemId: Integer;
  pPedidoVolumeId: Integer; pOperacao: Integer): TjSonArray;
var PedidoVolumeSeparacaoItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlPedidoVolumeCheckIn);
      Query.ParamByName('pCaixaEmbalagemId').Value := pCaixaEmbalagemId;
      Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      Query.ParamByName('pOperacao').Value := pOperacao;
      Query.Open;
      if Query.Isempty then
         Result.AddElement(tjsonObject.Create(tJsonPair.Create('Erro', TuEvolutConst.QrySemDados)))
      Else
        while Not Query.Eof do
          With ObjVolumeSeparacao do Begin
            VolumeSeparacaoId := Query.FieldByName('VolumeSeparacaoId').AsInteger;
            CaixaEmbalagemId := Query.FieldByName('CaixaEmbalagemId').AsInteger;
            Operacao := Query.FieldByName('Operacao').AsInteger;
            // 0-Aberto   1-Finalizado
            PedidoVolumeId := Query.FieldByName('PedidoVolumeId').AsInteger;
            EnderecoId := Query.FieldByName('EnderecoId').AsInteger;
            UsuarioId := Query.FieldByName('UsuarioId').AsInteger;
            DtInicio := Query.FieldByName('DtInicio').AsInteger;
            HrInicio := Query.FieldByName('HrInicio').AsInteger;
            DtFinalizacao := Query.FieldByName('DtFinalizacao').AsInteger;
            HrFinalizacao := Query.FieldByName('HrFinalizacao').AsInteger;
            Divergencia := Query.FieldByName('Divergencia').AsInteger;
            Result.AddElement(tJson.ObjectToJsonObject(ObjVolumeSeparacao, [joDateFormatISO8601]));
            Query.Next;
          End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PedidoVolumeSeparacao(GetId) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeSeparacaoDao.GetDesempenhoExpedicao(aParams: TDictionary<String, String>): TjSonArray;
var vParamOk: Integer;
    vData: TDateTime;
    Query : TFdQuery;
begin
  vParamOk := 0;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.GetDesempenhoExpedicao);
      if aParams.ContainsKey('datainicialpedido') then begin
         Try
           if StrToDate(aParams.Items['datainicialpedido']) <> 0 then
              Query.ParamByName('pDataPedidoInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datainicialpedido']))
           Else
              Query.ParamByName('pDataPedidoInicial').Value := 0;
           Inc(vParamOk);
         Except
         End;
      end
      Else
         Query.ParamByName('pDataPedidoInicial').Value := 0;
      if aParams.ContainsKey('datafinalpedido') then begin
         Try
           if StrToDate(aParams.Items['datafinalpedido']) <> 0 then
              Query.ParamByName('pDataPedidoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datafinalpedido']))
           Else
              Query.ParamByName('pDataPedidoFinal').Value := 0;
           Inc(vParamOk);
         Except
         End;
      end
      Else
        Query.ParamByName('pDataPedidoFinal').Value := 0;
      if aParams.ContainsKey('datainicialproducao') then begin
        Try
          if StrToDate(aParams.Items['datainicialproducao']) <> 0 then
             Query.ParamByName('pDataProducaoInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datainicialproducao']))
          Else
             Query.ParamByName('pDataProducaoInicial').Value := 0;
          Inc(vParamOk);
        Except
        End;
      end
      Else
         Query.ParamByName('pDataProducaoInicial').Value := 0;;
      if aParams.ContainsKey('datafinalproducao') then begin
        Try
          if StrToDate(aParams.Items['datafinalproducao']) <> 0 then
             Query.ParamByName('pDataProducaoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datafinalproducao']))
          Else
             Query.ParamByName('pDataProducaoFinal').Value := 0;
          Inc(vParamOk);
        Except
        End;
      end
      Else
         Query.ParamByName('pDataProducaoFinal').Value := 0;;
      if aParams.ContainsKey('usuarioid') then Begin
         Query.ParamByName('pUsuarioId').Value := aParams.Items['usuarioid'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pUsuarioId').Value := 0;
      if aParams.ContainsKey('analise') then Begin
         Query.ParamByName('pAnalise').Value := aParams.Items['analise'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pAnalise').Value := 1;
      if aParams.ContainsKey('embalagemid') then Begin // embalagemid
         Query.ParamByName('pEmbalagemId').Value := aParams.Items['embalagemid'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pEmbalagemId').Value := 99;
      if vParamOk <> aParams.Count then begin
         Result := TJsonArray.Create;
         Result.AddElement(tjsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'));
      end
      Else
      begin
        If DebugHook <> 0 Then Begin
           Query.SQL.Add('-- pDataPedidoInicial = ' + Query.ParamByName('pDataPedidoInicial').AsString);
           Query.SQL.Add('-- pDataPedidoFinal = ' + Query.ParamByName('pDataPedidoFinal').AsString);
           Query.SQL.Add('-- pDataProducaoInicial = ' +Query.ParamByName('pDataProducaoInicial').AsString);
           Query.SQL.Add('-- pDataProducaoFinal = ' + Query.ParamByName('pDataProducaoFinal').AsString);
           Query.SQL.Add('-- pUsuarioId = ' + Query.ParamByName('pUsuarioId').AsString);
           Query.SQL.Add('-- pAnalise = ' + Query.ParamByName('pAnalise').AsString);
           Query.SQL.Add('-- pEmbalagemId = ' + Query.ParamByName('pEmbalagemId').AsString);
           If DebugHook <> 0 Then
              Query.SQL.SaveToFile('DesepenhoExpedicao.Sql');
        End;
        Query.Open();
        if Query.Isempty then Begin
           Result := TJsonArray.Create;
           Result.AddElement(tjsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
        End
        Else
        Begin
          // TDataSetSerializeConfig.GetInstance.DateInputIsUTC    := False;
          // TDataSetSerializeConfig.GetInstance.DateTimeIsISO8601 := True;
          TDataSetSerializeConfig.GetInstance.Export.FormatDateTime := 'yyyy-mm-dd hh:nn:ss.zzz';
          Result := Query.ToJSONArray;
        End;
      end;
    Except On E: Exception do
      Raise Exception.Create('Processo: GetDesempenhoExpedicao - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeSeparacaoDao.GetDshSeparacao(aParams: TDictionary<String, String>): TjSonArray;
var vParamOk: Integer;
    vDataPedido, vDataProducao: TDateTime;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      vParamOk := 0;
      Query.SQL.Add(TuEvolutConst.SqlDSHSeparacao);
      if aParams.ContainsKey('usuarioid') then Begin
         Query.ParamByName('pUsuarioId').Value := aParams.Items['usuarioid'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pUsuarioId').Value := 0;
      if aParams.ContainsKey('datapedidoinicial') then begin
        Try
          vDataPedido := StrToDate(aParams.Items['datapedidoinicial']);
          if vDataPedido <> 0 then
             Query.ParamByName('pdatapedidoinicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datapedidoinicial']));
          Inc(vParamOk);
        Except
        End;
      end
      Else
         Query.ParamByName('pdatapedidoinicial').Value := 0;
      if aParams.ContainsKey('datapedidofinal') then begin
         Try
           vDataPedido := StrToDate(aParams.Items['datapedidofinal']);
           if vDataPedido <> 0 then Begin
             Query.ParamByName('pdatapedidofinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datapedidofinal']));
           End;
           Inc(vParamOk);
         Except
         End;
      end
      Else
         Query.ParamByName('pdatapedidofinal').Value := 0;
      if aParams.ContainsKey('dataproducaoinicial') then begin
         Try
           vDataProducao := StrToDate(aParams.Items['dataproducaoinicial']);
           if vDataProducao <> 0 then Begin
              Query.ParamByName('pdataproducaoinicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['dataproducaoinicial']));
           End;
           Inc(vParamOk);
         Except
         End;
      end
      Else
         Query.ParamByName('pdataproducaoinicial').Value := 0;
      if aParams.ContainsKey('dataproducaofinal') then begin
         Try
           vDataProducao := StrToDate(aParams.Items['dataproducaofinal']);
           if vDataProducao <> 0 then Begin
              Query.ParamByName('pdataproducaofinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['dataproducaofinal']));
           End;
           Inc(vParamOk);
         Except
         End;
      end
      Else
         Query.ParamByName('pdataproducaofinal').Value := 0;
      if aParams.ContainsKey('zonaid') then begin
         if StrToIntDef(aParams.Items['zonaid'], 0) > 0 then Begin
            Query.ParamByName('pZonaId').Value := aParams.Items['zonaid'];
         End;
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if vParamOk <> aParams.Count then Begin
         Result := TjSonArray.Create;
         Result.AddElement(tjsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'))
      End
      Else
      begin
        If DebugHook <> 0 Then
           Query.SQL.SaveToFile('DSHSeparacao.Sql');
        Query.Open();
        if Query.Isempty then Begin
           Result := TjSonArray.Create();
           Result.AddElement(tjsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
        End
        Else
           Result := Query.ToJSONArray;
      end;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: DshSeparacao - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeSeparacaoDao.GetResumoSeparacao
  (aParams: TDictionary<String, String>): TjSonArray;
var vParamOk: Integer;
    vDataPedido, vDataProducao: TDateTime;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('Select *, (select SeparacaoFracionadoMeta From Configuracao) Meta,');
      Query.SQL.Add('       (Select SeparacaoFracionadoTolerancia From Configuracao) Tolerancia');
      Query.SQL.Add('From vResumoSeparacao Where 1 = 1');
      if aParams.ContainsKey('usuarioid') then Begin
         Query.SQL.Add('and UsuarioId = :pUsuarioId');
         Query.ParamByName('pUsuarioId').Value := aParams.Items['usuarioid'];
         Inc(vParamOk);
      end;
      if aParams.ContainsKey('datainicialpedido') then begin
         Try
           vDataPedido := StrToDate(aParams.Items['datainicialpedido']);
           if vDataPedido <> 0 then Begin
              Query.SQL.Add('and Data >= :pDataInicialPedido');
              Query.ParamByName('pDataInicialPedido').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datainicialpedido']));
           End;
           Inc(vParamOk);
         Except
         End;
      end;
      if aParams.ContainsKey('datafinalpedido') then begin
         Try
           vDataPedido := StrToDate(aParams.Items['datafinalpedido']);
           if vDataPedido <> 0 then Begin
              Query.SQL.Add('and Data <= :pDataFinalPedido');
              Query.ParamByName('pDataFinalPedido').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datafinalpedido']));
           End;
           Inc(vParamOk);
         Except
         End;
      end;
      if aParams.ContainsKey('datainicialproducao') then begin
         Try
           vDataProducao := StrToDate(aParams.Items['datainicialproducao']);
           if vDataProducao <> 0 then Begin
              Query.SQL.Add('and Dataproducao >= :pDataInicialproducao');
              Query.ParamByName('pDataInicialproducao').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datainicialproducao']));
           End;
           Inc(vParamOk);
         Except
         End;
      end;
      if aParams.ContainsKey('datafinalproducao') then begin
         Try
           vDataProducao := StrToDate(aParams.Items['datafinalproducao']);
           if vDataProducao <> 0 then Begin
              Query.SQL.Add('and Dataproducao <= :pDataFinalproducao');
              Query.ParamByName('pDataFinalproducao').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aParams.Items['datafinalproducao']));
           End;
           Inc(vParamOk);
         Except
         End;
      end;
      if aParams.ContainsKey('processoid') then begin
         if StrToIntDef(aParams.Items['processoid'], 0) > 0 then Begin
            Query.SQL.Add('and ProcessoEtapaId = :pProcessoId');
            Query.ParamByName('pProcessoId').Value := aParams.Items['processoid'];
         End;
         Inc(vParamOk);
      end;
      if vParamOk <> aParams.Count then Begin
         Result := TjSonArray.Create;
         Result.AddElement(tjsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'))
      End
      Else begin
        // qryPesquisa.SQL.Add('order by InventarioId');
        Query.SQL.Add('Order by nome, data --Pedido, dataProducao');
        If DebugHook <> 0 Then
           Query.SQL.SaveToFile('ResumoSeparacao.Sql');
        Query.Open();
        if Query.Isempty then Begin
           Result := TjSonArray.Create();
           Result.AddElement(tjsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
        End
        Else
           Result := Query.ToJSONArray;
      end;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ResumoSeparacao - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
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
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.ObjVolumeSeparacao.VolumeSeparacaoId = 0 then
      Begin
        vSql := 'Insert Into PedidoVolumeSeparacao (CaixaEmbalagemId, PedidoVolumeId, Operacao, '+sLineBreak+
                'EnderecoId, Usuarioid, DtInicio, HrInicio, Divergencia) Values ('+sLineBreak+
                Self.ObjVolumeSeparacao.CaixaEmbalagemId.ToString() + ', '+sLineBreak+
                Self.ObjVolumeSeparacao.PedidoVolumeId.ToString() + ', '+sLineBreak+
                Self.ObjVolumeSeparacao.Operacao.ToString() + ', '+sLineBreak+
                Self.ObjVolumeSeparacao.EnderecoId.ToString() + ', '+sLineBreak+
                IfThen(Self.ObjVolumeSeparacao.UsuarioId = 0, 'Null', Self.ObjVolumeSeparacao.UsuarioId.ToString()) + ', '+sLineBreak+
                TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', 0)' + sLineBreak;
        vSql := vSql + 'Select Coalesce(VolumeSeparacaoId, 0) VolumeSeparacaoId From PedidoVolumeSeparacao '+sLineBreak+
                'Where CaixaEmbalagemId = ' + Self.ObjVolumeSeparacao.CaixaEmbalagemId.ToString()+sLineBreak+
                '  and PedidoVolumeId    = ' + Self.ObjVolumeSeparacao.PedidoVolumeId.ToString()+sLineBreak+
                '  and UsuarioId = ' + Self.ObjVolumeSeparacao.UsuarioId. ToString() +
                '  and Operacao  = 0' + sLineBreak;
        if Self.ObjVolumeSeparacao.CaixaEmbalagemId <> 0 then
           vSql := vSql + 'Update PedidoVolumes'+sLineBreak+
                   '   Set CaixaEmbalagemId = ' +Self.ObjVolumeSeparacao.CaixaEmbalagemId.ToString()+sLineBreak+
                   'Where PedidoVolumeId = ' + Self.ObjVolumeSeparacao.PedidoVolumeId.ToString() + sLineBreak;
      End
      Else Begin
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
      Query.SQL.Add(vSql);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('RegistrarSeparacao.Sql');
      Query.Open();
      Result := Query.FieldByName('VolumeSeparacaoId').AsInteger;
      ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
      if Self.ObjVolumeSeparacao.Operacao = 1 then Begin
         JsonRegVolume := tjsonObject.Create;
         JsonRegVolume.AddPair('pedidovolumeid', TJsonNumber.Create(Self.ObjVolumeSeparacao.PedidoVolumeId));
         if pConsolidado = 1 then
            JsonRegVolume.AddPair('processoid', TJsonNumber.Create(10))
         Else
            JsonRegVolume.AddPair('processoid', TJsonNumber.Create(8));
         JsonRegVolume.AddPair('usuarioid', TJsonNumber.Create(Self.ObjVolumeSeparacao.UsuarioId));
         JsonRegVolume.AddPair('estacao', pEstacao);
         ObjPedidoVolumeDAO.RegistrarDocumentoEtapa(JsonRegVolume);
      End
      Else If Self.ObjVolumeSeparacao.UsuarioId > 0 then Begin
         JsonRegVolume := tjsonObject.Create;
         JsonRegVolume.AddPair('pedidovolumeid', TJsonNumber.Create(Self.ObjVolumeSeparacao.PedidoVolumeId));
         JsonRegVolume.AddPair('processoid', TJsonNumber.Create(7));
         JsonRegVolume.AddPair('usuarioid', TJsonNumber.Create(Self.ObjVolumeSeparacao.UsuarioId));
         JsonRegVolume.AddPair('estacao', pEstacao);
         if Self.ObjVolumeSeparacao.EnderecoId = 0 then
            ObjPedidoVolumeDAO.RegistrarDocumentoEtapa(JsonRegVolume);
      End;
      JsonRegVolume := Nil;
      FreeAndNil(ObjPedidoVolumeDAO);
      if Self.ObjVolumeSeparacao.Operacao = 0 then
         AlterarStatusVolume(Self.ObjVolumeSeparacao.PedidoVolumeId, 9, Self.ObjVolumeSeparacao.UsuarioId, pEstacao)
      Else
      Begin
        if CheckFinalizacaoCheckInPedido(Self.ObjVolumeSeparacao.PedidoVolumeId) >= 10 then
           AlterarStatusVolume(Self.ObjVolumeSeparacao.PedidoVolumeId, 10, Self.ObjVolumeSeparacao.UsuarioId, pEstacao);
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Process: VolumeSeparacaoSalvar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoVolumeSeparacaoDao.SaveSeparacao(JsonSeparacao
  : tjsonObject): Boolean;
Var Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Update PedidoVolumeLotes  ');
      Query.SQL.Add('   Set  QtdSuprida = ' + JsonSeparacao.GetValue<Integer>('qtdsuprida').ToString());
      Query.SQL.Add('       ,DtInclusao = ' + TuEvolutConst.SqlDataAtual);
      Query.SQL.Add('       ,HrInclusao = ' + TuEvolutConst.SqlHoraAtual);
      Query.SQL.Add('       ,Terminal   = ' + QuotedStr(JsonSeparacao.GetValue<String>('estacao')));
      Query.SQL.Add('Where PedidoVolumeLoteId = ' + JsonSeparacao.GetValue<Integer>('pedidovolumeloteid').ToString());
      Query.ExecSql;
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: SaveSeparacao - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
