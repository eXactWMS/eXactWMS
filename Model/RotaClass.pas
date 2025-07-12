unit RotaClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  Rest.Json.Types,
  System.Json;

type
  Tcrud = (Ins, Upd);

  TRotaPessoa = Class
  Private
    FRotaId: Integer;
    FPessoaId: Integer;
    FCodPessoaERP: Integer;
    FRazao: String;
    FOrdem: Integer;
    FStatus: Integer;
  Public
    constructor Create;
    Procedure Limpar;
    Property RotaId: Integer Read FRotaId Write FRotaId;
    Property PessoaId: Integer Read FPessoaId Write FPessoaId;
    Property CodPessoaERP: Integer Read FCodPessoaERP Write FCodPessoaERP;
    Property Razao: String Read FRazao Write FRazao;
    Property Ordem: Integer Read FOrdem Write FOrdem;
    Property Status: Integer Read FStatus Write FStatus;
  End;

  TRota = class
  private
    FRotaId: Integer;
    FDescricao: String;
    FGoogleMaps: String;
    FLatitude: String;
    FLongitude: String;
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FNParticipante: Integer;
    FStatus: Integer;
    FListPessoa: TObjectList<TRotaPessoa>;
    Function NextCodigo: Integer; // Gerador de Código Automático
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean; // (const ObjRota: TRota)
    Procedure Limpar;
    Class Function ExportaExcel: Boolean;
    Class Function ClassToJson(Const ObjRota: TRota): String;
    Class Function JsonToClass(Json: String): TRota;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property RotaId: Integer Read FRotaId Write FRotaId;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property GoogleMaps: String Read FGoogleMaps Write FGoogleMaps;
    Property Latitude: String Read FLatitude Write FLatitude;
    Property Longitude: String Read FLongitude Write FLongitude;
    Property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    Property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property NParticipante: Integer Read FNParticipante Write FNParticipante;
    Property Status: Integer Read FStatus Write FStatus;
    Property ListPessoa: TObjectList<TRotaPessoa> Read FListPessoa
      Write FListPessoa;
  End;

implementation

{ TRota }

Uses uFuncoes;

class function TRota.ClassToJson(Const ObjRota: TRota): String;
begin
  Result := tJson.ObjectToJsonString(ObjRota);
end;

Class procedure TRota.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TRota.Create;
Begin
  FRotaId := 0;
  FDescricao := '';
  FGoogleMaps := '';
  FLatitude := '';
  FLongitude := '';
  FDtInclusao := 0;
  FHrInclusao := 0;
  FNParticipante := 0;
  FStatus := 0;
  FListPessoa := TObjectList<TRotaPessoa>.Create;
  Limpar;
End;

destructor TRota.Destroy;
begin
  FListPessoa := Nil;
  inherited;
end;

Class function TRota.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryRota);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacionale se o MS-Excel está instalado.');
  End;
end;

class function TRota.JsonToClass(Json: String): TRota;
begin
  Result := TRota.Create;
  Result := tJson.JsonToObject<TRota>(Json)
end;

procedure TRota.Limpar;
begin
  FRotaId := 0;
  FDescricao := '';
  FDtInclusao := 0;
  FHrInclusao := StrToTime('00:00');
  FStatus := 1;
  FNParticipante := 0;
end;

function TRota.NextCodigo: Integer;
Begin
  // Result := DmRhemaWMS.CodGeral('Rota', 'Id', '');
End;

function TRota.Salvar: Boolean; // (const ObjRota: TRota):
Var
  jSonRota: TJsonObject;
  // ListaDeRotas : TJsonArray;
begin
  Result := False;


  // ListaDeRotas.AddElement(jSonRota);

End;

{ TRotaPessoa }

constructor TRotaPessoa.Create;
begin
  Limpar;
end;

procedure TRotaPessoa.Limpar;
begin
  FRotaId := 0;
  FPessoaId := 0;
  FCodPessoaERP := 0;
  FRazao := '';
  FOrdem := 0;
  FStatus := 0;
end;

End.
