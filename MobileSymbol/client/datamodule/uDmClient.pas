unit uDmClient;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client, FMX.Dialogs,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf, System.UITypes,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.Generics.Collections,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DSClientRest,
  IdBaseComponent, IdComponent, IdTCPConnection, Data.FireDACJSONReflect,
  IdTCPClient, uTCaixa, Data.DbxJsonReflect, uTSaida, uTSeparacaoVolumeCaixa,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.UI.Intf, System.JSON,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, System.JSON.Readers,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, System.JSON.Types,
  uTHistorico, uRetorno, Rest.Json, FireDAC.Comp.UI, REST.Authenticator.Basic,
  uTProdutoColetor, uTEnderecoColetor, REST.Types, REST.Response.Adapter,
  FireDAC.Phys.SQLiteWrapper.Stat
  {$IFDEF ANDROID}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os
    ,Androidapi.JNI.Telephony //Sms
  {$Endif};

type
  TdmClient = class(TDataModule)
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    QryVolumeProduto: TFDQuery;
    DSRestConnection1: TDSRestConnection;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FdWmsSqlLite: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QryTemp: TFDQuery;
    QrySaveSeparacaoProduto: TFDQuery;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    QryLimparSqLite: TFDQuery;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    QryCargaDestinatario: TFDQuery;
    QryCargaPedido: TFDQuery;
    QryCargaVolume: TFDQuery;
  private
    { Private declarations }
    Function CheckReturnREST : Boolean;
    function Historico(vgHistorico: THistorico): TRetorno;
  public
    { Public declarations }
    Procedure ResetREST;
    Class Function ServidorAtivo(pHost, pPort : String) : Boolean;
    Function GetCaixa(CdCaixa : Int64) : TCaixa;
    Function GetEndereco(CdEndereco : Integer; NmEndereco : String) : TEnderecoColetor;
    Function GetVolume(CdVolume : Int64) : TSaidaVolume;
    Function GetVolumeCaixa(pCdVolume : Int64; pCdCaixa : Integer) : TRetorno;
    Function GetProduto(CdProduto : String; NmProduto : String = '') : TProdutoColetor;
    Function GetPickingProduto(CdEndereco : Integer; NmEndereco : String) : TProdutoColetor;
    Function GetSeparacaoVolume(CdCaixa : Integer) : TSeparacaoVolumeCaixa;
    Function GetSeparacaoVolumeItens(pCdVolume : Int64) :  TFDJSONDataSets;
    Procedure RegistrarStatusVolume(CdVolume : Int64; pStatusVolume: StatusVolume; vgHistorico: THistorico);
    Function bloquearCaixaSeparacao(pObjSeparacaoVolumeCaixa : TSeparacaoVolumeCaixa) : TRetorno;
    Function FinalizarSeparacao(pObjSeparacaoVolumeCaixa : TSeparacaoVolumeCaixa; vgHistorico: THistorico) : TRetorno;

    Function GetvProdSaiProcessamento : TFDJSONDataSets;
    Function GetEstoqueCrossdocking(pCdProduto : Int64) : TFDJSONDataSets;
    Function GetEstoqueProducao(pCdProduto : Int64; pNmEndereco : String = '') : TFDJSONDataSets;
    Function GetEstoqueEspera(pCdProduto : Int64) : TFDJSONDataSets;
    Function GetSalvarMovimentacaoPF(TpMovimento, CdEnderecoDestino, CdEnderecoOrigem, CdLotePF,
                                     QtMovPF : Integer; NmUsuario : String) : TRetorno;
    Function GetSaida(pCdSaida : Int64; pData : String) : TJSONArray;  //TSaida;
    Function GetParametro(pCdParametro : Integer) : String; OverLoad;
    Function GetParametro(pNmParametro : String) : String; OverLoad;
    Function GetValidarFuncao(pCdUsuario, pCdFuncao : Integer) : TJSONArray;
    Function CancelarVolumeSeparacao(pCdVolume : Int64) : Boolean;
    Function CriarVolumeExtra(pCdVolume : Int64) : String;
    Function GetLotesProdutos(pCdProduto : Int64) : tJSONArray;
    Function GetPickUsed(pCdProduto : Int64; pNmEndereco : String) : tJsonArray;
    Function AtualizarLotesReserva(LstLotes : tJsonArray) : Boolean;

    Function GetListInventarioPend : TFdMemTable;
    Function GetListInvEndereco(pCodInventario : Integer) : tJsonArray;
    Function GetListInvEstoqProdEnd(pLocalizacao : String; PCdProduto : Int64; pCodInventario : Integer) : tJsonArray;
    Function GetListInvEndContagem(pCodInventario : Integer; pLocalizacao : String) : tJsonArray;
    Function SendContagemInventario(pJson : tJsonArray) : Boolean;
    Function SalvarProduto(pJsonProduto : TJsonObject) : Boolean;

    Function GetPedidoVolumeExpedicao(pPedidoVolumeId, pProcessoId, pUsuarioId : Integer; pEstacao : String)  : TJsonArray;
    Function GetVolumeeXact(pPedidoVolumeId : Integer) : TJsonArray;
    Function VolumeExpedicao : TJsonArray;
    Function GetEmbalagemSeparacaoVolume(pEmbalagemId, pPedidoVolumeId, pOperacao : Integer) : TJsonArray;
    Function GetCaixaEmbalagem(pEmbalagemId : Integer) : TJsonArray;
    Function BuscarVolumeProdutosParaSeparacao(pPedidoId, pPedidoVolumeId : Integer) : TJsonArray;
    Function GetProdutoEan(pCodigoEan : String) : Integer;
    Function RegistrarAberturaSeparacao(Const pVolumeSeparacaoId : Integer; Const pJsonSeparacao : TJsonObject) : TJsonObject;

    Function GetVolumeProdutoLotes(pPedidoVolumeId, pProdutoid : Integer) : TJsonArray;
    Function GetConfig : TJsonArray;
    Function SaveApanheProduto(pJsonApanhe : TJsonArray) : TJsonArray;
    Function RegistrarDocumentoEtapa(pPedidoVolumeId, pDocumentoEtapaId : Integer) : TJsonArray;
    Function GetVolumeProdutos(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetCodProdEan(pCodProdEan : String) : TJsonObject;
    Function AtualizarConferencia( pJsonArray : TJsonArray) : TJsonArray;
  end;

var
  dmClient: TdmClient;

Const Ok200 = 200;
Const Ok201 = 201;
Const Ok303 = 303;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmClient }

