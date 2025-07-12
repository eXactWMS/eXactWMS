unit uSistemaControl;

interface

uses
  System.SysUtils, exactwmsservice.lib.connection;

type
  TSistemaControl = class
  private
    FConexao: TConnectionPool;

    class var FInstance: TSistemaControl;

  public
    constructor Create();
    destructor Destroy; override;

    class function GetInstance: TSistemaControl;

    property Conexao1: TConnectionPool read FConexao write FConexao;
  end;

implementation

{ TSistemaControl }

constructor TSistemaControl.Create();
begin
 // FConexao := TConnection.Create;
 // FConexao.Sender := Self;
end;

destructor TSistemaControl.Destroy;
begin
  //FConexao.Free;

  inherited;
end;

class function TSistemaControl.GetInstance: TSistemaControl;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TSistemaControl.Create();
  end;

  Result := Self.FInstance;
end;

end.
