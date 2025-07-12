unit MService.FuncionalidadeDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FuncionalidadeClass, exactwmsservice.lib.connection, exactwmsservice.dao.base;

type

  TFuncionalidadeDao = class(TBasicDao)
  private

    FFuncionalidade: TFuncionalidade;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pJsonObject: TJsonObject): Boolean;
    Function SalvarTopicoFuncionalidade(pTopicoId, pFuncionalidadeId,
      pStatus: Integer): Boolean;
    function GetId(pFuncionalidade: String): TjSonArray;
    Function GetFuncionalidade4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    function TopicoFuncionalidades(pTopicoId: Integer): TjSonArray;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Property ObjFuncionalidade: TFuncionalidade Read FFuncionalidade
      Write FFuncionalidade;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TFuncionalidadeDao.Create;
begin
  ObjFuncionalidade := TFuncionalidade.Create;
  inherited;
end;

function TFuncionalidadeDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Funcionalidades where FuncionalidadeId= ' +
      Self.ObjFuncionalidade.FuncionalidadeId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Funcionalidades - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TFuncionalidadeDao.Destroy;
begin
  ObjFuncionalidade.Free;
  inherited;
end;

function TFuncionalidadeDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Fconexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Funcionalidades') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if Fconexao.Query.IsEmpty Then
  Begin
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'));
  End
  Else
    Result := Fconexao.Query.ToJSONArray();
end;

function TFuncionalidadeDao.GetFuncionalidade4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vSql: String;
begin
  Try
    vSql := 'select FuncionalidadeId, Descricao From Funcionalidades' + sLineBreak+
            'Where 1 = 1';
    Result := TJsonObject.Create();
    QryPesquisa := Fconexao.GetQuery;
    QryPesquisa.SQL.Add(vSql);
    QryRecordCount := Fconexao.GetQuery;
    QryRecordCount.SQL.Add
      ('Select Count(FuncionalidadeId) cReg From Funcionalidades Where 1 =1');
    if AParams.ContainsKey('funcionalidadeid') then begin
       QryPesquisa.SQL.Add('and FuncionalidadeId = :FuncionalidadeId');
       QryPesquisa.ParamByName('FuncionalidadeId').AsLargeInt := AParams.Items['funcionalidadeid'].ToInt64;
       QryRecordCount.SQL.Add('and FuncionalidadeId = :FuncionalidadeId');
       QryRecordCount.ParamByName('FuncionalidadeId').AsLargeInt := AParams.Items['funcionalidadeid'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then begin
       QryPesquisa.SQL.Add('and (Descricao like :Descricao))');
       QryPesquisa.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'].ToLower + '%';
       QryRecordCount.SQL.Add('and (Descricao like :Descricao))');
       QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'].ToLower + '%';
    end;
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by Descricao');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.ToJSONArray());
    if DebugHook <> 0 then
       QryPesquisa.SQL.SaveToFile('FuncionalidadeLista.Sql');
    QryRecordCount.Open();
    Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Close;
    QryRecordCount.Close;
  End;
end;

function TFuncionalidadeDao.GetId(pFuncionalidade: String): TjSonArray;
var
  ObjJson: TJsonObject;
  FuncionalidadeItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    Fconexao.Query.SQL.Add(TuEvolutConst.SqlFuncionalidades);
    if (pFuncionalidade = '0') or (StrToInt64Def(pFuncionalidade, 0) > 0) then
      Fconexao.Query.ParamByName('pFuncionalidadeId').Value := pFuncionalidade
    Else
      Fconexao.Query.ParamByName('pFuncionalidadeId').Value := 0;
    if (StrToInt64Def(pFuncionalidade, 0) > 0) or (pFuncionalidade = '0') then
      Fconexao.Query.ParamByName('pDescricao').Value := ''
    Else
      Fconexao.Query.ParamByName('pDescricao').Value :=
        '%' + pFuncionalidade + '%';
    Fconexao.Query.Open;
    while Not Fconexao.Query.Eof do
      With ObjFuncionalidade do
      Begin
        ObjJson := TJsonObject.Create;
        With ObjJson do
        Begin
          AddPair('funcionalidadeid',
            TJsonNumber.Create(Fconexao.Query.FieldByName('FuncionalidadeId')
            .AsInteger));
          AddPair('descricao', Fconexao.Query.FieldByName('Descricao')
            .AsString);
          AddPair('status',
            TJsonNumber.Create(Fconexao.Query.FieldByName('Status').AsInteger));
          AddPair('data', DateToStr(Fconexao.Query.FieldByName('Data')
            .AsDateTime));
          AddPair('hora',
            TimeToStr(StrToTime(Copy(Fconexao.Query.FieldByName('Hora')
            .AsString, 1, 8))));
          Result.AddElement(ObjJson);
          // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
        End;
        Fconexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Funcionalidades - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TFuncionalidadeDao.Salvar(pJsonObject: TJsonObject): Boolean;
var
  vSql: String;
begin
  try
    if pJsonObject.GetValue<Integer>('funcionalidadeId') = 0 then
      vSql := 'Insert Into Funcionalidades (Descricao, Status, Data, Hora) Values ('
        + QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +
        pJsonObject.GetValue<String>('status') + ', ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ')'
    Else
      vSql := ' Update Funcionalidades ' + '   Set Descricao = ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) +
        '      , Status   = ' + pJsonObject.GetValue<String>('status') +
        ' where FuncionalidadeId = ' + pJsonObject.GetValue<Integer>
        ('funcionalidadeId').ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TFuncionalidadeDao.SalvarTopicoFuncionalidade(pTopicoId,
  pFuncionalidadeId, pStatus: Integer): Boolean;
var
  vSql: String;
begin
  try
    Fconexao.Query.SQL.Add(TuEvolutConst.SqlSaveTopicoFuncionalidade);
    Fconexao.Query.ParamByName('pTopicoId').Value := pTopicoId;
    Fconexao.Query.ParamByName('pFuncionalidadeId').Value := pFuncionalidadeId;
    Fconexao.Query.ParamByName('pStatus').Value := pStatus;
    If DebugHook <> 0 Then
      Fconexao.Query.SQL.SaveToFile('SaveTopicoFuncionalidade.Sql');
    Fconexao.Query.ExecSQL;
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TFuncionalidadeDao.TopicoFuncionalidades(pTopicoId: Integer)
  : TjSonArray;
var
  ObjJson: TJsonObject;
  FuncionalidadeItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    Fconexao.Query.SQL.Add(TuEvolutConst.SqlTopicoFuncionalidades);
    Fconexao.Query.ParamByName('pTopicoId').Value := pTopicoId;
    Fconexao.Query.Open;
    while Not Fconexao.Query.Eof do
      With ObjFuncionalidade do
      Begin
        ObjJson := TJsonObject.Create;
        With ObjJson do
        Begin
          AddPair('funcionalidadeid',
            TJsonNumber.Create(Fconexao.Query.FieldByName('FuncionalidadeId')
            .AsInteger));
          AddPair('descricao', Fconexao.Query.FieldByName('Descricao')
            .AsString);
          AddPair('status',
            TJsonNumber.Create(Fconexao.Query.FieldByName('Status').AsInteger));
          Result.AddElement(ObjJson);
          // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
        End;
        Fconexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Funcionalidades - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Function TFuncionalidadeDao.TrataErroFireDac
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
