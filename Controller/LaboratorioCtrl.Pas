{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit LaboratorioCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,  Generics.Collections,
      Rest.Json, System.Json, Rest.Types, LaboratoriosClass;

Type
  TipoConsulta = (Resumida, Completa);
  TLaboratorioCtrl = Class
  Private
    //Funções de Validação
    FLaboratorio : TLaboratorio;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function DelLaboratorio : Boolean;
    Function GetLaboratorio(pIdLaboratorio : Integer = 0; pNome : String = ''; pShowErro : Integer = 1) : TObjectList<TLaboratorioCtrl>;
    Function ImportDados(pCodigoERP : Integer; pNome, pFone, pEmail, pHomePage : String) : Boolean;
    Property ObjLaboratorio  : TLaboratorio Read FLaboratorio Write FLaboratorio;
    Function MontarPaginacao : Integer;
  End;

implementation

{ tCtrlLaboratorio }

uses uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tLaboratorioCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FLaboratorio do Begin
    if Nome = '' then raise Exception.Create('Informe o Nome do Fabricante!');
    if (Email<>'') and ((Pos('@',Email)<0) or (Pos('.',Email)<0)) then
       raise Exception.Create('Email inválido!');
  End;
  Result := True;
End;

constructor TLaboratorioCtrl.Create;
begin
  FLaboratorio := TLaboratorio.Create;
end;

function TLaboratorioCtrl.DelLaboratorio : Boolean;
begin
  Result := Self.FLaboratorio.DeleteLaboratorio;
  if Result then
     Self.FLaboratorio.IdLaboratorio := 0;
end;

destructor TLaboratorioCtrl.Destroy;
begin
  FLaboratorio := Nil;
  FLaboratorio.DisposeOf;
  inherited;
end;

Function TLaboratorioCtrl.GetLaboratorio(pIdLaboratorio: Integer; pNome: String;
  pShowErro: Integer): TObjectList<TLaboratorioCtrl>;
Var ReturnJson       : TJsonArray;
    JsonLaboratorio  : TJsonObject;
    xItens        : Integer;
    ObjLabCtrl       : TLaboratorioCtrl;
begin
  Result     := TObjectList<TLaboratorioCtrl>.Create;
  ReturnJson := Self.FLaboratorio.GetLaboratorio(pIdLaboratorio, pNome, 0);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       ObjLabCtrl := TLaboratorioCtrl.Create;
       JsonLaboratorio := tJsonObject.Create;
       JsonLaboratorio := ReturnJson.Items[xItens] as TJSONObject;
       ObjLabCtrl.FLaboratorio := Self.FLaboratorio.JsonToClass(JsonLaboratorio.ToString());
       Result.Add(ObjLabCtrl);
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Begin
    JsonLaboratorio := Nil;
    ObjLabCtrl := Nil;
    Raise Exception.Create('Registro de Fabricante não encontrado');
  End;
  JsonLaboratorio := Nil;
  ObjLabCtrl := Nil;
end;

function TLaboratorioCtrl.ImportDados(pCodigoERP: Integer;
  pNome, pFone, pEmail, pHomePage : String): Boolean;
Var JsonLaboratorio : TJsonObject;
    JsonArrayLaboratorio : TJsonArray;
begin
  Result := False;
  JsonLaboratorio := TJsonObject.Create();
  JsonLaboratorio.AddPair('fabricanteid', TJsonNumber.Create(pCodigoERP));
  JsonLaboratorio.AddPair('nome', pNome );
  JsonLaboratorio.AddPair('fone', pFone );
  JsonLaboratorio.AddPair('email', pEmail );
  JsonLaboratorio.AddPair('homepage', pHomePage );
  JsonArrayLaboratorio := TJsonArray.Create;
  JsonArrayLaboratorio.AddElement( JsonLaboratorio );
  Result := Self.FLaboratorio.ImportDados( JsonArrayLaboratorio );
end;

function TLaboratorioCtrl.MontarPaginacao: Integer;
Begin
  Result := Self.FLaboratorio.MontarPaginacao.GetValue<integer>('paginacao', 1);;
end;

Function tLaboratorioCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Begin
  Result := False;
  If Self.VerificaDados then
     Result :=  Self.FLaboratorio.Salvar;
End;

End.

