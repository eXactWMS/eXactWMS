{
  Laboratorio.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit PessoaTipoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Rest.Json, System.Json, Rest.Types;

Type

  TPessoaTipo = Class
  private
    FPessoaTipoId: Integer;
    FDescricao: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    Class Function ClassToJson(Const ObjPessoaTipo: TPessoaTipo): String;
    Class Function JsonToClass(Json: String): TPessoaTipo;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property PessoaTipoId: Integer read FPessoaTipoId write SetId;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TPessoaTipo }

class function TPessoaTipo.ClassToJson(Const ObjPessoaTipo
  : TPessoaTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjPessoaTipo);
end;

class procedure TPessoaTipo.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

class function TPessoaTipo.JsonToClass(Json: String): TPessoaTipo;
begin
  Result := tJson.JsonToObject<TPessoaTipo>(Json, [joDateFormatUnix])
end;

procedure TPessoaTipo.Limpar;
begin
  FPessoaTipoId := 0;
  FDescricao := '';
  FStatus := 0;
end;

procedure TPessoaTipo.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TPessoaTipo.SetId(const Value: Integer);
begin
  FPessoaTipoId := Value;
end;

procedure TPessoaTipo.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
