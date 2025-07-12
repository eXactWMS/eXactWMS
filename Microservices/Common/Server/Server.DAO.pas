unit Server.DAO;

interface

uses
  Server.Message,
  System.Rtti,
  Server.Attributes,
  System.SysUtils,
  FireDAC.Stan.Param,
  Server.Utils.JsonSearchToWhere,
  Server.Utils.SectionVariables,
  Web.HTTPApp,
  System.JSON,
  System.Generics.Collections,
  Server.Connection,
  Server.MessageList,
  System.DateUtils,
  System.Classes,
  Server.Util,
  Server.Records,
  Server.ResourceBaseClass,

  Data.DB;

type
  TExec = (teInsert, teUpdate, teDelete);
  TPesquisa = (tpInicio, tpTodoCampo, tpFim);

  TDAO = class
  private

    class function GetFields(Obj: TObject; ListHeader: Boolean = False;
      ListSelect: Boolean = False): String;
    class function GetWhere(Obj: TObject; ID: String; Search: String;
      WherePadrao: String; TipoPesquisa: TPesquisa): String; overload;

    Class function GetWhere(ID: string; Obj: TObject; Search: string)
      : String; overload;
    class function GetOrder(Obj: TObject; Sort: String;
      Direction: String): String;
    class function GetTotalElements(lSQL: String): Integer;
    class function OpenQuery(Response: TWebResponse; lSQL: string): TJSONArray;
      overload; static;
    class procedure SetFieldsAndParams(Tipo: TExec; Obj: TObject;
      var FieldsName: String; var ParamsOrWhereName: String; Params: TFDParams);
    class procedure ExecQuery(var Result: TMessageType; lSQL: string;
      Params: TFDParams);
    class procedure SetParams(Obj: TObject; RttiField: TRttiField;
      RttiAttribute: TCustomAttribute; Params: TFDParams);

    class function GetSqlJoin(Obj: TObject): string;

    class function DictionaryFields(Obj: TObject): TDictionary<String, string>;
    class function OpenQuery(const AValuesRequest: TValuesRequest;
      const ASQL: string; ADictionary: TDictionary<String, string>;
      ANameTable: string): TJSONArray; overload; static;
    class function DataSetToJSONObject(ADataSet: TDataSet): TJSONObject;

    class Function FielIsLookUp(Field: DbField; Obj: TObject): Boolean;
    class procedure SetResourceListArray(Obj: TObject; lDados: TJSONArray);
  public
    class procedure SetDadosInMessage(Obj: TObject; var Result: TMessageType);
    class procedure Select(Response: TWebResponse; Obj: TObject;
      PageNumber: Integer; PageSize: Integer; Direction: String; Sort: String;
      Search: String; ID: String; WherePadrao: String; Join: string;
      JSON: TJSONObject); overload;
    class procedure Select(Obj: TObject;
      AValuesRequest: TValuesRequest); overload;
    class procedure Insert(Response: TWebResponse;
      ListObj: TObjectList<TObject>; Dados: TJSONObject;
      Conn: TConnection = nil);

    class procedure Update(Response: TWebResponse;
      ListObj: TObjectList<TObject>; Dados: TJSONObject;
      Conn: TConnection = nil);
    class procedure Delete(Response: TWebResponse; Obj: TObject;
      Condicao: string = '');
    class procedure DeleteDetails(RttiAttribute: TCustomAttribute;
      Obj, ResourceObj: TObject; Conn: TConnection);
  end;

var
  lTotalElements: Integer;

implementation

uses
  System.StrUtils, Server.Token, System.Variants;

{ TDAO }

class procedure TDAO.Insert(Response: TWebResponse;
  ListObj: TObjectList<TObject>; Dados: TJSONObject; Conn: TConnection = nil);
const
  SQL = 'INSERT INTO %s (%s) VALUES (%s)';
var
  Connection: TConnection;
  TableName: String;
  FieldsName: String;
  ParamsName: String;
  Params: TFDParams;
  Mensagem: TMessageType;
  Obj: TObject;
  RttiType: TRttiType;
begin
  Mensagem := IRegistroInserido;
  if not assigned(Conn) then
  begin
    Connection := TConnection.Create;
    Connection.DB.StartTransaction;
  end
  else
    Connection := Conn;
  try
    try
      for Obj in ListObj do
      begin
        Params := TFDParams.Create;
        TableName := TWKUtil.GetTableName(Obj);
        SetFieldsAndParams(teInsert, Obj, FieldsName, ParamsName, Params);
        Connection.Query.SQL.Clear;

        Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName,
          ParamsName]));
        if DebugHook > 0 then
          TWKUtil.SaveSql(Connection.Query, 'InsertDebug');
        Connection.Query.Params := Params;
        Connection.Query.ExecSQL;
        RttiType := TWKUtil.GetRttiType(Obj);
      end;
      if not assigned(Conn) then
        Connection.DB.Commit;
    except
      on E: Exception do
      begin
        Connection.DB.Rollback;
        TMessage.Create(EDadosNaoSalvos, E.Message).SendMessage(Response);
      end;
    end;
  finally
    if not assigned(Conn) then
      Connection.Free;
  end;
  SetDadosInMessage(ListObj.First, Mensagem);
  if assigned(Response) then

    TMessage.Create(Mensagem).SendMessage(Response);
end;

