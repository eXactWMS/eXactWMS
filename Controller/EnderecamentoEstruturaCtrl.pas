{
   EnderecamentoEstruturaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EnderecamentoEstruturaCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     EnderecoEstruturaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TEnderecoEstruturaCtrl = Class
  Private
    //Funções de Validação
    FEstrutura      : TEnderecoEstrutura;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados(ObjEnderecoEstrutura : TEnderecoEstrutura) : Boolean;
    Function GetEnderecoEstrutura(pEstruturaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TObjectList<TEnderecoEstrutura>;
    Function GetEnderecoEstruturaJson(pEstruturaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelEnderecoEstrutura : Boolean;
    Property ObjEnderecoEstrutura : TEnderecoEstrutura Read FEstrutura Write FEstrutura;
  End;

implementation

{ tCtrlEnderecoEstrutura }

uses EnderecoEstruturaDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tEnderecoEstruturaCtrl.VerificaDados(ObjEnderecoEstrutura : TEnderecoEstrutura) : Boolean;
Begin
  Result := False;
  With ObjEnderecoEstrutura do Begin
    if ObjEnderecoEstrutura.Descricao = '' then
       raise Exception.Create('Informe a Identificação da Estrutura!');
    if (Not ObjEnderecoEstrutura.PickingFixo in [0,1]) then
       raise Exception.Create('Informe corretamente se Estrutura é para Picking!');
    if (Not ObjEnderecoEstrutura.Distribuicao in [0,1]) then
       raise Exception.Create('Informe a Estrutura é para Caixa Fechada ou Picking!');
  End;
  Result := True;
End;

constructor TEnderecoEstruturaCtrl.Create;
begin
  FEstrutura := TEnderecoEstrutura.Create;
end;

function TEnderecoEstruturaCtrl.DelEnderecoEstrutura : Boolean;
Var ObjEnderecoEstruturaDAO : TEnderecoEstruturaDAO;
begin
  ObjEnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
  ObjEnderecoEstruturaDAO.ObjEnderecoEstrutura.EstruturaId := Self.FEstrutura.EstruturaId;
  Result := ObjEnderecoEstruturaDAO.Delete;
  if Result then
     Self.ObjEnderecoEstrutura.EstruturaId := 0;
  ObjEnderecoEstruturaDAO.Free;
end;

destructor TEnderecoEstruturaCtrl.Destroy;
begin
  FEstrutura.Free;
  inherited;
end;

Function tEnderecoEstruturaCtrl.GetEnderecoEstrutura(pEstruturaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TObjectList<TEnderecoEstrutura>;
Var ObjEnderecoEstruturaDAO : TEnderecoEstruturaDAO;
    ReturnJson              : TJsonArray;
    jsonEnderecoEstrutura   : tjsonObject;
    xItensEnderecoEstrutura : Integer;
begin
  ObjEnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
  ObjEnderecoEstruturaDAO.ObjEnderecoEstrutura.EstruturaId := ObjEnderecoEstrutura.EstruturaId;
  ReturnJson := ObjEnderecoEstruturaDAO.GetEnderecoEstrutura(pEstruturaId, pDescricao, pShowErro);
  Result     := TObjectList<TEnderecoEstrutura>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensEnderecoEstrutura := 0;
     repeat
       jsonEnderecoEstrutura := tJsonObject.Create;
       jsonEnderecoEstrutura := ReturnJson.Items[xItensEnderecoEstrutura] as TJSONObject;
       ObjEnderecoEstrutura  := ObjEnderecoEstrutura.JsonToClass(JsonEnderecoEstrutura.ToString());
       Result.Add(ObjEnderecoEstrutura);
       jsonEnderecoEstrutura := Nil;
       Inc(xItensEnderecoEstrutura);
     until (xItensEnderecoEstrutura > Pred(ReturnJson.Count));
  End
  Else Begin
    jsonEnderecoEstrutura := Nil;
    ObjEnderecoEstruturaDAO.Free;
    Raise Exception.Create('Não foram encontrados endereço(s) para os parâmetros!');  ObjEnderecoEstruturaDAO := Nil;
  End;
  ObjEnderecoEstruturaDAO.Free;
End;

function TEnderecoEstruturaCtrl.GetEnderecoEstruturaJson(pEstruturaId: Integer;
  pDescricao: String; pShowErro: Integer): TJsonArray;
Var ObjEnderecoEstruturaDAO : TEnderecoEstruturaDAO;
begin
  ObjEnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
  ObjEnderecoEstruturaDAO.ObjEnderecoEstrutura.EstruturaId := ObjEnderecoEstrutura.EstruturaId;
  Result := ObjEnderecoEstruturaDAO.GetEnderecoEstrutura(pEstruturaId, pDescricao, pShowErro);
  if (Result.Count < 1) and (pShowErro = 1) then Begin
     ObjEnderecoEstruturaDAO.Free;
     Raise Exception.Create('Não foram encontrados endereço(s) para os parâmetros!');
  End;
  ObjEnderecoEstruturaDAO.Free;
end;

Function tEnderecoEstruturaCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjEnderecoEstruturaDAO : TEnderecoEstruturaDAO;
Begin
  ObjEnderecoEstruturaDAO := TEnderecoEstruturaDAO.Create;
  ObjEnderecoEstruturaDAO.ObjEnderecoEstrutura := ObjEnderecoEstrutura;
  Result := ObjEnderecoEstruturaDAO.Salvar;
  ObjEnderecoEstruturaDAO.Free;
End;

End.
