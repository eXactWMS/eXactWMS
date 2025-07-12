{
   VolumeEmbalagemCtrl.Pas
   Criado por Genilson S Soares em 28/05/2021
   Projeto: eXactWMS
}
unit CargasCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
     Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , CargasClass;

Type
  TCargasCtrl = Class
  Private
    FObjCargas : TCargas;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function GetCargas(pCargaId : Integer; pDataInicial, pDataFinal : TDateTime;
                       pRota, pRotaIdFinal, pTransportadora, pMotorista : String; pVeiculoId : Integer; pPlaca, pProcesso : String; pShowErro: Integer) : TJsonArray;
    Function GetPedidosParaCargas(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : TJsonArray;
    Function GetPedidosParaCargasNFs(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : TJsonArray;
    Function GetCargaCarregarClientes(Const pCargaId, pShowErro  : Integer) : TJsonArray;
    Function GetCargaCarregarPedidos(Const pCargaId, pShowErro  : Integer) : TJsonArray;
    Function GetCargaCarregarVolumes(Const pCargaId, pPessoaId : Integer; pProcesso : String;
             pShowErro: Integer) : TJsonArray;
    Function CancelarCarregamento(Const pCargaId : Integer) : TJsonObject;
    Function CancelarConferencia(Const pCargaId : Integer) : TJsonObject;
    Function CancelarCarga(Const pJsonObject : TJsonObject) : TJsonObject;
    Function Salvar(pJsonCarga : TJsonObject) : TJsonObject;  //(pHistorico: THistorico)
    Function DelCargas : TJsonObject;
    Function RegistrarCarregamento(Const pJsonCarregamento : TJsonObject) : TJsonObject;
    Function FinalizarCarregamento(Const pJsonCarregamento : TJsonObject) : TJsonObject;
    Function GetCargaHeader(pCargaId : Integer; pShowErro : Integer) : TJsonArray;
    Function GetCargaPessoas(pCargaId : Integer; pProcesso : String; pShowErro : Integer) : TJsonArray;
    Function GetCargaPedidos(pCargaId : Integer; pPessoaId : Integer; pProcesso : String; pShowErro : Integer) : TJsonArray;
    Function GetCargaNF(pCargaId : Integer) : TJsonArray;
    Function GetCargaPedidosRomaneio(pCargaId : Integer; pPessoaId : Integer; pProcesso : String; pShowErro : Integer) : TJsonArray;
    Function GetCargaPedidoVolumes(pCargaId : Integer; pProcesso : String) : TJsonArray;
    Function GetCargaPedidoVolumesConferencia(pCargaId : Integer; pProcesso : String) : TJsonArray;
    function GetCargaPessoasPedido(pCargaId, pShowErro: Integer): TJsonArray;
    Function Lista(pCargaId : Integer = 0; pRotaId : Integer = 0; pProcessoId : Integer = 0; pPendente : integer = 0; pProcesso : String = 'CA') : TJsonArray;
    Function ResumoCarga(pDataInicial : TDateTime = 0; pDataFinal : TDateTime = 0; pRotaIdInicial : Integer = 0; RotaIdFinal : Integer = 0;
                        pProcessoId : Integer = 0; pPendente : integer = 0) : TJsonArray;
    Function GetRelAnaliseConsolidada(pPedidoId : Integer; pDataInicial, pDataFinal : TDateTime; pDocumentoNr : String;
                           pRotaInicialId, pRotaFinalId, pZonaId, pDestinatarioId,
                           pSomenteExpedido, pOrdem : Integer ) : TjsonArray;
    Function AtualizarStatus(pJsonObject : TJsonObject) : TJsonArray;
    Function GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem : Integer) : TJsonArray;
    Property ObjCargas : TCargas Read FObjCargas Write FObjCargas;
  End;

implementation

{ tCtrlCargas }

uses uDmeXactWMS, uFuncoes, CargasDAO;

Function tCargasCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  If Self.FObjCargas.Motorista.PessoaId = 0 Then
     raise Exception.Create('Informe o motorista responsável pela carga.');
  if Self.FObjCargas.Veiculo.VeiculoId = 0 then
     raise Exception.Create('Informe o veículo em que será realizado o transporte da carga.');
  Result := True;
End;

function TCargasCtrl.AtualizarStatus(pJsonObject: TJsonObject): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
Begin
  ObjCargasDAO := TCargasDAO.Create;
  Try
    Result := ObjCargasDAO.AtualizarStatus(pJsonObject);
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCargasCtrl.CancelarCarga(const pJsonObject: TJsonObject): TJsonObject;
Var ObjCargasDAO : TCargasDAO;
Begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    Result := ObjCargasDAO.CancelarCarga(pJsonObject);
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

function TCargasCtrl.CancelarCarregamento(const pCargaId: Integer): TJsonObject;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    ObjCargasDAO.ObjCargas.CargaId := pCargaId;
    Result := ObjCargasDAO.CancelarCarregamento;
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonObject.Create.AddPair('Erro', E.Message);
    End;
  End;
end;

function TCargasCtrl.CancelarConferencia(const pCargaId: Integer): TJsonObject;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    ObjCargasDAO.ObjCargas.CargaId := pCargaId;
    Result := ObjCargasDAO.CancelarConferencia;
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonObject.Create.AddPair('Erro', E.Message);
    End;
  End;
end;

constructor TCargasCtrl.Create;
begin
  FObjCargas := TCargas.Create;
end;

function TCargasCtrl.DelCargas : TJsonObject;
Var ObjCargasDAO : TCargasDAO;
    vErro        : String;
begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    ObjCargasDAO.ObjCargas.CargaId := Self.ObjCargas.CargaId;
    Result := ObjCargasDAO.Delete;
    if Not Result.TryGetValue('Erro', vErro) then
       Self.ObjCargas.CargaId := 0;
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result := TJsonObject.Create.AddPair('Erro', E.Message);
    End;
  End;
end;

destructor TCargasCtrl.Destroy;
begin
  FreeAndNil(FObjCargas);
  inherited;
end;

function TCargasCtrl.FinalizarCarregamento(const pJsonCarregamento: TJsonObject): TJsonObject;
Var ObjCargasDAO : TCargasDAO;
Begin
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.FinalizarCarregamento(pJsonCarregamento);
  ObjCargasDAO.Free;
end;

function TCargasCtrl.GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    Try
      ObjCargasDAO := TCargasDAO.Create;
      Result := ObjCargasDAO.GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem);
    Except On E: Exception do
      Raise Exception.Create('Erro: '+E.Message);
    End;
  Finally
      FreeAndNil(ObjCargasDAO);
  End;
