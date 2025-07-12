unit tester.service.http;

interface

uses

  IdComponent,

  System.SysUtils,
  System.Variants,
  System.Classes,
  IdHTTP,
  System.JSON,
  idCookieManager,
  IdZLibCompressorBase,

  IdIntercept,
  IdIOHandler,

  IdHashMessageDigest,
  REST.Types,
  REST.Client,
  IdCompressorZLib,
  System.ZLib,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Authenticator.Basic

    ;

type
  TbeforeExecute = TNotifyEvent;

type
  TExecPath = class(Tthread)
  private

    FloginUser: String;
    FreturnCod: Integer;
    Findice: Integer;
    FbeforeExecute: TbeforeExecute;
    FMensageReturneD: string;
    Flogedin: Boolean;
    FFinalized: Boolean;
    FRetorno: string;
    FLurl: string;

    ngrestclient: TRESTClient;
    ngrequest: TRESTRequest;
    ngrestrespose: TRESTResponse;
    ngoautg: THTTPBasicAuthenticator;
    procedure sincronizedproc;
    procedure setupClient;
    procedure ngrequestAfterExecute(Sender: TCustomRESTRequest);

  public
    procedure execute_new;
    procedure execute; override;
    function decompress(value: TStream): TStream;

    property Lurl: string read FLurl write FLurl;
    property returnCod: Integer read FreturnCod write FreturnCod;
    property Retorno: string read FRetorno write FRetorno;
    property Finalized: Boolean read FFinalized write FFinalized;
    property Logedin: Boolean read Flogedin write Flogedin;
    property OnBeforeExecute: TbeforeExecute Read FbeforeExecute
      write FbeforeExecute;

    property MensageReturned: string Read FMensageReturneD
      write FMensageReturneD;
  end;

type
  TupdateApp = class(Tthread)
  private
  public
    procedure execute; override;
  end;

type
  Tdownloader = class
  private
    Furl: string;
    FlocalPath: string;

  public
    procedure execute;
    property Url: string read Furl write Furl;
    property LocalPaht: string read FlocalPath write FlocalPath;

  end;

const
  _rest_host = 'http://localhost:8200/';

implementation

function TExecPath.decompress(value: TStream): TStream;
begin

  value.Position := 0;
  result := TStringStream.Create;
  ZDecompressStream(value, result);

end;

procedure TExecPath.execute;
var
  sGet: string;
  myHttpCom: TIdHTTP;
  Cookie: TidCookieManager;
  idmd5: TIdHashMessageDigest5;
  aresponse: TStream;
begin
  inherited;

  idmd5 := TIdHashMessageDigest5.Create;
  try
    FFinalized := false;
    myHttpCom := TIdHTTP.Create(nil);
    with myHttpCom do
    begin
      AllowCookies := true;

      ProxyParams.ProxyPort := 0;
      Request.ContentLength := -1;
      Request.ContentRangeEnd := 0;
      Request.ContentRangeStart := 0;
      ProtocolVersion := pv1_1;
      Request.ContentType := 'application/x-www-form-urlencoded';
      Request.ContentEncoding := 'UTF-8'; // in test
      Request.CharSet := 'UTF-8'; // //in test
      Request.AcceptCharSet := 'UTF-8';

      response.CharSet := 'UTF-8'; // in test
      response.ContentEncoding := 'UTF-8'; // in test

      Request.AcceptEncoding := 'deflate';
      Request.Accept :=
        'image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/xaml+xml, application/x-ms-xbap, application/x-ms-application, */*';
      Request.BasicAuthentication := true;

      HTTPOptions := [hoForceEncodeParams];
      HandleRedirects := true;
      Request.Referer := '';
      Request.Host := _rest_host;
      Cookie := TidCookieManager.Create(nil);
      CookieManager := Cookie;

    end;
    try
      aresponse := TStringStream.Create('');

      myHttpCom.Get(_rest_host + Lurl,aresponse);
      {try
        aresponse := decompress(aresponse);
        sGet:=TStringStream(aresponse).DataString;
      except
        sGet := TStringStream(aresponse).DataString;
      end;}
      sGet := TStringStream(aresponse).DataString;
      FRetorno := sGet;
      returnCod := 200;

    except
      on e: EIdHTTPProtocolException do
      begin
        FreturnCod := 500;
        FRetorno := e.Message;
        exit;
      end;

      on e: exception do
      begin
        FreturnCod := 5001;
        FRetorno := e.Message;
      end;

    end;
  finally
    FreeAndNil(myHttpCom);
    try
      if Assigned(FbeforeExecute) then
        FbeforeExecute(Nil);
    except
    end;
    FFinalized := true;

  end;
end;

procedure TExecPath.ngrequestAfterExecute(Sender: TCustomRESTRequest);
begin
  // DecodeRestResponse(TRESTResponse(Sender.response));
end;

