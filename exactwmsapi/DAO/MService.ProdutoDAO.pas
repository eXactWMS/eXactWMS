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

uses Constants; //uSistemaControl,

{ TProdutoDao }

constructor TProdutoDao.Create;
begin
  ObjProdutoDAO := TProduto.Create;
  inherited;
end;

destructor TProdutoDao.Destroy;
begin
  FreeAndNil(ObjProdutoDAO);
  inherited;
end;

function TProdutoDao.Delete(pId, pProdutoTipoID: Integer): Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Produto where CodProduto = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      raise Exception.Create('Processo: Produto/Delete - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.EnderecarProduto(pJsonProduto: TJsonObject): TjSonArray;
Var Query : TFdQuery;
begin
  Result := TjSonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlEnderecarProduto);
      Query.ParamByName('pProdutoId').Value := pJsonProduto.GetValue<Integer>('produtoid');
      Query.ParamByName('pEnderecoId').Value := pJsonProduto.GetValue<Integer>('enderecoid');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('OK', 'Endereçamento realizado com sucesso!'));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Produto/EnderecarProduto - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('Produto') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do Begin
        vRegEstrutura := TJsonObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ExportarCubagem: TjSonArray;
Var xProd: Integer;
    xProduto: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Select * from vProdutoCubagemIntegracao');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('status', TJsonNumber.Create(200))
               .AddPair('produto', TJsonNumber.Create(0))
               .AddPair('mensagem', TuEvolutConst.QrySemDados));
      End
      Else
      Begin
        Result := Query.ToJSONArray();
        for xProduto := 0 to Pred(Result.Count) do Begin
          Query.Close;
          Query.Sql.Clear;
          Query.Sql.Add('Update ProdutoCubagemIntegracao');
          Query.Sql.Add('  Set Status = 1');
          Query.Sql.Add('Where ProdutoId = (Select IdProduto From Produto Where CodProduto ='+Result.Items[xProduto].GetValue<String>('codproduto') + ')');
          Query.ExecSQL;
        End;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Produto/ExportaCubagem - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ExportFile(const AParams: TDictionary<string, string>) : TjSonArray;
var vSql, pCampos: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if AParams.ContainsKey('campos') then
         pCampos := AParams.Items['campos']
      else
         pCampos := 'CodBarras, CodProduto, Descricao';
      vSql := 'Select ' + pCampos + ' ' + sLineBreak + 'From Produto P ' + sLineBreak +
              'Left Join ProdutoCodBarras Pc On Pc.ProdutoId = P.IdProduto';
      Query.Open(vSql);
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não foram encontrados dados da pesquisa.')));
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Processo: Produto/ExportFile - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetCodigoERP(pCodigoERP: String): TjSonArray;
begin
  if pCodigoERP = '' then
    pCodigoERP := '0';
  Result := GetId('0', 0, pCodigoERP, nil);
end;

