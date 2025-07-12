unit eXactWMS_Serialize;

interface

uses
  System.JSON, System.Generics.Collections, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.DatS, FireDAC.Stan.Option,
  System.RTTI, System.SysUtils, System.Classes, System.Threading,
  System.DateUtils, Data.DB, System.Variants, System.StrUtils,
  FireDAC.Comp.DataSet, System.JSON.Writers, System.JSON.Types, System.IOUtils;

type
  TJsonFieldType = (jftSimple, jftObject, jftArray);
  TFieldTransform = reference to function(Value: TJSONValue): Variant;

  TFieldMapping = record
    FieldName: string;
    JsonPath: string;
    FieldType: TFieldType;
    JsonType: TJsonFieldType;
    Size: Integer;
    Precision: Integer;
    constructor Create(const AFieldName, AJsonPath: string;
      AFieldType: TFieldType; AJsonType: TJsonFieldType;
      ASize: Integer = 0; APrecision: Integer = 0);
  end;

  TTransformRules = class
  private
    FTransforms: TDictionary<string, TFieldTransform>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddTransform(const FieldName: string; Transform: TFieldTransform);
    function GetTransform(const FieldName: string): TFieldTransform;
  end;

  TFDMemTableJsonHelper = class
  private
    class var FStructureCache: TObjectDictionary<string, TFDMemTable>;

    class function GetJsonType(JsonValue: TJSONValue): TJsonFieldType;
    class function ResolveNestedValue(Root: TJSONValue; const Path: string): TJSONValue;
    class procedure ApplyComplexField(Field: TField; JsonValue: TJSONValue);
    class function CreateJsonFromField(Field: TField): TJSONValue;
    class procedure ApplyJsonToField(Field: TField; const Value: TJSONValue);
    class function InferFieldType(JsonValue: TJSONValue; out Size: Integer; out Precision: Integer): TFieldType;
    class procedure CreateFieldsFromJsonValue(DataSet: TFDDataSet; JsonValue: TJSONValue; MaxSamples: Integer = 10);
    class function TryStringToGUID(const Str: string; out GUID: TGUID): Boolean;
    class function IsDateTimeFormat(const Value: string): Boolean;
    class function DetermineFieldSize(JsonValue: TJSONValue; FieldName: string; MaxSamples: Integer): Integer;
    class function GetFirstJsonObject(JsonValue: TJSONValue): TJSONObject;
    class function LimitFieldSize(Size: Integer): Integer;
    class procedure InternalDeserializeJsonObjectToRecord(DataSet: TFDDataSet; JsonObj: TJSONObject);
    class procedure InternalDeserializeJsonArrayToDataset(DataSet: TFDDataSet; JsonArray: TJSONArray; MaxSamples: Integer);
    class function InternalSerializeRecordToJsonObject(DataSet: TFDDataSet): TJSONObject;
    class function InternalSerializeDatasetToJsonArray(DataSet: TFDDataSet): TJSONArray;

    // Métodos otimizados
    class procedure WriteFieldToJson(Writer: TJsonTextWriter; Field: TField);
    class procedure WriteRecordToJson(Writer: TJsonTextWriter; DataSet: TFDDataSet);

  public
    // Serialização
    class function SerializeRecordToJsonObject(DataSet: TFDDataSet): TJSONObject; overload;
    class function SerializeRecordToJsonObject(MemTable: TFDMemTable): TJSONObject; overload;
    class function SerializeRecordToJsonObject(Query: TFDQuery): TJSONObject; overload;

    class function SerializeDatasetToJsonArray(DataSet: TFDDataSet): TJSONArray; overload;
    class function SerializeDatasetToJsonArray(MemTable: TFDMemTable): TJSONArray; overload;
    class function SerializeDatasetToJsonArray(Query: TFDQuery): TJSONArray; overload;

    class function SerializeWithMetadata(MemTable: TFDMemTable): TJSONObject;
    class function SerializeNestedData(MemTable: TFDMemTable; const FieldMappings: array of TFieldMapping): TJSONObject;

    // Desserialização
    class procedure DeserializeJsonObjectToRecord(DataSet: TFDDataSet; JsonObj: TJSONObject); overload;
    class procedure DeserializeJsonObjectToRecord(MemTable: TFDMemTable; JsonObj: TJSONObject);  overload;
    class procedure DeserializeJsonObjectToRecord(Query: TFDQuery; JsonObj: TJSONObject); overload;

    class procedure DeserializeJsonArrayToDataset(DataSet: TFDDataSet; JsonArray: TJSONArray; MaxSamples: Integer = 10); overload;
    class procedure DeserializeJsonArrayToDataset(MemTable: TFDMemTable; JsonArray: TJSONArray; MaxSamples: Integer = 10); overload;
    class procedure DeserializeJsonArrayToDataset(Query: TFDQuery; JsonArray: TJSONArray; MaxSamples: Integer = 10); overload;

    class procedure DeserializeWithRules(MemTable: TFDMemTable; JsonObj: TJSONObject; Rules: TTransformRules);
    class procedure DeserializeNestedData(MemTable: TFDMemTable; JsonObj: TJSONObject; const FieldMappings: array of TFieldMapping);

    // Gerenciamento de Cache
    class procedure CacheStructure(const Key: string; MemTable: TFDMemTable);
    class function GetCachedStructure(const Key: string): TFDMemTable;

    // Operações Assíncronas
    class procedure DeserializeAsync(JsonArray: TJSONArray;
      OnProgress: TProc<Integer>;
      OnComplete: TProc<TFDMemTable>;
      OnError: TProc<Exception>);

    // Criação de MemTable
    class function CreateMemTableFromJson(JsonObj: TJSONObject): TFDMemTable; overload;
    class function CreateMemTableFromJson(JsonArray: TJSONArray): TFDMemTable; overload;

    // Serialização otimizada
    class function SerializeDatasetToJsonArrayFast(DataSet: TFDDataSet): string; overload;
    class function SerializeDatasetToJsonArrayFast(MemTable: TFDMemTable): string; overload;
    class function SerializeDatasetToJsonArrayFast(Query: TFDQuery): string; overload;

    class function SerializeDatasetToJsonStringUltraFast(DataSet: TFDDataSet): string;
    class function EscapeJsonString(const Value: string): string;
  end;

