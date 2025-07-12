{
  UnidadeClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit EnderecoEstruturaClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TEnderecoEstrutura = Class
  private
    FEstruturaId: Integer;
    // FEnderecoEstrutura : Integer;
    FDescricao: String;
    FPickingFixo: Integer;
    FDistribuicao: Integer;
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FVolumePadrao: Double;
    FCapacidadePadrao: Double;
    FMascara: String;
    FStatus: Integer;
    FSigla: String;
    procedure SetDescricao(const Value: String);
    procedure SetEstruturaId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
    procedure SetPickingFixo(const Value: Integer);
    Procedure setDistribuicao(Const Value: Integer);
    Procedure SetVolumePadrao(Const Value: Double);
    Procedure SetCapacidadePadrao(Const Value: Double);
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjEnderecoEstrutura
      : TEnderecoEstrutura): String;
    Class Function JsonToClass(Json: String): TEnderecoEstrutura;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property EstruturaId: Integer read FEstruturaId write SetEstruturaId;
    Property Descricao: String read FDescricao write SetDescricao;
    Property PickingFixo: Integer read FPickingFixo write SetPickingFixo;
    Property Distribuicao: Integer Read FDistribuicao Write setDistribuicao;
    Property Altura: Double Read FAltura Write FAltura;
    Property Largura: Double Read FLargura Write FLargura;
    Property Comprimento: Double Read FComprimento Write FComprimento;
    Property VolumePadrao: Double Read FVolumePadrao Write SetVolumePadrao;
    Property CapacidadePadrao: Double Read FCapacidadePadrao
      Write SetCapacidadePadrao;
    Property Mascara: String Read FMascara Write FMascara;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TEnderecoEstrutura }

class function TEnderecoEstrutura.ClassToJson(Const ObjEnderecoEstrutura
  : TEnderecoEstrutura): String;
begin
  Result := tJson.ObjectToJsonString(ObjEnderecoEstrutura);
end;

class procedure TEnderecoEstrutura.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

constructor TEnderecoEstrutura.Create;
begin
  FEstruturaId := 0;
  // FEnderecoEstrutura := 0;
  FDescricao := '';
  FPickingFixo := 0;
  FDistribuicao := 0;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FVolumePadrao := 0;
  FCapacidadePadrao := 0;
  FMascara := '';
  FStatus := 0;
  FSigla := '';
end;

class function TEnderecoEstrutura.JsonToClass(Json: String): TEnderecoEstrutura;
begin
  Result := tJson.JsonToObject<TEnderecoEstrutura>(Json, [joDateFormatUnix])
end;

procedure TEnderecoEstrutura.Limpar;
begin
  FEstruturaId := 0;
  FDescricao := '';
  FPickingFixo := 0;
  FDistribuicao := 0;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FVolumePadrao := 0;
  FCapacidadePadrao := 0;
end;

procedure TEnderecoEstrutura.SetCapacidadePadrao(const Value: Double);
begin
  FCapacidadePadrao := Value;
end;

procedure TEnderecoEstrutura.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TEnderecoEstrutura.setDistribuicao(const Value: Integer);
begin
  FDistribuicao := Value;
end;

procedure TEnderecoEstrutura.SetEstruturaId(const Value: Integer);
begin
  FEstruturaId := Value;
end;

procedure TEnderecoEstrutura.SetPickingFixo(const Value: Integer);
begin
  FPickingFixo := Value;
end;

procedure TEnderecoEstrutura.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

procedure TEnderecoEstrutura.SetVolumePadrao(const Value: Double);
begin
  FVolumePadrao := Value;
end;

end.