class procedure TDAO.SetResourceListArray(Obj: TObject; lDados: TJSONArray);
var
  i: Integer;
begin
  if (Obj is TResourceBaseClass) then
  begin
    TResourceBaseClass(Obj).JsonArrayList := lDados;
    for i := 0 to lDados.Count - 1 do
      TResourceBaseClass(Obj).SetDados(TJSONObject(lDados.Items[i]));
  end;
end;

class procedure TDAO.SetFieldsAndParams(Tipo: TExec; Obj: TObject;
  var FieldsName: String; var ParamsOrWhereName: String; Params: TFDParams);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  AliasTableName: String;
  DefaultAlias: string;
begin
  FieldsName := EmptyStr;
  ParamsOrWhereName := EmptyStr;
  RttiType := TWKUtil.GetRttiType(Obj);
  DefaultAlias := TWKUtil.GetTableName(Obj) + '.';
  for RttiField in RttiType.GetFields do
  begin
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DbField then
      begin
        AliasTableName := DefaultAlias;
        if (RttiAttribute as DbField).TableSource <> '' then
          AliasTableName := (RttiAttribute as DbField).TableSource + '.';
        if (((RttiAttribute as DbField).Constraints = PrimaryKey) and
          (Tipo in [teUpdate, teDelete])) then
        begin
          if ParamsOrWhereName <> EmptyStr then
            ParamsOrWhereName := ParamsOrWhereName + ' AND ';
          ParamsOrWhereName := ParamsOrWhereName + #13#10 + AliasTableName +
            (RttiAttribute as DbField).FieldName + ' = :' +
            (RttiAttribute as DbField).FieldName;
        end
        else
        begin
          if (FielIsLookUp(RttiAttribute as DbField, Obj)) then
            continue;
          if (Tipo in [teUpdate, teDelete, teInsert]) then
            FieldsName := FieldsName + #13#10 + (RttiAttribute as DbField)
              .FieldName
          else
            FieldsName := FieldsName + #13#10 + AliasTableName +
              (RttiAttribute as DbField).FieldName;
          if Tipo = teUpdate then
          begin
            FieldsName := FieldsName + ' = :' + (RttiAttribute as DbField)
              .FieldName;
            if RttiField.FieldType.Name = 'TMacAddress' then
              FieldsName := FieldsName + '::macaddr'
            else if RttiField.FieldType.Name = 'TBytea' then
              FieldsName := FieldsName + '::bytea'
          end;
          FieldsName := FieldsName + ',';
        end;
        SetParams(Obj, RttiField, RttiAttribute, Params);
      end;
  end;

  FieldsName := FieldsName.TrimRight([',']);
  if Tipo = teInsert then
    ParamsOrWhereName := ':' + StringReplace(FieldsName, ',', ',:',
      [rfReplaceAll]);
  if Tipo = teInsert then
  begin
    ParamsOrWhereName := EmptyStr;
    RttiType := TWKUtil.GetRttiType(Obj);
    for RttiField in RttiType.GetFields do
    begin
      for RttiAttribute in RttiField.GetAttributes do
        if RttiAttribute is DbField then
        begin
          if (FielIsLookUp(RttiAttribute as DbField, Obj)) then
            continue;
          ParamsOrWhereName := ParamsOrWhereName + ':' +
            (RttiAttribute as DbField).FieldName;
          if RttiField.FieldType.Name = 'TPoint' then
            ParamsOrWhereName := ParamsOrWhereName + '::point'
          else if RttiField.FieldType.Name = 'TMacAddress' then
            ParamsOrWhereName := ParamsOrWhereName + '::macaddr'
          else if RttiField.FieldType.Name = 'TBytea' then
            ParamsOrWhereName := ParamsOrWhereName + '::bytea'
          else if RttiField.FieldType.Name = 'TIP' then
            ParamsOrWhereName := ParamsOrWhereName + '::inet';
          ParamsOrWhereName := ParamsOrWhereName + ',';
        end;
    end;
    ParamsOrWhereName := ParamsOrWhereName.TrimRight([',']);
  end
  else if Tipo in [teUpdate, teDelete] then
    ParamsOrWhereName := ParamsOrWhereName.TrimRight([',']);
end;

class function TDAO.GetFields(Obj: TObject; ListHeader: Boolean = False;
  ListSelect: Boolean = False): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  AliasTableName: String;
  DefaultAlias: string;
begin
  Result := EmptyStr;
  RttiType := TWKUtil.GetRttiType(Obj);
  DefaultAlias := TWKUtil.GetTableName(Obj) + '.';
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DbField then
      begin

        AliasTableName := DefaultAlias;
        if (RttiAttribute as DbField).TableSource <> '' then
          AliasTableName := (RttiAttribute as DbField).TableSource + '.';
        if not(RttiAttribute as DbField).ObjectJson then
          if ((RttiAttribute as DbField).Header) or
            ((RttiAttribute as DbField).ListSelect) then

            Result := Result + #13#10 + AliasTableName +
              (RttiAttribute as DbField).FieldName + ' as "' +
              RttiField.Name + '",';
      end;
  Result := Result.TrimRight([',']);
end;

class function TDAO.GetOrder(Obj: TObject; Sort: String;
  Direction: String): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  Padrao: String;
  AliasTableName: String;
  DefaultAlias: string;
