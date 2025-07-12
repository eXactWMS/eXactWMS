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
    Function GetPedidoAll(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer;
      pRazao, pDocumentoNr, pRegistroERP: String;
      pRotaId, pRotaIdFinal, pZonaId, pProcessoId, pMontarCarga: Integer;
      pCodProduto: Int64; pPedidoPendente: Integer; pCargaId: Integer;
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
    Function GetAnaliseColeta(aQueryParams: TDictionary<string, string>)
      : TjSonArray;
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
  Try
    Result := TjSonArray.Create;
    if pJsonArrayPedido = Nil then Begin
       Result.AddElement(TJsonObject.Create.AddPair('status', '500')
         .AddPair('pedidoid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
         .AddPair('mensagem', 'JsonArray enviado incorreto.'));
       Exit;
    End
    Else Begin
       vQryAtualiza := FConexao.GetQuery;
       vQryRegistrarRetorno := FConexao.GetQuery;
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
      raise Exception.Create('Processo: AtualizarNotaFiscal - ' + StringReplace(E.Message,
                             '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  End;
end;

function TServicePedidoSaida.AtualizarNFPedidoV2(pJsonArrayPedido: TjSonArray) : TjSonArray;
Var
  vQryPedido, vQryNfe: TFDQuery;
  vQryRegistrarRetorno: TFDQuery;
  xPedido: Integer;
  xNfe: Integer;
begin
  Try
    Result := TjSonArray.Create;
    if pJsonArrayPedido = Nil then
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('pedidoid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
        .AddPair('mensagem', 'JsonArray enviado incorreto.'));
      Exit;
    End;
    vQryPedido := FConexao.GetQuery;
    vQryNfe := FConexao.GetQuery;
    vQryPedido.connection.StartTransaction;
    vQryPedido.Close;
    vQryPedido.Sql.Clear;
    vQryPedido.Sql.Add
      ('Declare @PedidoId  Integer = (Select PedidoId From Pedido Where RegistroERP = :pRegistroERP)');
    vQryPedido.Sql.Add('Delete PedidoNotaFiscal Where PedidoId = @PedidoId');
    vQryPedido.Sql.Add
      ('Update Pedido Set Status = 5 where PedidoId = @PedidoId');
    vQryNfe.Sql.Add
      ('Declare @PedidoId Integer = (Select PedidoId From Pedido Where RegistroERP = :pRegistroERP)');
    vQryNfe.Sql.Add
      ('Insert into PedidoNotaFiscal Values (@PedidoId, :Nfe, :Chave, GetDate(), GetDate())');
    for xPedido := 0 to Pred(pJsonArrayPedido.Count) do
    Begin
      vQryPedido.ParamByName('pRegistroERP').Value := pJsonArrayPedido.Items
        [xPedido].GetValue<String>('pedido');
      vQryNfe.Params.ArraySize := pJsonArrayPedido.Items[xPedido]
        .GetValue<TjSonArray>('nfe').Count;
      For xNfe := 0 to Pred(pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Count) do
      begin
        vQryNfe.Params[0].Values[xNfe] := pJsonArrayPedido.Items[xPedido].GetValue<String>('pedido');
        vQryNfe.Params[1].Values[xNfe] := pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Items[xNfe].GetValue<String>('nfe');
        vQryNfe.Params[2].Values[xNfe] := pJsonArrayPedido.Items[xPedido].GetValue<TjSonArray>('nfe').Items[xNfe].GetValue<String>('chave');
      End;
      Try
        vQryPedido.ExecSql;
        vQryNfe.Execute(vQryNfe.Params.ArraySize, 0);
        Result.AddElement(TJsonObject.Create.AddPair('status', '200')
          .AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>
          ('pedido')).AddPair('nfe', '').AddPair('mensagem',
          'Ok - NF-e Atualizada com sucesso!'));
      Except
        Result.AddElement(TJsonObject.Create.AddPair('status', '500')
          .AddPair('pedido', pJsonArrayPedido.Items[xPedido].GetValue<String>
          ('pedido')).AddPair('nfe', '').AddPair('mensagem',
          'Erro! NF-e não Atualizada.'));
      End;
    End;
    vQryPedido.connection.Commit;
  Except
    On E: Exception do
    Begin
      vQryPedido.connection.Rollback;
      raise Exception.Create('Processo: AtualizarNotaFiscal - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

constructor TServicePedidoSaida.Create;
begin
  inherited
end;

function TServicePedidoSaida.DeletePedido(pJsonArrayPedido: TjSonArray) : TjSonArray;
Var xPedido: Integer;
begin
  Try
    Result := TjSonArray.Create;
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
    FConexao.Query.Close;
    FConexao.Query.Sql.Add('Declare @PedidoId Integer = :pPedidoId');
    FConexao.Query.Sql.Add('Declare @UsuarioId Integer = :pUsuarioId');
    FConexao.Query.Sql.Add('Declare @Terminal Varchar(50) = :pTerminal');
    FConexao.Query.SQL.Add('Declare @MotivoIdExclusao Integer = :pMotivoIdExclusao');

    FConexao.Query.Sql.Add('Update Pedido Set Status = 3 ');
    FConexao.Query.Sql.Add('                , MEP = @MotivoIdExclusao');
    FConexao.Query.Sql.Add('where PedidoId = @PedidoId and OperacaoTipoId = 2');
    FConexao.Query.Sql.Add('Update DocumentoEtapas Set Status = 0'); //01062024 nao cancelar volume já cancelado
    FConexao.Query.Sql.Add('Where Documento = (Select Uuid from Pedido Where Pedidoid = @PedidoId) and Status = 1');
    FConexao.Query.Sql.Add('  And ProcessoId = 31');
    FConexao.Query.Sql.Add('Insert Into DocumentoEtapas Values (');
    FConexao.Query.Sql.Add('   Cast((Select Uuid from Pedido Where Pedidoid = @PedidoId) as UNIQUEIDENTIFIER), ');
    FConexao.Query.Sql.Add('   (Select ProcessoId From ProcessoEtapas');
    FConexao.Query.Sql.Add('Where Descricao = '+#39+'Documento Excluido'+#39+'), ');
    FConexao.Query.Sql.Add('@UsuarioId, '+TuEvolutconst.SqlDataAtual+', '+TuEvolutconst.SqlHoraAtual + ', GetDate(), @Terminal, 1)');
    for xPedido := 0 to Pred(pJsonArrayPedido.Count) do Begin
      FConexao.Query.Close;
      FConexao.Query.ParamByName('pPedidoId').Value  := pJsonArrayPedido.Items[xPedido].GetValue<Integer>('pedidoid');
      FConexao.Query.ParamByName('pUsuarioId').Value := pJsonArrayPedido.Items[xPedido].GetValue<Integer>('usuarioid');
      FConexao.Query.ParamByName('pTerminal').Value  := pJsonArrayPedido.Items[xPedido].GetValue<String>('terminal');
      FConexao.Query.ParamByName('pMotivoIdExclusao').Value  := pJsonArrayPedido.Items[xPedido].GetValue<Integer>('motivoidexclusao');
      Try
        If DebugHook <> 0 Then
           FConexao.Query.Sql.SaveToFile('PedidoExcluir.Sql');
        FConexao.Query.ExecSql;
        Result.Add(TJsonObject.Create.AddPair('pedidoid', pJsonArrayPedido.Items[xPedido].GetValue<String>('pedidoid') +' - Ok! Excluido.'))
      Except
        raise Exception.Create('Não foi possível excluir o Pedido: '+pJsonArrayPedido.Items[xPedido].GetValue<String>('pedidoid'));
      End;
    End;
    FConexao.Query.connection.Commit;
  Except On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: DeletePedido - ' +StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  End;
end;

destructor TServicePedidoSaida.Destroy;
begin

  inherited;
end;

function TServicePedidoSaida.GetPedidoAll(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr, pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId,
  pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer; pCargaId: Integer; pNotaFiscalERP: String) : TjSonArray;
var JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni = 0 then
      FConexao.Query.ParamByName('pDataIni').Value := pDataIni
    Else
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
      FConexao.Query.ParamByName('pDataFin').Value := pDataFin
    Else
      FConexao.Query.ParamByName('pDataFin').Value      := FormatDateTime('YYYY-MM-DD', pDataFin);;
    FConexao.Query.ParamByName('pCodigoERP').Value      := pCodigoERP;
    FConexao.Query.ParamByName('pPessoaId').Value       := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value    := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value          := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value    := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value         := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value    := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value         := pZonaId;
    FConexao.Query.ParamByName('pProcessoId').Value     := pProcessoId;
    FConexao.Query.ParamByName('pMontarCarga').Value    := pMontarCarga;
    FConexao.Query.ParamByName('pCodProduto').Value     := pCodProduto;
    FConexao.Query.ParamByName('pPedidoPendente').Value := pPedidoPendente;
    FConexao.Query.ParamByName('pCargaId').Value        := pCargaId;
    FConexao.Query.ParamByName('pNotaFiscalERP').Value  := pNotaFiscalERP;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('PedidoAll.Sql');
    FConexao.Query.ParamByName('pOperacaoTipoId').Value := 2;
    FConexao.Query.Open;
    if FConexao.Query.Isempty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)));
    End
    Else Begin
       Result := FConexao.Query.ToJsonArray;
    End;
  Except ON E: Exception do Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', StringReplace(E.Message,
                        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))));
    End;
  end;
