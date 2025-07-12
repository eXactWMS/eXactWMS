{
  Micro Servico - Controller - operacaonaturezamotivoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys) em 30/03/2022
  Projeto: eXactWMSIndiana
}

unit MService.operacaonaturezamotivoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Horse, System.Json,
  operacaonaturezamotivoClass;

Type

  ToperacaonaturezamotivoCtrl = Class
  Private
    Foperacaonaturezamotivo: Toperacaonaturezamotivo;
  Public
    constructor Create;
    destructor Destroy; override;
    Property Objoperacaonaturezamotivo: Toperacaonaturezamotivo
      Read Foperacaonaturezamotivo Write Foperacaonaturezamotivo;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrloperacaonaturezamotivo }

uses MService.operacaonaturezamotivoDAO, uFuncoes;

procedure Registry;
Begin
  THorse.Group.Prefix('v1').Get('/operacaonaturezamotivo', Get)
    .Post('/operacaonaturezamotivo', Insert)
    .Put('/operacaonaturezamotivo/:motivoid', Update)
    .Delete('/operacaonaturezamotivo/:motivoid', Delete)
    .Patch('/operacaonaturezamotivo/cancelar/:motivoid', Cancelar)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  operacaonaturezamotivoDAO: ToperacaonaturezamotivoDao;
  AQueryParam: TDictionary<String, String>;
  JsonErro: TJsonObject;
  vParamsOk: Integer;
  vmotivoid: Integer;
  vdescricao: String;
  ErroJsonArray : TjsonArray;
Begin
  Try
    Try
      vmotivoid := 0;
      vdescricao := '';
      vParamsOk := 0;
      AQueryParam := Req.Query.Dictionary;
      if AQueryParam.ContainsKey('motivoid') then
      Begin
        vmotivoid := StrToIntDef(AQueryParam.Items['motivoid'], 0);
        Inc(vParamsOk);
      End;
      if AQueryParam.ContainsKey('descricao') then
      Begin
        vdescricao := AQueryParam.Items['descricao'];
        Inc(vParamsOk);
      End;
      if vParamsOk <> AQueryParam.Count then
      Begin
        Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Erro',
          'Parâmetros da consulta definidos incorretamente!')))
          .Status(THTTPStatus.Created);
        Exit;
      End;
      operacaonaturezamotivoDAO := ToperacaonaturezamotivoDao.Create;
      Res.Send<TJSonArray>(operacaonaturezamotivoDAO.Get(vmotivoid, vdescricao))
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(operacaonaturezamotivoDAO);
  End;
End;

Procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  operacaonaturezamotivoDAO: ToperacaonaturezamotivoDao;
Begin
  Try
    Try
      operacaonaturezamotivoDAO := ToperacaonaturezamotivoDao.Create;
      Res.Send<TJsonObject>(operacaonaturezamotivoDAO.InsertUpdate
        (Req.Body<TJsonObject>));
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJsonObject>
          (TJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(operacaonaturezamotivoDAO);
  End;
End;

Procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  operacaonaturezamotivoDAO: ToperacaonaturezamotivoDao;
Begin
  Try
    Try
      operacaonaturezamotivoDAO := ToperacaonaturezamotivoDao.Create;
      Res.Send<TJsonObject>(operacaonaturezamotivoDAO.InsertUpdate
        (Req.Body<TJsonObject>));
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJsonObject>
          (TJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(operacaonaturezamotivoDAO);
  End;
End;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  operacaonaturezamotivoDAO: ToperacaonaturezamotivoDao;
begin
  Try
    operacaonaturezamotivoDAO := ToperacaonaturezamotivoDao.Create;
    operacaonaturezamotivoDAO.Delete
      (StrToIntDef(Req.Params.Items['motivoid'], 0));
    Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
      'Registro Excluído com Sucesso!'))).Status(THTTPStatus.NoContent);
  Except
    on E: Exception do
    Begin
      Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
        E.Message))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;
end;

procedure Cancelar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  operacaonaturezamotivoDAO: ToperacaonaturezamotivoDao;
begin
  Try
    Try
      operacaonaturezamotivoDAO := ToperacaonaturezamotivoDao.Create;
      operacaonaturezamotivoDAO.Cancelar(Req.Body<TJsonObject>);
      Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Cancelado com Sucesso!'))).Status(THTTPStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(operacaonaturezamotivoDAO);
  End;
end;

constructor ToperacaonaturezamotivoCtrl.Create;
begin
  Foperacaonaturezamotivo := Toperacaonaturezamotivo.Create;
end;

destructor ToperacaonaturezamotivoCtrl.Destroy;
begin
  FreeAndNil(Foperacaonaturezamotivo);
  inherited;
end;

End.