function TProdutoDao.GetDescricao(pNome: String; pProdutoTipoID: Integer;
  AQueryParam: TDictionary<String, String>): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    If AQueryParam.Count > 0 then Begin
       if AQueryParam.ContainsKey('RecsMax') then begin
          Query.FetchOptions.RecsMax := StrToIntDef(AQueryParam.Items['RecsMax'], 5);
          Query.FetchOptions.RowsetSize := StrToIntDef(AQueryParam.Items['RecsMax'], 5);
       end;
       if AQueryParam.ContainsKey('RecsSkip') then
          Query.FetchOptions.RecsSkip := StrToIntDef(AQueryParam.Items['RecsSkip'], 0);
    End;
    try
      if pNome = '*' then
         pNome := '%';
      vSql := 'Select P.*, (Select Top 1 CodBarras From ProdutoCodBarras where ProdutoId = P.IdProduto Order by Principal Desc) As EanPrincipal'+sLineBreak +
              'From vProduto P ' + sLineBreak +
              'where (Descricao like '+QuotedStr('%' + pNome + '%') + ') or (DescrReduzida like ' + QuotedStr('%' + pNome + '%') + ') ';
      Query.Open(vSql);
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não foram encontrados dados da pesquisa.')))
      Else
        while Not Query.Eof do Begin
          ObjProdutoDAO.IdProduto    := Query.FieldByName('IdProduto').AsInteger;
          ObjProdutoDAO.CodProduto   := Query.FieldByName('CodProduto').AsInteger;
          ObjProdutoDAO.Descricao    := Query.FieldByName('Descricao').AsString;
          ObjProdutoDAO.DescricaoRed := Query.FieldByName('DescrReduzida').AsString;
          ObjProdutoDAO.CodigoMS := Query.FieldByName('CodigoMS').AsString;
          ObjProdutoDAO.Rastro.RastroId  := Query.FieldByName('RastroId').AsInteger;
          ObjProdutoDAO.Rastro.Descricao := Query.FieldByName('RastroDescricao').AsString;
          ObjProdutoDAO.Rastro.Status    := Query.FieldByName('RastroStatus').AsInteger;
          // JSon ProdutoTipo
          ObjProdutoDAO.ProdutoTipo.Id := Query.FieldByName('ProdutoTipoId').AsInteger;
          ObjProdutoDAO.ProdutoTipo.Descricao := Query.FieldByName('ProdutoTipoDescricao').AsString;
          ObjProdutoDAO.ProdutoTipo.Status := Query.FieldByName('ProdutoTipoStatus').AsInteger;

          ObjProdutoDAO.Unid.Id := Query.FieldByName('UnidadeId').AsInteger;
          ObjProdutoDAO.Unid.Descricao := Query.FieldByName('UnidadeDescricao').AsString;
          ObjProdutoDAO.Unid.Sigla := Query.FieldByName('UnidadeSigla').AsString;
          ObjProdutoDAO.Unid.Status := Query.FieldByName('UnidadeStatus').AsInteger;
          ObjProdutoDAO.QtdUnid := Query.FieldByName('QtdUnid').AsInteger;
          ObjProdutoDAO.UnidSecundaria.Id := Query.FieldByName('UnidadeSecundariaId').AsInteger;
          ObjProdutoDAO.UnidSecundaria.Descricao := Query.FieldByName('UnidadeSecundariaDescricao').AsString;
          ObjProdutoDAO.UnidSecundaria.Sigla := Query.FieldByName('UnidadeSecundariaSigla').AsString;
          ObjProdutoDAO.UnidSecundaria.Status := Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
          ObjProdutoDAO.FatorConversao := Query.FieldByName('FatorConversao').AsInteger;
          ObjProdutoDAO.SomenteCxaFechada := Query.FieldByName('SomenteCxaFechada').AsInteger;
          ObjProdutoDAO.Endereco.EnderecoId := Query.FieldByName('EnderecoId').AsInteger;
          ObjProdutoDAO.Endereco.Descricao := Query.FieldByName('EnderecoDescricao').AsString;
          ObjProdutoDAO.Endereco.EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
          ObjProdutoDAO.Endereco.EnderecoEstrutura.Descricao := Query.FieldByName('EstruturaDescricao').AsString;
          ObjProdutoDAO.Endereco.EnderecoEstrutura.Mascara := Query.FieldByName('mascara').AsString;
          ObjProdutoDAO.Endereco.EnderecamentoZona.ZonaId := Query.FieldByName('ZonaId').AsInteger;
          ObjProdutoDAO.Endereco.EnderecamentoZona.Descricao := Query.FieldByName('ZonaDescricao').AsString;
          ObjProdutoDAO.EnderecamentoZona.Status := Query.FieldByName('ZonaStatus').AsInteger;
          ObjProdutoDAO.Endereco.DesenhoArmazem.Id := Query.FieldByName('DesenhoArmazemId').AsInteger;
          ObjProdutoDAO.Endereco.DesenhoArmazem.Descricao := Query.FieldByName('DesenhoArmazemDescricao').AsString;
          ObjProdutoDAO.Endereco.DesenhoArmazem.Status := Query.FieldByName('DesenhoArmazemStatus').AsInteger;
          ObjProdutoDAO.Importado := Query.FieldByName('Importado').AsInteger = 1;
          ObjProdutoDAO.MedicamentoTipo.Id := Query.FieldByName('MedicamentoTipoId').AsInteger;
          ObjProdutoDAO.MedicamentoTipo.Descricao := Query.FieldByName('MedicamentoTipoDescricao').AsString;
          ObjProdutoDAO.SNGPC := Query.FieldByName('SNGPC').AsInteger = 1;

          // ObjProdutoDAO.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
          // ObjProdutoDAO.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
          ObjProdutoDAO.Laboratorio.IdLaboratorio := Query.FieldByName('LaboratorioId').AsInteger;
          ObjProdutoDAO.Laboratorio.Nome := Query.FieldByName('LaboratorioNome').AsString;
          ObjProdutoDAO.Peso := Query.FieldByName('PesoLiquido').AsInteger;
          ObjProdutoDAO.Liquido := Query.FieldByName('Liquido').AsInteger = 1;
          ObjProdutoDAO.Perigoso := Query.FieldByName('Perigoso').AsInteger = 1;
          ObjProdutoDAO.Inflamavel := Query.FieldByName('Inflamavel').AsInteger = 1;
          ObjProdutoDAO.Medicamento := Query.FieldByName('Medicamento').AsInteger = 1;
          ObjProdutoDAO.SNGPC := Query.FieldByName('Sngpc').AsInteger = 1;
          ObjProdutoDAO.Altura := Query.FieldByName('Altura').AsFloat;
          ObjProdutoDAO.Largura := Query.FieldByName('Largura').AsFloat;
          ObjProdutoDAO.Comprimento := Query.FieldByName('Comprimento').AsFloat;
          ObjProdutoDAO.MinPicking := Query.FieldByName('MinPicking').AsInteger;
          ObjProdutoDAO.MaxPicking := Query.FieldByName('MaxPicking').AsInteger;
          ObjProdutoDAO.QtdReposicao := Query.FieldByName('QtdReposicao').AsInteger;
          ObjProdutoDAO.PercReposicao := Query.FieldByName('PercReposicao').AsInteger;
          ObjProdutoDAO.MesEntradaMinima := Query.FieldByName('MesEntradaMinima').AsInteger;
          ObjProdutoDAO.MesSaidaMinima := Query.FieldByName('MesSaidaMinima').AsInteger;
          ObjProdutoDAO.Status := Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoDAO));
          // (ObjProdutoDAO.ClassToJson(ObjProdutoDAO).ToString);
          Query.Next;
        End;
    Except On E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Processo: Produto/Descricao - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetId(pId: String; pProdutoTipoID: Integer;
  pCodigoERP: String; AQueryParam: TDictionary<String, String>): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    If assigned(AQueryParam) and (AQueryParam.Count > 0) then Begin
       if AQueryParam.ContainsKey('RecsMax') then begin
          Query.FetchOptions.RecsMax := StrToIntDef(AQueryParam.Items['RecsMax'], 5);
          Query.FetchOptions.RowsetSize := StrToIntDef(AQueryParam.Items['RecsMax'], 5);
      end;
      if AQueryParam.ContainsKey('RecsSkip') then
         Query.FetchOptions.RecsSkip := StrToIntDef(AQueryParam.Items['RecsSkip'], 0) * StrToIntDef(AQueryParam.Items['RecsMax'], 5)
      Else
         Query.FetchOptions.RecsSkip := 0;
    End;
    try
      if (pId <> '0') or (pCodigoERP <> '0') then
        vSql := 'select Top 1 Vp.*, (Select Top 1 CodBarras From ProdutoCodBarras '+sLineBreak +
                'where ProdutoId = Vp.IdProduto Order by Principal Desc) As EanPrincipal '+sLineBreak +
                'From vproduto Vp WITH (READUNCOMMITTED) ' + sLineBreak +
                'Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Vp.IdProduto'
      Else
        vSql := 'select Vp.*, (Select Top 1 CodBarras From ProdutoCodBarras WITH (READUNCOMMITTED) '+sLineBreak+
                '              where ProdutoId = Vp.IdProduto Order by Principal Desc) As EanPrincipal'+sLineBreak+
                'From vproduto Vp WITH (READUNCOMMITTED) ';
      if pId <> '0' then Begin
         vSql := vSql + ' where Vp.IdProduto = @IdProduto or Cb.CodBarras = @CodBarras';
         Query.Sql.Add('Declare @IdProduto Bigint      = :pIdProduto');
         Query.Sql.Add('Declare @CodBarras VarChar(25) = :pCodBarras');
         Query.Sql.Add(vSql);
         Query.ParamByName('pIdProduto').Value := pId.ToInt64;
         Query.ParamByName('pCodBarras').Value := pId;
      End
      Else if pCodigoERP <> '0' then Begin
         vSql := vSql + ' where (@CodProduto <> 0 and @CodProduto = Vp.CodProduto) or (Cb.CodBarras = @CodBarras)';
         Query.Sql.Add('Declare @CodProduto Integer    = :pCodProduto');
         Query.Sql.Add('Declare @CodBarras VarChar(25) = :pCodBarras');
         Query.Sql.Add(vSql);
         Query.ParamByName('pCodProduto').Value := StrToIntDef(pCodigoERP, 0);
         Query.ParamByName('pCodBarras').Value := pCodigoERP;
      End;
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Não foram encontrados dados da pesquisa.')))
      Else
         While Not Query.Eof do Begin
          ObjProdutoDAO.IdProduto := Query.FieldByName('IdProduto').AsInteger;
          ObjProdutoDAO.CodProduto := Query.FieldByName('CodProduto').AsInteger;
          ObjProdutoDAO.EanPrincipal := Query.FieldByName('EanPrincipal').AsString;
          ObjProdutoDAO.Descricao := Query.FieldByName('Descricao').AsString;
          ObjProdutoDAO.DescricaoRed := Query.FieldByName('DescrReduzida').AsString;
          ObjProdutoDAO.CodigoMS := Query.FieldByName('CodigoMS').AsString;
          ObjProdutoDAO.Rastro.RastroId := Query.FieldByName('RastroId').AsInteger;
          ObjProdutoDAO.Rastro.Descricao := Query.FieldByName('RastroDescricao').AsString;
          ObjProdutoDAO.Rastro.Status := Query.FieldByName('RastroStatus').AsInteger;
          // JSon ProdutoTipo
          ObjProdutoDAO.ProdutoTipo.Id := Query.FieldByName('ProdutoTipoId').AsInteger;
          ObjProdutoDAO.ProdutoTipo.Descricao := Query.FieldByName('ProdutoTipoDescricao').AsString;
          ObjProdutoDAO.ProdutoTipo.Status := Query.FieldByName('ProdutoTipoStatus').AsInteger;

          ObjProdutoDAO.Unid.Id := Query.FieldByName('UnidadeId').AsInteger;
          ObjProdutoDAO.Unid.Descricao := Query.FieldByName('UnidadeDescricao').AsString;
          ObjProdutoDAO.Unid.Sigla := Query.FieldByName('UnidadeSigla').AsString;
          ObjProdutoDAO.Unid.Status := Query.FieldByName('UnidadeStatus').AsInteger;
          ObjProdutoDAO.QtdUnid := Query.FieldByName('QtdUnid').AsInteger;
          ObjProdutoDAO.UnidSecundaria.Id := Query.FieldByName('UnidadeSecundariaId').AsInteger;
          ObjProdutoDAO.UnidSecundaria.Descricao := Query.FieldByName('UnidadeSecundariaDescricao').AsString;
          ObjProdutoDAO.UnidSecundaria.Sigla := Query.FieldByName('UnidadeSecundariaSigla').AsString;
          ObjProdutoDAO.UnidSecundaria.Status := Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
          ObjProdutoDAO.FatorConversao := Query.FieldByName('FatorConversao').AsInteger;
          ObjProdutoDAO.SomenteCxaFechada := Query.FieldByName('SomenteCxaFechada').AsInteger;
          // Enderecamento de Picking
          ObjProdutoDAO.Endereco.EnderecoId := Query.FieldByName('EnderecoId').AsInteger;
          ObjProdutoDAO.Endereco.Descricao := Query.FieldByName('EnderecoDescricao').AsString;
          ObjProdutoDAO.Endereco.EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
          ObjProdutoDAO.Endereco.EnderecoEstrutura.Descricao := Query.FieldByName('EstruturaDescricao').AsString;
          ObjProdutoDAO.Endereco.EnderecoEstrutura.Mascara := Query.FieldByName('mascara').AsString;
          ObjProdutoDAO.Endereco.EnderecoRua.RuaId := Query.FieldByName('RuaId').AsInteger;
          ObjProdutoDAO.Endereco.EnderecoRua.Descricao := Query.FieldByName('RuaDescricao').AsString;
          ObjProdutoDAO.Endereco.EnderecoRua.Lado := Query.FieldByName('RuaLado').AsString;
          ObjProdutoDAO.Endereco.EnderecoRua.Ordem := Query.FieldByName('RuaOrdem').AsInteger;
          ObjProdutoDAO.Endereco.EnderecoRua.Status := Query.FieldByName('RuaStatus').AsInteger;
          ObjProdutoDAO.Endereco.Status := Query.FieldByName('EnderecoStatus').AsInteger;
          // Zona do Endereco
          ObjProdutoDAO.Endereco.EnderecamentoZona.ZonaId := Query.FieldByName('zonaid').AsInteger;
          ObjProdutoDAO.Endereco.EnderecamentoZona.Descricao := Query.FieldByName('zonadescricao').AsString;
          ObjProdutoDAO.Endereco.EnderecamentoZona.EstoqueTipoId := Query.FieldByName('EstoqueTipoId').AsInteger;
          ObjProdutoDAO.Endereco.EnderecamentoZona.RastroId := Query.FieldByName('ZonaRastroId').AsInteger;
          ObjProdutoDAO.Endereco.EnderecamentoZona.LoteReposicao := Query.FieldByName('LoteReposicao').AsInteger;
          ObjProdutoDAO.Endereco.EnderecamentoZona.SeparacaoConsolidada := Query.FieldByName('SeparacaoConsolidada').AsInteger;
          ObjProdutoDAO.Endereco.EnderecamentoZona.ProdutoSNGPC := Query.FieldByName('ProdutoSNGPC').AsInteger;

          ObjProdutoDAO.EnderecamentoZona.Status := Query.FieldByName('zonastatus').AsInteger;
          // Incluir Dados adicionais da Zona - ver select GSS em 09012021
          ObjProdutoDAO.Endereco.DesenhoArmazem.Id := Query.FieldByName('DesenhoArmazemId').AsInteger;
          ObjProdutoDAO.Endereco.DesenhoArmazem.Descricao := Query.FieldByName('DesenhoArmazemDescricao').AsString;
          ObjProdutoDAO.Endereco.DesenhoArmazem.Status := Query.FieldByName('DesenhoArmazemStatus').AsInteger;
          // Zona de Armazenamento
          ObjProdutoDAO.EnderecamentoZona.ZonaId := Query.FieldByName('armazenamentozonaid').AsInteger;
          ObjProdutoDAO.EnderecamentoZona.Descricao := Query.FieldByName('armazenamentozona').AsString;
          ObjProdutoDAO.EnderecamentoZona.Status := Query.FieldByName('armazenamentozonastatus').AsInteger;

          ObjProdutoDAO.Importado := Query.FieldByName('Importado').AsInteger = 1;
          ObjProdutoDAO.MedicamentoTipo.Id := Query.FieldByName('MedicamentoTipoId').AsInteger;
          ObjProdutoDAO.MedicamentoTipo.Descricao := Query.FieldByName('MedicamentoTipoDescricao').AsString;
          ObjProdutoDAO.SNGPC := Query.FieldByName('SNGPC').AsInteger = 1;

          ObjProdutoDAO.Laboratorio.IdLaboratorio := Query.FieldByName('LaboratorioId').AsInteger;
          ObjProdutoDAO.Laboratorio.Nome := Query.FieldByName('LaboratorioNome').AsString;
          ObjProdutoDAO.Peso := Query.FieldByName('PesoLiquido').AsFloat;
          ObjProdutoDAO.Liquido := Query.FieldByName('Liquido').AsInteger = 1;
          ObjProdutoDAO.Perigoso := Query.FieldByName('Perigoso').AsInteger = 1;
          ObjProdutoDAO.Inflamavel := Query.FieldByName('Inflamavel').AsInteger = 1;
          ObjProdutoDAO.Medicamento := Query.FieldByName('Medicamento').AsInteger = 1;
          ObjProdutoDAO.SNGPC := Query.FieldByName('Sngpc').AsInteger = 1;
          ObjProdutoDAO.Altura := Query.FieldByName('Altura').AsFloat;
          ObjProdutoDAO.Largura := Query.FieldByName('Largura').AsFloat;
          ObjProdutoDAO.Comprimento := Query.FieldByName('Comprimento').AsFloat;
          ObjProdutoDAO.QtdReposicao := Query.FieldByName('QtdReposicao').AsInteger;
          ObjProdutoDAO.PercReposicao := Query.FieldByName('PercReposicao').AsInteger;
          ObjProdutoDAO.MinPicking := Query.FieldByName('MinPicking').AsInteger;
          ObjProdutoDAO.MaxPicking := Query.FieldByName('MaxPicking').AsInteger;
          ObjProdutoDAO.MesEntradaMinima := Query.FieldByName('MesEntradaMinima').AsInteger;
          ObjProdutoDAO.MesSaidaMinima := Query.FieldByName('MesSaidaMinima').AsInteger;
          ObjProdutoDAO.Status := Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjProdutoDAO));
          // (ObjProdutoDAO.ClassToJson(ObjProdutoDAO).ToString);
          Query.Next;
        End;
    Except On E: Exception do
      Begin
          Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Processo: Produto/Get - '+TUtil.TratarExcessao(E.Message))));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetId4D(const AParams: TDictionary<string, string>) : TJsonObject;
