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
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Integer; pDescricao: String; pStatus: Integer) : TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function GetDesenhoArmazem4D(const AParams: TDictionary<string, string>) : TJsonObject;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

uses Constants;  //uSistemaControl,

{ TClienteDao }

constructor TDesenhoArmazemDao.Create;
begin
  inherited;
end;

function TDesenhoArmazemDao.Delete(pId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    vSql := 'Delete from DesenhoArmazem where Id = ' + pId.ToString;
    Query.ExecSQL(vSql);
    Result := True;
    Query.Close;
  finally
    Query.Free;
  end;
end;

destructor TDesenhoArmazemDao.Destroy;
begin

  inherited;
end;

function TDesenhoArmazemDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Try
    Query := TFDQuery.Create(nil);
    Try
      Query.Connection := Connection;
      Result := TjSonArray.Create;
      Query.Open
        ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
        'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
        'Where TABLE_NAME = ' + QuotedStr('DesenhoArmazem') +' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
      if Query.IsEmpty Then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
      Else
      Begin
        While Not Query.Eof do
        Begin
          vRegEstrutura := TJsonObject.Create;
          vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
          vRegEstrutura.AddPair('tipo',   LowerCase(Query.FieldByName('Tipo').AsString));
          vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
          Result.AddElement(vRegEstrutura);
          Query.Next;
        End;
      End;
    Except ON E: Exception do
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TDesenhoArmazemDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select * from DesenhoArmazem where Descricao like ' + QuotedStr('%' + pDescricao + '%');
      Query.Open(vSql);
      if Query.IsEmpty then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', tUevolutConst.QrySemDados));
      End
      Else
        Result := Query.toJsonArray;
    Except
      On E: Exception do
        raise Exception.Create(E.Message);
    end;
  Finally
    Query.Free;
  End;
end;

function TDesenhoArmazemDao.GetDesenhoArmazem4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
    vParam: String;
begin
  Try
    Result := TJsonObject.Create();
    QryPesquisa := TFDQuery.Create(nil);
    QryPesquisa.Connection := Connection;
    QryPesquisa.SQL.Add('select * From DesenhoArmazem where 1 = 1');
    QryRecordCount := TFDQuery.Create(nil);
    QryRecordCount.Connection := Connection;
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
  Finally
   QryPesquisa.Free;
   QryRecordCount.Free;
  End;
end;

function TDesenhoArmazemDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
        vSql := 'select * from DesenhoArmazem'
      Else
        vSql := 'select * from DesenhoArmazem where Id = ' + pId.ToString;
      Query.Open(vSql);
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', tUevolutConst.QrySemDados));
      End
      Else
        Result := Query.toJsonArray;
    Except
      On E: Exception do
        raise Exception.Create(E.Message);
    end;
  Finally
   Query.Free;
  End;
end;

function TDesenhoArmazemDao.InsertUpdate(pId: Integer; pDescricao: String;
  pStatus: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
        vSql := 'Insert Into DesenhoArmazem (Descricao, Status) Values (' +
          QuotedStr(pDescricao) + ', ' + pStatus.ToString() + ')'
      Else
        vSql := 'Update DesenhoArmazem ' + '    Set Descricao = ' + QuotedStr(pDescricao) + ', Status   = ' + pStatus.ToString() + ' where Id = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except
      On E: Exception do
        raise Exception.Create(E.Message);
    end;
  Finally
   Query.Free;
  End;
end;

end.
