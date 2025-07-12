unit uLaboratorioDAO;

interface

uses
  FireDAC.Comp.Client, LaboratoriosClass, System.SysUtils, DataSet.Serialize,
  System.Generics.Collections, System.JSON, REST.JSON, Web.HTTPApp,
  exactwmsservice.lib.connection, exactwmsservice.dao.base;

type
  TLaboratorioDao = class(TBasicDao)
  private
    FLaboratorio: TLaboratorio;
    
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Integer; pNome, pFone, pEmail, pHomePage: String;
      pStatus: Integer): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetId4D(const AParams: TDictionary<string, string>): TJsonObject;
    function GetDescricao(pNome: String): TjSonArray;
    Function GetLaboratorio(pIdLaboratorio: Integer = 0; pNome: String = '';
      pShowErro: Integer = 1): TjSonArray;
    Function Delete: Boolean;
    Function Salvar: Boolean;
    Function MontarPaginacao: TJsonObject;
    Function Estrutura: TjSonArray;
    Function Import(pJsonArray: TjSonArray): TjSonArray;
    Function ImportDados(pJsonArray: TjSonArray): TjSonArray;
  
    Property Laboratorio: TLaboratorio Read FLaboratorio Write FLaboratorio;
  end;

implementation

uses uSistemaControl, Constants, exactwmsservice.lib.utils;

{ TClienteDao }

constructor TLaboratorioDao.Create;
begin
  Laboratorio := TLaboratorio.Create;
  inherited;
end;

function TLaboratorioDao.Delete: Boolean;
var
  vSql: String;
Begin
  Result := False;
  try
    vSql := 'Delete from Laboratorios where IdLaboratorio = ' +
      Self.Laboratorio.IdLaboratorio.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TLaboratorioDao.Destroy;
begin
  Laboratorio.Free;
  inherited;
end;

function TLaboratorioDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Laboratorios') +
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

function TLaboratorioDao.GetDescricao(pNome: String): TjSonArray;
var
  vSql: String;
Begin
  try
    vSql := 'select * from Laboratorios where nome like ' +
      QuotedStr('%' + pNome + '%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TLaboratorioDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
Begin
  Result := TjSonArray.Create;
  try
    if pId = 0 then
      vSql := 'select * from Laboratorios'
    Else
      vSql := 'select * from Laboratorios where IdLaboratorio = ' +
        pId.ToString;
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      Laboratorio.IdLaboratorio := FConexao.Query.FieldByName('IdLaboratorio')
        .AsInteger;
      Laboratorio.Nome := FConexao.Query.FieldByName('Nome').AsString;
      Laboratorio.Fone := FConexao.Query.FieldByName('Fone').AsString;
      Laboratorio.Email := FConexao.Query.FieldByName('Email').AsString;
      Laboratorio.HomePage := FConexao.Query.FieldByName('HomePage').AsString;
      Laboratorio.Status := FConexao.Query.FieldByName('Status').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(Laboratorio));
      FConexao.Query.Next;
    End;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

Function TLaboratorioDao.ImportDados(pJsonArray: TjSonArray): TjSonArray;
var
  vSql: String;
  xFabr: Integer;
Begin
  Result := TjSonArray.Create();
  For xFabr := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add(tuEvolutConst.SqlInsFabricante);
      FConexao.Query.ParamByName('pCodERP').Value := pJsonArray.Items[xFabr]
        .GetValue<Integer>('fabricanteid');
      FConexao.Query.ParamByName('pNome').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('nome');
      FConexao.Query.ParamByName('pFone').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('fone');
      FConexao.Query.ParamByName('pEmail').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('email');
      FConexao.Query.ParamByName('pHomepage').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('homepage');
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('LaboratorioImporta.Sql');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Cadastro de produto ' + pJsonArray.Items[xFabr].GetValue<Integer>
        ('fabricanteid').ToString + ' realizado com sucesso!'));
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  End;
End;

