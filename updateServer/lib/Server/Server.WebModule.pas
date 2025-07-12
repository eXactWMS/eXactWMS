{$DEFINE DEBUGON}
unit Server.WebModule;

interface

uses
  System.SysUtils,
  Server.Util,
  Server.Constants,
  System.Classes,
  Web.HTTPApp,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker,
  Datasnap.DSServer,
  FireDAC.Stan.Param,
  Web.WebFileDispatcher,
  Server.Utils.SectionVariables,
  Web.HTTPProd,
  System.JSON,
  Datasnap.DSAuth,
  Datasnap.DSProxyJavaScript,
  IPPeerServer,
  Datasnap.DSMetadata,
  Datasnap.DSServerMetadata,
  Datasnap.DSClientMetadata,
  Datasnap.DSCommonServer,
  Datasnap.DSHTTP, System.Rtti,
  Server.Attributes,
  Server.Config,
  Server.Connection,
  Data.DB,
  System.Generics.Collections,

  Server.Authentication,
  Server.Records;

type
  obj = class(Tobject);

type
  TWebModuleApi = class(TWebModule)
    procedure WebModuleCreate(Sender: Tobject);
    procedure WebModuleApiWebActionPadraoAction(Sender: Tobject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: Tobject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private

    procedure GetClassesProc(AClass: TPersistentClass);
    procedure SetAction(Classe: TRttiType; Attribute: TCustomAttribute;
      Metodo: TRttiMethod; AttributeMethod: TCustomAttribute);
    procedure WebModuleApiWebAction(Sender: Tobject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure Execute(AClassName, AMethodName: String; Params: array of TValue);
    procedure SetClassName(lDados: TArray<String>; var ClassName: string);
    procedure SetParamsGet(Request: TWebRequest; var PageNumber: Integer;
      var PageSize: Integer; var Direction: String; var Sort: String;
      var Search: String; var Join: string); overload;
    procedure SetParamsGet(Request: TWebRequest; var PageNumber: Integer;
      var PageSize: Integer; var Direction: String; var Sort: String;
      var Search: String; var Join: string; var JSON: TJSONObject); overload;
    procedure ExecAction(Request: TWebRequest; Response: TWebResponse;
      Name: String);
    procedure ValidarAcesso(pValue: String);
    function ValidarUsuarioPadrao(AParams: TDictionary<string, string>)
      : Boolean;
    function IsMasterDatail(AClassName: string): Boolean;
    function IsFileRequest(Request: TWebRequest;
      Response: TWebResponse): Boolean;

    procedure ValidarPermissoes(ResourceName, MetodName: string);

  public
  end;

var
  WebModuleClass: TComponentClass = TWebModuleApi;

implementation

{$R *.dfm}

uses
  Web.WebReq, FireDAC.Comp.Client, System.Types, System.DateUtils,
  Server.Message, Server.MessageList, Server.Token,
  System.NetEncoding;
function ParseResourceName(value:string):string;
var
 lDados: TArray<String>;
 Item: String;
   I: Integer;
begin
  I := 0;
  result:='';
  lDados := string(value).Split(['/']);
  for Item in lDados do
  begin
    if Item = 'v1' then
    begin
      result := lDados[I + 1];
      Break;
    end
    else
      Inc(I);
  end;
end;

procedure TWebModuleApi.WebModuleApiWebActionPadraoAction(Sender: Tobject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lDados: TArray<String>;
  Resource: String;
   I: Integer;
  Redirect: Boolean;
begin
  Redirect := False;
  I := 0;
  Resource:=ParseResourceName(Request.PathInfo) ;
  for I := 0 to Self.Actions.Count - 1 do
  begin
    if Self.Actions.Items[I].MethodType = Request.MethodType then
    begin
      if Self.Actions.Items[I].PathInfo = '/v1/' + Resource then
      begin
        ExecAction(Request, Response, Self.Actions.Items[I].Name);
        Redirect := True;
      end;
    end;
  end;
  if not(Redirect) then
    Response.Content := 'Update Server - 1.0';
end;

procedure TWebModuleApi.WebModuleBeforeDispatch(Sender: Tobject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

begin
  Try
    Response.SetCustomHeader('Access-Control-Allow-Origin', '*');
    Response.SetCustomHeader('Access-Control-Allow-Methods', 'Content-Type');
    if Request.UserAgent.ToLower().Contains('postman') then
    begin
      Response.SetCustomHeader('Content-Type', 'application/json');
    end;
    Response.SetCustomHeader('Access-Control-Allow-Methods', 'Authorization');
    Response.SetCustomHeader('Access-Control-Allow-Methods',
      'GET,POST,PUT,PATCH,OPTIONS,DELETE');
    if trim(Request.GetFieldByName('Access-Control-Request-Headers')) <> EmptyStr
    then
    begin
      Response.SetCustomHeader('Access-Control-Allow-Headers',
        Request.GetFieldByName('Access-Control-Request-Headers'));
      Handled := True;
    end;

    if Request.Method <> 'OPTIONS' then
    begin
      Response.SetCustomHeader('path', Request.PathInfo);
      if LowerCase(Request.PathInfo) = '/v1/ping' then
        TMessage.Create(IServidorConnectado, 'Server connectado')
          .SendMessage(Response)

      else if not IsFileRequest(Request, Response) then
      begin
        if (LowerCase(Request.PathInfo) <> '/v1/authorization') and
          (LowerCase(Request.PathInfo) <> '/v1/sendemail') and (LowerCase(Request.PathInfo) <> '/v1/getversion') and
           (LowerCase(Request.PathInfo) <> '/v1/uploadapk')
          then
        begin
          if not Request.GetFieldByName('x-api-mobile').Equals('device-mobile')
          then
            Response.SetCustomHeader('Content-Type',
              'application/json;charset=UTF-8');
          ValidarAcesso(Request.GetFieldByName('x-api-key'));

        end;

      end;
    end;
  except
    on e: Exception do
    begin
      Response.SetCustomHeader('Content-Type', 'application/json');
      TMessage.Create(EErroGeral, e.Message).SendMessage(Response)
    end;
  end;
end;
                                                                                        procedure TWebModuleApi.WebModuleCreate(Sender: Tobject);
var
  ClassFinder: TClassFinder;
begin
  ClassFinder := TClassFinder.Create(nil);
  if assigned(ClassFinder) then
  begin
    try
      ClassFinder.GetClasses(GetClassesProc);
      TServerConfig.GetInstance;
    finally
      ClassFinder.Free;
    end;
  end;

end;

procedure TWebModuleApi.GetClassesProc(AClass: TPersistentClass);
var
  RttiContext: TRttiContext;
  Classe: TRttiType;
  Attribute: TCustomAttribute;
  Metodo: TRttiMethod;
  AttributeMethod: TCustomAttribute;
begin
  RttiContext := TRttiContext.Create;
  Classe := RttiContext.GetType(AClass);
  for Attribute in Classe.GetAttributes do
    if Attribute is Resource then
      for Metodo in Classe.GetMethods do
        for AttributeMethod in Metodo.GetAttributes do
        begin
          try

            SetAction(Classe, Attribute, Metodo, AttributeMethod);
          except

          end;
        end;
end;

procedure TWebModuleApi.SetAction(Classe: TRttiType;
  Attribute: TCustomAttribute; Metodo: TRttiMethod;
  AttributeMethod: TCustomAttribute);

begin
  try

    Self.Actions.Add;
    with Self.Actions.Items[Self.Actions.Count - 1] do
    begin
      PathInfo := '/v1/' + Resource(Attribute).ResourceName;

      Name := Classe.QualifiedName + '.' + Metodo.Name;
      if AttributeMethod is Get then
        MethodType := mtGet
      else if AttributeMethod is Post then
      begin
        MethodType := mtPost;

      end
      else if AttributeMethod is Put then
        MethodType := mtPut
      else if AttributeMethod is Delete then
        MethodType := mtDelete;

      OnAction := WebModuleApiWebAction;
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Erro ao registrar resource ' + Resource(Attribute)
        .ResourceName + ' - ' + Classe.QualifiedName + '.' + Metodo.Name)

    end;
  end;
end;

procedure TWebModuleApi.WebModuleApiWebAction(Sender: Tobject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin

  ExecAction(Request, Response, TWebActionItem(Sender).Name);
end;

procedure TWebModuleApi.ExecAction(Request: TWebRequest; Response: TWebResponse;
  Name: String);
var
  ClassName: String;
  MethodName: String;
  lDados: TArray<String>;
  Body: TJSONObject;
  lParams: Array of TValue;
  Resource: String;
  ID: String;
  PageNumber: Integer;
  PageSize: Integer;
  Direction: String;
  Sort: String;
  Search: String;
  Join: string;
  Item: String;
  JSON: TJSONObject;
  LValueRequest: TValuesRequest;
  I: Integer;
  LInicio: Ttime;
  RaisedErro: Boolean;
  MsgResp: string;

begin
  try

    LInicio := time;
    lDados := Name.Split(['.']);
    MethodName := lDados[Length(lDados) - 1];
    SetClassName(lDados, ClassName);

{$IFDEF LINUX}
{$IFDEF DEBUGON }
    Writeln('-----------------------------------------------------------');
    Writeln('Executando Path -> ' + ClassName + ' metodo : ' + MethodName +' Content: '+Request.Content);
{$ENDIF}
{$ENDIF}
    try


      Body := nil;
      if Request.Content <> EmptyStr then
      begin
        try
          Body := TJSONObject(TJSONObject.ParseJSONValue(Request.Content));
        except
          on e:exception do
          begin
            Writeln('Request content invalido');
            raise Exception.Create('Rquest content invalido');
          end;

        end;
      end;
      lDados := string(Request.PathInfo).Split(['/']);
      I := 0;
      ID := EmptyStr;
      for Item in lDados do
      begin
        if Item = 'v1' then
        begin
          Resource := lDados[I + 1];
          if ((I + 3) = Length(lDados)) then
          begin
            ID := lDados[I + 2];
            Break;
          end;
        end
        else
          Inc(I);
      end;

      if Request.MethodType = mtGet then
      begin
        if IsMasterDatail(ClassName) then
        begin
          SetParamsGet(Request, PageNumber, PageSize, Direction, Sort, Search,
            Join, JSON);
          LValueRequest := TValuesRequest.Create;
          LValueRequest.Request := Request;
          LValueRequest.Response := Response;
          LValueRequest.PageNumber := PageNumber;
          LValueRequest.PageSize := PageSize;
          LValueRequest.Direction := Direction;
          LValueRequest.Sort := Sort;
          LValueRequest.Search := Search;
          LValueRequest.Join := Join;
          LValueRequest.ID := ID;
          lParams := [LValueRequest];
        end
        else
        begin
          SetParamsGet(Request, PageNumber, PageSize, Direction, Sort, Search,
            Join, JSON);
          lParams := [Response, PageNumber, PageSize, Direction, Sort, Search,
            ID, Join, JSON];
        end;
      end
      else if Request.MethodType in [mtPost] then
        lParams := [Response, Body, nil]
      else if Request.MethodType in [mtPut] then
        lParams := [Response, ID.ToInteger, Body, nil]
      else if Request.MethodType in [mtDelete] then
        lParams := [Response, ID.ToInteger];
      Response.StatusCode := 200;
      Execute(ClassName, MethodName, lParams);
      MsgResp := Response.Content;

    except
      on e: Exception do
      begin
        RaisedErro := True;
        TWKUtil.gravalog('  --> Erro ao executar Path: ' + ClassName + 'Msg :' +
          e.Message);
        TMessage.Create(EErroGeral, e.Message + ' - ' +
          stringReplace(Request.Content, #13#10, '',
          [rfReplaceAll, rfIgnoreCase])).SendMessage(Response);

      end;
    end;
  finally

{$IFDEF LINUX}
{$IFDEF DEBUGON }
    if not RaisedErro then
    begin

      Writeln('Excucao finalizalizada  : ' + ClassName + '  Tempo Resposta : ' +
        FormatDateTime('hh:nn:ss.zzz', time - LInicio) + ' status ' +
        inttostr(Response.StatusCode));
    end;
{$ENDIF}
{$ENDIF}
  end;
end;

procedure TWebModuleApi.Execute(AClassName: String; AMethodName: String;
  Params: Array of TValue);
var
  RttiContext: TRttiContext;
  RttiInstanceType: TRttiInstanceType;
  RttiMethod: TRttiMethod;
  Instance: Tobject;
begin
  RttiContext := TRttiContext.Create;
  RttiInstanceType := RttiContext.FindType(AClassName).AsInstance;

  RttiMethod := RttiInstanceType.GetMethod('Create');
  Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType, []).AsObject;

  RttiMethod := RttiInstanceType.GetMethod(AMethodName);

  RttiMethod.Invoke(Instance, Params).AsString;
  Instance.Free;
end;

function TWebModuleApi.IsFileRequest(Request: TWebRequest;
  Response: TWebResponse): Boolean;

var
  lfilename: string;
  outstrem: TFileStream;
  isbasePath: Boolean;
  function isGraphicFile(lfilename: string): Boolean;
  begin
    result := (lfilename = '.ico') or (lfilename = '.png') or
      (lfilename = '.jpg') or (lfilename = '.jpeg') or (lfilename = '.bmp') or
      (lfilename = '.tif') or (lfilename = '.gif');
  end;
  procedure setContentType;
  begin
    if LowerCase(lfilename) = '.css' then
      Response.ContentType := 'text/css';

    if LowerCase(lfilename) = '.apk' then
      Response.ContentType := 'application/vnd.android.package-archive';
    if LowerCase(lfilename) = '.pdf' then
      Response.ContentType := 'application/pdf';
    if isGraphicFile(LowerCase(lfilename)) then
      Response.ContentType := 'image/x-icon';

  end;
  procedure setExpiresData();
  begin
    if (LowerCase(lfilename) = '.css') or (UpperCase(lfilename) = '.js') or
      (LowerCase(lfilename) = '.html') Then
    begin
      Response.Date := now;
      Response.LastModified := now;
      Response.Expires := Date + 10;
    end;
    if (LowerCase(lfilename) = 'app.js') or (LowerCase(lfilename) = '.js') then
    begin
      Response.Expires := now;
    end;
  end;

begin
  result := False;
  lfilename := '';
  isbasePath := Length(Request.PathInfo) = 1;
  lfilename := ExtractFileExt(stringReplace(Request.PathInfo, '/', PathDelim,
    [rfReplaceAll]));
  if (pos('.', lfilename) > 0) or (isbasePath) then
  begin
    result := True;
    setContentType();
    setExpiresData();
    if isbasePath then
      lfilename := ExtractFilePath(GetModuleName(HInstance)) + cWebRepository +
        PathDelim + 'index.html'
    else
      lfilename := ExtractFilePath(GetModuleName(HInstance)) + cWebRepository +
        stringReplace(Request.PathInfo, '/', PathDelim, [rfReplaceAll]);
    if FileExists(lfilename) then
    begin
      outstrem := TFileStream.Create(lfilename, fmOpenRead);
      Response.ContentStream := outstrem;
      Response.StatusCode := 200;
      Response.SendResponse;
    end
    else
    begin
      Response.StatusCode := 400;
      TMessage.Create(EErroGeral, 'Arquivo não encontrado')
        .SendMessage(Response);

    end;
  end;
end;

function TWebModuleApi.IsMasterDatail(AClassName: string): Boolean;
var
  RttiContext: TRttiContext;
  RttiInstanceType: TRttiInstanceType;
  Classe: TRttiType;
  Attribute: TCustomAttribute;
  RttiMethod: TRttiMethod;
  Instance: Tobject;
begin
  result := False;
  RttiContext := TRttiContext.Create;
  try
    RttiInstanceType := RttiContext.FindType(AClassName).AsInstance;
    RttiMethod := RttiInstanceType.GetMethod('Create');
    Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType, []).AsObject;
    for Attribute in RttiInstanceType.GetAttributes do
      if Attribute is Resource then
      begin
        result := Resource(Attribute).MasterDateil
      end;
  finally
    RttiContext.Free;
  end;
end;

procedure TWebModuleApi.SetClassName(lDados: TArray<String>;
  var ClassName: string);
var
  I: Integer;
begin
  ClassName := EmptyStr;
  for I := 0 to Length(lDados) - 2 do
    ClassName := ClassName + lDados[I] + '.';
  ClassName := ClassName.TrimRight(['.']);
end;

procedure TWebModuleApi.SetParamsGet(Request: TWebRequest;
  var PageNumber, PageSize: Integer; var Direction, Sort, Search, Join: string;
  var JSON: TJSONObject);
var
  LJSONString: String;
begin
  SetParamsGet(Request, PageNumber, PageSize, Direction, Sort, Search, Join);
  JSON := nil;
  if Request.QueryFields.IndexOfName('JSON') >= 0 then
  begin
    LJSONString := Request.QueryFields.Values['JSON'].Replace('<!', '{', [])
      .Replace('!>', '}', []);
    JSON := TJSONObject.ParseJSONValue(LJSONString) AS TJSONObject;
  end;
end;

procedure TWebModuleApi.SetParamsGet(Request: TWebRequest;
  var PageNumber: Integer; var PageSize: Integer; var Direction: String;
  var Sort: String; var Search: String; var Join: string);
var
  LJSONObj: TJSONObject;
begin
  PageNumber := 1;
  PageSize := 50;
  Direction := EmptyStr;
  Sort := EmptyStr;
  Search := EmptyStr;
  Join := EmptyStr;

  if Request.QueryFields.IndexOfName('pageNumber') >= 0 then
    PageNumber := Request.QueryFields.Values['pageNumber'].ToInteger;
  if Request.QueryFields.IndexOfName('pageSize') >= 0 then
    PageSize := Request.QueryFields.Values['pageSize'].ToInteger;
  if Request.QueryFields.IndexOfName('direction') >= 0 then
    Direction := Request.QueryFields.Values['direction'];
  if Request.QueryFields.IndexOfName('sort') >= 0 then
    Sort := Request.QueryFields.Values['sort'];
  if (Request.QueryFields.IndexOfName('search') >= 0) then
  begin
    if Request.GetFieldByName('x-api-mobile').Equals('device-mobile') then
      Search := Request.QueryFields.Values['search'].Replace('<!', '{',
        [rfReplaceAll]).Replace('!>', '}', [rfReplaceAll])
    else
      Search := Request.QueryFields.Values['search'];
  end;
  if Request.QueryFields.IndexOfName('join') >= 0 then
    Join := Request.QueryFields.Values['join'];
end;

procedure TWebModuleApi.ValidarAcesso(pValue: String);
Const
  TAG: String = 'Bearer ';

Var
  lToken: String;
  lResult: Boolean;
begin
  lResult := False;
  if pos(TAG, pValue) = 1 then
  begin
    lToken := stringReplace(pValue, TAG, '', []);
    lResult := TTokenWK.Validar(lToken);
  end;

  if Not lResult then
  begin
    TMessage.Create(EAcessoNegado, 'Token inválido.').SendMessage(Response);
  end;
end;

procedure TWebModuleApi.ValidarPermissoes(ResourceName, MetodName: string);

begin
 //  todo
end;

function TWebModuleApi.ValidarUsuarioPadrao
  (AParams: TDictionary<string, string>): Boolean;
const
  USER = 'server';
  PASSWORD = 'server2023';
var
  LUser, LPassword: String;
begin
  result := False;

  LUser := AParams.Items['user'];
  LPassword := AParams.Items['password'];

  if (LUser.ToUpper = USER) and (LPassword.ToUpper = PASSWORD) then
    result := True;
end;

initialization

RegisterClass(TWebModuleApi);

finalization

Web.WebReq.FreeWebModules;;

end.
