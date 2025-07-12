unit lib.util;

interface

uses
  System.classes,
  System.NetEncoding,
  Rtti,
  math,
  System.IOUtils,
  System.JSON,
  System.SysUtils;

type
  Tutil = class(TObject)
  public
    class function getcookvalue(name, cookies: string): string;
    class function Valdate(Value: string): Tdatetime;
    class function valint(Value: string): Integer;
    class function Valfloat(Value: string): double;

    class function getKindType(Value: string): Integer;
    class function formatvalue(Value: double): string;
    class function HaversineDistance(const lat1, lon1, lat2,
      lon2: double): double;

    class procedure jsonToClass(oclass, oclassinfo: pointer;
      Value: TJSONObject);

    class procedure gravalog(mensagem: string);
    class function classToJson(oclass, oclassinfo: pointer): TJSONObject;
    class procedure finalizeArray(var Value: TObject);
    class function decodebase64(Value: string): string;
    class function encodebase64(Value: string): string;
    class procedure clearCache();
    class procedure remove(dir: string);
    class procedure getFilesRecursive(const lista: TStringList;
      filtro, diretorio: string);
    class procedure getFiles(const lista: TStringList; filtro: string;
      dirtrabalho: string);
  end;

implementation

{ Tutil }
class procedure Tutil.remove(dir: string);
var
  Rec: TSearchRec;
  sDir: string;
begin
  sDir := IncludeTrailingPathDelimiter(dir);
  if FindFirst(sDir + '*.*', faAnyFile, Rec) = 0 then
    try
      repeat
        if (Rec.Attr and faDirectory) = faDirectory then
        begin
          if (Rec.name <> '.') and (Rec.name <> '..') then
            Tutil.remove(sDir + Rec.name);
        end
        else
        begin
          DeleteFile(sDir + Rec.name);
        end;
      until FindNext(Rec) <> 0;
    finally
      FindClose(Rec);
    end;
  RemoveDir(sDir);
end;

class procedure Tutil.clearCache();

var

  sDir: String;
begin
   exit;
  sDir := ExtractFilePath(GetModuleName(HInstance)) +
    'app.exe.WebView2\';
  Tutil.remove(sDir);

  sDir := ExtractFilePath(GetModuleName(HInstance)) + 'DataBrowser';
  Tutil.remove(sDir)
end;

{ ------------------------------------------------------------------------------ }
class function Tutil.Valdate(Value: string): Tdatetime;
var
  idate: Tdatetime;
  lst: TStringList;
  day: word;
  year: word;
  month: word;
  minut: word;
  second: word;
  hour: word;
  stime: string;
begin
  day := 0;
  year := 0;
  month := 0;
  minut := 0;
  second := 0;
  hour := 0;
  Result := 0;
  lst := TStringList.Create;

  try
    if TryStrToDateTime(Value, idate) then
      Result := idate
    else
    begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
      if pos('-', Value) > 0 then
      begin

        lst.StrictDelimiter := true;
        lst.Delimiter := '-';
        lst.DelimitedText := Value;
        year := StrToInt(lst[0]);
        month := StrToInt(copy(lst[1], 0, 2));
        day := StrToInt(copy(lst[2], 0, 2));
        Result := EncodeDate(year, month, day)
      end;

      if pos(':', Value) > 0 then
      begin
        lst.StrictDelimiter := true;
        lst.Delimiter := ' ';
        lst.DelimitedText := Value;
        stime := lst[1];
        if stime <> '' then
        begin
          lst.StrictDelimiter := true;
          lst.Delimiter := ':';
          lst.DelimitedText := stime;
          if lst.Count > 0 then

            hour := StrToInt(lst[0]);
          if lst.Count > 1 then
            minut := StrToInt(lst[1]);
          if lst.Count > 2 then
            second := StrToInt(copy(lst[2], 0, 2));
          Result := Result + EncodeTime(hour, minut, second, 0);
        end;
      end;
{$ELSE}
      if pos('-', Value) > 0 then
      begin

        lst.StrictDelimiter := true;
        lst.Delimiter := '-';
        lst.DelimitedText := Value;
        year := StrToInt(lst[0]);
        month := StrToInt(copy(lst[1], 0, 2));
        day := StrToInt(copy(lst[2], 0, 2));
        Result := EncodeDate(year, month, day)
      end;

      if pos(':', Value) > 0 then
      begin
        lst.StrictDelimiter := true;
        lst.Delimiter := ' ';
        lst.DelimitedText := Value;
        stime := lst[1];
        if stime <> '' then
        begin
          lst.StrictDelimiter := true;
          lst.Delimiter := ':';
          lst.DelimitedText := stime;
          if lst.Count > 0 then
            hour := StrToInt(lst[0]);
          if lst.Count > 1 then
            minut := StrToInt(lst[1]);
          if lst.Count > 2 then
            second := StrToInt(copy(lst[2], 0, 2));
          Result := Result + EncodeTime(hour, minut, second, 0);
        end;
      end;
{$ENDIF}
    end;
  finally
    FreeAndNil(lst);
  end;
