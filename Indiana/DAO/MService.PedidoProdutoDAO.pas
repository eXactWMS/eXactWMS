unit MService.PedidoProdutoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.JSON, Generics.Collections, PedidoProdutoClass,
  MService.ProdutoDAO, LotesClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlDataAtual =
    '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';

Const
  SqlHoraAtual =
    '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';

Const
  SqlPedidoProduto =
    'select PP.PedidoId, PP.PedidoItemId, Prd.IdProduto, Prd.CodProduto CodigoERP, Prd.Descricao DescrProduto, Prd.QtdUnid, '
    + #13 + #10 + 'Prd.EnderecoId, TEnd.Descricao as EnderecoDescricao, ' + #13
    + #10 + 'Prd.FatorConversao, PP.Quantidade as QtdSolicitada, 0 as QtdAtendida, 0 as QtdCorte '
    + #13 + #10 + 'From PedidoProdutos PP ' + #13 + #10 +
    'Inner Join Produto Prd On Prd.IdProduto = PP.ProdutoId ' + #13 + #10 +
    'Left Join Enderecamentos TEnd ON TENd.EnderecoId = Prd.EnderecoId ';
  // +#13+#10+
  // 'Where PedidoId = @Pedido';

Type
  TPedidoProdutoDao = class(TBasicDao)
  private
    

    FPedidoProduto: TPedidoProduto;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoItemId, pPedidoId, pLoteId, pQtdXml,
      pQtdCheckIn, pQtdDevolvida, pQtdSegregada: Integer): TjSonArray;
    Function Salvar: Boolean;
    function GetId(pPedidoItemId: Integer): TjSonArray;
    Function Delete: Boolean;
    Function GetPedidoProduto(pEntradaId: Integer = 0; pProdutoId: Integer = 0;
      pLoteId: Integer = 0; pShowErro: Integer = 1): TjSonArray;
    Property ObjPedidoProduto: TPedidoProduto Read FPedidoProduto
      Write FPedidoProduto;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TPedidoProdutoDao.Create;
begin
  FPedidoProduto := TPedidoProduto.Create();
  inherited;
end;

function TPedidoProdutoDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from PedidoItem where PedidoId = ' +
    Self.FPedidoProduto.PedidoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TPedidoProdutoDao.Destroy;
begin
  FPedidoProduto.Free;
  inherited;
end;

function TPedidoProdutoDao.GetPedidoProduto(pEntradaId, pProdutoId, pLoteId,
  pShowErro: Integer): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
  ObjProdutoDAO: TPRodutoDAO;
  // ObjLote       : TLote;
  vProdutoId: Integer;