var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  QryPesquisa    := TFdQuery.Create(nil);
  QryRecordCount := TFdQuery.Create(nil);
  Try
    QryPesquisa.Connection    := Connection;
    QryRecordCount.Connection := Connection;
    QryPesquisa.Sql.Add('select IdProduto, CodProduto, Descricao, UnidadeSecundariaSigla, FatorConversao, SomenteCxaFechada, EnderecoDescricao, RastroDescricao, Status From vProduto where 1 = 1');
    QryRecordCount.Sql.Add('Select Count(IdProduto) cReg From vProduto where 1=1');
    if AParams.ContainsKey('produtoid') then begin
       QryPesquisa.Sql.Add('and IdProduto = :Produtoid');
       QryPesquisa.ParamByName('ProdutoId').AsLargeInt := AParams.Items['produtoid'].ToInt64;
       QryRecordCount.Sql.Add('and IdProduto = :ProdutoId');
       QryRecordCount.ParamByName('ProdutoId').AsLargeInt := AParams.Items['produtoid'].ToInt64;
    end;
    if AParams.ContainsKey('codproduto') then begin
       QryPesquisa.Sql.Add('and codproduto = :codproduto');
       QryPesquisa.ParamByName('codproduto').AsLargeInt := AParams.Items['codproduto'].ToInt64;
       QryRecordCount.Sql.Add('and codproduto = :codproduto');
       QryRecordCount.ParamByName('codproduto').AsLargeInt := AParams.Items['codproduto'].ToInt64;
    end;
    if AParams.ContainsKey('descricao') then begin
       QryPesquisa.Sql.Add('and descricao like :descricao');
       QryPesquisa.ParamByName('descricao').AsString := '%' + AParams.Items['descricao'].ToUpper + '%';
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
    FreeAndNil(QryPesquisa);
    FreeAndNil(QryRecordCount);
  End;
end;