end;

function TServicePedidoSaida.GetPedidoParaCargas(pPedidoId: Integer; pDataIni,
  pDataFin: TDate; pCodigoERP, pPessoaId: Integer; pRazao, pDocumentoNr,
  pRegistroERP: String; pRotaId, pRotaIdFinal, pZonaId, pMontarCarga,
  pCargaId: Integer): TjSonArray;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlPedidoParaCargas);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni = 0 then
      FConexao.Query.ParamByName('pDataIni').Value := pDataIni
    Else
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
      FConexao.Query.ParamByName('pDataFin').Value := pDataFin
    Else
      FConexao.Query.ParamByName('pDataFin').Value      := FormatDateTime('YYYY-MM-DD', pDataFin);;
    FConexao.Query.ParamByName('pCodigoERP').Value      := pCodigoERP;
    FConexao.Query.ParamByName('pPessoaId').Value       := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value    := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value          := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value    := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value         := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value    := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value         := pZonaId;
    FConexao.Query.ParamByName('pMontarCarga').Value    := pMontarCarga;
    FConexao.Query.ParamByName('pCargaId').Value        := pCargaId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('PedidoParaCargas.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)));
    End
    Else
       Result := FConexao.Query.ToJsonArray;
  Except ON E: Exception do Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', StringReplace(E.Message,
                         '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))));
    End;
  end;
end;

function TServicePedidoSaida.GetRelAtendimentoDestinatario(pDataInicial, pDataFinal: TDateTime): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlRelAtendimentoDestinatario);
    FConexao.Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', pDataInicial);
    FConexao.Query.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', pDataFinal);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelAtendimentoDestinatario.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
    Else
      Result := FConexao.Query.ToJsonArray;
  Except ON E: Exception do Begin
      raise Exception.Create('Processo: Atendimento Por  - ' + StringReplace(E.Message,
                             '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.GetRelAtendimentoRota(pDataInicial, pDataFinal: TDateTime): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlRelAtendimentoRota);
    FConexao.Query.ParamByName('pDataInicial').Value :=
      FormatDateTime('YYYY-MM-DD', pDataInicial);
    FConexao.Query.ParamByName('pDataFinal').Value :=
      FormatDateTime('YYYY-MM-DD', pDataFinal);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelAtendimentoRota.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: Atendimento Por Rota - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.GetRelAtendimentoZona(pDataInicial,
  pDataFinal: TDateTime): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlRelAtendimentoZona);
    FConexao.Query.ParamByName('pDataInicial').Value :=
      FormatDateTime('YYYY-MM-DD', pDataInicial);
    FConexao.Query.ParamByName('pDataFinal').Value :=
      FormatDateTime('YYYY-MM-DD', pDataFinal);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelAtendimentoRota.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Etiqueta Por Rua - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.GetRelHistoricoTransferenciaPicking
  (aQueryParams: TDictionary<string, string>): TjSonArray;
Var
  pReposicaoId: Integer;
  pDataInicial, pDataFinal: TDateTime;
  pPendente: Integer;
begin
  Try
    if (aQueryParams.ContainsKey('modelo')) and
      (aQueryParams.Items['modelo'] = 'sintetico') then
      FConexao.Query.Sql.Add
        (TuEvolutconst.SqlRelHistoricoTransferenciaPickingSintetico)
    Else
      FConexao.Query.Sql.Add
        (TuEvolutconst.SqlRelHistoricoTransferenciaPickingAnalitico);
    if aQueryParams.ContainsKey('reposicaoid') then
      FConexao.Query.ParamByName('pReposicaoId').Value := aQueryParams.Items
        ['reposicaoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD',
        StrToDate(aQueryParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pDataInicial').Value := 0;
    if aQueryParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pDataFinal').Value := 0;
    if aQueryParams.ContainsKey('usuarioid') then
      FConexao.Query.ParamByName('pUsuarioId').Value := aQueryParams.Items
        ['usuarioid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pUsuarioId').Value := 0;
    if aQueryParams.ContainsKey('pendente') then
      FConexao.Query.ParamByName('pPendente').Value := aQueryParams.Items
        ['pendente'].ToInteger()
    Else
      FConexao.Query.ParamByName('pPendente').Value := 0;
    if aQueryParams.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value := aQueryParams.Items
        ['codproduto'].ToInteger()
    Else
      FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if aQueryParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := aQueryParams.Items
        ['zonaid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelHistoricoTransferenciaPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Reposição Análise - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.GetReposicaoDemanda(pData: TDate; pZonaId: Integer;
  pEnderecoInicial, pEnderecoFinal, pTipoGeracao: String): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlGetReposicaoDemanda);
    FConexao.Query.ParamByName('pDocumentoData').Value := FormatDateTime('YYYY-MM-DD', pData);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pPickingInicial').Value := pEnderecoInicial;
    FConexao.Query.ParamByName('pPickingFinal').Value := pEnderecoFinal;
    FConexao.Query.ParamByName('pTipoGeracao').Value := pTipoGeracao;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ReposicaoPorDemanda.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except ON E: Exception do Begin
    raise Exception.Create('Processo: GetReposicaoDemanda - ' + StringReplace(E.Message,
      '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.GetReposicaoCapacidade(pPercDownMaxPicking,
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String;
  pNegativo: Integer): TjSonArray;
begin
  Try

    FConexao.Query.FetchOptions.Mode := fmAll;
    FConexao.Query.Sql.Add(TuEvolutconst.SqlGetReposicaoCapacidade);
    FConexao.Query.ParamByName('pPercDownMaxPicking').Value :=
      pPercDownMaxPicking;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pPickingInicial').Value := pEnderecoInicial;
    FConexao.Query.ParamByName('pPickingFinal').Value := pEnderecoFinal;
    FConexao.Query.ParamByName('pNegativo').Value := pNegativo;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ReposicaoCapacidade.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetReposicaoDemanda - ' + StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.GetReposicaoDemandaColeta(pTipoGeracao: String) : TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlGetReposicaoDemandaColeta);
    FConexao.Query.ParamByName('pTipoGeracao').Value := pTipoGeracao;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('ReposicaoDemandaColeta.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then Begin
       Result := TjSonArray.Create();
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetReposicaoDemandaColeta - ' + TUtil.TratarExcessao(E.Message));
    End;
  end;
end;

// Move Estoque de reposicaoestoquetransferencia Para o Picking na Tabela Estoque
function TServicePedidoSaida.GetAnaliseColeta(aQueryParams
  : TDictionary<string, string>): TjSonArray;
Var
  pReposicaoId: Integer;
  pDataInicial, pDataFinal: TDateTime;
  pPendente: Integer;
begin
  Try
    if (aQueryParams.ContainsKey('modelo')) and (aQueryParams.Items['modelo'] = 'sintetico') then
       FConexao.Query.Sql.Add(TuEvolutconst.SqlRelReposicaoAnaliseColetaSintetico)
    Else
       FConexao.Query.Sql.Add(TuEvolutconst.SqlRelReposicaoAnalise);
    if aQueryParams.ContainsKey('reposicaoid') then
       FConexao.Query.ParamByName('pReposicaoId').Value := aQueryParams.Items['reposicaoid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('datainicial') then
       FConexao.Query.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datainicial']))
    Else
       FConexao.Query.ParamByName('pDataInicial').Value := 0;
    if aQueryParams.ContainsKey('datafinal') then
       FConexao.Query.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
    Else
       FConexao.Query.ParamByName('pDataFinal').Value   := 0;
    if aQueryParams.ContainsKey('usuarioid') then
        FConexao.Query.ParamByName('pUsuarioId').Value := aQueryParams.Items['usuarioid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pUsuarioId').Value  := 0;
    if aQueryParams.ContainsKey('pendente') then
       FConexao.Query.ParamByName('pPendente').Value := aQueryParams.Items['pendente'].ToInteger()
    Else
       FConexao.Query.ParamByName('pPendente').Value := 0;
    if aQueryParams.ContainsKey('divergencia') then
       FConexao.Query.ParamByName('pDivergencia').Value := aQueryParams.Items['divergencia'].ToInteger()
    Else
       FConexao.Query.ParamByName('pDivergencia').Value := 0;
    if aQueryParams.ContainsKey('naocoletado') then
       FConexao.Query.ParamByName('pNaoColetado').Value := aQueryParams.Items['naocoletado'].ToInteger()
    Else
       FConexao.Query.ParamByName('pNaoColetado').Value := 0;
    if aQueryParams.ContainsKey('codproduto') then
       FConexao.Query.ParamByName('pCodProduto').Value := aQueryParams.Items['codproduto'].ToInteger()
    Else
       FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if aQueryParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaId').Value := aQueryParams.Items['zonaid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pZonaId').Value := 0;
    if aQueryParams.ContainsKey('processoid') then
       FConexao.Query.ParamByName('pProcessoId').Value := aQueryParams.Items['processoid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pProcessoId').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelAnaliseColeta.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Reposição Análise - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.RelReposicaoTransfPicking
  (aQueryParams: TDictionary<string, string>): TjSonArray;
Var
  pReposicaoId: Integer;
  pDataInicial, pDataFinal: TDateTime;
begin
  Try
    if (aQueryParams.ContainsKey('modelo')) and
      (aQueryParams.Items['modelo'] = 'sintetico') Then
    Begin
      FConexao.Query.Sql.Add(TuEvolutconst.SqlRelReposicaoTransfSintetico);
      if aQueryParams.ContainsKey('zonaid') then
        FConexao.Query.ParamByName('pZonaId').Value :=
          StrToIntDef(aQueryParams.Items['zonaid'], 0)
      Else
        FConexao.Query.ParamByName('pZonaid').Value := 0;
    End
    Else
    Begin
      FConexao.Query.Sql.Add(TuEvolutconst.SqlRelReposicaoTransfAnalitico);
      if aQueryParams.ContainsKey('reposicaoid') then
        FConexao.Query.ParamByName('pReposicaoId').Value :=
          aQueryParams.Items['reposicaoid'].ToInteger()
      Else
        FConexao.Query.ParamByName('pReposicaoId').Value := 0;
      if aQueryParams.ContainsKey('datainicial') then
        FConexao.Query.ParamByName('pDataInicial').Value :=
          FormatDateTime('YYYY-MM-DD',
          StrToDate(aQueryParams.Items['datainicial']))
      Else
        FConexao.Query.ParamByName('pDataInicial').Value := 0;
      if aQueryParams.ContainsKey('datafinal') then
        FConexao.Query.ParamByName('pDataFinal').Value :=
          FormatDateTime('YYYY-MM-DD',
          StrToDate(aQueryParams.Items['datafinal']))
      Else
        FConexao.Query.ParamByName('pDataFinal').Value := 0;
      if aQueryParams.ContainsKey('codproduto') then
        FConexao.Query.ParamByName('pCodProduto').Value :=
          StrToIntDef(aQueryParams.Items['codproduto'], 0)
      Else
        FConexao.Query.ParamByName('pCodProduto').Value := 0;
      if aQueryParams.ContainsKey('zonaid') then
        FConexao.Query.ParamByName('pZonaId').Value :=
          StrToIntDef(aQueryParams.Items['zonaid'], 0)
      Else
        FConexao.Query.ParamByName('pZonaid').Value := 0;
    End;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelReposicaoTransferenciaPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Reposição Análise - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.RelReposicaoResumoAnalitico
  (aQueryParams: TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlGetRelReposicaoResumoAnalitico);
    if aQueryParams.ContainsKey('reposicaoid') then
      FConexao.Query.ParamByName('pReposicaoId').Value := aQueryParams.Items
        ['reposicaoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD',
        StrToDate(aQueryParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pDataInicial').Value := 0;
    if aQueryParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pDataFinal').Value := 0;
    if aQueryParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pProcessoId').Value := aQueryParams.Items
        ['processoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pProcessoId').Value := 0;
    if aQueryParams.ContainsKey('pendente') then
      FConexao.Query.ParamByName('pPendente').Value := aQueryParams.Items
        ['pendente'].ToInteger()
    Else
      FConexao.Query.ParamByName('pPendente').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelReposicaoResumoAnalitico.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: Relatório Reposição Resumo Analitico - '
        + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.RelReposicaoResumoSintetico
  (aQueryParams: TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlGetRelReposicaoResumoSintetico);
    if aQueryParams.ContainsKey('reposicaoid') then
      FConexao.Query.ParamByName('pReposicaoId').Value := aQueryParams.Items
        ['reposicaoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD',
        StrToDate(aQueryParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pDataInicial').Value := 0;
    if aQueryParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(aQueryParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pDataFinal').Value := 0;
    if aQueryParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pProcessoId').Value := aQueryParams.Items
        ['processoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pProcessoId').Value := 0;
    if aQueryParams.ContainsKey('pendente') then
      FConexao.Query.ParamByName('pPendente').Value := aQueryParams.Items
        ['pendente'].ToInteger()
    Else
      FConexao.Query.ParamByName('pPendente').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelReposicaoResumoSintetico.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: Relatório Reposição Resumo Sintético - '
        + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.ReposicaoCancelar(pJsonObject: TJsonObject)
  : TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlDelReservaReposicao);
    FConexao.Query.Sql.Add('Update Reposicao Set ProcessoId = 30');
    FConexao.Query.Sql.Add('  , UsuarioId = ' + pJsonObject.GetValue<Integer>
      ('usuarioid').ToString());
    FConexao.Query.Sql.Add('  , Terminal  = ' +
      QuotedStr(pJsonObject.GetValue<String>('terminal')));
    FConexao.Query.Sql.Add('Where ReposicaoId = ' +
      pJsonObject.GetValue<Integer>('reposicaoid').ToString());
    FConexao.Query.ParamByName('pReposicaoId').Value :=
      +pJsonObject.GetValue<Integer>('reposicaoid');
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ReposicaoCancelar.Sql');
    FConexao.Query.ExecSql;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Cancelamento Ok!'));
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServicePedidoSaida.ReposicaoExcluir(pJsonObject: TJsonObject)
  : TjSonArray;
begin
  Try

    FConexao.Query.Sql.Add(TuEvolutconst.SqlDelReservaReposicao);
    FConexao.Query.Sql.Add('Update Reposicao Set ProcessoId = 31');
    FConexao.Query.Sql.Add('  , UsuarioId = ' + pJsonObject.GetValue<Integer>
      ('usuarioid').ToString());
    FConexao.Query.Sql.Add('  , Terminal  = ' +
      QuotedStr(pJsonObject.GetValue<String>('terminal')));
    FConexao.Query.Sql.Add('Where ReposicaoId = ' +
      pJsonObject.GetValue<Integer>('reposicaoid').ToString());
    FConexao.Query.ParamByName('pReposicaoId').Value :=
      +pJsonObject.GetValue<Integer>('reposicaoid');
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ReposicaoExcluir.Sql');
    FConexao.Query.ExecSql;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Reposição excluída!'));
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServicePedidoSaida.ReposicaoRegistrarInUse(pReposicaoId,
  pUsuarioId: Integer; pTerminal: String): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add('Update reposicao');
    FConexao.Query.Sql.Add('  Set UsuarioIdInUse = 0');
    // +pUsuarioId.ToString());
    FConexao.Query.Sql.Add('    , TerminalInUse  = ' + QuotedStr(pTerminal));
    FConexao.Query.Sql.Add('Where ReposicaoId = ' + pReposicaoId.ToString());
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ReposicaoRegistrarInUse.Sql');
    FConexao.Query.ExecSql;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok',
      'Registrado com sucesso!'));
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End
end;

function TServicePedidoSaida.ReposicaoTransferenciaPicking(pJsonTransferencia : TJsonObject): TjSonArray;
Var
  vQryTrasferecia: TFDQuery;
  vQryEstoqueTransf: TFDQuery;
  vQtdBaixaLote: Integer;
  vBaixaEstoque: Integer;
begin
  Try
    vQryTrasferecia := FConexao.GetQuery;
    vQryEstoqueTransf := FConexao.GetQuery;
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
  Except
    On E: Exception do
    Begin
      vQryTrasferecia.connection.Rollback;
      raise Exception.Create('Não foi possível fazer a transferência.' + sLineBreak + E.Message);
    End;
  end;
end;

function TServicePedidoSaida.GetReposicaoHistorico(aQueryParams
  : TDictionary<string, string>): TjSonArray;
Var
  pReposicaoId, pCodProduto, pZonaReposicaoId, pZonaColetaId: Integer;
  pUsuarioId, pProcessoId, pDtReposicaoInicial: Integer;
  pDtReposicaoFinal, pEnderecoColetaId: TDateTime;
  pDivergencia: Integer;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlRelReposicaoHistorico);
    if aQueryParams.ContainsKey('reposicaoid') then
      FConexao.Query.ParamByName('pReposicaoId').Value := aQueryParams.Items
        ['reposicaoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value := aQueryParams.Items
        ['codproduto'].ToInteger()
    Else
      FConexao.Query.ParamByName('pCodProduto').Value := 0;
    if aQueryParams.ContainsKey('zonareposicaoid') then
      FConexao.Query.ParamByName('pZonaReposicaoId').Value :=
        aQueryParams.Items['zonareposicaoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pZonaReposicaoId').Value := 0;
    if aQueryParams.ContainsKey('zonacoletaid') then
      FConexao.Query.ParamByName('pZonaColetaId').Value :=
        aQueryParams.Items['zonacoletaid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pZonaColetaId').Value := 0;
    if aQueryParams.ContainsKey('usuarioid') then
      FConexao.Query.ParamByName('pUsuarioId').Value := aQueryParams.Items
        ['usuarioid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pUsuarioId').Value := 0;
    if aQueryParams.ContainsKey('usuarioid') then
      FConexao.Query.ParamByName('pUsuarioId').Value := aQueryParams.Items
        ['usuarioid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pUsuarioId').Value := 0;
    if aQueryParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pProcessoId').Value := aQueryParams.Items
        ['processoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pProcessoId').Value := 0;
    if aQueryParams.ContainsKey('dtreposicaoinicial') then
      FConexao.Query.ParamByName('pDtReposicaoInicial').Value :=
        FormatDateTime('YYYY-MM-DD',
        StrToDate(aQueryParams.Items['dtreposicaoinicial']))
    Else
      FConexao.Query.ParamByName('pDtReposicaoInicial').Value := 0;
    if aQueryParams.ContainsKey('dtreposicaofinal') then
      FConexao.Query.ParamByName('pDtReposicaoFinal').Value :=
        FormatDateTime('YYYY-MM-DD',
        StrToDate(aQueryParams.Items['dtreposicaofinal']))
    Else
      FConexao.Query.ParamByName('pDtReposicaoFinal').Value := 0;
    if aQueryParams.ContainsKey('enderecocoletaid') then
      FConexao.Query.ParamByName('pEnderecoColetaId').Value :=
        aQueryParams.Items['enderecocoletaid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pEnderecoColetaId').Value := 0;
    if aQueryParams.ContainsKey('divergencia') then
      FConexao.Query.ParamByName('pDivergencia').Value := aQueryParams.Items
        ['dtreposicaoinicial'].ToInteger()
    Else
      FConexao.Query.ParamByName('pDivergencia').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelReposicaoHistorico.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutconst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Etiqueta Por Rua - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoSaida.PedidoParaProcessamento(pPedidoId,
  pCodigoERP: Integer; pDataIni, pDataFin: TDateTime;
  pProcessoId, pRotaId, pRotaIdFinal, pZonaId, pRecebido, pCubagem,
  pEtiqueta: Integer): TjSonArray;
Var JsonArrayPedidos, JsonArrayRotas, JsonArrayPessoas: TjSonArray;
    JsonRetorno, JsonPedido, JsonOperacao, JsonNatureza, JsonRota, JsonPessoa: TJsonObject;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutconst.SqlPedidoParaProcessamento);
    FConexao.Query.ParamByName('pPedidoId').Value  := pPedidoId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    if pDataIni <> 0 then
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
       FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
       FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
       FConexao.Query.ParamByName('pDataFin').Value  := 0;
    FConexao.Query.ParamByName('pRotaId').Value      := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value      := pZonaId;
    FConexao.Query.ParamByName('pProcessoId').Value  := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value    := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value     := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value    := pEtiqueta;
    if (pRotaId>0) or (pRotaIdFinal>0) then
       FConexao.Query.sql.Add('Order by P.RotaId, P.PedidoId')
    Else
       FConexao.Query.sql.Add('Order by P.Data, p.PedidoId');
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('PedidoParaProcessamento.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then Begin
       Result := TjSonArray.Create();
       Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro', TuEvolutconst.QrySemDados)))
    End
    Else
    Begin
      JsonArrayPedidos := TjSonArray.Create;
      while Not FConexao.Query.Eof do Begin
        JsonPedido := TJsonObject.Create;
        JsonOperacao := TJsonObject.Create;
        JsonNatureza := TJsonObject.Create;
        JsonPessoa := TJsonObject.Create;
        JsonPedido.AddPair('pedidoid', TJsonNumber.Create(FConexao.Query.FieldByName('PedidoId').AsInteger));
        JsonPedido.AddPair('processoid', TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoId').AsInteger));
        JsonPedido.AddPair('processoetapa', FConexao.Query.FieldByName('ProcessoEtapa').AsString);
        JsonPedido.AddPair('statusmin', TJsonNumber.Create(FConexao.Query.FieldByName('StatusMin').AsInteger));
        JsonPedido.AddPair('statusmax', TJsonNumber.Create(FConexao.Query.FieldByName('StatusMax').AsInteger));
        JsonOperacao.AddPair('operacaotipoid', TJsonNumber.Create(FConexao.Query.FieldByName('OperacaoTipoId').AsInteger));
        JsonOperacao.AddPair('descricao', FConexao.Query.FieldByName('OperacaoTipo').AsString);
        JsonPedido.AddPair('operacaotipo', JsonOperacao);
        JsonPessoa.AddPair('pessoaid', TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').AsInteger));
        JsonPessoa.AddPair('codpessoaerp', TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaERP').AsInteger));
        JsonPessoa.AddPair('razao', FConexao.Query.FieldByName('Razao').AsString);
        JsonPessoa.AddPair('fantasia', FConexao.Query.FieldByName('Fantasia').AsString);
        JsonPessoa.AddPair('rotaid', TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').AsInteger));
        JsonPessoa.AddPair('rota', FConexao.Query.FieldByName('Rota').AsString);
        JsonPedido.AddPair('pessoa', JsonPessoa);
        JsonPedido.AddPair('documentonr', FConexao.Query.FieldByName('DocumentoNr').AsString);
        JsonPedido.AddPair('documentodatar', DateToStr(FConexao.Query.FieldByName('DocumentoData').AsDateTime));
        // FormatDateTime('YYYY-MM-DD', vQry.FieldByName('DocumentoData').AsDateTime));
        // jsonPedido.AddPair('dtinclusao', FormatDateTime('YYYY-MM-DD', FConexao.Query.FieldByName('DtInclusao').AsDateTime));
        // jsonPedido.AddPair('hrinclusao', FConexao.Query.FieldByName('HrInclusao').AsString);//FormatDateTime('hh:mm', vQry.FieldByName('HrInclusao').AsDateTime));
        JsonPedido.AddPair('armazemid', TJsonNumber.Create(FConexao.Query.FieldByName('ArmazemId').AsInteger));
        JsonPedido.AddPair('status', TJsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
        JsonPedido.AddPair('qtdproduto', TJsonNumber.Create(FConexao.Query.FieldByName('QtdProdutos').AsInteger));
        JsonPedido.AddPair('peso', TJsonNumber.Create(FConexao.Query.FieldByName('peso').AsInteger));
        JsonPedido.AddPair('volume', TJsonNumber.Create(FConexao.Query.FieldByName('volume').AsFloat));
        JsonPedido.AddPair('registroerp', FConexao.Query.FieldByName('RegistroERP').AsString);
        JsonPedido.AddPair('picking', FConexao.Query.FieldByName('Picking').AsString);
        JsonPedido.AddPair('uuid', FConexao.Query.FieldByName('uuid').AsString);
        JsonArrayPedidos.AddElement(JsonPedido);
        FConexao.Query.Next;
      End;
      // End;
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      // Buscar As Rotas
      FConexao.Query.Sql.Add(TuEvolutconst.SqlPedidoRotas);
      FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni <> 0 then
         FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         FConexao.Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
         FConexao.Query.ParamByName('pDataFin').Value := 0;
      FConexao.Query.ParamByName('pPessoaId').Value := pCodigoERP;
      // pPessoaId;
      FConexao.Query.ParamByName('pDocumentoNr').Value := '';
      FConexao.Query.ParamByName('pRazao').Value       := '';
      FConexao.Query.ParamByName('pRegistroERP').Value := '';
      FConexao.Query.ParamByName('pRotaId').Value      := pRotaId;
      FConexao.Query.ParamByName('pProcessoId').Value  := pProcessoId;
      FConexao.Query.ParamByName('pRecebido').Value    := pRecebido;
      FConexao.Query.ParamByName('pCubagem').Value     := pCubagem;
      FConexao.Query.ParamByName('pEtiqueta').Value    := pEtiqueta;
      if DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('PedidoRotas.Sql');
      FConexao.Query.Open();
      JsonArrayRotas := FConexao.Query.ToJsonArray();
      { JsonArrayRotas := tjsonArray.Create;
        while Not FConexao.Query.Eof do Begin
        jsonRota := tJsonObject.Create();
        jsonRota.addPair('rotaid', TJSONNumber.Create( FConexao.Query.FieldByName('RotaId').AsInteger) );
        jsonRota.addPair('descricao', FConexao.Query.FieldByName('Descricao').AsString );
        jsonArrayRotas.AddElement(JsonRota);
        FConexao.Query.Next;
        End;
      } FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      // Buscar As Pessoas/Destinatário
      FConexao.Query.Sql.Add(TuEvolutconst.SqlPedidoPessoa);
      FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
      if pDataIni <> 0 then
         FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni)
      Else
         FConexao.Query.ParamByName('pDataIni').Value := 0;
      if pDataFin <> 0 then
         FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin)
      Else
         FConexao.Query.ParamByName('pDataFin').Value := 0;
      FConexao.Query.ParamByName('pPessoaId').Value := pCodigoERP;
      // pPessoaId;
      FConexao.Query.ParamByName('pDocumentoNr').Value := '';
      FConexao.Query.ParamByName('pRazao').Value       := '';
      FConexao.Query.ParamByName('pRegistroERP').Value := '';
      FConexao.Query.ParamByName('pRotaId').Value      := pRotaId;
      FConexao.Query.ParamByName('pProcessoId').Value  := pProcessoId;
      FConexao.Query.ParamByName('pRecebido').Value    := pRecebido;
      FConexao.Query.ParamByName('pCubagem').Value     := pCubagem;
      FConexao.Query.ParamByName('pEtiqueta').Value    := pEtiqueta;
      if DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('PedidoPessoa.Sql');
      FConexao.Query.Open();
      JsonArrayPessoas := FConexao.Query.ToJsonArray();
      JsonRetorno := TJsonObject.Create;
      JsonRetorno.AddPair('pedido', JsonArrayPedidos);
      JsonRetorno.AddPair('rota', JsonArrayRotas);
      JsonRetorno.AddPair('pessoa', JsonArrayPessoas);
      Result := TjSonArray.Create;
      Result.AddElement(JsonRetorno);
    End;
  Except ON E: Exception do Begin
    raise Exception.Create('Processo: PedidoParaProcessamento - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
End;

end.
