unit Server.ResourceBaseClass;

interface

uses
  System.Classes,
  System.Rtti,
  System.JSON,

  Rest.JSON,
  Web.HTTPApp,
  variants,
  Server.Attributes,
  Server.Message,
  Server.MessageList,
  System.Generics.Collections,
  Server.Connection,
  System.DateUtils,
  Server.Records,
  Server.Util;

type
  TResourceBaseClass = class(TPersistent)
  private
    FFieldsJSON: TStringList;
    FOutpuJson: TJSONObject;
    function GetRttiType: TRttiType;
    function GetValueSequence(SequenceName: String): Integer;
    function GetRttiField(Name: String): TRttiField;
    procedure SetValueObject(FieldName: String; Value: String);
    procedure ValidateInteger(FieldName, Value: String);
    function GetResourceDetails(Dados: TJSONObject): TObjectList<TObject>;
    procedure ProcessDetails(Dados: TJSONObject; Response: TWebResponse;
      Operacao: String; List: TObjectList<TObject>);

    procedure ValidateID(ID: Integer);
    procedure SetPrimaryKey(ID: Integer);
    procedure SetDetailAtribute(RttiAttribute: TCustomAttribute;
      Ldados: TJSONObject; LConn: TConnection; LJsonResponse: TJSONObject;
      LMessageType: TMessageType);

  protected
    FResponse: TWebResponse;
    FJsonArrayList: TJsonArray;
    procedure ValidateBusiness(List: TObjectList<TObject>); virtual;
    function GetWherePadrao: String; virtual;
  public
    procedure SetAutoInc;

    procedure SetDados(Dados: TJSONObject);
    procedure ValidateNotNull;
    function GetFieldKeys: string;
    [Get]
    procedure Get(Response: TWebResponse; PageNumber: Integer;
      PageSize: Integer; Direction: String; Sort: String; Search: String;
      ID: String; Join: string; JSON: TJSONObject); overload; virtual;

    procedure Get(AValuesRequest: TValuesRequest); overload; virtual;
    [Post]
    procedure Post(Response: TWebResponse; Dados: TJSONObject;
      Conn: TConnection = nil); virtual;
    [Put]
    procedure Put(Response: TWebResponse; ID: Integer; Dados: TJSONObject;
      Conn: TConnection = nil); virtual;
    [Delete]
    procedure Delete(Response: TWebResponse; ID: Integer); overload; virtual;
    procedure Delete(Response: TWebResponse; Condicao: string);
      overload; virtual;

    property OutpuJson: TJSONObject read FOutpuJson write FOutpuJson;
    property JsonArrayList: TJsonArray read FJsonArrayList write FJsonArrayList;
  end;

implementation

uses
  System.SysUtils, Server.DAO;

{ TResourceBaseClass }

procedure TResourceBaseClass.Delete(Response: TWebResponse; ID: Integer);
begin
  FResponse := Response;
  SetPrimaryKey(ID);
  TDAO.Delete(Response, Self);
end;

procedure TResourceBaseClass.Delete(Response: TWebResponse; Condicao: string);
begin
  FResponse := Response;
  TDAO.Delete(Response, Self, Condicao);
end;

procedure TResourceBaseClass.SetPrimaryKey(ID: Integer);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          RttiField.SetValue(Self, ID)
end;

procedure TResourceBaseClass.Get(AValuesRequest: TValuesRequest);
begin
  FResponse := AValuesRequest.Response;
  TDAO.Select(Self, AValuesRequest);
end;

function TResourceBaseClass.GetRttiField(Name: String): TRttiField;
var
  RttiType: TRttiType;
begin
  RttiType := GetRttiType;
  Result := RttiType.GetField(Name);
end;



procedure TResourceBaseClass.ValidateBusiness(List: TObjectList<TObject>);
begin

end;

function TResourceBaseClass.GetFieldKeys: string;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          Result := (RttiAttribute as DBField).FieldName;

end;

