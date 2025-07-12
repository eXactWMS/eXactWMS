unit Server.Util;
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$HINTS OFF}
{$DEFINE APPTYPECONSOLE}

interface

uses
  System.Classes,
  System.Rtti,
  System.SysUtils,
  System.ZLib,
  System.JSON,
  db,
  Server.Message,
  Server.MessageList,
  System.Generics.Collections,
  Server.Attributes,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Web.HTTPApp,
  System.DateUtils;

type
  TWKUtil = class
    class function GetRttiType(Obj: TObject): TRttiType;
    class function GetResourName(Obj: TObject): String;
    class function GetTableName(Obj: TObject): String;
    class function GetResourceByName(AClassName: string): TObject;
    class function parseDate(value: string): TDate;
    class procedure SaveSql(qry: TFDQuery; Name: string = '');
    class function parseDateTime(value: string): TDateTime;
    class function parseFloat(pText: string): double;
    class procedure gravalog(mensagem: string);
    class procedure compactarResponse(AResponseInfo: TWebResponse);
    class function PascalCase(value: string): string;
    class function StripUnwantedChar(Text: string): string;
    class procedure SetObjectProperty(FieldName, value: String; Obj: TObject);
    class function GetRttiField(Name: String; Obj: TObject): TRttiField;
    class function GetFieldAlias(value: string;obj:tobject): string;
  end;

implementation

class procedure TWKUtil.SetObjectProperty(FieldName, value: String;
  Obj: TObject);
var
  RttiProperty: TRttiProperty;
  RttiValue: TValue;
  RttiType: TRttiType;
  RttiContext: TRttiContext;
  Llog: string;
begin
  try
    RttiContext := TRttiContext.Create;
    if not Assigned(Obj) then
      exit;

    RttiType := RttiContext.GetType(Obj.ClassInfo);

    RttiProperty := RttiType.GetProperty(FieldName);
    if RttiProperty <> nil then
    begin
      if FieldName = 'funcaonome' then
        Llog := '';

      if RttiProperty.PropertyType.TypeKind in [tkInteger] then
      begin
        if value <> EmptyStr then
        begin

          RttiValue := value.ToInteger;
        end;
      end
      else if RttiProperty.PropertyType.TypeKind
        in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar,
        tkWideString, tkChar] then
        RttiValue := value
      else if RttiProperty.PropertyType.TypeKind in [tkEnumeration] then
        RttiValue := value.ToBoolean
      else if RttiProperty.PropertyType.TypeKind in [tkFloat] then
      begin
        if (RttiProperty.PropertyType.Name = 'TDateTime') then
          RttiValue := TWKUtil.parseDateTime(value)
        else if (RttiProperty.PropertyType.Name = 'TDate') then
          RttiValue := TWKUtil.parseDate(value)
        else if (RttiProperty.PropertyType.Name = 'TTime') then
          RttiValue := TWKUtil.parseDateTime(value)
        else
          RttiValue := TWKUtil.parseFloat(value);

      end
      else if (RttiProperty.PropertyType.Name = 'TMacAddress') then
        RttiValue := TMacAddress.Create(value)
      else if (RttiProperty.PropertyType.Name = 'TBytea') then
        RttiValue := TBytea.Create(value);
      RttiProperty.SetValue(Obj, RttiValue);
    end;
  except
    on e: Exception do
    begin
      Llog := 'falha ' + FieldName + ' -  ' + value;
    end;
  end;
end;

class function TWKUtil.GetRttiType(Obj: TObject): TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  Result := RttiContext.GetType(Obj.ClassInfo);

end;

class function TWKUtil.GetTableName(Obj: TObject): String;
var
  RttiType: TRttiType;
  RttiAttribute: TCustomAttribute;
begin
  Result := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiAttribute in RttiType.GetAttributes do
    if RttiAttribute is Table then
      Result := (RttiAttribute as Table).TableName;
end;

class function TWKUtil.GetResourName(Obj: TObject): String;
var
  RttiType: TRttiType;
  RttiAttribute: TCustomAttribute;
begin
  Result := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiAttribute in RttiType.GetAttributes do
    if RttiAttribute is Resource then
      Result := (RttiAttribute as Resource).ResourceName;
end;

class function TWKUtil.GetResourceByName(AClassName: string): TObject;
var
  RttiContext: TRttiContext;
  RttiInstanceType: TRttiInstanceType;
  RttiMethod: TRttiMethod;
  Instance: TObject;
