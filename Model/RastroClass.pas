{
  RastroClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit RastroClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TRastro = Class
  private
    FRastroId: Integer;
    FDescricao: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetRastroId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    Class Function ClassToJson(Const ObjRastro: TRastro): String;
    Class Function JsonToClass(Json: String): TRastro;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property RastroId: Integer read FRastroId write SetRastroId;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TRastro }

class function TRastro.ClassToJson(Const ObjRastro: TRastro): String;
begin
  Result := tJson.ObjectToJsonString(ObjRastro);
end;

class procedure TRastro.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

class function TRastro.JsonToClass(Json: String): TRastro;
begin
  Result := tJson.JsonToObject<TRastro>(Json, [joDateFormatUnix])
end;

procedure TRastro.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TRastro.SetRastroId(const Value: Integer);
begin
  FRastroId := Value;
end;

procedure TRastro.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
