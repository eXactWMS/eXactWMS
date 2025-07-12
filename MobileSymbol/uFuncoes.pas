unit uFuncoes;

interface

uses
  DBClient, Types, FMX.Controls, MaskUtils, IniFiles, strutils, IdUri ,System.Generics.Collections
  {$IFDEF ANDROID}
     , FMX.Platform.Android
     , Androidapi.JNI.Telephony
     , Androidapi.JNI.Provider
     , AndroidApi.helpers
     , AndroidApi.Jni
     , AndroidApi.Jni.App
     , AndroidApi.Jni.Net
     , AndroidApi.JNI.JavaTypes
     , AndroidApi.JNI.GraphicsContentViewText
     , AndroidApi.JNIBridge
     //Delphi 10.3.3
     , AndroidApi.JNI.OS
  {$ELSE}
     ,WinApi.WIndows, System.Win.Registry
  {$ENDIF}

  {$IfDef IOS}

     , ISOAPI.UIKIT

  {$EndIf}

  , Rest.Json, System.Json, Rest.Types, IdHashMessageDigest;

  function ApplyMask(aMask, aValue: String): String;  //Formatar Data em Tempo de Execução
  function Versao(pApp : String) : string;
  Function VersaoAPK : String;

  Function AddHoras(Hora1, Hora2 :String):String;
  Function  AplicarMascara(pTexto, pMascara: string): string; overload;
  Function Capitalizar(Texto : String) : String;
  function  Criptografar(pTexto: string): string;
  procedure Esperar(pSegundos: Integer);
  procedure ExportarExcel(pDados: TClientDataSet);
  function  NomeDoComputador: string;
  procedure OrdenarGrid(pClientDataSet: TClientDataSet; pCampo: string);
  function  RemoverCaracteres(pTexto: string): string;
  function  RemoverCaracteresEspeciais(pTexto: string): string;
  function  RemoverEspacos(pTexto: string): string;
  procedure SelecionarRegistro(pDataSet: TClientDataSet; pCampo: string);
  procedure SomDeAlerta;
  procedure SomDeErro;
  procedure SoNumeros(pKey: Char);
  function  Moeda(pValor: string): string;
  function  TraduzirEndereco(pEndereco: string): string;
  function  ValidarCPF(pNumero: string): Boolean;
  function  ValidarData(pData, pNome: string): TDateTime; overload;
  //function  ValidarData(pData: TCustomEdit; pNome: string): TDateTime; overload;
  //function  ValidarHora(pHora: TCustomEdit; pNome: string): TDateTime;
  function NomeMes(i: word; tipo: integer): string;
  function NomeDia(i: word; tipo: integer): string;
  Function Right(Texto : String; Tamanho : Int64) : String;
  procedure ValidarParametroTexto(var pParametro: string);
  Function Calculatempo(DataInicio, DataTermino : TDateTime) : String;
  Function Repl (vCaracter : String; Tamanho : Integer) : String;
  Function ReturnREST(Cod : Integer) : String;
  Procedure MsgWhatsApp(pMsg : String);
  Function EnderecoMask(pEndereco : String; pMask : String; pFormata : Boolean) : String;
  function GetValueInjSon(jObj:TJSONObject; Value : String) : string;
  Function MD5Texto(const texto:string) : String;
  Function DateEUAtoBr(pDataEUA : String) : String;
  {$IFDef Android}
    Function IMEI : String;
  {$Endif}
implementation

uses
  SysUtils, Classes, FMX.Dialogs, Data.DB;
  //Windows, Registry, , MMSystem;

//eXactWMS
function ApplyMask(aMask, aValue: String): String;
Var
   M, V  : Integer;
   Texto : AnsiString;
begin
  Result := '';
  Texto  := '';
  aMask  := aMask.ToUpper;
  Texto := StringReplace(aValue, '/', '', [rfReplaceAll]);
  M := 1;
  V := 1;
  while (V <= Length(Texto)) And (M <= Length(aMask)) do Begin
    if aMask[M] <> '#' then Begin
       Result := Result + aMask[M];
       Inc(M);
    End;
    Result := Result + Texto[V];
    Inc(M);
    Inc(V);
  End;


EXIT;

