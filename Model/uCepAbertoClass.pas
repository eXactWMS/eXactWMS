unit uCepAbertoClass;

interface

Uses System.Classes, Dialogs, Generics.Collections, System.SysUtils, Rest.Json, IdHTTP, System.StrUtils, System.Json; //, UBotDAO;

type
 TCepAberto = class
   private
     FCep : String;
     FAltitude    : LongInt;
     FLatitude    : LongInt;
     FLongitude   : LongInt;
     FLogradouro  : String;
     FComplemento : String;
     FIdBairro    : Integer;
     FBairro      : String;
     FCidade      : String;
     FDdd         : Integer;
     FIbge        : String;
     FEstado      : String;
     Class Procedure AddCep(vCep, vIbge : String);
     Class Procedure AddDDD(vIbge : String; vDDD : Integer);
     Class Procedure AddMunicipio(vCodMunDv, vMunNomeX, vUF, vCep : String; vLatitude, vLongitude, vAltitude : LongInt);
     Class Procedure AddLogradouro(vLogradouro, vUF, vBairro, vCidade, vCep, vComplemento : String);
   Protected
   Public
     constructor Create;
     Class Function ClassToJson(Const ObjCepAberto : TCepAberto) : String;
     Class Function GetCepAberto(Cep : String) : TCepAberto;
     Class Function GetCepAbertoLat(pLatitude, pLongitude : String) : TCepAberto;
     Class Function JsonToClass(LJSONObject: TJSONObject) : TCepAberto;
     Class Function SeekBairro(vCodBai : String = ''; vNomBai : String = ''; vUF : String = ''; vNew : Boolean = False) : Integer;
     Class Function GetBairro(vBai_Nu_Sequencial : Integer) : String;
     Property Cep                    : String    Read FCep        Write FCep;
     property Altitude               : LongInt   Read FAltitude   Write FAltitude;
     property Latitude               : LongInt   Read FLatitude   Write FLatitude;
     property Longitude              : LongInt   Read FLongitude  Write FLongitude;
     Property Logradouro             : String    Read FLogradouro Write FLogradouro;
     Property Complemento            : String    Read FComplemento Write FComplemento;
     Property IdBairro               : Integer   Read FIdBairro   Write FIdBairro;
     Property Bairro                 : String    Read FBairro     Write FBairro;
     Property Cidade                 : String    Read FCidade     Write FCidade;
     Property Ddd                    : Integer   Read FDdd        Write FDdd;
     Property Ibge                   : String    Read FIbge       Write FIbge;
     Property Estado                 : String    Read FEstado     Write FEstado;
   end;

implementation

{ TCepAberto }

uses uDmeXactWMS;

class procedure TCepAberto.AddCep(vCep, vIbge: String);
begin
{
   with DmCep.QryPesquisar do Begin
     Close;
     Sql.Clear;
     Sql.Add('If Not Exists (Select Cep From Cep Where Cep = '+QuotedStr(vCep)+') Begin');
     Sql.Add('   Declare @NewCode Int;');
     Sql.Add('   Insert Into Cep Values ('+QuotedStr(vCep)+', '+QuotedStr(AnsiLeftStr(vIbge,6))+')');
     Sql.Add('End');
     Try ExecSql Except End;
     Close;
   End;
}
end;

class procedure TCepAberto.AddDDD(vIbge: String; vDDD: Integer);
begin
{
   With DmCep.QryPesquisar do Begin
     Close;
     Sql.Clear;
     Sql.Add('If not Exists (Select DDD From Ddd_Fone Where Mun_ibge = '+QuotedStr(vIbge)+' and Ddd = '+vDdd.ToString()+') Begin');
     Sql.Add('   Insert Into Ddd_Fone Values ('+QuotedStr(vIbge)+', '+QuotedStr(vDdd.ToString)+')');
     Sql.Add('End');
 //    Sql.SaveToFile('AddDDD.Txt');
     Try ExecSql Except End;
   End;
}
end;

class procedure TCepAberto.AddLogradouro(vLogradouro, vUF, vBairro, vCidade,
  vCep, vComplemento: String);
