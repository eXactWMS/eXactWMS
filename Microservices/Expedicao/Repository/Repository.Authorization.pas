unit Repository.Authorization;

interface

uses
  System.Classes,
  Server.Attributes,
 Server.Authentication,
 Server.Interfaces.Authentication,

  json,
  System.SysUtils,
 Server.Connection,
  REST.json,
  Server.Token,
  JOSE.Core.JWT,
  JOSE.Core.JWA,
  JOSE.Core.Builder,
  JOSE.Core.JWK,
  JOSE.Types.Bytes,
  System.NetEncoding,
  server.Util,
  System.DateUtils,
  System.Generics.Collections,
  Server.MessageList,
  Web.HTTPApp,
  Server.Message,
  System.Rtti,
 server.ResourceBaseClass;

type
  [Resource('authorization')]

  Tauthorization = class(Tpersistent, iAuthentication)
  private
    LUsuario: TJSONObject;
    LUserCamada: TJSONObject;
    LIdEmpresa: string;
    LidRevenda:integer;
    LidPerfil: Integer;
    LCamada: Integer;
    Lidcolaborador: Integer;
    Lnome: string;
    LuserId: Integer;
    function ObterToken(): String;
    function ObterTokenAsJsonValue(): TJsonValue;
    function Authenticate(Request: TWebRequest; Response: TWebResponse)
      : Boolean;
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    [DBField('user', True, True, True, notnull)]
    user: String;
    [DBField('password', True, True, True, notnull)]
    password: String;
    [Post]
    procedure Post(Response: TWebResponse; Dados: TJSONObject;
      Conn: TConnection = nil);
  end;

implementation

{ Tauthorization }
function Tauthorization.ObterTokenAsJsonValue(): TJsonValue;
Var
  lObj: TJSONObject;
begin
  lObj := TJSONObject.Create;
  lObj.AddPair('token', TJSONString.Create(ObterToken()));
  Result := lObj;
end;

function Tauthorization.Authenticate(Request: TWebRequest;
  Response: TWebResponse): Boolean;
begin

end;

function Tauthorization.ObterToken(): String;
Var
  LToken: TJWT;

  LArray: TJSONArray;

begin
  LToken := Nil;
  LIdempresa := '';
  LToken := TJWT.Create;
  LidPerfil := 0;
  LCamada := 0;
  Lidcolaborador := 0;
  Try
    LUsuario.TryGetValue('id', LuserId);
    // impedir que acentos malditos quebrem o base64 no token
    LUsuario.TryGetValue('nome', Lnome);
    Lnome := TWKUtil.StripUnwantedChar(Lnome);

    LuserId := 0;
    LUsuario.TryGetValue('id', LuserId);
    LToken.Claims.IssuedAt := (IncHour (now, 6));
    LToken.Claims.SetClaimOfType<Integer>('userid', LuserId);
    LToken.Claims.Subject := Lnome;

    Result := TJOSE.SHA256CompactToken(TTokenWK.ObterChave, LToken);
  Finally
    if assigned(LToken) then
      LToken.Free;
  End;
end;

procedure Tauthorization.Post(Response: TWebResponse; Dados: TJSONObject;
  Conn: TConnection);
var
  LAuthentication: TAuthentication;
  LMsg: TMessageType;


begin
  LAuthentication := (TAuthentication.NewInstance as TAuthentication);
  if LAuthentication.Authenticate(Dados, Response, LUsuario) then
  begin
    LMsg := IAutorizado;
    LMsg.Content := TJSONObject(ObterTokenAsJsonValue());

    if assigned(LUsuario) then
    begin

      LMsg.Content.AddPair('usuario', LUsuario);
    end;

    TMessage.Create(LMsg).SendMessage(Response);
  end
  else
    TMessage.Create(ENaoAutorizado).SendMessage(Response);
end;

function Tauthorization.QueryInterface(const IID: TGUID; out Obj): HResult;
begin

end;

function Tauthorization._AddRef: Integer;
begin

end;

function Tauthorization._Release: Integer;
begin

end;

initialization

RegisterClass(Tauthorization);

end.
