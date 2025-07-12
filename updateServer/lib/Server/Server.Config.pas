unit Server.Config;

interface

uses
  System.IniFiles,
  Server.Constants,
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Types,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
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
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.PG,
  FireDAC.Comp.UI,
  FireDAC.Phys.FB,

  Data.DB,
  FireDAC.Comp.DataSet,
  System.Classes,
  System.IOUtils,
  Server.Connection,
  Server.Utils.Criptografia;

type
  TServerConfig = class
  private
    FDManager: TFDManager;
    procedure ConfigDB;
    class var FInstance: TServerConfig;
  public
    class function GetInstance: TServerConfig;
  end;

implementation

{ TServer }

class function TServerConfig.GetInstance: TServerConfig;
begin
  if FInstance = nil then
  begin
    FInstance := TServerConfig.Create;
    FInstance.ConfigDB;
  end;
  Result := FInstance;
end;

procedure TServerConfig.ConfigDB;
var
  IniFile: TIniFile;
  Database: string;
  Server: string;
  UserName: string;
  Password: string;
  Params: TStrings;
  Driver: string;
  Spath: string;
  Port: integer;

begin

  Spath := ExtractFilePath(GetModuleName(HInstance)) + cConfigFileName;
  {$IFDEF LINUX}
    if not FileExists(Spath) then
      Writeln('<<FATAL ERRO>> Config file  not found in ' + Spath)
    else
      Writeln('Sucessefull to find  config file in ' + Spath);
  {$ENDIF}
  IniFile := TIniFile.Create(Spath);
  try
    Server := IniFile.ReadString('Conexao', 'Server', '');
    Driver := IniFile.ReadString('Config', 'driver', ' MsSql');
    Database := IniFile.ReadString('Conexao', 'Database', '');
    UserName := IniFile.ReadString('Conexao', 'User_Name', '');
    Password := IniFile.ReadString('Conexao', 'Password', '');
    //Port := IniFile.ReadInteger('Conexao', 'port', 5432);
    Params := TStringList.Create;
    Params.AddPair('Server', Server);
    Params.AddPair('Database', Database);
    Params.AddPair('User_Name', UserName);
    Params.AddPair('Password', Password);
    Params.AddPair('Port', Port.ToString);
   // Params.AddPair('CharacterSet','iso-8859-1');
    Params.AddPair('Pooled', 'True');
    if Driver = 'PG' then
    begin
      Params.AddPair('DriverID', 'PG');
      FInstance.FDManager := TFDManager.Create(nil);
      TServerConfig.GetInstance;
      FInstance.FDManager.AddConnectionDef(cConnectionDefName, 'PG', Params);

    end
    else
    begin
      Params.AddPair('DriverID', 'MsSql');
      FInstance.FDManager := TFDManager.Create(nil);
      FInstance.FDManager.AddConnectionDef(cConnectionDefName, 'MsSql', Params);

    end;

  finally
    FInstance.FDManager.SilentMode := True;
    IniFile.Free;
  end;
end;

end.
