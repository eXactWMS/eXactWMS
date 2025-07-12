{
  VeiculoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.VeiculoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.Types, System.JSON, REST.JSON, System.JSON.Types,
  System.Generics.Collections, VeiculoClass, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TVeiculoDao = class(TBasicDao)
  private

    FObjVeiculo: TVeiculo;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(Const ObjVeiculo: TVeiculo): TjSonArray;
    // (pVeiculoId : Integer; pDescricao : String; pStatus : Integer ) : TjSonArray;
    function Get(pVeiculoId: Integer; pPlaca: String;
      pTransportadoraId: Integer): TjSonArray;
    function Get4D(const AParams: TDictionary<string, string>): TjSonObject;
    Function Delete(pVeiculoId: Integer): Boolean;
    Property ObjVeiculo: TVeiculo Read FObjVeiculo Write FObjVeiculo;
  end;

implementation

uses uSistemaControl, Constants, System.Math;

{ TClienteDao }

constructor TVeiculoDao.Create;
begin
  ObjVeiculo := TVeiculo.Create;
  inherited;
end;

function TVeiculoDao.Delete(pVeiculoId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Veiculos where VeiculoId = ' + pVeiculoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Veiculo - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TVeiculoDao.Destroy;
begin

  ObjVeiculo.Free;
  inherited;
end;

function TVeiculoDao.Get(pVeiculoId: Integer; pPlaca: String;
  pTransportadoraId: Integer): TjSonArray;
var
  VQry: TFDQuery;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetVeiculo);
    FConexao.Query.ParamByName('pVeiculoId').Value := pVeiculoId;
    FConexao.Query.ParamByName('pPlaca').Value := pPlaca;
    FConexao.Query.ParamByName('pTransportadoraId').Value := pTransportadoraId;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TjSonObject.Create(tJsonPair.Create('Erro',
        'Não há dados para gerar consulta.')));
    End
    else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Erro: ' + E.Message);
    End;
  end;
end;

function TVeiculoDao.Get4D(const AParams: TDictionary<string, string>)
  : TjSonObject;
Var
  QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TjSonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.SQL.Add(TuEvolutConst.SqlGetVeiculoPesquisa + ' where 1=1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add('Select Count(VeiculoId) cReg From Veiculos V');
  QryRecordCount.SQL.Add
    ('Left Join Pessoa P On P.PessoaId = V.TransportadoraId');
  QryRecordCount.SQL.Add('Where 1=1');
  if AParams.ContainsKey('id') then
  begin
    QryPesquisa.SQL.Add('and V.VeiculoId = :id');
    QryPesquisa.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
    QryRecordCount.SQL.Add('and V.VeiculoId = :id');
    QryRecordCount.ParamByName('Id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;
  if AParams.ContainsKey('transportadoraid') then
  begin
    QryPesquisa.SQL.Add('and P.PessoaId = :pTransportadoraId');
    QryPesquisa.ParamByName('ptransportadoraid').AsInteger :=
      AParams.Items['transportadoraid'].ToInteger;
    QryRecordCount.SQL.Add('and P.PessoaId = :pTransportadoraId');
    QryRecordCount.ParamByName('ptransportadoraid').AsInteger :=
      AParams.Items['transportadoraid'].ToInteger;
  end;
  if AParams.ContainsKey('transportadora') then
  begin
    QryPesquisa.SQL.Add
      ('and (P.Razao Like :pRazao or P.Fantasia like :pFantasia)');
    QryPesquisa.ParamByName('pRazao').AsString := '%' + AParams.Items
      ['transportadora'] + '%';
    QryPesquisa.ParamByName('pFantasia').AsString := '%' + AParams.Items
      ['transportadora'] + '%';
    QryRecordCount.SQL.Add
      ('and (P.Razao Like :pRazao or P.Fantasia like :pFantasia)');
    QryRecordCount.ParamByName('pRazao').AsString := '%' + AParams.Items
      ['transportadora'] + '%';
    QryRecordCount.ParamByName('pFantasia').AsString := '%' + AParams.Items
      ['transportadora'] + '%';
  end;
  if AParams.ContainsKey('limit') then
  begin
    QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    QryPesquisa.FetchOptions.RowsetSize :=
      StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    QryPesquisa.FetchOptions.RecsSkip :=
      StrToIntDef(AParams.Items['offset'], 0);
  QryPesquisa.SQL.Add('order by V.Veiculoid');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.ToJSONArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJSONNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));

end;

function TVeiculoDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TVeiculoDao.InsertUpdate(Const ObjVeiculo: TVeiculo): TjSonArray;
// (pVeiculoId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
var
  vSql: String;
  Function MontaValor(pValor: Single = 0; pDecimal: Integer = 2): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, (pDecimal * -1))); // -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;