function TProdutoDao.GetProdutoList(const AParams: TDictionary<string, string>) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetProdutoList);
      if AParams.ContainsKey('produtoid') then
         Query.ParamByName('pProdutoId').Value := AParams.Items['produtoid'].ToInteger()
      Else
         Query.ParamByName('pProdutoId').Value := 0;
      if AParams.ContainsKey('codigoerp') then
         Query.ParamByName('pCodigoERP').Value := AParams.Items['codigoerp'].ToInteger()
      Else
        Query.ParamByName('pCodigoERP').Value := 0;
      if AParams.ContainsKey('enderecoid') then
         Query.ParamByName('pEnderecoId').Value := AParams.Items['enderecoid'].ToInteger()
      Else
        Query.ParamByName('pEnderecoId').Value := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AParams.ContainsKey('ean') then
         Query.ParamByName('pEan').Value := AParams.Items['ean']
      Else
        Query.ParamByName('pEan').Value := '';
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetProdutoList.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a pesquisa.'));
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Raise exception.Create('Processo: ProdutoList - '+TUtil.TratarExcessao(E.Message))
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetProdutoLotes(pProdutoId: Integer; pDescricao: String) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Declare @Produtoid Integer = ' + pProdutoId.ToString());
      Query.Sql.Add('Declare @descricao VarChar(30) = ' + QuotedStr(pDescricao));
      Query.Sql.Add('select Pl.produtoid, Prd.codproduto codigoerp, Pl.loteid, pl.descrlote, ');
      Query.Sql.Add('                FORMAT(Dv.Data, ' + #39 + 'dd/MM/yyyy' + #39 +') vencimento,');
      Query.SQL.Add('                FORMAT(Df.Data, ' + #39 + 'dd/MM/yyyy' + #39 +') Fabricacao');
      Query.Sql.Add('from ProdutoLotes Pl');
      Query.Sql.Add('Inner Join Rhema_Data DF on DF.IdData = Pl.Fabricacao');
      Query.Sql.Add('Inner Join Rhema_Data DV on Dv.IdData = Pl.Vencimento');
      Query.Sql.Add('Inner join Produto Prd On Prd.IdProduto = Pl.Produtoid');
      Query.Sql.Add('where (Pl.Produtoid = @ProdutoId)');
      Query.Sql.Add('      and (Pl.DescrLote like @Descricao)');
      If DebugHook <> 0 then
         Query.Sql.SaveToFile('ProdutoLotes.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para relatório de endereçamento.'));
      End
      else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Raise Exception.Create('Processo: Produtolotes - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetRelEnderecamento(AQueryParam : TDictionary<String, String>): TjSonArray;
var JsonCargas: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlRelProdutoEnderecamento);
      Query.Sql.Add('Where 1 = 1');
      if AQueryParam.ContainsKey('produtoid') then begin
         Query.Sql.Add('and Prd.IdProduto = :ProdutoId');
         Query.ParamByName('produtoid').AsLargeInt := AQueryParam.Items['produtoid'].ToInt64;
      end;
      if AQueryParam.ContainsKey('codprodutoerp') then begin
         Query.Sql.Add('and Prd.codproduto = :codprodutoerp');
         Query.ParamByName('codprodutoerp').AsLargeInt := AQueryParam.Items['codprodutoerp'].ToInt64;
      end;
      if AQueryParam.ContainsKey('zonaid') then begin
         Query.Sql.Add('and Z.ZonaId = :zonaid');
         Query.ParamByName('zonaid').AsLargeInt := AQueryParam.Items['zonaid'].ToInt64;
      end;
      if AQueryParam.ContainsKey('zona') then begin
         Query.Sql.Add('and Z.Zona Like :zona');
         Query.ParamByName('zona').AsString := AQueryParam.Items['zona'];
      end;
      if AQueryParam.ContainsKey('enderecado') then begin
         if AQueryParam.Items['enderecado'] = '1' then
            Query.Sql.Add('and Prd.EnderecoId Is Not Null')
         Else
            Query.Sql.Add('and Prd.EnderecoId Is Null');
      end;
      Query.Sql.Add('Order by Z.Descricao, Prd.Descricao');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para relatório de endereçamento.'));
      End
      else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Raise exception.create(''+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetRelProdutos01(AQueryParam: TDictionary<String, String>) : TjSonArray;
var JsonCargas: TJsonObject;
    pEstoque, pSemPicking, pCodProduto, pZonaId, pLaboratorioId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlGetRelProdutos01);
      If DebugHook <> 0 then
         Query.Sql.SaveToFile('RelProdutos01.Sql');
      if AQueryParam.ContainsKey('estoque') then
         Query.ParamByName('pEstoque').Value := AQueryParam.Items['estoque'].ToInteger
      Else
         Query.ParamByName('pEstoque').Value := 0;
      if AQueryParam.ContainsKey('sempicking') then
         Query.ParamByName('pSemPicking').Value := AQueryParam.Items['sempicking'].ToInteger
      Else
         Query.ParamByName('pSemPicking').Value := 0;
      if AQueryParam.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := AQueryParam.Items['codproduto'].ToInteger
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if AQueryParam.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := AQueryParam.Items['zonaid'].ToInteger
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if AQueryParam.ContainsKey('laboratorioid') then
         Query.ParamByName('pLaboratorioId').Value := AQueryParam.Items['laboratorioid'].ToInteger
      Else
         Query.ParamByName('pLaboratorioId').Value := 0;
      if AQueryParam.ContainsKey('listaean') then
         Query.ParamByName('plistaean').Value := AQueryParam.Items['listaean'].ToInteger
      Else
         Query.ParamByName('plistaean').Value := 0;
      if AQueryParam.ContainsKey('status') then
         Query.ParamByName('pStatus').Value := AQueryParam.Items['status'].ToInteger
      Else
        Query.ParamByName('pStatus').Value := 99;
      if AQueryParam.ContainsKey('somentecxafechada') then
        Query.ParamByName('psomentecxafechada').Value := AQueryParam.Items['somentecxafechada'].ToInteger
      Else
        Query.ParamByName('psomentecxafechada').Value := 0;
      if AQueryParam.ContainsKey('ativo') then
         Query.ParamByName('pAtivo').Value := AQueryParam.Items['ativo'].ToInteger
      Else
         Query.ParamByName('pAtivo').Value := 0;
      if AQueryParam.ContainsKey('bloqueado') then
         Query.ParamByName('pBloqueado').Value := AQueryParam.Items['bloqueado'].ToInteger
      Else
         Query.ParamByName('pBloqueado').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelProdutos01.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para relatório de endereçamento.'));
      End
      else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: RelProdutos01 - '+TUtil.TratarExcessao(E.Message));
      end;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.GetCodProduto(pCodProduto: String): TJsonObject;
var //IndexConn: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetProduto);
      Query.ParamByName('pProdutoid').Value := pCodProduto;
      Query.Open;
      if Query.IsEmpty then Begin
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
         Result.AddPair('produtoid', TJsonNumber.Create(Query.FieldByName('Produtoid').AsLargeInt));
         Result.AddPair('codproduto', TJsonNumber.Create(Query.FieldByName('CodProduto').AsLargeInt));
         Result.AddPair('descricao', Query.FieldByName('Descricao').AsString);
         Result.AddPair('eanprincipal', Query.FieldByName('EanPrincipal').AsString);
         Result.AddPair('ean', Query.FieldByName('Ean').AsString);
         Result.AddPair('endereco', Query.FieldByName('Endereco').AsString);
      End;
    Except ON E: Exception do
      Begin
        Query.Sql.Add('-- pProdutoid = ' + pCodProduto);
        If DebugHook <> 0 then
           Query.Sql.SaveToFile('ErroEan.Sql');
        Raise Exception.Create(''+TUtil.TratarExcessao(E.Message));
      end;
    end;
  Finally
    FreeAndNil(Query);
  End;
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
Var xProd: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create();
    for xProd := 0 to Pred(pJsonArray.Count) do Begin
      Try
        SalvarLaboratorio(pJsonArray.Items[xProd].GetValue<TJsonObject>('fabricante').GetValue<Integer>('id'),
                          pJsonArray.Items[xProd].GetValue<TJsonObject>('fabricante').GetValue<String>('nome'), '', '', '');
        SalvarUnidades(pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemprimaria').GetValue<String>('sigla'),
                       pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemprimaria').GetValue<String>('descricao'));
        SalvarUnidades(pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemsecundaria').GetValue<String>('sigla'),
                       pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemsecundaria').GetValue<String>('descricao'));
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add(TuEvolutConst.SqlInsProduto);
        Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('produtoid');
        Query.ParamByName('pDescricao').Value := pJsonArray.Items[xProd].GetValue<String>('descricao');
        Query.ParamByName('pSiglaUnidPrimaria').Value := pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemprimaria').GetValue<String>('sigla');
        Query.ParamByName('pQtdUnidPrimaria').Value := pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemprimaria').GetValue<Integer>('qtdembalagem');
        Query.ParamByName('pSiglaUnidSecundaria').Value := pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemsecundaria').GetValue<String>('sigla');
        Query.ParamByName('pFatorConversao').Value := pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemsecundaria').GetValue<Integer>('qtdembalagem') /
                                                      pJsonArray.Items[xProd].GetValue<TJsonObject>('embalagemprimaria').GetValue<Integer>('qtdembalagem');
        Query.ParamByName('pLaboratorioId').Value := pJsonArray.Items[xProd].GetValue<TJsonObject>('fabricante').GetValue<Integer>('id');
        Query.ParamByName('pPeso').Value := pJsonArray.Items[xProd].GetValue<Integer>('peso');
        Query.ParamByName('pLiquido').Value := pJsonArray.Items[xProd].GetValue<Integer>('liquido');
        Query.ParamByName('pPerigoso').Value := pJsonArray.Items[xProd].GetValue<Integer>('perigoso');
        Query.ParamByName('pInflamavel').Value := pJsonArray.Items[xProd].GetValue<Integer>('inflamavel');
        Query.ParamByName('pAltura').Value := pJsonArray.Items[xProd].GetValue<Integer>('altura');
        Query.ParamByName('pLargura').Value := pJsonArray.Items[xProd].GetValue<Integer>('largura');
        Query.ParamByName('pComprimento').Value := pJsonArray.Items[xProd].GetValue<Integer>('comprimento');
        Query.ParamByName('pEan').Value := pJsonArray.Items[xProd].GetValue<String>('ean');
        Query.ExecSQL;
        if pJsonArray.Items[xProd].GetValue<String>('ean') <> '' then
           SalvarProdutoCodbarras(pJsonArray.Items[xProd].GetValue<Integer>('produtoid'),
                                  pJsonArray.Items[xProd].GetValue<String>('ean'));
        Result.AddElement(TJsonObject.Create.AddPair(pJsonArray.Items[xProd].GetValue<Integer>('produtoid').ToString(),
                          'Cadastro de produto realizado com sucesso!'));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair(pJsonArray.Items[xProd]
                .GetValue<Integer>('produtoid').ToString(), TUtil.TratarExcessao(E.Message)));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportCubagem(pJsonArray: TjSonArray): TjSonArray;
Var xProd: Integer;
    Query : TFdQuery;
begin
    Result := TjSonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    For xProd := 0 to Pred(pJsonArray.Count) do Begin
      Try
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
        Query.Sql.Add('Declare @Altura float = :pAltura');
        Query.Sql.Add('Declare @Largura Float = :pLargura');
        Query.Sql.Add('Declare @Comprimento Float = :pComprimento');
        Query.Sql.Add('Declare @Peso Float = :pPeso');
        Query.Sql.Add('Declare @FatorConversao Float = :pFatorConversao');
        Query.Sql.Add('Update Produto Set Altura = @Altura');
        Query.Sql.Add('  , Largura = @Largura');
        Query.Sql.Add('  , Comprimento = @Comprimento');
        Query.Sql.Add('Where CodProduto = @CodProduto');
        Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
        Query.ParamByName('pAltura').Value := pJsonArray.Items[xProd].GetValue<Double>('altura');
        Query.ParamByName('pLargura').Value := pJsonArray.Items[xProd].GetValue<Double>('largura');
        Query.ParamByName('pComprimento').Value := pJsonArray.Items[xProd].GetValue<Double>('comprimento');
        Query.ParamByName('pPeso').Value := pJsonArray.Items[xProd].GetValue<Double>('peso');
        Query.ParamByName('pFatorConversao').Value := pJsonArray.Items[xProd].GetValue<Double>('fatorconversao');
        if Debughook <> 0 then
           Query.SaveToFile('Cubagem'+pJsonArray.Items[xProd].GetValue<String>('codproduto')+'Sql');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cubagem de produto ' + pJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString +
                          ' realizado com sucesso!'));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportCubagemDC(pJsonArray: TjSonArray): TjSonArray;
