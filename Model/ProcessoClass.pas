unit ProcessoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, PessoaTipoClass, Rest.Json.Types;

type
  TCrud = (Ins, Upd);

  TProcesso = class
  private
    [JSONMarshalledAttribute(False)]
    FCrud: TCrud;
    [JSONNameAttribute('codigo')]
    FId: Int64;
    FDescricao: String;
    FProcesso: String;
    [JSONBooleanAttribute]
    FStatus: Integer;
  Protected
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjProcesso: TProcesso): String;
    Class Function JsonToClass(Json: String): TProcesso;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    property CRUD: TCrud Read FCrud Write FCrud;
    property Id: Int64 Read FId Write FId;
    property Descricao: String Read FDescricao Write FDescricao;
    property Processo: String Read FProcesso Write FProcesso;
    Property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TProcesso }

class function TProcesso.ClassToJson(Const ObjProcesso: TProcesso): String;
begin
  Result := tJson.ObjectToJsonString(ObjProcesso);
end;

class procedure TProcesso.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TProcesso.Create;
Begin
  FId := 0;
  FDescricao := '';
  FProcesso := '';
  FStatus := 1;
End;

class function TProcesso.JsonToClass(Json: String): TProcesso;
begin
  Result := TProcesso.Create;
  Result := tJson.JsonToObject<TProcesso>(Json, [joDateFormatUnix])
end;

End.
