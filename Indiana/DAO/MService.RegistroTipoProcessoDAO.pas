unit MService.RegistroTipoProcessoDAO;

interface

uses
  FireDAC.Comp.Client, RegistroTipoProcessoClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TRegistroTipoProcessoDao = class(TBasicDao)
  private

    ObjRegistroTipoProcessoDAO: TRegistroTipoProcesso;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId, pProcessoId, pRegistroTipoId: Int64;
      pStatus: Integer): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
  end;

Const
  vcSql = 'select * from RegistroTipoProcesso P ';

implementation

uses uSistemaControl;

{ TRegistroTipoProcessoDao }

constructor TRegistroTipoProcessoDao.Create;
begin
  ObjRegistroTipoProcessoDAO := TRegistroTipoProcesso.Create;
  inherited;
end;

function TRegistroTipoProcessoDao.Delete(pId: Integer): Boolean;
var
  VQry: TFDQuery;
  vSql: String;
begin
  Result := False;
  try

    VQry := FConexao.GetQuery;
    if assigned(Fconexao) then
      VQry.connection := Fconexao.DB;
    vSql := 'Delete from RegistroTipoProcesso where Id = ' + pId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally
   ;

  end;
end;

destructor TRegistroTipoProcessoDao.Destroy;
begin
  
  ObjRegistroTipoProcessoDAO.Free;
  inherited;
end;

function TRegistroTipoProcessoDao.GetDescricao(pDescricao: String): TjSonArray;
var
  VQry: TFDQuery;
  vSql: String;
begin
  {
    Result := TJsonArray.Create;
    VQry := FConexao.CriarQuery();
    try
    vSql := vcSQL;
    vSql := vSql + 'where (P.Descricao like '+QuotedStr('%'+pDescricao+'%')+') or '+
    '(P.RegistroTipoProcesso like '+QuotedStr('%'+pDescricao+'%')+')';
    VQry.Open(vSql);
    while Not vQry.Eof do Begin
    ObjRegistroTipoProcessoDAO.Id        := vQry.FieldByName('Id').AsInteger;
    ObjRegistroTipoProcessoDao.Descricao := vQry.FieldByName('Descricao').AsString;
    ObjRegistroTipoProcessoDao.RegistroTipoProcesso  := vQry.FieldByName('RegistroTipoProcesso').AsString;
    ObjRegistroTipoProcessoDao.Status    := 1;//vQry.FieldByName('Status').Asinteger;
    Result.Add(tJson.ObjectToJsonObject(ObjRegistroTipoProcessoDAO));                                       //(ObjRegistroTipoProcessoDAO.ClassToJson(ObjRegistroTipoProcessoDAO).ToString);
    vQry.Next;
    End;
    VQry.Close;
    finally
   
    end;

  } end;

function TRegistroTipoProcessoDao.GetId(pId: Integer): TjSonArray;
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
      ObjRegistroTipoProcessoDAO.Id := VQry.FieldByName('Id').AsLargeInt;
      ObjRegistroTipoProcessoDAO.ProcessoId := VQry.FieldByName('Processo_Id')
        .AsLargeInt;
      ObjRegistroTipoProcessoDAO.RegistroTipoId :=
        VQry.FieldByName('Registro_Tipo_Id').AsLargeInt;
      ObjRegistroTipoProcessoDAO.Status := 1;
      // vQry.FieldByName('Status').Asinteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjRegistroTipoProcessoDAO));
      // (ObjRegistroTipoProcessoDAO.ClassToJson(ObjRegistroTipoProcessoDAO).ToString);
      VQry.Next;
    End;
    VQry.Close;
  finally
   ;

  end;
end;

function TRegistroTipoProcessoDao.InsertUpdate(pId, pProcessoId, pRegistroTipoId
  : Int64; pStatus: Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql: String;
begin

  VQry := FConexao.GetQuery;
  if assigned(Fconexao) then
    VQry.connection := Fconexao.DB;
  try
    if pId = 0 then
      vSql := 'Insert Into RegistroTipoProcesso (ProcessoId, RegistroTipoId ) Values ('
        + pProcessoId.ToString() + ', ' + pRegistroTipoId.ToString() + ')'
    Else
      vSql := 'Update RegistroTipoProcesso ' + 'Set Processo_Id     = ' +
        pProcessoId.ToString() + '  , Registro_Tipo_Id = ' +
        pRegistroTipoId.ToString() + ' ' + 'where Id = ' + pId.ToString;
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
