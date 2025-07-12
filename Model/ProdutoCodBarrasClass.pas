unit ProdutoCodBarrasClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json;

type
  Tcrud = (Ins, Upd);

  TProdutoCodBarras = class
  private
    // FCrud            : TCrud;
    FCodBarrasID: Integer;
    FProdutoID: Integer;
    FCodBarras: String;
    FUnidadesEmbalagem: Integer;
    FPrincipal: Integer;
    FStatus: Integer;
    Function NextCodigo: Integer; // Gerador de Código Automático
  Protected
  Public
    CRUD: Tcrud;
    constructor Create;
    Function Salvar: Boolean; // (const ObjLote: TProdutoCodBarras)
    Class Function ExportaExcel: Boolean;
    Function ClassToJson(Const ObjProdutoCodBarras: TProdutoCodBarras): String;
    Function JsonToClass(Json: String): TProdutoCodBarras;
    Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Function GetProdutoCodBarras(pProdutoCodBarrasId: Integer = 0;
      pProdutoid: Integer = 0; pCodBarras: String = ''; pShowErro: Integer = 1)
      : tJsonArray;
    Function DeleteProdutoCodBarras: Boolean;

    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property CodBarrasID: Integer Read FCodBarrasID Write FCodBarrasID;
    property ProdutoID: Integer Read FProdutoID Write FProdutoID;
    Property CodBarras: String Read FCodBarras Write FCodBarras;
    property UnidadesEmbalagem: Integer Read FUnidadesEmbalagem
      Write FUnidadesEmbalagem;
    Property Principal: Integer Read FPrincipal Write FPrincipal;
    property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TProdutoCodBarras }

Uses ProdutoCodBarrasDAO, uFuncoes;

function TProdutoCodBarras.ClassToJson(Const ObjProdutoCodBarras
  : TProdutoCodBarras): String;
begin
  Result := tJson.ObjectToJsonString(ObjProdutoCodBarras);
end;

procedure TProdutoCodBarras.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TProdutoCodBarras.Create;
Begin
  FCodBarrasID := 0;
  FProdutoID := 0;
  FCodBarras := '';
  FUnidadesEmbalagem := 0;
  FPrincipal := 1;
  FStatus := 1;
End;

function TProdutoCodBarras.DeleteProdutoCodBarras: Boolean;
Var
  ObjProdutoCodBarrasDAO: TProdutoCodBarrasDAO;
begin
  // Result := False; //TLaboratorioCtrl.DelLaboratorio(pIdLaboratorio);
  ObjProdutoCodBarrasDAO := TProdutoCodBarrasDAO.Create;
  ObjProdutoCodBarrasDAO.ProdutoCodBarras.CodBarrasID := Self.FCodBarrasID;
  Result := ObjProdutoCodBarrasDAO.Delete;
  FreeAndNil(ObjProdutoCodBarrasDAO);
end;

Class Function TProdutoCodBarras.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryLote);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacionale se o MS-Excel está instalado.');
  End;
end;

function TProdutoCodBarras.GetProdutoCodBarras(pProdutoCodBarrasId,
  pProdutoid: Integer; pCodBarras: String; pShowErro: Integer): tJsonArray;
Var
  ObjProdutoCodBarrasDAO: TProdutoCodBarrasDAO;
begin
  ObjProdutoCodBarrasDAO := TProdutoCodBarrasDAO.Create;
  Result := ObjProdutoCodBarrasDAO.GetProdutoCodBarras(pProdutoCodBarrasId,
    pProdutoid, pCodBarras, pShowErro);
  FreeAndNil(ObjProdutoCodBarrasDAO);
end;

function TProdutoCodBarras.JsonToClass(Json: String): TProdutoCodBarras;
begin
  Result := TProdutoCodBarras.Create;
  Result := tJson.JsonToObject<TProdutoCodBarras>(Json, [joDateFormatUnix])
end;

function TProdutoCodBarras.NextCodigo: Integer;
Begin
  // Result := DmRhemaWMS.CodGeral('Lote', 'Id', '');
End;

function TProdutoCodBarras.Salvar: Boolean;
// (const ObjLote: TProdutoCodBarras):
Var
  ObjProdutoCodBarrasDAO: TProdutoCodBarrasDAO;
begin
  ObjProdutoCodBarrasDAO := TProdutoCodBarrasDAO.Create;
  ObjProdutoCodBarrasDAO.ProdutoCodBarras := Self;
  Result := ObjProdutoCodBarrasDAO.Salvar;
  FreeAndNil(ObjProdutoCodBarrasDAO);
End;

End.
