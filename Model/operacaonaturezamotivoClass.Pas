{
  operacaonaturezamotivo.Pas
  Criado por Genilson S Soares (Rhemasys Soluções) em 28/03/2022
  Projeto: eXactWMS
  Direitos Reservados.
}
unit operacaonaturezamotivoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Rest.Json, System.Json, Rest.Types;

type
  Toperacaonaturezamotivo = class
  private
    // FCrud                : TCrud;
    Fmotivoid: Integer;
    Fdescricao: String;
    Foperacaonaturezaid: Integer;
    Fstatus: Integer;
  Protected
  Public
    constructor Create;
    Class Function ClassToJson(Const Objoperacaonaturezamotivo
      : Toperacaonaturezamotivo): String;
    Class Function JsonToClass(Json: String): Toperacaonaturezamotivo;
    Class procedure ConfigSizeField(Tabela: String; Sender: TObject);
    // property CRUD                 : TCRUD    Read FCrud                Write FCRUD;
    property motivoid: Integer Read Fmotivoid Write Fmotivoid;
    property descricao: String Read Fdescricao Write Fdescricao;
    property operacaonaturezaid: Integer Read Foperacaonaturezaid
      Write Foperacaonaturezaid;
    property status: Integer Read Fstatus Write Fstatus;
  End;

implementation

{ Toperacaonaturezamotivo }

constructor Toperacaonaturezamotivo.Create;
Begin
  Fmotivoid := 0;
  Fdescricao := '';
  Foperacaonaturezaid := 0;
  Fstatus := 0;
End;

class procedure Toperacaonaturezamotivo.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

class function Toperacaonaturezamotivo.ClassToJson
  (Const Objoperacaonaturezamotivo: Toperacaonaturezamotivo): String;
begin
  Result := tJson.ObjectToJsonString(Objoperacaonaturezamotivo);
end;

class function Toperacaonaturezamotivo.JsonToClass(Json: String)
  : Toperacaonaturezamotivo;
begin
  Result := Toperacaonaturezamotivo.Create;
  Result := tJson.JsonToObject<Toperacaonaturezamotivo>(Json)
end;

End.
