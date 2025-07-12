{
  EmbalagemCaixaClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 25/06/2021
  Projeto: RhemaWMS
}
unit PedidoVolumeClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types, PedidoSaidaClass,
  EmbalagemCaixaClass, VolumeEmbalagemClass, ProdutoClass, EnderecoClass,
  UsuarioClass;

Type
  TVolumeLoteCheckIn = Class
  Private
    FPedidoVolumeLoteId: Integer;
    FLoteId: Integer;
    FQtdApanhe: Integer;
    FQtdCorte: Integer;
    FUsuarioId: Integer;
    FDtCheckInStart: TDate;
    FHrCheckInStart: TTime;
    FDtCheckInEnd: TDate;
    FHrCheckInEnd: TTime;
  Public
    constructor Create;
    Property PedidoVolumeLoteId: Integer Read FPedidoVolumeLoteId
      Write FPedidoVolumeLoteId;
    Property LoteId: Integer Read FLoteId Write FLoteId;
    Property QtdApanhe: Integer Read FQtdApanhe Write FQtdApanhe;
    Property QtdCorte: Integer Read FQtdCorte Write FQtdCorte;
    Property UsuarioId: Integer Read FUsuarioId Write FUsuarioId;
    Property DtCheckInStart: TDate Read FDtCheckInStart Write FDtCheckInStart;
    Property HrCheckInStart: TTime Read FHrCheckInStart Write FHrCheckInStart;
    Property DtCheckInEnd: TDate Read FDtCheckInEnd Write FDtCheckInEnd;
    Property HrCheckInEnd: TTime Read FHrCheckInEnd Write FHrCheckInEnd;
  End;

  TPedidoVolumeProduto = Class
  Private
    FPedidoVolumeId: Integer;
    FProdutoId: Integer;
    FCodProduto: Integer;
    FDescricao: String;
    FDemanda: Integer;
    FEmbalagemPadrao: Integer;
    FQtdSuprida: Integer;
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjPedidoVolumeProduto
      : TPedidoVolumeProduto): String;
    Class Function JsonToClass(Json: String): TPedidoVolumeProduto;
    Property PedidoVolumeId: Integer Read FPedidoVolumeId Write FPedidoVolumeId;
    Property ProdutoId: Integer read FProdutoId Write FProdutoId;
    Property CodProduto: Integer Read FCodProduto Write FCodProduto;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property Demanda: Integer Read FDemanda Write FDemanda;
    Property EmbalagemPadrao: Integer Read FEmbalagemPadrao
      Write FEmbalagemPadrao;
    Property QtdSuprida: Integer Read FQtdSuprida Write FQtdSuprida;
  End;

  TPedidoVolumeLote = Class
  private
    FPedidoVolumeLoteId: Integer;
    FPedidoVolumeId: Integer;
    FLote: TProdutoLotes;
    FEndereco: TEndereco;
    FEstoqueTipoId: Integer; // Criar Class
    FEstoqueTipo: String;
    FQuantidade: Integer;
    FEmbalagemPadrao: Integer;
    FQtdSuprida: Integer;
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FTerminal: String;
    FUsuario: TUsuario;
    FProcessado: Integer;
    FVolumeLoteCheckIn: TVolumeLoteCheckIn;
  Public
    constructor Create;
    destructor Destroy; override;
    Class Function ClassToJson(Const ObjPedidoVolumeLote
      : TPedidoVolumeLote): String;
    Class Function JsonToClass(Json: String): TPedidoVolumeLote;
    Property PedidoVolumeLoteId: Integer Read FPedidoVolumeLoteId
      Write FPedidoVolumeLoteId;
    Property PedidoVolumeId: Integer Read FPedidoVolumeId Write FPedidoVolumeId;
    Property Lote: TProdutoLotes Read FLote Write FLote;
    Property Endereco: TEndereco Read FEndereco Write FEndereco;
    Property EstoqueTipoId: Integer Read FEstoqueTipoId Write FEstoqueTipoId;
    // Criar Class
    Property EstoqueTipo: String Read FEstoqueTipo Write FEstoqueTipo;
    Property Quantidade: Integer Read FQuantidade Write FQuantidade;
    Property EmbalagemPadrao: Integer Read FEmbalagemPadrao
      Write FEmbalagemPadrao;
    Property QtdSuprida: Integer Read FQtdSuprida Write FQtdSuprida;
    Property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    Property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property Terminal: String Read FTerminal Write FTerminal;
    Property Usuario: TUsuario Read FUsuario Write FUsuario;
    Property Processado: Integer Read FProcessado write FProcessado;
    Property VolumeLoteCheckIn: TVolumeLoteCheckIn Read FVolumeLoteCheckIn
      Write FVolumeLoteCheckIn;
  End;

  TPedidoVolume = Class
  private
    FPedidoVolumeId: Integer;
    FVolumeEmbalagem: TVolumeEmbalagem;
    FPedido: TPedidoSaida; // Tipo De Embalagem
    FNumSequencia: Integer;
    FCaixaEmbalagem: TCaixaEmbalagem; // Baget utilizado para o volume
    FProcessoEtapaId: Integer;
    FProcessoEtapa: String;
    FStatus: Integer;
    FLotes: TObjectList<TPedidoVolumeLote>;
    FProcessoId: Integer;
    FProcesso: String;
    Procedure SetNumSequencia(Const Value: Integer);
    Procedure SetStatus(Const Value: Integer);
  Public
    constructor Create;
    destructor Destroy; override;
    Class Function ClassToJson(Const ObjPedidoVolume: TPedidoVolume): String;
    Class Function JsonToClass(Json: String): TPedidoVolume;
    Property PedidoVolumeId: Integer Read FPedidoVolumeId Write FPedidoVolumeId;
    Property VolumeEmbalagem: TVolumeEmbalagem read FVolumeEmbalagem
      write FVolumeEmbalagem;
    Property Pedido: TPedidoSaida Read FPedido Write FPedido;
    Property NumSequencia: Integer read FNumSequencia write SetNumSequencia;
    Property CaixaEmbalagem: TCaixaEmbalagem Read FCaixaEmbalagem
      Write FCaixaEmbalagem;
    Property ProcessoEtapaId: Integer Read FProcessoEtapaId
      Write FProcessoEtapaId;
    Property ProcessoEtapa: String Read FProcessoEtapa Write FProcessoEtapa;
    Property Status: Integer read FStatus write SetStatus;
    Property Lotes: TObjectList<TPedidoVolumeLote> Read FLotes Write FLotes;
    Property ProcessoId: Integer Read FProcessoId Write FProcessoId;
    Property Processo: String Read FProcesso Write FProcesso;
  End;

