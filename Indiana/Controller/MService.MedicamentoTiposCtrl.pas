{
  MedicamentoTipoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
Unit MService.MedicamentoTiposCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  MedicamentoTipoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TMedicamentoTiposCtrl = Class
  Private
    // Funções de Validação
    FMedicamentoTipo: TMedicamentoTipo;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjMedicamentoTipo: TMedicamentoTipo Read FMedicamentoTipo
      Write FMedicamentoTipo;
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

{ tCtrlMedicamentoTipo }

uses MService.MedicamentoTipoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/medicamentotipo', Get)
    .Get('/medicamentotipo/:id', GetID).Get('/medicamentotipo/:id/:descricao',
    GetDescricao).Get('/medicamentotipo/estrutura', GetID)
    .Post('/medicamentotipo', Insert).Put('/medicamentotipo/:id', Update)
    .Delete('/medicamentotipo/:id', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
  JsonArrayRetorno : TJsonArray;
Begin
  Try
    Try
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      Res.Send<TJSonArray>(MedicamentoTipoDAO.Estrutura)
        .Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(MedicamentoTipoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      Res.Send<TJSonArray>(MedicamentoTipoDAO.GetID(0));
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(MedicamentoTipoDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
  JsonArrayRetorno : TjsonArray;
begin
  Try
    try
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      Res.Send<TJSonArray>(MedicamentoTipoDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(MedicamentoTipoDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      if StrToInt64Def(Req.Params.Items['id'], 0) > 0 then
        Res.Send<TJSonArray>
          (MedicamentoTipoDAO.GetID(StrToIntDef(Req.Params.Items['id'], 0)))
          .Status(THttpStatus.Created)
      Else
        Res.Send<TJSonArray>(MedicamentoTipoDAO.GetDescricao(Req.Params.Items
          ['id'])).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJSonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJSonArray>(JsonArrayRetorno)
          .Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(MedicamentoTipoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjMedicamentoTipo: TJSONObject;
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
begin
  Try
    Try
      ObjMedicamentoTipo := TJSONObject.Create;
      ObjMedicamentoTipo := Req.Body<TJSONObject>;
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      MedicamentoTipoDAO.InsertUpdate(GetValueInjSon(ObjMedicamentoTipo, 'id')
        .ToInteger(), GetValueInjSon(ObjMedicamentoTipo, 'descricao'));
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
    FreeAndNil(ObjMedicamentoTipo);
    FreeAndNil(MedicamentoTipoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjMedicamentoTipo: TJSONObject;
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
begin
  Try
    Try
      ObjMedicamentoTipo := TJSONObject.Create;
      ObjMedicamentoTipo := Req.Body<TJSONObject>;
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      MedicamentoTipoDAO.InsertUpdate(StrToIntDef(Req.Params.Items['id'], 0),
        Req.Params.Items['descricao']);
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
    FreeAndNil(ObjMedicamentoTipo);
    FreeAndNil(MedicamentoTipoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  MedicamentoTipoDAO: TMedicamentoTipoDAO;
begin
  Try
    Try
      MedicamentoTipoDAO := TMedicamentoTipoDAO.Create;
      MedicamentoTipoDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(MedicamentoTipoDAO);
  End;
end;

constructor TMedicamentoTiposCtrl.Create;
begin
  FMedicamentoTipo := TMedicamentoTipo.Create;
end;

destructor TMedicamentoTiposCtrl.Destroy;
begin
  FreeAndNil(FMedicamentoTipo);
  inherited;
end;

End.
