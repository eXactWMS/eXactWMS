unit MService.RotaDAO;

interface

uses
  FireDAC.Comp.Client, RotaClass, System.SysUtils,  DataSet.Serialize,
  System.Types, System.Generics.Collections, System.JSON, REST.JSON, exactwmsservice.lib.utils,
  System.JSON.Types, exactwmsservice.lib.connection, exactwmsservice.dao.base;

type
  TRotaDao = class(TBasicDao)
  private
    FRotaDAO: TRota;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pJsonObject: TJSonObject): TjSonArray;
    Function RotaParticipante(pJsonObject: TJSonObject): TjSonArray;
    function GetId(pRotaId_Descricao: String): TjSonArray;
    function Get4D(const AParams: TDictionary<string, string>): TJSonObject;
    Function GetParticipante(pRotaId, pPessoaId: Integer): TjSonArray;
    Function Delete(pRotaId: Integer): Boolean;
    Function DeleteParticipante(pPessoaId: Integer): Boolean;
    Function RotaOnOff(pRotaId: Integer): TjSonArray;
    Function GetProducaoDiaria(pDataInicial, pDataFinal : TDateTime) : TJsonObject;

    Property ObjRota: TRota Read FRotaDAO Write FRotaDAO;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TRotaDao.Create;
begin
  ObjRota := TRota.Create;
  inherited;
end;

