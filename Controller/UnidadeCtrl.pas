{
   UnidadeCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit UnidadeCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     UnidadeClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TUnidadeCtrl = Class
  Private
    //Funções de Validação
    FObjUnidade : TUnidade;
    LstUnidade : TObjectList<TUnidade>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindUnidade(pUnidadeId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : tJsonArray; //TObjectList<TUnidade>;
    Function GetUnidade(pUnidadeId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TObjectList<TUnidade>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelUnidade(pIdUnidade : Integer) : Boolean;
    Property ObjUnidade  : TUnidade Read FObjUnidade Write FObjUnidade;
  End;

implementation

{ tCtrlUnidade }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tUnidadeCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjUnidade do Begin
    if Descricao = '' then raise Exception.Create('Informe o tipo de Rastreabilidadde do produto!');
  End;
  Result := True;
End;

constructor TUnidadeCtrl.Create;
begin
  ObjUnidade := TUnidade.Create;
end;

class function TUnidadeCtrl.DelUnidade(pIdUnidade : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/unidade/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdUnidade.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
//     ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TUnidadeCtrl.Destroy;
begin
  FreeAndNil(FObjUnidade);
  inherited;
end;

Function tUnidadeCtrl.FindUnidade(pUnidadeId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TUnidade>;
Var jSonUnidade : tJsonObject;
    xItens      : Integer;
Begin
  //LstUnidade := TObjectList<TUnidade>.Create;
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pUnidadeId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/unidade/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pUnidadeId.ToString());
  End
  Else if pDescricao = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/unidade'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/unidade/{id}/{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', '0');
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat

          jSonUnidade := tJsonObject.Create;
          jSonUnidade := Result.Items[xItens] as TJSONObject;

          FObjUnidade.Id         := StrToIntDef(GetValueInjSon(jSonUnidade, 'id'), 0);
          FObjUnidade.Descricao  := GetValueInjSon(jSonUnidade, 'descricao');
          FObjUnidade.Status     := StrToIntDef(GetValueInjSon(jSonUnidade, 'status'), 0);
          jSonUnidade            := Nil;
          jSonUnidade.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));
     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else if ShowErro = 1 then
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  //LstUnidade.Add(GetUnidadeBD(Completa));
  //Result := LstUnidade;
End;

function TUnidadeCtrl.GetUnidade(pUnidadeId: Integer;
  pDescricao: String; ShowErro: Integer): TObjectList<TUnidade>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonUnidade : tJsonObject;
begin
  Result := TObjectList<TUnidade>.Create;
  ReturnJson := FindUnidade(pUnidadeId, '', ShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonUnidade := tJsonObject.Create;
       jSonUnidade := ReturnJson.Items[xItens] as TJSONObject;
       ObjUnidade  := ObjUnidade.JsonToClass(jSonUnidade.ToString());
       Result.Add(ObjUnidade);
       xItens := xItens + 1;
       jSonUnidade := Nil;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro de Unidade de medida não encontrada');
end;

Function tUnidadeCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonUnidade : TJsonObject;
Begin
  Result := False;
  jSonUnidade := tJson.ObjectToJsonObject(ObjUnidade);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonUnidade.ToJson, ContentTypeFromString('application/json'));
  if ObjUnidade.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/unidade';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/unidade/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', ObjUnidade.Id.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonUnidade);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True //ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.

