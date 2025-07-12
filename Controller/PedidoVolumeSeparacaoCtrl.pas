{
   PedidoVolumeSeparacaoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit PedidoVolumeSeparacaoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     PedidoVolumeSeparacaoClass, Rest.Json, System.Json, Rest.Types;

Type

  TVolumeSeparacaoCtrl = Class
  Private
    //Funções de Validação
    VolumeSeparacao      : TVolumeSeparacao;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados(ObjVolumeSeparacao : TVolumeSeparacao) : Boolean;
    Function GetVolumeSeparacao(pCaixaEmbalagemId : Integer = 0; pPedidoVolumeId : Integer = 0; pOperacao : Integer = 0; pShowErro : Integer = 1) : TObjectList<TVolumeSeparacao>;
    Function GetVolumeSeparacaoJson(pCaixaEmbalagemId : Integer = 0; pPedidoVolumeId : Integer = 0; pOperacao : Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function FinalizarSeparacao : tjsonObject;  //(pHistorico: THistorico)
    Function DelVolumeSeparacao : Boolean;
    Function GetResumoSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao, pDataFinalProducao: TDateTime; pUsuarioId, pProcessoId: Integer): TJsonArray;
    Function GetDSHSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao, pDataFinalProducao: TDateTime; pUsuarioId, pZonaId: Integer): TJsonArray;
    Function GetDesempenhoExpedicao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao, pDataFinalProducao: TDateTime; pUsuarioId, pAnalise : Integer; pEmbalagemId : Integer): TJsonArray;
    Property ObjVolumeSeparacao : TVolumeSeparacao Read VolumeSeparacao Write VolumeSeparacao;
    Procedure SaveSeparacao(jsonSeparacao : tjsonObject);
  End;

implementation

{ tCtrlVolumeSeparacao }

uses PedidoVolumeSeparacaoDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function TVolumeSeparacaoCtrl.VerificaDados(ObjVolumeSeparacao : TVolumeSeparacao) : Boolean;
Begin
  Result := False;
  With ObjVolumeSeparacao do Begin
{
     if ObjVolumeSeparacao.Numsequencia = 0 then
        raise Exception.Create('Informe o Número de Identificação da caixa!');
     if (ObjVolumeSeparacao.VolumeEmbalagem.EmbalagemId <= 0) then
        raise Exception.Create('Informe a tipo para as propriedades da Caixa!');
}
  End;
  Result := True;
End;

constructor TVolumeSeparacaoCtrl.Create;
begin
  VolumeSeparacao      := TVolumeSeparacao.Create;
end;

function TVolumeSeparacaoCtrl.DelVolumeSeparacao : Boolean;
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
begin
  ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
  ObjVolumeSeparacaoDAO.ObjVolumeSeparacao.VolumeSeparacaoId := Self.VolumeSeparacao.VolumeSeparacaoId;
  Result := ObjVolumeSeparacaoDAO.Delete;
  if Result then
     Self.ObjVolumeSeparacao.VolumeSeparacaoId := 0;
  ObjVolumeSeparacaoDAO.Free;
end;

destructor TVolumeSeparacaoCtrl.Destroy;
begin
  VolumeSeparacao.Free;
  inherited;
end;

function TVolumeSeparacaoCtrl.GetDesempenhoExpedicao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao,
  pDataFinalProducao: TDateTime; pUsuarioId, pAnalise : Integer; pEmbalagemId : Integer): TJsonArray;
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
begin
  ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
  Result := ObjVolumeSeparacaoDAO.GetDesempenhoExpedicao(pDataInicialPedido, pDataFinalPedido,
            pDataInicialProducao, pDataFinalProducao, pUsuarioId, pAnalise, pEmbalagemId);
  ObjVolumeSeparacaoDAO.Free
end;

function TVolumeSeparacaoCtrl.GetDSHSeparacao(pDataInicialPedido,
  pDataFinalPedido, pDataInicialProducao, pDataFinalProducao: TDateTime;
  pUsuarioId, pZonaId: Integer): TJsonArray;
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
begin
  Try
    ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
    Result := ObjVolumeSeparacaoDAO.GetDSHSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao,
    pDataFinalProducao, pUsuarioId, pZonaId);
    ObjVolumeSeparacaoDAO.Free;
  Except On E: Exception Do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjVolumeSeparacaoDAO.Free;
    End;
  End;
end;

