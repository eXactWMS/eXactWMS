unit Providers.Base;

interface

uses
  System.SysUtils, System.Classes,  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.JSON, System.Generics.Collections,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  //FireDAC.VCLUI.Wait
  Horse.Request, Web.HTTPApp, FireDAC.Comp.UI;

type
  TProvidersBase = class(TProvidersConnection)
    qryPesquisa: TFDQuery;
    qryRecordCount: TFDQuery;
    qryCadastro: TFDQuery;
    qryRecordCountCOUNT: TLargeintField;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create; reintroduce;
    function Append(const AJson: TJSONObject): Boolean; virtual;
    function Update(const AJson: TJSONObject): Boolean; virtual;
    function Delete: Boolean; virtual;
    function ListAll(const AParams: TDictionary<string, string>)
      : TFDQuery; virtual;
    function GetById(const AId: string): TFDQuery; virtual;
    function GetRecordCount: Int64; virtual;
    Procedure SalvarLog(pMethod: TMethodType; pUsuarioId: Integer;
      pTerminal, pIpClient: String; pPort: Integer; pUrl: String;
      pParams: String; pBody, pResponseStr: String; pResponseJson: AnsiString;
      pRespStatus: Integer; pTimeExecution: Double; pAppName: String);
  end;

var
  ProvidersBase: TProvidersBase;

implementation

uses DataSet.Serialize;

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
{ TProvidersCadastro }

function TProvidersBase.Append(const AJson: TJSONObject): Boolean;
begin
  qryCadastro.SQL.Add('where 1 <> 1');
  qryCadastro.Open();
  qryCadastro.LoadFromJSON(AJson, False);
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

constructor TProvidersBase.Create;
begin
  inherited Create(nil);
end;

function TProvidersBase.Delete: Boolean;
begin
  qryCadastro.Delete;
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

function TProvidersBase.GetById(const AId: string): TFDQuery;
begin
  qryCadastro.SQL.Add('where id = :id');
  qryCadastro.ParamByName('id').AsLargeInt := AId.ToInt64;
  qryCadastro.Open();
  Result := qryCadastro;
end;

function TProvidersBase.GetRecordCount: Int64;
begin
  qryRecordCount.Open();
  Result := qryRecordCountCOUNT.AsLargeInt;
end;

function TProvidersBase.ListAll(const AParams: TDictionary<string, string>)
  : TFDQuery;
begin
  if AParams.ContainsKey('limit') then
  begin
    qryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    qryPesquisa.FetchOptions.RowsetSize :=
      StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    qryPesquisa.FetchOptions.RecsSkip :=
      StrToIntDef(AParams.Items['offset'], 0);
  qryPesquisa.Open();
  Result := qryPesquisa;
end;

procedure TProvidersBase.SalvarLog(pMethod: TMethodType; pUsuarioId: Integer;
  pTerminal, pIpClient: String; pPort: Integer;
  pUrl, pParams, pBody, pResponseStr: String; pResponseJson: AnsiString;
  pRespStatus: Integer; pTimeExecution: Double; pAppName: String);
Var
  vQryLog: TFDQuery;
  vMethod: String;
begin
  If length(pParams) > 1000 then
    pParams := Copy(pParams, 1, 1000);
  If length(pBody) > 4000 then
    pBody := Copy(pBody, 1, 4000);
  If length(pResponseStr) > 1000 then
    pResponseStr := Copy(pResponseStr, 1, 1000);
  If length(pResponseJson) > 8000 then
    pResponseJson := Copy(pResponseJson, 1, 8000);
  pResponseJson := StringReplace(pResponseJson, #39, #34, [rfReplaceAll]);
  Try
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
    vQryLog := TFDQuery.Create(nil);
    vQryLog.Connection := FdConneXactWMSLog;
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
      Else
      Begin
        pParams := Copy(pBody, 1, 1000); // #39+pBody+#39;
        pBody := '[]';
      End;
    end;
    If pResponseJson = '' then
      pResponseJson := 'Null'
    Else
    Begin
      if (TJSONObject.ParseJSONValue(pResponseJson) Is TJsonArray) then
      Begin
        if (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pResponseJson),
          0) as TJsonArray).Count > 1 then
        Begin
          pResponseStr := 'Retorno: ' +
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
          pResponseStr := 'Retorno: ' +
            (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pResponseJson),
            0) as TJSONObject).Count.ToString + ' Registros.';
          pResponseJson := '[]';
        End;
      End
      Else
      Begin
        pResponseStr := pResponseJson;
        pResponseJson := '[]'
      End;
    End;
    // pResponseJson := '[]';//StringReplace(pResponseJson, #34, #39+'+Char(34)+'+#39, [rfReplaceAll]);

    vQryLog.SQL.Add
      ('Insert into RequestResponse (data,	hora,	usuarioid,	terminal,	verbo	,'
      + sLineBreak +
      '            ipclient,	Port,	url,	params, body,	responsestr,	responsejson, '
      + sLineBreak +
      '           	respstatus,	timeexecution) Values (GetDate(), GetDate(), ' +
      '      ' + pUsuarioId.ToString() + ', ' + #39 + pTerminal + #39 + ', ' +
      #39 + vMethod + #39 + ', ' + '      ' + #39 + pIpClient + #39 + ', ' +
      pPort.ToString() + ', ' + #39 + pUrl + #39 + ', ' +
      '      :pParams, :pBody, ' + #39 + pResponseStr + #39 + ', ' +
      '      :pResponseJson, ' +
      // '      '+pResponseJson+', '+
      pRespStatus.ToString() + ', ' + StringReplace(pTimeExecution.ToString(),
      ',', '.', [rfReplaceAll]) +
      // ', '+QuotedStr(pAppName)+
      ')');
    vQryLog.ParamByName('pParams').Value := pParams;
    vQryLog.ParamByName('pBody').Value := pBody;
    vQryLog.ParamByName('pResponseJson').AsAnsiString := pResponseJson;
    // vQryLog.SQL.Add('/*'+pResponseJson+'*/');
    // If DebugHook <> 0 Then vQryLog.Sql.SaveToFile('SalvarLog.Sql');
    vQryLog.ExecSQL;
    vQryLog.Close;
    vQryLog.Free;
    FdConneXactWMSLog.Connected := False;
  Except
    FdConneXactWMSLog.Connected := False;
  End;
end;

function TProvidersBase.Update(const AJson: TJSONObject): Boolean;
begin
  qryCadastro.MergeFromJSONObject(AJson, False);
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

end.
