{
   InventarioCtrl.Pas
   Criado por Genilson S Soares em 22/02/2022
   Projeto: eXactWMS
}
unit InventarioCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
     Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , InventarioClass;

Type
  TInventarioCtrl = Class
  Private
    FObjInventario : TInventario;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function GetInventario(pInventarioId : Integer = 0; pDataCriacao : TDateTime = 0;
             pDataFinalizacao : TDateTime = 0; pDataCancelamento : TDateTime = 0; pProcessoId : Integer = 0;
             pTipo : Integer = 0; pPendente : Integer = 0; pProdutoId : Integer = 0; pShowErro : Integer = 1; pDataCriacaoFinal : TDateTime = 0) : TJsonArray;
    Function GetPendente : TJsonArray;
    Function GetInventarioItens(pInventarioId : Integer; pShowErro : Integer) : TJsonArray;
    Function GetLoteInventariado(pInventarioId, pEnderecoId, pProdutoId, pTipo, pShowErro : Integer) : TJsonArray;
    Function ZerarEndereco(pInventarioId, pEnderecoId, pProdutoId  : Integer) : TJsonObject;
    Function Salvar(pListaEndereco : TJsonArray)  : TJsonObject;  //(pHistorico: THistorico)
    Function SaveContagem(pJsonArraycontagem : TJsonArray) : TJsonObject;
    Function GetContagem(pItem, pShowErro : Integer) : TJsonArray;
    Function LimparContagem(pInventarioId, pEnderecoId, pProdutoId : Integer) : TJsonArray;
    Function Delete : Boolean;
    Function Cancelar : Boolean;
    Function InventarioFechar : Boolean;
    Function GetDshInventarios(pDataInicial, pDataFinal : TDateTime; pInventarioIdInicial, pInventarioIdFinal : Integer) : TJsonObject;
    function SalvarModeloInventario(pJsonObject: TJsonObject): TJsonArray;
    function GetModeloLista(pModeloId : Integer) : TJsonArray;
    Function CongelarEstoqueInicial(pInventarioId, pInventarioTipo : Integer) : TJsonArray;
    Function GerarNovoInventarioModelo(pModeloId : integer) : TJsonArray;
    Function GetAjusteRelatorio(pInventarioId : Integer = 0; pDataCriacaoInicial : TDateTime = 0;
                                pDataCriacaoFinal : TDateTime = 0; pDataFinalizacaoInicial : TDateTime = 0;
                                pDataFinalizacaoFinal : TDateTime = 0; pProcessoId : Integer = 0; pInventarioTipo : Integer = 0;
                                pPendente : Integer = 0; pProdutoId : Integer = 0 ) : TJsonArray;
    Property ObjInventario : TInventario Read FObjInventario Write FObjInventario;
  End;

implementation

{ tCtrlInventario }

uses uDmeXactWMS, uFuncoes, InventarioDAO;

Function tInventarioCtrl.VerificaDados : Boolean;
Begin
  Result := False;

  Result := True;
End;

function TInventarioCtrl.ZerarEndereco(pInventarioId,
  pEnderecoId, pProdutoId : Integer): TJsonObject;
Var ObjInventarioDAO : TInventarioDAO;
Begin
  ObjInventarioDAO := TInventarioDAO.Create;
  Result := ObjInventarioDAO.ZerarEndereco(pInventarioId, pEnderecoId, pProdutoId );
  ObjInventarioDAO.Free;
end;

function TInventarioCtrl.Cancelar: Boolean;
Var ObjInventarioDAO : TInventarioDAO;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  ObjInventarioDAO.ObjInventario.InventarioId := Self.ObjInventario.InventarioId;
  Result := ObjInventarioDAO.Cancelar;
  if Result then
     Self.ObjInventario.InventarioId := 0;
  ObjInventarioDAO.Free;
end;

