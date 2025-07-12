{
  ____________________________________________________________________________

  █░█░█ █ █░░ █▀ █▀█ █▄░█   █░░ █░█ ▀█
  ▀▄▀▄▀ █ █▄▄ ▄█ █▄█ █░▀█   █▄▄ █▄█ █▄ ©  2023
  Map json Body class
  ______________________________________________________________________________
}
unit Swager.Json.Body;

interface

uses
  Swager.Json.DTO,
  sysutils,
  Server.Constants,
  classes;


{$M+}

type

  TcontactDTO = class
  private
    Fname: string;
    Femail: string;
    Furl: string;
  published
    property name: string read Fname write Fname;
    property email: string read Femail write Femail;
    property url: string read Furl write Furl;
  public
    constructor Create;

  end;

  TlicenseDTO = class
  private

    Fname: string;
    Furl: string;
  published
    property name: string read Fname write Fname;
    property url: string read Furl write Furl;
  public
    constructor Create;
  end;

  TinfoDTO = class
  private
    Fversion: string;
    Ftitle: string;
    Fdescription: string;
    FtermsOfService: string;
    Fcontact: TcontactDTO;
    Flicense: TlicenseDTO;
  published
    property version: string read Fversion write Fversion;
    property title: string read Ftitle write Ftitle;
    property description: string read Fdescription write Fdescription;
    property termsOfService: string read FtermsOfService write FtermsOfService;
    property contact: TcontactDTO read Fcontact write Fcontact;
    property license: TlicenseDTO read Flicense write Flicense;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TBasicAuthDTO = class
  private
    Ftype: string;
  published

    property &type: string read Ftype write Ftype;
  public
    constructor Create;
  end;

  TsecurityDefinitionsDTO = class
  private
    FBasicAuth: TBasicAuthDTO;

  published
    property BasicAuth: TBasicAuthDTO read FBasicAuth write FBasicAuth;

  public
    constructor Create;
  end;

  TBearerAuthDTO = class
  private
    Ftype: string;
    Fscheme: string;
    FbearerFormat: string;
  published
    property &type: string read Ftype write Ftype;
    property scheme: string read Fscheme write Fscheme;
    property bearerFormat: string read FbearerFormat write FbearerFormat;
  public
    constructor Create;
  end;

  TsecurityDTO = class
  private
    FBearerAuth: string;

  published
    property BearerAuth: string read FBearerAuth write FBearerAuth;
  public

  end;

  TcomponentsDTO = class
    FsecurityDefinitions: TsecurityDefinitionsDTO;
    FBearerAuth: TBearerAuthDTO;
    Fsecurity: TsecurityDTO;
  published
    property securityDefinitions: TsecurityDefinitionsDTO
      read FsecurityDefinitions write FsecurityDefinitions;

    property BearerAuth: TBearerAuthDTO read FBearerAuth write FBearerAuth;

    property security: TsecurityDTO read Fsecurity write Fsecurity;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  Tpaths = class
  private

  end;

  Tdefinitions = class

  end;

  TRootDTO = class(TJsonDTO)
  private
    Fswagger: string;
    Finfo: TinfoDTO;
    Fhost: string;
    FbasePath: string;
    Fschemes: TArray<string>;
    Fcomponents: TcomponentsDTO;
    Fconsumes: TArray<string>;
    Fproduces: TArray<string>;
    Fpaths: Tpaths;
    Fdefinitions: Tdefinitions;
  published
    property swagger: string read Fswagger write Fswagger;
    property info: TinfoDTO read Finfo write Finfo;
    property host: string read Fhost write Fhost;
    property basePath: string read FbasePath write FbasePath;
    property schemes: TArray<string> read Fschemes write Fschemes;
    property components: TcomponentsDTO read Fcomponents write Fcomponents;
    property consumes: TArray<string> read Fconsumes write Fconsumes;
    property produces: TArray<string> read Fproduces write Fproduces;
    property paths: Tpaths read Fpaths write Fpaths;
    property definitions: Tdefinitions read Fdefinitions write Fdefinitions;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }
constructor TRootDTO.Create;
begin
  inherited;
  Fswagger := '2.0';
  Finfo := TinfoDTO.Create;
  Fcomponents := TcomponentsDTO.Create;
  Fpaths := Tpaths.Create;;
  Fdefinitions := Tdefinitions.Create;
  SetLength(Fconsumes, 1);
  Fconsumes[0] := 'application/json';

  SetLength(Fproduces, 1);
  Fproduces[0] := 'application/json';
  Fhost:=cUrlApi;
  FbasePath:= '/v1';
  SetLength(Fschemes,1);

  Fschemes[0]:= 'https';

end;

destructor TRootDTO.Destroy;
begin

  inherited;
end;

{ TcomponentsDTO }

constructor TcomponentsDTO.Create;
begin
  inherited;
  FsecurityDefinitions := TsecurityDefinitionsDTO.Create;
  FBearerAuth := TBearerAuthDTO.Create;
  Fsecurity := TsecurityDTO.Create;

end;

destructor TcomponentsDTO.Destroy;
begin
  FreeAndNil(FsecurityDefinitions);
  FreeAndNil(FBearerAuth);
  FreeAndNil(Fsecurity);
  inherited;
end;

{ TinfoDTO }

constructor TinfoDTO.Create;
begin
  inherited;
  Fversion := 'v1';
  Ftitle := 'Update server 1.2';
  Fdescription := 'Documentaçao inicial do projeto';
  FtermsOfService := 'http://www.apache.org//licenses/LICENSE-2.0.txt';
  Fcontact := TcontactDTO.Create;
  Flicense := TlicenseDTO.Create;

end;

destructor TinfoDTO.Destroy;
begin

  FreeAndNil(Fcontact);
  FreeAndNil(Flicense);

  inherited;
end;

{ TcontactDTO }

constructor TcontactDTO.Create;
begin
  Fname := 'wilson luz';
  Femail := '"wilson.rodriogues@wkconsultoria.com.br';
  Furl := 'https://wkconsultoria.com.br';
end;

{ TlicenseDTO }

constructor TlicenseDTO.Create;
begin
  Fname := 'Apache License - Version 2.0, January 2004';
  Furl := 'http://www.apache.org/licenses/LICENSE-2.0';
end;

{ TsecurityDefinitionsDTO }

constructor TsecurityDefinitionsDTO.Create;
begin
  FBasicAuth := TBasicAuthDTO.Create;
end;

{ TBasicAuthDTO }

constructor TBasicAuthDTO.Create;
begin
  Ftype := 'basic';
end;

{ TBearerAuthDTO }

constructor TBearerAuthDTO.Create;
begin
  Ftype := 'http';
  Fscheme := 'bearer';
  FbearerFormat := 'JWT';
end;

end.
