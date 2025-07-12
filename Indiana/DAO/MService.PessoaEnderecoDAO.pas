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
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

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

uses uSistemaControl, Constants, System.Math;

{ TClienteDao }

constructor TPessoaEnderecoDao.Create;
begin
  ObjPessoaEnderecoDAO := TPessoaEndereco.Create;
  inherited;
end;

function TPessoaEnderecoDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from PessoaEndereco where Id = ' +
      Self.ObjPessoaEnderecoDAO.Id.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PessoaEndereco - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPessoaEnderecoDao.Destroy;
begin
  
  ObjPessoaEnderecoDAO.Free;
  inherited;
end;

function TPessoaEnderecoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('PessoaEndereco') +
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

function TPessoaEnderecoDao.GetId(pId, pPessoaId: Integer): TjSonArray;
var
  vSql: String;
  JsonEnderecoTipo: TJsonObject;
  JsonPessoaEndereco: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    vSql := TuEvolutConst.SqlGetPessoaEndereco;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pId').Value := pId;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        'Não há dados para gerar consulta.')))
    Else
      while Not FConexao.Query.Eof do
      Begin
        JsonPessoaEndereco := TJsonObject.Create;
        JsonPessoaEndereco.AddPair('id',
          TJsonNumber.Create(FConexao.Query.FieldByName('id').AsInteger));
        JsonPessoaEndereco.AddPair('pessoaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('pessoaid').AsInteger));
        JsonEnderecoTipo := TJsonObject.Create;
        JsonEnderecoTipo.AddPair('enderecotipoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('enderecotipoid').AsInteger));
        JsonEnderecoTipo.AddPair('descricao',
          FConexao.Query.FieldByName('enderecotipodescricao').AsString);
        JsonEnderecoTipo.AddPair('status',
          TJsonNumber.Create(FConexao.Query.FieldByName('enderecotipostatus').AsInteger));
        JsonPessoaEndereco.AddPair('enderecotipo', JsonEnderecoTipo);
        JsonPessoaEndereco.AddPair('endereco', FConexao.Query.FieldByName('endereco')
          .AsString);
        JsonPessoaEndereco.AddPair('numero', FConexao.Query.FieldByName('Numero')
          .AsString);
        JsonPessoaEndereco.AddPair('complemento',
          FConexao.Query.FieldByName('Complemento').AsString);
        JsonPessoaEndereco.AddPair('referencia', FConexao.Query.FieldByName('Referencia')
          .AsString);
        JsonPessoaEndereco.AddPair('bairro', FConexao.Query.FieldByName('bairro')
          .AsString);
        JsonPessoaEndereco.AddPair('municipio', FConexao.Query.FieldByName('Municipio')
          .AsString);
        JsonPessoaEndereco.AddPair('uf', FConexao.Query.FieldByName('Uf').AsString);
        JsonPessoaEndereco.AddPair('cep', FConexao.Query.FieldByName('Cep').AsString);
        JsonPessoaEndereco.AddPair('codibge', FConexao.Query.FieldByName('CodIbge')
          .AsString);
        JsonPessoaEndereco.AddPair('status',
          TJsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
        // Result := FConexao.Query.ToJSONArray();
        Result.AddElement(JsonPessoaEndereco);
        FConexao.Query.Next;
      End;
    ObjPessoaEnderecoDAO := Nil;
  Except
    On E: Exception do
    Begin
      ObjPessoaEnderecoDAO := Nil;
      JsonPessoaEndereco := Nil;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TPessoaEnderecoDao.InsertUpdate: TjSonArray;
// (pPessoaEnderecoId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
var
  vSql: String;
  Function MontaValor(pValor: Single): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlSavePessoaEndereco);
    FConexao.Query.ParamByName('pPessoaId').Value := ObjPessoaEnderecoDAO.PessoaId;
    FConexao.Query.ParamByName('pEnderecoTipoDescricao').Value :=
      ObjPessoaEnderecoDAO.EnderecoTipo.Descricao;
    FConexao.Query.ParamByName('pEndereco').Value := ObjPessoaEnderecoDAO.Endereco;
    FConexao.Query.ParamByName('pNumero').Value := ObjPessoaEnderecoDAO.Numero;
    FConexao.Query.ParamByName('pComplemento').Value := ObjPessoaEnderecoDAO.Complemento;
    FConexao.Query.ParamByName('pReferencia').Value := ObjPessoaEnderecoDAO.Referencia;
    FConexao.Query.ParamByName('pBairro').Value := ObjPessoaEnderecoDAO.Bairro;
    FConexao.Query.ParamByName('pMunicipio').Value := ObjPessoaEnderecoDAO.Municipio;
    FConexao.Query.ParamByName('pUf').Value := ObjPessoaEnderecoDAO.Uf;
    FConexao.Query.ParamByName('pCep').Value := ObjPessoaEnderecoDAO.Cep;
    FConexao.Query.ParamByName('pCodIbge').Value := ObjPessoaEnderecoDAO.CodIbge;
    FConexao.Query.ParamByName('pStatus').Value := ObjPessoaEnderecoDAO.Status;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PessoaenderecoSave.Sql');
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
