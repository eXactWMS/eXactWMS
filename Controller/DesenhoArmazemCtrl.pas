{
   EnderecamentoRuaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit DesenhoArmazemCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     DesenhoArmazemClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);

  TDesenhoArmazemCtrl = Class
  Private
    //Funções de Validação
    FDesenhoArmazem      : TDesenhoArmazem;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados(ObjDesenhoArmazem : TDesenhoArmazem) : Boolean;
    Function GetDesenhoArmazem(pArmazemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelArmazem : Boolean;
    Property ObjDesenhoArmazem : TDesenhoArmazem Read FDesenhoArmazem Write FDesenhoArmazem;
  End;

implementation

{ tCtrlDesenhoArmazem }

uses DesenhoArmazemDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tDesenhoArmazemCtrl.VerificaDados(ObjDesenhoArmazem : TDesenhoArmazem) : Boolean;
Begin
  Result := False;
  if ObjDesenhoArmazem.Descricao = '' then
     raise Exception.Create('Informe a Identificação da Rua!');
  Result := True;
End;

constructor TDesenhoArmazemCtrl.Create;
begin
  FDesenhoArmazem      := TDesenhoArmazem.Create;
end;

function TDesenhoArmazemCtrl.DelArmazem : Boolean;
Var ObjDesenhoArmazemDAO : TDesenhoArmazemDAO;
begin
  ObjDesenhoArmazemDAO := TDesenhoArmazemDAO.Create;
  ObjDesenhoArmazemDAO.ObjDesenhoArmazem.Id := Self.FDesenhoArmazem.Id;
  Result := ObjDesenhoArmazemDAO.Delete;
  if Result then
     Self.ObjDesenhoArmazem.Id := 0;
  ObjDesenhoArmazemDAO := Nil;
  ObjDesenhoArmazemDAO.DisposeOf;
end;

destructor TDesenhoArmazemCtrl.Destroy;
begin
  FreeAndNil(FDesenhoArmazem);
  inherited;
end;

Function tDesenhoArmazemCtrl.GetDesenhoArmazem(pArmazemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TJsonArray;
Var ObjDesenhoArmazemDAO : TDesenhoArmazemDAO;
begin
  ObjDesenhoArmazemDAO := TDesenhoArmazemDAO.Create;
  //ObjDesenhoArmazemDAO.ObjDesenhoArmazem.Id := ObjDesenhoArmazem.Id;
  Result := ObjDesenhoArmazemDAO.GetDesenhoArmazem(pArmazemId, pDescricao, pShowErro);
  if Result.Count >= 1 then
     ObjDesenhoArmazem  := ObjDesenhoArmazem.JsonToClass(Result.Items[0].Tostring)
  Else if pShowErro = 1 Then
     Raise Exception.Create('Dados não encontrado na Pesquisa!');
  ObjDesenhoArmazemDAO.DisposeOf;
End;

Function tDesenhoArmazemCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjDesenhoArmazemDAO : TDesenhoArmazemDAO;
Begin
  ObjDesenhoArmazemDAO := TDesenhoArmazemDAO.Create;
  ObjDesenhoArmazemDAO.ObjDesenhoArmazem := ObjDesenhoArmazem;
  Result := ObjDesenhoArmazemDAO.Salvar;
  ObjDesenhoArmazemDAO := Nil;
  ObjDesenhoArmazemDAO.DisposeOf;
End;

End.
