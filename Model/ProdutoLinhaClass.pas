{
  ProdutoLinhaClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit ProdutoLinhaClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TProdutoLinha = Class
  private
    FId: Integer;
    FSigla: String;
    FDescricao: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    Class Function ClassToJson(Const ObjProdutoLinha: TProdutoLinha): String;
    Class Function JsonToClass(Json: String): TProdutoLinha;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property Id: Integer read FId write SetId;
    Property Sigla: String Read FSigla Write FSigla;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TProdutoLinha }

class function TProdutoLinha.ClassToJson(Const ObjProdutoLinha
  : TProdutoLinha): String;
begin
  Result := tJson.ObjectToJsonString(ObjProdutoLinha);
end;

class procedure TProdutoLinha.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

class function TProdutoLinha.JsonToClass(Json: String): TProdutoLinha;
begin
  Result := tJson.JsonToObject<TProdutoLinha>(Json)
end;

procedure TProdutoLinha.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProdutoLinha.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TProdutoLinha.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
