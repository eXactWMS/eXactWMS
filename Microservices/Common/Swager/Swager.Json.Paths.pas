{
  ____________________________________________________________________________

  █░█░█ █ █░░ █▀ █▀█ █▄░█   █░░ █░█ ▀█
  ▀▄▀▄▀ █ █▄▄ ▄█ █▄█ █░▀█   █▄▄ █▄█ █▄ ©  2023
  Map paths to swager Json
  ______________________________________________________________________________
}
unit Swager.Json.Paths;

interface

uses
  Swager.Json.DTO,
  System.Generics.Collections,
  System.Rtti,
  REST.Json.Types, System.classes;

{$M+}

const
  _ctToken =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE4ODY2MjAwOTQsInVzZXJpZCI6MH0.lf91mkYaHWXDTlQFSBeYuEApiWTN4QDUpAQ5u3DDIPg';

type
  TActionsFlags = set of (afPost, afGet, afPut, afDelete, afAuthentification);

type

  T_200 = class;

  T_500 = class;
  TDelete = class;
  TGet = class;
  TParameters = class;
  TPost = class;
  TPut = class;
  TResponses = class;
  TSchema = class;

  TResponses = class
  private
    [JSONName('200')]
    F_200: T_200;
    [JSONName('204')]

    [JSONName('500')]
    F_500: T_500;
  published
    property _200: T_200 read F_200;

    property _500: T_500 read F_500;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TParameters = class
  private

  published

  public
    constructor Create;
    destructor Destroy; override;
  end;

  TParametersBody = class(TParameters)
  private

    FIn: string;
    FName: string;
    FRequired: Boolean;
    FSchema: TSchema;

  published

    property &In: string read FIn write FIn;
    property Name: string read FName write FName;
    property Required: Boolean read FRequired write FRequired;
    property Schema: TSchema read FSchema;

  public
    constructor Create;
    destructor Destroy; override;
  end;

  TParametersBodyId = class(TParameters)
  private

    FIn: string;
    FName: string;
    FRequired: Boolean;
    FType: string;
  published

    property &In: string read FIn write FIn;
    property Name: string read FName write FName;
    property Required: Boolean read FRequired write FRequired;
    property &Type: string read FType write FType;

  public
    constructor Create;
    destructor Destroy; override;
  end;

  TParametersHeader = class(TParameters)
  private
    FDescription: string;
    FExample: string;
    FIn: string;
    FName: string;
    FRequired: Boolean;
    FType: string;

  published
    property Name: string read FName write FName;
    property &In: string read FIn write FIn;
    property Description: string read FDescription write FDescription;
    property Example: string read FExample write FExample;
    property Required: Boolean read FRequired write FRequired;
    property &Type: string read FType write FType;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDelete = class(TJsonDTO)
  private
    FTags: TArray<string>;
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;

    [JSONMarshalled(False)]

    function GetParameters: TObjectList<TParameters>;

  protected
    function GetAsJson: string; override;
  published
    property Tags: TArray<string> read FTags write FTags;
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  T_500 = class
  private
    [JSONName('$ref')]
    FRef: string;
  published
    property Ref: string read FRef write FRef;
  end;

  T_200 = class
  private
    [JSONName('$ref')]
    FRef: string;
  published
    property Ref: string read FRef write FRef;
  end;

  TSchema = class
  private
    [JSONName('$ref')]
    FRef: string;
  published
    property Ref: string read FRef write FRef;
  end;

  TPut = class(TJsonDTO)
  private
    FTags: TArray<string>;
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONMarshalled(False)]
    function GetParameters: TObjectList<TParameters>;

  protected
    function GetAsJson: string; override;
  published
    property Tags: TArray<string> read FTags write FTags;
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TGet = class(TJsonDTO)
  private
    FTags: TArray<string>;
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONMarshalled(False)]

    function GetParameters: TObjectList<TParameters>;

  protected
    function GetAsJson: string; override;
  published
    property Tags: TArray<string> read FTags write FTags;
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;

  TResourceBaseId = class
  private
    FDelete: TDelete;
    FGet: TGet;
    FPut: TPut;
  published
    property Delete: TDelete read FDelete;
    property Get: TGet read FGet;
    property Put: TPut read FPut;
  public
    constructor Create(Flags: TActionsFlags);
    destructor Destroy; override;
  end;

  TPost = class(TJsonDTO)
  private
    FTags: TArray<string>;
    FDescription: string;
    FOperationId: string;

    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONMarshalled(False)]

    function GetParameters: TObjectList<TParameters>;

  protected
    function GetAsJson: string; override;
  published
    property Tags: TArray<string> read FTags write FTags;
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TResourceBase = class
  private
    FGet: TGet;
    FPost: TPost;
  published
    property Get: TGet read FGet;
    property Post: TPost read FPost;
  public
    constructor Create(Flags: TActionsFlags);
    destructor Destroy; override;
  end;

  TRoot = class(TJsonDTO)
  private
    [JSONName('/$ResourceBase')]
    FResourceBase: TResourceBase;
    [JSONName('/$ResourceBase/{id}')]
    FResourceBaseId: TResourceBaseId;
    FFlags: TActionsFlags;
  published
    property ResourceBase: TResourceBase read FResourceBase;
    property ResourceBaseId: TResourceBaseId read FResourceBaseId;
    property Flags: TActionsFlags read FFlags write FFlags;
  public

    constructor Create(); override;
    destructor Destroy; override;
    procedure CreateNodes();
  end;

