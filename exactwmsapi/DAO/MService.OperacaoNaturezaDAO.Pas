{
  Micro Servico - DAO - OperacaoNaturezaDAO
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.OperacaoNaturezaDAO;

interface

uses
  FireDAC.Comp.Client, OperacaoNaturezaClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.utils,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TOperacaoNaturezaDao = class(TBasicDao)
  private

  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pId: Integer; pDescricao: AnsiString; pTipo: AnsiString): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pNome: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

//uses uSistemaControl;

{ TtipooperacaoDao }

constructor TOperacaoNaturezaDao.Create;
begin
  inherited;
end;

function TOperacaoNaturezaDao.Delete(pId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    try
      vSql := 'Delete from OperacaoNatureza where OperacaoNaturezaId = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
        raise Exception.Create('Processo: OperacaoNatureza/Delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TOperacaoNaturezaDao.Destroy;
begin
  inherited;
end;

function TOperacaoNaturezaDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('OperacaoNatureza') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
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

function TOperacaoNaturezaDao.GetDescricao(pNome: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select * from OperacaoNatureza where Descricao like ' + QuotedStr('%' + pNome + '%');
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
      raise Exception.Create('Processo: OperacaoNatureza/GetDescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TOperacaoNaturezaDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'select * from OperacaoNatureza'
      Else
         vSql := 'Select * from OperacaoNatureza where OperacaoNaturezaId = ' + pId.ToString;
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except
      ON E: Exception do
        raise Exception.Create(E.Message);
    end;
  Finally
    Query.Free;
  End;
end;

function TOperacaoNaturezaDao.InsertUpdate(pId: Integer; pDescricao: AnsiString;
  pTipo: AnsiString): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'Insert Into OperacaoNatureza (Descricao, Tipo) Values (' + QuotedStr(pDescricao) + ', ' + QuotedStr(pTipo) + ')'
      Else
         vSql := 'Update OperacaoNatureza Set' + '    Descricao = ' + QuotedStr(pDescricao)+sLineBreak+
                 '    , Tipo = ' + QuotedStr(pTipo)+sLineBreak+
                 'Where Id = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
      raise Exception.Create('Processo: Operacaonatureza/insertupdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

end.
