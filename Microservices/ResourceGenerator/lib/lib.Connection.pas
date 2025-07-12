unit lib.Connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  FireDAC.Comp.UI,
  FireDAC.Stan.Option,
  FireDAC.Stan.Pool;

type
  TConnection = class
  private
    FQuery: TFDQuery;
    FTable: TFDTable;
    FDB: TFDConnection;
  public
    property DB: TFDConnection read FDB write FDB;
    property Query: TFDQuery read FQuery write FQuery;
    property Table: TFDTable read FTable write FTable;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Vcl.Dialogs;

{ TConnection }

constructor TConnection.Create;
begin
  DB := TFDConnection.Create(nil);

  DB.ConnectionDefName := 'IMPDB';
  DB.Params.AddPair('CharacterSet', 'UTF8');
  try
    DB.Connected := True;
    Query := TFDQuery.Create(nil);
    FTable := TFDTable.Create(nil);
    Query.Connection := DB;
    FTable.Connection := DB;
  except
      on e:exception do
      begin
        // raise Exception.Create('Imposivel conectar no banco de dados ->  '+e.Message);
      end;
  end;

end;

destructor TConnection.Destroy;
begin
  Query.Close;
  Query.Free;
  DB.Connected := False;
  DB.Free;
  inherited;
end;

end.