{  Result := '';
  Texto  := '';
  aMask  := aMask.ToUpper;
  for V := 0 to aValue.Length-1 do
     if aValue.Chars[V] In ['0'..'9'] Then
        Texto := Texto + aValue.Chars[V];
  M := 0;
  V := 0;
  while (V < Texto.Length) And (M < aMask.Length) do Begin
    While aMask.Chars[M] <> '#' Do Begin
      Result := Result + aMask.Chars[M];
      Inc(M);
    End;
    Result := Result + Texto.Chars[V];
    Inc(M);
    Inc(V);
  End;
}end;

Function EnderecoMask(pEndereco : String; pMask : String; pFormata : Boolean) : String;
Var vMaskClean, vEndereco : String;
    X, Y, PosIni, PosFinal, vMaskLen : Integer;
begin
  if pMask = '' then Begin
     Result := pEndereco;
     Exit;
  End;
  vMaskLen := 0;
  vMaskClean := StringReplace(StringReplace(pMask, '.', '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
  if length(pEndereco) <> Length(vMaskClean) then Begin
     Result := pEndereco;
     Exit;
  end;
  vEndereco := '';
  PosIni    := 1;
  PosFinal  := Length(vMaskClean);
  If Pos('A',vMaskClean) > 0 then Begin
     For X := PosIni to PosFinal do Begin
       if vMaskClean[X] in ['A'..'Z'] then
          vMaskLen := vMaskLen + 2
       Else vMaskLen := vMaskLen + 1;
     End;
  End
  Else vMaskLen := Length(vMaskClean);
  PosFinal := Length(pEndereco);
  for X := PosIni to PosFinal do Begin
    if pEndereco[X] in ['A'..'Z'] then Begin
       if (pMask <> '') and (Pos('A', vMaskClean) <= 0) then Begin
          Result := vEndereco;
          Exit;
       End;
       vEndereco := vEndereco + FormatFloat('00', Ord(pEndereco[X])-64);
    End
    Else vEndereco := vEndereco + pEndereco[X];
  End;
  if pMask = '' then Begin
     Result := vEndereco;
     Exit;
  End;
  if Length(vEndereco) > vMaskLen then Begin
     Result := vEndereco;
     Exit;
  End
  Else if (Length(vEndereco) < vMaskLen) and (Pos('!', vMaskClean) > 0) then Begin
     X := 1;
     Y := 0;
     repeat
       if vMaskClean[X] = '!' then
          vEndereco := Copy(vEndereco, 1, Y-1)+' '+Copy(vEndereco, Y, Length(vEndereco)-Y+1 )
       else If vMaskClean[X] = 'A' then //Forçar pular Duas posições
          Inc(Y);
       Inc(X);
       Inc(Y);
     until X >= vMaskLen;
  End;
  if Length(vEndereco) > vMaskLen then Begin
     Result := vEndereco;
     exit;
  End;
  pMask := pMask + ';0;_';
  if pFormata then
     Result := AplicarMascara(vEndereco, pMask)
  Else
     Result := StringReplace(StringReplace(AplicarMascara(vEndereco, pMask), '.', '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
End;

function AddHoras(Hora1, Hora2 :String):String;
var hh, mm, ss : Integer;
    vHora, vMinuto, vSegundo : Integer;
begin
  hh := StrToInt(Copy(Hora1, 1, 2)) + StrToInt(Copy(Hora2, 1, 2));
  mm := StrToInt(Copy(Hora1, 4, 2)) + StrToInt(Copy(Hora2, 4, 2));
  ss := StrToInt(Copy(Hora1, 7, 2)) + StrToInt(Copy(Hora2, 7, 2));

  vSegundo := ss Mod 60;
  mm       := mm + (ss Div 60);
  vMinuto:= mm mod 60;
  vHora:=   hh + (mm div 60);
  Result:= FormatFloat('00:', vHora) + FormatFloat('00', vMinuto)+':'+FormatFloat('00', vSegundo);
end;

Function Capitalizar(Texto : String) : String;
Begin
  Result := AnsiUpperCase(Texto);
End;

Function Repl (vCaracter : String; Tamanho : Integer) : String;
Var X : Integer;
Begin
  Result := '';
  for X := 1 to Tamanho do
    Result := Result + vCaracter;
End;

Function ReturnREST(Cod : Integer) : String;
Begin
  //https://restfulapi.net/http-status-codes/
  Result := 'Erro desconhecido no Servidor!';
  case Cod of
      0: Result := 'Falha de comunicação com Servidor.';
    200: Result := 'OK! Operação realizada com sucesso!';
    201: Result := 'OK! Dados gravados com sucesso!';
    202: Result := 'Processo lento... Pode ter ocorrido ERRO.';
    301: Result := 'Recurso indisponível no Servidor.';
    303: Result := 'OK! Sucesso na operação, mas servidor solicitou nova operação';
    400: Result := 'Recurso não disponível no Servidor. Check versão.';
    401: Result := 'Acesso não permitido ao servidor.';
    403: Result := 'Acesso não permitido ao Banco de Dados.';
    404: Result := 'Recurso indisponível no Servidor.';
    500: Result := 'ERRO: Repita a operação.';
    501: Result := 'Recurso indisponível no Servidor';
  end;
  Result := Cod.ToString()+': '+Result;
End;

function Versao(pApp : String): string;
{$IFDEF ANDROID}
   var vInfo : JPackageInfo;
{$ELSE}  //IFDEF MSWINDOWS}
   type
   PFFI = ^vs_FixedFileInfo;
   var
   F : PFFI;
   Handle : Dword;
   Len : Longint;
   Data : Pchar;
   Buffer : Pointer;
   Tamanho : Dword;
   Parquivo: Pchar;
   Arquivo : String;
   pNumVersao : String;
{$ENDIF}
begin
{$IFDEF ANDROID}
   vInfo := TAndroidHelper.Activity.GetPackageManager.GetPackageInfo(TAndroidHelper.Activity.GetPackageName, 0);
   Result := JStringToString(vInfo.VersionName)+' '+vInfo.VersionCode.ToString();
   exit; //Ver Se no Android pode Retornar aqui...
{$ELSE}  //IFDEF MSWINDOWS}
//http://compilaae.blogspot.com.br/2010/10/pegar-versao-da-aplicacao.html
  Arquivo := pApp;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := DateToStr(FileDateToDateTime(FileAge(Arquivo)));

  pNumVersao := '';
  if Len > 0 then Begin
     Data:=StrAlloc(Len+1);
     if GetFileVersionInfo(Parquivo,Handle,Len,Data) then begin
        VerQueryValue(Data, '\',Buffer,Tamanho);
        F := PFFI(Buffer);
        pNumVersao := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs),LoWord(F^.dwFileVersionMs),HiWord(F^.dwFileVersionLs),Loword(F^.dwFileVersionLs)]);
     end;
     StrDispose(Data);
  end;
  Result := StringReplace(pNumVersao+' / '+Result, '/', '-', [rfreplaceall]);
  StrDispose(Parquivo);
{$Endif}
end;

Function VersaoAPK : String;
{$IfDef Android}
   var PkgInfo : JPackageInfo;
{$Endif}
Begin
{$IfDef Android}
  PkgInfo := SharedActivity.GetpackageManager.GetPackageInfo(SharedActivity.GetPackageName, 0);
  //Result := JStringToString(PkgInfo.PackageName);
  Result := JStringToString(PkgInfo.VersionName)+'.'+PkgInfo.VersionCode.ToString();
{$Endif}
End;

{$IFDef Android}
Function IMEI : String;
var

  VVersionOSStr: String;
  {$IFDEF IOS}
    Device : UIDevice;
  {$ENDIF IOS}

  {$IFDEF ANDROID}
    function LocalGetImei(): String;
    var
      obj  : JObject;
      tm   : JTelephonyManager;
      IMEI : String;
    begin
      Result := 'SEM PERMISSAO';

      obj := SharedActivityContext.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);

      if obj <> nil then
      begin
        tm := TJTelephonyManager.Wrap((obj as ILocalObject).GetObjectID);
        if tm <> nil then
          IMEI := JStringToString(tm.getDeviceId);
      end;
      if IMEI = '' then
        IMEI := JStringToString(
          TJSettings_Secure.JavaClass.getString(
            SharedActivity.getContentResolver,
            TJSettings_Secure.JavaClass.ANDROID_ID
          )
        );
      Result := IMEI;
    end;
  {$ENDIF}


begin
  {$IFDEF ANDROID}
    //sult := LocalGetImei();
    Result := JStringToString(TJSettings_SECURE.JavaClass.getString(SharedActivity.getContentResolver, TJSettings_SECURE.JavaClass.ANDROID_ID));
  {$ENDIF}


  {$IFDEF IOS}
     Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice));
     Result := Device.uniqueIdentifier.UTF8String;
  {$ENDIF}
