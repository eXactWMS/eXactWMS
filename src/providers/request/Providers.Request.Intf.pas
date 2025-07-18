unit Providers.Request.Intf;

interface

uses
  RestRequest4D, System.JSON, System.Classes;

type
  IRequest = interface
    ['{FC784E0C-2E45-4AB8-875D-B4D7150B179F}']
    function BaseURL(const AValue: string): IRequest;
    function Resource(const AValue: string): IRequest;
    function ResourceSuffix(const AValue: string): IRequest;
    function AddParam(const AKey, AValue: string): IRequest;
    function ContentType(const AValue: string): IRequest;
    function ClearBody: IRequest;
    function ClearParams: IRequest;
    function AddBody(const ABody: TJSONObject; const AOwns: Boolean = True): IRequest; overload;
    function AddBody(const ABody: TMemoryStream; const AOwns: Boolean = True): IRequest; overload;
    function Get: IResponse;
    function Post: IResponse;
    function Delete: IResponse;
    function Put: IResponse;
  end;

implementation

end.
