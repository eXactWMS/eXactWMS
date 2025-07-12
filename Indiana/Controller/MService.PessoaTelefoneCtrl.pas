{
  PessoaTelefoneCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PessoaTelefoneCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PessoaClass,
  Horse,
  System.JSON; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TPessoaTelefoneCtrl = Class
  Private
    // Funções de Validação
    FPessoaTelefone: TPessoaTelefone;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjPessoaTelefone: TPessoaTelefone Read FPessoaTelefone
      Write FPessoaTelefone;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPessoaTelefone }

uses MService.PessoaTelefoneDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/pessoatelefone', Get)
    .Get('/pessoatelefone/:indfone/:pessoaid', GetId)
    .Get('/pessoatelefone/estrutura', Get).Post('/pessoatelefone', Insert)
    .Put('/pessoatelefone', Update)
    .Delete('/pessoatelefone/:indfone/:pessoaid', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PessoaTelefoneDAO: TPessoaTelefoneDAO;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      PessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
      Res.Send<TJSonArray>(PessoaTelefoneDAO.Estrutura)
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
    FreeAndNil(PessoaTelefoneDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PessoaTelefoneDAO: TPessoaTelefoneDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      PessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
      Res.Send<TJSonArray>(PessoaTelefoneDAO.GetId(0, 0));
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
    FreeAndNil(PessoaTelefoneDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PessoaTelefoneDAO: TPessoaTelefoneDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      PessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
      Res.Send<TJSonArray>(PessoaTelefoneDAO.GetId(Req.Params.Items['indfone']
        .ToInteger, Req.Params.Items['pessoaid'].ToInteger))
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
    FreeAndNil(PessoaTelefoneDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPessoaTelefone: TJSONObject;
  PessoaTelefoneDAO: TPessoaTelefoneDAO;
begin
  Try
    Try
      PessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
      PessoaTelefoneDAO.ObjPessoaTelefoneDAO :=
        PessoaTelefoneDAO.ObjPessoaTelefoneDAO.JsonToClass
        (Req.Body<TJSONObject>.ToString); // jsonPessoaTelefone.ToString());
      PessoaTelefoneDAO.InsertUpdate;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PessoaTelefoneDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPessoaTelefone: TJSONObject;
  PessoaTelefoneDAO: TPessoaTelefoneDAO;
begin
  Try
    PessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
    Try
      jsonPessoaTelefone := TJSONObject.Create;
      jsonPessoaTelefone := Req.Body<TJSONObject>;
      PessoaTelefoneDAO.ObjPessoaTelefoneDAO :=
        PessoaTelefoneDAO.ObjPessoaTelefoneDAO.JsonToClass
        (jsonPessoaTelefone.ToString());
      PessoaTelefoneDAO.InsertUpdate;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(JsonPessoaTelefone);
    FreeAndNil(PessoaTelefoneDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  PessoaTelefoneDAO: TPessoaTelefoneDAO;
begin
  Try
    Try
      PessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
      PessoaTelefoneDAO.ObjPessoaTelefoneDAO.IndFone :=
        StrToIntDef(Req.Params.Items['indfone'], 0);
      PessoaTelefoneDAO.ObjPessoaTelefoneDAO.PessoaId :=
        StrToIntDef(Req.Params.Items['pessoaid'], 0);
      If PessoaTelefoneDAO.Delete Then
         Res.Status(200).Send<TJSONObject>
           (TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro excluído com Sucesso!'))).Status(THttpStatus.Created)
      Else
         raise Exception.Create('Não foi possível Excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PessoaTelefoneDAO);
  End;
end;

constructor TPessoaTelefoneCtrl.Create;
begin
  FPessoaTelefone := TPessoaTelefone.Create;
end;

destructor TPessoaTelefoneCtrl.Destroy;
begin
  FreeAndNil(FPessoaTelefone);
  inherited;
end;

End.
