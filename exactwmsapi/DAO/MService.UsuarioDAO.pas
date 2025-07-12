unit MService.UsuarioDAO;

interface

uses
  FireDAC.Comp.Client, UsuarioClass, System.SysUtils, DataSet.Serialize,
  FireDAC.Stan.Option, System.JSON, REST.JSON, Web.HTTPApp, exactwmsservice.lib.utils,
  Generics.Collections, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlUsuario = 'select U.UsuarioId, U.Login, U.Nome, U.Senha, U.SenhaPadrao, U.DiasSenhaValida, U.Senha, U.Email, '+sLineBreak+
               '       P.PerfilId, P.Descricao, P.Status StatusPerfil, FORMAT(Dp.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') Data, CONVERT(Time(0), Hp.hora, 0) hora, '+sLineBreak+
               '       FORMAT(UAS.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') as DtUltimaAlteracaoSenha, CONVERT(VARCHAR(5), HAS.hora,108) as HrUltimaAlteracaoSenha, '+sLIneBreak+
               '       FORMAT(DI.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') as DtInclusao, CONVERT(VARCHAR(5), HI.hora,108) as HrInclusao, U.Status '+sLineBreak+
               '     , Coalesce(UL.IdLogOn, 0) IdLogOn, Ul.Terminal, Ul.DataInicio, Ul.HoraInicio'+sLineBreak+
               'From Usuarios U '+sLineBreak+
               'Inner Join Perfil P On P.PerfilId = U.PerfilId' + sLineBreak +
               'Left Join Rhema_Data UAS ON UAS.IdData = U.DtUltimaAlteracaoSenha '+sLineBreak+
               'Left Join Rhema_Hora HAS ON HAS.IdHora = U.HrUltimaAlteracaoSenha '+sLineBreak+
               'Left Join Rhema_Data DI ON DI.IdData = U.DtInclusao '+sLineBreak+
               'Left Join Rhema_Hora HI ON HI.IdHora = U.HrInclusao' + sLineBreak +
               'Left Join Rhema_Data DP ON DP.IdData = P.Data '+sLineBreak+
               'Left Join Rhema_Hora HP ON HP.IdHora = P.Hora' + sLineBreak+
               'Left Join (Select Top 1 UsuarioId, Coalesce(IdLogOn, 0) IdLogOn, Terminal, DataInicio, HoraInicio'+sLineBreak +
               '           From UsuarioLogOnOff' + sLineBreak +
               '           Where OnOff = 1) Ul On Ul.UsuarioId = U.UsuarioId';

