unit service.resource.generator;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  lib.Config,
  Data.DB,
  json,

  lib.Connection,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TonGerarResource = procedure(Sender: TObject; mensagem: string) of object;
  Tonlog = procedure(Sender: TObject; mensagem: string) of object;

type
  TResourceGenerator = class(TThread)
  private
    FonGerarResource: TonGerarResource;
    Fdiretorio: string;
    FonLog: Tonlog;
    Faliases: string;
    Ftabelas: TstringList;
    sFileName: string;
    lstTblOutput: TstringList;
    lst: TstringList;
    lFieldsDef: TstringList;
    lTemplate: TstringList;
    lTables: TstringList;
    sContraints: string;
    sSize: string;
    sName: string;
    sFieldType: string;
    sDescription: string;
    sResouceName: string;
    sTableName: string;
    nArquivos: Integer;
    skey: string;
    lFieldDefault: string;
    lseqName: string;
    lstGenerators: TstringList;
    sIndex: Integer;
    swSchema: TjsonObject;
    swSchemaDetail: TjsonObject;
    swDefinicoes: TjsonObject;
    swProperts: TjsonObject;
    swRequired: TJSONArray;
    lmetaData: TFDQuery;
    FConnection: TConnection;
    FtabelasText: string;
    LValorCampo: string;
    ACamposJson: string;
    procedure setlmetaDataFirebird();
    procedure setlmetaDataPostGres();
    procedure setSchemaProps();
    procedure setSwagerSchema();
    function setResourceName(tableName: string): string;
    function tableNameIsvalid(tableName: string): boolean;
    procedure addLog(value: string);
    function openTable(): boolean;
    Function RemoveAcentos(Str: String): String;
    procedure setFieldsProperts();
    procedure produceSwagerJson();
    procedure ProducePostmanJson();
    procedure produceUnitResource(index: Integer);
    procedure setTabelas(value: string);
    procedure dolog(Sender: TObject; mensagem: string);
    procedure doprocesslog(Sender: TObject; mensagem: string);

  public
    procedure Execute(); override;
    constructor create(CreateSuspended: boolean);
    destructor destroy; override;

  published
    property Connection: TConnection read FConnection write FConnection;
    property arquivosGerados: Integer read nArquivos write nArquivos;
    property aliases: string read Faliases write Faliases;
    property tabelasText: string read FtabelasText write setTabelas;

    property onGerarResource: TonGerarResource read FonGerarResource
      write FonGerarResource;

    property onLog: Tonlog read FonLog write FonLog;
    property diretorio: string read Fdiretorio write Fdiretorio;
  end;

const
  _ctTemplate = 'ResourceBaseClass.pas';

implementation

uses
  imp.model.postman;

function pascalCase(value: string): string;
var
  _lst: TstringList;
  _subIndex: Integer;
  _subLine: string;
begin
  _lst := TstringList.create;
  try
    result := '';
    _lst.Delimiter := '_';

    _lst.StrictDelimiter := True;
    _lst.DelimitedText := value;
    for _subIndex := 0 to _lst.Count - 1 do
    begin
      _subLine := _lst[_subIndex];
      _subLine := trim(_subLine);
      result := result + AnsiUpperCase(_subLine[1]) +
        AnsiLowerCase(Copy(_subLine, 2, Length(_subLine)))
    end;
  finally
    FreeAndNil(_lst);
  end;
end;

{ TResourceGenerator }
{ ------------------------------------------------------------------------------ }
Function TResourceGenerator.RemoveAcentos(Str: String): String;
{ Remove caracteres acentuados de uma string }
Const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
Var
  x: Integer;
Begin
  For x := 1 to Length(Str) do
  Begin
    if Pos(Str[x], ComAcento) <> 0 Then
    begin
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
    end;
  end;
  result := Str;
end;

{ ------------------------------------------------------------------------------ }
function TResourceGenerator.openTable(): boolean;
begin
  result := false;
  try
    FConnection.Table.open();
    result := True;
  except
    on e: exception do
      doprocesslog(self, 'falha ao abrir tabela ' + e.Message);
  end;
end;

