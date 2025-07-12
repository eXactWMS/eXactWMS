{
  EntradasCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.DevolucaoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PedidoSaidaClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TDevolucaoCtrl = Class
  Private
    // Fun��es de Valida��o
    FDevolucao: TPedidoSaida;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjDevolucao: TPedidoSaida Read FDevolucao Write FDevolucao;
  End;

procedure Registry;
procedure GetDevolucao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPedidoSaida }

uses MService.DevolucaoDAO, uFuncoes;

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/devolucao', GetDevolucao)
    .Get('/devolucao/pendente', GetPendente)
    .Post('/devolucao', Insert)
    .Put('/devolucao/:pedidoid', Update)
    .Delete('/devolucao/:pedidoid', Delete)
    .Patch('/devolucao/cancelar/:pedidoid', Cancelar)
end;

Procedure GetDevolucao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DevolucaoDAO: TDevolucaoDao;
  AQueryParam: TDictionary<String, String>;
  vDataIni, vDataFin: TDateTime;
  vDocumentoNr, vRazao: String;
  vDevolucaoId, vCodigoERP, vPessoaId: Integer;
  vParamsOk: Integer;
  JsonErro: TJsonArray;
begin
  Try
    DevolucaoDAO := TDevolucaoDao.Create;
    try

        JsonErro := TJsonArray.Create();
        JsonErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          'Rota em desenvolvimento...')));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.Created);
        Exit;

      vDevolucaoId := 0;
      vDataIni := 0;
      vDataFin := 0;
      vDocumentoNr := '';
      vCodigoERP := 0;
      vPessoaId := 0;
      vRazao := '';
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        JsonErro := TJsonArray.Create();
        JsonErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          'Par�metros da consulta n�o definidos!')));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.Created);
        Exit;
      End;
      vParamsOk := 0;
      if AQueryParam.ContainsKey('dataini') then
      Begin
        Try
          vDataIni := StrToDate(AQueryParam.Items['dataini']);
          vParamsOk := vParamsOk + 1;
        Except
          Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
            'Data Final dos Pedidos � inv�lida!'))).Status(THTTPStatus.Created);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('datafin') then
      Begin
        Try
          vDataFin := StrToDate(AQueryParam.Items['datafin']);
          vParamsOk := vParamsOk + 1;
        Except
          Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
            'Data Final dos Pedidos � inv�lida!'))).Status(THTTPStatus.Created);
          Exit;
        End;
      End;
      if AQueryParam.ContainsKey('devolucaoid') then
      Begin
        vDevolucaoId := StrToIntDef(AQueryParam.Items['devolucaoid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('codigoerp') then
      Begin
        vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('pessoaid') then
      Begin
        vPessoaId := StrToIntDef(AQueryParam.Items['pessoaid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('documentonr') then
      Begin
        vDocumentoNr := AQueryParam.Items['documentonr'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('razao') then
      Begin
        vRazao := AQueryParam.Items['razao'];
        vParamsOk := vParamsOk + 1;
      End;
      if vParamsOk <> AQueryParam.Count then
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta definidos incorretamente!')))
          .Status(THTTPStatus.Created);
        Exit;
      End;
      Res.Send<TJsonArray>(DevolucaoDAO.GetDevolucao(vDevolucaoId, vDataIni,
        vDataFin, vCodigoERP, vPessoaId, vRazao, vDocumentoNr))
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
       Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(DevolucaoDAO);
  End;
End;

procedure GetPendente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DevolucaoDAO: TDevolucaoDao;
  JsonErro : TJsonArray;
begin
  Try
    try
      DevolucaoDAO := TDevolucaoDao.Create;

        JsonErro := TJsonArray.Create();
        JsonErro.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          'Rota em desenvolvimento...')));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.Created);
        Exit;

      Res.Send<TJsonArray>(DevolucaoDAO.GetPendente).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
       Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(DevolucaoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  DevolucaoDAO: TDevolucaoDao;
begin
  Try
    Try
      DevolucaoDAO := TDevolucaoDao.Create;
      DevolucaoDAO.Devolucao := DevolucaoDAO.Devolucao.JsonToClass
        (Req.Body<tJsonObject>.ToString());
      if DevolucaoDAO.Salvar then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Verifique a estrutura do json!')))
          .Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(DevolucaoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  DevolucaoDAO: TDevolucaoDao;
begin
  Try
    Try
      DevolucaoDAO := TDevolucaoDao.Create;
      DevolucaoDAO.Devolucao := DevolucaoDAO.Devolucao.JsonToClass
        (Req.Body<tJsonObject>.ToString());
      if DevolucaoDAO.Salvar then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message + #13 + #10 + 'Verifique a estrutura do json!')))
          .Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(DevolucaoDAO);
  End;
end;

procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  DevolucaoDAO: TDevolucaoDao;
begin
  Try
    Try
      DevolucaoDAO := TDevolucaoDao.Create;
      DevolucaoDAO.Devolucao.PedidoId :=
        StrToIntDef(Req.Params.Items['devolucaoid'], 0);
      DevolucaoDAO.Cancelar;
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Cancelado com Sucesso!'))).Status(THTTPStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(DevolucaoDAO);
  End;
  FreeAndNil(DevolucaoDAO);
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  DevolucaoDAO: TDevolucaoDao;
begin
  Try
    Try
      DevolucaoDAO := TDevolucaoDao.Create;
      DevolucaoDAO.Devolucao.PedidoId :=
        StrToIntDef(Req.Params.Items['devoucaoid'], 0);
      DevolucaoDAO.Delete;
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(DevolucaoDAO);
  End;
end;

constructor TDevolucaoCtrl.Create;
begin
  FDevolucao := TPedidoSaida.Create;
end;

destructor TDevolucaoCtrl.Destroy;
begin
  FDevolucao.Free;
  inherited;
end;

End.
