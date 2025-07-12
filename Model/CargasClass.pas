unit CargasClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils,
  Rest.Json, Rest.Json.Types, System.Json, PessoaClass, VeiculoClass;

type
  Tcrud = (Ins, Upd);

  TCargas = class
  private
    Fcargaid: integer;
    Frotaid: integer;
    Ftransportadora: TPessoa;
    Fveiculo: TVeiculo;
    Fmotorista: TPessoa;
    Fdtinclusao: TDate;
    Fhrinclusao: TTime;
    Fusuarioid: integer;
    Fstatus: integer;
    FProcessoId: integer;
    FEmConferencia: integer;
    FCarregando: integer;
    FStatusOper: integer;
    FConferencia : Integer;
    // FPedidos           : TJsonArray;
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean; // (const ObjCarga: TCarga)
    Class Function ExportaExcel: Boolean;
    Class Function ClassToJson(Const ObjCarga: TCargas): String;
    Class Function JsonToClass(Json: String): TCargas;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    property cargaid: integer Read Fcargaid Write Fcargaid;
    property rotaid: integer Read Frotaid Write Frotaid;
    property transportadora: TPessoa Read Ftransportadora Write Ftransportadora;
    property veiculo: TVeiculo Read Fveiculo Write Fveiculo;
    property motorista: TPessoa Read Fmotorista Write Fmotorista;
    property dtinclusao: TDate Read Fdtinclusao Write Fdtinclusao;
    property hrinclusao: TTime Read Fhrinclusao Write Fhrinclusao;
    property usuarioid: integer Read Fusuarioid Write Fusuarioid;
    property status: integer Read Fstatus Write Fstatus;
    Property ProcessoId: integer Read FProcessoId Write FProcessoId;
    Property EmConferencia: integer Read FEmConferencia Write FEmConferencia;
    Property Carregando: integer Read FCarregando Write FCarregando;
    Property StatusOper: integer Read FStatusOper Write FStatusOper;
    Property Conferencia : Integer Read FConferencia Write FConferencia;
    // Property Pedidos        : TJsonArray Read FPedidos        Write FPedidos;
  End;

implementation

{ TCarga }

Uses uFuncoes;

class function TCargas.ClassToJson(Const ObjCarga: TCargas): String;
begin
  Result := tJson.ObjectToJsonString(ObjCarga);
end;

Class procedure TCargas.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TCargas.Create;
Begin
  Limpar;
End;

destructor TCargas.Destroy;
begin
  Ftransportadora := Nil;
  Fveiculo := Nil;
  Fmotorista := Nil;
  // FPedidos        := Nil;
  inherited;
end;

Class function TCargas.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryCarga);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacionale se o MS-Excel está instalado.');
  End;
end;

class function TCargas.JsonToClass(Json: String): TCargas;
var
  JSonValue: TJSonValue;
begin
  Result := TCargas.Create;
  // JsonValue := TJSonObject.ParseJSONValue(st);
  // JsonValue.GetValue<string>('data.results[0].veiculo');  //Busca um JsonObject dentro de um array
  // https://showdelphi.com.br/como-fazer-um-parse-a-json-string-in-delphi/
  Result := tJson.JsonToObject<TCargas>(Json, [joDateFormatUnix]) //,[joDateIsUTC, joDateFormatISO8601])
  // JsonValue := Free;
end;

procedure TCargas.Limpar;
begin
  Fcargaid := 0;
  Frotaid := 0;
  if Assigned(Ftransportadora) then
    Ftransportadora.Limpar // := Nil;
  Else
    Ftransportadora := TPessoa.Create;
  if Assigned(Fveiculo) then
    Fveiculo.Limpar // := Nil;
  Else
    Fveiculo := TVeiculo.Create;
  if Assigned(Fmotorista) then
    Fmotorista.Limpar // := Nil;
  Else
    Fmotorista   := TPessoa.Create;
  Fdtinclusao    := 0;
  Fhrinclusao    := 0;
  Fusuarioid     := 0;
  Fstatus        := 0;
  FProcessoId    := 0;
  FEmConferencia := 0;
  FCarregando    := 0;
  FStatusOper    := 0;
  FConferencia   := 0;
  // if Assigned(FPedidos) then
  // FPedidos := nil;
  // FPedidos        := TJsonArray.Create;
end;

function TCargas.Salvar: Boolean; // (const ObjCarga: TCarga):
begin
  Result := False;
End;

End.
