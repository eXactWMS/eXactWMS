{
  Micro Servico - DAO - pessoaDAO
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.pessoaDAO;

interface

uses
  FireDAC.Comp.Client, pessoaClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.utils,
  System.Generics.Collections, System.JSON, REST.JSON, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TpessoaDao = class(TBasicDao)
  private
    
    

    FObjPessoaDAO: TPessoa;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function PessoaInsert: TjSonArray;
    function InsertUpdate(pId: Integer; pCodPessoa: Integer; pRazao: String;
      pFantasia: String; pPessoaTipoID: Integer; pCnpjCpf: String;
      pFone: String; pEmail: String; pHomePage: String; pShelfLife: Integer;
      pStatus: Integer; pRotaId, pTransportadoraId: Integer): TjSonArray;
    function GetId(pId, pPessoaTipoID: Integer): TjSonArray;
    function GetPessoa4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    function GetPessoaId(pPessoaId, pPessoaTipoID, pCodPessoaERP: Integer;
      pRazao, pFantasia: String): TjSonArray;
    function GetCodigoERP(pCodigoERP, pPessoaTipoID: Integer): TjSonArray;
    function GetDescricao(pNome: String; pPessoaTipoID: Integer): TjSonArray;
    Function Delete(pId, pPessoaTipoID: Integer): Boolean;
    Function PessoaEstrutura: TjSonArray;
    Function Import(pJsonArray: TjSonArray): TjSonArray;
    Function GetAddressVolume(pCodPessoa: Integer): TjSonArray;
    Property ObjPessoaDAO: TPessoa Read FObjPessoaDAO Write FObjPessoaDAO;
  end;

implementation

uses uSistemaControl, Constants;

{ TpessoaDao }

constructor TpessoaDao.Create;
begin
  ObjPessoaDAO := TPessoa.Create;
  inherited;
end;

function TpessoaDao.Delete(pId, pPessoaTipoID: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from pessoa where PessoaId = ' + pId.ToString +
      ' and PessoaTipoID = ' + pPessoaTipoID.ToString();
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TpessoaDao.Destroy;
begin
  
  ObjPessoaDAO.Free;
  inherited;
end;

function TpessoaDao.GetAddressVolume(pCodPessoa: Integer): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add
      ('select Endereco, Complemento, Cep, Bairro, Municipio, Uf');
    FConexao.Query.SQL.Add('from PessoaEndereco');
    FConexao.Query.SQL.Add
      ('where PessoaId = (Select PessoaId From Pessoa where CodPessoaERP =  ' +
      pCodPessoa.ToString() + ' and PessoaTipoId = 1 ) ');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));;
    end;
  End;
end;

