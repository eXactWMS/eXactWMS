{
  TopicosClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 25/06/2021
  Projeto: RhemaWMS
}
unit TopicosClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types,
  VolumeEmbalagemClass;

Type

  TTopicos = Class
  private
    FTopicoId: Integer;
    FDescricao: String;
    FStatus: Integer;
    FData: TDate;
    FHora: TTime;
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjTopicos: TTopicos): String;
    Class Function JsonToClass(Json: String): TTopicos;
    Procedure Limpar;
    Property Topicoid: Integer Read FTopicoId Write FTopicoId;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property Status: Integer read FStatus write FStatus;
    Property Data: TDate Read FData Write FData;
    Property Hora: TTime Read FHora Write FHora;
  End;

implementation

{ TEnderecoRua }

class function TTopicos.ClassToJson(Const ObjTopicos: TTopicos): String;
begin
  Result := tJson.ObjectToJsonString(ObjTopicos);
end;

constructor TTopicos.Create;
begin
  Limpar;
end;

Class function TTopicos.JsonToClass(Json: String): TTopicos;
begin
  Result := tJson.JsonToObject<TTopicos>(Json)
end;

procedure TTopicos.Limpar;
begin
  FTopicoId := 0;
  FDescricao := '';
  FStatus := 1;
  FData := 0;
  FHora := 0;
end;

end.