Uses uFuncoes, uFrmeXactWMS;

Function TdmClient.GetPedidoVolumeExpedicao(pPedidoVolumeId, pProcessoId, pUsuarioId : Integer; pEstacao : String)  : TJsonArray;
Var JsonDocumento : TJsonObject;
begin
  JsonDocumento := tJsonObject.Create;
  JsonDocumento.AddPair('pedidovolumeid', TJsonNumber.Create(pPedidoVolumeId));
  JsonDocumento.AddPair('processoid', TJsonNumber.Create(pProcessoId));
  JsonDocumento.AddPair('usuarioid', TJsonNumber.Create(pUsuarioId));
  {$IfDef Android}
     JsonDocumento.AddPair('estacao', IMEI); //IMEI;
  {$else}
     JsonDocumento.AddPair('estacao', NomeDoComputador);
  {$ENdif}
  RestRequest1.ClearBody;
  RestRequest1.AddBody(jSonDocumento.ToJson, ContentTypeFromString('application/json'));
  RESTRequest1.Resource := 'v1/pedidovolume/registrardocumentoetapacombaixaestoque';
  RESTRequest1.Method := rmPOST;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);
  JsonDocumento.Free;
End;

function TdmClient.GetSeparacaoVolumeItens(pCdVolume: Int64): TFDJSONDataSets;
Var unMarshal  : TJsonUnmarshal;
 // LDataSetList : TFDJSONDataSets;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetVolumeSeparacao/{CdVolume}';
  RESTRequest1.Params.AddUrlSegment('CdVolume', pCdVolume.ToString);
  RESTRequest1. Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TFDJSONDataSets;
  End;
end;

function TdmClient.AtualizarConferencia(pJsonArray: TJsonArray): TJsonArray;
begin
  ResetRest;
  RestRequest1.ClearBody;
  RestRequest1.AddBody(pJsonArray.ToJson, ContentTypeFromString('application/json'));
  RestRequest1.Resource := 'v1/pedidovolume/atualizarconferencia';
  RestRequest1.Method := rmPUT;
  RestRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJsonArray
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);

end;

function TdmClient.AtualizarLotesReserva(LstLotes: tJsonArray): Boolean;
//Var jSonObj : tJsonObject;
//begin
//  jSonObj := tJsonObject.Create;
//  jSonObj := LstLotes.Items[0] as TJSONObject;
//  ShowMessage(jSonObj.Get('CdLote').JsonValue.Value+'  '+jSonObj.Get('CdLote').JsonValue.Value);
//  showmessage(LstLotes.ToJSON);

Var vMarshall          : TJsonMarshal;
    jValueObjSeparacao : TJSonValue;
    unMarshal : TJSONUnMarshal;
    Teste : String;
begin
  Result := False;
  ResetREST;
  vMarshall := TJsonMarshal.Create();
  jValueObjSeparacao    := vMarshall.Marshal(LstLotes);
  RESTRequest1.Resource := 'AtualizarLotesReserva';
  RestRequest1.ClearBody;
  RestRequest1.AddBody(LstLotes.ToJSON, ContentTypeFromString('application/json'));
  RESTRequest1.Method := rmPOST;
  Try
    RESTRequest1.Execute;
    if CheckReturnREST then Begin
       unMarshal := TJSONUnMarshal.Create;
    End;
    Result := True;
  Except on E: Exception do
    raise Exception.Create('Erro: Ajustar Lote.'+E.Message);
  End;
  vMarshall.DisposeOf;
  jValueObjSeparacao.DisposeOf;
  vMarshall := Nil;
  jValueObjSeparacao := Nil;

end;

function TdmClient.bloquearCaixaSeparacao(pObjSeparacaoVolumeCaixa: TSeparacaoVolumeCaixa): TRetorno;
Var vMarshall          : TJsonMarshal;
    jValueObjSeparacao : TJSonValue;
    unMarshal : TJSONUnMarshal;
begin
  ResetREST;
  vMarshall := TJsonMarshal.Create();
  jValueObjSeparacao    := vMarshall.Marshal(pObjSeparacaoVolumeCaixa);
  RESTRequest1.Resource := 'bloquearCaixaSeparacao';
  RestRequest1.ClearBody;
  RestRequest1.AddBody(jValueObjSeparacao.ToString, ContentTypeFromString('application/json'));
  RESTRequest1.Method := rmPOST;
  Try
    RESTRequest1.Execute;
    if CheckReturnREST then Begin
       unMarshal := TJSONUnMarshal.Create;
       Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TRetorno;
    End;
  Except on E: Exception do
    raise Exception.Create('Erro: Bloquear Caixa Separação! '+E.Message);
  End;
  vMarshall.DisposeOf;
  jValueObjSeparacao.DisposeOf;
  vMarshall := Nil;
  jValueObjSeparacao := Nil;
