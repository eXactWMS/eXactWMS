unit uPessoaTipoDAO;

interface

uses
  FireDAC.Comp.Client, PessoaTipoClass, System.SysUtils, DataSet.Serialize,
  System.JSON, REST.Json,exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type
  TpessoatipoDao = class(TBasicDao)
  private
    
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Integer; pDescricao : String; pStatus : Integer): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pNome : String) : tJsonArray;
    Function Delete(pId : Integer) : Boolean;
    Function Estrutura : TJsonArray;
  end;

implementation

//uses uSistemaControl;

{ TClienteDao }

constructor TpessoatipoDao.Create;
begin
  inherited;
end;

function TpessoatipoDao.Delete(pId: Integer): Boolean;
var vSql : String;
    FIndexConn : Integer;
    Query : TFdQuery;
begin
  inherited;
  Result := False;
  Try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := Connection;
      vSql := 'Delete from pessoatipo where PessoaTipoId = '+pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Raise Exception.Create('Processo: PessoaTipo/Delete - '+TUtil.TratarExcessao(E.Message))
    end;
  finally
   Query.Free;
  end;
end;

destructor TpessoatipoDao.Destroy;
begin
  inherited;
end;

function TpessoatipoDao.Estrutura: TJsonArray;
Var vRegEstrutura : TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TJsonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak+
               'FROM INFORMATION_SCHEMA.COLUMNS'+sLineBreak+
               'Where TABLE_NAME = '+QuotedStr('PessoaTipo')+' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else Begin
      While Not Query.Eof do Begin
        vRegEstrutura := TJsonObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo',   LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho',   TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TpessoatipoDao.GetDescricao(pNome: String): tJsonArray;
var vSql : String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select * from pessoatipo where Descricao like '+QuotedStr('%'+pNome+'%');
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
      raise Exception.Create('Processo: PessoaTipo/getdescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TpessoatipoDao.GetId(pId: Integer): TjSonArray;
var vSql : String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'select * from pessoatipo'
      Else vSql := 'select * from pessoatipo where PessoaTipoId = '+pId.ToString;
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
      raise Exception.Create('Processo: PessoaTipo/GetId - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TpessoatipoDao.InsertUpdate(pId: Integer; pDescricao : String; pStatus : Integer): TjSonArray;
var vSql : String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'Insert Into pessoatipo (Descricao, Status) Values ('+ QuotedStr(pDescricao)+', '+pStatus.ToString()+')'
      Else vSql := 'Update pessoatipo '+
                   '    Set Descricao = '+QuotedStr(pDescricao)+
                   '        ,Status   = '+pStatus.ToString()+
                   'where PessoaTipoId = '+pId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except ON E: Exception do
      raise Exception.Create(E.Message);
    end;
  Finally
    Query.Free;
  End;
end;

end.
