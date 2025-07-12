unit Server.Swagger;

interface

uses
  classes,
  sysutils,
  System.Rtti,
  Swager.Json.DTO,
  System.Json,
  System.StrUtils,
  Swager.Json.Body,
  Server.Attributes,
  Server.ResourceBaseClass,
  Server.AngularModel,
  Server.Utils.Strings,
  Swager.Json.Paths;

type
  TWKSwagerAPI = class
  private
    FoutPaht: string;
    FListClasses: TStringList;
    FFieldType: string;
    Lclass: string;
    Lcontraints: string;
    FSchemaDefinitions: TjsonObject;
    Lsize: string;
    FbodySwager: TRootDTO;
    FOutJson: TStringList;
    FPathsJson: TStringList;
    FAngularModel: TAngularModel;
    FDefinitionsJson: TStringList;
    procedure GetClassesProc(AClass: TPersistentClass);
    procedure setSchemaProps(sFieldType, sDescription, sSize, sName,
      sContraints: string; pRequired: TJSONArray; pProperts: TjsonObject);

    class function GetRttiType(Obj: TObject): TRttiType;
    procedure ParseClass(AClassName: String);
  public
    procedure MakeReposioty;
    constructor create;
    destructor destroy;
  end;

implementation
    uses
       Server.DAO;
{ TWKSwagerAPI }

constructor TWKSwagerAPI.create;
begin
  FbodySwager := TRootDTO.create;
  FOutJson := TStringList.create;
  FPathsJson := TStringList.create;
  FDefinitionsJson := TStringList.create;
  FoutPaht := ExtractFilePath(GetModuleName(HInstance)) + 'www' + PathDelim +
    'api' + PathDelim + 'help' + PathDelim + 'swagger.json';

  Inherited;
end;

procedure TWKSwagerAPI.MakeReposioty;
var
  _index: integer;
  _ClassFinder: TClassFinder;
  LIndex: integer;

begin
  FSchemaDefinitions := TjsonObject.create;
  FOutJson.Text := FbodySwager.ToString;
  _ClassFinder := TClassFinder.create(nil);
  if assigned(_ClassFinder) then
  begin
    try
      FListClasses := TStringList.create;
      _ClassFinder.GetClasses(GetClassesProc);
      FListClasses.Sort;
      FListClasses.Sorted := true;
      for LIndex := 0 to FListClasses.Count - 1 do
      begin
        ParseClass(FListClasses[LIndex]);
      end;

    finally
      _ClassFinder.Free;
    end;
    FOutJson.Text := StringReplace(FOutJson.Text, '"definitions":{}',
      '"definitions": ' + FSchemaDefinitions.ToString + '',
      [rfReplaceAll, rfIgnoreCase]);

    FOutJson.Text := StringReplace(FOutJson.Text, '"paths":{}',
      '"paths":{' + FPathsJson.Text + '}', [rfReplaceAll, rfIgnoreCase]);

    FOutJson.Text := StringReplace(FOutJson.Text, '"get":null,', '',
      [rfReplaceAll, rfIgnoreCase]);
    FOutJson.SaveToFile(FoutPaht);

  end;

end;

destructor TWKSwagerAPI.destroy;
begin
  FbodySwager := TRootDTO.create;
  FreeAndNil(FOutJson);
  FreeAndNil(FPathsJson);
  FreeAndNil(FDefinitionsJson);

  FreeAndNil(FSchemaDefinitions);
end;

procedure TWKSwagerAPI.GetClassesProc(AClass: TPersistentClass);
var
  RttiContext: TRttiContext;
  Classe: TRttiType;
  Attribute: TCustomAttribute;
begin
  RttiContext := TRttiContext.create;
  Classe := RttiContext.GetType(AClass);
  for Attribute in Classe.GetAttributes do
    if Attribute is Resource then
      FListClasses.add(Classe.QualifiedName)

end;

class function TWKSwagerAPI.GetRttiType(Obj: TObject): TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.create;
  Result := RttiContext.GetType(Obj.ClassInfo);
end;

procedure TWKSwagerAPI.setSchemaProps(sFieldType, sDescription, sSize, sName,
  sContraints: string; pRequired: TJSONArray; pProperts: TjsonObject);
var
  Obj: TjsonObject;
  SwagerDataType: string;
  LDateSubType: String;

begin
  SwagerDataType := LowerCase(sFieldType);
  LDateSubType := '';
  if SwagerDataType = 'time' then
    LDateSubType := 'time';
  if SwagerDataType = 'datetime' then
    LDateSubType := 'datetime';

  if (SwagerDataType = 'datetime') or (SwagerDataType = 'time') then
    SwagerDataType := 'date-time';

  if ((SwagerDataType = 'tbytea') or (SwagerDataType = 'bytea')) then
    SwagerDataType := 'byte';

  if (SwagerDataType = 'date') then
    SwagerDataType := 'date';
  if (SwagerDataType = 'double') then
    SwagerDataType := 'number';
  // -------------------------//
  Obj := TjsonObject.create;
  Obj.AddPair('type', SwagerDataType);
  if LDateSubType = 'time' then
  begin
    Obj.AddPair('pattern', '/(?:[01]\d|2[0-3]):(?:[0-5]\d):(?:[0-5]\d)/');
    Obj.AddPair('example', '00:00:00');
    SwagerDataType := 'date-time';
  end;
  if LDateSubType = 'datetime' then
  begin
    Obj.AddPair('pattern', '\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2}');
    Obj.AddPair('example', '2023-07-21T17:32:28Z');
    SwagerDataType := 'date-time';
  end;
  if SwagerDataType = 'date' then
  begin
    Obj.AddPair('pattern', '/([0-9]{4})-(?:[0-9]{2})-([0-9]{2})/');
    Obj.AddPair('example', '2023-01-17');
  end;

  if sDescription = '' then
  begin
    sDescription := 'Campo ' + sName;
  end;
  Obj.AddPair('description', sDescription);
  if SwagerDataType = 'integer' then
  begin
    Obj.AddPair('format', 'int64');
    Obj.AddPair('example', '1');
  end;

  if (SwagerDataType = 'string') and (sSize <> '') then
    Obj.AddPair('size', copy(sSize, 3, Length(sSize)));

  pProperts.AddPair(sName, Obj);

  if (AnsiUpperCase( sContraints) = AnsiUpperCase( 'NotNull')) or (AnsiUpperCase( sContraints) = AnsiUpperCase( 'PrimaryKey')) then
    pRequired.add(sName);
  // Ajustar para o padrao do TypeScript
  if (SwagerDataType = 'integer') then
    SwagerDataType := 'number';

  if SwagerDataType = 'date' then
    SwagerDataType := 'Date';
  // permitir que a pk seja opcional
  if (sContraints = 'PrimaryKey') then
    FAngularModel.FieldsList.add(sName + '?:' + SwagerDataType)
  else
    FAngularModel.FieldsList.add(sName + ':' + SwagerDataType)