function TVolumeSeparacaoCtrl.GetResumoSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao,
  pDataFinalProducao: TDateTime; pUsuarioId, pProcessoId: Integer): TJsonArray;
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
begin
  Try
    ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
    Result := ObjVolumeSeparacaoDAO.GetResumoSeparacao(pDataInicialPedido, pDataFinalPedido, pDataInicialProducao,
    pDataFinalProducao, pUsuarioId, pProcessoId);
    ObjVolumeSeparacaoDAO.Free;
  Except On E: Exception Do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjVolumeSeparacaoDAO.Free;
    End;
  End;
end;

function TVolumeSeparacaoCtrl.GetVolumeSeparacaoJson(pCaixaEmbalagemId,
  pPedidoVolumeId, pOperacao, pShowErro: Integer): TJsonArray;
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
    ReturnJson     : TJsonArray;
    jsonVolumeSeparacao   : tjsonObject;
    xItensVolumeSeparacao : Integer;
    vErro : String;
begin
  ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
  ObjVolumeSeparacaoDAO.ObjVolumeSeparacao.VolumeSeparacaoId := ObjVolumeSeparacao.VolumeSeparacaoId;
  Result := ObjVolumeSeparacaoDAO.GetVolumeSeparacao(pCaixaEmbalagemId, pPedidoVolumeId, pOperacao, pShowErro);
  ObjVolumeSeparacaoDAO.Free;
end;

Function TVolumeSeparacaoCtrl.GetVolumeSeparacao(pCaixaEmbalagemId : Integer = 0; pPedidoVolumeId : Integer = 0; pOperacao : Integer = 0; pShowErro : Integer = 1) : TObjectList<TVolumeSeparacao>;
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
    ReturnJson     : TJsonArray;
    jsonVolumeSeparacao   : tjsonObject;
    xItensVolumeSeparacao : Integer;
    vErro : String;
begin
  Result     := TObjectList<TVolumeSeparacao>.Create;
  ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
  ObjVolumeSeparacaoDAO.ObjVolumeSeparacao.VolumeSeparacaoId := ObjVolumeSeparacao.VolumeSeparacaoId;
  ReturnJson := ObjVolumeSeparacaoDAO.GetVolumeSeparacao(pCaixaEmbalagemId, pPedidoVolumeId, pOperacao, pShowErro);
  if ReturnJson.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     if pShowErro = 1 then
        Raise Exception.Create('CheckIn não encontrado!');
  End
  Else Begin
    if ReturnJson.Count >= 1 then Begin
       xItensVolumeSeparacao := 0;
       repeat
         jsonVolumeSeparacao := tJsonObject.Create;
         jsonVolumeSeparacao := ReturnJson.Items[xItensVolumeSeparacao] as TJSONObject;
         ObjVolumeSeparacao  := ObjVolumeSeparacao.JsonToClass(JsonVolumeSeparacao.ToString());
         Result.Add(ObjVolumeSeparacao);
         jsonVolumeSeparacao := Nil;
         jsonVolumeSeparacao.DisposeOf;
         Inc(xItensVolumeSeparacao);
       until (xItensVolumeSeparacao > Pred(ReturnJson.Count));
    End;
  End;
  ObjVolumeSeparacaoDAO.Free;
End;

Function TVolumeSeparacaoCtrl.FinalizarSeparacao : tjsonObject;       //(pHistorico: THistorico)
Var ObjVolumeSeparacaoDAO : TVolumeSeparacaoDAO;
Begin
  ObjVolumeSeparacaoDAO := TVolumeSeparacaoDAO.Create;
  ObjVolumeSeparacaoDAO.ObjVolumeSeparacao.VolumeSeparacaoId := Self.ObjVolumeSeparacao.VolumeSeparacaoId;
  ObjVolumeSeparacaoDAO.ObjVolumeSeparacao := ObjVolumeSeparacao;
  Result := ObjVolumeSeparacaoDAO.FinalizarSeparacao;
//  if Result then
//     Self.ObjVolumeEmbalagem.EmbalagemId := 0;
  ObjVolumeSeparacaoDAO.Free;
End;

procedure TVolumeSeparacaoCtrl.SaveSeparacao(jsonSeparacao: tjsonObject);
Var ObjPedidoVolumeDAO : TVolumeSeparacaoDAO;
begin
  ObjPedidoVolumeDAO := TVolumeSeparacaoDAO.Create;
  ObjPedidoVolumeDAO.SaveSeparacao(jsonSeparacao);
  ObjPedidoVolumeDAo.Free;
end;

End.