function TInventarioCtrl.CongelarEstoqueInicial(pInventarioId, pInventarioTipo : Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
begin
  Try
    ObjInventarioDAO := TInventarioDAO.Create;
    Result := ObjInventarioDAO.CongelarEstoqueInicial(pInventarioId, pInventarioTipo);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

constructor TInventarioCtrl.Create;
begin
  FObjInventario := TInventario.Create;
end;

function TInventarioCtrl.Delete : Boolean;
Var ObjInventarioDAO : TInventarioDAO;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  ObjInventarioDAO.ObjInventario.InventarioId := Self.ObjInventario.InventarioId;
  Result := ObjInventarioDAO.Delete;
  if Result then
     Self.ObjInventario.InventarioId := 0;
  ObjInventarioDAO.Free;
end;

destructor TInventarioCtrl.Destroy;
begin
  FreeAndNil(FObjInventario);
  inherited;
end;

function TInventarioCtrl.GerarNovoInventarioModelo(pModeloId: integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
    vErro         : String;
begin
  Try
    ObjInventarioDAO := TInventarioDAO.Create;
    Result := ObjInventarioDAO.GerarNovoInventarioModelo(pModeloId);
    ObjInventarioDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TInventarioCtrl.GetAjusteRelatorio(pInventarioId : Integer; pDataCriacaoInicial : TDateTime;
                                pDataCriacaoFinal : TDateTime; pDataFinalizacaoInicial : TDateTime;
                                pDataFinalizacaoFinal : TDateTime; pProcessoId : Integer; pInventarioTipo : Integer;
                                pPendente : Integer; pProdutoId : Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  Try
    Try
      Result := ObjInventarioDAO.GetAjusteRelatorio(pInventarioId, pDataCriacaoInicial,
                pDataCriacaoFinal, pDataFinalizacaoInicial, pDataFinalizacaoFinal, pProcessoId, PInventarioTipo,
                pPendente, pProdutoId);
    Except On E: Exception do  Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjInventarioDAO);
  End;
end;

function TInventarioCtrl.GetContagem(pItem, pShowErro : Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
    vErro         : String;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  Result := ObjInventarioDAO.GetContagem(pItem);
  ObjInventarioDAO.DisposeOf;
  If (pShowErro = 1) and (Result.Get(0).TryGetValue('Erro', vErro)) then
     Raise Exception.Create('Erro: '+vErro);
end;

function TInventarioCtrl.GetDshInventarios(pDataInicial, pDataFinal: TDateTime;
  pInventarioIdInicial, pInventarioIdFinal: Integer): TJsonObject;
Var ObjInventarioDAO : TInventarioDAO;
    vErro         : String;
begin
  Try
    Try
      ObjInventarioDAO := TInventarioDAO.Create;
      Result := ObjInventarioDAO.GetDshInventarios(pDataInicial, pDataFinal, pInventarioIdInicial, pInventarioIdFinal);
    Except On E: Exception do Begin
      Result := TJsonObject.Create;
      Result.AddPair('Erro', E.Message);
      End;
    End;
  Finally
   FreeAndNil(ObjInventarioDAO);
  End;
end;

function TInventarioCtrl.GetInventario(pInventarioId : Integer = 0; pDataCriacao : TDateTime = 0;
         pDataFinalizacao : TDateTime = 0; pDataCancelamento : TDateTime = 0; pProcessoId : Integer = 0;
         pTipo : Integer = 0; pPendente : Integer = 0; pProdutoId : Integer = 0; pShowErro : Integer = 1; pDataCriacaoFinal : TDateTime = 0): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
    vErro         : String;
begin
  Try
    Try
      ObjInventarioDAO := TInventarioDAO.Create;
      Result := ObjInventarioDAO.GetInventario(pInventarioId, pDataCriacao, pDataFinalizacao, pDataCancelamento, pProcessoid, pTipo, pPendente, pProdutoId, pDataCriacaoFinal);
      If (pShowErro = 1) and (Result.Get(0).TryGetValue('Erro', vErro)) then
         Raise Exception.Create('Erro: '+vErro);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjInventarioDAO);
  End;
end;

function TInventarioCtrl.GetInventarioItens(pInventarioId: Integer; pShowErro : Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
    vErro         : String;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  Result := ObjInventarioDAO.GetInventarioItens(pInventarioId);
  ObjInventarioDAO.Free;
  If (pShowErro = 1) and (Result.Get(0).TryGetValue('Erro', vErro)) then
     Raise Exception.Create('Erro: '+vErro);
end;

function TInventarioCtrl.GetLoteInventariado(pInventarioId, pEnderecoId, pProdutoId, pTipo, pShowErro : Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
    vErro         : String;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  Try
    Try
      Result := ObjInventarioDAO.GetLoteInventariado(pInventarioId, pEnderecoId, pProdutoId, pTipo, 1);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjInventarioDAO);
  End;
end;

function TInventarioCtrl.GetModeloLista(pModeloId: Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
begin
  Try
    Try
      ObjInventarioDAO := TInventarioDAO.Create;
      Result := ObjInventarioDAO.GetModeloLista(pModeloId);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjInventarioDAO);
  End;
end;

function TInventarioCtrl.GetPendente: TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
    vErro            : String;
begin
  ObjInventarioDAO := TInventarioDAO.Create;
  Result := ObjInventarioDAO.GetPendente;
  ObjInventarioDAO.Free;
end;

function TInventarioCtrl.InventarioFechar: Boolean;
Var ObjInventarioDAO : TInventarioDAO;
begin
  Try
    Try
      ObjInventarioDAO := TInventarioDAO.Create;
      ObjInventarioDAO.ObjInventario.InventarioId := Self.ObjInventario.InventarioId;
      Result := ObjInventarioDAO.InventarioFechar;
      if Result then
         Self.ObjInventario.InventarioId := 0;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(ObjInventarioDAO);
  End;
end;

function TInventarioCtrl.LimparContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjInventarioDAO := TInventarioDAO.Create;
  ObjInventarioDAO.ObjInventario := Self.ObjInventario;
  Result := ObjInventarioDAO.LimparContagem(pInventarioId, pEnderecoId, pProdutoId);
  ObjInventarioDAO.Free;
end;

function TInventarioCtrl.Salvar(pListaEndereco : TJsonArray) : TJsonObject;
Var ObjInventarioDAO : TInventarioDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjInventarioDAO := TInventarioDAO.Create;
  ObjInventarioDAO.ObjInventario := Self.ObjInventario;
  Result := ObjInventarioDAO.Salvar(pListaEndereco);
  Self.ObjInventario.InventarioId := Result.GetValue<Integer>('inventarioid');
  ObjInventarioDAO.Free;
end;

function TInventarioCtrl.SalvarModeloInventario(pJsonObject: TJsonObject): TJsonArray;
Var ObjInventarioDAO : TInventarioDAO;
begin
  Try
    ObjInventarioDAO := TInventarioDAO.Create;
    Result := ObjInventarioDAO.SalvarModeloInventario(pJsonObject);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TInventarioCtrl.SaveContagem(
  pJsonArraycontagem: TJsonArray): TJsonObject;
Var ObjInventarioDAO : TInventarioDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjInventarioDAO := TInventarioDAO.Create;
  Result := ObjInventarioDAO.SaveContagem(pJsonArraycontagem);
  ObjInventarioDAO.Free;
end;

End.

