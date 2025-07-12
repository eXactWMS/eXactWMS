{
  Micro Servico - DAO - ProdutoDAO
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}

unit MService.ProdutoDAO;

interface

uses
  FireDAC.Comp.Client, ProdutoClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.utils,
  System.JSON, REST.JSON, Math, System.Generics.Collections, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  TProdutoDao = class(TBasicDao)
  private
    
    ObjProdutoDAO: TProduto;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
    Function SalvarLaboratorio(pCodERP: Integer = 0; pNome: String = '';
      pFone: String = ''; PEmail: String = ''; pHomePage: String = ''): Integer;
    Function SalvarUnidades(pSigla: String = 'Un';
      pDescricao: String = 'Unidade'): Boolean;
    Procedure SalvarProdutoCodbarras(pCodProdutoERP: Integer = 0;
      pEan: String = '');
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pIdProduto, pCodProduto: Integer;
      pCodigoMS, pDescricao, pDescrReduzida: String;
      pUnidadeId, pQtdUnid, pUnidadeSecondariaId, pFatorConversao,
      pSomenteCxaFechada: Integer; pEnderecoId, pRastroid, pImportado,
      pSNGPC: Integer; pEnderecamentoZonaId: Integer;
      pEanPrincipal, pProdutoTipo, pMedicamentoTipo: String;
      pIdUnidMedIndustrial: Integer; pLaboratorioId, pliquido, pPerigoso,
      pInflamavel, pMedicamento: Integer; pPesoLiquido: Integer;  pAltura, pLargura,
  pComprimento : iNTEGER;  pMinPicking, pMaxPicking, pQtdReposicao,
      pPercReposicao: Integer; pMesEntradaMinima, pMesSaidaMinima,
      pStatus: Integer): TjSonArray;
    function GetId(pId: String; pProdutoTipoID: Integer; pCodigoERP: String;
      AQueryParam: TDictionary<String, String>): TjSonArray;
    function GetId4D(const AParams: TDictionary<string, string>): TJsonObject;
    function GetCodigoERP(pCodigoERP: String): TjSonArray;
    function GetDescricao(pNome: String; pProdutoTipoID: Integer;
      AQueryParam: TDictionary<String, String>): TjSonArray;
    Function Delete(pId, pProdutoTipoID: Integer): Boolean;
    Function GetCodProduto(pCodProduto: String): TJsonObject;
    Function MontarPaginacao: TJsonObject;
    Function Estrutura: TjSonArray;
    Function EnderecarProduto(pJsonProduto: TJsonObject): TjSonArray;
    Function Import(pJsonArray: TjSonArray): TjSonArray; // Integração ERP
    Function ImportDados(pJsonArray: TjSonArray): TjSonArray;
    Function ImportDadosV2(pJsonObjectProduto: TJsonObject) : TJsonArray;
    // Dados Básicos Implantação
    Function ExportarCubagem: TjSonArray;
    Function ImportCubagem(pJsonArray: TjSonArray): TjSonArray;
    // Dados Básicos Implantação
    Function ImportCubagemDC(pJsonArray: TjSonArray): TjSonArray;
    // Dados Básicos Implantação
    Function ImportEstoque(pJsonArray: TjSonArray): TjSonArray;
    // Dados Básicos Implantação
    Function ImportEnderecamento(pJsonArray: TjSonArray): TjSonArray;
    // Dados Básicos Implantação
    Function ImportEan(pJsonArray: TjSonArray): TjSonArray;
    Function ExportFile(const AParams: TDictionary<string, string>): TjSonArray;
    // Coletor
    Function SalvarColetor(pJsonProduto: TJsonObject): TjSonArray;

    // Relatorios
    Function GetRelEnderecamento(AQueryParam: TDictionary<String, String>) : TjSonArray;
    Function GetProdutoList(Const AParams: TDictionary<string, string>) : TjSonArray;
    Function GetProdutoLotes(pProdutoId: Integer; pDescricao: String) : TjSonArray;
    Function GetRelProdutos01(AQueryParam: TDictionary<String, String>) : TjSonArray;
    Function UpdatePicking(pCodProduto : Integer) : TJsonArray;
  end;

implementation

uses uSistemaControl, Constants;

{ TProdutoDao }

constructor TProdutoDao.Create;
begin
  ObjProdutoDAO := TProduto.Create;
  inherited;
end;

destructor TProdutoDao.Destroy;
begin
  ObjProdutoDAO.Free;
  
  inherited;
end;

function TProdutoDao.Delete(pId, pProdutoTipoID: Integer): Boolean;
var
  vSql: String;

  begin
  Result := False;
  try
    vSql := 'Delete from Produto where CodProduto = ' + pId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TProdutoDao.EnderecarProduto(pJsonProduto: TJsonObject): TjSonArray;
begin
  Result := TjSonArray.Create();
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlEnderecarProduto);
    FConexao.Query.ParamByName('pProdutoId').Value := pJsonProduto.GetValue<Integer>
      ('produtoid');
    FConexao.Query.ParamByName('pEnderecoId').Value := pJsonProduto.GetValue<Integer>
      ('enderecoid');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create.AddPair('OK',
      'Endereçamento realizado com sucesso!'));
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TProdutoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Produto') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    While Not FConexao.Query.Eof do
    Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna',
        LowerCase(FConexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo',
        LowerCase(FConexao.Query.FieldByName('Tipo').AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TProdutoDao.ExportarCubagem: TjSonArray;
Var
  xProd: Integer;
  xProduto: Integer;
begin
  Try
    FConexao.Query.Sql.Add('Select * from vProdutoCubagemIntegracao');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('status',
        TJsonNumber.Create(200)).AddPair('produto', TJsonNumber.Create(0))
        .AddPair('mensagem', TuEvolutConst.QrySemDados));

    End
    Else
    Begin
      Result := FConexao.Query.ToJSONArray();
      for xProduto := 0 to Pred(Result.Count) do
      Begin
        FConexao.Query.Close;
        FConexao.Query.Sql.Clear;
        FConexao.Query.Sql.Add('Update ProdutoCubagemIntegracao');
        FConexao.Query.Sql.Add('  Set Status = 1');
        FConexao.Query.Sql.Add
          ('Where ProdutoId = (Select IdProduto From Produto Where CodProduto ='
          + Result.Items[xProduto].GetValue<String>('codproduto') + ')');
        FConexao.Query.ExecSQL;
      End;
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TProdutoDao.ExportFile(const AParams: TDictionary<string, string>)
  : TjSonArray;
var
  vSql, pCampos: String;
begin
  try
    if AParams.ContainsKey('campos') then
      pCampos := AParams.Items['campos']
    else
      pCampos := 'CodBarras, CodProduto, Descricao';
    vSql := 'Select ' + pCampos + ' ' + sLineBreak + 'From Produto P ' +
      sLineBreak +
      'Left Join ProdutoCodBarras Pc On Pc.ProdutoId = P.IdProduto';
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
         'Não foram encontrados dados da pesquisa.')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TProdutoDao.GetCodigoERP(pCodigoERP: String): TjSonArray;
begin
  if pCodigoERP = '' then
    pCodigoERP := '0';
  Result := GetId('0', 0, pCodigoERP, nil);
end;

