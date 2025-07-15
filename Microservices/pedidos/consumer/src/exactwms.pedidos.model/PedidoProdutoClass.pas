{
  PedidoProdutoClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 16/05/2021
  Projeto: eXactWMS
}
unit PedidoProdutoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json,
  ProdutoClass;

type
  Tcrud = (Ins, Upd);

  TPedidoProduto = class
  private
    FPedidoId: Integer;
    FPedidoItemId: Integer;
    FProduto: TProduto;
    FQtdSolicitada: Integer;
    FEmbalagemPadrao: Integer;
    FQtdAtendida: Integer;
    FQtdCorte: Integer;
  Protected
  Public
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean; // (const ObjPedido: TPedido)
    Class Function ExportaExcel: Boolean;
    Function ClassToJson(Const ObjPedidoProduto: TPedidoProduto): String;
    Function JsonToClass(Json: String): TPedidoProduto;
    Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property PedidoId: Integer Read FPedidoId Write FPedidoId;
    Property PedidoItemId: Integer Read FPedidoItemId Write FPedidoItemId;
    Property Produto: TProduto Read FProduto Write FProduto;
    Property QtdSolicitada: Integer Read FQtdSolicitada Write FQtdSolicitada;
    Property EmbalagemPadrao: Integer Read FEmbalagemPadrao
      Write FEmbalagemPadrao;
    Property QtdAtendida: Integer Read FQtdAtendida Write FQtdAtendida;
    Property QtdCorte: Integer Read FQtdCorte Write FQtdCorte;
  End;

implementation

{ TPedidoProduto }

Uses uFuncoes;

Function TPedidoProduto.ClassToJson(const ObjPedidoProduto
  : TPedidoProduto): String;
begin
  Result := tJson.ObjectToJsonString(ObjPedidoProduto);
end;

Procedure TPedidoProduto.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  //
end;

constructor TPedidoProduto.Create;
begin
  FPedidoId := 0;
  FPedidoItemId := 0;
  FProduto := TProduto.Create;
  FQtdSolicitada := 0;
  FEmbalagemPadrao := 1;
  FQtdAtendida := 0;
  FQtdCorte := 0;
end;

destructor TPedidoProduto.Destroy;
begin
  FProduto := Nil;
  inherited;
end;

Class Function TPedidoProduto.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryLaboratorio);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
  End;
end;

Function TPedidoProduto.JsonToClass(Json: String): TPedidoProduto;
begin
  Result := TPedidoProduto.Create;
  Result := tJson.JsonToObject<TPedidoProduto>(Json, [joDateFormatUnix])
end;

function TPedidoProduto.Salvar: Boolean;
begin
  Result := False;
end;

end.
