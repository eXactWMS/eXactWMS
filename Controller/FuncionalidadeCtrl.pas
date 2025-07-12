{
   FuncionalidadeCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit FuncionalidadeCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     FuncionalidadeClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TFuncionalidadeCtrl = Class
  Private
    //Funções de Validação
    FObjFuncionalidade      : TFuncionalidade;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function GetFuncionalidade(pFuncionalidade : String = ''; pShowErro : Integer = 1) : TObjectList<TFuncionalidade>;
    Function GetTopicoFuncionalidades(pTopicoId : Integer) : TObjectList<TFuncionalidade>;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Procedure SalvarTopicoFuncionalidade(pTopicoId, pFuncionalidadeId, pStatus : Integer);
    Function DelFuncionalidade : Boolean;
    Property ObjFuncionalidade : TFuncionalidade Read FObjFuncionalidade Write FObjFuncionalidade;
  End;

implementation

{ tCtrlFuncionalidade }

uses FuncionalidadeDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tFuncionalidadeCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With ObjFuncionalidade do Begin
    if (ObjFuncionalidade.Descricao = '') then
       raise Exception.Create('Informe a descrição do tópico!');
  End;
  Result := True;
End;

constructor TFuncionalidadeCtrl.Create;
begin
  FObjFuncionalidade      := TFuncionalidade.Create;
end;

function TFuncionalidadeCtrl.DelFuncionalidade : Boolean;
Var ObjFuncionalidadeDAO : TFuncionalidadeDAO;
begin
  ObjFuncionalidadeDAO := TFuncionalidadeDAO.Create;
  ObjFuncionalidadeDAO.ObjFuncionalidade.FuncionalidadeId := Self.ObjFuncionalidade.FuncionalidadeId;
  Result := ObjFuncionalidadeDAO.Delete;
  if Result then
     Self.ObjFuncionalidade.FuncionalidadeId := 0;
  ObjFuncionalidadeDAO := Nil;
  ObjFuncionalidadeDAO.DisposeOf;
end;

destructor TFuncionalidadeCtrl.Destroy;
begin
  FreeAndNil(FObjFuncionalidade);
  inherited;
end;

Function tFuncionalidadeCtrl.GetFuncionalidade(pFuncionalidade : String = ''; pShowErro : Integer = 1) : TObjectList<TFuncionalidade>;
Var ObjFuncionalidadeDAO : TFuncionalidadeDAO;
    ReturnJson     : TJsonArray;
    //jsonFuncionalidade   : tjsonObject;
    xItensFuncionalidade : Integer;
    TmpFuncionalidade    : TFuncionalidade;
begin
  ObjFuncionalidadeDAO := TFuncionalidadeDAO.Create;
  ReturnJson := ObjFuncionalidadeDAO.GetFuncionalidade(pFuncionalidade, pShowErro);
  Result        := TObjectList<TFuncionalidade>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensFuncionalidade := 0;
     repeat
       TmpFuncionalidade := TFuncionalidade.Create;
       TmpFuncionalidade.Funcionalidadeid := ReturnJson.Get(xItensFuncionalidade).GetValue<Integer>('funcionalidadeid');
       TmpFuncionalidade.Descricao := ReturnJson.Get(xItensFuncionalidade).GetValue<String>('descricao');
       TmpFuncionalidade.Status    := ReturnJson.Get(xItensFuncionalidade).GetValue<Integer>('status');
       TmpFuncionalidade.Data      := StrToDate(ReturnJson.Get(xItensFuncionalidade).GetValue<String>('data'));
       TmpFuncionalidade.Hora      := StrToTime(ReturnJson.Get(xItensFuncionalidade).GetValue<String>('hora'));
       Result.Add(TmpFuncionalidade);
       xItensFuncionalidade := xItensFuncionalidade + 1;
     until (xItensFuncionalidade > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Funcionalidade(s) não encontrada para o software!');
  TmpFuncionalidade    := Nil;
  ObjFuncionalidadeDAO := Nil;
  ObjFuncionalidadeDAO.DisposeOf;
End;

function TFuncionalidadeCtrl.GetTopicoFuncionalidades(
  pTopicoId: Integer): TObjectList<TFuncionalidade>;
Var ObjFuncionalidadeDAO : TFuncionalidadeDAO;
    ReturnJson     : TJsonArray;
    xItensFuncionalidade : Integer;
    TmpFuncionalidade    : TFuncionalidade;
begin
  ObjFuncionalidadeDAO := TFuncionalidadeDAO.Create;
  ReturnJson := ObjFuncionalidadeDAO.GetTopicoFuncionalidades(pTopicoId, 0);
  Result        := TObjectList<TFuncionalidade>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensFuncionalidade := 0;
     repeat
       TmpFuncionalidade := TFuncionalidade.Create;
       TmpFuncionalidade.Funcionalidadeid := ReturnJson.Get(xItensFuncionalidade).GetValue<Integer>('funcionalidadeid');
       TmpFuncionalidade.Descricao := ReturnJson.Get(xItensFuncionalidade).GetValue<String>('descricao');
       TmpFuncionalidade.Status    := ReturnJson.Get(xItensFuncionalidade).GetValue<Integer>('status');
       Result.Add(TmpFuncionalidade);
       xItensFuncionalidade := xItensFuncionalidade + 1;
     until (xItensFuncionalidade > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Funcionalidade(s) não encontrada para o software para o Tópico!');
  TmpFuncionalidade    := Nil;
  ObjFuncionalidadeDAO := Nil;
  ObjFuncionalidadeDAO.DisposeOf;
  ReturnJson := Nil;
end;

Function tFuncionalidadeCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjFuncionalidadeDAO : TFuncionalidadeDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjFuncionalidadeDAO := TFuncionalidadeDAO.Create;
  ObjFuncionalidadeDAO.ObjFuncionalidade := ObjFuncionalidade;
  Result := ObjFuncionalidadeDAO.Salvar;
  ObjFuncionalidadeDAO := Nil;
  ObjFuncionalidadeDAO.DisposeOf;
End;

procedure TFuncionalidadeCtrl.SalvarTopicoFuncionalidade(pTopicoId,
  pFuncionalidadeId, pStatus: Integer);
Var ObjFuncionalidadeDAO : TFuncionalidadeDAO;
Begin
  ObjFuncionalidadeDAO := TFuncionalidadeDAO.Create;
  ObjFuncionalidadeDAO.SalvarTopicoFuncionalidade(pTopicoId, pFuncionalidadeId, pStatus);
  ObjFuncionalidadeDAO := Nil;
  ObjFuncionalidadeDAO.DisposeOf;
end;

End.