end;

function TdmClient.BuscarVolumeProdutosParaSeparacao(pPedidoId, pPedidoVolumeId: Integer): TJsonArray;
begin
  ResetRest;
  if (pPedidoId = 0) and (pPedidoVolumeId<>0) then Begin
     //RESTRequest1.Resource := 'v1/pedidovolumeseparacao/{pedidovolumeid}';
     RESTRequest1.Resource := 'v1/pedidovolume/produtoseparacao/{pedidovolumeid}';
     RESTRequest1.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  End
  Else Begin
     RESTRequest1.Resource := 'v1/pedidovolumeseparacao/{pedidoid}/{pedidovolumeid}';
     RESTRequest1.Params.AddUrlSegment('pedidoid', pPedidoId.ToString());
     RESTRequest1.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  End;
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) or
     (RESTResponse1.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := RESTResponse1.JSONValue as tjsonArray;
  End
  Else
    raise Exception.Create('Erro: '+(RESTResponse1.JSONValue as TJsonObject).GetValue<String>('Resultado'));
end;

function TdmClient.CancelarVolumeSeparacao(pCdVolume: Int64): Boolean;
begin
  Result := False;
  ResetREST;
  DmClient.RESTRequest1.Resource := 'CancelarVolumeSeparacao/{pCdVolume}';
  DmClient.RESTRequest1.Params.AddUrlSegment('pCdVolume', pCdVolume.ToString());
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  Result := RESTResponse1.StatusCode = 200;
end;

function TdmClient.CheckReturnREST: Boolean;
begin
  Result := False;
  if (dmClient.RESTResponse1.StatusCode = Ok200) or
     (dmClient.RESTResponse1.StatusCode = Ok201) Then
//     (dmClient.RESTResponse1.StatusCode = Ok303) then
     Result := True
  Else
  MessageDlg(ReturnREST(DmClient.RESTResponse1.StatusCode)+#13+RESTResponse1.StatusText, TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbOK], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = mrOk then
           Exit;
      end
    );
end;

function TdmClient.CriarVolumeExtra(pCdVolume: Int64): String;
Var   SR: TStringReader;
  JR: TJsonTextReader;
begin
  ResetREST;
  DmClient.RESTRequest1.Resource := 'CriarVolumeExtra/{pCdVolume}';
  DmClient.RESTRequest1.Params.AddUrlSegment('pCdVolume', pCdVolume.ToString());
  DmClient.RESTRequest1.Method := RmPut;
  RESTRequest1.Execute;
  If RESTResponse1.StatusCode = 200 then Begin
     SR := TStringReader.Create(RESTResponse1.Content);
     JR := TJsonTextReader.Create(SR);
     try
       try
         while JR.Read do
           if JR.TokenType = TJsonToken.PropertyName then Begin
             if JR.Value.ToString = 'Volume' then begin
               JR.Read;
               Result := JR.Value.ToString;
             end;
           end;
       finally
         JR.Free;
       end;
     finally
       SR.Free;
     end;
  End
  else
     Result := '';
End;

Function TDmClient.Historico(vgHistorico : THistorico) : TRetorno;
Var vMarshall : TJsonMarshal;
    jValueObjHistorico : TJSonValue;
//    unMarshal : TJSONUnMarshal;
Begin
  ResetREST;
  vMarshall  := TJsonMarshal.Create();
  jValueObjHistorico    := vMarshall.Marshal(vgHistorico);
  RESTRequest1.Resource := 'Historico';
  RestRequest1.ClearBody;
  RestRequest1.AddBody(jValueObjHistorico.ToString, ContentTypeFromString('application/json'));
  RESTRequest1.Method := rmPUT;
  Try
    RESTRequest1.Execute;
    if CheckReturnREST then Begin
//       unMarshal := TJSONUnMarshal.Create;
//       Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TRetorno;
    End;
  Except On E : Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
  vMarshall.DisposeOf;
  jValueObjHistorico := Nil;
  jValueObjHistorico.DisposeOf;
  vMarshall := Nil;
End;

Function TdmClient.FinalizarSeparacao(
  pObjSeparacaoVolumeCaixa: TSeparacaoVolumeCaixa; vgHistorico: THistorico) : TRetorno;
Var vMarshall : TJsonMarshal;
    jValueObjSeparacao : TJSonValue;
    unMarshal : TJSONUnMarshal;
Begin
  ResetREST;
  vMarshall  := TJsonMarshal.Create();
  jValueObjSeparacao    := vMarshall.Marshal(pObjSeparacaoVolumeCaixa);
  RESTRequest1.Resource := 'FinalizarSeparacao';
  RestRequest1.ClearBody;
  RestRequest1.AddBody(jValueObjSeparacao.ToString, ContentTypeFromString('application/json'));
  RESTRequest1.Method   := rmPOST;
  Try
    RESTRequest1.Execute;
    if CheckReturnREST then Begin
       unMarshal := TJSONUnMarshal.Create;
       Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TRetorno;
       if vgHistorico.Observacao = 'Separado' then
          Historico(vgHistorico);
    End;
  Except On E : Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
  vMarshall.DisposeOf;
  jValueObjSeparacao.DisposeOf;
  vMarshall := Nil;
  jValueObjSeparacao := Nil;
end;

function TdmClient.GetCaixa(CdCaixa : Int64) : TCaixa;
Var unMarshal : TJsonUnmarshal;
begin
  Result := Nil;
  ResetREST;
  RESTRequest1.Resource := 'GetCaixa/{CdCaixa}';
  RESTRequest1.Params.AddUrlSegment('CdCaixa', CdCaixa.ToString);
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  If CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TCaixa;
  End;
end;

function TdmClient.GetCaixaEmbalagem(pEmbalagemId: Integer): TJsonArray;
Begin
  Result := TJsonArray.Create;
  ResetRest;
  if (pEmbalagemId = 0) Then
     RESTRequest1.Resource := 'v1/caixaembalagem'
  Else Begin
    RESTRequest1.Resource := 'v1/caixaembalagem/{caixaembalagemid}';
    RESTRequest1.Params.AddUrlSegment('caixaembalagemid', pEmbalagemId.ToString());
  End;
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
//  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
  if (RESTResponse1.StatusCode in [ 200, 201]) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+RESTResponse1.StatusText);
