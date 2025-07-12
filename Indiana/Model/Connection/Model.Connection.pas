unit Model.Connection;

interface

uses
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Phys.MsSQLDef,
  FireDAC.Phys.MsSQL,

  FireDAC.Comp.UI,
  System.Generics.Collections,
  IniFiles, System.SysUtils,
  Web.HTTPApp;

var
  FDriver: TFDPhysMsSQLDriverLink;
  FConnList: TObjectList<TFDConnection>;
  FConnListLog: TObjectList<TFDConnection>;
  ACursor: TFDGUIxWaitCursor;

function Connected: Integer;
procedure Disconnected(Index: Integer);
function ConnectedLog: Integer;
procedure DisconnectedLog(Index: Integer);
Procedure SalvarLog(pMethod: TMethodType; pFdConnection: TFDConnection;
  pUsuarioId: Integer; pTerminal, pIpClient: String; pPort: Integer;
  pUrl: String; pParams: String; pBody, pResponsestr, pResponseJson: String;
  pRespStatus: Integer; pTimeExecution: Double; pAppName: String);

implementation

uses
  exactwmsservice.lib.utils;

function Connected: Integer;

Begin

  try
    if not Assigned(FConnList) then
      FConnList := TObjectList<TFDConnection>.Create;

    FConnList.Add(TFDConnection.Create(nil));

    FDriver := TFDPhysMsSQLDriverLink.Create(Nil);;
    ACursor := TFDGUIxWaitCursor.Create(nil);
    Result := Pred(FConnList.Count);
    FConnList.Items[Result].Params.Values['DriverID'] := 'MSSQL';
    FConnList.Items[Result].ConnectionDefName := _CTCONEXAO;
    Writeln('[Instance Pool] -Conexoes Ativas : ' +
      inttostr(FDManager.ConnectionCount));
    FConnList.Items[Result].Open;
  except
    on e: Exception do
      Writeln('[error] - 74 ' + e.Message)

  end;
end;

procedure Disconnected(Index: Integer);
begin
  Try
    FConnList.Items[Index].Connected := False;
    FConnList.Remove(FConnList.Items[Index]); // .DisposeOf;
    FConnList.TrimExcess;
  Except

  End;
end;

function ConnectedLog: Integer;
Begin
  try
    if not Assigned(FConnListLog) then
      FConnListLog := TObjectList<TFDConnection>.Create;
    FConnListLog.Add(TFDConnection.Create(nil));
    FDriver := TFDPhysMsSQLDriverLink.Create(Nil);
    ACursor := TFDGUIxWaitCursor.Create(nil);
    Result := Pred(FConnListLog.Count);
    FConnListLog.Items[Result].Params.Values['DriverID'] := 'MSSQL';
    FConnListLog.Items[Result].ConnectionDefName := _CTCONEXAOLOG;

    FConnListLog.Items[Result].Open;

  except
    on e: Exception do
      Writeln('[error]143 ' + e.Message);

  end;
end;

procedure DisconnectedLog(Index: Integer);
begin
  Try
    FConnListLog.Items[Index].Connected := False;
    FConnListLog.Remove(FConnListLog.Items[Index]); // .DisposeOf;
    FConnListLog.TrimExcess;
    // if FConnListLog.Count = 0 then FConnListLog.DisposeOf;
  Except

  End;
end;

Procedure SalvarLog(pMethod: TMethodType; pFdConnection: TFDConnection;
  pUsuarioId: Integer; pTerminal, pIpClient: String; pPort: Integer;
  pUrl: String; pParams: String; pBody, pResponsestr, pResponseJson: String;
  pRespStatus: Integer; pTimeExecution: Double; pAppName: String);
Var
  vQryLog: TFDQuery;
  vMethod: String;
