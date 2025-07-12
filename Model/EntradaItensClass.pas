{
  EntradaClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit EntradaItensClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json,
  ProdutoClass,
  LotesClass;

type
  Tcrud = (Ins, Upd);

  TEntradaItens = class
  private
    // FCrud            : TCrud;
    FEntradaId: Integer;
    FEntradaItemId: Integer;
    FProdutoLotes: TProdutoLotes;
    // FLote          : TLote;
    FQtdXml: Integer;
    FQtdCheckIn: Integer;
    FQtdDevolvida: Integer;
    FQtdSegregada: Integer;
    FPrintEtqControlado: Integer;
    Function NextCodigo: Integer; // Gerador de Código Automático
  Protected
  Public
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean; // (const ObjEntrada: TEntrada)
    Class Function ExportaExcel: Boolean;
    Function ClassToJson(Const ObjEntradaItens: TEntradaItens): String;
    Function JsonToClass(Json: String): TEntradaItens;
    Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Function GetEntradaItens(pEntradaId: Integer = 0; pProdutoId: Integer = 0;
      pLoteId: Integer = 0; pShowErro: Integer = 1): tJsonArray;
    Function GetEntradaProduto(pEntradaId: Integer = 0; pShowErro: Integer = 1)
      : tJsonArray;
    Function DeleteEntradaItens(pEntradaId: Integer = 0;
      pLoteId: Integer = 0): Boolean;
    Function GetProdutoTagClass(pPedidoId: Integer = 0;
      pDocumentoNr: String = ''; pDtDocumentoData: TDateTime = 0;
      pRegistroERP: String = ''; pDtCheckInFinalizacao: TDateTime = 0;
      pCodigoERP: Integer = 0; pTagEstoque: Boolean = False): tJsonArray;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property EntradaId: Integer Read FEntradaId Write FEntradaId;
    Property EntradaItemId: Integer Read FEntradaItemId Write FEntradaItemId;
    Property ProdutoLotes: TProdutoLotes Read FProdutoLotes Write FProdutoLotes;
    // Property Lote          : TLote         Read FLote          Write FLote;
    Property QtdXml: Integer Read FQtdXml Write FQtdXml;
    Property QtdCheckIn: Integer Read FQtdCheckIn Write FQtdCheckIn;
    Property QtdDevolvida: Integer Read FQtdDevolvida Write FQtdDevolvida;
    Property QtdSegregada: Integer Read FQtdSegregada Write FQtdSegregada;
    Property PrintEtqControlado: Integer Read FPrintEtqControlado
      Write FPrintEtqControlado;
  End;

implementation

{ TEntradaItens }

Uses uFuncoes, uEntradaItensDAO;

Function TEntradaItens.ClassToJson(const ObjEntradaItens
  : TEntradaItens): String;
begin
  Result := tJson.ObjectToJsonString(ObjEntradaItens);
end;

Procedure TEntradaItens.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  //
end;

constructor TEntradaItens.Create;
begin
  FEntradaId := 0;
  FEntradaItemId := 0;
  FProdutoLotes := TProdutoLotes.Create;

  // FLote          := TLote.Create();
  FQtdXml := 0;
  FQtdCheckIn := 0;
  FQtdDevolvida := 0;
  FQtdSegregada := 0;
  FPrintEtqControlado := 0;
end;

Function TEntradaItens.DeleteEntradaItens(pEntradaId, pLoteId: Integer)
  : Boolean;
Var
  ObjEntradaItensDAO: TEntradaItensDAO;
begin
  ObjEntradaItensDAO := TEntradaItensDAO.Create;
  try
    ObjEntradaItensDAO.EntradaItens.EntradaItemId := Self.FEntradaItemId;
    Result := ObjEntradaItensDAO.Delete;

  finally
    FreeAndNil(ObjEntradaItensDAO);
  end;
end;

destructor TEntradaItens.Destroy;
begin
  // FLote := Nil;
  FProdutoLotes := Nil;
  inherited;
end;

Class Function TEntradaItens.ExportaExcel: Boolean;
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

Function TEntradaItens.GetEntradaItens(pEntradaId, pProdutoId, pLoteId,
  pShowErro: Integer): tJsonArray;
Var
  ObjEntradaItensDAO: TEntradaItensDAO;
begin
  ObjEntradaItensDAO := TEntradaItensDAO.Create;
  try
    Result := ObjEntradaItensDAO.GetEntradaItens(pEntradaId, pProdutoId,
      pLoteId, pShowErro);

  finally
    FreeAndNil(ObjEntradaItensDAO);
  end;
end;

function TEntradaItens.GetEntradaProduto(pEntradaId: Integer;
  pShowErro: Integer): tJsonArray;
Var
  ObjEntradaItensDAO: TEntradaItensDAO;
begin
  Try
    ObjEntradaItensDAO := TEntradaItensDAO.Create;
    Result := ObjEntradaItensDAO.GetEntradaProduto(pEntradaId, pShowErro);
    ObjEntradaItensDAO.Free;
  Except
    On E: Exception do
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaItens.GetProdutoTagClass(pPedidoId: Integer;
  pDocumentoNr: String; pDtDocumentoData: TDateTime; pRegistroERP: String;
  pDtCheckInFinalizacao: TDateTime; pCodigoERP: Integer; pTagEstoque: Boolean)
  : tJsonArray;
Var
  ObjEntradaItensDAO: TEntradaItensDAO;
begin
  ObjEntradaItensDAO := TEntradaItensDAO.Create;
  try
    Result := ObjEntradaItensDAO.GetProdutoTagClass(pPedidoId, pDocumentoNr,
      pDtDocumentoData, pRegistroERP, pDtCheckInFinalizacao, pCodigoERP,
      pTagEstoque);

  finally
    FreeAndNil(ObjEntradaItensDAO);
  end;
end;

Function TEntradaItens.JsonToClass(Json: String): TEntradaItens;
begin
  Result := TEntradaItens.Create;
  Result := tJson.JsonToObject<TEntradaItens>(Json, [joDateFormatUnix])
end;

function TEntradaItens.NextCodigo: Integer;
begin
  //
end;

function TEntradaItens.Salvar: Boolean;
begin
  Result := False;
end;

end.
