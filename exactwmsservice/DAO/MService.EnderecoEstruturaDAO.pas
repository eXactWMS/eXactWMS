unit MService.EnderecoestruturaDAO;

interface

uses
  FireDAC.Comp.Client, EnderecoestruturaClass, System.SysUtils,
  DataSet.Serialize,
  System.JSON, REST.JSON, System.Generics.Collections,
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TEnderecoestruturaDao = class(TBasicDao)
  private
    

  public
    constructor Create; overload;
    destructor destroy; override;
    function InsertUpdate(pJsonEstrutura: TJsonObject): TjSonArray;
    function GetId(pId: Integer): TjSonArray;
    function GetEstrutura4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    function GetDescricao(pNome: String): TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function Estrutura: TjSonArray;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TEnderecoestruturaDao.Create;
begin
  inherited;
end;

function TEnderecoestruturaDao.Delete(pId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Enderecamentoestruturas where EstruturaId = ' +
      pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TEnderecoestruturaDao.destroy;
begin
  
  inherited;
end;

function TEnderecoestruturaDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Enderecamentoestruturas') +
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

function TEnderecoestruturaDao.GetDescricao(pNome: String): TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'select * from Enderecamentoestruturas where Descricao like ' +
      QuotedStr('%' + pNome + '%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TEnderecoestruturaDao.GetEstrutura4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vParam: String;
begin
  Result := TJsonObject.Create();
  QryPesquisa := Fconexao.GetQuery;
  QryPesquisa.SQL.Add('select * From EnderecamentoEstruturas where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add
    ('Select Count(EstruturaId) cReg From EnderecamentoEstruturas where 1=1');
  if AParams.ContainsKey('estruturaid') then
  begin
    QryPesquisa.SQL.Add('and EstruturaId = :EstruturaId');
    QryPesquisa.ParamByName('EstruturaId').AsString :=
      AParams.Items['estruturaid'];
    QryRecordCount.SQL.Add('and EstruturaId = :EstruturaId');
    QryRecordCount.ParamByName('EstruturaId').AsString :=
      AParams.Items['estruturaid'];
  end;
  if AParams.ContainsKey('descricao') then
  begin
    vParam := '%' + AParams.Items['descricao'] + '%';
    QryPesquisa.SQL.Add('and Descricao Like :descricao');
    QryPesquisa.ParamByName('Descricao').AsString := vParam;
    QryRecordCount.SQL.Add('and Descricao like :Descricao');
    QryRecordCount.ParamByName('Descricao').AsString := vParam;
  end;
  if AParams.ContainsKey('limit') then
  begin
    QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    QryPesquisa.FetchOptions.RowsetSize :=
      StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    QryPesquisa.FetchOptions.RecsSkip :=
      StrToIntDef(AParams.Items['offset'], 0);
  QryPesquisa.SQL.Add('order by Descricao');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.toJsonArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  QryPesquisa.Close;
  QryRecordCount.Close;
end;

function TEnderecoestruturaDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
 try
    if pId = 0 then
      vSql := 'select * from Enderecamentoestruturas'
    Else
      vSql := 'select * from Enderecamentoestruturas where EstruturaId = ' + pId.ToString;
    vSql := vSql + sLineBreak + 'Order by EstruturaId';
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
 Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TEnderecoestruturaDao.InsertUpdate(pJsonEstrutura: TJsonObject)
  : TjSonArray;
var
  vSql: String;
begin
  try
    if pJsonEstrutura.GetValue<Integer>('estruturaid') = 0 then
    Begin
      vSql := 'Insert Into Enderecamentoestruturas (CodEstrutura, Descricao, PickingFixo, '
        + 'Distribuicao, Altura, Largura, Comprimento, VolumePadrao, CapacidadePadrao, Mascara, Status) Values ('
        + '(SELECT IDENT_CURRENT(' + #39 + 'EnderecamentoEstruturas' + #39 +
        ')), ' + QuotedStr(pJsonEstrutura.GetValue<String>('descricao')) + ', '
        + pJsonEstrutura.GetValue<Integer>('pickingfixo').ToString() + ', ' +
        pJsonEstrutura.GetValue<Integer>('distribuicao').ToString() + ', ' +
        StringReplace(pJsonEstrutura.GetValue<double>('altura').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEstrutura.GetValue<double>('largua').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEstrutura.GetValue<double>('comprimento').ToString(),
        ',', '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEstrutura.GetValue<double>('volumepadrao')
        .ToString(), ',', '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEstrutura.GetValue<double>('capacidadepadrao')
        .ToString(), ',', '.', [rfReplaceAll]) + ', ' +
        QuotedStr(pJsonEstrutura.GetValue<String>('mascara')) + ', 1)';
    End
    Else
      vSql := 'Update Enderecamentoestruturas ' +
        '    Set Descricao          = ' +
        QuotedStr(pJsonEstrutura.GetValue<String>('descricao')) + sLineBreak +
        '        , PickingFixo      = ' + pJsonEstrutura.GetValue<Integer>
        ('pickingfixo').ToString() + sLineBreak +
        '        , Distribuicao     = ' + pJsonEstrutura.GetValue<Integer>
        ('distribuicao').ToString() + sLineBreak +
        '        , Altura           = ' +
        StringReplace(pJsonEstrutura.GetValue<double>('altura').ToString(), ',',
        '.', [rfReplaceAll]) + sLineBreak + '        , Largura          = ' +
        StringReplace(pJsonEstrutura.GetValue<double>('largua').ToString(), ',',
        '.', [rfReplaceAll]) + sLineBreak + '        , Comprimento      = ' +
        StringReplace(pJsonEstrutura.GetValue<double>('comprimento').ToString(),
        ',', '.', [rfReplaceAll]) + sLineBreak + '        , VolumePadrao     = '
        + StringReplace(pJsonEstrutura.GetValue<double>('volumepadrao')
        .ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
        '        , CapacidadePadrao = ' +
        StringReplace(pJsonEstrutura.GetValue<double>('capacidadepadrao')
        .ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
        '        , Mascara          = ' +
        QuotedStr(pJsonEstrutura.GetValue<String>('mascara')) + sLineBreak +
        '        , Status           = ' + pJsonEstrutura.GetValue<Integer>
        ('status').ToString() + 'where EstruturaId = ' +
        pJsonEstrutura.GetValue<Integer>('estruturaid').ToString();
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
