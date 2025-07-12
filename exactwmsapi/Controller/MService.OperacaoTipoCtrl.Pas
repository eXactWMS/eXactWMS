{
  Micro Servico - Controller - tipomovimentacaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.OperacaoTipoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  OperacaoTipoClass,
  Horse,
  System.JSON;

Type

  TOperacaoTipoCtrl = Class
  Private
    FOperacaoTipo: TOperacaoTipo;
  Public
    constructor Create;
    destructor Destroy; override;
    Property ObjOperacaoTipo: TOperacaoTipo Read FOperacaoTipo
      Write FOperacaoTipo;
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

{ tCtrlOperacaoTipo }

uses MService.OperacaoNaturezaCtrl, MService.OperacaoTipoDAO, uFuncoes;

procedure Registry;
begin
  THorse.Get('/v1/operacaotipo', Get);
  THorse.Get('/v1/operacaotipo/:id', GetID);
  THorse.Get('/v1/operacaotipo/:id/:descricao', GetDescricao);
  THorse.Get('/v1/operacaotipo/estrutura', Estrutura);
  THorse.Post('/v1/operacaotipo', Insert);
  THorse.Put('/v1/operacaotipo/:id', Update);
  THorse.Delete('/v1/operacaotipo/:id', Delete);
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoTipoDAO: TOperacaoTipoDAO;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      Res.Send<TJSonArray>(OperacaoTipoDAO.Estrutura).Status(THttpStatus.Created);
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
    FreeAndNil(OperacaoTipoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoTipoDAO: TOperacaoTipoDAO;
  ErroJsonArray : TJSonArray;
begin
  Try
    Try
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      Res.Send<TJSonArray>(OperacaoTipoDAO.GetID(0));
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
    FreeAndNil(OperacaoTipoDAO);
  End;end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoTipoDAO: TOperacaoTipoDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      Res.Send<TJSonArray>(OperacaoTipoDAO.GetDescricao(Req.Params.Items
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
    FreeAndNil(OperacaoTipoDAO);
  End;End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  OperacaoTipoDAO: TOperacaoTipoDAO;
  ErroJsonArray : TjsonArray;
begin
  Try
    try
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      Res.Send<TJSonArray>
        (OperacaoTipoDAO.GetID(StrToIntDef(Req.Params.Items['id'], 0)))
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
    FreeAndNil(OperacaoTipoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjOperacaoTipo: TJSONObject;
  OperacaoTipoDAO: TOperacaoTipoDAO;
begin
  Try
    Try
      ObjOperacaoTipo := TJSONObject.Create;
      ObjOperacaoTipo := Req.Body<TJSONObject>;
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      OperacaoTipoDAO.InsertUpdate(GetValueInjSon(ObjOperacaoTipo,
        'operacaotipoid').ToInteger, GetValueInjSon(ObjOperacaoTipo, 'descricao'),
        GetValueInjSon(ObjOperacaoTipo, 'operacaonaturezaid').ToInteger,
        GetValueInjSon(ObjOperacaoTipo, 'Status').ToInteger);
      ObjOperacaoTipo := Nil;
      ObjOperacaoTipo.DisposeOf;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(OperacaoTipoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjOperacaoTipo: TJSONObject;
  OperacaoTipoDAO: TOperacaoTipoDAO;
begin
  Try
    Try
      ObjOperacaoTipo := TJSONObject.Create;
      ObjOperacaoTipo := Req.Body<TJSONObject>;
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      OperacaoTipoDAO.InsertUpdate(GetValueInjSon(ObjOperacaoTipo,
        'operacaotipod').ToInteger, GetValueInjSon(ObjOperacaoTipo, 'Descricao'),
        GetValueInjSon(ObjOperacaoTipo, 'operacaonaturezaid').ToInteger,
        GetValueInjSon(ObjOperacaoTipo, 'Status').ToInteger);
      ObjOperacaoTipo := Nil;
      ObjOperacaoTipo.DisposeOf;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(OperacaoTipoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  OperacaoTipoDAO: TOperacaoTipoDAO;
begin
  Try
    Try
      OperacaoTipoDAO := TOperacaoTipoDAO.Create;
      OperacaoTipoDAO.Delete(StrToIntDef(Req.Params.Items['operacaotipoid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(OperacaoTipoDAO);
  End;
end;

constructor TOperacaoTipoCtrl.Create;
begin
  FOperacaoTipo := TOperacaoTipo.Create;
end;

destructor TOperacaoTipoCtrl.Destroy;
begin
  FreeAndNil(FOperacaoTipo);
  inherited;
end;

End.
