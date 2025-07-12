{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/02/2021
   Projeto: RhemaWMS
}
unit EntradaItensCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EntradaItensClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TEntradaItensCtrl = Class
  Private
    //Funções de Validação
    FEntradaItens : TEntradaItens;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function GetEntradaItens(pEntradaId :Integer = 0; pProdutoId : Integer =0; pLoteId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TEntradaItens>;
    Function GetEntradaProduto(pEntradaId :Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function DelEntradaItens : Boolean;
    Function DelCheckIn(pEntradaId, pPedidoItemId : Integer) : Boolean;
    Function GetProdutoTag(pPedidoId : Integer = 0; pDocumentoNr : String = ''; pDtDocumentoData : TDateTime = 0;
                           pRegistroERP : String = ''; pDtCheckInFinalizacao : TDateTime = 0; pCodigoERP : Integer = 0; pTagEstoque : Boolean = False) : TJsonArray;
    Function CancelarCheckInProduto(pAgrupamentoId, pEntradaId, pCodProduto : Integer) : TJsonArray;
    Function RegPrintEtqProduto(pPedidoId, pLoteId :Integer) : TJsonArray;
    Property EntradaItens : TEntradaItens Read FEntradaItens Write FEntradaItens;
  End;

implementation

{ tCtrlEntrada }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes, uEntradaItensDAO; //, uFrmPesquisa

Function tEntradaItensCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With FEntradaItens do Begin
    if ProdutoLotes.Lotes.LoteId = 0 then
       raise Exception.Create('Obrigatório informar o lote!');
    if (QtdXML+QtdCheckIn+QtdDevolvida+QtdSegregada <= 0) or
       (QtdXML+QtdCheckIn+QtdDevolvida+QtdSegregada > QtdXML)then
       raise Exception.Create('Quantidade da entrada(XML) é inválida!');
  End;
  Result := True;
End;

function TEntradaItensCtrl.CancelarCheckInProduto(pAgrupamentoId, pEntradaId, pCodProduto: Integer): TJsonArray;
Var ObjEntradaItensDAO : TEntradaItensDAO;
begin
  Try
    ObjEntradaItensDAO := TEntradaItensDAO.Create;
    Try
      Result := ObjEntradaItensDAO.CancelarCheckInProduto(pAgrupamentoId, pEntradaId, pCodProduto);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjEntradaItensDAO);
  End;
end;

constructor TEntradaItensCtrl.Create;
begin
  FEntradaItens := TEntradaItens.Create;
end;

function TEntradaItensCtrl.DelCheckIn(pEntradaId, pPedidoItemId: Integer): Boolean;
Var ObjEntradaItensDAO : TEntradaItensDAO;
begin
  ObjEntradaItensDAO := TEntradaItensDAO.Create;
  Result := ObjEntradaItensDAO.DelCheckIn(pEntradaId, pPedidoItemId);
  ObjEntradaItensDAO.Free;
end;

function TEntradaItensCtrl.DelEntradaItens: Boolean;
begin
  Result := Self.FEntradaItens.DeleteEntradaItens;
  if Result then
     Self.FEntradaItens.EntradaItemId := 0;
end;

destructor TEntradaitensCtrl.Destroy;
begin
  FreeAndNil(FEntradaitens);
  inherited;
end;

Function TEntradaItensCtrl.GetEntradaItens(pEntradaId :Integer = 0; pProdutoId : Integer =0;
               pLoteId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TEntradaItens>;
Var ReturnJson       : TJsonArray;
    JsonEntradaItens : TJsonObject;
    xItens           : Integer;
    ObjEntradaItens  : TEntradaItensCtrl;
begin
  Result := TObjectList<TEntradaItens>.Create;
  ReturnJson := Self.FEntradaItens.GetEntradaItens(pEntradaId, pProdutoId, pLoteId, pShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       ObjEntradaItens := TEntradaItensCtrl.Create;
       JsonEntradaItens := tJsonObject.Create;
       JsonEntradaItens := ReturnJson.Items[xItens] as TJSONObject;
       ObjEntradaItens.FEntradaItens  := Self.FEntradaitens.JsonToClass(JsonEntradaItens.ToString());
       Result.Add(ObjEntradaItens.FEntradaItens);
       JsonEntradaItens := Nil;
       JsonEntradaItens.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
     ObjEntradaItens := Nil;
  End
  Else Raise Exception.Create('Registro de Itens do pedido não encontrado');
End;

function TEntradaItensCtrl.GetEntradaProduto(pEntradaId,
  pShowErro: Integer): TJsonArray;
Var ObjEntradaItens  : TEntradaItensCtrl;
begin
  Try
    Result := Self.FEntradaItens.GetEntradaProduto(pEntradaId, pShowErro);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaItensCtrl.GetProdutoTag(pPedidoId: Integer;
  pDocumentoNr: String; pDtDocumentoData: TDateTime; pRegistroERP: String;
  pDtCheckInFinalizacao: TDateTime; pCodigoERP : Integer; pTagEstoque : Boolean): TJsonArray;
Var ObjEntradaItens  : TEntradaItensCtrl;
    VErro : String;
begin
  Result := Self.FEntradaItens.GetProdutoTagClass(pPedidoId, pDocumentoNr, pDtDocumentoData, pRegistroERP, pDtCheckInFinalizacao, pCodigoERP, pTagEstoque);
end;

function TEntradaItensCtrl.RegPrintEtqProduto(pPedidoId,
  pLoteId: Integer): TJsonArray;
Var ObjEntradaItensDAO : TEntradaItensDAO;
begin
  ObjEntradaItensDAO := TEntradaItensDAO.Create;
  Result := ObjEntradaItensDAO.RegPrintEtqProduto(pPedidoId, pLoteId);
  ObjEntradaItensDAO.Free;
end;

Function TEntradaItensCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Begin
  Result := False;
  If Self.VerificaDados then
     Result :=  Self.FEntradaItens.Salvar;
End;

End.