implementation

{ TFieldMapping }

constructor TFieldMapping.Create(const AFieldName, AJsonPath: string;
  AFieldType: TFieldType; AJsonType: TJsonFieldType; ASize: Integer = 0; APrecision: Integer = 0);
begin
  FieldName := AFieldName;
  JsonPath := AJsonPath;
  FieldType := AFieldType;
  JsonType := AJsonType;
  Size := ASize;
  Precision := APrecision;
end;

{ TTransformRules }

constructor TTransformRules.Create;
begin
  FTransforms := TDictionary<string, TFieldTransform>.Create;
end;

destructor TTransformRules.Destroy;
begin
  FTransforms.Free;
  inherited;
end;

procedure TTransformRules.AddTransform(const FieldName: string; Transform: TFieldTransform);
begin
  FTransforms.Add(FieldName, Transform);
end;

function TTransformRules.GetTransform(const FieldName: string): TFieldTransform;
begin
  if not FTransforms.TryGetValue(FieldName, Result) then
    Result := nil;
end;

{ TFDMemTableJsonHelper }

class function TFDMemTableJsonHelper.GetJsonType(JsonValue: TJSONValue): TJsonFieldType;
begin
  if JsonValue is TJSONObject then
    Result := jftObject
  else if JsonValue is TJSONArray then
    Result := jftArray
  else
    Result := jftSimple;
end;

class function TFDMemTableJsonHelper.ResolveNestedValue(Root: TJSONValue; const Path: string): TJSONValue;
var
  Parts: TArray<string>;
  Current: TJSONValue;
  I, Index: Integer;
begin
  if Root = nil then
    Exit(nil);

  Parts := Path.Split(['.']);
  Current := Root;

  for I := 0 to High(Parts) do
  begin
    if Current is TJSONObject then
      Current := TJSONObject(Current).GetValue(Parts[I])
    else if (Current is TJSONArray) and (Parts[I].StartsWith('[')) and (Parts[I].EndsWith(']')) then
    begin
      Index := StrToIntDef(Parts[I].Substring(1, Parts[I].Length - 2), -1);
      if (Index >= 0) and (Index < TJSONArray(Current).Count) then
        Current := TJSONArray(Current).Items[Index]
      else
        Exit(nil);
    end
    else
      Exit(nil);

    if Current = nil then
      Exit(nil);
  end;

  Result := Current;
