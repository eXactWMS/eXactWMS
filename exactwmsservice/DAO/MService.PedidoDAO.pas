unit MService.PedidoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  PedidoClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlDataAtual =
    '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';

Const
  SqlHoraAtual =
    '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';

Const
  SqlPedido =
    'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid, P.Razao, '
    + 'Ped.DocumentoNr, FORMAT(Rd.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as DocumentoData, RegistroERP, ' + ', FORMAT(RE.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtInclusao, Rh.Hora as HrInclusao ' +
    ', ArmazemId, Ped.Status ' + 'From pedido Ped ' +
    'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId ' +
    'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId ' +
    'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData ' +
    'Inner Join Rhema_Data RE On Re.IdData = Ped.DtInclusao ' +
    'Inner Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao ';

type

  TPedidoDao = class(TBasicDao)
  private
    
    FPedido: TPedido;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoId, pOperacaoTipoId, pPessoaId: Integer;
      pDocumentoNr: String; pDocumentoData: TDate; pRegistroERP: String;
      pArmazemId: Integer): TjSonArray;
    Function Salvar: Boolean;
    function GetId(pPedidoId: Integer): TjSonArray;
    function GetDocumento(pDocumento: String; pPessoaId: Integer): TjSonArray;
    Function Cancelar: Boolean;
    Function Delete: Boolean;
    Function GetPedido(pPedidoId: Integer = 0; pPessoaId: Integer = 0;
      pDocumentoNr: String = ''; pShowErro: Integer = 1): TjSonArray;
    Property Pedido: TPedido Read FPedido Write FPedido;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

function TPedidoDao.Cancelar: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Update Pedido Set Status = 3 where PedidoId = ' +
      Self.Pedido.PedidoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

constructor TPedidoDao.Create;
begin
  FPedido := TPedido.Create;
  inherited;
end;

function TPedidoDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Pedido where PedidoId = ' +
      Self.Pedido.PedidoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TPedidoDao.Destroy;
begin
  FPedido.Free;
  inherited;
end;

function TPedidoDao.GetDocumento(pDocumento: String; pPessoaId: Integer)
  : TjSonArray;
var
  vSql: String;
begin
  try
    vSql := 'Declare @PessoaId Int = ' + pPessoaId.ToString() + #13 + #10 +
      'Declare @DocumentoNr Varchar(20) = ' + pDocumento + #13 + #10;
    vSql := vSql + SqlPedido;
    vSql := vSql + ' Where ' + '(@PessoaId = 0 or @PessoaId = P.PessoaId) and '
      + '(@DocumentoNr Is Null or (@DocumentoNr = DocumentoNr or @DocumentoNr = Registro))';
    FConexao.Query.Open(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do 
    raise Exception.Create(E.Message);
  end;
end;

function TPedidoDao.GetPedido(pPedidoId, pPessoaId: Integer;
  pDocumentoNr: String; pShowErro: Integer): TjSonArray;
begin
  //
end;

function TPedidoDao.GetId(pPedidoId: Integer): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlPedido;
    if pPedidoId <> 0 then
      vSql := vSql + ' Where PedidoId = ' + pPedidoId.ToString;
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      Pedido.PedidoId := FConexao.Query.FieldByName('PedidoId').AsInteger;
      Pedido.OperacaoTipo.OperacaoTipoId := FConexao.Query.FieldByName('OperacaoTipoId')
        .AsInteger;
      Pedido.OperacaoTipo.Descricao := FConexao.Query.FieldByName('OperacaoTipo')
        .AsString;
      Pedido.Pessoa.PessoaId := FConexao.Query.FieldByName('PessoaId').AsInteger;
      Pedido.Pessoa.Razao := FConexao.Query.FieldByName('Razao').AsString;
      Pedido.DocumentoNr := FConexao.Query.FieldByName('DocumentoNr').AsString;
      Pedido.DocumentoData := FConexao.Query.FieldByName('DocumentoData').AsDateTime;
      Pedido.RegistroERP := FConexao.Query.FieldByName('RegistroERP').AsString;
      Pedido.DtInclusao := FConexao.Query.FieldByName('DtInclusao').AsDateTime;
      Pedido.HrInclusao := FConexao.Query.FieldByName('HrInclusao').AsDateTime;
      Pedido.ArmazemId := FConexao.Query.FieldByName('ArmazemId').AsInteger;
      Pedido.Status := FConexao.Query.FieldByName('Status').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(Pedido,
        [joDateFormatISO8601]));
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TPedidoDao.InsertUpdate(pPedidoId, pOperacaoTipoId, pPessoaId: Integer;
  pDocumentoNr: String; pDocumentoData: TDate; pRegistroERP: String;
  pArmazemId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pPedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, RegistroERP, DtInclusao, HrInclusao, ArmazemId) Values ('
        + pOperacaoTipoId.ToString() + ', ' + pPessoaId.ToString() + ', ' +
        QuotedStr(pDocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + '), ' + #39 +
        pRegistroERP + #39 + ', ' + SqlDataAtual + ', ' + SqlHoraAtual + ', ' +
        pArmazemId.ToString()
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        pOperacaoTipoId.ToString() + '   , PessoaId      = ' +
        pPessoaId.ToString() + '   , DocumentoNr   = ' + QuotedStr(pDocumentoNr)
        + '   , DocumentoData = ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + ')' +
        '   , RegistroERP   = ' + pRegistroERP + '   , DtInclusao    = ' +
        SqlDataAtual + '   , HrInclusao    = ' + SqlHoraAtual +
        '   , ArmazemId     = ' + pArmazemId.ToString() + ' where PedidoId = ' +
        pPedidoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TPedidoDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.Pedido.PedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, RegistroERP, HrInclusao, ArmazemId) Values ('
        + Self.Pedido.OperacaoTipo.OperacaoTipoId.ToString() + ', ' +
        Self.Pedido.Pessoa.PessoaId.ToString() + ', ' +
        QuotedStr(Self.Pedido.DocumentoNr) + ', ' + #39 +
        Self.Pedido.RegistroERP + #39 + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', Self.Pedido.DocumentoData) + #39 + '), ' +
        SqlDataAtual + ', ' + SqlHoraAtual + ', ' +
        Self.Pedido.ArmazemId.ToString()
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        Self.Pedido.OperacaoTipo.OperacaoTipoId.ToString() +
        '   , PessoaId      = ' + Self.Pedido.Pessoa.PessoaId.ToString() +
        '   , DocumentoNr   = ' + QuotedStr(Self.Pedido.DocumentoNr) +
        '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = '
        + #39 + FormatDateTime('YYYY-MM-DD', Self.Pedido.DocumentoData) + #39 +
        ')' + '   , RegistroERP   = ' + Self.Pedido.RegistroERP +
        '   , DtInclusao    = ' + SqlDataAtual + '   , HrInclusao    = ' +
        SqlHoraAtual + '   , ArmazemId     = ' + Self.Pedido.ArmazemId.ToString
        () + ' where PedidoId = ' + Self.Pedido.PedidoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
