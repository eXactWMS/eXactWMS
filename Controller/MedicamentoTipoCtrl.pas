{
   MedicamentoTipoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit MedicamentoTipoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     MedicamentoTipoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TMedicamentoTipoCtrl = Class
  Private
    //Funções de Validação
    FObjMedicamentoTipo : TMedicamentoTipo;
    LstMedicamentoTipo : TObjectList<TMedicamentoTipo>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindMedicamentoTipo(pMedicamentoTipoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : tJsonArray; //TObjectList<TMedicamentoTipo>;
    Function GetMedicamentoTipo(pMedicamentoTipoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TObjectList<TMedicamentoTipo>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelMedicamentoTipo(pIdMedicamentoTipo : Integer) : Boolean;
    Property ObjMedicamentoTipo  : TMedicamentoTipo Read FObjMedicamentoTipo Write FObjMedicamentoTipo;
  End;

implementation

{ tCtrlMedicamentoTipo }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tMedicamentoTipoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjMedicamentoTipo do Begin
    if Descricao = '' then raise Exception.Create('Informe o Nome do Fabricante!');

  End;
  Result := True;
End;

constructor TMedicamentoTipoCtrl.Create;
begin
  FObjMedicamentoTipo := TMedicamentoTipo.Create;
end;

class function TMedicamentoTipoCtrl.DelMedicamentoTipo(pIdMedicamentoTipo : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/medicamentotipo/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdMedicamentoTipo.ToString());
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

destructor TMedicamentoTipoCtrl.Destroy;
begin
  FObjMedicamentoTipo.Free;
  inherited;
end;

Function tMedicamentoTipoCtrl.FindMedicamentoTipo(pMedicamentoTipoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TMedicamentoTipo>;
Var jSonMedicamentoTipo : tJsonObject;
    xItens      : Integer;
Begin
  //LstMedicamentoTipo := TObjectList<TMedicamentoTipo>.Create;
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pMedicamentoTipoId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/medicamentotipo/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pMedicamentoTipoId.ToString());
  End
  Else if pDescricao = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/medicamentotipo'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/medicamentotipo/{id}/{descricao}';
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

          jSonMedicamentoTipo := tJsonObject.Create;
          jSonMedicamentoTipo := Result.Items[xItens] as TJSONObject;

          FObjMedicamentoTipo.Id        := StrToIntDef(GetValueInjSon(jSonMedicamentoTipo, 'id'), 0);
          FObjMedicamentoTipo.Descricao := GetValueInjSon(jSonMedicamentoTipo, 'descricao');
          FObjMedicamentoTipo.Status    := StrToIntDef(GetValueInjSon(jSonMedicamentoTipo, 'status'), 0);
          jSonMedicamentoTipo           := Nil;
          jSonMedicamentoTipo.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));
     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else if ShowErro = 1 then
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  //LstMedicamentoTipo.Add(GetMedicamentoTipoBD(Completa));
  //Result := LstMedicamentoTipo;
End;

function TMedicamentoTipoCtrl.GetMedicamentoTipo(pMedicamentoTipoId: Integer;
  pDescricao: String; ShowErro: Integer): TObjectList<TMedicamentoTipo>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonMedicamentoTipo : tJsonObject;
begin
  Result := TObjectList<TMedicamentoTipo>.Create;
  ReturnJson := FindMedicamentoTipo(pMedicamentoTipoId, '', ShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonMedicamentoTipo := tJsonObject.Create;
       jSonMedicamentoTipo := ReturnJson.Items[xItens] as TJSONObject;
       ObjMedicamentoTipo  := ObjMedicamentoTipo.JsonToClass(jSonMedicamentoTipo.ToString());
       Result.Add(ObjMedicamentoTipo);
       jSonMedicamentoTipo           := Nil;
       jSonMedicamentoTipo.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro(Tipo de Medicamentos) não encontrado');
end;

Function tMedicamentoTipoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonMedicamentoTipo : TJsonObject;
Begin
  Result := True;
  jSonMedicamentoTipo := tJson.ObjectToJsonObject(ObjMedicamentoTipo);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonMedicamentoTipo.ToJson, ContentTypeFromString('application/json'));
  if ObjMedicamentoTipo.Id = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/medicamentotipo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/medicamentotipo/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', ObjMedicamentoTipo.Id.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonMedicamentoTipo);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.

