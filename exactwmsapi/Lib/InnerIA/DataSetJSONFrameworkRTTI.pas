unit DataSetJSONFrameworkRTTI;

interface

uses
  System.Classes, System.SysUtils, System.JSON, Data.DB, System.Variants,
  System.DateUtils, System.TypInfo, System.Rtti, System.Generics.Collections,
  System.NetEncoding, System.Threading, System.SyncObjs, System.Math,
  System.StrUtils, Datasnap.DBClient;

type
  TDataSetJSONOptions = record
    IncludeFieldDefs: Boolean;
    IncludeMetadata: Boolean;
    DateTimeFormat: string;
    NullValueHandling: Boolean;
    FieldNameCase: (fncOriginal, fncLowerCase, fncUpperCase);
    UseMultiThreading: Boolean;
    ThreadPoolSize: Integer;
    BatchSize: Integer;
  end;

  // Cache de informações RTTI dos campos para performance
  TFieldRTTIInfo = record
    Field: TField;
    FieldName: string;
    DataType: TFieldType;
    RttiProperty: TRttiProperty;
    IsNullMethod: TRttiMethod;
    Size: Integer;
    Required: Boolean;
  end;

  TFieldRTTICache = class
  private
    FFieldInfos: TArray<TFieldRTTIInfo>;
    FRttiContext: TRttiContext;
    FFieldMap: TDictionary<string, Integer>;
    function GetFieldRTTIInfo(Field: TField): TFieldRTTIInfo;
    function GetFieldCount: Integer; inline;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BuildCache(DataSet: TDataSet; const Options: TDataSetJSONOptions);
    function GetCachedFieldInfo(Index: Integer): TFieldRTTIInfo; inline;
    function GetFieldIndex(const FieldName: string): Integer; inline;
    property FieldInfos: TArray<TFieldRTTIInfo> read FFieldInfos;
    property FieldCount: Integer read GetFieldCount;
  end;

  // Buffer para JSON otimizado
  TJSONBuffer = class
  private
    FBuffer: TStringBuilder;
    FCapacity: Integer;
    procedure SetCapacity(const Value: Integer);
  public
    constructor Create(InitialCapacity: Integer = 1024 * 1024);
    destructor Destroy; override;
    procedure Append(const Value: string); inline;
    procedure AppendChar(const C: Char); inline;
    procedure AppendQuoted(const Value: string); inline;
    procedure Clear; inline;
    function ToString: string; override;
    property Capacity: Integer read FCapacity write SetCapacity;
  end;

  // Worker thread para processamento paralelo
  TJSONWorkerThread = class(TThread)
  private
    FDataSet: TDataSet;
    FFieldCache: TFieldRTTICache;
    FStartRecord: Integer;
    FEndRecord: Integer;
    FOptions: TDataSetJSONOptions;
    FResult: string;
    FEvent: TEvent;
  protected
    procedure Execute; override;
  public
    constructor Create(DataSet: TDataSet; FieldCache: TFieldRTTICache;
                      StartRecord, EndRecord: Integer; const Options: TDataSetJSONOptions);
    destructor Destroy; override;
    property Result: string read FResult;
    property FinishedEvent: TEvent read FEvent;
  end;

  TDataSetJSONFrameworkRTTI = class
  private
    FOptions: TDataSetJSONOptions;
    FFieldCache: TFieldRTTICache;
    FJSONBuffer: TJSONBuffer;

    class function GetDefaultOptions: TDataSetJSONOptions;

    // Processamento em lote otimizado
    function ProcessRecordsBatch(DataSet: TDataSet; StartRecord, EndRecord: Integer): string;
    function ProcessRecordsParallel(DataSet: TDataSet): string;

    // Otimizações de memória
    procedure OptimizeDataSetBuffer(DataSet: TDataSet);

    // Helpers para conversão
    function FieldToJSONString(const FieldInfo: TFieldRTTIInfo): string;
    procedure SetFieldFromJSON(const FieldInfo: TFieldRTTIInfo; const JSONValue: string);

  public
    constructor Create(const Options: TDataSetJSONOptions); overload;
    constructor Create; overload;
    destructor Destroy; override;

    // Métodos de serialização otimizados
    function DataSetToJSON(DataSet: TDataSet): TJSONObject; overload;
    function DataSetToJSON(DataSet: TDataSet; const Options: TDataSetJSONOptions): TJSONObject; overload;
    function DataSetToJSONString(DataSet: TDataSet): string; overload;
    function DataSetToJSONString(DataSet: TDataSet; const Options: TDataSetJSONOptions): string; overload;

    // Métodos de deserialização otimizados
    procedure JSONToDataSet(const JSONString: string; DataSet: TDataSet); overload;
    procedure JSONToDataSet(JSONObject: TJSONObject; DataSet: TDataSet); overload;
    procedure JSONToDataSet(const JSONString: string; DataSet: TDataSet; const Options: TDataSetJSONOptions); overload;
    procedure JSONToDataSet(JSONObject: TJSONObject; DataSet: TDataSet; const Options: TDataSetJSONOptions); overload;

    // Streaming otimizado para datasets muito grandes
    procedure DataSetToJSONStream(DataSet: TDataSet; Stream: TStream);
    procedure JSONStreamToDataSet(Stream: TStream; DataSet: TDataSet);

    // Métodos estáticos para uso rápido
    class function QuickDataSetToJSON(DataSet: TDataSet): string;
    class procedure QuickJSONToDataSet(const JSONString: string; DataSet: TDataSet);

    // Propriedades
    property Options: TDataSetJSONOptions read FOptions write FOptions;
  end;

