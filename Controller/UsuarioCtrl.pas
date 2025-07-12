{
   UsuarioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 23/04/2021
   Projeto: eXactWMS
}
unit UsuarioCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     UsuarioClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TUsuarioCtrl = Class
  Private
    //Funções de Validação
    FObjUsuario : TUsuario;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindUsuario(pIdLoginNome : String = ''; pShowErro : Integer = 1; pSomenteAtivo : Integer = -1) : tJsonArray; //TObjectList<TUsuario>;
    Function Login(pIdLoginNome : String = ''; pShowErro : Integer = 1) : tJsonArray; //TObjectList<TUsuario>;
    Function FindLoginNome(pLogin, pNome : String) : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function AtualizarSenha : Boolean;
    Class Function DelUsuario(pIdUsuario : Integer) : Boolean;
    Function MontarPaginacao : Integer;
    Function AcessoFuncionalidade(pFuncionalidade : String) : Boolean;
    Function AcessoTopico(pTopico : String) : Boolean;
    Function ControleAcesso : TJsonObject;
    Function ListaFuncionalidade : TjsonArray;
    Function LogOn  : TJsonArray;
    Function LogOff : TJsonArray;
    Function SalvarAcesso(pJsonObject : TJsonObject) : Boolean;
    Function UsuarioConectado : TJsonArray;
    Function GetUsuarioLista(pUsuarioId, pFuncionalidadeid, pPerfilId, pStatus : Integer) : TJsonArray;
    Function ImportCSV(pJsonArray : TjsonArray) : TJsonArray;
    Property ObjUsuario  : TUsuario Read FObjUsuario Write FObjUsuario;
  End;

implementation

{ tCtrlUsuario }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tUsuarioCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjUsuario do Begin
    if login = '' then raise Exception.Create('Informe o Login do Usuário.');
    if nome  = '' then raise Exception.Create('Informe o Nome do Usuário.');
    if senha = '' then raise Exception.Create('Informe a senha do Usuário.');
    if DiasSenhaValida <= 0 then raise Exception.Create('Validade da senha inválido!');
    //if email = '' then raise Exception.Create('Informe o email do Usuário.');
    if Perfil.PerfilId = 0 then raise Exception.Create('O Perfil do usuário é obrigatório');
  End;
  Result := True;
End;

function TUsuarioCtrl.AcessoFuncionalidade(pFuncionalidade: String): Boolean;
Var vErro : String;
    JsonArrayRetorno : TJsonArray;
Begin
  if Self.ObjUsuario.Perfil.PerfilId = 1 then
     Result := True
  Else Begin
     Result := False;
     DmeXactWMS.ResetRest;
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/funcionalidade/{usuarioid}/{funcionalidade}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', Self.ObjUsuario.UsuarioId.ToString);
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('funcionalidade', pFuncionalidade);
     DmeXactWMS.RESTRequestWMS.Method := RmGet;
     DmeXactWMS.RESTRequestWMS.Execute;
     if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
        JsonArrayRetorno := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
        if not JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then
           Result := True;
     End
     Else
        raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  End;
end;

function TUsuarioCtrl.AcessoTopico(pTopico: String): Boolean;
Var vErro : String;
    JsonArrayRetorno : TJsonArray;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/topico/{usuarioid}/{topico}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', Self.ObjUsuario.UsuarioId.ToString);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('topico', pTopico);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
     JsonArrayRetorno := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then
        Result := False
     Else Result := True;
  End
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TUsuarioCtrl.AtualizarSenha: Boolean;
Var jSonUsuario : TJsonObject;
Begin
  Try
    Result := False;
    jSonUsuario := tJson.ObjectToJsonObject(ObjUsuario);
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(jSonUsuario.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario';
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    FreeAndNil(jSonUsuario);
    Result := (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201]); //= 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201));
  Except
    Result := False;
  End;
end;

function TUsuarioCtrl.ControleAcesso: TJsonObject;
//Var //ReturnJson  : TJsonArray;
    //JsonUsuario : TJsonObject;
    //xItens      : Integer;
    //vErro       : String;
    //ObjUsuarioCtrl  : TUsuarioCtrl;
