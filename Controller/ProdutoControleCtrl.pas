{
   ProdutoControleCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit ProdutoControleCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     ProdutoControleClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TProdutoControleCtrl = Class
  Private
    //Funções de Validação
    FObjProdutoControle : TProdutoControle;
    LstProdutoControle : TObjectList<TProdutoControle>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindProdutoControle(pProdutoControleId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : tJsonArray; //TObjectList<TProdutoControle>;
    Function GetProdutoControle(pProdutoControleId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TObjectList<TProdutoControle>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelProdutoControle(pIdProdutoControle : Integer) : Boolean;
    Property ObjProdutoControle  : TProdutoControle Read FObjProdutoControle Write FObjProdutoControle;
  End;

implementation

{ tCtrlProdutoControle }

uses UDmuEvolut, uFrmuEvolut, uFuncoes; //, uFrmPesquisa

Function tProdutoControleCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjProdutoControle do Begin
    if Descricao = '' then raise Exception.Create('Informe a Descricao do Tipo de Controle!');
  End;
  Result := True;
End;

constructor TProdutoControleCtrl.Create;
begin
  ObjProdutoControle := TProdutoControle.Create;
end;

class function TProdutoControleCtrl.DelProdutoControle(pIdProdutoControle : Integer): Boolean;
begin
  Result := False;
  DmuEvolut.ResetRest;
  DmuEvolut.RESTRequestWMS.Resource := 'v1/produtocontrole/{id}';
  DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('id', pIdProdutoControle.ToString());
  DmuEvolut.RESTRequestWMS.Method := RmDelete;
  DmuEvolut.RESTRequestWMS.Execute;
  if (DmuEvolut.RESTResponseWMS.StatusCode = 200) or (DmuEvolut.RESTResponseWMS.StatusCode = 201) or
     (DmuEvolut.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TProdutoControleCtrl.Destroy;
begin
  FreeAndNil(FObjProdutoControle);
  inherited;
end;

Function tProdutoControleCtrl.FindProdutoControle(pProdutoControleId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TProdutoControle>;
Var jSonProdutoControle : tJsonObject;
    xItens      : Integer;
Begin
  //LstProdutoControle := TObjectList<TProdutoControle>.Create;
  Result := TJsonArray.Create;
  DmuEvolut.ResetRest;
  if pProdutoControleId <> 0 then  Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/produtocontrole/{idcontrole}';
     DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('id', pProdutoControleId.ToString());
  End
  Else if pDescricao = '' then
     DmuEvolut.RESTRequestWMS.Resource := 'v1/produtocontrole'
  Else Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/produtocontrole/{idcontrole}/{descricao}';
     DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('idcontrole', '0');
     DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmuEvolut.RESTRequestWMS.Method := RmGet;
  DmuEvolut.RESTRequestWMS.Execute;
  if (DmuEvolut.RESTResponseWMS.StatusCode = 200) or (DmuEvolut.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmuEvolut.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat

          jSonProdutoControle := tJsonObject.Create;
          jSonProdutoControle := Result.Items[xItens] as TJSONObject;

          FObjProdutoControle.IdControle := StrToIntDef(GetValueInjSon(jSonProdutoControle, 'idcontrole'), 0);
          FObjProdutoControle.Descricao  := GetValueInjSon(jSonProdutoControle, 'descricao');
          FObjProdutoControle.Status     := StrToIntDef(GetValueInjSon(jSonProdutoControle, 'status'), 0);
          jSonProdutoControle            := Nil;
          jSonProdutoControle.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));
     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else if ShowErro = 1 then
    raise Exception.Create('Ocorreu um erro: '+DmuEvolut.RESTResponseWMS.StatusText);
  //LstProdutoControle.Add(GetProdutoControleBD(Completa));
  //Result := LstProdutoControle;
End;

function TProdutoControleCtrl.GetProdutoControle(pProdutoControleId: Integer;
  pDescricao: String; ShowErro: Integer): TObjectList<TProdutoControle>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonProdutoControle : tJsonObject;
begin
  Result := TObjectList<TProdutoControle>.Create;
  ReturnJson := FindProdutoControle(pProdutoControleId, '', ShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonProdutoControle := tJsonObject.Create;
       jSonProdutoControle := ReturnJson.Items[xItens] as TJSONObject;
       ObjProdutoControle  := ObjProdutoControle.JsonToClass(jSonProdutoControle.ToString());
       Result.Add(ObjProdutoControle);
       jSonProdutoControle           := Nil;
       jSonProdutoControle.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro(Tipo de Produtos) não encontrado');
end;

Function tProdutoControleCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonProdutoControle : TJsonObject;
Begin
  Result := True;
  jSonProdutoControle := tJson.ObjectToJsonObject(ObjProdutoControle);
  DmuEvolut.ResetRest;
  DmuEvolut.RestRequestWMS.ClearBody;
  DmuEvolut.RestRequestWMS.AddBody(jSonProdutoControle.ToJson, ContentTypeFromString('application/json'));
  if ObjProdutoControle.IdControle = 0 then Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/produtocontrole';
     DmuEvolut.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmuEvolut.RESTRequestWMS.Resource := 'v1/produtocontrole/{idcontrole}';
     DmuEvolut.RESTRequestWMS.Params.AddUrlSegment('idcontrole', ObjProdutoControle.IdControle.ToString());
     DmuEvolut.RESTRequestWMS.Method := rmPut;
  End;
  DmuEvolut.RESTRequestWMS.Execute;
  FreeAndNil(jSonProdutoControle);
  if (DmuEvolut.RESTResponseWMS.StatusCode = 200) or (DmuEvolut.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Ocorreu um erro: '+DmuEvolut.RESTResponseWMS.StatusText);
End;

End.

