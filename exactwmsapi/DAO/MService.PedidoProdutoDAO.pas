unit MService.PedidoProdutoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.JSON, Generics.Collections, PedidoProdutoClass,
  MService.ProdutoDAO, LotesClass, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

Const SqlDataAtual = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';

Const SqlHoraAtual = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';

Const SqlPedidoProduto = 'select PP.PedidoId, PP.PedidoItemId, Prd.IdProduto, Prd.CodProduto CodigoERP, Prd.Descricao DescrProduto, Prd.QtdUnid, '
    + #13 + #10 + 'Prd.EnderecoId, TEnd.Descricao as EnderecoDescricao, ' + #13
    + #10 + 'Prd.FatorConversao, PP.Quantidade as QtdSolicitada, 0 as QtdAtendida, 0 as QtdCorte '
    + #13 + #10 + 'From PedidoProdutos PP ' + #13 + #10 +
    'Inner Join Produto Prd On Prd.IdProduto = PP.ProdutoId ' + #13 + #10 +
    'Left Join Enderecamentos TEnd ON TENd.EnderecoId = Prd.EnderecoId ';

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
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from PedidoItem where PedidoId = ' + Self.FPedidoProduto.PedidoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      raise Exception.Create('Processo: PedidoProduto/Delete '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TPedidoProdutoDao.Destroy;
begin
  FreeAndNil(FPedidoProduto);
  inherited;
end;

function TPedidoProdutoDao.GetPedidoProduto(pEntradaId, pProdutoId, pLoteId,
  pShowErro: Integer): TjSonArray;
var vSql: String;
    ObjJson: TJsonObject;
    ObjProdutoDAO: TPRodutoDAO;
    vProdutoId: Integer;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Declare @PedidoId  Integer = ' + pEntradaId.ToString() + #13 + #10;
      vSql := vSql + 'Declare @ProdutoId Integer = ' + pProdutoId.ToString() +sLineBreak;
      vSql := vSql + 'Declare @LoteId Integer    = ' + pLoteId.ToString()+sLineBreak;
      vSql := vSql + SqlPedidoProduto+sLineBreak;
      vSql := vSql + ' Where (@PedidoId  = 0 or PIt.PedidoId  = ' + pEntradaId.ToString + ') and '+sLineBreak;
      vSql := vSql + '       (@ProdutoId = 0 or Prd.IdProduto = ' + pProdutoId.ToString + ') and '+sLineBreak;
      vSql := vSql + '       (@LoteId    = 0 or Pl.LoteId     = ' + pLoteId.ToString + ') '+sLineBreak;
      vSql := vSql + 'Order by PIt.PedidoId, PIt.PedidoItemId';
      Query.Open(vSql);
      while Not Query.Eof do Begin
        FPedidoProduto.PedidoId := Query.FieldByName('PedidoId').AsInteger;
        FPedidoProduto.PedidoItemId := Query.FieldByName('PedidoItemId').AsInteger;
        ObjProdutoDAO := TPRodutoDAO.Create;
        vProdutoId := 0;
        FPedidoProduto := TPedidoProduto.Create;
        if vProdutoId <> Query.FieldByName('ProdutoId').AsInteger then Begin
          FPedidoProduto.Produto := FPedidoProduto.Produto.JsonToClass(ObjProdutoDAO.
                                    GetId(Query.FieldByName('ProdutoId').AsString, 0, '0', nil).Items[0].ToString());
          vProdutoId := Query.FieldByName('ProdutoId').AsInteger;
        End;
        FPedidoProduto.PedidoId := Query.FieldByName('PedidoId').AsInteger;
        FPedidoProduto.PedidoItemId := Query.FieldByName('PedidoItemId').AsInteger;
        // FPedidoProduto.Produto :=
        FPedidoProduto.QtdSolicitada := Query.FieldByName('QtdSolicitada')
          .AsInteger;
        FPedidoProduto.QtdAtendida := Query.FieldByName('QtdAtendida').AsInteger;
        FPedidoProduto.QtdCorte    := Query.FieldByName('QtdCorte').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(FPedidoProduto, [joDateFormatISO8601]));
        Query.Next;
      End;
    Except On E: Exception do
      raise Exception.Create('Processo: PedidoProduto - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoProdutoDao.GetId(pPedidoItemId: Integer): TjSonArray;
var vSql: String;
   ObjJson: TJsonObject;
   ObjProdutoDAO: TPRodutoDAO;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := SqlPedidoProduto;
      if pPedidoItemId <> 0 then
         vSql := vSql + ' Where PedidoItemId = ' + pPedidoItemId.ToString;
      vSql := vSql + 'Order by Pp.PedidoId, PP.ProdutoId';
      Query.Open(vSql);
      while Not Query.Eof do
      Begin
        FPedidoProduto.PedidoId := Query.FieldByName('PedidoId').AsInteger;
        FPedidoProduto.PedidoItemId := Query.FieldByName('PedidoItemId').AsInteger;
        ObjProdutoDAO := TPRodutoDAO.Create;
        // ObjLote       := TLote.Create;
        FPedidoProduto.PedidoId := Query.FieldByName('PedidoId').AsInteger;
        FPedidoProduto.PedidoItemId := Query.FieldByName('PedidoItemId').AsInteger;
        FPedidoProduto := TPedidoProduto.Create;
        FPedidoProduto.Produto := FPedidoProduto.Produto.
                                  JsonToClass(ObjProdutoDAO.GetId(Query.FieldByName('IdProduto').AsString, 0, '0', nil).Items[0].ToString());
        FPedidoProduto.QtdSolicitada := Query.FieldByName('QtdSolicitada').AsInteger;
        FPedidoProduto.QtdAtendida := Query.FieldByName('QtdAtendida').AsInteger;
        FPedidoProduto.QtdCorte := Query.FieldByName('QtdCorte').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(FPedidoProduto, [joDateFormatISO8601]));
        Query.Next;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Erro: PedidoProduto/getid - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoProdutoDao.InsertUpdate(pPedidoItemId, pPedidoId, pLoteId,
  pQtdXml, pQtdCheckIn, pQtdDevolvida, pQtdSegregada: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pPedidoItemId = 0 then
        vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('
          + pPedidoId.ToString() + ', ' + pLoteId.ToString() + ', ' +
          pQtdXml.ToString() + ', ' + pQtdCheckIn.ToString() + ', ' +
          pQtdDevolvida.ToString() + ', ' + pQtdSegregada.ToString()
      Else
        vSql := ' Update PedidoItens ' + '   Set QtdXml   = ' + pQtdXml.ToString()+
                '   , QtdCheckIn = ' + pQtdCheckIn.ToString() +
                '   , QtdDevolvida = '+pQtdDevolvida.ToString() +
                '   , QtdSegregada = ' + pQtdSegregada.ToString() +
                ' where EntradaId = ' + pPedidoId.ToString + ' and LoteId = ' + pLoteId.ToString();
      Query.ExecSQL(vSql);
      Result := Query.toJsonArray;
    Except ON E: Exception do
      raise Exception.Create('Processo: PedidoProduto/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TPedidoProdutoDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.FPedidoProduto.PedidoId = 0 then
        vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('+
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
          ' and LoteId = ';
      // Self.FPedidoProduto.Lote.LoteId.ToString();
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      raise Exception.Create('Processo: PedidoProduto/Salvar'+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
