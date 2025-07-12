unit uPessoaTipoDAO;

interface

uses
  FireDAC.Comp.Client, PessoaTipoClass, System.SysUtils, DataSet.Serialize,
  System.JSON, REST.Json,exactwmsservice.lib.connection,exactwmsservice.dao.base;

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

uses uSistemaControl;

{ TClienteDao }

constructor TpessoatipoDao.Create;
begin
  inherited;
end;

function TpessoatipoDao.Delete(pId: Integer): Boolean;
var vQry: TFDQuery;
    vSql : String;
    FIndexConn : Integer;
    
Begin
  
  inherited;
  Result := False;
  try
    vQry := FConexao.GetQuery;
    vQry.Connection :=  Fconexao.DB;
    vSql := 'Delete from pessoatipo where PessoaTipoId = '+pId.ToString;
    vQry.ExecSQL(vSql);
    Result := True;
    vQry.Close;
  finally
   ;
    
  end;
end;

destructor TpessoatipoDao.Destroy;
begin
  
  inherited;
end;

function TpessoatipoDao.Estrutura: TJsonArray;
Var vRegEstrutura : TJsonObject;
Begin
  Result := TJsonArray.Create;
  FConexao.Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak+
            'FROM INFORMATION_SCHEMA.COLUMNS'+sLineBreak+
            'Where TABLE_NAME = '+QuotedStr('PessoaTipo')+' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
  Else Begin
    While Not FConexao.Query.Eof do Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna', LowerCase(FConexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo',   LowerCase(FConexao.Query.FieldByName('Tipo').AsString));
      vRegEstrutura.AddPair('tamanho',   TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TpessoatipoDao.GetDescricao(pNome: String): tJsonArray;
var vSql : String;
Begin
  try
    vSql := 'select * from pessoatipo where Descricao like '+QuotedStr('%'+pNome+'%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do 
    raise Exception.Create(E.Message);
  end;
end;

function TpessoatipoDao.GetId(pId: Integer): TjSonArray;
var vSql : String;
Begin
  try
    if pId = 0 then
       vSql := 'select * from pessoatipo'
    Else vSql := 'select * from pessoatipo where PessoaTipoId = '+pId.ToString;
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TpessoatipoDao.InsertUpdate(pId: Integer; pDescricao : String; pStatus : Integer): TjSonArray;
var vSql : String;
Begin
  try
    if pId = 0 then
       vSql := 'Insert Into pessoatipo (Descricao, Status) Values ('+
               QuotedStr(pDescricao)+', '+pStatus.ToString()+')'
    Else vSql := 'Update pessoatipo '+
                 '    Set Descricao = '+QuotedStr(pDescricao)+
                 '        ,Status   = '+pStatus.ToString()+
                 'where PessoaTipoId = '+pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
