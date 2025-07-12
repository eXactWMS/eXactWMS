{
  FuncionalidadesClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 25/06/2021
  Projeto: RhemaWMS
}
unit FuncionalidadeClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Rest.Json, System.Json, Rest.Types, VolumeEmbalagemClass;

Type

  TFuncionalidade = Class
  private
    FFuncionalidadeId: Integer;
    FDescricao: String;
    FStatus: Integer;
    FData: TDate;
    FHora: TTime;
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjFuncionalidades
      : TFuncionalidade): String;
    Class Function JsonToClass(Json: String): TFuncionalidade;
    Procedure Limpar;
    Property Funcionalidadeid: Integer Read FFuncionalidadeId
      Write FFuncionalidadeId;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property Status: Integer read FStatus write FStatus;
    Property Data: TDate Read FData Write FData;
    Property Hora: TTime Read FHora Write FHora;
  End;

implementation

{ TEnderecoRua }

class function TFuncionalidade.ClassToJson(Const ObjFuncionalidades
  : TFuncionalidade): String;
begin
  Result := tJson.ObjectToJsonString(ObjFuncionalidades);
end;

constructor TFuncionalidade.Create;
begin
  Limpar;
end;

Class function TFuncionalidade.JsonToClass(Json: String): TFuncionalidade;
begin
  Result := tJson.JsonToObject<TFuncionalidade>(Json)
end;

procedure TFuncionalidade.Limpar;
begin
  FFuncionalidadeId := 0;
  FDescricao := '';
  FStatus := 1;
  FData := 0;
  FHora := 0;
end;

end.