procedure TResourceBaseClass.ValidateID(ID: Integer);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  if ID > 0 then
  begin
    RttiType := GetRttiType;
    for RttiField in RttiType.GetFields do
      for RttiAttribute in RttiField.GetAttributes do
        if RttiAttribute is DBField then
          if (RttiAttribute as DBField).Constraints = PrimaryKey then
            if RttiField.GetValue(Self).AsInteger <> ID then
              TMessage.Create(EDadosNaoSalvos, 'ID Incompatível')
                .SendMessage(FResponse);
  end;
end;

function TResourceBaseClass.GetRttiType: TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  Result := RttiContext.GetType(Self.ClassInfo);
end;

procedure TResourceBaseClass.Get(Response: TWebResponse; PageNumber: Integer;
  PageSize: Integer; Direction: String; Sort: String; Search: String;
  ID: String; Join: string; JSON: TJSONObject);
begin
  FResponse := Response;


  TDAO.Select(Response, Self, PageNumber, PageSize, Direction, Sort, Search, ID,
    GetWherePadrao, Join, JSON);
end;

function TResourceBaseClass.GetWherePadrao: String;
begin
  Result := EmptyStr;
end;

procedure TResourceBaseClass.Post(Response: TWebResponse; Dados: TJSONObject;
  Conn: TConnection = nil);
var
  List: TObjectList<TObject>;
  ListDetails: TObjectList<TObject>;
begin
  FResponse := Response;
  List := TObjectList<TObject>.Create;
  SetDados(Dados);

  SetAutoInc;
  ValidateNotNull;
  List.Add(Self);
  ValidateBusiness(List);
  ListDetails := GetResourceDetails(Dados);
  if ListDetails.Count > 0 then
  begin
    ProcessDetails(Dados, Response, 'insert', List);
  end
  else
  begin
    TDAO.Insert(Response, List, Dados, Conn);
  end;
end;

function TResourceBaseClass.GetResourceDetails(Dados: TJSONObject)
  : TObjectList<TObject>;
var
  Ldados: TJSONObject;
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  Resource: TObject;
begin
  Ldados := TJSONObject.ParseJSONValue(Dados.ToString.ToLower) as TJSONObject;
  Result := TObjectList<TObject>.Create;
  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
  begin
    for RttiAttribute in RttiField.GetAttributes do
    begin
      if (RttiAttribute is TResourceDetail) then
      begin
        Resource := TWKUtil.GetResourceByName((RttiAttribute as TResourceDetail)
          .ResourceName);
        var
          LSubArray: TJsonArray;
        if Ldados.TryGetValue(TWKUtil.GetResourName(Resource), LSubArray) then
        begin
          if (LSubArray.Count > 0) then
            Result.Add(Resource);
          if (assigned(LSubArray)) then
            FreeAndNil(LSubArray);
        end;

      end;
    end;
  end;

end;

procedure TResourceBaseClass.SetDetailAtribute(RttiAttribute: TCustomAttribute;
  Ldados: TJSONObject; LConn: TConnection; LJsonResponse: TJSONObject;
  LMessageType: TMessageType);
var
  LDadosSub: TJSONObject;
  LId: String;
  LSearch: TJSONObject;
  Lkeys: TStringList;
  LMasterkeyValue: string;
  LIndiceArray: Integer;
  index: Integer;
  LValue: string;