End;
{$Endif}

function AplicarMascara(pTexto, pMascara: string): string;
var
  vlTexto: string;
  vlMascara: string;
  i, j: Integer;

  function Traduzir(pNumero: string): string;
  begin
    case StrToInt(pNumero) of
       1: Result := 'A';
       2: Result := 'B';
       3: Result := 'C';
       4: Result := 'D';
       5: Result := 'E';
       6: Result := 'F';
       7: Result := 'G';
       8: Result := 'H';
       9: Result := 'I';
      10: Result := 'J';
      11: Result := 'K';
      12: Result := 'L';
      13: Result := 'M';
      14: Result := 'N';
      15: Result := 'O';
      16: Result := 'P';
      17: Result := 'Q';
      18: Result := 'R';
      19: Result := 'S';
      20: Result := 'T';
      21: Result := 'U';
      22: Result := 'V';
      23: Result := 'W';
      24: Result := 'X';
      25: Result := 'Y';
      26: Result := 'Z';
      99: Result := '99';
    end;
  end;
begin
  if (Trim(pTexto) <> '') and (Trim(pMascara) <> '') then begin
     vlMascara := Copy(pMascara, 1, Pos(';', pMascara) - 1);
     vlMascara := StringReplace(vlMascara, '.', '', [rfReplaceAll]);
     vlTexto   := '';
     {$if defined(Android)}
       j := 1;
     {$Else}
       j := 1;
     {$Endif}
     for i := 1 to (Length(vlMascara)) do begin
         if (CharInSet(vlMascara[i], ['A'..'Z'])) then begin
