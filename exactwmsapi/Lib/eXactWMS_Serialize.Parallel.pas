unit eXactWMS_Serialize.Parallel;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  System.Threading, System.JSON, FireDAC.Comp.Client, System.SyncObjs,
  FireDAC.Comp.DataSet, Data.DB, Math;

type
  TChunkResult = record
    ChunkIndex: Integer;
    JsonData: string;
    RecordCount: Integer;
  end;

  TOptimizedParallelJsonSerializer = class
  private
    class var FTaskPool: TThreadPool;
    class var FIsInitialized: Boolean;

    class procedure InitializeTaskPool;
    class function SerializeChunkDirect(const ADataSet: TFDDataSet;
      AStartIdx, AEndIdx: Integer): TChunkResult;
    class function EscapeJsonString(const Value: string): string; inline;
    class function FormatJsonField(Field: TField): string; inline;
  public
    class constructor Create;
    class destructor Destroy;

    // Versão otimizada principal
    class function SerializeParallelOptimized(ADataSet: TFDDataSet;
      AChunkSize: Integer = 5000): string;

    // Versão ultra-rápida para casos específicos
    class function SerializeUltraFast(ADataSet: TFDDataSet): string;

    // Versão com pre-alocação de memória
    class function SerializeWithPreAllocation(ADataSet: TFDDataSet;
      AChunkSize: Integer = 5000): string;
  end;

implementation

{ TOptimizedParallelJsonSerializer }

class constructor TOptimizedParallelJsonSerializer.Create;
begin
  FIsInitialized := False;
  InitializeTaskPool;
end;

class destructor TOptimizedParallelJsonSerializer.Destroy;
begin
  if Assigned(FTaskPool) then
    FTaskPool.Free;
end;

class procedure TOptimizedParallelJsonSerializer.InitializeTaskPool;
begin
  if not FIsInitialized then
  begin
    FTaskPool := TThreadPool.Create;
    // Otimizado para CPU-bound operations
    FTaskPool.SetMaxWorkerThreads(TThread.ProcessorCount);
    FTaskPool.SetMinWorkerThreads(TThread.ProcessorCount div 2);
    FIsInitialized := True;
  end;
end;

class function TOptimizedParallelJsonSerializer.EscapeJsonString(const Value: string): string;
var
  I: Integer;
  Len: Integer;
  P: PChar;
  NeedsEscape: Boolean;
