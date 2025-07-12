{
   ProdutoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit ProdutoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     ProdutoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);

  TProdutoCtrl = Class
  Private
    //Funções de Validação
    FObjProduto : TProduto;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindProduto(pIdProduto : String = '0'; pCodigoERP : String = '0'; pNome : String = ''; pRecsSkip : Integer = 0; ShowErro : Integer = 1; pPicking : String = '') : tJsonArray; //TObjectList<TProduto>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function GetProduto(pProdutoId : String) : TObjectList<TProduto>;
    Function GetProdutoJson(pCodigoERP : String) : TJsonArray;
    Function GetCodigoERP(pCodigoERP : String) : TObjectList<TProduto>;
    Function GetCodigoERPJson(pCodigoERP : String = '0'; pShowErro : Integer = 0) : TJsonArray;
    Class Function GetCodProdEan(pCodProdEan : String) : Integer;
    Class Function GetEan(pCodProdEan : String) : TJsonObject;
    Class Function DelProduto(pIdProduto : Integer) : Boolean;
    Property ObjProduto  : TProduto Read FObjProduto Write FObjProduto;
    Class Function GetPickingMask : String;
    Function MontarPaginacao : Integer;
    Function EnderecarProduto(pProdutoId, pEnderecoId : Integer) : TJsonArray;
    Function ImportDados(pCodProduto : Integer; pDescricao : String; pUnidade : String; pEmbalagem : Integer;
                         pLaboratorioId : Integer; pFabricante : String; pSngpc : Integer; pCurva : String) : Boolean;
    Function ImportDadosV2(pJsonObjectProduto : TJsonObject) : TJsonArray;
    Function ImportCubagem(pCodProduto : Integer; pAltura, pLargura, pComprimento: Double) : Boolean;
    Function ImportCubagemDC(pCodProduto : Integer; pFatorConversao, pAltura, pLargura, pComprimento, pPeso : Double;
                             pEan01, pEan02, pEan03, pEan04, pEan05,
                             pEan06, pEan07, pEan08, pEan09, pEan10 : String; pSomentePadrao : Integer ) : Boolean;
    Function ImportEstoque(pCodProduto : Integer; pEndereco : String; pQuantidade : Double) : Boolean;
    Function ImportEnderecamento(pCodProduto : Integer; pEndereco : String) : TJsonArray;
    Function ImportEan(pCodProduto : Integer; pEan : String; pQtdEmbalagem : Integer) : TJsonArray;
    Function GetProdutoList(pProdutoId, pCodigoERP, pEnderecoId, pZonaId : Integer; pEan : String) : TJsonArray;
    Function GetProdutoLotes(pProdutoId : Integer; pDescricao : String) : TJsonArray;
    Function ExportFile(pCampos : String) : TJsonArray;
    Function GetRelProdutos01(pEstoque, pSemPicking, pCodProduto, pZonaId, pLaboratorioId, pListaEan, pSomenteCxaFechada, pAtivo, pBloqueado : Integer) : TJsonArray;
    Function AtualizarCubagem(pCodProduto : Integer; pPeso, pAltura, pLargura, pComprimento : Real;
                                                  pUsuarioId : Integer; pNomeDoComputador : String) : TJsonArray;
    Function AtualizarCubagemIntegracao(pCodProduto : Integer; pPeso, pAltura, pLargura, pComprimento : Real;
                                                  pUsuarioId : Integer; pNomeDoComputador : String) : TJsonArray;
    Function AtualizarRastreabilidade(pProdutoid, pRastroId : Integer) : TJsonArray;
    Function UpdatePicking(pCodProduto : Integer) : TJsonArray;
  End;

implementation

{ tCtrlProduto }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tProdutoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjProduto do Begin
    if Descricao = '' then raise Exception.Create('Informe o Nome do Produto!');
    if Rastro.RastroId <=0 then raise Exception.Create('Informe o tipo de Rastreabilidade para o Produto!');
    if Laboratorio.IdLaboratorio <=0 then raise Exception.Create('Informe o Fabricante do Produto!');
    if ProdutoTipo.id <=0 then raise Exception.Create('Informe o tipo do Produto!');
    if Unid.id <=0 then raise Exception.Create('Informe a Unidade Primária para o Produto!');
    if UnidSecundaria.id <=0 then raise Exception.Create('Informe a Unidade Secundária(Caixa Fechada) para o Produto!');
    if QtdUnid <= 0 then raise Exception.Create('Quantidade para Unidade Primária é inválida!');
    if FatorConversao <= 0 then raise Exception.Create('Fator de Conversão para Unidade Secundária é inválida!');
    if QtdUnid > FatorConversao then raise Exception.Create('Fator de Conversão para Unidade Secundária precisa ser maior que Qtd. Unid. Primária!');
    if Peso <= 0 then raise Exception.Create('Informe o peso bruto do produto!');
    if Altura <= 0 then raise Exception.Create('Informe a Altura do produto!');
    if Largura <= 0 then raise Exception.Create('Informe a Largura do produto!');
    if Comprimento <= 0 then raise Exception.Create('Informe o comprimento do produto!');
    if Volume <= 0 then raise Exception.Create('Informe os dados para Cubagem de Volume corretamente!');
    if (MesEntradaMinima < 0) or (MesSaidaMinima<0) then raise Exception.Create('Dados para Shelf Life do produto é inválido');
    if (MaxPicking < 0) or (QtdReposicao < 0) or (PercReposicao < 0 ) then raise Exception.Create('Dados para Reposição inválidos!');
  End;
  Result := True;
