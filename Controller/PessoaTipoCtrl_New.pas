{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit PessoaTipoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     uTHistorico, PessoaTipoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TPessoaTipoCtrl = Class
  Private
    //Funções de Validação
    FObjPessoaTipo : TPessoaTipo;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindPessoaTipo(pId : Integer = 0; pNome : String = '') : tJsonArray; //TObjectList<TPessoaTipo>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelPessoaTipo(pIdPessoaTipo : Integer) : Boolean;
    Property ObjPessoaTipo  : TPessoaTipo Read FObjPessoaTipo Write FObjPessoaTipo;
  End;

implementation

{ tCtrlPessoaTipo }

uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

Function tPessoaTipoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjPessoaTipo do Begin
    if Descricao = '' then raise Exception.Create('Informe a Descrição do Tipo de Pessoa!');
    if PessoaTipo < 0 then raise Exception.Create('Informe o Tipo de Pessoal!');
  End;
  Result := True;
End;

constructor TPessoaTipoCtrl.Create;
begin
  FObjPessoaTipo := TPessoaTipo.Create;
end;

class function TPessoaTipoCtrl.DelPessoaTipo(pIdPessoaTipo : Integer): Boolean;
begin
  Result := False;
  DmRhemaWMS.ResetRest;
  DmRhemaWMS.RESTRequestWMS.Resource := 'PessoaTipo/{id}';
  DmRhemaWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdPessoaTipo.ToString());
  DmRhemaWMS.RESTRequestWMS.Method := RmDelete;
  DmRhemaWMS.RESTRequestWMS.Execute;
  if (DmRhemaWMS.RESTResponseWMS.StatusCode = 200) or (DmRhemaWMS.RESTResponseWMS.StatusCode = 201) or
     (DmRhemaWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TPessoaTipoCtrl.Destroy;
begin
  FreeAndNil(FObjPessoaTipo);
  inherited;
end;

Function tPessoaTipoCtrl.FindPessoaTipo(pId : Integer; pNome: String): tJsonArray;// TObjectList<TPessoaTipo>;
Var //LstPessoaTipo : TObjectList<TPessoaTipo>;
    //JsonRetorno : TJSONArray;
    jSonObj     : tJsonObject;
    xItens      : Integer;
Begin
  //LstPessoaTipo := TObjectList<TPessoaTipo>.Create;
  Result := TJsonArray.Create;
  DmRhemaWMS.ResetRest;
  if pId <> 0 then  Begin
     DmRhemaWMS.RESTRequestWMS.Resource := 'PessoaTipo/{id}';
     DmRhemaWMS.RESTRequestWMS.Params.AddUrlSegment('id', pId.ToString());
  End
  else
    if pNome = '' then
       DmRhemaWMS.RESTRequestWMS.Resource := 'PessoaTipo'
    Else Begin
       DmRhemaWMS.RESTRequestWMS.Resource := 'PessoaTipo/{id}/{descricao}';
       DmRhemaWMS.RESTRequestWMS.Params.AddUrlSegment('id', pId.ToString());
       DmRhemaWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pnome);
    End;
  DmRhemaWMS.RESTRequestWMS.Method := RmGet;
  DmRhemaWMS.RESTRequestWMS.Execute;
  if (DmRhemaWMS.RESTResponseWMS.StatusCode = 200) or (DmRhemaWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmRhemaWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat

          jSonObj := tJsonObject.Create;
          jSonObj := Result.Items[xItens] as TJSONObject;

          FObjPessoaTipo.Id         := StrToIntDef(jSonObj.Get('id').JsonValue.Value, 0);
          FObjPessoaTipo.PessoaTipo := StrToIntDef(jSonObj.Get('PessoaTipo').JsonValue.Value, 0);
          FObjPessoaTipo.Descricao  := jSonObj.Get('Descricao').JsonValue.Value;
          FObjPessoaTipo.Status     := jSonObj.Get('status').JsonValue.Value.ToInteger;
          jSonObj := Nil;
          jSonObj.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

//        ExibirDados(DmRhemaWMS.RESTResponseWMS.JSONValue as TJSONArray)
     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmRhemaWMS.RESTResponseWMS.StatusText);

  //LstPessoaTipo.Add(GetPessoaTipoBD(Completa));
  //Result := LstPessoaTipo;
End;

Function tPessoaTipoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonPessoaTipo : TJsonObject;
Begin
  Result := True;
  jSonPessoaTipo := tJson.ObjectToJsonObject(ObjPessoaTipo);
  DmRhemaWMS.ResetRest;
  DmRhemaWMS.RestRequestWMS.ClearBody;
  DmRhemaWMS.RestRequestWMS.AddBody(jSonPessoaTipo.ToJson, ContentTypeFromString('application/json'));
  if ObjPessoaTipo.PessoaTipo = 0 then Begin
     DmRhemaWMS.RESTRequestWMS.Resource := 'PessoaTipo';
     DmRhemaWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmRhemaWMS.RESTRequestWMS.Resource := 'PessoaTipo/{id}';
     DmRhemaWMS.RESTRequestWMS.Params.AddUrlSegment('id', ObjPessoaTipo.Id.ToString());
     DmRhemaWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmRhemaWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPessoaTipo);
  if (DmRhemaWMS.RESTResponseWMS.StatusCode = 200) or (DmRhemaWMS.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Ocorreu um erro: '+DmRhemaWMS.RESTResponseWMS.StatusText);
End;

End.