function TpessoaDao.GetCodigoERP(pCodigoERP, pPessoaTipoID: Integer)
  : TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := 'Select P.*, T.PessoaTipoId, T.Descricao, T.Status as PessoaTipoStatus, RP.RotaId '
      + 'From Pessoa P ' +
      'Inner join PessoaTipo T On T.PessoaTipoId= P.PessoaTipoId ' +
      'Left Join RotaPessoas RP On Rp.Pessoaid = P.PessoaId' + sLineBreak +
      'Where P.PessoaTipoID = ' + pPessoaTipoID.ToString();
    if pCodigoERP <> 0 then
      vSql := vSql + ' And P.CodPessoaERP = ' + pCodigoERP.ToString;
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      ObjPessoaDAO.pessoaid := FConexao.Query.FieldByName('PessoaId').AsInteger;
      ObjPessoaDAO.CodPessoa := FConexao.Query.FieldByName('CodPessoaERP').AsInteger;
      ObjPessoaDAO.Razao := FConexao.Query.FieldByName('Razao').AsString;
      ObjPessoaDAO.Fantasia := FConexao.Query.FieldByName('Fantasia').AsString;
      // JSon PessoaTipo
      ObjPessoaDAO.PessoaTipo.PessoaTipoId := FConexao.Query.FieldByName('PessoaTipoId')
        .AsInteger;
      ObjPessoaDAO.PessoaTipo.Descricao :=
        FConexao.Query.FieldByName('Descricao').AsString;
      ObjPessoaDAO.PessoaTipo.Status := FConexao.Query.FieldByName('PessoaTipoStatus')
        .AsInteger;
      ObjPessoaDAO.Fone := FConexao.Query.FieldByName('Fone').AsString;
      ObjPessoaDAO.CnpjCpf := FConexao.Query.FieldByName('CnpjCpf').AsString;
      ObjPessoaDAO.Email := FConexao.Query.FieldByName('Email').AsString;
      ObjPessoaDAO.HomePage := FConexao.Query.FieldByName('HomePage').AsString;
      ObjPessoaDAO.ShelfLife := FConexao.Query.FieldByName('ShelfLife').AsInteger;
      ObjPessoaDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
      ObjPessoaDAO.RotaId := FConexao.Query.FieldByName('RotaId').AsInteger;
      ObjPessoaDAO.Transportadoraid := FConexao.Query.FieldByName('TransportadoraId')
        .AsInteger;
      ObjPessoaDAO.GoogleMaps := FConexao.Query.FieldByName('GoogleMaps').AsString;
      ObjPessoaDAO.Latitude := FConexao.Query.FieldByName('Latitude').AsString;
      ObjPessoaDAO.Longitude := FConexao.Query.FieldByName('Longitude').AsString;
      Result.AddElement(tJson.ObjectToJsonObject(ObjPessoaDAO,
        [joDateFormatISO8601]));
      // (ObjPessoaDAO.ClassToJson(ObjPessoaDAO).ToString);
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TpessoaDao.GetDescricao(pNome: String; pPessoaTipoID: Integer)
  : TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := 'Select P.*, T.PessoaTipoId, T.Descricao, T.Status as PessoaTipoStatus, Rp.RotaId '
      + 'From Pessoa P ' +
      'Inner join PessoaTipo T On T.PessoaTipoId= P.PessoaTipoId ' + sLineBreak
      + 'Left Join RotaPessoas RP On Rp.Pessoaid = P.PessoaId '+sLineBreak;
    vSql := vSql + 'where  ' + '(Razao like ' + QuotedStr('%' + pNome + '%') +
      ') and P.PessoaTipoId = ' + pPessoaTipoID.ToString();
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      ObjPessoaDAO.pessoaid := FConexao.Query.FieldByName('PessoaId').AsInteger;
      ObjPessoaDAO.CodPessoa := FConexao.Query.FieldByName('CodPessoaERP').AsInteger;
      ObjPessoaDAO.Razao := FConexao.Query.FieldByName('Razao').AsString;
      ObjPessoaDAO.Fantasia := FConexao.Query.FieldByName('Fantasia').AsString;
      // JSon PessoaTipo
      ObjPessoaDAO.PessoaTipo.PessoaTipoId := FConexao.Query.FieldByName('PessoaTipoId')
        .AsInteger;
      ObjPessoaDAO.PessoaTipo.Descricao :=
        FConexao.Query.FieldByName('Descricao').AsString;
      ObjPessoaDAO.PessoaTipo.Status := FConexao.Query.FieldByName('PessoaTipoStatus')
        .AsInteger;
      ObjPessoaDAO.Fone := FConexao.Query.FieldByName('Fone').AsString;
      ObjPessoaDAO.CnpjCpf := FConexao.Query.FieldByName('CnpjCpf').AsString;
      ObjPessoaDAO.Email := FConexao.Query.FieldByName('Email').AsString;
      ObjPessoaDAO.HomePage := FConexao.Query.FieldByName('HomePage').AsString;
      ObjPessoaDAO.ShelfLife := FConexao.Query.FieldByName('ShelfLife').AsInteger;
      ObjPessoaDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
      ObjPessoaDAO.RotaId := FConexao.Query.FieldByName('RotaId').AsInteger;
      ObjPessoaDAO.Transportadoraid := FConexao.Query.FieldByName('TransportadoraId')
        .AsInteger;
      ObjPessoaDAO.GoogleMaps := FConexao.Query.FieldByName('GoogleMaps').AsString;
      ObjPessoaDAO.Latitude := FConexao.Query.FieldByName('Latitude').AsString;
      ObjPessoaDAO.Longitude := FConexao.Query.FieldByName('Longitude').AsString;
      Result.Add(tJson.ObjectToJsonObject(ObjPessoaDAO));
      // (ObjPessoaDAO.ClassToJson(ObjPessoaDAO).ToString);
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TpessoaDao.GetId(pId, pPessoaTipoID: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := 'Select P.*, T.PessoaTipoId, T.Descricao, T.Status as PessoaTipoStatus, Rp.RotaId '
      + 'From Pessoa P ' +
      'Inner join PessoaTipo T On T.PessoaTipoId= P.PessoaTipoId ' +
      'Left Join RotaPessoas RP On Rp.Pessoaid = P.PessoaId' + sLineBreak +
      'Where P.PessoaTipoID = ' + pPessoaTipoID.ToString();
    if pId <> 0 then
      vSql := vSql + ' And P.PessoaId = ' + pId.ToString;
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      ObjPessoaDAO.pessoaid := FConexao.Query.FieldByName('PessoaId').AsInteger;
      ObjPessoaDAO.CodPessoa := FConexao.Query.FieldByName('CodPessoaERP').AsInteger;
      ObjPessoaDAO.Razao := FConexao.Query.FieldByName('Razao').AsString;
      ObjPessoaDAO.Fantasia := FConexao.Query.FieldByName('Fantasia').AsString;
      // JSon PessoaTipo
      ObjPessoaDAO.PessoaTipo.PessoaTipoId := FConexao.Query.FieldByName('PessoaTipoId')
        .AsInteger;
      ObjPessoaDAO.PessoaTipo.Descricao :=
        FConexao.Query.FieldByName('Descricao').AsString;
      ObjPessoaDAO.PessoaTipo.Status := FConexao.Query.FieldByName('PessoaTipoStatus')
        .AsInteger;
      ObjPessoaDAO.Fone := FConexao.Query.FieldByName('Fone').AsString;
      ObjPessoaDAO.CnpjCpf := FConexao.Query.FieldByName('CnpjCpf').AsString;
      ObjPessoaDAO.Email := FConexao.Query.FieldByName('Email').AsString;
      ObjPessoaDAO.HomePage := FConexao.Query.FieldByName('HomePage').AsString;
      ObjPessoaDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
      ObjPessoaDAO.RotaId := FConexao.Query.FieldByName('RotaId').AsInteger;
      ObjPessoaDAO.Transportadoraid := FConexao.Query.FieldByName('TransportadoraId')
        .AsInteger;
      ObjPessoaDAO.GoogleMaps := FConexao.Query.FieldByName('GoogleMaps').AsString;
      ObjPessoaDAO.Latitude := FConexao.Query.FieldByName('Latitude').AsString;
      ObjPessoaDAO.Longitude := FConexao.Query.FieldByName('Longitude').AsString;
      ObjPessoaDAO.ShelfLife := FConexao.Query.FieldByName('ShelfLife').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjPessoaDAO,
        [joDateFormatISO8601]));
      // (ObjPessoaDAO.ClassToJson(ObjPessoaDAO).ToString);
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TpessoaDao.GetPessoa4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vSql: String;
  vPessoaTipoid: Integer;
