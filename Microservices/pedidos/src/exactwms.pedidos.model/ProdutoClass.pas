{
  Laboratorio.Pas
  Criado por Genilson S Soares (RhemaSys) em 19/09/2020
  Projeto: RhemaWMS
}
unit ProdutoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Rest.Json, System.Json, Rest.Types,
  laboratoriosClass,
  RastroClass,
  ProdutoTipoClass,
  MedicamentoTipoClass,
  UnidadeClass,
  EnderecamentoZonaClass,
  EnderecoClass,
  LotesClass;

Type

  TProduto = Class
  private
    FIdProduto: Integer;
    FCodProduto: Integer;
    FEanPrincipal: String;
    FDescricao: String;
    FDescricaoRed: String;
    FProdutoTipo: TProdutoTipo; // Tipo de Produto
    FCodigoMS: String;
    FMedicamentoTipo: TMedicamentoTipo;
    FLaboratorio: TLaboratorio;
    FSNGPC: Boolean;
    FEndereco: TEndereco;
    FUnid: TUnidade;
    FQtdUnid: Integer;
    FUnidSecundaria: TUnidade;
    FFatorConversao: Integer;
    FSomenteCxaFechada: Integer;
    FRastro: TRastro;
    FEnderecamentoZona: TEnderecamentoZona;
    FLiquido: Boolean;
    FImportado: Boolean;
    FInflamavel: Boolean;
    FPerigoso: Boolean;
    FMedicamento: Boolean;
    FPeso: Double;
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FVolume: Double;
    FPesog         : Integer;
    FAlturaCm      : Integer;
    fLarguraCm     : Integer;
    FComprimentoCm : Integer;
    FCurva: String;
    FMinPicking: Integer;
    FMaxPicking: Integer; // Capacidade Máxima do Picking
    FQtdReposicao: Integer;
    FPercReposicao: Integer;
    FMesEntradaMinima: Integer;
    FMesSaidaMinima: Integer;
    FStatus: Integer;
    FBloqueioInventario : Integer;
    procedure SetDescricao(const Value: String);
    procedure SetDescricaoRed(const Value: String);
    procedure SetIdProduto(const Value: Integer);
    procedure SetCodProduto(const Value: Integer);
    procedure SetStatus(const Value: Integer);
    procedure SetAltura(const Value: Double);
    procedure SetCodigoMS(const Value: String);
    procedure SetComprimento(const Value: Double);
    procedure SetFatorConversao(const Value: Integer);
    procedure SetImportado(const Value: Boolean);
    procedure SetInflamavel(const Value: Boolean);
    procedure SetLargura(const Value: Double);
    procedure SetLiquido(const Value: Boolean);
    Procedure SetMinPicking(Const Value: Integer);
    procedure SetMaxPicking(const Value: Integer);
    procedure SetMesEntradaMinima(const Value: Integer);
    procedure SetMesSaidaMinima(const Value: Integer);
    procedure SetPercReposicao(const Value: Integer);
    procedure SetPerigoso(const Value: Boolean);
    procedure SetMedicamento(const Value: Boolean);
    procedure SetPeso(const Value: Double);
    procedure SetQtdReposicao(const Value: Integer);
    procedure SetQtdUnid(const Value: Integer);
    procedure SetSNGPC(const Value: Boolean);
    procedure SetVolume(const Value: Double);
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjProduto: TProduto): String;
    Class Function JsonToClass(Json: String): TProduto;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property IdProduto: Integer read FIdProduto write SetIdProduto;
    Property CodProduto: Integer read FCodProduto write SetCodProduto;
    Property EanPrincipal: String Read FEanPrincipal Write FEanPrincipal;
    Property Descricao: String read FDescricao write SetDescricao;
    Property DescricaoRed: String read FDescricaoRed write SetDescricaoRed;
    Property ProdutoTipo: TProdutoTipo read FProdutoTipo write FProdutoTipo;
    // Tipo de Produto
    Property CodigoMS: String read FCodigoMS write SetCodigoMS;
    Property MedicamentoTipo: TMedicamentoTipo read FMedicamentoTipo
      write FMedicamentoTipo;
    Property Laboratorio: TLaboratorio read FLaboratorio write FLaboratorio;
    Property SNGPC: Boolean read FSNGPC write SetSNGPC;
    Property Endereco: TEndereco read FEndereco write FEndereco;
    Property Unid: TUnidade read FUnid write FUnid;
    Property QtdUnid: Integer read FQtdUnid write SetQtdUnid;
    Property UnidSecundaria: TUnidade read FUnidSecundaria
      write FUnidSecundaria;
    Property FatorConversao: Integer read FFatorConversao
      write SetFatorConversao;
    Property SomenteCxaFechada: Integer Read FSomenteCxaFechada
      write FSomenteCxaFechada;
    Property Rastro: TRastro read FRastro write FRastro;
    // Tipo de Controle(Vencimento, Lote, Sem Controle)
    Property EnderecamentoZona: TEnderecamentoZona read FEnderecamentoZona
      write FEnderecamentoZona; // Zona de Armazenagem
    Property Liquido: Boolean read FLiquido write SetLiquido;
    Property Importado: Boolean read FImportado write SetImportado;
    Property Inflamavel: Boolean read FInflamavel write SetInflamavel;
    Property Perigoso: Boolean read FPerigoso write SetPerigoso;
    Property Medicamento: Boolean read FMedicamento write SetMedicamento;
    Property Peso: Double read FPeso write SetPeso;
    Property Altura: Double read FAltura write SetAltura;
    Property Largura: Double read FLargura write SetLargura;
    Property Comprimento: Double read FComprimento write SetComprimento;
    Property Volume: Double read FVolume write SetVolume;
    Property Curva: String Read FCurva Write FCurva;
    Property MinPicking: Integer Read FMinPicking Write FMinPicking;
    Property MaxPicking: Integer read FMaxPicking write SetMaxPicking;
    // Capacidade Máxima do Picking
    Property QtdReposicao: Integer read FQtdReposicao write SetQtdReposicao;
    Property PercReposicao: Integer read FPercReposicao write SetPercReposicao;
    Property MesEntradaMinima: Integer read FMesEntradaMinima
      write SetMesEntradaMinima;
    Property MesSaidaMinima: Integer read FMesSaidaMinima
      write SetMesSaidaMinima;
    Property Status: Integer read FStatus write SetStatus;
    Property BloqueioInventario : Integer Read FBloqueioInventario Write FBloqueioInventario;
    Property Pesog         : Integer read FPesog         write FPesog;
    Property AlturaCm      : Integer Read FAlturaCm      Write FAlturaCm;
    Property LarguraCm     : Integer Read FLarguraCM     Write FLarguraCM;
    Property ComprimentoCm : Integer Read FComprimentoCM Write FComprimentoCM;

  End;

  TProdutoLotes = Class
  private
    FProduto: TProduto;
    FLotes: TLote;
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjProdutoLote: TProdutoLotes): String;
    Class Function JsonToClass(Json: String): TProdutoLotes;
    Property Produto: TProduto Read FProduto Write FProduto;
    Property Lotes: TLote Read FLotes Write FLotes;
  End;