function TProdutoDao.GetDescricao(pNome: String; pProdutoTipoID: Integer;
  AQueryParam: TDictionary<String, String>): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  If AQueryParam.Count > 0 then
  Begin
    if AQueryParam.ContainsKey('RecsMax') then
    begin
      FConexao.Query.FetchOptions.RecsMax := StrToIntDef(AQueryParam.Items['RecsMax'], 5);
      FConexao.Query.FetchOptions.RowsetSize :=
        StrToIntDef(AQueryParam.Items['RecsMax'], 5);
    end;
    if AQueryParam.ContainsKey('RecsSkip') then
      FConexao.Query.FetchOptions.RecsSkip :=
        StrToIntDef(AQueryParam.Items['RecsSkip'], 0);
  End;

  try
    if pNome = '*' then
      pNome := '%';
    vSql := 'Select P.*, (Select Top 1 CodBarras From ProdutoCodBarras where ProdutoId = P.IdProduto Order by Principal Desc) As EanPrincipal'
      + sLineBreak + 'From vProduto P ' + sLineBreak + 'where (Descricao like '
      + QuotedStr('%' + pNome + '%') + ') or (DescrReduzida like ' +
      QuotedStr('%' + pNome + '%') + ') ';
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não foram encontrados dados da pesquisa.')))
    Else
      while Not FConexao.Query.Eof do
      Begin
        ObjProdutoDAO.IdProduto := FConexao.Query.FieldByName('IdProduto').AsInteger;
        ObjProdutoDAO.CodProduto := FConexao.Query.FieldByName('CodProduto').AsInteger;
        ObjProdutoDAO.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
        ObjProdutoDAO.DescricaoRed := FConexao.Query.FieldByName('DescrReduzida')
          .AsString;
        ObjProdutoDAO.CodigoMS := FConexao.Query.FieldByName('CodigoMS').AsString;
        // ObjProdutoDAO.ProdutoControle.IdControle := FConexao.Query.FieldByName('IdControle').AsInteger;
        // ObjProdutoDAO.ProdutoControle.Descricao  := FConexao.Query.FieldByName('DescrControle').AsString;
        // ObjProdutoDAO.ProdutoControle.Status     := FConexao.Query.FieldByName('StatusControle').AsInteger;
        // Substituir Anterior por este
        ObjProdutoDAO.Rastro.RastroId := FConexao.Query.FieldByName('RastroId').AsInteger;
        ObjProdutoDAO.Rastro.Descricao :=
          FConexao.Query.FieldByName('RastroDescricao').AsString;
        ObjProdutoDAO.Rastro.Status := FConexao.Query.FieldByName('RastroStatus')
          .AsInteger;

        // JSon ProdutoTipo
        ObjProdutoDAO.ProdutoTipo.Id := FConexao.Query.FieldByName('ProdutoTipoId')
          .AsInteger;
        ObjProdutoDAO.ProdutoTipo.Descricao :=
          FConexao.Query.FieldByName('ProdutoTipoDescricao').AsString;
        ObjProdutoDAO.ProdutoTipo.Status :=
          FConexao.Query.FieldByName('ProdutoTipoStatus').AsInteger;

        ObjProdutoDAO.Unid.Id := FConexao.Query.FieldByName('UnidadeId').AsInteger;
        ObjProdutoDAO.Unid.Descricao :=
          FConexao.Query.FieldByName('UnidadeDescricao').AsString;
        ObjProdutoDAO.Unid.Sigla := FConexao.Query.FieldByName('UnidadeSigla').AsString;
        ObjProdutoDAO.Unid.Status := FConexao.Query.FieldByName('UnidadeStatus')
          .AsInteger;
        ObjProdutoDAO.QtdUnid := FConexao.Query.FieldByName('QtdUnid').AsInteger;
        ObjProdutoDAO.UnidSecundaria.Id :=
          FConexao.Query.FieldByName('UnidadeSecundariaId').AsInteger;
        ObjProdutoDAO.UnidSecundaria.Descricao :=
          FConexao.Query.FieldByName('UnidadeSecundariaDescricao').AsString;
        ObjProdutoDAO.UnidSecundaria.Sigla :=
          FConexao.Query.FieldByName('UnidadeSecundariaSigla').AsString;
        ObjProdutoDAO.UnidSecundaria.Status :=
          FConexao.Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
        ObjProdutoDAO.FatorConversao := FConexao.Query.FieldByName('FatorConversao')
          .AsInteger;
        ObjProdutoDAO.SomenteCxaFechada := FConexao.Query.FieldByName('SomenteCxaFechada')
          .AsInteger;
        ObjProdutoDAO.Endereco.EnderecoId := FConexao.Query.FieldByName('EnderecoId')
          .AsInteger;
        ObjProdutoDAO.Endereco.Descricao :=
          FConexao.Query.FieldByName('EnderecoDescricao').AsString;
        ObjProdutoDAO.Endereco.EnderecoEstrutura.EstruturaId :=
          FConexao.Query.FieldByName('EstruturaId').AsInteger;
        ObjProdutoDAO.Endereco.EnderecoEstrutura.Descricao :=
          FConexao.Query.FieldByName('EstruturaDescricao').AsString;
        ObjProdutoDAO.Endereco.EnderecoEstrutura.Mascara :=
          FConexao.Query.FieldByName('mascara').AsString;
        ObjProdutoDAO.Endereco.EnderecamentoZona.ZonaId :=
          FConexao.Query.FieldByName('ZonaId').AsInteger;
        ObjProdutoDAO.Endereco.EnderecamentoZona.Descricao :=
          FConexao.Query.FieldByName('ZonaDescricao').AsString;
        ObjProdutoDAO.EnderecamentoZona.Status := FConexao.Query.FieldByName('ZonaStatus')
          .AsInteger;
        ObjProdutoDAO.Endereco.DesenhoArmazem.Id :=
          FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        ObjProdutoDAO.Endereco.DesenhoArmazem.Descricao :=
          FConexao.Query.FieldByName('DesenhoArmazemDescricao').AsString;
        ObjProdutoDAO.Endereco.DesenhoArmazem.Status :=
          FConexao.Query.FieldByName('DesenhoArmazemStatus').AsInteger;
        ObjProdutoDAO.Importado := FConexao.Query.FieldByName('Importado').AsInteger = 1;
        ObjProdutoDAO.MedicamentoTipo.Id :=
          FConexao.Query.FieldByName('MedicamentoTipoId').AsInteger;
        ObjProdutoDAO.MedicamentoTipo.Descricao :=
          FConexao.Query.FieldByName('MedicamentoTipoDescricao').AsString;
        ObjProdutoDAO.SNGPC := FConexao.Query.FieldByName('SNGPC').AsInteger = 1;

        // ObjProdutoDAO.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
        // ObjProdutoDAO.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
        ObjProdutoDAO.Laboratorio.IdLaboratorio :=
          FConexao.Query.FieldByName('LaboratorioId').AsInteger;
        ObjProdutoDAO.Laboratorio.Nome :=
          FConexao.Query.FieldByName('LaboratorioNome').AsString;
        ObjProdutoDAO.Peso := FConexao.Query.FieldByName('PesoLiquido').AsInteger;
        ObjProdutoDAO.Liquido := FConexao.Query.FieldByName('Liquido').AsInteger = 1;
        ObjProdutoDAO.Perigoso := FConexao.Query.FieldByName('Perigoso').AsInteger = 1;
        ObjProdutoDAO.Inflamavel := FConexao.Query.FieldByName('Inflamavel')
          .AsInteger = 1;
        ObjProdutoDAO.Medicamento := FConexao.Query.FieldByName('Medicamento')
          .AsInteger = 1;
        ObjProdutoDAO.SNGPC := FConexao.Query.FieldByName('Sngpc').AsInteger = 1;
        ObjProdutoDAO.Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        ObjProdutoDAO.Largura := FConexao.Query.FieldByName('Largura').AsFloat;
        ObjProdutoDAO.Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        ObjProdutoDAO.MinPicking := FConexao.Query.FieldByName('MinPicking').AsInteger;
        ObjProdutoDAO.MaxPicking := FConexao.Query.FieldByName('MaxPicking').AsInteger;
        ObjProdutoDAO.QtdReposicao := FConexao.Query.FieldByName('QtdReposicao')
          .AsInteger;
        ObjProdutoDAO.PercReposicao := FConexao.Query.FieldByName('PercReposicao')
          .AsInteger;
        ObjProdutoDAO.MesEntradaMinima := FConexao.Query.FieldByName('MesEntradaMinima')
          .AsInteger;
        ObjProdutoDAO.MesSaidaMinima := FConexao.Query.FieldByName('MesSaidaMinima')
          .AsInteger;
        ObjProdutoDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoDAO));
        // (ObjProdutoDAO.ClassToJson(ObjProdutoDAO).ToString);
        FConexao.Query.Next;
      End;
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TProdutoDao.GetId(pId: String; pProdutoTipoID: Integer;
  pCodigoERP: String; AQueryParam: TDictionary<String, String>): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  If assigned(AQueryParam) and (AQueryParam.Count > 0) then
  Begin
    if AQueryParam.ContainsKey('RecsMax') then
    begin
      FConexao.Query.FetchOptions.RecsMax := StrToIntDef(AQueryParam.Items['RecsMax'], 5);
      FConexao.Query.FetchOptions.RowsetSize :=
        StrToIntDef(AQueryParam.Items['RecsMax'], 5);
    end;
    if AQueryParam.ContainsKey('RecsSkip') then
      FConexao.Query.FetchOptions.RecsSkip := StrToIntDef(AQueryParam.Items['RecsSkip'],
        0) * StrToIntDef(AQueryParam.Items['RecsMax'], 5)
    Else
      FConexao.Query.FetchOptions.RecsSkip := 0;
  End;
  try
    if (pId <> '0') or (pCodigoERP <> '0') then
      vSql := 'select Top 1 Vp.*, (Select Top 1 CodBarras From ProdutoCodBarras '
        + sLineBreak +
        'where ProdutoId = Vp.IdProduto Order by Principal Desc) As EanPrincipal '
        + sLineBreak + 'From vproduto Vp WITH (READUNCOMMITTED) ' + sLineBreak +
        'Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Vp.IdProduto'
    Else
      vSql := 'select Vp.*, (Select Top 1 CodBarras From ProdutoCodBarras WITH (READUNCOMMITTED) where ProdutoId = Vp.IdProduto Order by Principal Desc) As EanPrincipal'
        + sLineBreak + 'From vproduto Vp WITH (READUNCOMMITTED) ';
    if pId <> '0' then
    Begin
      vSql := vSql +
        ' where Vp.IdProduto = @IdProduto or Cb.CodBarras = @CodBarras';
      FConexao.Query.Sql.Add('Declare @IdProduto Bigint      = :pIdProduto');
      FConexao.Query.Sql.Add('Declare @CodBarras VarChar(25) = :pCodBarras');
      FConexao.Query.Sql.Add(vSql);
      FConexao.Query.ParamByName('pIdProduto').Value := pId.ToInt64;
      FConexao.Query.ParamByName('pCodBarras').Value := pId;
    End
    Else if pCodigoERP <> '0' then
    Begin
      vSql := vSql +
        ' where (@CodProduto <> 0 and @CodProduto = Vp.CodProduto) or ' +
        sLineBreak + '(Cb.CodBarras = @CodBarras)';
      FConexao.Query.Sql.Add('Declare @CodProduto Integer    = :pCodProduto');
      FConexao.Query.Sql.Add('Declare @CodBarras VarChar(25) = :pCodBarras');
      FConexao.Query.Sql.Add(vSql);
      FConexao.Query.ParamByName('pCodProduto').Value := StrToIntDef(pCodigoERP, 0);
      FConexao.Query.ParamByName('pCodBarras').Value := pCodigoERP;
    End;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não foram encontrados dados da pesquisa.')))
    Else
      While Not FConexao.Query.Eof do
      Begin
        ObjProdutoDAO.IdProduto := FConexao.Query.FieldByName('IdProduto').AsInteger;
        ObjProdutoDAO.CodProduto := FConexao.Query.FieldByName('CodProduto').AsInteger;
        ObjProdutoDAO.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
        ObjProdutoDAO.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
        ObjProdutoDAO.DescricaoRed := FConexao.Query.FieldByName('DescrReduzida')
          .AsString;
        ObjProdutoDAO.CodigoMS := FConexao.Query.FieldByName('CodigoMS').AsString;

        // ObjProdutoDAO.ProdutoControle.IdControle := FConexao.Query.FieldByName('IdControle').AsInteger;
        // ObjProdutoDAO.ProdutoControle.Descricao  := FConexao.Query.FieldByName('DescrControle').AsString;
        // ObjProdutoDAO.ProdutoControle.Status     := FConexao.Query.FieldByName('StatusControle').AsInteger;
        ObjProdutoDAO.Rastro.RastroId := FConexao.Query.FieldByName('RastroId').AsInteger;
        ObjProdutoDAO.Rastro.Descricao :=
          FConexao.Query.FieldByName('RastroDescricao').AsString;
        ObjProdutoDAO.Rastro.Status := FConexao.Query.FieldByName('RastroStatus')
          .AsInteger;

        // JSon ProdutoTipo
        ObjProdutoDAO.ProdutoTipo.Id := FConexao.Query.FieldByName('ProdutoTipoId')
          .AsInteger;
        ObjProdutoDAO.ProdutoTipo.Descricao :=
          FConexao.Query.FieldByName('ProdutoTipoDescricao').AsString;
        ObjProdutoDAO.ProdutoTipo.Status :=
          FConexao.Query.FieldByName('ProdutoTipoStatus').AsInteger;

        ObjProdutoDAO.Unid.Id := FConexao.Query.FieldByName('UnidadeId').AsInteger;
        ObjProdutoDAO.Unid.Descricao :=
          FConexao.Query.FieldByName('UnidadeDescricao').AsString;
        ObjProdutoDAO.Unid.Sigla := FConexao.Query.FieldByName('UnidadeSigla').AsString;
        ObjProdutoDAO.Unid.Status := FConexao.Query.FieldByName('UnidadeStatus')
          .AsInteger;
        ObjProdutoDAO.QtdUnid := FConexao.Query.FieldByName('QtdUnid').AsInteger;
        ObjProdutoDAO.UnidSecundaria.Id :=
          FConexao.Query.FieldByName('UnidadeSecundariaId').AsInteger;
        ObjProdutoDAO.UnidSecundaria.Descricao :=
          FConexao.Query.FieldByName('UnidadeSecundariaDescricao').AsString;
        ObjProdutoDAO.UnidSecundaria.Sigla :=
          FConexao.Query.FieldByName('UnidadeSecundariaSigla').AsString;
        ObjProdutoDAO.UnidSecundaria.Status :=
          FConexao.Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
        ObjProdutoDAO.FatorConversao := FConexao.Query.FieldByName('FatorConversao')
          .AsInteger;
        ObjProdutoDAO.SomenteCxaFechada := FConexao.Query.FieldByName('SomenteCxaFechada')
          .AsInteger;
        // Enderecamento de Picking
        ObjProdutoDAO.Endereco.EnderecoId := FConexao.Query.FieldByName('EnderecoId')
          .AsInteger;
        ObjProdutoDAO.Endereco.Descricao :=
          FConexao.Query.FieldByName('EnderecoDescricao').AsString;
        ObjProdutoDAO.Endereco.EnderecoEstrutura.EstruturaId :=
          FConexao.Query.FieldByName('EstruturaId').AsInteger;
        ObjProdutoDAO.Endereco.EnderecoEstrutura.Descricao :=
          FConexao.Query.FieldByName('EstruturaDescricao').AsString;
        ObjProdutoDAO.Endereco.EnderecoEstrutura.Mascara :=
          FConexao.Query.FieldByName('mascara').AsString;
        ObjProdutoDAO.Endereco.EnderecoRua.RuaId := FConexao.Query.FieldByName('RuaId')
          .AsInteger;
        ObjProdutoDAO.Endereco.EnderecoRua.Descricao :=
          FConexao.Query.FieldByName('RuaDescricao').AsString;
        ObjProdutoDAO.Endereco.EnderecoRua.Lado :=
          FConexao.Query.FieldByName('RuaLado').AsString;
        ObjProdutoDAO.Endereco.EnderecoRua.Ordem := FConexao.Query.FieldByName('RuaOrdem')
          .AsInteger;
        ObjProdutoDAO.Endereco.EnderecoRua.Status :=
          FConexao.Query.FieldByName('RuaStatus').AsInteger;
        ObjProdutoDAO.Endereco.Status := FConexao.Query.FieldByName('EnderecoStatus')
          .AsInteger;
        // Zona do Endereco
        ObjProdutoDAO.Endereco.EnderecamentoZona.ZonaId :=
          FConexao.Query.FieldByName('zonaid').AsInteger;
        ObjProdutoDAO.Endereco.EnderecamentoZona.Descricao :=
          FConexao.Query.FieldByName('zonadescricao').AsString;
        ObjProdutoDAO.Endereco.EnderecamentoZona.EstoqueTipoId :=
          FConexao.Query.FieldByName('EstoqueTipoId').AsInteger;
        ObjProdutoDAO.Endereco.EnderecamentoZona.RastroId :=
          FConexao.Query.FieldByName('ZonaRastroId').AsInteger;
        ObjProdutoDAO.Endereco.EnderecamentoZona.LoteReposicao :=
          FConexao.Query.FieldByName('LoteReposicao').AsInteger;
        ObjProdutoDAO.Endereco.EnderecamentoZona.SeparacaoConsolidada :=
          FConexao.Query.FieldByName('SeparacaoConsolidada').AsInteger;
        ObjProdutoDAO.Endereco.EnderecamentoZona.ProdutoSNGPC :=
          FConexao.Query.FieldByName('ProdutoSNGPC').AsInteger;

        ObjProdutoDAO.EnderecamentoZona.Status := FConexao.Query.FieldByName('zonastatus')
          .AsInteger;
        // Incluir Dados adicionais da Zona - ver select GSS em 09012021
        ObjProdutoDAO.Endereco.DesenhoArmazem.Id :=
          FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        ObjProdutoDAO.Endereco.DesenhoArmazem.Descricao :=
          FConexao.Query.FieldByName('DesenhoArmazemDescricao').AsString;
        ObjProdutoDAO.Endereco.DesenhoArmazem.Status :=
          FConexao.Query.FieldByName('DesenhoArmazemStatus').AsInteger;
        // Zona de Armazenamento
        ObjProdutoDAO.EnderecamentoZona.ZonaId :=
          FConexao.Query.FieldByName('armazenamentozonaid').AsInteger;
        ObjProdutoDAO.EnderecamentoZona.Descricao :=
          FConexao.Query.FieldByName('armazenamentozona').AsString;
        ObjProdutoDAO.EnderecamentoZona.Status :=
          FConexao.Query.FieldByName('armazenamentozonastatus').AsInteger;

        ObjProdutoDAO.Importado := FConexao.Query.FieldByName('Importado').AsInteger = 1;
        ObjProdutoDAO.MedicamentoTipo.Id :=
          FConexao.Query.FieldByName('MedicamentoTipoId').AsInteger;
        ObjProdutoDAO.MedicamentoTipo.Descricao :=
          FConexao.Query.FieldByName('MedicamentoTipoDescricao').AsString;
        ObjProdutoDAO.SNGPC := FConexao.Query.FieldByName('SNGPC').AsInteger = 1;

        // ObjProdutoDAO.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
        // ObjProdutoDAO.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
        ObjProdutoDAO.Laboratorio.IdLaboratorio :=
          FConexao.Query.FieldByName('LaboratorioId').AsInteger;
        ObjProdutoDAO.Laboratorio.Nome :=
          FConexao.Query.FieldByName('LaboratorioNome').AsString;
        ObjProdutoDAO.Peso := FConexao.Query.FieldByName('PesoLiquido').AsFloat;
        ObjProdutoDAO.Liquido := FConexao.Query.FieldByName('Liquido').AsInteger = 1;
        ObjProdutoDAO.Perigoso := FConexao.Query.FieldByName('Perigoso').AsInteger = 1;
        ObjProdutoDAO.Inflamavel := FConexao.Query.FieldByName('Inflamavel')
          .AsInteger = 1;
        ObjProdutoDAO.Medicamento := FConexao.Query.FieldByName('Medicamento')
          .AsInteger = 1;
        ObjProdutoDAO.SNGPC := FConexao.Query.FieldByName('Sngpc').AsInteger = 1;
        ObjProdutoDAO.Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        ObjProdutoDAO.Largura := FConexao.Query.FieldByName('Largura').AsFloat;
        ObjProdutoDAO.Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        ObjProdutoDAO.QtdReposicao := FConexao.Query.FieldByName('QtdReposicao')
          .AsInteger;
        ObjProdutoDAO.PercReposicao := FConexao.Query.FieldByName('PercReposicao')
          .AsInteger;
        ObjProdutoDAO.MinPicking := FConexao.Query.FieldByName('MinPicking').AsInteger;
        ObjProdutoDAO.MaxPicking := FConexao.Query.FieldByName('MaxPicking').AsInteger;
        ObjProdutoDAO.MesEntradaMinima := FConexao.Query.FieldByName('MesEntradaMinima')
          .AsInteger;
        ObjProdutoDAO.MesSaidaMinima := FConexao.Query.FieldByName('MesSaidaMinima')
          .AsInteger;
        ObjProdutoDAO.Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoDAO));
        // (ObjProdutoDAO.ClassToJson(ObjProdutoDAO).ToString);
        FConexao.Query.Next;
      End;
  Except
    On E: Exception do
    Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TProdutoDao.GetId4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Try
    Result := TJsonObject.Create();
    QryPesquisa := FConexao.GetQuery;
    QryPesquisa.Sql.Add
      ('select IdProduto, CodProduto, Descricao, UnidadeSecundariaSigla, FatorConversao, SomenteCxaFechada, EnderecoDescricao, RastroDescricao, Status From vProduto where 1 = 1');
    QryRecordCount := FConexao.GetQuery;
    QryRecordCount.Sql.Add
      ('Select Count(IdProduto) cReg From vProduto where 1=1');
    if AParams.ContainsKey('produtoid') then
    begin
      QryPesquisa.Sql.Add('and IdProduto = :Produtoid');
      QryPesquisa.ParamByName('ProdutoId').AsLargeInt :=
        AParams.Items['produtoid'].ToInt64;
      QryRecordCount.Sql.Add('and IdProduto = :ProdutoId');
      QryRecordCount.ParamByName('ProdutoId').AsLargeInt :=
        AParams.Items['produtoid'].ToInt64;
    end;
    if AParams.ContainsKey('codproduto') then
    begin
      QryPesquisa.Sql.Add('and codproduto = :codproduto');
      QryPesquisa.ParamByName('codproduto').AsLargeInt :=
        AParams.Items['codproduto'].ToInt64;
      QryRecordCount.Sql.Add('and codproduto = :codproduto');
      QryRecordCount.ParamByName('codproduto').AsLargeInt :=
        AParams.Items['codproduto'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then
    begin
      QryPesquisa.Sql.Add('and descricao like :descricao');
      QryPesquisa.ParamByName('descricao').AsString := '%' + AParams.Items
        ['descricao'].ToUpper + '%';
      QryRecordCount.Sql.Add('and descricao like :descricao');
      QryRecordCount.ParamByName('descricao').AsString := '%' + AParams.Items['descricao'].ToUpper + '%';
    end;
    if AParams.ContainsKey('limit') then begin
      QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
      QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    end;
    if AParams.ContainsKey('offset') then
      QryPesquisa.FetchOptions.RecsSkip   := StrToIntDef(AParams.Items['offset'], 0);
    QryPesquisa.Sql.Add('order by Descricao');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.ToJSONArray());
    QryRecordCount.Open();
    Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Finally
    QryPesquisa.Close;
    QryRecordCount.Close;
  End;