end;

class function Tutil.decodebase64(Value: string): string;
var
  instream: TstringStream;
  decodedstrean: TstringStream;
begin
  Result := '';
  try
    if Value <> '' then
    begin
      instream := TstringStream.Create(Value);
      decodedstrean := TstringStream.Create('');
      try
        instream.Position := 0;
        TNetEncoding.Base64.Decode(instream, decodedstrean);
        Result := decodedstrean.DataString;
      finally
        FreeAndNil(instream);
        FreeAndNil(decodedstrean);
      end;
    end;
  except
  end;
end;

class function Tutil.encodebase64(Value: string): string;
var
  encodedstream: TstringStream;
  instream: TstringStream;
begin
  Result := '';
  try
    if Value <> '' then
    begin
      try
        encodedstream := TstringStream.Create('');
        instream := TstringStream.Create(Value);
        TNetEncoding.Base64.Encode(instream, encodedstream);
        Result := encodedstream.DataString
      finally
        FreeAndNil(encodedstream);
        FreeAndNil(instream);
      end;
    end;
  except

  end;
end;

class procedure Tutil.finalizeArray(var Value: TObject);
begin
  // **//
end;

class function Tutil.formatvalue(Value: double): string;
begin
  Result := StringReplace(FloatToStr(Value), ',', '.', [rfReplaceAll]);

end;

{ ------------------------------------------------------------------------------ }
class function Tutil.Valfloat(Value: string): double;
var
  vfloat: double;
  svalue: string;
  fs: TFormatSettings;
begin
  Result := 0;
  if Value <> '' then
  begin
    svalue := Value;
    if not TryStrToFloat(Value, vfloat) then
    begin
      try
        FillChar(fs, SizeOf(fs), 0);
        fs.ThousandSeparator := ',';
        fs.DecimalSeparator := '.';
        Result := strtofloat(Value, fs);

      except
        Value := StringReplace(Value, '.', ',', [rfReplaceAll]);
        if TryStrToFloat(Value, vfloat) then
          Result := vfloat
        else
          raise exception.Create('Valor ' + Value +
            ' Nao pode ser covertido para float');
      end;
    end
    else
      Result := vfloat;
  end;
end;

{ ------------------------------------------------------------------------------ }
class function Tutil.valint(Value: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  if Value <> '' then
  begin
    if TryStrToInt(Value, i) then
      Result := i;
  end;
end;

{ ------------------------------------------------------------------------------ }
class function Tutil.getcookvalue(name, cookies: string): string;
var
  tmplist: TStringList;
  itx: Integer;
begin
  Result := '';
  if pos(name, cookies) > 0 then
  begin
    try
      tmplist := TStringList.Create;
      tmplist.Delimiter := ';';
      tmplist.StrictDelimiter := true;
      tmplist.DelimitedText := cookies;
      for itx := 0 to tmplist.Count - 1 do
      begin
        if pos(name, tmplist[itx]) > 0 then
        begin
          Result := tmplist[itx];
          break;
        end;
      end;

      if pos('=', Result) > 0 then
        Result := copy(Result, pos('=', Result), length(Result));

    finally
      FreeAndNil(tmplist);
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }
class function Tutil.HaversineDistance(const lat1, lon1, lat2,
  lon2: double): double;
const
  rads = pi / 180;
  dia = 2 * 6372.8;
begin
  HaversineDistance := dia *
    arcsin(sqrt(sqr(cos(rads * (lon1 - lon2)) * cos(rads * lat1) -
    cos(rads * lat2)) + sqr(sin(rads * (lon1 - lon2)) * cos(rads * lat1)) +
    sqr(sin(rads * lat1) - sin(rads * lat2))) / 2);
  // HaversineDistance(-16.6505676275119, -49.18277814053, -16.651267, -49.182714);