end;

class procedure TFDMemTableJsonHelper.ApplyComplexField(Field: TField; JsonValue: TJSONValue);
begin
  if JsonValue <> nil then
    Field.AsString := JsonValue.ToJSON;
end;

class function TFDMemTableJsonHelper.TryStringToGUID(const Str: string; out GUID: TGUID): Boolean;
begin
  Result := False;
  try
    GUID := StringToGUID(Str);
    Result := True;
  except
    on E: EConvertError do
      Result := False;
  end;
end;

class procedure TFDMemTableJsonHelper.WriteFieldToJson(Writer: TJsonTextWriter;
  Field: TField);
begin
  Writer.WritePropertyName(LowerCase(Field.FieldName));

  if Field.IsNull then
    Writer.WriteNull
  else case Field.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Writer.WriteValue(Field.AsFloat);
    ftInteger, ftSmallint, ftWord, ftLongWord, ftByte:
      Writer.WriteValue(Field.AsInteger);
    ftBoolean:
      Writer.WriteValue(Field.AsBoolean);
    ftDate:
      Writer.WriteValue(FormatDateTime('yyyy-mm-dd', Field.AsDateTime));
    ftDateTime, ftTimeStamp:
      Writer.WriteValue(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Field.AsDateTime));
  else
    Writer.WriteValue(Field.AsString);
  end;
end;

class procedure TFDMemTableJsonHelper.WriteRecordToJson(Writer: TJsonTextWriter;
  DataSet: TFDDataSet);
var
  I: Integer;
begin
  Writer.WriteStartObject;
  try
    for I := 0 to DataSet.FieldCount - 1 do
      WriteFieldToJson(Writer, DataSet.Fields[I]);
  finally
    Writer.WriteEndObject;
  end;
end;

class function TFDMemTableJsonHelper.IsDateTimeFormat(const Value: string): Boolean;
var
  Dummy: TDateTime;
begin
  Result := TryStrToDateTime(Value, Dummy);
end;

class function TFDMemTableJsonHelper.LimitFieldSize(Size: Integer): Integer;
begin
  Result := Size;
  if Result < 1 then
    Result := 1;       // Tamanho mínimo de 1 caractere
  if Result > 8000 then
    Result := 8000;    // Tamanho máximo de 8000 caracteres
end;

class function TFDMemTableJsonHelper.InferFieldType(JsonValue: TJSONValue; out Size: Integer; out Precision: Integer): TFieldType;
var
  NumStr: string;
  DotPos: Integer;
begin
  Size := 0;
  Precision := 0;

  if JsonValue is TJSONNumber then
  begin
    NumStr := JsonValue.Value;
    DotPos := Pos('.', NumStr);

    if DotPos > 0 then
    begin
      Result := ftFloat;
      Precision := Length(NumStr) - DotPos;
    end
    else
      Result := ftInteger;
  end
  else if JsonValue is TJSONBool then
    Result := ftBoolean
  else if JsonValue is TJSONString then
  begin
    if IsDateTimeFormat(JsonValue.Value) then
      Result := ftDateTime
    else if (Length(JsonValue.Value) = 38) and (JsonValue.Value[1] = '{') then
      Result := ftGuid
    else
    begin
      Result := ftString;
      Size := Length(JsonValue.Value);
      if Size > 8000 then
        Size := 8000;
    end;
  end
  else if JsonValue is TJSONNull then
    Result := ftUnknown
  else
    Result := ftString;
end;

class procedure TFDMemTableJsonHelper.InternalDeserializeJsonArrayToDataset(
  DataSet: TFDDataSet; JsonArray: TJSONArray; MaxSamples: Integer);
begin
  if (DataSet = nil) or (JsonArray = nil) or (JsonArray.Count = 0) then Exit;

  CreateFieldsFromJsonValue(DataSet, JsonArray, MaxSamples);

  DataSet.DisableControls;
  try
    for var I := 0 to JsonArray.Count - 1 do
      if JsonArray.Items[I] is TJSONObject then
        InternalDeserializeJsonObjectToRecord(DataSet, TJSONObject(JsonArray.Items[I]));
  finally
    DataSet.EnableControls;
  end;
end;

class procedure TFDMemTableJsonHelper.InternalDeserializeJsonObjectToRecord(
  DataSet: TFDDataSet; JsonObj: TJSONObject);
