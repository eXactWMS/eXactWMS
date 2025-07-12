{
   ProdutoControleClass.Pas
   Criado por Genilson S Soares (RhemaSys) em 09/09/2020
   Projeto: RhemaWMS
}
unit ProdutoControleClass;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TProdutoControle = Class
  private
    FIdControle      : Integer;
    FDescricao       : String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetIdControle(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    Class Function ClassToJson(Const ObjProdutoControle : TProdutoControle) : String;
    Class Function JsonToClass(jSon : String) : TProdutoControle;
    Class Procedure ConfigSizeField(Tabela : String; Sender : TObject);
    Property IdControle : Integer read FIdControle write SetIdControle;
    Property Descricao : String   read FDescricao  write SetDescricao;
    Property Status : Integer     read FStatus     write SetStatus;
  End;

implementation

{ TProdutoControle }

class function TProdutoControle.ClassToJson(Const ObjProdutoControle : TProdutoControle): String;
begin
  Result := tJson.ObjectToJsonString(ObjProdutoControle);
end;

class procedure TProdutoControle.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

class function TProdutoControle.JsonToClass(jSon: String): TProdutoControle;
begin
  Result := tJson.JsonToObject<TProdutoControle>(jSon)
end;

procedure TProdutoControle.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProdutoControle.SetIdControle(const Value: Integer);
begin
  FIdControle := Value;
end;

procedure TProdutoControle.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
