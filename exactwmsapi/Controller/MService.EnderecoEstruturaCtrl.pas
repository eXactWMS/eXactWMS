{
  MService.EnderecoEstruturaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EnderecoEstruturaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  EnderecoEstruturaClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TEnderecoEstruturaCtrl = Class
  Private
    // Fun��es de Valida��o
    FEnderecoEstrutura: TEnderecoEstrutura;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEnderecoEstrutura: TEnderecoEstrutura Read FEnderecoEstrutura
      Write FEnderecoEstrutura;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetEstrutura4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEnderecoEstrutura }

uses MService.EnderecoEstruturaDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/enderecoestrutura', Get);
  THorse.Get('/v1/enderecoestrutura/:id', GetID);
  THorse.Get('/v1/enderecoestrutura4D', GetEstrutura4D);
  THorse.Get('/v1/enderecoestrutura/:id/:descricao', GetDescricao);
  THorse.Get('/v1/estrutura', Estrutura);
  THorse.Post('/v1/enderecoestrutura', Insert);
  THorse.Put('/v1/enderecoestrutura/:id', Update);
  THorse.Delete('/v1/enderecoestrutura/:id', Delete);
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
Begin
  Try
    Try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      Res.Send<TJSonArray>(EnderecoEstruturaDAO.Estrutura)
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    Try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      Res.Send<TJSonArray>(EnderecoEstruturaDAO.GetID(0)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      Res.Send<TJSonArray>(EnderecoEstruturaDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      Res.Send<TJSonArray>(EnderecoEstruturaDAO.GetID
        (StrToIntDef(Req.Params.Items['id'], 0))).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
end;

procedure GetEstrutura4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    Try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      Res.Send(EnderecoEstruturaDAO.GetEstrutura4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    Try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      EnderecoEstruturaDAO.InsertUpdate(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    Try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      EnderecoEstruturaDAO.InsertUpdate(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EnderecoEstruturaDAO: TEnderecoEstruturaDAO;
begin
  Try
    Try
      EnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
      EnderecoEstruturaDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoEstruturaDAO);
  End;
end;

constructor TEnderecoEstruturaCtrl.Create;
begin
  FEnderecoEstrutura := TEnderecoEstrutura.Create;
end;

destructor TEnderecoEstruturaCtrl.Destroy;
begin
  FreeAndNil(FEnderecoEstrutura);
  inherited;
end;

End.