end;

procedure TWKSwagerAPI.ParseClass(AClassName: String);
var
  RttiContext: TRttiContext;
  RttiInstanceType: TRttiInstanceType;
  RttiMethod: TRttiMethod;
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  LstrTmp: string;
  LfieldType: string;
  LResouce: TRoot;
  Instance: TObject;
  LSchemaDetail: TjsonObject;
  LRequired: TJSONArray;
  LProperts: TjsonObject;
  LFlags: TActionsFlags;
begin
  if AClassName = '' then
    exit;

  LResouce := TRoot.create();
  RttiContext := TRttiContext.create;
  RttiInstanceType := RttiContext.FindType(AClassName).AsInstance;
  LFlags := [];
  RttiMethod := RttiInstanceType.GetMethod('Put');
  if assigned(RttiMethod) then
    LFlags := LFlags + [afput];
  RttiMethod := RttiInstanceType.GetMethod('Post');
  if assigned(RttiMethod) then
    LFlags := LFlags + [afPost];
  RttiMethod := RttiInstanceType.GetMethod('Get');
  if assigned(RttiMethod) then
    LFlags := LFlags + [afGet];
  RttiMethod := RttiInstanceType.GetMethod('Delete');
  if assigned(RttiMethod) then
    LFlags := LFlags + [afdelete];
  if LFlags = [] then
    exit;

  LResouce.Flags := LFlags;
  LResouce.CreateNodes();

  FAngularModel := TAngularModel.create;
  Lclass := LowerCase(SplitString(AClassName, '.')[1]);
  LstrTmp := LResouce.ToString;
  LstrTmp := copy(LstrTmp, 2, Length(LstrTmp) - 2);
  LstrTmp := StringReplace(LstrTmp, '$ResourceBase', Lclass,
    [rfReplaceAll, rfIgnoreCase]);
  if FPathsJson.Count = 0 then

    FPathsJson.add(LstrTmp)
  else
    FPathsJson.add(', ' + LstrTmp);

  RttiMethod := RttiInstanceType.GetMethod('Create');
  Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType, []).AsObject;
  RttiType := GetRttiType(Instance);
  LSchemaDetail := TjsonObject.create;
  LSchemaDetail.AddPair('type', 'object');
  LSchemaDetail.AddPair('description', 'Dados ' + Lclass);
  LRequired := TJSONArray.create;
  LProperts := TjsonObject.create;

  for RttiField in RttiType.GetFields do
  begin
    Lcontraints := '';
    Lsize := '';
    for RttiAttribute in RttiField.GetAttributes do
    begin
      if (RttiAttribute is DBField) and ((RttiAttribute as DBField).TableSource =''  )   then
      begin

        if RttiField.FieldType.TypeKind in [tkInteger, tkInt64] then
        begin
          LfieldType := 'integer';
        end
        else if RttiField.FieldType.TypeKind
          in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar,
          tkWideString, tkChar] then
        begin
          LfieldType := 'string';

        end
        else if RttiField.FieldType.TypeKind in [tkFloat] then
        begin
          case IndexStr(RttiField.FieldType.Name,
            ['TDateTime', 'TDate', 'TTime']) of

            0:
              LfieldType := 'DateTime';
            1:
              LfieldType := 'Date';
            2:
              LfieldType := 'Time';
          else
            LfieldType := 'Double';
          end;
        end
        else if RttiField.FieldType.TypeKind in [tkEnumeration] then
          LfieldType := 'boolean'
        else if RttiField.FieldType.Name = 'TMacAddress' then
          LfieldType := 'MacAddress'
        else if RttiField.FieldType.Name = 'TBytea' then
          LfieldType := 'byte'
        else
          LfieldType := 'string';

        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          Lcontraints := 'PrimaryKey';
        if (RttiAttribute as DBField).Constraints = NotNull then
          Lcontraints := 'NotNull';

        setSchemaProps(LfieldType, '', Lsize, (RttiField.Name), Lcontraints,
          LRequired, LProperts);

      end;
    end;
  end;
  LSchemaDetail.AddPair('required', LRequired);
  LSchemaDetail.AddPair('properties', LProperts);
  FSchemaDefinitions.AddPair(Lclass, LSchemaDetail);

  FDefinitionsJson.Clear;
  FDefinitionsJson.add(FSchemaDefinitions.ToJSON);
  try
    FAngularModel.ClassName := Lclass;
    FAngularModel.saveModel;
  finally
    FreeAndNil(FAngularModel);
  end;

end;

end.
