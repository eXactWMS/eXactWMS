{
   tipomovimentacaoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 16/09/2020
   Projeto: RhemaWMS
}
unit OperacaoTipoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Generics.Collections, OperacaoTipoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);

  TOperacaoTipoCtrl = Class
  Private
    FObjOperacaoTipo : TOperacaoTipo;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function FindOperacaoTipo(pId : Integer; pNome : String) : tJsonArray;
    Function Salvar : Boolean;
    Class Function DelOperacaoTipo(pId : Integer) : Boolean;
    Function GetOperacaoTipo : TObjectList<TOperacaoTipo>;
    Property ObjOperacaoTipo  : TOperacaoTipo Read FObjOperacaoTipo Write FObjOperacaoTipo;
  End;

implementation

{ tCtrlOperacaoTipo }

uses uDmeXactWMS, OperacaoNaturezaCtrl;

Function tOperacaoTipoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjOperacaoTipo do Begin
    If Descricao = '' Then raise Exception.Create('Informe a Descrição da Movimentação.');
    If OperacaoNatureza.OperacaoNaturezaId = 0 Then raise Exception.Create('Informe a Natureza da Operação desta movimentação.');
  End;
  Result := True;
End;

constructor TOperacaoTipoCtrl.Create;
begin
  FObjOperacaoTipo := TOperacaoTipo.Create;
end;

class function TOperacaoTipoCtrl.DelOperacaoTipo(pId : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/OperacaoTipo/{Id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('Id', pId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     //ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TOperacaoTipoCtrl.Destroy;
begin
  FreeAndNil(FObjOperacaoTipo);
  inherited;
end;

Function tOperacaoTipoCtrl.FindOperacaoTipo(pId : Integer; pNome: String): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjOperacaoNaturezaCtrl : TOperacaoNaturezaCtrl;
Begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaotipo/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaotipoid', pId.ToString());
  End
  else
    if pNome = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaotipo'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaotipo/{operacaotipoid}/{descricao}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaotipo', pId.ToString());
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pnome);
    End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat
          jSonObj := tJsonObject.Create;
          jSonObj := Result.Items[xItens] as TJSONObject;
          FObjOperacaoTipo := FObjOperacaoTipo.JsonToClass(JsonObj.ToString());
{
           FObjOperacaoTipo.OperacaoTipoId := StrToIntDef(jSonObj.Get('operacaotipoid').JsonValue.Value, 0);
           FObjOperacaoTipo.Descricao := jSonObj.Get('descricao').JsonValue.Value;
           ObjOperacaoNaturezaCtrl    := TOperacaoNaturezaCtrl.Create;
           ObjOperacaoNaturezaCtrl.FindOperacaoNatureza(StrToIntDef(jSonObj.Get('operacaonaturezaid').JsonValue.Value, 0), '');
           FObjOperacaoTipo.OperacaoNatureza := ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza;    //
           FObjOperacaoTipo.Status    := StrToIntDef(jSonObj.Get('Status').JsonValue.Value, 0);

}          jSonObj := Nil;
          jSonObj.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);

End;

Function TOperacaoTipoCtrl.GetOperacaoTipo: TObjectList<TOperacaoTipo>;
Var ReturnJson       : TJsonArray;
    JsonOperacaoTipo : TJsonObject;
    xItens           : Integer;
begin
  Result := TObjectList<TOperacaoTipo>.Create;
  ReturnJson := FindOperacaoTipo(0, '');
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonOperacaoTipo := tJsonObject.Create;
       jSonOperacaoTipo := ReturnJson.Items[xItens] as TJSONObject;
       ObjOperacaoTipo  := ObjOperacaoTipo.JsonToClass(JsonOperacaoTipo.ToString());
       Result.Add(ObjOperacaoTipo);
       jSonOperacaoTipo := Nil;
       jSonOperacaoTipo.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro(Tipo de Produtos) não encontrado');

end;

Function tOperacaoTipoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonOperacaoTipo : TJsonObject;
Begin
  Result := True;
  jSonOperacaoTipo := tJson.ObjectToJsonObject(ObjOperacaoTipo);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonOperacaoTipo.ToJson, ContentTypeFromString('application/json'));
  if ObjOperacaoTipo.OperacaoTipoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaotipo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaotipo/{operacaotipoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaotipoId', ObjOperacaoTipo.OperacaotipoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonOperacaoTipo);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True //ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.

