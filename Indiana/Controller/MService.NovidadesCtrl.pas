unit MService.NovidadesCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections,
  // ConfiguracaoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TNovidadesCtrl = Class
  Private
    // Funções de Validação
    // FNovidades : TNovidadesWMS;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetNews(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tNovidadesCtrl }

uses MService.NovidadesDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/novidades', Get);
  THorse.Get('/v1/novidades/news', GetNews);
  THorse.Post('/v1/novidades', Insert);
  THorse.Put('/v1/novidades', Update);
  THorse.Delete('/v1/novidades/:novidadeid', Delete);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  NovidadesDAO: TNovidadesDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      NovidadesDAO := TNovidadesDao.Create;
      Res.Send<TJSonArray>(NovidadesDAO.Get(Req.Query.Dictionary));
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
    FreeAndNil(NovidadesDAO);
  End;
end;

Procedure GetNews(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  NovidadesDAO: TNovidadesDao;
  JsonArrayErro: TJSonArray;
begin
  Try
    Try
      NovidadesDAO := TNovidadesDao.Create;
      Res.status(200).Send<TJSonArray>(NovidadesDAO.GetNews(Req.Query.Dictionary));
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        Res.status(500).Send<TJSonArray>(JsonArrayErro);
      End;
    End;
  Finally
    FreeAndNil(NovidadesDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjNovidades: TJsonObject;
  NovidadesDAO: TNovidadesDao;
begin
  Try
    Try
      ObjNovidades := TJsonObject.Create;
      ObjNovidades := Req.Body<TJsonObject>;
      NovidadesDAO := TNovidadesDao.Create;
      Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjNovidades);
    FreeAndNil(NovidadesDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonNovidades: TJsonObject;
  NovidadesDAO: TNovidadesDao;
begin
  Try
    Try
      JsonNovidades := TJsonObject.Create;
      JsonNovidades := Req.Body<TJsonObject>;
      NovidadesDAO := TNovidadesDao.Create;
      NovidadesDAO.InsertUpdate(JsonNovidades);
      Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
        'Configurações salva com Sucesso!'))).status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(JsonNovidades);
    FreeAndNil(NovidadesDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJsonObject;
  NovidadesDAO: TNovidadesDao;
begin
  Try
    Try
      NovidadesDAO := TNovidadesDao.Create;
      NovidadesDAO.Delete(StrToIntDef(Req.Params.Items['novidadeid'], 0));
      Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).status(THTTPStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TJsonObject>(TJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(NovidadesDAO);
  End;
end;

constructor TNovidadesCtrl.Create;
begin
  // FNovidades := TNovidadesWMS.Create;
end;

destructor TNovidadesCtrl.Destroy;
begin
  // FNovidades.Free;
  inherited;
end;

End.