implementation

{ TEnderecoRua }

class function TPedidoVolume.ClassToJson(Const ObjPedidoVolume
  : TPedidoVolume): String;
begin
  Result := tJson.ObjectToJsonString(ObjPedidoVolume);
end;

constructor TPedidoVolume.Create;
begin
  FPedidoVolumeId := 0;
  FVolumeEmbalagem := TVolumeEmbalagem.Create;
  FPedido := TPedidoSaida.Create; // Tipo De Embalagem
  FNumSequencia := 0;
  FCaixaEmbalagem := TCaixaEmbalagem.Create;
  FProcessoEtapaId := 0;
  FProcessoEtapa := '';
  FStatus := 1;
  FLotes := TObjectList<TPedidoVolumeLote>.Create;
  FProcessoId := 0;
  FProcesso := '';
end;

destructor TPedidoVolume.Destroy;
begin
  if Assigned(FVolumeEmbalagem) then
    FreeAndNil(FVolumeEmbalagem);
  if Assigned(FPedido) then
    FreeAndNil(FPedido);
  if Assigned(FCaixaEmbalagem) then
    FreeAndNil(FCaixaEmbalagem);
  FreeAndNil(FLotes);
  inherited;
end;

class function TPedidoVolume.JsonToClass(Json: String): TPedidoVolume;
begin
  Result := tJson.JsonToObject<TPedidoVolume>(Json, [joDateFormatUnix])
end;

procedure TPedidoVolume.SetNumSequencia(const Value: Integer);
begin
  FNumSequencia := Value;
end;

procedure TPedidoVolume.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

{ TPedidoVolumeLote }

class function TPedidoVolumeLote.ClassToJson(const ObjPedidoVolumeLote
  : TPedidoVolumeLote): String;
begin
  Result := tJson.ObjectToJsonString(ObjPedidoVolumeLote);
end;

constructor TPedidoVolumeLote.Create;
begin
  FPedidoVolumeLoteId := 0;
  FPedidoVolumeId := 0;
  FLote := TProdutoLotes.Create;
  FEndereco := TEndereco.Create;
  FEstoqueTipoId := 0;
  FEstoqueTipo := '';
  FQuantidade := 0;
  FEmbalagemPadrao := 0;
  FQtdSuprida := 0;
  FDtInclusao := 0;
  FHrInclusao := 0;
  FTerminal := '';
  FUsuario := TUsuario.Create;
  FProcessado := 0;
end;

destructor TPedidoVolumeLote.Destroy;
begin
  FLote := Nil;
  FEndereco := Nil;
  FUsuario := Nil;
  inherited;
end;

class function TPedidoVolumeLote.JsonToClass(Json: String): TPedidoVolumeLote;
begin
  Result := tJson.JsonToObject<TPedidoVolumeLote>(Json, [joDateFormatUnix])
end;

{ TVolumeLoteCheckIn }

constructor TVolumeLoteCheckIn.Create;
begin
  FPedidoVolumeLoteId := 0;
  FLoteId := 0;
  FQtdApanhe := 0;
  FQtdCorte := 0;
  FUsuarioId := 0;
  FDtCheckInStart := Date();
  FHrCheckInStart := Time();
  FDtCheckInEnd := Date();
  FHrCheckInEnd := Time();
end;

{ TPedidoVolumeProduto }

class function TPedidoVolumeProduto.ClassToJson(const ObjPedidoVolumeProduto
  : TPedidoVolumeProduto): String;
begin
  Result := tJson.ObjectToJsonString(ObjPedidoVolumeProduto);
end;

constructor TPedidoVolumeProduto.Create;
begin
  FPedidoVolumeId := 0;
  FProdutoId := 0;
  FCodProduto := 0;
  FDescricao := '';
  FDemanda := 0;
  FEmbalagemPadrao := 0;
  FQtdSuprida := 0;
end;

class function TPedidoVolumeProduto.JsonToClass(Json: String)
  : TPedidoVolumeProduto;
begin
  Result := tJson.JsonToObject<TPedidoVolumeProduto>(Json, [joDateFormatUnix])
end;

end.