end;

Function TdmClient.GetCodProdEan(pCodProdEan: String): TJsonObject;
begin
  Try
    ResetRest;
    RESTRequest1.Resource := 'v1/produto/pesquisar/{codprodean}';
    RESTRequest1.Params.AddUrlSegment('codprodean', pCodProdEan);
    RESTRequest1.Method := RmGet;
    RESTRequest1.Execute;
    Result := RESTResponse1.JSONValue as tjsonObject;
  Except On E: Exception Do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

function TdmClient.GetConfig: TJsonArray;
begin
  RESTRequest1.Resource := 'v1/configuracao';
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);
end;

function TdmClient.GetEndereco(CdEndereco: Integer;
  NmEndereco: String): TEnderecoColetor;
Var unMarshal  : TJsonUnmarshal;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetEndereco/{pCdEndereco}/{pNmEndereco}';
  RESTRequest1.Params.AddUrlSegment('pCdEndereco', CdEndereco.ToString());
  RESTRequest1.Params.AddUrlSegment('pNmEndereco', NmEndereco);
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TEnderecoColetor;
  End;
end;

function TdmClient.GetEstoqueCrossdocking(pCdProduto: Int64): TFDJSONDataSets;
Var unMarshal  : TJsonUnmarshal;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetEstoqueCrossDocking/{CdProduto}';
  RESTRequest1.Params.AddUrlSegment('CdProduto', pCdProduto.ToString());
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TFDJSONDataSets;
  End;
end;

function TdmClient.GetEstoqueEspera(pCdProduto: Int64): TFDJSONDataSets;
Var unMarshal  : TJsonUnmarshal;
 // LDataSetList : TFDJSONDataSets;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetEstoqueEspera/{CdProduto}';
  RESTRequest1.Params.AddUrlSegment('CdProduto', pCdProduto.ToString());
  RESTRequest1.Method   := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TFDJSONDataSets;
  End;
end;

function TdmClient.GetEstoqueProducao(pCdProduto: Int64; pNmEndereco : String): TFDJSONDataSets;
Var unMarshal  : TJsonUnmarshal;
 // LDataSetList : TFDJSONDataSets;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetEstoqueProducao/{CdProduto}/{NmEndereco}';
  RESTRequest1.Params.AddUrlSegment('CdProduto', pCdProduto.ToString());
  RESTRequest1.Params.AddUrlSegment('NmEndereco', pNmEndereco);
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TFDJSONDataSets;
  End;
end;

function TdmClient.GetListInvEndContagem(pCodInventario: Integer;
  pLocalizacao: String): tJsonArray;
Var unMarshal : TJsonUnmarshal;
    jArr      : TJSONArray;
Begin
  Result := Nil;
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  DmClient.RESTRequest1.Resource := 'ListInvEndContagem/{pCodInventario}/{pLocalizacao}';
  DmClient.RESTRequest1.Params.AddUrlSegment('pCodInventario', pCodInventario.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('pLocalizacao', pLocalizacao);
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
end;

function TdmClient.GetListInvEndereco(pCodInventario : Integer) : tJsonArray;
Var unMarshal : TJsonUnmarshal;
    jArr      : TJSONArray;
Begin
  Result := Nil;
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  DmClient.RESTRequest1.Resource := 'ListInvEndereco/{pCodInventario}';
  DmClient.RESTRequest1.Params.AddUrlSegment('pCodInventario', pCodInventario.ToString());
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
end;

function TdmClient.GetListInventarioPend: TFdMemTable;
begin
  Result := TFdMemTable.Create(Nil);
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTResponseDataSetAdapter1.DataSet  := Result;
  RESTResponseDataSetAdapter1.Response := RestResponse1;
  DmClient.RESTRequest1.Resource := 'ListInventarioPend';
//  DmClient.RESTRequest1.Params.AddUrlSegment('CdProduto', pCdProduto.ToString());
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
//     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
  End;
end;

function TdmClient.GetListInvEstoqProdEnd(pLocalizacao: String;
  PCdProduto: Int64; pCodInventario: Integer): tJsonArray;
Var unMarshal : TJsonUnmarshal;
    jArr      : TJSONArray;
Begin
  Result := Nil;
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  DmClient.RESTRequest1.Resource := 'ListInvEstoqProdEnd/{pLocalizacao}/{pCdProduto}/{pCodInventario}';
  DmClient.RESTRequest1.Params.AddUrlSegment('pLocalizacao', pLocalizacao);
  DmClient.RESTRequest1.Params.AddUrlSegment('pCdProduto', pCdProduto.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('pCodInventario', pCodInventario.ToString());
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
end;

function TdmClient.GetLotesProdutos(pCdProduto: Int64): tJSONArray;
begin
  Result := Nil;
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  DmClient.RESTRequest1.Resource := 'GetLotesProdutos/{CdProduto}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdProduto', pCdProduto.ToString());
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
  End;
end;

function TdmClient.GetParametro(pCdParametro: Integer): String;
begin
  ResetREST;
  DmClient.RESTRequest1.Resource := 'GetParametro/{CdParametro}/{NmParametro}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdParametro', pCdParametro.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('NmParametro', '');
  DmClient.RESTRequest1.Method := RmGet;
  DmClient.RESTRequest1.Execute;
  if CheckReturnREST then Begin
     Result := StringReplace(DmClient.RESTResponse1.JSONText, '"', '',[rfReplaceAll]);
  End;
end;

function TdmClient.GetParametro(pNmParametro: String): String;
begin
  ResetREST;
  DmClient.RESTRequest1.Resource := 'GetParametro/{CdParametro}/{NmParametro}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdParametro', '0');
  DmClient.RESTRequest1.Params.AddUrlSegment('NmParametro', pNmParametro);
  DmClient.RESTRequest1.Method := RmGet;
  DmClient.RESTRequest1.Execute;
  if CheckReturnREST then Begin
     Result := StringReplace(DmClient.RESTResponse1.JSONText, '"', '',[rfReplaceAll]);
  End;