Var xProd: Integer;
    vListaEan, vCompl: String;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    For xProd := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        vListaEan := '';
        vCompl := '';
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Declare @FatorConversao Integer = ' + pJsonArray.Items[xProd].GetValue<Integer>('fatorconversao').ToString());
        Query.Sql.Add('Update Prd');
        Query.Sql.Add('   set FatorConversao =  @FatorConversao ');
        Query.Sql.Add('     , Altura  = ' + pJsonArray.Items[xProd].GetValue<Integer>('altura').ToString());
        Query.Sql.Add('	   , Largura = ' + pJsonArray.Items[xProd].GetValue<Integer>('largura').ToString());
        Query.Sql.Add('	   , Comprimento = ' + pJsonArray.Items[xProd].GetValue<Integer>('comprimento').ToString());
        Query.Sql.Add('	   , PesoLiquido = ' + pJsonArray.Items[xProd].GetValue<Integer>('peso').ToString());
        Query.SQL.Add('     , IdUnidMedIndustrial = 1');
        Query.Sql.Add('From Produto Prd');
        Query.Sql.Add('Inner join ProdutoCodBarras Pc On Pc.ProdutoId = prd.IdProduto');
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
        Query.Sql.Add('Where Pc.CodBarras in ( ' + vListaEan + ')');
        If pJsonArray.Items[xProd].GetValue<integer>('somentepadrao', 0) = 1 then
           Query.Sql.Add('  And (Prd.Altura=8 and Prd.Largura=8 and Comprimento=8)');
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('CubagemDC'+pJsonArray.Items[xProd].GetValue<String>('codproduto')+'.Sql');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cubagem de produto '+
                          pJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString+' realizado com sucesso!'));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportDados(pJsonArray: TjSonArray): TjSonArray;
Var xProd: Integer;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    For xProd := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Declare @CodProduto Integer    = :pCodProduto');
        Query.Sql.Add('Declare @Descricao Varchar(80) = :pDescricao');
        Query.Sql.Add('Declare @UnidadeSigla Varchar(10)           = :pUnidadeSigla');
        Query.Sql.Add('Declare @Unidade Varchar(30)           = :pUnidade');
        Query.Sql.Add('Declare @UnidadeSecundariaSigla Varchar(10) = :pUnidadeSecundariaSigla');
        Query.Sql.Add('Declare @UnidadeSecundaria Varchar(30) = :pUnidadeSecundaria');
        Query.Sql.Add('Declare @UnidadeId Integer           = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSigla), 0)');
        Query.Sql.Add('Declare @UnidadeSecundariaId Integer = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSecundariaSigla), 0)');
        Query.Sql.Add('Declare @FatorConversao Integer = :pFatorConversao');
        Query.Sql.Add('Declare @Fabricante VarChar(50) = :pFabricante');
        Query.Sql.Add('Declare @LaboratorioId Integer  = (Select IdLaboratorio From Laboratorios Where CodERP = :pFabricanteId)');
        Query.Sql.Add('Declare @Sngpc Integer          = :pSngpc');
        Query.Sql.Add('Declare @Curva VarChar(2)       = :pCurva');
        Query.Sql.Add('Declare @Liquido integer        = :pLiquido');
        Query.Sql.Add('Declare @Inflamavel Integer     = :pInflamavel');
        Query.Sql.Add('If @LaboratorioId = 0 Begin');
        Query.Sql.Add('    Set @LaboratorioId = 1');
        Query.Sql.Add('End;');
        Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSigla) Begin');
        Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSigla, @Unidade, 1)');
        Query.Sql.Add('   Set @UnidadeId = SCOPE_IDENTITY()');
        Query.Sql.Add('End;');
        Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla) Begin');
        Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSecundariaSigla, @UnidadeSecundaria, 1)');
        Query.Sql.Add('   Set @UnidadeSecundariaId = SCOPE_IDENTITY()');
        Query.Sql.Add('End');
        Query.Sql.Add('Else Begin');
        Query.Sql.Add('   Set @UnidadeSecundariaId = (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla)');
        Query.Sql.Add('End;');
        Query.Sql.Add('If Not Exists (Select CodProduto From Produto Where CodProduto = @CodProduto) Begin');
        Query.Sql.Add('   Insert Produto (CodProduto, Descricao, DescrReduzida, UnidadeId, QtdUnid, ');
        Query.Sql.Add('                   UnidadeSecundariaId, FatorConversao, LaboratorioId, ProdutoTipoId, ');
        Query.Sql.Add('                   RastroId, Altura, Largura, Comprimento, PesoLiquido, MesEntradaMinima, ');
        Query.Sql.Add('                   MesSaidaMinima, Sngpc, Curva, Liquido, Inflamavel, Uuid, Status) Values');
        Query.Sql.Add('          (@CodProduto, @Descricao, SubString(@Descricao, 1, 40), @UnidadeId, 1, @UnidadeSecundariaId, @FatorConversao,');
        Query.Sql.Add('          (Select IdLaboratorio From laboratorios Where CodERP = @LaboratorioId), ');
        Query.Sql.Add('           1, 3, 8, 8, 8, 1, (Select ShelflifeRecebimento From Configuracao), ');
        Query.Sql.Add('           (Select ShelflifeExpedicao From Configuracao),');
        Query.Sql.Add('           @Sngpc, @Curva, @Liquido, @Inflamavel, NewId(), 1)');
        Query.Sql.Add('End');
        Query.Sql.Add('Else Begin;');
        Query.Sql.Add('  Update Produto Set ');
        Query.Sql.Add('     Descricao      = @Descricao');
        Query.Sql.Add('    , DescrReduzida = SubString(@Descricao, 1, 40)');
        Query.Sql.Add('    , UnidadeId     = @UnidadeId');
        Query.Sql.Add('    , QtdUnid       = 1');
        Query.Sql.Add('    , UnidadeSecundariaId = @UnidadeSecundariaId');
        Query.Sql.Add('    --, FatorConversao = @FatorConversao');
        Query.Sql.Add('    , LaboratorioId  = (Select IdLaboratorio From laboratorios Where CodERP = @LaboratorioId)');
        Query.Sql.Add('    , Sngpc          = @Sngpc');
        Query.Sql.Add('    , Curva          = @Curva');
        Query.Sql.Add('    , Liquido        = @Liquido');
        Query.Sql.Add('    , Inflamavel     = @Inflamavel');
        Query.Sql.Add('    , Status = 1');
        Query.Sql.Add('  Where CodProduto = @CodProduto');
        Query.Sql.Add('End;');
        //Query.Sql.Add('Declare @ProdutoID Integer = 0');
        Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
        Query.ParamByName('pDescricao').Value := pJsonArray.Items[xProd].GetValue<String>('descricao');
        Query.ParamByName('pUnidadeSigla').Value := pJsonArray.Items[xProd].GetValue<String>('unidadesigla', 'UN');
        Query.ParamByName('pUnidade').Value := pJsonArray.Items[xProd].GetValue<String>('unidade', 'Unidade');
        Query.ParamByName('pUnidadeSecundariaSigla').Value := pJsonArray.Items[xProd].GetValue<String>('unidadesiglacaixamaster', 'UN');
        Query.ParamByName('pUnidadeSecundaria').Value := pJsonArray.Items[xProd].GetValue<String>('unidadecaixamaster', 'UNIDADE');
        Query.ParamByName('pFatorConversao').Value := pJsonArray.Items[xProd].GetValue<Integer>('qtdembalagemfornecedor');
        Query.ParamByName('pFabricanteId').Value := pJsonArray.Items[xProd].GetValue<Integer>('fabricanteid');
        Query.ParamByName('pFabricante').Value := pJsonArray.Items[xProd].GetValue<String>('fabricante');
        Query.ParamByName('pSngpc').Value := pJsonArray.Items[xProd].GetValue<Integer>('sngpc');
        Query.ParamByName('pCurva').Value := pJsonArray.Items[xProd].GetValue<String>('curva');
        Query.ParamByName('pLiquido').Value := pJsonArray.Items[xProd].GetValue<String>('liquido');
        Query.ParamByName('pInflamavel').Value := pJsonArray.Items[xProd].GetValue<String>('inflamavel');
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('ProdImporta.Sql');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('status', '200')
              .AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xProd].GetValue<Integer>('codproduto')))
              .AddPair('mensagem', 'Produto cadastrado/alterado com sucesso!'));
      Except ON E: Exception do
        Begin
          Raise Exception.Create('Erro: '+TUtil.TratarExcessao(E.Message));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportDadosV2(pJsonObjectProduto: TJsonObject): TJsonArray;
