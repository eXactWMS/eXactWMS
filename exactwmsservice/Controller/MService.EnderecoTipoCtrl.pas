{
  EnderecoTipoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EnderecoTipoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PessoaClass,
  Horse,
  System.JSON; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TEnderecoTipoCtrl = Class
  Private
    // Fun��es de Valida��o
    FEnderecoTipo: TEnderecoTipo;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEnderecoTipo: TEnderecoTipo Read FEnderecoTipo
      Write FEnderecoTipo;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEnderecoTipo }

uses MService.EnderecoTipoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/enderecotipo', Get)
    .Get('/enderecotipo/:enderecotipoid', GetId)
    .Get('/enderecotipodescr/:descricao', GetDescricao)
    .Get('/enderecotipo/estrutura', Estrutura).Post('/enderecotipo', Insert)
    .Put('/enderecotipo/:enderecotipoid', Update)
    .Delete('/enderecotipo/:enderecotipoid', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoTipoDAO: TEnderecoTipoDAO;
Begin
  Try
    Try
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      Res.Send<TJSonArray>(EnderecoTipoDAO.Estrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoTipoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoTipoDAO: TEnderecoTipoDAO;
begin
  Try
    Try
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      Res.Send<TJSonArray>(EnderecoTipoDAO.GetId(0)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoTipoDAO);
  End;
  FreeAndNil(EnderecoTipoDAO);
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoTipoDAO: TEnderecoTipoDAO;
begin
  Try
    try
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      Res.Send<TJSonArray>(EnderecoTipoDAO.GetDescricao(Req.Params.Items
        ['descricao'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoTipoDAO);
  End;
End;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoTipoDAO: TEnderecoTipoDAO;
begin
  Try
    try
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      Res.Send<TJSonArray>(EnderecoTipoDAO.GetId(Req.Params.Items
        ['enderecotipoid'].ToInteger)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoTipoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEnderecoTipo: TJSONObject;
  EnderecoTipoDAO: TEnderecoTipoDAO;
begin
  Try
    Try
      jsonEnderecoTipo := TJSONObject.Create;
      jsonEnderecoTipo := Req.Body<TJSONObject>;
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      EnderecoTipoDAO.ObjEnderecoTipo :=
        EnderecoTipoDAO.ObjEnderecoTipo.JsonToClass(jsonEnderecoTipo.ToString());
      if EnderecoTipoDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'N�o foi poss�vel salvar o Registro!'))).Status(THttpStatus.InternalServerError);
    Except on E: Exception do Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(JsonEnderecoTipo);
    FreeAndNil(EnderecoTipoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEnderecoTipo: TJSONObject;
  EnderecoTipoDAO: TEnderecoTipoDAO;
begin
  Try
    Try
      jsonEnderecoTipo := TJSONObject.Create;
      jsonEnderecoTipo := Req.Body<TJSONObject>;
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      EnderecoTipoDAO.ObjEnderecoTipo :=
        EnderecoTipoDAO.ObjEnderecoTipo.JsonToClass(jsonEnderecoTipo.ToString());
      if EnderecoTipoDAO.Salvar then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
            'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'N�o foi poss�uvel Salvar o Registro!'))).Status(THttpStatus.InternalServerError);
    Except on E: Exception do Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(jsonEnderecoTipo);
    FreeAndNil(EnderecoTipoDAO);
  End;

end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EnderecoTipoDAO: TEnderecoTipoDAO;
begin
  Try
    Try
      EnderecoTipoDAO := TEnderecoTipoDAO.Create;
      EnderecoTipoDAO.ObjEnderecoTipo.EnderecoTipoid :=
        StrToIntDef(Req.Params.Items['enderecotipoid'], 0);
      EnderecoTipoDAO.Delete;
      // Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
      Res.Status(200).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro exclu�do com Sucesso!'))).Status(THttpStatus.Created);
    Except on E: Exception do Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(EnderecoTipoDAO);
  End;
  FreeAndNil(EnderecoTipoDAO);
end;

constructor TEnderecoTipoCtrl.Create;
begin
  FEnderecoTipo := TEnderecoTipo.Create;
end;

destructor TEnderecoTipoCtrl.Destroy;
begin
  FreeAndNil(FEnderecoTipo);
  inherited;
end;

End.
