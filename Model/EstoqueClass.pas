{
  EstoqueClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 08/07/2021
  Projeto: RhemaWMS
}
unit EstoqueClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types
  // , VolumeEmbalagemClass
    ;

Type

  TEstoque = Class
  private
    FProdutoId: Integer;
    FCodigoERP: Integer;
    FProduto: String;
    FUnidadeId: Integer;
    FUnidadeSecuncariaId: Integer;
    FEmbPrim: String;
    FEmbSec: String;
    FMesSaidaMinima: Integer;
    FLoteId: Integer;
    FDescrLote: String;
    FFabricacao: TDate;
    FVencimento: TDate;
    FEnderecoId: Integer;
    FEndereco: String;
    FEstruturaId: Integer;
    FEstrutura: String;
    FPickingFixo: Integer;
    FStatus: Integer;
    FZonaID: Integer;
    FZona: String;
    FQtdeProducao: Integer;
    FQtdeReserva: Integer;
    FQtde: Integer;
    FEstoqueTipoId: Integer;
    FEstoqueTipo: String;
    FQtdUnid: Integer;
    FFatorConversao: Integer;
    FProducao: Integer;
    FDistribuicao: Integer;
    FDtEntrada: TDate;
    FHrEntrada: TTime;
    FHorario: TDateTime;
    FUsuarioId: Integer;
    FOrdem: Integer;
    FMascara: String;
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjEstoque: TEstoque): String;
    Class Function JsonToClass(Json: String): TEstoque;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property ProdutoId: Integer Read FProdutoId Write FProdutoId;
    Property CodigoERP: Integer Read FCodigoERP Write FCodigoERP;
    Property Produto: String Read FProduto Write FProduto;
    Property UnidadeId: Integer Read FUnidadeId Write FUnidadeId;
    Property UnidadeSecundariaId: Integer Read FUnidadeId Write FUnidadeId;
    Property EmbPrim: String Read FEmbPrim Write FEmbPrim;
    Property EmbSec: String Read FEmbSec Write FEmbSec;
    Property QtdUnid: Integer Read FQtdUnid Write FQtdUnid;
    Property FatorConversao: Integer Read FFatorConversao Write FFatorConversao;
    Property MesSaidaMinima: Integer Read FMesSaidaMinima Write FMesSaidaMinima;
    Property LoteId: Integer Read FLoteId Write FLoteId;
    Property DescrLote: String Read FDescrLote Write FDescrLote;
    Property Fabricacao: TDate Read FFabricacao Write FFabricacao;
    Property Vencimento: TDate Read FVencimento Write FVencimento;
    Property EnderecoId: Integer Read FEnderecoId Write FEnderecoId;
    Property Endereco: String Read FEndereco Write FEndereco;
    Property Estruturaid: Integer Read FEstruturaId Write FEstruturaId;
    Property Estrutura: String Read FEstrutura Write FEstrutura;
    Property PickingFixo: Integer Read FPickingFixo Write FPickingFixo;
    Property Status: Integer Read FStatus Write FStatus;
    Property ZonaID: Integer Read FZonaID Write FZonaID;
    Property Zona: String Read FZona Write FZona;
    Property QtdeProducao: Integer Read FQtdeProducao Write FQtdeProducao;
    Property QtdeReserva: Integer Read FQtdeReserva Write FQtdeReserva;
    Property Qtde: Integer Read FQtde Write FQtde;
    Property EstoqueTipoId: Integer Read FEstoqueTipoId Write FEstoqueTipoId;
    Property EstoqueTipo: String Read FEstoqueTipo Write FEstoqueTipo;
    Property Producao: Integer Read FProducao Write FProducao;
    Property Distribuicao: Integer Read FDistribuicao Write FDistribuicao;
    Property DtEntrada: TDate Read FDtEntrada Write FDtEntrada;
    Property HrEntrada: TTime Read FHrEntrada Write FHrEntrada;
    Property Horario: TDateTime Read FHorario Write FHorario;
    Property UsuarioId: Integer Read FUsuarioId Write FUsuarioId;
    Property Ordem: Integer Read FOrdem Write FOrdem;
    Property Mascara: String Read FMascara Write FMascara;
  End;

implementation

{ TEnderecoRua }

class function TEstoque.ClassToJson(Const ObjEstoque: TEstoque): String;
begin
  Result := tJson.ObjectToJsonString(ObjEstoque);
end;

class procedure TEstoque.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TEstoque.Create;
begin
  ProdutoId := 0;
  CodigoERP := 0;
  Produto := '';
  UnidadeId := 0;
  UnidadeSecundariaId := 0;
  EmbPrim := '';
  EmbSec := '';
  LoteId := 0;
  DescrLote := '';
  Fabricacao := 0;
  Vencimento := 0;
  EnderecoId := 0;
  Endereco := '';
  Estruturaid := 0;
  Estrutura := '';
  PickingFixo := 0;
  FStatus := 1;
  ZonaID := 0;
  Zona := '';
  QtdeProducao := 0;
  QtdeReserva := 0;
  Qtde := 0;
  EstoqueTipoId := 0;
  EstoqueTipo := '';
  QtdUnid := 1;
  FatorConversao := 1;
  Producao := 0;
  Distribuicao := 0;
  DtEntrada := 0;
  HrEntrada := 0;
  Horario := 0;
  UsuarioId := 0;
  Ordem := 0;
  Mascara := '';
end;

class function TEstoque.JsonToClass(Json: String): TEstoque;
begin
  Result := tJson.JsonToObject<TEstoque>(Json, [joDateFormatUnix])
end;

end.
