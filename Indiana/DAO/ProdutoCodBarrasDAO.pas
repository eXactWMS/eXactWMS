unit ProdutoCodBarrasDAO;

interface

uses
  FireDAC.Comp.Client, ProdutoCodBarrasClass, System.SysUtils, 
  DataSet.Serialize,
  System.JSON, REST.JSON, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

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
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from ProdutoCodBarras where CodBarrasId = ' +
      Self.ProdutoCodBarras.CodBarrasId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TProdutoCodBarrasDao.Destroy;
begin
  FProdutoCodBarras.Free;

  inherited;
end;

function TProdutoCodBarrasDao.GetId(pId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    if pId = 0 then
      vSql := 'select * from ProdutoCodBarras'
    Else
      vSql := 'select * from ProdutoCodBarras where CodBarrasId = ' +
        pId.ToString;
    Fconexao.Query.Open(vSql);
    while Not Fconexao.Query.Eof do
    Begin
      ProdutoCodBarras.CodBarrasId := Fconexao.Query.FieldByName('CodBarrasId')
        .AsInteger;
      ProdutoCodBarras.ProdutoId := Fconexao.Query.FieldByName('ProdutoId')
        .AsInteger;
      ProdutoCodBarras.CodBarras := Fconexao.Query.FieldByName
        ('CodBarras').AsString;
      ProdutoCodBarras.UnidadesEmbalagem := Fconexao.Query.FieldByName
        ('UnidadesEmbalagem').AsInteger;
      ProdutoCodBarras.Status := Fconexao.Query.FieldByName('Status').AsInteger;
      Result.AddElement(tJson.ObjectToJsonObject(ProdutoCodBarras));
      Fconexao.Query.Next;
    End;

  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TProdutoCodBarrasDao.GetProdutoCodBarras(pProdutoCodBarrasId
  : Integer = 0; pProdutoId: Integer = 0; pCodBarras: String = 'Null';
  pShowErro: Integer = 1): TjSonArray;
var
  vSql: String;
begin
  try
    if (pCodBarras = '') or (pCodBarras = '*') then
      pCodBarras := 'Null';
    vSql := 'Declare @CodBarrasID Integer = ' + pProdutoCodBarrasId.ToString +
      #13 + #10;
    vSql := vSql + 'Declare @ProdutoId   Integer = ' + pProdutoId.ToString +
      #13 + #10;
    vSql := vSql + 'Declare @CodBarras   VarChar(25) = ' +
      IfThen(pCodBarras = 'Null', pCodBarras, QuotedStr(pCodBarras)) +
      #13 + #10;
    vSql := vSql + 'select top 500 CodBarrasId, ProdutoId, CodBarras, UnidadesEmbalagem, DtInclusao, HrInclusao, Principal, Status'+sLineBreak+
                   ' from ProdutoCodBarras ' + #13 + #10;
    vSql := vSql + 'where (@CodBarrasId = 0 or @CodBarrasId = CodBarrasId) and '
      + #13 + #10;
    vSql := vSql + '      (@ProdutoId = 0 or @ProdutoId = ProdutoId) and ' +
      #13 + #10;
    vSql := vSql + '      (@CodBarras Is Null or @CodBarras = CodBarras)';
    Fconexao.Query.Open(vSql);
    Result := Fconexao.Query.toJsonArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
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
var
  vSql: String;
begin
  Result := False;
  try
    if Self.ProdutoCodBarras.CodBarrasId = 0 then
      vSql := 'Declare @Principal Integer = '+Self.ProdutoCodBarras.Principal.ToString + sLineBreak +
        'Insert Into ProdutoCodBarras (ProdutoId, CodBarras, UnidadesEmbalagem, Principal, Status, DtInclusao, HrInclusao) Values ('
        + Self.ProdutoCodBarras.ProdutoId.ToString() + ', ' + QuotedStr(Self.ProdutoCodBarras.CodBarras) + ', ' +
        Self.ProdutoCodBarras.UnidadesEmbalagem.ToString() + ', ' + Self.ProdutoCodBarras.Principal.ToString() + ', 1, ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ')' +sLineBreak +
        'If @Principal = 1 ' + sLineBreak +
        '   Update ProdutoCodBarras Set Principal = 0 Where  CodBarras <> '+QuotedStr(Self.ProdutoCodBarras.CodBarras)+sLineBreak+
        '      And ProdutoId = '+Self.ProdutoCodBarras.ProdutoId.ToString
    Else
      vSql := 'Declare @Principal Integer = ' + Self.ProdutoCodBarras.Principal.ToString + sLineBreak +
        'Update ProdutoCodBarras ' + sLineBreak +
        '    Set CodBarras         = '+ QuotedStr(Self.ProdutoCodBarras.CodBarras) +sLineBreak+
        '      , UnidadesEmbalagem = ' +Self.ProdutoCodBarras.UnidadesEmbalagem.ToString() +slineBreak+
        '      , Principal         = ' + Self.ProdutoCodBarras.Principal.ToString() +sLinebreak+
        '      , Status            = ' +Self.ProdutoCodBarras.Status.ToString() + sLineBreak+
        'where CodBarrasId = '+Self.ProdutoCodBarras.CodBarrasId.ToString + sLineBreak +
        'If @Principal = 1 ' + sLineBreak +
        '   Update ProdutoCodBarras Set Principal = 0 '+sLineBreak+
        '   Where CodBarrasId <> '+Self.ProdutoCodBarras.CodBarrasId.ToString+sLineBreak+
        '      And ProdutoId = '+Self.ProdutoCodBarras.ProdutoId.ToString;
    Fconexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
