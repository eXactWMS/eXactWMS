{
  Micro Servico - DAO - OperacaoNaturezaDAO
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.OperacaoNaturezaDAO;

interface

uses
  FireDAC.Comp.Client, OperacaoNaturezaClass, System.SysUtils,
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TOperacaoNaturezaDao = class(TBasicDao)
  private

  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Integer; pDescricao: AnsiString;
      pTipo: AnsiString): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pNome: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

uses uSistemaControl;

{ TtipooperacaoDao }

constructor TOperacaoNaturezaDao.Create;
begin
  inherited;
end;

function TOperacaoNaturezaDao.Delete(pId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from OperacaoNatureza where OperacaoNaturezaId = ' +
      pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TOperacaoNaturezaDao.Destroy;
begin

  inherited;
end;

function TOperacaoNaturezaDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('OperacaoNatureza') +
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
      vRegEstrutura.AddPair('tipo', LowerCase(FConexao.Query.FieldByName('Tipo')
        .AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TOperacaoNaturezaDao.GetDescricao(pNome: String): TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'select * from OperacaoNatureza where Descricao like ' +
      QuotedStr('%' + pNome + '%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TOperacaoNaturezaDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'select * from OperacaoNatureza'
    Else
      vSql := 'Select * from OperacaoNatureza where OperacaoNaturezaId = ' +
        pId.ToString;
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TOperacaoNaturezaDao.InsertUpdate(pId: Integer; pDescricao: AnsiString;
  pTipo: AnsiString): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'Insert Into OperacaoNatureza (Descricao, Tipo) Values (' +
        QuotedStr(pDescricao) + ', ' + QuotedStr(pTipo) + ')'
    Else
      vSql := 'Update OperacaoNatureza Set' + '    Descricao = ' +
        QuotedStr(pDescricao) + '    , Tipo = ' + QuotedStr(pTipo) +
        'where Id = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