function TLaboratorioDao.GetId4D(const AParams: TDictionary<string, string>) : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
Begin
  Result := TJsonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.SQL.Add('Select * From Laboratorios where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add
    ('Select Count(IdLaboratorio) cReg From Laboratorios where 1=1');
  if AParams.ContainsKey('id') then
  begin
    QryPesquisa.SQL.Add('and IdLaboratorio = :id');
    QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    QryRecordCount.SQL.Add('and IdLaboratorio = :id');
    QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;
  if AParams.ContainsKey('razao') then
  begin
    QryPesquisa.SQL.Add('and razao like :razao');
    QryPesquisa.ParamByName('razao').AsString := '%' + AParams.Items['razao']
      .ToLower + '%';
    QryRecordCount.SQL.Add('and razao like :razao');
    QryRecordCount.ParamByName('razao').AsString := '%' + AParams.Items['razao']
      .ToLower + '%';
  end;
  if AParams.ContainsKey('status') then
  begin
    QryPesquisa.SQL.Add('and Status = :Status');
    QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status']
      .ToInteger;
    QryRecordCount.SQL.Add('and Status = :Status');
    QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status']
      .ToInteger;
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
  QryPesquisa.SQL.Add('order by IdLaboratorio');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.toJsonArray());
  QryRecordCount.Open();
  Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));


end;

function TLaboratorioDao.GetLaboratorio(pIdLaboratorio: Integer; pNome: String;
  pShowErro: Integer): TjSonArray;
begin
  //
end;

function TLaboratorioDao.Import(pJsonArray: TjSonArray): TjSonArray;
Var
  xFabr: Integer;
Begin
  Result := TjSonArray.Create();
  For xFabr := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add(tuEvolutConst.SqlInsFabricante);
      FConexao.Query.ParamByName('pCodERP').Value := pJsonArray.Items[xFabr]
        .GetValue<Integer>('idlaboratorio');
      FConexao.Query.ParamByName('pNome').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('nome');
      FConexao.Query.ParamByName('pFone').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('fone');
      FConexao.Query.ParamByName('pEmail').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('email');
      FConexao.Query.ParamByName('pHomepage').Value := pJsonArray.Items[xFabr]
        .GetValue<String>('homepage');
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('LaboratorioImporta.Sql');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Cadastro de Fabricante ' + pJsonArray.Items[xFabr].GetValue<Integer>
        ('fabricanteid').ToString + ' realizado com sucesso!'));
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  End;
end;

function TLaboratorioDao.InsertUpdate(pId: Integer;
  pNome, pFone, pEmail, pHomePage: String; pStatus: Integer): TjSonArray;
var
  vSql: String;
Begin
  try
    if pId = 0 then
      vSql := 'Insert Into Laboratorios (Nome, Fone, Email, HomePage, Status) Values ('
        + QuotedStr(pNome) + ', ' + QuotedStr(pFone) + ', ' + QuotedStr(pEmail)
        + ', ' + QuotedStr(pHomePage) + ', ' + pStatus.ToString() + ')'
    Else
      vSql := 'Update Laboratorios ' + '    Set Nome = ' + QuotedStr(pNome) +
        '        ,Fone = ' + QuotedStr(pFone) + '        ,Email = ' +
        QuotedStr(pEmail) + '        ,HomePage = ' + QuotedStr(pHomePage) +
        '        ,Status   = ' + pStatus.ToString() + 'where IdLaboratorio = ' +
        pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TLaboratorioDao.MontarPaginacao: TJsonObject;
var
  vSql: String;
Begin
  Result := TJsonObject.Create;
  try
    FConexao.Query.Open('Select Count(*) Paginacao From Laboratorios');
    Result.AddPair('paginacao',
      TJsonNumber.Create(FConexao.Query.FieldByName('Paginacao').AsInteger));
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', E.Message);
    End;
  end;
end;

function TLaboratorioDao.Salvar: Boolean;
var
  vSql: String;
Begin
  Result := False;
  try
    if Self.Laboratorio.IdLaboratorio = 0 then
      vSql := 'Insert Into Laboratorios (Nome, Fone, Email, HomePage, Status) Values ('
        + QuotedStr(Self.Laboratorio.Nome) + ', ' +
        QuotedStr(Self.Laboratorio.Fone) + ', ' +
        QuotedStr(Self.Laboratorio.Email) + ', ' +
        QuotedStr(Self.Laboratorio.HomePage) + ', 1)'
    Else
      vSql := 'Update Laboratorios ' + '    Set Nome = ' +
        QuotedStr(Self.Laboratorio.Nome) + '        ,Fone = ' +
        QuotedStr(Self.Laboratorio.Fone) + '        ,Email = ' +
        QuotedStr(Self.Laboratorio.Email) + '        ,HomePage = ' +
        QuotedStr(Self.Laboratorio.HomePage) + '        ,Status   = ' +
        Self.Laboratorio.Status.ToString() + 'where IdLaboratorio = ' +
        Self.Laboratorio.IdLaboratorio.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