//            vlTexto := vlTexto + Traduzir(Copy(pTexto, j, 2));
             vlTexto := vlTexto + strutils.IfThen(StrtoInt(Copy(pTexto, j, 2))=99, '99',
                                                  Chr(64+StrtoInt(Copy(pTexto, j, 2))));
             Inc(j);
         end
         else
             vlTexto := vlTexto + pTexto[j];
         Inc(j);
     end;
     Result := FormatMaskText(pMascara, vlTexto);
 end
   else
     Result := pTexto;
end;

function Criptografar(pTexto: string): string;
const
  clChave: string = 'xj3xxyr4cjtqd6j';
var
  x, y: Integer;
  vlNovoTexto: String;
begin
  for x := 1 to Length(clChave) do
    begin
      vlNovoTexto := '';

      for y := 1 to Length(pTexto) do
        begin
          vlNovoTexto := vlNovoTexto + Chr((Ord(clChave[x]) xor Ord(pTexto[y])));
        end;

      pTexto := vlNovoTexto;
    end;

  Result := pTexto;
end;

procedure Esperar(pSegundos: Integer);
begin
end;

procedure ExportarExcel(pDados: TClientDataSet);
begin
end;

procedure OrdenarGrid(pClientDataSet: TClientDataSet; pCampo: string);
var
  vlCampos: string;
begin
  vlCampos := pClientDataSet.IndexFieldNames;
  pCampo   := ' ' + pCampo + ' ';

  if (Trim(vlCampos) = '') then
    begin
      pClientDataSet.IndexFieldNames := pCampo;
    end
  else
    begin
      if (vlCampos <> pCampo) then
        begin
          if (Pos(pCampo, vlCampos) = 1) then
            begin
              vlCampos := StringReplace(vlCampos, pCampo + ';', '', []);
            end
          else
            begin
              vlCampos := StringReplace(vlCampos, ';' + pCampo, '', []);
            end;

          vlCampos := pCampo + ';' + vlCampos;
          pClientDataSet.IndexFieldNames := vlCampos;
        end;
    end;
end;

//https://forums.embarcadero.com/thread.jspa?threadID=245437
function NomeDoComputador: string;
{$IfDef MsWindows}
  var vlRegistro : TRegistry;
{$Endif}
begin
  Result := 'ND';
  {$IfDef MsWindows}
     vlRegistro := TRegistry.Create(KEY_READ or KEY_WOW64_32KEY);
     try
       vlRegistro.RootKey := HKEY_LOCAL_MACHINE;
       vlRegistro.OpenKey('System\CurrentControlSet\Control\ComputerName\ActiveComputerName', False);
       Result := vlRegistro.ReadString('ComputerName');
     finally
       FreeAndNil(vlRegistro);
     end;
  {$Else}
     Result := IMEI;
  {$Endif}