procedure TResourceGenerator.ProducePostmanJson();
begin
  ACamposJson := Copy(ACamposJson, 1, ACamposJson.Length - 5);
  ACamposJson := '"body": { ' + #13#10 +
    '                                    "mode": "raw", ' + #13#10 +
    '                                    "raw": "{\r\n' + ACamposJson +
    '\r\n}", ' + #13#10 + '                                    "options": { ' +
    #13#10 + '                                        "raw": { ' + #13#10 +
    '                                            "language": "json" ' + #13#10 +
    '                                        } ' + #13#10 +
    '                                    } ' + #13#10 +
    '                                }, ';
  with TstringList.create do
  begin
    Add(TPostman.create.Ref.Execute(sTableName, ACamposJson));
    ForceDirectories(Fdiretorio + '\Postman');
    doprocesslog(self, 'Salvando resource  postman ' + Fdiretorio +
      '\Resources.' + sResouceName + '.json');
    SaveToFile(Fdiretorio + '\Postman\Resources.' + sResouceName + '.json')

  end;
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.produceSwagerJson;
begin
  swSchemaDetail.AddPair('required', swRequired);
  swSchemaDetail.AddPair('properties', swProperts);
  swSchema.AddPair(sResouceName, swSchemaDetail);
  with TstringList.create do
  begin
    Text := swSchema.ToJSON;
    ForceDirectories(Fdiretorio + '\Swager');
    doprocesslog(self, 'Salvando resource  swager ' + Fdiretorio + '\Resources.'
      + sResouceName + '.json');
    SaveToFile(Fdiretorio + '\Swager\Resources.' + sResouceName + '.json');

    free;
  end;
  swDefinicoes.AddPair(sResouceName, swSchema);
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.produceUnitResource(index: Integer);
begin
  lst.Text := StringReplace(lst.Text, '%resourceName', LowerCase(sResouceName),
    [rfReplaceAll, rfIgnoreCase]);
  lst.Text := StringReplace(lst.Text, '%tableName', LowerCase(Ftabelas[index]),
    [rfReplaceAll, rfIgnoreCase]);
  lst.Text := StringReplace(lst.Text, '%fieldsDef', lFieldsDef.Text,
    [rfReplaceAll, rfIgnoreCase]);
  lst.Text := StringReplace(lst.Text, '%tClassName', 'T' + sResouceName,
    [rfReplaceAll, rfIgnoreCase]);
  lst.SaveToFile(Fdiretorio + '\Resources.' + sResouceName + '.pas');
  if skey <> '' then
    skey := '{' + skey + '}';
  skey := '';
end;

{ ------------------------------------------------------------------------------ }
function TResourceGenerator.tableNameIsvalid(tableName: string): boolean;
begin

  result := Pos('$', tableName) <= 0;
end;

{ ------------------------------------------------------------------------------ }
function TResourceGenerator.setResourceName(tableName: string): string;
var
  i: Integer;
  outInt: Integer;
  changed: boolean;
  sresult: string;
  listAliases: TstringList;
  procedure checkTname();
  begin
    if not changed then
    begin
      // if Pos('T', sresult) = 1 then
      // sresult := Copy(sresult, 2, Length(sresult));

      if TryStrToInt(Copy(sresult, 1, 5), outInt) then
        sresult := Copy(sresult, 6, Length(sresult))

      else if TryStrToInt(Copy(sresult, 1, 4), outInt) then
        sresult := Copy(sresult, 5, Length(sresult))

      else if TryStrToInt(Copy(sresult, 1, 3), outInt) then
        sresult := Copy(sresult, 4, Length(sresult))

      else if TryStrToInt(Copy(sresult, 1, 2), outInt) then
        sresult := Copy(sresult, 3, Length(sresult))
    end;
  end;

begin
  listAliases := TstringList.create;
  listAliases.Text := Faliases;
  sresult := uppercase(tableName);
  changed := false;
  for i := 0 to listAliases.Count - 1 do
  begin
    if Pos(uppercase(listAliases[i]), sresult) = 1 then
    begin
      sresult := pascalCase(sresult);
      changed := True;
      Break;
    end;
  end;
  checkTname();
  sresult := pascalCase(sresult);
  if lstTblOutput.IndexOf(sresult) < 0 then
  begin
    lstTblOutput.Add(sresult);
  end
  else
  begin
    sresult := uppercase(tableName);
    changed := false;
    checkTname();
    sresult := pascalCase(sresult);
  end;
  result := sresult
