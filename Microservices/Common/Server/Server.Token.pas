unit Server.Token;

interface

uses
  System.JSON, Data.DB;

type
  TTokenWK = class
  public
    class function ObterVencimento: TDateTime;
    class function ObterChave: String;
    class function Obter(Usuario: String; Tipo: Integer): String;
    class function Validar(const pToken: String): Boolean;
    class function ObterTokenAsJsonValue(Usuario: String; Tipo: Integer)
      : TJsonValue; overload;
    class function ObterTokenAsJsonValue(DataSet: TDataSet)
      : TJsonValue; overload;
  end;

implementation

uses
  JOSE.Core.JWT, JOSE.Core.JWA, JOSE.Core.Builder, JOSE.Core.JWK,
  JOSE.Types.Bytes, System.NetEncoding, System.SysUtils,
  System.DateUtils, Server.Utils.SectionVariables;

{ TTokenWs }

class function TTokenWK.Obter(Usuario: String; Tipo: Integer): String;
Var
  LToken: TJWT;
begin
  LToken := Nil;
  Try
    LToken := TJWT.Create;
    case Tipo of
      0:
        LToken.Claims.Issuer := 'Administrador Master';
      1:
        LToken.Claims.Issuer := 'Administrador Loja';
      2:
        LToken.Claims.Issuer := 'Operador Loja';
    end;

    LToken.Claims.Subject := Usuario;
    LToken.Claims.IssuedAt := strtodate('01/01/2030');
    LToken.Claims.SetClaimOfType<String>('customer', '');
    Result := TJOSE.SHA256CompactToken(ObterChave, LToken);
  Finally
    if Assigned(LToken) then
      LToken.Free;
  End;
end;

class function TTokenWK.ObterChave: String;
const
  _SECRET_KEY: String = 'WK@Technology$2021';
Var
  lBase: TBase64Encoding;
begin
  lBase := nil;
  Try
    lBase := TBase64Encoding.Create;
    Result := '@' + lBase.Encode(_SECRET_KEY);
  Finally
    lBase.Free;
  End;
end;

class function TTokenWK.ObterTokenAsJsonValue(DataSet: TDataSet): TJsonValue;
Var
  lObj: TJSONObject;
begin
  lObj := TJSONObject.Create;
  lObj.AddPair('token',
    TJSONString.Create(Obter(DataSet.FieldByName('nm_usuario').AsString,
    DataSet.FieldByName('tp_usuario').AsInteger)));
  lObj.AddPair('tipo', TJSONNumber.Create(DataSet.FieldByName('tp_usuario')
    .AsInteger));
  lObj.AddPair('id', TJSONNumber.Create(DataSet.FieldByName('id_usuarios')
    .AsInteger));
  Result := lObj;
end;

class function TTokenWK.ObterTokenAsJsonValue(Usuario: String; Tipo: Integer)
  : TJsonValue;
Var
  lObj: TJSONObject;
begin
  lObj := TJSONObject.Create;
  lObj.AddPair('token', TJSONString.Create(Obter(Usuario, Tipo)));
  lObj.AddPair('tipo', TJSONNumber.Create(Tipo));
  Result := lObj;
end;

class function TTokenWK.ObterVencimento: TDateTime;
Var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(Now, Ano, Mes, Dia);
  Result := EncodeDateTime(Ano, Mes, Dia, 23, 59, 59, 0);
end;

class function TTokenWK.Validar(const pToken: String): Boolean;
Var
  LKey: TJWK;
  LToken: TJWT;
  LCompactToken: TJOSEBytes;
begin
  LToken := nil;
  Try
    Try
      LKey := TJWK.Create(ObterChave);
      LCompactToken := pToken;
      LToken := TJOSE.Verify(LKey, LCompactToken);
      Result := LToken.Verified;
      LToken.Claims.JSON.TryGetValue('empresa', FTSectionVariables.IdEmpresa);
      LToken.Claims.JSON.TryGetValue('userid', FTSectionVariables.Userid);
      LToken.Claims.JSON.TryGetValue('camada', FTSectionVariables.Camada);
      LToken.Claims.JSON.TryGetValue('idperfil', FTSectionVariables.IdPerfil);
      LToken.Claims.JSON.TryGetValue('idcolaborador',
        FTSectionVariables.IdColaborador);

      LToken.Claims.JSON.TryGetValue('idrevenda', FTSectionVariables.IdRevenda);

      if LToken.Claims.IssuedAt < Now then
        Result := False;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    if Assigned(LToken) then
      LToken.Free;
  End;
end;

end.
