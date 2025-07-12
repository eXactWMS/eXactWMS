unit postManCollection;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TBody = class;
  THeader = class;
  TItem = class;
  TOauth2 = class;
  TOptions = class;
  TRaw = class;
  TRequest = class;
  TResponse = class;
  TScript = class;
  TUrl = class;

  TScript = class(TJsonDTO)
  private
    [JSONName('exec')]
    FExecArray: TArray<string>;
    [JSONMarshalled(False)]
    FExec: TList<string>;
    FType: string;
    function GetExec: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Exec: TList<string> read GetExec;
    property &Type: string read FType write FType;
  public
    destructor Destroy; override;
  end;
  
  TEvent = class
  private
    FListen: string;
    FScript: TScript;
  published
    property Listen: string read FListen write FListen;
    property Script: TScript read FScript;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TOauth2 = class
  private
    FKey: string;
    FType: string;
    FValue: string;
  published
    property Key: string read FKey write FKey;
    property &Type: string read FType write FType;
    property Value: string read FValue write FValue;
  end;
  
  TAuth = class(TJsonDTO)
  private
    [JSONName('oauth2'), JSONMarshalled(False)]
    FOauth2Array: TArray<TOauth2>;
    [GenericListReflect]
    FOauth2: TObjectList<TOauth2>;
    FType: string;
    function GetOauth2: TObjectList<TOauth2>;
  protected
    function GetAsJson: string; override;
  published
    property Oauth2: TObjectList<TOauth2> read GetOauth2;
    property &Type: string read FType write FType;
  public
    destructor Destroy; override;
  end;
  
  TResponse = class
  end;
  
  TUrl = class(TJsonDTO)
  private
    [JSONName('host')]
    FHostArray: TArray<string>;
    [JSONMarshalled(False)]
    FHost: TList<string>;
    [JSONName('path')]
    FPathArray: TArray<string>;
    [JSONMarshalled(False)]
    FPath: TList<string>;
    FPort: string;
    FProtocol: string;
    FRaw: string;
    function GetHost: TList<string>;
    function GetPath: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Host: TList<string> read GetHost;
    property Path: TList<string> read GetPath;
    property Port: string read FPort write FPort;
    property Protocol: string read FProtocol write FProtocol;
    property Raw: string read FRaw write FRaw;
  public
    destructor Destroy; override;
  end;
  
  TRaw = class
  private
    FLanguage: string;
  published
    property Language: string read FLanguage write FLanguage;
  end;
  
  TOptions = class
  private
    FRaw: TRaw;
  published
    property Raw: TRaw read FRaw;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TBody = class
  private
    FMode: string;
    FOptions: TOptions;
    FRaw: string;
  published
    property Mode: string read FMode write FMode;
    property Options: TOptions read FOptions;
    property Raw: string read FRaw write FRaw;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  THeader = class
  end;
  
  TRequest = class(TJsonDTO)
  private
    FBody: TBody;
    [JSONName('header'), JSONMarshalled(False)]
    FHeaderArray: TArray<THeader>;
    [GenericListReflect]
    FHeader: TObjectList<THeader>;
    FMethod: string;
    FUrl: TUrl;
    function GetHeader: TObjectList<THeader>;
  protected
    function GetAsJson: string; override;
  published
    property Body: TBody read FBody;
    property Header: TObjectList<THeader> read GetHeader;
    property Method: string read FMethod write FMethod;
    property Url: TUrl read FUrl;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
  TItem = class(TJsonDTO)
  private
    [JSONName('item'), JSONMarshalled(False)]
    FItemArray: TArray<TItem>;
    [GenericListReflect]
    FItem: TObjectList<TItem>;
    FName: string;
    FRequest: TRequest;
    [JSONName('response'), JSONMarshalled(False)]
    FResponseArray: TArray<TResponse>;
    [GenericListReflect]
    FResponse: TObjectList<TResponse>;
    function GetItem: TObjectList<TItem>;
    function GetResponse: TObjectList<TResponse>;
  protected
    function GetAsJson: string; override;
  published
    property Item: TObjectList<TItem> read GetItem;
    property Name: string read FName write FName;
    property Request: TRequest read FRequest;
    property Response: TObjectList<TResponse> read GetResponse;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
  TInfo = class
  private
    FName: string;
    [JSONName('_postman_id')]
    FPostmanId: string;
    FSchema: string;
  published
    property Name: string read FName write FName;
    property PostmanId: string read FPostmanId write FPostmanId;
    property Schema: string read FSchema write FSchema;
  end;
  
  TRoot = class(TJsonDTO)
  private
    FAuth: TAuth;
    [JSONName('event'), JSONMarshalled(False)]
    FEventArray: TArray<TEvent>;
    [GenericListReflect]
    FEvent: TObjectList<TEvent>;
    FInfo: TInfo;
    [JSONName('item'), JSONMarshalled(False)]
    FItemArray: TArray<TItem>;
    [GenericListReflect]
    FItem: TObjectList<TItem>;
    function GetEvent: TObjectList<TEvent>;
    function GetItem: TObjectList<TItem>;
  protected
    function GetAsJson: string; override;
  published
    property Auth: TAuth read FAuth;
    property Event: TObjectList<TEvent> read GetEvent;
    property Info: TInfo read FInfo;
    property Item: TObjectList<TItem> read GetItem;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