implementation

{ TResponses }

constructor TResponses.Create;
begin
  inherited;
  F_200 := T_200.Create;
  F_500 := T_500.Create;

end;

destructor TResponses.Destroy;
begin
  F_200.Free;
  F_500.Free;

  inherited;
end;

{ TParameters }

constructor TParameters.Create;
begin
  inherited;
  // FSchema := TSchema.Create;
end;

destructor TParameters.Destroy;
begin
  // FSchema.Free;
  inherited;
end;

{ TDelete }

constructor TDelete.Create;
var
  _header: TParametersHeader;
  _body: TParametersBodyId;
begin
  inherited;
  FResponses := TResponses.Create;
  SetLength(FTags, 1);
  FTags[0] := '$ResourceBase';
  Description := 'Apagar  $ResourceBase (s)';
  FParameters := TObjectList<TParameters>.Create;
  _header := TParametersHeader.Create;
  _header.Name := 'x-api-key';
  _header.&In := 'header';
  _header.Description := 'token bearer';
  _header.Example := _ctToken;
  _header.Required := true;
  _header.&Type := 'string';
  FParameters.Add(_header);
  _body := TParametersBodyId.Create;
  _body.&In := 'path';
  _body.Name := 'id';
  _body.Required := true;
  _body.&Type := 'integer';

  FParameters.Add(_body);
  FResponses := TResponses.Create;
  FResponses.F_200 := T_200.Create;
  FResponses.F_200.FRef := '/resources/ResponseBase.json#/200';
  FResponses.F_500 := T_500.Create;
  FResponses.F_500.FRef := '/resources/ResponseBase.json#/500';
end;

destructor TDelete.Destroy;
begin
  FResponses.Free;

  GetParameters.Free;
  inherited;
end;

function TDelete.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TDelete.GetAsJson: string;
begin

  RefreshArray<TParameters>(FParameters, FParametersArray);

  Result := inherited;
end;

{ TPut }

constructor TPut.Create;
var
  _header: TParametersHeader;
  _bodyId: TParametersBodyId;
  _body: TParametersBody;
begin
  inherited;
  FResponses := TResponses.Create;
  SetLength(FTags, 1);
  FTags[0] := '$ResourceBase';
  Description := 'Atualizar  $ResourceBase (s)';
  FParameters := TObjectList<TParameters>.Create;
  _header := TParametersHeader.Create;
  _header.Name := 'x-api-key';
  _header.&In := 'header';
  _header.Description := 'token bearer';
  _header.Example := _ctToken;
  _header.Required := true;
  _header.&Type := 'string';
  FParameters.Add(_header);
  _bodyId := TParametersBodyId.Create;
  _bodyId.&In := 'path';
  _bodyId.Name := 'id';
  _bodyId.Required := true;
  _bodyId.&Type := 'integer';
  FParameters.Add(_bodyId);

  _body := TParametersBody.Create;
  _body.&In := 'body';
  _body.Name := 'id';
  _body.Required := true;

  if Not assigned(_body.FSchema) then
    _body.FSchema := TSchema.Create;
  _body.Schema.Ref := '#/definitions/$ResourceBase';
  FParameters.Add(_body);

  FResponses := TResponses.Create;
  FResponses.F_200 := T_200.Create;
  FResponses.F_200.FRef := '/resources/ResponseBase.json#/200';

  FResponses.F_500.FRef := '/resources/ResponseBase.json#/500';
end;

destructor TPut.Destroy;
begin
  FResponses.Free;

  GetParameters.Free;
  inherited;
end;

function TPut.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TPut.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);

  Result := inherited;
end;

{ TGet }

constructor TGet.Create();
var
  _header: TParametersHeader;