begin
  case pMethod of
    mtAny:
      vMethod := 'Any';
    mtGet:
      vMethod := 'Get';
    mtPut:
      vMethod := 'Put';
    mtPost:
      vMethod := 'Post';
    mtHead:
      vMethod := 'Head';
    mtDelete:
      vMethod := 'Delete';
    mtPatch:
      vMethod := 'Patch';
  end;
  Try
    If length(pParams) > 1000 then
      pParams := Copy(pParams, 1, 1000);
    If length(pBody) > 4000 then
      pBody := Copy(pBody, 1, 4000);
    If length(pResponsestr) > 1000 then
      pResponsestr := Copy(pResponsestr, 1, 1000);
    If length(pResponseJson) > 8000 then
      pResponseJson := Copy(pResponseJson, 1, 8000);
    vQryLog := TFDQuery.Create(nil);
    vQryLog.Connection := pFdConnection;
    // if pParams = '' then
    // pParams := 'Null'
    // Else
    // pParams := #39+pParams+#39;
    if pBody = '' then
      pBody := '[]'
    Else
    begin
      if (TJSONObject.ParseJSONValue(pBody) Is TJSONObject) or
        (TJSONObject.ParseJSONValue(pBody) Is TJsonArray) then
        // pBody := StringReplace(pBody, #34 , #39+'+CHAR(34)+'+#39, [rfReplaceAll])
      Else
      Begin
        pParams := Copy(pBody, 1, 1000); // #39+pBody+#39;
        pBody := '[]';
      End;
    end;
    If pResponseJson = '' then
      pResponseJson := '[]'
    Else
    Begin
      if (TJSONObject.ParseJSONValue(pResponseJson) Is TJsonArray) then
      Begin
        if (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pResponseJson),
          0) as TJsonArray).Count > 1 then
        Begin
          pResponsestr := 'Retorno: ' +
            (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pResponseJson),
            0) as TJsonArray).Count.ToString + ' Registros.';
          pResponseJson := '[]';
        End;
      End
      Else if (TJSONObject.ParseJSONValue(pResponseJson) Is TJSONObject) then
      Begin
        if (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pResponseJson),
          0) as TJSONObject).Count > 1 then
        Begin
          pResponsestr := 'Retorno: ' +
            (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pResponseJson),
            0) as TJSONObject).Count.ToString + ' Registros.';
          pResponseJson := '[]';
        End;
      End
      Else
      Begin
        pResponsestr := pResponseJson;
        pResponseJson := '[]';
      End;
    End;
    vQryLog.SQL.Add
      ('Insert into RequestResponse (data,	hora,	usuarioid,	terminal,	verbo	,'
      + sLineBreak +
      '            ipclient,	Port,	url,	params, body,	responsestr,	responsejson, '
      + sLineBreak +
      '           	respstatus,	timeexecution) Values (GetDate(), GetDate(), ' +
      '      ' + pUsuarioId.ToString() + ', ' + #39 + pTerminal + #39 + ', ' +
      #39 + vMethod + #39 + ', ' + '      ' + #39 + pIpClient + #39 + ', ' +
      pPort.ToString() + ', ' + #39 + pUrl + #39 + ', ' +
      '      :pParams, :pBody, ' + #39 + pResponsestr + #39 + ', ' +
      '      :pResponseJson, ' + pRespStatus.ToString() + ', ' + '      ' +
      StringReplace(pTimeExecution.ToString(), ',', '.', [rfReplaceAll]) +
      // ', '+QuotedStr(pAppName)+
      ')');
    vQryLog.ParamByName('pParams').Value := pParams;
    vQryLog.ParamByName('pBody').Value := pBody;
    vQryLog.ParamByName('pResponseJson').Value := pResponseJson;
    If DebugHook <> 0 Then
      vQryLog.SQL.SaveToFile('SalvarLog.Sql');
    vQryLog.ExecSQL;
    vQryLog.Close;
    vQryLog.Free;
  Except
    on e: Exception do
      Writeln('[error]268 ' + e.Message);
  End;
End;

end.
