{
  ProdutoTipoClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit ProdutoTipoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TProdutoTipo = Class
  private
    FId: Integer;
    FSigla: String;
    FDescricao: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    Class Function ClassToJson(Const ObjProdutoTipo: TProdutoTipo): String;
    Class Function JsonToClass(Json: String): TProdutoTipo;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property Id: Integer read FId write SetId;
    Property Sigla: String Read FSigla Write FSigla;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TProdutoTipo }

class function TProdutoTipo.ClassToJson(Const ObjProdutoTipo
  : TProdutoTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjProdutoTipo);
end;

class procedure TProdutoTipo.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

class function TProdutoTipo.JsonToClass(Json: String): TProdutoTipo;
begin
  Result := tJson.JsonToObject<TProdutoTipo>(Json, [joDateFormatUnix])
end;

procedure TProdutoTipo.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProdutoTipo.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TProdutoTipo.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
