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
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
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
begin
  Try
    FConexao.Query.Sql.Add('Update CaixaEmbalagem Set Status = 0 Where NumSequencia = :pCaixaId');
    FConexao.Query.ParamByName('pCaixaId').Value := pCaixaId;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('CaixaInativar.Sql');
    FConexao.Query.ExecSql;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Caixa Inativada com sucesso!'));
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(CaixaInativar) - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TCaixaEmbalagemDao.CaixaLiberacao(pCaixaId: Integer): TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add('Update CaixaEmbalagem Set PedidoVolumeId = Null Where NumSequencia = :pCaixaId');
    FConexao.Query.ParamByName('pCaixaId').Value := pCaixaId;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('CaixaLiberacao.Sql');
    FConexao.Query.ExecSql;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Caixa Liberada com sucesso!'));
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(CaixaLiberacao) - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

constructor TCaixaEmbalagemDao.Create;
begin
  ObjCaixaEmbalagem := TCaixaEmbalagem.Create;
  inherited;
end;

function TCaixaEmbalagemDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from CaixaEmbalagem where CaixaEmbalagemId= ' +
      Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString;
    FConexao.Query.ExecSQL(vSql);
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
end;

destructor TCaixaEmbalagemDao.Destroy;
begin
  ObjCaixaEmbalagem.Free;
  inherited;
end;

function TCaixaEmbalagemDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('CaixaEmbalagem') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    While Not FConexao.Query.Eof do
    Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna',
        LowerCase(FConexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo',
        LowerCase(FConexao.Query.FieldByName('Tipo').AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TCaixaEmbalagemDao.GetLista(pCaixaEmbalagemId, pSequenciaIni,
  pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String; pStatus : Integer): TJsonArray;
begin
  Try
    Fconexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemLista);
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value  := pCaixaEmbalagemId;
    FConexao.Query.ParamByName('pSequenciaIni').Value      := pSequenciaIni;
    FConexao.Query.ParamByName('pSequenciaFin').Value      := pSequenciaFin;
    FConexao.Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
    FConexao.Query.ParamByName('pSituacao').Value          := pSituacao;
    FConexao.Query.ParamByName('pStatus').Value            := pStatus;
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('CaixaEmbalagemLista.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('JsonRetorno').AsString = '') then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else Begin
      Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('jsonRetorno').AsString), 0) as TjSonArray;
    End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(Caixas Lista) - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TCaixaEmbalagemDao.GetListaPaginacao(pCaixaEmbalagemId, pSequenciaIni,
  pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus, pLimit, pOffSet : Integer): TJSonObject;
Var vTotRegistro : Integer;
    JsonArrayRetorno : TJsonArray;
