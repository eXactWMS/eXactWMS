{
   tipooperacaoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 16/09/2020
   Projeto: RhemaWMS
}
unit OperacaoNaturezaCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, OperacaoNaturezaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TOperacaoNaturezaCtrl = Class
  Private
    FObjOperacaoNatureza : TOperacaoNatureza;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function FindOperacaoNatureza(pId : Integer; pDescricao : String) : tJsonArray;
    Function Salvar : Boolean;
    Class Function DelOperacaoNatureza(pId : Integer) : Boolean;
    Property ObjOperacaoNatureza  : TOperacaoNatureza Read FObjOperacaoNatureza Write FObjOperacaoNatureza;
  End;

implementation

{ tCtrlOperacaoNatureza }

uses uDmeXactWMS;

Function tOperacaoNaturezaCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjOperacaoNatureza do Begin
    If Descricao = '' Then raise Exception.Create('Informe a Descrição.');
    If Tipo = '' Then raise Exception.Create('Informe o tipo da operação(Entrada/Saída).');
  End;
  Result := True;
End;

constructor TOperacaoNaturezaCtrl.Create;
begin
  FObjOperacaoNatureza := TOperacaoNatureza.Create;
end;

class function TOperacaoNaturezaCtrl.DelOperacaoNatureza(pId : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonatureza/{operacaonaturezaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaonaturezaid', pId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TOperacaoNaturezaCtrl.Destroy;
begin
  FreeAndNil(FObjOperacaoNatureza);
  inherited;
end;

Function tOperacaoNaturezaCtrl.FindOperacaoNatureza(pId : Integer; pDescricao: String): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
Begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonaturezatipo/{operacaonaturezaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaonaturezaid', pId.ToString());
  End
  else
    if pDescricao = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'Id'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonatureza/{operacaonaturezaid}/{descricao}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaonnaturezaid', pId.ToString());
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
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

          FObjOperacaoNatureza.OperacaoNaturezaId := StrToIntDef(jSonObj.Get('operacaonaturezaid').JsonValue.Value, 0);
          FObjOperacaoNatureza.Descricao  := jSonObj.Get('descricao').JsonValue.Value;
          FObjOperacaoNatureza.Tipo       := jSonObj.Get('tipo').JsonValue.Value;
          jSonObj := Nil;
          jSonObj.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);

End;

Function tOperacaoNaturezaCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonOperacaoNatureza : TJsonObject;
Begin
  Result := True;
  jSonOperacaoNatureza := tJson.ObjectToJsonObject(ObjOperacaoNatureza);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonOperacaoNatureza.ToJson, ContentTypeFromString('application/json'));
  if ObjOperacaoNatureza.OperacaoNaturezaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonatureza';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/operacaonatureza/{operacaonaturezaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('operacaonaturezaid', ObjOperacaoNatureza.operacaoNaturezaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonOperacaoNatureza);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.