end;

function TProdutoDao.GetProdutoList(const AParams: TDictionary<string, string>) : TjSonArray;
begin
  FConexao.Query.Sql.Add(TuEvolutConst.SqlGetProdutoList);
  if AParams.ContainsKey('produtoid') then
    FConexao.Query.ParamByName('pProdutoId').Value := AParams.Items['produtoid']
      .ToInteger()
  Else
    FConexao.Query.ParamByName('pProdutoId').Value := 0;
  if AParams.ContainsKey('codigoerp') then
    FConexao.Query.ParamByName('pCodigoERP').Value := AParams.Items['codigoerp']
      .ToInteger()
  Else
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;
  if AParams.ContainsKey('enderecoid') then
    FConexao.Query.ParamByName('pEnderecoId').Value := AParams.Items['enderecoid']
      .ToInteger()
  Else
    FConexao.Query.ParamByName('pEnderecoId').Value := 0;
  if AParams.ContainsKey('zonaid') then
    FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
  Else
    FConexao.Query.ParamByName('pZonaId').Value := 0;
  if AParams.ContainsKey('ean') then
    FConexao.Query.ParamByName('pEan').Value := AParams.Items['ean']
  Else
    FConexao.Query.ParamByName('pEan').Value := '';
  if DebugHook <> 0 then
    FConexao.Query.Sql.SaveToFile('GetProdutoList.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados para a pesquisa.'));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TProdutoDao.GetProdutoLotes(pProdutoId: Integer; pDescricao: String)
  : TjSonArray;
begin
  FConexao.Query.Sql.Add('Declare @Produtoid Integer = ' + pProdutoId.ToString());
  FConexao.Query.Sql.Add('Declare @descricao VarChar(30) = ' + QuotedStr(pDescricao));
  FConexao.Query.Sql.Add
    ('select Pl.produtoid, Prd.codproduto codigoerp, Pl.loteid, pl.descrlote, ');
  FConexao.Query.Sql.Add('       FORMAT(Dv.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') vencimento, FORMAT(Df.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') Fabricacao');
  FConexao.Query.Sql.Add('from ProdutoLotes Pl');
  FConexao.Query.Sql.Add('Inner Join Rhema_Data DF on DF.IdData = Pl.Fabricacao');
  FConexao.Query.Sql.Add('Inner Join Rhema_Data DV on Dv.IdData = Pl.Vencimento');
  FConexao.Query.Sql.Add('Inner join Produto Prd On Prd.IdProduto = Pl.Produtoid');
  FConexao.Query.Sql.Add('where (Pl.Produtoid = @ProdutoId)');
  FConexao.Query.Sql.Add('      and (Pl.DescrLote like @Descricao)');
  If DebugHook <> 0 then
    FConexao.Query.Sql.SaveToFile('ProdutoLotes.Sql');
  FConexao.Query.Open;
  if FConexao.Query.IsEmpty then Begin
     Result := TjSonArray.Create();
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para relatório de endereçamento.'));
  End
  else
    Result := FConexao.Query.ToJSONArray();
