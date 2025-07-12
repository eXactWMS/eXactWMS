unit exactwmsservice.dao.base;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  DataSet.Serialize,
  System.JSON,
  REST.JSON,
  exactwmsservice.lib.utils,
  exactwmsservice.lib.connection;

type
  TBasicDao = class
  private
    FConnection: TFDConnection;
  Protected
    property Connection: TFDConnection read FConnection;
  public
//    Fconexao: TConnection;
    constructor Create();
    destructor Destroy; override;
  end;

implementation

{ TbasicDao }

constructor TBasicDao.Create;
begin
  FConnection := GlobalConnectionPool.GetConnection;
  //Fconexao := TConnection.Create(0);
  //Fconexao.Sender := Self;
end;

destructor TBasicDao.Destroy;
Var ConnName : String;
begin
  if Assigned(FConnection) then
    GlobalConnectionPool.ReleaseConnection(FConnection);
  inherited Destroy;


{  try
    ConnName := FConexao.db.ConnectionDefName;
    If FConexao.db.Connected then
       FConexao.DB.Close;
    FreeandNil(Fconexao);
  except
    on e: Exception do
    begin
      Tutil.Gravalog('[EROR 37] ' + e.Message)
    end;
  end;
  inherited;
}end;

end.
