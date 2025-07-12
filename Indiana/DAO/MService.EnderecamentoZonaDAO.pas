unit MService.EnderecamentoZonaDAO;

interface

uses
  FireDAC.Comp.Client, EnderecamentoZonaClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.connection, exactwmsservice.lib.utils,
  System.JSON, REST.JSON, System.Generics.Collections,exactwmsservice.dao.base;

type
  TEnderecamentoZonaDao = class(TBasicDao)
  private
    

  public
    constructor Create; overload;
    destructor destroy; override;

    function InsertUpdate(pJsonEnderecamentoZona: TJsonObject): TjSonArray;
    function GetId(pZonaId: Integer): TjSonArray;
    function GetZona4D(const AParams: TDictionary<string, string>): TJsonObject;
    Function GetZonaPicking(pZonaId, pPickingFixo, pDisponivel: Integer)
      : TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete(pZonaId: Integer): Boolean;
    Function MontarPaginacao: TJsonObject;
    Function GetZonas(const AParams: TDictionary<string, string>) : TJsonArray;
    Function Estrutura: TjSonArray;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TEnderecamentoZonaDao.Create;
begin
  inherited;
end;

function TEnderecamentoZonaDao.Delete(pZonaId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from EnderecamentoZonas where ZonaId = ' + pZonaId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TEnderecamentoZonaDao.destroy;
begin
  
  inherited;
end;

function TEnderecamentoZonaDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('EnderecamentoZonas') +
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

function TEnderecamentoZonaDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
begin
  try
    vSql := 'select * from EnderecamentoZonas where Descricao like ' +
      QuotedStr('%' + pDescricao + '%');
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception Do
    raise Exception.Create(E.Message);
  end;
end;

function TEnderecamentoZonaDao.GetId(pZonaId: Integer): TjSonArray;
var vSql: String;
    JsonZona, JsonEstoqueTipo, JsonRastro: TJsonObject;
begin
  try
    vSql := 'select Ez.ZonaId, Ez.Descricao, Ez.EstruturaId, Ez.EstoqueTipoId, Et.Descricao EstoqueTipo, Ez.Status, '+sLineBreak +
            '      Ez.RastroId, R.Descricao Rastro, Ez.LoteReposicao, Ez.SeparacaoConsolidada, Ez.Sigla, Ez.pickingdinamico, Ez.TagVolumeOrdem, Ez.ProdutoSNGPC'+sLineBreak +
            'From EnderecamentoZonas EZ' + sLineBreak +
            'Inner join EstoqueTipo ET ON Et.Id = Ez.EstoqueTipoId' + sLineBreak +
            'Inner join RastroTipo R ON R.RastroId = Ez.RastroId';
    if pZonaId <> 0 then
       vSql := vSql + sLineBreak + 'where ZonaId = ' + pZonaId.ToString;
    FConexao.Query.Open(vSql);
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('EnderecamentoZonas.Sql');
    Result := TjSonArray.Create;
    if FConexao.Query.IsEmpty then
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
    Else
      While Not FConexao.Query.Eof do Begin
        JsonZona := TJsonObject.Create;
        JsonZona.AddPair('zonaid', TJsonNumber.Create(FConexao.Query.FieldByName('ZonaId').AsInteger));
        JsonZona.AddPair('descricao', FConexao.Query.FieldByName('Descricao').AsString);
        JsonZona.AddPair('estruturaid', FConexao.Query.FieldByName('EstruturaId').AsString);
        JsonZona.AddPair('estoquetipoid', TJsonNumber.Create(FConexao.Query.FieldByName('EstoqueTipoId').AsInteger));
        JsonEstoqueTipo := TJsonObject.Create;
        JsonEstoqueTipo.AddPair('estoquetipoid', TJsonNumber.Create(FConexao.Query.FieldByName('EstoqueTipoId').AsInteger));
        JsonEstoqueTipo.AddPair('descricao', FConexao.Query.FieldByName('EstoqueTipo').AsString);
        JsonRastro := TJsonObject.Create;
        JsonRastro.AddPair('rastroid', TJsonNumber.Create(FConexao.Query.FieldByName('RastroId').AsInteger));
        JsonRastro.AddPair('descricao', FConexao.Query.FieldByName('Rastro').AsString);
        JsonZona.AddPair('estoquetipo', JsonEstoqueTipo);
        JsonZona.AddPair('rastro', JsonRastro);
        JsonZona.AddPair('lotereposicao', TJsonNumber.Create(FConexao.Query.FieldByName('LoteReposicao').AsString));
        JsonZona.AddPair('separacaoconsolidada', TJsonNumber.Create(FConexao.Query.FieldByName('SeparacaoConsolidada').AsString));
        JsonZona.AddPair('produtosngpc', TJsonNumber.Create(FConexao.Query.FieldByName('ProdutoSNGPC').AsString));
        JsonZona.AddPair('sigla',FConexao.Query.FieldByName('sigla').AsString);
        JsonZona.AddPair('pickingdinamico',TJsonNumber.Create(FConexao.Query.FieldByName('PickingDinamico').AsInteger));
        JsonZona.AddPair('tagvolumeordem',TJsonNumber.Create(FConexao.Query.FieldByName('TagVolumeOrdem').AsInteger));
        JsonZona.AddPair('status', TJsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
        Result.AddElement(JsonZona);
        FConexao.Query.Next;
      End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

// https://www.youtube.com/watch?v=emtAWD8XHmQ&ab_channel=AcademiadoC%C3%B3digo
// Entre 30 e 40 min criar conexao com banco
function TEnderecamentoZonaDao.GetZona4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;

begin
  Result := TJsonObject.Create();

  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.SQL.Add
    ('select Z.*, ET.Descricao EstoqueTipo from EnderecamentoZonas Z');
  QryPesquisa.SQL.Add
    ('Inner join EstoqueTipo ET On ET.Id = Z.EstoqueTipoId where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add
    ('Select Count(ZonaId) cReg From EnderecamentoZonas where 1=1');
  if AParams.ContainsKey('zonaid') then
  begin
    QryPesquisa.SQL.Add('and ZonaId = :ZonaId');
    QryPesquisa.ParamByName('ZonaId').AsString := AParams.Items['zonaid'];
    QryRecordCount.SQL.Add('and ZonaId = :ZonaId');
    QryRecordCount.ParamByName('ZonaId').AsString := AParams.Items['zonaid'];
  end;
  if AParams.ContainsKey('descricao') then
  begin
    QryPesquisa.SQL.Add('and Z.Descricao Like :descricao');
    QryPesquisa.ParamByName('Descricao').AsString := '%' + AParams.Items
      ['descricao'] + '%';
    QryRecordCount.SQL.Add('and Descricao like :Descricao');
    QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items
      ['descricao'] + '%';
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
  QryPesquisa.SQL.Add('order by Z.Descricao');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.toJsonArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  
  
end;

function TEnderecamentoZonaDao.GetZonaPicking(pZonaId, pPickingFixo, pDisponivel: Integer): TjSonArray;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutconst.SqlZonaPicking);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pPickingFixo').Value := pPickingFixo;
    FConexao.Query.ParamByName('pDisponivel').Value := pDisponivel;
    if DebugHook <> 0 then
       FConexao.Query.sql.SaveToFile('ZonaPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutconst.QrySemDados));
    End
    Else
      Result := FConexao.Query.toJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Zonas - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecamentoZonaDao.GetZonas(Const AParams: TDictionary<string, string>) : TJsonArray;
begin
  try
    FConexao.Query.SQL.Add('select Ez.ZonaId, Ez.Descricao, Ez.EstruturaId, Ez.EstoqueTipoId, Et.Descricao EstoqueTipo, Ez.Status, ');
    FConexao.Query.SQL.Add('      Ez.RastroId, R.Descricao Rastro, Ez.LoteReposicao, Ez.SeparacaoConsolidada, Ez.Sigla, Ez.pickingdinamico, Ez.TagVolumeOrdem, Ez.ProdutoSNGPC');
    FConexao.Query.SQL.Add('From EnderecamentoZonas EZ');
    FConexao.Query.SQL.Add('Inner join EstoqueTipo ET ON Et.Id = Ez.EstoqueTipoId');
    FConexao.Query.SQL.Add('Inner join RastroTipo R ON R.RastroId = Ez.RastroId');
    FConexao.Query.Sql.Add('Where 1 = 1');
    If AParams.ContainsKey('estruturaid') then
       FConexao.Query.Sql.Add('  And EstruturaId = '+AParams.Items['estruturaid']);
    If AParams.ContainsKey('zonaid') then
       FConexao.Query.Sql.Add('  And ZonaId = '+AParams.Items['zonaid']);
    If AParams.ContainsKey('descricao') then
       FConexao.Query.Sql.Add('  And descricao like '+'%'+AParams.Items['descricao']+'%');
    If AParams.ContainsKey('pickingdinamico') then
       FConexao.Query.Sql.Add('  And pickingdinamico = '+AParams.Items['pickingdinamico']);
    if DebugHook <> 0 then
       FConexao.Query.sql.SaveToFile('GetZona.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create();
       Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutconst.QrySemDados));
    End
    Else
       Result := FConexao.Query.toJsonArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Zonas - ' + StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
            '', [rfReplaceAll]));
    End;
  end;

