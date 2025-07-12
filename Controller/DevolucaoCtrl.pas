{
   PedidoSaidaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit DevolucaoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     PedidoSaidaClass, Rest.Json, System.Json, Rest.Types, PedidoProdutoCtrl, System.Generics.Collections;

Type
  TipoConsulta = (Resumida, Completa);

  TDevolucaoCtrl = Class
  Private
    //Funções de Validação
    FDevolucao      : TPedidoSaida;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function CancelarDevolucao(pPedidoId : Integer) : Boolean;
    Function VerificaDados(ObjDevolucao : TPedidoSaida) : Boolean;
    Function GetDevolucao(pDevolucaoId : Integer = 0; pCodigoERP : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = ''; pShowErro : Integer = 1) : TJsonArray;
    Function GetPendente : TJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Property Devolucao : TPedidoSaida Read FDevolucao Write FDevolucao;
  End;

implementation

{ tCtrlDevolucao }

uses DevolucaoDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tDevolucaoCtrl.VerificaDados(ObjDevolucao : TPedidoSaida) : Boolean;
Begin
  Result := False;
  With ObjDevolucao do Begin
    if OperacaoTipo.OperacaoTipoId = 0 then
       raise Exception.Create('Informe o Tipo da Operação!');
    if (Pessoa.PessoaId = 0) then
       raise Exception.Create('Informe o fornecedor!');
  End;
  Result := True;
End;

function TDevolucaoCtrl.CancelarDevolucao(pPedidoId: Integer): Boolean;
Var ObjDevolucaoDAO : TDevolucaoDAO;
begin
  ObjDevolucaoDAO := TDevolucaoDAO.Create;
  ObjDevolucaoDAO.Devolucao.PedidoId := Self.FDevolucao.PedidoId;
  Result := ObjDevolucaoDAO.CancelarDevolucao;
  if Result then
     Self.Devolucao.PedidoId := 0;
  ObjDevolucaoDAO := Nil;
  ObjDevolucaoDAO.DisposeOf;
end;

constructor TDevolucaoCtrl.Create;
begin
  FDevolucao := TPedidoSaida.Create;
end;

function TDevolucaoCtrl.Delete : Boolean;
Var ObjDevolucaoDAO : TDevolucaoDAO;
begin
  ObjDevolucaoDAO := TDevolucaoDAO.Create;
  ObjDevolucaoDAO.Devolucao.PedidoId := Self.FDevolucao.PedidoId;
  Result := ObjDevolucaoDAO.Delete;
  if Result then
     Self.Devolucao.PedidoId := 0;
  ObjDevolucaoDAO := Nil;
  ObjDevolucaoDAO.DisposeOf;
end;

destructor TDevolucaoCtrl.Destroy;
begin
  FDevolucao.DisposeOf;
  inherited;
end;

function TDevolucaoCtrl.GetPendente: TJsonArray;
Var ObjDevolucaoDAO    : TDevolucaoDAO;
begin
  ObjDevolucaoDAO := TDevolucaoDAO.Create;
  Result := ObjDevolucaoDAO.GetPendente;
  ObjDevolucaoDAO.DisposeOf;
end;

Function TDevolucaoCtrl.GetDevolucao(pDevolucaoId : Integer = 0; pCodigoERP : Integer = 0; pPessoaId : Integer = 0;
                                     pDocumentoNr : String = ''; pShowErro : Integer = 1): TJsonArray;
Var ObjDevolucaoDAO    : TDevolucaoDAO;
    JsonArrayDevolucao : TJsonArray;
    vErro              : String;
begin
  Try
    Try
      ObjDevolucaoDAO := TDevolucaoDAO.Create;
      Result := ObjDevolucaoDAO.GetDevolucao(pDevolucaoId, pPessoaId, pDocumentoNr);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjDevolucaoDAO);
  End;
End;

Function TDevolucaoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var ObjDevolucaoDAO : TDevolucaoDAO;
Begin
  ObjDevolucaoDAO := TDevolucaoDAO.Create;
  Result := ObjDevolucaoDAO.Delete;
  if Result then
     Self.Devolucao.PedidoId := 0;
  ObjDevolucaoDAO := Nil;
  ObjDevolucaoDAO.DisposeOf;
End;

End.

