unit uFuncoes;

interface

uses
  DBClient, Types, IniFiles, strutils,
  FireDAC.Comp.Client, System.Json, IdHashMessageDigest,
  IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, System.Classes;

function Versao: string;
Function AddHoras(Hora1, Hora2: String): String;
Function AplicarMascara(pTexto, pMascara: string): string; overload;

function Criptografar(pTexto: string): string;
function CriptografarSimples(wStri: AnsiString): AnsiString;
function Encript(Encript: String): string;
function Decript(Decript: String): string;
function ValidarCPF(pCPF: string): boolean;
function ValidarCNPJ(pCNPJ: string): boolean;
function FormatarCPFCNPJ(pCPFCNPJ: string): string;
procedure Esperar(pSegundos: Integer);

procedure ExportarExcel(pDados: TFdMemTable = Nil;
  pFileName: String = 'Relatorio.Xls');
function NomeDoComputador: string;
procedure OrdenarGrid(pClientDataSet: TClientDataSet; pCampo: string);
procedure OrdenarMemTable(pMemTable: TFdMemTable; pCampo: string);
function RemoverCaracteres(pTexto: string): string;
function RemoverCaracteresEspeciais(pTexto: string): string;
function RemoverEspacos(pTexto: string): string;

procedure SelecionarRegistro(pDataSet: TClientDataSet; pCampo: string);
procedure SelecionarRegistroFdMem(pDataSet: TFdMemTable; pCampo: string);
procedure SomDeAlerta;
procedure SomDeErro;
procedure SoNumeros(pKey: Char);
Function GetStrNumber(const S: string): string;
function Moeda(pValor: string): string;
function TraduzirEndereco(pEndereco: string): string;
function ValidarData(pData, pNome: string): TDateTime; overload;

function NomeMes(i: word; tipo: Integer): string;
function NomeDia(i: word; tipo: Integer): string;
Function Right(Texto: AnsiString; Tamanho: Int64): AnsiString;
procedure ValidarParametroTexto(var pParametro: string);
Function Calculatempo(DataInicio, DataTermino: TDateTime): String;
Function Repl(vCaracter: String; Tamanho: Integer): String;
function SeThen(Avalue: boolean; Const ATrue: String; Const AFalse: String = '')
  : String; OverLoad; inline;
function CalcUnidHr(Unid: Integer; HrTrab: String): Integer;
Function DataInversa(vData: String): TDate;
Procedure Player(pFile: String = '');
function GetValueInjSon(jObj: TJSONObject; Value: String): string;
Function EnderecoMask(pEndereco: String = ''; pMask: String = '';
  pFormata: boolean = True): String;
Function UfNome(pSigla: String): String;
Function MD5Texto(const Texto: string): AnsiString;
Function GetIp(pTipo: String = 'I'): String; // E-xterno I-nterno

Function DownloadFTP: boolean;
Function DownloadGoogleDrive: boolean;
Function DateEUAtoBr(pDataEUA: String): String;
Function ValidarLote(pLote: String): boolean;
procedure gravalog(mensagem: string);
function ParseDataSegura(const DataStr: string): TDateTime;

implementation

uses
  SysUtils, Data.DB;

function AddHoras(Hora1, Hora2: String): String;
var
  hh, mm, ss: Integer;
  vHora, vMinuto, vSegundo: Integer;
begin
  hh := StrToInt(Copy(Hora1, 1, 2)) + StrToInt(Copy(Hora2, 1, 2));
  mm := StrToInt(Copy(Hora1, 4, 2)) + StrToInt(Copy(Hora2, 4, 2));
  ss := StrToInt(Copy(Hora1, 7, 2)) + StrToInt(Copy(Hora2, 7, 2));

  vSegundo := ss Mod 60;
  mm := mm + (ss Div 60);
  vMinuto := mm mod 60;
  vHora := hh + (mm div 60);
  Result := FormatFloat('00:', vHora) + FormatFloat('00', vMinuto) + ':' +
    FormatFloat('00', vSegundo);
end;

function CalcUnidHr(Unid: Integer; HrTrab: String): Integer;
var
  MyHora, MyMinuto, MySegundo: word;
  Hour: string;
