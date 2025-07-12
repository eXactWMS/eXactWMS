unit Server.Attributes;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.SysUtils;

type
  Get = class(TCustomAttribute)

  end;

  Post = class(TCustomAttribute)

  end;

  Put = class(TCustomAttribute)

  end;

  Delete = class(TCustomAttribute)

  end;

  Resource = class(TCustomAttribute)
  private
    FResourceName: String;
    FMasterDateil: Boolean;
  public
    property ResourceName: String read FResourceName write FResourceName;
    property MasterDateil: Boolean read FMasterDateil write FMasterDateil;
    constructor Create(pResourceName: String; pMasterDateil: Boolean = False);
  end;

  Table = class(TCustomAttribute)
  private
    FTableName: String;
  public
    property TableName: String read FTableName write FTableName;
    constructor Create(pTableName: String);
  end;

  TConstraints = (PrimaryKey, ForeignKey, NotNull, Null, ReadOnly);
  TTipoJoin = (INNER, LEFT, RIGHT, FULL);

  AutoInc = class(TCustomAttribute)
  private
    FSequenceName: String;
  public
    property SequenceName: String read FSequenceName write FSequenceName;
    constructor Create(pSequenceName: String);
  end;

  TCustomSqlclauses = class(TCustomAttribute)
  private
    FCustomSelect: String;
    FCustomWhere: String;
    FCustomJoin: String;
    FCustomGroupBy: String;
  public
    property CustomSelect: String read FCustomSelect write FCustomSelect;
    property CustomWhere: String read FCustomWhere write FCustomWhere;
    property CustomJoin: String read FCustomJoin write FCustomJoin;
    property CustomGroupBy: String read FCustomGroupBy write FCustomGroupBy;
    constructor Create(pCustomSelect, pCustomWhere, pCustomJoin,
      pCustomGroupBy: String);

  end;

  FkConstraints = class(TCustomAttribute)
  private
    FKeyField: String;
    FTableReference: string;
    FKeyReference: string;
    FTipoJoin: TTipoJoin;
    FMasterTable: string;
  public
    property KeyField: String read FKeyField write FKeyField;
    property TableReference: String read FTableReference write FTableReference;
    property KeyReference: String read FKeyReference write FKeyReference;
    property TipoJoin: TTipoJoin read FTipoJoin write FTipoJoin;
    property MasterTable: String read FMasterTable write FMasterTable;
    constructor Create(pKeyField, pTableReference, pKeyReference: String;
      pTipoJoin: TTipoJoin; pMasterTable: string = '');
  end;

  ForengKeyDBField = class(TCustomAttribute)
  private
    FFieldName: String;
    FTable: String;
    FTipoJoin: TTipoJoin;

  public
    constructor Create(pFieldName, pTable: string; pTipoJoin: TTipoJoin);
    property FieldName: String read FFieldName write FFieldName;
    property Table: String read FTable write FTable;
    property TipoJoin: TTipoJoin read FTipoJoin write FTipoJoin;

  end;
  TResourceDetail = class(TCustomAttribute)
  private
    FResourceName: String;
    FKeyField: string;
    FKeyReference: string;

  public
    property ResourceName: String read FResourceName write FResourceName;
    property KeyField: String read FKeyField write FKeyField;
    property KeyReference: String read FKeyReference write FKeyReference;

    constructor Create(pResourceName, pKeyField, pKeyReference: String);
  end;

  DBField = class(TCustomAttribute)
  private
    FFieldName: String;
    FConstraints: TConstraints;
    FAutoInc: AutoInc;
    FHeader: Boolean;
    FListSelect: Boolean;
    FSort: Boolean;
    FObjectJson: Boolean;
    FTableSource: string;
  public
    property FieldName: String read FFieldName write FFieldName;
    property Constraints: TConstraints read FConstraints write FConstraints;
    property AutoIncrement: AutoInc read FAutoInc write FAutoInc;
    property Header: Boolean read FHeader write FHeader;
    property ListSelect: Boolean read FListSelect write FListSelect;
    property Sort: Boolean read FSort write FSort;
    property ObjectJson: Boolean read FObjectJson write FObjectJson;
    property TableSource: String read FTableSource write FTableSource;
    constructor Create(pFieldName: String; pHeader: Boolean;
      pListSelect: Boolean; pSort: Boolean; pConstraints: TConstraints;
      pObjectJson: Boolean = False; pTableSource: string = ''); overload;
  end;

  TTypeJSONValue = (tpJsonObject, tpJsonArray);

  JSONValue = class(TCustomAttribute)
  private
    FTableName: String;
    FResourceName: string;
    FMasterField: string;
    FFKField: string;

    FTypeJsonValue: TTypeJSONValue;
  public
    property TableName: String read FTableName write FTableName;
    property ResourceName: String read FResourceName write FResourceName;
    property MasterField: String read FMasterField write FMasterField;
    property FKField: String read FFKField write FFKField;

    property TypeJsonValue: TTypeJSONValue read FTypeJsonValue
      write FTypeJsonValue;
    constructor Create(pTableName, pResourceName, pMasterField,
      pFKField: string; pTypeJsonValue: TTypeJSONValue);
  end;

  TMacAddress = class
  private
    FValue: String;
  public
    constructor Create(pValue: String); overload;
    property Value: String read FValue;
  end;

  TBytea = class
  private
    FValue: TStringList;
  public
    constructor Create(pValue: String); overload;
    destructor Destroy(); override;
    property Value: TStringList read FValue;
  end;

  DBFieldTypeMemo = class(TCustomAttribute);

  Authorization = class(TCustomAttribute);

