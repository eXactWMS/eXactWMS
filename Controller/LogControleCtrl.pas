{
   PedidoSaidaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit LogControleCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     PedidoSaidaClass, Rest.Json, System.Json, Rest.Types, PedidoProdutoCtrl, System.Generics.Collections;

Type
  TipoConsulta = (Resumida, Completa);

  TLogControleCtrl = Class
  Private
    //Funções de Validação
    FLogControle      : TPedidoSaida;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function GetLogControle(pDataInicio, pDataTermino : TDateTime;
                            pUsuarioId : Integer; pTerminal, pRequisicao : String; pVerbo, pSomenteErro : Integer) : TJsonArray;
    Function GetLogDashBoard : TJsonArray;
//    Property LogControle : TPedidoSaida Read FLogControle Write FLogControle;
  End;

implementation

{ tCtrlLogControle }

uses LogControleDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

constructor TLogControleCtrl.Create;
begin
//  FLogControle := TPedidoSaida.Create;
end;

destructor TLogControleCtrl.Destroy;
begin
  FreeAndNil(FLogControle);
  inherited;
end;

Function TLogControleCtrl.GetLogControle(pDataInicio, pDataTermino : TDateTime;
                          pUsuarioId : Integer; pTerminal, pRequisicao : String; pVerbo, pSomenteErro : Integer) : TJsonArray;
Var ObjLogControleDAO    : TLogControleDAO;
    vErro              : String;
begin
  ObjLogControleDAO := TLogControleDAO.Create;
  Result := ObjLogControleDAO.GetLogControle(pDataInicio, pDataTermino,
                          pUsuarioId, pTerminal, pRequisicao, pVerbo, pSomenteErro);
  FreeAndNil(ObjLogControleDAO);
End;

function TLogControleCtrl.GetLogDashBoard: TJsonArray;
Var ObjLogControleDAO : TLogControleDAO;
begin
  Try
    Try
      ObjLogControleDAO := TLogControleDAO.Create;
      Result            := ObjLogControleDAO.GetLogDashBoard;
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjLogControleDAO);
  End;
end;

End.

