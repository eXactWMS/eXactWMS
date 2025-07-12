unit Server.Records;

interface

uses
  Web.HTTPApp, System.Generics.Collections;

type
  TValuesRequest = class

    Request: TWebRequest;
    Response: TWebResponse;
    PageNumber: Integer;
    PageSize: Integer;
    Direction: String;
    Sort: String;
    Search: String;
    Join: string;
    ID: string;
  end;

  TTypeFildTable = (tpFInteger, tpFString, tpFBoolean, tpFDate, tpFObject,
    tpFArrayObject);

type
  TJSONObjectField = class
    MasterField: string;
    FkField: string;
    TableFK: string;
    ResourceName: string;
  end;

type

  TMapperAttributes = class
  private
  public
    Table: string;
    DictionaryFilds: TDictionary<string, string>;
    DBFieldName: string;
    JSONFieldName: string;
    TypeFieldName: string;
    TypeField: TTypeFildTable;
    JSONObjectField: TJSONObjectField;
    constructor Create();
    destructor Destroy(); override;
    procedure CopyClass(AMapperAttributes: TMapperAttributes);
  end;

implementation

{ TMapperAttributes }

procedure TMapperAttributes.CopyClass(AMapperAttributes: TMapperAttributes);
begin
  Self.Table := AMapperAttributes.Table;
  Self.DBFieldName := AMapperAttributes.DBFieldName;
  Self.JSONFieldName := AMapperAttributes.JSONFieldName;
  Self.TypeField := AMapperAttributes.TypeField;
  Self.TypeFieldName := AMapperAttributes.TypeFieldName;
  Self.JSONObjectField.MasterField :=
    AMapperAttributes.JSONObjectField.MasterField;
  Self.JSONObjectField.FkField := AMapperAttributes.JSONObjectField.FkField;
  Self.JSONObjectField.TableFK := AMapperAttributes.JSONObjectField.TableFK;
  Self.JSONObjectField.ResourceName :=
    AMapperAttributes.JSONObjectField.ResourceName;

end;

constructor TMapperAttributes.Create;
begin
  JSONObjectField := TJSONObjectField.Create;
  DictionaryFilds := TDictionary<string, string>.Create();
end;

destructor TMapperAttributes.Destroy;
begin

  inherited;
end;

end.