end;

{ ----------------------------------------------------------------------------- }
procedure TResourceGenerator.setFieldsProperts;
var
  j: Integer;
begin
  ACamposJson := EmptyStr;
  LValorCampo := ':0,\r\n';

  for j := 0 to FConnection.Table.FieldCount - 1 do
  begin
    sFieldType := '';
    sDescription := '';

    sName := AnsiUpperCase(FConnection.Table.Fields[j].FullName);
    // sName := trim(sName);
    // sName := StringReplace(sName, '_', EmptyStr, [rfReplaceAll]);
    // sName := StringReplace(sName, ' ', EmptyStr, [rfReplaceAll]);
    if lmetaData.locate('FIELD_NAME', sName, [loCaseInsensitive]) then
      sDescription := lmetaData.FieldByName('FIELD_DESCRIPTION').AsString;
    case FConnection.Table.Fields[j].DataType of
      ftInteger, ftSmallint, ftShortint:
        sFieldType := 'Integer';
      ftDateTime:
        begin
          sFieldType := 'TDateTime';
        end;
      ftDate:
        begin
          sFieldType := 'TDate';
        end;
      ftTime:
        begin
          sFieldType := 'TTime';
        end;
      ftTimeStamp:
        begin
          sFieldType := 'TDateTime';
        end;
      ftBoolean:
        begin
          sFieldType := 'boolean';
        end;
      ftByte, ftBlob, ftGraphic, ftTypedBinary:
        begin
          sFieldType := 'TBytea';
        end;
      ftFloat, ftCurrency, ftBCD, ftLargeint, ftFMTBcd, ftExtended, ftSingle:
        sFieldType := 'double';
      ftString, ftMemo, ftWideString, ftWideMemo:
        begin
          sFieldType := 'String';
          LValorCampo := ':\"valor\",\r\n';
        end;

    else
      addLog(' -> tipo desconhecido tabela: ' + FConnection.Table.tableName +
        ' - ' + FConnection.Table.Fields[j].FieldName);
      // ftLargeint   ira como string para os campos GID
      sFieldType := 'String';
    end;

    sContraints := 'null';

    if sFieldType <> '' then
    begin
      if FConnection.Table.Fields[j].Required then

        sContraints := 'NotNull';

      if pfInKey in FConnection.Table.Fields[j].ProviderFlags then
      begin
        sContraints := 'PrimaryKey';

        if skey = '' then
          skey := sName + ':' + lFieldDefault
        else
          skey := skey + ',' + sName + ':' + lFieldDefault;
      end;

      sSize := '';
      ACamposJson := ACamposJson + '    \"' + LowerCase((sName)) + '\"' +
        LValorCampo;

      // PrimaryKey, ForeignKey, NotNull, Null
      // if (sFieldType = 'String') and (FConnection.Table.Fields[j].Size > 0) then
      // sSize := ', ' + inttostr(FConnection.Table.Fields[j].Size);

      // TIRARAM O SIZE
      if j = 0 then
        lFieldsDef.Add('[DBField(' + QuotedStr(sName) + '  ,True, True,false, ' +
          sContraints + sSize + ')]')
      else
        lFieldsDef.Add('     [DBField(' + QuotedStr(sName) +
          '  ,True, True,True, ' + sContraints + sSize + ')]');

      if (lseqName <> '') and ((uppercase(sName) = 'GID') or
        (uppercase(sName) = 'ID')) then
      begin
        lFieldsDef.Add('     [AutoInc(' + QuotedStr(lseqName) + ')]');
        lseqName := '';
      end;

      lFieldsDef.Add('     ' + pascalCase(sName) + ' : ' + sFieldType + ';');

    end;
    setSchemaProps();
  end; // END FOR CAMPOS
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.setlmetaDataFirebird();
begin
  lmetaData := TFDQuery.create(Nil);
  lmetaData.Connection := FConnection.DB;
  with lmetaData.SQL do
  begin
    Add('SELECT                                                     ');
    Add('   RF.RDB$RELATION_NAME,                                   ');
    Add('   RF.RDB$FIELD_NAME FIELD_NAME,                           ');
    Add('   RF.RDB$DESCRIPTION FIELD_DESCRIPTION                    ');
    Add('FROM                                                       ');
    Add('   RDB$RELATION_FIELDS RF                                  ');
    Add('JOIN RDB$FIELDS F ON                                       ');
    Add('    (F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE)               ');
    Add('LEFT OUTER JOIN RDB$CHARACTER_SETS CH ON                   ');
    Add('    (CH.RDB$CHARACTER_SET_ID = F.RDB$CHARACTER_SET_ID)     ');
    Add('LEFT OUTER JOIN RDB$COLLATIONS DCO ON                      ');
    Add('  ((DCO.RDB$COLLATION_ID = F.RDB$COLLATION_ID)             ');
    Add('  AND (DCO.RDB$CHARACTER_SET_ID = F.RDB$CHARACTER_SET_ID)) ');
    Add('WHERE');
    Add('   (COALESCE(RF.RDB$SYSTEM_FLAG, 0) = 0)                   ');
    Add('  AND RF.RDB$RELATION_NAME  =:TABELA                       ');
    Add('ORDER BY RF.RDB$FIELD_POSITION                             ');
  end;