//  GetEnvironmentVariable()
end;

function RemoverCaracteres(pTexto: string): string;
var
  i: integer;
  tmp: string;
begin
  tmp := '';

  for i := 1 to Length(pTexto) do
    begin
      if (CharInSet(pTexto[i], ['0'..'9'])) then
      	begin
          tmp := tmp + Copy(pTexto, i, 1);
      	end;
    end;

  Result := tmp;
end;

function RemoverCaracteresEspeciais(pTexto: string): string;
var
  i: integer;
  tmp: string;
begin
  tmp := '';

  for i := 1 to Length(pTexto) do
    begin
      if (CharInSet(pTexto[i], ['0'..'9'])) or (CharInSet(pTexto[i], ['a'..'z'])) or (CharInSet(pTexto[i], ['A'..'Z'])) then
      	begin
          tmp := tmp + Copy(pTexto, i, 1);
      	end;
    end;

  Result := tmp;
end;

function RemoverEspacos(pTexto: string): string;
begin
  Result := Trim(StringReplace(pTexto, ' ', '', [rfReplaceAll]));
end;

procedure SelecionarRegistro(pDataSet: TClientDataSet; pCampo: string);
begin
  if (pDataSet.IsEmpty = False) then
    begin
      pDataSet.Edit;
      case pDataSet.FieldByName(pCampo).AsInteger of
        0: pDataSet.FieldByName(pCampo).AsInteger := 1;
        1: pDataSet.FieldByName(pCampo).AsInteger := 0;
      end;
      pDataSet.Post;
    end;
end;

procedure SomDeAlerta;
begin
end;

procedure SomDeErro;
begin
end;