begin
  if Pos('d', HrTrab) > 0 then
  Begin
    MyHora := StrToInt(Copy(HrTrab, 1, Pos('d', HrTrab) - 1)) * 24;
    Hour := Copy(HrTrab, Pos('d', HrTrab) + 2, Length(HrTrab) - Pos('d',
      HrTrab) + 1);
  End
  Else
  Begin
    Hour := HrTrab;
    MyHora := 0
  End;

  MyHora := MyHora + StrToInt(Copy(Hour, 1, Length(Hour) - 6)); // 160:32:04
  MyMinuto := StrToInt(Copy(Hour, Length(Hour) - 4, 2));
  MySegundo := StrToInt(RightStr(Hour, 2)); // Copy(Hour, Length(Hour)-7, 2));
  Result := Trunc(Unid / (((MyHora * 60 * 60) + (MyMinuto * 60) + MySegundo))
    * 60 * 60);
End;

function CriptografarSimples(wStri: AnsiString): AnsiString;
var
  Simbolos: array [0 .. 4] of AnsiString;
  x: Integer;
  // Procedure nao testada
  // Testar esta rotina de criptografia - http://delphisempre.blogspot.com.br/2011/03/criptografando-arquivos-com-letras-e.html
  procedure DificultaCrip(origem, destino: string; Chave: word);
  var
    origemMS, destinoMS: TMemoryStream;
    i: Integer;
    C: byte;
  begin
    origemMS := TMemoryStream.Create;
    destinoMS := TMemoryStream.Create;
    try
      origemMS.LoadFromFile(origem);
      origemMS.Position := 0;
      for i := 0 to origemMS.Size - 1 do
      begin
        origemMS.Read(C, 1);
        C := (C xor (ord(Chave shr (i + 2))));
        destinoMS.Write(C, 1);
      end;
      destinoMS.SaveToFile(destino);
    finally
      FreeAndNil(origemMS);
      FreeAndNil(destinoMS);
    end;
  end;

begin
  // Result := wStri; //Retirar estas 2 linha para criptografar
  // Exit;
  // http://www.devmedia.com.br/funcao-para-criptografar-e-descriptografar-uma-string/21834
  Simbolos[1] := 'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*():\.';
  Simbolos[2] := 'ÂÀ©Øû×ƒçêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Á|/'; // 41
  Simbolos[3] := 'abcdefghijlmnopqrstuvxzywk1234567890'; // 36
  Simbolos[4] := 'áâäàåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¦·¹³²Õµþîì¡«½'; // 36
  for x := 1 to Length(Trim(wStri)) do
  begin
    if Pos(Copy(wStri, x, 1), Simbolos[1]) > 0 then
      Result := Result + Copy(Simbolos[2], Pos(Copy(wStri, x, 1),
        Simbolos[1]), 1)
    else if Pos(Copy(wStri, x, 1), Simbolos[2]) > 0 then
      Result := Result + Copy(Simbolos[1], Pos(Copy(wStri, x, 1),
        Simbolos[2]), 1)

    else if Pos(Copy(wStri, x, 1), Simbolos[3]) > 0 then
      Result := Result + Copy(Simbolos[4], Pos(Copy(wStri, x, 1),
        Simbolos[3]), 1)

    else if Pos(Copy(wStri, x, 1), Simbolos[4]) > 0 then
      Result := Result + Copy(Simbolos[3], Pos(Copy(wStri, x, 1),
        Simbolos[4]), 1);
  end;
end;

function Encript(Encript: String): string;
var
  Cod: String;
  Codi_go: String;
  Qt_Expc: Integer;
  x: Integer;
  POrd: Integer;
  D: string;
begin
  Cod := Encript;
  Codi_go := '';
  Qt_Expc := Length(Encript);
  for x := Qt_Expc downto 1 do
    Codi_go := Codi_go + Copy(Cod, x, 1);
  Cod := '';
  for x := 1 TO Qt_Expc do
  begin
    D := Copy(Codi_go, x, 1);
    POrd := ord(D[1]);
    if x / 2 = INT(x / 2) then
      Cod := Cod + CHR(POrd + 1)
    else
      Cod := Cod + CHR(POrd - 1);
  end;
  Codi_go := Cod;
  Result := Codi_go;
