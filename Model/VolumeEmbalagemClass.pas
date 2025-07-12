unit VolumeEmbalagemClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  Rest.Json.Types,
  System.Json;

type
  Tcrud = (Ins, Upd);

  TVolumeEmbalagem = class
  private
    FEmbalagemId: Integer;
    FDescricao: String;
    FIdentificacao: String;
    FTipo: String; // R-Retornável P-Própria C-Pacote U-Reutilizável
    FTipoDescricao: String;
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FVolume: Double;
    FAproveitamento: Integer; // Valor Fixo 90%
    FTara: Double;
    FCapacidade: Double;
    FQtdLacres: Integer;
    FCodBarras: Integer; // Impressão de Código de Barras
    FDisponivel: Integer;
    FPrecoCusto: Double;
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FStatus: Integer;
    FTipoEmbalagem: String;
    Procedure SetTipo(Const Value: String);
    Procedure SetAltura(Const Value: Double);
    Procedure SetLargura(Const Value: Double);
    Procedure SetComprimento(Const Value: Double);
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean; // (const ObjVolumeEmbalagem: TVolumeEmbalagem)
    Class Function ExportaExcel: Boolean;
    Class Function ClassToJson(Const ObjVolumeEmbalagem : TVolumeEmbalagem): String;
    Class Function JsonToClass(Json: String): TVolumeEmbalagem;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property EmbalagemId: Integer Read FEmbalagemId Write FEmbalagemId;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property Identificacao: String Read FIdentificacao Write FIdentificacao;
    Property Tipo: String Read FTipo Write SetTipo;
    Property TipoDescricao: String Read FTipoEmbalagem Write FTipoEmbalagem;
    Property Altura: Double Read FAltura Write SetAltura;
    Property Largura: Double Read FLargura Write SetLargura;
    Property Comprimento: Double Read FComprimento Write SetComprimento;
    Property Volume: Double Read FVolume Write FVolume;
    Property Aproveitamento: Integer Read FAproveitamento Write FAproveitamento;
    Property Tara: Double Read FTara Write FTara;
    Property Capacidade: Double Read FCapacidade Write FCapacidade;
    Property QtdLacres: Integer Read FQtdLacres Write FQtdLacres;
    Property CodBarras: Integer Read FCodBarras Write FCodBarras;
    Property Disponivel: Integer Read FDisponivel Write FDisponivel;
    Property PrecoCusto: Double Read FPrecoCusto Write FPrecoCusto;
    Property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    Property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TVolumeEmbalagem }

Uses uFuncoes;

class function TVolumeEmbalagem.ClassToJson(Const ObjVolumeEmbalagem
  : TVolumeEmbalagem): String;
begin
  Result := tJson.ObjectToJsonString(ObjVolumeEmbalagem);
end;

Class procedure TVolumeEmbalagem.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TVolumeEmbalagem.Create;
Begin
  Limpar;
End;

destructor TVolumeEmbalagem.Destroy;
begin
  inherited;
end;

Class function TVolumeEmbalagem.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryVolumeEmbalagem);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacionale se o MS-Excel está instalado.');
  End;
end;

class function TVolumeEmbalagem.JsonToClass(Json: String): TVolumeEmbalagem;
begin
  Result := TVolumeEmbalagem.Create;
  Result := tJson.JsonToObject<TVolumeEmbalagem>(Json, [joDateFormatUnix]);
    //[joDateIsUTC, joDateFormatISO8601])
end;

procedure TVolumeEmbalagem.Limpar;
begin
  FEmbalagemId := 0;
  FDescricao := '';
  FIdentificacao := '';
  FTipo := '';
  FTipoEmbalagem := '';
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FVolume := 0;
  FAproveitamento := 90;
  FTara := 0;
  FCapacidade := 0;
  FQtdLacres := 0;
  CodBarras := 0;
  FDisponivel := 0;
  FPrecoCusto := 0;
  FStatus := 0;
  FDtInclusao := 0;
  FHrInclusao := 0;
  FStatus := 0;
end;

function TVolumeEmbalagem.Salvar: Boolean;
// (const ObjVolumeEmbalagem: TVolumeEmbalagem):
begin
  Result := False;
End;

procedure TVolumeEmbalagem.SetAltura(const Value: Double);
begin
  FAltura := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TVolumeEmbalagem.SetComprimento(const Value: Double);
begin
  FComprimento := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TVolumeEmbalagem.SetLargura(const Value: Double);
begin
  FLargura := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TVolumeEmbalagem.SetTipo(const Value: String);
begin
  FTipo := Value;
  if Value = 'R' then
    FTipoDescricao := 'Retornável'
  Else If Value = 'P' then
    FTipoDescricao := 'Própria'
  Else If Value = 'C' then
    FTipoDescricao := 'Pacote'
  Else If Value = 'U' then
    FTipoDescricao := 'Reutilizável';
end;

End.
