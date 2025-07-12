unit MService.ProdutoControleDAO;

interface

uses
  Dialogs, FireDAC.Comp.Client, ProdutoControleClass, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.Json;

type
  TProdutoControleDao = class
  private
    
    ObjProdutoControleDAO : TProdutoControle;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pProdutoControleId : Integer; pDescricao : String ): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao : String) : tJsonArray;
    Function Delete(pId : Integer) : Boolean;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TProdutoControleDao.Create;
begin
  ObjProdutoControleDAO := TProdutoControle.Create;
  inherited;
end;

function TProdutoControleDao.Delete(pId: Integer): Boolean;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := False;
  try
    VQry := FConexao.CriarQuery();
    vSql := 'Delete from ProdutoControle where IdControle = '+pId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally
   
  end;
end;

destructor TProdutoControleDao.Destroy;
begin
  ObjProdutoControleDAO.Free;
  inherited;
end;

function TProdutoControleDao.GetDescricao(pDescricao : String): tJsonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();
  try
    if pDescricao = '*' then pDescricao := '';
    vSql := 'Select * From ProdutoControle Where Descricao Like '+QuotedStr('%'+pDescricao+'%');
    VQry.Open(vSql);
    try
      Result := VQry.toJsonArray;
    finally
      VQry.Close;
    end;
  finally
   
  end;
end;

function TProdutoControleDao.GetId(pId: Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := TJsonArray.Create;
  VQry := FConexao.CriarQuery();
  try
    if pId = 0 then
       vSql := 'select * from ProdutoControle'
    Else vSql := 'select * from ProdutoControle where IdControle = '+pId.ToString;
    VQry.Open(vSql);
    while Not vQry.Eof do Begin
      ObjProdutoControleDAO.IdControle := vQry.FieldByName('IdControle').AsInteger;
      ObjProdutoControleDAO.Descricao  := vQry.FieldByName('Descricao').AsString;
      Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoControleDAO));
      vQry.Next;
    End;
    VQry.Close;
  finally
   
  end;
end;

function TProdutoControleDao.InsertUpdate(pProdutoControleId : Integer; pDescricao : String): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();

  try
    if pProdutoControleId = 0 then
       vSql := 'Insert Into ProdutoControle (Descricao, Status) Values ('+
               QuotedStr(pDescricao)+', 1) '
    Else
       vSql := 'Update ProdutoControle '+
               '    Set Descricao = '+QuotedStr(pDescricao)+
               'where IdControle = '+pProdutoControleId.ToString;
    VQry.ExecSQL(vSql);
    try
      Result := VQry.toJsonArray;
    finally
      VQry.Close;
    end;
  finally
   
  end;
end;

end.