end;

function TCargasCtrl.GetCargaCarregarClientes(
  const pCargaId, pShowErro : Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaCarregarClientes(pCargaId, pShowErro);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetCargaCarregarPedidos(const pCargaId, pShowErro : Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaCarregarPedidos(pCargaId, pShowErro);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetCargaCarregarVolumes(const pCargaId, pPessoaId : Integer; pProcesso : String;
  pShowErro: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaCarregarVolumes(pCargaId, pProcesso, pShowErro);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetCargaHeader(pCargaId, pShowErro: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaHeader(pCargaId);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetCargaNF(pCargaId: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    Result := ObjCargasDAO.GetCargaNF(pCargaId);
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
     End;
  End;
end;

function TCargasCtrl.GetCargaPedidos(pCargaId : Integer; pPessoaId : Integer; pProcesso : String; pShowErro : Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaPedidos(pCargaId, pPessoaId, pProcesso);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetCargaPedidosRomaneio(pCargaId, pPessoaId: Integer;
  pProcesso: String; pShowErro: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaPedidosRomaneio(pCargaId, pPessoaId, pProcesso);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetCargaPedidoVolumes(pCargaId: Integer; pProcesso : String): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  //Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaPedidoVolumes(pCargaId, pProcesso);
  FreeAndNil(ObjCargasDAO);
end;

function TCargasCtrl.GetCargaPessoasPedido(pCargaId, pShowErro: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargaPessoasPedidos(pCargaId);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;


function TCargasCtrl.GetCargaPedidoVolumesConferencia(pCargaId: Integer; pProcesso : String): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  //Result     := TJsonArray.Create;
  Try
    Try
      ObjCargasDAO := TCargasDAO.Create;
      Result := ObjCargasDAO.GetCargaPedidoVolumesConferencia(pCargaId, pProcesso);
    Except On E: Exception do
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  Finally
    FreeAndNil(ObjCargasDAO);
  End;
end;

function TCargasCtrl.GetCargaPessoas(pCargaId : Integer; pProcesso : String; pShowErro: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    Try
      ObjCargasDAO := TCargasDAO.Create;
      Result := ObjCargasDAO.GetCargaPessoas(pCargaId, pProcesso);
      if (Result.Count < 1) and (pShowErro = 1) then
         Raise Exception.Create('Registro de Carga não encontrado');
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjCargasDAO);
  End;
end;

function TCargasCtrl.GetCargas(pCargaId : Integer; pDataInicial, pDataFinal : TDateTime;
                       pRota, pRotaIdFinal, pTransportadora, pMotorista : String; pVeiculoId : Integer; pPlaca, pProcesso : String; pShowErro: Integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetCargas(pCargaId, pDataInicial, pDataFinal, pRota, pRotaIdFinal,
            pTransportadora, pMotorista, pVeiculoId, pPlaca, pProcesso);
  FreeAndNil(ObjCargasDAO);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Erro: Registro de Carga não encontrado');
end;

function TCargasCtrl.GetPedidosParaCargas(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    Result := ObjCargasDAO.GetPedidosParaCargas(pDataInicial, pDataFinal, pCodPessoaERP, pRota, pZonaId, pProcesso);
  Except On E: Exception do Begin
    Result     := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
  FreeAndNil(ObjCargasDAO);
end;

function TCargasCtrl.GetPedidosParaCargasNFs(pDataInicial, pDataFinal: TDateTime; pCodPessoaERP, pRota, pZonaId, pProcesso: integer) : TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Result     := TJsonArray.Create;
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.GetPedidosParaCargasNFs(pDataInicial, pDataFinal, pCodPessoaERP, pRota, pZonaId, pProcesso);
  FreeAndNil(ObjCargasDAO);
end;

function TCargasCtrl.GetRelAnaliseConsolidada(pPedidoId: Integer; pDataInicial,
  pDataFinal: TDateTime; pDocumentoNr : String; pRotaInicialId, pRotaFinalId, pZonaId, pDestinatarioId,
  pSomenteExpedido, pOrdem: Integer): TjsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  Try
    ObjCargasDAO := TCargasDAO.Create;
    Result := ObjCargasDAO.GetRelAnaliseConsolidada(pPedidoId, pDataInicial, pDataFinal, pDocumentoNr,
              pRotaInicialId, pRotaFinalId, pZonaId, pDestinatarioId, pSomenteExpedido, pOrdem);
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TCargasCtrl.Lista(pCargaId, pRotaId, pProcessoId, pPendente : Integer; pProcesso : String): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
Begin
  Try
    Try
      ObjCargasDAO := TCargasDAO.Create;
      Result := ObjCargasDAO.Lista(pCargaId, pRotaId, pProcessoId, pPendente, pProcesso);
    Except On E: Exception do Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  Finally
    FreeAndNil(ObjCargasDAO);
  End;
end;

function TCargasCtrl.RegistrarCarregamento(const pJsonCarregamento : TJsonObject): TJsonObject;
Var ObjCargasDAO : TCargasDAO;
Begin
  ObjCargasDAO := TCargasDAO.Create;
  Result := ObjCargasDAO.RegistrarCarregamento(pJsonCarregamento);
  FreeAndNil(ObjCargasDAO);
end;

function TCargasCtrl.ResumoCarga(pDataInicial, pDataFinal: TDateTime;
  pRotaIdInicial, RotaIdFinal, pProcessoId, pPendente: integer): TJsonArray;
Var ObjCargasDAO : TCargasDAO;
begin
  ObjCargasDAO := TCargasDAO.Create;
  Try
    Result := ObjCargasDAO.ResumoCarga(pDataInicial, pDataFinal, pRotaIdInicial, RotaIdFinal,
              pProcessoId, pPendente);
    FreeAndNil(ObjCargasDAO);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End
  End;
end;

function TCargasCtrl.Salvar(pJsonCarga : TJsonObject) : TJsonObject;
Var ObjCargasDAO : TCargasDAO;
    vErro : String;
Begin
  if Not VerificaDados then
     Exit;
  ObjCargasDAO := TCargasDAO.Create;
  ObjCargasDAO.ObjCargas := Self.ObjCargas;
  Result := ObjCargasDAO.Salvar(pJsonCarga);
  if Not Result.TryGetValue('Erro', vErro) then
     Self.ObjCargas.CargaId := 0;
  FreeAndNil(ObjCargasDAO);
end;

End.

