{
  UnidadeClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit EnderecoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types,
  EnderecamentoRuaClass,
  EnderecamentoZonaClass,
  EnderecoEstruturaClass,
  DesenhoArmazemClass;

Type

  TEndereco = Class
  private
    FEnderecoId: Integer;
    FEnderecoRua: TEnderecoRua;
    FEnderecoEstrutura: TEnderecoEstrutura;
    FEnderecamentoZona: TEnderecamentoZona;
    FDescricao: String;
    FDesenhoArmazem: TDesenhoArmazem;
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FVolume: Double;
    FCapacidade: Double; // Peso(g)
    FProdutoId: Integer;
    FCodProduto: Integer;
    FCurva: String;
    FStatus: Integer;
    FBloqueado : Integer;
    FBloqueioInventario :Integer;
    procedure SetDescricao(const Value: String);
    procedure SetEnderecoId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjEndereco: TEndereco): String;
    Class Function JsonToClass(Json: String): TEndereco;
    Procedure Limpar;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);

    Property EnderecoId: Integer Read FEnderecoId Write SetEnderecoId;
    Property EnderecoRua: TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
    Property EnderecoEstrutura: TEnderecoEstrutura Read FEnderecoEstrutura
      Write FEnderecoEstrutura;
    Property EnderecamentoZona: TEnderecamentoZona Read FEnderecamentoZona
      Write FEnderecamentoZona;
    Property Descricao: String Read FDescricao Write SetDescricao;
    Property DesenhoArmazem: TDesenhoArmazem Read FDesenhoArmazem
      Write FDesenhoArmazem;
    Property Altura: Double Read FAltura Write FAltura;
    Property Largura: Double Read FLargura Write FLargura;
    Property Comprimento: Double Read FComprimento Write FComprimento;
    Property Volume: Double Read FVolume Write FVolume;
    Property Capacidade: Double Read FCapacidade Write FCapacidade;
    Property ProdutoId: Integer Read FProdutoId Write FProdutoId;
    Property CodProduto: Integer Read FCodProduto Write FCodProduto;
    Property Curva: String Read FCurva Write FCurva;
    Property Status: Integer read FStatus write SetStatus;
    Property Bloqueado: Integer read FBloqueado write FBloqueado;
    Property BloqueioInventario : Integer Read FBloqueioInventario Write FBloqueioInventario;
  End;

implementation

{ TEndereco }

Uses uFuncoes;

class function TEndereco.ClassToJson(Const ObjEndereco: TEndereco): String;
begin
  Result := tJson.ObjectToJsonString(ObjEndereco);
end;

class procedure TEndereco.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TEndereco.Create;
begin
  FEnderecoId := 0;
  FEnderecoRua := TEnderecoRua.Create;
  FEnderecoEstrutura := TEnderecoEstrutura.Create;
  FEnderecamentoZona := TEnderecamentoZona.Create;
  FDesenhoArmazem := TDesenhoArmazem.Create;
  FAltura      := 0;
  FLargura     := 0;
  FComprimento := 0;
  FVolume      := 0;
  FCapacidade  := 0; // Peso(g)
  FProdutoId   := 0;
  FCodProduto  := 0;
  FCurva       := '';
  FStatus      := 1;
  FBloqueado   := 0;
  FBloqueioInventario := 0;
end;

destructor TEndereco.Destroy;
begin
  FEnderecoEstrutura.Free;
  FEnderecamentoZona.Free;
  FEnderecoRua.Free;
  FDesenhoArmazem.Free;
  inherited;
end;

class function TEndereco.JsonToClass(Json: String): TEndereco;
Var JsonEndereco : TJsonObject;
begin
  JsonEndereco := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Json), 0) as TJSonObject;
  Result := TEndereco.Create;
  Result.FEnderecoId  := JsonEndereco.GetValue<Integer>('enderecoid');
  Result.FDescricao   := JsonEndereco.GetValue<String>('descricao', '');
  Result.FAltura      := JsonEndereco.GetValue<Double>('altura', 0);
  Result.FLargura     := JsonEndereco.GetValue<Double>('largura', 0);
  Result.FComprimento := JsonEndereco.GetValue<Double>('comprimento', 0);
  Result.Volume       := JsonEndereco.GetValue<Double>('volume', 0);
  Result.FCapacidade  := JsonEndereco.GetValue<Double>('capacidade', 0);
  Result.FCurva       := '';//JsonEndereco.GetValue<string>('curva');
  Result.FStatus      := JsonEndereco.GetValue<integer>('status', 0);
  Result.Bloqueado    := JsonEndereco.GetValue<Integer>('bloqueado', 0);
  Result.BloqueioInventario := JsonEndereco.GetValue<Integer>('bloqueioinventario', 0);

  Result.FEnderecoEstrutura.EstruturaId := JsonEndereco.GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('estruturaid');
  Result.FEnderecoEstrutura.Descricao   := JsonEndereco.GetValue<TJsonObject>('enderecoestrutura').GetValue<string>('descricao');
  Result.FEnderecoEstrutura.PickingFixo := JsonEndereco.GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('pickingfixo');
  Result.FEnderecoEstrutura.Mascara     := JsonEndereco.GetValue<TJsonObject>('enderecoestrutura').GetValue<string>('mascara');

  Result.FEnderecoRua.RuaId     := JsonEndereco.GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ruaid');
  Result.FEnderecoRua.Descricao := JsonEndereco.GetValue<TJsonObject>('enderecorua').GetValue<string>('descricao');
  Result.FEnderecoRua.lado      := JsonEndereco.GetValue<TJsonObject>('enderecorua').GetValue<string>('lado');
  Result.FEnderecoRua.Ordem     := JsonEndereco.GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ordem');

  Result.FEnderecamentoZona.ZonaId        := JsonEndereco.GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid');
  Result.FEnderecamentoZona.Descricao     := JsonEndereco.GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
  Result.FEnderecamentoZona.EstoqueTipoId := JsonEndereco.GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('estoquetipoid');
  Result.FEnderecamentoZona.status        := JsonEndereco.GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('status');
  Result.FEnderecamentoZona.ProdutoSNGPC  := JsonEndereco.GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('produtosngpc');

  Result.FDesenhoArmazem.Id        := JsonEndereco.GetValue<TJsonObject>('desenhoarmazem').GetValue<Integer>('Id');
  Result.FDesenhoArmazem.Descricao := JsonEndereco.GetValue<TJsonObject>('desenhoarmazem').GetValue<String>('descricao');

  Result.FProdutoId  := JsonEndereco.GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid');
  Result.FCodProduto := JsonEndereco.GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
//Result := tJson.JsonToObject<TEndereco>(Json, [joDateFormatUnix])
end;

procedure TEndereco.Limpar;
begin
  FEnderecoId := 0;
  FEnderecoRua.Limpar;
  FEnderecoEstrutura.Limpar;
  FEnderecamentoZona.Limpar;
  FDescricao := '';
  FDesenhoArmazem.Limpar;
  FAltura      := 0;
  FLargura     := 0;
  FComprimento := 0;
  FVolume      := 0;
  FCapacidade  := 0; // Peso(g)
  FProdutoId   := 0;
  FCodProduto  := 0;
  FCurva       := '';
  FStatus      := 0;
  FBloqueado   := 0;
  FBloqueioInventario := 0;
end;

procedure TEndereco.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TEndereco.SetEnderecoId(const Value: Integer);
begin
  FEnderecoId := Value;
end;

procedure TEndereco.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
