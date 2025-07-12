{
  Micro Servico - DAO - tipomovimentacaoDAO
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.OperacaoTipoDAO;

interface

uses FireDAC.Comp.Client, OperacaoTipoClass, System.SysUtils,
  DataSet.Serialize, System.JSON, REST.JSON, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TOperacaoTipoDao = class(TBasicDao)
  private
    

  public
    constructor Create; overload;
    destructor destroy; override;

    function InsertUpdate(pId: Integer; pDescricao: AnsiString;
      pIdTipoOperacao: Integer; pStatus: Integer): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pNome: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

uses uSistemaControl;

{ TOperacaoTipoDao }

constructor TOperacaoTipoDao.Create;
begin
  inherited;
end;

function TOperacaoTipoDao.Delete(pId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from OperacaoTipo where OperacaoTipoId = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TOperacaoTipoDao.destroy;
begin
  
  inherited;
end;

function TOperacaoTipoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('OperacaoTipo') +
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

function TOperacaoTipoDao.GetDescricao(pNome: String): TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'select * from OperacaoTipo where Descricao like ' +
      QuotedStr('%' + pNome + '%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TOperacaoTipoDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'select * from OperacaoTipo'
    Else
      vSql := 'Select * from OperacaoTipo where OperacaoTipoId = ' +
        pId.ToString;
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TOperacaoTipoDao.InsertUpdate(pId: Integer; pDescricao: AnsiString;
  pIdTipoOperacao: Integer; pStatus: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'Insert Into OperacaoTipo (Descricao, OperacaoNaturezaId, Status) Values ('
        + QuotedStr(pDescricao) + ', ' + pIdTipoOperacao.ToString() + ', ' +
        pStatus.ToString() + ')'
    Else
      vSql := 'Update OperacaoTipo Set Descricao = ' + QuotedStr(pDescricao) +
        '     , OperacaoNaturezaId = ' + pIdTipoOperacao.ToString() +
        '     , Status = ' + pStatus.ToString() + 'where OperacaoTipoId = ' +
        pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
