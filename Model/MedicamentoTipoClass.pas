{
  MedicamentotoTipoClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit MedicamentoTipoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types;

Type

  TMedicamentoTipo = Class
  private
    FId: Integer;
    FMedicamentoTipo: Integer;
    FDescricao: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    constructor Create;
    destructor Destroy; override;
    Class Function ClassToJson(Const ObjMedicamentoTipo
      : TMedicamentoTipo): String;
    Class Function JsonToClass(Json: String): TMedicamentoTipo;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property Id: Integer read FId write SetId;
    Property Descricao: String read FDescricao write SetDescricao;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TMedicamentoTipo }

class function TMedicamentoTipo.ClassToJson(Const ObjMedicamentoTipo
  : TMedicamentoTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjMedicamentoTipo);
end;

class procedure TMedicamentoTipo.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

constructor TMedicamentoTipo.Create;
begin
  Limpar;
end;

destructor TMedicamentoTipo.Destroy;
begin

  inherited;
end;

class function TMedicamentoTipo.JsonToClass(Json: String): TMedicamentoTipo;
begin
  Result := tJson.JsonToObject<TMedicamentoTipo>(Json, [joDateFormatUnix])
end;

procedure TMedicamentoTipo.Limpar;
begin
  FId := 0;
  FMedicamentoTipo := 0;
  FDescricao := '';
  FStatus := 0;
end;

procedure TMedicamentoTipo.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TMedicamentoTipo.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TMedicamentoTipo.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