end;

function TdmClient.GetPickingProduto(CdEndereco: Integer;
  NmEndereco: String): TProdutoColetor;
Var unMarshal : TJsonUnmarshal;
begin
  ResetREST;
  DmClient.RESTRequest1.Resource := 'GetPickingProduto/{CdEndereco}/{NmEndereco}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdEndereco', CdEndereco.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('NmEndereco', NmEndereco);
  DmClient.RESTRequest1.Method := RmGet;
  DmClient.RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TProdutoColetor;
  End;
end;

function TdmClient.GetPickUsed(pCdProduto: Int64;
  pNmEndereco: String): tJsonArray;
Var jArr      : TJSONArray;
begin
  Result := Nil;
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  DmClient.RESTRequest1.Resource := 'GetPickUsed/{CdProduto}/{NmEndereco}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdProduto', pCdProduto.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('NmEndereco', pNmEndereco);
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
  End;
end;

function TdmClient.GetProduto(CdProduto: String; NmProduto : String): TProdutoColetor;
Var unMarshal : TJsonUnmarshal;
    JsonArrayProduto : TJsonArray;
    vErro : String;
begin
  Try
  ResetREST;
  Except

  End;
  DmClient.RESTRequest1.Resource := 'v1/produto/codigoerp/{codigoerp}';
  DmClient.RESTRequest1.Params.AddUrlSegment('codigoerp', CdProduto); //.ToString());
//  DmClient.RESTRequest1.Params.AddUrlSegment('pNmProduto', NmProduto); //.ToString());
//  DmClient.RESTRequest1.Params.AddUrlSegment('Status', '0');
  DmClient.RESTRequest1.Method := RmGet;
  DmClient.RESTRequest1.Execute;
  if CheckReturnREST then Begin