implementation

{ TProduto }

class function TProduto.ClassToJson(Const ObjProduto: TProduto): String;
begin
  Result := tJson.ObjectToJsonString(ObjProduto);
end;

class procedure TProduto.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TProduto.Create;
Begin
  FLaboratorio := TLaboratorio.Create;
  FRastro := TRastro.Create;
  FProdutoTipo := TProdutoTipo.Create;
  FMedicamentoTipo := TMedicamentoTipo.Create;
  FEndereco := TEndereco.Create;
  FUnid := TUnidade.Create;
  FUnidSecundaria := TUnidade.Create;
  FEnderecamentoZona := TEnderecamentoZona.Create;
  FFatorConversao := 1;
  FSomenteCxaFechada := 0;
  Limpar;
end;

destructor TProduto.Destroy;
begin
  FIdProduto := 0;
  FLaboratorio.Free;
  // FRastro.Free;
  FProdutoTipo.Free;
  FMedicamentoTipo.Free;
  FEndereco.Free;
  FUnid.Free;
  FUnidSecundaria.Free;
  FEnderecamentoZona.Free;
  inherited;
end;

class function TProduto.JsonToClass(Json: String): TProduto;
begin
  Result := tJson.JsonToObject<TProduto>(Json, [joDateFormatUnix])