end;

function Decript(Decript: String): string;
var
  Cod: String;
  Codi_go: String;
  Qt_Expc: Integer;
  x: Integer;
  POrd: Integer;
  D: string;
  Resto: Integer;
begin
  Cod := Decript;
  Codi_go := '';
  Qt_Expc := Length(Decript);
  Resto := Length(Decript) mod 2;
  for x := Qt_Expc downto 1 do
    Codi_go := Codi_go + Copy(Cod, x, 1);
  Cod := '';
  for x := 1 TO Qt_Expc do
  begin
    D := Copy(Codi_go, x, 1);
    POrd := ord(D[1]);
    if Resto > 0 then
    begin
      if not(x / 2 = INT(x / 2)) then
        Cod := Cod + CHR(POrd + 1)
      else
        Cod := Cod + CHR(POrd - 1);
    end
    else
    begin
      if x / 2 = INT(x / 2) then
        Cod := Cod + CHR(POrd + 1)
      else
        Cod := Cod + CHR(POrd - 1);
    end;
  end;
  Codi_go := Cod;
  Result := Codi_go;
end;

Function DataInversa(vData: String): TDate;
Begin
  Result:=now;
  try
    Result := StrToDate(Copy(vData, 9, 2) + '/' + Copy(vData, 6, 2) + '/' +
      Copy(vData, 1, 4));
  Except
  End;
End;

Function ValidarLote(pLote: String): boolean;
Begin
  Result := pLote = Trim(pLote);
End;

function GetValueInjSon(jObj: TJSONObject; Value: String): string;
var
  i: Integer;
  jPar: TJSONPair;
begin
  Result := '';
  for i := 0 to jObj.Size - 1 do
  begin
    jPar := jObj.Get(i);
    if jPar.JsonValue Is TJSONObject then
      Result := GetValueInjSon((jPar.JsonValue As TJSONObject), Value)
    else if sametext(Trim(jPar.JsonString.Value), Value) then
    begin
      Result := jPar.JsonValue.Value;
      break;
    end;
    if Result <> '' then
      break;
  end;
end;

Function Repl(vCaracter: String; Tamanho: Integer): String;
Var
  x: Integer;
Begin
  Result := '';
  for x := 1 to Tamanho do
    Result := Result + vCaracter;
End;

function SeThen(Avalue: boolean; Const ATrue: String; Const AFalse: String)
  : String; OverLoad; inline;
Begin
  if Avalue then
    Result := ATrue
  else
    Result := AFalse;
End;

function Versao: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  // VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: word;
  Prog: string;
begin

  Result := '1.' + '1.' + '1.1';
end;

function AplicarMascara(pTexto, pMascara: string): string;
var
  vlTexto: string;
  vlMascara: string;
  i, j: Integer;

  function Traduzir(pNumero: string): string;
  begin
    case StrToInt(pNumero) of
      1:
        Result := 'A';
      2:
        Result := 'B';
      3:
        Result := 'C';
      4:
        Result := 'D';
      5:
        Result := 'E';
      6:
        Result := 'F';
      7:
        Result := 'G';
      8:
        Result := 'H';
      9:
        Result := 'I';
      10:
        Result := 'J';
      11:
        Result := 'K';
      12:
        Result := 'L';
      13:
        Result := 'M';
      14:
        Result := 'N';
      15:
        Result := 'O';
      16:
        Result := 'P';
      17:
        Result := 'Q';
      18:
        Result := 'R';
      19:
        Result := 'S';
      20:
        Result := 'T';
      21:
        Result := 'U';
      22:
        Result := 'V';
      23:
        Result := 'W';
      24:
        Result := 'X';
      25:
        Result := 'Y';
      26:
        Result := 'Z';
      99:
        Result := '99';
    end;
  end;

begin

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
      vlNovoTexto := vlNovoTexto + CHR((ord(clChave[x]) xor ord(pTexto[y])));
    end;

    pTexto := vlNovoTexto;
  end;

  Result := pTexto;
end;

