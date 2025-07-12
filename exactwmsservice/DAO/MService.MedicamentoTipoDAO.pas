unit MService.MedicamentoTipoDAO;

interface

uses
  FireDAC.Comp.Client, MedicamentoTipoClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

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

uses uSistemaControl;

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
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from MedicamentoTipo where Id = ' + pId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  End;
end;

function TMedicamentoTipoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  Fconexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('MedicamentoTipo') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if Fconexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    While Not Fconexao.Query.Eof do
    Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna',
        LowerCase(Fconexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo', LowerCase(Fconexao.Query.FieldByName('Tipo')
        .AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(Fconexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      Fconexao.Query.Next;
    End;
  End;
end;

function TMedicamentoTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var
  vSql: String;
begin
  try
    if pDescricao = '*' then
      pDescricao := '';
    vSql := 'Select * From MedicamentoTipo Where Descricao Like ' +
      QuotedStr('%' + pDescricao + '%');
    Fconexao.Query.Open(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TMedicamentoTipoDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    if pId = 0 then
      vSql := 'select * from MedicamentoTipo'
    Else
      vSql := 'select * from MedicamentoTipo where Id = ' + pId.ToString;
    Fconexao.Query.Open(vSql);
    while Not Fconexao.Query.Eof do
    Begin
      ObjMedicamentoTipoDAO.Id := Fconexao.Query.FieldByName('Id').AsInteger;
      ObjMedicamentoTipoDAO.Descricao := Fconexao.Query.FieldByName
        ('Descricao').AsString;
      Result.AddElement(tJson.ObjectToJsonObject(ObjMedicamentoTipoDAO));
      Fconexao.Query.Next;
    End;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TMedicamentoTipoDao.InsertUpdate(pMedicamentoTipoId: Integer;
  pDescricao: String): TjSonArray;
var
  vSql: String;
begin
  try
    if pMedicamentoTipoId = 0 then
      vSql := 'Insert Into MedicamentoTipo (Descricao, Status) Values (' +
        QuotedStr(pDescricao) + ', 1) '
    Else
      vSql := 'Update MedicamentoTipo ' + '    Set Descricao = ' +
        QuotedStr(pDescricao) + 'where Id = ' + pMedicamentoTipoId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
