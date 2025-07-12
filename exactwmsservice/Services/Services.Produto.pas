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
Var
  pProdutoId, pCodigoERP: String;
  ObjProduto: TProduto;
begin
  Result := TJsonArray.Create;
  Try
    FConexao.Query.SQL.Add('select Vp.*, (Select Top 1 CodBarras');
    FConexao.Query.SQL.Add('                    From ProdutoCodBarras ');
    FConexao.Query.SQL.Add
      ('                    where ProdutoId = Vp.IdProduto and Principal = 1');
    FConexao.Query.SQL.Add
      ('                    Order by Principal Desc) As EanPrincipal');
    FConexao.Query.SQL.Add('From vproduto Vp WITH (READUNCOMMITTED)');
    // FConexao.Query.SQL.Add('Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Vp.IdProduto');
    FConexao.Query.SQL.Add('Where EnderecoDescricao = ' + QuotedStr(pPicking));
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('GetPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Produto não encontrado para este Picking na pesquisa!')))
    Else
    Begin
      ObjProduto := TProduto.Create;
      While Not FConexao.Query.Eof do
      Begin
        ObjProduto.IdProduto := FConexao.Query.FieldByName('IdProduto')
          .AsInteger;
        ObjProduto.CodProduto := FConexao.Query.FieldByName('CodProduto')
          .AsInteger;
        ObjProduto.EanPrincipal := FConexao.Query.FieldByName
          ('EanPrincipal').AsString;
        ObjProduto.Descricao := FConexao.Query.FieldByName('Descricao')
          .AsString;
        ObjProduto.DescricaoRed := FConexao.Query.FieldByName
          ('DescrReduzida').AsString;
        ObjProduto.CodigoMS := FConexao.Query.FieldByName('CodigoMS').AsString;

        // ObjProduto.ProdutoControle.IdControle := FConexao.Query.FieldByName('IdControle').AsInteger;
        // ObjProduto.ProdutoControle.Descricao  := FConexao.Query.FieldByName('DescrControle').AsString;
        // ObjProduto.ProdutoControle.Status     := FConexao.Query.FieldByName('StatusControle').AsInteger;
        ObjProduto.Rastro.RastroId := FConexao.Query.FieldByName('RastroId')
          .AsInteger;
        ObjProduto.Rastro.Descricao := FConexao.Query.FieldByName
          ('RastroDescricao').AsString;
        ObjProduto.Rastro.Status := FConexao.Query.FieldByName('RastroStatus')
          .AsInteger;

        // JSon ProdutoTipo
        ObjProduto.ProdutoTipo.Id := FConexao.Query.FieldByName('ProdutoTipoId')
          .AsInteger;
        ObjProduto.ProdutoTipo.Descricao := FConexao.Query.FieldByName
          ('ProdutoTipoDescricao').AsString;
        ObjProduto.ProdutoTipo.Status := FConexao.Query.FieldByName
          ('ProdutoTipoStatus').AsInteger;

        ObjProduto.Unid.Id := FConexao.Query.FieldByName('UnidadeId').AsInteger;
        ObjProduto.Unid.Descricao := FConexao.Query.FieldByName
          ('UnidadeDescricao').AsString;
        ObjProduto.Unid.Sigla := FConexao.Query.FieldByName
          ('UnidadeSigla').AsString;
        ObjProduto.Unid.Status := FConexao.Query.FieldByName('UnidadeStatus')
          .AsInteger;
        ObjProduto.QtdUnid := FConexao.Query.FieldByName('QtdUnid').AsInteger;
        ObjProduto.UnidSecundaria.Id := FConexao.Query.FieldByName
          ('UnidadeSecundariaId').AsInteger;
        ObjProduto.UnidSecundaria.Descricao :=
          FConexao.Query.FieldByName('UnidadeSecundariaDescricao').AsString;
        ObjProduto.UnidSecundaria.Sigla := FConexao.Query.FieldByName
          ('UnidadeSecundariaSigla').AsString;
        ObjProduto.UnidSecundaria.Status := FConexao.Query.FieldByName
          ('UnidadeSecundariaStatus').AsInteger;
        ObjProduto.FatorConversao := FConexao.Query.FieldByName
          ('FatorConversao').AsInteger;
        ObjProduto.SomenteCxaFechada := FConexao.Query.FieldByName
          ('SomenteCxaFechada').AsInteger;
        // Enderecamento de Picking
        ObjProduto.Endereco.EnderecoId := FConexao.Query.FieldByName
          ('EnderecoId').AsInteger;
        ObjProduto.Endereco.Descricao := FConexao.Query.FieldByName
          ('EnderecoDescricao').AsString;
        ObjProduto.Endereco.EnderecoEstrutura.EstruturaId :=
          FConexao.Query.FieldByName('EstruturaId').AsInteger;
        ObjProduto.Endereco.EnderecoEstrutura.Descricao :=
          FConexao.Query.FieldByName('EstruturaDescricao').AsString;
        ObjProduto.Endereco.EnderecoEstrutura.Mascara :=
          FConexao.Query.FieldByName('mascara').AsString;
        ObjProduto.Endereco.EnderecoRua.RuaId :=
          FConexao.Query.FieldByName('RuaId').AsInteger;
        ObjProduto.Endereco.EnderecoRua.Descricao :=
          FConexao.Query.FieldByName('RuaDescricao').AsString;
        ObjProduto.Endereco.EnderecoRua.Lado :=
          FConexao.Query.FieldByName('RuaLado').AsString;
        ObjProduto.Endereco.EnderecoRua.Ordem :=
          FConexao.Query.FieldByName('RuaOrdem').AsInteger;
        ObjProduto.Endereco.EnderecoRua.Status :=
          FConexao.Query.FieldByName('RuaStatus').AsInteger;
        ObjProduto.Endereco.Status := FConexao.Query.FieldByName
          ('EnderecoStatus').AsInteger;
        // Zona do Endereco
        ObjProduto.Endereco.EnderecamentoZona.ZonaId :=
          FConexao.Query.FieldByName('zonaid').AsInteger;
        ObjProduto.Endereco.EnderecamentoZona.Descricao :=
          FConexao.Query.FieldByName('zonadescricao').AsString;
        ObjProduto.Endereco.EnderecamentoZona.EstoqueTipoId :=
          FConexao.Query.FieldByName('EstoqueTipoId').AsInteger;
        ObjProduto.Endereco.EnderecamentoZona.RastroId :=
          FConexao.Query.FieldByName('ZonaRastroId').AsInteger;
        ObjProduto.Endereco.EnderecamentoZona.LoteReposicao :=
          FConexao.Query.FieldByName('LoteReposicao').AsInteger;
        ObjProduto.Endereco.EnderecamentoZona.SeparacaoConsolidada :=
          FConexao.Query.FieldByName('SeparacaoConsolidada').AsInteger;
        ObjProduto.Endereco.EnderecamentoZona.ProdutoSNGPC :=
          FConexao.Query.FieldByName('ProdutoSNGPC').AsInteger;

        ObjProduto.EnderecamentoZona.Status :=
          FConexao.Query.FieldByName('zonastatus').AsInteger;
        // Incluir Dados adicionais da Zona - ver select GSS em 09012021
        ObjProduto.Endereco.DesenhoArmazem.Id :=
          FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        ObjProduto.Endereco.DesenhoArmazem.Descricao :=
          FConexao.Query.FieldByName('DesenhoArmazemDescricao').AsString;
        ObjProduto.Endereco.DesenhoArmazem.Status :=
          FConexao.Query.FieldByName('DesenhoArmazemStatus').AsInteger;
        // Zona de Armazenamento
        ObjProduto.EnderecamentoZona.ZonaId :=
          FConexao.Query.FieldByName('armazenamentozonaid').AsInteger;
        ObjProduto.EnderecamentoZona.Descricao :=
          FConexao.Query.FieldByName('armazenamentozona').AsString;
        ObjProduto.EnderecamentoZona.Status :=
          FConexao.Query.FieldByName('armazenamentozonastatus').AsInteger;

        ObjProduto.Importado := FConexao.Query.FieldByName('Importado')
          .AsInteger = 1;
        ObjProduto.MedicamentoTipo.Id := FConexao.Query.FieldByName
          ('MedicamentoTipoId').AsInteger;
        ObjProduto.MedicamentoTipo.Descricao :=
          FConexao.Query.FieldByName('MedicamentoTipoDescricao').AsString;
        ObjProduto.SNGPC := FConexao.Query.FieldByName('SNGPC').AsInteger = 1;

        // ObjProduto.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
        // ObjProduto.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
        ObjProduto.Laboratorio.IdLaboratorio :=
          FConexao.Query.FieldByName('LaboratorioId').AsInteger;
        ObjProduto.Laboratorio.Nome := FConexao.Query.FieldByName
          ('LaboratorioNome').AsString;
        ObjProduto.Peso := FConexao.Query.FieldByName('PesoLiquido').AsFloat;
        ObjProduto.Liquido := FConexao.Query.FieldByName('Liquido')
          .AsInteger = 1;
        ObjProduto.Perigoso := FConexao.Query.FieldByName('Perigoso')
          .AsInteger = 1;
        ObjProduto.Inflamavel := FConexao.Query.FieldByName('Inflamavel')
          .AsInteger = 1;
        ObjProduto.Medicamento := FConexao.Query.FieldByName('Medicamento')
          .AsInteger = 1;
        ObjProduto.SNGPC := FConexao.Query.FieldByName('Sngpc').AsInteger = 1;
        ObjProduto.Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        ObjProduto.Largura := FConexao.Query.FieldByName('Largura').AsFloat;
        ObjProduto.Comprimento := FConexao.Query.FieldByName
          ('Comprimento').AsFloat;
        ObjProduto.QtdReposicao := FConexao.Query.FieldByName('QtdReposicao')
          .AsInteger;
        ObjProduto.PercReposicao := FConexao.Query.FieldByName('PercReposicao')
          .AsInteger;
        ObjProduto.MinPicking := FConexao.Query.FieldByName('MinPicking')
          .AsInteger;
        ObjProduto.MaxPicking := FConexao.Query.FieldByName('MaxPicking')
          .AsInteger;
        ObjProduto.MesEntradaMinima := FConexao.Query.FieldByName
          ('MesEntradaMinima').AsInteger;
        ObjProduto.MesSaidaMinima := FConexao.Query.FieldByName
          ('MesSaidaMinima').AsInteger;
        ObjProduto.Status             := FConexao.Query.FieldByName('Status').AsInteger;
        ObjProduto.BloqueioInventario := FConexao.Query.FieldByName('BloqueioInventario').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjProduto));
        FConexao.Query.Next;
      End;
      // (ObjProduto.ClassToJson(ObjProduto).ToString);
    End;
    // sleep(500);
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetPicking(Service) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServiceProduto.GetProduto(AQueryParam: TDictionary<String, String>)
  : TJsonArray;