begin
  if (DataSet = nil) or (JsonObj = nil) then Exit;

  DataSet.Append;
  try
    for var I := 0 to JsonObj.Count - 1 do
    begin
      var Field := DataSet.FindField(LowerCase(JsonObj.Pairs[I].JsonString.Value));
      if Assigned(Field) then
        ApplyJsonToField(Field, JsonObj.Pairs[I].JsonValue);
    end;
    DataSet.Post;
  except
    DataSet.Cancel;
    raise;
  end;
end;

class function TFDMemTableJsonHelper.InternalSerializeDatasetToJsonArray(
  DataSet: TFDDataSet): TJSONArray;
var
  Bookmark: TBookmark;
begin
  Result := TJSONArray.Create;
  try
    DataSet.DisableControls;
    try
      Bookmark := DataSet.GetBookmark;
      try
        DataSet.First;
        while not DataSet.Eof do
        begin
          Result.AddElement(InternalSerializeRecordToJsonObject(DataSet));
          DataSet.Next;
        end;
      finally
        DataSet.GotoBookmark(Bookmark);
        DataSet.FreeBookmark(Bookmark);
      end;
    finally
      DataSet.EnableControls;
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TFDMemTableJsonHelper.InternalSerializeRecordToJsonObject(
  DataSet: TFDDataSet): TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    for var I := 0 to DataSet.FieldCount - 1 do
      Result.AddPair(LowerCase(DataSet.Fields[I].FieldName), CreateJsonFromField(DataSet.Fields[I]));
  except
    Result.Free;
    raise;
  end;
end;

class procedure TFDMemTableJsonHelper.CreateFieldsFromJsonValue(DataSet: TFDDataSet; JsonValue: TJSONValue; MaxSamples: Integer = 10);
Var
  FirstObj: TJSONObject;
  I: Integer;
  FieldType: TFieldType;
  FieldName: string;
  FieldSize: Integer;
begin
  FirstObj := GetFirstJsonObject(JsonValue);
  if FirstObj = nil then Exit;

  DataSet.FieldDefs.Clear;

  for I := 0 to FirstObj.Count - 1 do
  begin
    // Padroniza nome do campo para minúsculo
    FieldName := LowerCase(FirstObj.Pairs[I].JsonString.Value);

    if FirstObj.Pairs[I].JsonValue is TJSONNumber then
    begin
      if Pos('.', FirstObj.Pairs[I].JsonValue.Value) > 0 then
        FieldType := ftFloat
      else
        FieldType := ftInteger;
      FieldSize := 0;
    end
    else if FirstObj.Pairs[I].JsonValue is TJSONBool then
    begin
      FieldType := ftBoolean;
      FieldSize := 0;
    end
    else
    begin
      FieldType := ftString;
      // Determina tamanho máximo baseado em amostragem
      FieldSize := DetermineFieldSize(JsonValue, FirstObj.Pairs[I].JsonString.Value, MaxSamples);
      // Aplica limites de tamanho
      FieldSize := LimitFieldSize(FieldSize);
    end;

    DataSet.FieldDefs.Add(FieldName, FieldType, FieldSize);
  end;

  if DataSet.Active then
    DataSet.Close;
  DataSet.CreateDataSet;
end;

class function TFDMemTableJsonHelper.CreateJsonFromField(Field: TField): TJSONValue;
begin
  if Field.IsNull then
    Exit(TJSONNull.Create);

  case Field.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result := TJSONNumber.Create(Field.AsFloat);
    ftInteger, ftSmallint, ftWord, ftLongWord, ftByte:
      Result := TJSONNumber.Create(Field.AsInteger);
    ftBoolean:
      Result := TJSONBool.Create(Field.AsBoolean);
    else
      Result := TJSONString.Create(Field.AsString);
  end;
end;

class procedure TFDMemTableJsonHelper.ApplyJsonToField(Field: TField; const Value: TJSONValue);
var
  FormatSettings: TFormatSettings;