begin
  Lkeys := TStringList.Create;
  try
    var
    Resource := TWKUtil.GetResourceByName((RttiAttribute as TResourceDetail)
      .ResourceName);
    var
      LSubArray: TJsonArray;


    if Ldados.TryGetValue<TJsonArray>(TWKUtil.GetResourName(Resource),
      LSubArray) and (LSubArray.Count > 0) then
    begin
      LId := '';
      LSearch := TJSONObject.Create;
      Lkeys.Text := LowerCase(TResourceBaseClass(Resource).GetFieldKeys);

      for LIndiceArray := 0 to LSubArray.Count - 1 do
      begin
        LDadosSub := LSubArray[LIndiceArray] AS TJSONObject;
        for index := 0 to Lkeys.Count - 1 do
        begin
          LValue := '';
          LDadosSub.TryGetValue(Lkeys[index], LValue);
          if LValue <> '' then
          begin
            if index = 0 then
              LId := LValue;
            LSearch.AddPair(Lkeys[index], LValue);
          end;
        end;

        LMasterkeyValue := Self.GetRttiField((RttiAttribute as TResourceDetail)
          .KeyField).GetValue(Self).AsVariant;

        LDadosSub.RemovePair(LowerCase((RttiAttribute as TResourceDetail)
          .KeyReference));
        LDadosSub.AddPair((RttiAttribute as TResourceDetail).KeyReference,
          LMasterkeyValue);

        if (LMasterkeyValue <> '') and (LValue <> '') then
          LSearch.AddPair((RttiAttribute as TResourceDetail).KeyReference,
            LMasterkeyValue);

        LMasterkeyValue := '';

        if Length(LSearch.ToString) > 3 then
        begin
          TResourceBaseClass(Resource).Get(nil, 1, 50, EmptyStr, EmptyStr,
            LSearch.ToString, EmptyStr, EmptyStr, nil);

          LMasterkeyValue := TResourceBaseClass(Resource).GetRttiField(Lkeys[0])
            .GetValue(Resource).AsVariant;
        end;

        if (LMasterkeyValue <> '') and (LMasterkeyValue <> '0') then
        begin
          TResourceBaseClass(Resource).Put(Nil, strtoint(LId),
            LDadosSub, LConn);
          TDAO.SetDadosInMessage(Resource, LMessageType);
          LJsonResponse.AddPair('update', LMessageType.Content);
        end
        else
        begin
          TResourceBaseClass(Resource).Post(Nil, LDadosSub, LConn);
          TDAO.SetDadosInMessage(Resource, LMessageType);
          LJsonResponse.AddPair('insert', LMessageType.Content);
        end;
      end;
      if assigned(LSubArray) then
        FreeAndNil(LSubArray)

    end;
  finally
    FreeAndNil(Lkeys);
  end;
end;

procedure TResourceBaseClass.ProcessDetails(Dados: TJSONObject;
  Response: TWebResponse; Operacao: string; List: TObjectList<TObject>);
var
  LConn: TConnection;
  LMessageType: TMessageType;
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  LJsonResponse: TJSONObject;
begin
  var
  Ldados := TJSONObject.ParseJSONValue(Dados.ToString.ToLower) as TJSONObject;
  RttiType := GetRttiType;
  LConn := TConnection.Create;
  LJsonResponse := TJSONObject.Create;
  LConn.DB.StartTransaction;
  try
    try
      if Operacao = 'insert' then
      begin
        TDAO.Insert(Nil, List, Dados, LConn);
        LMessageType := IRegistroInserido;
        TDAO.SetDadosInMessage(List[0], LMessageType);
        LJsonResponse.AddPair('insert', LMessageType.Content);
      end
      else
      begin
        TDAO.Update(Nil, List, Dados, LConn);
        LMessageType := IRegistroAlterado;
        TDAO.SetDadosInMessage(List[0], LMessageType);
        LJsonResponse.AddPair('update', LMessageType.Content);
      end;
      for RttiField in RttiType.GetFields do
        for RttiAttribute in RttiField.GetAttributes do
          if RttiAttribute is TResourceDetail then
          begin
            SetDetailAtribute(RttiAttribute, Ldados, LConn, LJsonResponse,
              LMessageType);
          end;
      LConn.DB.Commit;
      LMessageType.Content := LJsonResponse;
      TMessage.Create(LMessageType).SendMessage(Response);
    except
      on e: exception do
      begin
        LConn.DB.Rollback;
        FreeAndNil(LJsonResponse);
        LJsonResponse := TJSONObject.Create;
        LJsonResponse.AddPair('erro', e.Message);
        LMessageType := EErroGeral;
        LMessageType.Content := LJsonResponse;
        TMessage.Create(LMessageType).SendMessage(Response);
      end;
    end;
  finally
    FreeAndNil(LConn);

  end;
end;

procedure TResourceBaseClass.Put(Response: TWebResponse; ID: Integer;
  Dados: TJSONObject; Conn: TConnection = nil);
var
  List: TObjectList<TObject>;
  ListDetails: TObjectList<TObject>;

