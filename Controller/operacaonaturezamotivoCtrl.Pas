{
   operacaonaturezamotivo.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 28/03/2022
   Projeto: eXactWMS
}
unit operacaonaturezamotivoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     operacaonaturezamotivoClass, Rest.Json, System.Json, Rest.Types, System.Generics.Collections;

Type
  ToperacaonaturezamotivoCtrl = Class
  Private
    //Funções de Validação
    Foperacaonaturezamotivo      : Toperacaonaturezamotivo;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function Cancelaroperacaonaturezamotivo(pmotivoid : Integer) : Boolean;
    Function VerificaDados(Objoperacaonaturezamotivo : Toperacaonaturezamotivo) : Boolean;
    Function Getoperacaonaturezamotivo(pmotivoid : Integer = 0;  pShowErro : Integer = 1) : TJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Property Objoperacaonaturezamotivo : Toperacaonaturezamotivo Read Foperacaonaturezamotivo Write Foperacaonaturezamotivo;
  End;

implementation

{ toperacaonaturezamotivo }

uses operacaonaturezamotivoDAO, uFrmeXactWMS, uFuncoes;

Function toperacaonaturezamotivoCtrl.VerificaDados(Objoperacaonaturezamotivo : Toperacaonaturezamotivo) : Boolean;
Begin
  Result := False;

  Result := True;
End;

Function ToperacaonaturezamotivoCtrl.Cancelaroperacaonaturezamotivo(pmotivoid : Integer) : Boolean;
Var ObjoperacaonaturezamotivoDAO : ToperacaonaturezamotivoDAO;
begin
  ObjoperacaonaturezamotivoDAO := ToperacaonaturezamotivoDAO.Create;
  ObjoperacaonaturezamotivoDAO.Objoperacaonaturezamotivo.motivoid := Self.Foperacaonaturezamotivo.motivoid; 
  Result := ObjoperacaonaturezamotivoDAO.Cancelaroperacaonaturezamotivo;
  if Result then
     Self.Objoperacaonaturezamotivo.motivoid := 0;
  ObjoperacaonaturezamotivoDAO.DisposeOf;
end;

constructor ToperacaonaturezamotivoCtrl.Create;
begin
  Foperacaonaturezamotivo := Toperacaonaturezamotivo.Create;
end;

Function ToperacaonaturezamotivoCtrl.Delete : Boolean;
Var ObjoperacaonaturezamotivoDAO : ToperacaonaturezamotivoDAO;
Begin
  ObjoperacaonaturezamotivoDAO := ToperacaonaturezamotivoDAO.Create;
  ObjoperacaonaturezamotivoDAO.Objoperacaonaturezamotivo.motivoid := Self.Foperacaonaturezamotivo.motivoid;
  Result := ObjoperacaonaturezamotivoDAO.Delete;
  if Result then
     Self.Objoperacaonaturezamotivo.motivoid := 0;
  ObjoperacaonaturezamotivoDAO.DisposeOf;
End;

Destructor ToperacaonaturezamotivoCtrl.Destroy;
Begin
  Foperacaonaturezamotivo.DisposeOf;
  inherited;
End;

Function ToperacaonaturezamotivoCtrl.Getoperacaonaturezamotivo(pmotivoid : Integer = 0;  pShowErro : Integer = 1) : TJsonArray;
Var ObjoperacaonaturezamotivoDAO    : ToperacaonaturezamotivoDAO;
    JsonArrayoperacaonaturezamotivo : TJsonArray;
    vErro              : String;
begin
  ObjoperacaonaturezamotivoDAO := ToperacaonaturezamotivoDAO.Create;
  JsonArrayoperacaonaturezamotivo := ObjoperacaonaturezamotivoDAO.Getoperacaonaturezamotivo(pmotivoid);
  if (JsonArrayoperacaonaturezamotivo.Items[0].TryGetValue('Erro', vErro)) and (pShowErro = 1) then
     Raise Exception.Create('operacaonaturezamotivo(s) não encontrada!');
  ObjoperacaonaturezamotivoDAO.DisposeOf;
End;

Function ToperacaonaturezamotivoCtrl.Salvar : Boolean;
Var ObjoperacaonaturezamotivoDAO : ToperacaonaturezamotivoDAO;
Begin
  ObjoperacaonaturezamotivoDAO := ToperacaonaturezamotivoDAO.Create;
  Result := ObjoperacaonaturezamotivoDAO.Delete;
  if Result then
     Self.Objoperacaonaturezamotivo.motivoid := 0;
  ObjoperacaonaturezamotivoDAO.DisposeOf;
End;

End.