begin
  if Value is TJSONNull then
  begin
    Field.Clear;
    Exit;
  end;

  FormatSettings := TFormatSettings.Create;
  FormatSettings.DecimalSeparator := '.';

  try
    case Field.DataType of
      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        if Value is TJSONNumber then
          Field.AsFloat := TJSONNumber(Value).AsDouble
        else
          Field.AsFloat := StrToFloat(Value.Value, FormatSettings);

      ftInteger, ftSmallint, ftWord, ftLongWord, ftByte:
        if Value is TJSONNumber then
          Field.AsInteger := TJSONNumber(Value).AsInt
        else
          Field.AsInteger := StrToIntDef(Value.Value, 0);

      ftBoolean:
        if Value is TJSONBool then
          Field.AsBoolean := TJSONBool(Value).AsBoolean
        else
          Field.AsBoolean := StrToBoolDef(Value.Value, False);

      else
        Field.AsString := Value.Value;
    end;
  except
    Field.Clear;
  end;
end;

class function TFDMemTableJsonHelper.SerializeRecordToJsonObject(MemTable: TFDMemTable): TJSONObject;
begin
  Result := InternalSerializeRecordToJsonObject(MemTable);
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonArray(MemTable: TFDMemTable): TJSONArray;
begin
  Result := InternalSerializeDatasetToJsonArray(MemTable);
end;

class function TFDMemTableJsonHelper.SerializeWithMetadata(MemTable: TFDMemTable): TJSONObject;
var
  MetaArray: TJSONArray;
  I: Integer;
begin
  Result := TJSONObject.Create;
  try
    Result.AddPair('data', SerializeDatasetToJsonArray(MemTable));

    MetaArray := TJSONArray.Create;
    for I := 0 to MemTable.FieldCount - 1 do
    begin
      MetaArray.AddElement(TJSONObject.Create
        .AddPair('name', MemTable.Fields[I].FieldName)
        .AddPair('type', TRttiEnumerationType.GetName(MemTable.Fields[I].DataType))
        .AddPair('size', TJSONNumber.Create(MemTable.Fields[I].Size)));
    end;

    Result.AddPair('metadata', MetaArray);
  except
    Result.Free;
    raise;
  end;
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonArray(
  Query: TFDQuery): TJSONArray;
begin
  Result := InternalSerializeDatasetToJsonArray(Query);
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonArrayFast(
  DataSet: TFDDataSet): string;
var
  StringWriter: TStringWriter;
  JsonWriter: TJsonTextWriter;
  Bookmark: TBookmark;
begin
  Result := '';
  if not Assigned(DataSet) or not DataSet.Active then Exit;

  StringWriter := TStringWriter.Create;
  try
    JsonWriter := TJsonTextWriter.Create(StringWriter);
    try
      JsonWriter.Formatting := TJsonFormatting.None;

      DataSet.DisableControls;
      try
        Bookmark := DataSet.GetBookmark;
        try
          JsonWriter.WriteStartArray;

          DataSet.First;
          while not DataSet.Eof do
          begin
            WriteRecordToJson(JsonWriter, DataSet);
            DataSet.Next;
          end;

          JsonWriter.WriteEndArray;

          DataSet.GotoBookmark(Bookmark);
        finally
          DataSet.FreeBookmark(Bookmark);
        end;
      finally
        DataSet.EnableControls;
      end;
    finally
      JsonWriter.Free;
    end;
    Result := StringWriter.ToString;
  finally
    StringWriter.Free;
  end;
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonArrayFast(
  MemTable: TFDMemTable): string;
begin
  Result := SerializeDatasetToJsonArrayFast(TFDDataSet(MemTable));
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonArrayFast(
  Query: TFDQuery): string;
begin
  Result := SerializeDatasetToJsonArrayFast(TFDDataSet(Query));
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonStringUltraFast(
  DataSet: TFDDataSet): string;
var
  StringBuilder: TStringBuilder;
  Field: TField;
  FirstRecord: Boolean;
  FirstField: Boolean;
