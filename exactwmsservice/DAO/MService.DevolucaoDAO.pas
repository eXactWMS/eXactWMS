unit MService.DevolucaoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Math,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  PedidoSaidaClass, exactwmsservice.lib.connection, exactwmsservice.dao.base
  // , PedidoProdutoClass, MService.PedidoProdutoDAO
    ;

type

  TDevolucaoDao = class(TBasicDao)
  private

    FDevolucao: TPedidoSaida;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    function GetDevolucao(pDevolucaoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer; pRazao, pDocumentoNr: String): TjSonArray;
    Function GetPendente: TjSonArray;
    Function Cancelar: Boolean;
    Function Delete: Boolean;
    Property Devolucao: TPedidoSaida Read FDevolucao Write FDevolucao;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TDevolucaoDao.Cancelar: Boolean;
var
  VQry: TFDQuery;
  vSql: String;
begin
  Result := False;
  try
    // Chamar Rotina de Cancelamento de Cubagem

    VQry := FConexao.GetQuery;
    if assigned(FConexao) then
      VQry.connection := FConexao.DB;
    vSql := 'Update Pedido Set Status = 3 ' + #13 + #10 + 'where PedidoId = ' +
      Self.Devolucao.PedidoId.ToString + ' and OperacaoTipoId = 2' + #13 + #10 +
      #13 + #10 + 'Insert Into DocumentoEtapas Values ' + #13 + #10 + ' (' + #39
      + Self.Devolucao.uuid + #39 + ', 13, Null, ' + TuEvolutConst.SqlDataAtual
      + ', ' + TuEvolutConst.SqlHoraAtual + ', GetDate(), Null, 1)';
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally;

  end;
end;

constructor TDevolucaoDao.Create;
begin
  Devolucao := TPedidoSaida.Create;
  // TDevolucaoDAO.ListProduto   := TObjectList<TPedidoProduto>.Create();
  inherited;
end;

function TDevolucaoDao.Delete: Boolean;
var
  VQry: TFDQuery;
  vSql: String;
begin
  Result := False;
  try

    VQry := FConexao.GetQuery;
    if assigned(FConexao) then
      VQry.connection := FConexao.DB;
    vSql := 'Delete from Pedido where PedidoId = ' +
      Self.Devolucao.PedidoId.ToString + ' and OperacaoTipoId = 5';
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally;

  end;
end;

destructor TDevolucaoDao.Destroy;
begin

  FreeAndNil(Devolucao);
  inherited;
end;

function TDevolucaoDao.GetDevolucao(pDevolucaoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr: String): TjSonArray;
var
  VQry: TFDQuery;
  JsonRetorno: TJsonObject;
begin
  VQry := FConexao.GetQuery;
  if assigned(FConexao) then
    VQry.connection := FConexao.DB;
  // vQryProduto := FConexao.CriarQuery();
  try
    VQry.Sql.Add(TuEvolutConst.SqlPedido);
    VQry.ParamByName('pPedidoId').Value := pDevolucaoId;
    if pDataIni = 0 then
      VQry.ParamByName('pDataIni').Value := pDataIni
    Else
      VQry.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD',
        pDataIni);
    if pDataFin = 0 then
      VQry.ParamByName('pDataFin').Value := pDataFin
    Else
      VQry.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD',
        pDataFin);;
    VQry.ParamByName('pCodigoERP').Value := pCodigoERP;
    VQry.ParamByName('pPessoaId').Value := pPessoaId;
    VQry.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    VQry.ParamByName('pRazao').Value := '%' + pRazao + '%';

    VQry.ParamByName('pRegistroERP').Value := '';
    VQry.ParamByName('pRotaId').Value := 0;
    VQry.ParamByName('pProcessoId').Value := 0;
    VQry.ParamByName('pMontarCarga').Value := 0;

    if DebugHook <> 0 then
      VQry.Sql.SaveToFile('Devolucao.Sql');
    VQry.ParamByName('pOperacaoTipoId').Value := 5;
    VQry.Open;
    if VQry.Isempty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutConst.QrySemDados)));
    End
    Else
       VQry.ToJsonArray;
    VQry.Close;;

  Except
    ON E: Exception do
    Begin;

      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TDevolucaoDao.GetPendente: TjSonArray;
var
  VQry: TFDQuery;
  vSql: String;
  // ObjPedidoProduto       : TPedidoProduto;
  // ObjPedidoSaidaItensDAO : TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