begin
  FResponse := Response;
  List := TObjectList<TObject>.Create;
  if not assigned(Dados) then
  begin
    Dados := Rest.JSON.TJson.ObjectToJsonObject(Self);
  end;
  SetDados(Dados);

  ValidateID(ID);
  ValidateNotNull;
  List.Add(Self);
  ListDetails := GetResourceDetails(Dados);
  if ListDetails.Count > 0 then
  begin
    ProcessDetails(Dados, Response, 'update', List);
  end
  else
  begin
    TDAO.Update(Response, List, Dados, Conn);
  end;
end;

procedure TResourceBaseClass.SetDados(Dados: TJSONObject);
var
  Item: TJSONPair;
  FieldName: String;
  Value: String;
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;

begin

  FFieldsJSON := TStringList.Create;
  if not assigned(Dados) then
    raise exception.Create('Dados não carregados, verificar json !');

  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
      begin
        if RttiField.FieldType.TypeKind in [tkInteger] then
          RttiField.SetValue(Self, -1)

        else if RttiField.FieldType.TypeKind
          in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar,
          tkWideString, tkChar] then
          RttiField.SetValue(Self, 'Null');
      end;

  for Item in Dados do
  begin
    FieldName := Item.JsonString.Value;
    Value := Item.JsonValue.Value;

    SetValueObject(FieldName, Value);
  end;
  FOutpuJson := Dados;

end;



procedure TResourceBaseClass.SetValueObject(FieldName, Value: String);
var
  RttiField: TRttiField;
  RttiValue: TValue;

begin
  RttiField := GetRttiField(FieldName);

  if RttiField <> nil then
  begin
    if RttiField.FieldType.TypeKind in [tkInteger] then
    begin
      if Value <> EmptyStr then
      begin
        ValidateInteger(FieldName, Value);
        RttiValue := Value.ToInteger;
      end;
    end
    else if RttiField.FieldType.TypeKind in [tkString, tkUString,
      tkUnicodeString, tkWString, tkWideChar, tkWideString, tkChar] then
      RttiValue := Value
    else if RttiField.FieldType.TypeKind in [tkEnumeration] then
      RttiValue := Value.ToBoolean
    else if RttiField.FieldType.TypeKind in [tkFloat] then
    begin
      if (RttiField.FieldType.Name = 'TDateTime') then
        RttiValue := TWKUtil.parseDateTime(Value)
      else if (RttiField.FieldType.Name = 'TDate') then
        RttiValue := TWKUtil.parseDate(Value)
      else if (RttiField.FieldType.Name = 'TTime') then
        RttiValue := TWKUtil.parseDateTime(Value)
      else
        RttiValue := TWKUtil.parseFloat(Value);

    end
    else if (RttiField.FieldType.Name = 'TMacAddress') then
      RttiValue := TMacAddress.Create(Value)
    else if (RttiField.FieldType.Name = 'TBytea') then
      RttiValue := TBytea.Create(Value);

    RttiField.SetValue(Self, RttiValue);
    FFieldsJSON.Add(FieldName);
  end;
end;

procedure TResourceBaseClass.ValidateInteger(FieldName: String; Value: String);
var
  I: Integer;
begin
  if not(TryStrToInt(Value, I)) then
    TMessage.Create(EDadosNaoSalvos, FieldName + ' deve ser um número válido')
      .SendMessage(FResponse);
end;

procedure TResourceBaseClass.ValidateNotNull;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints in [NotNull] then
          if (FFieldsJSON.IndexOf(RttiField.Name) < 0) then
            TMessage.Create(ECampoNotNullNaoPreenchido,
              RttiField.Name + ' é obrigatório').SendMessage(FResponse);
end;

procedure TResourceBaseClass.SetAutoInc;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  SequenceName: String;
  Value: Integer;
  s: string;
begin
  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is AutoInc then
      begin
        SequenceName := (RttiAttribute as AutoInc).SequenceName;
        Value := GetValueSequence(SequenceName);
        RttiField.SetValue(Self, Value);
        s := RttiField.Name;
        Break;
      end;
end;

function TResourceBaseClass.GetValueSequence(SequenceName: String): Integer;
const
  SQL = 'SELECT nextval(%s) seq';
var
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(Format(SQL, [QuotedStr(SequenceName)]));
    Connection.Query.Open;
    Result := Connection.Query.FieldByName('seq').AsInteger;
  finally
    Connection.Free;
  end;
end;

end.