begin
  Len := Length(Value);
  if Len = 0 then Exit('');

  // Verificação rápida se precisa de escape
  NeedsEscape := False;
  P := PChar(Value);
  for I := 0 to Len - 1 do
  begin
    if (P^ = '"') or (P^ = '\') or (P^ = '/') or (P^ < ' ') then
    begin
      NeedsEscape := True;
      Break;
    end;
    Inc(P);
  end;

  if not NeedsEscape then
    Exit(Value);

  // Escape necessário - versão otimizada
  SetLength(Result, Len * 2); // Pre-aloca espaço suficiente
  P := PChar(Value);
  I := 0;
  Len := 0;

  while I < Length(Value) do
  begin
    case P^ of
      '"': begin Result := Result + '\"'; Inc(Len, 2); end;
      '\': begin Result := Result + '\\'; Inc(Len, 2); end;
      '/': begin Result := Result + '\/'; Inc(Len, 2); end;
      #8: begin Result := Result + '\b'; Inc(Len, 2); end;
      #9: begin Result := Result + '\t'; Inc(Len, 2); end;
      #10: begin Result := Result + '\n'; Inc(Len, 2); end;
      #12: begin Result := Result + '\f'; Inc(Len, 2); end;
      #13: begin Result := Result + '\r'; Inc(Len, 2); end;
    else
      if P^ < ' ' then
      begin
        Result := Result + '\u' + IntToHex(Ord(P^), 4);
        Inc(Len, 6);
      end
      else
      begin
        Result := Result + P^;
        Inc(Len);
      end;
    end;
    Inc(I);
    Inc(P);
  end;

  SetLength(Result, Len); // Ajusta tamanho final
end;

class function TOptimizedParallelJsonSerializer.FormatJsonField(Field: TField): string;
begin
  if Field.IsNull then
    Exit('null');

  case Field.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result := Field.AsFloat.ToString;
    ftInteger, ftSmallint, ftWord, ftLongWord, ftByte:
      Result := Field.AsInteger.ToString;
    ftBoolean:
      if Field.AsBoolean then
        Result := 'true'
      else
        Result := 'false';
    ftDate:
      Result := '"' + FormatDateTime('yyyy-mm-dd', Field.AsDateTime) + '"';
    ftDateTime, ftTimeStamp:
      Result := '"' + FormatDateTime('yyyy-mm-dd"T"hh:nn:ss.zzz"Z"', Field.AsDateTime) + '"';
    ftGuid:
      Result := '"' + Field.AsString + '"';
    else
      Result := '"' + EscapeJsonString(Field.AsString) + '"';
  end;
end;

class function TOptimizedParallelJsonSerializer.SerializeChunkDirect(
  const ADataSet: TFDDataSet; AStartIdx, AEndIdx: Integer): TChunkResult;
var
  StringBuilder: TStringBuilder;
  Field: TField;
  RecordIndex: Integer;
  FirstRecord: Boolean;
  FieldCount: Integer;
  I: Integer;
begin
  Result.ChunkIndex := AStartIdx;
  Result.RecordCount := 0;

  StringBuilder := TStringBuilder.Create;
  try
    // Pré-aloca capacidade estimada
    StringBuilder.Capacity := (AEndIdx - AStartIdx + 1) * 200; // Estimativa por registro

    FieldCount := ADataSet.FieldCount;
    FirstRecord := True;
    RecordIndex := 0;

    // Posiciona no registro inicial
    ADataSet.RecNo := AStartIdx + 1;

    while (not ADataSet.Eof) and (RecordIndex <= (AEndIdx - AStartIdx)) do
    begin
      if not FirstRecord then
        StringBuilder.Append(',');
      FirstRecord := False;

      StringBuilder.Append('{');

      // Serializa campos do registro atual
      for I := 0 to FieldCount - 1 do
      begin
        if I > 0 then
          StringBuilder.Append(',');

        Field := ADataSet.Fields[I];
        StringBuilder.Append('"')
                   .Append(LowerCase(Field.FieldName))
                   .Append('":')
                   .Append(FormatJsonField(Field));
      end;

      StringBuilder.Append('}');

      ADataSet.Next;
      Inc(RecordIndex);
      Inc(Result.RecordCount);
    end;

    Result.JsonData := StringBuilder.ToString;
  finally
    StringBuilder.Free;
  end;
end;

class function TOptimizedParallelJsonSerializer.SerializeParallelOptimized(
  ADataSet: TFDDataSet; AChunkSize: Integer): string;
var
  TotalRecords: Integer;
  NumChunks: Integer;
  Tasks: TArray<ITask>;
  ChunkResults: TArray<TChunkResult>;
  FinalBuilder: TStringBuilder;
  I: Integer;
  StartIdx, EndIdx: Integer;
  DataCopies: TArray<TFDMemTable>;
  EstimatedSize: Integer;
begin
  if not Assigned(ADataSet) or not ADataSet.Active then
    Exit('[]');

  TotalRecords := ADataSet.RecordCount;
  if TotalRecords = 0 then
    Exit('[]');

  // Calcula chunks otimizados
  NumChunks := (TotalRecords + AChunkSize - 1) div AChunkSize;

  // Cria cópias dos dados de forma eficiente
  SetLength(DataCopies, NumChunks);
  SetLength(Tasks, NumChunks);
  SetLength(ChunkResults, NumChunks);

  try
    // Cria cópias dos dados uma única vez
    for I := 0 to NumChunks - 1 do
    begin
      DataCopies[I] := TFDMemTable.Create(nil);
      DataCopies[I].CopyDataSet(ADataSet, [coStructure, coRestart, coAppend]);
    end;

    // Executa processamento paralelo
    for I := 0 to NumChunks - 1 do
    begin
      StartIdx := I * AChunkSize;
      EndIdx := Min((I + 1) * AChunkSize - 1, TotalRecords - 1);

      Tasks[I] := TTask.Run(
        procedure
        var
          LocalCopy: TFDMemTable;
          LocalStart, LocalEnd: Integer;
          ChunkIdx: Integer;
        begin
          ChunkIdx := I;
          LocalCopy := DataCopies[ChunkIdx];
          LocalStart := StartIdx;
          LocalEnd := EndIdx;

          try
            LocalCopy.DisableControls;
            try
              ChunkResults[ChunkIdx] := SerializeChunkDirect(LocalCopy, LocalStart, LocalEnd);
            finally
              LocalCopy.EnableControls;
            end;
          except
            ChunkResults[ChunkIdx].JsonData := '';
            ChunkResults[ChunkIdx].RecordCount := 0;
          end;
        end,
        FTaskPool
      );
    end;

    // Aguarda conclusão
    TTask.WaitForAll(Tasks);

    // Monta resultado final de forma eficiente
    EstimatedSize := TotalRecords * 150; // Estimativa conservadora
    FinalBuilder := TStringBuilder.Create;
    try
      FinalBuilder.Capacity := EstimatedSize;
      FinalBuilder.Append('[');

      for I := 0 to High(ChunkResults) do
      begin
        if (I > 0) and (ChunkResults[I].JsonData <> '') then
          FinalBuilder.Append(',');
        FinalBuilder.Append(ChunkResults[I].JsonData);
      end;

      FinalBuilder.Append(']');
      Result := FinalBuilder.ToString;
    finally
      FinalBuilder.Free;
    end;

  finally
    // Limpeza
    for I := 0 to High(DataCopies) do
      if Assigned(DataCopies[I]) then
        DataCopies[I].Free;
  end;
end;

class function TOptimizedParallelJsonSerializer.SerializeUltraFast(
  ADataSet: TFDDataSet): string;
var
  StringBuilder: TStringBuilder;
  Field: TField;
  FirstRecord: Boolean;
  I: Integer;
  EstimatedSize: Integer;
begin
  if not Assigned(ADataSet) or not ADataSet.Active then
    Exit('[]');

  if ADataSet.RecordCount = 0 then
    Exit('[]');

  // Estimativa de tamanho para pré-alocação
  EstimatedSize := ADataSet.RecordCount * ADataSet.FieldCount * 25;

  StringBuilder := TStringBuilder.Create;
  try
    StringBuilder.Capacity := EstimatedSize;
    StringBuilder.Append('[');

    ADataSet.DisableControls;
    try
      FirstRecord := True;
      ADataSet.First;

      while not ADataSet.Eof do
      begin
        if not FirstRecord then
          StringBuilder.Append(',');
        FirstRecord := False;

        StringBuilder.Append('{');

        for I := 0 to ADataSet.FieldCount - 1 do
        begin
          if I > 0 then
            StringBuilder.Append(',');

          Field := ADataSet.Fields[I];
          StringBuilder.Append('"')
                     .Append(LowerCase(Field.FieldName))
                     .Append('":')
                     .Append(FormatJsonField(Field));
        end;

        StringBuilder.Append('}');
        ADataSet.Next;
      end;
    finally
      ADataSet.EnableControls;
    end;

    StringBuilder.Append(']');
    Result := StringBuilder.ToString;
  finally
    StringBuilder.Free;
  end;
end;

class function TOptimizedParallelJsonSerializer.SerializeWithPreAllocation(
  ADataSet: TFDDataSet; AChunkSize: Integer): string;
var
  TotalRecords: Integer;
  NumChunks: Integer;
  Tasks: TArray<ITask>;
  Results: TArray<string>;
  FinalBuilder: TStringBuilder;
  I: Integer;
  StartIdx, EndIdx: Integer;
  EstimatedTotalSize: Integer;
begin
  if not Assigned(ADataSet) or not ADataSet.Active then
    Exit('[]');

  TotalRecords := ADataSet.RecordCount;
  if TotalRecords = 0 then
    Exit('[]');

  NumChunks := (TotalRecords + AChunkSize - 1) div AChunkSize;
  SetLength(Tasks, NumChunks);
  SetLength(Results, NumChunks);

  // Processamento paralelo simplificado
  for I := 0 to NumChunks - 1 do
  begin
    StartIdx := I * AChunkSize;
    EndIdx := Min((I + 1) * AChunkSize - 1, TotalRecords - 1);

    Tasks[I] := TTask.Run(
      procedure
      var
        LocalCopy: TFDMemTable;
        ChunkIdx: Integer;
      begin
        ChunkIdx := I;
        LocalCopy := TFDMemTable.Create(nil);
        try
          LocalCopy.CopyDataSet(ADataSet, [coStructure, coRestart, coAppend]);
          LocalCopy.DisableControls;
          try
            Results[ChunkIdx] := SerializeChunkDirect(LocalCopy, StartIdx, EndIdx).JsonData;
          finally
            LocalCopy.EnableControls;
          end;
        finally
          LocalCopy.Free;
        end;
      end,
      FTaskPool
    );
  end;

  TTask.WaitForAll(Tasks);

  // Montagem final otimizada
  EstimatedTotalSize := TotalRecords * 120;
  FinalBuilder := TStringBuilder.Create;
  try
    FinalBuilder.Capacity := EstimatedTotalSize;
    FinalBuilder.Append('[');

    for I := 0 to High(Results) do
    begin
      if (I > 0) and (Results[I] <> '') then
        FinalBuilder.Append(',');
      FinalBuilder.Append(Results[I]);
    end;

    FinalBuilder.Append(']');
    Result := FinalBuilder.ToString;
  finally
    FinalBuilder.Free;
  end;
end;

end.
