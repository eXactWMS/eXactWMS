{
  VeiculoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
Unit MService.VeiculoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  VeiculoClass,
  Horse,
  System.Types,
  System.JSON,
  System.JSON.Types;

Type

  TVeiculoCtrl = Class
  Private
    FObjVeiculo: TVeiculo;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjVeiculo: TVeiculo Read FObjVeiculo Write FObjVeiculo;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InsertUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlVeiculo }

uses MService.VeiculoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/veiculo', Get).Get('/veiculos4D', Get4D)
    .Post('/veiculo', InsertUpdate).Put('/veiculo', InsertUpdate)
    .Delete('/veiculo/:veiculoid', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  VeiculoDAO: TVeiculoDao;
  AQueryParam: TDictionary<String, String>;
  pVeiculoId, pTransportadoraId: Integer;
  pPlaca: String;
  RetornoErro : TJsonArray;
begin
  Try
    VeiculoDAO := TVeiculoDao.Create;
    Try
      pVeiculoId := 0;
      pPlaca := '';
      pTransportadoraId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 0 then
      Begin
        if AQueryParam.ContainsKey('veiculoid') then
          pVeiculoId := StrToIntDef(AQueryParam.Items['veiculoid'], 0);
        if AQueryParam.ContainsKey('placa') then
          pPlaca := AQueryParam.Items['placa'];
        if AQueryParam.ContainsKey('transportadoraid') then
          pTransportadoraId :=
            StrToIntDef(AQueryParam.Items['transportadoraid'], 0);
      End;
      Res.Status(200).Send<TJSonArray>(VeiculoDAO.Get(pVeiculoId, pPlaca,
        pTransportadoraId));
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VeiculoDAO);
  End;
end;

procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  VeiculoDAO: TVeiculoDao;
begin
  Try
    Try
      VeiculoDAO := TVeiculoDao.Create;
      Res.Send(VeiculoDAO.Get4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VeiculoDAO);
  End;
End;

procedure InsertUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjVeiculoDAO: TVeiculoDao;
begin
  Try
    Try
      ObjVeiculoDAO := TVeiculoDao.Create;
      ObjVeiculoDAO.ObjVeiculo := ObjVeiculoDAO.ObjVeiculo.JsonToClass
        (Req.Body<TJSONObject>.ToJson);
      ObjVeiculoDAO.InsertUpdate(ObjVeiculoDAO.ObjVeiculo);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(ObjVeiculoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  VeiculoDAO: TVeiculoDao;
begin
  Try
    VeiculoDAO := TVeiculoDao.Create;
    If VeiculoDAO.Delete(StrToIntDef(Req.Params.Items['veiculoid'], 0)) then
       Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
         'Registro Excluído com Sucesso!'))).Status(THTTPStatus.Created)
    Else
       raise Exception.Create('Não foi possível Excluir o registro!');
  Except
    on E: Exception do
    Begin
      Res.Status(500).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)))
        .Status(THTTPStatus.ExpectationFailed); // Status(THTTPStatus.Created);
    End;
  End;
end;

constructor TVeiculoCtrl.Create;
begin
  FObjVeiculo := TVeiculo.Create;
end;

destructor TVeiculoCtrl.Destroy;
begin
  FreeAndNil(FObjVeiculo);
  inherited;
end;

End.
