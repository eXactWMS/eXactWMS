unit MService.ProdutoCodBarrasDAO;

interface

uses
  Dialogs, FireDAC.Comp.Client, ProdutoCodBarrasClass, System.SysUtils,  DataSet.Serialize,
  System.JSON, REST.Json;

Const SqlDataAtual = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';
Const SqlHoraAtual = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';
Const SqlProdutoCodBarras = 'Select Cb.* From ProdutoCodBarras Cb';

type
  TProdutoCodBarrasDao = class
  private
    
    ObjProdutoCodBarrasDAO : TProdutoCodBarras;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pProdutoCodBarrasId, pProdutoId : Integer; pCodBarras : String; pUnidadesEmbalagem : Integer; pStatus : Integer): TjSonArray;
    function GetCodBarras(pCodBarras : String = ''): TjSonArray;
    function GetDescricao(pProdutoCodBarrasId, pProdutoId : Integer; pCodBarras : String) : tJsonArray;
    Function Delete(pId : Integer) : Boolean;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TProdutoCodBarrasDao.Create;
begin
  ObjProdutoCodBarrasDAO := TProdutoCodBarras.Create;
  inherited;
end;

function TProdutoCodBarrasDao.Delete(pId: Integer): Boolean;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := False;
  try
    VQry := FConexao.CriarQuery();
    vSql := 'Delete from ProdutoProdutoCodBarrass where ProdutoCodBarrasId = '+pId.ToString;
    VQry.ExecSQL(vSql);
    Result := True;
    VQry.Close;
  finally
   
  end;
end;

destructor TProdutoCodBarrasDao.Destroy;
begin
  ObjProdutoCodBarrasDAO.Free;
  inherited;
end;

function TProdutoCodBarrasDao.GetDescricao(pProdutoCodBarrasId, pProdutoId : Integer; pCodBarras : String): tJsonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();
  try
    if pCodBarras = '*' then pCodBarras := 'Null';
    vSql := 'Declare @ProdutoCodBarrasId : Integer = '+pProdutoCodBarrasId.ToString()+#13+#10+
            'Declare @ProdutoId : Integer = '+pProdutoId.ToString+#13+#10+
            'Declare @CodBarra : VarChar(25) = '+pCodBarras+#13+#10+
            SqlProdutoCodBarras+#13+#10+
            'Where (@ProdutoId = 0 or @ProdutoId = Cb.ProdutoId)'+#13+#10+
            '      and (@ProdutoCodBarrasId = 0 or @ProdutoCodBarrasid = Cb.ProdutoCodBarrasId)'+#13+#10+
            '   	  and (@Descricao = Null or CodBarras like @CodBarras)';
            //showmessage(vSql);
    VQry.Open(vSql);
    try
      Result := VQry.toJsonArray;
    finally
      VQry.Close;
    end;
  finally
   
  end;
end;

function TProdutoCodBarrasDao.GetCodBarras(pCodBarras : String): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  Result := TJsonArray.Create;
  VQry := FConexao.CriarQuery();
  try
    if pCodBarras = 0 then
       vSql := SqlProdutoCodBarras
    Else vSql := SqlProdutoCodBarras+#13+#10+
                 'where CodBarras = '+pCodBarras;
    VQry.Open(vSql);
    while Not vQry.Eof do Begin
      ObjProdutoCodBarrasDAO.ProdutoCodBarrasId := vQry.FieldByName('ProdutoCodBarrasId').AsInteger;
      ObjProdutoCodBarrasDAO.ProdutoId          := vQry.FieldByName('ProdutoId').AsInteger;
      ObjProdutoCodBarrasDAO.CodBarras          := vQry.FieldByName('CodBarras').AsString;
      ObjProdutoCodBarrasDAO.UnidadesEmbalagem  := vQry.FieldByName('UnidadesEmabalagem').AsInteger;
      ObjProdutoCodBarrasDAO.Status             := vQry.FieldByName('Status').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoCodBarrasDAO, [joDateFormatISO8601]));
      vQry.Next;
    End;
    VQry.Close;
  finally
   
  end;
end;

function TProdutoCodBarrasDao.InsertUpdate(pProdutoCodBarrasId, pProdutoId : Integer; pCodBarras : String; pUnidadesEmbalagem : Integer; pStatus : Integer): TjSonArray;
var
  VQry: TFDQuery;
  vSql : String;
begin
  VQry := FConexao.CriarQuery();

  try
    if pProdutoCodBarrasId = 0 then
       vSql := 'Insert Into ProdutoCodBarras (ProdutoId, CodBarras, UnidadesEmbalagem, Status) Values ('+
               pProdutoid.ToString()+', '+QuotedStr(pCodBarras)+', '+pUnidadesEmbalagem.ToString()+', '+
               pStatus.ToString()+', '+
               '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+', '+
               'select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))'+
               pStatus.ToString()+')'
    Else vSql := 'Update ProdutoCodBarras '+
                 '    Set CodBarras   = '+QuotedStr(pCodBarras)+#13+#10+
                 '        , UnidadesEmabalagem ='+pUnidadesEmbalagem.ToString+#13+#10+
                 'where ProdutoCodBarrasId = '+pProdutoCodBarrasId.ToString;
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
