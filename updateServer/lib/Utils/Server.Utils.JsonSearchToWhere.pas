unit Server.Utils.JsonSearchToWhere;

interface

uses
  rest.json,
  system.json,
  system.Generics.Collections,
  Server.Attributes,
  system.Character,
  system.SysUtils,
  system.Rtti,
  rest.json.Types;

{$M+}

type
  TFiltroField = class
  private
    FOperador: string;

  published
    property Operador: string read FOperador write FOperador;

  end;

  TSearchFilter = class
  private
    FFiltroField: TFiltroField;
    lfiltros: TJSONObject;
    latribs: TJSONObject;
    optArray: TJSONArray;
    JSonValue: TJSonValue;
    Resource: TObject;
    lfield: string;
    lvalue: string;
    loperator: string;
    concact: string;
    FwhereFilter: string;
    FinputJson: string;
    procedure makeFilter;
    function GetTableName(Obj: TObject): String;
    function GetFieldAlias(value: string): string;
    function decodeOperador(value: string): string;
    procedure processInOperator();
    procedure processbetweenOperator();
    function parseValue(value: string): string;

  published
    property FiltroField: TFiltroField read FFiltroField;
    property whereFilter: string read FwhereFilter write FwhereFilter;
  public
    constructor Create(Obj: TObject; filterSearch: string);
    destructor Destroy; override;

  end;

type
  TSearchFilters = TObjectList<TSearchFilter>;

const
  cop_not = ' <> ';
  cop_in = ' in ';
  cop_dif = ' <> ';
  cop_or = ' or ';
  cop_and = ' and ';
  cop_gt = ' > ';
  cop_gte = ' >= ';
  cop_lt = ' < ';
  cop_lte = ' <= ';
  cop_bt = ' between ';

implementation

{ TSearchFilter }
function TSearchFilter.decodeOperador(value: string): string;
begin
  if value = '$not' then
    result := cop_not
  else if value = '$in' then
    result := cop_in
  else if value = '$nin' then
    result := cop_not
  else if value = '$or' then
    result := cop_or
  else if value = '$and' then
    result := cop_and
  else if value = '$gt' then
    result := cop_gt
  else if value = '$gte' then
    result := cop_gte
  else if value = '$lt' then
    result := cop_lt
  else if value = '$lte' then
    result := cop_lte
  else if value = '$bt' then
    result := cop_bt
  else

end;

function TSearchFilter.parseValue(value: string): string;
var
  i: Integer;
begin
  result := value;
  if TryStrToInt(value, i) then
    result := value
  else
    result := QuotedStr(value);
end;

procedure TSearchFilter.processbetweenOperator;
var
  sep: string;
  aindex: Integer;
begin

  sep := '';
  for aindex := 0 to optArray.Count - 1 do
  begin
    lvalue := lvalue + sep + QuotedStr(optArray.Items[aindex].value);
    sep := ' and  ';
  end;

end;

procedure TSearchFilter.processInOperator();
var
  sep: string;
  index: Integer;
begin
  lvalue := '( ';
  sep := '';
  for index := 0 to optArray.Count - 1 do
  begin
    lvalue := lvalue + sep + parseValue(optArray.Items[index].value);
    sep := ' , ';
  end;
  lvalue := lvalue + ' ) ';

end;

function GetRttiType(Obj: TObject): TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  result := RttiContext.GetType(Obj.ClassInfo);
end;

function TSearchFilter.GetTableName(Obj: TObject): String;
var
  RttiType: TRttiType;
  RttiAttribute: TCustomAttribute;
begin
  result := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiAttribute in RttiType.GetAttributes do
    if RttiAttribute is Table then
      result := (RttiAttribute as Table).TableName;
end;

function TSearchFilter.GetFieldAlias(value: string): string;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  result := '';
  RttiType := GetRttiType(Resource);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DbField then
      begin
        if RttiField.Name.ToLower = LowerCase(value) then
        begin
          if (RttiAttribute as DbField).TableSource <> '' then
            result := (RttiAttribute as DbField).TableSource + '.' +
              (RttiAttribute as DbField).FieldName
          else
            result := GetTableName(Resource) + '.' + (RttiAttribute as DbField)
              .FieldName
        end;
      end;

end;

procedure TSearchFilter.makeFilter;
var
  indexCampo: Integer;
  indexAtribs: Integer;

Begin

  for indexCampo := 0 to lfiltros.Count - 1 do
  begin
    loperator := '=';
    lvalue := '';
    lfield := '';
    if (lfiltros.Pairs[indexCampo].JSonValue is TJSONObject) then
    begin
      latribs := (lfiltros.Pairs[indexCampo].JSonValue as TJSONObject);
      lfield := GetFieldAlias(lfiltros.Pairs[indexCampo].JsonString.value);
      if lfield <> '' then
      begin
        for indexAtribs := 0 to latribs.Count - 1 do
        begin
          loperator := decodeOperador(latribs.Pairs[indexAtribs]
            .JsonString.value);
          if (latribs.Pairs[indexAtribs].JSonValue is TJSONArray) then
          begin
            optArray := (latribs.Pairs[indexAtribs].JSonValue as TJSONArray);
            if loperator = cop_in then
              processInOperator()
            else if loperator = cop_bt then
              processbetweenOperator;
          end
          else
          begin
            lvalue := parseValue(latribs.Pairs[indexAtribs].JSonValue.value);
          end;
        end;
      end;
    end
    else
    begin
      lfield := GetFieldAlias(lfiltros.Pairs[indexCampo].JsonString.value);
      if lfield <> '' then
        lvalue := parseValue(lfiltros.Pairs[indexCampo].JSonValue.value);
    end;
    if (concact = '') and (FwhereFilter <> '') then
      concact := ' AND ';
    if lfield <> '' then
      FwhereFilter := FwhereFilter + '  ' + concact + lfield + loperator +
        lvalue + #13#10;
  end;
  if FwhereFilter <> '' then
    FwhereFilter := 'WHERE' + #13#10 + FwhereFilter;
end;

constructor TSearchFilter.Create(Obj: TObject; filterSearch: string);
begin
  concact := '';
  Resource := Obj;
  FinputJson := filterSearch;
  lfiltros := TJSONObject.Create;
  JSonValue := lfiltros.ParseJSONValue(FinputJson);
  lfiltros := (JSonValue as TJSONObject);
  FFiltroField := TFiltroField.Create;
  makeFilter;
end;

destructor TSearchFilter.Destroy;
begin
  FFiltroField.Free;
  FreeAndNil(lfiltros);
  inherited;
end;

end.
