{
   ProcessoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit ProcessoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     ProcessoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TProcessoCtrl = Class
  Private
    //Funções de Validação
    FObjProcesso : TProcesso;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function GetProcesso(pProcesso : String = ''; pShowErro : Integer = 1) : TjsonArray;
    Function GetProcessoIncremental(pProcesso : String = '') : TjsonArray;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelProcesso : Boolean;
    Property ObjProcesso : TProcesso Read FObjProcesso Write FObjProcesso;
  End;

implementation

{ tCtrlProcesso }

uses ProcessoDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tProcessoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With ObjProcesso do Begin
    if (ObjProcesso.Descricao = '') then
       raise Exception.Create('Informe a descrição do Processo!');
  End;
  Result := True;
End;

constructor TProcessoCtrl.Create;
begin
  FObjProcesso := TProcesso.Create;
end;

function TProcessoCtrl.DelProcesso : Boolean;
Var ObjProcessoDAO : TProcessoDAO;
begin
  ObjProcessoDAO := TProcessoDAO.Create;
  ObjProcessoDAO.ObjProcesso.Id := Self.ObjProcesso.Id;
  Result := ObjProcessoDAO.Delete;
  if Result then
     Self.ObjProcesso.Id := 0;
  ObjProcessoDAO.Free;
end;

destructor TProcessoCtrl.Destroy;
begin
  FObjProcesso.Free;
  inherited;
end;

Function tProcessoCtrl.GetProcesso(pProcesso : String = ''; pShowErro : Integer = 1) : TJsonArray;
Var ObjProcessoDAO : TProcessoDAO;
    vErro : String;
begin
  ObjProcessoDAO := TProcessoDAO.Create;
  Result := ObjProcessoDAO.GetProcesso(pProcesso, pShowErro);
//  if (Result.Count<1) or (Result.Items[0].TryGetValue('Erro', vErro)) then
//     raise Exception.Create(vErro);
  FreeAndNil(ObjProcessoDAO);
End;

function TProcessoCtrl.GetProcessoIncremental(pProcesso: String): TjsonArray;
Var ObjProcessoDAO : TProcessoDAO;
    vErro : String;
begin
  ObjProcessoDAO := TProcessoDAO.Create;
  Result := ObjProcessoDAO.GetProcessoIncremental(pProcesso);
  ObjProcessoDAO.Free;
end;

Function tProcessoCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjProcessoDAO : TProcessoDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjProcessoDAO := TProcessoDAO.Create;
  ObjProcessoDAO.ObjProcesso := ObjProcesso;
  Result := ObjProcessoDAO.Salvar;
  ObjProcessoDAO.Free;
End;

End.
