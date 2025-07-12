unit MService.SegregadoCausaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PedidoVolumeClass,
  Horse,
  System.JSON, Services.SegregadoCausa; // , uTHistorico;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InsertUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetHistorico(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/segregadocausa', Get).Put('/segregadocausa',
    InsertUpdate).Delete('/segregadocausa/:id', Delete)
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceSegregadoCausa;
begin
  Try
    Try
      LService := TServiceSegregadoCausa.Create;
      JsonArrayRetorno := LService.Delete(Req.Params.Items['id'].ToInteger());
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

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceSegregadoCausa;
begin
  Try
    Try
      LService := TServiceSegregadoCausa.Create;
      JsonArrayRetorno := LService.GetSegregadoCausa(Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
    Except On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(LService);
  End;
end;

Procedure GetHistorico(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Begin

End;

procedure InsertUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonArrayRetorno: TJsonArray;
  LService: TServiceSegregadoCausa;
begin
  Try
    Try
      LService := TServiceSegregadoCausa.Create;
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

end.