end;

procedure TProduto.Limpar;
begin
  FIdProduto := 0;
  FCodProduto := 0;
  FEanPrincipal := '';
  FDescricao := '';
  FDescricaoRed := '';
  FCodigoMS := '';
  FSNGPC := False;
  FQtdUnid := 0;
  FFatorConversao := 0;
  FSomenteCxaFechada := 0;
  FLiquido := False;
  FImportado := False;
  FInflamavel := False;
  FPerigoso := False;
  FMedicamento := False;
  FPeso := 0;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FPesog    := 0;
  FAlturaCm := 0;
  FLarguraCm := 0;
  FComprimentoCm := 0;
  FVolume := 0;
  FMinPicking := 0;
  FMaxPicking := 0;
  FQtdReposicao := 0;
  FPercReposicao := 0;
  FMesEntradaMinima := 0;
  FMesSaidaMinima := 0;
  FStatus := 0;
  FBloqueioInventario := 0
end;

procedure TProduto.SetAltura(const Value: Double);
begin
  FAltura := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TProduto.SetCodigoMS(const Value: String);
begin
  FCodigoMS := Value;
end;

procedure TProduto.SetCodProduto(const Value: Integer);
begin
  FCodProduto := Value;
end;

procedure TProduto.SetComprimento(const Value: Double);
begin
  FComprimento := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetDescricaoRed(const Value: String);
begin
  FDescricaoRed := Value
end;

procedure TProduto.SetFatorConversao(const Value: Integer);
begin
  FFatorConversao := Value;
end;

procedure TProduto.SetIdProduto(const Value: Integer);
begin
  FIdProduto := Value;
end;

procedure TProduto.SetImportado(const Value: Boolean);
begin
  FImportado := Value;
end;

procedure TProduto.SetInflamavel(const Value: Boolean);
begin
  FInflamavel := Value;
end;

procedure TProduto.SetLargura(const Value: Double);
begin
  FLargura := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TProduto.SetLiquido(const Value: Boolean);
begin
  FLiquido := Value;
end;

procedure TProduto.SetMaxPicking(const Value: Integer);
begin
  FMaxPicking := Value;
end;

procedure TProduto.SetMedicamento(const Value: Boolean);
begin
  FMedicamento := Value;
end;

procedure TProduto.SetMesEntradaMinima(const Value: Integer);
begin
  FMesEntradaMinima := Value;
end;

procedure TProduto.SetMesSaidaMinima(const Value: Integer);
begin
  FMesSaidaMinima := Value;
end;

procedure TProduto.SetMinPicking(const Value: Integer);
begin
  FMinPicking := Value;
end;

procedure TProduto.SetPercReposicao(const Value: Integer);
begin
  FPercReposicao := Value;
end;

procedure TProduto.SetPerigoso(const Value: Boolean);
begin
  FPerigoso := Value;
end;

procedure TProduto.SetPeso(const Value: Double);
begin
  FPeso := Value;
end;

procedure TProduto.SetQtdReposicao(const Value: Integer);
begin
  FQtdReposicao := Value;
end;

procedure TProduto.SetQtdUnid(const Value: Integer);
begin
  FQtdUnid := Value;
end;

procedure TProduto.SetSNGPC(const Value: Boolean);
begin
  FSNGPC := Value;
end;

procedure TProduto.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

procedure TProduto.SetVolume(const Value: Double);
begin
  FVolume := Value;
end;

{ TProdutoLote }

class function TProdutoLotes.ClassToJson(const ObjProdutoLote
  : TProdutoLotes): String;
begin
  Result := tJson.ObjectToJsonString(ObjProdutoLote);
end;

constructor TProdutoLotes.Create;
begin
  FProduto := TProduto.Create;
  FLotes := TLote.Create;
end;

destructor TProdutoLotes.Destroy;
begin
  FLotes.Free;
  FProduto.Free;
  inherited;
end;

class function TProdutoLotes.JsonToClass(Json: String): TProdutoLotes;
begin
  Result := tJson.JsonToObject<TProdutoLotes>(Json, [joDateFormatUnix])
end;

end.