begin
  Try
    vPessoaTipoid := 0;
    if AParams.ContainsKey('pessoatipoid') then
       vPessoaTipoid := AParams.Items['pessoatipoid'].ToInt64;
    if vPessoaTipoid in [1, 2] then
       vSql := 'select P.PessoaId, P.CodPessoaERP, Pt.Descricao, p.Razao, p.Fantasia, p.CnpjCpf, p.Email, Rp.RotaId, R.Descricao Rota, P.ShelfLife, p.Status'+sLineBreak
    Else
       vSql := 'select P.PessoaId, Pt.Descricao, p.Razao, p.Fantasia, p.CnpjCpf, p.Email, Rp.RotaId, R.Descricao Rota, p.Status'+sLineBreak;
    vSql := vSql + 'From Pessoa p'+sLineBreak+
            'Inner Join PessoaTipo Pt On Pt.PessoaTipoId = p.PessoaTipoID'+sLineBreak+
            'Left Join RotaPessoas Rp On Rp.PessoaId = p.PessoaId' + sLineBreak+
            'Left Join Rotas R On R.RotaId = Rp.RotaId' + sLineBreak;
    If (AParams.ContainsKey('disponivelagrupamento')) and (AParams.Items['disponivelagrupamento'].ToInteger = 1) then Begin
       vSql := vSql + 'Left Join (select PessoaId'+sLineBreak+
                      'From Pedido Ped'+sLineBreak+
                      'Inner Join vDocumentoEtapas De On De.Documento = Ped.Uuid'+sLineBreak+
                      'Where DE.ProcessoId = (Select Max(ProcessoId) From vDocumentoEtapas where Documento = Ped.uuid)'+sLineBreak+
                      '  And De.ProcessoId = 1'+sLineBreak+
                      'Group by PessoaId) PedFor On PedFor.PessoaId = P.PessoaId'+sLineBreak;
    End;
    vSql := vSql + 'Where p.PessoaTipoID  = :PessoaTipoId';
    If (AParams.ContainsKey('disponivelagrupamento')) and (AParams.Items['disponivelagrupamento'].ToInteger = 1) then
    Begin
      vSql := vSql + sLineBreak + '  And PedFor.PessoaId Is Not Null ';
    End;
    Result := TJsonObject.Create();
    QryPesquisa := FConexao.GetQuery;
    QryPesquisa.SQL.Add(vSql);
    QryPesquisa.ParamByName('PessoaTipoId').AsInteger := vPessoaTipoid;
    QryRecordCount := FConexao.GetQuery;
    QryRecordCount.SQL.Add('Select Count(Pessoaid) cReg From Pessoa P where p.PessoaTipoID  = :PessoaTipoId');
    QryRecordCount.ParamByName('PessoaTipoId').AsInteger := vPessoaTipoid;
    if AParams.ContainsKey('id') then begin
       QryPesquisa.SQL.Add('and p.pessoaid = :id');
       QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
       QryRecordCount.SQL.Add('and p.pessoaid = :id');
       QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    end;
    if AParams.ContainsKey('codpessoaerp') then begin
       QryPesquisa.SQL.Add('and p.CodPessoaERP = :CodPessoaERP');
       QryPesquisa.ParamByName('CodPessoaERP').AsLargeInt := AParams.Items['codpessoaerp'].ToInt64;
       QryRecordCount.SQL.Add('and p.CodPessoaERP = :CodPessoaERP');
       QryRecordCount.ParamByName('CodPessoaERP').AsLargeInt := AParams.Items['codpessoaerp'].ToInt64;
    end;
    if AParams.ContainsKey('razao') then begin
       QryPesquisa.SQL.Add('and ((razao like :razao) or (p.fantasia like :fantasia))');
       QryPesquisa.ParamByName('razao').AsString := '%' + AParams.Items['razao'].ToLower + '%';
       QryPesquisa.ParamByName('fantasia').AsString := '%' + AParams.Items['razao'].ToLower + '%';
       QryRecordCount.SQL.Add('and ((razao like :razao) or (p.fantasia like :fantasia))');
       QryRecordCount.ParamByName('razao').AsString := '%' + AParams.Items['razao'].ToLower + '%';
       QryRecordCount.ParamByName('fantasia').AsString := '%' + AParams.Items['razao'].ToLower + '%';
    end;
    if AParams.ContainsKey('status') then begin
       QryPesquisa.SQL.Add('and Status = :Status');
       QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status'].ToInteger;
       QryRecordCount.SQL.Add('and Status = :Status');
       QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status'].ToInteger;
    end;
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by pessoaid');
    If DebugHook <> 0 Then
       QryPesquisa.SQL.SaveToFile('Pessoa4D.Sql');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.ToJSONArray());
    QryRecordCount.Open();
    Result.AddPair('records', TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Close;
    QryRecordCount.Close;
  End;
end;

function TpessoaDao.GetPessoaId(pPessoaId, pPessoaTipoID,
  pCodPessoaERP: Integer; pRazao, pFantasia: String): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  If pPessoaTipoID = 0 then Begin
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Tipo de Pessoa não definido.'));
     Exit;
  End;
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPessoa);
    FConexao.Query.ParamByName('pPessoaId').Value     := pPessoaId;
    FConexao.Query.ParamByName('pPessoaTipoID').Value := pPessoaTipoID;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pFantasia').Value := '%' + pFantasia + '%';
    If DebugHook <> 0 Then
       FConexao.Query.SQL.SaveToFile('Pessoa.Sql');
    FConexao.Query.Open;
    while Not FConexao.Query.Eof do Begin
      ObjPessoaDAO.pessoaid := FConexao.Query.FieldByName('PessoaId').AsInteger;
      ObjPessoaDAO.CodPessoa := FConexao.Query.FieldByName('CodPessoaERP').AsInteger;
      ObjPessoaDAO.Razao := FConexao.Query.FieldByName('Razao').AsString;
      ObjPessoaDAO.Fantasia := FConexao.Query.FieldByName('Fantasia').AsString;
      // JSon PessoaTipo
      ObjPessoaDAO.PessoaTipo.PessoaTipoId := FConexao.Query.FieldByName('PessoaTipoId')
        .AsInteger;
      ObjPessoaDAO.PessoaTipo.Descricao :=
        FConexao.Query.FieldByName('Descricao').AsString;
      ObjPessoaDAO.PessoaTipo.Status := FConexao.Query.FieldByName('PessoaTipoStatus')
        .AsInteger;
      ObjPessoaDAO.Fone := FConexao.Query.FieldByName('Fone').AsString;
      ObjPessoaDAO.CnpjCpf := FConexao.Query.FieldByName('CnpjCpf').AsString;
      ObjPessoaDAO.Email := FConexao.Query.FieldByName('Email').AsString;
      ObjPessoaDAO.HomePage := FConexao.Query.FieldByName('HomePage').AsString;
      ObjPessoaDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
      ObjPessoaDAO.RotaId := FConexao.Query.FieldByName('RotaId').AsInteger;
      ObjPessoaDAO.Transportadoraid := FConexao.Query.FieldByName('TransportadoraId')
        .AsInteger;
      ObjPessoaDAO.GoogleMaps := FConexao.Query.FieldByName('GoogleMaps').AsString;
      ObjPessoaDAO.Latitude := FConexao.Query.FieldByName('Latitude').AsString;
      ObjPessoaDAO.Longitude := FConexao.Query.FieldByName('Longitude').AsString;
      ObjPessoaDAO.ShelfLife := FConexao.Query.FieldByName('ShelfLife').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjPessoaDAO,
        [joDateFormatISO8601]));
      // (ObjPessoaDAO.ClassToJson(ObjPessoaDAO).ToString);
      FConexao.Query.Next;
    End;

  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Pessoas - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TpessoaDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TpessoaDao.Import(pJsonArray: TjSonArray): TjSonArray;
