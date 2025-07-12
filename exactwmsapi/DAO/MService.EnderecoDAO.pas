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

uses
  System.Classes;

//uses uSistemaControl;

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
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    try
      vSql := 'Delete from Enderecamentos where EnderecoId = ' + pEnderecoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Enderecamentos - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

//Inicialmente criado para Inativar Endereço
function TEnderecoDao.EnderecoBloquear(ArrayEndereco: TjSonArray): TjSonArray;
Var xEndereco: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('Update Enderecamentos Set Status = 0');
      Query.Sql.Add('Where EnderecoId = :EnderecoId');
      for xEndereco := 0 to ArrayEndereco.Count - 1 do Begin
        Query.ParamByName('EnderecoId').Value := ArrayEndereco.Get(xEndereco).GetValue<Integer>('enderecoid', 0);
        Query.ExecSQL;
      End;
      Query.connection.Commit;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Endereço bloqueado com sucesso!'));
    Except ON E: Exception do
      Begin
        Query.Connection.Rollback;
        Raise Exception.Create('Tabela: Enderecamentos - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.EnderecoBloqueioDeUso( ArrayEndereco: TjSonArray): TjSonArray;
Var xEndereco: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('Update Enderecamentos Set Bloqueado = :pBloqueio');
      Query.Sql.Add('Where EnderecoId = :pEnderecoId');
      Query.connection.StartTransaction;
      for xEndereco := 0 to ArrayEndereco.Count - 1 do Begin
        Query.ParamByName('pEnderecoId').Value := ArrayEndereco.Get(xEndereco).GetValue<Integer>('enderecoid', 0);
        Query.ParamByName('pBloqueio').Value   := ArrayEndereco.Get(xEndereco).GetValue<Integer>('bloqueio', 0);
        Query.ExecSQL;
      End;
      Query.connection.Commit;
      Result := TjSonArray.Create;
    Except ON E: Exception do
      Raise Exception.Create('Processo: EnderecoBloqueioDeUso - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak+
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('vEnderecamentos') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
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

function TEnderecoDao.ExportFile(const AParams: TDictionary<string, string>) : TjSonArray;
var vSql, pCampos: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if AParams.ContainsKey('campos') then
         pCampos := AParams.Items['campos']
      else
         pCampos := 'Descricao, PickingFixo';
      vSql := 'Select ' + pCampos + ' ' + sLineBreak + 'From vEnderecamentos';
      Query.Open(vSql);
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não foram encontrados dados da pesquisa.')));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
       Raise Exception.Create('Processo: ExportFile - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;

end;

function TEnderecoDao.GetEstrutura(pEstruturaId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create;
    try
      vSql := SqlEndereco;
      vSql := vSql + #13 + #10 + ' where EstruturaId = ' +pEstruturaId.ToString();
      Query.Open(vSql);
      while Not Query.Eof do Begin
        With ObjEnderecoDAO do Begin
          EnderecoId                    := Query.FieldByName('EnderecoId').AsInteger;
          EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
          EnderecoEstrutura.Descricao   := Query.FieldByName('Estrutura').AsString;
          EnderecamentoZona.ZonaId      := Query.FieldByName('ZonaId').AsInteger;
          EnderecamentoZona.Descricao   := Query.FieldByName('Zona').AsString;
          Descricao                     := Query.FieldByName('Endereco').AsString;
          DesenhoArmazem.Id             := Query.FieldByName('DesenhoArmazemId').AsInteger;
          Altura      := Query.FieldByName('Altura').AsFloat;
          largura     := Query.FieldByName('Largura').AsFloat;
          Comprimento := Query.FieldByName('Comprimento').AsFloat;
          Volume      := Query.FieldByName('Volume').AsFloat;
          Capacidade  := Query.FieldByName('Capacidade').AsFloat;
          Curva       := Query.FieldByName('Curva').AsString;
          Status      := Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
          Query.Next;
        End;
      end;
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Tabela: Enderecamentos - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetId(pEnderecoId: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := SqlEndereco;
      if pEnderecoId <> '0' then
        vSql := vSql + #13 + #10 + 'Where (Cast(EnderecoId as varchar(20)) = ' +
                QuotedStr(pEnderecoId) + ') or (Endereco = ' + QuotedStr(pEnderecoId) + ')';
      Query.Open(vSql);
      while Not Query.Eof do
      Begin
        With ObjEnderecoDAO do Begin
          EnderecoId                    := Query.FieldByName('EnderecoId').AsInteger;
          EnderecoRua.RuaId             := Query.FieldByName('ruaid').AsInteger;
          EnderecoRua.Descricao         := Query.FieldByName('Rua').AsString;
          EnderecoRua.Lado              := Query.FieldByName('Lado').AsString;
          EnderecoRua.Ordem             := Query.FieldByName('Ordem').AsInteger;
          EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
          EnderecoEstrutura.Descricao   := Query.FieldByName('Estrutura').AsString;
          EnderecoEstrutura.PickingFixo := Query.FieldByName('PickingFixo').AsInteger;
          EnderecoEstrutura.Mascara     := Query.FieldByName('Mascara').AsString;
          EnderecamentoZona.ZonaId      := Query.FieldByName('ZonaId').AsInteger;
          EnderecamentoZona.Descricao   := Query.FieldByName('Zona').AsString;
          Descricao          := Query.FieldByName('Endereco').AsString;
          DesenhoArmazem.Id  := Query.FieldByName('DesenhoArmazemId').AsInteger;
          Altura             := Query.FieldByName('Altura').AsFloat;
          largura            := Query.FieldByName('Largura').AsFloat;
          Comprimento        := Query.FieldByName('Comprimento').AsFloat;
          Volume             := Query.FieldByName('Volume').AsFloat;
          Capacidade         := Query.FieldByName('Capacidade').AsFloat;
          Curva              := Query.FieldByName('Curva').AsString;
          Status             := Query.FieldByName('Status').AsInteger;
          Bloqueado          := Query.FieldByName('Bloqueado').AsInteger;
          Bloqueioinventario := Query.FieldByName('BloqueioInventario').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
          Query.Next;
        End;
      end;
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Tabela: Enderecamentos - ' +TUtil.tratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetEndereco4D(const AParams: TDictionary<string, string>) : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  Try
    QryPesquisa    := TFdQuery.Create(Nil);
    QryPesquisa.Connection := Connection;
    QryRecordCount := TFdQuery.Create(Nil);
    QryRecordCount.Connection := Connection;
    Try
      QryPesquisa.Sql.Add('select EnderecoId, Endereco, Estrutura, Rua, Lado, Zona, Status, Curva');
      QryPesquisa.Sql.Add('From vEnderecamentos where 1 = 1');
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
    Except On E: Exception do
      Raise Exception.Create('Tabela: Enderecamento4D - ' +TUtil.tratarExcessao(E.Message));
    End;
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TEnderecoDao.GetEnderecoModelo(const AParams: TDictionary<string, string>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
//Levar Codigo para Constants e substituir a Const aqui em em InventarioDAO - GerarNovoInventarioModelo
    Try
      Query.Sql.Add('Declare @EstruturaId Integer         = :pEstruturaId');
      Query.Sql.Add('Declare @ZonaId      Integer         = :pZonaId');
      Query.Sql.Add('Declare @EnderecoInicial Varchar(11) = :pEnderecoInicial');
      Query.Sql.Add('Declare @EnderecoFinal Varchar(11)   = :pEnderecoFinal');
      Query.Sql.Add('Declare @RuaInicial Varchar(2)       = :pRuaInicial');
      Query.Sql.Add('Declare @RuaFinal Varchar(2)         = :pRuaFinal');
      Query.Sql.Add('Declare @RuaPar Integer              = :pRuaPar');
      Query.Sql.Add('Declare @RuaImpar Integer            = :pRuaImpar');
      Query.Sql.Add('Declare @PredioInicial Varchar(2)    = :pPredioInicial');
      Query.Sql.Add('Declare @PredioFinal Varchar(2)      = :pPredioFinal');
      Query.Sql.Add('Declare @PredioPar Integer           = :pPredioPar');
      Query.Sql.Add('Declare @PredioImpar Integer         = :pPredioImpar');
      Query.Sql.Add('Declare @NivelInicial Varchar(2)     = :pNivelInicial');
      Query.Sql.Add('Declare @NivelFinal Varchar(2)       = :pNivelFinal');
      Query.Sql.Add('Declare @NivelPar Integer            = :pNivelPar');
      Query.Sql.Add('Declare @NivelImpar Integer          = :pNivelImpar');
      Query.Sql.Add('Declare @AptoInicial Varchar(3)      = :pAptoInicial');
      Query.Sql.Add('Declare @AptoFinal Varchar(3)        = :pAptoFinal');
      Query.Sql.Add('Declare @AptoPar Integer             = :pAptoPar');
      Query.Sql.Add('Declare @AptoImpar Integer           = :pAptoImpar');
      Query.Sql.Add('');
      Query.Sql.Add('Select TEnd.EnderecoId, TEnd.Descricao Endereco, TEnd.RuaId, TEnd.ZonaID, Z.Descricao Zona, TEnd.Curva, TEnd.Status, TEnd.Bloqueado');
      Query.SQL.Add('From Enderecamentos TEnd');
      Query.SQL.Add('Join EnderecamentoZonas Z On Z.ZonaId = TEnd.ZonaId');
      Query.SQL.Add('  ');
      Query.SQL.Add('where (@EstruturaId = 0 or @EstruturaId = TEnd.EstruturaId)');
      Query.SQL.Add('  And (@ZonaId = 0 or TEnd.ZonaID = @ZonaId)');
      Query.SQL.Add('  And (@EnderecoInicial = '+#39+#39+' or SubString(TEnd.Descricao, 1, Len(@EnderecoInicial)) >= @EnderecoInicial)');
      Query.SQL.Add('  And (@EnderecoFinal = '+#39+#39+' or SubString(TEnd.Descricao, 1, Len(@EnderecoFinal)) <= @EnderecoFinal)');
      Query.SQL.Add('  And (@RuaInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) >= @RuaInicial)');
      Query.SQL.Add('  And (@RuaFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) <= @RuaFinal)');
      Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) % 2 = 0) and @Ruapar = 1) or');
      Query.SQL.Add('       (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) % 2 = 1) and @RuaImpar = 1) )');
      Query.SQL.Add('');
      Query.SQL.Add('  And (@PredioInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) >= @PredioInicial)');
      Query.SQL.Add('  And (@PredioFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) <= @PredioFinal)');
      Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) % 2 = 0) and @Prediopar = 1) or');
      Query.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) % 2 = 1) and @PredioImpar = 1) )');
      Query.SQL.Add('');
      Query.SQL.Add('  And (@NivelInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) >= @NivelInicial)');
      Query.SQL.Add('  And (@NivelFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) <= @NivelFinal)');
      Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) % 2 = 0) and @Nivelpar = 1) or');
      Query.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) % 2 = 1) and @NivelImpar = 1 ) )');
      Query.SQL.Add('');
      Query.SQL.Add('  And (@AptoInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) >= @AptoInicial)');
      Query.SQL.Add('  And (@AptoFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) <= @AptoFinal)');
      Query.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) % 2 = 0) and @Aptopar = 1) or');
      Query.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) % 2 = 1) and @AptoImpar = 1) ) ');
      Query.SQL.Add('  --And (IsNull(TEnd.Status, 0) = 1 and IsNull(TEnd.Bloqueado, 0) = 0)');
      Query.SQL.Add('Order by TEnd.Descricao');
      If AParams.ContainsKey('estruturaid') then
         Query.ParamByName('pEstruturaId').Value := AParams.Items['estruturaid'].ToInteger()
      Else
         Query.ParamByName('pEstruturaId').Value := 0;
      If AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      If AParams.ContainsKey('enderecoinicial') then
         Query.ParamByName('pEnderecoInicial').Value := AParams.Items['enderecoinicial']
      Else
         Query.ParamByName('pEnderecoInicial').Value := '';
      If AParams.ContainsKey('enderecofinal') then
         Query.ParamByName('pEnderecoFinal').Value := AParams.Items['enderecofinal']
      Else
         Query.ParamByName('pEnderecoFinal').Value := '';
      If AParams.ContainsKey('ruainicial') then
         Query.ParamByName('pRuaInicial').Value := AParams.Items['ruainicial']
      Else
         Query.ParamByName('pRuaInicial').Value := '';
      If AParams.ContainsKey('ruafinal') then
         Query.ParamByName('pRuaFinal').Value := AParams.Items['ruafinal']
      Else
         Query.ParamByName('pRuaFinal').Value := '';
      If AParams.ContainsKey('ruapar') then
         Query.ParamByName('pRuaPar').Value := AParams.Items['ruapar'].ToInteger
      Else
         Query.ParamByName('pRuaPar').Value := 0;
      If AParams.ContainsKey('ruaimpar') then
         Query.ParamByName('pRuaImpar').Value := AParams.Items['ruaimpar'].ToInteger()
      Else
         Query.ParamByName('pRuaImpar').Value := 0;
      If AParams.ContainsKey('predioinicial') then
         Query.ParamByName('pPredioInicial').Value := AParams.Items['predioinicial']
      Else
         Query.ParamByName('pPredioInicial').Value := '';
      If AParams.ContainsKey('prediofinal') then
         Query.ParamByName('pPredioFinal').Value := AParams.Items['prediofinal']
      Else
         Query.ParamByName('pPredioFinal').Value := '';
      If AParams.ContainsKey('prediopar') then
         Query.ParamByName('pPredioPar').Value := AParams.Items['prediopar'].ToInteger
      Else
         Query.ParamByName('pPredioPar').Value := 0;
      If AParams.ContainsKey('predioimpar') then
         Query.ParamByName('pPredioImpar').Value := AParams.Items['predioimpar'].ToInteger()
      Else
         Query.ParamByName('ppredioimpar').Value := 0;

      If AParams.ContainsKey('nivelinicial') then
         Query.ParamByName('pNivelInicial').Value := AParams.Items['nivelinicial']
      Else
         Query.ParamByName('pNivelInicial').Value := '';
      If AParams.ContainsKey('nivelfinal') then
         Query.ParamByName('pNivelFinal').Value := AParams.Items['nivelfinal']
      Else
         Query.ParamByName('pNivelFinal').Value := '';
      If AParams.ContainsKey('nivelpar') then
         Query.ParamByName('pNivelPar').Value := AParams.Items['nivelpar'].ToInteger
      Else
         Query.ParamByName('pNivelPar').Value := 0;
      If AParams.ContainsKey('nivelimpar') then
         Query.ParamByName('pNivelImpar').Value := AParams.Items['nivelimpar'].ToInteger()
      Else
         Query.ParamByName('pnivelimpar').Value := 0;

      If AParams.ContainsKey('aptoinicial') then
         Query.ParamByName('pAptoInicial').Value := AParams.Items['aptoinicial']
      Else
         Query.ParamByName('pAptoInicial').Value := '';
      If AParams.ContainsKey('aptofinal') then
         Query.ParamByName('pAptoFinal').Value := AParams.Items['aptofinal']
      Else
         Query.ParamByName('pAptoFinal').Value := '';
      If AParams.ContainsKey('aptopar') then
         Query.ParamByName('pAptoPar').Value := AParams.Items['aptopar'].ToInteger
      Else
         Query.ParamByName('pAptoPar').Value := 0;
      If AParams.ContainsKey('aptoimpar') then
         Query.ParamByName('pAptoImpar').Value := AParams.Items['aptoimpar'].ToInteger()
      Else
         Query.ParamByName('pAptoImpar').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetEnderecoModelo.Sql');
      Query.Open;
      if (Query.IsEmpty) Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não foi encontrado Endereço(s) para o modelo pré-definido.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: GetEnderecamentoModelo - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetEnderecoOcupacao(const AParams: TDictionary<string, string>): TjsonArray;
