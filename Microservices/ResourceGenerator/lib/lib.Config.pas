unit lib.Config;

interface

uses
  System.IniFiles,
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Types,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Phys.PGDef,
   FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.PG,
   FireDAC.Phys.MSSQL,
  FireDAC.Comp.UI,

  Data.DB, FireDAC.Comp.DataSet,

  System.Classes,
  System.IOUtils, FireDAC.Phys.FB;

const
  IniName = 'Config.ini';

type
  TServerConfig = class
  public

  private
    FDManager: TFDManager;

  public
    class function GetInstance: TServerConfig;
    class procedure ConfigDB;
  end;

var
  TmpManeger: TFDManager;

implementation

uses
  Vcl.Dialogs;

{ TServer }

class function TServerConfig.GetInstance: TServerConfig;
begin

end;

class procedure TServerConfig.ConfigDB;
var
  IniFile: TIniFile;
  i: Integer;
  Database: string;
  Server: string;
  UserName: string;
  Password: string;
  Params: TStrings;
  Port: Integer;
  IniPath: string;
  Driver: string;
  Fdriver: TFDPhysFBDriverLink;

begin
  Fdriver := TFDPhysFBDriverLink.Create(Nil);
  if FileExists(ExtractFilePath(GetModuleName(HInstance)) + 'libpq.dll') then

    Fdriver.VendorLib := ExtractFilePath(GetModuleName(HInstance)) +
      'libpq.dll';
{$IFDEF WINDOWS}
  Fdriver.VendorLib := ExtractFilePath(GetModuleName(HInstance)) +
    'libpq.dll';
{$ENDIF}
{$IFDEF LINUX}
  Fdriver.VendorLib := ExtractFilePath(GetModuleName(HInstance)) +
    'libpq.so';
{$ENDIF}
  IniPath := ExtractFilePath(GetModuleName(HInstance)) + IniName;
  if not assigned(TmpManeger) then
    TmpManeger := TFDManager.Create(nil)
  else
  begin

    for i := 0 to TmpManeger.ConnectionCount -1 do
    begin
      TmpManeger.Connections[i].Close;
    end;

    TmpManeger.CloseConnectionDef('IMPDB');

    TmpManeger.DeleteConnectionDef('IMPDB');
  end;
  IniFile := TIniFile.Create(IniPath);

  // TmpManeger.DeleteConnectionDef('IMPDB');

  try
    Database := IniFile.ReadString('Config', 'Database', '');
    Server := IniFile.ReadString('Config', 'Server', '');
    Driver := IniFile.ReadString('Config', 'driver', 'MsSql');
    Database := IniFile.ReadString('Config', 'Database', '');
    Server := IniFile.ReadString('Config', 'Server', '');
    UserName := IniFile.ReadString('Config', 'User_Name', '');
    Password := IniFile.ReadString('Config', 'Password', '');
    Params := TStringList.Create;
    if Driver = 'FIREBIRD' then
    Begin
      Port := StrToInt(IniFile.ReadString('Config', 'Port', '3050'));
      Params.AddPair('DriverID', 'FB');
      Params.AddPair('Server', Server);
      Params.AddPair('Database', Database);
      Params.AddPair('User_Name', UserName);
      Params.AddPair('Password', Password);
      Params.AddPair('Port', Port.ToString);
      Params.AddPair('CharacterSet', 'UTF8');

      Params.AddPair('Pooled', 'True');
      TmpManeger.AddConnectionDef('IMPDB', 'FB', Params);
    End
    else if Driver = 'POSTGREES' then
    Begin

      Port := StrToInt(IniFile.ReadString('Config', 'Port', '5432'));
      Params := TStringList.Create;
      Params.AddPair('DriverID', 'PG');
      Params.AddPair('Server', Server);
      Params.AddPair('Database', Database);
      Params.AddPair('User_Name', UserName);
      Params.AddPair('Password', Password);
      Params.AddPair('Port', Port.ToString);
    //  Params.AddPair('Pooled', 'True');
      TmpManeger.AddConnectionDef('IMPDB', 'PG', Params);
    End;

    if Driver = 'MsSql' then
    Begin
    //  Port := StrToInt(IniFile.ReadString('Config', 'Port', '3050'));
      Params.AddPair('DriverID', 'MsSql');
      Params.AddPair('Server', Server);
      Params.AddPair('Database', Database);
      Params.AddPair('User_Name', UserName);
      Params.AddPair('Password', Password);
      Params.AddPair('Port', Port.ToString);
      Params.AddPair('CharacterSet', 'UTF8');

      Params.AddPair('Pooled', 'True');
      TmpManeger.AddConnectionDef('IMPDB', 'MsSql', Params);
    End ;

    TmpManeger.Active := True;
  finally
    FreeAndNil(IniFile);

  end;
end;

end.

