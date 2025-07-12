unit MService.EnderecamentoRuaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  EnderecamentoRuaClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlEnderecoRua = 'select * From EnderecamentoRuas';

type

  TEnderecoRuaDao = class(TBasicDao)
  private
    

    FEnderecoRua: TEnderecoRua;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    function GetId(pRuaId: String): TjSonArray;
    Function GetRua4D(const AParams: TDictionary<string, string>): TJsonObject;
    Function Delete: Boolean;
    Function GetEnderecoLado(pDescricao: String = ''; pLado: String = 'U';
      pShowErro: Integer = 1): TjSonArray;
    Property ObjEnderecoRua: TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
    Function Estrutura: TjSonArray;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TEnderecoRuaDao.Create;
begin
  ObjEnderecoRua := TEnderecoRua.Create;
  inherited;
end;

function TEnderecoRuaDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from EnderecamentoRuas where RuaId= ' +
      Self.ObjEnderecoRua.RuaId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: EnderecamentoRuas - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TEnderecoRuaDao.Destroy;
begin
  
  ObjEnderecoRua.Free;
  inherited;
end;

function TEnderecoRuaDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
  FIndexeXact: Integer;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('EnderecamentoRuas') +
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

function TEnderecoRuaDao.GetEnderecoLado(pDescricao, pLado: String;
  pShowErro: Integer): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
  EnderecoRuaDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEnderecoRua;
    if (pDescricao <> '') and (pLado <> '') then
      vSql := vSql + ' Where Descricao = ' + QuotedStr(pDescricao) +
        ' and Lado = ' + QuotedStr(pLado)
    Else If pDescricao <> '' then
      vSql := vSql + ' Where Descricao = ' + QuotedStr(pDescricao)
    Else If pLado <> '' then
      vSql := vSql + ' Where Lado = ' + QuotedStr(pLado);
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
      With ObjEnderecoRua do
      Begin
        RuaId := FConexao.Query.FieldByName('RuaId').AsInteger;
        Descricao := FConexao.Query.FieldByName('Descricao').AsString;
        Lado := FConexao.Query.FieldByName('Lado').AsString;
        Ordem := FConexao.Query.FieldByName('Ordem').AsInteger;
        Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoRua,
          [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: EnderecamentoRuas - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoRuaDao.GetId(pRuaId: String): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
  EnderecoRuaItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEnderecoRua;
    if pRuaId <> '0' then
      if StrToIntDef(pRuaId, 0) > 0 then
        vSql := vSql + ' Where RuaId = ' + pRuaId
      Else
        vSql := vSql + ' Where Descricao = ' + QuotedStr(pRuaId);
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
      With ObjEnderecoRua do
      Begin
        RuaId := FConexao.Query.FieldByName('RuaId').AsInteger;
        Descricao := FConexao.Query.FieldByName('Descricao').AsString;
        Lado := FConexao.Query.FieldByName('Lado').AsString;
        Ordem := FConexao.Query.FieldByName('Ordem').AsInteger;
        Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoRua,
          [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: EnderecamentoRuas - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoRuaDao.GetRua4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vParam: String;

begin
  Result := TJsonObject.Create();

  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.SQL.Add('select * From EnderecamentoRuas where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add
    ('Select Count(RuaId) cReg From EnderecamentoRuas where 1=1');
  if AParams.ContainsKey('ruaid') then
  begin
    QryPesquisa.SQL.Add('and Ruaid = :RuaId');
    QryPesquisa.ParamByName('RuaId').AsString := AParams.Items['ruaid'];
    QryRecordCount.SQL.Add('and RuaId = :RuaId');
    QryRecordCount.ParamByName('RuaId').AsString := AParams.Items['ruaid'];
  end;
  if AParams.ContainsKey('descricao') then
  begin
    vParam := '%' + AParams.Items['descricao'] + '%';
    QryPesquisa.SQL.Add('and Descricao Like :descricao');
    QryPesquisa.ParamByName('Descricao').AsString := vParam;
    QryRecordCount.SQL.Add('and Descricao like :Descricao');
    QryRecordCount.ParamByName('Descricao').AsString := vParam;
  end;
  if AParams.ContainsKey('limit') then
  begin
    QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    QryPesquisa.FetchOptions.RowsetSize :=
      StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    QryPesquisa.FetchOptions.RecsSkip :=
      StrToIntDef(AParams.Items['offset'], 0);
  QryPesquisa.SQL.Add('order by Descricao');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.ToJSONArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  
  
end;

function TEnderecoRuaDao.Salvar: Boolean;
var
  vSql: String;
  FIndexeXact: Integer;
begin
  try
    if Self.ObjEnderecoRua.RuaId = 0 then
       vSql := 'Insert Into EnderecamentoRuas (Descricao, Lado, Ordem, Status) Values ('+sLineBreak+
               QuotedStr(Self.ObjEnderecoRua.Descricao) + ', ' +QuotedStr(Self.ObjEnderecoRua.Lado)+ ', '+sLineBreak+
               Self.ObjEnderecoRua.Ordem.ToString() + ', 1)'
    Else
       vSql := ' Update EnderecamentoRuas '+sLineBreak+
               '    Set Descricao = '+QuotedStr(Self.ObjEnderecoRua.Descricao)+sLineBreak+
               '  , Lado          = '+QuotedStr(Self.ObjEnderecoRua.Lado)+sLineBreak+
               '  , Ordem         = '+Self.ObjEnderecoRua.Ordem.ToString()+sLineBreak+
               '   , Status = '+Self.ObjEnderecoRua.Status.ToString()+sLineBreak+
               ' where RuaId = '+Self.ObjEnderecoRua.RuaId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

Function TEnderecoRuaDao.TrataErroFireDac(pErro: EFDDBEngineException): String;
begin
  case pErro.Kind of
    ekOther:             Result := pErro.Message; // 'Operação com o Banco de Dados';
    ekNoDataFound:       Result := 'Erro! Dados não encontrados';
    ekTooManyRows:       Result := 'Excesso de Linhas';
    ekRecordLocked:      Result := 'Registro com acesso bloqueado. Pode está sendo usado por outro processo.';
    ekUKViolated:        Result := 'Tentativa de incluir registro já existente.';
    ekFKViolated:        Result := 'Cadastro primário necessário inexistente.';
    ekObjNotExists:      Result := 'Objeto não encontrado';
    ekUserPwdInvalid:    Result := 'Usuário e/ou Senha inválido.';
    ekUserPwdExpired:    Result := 'Usuário e/ou Senha expirou!';
    ekUserPwdWillExpire: Result := 'Usuário e/ou Senha prestes a expirar';
    ekCmdAborted:        Result := 'Operação cancelada.';
    ekServerGone:        Result := 'Servidor de Banco de Dados inexistente.';
    ekServerOutput:      Result := 'Servidor de Banco de Dados parece está fora do ar.';
    ekArrExecMalfunc:    Result := 'Operação mal sucedida.';
    ekInvalidParams:     Result := 'Parâmetros inválidos para esta operação.';
  end;
  Result := 'Tabela: EnderecamentoRuas - ' + StringReplace(Result, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]);
end;

end.
