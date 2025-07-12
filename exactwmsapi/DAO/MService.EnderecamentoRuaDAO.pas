unit MService.EnderecamentoRuaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  EnderecamentoRuaClass, exactwmsservice.lib.connection, exactwmsservice.lib.utils,
  exactwmsservice.dao.base;

Const
  SqlEnderecoRua = 'select * From EnderecamentoRuas';

type

  TEnderecoRuaDao = class(TBasicDao)
  private
    FEnderecoRua: TEnderecoRua;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    function GetId(pRuaId: String): TjSonArray;
    Function GetRua4D(const AParams: TDictionary<string, string>): TJsonObject;
    Function Delete: Boolean;
    Function GetEnderecoLado(pDescricao: String = ''; pLado: String = 'U'; pShowErro: Integer = 1): TjSonArray;
    Property ObjEnderecoRua: TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
    Function Estrutura: TjSonArray;
  end;

implementation

{ TClienteDao }

constructor TEnderecoRuaDao.Create;
begin
  ObjEnderecoRua := TEnderecoRua.Create;
  inherited;
end;

function TEnderecoRuaDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from EnderecamentoRuas where RuaId= ' + Self.ObjEnderecoRua.RuaId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: EnderecamentoRuas - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TEnderecoRuaDao.Destroy;
begin
  FreeAndNil(ObjEnderecoRua);
  inherited;
end;

function TEnderecoRuaDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    FIndexeXact: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('EnderecamentoRuas') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else Begin
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

function TEnderecoRuaDao.GetEnderecoLado(pDescricao, pLado: String; pShowErro: Integer): TjSonArray;
var vSql: String;
    ObjJson: TJsonObject;
    EnderecoRuaDAO: TjSonArray;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Result := TJsonArray.Create;
  Try
    Query.Connection := Connection;
    try
      vSql := SqlEnderecoRua;
      if (pDescricao <> '') and (pLado <> '') then
        vSql := vSql + ' Where Descricao = ' + QuotedStr(pDescricao) + ' and Lado = ' + QuotedStr(pLado)
      Else If pDescricao <> '' then
        vSql := vSql + ' Where Descricao = ' + QuotedStr(pDescricao)
      Else If pLado <> '' then
        vSql := vSql + ' Where Lado = ' + QuotedStr(pLado);
      Query.Open(vSql);
      while Not Query.Eof do
        With ObjEnderecoRua do Begin
          RuaId     := Query.FieldByName('RuaId').AsInteger;
          Descricao := Query.FieldByName('Descricao').AsString;
          Lado      := Query.FieldByName('Lado').AsString;
          Ordem     := Query.FieldByName('Ordem').AsInteger;
          Status    := Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoRua, [joDateFormatISO8601]));
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: EnderecamentoRuas - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoRuaDao.GetId(pRuaId: String): TjSonArray;
var vSql: String;
    ObjJson: TJsonObject;
    EnderecoRuaItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := SqlEnderecoRua;
      if pRuaId <> '0' then
        if StrToIntDef(pRuaId, 0) > 0 then
           vSql := vSql + ' Where RuaId = ' + pRuaId
        Else
           vSql := vSql + ' Where Descricao = ' + QuotedStr(pRuaId);
      Query.Open(vSql);
      while Not Query.Eof do
        With ObjEnderecoRua do Begin
          RuaId     := Query.FieldByName('RuaId').AsInteger;
          Descricao := Query.FieldByName('Descricao').AsString;
          Lado      := Query.FieldByName('Lado').AsString;
          Ordem     := Query.FieldByName('Ordem').AsInteger;
          Status    := Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoRua, [joDateFormatISO8601]));
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: EnderecamentoRuas - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoRuaDao.GetRua4D(const AParams: TDictionary<string, string>) : TJsonObject;
Var QryPesquisa, QryRecordCount: TFDQuery;
   vParam: String;
begin
  Result := TJsonObject.Create();
  QryPesquisa := TFdQuery.Create(nil);
  QryPesquisa.Connection := Connection;
  QryPesquisa.SQL.Add('select * From EnderecamentoRuas where 1 = 1');
  QryRecordCount := TFdQuery.Create(Nil);
  QryRecordCount.Connection := Connection;
  QryRecordCount.SQL.Add('Select Count(RuaId) cReg From EnderecamentoRuas where 1=1');
  Try
    Try
      if AParams.ContainsKey('ruaid') then begin
        QryPesquisa.SQL.Add('and Ruaid = :RuaId');
        QryPesquisa.ParamByName('RuaId').AsString := AParams.Items['ruaid'];
        QryRecordCount.SQL.Add('and RuaId = :RuaId');
        QryRecordCount.ParamByName('RuaId').AsString := AParams.Items['ruaid'];
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
         QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
      QryPesquisa.SQL.Add('order by Descricao');
      QryPesquisa.Open();
      Result.AddPair('data', QryPesquisa.ToJSONArray());
      QryRecordCount.Open();
      Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
      QryPesquisa.Close;
      QryRecordCount.Close;
    Except On E: Exception do
      Raise Exception.Create(E.Message);
    End;
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TEnderecoRuaDao.Salvar: Boolean;
var vSql: String;
    FIndexeXact: Integer;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.ObjEnderecoRua.RuaId = 0 then
         vSql := 'Insert Into EnderecamentoRuas (Descricao, Lado, Ordem, Status) Values ('+sLineBreak+
                 QuotedStr(Self.ObjEnderecoRua.Descricao) + ', ' +QuotedStr(Self.ObjEnderecoRua.Lado)+ ', '+sLineBreak+
                 Self.ObjEnderecoRua.Ordem.ToString() + ', 1)'
      Else
         vSql := ' Update EnderecamentoRuas '+sLineBreak+
                 '    Set Descricao = '+QuotedStr(Self.ObjEnderecoRua.Descricao)+sLineBreak+
                 '  , Lado          = '+QuotedStr(Self.ObjEnderecoRua.Lado)+sLineBreak+
                 '  , Ordem         = '+Self.ObjEnderecoRua.Ordem.ToString()+sLineBreak+
                 '   , Status = '+Self.ObjEnderecoRua.Status.ToString()+sLineBreak+
                 ' where RuaId = '+Self.ObjEnderecoRua.RuaId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