//     unMarshal := TJSONUnMarshal.Create;
//     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TProdutoColetor;
     JsonArrayProduto := DmClient.RESTResponse1.JSONValue as TJSONArray;
     if JsonArrayProduto.Get(0).TryGetValue('Erro', vErro) then
        raise Exception.Create(vErro);
     Result := TProdutoColetor.Create;
     Result.ProdutoId   := JsonArrayProduto.Items[0].GetValue<Integer>('idProduto');
     Result.Codigo      := JsonArrayProduto.Items[0].GetValue<Integer>('codProduto');
     Result.Descricao   := JsonArrayProduto.Items[0].GetValue<String>('descricao');
     Result.Embalagem   := JsonArrayProduto.Items[0].GetValue<Integer>('fatorConversao');
     Result.Altura      := JsonArrayProduto.Items[0].GetValue<Double>('altura');
     Result.Largura     := JsonArrayProduto.Items[0].GetValue<Double>('largura');
     Result.Comprimento := JsonArrayProduto.Items[0].GetValue<Double>('comprimento');
     Result.Volume      := JsonArrayProduto.Items[0].GetValue<Double>('volume');
     Result.Peso        := JsonArrayProduto.Items[0].GetValue<Double>('peso');
     Result.Liquido     := JsonArrayProduto.Items[0].GetValue<Integer>('liquido') = 1;
     Result.EstoqueMinimo   := 1;
     Result.EstoqueMaximo   := 1;
     Result.QtdEstoque      := 0;
     Result.QtdCrosDocking := 0;
     Result.ValidadeMinimaEntrada     := JsonArrayProduto.Items[0].GetValue<Integer>('mesEntradaMinima');
     Result.DataValidadeMinimaEntrada := Now()+JsonArrayProduto.Items[0].GetValue<Integer>('mesSaidaMinima');
     Result.ValidadeMinimaSaida       := JsonArrayProduto.Items[0].GetValue<Integer>('mesSaidaMinima');
     Result.DataValidadeMinimaSaida   := Now()+JsonArrayProduto.Items[0].GetValue<Integer>('mesSaidaMinima');
  //    FFabricante: TFabricante;
     Result.Controle.Codigo := (JsonArrayProduto.Items[0].GetValue<TJsonObject>('rastro')).GetValue<Integer>('rastroId');
     Result.Controle.Nome   := (JsonArrayProduto.Items[0].GetValue<TJsonObject>('rastro')).GetValue<String>('descricao');
     Result.CodigoEndereco  := (JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco')).GetValue<Integer>('enderecoId');
     Result.Endereco        :=  TEnderecoColetor.Create;
     Result.Endereco.Codigo := (JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco')).GetValue<Integer>('enderecoId');
     Result.Endereco.Endereco := (JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco')).GetValue<string>('descricao');
     Result.Endereco.EnderecoFormatado((JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco')).GetValue<TJsonObject>('enderecoEstrutura').GetValue<String>('mascara'));

//     Result.CodigoEnderecoAntigo := 0;
//     Result.EnderecoAntigo: TEnderecoColetor;
//     Result.EAN: string;
//     Result.QtdEAN: Integer;
  End;
end;

function TdmClient.GetProdutoEan(pCodigoEan: String): integer;
begin
  ResetRest;
  RESTRequest1.Resource := 'v1/produto/pesquisar/{codprodean}';
  RESTRequest1.Params.AddUrlSegment('codprodean', pCodigoEan);
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode in [200, 201, 204]) Then
     Result := (RESTResponse1.JSONValue as tjsonObject).GetValue<Integer>('produtoid', 0)
  Else
     raise Exception.Create(RESTResponse1.Content);
end;

function TdmClient.GetSaida(pCdSaida: Int64; pData : String): TJSONArray; //TSaida;
Var unMarshal : TJsonUnmarshal;
    jArr      : TJSONArray;
begin
  Result := Nil;
  ResetREST;
  RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  DmClient.RESTRequest1.Resource := 'GetSaida/{CdSaida}/{pDtSaida}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdSaida', pCdSaida.ToString());
  if pData <> '' then pData := StringReplace(pData, '/', '-', [rfReplaceAll]);
  DmClient.RESTRequest1.Params.AddUrlSegment('pDtSaida', pData);
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
//                            RESTResp.JSONValue as TJSONArray;
//     unMarshal := TJSONUnMarshal.Create;
//     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TSaida;
  End;
end;

function TdmClient.GetSalvarMovimentacaoPF(TpMovimento, CdEnderecoDestino,
  CdEnderecoOrigem, CdLotePF, QtMovPF : Integer; NmUsuario: String): TRetorno;
Var unMarshal : TJsonUnmarshal;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetSalvarMovimentacaoPF/{TpMovimento}/{CdEnderecoDestino}/'+
                                    '{CdEnderecoOrigem}/{CdLotePF}/{QtMovPF}/{NmUsuario}';
  RESTRequest1.Params.AddUrlSegment('TpMovimento', TpMovimento.ToString());
  RESTRequest1.Params.AddUrlSegment('CdEnderecoDestino', CdEnderecoDestino.ToString());
  RESTRequest1.Params.AddUrlSegment('CdEnderecoOrigem', CdEnderecoOrigem.ToString());
  RESTRequest1.Params.AddUrlSegment('CdLotePF', CdLotePF.ToString());
  RESTRequest1.Params.AddUrlSegment('QtMovPF', QtMovPF.ToString());
  RESTRequest1.Params.AddUrlSegment('NmUsuario', NmUsuario);
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TRetorno;
  End;
end;

function TdmClient.SalvarProduto(pJsonProduto: TJsonObject): Boolean;
begin
  ResetREST;
  RESTRequest1.Resource := 'v1/produto/salvarcoletor';
  RESTRequest1.ClearBody;
  RESTRequest1.AddBody(pJsonProduto.ToJson, ContentTypeFromString('application/json'));
  RESTRequest1.Method := RmPut;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := True
  Else
     Result := False;
end;

function TdmClient.SaveApanheProduto(pJsonApanhe: TJsonArray): TJsonArray;
begin
//  {$IfDef Android}
//     pJsonApanhe.AddPair('estacao', IMEI); //IMEI;
//  {$else}
//     pJsonApanhe.AddPair('estacao', NomeDoComputador);
//  {$ENdif}
  ResetRest;
  RestRequest1.ClearBody;
  RestRequest1.AddBody(pJsonApanhe.ToJson, ContentTypeFromString('application/json'));
  RESTRequest1.Resource := 'v1/pedidovolume/saveapanheprodutos';
  RESTRequest1.Method := rmPUT;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode in [200,201, 204]) Then
     Result := RESTResponse1.JSONValue as tjsonArray
  Else
    raise Exception.Create('Erro: Salvar Apanhe no servidor!');
end;

function TdmClient.SendContagemInventario(pJson: tJsonArray): Boolean;
Var vMarshall          : TJsonMarshal;
    jValueContagem : TJSonValue;
    unMarshal : TJSONUnMarshal;
begin
  Result := False;
  ResetREST;
  vMarshall := TJsonMarshal.Create();
  jValueContagem    := vMarshall.Marshal(pJson);
  DmClient.RESTRequest1.Resource := 'SendContagemInventario';
  RestRequest1.ClearBody;
  RestRequest1.AddBody(pJson.ToJSON, ContentTypeFromString('application/json'));
//  DmClient.RESTRequest1.Params.AddUrlSegment('pJson', pJson);
  DmClient.RESTRequest1.Method := RmPost; //RmGet;
  RESTRequest1.Execute;
  Result := RESTResponse1.StatusCode = 200;
end;

function TdmClient.GetSeparacaoVolume(CdCaixa : Integer) : TSeparacaoVolumeCaixa;
Var unMarshal : TJsonUnmarshal;
begin
  ResetREST;
  DmClient.RESTRequest1.Resource := 'GetSeparacaoVolumeCaixa/{CdCaixa}/{Status}';
  DmClient.RESTRequest1.Params.AddUrlSegment('CdCaixa', CdCaixa.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('Status', '0');
  DmClient.RESTRequest1.Method := RmGet;
  DmClient.RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TSeparacaoVolumeCaixa;
  End;
end;

function TdmClient.GetValidarFuncao(pCdUsuario, pCdFuncao: Integer): TJSONArray;
Var unMarshal : TJsonUnmarshal;
    jArr      : TJSONArray;
begin
  Result := Nil;
  ResetREST;
  DmClient.RESTRequest1.Resource := 'ValidarAcessoFuncao/{pCdUsuario}/{pCdFuncao}';
  DmClient.RESTRequest1.Params.AddUrlSegment('pCdUsuario', pCdUsuario.ToString());
  DmClient.RESTRequest1.Params.AddUrlSegment('pCdFuncao', pCdFuncao.ToString());
  DmClient.RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     Result := DmClient.RESTResponse1.JSONValue as TJSONArray;
  End;
end;

function TdmClient.GetVolume(CdVolume: Int64): TSaidaVolume;
Var unMarshal : TJsonUnmarshal;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetVolume/{CdVolume}';
  RESTRequest1.Params.AddUrlSegment('CdVolume', CdVolume.ToString);
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TSaidaVolume;
  End;
end;

function TdmClient.GetVolumeCaixa(pCdVolume: Int64; pCdCaixa: Integer): TRetorno;
Var unMarshal : TJsonUnmarshal;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetVolumeCaixa/{pCdVolume}/{pCdCaixa}';
  RESTRequest1.Params.AddUrlSegment('pCdVolume', pCdVolume.ToString());
  RESTRequest1.Params.AddUrlSegment('pCdCaixa', pCdCaixa.ToString());
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TRetorno;
  End;
end;

function TdmClient.GetVolumeeXact(pPedidoVolumeId: Integer): TJsonArray;
begin
  ResetRest;
  RESTRequest1.Resource := 'v1/pedidovolume/{pedidoid}/{pedidovolumeid}/{sequencia}/{ordem}/{embalagem}/{zonaid}';
  RESTRequest1.Params.AddUrlSegment('pedidoid', '0');
  RESTRequest1.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  RESTRequest1.Params.AddUrlSegment('sequencia', '0');
  RESTRequest1.params.AddUrlSegment('ordem', '0');
  RestRequest1.params.AddUrlSegment('embalagem', 'T');
  RestRequest1.params.AddUrlSegment('zonaid', '0');
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) or
     (RESTResponse1.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := RESTResponse1.JSONValue as tjsonArray;
  End
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);
end;

function TdmClient.GetVolumeProdutoLotes(pPedidoVolumeId,
  pProdutoid: Integer): TJsonArray;
begin
  ResetRest;
  RESTRequest1.Resource := 'v1/pedidovolume/produtolotes/{pedidovolumeid}/{produtoid}';
  RESTRequest1.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  RESTRequest1.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);
end;

function TdmClient.GetVolumeProdutos(pPedidoVolumeId: Integer): TJsonArray;
begin
  ResetRest;
  RESTRequest1.Resource := 'v1/pedidovolume/produto/{pedidovolumeid}';
  RESTRequest1.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) or
     (RESTResponse1.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := RESTResponse1.JSONValue as tjsonArray;
  End
  Else
    raise Exception.Create('Erro: Buscar dados. '+RESTResponse1.StatusText);
end;

Function TDmClient.VolumeExpedicao  : TJsonArray;
Begin
  //Result := TJsonArray.Create;
  ResetRest;
  RESTRequest1.Resource := 'v1/pedidovolume/expedicao';
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+RESTResponse1.StatusText);
End;