var
  xPes: Integer;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlSalvarDestinatario);
  Result := TjSonArray.Create();
  for xPes := 0 to Pred(pJsonArray.Count) do
  begin
    Try
      FConexao.Query.Close;
      if UpperCase(pJsonArray.Items[xPes].GetValue<String>('pessoatipo')) = 'CLIENTE'
      then
        FConexao.Query.ParamByName('pPessoaTipoId').Value := 1
      Else if UpperCase(pJsonArray.Items[xPes].GetValue<String>('pessoatipo')) = 'FORNECEDOR'
      then
        FConexao.Query.ParamByName('pPessoaTipoId').Value := 2
      Else if UpperCase(pJsonArray.Items[xPes].GetValue<String>('pessoatipo')) = 'TRANSPORTADORA'
      then
        FConexao.Query.ParamByName('pPessoaTipoId').Value := 3
      Else if UpperCase(pJsonArray.Items[xPes].GetValue<String>('pessoatipo')) = 'MOTORISTA'
      then
        FConexao.Query.ParamByName('pPessoaTipoId').Value := 4;
      FConexao.Query.ParamByName('pCodPessoaERP').Value := pJsonArray.Items[xPes]
        .GetValue<Integer>('pessoaid');
      FConexao.Query.ParamByName('pRazao').Value := pJsonArray.Items[xPes]
        .GetValue<String>('razao');
      FConexao.Query.ParamByName('pFantasia').Value := pJsonArray.Items[xPes]
        .GetValue<String>('fantasia');
      FConexao.Query.ParamByName('pCnpjCpf').Value := pJsonArray.Items[xPes]
        .GetValue<String>('cnpjcpf');
      FConexao.Query.ParamByName('pEmail').Value := pJsonArray.Items[xPes]
        .GetValue<String>('email');
      FConexao.Query.ParamByName('pHomePage').Value := pJsonArray.Items[xPes]
        .GetValue<String>('homepage');
      FConexao.Query.ParamByName('pShelfLife').Value := pJsonArray.Items[xPes]
        .GetValue<String>('shelflife');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair(pJsonArray.Items[xPes]
        .GetValue<Integer>('pessoaid').ToString(),
        'Cadastro de Pessoa realizado com sucesso!'));
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair(pJsonArray.Items[xPes]
          .GetValue<Integer>('pessoaid').ToString(), E.Message));
      End;
    End;
  end;