begin
  Try
    Fconexao.Query.Close;
    FConexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add('Declare @CaixaEmbalagemId Integer  = :pCaixaEmbalagemId');
    Fconexao.Query.Sql.Add('Declare @SequenciaIni Integer      = :pSequenciaIni');
    Fconexao.Query.Sql.Add('Declare @SequenciaFin Integer      = :pSequenciaFin');
    Fconexao.Query.Sql.Add('Declare @VolumeEmbalagemid Integer = :pVolumeEmbalagemId');
    Fconexao.Query.Sql.Add('Declare @Situacao Varchar(1)       = :pSituacao');
    Fconexao.Query.Sql.Add('Declare @Status Integer            = :pStatus');
    Fconexao.Query.Sql.Add('select Count(Ce.CaixaEmbalagemId) TotRegistro');
    Fconexao.Query.Sql.Add('From CaixaEmbalagem CE');
    Fconexao.Query.Sql.Add('Inner Join VolumeEmbalagem On VolumeEmbalagem.EmbalagemId = CE.EmbalagemId');
    Fconexao.Query.Sql.Add('Where (@CaixaEmbalagemId = 0 or @CaixaEmbalagemId = CE.CaixaEmbalagemID) and');
    Fconexao.Query.Sql.Add('      (@SequenciaIni = 0 or Ce.NumSequencia >= @SequenciaIni) and');
    Fconexao.Query.Sql.Add('      (@SequenciaFin = 0 or Ce.NumSequencia <= @SequenciaFin) and');
    Fconexao.Query.Sql.Add('      (@VolumeEmbalagemId = 0 or @VolumeEmbalagemId = Ce.EmbalagemId) and');
    Fconexao.Query.Sql.Add('      (@Status>1 or @Status = Ce.Status)');
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value  := pCaixaEmbalagemId;
    FConexao.Query.ParamByName('pSequenciaIni').Value      := pSequenciaIni;
    FConexao.Query.ParamByName('pSequenciaFin').Value      := pSequenciaFin;
    FConexao.Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
    FConexao.Query.ParamByName('pSituacao').Value          := pSituacao;
    FConexao.Query.ParamByName('pStatus').Value            := pStatus;
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('CaixaEmbalagemListaHeader.Sql');
    FConexao.Query.Open();
    vTotRegistro := FConexao.Query.FieldByName('TotRegistro').Asinteger;
    Result := TJSonObject.Create;
    Result.AddPair('registro', TJsonNumber.Create(vTotRegistro));
    Fconexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemLista);
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value  := pCaixaEmbalagemId;
    FConexao.Query.ParamByName('pSequenciaIni').Value      := pSequenciaIni;
    FConexao.Query.ParamByName('pSequenciaFin').Value      := pSequenciaFin;
    FConexao.Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
    FConexao.Query.ParamByName('pSituacao').Value          := pSituacao;
    FConexao.Query.ParamByName('pStatus').Value            := pStatus;
    if (pOffSet >= 0) then
       FConexao.Query.Sql.Strings[0] := StringReplace(StringReplace(FConexao.Query.Sql.Strings[0], '--', '', [rfReplaceAll]), 'xOffSet', pOffSet.ToString(), [rfReplaceAll]) ;
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('CaixaEmbalagemLista.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('JsonRetorno').AsString = '') then Begin
//       Result := TJsonArray.Create;
//       Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
       JsonArrayRetorno := TJsonArray.Create;
       JsonArrayRetorno.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
       Result.AddPair('caixas', JsonArrayRetorno);
    End
    Else Begin
      JsonArrayRetorno := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('jsonRetorno').AsString), 0) as TjSonArray;
      Result.AddPair('caixas', JsonArrayRetorno);
    End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(Caixas Lista) - ' +Tutil.TratarExcessao(E.Message));
    End;
  end;
end;

function TCaixaEmbalagemDao.GetMaxCaixa: TJsonArray;
begin
  Try
    Fconexao.Query.Sql.Add('Select Coalesce(Max(NumSequencia), 0)+1 NumSequencia from CaixaEmbalagem');
    Fconexao.Query.Open;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('numsequencia', TJsonNumber.Create(FConexao.Query.FieldByName('NumSequencia').AsInteger)));
  Except On E: Exception do
      raise Exception.Create('Tabela: GetMaxCaixa - '+TUtil.TratarExcessao(E.Message));
  End;
end;

