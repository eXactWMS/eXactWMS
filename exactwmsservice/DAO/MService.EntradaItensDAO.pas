unit MService.EntradaItensDAO;

interface

uses
  Dialogs, FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.Json, Generics.Collections
  , EntradaItensClass;

Const SqlDataAtual    = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';
Const SqlHoraAtual    = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';
Const SqlEntradaItens = 'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.ProdutoId, Pl.DescrLote, '+#13+#10+
	                       'Pl.Fabricacao, Pl.Vencimento,RD.Data  DtEntrada, Rh.Hora HrEntrada, '+#13+#10+
	                       'PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, PIt.QtdSegregada, '+#13+#10+
	                       'Prd.Descricao DescrProduto'+#13+#10+
                        'From PedidoItens PIt'+#13+#10+
                        'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId'+#13+#10+
                        'Inner join Produto Prd On Prd.IdProduto = Pl.ProdutoId'+#13+#10+
                        'Inner join Rhema_Data RD on Rd.IdData = Pl.DtEntrada'+#13+#10+
                        'Inner Join Rhema_Hora RH on Rh.IdHora = Pl.HrEntrada';

Type
  TEntradaItensDao = class
  private
    
    ObjEntradaItensDAO : TEntradaItens;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoItemId,	pPedidoId, pLoteId, pQtdXml, pQtdCheckIn, pQtdDevolvida, pQtdSegregada : Integer) : TjSonArray;
    function GetId(pPedidoItemId: Integer): TjSonArray;
    function GetEntradaItens(pPedidoId : Integer; pProdutoId : Integer; pLoteId : Integer) : tJsonArray;
    Function Delete(pPedidoId : Integer) : Boolean;
  end;


implementation

uses uSistemaControl;

{ TClienteDao }

constructor TEntradaItensDao.Create;
begin
  ObjEntradaItensDAO := TEntradaItens.Create;
  inherited;
end;

function TEntradaItensDao.Delete(pPedidoId: Integer): Boolean;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := False;
  try
    VQry := FConexao.CriarQuery();
    vSql := 'Delete from PedidoItem where PedidoId = '+pPedidoId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally
   
  end;
end;

destructor TEntradaItensDao.Destroy;
begin
  ObjEntradaItensDAO.Free;
  inherited;
end;

function TEntradaItensDao.GetEntradaItens(pPedidoId : Integer; pProdutoId : Integer; pLoteId : Integer): tJsonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := TJsonArray.Create;
  VQry := FConexao.CriarQuery();
  try
    vSql := 'Declare @PedidoId Int = '+pPedidoId.ToString+#13+#10+
            'Declare @ProdutoId Int = '+pProdutoId.ToString+#13+#10+
            'Declare @LoteId Int = '+pLoteId.ToString+#13+#10;
    vSql := vSql + SqlEntradaItens+#13+#10;
    vSql := vSql + ' Where '+#13+#10+
            '(@PedidoId = 0 or @PedidoId = PIt.PedidoId) AND '+
            '(@ProdutoId = 0 or @ProdutoId = PL.ProdutoId) and '+
            '(@LoteId = 0 or @LoteId = PIt.Loteid)';
    VQry.Open(vSql);
    try
      //Result := VQry.toJsonArray;
      while Not vQry.Eof do Begin
        ObjEntradaItensDAO.EntradaItemId := vQry.FieldByName('PedidoItemid').AsInteger;
        ObjEntradaItensDAO.EntradaId     := vQry.FieldByName('PedidoId').AsInteger;
        ObjEntradaItensDAO.Lote.LoteId   := vQry.FieldByName('LoteId').AsInteger;
        ObjEntradaItensDAO.Lote.ProdutoId := vQry.FieldByName('ProdutoId').AsInteger;
        ObjEntradaItensDAO.Lote.DescrLote := vQry.FieldByName('DescrLote').AsString;
        ObjEntradaItensDAO.Lote.Fabricacao := vQry.FieldByName('Fabricacao').AsDateTime;
        ObjEntradaItensDAO.Lote.Vencimento := vQry.FieldByName('Vencimento').AsDateTime;
        ObjEntradaItensDAO.Lote.DtEntrada  := vQry.FieldByName('DtEntrada').AsDateTime;
        ObjEntradaItensDAO.Lote.HrEntrada  := vQry.FieldByName('HrEntrada').AsDateTime;
        ObjEntradaItensDAO.QtdXml          := vQry.FieldByName('QtdXML').AsInteger;
        ObjEntradaItensDAO.QtdCheckIn      := vQry.FieldByName('QtdCheckIn').AsInteger;
        ObjEntradaItensDAO.QtdDevolvida    := vQry.FieldByName('QtdDevolvida').AsInteger;
        ObjEntradaItensDAO.QtdSegregada    := vQry.FieldByName('QtdSegregada').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEntradaItensDAO, [joDateFormatISO8601]));
        vQry.Next;
      End;
    finally
      VQry.Close;
    end;
  finally
   
  end;
