unit Services.Inventario;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, System.Generics.Collections,
  Constants, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI,
  exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TServiceInventario = class (TBasicDao)
  private
    { Private declarations }

  public
    { Public declarations }
    function InsertUpdate(pJsonInventario: TJsonObject): TJsonObject;
    Function ZerarContagem(pInventarioId, pEnderecoId, pProdutoId: Integer)
      : TJsonObject;
    Function SaveContagem(pJsonArray: TJsonArray): TJsonObject;
    function GetInventario(const AParams: TDictionary<string, string>)
      : TJsonArray;
    Function GetPendente: TJsonArray;
    Function GetItens(Const pInventarioId: Integer): TJsonArray;
    Function GetLoteInventariado(Const AParams: TDictionary<string, string>)
      : TJsonArray;
    function GetInventario4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function Cancelar(Const AParams: TDictionary<string, string>): Boolean;
    Function InventarioFechar(Const AParams
      : TDictionary<string, string>): Boolean;
    Function Contagem(pItem: Integer): TJsonArray;
    Function Delete(pInventarioId: Integer): Boolean;
    Function InventarioCancelar(pInventarioId: Integer): TJsonArray;
    Function ApuracaoInventarioEndereco(Const AParams
      : TDictionary<string, string>): TJsonArray;
    Function ApuracaoInventarioProduto(Const AParams
      : TDictionary<string, string>): TJsonArray;
    Function LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer)
      : TJsonArray;
    Function GetInventarioConsultaIntegracao: TJsonArray;
    Function PutInventarioIntegracao(pInventarioId: String): TJsonArray;
    Function GetDSHAcompanhamentoContagem(const AParams
      : TDictionary<string, string>): TJsonObject;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServiceInventario: TServiceInventario;

implementation

{ TProvidersBase1 }

function TServiceInventario.ApuracaoInventarioEndereco(const AParams : TDictionary<string, string>): TJsonArray;
Var vQryApuracao: TFDQuery;
    xPedido, vApuracao, pProcessoId: Integer;