end;

function TpessoaDao.InsertUpdate(pId: Integer; pCodPessoa: Integer;
  pRazao: String; pFantasia: String; pPessoaTipoID: Integer; pCnpjCpf: String;
  pFone: String; pEmail: String; pHomePage: String; pShelfLife: Integer;
  pStatus: Integer; pRotaId, pTransportadoraId: Integer): TjSonArray;
var
  vSql: String;
  vGuuid: string;
begin
  try
    if pId = 0 then Begin
       vGuuid := TGUID.NewGuid.ToString();
       vSql := 'Insert Into pessoa (CodPessoaERP, Razao, Fantasia, PessoaTipoID, CnpjCpf, Fone, Email, HomePage, Uuid, RotaId, pTransportadoraId, ShelfLife, Status) Values ('+
                pCodPessoa.ToString() + ', ' + QuotedStr(pRazao) + ', ' + QuotedStr(pFantasia) + ', ' + pPessoaTipoID.ToString() + ', ' + QuotedStr(pCnpjCpf) + ', ' + QuotedStr(pEmail) + ', ' +
                QuotedStr(pHomePage) + ', ' + 'Cast(' + QuotedStr(vGuuid) + ' AS UNIQUEIDENTIFIER), ' + pRotaId.ToString() + ', ' + pTransportadoraId.ToString() + ', ' + pShelfLife.ToString + ', ' +
                pStatus.ToString() + ')' + sLineBreak + 'select * From Pessoa where Uuid = Cast(' + QuotedStr(vGuuid) + ' AS UNIQUEIDENTIFIER)';
    End
    Else
      vSql := 'Update pessoa Set CodPessoaERP = ' + pCodPessoa.ToString() + '    , Razao = ' + QuotedStr(pRazao) + '    , Fantasia = ' + QuotedStr(pFantasia) +
              '    , PessoaTipoID = ' + pPessoaTipoID.ToString() + '    , CnpjCpf = ' + QuotedStr(pCnpjCpf) + '    , Fone = ' + QuotedStr(pFone) +
              '    , Email = ' + QuotedStr(pEmail) + '    , HomePage = ' + QuotedStr(pHomePage) + '    , Status = ' + pStatus.ToString() + '    , Rotaid = ' + pRotaId.ToString() +
              '    , TransportadoraId = ' + pTransportadoraId.ToString() + '    , ShelfLife = ' + pShelfLife.ToString + 'where PessoaId = ' +
              pId.ToString + sLineBreak + 'Select * from Pessoa where PessoaId= ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlSaveRotaPessoa);
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pPessoaid').Value := pId;
    FConexao.Query.ExecSQL;
  Except ON E: Exception do
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TUtil.TratarExcessao(E.Message)));
    End;
  end;