Var pLista : String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
  //    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEnderecoOcupacao);
      Query.Sql.Add('Declare @VolumePadrao Int = (Select IsNull(PalletSizeStand, (120*120*100)) From Configuracao)');
      Query.Sql.Add('If @VolumePadrao = 0');
      Query.Sql.Add('   Set @VolumePadrao = (120*120*100)');
      Query.Sql.Add('Declare @Bloqueado Int   = :pBloqueado');
      Query.Sql.Add('--Declare @Zona Varchar    = :pZona');
      Query.Sql.Add('if object_id ('+#39+'tempdb..#Endereco'+#39+') is not null drop table #Endereco');
      Query.Sql.Add('if object_id ('+#39+'tempdb..#EstoqueVlm'+#39+') is not null drop table #EstoqueVlm');
      Query.Sql.Add('select EnderecoId, Endereco, ZonaId, Zona, RuaId, Curva,');
      Query.Sql.Add('       (Case When IsNull(Volume, 0) = 0 then @VolumePadrao Else Volume End) Volume,');
      Query.Sql.Add('	   Capacidade Into #Endereco');
      Query.Sql.Add('from venderecamentos');
      Query.Sql.Add('where IsNull(Status, 0) = 1');
      Query.Sql.Add('  And (@Bloqueado=1 or (@Bloqueado=0 and IsNull(Bloqueado, 0) = 0))');
      pLista := AParams.Items['zonaidlista'];
      If AParams.ContainsKey('zonaidlista') then
         Query.Sql.Add('  And ZonaId in ('+AParams.Items['zonaidlista']+')')
      Else
         Query.Sql.Add('  And ZonaId in (4, 5)');
      Query.Sql.Add('');
      Query.Sql.Add('select Est.Enderecoid, sum(Qtde) Qtde, Sum(Est.Qtde*Volume) Volume Into #EstoqueVlm');
      Query.Sql.Add('From Estoque Est');
      Query.Sql.Add('inner join ProdutoLotes Pl on Pl.Loteid = Est.LoteId');
      Query.Sql.Add('Inner join vProduto Prd ON Prd.IdProduto = Pl.ProdutoId');
      Query.Sql.Add('Where Est.EstoqueTipoId in (1, 4)');
      Query.Sql.Add('Group by Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('select TEnd.*, IsNull(Est.Qtde, 0) Estoque,');
      Query.Sql.Add('       Isnull(Est.Volume, 0) VlmOcupado,');
      Query.Sql.Add('	   Cast(Isnull(Est.Volume, 0)/TEnd.Volume*100 as Decimal(15,2)) as TxOcupacao');
      Query.Sql.Add('From #Endereco TEnd');
      Query.Sql.Add('left Join #EstoqueVlm Est on Est.EnderecoId = Tend.EnderecoId');
      Query.Sql.Add('Order by ZOnaId, Endereco');
      If AParams.ContainsKey('bloqueado') then
         Query.ParamByName('pBloqueado').Value := AParams.Items['bloqueado']
      Else
         Query.ParamByName('pBloqueado').Value := 1;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EnderecoOcupacao.Sql');
      Query.Open;
      if (Query.IsEmpty) Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não foi encontrado Endereço(s) para análise.'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Enderecamentos - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetEnderecoToReposicao(pZonaId: Integer;
  pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
  pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String;
  pPredioParImpar: Integer; pNivelInicial, pNivelFinal: String;
  pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String;
  pAptoParImpar: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
      Query.Sql.Add('Declare @EnderecoIni VarChar(40)  = ' + #39 +pEnderecoIni + #39);
      Query.Sql.Add('Declare @EnderecoFin VarChar(40)  = ' + #39 +pEnderecoFin + #39);
      Query.Sql.Add('Declare @RuaInicial VarChar(2)    = ' + #39 +pRuaInicial + #39);
      Query.Sql.Add('Declare @RuaFinal  VarChar(2)     = ' + #39 +pRuaFinal + #39);
      Query.Sql.Add('Declare @RuaParImpar Integer      = ' +pRuaParImpar.ToString());
      Query.Sql.Add('Declare @PredioInicial VarChar(2) = ' + #39 +pPredioInicial + #39);
      Query.Sql.Add('Declare @PredioFinal   VarChar(2) = ' + #39 +pPredioFinal + #39);
      Query.Sql.Add('Declare @PredioParImpar Integer   = ' +pPredioParImpar.ToString());
      Query.Sql.Add('Declare @NivelInicial VarChar(2)  = ' + #39 +pNivelInicial + #39);
      Query.Sql.Add('Declare @NivelFinal   VarChar(2)  = ' + #39 +pNivelFinal + #39);
      Query.Sql.Add('Declare @NivelParImpar Integer    = ' +pNivelParImpar.ToString());
      Query.Sql.Add('Declare @AptoInicial VarChar(2)   = ' + #39 +pAptoInicial + #39);
      Query.Sql.Add('Declare @AptoFinal   VarChar(2)   = ' + #39 +pAptoFinal + #39);
      Query.Sql.Add('Declare @AptoParImpar Integer     = ' +pAptoParImpar.ToString());
      Query.Sql.Add('Select (select vEnd.enderecoid, vEnd.Endereco, vEnd.Mascara, vEnd.Descricao Produto,');
      Query.Sql.Add('        Cast(vEnd.altura as Decimal(15,3)) altura,');
      Query.Sql.Add('        Cast(vEnd.largura as Decimal(15,3)) largua,');
      Query.Sql.Add('        Cast(vEnd.comprimento as Decimal(15,3)) comprimento,');
      Query.Sql.Add('        Cast(vEnd.volume as Decimal(15,6)) volume,');
      Query.Sql.Add('        Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
      Query.Sql.Add('        vEnd.Zona, Coalesce(Est.Qtde, 0) as ' + #39 + 'qtde' +#39 + ', Coalesce(EstPulmao.Qtde, 0) as ' + #39 + 'qtdepulmao' + #39);
      Query.Sql.Add('From vEnderecamentos vEnd');
      Query.Sql.Add('Left Join (Select EnderecoId, Coalesce(Sum(Qtde), 0) Qtde From vEstoque Group By EnderecoId) Est ON Est.Enderecoid = vEnd.EnderecoId');
      Query.Sql.Add('Left Join (Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde');
      Query.Sql.Add('From vEstoque Where EstruturaId <> 2');
      Query.Sql.Add('Group By CodigoERP) EstPulmao ON EstPulmao.CodigoERP = vEnd.CodProduto');
      Query.Sql.Add('Where (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
      Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or Substring(vEnd.Endereco, 1, LEN( @EnderecoIni)) >= @EnderecoIni) and ');
      Query.Sql.Add('      (@EnderecoFin = ' + #39 + #39+' or Substring(vEnd.Endereco, 1, LEN( @EnderecoFin)) <= @EnderecoFin) and ');
      Query.Sql.Add('      (@RuaInicial  = ' + #39 + #39+' or SubString(vEnd.Endereco,1,2) >= @RuaInicial) and');
      Query.Sql.Add('      (@RuaFinal    = ' + #39 + #39+' or SubString(vEnd.Endereco,1,2) <= @RuaFinal) and');
      Query.Sql.Add('      (@RuaParImpar = 2 or (@RuaParImpar=0 and SubString(vEnd.Endereco,1,2) % 2 = 0) or ');
      Query.Sql.Add('                           (@RuaParImpar=1 and SubString(vEnd.Endereco,1,2) % 2 = 1) ) and');
      Query.Sql.Add('      (vEnd.EstruturaId=2 and vEnd.Status = 1 and IsNull(vEnd.Bloqueado, 0) = 0)');
      Query.Sql.Add('Order by vEnd.Endereco'); // by RuaId, Lado, Endereco');
      Query.Sql.Add('For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelEnderecoToReposicao.Sql');
      Query.Open;
      if (Query.IsEmpty) or (Query.FieldByName('ConsultaRetorno').AsString = '') Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Endereço não encontrado.'));
      End
      Else
         Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Query.FieldByName('ConsultaRetorno').AsString), 0) as TjSonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Enderecamentos - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetLista(pEnderecoId, pEstruturaId, pZonaId: Integer;
  pRuaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus: Integer; pBloqueado : Integer; pListaZona: String; pCurva: String; pBuscaParcial, pLimit, pOffSet : Integer): TjSonArray;
Var Query, QueryData : TFdQuery;
begin
  Query     := TFDQuery.Create(nil);
  QueryData := TFDQuery.Create(nil);
  Try
    Query.Connection     := Connection;
    QueryData.Connection := Connection;
    try
      Query.Sql.Add('Declare @EnderecoId Integer = ' + pEnderecoId.ToString());
      Query.Sql.Add('Declare @EstruturaId Integer = ' + pEstruturaId.ToString());
      Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
      Query.Sql.Add('Declare @Ruaid Integer  = ' + pRuaId.ToString());
      Query.Sql.Add('Declare @EnderecoIni VarChar(40) = ' + #39 +pEnderecoIni + #39);
      Query.Sql.Add('Declare @EnderecoFin VarChar(40) = ' + #39 +pEnderecoFin + #39);
      Query.Sql.Add('Declare @OcupacaoEndereco Varchar(1) = ' + #39 +pOcupacaoEndereco + #39);
      Query.Sql.Add('Declare @Curva Varchar(30)           = ' + #39 +pCurva + #39);
      Query.Sql.Add('Declare @Status Integer = ' + pStatus.ToString());
      Query.Sql.Add('Declare @Bloqueado Integer = ' + pBloqueado.ToString());
      Query.SQL.Add('if object_id ('+#39+'tempdb..#Endereco'+#39+') is not null drop table #Endereco');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#Estoq'+#39+') is not null drop table #Estoq');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstPulmao'+#39+') is not null drop table #EstPulmao');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstSegregado'+#39+') is not null drop table #EstSegregado');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstPicking'+#39+') is not null drop table #EstPicking');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstReserva'+#39+') is not null drop table #EstReserva');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstRepo'+#39+') is not null drop table #EstRepo');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstProd'+#39+') is not null drop table #EstProd');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#EstDet'+#39+') is not null drop table #EstDet');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#MaxProcesso'+#39+') is not null drop table #MaxProcesso');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#BloqInv'+#39+') is not null drop table #BloqInv');
      Query.Sql.Add('select vEnd.enderecoid, vEnd.Endereco descricao, Cast(vEnd.altura as Decimal(15,3)) altura, Cast(vEnd.largura as Decimal(15,3)) largura,');
      Query.Sql.Add('                    Cast(vEnd.comprimento as Decimal(15,3)) comprimento, Cast(vEnd.volume as Decimal(20,6)) volume, Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
      Query.Sql.Add('                    vEnd.status, vEnd.bloqueado, vEnd.bloqueioinventario, vEnd.EstruturaId, vEnd.estrutura, vEnd.PickingFixo, vEnd.Mascara,');
      Query.Sql.Add('                    vEnd.Ruaid, vEnd.Rua, vEnd.Lado, vEnd.Ordem, vEnd.ZonaId, vEnd.Zona, vEnd.EstoqueTipoId, vEnd.ZonaStatus, vEnd.produtosngpc,');
      Query.Sql.Add('                    vEnd.DesenhoArmazemId, vEnd.DesenhoArmazemDescricao, Coalesce(vEnd.produtoid, 0) ProdutoId, Coalesce(vEnd.codproduto, 0) CodProduto,');
      Query.Sql.Add('                    Coalesce(vEnd.descricao, '+#39+#39+') Produto, (Case When vEnd.Curva is Null then '+#39+#39+' Else vEnd.Curva End) Curva, 0 as Ocupacao Into #Endereco');
      Query.Sql.Add('From vEnderecamentos vEnd');
      Query.Sql.Add('Where (@EnderecoId = 0 or vEnd.EnderecoId = @EnderecoId) and');
      Query.Sql.Add('      (@EstruturaId = 0 or vEnd.EstruturaId = @EstruturaId) and');
      Query.Sql.Add('      (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
      If pListaZona <> '' Then
         Query.Sql.Add('      (vEnd.Zonaid in ('+pListaZona+')) and ');
      Query.Sql.Add('      (@RuaId  = 0 or vEnd.RuaId  = @RuaId) and');
      Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
      Query.Sql.Add('      (@EnderecoFin = '#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin) and');
      Query.Sql.Add('      ((@OcupacaoEndereco = '+#39+'T'+#39+') or (@OcupacaoEndereco='+#39+'L'+#39+' and vEnd.ProdutoId Is Null) or');
      Query.Sql.Add('      (@OcupacaoEndereco='+#39+'O'+#39+' and vEnd.ProdutoId is Not Null)) And');
      Query.Sql.Add('      (@Curva = '+#39+#39+' or vEnd.Curva = @Curva) and');
      Query.Sql.Add('      (@Status Not In (0,1) or (@Status = Status)) and');
      Query.Sql.Add('      (@Bloqueado <> 1 or (@Bloqueado = vEnd.Bloqueado)) and');
      If pBuscaParcial = 0 then Begin
         Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or vEnd.Endereco >= @EnderecoIni) and');
         Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or vEnd.Endereco <= @EnderecoFin)');
      End
      Else Begin
         Query.Sql.Add('     (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
         Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin)');
      End;
      Query.Sql.Add('');
      Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(Qtde), 0) Qtde Into #Estoq');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = Est.Enderecoid');
      Query.Sql.Add('Group By Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde Into #EstPulmao');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Join #Endereco TEnd On CodigoERP = TEnd.Codproduto');
      Query.Sql.Add('Where Est.EstruturaId <> 2');
      Query.Sql.Add('Group By CodigoERP');
      Query.Sql.Add('');
      Query.Sql.Add('Select CodigoERP, Coalesce(Sum(Qtde), 0) QtdeSegregado Into #EstSegregado');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Join #Endereco TEnd On CodigoERP = TEnd.Codproduto');
      Query.Sql.Add('Where Est.EstruturaId <> 2 and Est.ZonaID = 3');
      Query.Sql.Add('Group By CodigoERP');
      Query.Sql.Add('');
      Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeProducao), 0) Qtde Into #EstPicking');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
      Query.Sql.Add('Where Est.EstruturaId = 2');
      Query.Sql.Add('Group By Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeReserva), 0) Qtde Into #EstReserva');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
      Query.Sql.Add('Group By Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select ET.EnderecoId, Coalesce(Sum(ET.Qtde), 0) Qtde Into #EstRepo');
      Query.Sql.Add('From ReposicaoEstoqueTransferencia ET');
      Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = ET.EnderecoId');
      Query.Sql.Add('Where ET.Qtde > 0');
      Query.Sql.Add('Group By ET.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select vEst.EnderecoId,');
      Query.Sql.Add('       Cast(Sum(Prd.Volume*vEst.Qtde) As decimal(15,2)) Ocupacao2,');
      Query.Sql.Add('       Cast(Sum(Cast( Prd.Volume*vEst.Qtde As decimal(15,2))');
      Query.Sql.Add('                / Cast( (Case When TEnd.Volume <=0 then (120*120*100) else TEnd.Volume End) as Decimal(15,2)))');
      Query.Sql.Add('						                     * 100 as decimal(15,2)) Ocupacao Into #EstProd');
      Query.Sql.Add('From vEstoque vEst');
      Query.Sql.Add('join vProduto Prd on Prd.CodProduto = vEst.CodigoERP');
      Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = vEst.EnderecoId');
      Query.Sql.Add('Where vEst.Producao = 1 and vEst.Qtde > 0');
      Query.Sql.Add('Group By vEst.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('select Est.Enderecoid, Count(*) Sku,');
      Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (1,4) then Qtde Else 0 End) QtdeProducao,');
      Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (6) then Qtde Else 0 End) QtdeReserva,');
      Query.Sql.Add('                   sum(Case when Est.estoqueTipoId Not in (1, 4, 6) then Qtde Else 0 End) QtdeOutros Into #EstDet');
      Query.Sql.Add('from Estoque Est');
      Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
      Query.Sql.Add('Group by Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('SELECT Inv.InventarioId,  MAX(De.ProcessoId) AS ProcessoId Into #MaxProcesso');
      Query.Sql.Add('FROM  DocumentoEtapas De');
      Query.Sql.Add('INNER JOIN  inventarios Inv On Inv.uuid = De.Documento');
      Query.Sql.Add('GROUP BY Inv.InventarioId');
      Query.Sql.Add('');
      Query.Sql.Add('Select II.Enderecoid, COUNT(*) TotalEndereco Into #BloqInv');
      Query.Sql.Add('From inventarioitens II');
      Query.Sql.Add('Inner join inventarios I On I.inventarioid = II.inventarioid');
      Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = II.enderecoid');
      Query.Sql.Add('Inner Join #MaxProcesso De On De.InventarioId = II.InventarioId');
      Query.Sql.Add('where De.ProcessoId < 143');
      Query.Sql.Add('Group by II.EnderecoId');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelEnderecoLista01.Sql');
      Query.ExecSQL;

      QueryData.Sql.Add('');
      QueryData.Sql.Add('Select (');
      QueryData.Sql.Add('');
      QueryData.Sql.Add('select TEnd.enderecoid, TEnd.descricao,');
      QueryData.Sql.Add('       Cast(TEnd.altura as Decimal(15,3)) altura,');
      QueryData.Sql.Add('       Cast(TEnd.largura as Decimal(15,3)) largura,');
      QueryData.Sql.Add('	   Cast(TEnd.comprimento as Decimal(15,3)) comprimento,');
      QueryData.Sql.Add('       Cast(TEnd.volume as Decimal(20,6)) volume,');
      QueryData.Sql.Add('	   Cast(TEnd.capacidade as Decimal(15,3)) capacidade,');
      QueryData.Sql.Add('       TEnd.status, TEnd.bloqueado, TEnd.bloqueioinventario,');
      QueryData.Sql.Add('       TEnd.EstruturaId as '+#39+'enderecoestrutura.estruturaid'+#39+', TEnd.estrutura as '+#39+'enderecoestrutura.descricao'+#39+',');
      QueryData.Sql.Add('       TEnd.PickingFixo as '+#39+'enderecoestrutura.pickingfixo'+#39+', TEnd.Mascara as '+#39+'enderecoestrutura.mascara'+#39+',');
      QueryData.Sql.Add('       TEnd.Ruaid as '+#39+'enderecorua.ruaid'+#39+', TEnd.Rua as '+#39+'enderecorua.descricao'+#39+',');
      QueryData.Sql.Add('       TEnd.Lado as '+#39+'enderecorua.lado'+#39+', TEnd.Ordem as '+#39+'enderecorua.ordem'+#39+',');
      QueryData.Sql.Add('       TEnd.ZonaId as '+#39+'enderecamentozona.zonaid'+#39+', TEnd.Zona as '+#39+'enderecamentozona.descricao'+#39+',');
      QueryData.Sql.Add('       TEnd.EstoqueTipoId as '+#39+'enderecamentozona.estoquetipoid'+#39+', TEnd.ZonaStatus as '+#39+'enderecamentozona.status'+#39+',');
      QueryData.Sql.Add('       TEnd.produtosngpc as '+#39+'enderecamentozona.produtosngpc'+#39+', TEnd.DesenhoArmazemId AS '+#39+'desenhoarmazem.Id'+#39+',');
      QueryData.Sql.Add('       TEnd.DesenhoArmazemDescricao AS '+#39+'desenhoarmazem.descricao'+#39+',');
      QueryData.Sql.Add('       IsNull(TEnd.produtoid, 0) as '+#39+'produto.produtoid'+#39+',');
      QueryData.Sql.Add('	   IsNull(TEnd.codproduto, 0) as '+#39+'produto.codproduto'+#39+',');
      QueryData.Sql.Add('       IsNull(TEnd.Produto, '+#39+#39+') as '+#39+'produto.descricao'+#39+',');
      QueryData.Sql.Add('  	   IsNull(Est.Qtde, 0) as '+#39+'produto.qtde'+#39+',');
      QueryData.Sql.Add('	   IsNull(EPu.Qtde, 0) as '+#39+'produto.qtdepulmao'+#39+',');
      QueryData.Sql.Add('	   IsNull(ESeg.QtdeSegregado, 0) as '+#39+'produto.qtdesegregado'+#39+',');
      QueryData.Sql.Add('       IsNull(EPi.Qtde, 0) as '+#39+'produto.qtdepicking'+#39+',');
      QueryData.Sql.Add('       IsNull(ER.Qtde, 0) as '+#39+'produto.qtdereserva'+#39+',');
      QueryData.Sql.Add('       IsNull(ERep.Qtde, 0) as '+#39+'produto.qtdetransferencia'+#39+',');
      QueryData.Sql.Add('       (Case When IsNull(EP.Ocupacao, 0) > 0 then EP.Ocupacao Else 0 End) Ocupacao,');
      QueryData.Sql.Add('       (Case When TEnd.Curva is Null then '+#39+#39+' Else TEnd.Curva End) Curva,');
      QueryData.Sql.Add('       IsNull(ED.QtdeProducao, 0) QtdeProducao, IsNull(ER.Qtde, 0) QtdeReserva,');
      QueryData.Sql.Add('       IsNull(ED.QtdeOutros, 0) QtdeOutros, IsNull(ED.Sku, 0) Sku');
      QueryData.Sql.Add('	  , (Case When IsNull(Bi.TotalEndereco, 0) > 0 then 1 Else 0 End) reservadoinventario');
      QueryData.Sql.Add('From #Endereco TEnd');
      QueryData.Sql.Add('Left Join #Estoq Est On Est.EnderecoId = TEnd.EnderecoId');
      QueryData.Sql.Add('Left Join #EstPulmao EPu On EPu.CodigoERP = TEnd.CodProduto');
      QueryData.Sql.Add('Left Join #EstSegregado ESeg On ESeg.CodigoERP = TEnd.CodProduto');
      QueryData.Sql.Add('Left Join #EstPicking EPi On EPi.EnderecoId = TEnd.EnderecoId');
      QueryData.Sql.Add('Left Join #EstReserva ER On ER.EnderecoId = TEnd.EnderecoId');
      QueryData.Sql.Add('Left Join #EstRepo ERep On ERep.EnderecoId = TEnd.EnderecoId');
      QueryData.Sql.Add('Left Join #EstProd EP On EP.EnderecoId = TEnd.EnderecoId');
      QueryData.Sql.Add('Left Join #EstDet ED On ED.EnderecoId = TEnd.EnderecoId');
      QueryData.Sql.Add('Left Join #BloqInv BI On BI.enderecoid = TEnd.EnderecoId');
      QueryData.Sql.Add('Order by TEnd.Descricao');
      If pLimit <> 0 then Begin
         QueryData.Sql.Add('OFFSET '+pOffSet.ToString()+'ROWS ');//+' * '+pLimit.ToString()+' ROWS');
         QueryData.Sql.Add('FETCH NEXT '+pLimit.ToString()+' ROWS ONLY');
      End;
      QueryData.Sql.Add('For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno');
//      QueryData.SQL.Add('Drop Table #Endereco, #Estoq, #EstPulmao, #EstPicking, #EstReserva, #EstRepo, #EstProd, #EstDet, #BloqInv, #MaxProcesso, #EstSegregado');
      if DebugHook <> 0 then
         QueryData.Sql.SaveToFile('RelEnderecoLista02.Sql');
      QueryData.Open;
      if (QueryData.IsEmpty) or (QueryData.FieldByName('ConsultaRetorno').AsString = '') Then Begin
         If pLimit = 0 then Begin
            Result := TjSonArray.Create;
            Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Endereço não encontrado.'));
         End
         Else
            Raise Exception.Create('Endereço não encontrado.');
      End
      Else
         Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(QueryData.FieldByName('ConsultaRetorno').AsString), 0) as TjSonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Enderecamentos - ' + TUtil.TratarExcessao(E.Message) );
      End;
    end;
  Finally
    Query.Free;
    QueryData.Free;
  End;
end;

function TEnderecoDao.GetListaRecordCount(pEnderecoId, pEstruturaId, pZonaId,
  pRuaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus, pBloqueado: Integer; pListaZona, pCurva: String; pBuscaParcial,
  pLimit, pOffSet: Integer): Integer;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('Declare @EnderecoId Integer = ' + pEnderecoId.ToString());
      Query.Sql.Add('Declare @EstruturaId Integer = ' + pEstruturaId.ToString());
      Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
      Query.Sql.Add('Declare @Ruaid Integer  = ' + pRuaId.ToString());
      Query.Sql.Add('Declare @EnderecoIni VarChar(40) = ' + #39 +pEnderecoIni + #39);
      Query.Sql.Add('Declare @EnderecoFin VarChar(40) = ' + #39 +pEnderecoFin + #39);
      Query.Sql.Add('Declare @OcupacaoEndereco Varchar(1) = ' + #39 +pOcupacaoEndereco + #39);
      Query.Sql.Add('Declare @Curva Varchar(30)           = ' + #39 +pCurva + #39);
      Query.Sql.Add('Declare @Status Integer = ' + pStatus.ToString());
      Query.Sql.Add('Declare @Bloqueado Integer = ' + pBloqueado.ToString());
      Query.Sql.Add('select vEnd.enderecoid, vEnd.Endereco descricao, Cast(vEnd.altura as Decimal(15,3)) altura, Cast(vEnd.largura as Decimal(15,3)) largura,');
      Query.Sql.Add('                    Cast(vEnd.comprimento as Decimal(15,3)) comprimento, Cast(vEnd.volume as Decimal(20,6)) volume, Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
      Query.Sql.Add('                    vEnd.status, vEnd.bloqueado, vEnd.bloqueioinventario, vEnd.EstruturaId, vEnd.estrutura, vEnd.PickingFixo, vEnd.Mascara,');
      Query.Sql.Add('                    vEnd.Ruaid, vEnd.Rua, vEnd.Lado, vEnd.Ordem, vEnd.ZonaId, vEnd.Zona, vEnd.EstoqueTipoId, vEnd.ZonaStatus, vEnd.produtosngpc,');
      Query.Sql.Add('                    vEnd.DesenhoArmazemId, vEnd.DesenhoArmazemDescricao, Coalesce(vEnd.produtoid, 0) ProdutoId, Coalesce(vEnd.codproduto, 0) CodProduto,');
      Query.Sql.Add('                    Coalesce(vEnd.descricao, '+#39+#39+') Produto, (Case When vEnd.Curva is Null then '+#39+#39+' Else vEnd.Curva End) Curva, 0 as Ocupacao Into #Endereco');
      Query.Sql.Add('From vEnderecamentos vEnd');
      Query.Sql.Add('Where (@EnderecoId = 0 or vEnd.EnderecoId = @EnderecoId) and');
      Query.Sql.Add('      (@EstruturaId = 0 or vEnd.EstruturaId = @EstruturaId) and');
      Query.Sql.Add('      (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
      Query.Sql.Add('      (@RuaId  = 0 or vEnd.RuaId  = @RuaId) and');
      Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
      Query.Sql.Add('      (@EnderecoFin = '#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin) and');
      Query.Sql.Add('      ((@OcupacaoEndereco = '+#39+'T'+#39+') or (@OcupacaoEndereco='+#39+'L'+#39+' and vEnd.ProdutoId Is Null) or');
      Query.Sql.Add('      (@OcupacaoEndereco='+#39+'O'+#39+' and vEnd.ProdutoId is Not Null)) And');
      Query.Sql.Add('      (@Curva = '+#39+#39+' or vEnd.Curva = @Curva) and');
      Query.Sql.Add('      (@Status Not In (0,1) or (@Status = Status)) and');
      Query.Sql.Add('      (@Bloqueado <> 1 or (@Bloqueado = vEnd.Bloqueado)) and');
      If pBuscaParcial = 0 then Begin
         Query.Sql.Add('      (@EnderecoIni = '+#39+#39+' or vEnd.Endereco >= @EnderecoIni) and');
         Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or vEnd.Endereco <= @EnderecoFin)');
      End
      Else Begin
         Query.Sql.Add('     (@EnderecoIni = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))>=@EnderecoIni) and');
         Query.Sql.Add('      (@EnderecoFin = '+#39+#39+' or SubString(vEnd.Endereco, 1, Len(@EnderecoIni))<=@EnderecoFin)');
      End;
      Query.Sql.Add('');
      Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(Qtde), 0) Qtde Into #Estoq');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = Est.Enderecoid');
      Query.Sql.Add('Group By Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde Into #EstPulmao');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Join #Endereco TEnd On CodigoERP = TEnd.Codproduto');
      Query.Sql.Add('Where Est.EstruturaId <> 2');
      Query.Sql.Add('Group By CodigoERP');
      Query.Sql.Add('');
      Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeProducao), 0) Qtde Into #EstPicking');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
      Query.Sql.Add('Where Est.EstruturaId = 2');
      Query.Sql.Add('Group By Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select Est.EnderecoId, Coalesce(Sum(QtdeReserva), 0) Qtde Into #EstReserva');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
      Query.Sql.Add('Group By Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select ET.EnderecoId, Coalesce(Sum(ET.Qtde), 0) Qtde Into #EstRepo');
      Query.Sql.Add('From ReposicaoEstoqueTransferencia ET');
      Query.Sql.Add('Inner Join #Endereco TEnd On TEnd.EnderecoId = ET.EnderecoId');
      Query.Sql.Add('Where ET.Qtde > 0');
      Query.Sql.Add('Group By ET.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('Select vEst.EnderecoId,');
      Query.Sql.Add('       Cast(Sum(Prd.Volume*vEst.Qtde) As decimal(15,2)) Ocupacao2,');
      Query.Sql.Add('       Cast(Sum(Cast( Prd.Volume*vEst.Qtde As decimal(15,2))');
      Query.Sql.Add('                / Cast( (Case When TEnd.Volume <=0 then 1 else TEnd.Volume End) as Decimal(15,2)))');
      Query.Sql.Add('						                     * 100 as decimal(15,2)) Ocupacao Into #EstProd');
      Query.Sql.Add('From vEstoque vEst');
      Query.Sql.Add('join vProduto Prd on Prd.CodProduto = vEst.CodigoERP');
      Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = vEst.EnderecoId');
      Query.Sql.Add('Where vEst.Producao = 1 and vEst.Qtde > 0');
      Query.Sql.Add('Group By vEst.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('select Est.Enderecoid, Count(*) Sku,');
      Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (1,4) then Qtde Else 0 End) QtdeProducao,');
      Query.Sql.Add('                   sum(Case when Est.estoqueTipoId in (6) then Qtde Else 0 End) QtdeReserva,');
      Query.Sql.Add('                   sum(Case when Est.estoqueTipoId Not in (1, 4, 6) then Qtde Else 0 End) QtdeOutros Into #EstDet');
      Query.Sql.Add('from Estoque Est');
      Query.Sql.Add('Join #Endereco TEnd On TEnd.EnderecoId = Est.EnderecoId');
      Query.Sql.Add('Group by Est.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('SELECT Inv.InventarioId,  MAX(De.ProcessoId) AS ProcessoId Into #MaxProcesso');
      Query.Sql.Add('FROM  DocumentoEtapas De');
      Query.Sql.Add('INNER JOIN  inventarios Inv On Inv.uuid = De.Documento');
      Query.Sql.Add('GROUP BY Inv.InventarioId');
      Query.Sql.Add('');
      Query.Sql.Add('Select II.Enderecoid, COUNT(*) TotalEndereco Into #BloqInv');
      Query.Sql.Add('From inventarioitens II');
      Query.Sql.Add('Inner join inventarios I On I.inventarioid = II.inventarioid');
      Query.Sql.Add('Inner join #Endereco TEnd On TEnd.EnderecoId = II.enderecoid');
      Query.Sql.Add('Inner Join #MaxProcesso De On De.InventarioId = II.InventarioId');
      Query.Sql.Add('where De.ProcessoId < 143');
      Query.Sql.Add('Group by II.EnderecoId');
      Query.Sql.Add('');
      Query.Sql.Add('select Count(*) TotalRegistro');
      Query.Sql.Add('From #Endereco TEnd');
      Query.Sql.Add('Left Join #Estoq Est On Est.EnderecoId = TEnd.EnderecoId');
      Query.Sql.Add('Left Join #EstPulmao EPu On EPu.CodigoERP = TEnd.CodProduto');
      Query.Sql.Add('Left Join #EstPicking EPi On EPi.EnderecoId = TEnd.EnderecoId');
      Query.Sql.Add('Left Join #EstReserva ER On ER.EnderecoId = TEnd.EnderecoId');
      Query.Sql.Add('Left Join #EstRepo ERep On ERep.EnderecoId = TEnd.EnderecoId');
      Query.Sql.Add('Left Join #EstProd EP On EP.EnderecoId = TEnd.EnderecoId');
      Query.Sql.Add('Left Join #EstDet ED On ED.EnderecoId = TEnd.EnderecoId');
      Query.Sql.Add('Left Join #BloqInv BI On BI.enderecoid = TEnd.EnderecoId');
      Query.SQL.Add('Drop Table #Endereco, #Estoq, #EstPulmao, #EstPicking, #EstReserva, #EstRepo, #EstProd, #EstDet, #BloqInv, #MaxProcesso');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelEnderecoListaRecordCount.Sql');
      Query.Open;
      if (Query.IsEmpty) Then Begin
         Result := 0
      End
      Else Begin
         Result := Query.FieldByName('TotalRegistro').AsInteger;
      End;
    Except ON E: Exception do
      Begin
        Result := 0;
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetMotivoMovimentacaoSegregado: TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('Select EnderecoId, Endereco, Mascara, ZonaId From vEnderecamentos');
      Query.Sql.Add('Where ZonaId in (1, 3) And Status = 1');
      Query.Sql.Add('Order By ZonaId, Endereco');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há dados para gerar o relatório'));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Processo: GetMotivoMovimentacaoSegregado'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetPickingMask: TjSonArray;
Var Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Open('Select Mascara From EnderecamentoEstruturas'+sLineBreak+
                 'where Descricao = ' + QuotedStr('Picking'));
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('mascara', Query.FieldByName('Mascara').AsString)));
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Processo: GetPickingMask'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetReUsoPicking(pZonaId, pDias: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlReUsoPicking);
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pDias').Value   := pDias;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelReUsoPicking.Sql');
      Query.Open;
      if (Query.IsEmpty) Then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há picking disponível para ReUso.'));
      End
      Else
        Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Enderecamento - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.GetZona(pEstruturaId: Integer): TjSonArray;
Var vSql  : String;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := SqlEndereco;
      vSql := vSql + #13 + #10 + ' where ZonaId = ' + pEstruturaId.ToString();
      Query.Open(vSql);
      while Not Query.Eof do
      Begin
        With ObjEnderecoDAO do
        Begin
          EnderecoId := Query.FieldByName('EnderecoId').AsInteger;
          EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
          EnderecoEstrutura.Descricao   := Query.FieldByName('Estrutura').AsString;
          EnderecamentoZona.ZonaId      := Query.FieldByName('ZonaId').AsInteger;
          EnderecamentoZona.Descricao   := Query.FieldByName('Zona').AsString;
          Descricao         := Query.FieldByName('Endereco').AsString;
          DesenhoArmazem.Id := Query.FieldByName('DesenhoArmazemId').AsInteger;
          Altura            := Query.FieldByName('Altura').AsFloat;
          largura           := Query.FieldByName('Largura').AsFloat;
          Comprimento       := Query.FieldByName('Comprimento').AsFloat;
          Volume            := Query.FieldByName('Volume').AsFloat;
          Capacidade        := Query.FieldByName('Capacidade').AsFloat;
          Curva             := Query.FieldByName('Curva').AsString;
          Status            := Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
          Query.Next;
        End;
      end;
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Processo: GetZona - '+TUtil.TratarExcessao(E.Message))
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.InsertUpdate(pJsonEndereco: TJsonObject): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
     try
      if pJsonEndereco.GetValue<Integer>('enderecoId') = 0 then
        vSql := 'Insert Into Enderecamentos (RuaId, EstruturaId, ZonaId, Descricao, DesenhoArmazemID, Altura, Largura, Comprimento, Volume, Capacidade, Curva, Status) Values ('+sLineBreak+
                pJsonEndereco.GetValue<TJsonObject>('enderecoRua').GetValue<Integer>('ruaId').ToString() + ', ' +sLineBreak+
                pJsonEndereco.GetValue<TJsonObject>('enderecoEstrutura').GetValue<Integer>('estruturaId').ToString() + ', ' +sLinebreak+
                pJsonEndereco.GetValue<TJsonObject>('enderecamentoZona').GetValue<Integer>('zonaId').ToString() + ', ' +sLinebreak+
                QuotedStr(pJsonEndereco.GetValue<String>('descricao')) + ', ' +sLineBreak+
                pJsonEndereco.GetValue<TJsonObject>('desenhoArmazem').GetValue<Integer>('id').ToString() + ', ' +sLineBreak+
                StringReplace(pJsonEndereco.GetValue<double>('altura').ToString(), ',', '.', [rfReplaceAll]) + ', ' +sLineBreak+
                StringReplace(pJsonEndereco.GetValue<double>('largura').ToString(), ',', '.', [rfReplaceAll]) + ', ' +sLineBreak+
                StringReplace(pJsonEndereco.GetValue<double>('comprimento').ToString(), ',', '.', [rfReplaceAll]) + ', ' +sLineBreak+
                StringReplace(pJsonEndereco.GetValue<double>('volume').ToString(), ',','.', [rfReplaceAll]) + ', ' +sLineBreak+
                StringReplace(pJsonEndereco.GetValue<double>('capacidade').ToString(), ',', '.', [rfReplaceAll]) + ', ' +sLineBreak+
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
      Query.Sql.Add(vSql);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('EnderecoInsert.Sql');
      Query.ExecSQL;
      Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: Insert/Update - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
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
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
     try
      Query.Connection.StartTransaction;
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
              Query.Close;
              Query.Sql.Clear;
              Query.Sql.Add('Update Enderecamentos Set');
              vComplAcao := '';
              for vQtAcao := 0 to Pred(pJsonManutencao.GetValue<TJsonArray>('acao').Count) do Begin
                vAcao := pJsonManutencao.GetValue<TJsonArray>('acao').Items[vQtAcao].GetValue<String>('acao');
                if vAcao = 'ativar' Then Begin
                   Query.Sql.Add('   '+vComplAcao+'Status = 1');
                   vComplAcao:= ', ';
                End
                Else if vAcao = 'desativar' then Begin
                   Query.Sql.Add('   '+vComplAcao+'Status = 0');
                   vComplAcao:= ', ';
                End
                Else if vAcao = 'bloquear' then Begin
                   Query.Sql.Add('   '+vComplAcao+'Bloqueado = 1');
                   vComplAcao:= ', ';
                End
                Else if vAcao = 'desbloquear' then Begin
                   Query.Sql.Add('   '+vComplAcao+'Bloqueado = 0');
                   vComplAcao:= ', ';
                End
              End;
              Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(vEndereco) + ')');
           End
           Else if vOperacao = 'MudarZona' then Begin
              Query.Close;
              Query.Sql.Clear;
              Query.Sql.Add('Update Enderecamentos');
              Query.Sql.Add('  Set ZonaId = ' + vZonaId.ToString());
              Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
           End
           Else if vOperacao = 'QuebraRuaPicking' then Begin
              Query.Close;
              Query.Sql.Clear;
              Query.Sql.Add('Update Enderecamentos');
              Query.Sql.Add('  Set RuaId = ' + vRuaId.ToString());
              Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
           End
           Else if vOperacao = 'Cubagem' then Begin
             Query.Close;
             Query.Sql.Clear;
             Query.Sql.Add('Update Enderecamentos');
             Query.Sql.Add('  Set Altura      = ' + StringReplace(vAltura.ToString(), ',', '.', [rfReplaceAll]));
             Query.Sql.Add('    , Largura     = ' + StringReplace(vLargura.ToString(), ',', '.', [rfReplaceAll]));
             Query.Sql.Add('    , Comprimento = ' + StringReplace(vComprimento.ToString(), ',', '.', [rfReplaceAll]));
             Query.Sql.Add('    , Capacidade  = ' + StringReplace(vPeso.ToString(), ',', '.', [rfReplaceAll]));
             Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
           End
           Else if vOperacao = 'Excluir' then
           Begin
             Query.Close;
             Query.Sql.Clear;
             Query.Sql.Add('Delete Enderecamentos');
             Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
           End
           Else if vOperacao = 'RemoverVinculo' then
           Begin
             Query.Close;
             Query.Sql.Clear;
             Query.Sql.Add('update Produto');
             Query.Sql.Add('  Set EnderecoId = Null');
             Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '+QuotedStr(vEndereco) + ')');
           End;
           if DebugHook <> 0 then
              Query.Sql.SaveToFile('EnderecoManutencao.Sql');
           Query.ExecSQL;
         End;
      End
      Else
      Begin
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('update Produto');
        Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
        Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');
        Query.Sql.Add('update Estoque');
        Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
        Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');
        //Volumes Pendentes
  //      Query.Sql.Add('update Estoque');
  //      Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
  //      Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');

        Query.Sql.Add('update ReposicaoEstoqueTransferencia');
        Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
        Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');

        if DebugHook <> 0 then
           Query.Sql.SaveToFile('EnderecoManutencao_TransfPicking.Sql');
        Query.ExecSQL;
      End;
      Result := TJsonObject.Create.AddPair('Ok', 'Manutenção realizado com sucesso!');
      Query.Connection.Commit;
    Except ON E: Exception do
      Begin
        Query.Connection.Rollback;
        Raise Exception.Create('Tabela: Manutenção de Enderecamento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.MontarPaginacao: TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Open('Select Count(*) Paginacao From Enderecamento');
      Result.AddPair('paginacao', TJsonNumber.Create(Query.FieldByName('Paginacao').AsInteger));
    Except On E: Exception do
      Begin
        Raise Exception.Create(E.Message);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoDao.PutDesvincularPicking(pJsonArray: TjSonArray): TjSonArray;
var vSql: String;
    xEndereco: Integer;
    vParamSize: Integer;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    try
      Query.Close;
      Query.Sql.Add('Update Produto Set EnderecoId = Null Where EnderecoId = :pEnderecoId');
      Query.Params.ArraySize := pJsonArray.Count;
      for xEndereco := 0 to Pred(pJsonArray.Count) do Begin
        Query.Params[0].Values[xEndereco] := pJsonArray.Items[xEndereco].GetValue<Integer>('enderecoid');
      End;
      Query.Execute(Query.Params.ArraySize, 0);
      Query.connection.Commit;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Picking`s Liberados'));
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        Raise Exception.Create('Tabela: PutDesvinculaPicking - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
