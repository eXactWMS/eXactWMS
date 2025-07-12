unit MService.UnidadeDAO;

interface

uses
  FireDAC.Comp.Client, UnidadeClass, System.SysUtils,
  DataSet.Serialize,
  System.JSON, REST.JSON, Generics.Collections, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TUnidadeDao = class(TBasicDao)
  private

  public
    constructor Create; overload;
    destructor destroy; override;
    function InsertUpdate(pId: Integer; pSigla, pDescricao: String; pStatus: Integer): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pNome: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function GetUnidade4D(const AParams: TDictionary<string, string>) : TJsonObject;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TUnidadeDao.Create;
begin
  inherited;
end;

function TUnidadeDao.Delete(pId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Unidades where Id = ' + pId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TUnidadeDao.destroy;
begin

  inherited;
end;

function TUnidadeDao.GetDescricao(pNome: String): TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'select * from Unidades where Descricao like ' +
      QuotedStr('%' + pNome + '%');
    Fconexao.Query.Open(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TUnidadeDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'select * from Unidades'
    Else
      vSql := 'select * from Unidades where Id = ' + pId.ToString;
    Fconexao.Query.Open(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TUnidadeDao.GetUnidade4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vSql: String;

begin
  Try
    vSql := 'select * From Unidades Where 1 = 1';
    Result := TJsonObject.Create();

    QryPesquisa := Fconexao.GetQuery;
    QryPesquisa.SQL.Add(vSql);
    QryRecordCount := Fconexao.GetQuery;
    QryRecordCount.SQL.Add('Select Count(Id) cReg From Unidades Where 1 =1');
    if AParams.ContainsKey('unidadeid') then
    begin
      QryPesquisa.SQL.Add('and Id = :UnidadeId');
      QryPesquisa.ParamByName('UnidadeId').AsLargeInt :=
        AParams.Items['unidadeid'].ToInt64;
      QryRecordCount.SQL.Add('and Id = :UnidadeId');
      QryRecordCount.ParamByName('UnidadeId').AsLargeInt :=
        AParams.Items['unidadeid'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then
    begin
      QryPesquisa.SQL.Add('and (descricao like :descricao))');
      QryPesquisa.ParamByName('descricao').AsString := '%' + AParams.Items
        ['descricao'].ToLower + '%';
      QryRecordCount.SQL.Add('and (Descricao like :Descricao))');
      QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items
        ['descricao'].ToLower + '%';
    end;
    if AParams.ContainsKey('limit') then
    begin
      QryPesquisa.FetchOptions.RecsMax :=
        StrToIntDef(AParams.Items['limit'], 50);
      QryPesquisa.FetchOptions.RowsetSize :=
        StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
      QryPesquisa.FetchOptions.RecsSkip :=
        StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by Id');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.toJsonArray());
    QryRecordCount.Open();
    Result.AddPair('records',
      TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));

  Except
    On E: Exception do
      raise Exception.Create('Tabela Unidades: ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
  End;
end;

function TUnidadeDao.InsertUpdate(pId: Integer; pSigla, pDescricao: String;
  pStatus: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'Insert Into Unidades (Sigla,Descricao, Status) Values (' +
        QuotedStr(pSigla) + ', ' + QuotedStr(pDescricao) + ', ' +
        pStatus.ToString() + ')'
    Else
      vSql := 'Update Unidade ' + '    Set Sigla = ' + QuotedStr(pSigla) +
        '        ,Descricao = ' + QuotedStr(pDescricao) + '        ,Status   = '
        + pStatus.ToString() + 'where Id = ' + pId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
