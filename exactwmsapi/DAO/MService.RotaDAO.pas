unit MService.RotaDAO;

interface

uses
  FireDAC.Comp.Client, RotaClass, System.SysUtils,  DataSet.Serialize,
  System.Types, System.Generics.Collections, System.JSON, REST.JSON, exactwmsservice.lib.utils,
  exactwmsservice.lib.connection, exactwmsservice.dao.base;

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

uses Constants; //uSistemaControl,

{ TClienteDao }

constructor TRotaDao.Create;
begin
  ObjRota := TRota.Create;
  inherited;
end;

function TRotaDao.Delete(pRotaId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Rotas where RotaId = ' + pRotaId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Rotas - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TRotaDao.DeleteParticipante(pPessoaId: Integer): Boolean;
Var Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.ExecSQL('Delete from RotaPessoas where PessoaId = ' + pPessoaId.ToString);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Rota/deleteparticipante - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TRotaDao.Destroy;
begin
  FreeAndNil(ObjRota);
  inherited;
end;

function TRotaDao.RotaOnOff(pRotaId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TjsonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.ExecSQL('Declare @RotaId Integer = ' + pRotaId.ToString() + sLineBreak + TuEvolutConst.SqlRotaDesativar);
      Result.AddElement(TJSonObject.Create.AddPair('Ok', 'Status = 200'));
    Except On E: Exception do
      Begin
        Result.AddElement(TJSonObject.Create(TJSONPair.Create('Erro', 'Processo: RotaOnOff - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

// Post
function TRotaDao.RotaParticipante(pJsonObject: TJSonObject): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlInsUpdRotaParticipante);
      Query.ParamByName('pRotaId').Value := pJsonObject.GetValue<Integer>('rotaid');
      Query.ParamByName('pPessoaId').Value := pJsonObject.GetValue<Integer>('pessoaid');
      Query.ParamByName('pPosicao').Value := pJsonObject.GetValue<Integer>('posicao');
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('RotaParticipante.Sql');
      Query.ExecSQL;
      Result := Query.toJsonArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Rota/rotaparticipamente - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TRotaDao.Get4D(const AParams: TDictionary<string, string>) : TJSonObject;
Var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Try
    Result := TJSonObject.Create();
    QryPesquisa := TFdQuery.Create(Nil);
    QryPesquisa.Connection := Connection;
    QryPesquisa.Sql.Add('Select RotaId, Descricao, Status');
    QryPesquisa.SQL.Add('From Rotas where 1 = 1');
    QryRecordCount := TFdQuery.Create(Nil);
    QryRecordCount.Connection := Connection;
    QryRecordCount.Sql.Add('Select Count(Rotaid) cReg From Rotas where 1=1');
    if AParams.ContainsKey('id') then begin
       QryPesquisa.Sql.Add('and RotaId = :id');
       QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
       QryRecordCount.Sql.Add('and RotaId = :id');
       QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then Begin
       QryPesquisa.Sql.Add('and descricao like ' + #39'%'+AParams.Items['descricao'].ToLower + '%'+#39);
       QryRecordCount.Sql.Add('and descricao like ' + #39'%'+AParams.Items['descricao'].ToLower + '%'+#39);
    end;
    if AParams.ContainsKey('status') then Begin
       QryPesquisa.Sql.Add('and Status = :Status');
       QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status'].ToInteger;
       QryRecordCount.Sql.Add('and Status = :Status');
       QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status'].ToInteger;
    end;
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.Sql.Add('order by rotaid');
    If DebugHook <> 0 then
       QryPesquisa.SQL.SaveToFile('Rota4D.Sql');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.toJsonArray());
    QryRecordCount.Open();
    Result.AddPair('records', TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TRotaDao.GetId(pRotaId_Descricao: String): TjSonArray;
var vQryRota : TFDQuery;
    vSql: String;
    ReturnjsonRotaPessoa: TjSonArray;
    xRotaPessoa: Integer;
    ObjRotaPessoa: TRotaPessoa;
    JsonRotaPessoa: TJSonObject;
begin
  Result := TjSonArray.Create;
  Try
    vQryRota := TFdQuery.Create(Nil);
    try
      vQryRota.Connection := Connection;
      vSql := TuEvolutConst.SqlRota;
      if pRotaId_Descricao <> '0' then Begin
         if StrToIntDef(pRotaId_Descricao, 0) > 0 then
            vSql := vSql + #13 + #10 + 'Where R.RotaId = ' + pRotaId_Descricao
         Else
            vSql := vSql + #13 + #10 + 'Where R.Descricao Like ' + QuotedStr('%' + pRotaId_Descricao + '%');
      End;
      vQryRota.Open(vSql);
      if vQryRota.IsEmpty then
         Result.AddElement(TJSonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      Else Begin
        While not vQryRota.Eof do Begin
          With ObjRota do Begin
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
            for xRotaPessoa := 0 to ReturnjsonRotaPessoa.Count - 1 do Begin
              JsonRotaPessoa := ReturnjsonRotaPessoa.Get(xRotaPessoa) as TJSonObject;
              ObjRotaPessoa := TRotaPessoa.Create;
              ObjRotaPessoa.RotaId := JsonRotaPessoa.GetValue<Integer>('rotaid', 0);
              ObjRotaPessoa.PessoaId := JsonRotaPessoa.GetValue<Integer>('pessoaid', 0);
              ObjRotaPessoa.CodPessoaERP := JsonRotaPessoa.GetValue<Integer>('codpessoaerp', 0);
              ObjRotaPessoa.Razao := JsonRotaPessoa.GetValue<String>('razao', '');
              ObjRotaPessoa.Ordem := JsonRotaPessoa.GetValue<Integer>('ordem', 1);
              ObjRota.ListPessoa.Add(ObjRotaPessoa);
            End;
            Result.AddElement(tJson.ObjectToJsonObject(ObjRota, [joDateFormatISO8601]));
            vQryRota.Next;
          End;
        End;
      End;
    Except On E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: Rota/getid - '+TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    vQryRota.Free;
  End;
end;

function TRotaDao.GetParticipante(pRotaId, pPessoaId: Integer): TjSonArray;
var JsonRotaPessoa: TJSonObject;
    vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Close;
      Query.SQL.Clear;
      Query.Sql.Add(TuEvolutConst.SqlRotaParticipante);
      Query.ParamByName('pRotaId').Value := pRotaId;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.Open();
      If Not Query.IsEmpty then
         Result := Query.toJsonArray
      Else Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJSonObject.Create.AddPair('Erro', 'Não há registro de participante(s).'));
      End;
    Except On E: Exception do
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJSonObject.Create.AddPair('Erro', 'Processo: Rota/getparticipante - '+TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TRotaDao.GetProducaoDiaria(pDataInicial, pDataFinal: TDateTime): TJsonObject;
Var JsonArrayUnidades, JsonArrayVolumes : TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := TJsonObject.Create;
      JsonArrayUnidades := TJsonArray.Create;
      JsonArrayVolumes  := TJsonArray.Create;
      //Buscar Dados por Unidades
      Query.Sql.Add(TuEvolutConst.SqlRotaProducaoDiariaUnidades);
      Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
      Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataFinal);
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('ProducaoDiariaUnidades.Sql');
      Query.Open();
      If Query.IsEmpty then
         Result.AddPair('MSG', TuEvolutConst.QrySemDados)
      Else Begin
         JsonArrayUnidades := Query.ToJSONArray();
         //Buscar Dados por Volumes
         Query.Close;
         Query.Sql.Clear;
         Query.Sql.Add(TuEvolutConst.SqlRotaProducaoDiariaVolumes);
         Query.ParamByName('pDataInicial').Value :=  FormatDateTime('YYYY-MM-DD', pDataInicial);
         Query.ParamByName('pDatafinal').Value   :=  FormatDateTime('YYYY-MM-DD', pDataFinal);
         If DebugHook <> 0 then
            Query.SQL.SaveToFile('ProducaoDiariaVolumes.Sql');
         Query.Open();
         If Query.IsEmpty then
            Result.AddPair('MSG', TuEvolutConst.QrySemDados)
         Else
            JsonArrayVolumes := Query.ToJSONArray();
      End;
      Result.AddPair('unidades', JsonArrayUnidades);
      Result.AddPair('volumes',  JsonArrayVolumes);
    Except On E: Exception do
      raise Exception.Create('Processo: GetProducaoDiaria - ' + TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TRotaDao.InsertUpdate(pJsonObject: TJSonObject): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pJsonObject.GetValue<Integer>('rotaId') = 0 then Begin
         Query.Sql.Add('Insert Into Rotas (RotaId, Descricao, GoogleMaps, Latitude, Longitude, DtInclusao, HrInclusao, Status) Values (');
         Query.Sql.Add('       (Select Coalesce(Max(RotaId), 0)+1 From Rotas), ');
         Query.Sql.Add('       '+QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', '+QuotedStr(pJsonObject.GetValue<String>('googleMaps')) + ', ');
         Query.Sql.Add('       '+QuotedStr(pJsonObject.GetValue<String>('latitude')) + ', '+QuotedStr(pJsonObject.GetValue<String>('longitude')) + ', ');
         Query.Sql.Add('       '+TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', 1)');
      End
      Else Begin
         Query.Sql.Add('Update Rotas ' + '     Set  Descricao   = ');
         Query.Sql.Add('       '+QuotedStr(pJsonObject.GetValue<String>('descricao'))+', GoogleMaps = ' +QuotedStr(pJsonObject.GetValue<String>('googleMaps')));
         Query.Sql.Add('      ,Latitude = ' +QuotedStr(pJsonObject.GetValue<String>('latitude'))+', Longitude  = ' +QuotedStr(pJsonObject.GetValue<String>('longitude')));
         Query.Sql.Add('      ,Status   = ' +pJsonObject.GetValue<Integer>('status').ToString());
         Query.Sql.Add('Where RotaId = ' + pJsonObject.GetValue<Integer>('rotaId').ToString);
         Query.Sql.Add('-- Status = ' + pJsonObject.GetValue<Integer>('status').ToString);
         Query.Sql.Add('-- RotaId = ' + pJsonObject.GetValue<Integer>('rotaId').ToString);
      End;
      If DebugHook<>0 then
         Query.SQL.SaveToFile('RotaInsertUpdate.Sql');
      Query.ExecSQL;
      Result := Query.toJsonArray;
    Except On E: Exception do
      Begin
        Result := TjSonArray.Create();
        Result.AddElement(TJSonObject.Create.AddPair('Erro', 'Processo: Rota/insertupdate - '+TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
