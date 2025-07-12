{
  ProdutoLinhaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
Unit MService.ProdutoLinhaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  ProdutoLinhaClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TProdutoLinhasCtrl = Class
  Private
    // Funções de Validação
    FProdutoLinha: TProdutoLinha;
  Public
    // Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjProdutoLinha: TProdutoLinha Read FProdutoLinha
      Write FProdutoLinha;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InsertUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlProdutoLinha }

uses uFuncoes, Services.ProdutoLinha;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/produtolinha', Get)
    .Put('/produtolinha', InsertUpdate)
    .Post('/produtolinha/import', Import)
    .Delete('/produtolinha/:produtolinhaid', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceProdutoLinha;
begin
  Try
    Try
      LService := TServiceProdutoLinha.Create;
      JsonArrayRetorno := LService.GetProdutoLinha(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
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
    FreeAndNil(LService);
  End;
end;

procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceProdutoLinha;
begin
  Try
    Try
      LService := TServiceProdutoLinha.Create;
      JsonArrayRetorno := LService.Import(Req.Body<tJsonObject>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
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
    FreeAndNil(LService);
  End;
end;

procedure InsertUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceProdutoLinha;
begin
  Try
    Try
      LService := TServiceProdutoLinha.Create;
      JsonArrayRetorno := LService.Salvar(Req.Body<TJsonArray>);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
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
    FreeAndNil(LService);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceProdutoLinha;
begin
  Try
    Try
      LService := TServiceProdutoLinha.Create;
      JsonArrayRetorno := LService.Delete(Req.Params.Items['produtolinhaid']
        .ToInteger());
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
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
    FreeAndNil(LService);
  End;
end;

constructor TProdutoLinhasCtrl.Create;
begin
  FProdutoLinha := TProdutoLinha.Create;
end;

destructor TProdutoLinhasCtrl.Destroy;
begin
  FreeAndNil(FProdutoLinha);
  inherited;
end;

End.