{ ------------------------------------------------------------------------------ }
procedure TExecPath.setupClient;
begin
  ngoautg := THTTPBasicAuthenticator.Create(Nil);

  ngrestclient := TRESTClient.Create(Nil);
  ngrestclient.Authenticator := ngoautg;
  ngrestclient.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  ngrestclient.AcceptCharSet := 'utf-8, *;q=0.8';
  ngrestclient.AcceptEncoding := 'gzip';
  ngrestclient.BaseURL := 'http://localhost:6466';
  ngrestclient.ContentType := 'text/javascript';
  ngrestclient.UserAgent := 'nagram RESTClient/1.0';
  ngrestrespose := TRESTResponse.Create(Nil);
  ngrestrespose.ContentType := 'application/json';
  ngrequest := TRESTRequest.Create(Nil);
  ngrequest.AcceptEncoding := 'gzip,deflate';

  ngrequest.OnAfterExecute := ngrequestAfterExecute;

  ngrequest.Client := ngrestclient;
  ngrequest.Method := rmGET;

end;

{ ------------------------------------------------------------------------------ }
procedure TExecPath.execute_new;
var
  sGet: string;
begin
  inherited;
  try
    setupClient();
    try
      ngrequest.execute;
      sGet := ngrestrespose.Content;

    except
      on e: exception do
      begin
        Flogedin := false;
        if pos('forbidden', AnsiLowerCase(e.Message)) > 0 then
        begin
          FMensageReturneD := 'Servidor recusou a conexão,Atualize a versão';
        end
        else
        begin
          FMensageReturneD := 'Erro ao acessar servidor : ' + e.Message;
        end;
        sGet := FMensageReturneD;
      end;
    end;
  finally
    FFinalized := true;
    FreeAndNil(ngrestclient);
    FreeAndNil(ngrequest);
    FreeAndNil(ngrestrespose);
  end;
end;

procedure TExecPath.sincronizedproc;
begin
  // *//
end;

{ TupdateApp }

procedure TupdateApp.execute;
var
  http: TIdHTTP;
  tituloBalao: String;
  sGet: string;
  ojson: TJSONObject;
  oresult: TJSONValue;
  WebHash: string;
  LocalHash: string;
  NovaVersao: string;
  bat: string;
begin
  inherited;
  // URL_UPDATE_HASH_APP, MD5Checksum(ParamStr(0))
  { http := TIdHTTP.Create(nil);
    try

    http.Request.BasicAuthentication := true;
    http.Request.Username :=_rest_user;
    http.Request.Password := _rest_pass;
    //  LocalHash := MD5Checksum(ParamStr(0));
    sGet := http.Get(URL_UPDATE_HASH_APP + '/' + LocalHash);

    ojson := TJSONObject.ParseJSONValue(sGet) as TJSONObject;
    if Assigned(ojson) then
    begin
    oresult := (ojson.GetValue('result') as TJSONArray)
    .Items[0].FindValue('hash') as TJSONValue;
    WebHash := oresult.Value;
    if (WebHash <> '') and (uppercase(WebHash) <> uppercase(LocalHash)) then
    begin
    bat := ExtractFilePath(ParamStr(0)) + 'siga2.update.bat';
    NovaVersao := ParamStr(0) + '.new';
    with Tdownloader.Create do
    begin
    Url := URL_UPGRADE_EXE;
    FlocalPath := NovaVersao;
    execute;
    free;
    end;
    if FileExists(NovaVersao) then
    begin
    if FileExists(ExtractFileName(ParamStr(0)) + '.old"') then
    DeleteFile(ExtractFileName(ParamStr(0)) + '.old"');
    with TStringList.Create do
    try
    Add('@echo off');
    Add('cd ' + ExtractFilePath(ParamStr(0)));

    Add('rename "' + ExtractFileName(ParamStr(0)) + '" "' +
    ExtractFileName(ParamStr(0)) + '.old"');
    Add('rename "' + ExtractFileName(NovaVersao) + '" "' +
    ExtractFileName(ParamStr(0)) + '"');

    Add('del ' + ExtractFileName(bat));
    SaveToFile(bat);
    ShellExecute(0, 'open', PChar(bat), nil, nil, SW_SHOWNORMAL);
    finally
    free;
    end;

    end;
    end;
    end;

    finally
    FreeAndNil(http);
    end; }
end;

{ Tdownloader }

procedure Tdownloader.execute;

var
  Stream: TMemoryStream;
  IdHTTP: TIdHTTP;
  // Baixador: TThreadDownload;

begin
  Stream := TMemoryStream.Create;
  IdHTTP := TIdHTTP.Create(Nil);
  try
    try
      Stream := TMemoryStream.Create;
      IdHTTP.HandleRedirects := true;
      IdHTTP.AllowCookies := true;
      IdHTTP.ConnectTimeout := 2 * 60 * 1000;
      with IdHTTP do
      begin
        Request.UserAgent := 'Mozilla/4.0';
        Request.Connection := 'Keep-Alive';
        Request.ProxyConnection := 'Keep-Alive';
        Request.Referer := 'http://www.google.com';
        Request.CacheControl := 'no-cache'; // this force use no-cache
      end;

      IdHTTP.Get(Furl, Stream);

      if FileExists(FlocalPath) then
        DeleteFile(FlocalPath);
      Stream.SaveToFile(FlocalPath);

    except
      on e: exception do
      begin

      end;
    end;
  finally
    Stream.free;
    IdHTTP.Disconnect;
    FreeAndNil(IdHTTP);
  end;
end;

end.