begin
  Try
    Try
      Result := TJsonArray.Create;
      vQryApuracao := FConexao.GetQuery;
      vQryApuracao.connection.StartTransaction;
      vQryApuracao.connection.TxOptions.Isolation := xiReadCommitted;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('select inventariotipo from inventarios where inventarioid = '+AParams.Items['inventarioid']);
      FConexao.Query.open;
      if FConexao.Query.FieldByName('InventarioTipo').AsInteger = 1 then Begin
         FConexao.Query.Close;
         FConexao.Query.SQL.Clear;
         //Veficar se não existe bloqueio em outros Inventarios Abertos
         FConexao.Query.SQL.Add('update TEnd Set BloqueioInventario = 0');
         FConexao.Query.SQL.Add('From Enderecamentos TEnd');
         FConexao.Query.SQL.Add('inner join inventarioitens II On II.EnderecoId = TEnd.EnderecoId');
         FConexao.Query.SQL.Add('Where II.inventarioid = '+AParams.Items['inventarioid']);
      End
      Else if FConexao.Query.FieldByName('InventarioTipo').AsInteger = 2 then Begin
         FConexao.Query.Close;
         FConexao.Query.SQL.Clear;
         FConexao.Query.SQL.Add('update Prd Set BloqueioInventario = 0');
         FConexao.Query.SQL.Add('From Produto Prd');
         FConexao.Query.SQL.Add('inner join inventarioitens II On II.produtoid = Prd.IdProduto');
         FConexao.Query.SQL.Add('Where II.inventarioid = '+AParams.Items['inventarioid']);
      End;
      if DebugHook <> 0 then
         FConexao.Query.SQL.SaveToFile('ApuracaoInventario01.Sql');
      FConexao.Query.ExecSql;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      vQryApuracao.SQL.Add('Declare @IntegraAjusteERP Integer;');
      vQryApuracao.SQL.Add('If (Select IntegrarAjusteERP From Configuracao) = 0');
      vQryApuracao.SQL.Add('   Set @IntegraAjusteERP = 2');
      vQryApuracao.SQL.Add('Else Set @IntegraAjusteERP = 0');
      vQryApuracao.SQL.Add('Declare @InventarioId Integer = ' + AParams.Items['inventarioid']);
      vQryApuracao.SQL.Add('-- Inserir Ajuste para Integração e Consultas Futuras');
      vQryApuracao.SQL.Add('Insert inventarioajuste');
      vQryApuracao.SQL.Add('  select @InventarioId, Ctg.enderecoid, Ctg.ProdutoId, ');
      vQryApuracao.SQL.Add('         Ctg.loteid, Ctg.Contagem, Ctg.Ajuste, @IntegraAjusteERP Status, NEWID()');
      vQryApuracao.SQL.Add('  From (Select Prd.CodProduto, II.enderecoid, II.ProdutoId, II.loteid, ');
      vQryApuracao.SQL.Add('               II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste');
      vQryApuracao.SQL.Add('        from InventarioInicial II');
      vQryApuracao.SQL.Add('        Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId');
      vQryApuracao.SQL.Add('        Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId');
      vQryApuracao.SQL.Add('        Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId');
      vQryApuracao.SQL.Add('        Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And');
      vQryApuracao.SQL.Add('                  (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))');
      vQryApuracao.SQL.Add('        Where InventarioId = @InventarioId) Ctg');
      vQryApuracao.SQL.Add('  --Where Ajuste <> 0');

      vQryApuracao.SQL.Add('--Incluir estoque de lotes inexistente');
      vQryApuracao.SQL.Add('Insert Into Estoque Select Ctg.loteid, Ctg.enderecoid, 4, Ctg.Contagem, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      vQryApuracao.SQL.Add('           (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), Null, Null, Null, Null');
      vQryApuracao.SQL.Add('from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste');
      vQryApuracao.SQL.Add('		      from InventarioInicial II');
      vQryApuracao.SQL.Add('       	Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId');
      vQryApuracao.SQL.Add('        Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId');
      vQryApuracao.SQL.Add('        Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId');
      vQryApuracao.SQL.Add('       	Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))');
      vQryApuracao.SQL.Add('	       Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg');
      vQryApuracao.SQL.Add('Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid');
      vQryApuracao.SQL.Add('where Coalesce(Est.EstoqueTipoId, 0) <> 6 and (Est.EnderecoId is Null)');

      vQryApuracao.SQL.Add('--Update no lotes já existentes');
      vQryApuracao.SQL.Add('Update Est Set Qtde = Ctg.Contagem');
      vQryApuracao.SQL.Add('From   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, ');
      vQryApuracao.SQL.Add('Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste');
      vQryApuracao.SQL.Add('		      from InventarioInicial II');
      vQryApuracao.SQL.Add('	       Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId');
      vQryApuracao.SQL.Add('		      Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId');
      vQryApuracao.SQL.Add('		      Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId');
      vQryApuracao.SQL.Add('		      Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId ');
      vQryApuracao.SQL.Add('             And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))');
      vQryApuracao.SQL.Add('		      Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg');
      vQryApuracao.SQL.Add('Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid');
      vQryApuracao.SQL.Add('where Coalesce(Est.EstoqueTipoId, 0) <> 6 and (Est.EnderecoId is Not Null)');
      vQryApuracao.SQL.Add('--Registrar Ajuste no Kardex');
      vQryApuracao.SQL.Add('Delete Est');
      vQryApuracao.SQL.Add('from (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial,');
      vQryApuracao.SQL.Add('     Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste');
      vQryApuracao.SQL.Add('		      from InventarioInicial II');
      vQryApuracao.SQL.Add('		      Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId');
      vQryApuracao.SQL.Add('		      Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId');
      vQryApuracao.SQL.Add('		      Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId');
      vQryApuracao.SQL.Add('		      Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId ');
      vQryApuracao.SQL.Add('             And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))');
      vQryApuracao.SQL.Add('		      Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg');
      vQryApuracao.SQL.Add('Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid');
      vQryApuracao.SQL.Add('where Qtde = 0');
      // Apagar Estoque existente e não contado
      vQryApuracao.SQL.Add('If (Select InventarioTipo From Inventarios Where InventarioId = @InventarioId) = 1 begin --Por Endereco');
      vQryApuracao.SQL.Add('	  Insert Into InventarioAjuste ');
      vQryApuracao.SQL.Add('           Select @InventarioId, Est.enderecoId, Pl.ProdutoId, Est.LoteId, 0, Est.Qtde*-1, @IntegraAjusteERP, NewId()');
      vQryApuracao.SQL.Add('	          from Estoque Est');
      vQryApuracao.SQL.Add('	          inner Join (Select EnderecoId');
      vQryApuracao.SQL.Add('			                    From InventarioInicial');
      vQryApuracao.SQL.Add('			                    Where InventarioId = @InventarioId');
      vQryApuracao.SQL.Add('			                    Group By Enderecoid)  IE On IE.EnderecoId = Est.EnderecoId');
      vQryApuracao.SQL.Add('	          Left Join InventarioInicial II On II.EnderecoId = Est.EnderecoId and II.Loteid = Est.LoteId');
      vQryApuracao.SQL.Add('           Left Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
      vQryApuracao.SQL.Add('	          Where II.LoteId Is Null and Est.EstoqueTipoId In (4)');
      vQryApuracao.SQL.Add('');
      vQryApuracao.SQL.Add('	Delete Est');
      vQryApuracao.SQL.Add('	from Estoque Est');
      vQryApuracao.SQL.Add('	inner Join (Select EnderecoId');
      vQryApuracao.SQL.Add('			   From InventarioInicial');
      vQryApuracao.SQL.Add('			   Where InventarioId = @InventarioId');
      vQryApuracao.SQL.Add('			   Group By Enderecoid)  IE On IE.EnderecoId = Est.EnderecoId');
      vQryApuracao.SQL.Add('	Left Join InventarioInicial II On II.EnderecoId = Est.EnderecoId and II.Loteid = Est.LoteId');
      vQryApuracao.SQL.Add('	Where II.LoteId Is Null and Est.EstoqueTipoId In (4)');
      vQryApuracao.SQL.Add('End');
      vQryApuracao.SQL.Add('Else Begin --Por Endereço');
      vQryApuracao.SQL.Add('  Insert Into InventarioAjuste Select @InventarioId, Est.enderecoId, Pl.ProdutoId, Est.LoteId, 0, Est.Qtde*-1, @IntegraAjusteERP, NewId()');
      vQryApuracao.SQL.Add('  from Estoque Est');
      vQryApuracao.SQL.Add('  Inner Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
      vQryApuracao.SQL.Add('  inner Join (Select ProdutoId');
      vQryApuracao.SQL.Add('		      From InventarioInicial');
      vQryApuracao.SQL.Add('			  Where InventarioId = @InventarioId');
      vQryApuracao.SQL.Add('	  	      Group By Produtoid)  IE On IE.ProdutoId = Pl.ProdutoId');
      vQryApuracao.SQL.Add('  Left Join InventarioInicial II On II.ProdutoId = Pl.ProdutoId');
      vQryApuracao.SQL.Add('            and II.Loteid = Est.LoteId');
      vQryApuracao.SQL.Add('			and II.EnderecoId = Est.EnderecoId');
      vQryApuracao.SQL.Add('  Where II.LoteId Is Null and Est.EstoqueTipoId In (4)');
      vQryApuracao.SQL.Add('');
      vQryApuracao.SQL.Add('  Delete Est');
      vQryApuracao.SQL.Add('  from Estoque Est');
      vQryApuracao.SQL.Add('  Inner Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
      vQryApuracao.SQL.Add('  inner Join (Select ProdutoId');
      vQryApuracao.SQL.Add('		      From InventarioInicial');
      vQryApuracao.SQL.Add('			  Where InventarioId = @InventarioId');
      vQryApuracao.SQL.Add('	  	      Group By Produtoid)  IE On IE.ProdutoId = Pl.ProdutoId');
      vQryApuracao.SQL.Add('  Left Join InventarioInicial II On II.ProdutoId = Pl.ProdutoId');
      vQryApuracao.SQL.Add('            and II.Loteid = Est.LoteId');
      vQryApuracao.SQL.Add('			and II.EnderecoId = Est.EnderecoId');
      vQryApuracao.SQL.Add('  Where II.LoteId Is Null and Est.EstoqueTipoId In (4)');
      vQryApuracao.SQL.Add('End;');
      if DebugHook <> 0 then
         vQryApuracao.SQL.SaveToFile('ApuracaoInventario02.Sql');
      vQryApuracao.ExecSQL;
      vQryApuracao.Close;
      vQryApuracao.SQL.Clear;
      vQryApuracao.SQL.Add('Select ProcessoId From ProcessoEtapas');
      vQryApuracao.Sql.Add('where Descricao = '+#39+ 'Inventario - Finalizado' + #39);
      vQryApuracao.Open();
      pProcessoId := vQryApuracao.FieldByName('ProcessoId').AsInteger;
      vQryApuracao.Close;
      vQryApuracao.SQL.Clear;
      vQryApuracao.SQL.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios');
      vQryApuracao.SQL.Add('                                  Where InventarioId = ' + AParams.Items['inventarioid'] + ')');
      vQryApuracao.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      vQryApuracao.ParamByName('pTerminal').Value := AParams.Items['terminal'];
      vQryApuracao.ParamByName('pProcessoId').Value := pProcessoId;
      vQryApuracao.ParamByName('pUsuarioId').Value := AParams.Items['usuarioid'];
      if DebugHook <> 0 then
         vQryApuracao.Sql.SaveToFile('ApuracaoInventarioRegistrar.Sql');
      vQryApuracao.ExecSQL;
      vQryApuracao.connection.Commit;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Apuração de resultado concluída!'));
      FConexao.DB.Connected := False;
    Except On E: Exception do
      Begin
        vQryApuracao.Close;
        vQryApuracao.connection.Rollback;
        FConexao.DB.Connected := False;
        raise Exception.Create('Processo: ApuraçãoInventarioEndereco - ' + StringReplace(E.Message,
              '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
      End;
    End;
  Finally
    vQryApuracao.Close;
  End;
end;

function TServiceInventario.ApuracaoInventarioProduto(const AParams
  : TDictionary<string, string>): TJsonArray;
begin

end;

function TServiceInventario.Cancelar(const AParams : TDictionary<string, string>): Boolean;
begin

end;

function TServiceInventario.Contagem(pItem: Integer): TJsonArray;
begin

end;

constructor TServiceInventario.Create;
begin
   inherited;
end;

function TServiceInventario.Delete(pInventarioId: Integer): Boolean;
begin

end;

destructor TServiceInventario.Destroy;
begin

  inherited;
end;

function TServiceInventario.GetDSHAcompanhamentoContagem(const AParams
  : TDictionary<string, string>): TJsonObject;
Var
  vQryInventario: TFDQuery;
  vQryEndereco: TFDQuery;
  vParamOk: Integer;
  vProcessoId: Integer;
begin
  Try
    Try
      Result := TJsonObject.Create;
      vQryInventario := FConexao.GetQuery;
      vQryEndereco := FConexao.GetQuery;
      vQryInventario.connection := FConexao.DB;
      vQryEndereco.connection := FConexao.DB;
      vQryInventario.Close;
      vQryInventario.SQL.Add
        (TuEvolutConst.SqlDSHAcompanhamentoContagemInventario);
      vParamOk := 0;
      if AParams.ContainsKey('inventarioidinicial') then
      Begin
        vQryInventario.ParamByName('pInventarioidInicial').Value :=
          AParams.Items['inventarioidinicial'];
        Inc(vParamOk);
      end
      Else
        vQryInventario.ParamByName('pInventarioidInicial').Value := 0;
      if AParams.ContainsKey('inventarioidfinal') then
      Begin
        vQryInventario.ParamByName('pInventarioIdFinal').Value :=
          AParams.Items['inventarioidfinal'];
        Inc(vParamOk);
      end
      Else
        vQryInventario.ParamByName('pInventarioIdFinal').Value := 0;
      if AParams.ContainsKey('datainicial') then
      Begin
        vQryInventario.ParamByName('pDataInicial').Value :=
          FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
        Inc(vParamOk);
      end
      Else
        vQryInventario.ParamByName('pDataInicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
      Begin
        vQryInventario.ParamByName('pDataFinal').Value :=
          FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
        Inc(vParamOk);
      end
      Else
        vQryInventario.ParamByName('pDataFinal').Value := 0;
      if DebugHook <> 0 then
        vQryInventario.SQL.SaveToFile('DSHAcompanhamentoContagemInventario.Sql');
      vQryInventario.Open;
      if vQryInventario.IsEmpty then
        Result.AddPair('Erro', TuEvolutConst.QrySemDados)
      Else
      Begin
        Result.AddPair('inventario', vQryInventario.ToJsonArray);
        vQryEndereco.Close;
        vQryEndereco.SQL.Add(TuEvolutConst.SqlDSHAcompanhamentoContagemEndereco);
        vParamOk := 0;
        if AParams.ContainsKey('inventarioidinicial') then
        Begin
          vQryEndereco.ParamByName('pInventarioidInicial').Value :=
            AParams.Items['inventarioidinicial'];
          Inc(vParamOk);
        end
        Else
          vQryEndereco.ParamByName('pInventarioidInicial').Value := 0;
        if AParams.ContainsKey('inventarioidfinal') then
        Begin
          vQryEndereco.ParamByName('pInventarioIdFinal').Value :=
            AParams.Items['inventarioidfinal'];
          Inc(vParamOk);
        end
        Else
          vQryEndereco.ParamByName('pInventarioidFinal').Value := 0;
        if AParams.ContainsKey('datainicial') then
        Begin
          vQryEndereco.ParamByName('pDataInicial').Value :=
            FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
          Inc(vParamOk);
        end
        Else
          vQryEndereco.ParamByName('pDataInicial').Value := 0;
        if AParams.ContainsKey('datafinal') then
        Begin
          vQryEndereco.ParamByName('pDataFinal').Value :=
            FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
          Inc(vParamOk);
        end
        Else
          vQryEndereco.ParamByName('pDataFinal').Value := 0;
        if DebugHook <> 0 then
          vQryEndereco.SQL.SaveToFile('DSHAcompanhamentoContagemEndereco.Sql');
        vQryEndereco.Open;
        if vQryEndereco.IsEmpty then
          Result.AddPair('Erro', TuEvolutConst.QrySemDados)
        Else
          Result.AddPair('endereco', vQryEndereco.ToJsonArray);
      End;
      vQryInventario.Close;

      FConexao.DB.Connected := False;
    Except
      On E: Exception do
      Begin

        raise Exception.Create('Processo: GetDSHAcompanhamentoContagem - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    End;
  Finally
    vQryInventario.Close;
    vQryEndereco.Close;
  End;
end;

function TServiceInventario.GetInventario(const AParams
  : TDictionary<string, string>): TJsonArray;
begin

end;

function TServiceInventario.GetInventario4D(const AParams
  : TDictionary<string, string>): TJsonObject;
begin

end;

function TServiceInventario.GetInventarioConsultaIntegracao: TJsonArray;
begin

end;

function TServiceInventario.GetItens(const pInventarioId: Integer): TJsonArray;
begin

end;

function TServiceInventario.GetLoteInventariado(const AParams
  : TDictionary<string, string>): TJsonArray;
Var
  vQryLoteInvetariado: TFDQuery;
  vParamOk: Integer;
  vProcessoId: Integer;
begin
  Try
    Try
      Result := TJsonArray.Create;
      vQryLoteInvetariado := FConexao.GetQuery;

      vQryLoteInvetariado.Close;
      vQryLoteInvetariado.SQL.Add(TuEvolutConst.SqlGetLoteInventario);
      vParamOk := 0;
      if AParams.ContainsKey('inventarioid') then
      begin
        vQryLoteInvetariado.SQL.Add('and II.InventarioId = :pInventarioId');
        vQryLoteInvetariado.ParamByName('pInventarioId').Value :=
          AParams.Items['inventarioid'];
        Inc(vParamOk);
      end;
      if AParams.ContainsKey('produtoid') then
      begin
        vQryLoteInvetariado.SQL.Add('and II.ProdutoId = :pProdutoId');
        vQryLoteInvetariado.ParamByName('pProdutoId').Value :=
          AParams.Items['produtoid'];
        Inc(vParamOk);
      end;
      if AParams.ContainsKey('enderecoid') then
      begin
        vQryLoteInvetariado.SQL.Add('and II.EnderecoId = :pEnderecoId');
        vQryLoteInvetariado.ParamByName('pEnderecoId').Value :=
          AParams.Items['enderecoid'];
        Inc(vParamOk);
      end;
      if vParamOk <> AParams.Count then
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          'Parâmetros incorretos na requisição!'))
      Else
      begin
        // QryPesquisa.Sql.Add('Order by InventarioId, Endereco, ProdutoId, DescrLote');
        vQryLoteInvetariado.SQL.Add('Order by II.InventarioId, II.Status, ');
        vQryLoteInvetariado.SQL.Add
          ('         Case When Inv.inventariotipo = 1 then TEnd.Descricao--, ProdutoId, DescrLote');
        vQryLoteInvetariado.SQL.Add
          ('              When Inv.inventariotipo = 2 then II.ProdutoId --, Endereco, DescrLote');
        vQryLoteInvetariado.SQL.Add('	     End,');
        vQryLoteInvetariado.SQL.Add
          ('         Case When Inv.inventariotipo = 1 then II.ProdutoId--, DescrLote');
        vQryLoteInvetariado.SQL.Add
          ('              When Inv.inventariotipo = 2 then II.InventarioId--, ProdutoId, Endereco, DescrLote');
        vQryLoteInvetariado.SQL.Add('	     End');
        vQryLoteInvetariado.SQL.Add('		 , DescrLote');
        If DebugHook <> 0 Then
          vQryLoteInvetariado.SQL.SaveToFile('LoteInventariado.Sql');
        vQryLoteInvetariado.Open();
        if vQryLoteInvetariado.IsEmpty then
          Result.AddElement(TJsonObject.Create.AddPair('Erro',
            TuEvolutConst.QrySemDados))
        Else
          Result := vQryLoteInvetariado.ToJsonArray;
      end;
      vQryLoteInvetariado.Close;

      FConexao.DB.Connected := False;
    Except
      On E: Exception do
      Begin
        vQryLoteInvetariado.Close;

        FConexao.DB.Connected := False;
        raise Exception.Create('Processo: ApuraçãoInventarioEndereco - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    End;
  Finally
    vQryLoteInvetariado.Close;
  End;
end;

function TServiceInventario.GetPendente: TJsonArray;
begin

end;

function TServiceInventario.InsertUpdate(pJsonInventario: TJsonObject)
  : TJsonObject;
begin

end;

function TServiceInventario.InventarioCancelar(pInventarioId: Integer)
  : TJsonArray;
begin

end;

function TServiceInventario.InventarioFechar(const AParams
  : TDictionary<string, string>): Boolean;
begin

end;

function TServiceInventario.LimparContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonArray;
begin

end;

function TServiceInventario.PutInventarioIntegracao(pInventarioId: String)
  : TJsonArray;
begin

end;

function TServiceInventario.SaveContagem(pJsonArray: TJsonArray): TJsonObject;
begin

end;

function TServiceInventario.ZerarContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonObject;
begin

end;

end.