begin
  Result := EmptyStr;
  Padrao := EmptyStr;
  RttiType := TWKUtil.GetRttiType(Obj);
  DefaultAlias := TWKUtil.GetTableName(Obj) + '.';
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DbField then
      begin
        AliasTableName := DefaultAlias;
        if (RttiAttribute as DbField).TableSource <> '' then
          AliasTableName := (RttiAttribute as DbField).TableSource + '.';
        if (RttiAttribute as DbField).Sort then
        begin
          if Padrao <> EmptyStr then
            Padrao := Padrao + ',';
          Padrao := Padrao + #13#10 + AliasTableName +
            (RttiAttribute as DbField).FieldName;
          if Direction = 'desc' then
            Padrao := Padrao + ' DESC';

        end;
        if LowerCase(RttiField.Name) = LowerCase(Sort) then
        begin
          Result := #13#10 + ' ORDER BY ' + #13#10 + AliasTableName +
            (RttiAttribute as DbField).FieldName;
          if Direction = 'desc' then
            Result := Result + ' DESC';
        end;
      end;
  if Result = EmptyStr then
    if Padrao <> EmptyStr then
      Result := #13#10 + ' ORDER BY ' + Padrao;
end;

class function TDAO.GetTotalElements(lSQL: String): Integer;
var
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    Connection.Query.Open;
    Result := Connection.Query.FieldByName('QTD').AsInteger;
  finally
    Connection.Free;
  end;
end;

class function TDAO.DataSetToJSONObject(ADataSet: TDataSet): TJSONObject;
var
  Field: TField;
begin
  Result := TJSONObject.Create;
  for Field in ADataSet.Fields do
  begin
    if Field.DataType = ftInteger then
      Result.AddPair(LowerCase(Field.FieldName),
        TJSONNumber.Create(Field.AsInteger))
    else if Field.DataType = ftBoolean then
    begin
      Result.AddPair(LowerCase(Field.FieldName),
        TJSONBool.Create(Field.AsBoolean))
    end
    else if Field.DataType in [ftDate] then
      Result.AddPair(LowerCase(Field.FieldName),
        Copy(DateToISO8601(Field.AsFloat), 1, 10))
    else if Field.DataType in [ftBCD, ftCurrency] then
      Result.AddPair(LowerCase(Field.FieldName),
        TJSONNumber.Create(Field.AsCurrency))

    else if Field.DataType in [ftBlob, ftByte] then
      if ADataSet.RecordCount = 1 then

        Result.AddPair(LowerCase(Field.FieldName),
          TJSONString.Create(TrimRight(Field.AsString)))
      else
        Result.AddPair(LowerCase(Field.FieldName), '')
    else
      Result.AddPair(LowerCase(Field.FieldName), Field.AsString);
  end;
end;

class procedure TDAO.Delete(Response: TWebResponse; Obj: TObject;
  Condicao: string = '');
const
  SQL = 'DELETE FROM %s WHERE %s';
var
  TableName: String;
  FieldsName: String;
  WhereCondition: String;
  Params: TFDParams;
  Mensagem: TMessageType;
begin
  Mensagem := IRegistroExcluido;
  Params := TFDParams.Create;
  TableName := TWKUtil.GetTableName(Obj);
  if Condicao <> '' then
    ExecQuery(Mensagem, Format(SQL, [TableName, Condicao]), Params)

  else
  begin
    SetFieldsAndParams(teDelete, Obj, FieldsName, WhereCondition, Params);
    ExecQuery(Mensagem, Format(SQL, [TableName, WhereCondition]), Params);
  end;
  TMessage.Create(Mensagem).SendMessage(Response);
end;

class procedure TDAO.SetParams(Obj: TObject; RttiField: TRttiField;
  RttiAttribute: TCustomAttribute; Params: TFDParams);
var
  lParam: TFDParam;
  LAttribute: TCustomAttribute;

begin
  lParam := Params.Add;
  lParam.Name := (RttiAttribute as DbField).FieldName;
  lParam.ParamType := ptInput;

  if RttiField.FieldType.TypeKind in [tkInteger] then
  begin
    lParam.DataType := ftInteger;
    if RttiField.GetValue(Obj).AsInteger < 0 then
      lParam.Value := Null
    else
      lParam.Value := RttiField.GetValue(Obj).AsInteger;
  end
  else if RttiField.FieldType.TypeKind in [tkString, tkUString, tkUnicodeString,
    tkWString, tkWideChar, tkWideString, tkChar] then
  begin
    lParam.DataType := ftString;
    for LAttribute in RttiField.GetAttributes do
    begin
      if (LAttribute is DBFieldTypeMemo) then
      begin
        lParam.DataType := ftWideMemo;
        break;
      end;
    end;
    if RttiField.GetValue(Obj).AsString = 'Null' then
      lParam.Value := Null
    else
      lParam.Value := (RttiField.GetValue(Obj).AsString);
  end
  else if RttiField.FieldType.TypeKind in [tkFloat] then
  begin
    case IndexStr(RttiField.FieldType.Name, ['TDateTime', 'TDate', 'TTime']) of
      0:
        begin
          lParam.DataType := ftDateTime;
          lParam.Value := RttiField.GetValue(Obj).AsType<TDateTime>;
        end;
      1:
        begin
          lParam.DataType := ftDate;
          lParam.Value := RttiField.GetValue(Obj).AsType<TDate>;
        end;
      2:
        begin
          lParam.DataType := ftTime;
          lParam.Value := RttiField.GetValue(Obj).AsType<TTime>;
        end;
    else
      begin
        lParam.DataType := ftFloat;
        lParam.Value := RttiField.GetValue(Obj).AsExtended;
      end;
    end;
  end
  else if RttiField.FieldType.TypeKind in [tkEnumeration] then
  begin
    lParam.DataType := ftBoolean;
    lParam.Value := RttiField.GetValue(Obj).AsBoolean;
  end
  else if RttiField.FieldType.TypeKind in [tkRecord] then
  begin
    case IndexStr(RttiField.FieldType.Name, ['TDateTime']) of
      0:
        begin
          lParam.DataType := ftDateTime;
          lParam.Value := RttiField.GetValue(Obj).AsType<TDateTime>;
        end;
    end;
  end
  else if RttiField.FieldType.Name = 'TMacAddress' then
  begin
    lParam.DataType := ftString;
    lParam.Value := TMacAddress(RttiField.GetValue(Obj).AsObject).Value;
  end
  else if RttiField.FieldType.Name = 'TBytea' then
  begin
    lParam.DataType := ftBlob;
    if assigned(TBytea(RttiField.GetValue(Obj).AsObject)) then

      lParam.Value := TBytea(RttiField.GetValue(Obj).AsObject).Value.Text;
  end
  else
  begin
    lParam.DataType := ftString;
    lParam.Value := RttiField.GetValue(Obj).AsString;
  end;