procedure SoNumeros(pKey: Char);
begin
  if not ((CharInSet(pKey, ['0'..'9'])) or (pKey = #8) or (pKey = #0))
     or (pKey = #13) or (pkey in [#113..#121] )then
    begin
      Abort;
    end;
end;

Procedure MsgWhatsApp(pMsg : String);
{$if defined(Android)}
  Var IWhats : JIntent;
{$Endif}
Begin
{$if defined(Android)}
  if Not pMsg.IsEmpty then Begin
     IWhats := TJIntent.JavaClass.init(TJintent.JavaClass.ACTION_SEND);
     IWhats.setType(StringToJString('text/plain'));
     IWhats.putExtra(TJintent.JavaClass.EXTRA_TEXT, StringToJString(pMsg));
     IWhats.SetPackage(StringToJString('com.whatsapp'));
//     SharedActivity.startActivity(IWhats);

     if TAndroidHelper.Activity.getPackageManager.queryIntentActivities(IWhats, TJPackageManager.JavaClass.MATCH_DEFAULT_ONLY).size > 0 then //Checks if there is at least one application capable of receiving the intent.
        TAndroidHelper.Activity.startActivity(IWhats) //Calls startActivity() to send the intent to the system.
  else
    ShowMessage('WhatsApp não está respondendo');
  End;
{$Endif}
End;

function Moeda(pValor: string): string;
var
  vlValor: Double;
begin
  pValor  := RemoverCaracteres(pValor);
  vlValor := (StrToInt64Def(pValor, 0) / 100);
  Result  := CurrToStrF(vlValor, ffCurrency, 2);
end;

function TraduzirEndereco(pEndereco: string): string;
var
  vlLetra: Char;
begin
  Result := Trim(UpperCase(pEndereco));

  if (Result <> '') then
    begin
      Result  := StringReplace(Result, '.', '', [rfReplaceAll]);
      vlLetra := Result[1];

      if (CharInSet(vlLetra, ['A'..'Z'])) then
        begin
          case vlLetra of
            'A': Result := StringReplace(Result, 'A', '01', [rfReplaceAll]);
            'B': Result := StringReplace(Result, 'B', '02', [rfReplaceAll]);
            'C': Result := StringReplace(Result, 'C', '03', [rfReplaceAll]);
            'D': Result := StringReplace(Result, 'D', '04', [rfReplaceAll]);
            'E': Result := StringReplace(Result, 'E', '05', [rfReplaceAll]);
            'F': Result := StringReplace(Result, 'F', '06', [rfReplaceAll]);
            'G': Result := StringReplace(Result, 'G', '07', [rfReplaceAll]);
            'H': Result := StringReplace(Result, 'H', '08', [rfReplaceAll]);
            'I': Result := StringReplace(Result, 'I', '09', [rfReplaceAll]);
            'J': Result := StringReplace(Result, 'J', '10', [rfReplaceAll]);
            'K': Result := StringReplace(Result, 'K', '11', [rfReplaceAll]);
            'L': Result := StringReplace(Result, 'L', '12', [rfReplaceAll]);
            'M': Result := StringReplace(Result, 'M', '13', [rfReplaceAll]);
            'N': Result := StringReplace(Result, 'N', '14', [rfReplaceAll]);
            'O': Result := StringReplace(Result, 'O', '15', [rfReplaceAll]);
            'P': Result := StringReplace(Result, 'P', '16', [rfReplaceAll]);
            'Q': Result := StringReplace(Result, 'Q', '17', [rfReplaceAll]);
            'R': Result := StringReplace(Result, 'R', '18', [rfReplaceAll]);
            'S': Result := StringReplace(Result, 'S', '19', [rfReplaceAll]);
            'T': Result := StringReplace(Result, 'T', '20', [rfReplaceAll]);
            'U': Result := StringReplace(Result, 'U', '21', [rfReplaceAll]);
            'V': Result := StringReplace(Result, 'V', '22', [rfReplaceAll]);
            'W': Result := StringReplace(Result, 'W', '23', [rfReplaceAll]);
            'X': Result := StringReplace(Result, 'X', '24', [rfReplaceAll]);
            'Y': Result := StringReplace(Result, 'Y', '25', [rfReplaceAll]);
            'Z': Result := StringReplace(Result, 'Z', '26', [rfReplaceAll]);
          end;
        end;
    end;
end;

function ValidarCPF(pNumero: string): Boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9 : integer;
  d1,d2 : integer;
  vlDigitado, vlCalculado : String;
begin
  n1 := StrToInt(pNumero[1]);
  n2 := StrToInt(pNumero[2]);
  n3 := StrToInt(pNumero[3]);
  n4 := StrToInt(pNumero[4]);
  n5 := StrToInt(pNumero[5]);
  n6 := StrToInt(pNumero[6]);
  n7 := StrToInt(pNumero[7]);
  n8 := StrToInt(pNumero[8]);
  n9 := StrToInt(pNumero[9]);
  d1 := n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1 := 11 - (d1 mod 11);

  if (d1 >= 10) then
    begin
      d1 := 0;
    end;

  d2 := d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
  d2 := 11 - (d2 mod 11);

  if (d2 >= 10) then
    begin
      d2 := 0;
    end;

  vlCalculado := IntToStr(d1) + IntToStr(d2);
  vlDigitado  := pNumero[10] + pNumero[11];

  Result := (vlCalculado = vlDigitado);
end;

function ValidarData(pData, pNome: string): TDateTime;
begin
  try
    Result := StrToDate(pData);
  except
    raise Exception.Create(pNome + ' inválida!');
  end;
end;

procedure ValidarParametroTexto(var pParametro: string);
begin
  pParametro := Trim(pParametro);

  if (pParametro = '') then
    begin
      pParametro := '%';
    end;
end;

function NomeMes(i: word; tipo: integer): string;
const mes: array[1..12] of string = ('Janeiro', 'Fevereiro',
  'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto',
  'Setembro', 'Outubro', 'Novembro', 'Dezembro');
begin
  if (tipo = 0)
     then NomeMes := mes[i] // extenso
// a função "copy" retorna os 3 primeiros caracteres de "mes[i]"
  else NomeMes := copy(mes[i], 1, 3); // abreviado
end;

function NomeDia(i: word; tipo: integer): string;
const Dia: array[1..7] of string = ('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');

begin
  if (tipo = 0)
     then NomeDia := Dia[i] // extenso
// a função "copy" retorna os 3 primeiros caracteres de "mes[i]"
  else NomeDia := copy(Dia[i], 1, 3); // abreviado
end;

Function Right(Texto : String; Tamanho : Int64) : String;
Begin
  Result := Copy(Texto, Length(Texto)-Tamanho+1, Tamanho);
End;

Function Calculatempo(DataInicio, DataTermino : TDateTime) : String;
Var Dias : Integer;
    Total , Horas : Real;
    H,M,S,SS:Word;
Begin
  if DataInicio > DataTermino then
    Total := DataInicio - DataTermino
  else
    Total := DataTermino - DataInicio;
  Dias:=Trunc(total);
  Horas:=total - Trunc(total);
  Decodetime(Horas,H,M,S,SS);
  H:=H+24*TRunc(dias);
  Result := FormatFloat('#00',H)+':'+FormatFloat('00',m)+':'+FormatFloat('00',s);
End;

function GetValueInjSon(jObj:TJSONObject; Value : String) : string;
var i:integer;
    jPar: TJSONPair;
begin
     result := '';
     for i := 0 to jObj.Size - 1 do
     begin
          jPar := jObj.Get(i);
          if jPar.JsonValue Is TJSONObject then
             result := GetValueInjSon((jPar.JsonValue As TJSONObject), value) else
          if sametext(trim(jPar.JsonString.Value), value) then
          begin
               Result := jPar.JsonValue.Value;
               break;
          end;
          if result <> '' then
             break;
     end;
end;

Function MD5Texto(const texto:string) : String;
var
  idmd5 : TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := idmd5.HashStringAsHex(texto);
  finally
    idmd5.Free;
  end;
end;

Function DateEUAtoBr(pDataEUA : String) : String;
Begin                            //2023-09-21
  if Length(pDataEUA) = 10 then Begin
     Result := Copy(pDataEUA, 9, 2)+'/'+
               Copy(pDataEUA, 6, 2)+'/'+
               Copy(pDataEUA, 1, 4)
  End
  Else Begin
     Result := Copy(pDataEUA, 9, 2)+'/'+
               Copy(pDataEUA, 6, 2)+'/'+
               Copy(pDataEUA, 1, 2)
  End;
End;

end.

(*  Enviar Arquivo Via Zap
procedure TFandroid.WhatsAppImage;
var
IntentWhats :JIntent;
FileUri :Jnet_Uri;
iArq :integer;
mensagem, sArqOrig1, sArqOrig2, sArqEnv1, sArqEnv2 :string;
ListArqs :JArrayList;
begin
if Edit1.Text.IsEmpty then
mensagem := ‘Teste de envio do Whatsapp com Delphi XE7. ‘+ #13+#10+
‘Confira mais no blog http://www.vivaitaocara.com.br/landersongomes/‘
else
mensagem := Edit1.Text;

sArqOrig1:=’sua_pasta/arquivo1.jpg’;
sArqOrig2:=’sua_pasta/arquivo2.jpg’;

//os arquivos devem ser copiados para uma pasta que o Whatapp possa ter acesso,
//como a pasta temporária do seu app (TPath.GetTempPath)
sArqEnv1:=TPath.GetTempPath +’/’+ ExtractFileName(sArqOrig1);
sArqEnv2:=TPath.GetTempPath +’/’+ ExtractFileName(sArqOrig2);

//então copiamos os arquivos para a pasta TPath.GetTempPath
//depois é aconselhável deletá-los
Tfile.Copy(sArqOrig1,sArqEnv1);
Tfile.Copy(sArqOrig2,sArqEnv2);

//criar o array para colocarmoa a lista de arquivos a serem enviados
ListArqs:= TJArrayList.Create;

FileUri:=TJNet_Uri.JavaClass.fromFile(TJFile.JavaClass.init(StringToJString(sArqEnv1)));
iArq:=0;
ListArqs.add(iArq,FileUri);

FileUri:=TJNet_Uri.JavaClass.fromFile(TJFile.JavaClass.init(StringToJString(sArqEnv2)));
inc(iArq);
ListArqs.add(iArq,FileUri);

IntentWhats := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
IntentWhats.setType(StringToJString(‘text/plain’));
IntentWhats.putExtra(TJIntent.JavaClass.EXTRA_TEXT,StringToJString(mensagem));

//para audio (‘audio/mp3’) ou (‘audio/mpeg3’) ou ainda (‘audio/*’)
IntentWhats.setType(StringToJString(‘image/jpg’));
IntentWhats.putParcelableArrayListExtra(TJIntent.JavaClass.EXTRA_STREAM,ListArqs);
IntentWhats.setPackage(StringToJString(‘com.whatsapp’));

//compartilhar diretamente com o WhatsApp
SharedActivity.startActivity(IntentWhats);

//substiua a próxima linha pela a anterior se quiser ter a opção de escolher com qual app compartilhar
//SharedActivity.startActivity (TJIntent.JavaClass.createChooser(IntentWhats,StrToJCharSequence(‘Compartilhar com?’)));
end;
*)
