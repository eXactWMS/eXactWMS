unit VeiculoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  Rest.Json.Types,
  System.Json;

type
  Tcrud = (Ins, Upd);

  TVeiculo = class
  private
    FVeiculoId: Integer;
    FProcedencia: String;
    FProcedenciaDescr: String;
    FPlaca: String;
    FTipo: String;
    FMarca: String;
    FModelo: String;
    FAnoFabricacaoModelo: String;
    FChassiTipo: String;
    // 1 Monobloco - 2 Monobloco Estrutura   3 Chassi Tunel Central   4 Chassi de Longarina   5 Subchassi
    FChassiTipoDescr: String;
    FChassiNumero: String;
    FCarroceriaTipo: String;
    FCarroceriaDescr: String;
    FRenavam: String;
    FMotorNumero: String;
    FCor: String;
    FCombustivelTipo: String;
    FCombustivel: String;
    FTaraKg: Double;
    FCapacidadeKg: Double;
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FAproveitamento: Double;
    FVolume: Double;
    FRastreado: Integer;
    FSegurado: Integer;
    FTransportadoraId: Integer; // Pesssoa, PessoaTipoId = 3
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FStatus: Integer;
    Procedure SetCombustivelTipo(Const Value: String);
    procedure SetProcedencia(const Value: String);
    Procedure SetCarroceriaTipo(Const Value: String);
    procedure SetAltura(const Value: Double);
    procedure SetLargura(const Value: Double);
    procedure SetComprimento(const Value: Double);
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean; // (const ObjVeiculo: TVeiculo)
    Class Function ExportaExcel: Boolean;
    Class Function ClassToJson(Const ObjVeiculo: TVeiculo): String;
    Class Function JsonToClass(Json: String): TVeiculo;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure SetVolume;
    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    Property VeiculoId: Integer Read FVeiculoId Write FVeiculoId;
    Property Procedencia: String Read FProcedencia Write SetProcedencia;
    Property ProcedenciaDescr: String Read FProcedenciaDescr
      Write FProcedenciaDescr;
    Property Placa: String Read FPlaca Write FPlaca;
    Property Tipo: String Read FTipo Write FTipo;
    Property Marca: String Read FMarca Write FMarca;
    Property Modelo: String Read FModelo Write FModelo;
    Property AnoFabricacaoModelo: String Read FAnoFabricacaoModelo
      Write FAnoFabricacaoModelo;
    Property ChassiTipo: String Read FChassiTipo Write FChassiTipo;
    // 1 Monobloco - 2 Monobloco Estrutura   3 Chassi Tunel Central   4 Chassi de Longarina   5 Subchassi
    Property ChassiTipoDescr: String Read FChassiTipoDescr
      Write FChassiTipoDescr;
    Property ChassiNumero: String Read FChassiNumero Write FChassiNumero;
    Property CarroceriaTipo: String Read FCarroceriaTipo
      Write SetCarroceriaTipo;
    Property CarroceriaDescr: String Read FCarroceriaDescr
      Write FCarroceriaDescr;
    Property Renavam: String Read FRenavam Write FRenavam;
    Property MotorNumero: String Read FMotorNumero Write FMotorNumero;
    Property Cor: String Read FCor Write FCor;
    Property CombustivelTipo: String Read FCombustivelTipo
      Write SetCombustivelTipo;
    Property Combustivel: String Read FCombustivel Write FCombustivel;
    Property TaraKg: Double Read FTaraKg Write FTaraKg;
    Property CapacidadeKg: Double Read FCapacidadeKg Write FCapacidadeKg;
    Property Altura: Double Read FAltura Write SetAltura;
    Property Largura: Double Read FLargura Write SetLargura;
    Property Comprimento: Double Read FComprimento Write FComprimento;
    Property Volume: Double Read FVolume Write FVolume;
    Property Aproveitamento: Double Read FAproveitamento Write FAproveitamento;
    Property Rastreado: Integer Read FRastreado Write FRastreado;
    Property Segurado: Integer Read FSegurado Write FSegurado;
    Property TransportadoraId: Integer Read FTransportadoraId
      Write FTransportadoraId;
    Property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    Property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property Status: Integer Read FStatus Write FStatus;
  End;

implementation

{ TVeiculo }

Uses uFuncoes;

class function TVeiculo.ClassToJson(Const ObjVeiculo: TVeiculo): String;
begin
  Result := tJson.ObjectToJsonString(ObjVeiculo);
end;

Class procedure TVeiculo.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TVeiculo.Create;
Begin
  Limpar;
End;

destructor TVeiculo.Destroy;
begin
  inherited;
end;

Class function TVeiculo.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryVeiculo);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacionale se o MS-Excel está instalado.');
  End;
end;

class function TVeiculo.JsonToClass(Json: String): TVeiculo;
begin
  Result := TVeiculo.Create;
  Result := tJson.JsonToObject<TVeiculo>(Json, [joDateFormatUnix]); //,[joDateIsUTC, joDateFormatISO8601])
end;

procedure TVeiculo.Limpar;
begin
  FVeiculoId := 0;
  FProcedencia := '';
  FProcedenciaDescr := '';
  FPlaca := '';
  FTipo := '';
  FMarca := '';
  FModelo := '';
  FAnoFabricacaoModelo := '';
  FChassiTipo := '';
  // 1 Monobloco - 2 Monobloco Estrutura   3 Chassi Tunel Central   4 Chassi de Longarina   5 Subchassi
  FChassiTipoDescr := '';
  FChassiNumero := '';
  FCarroceriaTipo := '';
  FCarroceriaDescr := '';
  FRenavam := '';
  FMotorNumero := '';
  FCor := '';
  FCombustivelTipo := '';
  FCombustivel := '';
  FTaraKg := 0;
  FCapacidadeKg := 0;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FVolume := 0;
  FAproveitamento := 0;
  FRastreado := 0;
  FSegurado := 0;
  FTransportadoraId := 0;
  FDtInclusao := 0;
  FHrInclusao := 0;
  FStatus := 0;
end;

function TVeiculo.Salvar: Boolean; // (const ObjVeiculo: TVeiculo):
begin
  Result := False;
End;

procedure TVeiculo.SetAltura(const Value: Double);
begin
  FAltura := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TVeiculo.SetComprimento(const Value: Double);
begin
  FComprimento := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TVeiculo.SetLargura(const Value: Double);
begin
  FLargura := Value;
  FVolume := (FAltura * FLargura * FComprimento);
end;

procedure TVeiculo.SetCarroceriaTipo(const Value: String);
begin
  FCarroceriaTipo := Value;
  FCarroceriaDescr := 'Definir aqui Class';
end;

procedure TVeiculo.SetCombustivelTipo(const Value: String);
begin
  FCombustivelTipo := Value;
  if Value = 'G' then
    FCombustivel := 'Gasolina'
  Else If Value = 'E' then
    FCombustivel := 'Etanol'
  Else If Value = 'D' then
    FCombustivel := 'Diesel'
  Else If Value = 'F' then
    FCombustivel := 'Flex Gasolina/Etanol';
end;

procedure TVeiculo.SetProcedencia(const Value: String);
begin
  FProcedencia := Value;
  if Value = 'N' then
    FProcedenciaDescr := 'Nacional'
  Else If Value = 'I' then
    FProcedenciaDescr := 'Importado'
  Else If Value = 'N' then
    FProcedenciaDescr := 'Não Informado'
end;

procedure TVeiculo.SetVolume;
begin
  FVolume := (FAltura) * (FLargura) * (FComprimento);
  FVolume := FVolume * (FAproveitamento / 100);
  FVolume := FVolume / 1000000;
end;

End.
