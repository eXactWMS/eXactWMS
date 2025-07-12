unit MService.EnderecoDAO;

interface

uses
  FireDAC.Comp.Client, EnderecoClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.utils,
  System.JSON, REST.JSON, System.Generics.Collections, Constants,
  FireDAC.Stan.Option, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlEndereco = 'Select * From vEnderecamentos';

type
  TEnderecoDao = class(TBasicDao)
  private

    ObjEnderecoDAO: TEndereco;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pJsonEndereco: TJsonObject): TjSonArray;
    function GetId(pEnderecoId: String): TjSonArray;
    function GetEndereco4D(const AParams: TDictionary<string, string>) : TJsonObject;
    Function GetLista(pEnderecoId: Integer; pEstruturaId: Integer; pZonaId: Integer; pRuaId: Integer; pEnderecoIni: String;
             pEnderecoFin, pOcupacaoEndereco: String; pStatus: Integer; pBloqueado : Integer; pListaZona: String; pCurva: String; pBuscaParcial, pLimit, pOffSet : Integer): TjSonArray;
    Function GetListaRecordCount(pEnderecoId: Integer; pEstruturaId: Integer; pZonaId: Integer; pRuaId: Integer; pEnderecoIni: String;
             pEnderecoFin, pOcupacaoEndereco: String; pStatus: Integer; pBloqueado : Integer; pListaZona: String; pCurva: String; pBuscaParcial, pLimit, pOffSet : Integer): Integer;
    Function GetEnderecoToReposicao(pZonaId: Integer; pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
             pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String; pPredioParImpar: Integer; pNivelInicial,
             pNivelFinal: String; pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String; pAptoParImpar: Integer): TjSonArray;
    function GetEstrutura(pEstruturaId: Integer): TjSonArray;
    Function GetPickingMask: TjSonArray;
    Function GetReUsoPicking(pZonaId, pDias: Integer): TjSonArray;
    function GetZona(pEstruturaId: Integer): TjSonArray;
    Function Delete(pEnderecoId: Integer): Boolean;
    Function EnderecoBloquear(ArrayEndereco: TjSonArray): TjSonArray;
    Function EnderecoBloqueioDeUso(ArrayEndereco: TjSonArray): TjSonArray;
    Function MontarPaginacao: TJsonObject;
    Function PutDesvincularPicking(pJsonArray: TjSonArray): TjSonArray;
    Function Estrutura: TjSonArray;
    Function ExportFile(const AParams: TDictionary<string, string>): TjSonArray;
    Function GetEnderecoOcupacao(const AParams: TDictionary<string, string>) :TjsonArray;
    Function Manutencao(pJsonManutencao: TJsonObject): TJsonObject;
    Function GetMotivoMovimentacaoSegregado: TjSonArray;
    Function GetEnderecoModelo(const AParams: TDictionary<string, string>) : TJsonArray;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TEnderecoDao.Create;
begin
  inherited;
  ObjEnderecoDAO := TEndereco.Create;
end;

destructor TEnderecoDao.Destroy;
begin
  
  ObjEnderecoDAO.Free;
  inherited;
end;

function TEnderecoDao.Delete(pEnderecoId: Integer): Boolean;
var vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Enderecamentos where EnderecoId = ' +
      pEnderecoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

//Inicialmente criado para Inativar Endereço
function TEnderecoDao.EnderecoBloquear(ArrayEndereco: TjSonArray): TjSonArray;
Var xEndereco: Integer;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Update Enderecamentos Set Status = 0');
    FConexao.Query.Sql.Add('Where EnderecoId = :EnderecoId');
    for xEndereco := 0 to ArrayEndereco.Count - 1 do Begin
      FConexao.Query.ParamByName('EnderecoId').Value := ArrayEndereco.Get(xEndereco).GetValue<Integer>('enderecoid', 0);
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Endereço bloqueado com sucesso!'));
  Except ON E: Exception do
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamentos - ' +
             StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.EnderecoBloqueioDeUso( ArrayEndereco: TjSonArray): TjSonArray;
Var
  xEndereco: Integer;
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Update Enderecamentos Set Bloqueado = :pBloqueio');
    FConexao.Query.Sql.Add('Where EnderecoId = :pEnderecoId');
    FConexao.Query.connection.StartTransaction;
    for xEndereco := 0 to ArrayEndereco.Count - 1 do Begin
      FConexao.Query.ParamByName('pEnderecoId').Value := ArrayEndereco.Get(xEndereco).GetValue<Integer>('enderecoid', 0);
      FConexao.Query.ParamByName('pBloqueio').Value   := ArrayEndereco.Get(xEndereco).GetValue<Integer>('bloqueio', 0);
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
  Except ON E: Exception do
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamentos - ' +
             StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('vEnderecamentos') +
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

function TEnderecoDao.ExportFile(const AParams: TDictionary<string, string>)
  : TjSonArray;
var
  vSql, pCampos: String;
begin
  try
    if AParams.ContainsKey('campos') then
      pCampos := AParams.Items['campos']
    else
      pCampos := 'Descricao, PickingFixo';
    vSql := 'Select ' + pCampos + ' ' + sLineBreak + 'From vEnderecamentos';
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não foram encontrados dados da pesquisa.')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;

end;