end;

function TEntradaItensDao.GetId(pPedidoItemId: Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
  ObjJson : TJsonObject;
begin
  Result := TJsonArray.Create;
  VQry := FConexao.CriarQuery();
  try
    vSql := SqlEntradaItens;
    if pPedidoItemId <> 0 then
       vSql := vSql + ' Where PedidoItensId = '+pPedidoItemId.ToString;
    VQry.Open(vSql);
    while Not vQry.Eof do Begin
      ObjEntradaItensDAO.EntradaId       := vQry.FieldByName('PedidoId').AsInteger;
      ObjEntradaItensDAO.EntradaItemId   := vQry.FieldByName('EntradaItemId').AsInteger;
      ObjEntradaItensDAO.Lote.LoteId     := vQry.FieldByName('LoteId').AsInteger;
      ObjEntradaItensDAO.Lote.DescrLote  := vQry.FieldByName('DescrLote').AsString;
      ObjEntradaItensDAO.Lote.Fabricacao := vQry.FieldByName('Fabricacao').AsDateTime;
      ObjEntradaItensDAO.Lote.Vencimento := vQry.FieldByName('Vencimento').AsDateTime;
      ObjEntradaItensDAO.Lote.DtEntrada  := vQry.FieldByName('Data').AsDateTime;
      ObjEntradaItensDAO.Lote.HrEntrada  := vQry.FieldByName('Hora').AsDateTime;
      Result.AddElement(tJson.ObjectToJsonObject(ObjEntradaItensDAO, [joDateFormatISO8601]));
      vQry.Next;
    End;
    VQry.Close;
  finally
   
  end;
end;

function TEntradaItensDao.InsertUpdate(pPedidoItemId,	pPedidoId, pLoteId, pQtdXml, pQtdCheckIn, pQtdDevolvida, pQtdSegregada : Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();
  try
    if pPedidoItemId = 0 then
       vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('+
               pPedidoId.ToString()+', '+pLoteId.ToString()+', '+pQtdXml.ToString()+', '+
               pQtdCheckIn.ToString()+', '+pQtdDevolvida.ToString()+', '+pQtdSegregada.ToString()
    Else vSql := ' Update PedidoItens '+
                 '   Set QtdXml   = '+pQtdXml.ToString()+
                 '   , QtdCheckIn = '+pQtdCheckIn.ToString()+
                 '   , QtdDevolvida = '+pQtdDevolvida.ToString()+
                 '   , QtdSegregada = '+pQtdSegregada.ToString()+
                 ' where EntradaId = '+pPedidoId.ToString+' and LoteId = '+pLoteId.ToString();
    VQry.ExecSQL(vSql);
    try
      Result := VQry.toJsonArray;
    finally
      VQry.Close;
    end;
  finally
   
  end;
end;

end.