begin
  Result := Nil;
  RttiContext := TRttiContext.Create;

  try
    try
      RttiInstanceType := RttiContext.FindType(AClassName).AsInstance;
      RttiMethod := RttiInstanceType.GetMethod('Create');
      Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType, [])
        .AsObject;
      if not Assigned(Instance) then
        raise Exception.Create('Resource mapeado não encontrado -> ' +
          AClassName);
      Result := Instance;
    except
      on e: Exception do
        raise Exception.Create('Nome do resource invalido :' + AClassName);
    end;
  finally
    RttiContext.Free;
  end;
end;

class function TWKUtil.StripUnwantedChar(Text: string): string;
var
  Allowed: Set of Char;
  i, LeftOvers: Integer;
begin
  Allowed := [' ', '0' .. '9', 'a' .. 'z', 'A' .. 'Z', '~' .. ')', '-', '.',
    '\', ':', '`', '/', '<', ',', '>', ';', '{', '}'];

  SetLength(Result, Length(Text));
  LeftOvers := 1;
  for i := 1 to Length(Text) do
  begin
    if Text[i] in Allowed then
    begin
      Result[LeftOvers] := Text[i];
      Inc(LeftOvers);
    end
  end;
  SetLength(Result, LeftOvers - 1);
end;

class function TWKUtil.PascalCase(value: string): string;
var
  _lst: TstringList;
  _subIndex: Integer;
  _subLine: string;
begin
  _lst := TstringList.Create;
  try
    Result := '';
    _lst.Delimiter := '_';

    _lst.StrictDelimiter := True;
    _lst.DelimitedText := value;
    for _subIndex := 0 to _lst.Count - 1 do
    begin
      _subLine := _lst[_subIndex];
      _subLine := trim(_subLine);
      Result := Result + AnsiUpperCase(_subLine[1]) +
        AnsiLowerCase(Copy(_subLine, 2, Length(_subLine)))
    end;
  finally
    FreeAndNil(_lst);
  end;
end;

class procedure TWKUtil.compactarResponse(AResponseInfo: TWebResponse);
var
  aRequestStream: TStringStream;
  aRequestContent, aResponseContent: string;
  i: Integer;
  outstrem: TFileStream;
  os: string;
  srcbuf, destbuf: TBytes;
  str: string;

begin
  try
    if Length(AResponseInfo.Content) < 6000 then
      exit;
    str := AResponseInfo.Content;
    srcbuf := BytesOf(str);
    ZCompress(srcbuf, destbuf, zcMax);
{$IFDEF LINUX}
    Writeln('     --> Response compactação ' +
      inttostr(Length(AResponseInfo.Content)));
{$ENDIF}
    AResponseInfo.Content := '';
    AResponseInfo.ContentStream := TMemoryStream.Create;
    AResponseInfo.ContentEncoding := 'deflate';
    AResponseInfo.ContentStream.WriteData(@(destbuf[0]), Length(destbuf));
    AResponseInfo.ContentLength := (Length(destbuf));
    AResponseInfo.ContentStream.Position := 0;
  except
    on e: Exception do
    begin
{$IFDEF LINUX}
      str := 'Falha na compactação de dados ' + e.Message;
      Writeln('     --> Response ' + str);
{$ENDIF}
    end;
  end;
end;

class procedure TWKUtil.SaveSql(qry: TFDQuery; Name: string = '');
var
  FileNane: string;
  TmpSql: TstringList;
  apath: string;
  function parseParans(Sql: string): string;
  var
    i: Integer;
    lValue: string;
  begin
    Result := Sql;
    for i := 0 to qry.Params.Count - 1 do
    begin
      lValue := qry.Params[i].AsString;
      case qry.Params[i].DataType of
        ftString:
          lValue := QuotedStr(qry.Params[i].AsString);
        ftDate:
          lValue := QuotedStr(FormatDateTime('YYY-MM-DD',
            qry.Params[i].AsDate));

        ftDateTime:
          lValue := QuotedStr(FormatDateTime('YYY-MM-DD hh:nn:ss',
            qry.Params[i].AsDateTime));

        ftTime:
          lValue := QuotedStr(FormatDateTime('hh:nn:ss', qry.Params[i].AsTime));
      end;
      Result := StringReplace(Result, ':' + qry.Params[i].Name,
        lValue + ' -- ' + qry.Params[i].Name + #13#10, [rfIgnoreCase]);
    end;
  end;

begin
  try
    apath := ExtractFilePath(GetModuleName(HInstance)) + 'sqlExecutados';
    ForceDirectories(apath);
    apath := apath + PathDelim + FormatDateTime('ddmmyyy', date);
    ForceDirectories(apath);
    FileNane := apath + PathDelim + name + '_' + FormatDateTime('hh-nn-ss', now)
      + '_SqlSave.txt';
    qry.Sql.SaveToFile(FileNane);
    TmpSql := TstringList.Create;
    try
      TmpSql.Text := parseParans(qry.Sql.Text);
      TmpSql.SaveToFile(FileNane);
    finally
      TmpSql.Free;
    end;
  except
  end;
end;

class function TWKUtil.parseFloat(pText: string): double;
var
  Lresult: double;
begin
  Result := 0;
  Lresult := 0;
  if pText = '' then
    exit;
  if not TryStrToFloat(pText, Lresult) then
    TryStrToFloat(StringReplace(pText, '.', FormatSettings.DecimalSeparator,
      [rfIgnoreCase, rfReplaceAll]), Lresult);
  Result := Lresult;
end;

class function TWKUtil.parseDate(value: string): TDate;
var
  idate: TDateTime;
  lst: TstringList;
  day: word;
  year: word;
  month: word;
begin
  Result := 0;
  day := 0;
  year := 0;
  month := 0;
  Result := 0;
  lst := TstringList.Create;
  try
    if TryStrToDate(value, idate) then
      Result := idate
    else
    begin
      if Pos('-', value) > 0 then
      begin
        lst.Delimiter := '-';
        lst.DelimitedText := value;
        year := StrToInt(lst[0]);
        month := StrToInt(Copy(lst[1], 0, 2));
        day := StrToInt(Copy(lst[2], 0, 2));
        Result := EncodeDate(year, month, day)
      end;
    end;
  finally
    FreeAndNil(lst);
  end;
end;

class function TWKUtil.parseDateTime(value: string): TDateTime;
var
  idate: TDateTime;
  lst: TstringList;
  day: word;
  year: word;
  month: word;
  minut: word;
  second: word;
  hour: word;
  stime: string;
begin
  Result := 0;
  day := 0;
  year := 0;
  month := 0;
  minut := 0;
  second := 0;
  hour := 0;
  Result := 0;
  lst := TstringList.Create;
  try
    if TryStrToDateTime(value, idate) then
      Result := idate
    else
    begin
      if Pos('-', value) > 0 then
      begin

        lst.Delimiter := '-';
        lst.DelimitedText := value;
        year := StrToInt(lst[0]);
        month := StrToInt(Copy(lst[1], 0, 2));
        day := StrToInt(Copy(lst[2], 0, 2));
        Result := EncodeDate(year, month, day)
      end;

      if Pos(':', value) > 0 then
      begin

        lst.Delimiter := ' ';
        lst.DelimitedText := value;
        stime := lst[1];
        if stime <> '' then
        begin

          lst.Delimiter := ':';
          lst.DelimitedText := stime;
          if lst.Count > 1 then

            hour := StrToInt(lst[0]);
          if lst.Count > 2 then
            minut := StrToInt(lst[1]);
          if lst.Count > 3 then
            second := StrToInt(Copy(lst[2], 0, 2));
          Result := Result + EncodeTime(hour, minut, second, 0);
        end;
      end;

    end;
  finally
    FreeAndNil(lst);
  end;
end;

class procedure TWKUtil.gravalog(mensagem: string);
var
  strSaida: string;
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
    strSaida := FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + mensagem;
{$IFDEF APPTYPECONSOLE }
    Writeln(strSaida);
{$ENDIF}
    registrarLogEmArquivo;
  except
  end;
end;

class function TWKUtil.GetRttiField(Name: String; Obj: TObject): TRttiField;
var
  RttiType: TRttiType;
begin
  RttiType := TWKUtil.GetRttiType(Obj);
  Result := RttiType.GetField(Name);
end;
class function TWKUtil.GetFieldAlias(value: string;obj:tobject): string;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  result := '';
  RttiType := GetRttiType(obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DbField then
      begin
        if RttiField.Name.ToLower = LowerCase(value) then
        begin
          if (RttiAttribute as DbField).TableSource <> '' then
            result := (RttiAttribute as DbField).TableSource + '.' +
              (RttiAttribute as DbField).FieldName
          else
            result := GetTableName(obj) + '.' + (RttiAttribute as DbField)
              .FieldName
        end;
      end;

end;

end.