End;

function TProdutoCtrl.AtualizarCubagem(pCodProduto: Integer; pPeso, pAltura,
  pLargura, pComprimento: Real; pUsuarioId: Integer;
  pNomeDoComputador: String): TJsonArray;
Var JsonCubagem : TJsonObject;
begin
  JsonCubagem := TJsonObject.Create;
  JsonCubagem.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonCubagem.AddPair('peso', TJsonNumber.Create(pPeso));
  JsonCubagem.AddPair('altura', TJsonNumber.Create(pAltura));
  JsonCubagem.AddPair('largura', TJsonNumber.Create(pLargura));
  JsonCubagem.AddPair('comprimento', TJsonNumber.Create(pComprimento));
  JsonCubagem.AddPair('usuarioid', TJsonNumber.Create(pUsuarioId));
  JsonCubagem.AddPair('terminal', pNomeDoComputador);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/atualizarcubagem';
  DmeXactWMS.RestRequestWMS.AddBody(jSonCubagem.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method := rmPUT;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode In [200, 201, 204]) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  End
  Else
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  JsonCubagem.Free;
end;

function TProdutoCtrl.AtualizarCubagemIntegracao(pCodProduto: Integer; pPeso,
  pAltura, pLargura, pComprimento: Real; pUsuarioId: Integer;
  pNomeDoComputador: String): TJsonArray;
Var JsonCubagem : TJsonObject;
begin
  JsonCubagem := TJsonObject.Create;
  JsonCubagem.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonCubagem.AddPair('peso', TJsonNumber.Create(pPeso));
  JsonCubagem.AddPair('altura', TJsonNumber.Create(pAltura));
  JsonCubagem.AddPair('largura', TJsonNumber.Create(pLargura));
  JsonCubagem.AddPair('comprimento', TJsonNumber.Create(pComprimento));
  JsonCubagem.AddPair('usuarioid', TJsonNumber.Create(pUsuarioId));
  JsonCubagem.AddPair('terminal', pNomeDoComputador);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/atualizarcubagemintegracao';
  DmeXactWMS.RestRequestWMS.AddBody(jSonCubagem.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Method := rmPUT;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode In [200, 201, 204]) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  End
  Else
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  JsonCubagem.Free;
end;

