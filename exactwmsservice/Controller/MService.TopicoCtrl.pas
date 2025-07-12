{
  TopicoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.TopicoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  TopicosClass,
  Horse,
  System.JSON; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TTopicoCtrl = Class
  Private
    // Funções de Validação
    FTopico: TTopicos;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjTopico: TTopicos Read FTopico Write FTopico;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlTopico }

uses MService.TopicoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/topico', Get).Get('/topico/:topicoid', GetId)
    .Post('/topico', Insert).Put('/topico/:topicoid', Update)
    .Delete('/topico/:topicoid', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  TopicoDAO: TTopicoDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    Try
      TopicoDAO := TTopicoDAO.Create;
      Res.Send<TJSonArray>(TopicoDAO.GetId('0')).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(TopicoDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  TopicoDAO: TTopicoDAO;
  JsonArrayRetorno : TJsonArray;
begin
  Try
    try
      TopicoDAO := TTopicoDAO.Create;
      Res.Send<TJSonArray>(TopicoDAO.GetId(Req.Params.Items['topicoid']))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(TopicoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  TopicoDAO: TTopicoDAO;
begin
  Try
    Try
      TopicoDAO := TTopicoDAO.Create;
      if TopicoDAO.Salvar(Req.Body<TJSONObject>) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
         raise Exception.Create('Não foi possível Salvar o Registro');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(TopicoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  TopicoDAO: TTopicoDAO;
begin
  Try
    Try
      TopicoDAO := TTopicoDAO.Create;
      if TopicoDAO.Salvar(Req.Body<TJSONObject>) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created)
      Else
        raise Exception.Create('Não foi possível Salvar o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(TopicoDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  TopicoDAO: TTopicoDAO;
begin
  Try
    Try
      TopicoDAO := TTopicoDAO.Create;
      TopicoDAO.ObjTopico.Topicoid :=
        StrToIntDef(Req.Params.Items['topicoid'], 0);
      If TopicoDAO.Delete then
         Res.Status(200).Send<TJSONObject>
           (TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro excluído com Sucesso!'))).Status(THttpStatus.Created)
      Else
         raise Exception.Create('Não foi possível excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(TopicoDAO);
  End;
end;

constructor TTopicoCtrl.Create;
begin
  FTopico := TTopicos.Create;
end;

destructor TTopicoCtrl.Destroy;
begin
  FreeAndNil(FTopico);
  inherited;
end;

End.
