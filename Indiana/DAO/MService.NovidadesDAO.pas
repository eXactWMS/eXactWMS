unit MService.NovidadesDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.JSON, Math, Generics.Collections,
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TNovidadesDao = class(TBasicDao)
  private
    

  public
    constructor Create; overload;
    destructor destroy; override;

    function InsertUpdate(pJsonNovidades: TJsonObject): TjSonArray;
    function Get(const AParams: TDictionary<string, string>): TjSonArray;
    function GetNews(const AParams: TDictionary<string, string>): TjSonArray;
    Function Delete(pNovidadeId: Integer): Boolean;
  end;

implementation

uses uSistemaControl;

{ TNovidadesDao }

constructor TNovidadesDao.Create;
begin
  inherited;
end;

function TNovidadesDao.Delete(pNovidadeId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Novidades where NovidadeId = ' + pNovidadeId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TNovidadesDao.destroy;
begin
  
  inherited;
end;

function TNovidadesDao.Get(const AParams: TDictionary<string, string>)
  : TjSonArray;
begin
  try
    FConexao.Query.Sql.Add('select novidadeid, FORMAT(Data, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') data, versao, texto, status from Novidades');
    FConexao.Query.Sql.Add('Where 1 = 1');
    if AParams.ContainsKey('novidadeid') then
      FConexao.Query.Sql.Add('and Novidadeid = ' + AParams.Items['novidadeid']);
    if AParams.ContainsKey('versao') then
      FConexao.Query.Sql.Add('and versao = ' + QuotedStr(AParams.Items['novidadeid']));
    if AParams.ContainsKey('status') then
      FConexao.Query.Sql.Add('and Status = ' + AParams.Items['status']);
    FConexao.Query.Sql.Add('Order by NovidadeId Desc' );
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('Novidades.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Novidades - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TNovidadesDao.GetNews(const AParams: TDictionary<string, string>)
  : TjSonArray;
begin
  try
    FConexao.Query.Sql.Add('select novidadeid, FORMAT(Data, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') data, versao, texto, status from Novidades');
    FConexao.Query.Sql.Add('Where Status = 1');
    FConexao.Query.Sql.Add('Order by NovidadeId Desc' );
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('News.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Novidades - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TNovidadesDao.InsertUpdate(pJsonNovidades: TJsonObject): TjSonArray;
begin
  Try
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('UpdNovidades.Sql');

    FConexao.Query.ExecSQL;
    Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