end;

procedure TResourceGenerator.setlmetaDataPostGres();
begin
  lmetaData := TFDQuery.create(Nil);
  lmetaData.Connection := FConnection.DB;
  with lmetaData.SQL do
  begin

    Add('SELECT                    ');
    Add('   column_name  as  FIELD_NAME , ');
    Add('   column_name  as  NAME,  ');
    Add('   column_name  as  FIELD_DESCRIPTION, ');
    Add('   data_type,         ');
    Add('   table_catalog,     ');
    Add('   table_name,        ');
    Add('   ordinal_position,  ');
    Add('   is_nullable,       ');
    Add('   table_schema       ');
    Add('FROM                   ');
    Add('  information_schema.columns  ');
    Add('  WHERE table_name = :TABELA ');
  end;
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.setSwagerSchema();

begin
  swSchema := TjsonObject.create;
  swSchemaDetail := TjsonObject.create;

  swSchemaDetail.AddPair('type', 'object');
  swSchemaDetail.AddPair('description', 'Dados ' + sResouceName);
  swRequired := TJSONArray.create;
  swProperts := TjsonObject.create;

end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.setTabelas(value: string);
begin
  Ftabelas.Text := value;
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.setSchemaProps();
var
  obj: TjsonObject;
  swType: string;
begin
  swType := LowerCase(sFieldType);
  if (swType = 'tdatetime') or (swType = 'ttime') or (swType = 'tdate') then
    swType := 'date';
  if (swType = 'double') then
    swType := 'number';
  obj := TjsonObject.create;
  obj.AddPair('type', swType);
  obj.AddPair('description', RemoveAcentos(sDescription));
  if swType = 'integer' then
    obj.AddPair('format', 'int64');

  if swType = 'date' then
  begin
    obj.AddPair('pattern', '/([0-9]{4})-(?:[0-9]{2})-([0-9]{2})/');
    obj.AddPair('example', '2023-01-17');
  end;
  if (swType = 'string') and (sSize <> '') then
    obj.AddPair('size', Copy(sSize, 3, Length(sSize)));

  swProperts.AddPair(sName, obj);

  if (sContraints = 'NotNull') or (sContraints = 'PrimaryKey') then
  begin
    swRequired.Add(sName);
  end;
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.addLog(value: string);
begin
  Synchronize(nil);
  if assigned(FonLog) then
    (FonLog(self, value));
end;

{ ------------------------------------------------------------------------------ }
constructor TResourceGenerator.create(CreateSuspended: boolean);
begin
  lFieldDefault := '0';
  lstTblOutput := TstringList.create;
  lTemplate := TstringList.create;

  lst := TstringList.create;
  lFieldsDef := TstringList.create;
  lTables := TstringList.create;
  nArquivos := 0;
  lstGenerators := TstringList.create;
  swDefinicoes := TjsonObject.create;
  Ftabelas := TstringList.create;
  inherited create(CreateSuspended);
