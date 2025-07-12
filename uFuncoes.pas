unit uFuncoes;

interface

uses
        SysUtils, DBClient, Json, System.Diagnostics;

function RemoverCaracteres(pTexto: string): string;
function ValidarCPF(pCPF: string): boolean;
function ValidarCNPJ(pCNPJ: string): boolean;
function FormatarCPFCNPJ(pCPFCNPJ: string): string;
function Versao: string;
function Encript(Encript: String): string;
function Decript(Decript: String): string;
function NomeDoComputador: string;
Function NovaFuncaoGit: String;

procedure Ordenar(pClientDataSet: TClientDataSet; pCampo: string);
procedure SoNumeros(pKey: char);
function GetValueInjSon(jObj: TJSONObject; Value: String): string;
function GetCurrentTime: Int64; // Alterado para usar TStopwatch
Function CalculaTempoProcesso(pStarTime : Int64) : Double;

implementation

function GetCurrentTime: Int64;
begin
  // Usando TStopwatch para maior precisão e compatibilidade multiplataforma
  Result := TStopwatch.GetTimestamp div (TStopwatch.Frequency div 1000);
end;

Function CalculaTempoProcesso(pStarTime : Int64) : Double;
Begin
  Result := (GetCurrentTime - pStarTime)/1000;
End;

