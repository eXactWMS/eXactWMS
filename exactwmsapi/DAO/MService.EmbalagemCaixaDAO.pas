unit MService.EmbalagemCaixaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error, exactwmsservice.lib.utils,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  EmbalagemCaixaClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type

  TCaixaEmbalagemDao =class(TBasicDao)
  private
    

    FCaixaEmbalagem: TCaixaEmbalagem;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    Function GetCaixaResumo : TJsonArray;
    function GetId(pCaixaEmbalagemId: Integer): TjSonArray;
    Function GetLista(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer;
             pSituacao: String; pStatus : Integer) : TJsonArray;
    Function GetListaPaginacao(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer;
             pSituacao: String; pStatus, pLimit, pOffSet : Integer) : TJsonObject;
    Function Rastreamento(const AParams: TDictionary<string, string>) : TjsonArray;
    Function Estrutura: TjSonArray;
    Function Delete: Boolean;
    Function InsertFilaCaixa(pJsonObject : TJsonObject) : TJsonObject;
    Function CaixaLiberacao(pCaixaId : Integer) : TJsonArray;
    Function CaixaInativar(pCaixaId : Integer) : TJsonArray;
    Function GetMaxCaixa : TJsonArray;

    Property ObjCaixaEmbalagem: TCaixaEmbalagem Read FCaixaEmbalagem Write FCaixaEmbalagem;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TCaixaEmbalagemDao.CaixaInativar(pCaixaId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Connection;
  Try
    Try
      Query.Sql.Add('Update CaixaEmbalagem Set Status = 0 Where NumSequencia = :pCaixaId');
      Query.ParamByName('pCaixaId').Value := pCaixaId;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('CaixaInativar.Sql');
      Query.ExecSql;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Caixa Inativada com sucesso!'));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: CaixaEmbalagem(CaixaInativar) - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.CaixaLiberacao(pCaixaId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Connection;
  Try
    Try
      Query.Sql.Add('Update CaixaEmbalagem Set PedidoVolumeId = Null Where NumSequencia = :pCaixaId');
      Query.ParamByName('pCaixaId').Value := pCaixaId;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('CaixaLiberacao.Sql');
      Query.ExecSql;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Caixa Liberada com sucesso!'));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: CaixaEmbalagem(CaixaLiberacao) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
   Query.Free;
  End;
end;

constructor TCaixaEmbalagemDao.Create;
begin
  ObjCaixaEmbalagem := TCaixaEmbalagem.Create;
  inherited;
end;

function TCaixaEmbalagemDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from CaixaEmbalagem where CaixaEmbalagemId= ' + Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except
      On E: Exception do
      Begin
        raise Exception.Create('Tabela: CaixaEmbalagem - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  Finally
   Query.Free;
  End;
end;

destructor TCaixaEmbalagemDao.Destroy;
begin
  ObjCaixaEmbalagem.Free;
  inherited;
end;

function TCaixaEmbalagemDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak+
               'Where TABLE_NAME = ' + QuotedStr('CaixaEmbalagem') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do Begin
        vRegEstrutura := TJsonObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.GetLista(pCaixaEmbalagemId, pSequenciaIni,
  pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String; pStatus : Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Sql.Clear;
    Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemLista);
    Query.ParamByName('pCaixaEmbalagemId').Value  := pCaixaEmbalagemId;
    Query.ParamByName('pSequenciaIni').Value      := pSequenciaIni;
    Query.ParamByName('pSequenciaFin').Value      := pSequenciaFin;
    Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
    Query.ParamByName('pSituacao').Value          := pSituacao;
    Query.ParamByName('pStatus').Value            := pStatus;
    If DebugHook <> 0 Then
       Query.Sql.SaveToFile('CaixaEmbalagemLista.Sql');
    Query.Open;
    if (Query.IsEmpty) or (Query.FieldByName('JsonRetorno').AsString = '') then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else Begin
      Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Query.FieldByName('jsonRetorno').AsString), 0) as TjSonArray;
    End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(Caixas Lista) - ' + TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

function TCaixaEmbalagemDao.GetListaPaginacao(pCaixaEmbalagemId, pSequenciaIni,
  pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus, pLimit, pOffSet : Integer): TJSonObject;
