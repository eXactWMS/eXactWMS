{
   PessoaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 15/09/2020
   Projeto: RhemaWMS
}
unit PessoaCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , PessoaClass;

Type
  TipoConsulta = (Resumida, Completa);
  TPessoaCtrl = Class
  Private
    FObjPessoa : TPessoa;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function FindPessoa(pId : Integer; pCodPessoaERP : Integer; pRazao, pFantasia : String; pPessoaTipoId, ShowErro : Integer) : tJsonArray;
    Function GetEstrutura : TJsonArray;
    Function Salvar(pPessoaTipo : Integer) : Integer;
    Function MontarPaginacao(pPessoaTipo : Integer) : Integer;
    Function GetAddressToVolume(pCodPessoa : Integer) : TJsonArray;
    Class Function DelPessoa(pId, pPessoaTipoId : Integer) : Boolean;
    Property ObjPessoa  : TPessoa Read FObjPessoa Write FObjPessoa;
  End;

implementation

{ tCtrlPessoa }

uses uDmeXactWMS, uFuncoes;

Function tPessoaCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjPessoa do Begin
    If Razao = ''  Then raise
       Exception.Create('Informe a razão social da pessoa.');
    if (CnpjCpf <> '') and (Not (length(CnpjCpf) in [11, 14])) then
       raise Exception.Create('C.N.P.J/C.P.F. inválido.')
    Else if (Length(CnpjCpf) = 11) and (Not ValidarCPF(CnpjCpf)) then
       raise Exception.Create('C.P.F. inválido.')
    Else if (Length(CnpjCpf) = 14) and (Not ValidarCNPJ(CnpjCpf)) then
       raise Exception.Create('C.N.P.J. inválido.');
  End;
  Result := True;
End;

constructor TPessoaCtrl.Create;
begin
  FObjPessoa := TPessoa.Create;
end;

class function TPessoaCtrl.DelPessoa(pId, pPessoaTipoId : Integer): Boolean;
Var RotaService : String;
Begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoa/{id}/{pessoatipoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoatipoid', pPessoaTipoId.ToString());
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

destructor TPessoaCtrl.Destroy;
begin
  FreeAndNil(FObjPessoa);
  inherited;
end;

Function tPessoaCtrl.FindPessoa(pId : Integer; pCodPessoaERP : Integer; pRazao, pFantasia: String; pPessoaTipoId, ShowErro : Integer): tJsonArray;
Var jSonPessoa, JSonPessoaTipo : tJsonObject;
    xItens      : Integer;
    RotaService : String;
Begin
  DmeXactWMS.ResetRest;
//  if (pId = 0) and (pCodPessoaERP = 0) and (pRazao='') then
//     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoa?pessoatipoid='+pPessoaTipoId.ToString
//  Else Begin
     RotaService := 'v1/pessoa/{pessoaid}?pessoatipoid='+pPessoaTipoId.ToString;
     if pCodPessoaERP <> 0 then
        RotaService := RotaService+'&codpessoaerp='+pCodPessoaERP.ToString();
     if pRazao <> '' then
        RotaService := RotaService+'&razao='+pRazao;
     if pFantasia <> '' then
        RotaService := RotaService+'&fantasia='+pFantasia;
     DmeXactWMS.RESTRequestWMS.Resource := RotaService;
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pId.ToString());
//  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := TJsonArray.Create;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJSONArray;
     if Result.Count >= 1 then Begin
        jSonPessoa := tJsonObject.Create;
        JSonPessoaTipo := TJsonObject.Create;
        xItens := 0;
        repeat
          jSonPessoa           := Result.Items[xItens] as TJSONObject;
          FObjPessoa.PessoaId  := GetValueInjSon(jSonPessoa, 'pessoaId').ToInteger;
          FObjPessoa.CodPessoa := GetValueInjSon(jSonPessoa, 'codpessoaerp').Tointeger;
          FObjPessoa.Razao     := GetValueInjSon(jSonPessoa, 'razao');
          FObjPessoa.Fantasia  := GetValueInjSon(jSonPessoa, 'fantasia');

          JSonPessoaTipo := jSonPessoa.GetValue('pessoatipo') as TJSONObject;
          FObjPessoa.PessoaTipo.PessoaTipoId         := GetValueInjSon(JSonPessoaTipo, 'pessoaTipoId').Tointeger;
          FObjPessoa.PessoaTipo.Descricao  := GetValueInjSon(JSonPessoaTipo, 'descricao');
          FObjPessoa.PessoaTipo.Status     := GetValueInjSon(JSonPessoaTipo, 'status').Tointeger;
          FObjPessoa.Fone      := GetValueInjSon(jSonPessoa, 'fone');
          FObjPessoa.CnpjCpf   := GetValueInjSon(jSonPessoa, 'cnpjcpf');
          FObjPessoa.Email     := GetValueInjSon(jSonPessoa, 'email');
          FObjPessoa.HomePage  := GetValueInjSon(jSonPessoa, 'homepage');
          FObjPessoa.ShelfLife := jSonPessoa.GetValue<Integer>('shelflife');
          FObjPessoa.Status    := jSonPessoa.GetValue<Integer>('status');
          FObjPessoa.RotaId    := jSonPessoa.GetValue<Integer>('rotaId');
          FObjPessoa.TransportadoraId := jSonPessoa.GetValue<Integer>('transportadoraId');
          xItens := xItens + 1;
        until (xItens > Pred(Result.Count));

     End
     Else If ShowErro = 1 then
        Raise Exception.Create('Registro não encontrado');
     jSonPessoa     := Nil;
     jSonPessoa.DisposeOf;
     JSonPessoaTipo := Nil; //.Free;
     JSonPessoaTipo.DisposeOf;
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TPessoaCtrl.GetAddressToVolume(pCodPessoa: Integer): TJsonArray;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoa/getaddresstovolume?codpessoa='+pCodPessoa.ToString;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJSONArray
  Else Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Não Foi possível acessar os dados do endereço.'));
  End;
end;

function TPessoaCtrl.GetEstrutura: TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoa/estrutura';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TPessoaCtrl.MontarPaginacao(pPessoaTipo : Integer) : Integer;
Var RotaService : String;
begin
  if pPessoaTipo = 1 then
     RotaService := 'v1/cliente/montarpaginacao'
  else RotaService := 'v1/fornecedor/montarpaginacao';
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue).GetValue<Integer>('paginacao')
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function tPessoaCtrl.Salvar(pPessoaTipo : Integer) : Integer;       //(pHistorico: THistorico)
Var jSonPessoa      : TJsonObject;
    RotaService     : String;
    ReturnJsonArray : TJsonArray;
Begin
  Result := 0;
  if Not VerificaDados then Begin
     Exit;
  End;
  if pPessoaTipo = 1 then
     RotaService := 'v1/cliente'
  else if pPessoaTipo = 1 then RotaService := 'v1/fornecedor'
  else if pPessoaTipo = 3 then RotaService := 'v1/transportadora';
  jSonPessoa := tJson.ObjectToJsonObject(ObjPessoa);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonPessoa.ToJson, ContentTypeFromString('application/json'));
  if ObjPessoa.PessoaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoa'; //RotaService;
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/pessoa'; //RotaService+'/{pessoaid}';
//     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', ObjPessoa.PessoaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonPessoa);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
     ReturnJsonArray := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJSONArray;
     Result          := ReturnJsonArray.Get(0).GetValue<Integer>('pessoaid');
     End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

End.


