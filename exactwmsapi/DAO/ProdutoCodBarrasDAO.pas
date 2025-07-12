unit ProdutoCodBarrasDAO;

interface

uses
  FireDAC.Comp.Client, ProdutoCodBarrasClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type
  TProdutoCodBarrasDao = class(TBasicDao)
  private
    FProdutoCodBarras: TProdutoCodBarras;

    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function GetId(pId: Integer): TjSonArray;
    Function GetProdutoCodBarras(pProdutoCodBarrasId: Integer = 0;
      pProdutoId: Integer = 0; pCodBarras: String = 'Null';
      pShowErro: Integer = 1): TjSonArray;
    Function Delete: Boolean;
    Function Salvar: Boolean;
    Property ProdutoCodBarras: TProdutoCodBarras Read FProdutoCodBarras
      Write FProdutoCodBarras;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TProdutoCodBarrasDao.Create;
begin
  FProdutoCodBarras := TProdutoCodBarras.Create;
  inherited;;
end;

function TProdutoCodBarrasDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from ProdutoCodBarras where CodBarrasId = ' + Self.ProdutoCodBarras.CodBarrasId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      raise Exception.Create('Processo: Codbarras/delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TProdutoCodBarrasDao.Destroy;
begin
  FreeAndNil(FProdutoCodBarras);

  inherited;
end;

function TProdutoCodBarrasDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pId = 0 then
         vSql := 'select * from ProdutoCodBarras'
      Else
         vSql := 'select * from ProdutoCodBarras where CodBarrasId = ' + pId.ToString;
      Query.Open(vSql);
      while Not Query.Eof do Begin
        ProdutoCodBarras.CodBarrasId       := Query.FieldByName('CodBarrasId').AsInteger;
        ProdutoCodBarras.ProdutoId         := Query.FieldByName('ProdutoId').AsInteger;
        ProdutoCodBarras.CodBarras         := Query.FieldByName('CodBarras').AsString;
        ProdutoCodBarras.UnidadesEmbalagem := Query.FieldByName('UnidadesEmbalagem').AsInteger;
        ProdutoCodBarras.Status            := Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ProdutoCodBarras));
        Query.Next;
      End;
    Except ON E: Exception do
        raise Exception.Create('Processo: Codbarras/getid - '+TUtil.tratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoCodBarrasDao.GetProdutoCodBarras(pProdutoCodBarrasId
  : Integer = 0; pProdutoId: Integer = 0; pCodBarras: String = 'Null';
  pShowErro: Integer = 1): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
     try
      if (pCodBarras = '') or (pCodBarras = '*') then
         pCodBarras := 'Null';
      vSql := 'Declare @CodBarrasID Integer = ' + pProdutoCodBarrasId.ToString+sLineBreak;
      vSql := vSql + 'Declare @ProdutoId   Integer = ' + pProdutoId.ToString+sLineBreak;
      vSql := vSql + 'Declare @CodBarras   VarChar(25) = ' + IfThen(pCodBarras = 'Null', pCodBarras, QuotedStr(pCodBarras))+sLineBreak;
      vSql := vSql + 'select top 500 CodBarrasId, ProdutoId, CodBarras, UnidadesEmbalagem, DtInclusao, HrInclusao, Principal, Status'+sLineBreak+
                     'from ProdutoCodBarras '+sLineBreak;
      vSql := vSql + 'where (@CodBarrasId = 0 or @CodBarrasId = CodBarrasId) and '+sLineBreak;
      vSql := vSql + '      (@ProdutoId = 0 or @ProdutoId = ProdutoId) and '+sLineBreak;
      vSql := vSql + '      (@CodBarras Is Null or @CodBarras = CodBarras)';
      Query.Open(vSql);
      Result := Query.toJsonArray;
    Except On E: Exception do
        raise Exception.Create('Processo: Codbarras/getprodutocodbarras - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(QUery)
  End;
end;

function TProdutoCodBarrasDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TProdutoCodBarrasDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.ProdutoCodBarras.CodBarrasId = 0 then
         vSql := 'Declare @Principal Integer = '+Self.ProdutoCodBarras.Principal.ToString + sLineBreak +
                 'Insert Into ProdutoCodBarras (ProdutoId, CodBarras, UnidadesEmbalagem, Principal, Status, DtInclusao, HrInclusao) Values ('+sLineBreak+
                 Self.ProdutoCodBarras.ProdutoId.ToString() + ', ' + QuotedStr(Self.ProdutoCodBarras.CodBarras) + ', ' +sLineBreak+
                 Self.ProdutoCodBarras.UnidadesEmbalagem.ToString() + ', ' + Self.ProdutoCodBarras.Principal.ToString() + ', 1, ' +sLineBreak+
                 TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ')'+sLineBreak+
                 'If @Principal = 1 '+sLineBreak+
                 '   Update ProdutoCodBarras Set Principal = 0 Where  CodBarras <> '+QuotedStr(Self.ProdutoCodBarras.CodBarras)+sLineBreak+
                 '      And ProdutoId = '+Self.ProdutoCodBarras.ProdutoId.ToString
             Else
         vSql := 'Declare @Principal Integer = ' + Self.ProdutoCodBarras.Principal.ToString + sLineBreak +
                 'Update ProdutoCodBarras ' + sLineBreak +
                 '    Set CodBarras         = '+ QuotedStr(Self.ProdutoCodBarras.CodBarras) +sLineBreak+
                 '      , UnidadesEmbalagem = ' +Self.ProdutoCodBarras.UnidadesEmbalagem.ToString() +slineBreak+
                 '      , Principal         = ' + Self.ProdutoCodBarras.Principal.ToString() +sLinebreak+
                 '      , Status            = ' +Self.ProdutoCodBarras.Status.ToString() + sLineBreak+
                 'Where CodBarrasId = '+Self.ProdutoCodBarras.CodBarrasId.ToString + sLineBreak +
                 'If @Principal = 1 ' + sLineBreak +
                 '   Update ProdutoCodBarras Set Principal = 0 '+sLineBreak+
                 '   Where CodBarrasId <> '+Self.ProdutoCodBarras.CodBarrasId.ToString+sLineBreak+
                 '     And ProdutoId = '+Self.ProdutoCodBarras.ProdutoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
        raise Exception.Create('Processo: Codbarras/salvar -'+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
