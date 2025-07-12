unit MService.EnderecoTipoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  PessoaClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type

  TEnderecoTipoDao = class(TBasicDao)
  private
    

    FEnderecoTipo: TEnderecoTipo;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    function GetId(pEnderecoTipoId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Property ObjEnderecoTipo: TEnderecoTipo Read FEnderecoTipo
      Write FEnderecoTipo;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TEnderecoTipoDao.Create;
begin
  ObjEnderecoTipo := TEnderecoTipo.Create;
  inherited;
end;

function TEnderecoTipoDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from EnderecoTipo where EnderecoTipoId = ' +
      Self.ObjEnderecoTipo.EnderecoTipoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: EnderecoTipo - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TEnderecoTipoDao.Destroy;
begin
  ObjEnderecoTipo.free;
  inherited;
end;

function TEnderecoTipoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('EnderecoTipo') +
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

function TEnderecoTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var
  ObjJson: TJsonObject;
  EnderecoTipoItensDAO: TjSonArray;
begin
  try
    Result := TJsonArray.Create;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEnderecoTipo);
    FConexao.Query.ParamByName('pEnderecoTipoId').Value := 0;
    FConexao.Query.ParamByName('pDescricao').Value := pDescricao;
    FConexao.Query.Open;
    while Not FConexao.Query.Eof do
      With ObjEnderecoTipo do
      Begin
        ObjJson := TJsonObject.Create;
        With ObjJson do
        Begin
          AddPair('enderecotipoid',
            TJsonNumber.Create(FConexao.Query.FieldByName('EnderecoTipoId').AsInteger));
          AddPair('descricao', FConexao.Query.FieldByName('Descricao').AsString);
          AddPair('status', TJsonNumber.Create(FConexao.Query.FieldByName('Status')
            .AsInteger));
          Result.AddElement(ObjJson);
          // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
        End;
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: EnderecoTipo - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoTipoDao.GetId(pEnderecoTipoId: Integer): TjSonArray;
var
  ObjJson: TJsonObject;
  EnderecoTipoItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEnderecoTipo);
    FConexao.Query.ParamByName('pEnderecoTipoId').Value := pEnderecoTipoId;
    FConexao.Query.ParamByName('pDescricao').Value := '';
    FConexao.Query.Open;
    while Not FConexao.Query.Eof do
      With ObjEnderecoTipo do
      Begin
        ObjJson := TJsonObject.Create;
        With ObjJson do
        Begin
          AddPair('enderecotipoid',
            TJsonNumber.Create(FConexao.Query.FieldByName('EnderecoTipoId').AsInteger));
          AddPair('descricao', FConexao.Query.FieldByName('Descricao').AsString);
          AddPair('status', TJsonNumber.Create(FConexao.Query.FieldByName('Status')
            .AsInteger));
          Result.AddElement(ObjJson);
          // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
        End;
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: EnderecoTipo - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoTipoDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.ObjEnderecoTipo.EnderecoTipoId = 0 then
      vSql := 'Insert Into EnderecoTipo (Descricao, Status) Values (' +
        QuotedStr(Self.ObjEnderecoTipo.Descricao) + ', ' +
        Self.ObjEnderecoTipo.Status.ToString() + ')'
    Else
      vSql := ' Update EnderecoTipo ' + '   Set Descricao = ' +
        QuotedStr(Self.ObjEnderecoTipo.Descricao) + '      , Status   = ' +
        Self.ObjEnderecoTipo.Status.ToString() + ' where EnderecoTipoId = ' +
        Self.ObjEnderecoTipo.EnderecoTipoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

Function TEnderecoTipoDao.TrataErroFireDac(pErro: EFDDBEngineException): String;
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