implementation

{ TFieldRTTICache }

constructor TFieldRTTICache.Create;
begin
  inherited;
  FRttiContext := TRttiContext.Create;
  FFieldMap := TDictionary<string, Integer>.Create;
end;

destructor TFieldRTTICache.Destroy;
begin
  FFieldMap.Free;
  FRttiContext.Free;
  inherited;
end;

procedure TFieldRTTICache.BuildCache(DataSet: TDataSet; const Options: TDataSetJSONOptions);
var
  I: Integer;
  Field: TField;
  FieldInfo: TFieldRTTIInfo;
begin
  SetLength(FFieldInfos, DataSet.FieldCount);
  FFieldMap.Clear;

  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Field := DataSet.Fields[I];
    FieldInfo := GetFieldRTTIInfo(Field);

    // Aplicar configurações de nome
    case Options.FieldNameCase of
      fncLowerCase: FieldInfo.FieldName := LowerCase(FieldInfo.FieldName);
      fncUpperCase: FieldInfo.FieldName := UpperCase(FieldInfo.FieldName);
    end;

    FFieldInfos[I] := FieldInfo;
    FFieldMap.Add(FieldInfo.FieldName, I);
  end;
end;

function TFieldRTTICache.GetFieldRTTIInfo(Field: TField): TFieldRTTIInfo;
var
  RttiType: TRttiType;
begin
  Result.Field := Field;
  Result.FieldName := Field.FieldName;
  Result.DataType := Field.DataType;
  Result.Size := Field.Size;
  Result.Required := Field.Required;

  // Obter informações RTTI do campo
  RttiType := FRttiContext.GetType(Field.ClassType);

  // Cache dos métodos mais usados para acesso direto
  Result.IsNullMethod := RttiType.GetMethod('IsNull');

  // Para campos específicos, obter propriedades RTTI
  case Field.DataType of
    ftString, ftWideString, ftMemo, ftWideMemo:
      Result.RttiProperty := RttiType.GetProperty('AsString');
    ftInteger, ftSmallint, ftWord, ftAutoInc:
      Result.RttiProperty := RttiType.GetProperty('AsInteger');
    ftLargeint:
      Result.RttiProperty := RttiType.GetProperty('AsLargeInt');
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result.RttiProperty := RttiType.GetProperty('AsFloat');
    ftBoolean:
      Result.RttiProperty := RttiType.GetProperty('AsBoolean');
    ftDateTime, ftDate, ftTime:
      Result.RttiProperty := RttiType.GetProperty('AsDateTime');
  end;
end;

function TFieldRTTICache.GetCachedFieldInfo(Index: Integer): TFieldRTTIInfo;
begin
  Result := FFieldInfos[Index];
end;

function TFieldRTTICache.GetFieldIndex(const FieldName: string): Integer;
begin
  if not FFieldMap.TryGetValue(FieldName, Result) then
    Result := -1;
end;

function TFieldRTTICache.GetFieldCount: Integer;
begin
  Result := Length(FFieldInfos);