implementation

{ TScript }

destructor TScript.Destroy;
begin
  GetExec.Free;
  inherited;
end;

function TScript.GetExec: TList<string>;
begin
  Result := List<string>(FExec, FExecArray);
end;

function TScript.GetAsJson: string;
begin
  RefreshArray<string>(FExec, FExecArray);
  Result := inherited;
end;

{ TEvent }

constructor TEvent.Create;
begin
  inherited;
  FScript := TScript.Create;
end;

destructor TEvent.Destroy;
begin
  FScript.Free;
  inherited;
end;

{ TAuth }

destructor TAuth.Destroy;
begin
  GetOauth2.Free;
  inherited;
end;

function TAuth.GetOauth2: TObjectList<TOauth2>;
begin
  Result := ObjectList<TOauth2>(FOauth2, FOauth2Array);
end;

function TAuth.GetAsJson: string;
begin
  RefreshArray<TOauth2>(FOauth2, FOauth2Array);
  Result := inherited;
end;

{ TUrl }

destructor TUrl.Destroy;
begin
  GetHost.Free;
  GetPath.Free;
  inherited;
end;

function TUrl.GetHost: TList<string>;
begin
  Result := List<string>(FHost, FHostArray);
end;

function TUrl.GetPath: TList<string>;
begin
  Result := List<string>(FPath, FPathArray);
end;

function TUrl.GetAsJson: string;
begin
  RefreshArray<string>(FHost, FHostArray);
  RefreshArray<string>(FPath, FPathArray);
  Result := inherited;
end;

{ TOptions }

constructor TOptions.Create;
begin
  inherited;
  FRaw := TRaw.Create;
end;

destructor TOptions.Destroy;
begin
  FRaw.Free;
  inherited;
end;

{ TBody }

constructor TBody.Create;
begin
  inherited;
  FOptions := TOptions.Create;
end;

destructor TBody.Destroy;
begin
  FOptions.Free;
  inherited;
end;

{ TRequest }

constructor TRequest.Create;
begin
  inherited;
  FBody := TBody.Create;
  FUrl := TUrl.Create;
end;

destructor TRequest.Destroy;
begin
  FBody.Free;
  FUrl.Free;
  GetHeader.Free;
  inherited;
end;

function TRequest.GetHeader: TObjectList<THeader>;
begin
  Result := ObjectList<THeader>(FHeader, FHeaderArray);
end;

function TRequest.GetAsJson: string;
begin
  RefreshArray<THeader>(FHeader, FHeaderArray);
  Result := inherited;
end;

{ TItem }

constructor TItem.Create;
begin
  inherited;
  FRequest := TRequest.Create;
end;

destructor TItem.Destroy;
begin
  FRequest.Free;
  GetItem.Free;
  GetResponse.Free;
  inherited;
end;

function TItem.GetItem: TObjectList<TItem>;
begin
  Result := ObjectList<TItem>(FItem, FItemArray);
end;

function TItem.GetResponse: TObjectList<TResponse>;
begin
  Result := ObjectList<TResponse>(FResponse, FResponseArray);
end;

function TItem.GetAsJson: string;
begin
  RefreshArray<TItem>(FItem, FItemArray);
  RefreshArray<TResponse>(FResponse, FResponseArray);
  Result := inherited;
end;

{ TRoot }

constructor TRoot.Create;
begin
  inherited;
  FInfo := TInfo.Create;
  FAuth := TAuth.Create;
end;

destructor TRoot.Destroy;
begin
  FInfo.Free;
  FAuth.Free;
  GetItem.Free;
  GetEvent.Free;
  inherited;
end;

function TRoot.GetEvent: TObjectList<TEvent>;
begin
  Result := ObjectList<TEvent>(FEvent, FEventArray);
end;

function TRoot.GetItem: TObjectList<TItem>;
begin
  Result := ObjectList<TItem>(FItem, FItemArray);
end;

function TRoot.GetAsJson: string;
begin
  RefreshArray<TEvent>(FEvent, FEventArray);
  RefreshArray<TItem>(FItem, FItemArray);
  Result := inherited;
end;

end.