end;

class procedure TDAO.Select(Response: TWebResponse; Obj: TObject;
  PageNumber: Integer; PageSize: Integer; Direction: String; Sort: String;
  Search: String; ID: String; WherePadrao: String; Join: string;
  JSON: TJSONObject);
const
  SQL = 'SELECT %s   FROM %s %s %s %s %s';
var
  lFields: String;
  lTableName: String;
  lWhere: String;
  lOrder: String;
  lPagination: String;
  lSQL: String;
  lDados: TJSONArray;
  lResult: TJSONObject;
  lTotalPages: Integer;
  lJoin: string;
  LTpPesquisa: TPesquisa;
  LValueTypeSearch: string;
begin
  LTpPesquisa := tpTodoCampo;
  if assigned(JSON) then
  begin
    LValueTypeSearch := JSON.GetValue<string>('TypeSearch').ToLower;
    if (LValueTypeSearch = 'first') then
      LTpPesquisa := tpInicio
    else if LValueTypeSearch = 'all' then
      LTpPesquisa := tpTodoCampo
    else if LValueTypeSearch = 'last' then
      LTpPesquisa := tpFim;
  end;
  if ID = 'list-select' then
    lFields := GetFields(Obj, False, True)
  else if ID = EmptyStr then
    lFields := GetFields(Obj, True)
  else
    lFields := GetFields(Obj);
  lTableName := TWKUtil.GetTableName(Obj);
  lJoin := GetSqlJoin(Obj);
  if assigned(TJSONObject.ParseJSONValue(Search)) then
    lWhere := GetWhere(ID, Obj, Search)
  else
    lWhere := GetWhere(Obj, ID, Search, WherePadrao, LTpPesquisa);
  lOrder := GetOrder(Obj, Sort, Direction);

  lSQL := Format(SQL, [lFields, lTableName, lJoin, lWhere, lOrder,
    lPagination]);
  lDados := OpenQuery(Response, lSQL);
  SetResourceListArray(Obj, lDados);
  if ID = 'list-select' then
  begin
    Response.Content := lDados.ToString;
    Response.SendResponse;
  end
  else if ID = EmptyStr then
  begin
    lResult := TJSONObject.Create;
    lResult.AddPair('content', lDados);
    lResult.AddPair('totalElements', TJSONNumber.Create(lTotalElements));
    if (lTotalElements mod PageSize) <> 0 then
      lTotalPages := (lTotalElements div PageSize) + 1
    else
      lTotalPages := (lTotalElements div PageSize);
    lResult.AddPair('totalPages', TJSONNumber.Create(lTotalPages));
    lResult.AddPair('pageSize', TJSONNumber.Create(PageSize));
    lResult.AddPair('pageNumber', TJSONNumber.Create(PageNumber));
    if assigned(Response) then
    begin
      Response.Content := lResult.ToString;
      TWKUtil.compactarResponse(Response);
      Response.SendResponse;
    end;
  end
  else
  begin
    if assigned(Response) then
    begin
      if lDados.Count >= 1 then
      begin
        lResult := TJSONObject(lDados.Items[0]);
        Response.Content := lResult.ToString;
        TWKUtil.compactarResponse(Response);
        Response.SendResponse;
      end
      else
      begin
        Response.Content := '{}';
        Response.SendResponse;
      end;
    end;
  end;
end;

class procedure TDAO.Select(Obj: TObject; AValuesRequest: TValuesRequest);
const
  SQL = 'SELECT %s FROM %s %s %s %s %s';
var
  lFields: String;
  lTableName: String;
  lWhere: String;
  lOrder: String;
  lPagination: String;
  lSQL: String;
  lDados: TJSONArray;
  lResult: TJSONObject;
  lTotalElements: Integer;
  lTotalPages: Integer;
  lJoin: string;
  i: Integer;
  procedure postResponse(Value: string);
  begin
    try
      if assigned(AValuesRequest.Response) then
      begin
        try
          AValuesRequest.Response.Content := Value;
        except

        end;
        TWKUtil.compactarResponse(AValuesRequest.Response);
        AValuesRequest.Response.SendResponse;
      end;
    except
      on E: Exception do
        Writeln('Fail on post message');
    end;
  end;