end;

function TProdutoDao.GetRelEnderecamento(AQueryParam
  : TDictionary<String, String>): TjSonArray;
var
  JsonCargas: TJsonObject;
begin
  FConexao.Query.Sql.Add(TuEvolutConst.SqlRelProdutoEnderecamento);
  FConexao.Query.Sql.Add('Where 1 = 1');
  if AQueryParam.ContainsKey('produtoid') then
  begin
    FConexao.Query.Sql.Add('and Prd.IdProduto = :ProdutoId');
    FConexao.Query.ParamByName('produtoid').AsLargeInt := AQueryParam.Items
      ['produtoid'].ToInt64;
  end;
  if AQueryParam.ContainsKey('codprodutoerp') then
  begin
    FConexao.Query.Sql.Add('and Prd.codproduto = :codprodutoerp');
    FConexao.Query.ParamByName('codprodutoerp').AsLargeInt := AQueryParam.Items
      ['codprodutoerp'].ToInt64;
  end;
  if AQueryParam.ContainsKey('zonaid') then
  begin
    FConexao.Query.Sql.Add('and Z.ZonaId = :zonaid');
    FConexao.Query.ParamByName('zonaid').AsLargeInt := AQueryParam.Items
      ['zonaid'].ToInt64;
  end;
  if AQueryParam.ContainsKey('zona') then
  begin
    FConexao.Query.Sql.Add('and Z.Zona Like :zona');
    FConexao.Query.ParamByName('zona').AsString := AQueryParam.Items['zona'];
  end;
  if AQueryParam.ContainsKey('enderecado') then
  begin
    if AQueryParam.Items['enderecado'] = '1' then
      FConexao.Query.Sql.Add('and Prd.EnderecoId Is Not Null')
    Else
      FConexao.Query.Sql.Add('and Prd.EnderecoId Is Null');
  end;
  FConexao.Query.Sql.Add('Order by Z.Descricao, Prd.Descricao');
  FConexao.Query.Open;
  if FConexao.Query.IsEmpty then Begin
     Result := TjSonArray.Create();
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para relatório de endereçamento.'));
  End
  else
    Result := FConexao.Query.ToJSONArray();
end;

function TProdutoDao.GetRelProdutos01(AQueryParam: TDictionary<String, String>)
  : TjSonArray;
var
  JsonCargas: TJsonObject;
  pEstoque, pSemPicking, pCodProduto, pZonaId, pLaboratorioId: Integer;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetRelProdutos01);
    If DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelProdutos01.Sql');
    if AQueryParam.ContainsKey('estoque') then
      FConexao.Query.ParamByName('pEstoque').Value := AQueryParam.Items['estoque']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pEstoque').Value := 0;
    if AQueryParam.ContainsKey('sempicking') then
      FConexao.Query.ParamByName('pSemPicking').Value := AQueryParam.Items['sempicking']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pSemPicking').Value := 0;
    if AQueryParam.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value := AQueryParam.Items['codproduto']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if AQueryParam.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := AQueryParam.Items['zonaid'].ToInteger
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    if AQueryParam.ContainsKey('laboratorioid') then
      FConexao.Query.ParamByName('pLaboratorioId').Value := AQueryParam.Items
        ['laboratorioid'].ToInteger
    Else
      FConexao.Query.ParamByName('pLaboratorioId').Value := 0;
    if AQueryParam.ContainsKey('listaean') then
      FConexao.Query.ParamByName('plistaean').Value := AQueryParam.Items['listaean']
        .ToInteger
    Else
      FConexao.Query.ParamByName('plistaean').Value := 0;
    if AQueryParam.ContainsKey('status') then
      FConexao.Query.ParamByName('pStatus').Value := AQueryParam.Items['status'].ToInteger
    Else
      FConexao.Query.ParamByName('pStatus').Value := 99;
    if AQueryParam.ContainsKey('somentecxafechada') then
      FConexao.Query.ParamByName('psomentecxafechada').Value := AQueryParam.Items
        ['somentecxafechada'].ToInteger
    Else
      FConexao.Query.ParamByName('psomentecxafechada').Value := 0;
    if AQueryParam.ContainsKey('ativo') then
      FConexao.Query.ParamByName('pAtivo').Value := AQueryParam.Items['ativo'].ToInteger
    Else
      FConexao.Query.ParamByName('pAtivo').Value := 0;
    if AQueryParam.ContainsKey('bloqueado') then
      FConexao.Query.ParamByName('pBloqueado').Value := AQueryParam.Items['bloqueado'].ToInteger
    Else
      FConexao.Query.ParamByName('pBloqueado').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelProdutos01.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create();
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para relatório de endereçamento.'));
    End
    else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TProdutoDao.GetCodProduto(pCodProduto: String): TJsonObject;
var
  IndexConn: Integer;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetProduto);
    FConexao.Query.ParamByName('pProdutoid').Value := pCodProduto;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('produtoid', TJsonNumber.Create(0));
      Result.AddPair('codproduto', TJsonNumber.Create(0));
      Result.AddPair('descricao', '');
      Result.AddPair('eanprincipal', '');
      Result.AddPair('ean', '');
      Result.AddPair('endereco', '');
    End
    Else
    Begin
      Result := TJsonObject.Create;
      Result.AddPair('produtoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('Produtoid').AsLargeInt));
      Result.AddPair('codproduto',
        TJsonNumber.Create(FConexao.Query.FieldByName('CodProduto').AsLargeInt));
      Result.AddPair('descricao', FConexao.Query.FieldByName('Descricao').AsString);
      Result.AddPair('eanprincipal', FConexao.Query.FieldByName('EanPrincipal').AsString);
      Result.AddPair('ean', FConexao.Query.FieldByName('Ean').AsString);
      Result.AddPair('endereco', FConexao.Query.FieldByName('Endereco').AsString);
      // Result := TjsonObject.Create;
      // Result := vQry.ToJSONObject;
    End;
  Except
    ON E: Exception do
    Begin
      FConexao.Query.Close;
      FConexao.Query.Sql.Add('-- pProdutoid = ' + pCodProduto);
      If DebugHook <> 0 then
        FConexao.Query.Sql.SaveToFile('ErroEan.Sql');
    end;
  end;
end;

function TProdutoDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TProdutoDao.Import(pJsonArray: TjSonArray): TjSonArray;
Var
  xProd: Integer;
begin
  Result := TjSonArray.Create();
  for xProd := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      SalvarLaboratorio(pJsonArray.Items[xProd].GetValue<TJsonObject>
        ('fabricante').GetValue<Integer>('id'),
        pJsonArray.Items[xProd].GetValue<TJsonObject>('fabricante')
        .GetValue<String>('nome'), '', '', '');
      SalvarUnidades(pJsonArray.Items[xProd].GetValue<TJsonObject>
        ('embalagemprimaria').GetValue<String>('sigla'),
        pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemprimaria')
        .GetValue<String>('descricao'));
      SalvarUnidades(pJsonArray.Items[xProd].GetValue<TJsonObject>
        ('embalagemsecundaria').GetValue<String>('sigla'),
        pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemsecundaria')
        .GetValue<String>('descricao'));
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add(TuEvolutConst.SqlInsProduto);
      FConexao.Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('produtoid');
      FConexao.Query.ParamByName('pDescricao').Value := pJsonArray.Items[xProd]
        .GetValue<String>('descricao');
      FConexao.Query.ParamByName('pSiglaUnidPrimaria').Value := pJsonArray.Items[xProd]
        .GetValue<TJsonObject>('embalagemprimaria').GetValue<String>('sigla');
      FConexao.Query.ParamByName('pQtdUnidPrimaria').Value := pJsonArray.Items[xProd]
        .GetValue<TJsonObject>('embalagemprimaria')
        .GetValue<Integer>('qtdembalagem');
      FConexao.Query.ParamByName('pSiglaUnidSecundaria').Value := pJsonArray.Items[xProd]
        .GetValue<TJsonObject>('embalagemsecundaria').GetValue<String>('sigla');
      FConexao.Query.ParamByName('pFatorConversao').Value := pJsonArray.Items[xProd]
        .GetValue<TJsonObject>('embalagemsecundaria')
        .GetValue<Integer>('qtdembalagem') / pJsonArray.Items[xProd]
        .GetValue<TJsonObject>('embalagemprimaria')
        .GetValue<Integer>('qtdembalagem');
      FConexao.Query.ParamByName('pLaboratorioId').Value := pJsonArray.Items[xProd]
        .GetValue<TJsonObject>('fabricante').GetValue<Integer>('id');
      FConexao.Query.ParamByName('pPeso').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('peso');
      FConexao.Query.ParamByName('pLiquido').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('liquido');
      FConexao.Query.ParamByName('pPerigoso').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('perigoso');
      FConexao.Query.ParamByName('pInflamavel').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('inflamavel');
      FConexao.Query.ParamByName('pAltura').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('altura');
      FConexao.Query.ParamByName('pLargura').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('largura');
      FConexao.Query.ParamByName('pComprimento').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('comprimento');
      FConexao.Query.ParamByName('pEan').Value := pJsonArray.Items[xProd]
        .GetValue<String>('ean');
      FConexao.Query.ExecSQL;
      if pJsonArray.Items[xProd].GetValue<String>('ean') <> '' then
        SalvarProdutoCodbarras(pJsonArray.Items[xProd].GetValue<Integer>
          ('produtoid'), pJsonArray.Items[xProd].GetValue<String>('ean'));
      Result.AddElement(TJsonObject.Create.AddPair(pJsonArray.Items[xProd]
        .GetValue<Integer>('produtoid').ToString(),
        'Cadastro de produto realizado com sucesso!'));
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair(pJsonArray.Items[xProd]
          .GetValue<Integer>('produtoid').ToString(), E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.ImportCubagem(pJsonArray: TjSonArray): TjSonArray;
Var
  xProd: Integer;
begin
  Result := TjSonArray.Create();
  For xProd := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
      FConexao.Query.Sql.Add('Declare @Altura float = :pAltura');
      FConexao.Query.Sql.Add('Declare @Largura Float = :pLargura');
      FConexao.Query.Sql.Add('Declare @Comprimento Float = :pComprimento');
      FConexao.Query.Sql.Add('Declare @Peso Float = :pPeso');
      FConexao.Query.Sql.Add('Declare @FatorConversao Float = :pFatorConversao');
      FConexao.Query.Sql.Add('Update Produto Set Altura = @Altura');
      FConexao.Query.Sql.Add('  , Largura = @Largura');
      FConexao.Query.Sql.Add('  , Comprimento = @Comprimento');
      FConexao.Query.Sql.Add('Where CodProduto = @CodProduto');
      FConexao.Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
      FConexao.Query.ParamByName('pAltura').Value := pJsonArray.Items[xProd].GetValue<Double>('altura');
      FConexao.Query.ParamByName('pLargura').Value := pJsonArray.Items[xProd].GetValue<Double>('largura');
      FConexao.Query.ParamByName('pComprimento').Value := pJsonArray.Items[xProd].GetValue<Double>('comprimento');
      FConexao.Query.ParamByName('pPeso').Value := pJsonArray.Items[xProd].GetValue<Double>('peso');
      FConexao.Query.ParamByName('pFatorConversao').Value := pJsonArray.Items[xProd].GetValue<Double>('fatorconversao');
      if Debughook <> 0 then
         FConexao.Query.SaveToFile('Cubagem'+pJsonArray.Items[xProd].GetValue<String>('codproduto')+'Sql');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cubagem de produto ' +
        pJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString +
        ' realizado com sucesso!'));
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.ImportCubagemDC(pJsonArray: TjSonArray): TjSonArray;
Var
  xProd: Integer;
  vListaEan, vCompl: String;
