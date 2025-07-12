{
   EnderecamentoRuaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EnderecamentoRuaCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     EnderecamentoRuaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TEnderecoRuaCtrl = Class
  Private
    //Funções de Validação
    FEnderecoRua      : TEnderecoRua;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados(ObjEnderecoRua : TEnderecoRua) : Boolean;
    Function GetEnderecoRua(pRuaId : Integer = 0; pDescricao : String = ''; pLado : String = 'U'; pShowErro : Integer = 1) : TObjectList<TEnderecoRua>;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelEnderecoRua : Boolean;
    Property ObjEnderecoRua : TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
  End;

implementation

{ tCtrlEnderecoRua }

uses EnderecoRuaDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tEnderecoRuaCtrl.VerificaDados(ObjEnderecoRua : TEnderecoRua) : Boolean;
Begin
  Result := False;
  With ObjEnderecoRua do Begin
    if ObjEnderecoRua.Descricao = '' then
       raise Exception.Create('Informe a Identificação da Rua!');
    if (Not AnsiIndexText(ObjEnderecoRua.Lado, ['D', 'E', 'U'])<0) then
       raise Exception.Create('Informe o Lado da Rua!');
    if (ObjEnderecoRua.Ordem <= 0) then
       raise Exception.Create('Ordem da Rua no Armazem é inválida!');
  End;
  Result := True;
End;

constructor TEnderecoRuaCtrl.Create;
begin
  FEnderecoRua      := TEnderecoRua.Create;
end;

function TEnderecoRuaCtrl.DelEnderecoRua : Boolean;
Var ObjEnderecoRuaDAO : TEnderecoRuaDAO;
begin
  ObjEnderecoRuaDAO := TEnderecoRuaDAO.Create;
  ObjEnderecoRuaDAO.ObjEnderecoRua.RuaId := Self.FEnderecoRua.RuaId;
  Result := ObjEnderecoRuaDAO.Delete;
  if Result then
     Self.ObjEnderecoRua.RuaId := 0;
  ObjEnderecoRuaDAO := Nil;
  ObjEnderecoRuaDAO.DisposeOf;
end;

destructor TEnderecoRuaCtrl.Destroy;
begin
  FreeAndNil(FEnderecoRua);
  inherited;
end;

Function tEnderecoRuaCtrl.GetEnderecoRua(pRuaId : Integer = 0; pDescricao : String = ''; pLado : String = 'U'; pShowErro : Integer = 1) : TObjectList<TEnderecoRua>;
Var ObjEnderecoRuaDAO : TEnderecoRuaDAO;
    ReturnJson     : TJsonArray;
    jsonEnderecoRua   : tjsonObject;
    xItensEnderecoRua : Integer;
begin
  ObjEnderecoRuaDAO := TEnderecoRuaDAO.Create;
  ObjEnderecoRuaDAO.ObjEnderecoRua.RuaId := ObjEnderecoRua.RuaId;
  ReturnJson := ObjEnderecoRuaDAO.GetEnderecoRua(pRuaId, pDescricao, pLado, pShowErro);
  Result     := TObjectList<TEnderecoRua>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensEnderecoRua := 0;
     repeat
       jsonEnderecoRua := tJsonObject.Create;
       jsonEnderecoRua := ReturnJson.Items[xItensEnderecoRua] as TJSONObject;
       ObjEnderecoRua  := ObjEnderecoRua.JsonToClass(JsonEnderecoRua.ToString());
       Result.Add(ObjEnderecoRua);
       jsonEnderecoRua := Nil;
       jsonEnderecoRua.DisposeOf;
       Inc(xItensEnderecoRua);
     until (xItensEnderecoRua > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Não existe lote(s) deste produto!');
  ObjEnderecoRuaDAO := Nil;
  ObjEnderecoRuaDAO.DisposeOf;
End;

Function tEnderecoRuaCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjEnderecoRuaDAO : TEnderecoRuaDAO;
Begin
  ObjEnderecoRuaDAO := TEnderecoRuaDAO.Create;
  ObjEnderecoRuaDAO.ObjEnderecoRua := ObjEnderecoRua;
  Result := ObjEnderecoRuaDAO.Salvar;
  ObjEnderecoRuaDAO := Nil;
  ObjEnderecoRuaDAO.DisposeOf;
End;

End.
