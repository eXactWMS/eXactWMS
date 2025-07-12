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
  exactwmsservice.lib.connection, exactwmsservice.lib.utils, exactwmsservice.dao.base;

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

uses Constants, System.Math; //uSistemaControl,

{ TClienteDao }

constructor TPessoaTelefoneDao.Create;
begin
  ObjPessoaTelefoneDAO := TPessoaTelefone.Create;
  inherited;
end;

function TPessoaTelefoneDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
  Result := False;
    try
      vSql := 'Delete from PessoaTelefone'+sLineBreak+
              'Where IndFone = ' + Self.ObjPessoaTelefoneDAO.IndFone.ToString+sLinebreak+
              '  and PessoaId = ' + Self.ObjPessoaTelefoneDAO.PessoaId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PessoaTelefone/Delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TPessoaTelefoneDao.Destroy;
begin
  ObjPessoaTelefoneDAO.Free;
  inherited;
end;

function TPessoaTelefoneDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
  Result := TjSonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('PessoaTelefone') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do Begin
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

function TPessoaTelefoneDao.GetId(pIndFone, pPessoaId: Integer): TjSonArray;
var vSql: String;
    JsonEnderecoTipo: TJsonObject;
    JsonPessoaTelefone: TJsonObject;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := TuEvolutConst.SqlGetPessoaTelefone;
      Query.SQL.Add(vSql);
      Query.ParamByName('pIndFone').Value := pIndFone;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.Open;
      if Query.IsEmpty then
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', 'Não há dados para gerar consulta.')))
      Else
        while Not Query.Eof do Begin
          JsonPessoaTelefone := TJsonObject.Create;
          JsonPessoaTelefone.AddPair('id', TJsonNumber.Create(Query.FieldByName('id').AsInteger));
          JsonPessoaTelefone.AddPair('indfone', TJsonNumber.Create(Query.FieldByName('indfone').AsInteger));
          JsonPessoaTelefone.AddPair('pessoaid', TJsonNumber.Create(Query.FieldByName('pessoaid').AsInteger));
          JsonPessoaTelefone.AddPair('tipo', Query.FieldByName('Tipo').AsString);
          JsonPessoaTelefone.AddPair('telefone', Query.FieldByName('Telefone').AsString);
          JsonPessoaTelefone.AddPair('contato', Query.FieldByName('Contato').AsString);
          JsonPessoaTelefone.AddPair('observacao', Query.FieldByName('Observacao').AsString);
          JsonPessoaTelefone.AddPair('codpais', Query.FieldByName('codpais').AsString);
          // JsonPessoaTelefone.AddPair('status', tjsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
          // Result := FConexao.Query.ToJSONArray();
          Result.AddElement(JsonPessoaTelefone);
          Query.Next;
        End;
      ObjPessoaTelefoneDAO := Nil;
    Except On E: Exception do
      Begin
        JsonPessoaTelefone   := Nil;
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', 'Processo: PessoaTelefone/getid - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TPessoaTelefoneDao.InsertUpdate: TjSonArray;
// (pPessoaTelefoneId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
  Function MontaValor(pValor: Single): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlSavePessoaTelefone);
      Query.ParamByName('pIndFone').Value := ObjPessoaTelefoneDAO.IndFone;
      Query.ParamByName('pPessoaId').Value := ObjPessoaTelefoneDAO.PessoaId;
      Query.ParamByName('pTipo').Value := ObjPessoaTelefoneDAO.Tipo;
      Query.ParamByName('pTelefone').Value := ObjPessoaTelefoneDAO.Telefone;
      Query.ParamByName('pContato').Value := ObjPessoaTelefoneDAO.Contato;
      Query.ParamByName('pObservacao').Value := ObjPessoaTelefoneDAO.Observacao;
      Query.ParamByName('pCodPais').Value := ObjPessoaTelefoneDAO.CodPais;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PessoaTelefoneSave.Sql');
      Query.ExecSQL;
      Result := Query.toJsonArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: PessoaTelefone/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
