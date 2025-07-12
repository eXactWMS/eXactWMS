{
  PerfilClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 25/06/2021
  Projeto: RhemaWMS
}
unit PerfilClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types,
  VolumeEmbalagemClass;

Type

  TPerfil = Class
  private
    FPerfilId: Integer;
    FDescricao: String;
    FStatus: Integer;
    FData: TDate;
    FHora: TTime;
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjPerfil: TPerfil): String;
    Class Function JsonToClass(Json: String): TPerfil;
    Procedure Limpar;
    Property PerfilId: Integer Read FPerfilId Write FPerfilId;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property Status: Integer read FStatus write FStatus;
    Property Data: TDate Read FData Write FData;
    Property Hora: TTime Read FHora Write FHora;
  End;

implementation

{ TEnderecoRua }

class function TPerfil.ClassToJson(Const ObjPerfil: TPerfil): String;
begin
  Result := tJson.ObjectToJsonString(ObjPerfil);
end;

constructor TPerfil.Create;
begin
  Limpar;
end;

Class function TPerfil.JsonToClass(Json: String): TPerfil;
begin
  Result := tJson.JsonToObject<TPerfil>(Json, [joDateFormatUnix])
end;

procedure TPerfil.Limpar;
begin
  FPerfilId := 0;
  FDescricao := '';
  FStatus := 1;
  FData := 0;
  FHora := 0;
end;

end.
