unit Services.Produto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections, Constants,
  ProdutoClass, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI,
  exactwmsservice.lib.utils, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TServiceProduto = class   (TBasicDao)
  private
    { Private declarations }

  public
    { Public declarations }
    Function GetCodProdutoEan(pCodProduto: String): TJsonObject;
    Function GetProduto(AQueryParam: TDictionary<String, String>): TJsonArray;
    Function GetPicking(pPicking: String): TJsonArray;
    Function AtualizarCubagem(pJsonObjectProduto: TJsonObject): TJsonArray;
    Function AtualizarCubagemIntegracao(pJsonObjectProduto: TJsonObject)
      : TJsonArray; // Enviar para ERP
    Function AtualizarRastreabilidade(pProdutoId, pRastroId: Integer)
      : TJsonArray;
    Function ImportEan(pJsonArray: TJsonArray): TJsonArray;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServiceProduto: TServiceProduto;

implementation

{ TServiceProduto }

function TServiceProduto.GetPicking(pPicking: String): TJsonArray;
Var pProdutoId, pCodigoERP: String;
    ObjProduto: TProduto;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('select Vp.*, (Select Top 1 CodBarras');
      Query.SQL.Add('                    From ProdutoCodBarras ');
      Query.SQL.Add('                    where ProdutoId = Vp.IdProduto and Principal = 1');
      Query.SQL.Add('                    Order by Principal Desc) As EanPrincipal');
      Query.SQL.Add('From vproduto Vp WITH (READUNCOMMITTED)');
      // Query.SQL.Add('Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Vp.IdProduto');
      Query.SQL.Add('Where EnderecoDescricao = ' + QuotedStr(pPicking));
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('GetPicking.Sql');
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Produto não encontrado para este Picking na pesquisa!')))
      Else
      Begin
        ObjProduto := TProduto.Create;
        While Not Query.Eof do
        Begin
          ObjProduto.IdProduto := Query.FieldByName('IdProduto').AsInteger;
          ObjProduto.CodProduto := Query.FieldByName('CodProduto').AsInteger;
          ObjProduto.EanPrincipal := Query.FieldByName('EanPrincipal').AsString;
          ObjProduto.Descricao := Query.FieldByName('Descricao').AsString;
          ObjProduto.DescricaoRed := Query.FieldByName('DescrReduzida').AsString;
          ObjProduto.CodigoMS := Query.FieldByName('CodigoMS').AsString;
          ObjProduto.Rastro.RastroId := Query.FieldByName('RastroId').AsInteger;
          ObjProduto.Rastro.Descricao := Query.FieldByName('RastroDescricao').AsString;
          ObjProduto.Rastro.Status := Query.FieldByName('RastroStatus').AsInteger;
          // JSon ProdutoTipo
          ObjProduto.ProdutoTipo.Id := Query.FieldByName('ProdutoTipoId').AsInteger;
          ObjProduto.ProdutoTipo.Descricao := Query.FieldByName('ProdutoTipoDescricao').AsString;
          ObjProduto.ProdutoTipo.Status := Query.FieldByName('ProdutoTipoStatus').AsInteger;
          ObjProduto.Unid.Id := Query.FieldByName('UnidadeId').AsInteger;
          ObjProduto.Unid.Descricao := Query.FieldByName('UnidadeDescricao').AsString;
          ObjProduto.Unid.Sigla := Query.FieldByName('UnidadeSigla').AsString;
          ObjProduto.Unid.Status := Query.FieldByName('UnidadeStatus').AsInteger;
          ObjProduto.QtdUnid := Query.FieldByName('QtdUnid').AsInteger;
          ObjProduto.UnidSecundaria.Id := Query.FieldByName('UnidadeSecundariaId').AsInteger;
          ObjProduto.UnidSecundaria.Descricao := Query.FieldByName('UnidadeSecundariaDescricao').AsString;
          ObjProduto.UnidSecundaria.Sigla := Query.FieldByName('UnidadeSecundariaSigla').AsString;
          ObjProduto.UnidSecundaria.Status := Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
          ObjProduto.FatorConversao := Query.FieldByName('FatorConversao').AsInteger;
          ObjProduto.SomenteCxaFechada := Query.FieldByName('SomenteCxaFechada').AsInteger;
          // Enderecamento de Picking
          ObjProduto.Endereco.EnderecoId := Query.FieldByName('EnderecoId').AsInteger;
          ObjProduto.Endereco.Descricao := Query.FieldByName('EnderecoDescricao').AsString;
          ObjProduto.Endereco.EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
          ObjProduto.Endereco.EnderecoEstrutura.Descricao := Query.FieldByName('EstruturaDescricao').AsString;
          ObjProduto.Endereco.EnderecoEstrutura.Mascara := Query.FieldByName('mascara').AsString;
          ObjProduto.Endereco.EnderecoRua.RuaId := Query.FieldByName('RuaId').AsInteger;
          ObjProduto.Endereco.EnderecoRua.Descricao := Query.FieldByName('RuaDescricao').AsString;
          ObjProduto.Endereco.EnderecoRua.Lado := Query.FieldByName('RuaLado').AsString;
          ObjProduto.Endereco.EnderecoRua.Ordem := Query.FieldByName('RuaOrdem').AsInteger;
          ObjProduto.Endereco.EnderecoRua.Status := Query.FieldByName('RuaStatus').AsInteger;
          ObjProduto.Endereco.Status := Query.FieldByName('EnderecoStatus').AsInteger;
          // Zona do Endereco
          ObjProduto.Endereco.EnderecamentoZona.ZonaId := Query.FieldByName('zonaid').AsInteger;
          ObjProduto.Endereco.EnderecamentoZona.Descricao := Query.FieldByName('zonadescricao').AsString;
          ObjProduto.Endereco.EnderecamentoZona.EstoqueTipoId := Query.FieldByName('EstoqueTipoId').AsInteger;
          ObjProduto.Endereco.EnderecamentoZona.RastroId := Query.FieldByName('ZonaRastroId').AsInteger;
          ObjProduto.Endereco.EnderecamentoZona.LoteReposicao := Query.FieldByName('LoteReposicao').AsInteger;
          ObjProduto.Endereco.EnderecamentoZona.SeparacaoConsolidada := Query.FieldByName('SeparacaoConsolidada').AsInteger;
          ObjProduto.Endereco.EnderecamentoZona.ProdutoSNGPC := Query.FieldByName('ProdutoSNGPC').AsInteger;
          ObjProduto.EnderecamentoZona.Status := Query.FieldByName('zonastatus').AsInteger;
          // Incluir Dados adicionais da Zona - ver select GSS em 09012021
          ObjProduto.Endereco.DesenhoArmazem.Id := Query.FieldByName('DesenhoArmazemId').AsInteger;
          ObjProduto.Endereco.DesenhoArmazem.Descricao := Query.FieldByName('DesenhoArmazemDescricao').AsString;
          ObjProduto.Endereco.DesenhoArmazem.Status := Query.FieldByName('DesenhoArmazemStatus').AsInteger;
          // Zona de Armazenamento
          ObjProduto.EnderecamentoZona.ZonaId := Query.FieldByName('armazenamentozonaid').AsInteger;
          ObjProduto.EnderecamentoZona.Descricao := Query.FieldByName('armazenamentozona').AsString;
          ObjProduto.EnderecamentoZona.Status := Query.FieldByName('armazenamentozonastatus').AsInteger;
          ObjProduto.Importado := Query.FieldByName('Importado').AsInteger = 1;
          ObjProduto.MedicamentoTipo.Id := Query.FieldByName('MedicamentoTipoId').AsInteger;
          ObjProduto.MedicamentoTipo.Descricao := Query.FieldByName('MedicamentoTipoDescricao').AsString;
          ObjProduto.SNGPC := Query.FieldByName('SNGPC').AsInteger = 1;
          // ObjProduto.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
          // ObjProduto.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
          ObjProduto.Laboratorio.IdLaboratorio := Query.FieldByName('LaboratorioId').AsInteger;
          ObjProduto.Laboratorio.Nome := Query.FieldByName('LaboratorioNome').AsString;
          ObjProduto.Peso := Query.FieldByName('PesoLiquido').AsFloat;
          ObjProduto.Liquido := Query.FieldByName('Liquido').AsInteger = 1;
          ObjProduto.Perigoso := Query.FieldByName('Perigoso').AsInteger = 1;
          ObjProduto.Inflamavel := Query.FieldByName('Inflamavel').AsInteger = 1;
          ObjProduto.Medicamento := Query.FieldByName('Medicamento').AsInteger = 1;
          ObjProduto.SNGPC := Query.FieldByName('Sngpc').AsInteger = 1;
          ObjProduto.Altura := Query.FieldByName('Altura').AsFloat;
          ObjProduto.Largura := Query.FieldByName('Largura').AsFloat;
          ObjProduto.Comprimento := Query.FieldByName('Comprimento').AsFloat;
          ObjProduto.QtdReposicao := Query.FieldByName('QtdReposicao').AsInteger;
          ObjProduto.PercReposicao := Query.FieldByName('PercReposicao').AsInteger;
          ObjProduto.MinPicking := Query.FieldByName('MinPicking').AsInteger;
          ObjProduto.MaxPicking := Query.FieldByName('MaxPicking').AsInteger;
          ObjProduto.MesEntradaMinima := Query.FieldByName('MesEntradaMinima').AsInteger;
          ObjProduto.MesSaidaMinima := Query.FieldByName('MesSaidaMinima').AsInteger;
          ObjProduto.Status             := Query.FieldByName('Status').AsInteger;
          ObjProduto.BloqueioInventario := Query.FieldByName('BloqueioInventario').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjProduto));
          Query.Next;
        End;
        // (ObjProduto.ClassToJson(ObjProduto).ToString);
      End;
      // sleep(500);
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetPicking(Service) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProduto.GetProduto(AQueryParam: TDictionary<String, String>) : TJsonArray;
Var ObjProduto: TProduto;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('if object_id ('+#39+'tempdb..#Produto'+#39+') is not null Drop table #Produto');
      Query.SQL.Add('if object_id ('+#39+'tempdb..#BarraMain'+#39+') is not null Drop table #BarraMain');
      Query.SQL.Add('select Distinct Prd.* Into #Produto');
      Query.SQL.Add('From vproduto Prd WITH (READUNCOMMITTED)');
      Query.SQL.Add('Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Prd.IdProduto');
      Query.SQL.Add('Where 1 = 1');
  //    Query.SQL.Add('  And (Prd.CodProduto = @CodProduto or Cb.CodBarras = @CodBarras)');
      if AQueryParam.ContainsKey('codigoerp') then begin
         Query.SQL.Add(' And (Cast(CodProduto as VarChar) = :pCodigoERP or Cb.CodBarras = :pCodBarra)');
         Query.ParamByName('pCodigoERP').AsString := AQueryParam.Items['codigoerp']; //.ToInt64;
         Query.ParamByName('pCodBarra').AsString  := AQueryParam.Items['codigoerp'];
         Query.SQL.Add('--CodigoERP = '+AQueryParam.Items['codigoerp']);
      end;
      if AQueryParam.ContainsKey('produtoid') then begin
         Query.SQL.Add(' And (Cast(IdProduto as Varchar) = :pProdutoId or Cb.CodBarras = :pCodBarra)');
         Query.ParamByName('pProdutoId').AsString := AQueryParam.Items['produtoid']; //.ToInt64;
         Query.ParamByName('pCodBarra').AsString  := AQueryParam.Items['produtoid'];
         //pProdutoId := AQueryParam.Items['produtoid'];
      end;
      if AQueryParam.ContainsKey('descricao') then begin
         Query.SQL.Add(' And (Prd.Descricao Like :pDescricao or Prd.DescrReduzida = :pDescrReduzida)');
         Query.ParamByName('pDescricao').Value := '%' + AQueryParam.Items['descricao'] + '%';
         Query.ParamByName('pDescrReduzida').Value := '%' + AQueryParam.Items['descricao'] + '%';
      end;
      Query.SQL.Add('');
      Query.SQL.Add('select Top 1 Pc.ProdutoId, CodBarras Into #BarraMain');
      Query.SQL.Add('From ProdutoCodBarras Pc');
      Query.SQL.Add('inner join #Produto Prd ON Prd.IdProduto = Pc.Produtoid');
      Query.SQL.Add('');
      Query.SQL.Add('Select Prd.*, Pc.CodBarras EanPrincipal');
      Query.SQL.Add('From #Produto PRd');
      Query.SQL.Add('Left Join #BarraMain Pc On Pc.ProdutoId = Prd.IdProduto');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('GetProdutoService.Sql');
      Query.Open;
      if Query.IsEmpty then
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Produto não encontrado na pesquisa!')))
      Else Begin
         ObjProduto := TProduto.Create;
         While Not Query.Eof do Begin
           ObjProduto.IdProduto    := Query.FieldByName('IdProduto').AsInteger;
           ObjProduto.CodProduto   := Query.FieldByName('CodProduto').AsInteger;
           ObjProduto.EanPrincipal := Query.FieldByName('EanPrincipal').AsString;
           ObjProduto.Descricao    := Query.FieldByName('Descricao').AsString;
           ObjProduto.DescricaoRed := Query.FieldByName('DescrReduzida').AsString;
           ObjProduto.CodigoMS     := Query.FieldByName('CodigoMS').AsString;
           // ObjProduto.ProdutoControle.IdControle := FConexao.Query.FieldByName('IdControle').AsInteger;
           // ObjProduto.ProdutoControle.Descricao  := FConexao.Query.FieldByName('DescrControle').AsString;
           // ObjProduto.ProdutoControle.Status     := FConexao.Query.FieldByName('StatusControle').AsInteger;
           ObjProduto.Rastro.RastroId  := Query.FieldByName('RastroId').AsInteger;
           ObjProduto.Rastro.Descricao := Query.FieldByName('RastroDescricao').AsString;
           ObjProduto.Rastro.Status    := Query.FieldByName('RastroStatus').AsInteger;
           // JSon ProdutoTipo
           ObjProduto.ProdutoTipo.Id        := Query.FieldByName('ProdutoTipoId').AsInteger;
           ObjProduto.ProdutoTipo.Descricao := Query.FieldByName('ProdutoTipoDescricao').AsString;
           ObjProduto.ProdutoTipo.Status    := Query.FieldByName('ProdutoTipoStatus').AsInteger;

           ObjProduto.Unid.Id        := Query.FieldByName('UnidadeId').AsInteger;
           ObjProduto.Unid.Descricao := Query.FieldByName('UnidadeDescricao').AsString;
           ObjProduto.Unid.Sigla     := Query.FieldByName('UnidadeSigla').AsString;
           ObjProduto.Unid.Status    := Query.FieldByName('UnidadeStatus').AsInteger;
           ObjProduto.QtdUnid        := Query.FieldByName('QtdUnid').AsInteger;
           ObjProduto.UnidSecundaria.Id        := Query.FieldByName('UnidadeSecundariaId').AsInteger;
           ObjProduto.UnidSecundaria.Descricao := Query.FieldByName('UnidadeSecundariaDescricao').AsString;
           ObjProduto.UnidSecundaria.Sigla     := Query.FieldByName('UnidadeSecundariaSigla').AsString;
           ObjProduto.UnidSecundaria.Status    := Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
           ObjProduto.FatorConversao           := Query.FieldByName('FatorConversao').AsInteger;
           ObjProduto.SomenteCxaFechada        := Query.FieldByName('SomenteCxaFechada').AsInteger;
           // Enderecamento de Picking
           ObjProduto.Endereco.EnderecoId := Query.FieldByName('EnderecoId').AsInteger;
           ObjProduto.Endereco.Descricao  := Query.FieldByName('EnderecoDescricao').AsString;
           ObjProduto.Endereco.EnderecoEstrutura.EstruturaId := Query.FieldByName('EstruturaId').AsInteger;
           ObjProduto.Endereco.EnderecoEstrutura.Descricao   := Query.FieldByName('EstruturaDescricao').AsString;
           ObjProduto.Endereco.EnderecoEstrutura.Mascara     := Query.FieldByName('mascara').AsString;
           ObjProduto.Endereco.EnderecoRua.RuaId     := Query.FieldByName('RuaId').AsInteger;
           ObjProduto.Endereco.EnderecoRua.Descricao := Query.FieldByName('RuaDescricao').AsString;
           ObjProduto.Endereco.EnderecoRua.Lado      := Query.FieldByName('RuaLado').AsString;
           ObjProduto.Endereco.EnderecoRua.Ordem     := Query.FieldByName('RuaOrdem').AsInteger;
           ObjProduto.Endereco.EnderecoRua.Status    := Query.FieldByName('RuaStatus').AsInteger;
           ObjProduto.Endereco.Status                := Query.FieldByName('EnderecoStatus').AsInteger;
           // Zona do Endereco
           ObjProduto.Endereco.EnderecamentoZona.ZonaId        := Query.FieldByName('zonaid').AsInteger;
           ObjProduto.Endereco.EnderecamentoZona.Descricao     := Query.FieldByName('zonadescricao').AsString;
           ObjProduto.Endereco.EnderecamentoZona.EstoqueTipoId := Query.FieldByName('EstoqueTipoId').AsInteger;
           ObjProduto.Endereco.EnderecamentoZona.RastroId      := Query.FieldByName('ZonaRastroId').AsInteger;
           ObjProduto.Endereco.EnderecamentoZona.LoteReposicao := Query.FieldByName('LoteReposicao').AsInteger;
           ObjProduto.Endereco.EnderecamentoZona.SeparacaoConsolidada := Query.FieldByName('SeparacaoConsolidada').AsInteger;
           ObjProduto.Endereco.EnderecamentoZona.ProdutoSNGPC  := Query.FieldByName('ProdutoSNGPC').AsInteger;

           ObjProduto.EnderecamentoZona.Status          := Query.FieldByName('zonastatus').AsInteger;
           // Incluir Dados adicionais da Zona - ver select GSS em 09012021
           ObjProduto.Endereco.DesenhoArmazem.Id        := Query.FieldByName('DesenhoArmazemId').AsInteger;
           ObjProduto.Endereco.DesenhoArmazem.Descricao := Query.FieldByName('DesenhoArmazemDescricao').AsString;
           ObjProduto.Endereco.DesenhoArmazem.Status    := Query.FieldByName('DesenhoArmazemStatus').AsInteger;
           // Zona de Armazenamento
           ObjProduto.EnderecamentoZona.ZonaId    := Query.FieldByName('armazenamentozonaid').AsInteger;
           ObjProduto.EnderecamentoZona.Descricao := Query.FieldByName('armazenamentozona').AsString;
           ObjProduto.EnderecamentoZona.Status    := Query.FieldByName('armazenamentozonastatus').AsInteger;

           ObjProduto.Importado                 := Query.FieldByName('Importado').AsInteger = 1;
           ObjProduto.MedicamentoTipo.Id        := Query.FieldByName('MedicamentoTipoId').AsInteger;
           ObjProduto.MedicamentoTipo.Descricao := Query.FieldByName('MedicamentoTipoDescricao').AsString;
           ObjProduto.SNGPC := Query.FieldByName('SNGPC').AsInteger = 1;

           // ObjProduto.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
           // ObjProduto.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
           ObjProduto.Laboratorio.IdLaboratorio := Query.FieldByName('LaboratorioId').AsInteger;
           ObjProduto.Laboratorio.Nome          := Query.FieldByName('LaboratorioNome').AsString;
           ObjProduto.Peso                      := Query.FieldByName('PesoLiquido').AsFloat;
           ObjProduto.Liquido                   := Query.FieldByName('Liquido').AsInteger = 1;
           ObjProduto.Perigoso                  := Query.FieldByName('Perigoso').AsInteger = 1;
           ObjProduto.Inflamavel                := Query.FieldByName('Inflamavel').AsInteger = 1;
           ObjProduto.Medicamento               := Query.FieldByName('Medicamento').AsInteger = 1;
           ObjProduto.SNGPC                     := Query.FieldByName('Sngpc').AsInteger = 1;
           ObjProduto.Altura                    := Query.FieldByName('Altura').AsFloat;
           ObjProduto.Largura                   := Query.FieldByName('Largura').AsFloat;
           ObjProduto.Comprimento               := Query.FieldByName('Comprimento').AsFloat;
           ObjProduto.QtdReposicao              := Query.FieldByName('QtdReposicao').AsInteger;
           ObjProduto.PercReposicao             := Query.FieldByName('PercReposicao').AsInteger;
           ObjProduto.MinPicking                := Query.FieldByName('MinPicking').AsInteger;
           ObjProduto.MaxPicking                := Query.FieldByName('MaxPicking').AsInteger;
           ObjProduto.MesEntradaMinima          := Query.FieldByName('MesEntradaMinima').AsInteger;
           ObjProduto.MesSaidaMinima            := Query.FieldByName('MesSaidaMinima').AsInteger;
           ObjProduto.Status                    := Query.FieldByName('Status').AsInteger;
           ObjProduto.BloqueioInventario        := Query.FieldByName('bloqueioinventario').AsInteger;
           Result.AddElement(tJson.ObjectToJsonObject(ObjProduto));
           Query.Next;
        End;
        // (ObjProduto.ClassToJson(ObjProduto).ToString);
      End;
      // sleep(500);
    Except ON E: Exception do
      raise Exception.Create('Processo: GetProduto(Service) - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProduto.ImportEan(pJsonArray: TJsonArray): TJsonArray;
Var xProduto: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := TJsonArray.Create;
      if pJsonArray = Nil then Begin
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
               .AddPair('produto', TJsonNumber.Create(0)).AddPair('ean', '')
               .AddPair('mensagem', 'JsonArray enviado incorreto.'));
         FreeAndNil(Query);
         Exit;
      End;
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ImportEAN - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProduto.AtualizarCubagem(pJsonObjectProduto: TJsonObject) : TJsonArray;
Var xProduto: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := TJsonArray.Create;
      Query.connection.StartTransaction;
      Query.connection.TxOptions.Isolation := xiReadCommitted;
      Query.Close;
      Query.SQL.Add('Declare @codproduto  Integer     = :pCodProduto');
      Query.SQL.Add('Declare @Peso        Float       = :pPeso');
      Query.SQL.Add('Declare @Altura      Float       = :paltura');
      Query.SQL.Add('Declare @largura     Float       = :pLargura');
      Query.SQL.Add('Declare @Comprimento Float       = :pComprimento');
      Query.SQL.Add('Declare @UsuarioId   Integer     = :pUsuarioId');
      Query.SQL.Add('Declare @Terminal    VarChar(50) = :pTerminal');
      Query.SQL.Add('update Produto');
      Query.SQL.Add('  Set PesoLiquido = @Peso');
      Query.SQL.Add('     ,Altura      = @Altura');
      Query.SQL.Add('     ,Largura     = @largura');
      Query.SQL.Add('     ,Comprimento = @Comprimento');
      Query.SQL.Add('Where CodProduto  = @CodProduto');
      Query.SQL.Add('If Exists (Select ProdutoId From ProdutoCubagemIntegracao ');
      Query.SQL.Add('           Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0) Begin');
      Query.SQL.Add('   Update ProdutoCubagemIntegracao');
      Query.SQL.Add('     Set PesoLiquido = @Peso');
      Query.SQL.Add('        ,Altura = @Altura');
      Query.SQL.Add('        ,Largura = @largura');
      Query.SQL.Add('        ,Comprimento = @Comprimento');
      Query.SQL.Add('        ,UsuarioId = @UsuarioId');
      Query.SQL.Add('        ,Terminal  = @Terminal');
      Query.SQL.Add('        ,Data = GetDate()');
      Query.SQL.Add('        ,Hora = GetDate()');
      Query.SQL.Add('   Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0');
      Query.SQL.Add('End');
      Query.SQL.Add('Else Begin');
      Query.SQL.Add('   Insert Into ProdutoCubagemIntegracao Values ((Select IdProduto From Produto Where CodProduto = @CodProduto),');
      Query.SQL.Add('              @Altura, @largura, @Comprimento, @Peso, ');
      Query.SQL.Add('              @UsuarioId, GetDate(), GetDate(), @Terminal, 0)');
      Query.SQL.Add('End');
      Query.ParamByName('pCodProduto').Value := pJsonObjectProduto.GetValue<Integer>('codproduto');
      // StrToFloatDef(StringReplace(pjSonObjectProduto.GetValue<String>('peso'), '.', ',', []), 0),
      Query.ParamByName('pAltura').Value := pJsonObjectProduto.GetValue<Double>('altura');
      Query.ParamByName('pLargura').Value := pJsonObjectProduto.GetValue<Double>('largura');
      Query.ParamByName('pComprimento').Value := pJsonObjectProduto.GetValue<Double>('comprimento');
      Query.ParamByName('pPeso').Value := pJsonObjectProduto.GetValue<Double>('peso');
      Query.ParamByName('pUsuarioId').Value := pJsonObjectProduto.GetValue<Integer>('usuarioid');
      Query.ParamByName('pTerminal').Value := pJsonObjectProduto.GetValue<string>('terminal');
      if DebugHook <> 0 Then
         Query.SQL.SaveToFile('AtualizarCubagem.Sql');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: AtualizarCubagem - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProduto.AtualizarCubagemIntegracao(pJsonObjectProduto
  : TJsonObject): TJsonArray;
Var xProduto: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Try
      Result := TJsonArray.Create;
      Query.connection.StartTransaction;
      Query.Close;
      Query.SQL.Add('Declare @codproduto  Integer     = :pCodProduto');
      Query.SQL.Add('Declare @Peso        Float       = :pPeso');
      Query.SQL.Add('Declare @Altura      Float       = :paltura');
      Query.SQL.Add('Declare @largura     Float       = :pLargura');
      Query.SQL.Add('Declare @Comprimento Float       = :pComprimento');
      Query.SQL.Add('Declare @UsuarioId   Integer     = :pUsuarioId');
      Query.SQL.Add('Declare @Terminal    VarChar(50) = :pTerminal');
      Query.SQL.Add('If Exists (Select ProdutoId From ProdutoCubagemIntegracao ');
      Query.SQL.Add('           Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0) Begin');
      Query.SQL.Add('   Update ProdutoCubagemIntegracao');
      Query.SQL.Add('     Set PesoLiquido = @Peso');
      Query.SQL.Add('        ,Altura = @Altura');
      Query.SQL.Add('        ,Largura = @largura');
      Query.SQL.Add('        ,Comprimento = @Comprimento');
      Query.SQL.Add('        ,UsuarioId = @UsuarioId');
      Query.SQL.Add('        ,Terminal  = @Terminal');
      Query.SQL.Add('        ,Data = GetDate()');
      Query.SQL.Add('        ,Hora = GetDate()');
      Query.SQL.Add('   Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0');
      Query.SQL.Add('End');
      Query.SQL.Add('Else Begin');
      Query.SQL.Add('   Insert Into ProdutoCubagemIntegracao Values ((Select IdProduto From Produto Where CodProduto = @CodProduto),');
      Query.SQL.Add('              @Altura, @largura, @Comprimento, @Peso, ');
      Query.SQL.Add('              @UsuarioId, GetDate(), GetDate(), @Terminal, 0)');
      Query.SQL.Add('End');
      Query.ParamByName('pCodProduto').Value := pJsonObjectProduto.GetValue<Integer>('codproduto');
      // StrToFloatDef(StringReplace(pjSonObjectProduto.GetValue<String>('peso'), '.', ',', []), 0),
      Query.ParamByName('pAltura').Value := pJsonObjectProduto.GetValue<Double>('altura');
      Query.ParamByName('pLargura').Value := pJsonObjectProduto.GetValue<Double>('largura');
      Query.ParamByName('pComprimento').Value := pJsonObjectProduto.GetValue<Double>('comprimento');
      Query.ParamByName('pPeso').Value := pJsonObjectProduto.GetValue<Double>('peso');
      Query.ParamByName('pUsuarioId').Value := pJsonObjectProduto.GetValue<Integer>('usuarioid');
      Query.ParamByName('pTerminal').Value := pJsonObjectProduto.GetValue<string>('terminal');
      if DebugHook <> 0 Then
         Query.SQL.SaveToFile('AtualizarCubagem.Sql');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: AtualizarCubagemIntegracao - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProduto.AtualizarRastreabilidade(pProdutoId,
  pRastroId: Integer): TJsonArray;
Var xProduto: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
       Query.SQL.Clear;
       Query.Close;
       Query.SQL.Add('Update Produto');
       Query.SQL.Add('  Set RastroId = :pRastroId');
       Query.SQL.Add('Where IdProduto = :pProdutoId');
       Query.ParamByName('pProdutoId').Value := pProdutoId;
       Query.ParamByName('pRastroid').Value := pRastroId;
       if DebugHook <> 0 Then
          Query.SQL.SaveToFile('AtualizarRastreabilidade.Sql');
       Query.ExecSQL;
       Query.Close;
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
     Except On E: Exception do
       Begin
         raise Exception.Create('Processo: AtualizarRastreabilidade - '+TUtil.TratarExcessao(E.Message));
       End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

constructor TServiceProduto.Create;
begin
  inherited;
end;

destructor TServiceProduto.Destroy;
begin
  inherited;
end;

function TServiceProduto.GetCodProdutoEan(pCodProduto: String): TJsonObject;
Var Query : TFdQuery;
begin
  Try
    Query := TFDQuery.Create(nil);
    Try
      Query.Connection := Connection;
      Query.Connection.ResourceOptions.CmdExecTimeout := 60000;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlGetProduto);
      Query.ParamByName('pProdutoid').Value := pCodProduto;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('produtoEan.Sql');
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
        Result := Query.ToJSONObject;
      End;
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetCodProdutoEAN(Service) - ' +Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