Function TdmClient.RegistrarAberturaSeparacao(Const pVolumeSeparacaoId : Integer; Const pJsonSeparacao: TJsonObject) : TJsonObject;
Var vErro       : String;
    JsonRetorno : TJsonObject;
begin
  ResetRest;
  RestRequest1.ClearBody;
  {$IfDef Android}
     pJsonSeparacao.AddPair('estacao', IMEI); //IMEI;
  {$else}
     pJsonSeparacao.AddPair('estacao', NomeDoComputador);
  {$ENdif}
  Try
    RestRequest1.AddBody(pJsonSeparacao.ToJson, ContentTypeFromString('application/json'));
    if pVolumeSeparacaoId = 0 then Begin
       RESTRequest1.Resource := 'v1/pedidovolume/finalizarseparacao'; //'v1/volumeseparacao';
       RESTRequest1.Method := rmPut;
    End
    Else Begin
       RESTRequest1.Resource := 'v1/pedidovolume/finalizarseparacao'; //volumeseparacao/{volumeseparacaoid}';
       RESTRequest1.Method := rmPut;
    End;
    RESTRequest1.Execute;
    Result := (RESTResponse1.JSONValue as TJSONObject);
  Except On E: Exception do  Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

function TdmClient.RegistrarDocumentoEtapa(pPedidoVolumeId,
  pDocumentoEtapaId: Integer): TJsonArray;
