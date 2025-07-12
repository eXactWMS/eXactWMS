{
   PessoaEnderecoCtrl.Pas
   Criado por Genilson S Soares em 28/05/2021
   Projeto: eXactWMS
}
unit PessoaEnderecoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , PessoaClass;

Type
  TPessoaEnderecoCtrl = Class
  Private
    FObjPessoaEndereco : TPessoaEndereco;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function GetPessoaEndereco(pId : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 0) : TObjectList<TPessoaEnderecoCtrl>;
    Function Salvar  : Boolean;  //(pHistorico: THistorico)
    Function DelPessoaEndereco : Boolean;
    Property ObjPessoaEndereco : TPessoaEndereco Read FObjPessoaEndereco Write FObjPessoaEndereco;
  End;

implementation

{ tCtrlPessoaEndereco }

uses uDmeXactWMS, uFuncoes, PessoaEnderecoDAO;

Function tPessoaEnderecoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjPessoaEndereco do Begin
    If Endereco = ''  Then
       raise Exception.Create('Informe o endereço da pessoa..');
//    if (EnderecoTipo.Descricao='') then
//       raise Exception.Create('Informe o Tipo do Endereço.');
    if Municipio = '' then
       raise Exception.Create('Informe o município referente ao endereço.');
  End;
  Result := True;
End;

constructor TPessoaEnderecoCtrl.Create;
begin
  FObjPessoaEndereco := TPessoaEndereco.Create;
end;

function TPessoaEnderecoCtrl.DelPessoaEndereco : Boolean;
Var ObjPessoaEnderecoDAO : TPessoaEnderecoDAO;
begin
  ObjPessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
  ObjPessoaEnderecoDAO.PessoaEndereco.Id := Self.ObjPessoaEndereco.Id;
  Result := ObjPessoaEnderecoDAO.Delete;
  if Result then
     Self.ObjPessoaEndereco.Id := 0;
  ObjPessoaEnderecoDAO := Nil;
  ObjPessoaEnderecoDAO.DisposeOf;
end;

destructor TPessoaEnderecoCtrl.Destroy;
begin
  FreeAndNil(FObjPessoaEndereco);
  inherited;
end;

function TPessoaEnderecoCtrl.GetPessoaEndereco(pId : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 0): TObjectList<TPessoaEnderecoCtrl>;
Var ReturnJson : TJsonArray;
    xItens         : Integer;
    ObjPessoaEnderecoCtrl    : TPessoaEnderecoCtrl;
    ObjPessoaEnderecoDAO : TPessoaEnderecoDAO;
    vErro : string;
begin
  Result     := TObjectList<TPessoaEnderecoCtrl>.Create;
  ObjPessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
  ReturnJson := ObjPessoaEnderecoDAO.GetPessoaEndereco(pId, pPessoaId, pShowErro);
  ObjPessoaEnderecoDAO := Nil;
  ObjPessoaEnderecoDAO.DisposeOf;
  If ReturnJson.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     ReturnJson := Nil;
     Exit;
  End;
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       ObjPessoaEnderecoCtrl := TPessoaEnderecoCtrl.Create;
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Id             := ReturnJson.Items[xItens].GetValue<Integer>('id');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.PessoaId       := ReturnJson.Items[xItens].GetValue<Integer>('pessoaid');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.EnderecoTipo.EnderecoTipoId := (ReturnJson.Items[xItens].GetValue<TJsonObject>('enderecotipo')).GetValue<Integer>('enderecotipoid');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.EnderecoTipo.Descricao      := (ReturnJson.Items[xItens].GetValue<TJsonObject>('enderecotipo')).GetValue<String>('descricao');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.EnderecoTipo.Status         := (ReturnJson.Items[xItens].GetValue<TJsonObject>('enderecotipo')).GetValue<Integer>('status');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Numero         := ReturnJson.Items[xItens].GetValue<String>('numero');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Cep            := ReturnJson.Items[xItens].GetValue<String>('cep');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Endereco       := ReturnJson.Items[xItens].GetValue<String>('endereco');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Complemento    := ReturnJson.Items[xItens].GetValue<String>('complemento');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Referencia     := ReturnJson.Items[xItens].GetValue<String>('referencia');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Bairro         := ReturnJson.Items[xItens].GetValue<String>('bairro');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Municipio      := ReturnJson.Items[xItens].GetValue<String>('municipio');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Uf             := ReturnJson.Items[xItens].GetValue<String>('uf');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.CodIbge        := ReturnJson.Items[xItens].GetValue<String>('codibge');
       ObjPessoaEnderecoCtrl.FObjPessoaEndereco.Status         := ReturnJson.Items[xItens].GetValue<Integer>('status');
       Result.Add(ObjPessoaEnderecoCtrl);
       ObjPessoaEnderecoCtrl  := Nil;
      xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else If pShowErro = 1 then
     Raise Exception.Create('Registro de Embalagem não encontrado');
end;

function TPessoaEnderecoCtrl.Salvar: Boolean;
Var ObjPessoaEnderecoDAO : TPessoaEnderecoDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjPessoaEnderecoDAO := TPessoaEnderecoDAO.Create;
  ObjPessoaEnderecoDAO.PessoaEndereco := Self.ObjPessoaEndereco;
  Result := ObjPessoaEnderecoDAO.Salvar;
  if Result then
     Self.ObjPessoaEndereco.Id := 0;
  ObjPessoaEnderecoDAO := Nil;
  ObjPessoaEnderecoDAO.DisposeOf;
end;

End.

