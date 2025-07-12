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
var vSql: String;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    try
      vSql := 'Delete from EnderecamentoZonas where ZonaId = ' + pZonaId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      raise Exception.Create(E.Message);
    end;
  Finally
    Query.Free;
  End;
end;

destructor TEnderecamentoZonaDao.destroy;
begin

  inherited;
end;

function TEnderecamentoZonaDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Result := TJsonArray.Create;
  Try
    Query.Connection := Connection;
    Try
      Result := TjSonArray.Create;
      Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak+
                 'FROM INFORMATION_SCHEMA.COLUMNS'+sLineBreak+
                 'Where TABLE_NAME = ' + QuotedStr('EnderecamentoZonas') +'-- and CHARACTER_MAXIMUM_LENGTH Is Not Null');
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
    Except On E: Exception do
      Raise Exception.Create(E.Message);
    End;
  Finally
    Query.Free;
  End;
end;

function TEnderecamentoZonaDao.GetDescricao(pDescricao: String): TjSonArray;
var vSql: String;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select * from EnderecamentoZonas where Descricao like ' + QuotedStr('%' + pDescricao + '%');
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception Do
      raise Exception.Create(E.Message);
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecamentoZonaDao.GetId(pZonaId: Integer): TjSonArray;
var vSql: String;
    JsonZona, JsonEstoqueTipo, JsonRastro: TJsonObject;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select Ez.ZonaId, Ez.Descricao, Ez.EstruturaId, Ez.EstoqueTipoId, Et.Descricao EstoqueTipo, Ez.Status, '+sLineBreak +
              '      Ez.RastroId, R.Descricao Rastro, Ez.LoteReposicao, Ez.SeparacaoConsolidada, Ez.Sigla, Ez.pickingdinamico, Ez.TagVolumeOrdem, '+sLineBreak +
              '      Ez.ProdutoSNGPC, Ez.Auditavel, EE.Descricao Estrutura'+sLineBreak+
              'From EnderecamentoZonas EZ' + sLineBreak +
              'Inner join EstoqueTipo ET ON Et.Id = Ez.EstoqueTipoId' + sLineBreak +
              'Inner join RastroTipo R ON R.RastroId = Ez.RastroId'+sLineBreak+
              'Inner join EnderecamentoEstruturas EE On EE.EstruturaId = Ez.Estruturaid';
      if pZonaId <> 0 then
         vSql := vSql + sLineBreak + 'where ZonaId = ' + pZonaId.ToString;
      Query.Open(vSql);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('EnderecamentoZonas.Sql');
      Result := TjSonArray.Create;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      Else
        While Not Query.Eof do Begin
          JsonZona := TJsonObject.Create;
          JsonZona.AddPair('zonaid', TJsonNumber.Create(Query.FieldByName('ZonaId').AsInteger));
          JsonZona.AddPair('descricao', Query.FieldByName('Descricao').AsString);
          JsonZona.AddPair('estruturaid', Query.FieldByName('EstruturaId').AsString);
          JsonZona.AddPair('estrutura', Query.FieldByName('Estrutura').AsString);
          JsonZona.AddPair('estoquetipoid', TJsonNumber.Create(Query.FieldByName('EstoqueTipoId').AsInteger));
          JsonEstoqueTipo := TJsonObject.Create;
          JsonEstoqueTipo.AddPair('estoquetipoid', TJsonNumber.Create(Query.FieldByName('EstoqueTipoId').AsInteger));
          JsonEstoqueTipo.AddPair('descricao', Query.FieldByName('EstoqueTipo').AsString);
          JsonRastro := TJsonObject.Create;
          JsonRastro.AddPair('rastroid', TJsonNumber.Create(Query.FieldByName('RastroId').AsInteger));
          JsonRastro.AddPair('descricao', Query.FieldByName('Rastro').AsString);
          JsonZona.AddPair('estoquetipo', JsonEstoqueTipo);
          JsonZona.AddPair('rastro', JsonRastro);
          JsonZona.AddPair('lotereposicao', TJsonNumber.Create(Query.FieldByName('LoteReposicao').AsString));
          JsonZona.AddPair('separacaoconsolidada', TJsonNumber.Create(Query.FieldByName('SeparacaoConsolidada').AsString));
          JsonZona.AddPair('produtosngpc', TJsonNumber.Create(Query.FieldByName('ProdutoSNGPC').AsString));
          JsonZona.AddPair('sigla',Query.FieldByName('sigla').AsString);
          JsonZona.AddPair('pickingdinamico',TJsonNumber.Create(Query.FieldByName('PickingDinamico').AsInteger));
          JsonZona.AddPair('tagvolumeordem',TJsonNumber.Create(Query.FieldByName('TagVolumeOrdem').AsInteger));
          JsonZona.AddPair('auditavel',TJsonNumber.Create(Query.FieldByName('Auditavel').AsInteger));
          JsonZona.AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
          Result.AddElement(JsonZona);
          Query.Next;
        End;
    Except On E: Exception do
      raise Exception.Create(TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

// https://www.youtube.com/watch?v=emtAWD8XHmQ&ab_channel=AcademiadoC%C3%B3digo
// Entre 30 e 40 min criar conexao com banco
function TEnderecamentoZonaDao.GetZona4D(const AParams : TDictionary<string, string>): TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  Try
    Try
      QryPesquisa := TFdQuery.Create(Nil);
      QryPesquisa.Connection := connection;
      QryPesquisa.SQL.Add('select Z.*, ET.Descricao EstoqueTipo from EnderecamentoZonas Z');
      QryPesquisa.SQL.Add('Inner join EstoqueTipo ET On ET.Id = Z.EstoqueTipoId where 1 = 1');
      QryRecordCount := TFdQuery.Create(Nil);
      QryRecordCount.Connection := Connection;
      QryRecordCount.SQL.Add('Select Count(ZonaId) cReg From EnderecamentoZonas where 1=1');
      if AParams.ContainsKey('zonaid') then begin
         QryPesquisa.SQL.Add('and ZonaId = :ZonaId');
         QryPesquisa.ParamByName('ZonaId').AsString := AParams.Items['zonaid'];
         QryRecordCount.SQL.Add('and ZonaId = :ZonaId');
         QryRecordCount.ParamByName('ZonaId').AsString := AParams.Items['zonaid'];
      end;
      if AParams.ContainsKey('descricao') then begin
         QryPesquisa.SQL.Add('and Z.Descricao Like :descricao');
         QryPesquisa.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'] + '%';
         QryRecordCount.SQL.Add('and Descricao like :Descricao');
         QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'] + '%';
      end;
      if AParams.ContainsKey('limit') then begin
         QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
         QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
      end;
      if AParams.ContainsKey('offset') then
         QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
      QryPesquisa.SQL.Add('order by Z.Descricao');
      QryPesquisa.Open();
      Result.AddPair('data', QryPesquisa.toJsonArray());
      QryRecordCount.Open();
      Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
      QryPesquisa.Close;
      QryRecordCount.Close;
    Except On E: Exception do
      raise Exception.Create(TUtil.TratarExcessao(E.Message));
    end;
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TEnderecamentoZonaDao.GetZonaPicking(pZonaId, pPickingFixo, pDisponivel: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutconst.SqlZonaPicking);
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pPickingFixo').Value := pPickingFixo;
      Query.ParamByName('pDisponivel').Value := pDisponivel;
      if DebugHook <> 0 then
         Query.sql.SaveToFile('ZonaPicking.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutconst.QrySemDados));
      End
      Else
         Result := Query.toJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Zonas - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  finally
    Query.Free;
  end;
end;

function TEnderecamentoZonaDao.GetZonas(Const AParams: TDictionary<string, string>) : TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    try
      Query.SQL.Add('select Ez.ZonaId, Ez.Descricao, Ez.EstruturaId, Ez.EstoqueTipoId, Et.Descricao EstoqueTipo, Ez.Status, ');
      Query.SQL.Add('       Ez.RastroId, R.Descricao Rastro, Ez.LoteReposicao, Ez.SeparacaoConsolidada, Ez.Sigla, Ez.pickingdinamico, ');
      Query.SQL.Add('       Ez.TagVolumeOrdem, Ez.ProdutoSNGPC, Ez.Auditavel, EE.Descricao Estrutura');
      Query.SQL.Add('From EnderecamentoZonas EZ');
      Query.SQL.Add('Inner join EstoqueTipo ET ON Et.Id = Ez.EstoqueTipoId');
      Query.SQL.Add('Inner join RastroTipo R ON R.RastroId = Ez.RastroId');
      Query.SQL.Add('Inner Join EnderecamentoEstruturas EE On EE.EstruturaId = Ez.EstruturaId');
      Query.Sql.Add('Where 1 = 1');
      If AParams.ContainsKey('estruturaid') then
         Query.Sql.Add('  And Ez.EstruturaId = '+AParams.Items['estruturaid']);
      If AParams.ContainsKey('zonaid') then
         Query.Sql.Add('  And Ez.ZonaId = '+AParams.Items['zonaid']);
      If AParams.ContainsKey('descricao') then
         Query.Sql.Add('  And Ez.descricao like '+'%'+AParams.Items['descricao']+'%');
      If AParams.ContainsKey('pickingdinamico') then
         Query.Sql.Add('  And Ez.pickingdinamico = '+AParams.Items['pickingdinamico']);
      if DebugHook <> 0 then
         Query.sql.SaveToFile('GetZona.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutconst.QrySemDados));
      End
      Else
         Result := Query.toJsonArray;
    Except ON E: Exception do
      raise Exception.Create('Tabela: Zonas - ' + TUtil.TratarExcessao(E.Message));
    end;
  finally
    Query.Free;
  end;
end;

function TEnderecamentoZonaDao.InsertUpdate(pJsonEnderecamentoZona: TJsonObject) : TjSonArray;
var  vSql: String;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    try
      if pJsonEnderecamentoZona.GetValue<Integer>('zonaId') = 0 then
         vSql := 'Insert Into EnderecamentoZonas (Descricao, EstruturaId, '+sLineBreak+
                 'EstoqueTipoId, RastroId, LoteReposicao, SeparacaoConsolidada, ProdutoSNGPC, Sigla, PickingDinamico, TagVolumeOrdem, Auditavel, Status) Values ('+sLineBreak+
                 QuotedStr(pJsonEnderecamentoZona.GetValue<String>('descricao')) + ', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('estruturaId').ToString()+', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('estoqueTipoId').ToString()+', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('rastroId').ToString()+', ' +sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('loteReposicao').ToString()+', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('separacaoConsolidada').ToString()+', '+
                 pJsonEnderecamentoZona.GetValue<Integer>('produtoSNGPC').ToString()+', '+sLineBreak+
                 QuotedStr(pJsonEnderecamentoZona.GetValue<String>('sigla'))+', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('pickingdinamico', 0).ToString()+', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('tagVolumeOrdem', 0).ToString()+', '+sLineBreak+
                 pJsonEnderecamentoZona.GetValue<Integer>('auditavel', 0).ToString()+', 1)'
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
                 '     , Auditavel       = '+pJsonEnderecamentoZona.GetValue<Integer>('auditavel', 0).ToString()+sLineBreak+
                 '     , Status          = ' + pJsonEnderecamentoZona.GetValue<Integer>('status').ToString()+sLineBreak+
                 'where ZonaId = '+pJsonEnderecamentoZona.GetValue<Integer>('zonaId').ToString;
      Query.Sql.Add(vSql);
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('ZonaSave.Sql');
      Query.ExecSQL;
      Result := Query.toJsonArray;
    Except On E: Exception do
      raise Exception.Create(TUtil.TratarExcessao(E.Message));
    end;
  finally
    Query.Free;
  end;
end;

function TEnderecamentoZonaDao.MontarPaginacao: TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    try
      Query.Open('Select Count(*) Paginacao From EnderecamentoZonas');
      Result.AddPair('paginacao', TJsonNumber.Create(Query.FieldByName('Paginacao').AsInteger));
    Except On E: Exception do
      Begin
        Result.AddPair('Erro', TUtil.TratarExcessao(E.Message));
      End;
    end;
  finally
    Query.Free;
  end;
end;

end.
