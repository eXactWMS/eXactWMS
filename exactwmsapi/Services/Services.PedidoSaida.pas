unit Services.PedidoSaida;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS, exactwmsservice.lib.utils,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TServicePedidoSaida = class (TBasicDao)
  private
    { Private declarations }

  public
    { Public declarations }
    Function GetPedidoAll(pPedidoId: Int64; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Int64;
      pRazao, pDocumentoNr, pRegistroERP: String;
      pRotaId, pRotaIdFinal, pZonaId : int64; pProcessoId, pMontarCarga: Integer;
      pCodProduto: Int64; pPedidoPendente: Integer; pCargaId: Int64;
      pNotaFiscalERP: String): TjSonArray;
    Function GetPedidoParaCargas(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer; pRazao, pDocumentoNr, pRegistroERP: String;
      pRotaId, pRotaIdFinal, pZonaId, pMontarCarga: Integer; pCargaId: Integer) : TjSonArray;
    Function GetRelAtendimentoRota(pDataInicial, pDataFinal: TDateTime)
      : TjSonArray;
    Function GetRelAtendimentoDestinatario(pDataInicial, pDataFinal: TDateTime)
      : TjSonArray;
    Function GetRelAtendimentoZona(pDataInicial, pDataFinal: TDateTime)
      : TjSonArray;
    Function DeletePedido(pJsonArrayPedido: TjSonArray): TjSonArray;
    Function AtualizarNFPedido(pJsonArrayPedido: TjSonArray): TjSonArray;
    Function AtualizarNFPedidoV2(pJsonArrayPedido: TjSonArray): TjSonArray;
    Function GetReposicaoHistorico(aQueryParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetReposicaoDemanda(pData: TDate; pZonaId: Integer;
      pEnderecoInicial, pEnderecoFinal, pTipoGeracao: String): TjSonArray;
    Function GetReposicaoCapacidade(pPercDownMaxPicking, pZonaId: Integer;
      pEnderecoInicial, pEnderecoFinal: String; pNegativo: Integer): TjSonArray;
    Function GetReposicaoDemandaColeta(pTipoGeracao: String): TjSonArray;
    Function ReposicaoTransferenciaPicking(pJsonTransferencia: TJsonObject)
      : TjSonArray;
    Function PedidoParaProcessamento(pPedidoId, pCodigoERP: Integer;
      pDataIni, pDataFin: TDateTime; pProcessoId, pRotaId, pRotaIdFinal,
      pZonaId, pRecebido, pCubagem, pEtiqueta: Integer): TjSonArray;
    Function RelReposicaoTransfPicking(aQueryParams
      : TDictionary<string, string>): TjSonArray;
    Function RelReposicaoResumoSintetico(aQueryParams
      : TDictionary<string, string>): TjSonArray;
    Function RelReposicaoResumoAnalitico(aQueryParams
      : TDictionary<string, string>): TjSonArray;
    Function GetAnaliseColeta(aQueryParams: TDictionary<string, string>) : TjSonArray;
    Function GetReposicaoColetaProdutividade(aQueryParams : TDictionary<string, string>): TjSonArray;
    Function GetRelHistoricoTransferenciaPicking(aQueryParams
      : TDictionary<string, string>): TjSonArray;
    Function ReposicaoCancelar(pJsonObject: TJsonObject): TjSonArray;
    Function ReposicaoExcluir(pJsonObject: TJsonObject): TjSonArray;
    Function ReposicaoRegistrarInUse(pReposicaoId, pUsuarioId: Integer;
      pTerminal: String): TjSonArray;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServicePedidoSaida: TServicePedidoSaida;

implementation

uses Constants;

{ TProvidersBase1 }

function TServicePedidoSaida.AtualizarNFPedido(pJsonArrayPedido: TjSonArray) : TjSonArray;
Var vQryAtualiza: TFDQuery;
    vQryRegistrarRetorno: TFDQuery;
    xPedido: Integer;
begin
  Result := TjsonArray.Create;
  Try
    vQryAtualiza         := TFdQuery.Create(Nil);
    vQryRegistrarRetorno := TFdQuery.Create(nil);
    Try
      vQryAtualiza.Connection         := Connection;
      vQryRegistrarRetorno.Connection := Connection;
      if pJsonArrayPedido = Nil then Begin
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
               .AddPair('pedidoid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
               .AddPair('mensagem', 'JsonArray enviado incorreto.'));
         Exit;
      End
      Else Begin
         vQryAtualiza.connection.StartTransaction;
         vQryAtualiza.connection.TxOptions.Isolation := xiReadCommitted;
         vQryAtualiza.Sql.Add('Declare @Pedido varchar(36) = :pPedido');
         vQryAtualiza.Sql.Add('Declare @NotaFiscal VarChar(20) = :pNotaFiscal');
         vQryAtualiza.Sql.Add('Declare @PedidoId Integer = Coalesce((Select PedidoId From Pedido');
         vQryAtualiza.Sql.Add('        where Cast(RegistroERP as Varchar(36)) = @Pedido), -1)');
         vQryAtualiza.Sql.Add('If @PedidoId > 0 Begin');
         vQryAtualiza.Sql.Add('   Update Pedido Set NotaFiscalERP = @NotaFiscal Where Cast(RegistroERP as Varchar(36)) = @Pedido');
         vQryAtualiza.Sql.Add('   Insert Into PedidoNotaFiscal (PedidoId, NotaFiscal)');
         vQryAtualiza.Sql.Add('   Select Ped.PedidoId, Ped.NotaFiscalERP');
         vQryAtualiza.Sql.Add('   From pedido Ped');
         vQryAtualiza.Sql.Add('   Left Join PedidoNotaFiscal PNF On PNF.PedidoId = Ped.PedidoId and PNF.NotaFiscal = Ped.NotaFiscalERP');
         vQryAtualiza.Sql.Add('   where (Cast(RegistroERP as Varchar(36)) = @Pedido OR Cast(Ped.PedidoId as Varchar(36)) = @Pedido) and');
         vQryAtualiza.Sql.Add('         (ped.NotaFiscalERP Is not Null) and (ped.NotaFiscalERP Is not Null) and (PNF.NotaFiscal is null)');
         vQryAtualiza.Sql.Add('End');
         vQryAtualiza.Sql.Add('Select @PedidoId As PedidoId');
         for xPedido := 0 to Pred(pJsonArrayPedido.Count) do
         Begin
           vQryAtualiza.Close;
           vQryAtualiza.ParamByName('pPedido').Value := pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido');
           vQryAtualiza.ParamByName('pNotaFiscal').Value := pJsonArrayPedido.Items[xPedido].GetValue<String>('nfe');
           Try
             vQryAtualiza.Sql.Add('-- :pPedio = ' + pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido'));
             if DebugHook <> 0 Then
                vQryAtualiza.Sql.SaveToFile('AtualizarNotaFiscal.Sql');
             vQryAtualiza.Open;
             if vQryAtualiza.FieldByName('PedidoId').AsInteger > 0 then Begin
                vQryRegistrarRetorno.Close;
                vQryRegistrarRetorno.Sql.Clear;
                vQryRegistrarRetorno.Sql.Add('Declare @Pedido Varchar(36) = :pPedido');
                vQryRegistrarRetorno.Sql.Add('Update Pedido Set Status = 5');
                vQryRegistrarRetorno.Sql.Add('Where (Cast(PEDIDOID as varchar(36)) = @Pedido or Cast(RegistroERP as VarChar(36)) = @Pedido)');
                vQryRegistrarRetorno.ParamByName('pPedido').Value := pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido');
                If DebugHook <> 0 Then
                   vQryRegistrarRetorno.Sql.SaveToFile('RegistrarRetornoSaida.Sql');
                vQryRegistrarRetorno.ExecSql;
                Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                  .AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido'))
                  .AddPair('nfe', pJsonArrayPedido.Items[xPedido].GetValue<String>('nfe'))
                  .AddPair('mensagem', 'Ok! NF-e Atualizada.'))
             End
             Else
             Begin
               Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                 .AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido'))
                 .AddPair('nfe', pJsonArrayPedido.Items[xPedido].GetValue<String>('nfe'))
                 .AddPair('mensagem', 'Erro! Pedido não encontrado.'))
             End;
           Except On E: Exception do
             Begin
               Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                 .AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido'))
                 .AddPair('nfe', pJsonArrayPedido.Items[xPedido].GetValue<String>('nfe'))
                 .AddPair('mensagem', 'Erro! NF-e não Atualizada. '+E.Message));
             End;
           End;
         End;
         vQryAtualiza.connection.Commit;
      End;
    Except On E: Exception do
      Begin
        vQryAtualiza.connection.Rollback;
        raise Exception.Create('Processo: AtualizarNotaFiscal - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(vQryAtualiza);
    FreeAndNil(vQryRegistrarRetorno);
  End;
end;

function TServicePedidoSaida.AtualizarNFPedidoV2(pJsonArrayPedido: TjSonArray) : TjSonArray;
Var
  vQryPedido, vQryNfe: TFDQuery;
  xPedido: Integer;
  xNfe: Integer;
begin
  vQryPedido := TFdQuery.Create(Nil);
  vQryNfe    := TFdQuery.Create(Nil);
  Try
    vQryPedido.Connection := Connection;
    vQryNfe.Connection    := Connection;
    Try
      Result := TjSonArray.Create;
      if pJsonArrayPedido = Nil then Begin
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
               .AddPair('pedidoid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
               .AddPair('mensagem', 'JsonArray enviado incorreto.'));
         Exit;
      End;
      vQryPedido.connection.StartTransaction;
      vQryPedido.Close;
      vQryPedido.Sql.Clear;
      vQryPedido.Sql.Add('Declare @PedidoId  Integer = (Select PedidoId From Pedido Where RegistroERP = :pRegistroERP)');
      vQryPedido.Sql.Add('Delete PedidoNotaFiscal Where PedidoId = @PedidoId');
      vQryPedido.Sql.Add('Update Pedido Set Status = 5 where PedidoId = @PedidoId');
      vQryNfe.Sql.Add('Declare @PedidoId Integer = (Select PedidoId From Pedido Where RegistroERP = :pRegistroERP)');
      vQryNfe.Sql.Add('Insert into PedidoNotaFiscal Values (@PedidoId, :Nfe, :Chave, GetDate(), GetDate())');
      for xPedido := 0 to Pred(pJsonArrayPedido.Count) do Begin
        vQryPedido.ParamByName('pRegistroERP').Value := pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido');
        vQryNfe.Params.ArraySize := pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Count;
        For xNfe := 0 to Pred(pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Count) do Begin
            vQryNfe.Params[0].Values[xNfe] := pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido');
            vQryNfe.Params[1].Values[xNfe] := pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Items[xNfe].GetValue<String>('nfe');
            vQryNfe.Params[2].Values[xNfe] := pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Items[xNfe].GetValue<String>('chave');
        End;
        Try
          vQryPedido.ExecSql;
          vQryNfe.Execute(vQryNfe.Params.ArraySize, 0);
          Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                .AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido')).AddPair('nfe', '').AddPair('mensagem', 'Ok - NF-e Atualizada com sucesso!'));
        Except
          Result.AddElement(TJsonObject.Create.AddPair('status', '500').AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido')).AddPair('nfe', '').AddPair('mensagem', 'Erro! NF-e não Atualizada.'));
        End;
      End;
      vQryPedido.connection.Commit;
    Except On E: Exception do
      Begin
        vQryPedido.connection.Rollback;
        raise Exception.Create('Processo: AtualizarNotaFiscal - ' +  TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(vQryPedido);
    FreeAndNil(vQryNfe);
  End;
end;

constructor TServicePedidoSaida.Create;
begin
  inherited
end;

function TServicePedidoSaida.DeletePedido(pJsonArrayPedido: TjSonArray) : TjSonArray;
Var xPedido: Integer;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      Query.connection.TxOptions.Isolation := xiReadCommitted;
      Query.Close;
      Query.Sql.Add('Declare @PedidoId Integer = :pPedidoId');
      Query.Sql.Add('Declare @UsuarioId Integer = :pUsuarioId');
      Query.Sql.Add('Declare @Terminal Varchar(50) = :pTerminal');
      Query.SQL.Add('Declare @MotivoIdExclusao Integer = :pMotivoIdExclusao');

      Query.Sql.Add('Update Pedido Set Status = 3 ');
      Query.Sql.Add('                , MEP = @MotivoIdExclusao');
      Query.Sql.Add('where PedidoId = @PedidoId and OperacaoTipoId = 2');
      Query.Sql.Add('Update DocumentoEtapas Set Status = 0'); //01062024 nao cancelar volume já cancelado
      Query.Sql.Add('Where Documento = (Select Uuid from Pedido Where Pedidoid = @PedidoId) and Status = 1');
      Query.Sql.Add('  And ProcessoId = 31');
      Query.Sql.Add('Insert Into DocumentoEtapas Values (');
      Query.Sql.Add('   Cast((Select Uuid from Pedido Where Pedidoid = @PedidoId) as UNIQUEIDENTIFIER), ');
      Query.Sql.Add('   (Select ProcessoId From ProcessoEtapas');
      Query.Sql.Add('Where Descricao = '+#39+'Documento Excluido'+#39+'), ');
      Query.Sql.Add('@UsuarioId, '+TuEvolutconst.SqlDataAtual+', '+TuEvolutconst.SqlHoraAtual + ', GetDate(), @Terminal, 1)');
      for xPedido := 0 to Pred(pJsonArrayPedido.Count) do Begin
        Query.Close;
        Query.ParamByName('pPedidoId').Value  := pJsonArrayPedido.Items[xPedido].GetValue<Integer>('pedidoid');
        Query.ParamByName('pUsuarioId').Value := pJsonArrayPedido.Items[xPedido].GetValue<Integer>('usuarioid');
        Query.ParamByName('pTerminal').Value  := pJsonArrayPedido.Items[xPedido].GetValue<String>('terminal');
        Query.ParamByName('pMotivoIdExclusao').Value  := pJsonArrayPedido.Items[xPedido].GetValue<Integer>('motivoidexclusao');
        Try
          If DebugHook <> 0 Then
             Query.Sql.SaveToFile('PedidoExcluir.Sql');
          Query.ExecSql;
          Result.Add(TJsonObject.Create.AddPair('pedidoid', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedidoid') +' - Ok! Excluido.'))
        Except
          raise Exception.Create('Não foi possível excluir o Pedido: '+pJsonArrayPedido.Items[xPedido].GetValue<String>('pedidoid'));
        End;
      End;
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Processo: DeletePedido - ' + TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TServicePedidoSaida.Destroy;
begin

  inherited;
end;

function TServicePedidoSaida.GetPedidoAll(pPedidoId: Int64;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Int64;
  pRazao, pDocumentoNr, pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId : int64;
  pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer; pCargaId: Int64; pNotaFiscalERP: String) : TjSonArray;
var JsonRetorno: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      If pNotaFiscalERP = '' then
         Query.Sql.Add(TuEvolutconst.SqlPedido)
      Else
         Query.Sql.Add(TuEvolutconst.SqlPedidoPNF);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni = 0 then
         Query.ParamByName('pDataIni').Value := pDataIni
      Else
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
      if pDataFin = 0 then
         Query.ParamByName('pDataFin').Value := pDataFin
      Else
         Query.ParamByName('pDataFin').Value      := FormatDateTime('YYYY-MM-DD', pDataFin);
      Query.ParamByName('pCodigoERP').Value      := pCodigoERP;
      Query.ParamByName('pPessoaId').Value       := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value    := pDocumentoNr;
      Query.ParamByName('pRazao').Value          := '%' + pRazao + '%';
      Query.ParamByName('pRegistroERP').Value    := pRegistroERP;
      Query.ParamByName('pRotaId').Value         := pRotaId;
      Query.ParamByName('pRotaIdFinal').Value    := pRotaIdFinal;
      Query.ParamByName('pZonaId').Value         := pZonaId;
      Query.ParamByName('pProcessoId').Value     := pProcessoId;
      Query.ParamByName('pMontarCarga').Value    := pMontarCarga;
      Query.ParamByName('pCodProduto').Value     := pCodProduto;
      Query.ParamByName('pPedidoPendente').Value := pPedidoPendente;
      Query.ParamByName('pCargaId').Value        := pCargaId;
      Query.ParamByName('pNotaFiscalERP').Value  := pNotaFiscalERP;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('PedidoAll.Sql');
      Query.ParamByName('pOperacaoTipoId').Value := 2;
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)));
      End
      Else Begin
         Result := Query.ToJsonArray;
      End;
    Except ON E: Exception do Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetPedidoParaCargas(pPedidoId: Integer; pDataIni,
  pDataFin: TDate; pCodigoERP, pPessoaId: Integer; pRazao, pDocumentoNr,
  pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId, pMontarCarga,
  pCargaId: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutconst.SqlPedidoParaCargas);
      Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni = 0 then
         Query.ParamByName('pDataIni').Value := pDataIni
      Else
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
      if pDataFin = 0 then
         Query.ParamByName('pDataFin').Value := pDataFin
      Else
         Query.ParamByName('pDataFin').Value      := FormatDateTime('YYYY-MM-DD', pDataFin);;
      Query.ParamByName('pCodigoERP').Value      := pCodigoERP;
      Query.ParamByName('pPessoaId').Value       := pPessoaId;
      Query.ParamByName('pDocumentoNr').Value    := pDocumentoNr;
      Query.ParamByName('pRazao').Value          := '%' + pRazao + '%';
      Query.ParamByName('pRegistroERP').Value    := pRegistroERP;
      Query.ParamByName('pRotaId').Value         := pRotaId;
      Query.ParamByName('pRotaIdFinal').Value    := pRotaIdFinal;
      Query.ParamByName('pZonaId').Value         := pZonaId;
      Query.ParamByName('pMontarCarga').Value    := pMontarCarga;
      Query.ParamByName('pCargaId').Value        := pCargaId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('PedidoParaCargas.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)));
      End
      Else
         Result := Query.ToJsonArray;
    Except ON E: Exception do Begin
      Raise Exception.Create('Processo: PedidoParaCarga - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetRelAtendimentoDestinatario(pDataInicial, pDataFinal: TDateTime): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlRelAtendimentoDestinatario);
      Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      Query.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', pDataFinal);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelAtendimentoDestinatario.Sql');
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do Begin
        raise Exception.Create('Processo: Atendimento Por Destintário - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetRelAtendimentoRota(pDataInicial, pDataFinal: TDateTime): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlRelAtendimentoRota);
      Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', pDataFinal);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelAtendimentoRota.Sql');
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      Else
        Result := Query.ToJsonArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Atendimento Por Rota - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetRelAtendimentoZona(pDataInicial,
  pDataFinal: TDateTime): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlRelAtendimentoZona);
      Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
      Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', pDataFinal);
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelAtendimentoRota.Sql');
      Query.Open;
      if Query.Isempty then
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Etiqueta Por Rua - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetRelHistoricoTransferenciaPicking
  (aQueryParams: TDictionary<string, string>): TjSonArray;
Var
  pReposicaoId: Integer;
  pDataInicial, pDataFinal: TDateTime;
  pPendente: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if (aQueryParams.ContainsKey('modelo')) and (aQueryParams.Items['modelo'] = 'sintetico') then
         Query.Sql.Add(TuEvolutconst.SqlRelHistoricoTransferenciaPickingSintetico)
      Else
         Query.Sql.Add(TuEvolutconst.SqlRelHistoricoTransferenciaPickingAnalitico);
      if aQueryParams.ContainsKey('reposicaoid') then
         Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
      Else
         Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if aQueryParams.ContainsKey('usuarioid') then
         Query.ParamByName('pUsuarioId').Value := aQueryParams.Items['usuarioid'].ToInteger()
      Else
         Query.ParamByName('pUsuarioId').Value := 0;
      if aQueryParams.ContainsKey('pendente') then
         Query.ParamByName('pPendente').Value := aQueryParams.Items['pendente'].ToInteger()
      Else
         Query.ParamByName('pPendente').Value := 0;
      if aQueryParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := aQueryParams.Items['codproduto'].ToInteger()
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if aQueryParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := aQueryParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelHistoricoTransferenciaPicking.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Reposição Análise - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetReposicaoDemanda(pData: TDate; pZonaId: Integer;
  pEnderecoInicial, pEnderecoFinal, pTipoGeracao: String): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlGetReposicaoDemanda);
      Query.ParamByName('pDocumentoData').Value := FormatDateTime('YYYY-MM-DD', pData);
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pPickingInicial').Value := pEnderecoInicial;
      Query.ParamByName('pPickingFinal').Value := pEnderecoFinal;
      Query.ParamByName('pTipoGeracao').Value := pTipoGeracao;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoPorDemanda.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do Begin
      raise Exception.Create('Processo: GetReposicaoDemanda - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetReposicaoCapacidade(pPercDownMaxPicking,
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String;
  pNegativo: Integer): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.FetchOptions.Mode := fmAll;
      Query.Sql.Add(TuEvolutconst.SqlGetReposicaoCapacidade);
      Query.ParamByName('pPercDownMaxPicking').Value := pPercDownMaxPicking;
      Query.ParamByName('pZonaId').Value := pZonaId;
      Query.ParamByName('pPickingInicial').Value := pEnderecoInicial;
      Query.ParamByName('pPickingFinal').Value := pEnderecoFinal;
      Query.ParamByName('pNegativo').Value := pNegativo;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoCapacidade.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
         Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetReposicaoDemanda - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetReposicaoDemandaColeta(pTipoGeracao: String) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlGetReposicaoDemandaColeta);
      Query.ParamByName('pTipoGeracao').Value := pTipoGeracao;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoDemandaColeta.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetReposicaoDemandaColeta - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

// Move Estoque de reposicaoestoquetransferencia Para o Picking na Tabela Estoque
function TServicePedidoSaida.GetAnaliseColeta(aQueryParams : TDictionary<string, string>): TjSonArray;
Var pReposicaoId: Integer;
    pDataInicial, pDataFinal: TDateTime;
    pPendente: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if (aQueryParams.ContainsKey('modelo')) and (aQueryParams.Items['modelo'] = 'sintetico') then
         Query.Sql.Add(TuEvolutconst.SqlRelReposicaoAnaliseColetaSintetico)
      Else
         Query.Sql.Add(TuEvolutconst.SqlRelReposicaoAnalise);
      if aQueryParams.ContainsKey('reposicaoid') then
         Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
      Else
         Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value   := 0;
      if aQueryParams.ContainsKey('usuarioid') then
         Query.ParamByName('pUsuarioId').Value := aQueryParams.Items['usuarioid'].ToInteger()
      Else
         Query.ParamByName('pUsuarioId').Value  := 0;
      if aQueryParams.ContainsKey('pendente') then
         Query.ParamByName('pPendente').Value := aQueryParams.Items['pendente'].ToInteger()
      Else
         Query.ParamByName('pPendente').Value := 0;
      if aQueryParams.ContainsKey('divergencia') then
         Query.ParamByName('pDivergencia').Value := aQueryParams.Items['divergencia'].ToInteger()
      Else
         Query.ParamByName('pDivergencia').Value := 0;
      if aQueryParams.ContainsKey('naocoletado') then
         Query.ParamByName('pNaoColetado').Value := aQueryParams.Items['naocoletado'].ToInteger()
      Else
         Query.ParamByName('pNaoColetado').Value := 0;
      if aQueryParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := aQueryParams.Items['codproduto'].ToInteger()
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if aQueryParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := aQueryParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if aQueryParams.ContainsKey('processoid') then
         Query.ParamByName('pProcessoId').Value := aQueryParams.Items['processoid'].ToInteger()
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelAnaliseColeta.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Reposição Análise - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.GetReposicaoColetaProdutividade(aQueryParams : TDictionary<string, string>): TjSonArray;
Var pReposicaoId: Integer;
    pDataInicial, pDataFinal: TDateTime;
    pPendente: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlRelReposicaoColetaProdutividade);
      if aQueryParams.ContainsKey('reposicaoid') then
         Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
      Else
         Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value   := 0;
      if aQueryParams.ContainsKey('usuarioid') then
         Query.ParamByName('pUsuarioId').Value := aQueryParams.Items['usuarioid'].ToInteger()
      Else
         Query.ParamByName('pUsuarioId').Value  := 0;
      if aQueryParams.ContainsKey('pendente') then
         Query.ParamByName('pPendente').Value := aQueryParams.Items['pendente'].ToInteger()
      Else
         Query.ParamByName('pPendente').Value := 0;
      if aQueryParams.ContainsKey('divergencia') then
         Query.ParamByName('pDivergencia').Value := aQueryParams.Items['divergencia'].ToInteger()
      Else
         Query.ParamByName('pDivergencia').Value := 0;
      if aQueryParams.ContainsKey('naocoletado') then
         Query.ParamByName('pNaoColetado').Value := aQueryParams.Items['naocoletado'].ToInteger()
      Else
         Query.ParamByName('pNaoColetado').Value := 0;
      if aQueryParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := aQueryParams.Items['codproduto'].ToInteger()
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if aQueryParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := aQueryParams.Items['zonaid'].ToInteger()
      Else
         Query.ParamByName('pZonaId').Value := 0;
      if aQueryParams.ContainsKey('processoid') then
         Query.ParamByName('pProcessoId').Value := aQueryParams.Items['processoid'].ToInteger()
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoColetaProdutividade.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
        Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Reposição Análise - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.RelReposicaoTransfPicking(aQueryParams: TDictionary<string, string>): TjSonArray;
