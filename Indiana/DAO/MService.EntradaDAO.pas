unit MService.EntradaDAO;

interface

uses
  Dialogs, FireDAC.Comp.Client, EntradaClass, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.Json, Generics.Collections;

Const SqlDataAtual = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';
Const SqlHoraAtual = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';
Const SqlEntrada   = 'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid, P.Razao, '+
                     'Ped.DocumentoNr, FORMAT(Rd.Data, '+#39+'dd/MM/yyyy'+#39+') as DocumentoData '+
                     ', FORMAT(RE.Data, '+#39+'dd/MM/yyyy'+#39+') as DtInclusao, Rh.Hora as HrInclusao '+
                     ', ArmazemId '+
	                    'From pedido Ped '+
	                    'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId '+
	                    'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId '+
	                    'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData '+
	                    'Inner Join Rhema_Data RE On Re.IdData = Ped.DtInclusao '+
	                    'Inner Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao ';

type

  TEntradaDao = class
  private
    
    ObjEntradaDAO : TEntrada;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate( pPedidoId,	pOperacaoTipoId,	pPessoaId : Integer;	pDocumentoNr : String;
                           pDocumentoData	: TDate; pArmazemId : Integer) : TjSonArray;
    function GetId(pPedidoId: Integer): TjSonArray;
    function GetDescricao(pPedidoId : Integer; pDocumento : String; pPessoaId : Integer) : tJsonArray;
    Function Delete(pPedidoId : Integer) : Boolean;
  end;


implementation

uses uSistemaControl;

{ TClienteDao }

constructor TEntradaDao.Create;
begin
  ObjEntradaDAO := TEntrada.Create;
  inherited;
end;

function TEntradaDao.Delete(pPedidoId: Integer): Boolean;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := False;
  try
    VQry := FConexao.CriarQuery();
    vSql := 'Delete from Pedido where PedidoId = '+pPedidoId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally
   
  end;
end;

destructor TEntradaDao.Destroy;
begin
  ObjEntradaDAO.Free;
  inherited;
end;

function TEntradaDao.GetDescricao(pPedidoId : Integer; pDocumento : String; pPessoaId : Integer): tJsonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();
  try
    vSql := 'Declare @PedidoId Int = '+pPedidoId.ToString()+#13+#10+
            'Declare @PessoaId Int = '+PPessoaid.ToString()+#13+#10+
            'Declare @DocumentoNr Varchar(20) = '+pDocumento+#13+#10;
    vSql := Vsql + SqlEntrada;
    vSql := vSql + ' Where '+
            '(@PedidoId = 0 or @PedidoId = Ped.PedidoId) AND '+
            '(@PessoaId = 0 or @PessoaId = P.PessoaId) and '+
            '(@DocumentoNr Is Null or @DocumentoNr = DocumentoNr)';
    VQry.Open(vSql);
    try
      Result := VQry.toJsonArray;
    finally
      VQry.Close;
    end;
  finally
   
  end;
end;

function TEntradaDao.GetId(pPedidoId: Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
  ObjJson : TJsonObject;
begin
  Result := TJsonArray.Create;
  VQry := FConexao.CriarQuery();
  try
    vSql := SqlEntrada;
    if pPedidoId <> 0 then
       vSql := vSql + ' Where PedidoId = '+pPedidoId.ToString;
    VQry.Open(vSql);
    while Not vQry.Eof do Begin
      ObjEntradaDAO.EntradaId                   := vQry.FieldByName('PedidoId').AsInteger;
      ObjEntradaDAO.OperacaoTipo.OperacaoTipoId := vQry.FieldByName('OperacaoTipoId').AsInteger;
      ObjEntradaDAO.OperacaoTipo.Descricao      := vQry.FieldByName('OperacaoTipo').AsString;
      ObjEntradaDAO.Pessoa.Id                   := vQry.FieldByName('PessoaId').AsInteger;
      ObjEntradaDAO.Pessoa.Razao                := vQry.FieldByName('Razao').AsString;
      ObjEntradaDAO.DocumentoNr                 := vQry.FieldByName('DocumentoNr').AsString;
      ObjEntradaDAO.DocumentoData               := vQry.FieldByName('DocumentoData').AsDateTime;
      ObjEntradaDAO.DtInclusao                  := vQry.FieldByName('DtInclusao').AsDateTime;
      ObjEntradaDAO.HrInclusao                  := vQry.FieldByName('HrInclusao').AsDateTime;
      ObjEntradaDAO.ArmazemId                   := vQry.FieldByName('ArmazemId').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjEntradaDAO, [joDateFormatISO8601]));

      vQry.Next;
    End;
    VQry.Close;
  finally
   
  end;
end;

function TEntradaDao.InsertUpdate(pPedidoId,	pOperacaoTipoId,	pPessoaId : Integer;	pDocumentoNr : String;
                           pDocumentoData : TDate; pArmazemId : Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();

  try
    if pPedidoId = 0 then
       vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('+
               poperacaoTipoId.ToString()+', '+pPessoaId.ToString()+', '+QuotedStr(pDocumentoNr)+', '+
               '(select IdData From Rhema_Data where Data = '+#39+FormatDateTime('YYYY-MM-DD', pDocumentoData)+#39+'), '+
               SqlDataAtual+', '+SqlHoraAtual+', '+pArmazemId.ToString()
    Else vSql := ' Update Pedido '+
                 '     Set OperacaoTipoId = '+pOperacaoTipoId.ToString()+
                 '   , PessoaId      = '+pPessoaId.ToString()+
                 '   , DocumentoNr   = '+QuotedStr(pDocumentoNr)+
                 '   , DocumentoData = '+'(select IdData From Rhema_Data where Data = '+#39+FormatDateTime('YYYY-MM-DD', pDocumentoData)+#39+')'+
                 '   , DtInclusao    = '+SqlDataAtual+
                 '   , HrInclusao    = '+SqlHoraAtual+
                 '   , ArmazemId     = '+pArmazemId.ToString()+
                 ' where EntradaId = '+pPedidoId.ToString;
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
