unit DataSetJSONFrameworkRTTI;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Data.DB, FireDAC.Comp.Client,
  System.Rtti, System.TypInfo, System.Generics.Collections;

type
  TFieldMap = record
    Field: TField;
    FieldName: string;
  end;

  TBaseDataSetJSON = class
  protected
    FDataSet: TDataSet;
    FieldMaps: TArray<TFieldMap>;
    procedure PrepareFieldMaps;
  public
    constructor Create(ADataSet: TDataSet); virtual;
    function DataSetToJsonArray: TJSONArray; virtual;
    procedure JsonArrayToDataSet(JSONArray: TJSONArray); virtual;
  end;

  TFDQueryJSON = class(TBaseDataSetJSON)
  public
    constructor Create(AFDQuery: TFDQuery); reintroduce;
  end;

  TFDMemoryTableJSON = class(TBaseDataSetJSON)
  public
    constructor Create(AFDTable: TFDMemTable); reintroduce;
  end;

implementation

uses
  System.Variants;

{ TBaseDataSetJSON }

constructor TBaseDataSetJSON.Create(ADataSet: TDataSet);
begin
  inherited Create;
  FDataSet := ADataSet;
  PrepareFieldMaps;
end;

procedure TBaseDataSetJSON.PrepareFieldMaps;
var
  i: Integer;
begin
  SetLength(FieldMaps, FDataSet.FieldCount);
  for i := 0 to FDataSet.FieldCount - 1 do
  begin
    FieldMaps[i].Field := FDataSet.Fields[i];
    FieldMaps[i].FieldName := FDataSet.Fields[i].FieldName;
  end;
end;

function TBaseDataSetJSON.DataSetToJsonArray: TJSONArray;
var
  JSONObject: TJSONObject;
  i: Integer;
begin
  Result := TJSONArray.Create;
  FDataSet.First;
  while not FDataSet.Eof do
  begin
    JSONObject := TJSONObject.Create;
    for i := 0 to High(FieldMaps) do
      JSONObject.AddPair(FieldMaps[i].FieldName, VarToStr(FieldMaps[i].Field.Value));
    Result.AddElement(JSONObject);
    FDataSet.Next;
  end;
end;

procedure TBaseDataSetJSON.JsonArrayToDataSet(JSONArray: TJSONArray);
var
  JSONObject: TJSONObject;
  i, j: Integer;
  Value: TJSONValue;
begin
  FDataSet.DisableControls;
  try
    FDataSet.First;
    while not FDataSet.IsEmpty do
      FDataSet.Delete;

    for i := 0 to JSONArray.Count - 1 do
    begin
      JSONObject := JSONArray.Items[i] as TJSONObject;
      FDataSet.Append;
      for j := 0 to High(FieldMaps) do
      begin
        Value := JSONObject.GetValue(FieldMaps[j].FieldName);
        if Assigned(Value) then
          FieldMaps[j].Field.AsString := Value.Value;
      end;
      FDataSet.Post;
    end;
  finally
    FDataSet.EnableControls;
  end;
end;

{ TFDQueryJSON }

constructor TFDQueryJSON.Create(AFDQuery: TFDQuery);
begin
  inherited Create(AFDQuery);
end;

{ TFDMemoryTableJSON }

constructor TFDMemoryTableJSON.Create(AFDTable: TFDMemTable);
begin
  inherited Create(AFDTable);
end;

end.

