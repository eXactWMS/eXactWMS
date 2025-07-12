unit Providers.Connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  exactwmsservice.lib.connection,
  IniFiles,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,
  FireDAC.Comp.UI;

type
  TProvidersConnection = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProvidersConnection: TProvidersConnection;

implementation

uses
  exactwmsservice.lib.utils;
{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

end.