end;

{ ------------------------------------------------------------------------------ }
class function Tutil.getKindType(Value: string): Integer;
begin
  try
    Result := 0;
    if Value = 'TDateTime' then
      Result := 1
    else if Value = 'Integer' then
      Result := 2
    else if Value = 'Double' then
      Result := 3
    else if LowerCase(Value) = 'string' then
      Result := 4
  except
  end;
end;

{ ---------------------------------------------------------------------------- }
class procedure Tutil.jsonToClass(oclass, oclassinfo: pointer;
  Value: TJSONObject);
var
  ctx: TRttiContext;
  objType: TRttiType;
  Prop: TRttiProperty;
  i: Integer;
  oname: string;
  ovalue: string;
  otkind: Integer;
begin
  try
    ctx := TRttiContext.Create;
    objType := ctx.GetType(oclassinfo);
    for Prop in objType.GetProperties do
    begin
      oname := Prop.name;
      if assigned(Value.FindValue(oname)) then
      begin
        otkind := Tutil.getKindType(Prop.PropertyType.ToString);
        ovalue := Value.FindValue(oname).Value;
        case otkind of
          1:
            Prop.SetValue(oclass, TValue.From(Tutil.Valdate(ovalue)));
          2:
            Prop.SetValue(oclass, TValue.From(Tutil.valint(ovalue)));
          3:
            Prop.SetValue(oclass, TValue.From(Tutil.Valfloat(ovalue)));
          4:
            Prop.SetValue(oclass, TValue.From(ovalue));
        end;
      end;
    end;
  except
  end;
end;

{ ---------------------------------------------------------------------------- }
class function Tutil.classToJson(oclass, oclassinfo: pointer): TJSONObject;
var
  ctx: TRttiContext;
  objType: TRttiType;
  o: TObject;
  Prop: TRttiProperty;
  oname: string;
  ovalue: string;
  otkind: Integer;
  avalues: TJSONArray;
  invalidkind: Boolean;
begin
  try
    ctx := TRttiContext.Create;
    objType := ctx.GetType(oclassinfo);
    Result := TJSONObject.Create;
    for Prop in objType.GetProperties do
    begin
      if (UpperCase(Prop.name) <> UpperCase('RefCount')) and
        (UpperCase(Prop.name) <> UpperCase('Disposed')) then
      begin
        oname := Prop.name;
        invalidkind := false;
        otkind := Tutil.getKindType(Prop.PropertyType.ToString);
        case otkind of
          1:
            ovalue := FormatDateTime('YYYY-MM-DD hh:mm:ss',
              (Prop.GetValue(oclass).AsType<Tdatetime>));
          2:
            ovalue := IntToStr((Prop.GetValue(oclass).AsInteger));
          3:
            ovalue := FloatToJson(Prop.GetValue(oclass).AsType<double>);
          4:
            ovalue := (Prop.GetValue(oclass).AsString);
        else
          invalidkind := true;
        end;

        if not invalidkind then
          Result.AddPair(TJSONPair.Create(oname, ovalue));
      end;
    end;
  except
  end;
end;

{ ------------------------------------------------------------------------------ }
class procedure Tutil.gravalog(mensagem: string);
var
  strSaida: string;
  procedure registrarLogEmArquivo;
  var
    p: string;
    F: TextFile;
  begin
    try
      try
        p := ExtractFilePath(GetModuleName(HInstance)) + 'wkbot_' +
          FormatDateTime('ddmmyy', date) + '.log';
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
    strSaida := FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + mensagem;
    registrarLogEmArquivo;
  except
  end;
end;

class procedure Tutil.getFiles(const lista: TStringList; filtro: string;
  dirtrabalho: string);
var
  FileName: string;
  SearchRec: TSearchRec;
begin

  lista.Clear;
  SetCurrentDir(dirtrabalho);
  if FindFirst(filtro, faAnyFile, SearchRec) = 0 then
    repeat
      FileName := dirtrabalho + SearchRec.name;
      lista.Add(FileName);
    until FindNext(SearchRec) <> 0;
  FindClose(SearchRec);
end;

class procedure Tutil.getFilesRecursive(const lista: TStringList;
  filtro, diretorio: string);

var
  S: string;
begin

  for S in TDirectory.getFiles(diretorio, filtro,
    TSearchOption.soAllDirectories) do
    lista.Add(S);

end;

end.
