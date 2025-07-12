unit RegistroTipoProcessoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, PessoaTipoClass, Rest.Json.Types;

type
  TCrud = (Ins, Upd);

  TRegistroTipoProcesso = class
  private
    [JSONMarshalledAttribute(False)]
    FCrud: TCrud;
    [JSONNameAttribute('codigo')]
    FId: Int64;
    FProcessoId: Int64;
    FRegistroTipoId: Int64;
    [JSONBooleanAttribute]
    FStatus: Integer;
  Protected
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjRegistroTipoProcesso
      : TRegistroTipoProcesso): String;
    Class Function JsonToClass(Json: String): TRegistroTipoProcesso;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    property CRUD: TCrud Read FCrud Write FCrud;
    property Id: Int64 Read FId Write FId;
    property ProcessoId: Int64 Read FProcessoId Write FProcessoId;
    property RegistroTipoId: Int64 Read FRegistroTipoId Write FRegistroTipoId;
    Property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TRegistroTipoProcesso }

class function TRegistroTipoProcesso.ClassToJson(Const ObjRegistroTipoProcesso
  : TRegistroTipoProcesso): String;
begin
  Result := tJson.ObjectToJsonString(ObjRegistroTipoProcesso);
end;

class procedure TRegistroTipoProcesso.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

constructor TRegistroTipoProcesso.Create;
Begin
  FId := 0;
  FProcessoId := 0;
  FRegistroTipoId := 0;
  FStatus := 1;
End;

class function TRegistroTipoProcesso.JsonToClass(Json: String)
  : TRegistroTipoProcesso;
begin
  Result := TRegistroTipoProcesso.Create;
  Result := tJson.JsonToObject<TRegistroTipoProcesso>(Json)
end;

End.