Var xProd: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.Sql.Clear;
      Query.Sql.Add('Declare @CodProduto Integer       = :pCodProduto');
      Query.Sql.Add('Declare @Descricao Varchar(100)   = :pDescricao');
      Query.Sql.Add('Declare @UnidadeSigla Varchar(10) = :pUnidadeSigla');
      Query.Sql.Add('Declare @Unidade Varchar(30)      = :pUnidade');
      Query.Sql.Add('Declare @UnidadeId Integer        = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSigla), 0)');
      Query.Sql.Add('Declare @UnidadeSecundariaSigla Varchar(10) = :pUnidadeSecundariaSigla');
      Query.Sql.Add('Declare @UnidadeSecundaria Varchar(30)      = :pUnidadeSecundaria');
      Query.Sql.Add('Declare @UnidadeSecundariaId Integer        = Coalesce((Select Coalesce(Id, 0) From Unidades Where Sigla = @UnidadeSecundariaSigla), 0)');
      Query.Sql.Add('Declare @FatorConversao Integer   = :pQtdCaixaMaster');
      Query.Sql.Add('Declare @Fabricante VarChar(50)   = :pFabricante');
      Query.Sql.Add('Declare @CodERPFabricante Integer = (Select IdLaboratorio From Laboratorios Where CodERP = :pCodERPFabricante)');
      Query.Sql.Add('Declare @Sngpc Integer            = :pSngpc');
      Query.Sql.Add('Declare @Curva VarChar(2)         = :pCurva');
      Query.Sql.Add('Declare @Liquido integer          = :pLiquido');
      Query.Sql.Add('Declare @Inflamavel integer       = :pInflamavel');
      Query.Sql.Add('Declare @PesoLiquido Integer      = :pPesoLiquido');
      Query.Sql.Add('Declare @Altura Integer           = :pAltura');
      Query.Sql.Add('Declare @Largura Integer          = :pLargura');
      Query.Sql.Add('Declare @Comprimento Integer      = :pComprimento');

      Query.Sql.Add('If @CodERPFabricante = 0 Begin');
      Query.Sql.Add('    Set @CodERPFabricante = Null');
      Query.Sql.Add('End;');
      Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSigla) Begin');
      Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSigla, @Unidade, 1)');
      Query.Sql.Add('   Set @UnidadeId = SCOPE_IDENTITY()');
      Query.Sql.Add('End;');
      Query.Sql.Add('If Not Exists (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla) Begin');
      Query.Sql.Add('   Insert Into Unidades Values (@UnidadeSecundariaSigla, @UnidadeSecundaria, 1)');
      Query.Sql.Add('   Set @UnidadeSecundariaId = SCOPE_IDENTITY()');
      Query.Sql.Add('End');
      Query.Sql.Add('Else Begin');
      Query.Sql.Add('   Set @UnidadeSecundariaId = (Select Id From Unidades Where Sigla = @UnidadeSecundariaSigla)');
      Query.Sql.Add('End;');
      Query.Sql.Add('If Not Exists (Select CodProduto From Produto Where CodProduto = @CodProduto) Begin');
      Query.Sql.Add('   Insert Produto (CodProduto, Descricao, DescrReduzida, UnidadeId, QtdUnid, ');
      Query.Sql.Add('                   UnidadeSecundariaId, FatorConversao, LaboratorioId, ProdutoTipoId, ');
      Query.Sql.Add('                   RastroId, Altura, Largura, Comprimento, PesoLiquido, MesEntradaMinima, ');
      Query.Sql.Add('                   MesSaidaMinima, Sngpc, Curva, Liquido, Inflamavel, Uuid, Status) Values');
      Query.Sql.Add('          (@CodProduto, @Descricao, SubString(@Descricao, 1, 40), @UnidadeId, 1, @UnidadeSecundariaId, '+
                    '           @FatorConversao, (Select IdLaboratorio From laboratorios ');
      Query.Sql.Add('                             Where CodERP = @CodERPFabricante), ');
      Query.Sql.Add('           1, 2, @Altura, @Largura, @Comprimento, @PesoLiquido, (Select ShelflifeRecebimento From Configuracao), ');
      Query.Sql.Add('           (Select ShelflifeExpedicao From Configuracao),');
      Query.Sql.Add('           @Sngpc, @Curva, @Liquido, @Inflamavel, NewId(), 1)');
      Query.Sql.Add('End');
      Query.Sql.Add('Else Begin;');
      Query.Sql.Add('  Update Produto Set ');
      Query.Sql.Add('     Descricao      = @Descricao');
      Query.Sql.Add('    , DescrReduzida = SubString(@Descricao, 1, 40)');
      Query.Sql.Add('    , UnidadeId     = @UnidadeId');
      Query.Sql.Add('    , QtdUnid       = 1');
      Query.Sql.Add('    , UnidadeSecundariaId = @UnidadeSecundariaId');
      Query.Sql.Add('    --, FatorConversao = @FatorConversao');
      Query.Sql.Add('    , LaboratorioId  = (Select IdLaboratorio From laboratorios Where CodERP = @CodERPFabricante)');
      Query.Sql.Add('    , Sngpc          = @Sngpc');
      Query.Sql.Add('    , Curva          = @Curva');
      Query.Sql.Add('    , Liquido        = @Liquido');
      Query.Sql.Add('    , Inflamavel     = @Inflamavel');
      Query.Sql.Add('    , Status = 1');
      Query.Sql.Add('  Where CodProduto = @CodProduto');
      Query.Sql.Add('End;');
      Query.Sql.Add('Declare @ProdutoID Integer = 0');
      Query.ParamByName('pCodProduto').Value             := pJsonObjectProduto.GetValue<Integer>('codproduto');
      Query.ParamByName('pDescricao').Value              := UpperCase(pJsonObjectProduto.GetValue<String>('descricao'));
      Query.ParamByName('pUnidadeSigla').Value           := UpperCase(pJsonObjectProduto.GetValue<String>('unidadesigla', 'UN'));
      Query.ParamByName('pUnidade').Value                := UpperCase(pJsonObjectProduto.GetValue<String>('unidade', 'Unidade'));
      Query.ParamByName('pUnidadeSecundariaSigla').Value := UpperCase(pJsonObjectProduto.GetValue<String>('unidadesiglacaixamaster', 'UN'));
      Query.ParamByName('pUnidadeSecundaria').Value      := UpperCase(pJsonObjectProduto.GetValue<String>('unidadecaixamaster', 'UNIDADE'));
      Query.ParamByName('pqtdcaixamaster').Value         := pJsonObjectProduto.GetValue<Integer>('qtdcaixamaster');
      Query.ParamByName('pCodERPFabricante').Value       := pJsonObjectProduto.GetValue<Integer>('coderpfabricante');
      Query.ParamByName('pFabricante').Value             := UpperCase(pJsonObjectProduto.GetValue<String>('fabricante'));
      Query.ParamByName('pSngpc').Value                  := pJsonObjectProduto.GetValue<Integer>('sngpc');
      Query.ParamByName('pCurva').Value                  := pJsonObjectProduto.GetValue<String>('curva');
      Query.ParamByName('pLiquido').Value                := pJsonObjectProduto.GetValue<String>('liquido');
      Query.ParamByName('pInflamavel').Value             := pJsonObjectProduto.GetValue<String>('inflamavel');
      Query.ParamByName('pPesoLiquido').Value            := pJsonObjectProduto.GetValue<String>('pesoliquido');
      Query.ParamByName('pAltura').Value                 := pJsonObjectProduto.GetValue<String>('altura');
      Query.ParamByName('pLargura').Value                := pJsonObjectProduto.GetValue<String>('largura');
      Query.ParamByName('pComprimento').Value            := pJsonObjectProduto.GetValue<String>('comprimento');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProdImporta.Sql');
      Query.ExecSQL;
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('status', '200')
            .AddPair('codproduto', TJsonNumber.Create(pJsonObjectProduto.GetValue<Integer>('codproduto')))
            .AddPair('mensagem', 'Produto cadastrado/alterado com sucesso!'));
    Except ON E: Exception do
      Begin
        Raise Exception.Create(TUtil.TratarExcessao('Erro - ImportDadosV2: '+TUtil.TratarExcessao(E.Message)));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportEan(pJsonArray: TjSonArray): TjSonArray;