begin
{
   With DmCep.QryPesquisar do Begin
     //Localidade
     Close;
     Sql.Clear;
     Sql.Add('If not Exists (Select Log_Nu_Sequencial From Log_Logradouro Where UFe_SG = '+QuotedStr(vUF)+' and Log_Nome='+QuotedStr(vLogradouro)+') Begin');
         Sql.Add('   Declare @Loc_Nu_Sequencial Int;');
         Sql.Add('   Declare @Bai_Nu_Sequencial Int;');
         Sql.Add('   Declare @Log_Sem_Acento VarChar(70);');  //http://www.devmedia.com.br/eliminando-caracteres-especiais-de-strings-no-sql-server-collate/25286
         Sql.Add('   Declare @Tp_Logr VarChar(255)');
         Sql.Add('   Declare @Log_No VarChar(255);');
         Sql.Add('   Set @Loc_Nu_Sequencial = (Select Loc_Nu_Sequencial From Log_Localidade Where Loc_no = '+QuotedStr(vCidade)+' and Cep='+QuotedStr(vCep)+')');
         Sql.Add('   Set @Bai_Nu_Sequencial = (Select Bai_Nu_Sequencial From Log_Bairro Where Ufe_Sg='+QuotedStr(vUf)+' and Bai_No='+QuotedStr(vBairro)+')');
         Sql.Add('   Set @Log_Sem_Acento    = '+QuotedStr(vLogradouro)+' Collate sql_latin1_general_cp1251_ci_as' );
         Sql.Add('   Set @Tp_Logr = (Select TipoLogradouro FroM LOG_TIPO_LOGR where TipoLogradouro =  SUBSTRING('+QuotedStr(vLogradouro)+
                                     ', 1, CHARINDEX('+#39' '+#39+', '+QuotedStr(vlogradouro)+', 1) - 1))');
         Sql.Add('   Set @Log_no = (Select SUBSTRING('+QuotedStr(vLogradouro)+', Coalesce(Len(@Tp_Logr),0)+1, Len('+QuotedStr(vLogradouro)+')-Coalesce(Len(@Tp_Logr),0)))');
         Sql.Add('   Insert Into Log_Logradouro (Log_Nu_Sequencial, UFe_SG, Loc_Nu_Sequencial, Log_No, Log_Nome, Bai_Nu_Sequencial_Ini, ');
         Sql.Add('                               Cep, Log_Complemento, Log_Tipo_Logradouro, Log_Status_Tipo_Log, Log_No_Sem_Acento) Values (');
         Sql.Add('(Select Coalesce(Max(Log_Nu_Sequencial),0)+1 From Log_Logradouro), '+QuotedStr(vUF)+', @Loc_Nu_Sequencial, @Log_No, '+
                 QuotedStr(vLogradouro)+', @Bai_Nu_Sequencial, '+QuotedStr(vCep)+', '+QuotedStr(vComplemento)+', @Tp_Logr, '+
                 QuotedStr('N')+', @Log_Sem_Acento )');
     Sql.Add('End');
     Sql.SaveToFile('AddLogradouro.Txt');
     Try ExecSql Except End;
   End;
}
end;

class procedure TCepAberto.AddMunicipio(vCodMunDv, vMunNomeX, vUF, vCep: String;
  vLatitude, vLongitude, vAltitude: LongInt);
begin
{
   With DmCep.QryPesquisar do Begin
     //Localidade
     Close;
     Sql.Add('If not Exists (Select Loc_NoSub From Log_Localidade Where Loc_NoSub = '+QuotedStr(vMunNomeX)+' and UFe_Sg='+QuotedStr(vUF)+' and Cep='+QuotedStr(vCep)+') Begin');
     Sql.Add('Insert Into Log_Localidade (Loc_Nu_Sequencial, Loc_NoSUb, Loc_No, Cep, UFe_SG, Loc_In_Situacao, Loc_In_Tipo_Localidade) Values (');
     Sql.Add('(Select Coalesce(Max(Loc_Nu_Sequencial),0)+1 From Log_Localidade), '+QuotedStr(vMunNomex)+', '+QuotedStr(vMunNomeX)+', '+QuotedStr(vCep)+', '+
             QuotedStr(vUF)+', 1, '+QuotedStr('M') );
     Sql.Add(')');
     Sql.Add('End');

     Sql.Add('if not Exists (Select MunCodDv From CadMun Where MunCodDv = '+QuotedStr(vCodMunDv)+') Begin');
     Sql.Add('Insert Into CadMun (MunCod, MunCodDv, MunNome, MunNomeX, UFCod, Latitude, Longitude, Altitude) values (');
     Sql.Add(QuotedStr(AnsiLeftStr(vCodMunDv,6))+', '+QuotedStr(vCodMunDv)+', '+QuotedStr(vMunNomeX)+', upper('+QuotedStr(vMunNomeX)+'), '+
             QuotedStr(AnsiLeftStr(vCodMunDv,2))+', '+vLatitude.ToString()+', '+vLongitude.ToString()+', '+vAltitude.ToString()+')' );
     Sql.Add('End');
     Sql.SaveToFile('AddMunicipio.Txt');
     Try ExecSql Except End;
   End;
}
end;

class function TCepAberto.ClassToJson(const ObjCepAberto: TCepAberto): String;
begin
  Result := tJson.ObjectToJsonString(ObjCepAberto);
end;

constructor TCepAberto.Create;
begin
  FCep         := '';
  FAltitude    := 0;
  FLatitude    := 0;
  FLongitude   := 0;
  FLogradouro  := '';
  FComplemento := '';
  FIdBairro    := 0;
  FBairro      := '';
  FCidade      := '';
  FDdd         := 0;
  FIbge        := '';
  FEstado      := '';
end;

class function TCepAberto.GetBairro(vBai_Nu_Sequencial: Integer): String;
begin
{
   With DmCep.QryGetBairro do Begin
     Close;
     Parameters.ParamByName('pBai_Nu_Sequencial').Value := vBai_Nu_Sequencial;
     Open;
     Result := FieldByName('Bai_No').AsString;
     Close;
   End;
}
end;

class function TCepAberto.GetCepAberto(Cep: String): TCepAberto;
begin
  //DmBase := TDmBase;
  DmeXactWMS.RESTClientCep.BaseURL := 'http://www.cepaberto.com/api/v3/cep?cep='+Cep;
  DmeXactWMS.RESTRequestCep.Execute;
  if DmeXactWMS.RESTRequestCep.Response.StatusCode in [200, 201] then
    Result := JsonToClass(tJsonObject(DmeXactWMS.RESTRequestCep.Response.JSONValue) as TJsonObject)
  else Begin
    Result := TCepAberto.Create;
    if DmeXactWMS.RESTRequestCep.Response.StatusCode = 403 then
       raise Exception.Create('Limite de pesquisa excedido')
    Else Raise Exception.Create('Ocorreu um erro no servidor de Pesquisa de CEP!');
  End;
End;

class function TCepAberto.GetCepAbertoLat(pLatitude,
  pLongitude: String): TCepAberto;

begin
  Try
    DmeXactWMS.RESTClientCep.BaseURL := 'http://www.cepaberto.com/api/v3/nearest?lat='+pLatitude+'&lng='+pLongitude;
    DmeXactWMS.RESTRequestCep.Execute;
    Result := JsonToClass(tJsonObject(DmeXactWMS.RESTRequestCep.Response.JSONValue) as TJsonObject);
  Except
    Result := Nil;
  End;
     //  Result := JsonToClass(  );        //https://www.youtube.com/watch?v=6kecuVQrRCY
end;

class function TCepAberto.JsonToClass(LJSONObject: TJSONObject): TCepAberto;
   function TrataObjeto(jObj:TJSONObject; Value : String) : string;
   var i:integer;
       jPar: TJSONPair;
   begin
        result := '';
        for i := 0 to jObj.Size - 1 do
        begin
             jPar := jObj.Get(i);
             if jPar.JsonValue Is TJSONObject then
                result := TrataObjeto((jPar.JsonValue As TJSONObject), value) else
             if sametext(trim(jPar.JsonString.Value), value) then
             begin
                  Result := jPar.JsonValue.Value;
                  break;
             end;
             if result <> '' then
                break;
        end;
   end;
begin
   Result := TCepAberto.Create;
   try
     if DmeXactWMS.RESTResponseCep.Content <> '{}' then Begin
     Result.Logradouro  := TrataObjeto(LJSONObject, 'logradouro');
     Result.Complemento := TrataObjeto(LJSONObject, 'complemento');
     Result.Ibge        := TrataObjeto(LJSONObject, 'ibge');
     Result.Ddd         := StrToIntDef(TrataObjeto(LJSONObject, 'ddd'), 0);
     Result.Bairro      := TrataObjeto(LJSONObject, 'bairro');
     Result.Cidade      := TrataObjeto(LJSONObject, 'nome');
     Result.Estado      := TrataObjeto(LJSONObject, 'sigla');
     Result.Cep         := TrataObjeto(LJSONObject, 'cep');
     //Result.Altitude    := TrataObjeto(LJSONObject, 'altitude').ToInteger();
     //Result.Latitude    := TrataObjeto(LJSONObject, 'latitude').ToInteger;
     //Result.Longitude   := TrataObjeto(LJSONObject, 'longitude').ToInteger;
     End;
   finally
//      LJSONObject.Free;
   end;
end;

class function TCepAberto.SeekBairro(vCodBai, vNomBai, vUF: String;
  vNew: Boolean): Integer;
begin
{
   with DmCep.QryPesquisar do Begin
     Close;
     Sql.Clear;
     Sql.Add('Select * From Log_Bairro');
     if vCodBai <> '' then Sql.Add('Where Bai_Nu_Sequencial = '+vCodBai)
     Else Sql.Add('Where Ufe_Sg = '+QuotedStr(vUF)+' and Bai_No = '+QuotedStr(vNomBai)+' Collate SQL_Latin1_General_CP1_CI_AI');     //https://sqlfromhell.wordpress.com/2010/05/01/ignorando-letras-maiusculas-minusculas-acentos-e-c/
     Open;
     if (IsEmpty() and vNew) then Begin
        Close;
        Sql.Clear;
        Sql.Add('Declare @NewCode Int;');
        Sql.Add('Set @NewCode = (Select Coalesce(Max(Bai_Nu_Sequencial),0)+1 From Log_Bairro )' );
        Sql.Add('  Insert Into Log_Bairro (Bai_Nu_Sequencial, Ufe_Sg, Bai_No) Values (@NewCode, '+QuotedStr(vUF)+', '+QuotedStr(vNomBai)+')');
        Sql.Add('Select @NewCode as Bai_Nu_Sequencial');
        Open;
     End;
     Result := FieldByName('Bai_Nu_Sequencial').AsInteger;
     Close;
   End;
}
end;

end.
