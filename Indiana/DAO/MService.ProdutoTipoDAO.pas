unit MService.ProdutoTipoDAO;

interface

uses
  FireDAC.Comp.Client, ProdutoTipoClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TProdutoTipoDao = class(TBasicDao)
  private

    

    ObjProdutoTipoDAO: TProdutoTipo;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pProdutoTipoId: Integer; pDescricao, pSigla : String; pStatus : Integer) : TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TProdutoTipoDao.Create;
begin
  ObjProdutoTipoDAO := TProdutoTipo.Create;
  inherited;
end;

function TProdutoTipoDao.Delete(pId: Integer): Boolean;
var vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from ProdutoTipo where Id = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TProdutoTipoDao.Destroy;
begin
  
  ObjProdutoTipoDAO.Free;
  inherited;
end;

function TProdutoTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
begin
  try
    if pDescricao = '*' then
      pDescricao := '';
    vSql := 'Select * From ProdutoTipo Where Descricao Like ' +
      QuotedStr('%' + pDescricao + '%');
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TProdutoTipoDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
begin
  Result := TjSonArray.Create;
  try
    if pId = 0 then
      vSql := 'select * from ProdutoTipo'
    Else
      vSql := 'select * from ProdutoTipo where Id = ' + pId.ToString;
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
{
     while Not VQry.Eof do
     Begin
       ObjProdutoTipoDAO.Id := VQry.FieldByName('Id').AsInteger;
       ObjProdutoTipoDAO.Descricao := VQry.FieldByName('Descricao').AsString;
       ObjProdutoTipoDAO.Status := VQry.FieldByName('Status').AsInteger;
       Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoTipoDAO));
       VQry.Next;
     End;

}  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TProdutoTipoDao.InsertUpdate(pProdutoTipoId: Integer;
  pDescricao, pSigla: String; pStatus : Integer): TjSonArray;
var vSql: String;
begin
  try
    if pProdutoTipoId = 0 then
      vSql := 'Insert Into ProdutoTipo (Descricao, Sigla, Status) Values (' +
        QuotedStr(pDescricao)+', '+QuotedStr(pSigla) + ', 1) '
    Else
      vSql := 'Update ProdutoTipo ' + '    Set Descricao = ' +QuotedStr(pDescricao)+
              ', Sigla = '+QuotedStr(pSigla)+
              ', Status = '+pStatus.ToString() + ' where Id = ' + pProdutoTipoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', '200'));
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