begin

  lFields := GetFields(Obj);
  if assigned(TJSONObject.ParseJSONValue(AValuesRequest.Search)) then
    lWhere := GetWhere(AValuesRequest.ID, Obj, AValuesRequest.Search)
  else
    lWhere := GetWhere(Obj, AValuesRequest.ID, AValuesRequest.Search, '',
      TPesquisa.tpTodoCampo);

  lOrder := GetOrder(Obj, AValuesRequest.Sort, AValuesRequest.Direction);
  lTableName := TWKUtil.GetTableName(Obj);
  lJoin := GetSqlJoin(Obj);
  lSQL := Format(SQL, [lFields, lTableName, lJoin, lWhere, lOrder,
    lPagination]);
  lDados := OpenQuery(AValuesRequest, lSQL, DictionaryFields(Obj), lTableName);
  SetResourceListArray(Obj, lDados);
  if AValuesRequest.ID = EmptyStr then
  begin
    lResult := TJSONObject.Create;

    lResult.AddPair('content', lDados);
    lSQL := 'SELECT COUNT(*) AS QTD FROM %s %s %s';
    lSQL := Format(lSQL, [lTableName, lJoin, lWhere]);
    lTotalElements := GetTotalElements(lSQL);
    lResult.AddPair('totalElements', TJSONNumber.Create(lTotalElements));
    if (lTotalElements mod AValuesRequest.PageSize) <> 0 then
      lTotalPages := (lTotalElements div AValuesRequest.PageSize) + 1
    else
      lTotalPages := (lTotalElements div AValuesRequest.PageSize);
    lResult.AddPair('totalPages', TJSONNumber.Create(lTotalPages));
    lResult.AddPair('pageSize', TJSONNumber.Create(AValuesRequest.PageSize));
    lResult.AddPair('pageNumber',
      TJSONNumber.Create(AValuesRequest.PageNumber));
    postResponse(lResult.ToString);
  end
  else if lDados.Count >= 1 then
    postResponse(lDados.Items[0].ToString)
  else
    postResponse('{}');
end;

class procedure TDAO.SetDadosInMessage(Obj: TObject; var Result: TMessageType);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  Dados: TJSONObject;
begin
  Dados := TJSONObject.Create;
  RttiType := TWKUtil.GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DbField then
      begin
        if RttiField.FieldType.TypeKind in [tkInteger] then
          Dados.AddPair(RttiField.Name.ToLower,
            TJSONNumber.Create(RttiField.GetValue(Obj).AsInteger))
        else if RttiField.FieldType.TypeKind
          in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar,
          tkWideString, tkChar] then
          Dados.AddPair(RttiField.Name.ToLower,
            RttiField.GetValue(Obj).AsString)
        else if RttiField.FieldType.TypeKind in [tkFloat] then
        begin
          case IndexStr(RttiField.FieldType.Name,
            ['TDateTime', 'TDate', 'TTime']) of

            0:
              Dados.AddPair(RttiField.Name.ToLower,
                TJSONString.Create(Copy(DateToISO8601(RttiField.GetValue(Obj)
                .AsType<TDateTime>), 1, 10)));
            1:
              Dados.AddPair(RttiField.Name.ToLower,
                TJSONString.Create(Copy(DateToISO8601(RttiField.GetValue(Obj)
                .AsType<TDate>), 1, 10)));
            2:
              Dados.AddPair(RttiField.Name.ToLower,
                TJSONString.Create(TimeToStr(RttiField.GetValue(Obj)
                .AsType<TTime>)));
          else
            Dados.AddPair(RttiField.Name.ToLower,
              TJSONNumber.Create(RttiField.GetValue(Obj).AsExtended))
          end;
        end
        else if RttiField.FieldType.TypeKind in [tkEnumeration] then
          Dados.AddPair(RttiField.Name.ToLower,
            TJSONBool.Create(RttiField.GetValue(Obj).AsBoolean))
        else if RttiField.FieldType.Name = 'TMacAddress' then
          Dados.AddPair(RttiField.Name.ToLower,
            TMacAddress(RttiField.GetValue(Obj).AsObject).Value)
        else if RttiField.FieldType.Name = 'TBytea' then
        begin
          if assigned((RttiField.GetValue(Obj).AsObject)) then

            Dados.AddPair(RttiField.Name.ToLower,
              TBytea(RttiField.GetValue(Obj).AsObject).Value.Text)
          else
            Dados.AddPair(RttiField.Name.ToLower, '');
        end
        else
          Dados.AddPair(RttiField.Name.ToLower,
            RttiField.GetValue(Obj).AsString)
      end;
  Result.Content := Dados;
end;

class procedure TDAO.ExecQuery(var Result: TMessageType; lSQL: string;
  Params: TFDParams);
var
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    Connection.Query.Params := Params;
    try
      Connection.Query.ExecSQL;
    except
      on E: Exception do
      begin
        Result := EDadosNaoExcluidos;
      end;
    end;
  finally
    Connection.Free;
  end;
end;

class function TDAO.FielIsLookUp(Field: DbField; Obj: TObject): Boolean;
begin
  Result := False;
  if Field.TableSource = '' then
    exit;
  Result := Field.TableSource <> TWKUtil.GetTableName(Obj);