end;

function TEnderecamentoZonaDao.InsertUpdate(pJsonEnderecamentoZona: TJsonObject) : TjSonArray;
var  vSql: String;
begin
  try
    if pJsonEnderecamentoZona.GetValue<Integer>('zonaId') = 0 then
      vSql := 'Insert Into EnderecamentoZonas (Descricao, EstruturaId, '+sLineBreak+
              'EstoqueTipoId, RastroId, LoteReposicao, SeparacaoConsolidada, ProdutoSNGPC, Sigla, PickingDinamico, TagVolumeOrdem, Status) Values ('+sLineBreak+
              QuotedStr(pJsonEnderecamentoZona.GetValue<String>('descricao')) + ', '+sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('estruturaId').ToString()+', '+sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('estoqueTipoId').ToString()+', '+sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('rastroId').ToString()+', ' +sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('loteReposicao').ToString()+', '+sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('separacaoConsolidada').ToString()+', '+
              pJsonEnderecamentoZona.GetValue<Integer>('produtoSNGPC').ToString()+', '+sLineBreak+
              QuotedStr(pJsonEnderecamentoZona.GetValue<String>('sigla'))+', '+sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('pickingdinamico', 0).ToString()+', '+sLineBreak+
              pJsonEnderecamentoZona.GetValue<Integer>('tagVolumeOrdem', 0).ToString()+', 1)'
    Else
      vSql := 'Update EnderecamentoZonas '+sLineBreak+
              '   Set Descricao       = '+QuotedStr(pJsonEnderecamentoZona.GetValue<String>('descricao'))+sLineBreak+
              '     , EstruturaId     = '+ pJsonEnderecamentoZona.GetValue<Integer>('estruturaId').ToString()+sLineBreak+
              '     , EstoqueTipoId   = '+ pJsonEnderecamentoZona.GetValue<Integer>('estoqueTipoId').ToString()+sLineBreak+
              '     , RastroId        = '+pJsonEnderecamentoZona.GetValue<Integer>('rastroId').ToString()+sLineBreak+
              '     , LoteReposicao   = ' + pJsonEnderecamentoZona.GetValue<Integer>('loteReposicao').ToString()+sLineBreak+
              '     , SeparacaoConsolidada = '+pJsonEnderecamentoZona.GetValue<Integer>('separacaoConsolidada').ToString()+sLineBreak+
              '     , ProdutoSNGPC    = '+pJsonEnderecamentoZona.GetValue<Integer>('produtoSNGPC').ToString()+sLineBreak+
              '     , Sigla           = '+QuotedStr(pJsonEnderecamentoZona.GetValue<String>('sigla'))+sLineBreak+
              '     , PickingDinamico = '+ pJsonEnderecamentoZona.GetValue<Integer>('pickingdinaminco', 0).ToString()+sLineBreak+
              '     , TagVolumeOrdem  = '+pJsonEnderecamentoZona.GetValue<Integer>('tagVolumeOrdem', 0).ToString()+sLineBreak+
              '     , Status          = ' + pJsonEnderecamentoZona.GetValue<Integer>('status').ToString()+sLineBreak+
              'where ZonaId = '+pJsonEnderecamentoZona.GetValue<Integer>('zonaId').ToString;
    FConexao.Query.Sql.Add(vSql);
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('ZonaSave.Sql');
    FConexao.Query.ExecSQL;
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(TUtil.TratarExcessao(E.Message));
  end;
end;

function TEnderecamentoZonaDao.MontarPaginacao: TJsonObject;
var vSql: String;
begin
  Result := TJsonObject.Create;
  try
    FConexao.Query.Open('Select Count(*) Paginacao From EnderecamentoZonas');
    Result.AddPair('paginacao', TJsonNumber.Create(FConexao.Query.FieldByName('Paginacao')
      .AsInteger));
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', E.Message);

    End;
  end;
end;

end.
