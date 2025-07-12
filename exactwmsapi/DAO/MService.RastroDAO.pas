unit MService.RastroDAO;

interface

uses
  FireDAC.Comp.Client, RastroClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

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

//uses uSistemaControl;

{ TClienteDao }

constructor TRastroDao.Create;
begin
  ObjRastroDAO := TRastro.Create;
  inherited;
end;

function TRastroDao.Delete(pId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from RastroTipo where RastroId = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      raise Exception.Create('Processo: Rastro/Delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TRastroDao.Destroy;
begin
  ObjRastroDAO.Free;
  inherited;
end;

function TRastroDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pDescricao = '*' then
         pDescricao := '';
      vSql := 'Select * From RastroTipo Where Descricao Like ' + QuotedStr('%' + pDescricao + '%');
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
      raise Exception.Create('Processo: Rastro/getdescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TRastroDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'select * from RastroTipo'
      Else
         vSql := 'select * from RastroTipo where RastroId = ' + pId.ToString;
      Query.Open(vSql);
      while Not Query.Eof do Begin
        ObjRastroDAO.RastroId  := Query.FieldByName('RastroId').AsInteger;
        ObjRastroDAO.Descricao := Query.FieldByName('Descricao').AsString;
        Result.AddElement(tJson.ObjectToJsonObject(ObjRastroDAO));
        Query.Next;
      End;
    Except On E: Exception do
      raise Exception.Create('Processo: Rastro/getid - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TRastroDao.InsertUpdate(pRastroId: Integer; pDescricao: String) : TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pRastroId = 0 then
         vSql := 'Insert Into RastroTipo (Descricao, Status) Values (' + QuotedStr(pDescricao) + ', 1) '
      Else
         vSql := 'Update RastroTipo ' + '    Set Descricao = ' + QuotedStr(pDescricao) + 'where RastroId    = ' + pRastroId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    except On E: Exception do
      raise Exception.Create('Processo: Rastro/insertupdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

end.