Var xEan: Integer;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
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
        Query.connection.StartTransaction;
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('Declare @Produtoid Integer    = (Select IdProduto From Produto Where CodProduto = '+ pJsonArray.Items[xEan].GetValue<String>('codproduto') + ')');
        Query.Sql.Add('Declare @Ean Varchar(25)      = ' + #39 + pJsonArray.Items[xEan].GetValue<String>('ean') + #39);
        Query.Sql.Add('Declare @QtdEmbalagem Integer = ' + pJsonArray.Items[xEan].GetValue<String>('qtdembalagem'));
        Query.Sql.Add('Declare @Principal Integer    = Coalesce((Select Top 1 principal from ProdutoCodBarras');
        Query.Sql.Add('                                          where produtoid = @ProdutoId and Principal = 1), 0)');
        Query.Sql.Add('if @ProdutoId <> 0 Begin');
        Query.Sql.Add('   If Not Exists (Select CodBarrasId From ProdutoCodBarras Where CodBarras = @Ean) Begin');
        Query.Sql.Add('      Insert ProdutoCodBarras Values (@ProdutoId, @Ean, @QtdEmbalagem, ');
        Query.Sql.Add('             (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), ');
        Query.Sql.Add('             (Case When @Principal = 1 then 0 else 1 End), 1)');
        Query.Sql.Add('   End');
        Query.Sql.Add('   Else Begin');
        Query.Sql.Add('     Update ProdutoCodBarras Set ProdutoId = @ProdutoId');
        Query.Sql.Add('          , Principal = (Case When @Principal = 1 then 0 else 1 End)');
        Query.Sql.Add('     Where CodBarras = @Ean');
        Query.Sql.Add('   End');
        Query.Sql.Add('End');
        Query.Sql.Add('Select Coalesce(CodBarrasId, 0) CodBarrasId From ProdutoCodBarras Where ProdutoId = @ProdutoId and CodBarras = @Ean');
        If DebugHook <> 0 Then
           Query.Sql.SaveToFile('ImportEan.Sql');
        if StrToInt64Def(pJsonArray.Items[xEan].GetValue<String>('ean'), 0) > 999999 then Begin
           Query.Open;
           Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                             .AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xEan].GetValue<String>('codproduto')))
                             .AddPair('ean', pJsonArray.Items[xEan].GetValue<String>('ean')).AddPair('mensagem', 'Ean cadastrado com sucesso!'));
        End
        Else Begin
           Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                             .AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xEan].GetValue<String>('codproduto')))
                             .AddPair('ean', pJsonArray.Items[xEan].GetValue<String>('ean')).AddPair('mensagem', 'Ean inválido para cadastrado!'));
        End;
        Query.connection.Commit;
      Except ON E: Exception do
        Begin
          Query.connection.Rollback;
          Result.AddElement(TJsonObject.Create.AddPair('status', '500').AddPair('codproduto', TJsonNumber.Create(pJsonArray.Items[xEan]
                .GetValue<String>('codproduto'))).AddPair('ean', pJsonArray.Items[xEan].GetValue<String>('ean')).AddPair('mensagem', E.Message));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportEnderecamento(pJsonArray: TjSonArray): TjSonArray;
Var xProd: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create();
    For xProd := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('declare @CodProduto Integer = :pCodProduto');
        Query.Sql.Add('Declare @Produtoid Integer = (Select IdProduto From Produto Where CodProduto = @CodProduto)');
        Query.Sql.Add('Declare @Endereco Varchar(20) = :pEndereco');
        Query.Sql.Add('Declare @EnderecoId Integer = (select Coalesce((Select EnderecoId From Enderecamentos TEnd ');
        Query.Sql.Add('                               Inner Join EnderecamentoEstruturas Est On Est.EstruturaId = TEnd.EstruturaID');
        Query.Sql.Add('                               where Est.PickingFixo = 1 and TEnd.Descricao = @Endereco), 0))');
        Query.Sql.Add('if @EnderecoId <> 0 Begin');
        Query.Sql.Add('  Update Produto Set EnderecoId = @EnderecoId Where IdProduto = @Produtoid');
        Query.Sql.Add('End');
        Query.Sql.Add('Select Coalesce(IdProduto, 0) IdProduto From produto Where EnderecoId = @Enderecoid');
        Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
        Query.ParamByName('pEndereco').Value := pJsonArray.Items[xProd].GetValue<String>('endereco');
        If DebugHook <> 0 Then
           Query.Sql.SaveToFile('ImportEnderecamento.Sql');
        Query.Open;
        Result.AddElement(TJsonObject.Create.AddPair('idproduto', TJsonNumber.Create(Query.FieldByName('IdProduto').AsInteger)));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('Erro', TUtil.TratarExcessao(E.Message)));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.ImportEstoque(pJsonArray: TjSonArray): TjSonArray;
Var xProd: Integer;
    Query : TFdQuery;