end;

{ ------------------------------------------------------------------------------ }
destructor TResourceGenerator.destroy;
begin
  FreeAndNil(lstTblOutput);
  FreeAndNil(lTemplate);
  FreeAndNil(lst);
  FreeAndNil(lTables);
  FreeAndNil(lstGenerators);
  FreeAndNil(swDefinicoes);
  FreeAndNil(Ftabelas);
  FreeAndNil(FConnection);
  inherited;
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.dolog(Sender: TObject; mensagem: string);
begin
  Synchronize(nil);
  if assigned(FonLog) then
    FonLog(Sender, mensagem);
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.doprocesslog(Sender: TObject; mensagem: string);
begin
  Synchronize(nil);
  if assigned(FonGerarResource) then
    FonGerarResource(Sender, mensagem);
end;

{ ------------------------------------------------------------------------------ }
procedure TResourceGenerator.Execute;
var
  i: Integer;
  j: Integer;
begin
  try
    try
      try
        FConnection := TConnection.create;
      except
        on e: exception do
          raise exception.create('Conex„o n„o pode ser iniciada ' + e.Message);

      end;
      sFileName := ExtractFilePath(GetModuleName(HInstance)) + '\Template\' +
        _ctTemplate;
      if FileExists(sFileName) then
        lTemplate.LoadFromFile(sFileName)
      else
        raise exception.create('Arquivo template : ' + sFileName +
          ' n„o encontrado na pasta ' + ExtractFilePath(GetModuleName(HInstance)
          ) + '\Template\');
      setlmetaDataPostGres();
      FConnection.DB.GetGeneratorNames('', '', '', lstGenerators);
      for i := 0 to Ftabelas.Count - 1 do
      begin
        lseqName := '';
        if tableNameIsvalid(Ftabelas[i]) then
        begin
          lst.Clear;
          lst.Text := lTemplate.Text;
          sResouceName := setResourceName(Ftabelas[i]);
          doprocesslog(self, 'processsando  resource' + sResouceName);
          lFieldsDef.Clear;
          FConnection.Table.Close;
          FConnection.Table.tableName := Ftabelas[i];
          skey := '';
          try
            if openTable() then
            begin
              sTableName := uppercase(Ftabelas[i]);
              sIndex := lstGenerators.IndexOf('SEQID_' + Copy(sTableName, 2,
                Length(sTableName)));
              if sIndex < 0 then
                sIndex := lstGenerators.IndexOf('SEQID_' + Copy(sTableName, 1,
                  Length(sTableName)));

              if sIndex < 0 then
                sIndex := lstGenerators.IndexOf(LowerCase(sTableName) +
                  '_id_seq');

              if sIndex > -1 then
                lseqName := lstGenerators[sIndex];

              lmetaData.Close;
              lmetaData.ParamByName('TABELA').AsString := sTableName;
              lmetaData.open;

              setSwagerSchema();
              setFieldsProperts();
              ProducePostmanJson();
              FConnection.Table.Close;
              lTables.Add(FConnection.Table.tableName);

              produceSwagerJson();
              produceUnitResource(i);
              inc(nArquivos);
            end
            else
            begin
              doprocesslog(self, 'tabela n„o pode ser aberta ' + sResouceName);
            end;
          except
            on e: exception do
            begin

              doprocesslog(self, 'Falha ao criar resource ' + sResouceName + ' '
                + e.Message);
            end;

          end;
        end; // END VAL
        lFieldsDef.Clear;
        lst.Clear;
      end; // END FOR TABELAS
    except
      on e: exception do
        doprocesslog(self, 'erro no processamento ' + e.Message);

    end;
  finally
    doprocesslog(self, 'finalizando processamento na tabela ');
    FConnection.Table.Close;
    FConnection.DB.Close;
    lTables.SaveToFile(ExtractFilePath(GetModuleName(HInstance)) +
      'TabelasMapeadas.txt');
    self.Terminate;
  end;
end;

{ ------------------------------------------------------------------------------ }
end.
