{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit PessoaTipoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     PessoaTipoClass, Rest.Json, System.Json, Rest.Types;

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
    Function FindPessoaTipo(pId : Integer = 0; pNome : String = ''; pShowErro : Integer = 1) : tJsonArray; //TObjectList<TPessoaTipo>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelPessoaTipo(pIdPessoaTipo : Integer) : Boolean;
    Property ObjPessoaTipo  : TPessoaTipo Read FObjPessoaTipo Write FObjPessoaTipo;
  End;

implementation

{ tCtrlPessoaTipo }

uses UDmeXactWMS, uFrmeXactWMS; //, uFrmPesquisa

Function tPessoaTipoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjPessoaTipo do Begin
    if Descricao = '' then raise Exception.Create('Informe a Descrição do Tipo de Pessoa!');
    //if PessoaTipo < 0 then raise Exception.Create('Informe o Tipo de Pessoal!');
  End;
  Result := True;
End;

constructor TPessoaTipoCtrl.Create;
begin
//  FObjPessoaTipo := TPessoaTipo.Create;
end;

class function TPessoaTipoCtrl.DelPessoaTipo(pIdPessoaTipo : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'pessoatipo/{pessoatipoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdPessoaTipo.ToString());
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

destructor TPessoaTipoCtrl.Destroy;
begin
  FObjPessoaTipo.Free;
  inherited;
end;

Function tPessoaTipoCtrl.FindPessoaTipo(pId : Integer; pNome: String; pShowErro : Integer): tJsonArray;// TObjectList<TPessoaTipo>;
Var //LstPessoaTipo : TObjectList<TPessoaTipo>;
    //JsonRetorno : TJSONArray;
    jSonObj     : tJsonObject;
    xItens      : Integer;
Begin
  //LstPessoaTipo := TObjectList<TPessoaTipo>.Create;
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'pessoatipo/{pessoatipoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoatipoid', pId.ToString());
  End
  else
    if pNome = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'pessoatipo'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'PessoaTipo/{pessoatipoid}/{descricao}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoatipoid', pId.ToString());
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pnome);
    End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Count >= 1 then Begin
        xItens := 0;
        repeat

          jSonObj := tJsonObject.Create;
          jSonObj := Result.Items[xItens] as TJSONObject;

          FObjPessoaTipo.PessoaTipoId := StrToIntDef(jSonObj.Get('pessoatipoid').JsonValue.Value, 0);
          FObjPessoaTipo.Descricao    := jSonObj.Get('Descricao').JsonValue.Value;
          FObjPessoaTipo.Status       := jSonObj.Get('status').JsonValue.Value.ToInteger;
          jSonObj := Nil;
          jSonObj.DisposeOf;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

//        ExibirDados(DmRhemaWMS.RESTResponseWMS.JSONValue as TJSONArray)
     End
     Else If pShowErro = 1 then
       Raise Exception.Create('Registro não encontrado');
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);

  //LstPessoaTipo.Add(GetPessoaTipoBD(Completa));
  //Result := LstPessoaTipo;
End;

Function tPessoaTipoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonPessoaTipo : TJsonObject;
Begin
  Result := True;
  jSonPessoaTipo := tJson.ObjectToJsonObject(ObjPessoaTipo);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPessoaTipo.ToJson, ContentTypeFromString('application/json'));
  if ObjPessoaTipo.PessoaTipoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'pessoatipo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'pessoatipo/{pessoatipoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoatipoid', ObjPessoaTipo.PessoaTipoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPessoaTipo);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.