end;

class function TDAO.OpenQuery(Response: TWebResponse; lSQL: string): TJSONArray;
var
  lItem: TJSONObject;
  Field: TField;
  Connection: TConnection;
begin
  Result := TJSONArray.Create;
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    try
      if DebugHook > 0 then
        TWKUtil.SaveSql(Connection.Query, 'OpenQuery');
      Connection.Query.Open;
      Connection.Query.First;
      while not(Connection.Query.Eof) do
      begin
        lItem := TJSONObject.Create;
        Result.AddElement(lItem);
        for Field in Connection.Query.Fields do
          if Field.DataType = ftInteger then
            lItem.AddPair(LowerCase(Field.FieldName),
              TJSONNumber.Create(Field.AsInteger))
          else if Field.DataType = ftBoolean then
          begin
            lItem.AddPair(LowerCase(Field.FieldName),
              TJSONBool.Create(Field.AsBoolean))
          end
          else if Field.DataType in [ftDate] then
            lItem.AddPair(LowerCase(Field.FieldName),
              Copy(DateToISO8601(Field.AsFloat), 1, 10))
          else if Field.DataType in [ftBCD, ftCurrency] then
            lItem.AddPair(LowerCase(Field.FieldName),
              TJSONNumber.Create(Field.AsCurrency))

            // corigir problema de terminação /rn
          else if Field.DataType in [ftBlob, ftByte] then
            if Connection.Query.RecordCount = 1 then
              lItem.AddPair(LowerCase(Field.FieldName),
                TJSONString.Create(TrimRight(Field.AsString)))
            else
              lItem.AddPair(LowerCase(Field.FieldName), '')
          else
            lItem.AddPair(LowerCase(Field.FieldName), Field.AsString);
        Connection.Query.Next;

      end;
      lTotalElements := Connection.Query.RecordCount;

    except
      on E: Exception do
      begin
        Connection.Query.SQL.saveTofile(ExtractFilePath(GetModuleName(HInstance)
          ) + 'ErroSql.sql');
        if assigned(Response) then

          TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' +
            E.Message + ')').SendMessage(Response);
      end;
    end;
  finally
    Connection.Free;
  end;
end;

class procedure TDAO.Update(Response: TWebResponse;
  ListObj: TObjectList<TObject>; Dados: TJSONObject; Conn: TConnection = nil);
const
  SQL = 'UPDATE %s SET %s WHERE %s';
var
  Connection: TConnection;
  TableName: String;
  FieldsName: String;
  WhereCondition: String;
  Params: TFDParams;
  Mensagem: TMessageType;
  Obj: TObject;
  RttiType: TRttiType;
begin
  Mensagem := IRegistroAlterado;
  if not assigned(Conn) then
  begin
    Connection := TConnection.Create;
    Connection.DB.StartTransaction;
  end
  else
    Connection := Conn;
  try
    try
      for Obj in ListObj do
      begin
        Params := TFDParams.Create;
        TableName := TWKUtil.GetTableName(Obj);
        SetFieldsAndParams(teUpdate, Obj, FieldsName, WhereCondition, Params);
        Connection.Query.SQL.Clear;
        Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName,
          WhereCondition]));
        Connection.Query.Params := Params;

        Connection.Query.ExecSQL;
        RttiType := TWKUtil.GetRttiType(Obj);
      end;
      if not assigned(Conn) then
        Connection.DB.Commit;
    except
      on E: Exception do
      begin
        if DebugHook > 0 then
        begin
          ForceDirectories(ExtractFilePath(GetModuleName(HInstance)) +
            'sqlerros');
          Connection.Query.SQL.saveTofile
            (ExtractFilePath(GetModuleName(HInstance)) +
            'sqlerros\Erro_sql.sql');
        end;
        Connection.DB.Rollback;
        if assigned(Response) then

          TMessage.Create(EDadosNaoSalvos, E.Message).SendMessage(Response)
        else
          raise Exception.Create(E.Message);
      end;
    end;
  finally
    if not assigned(Conn) then
      Connection.Free;
  end;
  SetDadosInMessage(ListObj.First, Mensagem);
  TMessage.Create(Mensagem).SendMessage(Response);
end;

class function TDAO.GetWhere(ID: string; Obj: TObject; Search: string): String;
var
  filtro: TSearchFilter;
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  lTableName: String;
begin
  try
    filtro := TSearchFilter.Create(Obj, Search);
    Result := filtro.whereFilter;
    lTableName := TWKUtil.GetTableName(Obj);
    if ((ID <> EmptyStr) and (ID <> 'list-select')) then
    begin
      RttiType := TWKUtil.GetRttiType(Obj);
      for RttiField in RttiType.GetFields do
        for RttiAttribute in RttiField.GetAttributes do
          if RttiAttribute is DbField then
            if (RttiAttribute as DbField).Constraints = PrimaryKey then
            begin
              if Result <> '' then

                Result := Result + #13#10 + 'AND ' + #13#10 + lTableName + '.' +
                  (RttiAttribute as DbField).FieldName + ' = ' + ID
              else
                Result := #13#10 + 'WHERE ' + lTableName + '.' +
                  (RttiAttribute as DbField).FieldName + ' = ' + ID
            end;
    end
  finally
    FreeAndNil(filtro);
  end;
end;

