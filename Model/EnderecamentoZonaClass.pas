{
  EnderecamentoZonaClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit EnderecamentoZonaClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Rest.Json, System.Json, Rest.Types;

Type

  Tenderecamentozona = Class
  private
    FZonaId: Integer;
    FEnderecamentoZona: Integer;
    FDescricao: String;
    FEstruturaId: Integer;
    FEstoqueTipoId: Integer;
    FRastroId: Integer;
    FLoteReposicao: Integer;
    FSeparacaoConsolidada: Integer;
    FProdutoSNGPC: Integer;
    FStatus: Integer;
    FSigla: String;
    fpickingdinamico : Integer;
    FTagVolumeOrdem  : Integer;
    FAuditavel       : Integer;

    procedure SetDescricao(const Value: String);
    procedure SetZonaId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    constructor Create;
    Class Function ClassToJson(Const objenderecamentozona : Tenderecamentozona): String;
    Class Function JsonToClass(Json: String): Tenderecamentozona;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property ZonaId: Integer           read FZonaId          write SetZonaId;
    Property Descricao: String         read FDescricao       write SetDescricao;
    Property EstruturaId: Integer      Read FEstruturaId     Write FEstruturaId;
    Property EstoqueTipoId: Integer    Read FEstoqueTipoId   Write FEstoqueTipoId;
    Property RastroId: Integer         Read FRastroId        Write FRastroId;
    Property LoteReposicao: Integer    Read FLoteReposicao   Write FLoteReposicao;
    Property SeparacaoConsolidada: Integer Read FSeparacaoConsolidada Write FSeparacaoConsolidada;
    Property ProdutoSNGPC: Integer     Read FProdutoSNGPC    Write FProdutoSNGPC;
    Property Sigla : String            Read FSigla           Write FSigla;
    Property pickingdinamico : Integer Read fpickingdinamico Write fpickingdinamico;
    Property TagVolumeOrdem : Integer  Read FTagVolumeOrdem  Write FTagVolumeOrdem;
    Property Status: Integer           read FStatus          Write SetStatus;
    Property Auditavel : Integer       Read FAuditavel       Write FAuditavel;
  End;

implementation

{ TEnderecamentoZona }

class function Tenderecamentozona.ClassToJson(Const ObjEnderecamentoZona : TEnderecamentoZona): String;
begin
  Result := tJson.ObjectToJsonString(objenderecamentozona);
end;

class procedure Tenderecamentozona.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor Tenderecamentozona.Create;
begin
  FZonaId          := 0;
  FEnderecamentoZona := 0;
  FDescricao       := '';
  FEstruturaId     := 0;
  FEstoqueTipoId   := 0;
  FRastroId        := 0;
  FLoteReposicao   := 0;
  FSeparacaoConsolidada := 0;
  FProdutoSNGPC    := 0;
  FStatus          := 0;
  fpickingdinamico := 0;
  FTagVolumeOrdem  := 0;
  FSigla           := '';
  FAuditavel       := 0;
end;

class function Tenderecamentozona.JsonToClass(Json: String): Tenderecamentozona;
begin
  Result := tJson.JsonToObject<Tenderecamentozona>(Json, [joDateFormatUnix])
end;

procedure Tenderecamentozona.Limpar;
begin
  FZonaId          := 0;
  FEnderecamentoZona := 0;
  FDescricao       := '';
  FEstruturaId     := 0;
  FEstoqueTipoId   := 0;
  FRastroId        := 0;
  FLoteReposicao   := 0;
  FSeparacaoConsolidada := 0;
  FProdutoSNGPC    := 0;
  FStatus          := 0;
  fpickingdinamico := 0;
  FTagVolumeOrdem  := 0;
  FSigla           := '';
  FAuditavel       := 0;
end;

procedure Tenderecamentozona.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure Tenderecamentozona.SetZonaId(const Value: Integer);
begin
  FZonaId := Value;
end;

procedure Tenderecamentozona.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
