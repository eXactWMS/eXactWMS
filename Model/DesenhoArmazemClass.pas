{
  DesenhoArmazemClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit DesenhoArmazemClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TDesenhoArmazem = Class
  private
    FId: Integer;
    FDesenhoArmazem: Integer;
    FDescricao: String;
    FStatus: Integer;
    FSigla: String;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    Class Function ClassToJson(Const ObjDesenhoArmazem
      : TDesenhoArmazem): String;
    Class Function JsonToClass(Json: String): TDesenhoArmazem;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property Id: Integer read FId write SetId;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TDesenhoArmazem }

class function TDesenhoArmazem.ClassToJson(Const ObjDesenhoArmazem
  : TDesenhoArmazem): String;
begin
  Result := tJson.ObjectToJsonString(ObjDesenhoArmazem);
end;

class procedure TDesenhoArmazem.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

class function TDesenhoArmazem.JsonToClass(Json: String): TDesenhoArmazem;
begin
  Result := tJson.JsonToObject<TDesenhoArmazem>(Json, [joDateFormatUnix])
end;

procedure TDesenhoArmazem.Limpar;
begin
  FId := 0;
  FDesenhoArmazem := 0;
  FDescricao := '';
  FStatus := 0;
  FSigla := '';
end;

procedure TDesenhoArmazem.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TDesenhoArmazem.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TDesenhoArmazem.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
