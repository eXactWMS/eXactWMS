{
  UnidadeClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit UnidadeClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TUnidade = Class
  private
    FId: Integer;
    FUnidade: Integer;
    FDescricao: String;
    FStatus: Integer;
    FSigla: String;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
    procedure SetSigla(const Value: String);
  Public
    Class Function ClassToJson(Const ObjUnidade: TUnidade): String;
    Class Function JsonToClass(Json: String): TUnidade;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property Id: Integer read FId write SetId;
    Property Sigla: String read FSigla Write SetSigla;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TUnidade }

class function TUnidade.ClassToJson(Const ObjUnidade: TUnidade): String;
begin
  Result := tJson.ObjectToJsonString(ObjUnidade);
end;

class procedure TUnidade.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

class function TUnidade.JsonToClass(Json: String): TUnidade;
begin
  Result := tJson.JsonToObject<TUnidade>(Json, [joDateFormatUnix])
end;

procedure TUnidade.Limpar;
begin
  FId := 0;
  FUnidade := 0;
  FDescricao := '';
  FStatus := 0;
  FSigla := '';
end;

procedure TUnidade.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TUnidade.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TUnidade.SetSigla(const Value: String);
begin
  FSigla := Value;
end;

procedure TUnidade.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