begin
  Result := TjSonArray.Create;
  try
    vSql := 'Declare @PedidoId  Integer = ' + pEntradaId.ToString() + #13 + #10;
    vSql := vSql + 'Declare @ProdutoId Integer = ' + pProdutoId.ToString() +
      #13 + #10;
    vSql := vSql + 'Declare @LoteId Integer    = ' + pLoteId.ToString() +
      #13 + #10;
    vSql := vSql + SqlPedidoProduto + #13 + #10;
    vSql := vSql + ' Where (@PedidoId  = 0 or PIt.PedidoId  = ' +
      pEntradaId.ToString + ') and ' + #13 + #10;
    vSql := vSql + '       (@ProdutoId = 0 or Prd.IdProduto = ' +
      pProdutoId.ToString + ') and ' + #13 + #10;
    vSql := vSql + '       (@LoteId    = 0 or Pl.LoteId     = ' +
      pLoteId.ToString + ') ' + #13 + #10;
    vSql := vSql + 'Order by PIt.PedidoId, PIt.PedidoItemId';
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      FPedidoProduto.PedidoId := FConexao.Query.FieldByName('PedidoId').AsInteger;
      FPedidoProduto.PedidoItemId := FConexao.Query.FieldByName('PedidoItemId').AsInteger;
      ObjProdutoDAO := TPRodutoDAO.Create;
      // ObjLote       := TLote.Create;
      vProdutoId := 0;
      FPedidoProduto := TPedidoProduto.Create;
      if vProdutoId <> FConexao.Query.FieldByName('ProdutoId').AsInteger then
      Begin
        FPedidoProduto.Produto := FPedidoProduto.Produto.JsonToClass
          (ObjProdutoDAO.GetId(FConexao.Query.FieldByName('ProdutoId').AsString, 0, '0',
          nil).Items[0].ToString());
        vProdutoId := FConexao.Query.FieldByName('ProdutoId').AsInteger;
      End;
      FPedidoProduto.PedidoId := FConexao.Query.FieldByName('PedidoId').AsInteger;
      FPedidoProduto.PedidoItemId := FConexao.Query.FieldByName('PedidoItemId').AsInteger;
      // FPedidoProduto.Produto :=
      FPedidoProduto.QtdSolicitada := FConexao.Query.FieldByName('QtdSolicitada')
        .AsInteger;
      FPedidoProduto.QtdAtendida := FConexao.Query.FieldByName('QtdAtendida').AsInteger;
      FPedidoProduto.QtdCorte := FConexao.Query.FieldByName('QtdCorte').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(FPedidoProduto,
        [joDateFormatISO8601]));
      FConexao.Query.Next;
    End;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TPedidoProdutoDao.GetId(pPedidoItemId: Integer): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
  ObjProdutoDAO: TPRodutoDAO;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlPedidoProduto;
    if pPedidoItemId <> 0 then
      vSql := vSql + ' Where PedidoItemId = ' + pPedidoItemId.ToString;
    vSql := vSql + 'Order by Pp.PedidoId, PP.ProdutoId';
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      FPedidoProduto.PedidoId := FConexao.Query.FieldByName('PedidoId').AsInteger;
      FPedidoProduto.PedidoItemId := FConexao.Query.FieldByName('PedidoItemId').AsInteger;
      ObjProdutoDAO := TPRodutoDAO.Create;
      // ObjLote       := TLote.Create;
      FPedidoProduto.PedidoId := FConexao.Query.FieldByName('PedidoId').AsInteger;
      FPedidoProduto.PedidoItemId := FConexao.Query.FieldByName('PedidoItemId').AsInteger;
      FPedidoProduto := TPedidoProduto.Create;
      FPedidoProduto.Produto := FPedidoProduto.Produto.JsonToClass
        (ObjProdutoDAO.GetId(FConexao.Query.FieldByName('IdProduto').AsString, 0, '0',
        nil).Items[0].ToString());
      FPedidoProduto.QtdSolicitada := FConexao.Query.FieldByName('QtdSolicitada')
        .AsInteger;
      FPedidoProduto.QtdAtendida := FConexao.Query.FieldByName('QtdAtendida').AsInteger;
      FPedidoProduto.QtdCorte := FConexao.Query.FieldByName('QtdCorte').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(FPedidoProduto,
        [joDateFormatISO8601]));
      FConexao.Query.Next;
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Erro: ' + E.Message);
    End;
  End;
end;

function TPedidoProdutoDao.InsertUpdate(pPedidoItemId, pPedidoId, pLoteId,
  pQtdXml, pQtdCheckIn, pQtdDevolvida, pQtdSegregada: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pPedidoItemId = 0 then
      vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('
        + pPedidoId.ToString() + ', ' + pLoteId.ToString() + ', ' +
        pQtdXml.ToString() + ', ' + pQtdCheckIn.ToString() + ', ' +
        pQtdDevolvida.ToString() + ', ' + pQtdSegregada.ToString()
    Else
      vSql := ' Update PedidoItens ' + '   Set QtdXml   = ' + pQtdXml.ToString()
        + '   , QtdCheckIn = ' + pQtdCheckIn.ToString() + '   , QtdDevolvida = '
        + pQtdDevolvida.ToString() + '   , QtdSegregada = ' +
        pQtdSegregada.ToString() + ' where EntradaId = ' + pPedidoId.ToString +
        ' and LoteId = ' + pLoteId.ToString();
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.toJsonArray;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TPedidoProdutoDao.Salvar: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    if Self.FPedidoProduto.PedidoId = 0 then
      vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('
        +
      // Self.FPedidoProduto.EntradaId.ToString()+', '+Self.FPedidoProduto.Lote.LoteId.ToString()+', '+
        Self.FPedidoProduto.QtdSolicitada.ToString() + ', ' +
        Self.FPedidoProduto.QtdAtendida.ToString() + ', ' +
        Self.FPedidoProduto.QtdCorte.ToString()
    Else
      vSql := ' Update PedidoItens ' +
      // '   Set QtdXml     = '+Self.FPedidoProduto.QtdXml.ToString()+
      // '   , QtdCheckIn   = '+Self.FPedidoProduto.QtdCheckIn.ToString()+
      // '   , QtdDevolvida = '+Self.FPedidoProduto.QtdDevolvida.ToString()+
      // '   , QtdSegregada = '+Self.FPedidoProduto.QtdSegregada.ToString()+
        ' where EntradaId  = ' + Self.FPedidoProduto.PedidoId.ToString +
        ' and LoteId = '; // +
    // Self.FPedidoProduto.Lote.LoteId.ToString();
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