begin
  if not Assigned(DataSet) or not DataSet.Active or (DataSet.RecordCount = 0) then
    Exit('[]');

  StringBuilder := TStringBuilder.Create;
  try
    StringBuilder.Append('[');

    DataSet.DisableControls;
    try
      FirstRecord := True;
      DataSet.First;
      while not DataSet.Eof do
      begin
        if not FirstRecord then
          StringBuilder.Append(',');
        FirstRecord := False;

        StringBuilder.Append('{');

        FirstField := True;
        for Field in DataSet.Fields do
        begin
          if not FirstField then
            StringBuilder.Append(',');
          FirstField := False;

          // Nome do campo
          StringBuilder.Append('"').Append(LowerCase(Field.FieldName)).Append('":');

          // Valor do campo
          if Field.IsNull then
            StringBuilder.Append('null')
          else case Field.DataType of
            ftFloat, ftCurrency, ftBCD, ftFMTBcd:
              StringBuilder.Append(Field.AsFloat.ToString);
            ftInteger, ftSmallint, ftWord, ftLongWord, ftByte:
              StringBuilder.Append(Field.AsInteger.ToString);
            ftBoolean:
              if Field.AsBoolean then
                StringBuilder.Append('true')
              else
                StringBuilder.Append('false');
            ftDate:
              StringBuilder.Append('"').Append(FormatDateTime('yyyy-mm-dd', Field.AsDateTime)).Append('"');
            ftDateTime, ftTimeStamp:
              StringBuilder.Append('"').Append(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Field.AsDateTime)).Append('"');
            ftGuid:
              StringBuilder.Append('"').Append(Field.AsString).Append('"');
            else
              // Strings e outros tipos
              StringBuilder.Append('"').Append(EscapeJsonString(Field.AsString)).Append('"');
          end;
        end;

        StringBuilder.Append('}');
        DataSet.Next;
      end;
    finally
      DataSet.EnableControls;
    end;

    StringBuilder.Append(']');
    Result := StringBuilder.ToString;
  finally
    StringBuilder.Free;
  end;
end;

class function TFDMemTableJsonHelper.SerializeDatasetToJsonArray(
  DataSet: TFDDataSet): TJSONArray;
begin
  Result := InternalSerializeDatasetToJsonArray(DataSet);
end;

class function TFDMemTableJsonHelper.SerializeNestedData(MemTable: TFDMemTable;
  const FieldMappings: array of TFieldMapping): TJSONObject;
var
  I: Integer;
  Mapping: TFieldMapping;
  JsonValue: TJSONValue;
begin
  Result := TJSONObject.Create;
  try
    for I := 0 to High(FieldMappings) do
    begin
      Mapping := FieldMappings[I];
      case Mapping.JsonType of
        jftSimple:
          JsonValue := TJSONString.Create(MemTable.FieldByName(Mapping.FieldName).AsString);
        jftObject:
          JsonValue := TJSONObject.ParseJSONValue(MemTable.FieldByName(Mapping.FieldName).AsString);
        jftArray:
          JsonValue := TJSONArray.ParseJSONValue(MemTable.FieldByName(Mapping.FieldName).AsString);
      end;

      if JsonValue <> nil then
        Result.AddPair(Mapping.JsonPath, JsonValue);
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TFDMemTableJsonHelper.SerializeRecordToJsonObject(
  DataSet: TFDDataSet): TJSONObject;
begin
  Result := InternalSerializeRecordToJsonObject(DataSet);
end;

class function TFDMemTableJsonHelper.SerializeRecordToJsonObject(
  Query: TFDQuery): TJSONObject;
begin
  Result := InternalSerializeRecordToJsonObject(Query);
end;

class procedure TFDMemTableJsonHelper.DeserializeJsonObjectToRecord(MemTable: TFDMemTable; JsonObj: TJSONObject);
begin
  InternalDeserializeJsonObjectToRecord(MemTable, JsonObj);
end;

class procedure TFDMemTableJsonHelper.DeserializeJsonArrayToDataset(MemTable: TFDMemTable; JsonArray: TJSONArray; MaxSamples: Integer = 10);
begin
  InternalDeserializeJsonArrayToDataset(MemTable, JsonArray, MaxSamples);
end;

class procedure TFDMemTableJsonHelper.DeserializeWithRules(MemTable: TFDMemTable;
  JsonObj: TJSONObject; Rules: TTransformRules);
begin
   if (MemTable = nil) or (JsonObj = nil) then
    Exit;

  // Recria estrutura
  MemTable.FieldDefs.Clear;
  CreateFieldsFromJsonValue(MemTable, JsonObj);

  if MemTable.FieldDefs.Count = 0 then
    Exit;

  if MemTable.Active then
    MemTable.Close;
  MemTable.CreateDataSet;

  MemTable.Append;
  try
    for var I := 0 to JsonObj.Count - 1 do
    begin
      var JsonPair := JsonObj.Pairs[I];
      var Field := MemTable.FindField(JsonPair.JsonString.Value);

      if Assigned(Field) then
      begin
        var Transform := Rules.GetTransform(Field.FieldName);
        if Assigned(Transform) then
          Field.Value := Transform(JsonPair.JsonValue)
        else
          ApplyJsonToField(Field, JsonPair.JsonValue);
      end;
    end;
    MemTable.Post;
  except
    MemTable.Cancel;
    raise;
  end;
