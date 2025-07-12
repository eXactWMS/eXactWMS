{
  EnderecoRuaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EnderecamentoRuaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  EnderecamentoRuaClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TEnderecoRuaCtrl = Class
  Private
    // Fun��es de Valida��o
    FEnderecoRua: TEnderecoRua;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEnderecoRua: TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetIdDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetRua4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetEnderecoLado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEnderecoRua }

uses MService.EnderecamentoRuaDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/enderecorua', Get).Get('/enderecorua/:ruaid',
    GetIdDescricao).Get('/enderecorua4D', GetRua4D)
    .Get('/enderecorua/:descricao/:lado', GetEnderecoLado)
    .Get('/enderecorua/estrutura', Estrutura).Post('/enderecorua', Insert)
    .Put('/enderecorua/:ruaid', Update).Delete('/enderecorua/:ruaid', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoRuaDAO: TEnderecoRuaDAO;
Begin
  Try
    Try
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      Res.Send<TJSonArray>(EnderecoRuaDAO.Estrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(EnderecoRuaDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    Try
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      Res.Send<TJSonArray>(EnderecoRuaDAO.GetId('0')).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
    End;
  Finally
    FreeAndNil(EnderecoRuaDAO);
  End;
end;

procedure GetIdDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    try
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      Res.Send<TJSonArray>(EnderecoRuaDAO.GetId(Req.Params.Items['ruaid']))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    end;
  Finally
    FreeAndNil(EnderecoRuaDAO);
  End;
end;

procedure GetRua4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    Try
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      Res.Send(EnderecoRuaDAO.GetRua4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    end;
  Finally
    FreeAndNil(EnderecoRuaDAO);
    FreeAndNil(EnderecoRuaDAO);
  End;
End;

procedure GetEnderecoLado(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    try
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      Res.Send<TJSonArray>(EnderecoRuaDAO.GetEnderecoLado(Req.Params.Items
        ['descricao'], Req.Params.Items['lado'])).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    end;
  Finally
    FreeAndNil(EnderecoRuaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEnderecoRua: TJSONObject;
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    Try
      jsonEnderecoRua := Req.Body<TJSONObject>;
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      EnderecoRuaDAO.ObjEnderecoRua := EnderecoRuaDAO.ObjEnderecoRua.JsonToClass
        (jsonEnderecoRua.ToString());
      if EnderecoRuaDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
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
    FreeAndNil(EnderecoRuaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEnderecoRua: TJSONObject;
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    Try
      jsonEnderecoRua := Req.Body<TJSONObject>;
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;

      EnderecoRuaDAO.ObjEnderecoRua := EnderecoRuaDAO.ObjEnderecoRua.JsonToClass
        (jsonEnderecoRua.ToString());
      if EnderecoRuaDAO.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        raise Exception.Create('N�o foi poss�vel Salvar o Registro.');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(EnderecoRuaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EnderecoRuaDAO: TEnderecoRuaDAO;
begin
  Try
    Try
      EnderecoRuaDAO := TEnderecoRuaDAO.Create;
      EnderecoRuaDAO.ObjEnderecoRua.RuaId :=
        StrToIntDef(Req.Params.Items['ruaid'], 0);
      EnderecoRuaDAO.Delete;
      Res.Status(200).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro exclu�do com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(EnderecoRuaDAO);
  End;
end;

constructor TEnderecoRuaCtrl.Create;
begin
  FEnderecoRua := TEnderecoRua.Create;
end;

destructor TEnderecoRuaCtrl.Destroy;
begin
  FEnderecoRua.Free;
  inherited;
end;

End.
