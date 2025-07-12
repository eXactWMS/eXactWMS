unit MService.FuncionalidadeDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FuncionalidadeClass, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type

  TFuncionalidadeDao = class(TBasicDao)
  private
    FFuncionalidade: TFuncionalidade;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pJsonObject: TJsonObject): Boolean;
    Function SalvarTopicoFuncionalidade(pTopicoId, pFuncionalidadeId,
      pStatus: Integer): Boolean;
    function GetId(pFuncionalidade: String): TjSonArray;
    Function GetFuncionalidade4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    function TopicoFuncionalidades(pTopicoId: Integer): TjSonArray;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Property ObjFuncionalidade: TFuncionalidade Read FFuncionalidade Write FFuncionalidade;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TFuncionalidadeDao.Create;
begin
  ObjFuncionalidade := TFuncionalidade.Create;
  inherited;
end;

function TFuncionalidadeDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Funcionalidades where FuncionalidadeId= '+Self.ObjFuncionalidade.FuncionalidadeId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: Funcionalidades - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TFuncionalidadeDao.Destroy;
begin
  ObjFuncionalidade.Free;
  inherited;
end;

function TFuncionalidadeDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('Funcionalidades')+' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
    End
    Else
      Result := Query.ToJSONArray();
  Finally
    Query.Free;
  End;
end;

function TFuncionalidadeDao.GetFuncionalidade4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
    vSql: String;
begin
  Try
    vSql := 'select FuncionalidadeId, Descricao From Funcionalidades' + sLineBreak+
            'Where 1 = 1';
    Result := TJsonObject.Create();
    QryPesquisa := TFdQuery.Create(Nil);
    QryPesquisa.Connection := Connection;
    QryPesquisa.SQL.Add(vSql);
    QryRecordCount := TFdQuery.Create(Nil);
    QryRecordCount.Connection := Connection;
    QryRecordCount.SQL.Add('Select Count(FuncionalidadeId) cReg From Funcionalidades Where 1 =1');
    if AParams.ContainsKey('funcionalidadeid') then begin
       QryPesquisa.SQL.Add('and FuncionalidadeId = :FuncionalidadeId');
       QryPesquisa.ParamByName('FuncionalidadeId').AsLargeInt := AParams.Items['funcionalidadeid'].ToInt64;
       QryRecordCount.SQL.Add('and FuncionalidadeId = :FuncionalidadeId');
       QryRecordCount.ParamByName('FuncionalidadeId').AsLargeInt := AParams.Items['funcionalidadeid'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then begin
       QryPesquisa.SQL.Add('and (Descricao like :Descricao))');
       QryPesquisa.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'].ToLower + '%';
       QryRecordCount.SQL.Add('and (Descricao like :Descricao))');
       QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'].ToLower + '%';
    end;
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by Descricao');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.ToJSONArray());
    if DebugHook <> 0 then
       QryPesquisa.SQL.SaveToFile('FuncionalidadeLista.Sql');
    QryRecordCount.Open();
    Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TFuncionalidadeDao.GetId(pFuncionalidade: String): TjSonArray;
var ObjJson: TJsonObject;
    FuncionalidadeItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlFuncionalidades);
      if (pFuncionalidade = '0') or (StrToInt64Def(pFuncionalidade, 0) > 0) then
         Query.ParamByName('pFuncionalidadeId').Value := pFuncionalidade
      Else
         Query.ParamByName('pFuncionalidadeId').Value := 0;
      if (StrToInt64Def(pFuncionalidade, 0) > 0) or (pFuncionalidade = '0') then
         Query.ParamByName('pDescricao').Value := ''
      Else
         Query.ParamByName('pDescricao').Value := '%' + pFuncionalidade + '%';
      Query.Open;
      while Not Query.Eof do
        With ObjFuncionalidade do Begin
          ObjJson := TJsonObject.Create;
          With ObjJson do
          Begin
            AddPair('funcionalidadeid', TJsonNumber.Create(Query.FieldByName('FuncionalidadeId').AsInteger));
            AddPair('descricao', Query.FieldByName('Descricao').AsString);
            AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
            AddPair('data', DateToStr(Query.FieldByName('Data').AsDateTime));
            AddPair('hora', TimeToStr(StrToTime(Copy(Query.FieldByName('Hora').AsString, 1, 8))));
            Result.AddElement(ObjJson);
            // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
          End;
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Funcionalidades - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TFuncionalidadeDao.Salvar(pJsonObject: TJsonObject): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pJsonObject.GetValue<Integer>('funcionalidadeId') = 0 then
        vSql := 'Insert Into Funcionalidades (Descricao, Status, Data, Hora) Values ('+SLineBreak+
                QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +sLineBreak+
                pJsonObject.GetValue<String>('status') + ', ' +sLineBreak+
                TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ')'
      Else
        vSql := ' Update Funcionalidades ' + sLineBreak+
                '   Set Descricao = ' + QuotedStr(pJsonObject.GetValue<String>('descricao')) +sLineBreak+
                '      , Status   = ' + pJsonObject.GetValue<String>('status') +
                ' where FuncionalidadeId = ' + pJsonObject.GetValue<Integer>('funcionalidadeId').ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Funcionalidade/Salvar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TFuncionalidadeDao.SalvarTopicoFuncionalidade(pTopicoId,
  pFuncionalidadeId, pStatus: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlSaveTopicoFuncionalidade);
      Query.ParamByName('pTopicoId').Value := pTopicoId;
      Query.ParamByName('pFuncionalidadeId').Value := pFuncionalidadeId;
      Query.ParamByName('pStatus').Value := pStatus;
      If DebugHook <> 0 Then
         Query.SQL.SaveToFile('SaveTopicoFuncionalidade.Sql');
      Query.ExecSQL;
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: SalvarTopicoFuncionalidades - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TFuncionalidadeDao.TopicoFuncionalidades(pTopicoId: Integer) : TjSonArray;
var ObjJson: TJsonObject;
    FuncionalidadeItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlTopicoFuncionalidades);
      Query.ParamByName('pTopicoId').Value := pTopicoId;
      Query.Open;
      while Not Query.Eof do
        With ObjFuncionalidade do Begin
          ObjJson := TJsonObject.Create;
          With ObjJson do Begin
            AddPair('funcionalidadeid', TJsonNumber.Create(Query.FieldByName('FuncionalidadeId').AsInteger));
            AddPair('descricao', Query.FieldByName('Descricao').AsString);
            AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
            Result.AddElement(ObjJson);
            // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
          End;
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: TopicoFuncionalidades - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
