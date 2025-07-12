unit MService.RegistroTipoDAO;

interface

uses
  FireDAC.Comp.Client, RegistroTipoClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TRegistroTipoDao = class(TBasicDao)
  private

    
    ObjRegistroTipoDAO: TRegistroTipo;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Int64; pDescricao: String; pRegistroTipo: Int64;
      pStatus: Integer): TjSonArray;
    function GetId(pId: Int64): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pId: Int64): Boolean;
  end;

Const
  vcSql = 'select *' + ' from RegistroTipo ';

implementation

uses uSistemaControl;

{ TRegistroTipoDao }

constructor TRegistroTipoDao.Create;
begin
  ObjRegistroTipoDAO := TRegistroTipo.Create;
  inherited;
end;

function TRegistroTipoDao.Delete(pId: Int64): Boolean;
var
  VQry: TFDQuery;
  vSql: String;
begin
  Result := False;
  try

    VQry := FConexao.GetQuery;
    if assigned(Fconexao) then
      VQry.connection := Fconexao.DB;
    vSql := 'Delete from RegistroTipo where Id = ' + pId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally
   ;

  end;
end;

destructor TRegistroTipoDao.Destroy;
begin
  
  ObjRegistroTipoDAO.Free;
  inherited;
end;

function TRegistroTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var
  VQry: TFDQuery;
  vSql: String;
begin
  Result := TjSonArray.Create;
  VQry := FConexao.GetQuery;

  VQry.connection := Fconexao.DB;
  try
    vSql := vcSql;
    vSql := vSql + 'where (P.Descricao like ' +
      QuotedStr('%' + pDescricao + '%') + ')';
    VQry.Open(vSql);
    while Not VQry.Eof do
    Begin
      ObjRegistroTipoDAO.Id := VQry.FieldByName('Id').AsLargeInt;
      ObjRegistroTipoDAO.Descricao := VQry.FieldByName('Descricao').AsString;
      ObjRegistroTipoDAO.RegistroTipo := VQry.FieldByName('Registro_Tipo')
        .AsLargeInt;
      ObjRegistroTipoDAO.Status := 1; // vQry.FieldByName('Status').Asinteger;
      Result.Add(tJson.ObjectToJsonObject(ObjRegistroTipoDAO));
      // (ObjRegistroTipoDAO.ClassToJson(ObjRegistroTipoDAO).ToString);
      VQry.Next;
    End;
    VQry.Close;
  finally
   ;

  end;
end;

function TRegistroTipoDao.GetId(pId: Int64): TjSonArray;
var
  VQry: TFDQuery;
  vSql: String;
begin
  Result := TjSonArray.Create;

  VQry := FConexao.GetQuery;
  if assigned(Fconexao) then
    VQry.connection := Fconexao.DB;
  try
    vSql := vcSql;
    if pId <> 0 then
      vSql := vSql + ' Where P.Id = ' + pId.ToString;
    VQry.Open(vSql);
    while Not VQry.Eof do
    Begin
      ObjRegistroTipoDAO.Id := VQry.FieldByName('Id').AsLargeInt;
      ObjRegistroTipoDAO.Descricao := VQry.FieldByName('Descricao').AsString;
      ObjRegistroTipoDAO.RegistroTipo := VQry.FieldByName('Registro_Tipo')
        .AsLargeInt;
      ObjRegistroTipoDAO.Status := 1; // vQry.FieldByName('Status').Asinteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjRegistroTipoDAO));
      // (ObjRegistroTipoDAO.ClassToJson(ObjRegistroTipoDAO).ToString);
      VQry.Next;
    End;
    VQry.Close;
  finally
   ;

  end;
end;

function TRegistroTipoDao.InsertUpdate(pId: Int64; pDescricao: String;
  pRegistroTipo: Int64; pStatus: Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql: String;
begin

  VQry := FConexao.GetQuery;
  if assigned(Fconexao) then
    VQry.connection := Fconexao.DB;
  try
    if pId = 0 then
      vSql := 'Insert Into RegistroTipo (Descricao, Registro_Tipo ) Values (' +
        QuotedStr(pDescricao) + ', ' + pRegistroTipo.ToString() + ')'
    Else
      vSql := 'Update RegistroTipo Set Descricao = ' + QuotedStr(pDescricao) +
        '    , Registro_Tipo = ' + pRegistroTipo.ToString() + ' ' +
        'where Id = ' + pId.ToString;
    VQry.ExecSQL(vSql);
    try
      Result := VQry.toJsonArray;
    finally
      VQry.Close;
    end;
  finally
   ;

  end;
end;

end.
