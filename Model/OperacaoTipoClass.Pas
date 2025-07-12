{
  tipomovimentacao.Pas _Natureza da Operacao
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
  Artigo: https://maxiprod.com.br/erp/notas-fiscais/operacoes-fiscais/
}
unit OperacaoTipoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, OperacaoNaturezaClass;

type
  TOperacaoTipo = class
  private
    // FCrud           : TCrud;
    FOperacaoTipoId: Integer;
    FDescricao: String;
    FOperacaoNatureza: TOperacaoNatureza;
    FStatus: Integer;
  Protected
  Public
    constructor Create;
    destructor Destroy; override;
    Class Function ClassToJson(Const ObjOperacaoTipo: TOperacaoTipo): String;
    Class Function JsonToClass(Json: String): TOperacaoTipo;
    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    property OperacaoTipoId: Integer Read FOperacaoTipoId Write FOperacaoTipoId;
    property Descricao: String Read FDescricao Write FDescricao;
    property OperacaoNatureza: TOperacaoNatureza Read FOperacaoNatureza
      Write FOperacaoNatureza;
    property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TOperacaoTipo }

class function TOperacaoTipo.ClassToJson(Const ObjOperacaoTipo
  : TOperacaoTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjOperacaoTipo);
end;

constructor TOperacaoTipo.Create;
Begin
  FOperacaoNatureza := TOperacaoNatureza.Create;
  Limpar;
End;

destructor TOperacaoTipo.Destroy;
begin
  FreeAndNil(FOperacaoNatureza);
  inherited;
end;

class function TOperacaoTipo.JsonToClass(Json: String): TOperacaoTipo;
begin
  Result := TOperacaoTipo.Create;
  Result := tJson.JsonToObject<TOperacaoTipo>(Json, [joDateFormatUnix])
end;

procedure TOperacaoTipo.Limpar;
begin
  FOperacaoTipoId := 0;
  FDescricao := '';
  FStatus := 0;
end;

End.
