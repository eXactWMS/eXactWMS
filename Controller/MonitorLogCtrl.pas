unit MonitorLogCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     UsuarioClass, Rest.Json, System.Json, Rest.Types;

Type
  TMonitorLogCtrl = Class
  Private
    //Funções de Validação
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function GetListaLog(pIdReq, pUsuarioId: Integer; pDataInicial, pDataFinal : TDateTime;
         pTerminal, pIpClient, pPorta: String; pStatusCode: Integer; pUrl : String) : tJsonArray; //TObjectList<TUsuario>;
    Function DeleteLog(pIdReq : Integer) : TjsonArray;
  End;

implementation

{ TMonitorLogCtrl }

uses uDmeXactWMS, uFrmeXactWMS, uFuncoes;

constructor TMonitorLogCtrl.Create;
begin
//
end;

function TMonitorLogCtrl.DeleteLog(pIdReq: Integer): TjsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.Resource := 'v1/monitorlog/delete/{idreq}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('idreq', pIdReq.ToString());
  DmeXactWMS.RestRequestWMS.Params.AddHeader('usuario', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
  {$IfDef Android}
     DmeXactWMS.RestRequestWMS.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
  {$else}
     DmeXactWMS.RestRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
  {$Endif}
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

destructor TMonitorLogCtrl.Destroy;
begin
//
  inherited;
end;

function TMonitorLogCtrl.GetListaLog(pIdReq : Integer; pUsuarioId: Integer; pDataInicial, pDataFinal : TDateTime;
  pTerminal, pIpClient, pPorta: String; pStatusCode: Integer; pUrl : String): tJsonArray;
Var vResourceURI : String;
begin
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/monitorlog/lista?';
  DmeXactWMS.RestRequestWMS.Params.AddHeader('usuario', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
  {$IfDef Android}
     DmeXactWMS.RestRequestWMS.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
  {$else}
     DmeXactWMS.RestRequestWMS.Params.AddHeader('terminal', NomeDoComputador);
  {$Endif}
  if pIdReq <> 0 then
     vResourceURI := vResourceURI+'&idreq='+pIdReq.ToString();
  if pUsuarioId <> 0 then
     vResourceURI := vResourceURI+'&usuarioid='+pusuarioId.ToString();
  if pDataInicial <> 0 then
     vResourceURI := vResourceURI+'&datainicial='+DateToStr(pDataInicial);
  if pDataFinal <> 0 then
     vResourceURI := vResourceURI+'&datafinal='+DateToStr(pDataFinal);
  if pTerminal <> '' then
     vResourceURI := vResourceURI+'&terminal='+pTerminal;
  if pIpClient <> '' then
     vResourceURI := vResourceURI+'&ipclient='+pIpClient;
  if pPorta <> '' then
     vResourceURI := vResourceURI+'&porta='+pPorta;
  if pStatusCode <> 0 then
     vResourceURI := vResourceURI+'&statuscode='+pStatusCode.ToString();
  if pUrl <> '' then
     vResourceURI := vResourceURI+'&url='+pUrl;
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
end;

end.