end;

class function TFDMemTableJsonHelper.DetermineFieldSize(JsonValue: TJSONValue;
  FieldName: string; MaxSamples: Integer): Integer;
var
  I, SampleCount: Integer;
  JsonObj: TJSONObject;
  JsonArray: TJSONArray;
  CurrentLength: Integer;
begin
  Result := 100; // Valor padrão se não encontrar amostras

  if JsonValue is TJSONObject then
  begin
    JsonObj := TJSONObject(JsonValue);
    if JsonObj.GetValue(FieldName) is TJSONString then
    begin
      CurrentLength := Length(JsonObj.GetValue(FieldName).Value);
      if CurrentLength > Result then
        Result := CurrentLength;
    end;
  end
  else if JsonValue is TJSONArray then
  begin
    JsonArray := TJSONArray(JsonValue);
    SampleCount := 0;
    for I := 0 to JsonArray.Count - 1 do
    begin
      if SampleCount >= MaxSamples then Break;

      if (JsonArray.Items[I] is TJSONObject) and
         (TJSONObject(JsonArray.Items[I]).GetValue(FieldName) is TJSONString) then
      begin
        CurrentLength := Length(TJSONObject(JsonArray.Items[I]).GetValue(FieldName).Value);
        if CurrentLength > Result then
          Result := CurrentLength;
        Inc(SampleCount);
      end;
    end;
  end;
end;

class function TFDMemTableJsonHelper.EscapeJsonString(
  const Value: string): string;
var
  I: Integer;
  Len: Integer;
  P: PChar;
begin
  Result := '';
  Len := Length(Value);
  if Len = 0 then Exit;

  P := PChar(Value);
  I := 0;
  while I < Len do
  begin
    case P^ of
      '"': Result := Result + '\"';
      '\': Result := Result + '\\';
      '/': Result := Result + '\/';
      #8: Result := Result + '\b';
      #9: Result := Result + '\t';
      #10: Result := Result + '\n';
      #12: Result := Result + '\f';
      #13: Result := Result + '\r';
    else
      if P^ < ' ' then
        Result := Result + '\u' + IntToHex(Ord(P^), 4)
      else
        Result := Result + P^;
    end;
    Inc(I);
    Inc(P);
  end;
end;

class procedure TFDMemTableJsonHelper.DeserializeNestedData(MemTable: TFDMemTable;
  JsonObj: TJSONObject; const FieldMappings: array of TFieldMapping);
begin
  if (MemTable = nil) or (JsonObj = nil) then
    Exit;

  // Cria estrutura baseada no mapeamento
  MemTable.FieldDefs.Clear;
  for var Mapping in FieldMappings do
  begin
    var FieldDef := MemTable.FieldDefs.AddFieldDef;
    FieldDef.Name := Mapping.FieldName;
    FieldDef.DataType := Mapping.FieldType;
    FieldDef.Size := Mapping.Size;
    if Mapping.Precision > 0 then
      FieldDef.Precision := Mapping.Precision;
  end;

  if MemTable.FieldDefs.Count = 0 then
    Exit;

  if MemTable.Active then
    MemTable.Close;
  MemTable.CreateDataSet;

  MemTable.Append;
  try
    for var Mapping in FieldMappings do
    begin
      var JsonValue := ResolveNestedValue(JsonObj, Mapping.JsonPath);
      var Field := MemTable.FieldByName(Mapping.FieldName);

      if Assigned(JsonValue) then
      begin
        case Mapping.JsonType of
          jftSimple: ApplyJsonToField(Field, JsonValue);
          jftObject, jftArray: Field.AsString := JsonValue.ToJSON;
        end;
      end;
    end;
    MemTable.Post;
  except
    MemTable.Cancel;
    raise;
  end;
end;

class procedure TFDMemTableJsonHelper.CacheStructure(const Key: string; MemTable: TFDMemTable);
var
  Clone: TFDMemTable;