function TCaixaEmbalagemDao.InsertFilaCaixa(pJsonObject : TJsonObject): TJsonObject;
Var xCaixa : Integer;
begin
  Try
    if pJsonObject.GetValue<Integer>('caixaidinicial' , 0) <= 0 then
       Raise Exception.Create('Tabela: InsertFilaCaixa. Nr Inicial('+pJsonObject.GetValue<String>('caixaidinicial')+') para criação/identificação das caixas é inválido!');
    if pJsonObject.GetValue<Integer>('caixaidfinal', 0) <= 0 then
       Raise Exception.Create('Tabela: InsertFilaCaixa. Nr Final('+pJsonObject.GetValue<String>('caixaidfinal')+') para criação/identificação das caixas é inválido!');
    Fconexao.Query.connection.StartTransaction;
    Fconexao.Query.Close;
    Fconexao.Query.Sql.Clear;
    Fconexao.Query.Sql.Add('Declare @xCaixaId      Integer = :pCaixaIdInicial');
    Fconexao.Query.Sql.Add('Declare @xCaixaIdFinal Integer = :pCaixaIdFinal');
    Fconexao.Query.Sql.Add('Declare @EmbalagemId   Integer = :pEmbalagemId');
    Fconexao.Query.Sql.Add('while @xCaixaId <= @xCaixaIdFinal Begin');
    Fconexao.Query.Sql.Add('  If Not Exists (Select CaixaEmbalagemId From CaixaEmbalagem where NumSequencia = @xCaixaId) Begin');
    Fconexao.Query.Sql.Add('     Insert Into CaixaEmbalagem (CaixaEmbalagemId, EmbalagemId,NumSequencia, Observacao, Disponivel, Status, PedidoVolumeId)');
    Fconexao.Query.Sql.Add('	        Values (@xCaixaId, @EmbalagemId, @xCaixaId, Null, 1, 1, Null)');
    Fconexao.Query.Sql.Add('  End;');
    Fconexao.Query.Sql.Add('  Set @xCaixaId = @xCaixaId + 1');
    Fconexao.Query.Sql.Add('End;');
    Fconexao.Query.ParamByName('pCaixaIdInicial').Value := pJsonObject.GetValue<Integer>('caixaidinicial', 0);
    Fconexao.Query.ParamByName('pCaixaIdFinal').Value   := pJsonObject.GetValue<Integer>('caixaidfinal', 0);
    Fconexao.Query.ParamByName('pEmbalagemId').Value    := pJsonObject.GetValue<Integer>('embalagemid', 0);
    If DebugHook <> 0 then
       Fconexao.Query.Sql.SaveToFile('InsertFilaCaixa.Sql');
    Fconexao.Query.ExecSql;
    Fconexao.Query.connection.Commit;
    Result := TJsonObject.Create.AddPair('Ok','Caixas criadas com sucesso!')
  Except ON E: Exception do
    Begin
      Fconexao.Query.connection.RollBack;
      raise Exception.Create('Tabela: InsertFilaCaixa - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

function TCaixaEmbalagemDao.Rastreamento(Const AParams: TDictionary<string, string>): TjsonArray;
begin
  Try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemRastreamento);
    if AParams.ContainsKey('dtpedidoinicial') then
       FConexao.Query.ParamByName('pDtPedidoInicial').value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidoinicial']))
    Else
       FConexao.Query.ParamByName('pDtPedidoInicial').value := 0;
    if AParams.ContainsKey('dtpedidofinal') then
       FConexao.Query.ParamByName('pDtPedidoFinal').value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidofinal']))
    Else
       FConexao.Query.ParamByName('pDtPedidoFinal').value := 0;
    if AParams.ContainsKey('caixaidinicial') then
       FConexao.Query.ParamByName('pCaixaIdInicial').value := StrToInt(AParams.Items['caixaidinicial'])
    Else
       FConexao.Query.ParamByName('pCaixaIdInicial').value := 0;
    if AParams.ContainsKey('caixaidfinal') then
       FConexao.Query.ParamByName('pCaixaIdFinal').value := StrToInt(AParams.Items['caixaidfinal'])
    Else
       FConexao.Query.ParamByName('pCaixaIdFinal').value := 0;
    if AParams.ContainsKey('codpessoaerp') then
       FConexao.Query.ParamByName('pCodPessoaERP').value := StrToInt(AParams.Items['codpessoaerp'])
    Else
       FConexao.Query.ParamByName('pCodPessoaERP').value := 0;
    if AParams.ContainsKey('processoid') then
       FConexao.Query.ParamByName('pProcessoId').value := StrToInt(AParams.Items['processoid'])
    Else
       FConexao.Query.ParamByName('pProcessoId').value := 0;
    if AParams.ContainsKey('rotaid') then
       FConexao.Query.ParamByName('pRotaId').value := StrToInt(AParams.Items['rotaid'])
    Else
       FConexao.Query.ParamByName('pRotaId').value := 0;
    If DebugHook <> 0 Then
      Fconexao.Query.Sql.SaveToFile('CaixaEmbalagemRastreamento.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Sem Dados para a consulta.'));
    End
    Else
       Result := Fconexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Caixa Rastreamento - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

function TCaixaEmbalagemDao.GetCaixaResumo: TJsonArray;
begin
  Try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlGetCaixaResumo);
    If DebugHook <> 0 Then
      Fconexao.Query.Sql.SaveToFile('GetCaixaResumo.Sql');
    Fconexao.Query.Open;
    if Fconexao.Query.Isempty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Sem Dados para a consulta.'));
    End
    Else
       Result := Fconexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Caixa Resumo - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