begin
  Result := TjSonArray.Create();
  For xProd := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      vListaEan := '';
      vCompl := '';
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('Declare @FatorConversao Integer = ' + pJsonArray.Items
        [xProd].GetValue<Integer>('fatorconversao').ToString());
      FConexao.Query.Sql.Add('Update Prd');
      FConexao.Query.Sql.Add('   set FatorConversao =  @FatorConversao ');
      FConexao.Query.Sql.Add('     , Altura  = ' + pJsonArray.Items[xProd].GetValue<Integer>('altura').ToString());
      FConexao.Query.Sql.Add('	   , Largura = ' + pJsonArray.Items[xProd].GetValue<Integer>('largura').ToString());
      FConexao.Query.Sql.Add('	   , Comprimento = ' + pJsonArray.Items[xProd].GetValue<Integer>('comprimento').ToString());
      FConexao.Query.Sql.Add('	   , PesoLiquido = ' + pJsonArray.Items[xProd].GetValue<Integer>('peso').ToString());
      FConexao.Query.SQL.Add('     , IdUnidMedIndustrial = 1');
      FConexao.Query.Sql.Add('From Produto Prd');
      FConexao.Query.Sql.Add('Inner join ProdutoCodBarras Pc On Pc.ProdutoId = prd.IdProduto');
      if pJsonArray.Items[xProd].GetValue<String>('ean01') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean01') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean02') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean02') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean03') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean03') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean04') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean04') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean05') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean05') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean06') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean06') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean07') <> '' then Begin
        vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean07') + #39;
        vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean08') <> '' then Begin
         vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean08') + #39;
         vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean09') <> '' then Begin
         vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean09') + #39;
         vCompl := ', ';
      End;
      if pJsonArray.Items[xProd].GetValue<String>('ean10') <> '' then Begin
         vListaEan := vListaEan + vCompl + #39 + pJsonArray.Items[xProd].GetValue<String>('ean10') + #39;
         vCompl := ', ';
      End;
      FConexao.Query.Sql.Add('Where Pc.CodBarras in ( ' + vListaEan + ')');
      If pJsonArray.Items[xProd].GetValue<integer>('somentepadrao', 0) = 1 then
         FConexao.Query.Sql.Add('  And (Prd.Altura=8 and Prd.Largura=8 and Comprimento=8)');
      if DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('CubagemDC'+pJsonArray.Items[xProd].GetValue<String>('codproduto')+'.Sql');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cubagem de produto '+
                        pJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString+' realizado com sucesso!'));
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.ImportDados(pJsonArray: TjSonArray): TjSonArray;
Var xProd: Integer;
begin
  Result := TjSonArray.Create();
  For xProd := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('Declare @CodProduto Integer    = :pCodProduto');
      FConexao.Query.Sql.Add('Declare @Descricao Varchar(80) = :pDescricao');
      FConexao.Query.Sql.Add('Declare @UnidadeSigla Varchar(10)           = :pUnidadeSigla');
      FConexao.Query.Sql.Add('Declare @Unidade Varchar(30)           = :pUnidade');
      FConexao.Query.Sql.Add('Declare @UnidadeSecundariaSigla Varchar(10) = :pUnidadeSecundariaSigla');
      FConexao.Query.Sql.Add('Declare @UnidadeSecundaria Varchar(30) = :pUnidadeSecundaria');
      FConexao.Query.Sql.Add('Declare @UnidadeId Integer           = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSigla), 0)');
      FConexao.Query.Sql.Add('Declare @UnidadeSecundariaId Integer = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSecundariaSigla), 0)');
      FConexao.Query.Sql.Add('Declare @FatorConversao Integer = :pFatorConversao');
      FConexao.Query.Sql.Add('Declare @Fabricante VarChar(50) = :pFabricante');
      FConexao.Query.Sql.Add('Declare @LaboratorioId Integer  = (Select IdLaboratorio From Laboratorios Where CodERP = :pFabricanteId)');
      FConexao.Query.Sql.Add('Declare @Sngpc Integer          = :pSngpc');
      FConexao.Query.Sql.Add('Declare @Curva VarChar(2)       = :pCurva');
      FConexao.Query.Sql.Add('Declare @Liquido integer        = :pLiquido');
      FConexao.Query.Sql.Add('Declare @Inflamavel Integer     = :pInflamavel');
      FConexao.Query.Sql.Add('If @LaboratorioId = 0 Begin');
      FConexao.Query.Sql.Add('    Set @LaboratorioId = 1');
      FConexao.Query.Sql.Add('End;');
      FConexao.Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSigla) Begin');
      FConexao.Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSigla, @Unidade, 1)');
      FConexao.Query.Sql.Add('   Set @UnidadeId = SCOPE_IDENTITY()');
      FConexao.Query.Sql.Add('End;');
      FConexao.Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla) Begin');
      FConexao.Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSecundariaSigla, @UnidadeSecundaria, 1)');
      FConexao.Query.Sql.Add('   Set @UnidadeSecundariaId = SCOPE_IDENTITY()');
      FConexao.Query.Sql.Add('End');
      FConexao.Query.Sql.Add('Else Begin');
      FConexao.Query.Sql.Add('   Set @UnidadeSecundariaId = (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla)');
      FConexao.Query.Sql.Add('End;');

      FConexao.Query.Sql.Add('If Not Exists (Select CodProduto From Produto Where CodProduto = @CodProduto) Begin');
      FConexao.Query.Sql.Add('   Insert Produto (CodProduto, Descricao, DescrReduzida, UnidadeId, QtdUnid, ');
      FConexao.Query.Sql.Add('                   UnidadeSecundariaId, FatorConversao, LaboratorioId, ProdutoTipoId, ');
      FConexao.Query.Sql.Add('                   RastroId, Altura, Largura, Comprimento, PesoLiquido, MesEntradaMinima, ');
      FConexao.Query.Sql.Add('                   MesSaidaMinima, Sngpc, Curva, Liquido, Inflamavel, Uuid, Status) Values');
      FConexao.Query.Sql.Add('          (@CodProduto, @Descricao, SubString(@Descricao, 1, 40), @UnidadeId, 1, @UnidadeSecundariaId, '+
                             '           @FatorConversao, (Select IdLaboratorio From laboratorios ');
      FConexao.Query.Sql.Add('                             Where CodERP = @LaboratorioId), ');
      FConexao.Query.Sql.Add('           1, 3, 8, 8, 8, 1, (Select ShelflifeRecebimento From Configuracao), ');
      FConexao.Query.Sql.Add('           (Select ShelflifeExpedicao From Configuracao),');
      FConexao.Query.Sql.Add('           @Sngpc, @Curva, @Liquido, @Inflamavel, NewId(), 1)');
      FConexao.Query.Sql.Add('End');
      FConexao.Query.Sql.Add('Else Begin;');
      FConexao.Query.Sql.Add('  Update Produto Set ');
      FConexao.Query.Sql.Add('     Descricao      = @Descricao');
      FConexao.Query.Sql.Add('    , DescrReduzida = SubString(@Descricao, 1, 40)');
      FConexao.Query.Sql.Add('    , UnidadeId     = @UnidadeId');
      FConexao.Query.Sql.Add('    , QtdUnid       = 1');
      FConexao.Query.Sql.Add('    , UnidadeSecundariaId = @UnidadeSecundariaId');
      FConexao.Query.Sql.Add('    --, FatorConversao = @FatorConversao');
      FConexao.Query.Sql.Add('    , LaboratorioId  = (Select IdLaboratorio From laboratorios Where CodERP = @LaboratorioId)');
      FConexao.Query.Sql.Add('    , Sngpc          = @Sngpc');
      FConexao.Query.Sql.Add('    , Curva          = @Curva');
      FConexao.Query.Sql.Add('    , Liquido        = @Liquido');
      FConexao.Query.Sql.Add('    , Inflamavel     = @Inflamavel');
      FConexao.Query.Sql.Add('    , Status = 1');
      FConexao.Query.Sql.Add('  Where CodProduto = @CodProduto');
      FConexao.Query.Sql.Add('End;');
      FConexao.Query.Sql.Add('Declare @ProdutoID Integer = 0');
      FConexao.Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
      FConexao.Query.ParamByName('pDescricao').Value := pJsonArray.Items[xProd].GetValue<String>('descricao');
      FConexao.Query.ParamByName('pUnidadeSigla').Value := pJsonArray.Items[xProd].GetValue<String>('unidadesigla', 'UN');
      FConexao.Query.ParamByName('pUnidade').Value := pJsonArray.Items[xProd].GetValue<String>('unidade', 'Unidade');
      FConexao.Query.ParamByName('pUnidadeSecundariaSigla').Value := pJsonArray.Items[xProd].GetValue<String>('unidadesiglacaixamaster', 'UN');
      FConexao.Query.ParamByName('pUnidadeSecundaria').Value := pJsonArray.Items[xProd].GetValue<String>('unidadecaixamaster', 'UNIDADE');
      FConexao.Query.ParamByName('pFatorConversao').Value := pJsonArray.Items[xProd].GetValue<Integer>('qtdembalagemfornecedor');
      FConexao.Query.ParamByName('pFabricanteId').Value := pJsonArray.Items[xProd].GetValue<Integer>('fabricanteid');
      FConexao.Query.ParamByName('pFabricante').Value := pJsonArray.Items[xProd].GetValue<String>('fabricante');
      FConexao.Query.ParamByName('pSngpc').Value := pJsonArray.Items[xProd].GetValue<Integer>('sngpc');
      FConexao.Query.ParamByName('pCurva').Value := pJsonArray.Items[xProd].GetValue<String>('curva');
      FConexao.Query.ParamByName('pLiquido').Value := pJsonArray.Items[xProd].GetValue<String>('liquido');
      FConexao.Query.ParamByName('pInflamavel').Value := pJsonArray.Items[xProd].GetValue<String>('inflamavel');
      if DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('ProdImporta.Sql');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('status', '200')
            .AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xProd].GetValue<Integer>('codproduto')))
            .AddPair('mensagem', 'Produto cadastrado/alterado com sucesso!'));
    Except ON E: Exception do
      Begin
        Raise Exception.Create('Erro: '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.ImportDadosV2(pJsonObjectProduto: TJsonObject): TJsonArray;
Var xProd: Integer;
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @CodProduto Integer       = :pCodProduto');
    FConexao.Query.Sql.Add('Declare @Descricao Varchar(100)   = :pDescricao');
    FConexao.Query.Sql.Add('Declare @UnidadeSigla Varchar(10) = :pUnidadeSigla');
    FConexao.Query.Sql.Add('Declare @Unidade Varchar(30)      = :pUnidade');
    FConexao.Query.Sql.Add('Declare @UnidadeId Integer        = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSigla), 0)');
    FConexao.Query.Sql.Add('Declare @UnidadeSecundariaSigla Varchar(10) = :pUnidadeSecundariaSigla');
    FConexao.Query.Sql.Add('Declare @UnidadeSecundaria Varchar(30)      = :pUnidadeSecundaria');
    FConexao.Query.Sql.Add('Declare @UnidadeSecundariaId Integer        = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSecundariaSigla), 0)');
    FConexao.Query.Sql.Add('Declare @FatorConversao Integer   = :pQtdCaixaMaster');
    FConexao.Query.Sql.Add('Declare @Fabricante VarChar(50)   = :pFabricante');
    FConexao.Query.Sql.Add('Declare @CodERPFabricante Integer = (Select IdLaboratorio From Laboratorios Where CodERP = :pCodERPFabricante)');
    FConexao.Query.Sql.Add('Declare @Sngpc Integer            = :pSngpc');
    FConexao.Query.Sql.Add('Declare @Curva VarChar(2)         = :pCurva');
    FConexao.Query.Sql.Add('Declare @Liquido integer          = :pLiquido');
    FConexao.Query.Sql.Add('Declare @Inflamavel integer       = :pInflamavel');
    FConexao.Query.Sql.Add('Declare @PesoLiquido Integer      = :pPesoLiquido');
    FConexao.Query.Sql.Add('Declare @Altura Integer           = :pAltura');
    FConexao.Query.Sql.Add('Declare @Largura Integer          = :pLargura');
    FConexao.Query.Sql.Add('Declare @Comprimento Integer      = :pComprimento');

    FConexao.Query.Sql.Add('If @CodERPFabricante = 0 Begin');
    FConexao.Query.Sql.Add('    Set @CodERPFabricante = Null');
    FConexao.Query.Sql.Add('End;');
    FConexao.Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSigla) Begin');
    FConexao.Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSigla, @Unidade, 1)');
    FConexao.Query.Sql.Add('   Set @UnidadeId = SCOPE_IDENTITY()');
    FConexao.Query.Sql.Add('End;');
    FConexao.Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla) Begin');
    FConexao.Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSecundariaSigla, @UnidadeSecundaria, 1)');
    FConexao.Query.Sql.Add('   Set @UnidadeSecundariaId = SCOPE_IDENTITY()');
    FConexao.Query.Sql.Add('End');
    FConexao.Query.Sql.Add('Else Begin');
    FConexao.Query.Sql.Add('   Set @UnidadeSecundariaId = (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla)');
    FConexao.Query.Sql.Add('End;');
    FConexao.Query.Sql.Add('If Not Exists (Select CodProduto From Produto Where CodProduto = @CodProduto) Begin');
    FConexao.Query.Sql.Add('   Insert Produto (CodProduto, Descricao, DescrReduzida, UnidadeId, QtdUnid, ');
    FConexao.Query.Sql.Add('                   UnidadeSecundariaId, FatorConversao, LaboratorioId, ProdutoTipoId, ');
    FConexao.Query.Sql.Add('                   RastroId, Altura, Largura, Comprimento, PesoLiquido, MesEntradaMinima, ');
    FConexao.Query.Sql.Add('                   MesSaidaMinima, Sngpc, Curva, Liquido, Inflamavel, Uuid, Status) Values');
    FConexao.Query.Sql.Add('          (@CodProduto, @Descricao, SubString(@Descricao, 1, 40), @UnidadeId, 1, @UnidadeSecundariaId, '+
                           '           @FatorConversao, (Select IdLaboratorio From laboratorios ');
    FConexao.Query.Sql.Add('                             Where CodERP = @CodERPFabricante), ');
    FConexao.Query.Sql.Add('           1, 2, @Altura, @Largura, @Comprimento, @PesoLiquido, (Select ShelflifeRecebimento From Configuracao), ');
    FConexao.Query.Sql.Add('           (Select ShelflifeExpedicao From Configuracao),');
    FConexao.Query.Sql.Add('           @Sngpc, @Curva, @Liquido, @Inflamavel, NewId(), 1)');
    FConexao.Query.Sql.Add('End');
    FConexao.Query.Sql.Add('Else Begin;');
    FConexao.Query.Sql.Add('  Update Produto Set ');
    FConexao.Query.Sql.Add('     Descricao      = @Descricao');
    FConexao.Query.Sql.Add('    , DescrReduzida = SubString(@Descricao, 1, 40)');
    FConexao.Query.Sql.Add('    , UnidadeId     = @UnidadeId');
    FConexao.Query.Sql.Add('    , QtdUnid       = 1');
    FConexao.Query.Sql.Add('    , UnidadeSecundariaId = @UnidadeSecundariaId');
    FConexao.Query.Sql.Add('    --, FatorConversao = @FatorConversao');
    FConexao.Query.Sql.Add('    , LaboratorioId  = (Select IdLaboratorio From laboratorios Where CodERP = @CodERPFabricante)');
    FConexao.Query.Sql.Add('    , Sngpc          = @Sngpc');
    FConexao.Query.Sql.Add('    , Curva          = @Curva');
    FConexao.Query.Sql.Add('    , Liquido        = @Liquido');
    FConexao.Query.Sql.Add('    , Inflamavel     = @Inflamavel');
    FConexao.Query.Sql.Add('    , Status = 1');
    FConexao.Query.Sql.Add('  Where CodProduto = @CodProduto');
    FConexao.Query.Sql.Add('End;');
    FConexao.Query.Sql.Add('Declare @ProdutoID Integer = 0');
    FConexao.Query.ParamByName('pCodProduto').Value             := pJsonObjectProduto.GetValue<Integer>('codproduto');
    FConexao.Query.ParamByName('pDescricao').Value              := UpperCase(pJsonObjectProduto.GetValue<String>('descricao'));
    FConexao.Query.ParamByName('pUnidadeSigla').Value           := UpperCase(pJsonObjectProduto.GetValue<String>('unidadesigla', 'UN'));
    FConexao.Query.ParamByName('pUnidade').Value                := UpperCase(pJsonObjectProduto.GetValue<String>('unidade', 'Unidade'));
    FConexao.Query.ParamByName('pUnidadeSecundariaSigla').Value := UpperCase(pJsonObjectProduto.GetValue<String>('unidadesiglacaixamaster', 'UN'));
    FConexao.Query.ParamByName('pUnidadeSecundaria').Value      := UpperCase(pJsonObjectProduto.GetValue<String>('unidadecaixamaster', 'UNIDADE'));
    FConexao.Query.ParamByName('pqtdcaixamaster').Value         := pJsonObjectProduto.GetValue<Integer>('qtdcaixamaster');
    FConexao.Query.ParamByName('pCodERPFabricante').Value       := pJsonObjectProduto.GetValue<Integer>('coderpfabricante');
    FConexao.Query.ParamByName('pFabricante').Value             := UpperCase(pJsonObjectProduto.GetValue<String>('fabricante'));
    FConexao.Query.ParamByName('pSngpc').Value                  := pJsonObjectProduto.GetValue<Integer>('sngpc');
    FConexao.Query.ParamByName('pCurva').Value                  := pJsonObjectProduto.GetValue<String>('curva');
    FConexao.Query.ParamByName('pLiquido').Value                := pJsonObjectProduto.GetValue<String>('liquido');
    FConexao.Query.ParamByName('pInflamavel').Value             := pJsonObjectProduto.GetValue<String>('inflamavel');
    FConexao.Query.ParamByName('pPesoLiquido').Value            := pJsonObjectProduto.GetValue<String>('pesoliquido');
    FConexao.Query.ParamByName('pAltura').Value                 := pJsonObjectProduto.GetValue<String>('altura');
    FConexao.Query.ParamByName('pLargura').Value                := pJsonObjectProduto.GetValue<String>('largura');
    FConexao.Query.ParamByName('pComprimento').Value            := pJsonObjectProduto.GetValue<String>('comprimento');
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('ProdImporta.Sql');
    FConexao.Query.ExecSQL;
    Result := TjSonArray.Create();
    Result.AddElement(TJsonObject.Create.AddPair('status', '200')
          .AddPair('codproduto', TJsonNumber.Create(pJsonObjectProduto.GetValue<Integer>('codproduto')))
          .AddPair('mensagem', 'Produto cadastrado/alterado com sucesso!'));
  Except ON E: Exception do
    Begin
      Raise Exception.Create(TUtil.TratarExcessao('Erro - ImportDadosV2: '+E.Message))
    End;
  End;
