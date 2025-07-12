{
  PessoaEnderecoDAO.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.PessoaEnderecoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.Types, System.JSON, REST.JSON, System.JSON.Types, PessoaClass,
  exactwmsservice.lib.connection,
  exactwmsservice.Lib.Utils, exactwmsservice.dao.base;

type
  TPessoaEnderecoDao = class(TBasicDao)
  private
    FObjPessoaEnderecoDAO: TPessoaEndereco;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate: TjSonArray;
    // (pPessoaEnderecoId : Integer; pDescricao : String; pStatus : Integer ) : TjSonArray;
    function GetId(pId, pPessoaId: Integer): TjSonArray;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Property ObjPessoaEnderecoDAO: TPessoaEndereco Read FObjPessoaEnderecoDAO
      Write FObjPessoaEnderecoDAO;
  end;

implementation

uses Constants, System.Math;      ///uSistemaControl,

{ TClienteDao }

constructor TPessoaEnderecoDao.Create;
begin
  ObjPessoaEnderecoDAO := TPessoaEndereco.Create;
  inherited;
end;

function TPessoaEnderecoDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from PessoaEndereco where Id = ' + Self.ObjPessoaEnderecoDAO.Id.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PessoaEndereco/Delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TPessoaEnderecoDao.Destroy;
begin

  ObjPessoaEnderecoDAO.Free;
  inherited;
end;

function TPessoaEnderecoDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('PessoaEndereco') +
               ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else Begin
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

function TPessoaEnderecoDao.GetId(pId, pPessoaId: Integer): TjSonArray;
var vSql: String;
    JsonEnderecoTipo: TJsonObject;
    JsonPessoaEndereco: TJsonObject;
Var Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := TuEvolutConst.SqlGetPessoaEndereco;
      Query.SQL.Add(vSql);
      Query.ParamByName('pId').Value := pId;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', 'Não há dados para gerar consulta.')))
      Else
        while Not Query.Eof do Begin
          JsonPessoaEndereco := TJsonObject.Create;
          JsonPessoaEndereco.AddPair('id', TJsonNumber.Create(Query.FieldByName('id').AsInteger));
          JsonPessoaEndereco.AddPair('pessoaid', TJsonNumber.Create(Query.FieldByName('pessoaid').AsInteger));
          JsonEnderecoTipo := TJsonObject.Create;
          JsonEnderecoTipo.AddPair('enderecotipoid', TJsonNumber.Create(Query.FieldByName('enderecotipoid').AsInteger));
          JsonEnderecoTipo.AddPair('descricao', Query.FieldByName('enderecotipodescricao').AsString);
          JsonEnderecoTipo.AddPair('status', TJsonNumber.Create(Query.FieldByName('enderecotipostatus').AsInteger));
          JsonPessoaEndereco.AddPair('enderecotipo', JsonEnderecoTipo);
          JsonPessoaEndereco.AddPair('endereco', Query.FieldByName('endereco').AsString);
          JsonPessoaEndereco.AddPair('numero', Query.FieldByName('Numero').AsString);
          JsonPessoaEndereco.AddPair('complemento', Query.FieldByName('Complemento').AsString);
          JsonPessoaEndereco.AddPair('referencia', Query.FieldByName('Referencia').AsString);
          JsonPessoaEndereco.AddPair('bairro', Query.FieldByName('bairro').AsString);
          JsonPessoaEndereco.AddPair('municipio', Query.FieldByName('Municipio').AsString);
          JsonPessoaEndereco.AddPair('uf', Query.FieldByName('Uf').AsString);
          JsonPessoaEndereco.AddPair('cep', Query.FieldByName('Cep').AsString);
          JsonPessoaEndereco.AddPair('codibge', Query.FieldByName('CodIbge').AsString);
          JsonPessoaEndereco.AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
          // Result := FConexao.Query.ToJSONArray();
          Result.AddElement(JsonPessoaEndereco);
          Query.Next;
        End;
      ObjPessoaEnderecoDAO := Nil;
    Except On E: Exception do
      Begin
        ObjPessoaEnderecoDAO := Nil;
        JsonPessoaEndereco := Nil;
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', 'PessoaEndereco/getid - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TPessoaEnderecoDao.InsertUpdate: TjSonArray;
// (pPessoaEnderecoId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
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
      Query.SQL.Add(TuEvolutConst.SqlSavePessoaEndereco);
      Query.ParamByName('pPessoaId').Value := ObjPessoaEnderecoDAO.PessoaId;
      Query.ParamByName('pEnderecoTipoDescricao').Value := ObjPessoaEnderecoDAO.EnderecoTipo.Descricao;
      Query.ParamByName('pEndereco').Value := ObjPessoaEnderecoDAO.Endereco;
      Query.ParamByName('pNumero').Value := ObjPessoaEnderecoDAO.Numero;
      Query.ParamByName('pComplemento').Value := ObjPessoaEnderecoDAO.Complemento;
      Query.ParamByName('pReferencia').Value := ObjPessoaEnderecoDAO.Referencia;
      Query.ParamByName('pBairro').Value := ObjPessoaEnderecoDAO.Bairro;
      Query.ParamByName('pMunicipio').Value := ObjPessoaEnderecoDAO.Municipio;
      Query.ParamByName('pUf').Value := ObjPessoaEnderecoDAO.Uf;
      Query.ParamByName('pCep').Value := ObjPessoaEnderecoDAO.Cep;
      Query.ParamByName('pCodIbge').Value := ObjPessoaEnderecoDAO.CodIbge;
      Query.ParamByName('pStatus').Value := ObjPessoaEnderecoDAO.Status;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PessoaenderecoSave.Sql');
      Query.ExecSQL;
      Result := Query.toJsonArray;
    Except On E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  Finally
   Query.Free;
  End
end;

end.
