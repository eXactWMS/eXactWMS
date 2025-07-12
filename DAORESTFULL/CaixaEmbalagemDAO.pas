unit CaixaEmbalagemDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EmbalagemCaixaClass, System.JSON, REST.Json, Rest.Types;

Type

  TCaixaEmbalagemDAO = class
  private
    FCaixaEmbalagem : TCaixaEmbalagem;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function GetCaixaEmbalagemJson(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin,
             pVolumeEmbalagemId : Integer; pSituacao : String; pStatus : Integer) : TJsonArray;
    Function GetCaixaEmbalagemListaPaginacao(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin,
             pVolumeEmbalagemId : Integer; pSituacao : String; pStatus, pOffSetPaginacao : Integer) : TJsonObject;
    Function Salvar : tjsonObject;
    Function GetCaixaResumo : TJsonArray;
    Function GetRastreamento(pDtPedidoInicial, pDtPedidoFinal: TDateTime; pCodPessoaERP, pProcessoId, pRotaId,
             pNumSequenciaCxaInicial, pNumSequenciaCxaFinal: Integer): TJsonArray;
    Function InsertFilaCaixa(pJsonObject: TJsonObject): TJsonObject;
    Function SalvarCaixaLiberacao(pCaixaId: Int64) : TjsonArray;
    Function CaixaInativar(pCaixaId: integer) : TjsonArray;
    Function GetMaxCaixa : TJsonArray;

    Property ObjCaixaEmbalagem : TCaixaEmbalagem Read FCaixaEmbalagem Write FCaixaEmbalagem;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

