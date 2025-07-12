{
   EnderecamentoRuaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EmbalagemCaixaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EmbalagemCaixaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TCaixaEmbalagemCtrl = Class
  Private
    //Funções de Validação
    FObjCaixaEmbalagem      : TCaixaEmbalagem;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados(ObjCaixaEmbalagem : TCaixaEmbalagem) : Boolean;
    Function GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TCaixaEmbalagem>;
    Function GetCaixaEmbalagemJson(pCaixaEmbalagemId : Integer = 0; pSequenciaIni : Integer = 0;
             pSequenciaFin : Integer = 0; pVolumeEmbalagemId : Integer = 0; pSituacao : String = 'A'; pStatus: Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function GetCaixaEmbalagemListapaginacao(pCaixaEmbalagemId : Integer = 0; pSequenciaIni : Integer = 0;
             pSequenciaFin : Integer = 0; pVolumeEmbalagemId : Integer = 0; pSituacao : String = 'A'; pStatus: Integer = 0; pNrPagePaginacao : Integer = 0) : TJsonObject;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelCaixaEmbalagem : Boolean;
    Function GetCaixaResumo : TJsonArray;
    Function GetRastreamento(pDtPedidoInicial, pDtPedidoFinal : TDateTime; pCodPessoaERP, pProcessoId, pRotaId, pNumSequenciaCxaInicial, pNumSequenciaCxaFinal : Integer) : TJsonArray;
    Function InsertFilaCaixa(pJsonObject : TJsonObject) : TJsonObject;
    Function SalvarCaixaLiberacao(pCaixaId : Int64) : TjsonArray;
    Function CaixaInativar(pCaixaId : integer) : TJsonArray;
    Function GetMaxCaixa : TJsonArray;
    Property ObjCaixaEmbalagem : TCaixaEmbalagem Read FObjCaixaEmbalagem Write FObjCaixaEmbalagem;
  End;

implementation

{ tCtrlCaixaEmbalagem }

uses CaixaEmbalagemDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tCaixaEmbalagemCtrl.VerificaDados(ObjCaixaEmbalagem : TCaixaEmbalagem) : Boolean;
Begin
  Result := False;
  With ObjCaixaEmbalagem do Begin
    if ObjCaixaEmbalagem.Numsequencia = 0 then
       raise Exception.Create('Informe o Número de Identificação da caixa!');
    if (ObjCaixaEmbalagem.VolumeEmbalagem.EmbalagemId <= 0) then
       raise Exception.Create('Informe a tipo para as propriedades da Caixa!');
  End;
  Result := True;
End;

function TCaixaEmbalagemCtrl.CaixaInativar(pCaixaId: integer): TJsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  Try
    Try
      ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
      Result := ObjCaixaEmbalagemDAO.CaixaInativar(pCaixaId);
    Except On E: Exception do begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      end;
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
end;

constructor TCaixaEmbalagemCtrl.Create;
begin
  FObjCaixaEmbalagem      := TCaixaEmbalagem.Create;
end;

function TCaixaEmbalagemCtrl.DelCaixaEmbalagem : Boolean;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  ObjCaixaEmbalagemDAO.ObjCaixaEmbalagem.CaixaEmbalagemId := Self.ObjCaixaEmbalagem.CaixaEmbalagemId;
  Result := ObjCaixaEmbalagemDAO.Delete;
  if Result then
     Self.ObjCaixaEmbalagem.CaixaEmbalagemId := 0;
  ObjCaixaEmbalagemDAO := Nil;
  ObjCaixaEmbalagemDAO.DisposeOf;
end;

destructor TCaixaEmbalagemCtrl.Destroy;
begin
  FreeAndNil(FObjCaixaEmbalagem);
  inherited;
end;

Function tCaixaEmbalagemCtrl.GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TCaixaEmbalagem>;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
    ReturnJson     : TJsonArray;
    jsonCaixaEmbalagem   : tjsonObject;
    xItensCaixaEmbalagem : Integer;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  ReturnJson := ObjCaixaEmbalagemDAO.GetCaixaEmbalagem(pCaixaEmbalagemId, pShowErro);
  Result     := TObjectList<TCaixaEmbalagem>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensCaixaEmbalagem := 0;
     repeat
       jsonCaixaEmbalagem := tJsonObject.Create;
       jsonCaixaEmbalagem := ReturnJson.Items[xItensCaixaEmbalagem] as TJSONObject;
       ObjCaixaEmbalagem  := ObjCaixaEmbalagem.JsonToClass(JsonCaixaEmbalagem.ToString());
       Result.Add(ObjCaixaEmbalagem);
       jsonCaixaEmbalagem := Nil;
       jsonCaixaEmbalagem.DisposeOf;
       Inc(xItensCaixaEmbalagem);
     until (xItensCaixaEmbalagem > Pred(ReturnJson.Count));
  End
  Else If pShowErro = 1 then
     Raise Exception.Create('Caixa não encontrada!');
  ObjCaixaEmbalagemDAO := Nil;
  ObjCaixaEmbalagemDAO.DisposeOf;
End;

function TCaixaEmbalagemCtrl.GetCaixaEmbalagemJson(pCaixaEmbalagemId,
  pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus, pShowErro: Integer): TJsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  Result := ObjCaixaEmbalagemDAO.GetCaixaEmbalagemJson(pCaixaEmbalagemId,
            pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId, pSituacao, pStatus);
  If (pShowErro = 1) and (Result.Count < 1) then
     Raise Exception.Create('Caixa não encontrada!');
  ObjCaixaEmbalagemDAO.Free;
end;

function TCaixaEmbalagemCtrl.GetCaixaEmbalagemListapaginacao(pCaixaEmbalagemId,
  pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus, pNrPagePaginacao : Integer): TJsonObject;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  Result := ObjCaixaEmbalagemDAO.GetCaixaEmbalagemListapaginacao(pCaixaEmbalagemId,
            pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId, pSituacao, pStatus, pNrPagePaginacao);
  FreeAndNil(ObjCaixaEmbalagemDAO);
end;

function TCaixaEmbalagemCtrl.GetCaixaResumo: TJsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
Begin
  Try
    Try
      ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
      Result := ObjCaixaEmbalagemDAO.GetCaixaResumo;
    Except On E: Exception do begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      end;
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
end;

function TCaixaEmbalagemCtrl.GetMaxCaixa: TJsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  Try
    Try
      Result := ObjCaixaEmbalagemDAO.GetMaxCaixa;
    Except On E: Exception do Begin
      Result := TjsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
end;

function TCaixaEmbalagemCtrl.GetRastreamento(pDtPedidoInicial,
  pDtPedidoFinal: TDateTime; pCodPessoaERP, pProcessoId, pRotaId, pNumSequenciaCxaInicial,
  pNumSequenciaCxaFinal: Integer): TJsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
Begin
  Try
    Try
      ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
      Result := ObjCaixaEmbalagemDAO.GetRastreamento(pDtPedidoInicial, pDtPedidoFinal, pCodPessoaERP, pProcessoId, pRotaId, pNumSequenciaCxaInicial, pNumSequenciaCxaFinal);
    Except On E: Exception do begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      end;
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
end;

function TCaixaEmbalagemCtrl.InsertFilaCaixa(
  pJsonObject: TJsonObject): TJsonObject;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  Try
    Try
      Result := ObjCaixaEmbalagemDAO.InsertFilaCaixa(pJsonObject);
    Except On E: Exception do
      Result := TJsonObject.Create.AddPair('Erro', E.Message);
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
end;

Function tCaixaEmbalagemCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
Begin
  Try
    Try
      ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
      ObjCaixaEmbalagemDAO.ObjCaixaEmbalagem := ObjCaixaEmbalagem;
      Result := ObjCaixaEmbalagemDAO.Salvar;
    Except On E: Exception do begin
      Result := TJsonObject.Create.AddPair('Erro', E.Message);
      end;
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
End;

function TCaixaEmbalagemCtrl.SalvarCaixaLiberacao(pCaixaId: Int64): TjsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
Begin
  Try
    Try
      ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
      Result := ObjCaixaEmbalagemDAO.SalvarCaixaLiberacao(pCaixaId);
    Except On E: Exception do begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      end;
    End;
  Finally
    FreeAndNil(ObjCaixaEmbalagemDAO);
  End;
end;

End.