end;

function TpessoaDao.PessoaEstrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Pessoa') +
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
        TJSONNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TpessoaDao.PessoaInsert: TjSonArray;
var
  vSql: String;
  vGuuid: string;
begin
  try
    if ObjPessoaDAO.pessoaid = 0 then
    Begin
      vGuuid := TGUID.NewGuid.ToString();
      vSql := 'Insert Into pessoa (PessoaTipoId, CodPessoaERP, Razao, Fantasia, CnpjCpf, Fone, Email, HomePage, '
        + 'Uuid, TransportadoraId, GoogleMaps, Latitude, Longitude, ShelfLife, Status) Values ('
        + ObjPessoaDAO.PessoaTipo.PessoaTipoId.ToString + ', ' +
        ObjPessoaDAO.CodPessoa.ToString + ', ' + QuotedStr(ObjPessoaDAO.Razao) +
        ', ' + QuotedStr(ObjPessoaDAO.Fantasia) + ', ' +
        QuotedStr(ObjPessoaDAO.CnpjCpf) + ', ' + QuotedStr(ObjPessoaDAO.Fone) +
        ', ' + QuotedStr(ObjPessoaDAO.Email) + ', ' +
        QuotedStr(ObjPessoaDAO.HomePage) + ', ' + 'Cast(' + QuotedStr(vGuuid) +
        ' AS UNIQUEIDENTIFIER), ' + IfThen(ObjPessoaDAO.Transportadoraid = 0,
        'Null', ObjPessoaDAO.Transportadoraid.ToString()) + ', ' +
        QuotedStr(ObjPessoaDAO.GoogleMaps) + ', ' +
        QuotedStr(ObjPessoaDAO.Latitude) + ', ' +
        QuotedStr(ObjPessoaDAO.Longitude) + ', ' +
        ObjPessoaDAO.ShelfLife.ToString + ', ' + sLineBreak +
        ObjPessoaDAO.Status.ToString() + ')' + sLineBreak +
        'select * From Pessoa where Uuid = Cast(' + QuotedStr(vGuuid) +
        ' AS UNIQUEIDENTIFIER)';
    End
    Else
      vSql := 'Update pessoa Set CodPessoaERP = ' +
        ObjPessoaDAO.CodPessoa.ToString() + '    , Razao = ' +
        QuotedStr(ObjPessoaDAO.Razao) + '    , Fantasia = ' +
        QuotedStr(ObjPessoaDAO.Fantasia) + '    , PessoaTipoID = ' +
        ObjPessoaDAO.PessoaTipo.PessoaTipoId.ToString() + '    , CnpjCpf = ' +
        QuotedStr(ObjPessoaDAO.CnpjCpf) + '    , Fone = ' +
        QuotedStr(ObjPessoaDAO.Fone) + '    , Email = ' +
        QuotedStr(ObjPessoaDAO.Email) + '    , HomePage = ' +
        QuotedStr(ObjPessoaDAO.HomePage) + '    , TransportadoraId = ' +
        IfThen(ObjPessoaDAO.Transportadoraid = 0, 'Null',
        ObjPessoaDAO.Transportadoraid.ToString()) + '    , GoogleMaps = ' +
        QuotedStr(ObjPessoaDAO.GoogleMaps) + '    , Latitude   = ' +
        QuotedStr(ObjPessoaDAO.Latitude) + '    , Longitude  = ' +
        QuotedStr(ObjPessoaDAO.Longitude) + '    , ShelfLife  = ' +
        ObjPessoaDAO.ShelfLife.ToString() + '    , Status = ' +
        ObjPessoaDAO.Status.ToString() + 'where PessoaId = ' +
        ObjPessoaDAO.pessoaid.ToString + sLineBreak +
        'Select * from Pessoa where PessoaId = ' +
        ObjPessoaDAO.pessoaid.ToString;
    // vQry.Open(vSql);
    FConexao.Query.SQL.Add(vSql);
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('PessoaSave.Sql');
    FConexao.Query.Open();
    Result := FConexao.Query.ToJSONArray;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlSaveRotaPessoa);
    FConexao.Query.ParamByName('pRotaId').Value := ObjPessoaDAO.RotaId;
    FConexao.Query.ParamByName('pPessoaid').Value := ObjPessoaDAO.pessoaid;
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      Raise Exception.Create(E.Message);
    End;
  end;
end;

end.
