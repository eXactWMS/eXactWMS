{
  MService.pessoatiposCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PessoaTipoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  pessoatipoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TpessoatipoCtrl = Class
  Private
    // Funções de Validação
    Fpessoatipo: Tpessoatipo;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property Objpessoatipo: Tpessoatipo Read Fpessoatipo Write Fpessoatipo;
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

{ tCtrlpessoatipo }

uses upessoatipoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/pessoatipo', Get);
  THorse.Get('/v1/pessoatipo/:pessoatipoid', GetID);
  THorse.Get('/v1/pessoatipo/:pessoatipoid/:descricao', GetDescricao);
  THorse.Get('/v1/pessoatipo/estrutura', Estrutura);
  THorse.Post('/v1/pessoatipo', Insert);
  THorse.Put('/v1/pessoatipo/:pessoatipoid', Update);
  THorse.Delete('/v1/pessoatipo/:pessoatipoid', Delete);
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoatipoDAO: TpessoatipoDAO;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      pessoatipoDAO := TpessoatipoDAO.Create;
      Res.Send<TJSonArray>(pessoatipoDAO.Estrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoatipoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoatipoDAO: TpessoatipoDAO;
  ErroJsonArray : TjsonArray;
begin
  Try
    Try
      pessoatipoDAO := TpessoatipoDAO.Create;
      Res.Send<TJSonArray>(pessoatipoDAO.GetID(0));
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoatipoDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoatipoDAO: TpessoatipoDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      pessoatipoDAO := TpessoatipoDAO.Create;
      Res.Send<TJSonArray>(pessoatipoDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoatipoDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoatipoDAO: TpessoatipoDAO;
  ErroJsonArray : TjsonArray;
begin
  Try
    try
      pessoatipoDAO := TpessoatipoDAO.Create;
      Res.Send<TJSonArray>
        (pessoatipoDAO.GetID(StrToIntDef(Req.Params.Items['pessoatipoid'], 0)))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoatipoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  Objpessoatipo: TJSONObject;
  pessoatipoDAO: TpessoatipoDAO;
begin
  Try
    Try
      Objpessoatipo := TJSONObject.Create;
      Objpessoatipo := Req.Body<TJSONObject>;
      pessoatipoDAO := TpessoatipoDAO.Create;
      pessoatipoDAO.InsertUpdate(GetValueInjSon(Objpessoatipo, 'pessoatipoid')
        .ToInteger, // Objpessoatipo.Get('descricao').JsonValue.Value
        GetValueInjSon(Objpessoatipo, 'descricao'), GetValueInjSon(Objpessoatipo,
        'status').ToInteger);
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
    FreeAndNil(ObjPessoaTipo);
    FreeAndNil(pessoatipoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  Objpessoatipo: TJSONObject;
  pessoatipoDAO: TpessoatipoDAO;
begin
  Try
    Try
      Objpessoatipo := TJSONObject.Create;
      Objpessoatipo := Req.Body<TJSONObject>;
      pessoatipoDAO := TpessoatipoDAO.Create;
      pessoatipoDAO.InsertUpdate(StrToIntDef(Req.Params.Items['pessoatipoid'], 0),
        // Objpessoatipo.Get('descricao').JsonValue.Value
        GetValueInjSon(Objpessoatipo, 'descricao'), GetValueInjSon(Objpessoatipo,
        'status').ToInteger);
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
    FreeAndNil(ObjPessoaTipo);
    FreeAndNil(pessoatipoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  pessoatipoDAO: TpessoatipoDAO;
begin
  Try
    Try
      pessoatipoDAO := TpessoatipoDAO.Create;
      If pessoatipoDAO.Delete(StrToIntDef(Req.Params.Items['pessoatipoid'], 0)) then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Alterado com Sucesso!'))).Status(THttpStatus.Ok)
      Else
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Não foi possível Excluir o Registro!'))).Status(THttpStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(pessoatipoDAO);
  End;
end;

constructor TpessoatipoCtrl.Create;
begin
  Fpessoatipo := Tpessoatipo.Create;
end;

destructor TpessoatipoCtrl.Destroy;
begin
  FreeAndNil(Fpessoatipo);
  inherited;
end;

End.