Var vTotRegistro : Integer;
    JsonArrayRetorno : TJsonArray;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('Declare @CaixaEmbalagemId Integer  = :pCaixaEmbalagemId');
      Query.Sql.Add('Declare @SequenciaIni Integer      = :pSequenciaIni');
      Query.Sql.Add('Declare @SequenciaFin Integer      = :pSequenciaFin');
      Query.Sql.Add('Declare @VolumeEmbalagemid Integer = :pVolumeEmbalagemId');
      Query.Sql.Add('Declare @Situacao Varchar(1)       = :pSituacao');
      Query.Sql.Add('Declare @Status Integer            = :pStatus');
      Query.Sql.Add('select Count(Ce.CaixaEmbalagemId) TotRegistro');
      Query.Sql.Add('From CaixaEmbalagem CE');
      Query.Sql.Add('Inner Join VolumeEmbalagem On VolumeEmbalagem.EmbalagemId = CE.EmbalagemId');
      Query.Sql.Add('Where (@CaixaEmbalagemId = 0 or @CaixaEmbalagemId = CE.CaixaEmbalagemID) and');
      Query.Sql.Add('      (@SequenciaIni = 0 or Ce.NumSequencia >= @SequenciaIni) and');
      Query.Sql.Add('      (@SequenciaFin = 0 or Ce.NumSequencia <= @SequenciaFin) and');
      Query.Sql.Add('      (@VolumeEmbalagemId = 0 or @VolumeEmbalagemId = Ce.EmbalagemId) and');
      Query.Sql.Add('      (@Status>1 or @Status = Ce.Status)');
      Query.ParamByName('pCaixaEmbalagemId').Value  := pCaixaEmbalagemId;
      Query.ParamByName('pSequenciaIni').Value      := pSequenciaIni;
      Query.ParamByName('pSequenciaFin').Value      := pSequenciaFin;
      Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
      Query.ParamByName('pSituacao').Value          := pSituacao;
      Query.ParamByName('pStatus').Value            := pStatus;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('CaixaEmbalagemListaHeader.Sql');
      Query.Open();
      vTotRegistro := Query.FieldByName('TotRegistro').Asinteger;
      Result := TJSonObject.Create;
      Result.AddPair('registro', TJsonNumber.Create(vTotRegistro));
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemLista);
      Query.ParamByName('pCaixaEmbalagemId').Value  := pCaixaEmbalagemId;
      Query.ParamByName('pSequenciaIni').Value      := pSequenciaIni;
      Query.ParamByName('pSequenciaFin').Value      := pSequenciaFin;
      Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
      Query.ParamByName('pSituacao').Value          := pSituacao;
      Query.ParamByName('pStatus').Value            := pStatus;
      if (pOffSet >= 0) then
         Query.Sql.Strings[0] := StringReplace(StringReplace(Query.Sql.Strings[0], '--', '', [rfReplaceAll]), 'xOffSet', pOffSet.ToString(), [rfReplaceAll]) ;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('CaixaEmbalagemLista.Sql');
      Query.Open;
      if (Query.IsEmpty) or (Query.FieldByName('JsonRetorno').AsString = '') then Begin
  //       Result := TJsonArray.Create;
  //       Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
         JsonArrayRetorno := TJsonArray.Create;
         JsonArrayRetorno.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
         Result.AddPair('caixas', JsonArrayRetorno);
      End
      Else Begin
        JsonArrayRetorno := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Query.FieldByName('jsonRetorno').AsString), 0) as TjSonArray;
        Result.AddPair('caixas', JsonArrayRetorno);
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: CaixaEmbalagem(Caixas Lista) - ' +Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.GetMaxCaixa: TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Select Coalesce(Max(NumSequencia), 0)+1 NumSequencia from CaixaEmbalagem');
      Query.Open;
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('numsequencia', TJsonNumber.Create(Query.FieldByName('NumSequencia').AsInteger)));
    Except On E: Exception do
        raise Exception.Create('Tabela: GetMaxCaixa - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.InsertFilaCaixa(pJsonObject : TJsonObject): TJsonObject;
Var xCaixa : Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if pJsonObject.GetValue<Integer>('caixaidinicial' , 0) <= 0 then
         Raise Exception.Create('Tabela: InsertFilaCaixa. Nr Inicial('+pJsonObject.GetValue<String>('caixaidinicial')+') para criação/identificação das caixas é inválido!');
      if pJsonObject.GetValue<Integer>('caixaidfinal', 0) <= 0 then
         Raise Exception.Create('Tabela: InsertFilaCaixa. Nr Final('+pJsonObject.GetValue<String>('caixaidfinal')+') para criação/identificação das caixas é inválido!');
      Query.connection.StartTransaction;
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('Declare @xCaixaId      Integer = :pCaixaIdInicial');
      Query.Sql.Add('Declare @xCaixaIdFinal Integer = :pCaixaIdFinal');
      Query.Sql.Add('Declare @EmbalagemId   Integer = :pEmbalagemId');
      Query.Sql.Add('while @xCaixaId <= @xCaixaIdFinal Begin');
      Query.Sql.Add('  If Not Exists (Select CaixaEmbalagemId From CaixaEmbalagem where NumSequencia = @xCaixaId) Begin');
      Query.Sql.Add('     Insert Into CaixaEmbalagem (CaixaEmbalagemId, EmbalagemId,NumSequencia, Observacao, Disponivel, Status, PedidoVolumeId)');
      Query.Sql.Add('	        Values (@xCaixaId, @EmbalagemId, @xCaixaId, Null, 1, 1, Null)');
      Query.Sql.Add('  End;');
      Query.Sql.Add('  Set @xCaixaId = @xCaixaId + 1');
      Query.Sql.Add('End;');
      Query.ParamByName('pCaixaIdInicial').Value := pJsonObject.GetValue<Integer>('caixaidinicial', 0);
      Query.ParamByName('pCaixaIdFinal').Value   := pJsonObject.GetValue<Integer>('caixaidfinal', 0);
      Query.ParamByName('pEmbalagemId').Value    := pJsonObject.GetValue<Integer>('embalagemid', 0);
      If DebugHook <> 0 then
         Query.Sql.SaveToFile('InsertFilaCaixa.Sql');
      Query.ExecSql;
      Query.connection.Commit;
      Result := TJsonObject.Create.AddPair('Ok','Caixas criadas com sucesso!')
    Except ON E: Exception do
      Begin
        Query.connection.RollBack;
        raise Exception.Create('Tabela: InsertFilaCaixa - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.Rastreamento(Const AParams: TDictionary<string, string>): TjsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemRastreamento);
      if AParams.ContainsKey('dtpedidoinicial') then
         Query.ParamByName('pDtPedidoInicial').value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidoinicial']))
      Else
         Query.ParamByName('pDtPedidoInicial').value := 0;
      if AParams.ContainsKey('dtpedidofinal') then
         Query.ParamByName('pDtPedidoFinal').value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidofinal']))
      Else
         Query.ParamByName('pDtPedidoFinal').value := 0;
      if AParams.ContainsKey('caixaidinicial') then
         Query.ParamByName('pCaixaIdInicial').value := StrToInt(AParams.Items['caixaidinicial'])
      Else
         Query.ParamByName('pCaixaIdInicial').value := 0;
      if AParams.ContainsKey('caixaidfinal') then
         Query.ParamByName('pCaixaIdFinal').value := StrToInt(AParams.Items['caixaidfinal'])
      Else
         Query.ParamByName('pCaixaIdFinal').value := 0;
      if AParams.ContainsKey('codpessoaerp') then
         Query.ParamByName('pCodPessoaERP').value := StrToInt(AParams.Items['codpessoaerp'])
      Else
         Query.ParamByName('pCodPessoaERP').value := 0;
      if AParams.ContainsKey('processoid') then
         Query.ParamByName('pProcessoId').value := StrToInt(AParams.Items['processoid'])
      Else
         Query.ParamByName('pProcessoId').value := 0;
      if AParams.ContainsKey('rotaid') then
         Query.ParamByName('pRotaId').value := StrToInt(AParams.Items['rotaid'])
      Else
         Query.ParamByName('pRotaId').value := 0;
      If DebugHook <> 0 Then
        Query.Sql.SaveToFile('CaixaEmbalagemRastreamento.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Sem Dados para a consulta.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Caixa Rastreamento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.GetCaixaResumo: TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetCaixaResumo);
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('GetCaixaResumo.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Sem Dados para a consulta.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Caixa Resumo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.GetId(pCaixaEmbalagemId: Integer): TjSonArray;
var ObjJson: TJsonObject;
    CaixaEmbalagemItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    try
      Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagem);
      Query.ParamByName('pCaixaEmbalagemId').Value := pCaixaEmbalagemId;
      Query.Open;
      if Query.IsEmpty then
      begin
        if pCaixaEmbalagemId = 0 then
          Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
        Else
          Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Caixa não encontrada!'))
      End
      Else
        while Not Query.Eof do
          With ObjCaixaEmbalagem do Begin
            CaixaEmbalagemId               := Query.FieldByName('CaixaEmbalagemId').AsInteger;
            VolumeEmbalagem.EmbalagemId    := Query.FieldByName('EmbalagemId').AsInteger;
            VolumeEmbalagem.Descricao      := Query.FieldByName('Descricao').AsString;
            VolumeEmbalagem.Tipo           := Query.FieldByName('Tipo').AsString;
            VolumeEmbalagem.TipoDescricao  := Query.FieldByName('TipoDescricao').AsString;
            VolumeEmbalagem.Altura         := Query.FieldByName('Altura').AsFloat;
            VolumeEmbalagem.Largura        := Query.FieldByName('Largura').AsFloat;
            VolumeEmbalagem.Comprimento    := Query.FieldByName('Comprimento').AsFloat;
            VolumeEmbalagem.Volume         := Query.FieldByName('Volume').AsFloat;
            VolumeEmbalagem.Aproveitamento := Query.FieldByName('Aproveitamento').AsInteger;
            VolumeEmbalagem.Tara           := Query.FieldByName('Tara').AsFloat;
            VolumeEmbalagem.Capacidade     := Query.FieldByName('Capacidade').AsFloat;
            VolumeEmbalagem.QtdLacres      := Query.FieldByName('QtdLacres').AsInteger;
            VolumeEmbalagem.CodBarras      := Query.FieldByName('CodBarras').AsInteger;
            VolumeEmbalagem.Disponivel     := Query.FieldByName('Disponivel').AsInteger;
            VolumeEmbalagem.PrecoCusto     := Query.FieldByName('PrecoCusto').AsFloat;
            // VolumeEmbalagem.DtInclusao     := Query.FieldByName('DtInclusao').AsDateTime;
            // VolumeEmbalagem.HrInclusao     := Query.FieldByName('HrInclusao').AsDateTime;
            VolumeEmbalagem.Status := Query.FieldByName('Status').AsInteger;
            NumSequencia := Query.FieldByName('NumSequencia').AsInteger;
            Observacao   := Query.FieldByName('Observacao').AsString;
            Disponivel   := Query.FieldByName('Disponivel').AsInteger;
            Status       := Query.FieldByName('Status').AsInteger;
            Result.AddElement(tJson.ObjectToJsonObject(ObjCaixaEmbalagem, [joDateFormatISO8601]));
            Query.Next;
          End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: CaixaEmbalagem(Caixas) - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCaixaEmbalagemDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.ObjCaixaEmbalagem.CaixaEmbalagemId = 0 then
        vSql := 'Insert Into CaixaEmbalagem (EmbalagemId, NumSequencia, Observacao, Disponivel, Status) Values ('+sLineBreak+
                Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString() + ', ' +sLineBreak+
                Self.ObjCaixaEmbalagem.NumSequencia.ToString() + ', ' + sLineBreak+
                QuotedStr(Self.ObjCaixaEmbalagem.Observacao) + ', ' + sLineBreak+
                Self.ObjCaixaEmbalagem.Disponivel.ToString() + ', ' + sLineBreak+
                Self.ObjCaixaEmbalagem.Status.ToString() + ')'
      Else
        vSql := ' Update CaixaEmbalagem ' + // '     Set NumSequencia = '+QuotedStr(Self.ObjCaixaEmbalagem.Descricao)+
                '   Set Observacao       = ' + QuotedStr(Self.ObjCaixaEmbalagem.Observacao) +
                '      ,Disponivel       = ' + Self.ObjCaixaEmbalagem.Disponivel.ToString() +
                '      , Status          = ' + Self.ObjCaixaEmbalagem.Status.ToString() +
                ' where CaixaEmbalagemId = ' + Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: CaixaEmbalagem/Salvar ='+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
     Query.Free;
  End;
end;

end.
