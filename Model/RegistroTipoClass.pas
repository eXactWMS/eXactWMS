unit RegistroTipoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, PessoaTipoClass, Rest.Json.Types;

type
  TCrud = (Ins, Upd);

  TRegistroTipo = class
  private
    [JSONMarshalledAttribute(False)]
    FCrud: TCrud;
    [JSONNameAttribute('codigo')]
    FId: Int64;
    FDescricao: String;
    FRegistroTipo: Integer;
    [JSONBooleanAttribute]
    FStatus: Integer;
  Protected
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjRegistroTipo: TRegistroTipo): String;
    Class Function JsonToClass(Json: String): TRegistroTipo;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    property CRUD: TCrud Read FCrud Write FCrud;
    property Id: Int64 Read FId Write FId;
    property Descricao: String Read FDescricao Write FDescricao;
    property RegistroTipo: Integer Read FRegistroTipo Write FRegistroTipo;
    Property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TRegistroTipo }

class function TRegistroTipo.ClassToJson(Const ObjRegistroTipo
  : TRegistroTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjRegistroTipo);
end;

class procedure TRegistroTipo.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TRegistroTipo.Create;
Begin
  FId := 0;
  FDescricao := '';
  FRegistroTipo := 0;
End;

class function TRegistroTipo.JsonToClass(Json: String): TRegistroTipo;
begin
  Result := TRegistroTipo.Create;
  Result := tJson.JsonToObject<TRegistroTipo>(Json)
end;

End.
