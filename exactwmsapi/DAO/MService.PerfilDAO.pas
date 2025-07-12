unit MService.PerfilDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option, PerfilClass, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type

  TPerfilDao = class(TBasicDao)
  private
    FPerfil: TPerfil;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pJsonObject: TJsonObject): TJsonObject;
    function GetId(pPerfil: String): TjSonArray;
    Function GetPerfil4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Function ControleAcessoFuncionalidades(pPerfilId: Integer;
      pListaTopicos: String): TJsonObject;
    Function ControleAcessoTopicos(pPerfilId: Integer): TJsonObject;
    Function SalvarAcesso(pPerfilId: Integer; pJsonObject: TJsonObject) : TjSonArray;
    Function AtualizarPermissao(pPerfilId : Integer) : TJsonArray;
    Property ObjPerfil: TPerfil Read FPerfil Write FPerfil;
  end;

implementation

uses Constants;  //uSistemaControl,

{ TClienteDao }

function TPerfilDao.AtualizarPermissao(pPerfilId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Delete UF');
      Query.SQL.Add('From UsuarioFuncionalidades UF');
      Query.SQL.Add('inner join Usuarios U On U.usuarioId = Uf.UsuarioId');
      Query.SQL.Add('Where U.perfilId = '+pPerfilId.ToString());

      Query.SQL.Add('Insert Into UsuarioFuncionalidades');
      Query.SQL.Add('select U.UsuarioId, Pf.FuncionalidadeId, 1');
      Query.SQL.Add('from usuarios U');
      Query.SQL.Add('Inner Join PerfilFuncionalidades PF On Pf.PerfilId = U.PerfilId');
      Query.SQL.Add('where U.perfilId = '+pPerfilId.ToString());
      Query.SQL.Add('Order by U.UsuarioId, Pf.FuncionalidadeId');

      Query.SQL.Add('Delete UT');
      Query.SQL.Add('From UsuarioTopicos UT');
      Query.SQL.Add('Inner join Usuarios U On U.UsuarioId = UT.UsuarioId');
      Query.SQL.Add('where U.perfilId = '+pPerfilId.ToString());
      Query.SQL.Add('Insert Into UsuarioTopicos');
      Query.SQL.Add('select UF.Usuarioid, TF.TopicoId, 1');
      Query.SQL.Add('from Usuarios U');
      Query.SQL.Add('Inner Join UsuarioFuncionalidades UF On Uf.UsuarioId = U.UsuarioId');
      Query.SQL.Add('Left join Funcionalidades F On F.Funcionalidadeid = UF.FuncionalidadeId ');
      Query.SQL.Add('Left join TopicoFuncionalidades TF On TF.FuncionalidadeId = F.Funcionalidadeid');
      Query.SQL.Add('where U.PerfilId = '+pPerfilId.ToString());
      Query.SQL.Add('Group by UF.UsuarioId, TF.TopicoId');
      Query.SQL.Add('Order by UF.UsuarioId, TF.TopicoId');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('PerfilAtualizarAcesso.Sql');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Atualizado com sucesso!'));
    Except On E: Exception do Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: Perfil/AtualizarPermissao - '+TUtil.TratarExcessao(E.Message)));
      End
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPerfilDao.ControleAcessoFuncionalidades(pPerfilId: Integer; pListaTopicos: String): TJsonObject;
var JsonArrayFuncionalidades: TjSonArray;
Var Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    JsonArrayFuncionalidades := TjSonArray.Create;
    try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('select Tf.TopicoId, F.Funcionalidadeid, F.Descricao, F.Status, (Case When PF.FuncionalidadeId Is Not Null Then 1 Else 0 End) as Acesso');
      Query.SQL.Add('from Funcionalidades F');
      Query.SQL.Add('INNER Join TopicoFuncionalidades TF On TF.FuncionalidadeId = F.FuncionalidadeId --and TF.TopicoId In ('+pListaTopicos + ')');
      Query.SQL.Add('Left Join PerfilFuncionalidades PF ON PF.FuncionalidadeId = TF.Funcionalidadeid and PF.PerfilId = '+pPerfilId.ToString());
  //    Query.SQL.Add('Where PF.PerfilId = '+pPerfilId.ToString());
      If (pListaTopicos <> '') and ( pListaTopicos <> '*') and (pListaTopicos <> '0') then
         Query.SQL.Add('And TF.TopicoId In (' + pListaTopicos + ')');
      Query.SQL.Add('Order by Tf.TopicoId, F.Descricao');
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('ControleAcessoFuncionalidades.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result.AddPair('Erro', tuEvolutConst.QrySemDados);
      End
      Else Begin
         Result.AddPair('funcionalidades', Query.toJsonArray);
      End;
    Except on E: Exception do
      Begin
        JsonArrayFuncionalidades.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        Result.AddPair('Erro', E.Message);
      End;
    end;
  Finally
    FreeAndNil(JsonArrayFuncionalidades);
    FreeAndNil(Query);
  End;
end;

function TPerfilDao.ControleAcessoTopicos(pPerfilId: Integer): TJsonObject;
var JsonArrayTopicos: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  JsonArrayTopicos := TjSonArray.Create;
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(tuEvolutConst.SqlGetPerfilControleAcessoTopico);
      Query.ParamByName('pPerfilId').Value := pPerfilId;
      Query.Open;
      if Query.IsEmpty then Begin
         JsonArrayTopicos.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há Tópicos cadastrado no sistema!'));
         Result.AddPair('Erro', tuEvolutConst.QrySemDados);
      End
      Else Begin
         Result.AddPair('topicos', Query.toJsonArray);
      End;
    Except on E: Exception do
      Begin
        JsonArrayTopicos.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        Result.AddPair('Erro', 'Processo: ControleAcessoTopicos - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(JsonArrayTopicos);
    FreeAndNil(Query);
  End;
end;

constructor TPerfilDao.Create;
begin
  ObjPerfil := TPerfil.Create;
  inherited;
end;

function TPerfilDao.Delete: Boolean;
var
  vSql: String;
Var Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Perfil where PerfilId = ' + Self.ObjPerfil.PerfilId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: Perfil/Delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TPerfilDao.Destroy;
begin
  FreeAndNil(ObjPerfil);
  inherited;
end;

function TPerfilDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('Perfil') +
               '  and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
    End
    Else
    Begin
      Result := Query.toJsonArray();
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPerfilDao.GetId(pPerfil: String): TjSonArray;
var ObjJson: TJsonObject;
    PerfilItensDAO: TjSonArray;
Var Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(tuEvolutConst.SqlPerfil);
      if (pPerfil = '0') or (StrToInt64Def(pPerfil, 0) > 0) then
         Query.ParamByName('pPerfilId').Value := pPerfil
      Else
         Query.ParamByName('pPerfilId').Value := 0;
      if (StrToInt64Def(pPerfil, 0) > 0) or (pPerfil = '0') then
         Query.ParamByName('pDescricao').Value := ''
      Else
        Query.ParamByName('pDescricao').Value := '%' + pPerfil + '%';
      Query.Open;
      while Not Query.Eof do
        With ObjPerfil do Begin
          ObjJson := TJsonObject.Create;
          With ObjJson do
          Begin
            AddPair('perfilid', TJsonNumber.Create(Query.FieldByName('PerfilId').AsInteger));
            AddPair('descricao', Query.FieldByName('Descricao').AsString);
            AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
            AddPair('data', DateToStr(Query.FieldByName('Data').AsDateTime));
            AddPair('hora', TimeToStr(StrToTime(Copy(Query.FieldByName('Hora').AsString, 1, 8))));
            Result.AddElement(ObjJson);
          End;
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: Perfil/GetId - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPerfilDao.GetPerfil4D(const AParams: TDictionary<string, string>) : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
  vSql: String;
begin
  Result := TJsonObject.Create();
  vSql := 'select P.PerfilId, P.Descricao, P.Status, Rd.Data, Rh.Hora' + sLineBreak +
          'from Perfil P' + sLineBreak +
          'Inner Join Rhema_Data RD On Rd.IdData = P.Data' + sLineBreak +
          'Inner join Rhema_Hora RH ON RH.IdHora = P.Hora' + sLineBreak +
          'Where 1 = 1';
  QryPesquisa    := TFdQuery.Create(nil);
  QryRecordCount := TFdQuery.Create(nil);
  Try
    QryPesquisa.Connection    := Connection;
    QryRecordCount.Connection := Connection;
    QryPesquisa.SQL.Add(vSql);
    QryRecordCount.SQL.Add('Select Count(PerfilId) cReg From Perfil Where 1 =1');
    if AParams.ContainsKey('perfilid') then begin
       QryPesquisa.SQL.Add('and PerfilId = :PerfilId');
       QryPesquisa.ParamByName('PerfilId').AsLargeInt := AParams.Items['perfilid'].ToInt64;
       QryRecordCount.SQL.Add('and PerfilId = :PerfilId');
       QryRecordCount.ParamByName('PerfilId').AsLargeInt := AParams.Items['perfilid'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then begin
       QryPesquisa.SQL.Add('and (descricao like :descricao))');
       QryPesquisa.ParamByName('descricao').AsString := '%' + AParams.Items['descricao'].ToLower + '%';
       QryRecordCount.SQL.Add('and (Descricao like :Descricao))');
       QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items['descricao'].ToLower + '%';
    end;
    if AParams.ContainsKey('limit') then begin
       QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
       QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
       QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.SQL.Add('order by perfilid');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.toJsonArray());
    QryRecordCount.Open();
    Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    FreeAndNil(QryPesquisa);
    FreeAndNil(QryRecordCount);
  End;
end;

function TPerfilDao.Salvar(pJsonObject: TJsonObject): TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pJsonObject.GetValue<Integer>('perfilId') = 0 then
         vSql := 'Insert Into Perfil (Descricao, Status, Data, Hora)OUTPUT Inserted.PerfilId Values (' +sLineBreak+
                 QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +sLineBreak+
                 pJsonObject.GetValue<String>('status') + ', ' +sLineBreak+
                 tuEvolutConst.SqlDataAtual + ', ' + tuEvolutConst.SqlHoraAtual + ')'
      Else
         vSql := ' Update Perfil ' + '   Set Descricao = ' +QuotedStr(pJsonObject.GetValue<String>('descricao'))+sLineBreak+
                 '      , Status   = ' + pJsonObject.GetValue<String>('status') +sLineBreak+
                 '   OUTPUT Inserted.PerfilId as PerfilId' + sLineBreak +
                 ' where PerfilId = ' + pJsonObject.GetValue<String>('perfilId');
      Query.Sql.Add(vSql);
      Query.Open;
      Result := Query.ToJSONObject();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Perfil/Salvar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPerfilDao.SalvarAcesso(pPerfilId: Integer; pJsonObject: TJsonObject) : TjSonArray;
Var pJsonArrayTopicos, pJsonArrayFuncionalidades: TjSonArray;
    vQryTopico, vQryFuncionalidade: TFDQuery;
    xTopico, xFuncionalidade: Integer;
begin
  vQryTopico         := TFdQuery.Create(nil);
  vQryFuncionalidade := TFdQuery.Create(nil);
  Try
    vQryTopico.Connection         := Connection;
    vQryFuncionalidade.Connection := Connection;
    Try
      pJsonArrayTopicos := TjSonArray.Create;
      pJsonArrayFuncionalidades := TjSonArray.Create;
      pJsonArrayTopicos := pJsonObject.GetValue<TjSonArray>('topicos');
      pJsonArrayFuncionalidades := pJsonObject.GetValue<TjSonArray>('funcionalidades');
      vQryTopico.Connection         := Connection;
      vQryFuncionalidade.Connection := Connection;
      vQryTopico.connection.StartTransaction;
      //vQryTopico.connection.TxOptions.Isolation := xiReadCommitted;
      vQryTopico.SQL.Add(tuEvolutConst.SqlSalvarPerfilAcessoTopico);
      for xTopico := 0 to Pred(pJsonArrayTopicos.Count) do Begin
        vQryTopico.Close;
        vQryTopico.ParamByName('pPerfilId').Value := pPerfilId;
        vQryTopico.ParamByName('pTopicoId').Value := pJsonArrayTopicos.Items[xTopico].GetValue<Integer>('topicoid');
        vQryTopico.ParamByName('pAcesso').Value := pJsonArrayTopicos.Items[xTopico].GetValue<Integer>('acesso');
        vQryTopico.ExecSQL;
      End;
      vQryFuncionalidade.SQL.Add(tuEvolutConst.SqlSalvarPerfilAcessoFuncionalidade);
      for xFuncionalidade := 0 to Pred(pJsonArrayFuncionalidades.Count) do Begin
        vQryFuncionalidade.Close;
        vQryFuncionalidade.ParamByName('pPerfilId').Value := pPerfilId;
        vQryFuncionalidade.ParamByName('pFuncionalidadeId').Value := pJsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>('funcionalidadeid');
        vQryFuncionalidade.ParamByName('pAcesso').Value := pJsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>('acesso');
        vQryFuncionalidade.ExecSQL;
      End;
      Result := vQryFuncionalidade.toJsonArray;
      vQryTopico.connection.Commit;
    Except ON E: Exception do
      Begin
        vQryTopico.connection.Rollback;
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: SalvaAcesso - '+TUtil.TratarExcessao(E.Message)));
      End;
    End;
  Finally
    FreeAndNil(vQryTopico);
    FreeAndNil(vQryFuncionalidade);
  End;
End;

end.
