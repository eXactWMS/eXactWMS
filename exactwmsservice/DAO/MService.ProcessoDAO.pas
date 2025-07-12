unit MService.ProcessoDAO;

interface

uses
  FireDAC.Comp.Client, ProcessoClass, System.SysUtils,
  DataSet.Serialize,
  System.JSON, REST.JSON, System.Generics.Collections,
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TProcessoDao = class(TBasicDao)
  private

    
    ObjProcessoDAO: TProcesso;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Int64; pDescricao, pProcesso: String;
      pStatus: Integer): TjSonArray;
    function GetId(pId: Int64): TjSonArray;
    Function Get4D(const AParams: TDictionary<string, string>): TjSonObject;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pId: Int64): Boolean;
  end;

Const
  vcSql = 'select * from ProcessoEtapas P ';

implementation

uses uSistemaControl;

{ TProcessoDao }

constructor TProcessoDao.Create;
begin
  ObjProcessoDAO := TProcesso.Create;
  inherited;
end;

function TProcessoDao.Delete(pId: Int64): Boolean;
var vSql: String;
begin
  Result := False;
  vSql := 'Delete from ProcessoEtapas where ProcessoId = ' + pId.ToString;
  FConexao.Query.ExecSQL(vSql);
  Result := True;
end;

destructor TProcessoDao.Destroy;
begin
  FreeAndNil(ObjProcessoDAO);
  inherited;
end;

function TProcessoDao.Get4D(const AParams: TDictionary<string, string>) : TjSonObject;
Var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Try
    Result := TjSonObject.Create();
    QryPesquisa := FConexao.GetQuery;
    QryPesquisa.SQL.Add('Select * From ProcessoEtapas where 1 = 1');
    QryRecordCount := FConexao.GetQuery;
    QryRecordCount.SQL.Add
      ('Select Count(ProcessoId) cReg From ProcessoEtapas where 1=1');
    if AParams.ContainsKey('id') then
    Begin
      QryPesquisa.SQL.Add('and ProcessoId = :id');
      QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
      QryRecordCount.SQL.Add('and ProcessoId = :id');
      QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then
    begin
      QryPesquisa.SQL.Add('and descricao like :descricao');
      QryPesquisa.ParamByName('descricao').AsString := '%' + AParams.Items
        ['descricao'].ToLower + '%';
      QryRecordCount.SQL.Add('and descricao like :descricao');
      QryRecordCount.ParamByName('descricao').AsString := '%' + AParams.Items
        ['descricao'].ToLower + '%';
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
      QryRecordCount.FetchOptions.RecsMax :=
        StrToIntDef(AParams.Items['limit'], 50);
      QryRecordCount.FetchOptions.RowsetSize :=
        StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
    Begin
      QryPesquisa.FetchOptions.RecsSkip :=
        StrToIntDef(AParams.Items['offset'], 0);
      QryRecordCount.FetchOptions.RecsSkip :=
        StrToIntDef(AParams.Items['offset'], 0);
    End;
    QryPesquisa.SQL.Add('order by processoid');
    if DebugHook <> 0 then
      QryPesquisa.SQL.SaveToFile('ProcessoEtapas.Sql');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.ToJSONArray());
    QryRecordCount.Open();
    Result.AddPair('records',
      TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Close;
    QryRecordCount.Close;
  End;
end;

function TProcessoDao.GetDescricao(pDescricao: String): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := 'select * from ProcessoEtapas P';
    vSql := vSql + ' where (P.Descricao like ' + #39 + '%' + pDescricao + '%' +
      #39 + ')';
    // vSql := vSql + ' where (P.Descricao like '+QuotedStr('%'+pDescricao+'%')+') or '+
    // '(P.Processo like '+QuotedStr('%'+pDescricao+'%')+')';
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      ObjProcessoDAO.Id := FConexao.Query.FieldByName('ProcessoId').AsLargeInt;
      ObjProcessoDAO.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
      ObjProcessoDAO.Status := 1; // FConexao.Query.FieldByName('Status').Asinteger;
      Result.Add(tJson.ObjectToJsonObject(ObjProcessoDAO));
      // (ObjProcessoDAO.ClassToJson(ObjProcessoDAO).ToString);
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TProcessoDao.GetId(pId: Int64): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := vcSql;
    if pId <> 0 then
      vSql := vSql + ' Where P.ProcessoId = ' + pId.ToString;
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      ObjProcessoDAO.Id := FConexao.Query.FieldByName('ProcessoId').AsLargeInt;
      ObjProcessoDAO.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
      ObjProcessoDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjProcessoDAO));
      // (ObjProcessoDAO.ClassToJson(ObjProcessoDAO).ToString);
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TProcessoDao.InsertUpdate(pId: Int64; pDescricao, pProcesso: String;
  pStatus: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pId = 0 then
      vSql := 'Insert Into ProcessoEtapas (Descricao, Processo ) Values (' +
        sLineBreak + QuotedStr(pDescricao) + ', ' + QuotedStr(pProcesso) + ')'
    Else
      vSql := 'Update ProcessoEtapas Set Descricao = ' + QuotedStr(pDescricao) +
        sLineBreak + '       , Status = ' + pStatus.ToString + sLineBreak +
        'where ProcessoId = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
