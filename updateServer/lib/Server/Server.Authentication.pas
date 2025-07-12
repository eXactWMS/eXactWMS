unit Server.Authentication;

interface

uses
  System.SysUtils, Web.HTTPApp, System.JSON, Server.Token,
  Server.Utils.SectionVariables, Resources.usuarios;

type
  TAuthentication = class
  private
    FParameters: String;
    constructor Create(aNameResource, aNameFieldUser,
      aNameFieldPassword: String);
  public
    destructor Destroy; override;
    class function GetInstance(aNameResource, aNameFieldUser, aNameFieldPassword
      : String): TAuthentication;
    class function NewInstance: TObject; override;
    function Authenticate(Request: TJSONObject; Response: TWebResponse;
      var Usuario: TJSONObject): Boolean;
  end;

var
  Authentication: TAuthentication;

implementation

uses
  System.Rtti, Server.Connection, Server.Records;

{ TAuthentication }

function TAuthentication.Authenticate(Request: TJSONObject;
  Response: TWebResponse; var Usuario: TJSONObject): Boolean;
const
  SQL = 'SELECT * FROM %s WHERE %s';

var
  LAutParameters: TArray<String>;
  LJSONValue: TJSONValue;

  LTableName: String;
  LWhere: String;
  LUser: String;
  LIdUser: Integer;
  Password: String;
  Connection: TConnection;

  LToken: String;
  Fusuarios: Tusuarios;

begin
  try
    result := false;
    Connection := TConnection.Create;
    try
      LAutParameters := FParameters.Split([';']);
      LJSONValue := TJSONObject.ParseJSONValue(Request.ToJSON, true, true);
      if not Assigned(LJSONValue) then
        raise Exception.Create('Invalid request ' + Request.ToJSON);

      LToken := '';
      LJSONValue.TryGetValue('token', LToken);
      if LToken <> '' then
      begin
        if not TTokenWK.Validar(LToken) then
          raise Exception.Create('Token invalido');

        LWhere := LAutParameters[3] + ' = ' +
          inttostr(FTSectionVariables.userid);

      end
      else
      begin

        LUser := '';
        LJSONValue.TryGetValue('user', LUser);
        if LUser = '' then
          raise Exception.Create('User not found in json request -> ' +
            LJSONValue.ToString);
{$IFDEF LINUX}
        Writeln('Login request by user : ' + LUser);
{$ENDIF}
        Password := '';
        LJSONValue.TryGetValue('password', Password);

        if Password = '' then
          raise Exception.Create('Password not found in json request -> ' +
            LJSONValue.ToString);

        LWhere := LAutParameters[1] + ' = ' + QuotedStr(LUser) + ' AND ' +
          LAutParameters[2] + ' = ' + QuotedStr(Password);
      end;
      LTableName := LAutParameters[0];
      Connection.Query.SQL.Add(Format(SQL, [LTableName, LWhere]));
      Connection.Query.Open;
      Connection.Query.Last;

      result := Connection.Query.RecordCount > 0;
      if result then
      begin

        Fusuarios := Tusuarios.Create;

        try


          Fusuarios.Get(nil, 1, 50, EmptyStr, EmptyStr, EmptyStr,
            Connection.Query.FieldByName('USUARIOID').AsString, EmptyStr, nil);

        finally

          FreeAndNil(Fusuarios);

        end;
      end
      else
        Writeln('Login error ' + LUser + #13#10 +
          'Msg: User or password incorrect');
    except
      on e: Exception do
      begin
        Writeln('Login error ' + LUser + #13#10 + 'Msg:  ' + e.Message);

      end;

    end;
  finally
    Connection.Free;
  end;

end;

constructor TAuthentication.Create(aNameResource, aNameFieldUser,
  aNameFieldPassword: String);
begin
  FParameters := aNameResource + ';' + aNameFieldUser + ';' +
    aNameFieldPassword;
end;

destructor TAuthentication.Destroy;
begin

  inherited;
end;

class function TAuthentication.GetInstance(aNameResource, aNameFieldUser,
  aNameFieldPassword: String): TAuthentication;
begin
  result := self.Create(aNameResource, aNameFieldUser, aNameFieldPassword);
end;

class function TAuthentication.NewInstance: TObject;
begin
  if not Assigned(Authentication) then
    Authentication := TAuthentication(inherited NewInstance);
  Authentication.FParameters := 'usuarios;login;senha;usuarioid';
  result := Authentication;
end;

end.