end;

function TProdutoDao.ImportEan(pJsonArray: TjSonArray): TjSonArray;
Var xEan: Integer;
begin
  Result := TjSonArray.Create();
  if pJsonArray = Nil then
  Begin
    Result.AddElement(TJsonObject.Create.AddPair('status', '500')
      .AddPair('produto', TJsonNumber.Create(0)).AddPair('ean', '')
      .AddPair('mensagem', 'JsonArray enviado incorreto.'));
    Exit;
  End;
  For xEan := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.connection.StartTransaction;
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('Declare @Produtoid Integer    = (Select IdProduto From Produto Where CodProduto = '+ pJsonArray.Items[xEan].GetValue<String>('codproduto') + ')');
      FConexao.Query.Sql.Add('Declare @Ean Varchar(25)      = ' + #39 + pJsonArray.Items[xEan].GetValue<String>('ean') + #39);
      FConexao.Query.Sql.Add('Declare @QtdEmbalagem Integer = ' + pJsonArray.Items[xEan].GetValue<String>('qtdembalagem'));
      FConexao.Query.Sql.Add('Declare @Principal Integer    = Coalesce((Select Top 1 principal from ProdutoCodBarras');
      FConexao.Query.Sql.Add('                                          where produtoid = @ProdutoId and Principal = 1), 0)');
      FConexao.Query.Sql.Add('if @ProdutoId <> 0 Begin');
      FConexao.Query.Sql.Add('   If Not Exists (Select CodBarrasId From ProdutoCodBarras Where CodBarras = @Ean) Begin');
      FConexao.Query.Sql.Add('      Insert ProdutoCodBarras Values (@ProdutoId, @Ean, @QtdEmbalagem, ');
      FConexao.Query.Sql.Add('             (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), ');
      FConexao.Query.Sql.Add('             (Case When @Principal = 1 then 0 else 1 End), 1)');
      FConexao.Query.Sql.Add('   End');
      FConexao.Query.Sql.Add('   Else Begin');
      FConexao.Query.Sql.Add('     Update ProdutoCodBarras Set ProdutoId = @ProdutoId');
      FConexao.Query.Sql.Add('          , Principal = (Case When @Principal = 1 then 0 else 1 End)');
      FConexao.Query.Sql.Add('     Where CodBarras = @Ean');
      FConexao.Query.Sql.Add('   End');
      FConexao.Query.Sql.Add('End');
      FConexao.Query.Sql.Add('Select Coalesce(CodBarrasId, 0) CodBarrasId From ProdutoCodBarras Where ProdutoId = @ProdutoId and CodBarras = @Ean');
      If DebugHook <> 0 Then
         FConexao.Query.Sql.SaveToFile('ImportEan.Sql');
      if StrToInt64Def(pJsonArray.Items[xEan].GetValue<String>('ean'), 0) > 999999 then Begin
         FConexao.Query.Open;
         Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                           .AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xEan].GetValue<String>('codproduto')))
                           .AddPair('ean', pJsonArray.Items[xEan].GetValue<String>('ean')).AddPair('mensagem', 'Ean cadastrado com sucesso!'));
      End
      Else Begin
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                           .AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xEan].GetValue<String>('codproduto')))
                           .AddPair('ean', pJsonArray.Items[xEan].GetValue<String>('ean')).AddPair('mensagem', 'Ean inválido para cadastrado!'));
      End;
      FConexao.Query.connection.Commit;
    Except ON E: Exception do
      Begin
        FConexao.Query.connection.Rollback;
        Result.AddElement(TJsonObject.Create.AddPair('status', '500').AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xEan]
          .GetValue<String>('codproduto'))).AddPair('ean', pJsonArray.Items[xEan].GetValue<String>('ean')).AddPair('mensagem', E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.ImportEnderecamento(pJsonArray: TjSonArray): TjSonArray;
Var
  xProd: Integer;
begin
  Result := TjSonArray.Create();
  For xProd := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('declare @CodProduto Integer = :pCodProduto');
      FConexao.Query.Sql.Add
        ('Declare @Produtoid Integer = (Select IdProduto From Produto Where CodProduto = @CodProduto)');
      FConexao.Query.Sql.Add('Declare @Endereco Varchar(20) = :pEndereco');
      FConexao.Query.Sql.Add
        ('Declare @EnderecoId Integer = (select Coalesce((Select EnderecoId From Enderecamentos TEnd ');
      FConexao.Query.Sql.Add
        ('                               Inner Join EnderecamentoEstruturas Est On Est.EstruturaId = TEnd.EstruturaID');
      FConexao.Query.Sql.Add
        ('                               where Est.PickingFixo = 1 and TEnd.Descricao = @Endereco), 0))');
      FConexao.Query.Sql.Add('if @EnderecoId <> 0 Begin');
      FConexao.Query.Sql.Add
        ('  Update Produto Set EnderecoId = @EnderecoId Where IdProduto = @Produtoid');
      FConexao.Query.Sql.Add('End');
      FConexao.Query.Sql.Add
        ('Select Coalesce(IdProduto, 0) IdProduto From produto Where EnderecoId = @Enderecoid');
      FConexao.Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd]
        .GetValue<Integer>('codproduto');
      FConexao.Query.ParamByName('pEndereco').Value := pJsonArray.Items[xProd]
        .GetValue<String>('endereco');
      If DebugHook <> 0 Then
        FConexao.Query.Sql.SaveToFile('ImportEnderecamento.Sql');
      FConexao.Query.Open;
      Result.AddElement(TJsonObject.Create.AddPair('idproduto',
        TJsonNumber.Create(FConexao.Query.FieldByName('IdProduto').AsInteger)));
    Except
      ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.ImportEstoque(pJsonArray: TjSonArray): TjSonArray;