type
  TUsuarioDao =class(TBasicDao)
  private
    // FIndexConn : Integer;
    
  public
    constructor Create; overload;
    Destructor Destroy; override;
    Function AtualizarSenha(Const pJsonObject: TJsonObject): Boolean;
    function InsertUpdate(pUsuarioId: Integer; pLogin, pNome, pSenha: String;
      pSenhaPadrao, pDiasSenhaValida: Integer; pEmail: String;
      pPerfilId, pStatus: Integer): TjSonArray;
    function GetId(pUsuarioId: String): TjSonArray;
    Function GetAtivo : TJsonArray;
    Function FindLoginNome(pLogin, pNome: String): TjSonArray;
    Function Delete(pUsuarioId: Integer): Boolean;
    Function AcessoFuncionalidade(pUsuarioId: Integer; pFuncionalidade: String)
      : TjSonArray;
    Function AcessoTopico(pUsuarioId: Integer; pTopico: String): TjSonArray;
    Function ControleAcesso(pUsuarioId: Integer): TJsonObject;
    Function ListaFuncionalidade(pUsuarioId: Integer): TjSonArray;
    Function SalvarAcesso(pUsuarioId: Integer; pJsonObject: TJsonObject)
      : TjSonArray;
    Function LogOnOff(pJsonObject: TJsonObject): TjSonArray;
    Function UsuarioConectado: TjSonArray;
    Function GetRelUsuarioLista(pUsuarioId, pFuncionalidadeId, pPerfilId,
      pStatus: Integer): TjSonArray;
    Function GetUsuario4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function ImportCSV(pJsonArray : TJsonArray) : TJsonArray;

  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TUsuarioDao.AcessoFuncionalidade(pUsuarioId: Integer;
  pFuncionalidade: String): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
     Query.FetchOptions.Mode := fmAll;
     Query.Sql.Add(tuEvolutConst.SqlGetUsuarioAcessoFuncionalidade);
     Query.ParamByName('pUsuarioId').Value := pUsuarioId;
     Query.ParamByName('PFuncionalidade').Value := pFuncionalidade;
     If Debughook <> 0 then
        Query.SQL.SaveToFile('AcessoFuncionalidade.Sql');
     Query.Open;
     if Query.IsEmpty then Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Acesso não permitido a Funcionalidade!'));
     End
     Else Begin
       Result := Query.toJsonArray;
     End;
   Except on E: Exception do
     Begin
       Raise Exception.Create('Processo: Usuarios/acessofuncionalidade - '+TUtil.TratarExcessao(E.Message));
     End;
   end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.AcessoTopico(pUsuarioId: Integer; pTopico: String) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(tuEvolutConst.SqlGetUsuarioAcessoTopico);
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.ParamByName('pTopico').Value := pTopico;
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Acesso não permitido ao Tópico!'));
      End
      Else
        Result := Query.toJsonArray;
    Except on E: Exception do
      raise Exception.Create('Processo: Usuarios/acessotopico - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.AtualizarSenha(Const pJsonObject: TJsonObject): Boolean;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
  Result := False;
    try
      Query.Sql.Add('Update Usuarios ');
      Query.Sql.Add('    Set  Senha  = ' + QuotedStr(pJsonObject.GetValue<String>('senha')));
      Query.Sql.Add('        ,SenhaPadrao = 0');
      Query.Sql.Add('        ,DtUltimaAlteracaoSenha = ' + tuEvolutConst.SqlDataAtual);
      Query.Sql.Add('Where UsuarioId = ' + pJsonObject.GetValue<String>('usuarioId'));
      Query.ExecSQL;
      Result := True;
    Except On E: Exception do
      raise Exception.Create('Processo: Usuarios/atualizarsenha - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.ControleAcesso(pUsuarioId: Integer): TJsonObject;
var JsonArrayModulos, JsonArrayFuncionalidades: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      JsonArrayModulos := TjSonArray.Create;
      JsonArrayFuncionalidades := TjSonArray.Create;
      Query.Sql.Add(tuEvolutConst.SqlGetControleAcessoModulo);
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.Open;
      if Query.IsEmpty then Begin
         JsonArrayModulos.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há Tópicos cadastrado no sistema!'));
         Result.AddPair('topicos', JsonArrayModulos);
      End
      Else
      Begin
        Result.AddPair('topicos', Query.toJsonArray);
      End;
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add(tuEvolutConst.SqlGetControleAcessoFuncionalidade);
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.Open;
      if Query.IsEmpty then Begin
         JsonArrayModulos.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há Funcionalidades cadastrado no sistema!'));
         Result.AddPair('funcionalidades', JsonArrayModulos);
      End
      Else
         Result.AddPair('funcionalidades', Query.toJsonArray);
    Except on E: Exception do
      Begin
        JsonArrayModulos.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        JsonArrayFuncionalidades.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        Result.AddPair('topicos', JsonArrayModulos);
        Result.AddPair('funcionalidades', JsonArrayFuncionalidades);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

constructor TUsuarioDao.Create;
begin
  inherited;
end;

function TUsuarioDao.Delete(pUsuarioId: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Usuarios where UsuarioId = ' + pUsuarioId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except on E: Exception do
      raise Exception.Create('Processo: Usuarios/delete - '+ TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TUsuarioDao.Destroy;
begin
  inherited;
end;

function TUsuarioDao.FindLoginNome(pLogin, pNome: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(SqlUsuario);
      Query.Sql.Add('Where (1=1)');
      if pLogin <> '*' then
         Query.Sql.Add(' And U.Login like ' + QuotedStr('%' + pLogin + '%'));
      if pNome <> '*' then
         Query.Sql.Add(' And U.Nome like ' + QuotedStr('%' + pNome + '%'));
      If DebugHook <> 0 Then
        Query.Sql.SaveToFile('GetFindLoginNome.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Dados não encontrado na pesquisa!'));
      End
      Else
        Result := Query.toJsonArray;
    Except
      on E: Exception do
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.GetAtivo: TJsonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('select U.UsuarioId, U.Login, U.Nome, U.Senha, U.SenhaPadrao, U.DiasSenhaValida, U.Senha, U.Email, ');
      Query.Sql.Add('       P.PerfilId, P.Descricao, P.Status StatusPerfil, FORMAT(Dp.Data, '+#39+'dd/MM/yyyy'+#39+') Data,');
      Query.Sql.Add('       CONVERT(Time(0), Hp.hora, 0) hora, FORMAT(UAS.Data, ' + #39 + 'dd/MM/yyyy' + #39+') as DtUltimaAlteracaoSenha,');
      Query.Sql.Add('       CONVERT(VARCHAR(5), HAS.hora,108) as HrUltimaAlteracaoSenha, FORMAT(DI.Data, '+#39+'dd/MM/yyyy'+#39+') as DtInclusao,');
      Query.Sql.Add('       CONVERT(VARCHAR(5), HI.hora,108) as HrInclusao, U.Status, Coalesce(UL.IdLogOn, 0) IdLogOn, ');
      Query.Sql.Add('       Ul.Terminal, Ul.DataInicio, Ul.HoraInicio');
      Query.Sql.Add('From Usuarios U ');
      Query.Sql.Add('Inner Join Perfil P On P.PerfilId = U.PerfilId');
      Query.Sql.Add('Left Join Rhema_Data UAS ON UAS.IdData = U.DtUltimaAlteracaoSenha ');
      Query.Sql.Add('Join Rhema_Hora HAS ON HAS.IdHora = U.HrUltimaAlteracaoSenha');
      Query.Sql.Add('Left Join Rhema_Data DI ON DI.IdData = U.DtInclusao ');
      Query.Sql.Add('Left Join Rhema_Hora HI ON HI.IdHora = U.HrInclusao');
      Query.Sql.Add('Left Join Rhema_Data DP ON DP.IdData = P.Data ');
      Query.Sql.Add('Left Join Rhema_Hora HP ON HP.IdHora = P.Hora');
      Query.Sql.Add('Left Join (Select Top 1 UsuarioId, Coalesce(IdLogOn, 0) IdLogOn, Terminal, DataInicio, HoraInicio');
      Query.Sql.Add('           From UsuarioLogOnOff');
      Query.Sql.Add('           Where OnOff = 1) Ul On Ul.UsuarioId = U.UsuarioId');
      Query.Sql.Add('where U.Status = 1');
      Query.Sql.Add('Order by U.Nome');
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('GetUsuarioAtivo.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Dados não encontrado na pesquisa!'));
      End
      Else Begin
         Result := Query.toJsonArray;
      End;
    Except
      on E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.GetId(pUsuarioId: String): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(SqlUsuario);
      if pUsuarioId <> '0' then Begin
         if StrToInt64Def(pUsuarioId, 0) > 0 then
            Query.Sql.Add('where U.UsuarioId = ' + pUsuarioId)
         Else
            Query.Sql.Add('where U.Login = ' + QuotedStr(pUsuarioId) + ' or U.Nome  Like ' + QuotedStr('%' + pUsuarioId + '%'));
      End;
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('GetUsuario.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Dados não encontrado na pesquisa!'));
      End
      Else Begin
         Result := Query.toJsonArray;
      End;
    Except
      on E: Exception do
      Begin
        raise Exception.Create('Processo: Usuario/getid - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.GetRelUsuarioLista(pUsuarioId, pFuncionalidadeId,
  pPerfilId, pStatus: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(tuEvolutConst.SqlRelUsuarioLista);
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.ParamByName('pFuncionalidadeId').Value := pFuncionalidadeId;
      Query.ParamByName('pPerfilId').Value := pPerfilId;
      Query.ParamByName('pStatus').Value := pStatus;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('UsuarioLista.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', tuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.toJsonArray;
    Except on E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.GetUsuario4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
    vSql: String;
begin
  Try
    QryPesquisa    := TFdQuery.Create(Nil);
    QryRecordCount := TFdQuery.Create(Nil);
    vSql := 'select U.UsuarioId, U.Nome, U.PerfilId, P.Descricao Perfil, U.Status'+sLineBreak +
            'From Usuarios U' + sLineBreak +
            'Inner Join Perfil P On P.PerfilId = U.PerfilId' + sLineBreak +
            'Where 1 = 1';
    Result := TJsonObject.Create();
    try
      QryPesquisa.Connection := Connection;
      QryPesquisa.Sql.Add(vSql);
      QryRecordCount.Connection := Connection;
      QryRecordCount.connection := QryPesquisa.connection;
      QryRecordCount.Sql.Add('Select Count(UsuarioId) cReg From Usuarios Where 1 =1');
      if AParams.ContainsKey('usuarioid') then begin
         QryPesquisa.Sql.Add('and UsuarioId = :UsuarioId');
         QryPesquisa.ParamByName('UsuarioId').AsLargeInt := AParams.Items['usuarioid'].ToInt64;
         QryRecordCount.Sql.Add('and UsuarioId = :UsuarioId');
         QryRecordCount.ParamByName('UsuarioId').AsLargeInt := AParams.Items['usuarioid'].ToInt64;
      end;
      if AParams.ContainsKey('nome') then begin
         QryPesquisa.Sql.Add('and (Nome like :Nome)');
         QryPesquisa.ParamByName('Nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
         QryRecordCount.Sql.Add('and (Nome like :Nome)');
         QryRecordCount.ParamByName('Nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
      end;
      if AParams.ContainsKey('limit') then begin
         QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 200);
         QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 200);
      end;
      if AParams.ContainsKey('offset') then
         QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
      QryPesquisa.Sql.Add('order by Nome');
      QryPesquisa.Open();
      Result.AddPair('data', QryPesquisa.toJsonArray());
      if DebugHook <> 0 then
         QryPesquisa.Sql.SaveToFile('UsuarioLista.Sql');
      QryRecordCount.Open();
      Result.AddPair('records', TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
    Except On E: Exception do
      raise Exception.Create('Processo: Usuario/usuario4D - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TUsuarioDao.ImportCSV(pJsonArray: TJsonArray): TJsonArray;
Var xUsuario  : Integer;
    vPerfilId : Integer;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    for xUsuario := 0 to Pred(pJsonArray.Count) do Begin
      Try
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Select PerfilId From Perfil Where Descricao = '+QuotedStr(pJsonArray.Items[xUsuario].GetValue<String>('perfil')));
        Query.Open();
        vPerfilid := StrToIntDef(Query.FieldByName('PerfilId').AsString, 1);
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Insert Into Usuarios (login, nome, senha,	senhapadrao,	diassenhavalida, email, ');
        Query.Sql.Add('                      PerfilId, dtultimaalteracaosenha,	hrultimaalteracaosenha,	');
        Query.Sql.Add('                      dtinclusao,	hrinclusao,	status,	uuid) Values(');
        Query.SQL.Add(QuotedStr(pJsonArray.Items[xUsuario].GetValue<String>('login'))+', '+
                                QuotedStr(pJsonArray.Items[xUsuario].GetValue<String>('nome'))+', '+
                                QuotedStr(pJsonArray.Items[xUsuario].GetValue<String>('senha'))+', 0, 30, '+
                                QuotedStr(pJsonArray.Items[xUsuario].GetValue<String>('email'))+', '+vPerfilId.ToString+', '+
                                TuEvolutConst.SqlDataAtual+', '+TuEvolutConst.SqlHoraAtual+', '+
                                TuEvolutConst.SqlDataAtual+', '+TuEvolutConst.SqlHoraAtual+', 1, NewId()' );
        Query.Sql.Add(')');
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('UsuarioImport.csv');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('Ok',  pJsonArray.Items[xUsuario].GetValue<String>('login'))
                                            .AddPair('nome',pJsonArray.Items[xUsuario].GetValue<String>('nome')));
      Except On E: Exception do Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message)
                                            .AddPair('login', pJsonArray.Items[xUsuario].GetValue<String>('login'))
                                            .AddPair('nome',pJsonArray.Items[xUsuario].GetValue<String>('nome')));
        End;
      End;
    End;
  finally
    Query.Free;
  end;
end;

function TUsuarioDao.InsertUpdate(pUsuarioId: Integer; pLogin, pNome, pSenha: String; pSenhaPadrao,
                                  pDiasSenhaValida: Integer; pEmail: String; pPerfilId, pStatus: Integer): TjSonArray;
var vSql: String;
    vUsuarioId : Integer;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pUsuarioId = 0 then
         vSql := 'Insert Into Usuarios (Login, Nome, Senha, SenhaPadrao, DiasSenhaValida, Email, PerfilId, '+sLineBreak+
                 'DtUltimaAlteracaoSenha, HrUltimaAlteracaoSenha, DtInclusao, HrInclusao, Status) '+sLineBreak+
                 'OUTPUT Inserted.UsuarioId as UsuarioId Values ('+
                 QuotedStr(pLogin) + ', ' + QuotedStr(pNome) + ', ' + QuotedStr(pSenha)
                 + ', ' + pSenhaPadrao.ToString() + ', ' + pDiasSenhaValida.ToString() +
                 ', ' + QuotedStr(pEmail) + ', ' + pPerfilId.ToString + ', ' +
                 tuEvolutConst.SqlDataAtual + ', ' + tuEvolutConst.SqlHoraAtual + ', ' +
                 tuEvolutConst.SqlDataAtual + ', ' + tuEvolutConst.SqlHoraAtual + ', ' +
                 pStatus.ToString() + ')'
      Else
         vSql := 'Update Usuarios ' + sLineBreak + '    Set  Login  = ' +
                 QuotedStr(pLogin) + sLineBreak + '        ,Nome   = ' + QuotedStr(pNome)+sLineBreak+
                 '        ,Senha  = ' + QuotedStr(pSenha) + sLineBreak +
                 '        ,SenhaPadrao = ' + pSenhaPadrao.ToString() + sLineBreak +
                 '        ,DiasSenhaValida = ' + pDiasSenhaValida.ToString() + sLineBreak
                 + '        ,Email  = ' + QuotedStr(pEmail) + sLineBreak +
                 '        ,PerfilId = ' + pPerfilId.ToString + sLineBreak +
                 '        ,DtUltimaAlteracaoSenha = (Select IdData From Rhema_Data where Data = Cast(GetDate() as Date))'+sLineBreak+
                 '        ,HrUltimaAlteracaoSenha = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
                 '        ,Status   = ' + pStatus.ToString() + sLineBreak+
                 'OUTPUT Inserted.UsuarioId as UsuarioId'+sLineBreak+
                 'Where UsuarioId = ' + pUsuarioId.ToString;
      Query.Sql.Add(vSql);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('UsuarioIns.Sql');
      Query.Open;
      vUsuarioId := Query.FieldByName('UsuarioId').AsInteger;
      Result := TJSONArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('usuarioid', Query.FieldByName('UsuarioId').AsInteger));
    Except On E: Exception do Begin
        raise Exception.Create('Processo: Usuario/insertupdate - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.ListaFuncionalidade(pUsuarioId: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(tuEvolutConst.SqlGetUsuarioListaFuncionalidade);
      Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', tuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.toJsonArray;
    Except on E: Exception do
      Raise Exception.Create('Processo: Usuario/listafuncionalidade - '+TUtil.TratarExcessao(E.Message))
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.LogOnOff(pJsonObject: TJsonObject): TjSonArray;
Var Query : TFdQuery;
begin
  Result := TjsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pJsonObject.GetValue<Integer>('logonoff') = 1 then Begin
         Query.Sql.Add('Select IdLogOn From UsuarioLogOnOff');
         Query.Sql.Add('Where UsuarioId = ' + pJsonObject.GetValue<Integer>('usuarioid').ToString());
         Query.Sql.Add('  And OnOff = 1 and Terminal = ' + #39 +pJsonObject.GetValue<String>('terminal') + #39);
         Query.Open;
         if Query.IsEmpty then Begin
           Query.Close;
           Query.Sql.Clear;
           Query.Sql.Add('Declare @IdLogOn Integer = 0');
           Query.Sql.Add('Insert into UsuarioLogOnOff (onoff, usuarioid, datainicio, horainicio, terminal, versaoapp, uuid) values (');
           Query.Sql.Add(pJsonObject.GetValue<String>('logonoff') + ', ' + pJsonObject.GetValue<Integer>('usuarioid').ToString() + ', ' +
                         'GetDate(), GetDate(), ' + #39 + pJsonObject.GetValue<String>('terminal') + #39 + ', ' + #39 + pJsonObject.GetValue<String>('versaoapp') + #39 +
                         ', NewId()');
           Query.Sql.Add(')');
           Query.Sql.Add('Set @IdLogOn = SCOPE_IDENTITY()');
           Query.Sql.Add('Select @IdLogOn As IdLogOn');
           Query.Open;
         End
      End;
      if (pJsonObject.GetValue<Integer>('logonoff') = 0) Then
      Begin
        Query.Sql.Add('Update UsuarioLogOnOff');
        Query.Sql.Add('  Set OnOff = 0,');
        Query.Sql.Add('      DataTermino = GetDate(),');
        Query.Sql.Add('      HoraTermino = GetDate()');
        Query.Sql.Add('Where IdLogOn = ' + pJsonObject.GetValue<Integer>('idlogon').ToString());
        Query.Sql.Add('Select ' + pJsonObject.GetValue<Integer>('idlogon').ToString() + ' As IdLogOn');
        Query.Open;
      End;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('UsuarioLogOnOff.Sql');
      Result.AddElement(TJsonObject.Create.AddPair('idlogon', Query.FieldByName('IdLogOn').AsString));
    Except on E: Exception do
        raise Exception.Create('Processo: Usuario/LogOnOff - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TUsuarioDao.SalvarAcesso(pUsuarioId: Integer; pJsonObject: TJsonObject) : TjSonArray;
Var pJsonArrayTopicos, pJsonArrayFuncionalidades: TjSonArray;
    vQryTopico, vQryFuncionalidade: TFDQuery;
    xTopico, xFuncionalidade: Integer;
begin
  Try
    vQryTopico         := TFdQuery.Create(Nil);
    vQryFuncionalidade := TFdQuery.Create(Nil);
    Try
      vQryTopico.Connection         := Connection;
      vQryFuncionalidade.Connection := Connection;
      pJsonArrayTopicos := TjSonArray.Create;
      pJsonArrayFuncionalidades := TjSonArray.Create;
      pJsonArrayTopicos := pJsonObject.GetValue<TjSonArray>('topicos');
      pJsonArrayFuncionalidades := pJsonObject.GetValue<TjSonArray>('funcionalidades');
      vQryTopico.connection.StartTransaction;
//      vQryTopico.connection.TxOptions.Isolation := xiReadCommitted;
      vQryTopico.Close;
      vQryTopico.Sql.Clear;
      vQryTopico.Sql.Add('Delete from UsuarioTopicos where UsuarioId = ' + pUsuarioId.ToString);
      vQryTopico.Sql.Add('Delete from UsuarioFuncionalidades where UsuarioId = ' + pUsuarioId.ToString);
      vQryTopico.ExecSQL;
      vQryTopico.Close;
      vQryTopico.Sql.Clear;
      vQryTopico.Sql.Add(tuEvolutConst.SqlSalvarAcessoTopico);
      for xTopico := 0 to Pred(pJsonArrayTopicos.Count) do Begin
         vQryTopico.Close;
         vQryTopico.ParamByName('pUsuarioId').Value := pUsuarioId;
         vQryTopico.ParamByName('pTopicoId').Value := pJsonArrayTopicos.Items[xTopico].GetValue<Integer>('topicoid');
         vQryTopico.ParamByName('pAcesso').Value := pJsonArrayTopicos.Items[xTopico].GetValue<Integer>('acesso');
         vQryTopico.ExecSQL;
      End;
      vQryFuncionalidade.Close;
      vQryFuncionalidade.Sql.Clear;
      vQryFuncionalidade.Sql.Add('Delete UsuarioFuncionalidades Where UsuarioId = ' + pUsuarioId.ToString());
      vQryFuncionalidade.ExecSQL;
      vQryFuncionalidade.Close;
      vQryFuncionalidade.Sql.Clear;
      vQryFuncionalidade.Sql.Add(tuEvolutConst.SqlSalvarAcessoFuncionalidade);
      for xFuncionalidade := 0 to Pred(pJsonArrayFuncionalidades.Count) do Begin
          vQryFuncionalidade.Close;
          vQryFuncionalidade.ParamByName('pUsuarioId').Value := pUsuarioId;
          vQryFuncionalidade.ParamByName('pFuncionalidadeId').Value := pJsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>('funcionalidadeid');
          vQryFuncionalidade.ParamByName('pAcesso').Value := pJsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>('acesso');
          vQryFuncionalidade.ExecSQL;
      End;
      Result := vQryFuncionalidade.toJsonArray;
      vQryTopico.connection.Commit;
    Except ON E: Exception do
      Begin
        vQryTopico.connection.Rollback;
        Raise Exception.Create('Processo: Usuario/salvaracesso - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQryTopico.Free;
    vQryFuncionalidade.Free;
  End;
end;


function TUsuarioDao.UsuarioConectado: TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('select Ul.*, U.Nome, iif(onoff=1, ' + #39 + 'Logado' + #39 +', ' + #39 + 'LogOf' + #39 + ') As LogOn');
      Query.Sql.Add('from usuariologonoff UL');
      Query.Sql.Add('Inner join Usuarios U On U.UsuarioId = Ul.UsuarioId');
      Query.Sql.Add('Where OnOff = 1');
      Query.Sql.Add('Order by U.Nome, DataInicio');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não há usuários conectado!'));
      End
      Else
        Result := Query.toJsonArray;
    Except on E: Exception do
      Begin
        raise Exception.Create('Processo: Usuario/usuarioconectado - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