function TCaixaEmbalagemDao.GetId(pCaixaEmbalagemId: Integer): TjSonArray;
var
  ObjJson: TJsonObject;
  CaixaEmbalagemItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagem);
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value := pCaixaEmbalagemId;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    begin
      if pCaixaEmbalagemId = 0 then
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados))
      Else
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          'Caixa não encontrada!'))
    End
    Else
      while Not FConexao.Query.Eof do
        With ObjCaixaEmbalagem do
        Begin
          CaixaEmbalagemId := FConexao.Query.FieldByName('CaixaEmbalagemId').AsInteger;
          VolumeEmbalagem.EmbalagemId := FConexao.Query.FieldByName('EmbalagemId')
            .AsInteger;
          VolumeEmbalagem.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
          VolumeEmbalagem.Tipo := FConexao.Query.FieldByName('Tipo').AsString;
          VolumeEmbalagem.TipoDescricao :=
            FConexao.Query.FieldByName('TipoDescricao').AsString;
          VolumeEmbalagem.Altura := FConexao.Query.FieldByName('Altura').AsFloat;
          VolumeEmbalagem.Largura := FConexao.Query.FieldByName('Largura').AsFloat;
          VolumeEmbalagem.Comprimento :=
            FConexao.Query.FieldByName('Comprimento').AsFloat;
          VolumeEmbalagem.Volume := FConexao.Query.FieldByName('Volume').AsFloat;
          VolumeEmbalagem.Aproveitamento := FConexao.Query.FieldByName('Aproveitamento')
            .AsInteger;
          VolumeEmbalagem.Tara := FConexao.Query.FieldByName('Tara').AsFloat;
          VolumeEmbalagem.Capacidade := FConexao.Query.FieldByName('Capacidade').AsFloat;
          VolumeEmbalagem.QtdLacres := FConexao.Query.FieldByName('QtdLacres').AsInteger;
          VolumeEmbalagem.CodBarras := FConexao.Query.FieldByName('CodBarras').AsInteger;
          VolumeEmbalagem.Disponivel := FConexao.Query.FieldByName('Disponivel')
            .AsInteger;
          VolumeEmbalagem.PrecoCusto := FConexao.Query.FieldByName('PrecoCusto').AsFloat;
          // VolumeEmbalagem.DtInclusao     := FConexao.Query.FieldByName('DtInclusao').AsDateTime;
          // VolumeEmbalagem.HrInclusao     := FConexao.Query.FieldByName('HrInclusao').AsDateTime;
          VolumeEmbalagem.Status := FConexao.Query.FieldByName('Status').AsInteger;
          NumSequencia := FConexao.Query.FieldByName('NumSequencia').AsInteger;
          Observacao := FConexao.Query.FieldByName('Observacao').AsString;
          Disponivel := FConexao.Query.FieldByName('Disponivel').AsInteger;
          Status := FConexao.Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjCaixaEmbalagem,
            [joDateFormatISO8601]));
          FConexao.Query.Next;
        End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(Caixas) - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TCaixaEmbalagemDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.ObjCaixaEmbalagem.CaixaEmbalagemId = 0 then
      vSql := 'Insert Into CaixaEmbalagem (EmbalagemId, NumSequencia, Observacao, Disponivel, Status) Values ('
        + Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString() + ', ' +
        Self.ObjCaixaEmbalagem.NumSequencia.ToString() + ', ' +
        QuotedStr(Self.ObjCaixaEmbalagem.Observacao) + ', ' +
        Self.ObjCaixaEmbalagem.Disponivel.ToString() + ', ' +
        Self.ObjCaixaEmbalagem.Status.ToString() + ')'
    Else
      vSql := ' Update CaixaEmbalagem ' +
      // '     Set NumSequencia = '+QuotedStr(Self.ObjCaixaEmbalagem.Descricao)+
        '   Set Observacao       = ' +
        QuotedStr(Self.ObjCaixaEmbalagem.Observacao) +
        '      ,Disponivel       = ' + Self.ObjCaixaEmbalagem.Disponivel.
        ToString() + '      , Status          = ' +
        Self.ObjCaixaEmbalagem.Status.ToString() + ' where CaixaEmbalagemId = '
        + Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;

  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

Function TCaixaEmbalagemDao.TrataErroFireDac
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
  Result := 'Tabela: EnderecamentoRuas - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

end.