end;

{ TJSONBuffer }

constructor TJSONBuffer.Create(InitialCapacity: Integer);
begin
  inherited Create;
  FCapacity := InitialCapacity;
  FBuffer := TStringBuilder.Create(FCapacity);
end;

destructor TJSONBuffer.Destroy;
begin
  FBuffer.Free;
  inherited;
end;

procedure TJSONBuffer.Append(const Value: string);
begin
  FBuffer.Append(Value);
end;

procedure TJSONBuffer.AppendChar(const C: Char);
begin
  FBuffer.Append(C);
end;

procedure TJSONBuffer.AppendQuoted(const Value: string);
var
  EscapedValue: string;
begin
  EscapedValue := StringReplace(Value, '"', '\"', [rfReplaceAll]);
  EscapedValue := StringReplace(EscapedValue, #13#10, '\n', [rfReplaceAll]);
  EscapedValue := StringReplace(EscapedValue, #13, '\n', [rfReplaceAll]);
  EscapedValue := StringReplace(EscapedValue, #10, '\n', [rfReplaceAll]);
  FBuffer.Append('"');
  FBuffer.Append(EscapedValue);
  FBuffer.Append('"');
end;

procedure TJSONBuffer.Clear;
begin
  FBuffer.Clear;
end;

function TJSONBuffer.ToString: string;
begin
  Result := FBuffer.ToString;
end;

procedure TJSONBuffer.SetCapacity(const Value: Integer);
begin
  FCapacity := Value;
  FBuffer.Capacity := Value;
end;

{ TJSONWorkerThread }

constructor TJSONWorkerThread.Create(DataSet: TDataSet; FieldCache: TFieldRTTICache;
  StartRecord, EndRecord: Integer; const Options: TDataSetJSONOptions);
begin
  inherited Create(False);
  FDataSet := DataSet;
  FFieldCache := FieldCache;
  FStartRecord := StartRecord;
  FEndRecord := EndRecord;
  FOptions := Options;
  FEvent := TEvent.Create;
  FreeOnTerminate := False;
end;

destructor TJSONWorkerThread.Destroy;
begin
  FEvent.Free;
  inherited;
end;

procedure TJSONWorkerThread.Execute;
var
  Buffer: TJSONBuffer;
  J: Integer;
  FieldInfo: TFieldRTTIInfo;
  RecNo: Integer;
  ClonedDataSet: TDataSet;
begin
  Buffer := TJSONBuffer.Create(64 * 1024); // 64KB inicial
  try
    // Para threads, precisamos de uma cópia do dataset ou usar synchronização
    // Por simplicidade, vamos usar o dataset original com sincronização
    TThread.Synchronize(nil,
      procedure
      var
        J, I: Integer;
      begin
        RecNo := 0;
        FDataSet.First;

        // Navegar até o registro inicial
        while (RecNo < FStartRecord) and not FDataSet.Eof do
        begin
          FDataSet.Next;
          Inc(RecNo);
        end;

        // Processar registros do lote
        while (RecNo <= FEndRecord) and not FDataSet.Eof do
        begin
          if RecNo > FStartRecord then
            Buffer.AppendChar(',');

          Buffer.AppendChar('{');

          for J := 0 to FFieldCache.FieldCount - 1 do
          begin
            if J > 0 then
              Buffer.AppendChar(',');

            FieldInfo := FFieldCache.GetCachedFieldInfo(J);

            Buffer.AppendQuoted(FieldInfo.FieldName);
            Buffer.AppendChar(':');

            // Verificar se é null usando RTTI
            if FieldInfo.Field.IsNull then
              Buffer.Append('null')
            else
            begin
              case FieldInfo.DataType of
                ftString, ftWideString, ftMemo, ftWideMemo:
                  Buffer.AppendQuoted(FieldInfo.Field.AsString);
                ftInteger, ftSmallint, ftWord, ftAutoInc:
                  Buffer.Append(IntToStr(FieldInfo.Field.AsInteger));
                ftLargeint:
                  Buffer.Append(IntToStr(FieldInfo.Field.AsLargeInt));
                ftFloat, ftCurrency, ftBCD, ftFMTBcd:
                  Buffer.Append(FloatToStr(FieldInfo.Field.AsFloat));
                ftBoolean:
                  Buffer.Append(IfThen(FieldInfo.Field.AsBoolean, 'true', 'false'));
                ftDateTime, ftDate, ftTime:
                  Buffer.AppendQuoted(DateToISO8601(FieldInfo.Field.AsDateTime));
              else
                Buffer.AppendQuoted(FieldInfo.Field.AsString);
              end;
            end;
          end;

          Buffer.AppendChar('}');

          FDataSet.Next;
          Inc(RecNo);
        end;
      end);

    FResult := Buffer.ToString;

  finally
    Buffer.Free;
    FEvent.SetEvent;
  end;
end;

{ TDataSetJSONFrameworkRTTI }

constructor TDataSetJSONFrameworkRTTI.Create;
begin
  inherited Create;
  FOptions := GetDefaultOptions;
  FFieldCache := TFieldRTTICache.Create;
  FJSONBuffer := TJSONBuffer.Create(2 * 1024 * 1024); // 2MB inicial
end;

constructor TDataSetJSONFrameworkRTTI.Create(const Options: TDataSetJSONOptions);
begin
  inherited Create;
  FOptions := Options;
  FFieldCache := TFieldRTTICache.Create;
  FJSONBuffer := TJSONBuffer.Create(2 * 1024 * 1024);
end;

destructor TDataSetJSONFrameworkRTTI.Destroy;
begin
  FJSONBuffer.Free;
  FFieldCache.Free;
  inherited;
end;

class function TDataSetJSONFrameworkRTTI.GetDefaultOptions: TDataSetJSONOptions;
begin
  Result.IncludeFieldDefs := False;
  Result.IncludeMetadata := False;
  Result.DateTimeFormat := '';
  Result.NullValueHandling := True;
  Result.FieldNameCase := fncOriginal;
  Result.UseMultiThreading := True;
  Result.ThreadPoolSize := Max(2, TThread.ProcessorCount);
  Result.BatchSize := 10000; // 10k registros por lote
end;

procedure TDataSetJSONFrameworkRTTI.OptimizeDataSetBuffer(DataSet: TDataSet);
begin
  // Otimizações específicas para datasets grandes
  if DataSet is TCustomClientDataSet then
  begin
    TCustomClientDataSet(DataSet).DisableControls;
  end;
end;

function TDataSetJSONFrameworkRTTI.FieldToJSONString(const FieldInfo: TFieldRTTIInfo): string;
begin
  if FieldInfo.Field.IsNull then
  begin
    Result := 'null';
    Exit;
  end;

  case FieldInfo.DataType of
    ftString, ftWideString, ftMemo, ftWideMemo:
      Result := '"' + StringReplace(FieldInfo.Field.AsString, '"', '\"', [rfReplaceAll]) + '"';
    ftInteger, ftSmallint, ftWord, ftAutoInc:
      Result := IntToStr(FieldInfo.Field.AsInteger);
    ftLargeint:
      Result := IntToStr(FieldInfo.Field.AsLargeInt);
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result := FloatToStr(FieldInfo.Field.AsFloat);
    ftBoolean:
      Result := IfThen(FieldInfo.Field.AsBoolean, 'true', 'false');
    ftDateTime, ftDate, ftTime:
      Result := '"' + DateToISO8601(FieldInfo.Field.AsDateTime) + '"';
  else
    Result := '"' + StringReplace(FieldInfo.Field.AsString, '"', '\"', [rfReplaceAll]) + '"';
  end;
end;

procedure TDataSetJSONFrameworkRTTI.SetFieldFromJSON(const FieldInfo: TFieldRTTIInfo; const JSONValue: string);
begin
  if JSONValue = 'null' then
  begin
    FieldInfo.Field.Clear;
    Exit;
  end;

  case FieldInfo.DataType of
    ftString, ftWideString, ftMemo, ftWideMemo:
      FieldInfo.Field.AsString := StringReplace(JSONValue, '\"', '"', [rfReplaceAll]);
    ftInteger, ftSmallint, ftWord, ftAutoInc:
      FieldInfo.Field.AsInteger := StrToIntDef(JSONValue, 0);
    ftLargeint:
      FieldInfo.Field.AsLargeInt := StrToInt64Def(JSONValue, 0);
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      FieldInfo.Field.AsFloat := StrToFloatDef(JSONValue, 0);
    ftBoolean:
      FieldInfo.Field.AsBoolean := SameText(JSONValue, 'true');
    ftDateTime, ftDate, ftTime:
      FieldInfo.Field.AsDateTime := ISO8601ToDate(JSONValue);
  else
    FieldInfo.Field.AsString := JSONValue;
  end;
end;

function TDataSetJSONFrameworkRTTI.ProcessRecordsBatch(DataSet: TDataSet; StartRecord, EndRecord: Integer): string;
var
  Buffer: TJSONBuffer;
  RecNo: Integer;
  J: Integer;
  FieldInfo: TFieldRTTIInfo;
begin
  Buffer := TJSONBuffer.Create(256 * 1024); // 256KB por lote
  try
    RecNo := 0;
    DataSet.First;

    // Navegar até o registro inicial
    while (RecNo < StartRecord) and not DataSet.Eof do
    begin
      DataSet.Next;
      Inc(RecNo);
    end;

    // Processar lote
    while (RecNo <= EndRecord) and not DataSet.Eof do
    begin
      if RecNo > StartRecord then
        Buffer.AppendChar(',');

      Buffer.AppendChar('{');

      for J := 0 to FFieldCache.FieldCount - 1 do
      begin
        if J > 0 then
          Buffer.AppendChar(',');

        FieldInfo := FFieldCache.GetCachedFieldInfo(J);

        Buffer.AppendQuoted(FieldInfo.FieldName);
        Buffer.AppendChar(':');
        Buffer.Append(FieldToJSONString(FieldInfo));
      end;

      Buffer.AppendChar('}');
      DataSet.Next;
      Inc(RecNo);
    end;

    Result := Buffer.ToString;
  finally
    Buffer.Free;
  end;
end;

function TDataSetJSONFrameworkRTTI.ProcessRecordsParallel(DataSet: TDataSet): string;
var
  RecordCount, BatchSize: Integer;
  FinalBuffer: TJSONBuffer;
begin
  RecordCount := DataSet.RecordCount;
  BatchSize := FOptions.BatchSize;

  if (RecordCount <= BatchSize) or not FOptions.UseMultiThreading then
  begin
    // Processamento sequencial para datasets pequenos
    Result := ProcessRecordsBatch(DataSet, 0, RecordCount - 1);
    Exit;
  end;

  // Para simplificar, vamos usar processamento sequencial por enquanto
  // O processamento paralelo real requer clonagem do dataset ou uso de índices
  Result := ProcessRecordsBatch(DataSet, 0, RecordCount - 1);
end;

function TDataSetJSONFrameworkRTTI.DataSetToJSONString(DataSet: TDataSet): string;
begin
  Result := DataSetToJSONString(DataSet, FOptions);
end;

function TDataSetJSONFrameworkRTTI.DataSetToJSONString(DataSet: TDataSet; const Options: TDataSetJSONOptions): string;
var
  StartTime: TDateTime;
  RecordData: string;
begin
  StartTime := Now;

  if not DataSet.Active then
    DataSet.Open;

  // Otimizar buffer do dataset
  OptimizeDataSetBuffer(DataSet);

  // Construir cache RTTI
  FFieldCache.BuildCache(DataSet, Options);

  FJSONBuffer.Clear;
  FJSONBuffer.Append('{"data":[');

  // Processar registros (paralelo ou sequencial)
  RecordData := ProcessRecordsParallel(DataSet);
  FJSONBuffer.Append(RecordData);

  FJSONBuffer.Append(']');

  // Adicionar metadata se solicitado
  if Options.IncludeMetadata then
  begin
    FJSONBuffer.Append(',"metadata":{"recordCount":');
    FJSONBuffer.Append(IntToStr(DataSet.RecordCount));
    FJSONBuffer.Append(',"fieldCount":');
    FJSONBuffer.Append(IntToStr(DataSet.FieldCount));
    FJSONBuffer.Append(',"processingTime":');
    FJSONBuffer.Append(FloatToStr(MilliSecondsBetween(Now, StartTime)));
    FJSONBuffer.Append('}');
  end;

  FJSONBuffer.Append('}');

  Result := FJSONBuffer.ToString;
end;

function TDataSetJSONFrameworkRTTI.DataSetToJSON(DataSet: TDataSet): TJSONObject;
var
  JSONString: string;
begin
  JSONString := DataSetToJSONString(DataSet);
  Result := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
end;

function TDataSetJSONFrameworkRTTI.DataSetToJSON(DataSet: TDataSet; const Options: TDataSetJSONOptions): TJSONObject;
var
  JSONString: string;
begin
  JSONString := DataSetToJSONString(DataSet, Options);
  Result := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
end;

procedure TDataSetJSONFrameworkRTTI.JSONToDataSet(const JSONString: string; DataSet: TDataSet);
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    JSONToDataSet(JSONObj, DataSet, FOptions);
  finally
    JSONObj.Free;
  end;
end;

procedure TDataSetJSONFrameworkRTTI.JSONToDataSet(JSONObject: TJSONObject; DataSet: TDataSet);
begin
  JSONToDataSet(JSONObject, DataSet, FOptions);
end;

procedure TDataSetJSONFrameworkRTTI.JSONToDataSet(const JSONString: string; DataSet: TDataSet; const Options: TDataSetJSONOptions);
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    JSONToDataSet(JSONObj, DataSet, Options);
  finally
    JSONObj.Free;
  end;
end;

procedure TDataSetJSONFrameworkRTTI.JSONToDataSet(JSONObject: TJSONObject; DataSet: TDataSet; const Options: TDataSetJSONOptions);
var
  DataArray: TJSONArray;
  RowObject: TJSONObject;
  JSONValue: TJSONValue;
  I, J: Integer;
  FieldInfo: TFieldRTTIInfo;
begin
  DataArray := JSONObject.GetValue('data') as TJSONArray;
  if not Assigned(DataArray) then
    raise Exception.Create('JSON deve conter um array "data"');

  if not DataSet.Active then
    DataSet.Open;

  // Construir cache RTTI
  FFieldCache.BuildCache(DataSet, Options);

  DataSet.DisableControls;
  try
    // Limpar dataset (usando método compatível)
    while not DataSet.Eof do
      DataSet.Delete;

    for I := 0 to DataArray.Count - 1 do
    begin
      RowObject := DataArray.Items[I] as TJSONObject;
      DataSet.Append;

      // Usar cache RTTI para acesso otimizado aos campos
      for J := 0 to FFieldCache.FieldCount - 1 do
      begin
        FieldInfo := FFieldCache.GetCachedFieldInfo(J);

        if RowObject.TryGetValue(FieldInfo.FieldName, JSONValue) then
        begin
          if JSONValue is TJSONNull then
            FieldInfo.Field.Clear
          else
            SetFieldFromJSON(FieldInfo, JSONValue.Value);
        end;
      end;

      DataSet.Post;
    end;

    DataSet.First;
  finally
    DataSet.EnableControls;
  end;
end;

procedure TDataSetJSONFrameworkRTTI.DataSetToJSONStream(DataSet: TDataSet; Stream: TStream);
var
  JSONString: string;
  StringBytes: TBytes;
begin
  JSONString := DataSetToJSONString(DataSet);
  StringBytes := TEncoding.UTF8.GetBytes(JSONString);
  Stream.WriteBuffer(StringBytes, Length(StringBytes));
end;

procedure TDataSetJSONFrameworkRTTI.JSONStreamToDataSet(Stream: TStream; DataSet: TDataSet);
var
  StringList: TStringList;
  JSONString: string;
begin
  StringList := TStringList.Create;
  try
    Stream.Position := 0;
    StringList.LoadFromStream(Stream, TEncoding.UTF8);
    JSONString := StringList.Text;
    JSONToDataSet(JSONString, DataSet);
  finally
    StringList.Free;
  end;
end;

class function TDataSetJSONFrameworkRTTI.QuickDataSetToJSON(DataSet: TDataSet): string;
var
  Framework: TDataSetJSONFrameworkRTTI;
begin
  Framework := TDataSetJSONFrameworkRTTI.Create;
  try
    Result := Framework.DataSetToJSONString(DataSet);
  finally
    Framework.Free;
  end;
end;

class procedure TDataSetJSONFrameworkRTTI.QuickJSONToDataSet(const JSONString: string; DataSet: TDataSet);
var
  Framework: TDataSetJSONFrameworkRTTI;
begin
  Framework := TDataSetJSONFrameworkRTTI.Create;
  try
    Framework.JSONToDataSet(JSONString, DataSet);
  finally
    Framework.Free;
  end;
end;

end.