class function TDAO.GetWhere(Obj: TObject; ID: String; Search: String;
  WherePadrao: String; TipoPesquisa: TPesquisa): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  ListWhere: TArray<String>;
  Item: String;
  FieldName: String;
  lTableName: string;
  Filter: String;
begin
  Result := EmptyStr;
  lTableName := TWKUtil.GetTableName(Obj);
  if ((ID <> EmptyStr) and (ID <> 'list-select')) then
  begin
    RttiType := TWKUtil.GetRttiType(Obj);
    for RttiField in RttiType.GetFields do
      for RttiAttribute in RttiField.GetAttributes do
        if RttiAttribute is DbField then
          if (RttiAttribute as DbField).Constraints = PrimaryKey then
          begin
            Result := ' WHERE ' + #13#10 + lTableName + '.' +
              (RttiAttribute as DbField).FieldName + ' = ' + ID;
          end;
  end
  else if Search <> EmptyStr then
  begin
    ListWhere := Search.Split(['@@@']);
    for Item in ListWhere do
    begin
      if Length(Item.Split([':'])) = 2 then
      begin
        FieldName := Item.Split([':'])[0];
        Filter := Item.Split([':'])[1];
        RttiType := TWKUtil.GetRttiType(Obj);
        for RttiField in RttiType.GetFields do
        begin
          for RttiAttribute in RttiField.GetAttributes do
          begin
            lTableName := TWKUtil.GetTableName(Obj);

            if RttiAttribute is DbField then
            begin

              if LowerCase(RttiField.Name) = LowerCase(FieldName) then
              begin
                if (RttiAttribute as DbField).TableSource <> '' then
                  lTableName := (RttiAttribute as DbField).TableSource;

                if ((RttiField.FieldType.ToString) = 'Integer') or
                  (RttiField.FieldType.ToString = 'Boolean') then
                begin
                  if Result = EmptyStr then
                    Result := ' WHERE (' + #13#10 + lTableName + '.' +
                      (RttiAttribute as DbField).FieldName + ') = ' + Filter
                  else
                    Result := Result + ' AND (' + lTableName + '.' +
                      (RttiAttribute as DbField).FieldName + ') = ' + Filter;
                end
                else
                begin
                  if (TipoPesquisa = tpInicio) then
                    Filter := Filter + '%'
                  else if (TipoPesquisa = tpTodoCampo) then
                    Filter := '%' + Filter + '%'
                  else if (TipoPesquisa = tpFim) then
                    Filter := '%' + Filter;

                  if Result = EmptyStr then
                    Result := ' WHERE lower(' + lTableName + '.' +
                      (RttiAttribute as DbField).FieldName + ') LIKE lower(' +
                      QuotedStr(Filter) + ')'
                  else
                    Result := Result + ' AND lower(' + lTableName + '.' +
                      (RttiAttribute as DbField).FieldName + ') LIKE lower(' +
                      QuotedStr('%' + Filter + '%') + ')';
                end;
              end
              else
              begin

              end;
            end;
          end;
        end;
      end;
    end;
  end;
  if WherePadrao <> EmptyStr then
  begin
    if Result = EmptyStr then
      Result := ' WHERE ' + WherePadrao
    else
      Result := Result + ' AND ' + WherePadrao;
  end;
end;

class function TDAO.OpenQuery(const AValuesRequest: TValuesRequest;
  const ASQL: string; ADictionary: TDictionary<String, string>;
  ANameTable: string): TJSONArray;
const
  SQL = 'SELECT %s FROM %s %s %s %s %s';
var
  lItem: TJSONObject;
  Connection: TConnection;
  LNameTable: string;
  LListMapperAttributes: TList<TMapperAttributes>;
  ConnectionObject: TConnection;
  LJSONObject: TJSONObject;
  FListConnection: TDictionary<string, TConnection>;
  LKey: string;
  lDados: TJSONArray;
  i: Integer;
  lFields: string;
  lTableName: string;
  lJoin: string;
  lWhere: string;
  IsEmpetyLine: Boolean;
  lSQL: string;
  Obj: TObject;

  function getFKNameField: string;
  begin
    Result := LListMapperAttributes[i].JSONObjectField.FkField;
  end;
  Function GetValueMasterField(): string;
  begin
    Result := Connection.Query.FieldByName
      (LListMapperAttributes[i].JSONObjectField.MasterField).AsString;
  end;
  function GetIndexArray(FieldNameValue, AValue: string): Integer;
  var
    LIndexArray: Integer;
    TesteValue: string;
    LArrray: TJSONArray;
  begin
    Result := 0;
    LArrray := TJSONArray.Create;
    for LIndexArray := 0 to lDados.Count - 1 do
    begin
      TJSONObject(lDados.Items[LIndexArray]).TryGetValue(FieldNameValue,
        TesteValue);
      if TesteValue = AValue then
      begin
        Inc(Result);

        LJSONObject := TJSONObject(lDados.Items[LIndexArray]);
        LArrray.AddElement(LJSONObject);

      end;

    end;
    lItem.AddPair(LListMapperAttributes[i].JSONFieldName, LArrray);
  end;

