{
   PerfilCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit PerfilCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     PerfilClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TPerfilCtrl = Class
  Private
    //Funções de Validação
    FObjPerfil      : TPerfil;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function GetPerfil(pPerfil : String = ''; pShowErro : Integer = 1) : TObjectList<TPerfil>;
    Function ControleAcessoTopicos : TJsonObject;
    Function ControleAcessoFuncionalidades(pListaTopicos : String) : TJsonObject;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function AtualizarPermissao : TJsonArray;
    Function SalvarAcesso(pJsonObject : TJsonObject) : Boolean;
    Function DelPerfil : Boolean;
    Property ObjPerfil : TPerfil Read FObjPerfil Write FObjPerfil;
  End;

implementation

{ tCtrlPerfil }

uses PerfilDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tPerfilCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With ObjPerfil do Begin
    if (ObjPerfil.Descricao = '') then
       raise Exception.Create('Informe a descrição do tópico!');
  End;
  Result := True;
End;

function TPerfilCtrl.AtualizarPermissao: TJsonArray;
Var ObjPerfilDAO : TPerfilDAO;
begin
   ObjPerfilDAO := TPerfilDAO.Create;
  ObjPerfilDAO.ObjPerfil := Self.ObjPerfil;
  Result := ObjPerfilDAO.AtualizarPermissao(ObjPerfil.PerfilId);
  ObjPerfilDAO.Free;
end;

function TPerfilCtrl.ControleAcessoFuncionalidades(
  pListaTopicos: String): TJsonObject;
Var ObjPerfilDAO : TPerfilDAO;
begin
  ObjPerfilDAO := TPerfilDAO.Create;
  ObjPerfilDAO.ObjPerfil := Self.ObjPerfil;
  Result := ObjPerfilDAO.ControleAcessoFuncionalidades(pListaTopicos);
  ObjPerfilDAO.Free;
end;

function TPerfilCtrl.ControleAcessoTopicos: TJsonObject;
Var ObjPerfilDAO : TPerfilDAO;
begin
  ObjPerfilDAO := TPerfilDAO.Create;
  ObjPerfilDAO.ObjPerfil := Self.ObjPerfil;
  Result := ObjPerfilDAO.ControleAcessoTopicos;
  ObjPerfilDAO.Free;
end;

constructor TPerfilCtrl.Create;
begin
  FObjPerfil      := TPerfil.Create;
end;

function TPerfilCtrl.DelPerfil : Boolean;
Var ObjPerfilDAO : TPerfilDAO;
begin
  ObjPerfilDAO := TPerfilDAO.Create;
  ObjPerfilDAO.ObjPerfil.PerfilId := Self.ObjPerfil.PerfilId;
  Result := ObjPerfilDAO.Delete;
  if Result then
     Self.ObjPerfil.PerfilId := 0;
  ObjPerfilDAO := Nil;
  ObjPerfilDAO.Free;
end;

destructor TPerfilCtrl.Destroy;
begin
  FreeAndNil(FObjPerfil);
  inherited;
end;

Function tPerfilCtrl.GetPerfil(pPerfil : String = ''; pShowErro : Integer = 1) : TObjectList<TPerfil>;
Var ObjPerfilDAO : TPerfilDAO;
    ReturnJson     : TJsonArray;
    jsonPerfil   : tjsonObject;
    xItensPerfil : Integer;
    TmpPerfil    : TPerfil;
begin
  ObjPerfilDAO := TPerfilDAO.Create;
  ReturnJson := ObjPerfilDAO.GetPerfil(pPerfil, pShowErro);
  Result     := TObjectList<TPerfil>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensPerfil := 0;
     repeat
       TmpPerfil := TPerfil.Create;
       TmpPerfil.PerfilId  := ReturnJson.Get(xItensPerfil).GetValue<Integer>('perfilid');
       TmpPerfil.Descricao := ReturnJson.Get(xItensPerfil).GetValue<String>('descricao');
       TmpPerfil.Status    := ReturnJson.Get(xItensPerfil).GetValue<Integer>('status');
       TmpPerfil.Data      := StrToDate(ReturnJson.Get(xItensPerfil).GetValue<String>('data'));
       TmpPerfil.Hora      := StrToTime(ReturnJson.Get(xItensPerfil).GetValue<String>('hora'));
      Result.Add(TmpPerfil);
       Inc(xItensPerfil);
     until (xItensPerfil > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Perfil de usuário(s) não encontrado!');
  TmpPerfil    := Nil;
  ReturnJson   := Nil;
  ObjPerfilDAO.Free;
End;

Function tPerfilCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjPerfilDAO : TPerfilDAO;
Begin
  Try
    if Not VerificaDados then
       Exit;
    ObjPerfilDAO := TPerfilDAO.Create;
    ObjPerfilDAO.ObjPerfil := ObjPerfil;
    Result := ObjPerfilDAO.Salvar;
    ObjPerfilDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonObject.Create.AddPair('Erro', E.Message);
    End;
  End;
End;

function TPerfilCtrl.SalvarAcesso(pJsonObject: TJsonObject): Boolean;
Var ObjPerfilDAO : TPerfilDAO;
Begin
  ObjPerfilDAO := TPerfilDAO.Create;
  ObjPerfilDAO.ObjPerfil := ObjPerfil;
  Result := ObjPerfilDAO.SalvarAcesso(pJsonObject);
  ObjPerfilDAO.Free;
end;

End.
