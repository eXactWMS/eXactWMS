unit LotesClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json;

type
  Tcrud = (Ins, Upd);

  TLote = class
  private
    // FCrud            : TCrud;
    FProdutoId: Integer;
    FCodigoERP: Integer;
    FLoteId: Integer;
    FDescrLote: String;
    FFabricacao: TDate;
    FVencimento: TDate;
    FDtEntrada: TDate;
    FHrEntrada: TTime;
    Fstatus: Integer;
    FQtdeDisponivel: Integer;
    FBloqueado: Integer;
    Function NextCodigo: Integer; // Gerador de Código Automático
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Function Salvar: Boolean; // (const ObjLote: TLote)
    Class Function ExportaExcel: Boolean;
    Class Function ClassToJson(Const ObjLote: TLote): String;
    Class Function JsonToClass(Json: String): TLote;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property ProdutoId: Integer Read FProdutoId Write FProdutoId;
    Property CodigoERP: Integer Read FCodigoERP Write FCodigoERP;
    property LoteId: Integer Read FLoteId Write FLoteId;
    Property DescrLote: String Read FDescrLote Write FDescrLote;
    property Fabricacao: TDate Read FFabricacao Write FFabricacao;
    property Vencimento: TDate Read FVencimento Write FVencimento;
    Property DtEntrada: TDate Read FDtEntrada Write FDtEntrada;
    Property HrEntrada: TTime Read FHrEntrada Write FHrEntrada;
    Property Status: Integer Read Fstatus Write Fstatus;
    property QtdeDisponivel: Integer Read FQtdeDisponivel Write FQtdeDisponivel;
    Property Bloqueado: Integer Read FBloqueado Write FBloqueado;
  End;

implementation

{ TLote }

Uses uFuncoes;

class function TLote.ClassToJson(Const ObjLote: TLote): String;
begin
  Result := tJson.ObjectToJsonString(ObjLote);
end;

Class procedure TLote.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TLote.Create;
Begin
  FProdutoId := 0;
  FCodigoERP := 0;
  FLoteId := 0;
  FDescrLote := '';
  FFabricacao := 0;
  FVencimento := 0;
  FDtEntrada := 0;
  FHrEntrada := StrToTime('00:00');
  FQtdeDisponivel := 0;
  FBloqueado := 0;
End;

Class function TLote.ExportaExcel: Boolean;
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

class function TLote.JsonToClass(Json: String): TLote;
begin
  Result := TLote.Create;
  Result := tJson.JsonToObject<TLote>(Json, [joDateFormatUnix])
end;

function TLote.NextCodigo: Integer;
Begin
  // Result := DmRhemaWMS.CodGeral('Lote', 'Id', '');
End;

function TLote.Salvar: Boolean; // (const ObjLote: TLote):
Var
  jSonLote: TJsonObject;
  // ListaDeLotes : TJsonArray;
begin
  Result := False;


  // ListaDeLotes.AddElement(jSonLote);

End;

End.
