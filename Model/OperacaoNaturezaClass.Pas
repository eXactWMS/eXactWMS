{
  tipooperacao.Pas
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}
unit OperacaoNaturezaClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json;

type
  TOperacaoNatureza = class
  private
    // FCrud            : TCrud;
    FOperacaoNaturezaId: Integer;
    FDescricao: String;
    FTipo: String;
  Protected
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjOperacaoNatureza
      : TOperacaoNatureza): String;
    Class Function JsonToClass(Json: String): TOperacaoNatureza;
    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    property OperacaoNaturezaId: Integer Read FOperacaoNaturezaId
      Write FOperacaoNaturezaId;
    property Descricao: String Read FDescricao Write FDescricao;
    property Tipo: String Read FTipo Write FTipo;
  End;

implementation

{ Ttipooperacao }

class function TOperacaoNatureza.ClassToJson(Const ObjOperacaoNatureza
  : TOperacaoNatureza): String;
begin
  Result := tJson.ObjectToJsonString(ObjOperacaoNatureza);
end;

constructor TOperacaoNatureza.Create;
Begin
  Limpar;
End;

class function TOperacaoNatureza.JsonToClass(Json: String): TOperacaoNatureza;
begin
  Result := TOperacaoNatureza.Create;
  Result := tJson.JsonToObject<TOperacaoNatureza>(Json, [joDateFormatUnix])
end;

procedure TOperacaoNatureza.Limpar;
begin
  FOperacaoNaturezaId := 0;
  FDescricao := '';
  FTipo := ''; // <E>ntrada  <S>aída
end;

End.
