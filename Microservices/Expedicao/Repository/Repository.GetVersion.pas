unit Repository.GetVersion;

interface

uses
  System.Classes,
  Server.Attributes,

  json,
  System.SysUtils,
  Server.Connection,
  Resources.configupdate,
  REST.json,

  System.Generics.Collections,
  Server.MessageList,
  Web.HTTPApp,
  Server.Message,
  System.Rtti,

  Server.ResourceBaseClass;

type

  [Resource('getversion')]

  TGetVersion = class(TPersistent)
  private

  protected

  public

    [Get]
    procedure Get(Response: TWebResponse; PageNumber: Integer;
      PageSize: Integer; Direction: String; Sort: String; Search: String;
      ID: String; Join: string; json: TJSONObject);
  end;

implementation

{ TGetVersion }

procedure TGetVersion.Get(Response: TWebResponse; PageNumber, PageSize: Integer;
  Direction, Sort, Search, ID, Join: string; json: TJSONObject);
var
  conf: TConfigupdate;
begin
  try
    conf := TConfigupdate.create();
    conf.Get(Response, PageNumber, PageSize, Direction, Sort, Search, ID,
      Join, json)
  finally
    FreeAndNil(conf)
  end;

end;

initialization

RegisterClass(TGetVersion);

end.
