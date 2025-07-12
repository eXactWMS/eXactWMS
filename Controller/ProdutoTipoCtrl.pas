{
   ProdutoTipoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
   Essa Rotina é equivalente a Categorias do ERP
}
unit ProdutoTipoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     ProdutoTipoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TProdutoTipoCtrl = Class
  Private
    //Funções de Validação
    FObjProdutoTipo : TProdutoTipo;
    LstProdutoTipo : TObjectList<TProdutoTipo>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindProdutoTipo(pProdutoTipoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : tJsonArray; //TObjectList<TProdutoTipo>;
    Function GetProdutoTipo(pProdutoTipoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TObjectList<TProdutoTipo>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function ImportDados(pId : Integer; pSigla, pDescricao : String; pAtivo : Integer) : Boolean;
    Class Function DelProdutoTipo(pIdProdutoTipo : Integer) : Boolean;
    Property ObjProdutoTipo  : TProdutoTipo Read FObjProdutoTipo Write FObjProdutoTipo;
  End;

implementation

{ tCtrlProdutoTipo }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tProdutoTipoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjProdutoTipo do Begin
    if Descricao = '' then raise Exception.Create('Informe o Nome do Fabricante!');

  End;
  Result := True;
End;

constructor TProdutoTipoCtrl.Create;
begin
  FObjProdutoTipo := TProdutoTipo.Create;
end;

class function TProdutoTipoCtrl.DelProdutoTipo(pIdProdutoTipo : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtotipo/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdProdutoTipo.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TProdutoTipoCtrl.Destroy;
begin
  FObjProdutoTipo.Free;
  inherited;
end;

Function tProdutoTipoCtrl.FindProdutoTipo(pProdutoTipoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TProdutoTipo>;
Var jSonProdutoTipo : tJsonObject;
    xItens      : Integer;
    vErro : String;
Begin
  Try
    Result := TJsonArray.Create;
    DmeXactWMS.ResetRest;
    if pProdutoTipoId <> 0 then  Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtotipo/{id}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pProdutoTipoId.ToString());
    End
    Else if pDescricao = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtotipo'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtotipo/{id}/{descricao}';
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

            jSonProdutoTipo := tJsonObject.Create;
            jSonProdutoTipo := Result.Items[xItens] as TJSONObject;

            FObjProdutoTipo.Id        := StrToIntDef(GetValueInjSon(jSonProdutoTipo, 'id'), 0);
            FObjProdutoTipo.Descricao := GetValueInjSon(jSonProdutoTipo, 'descricao');
            FObjProdutoTipo.Status    := StrToIntDef(GetValueInjSon(jSonProdutoTipo, 'status'), 0);
            //FreeAndNil(jSonProdutoTipo);
            xItens := xItens + 1;
          until (xItens > Pred(Result.Count));
       End
       Else
          Raise Exception.Create('Registro não encontrado');
    End
    Else if ShowErro = 1 then Begin
      (DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray).Items[0].TryGetValue('Erro', vErro);
      raise Exception.Create(vErro);
    End;
  Except On E: Exception do  Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
  //LstProdutoTipo.Add(GetProdutoTipoBD(Completa));
  //Result := LstProdutoTipo;
End;

function TProdutoTipoCtrl.GetProdutoTipo(pProdutoTipoId: Integer;
  pDescricao: String; ShowErro: Integer): TObjectList<TProdutoTipo>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonProdutoTipo : tJsonObject;
begin
  Result := TObjectList<TProdutoTipo>.Create;
  ReturnJson := FindProdutoTipo(pProdutoTipoId, '', ShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonProdutoTipo := tJsonObject.Create;
       jSonProdutoTipo := ReturnJson.Items[xItens] as TJSONObject;
       ObjProdutoTipo  := ObjProdutoTipo.JsonToClass(jSonProdutoTipo.ToString());
       Result.Add(ObjProdutoTipo);
       jSonProdutoTipo           := Nil;
       jSonProdutoTipo.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro(Tipo de Produtos) não encontrado');
end;

function TProdutoTipoCtrl.ImportDados(pId: Integer; pSigla, pDescricao: String;
  pAtivo: Integer): Boolean;
begin

end;

Function tProdutoTipoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonProdutoTipo : TJsonObject;
Begin
  Result := True;
  jSonProdutoTipo := tJson.ObjectToJsonObject(ObjProdutoTipo);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonProdutoTipo.ToJson, ContentTypeFromString('application/json'));
  if ObjProdutoTipo.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtotipo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produtotipo/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', ObjProdutoTipo.Id.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonProdutoTipo);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  jSonProdutoTipo := Nil;
End;

End.