Var
  //pProdutoId, pCodigoERP: String;
  ObjProduto: TProduto;
begin
  Result := TJsonArray.Create;
  Try
    FConexao.Query.SQL.Add('if object_id ('+#39+'tempdb..#Produto'+#39+') is not null Drop table #Produto');
    FConexao.Query.SQL.Add('if object_id ('+#39+'tempdb..#BarraMain'+#39+') is not null Drop table #BarraMain');
    FConexao.Query.SQL.Add('select Distinct Prd.* Into #Produto');
    FConexao.Query.SQL.Add('From vproduto Prd WITH (READUNCOMMITTED)');
    FConexao.Query.SQL.Add('Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Prd.IdProduto');
    FConexao.Query.SQL.Add('Where 1 = 1');
//    FConexao.Query.SQL.Add('  And (Prd.CodProduto = @CodProduto or Cb.CodBarras = @CodBarras)');
    if AQueryParam.ContainsKey('codigoerp') then begin
        FConexao.Query.SQL.Add(' And (Cast(CodProduto as VarChar) = :pCodigoERP or Cb.CodBarras = :pCodBarra)');
        FConexao.Query.ParamByName('pCodigoERP').AsString := AQueryParam.Items['codigoerp']; //.ToInt64;
        FConexao.Query.ParamByName('pCodBarra').AsString  := AQueryParam.Items['codigoerp'];
        FConexao.Query.SQL.Add('--CodigoERP = '+AQueryParam.Items['codigoerp']);
    end;
    if AQueryParam.ContainsKey('produtoid') then begin
       FConexao.Query.SQL.Add(' And (Cast(IdProduto as Varchar) = :pProdutoId or Cb.CodBarras = :pCodBarra)');
       FConexao.Query.ParamByName('pProdutoId').AsString := AQueryParam.Items['produtoid']; //.ToInt64;
       FConexao.Query.ParamByName('pCodBarra').AsString  := AQueryParam.Items['produtoid'];
       //pProdutoId := AQueryParam.Items['produtoid'];
    end;
    if AQueryParam.ContainsKey('descricao') then begin
       FConexao.Query.SQL.Add(' And (Prd.Descricao Like :pDescricao or Prd.DescrReduzida = :pDescrReduzida)');
       FConexao.Query.ParamByName('pDescricao').Value := '%' + AQueryParam.Items['descricao'] + '%';
       FConexao.Query.ParamByName('pDescrReduzida').Value := '%' + AQueryParam.Items['descricao'] + '%';
    end;

    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('select Top 1 Pc.ProdutoId, CodBarras Into #BarraMain');
    FConexao.Query.SQL.Add('From ProdutoCodBarras Pc');
    FConexao.Query.SQL.Add('inner join #Produto Prd ON Prd.IdProduto = Pc.Produtoid');
    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('Select Prd.*, Pc.CodBarras EanPrincipal');
    FConexao.Query.SQL.Add('From #Produto PRd');
    FConexao.Query.SQL.Add('Left Join #BarraMain Pc On Pc.ProdutoId = Prd.IdProduto');
{    FConexao.Query.SQL.Add('select Distinct Vp.*, (Select Top 1 CodBarras');
    FConexao.Query.SQL.Add('                    From ProdutoCodBarras ');
    FConexao.Query.SQL.Add('                    where ProdutoId = Vp.IdProduto and Principal = 1');
    FConexao.Query.SQL.Add('                    Order by Principal Desc) As EanPrincipal');
    FConexao.Query.SQL.Add('From vproduto Vp WITH (READUNCOMMITTED)');
    FConexao.Query.SQL.Add('Left join ProdutoCodBarras CB WITH (READUNCOMMITTED) ON Cb.ProdutoId = Vp.IdProduto');
    FConexao.Query.SQL.Add('Where 1 = 1');
}
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('GetProdutoService.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
       Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Produto não encontrado na pesquisa!')))
    Else Begin
       ObjProduto := TProduto.Create;
       While Not FConexao.Query.Eof do Begin
         ObjProduto.IdProduto    := FConexao.Query.FieldByName('IdProduto').AsInteger;
         ObjProduto.CodProduto   := FConexao.Query.FieldByName('CodProduto').AsInteger;
         ObjProduto.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
         ObjProduto.Descricao    := FConexao.Query.FieldByName('Descricao').AsString;
         ObjProduto.DescricaoRed := FConexao.Query.FieldByName('DescrReduzida').AsString;
         ObjProduto.CodigoMS     := FConexao.Query.FieldByName('CodigoMS').AsString;

         // ObjProduto.ProdutoControle.IdControle := FConexao.Query.FieldByName('IdControle').AsInteger;
         // ObjProduto.ProdutoControle.Descricao  := FConexao.Query.FieldByName('DescrControle').AsString;
         // ObjProduto.ProdutoControle.Status     := FConexao.Query.FieldByName('StatusControle').AsInteger;
         ObjProduto.Rastro.RastroId  := FConexao.Query.FieldByName('RastroId').AsInteger;
         ObjProduto.Rastro.Descricao := FConexao.Query.FieldByName('RastroDescricao').AsString;
         ObjProduto.Rastro.Status    := FConexao.Query.FieldByName('RastroStatus').AsInteger;

         // JSon ProdutoTipo
         ObjProduto.ProdutoTipo.Id        := FConexao.Query.FieldByName('ProdutoTipoId').AsInteger;
         ObjProduto.ProdutoTipo.Descricao := FConexao.Query.FieldByName('ProdutoTipoDescricao').AsString;
         ObjProduto.ProdutoTipo.Status    := FConexao.Query.FieldByName('ProdutoTipoStatus').AsInteger;

         ObjProduto.Unid.Id        := FConexao.Query.FieldByName('UnidadeId').AsInteger;
         ObjProduto.Unid.Descricao := FConexao.Query.FieldByName('UnidadeDescricao').AsString;
         ObjProduto.Unid.Sigla     := FConexao.Query.FieldByName('UnidadeSigla').AsString;
         ObjProduto.Unid.Status    := FConexao.Query.FieldByName('UnidadeStatus').AsInteger;
         ObjProduto.QtdUnid        := FConexao.Query.FieldByName('QtdUnid').AsInteger;
         ObjProduto.UnidSecundaria.Id        := FConexao.Query.FieldByName('UnidadeSecundariaId').AsInteger;
         ObjProduto.UnidSecundaria.Descricao := FConexao.Query.FieldByName('UnidadeSecundariaDescricao').AsString;
         ObjProduto.UnidSecundaria.Sigla     := FConexao.Query.FieldByName('UnidadeSecundariaSigla').AsString;
         ObjProduto.UnidSecundaria.Status    := FConexao.Query.FieldByName('UnidadeSecundariaStatus').AsInteger;
         ObjProduto.FatorConversao           := FConexao.Query.FieldByName('FatorConversao').AsInteger;
         ObjProduto.SomenteCxaFechada        := FConexao.Query.FieldByName('SomenteCxaFechada').AsInteger;
         // Enderecamento de Picking
         ObjProduto.Endereco.EnderecoId := FConexao.Query.FieldByName('EnderecoId').AsInteger;
         ObjProduto.Endereco.Descricao  := FConexao.Query.FieldByName('EnderecoDescricao').AsString;
         ObjProduto.Endereco.EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId').AsInteger;
         ObjProduto.Endereco.EnderecoEstrutura.Descricao   := FConexao.Query.FieldByName('EstruturaDescricao').AsString;
         ObjProduto.Endereco.EnderecoEstrutura.Mascara     := FConexao.Query.FieldByName('mascara').AsString;
         ObjProduto.Endereco.EnderecoRua.RuaId     := FConexao.Query.FieldByName('RuaId').AsInteger;
         ObjProduto.Endereco.EnderecoRua.Descricao := FConexao.Query.FieldByName('RuaDescricao').AsString;
         ObjProduto.Endereco.EnderecoRua.Lado      := FConexao.Query.FieldByName('RuaLado').AsString;
         ObjProduto.Endereco.EnderecoRua.Ordem     := FConexao.Query.FieldByName('RuaOrdem').AsInteger;
         ObjProduto.Endereco.EnderecoRua.Status    := FConexao.Query.FieldByName('RuaStatus').AsInteger;
         ObjProduto.Endereco.Status                := FConexao.Query.FieldByName('EnderecoStatus').AsInteger;
         // Zona do Endereco
         ObjProduto.Endereco.EnderecamentoZona.ZonaId        := FConexao.Query.FieldByName('zonaid').AsInteger;
         ObjProduto.Endereco.EnderecamentoZona.Descricao     := FConexao.Query.FieldByName('zonadescricao').AsString;
         ObjProduto.Endereco.EnderecamentoZona.EstoqueTipoId := FConexao.Query.FieldByName('EstoqueTipoId').AsInteger;
         ObjProduto.Endereco.EnderecamentoZona.RastroId      := FConexao.Query.FieldByName('ZonaRastroId').AsInteger;
         ObjProduto.Endereco.EnderecamentoZona.LoteReposicao := FConexao.Query.FieldByName('LoteReposicao').AsInteger;
         ObjProduto.Endereco.EnderecamentoZona.SeparacaoConsolidada := FConexao.Query.FieldByName('SeparacaoConsolidada').AsInteger;
         ObjProduto.Endereco.EnderecamentoZona.ProdutoSNGPC  := FConexao.Query.FieldByName('ProdutoSNGPC').AsInteger;

         ObjProduto.EnderecamentoZona.Status          := FConexao.Query.FieldByName('zonastatus').AsInteger;
         // Incluir Dados adicionais da Zona - ver select GSS em 09012021
         ObjProduto.Endereco.DesenhoArmazem.Id        := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
         ObjProduto.Endereco.DesenhoArmazem.Descricao := FConexao.Query.FieldByName('DesenhoArmazemDescricao').AsString;
         ObjProduto.Endereco.DesenhoArmazem.Status    := FConexao.Query.FieldByName('DesenhoArmazemStatus').AsInteger;
         // Zona de Armazenamento
         ObjProduto.EnderecamentoZona.ZonaId    := FConexao.Query.FieldByName('armazenamentozonaid').AsInteger;
         ObjProduto.EnderecamentoZona.Descricao := FConexao.Query.FieldByName('armazenamentozona').AsString;
         ObjProduto.EnderecamentoZona.Status    := FConexao.Query.FieldByName('armazenamentozonastatus').AsInteger;

         ObjProduto.Importado                 := FConexao.Query.FieldByName('Importado').AsInteger = 1;
         ObjProduto.MedicamentoTipo.Id        := FConexao.Query.FieldByName('MedicamentoTipoId').AsInteger;
         ObjProduto.MedicamentoTipo.Descricao := FConexao.Query.FieldByName('MedicamentoTipoDescricao').AsString;
         ObjProduto.SNGPC := FConexao.Query.FieldByName('SNGPC').AsInteger = 1;

         // ObjProduto.EanPrincipal := FConexao.Query.FieldByName('EanPrincipal').AsString;
         // ObjProduto.UnidMedIndustrial := FConexao.Query.FieldByName('IdUnidadeIndustrial').AsInteger;
         ObjProduto.Laboratorio.IdLaboratorio := FConexao.Query.FieldByName('LaboratorioId').AsInteger;
         ObjProduto.Laboratorio.Nome          := FConexao.Query.FieldByName('LaboratorioNome').AsString;
         ObjProduto.Peso                      := FConexao.Query.FieldByName('PesoLiquido').AsFloat;
         ObjProduto.Liquido                   := FConexao.Query.FieldByName('Liquido').AsInteger = 1;
         ObjProduto.Perigoso                  := FConexao.Query.FieldByName('Perigoso').AsInteger = 1;
         ObjProduto.Inflamavel                := FConexao.Query.FieldByName('Inflamavel').AsInteger = 1;
         ObjProduto.Medicamento               := FConexao.Query.FieldByName('Medicamento').AsInteger = 1;
         ObjProduto.SNGPC                     := FConexao.Query.FieldByName('Sngpc').AsInteger = 1;
         ObjProduto.Altura                    := FConexao.Query.FieldByName('Altura').AsFloat;
         ObjProduto.Largura                   := FConexao.Query.FieldByName('Largura').AsFloat;
         ObjProduto.Comprimento               := FConexao.Query.FieldByName('Comprimento').AsFloat;
         ObjProduto.QtdReposicao              := FConexao.Query.FieldByName('QtdReposicao').AsInteger;
         ObjProduto.PercReposicao             := FConexao.Query.FieldByName('PercReposicao').AsInteger;
         ObjProduto.MinPicking                := FConexao.Query.FieldByName('MinPicking').AsInteger;
         ObjProduto.MaxPicking                := FConexao.Query.FieldByName('MaxPicking').AsInteger;
         ObjProduto.MesEntradaMinima          := FConexao.Query.FieldByName('MesEntradaMinima').AsInteger;
         ObjProduto.MesSaidaMinima            := FConexao.Query.FieldByName('MesSaidaMinima').AsInteger;
         ObjProduto.Status                    := FConexao.Query.FieldByName('Status').AsInteger;
         ObjProduto.BloqueioInventario        := FConexao.Query.FieldByName('bloqueioinventario').AsInteger;
         Result.AddElement(tJson.ObjectToJsonObject(ObjProduto));
         FConexao.Query.Next;
      End;
      // (ObjProduto.ClassToJson(ObjProduto).ToString);
    End;
    // sleep(500);
  Except ON E: Exception do
    raise Exception.Create('Processo: GetProduto(Service) - '+TUtil.TratarExcessao(E.Message));
  end;

end;

function TServiceProduto.ImportEan(pJsonArray: TJsonArray): TJsonArray;
Var
  xProduto: Integer;
begin
  Try
    Result := TJsonArray.Create;
    if pJsonArray = Nil then Begin
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('produto', TJsonNumber.Create(0)).AddPair('ean', '')
        .AddPair('mensagem', 'JsonArray enviado incorreto.'));
      Exit;
    End;
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
  Except On E: Exception do
    Begin
      raise Exception.Create('Processo: ImportEAN - ' + TUtil.TratarExcessao(E.Message));
    End;
  End;
end;

function TServiceProduto.AtualizarCubagem(pJsonObjectProduto: TJsonObject)
  : TJsonArray;
Var
  xProduto: Integer;
begin
  Try
    Result := TJsonArray.Create;
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
    FConexao.Query.Close;
    FConexao.Query.SQL.Add('Declare @codproduto  Integer     = :pCodProduto');
    FConexao.Query.SQL.Add('Declare @Peso        Float       = :pPeso');
    FConexao.Query.SQL.Add('Declare @Altura      Float       = :paltura');
    FConexao.Query.SQL.Add('Declare @largura     Float       = :pLargura');
    FConexao.Query.SQL.Add('Declare @Comprimento Float       = :pComprimento');
    FConexao.Query.SQL.Add('Declare @UsuarioId   Integer     = :pUsuarioId');
    FConexao.Query.SQL.Add('Declare @Terminal    VarChar(50) = :pTerminal');
    FConexao.Query.SQL.Add('update Produto');
    FConexao.Query.SQL.Add('  Set PesoLiquido = @Peso');
    FConexao.Query.SQL.Add('     ,Altura      = @Altura');
    FConexao.Query.SQL.Add('     ,Largura     = @largura');
    FConexao.Query.SQL.Add('     ,Comprimento = @Comprimento');
    FConexao.Query.SQL.Add('Where CodProduto  = @CodProduto');
    FConexao.Query.SQL.Add
      ('If Exists (Select ProdutoId From ProdutoCubagemIntegracao ');
    FConexao.Query.SQL.Add
      ('           Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0) Begin');
    FConexao.Query.SQL.Add('   Update ProdutoCubagemIntegracao');
    FConexao.Query.SQL.Add('     Set PesoLiquido = @Peso');
    FConexao.Query.SQL.Add('        ,Altura = @Altura');
    FConexao.Query.SQL.Add('        ,Largura = @largura');
    FConexao.Query.SQL.Add('        ,Comprimento = @Comprimento');
    FConexao.Query.SQL.Add('        ,UsuarioId = @UsuarioId');
    FConexao.Query.SQL.Add('        ,Terminal  = @Terminal');
    FConexao.Query.SQL.Add('        ,Data = GetDate()');
    FConexao.Query.SQL.Add('        ,Hora = GetDate()');
    FConexao.Query.SQL.Add
      ('   Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0');
    FConexao.Query.SQL.Add('End');
    FConexao.Query.SQL.Add('Else Begin');
    FConexao.Query.SQL.Add
      ('   Insert Into ProdutoCubagemIntegracao Values ((Select IdProduto From Produto Where CodProduto = @CodProduto),');
    FConexao.Query.SQL.Add
      ('              @Altura, @largura, @Comprimento, @Peso, ');
    FConexao.Query.SQL.Add
      ('              @UsuarioId, GetDate(), GetDate(), @Terminal, 0)');
    FConexao.Query.SQL.Add('End');
    FConexao.Query.ParamByName('pCodProduto').Value :=
      pJsonObjectProduto.GetValue<Integer>('codproduto');
    // StrToFloatDef(StringReplace(pjSonObjectProduto.GetValue<String>('peso'), '.', ',', []), 0),
    FConexao.Query.ParamByName('pAltura').Value :=
      pJsonObjectProduto.GetValue<Double>('altura');
    FConexao.Query.ParamByName('pLargura').Value :=
      pJsonObjectProduto.GetValue<Double>('largura');
    FConexao.Query.ParamByName('pComprimento').Value :=
      pJsonObjectProduto.GetValue<Double>('comprimento');
    FConexao.Query.ParamByName('pPeso').Value :=
      pJsonObjectProduto.GetValue<Double>('peso');
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      pJsonObjectProduto.GetValue<Integer>('usuarioid');
    FConexao.Query.ParamByName('pTerminal').Value :=
      pJsonObjectProduto.GetValue<string>('terminal');
    if DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('AtualizarCubagem.Sql');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
    FConexao.Query.connection.Commit;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: AtualizarCubagem - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceProduto.AtualizarCubagemIntegracao(pJsonObjectProduto
  : TJsonObject): TJsonArray;
Var
  xProduto: Integer;
begin
  Try
    Result := TJsonArray.Create;

    FConexao.Query.connection.StartTransaction;
    FConexao.Query.Close;
    FConexao.Query.SQL.Add('Declare @codproduto  Integer     = :pCodProduto');
    FConexao.Query.SQL.Add('Declare @Peso        Float       = :pPeso');
    FConexao.Query.SQL.Add('Declare @Altura      Float       = :paltura');
    FConexao.Query.SQL.Add('Declare @largura     Float       = :pLargura');
    FConexao.Query.SQL.Add('Declare @Comprimento Float       = :pComprimento');
    FConexao.Query.SQL.Add('Declare @UsuarioId   Integer     = :pUsuarioId');
    FConexao.Query.SQL.Add('Declare @Terminal    VarChar(50) = :pTerminal');
    FConexao.Query.SQL.Add
      ('If Exists (Select ProdutoId From ProdutoCubagemIntegracao ');
    FConexao.Query.SQL.Add
      ('           Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0) Begin');
    FConexao.Query.SQL.Add('   Update ProdutoCubagemIntegracao');
    FConexao.Query.SQL.Add('     Set PesoLiquido = @Peso');
    FConexao.Query.SQL.Add('        ,Altura = @Altura');
    FConexao.Query.SQL.Add('        ,Largura = @largura');
    FConexao.Query.SQL.Add('        ,Comprimento = @Comprimento');
    FConexao.Query.SQL.Add('        ,UsuarioId = @UsuarioId');
    FConexao.Query.SQL.Add('        ,Terminal  = @Terminal');
    FConexao.Query.SQL.Add('        ,Data = GetDate()');
    FConexao.Query.SQL.Add('        ,Hora = GetDate()');
    FConexao.Query.SQL.Add
      ('   Where ProdutoId = (Select IdProduto From Produto Where CodProduto = @CodProduto) and Status = 0');
    FConexao.Query.SQL.Add('End');
    FConexao.Query.SQL.Add('Else Begin');
    FConexao.Query.SQL.Add
      ('   Insert Into ProdutoCubagemIntegracao Values ((Select IdProduto From Produto Where CodProduto = @CodProduto),');
    FConexao.Query.SQL.Add
      ('              @Altura, @largura, @Comprimento, @Peso, ');
    FConexao.Query.SQL.Add
      ('              @UsuarioId, GetDate(), GetDate(), @Terminal, 0)');
    FConexao.Query.SQL.Add('End');
    FConexao.Query.ParamByName('pCodProduto').Value :=
      pJsonObjectProduto.GetValue<Integer>('codproduto');
    // StrToFloatDef(StringReplace(pjSonObjectProduto.GetValue<String>('peso'), '.', ',', []), 0),
    FConexao.Query.ParamByName('pAltura').Value :=
      pJsonObjectProduto.GetValue<Double>('altura');
    FConexao.Query.ParamByName('pLargura').Value :=
      pJsonObjectProduto.GetValue<Double>('largura');
    FConexao.Query.ParamByName('pComprimento').Value :=
      pJsonObjectProduto.GetValue<Double>('comprimento');
    FConexao.Query.ParamByName('pPeso').Value :=
      pJsonObjectProduto.GetValue<Double>('peso');
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      pJsonObjectProduto.GetValue<Integer>('usuarioid');
    FConexao.Query.ParamByName('pTerminal').Value :=
      pJsonObjectProduto.GetValue<string>('terminal');
    if DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('AtualizarCubagem.Sql');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
    FConexao.Query.connection.Commit;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: AtualizarCubagem - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceProduto.AtualizarRastreabilidade(pProdutoId,
  pRastroId: Integer): TJsonArray;
Var xProduto: Integer;
begin
  Try
    FConexao.Query.SQL.Clear;
    FConexao.Query.Close;
    FConexao.Query.SQL.Add('Update Produto');
    FConexao.Query.SQL.Add('  Set RastroId = :pRastroId');
    FConexao.Query.SQL.Add('Where IdProduto = :pProdutoId');
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    FConexao.Query.ParamByName('pRastroid').Value := pRastroId;
    if DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('AtualizarRastreabilidade.Sql');
    FConexao.Query.ExecSQL;
    FConexao.Query.Close;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('status', '200'));

  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;

      raise Exception.Create('Processo: AtualizarRastrebilidade - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
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
begin
  Try
    //FConexao.GetQuery;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetProduto);
    FConexao.Query.ParamByName('pProdutoid').Value := pCodProduto;
    if DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('produtoEan.Sql');
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
      Result := FConexao.Query.ToJSONObject;
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetCodProdutoEAN(Service) - ' +Tutil.TratarExcessao(E.Message));
    End;
  end;
end;

end.
