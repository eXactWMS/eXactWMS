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
  public
    Fconexao: TConnection;
    constructor Create();
    destructor Destroy; override;
  end;

implementation

{ TbasicDao }

constructor TBasicDao.Create;
begin
  Fconexao := TConnection.Create;
  Fconexao.Sender := Self;
end;

destructor TBasicDao.Destroy;
begin
  try
    FreeandNil(Fconexao);
  except
    on e: Exception do
    begin
      Tutil.Gravalog('[EROR 37] ' + e.Message)
    end;
  end;
  inherited;
end;

end.