begin
  inherited;
  FResponses := TResponses.Create;
  SetLength(FTags, 1);
  FTags[0] := '$ResourceBase';
  Description := 'Retornar lista de  $ResourceBase (s)';
  FParameters := TObjectList<TParameters>.Create;
  _header := TParametersHeader.Create;
  _header.Name := 'x-api-key';
  _header.&In := 'header';
  _header.Description := 'token bearer';
  _header.Example := _ctToken;
  _header.Required := true;
  _header.&Type := 'string';
  FParameters.Add(_header);

  FResponses.F_200.FRef := '/resources/ResponseConsulta.json#/200';

  FResponses.F_500.FRef := '/resources/ResponseConsulta.json#/500';

end;

destructor TGet.Destroy;
begin
  FResponses.Free;
  GetParameters.Free;
  inherited;
end;

function TGet.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TGet.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);
  Result := inherited;
end;

{ TResourceBaseId }

constructor TResourceBaseId.Create(Flags: TActionsFlags);
var
  _bodyId: TParametersBodyId;
begin

  if afGet in Flags then
  begin
    FGet := TGet.Create;
    if InheritsFrom(TResourceBaseId) then
    begin
      _bodyId := TParametersBodyId.Create;
      _bodyId.&In := 'path';
      _bodyId.Name := 'id';
      _bodyId.Required := true;
      _bodyId.&Type := 'integer';
      FGet.FParameters.Add(_bodyId);
    end;
  end;
  if afPut in Flags then
    FPut := TPut.Create;
  if afDelete in Flags then
    FDelete := TDelete.Create;
end;

destructor TResourceBaseId.Destroy;
begin
  if assigned(FGet) then
    FGet.Free;
  if assigned(FPut) then
    FPut.Free;
  if assigned(FDelete) then
    FDelete.Free;
  inherited;
end;

{ TPost }

constructor TPost.Create;
var
  _header: TParametersHeader;
  _body: TParametersBody;
begin
  inherited;
  FResponses := TResponses.Create;
  FParameters := TObjectList<TParameters>.Create;
  SetLength(FTags, 1);
  FTags[0] := '$ResourceBase';
  Description := 'Incluir novo  $ResourceBase (s)';


  _header := TParametersHeader.Create;
  _header.Name := 'x-api-key';
  _header.&In := 'header';
  _header.Description := 'token bearer';
  _header.Example := _ctToken;
  _header.Required := true;
  _header.&Type := 'string';
  FParameters.Add(_header);
  _body := TParametersBody.Create;
  _body.&In := 'body';
  _body.Name := 'id';
  _body.Required := true;
  _body.FSchema := TSchema.Create;
  _body.Schema.Ref := '#/definitions/$ResourceBase';
  FParameters.Add(_body);
  FResponses := TResponses.Create;
  FResponses.F_200 := T_200.Create;
  FResponses.F_200.FRef := '/resources/ResponseBase.json#/200';

  FResponses.F_500.FRef := '/resources/ResponseBase.json#/500';

end;

destructor TPost.Destroy;
begin
  FResponses.Free;
  GetParameters.Free;
  inherited;
end;

function TPost.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TPost.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);
  Result := inherited;
end;

{ TResourceBase }

constructor TResourceBase.Create(Flags: TActionsFlags);
begin

  if afGet in Flags then
    FGet := TGet.Create;
  if afPost in Flags then
    FPost := TPost.Create;
end;

destructor TResourceBase.Destroy;
begin
  if assigned(FGet) then
    FGet.Free;
  if assigned(FPost) then
    FPost.Free;
  inherited;
end;

{ TRoot }

constructor TRoot.Create();
begin
  inherited;
end;

procedure TRoot.CreateNodes;
begin
  FResourceBase := TResourceBase.Create(FFlags);
  if (afDelete in FFlags) or (afPut in FFlags) or ((afGet in FFlags)) then
    FResourceBaseId := TResourceBaseId.Create(FFlags);;
end;

destructor TRoot.Destroy;
begin
  FResourceBase.Free;
  if assigned(FResourceBaseId) then
    FResourceBaseId.Free;
  inherited;
end;

{ TParametersHeader }

constructor TParametersHeader.Create;
begin
  // **///

end;

destructor TParametersHeader.Destroy;
begin

  inherited;
end;

{ TParametersBody }

constructor TParametersBody.Create;
begin
  inherited;
end;

destructor TParametersBody.Destroy;
begin

  inherited;
end;

{ TParametersBodyId }

constructor TParametersBodyId.Create;
begin
  // **//
end;

destructor TParametersBodyId.Destroy;
begin

  inherited;
end;

end.