Var pReposicaoId: Integer;
    pDataInicial, pDataFinal: TDateTime;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      if (aQueryParams.ContainsKey('modelo')) and (aQueryParams.Items['modelo'] = 'sintetico') Then Begin
         Query.Sql.Add(TuEvolutconst.SqlRelReposicaoTransfSintetico);
      End
      Else //Begin
        Query.Sql.Add(TuEvolutconst.SqlRelReposicaoTransfAnalitico);
      if aQueryParams.ContainsKey('reposicaoid') then
         Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
      Else
         Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if aQueryParams.ContainsKey('codproduto') then
         Query.ParamByName('pCodProduto').Value := StrToIntDef(aQueryParams.Items['codproduto'], 0)
      Else
         Query.ParamByName('pCodProduto').Value := 0;
      if aQueryParams.ContainsKey('zonaid') then
         Query.ParamByName('pZonaId').Value := StrToIntDef(aQueryParams.Items['zonaid'], 0)
      Else
         Query.ParamByName('pZonaid').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelReposicaoTransferenciaPicking.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
         Result := Query.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Reposição Análise - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.RelReposicaoResumoAnalitico(aQueryParams: TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlGetRelReposicaoResumoAnalitico);
      if aQueryParams.ContainsKey('reposicaoid') then
         Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
      Else
         Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
      Else
        Query.ParamByName('pDataFinal').Value := 0;
      if aQueryParams.ContainsKey('processoid') then
         Query.ParamByName('pProcessoId').Value := aQueryParams.Items['processoid'].ToInteger()
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if aQueryParams.ContainsKey('pendente') then
         Query.ParamByName('pPendente').Value := aQueryParams.Items['pendente'].ToInteger()
      Else
         Query.ParamByName('pPendente').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelReposicaoResumoAnalitico.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
         Result := Query.ToJsonArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Relatório Reposição Resumo Analitico - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.RelReposicaoResumoSintetico
  (aQueryParams: TDictionary<string, string>): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlGetRelReposicaoResumoSintetico);
      if aQueryParams.ContainsKey('reposicaoid') then
         Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
      Else
         Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
         Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
      Else
         Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
         Query.ParamByName('pDataFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
      Else
         Query.ParamByName('pDataFinal').Value := 0;
      if aQueryParams.ContainsKey('processoid') then
         Query.ParamByName('pProcessoId').Value := aQueryParams.Items['processoid'].ToInteger()
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if aQueryParams.ContainsKey('pendente') then
         Query.ParamByName('pPendente').Value := aQueryParams.Items['pendente'].ToInteger()
      Else
         Query.ParamByName('pPendente').Value := 0;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('RelReposicaoResumoSintetico.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
         Result := Query.ToJsonArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Relatório Reposição Resumo Sintético - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.ReposicaoCancelar(pJsonObject: TJsonObject) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlDelReservaReposicao);
      Query.Sql.Add('Update Reposicao Set ProcessoId = 30');
      Query.Sql.Add('  , UsuarioId = ' + pJsonObject.GetValue<Integer>('usuarioid').ToString());
      Query.Sql.Add('  , Terminal  = ' + QuotedStr(pJsonObject.GetValue<String>('terminal')));
      Query.Sql.Add('Where ReposicaoId = ' + pJsonObject.GetValue<Integer>('reposicaoid').ToString());
      Query.ParamByName('pReposicaoId').Value := pJsonObject.GetValue<Integer>('reposicaoid');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoCancelar.Sql');
      Query.ExecSql;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cancelamento Ok!'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoCancelar - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.ReposicaoExcluir(pJsonObject: TJsonObject) : TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlDelReservaReposicao);
      Query.Sql.Add('Update Reposicao Set ProcessoId = 31');
      Query.Sql.Add('  , UsuarioId = ' + pJsonObject.GetValue<Integer>('usuarioid').ToString());
      Query.Sql.Add('  , Terminal  = ' + QuotedStr(pJsonObject.GetValue<String>('terminal')));
      Query.Sql.Add('Where ReposicaoId = ' + pJsonObject.GetValue<Integer>('reposicaoid').ToString());
      Query.ParamByName('pReposicaoId').Value := pJsonObject.GetValue<Integer>('reposicaoid');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoExcluir.Sql');
      Query.ExecSql;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Reposição excluída!'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoExcluir '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.ReposicaoRegistrarInUse(pReposicaoId,
  pUsuarioId: Integer; pTerminal: String): TjSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Update reposicao');
      Query.Sql.Add('  Set UsuarioIdInUse = 0');// +pUsuarioId.ToString());
      Query.Sql.Add('    , TerminalInUse  = ' + QuotedStr(pTerminal));
      Query.Sql.Add('Where ReposicaoId = ' + pReposicaoId.ToString());
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ReposicaoRegistrarInUse.Sql');
      Query.ExecSql;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Registrado com sucesso!'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: ReposicaoRegistrarInUse - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.ReposicaoTransferenciaPicking(pJsonTransferencia : TJsonObject): TjSonArray;
Var vQryTrasferecia: TFDQuery;
    vQryEstoqueTransf: TFDQuery;
    vQtdBaixaLote: Integer;
    vBaixaEstoque: Integer;
begin
  vQryTrasferecia   := TFdQuery.Create(nil);
  vQryEstoqueTransf := TFdQuery.Create(Nil);
  Try
    vQryTrasferecia.Connection   := Connection;
    vQryEstoqueTransf.Connection := Connection;
    Try
      vQryTrasferecia.connection.StartTransaction;
      // Baixar Estoque
      if (pJsonTransferencia.GetValue<Integer>('qtdrepo') > 0) and
         (pJsonTransferencia.GetValue<String>('pickingid') <> '') and
         (pJsonTransferencia.GetValue<String>('pickingid') <> '0') then
      Begin
        // Pegar todos os lotes disponiveis e baixar proporcionalmente
        // ao Invés de baixar por lote, devemos baixar por produto, para reposicao sem lote
        vQryEstoqueTransf.Close;
        vQryEstoqueTransf.Sql.Clear;
        vQryEstoqueTransf.Sql.Add('Declare @LoteId Integer = :pLoteId');
        vQryEstoqueTransf.Sql.Add('select * from reposicaoestoquetransferencia RT');
        vQryEstoqueTransf.Sql.Add('where Rt.LoteId = @LoteId');
        vQryEstoqueTransf.Sql.Add('Order by RT.LoteId, RT.ReposicaoId');
        vQryEstoqueTransf.ParamByName('pLoteId').Value := pJsonTransferencia.GetValue<Integer>('loteid');
        vQryEstoqueTransf.Open;
        vQtdBaixaLote := pJsonTransferencia.GetValue<Integer>('qtdrepo');
        while ((vQtdBaixaLote > 0) and (Not vQryEstoqueTransf.Eof)) do Begin
          vQryTrasferecia.Close;
          vQryTrasferecia.Sql.Clear;
          vQryTrasferecia.Sql.Add(TuEvolutconst.SqlReposicaoEstoqueTransferencia);
          vQryTrasferecia.ParamByName('pLoteId').Value           := pJsonTransferencia.GetValue<Integer>('loteid');
          vQryTrasferecia.ParamByName('pEnderecoId').Value       := pJsonTransferencia.GetValue<Integer>('enderecoid');
          vQryTrasferecia.ParamByName('pEstoqueTipoId').Value    := 7;
          vQryTrasferecia.ParamByName('pReposicaoId').Value      := vQryEstoqueTransf.FieldByName('ReposicaoId').AsInteger;
          vQryTrasferecia.ParamByName('pEnderecoOrigemId').Value := vQryEstoqueTransf.FieldByName('EnderecoOrigemId').AsInteger;
          if vQtdBaixaLote > vQryEstoqueTransf.FieldByName('Qtde').AsInteger then Begin
             vBaixaEstoque := vQryEstoqueTransf.FieldByName('Qtde').AsInteger;
             vQryTrasferecia.ParamByName('pQuantidade').Value := (vBaixaEstoque * -1);
             vQtdBaixaLote := vQtdBaixaLote - vBaixaEstoque;
          End
          Else Begin
            vBaixaEstoque := vQtdBaixaLote;
            vQryTrasferecia.ParamByName('pQuantidade').Value := (vQtdBaixaLote * -1);
            vQtdBaixaLote := 0;
          End;
          vQryTrasferecia.ParamByName('pUsuarioId').Value := (pJsonTransferencia.GetValue<Integer>('usuarioid'));
          vQryTrasferecia.ParamByName('pTerminal').Value  := (pJsonTransferencia.GetValue<String>('terminal'));
          if DebugHook <> 0 then
            vQryTrasferecia.Sql.SaveToFile('SqlReposicaoBaixarTransferenciaPicking.Sql');
          vQryTrasferecia.ExecSql;
          // Transferir para o Picking
          if pJsonTransferencia.GetValue<Integer>('qtdrepo') > 0 then Begin
             vQryTrasferecia.Close;
             vQryTrasferecia.Sql.Clear;
             vQryTrasferecia.Sql.Add('-- Transferir para o Picking');
             vQryTrasferecia.Sql.Add(TuEvolutconst.SqlEstoque);
             vQryTrasferecia.ParamByName('pLoteId').Value     := pJsonTransferencia.GetValue<Integer>('loteid');
             vQryTrasferecia.ParamByName('pEnderecoId').Value := pJsonTransferencia.GetValue<Integer>('pickingid');
             vQryTrasferecia.ParamByName('pEstoqueTipoId').Value := 4;
             vQryTrasferecia.ParamByName('pQuantidade').Value := vBaixaEstoque;
             vQryTrasferecia.ParamByName('pUsuarioId').Value  := pJsonTransferencia.GetValue<Integer>('usuarioid');
             if DebugHook <> 0 then
                vQryTrasferecia.Sql.SaveToFile('SqlReposicaoTransferenciaParaPicking.Sql');
             vQryTrasferecia.ExecSql;
          End;
          vQryEstoqueTransf.Next;
        End;
      End;
      // Registrar no Kardex
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Ok', 'Trasferência salva.')));
      vQryTrasferecia.connection.Commit;
    Except On E: Exception do
      Begin
        vQryTrasferecia.connection.Rollback;
        raise Exception.Create('Não foi possível fazer a transferência.'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(vQryTrasferecia);
    FreeAndNil(vQryEstoqueTransf);
  End;
end;

function TServicePedidoSaida.GetReposicaoHistorico(aQueryParams
  : TDictionary<string, string>): TjSonArray;
Var pReposicaoId, pCodProduto, pZonaReposicaoId, pZonaColetaId: Integer;
    pUsuarioId, pProcessoId, pDtReposicaoInicial: Integer;
    pDtReposicaoFinal, pEnderecoColetaId: TDateTime;
    pDivergencia: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
  Try
    Query.Sql.Add(TuEvolutconst.SqlRelReposicaoHistorico);
    if aQueryParams.ContainsKey('reposicaoid') then
       Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
    Else
       Query.ParamByName('pReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('codproduto') then
       Query.ParamByName('pCodProduto').Value := aQueryParams.Items['codproduto'].ToInteger()
    Else
       Query.ParamByName('pCodProduto').Value := 0;
    if aQueryParams.ContainsKey('zonareposicaoid') then
       Query.ParamByName('pZonaReposicaoId').Value := aQueryParams.Items['zonareposicaoid'].ToInteger()
    Else
      Query.ParamByName('pZonaReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('zonacoletaid') then
       Query.ParamByName('pZonaColetaId').Value := aQueryParams.Items['zonacoletaid'].ToInteger()
    Else
       Query.ParamByName('pZonaColetaId').Value := 0;
    if aQueryParams.ContainsKey('usuarioid') then
       Query.ParamByName('pUsuarioId').Value := aQueryParams.Items['usuarioid'].ToInteger()
    Else
       Query.ParamByName('pUsuarioId').Value := 0;
    if aQueryParams.ContainsKey('usuarioid') then
       Query.ParamByName('pUsuarioId').Value := aQueryParams.Items['usuarioid'].ToInteger()
    Else
      Query.ParamByName('pUsuarioId').Value := 0;
    if aQueryParams.ContainsKey('processoid') then
       Query.ParamByName('pProcessoId').Value := aQueryParams.Items['processoid'].ToInteger()
    Else
       Query.ParamByName('pProcessoId').Value := 0;
    if aQueryParams.ContainsKey('dtreposicaoinicial') then
       Query.ParamByName('pDtReposicaoInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['dtreposicaoinicial']))
    Else
       Query.ParamByName('pDtReposicaoInicial').Value := 0;
    if aQueryParams.ContainsKey('dtreposicaofinal') then
       Query.ParamByName('pDtReposicaoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['dtreposicaofinal']))
    Else
      Query.ParamByName('pDtReposicaoFinal').Value := 0;
    if aQueryParams.ContainsKey('enderecocoletaid') then
       Query.ParamByName('pEnderecoColetaId').Value := aQueryParams.Items['enderecocoletaid'].ToInteger()
    Else
       Query.ParamByName('pEnderecoColetaId').Value := 0;
    if aQueryParams.ContainsKey('divergencia') then
       Query.ParamByName('pDivergencia').Value := aQueryParams.Items['dtreposicaoinicial'].ToInteger()
    Else
       Query.ParamByName('pDivergencia').Value := 0;
    if DebugHook <> 0 then
       Query.Sql.SaveToFile('RelReposicaoHistorico.Sql');
    Query.Open;
    if Query.Isempty then Begin
       Result := TjSonArray.Create();
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
    End
    Else
      Result := Query.ToJsonArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: Etiqueta Por Rua - '+TUtil.TratarExcessao(E.Message));
    End;
  end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServicePedidoSaida.PedidoParaProcessamento(pPedidoId,
  pCodigoERP: Integer; pDataIni, pDataFin: TDateTime;
  pProcessoId, pRotaId, pRotaIdFinal, pZonaId, pRecebido, pCubagem,
  pEtiqueta: Integer): TjSonArray;
Var JsonArrayPedidos, JsonArrayRotas, JsonArrayPessoas: TjSonArray;
    JsonRetorno, JsonPedido, JsonOperacao, JsonNatureza, JsonRota, JsonPessoa: TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add(TuEvolutconst.SqlPedidoParaProcessamento);
      Query.ParamByName('pPedidoId').Value  := pPedidoId;
      Query.ParamByName('pCodigoERP').Value := pCodigoERP;
      if pDataIni <> 0 then
         Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
         Query.ParamByName('pDataFin').Value  := 0;
      Query.ParamByName('pRotaId').Value      := pRotaId;
      Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
      Query.ParamByName('pZonaId').Value      := pZonaId;
      Query.ParamByName('pProcessoId').Value  := pProcessoId;
      Query.ParamByName('pRecebido').Value    := pRecebido;
      Query.ParamByName('pCubagem').Value     := pCubagem;
      Query.ParamByName('pEtiqueta').Value    := pEtiqueta;
      if (pRotaId>0) or (pRotaIdFinal>0) then
         Query.sql.Add('Order by P.RotaId, P.PedidoId')
      Else
         Query.sql.Add('Order by P.Data, p.PedidoId');
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('PedidoParaProcessamento.Sql');
      Query.Open;
      if Query.Isempty then Begin
         Result := TjSonArray.Create();
         Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
      End
      Else
      Begin
        JsonArrayPedidos := TjSonArray.Create;
        while Not Query.Eof do Begin
          JsonPedido := TJsonObject.Create;
          JsonOperacao := TJsonObject.Create;
          JsonNatureza := TJsonObject.Create;
          JsonPessoa := TJsonObject.Create;
          JsonPedido.AddPair('pedidoid', TJsonNumber.Create(Query.FieldByName('PedidoId').AsInteger));
          JsonPedido.AddPair('processoid', TJsonNumber.Create(Query.FieldByName('ProcessoId').AsInteger));
          JsonPedido.AddPair('processoetapa', Query.FieldByName('ProcessoEtapa').AsString);
          JsonPedido.AddPair('statusmin', TJsonNumber.Create(Query.FieldByName('StatusMin').AsInteger));
          JsonPedido.AddPair('statusmax', TJsonNumber.Create(Query.FieldByName('StatusMax').AsInteger));
          JsonOperacao.AddPair('operacaotipoid', TJsonNumber.Create(Query.FieldByName('OperacaoTipoId').AsInteger));
          JsonOperacao.AddPair('descricao', Query.FieldByName('OperacaoTipo').AsString);
          JsonPedido.AddPair('operacaotipo', JsonOperacao);
          JsonPessoa.AddPair('pessoaid', TJsonNumber.Create(Query.FieldByName('PessoaId').AsInteger));
          JsonPessoa.AddPair('codpessoaerp', TJsonNumber.Create(Query.FieldByName('CodPessoaERP').AsInteger));
          JsonPessoa.AddPair('razao', Query.FieldByName('Razao').AsString);
          JsonPessoa.AddPair('fantasia', Query.FieldByName('Fantasia').AsString);
          JsonPessoa.AddPair('rotaid', TJsonNumber.Create(Query.FieldByName('RotaId').AsInteger));
          JsonPessoa.AddPair('rota', Query.FieldByName('Rota').AsString);
          JsonPedido.AddPair('pessoa', JsonPessoa);
          JsonPedido.AddPair('documentonr', Query.FieldByName('DocumentoNr').AsString);
          JsonPedido.AddPair('documentodatar', DateToStr(Query.FieldByName('DocumentoData').AsDateTime));
          JsonPedido.AddPair('armazemid', TJsonNumber.Create(Query.FieldByName('ArmazemId').AsInteger));
          JsonPedido.AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
          JsonPedido.AddPair('qtdproduto', TJsonNumber.Create(Query.FieldByName('QtdProdutos').AsInteger));
          JsonPedido.AddPair('peso', TJsonNumber.Create(Query.FieldByName('peso').AsInteger));
          JsonPedido.AddPair('volume', TJsonNumber.Create(Query.FieldByName('volume').AsFloat));
          JsonPedido.AddPair('registroerp', Query.FieldByName('RegistroERP').AsString);
          JsonPedido.AddPair('picking', Query.FieldByName('Picking').AsString);
          JsonPedido.AddPair('uuid', Query.FieldByName('uuid').AsString);
          JsonArrayPedidos.AddElement(JsonPedido);
          Query.Next;
        End;
        // End;
        Query.Close;
        Query.Sql.Clear;
        // Buscar As Rotas
        Query.Sql.Add(TuEvolutconst.SqlPedidoRotas);
        Query.ParamByName('pPedidoId').Value := pPedidoId;
        if pDataIni <> 0 then
           Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
        Else
           Query.ParamByName('pDataIni').Value := 0;
        if pDataFin <> 0 then
           Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
        Else
           Query.ParamByName('pDataFin').Value := 0;
        Query.ParamByName('pPessoaId').Value := pCodigoERP;
        // pPessoaId;
        Query.ParamByName('pDocumentoNr').Value := '';
        Query.ParamByName('pRazao').Value       := '';
        Query.ParamByName('pRegistroERP').Value := '';
        Query.ParamByName('pRotaId').Value      := pRotaId;
        Query.ParamByName('pProcessoId').Value  := pProcessoId;
        Query.ParamByName('pRecebido').Value    := pRecebido;
        Query.ParamByName('pCubagem').Value     := pCubagem;
        Query.ParamByName('pEtiqueta').Value    := pEtiqueta;
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('PedidoRotas.Sql');
        Query.Open();
        JsonArrayRotas := Query.ToJsonArray();
        Query.Close;
        Query.Sql.Clear;
        // Buscar As Pessoas/Destinatário
        Query.Sql.Add(TuEvolutconst.SqlPedidoPessoa);
        Query.ParamByName('pPedidoId').Value := pPedidoId;
        if pDataIni <> 0 then
           Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
        Else
           Query.ParamByName('pDataIni').Value := 0;
        if pDataFin <> 0 then
           Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
        Else
           Query.ParamByName('pDataFin').Value := 0;
        Query.ParamByName('pPessoaId').Value := pCodigoERP;
        // pPessoaId;
        Query.ParamByName('pDocumentoNr').Value := '';
        Query.ParamByName('pRazao').Value       := '';
        Query.ParamByName('pRegistroERP').Value := '';
        Query.ParamByName('pRotaId').Value      := pRotaId;
        Query.ParamByName('pProcessoId').Value  := pProcessoId;
        Query.ParamByName('pRecebido').Value    := pRecebido;
        Query.ParamByName('pCubagem').Value     := pCubagem;
        Query.ParamByName('pEtiqueta').Value    := pEtiqueta;
        if DebugHook <> 0 then
           Query.Sql.SaveToFile('PedidoPessoa.Sql');
        Query.Open();
        JsonArrayPessoas := Query.ToJsonArray();
        JsonRetorno := TJsonObject.Create;
        JsonRetorno.AddPair('pedido', JsonArrayPedidos);
        JsonRetorno.AddPair('rota', JsonArrayRotas);
        JsonRetorno.AddPair('pessoa', JsonArrayPessoas);
        Result := TjSonArray.Create;
        Result.AddElement(JsonRetorno);
      End;
    Except ON E: Exception do Begin
      raise Exception.Create('Processo: PedidoParaProcessamento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
End;

end.
