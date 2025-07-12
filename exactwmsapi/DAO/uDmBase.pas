unit uDmBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase;

type
  TDmBase = class(TDataModule)
    FdBase: TConnection;
    QryBase: TFDQuery;
    RESTClientCep: TRESTClient;
    RESTRequestCep: TRESTRequest;
    RESTResponseCep: TRESTResponse;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmBase: TDmBase;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
