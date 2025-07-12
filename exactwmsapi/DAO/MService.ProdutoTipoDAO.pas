unit MService.ProdutoTipoDAO;

interface

uses
  FireDAC.Comp.Client, ProdutoTipoClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

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

uses Constants; //uSistemaControl,

{ TClienteDao }

constructor TProdutoTipoDao.Create;
begin
  ObjProdutoTipoDAO := TProdutoTipo.Create;
  inherited;
end;

function TProdutoTipoDao.Delete(pId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from ProdutoTipo where Id = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      raise Exception.Create('Processo: ProdutoTipo/Delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TProdutoTipoDao.Destroy;
begin
  ObjProdutoTipoDAO.Free;
  inherited;
end;

function TProdutoTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pDescricao = '*' then
         pDescricao := '';
      vSql := 'Select * From ProdutoTipo Where Descricao Like ' + QuotedStr('%' + pDescricao + '%');
      Query.Open(vSql);
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      raise Exception.Create('Processo: ProdutoTipo/getdescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TProdutoTipoDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
        vSql := 'select * from ProdutoTipo'
      Else
        vSql := 'select * from ProdutoTipo where Id = ' + pId.ToString;
      Query.Open(vSql);
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      raise Exception.Create('Processo: ProdutoTipo/getid - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TProdutoTipoDao.InsertUpdate(pProdutoTipoId: Integer;
  pDescricao, pSigla: String; pStatus : Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pProdutoTipoId = 0 then
         vSql := 'Insert Into ProdutoTipo (Descricao, Sigla, Status) Values (' + QuotedStr(pDescricao)+', '+QuotedStr(pSigla) + ', 1) '
      Else
         vSql := 'Update ProdutoTipo ' + '    Set Descricao = ' +QuotedStr(pDescricao)+
                 ', Sigla = '+QuotedStr(pSigla)+
                 ', Status = '+pStatus.ToString() + ' where Id = ' + pProdutoTipoId.ToString;
      Query.ExecSQL(vSql);
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', '200'));
    Except On E: Exception do
      raise Exception.Create('Processo: ProdutoTipo/insertupdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

end.