begin
  try
    if ObjVeiculo.VeiculoId = 0 then
      vSql := 'Insert Into Veiculos (Placa, Procedencia, Tipo, Marca, Modelo, AnoFabricacaoModelo, ChassiTipo,	'
        + sLineBreak +
        '                     ChassiNumero, CarroceriaTipo, Renavam, MotorNumero, Cor, Combustivel, TaraKg, '
        + sLineBreak +
        '                     CapacidadeKg, Altura, Largura, Comprimento, Aproveitamento, Rastreado, Segurado, TransportadoraId, Status'
        + sLineBreak + ') Values (' + sLineBreak + QuotedStr(ObjVeiculo.Placa) +
        ', ' + QuotedStr(ObjVeiculo.Procedencia) + ', ' +
        QuotedStr(ObjVeiculo.Tipo) + ', ' + QuotedStr(ObjVeiculo.Marca) + ', ' +
        QuotedStr(ObjVeiculo.Modelo) + ', ' +
        QuotedStr(ObjVeiculo.AnoFabricacaoModelo) + ', ' +
        QuotedStr(ObjVeiculo.ChassiTipo) + ', ' +
        QuotedStr(ObjVeiculo.ChassiNumero) + ', ' +
        QuotedStr(ObjVeiculo.CarroceriaTipo) + ', ' +
        QuotedStr(ObjVeiculo.Renavam) + ', ' + QuotedStr(ObjVeiculo.MotorNumero)
        + ', ' + QuotedStr(ObjVeiculo.Cor) + ', ' +
        QuotedStr(ObjVeiculo.Combustivel) + ', ' + MontaValor(ObjVeiculo.TaraKg)
        + ', ' + MontaValor(ObjVeiculo.CapacidadeKg) + ', ' +
        MontaValor(ObjVeiculo.Altura) + ', ' + MontaValor(ObjVeiculo.Largura) +
        ', ' + MontaValor(ObjVeiculo.Comprimento) + ', ' +
        MontaValor(ObjVeiculo.Aproveitamento) + ', ' +
        ObjVeiculo.Rastreado.ToString() + ', ' + ObjVeiculo.Segurado.ToString()
        + ', ' + IfThen(ObjVeiculo.TransportadoraId <> 0,
        ObjVeiculo.TransportadoraId.ToString, 'Null') + ', 1)'
    Else
      vSql := 'Update Veiculos ' + sLineBreak + '    Set Placa           = ' +
        QuotedStr(ObjVeiculo.Placa) + sLineBreak + '       , Procedencia    = '
        + QuotedStr(ObjVeiculo.Procedencia) + sLineBreak +
        '       , Tipo           = ' + QuotedStr(ObjVeiculo.Tipo) + sLineBreak +
        '       , Marca          = ' + QuotedStr(ObjVeiculo.Marca) + sLineBreak
        + '       , Modelo         = ' + QuotedStr(ObjVeiculo.Modelo) +
        sLineBreak + '       , AnoFabricacaoModelo = ' +
        QuotedStr(ObjVeiculo.AnoFabricacaoModelo) + sLineBreak +
        '       , ChassiTipo     = ' + QuotedStr(ObjVeiculo.ChassiTipo) +
        sLineBreak + '       , ChassiNumero   = ' +
        QuotedStr(ObjVeiculo.ChassiNumero) + sLineBreak +
        '       , CarroceriaTipo = ' + QuotedStr(ObjVeiculo.CarroceriaTipo) +
        sLineBreak + '       , Renavam        = ' +
        QuotedStr(ObjVeiculo.Renavam) + sLineBreak +
        '       , MotorNumero    = ' + QuotedStr(ObjVeiculo.MotorNumero) +
        sLineBreak + '       , Cor            = ' + QuotedStr(ObjVeiculo.Cor) +
        sLineBreak + '       , Combustivel    = ' +
        QuotedStr(ObjVeiculo.Combustivel) + sLineBreak +
        '       , TaraKg         = ' + MontaValor(ObjVeiculo.TaraKg, 3) +
        sLineBreak + '       , CapacidadeKg   = ' +
        MontaValor(ObjVeiculo.CapacidadeKg, 3) + sLineBreak +
        '       , Altura         = ' + MontaValor(ObjVeiculo.Altura) +
        sLineBreak + '       , Largura        = ' +
        MontaValor(ObjVeiculo.Largura) + sLineBreak +
        '       , Comprimento    = ' + MontaValor(ObjVeiculo.Comprimento) +
        sLineBreak + '       , Aproveitamento = ' +
        MontaValor(ObjVeiculo.Aproveitamento) + sLineBreak +
        '       , Rastreado      = ' + ObjVeiculo.Rastreado.ToString() +
        sLineBreak + '       , Segurado       = ' + ObjVeiculo.Segurado.ToString
        () + sLineBreak + '       , TransportadoraId = ' +
        IfThen(ObjVeiculo.TransportadoraId <> 0,
        ObjVeiculo.TransportadoraId.ToString, 'Null') + sLineBreak +
        '       , Status       = ' + ObjVeiculo.Status.ToString() + sLineBreak +
        'where VeiculoId = ' + ObjVeiculo.VeiculoId.ToString;
    FConexao.Query.Sql.Add(vSql);
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('Veiculos.Sql');
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela Veiculos - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