Var
  xProd: Integer;
begin
  Result := TjSonArray.Create();
  For xProd := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('declare @CodProduto Integer = :pCodProduto');
      FConexao.Query.Sql.Add('Declare @Produtoid Integer = (Select IdProduto From Produto Where CodProduto = @CodProduto)');
      FConexao.Query.Sql.Add('Declare @Endereco Varchar(20) = :pEndereco');
      FConexao.Query.Sql.Add('Declare @Quantidade Integer = :pQuantidade');
      FConexao.Query.SQL.Add('Declare @DescrLote Varchar(30) = FORMAT(GetDate(), '+#39+'yyMMdd'+#39+')');
      FConexao.Query.SQL.Add('Declare @EstoqueTipoId Integer = 0');
      FConexao.Query.SQL.Add('if @Endereco = '+#39+#39);
      FConexao.Query.SQL.Add('   Set @Endereco = (Select EnderecoDescricao From vProduto where CodProduto = @CodProduto)');
      FConexao.Query.SQL.Add('if @Endereco Is Null');
      FConexao.Query.SQL.Add('   Set @Endereco = (Select Descricao From Enderecamentos where EnderecoId = 1)');
      FConexao.Query.SQL.Add('Set @EstoqueTipoId = (select EstoqueTipoId from vEnderecamentos where Endereco = @Endereco)');
      FConexao.Query.SQL.Add('');
      FConexao.Query.SQL.Add('if Not Exists (Select LoteId From Produtolotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote) Begin --Formula para pegar data atual invertida');
      FConexao.Query.SQL.Add('   Insert Into ProdutoLotes (ProdutoId, DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada, uuid) values');
      FConexao.Query.SQL.Add('          (@ProdutoId, @DescrLote, (Select IdData From Rhema_Data Where Data = Cast(dateadd(day, -360, Getdate()) as Date)),');
      FConexao.Query.SQL.Add('		  (Select IdData From Rhema_Data Where Data = Cast(dateadd(day, 730,getdate()) as Date)),');
      FConexao.Query.SQL.Add('		  (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      FConexao.Query.SQL.Add('		  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), NewId() )');
      FConexao.Query.SQL.Add('End');
      FConexao.Query.SQL.Add('If Not Exists (Select LoteId From Estoque where LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote) and');
      FConexao.Query.SQL.Add('               EnderecoId = (Select EnderecoId From Enderecamentos where Descricao = @Endereco) and EstoqueTipoId = @EstoqueTipoId ) Begin');
      FConexao.Query.SQL.Add('   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao) values');
      FConexao.Query.SQL.Add('               ((Select LoteId From ProdutoLotes where LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)),');
      FConexao.Query.SQL.Add('			   (Select EnderecoId From Enderecamentos where Descricao = @Endereco), @EstoqueTipoId, @Quantidade,');
      FConexao.Query.SQL.Add('			   (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      FConexao.Query.SQL.Add('		       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) )');
      FConexao.Query.SQL.Add('End');
      FConexao.Query.SQL.Add('else Begin');
      FConexao.Query.SQL.Add('  Update Estoque');
      FConexao.Query.SQL.Add('     Set Qtde = Qtde + @Quantidade');
      FConexao.Query.SQL.Add('        , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))');
      FConexao.Query.SQL.Add('        , HrAlteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))');
      FConexao.Query.SQL.Add('  Where LoteId = (Select LoteId From ProdutoLotes where LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)) and');
      FConexao.Query.SQL.Add('  EnderecoId = (Select EnderecoId From Enderecamentos where Descricao = @Endereco) and EstoqueTipoId = @EstoqueTipoId');
      FConexao.Query.SQL.Add('End');
      FConexao.Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
      FConexao.Query.ParamByName('pEndereco').Value := pJsonArray.Items[xProd].GetValue<String>('endereco');
      FConexao.Query.ParamByName('pQuantidade').Value := pJsonArray.Items[xProd].GetValue<Integer>('quantidade');
      If DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('ImportEstoque.Sql');
      FConexao.Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cadastro de produto '+pJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString + ' realizado com sucesso!'));
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
      End;
    End;
  End;
end;

function TProdutoDao.InsertUpdate(pIdProduto, pCodProduto: Integer;
  pCodigoMS, pDescricao, pDescrReduzida: String;
  pUnidadeId, pQtdUnid, pUnidadeSecondariaId, pFatorConversao,
  pSomenteCxaFechada: Integer; pEnderecoId, pRastroid, pImportado,
  pSNGPC: Integer; pEnderecamentoZonaId: Integer;
  pEanPrincipal, pProdutoTipo, pMedicamentoTipo: String;
  pIdUnidMedIndustrial: Integer; pLaboratorioId, pliquido, pPerigoso,
  pInflamavel, pMedicamento: Integer; pPesoLiquido: Integer;  pAltura, pLargura,
  pComprimento : iNTEGER; pMinPicking, pMaxPicking, pQtdReposicao,
  pPercReposicao: Integer; pMesEntradaMinima, pMesSaidaMinima, pStatus: Integer)
  : TjSonArray;
var
  vSql: String;
