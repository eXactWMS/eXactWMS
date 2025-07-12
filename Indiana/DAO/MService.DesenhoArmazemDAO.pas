unit MService.DesenhoArmazemDAO;

interface

uses
  FireDAC.Comp.Client, DesenhoArmazemClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.connection,
  System.JSON, REST.JSON, Generics.Collections, exactwmsservice.dao.base;

type
  TDesenhoArmazemDao = class(TBasicDao)
  private

  public

    function InsertUpdate(pId: Integer; pDescricao: String; pStatus: Integer)
      : TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function GetDesenhoArmazem4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TDesenhoArmazemDao.Delete(pId: Integer): Boolean;
var
  VQry: TFDQuery;
  vSql: String;

begin
  Result := False;
  try
    VQry := FConexao.GetQuery;
    vSql := 'Delete from DesenhoArmazem where Id = ' + pId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally


  end;
end;

function TDesenhoArmazemDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('DesenhoArmazem') +
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

function TDesenhoArmazemDao.GetDescricao(pDescricao: String): TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'select * from DesenhoArmazem where Descricao like ' +
      QuotedStr('%' + pDescricao + '%');
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        tUevolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TDesenhoArmazemDao.GetDesenhoArmazem4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vParam: String;

begin
  Result := TJsonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.SQL.Add('select * From DesenhoArmazem where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add('Select Count(id) cReg From DesenhoArmazem where 1=1');
  if AParams.ContainsKey('id') then
  begin
    QryPesquisa.SQL.Add('and id = :Id');
    QryPesquisa.ParamByName('Id').AsString := AParams.Items['id'];
    QryRecordCount.SQL.Add('and Id = :Id');
    QryRecordCount.ParamByName('Id').AsString := AParams.Items['id'];
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
  Result.AddPair('data', QryPesquisa.toJsonArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  QryPesquisa.Close;
  
  QryRecordCount.Close;
  
end;

function TDesenhoArmazemDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'select * from DesenhoArmazem'
    Else
      vSql := 'select * from DesenhoArmazem where Id = ' + pId.ToString;
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        tUevolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TDesenhoArmazemDao.InsertUpdate(pId: Integer; pDescricao: String;
  pStatus: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'Insert Into DesenhoArmazem (Descricao, Status) Values (' +
        QuotedStr(pDescricao) + ', ' + pStatus.ToString() + ')'
    Else
      vSql := 'Update DesenhoArmazem ' + '    Set Descricao = ' +
        QuotedStr(pDescricao) + ', Status   = ' + pStatus.ToString() +
        ' where Id = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