function TRotaDao.Delete(pRotaId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Rotas where RotaId = ' + pRotaId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Rotas - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TRotaDao.DeleteParticipante(pPessoaId: Integer): Boolean;
begin
  Result := False;
  try
    Fconexao.Query.ExecSQL('Delete from RotaPessoas where PessoaId = ' +
      pPessoaId.ToString);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: RotaPessoas - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TRotaDao.Destroy;
begin
  FreeAndNil(ObjRota);
  inherited;
end;

function TRotaDao.RotaOnOff(pRotaId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    Fconexao.Query.ExecSQL('Declare @RotaId Integer = ' + pRotaId.ToString() +
      sLineBreak + TuEvolutConst.SqlRotaDesativar);
    Result.AddElement(TJSonObject.Create.AddPair('Ok', 'Status = 200'));
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJSonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

// Post
function TRotaDao.RotaParticipante(pJsonObject: TJSonObject): TjSonArray;
begin
  Try
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlInsUpdRotaParticipante);
    Fconexao.Query.ParamByName('pRotaId').Value := pJsonObject.GetValue<Integer>
      ('rotaid');
    Fconexao.Query.ParamByName('pPessoaId').Value :=
      pJsonObject.GetValue<Integer>('pessoaid');
    Fconexao.Query.ParamByName('pPosicao').Value :=
      pJsonObject.GetValue<Integer>('posicao');
    If DebugHook <> 0 Then
      Fconexao.Query.Sql.SaveToFile('RotaParticipante.Sql');
    Fconexao.Query.ExecSQL;
    Result := Fconexao.Query.toJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Erro:' + E.Message);
    End;
  end;
end;

function TRotaDao.Get4D(const AParams: TDictionary<string, string>)
  : TJSonObject;
Var
  QryPesquisa, QryRecordCount: TFDQuery;

begin
  Result := TJSonObject.Create();

  QryPesquisa := Fconexao.GetQuery;
  QryPesquisa.Sql.Add('Select * From Rotas where 1 = 1');
  QryRecordCount := Fconexao.GetQuery;
  QryRecordCount.Sql.Add('Select Count(Rotaid) cReg From Rotas where 1=1');
  if AParams.ContainsKey('id') then
  begin
    QryPesquisa.Sql.Add('and RotaId = :id');
    QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    QryRecordCount.Sql.Add('and RotaId = :id');
    QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;
  if AParams.ContainsKey('descricao') then
  begin
    QryPesquisa.Sql.Add('and descricao like ' + #39'%'+AParams.Items['descricao'].ToLower + '%'+#39);
    QryRecordCount.Sql.Add('and descricao like ' + #39'%'+AParams.Items['descricao'].ToLower + '%'+#39);
  end;
  if AParams.ContainsKey('status') then
  begin
    QryPesquisa.Sql.Add('and Status = :Status');
    QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status']
      .ToInteger;
    QryRecordCount.Sql.Add('and Status = :Status');
    QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status']
      .ToInteger;
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
  QryPesquisa.Sql.Add('order by rotaid');
  If DebugHook <> 0 then
     QryPesquisa.SQL.SaveToFile('Rota4D.Sql');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.toJsonArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));

end;

function TRotaDao.GetId(pRotaId_Descricao: String): TjSonArray;
var
  vQryRota, vQryRotaParticipante: TFDQuery;
  vSql: String;
  ReturnjsonRotaPessoa: TjSonArray;
  xRotaPessoa: Integer;
  ObjRotaPessoa: TRotaPessoa;
  JsonRotaPessoa: TJSonObject;
begin
  Result := TjSonArray.Create;
  try
    vSql := TuEvolutConst.SqlRota;
    if pRotaId_Descricao <> '0' then
    Begin
      if StrToIntDef(pRotaId_Descricao, 0) > 0 then
        vSql := vSql + #13 + #10 + 'Where R.RotaId = ' + pRotaId_Descricao
      Else
        vSql := vSql + #13 + #10 + 'Where R.Descricao Like ' +
          QuotedStr('%' + pRotaId_Descricao + '%');
    End;
    vQryRota := Fconexao.GetQuery;
    vQryRota.Open(vSql);
    if vQryRota.IsEmpty then
      Result.AddElement(TJSonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
    Begin
      While not vQryRota.Eof do
      Begin
        With ObjRota do
        Begin
          RotaId := vQryRota.FieldByName('RotaId').AsInteger;
          Descricao := vQryRota.FieldByName('Descricao').AsString;
          GoogleMaps := vQryRota.FieldByName('GoogleMaps').AsString;
          Latitude := vQryRota.FieldByName('Latitude').AsString;
          Longitude := vQryRota.FieldByName('Longitude').AsString;
          DtInclusao := vQryRota.FieldByName('DtInclusao').AsDateTime;
          HrInclusao := vQryRota.FieldByName('HrInclusao').AsDateTime;
          Status := vQryRota.FieldByName('Status').AsInteger;
          NParticipante := vQryRota.FieldByName('NrParticipante').AsInteger;
          ReturnjsonRotaPessoa := GetParticipante(RotaId, 0);
          ListPessoa.Clear;
          for xRotaPessoa := 0 to ReturnjsonRotaPessoa.Count - 1 do
          Begin
            JsonRotaPessoa := ReturnjsonRotaPessoa.Get(xRotaPessoa)
              as TJSonObject;
            ObjRotaPessoa := TRotaPessoa.Create;
            ObjRotaPessoa.RotaId := JsonRotaPessoa.GetValue<Integer>
              ('rotaid', 0);
            ObjRotaPessoa.PessoaId := JsonRotaPessoa.GetValue<Integer>
              ('pessoaid', 0);
            ObjRotaPessoa.CodPessoaERP := JsonRotaPessoa.GetValue<Integer>
              ('codpessoaerp', 0);
            ObjRotaPessoa.Razao := JsonRotaPessoa.GetValue<String>('razao', '');
            ObjRotaPessoa.Ordem := JsonRotaPessoa.GetValue<Integer>('ordem', 1);
            ObjRota.ListPessoa.Add(ObjRotaPessoa);
          End;
          Result.AddElement(tJson.ObjectToJsonObject(ObjRota,
            [joDateFormatISO8601]));
          vQryRota.Next;
        End;
      End;
    End;
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJSonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TRotaDao.GetParticipante(pRotaId, pPessoaId: Integer): TjSonArray;
var JsonRotaPessoa: TJSonObject;
    vSql: String;
    vQryParticipante : TFdQuery;
Begin
  try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    Fconexao.Query.Sql.Add(TuEvolutConst.SqlRotaParticipante);
    Fconexao.Query.ParamByName('pRotaId').Value := pRotaId;
    Fconexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    Fconexao.Query.Open();
    If Not Fconexao.Query.IsEmpty then
      Result := Fconexao.Query.toJsonArray
    Else
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJSonObject.Create.AddPair('Erro',
        'Não há registro de participante(s).'));
    End;
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJSonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TRotaDao.GetProducaoDiaria(pDataInicial, pDataFinal: TDateTime): TJsonObject;
Var JsonArrayUnidades, JsonArrayVolumes : TJsonArray;
begin
  Try
    Result := TJsonObject.Create;
    JsonArrayUnidades := TJsonArray.Create;
    JsonArrayVolumes  := TJsonArray.Create;
    //Buscar Dados por Unidades
    FConexao.Query.Sql.Add(TuEvolutConst.SqlRotaProducaoDiariaUnidades);
    FConexao.Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
    FConexao.Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
    If DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('ProducaoDiariaUnidades.Sql');
    FConexao.Query.Open();
    If FConexao.Query.IsEmpty then
       Result.AddPair('MSG', TuEvolutConst.QrySemDados)
    Else Begin
       JsonArrayUnidades := FConexao.Query.ToJSONArray();
       //Buscar Dados por Volumes
       FConexao.Query.Close;
       FConexao.Query.Sql.Clear;
       FConexao.Query.Sql.Add(TuEvolutConst.SqlRotaProducaoDiariaVolumes);
       FConexao.Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
       FConexao.Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
       If DebugHook <> 0 then
          FConexao.Query.SQL.SaveToFile('ProducaoDiariaVolumes.Sql');
       FConexao.Query.Open();
       If FConexao.Query.IsEmpty then
          Result.AddPair('MSG', TuEvolutConst.QrySemDados)
       Else
          JsonArrayVolumes := FConexao.Query.ToJSONArray();
    End;
    Result.AddPair('unidades', JsonArrayUnidades);
    Result.AddPair('volumes',  JsonArrayVolumes);
  Except On E: Exception do
    raise Exception.Create('Processo: GetProducaoDiaria - ' + TUtil.TratarExcessao(E.Message));
  End;
end;

function TRotaDao.InsertUpdate(pJsonObject: TJSonObject): TjSonArray;
var vSql: String;
begin
  try
    if pJsonObject.GetValue<Integer>('rotaId') = 0 then
      vSql := 'Insert Into Rotas (RotaId, Descricao, GoogleMaps, Latitude, Longitude, DtInclusao, HrInclusao, Status) Values ('
        + '(Select Coalesce(Max(RotaId), 0)+1 From Rotas), ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +
        QuotedStr(pJsonObject.GetValue<String>('googleMaps')) + ', ' +
        QuotedStr(pJsonObject.GetValue<String>('latitude')) + ', ' +
        QuotedStr(pJsonObject.GetValue<String>('longitude')) + ', ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', 1)'
    Else
      vSql := 'Update Rotas ' + '     Set  Descricao   = ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) + sLineBreak +
        '        , GoogleMaps = ' +
        QuotedStr(pJsonObject.GetValue<String>('googleMaps')) + sLineBreak +
        '        , Latitude   = ' +
        QuotedStr(pJsonObject.GetValue<String>('latitude')) + sLineBreak +
        '        , Longitude  = ' +
        QuotedStr(pJsonObject.GetValue<String>('longitude')) + sLineBreak +
        '        , Status = ' + ObjRota.Status.ToString() + sLineBreak +
        'Where RotaId = ' + pJsonObject.GetValue<Integer>('rotaId').ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    On E: Exception do
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJSonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

end.