Var JsonDocumento : TJsonObject;
begin
  JsonDocumento := tJsonObject.Create;
  JsonDocumento.AddPair('pedidovolumeid', pPedidoVolumeId.ToString());
  JsonDocumento.AddPair('processoid', pDocumentoEtapaId.Tostring());
  JsonDocumento.AddPair('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
  JsonDocumento.AddPair('estacao', NomeDoComputador);
  RESTRequest1.ClearBody;
  RESTRequest1.AddBody(jSonDocumento.ToJson, ContentTypeFromString('application/json'));
  RESTRequest1.Resource := 'v1/pedidovolume/registrardocumentoetapa';
  RESTRequest1.Method := rmPOST;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);
  FreeAndNil(JsonDocumento);
end;

procedure TdmClient.RegistrarStatusVolume(CdVolume : Int64; pStatusVolume: StatusVolume;
  vgHistorico: THistorico);
Var vMarshall : TJsonMarshal;
    jValue    : TJSonValue;
begin
  ResetREST;
  vMarshall := TJsonMarshal.Create();
  jValue    := vMarshall.Marshal(vgHistorico);
  RESTRequest1.Resource := 'VolumeRegistrarStatus/{CdVolume}/{pStatus}/{CdUsuario}';//{ObjHistorico}';
  RESTRequest1.Params.AddUrlSegment('CdVolume', CdVolume.ToString);
  RESTRequest1.Params.AddUrlSegment('pStatus', IntToStr(Ord(pStatusVolume)+1));
  RESTRequest1.Params.AddUrlSegment('CdUsuario', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString());
  RestRequest1.ClearBody;
  RestRequest1.AddBody(jValue.ToString, ContentTypeFromString('application/json'));
  RESTRequest1.Method := rmPOST;
  Try
    RESTRequest1.Execute;
    CheckReturnREST;
  Except on E : Exception do
    raise Exception.Create('ERRO: '+E.Message);
  End;
  vMarshall.DisposeOf;
  jValue.DisposeOf;
  vMarshall := Nil;
  jValue    := Nil;
end;

procedure TdmClient.ResetREST;
var Erro : Boolean;
begin
 RESTRequest1.TimeOut := 30000;
  Repeat
    Try
      Erro := False;
      DmClient.RESTRequest1.ResetToDefaults;
      RESTClient1.Accept := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
      RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
      RESTClient1.Params.Clear;
      if (FrmeXactWMS = Nil) or (FrmeXactWMS.ObjUsuarioCtrl = Nil) then
         RESTClient1.Params.AddHeader('usuarioid', '0')
      Else
         RESTClient1.Params.AddHeader('usuarioid', FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString);
      {$IfDef Android}
         RESTClient1.Params.AddHeader('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
         RESTClient1.Params.AddHeader('appname', 'eXactWMSMobileApk'); //+VersaoAPK);
         RESTClient1.Params.AddHeader('versao', VersaoAPK);
      {$else}
         RESTClient1.Params.AddHeader('terminal', NomeDoComputador);
         RESTClient1.Params.AddHeader('appname', 'eXactWMSMobileWin'); //+Versao('eXactWmsMobile.exe'));
         RESTClient1.Params.AddHeader('versao', Versao('eXactWmsMobile.exe'));
      {$Endif}
      DmClient.RESTResponseDataSetAdapter1.Response.DisposeOf;
    Except On E: Exception do
      Erro := True;
//     raise Exception.Create('erro: '+E.Message);
    End;
  Until (Not Erro);
end;

class function TdmClient.ServidorAtivo(pHost, pPort : String) : Boolean;
var VCon : TIdTCPClient;
begin
  vCon :=  TIdTCPClient.create;
  try
    vCon.ReadTimeout    := 9000;
    vCon.ConnectTimeout := 9000;
    vCon.Port := pPort.ToInteger;
    vCon.Host := pHost;
    vCon.Connect;
    vCon.Disconnect;
    Result    := true;
  Except
    Result := false;
    vCon.DisposeOf;
  end;
  vCon.DisposeOf;
end;

function TdmClient.GetvProdSaiProcessamento: TFDJSONDataSets;
Var unMarshal  : TJsonUnmarshal;
 // LDataSetList : TFDJSONDataSets;
begin
  ResetREST;
  RESTRequest1.Resource := 'GetvProdSaiProcessamento';
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if CheckReturnREST then Begin
     unMarshal := TJSONUnMarshal.Create;
     Result    := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TFDJSONDataSets;
  End;
end;

Function TDmClient.GetEmbalagemSeparacaoVolume(pEmbalagemId, pPedidoVolumeId, pOperacao : Integer) : TJsonArray;
Var jSonObj : tJsonObject;
    xItens  : Integer;
begin
  Result := TJsonArray.Create;
  ResetRest;
  RESTRequest1.Resource := 'v1/volumeseparacao/{caixaembalagemid}/{pedidovolumeid}/{operacao}';
  RESTRequest1.Params.AddUrlSegment('caixaembalagemid', pEmbalagemId.ToString());
  RESTRequest1.Params.AddUrlSegment('pedidovolumeid', pPedidoVolumeId.ToString());
  RESTRequest1.Params.AddUrlSegment('operacao', pOperacao.ToString());
  RESTRequest1.Method := RmGet;
  RESTRequest1.Execute;
  if (RESTResponse1.StatusCode = 200) or (RESTResponse1.StatusCode = 201) Then
     Result := RESTResponse1.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+RESTResponse1.StatusText);
End;

end.


