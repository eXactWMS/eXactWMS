unit MService.NovidadesDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.JSON, Math, Generics.Collections,
  exactwmsservice.lib.connection,exactwmsservice.dao.base,
  exactwmsservice.lib.utils;

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

//uses uSistemaControl;

{ TNovidadesDao }

constructor TNovidadesDao.Create;
begin
  inherited;
end;

function TNovidadesDao.Delete(pNovidadeId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    try
      vSql := 'Delete from Novidades where NovidadeId = ' + pNovidadeId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      raise Exception.Create('Processo: Novidades/Delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TNovidadesDao.destroy;
begin
  inherited;
end;

function TNovidadesDao.Get(const AParams: TDictionary<string, string>)
  : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('select novidadeid, FORMAT(Data, ' + #39 + 'dd/MM/yyyy' + #39 +
        ') data, versao, texto, status from Novidades');
      Query.Sql.Add('Where 1 = 1');
      if AParams.ContainsKey('novidadeid') then
        Query.Sql.Add('and Novidadeid = ' + AParams.Items['novidadeid']);
      if AParams.ContainsKey('versao') then
        Query.Sql.Add('and versao = ' + QuotedStr(AParams.Items['novidadeid']));
      if AParams.ContainsKey('status') then
        Query.Sql.Add('and Status = ' + AParams.Items['status']);
      Query.Sql.Add('Order by NovidadeId Desc' );
      if DebugHook <> 0 then
        Query.Sql.SaveToFile('Novidades.Sql');
      Query.Open;
      if Query.IsEmpty Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Novidades/Get - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TNovidadesDao.GetNews(const AParams: TDictionary<string, string>) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('select novidadeid, FORMAT(Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') data, versao, texto, status from Novidades');
      Query.Sql.Add('Where Status = 1');
      Query.Sql.Add('Order by NovidadeId Desc' );
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('News.Sql');
      Query.Open;
      if Query.IsEmpty Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Novidades/GetNews - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TNovidadesDao.InsertUpdate(pJsonNovidades: TJsonObject): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('UpdNovidades.Sql');
      Query.ExecSQL;
      Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Novidades/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