function TEnderecoDao.GetEstrutura(pEstruturaId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEndereco;
    vSql := vSql + #13 + #10 + ' where EstruturaId = ' +pEstruturaId.ToString();
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      With ObjEnderecoDAO do
      Begin
        EnderecoId                    := FConexao.Query.FieldByName('EnderecoId').AsInteger;
        EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId').AsInteger;
        EnderecoEstrutura.Descricao   := FConexao.Query.FieldByName('Estrutura').AsString;
        EnderecamentoZona.ZonaId      := FConexao.Query.FieldByName('ZonaId').AsInteger;
        EnderecamentoZona.Descricao   := FConexao.Query.FieldByName('Zona').AsString;
        Descricao                     := FConexao.Query.FieldByName('Endereco').AsString;
        DesenhoArmazem.Id              := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        Altura      := FConexao.Query.FieldByName('Altura').AsFloat;
        largura     := FConexao.Query.FieldByName('Largura').AsFloat;
        Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        Volume      := FConexao.Query.FieldByName('Volume').AsFloat;
        Capacidade  := FConexao.Query.FieldByName('Capacidade').AsFloat;
        Curva       := FConexao.Query.FieldByName('Curva').AsString;
        Status      := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
        FConexao.Query.Next;
      End;
    end;
  Except ON E: Exception do
    Begin
      Result.AddElement( TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamentos - '+TUtil.TratarExcessao(E.Message)) );
    End;
  end;
end;

function TEnderecoDao.GetId(pEnderecoId: String): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEndereco;
    if pEnderecoId <> '0' then
      vSql := vSql + #13 + #10 + 'Where (Cast(EnderecoId as varchar(20)) = ' +
        QuotedStr(pEnderecoId) + ') or (Endereco = ' +
        QuotedStr(pEnderecoId) + ')';
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      With ObjEnderecoDAO do
      Begin
        EnderecoId                    := FConexao.Query.FieldByName('EnderecoId').AsInteger;
        EnderecoRua.RuaId             := FConexao.Query.FieldByName('ruaid').AsInteger;
        EnderecoRua.Descricao         := FConexao.Query.FieldByName('Rua').AsString;
        EnderecoRua.Lado              := FConexao.Query.FieldByName('Lado').AsString;
        EnderecoRua.Ordem             := FConexao.Query.FieldByName('Ordem').AsInteger;
        EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId').AsInteger;
        EnderecoEstrutura.Descricao   := FConexao.Query.FieldByName('Estrutura').AsString;
        EnderecoEstrutura.PickingFixo := FConexao.Query.FieldByName('PickingFixo').AsInteger;
        EnderecoEstrutura.Mascara     := FConexao.Query.FieldByName('Mascara').AsString;
        EnderecamentoZona.ZonaId      := FConexao.Query.FieldByName('ZonaId').AsInteger;
        EnderecamentoZona.Descricao   := FConexao.Query.FieldByName('Zona').AsString;
        Descricao          := FConexao.Query.FieldByName('Endereco').AsString;
        DesenhoArmazem.Id  := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        Altura             := FConexao.Query.FieldByName('Altura').AsFloat;
        largura            := FConexao.Query.FieldByName('Largura').AsFloat;
        Comprimento        := FConexao.Query.FieldByName('Comprimento').AsFloat;
        Volume             := FConexao.Query.FieldByName('Volume').AsFloat;
        Capacidade         := FConexao.Query.FieldByName('Capacidade').AsFloat;
        Curva              := FConexao.Query.FieldByName('Curva').AsString;
        Status             := FConexao.Query.FieldByName('Status').AsInteger;
        Bloqueado          := FConexao.Query.FieldByName('Bloqueado').AsInteger;
        Bloqueioinventario := FConexao.Query.FieldByName('BloqueioInventario').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
        FConexao.Query.Next;
      End;
    end;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamentos - ' +TUtil.tratarExcessao(E.Message) ));
    End;
  end;
end;

function TEnderecoDao.GetEndereco4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.Sql.Add('select EnderecoId, Endereco, Estrutura, Rua, Lado, Zona, Status, Curva');
  QryPesquisa.Sql.Add('From vEnderecamentos where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.Sql.Add('Select Count(EnderecoId) cReg From vEnderecamentos where 1=1');
  if AParams.ContainsKey('endereco') then begin
     QryPesquisa.Sql.Add('and Endereco = :Endereco');
     QryPesquisa.ParamByName('Endereco').AsString := AParams.Items['endereco'];
     QryRecordCount.Sql.Add('and Endereco = :Endereco');
     QryRecordCount.ParamByName('Endereco').AsString := AParams.Items['endereco'];
  end;
  if AParams.ContainsKey('zona') then begin
     QryPesquisa.Sql.Add('and zona Like :zona');
     QryPesquisa.ParamByName('zona').AsString := '%' + AParams.Items['zona'].ToUpper + '%';
     QryRecordCount.Sql.Add('and zona like :zona');
     QryRecordCount.ParamByName('zona').AsString := '%' + AParams.Items['zona'].ToUpper + '%';
  end;
  if AParams.ContainsKey('curva') then begin
     QryPesquisa.Sql.Add('and curva = :curva');
     QryPesquisa.ParamByName('curva').AsString := AParams.Items['curva'].ToUpper;
     QryRecordCount.Sql.Add('and curva = :curva');
     QryRecordCount.ParamByName('curva').AsString := AParams.Items['curva'].ToUpper;
  end;
  if AParams.ContainsKey('limit') then begin
     QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
     QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
     QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
  QryPesquisa.Sql.Add('order by Endereco');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.ToJSONArray());
  QryRecordCount.Open();
  Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  QryPesquisa.Close;
  QryRecordCount.Close;
end;

function TEnderecoDao.GetEnderecoModelo(const AParams: TDictionary<string, string>): TJsonArray;
begin
//Levar Codigo para Constants e substituir a Const aqui em em InventarioDAO - GerarNovoInventarioModelo
  Try
    FConexao.Query.Sql.Add('Declare @EstruturaId Integer         = :pEstruturaId');
    FConexao.Query.Sql.Add('Declare @ZonaId      Integer         = :pZonaId');
    FConexao.Query.Sql.Add('Declare @EnderecoInicial Varchar(11) = :pEnderecoInicial');
    FConexao.Query.Sql.Add('Declare @EnderecoFinal Varchar(11)   = :pEnderecoFinal');
    FConexao.Query.Sql.Add('Declare @RuaInicial Varchar(2)       = :pRuaInicial');
    FConexao.Query.Sql.Add('Declare @RuaFinal Varchar(2)         = :pRuaFinal');
    FConexao.Query.Sql.Add('Declare @RuaPar Integer              = :pRuaPar');
    FConexao.Query.Sql.Add('Declare @RuaImpar Integer            = :pRuaImpar');
    FConexao.Query.Sql.Add('Declare @PredioInicial Varchar(2)    = :pPredioInicial');
    FConexao.Query.Sql.Add('Declare @PredioFinal Varchar(2)      = :pPredioFinal');
    FConexao.Query.Sql.Add('Declare @PredioPar Integer           = :pPredioPar');
    FConexao.Query.Sql.Add('Declare @PredioImpar Integer         = :pPredioImpar');
    FConexao.Query.Sql.Add('Declare @NivelInicial Varchar(2)     = :pNivelInicial');
    FConexao.Query.Sql.Add('Declare @NivelFinal Varchar(2)       = :pNivelFinal');
    FConexao.Query.Sql.Add('Declare @NivelPar Integer            = :pNivelPar');
    FConexao.Query.Sql.Add('Declare @NivelImpar Integer          = :pNivelImpar');
    FConexao.Query.Sql.Add('Declare @AptoInicial Varchar(3)      = :pAptoInicial');
    FConexao.Query.Sql.Add('Declare @AptoFinal Varchar(3)        = :pAptoFinal');
    FConexao.Query.Sql.Add('Declare @AptoPar Integer             = :pAptoPar');
    FConexao.Query.Sql.Add('Declare @AptoImpar Integer           = :pAptoImpar');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select TEnd.EnderecoId, TEnd.Descricao Endereco, TEnd.RuaId, TEnd.ZonaID, Z.Descricao Zona, TEnd.Curva, TEnd.Status, TEnd.Bloqueado');
    FConexao.Query.SQL.Add('From Enderecamentos TEnd');
    FConexao.Query.SQL.Add('Join EnderecamentoZonas Z On Z.ZonaId = TEnd.ZonaId');
    FConexao.Query.SQL.Add('  ');
    FConexao.Query.SQL.Add('where (@EstruturaId = 0 or @EstruturaId = TEnd.EstruturaId)');
    FConexao.Query.SQL.Add('  And (@ZonaId = 0 or TEnd.ZonaID = @ZonaId)');
    FConexao.Query.SQL.Add('  And (@EnderecoInicial = '+#39+#39+' or SubString(TEnd.Descricao, 1, Len(@EnderecoInicial)) >= @EnderecoInicial)');
    FConexao.Query.SQL.Add('  And (@EnderecoFinal = '+#39+#39+' or SubString(TEnd.Descricao, 1, Len(@EnderecoFinal)) <= @EnderecoFinal)');
    FConexao.Query.SQL.Add('  And (@RuaInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) >= @RuaInicial)');
    FConexao.Query.SQL.Add('  And (@RuaFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) <= @RuaFinal)');
    FConexao.Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) % 2 = 0) and @Ruapar = 1) or');
    FConexao.Query.SQL.Add('       (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) % 2 = 1) and @RuaImpar = 1) )');
    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('  And (@PredioInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) >= @PredioInicial)');
    FConexao.Query.SQL.Add('  And (@PredioFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) <= @PredioFinal)');
    FConexao.Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) % 2 = 0) and @Prediopar = 1) or');
    FConexao.Query.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) % 2 = 1) and @PredioImpar = 1) )');
    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('  And (@NivelInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) >= @NivelInicial)');
    FConexao.Query.SQL.Add('  And (@NivelFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) <= @NivelFinal)');
    FConexao.Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) % 2 = 0) and @Nivelpar = 1) or');
    FConexao.Query.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) % 2 = 1) and @NivelImpar = 1 ) )');
    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('  And (@AptoInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) >= @AptoInicial)');
    FConexao.Query.SQL.Add('  And (@AptoFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) <= @AptoFinal)');
    FConexao.Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) % 2 = 0) and @Aptopar = 1) or');
    FConexao.Query.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) % 2 = 1) and @AptoImpar = 1) ) ');
    FConexao.Query.SQL.Add('  --And (IsNull(TEnd.Status, 0) = 1 and IsNull(TEnd.Bloqueado, 0) = 0)');
    FConexao.Query.SQL.Add('Order by TEnd.Descricao');
    If AParams.ContainsKey('estruturaid') then
       FConexao.Query.ParamByName('pEstruturaId').Value := AParams.Items['estruturaid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pEstruturaId').Value := 0;
    If AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pZonaId').Value := 0;
    If AParams.ContainsKey('enderecoinicial') then
       FConexao.Query.ParamByName('pEnderecoInicial').Value := AParams.Items['enderecoinicial']
    Else
       FConexao.Query.ParamByName('pEnderecoInicial').Value := '';
    If AParams.ContainsKey('enderecofinal') then
       FConexao.Query.ParamByName('pEnderecoFinal').Value := AParams.Items['enderecofinal']
    Else
       FConexao.Query.ParamByName('pEnderecoFinal').Value := '';
    If AParams.ContainsKey('ruainicial') then
       FConexao.Query.ParamByName('pRuaInicial').Value := AParams.Items['ruainicial']
    Else
       FConexao.Query.ParamByName('pRuaInicial').Value := '';
    If AParams.ContainsKey('ruafinal') then
       FConexao.Query.ParamByName('pRuaFinal').Value := AParams.Items['ruafinal']
    Else
       FConexao.Query.ParamByName('pRuaFinal').Value := '';
    If AParams.ContainsKey('ruapar') then
       FConexao.Query.ParamByName('pRuaPar').Value := AParams.Items['ruapar'].ToInteger
    Else
       FConexao.Query.ParamByName('pRuaPar').Value := 0;
    If AParams.ContainsKey('ruaimpar') then
       FConexao.Query.ParamByName('pRuaImpar').Value := AParams.Items['ruaimpar'].ToInteger()
    Else
       FConexao.Query.ParamByName('pRuaImpar').Value := 0;
    If AParams.ContainsKey('predioinicial') then
       FConexao.Query.ParamByName('pPredioInicial').Value := AParams.Items['predioinicial']
    Else
       FConexao.Query.ParamByName('pPredioInicial').Value := '';
    If AParams.ContainsKey('prediofinal') then
       FConexao.Query.ParamByName('pPredioFinal').Value := AParams.Items['prediofinal']
    Else
       FConexao.Query.ParamByName('pPredioFinal').Value := '';
    If AParams.ContainsKey('prediopar') then
       FConexao.Query.ParamByName('pPredioPar').Value := AParams.Items['prediopar'].ToInteger
    Else
       FConexao.Query.ParamByName('pPredioPar').Value := 0;
    If AParams.ContainsKey('predioimpar') then
       FConexao.Query.ParamByName('pPredioImpar').Value := AParams.Items['predioimpar'].ToInteger()
    Else
       FConexao.Query.ParamByName('ppredioimpar').Value := 0;

    If AParams.ContainsKey('nivelinicial') then
       FConexao.Query.ParamByName('pNivelInicial').Value := AParams.Items['nivelinicial']
    Else
       FConexao.Query.ParamByName('pNivelInicial').Value := '';
    If AParams.ContainsKey('nivelfinal') then
       FConexao.Query.ParamByName('pNivelFinal').Value := AParams.Items['nivelfinal']
    Else
       FConexao.Query.ParamByName('pNivelFinal').Value := '';
    If AParams.ContainsKey('nivelpar') then
       FConexao.Query.ParamByName('pNivelPar').Value := AParams.Items['nivelpar'].ToInteger
    Else
       FConexao.Query.ParamByName('pNivelPar').Value := 0;
    If AParams.ContainsKey('nivelimpar') then
       FConexao.Query.ParamByName('pNivelImpar').Value := AParams.Items['nivelimpar'].ToInteger()
    Else
       FConexao.Query.ParamByName('pnivelimpar').Value := 0;

    If AParams.ContainsKey('aptoinicial') then
       FConexao.Query.ParamByName('pAptoInicial').Value := AParams.Items['aptoinicial']
    Else
       FConexao.Query.ParamByName('pAptoInicial').Value := '';
    If AParams.ContainsKey('aptofinal') then
       FConexao.Query.ParamByName('pAptoFinal').Value := AParams.Items['aptofinal']
    Else
       FConexao.Query.ParamByName('pAptoFinal').Value := '';
    If AParams.ContainsKey('aptopar') then
       FConexao.Query.ParamByName('pAptoPar').Value := AParams.Items['aptopar'].ToInteger
    Else
       FConexao.Query.ParamByName('pAptoPar').Value := 0;
    If AParams.ContainsKey('aptoimpar') then
       FConexao.Query.ParamByName('pAptoImpar').Value := AParams.Items['aptoimpar'].ToInteger()
    Else
       FConexao.Query.ParamByName('pAptoImpar').Value := 0;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('GetEnderecoModelo.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não foi encontrado Endereço(s) para o modelo pré-definido.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' + Tutil.TratarExcessao(E.Message));
    End;
  end;
