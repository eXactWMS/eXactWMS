{
  Micro Servico - Controller - tipooperacaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.OperacaoNaturezaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  operacaoNaturezaClass,
  Horse,
  System.JSON;

Type

  TOperacaoNaturezaCtrl = Class
  Private
    FOperacaoNatureza: TOperacaoNatureza;
  Public
    constructor Create;
    destructor Destroy; override;
    Property Objtipooperacao: TOperacaoNatureza Read FOperacaoNatureza
      Write FOperacaoNatureza;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrltipooperacao }

uses MService.OperacaoNaturezaDAO, uFuncoes;

procedure Registry;
begin
  THorse.Get('/v1/operacaonatureza', Get);
  THorse.Get('/v1/operacaonatureza/:operacaonaturezaid', GetID);
  THorse.Get('/v1/operacaonatureza/:operacaonaturezaid/:descricao',
    GetDescricao);
  THorse.Get('/v1/operacaonatureza/estrutura', Estrutura);
  THorse.Post('/v1/operacaonatureza', Insert);
  THorse.Put('/v1/operacaonatureza/:operacaonaturezaid', Update);
  THorse.Delete('/v1/operacaonatureza/:operacaonaturezaid', Delete);
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      Res.Send<TJSonArray>(OperacaoNaturezaDAO.Estrutura)
        .Status(THttpStatus.Created);
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
    FreeAndNil(OperacaoNaturezaDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      Res.Send<TJSonArray>(OperacaoNaturezaDAO.GetID(0));
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
    FreeAndNil(OperacaoNaturezaDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
  ErroJsonArray : TjsonArray;
begin
  Try
    try
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      Res.Send<TJSonArray>(OperacaoNaturezaDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
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
    FreeAndNil(OperacaoNaturezaDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      Res.Send<TJSonArray>(OperacaoNaturezaDAO.GetID
        (StrToIntDef(Req.Params.Items['operacaonaturezaid'], 0)))
        .Status(THttpStatus.Created);
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
    FreeAndNil(OperacaoNaturezaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjOperacaoNatureza: TJSONObject;
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      ObjOperacaoNatureza := TJSONObject.Create;
      ObjOperacaoNatureza := Req.Body<TJSONObject>;
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      OperacaoNaturezaDAO.InsertUpdate(GetValueInjSon(ObjOperacaoNatureza,
        'operacaonaturezaid').ToInteger, GetValueInjSon(ObjOperacaoNatureza,
        'descricao'), GetValueInjSon(ObjOperacaoNatureza, 'tipo'));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjOperacaoNatureza);
    FreeAndNil(OperacaoNaturezaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjOperacaoNatureza: TJSONObject;
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
begin
  Try
    Try
      ObjOperacaoNatureza := TJSONObject.Create;
      ObjOperacaoNatureza := Req.Body<TJSONObject>;
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      OperacaoNaturezaDAO.InsertUpdate
        (StrToIntDef(Req.Params.Items['operacaonaturezaid'], 0),
        GetValueInjSon(ObjOperacaoNatureza, 'descricao'),
        GetValueInjSon(ObjOperacaoNatureza, 'tipo'));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjOperacaoNatureza);
    FreeAndNil(OperacaoNaturezaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  OperacaoNaturezaDAO: TOperacaoNaturezaDAO;
begin
  Try
    Try
      OperacaoNaturezaDAO := TOperacaoNaturezaDAO.Create;
      If OperacaoNaturezaDAO.Delete(StrToIntDef(Req.Params.Items['operacaonaturezaid'], 0)) then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent)
      Else
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Não foi possível Excluiur o Registro!'))).Status(THttpStatus.NoContent)
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(OperacaoNaturezaDAO);
  End;
end;

constructor TOperacaoNaturezaCtrl.Create;
begin
  FOperacaoNatureza := TOperacaoNatureza.Create;
end;

destructor TOperacaoNaturezaCtrl.Destroy;
begin
  FreeAndNil(FOperacaoNatureza);
  inherited;
end;

End.
