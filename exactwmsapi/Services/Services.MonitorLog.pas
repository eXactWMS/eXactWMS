unit Services.MonitorLog;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type
  TServiceMonitorLog = class (TBasicDao)
  private
    { Private declarations }
  public
    { Public declarations }
    Function GetListaLog(pIdReq, pUsuarioId: Integer; pDataInicial, pDataFinal: TDateTime; pTerminal, pIpClient, pPorta: String; pStatusCode: Integer; pUrl, pVerbo : String): TjSonArray;
    Function DeleteLog(pIdReq: Integer): TjSonArray;
    Function DashBoard : TJsonArray;
    constructor Create;
    destructor Destroy; override;
  end;

var
  ServiceMonitorLog: TServiceMonitorLog;

implementation

uses Constants, IniFiles;

constructor TServiceMonitorLog.Create;
begin
  inherited;
end;

function TServiceMonitorLog.DashBoard: TJsonArray;
var JsonRetorno: TJsonObject;
    FIndexConnExact: Integer;
    ArqIni: TIniFile;
    BdeXactWMS: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
  Result := TjSonArray.Create;
    try
{
       if fileexists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.Ini') then Begin
          ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance))+'eXactWMS.Ini');
          BdeXactWMS := ArqIni.ReadString('BD', 'DataBase', 'eXactWMSBad');
          ArqIni.Free;
       End
       Else
          raise Exception.Create('Arquivo de configuração do banco de dados inexistente!');
}
      Query.Sql.Add(';With');
      Query.Sql.Add('Req as (select RR.data, Convert(Varchar(2), RR.Hora) as Hora, COUNT(IdReq) TotalReq');
      Query.Sql.Add('From RequestResponse RR');
      Query.Sql.Add('Where RR.Data = Cast(GETDATE() as date)');
      Query.Sql.Add('Group by RR.Data, Convert(Varchar(2), RR.Hora) )');
      Query.Sql.Add('');
      Query.Sql.Add(', Advertencia as (select R.data,R.Hora, Coalesce(COUNT(RR.IdReq), 0) TotalAdv');
      Query.Sql.Add('From Req R');
      Query.Sql.Add('Left Join RequestResponse RR on Convert(Varchar(2), RR.Hora) = R.Hora and RR.data = R.Data');
      Query.Sql.Add('     and RR.RespStatus > 299 and RR.responsestr = '+#39+'[{"Erro":"Sem Dados para a consulta."}]'+#39);
      Query.Sql.Add('Group by R.Data, R.Hora');
      Query.Sql.Add(')');
      Query.Sql.Add('');
      Query.Sql.Add(', Erro as (select R.data, R.Hora, Coalesce(COUNT(RR.IdReq), 0) TotalErro');
      Query.Sql.Add('From Req R');
      Query.Sql.Add('Left Join RequestResponse RR on Convert(Varchar(2), RR.Hora) = R.Hora and RR.data = R.Data');
      Query.Sql.Add('     and RR.RespStatus > 299 and RR.RespStatus > 299 and responsestr <> '+#39+'[{"Erro":"Sem Dados para a consulta."}]'+#39);
      Query.Sql.Add('Group by R.Data, R.Hora )');
      Query.Sql.Add('');
      Query.Sql.Add('select R.*, Adv.TotalAdv, Err.TotalErro');
      Query.Sql.Add('From Req R');
      Query.Sql.Add('Left join Advertencia Adv On Adv.Hora = R.Hora');
      Query.Sql.Add('Left join Erro Err On Err.Hora = R.Hora');
      Query.SQL.Add('Order by R.Hora');
      Query.Open();
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('MonitorLog_DashBoard.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', tuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Processo: MonitorLog/DashBoard - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceMonitorLog.DeleteLog(pIdReq: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add('Delete RequestResponse where IdReq = ' + pIdReq.ToString());
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Registro(' + pIdReq.ToString() + ') excluído com sucesso!'));
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Processo: MonitorLog/DeleteLog - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TServiceMonitorLog.Destroy;
begin
  inherited;
end;

function TServiceMonitorLog.GetListaLog(pIdReq, pUsuarioId: Integer; pDataInicial, pDataFinal: TDateTime; pTerminal, pIpClient, pPorta: String; pStatusCode: Integer; pUrl, pVerbo : String): TjSonArray;
var JsonRetorno: TJsonObject;
    FIndexConnExact: Integer;
    ArqIni: TIniFile;
    BdeXactWMS: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
{
       if fileexists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.Ini') then Begin
          ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance))+'eXactWMS.Ini');
          BdeXactWMS := ArqIni.ReadString('BD', 'DataBase', 'eXactWMSBad');
          ArqIni.Free;
       End
       Else
          raise Exception.Create('Arquivo de configuração do banco de dados inexistente!');

}      Query.Sql.Add('select RR.*, U.Nome, RR.RespStatus As statuscode');
      Query.Sql.Add('From RequestResponse RR');
      Query.Sql.Add('Left Join ' + BdeXactWMS + '.Dbo.Usuarios U On U.UsuarioId = RR.UsuarioId');
      Query.Sql.Add('Where 1=1');
      If pIdReq <> 0 then Begin
         Query.Sql.Add(' And RR.IdReq = :pIdReq');
         Query.ParamByName('pIdReq').Value := pIdReq;
      End;
      If pUsuarioId <> 0 then Begin
         Query.Sql.Add(' And RR.UsuarioId = :pUsuarioId');
         Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      End;
      If pDataInicial <> 0 Then Begin
         Query.Sql.Add(' And RR.Data >= :pDataInicial');
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      End;
      If pDataFinal <> 0 Then Begin
         Query.Sql.Add(' And RR.Data <= :pDataFinal');
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', pDataFinal);
      End;
      If pTerminal <> '' Then Begin
         Query.Sql.Add(' And RR.Terminal like :pTerminal');
         Query.ParamByName('pTerminal').Value := '%' + pTerminal + '%';
         Query.Sql.Add('--pTerminal = ' + '%' + pTerminal + '%');
      End;
      If pPorta <> '' Then Begin
         Query.Sql.Add(' And RR.Port = :pPort');
         Query.ParamByName('pPort').Value := pPorta;
      End;
      If pStatusCode <> 0 Then Begin
         Query.Sql.Add(' And RR.Status = :pStatus');
         Query.ParamByName('pStatus').Value := pStatusCode;
      End;
      If pUrl <> '' Then Begin
         Query.Sql.Add(' And RR.Url like :pUrl');
         Query.ParamByName('pUrl').Value := '%' + pUrl + '%';
      End;
      If pVerbo <> '' Then Begin
         Query.Sql.Add(' And RR.Verbo = :pVerbo');
         Query.ParamByName('pVerbo').Value := pVerbo;
      End;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('MonitorLog.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', tuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Processo: MonitorLog/GetListaLog - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
