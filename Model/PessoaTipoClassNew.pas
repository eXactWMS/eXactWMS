{
   Laboratorio.Pas
   Criado por Genilson S Soares (RhemaSys) em 09/09/2020
   Projeto: RhemaWMS
}
unit PessoaTipoClass;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     Rest.Json, System.Json, Rest.Types;

Type

  TPessoaTipo = Class
  private
    FId: Integer;
    FPessoaTipo: Integer;
    FDescricao: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetPessoaTipo(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjPessoaTipo : TPessoaTipo) : String;
    Class Function JsonToClass(jSon : String) : TPessoaTipo;
    Class Procedure ConfigSizeField(Tabela : String; Sender : TObject);
    Property Id : Integer         read FId         write SetId;
    Property PessoaTipo : Integer read FPessoaTipo write SetPessoaTipo;
    Property Descricao : String   read FDescricao  write SetDescricao;
    Property Status : Integer     read FStatus     write SetStatus;
  End;

implementation

{ TPessoaTipo }

class function TPessoaTipo.ClassToJson(Const ObjPessoaTipo : TPessoaTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjPessoaTipo);
end;

class procedure TPessoaTipo.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TPessoaTipo.Create;
begin
  FId         := 0;
  FPessoaTipo := 0;
  FDescricao  := '';
  FStatus     := 0;
end;

class function TPessoaTipo.JsonToClass(jSon: String): TPessoaTipo;
begin
  Result := tJson.JsonToObject<TPessoaTipo>(jSon)
end;

procedure TPessoaTipo.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TPessoaTipo.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TPessoaTipo.SetPessoaTipo(const Value: Integer);
begin
  FPessoaTipo := Value;
end;

procedure TPessoaTipo.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