begin
  FConexao.Query.Sql.Clear;
  try
    if pIdProduto = 0 then
    Begin
      FConexao.Query.Sql.Add
        ('Insert Into Produto (CodProduto, CodigoMS, Descricao, DescrReduzida, ProdutoTipoId, '
        + ' UnidadeId, QtdUnid, UnidadeSecondariaId, FatorConversao, SomenteCxaFechada, EnderecoId, RastroId, pImportado, '
        + ' MedicamentoTipoId, SNGPC, ArmazenamentoZonaId, EanPrincipal, IdUnidMedIndustrial, LaboratorioId, '
        + ' PesoLiquido, liquido, Perigoso, Inflamavel, Medicamento, Altura, Largura, Comprimento, MinPicking, MaxPicking, QtdReposicao, '
        + ' PercReposicao, MesEntradaMinima, MesSaidaMinima, Status) Values (');
      FConexao.Query.Sql.Add(pCodProduto.ToString() + ', ' + QuotedStr(pCodigoMS) + ', ' +
        QuotedStr(pDescricao) + ', ' + QuotedStr(pDescrReduzida) + ', ' +
        '(Select Id From ProdutoTipo Where Descricao = ' + #39 + pProdutoTipo +
        #39 + ')' + ', ' + pUnidadeId.ToString() + ', ' + pQtdUnid.ToString() +
        ', ' + pUnidadeSecondariaId.ToString() + ', ' + pFatorConversao.ToString
        () + ', ' + ', ' + pSomenteCxaFechada.ToString() +
        IfThen(pEnderecoId > 0, pEnderecoId.ToString(), 'Null') + ', ' +
        pRastroid.ToString() + ', ' + pImportado.ToString() + ', ' +
        '(Select MedicamentoTipoId From MedicamentoTipo Where Descricao = ' +
        #39 + pMedicamentoTipo + #39 + '), ' + pSNGPC.ToString() + ', ' +
        pEnderecamentoZonaId.ToString() + ', ' + QuotedStr(pEanPrincipal) + ', '
        + pIdUnidMedIndustrial.ToString() + ', ');
      FConexao.Query.Sql.Add(pLaboratorioId.ToString() + ', ' + pPesoLiquido.ToString() +
        ', ' + pliquido.ToString() + ', ' + pPerigoso.ToString() + ', ' +
        pInflamavel.ToString() + ', ' + pMedicamento.ToString + ', ' +
        pAltura.ToString() + ', ' + pLargura.ToString() + ', ' +
        pComprimento.ToString() + ', ' + pMinPicking.ToString() + ', ' +
        pMaxPicking.ToString() + ', ' + pQtdReposicao.ToString() + ', ' +
        pPercReposicao.ToString() + ', ' + pMesEntradaMinima.ToString() + ', ' +
        pMesSaidaMinima.ToString() + ', ' + pStatus.ToString() + ')');

    End
    Else
    Begin
      FConexao.Query.Sql.Add('Update Produto Set CodProduto = ' + pCodProduto.ToString() +
        '      ,CodigoMS       = ' + QuotedStr(pCodigoMS) +
        '      ,Descricao      = ' + QuotedStr(pDescricao) +
        '      ,DescrReduzida   = ' + QuotedStr(pDescrReduzida) +
        '      ,ProdutoTipoId  = (Select Id From ProdutoTipo Where Descricao = '
        + #39 + pProdutoTipo + #39 + ')' + '      ,UnidadeId      = ' +
        IfThen(pUnidadeId > 0, pUnidadeId.ToString(), 'Null') +
        '      ,QtdUnid        = ' + pQtdUnid.ToString() +
        '      ,UnidadeSecundariaId = ' + IfThen(pUnidadeSecondariaId > 0,
        pUnidadeSecondariaId.ToString(), 'Null') + '      ,FatorConversao = ' +
        pFatorConversao.ToString() + '      ,SomenteCxaFechada = ' +
        pSomenteCxaFechada.ToString() + '      ,EnderecoId     = ' +
        IfThen(pEnderecoId > 0, pEnderecoId.ToString(), 'Null') +
        '      ,RastroId       = ' + IfThen(pRastroid > 0, pRastroid.ToString(),
        'Null') + '      ,MedicamentoTipoId   = (Select Id From MedicamentoTipo Where Descricao = '
        + #39 + pMedicamentoTipo + #39 + ')' + '      ,ArmazenamentoZonaId = ' +
        IfThen(pEnderecamentoZonaId > 0, pEnderecamentoZonaId.ToString(),
        'Null') + '      ,EanPrincipal   = ' + QuotedStr(pEanPrincipal) +
        '      ,IdUnidMedIndustrial = ' + pIdUnidMedIndustrial.ToString());
      FConexao.Query.Sql.Add('      ,LaboratorioId  = ' + IfThen(pLaboratorioId > 0,
        pLaboratorioId.ToString(), 'Null') + '      ,Liquido        = ' +
        pliquido.ToString() + '      ,importado      = ' + pImportado.ToString()
        + '      ,Inflamavel     = ' + pInflamavel.ToString() +
        '      ,Perigoso       = ' + pPerigoso.ToString() +
        '      ,Medicamento    = ' + pMedicamento.ToString() +
        '      ,SNGPC          = ' + pSNGPC.ToString() +
        '      ,PesoLiquido    = ' + pPesoLiquido.ToString()+   //StringReplace(pPesoLiquido.ToString(), ',', '.', [rfReplaceAll]) +
        '      ,Altura         = Cast(' + pAltura.ToString()+' as Float)'+ '/100 '+
        '      ,Largura        = Cast(' + pLargura.ToString()+' as Float)'+ '/100 '+
        '      ,Comprimento    = Cast(' + pComprimento.ToString()+' as Float)'+ '/100 '+
        '      ,MinPicking     = ' + pMinPicking.ToString() +
        '      ,MaxPicking     = ' + pMaxPicking.ToString() +
        '      ,QtdReposicao   = ' + pQtdReposicao.ToString() +
        '      ,PercReposicao  = ' + pPercReposicao.ToString() +
        '      ,MesEntradaMinima = ' + pMesEntradaMinima.ToString() +
        '      ,MesSaidaMinima   = ' + pMesSaidaMinima.ToString() +
        '      ,Status           = ' + pStatus.ToString());
      FConexao.Query.Sql.Add('Where IdProduto = ' + pIdProduto.ToString);
      If DebugHook <> 0 Then
        FConexao.Query.Sql.SaveToFile('updateProduto.Sql');
    End;
    FConexao.Query.ExecSQL;
    Result := FConexao.Query.ToJSONArray;
  Except On E: Exception do Begin
    raise Exception.Create(E.Message);
    end;
  end;
end;

function TProdutoDao.MontarPaginacao: TJsonObject;
var vSql: String;
begin
  Result := TJsonObject.Create;
  try
    FConexao.Query.Open('Select Count(*) Paginacao From Produto');
    Result.AddPair('paginacao', TJsonNumber.Create(FConexao.Query.FieldByName('Paginacao').AsInteger));
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', E.Message);
    End;
  end;
end;

function TProdutoDao.SalvarColetor(pJsonProduto: TJsonObject): TjSonArray;
begin
  Result := TjSonArray.Create();
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlSalvarProdutoColetor);
    FConexao.Query.ParamByName('pIdProduto').Value := pJsonProduto.GetValue<Integer>
      ('idproduto');
    FConexao.Query.ParamByName('pcodproduto').Value := pJsonProduto.GetValue<Integer>
      ('codproduto');
    // FConexao.Query.ParamByName('pDescricao').Value := pJsonProduto.GetValue<String>('descricao');
    // FConexao.Query.ParamByName('p--DescricaoRed	   = :DescricaoRed
    FConexao.Query.ParamByName('pQtdUnid').Value := pJsonProduto.GetValue<Integer>
      ('qtdunid');
    FConexao.Query.ParamByName('pFatorConversao').Value := pJsonProduto.GetValue<String>
      ('fatorconversao');
    // FConexao.Query.ParamByName('pSomenteCaixaFechada').Value := pJsonProduto.GetValue<String>('somentecxafechada');
    FConexao.Query.ParamByName('pEndereco').Value := pJsonProduto.GetValue<String>
      ('endereco');
    FConexao.Query.ParamByName('prastroid').Value := pJsonProduto.GetValue<Integer>
      ('rastroid');
    FConexao.Query.ParamByName('ppeso').Value := pJsonProduto.GetValue<Double>('peso');
    FConexao.Query.ParamByName('paltura').Value := pJsonProduto.GetValue<Double>
      ('altura');
    FConexao.Query.ParamByName('plargura').Value := pJsonProduto.GetValue<Double>
      ('largura');
    FConexao.Query.ParamByName('pcomprimento').Value := pJsonProduto.GetValue<Double>
      ('comprimento');
    FConexao.Query.ParamByName('pMesEntradaMinima').Value :=
      pJsonProduto.GetValue<Integer>('mesentradaminima');
    FConexao.Query.ParamByName('pMesSaidaMinima').Value := pJsonProduto.GetValue<Integer>
      ('messaidaminima');
    If DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('SalvarProdutoColetor.Sql');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create.AddPair('OK', 'Dados gravados com sucesso!'));
  Except
    ON E: Exception do
    Begin
     Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TProdutoDao.SalvarLaboratorio(pCodERP: Integer;
  pNome, pFone, PEmail, pHomePage: String): Integer;
begin
  Result := -1;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlInsFabricante);
    FConexao.Query.ParamByName('pCodERP').Value := pCodERP;
    FConexao.Query.ParamByName('pNome').Value := pNome;
    FConexao.Query.ParamByName('pFone').Value := pFone;
    FConexao.Query.ParamByName('pEmail').Value := PEmail;
    FConexao.Query.ParamByName('pHomePage').Value := pHomePage;
    FConexao.Query.ExecSQL;
    Result := 0;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: ProdutosImport - Fabricante: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

procedure TProdutoDao.SalvarProdutoCodbarras(pCodProdutoERP: Integer;
  pEan: String);
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlInsProdutoCodBarras);
    FConexao.Query.ParamByName('pCodProdutoERP').Value := pCodProdutoERP;
    FConexao.Query.ParamByName('pCodBarras').Value := pEan;
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: ProdutosImport - Código de Barras: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Function TProdutoDao.SalvarUnidades(pSigla, pDescricao: String): Boolean;
begin
  Result := False;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlInsUnidades);
    FConexao.Query.ParamByName('pSigla').Value := pSigla;
    FConexao.Query.ParamByName('pDescricao').Value := pDescricao;
    FConexao.Query.ExecSQL;
    Result := True
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: ProdutosImport - Unidades: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TProdutoDao.UpdatePicking(pCodProduto: Integer): TJsonArray;
begin
  Try
    FConexao.Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
    FConexao.Query.Sql.Add('select CodigoERP CodProduto, Sum(Qtde) Qtde, Sum(IsNull(QtdeProducao, 0)) QTdeProducao, Sum(IsNull(QtdeReserva, 0)) QtdeReserva');
    FConexao.Query.Sql.Add('From vEstoque Est');
    FConexao.Query.Sql.Add('Where CodigoERP = @CodProduto');
    FConexao.Query.Sql.Add('  And ZonaId <> 3 And ((Select mudarPickingEstoquePallet from Configuracao) = 1 or EstruturaId = 2)');
    FConexao.Query.Sql.Add('Group by CodigoERP');
    FConexao.Query.Sql.Add('Union');
    FConexao.Query.Sql.Add('Select Pl.Codproduto, 0 as Qtde, 0 as QTdeProducao, Sum(Coalesce(Qtde, 0)) as QtdeReserva');
    FConexao.Query.Sql.Add('From ReposicaoEstoqueTransferencia RET');
    FConexao.Query.Sql.Add('inner join vProdutoLotes Pl On Pl.Loteid = RET.LoteId');
    FConexao.Query.Sql.Add('Where Pl.CodProduto =@CodProduto and Coalesce(Qtde, 0) > 0');
    FConexao.Query.Sql.Add('Group by Pl.CodProduto');

{
     FConexao.Query.Sql.Add('Select CodProduto, Coalesce(Sum(Qtde), 0) Qtde');
     FConexao.Query.Sql.Add('From (select CodigoERP CodProduto, Sum(Qtde) Qtde --Sum(IsNull(QtdeProducao, 0)+IsNull(QtdeReserva, 0)) Qtde');
     FConexao.Query.Sql.Add('From vEstoque Est');
     FConexao.Query.Sql.Add('Where CodigoERP = @CodProduto');
     FConexao.Query.Sql.Add('  And ZonaId <> 3 And ((Select mudarPickingEstoquePallet from Configuracao) = 1 or EstruturaId = 2)');
     FConexao.Query.Sql.Add('Group by CodigoERP');
     FConexao.Query.Sql.Add('Union');
     FConexao.Query.Sql.Add('Select Pl.Codproduto, Sum(Coalesce(Qtde, 0)) Qtde');
     FConexao.Query.Sql.Add('From ReposicaoEstoqueTransferencia RET');
     FConexao.Query.Sql.Add('inner join vProdutoLotes Pl On Pl.Loteid = RET.LoteId');
     FConexao.Query.Sql.Add('Where Pl.CodProduto =@CodProduto and Coalesce(Qtde, 0) > 0');
     FConexao.Query.Sql.Add('Group by Pl.CodProduto) Est');
     FConexao.Query.Sql.Add('Group by CodProduto');

}    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('UpdatePicking.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('codproduto', TJsonNumber.Create(pCodProduto))
                                           .Addpair('estoque', TJsonNumber.Create(0)));
    End
    Else Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('codproduto', TJsonNumber.Create(pCodProduto))
                                           .Addpair('qtdeproducao', TJsonNumber.Create(FConexao.Query.FieldByName('QtdeProducao').AsInteger))
                                           .Addpair('qtdereserva', TJsonNumber.Create(FConexao.Query.FieldByName('QtdeReserva').AsInteger))
                                           .Addpair('saldo', TJsonNumber.Create(FConexao.Query.FieldByName('Qtde').AsInteger))
                                           );
    End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: UpdatePicking - '+StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

end.
