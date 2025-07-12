{
  UnidadeClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit EnderecamentoRuaClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TEnderecoRua = Class
  private
    FRuaId: Integer;
    FDescricao: String;
    FLado: String;
    FOrdem: Integer;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetRuaId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
    procedure SetLado(const Value: String);
    Procedure SetOrdem(Const Value: Integer);
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjEnderecoRua: TEnderecoRua): String;
    Class Function JsonToClass(Json: String): TEnderecoRua;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property RuaId: Integer read FRuaId write SetRuaId;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Lado: String read FLado Write SetLado;
    Property Ordem: Integer Read FOrdem Write SetOrdem;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TEnderecoRua }

class function TEnderecoRua.ClassToJson(Const ObjEnderecoRua
  : TEnderecoRua): String;
begin
  Result := tJson.ObjectToJsonString(ObjEnderecoRua);
end;

class procedure TEnderecoRua.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TEnderecoRua.Create;
begin
  FRuaId := 0;
  FDescricao := '';
  FLado := 'U';
  FOrdem := 1;
  FStatus := 1;
end;

class function TEnderecoRua.JsonToClass(Json: String): TEnderecoRua;
begin
  Result := tJson.JsonToObject<TEnderecoRua>(Json, [joDateFormatUnix])
end;

procedure TEnderecoRua.Limpar;
begin
  FRuaId := 0;
  FDescricao := '';
  FLado := 'U';
  FOrdem := 0;
  FStatus := 0;
end;

procedure TEnderecoRua.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TEnderecoRua.SetRuaId(const Value: Integer);
begin
  FRuaId := Value;
end;

procedure TEnderecoRua.SetLado(const Value: String);
begin
  FLado := Value;
end;

procedure TEnderecoRua.SetOrdem(const Value: Integer);
begin
  FOrdem := Value;
end;

procedure TEnderecoRua.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