begin
  Result := TjSonArray.Create();
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    For xProd := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        Query.Close;
        Query.Sql.Clear;
        Query.Sql.Add('declare @CodProduto Integer = :pCodProduto');
        Query.Sql.Add('Declare @Produtoid Integer = (Select IdProduto From Produto Where CodProduto = @CodProduto)');
        Query.Sql.Add('Declare @Endereco Varchar(20) = :pEndereco');
        Query.Sql.Add('Declare @Quantidade Integer = :pQuantidade');
        Query.SQL.Add('Declare @DescrLote Varchar(30) = FORMAT(GetDate(), '+#39+'yyMMdd'+#39+')');
        Query.SQL.Add('Declare @EstoqueTipoId Integer = 0');
        Query.SQL.Add('if @Endereco = '+#39+#39);
        Query.SQL.Add('   Set @Endereco = (Select EnderecoDescricao From vProduto where CodProduto = @CodProduto)');
        Query.SQL.Add('if @Endereco Is Null');
        Query.SQL.Add('   Set @Endereco = (Select Descricao From Enderecamentos where EnderecoId = 1)');
        Query.SQL.Add('Set @EstoqueTipoId = (select EstoqueTipoId from vEnderecamentos where Endereco = @Endereco)');
        Query.SQL.Add('');
        Query.SQL.Add('if Not Exists (Select LoteId From Produtolotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote) Begin --Formula para pegar data atual invertida');
        Query.SQL.Add('   Insert Into ProdutoLotes (ProdutoId, DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada, uuid) values');
        Query.SQL.Add('          (@ProdutoId, @DescrLote, (Select IdData From Rhema_Data Where Data = Cast(dateadd(day, -360, Getdate()) as Date)),');
        Query.SQL.Add('		  (Select IdData From Rhema_Data Where Data = Cast(dateadd(day, 730,getdate()) as Date)),');
        Query.SQL.Add('		  (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
        Query.SQL.Add('		  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), NewId() )');
        Query.SQL.Add('End');
        Query.SQL.Add('If Not Exists (Select LoteId From Estoque where LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote) and');
        Query.SQL.Add('               EnderecoId = (Select EnderecoId From Enderecamentos where Descricao = @Endereco) and EstoqueTipoId = @EstoqueTipoId ) Begin');
        Query.SQL.Add('   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao) values');
        Query.SQL.Add('               ((Select LoteId From ProdutoLotes where LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)),');
        Query.SQL.Add('			   (Select EnderecoId From Enderecamentos where Descricao = @Endereco), @EstoqueTipoId, @Quantidade,');
        Query.SQL.Add('			   (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
        Query.SQL.Add('		       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) )');
        Query.SQL.Add('End');
        Query.SQL.Add('else Begin');
        Query.SQL.Add('  Update Estoque');
        Query.SQL.Add('     Set Qtde = Qtde + @Quantidade');
        Query.SQL.Add('        , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))');
        Query.SQL.Add('        , HrAlteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))');
        Query.SQL.Add('  Where LoteId = (Select LoteId From ProdutoLotes where LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)) and');
        Query.SQL.Add('  EnderecoId = (Select EnderecoId From Enderecamentos where Descricao = @Endereco) and EstoqueTipoId = @EstoqueTipoId');
        Query.SQL.Add('End');
        Query.ParamByName('pCodProduto').Value := pJsonArray.Items[xProd].GetValue<Integer>('codproduto');
        Query.ParamByName('pEndereco').Value := pJsonArray.Items[xProd].GetValue<String>('endereco');
        Query.ParamByName('pQuantidade').Value := pJsonArray.Items[xProd].GetValue<Integer>('quantidade');
        If DebugHook <> 0 then
           Query.Sql.SaveToFile('ImportEstoque.Sql');
        Query.ExecSQL;
        Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cadastro de produto '+pJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString + ' realizado com sucesso!'));
      Except ON E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: ImportEstoque - '+TUtil.TratarExcessao(E.Message)));
        End;
      End;
    End;
  Finally
    FreeAndNil(Query);
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
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Sql.Clear;
    try
      if pIdProduto = 0 then Begin
        Query.Sql.Add('Insert Into Produto (CodProduto, CodigoMS, Descricao, DescrReduzida, ProdutoTipoId, '+
                      ' UnidadeId, QtdUnid, UnidadeSecondariaId, FatorConversao, SomenteCxaFechada, EnderecoId, RastroId, pImportado, '+
                      ' MedicamentoTipoId, SNGPC, ArmazenamentoZonaId, EanPrincipal, IdUnidMedIndustrial, LaboratorioId, '+
                      ' PesoLiquido, liquido, Perigoso, Inflamavel, Medicamento, Altura, Largura, Comprimento, MinPicking, MaxPicking, QtdReposicao, '+
                      ' PercReposicao, MesEntradaMinima, MesSaidaMinima, Status) Values (');
        Query.Sql.Add(pCodProduto.ToString() + ', ' + QuotedStr(pCodigoMS) + ', ' + QuotedStr(pDescricao) + ', ' +
                      QuotedStr(pDescrReduzida) + ', (Select Id From ProdutoTipo Where Descricao = ' + #39 + pProdutoTipo+ #39+')'+', '+
                      pUnidadeId.ToString() + ', ' + pQtdUnid.ToString()+', ' + pUnidadeSecondariaId.ToString() + ', ' +
                      pFatorConversao.ToString() + ', ' + ', ' + pSomenteCxaFechada.ToString()+IfThen(pEnderecoId > 0,
                      pEnderecoId.ToString(), 'Null') + ', ' + pRastroid.ToString() + ', ' + pImportado.ToString() + ', ' +
                      '(Select MedicamentoTipoId From MedicamentoTipo Where Descricao = '+#39 + pMedicamentoTipo + #39 + '), '+
                      pSNGPC.ToString() + ', ' + pEnderecamentoZonaId.ToString() + ', ' + QuotedStr(pEanPrincipal) + ', '+
                      pIdUnidMedIndustrial.ToString() + ', ');
        Query.Sql.Add(pLaboratorioId.ToString() + ', ' + pPesoLiquido.ToString() +', ' + pliquido.ToString() + ', ' +
                      pPerigoso.ToString() + ', ' + pInflamavel.ToString() + ', ' + pMedicamento.ToString + ', ' +
                      pAltura.ToString() + ', ' + pLargura.ToString() + ', ' + pComprimento.ToString() + ', ' +
                      pMinPicking.ToString() + ', ' + pMaxPicking.ToString() + ', ' + pQtdReposicao.ToString() + ', ' +
                      pPercReposicao.ToString() + ', ' + pMesEntradaMinima.ToString() + ', ' +
                      pMesSaidaMinima.ToString() + ', ' + pStatus.ToString() + ')');
      End
      Else Begin
        Query.Sql.Add('Update Produto Set CodProduto = ' + pCodProduto.ToString() +
                      '      ,CodigoMS       = ' + QuotedStr(pCodigoMS) +
                      '      ,Descricao      = ' + QuotedStr(pDescricao) +
                      '      ,DescrReduzida   = ' + QuotedStr(pDescrReduzida) +
                      '      ,ProdutoTipoId  = (Select Id From ProdutoTipo Where Descricao = '+#39+pProdutoTipo + #39 + ')' +
                      '      ,UnidadeId      = '+IfThen(pUnidadeId > 0, pUnidadeId.ToString(), 'Null')+
                      '      ,QtdUnid        = ' + pQtdUnid.ToString() +
                      '      ,UnidadeSecundariaId = ' + IfThen(pUnidadeSecondariaId > 0,
                      pUnidadeSecondariaId.ToString(), 'Null') + '      ,FatorConversao = '+pFatorConversao.ToString()+
                      '      ,SomenteCxaFechada = ' + pSomenteCxaFechada.ToString() +
                      '      ,EnderecoId     = ' + IfThen(pEnderecoId > 0, pEnderecoId.ToString(), 'Null') +
                      '      ,RastroId       = ' + IfThen(pRastroid > 0, pRastroid.ToString(),'Null') +
                      '      ,MedicamentoTipoId   = (Select Id From MedicamentoTipo Where Descricao = '+#39+pMedicamentoTipo+#39+')'+
                      '      ,ArmazenamentoZonaId = ' + IfThen(pEnderecamentoZonaId > 0, pEnderecamentoZonaId.ToString(), 'Null')+
                      '      ,EanPrincipal   = ' + QuotedStr(pEanPrincipal) +
                      '      ,IdUnidMedIndustrial = ' + pIdUnidMedIndustrial.ToString());
        Query.Sql.Add('      ,LaboratorioId  = ' + IfThen(pLaboratorioId > 0, pLaboratorioId.ToString(), 'Null') +
                      '      ,Liquido        = ' + pliquido.ToString() +
                      '      ,importado      = ' + pImportado.ToString()+
                      '      ,Inflamavel     = ' + pInflamavel.ToString() +
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
        Query.Sql.Add('Where IdProduto = ' + pIdProduto.ToString);
        If DebugHook <> 0 Then
           Query.Sql.SaveToFile('updateProduto.Sql');
      End;
       Query.ExecSQL;
      Result := Query.ToJSONArray;
    Except On E: Exception do Begin
      raise Exception.Create('Processo: '+TUtil.TratarExcessao(E.Message));
      end;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.MontarPaginacao: TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Open('Select Count(*) Paginacao From Produto');
      Result.AddPair('paginacao', TJsonNumber.Create(Query.FieldByName('Paginacao').AsInteger));
    Except On E: Exception do
      Begin
        Result.AddPair('Erro', 'Processo: MontarPagina - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.SalvarColetor(pJsonProduto: TJsonObject): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TjSonArray.Create();
    Try
      Query.Sql.Add(TuEvolutConst.SqlSalvarProdutoColetor);
      Query.ParamByName('pIdProduto').Value := pJsonProduto.GetValue<Integer>('idproduto');
      Query.ParamByName('pcodproduto').Value := pJsonProduto.GetValue<Integer>('codproduto');
      // Query.ParamByName('pDescricao').Value := pJsonProduto.GetValue<String>('descricao');
      // Query.ParamByName('p--DescricaoRed	   = :DescricaoRed
      Query.ParamByName('pQtdUnid').Value := pJsonProduto.GetValue<Integer>('qtdunid');
      Query.ParamByName('pFatorConversao').Value := pJsonProduto.GetValue<String>('fatorconversao');
      // Query.ParamByName('pSomenteCaixaFechada').Value := pJsonProduto.GetValue<String>('somentecxafechada');
      Query.ParamByName('pEndereco').Value := pJsonProduto.GetValue<String>('endereco');
      Query.ParamByName('prastroid').Value := pJsonProduto.GetValue<Integer>('rastroid');
      Query.ParamByName('ppeso').Value := pJsonProduto.GetValue<Double>('peso');
      Query.ParamByName('paltura').Value := pJsonProduto.GetValue<Double>('altura');
      Query.ParamByName('plargura').Value := pJsonProduto.GetValue<Double>('largura');
      Query.ParamByName('pcomprimento').Value := pJsonProduto.GetValue<Double>('comprimento');
      Query.ParamByName('pMesEntradaMinima').Value := pJsonProduto.GetValue<Integer>('mesentradaminima');
      Query.ParamByName('pMesSaidaMinima').Value := pJsonProduto.GetValue<Integer>('messaidaminima');
      If DebugHook <> 0 then
         Query.Sql.SaveToFile('SalvarProdutoColetor.Sql');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('OK', 'Dados gravados com sucesso!'));
    Except ON E: Exception do
      Begin
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: Produto/SalvarColetor - '+TUtil.TratarExcessao(E.Message)));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.SalvarLaboratorio(pCodERP: Integer;
  pNome, pFone, PEmail, pHomePage: String): Integer;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := -1;
    Try
      Query.Sql.Add(TuEvolutConst.SqlInsFabricante);
      Query.ParamByName('pCodERP').Value := pCodERP;
      Query.ParamByName('pNome').Value := pNome;
      Query.ParamByName('pFone').Value := pFone;
      Query.ParamByName('pEmail').Value := PEmail;
      Query.ParamByName('pHomePage').Value := pHomePage;
      Query.ExecSQL;
      Result := 0;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Produto/SalvarFabricante - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

procedure TProdutoDao.SalvarProdutoCodbarras(pCodProdutoERP: Integer;
  pEan: String);
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutConst.SqlInsProdutoCodBarras);
      Query.ParamByName('pCodProdutoERP').Value := pCodProdutoERP;
      Query.ParamByName('pCodBarras').Value := pEan;
      Query.ExecSQL;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Produto/SalvarProdutoCodBarras -  '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

Function TProdutoDao.SalvarUnidades(pSigla, pDescricao: String): Boolean;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := False;
    Try
      Query.Sql.Add(TuEvolutConst.SqlInsUnidades);
      Query.ParamByName('pSigla').Value := pSigla;
      Query.ParamByName('pDescricao').Value := pDescricao;
      Query.ExecSQL;
      Result := True
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Produto/SalvarUnidades: '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TProdutoDao.UpdatePicking(pCodProduto: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Declare @CodProduto Integer = :pCodProduto');
      Query.Sql.Add('select CodigoERP CodProduto, Sum(Qtde) Qtde, Sum(IsNull(QtdeProducao, 0)) QTdeProducao, Sum(IsNull(QtdeReserva, 0)) QtdeReserva');
      Query.Sql.Add('From vEstoque Est');
      Query.Sql.Add('Where CodigoERP = @CodProduto');
      Query.Sql.Add('  And ZonaId <> 3 And ((Select mudarPickingEstoquePallet from Configuracao) = 1 or EstruturaId = 2)');
      Query.Sql.Add('Group by CodigoERP');
      Query.Sql.Add('Union');
      Query.Sql.Add('Select Pl.Codproduto, 0 as Qtde, 0 as QTdeProducao, Sum(Coalesce(Qtde, 0)) as QtdeReserva');
      Query.Sql.Add('From ReposicaoEstoqueTransferencia RET');
      Query.Sql.Add('inner join vProdutoLotes Pl On Pl.Loteid = RET.LoteId');
      Query.Sql.Add('Where Pl.CodProduto =@CodProduto and Coalesce(Qtde, 0) > 0');
      Query.Sql.Add('Group by Pl.CodProduto');
      Query.ParamByName('pCodProduto').Value := pCodProduto;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('UpdatePicking.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('codproduto', TJsonNumber.Create(pCodProduto))
                                             .Addpair('estoque', TJsonNumber.Create(0)));
      End
      Else Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('codproduto', TJsonNumber.Create(pCodProduto))
                                             .Addpair('qtdeproducao', TJsonNumber.Create(Query.FieldByName('QtdeProducao').AsInteger))
                                             .Addpair('qtdereserva', TJsonNumber.Create(Query.FieldByName('QtdeReserva').AsInteger))
                                             .Addpair('saldo', TJsonNumber.Create(Query.FieldByName('Qtde').AsInteger))
                                             );
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: UpdatePicking - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