function TProdutoCtrl.AtualizarRastreabilidade(pProdutoid,
  pRastroId: Integer): TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/atualizarrastreabilidade/{produtoid}/{rastroid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rastroid', pRastroId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('não foi atualizar rastreabilidade!');
end;

constructor TProdutoCtrl.Create;
begin
  FObjProduto := TProduto.Create;
end;

class function TProdutoCtrl.DelProduto(pIdProduto : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdProduto.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     //ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TProdutoCtrl.Destroy;
begin
  FObjProduto.Free;
  inherited;
end;

function TProdutoCtrl.EnderecarProduto(pProdutoId,
  pEnderecoId: Integer): TJsonArray;
Var jSonEnderecarProduto : TJsonObject;
begin
  jSonEnderecarProduto := TJsonObject.Create;
  jSonEnderecarProduto.AddPair('produtoid', TJSONNumber.Create(pProdutoid));
  jSonEnderecarProduto.AddPair('enderecoid', TJSONNumber.Create(pEnderecoId));
  jSonEnderecarProduto.AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  {$IfDef Android}
     jSonEnderecarProduto.AddPair('estacao', IMEI); //IMEI;
  {$else}
     jSonEnderecarProduto.AddPair('estacao', NomeDoComputador);
  {$ENdif}
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEnderecarProduto.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/enderecar';
  DmeXactWMS.RESTRequestWMS.Method := rmPUT;
  DmeXactWMS.RESTRequestWMS.Execute;
  jSonEnderecarProduto := nil;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TProdutoCtrl.ExportFile(pCampos: String): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/exportfile?campos='+pCampos;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
       (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
       Result := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJsonArray
    End
    Else
      raise Exception.Create(DmeXactWMS.RESTResponseWMS.Content);
  Except On E: Exception do
      raise Exception.Create('Erro:' +E.Message);
  End;
end;

//                      FindProduto(pIdProduto : String = '0'; pCodigoERP : String = '0'; pNome : String = ''; pRecsSkip : Integer = 0; ShowErro : Integer = 1) : tJsonArray; //TObjectList<TProduto>;
Function tProdutoCtrl.FindProduto(pIdProduto : String; pCodigoERP : String; pNome : String; pRecsSkip : Integer    ; ShowErro : Integer; pPicking : String): tJsonArray;
Var jSonProduto, JSonProdutoTipo, JsonRastro, JsonMedicamentoTipo, JSonLaboratorio,
    JSonUnidade, JSonUnidadeSecundaria, JSonEnderecamentoZona, JSonEndereco, JsonEnderecoRua, jsonEnderecoEstrutura,
    JSonDesenhoArmazem : tJsonObject;
    xItens      : Integer;
    vErro       : String;
Begin
Try
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pIdProduto <> '0' then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdProduto);
  End
  Else if pPicking <> '' then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/picking/{picking}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('picking', pPicking);
  End
  Else if pCodigoERP <> '0' then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/codigoerp/{codigoerp}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codigoerp', pCodigoERP);
  End
  else Begin
    if pNome = '' then
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto'
    Else Begin
       DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/{id}/{descricao}';
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdProduto);
       DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pnome);
    End;
    //DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource + '?RecsMax=5&RecsSkip='+pRecsSkip.ToString;
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if Result.Items[0].TryGetValue('Erro', vErro) then
        If ShowErro = 1 then
           raise Exception.Create(vErro)
        Else Begin
          //Result := TJsonArray.Create;
          Exit;
        End;
     if Result.Count >= 1 then Begin
        xItens := 0;
       // repeat

          jSonProduto := tJsonObject.Create;
          jSonProduto := Result.Items[xItens] as TJSONObject;

          FObjProduto.IdProduto     := StrToIntDef(GetValueInjSon(jSonProduto, 'idProduto'), 0);
          FObjProduto.CodProduto    := StrToIntDef(GetValueInjSon(jSonProduto, 'Codproduto'), 0);
          FObjProduto.Descricao     := GetValueInjSon(jSonProduto, 'Descricao');
          FObjProduto.DescricaoRed  := GetValueInjSon(jSonProduto, 'DescricaoRed');
          FObjProduto.CodigoMS      := GetValueInjSon(jSonProduto, 'codigoMS');
          JSonRastro := TJsonObject.Create;
          JSonRastro := jSonProduto.GetValue('rastro') as TJSONObject;
          FObjProduto.Rastro.RastroId := StrToIntDef(GetValueInjSon(JSonRastro, 'rastroid'), 0); //Tipo de Produto
          FObjProduto.Rastro.Descricao  := GetValueInjSon(JSonRastro, 'descricao');
          FObjProduto.Rastro.Status     := StrToIntDef(GetValueInjSon(JSonRastro, 'status'), 0);
          JSonProdutoTipo := TJsonObject.Create;
          JSonProdutoTipo := jSonProduto.GetValue('produtoTipo') as TJSONObject;
          FObjProduto.ProdutoTipo.Id        := StrToIntDef(GetValueInjSon(JSonProdutoTipo, 'Id'), 0); //Tipo de Produto
          FObjProduto.ProdutoTipo.Descricao := GetValueInjSon(JSonProdutoTipo, 'Descricao');
          FObjProduto.ProdutoTipo.Status    := StrToIntDef(GetValueInjSon(JSonProdutoTipo, 'Status'), 0);
          JsonMedicamentoTipo := TJsonObject.Create;
          JSonMedicamentoTipo := jSonProduto.GetValue('medicamentoTipo') as TJSONObject;
          FObjProduto.MedicamentoTipo.Id        := StrToIntDef(GetValueInjSon(JSonMedicamentoTipo, 'Id'), 0);
          FObjProduto.MedicamentoTipo.Descricao := GetValueInjSon(JSonMedicamentoTipo, 'Descricao');
          FObjProduto.MedicamentoTipo.Status    := StrToIntDef(GetValueInjSon(JSonMedicamentoTipo, 'Status'), 0);
          JSonLaboratorio := TJsonObject.Create;
          JSonlaboratorio := jSonProduto.GetValue('laboratorio') as TJSONObject;
          FObjProduto.Laboratorio.IdLaboratorio := StrToIntDef(GetValueInjSon(JSonLaboratorio, 'IdLaboratorio'), 0);
          FObjProduto.Laboratorio.Nome          := GetValueInjSon(JSonLaboratorio, 'Nome');
          FObjProduto.Laboratorio.Fone          := GetValueInjSon(JSonLaboratorio, 'fone');
          FObjProduto.Laboratorio.Email         := GetValueInjSon(JSonLaboratorio, 'email');
          FObjProduto.Laboratorio.HomePage      := GetValueInjSon(JSonLaboratorio, 'homepage');
          FObjProduto.Laboratorio.Status        := StrToIntDef(GetValueInjSon(JSonLaboratorio, 'status'), 0);
          FObjProduto.SNGPC                     := StrToIntDef(GetValueInjSon(JSonProduto, 'SNGPC'), 0) =  1;
          JSonEndereco := TJsonObject.Create;
          JSonEndereco := jSonProduto.GetValue('endereco') as TJSONObject;
          FObjProduto.Endereco.EnderecoId  := StrToIntDef(GetValueInjSon(JSonEndereco, 'EnderecoId'), 0);
          FObjProduto.Endereco.Descricao   := JSonEndereco.GetValue<String>('descricao');
          FObjProduto.Endereco.Status      := JsonEndereco.GetValue<Integer>('status');
          JSonEnderecoRua := jSonEndereco.GetValue('enderecoRua') as TJSONObject;
          FObjProduto.Endereco.EnderecoRua.RuaId     := JSonEnderecoRua.GetValue<Integer>('ruaId', 0);
          FObjProduto.Endereco.EnderecoRua.Descricao := JSonEnderecoRua.GetValue<String>('descricao');
          FObjProduto.Endereco.EnderecoRua.Lado      := JSonEnderecoRua.GetValue<String>('lado');
          FObjProduto.Endereco.EnderecoRua.Ordem     := JSonEnderecoRua.GetValue<Integer>('ordem');
          FObjProduto.Endereco.EnderecoRua.Status    := JSonEnderecoRua.GetValue<Integer>('status', 1);

          jsonEnderecoEstrutura := jsonEndereco.GetValue('enderecoEstrutura') as TJSONObject;
          FObjProduto.Endereco.EnderecoEstrutura.EstruturaId := StrToIntDef(GetValueInjSon(jsonEnderecoEstrutura, 'EnderecoEstruturaId'), 0);
          FObjProduto.Endereco.EnderecoEstrutura.Mascara     := GetValueInjSon(jsonEnderecoEstrutura, 'mascara');
          JSonEnderecamentoZona := jsonEndereco.GetValue('enderecamentoZona') as TJSONObject;
          FObjProduto.Endereco.EnderecamentoZona.ZonaId      := StrToIntDef(GetValueInjSon(JSonEnderecamentoZona, 'zonaid'), 0);
          FObjProduto.Endereco.EnderecamentoZona.Descricao   := JSonEnderecamentoZona.GetValue<String>('descricao');
          FObjProduto.Endereco.EnderecamentoZona.Status      := JSonEnderecamentoZona.GetValue<Integer>('status');
          JSonDesenhoArmazem := TJsonObject.Create;
          JSonDesenhoArmazem := JSonEndereco.GetValue('desenhoArmazem') as TJSONObject;
          FObjProduto.Endereco.DesenhoArmazem.Id        := StrToIntDef(GetValueInjSon(JSonDesenhoArmazem, 'id'), 0);
          FObjProduto.Endereco.DesenhoArmazem.Descricao := GetValueInjSon(JSonDesenhoArmazem, 'descricao');
          FObjProduto.Endereco.DesenhoArmazem.Status := StrToIntDef(GetValueInjSon(JSonDesenhoArmazem, 'status'), 0);
          JSonUnidade := TJsonObject.Create;
          JSonUnidade := jSonProduto.GetValue('unid') as TJSONObject;
          FObjProduto.Unid.Id        := StrToIntDef(GetValueInjSon(JSonUnidade, 'Id'), 0);
          FObjProduto.Unid.Descricao := GetValueInjSon(JSonUnidade, 'Descricao');
          FObjProduto.Unid.Sigla     := GetValueInjSon(JSonUnidade, 'Sigla');
          FObjProduto.QtdUnid        := StrToIntDef(GetValueInjSon(JSonProduto, 'QtdUnid'), 0);
          JSonUnidadeSecundaria := TJsonObject.Create;
          JSonUnidadeSecundaria := jSonProduto.GetValue('unidSecundaria') as TJSONObject;
          FObjProduto.UnidSecundaria.id        := StrToIntDef(GetValueInjSon(JSonUnidadeSecundaria, 'Id'), 0);
          FObjProduto.UnidSecundaria.Sigla     := GetValueInjSon(JSonUnidadeSecundaria, 'Sigla');
          FObjProduto.UnidSecundaria.Descricao := GetValueInjSon(JSonUnidadeSecundaria, 'Descricao');
          FObjProduto.UnidSecundaria.Status    := StrToIntDef(GetValueInjSon(JSonUnidadeSecundaria, 'Status'), 0);
          FObjProduto.FatorConversao           := StrTointDef(GetValueInjSon(JSonProduto, 'FatorConversao'), 0);
          FObjProduto.SomenteCxaFechada        := StrTointDef(GetValueInjSon(JSonProduto, 'SomenteCxaFechada'), 0);
          JSonEnderecamentoZona := jsonProduto.GetValue('enderecamentoZona') as TJSONObject;
          FObjProduto.EnderecamentoZona.ZonaId      := StrToIntDef(GetValueInjSon(JSonEnderecamentoZona, 'zonaid'), 0);
          FObjProduto.EnderecamentoZona.Descricao   := JSonEnderecamentoZona.GetValue<String>('descricao');
          FObjProduto.EnderecamentoZona.Status      := JSonEnderecamentoZona.GetValue<Integer>('status');

          FObjProduto.Liquido          := jsonProduto.GetValue<boolean>('liquido');
          FObjProduto.Importado        := jsonProduto.GetValue<boolean>('importado');
          FObjProduto.Inflamavel       := jsonProduto.GetValue<boolean>('inflamavel');
          FObjProduto.Perigoso         := jsonProduto.GetValue<boolean>('perigoso');
          FObjProduto.Medicamento      := jsonProduto.GetValue<boolean>('medicamento');
          FObjProduto.SNGPC            := jsonProduto.GetValue<boolean>('sNGPC');
          FObjProduto.Peso             := JSonProduto.GetValue<Double>('peso');
          FObjProduto.Altura           := JSonProduto.GetValue<Double>('altura');
          FObjProduto.Largura          := JSonProduto.GetValue<Double>('largura');
          FObjProduto.Comprimento      := JSonProduto.GetValue<Double>('comprimento');
          FObjProduto.Volume           := JSonProduto.GetValue<Double>('volume');
          FObjProduto.MinPicking       := StrTointDef(GetValueInjSon(JSonProduto, 'minpicking'), 0);
          FObjProduto.MaxPicking       := StrTointDef(GetValueInjSon(JSonProduto, 'MaxPicking'), 0);
          FObjProduto.QtdReposicao     := StrTointDef(GetValueInjSon(JSonProduto, 'QtdReposicao'), 0);
          FObjProduto.PercReposicao    := StrTointDef(GetValueInjSon(JSonProduto, 'PercReposicao'), 0);
          FObjProduto.MesEntradaMinima := StrTointDef(GetValueInjSon(JSonProduto, 'MesEntradaMinima'), 0);
          FObjProduto.MesSaidaMinima   := StrTointDef(GetValueInjSon(JSonProduto, 'MesSaidaMinima'), 0);
          FObjProduto.Status           := JSonProduto.GetValue<Integer>('status');
          FObjProduto.BloqueioInventario := JSonProduto.GetValue<Integer>('bloqueioInventario');
          jSonProduto           := Nil;
          JSonProdutoTipo       := Nil;
          JSonRastro            := Nil;
          JsonMedicamentoTipo   := Nil;
          JSonLaboratorio       := Nil;
          JSonUnidade           := Nil;
          JSonUnidadeSecundaria := Nil;
          JSonEnderecamentoZona := Nil;
          JSonEndereco          := Nil;
          JSonDesenhoArmazem    := Nil;
          xItens := xItens + 1;
       // until (xItens > Pred(Result.Count));