begin
  Clone := TFDMemTable.Create(nil);
  Clone.CopyDataSet(MemTable, [coStructure]);
  FStructureCache.AddOrSetValue(Key, Clone);
end;

class function TFDMemTableJsonHelper.GetCachedStructure(const Key: string): TFDMemTable;
var
  CachedMT: TFDMemTable;
begin
  if FStructureCache.TryGetValue(Key, CachedMT) then
  begin
    Result := TFDMemTable.Create(nil);
    Result.CopyDataSet(CachedMT, [coStructure]);
  end
  else
    Result := nil;
end;

class function TFDMemTableJsonHelper.GetFirstJsonObject(
  JsonValue: TJSONValue): TJSONObject;
begin
  Result := nil;
  if JsonValue is TJSONObject then
    Result := TJSONObject(JsonValue)
  else if (JsonValue is TJSONArray) and (TJSONArray(JsonValue).Count > 0) and
          (TJSONArray(JsonValue).Items[0] is TJSONObject) then
    Result := TJSONObject(TJSONArray(JsonValue).Items[0]);
end;

class procedure TFDMemTableJsonHelper.DeserializeAsync(JsonArray: TJSONArray;
  OnProgress: TProc<Integer>; OnComplete: TProc<TFDMemTable>; OnError: TProc<Exception>);
var
  Thread: TThread;
begin
  Thread := TThread.CreateAnonymousThread(
    procedure
    var
      LocalMT: TFDMemTable;
      I: Integer;
    begin
      try
        LocalMT := TFDMemTable.Create(nil);
        try
          for I := 0 to JsonArray.Count - 1 do
          begin
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                if Assigned(OnProgress) then
                  OnProgress(I * 100 div JsonArray.Count);
              end);

            LocalMT.Append;
            DeserializeJsonObjectToRecord(LocalMT, JsonArray.Items[I] as TJSONObject);
            LocalMT.Post;
          end;

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              if Assigned(OnComplete) then
                OnComplete(LocalMT);
            end);
        except
          LocalMT.Free;
          raise;
        end;
      except
        on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              if Assigned(OnError) then
                OnError(E);
            end);
        end;
      end;
    end);
  Thread.FreeOnTerminate := True;
  Thread.Start;
end;

class function TFDMemTableJsonHelper.CreateMemTableFromJson(JsonObj: TJSONObject): TFDMemTable;
begin
  Result := TFDMemTable.Create(nil);
  try
    DeserializeJsonObjectToRecord(Result, JsonObj);
  except
    Result.Free;
    raise;
  end;
end;

class function TFDMemTableJsonHelper.CreateMemTableFromJson(JsonArray: TJSONArray): TFDMemTable;
begin
  if JsonArray.Count = 0 then
    raise Exception.Create('JSON array is empty - cannot infer structure');

  Result := TFDMemTable.Create(nil);
  try
    DeserializeJsonArrayToDataset(Result, JsonArray);
  except
    Result.Free;
    raise;
  end;
end;

class procedure TFDMemTableJsonHelper.DeserializeJsonArrayToDataset(
  Query: TFDQuery; JsonArray: TJSONArray; MaxSamples: Integer);
begin
  InternalDeserializeJsonArrayToDataset(Query, JsonArray, MaxSamples);
end;

class procedure TFDMemTableJsonHelper.DeserializeJsonArrayToDataset(
  DataSet: TFDDataSet; JsonArray: TJSONArray; MaxSamples: Integer);
begin
  InternalDeserializeJsonArrayToDataset(DataSet, JsonArray, MaxSamples);
end;

class procedure TFDMemTableJsonHelper.DeserializeJsonObjectToRecord(
  DataSet: TFDDataSet; JsonObj: TJSONObject);
begin
  InternalDeserializeJsonObjectToRecord(DataSet, JsonObj);
end;

class procedure TFDMemTableJsonHelper.DeserializeJsonObjectToRecord(
  Query: TFDQuery; JsonObj: TJSONObject);
begin
  InternalDeserializeJsonObjectToRecord(Query, JsonObj);
end;

initialization
  TFDMemTableJsonHelper.FStructureCache := TObjectDictionary<string, TFDMemTable>.Create([doOwnsValues]);

finalization
  TFDMemTableJsonHelper.FStructureCache.Free;

end.