begin
  Result := TjSonArray.Create;

  VQry := FConexao.GetQuery;
  if assigned(FConexao) then
    VQry.connection := FConexao.DB;
  // vQryProduto := FConexao.CriarQuery();
  try
    vSql := TuEvolutConst.SqlPedidoProcessar;
    // Todos os pedidos disponíveis para processamento
    VQry.Sql.Add(vSql);
    // vSql := vSql + ' Where PedidoId = '+pPedidoId.ToString+' and Ped.OperacaoTipoId = 2';
    VQry.Open;
    if VQry.Isempty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      While Not VQry.Eof do
      Begin
        Devolucao.PedidoId := VQry.FieldByName('PedidoId').AsInteger;
        Devolucao.OperacaoTipo.OperacaoTipoId :=
          VQry.FieldByName('OperacaoTipoId').AsInteger;
        Devolucao.OperacaoTipo.Descricao :=
          VQry.FieldByName('OperacaoTipo').AsString;
        Devolucao.Pessoa.PessoaId := VQry.FieldByName('PessoaId').AsInteger;
        Devolucao.Pessoa.Razao := VQry.FieldByName('Razao').AsString;
        Devolucao.DocumentoNr := VQry.FieldByName('DocumentoNr').AsString;
        Devolucao.DocumentoData := VQry.FieldByName('DocumentoData').AsDateTime;
        Devolucao.DtInclusao := VQry.FieldByName('DtInclusao').AsDateTime;
        Devolucao.HrInclusao := VQry.FieldByName('HrInclusao').AsDateTime;
        Devolucao.ArmazemId := VQry.FieldByName('ArmazemId').AsInteger;
        Devolucao.Status := VQry.FieldByName('Status').AsInteger;
        Devolucao.uuid := VQry.FieldByName('uuid').AsString;
        // vQryProduto.Open('Declare @Pedido Integer = '+vQry.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
        { ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
          ArrayPedidoProdutoDAO  := ObjPedidoSaidaItensDAO.GetId(0); //vQryProduto.FieldByName('PedidoId').AsInteger);
          for vItens := 0 to ArrayPedidoProdutoDAO.Count-1 do Begin
          ObjPedidoProduto := ObjPedidoProduto.JsonToClass(ArrayPedidoProdutoDAO.Items[vItens].ToString());
          PedidoSaida.ListProduto.Add(ObjPedidoProduto);
          End;
          Result.AddElement(tJson.ObjectToJsonObject(PedidoSaida, [joDateFormatISO8601]));
        } VQry.Next;
      End;
    VQry.Close;;

    // ObjPedidoProduto := Nil;
    // ArrayPedidoProdutoDAO := nil;
  Except
    ON E: Exception do
    Begin;

      // ObjPedidoProduto := Nil;
      // ArrayPedidoProdutoDAO := nil;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TDevolucaoDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

Function TDevolucaoDao.Salvar: Boolean;
var
  VQry: TFDQuery;
  vSql: String;
begin

  VQry := FConexao.GetQuery;
  if assigned(FConexao) then
    VQry.connection := FConexao.DB;
  try
    if Self.Devolucao.PedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, RegistroERP, DtInclusao, HrInclusao, ArmazemId) Values ('
        + Self.Devolucao.OperacaoTipo.OperacaoTipoId.ToString() + ', ' +
        Self.Devolucao.Pessoa.PessoaId.ToString() + ', ' +
        QuotedStr(Self.Devolucao.DocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', Self.Devolucao.DocumentoData) + #39 + '), '
        + #39 + Self.Devolucao.RegistroERP + #39 + ', ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', ' +
      // Self.PedidoSaida.ArmazemId.ToString() //
        IfThen(Self.Devolucao.ArmazemId = 0, 'Null',
        Self.Devolucao.ToString()) + ')'
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        Self.Devolucao.OperacaoTipo.OperacaoTipoId.ToString() +
        '   , PessoaId      = ' + Self.Devolucao.Pessoa.PessoaId.ToString() +
        '   , DocumentoNr   = ' + QuotedStr(Self.Devolucao.DocumentoNr) +
        '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = '
        + #39 + FormatDateTime('YYYY-MM-DD', Self.Devolucao.DocumentoData) + #39
        + ')' + '   , RegistroERP   = ' + QuotedStr(Self.Devolucao.RegistroERP)
        + '   , ArmazemId     = ' + Self.Devolucao.ArmazemId.ToString() +
        ' where PedidoId = ' + Self.Devolucao.PedidoId.ToString +
        ' and OperacaoTipoId = 5';
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally;

  end;
end;

end.