function TCaixaEmbalagemDao.CaixaInativar(pCaixaId: integer): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/inativar/{caixaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaid', pCaixaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Raise  Exception.Create(E.Message);
    End;
  End;
end;

constructor TCaixaEmbalagemDao.Create;
begin
  Self.FCaixaEmbalagem := TCaixaEmbalagem.Create;
end;

function TCaixaEmbalagemDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/{caixaembalagemid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TCaixaEmbalagemDao.GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCaixaEmbalagem  : TCaixaEmbalagem;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pCaixaEmbalagemId = 0) Then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem'
  Else Begin
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/{caixaembalagemid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', pCaixaEmbalagemId.ToString());
  End;

  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else if pShowErro = 1 then
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCaixaEmbalagemDao.GetCaixaEmbalagemJson(pCaixaEmbalagemId,
  pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus : Integer): TJsonArray;
Var jSonObj         : tJsonObject;
    vResourceURI    : String;
Begin
  Result := TJsonArray.Create;
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RequestReport.Timeout := DmeXactWMS.RequestReport.Timeout * 5;
    ///v1/saida/cubagem?DataIni=01/05/  &DataFin=21/05/21
    vResourceURI := 'v1/caixaembalagem/lista?';
    if pCaixaEmbalagemId <> 0 then
       vResourceURI := vResourceURI+'&caixaembalagemid='+pCaixaEmbalagemId.ToString();
    if pSequenciaIni <> 0 then
       vResourceURI := vResourceURI+'&sequenciaini='+pSequenciaIni.ToString();
    if pSequenciaFin <> 0 then
       vResourceURI := vResourceURI+'&sequenciafin='+pSequenciaFin.ToString();
    if pVolumeEmbalagemId <> 0 then
       vResourceURI := vResourceURI+'&volumeembalagemid='+pVolumeEmbalagemId.ToString();
    vResourceURI := vResourceURI+'&situacao='+pSituacao;
    vResourceURI := vResourceURI+'&status='+pStatus.Tostring();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
      raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCaixaEmbalagemDAO.GetCaixaEmbalagemListaPaginacao(pCaixaEmbalagemId,
  pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus, pOffSetPaginacao : Integer): TJsonObject;
Var JsonArrayErro : TJsonArray;
    vResourceURI  : String;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RequestReport.Timeout := DmeXactWMS.RequestReport.Timeout * 5;
    vResourceURI := 'v1/caixaembalagem/lista/paginacao?';
    if pCaixaEmbalagemId <> 0 then
       vResourceURI := vResourceURI+'&caixaembalagemid='+pCaixaEmbalagemId.ToString();
    if pSequenciaIni <> 0 then
       vResourceURI := vResourceURI+'&sequenciaini='+pSequenciaIni.ToString();
    if pSequenciaFin <> 0 then
       vResourceURI := vResourceURI+'&sequenciafin='+pSequenciaFin.ToString();
    if pVolumeEmbalagemId <> 0 then
       vResourceURI := vResourceURI+'&volumeembalagemid='+pVolumeEmbalagemId.ToString();
    vResourceURI := vResourceURI+'&situacao='+pSituacao;
    vResourceURI := vResourceURI+'&status='+pStatus.Tostring();
    vResourceURI := vResourceURI+'&offset='+pOffSetPaginacao.Tostring();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
  Except ON E: Exception do Begin
    JsonArrayErro := TJsonArray.Create;
    JsonArrayErro.AddElement(TJsonObject.Create.AddPair('erro', E.Message));
    Result := TJsonObject.Create
              .AddPair('registro', TJsonNumber.Create(0))
              .AddPair('caixa', JsonArrayErro);
    End;
  End;
end;

function TCaixaEmbalagemDao.GetCaixaResumo: TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/resumo';
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TCaixaEmbalagemDAO.GetMaxCaixa: TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/maxcaixa';
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;  
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TCaixaEmbalagemDao.GetRastreamento(pDtPedidoInicial,
  pDtPedidoFinal: TDateTime; pCodPessoaERP, pProcessoId, pRotaId, pNumSequenciaCxaInicial,
  pNumSequenciaCxaFinal: Integer): TJsonArray;
Var vResourceURI, vComplemento : String;
begin
  Try
    vComplemento := '?';
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/caixaembalagem/rastreamento';
    if pDtPedidoInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'dtpedidoinicial='+DateToStr(pDtPedidoInicial);
       vComplemento := '&';
    End;
    if pDtPedidoInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'dtpedidofinal='+DateToStr(pDtPedidoFinal);
       vComplemento := '&';
    End;
    if pCodPessoaERP <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'codpessoaerp='+pCodPessoaERP.ToString;
       vComplemento := '&';
    End;
    if pProcessoId <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'processoid='+pProcessoId.ToString;
       vComplemento := '&';
    End;
    if pRotaId <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'rotaid='+pRotaId.ToString;
       vComplemento := '&';
    End;
    if pNumSequenciaCxaInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'caixaidinicial='+pNumSequenciaCxaInicial.ToString;
       vComplemento := '&';
    End;
    if pNumSequenciaCxaFinal <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'caixaidfinal='+pNumSequenciaCxaFinal.ToString;
       vComplemento := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    End;
  End;
end;

function TCaixaEmbalagemDao.InsertFilaCaixa(pJsonObject: TJsonObject): TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/filacaixa';
    DmeXactWMS.RESTRequestWMS.Method := rmPOST;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

Function TCaixaEmbalagemDao.Salvar: tjsonObject;
Var jSonCaixaEmbalagem : TJsonObject;
begin
  jSonCaixaEmbalagem := tJson.ObjectToJsonObject(Self.FCaixaEmbalagem);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonCaixaEmbalagem.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjCaixaEmbalagem.CaixaEmbalagemId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/Caixaembalagem/{caixaembalagemid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', Self.FCaixaEmbalagem.CaixaEmbalagemId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonCaixaEmbalagem);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCaixaEmbalagemDao.SalvarCaixaLiberacao(pCaixaId: Int64): TjsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/Caixaembalagem/caixaliberacao/{caixaid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaid', pCaixaId.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Raise  Exception.Create(E.Message);
    End;
  End;
end;

end.
