{
   RastroCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit RastroCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     RastroClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TRastroCtrl = Class
  Private
    //Funções de Validação
    FObjRastro : TRastro;
    LstRastro : TObjectList<TRastro>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindRastro(pRastroId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : tJsonArray; //TObjectList<TRastro>;
    Function GetRastro(pRastroId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TObjectList<TRastro>;
    Function GetRastroJson(pRastroId : Integer = 0; pDescricao : String = '') : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelRastro(pIdRastro : Integer) : Boolean;
    Property ObjRastro  : TRastro Read FObjRastro Write FObjRastro;
  End;

implementation

{ tCtrlRastro }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tRastroCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjRastro do Begin
    if Descricao = '' then raise Exception.Create('Informe o tipo de Rastreabilidadde do produto!');
  End;
  Result := True;
End;

constructor TRastroCtrl.Create;
begin
  ObjRastro := TRastro.Create;
end;

class function TRastroCtrl.DelRastro(pIdRastro : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rastroid', pIdRastro.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TRastroCtrl.Destroy;
begin
  FreeAndNil(FObjRastro);
  inherited;
end;

Function tRastroCtrl.FindRastro(pRastroId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TRastro>;
Var jSonRastro : tJsonObject;
    xItens      : Integer;
Begin
  //LstRastro := TObjectList<TRastro>.Create;
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pRastroId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro/{rastro}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pRastroId.ToString());
  End
  Else if pDescricao = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro/{rastro}/{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rastroid', '0');
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat

          jSonRastro := tJsonObject.Create;
          jSonRastro := Result.Items[xItens] as TJSONObject;

          FObjRastro.RastroId := StrToIntDef(GetValueInjSon(jSonRastro, 'rastroid'), 0);
          FObjRastro.Descricao  := GetValueInjSon(jSonRastro, 'descricao');
          FObjRastro.Status     := StrToIntDef(GetValueInjSon(jSonRastro, 'status'), 0);
          jSonRastro            := Nil;
          jSonRastro.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));
     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else if ShowErro = 1 then
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  //LstRastro.Add(GetRastroBD(Completa));
  //Result := LstRastro;
End;

function TRastroCtrl.GetRastro(pRastroId: Integer;
  pDescricao: String; ShowErro: Integer): TObjectList<TRastro>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonRastro : tJsonObject;
begin
  Result := TObjectList<TRastro>.Create;
  ReturnJson := FindRastro(pRastroId, '', ShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonRastro := tJsonObject.Create;
       jSonRastro := ReturnJson.Items[xItens] as TJSONObject;
       ObjRastro  := ObjRastro.JsonToClass(jSonRastro.ToString());
       Result.Add(ObjRastro);
       jSonRastro           := Nil;
       jSonRastro.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro de Tipo de Rastreabilidade não encontrado');
end;

function TRastroCtrl.GetRastroJson(pRastroId: Integer; pDescricao: String): TJsonArray;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonRastro : tJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    if pRastroId <> 0 then  Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro/{rastro}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pRastroId.ToString());
    End
    Else if pDescricao = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro/{rastro}/{descricao}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rastroid', '0');
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.create.addpair('Erro', E.Message));
    End;
  End;
end;

Function tRastroCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonRastro : TJsonObject;
Begin
  Result := True;
  jSonRastro := tJson.ObjectToJsonObject(ObjRastro);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonRastro.ToJson, ContentTypeFromString('application/json'));
  if ObjRastro.RastroId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rastro/{rastroid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rastroid', ObjRastro.RastroId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonRastro);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.


