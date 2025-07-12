{
  PedidoVolumeSeparacaoClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 25/06/2021
  Projeto: RhemaWMS
}
unit PedidoVolumeSeparacaoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types,
  VolumeEmbalagemClass;

Type

  TVolumeSeparacao = Class
  private
    FVolumeSeparacaoId: Integer;
    FCaixaEmbalagemId: Integer;
    FOperacao: Integer; // 0-Aberto   1-Finalizado
    FPedidoVolumeId: Integer;
    FEnderecoId: Integer;
    FUsuarioId: Integer;
    FDtInicio: TDate;
    FHrInicio: TTime;
    FDtFinalizacao: TDate;
    FHrFinalizacao: TTime;
    FDivergencia: Integer;
  Public
    Constructor Create;
    Class Function ClassToJson(Const ObjVolumeSeparacao
      : TVolumeSeparacao): String;
    Class Function JsonToClass(Json: String): TVolumeSeparacao;
    Property VolumeSeparacaoId: Integer Read FVolumeSeparacaoId
      Write FVolumeSeparacaoId;
    Property CaixaEmbalagemId: Integer Read FCaixaEmbalagemId
      Write FCaixaEmbalagemId;
    Property Operacao: Integer Read FOperacao Write FOperacao;
    // 0-Aberto   1-Finalizado
    Property PedidoVolumeId: Integer Read FPedidoVolumeId Write FPedidoVolumeId;
    Property EnderecoId: Integer Read FEnderecoId Write FEnderecoId;
    Property UsuarioId: Integer Read FUsuarioId Write FUsuarioId;
    Property DtInicio: TDate Read FDtInicio Write FDtInicio;
    Property HrInicio: TTime Read FHrInicio Write FHrInicio;
    Property DtFinalizacao: TDate Read FDtFinalizacao Write FDtFinalizacao;
    Property HrFinalizacao: TTime Read FHrFinalizacao Write FHrFinalizacao;
    Property Divergencia: Integer Read FDivergencia Write FDivergencia;
  End;

implementation

{ TEnderecoRua }

class function TVolumeSeparacao.ClassToJson(Const ObjVolumeSeparacao
  : TVolumeSeparacao): String;
begin
  Result := tJson.ObjectToJsonString(ObjVolumeSeparacao);
end;

constructor TVolumeSeparacao.Create;
begin
  FVolumeSeparacaoId := 0;
  FCaixaEmbalagemId := 0;
  FOperacao := 0; // 0-Aberto   1-Finalizado
  FPedidoVolumeId := 0;
  FEnderecoId := 0;
  FUsuarioId := 0;
  FDtInicio := Date;
  FHrInicio := Time;
  FDtFinalizacao := 0;
  FHrFinalizacao := 0;
  FDivergencia := 0;
end;

class function TVolumeSeparacao.JsonToClass(Json: String): TVolumeSeparacao;
begin
  Result := tJson.JsonToObject<TVolumeSeparacao>(Json, [joDateFormatUnix])
end;

end.