//    Fh : TFormatSettings;
Begin
//  Fh.TimeSeparator := ':';
  Result := TJsonObject.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Params.Clear;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/controleacesso/{usuarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', ObjUsuario.Usuarioid.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TjsonObject
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

constructor TUsuarioCtrl.Create;
begin
  FObjUsuario := TUsuario.Create;
end;

class function TUsuarioCtrl.DelUsuario(pIdUsuario : Integer): Boolean;
Var vErro : String;
begin
  Try
    Result := False;
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/{usuarioid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', pIdUsuario.ToString());
    DmeXactWMS.RESTRequestWMS.Method := RmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := Not (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject).TryGetValue('Erro', vErro);
  Except
    Result := False;
  End;
end;

destructor TUsuarioCtrl.Destroy;
begin
  FObjUsuario.Free;
  inherited;
end;

function TUsuarioCtrl.FindLoginNome(pLogin, pNome: String): TJsonArray;
Var ReturnJson  : TJsonArray;
    JsonUsuario : TJsonObject;
    xItens      : Integer;
    vErro       : String;
    ObjUsuarioCtrl  : TUsuarioCtrl;
//    Fh : TFormatSettings;
Begin
//  Fh.TimeSeparator := ':';
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/{login}/{nome}';
  if pLogin = '' then pLogin := '*';
  if pNome  = '' then pNome  := '*';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('login', pLogin);
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('nome',  pNome);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     If Result.Items[0].TryGetValue<String>('Erro', vErro) then
        exit
     Else if (Result.Count >= 1) then Begin
        xItens := 0;
        repeat
          JsonUsuario := tJsonObject.Create;
          JsonUsuario := Result.Items[xItens] as TJSONObject;  //.GetValue<TJsonObject>('usuario');//
          FObjUsuario             := Self.ObjUsuario.JsonToClass(JsonUsuario.ToString());
          FObjUsuario.UsuarioId   := StrToIntDef(JsonUsuario.Get('usuarioid').JsonValue.Value, 0);
          FObjUsuario.Login       := JsonUsuario.Get('login').JsonValue.Value;
          FObjUsuario.Nome        := JsonUsuario.Get('nome').JsonValue.Value;
          FObjUsuario.Senha       := JsonUsuario.Get('senha').JsonValue.Value;
          FObjUsuario.SenhaPadrao := StrToIntDef(JsonUsuario.Get('senhapadrao').JsonValue.Value, 0);
          FObjUsuario.DiasSenhaValida := StrToIntDef(JsonUsuario.Get('diassenhavalida').JsonValue.Value, 0);
          FObjUsuario.Email       := JsonUsuario.Get('email').JsonValue.Value;
          //Pegar o Perfi;
          FObjUsuario.Perfil.PerfilId  := JsonUsuario.GetValue<Integer>('perfilid');
          FObjUsuario.Perfil.Descricao := JsonUsuario.GetValue<String>('descricao');
          FObjUsuario.Perfil.Status    := JsonUsuario.GetValue<integer>('statusperfil');
          FObjUsuario.Perfil.Data      := StrToDate(JsonUsuario.GetValue<String>('data'));
          if JsonUsuario.GetValue<String>('hora') <> '' then
             FObjUsuario.Perfil.Hora      := StrToTime(Copy(JsonUsuario.GetValue<String>('hora'), 1, 8));
          if JsonUsuario.Get('dtultimaalteracaosenha').JsonValue.Value <> 'null' then
             FObjUsuario.DtUltimaAlteracaoSenha := StrToDate(JsonUsuario.Get('dtultimaalteracaosenha').JsonValue.Value);
          if JsonUsuario.Get('hrultimaalteracaosenha').JsonValue.Value <> 'null' then
             FObjUsuario.HrUltimaAlteracaoSenha := StrToTime(JsonUsuario.Get('hrultimaalteracaosenha').JsonValue.Value);
          FObjUsuario.Status := StrToIntDef(JsonUsuario.Get('status').JsonValue.Value, 0);
          FObjUsuario.IdlogOn  := JsonUsuario.GetValue<Integer>('idlogon');
          FObjUsuario.Terminal := JsonUsuario.GetValue<String>('terminal');
          if JsonUsuario.Get('datainicio').JsonValue.Value <> 'null' then
             FObjUsuario.DataInicio := StrToDate(DateEUAtoBr(JsonUsuario.Get('datainicio').JsonValue.Value));
          if JsonUsuario.Get('horainicio').JsonValue.Value <> 'null' then
             FObjUsuario.HoraInicio := StrToTime(Copy(JsonUsuario.Get('horainicio').JsonValue.Value, 1, 8));
          JsonUsuario := Nil;
          JsonUsuario.DisposeOf;
          xItens := xItens + 1;
        until (xItens <= 1); //Pred(Result.Count));
     End;
  End
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function tUsuarioCtrl.FindUsuario(pIdLoginNome: String; pShowErro, pSomenteAtivo : Integer): tJsonArray;// TObjectList<TUsuario>;
Var ReturnJson  : TJsonArray;
    JsonUsuario : TJsonObject;
    xItens      : Integer;
    vErro       : String;
    ObjUsuarioCtrl  : TUsuarioCtrl;
//    Fh : TFormatSettings;
Begin
//  Fh.TimeSeparator := ':';
//  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pIdLoginNome = '0' then Begin
     if pSomenteAtivo = 1 then
        DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/ativo'
     Else
        DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario';
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/{idloginnome}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('idloginnome', pIdLoginNome);
  End;
  DmeXactWMS.RestRequestWMS.Params.AddHeader('usuario', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     If Result.Get(0).TryGetValue<String>('Erro', vErro) then
        exit
     Else if (Result.Count >= 1) then Begin
        xItens := 0;
        repeat
          JsonUsuario := tJsonObject.Create;
          JsonUsuario := Result.Items[xItens] as TJSONObject;  //.GetValue<TJsonObject>('usuario');//
          FObjUsuario             := Self.ObjUsuario.JsonToClass(JsonUsuario.ToString());
          FObjUsuario.UsuarioId   := StrToIntDef(JsonUsuario.Get('usuarioid').JsonValue.Value, 0);
          FObjUsuario.Login       := JsonUsuario.Get('login').JsonValue.Value;
          FObjUsuario.Nome        := JsonUsuario.Get('nome').JsonValue.Value;
          FObjUsuario.Senha       := JsonUsuario.Get('senha').JsonValue.Value;
          FObjUsuario.SenhaPadrao := StrToIntDef(JsonUsuario.Get('senhapadrao').JsonValue.Value, 0);
          FObjUsuario.DiasSenhaValida := StrToIntDef(JsonUsuario.Get('diassenhavalida').JsonValue.Value, 0);
          FObjUsuario.Email       := JsonUsuario.Get('email').JsonValue.Value;
          //Pegar o Perfi;
          FObjUsuario.Perfil.PerfilId  := JsonUsuario.GetValue<Integer>('perfilid');
          FObjUsuario.Perfil.Descricao := JsonUsuario.GetValue<String>('descricao');
          FObjUsuario.Perfil.Status    := JsonUsuario.GetValue<integer>('statusperfil');
          FObjUsuario.Perfil.Data      := StrToDate(JsonUsuario.GetValue<String>('data'));
          if JsonUsuario.GetValue<String>('hora') <> '' then
             FObjUsuario.Perfil.Hora      := StrToTime(Copy(JsonUsuario.GetValue<String>('hora'), 1, 8));
          if JsonUsuario.Get('dtultimaalteracaosenha').JsonValue.Value <> 'null' then
             FObjUsuario.DtUltimaAlteracaoSenha := StrToDate(JsonUsuario.Get('dtultimaalteracaosenha').JsonValue.Value);
          if JsonUsuario.Get('hrultimaalteracaosenha').JsonValue.Value <> 'null' then
             FObjUsuario.HrUltimaAlteracaoSenha := StrToTime(JsonUsuario.Get('hrultimaalteracaosenha').JsonValue.Value);
          FObjUsuario.Status   := StrToIntDef(JsonUsuario.Get('status').JsonValue.Value, 0);
          FObjUsuario.IdlogOn  := JsonUsuario.GetValue<Integer>('idlogon');
          FObjUsuario.Terminal := JsonUsuario.GetValue<String>('terminal');
          if JsonUsuario.Get('datainicio').JsonValue.Value <> 'null' then
             FObjUsuario.DataInicio := StrToDate(DateEUAtoBr(JsonUsuario.Get('datainicio').JsonValue.Value));
          if JsonUsuario.Get('horainicio').JsonValue.Value <> 'null' then
             FObjUsuario.HoraInicio := StrToTime(Copy(JsonUsuario.Get('horainicio').JsonValue.Value, 1, 8));
          JsonUsuario := Nil;
          JsonUsuario.DisposeOf;
          xItens := xItens + 1;
        until (xItens <= 1); //Pred(Result.Count));
     End
     Else If (pShowErro = 1) then
       Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TUsuarioCtrl.ListaFuncionalidade: TjsonArray;
Var JsonArrayRetorno : TJsonArray;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/listafuncionalidade/{usuarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', Self.ObjUsuario.UsuarioId.ToString);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TUsuarioCtrl.Login(pIdLoginNome: String;
  pShowErro: Integer): tJsonArray;
Var ReturnJson  : TJsonArray;
    JsonUsuario : TJsonObject;
    xItens      : Integer;
    vErro       : String;
    ObjUsuarioCtrl  : TUsuarioCtrl;
//    Fh : TFormatSettings;
Begin
//  Fh.TimeSeparator := ':';
//  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pIdLoginNome = '0' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/login/{idloginnome}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('idloginnome', pIdLoginNome);
  End;
  DmeXactWMS.RestRequestWMS.Params.AddHeader('usuario', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     If Result.Get(0).TryGetValue<String>('Erro', vErro) then
        exit
     Else if (Result.Count >= 1) then Begin
        xItens := 0;
        repeat
          JsonUsuario := tJsonObject.Create;
          JsonUsuario := Result.Items[xItens] as TJSONObject;  //.GetValue<TJsonObject>('usuario');//
          FObjUsuario             := Self.ObjUsuario.JsonToClass(JsonUsuario.ToString());
          FObjUsuario.UsuarioId   := StrToIntDef(JsonUsuario.Get('usuarioid').JsonValue.Value, 0);
          FObjUsuario.Login       := JsonUsuario.Get('login').JsonValue.Value;
          FObjUsuario.Nome        := JsonUsuario.Get('nome').JsonValue.Value;
          FObjUsuario.Senha       := JsonUsuario.Get('senha').JsonValue.Value;
          FObjUsuario.SenhaPadrao := StrToIntDef(JsonUsuario.Get('senhapadrao').JsonValue.Value, 0);
          FObjUsuario.DiasSenhaValida := StrToIntDef(JsonUsuario.Get('diassenhavalida').JsonValue.Value, 0);
          FObjUsuario.Email       := JsonUsuario.Get('email').JsonValue.Value;
          //Pegar o Perfi;
          FObjUsuario.Perfil.PerfilId  := JsonUsuario.GetValue<Integer>('perfilid');
          FObjUsuario.Perfil.Descricao := JsonUsuario.GetValue<String>('descricao');
          FObjUsuario.Perfil.Status    := JsonUsuario.GetValue<integer>('statusperfil');
          FObjUsuario.Perfil.Data      := StrToDate(JsonUsuario.GetValue<String>('data'));
          if JsonUsuario.GetValue<String>('hora') <> '' then
             FObjUsuario.Perfil.Hora      := StrToTime(Copy(JsonUsuario.GetValue<String>('hora'), 1, 8));
          if JsonUsuario.Get('dtultimaalteracaosenha').JsonValue.Value <> 'null' then
             FObjUsuario.DtUltimaAlteracaoSenha := StrToDate(JsonUsuario.Get('dtultimaalteracaosenha').JsonValue.Value);
          if JsonUsuario.Get('hrultimaalteracaosenha').JsonValue.Value <> 'null' then
             FObjUsuario.HrUltimaAlteracaoSenha := StrToTime(JsonUsuario.Get('hrultimaalteracaosenha').JsonValue.Value);
          FObjUsuario.Status   := StrToIntDef(JsonUsuario.Get('status').JsonValue.Value, 0);
          FObjUsuario.IdlogOn  := JsonUsuario.GetValue<Integer>('idlogon');
          FObjUsuario.Terminal := JsonUsuario.GetValue<String>('terminal');
          if JsonUsuario.Get('datainicio').JsonValue.Value <> 'null' then
             FObjUsuario.DataInicio := StrToDate(DateEUAtoBr(JsonUsuario.Get('datainicio').JsonValue.Value));
          if JsonUsuario.Get('horainicio').JsonValue.Value <> 'null' then
             FObjUsuario.HoraInicio := StrToTime(Copy(JsonUsuario.Get('horainicio').JsonValue.Value, 1, 8));
          JsonUsuario := Nil;
          JsonUsuario.DisposeOf;
          xItens := xItens + 1;
        until (xItens <= 1); //Pred(Result.Count));
     End
     Else If (pShowErro = 1) then
       Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TUsuarioCtrl.LogOff: TJsonArray;
Var JsonLogOn : TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    JsonLogOn := TJsonObject.Create;
    JsonLogOn.AddPair('idlogon',  TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.IdLogOn));
    JsonLogOn.AddPair('logonoff',  TJsonNumber.Create(0));
    JsonLogOn.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    {$IfDef Android}
       JsonLogOn.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
    {$else}
       JsonLogOn.AddPair('terminal', NomeDoComputador);
    {$Endif}
    JsonLogOn.AddPair('versaoapp', 'ND');
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/logonoff';
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(JsonLogOn.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := rmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201, 204]) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TUsuarioCtrl.LogOn: TJsonArray;
Var JsonLogOn : TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    JsonLogOn := TJsonObject.Create;
    JsonLogOn.AddPair('logonoff', TJsonNumber.Create(1));
    JsonLogOn.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    {$IfDef Android}
       JsonLogOn.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
    {$else}
       JsonLogOn.AddPair('terminal', NomeDoComputador);
    {$Endif}
    JsonLogOn.AddPair('versaoapp', 'ND');
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/logonoff';
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(JsonLogOn.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPUT;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode in [200, 201, 204]) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TUsuarioCtrl.MontarPaginacao: Integer;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/montarpaginacao';
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as tjsonObject).GetValue<Integer>('paginacao')
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function tUsuarioCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonUsuario : TJsonObject;
Begin
  Result := True;
  jSonUsuario := tJson.ObjectToJsonObject(ObjUsuario);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonUsuario.ToJson, ContentTypeFromString('application/json'));
  if ObjUsuario.UsuarioId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/{usuarioid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuarioid', ObjUsuario.UsuarioId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonUsuario);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then   Begin
     Self.ObjUsuario.UsuarioId := (DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray).Items[0].GetValue<Integer>('usuarioid', 0);
     Result := True;
  End
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TUsuarioCtrl.SalvarAcesso(pJsonObject: TJsonObject): Boolean;
Begin
  Result := False;
//  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/salvaracesso/{usuid}'; //{usuarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('usuid', ObjUsuario.UsuarioId.ToString());
  DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TUsuarioCtrl.UsuarioConectado: TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/conectado';
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TUsuarioCtrl.GetUsuarioLista(pUsuarioId, pFuncionalidadeId, pPerfilId,
  pStatus: Integer): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/lista?status='+pStatus.ToString();
    if pUsuarioId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource :=DmeXactWMS.RESTRequestWMS.Resource + '&usuarioid='+pUsuarioId.tostring();
    if pFuncionalidadeId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&funcionalidadeid='+pFuncionalidadeId.tostring();
    if pPerfilId <> 0 then
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+'&perfilid='+pPerfilId.tostring();
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TUsuarioCtrl.ImportCSV(pJsonArray: TjsonArray): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/usuario/importcsv';
    DmeXactWMS.RestRequestWMS.AddBody(pJsonArray.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Method := RmPost;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

End.

