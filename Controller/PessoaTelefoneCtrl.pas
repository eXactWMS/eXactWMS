{
   PessoaFoneCtrl.Pas
   Criado por Genilson S Soares em 28/05/2021
   Projeto: eXactWMS
}
unit PessoaTelefoneCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , PessoaClass;

Type
  TPessoaTelefoneCtrl = Class
  Private
    FObjPessoaTelefone : TPessoaTelefone;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function GetPessoaTelefone(pIndFone : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 0) : TObjectList<TPessoaTelefoneCtrl>;
    Function Salvar  : Boolean;  //(pHistorico: THistorico)
    Function DelPessoaTelefone : Boolean;
    Property ObjPessoaTelefone : TPessoaTelefone Read FObjPessoaTelefone Write FObjPessoaTelefone;
  End;

implementation

{ tCtrlPessoaTelefone }

uses uDmeXactWMS, uFuncoes, PessoaTelefoneDAO;

Function tPessoaTelefoneCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjPessoaTelefone do Begin
    if PessoaId = 0 then
       raise Exception.Create('Informe o Id da pessoa responsável pelo endereço.');
    If Telefone = ''  Then
       raise Exception.Create('Informe o telefone do contato..');
  End;
  Result := True;
End;

constructor TPessoaTelefoneCtrl.Create;
begin
  FObjPessoaTelefone := TPessoaTelefone.Create;
end;

function TPessoaTelefoneCtrl.DelPessoaTelefone : Boolean;
Var ObjPessoaTelefoneDAO : TPessoaTelefoneDAO;
begin
  ObjPessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
  ObjPessoaTelefoneDAO.PessoaTelefone.IndFone  := ObjPessoaTelefone.IndFone;
  ObjPessoaTelefoneDAO.PessoaTelefone.PessoaId := ObjPessoaTelefone.PessoaId;
  Result := ObjPessoaTelefoneDAO.Delete;
  if Result then
     Self.ObjPessoaTelefone.Id := 0;
  ObjPessoaTelefoneDAO := Nil;
  ObjPessoaTelefoneDAO.DisposeOf;
end;

destructor TPessoaTelefoneCtrl.Destroy;
begin
  FreeAndNil(FObjPessoaTelefone);
  inherited;
end;

function TPessoaTelefoneCtrl.GetPessoaTelefone(pIndFone : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 0): TObjectList<TPessoaTelefoneCtrl>;
Var ReturnJson : TJsonArray;
    xItens         : Integer;
    ObjPessoaTelefoneCtrl    : TPessoaTelefoneCtrl;
    ObjPessoaTelefoneDAO : TPessoaTelefoneDAO;
    vErro : string;
begin
  Result     := TObjectList<TPessoaTelefoneCtrl>.Create;
  ObjPessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
  ReturnJson := ObjPessoaTelefoneDAO.GetPessoaTelefone(pIndFone, pPessoaId, pShowErro);
  ObjPessoaTelefoneDAO := Nil;
  ObjPessoaTelefoneDAO.DisposeOf;
  If ReturnJson.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     ReturnJson := Nil;
     Exit;
  End;
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       ObjPessoaTelefoneCtrl := TPessoaTelefoneCtrl.Create;
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.Id       := ReturnJson.Items[xItens].GetValue<Integer>('id');
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.PessoaId := ReturnJson.Items[xItens].GetValue<Integer>('pessoaid');
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.Tipo     := ReturnJson.Items[xItens].GetValue<String>('tipo');
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.Telefone := ReturnJson.Items[xItens].GetValue<String>('telefone');
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.Contato  := ReturnJson.Items[xItens].GetValue<String>('contato');
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.Observacao := ReturnJson.Items[xItens].GetValue<String>('observacao');
       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.IndFone  := ReturnJson.Items[xItens].GetValue<Integer>('indfone');
//       ObjPessoaTelefoneCtrl.FObjPessoaTelefone.Status   := ReturnJson.Items[xItens].GetValue<Integer>('status');
       Result.Add(ObjPessoaTelefoneCtrl);
       ObjPessoaTelefoneCtrl  := Nil;
      xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else If pShowErro = 1 then
     Raise Exception.Create('Registro de Embalagem não encontrado');
end;

function TPessoaTelefoneCtrl.Salvar: Boolean;
Var ObjPessoaTelefoneDAO : TPessoaTelefoneDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjPessoaTelefoneDAO := TPessoaTelefoneDAO.Create;
  ObjPessoaTelefoneDAO.PessoaTelefone := Self.ObjPessoaTelefone;
  Result := ObjPessoaTelefoneDAO.Salvar;
  if Result then
     Self.ObjPessoaTelefone.Id := 0;
  ObjPessoaTelefoneDAO := Nil;
  ObjPessoaTelefoneDAO.DisposeOf;
end;

End.