procedure Esperar(pSegundos: Integer);
var
  vlInicio: DWORD;
  vlFim: DWORD;
begin

end;

procedure ExportarExcel(pDados: TFdMemTable; pFileName: String);
begin
end;

procedure OrdenarMemTable(pMemTable: TFdMemTable; pCampo: string);
var
  vlCampos: string;
begin
  vlCampos := pMemTable.IndexFieldNames;
  pCampo := ' ' + pCampo + ' ';

  if (Trim(vlCampos) = '') then
  begin
    pMemTable.IndexFieldNames := pCampo;
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
      pMemTable.IndexFieldNames := vlCampos;
    end;
  end;
End;

procedure OrdenarGrid(pClientDataSet: TClientDataSet; pCampo: string);
var
  vlCampos: string;
begin
  vlCampos := pClientDataSet.IndexFieldNames;
  pCampo := ' ' + pCampo + ' ';

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

function NomeDoComputador: string;
begin
  Result := 'MICROSERVICE';
end;

function RemoverCaracteres(pTexto: string): string;
var
  i: Integer;
  tmp: string;
begin
  tmp := '';

  for i := 1 to Length(pTexto) do
  begin
    if (CharInSet(pTexto[i], ['0' .. '9'])) then
    begin
      tmp := tmp + Copy(pTexto, i, 1);
    end;
  end;

  Result := tmp;
end;

function RemoverCaracteresEspeciais(pTexto: string): string;
var
  i: Integer;
  tmp: string;
begin
  tmp := '';

  for i := 1 to Length(pTexto) do
  begin
    if (CharInSet(pTexto[i], ['0' .. '9'])) or
      (CharInSet(pTexto[i], ['a' .. 'z'])) or
      (CharInSet(pTexto[i], ['A' .. 'Z'])) then
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
      0:
        pDataSet.FieldByName(pCampo).AsInteger := 1;
      1:
        pDataSet.FieldByName(pCampo).AsInteger := 0;
    end;
    pDataSet.Post;
  end;
end;

procedure SelecionarRegistroFdMem(pDataSet: TFdMemTable; pCampo: string);
Begin
  if (pDataSet.IsEmpty = False) then
  begin
    pDataSet.Edit;
    case pDataSet.FieldByName(pCampo).AsInteger of
      0:
        pDataSet.FieldByName(pCampo).AsInteger := 1;
      1:
        pDataSet.FieldByName(pCampo).AsInteger := 0;
    end;
    pDataSet.Post;
  end;

End;

procedure SomDeAlerta;
var
  vlArquivo: string;
begin

end;

procedure SomDeErro;
var
  vlArquivo: string;
begin

end;

Function GetIp(pTipo: String = 'I'): String;
Var
  vIp: String;
  IdHTTP1: TIdHTTP;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;

  Temporario: String;
  Endereco: String;
  x: Integer;
Begin
  IdHTTP1 := TIdHTTP.Create(Nil);
  IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
  IdHTTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;

  try
    vIp := IdHTTP1.Get('http://www.meuip.com.br');
    vIp := Copy(vIp, Pos('<strong class="IP">', vIp) + 19, 12);
    Result := 'Seu IP é: ' + vIp;
    IdHTTP1.DisposeOf;
    IdSSLIOHandlerSocketOpenSSL1.DisposeOf;
  except
    Result := '';
    IdHTTP1.DisposeOf;
    IdSSLIOHandlerSocketOpenSSL1.DisposeOf;
  end;
End;

function GetStrNumber(const S: string): string;
var
  vText: PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
{$IFDEF UNICODE}
    if CharInSet(vText^, ['0' .. '9']) then
{$ELSE}
    if vText^ in ['0' .. '9'] then
{$ENDIF}
      Result := Result + vText^;
    Inc(vText);
  end;
end;