begin
  Result := TJSONArray.Create;
  Connection := TConnection.Create;
  FListConnection := TDictionary<string, TConnection>.Create;
  try
    Connection.Query.SQL.Add(ASQL);
    if DebugHook > 0 then
      TWKUtil.SaveSql(Connection.Query, 'OpenQuery');
 

    try
      Connection.Query.Open;
      Connection.Query.First;
      while not(Connection.Query.Eof) do
      begin
        IsEmpetyLine := False;
        lItem := DataSetToJSONObject(Connection.Query);
        for i := 0 to LListMapperAttributes.Count - 1 do
        begin
          if LListMapperAttributes[i].TypeField = TTypeFildTable.tpFObject then
          begin
            LNameTable := LListMapperAttributes[i].JSONObjectField.TableFK;
            if LNameTable <> '' then
            begin
              if not FListConnection.ContainsKey(LNameTable) then
              begin
                ConnectionObject := TConnection.Create;
                ConnectionObject.Query.Close;
                Obj := TWKUtil.GetResourceByName
                  (LListMapperAttributes[i].JSONObjectField.ResourceName);
                lFields := GetFields(Obj);
                lTableName := TWKUtil.GetTableName(Obj);
                lJoin := GetSqlJoin(Obj);

                if assigned(TJSONObject.ParseJSONValue(AValuesRequest.Search))
                then
                  lWhere := GetWhere('', Obj, AValuesRequest.Search)
                else
                  lWhere := GetWhere(Obj, '', AValuesRequest.Search, '',
                    TPesquisa.tpTodoCampo);
                lSQL := Format(SQL, [lFields, lTableName, lJoin,
                  lWhere, '', '']);
                lDados := OpenQuery(nil, lSQL);
                FListConnection.Add(LNameTable, ConnectionObject);
              end;
              if lDados.Count > 0 then
                GetIndexArray(LowerCase(TWKUtil.PascalCase(getFKNameField)),
                  GetValueMasterField);
            end;
          end;
        end;
        Result.AddElement(lItem);
        Connection.Query.Next;
      end;
    except
      on E: Exception do
      begin
        TWKUtil.SaveSql(Connection.Query, 'OpenQuery');
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message
          + ')').SendMessage(AValuesRequest.Response);
      end;
    end;
  finally
    Connection.Free;
    for LKey in FListConnection.Keys do
    begin
      FListConnection.Items[LKey].Free;
    end;
    FreeAndNil(FListConnection);
    FreeAndNil(LListMapperAttributes);
  end;
end;

class function TDAO.GetSqlJoin(Obj: TObject): string;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  Join: String;
  TableReference: string;
  ListJoinedTables: TStringList;
  LCountSubTables: Integer;
  LAliasTable: string;
  TableReferenceAlias: String;
begin
  Result := '';
  { By santa's 09-08-2023 }
  LCountSubTables := 1;
  ListJoinedTables := TStringList.Create;
  RttiType := TWKUtil.GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is FKConstraints then
      begin
        TableReference := (RttiAttribute as FKConstraints).TableReference;
        if (RttiAttribute as FKConstraints).MasterTable = '' then
          LAliasTable := TWKUtil.GetTableName(Obj) + '.'

        else
          LAliasTable := (RttiAttribute as FKConstraints).MasterTable + '.';
        TableReferenceAlias := TableReference;
        if ListJoinedTables.IndexOf(TableReference) > -1 then
        begin
          TableReferenceAlias := TableReference + inttostr(LCountSubTables);
          Inc(LCountSubTables);
        end;

        Join := 'INNER JOIN';
        if (RttiAttribute as FKConstraints).TipoJoin = LEFT then
          Join := 'LEFT JOIN'
        else if (RttiAttribute as FKConstraints).TipoJoin = RIGHT then
          Join := 'RIGHT'
        else if (RttiAttribute as FKConstraints).TipoJoin = FULL then
          Join := 'FULL JOIN';

        Result := Result + #13#10 + ' ' + Join + ' ' + TableReference + ' as ' +
          TableReferenceAlias;
        Result := Result + #13#10 + ' ON ' + TableReferenceAlias + '.' +
          (RttiAttribute as FKConstraints).KeyReference + ' = ' + LAliasTable +
          (RttiAttribute as FKConstraints).KeyField;

        ListJoinedTables.Add(TableReference);
      end;

end;

class procedure TDAO.DeleteDetails(RttiAttribute: TCustomAttribute;
  Obj, ResourceObj: TObject; Conn: TConnection);

var
  KeyValue: string;
  KeyName: string;
const
  SQL = 'DELETE FROM %s WHERE %s';
begin
  KeyValue := '';
  KeyValue := TWKUtil.GetRttiField((RttiAttribute as TResourceDetail).KeyField,
    Obj).GetValue(Obj).AsVariant;
  KeyName := TWKUtil.GetFieldAlias(  (RttiAttribute as TResourceDetail).KeyReference,ResourceObj);

  if KeyValue <> '' then
  begin
    Conn.Query.SQL.Clear;
    Conn.Query.SQL.Add(Format(SQL, [TWKUtil.GetTableName(ResourceObj),
      KeyName + '=' + KeyValue]));
    Conn.Query.ExecSQL;
  end;
end;

class function TDAO.DictionaryFields(Obj: TObject): TDictionary<String, string>;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
begin
  Result := TDictionary<string, string>.Create();
  RttiType := TWKUtil.GetRttiType(Obj);
  for RttiField in RttiType.GetFields do { For em todos os fields }
  begin
    Result.Add(RttiField.Name.ToLower, RttiField.FieldType.Name);
  end;

end;

end.
