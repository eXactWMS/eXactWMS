unit MService.MedicamentoTipoDAO;

interface

uses
  FireDAC.Comp.Client, MedicamentoTipoClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type
  TMedicamentoTipoDao = class(TBasicDao)
  private

    ObjMedicamentoTipoDAO: TMedicamentoTipo;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pMedicamentoTipoId: Integer; pDescricao: String)
      : TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

//uses uSistemaControl;

{ TClienteDao }

constructor TMedicamentoTipoDao.Create;
begin
  ObjMedicamentoTipoDAO := TMedicamentoTipo.Create;
  inherited;

end;

destructor TMedicamentoTipoDao.Destroy;
begin
  ObjMedicamentoTipoDAO.Free;
  inherited;
end;

function TMedicamentoTipoDao.Delete(pId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from MedicamentoTipo where Id = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
        raise Exception.Create('Processo: MedicamentoTipo?Delete - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TMedicamentoTipoDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    Query.Open
      ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
      + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
      'Where TABLE_NAME = ' + QuotedStr('MedicamentoTipo') +
      ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do
      Begin
        vRegEstrutura := TJsonObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TMedicamentoTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pDescricao = '*' then
        pDescricao := '';
      vSql := 'Select * From MedicamentoTipo Where Descricao Like ' + QuotedStr('%' + pDescricao + '%');
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except ON E: Exception do
        raise Exception.Create('Processo: MedicamentoTipo/GetDescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TMedicamentoTipoDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    try
      if pId = 0 then
        vSql := 'select * from MedicamentoTipo'
      Else
        vSql := 'select * from MedicamentoTipo where Id = ' + pId.ToString;
      Query.Open(vSql);
      while Not Query.Eof do Begin
        ObjMedicamentoTipoDAO.Id        := Query.FieldByName('Id').AsInteger;
        ObjMedicamentoTipoDAO.Descricao := Query.FieldByName
          ('Descricao').AsString;
        Result.AddElement(tJson.ObjectToJsonObject(ObjMedicamentoTipoDAO));
        Query.Next;
      End;
    Except ON E: Exception do
        raise Exception.Create('Processo: MedicamentoTipo/GetId - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TMedicamentoTipoDao.InsertUpdate(pMedicamentoTipoId: Integer;
  pDescricao: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pMedicamentoTipoId = 0 then
        vSql := 'Insert Into MedicamentoTipo (Descricao, Status) Values (' + QuotedStr(pDescricao) + ', 1) '
      Else
        vSql := 'Update MedicamentoTipo ' + '    Set Descricao = ' + QuotedStr(pDescricao) + 'where Id = ' + pMedicamentoTipoId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except
      ON E: Exception do
        raise Exception.Create('Processo: MedicamentoTipo/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

end.
