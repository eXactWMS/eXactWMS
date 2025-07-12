unit MService.RastroDAO;

interface

uses
  FireDAC.Comp.Client, RastroClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TRastroDao = class(TBasicDao)
  private
    
    

    ObjRastroDAO: TRastro;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pRastroId: Integer; pDescricao: String): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TRastroDao.Create;
begin
  ObjRastroDAO := TRastro.Create;
  inherited;
end;

function TRastroDao.Delete(pId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from RastroTipo where RastroId = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TRastroDao.Destroy;
begin
  
  ObjRastroDAO.Free;
  inherited;
end;

function TRastroDao.GetDescricao(pDescricao: String): TjSonArray;
var
  vSql: String;
begin
  try
    if pDescricao = '*' then
      pDescricao := '';
    vSql := 'Select * From RastroTipo Where Descricao Like ' +
      QuotedStr('%' + pDescricao + '%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TRastroDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    if pId = 0 then
      vSql := 'select * from RastroTipo'
    Else
      vSql := 'select * from RastroTipo where RastroId = ' + pId.ToString;
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      ObjRastroDAO.RastroId := FConexao.Query.FieldByName('RastroId').AsInteger;
      ObjRastroDAO.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
      Result.AddElement(tJson.ObjectToJsonObject(ObjRastroDAO));
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TRastroDao.InsertUpdate(pRastroId: Integer; pDescricao: String)
  : TjSonArray;
var
  vSql: String;
begin
  try
    if pRastroId = 0 then
      vSql := 'Insert Into RastroTipo (Descricao, Status) Values (' +
        QuotedStr(pDescricao) + ', 1) '
    Else
      vSql := 'Update RastroTipo ' + '    Set Descricao = ' +
        QuotedStr(pDescricao) + 'where RastroId    = ' + pRastroId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
