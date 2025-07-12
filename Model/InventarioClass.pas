unit InventarioClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  Rest.Json.Types,
  System.Json, FireDAC.Comp.Client;

type
  Tcrud = (Ins, Upd);

  TInventario = class
  private
    finventarioid: Integer;
    fdatacriacao: TDateTime;
    fusuarioidcriacao: Integer;
    fdataliberacao: TDateTime;
    fusuarioidliberacao: Integer;
    fprocessoid: Integer;
    finventariotipo: Integer; // 0-Geográfico 1-Prioritário 2-Ciclíco
    fusuarioidcancelamento: Integer;
    fdatacancelamento: TDateTime;
    fusuarioidfechamento: Integer;
    fdatafechamento : TDateTime;
    fhorafechamento : TTime;
    FUsuarioIdCreate : Integer;
    FUsuarioCreate   : String;
    FUsuarioFechamento : String;
    fmotivo: String;
    ftipoajuste: Integer;
    fstatus: Integer;
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ExportaExcel(PJsonArray: TJsonArray): Boolean;
    Class Function ClassToJson(Const ObjInventario: TInventario): String;
    Class Function JsonToClass(Json: String): TInventario;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property inventarioid: Integer     Read finventarioid Write finventarioid;
    Property datacriacao  : TDateTime  Read fdatacriacao Write fdatacriacao;
    Property dataliberacao: TDateTime  Read fdataliberacao Write fdataliberacao;
    Property usuarioidcriacao: Integer Read fusuarioidcriacao Write fusuarioidcriacao;
    Property UsuarioIdCreate : integer Read FUsuarioIdCreate  Write FUsuarioIdCreate;
    Property UsuarioCreate   : String  Read FUsuarioCreate    Write FUsuarioCreate;
    Property usuarioidliberacao: Integer Read fusuarioidliberacao Write fusuarioidliberacao;
    Property processoid: Integer Read fprocessoid Write fprocessoid;
    Property inventariotipo: Integer Read finventariotipo Write finventariotipo;
    Property usuarioidcancelamento: Integer Read fusuarioidcancelamento Write fusuarioidcancelamento;
    Property datacancelamento: TDateTime Read fdatacancelamento Write fdatacancelamento;
    Property usuarioidfechamento: Integer Read fusuarioidfechamento Write fusuarioidfechamento;
    Property usuariofechamento  : String  Read fusuariofechamento   write fusuariofechamento;
    Property datafechamento: TDateTime Read fdatafechamento Write fdatafechamento;
    Property horafechamento: TTime     Read Fhorafechamento Write fhorafechamento;
    Property motivo: String Read fmotivo Write fmotivo;
    Property tipoajuste: Integer Read ftipoajuste Write ftipoajuste;
    Property status: Integer Read fstatus Write fstatus;
  End;

implementation

{ TInventario }

Uses uFuncoes;

class function TInventario.ClassToJson(Const ObjInventario
  : TInventario): String;
begin
  Result := tJson.ObjectToJsonString(ObjInventario);
end;

Class procedure TInventario.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TInventario.Create;
Begin
  Limpar;
End;

destructor TInventario.Destroy;
begin
  inherited;
end;

Class function TInventario.ExportaExcel(PJsonArray: TJsonArray): Boolean;
Var
  pQry: TFdQuery;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryInventario);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacionale se o MS-Excel está instalado.');
  End;
end;

class function TInventario.JsonToClass(Json: String): TInventario;
begin
  Result := TInventario.Create;
  Result := tJson.JsonToObject<TInventario>(Json, [joDateFormatUnix]);
//    , [joDateIsUTC, joDateFormatISO8601])
end;

procedure TInventario.Limpar;
begin
  finventarioid := 0;
  fdatacriacao := 0;
  fusuarioidcriacao := 0;
  fusuarioidcreate  := 0;
  fusuariocreate    := '';
  fdataliberacao := 0;
  fusuarioidliberacao := 0;
  fprocessoid := 0;
  finventariotipo := 0;
  fusuarioidcancelamento := 0;
  fdatacancelamento := 0;
  fusuarioidfechamento := 0;
  fusuariofechamento   := '';
  fdatafechamento := 0;
  fhorafechamento := 0;
  fmotivo := '';
  ftipoajuste := 0;
  fstatus := 0;
end;

End.
