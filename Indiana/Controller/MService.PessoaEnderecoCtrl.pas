{
  PessoaEnderecoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PessoaEnderecoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PessoaClass,
  Horse,
  System.JSON; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TPessoaEnderecoCtrl = Class
  Private
    // Funções de Validação
    FPessoaEndereco: TPessoaEndereco;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjPessoaEndereco: TPessoaEndereco Read FPessoaEndereco
      Write FPessoaEndereco;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPessoaEndereco }

uses MService.PessoaEnderecoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/pessoaendereco', Get)
    .Get('/pessoaendereco/:id/:pessoaid', GetId)
    .Get('/pessoaendereco/estrutura', Estrutura)
    .Post('/pessoaendereco', Insert)
    .Put('/pessoaendereco/:id', Update)
    .Delete('/pessoaendereco/:id', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PessoaEnderecoDAO: TPessoaEnderecoDAO;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      PessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
      Res.Send<TJSonArray>(PessoaEnderecoDAO.Estrutura)
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
    FreeAndNil(PessoaEnderecoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PessoaEnderecoDAO: TPessoaEnderecoDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      PessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
      Res.Send<TJSonArray>(PessoaEnderecoDAO.GetId(0, 0)).Status(THTTPStatus.Ok);
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
    FreeAndNil(PessoaEnderecoDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PessoaEnderecoDAO: TPessoaEnderecoDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      PessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
      Res.Send<TJSonArray>(PessoaEnderecoDAO.GetId(Req.Params.Items['id']
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
    FreeAndNil(PessoaEnderecoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPessoaEndereco: TJSONObject;
  PessoaEnderecoDAO: TPessoaEnderecoDAO;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      PessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
      PessoaEnderecoDAO.ObjPessoaEnderecoDAO :=
        PessoaEnderecoDAO.ObjPessoaEnderecoDAO.JsonToClass
        (Req.Body<TJSONObject>.ToString); // jsonPessoaEndereco.ToString());
      PessoaEnderecoDAO.InsertUpdate;
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
    FreeAndNil(PessoaEnderecoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonPessoaEndereco: TJSONObject;
  PessoaEnderecoDAO: TPessoaEnderecoDAO;
begin
  Try
    Try
      PessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
      jsonPessoaEndereco := TJSONObject.Create;
      jsonPessoaEndereco := Req.Body<TJSONObject>;
      PessoaEnderecoDAO.ObjPessoaEnderecoDAO :=
        PessoaEnderecoDAO.ObjPessoaEnderecoDAO.JsonToClass
        (jsonPessoaEndereco.ToString());
      PessoaEnderecoDAO.InsertUpdate;
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
    FreeAndNil(JsonPessoaEndereco);
    FreeAndNil(PessoaEnderecoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  PessoaEnderecoDAO: TPessoaEnderecoDAO;
begin
  Try
    Try
      PessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
      PessoaEnderecoDAO.ObjPessoaEnderecoDAO.id :=
        StrToIntDef(Req.Params.Items['id'], 0);
      PessoaEnderecoDAO.Delete;
      Res.Status(200).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro excluído com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PessoaEnderecoDAO);
  End;
end;

constructor TPessoaEnderecoCtrl.Create;
begin
  FPessoaEndereco := TPessoaEndereco.Create;
end;

destructor TPessoaEnderecoCtrl.Destroy;
begin
  FreeAndNil(FPessoaEndereco);
  inherited;
end;

End.