procedure SoNumeros(pKey: Char);
begin
  if not((CharInSet(pKey, ['0' .. '9'])) or (pKey = #8) or (pKey = #13) or
    (pKey = #27)) then
  begin
    Abort;
  end;
end;

function Moeda(pValor: string): string;
var
  vlValor: Double;
begin
  pValor := RemoverCaracteres(pValor);
  vlValor := (StrToInt64Def(pValor, 0) / 100);
  Result := CurrToStrF(vlValor, ffCurrency, 2);
end;

function TraduzirEndereco(pEndereco: string): string;
var
  vlLetra: Char;
begin
  Result := Trim(UpperCase(pEndereco));

  if (Result <> '') then
  begin
    Result := StringReplace(Result, '.', '', [rfReplaceAll]);
    vlLetra := Result[1];

    if (CharInSet(vlLetra, ['A' .. 'Z'])) then
    begin
      case vlLetra of
        'A':
          Result := StringReplace(Result, 'A', '01', [rfReplaceAll]);
        'B':
          Result := StringReplace(Result, 'B', '02', [rfReplaceAll]);
        'C':
          Result := StringReplace(Result, 'C', '03', [rfReplaceAll]);
        'D':
          Result := StringReplace(Result, 'D', '04', [rfReplaceAll]);
        'E':
          Result := StringReplace(Result, 'E', '05', [rfReplaceAll]);
        'F':
          Result := StringReplace(Result, 'F', '06', [rfReplaceAll]);
        'G':
          Result := StringReplace(Result, 'G', '07', [rfReplaceAll]);
        'H':
          Result := StringReplace(Result, 'H', '08', [rfReplaceAll]);
        'I':
          Result := StringReplace(Result, 'I', '09', [rfReplaceAll]);
        'J':
          Result := StringReplace(Result, 'J', '10', [rfReplaceAll]);
        'K':
          Result := StringReplace(Result, 'K', '11', [rfReplaceAll]);
        'L':
          Result := StringReplace(Result, 'L', '12', [rfReplaceAll]);
        'M':
          Result := StringReplace(Result, 'M', '13', [rfReplaceAll]);
        'N':
          Result := StringReplace(Result, 'N', '14', [rfReplaceAll]);
        'O':
          Result := StringReplace(Result, 'O', '15', [rfReplaceAll]);
        'P':
          Result := StringReplace(Result, 'P', '16', [rfReplaceAll]);
        'Q':
          Result := StringReplace(Result, 'Q', '17', [rfReplaceAll]);
        'R':
          Result := StringReplace(Result, 'R', '18', [rfReplaceAll]);
        'S':
          Result := StringReplace(Result, 'S', '19', [rfReplaceAll]);
        'T':
          Result := StringReplace(Result, 'T', '20', [rfReplaceAll]);
        'U':
          Result := StringReplace(Result, 'U', '21', [rfReplaceAll]);
        'V':
          Result := StringReplace(Result, 'V', '22', [rfReplaceAll]);
        'W':
          Result := StringReplace(Result, 'W', '23', [rfReplaceAll]);
        'X':
          Result := StringReplace(Result, 'X', '24', [rfReplaceAll]);
        'Y':
          Result := StringReplace(Result, 'Y', '25', [rfReplaceAll]);
        'Z':
          Result := StringReplace(Result, 'Z', '26', [rfReplaceAll]);
      end;
    end;
  end;
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

function NomeMes(i: word; tipo: Integer): string;
const
  mes: array [1 .. 12] of string = ('Janeiro', 'Fevereiro', 'Março', 'Abril',
    'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro',
    'Dezembro');
begin
  if (tipo = 0) then
    NomeMes := mes[i] // extenso
    // a função "copy" retorna os 3 primeiros caracteres de "mes[i]"
  else
    NomeMes := Copy(mes[i], 1, 3); // abreviado
end;

function NomeDia(i: word; tipo: Integer): string;
const
  Dia: array [1 .. 7] of string = ('Domingo', 'Segunda', 'Terça', 'Quarta',
    'Quinta', 'Sexta', 'Sábado');

begin
  if (tipo = 0) then
    NomeDia := Dia[i] // extenso
    // a função "copy" retorna os 3 primeiros caracteres de "mes[i]"
  else
    NomeDia := Copy(Dia[i], 1, 3); // abreviado
end;

Function Right(Texto: AnsiString; Tamanho: Int64): AnsiString;
Begin
  Result := Copy(Texto, Length(Texto) - Tamanho + 1, Tamanho);
End;

Function Calculatempo(DataInicio, DataTermino: TDateTime): String;
Var
  Dias: Integer;
  Total, Horas: Real;
  H, M, S, ss: word;
Begin
  if DataInicio > DataTermino then
    Total := DataInicio - DataTermino
  else
    Total := DataTermino - DataInicio;
  Dias := Trunc(Total);
  Horas := Total - Trunc(Total);
  Decodetime(Horas, H, M, S, ss);
  H := H + 24 * Trunc(Dias);
  Result := FormatFloat('#00', H) + ':' + FormatFloat('00', M) + ':' +
    FormatFloat('00', S);
End;

Procedure Player(pFile: String);
Begin

End;

function ValidarCPF(pCPF: string): boolean;
Var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: Integer;
  d1, d2: Integer;
  digitado, calculado: String;
begin
  n1 := StrToInt(pCPF[1]);
  n2 := StrToInt(pCPF[2]);
  n3 := StrToInt(pCPF[3]);
  n4 := StrToInt(pCPF[4]);
  n5 := StrToInt(pCPF[5]);
  n6 := StrToInt(pCPF[6]);
  n7 := StrToInt(pCPF[7]);
  n8 := StrToInt(pCPF[8]);
  n9 := StrToInt(pCPF[9]);
  d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9
    + n1 * 10;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1 := 0;
  d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 +
    n2 * 10 + n1 * 11;
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;
  calculado := IntToStr(d1) + IntToStr(d2);
  digitado := pCPF[10] + pCPF[11];
  if (calculado = digitado) then
    Result := True
  else
    Result := False;
end;

function ValidarCNPJ(pCNPJ: string): boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: Integer;
  d1, d2: Integer;
  digitado, calculado: string;
begin
  n1 := StrToInt(pCNPJ[1]);
  n2 := StrToInt(pCNPJ[2]);
  n3 := StrToInt(pCNPJ[3]);
  n4 := StrToInt(pCNPJ[4]);
  n5 := StrToInt(pCNPJ[5]);
  n6 := StrToInt(pCNPJ[6]);
  n7 := StrToInt(pCNPJ[7]);
  n8 := StrToInt(pCNPJ[8]);
  n9 := StrToInt(pCNPJ[9]);
  n10 := StrToInt(pCNPJ[10]);
  n11 := StrToInt(pCNPJ[11]);
  n12 := StrToInt(pCNPJ[12]);
  d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 * 9
    + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1 := 0;
  d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 * 9
    + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;
  calculado := IntToStr(d1) + IntToStr(d2);
  digitado := pCNPJ[13] + pCNPJ[14];
  if calculado = digitado then
    Result := True
  else
    Result := False;
end;

function FormatarCPFCNPJ(pCPFCNPJ: string): string;
var
  i, tmp: Integer;
begin
  pCPFCNPJ := RemoverCaracteres(pCPFCNPJ);
  tmp := Length(pCPFCNPJ);
  if (pCPFCNPJ = '') or (tmp < 11) then
    Result := '000.000.000-00'
  else
  begin
    if (tmp > 13) then
    begin
      if (ValidarCNPJ(pCPFCNPJ) = True) then
      begin
        Result := '';
        for i := 1 to Length(pCPFCNPJ) do
          Result := Result + pCPFCNPJ[i];
        Result := Copy(Result, 1, 2) + '.' + Copy(Result, 3, 3) + '.' +
          Copy(Result, 6, 3) + '/' + Copy(Result, 9, 4) + '-' +
          Copy(Result, 13, 2);
      end
      else
        raise Exception.Create('CNPJ Inválido!');
    end
    else
    begin
      if (ValidarCPF(pCPFCNPJ) = True) then
      begin
        Result := '';
        for i := 1 to Length(pCPFCNPJ) do
          Result := Result + pCPFCNPJ[i];
        Result := Copy(Result, 1, 3) + '.' + Copy(Result, 4, 3) + '.' +
          Copy(Result, 7, 3) + '-' + Copy(Result, 10, 2);
      end
      else
        raise Exception.Create('CPF Inválido!');
    end;
  end;
end;

Function DownloadFTP: boolean;
Begin
  { Uses
    WinInet;

    Var
    hInet, hFTP: HINTERNET;
    Filename, Host, User, Password: String;
    Buffer: Array[1..1024] of Byte;
    BufferLen: DWORD;
    FileHandle: THandle;
    BytesRead: Integer;

    Begin
    //Inicia o WinInet
    hInet := InternetOpen('FTP_Download', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

    //Faz a conexão com o servidor FTP
    Host := 'ftp.example.com';
    User := 'usuario';
    Password := 'senha';
    hFTP := InternetConnect(hInet, Host, INTERNET_DEFAULT_FTP_PORT, User, Password, INTERNET_SERVICE_FTP, 0, 0);

    //Faz o download do arquivo
    Filename := 'arquivo.txt';
    FileHandle := CreateFile(Filename, GENERIC_WRITE, 0
  }
End;

Function DownloadGoogleDrive: boolean;
const
  URL = 'https://docs.google.com/presentation/d/1lawtOIgn8Crgu78e_0saRs8o3wPSlYzOhvZcr8DQOJg/edit?usp=share_link';
  arquivoLocal = 'C:\App\FileCopied.Pdf';
begin
  // UrlDownloadToFile(nil, PChar(URL), PChar(arquivoLocal), 0, nil);
end;

Function EnderecoMask(pEndereco: String; pMask: String;
  pFormata: boolean): String;
Var
  vMaskClean, vEndereco: String;
  x, y, vMaskLen: Integer;
begin
  if pMask = '' then
  Begin
    Result := pEndereco;
    Exit;
  End;
  vMaskLen := 0;
  vMaskClean := StringReplace(StringReplace(pMask, '.', '', [rfReplaceAll]),
    '-', '', [rfReplaceAll]);
  if Length(pEndereco) <> Length(vMaskClean) then
  Begin
    Result := pEndereco;
    Exit;
  end;
  vEndereco := '';
  If Pos('A', vMaskClean) > 0 then
  Begin
    For x := 1 to Length(vMaskClean) do
    Begin
      if vMaskClean[x] in ['A' .. 'Z'] then
        vMaskLen := vMaskLen + 2
      Else
        vMaskLen := vMaskLen + 1;
    End;
  End
  Else
    vMaskLen := Length(vMaskClean);
  for x := 1 to Length(pEndereco) do
  Begin
    if pEndereco[x] in ['A' .. 'Z'] then
    Begin
      if (pMask <> '') and (Pos('A', vMaskClean) <= 0) then
      Begin
        Result := vEndereco;
        Exit;
      End;
      vEndereco := vEndereco + FormatFloat('00', ord(pEndereco[x]) - 64);
    End
    Else
      vEndereco := vEndereco + pEndereco[x];
  End;
  if pMask = '' then
  Begin
    Result := vEndereco;
    Exit;
  End;
  if Length(vEndereco) > vMaskLen then
  Begin
    Result := vEndereco;
    Exit;
  End
  Else if (Length(vEndereco) < vMaskLen) and (Pos('!', vMaskClean) > 0) then
  Begin
    x := 1;
    y := 1;
    repeat
      if vMaskClean[x] = '!' then
        vEndereco := Copy(vEndereco, 1, y - 1) + ' ' +
          Copy(vEndereco, y, Length(vEndereco) - y + 1)
      else If vMaskClean[x] = 'A' then // Forçar pular Duas posições
        Inc(y);
      Inc(x);
      Inc(y);
    until x >= vMaskLen;
  End;
  if Length(vEndereco) > vMaskLen then
  Begin
    Result := vEndereco;
    Exit;
  End;
  pMask := pMask + ';0;_';
  if pFormata then
    Result := AplicarMascara(vEndereco, pMask)
  Else
    Result := StringReplace(StringReplace(AplicarMascara(vEndereco, pMask), '.',
      '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
End;

Function UfNome(pSigla: String): String;
Begin
  If pSigla = 'AC' then
    Result := 'Acre'
  Else If pSigla = 'AM' then
    Result := 'Amazonas'
  Else If pSigla = 'AP' then
    Result := 'Amapá'
  Else If pSigla = 'BA' then
    Result := 'Bahia'
  Else If pSigla = 'CE' then
    Result := 'Ceará'
  Else If pSigla = 'DF' then
    Result := 'Distrito Federal'
  Else If pSigla = 'GO' then
    Result := 'Goiás'
  Else If pSigla = 'MA' then
    Result := 'Maranhão'
  Else If pSigla = 'MG' then
    Result := 'Minas Gerais'
  Else If pSigla = 'MT' then
    Result := 'Mato Grosso'
  Else If pSigla = 'MS' then
    Result := 'Mato Grosso do Sul'
  Else If pSigla = 'PA' then
    Result := 'Pará'
  Else If pSigla = 'PB' then
    Result := 'Paraiba'
  Else If pSigla = 'PI' then
    Result := 'Piauí'
  Else If pSigla = 'PR' then
    Result := 'Paraná'
  Else If pSigla = 'RJ' then
    Result := 'Rio de Janeiro'
  Else If pSigla = 'RS' then
    Result := 'Rio Grande do Sul'
  Else If pSigla = 'SC' then
    Result := 'Santa Catarina'
  Else If pSigla = 'SP' then
    Result := 'São Paulo'
  Else If pSigla = 'TO' then
    Result := 'Tocantins';
End;

Function MD5Texto(const Texto: string): AnsiString;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := idmd5.HashStringAsHex(Texto);
  finally
    idmd5.Free;
  end;
end;

Function DateEUAtoBr(pDataEUA: String): String;
Begin // 2023-09-21
  if Length(pDataEUA) = 10 then
  Begin
    Result := Copy(pDataEUA, 9, 2) + '/' + Copy(pDataEUA, 6, 2) + '/' +
      Copy(pDataEUA, 1, 4)
  End
  Else
  Begin
    Result := Copy(pDataEUA, 9, 2) + '/' + Copy(pDataEUA, 6, 2) + '/' +
      Copy(pDataEUA, 1, 2)
  End;
End;

{ ------------------------------------------------------------------------------- }
procedure gravalog(mensagem: string);
var
  strSaida: string;
  HWND: Cardinal;

  procedure registrarLogEmArquivo;

  var
    p: string;
    F: TextFile;
  begin
    try
      try
        p := ExtractFilePath(ParamStr(0)) + 'log\';
        ForceDirectories(p);
        p := p + FormatDateTime('yyyymmdd', now) + '_' +
          ChangeFileExt(ExtractFileName(ParamStr(0)), '') + '.log';
        AssignFile(F, p);
        if not FileExists(p) then
          Rewrite(F)
        else
          Append(F);
        Writeln(F, strSaida);
      except
      end;
    finally
      Closefile(F);
    end;
  end;

begin
  Try
    HWND := 0;
    strSaida := FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + mensagem;
    Writeln(strSaida);
    registrarLogEmArquivo;

  except
  end;
end;

{ ------------------------------------------------------------------------------ }
function ParseDataSegura(const DataStr: string): TDateTime;
var
  Ano, mes, Dia: word;
begin
  // ISO (2025-01-01)
  if (Length(DataStr) = 10) and (DataStr[5] = '-') then
  begin
    Ano := StrToIntDef(Copy(DataStr, 1, 4), 0);
    mes := StrToIntDef(Copy(DataStr, 6, 2), 0);
    Dia := StrToIntDef(Copy(DataStr, 9, 2), 0);
  end
  // Brasileiro (01/01/2025)
  else if (Length(DataStr) = 10) and (DataStr[3] = '/') then
  begin
    Dia := StrToIntDef(Copy(DataStr, 1, 2), 0);
    mes := StrToIntDef(Copy(DataStr, 4, 2), 0);
    Ano := StrToIntDef(Copy(DataStr, 7, 4), 0);
  end
  else
    raise Exception.CreateFmt('Formato de data inválido: "%s"', [DataStr]);

  // Valida e monta
  if not TryEncodeDate(Ano, mes, Dia, Result) then
    raise Exception.CreateFmt('Data inválida: "%s"', [DataStr]);
end;

end.
