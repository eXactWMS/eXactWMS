{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit ProdutoCodBarrasCtrl;

Interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     Rest.Json, System.Json, Rest.Types, ProdutoCodBarrasClass;

Type
  TipoConsulta = (Resumida, Completa);
  TProdutoCodBarrasCtrl = Class
  Private
    //Funções de Validação
    FProdutoCodBarras : TProdutoCodBarras;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function DelProdutoCodBarras : Boolean;
    Function GetProdutoCodBarras(pProdutoCodBarrasId : Integer = 0; pProdutoId : Integer = 0;
             pCodBarras : String = '*'; pShowErro : Integer = 1) : TObjectList<TProdutoCodBarrasCtrl>;
    Property ObjProdutoCodBarras  : TProdutoCodBarras Read FProdutoCodBarras Write FProdutoCodBarras;
  End;

implementation

{ tCtrlProdutoCodBarras }

uses uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tProdutoCodBarrasCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FProdutoCodBarras do Begin
    if ProdutoId = 0 then
       raise Exception.Create('Informe o Produto para o Código de Barras!');
    if (CodBarras='') then
       raise Exception.Create('Informe o Código de Barras!');
  End;
  Result := True;
End;

constructor TProdutoCodBarrasCtrl.Create;
begin
  FProdutoCodBarras := TProdutoCodBarras.Create;
end;

function TProdutoCodBarrasCtrl.DelProdutoCodBarras : Boolean;
begin
  Result := Self.FProdutoCodBarras.DeleteProdutoCodBarras;
  if Result then
     Self.FProdutoCodBarras.CodBarrasId := 0;
end;

destructor TProdutoCodBarrasCtrl.Destroy;
begin
  FProdutoCodBarras.Free;
  inherited;
end;

Function TProdutoCodBarrasCtrl.GetProdutoCodBarras(pProdutoCodBarrasId : Integer = 0; pProdutoId : Integer = 0; pCodBarras : String = '*';
  pShowErro: Integer = 1): TObjectList<TProdutoCodBarrasCtrl>;
Var ReturnJson       : TJsonArray;
    JsonProdutoCodBarras  : TJsonObject;
    xItens        : Integer;
    ObjLabCtrl       : TProdutoCodBarrasCtrl;
begin
  Result     := TObjectList<TProdutoCodBarrasCtrl>.Create;
  ReturnJson := Self.FProdutoCodBarras.GetProdutoCodBarras(pProdutoCodBarrasId, pProdutoId, pCodBarras, 0);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       ObjLabCtrl := TProdutoCodBarrasCtrl.Create;
       JsonProdutoCodBarras := tJsonObject.Create;
       JsonProdutoCodBarras := ReturnJson.Items[xItens] as TJSONObject;
       ObjLabCtrl.FProdutoCodBarras    := Self.FProdutoCodBarras.JsonToClass(JsonProdutoCodBarras.ToString());
       Result.Add(ObjLabCtrl);
       JsonProdutoCodBarras := Nil;
       JsonProdutoCodBarras.DisposeOf;
       ObjLabCtrl := Nil;
       OBJLabCtrl.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else if pShowErro = 1 then
    Raise Exception.Create('Não encontrado foi encontrado Código de Barras para o Produto.');
end;

Function tProdutoCodBarrasCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Begin
  Result := False;
  If Self.VerificaDados then
     Result :=  Self.FProdutoCodBarras.Salvar;
End;

End.

