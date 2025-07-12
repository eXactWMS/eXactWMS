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

uses Constants, exactwmsservice.lib.utils; //uSistemaControl,

{ TClienteDao }

constructor TLaboratorioDao.Create;
begin
  Laboratorio := TLaboratorio.Create;
  inherited;
end;

function TLaboratorioDao.Delete: Boolean;
var vSql: String;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    try
      vSql := 'Delete from Laboratorios where IdLaboratorio = ' + Self.Laboratorio.IdLaboratorio.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      raise Exception.Create('Processo: Laboratorio/delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TLaboratorioDao.Destroy;
begin
  Laboratorio.Free;
  inherited;
end;

function TLaboratorioDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('Laboratorios') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do Begin
        vRegEstrutura := TJsonObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TLaboratorioDao.GetDescricao(pNome: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select * from Laboratorios where nome like ' + QuotedStr('%' + pNome + '%');
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
        raise Exception.Create('Processo: Laboratorio/Descricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TLaboratorioDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'select * from Laboratorios'
      Else
        vSql := 'select * from Laboratorios where IdLaboratorio = ' + pId.ToString;
      Query.Open(vSql);
      while Not Query.Eof do Begin
        Laboratorio.IdLaboratorio := Query.FieldByName('IdLaboratorio').AsInteger;
        Laboratorio.Nome := Query.FieldByName('Nome').AsString;
        Laboratorio.Fone := Query.FieldByName('Fone').AsString;
        Laboratorio.Email := Query.FieldByName('Email').AsString;
        Laboratorio.HomePage := Query.FieldByName('HomePage').AsString;
        Laboratorio.Status := Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(Laboratorio));
        Query.Next;
      End;
    Except On E: Exception do
        raise Exception.Create('Processo: Fabricante/Id - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

Function TLaboratorioDao.ImportDados(pJsonArray: TjSonArray): TjSonArray;
var vSql: String;
    xFabr: Integer;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    For xFabr := 0 to Pred(pJsonArray.Count) do Begin
      Try
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add(tuEvolutConst.SqlInsFabricante);
        Query.ParamByName('pCodERP').Value := pJsonArray.Items[xFabr].GetValue<Integer>('fabricanteid');
        Query.ParamByName('pNome').Value := pJsonArray.Items[xFabr].GetValue<String>('nome');
        Query.ParamByName('pFone').Value := pJsonArray.Items[xFabr].GetValue<String>('fone');
        Query.ParamByName('pEmail').Value := pJsonArray.Items[xFabr].GetValue<String>('email');
        Query.ParamByName('pHomepage').Value := pJsonArray.Items[xFabr].GetValue<String>('homepage');
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('LaboratorioImporta.Sql');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cadastro de produto ' + pJsonArray.Items[xFabr]
              .GetValue<Integer>('fabricanteid').ToString + ' realizado com sucesso!'));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: ImportaDados - '+TUtil.TratarExcessao(E.Message)));
        End;
      End;
    End;
  Finally
    QUery.Free;
  End;
End;

function TLaboratorioDao.GetId4D(const AParams: TDictionary<string, string>) : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
Begin
  Result := TJsonObject.Create();
  QryPesquisa    := TFdQuery.Create(nil);
  QryRecordCount := TFdQuery.Create(nil);
  Try
    QryPesquisa.Connection    := Connection;
    QryRecordCount.Connection := Connection;
    QryPesquisa.SQL.Add('Select * From Laboratorios where 1 = 1');
    QryRecordCount.SQL.Add('Select Count(IdLaboratorio) cReg From Laboratorios where 1=1');
    if AParams.ContainsKey('id') then begin
       QryPesquisa.SQL.Add('and IdLaboratorio = :id');
       QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
       QryRecordCount.SQL.Add('and IdLaboratorio = :id');
       QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    end;
    if AParams.ContainsKey('nome') then begin
       QryPesquisa.SQL.Add('and nome like :nome');
       QryPesquisa.ParamByName('Nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
       QryRecordCount.SQL.Add('and nome like :nome');
       QryRecordCount.ParamByName('Nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
    end;
    if AParams.ContainsKey('status') then begin
       QryPesquisa.SQL.Add('and Status = :Status');
       QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status'].ToInteger;
       QryRecordCount.SQL.Add('and Status = :Status');
       QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status'].ToInteger;
    end;
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by IdLaboratorio');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.toJsonArray());
    QryRecordCount.Open();
    Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TLaboratorioDao.GetLaboratorio(pIdLaboratorio: Integer; pNome: String;
  pShowErro: Integer): TjSonArray;
begin
  //
end;

function TLaboratorioDao.Import(pJsonArray: TjSonArray): TjSonArray;
Var xFabr: Integer;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    For xFabr := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add(tuEvolutConst.SqlInsFabricante);
        Query.ParamByName('pCodERP').Value   := pJsonArray.Items[xFabr].GetValue<Integer>('fabricanteid');
        Query.ParamByName('pNome').Value     := pJsonArray.Items[xFabr].GetValue<String>('nome');
        Query.ParamByName('pFone').Value     := pJsonArray.Items[xFabr].GetValue<String>('fone');
        Query.ParamByName('pEmail').Value    := pJsonArray.Items[xFabr].GetValue<String>('email');
        Query.ParamByName('pHomepage').Value := pJsonArray.Items[xFabr].GetValue<String>('homepage');
        Query.ParamByName('pStatus').Value   := pJsonArray.Items[xFabr].GetValue<Integer>('status', 1);
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('LaboratorioImporta.Sql');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cadastro de Fabricante ' + pJsonArray.Items[xFabr]
              .GetValue<Integer>('fabricanteid').ToString + ' realizado com sucesso!'));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: Laboratorio/import - '+TUtil.TratarExcessao(E.Message)));
        End;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TLaboratorioDao.InsertUpdate(pId: Integer;
  pNome, pFone, pEmail, pHomePage: String; pStatus: Integer): TjSonArray;
var vSql: String;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'Insert Into Laboratorios (Nome, Fone, Email, HomePage, Status) Values ('+
                  QuotedStr(pNome) + ', ' + QuotedStr(pFone) + ', ' + QuotedStr(pEmail)+', '+
                  QuotedStr(pHomePage) + ', ' + pStatus.ToString() + ')'
      Else
         vSql := 'Update Laboratorios ' + '    Set Nome = ' + QuotedStr(pNome) +
                 '        ,Fone = ' + QuotedStr(pFone) + '        ,Email = ' + QuotedStr(pEmail) +
                 '        ,HomePage = ' + QuotedStr(pHomePage) +
                 '        ,Status   = ' + pStatus.ToString() + 'where IdLaboratorio = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except on E: Exception do
        raise Exception.Create('Processo: Fabricante/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TLaboratorioDao.MontarPaginacao: TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Open('Select Count(*) Paginacao From Laboratorios');
      Result.AddPair('paginacao', TJsonNumber.Create(Query.FieldByName('Paginacao').AsInteger));
    Except On E: Exception do
      Begin
        Result.AddPair('Erro', E.Message);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TLaboratorioDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.Laboratorio.IdLaboratorio = 0 then
         vSql := 'Insert Into Laboratorios (Nome, Fone, Email, HomePage, Status) Values ('+
                 QuotedStr(Self.Laboratorio.Nome) + ', ' +
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
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
        raise Exception.Create('Processo: Fabricante/Salvar - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

end.