end;

function TEnderecoDao.GetEnderecoOcupacao(const AParams: TDictionary<string, string>): TjsonArray;
Var pLista : String;
Begin
  try
//    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEnderecoOcupacao);
    FConexao.Query.Sql.Add('Declare @VolumePadrao Int = (Select IsNull(PalletSizeStand, (120*120*100)) From Configuracao)');
    FConexao.Query.Sql.Add('If @VolumePadrao = 0');
    FConexao.Query.Sql.Add('   Set @VolumePadrao = (120*120*100)');
    FConexao.Query.Sql.Add('Declare @Bloqueado Int   = :pBloqueado');
    FConexao.Query.Sql.Add('--Declare @Zona Varchar    = :pZona');
    FConexao.Query.Sql.Add('if object_id ('+#39+'tempdb..#Endereco'+#39+') is not null drop table #Endereco');
    FConexao.Query.Sql.Add('if object_id ('+#39+'tempdb..#EstoqueVlm'+#39+') is not null drop table #EstoqueVlm');
    FConexao.Query.Sql.Add('select EnderecoId, Endereco, ZonaId, Zona, RuaId, Curva,');
    FConexao.Query.Sql.Add('       (Case When IsNull(Volume, 0) = 0 then @VolumePadrao Else Volume End) Volume,');
    FConexao.Query.Sql.Add('	   Capacidade Into #Endereco');
    FConexao.Query.Sql.Add('from venderecamentos');
    FConexao.Query.Sql.Add('where IsNull(Status, 0) = 1');
    FConexao.Query.Sql.Add('  And (@Bloqueado=1 or (@Bloqueado=0 and IsNull(Bloqueado, 0) = 0))');
    pLista := AParams.Items['zonaidlista'];
    If AParams.ContainsKey('zonaidlista') then
       FConexao.Query.Sql.Add('  And ZonaId in ('+AParams.Items['zonaidlista']+')')
    Else
       FConexao.Query.Sql.Add('  And ZonaId in (4, 5)');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('select Est.Enderecoid, sum(Qtde) Qtde, Sum(Est.Qtde*Volume) Volume Into #EstoqueVlm');
    FConexao.Query.Sql.Add('From Estoque Est');
    FConexao.Query.Sql.Add('inner join ProdutoLotes Pl on Pl.Loteid = Est.LoteId');
    FConexao.Query.Sql.Add('Inner join vProduto Prd ON Prd.IdProduto = Pl.ProdutoId');
    FConexao.Query.Sql.Add('Where Est.EstoqueTipoId in (1, 4)');
    FConexao.Query.Sql.Add('Group by Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('select TEnd.*, IsNull(Est.Qtde, 0) Estoque,');
    FConexao.Query.Sql.Add('       Isnull(Est.Volume, 0) VlmOcupado,');
    FConexao.Query.Sql.Add('	   Cast(Isnull(Est.Volume, 0)/TEnd.Volume*100 as Decimal(15,2)) as TxOcupacao');
    FConexao.Query.Sql.Add('From #Endereco TEnd');
    FConexao.Query.Sql.Add('left Join #EstoqueVlm Est on Est.EnderecoId = Tend.EnderecoId');
    FConexao.Query.Sql.Add('Order by ZOnaId, Endereco');
    If AParams.ContainsKey('bloqueado') then
       FConexao.Query.ParamByName('pBloqueado').Value := AParams.Items['bloqueado']
    Else
       FConexao.Query.ParamByName('pBloqueado').Value := 1;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('EnderecoOcupacao.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não foi encontrado Endereço(s) para análise.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.GetEnderecoToReposicao(pZonaId: Integer;
  pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
  pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String;
  pPredioParImpar: Integer; pNivelInicial, pNivelFinal: String;
  pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String;
  pAptoParImpar: Integer): TjSonArray;
begin
  try
    FConexao.Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
    FConexao.Query.Sql.Add('Declare @EnderecoIni VarChar(40)  = ' + #39 +pEnderecoIni + #39);
    FConexao.Query.Sql.Add('Declare @EnderecoFin VarChar(40)  = ' + #39 +pEnderecoFin + #39);
    FConexao.Query.Sql.Add('Declare @RuaInicial VarChar(2)    = ' + #39 +pRuaInicial + #39);
    FConexao.Query.Sql.Add('Declare @RuaFinal  VarChar(2)     = ' + #39 +pRuaFinal + #39);
    FConexao.Query.Sql.Add('Declare @RuaParImpar Integer      = ' +pRuaParImpar.ToString());
    FConexao.Query.Sql.Add('Declare @PredioInicial VarChar(2) = ' + #39 +pPredioInicial + #39);
    FConexao.Query.Sql.Add('Declare @PredioFinal   VarChar(2) = ' + #39 +pPredioFinal + #39);
    FConexao.Query.Sql.Add('Declare @PredioParImpar Integer   = ' +pPredioParImpar.ToString());
    FConexao.Query.Sql.Add('Declare @NivelInicial VarChar(2)  = ' + #39 +pNivelInicial + #39);
    FConexao.Query.Sql.Add('Declare @NivelFinal   VarChar(2)  = ' + #39 +pNivelFinal + #39);
    FConexao.Query.Sql.Add('Declare @NivelParImpar Integer    = ' +pNivelParImpar.ToString());
    FConexao.Query.Sql.Add('Declare @AptoInicial VarChar(2)   = ' + #39 +pAptoInicial + #39);
    FConexao.Query.Sql.Add('Declare @AptoFinal   VarChar(2)   = ' + #39 +pAptoFinal + #39);
    FConexao.Query.Sql.Add('Declare @AptoParImpar Integer     = ' +pAptoParImpar.ToString());
    FConexao.Query.Sql.Add('Select (select vEnd.enderecoid, vEnd.Endereco, vEnd.Mascara, vEnd.Descricao Produto,');
    FConexao.Query.Sql.Add('        Cast(vEnd.altura as Decimal(15,3)) altura,');
    FConexao.Query.Sql.Add('        Cast(vEnd.largura as Decimal(15,3)) largua,');
    FConexao.Query.Sql.Add('        Cast(vEnd.comprimento as Decimal(15,3)) comprimento,');
    FConexao.Query.Sql.Add('        Cast(vEnd.volume as Decimal(15,6)) volume,');
    FConexao.Query.Sql.Add('        Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
    FConexao.Query.Sql.Add('        vEnd.Zona, Coalesce(Est.Qtde, 0) as ' + #39 + 'qtde' +#39 + ', Coalesce(EstPulmao.Qtde, 0) as ' + #39 + 'qtdepulmao' + #39);
    FConexao.Query.Sql.Add('From vEnderecamentos vEnd');
    FConexao.Query.Sql.Add('Left Join (Select EnderecoId, Coalesce(Sum(Qtde), 0) Qtde From vEstoque Group By EnderecoId) Est ON Est.Enderecoid = vEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join (Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde');
    FConexao.Query.Sql.Add('From vEstoque Where EstruturaId <> 2');
    FConexao.Query.Sql.Add('Group By CodigoERP) EstPulmao ON EstPulmao.CodigoERP = vEnd.CodProduto');
    FConexao.Query.Sql.Add('Where (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
    FConexao.Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or Substring(vEnd.Endereco, 1, LEN( @EnderecoIni)) >= @EnderecoIni) and ');
    FConexao.Query.Sql.Add('      (@EnderecoFin = ' + #39 + #39+' or Substring(vEnd.Endereco, 1, LEN( @EnderecoFin)) <= @EnderecoFin) and ');
    FConexao.Query.Sql.Add('      (@RuaInicial  = ' + #39 + #39+' or SubString(vEnd.Endereco,1,2) >= @RuaInicial) and');
    FConexao.Query.Sql.Add('      (@RuaFinal    = ' + #39 + #39+' or SubString(vEnd.Endereco,1,2) <= @RuaFinal) and');
    FConexao.Query.Sql.Add('      (@RuaParImpar = 2 or (@RuaParImpar=0 and SubString(vEnd.Endereco,1,2) % 2 = 0) or ');
    FConexao.Query.Sql.Add('                           (@RuaParImpar=1 and SubString(vEnd.Endereco,1,2) % 2 = 1) ) and');
    FConexao.Query.Sql.Add('      (vEnd.EstruturaId=2 and vEnd.Status = 1 and IsNull(vEnd.Bloqueado, 0) = 0)');
    FConexao.Query.Sql.Add('Order by vEnd.Endereco'); // by RuaId, Lado, Endereco');
    FConexao.Query.Sql.Add('For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno');
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('RelEnderecoToReposicao.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('ConsultaRetorno').AsString = '') Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Endereço não encontrado.'));
    End
    Else
       Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno').AsString), 0) as TjSonArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.GetLista(pEnderecoId, pEstruturaId, pZonaId: Integer;
  pRuaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus: Integer; pBloqueado : Integer; pListaZona: String; pCurva: String; pBuscaParcial, pLimit, pOffSet : Integer): TjSonArray;
begin
  try
    FConexao.Query.Sql.Add('Declare @EnderecoId Integer = ' + pEnderecoId.ToString());
    FConexao.Query.Sql.Add('Declare @EstruturaId Integer = ' + pEstruturaId.ToString());
    FConexao.Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
    FConexao.Query.Sql.Add('Declare @Ruaid Integer  = ' + pRuaId.ToString());
    FConexao.Query.Sql.Add('Declare @EnderecoIni VarChar(40) = ' + #39 +pEnderecoIni + #39);
    FConexao.Query.Sql.Add('Declare @EnderecoFin VarChar(40) = ' + #39 +pEnderecoFin + #39);
    FConexao.Query.Sql.Add('Declare @OcupacaoEndereco Varchar(1) = ' + #39 +pOcupacaoEndereco + #39);
    FConexao.Query.Sql.Add('Declare @Curva Varchar(30)           = ' + #39 +pCurva + #39);
    FConexao.Query.Sql.Add('Declare @Status Integer = ' + pStatus.ToString());
    FConexao.Query.Sql.Add('Declare @Bloqueado Integer = ' + pBloqueado.ToString());
    FConexao.Query.Sql.Add('select vEnd.enderecoid, vEnd.Endereco descricao, Cast(vEnd.altura as Decimal(15,3)) altura, Cast(vEnd.largura as Decimal(15,3)) largura,');
    FConexao.Query.Sql.Add('                    Cast(vEnd.comprimento as Decimal(15,3)) comprimento, Cast(vEnd.volume as Decimal(20,6)) volume, Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
    FConexao.Query.Sql.Add('                    vEnd.status, vEnd.bloqueado, vEnd.bloqueioinventario, vEnd.EstruturaId, vEnd.estrutura, vEnd.PickingFixo, vEnd.Mascara,');
    FConexao.Query.Sql.Add('                    vEnd.Ruaid, vEnd.Rua, vEnd.Lado, vEnd.Ordem, vEnd.ZonaId, vEnd.Zona, vEnd.EstoqueTipoId, vEnd.ZonaStatus, vEnd.produtosngpc,');
    FConexao.Query.Sql.Add('                    vEnd.DesenhoArmazemId, vEnd.DesenhoArmazemDescricao, Coalesce(vEnd.produtoid, 0) ProdutoId, Coalesce(vEnd.codproduto, 0) CodProduto,');
    FConexao.Query.Sql.Add('                    Coalesce(vEnd.descricao, '+#39+#39+') Produto, (Case When vEnd.Curva is Null then '+#39+#39+' Else vEnd.Curva End) Curva, 0 as Ocupacao Into #Endereco');
    FConexao.Query.Sql.Add('From vEnderecamentos vEnd');
    FConexao.Query.Sql.Add('Where (@EnderecoId = 0 or vEnd.EnderecoId = @EnderecoId) and');
    FConexao.Query.Sql.Add('      (@EstruturaId = 0 or vEnd.EstruturaId = @EstruturaId) and');
    FConexao.Query.Sql.Add('      (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
    If pListaZona <> '' Then
       FConexao.Query.Sql.Add('      (vEnd.Zonaid in ('+pListaZona+')) and ');
    FConexao.Query.Sql.Add('      (@RuaId  = 0 or vEnd.RuaId  = @RuaId) and');
    FConexao.Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
    FConexao.Query.Sql.Add('      (@EnderecoFin = '#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin) and');
    FConexao.Query.Sql.Add('      ((@OcupacaoEndereco = '+#39+'T'+#39+') or (@OcupacaoEndereco='+#39+'L'+#39+' and vEnd.ProdutoId Is Null) or');
    FConexao.Query.Sql.Add('      (@OcupacaoEndereco='+#39+'O'+#39+' and vEnd.ProdutoId is Not Null)) And');
    FConexao.Query.Sql.Add('      (@Curva = '+#39+#39+' or vEnd.Curva = @Curva) and');
    FConexao.Query.Sql.Add('      (@Status Not In (0,1) or (@Status = Status)) and');
    FConexao.Query.Sql.Add('      (@Bloqueado <> 1 or (@Bloqueado = vEnd.Bloqueado)) and');
    If pBuscaParcial = 0 then Begin
       FConexao.Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or vEnd.Endereco >= @EnderecoIni) and');
       FConexao.Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or vEnd.Endereco <= @EnderecoFin)');
    End
    Else Begin
       FConexao.Query.Sql.Add('     (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
       FConexao.Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin)');
    End;
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(Qtde), 0) Qtde Into #Estoq');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = Est.Enderecoid');
    FConexao.Query.Sql.Add('Group By Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde Into #EstPulmao');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On CodigoERP = TEnd.Codproduto');
    FConexao.Query.Sql.Add('Where Est.EstruturaId <> 2');
    FConexao.Query.Sql.Add('Group By CodigoERP');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select CodigoERP, Coalesce(Sum(Qtde), 0) QtdeSegregado Into #EstSegregado');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On CodigoERP = TEnd.Codproduto');
    FConexao.Query.Sql.Add('Where Est.EstruturaId <> 2 and Est.ZonaID = 3');
    FConexao.Query.Sql.Add('Group By CodigoERP');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeProducao), 0) Qtde Into #EstPicking');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
    FConexao.Query.Sql.Add('Where Est.EstruturaId = 2');
    FConexao.Query.Sql.Add('Group By Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeReserva), 0) Qtde Into #EstReserva');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
    FConexao.Query.Sql.Add('Group By Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select ET.EnderecoId, Coalesce(Sum(ET.Qtde), 0) Qtde Into #EstRepo');
    FConexao.Query.Sql.Add('From ReposicaoEstoqueTransferencia ET');
    FConexao.Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = ET.EnderecoId');
    FConexao.Query.Sql.Add('Where ET.Qtde > 0');
    FConexao.Query.Sql.Add('Group By ET.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select vEst.EnderecoId,');
    FConexao.Query.Sql.Add('       Cast(Sum(Prd.Volume*vEst.Qtde) As decimal(15,2)) Ocupacao2,');
    FConexao.Query.Sql.Add('       Cast(Sum(Cast( Prd.Volume*vEst.Qtde As decimal(15,2))');
    FConexao.Query.Sql.Add('                / Cast( (Case When TEnd.Volume <=0 then (120*120*100) else TEnd.Volume End) as Decimal(15,2)))');
    FConexao.Query.Sql.Add('						                     * 100 as decimal(15,2)) Ocupacao Into #EstProd');
    FConexao.Query.Sql.Add('From vEstoque vEst');
    FConexao.Query.Sql.Add('join vProduto Prd on Prd.CodProduto = vEst.CodigoERP');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = vEst.EnderecoId');
    FConexao.Query.Sql.Add('Where vEst.Producao = 1 and vEst.Qtde > 0');
    FConexao.Query.Sql.Add('Group By vEst.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('select Est.Enderecoid, Count(*) Sku,');
    FConexao.Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (1,4) then Qtde Else 0 End) QtdeProducao,');
    FConexao.Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (6) then Qtde Else 0 End) QtdeReserva,');
    FConexao.Query.Sql.Add('                   sum(Case when Est.estoqueTipoId Not in (1, 4, 6) then Qtde Else 0 End) QtdeOutros Into #EstDet');
    FConexao.Query.Sql.Add('from Estoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
    FConexao.Query.Sql.Add('Group by Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('SELECT Inv.InventarioId,  MAX(De.ProcessoId) AS ProcessoId Into #MaxProcesso');
    FConexao.Query.Sql.Add('FROM  DocumentoEtapas De');
    FConexao.Query.Sql.Add('INNER JOIN  inventarios Inv On Inv.uuid = De.Documento');
    FConexao.Query.Sql.Add('GROUP BY Inv.InventarioId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select II.Enderecoid, COUNT(*) TotalEndereco Into #BloqInv');
    FConexao.Query.Sql.Add('From inventarioitens II');
    FConexao.Query.Sql.Add('Inner join inventarios I On I.inventarioid = II.inventarioid');
    FConexao.Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = II.enderecoid');
    FConexao.Query.Sql.Add('Inner Join #MaxProcesso De On De.InventarioId = II.InventarioId');
    FConexao.Query.Sql.Add('where De.ProcessoId < 143');
    FConexao.Query.Sql.Add('Group by II.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select (');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('select TEnd.enderecoid, TEnd.descricao,');
    FConexao.Query.Sql.Add('       Cast(TEnd.altura as Decimal(15,3)) altura,');
    FConexao.Query.Sql.Add('       Cast(TEnd.largura as Decimal(15,3)) largura,');
    FConexao.Query.Sql.Add('	   Cast(TEnd.comprimento as Decimal(15,3)) comprimento,');
    FConexao.Query.Sql.Add('       Cast(TEnd.volume as Decimal(20,6)) volume,');
    FConexao.Query.Sql.Add('	   Cast(TEnd.capacidade as Decimal(15,3)) capacidade,');
    FConexao.Query.Sql.Add('       TEnd.status, TEnd.bloqueado, TEnd.bloqueioinventario,');
    FConexao.Query.Sql.Add('       TEnd.EstruturaId as '+#39+'enderecoestrutura.estruturaid'+#39+', TEnd.estrutura as '+#39+'enderecoestrutura.descricao'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.PickingFixo as '+#39+'enderecoestrutura.pickingfixo'+#39+', TEnd.Mascara as '+#39+'enderecoestrutura.mascara'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.Ruaid as '+#39+'enderecorua.ruaid'+#39+', TEnd.Rua as '+#39+'enderecorua.descricao'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.Lado as '+#39+'enderecorua.lado'+#39+', TEnd.Ordem as '+#39+'enderecorua.ordem'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.ZonaId as '+#39+'enderecamentozona.zonaid'+#39+', TEnd.Zona as '+#39+'enderecamentozona.descricao'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.EstoqueTipoId as '+#39+'enderecamentozona.estoquetipoid'+#39+', TEnd.ZonaStatus as '+#39+'enderecamentozona.status'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.produtosngpc as '+#39+'enderecamentozona.produtosngpc'+#39+', TEnd.DesenhoArmazemId AS '+#39+'desenhoarmazem.Id'+#39+',');
    FConexao.Query.Sql.Add('       TEnd.DesenhoArmazemDescricao AS '+#39+'desenhoarmazem.descricao'+#39+',');
    FConexao.Query.Sql.Add('       IsNull(TEnd.produtoid, 0) as '+#39+'produto.produtoid'+#39+',');
    FConexao.Query.Sql.Add('	   IsNull(TEnd.codproduto, 0) as '+#39+'produto.codproduto'+#39+',');
    FConexao.Query.Sql.Add('       IsNull(TEnd.Produto, '+#39+#39+') as '+#39+'produto.descricao'+#39+',');
    FConexao.Query.Sql.Add('  	   IsNull(Est.Qtde, 0) as '+#39+'produto.qtde'+#39+',');
    FConexao.Query.Sql.Add('	   IsNull(EPu.Qtde, 0) as '+#39+'produto.qtdepulmao'+#39+',');
    FConexao.Query.Sql.Add('	   IsNull(ESeg.QtdeSegregado, 0) as '+#39+'produto.qtdesegregado'+#39+',');
    FConexao.Query.Sql.Add('       IsNull(EPi.Qtde, 0) as '+#39+'produto.qtdepicking'+#39+',');
    FConexao.Query.Sql.Add('       IsNull(ER.Qtde, 0) as '+#39+'produto.qtdereserva'+#39+',');
    FConexao.Query.Sql.Add('       IsNull(ERep.Qtde, 0) as '+#39+'produto.qtdetransferencia'+#39+',');
    FConexao.Query.Sql.Add('       (Case When IsNull(EP.Ocupacao, 0) > 0 then EP.Ocupacao Else 0 End) Ocupacao,');
    FConexao.Query.Sql.Add('       (Case When TEnd.Curva is Null then '+#39+#39+' Else TEnd.Curva End) Curva,');
    FConexao.Query.Sql.Add('       IsNull(ED.QtdeProducao, 0) QtdeProducao, IsNull(ER.Qtde, 0) QtdeReserva,');
    FConexao.Query.Sql.Add('       IsNull(ED.QtdeOutros, 0) QtdeOutros, IsNull(ED.Sku, 0) Sku');
    FConexao.Query.Sql.Add('	  , (Case When IsNull(Bi.TotalEndereco, 0) > 0 then 1 Else 0 End) reservadoinventario');
    FConexao.Query.Sql.Add('From #Endereco TEnd');
    FConexao.Query.Sql.Add('Left Join #Estoq Est On Est.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstPulmao EPu On EPu.CodigoERP = TEnd.CodProduto');
    FConexao.Query.Sql.Add('Left Join #EstSegregado ESeg On ESeg.CodigoERP = TEnd.CodProduto');
    FConexao.Query.Sql.Add('Left Join #EstPicking EPi On EPi.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstReserva ER On ER.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstRepo ERep On ERep.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstProd EP On EP.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstDet ED On ED.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #BloqInv BI On BI.enderecoid = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Order by TEnd.Descricao');
    If pLimit <> 0 then Begin
       FConexao.Query.Sql.Add('OFFSET '+pOffSet.ToString()+'ROWS ');//+' * '+pLimit.ToString()+' ROWS');
       FConexao.Query.Sql.Add('FETCH NEXT '+pLimit.ToString()+' ROWS ONLY');
    End;
    FConexao.Query.Sql.Add('For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno');
    FConexao.Query.SQL.Add('Drop Table #Endereco, #Estoq, #EstPulmao, #EstPicking, #EstReserva, #EstRepo, #EstProd, #EstDet, #BloqInv, #MaxProcesso, #EstSegregado');
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('RelEnderecoLista.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('ConsultaRetorno').AsString = '') Then Begin
       If pLimit = 0 then Begin
          Result := TjSonArray.Create;
          Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Endereço não encontrado.'));
       End
       Else
          Raise Exception.Create('Endereço não encontrado.');
    End
    Else
       Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno').AsString), 0) as TjSonArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' + TUtil.TratarExcessao(E.Message) );
    End;
  end;
end;

function TEnderecoDao.GetListaRecordCount(pEnderecoId, pEstruturaId, pZonaId,
  pRuaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus, pBloqueado: Integer; pListaZona, pCurva: String; pBuscaParcial,
  pLimit, pOffSet: Integer): Integer;
begin
  try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @EnderecoId Integer = ' + pEnderecoId.ToString());
    FConexao.Query.Sql.Add('Declare @EstruturaId Integer = ' + pEstruturaId.ToString());
    FConexao.Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
    FConexao.Query.Sql.Add('Declare @Ruaid Integer  = ' + pRuaId.ToString());
    FConexao.Query.Sql.Add('Declare @EnderecoIni VarChar(40) = ' + #39 +pEnderecoIni + #39);
    FConexao.Query.Sql.Add('Declare @EnderecoFin VarChar(40) = ' + #39 +pEnderecoFin + #39);
    FConexao.Query.Sql.Add('Declare @OcupacaoEndereco Varchar(1) = ' + #39 +pOcupacaoEndereco + #39);
    FConexao.Query.Sql.Add('Declare @Curva Varchar(30)           = ' + #39 +pCurva + #39);
    FConexao.Query.Sql.Add('Declare @Status Integer = ' + pStatus.ToString());
    FConexao.Query.Sql.Add('Declare @Bloqueado Integer = ' + pBloqueado.ToString());
    FConexao.Query.Sql.Add('select vEnd.enderecoid, vEnd.Endereco descricao, Cast(vEnd.altura as Decimal(15,3)) altura, Cast(vEnd.largura as Decimal(15,3)) largura,');
    FConexao.Query.Sql.Add('                    Cast(vEnd.comprimento as Decimal(15,3)) comprimento, Cast(vEnd.volume as Decimal(20,6)) volume, Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
    FConexao.Query.Sql.Add('                    vEnd.status, vEnd.bloqueado, vEnd.bloqueioinventario, vEnd.EstruturaId, vEnd.estrutura, vEnd.PickingFixo, vEnd.Mascara,');
    FConexao.Query.Sql.Add('                    vEnd.Ruaid, vEnd.Rua, vEnd.Lado, vEnd.Ordem, vEnd.ZonaId, vEnd.Zona, vEnd.EstoqueTipoId, vEnd.ZonaStatus, vEnd.produtosngpc,');
    FConexao.Query.Sql.Add('                    vEnd.DesenhoArmazemId, vEnd.DesenhoArmazemDescricao, Coalesce(vEnd.produtoid, 0) ProdutoId, Coalesce(vEnd.codproduto, 0) CodProduto,');
    FConexao.Query.Sql.Add('                    Coalesce(vEnd.descricao, '+#39+#39+') Produto, (Case When vEnd.Curva is Null then '+#39+#39+' Else vEnd.Curva End) Curva, 0 as Ocupacao Into #Endereco');
    FConexao.Query.Sql.Add('From vEnderecamentos vEnd');
    FConexao.Query.Sql.Add('Where (@EnderecoId = 0 or vEnd.EnderecoId = @EnderecoId) and');
    FConexao.Query.Sql.Add('      (@EstruturaId = 0 or vEnd.EstruturaId = @EstruturaId) and');
    FConexao.Query.Sql.Add('      (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
    FConexao.Query.Sql.Add('      (@RuaId  = 0 or vEnd.RuaId  = @RuaId) and');
    FConexao.Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
    FConexao.Query.Sql.Add('      (@EnderecoFin = '#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin) and');
    FConexao.Query.Sql.Add('      ((@OcupacaoEndereco = '+#39+'T'+#39+') or (@OcupacaoEndereco='+#39+'L'+#39+' and vEnd.ProdutoId Is Null) or');
    FConexao.Query.Sql.Add('      (@OcupacaoEndereco='+#39+'O'+#39+' and vEnd.ProdutoId is Not Null)) And');
    FConexao.Query.Sql.Add('      (@Curva = '+#39+#39+' or vEnd.Curva = @Curva) and');
    FConexao.Query.Sql.Add('      (@Status Not In (0,1) or (@Status = Status)) and');
    FConexao.Query.Sql.Add('      (@Bloqueado <> 1 or (@Bloqueado = vEnd.Bloqueado)) and');
    If pBuscaParcial = 0 then Begin
       FConexao.Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or vEnd.Endereco >= @EnderecoIni) and');
       FConexao.Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or vEnd.Endereco <= @EnderecoFin)');
    End
    Else Begin
       FConexao.Query.Sql.Add('     (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
       FConexao.Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin)');
    End;
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(Qtde), 0) Qtde Into #Estoq');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = Est.Enderecoid');
    FConexao.Query.Sql.Add('Group By Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde Into #EstPulmao');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On CodigoERP = TEnd.Codproduto');
    FConexao.Query.Sql.Add('Where Est.EstruturaId <> 2');
    FConexao.Query.Sql.Add('Group By CodigoERP');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeProducao), 0) Qtde Into #EstPicking');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
    FConexao.Query.Sql.Add('Where Est.EstruturaId = 2');
    FConexao.Query.Sql.Add('Group By Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeReserva), 0) Qtde Into #EstReserva');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
    FConexao.Query.Sql.Add('Group By Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select ET.EnderecoId, Coalesce(Sum(ET.Qtde), 0) Qtde Into #EstRepo');
    FConexao.Query.Sql.Add('From ReposicaoEstoqueTransferencia ET');
    FConexao.Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = ET.EnderecoId');
    FConexao.Query.Sql.Add('Where ET.Qtde > 0');
    FConexao.Query.Sql.Add('Group By ET.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select vEst.EnderecoId,');
    FConexao.Query.Sql.Add('       Cast(Sum(Prd.Volume*vEst.Qtde) As decimal(15,2)) Ocupacao2,');
    FConexao.Query.Sql.Add('       Cast(Sum(Cast( Prd.Volume*vEst.Qtde As decimal(15,2))');
    FConexao.Query.Sql.Add('                / Cast( (Case When TEnd.Volume <=0 then 1 else TEnd.Volume End) as Decimal(15,2)))');
    FConexao.Query.Sql.Add('						                     * 100 as decimal(15,2)) Ocupacao Into #EstProd');
    FConexao.Query.Sql.Add('From vEstoque vEst');
    FConexao.Query.Sql.Add('join vProduto Prd on Prd.CodProduto = vEst.CodigoERP');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = vEst.EnderecoId');
    FConexao.Query.Sql.Add('Where vEst.Producao = 1 and vEst.Qtde > 0');
    FConexao.Query.Sql.Add('Group By vEst.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('select Est.Enderecoid, Count(*) Sku,');
    FConexao.Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (1,4) then Qtde Else 0 End) QtdeProducao,');
    FConexao.Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (6) then Qtde Else 0 End) QtdeReserva,');
    FConexao.Query.Sql.Add('                   sum(Case when Est.estoqueTipoId Not in (1, 4, 6) then Qtde Else 0 End) QtdeOutros Into #EstDet');
    FConexao.Query.Sql.Add('from Estoque Est');
    FConexao.Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
    FConexao.Query.Sql.Add('Group by Est.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('SELECT Inv.InventarioId,  MAX(De.ProcessoId) AS ProcessoId Into #MaxProcesso');
    FConexao.Query.Sql.Add('FROM  DocumentoEtapas De');
    FConexao.Query.Sql.Add('INNER JOIN  inventarios Inv On Inv.uuid = De.Documento');
    FConexao.Query.Sql.Add('GROUP BY Inv.InventarioId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Select II.Enderecoid, COUNT(*) TotalEndereco Into #BloqInv');
    FConexao.Query.Sql.Add('From inventarioitens II');
    FConexao.Query.Sql.Add('Inner join inventarios I On I.inventarioid = II.inventarioid');
    FConexao.Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = II.enderecoid');
    FConexao.Query.Sql.Add('Inner Join #MaxProcesso De On De.InventarioId = II.InventarioId');
    FConexao.Query.Sql.Add('where De.ProcessoId < 143');
    FConexao.Query.Sql.Add('Group by II.EnderecoId');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('select Count(*) TotalRegistro');
    FConexao.Query.Sql.Add('From #Endereco TEnd');
    FConexao.Query.Sql.Add('Left Join #Estoq Est On Est.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstPulmao EPu On EPu.CodigoERP = TEnd.CodProduto');
    FConexao.Query.Sql.Add('Left Join #EstPicking EPi On EPi.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstReserva ER On ER.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstRepo ERep On ERep.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstProd EP On EP.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #EstDet ED On ED.EnderecoId = TEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join #BloqInv BI On BI.enderecoid = TEnd.EnderecoId');
    FConexao.Query.SQL.Add('Drop Table #Endereco, #Estoq, #EstPulmao, #EstPicking, #EstReserva, #EstRepo, #EstProd, #EstDet, #BloqInv, #MaxProcesso');
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('RelEnderecoListaRecordCount.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) Then Begin
       Result := 0
    End
    Else Begin
       Result := FConexao.Query.FieldByName('TotalRegistro').AsInteger;
    End;
  Except ON E: Exception do
    Begin
      Result := 0;
    End;
  end;
end;

function TEnderecoDao.GetMotivoMovimentacaoSegregado: TjSonArray;
begin
  try
    FConexao.Query.Sql.Add
      ('Select EnderecoId, Endereco, Mascara, ZonaId From vEnderecamentos');
    FConexao.Query.Sql.Add('Where ZonaId in (1, 3) And Status = 1');
    FConexao.Query.Sql.Add('Order By ZonaId, Endereco');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há dados para gerar o relatório'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Erro: GetMotivoMovimentacaoSegregado - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.GetPickingMask: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Open('Select Mascara From EnderecamentoEstruturas'+sLineBreak+
                        'where Descricao = ' + QuotedStr('Picking'));
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('mascara', FConexao.Query.FieldByName('Mascara').AsString)));
  Except ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamento - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.GetReUsoPicking(pZonaId, pDias: Integer): TjSonArray;
var vSql: String;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlReUsoPicking);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pDias').Value   := pDias;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('RelReUsoPicking.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há picking disponível para ReUso.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.GetZona(pEstruturaId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEndereco;
    vSql := vSql + #13 + #10 + ' where ZonaId = ' + pEstruturaId.ToString();
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      With ObjEnderecoDAO do
      Begin
        EnderecoId := FConexao.Query.FieldByName('EnderecoId').AsInteger;
        EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId')
          .AsInteger;
        EnderecoEstrutura.Descricao := FConexao.Query.FieldByName('Estrutura').AsString;
        EnderecamentoZona.ZonaId := FConexao.Query.FieldByName('ZonaId').AsInteger;
        EnderecamentoZona.Descricao := FConexao.Query.FieldByName('Zona').AsString;
        Descricao := FConexao.Query.FieldByName('Endereco').AsString;
        DesenhoArmazem.Id := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        largura := FConexao.Query.FieldByName('Largura').AsFloat;
        Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        Volume := FConexao.Query.FieldByName('Volume').AsFloat;
        Capacidade := FConexao.Query.FieldByName('Capacidade').AsFloat;
        Curva := FConexao.Query.FieldByName('Curva').AsString;
        Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
        FConexao.Query.Next;
      End;
    end;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Enderecamento - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.InsertUpdate(pJsonEndereco: TJsonObject): TjSonArray;
var
  vSql: String;
begin
  try
    if pJsonEndereco.GetValue<Integer>('enderecoId') = 0 then
      vSql := 'Insert Into Enderecamentos (RuaId, EstruturaId, ZonaId, Descricao, DesenhoArmazemID, Altura, Largura, Comprimento, Volume, Capacidade, Curva, Status) Values ('
        + pJsonEndereco.GetValue<TJsonObject>('enderecoRua')
        .GetValue<Integer>('ruaId').ToString() + ', ' +
        pJsonEndereco.GetValue<TJsonObject>('enderecoEstrutura')
        .GetValue<Integer>('estruturaId').ToString() + ', ' +
        pJsonEndereco.GetValue<TJsonObject>('enderecamentoZona')
        .GetValue<Integer>('zonaId').ToString() + ', ' +
        QuotedStr(pJsonEndereco.GetValue<String>('descricao')) + ', ' +
        pJsonEndereco.GetValue<TJsonObject>('desenhoArmazem')
        .GetValue<Integer>('id').ToString() + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('altura').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('largura').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('comprimento').ToString(),
        ',', '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('volume').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('capacidade').ToString(),
        ',', '.', [rfReplaceAll]) + ', ' +
        QuotedStr(pJsonEndereco.GetValue<String>('curva')) + ', 1)'
    Else
       vSql := 'Update Enderecamentos Set ' + sLineBreak +
               '     RuaId            = ' + pJsonEndereco.GetValue<TJsonObject>('enderecoRua').GetValue<Integer>('ruaId').ToString() + sLineBreak +
               '   , EstruturaId      = ' + pJsonEndereco.GetValue<TJsonObject>('enderecoEstrutura').GetValue<Integer>('estruturaId').ToString() +sLineBreak +
               '   , ZonaId           = ' + pJsonEndereco.GetValue<TJsonObject>('enderecamentoZona').GetValue<Integer>('zonaId').ToString() + sLineBreak +
               '   , Descricao        = ' + QuotedStr(pJsonEndereco.GetValue<String>('descricao')) + sLineBreak +
               '   , DesenhoArmazemId = ' + pJsonEndereco.GetValue<TJsonObject>('desenhoArmazem').GetValue<Integer>('id').ToString() + sLineBreak +
               '   , Altura           = ' + StringReplace(pJsonEndereco.GetValue<double>('altura').ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
               '   , Largura          = ' + StringReplace(pJsonEndereco.GetValue<double>('largura').ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
               '   , Comprimento      = ' + StringReplace(pJsonEndereco.GetValue<double>('comprimento').ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
               '   , Volume           = ' + StringReplace(pJsonEndereco.GetValue<double>('volume').ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
               '   , Capacidade       = ' + StringReplace(pJsonEndereco.GetValue<double>('capacidade').ToString(), ',', '.', [rfReplaceAll]) + sLineBreak +
               '   , Curva            = ' + QuotedStr(pJsonEndereco.GetValue<String>('curva')) + sLineBreak +
               '   , Status           = ' + pJsonEndereco.GetValue<Integer>('status').ToString() + sLineBreak +
               'where EnderecoId = ' + pJsonEndereco.GetValue<Integer>('enderecoId').ToString();
    FConexao.Query.Sql.Add(vSql);
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('EnderecoInsert.Sql');
    FConexao.Query.ExecSQL;
    Result := FConexao.Query.ToJSONArray;
  Except On E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamento - ' + StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.Manutencao(pJsonManutencao: TJsonObject): TJsonObject;
var vSql: String;
    xManutencao: Integer;
    vOperacao: String;
    vAcao: String;
    vRuaId, vZonaId: Integer;
    vPicking, vPickingNovo: String;
    vAltura, vLargura, vComprimento, vPeso: double;
    vEndereco  : String;
    vQtAcao    : Integer;
    vComplAcao : String;
begin
  try
    Fconexao.Query.Connection.StartTransaction;
    vOperacao := pJsonManutencao.GetValue<String>('operacao');
    if vOperacao = 'AtivaDesativa' then
      vAcao := '' //pJsonManutencao.GetValue<String>('acao');
    Else if vOperacao = 'MudarZona' then
      vZonaId := pJsonManutencao.GetValue<Integer>('zonaid')
    Else if vOperacao = 'QuebraRuaPicking' then
      vRuaId := pJsonManutencao.GetValue<Integer>('ruaid')
    Else if vOperacao = 'Cubagem' then Begin
      vAltura := pJsonManutencao.GetValue<double>('altura');
      vLargura := pJsonManutencao.GetValue<double>('largura');
      vComprimento := pJsonManutencao.GetValue<double>('comprimento');
      vPeso := pJsonManutencao.GetValue<double>('peso');
    End;
    if vOperacao <> 'Transferencia' then Begin
      For xManutencao := 0 to Pred(pJsonManutencao.GetValue<TjSonArray>('lista').Count) do Begin
        vEndereco := pJsonManutencao.GetValue<TjSonArray>('lista').Items[xManutencao].GetValue<String>('endereco');
        if vOperacao = 'AtivaDesativa' then Begin
           FConexao.Query.Close;
           FConexao.Query.Sql.Clear;
           FConexao.Query.Sql.Add('Update Enderecamentos Set');
           vComplAcao := '';
           for vQtAcao := 0 to Pred(pJsonManutencao.GetValue<TJsonArray>('acao').Count) do Begin
             vAcao := pJsonManutencao.GetValue<TJsonArray>('acao').Items[vQtAcao].GetValue<String>('acao');
             if vAcao = 'ativar' Then Begin
                FConexao.Query.Sql.Add('   '+vComplAcao+'Status = 1');
                vComplAcao:= ', ';
             End
             Else if vAcao = 'desativar' then Begin
                FConexao.Query.Sql.Add('   '+vComplAcao+'Status = 0');
                vComplAcao:= ', ';
             End
             Else if vAcao = 'bloquear' then Begin
                FConexao.Query.Sql.Add('   '+vComplAcao+'Bloqueado = 1');
                vComplAcao:= ', ';
             End
             Else if vAcao = 'desbloquear' then Begin
                FConexao.Query.Sql.Add('   '+vComplAcao+'Bloqueado = 0');
                vComplAcao:= ', ';
             End
           End;
           FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'MudarZona' then Begin
           FConexao.Query.Close;
           FConexao.Query.Sql.Clear;
           FConexao.Query.Sql.Add('Update Enderecamentos');
           FConexao.Query.Sql.Add('  Set ZonaId = ' + vZonaId.ToString());
           FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'QuebraRuaPicking' then Begin
           FConexao.Query.Close;
           FConexao.Query.Sql.Clear;
           FConexao.Query.Sql.Add('Update Enderecamentos');
           FConexao.Query.Sql.Add('  Set RuaId = ' + vRuaId.ToString());
           FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'Cubagem' then Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('Update Enderecamentos');
          FConexao.Query.Sql.Add('  Set Altura      = ' + StringReplace(vAltura.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('    , Largura     = ' + StringReplace(vLargura.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('    , Comprimento = ' + StringReplace(vComprimento.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('    , Capacidade  = ' + StringReplace(vPeso.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'Excluir' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('Delete Enderecamentos');
          FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'RemoverVinculo' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('update Produto');
          FConexao.Query.Sql.Add('  Set EnderecoId = Null');
          FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
        End;
        if DebugHook <> 0 then
           FConexao.Query.Sql.SaveToFile('EnderecoManutencao.Sql');
        FConexao.Query.ExecSQL;
      End;
    End
    Else
    Begin
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('update Produto');
      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');
      FConexao.Query.Sql.Add('update Estoque');
      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');
      //Volumes Pendentes
//      FConexao.Query.Sql.Add('update Estoque');
//      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
//      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');

      FConexao.Query.Sql.Add('update ReposicaoEstoqueTransferencia');
      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');

      if DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('EnderecoManutencao_TransfPicking.Sql');
      FConexao.Query.ExecSQL;
    End;
    Result := TJsonObject.Create.AddPair('Ok', 'Manutenção realizado com sucesso!');
    Fconexao.Query.Connection.Commit;
  Except ON E: Exception do
    Begin
      Fconexao.Query.Connection.Rollback;
      Result := TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamento - '+StringReplace(E.Message,
                '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.MontarPaginacao: TJsonObject;
var
  vSql: String;
begin
  Result := TJsonObject.Create;
  try
    FConexao.Query.Open('Select Count(*) Paginacao From Enderecamento');
    Result.AddPair('paginacao', TJsonNumber.Create(FConexao.Query.FieldByName('Paginacao')
      .AsInteger));
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', E.Message);
    End;
  end;
end;

function TEnderecoDao.PutDesvincularPicking(pJsonArray: TjSonArray): TjSonArray;
var
  vSql: String;
  xEndereco: Integer;
  vParamSize: Integer;
begin
  FConexao.Query.connection.StartTransaction;
  try
    FConexao.Query.Close;
    FConexao.Query.Sql.Add
      ('Update Produto Set EnderecoId = Null Where EnderecoId = :pEnderecoId');
    FConexao.Query.Params.ArraySize := pJsonArray.Count;
    for xEndereco := 0 to Pred(pJsonArray.Count) do
    Begin
      FConexao.Query.Params[0].Values[xEndereco] := pJsonArray.Items[xEndereco]
        .GetValue<Integer>('enderecoid');
    End;
    FConexao.Query.Execute(FConexao.Query.Params.ArraySize, 0);
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Picking`s Liberados'));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