implementation

{ Resource }

constructor Resource.Create(pResourceName: String;
  pMasterDateil: Boolean = False);
begin
  Self.ResourceName := pResourceName;
  MasterDateil := pMasterDateil;
end;

{ Table }

constructor Table.Create(pTableName: String);
begin
  Self.TableName := pTableName;
end;

{ Field }

constructor DBField.Create(pFieldName: String; pHeader: Boolean;
  pListSelect: Boolean; pSort: Boolean; pConstraints: TConstraints;
  pObjectJson: Boolean = False; pTableSource: string = '');
begin
  Self.FieldName := pFieldName;
  Self.Constraints := pConstraints;
  Self.Header := pHeader;
  Self.ListSelect := pListSelect;
  Self.Sort := pSort;
  Self.FObjectJson := pObjectJson;
  Self.FTableSource := pTableSource;
end;

{ TAutoInc }

constructor AutoInc.Create(pSequenceName: String);
begin
  Self.SequenceName := pSequenceName;
end;


{ TMacAddress }

constructor TMacAddress.Create(pValue: String);
begin
  FValue := pValue;
end;

{ TBytea }

constructor TBytea.Create(pValue: String);
begin
  FValue := TStringList.Create();
  FValue.Text := pValue;
end;

destructor TBytea.Destroy;
begin
  FreeAndNil(FValue);
  inherited;
end;

{ JSONValue }

constructor JSONValue.Create(pTableName, pResourceName, pMasterField,
  pFKField: string; pTypeJsonValue: TTypeJSONValue);
begin
  Self.FTableName := pTableName;
  Self.FMasterField := pMasterField;
  Self.FFKField := pFKField;
  Self.FTypeJsonValue := pTypeJsonValue;
  Self.FResourceName := pResourceName;
end;

{ ForengKeyDBField }

constructor ForengKeyDBField.Create(pFieldName, pTable: String;
  pTipoJoin: TTipoJoin);
begin
  Self.FFieldName := pFieldName;
  Self.FTable := pTable;
  Self.FTipoJoin := pTipoJoin;
end;

{ FkConstraints }

constructor FkConstraints.Create(pKeyField, pTableReference,
  pKeyReference: String; pTipoJoin: TTipoJoin; pMasterTable: string = '');
begin
  Self.FKeyField := pKeyField;
  Self.FTableReference := pTableReference;
  Self.FKeyReference := pKeyReference;
  Self.FTipoJoin := pTipoJoin;
  Self.FMasterTable := pMasterTable;
end;

{ TCustomSqlclauses }

constructor TCustomSqlclauses.Create(pCustomSelect, pCustomWhere, pCustomJoin,
  pCustomGroupBy: String);
begin
  Self.FCustomSelect := pCustomSelect;
  Self.FCustomWhere := pCustomWhere;
  Self.FCustomJoin := pCustomJoin;
  Self.FCustomGroupBy := pCustomGroupBy;
end;

{ TResourceDetail }

constructor TResourceDetail.Create(pResourceName, pKeyField,
  pKeyReference: String);
begin
  Self.FResourceName := pResourceName;
  Self.FKeyField := pKeyField;
  Self.FKeyReference := pKeyReference;
end;

end.