//        ExibirDados(DmRhemaWMS.RESTResponseWMS.JSONValue as TJSONArray)
     End
     Else If ShowErro = 1 then
       Raise Exception.Create('Registro não encontrado')
     Else
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Código não encontrado!'));
  End
  Else if ShowErro = 1 then
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText)
  Else Begin
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End;
Except ON E: Exception do
  raise Exception.Create(E.Message);
  End;
End;

function TProdutoCtrl.GetCodigoERP(pCodigoERP: String): TObjectList<TProduto>;
Var ReturnJson  : TJsonArray;
    JsonProduto : TJsonObject;
    xItensPrd   : Integer;
begin
  Result := TObjectList<TProduto>.Create;
  ReturnJson := FindProduto('0', pCodigoERP, '', 0);
  if ReturnJson.Count >= 1 then Begin
     xItensPrd := 0;
     repeat
       JsonProduto := tJsonObject.Create;
       JsonProduto := ReturnJson.Items[xItensPrd] as TJSONObject;
       ObjProduto  := ObjProduto.JsonToClass(JsonProduto.ToString());
       Result.Add(ObjProduto);
       JsonProduto := Nil;
       JsonProduto.DisposeOf;
       Inc(xItensPrd);
     until (xItensPrd > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro de Produto não encontrado');
end;

function TProdutoCtrl.GetCodigoERPJson(pCodigoERP: String = '0'; pShowErro : Integer = 0): TJsonArray;
Var ReturnJson : TJsonArray;
    vErro      : String;
begin
  Result := FindProduto('0', pCodigoERP, '', 0, 0);
  if Result.Items[0].TryGetValue('Erro', vErro) then Begin
     If pShowErro = 1 then
        Raise Exception.Create('Registro de Produto não encontrado');
  End;
end;

Class function TProdutoCtrl.GetCodProdEan(pCodProdEan: String): Integer;
begin
Try
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/pesquisar/{codprodean}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codprodean', pCodProdEan);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := (DmeXactWMS.RESTResponseWMS.JSONValue as tjsonObject).GetValue<Integer>('produtoid', 0);
Except On E: Exception do
  raise Exception.Create(E.Message);
End;
end;

class function TProdutoCtrl.GetEan(pCodProdEan: String): TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/pesquisar/{codprodean}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codprodean', pCodProdEan);
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject;
  End
  Else
    raise Exception.Create(DmeXactWMS.RESTResponseWMS.Content);

end;

class function TProdutoCtrl.GetPickingMask: String;
//Var jsonPickingMask : tjsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/pickingmask';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
//     jsonPickingMask := DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray;
     Result          := (DmeXactWMS.RESTResponseWMS.JSONValue as tjsonArray).Items[0].GetValue<String>('mascara', '');
  End
  Else
    raise Exception.Create('não foi possível definir máscara para o Picking');
end;

function TProdutoCtrl.GetProduto(pProdutoId : String) : TObjectList<TProduto>;
Var ReturnJson  : TJsonArray;
    JsonProduto : TJsonObject;
    xItensPrd   : Integer;
begin
  Result := TObjectList<TProduto>.Create;
  ReturnJson := FindProduto(pProdutoId, '0', '', 0);
  if ReturnJson.Count >= 1 then Begin
     xItensPrd := 0;
     repeat
       JsonProduto := tJsonObject.Create;
       JsonProduto := ReturnJson.Items[xItensPrd] as TJSONObject;
       ObjProduto  := ObjProduto.JsonToClass(JsonProduto.ToString());
       Result.Add(ObjProduto);
       JsonProduto := Nil;
       JsonProduto.DisposeOf;
       Inc(xItensPrd);
     until (xItensPrd > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro de Produto não encontrado');
end;

function TProdutoCtrl.GetProdutoJson(pCodigoERP: String): TJsonArray;
begin
  Result := FindProduto('0', pCodigoERP, '', 0, 0);
end;

function TProdutoCtrl.GetProdutoList(pProdutoId, pCodigoERP, pEnderecoId, pZonaId : Integer; pEan : String): TJsonArray;
Var vLim : String;
begin
  vLim := '?';
  Result := TJsonArray.Create;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/produtolist';
  if pProdutoId <> 0 then begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'produtoid='+pProdutoId.ToString;
     vLim := '&';
  end;
  if pCodigoERP<>0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'codigoerp='+pCodigoERP.Tostring;
     vLim := '&';
  End;
  if pEnderecoId<>0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'enderecoid='+pEnderecoId.ToString();
     vLim := '&';
  End;
  if pZonaId <> 0 then begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'zonaid='+pZonaId.ToString;
     vLim := '&';
  end;
  if pEan <> '' then begin
     DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vLim+'ean='+pEan;
     vLim := '&';
  end;  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    Result.AddElement(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
end;

function TProdutoCtrl.ImportCubagem(pCodProduto : Integer; pAltura, pLargura,
  pComprimento: Double): Boolean;
Var JsonProduto : TJsonObject;
    JsonArrayProduto : TJsonArray;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  JsonProduto := TJsonObject.Create();
  JsonProduto.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonProduto.AddPair('altura',  TJsonNumber.Create(pAltura) );
  JsonProduto.AddPair('largura', TJsonNumber.Create(pLargura));
  JsonProduto.AddPair('comprimento', TJsonNumber.Create(pComprimento));
  JsonArrayProduto := TJsonArray.Create;
  JsonArrayProduto.AddElement( jSonProduto );
  DmeXactWMS.RestRequestWMS.AddBody( JsonArrayProduto.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/importcubagem';
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  JsonProduto.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else Begin
    Result := False;
    raise Exception.Create('Erro: '+pCodProduto.ToString);
  End;
end;

function TProdutoCtrl.ImportCubagemDC(pCodProduto: Integer; pFatorConversao,
  pAltura, pLargura, pComprimento, pPeso: Double; pEan01, pEan02, pEan03,
  pEan04, pEan05, pEan06, pEan07, pEan08, pEan09, pEan10: String; pSomentePadrao : Integer): Boolean;
Var JsonProduto : TJsonObject;
    JsonArrayProduto : TJsonArray;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  JsonProduto := TJsonObject.Create();
  JsonProduto.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonProduto.AddPair('fatorconversao', TJsonNumber.Create(pFatorConversao));
  JsonProduto.AddPair('altura',  TJsonNumber.Create(pAltura) );
  JsonProduto.AddPair('largura', TJsonNumber.Create(pLargura));
  JsonProduto.AddPair('comprimento', TJsonNumber.Create(pComprimento));
  JsonProduto.AddPair('peso', TJsonNumber.Create(pPeso));
  JsonProduto.AddPair('ean01', pEan01);
  JsonProduto.AddPair('ean02', pEan02);
  JsonProduto.AddPair('ean03', pEan03);
  JsonProduto.AddPair('ean04', pEan04);
  JsonProduto.AddPair('ean05', pEan05);
  JsonProduto.AddPair('ean06', pEan06);
  JsonProduto.AddPair('ean07', pEan07);
  JsonProduto.AddPair('ean08', pEan08);
  JsonProduto.AddPair('ean09', pEan09);
  JsonProduto.AddPair('ean10', pEan10);
  JsonProduto.AddPair('somentepadrao', TJsonNumber.Create(pSomentePadrao));
  JsonArrayProduto := TJsonArray.Create;
  JsonArrayProduto.AddElement( jSonProduto );
  DmeXactWMS.RestRequestWMS.AddBody( JsonArrayProduto.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/importcubagemdc';
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  JsonProduto.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else Begin
    Result := False;
    raise Exception.Create('Erro: '+pCodProduto.ToString);
  End;
end;

function TProdutoCtrl.ImportDados(pCodProduto : Integer; pDescricao : String; pUnidade : String; pEmbalagem : Integer;
                                  pLaboratorioId : Integer; pFabricante : String; pSngpc : Integer; pCurva : String): Boolean;
Var JsonProduto : TJsonObject;
    JsonArrayProduto : TJsonArray;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  JsonProduto := TJsonObject.Create();
  JsonProduto.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonProduto.AddPair('descricao',  pDescricao );
  JsonProduto.AddPair('unidadesigla', pUnidade);
  JsonProduto.AddPair('unidade', pUnidade);
  JsonProduto.AddPair('embalagem', TJsonNumber.Create(pEmbalagem));
  JsonProduto.AddPair('laboratorioid', TJsonNumber.Create(pLaboratorioId));
  JsonProduto.AddPair('fabricante', pfabricante);
  JsonProduto.AddPair('sngpc', TJsonNumber.Create(pSngpc));
  JsonProduto.AddPair('curva', pCurva);
  JsonProduto.AddPair('liquido', TJsonNumber.Create(0));
  JsonProduto.AddPair('inflamavel', TJsonNumber.Create(0));
  JsonArrayProduto := TJsonArray.Create;
  JsonArrayProduto.AddElement( jSonProduto );
  DmeXactWMS.RestRequestWMS.AddBody( JsonArrayProduto.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/importdados';
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(JsonProduto);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else Begin
    Result := False;
    raise Exception.Create('Erro: '+pCodProduto.ToString+' '+pDescricao);
  End;
end;

function TProdutoCtrl.ImportDadosV2(pJsonObjectProduto: TJsonObject): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody( pJsonObjectProduto.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v2/produto/importdados';
    DmeXactWMS.RESTRequestWMS.Method := RmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
       (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
    End
    Else Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('codproduto', TJsonNumber.Create(pJsonObjectProduto.GetValue<Integer>('codproduto')))
            .AddPair('mensagem', 'Produto cadastrado/alterado com sucesso!'));
    End;
  Except On E:Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(pJsonObjectProduto.GetValue<Integer>('codproduto')))
          .AddPair('mensagem', 'Produto cadastrado/alterado com sucesso!'));
    End;
  End;
end;

function TProdutoCtrl.ImportEan(pCodProduto: Integer; pEan: String;
  pQtdEmbalagem: Integer): TJsonArray;
Var JsonEan      : TJsonObject;
    JsonArrayEan : TJsonArray;
begin
  //Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  JsonEan := TJsonObject.Create();
  JsonEan.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonEan.AddPair('ean',  pEan );
  JsonEan.AddPair('qtdembalagem',  TJsonNumber.Create(pQtdEmbalagem) );
  JsonArrayEan := TJsonArray.Create;
  JsonArrayEan.AddElement( JsonEan );
  DmeXactWMS.RestRequestWMS.AddBody( JsonArrayEan.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/importean';
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  //JsonEan.Free;
  JsonArrayEan.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else Begin
    //JsonArrayEan.Free;
    raise Exception.Create('Erro: '+pCodProduto.ToString+' '+pEan+' '+DmeXactWMS.RESTResponseWMS.StatusCode.ToString+' '+
                                    DmeXactWMS.RESTResponseWMS.Content);
  End;
end;

function TProdutoCtrl.ImportEnderecamento(pCodProduto: Integer;
  pEndereco: String): TJsonArray;
Var JsonEnderecamento : TJsonObject;
    JsonArrayEnderecamento : TJsonArray;
begin
  //Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  JsonEnderecamento := TJsonObject.Create();
  JsonEnderecamento.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonEnderecamento.AddPair('endereco',  pEndereco );
  JsonArrayEnderecamento := TJsonArray.Create;
  JsonArrayEnderecamento.AddElement( JsonEnderecamento );
  DmeXactWMS.RestRequestWMS.AddBody( JsonArrayEnderecamento.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/importenderecamento';
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  JsonEnderecamento.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else Begin
    //Result := False;
    JsonArrayEnderecamento.Free;
    raise Exception.Create('Erro: '+pCodProduto.ToString+' '+pEndereco);
  End;
 // JsonArrayEnderecamento.Free;
end;

function TProdutoCtrl.ImportEstoque(pCodProduto: Integer; pEndereco: String;
  pQuantidade: Double): Boolean;
Var JsonProduto : TJsonObject;
    JsonArrayProduto : TJsonArray;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  JsonProduto := TJsonObject.Create();
  JsonProduto.AddPair('codproduto', TJsonNumber.Create(pCodProduto));
  JsonProduto.AddPair('endereco',  pEndereco );
  JsonProduto.AddPair('quantidade', TJsonNumber.Create(pQuantidade));
  JsonArrayProduto := TJsonArray.Create;
  JsonArrayProduto.AddElement( jSonProduto );
  DmeXactWMS.RestRequestWMS.AddBody( JsonArrayProduto.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/importestoque';
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  JsonProduto.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else Begin
    Result := False;
    raise Exception.Create('Erro: '+pCodProduto.ToString+' '+pEndereco);
  End;
end;

function TProdutoCtrl.MontarPaginacao: Integer;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/montarpaginacao';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as tjsonObject).GetValue<integer>('paginacao', 1);
  End
  Else
    raise Exception.Create('não foi possível definir máscara para o Picking');
end;

function TProdutoCtrl.GetProdutoLotes(pProdutoId : Integer; pDescricao : String): TJsonArray;
Var jSonArrayProduto : TJsonObject;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/lotes/{produtoid}/{descricao}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  DmeXactWMS.RESTRequestWMS.Method   := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else
    Raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TProdutoCtrl.GetRelProdutos01(pEstoque, pSemPicking, pCodProduto,
  pZonaId, pLaboratorioId, pListaEan, pSomenteCxaFechada, pAtivo, pBloqueado : Integer): TJsonArray;
Var vResourceURI, vDelimiter : String;
begin
  Result := TJsonArray.Create;
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*10;
    vResourceURI := 'v1/produto/relatorio01?';
    vResourceURI := vResourceURI+vDelimiter+'estoque='+pEstoque.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'sempicking='+pSemPicking.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'codproduto='+pCodProduto.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'zonaid='+pZonaId.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'laboratorioid='+pLaboratorioId.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'somentecxafechada='+pSomenteCxaFechada.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'listaean='+pListaEan.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'ativo='+pAtivo.ToString()+'&';
    vResourceURI := vResourceURI+vDelimiter+'bloqueado='+pBloqueado.ToString();
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message) );
    End;
  End;
end;

Function tProdutoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonProduto : TJsonObject;
Begin
  Result := False;
  if Not VerificaDados then Begin
     Exit;
  End;
  jSonProduto := tJson.ObjectToJsonObject(ObjProduto);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonProduto.ToJson, ContentTypeFromString('application/json'));
  if ObjProduto.IdProduto = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', ObjProduto.IdProduto.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TProdutoCtrl.UpdatePicking(pCodProduto: Integer): TJsonArray;
Var jSonProduto : TJsonObject;
Begin
  Try
    jSonProduto := tJson.ObjectToJsonObject(ObjProduto);
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/produto/updatepicking/{codproduto}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('codproduto', pCodProduto.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do begin
//    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.message));
    end;
  End;
end;

End.
