{
  EmbalagemCaixaClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 25/06/2021
  Projeto: RhemaWMS
}
unit EmbalagemCaixaClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types,
  VolumeEmbalagemClass;

Type

  TCaixaEmbalagem = Class
  private
    FCaixaEmbalagemId : Integer;
    FVolumeEmbalagem  : TVolumeEmbalagem; // Tipo De Embalagem
    FNumSequencia     : Integer;
    FObservacao       : String;
    FDisponivel       : Integer;
    FSituacao         : String;
    FStatus           : Integer;
    FPedidoVolumeId   : Integer;
    procedure SetNumSequencia(const Value: Integer);
    procedure SetObservacao(const Value: String);
    Procedure SetStatus(Const Value: Integer);
  Public
    constructor Create;
    destructor Destroy; override;
    Class Function ClassToJson(Const ObjCaixaEmbalagem
      : TCaixaEmbalagem): String;
    Class Function JsonToClass(Json: String): TCaixaEmbalagem;
    Class Function JsonArrayToClass(pJsonArray: TJsonArray): TCaixaEmbalagem;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property CaixaEmbalagemid: Integer Read FCaixaEmbalagemId
      Write FCaixaEmbalagemId;
    Property VolumeEmbalagem: TVolumeEmbalagem read FVolumeEmbalagem
      write FVolumeEmbalagem;
    Property NumSequencia: Integer read FNumSequencia write SetNumSequencia;
    Property Observacao: String Read FObservacao Write FObservacao;
    Property Disponivel: Integer Read FDisponivel Write FDisponivel;
    Property Situacao: String Read FSituacao Write FSituacao;
    Property Status: Integer read FStatus write SetStatus;
    Property PedidoVolumeId : Integer Read FPedidoVolumeId Write FPedidoVolumeId;
  End;

implementation

{ TEnderecoRua }

class function TCaixaEmbalagem.ClassToJson(Const ObjCaixaEmbalagem
  : TCaixaEmbalagem): String;
begin
  Result := tJson.ObjectToJsonString(ObjCaixaEmbalagem);
end;

class procedure TCaixaEmbalagem.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

constructor TCaixaEmbalagem.Create;
begin
  FVolumeEmbalagem := TVolumeEmbalagem.Create;
  FNumSequencia := 0;
  FObservacao := '';
  FDisponivel := 1;
  FSituacao := '';
  FStatus := 1;
  FPedidoVolumeId := 0;
end;

destructor TCaixaEmbalagem.Destroy;
begin
  if Assigned(FVolumeEmbalagem) then
    FreeAndNil(FVolumeEmbalagem);
  inherited;
end;

class function TCaixaEmbalagem.JsonArrayToClass(pJsonArray: TJsonArray)
  : TCaixaEmbalagem;
begin
  Result := TCaixaEmbalagem.Create;
  Result.CaixaEmbalagemid := pJsonArray.Items[0].GetValue<Integer>
    ('caixaembalagemid');
  Result.NumSequencia := pJsonArray.Items[0].GetValue<Integer>('numsequencia');
  Result.VolumeEmbalagem.EmbalagemId := pJsonArray.Items[0].GetValue<TJsonArray>
    ('VolumeEmbalagem').Items[0].GetValue<Integer>('embalagemid');
  Result.VolumeEmbalagem.Descricao := pJsonArray.Items[0].GetValue<TJsonArray>
    ('VolumeEmbalagem').Items[0].GetValue<String>('descricao');
  Result.VolumeEmbalagem.Identificacao := pJsonArray.Items[0]
    .GetValue<TJsonArray>('VolumeEmbalagem').Items[0].GetValue<String>
    ('identificacao');
  Result.VolumeEmbalagem.Tipo := pJsonArray.Items[0].GetValue<TJsonArray>
    ('VolumeEmbalagem').Items[0].GetValue<String>('tipo');
  Result.VolumeEmbalagem.TipoDescricao := pJsonArray.Items[0]
    .GetValue<TJsonArray>('VolumeEmbalagem').Items[0].GetValue<String>
    ('tipodescricao');
  Result.VolumeEmbalagem.Tipo := pJsonArray.Items[0].GetValue<TJsonArray>
    ('VolumeEmbalagem').Items[0].GetValue<String>('tipo');

  Result.Observacao := pJsonArray.Items[0].GetValue<String>('observacao');
  Result.Disponivel := pJsonArray.Items[0].GetValue<Integer>('disponivel');
  Result.Situacao := pJsonArray.Items[0].GetValue<String>('situacao');
  Result.PedidoVolumeId := pJsonArray.Items[0].GetValue<Integer>('pedidovolumeid');
  Result.Status := pJsonArray.Items[0].GetValue<Integer>('status');
end;

class function TCaixaEmbalagem.JsonToClass(Json: String): TCaixaEmbalagem;
begin
  Result := tJson.JsonToObject<TCaixaEmbalagem>(Json, [joDateFormatUnix])
end;

procedure TCaixaEmbalagem.SetNumSequencia(const Value: Integer);
begin
  FNumSequencia := Value;
end;

procedure TCaixaEmbalagem.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TCaixaEmbalagem.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
