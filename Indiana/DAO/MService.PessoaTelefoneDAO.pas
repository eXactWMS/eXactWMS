{
  PessoaTelefoneDAO.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.PessoaTelefoneDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.Types, System.JSON, REST.JSON, System.JSON.Types, PessoaClass,
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TPessoaTelefoneDao = class(TBasicDao)
  private

    

    FObjPessoaTelefoneDAO: TPessoaTelefone;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate: TjSonArray;
    // (pPessoaTelefoneId : Integer; pDescricao : String; pStatus : Integer ) : TjSonArray;
    function GetId(pIndFone, pPessoaId: Integer): TjSonArray;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Property ObjPessoaTelefoneDAO: TPessoaTelefone Read FObjPessoaTelefoneDAO
      Write FObjPessoaTelefoneDAO;
  end;

implementation

uses uSistemaControl, Constants, System.Math;

{ TClienteDao }

constructor TPessoaTelefoneDao.Create;
begin
  ObjPessoaTelefoneDAO := TPessoaTelefone.Create;
  inherited;
end;

function TPessoaTelefoneDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from PessoaTelefone where IndFone = ' +
      Self.ObjPessoaTelefoneDAO.IndFone.ToString + '       and PessoaId = ' +
      Self.ObjPessoaTelefoneDAO.PessoaId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PessoaTelefone - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPessoaTelefoneDao.Destroy;
begin
  
  ObjPessoaTelefoneDAO.Free;
  inherited;
end;

function TPessoaTelefoneDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('PessoaTelefone') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    While Not FConexao.Query.Eof do
    Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna',
        LowerCase(FConexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo',
        LowerCase(FConexao.Query.FieldByName('Tipo').AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TPessoaTelefoneDao.GetId(pIndFone, pPessoaId: Integer): TjSonArray;
var
  vSql: String;
  JsonEnderecoTipo: TJsonObject;
  JsonPessoaTelefone: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    vSql := TuEvolutConst.SqlGetPessoaTelefone;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pIndFone').Value := pIndFone;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        'Não há dados para gerar consulta.')))
    Else
      while Not FConexao.Query.Eof do
      Begin
        JsonPessoaTelefone := TJsonObject.Create;
        JsonPessoaTelefone.AddPair('id',
          TJsonNumber.Create(FConexao.Query.FieldByName('id').AsInteger));
        JsonPessoaTelefone.AddPair('indfone',
          TJsonNumber.Create(FConexao.Query.FieldByName('indfone').AsInteger));
        JsonPessoaTelefone.AddPair('pessoaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('pessoaid').AsInteger));
        JsonPessoaTelefone.AddPair('tipo', FConexao.Query.FieldByName('Tipo').AsString);
        JsonPessoaTelefone.AddPair('telefone', FConexao.Query.FieldByName('Telefone')
          .AsString);
        JsonPessoaTelefone.AddPair('contato', FConexao.Query.FieldByName('Contato')
          .AsString);
        JsonPessoaTelefone.AddPair('observacao', FConexao.Query.FieldByName('Observacao')
          .AsString);
        JsonPessoaTelefone.AddPair('codpais', FConexao.Query.FieldByName('codpais')
          .AsString);
        // JsonPessoaTelefone.AddPair('status', tjsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
        // Result := FConexao.Query.ToJSONArray();
        Result.AddElement(JsonPessoaTelefone);
        FConexao.Query.Next;
      End;
    ObjPessoaTelefoneDAO := Nil;
  Except
    On E: Exception do
    Begin
      ObjPessoaTelefoneDAO := Nil;
      JsonPessoaTelefone := Nil;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TPessoaTelefoneDao.InsertUpdate: TjSonArray;
// (pPessoaTelefoneId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
var
  vSql: String;
  Function MontaValor(pValor: Single): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlSavePessoaTelefone);
    FConexao.Query.ParamByName('pIndFone').Value := ObjPessoaTelefoneDAO.IndFone;
    FConexao.Query.ParamByName('pPessoaId').Value := ObjPessoaTelefoneDAO.PessoaId;
    FConexao.Query.ParamByName('pTipo').Value := ObjPessoaTelefoneDAO.Tipo;
    FConexao.Query.ParamByName('pTelefone').Value := ObjPessoaTelefoneDAO.Telefone;
    FConexao.Query.ParamByName('pContato').Value := ObjPessoaTelefoneDAO.Contato;
    FConexao.Query.ParamByName('pObservacao').Value := ObjPessoaTelefoneDAO.Observacao;
    FConexao.Query.ParamByName('pCodPais').Value := ObjPessoaTelefoneDAO.CodPais;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PessoaTelefoneSave.Sql');
    FConexao.Query.ExecSQL;
    Result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