procedure SoNumeros(pKey: char);
begin
        if not(pKey in ['0' .. '9']) or (pKey = #8) then
        begin
                Abort;
        end;
end;

function GetValueInjSon(jObj: TJSONObject; Value: String): string;
var
        i: integer;
        jPar: TJSONPair;
begin
        result := '';
        for i := 0 to jObj.Size - 1 do
        begin
                jPar := jObj.Get(i);
                if jPar.JsonValue Is TJSONObject then
                        result := GetValueInjSon
                          ((jPar.JsonValue As TJSONObject), Value)
                else if sametext(trim(jPar.JsonString.Value), Value) then
                begin
                        result := jPar.JsonValue.Value;
                        break;
                end;
                if result <> '' then
                        break;
        end;
end;

function RemoverCaracteres(pTexto: string): string;
{ Remove todos os caracteres de uma palavra, deixando
  somente os números }
var
        i: integer;
        tmp: string;
begin
        tmp := '';

        for i := 1 to length(pTexto) do
        begin
                if (pTexto[i] in ['0' .. '9']) then
                begin
                        tmp := tmp + Copy(pTexto, i, 1);
                end;
        end;

        result := tmp;
end;

function ValidarCPF(pCPF: string): boolean;
Var
        n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
        d1, d2: integer;
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
        d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2
          * 9 + n1 * 10;
        d1 := 11 - (d1 mod 11);
        if d1 >= 10 then
                d1 := 0;
        d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3
          * 9 + n2 * 10 + n1 * 11;
        d2 := 11 - (d2 mod 11);
        if d2 >= 10 then
                d2 := 0;
        calculado := IntToStr(d1) + IntToStr(d2);
        digitado := pCPF[10] + pCPF[11];
        if (calculado = digitado) then
                result := True
        else
                result := False;
end;

function ValidarCNPJ(pCNPJ: string): boolean;
var
        n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: integer;
        d1, d2: integer;
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
        d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 +
          n5 * 9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
        d1 := 11 - (d1 mod 11);
        if d1 >= 10 then
                d1 := 0;
        d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 +
          n6 * 9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
        d2 := 11 - (d2 mod 11);
        if d2 >= 10 then
                d2 := 0;
        calculado := IntToStr(d1) + IntToStr(d2);
        digitado := pCNPJ[13] + pCNPJ[14];
        if calculado = digitado then
                result := True
        else
                result := False;
end;

function FormatarCPFCNPJ(pCPFCNPJ: string): string;
var
        i, tmp: integer;
begin
        pCPFCNPJ := RemoverCaracteres(pCPFCNPJ);
        tmp := length(pCPFCNPJ);
        if (pCPFCNPJ = '') or (tmp < 11) then
                result := '000.000.000-00'
        else
        begin
                if (tmp > 13) then
                begin
                        if (ValidarCNPJ(pCPFCNPJ) = True) then
                        begin
                                result := '';
                                for i := 1 to length(pCPFCNPJ) do
                                        result := result + pCPFCNPJ[i];
                                result := Copy(result, 1, 2) + '.' +
                                  Copy(result, 3, 3) + '.' + Copy(result, 6, 3)
                                  + '/' + Copy(result, 9, 4) + '-' +
                                  Copy(result, 13, 2);
                        end
                        else
                                raise Exception.Create('CNPJ Inválido!');
                end
                else
                begin
                        if (ValidarCPF(pCPFCNPJ) = True) then
                        begin
                                result := '';
                                for i := 1 to length(pCPFCNPJ) do
                                        result := result + pCPFCNPJ[i];
                                result := Copy(result, 1, 3) + '.' +
                                  Copy(result, 4, 3) + '.' + Copy(result, 7, 3)
                                  + '-' + Copy(result, 10, 2);
                        end
                        else
                                raise Exception.Create('CPF Inválido!');
                end;
        end;
end;

function Versao: string;
begin
end;

function Encript(Encript: String): string;
var
        Cod: String;
        Codi_go: String;
        Qt_Expc: integer;
        X: integer;
        POrd: integer;
        D: string;
begin
        Cod := Encript;
        Codi_go := '';
        Qt_Expc := length(Encript);
        for X := Qt_Expc downto 1 do
                Codi_go := Codi_go + Copy(Cod, X, 1);
        Cod := '';
        for X := 1 TO Qt_Expc do
        begin
                D := Copy(Codi_go, X, 1);
                POrd := Ord(D[1]);
                if X / 2 = INT(X / 2) then
                        Cod := Cod + CHR(POrd + 1)
                else
                        Cod := Cod + CHR(POrd - 1);
        end;
        Codi_go := Cod;
        result := Codi_go;
end;

function Decript(Decript: String): string;
var
        Cod: String;
        Codi_go: String;
        Qt_Expc: integer;
        X: integer;
        POrd: integer;
        D: string;
        Resto: integer;
begin
        Cod := Decript;
        Codi_go := '';
        Qt_Expc := length(Decript);
        Resto := length(Decript) mod 2;
        for X := Qt_Expc downto 1 do
                Codi_go := Codi_go + Copy(Cod, X, 1);
        Cod := '';
        for X := 1 TO Qt_Expc do
        begin
                D := Copy(Codi_go, X, 1);
                POrd := Ord(D[1]);
                if Resto > 0 then
                begin
                        if not(X / 2 = INT(X / 2)) then
                                Cod := Cod + CHR(POrd + 1)
                        else
                                Cod := Cod + CHR(POrd - 1);
                end
                else
                begin
                        if X / 2 = INT(X / 2) then
                                Cod := Cod + CHR(POrd + 1)
                        else
                                Cod := Cod + CHR(POrd - 1);
                end;
        end;
        Codi_go := Cod;
        result := Codi_go;
end;

function NomeDoComputador: string;
begin
end;

procedure Ordenar(pClientDataSet: TClientDataSet; pCampo: string);
var
        tmp, campos: string;
begin
        campos := pClientDataSet.IndexFieldNames;

        if (trim(campos) = '') then
        begin
                pClientDataSet.IndexFieldNames := pCampo;
        end
        else
        begin
                tmp := pCampo;

                if (campos <> tmp) then
                begin
                        if (Pos(tmp, campos) = 1) then
                        begin
                                campos := StringReplace(campos,
                                  tmp + '; ', '', [])
                        end
                        else
                        begin
                                campos := StringReplace(campos,
                                  '; ' + tmp, '', []);
                        end;

                        campos := tmp + '; ' + campos;
                        pClientDataSet.IndexFieldNames := campos;
                end;
        end;
end;

Function NovaFuncaoGit: String;
Begin
        result := '';
End;

end.
