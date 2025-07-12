{
   EnderecoTipoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 15/09/2020
   Projeto: RhemaWMS
}
unit EnderecoTipoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , PessoaClass;

Type
  TipoConsulta = (Resumida, Completa);
  TEnderecoTipoCtrl = Class
  Private
    FObjEnderecoTipo : TEnderecoTipo;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function FindEnderecoTipo(pEnderecoTipoId : Integer; pDescricao : String; ShowErro : Integer) : tJsonArray;
    Function Salvar(pEnderecoTipoId : Integer) : Boolean;
    Function MontarPaginacao(pEnderecoTipoTipo : Integer) : Integer;
    Class Function DelEnderecoTipo(pEnderecoTipoId : Integer) : Boolean;
    Property ObjEnderecoTipo  : TEnderecoTipo Read FObjEnderecoTipo Write FObjEnderecoTipo;
  End;

implementation

{ tCtrlEnderecoTipo }

uses uDmeXactWMS, uFuncoes;

Function tEnderecoTipoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  If Self.FObjEnderecoTipo.Descricao = ''  Then
     raise Exception.Create('Informe a Descrição do Tipo de Endereço.');
  Result := True;
End;

constructor TEnderecoTipoCtrl.Create;
begin
  FObjEnderecoTipo := TEnderecoTipo.Create;
end;

class function TEnderecoTipoCtrl.DelEnderecoTipo(pEnderecoTipoId: Integer): Boolean;
Begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipo/{enderecotipoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecotipoid', PEnderecoTipoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o Tipo de Endereço.'+sLineBreak+DmeXactWMS.RESTResponseWMS.StatusText);
end;

destructor TEnderecoTipoCtrl.Destroy;
begin
  FreeAndNil(FObjEnderecoTipo);
  inherited;
end;

Function tEnderecoTipoCtrl.FindEnderecoTipo(pEnderecoTipoId : Integer; pDescricao : String; ShowErro : Integer): tJsonArray;
Var jSonEnderecoTipo : tJsonObject;
    xItens      : Integer;
    RotaService : String;
Begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pEnderecoTipoId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipo/{enderecotipoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecotipoid', pEnderecoTipoId.ToString());
  End
  Else If (pDescricao <> '') then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipodescr/{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End
  Else
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipo';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJSONArray;
     if Result.Count >= 1 then Begin
        jSonEnderecoTipo := tJsonObject.Create;
        xItens := 0;
        repeat
          jSonEnderecoTipo                := Result.Items[xItens] as TJSONObject;
          FObjEnderecoTipo.EnderecoTipoId := GetValueInjSon(jSonEnderecoTipo, 'enderecotipoid').ToInteger;
          FObjEnderecoTipo.Descricao      := GetValueInjSon(jSonEnderecoTipo, 'descricao');
          FObjEnderecoTipo.Status         := GetValueInjSon(jSonEnderecoTipo, 'status').ToInteger;
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

     End
     Else If ShowErro = 1 then
        Raise Exception.Create('Tipo de Endereço não encontrado');
     jSonEnderecoTipo     := Nil;
     jSonEnderecoTipo.DisposeOf;
  End
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TEnderecoTipoCtrl.MontarPaginacao(pEnderecoTipoTipo : Integer) : Integer;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipo/montarpaginacao';
  DmeXactWMS.RESTRequestWMS.Method   := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue).GetValue<Integer>('paginacao')
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function tEnderecoTipoCtrl.Salvar(pEnderecoTipoId : Integer) : Boolean;       //(pHistorico: THistorico)
Var jSonEnderecoTipo : TJsonObject;
Begin
  Result := False;
  if Not VerificaDados then Begin
     Exit;
  End;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  jSonEnderecoTipo := TJsonObject.Create;
  JsonEnderecoTipo.AddPair('enderecotipoid', TJsonNumber.Create(ObjEnderecoTipo.EnderecoTipoId));
  JsonEnderecoTipo.AddPair('descricao', ObjEnderecoTipo.Descricao);
  JsonEnderecoTipo.AddPair('status', TJsonNumber.Create(ObjEnderecoTipo.Status));
  DmeXactWMS.RestRequestWMS.AddBody(jSonEnderecoTipo.ToJson, ContentTypeFromString('application/json'));
  if ObjEnderecoTipo.EnderecoTipoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipo';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecotipo/{enderecotipoid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecotipoid', ObjEnderecoTipo.EnderecoTipoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonEnderecoTipo);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.

