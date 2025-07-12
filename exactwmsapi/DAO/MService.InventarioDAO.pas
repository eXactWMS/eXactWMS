unit MService.InventarioDAO;

interface

uses
  FireDAC.Comp.Client, InventarioClass, System.SysUtils,
  DataSet.Serialize,
  FireDAC.Stan.Option, System.JSON, REST.JSON, System.Generics.Collections,
  Web.HTTPApp, exactwmsservice.lib.utils, exactwmsservice.lib.connection,
  exactwmsservice.dao.base, Math;

type
  TInventarioDao = class(TBasicDao)
  private
    ObjInventarioDAO: TInventario;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pJsonInventario: TJsonObject): TJsonObject;
    Function ZerarContagem(pInventarioId, pEnderecoId, pProdutoId: Integer) : TJsonObject;
    Function SaveContagem(pJsonArray: TJsonArray): TJsonObject;
    function GetInventario(const AParams: TDictionary<string, string>) : TJsonArray;
    Function GetPendente: TJsonArray;
    Function GetItens(Const pInventarioId: Integer): TJsonArray;
    Function GetLoteInventariado(Const AParams: TDictionary<string, string>) : TJsonArray;
    function GetInventario4D(const AParams: TDictionary<string, string>) : TJsonObject;
    Function Cancelar(Const AParams: TDictionary<string, string>): Boolean;
    Function InventarioFechar(Const AParams : TDictionary<string, string>): Boolean;
    Function Contagem(pItem: Integer): TJsonArray;
    Function Delete(pInventarioId: Integer): Boolean;
    Function InventarioCancelar(pInventarioId: Integer): TJsonArray;
    Function ApuracaoInventarioEndereco(Const AParams : TDictionary<string, string>): TJsonArray;
    Function ApuracaoInventarioProduto(Const AParams : TDictionary<string, string>): TJsonArray;
    Function LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer) : TJsonArray;
    Function GetInventarioConsultaIntegracao: TJsonArray;
    Function PutInventarioIntegracao(pInventarioId: String): TJsonArray;
    Function PutInventarioIntegracaoLote(pInventarioId: String): TJsonArray;
    Function SalvarModeloInventario(pJsonObject : TJsonObject) : TJsonArray;
    Function GetModeloInventarioLista(pModeloId : Integer) : TJsonArray;
    Function CongelarEstoqueInicial(pInventarioId, pInventarioTipo : Integer) : TJsonArray;
    Function GerarNovoInventarioModelo(pModeloId, pUsuarioId : integer; pTerminal : String) : TJsonArray;
    Function GetRelatorioAjuste(const AParams: TDictionary<string, string>) : TJsonArray;
  end;

implementation

uses Constants; //uSistemaControl,

{ TClienteDao }

function TInventarioDao.ApuracaoInventarioEndereco(const AParams : TDictionary<string, string>): TJsonArray;
Var pProcessoId: Integer;
    ErroJsonArray: TJsonArray;
var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.connection.StartTransaction;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('select inventariotipo from inventarios where inventarioid = '+AParams.Items['inventarioid']);
      Query.open;
      if Query.FieldByName('InventarioTipo').AsInteger = 1 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('update TEnd Set BloqueioInventario = 0');
         Query.SQL.Add('From Enderecamentos TEnd');
         Query.SQL.Add('inner join inventarioitens II On II.EnderecoId = TEnd.EnderecoId');
         Query.SQL.Add('Where II.inventarioid = '+AParams.Items['inventarioid']);
      End
      Else if Query.FieldByName('InventarioTipo').AsInteger = 2 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('update Prd Set BloqueioInventario = 0');
         Query.SQL.Add('From Produto Prd');
         Query.SQL.Add('inner join inventarioitens II On II.produtoid = Prd.IdProduto');
         Query.SQL.Add('Where II.inventarioid = '+AParams.Items['inventarioid']);
      End;
      Query.ExecSql;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Declare @IntegraAjusteERP Integer;');
      Query.SQL.Add('If (Select IntegrarAjusteERP From Configuracao) = 0');
      Query.SQL.Add('   Set @IntegraAjusteERP = 2');
      Query.SQL.Add('Else Set @IntegraAjusteERP = 0');
      Query.SQL.Add('Declare @InventarioId Integer = ' + AParams.Items
        ['inventarioid'] + sLineBreak +
        '-- Inserir Ajuste para Integração e Consultas Futuras' + sLineBreak +
        'Insert inventarioajuste' + sLineBreak +
        '  select @InventarioId, Ctg.enderecoid, Ctg.loteid, Ctg.Contagem, Ctg.Ajuste, @IntegraAjusteERP Status, NEWID()'
        + sLineBreak + '  From (Select Prd.CodProduto, II.enderecoid, II.loteid, '
        + sLineBreak +
        '               II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste'
        + sLineBreak + '        from InventarioInicial II' + sLineBreak +
        '        Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId'
        + sLineBreak +
        '        Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' + sLineBreak
        + '        Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
        sLineBreak +
        '        Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
        + sLineBreak + '        Where InventarioId = @InventarioId) Ctg' +
        sLineBreak + '  --Where Ajuste <> 0');

      Query.SQL.Add('--Incluir estoque de lotes inexistente');
      Query.SQL.Add
        ('Insert Into Estoque Select Ctg.loteid, Ctg.enderecoid, 4, Ctg.Contagem, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      Query.SQL.Add
        ('           (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), Null, Null, Null, Null');
      Query.SQL.Add
        ('from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste');
      Query.SQL.Add('		      from InventarioInicial II');
      Query.SQL.Add
        ('       	Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId');
      Query.SQL.Add
        ('        Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId');
      Query.SQL.Add
        ('        Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId');
      Query.SQL.Add
        ('       	Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))');
      Query.SQL.Add
        ('	       Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg');
      Query.SQL.Add
        ('Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid');
      Query.SQL.Add
        ('where Coalesce(Est.EstoqueTipoId, 0) <> 6 and (Est.EnderecoId is Null)');

      Query.SQL.Add('--Update no lotes já existentes' + sLineBreak +
        'Update Est Set Qtde = Ctg.Contagem' + sLineBreak +
        'from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste'+sLineBreak +
        '		      from InventarioInicial II' + sLineBreak +
        '	       Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId'+sLineBreak +
        '		      Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' + sLineBreak+
        '		      Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +sLineBreak +
        '		      Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'+sLineBreak +
        '		      Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg'+sLineBreak +
        'Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid'+sLineBreak +
        'where Coalesce(Est.EstoqueTipoId, 0) <> 6 and (Est.EnderecoId is Not Null)');
      Query.SQL.Add('--Registrar Ajuste no Kardex');
      {
        FConexao.Query.Sql.Add(      'Insert Into Kardex'+sLineBreak+
        '  Select 4, A.LoteId, Null, 4, A.Ajuste, A.EstoqueInicial, A.Quantidade, '+#39+'Ajuste Inventario '+#39+'+Cast(@InventarioId as Varchar),'+sLineBreak+
        '         A.EnderecoId, A.EstoqueInicial, A.Quantidade, '+#39+'Ajuste Inventario'+#39+', '+sLineBreak+
        '         (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak+
        '         (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), @Usuario, @Estacao'+sLineBreak+
        '  From ##Ajuste A');
      }

      Query.SQL.Add('Delete Est' + sLineBreak +
        'from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste'+sLineBreak +
        '		      from InventarioInicial II' + sLineBreak +
        '		      Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId'+sLineBreak +
        '		      Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' + sLineBreak+
        '		      Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +sLineBreak +
        '		      Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'+sLineBreak +
        '		      Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg'+sLineBreak +
        'Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid'+sLineBreak +
        'where Qtde = 0');
      // Apagar Estoque existente e não contado
      Query.SQL.Add('If (Select InventarioTipo From Inventarios Where InventarioId = @InventarioId) = 1 begin');
      Query.SQL.Add('	  Insert Into InventarioAjuste ');
      Query.SQL.Add('           Select @InventarioId, Est.enderecoId, Est.LoteId, @IntegraAjusteERP, Est.Qtde*-1, 0, NewId()');
      Query.SQL.Add('	          from Estoque Est');
      Query.SQL.Add('	          inner Join (Select EnderecoId');
      Query.SQL.Add('			                    From InventarioInicial');
      Query.SQL.Add('			                    Where InventarioId = @InventarioId');
      Query.SQL.Add('			                    Group By Enderecoid)  IE On IE.EnderecoId = Est.EnderecoId');
      Query.SQL.Add('	          Left Join InventarioInicial II On II.EnderecoId = Est.EnderecoId and II.Loteid = Est.LoteId');
      Query.SQL.Add('	          Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
      Query.SQL.Add('');
      Query.SQL.Add('	Delete Est');
      Query.SQL.Add('	from Estoque Est');
      Query.SQL.Add('	inner Join (Select EnderecoId');
      Query.SQL.Add('			   From InventarioInicial');
      Query.SQL.Add('			   Where InventarioId = @InventarioId');
      Query.SQL.Add('			   Group By Enderecoid)  IE On IE.EnderecoId = Est.EnderecoId');
      Query.SQL.Add('	Left Join InventarioInicial II On II.EnderecoId = Est.EnderecoId and II.Loteid = Est.LoteId');
      Query.SQL.Add('	Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
      Query.SQL.Add('End');
      Query.SQL.Add('Else Begin');
      Query.SQL.Add('  Insert Into InventarioAjuste Select @InventarioId, Est.enderecoId, Est.LoteId, @IntegraAjusteERP, Est.Qtde*-1, 0, NewId()');
      Query.SQL.Add('  from Estoque Est');
      Query.SQL.Add('  Inner Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
      Query.SQL.Add('  inner Join (Select ProdutoId');
      Query.SQL.Add('		      From InventarioInicial');
      Query.SQL.Add('			  Where InventarioId = @InventarioId');
      Query.SQL.Add('	  	      Group By Produtoid)  IE On IE.ProdutoId = Pl.ProdutoId');
      Query.SQL.Add('  Left Join InventarioInicial II On II.ProdutoId = Pl.ProdutoId');
      Query.SQL.Add('            and II.Loteid = Est.LoteId');
      Query.SQL.Add('			and II.EnderecoId = Est.EnderecoId');
      Query.SQL.Add('  Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
      Query.SQL.Add('');
      Query.SQL.Add('  Delete Est');
      Query.SQL.Add('  from Estoque Est');
      Query.SQL.Add('  Inner Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
      Query.SQL.Add('  inner Join (Select ProdutoId');
      Query.SQL.Add('		      From InventarioInicial');
      Query.SQL.Add('			  Where InventarioId = @InventarioId');
      Query.SQL.Add('	  	      Group By Produtoid)  IE On IE.ProdutoId = Pl.ProdutoId');
      Query.SQL.Add('  Left Join InventarioInicial II On II.ProdutoId = Pl.ProdutoId');
      Query.SQL.Add('            and II.Loteid = Est.LoteId');
      Query.SQL.Add('			and II.EnderecoId = Est.EnderecoId');
      Query.SQL.Add('  Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
      Query.SQL.Add('End;');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ApuracaoInventario.Sql');
      Query.ExecSQL;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 +
                             'Inventario - Finalizado' + #39);
      Query.Open();
      pProcessoId := Query.FieldByName('ProcessoId').AsInteger;
      // Realizar Apuração de acordo com
      // v1/inventario/loteinventariado?inventarioid=XXX
      Query.Close;
      Query.SQL.Clear;
      // FConexao.Query.Sql.Add(TuEvolutConst.SqlInventarioFechar);
      // FConexao.Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'].ToInteger();
      // FConexao.Query.ParamByName('pEstacao').Value   := AParams.Items['terminal'];
      // FConexao.Query.ParamByName('pUsuario').value  := AParams.Items['usuarioid'];
      Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios');
      Query.SQL.Add(' where InventarioId = ' + AParams.Items['inventarioid'] + ')');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      Query.ParamByName('pTerminal').Value   := AParams.Items['terminal'];
      Query.ParamByName('pProcessoId').Value := pProcessoId;
      Query.ParamByName('pUsuarioId').Value  := AParams.Items['usuarioid'];
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('ApuracaoInventarioFinalizar.Sql');
      Query.ExecSQL;
      Query.connection.Commit;
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Apuração de resultado concluída!'));
    Except ON E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Tabela: ApuraçãoInventario(Fechar) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.ApuracaoInventarioProduto(const AParams
  : TDictionary<string, string>): TJsonArray;
begin

end;

function TInventarioDao.Cancelar(Const AParams
  : TDictionary<string, string>): Boolean;
var pProcessoId: Integer;
var Query : TFdQuery;
    vSql: String;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.connection.StartTransaction;
      Query.connection.TxOptions.Isolation := xiReadCommitted;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('select inventariotipo from inventarios where inventarioid = '+AParams.Items['inventarioid']);
      Query.open;
      if Query.FieldByName('InventarioTipo').AsInteger = 1 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('update TEnd Set BloqueioInventario = 0');
         Query.SQL.Add('From Enderecamentos TEnd');
         Query.SQL.Add('inner join inventarioitens II On II.EnderecoId = TEnd.EnderecoId');
         Query.SQL.Add('Where II.inventarioid = '+AParams.Items['inventarioid']);
      End
      Else if Query.FieldByName('InventarioTipo').AsInteger = 2 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('update Prd Set BloqueioInventario = 0');
         Query.SQL.Add('From Produto Prd');
         Query.SQL.Add('inner join inventarioitens II On II.produtoid = Prd.IdProduto');
         Query.SQL.Add('Where II.inventarioid = '+AParams.Items['inventarioid']);
      End;
      Query.ExecSql;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 + 'inventario - Cancelado' + #39);
      Query.Open();
      pProcessoId := Query.FieldByName('ProcessoId').AsInteger;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlInventarioCancelar);
      Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'].ToInteger();
      Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where ' + 'InventarioId = ' + AParams.Items['inventarioid'] + ')');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      Query.ParamByName('pTerminal').Value := AParams.Items['terminal'];
      Query.ParamByName('pProcessoId').Value := pProcessoId;
      Query.ParamByName('pUsuarioId').Value := AParams.Items['usuarioid'];
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('InventarioCancelar.Sql');
      Query.ExecSQL;
      Result := True;
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Tabela: Inventarios(Cancelar) - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.CongelarEstoqueInicial(pInventarioId, pInventarioTipo : Integer): TJsonArray;
var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      If pInventarioId < 0 then
         Raise  Exception.Create('Id de Inventário inválido!!!');
      Query.SQL.Add('If Not Exists (Select InventarioId From inventarioinicial where inventarioid = '+pInventarioId.ToString+') Begin');
      Query.SQL.Add('   Insert Into InventarioInicial');
      If pInventarioTipo = 1 then Begin
         Query.SQL.Add('   select II.InventarioId, II.enderecoid, ');
         Query.SQL.Add('          Est.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
      End
      Else Begin
         Query.SQL.Add('   select II.InventarioId, Est.enderecoid, ');
         Query.SQL.Add('          II.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
      End;
      Query.SQL.Add('          Coalesce(Est.QtdeProducao, 0) EstoqueInicial, ' + #39 + 'I' + #39+' Status, 1 as Automatico');
      Query.SQL.Add('   from inventarioitens II');
      If pInventarioTipo = 1  then
         Query.SQL.Add('   Left Join vestoque Est on Est.EnderecoId = II.enderecoid')
      Else
         Query.SQL.Add('   Left Join vestoque Est on Est.ProdutoId = II.Produtoid');
      Query.SQL.Add('   where II.inventarioid = ' + pInventarioId.ToString());
      If pInventarioTipo = 2 then
         Query.SQL.Add('     And (Est.ZonaId Is Null Or Est.ZonaID > 3)');
      Query.SQL.Add('End;');
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('InventarioInicial.Sql');
      Query.ExecSQL;
      Result := Query.ToJSONArray;
      Query.Close;
      Query.Sql.Clear;
      If pInventarioTipo = 1  then Begin
         Query.Sql.Add('Update TEnd');
         Query.SQL.Add('  Set BloqueioInventario = 1');
         Query.Sql.Add('From InventarioInicial II');
         Query.Sql.Add('Inner Join Enderecamentos TEnd ON TEnd.EnderecoId = II.EnderecoId');
         Query.Sql.Add('Where InventarioId = '+pInventarioId.ToString());
      End
      Else Begin
         Query.Sql.Add('Update Prd');
         Query.SQL.Add('  Set BloqueioInventario = 1');
         Query.Sql.Add('From InventarioInicial II');
         Query.Sql.Add('Inner Join Produto Prd ON Prd.IdProduto = II.ProdutoId');
         Query.Sql.Add('Where InventarioId = '+pInventarioId.ToString());
      End;
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Sucesso na criação!'));
    Except On E: Exception do
      raise Exception.Create('Processo: CongelarEstoqueInicial - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.GerarNovoInventarioModelo(pModeloId, pUsuarioId : integer; pTerminal : String): TJsonArray;
Var QyrInventarioModelo, QryInventarioNovo, QryEnderecoModelo : TFdQuery;
    vInventarioIdNovo : Integer;
begin
  QyrInventarioModelo := TFDQuery.Create(nil);
  QryInventarioNovo   := TFdQuery.Create(Nil);
  QryEnderecoModelo   := TFdQuery.Create(Nil);
  Try
    QryInventarioNovo.Connection := Connection;
    QryInventarioNovo.Connection := Connection;
    QryEnderecoModelo.Connection := Connection;
    Try
      //Abrir Transacao
      QyrInventarioModelo.SQL.Add('Select * from inventarioModelo where modeloid = '+pModeloId.ToString());
      QyrInventarioModelo.Open();
      //Cria o Novo Invnentario

      QryInventarioNovo.Sql.Add('Declare @uuid UNIQUEIDENTIFIER = NewId()');
      QryInventarioNovo.Sql.Add('Insert Into Inventarios (inventariotipo, motivo, dataliberacao, tipoajuste, status, uuid) ');
      QryInventarioNovo.Sql.Add('       OUTPUT Inserted.InventarioId Values (');
      QryInventarioNovo.Sql.Add('   1, '+#39+'Inventário Rotativo, criado pelo modelo: '+pModeloId.ToString()+#39+', ');
      QryInventarioNovo.Sql.Add('   Null, 1, 1, @uuid)');
      QryInventarioNovo.Open;
      vInventarioIdNovo := QryInventarioNovo.FieldByName('InventarioId').AsInteger;

      QryEnderecoModelo.Sql.Add('Declare @EstruturaId Integer         = :pEstruturaId');
      QryEnderecoModelo.Sql.Add('Declare @ZonaId      Integer         = :pZonaId');
      QryEnderecoModelo.Sql.Add('Declare @EnderecoInicial Varchar(11) = :pEnderecoInicial');
      QryEnderecoModelo.Sql.Add('Declare @EnderecoFinal Varchar(11)   = :pEnderecoFinal');
      QryEnderecoModelo.Sql.Add('Declare @RuaInicial Varchar(2)       = :pRuaInicial');
      QryEnderecoModelo.Sql.Add('Declare @RuaFinal Varchar(2)         = :pRuaFinal');
      QryEnderecoModelo.Sql.Add('Declare @RuaPar Integer              = :pRuaPar');
      QryEnderecoModelo.Sql.Add('Declare @RuaImpar Integer            = :pRuaImpar');
      QryEnderecoModelo.Sql.Add('Declare @PredioInicial Varchar(2)    = :pPredioInicial');
      QryEnderecoModelo.Sql.Add('Declare @PredioFinal Varchar(2)      = :pPredioFinal');
      QryEnderecoModelo.Sql.Add('Declare @PredioPar Integer           = :pPredioPar');
      QryEnderecoModelo.Sql.Add('Declare @PredioImpar Integer         = :pPredioImpar');
      QryEnderecoModelo.Sql.Add('Declare @NivelInicial Varchar(2)     = :pNivelInicial');
      QryEnderecoModelo.Sql.Add('Declare @NivelFinal Varchar(2)       = :pNivelFinal');
      QryEnderecoModelo.Sql.Add('Declare @NivelPar Integer            = :pNivelPar');
      QryEnderecoModelo.Sql.Add('Declare @NivelImpar Integer          = :pNivelImpar');
      QryEnderecoModelo.Sql.Add('Declare @AptoInicial Varchar(3)      = :pAptoInicial');
      QryEnderecoModelo.Sql.Add('Declare @AptoFinal Varchar(3)        = :pAptoFinal');
      QryEnderecoModelo.Sql.Add('Declare @AptoPar Integer             = :pAptoPar');
      QryEnderecoModelo.Sql.Add('Declare @AptoImpar Integer           = :pAptoImpar');
      QryEnderecoModelo.Sql.Add('');
      QryEnderecoModelo.Sql.Add('Insert Into InventarioItens');
      QryEnderecoModelo.Sql.Add('Select '+vInventarioIdNovo.ToString()+', TEnd.EnderecoId, Null');
      QryEnderecoModelo.Sql.Add('From Enderecamentos TEnd');
      QryEnderecoModelo.Sql.Add('Join EnderecamentoZonas Z On Z.ZonaId = TEnd.ZonaId');
      QryEnderecoModelo.Sql.Add('  ');
      QryEnderecoModelo.Sql.Add('where (@EstruturaId = 0 or @EstruturaId = TEnd.EstruturaId)');
      QryEnderecoModelo.Sql.Add('  And (@ZonaId = 0 or TEnd.ZonaID = @ZonaId)');
      QryEnderecoModelo.Sql.Add('  And (@EnderecoInicial = '+#39+#39+' or SubString(TEnd.Descricao, 1, Len(@EnderecoInicial)) >= @EnderecoInicial)');
      QryEnderecoModelo.Sql.Add('  And (@EnderecoFinal = '+#39+#39+' or SubString(TEnd.Descricao, 1, Len(@EnderecoFinal)) <= @EnderecoFinal)');
      QryEnderecoModelo.Sql.Add('  And (@RuaInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) >= @RuaInicial)');
      QryEnderecoModelo.Sql.Add('  And (@RuaFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) <= @RuaFinal)');
      QryEnderecoModelo.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) % 2 = 0) and @Ruapar = 1) or');
      QryEnderecoModelo.SQL.Add('       (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 1, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 1, 2)) ELSE 0 END) % 2 = 1) and @RuaImpar = 1) )');
      QryEnderecoModelo.Sql.Add('');
      QryEnderecoModelo.Sql.Add('  And (@PredioInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) >= @PredioInicial)');
      QryEnderecoModelo.Sql.Add('  And (@PredioFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) <= @PredioFinal)');
      QryEnderecoModelo.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) % 2 = 0) and @Prediopar = 1) or');
      QryEnderecoModelo.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 3, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 3, 2)) ELSE 0 END) % 2 = 1) and @PredioImpar = 1) )');
      QryEnderecoModelo.Sql.Add('');
      QryEnderecoModelo.Sql.Add('  And (@NivelInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) >= @NivelInicial)');
      QryEnderecoModelo.Sql.Add('  And (@NivelFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) <= @NivelFinal)');
      QryEnderecoModelo.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) % 2 = 0) and @Nivelpar = 1) or');
      QryEnderecoModelo.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 5, 2)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 5, 2)) ELSE 0 END) % 2 = 1) and @NivelImpar = 1 ) )');
      QryEnderecoModelo.Sql.Add('');
      QryEnderecoModelo.Sql.Add('  And (@AptoInicial='+#39+#39+' or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) >= @AptoInicial)');
      QryEnderecoModelo.Sql.Add('  And (@AptoFinal='+#39+#39+'   or (CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) <= @AptoFinal)');
      QryEnderecoModelo.SQL.Add('  And ((((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) % 2 = 0) and @Aptopar = 1) or');
      QryEnderecoModelo.SQL.Add('      (((CASE WHEN (ISNUMERIC(SUBSTRING(TEnd.Descricao, 7, 3)) = 1) THEN CONVERT(INT, SUBSTRING(TEnd.Descricao, 7, 3)) ELSE 0 END) % 2 = 1) and @AptoImpar = 1) ) ');
      QryEnderecoModelo.Sql.Add('  --And (IsNull(TEnd.Status, 0) = 1 and IsNull(TEnd.Bloqueado, 0) = 0)');
      QryEnderecoModelo.Sql.Add('Order by TEnd.Descricao');
      QryEnderecoModelo.ParamByName('pEstruturaId').Value     := QyrInventarioModelo.FieldByName('estruturaid').AsInteger;
      QryEnderecoModelo.ParamByName('pZonaId').Value          := QyrInventarioModelo.FieldByName('zonaid').AsInteger;
      QryEnderecoModelo.ParamByName('pEnderecoInicial').Value := QyrInventarioModelo.FieldByName('enderecoinicial').AsString;
      QryEnderecoModelo.ParamByName('pEnderecoFinal').Value   := QyrInventarioModelo.FieldByName('enderecofinal').AsString;
      QryEnderecoModelo.ParamByName('pRuaInicial').Value      := StrToIntDef(QyrInventarioModelo.FieldByName('ruainicial').AsString, 0);
      QryEnderecoModelo.ParamByName('pRuaFinal').Value        := StrToIntDef(QyrInventarioModelo.FieldByName('ruafinal').AsString, 99);
      QryEnderecoModelo.ParamByName('pRuaPar').Value          := QyrInventarioModelo.FieldByName('ruapar').AsInteger;
      QryEnderecoModelo.ParamByName('pRuaImpar').Value        := QyrInventarioModelo.FieldByName('ruaimpar').AsInteger;
      QryEnderecoModelo.ParamByName('pPredioInicial').Value   := StrToIntDef(QyrInventarioModelo.FieldByName('predioinicial').AsString, 0);
      QryEnderecoModelo.ParamByName('pPredioFinal').Value     := StrToIntDef(QyrInventarioModelo.FieldByName('prediofinal').AsString, 99);
      QryEnderecoModelo.ParamByName('pPredioPar').Value       := QyrInventarioModelo.FieldByName('prediopar').AsInteger;
      QryEnderecoModelo.ParamByName('pPredioImpar').Value     := QyrInventarioModelo.FieldByName('predioimpar').AsInteger;
      QryEnderecoModelo.ParamByName('pNivelInicial').Value    := StrToIntDef(QyrInventarioModelo.FieldByName('nivelinicial').AsString, 0);
      QryEnderecoModelo.ParamByName('pNivelFinal').Value      := StrToIntDef(QyrInventarioModelo.FieldByName('nivelfinal').AsString, 99);
      QryEnderecoModelo.ParamByName('pNivelPar').Value        := QyrInventarioModelo.FieldByName('nivelpar').AsInteger;
      QryEnderecoModelo.ParamByName('pNivelImpar').Value      := QyrInventarioModelo.FieldByName('nivelimpar').AsInteger;
      QryEnderecoModelo.ParamByName('pAptoInicial').Value     := StrToIntDef(QyrInventarioModelo.FieldByName('aptoinicial').AsString, 0);
      QryEnderecoModelo.ParamByName('pAptoFinal').Value       := StrToIntDef(QyrInventarioModelo.FieldByName('aptofinal').AsString, 999);
      QryEnderecoModelo.ParamByName('pAptoPar').Value         := QyrInventarioModelo.FieldByName('aptopar').AsInteger;
      QryEnderecoModelo.ParamByName('pAptoImpar').Value       := QyrInventarioModelo.FieldByName('aptoimpar').AsInteger;
      If DebugHook <> 0 then
         QryEnderecoModelo.SQL.SaveToFile('GerarNovoInventarioModelo'+pModeloId.ToString()+'.Sql');
      QryEnderecoModelo.eXecSql;
      QryInventarioNovo.Close;
      QryInventarioNovo.SQL.Clear;
      QryInventarioNovo.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where '+'InventarioId = ' + vInventarioIdNovo.ToString() + ')');
      QryInventarioNovo.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      QryInventarioNovo.ParamByName('pTerminal').Value := pTerminal;
      QryInventarioNovo.ParamByName('pProcessoId').Value := 123;
      QryInventarioNovo.ParamByName('pUsuarioId').Value := pUsuarioid;
      QryInventarioNovo.ExecSQL;
      Result :=TJSONArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Sucesso na criação do inventário: '+vInventarioIdNovo.ToString()));
    Except On E: Exception do
      raise Exception.Create(TUtil.TratarExcessao(E.Message));
    End;
  Finally
    QyrInventarioModelo.Free;
    QryInventarioNovo.Free;
    QryEnderecoModelo.Free;
  End;
end;

function TInventarioDao.Contagem(pItem: Integer): TJsonArray;
var
  vParamOk: Integer;
  vProcessoId: Integer;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetContagemLote);
      Query.ParamByName('pItem').Value := pItem;
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: InventarioContagem'+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

constructor TInventarioDao.Create;
begin
  ObjInventarioDAO := TInventario.Create;
  inherited;
end;

function TInventarioDao.Delete(pInventarioId: Integer): Boolean;
var vSql: String;
  Query : TFdQuery;
begin
  Result:= False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('select inventariotipo from inventarios where inventarioid = '+pInventarioId.ToString);
      Query.open;
      if Query.FieldByName('InventarioTipo').AsInteger = 1 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('update TEnd Set BloqueioInventario = 0');
         Query.SQL.Add('From Enderecamentos TEnd');
         Query.SQL.Add('inner join inventarioitens II On II.EnderecoId = TEnd.EnderecoId');
         Query.SQL.Add('Where II.inventarioid = '+pInventarioId.ToString);
      End
      Else if Query.FieldByName('InventarioTipo').AsInteger = 2 then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('update Prd Set BloqueioInventario = 0');
         Query.SQL.Add('From Produto Prd');
         Query.SQL.Add('inner join inventarioitens II On II.produtoid = Prd.IdProduto');
         Query.SQL.Add('Where II.inventarioid = '+pInventarioId.ToString);
      End;
      Query.ExecSql;
      Query.Close;
      Query.SQL.Clear;
      vSql := 'Delete from Inventarios where InventarioId = '+pInventarioId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: InventarioDelete - ' + TUtil.TratarExcessao(E.Message) );
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TInventarioDao.Destroy;
begin
  ObjInventarioDAO.Free;
  inherited;
end;

function TInventarioDao.InventarioCancelar(pInventarioId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Update Inventario Set ProcessoId = (Select ProcessoId from Processo ');
      Query.SQL.Add('Where Descricao = '+QuotedStr('Inventario - Cancelar')+') Where InventarioId = :InventarioId');
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Inventario', TJsonNumber.Create(Query.FieldByName('InventarioId').AsInteger)));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: InventariosCancelar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.InventarioFechar(const AParams : TDictionary<string, string>): Boolean;
var pProcessoId: Integer;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.connection.StartTransaction;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add
        ('Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 +
        'Inventario - Finalizado' + #39);
      Query.Open();
      pProcessoId := Query.FieldByName('ProcessoId').AsInteger;
      // Realizar Apuração de acordo com
      // v1/inventario/loteinventariado?inventarioid=XXX
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlInventarioFechar);
      Query.ParamByName('pInventarioId').Value :=
        AParams.Items['inventarioid'].ToInteger();
      Query.ParamByName('pEstacao').Value := AParams.Items['terminal'];
      Query.ParamByName('pUsuario').Value := AParams.Items['usuarioid'];
      Query.SQL.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where ' +
        'InventarioId = ' + AParams.Items['inventarioid'] + ')');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      Query.ParamByName('pTerminal').Value := AParams.Items['terminal'];
      Query.ParamByName('pProcessoId').Value := pProcessoId;
      Query.ParamByName('pUsuarioId').Value :=
        AParams.Items['usuarioid'];
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('InventarioFechar.Sql');
      Query.ExecSQL;
      Result := True;
      Query.connection.Commit;
    Except ON E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Tabela: Inventario Apuração(Fechar) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.LimparContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
  Result := TJsonArray.Create;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlLimparContagem);
      Query.ParamByName('pInventarioId').Value := pInventarioId;
      Query.ParamByName('pEnderecoId').Value := pEnderecoId;
      Query.ParamByName('pProdutoId').Value := pProdutoId;
      Query.SQL.Add('-- ' + pInventarioId.ToString);
      Query.SQL.Add('-- ' + pEnderecoId.ToString);
      Query.SQL.Add('-- ' + pProdutoId.ToString);
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('LimparContagem' + pInventarioId.ToString+'_' + pEnderecoId.ToString + '_' + pProdutoId.ToString + '.Sql');
      Query.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('ok', 'Endereço zerado com sucesso'));
    Except On E: Exception do
      Begin
        Raise Exception.Create('Tabela: LimparContagem - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.PutInventarioIntegracao(pInventarioId: String) : TJsonArray;
var vQry, vQryStatus: TFdQuery;
    ErroJsonArray: TJsonArray;
begin
  vQry       := TFDQuery.Create(nil);
  vQryStatus := TFdQuery.Create(Nil);
  Try
    vQry.Connection       := Connection;
    vQryStatus.Connection := Connection;
    Try
      vQry.connection.StartTransaction;
      vQry.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
      vQry.SQL.Add('select * from vinventarioajusteintegracao');
      vQry.SQL.Add('Where Cast(InventarioId as VarChar(36)) = @InventarioId or Cast(uuid as Varchar(36)) = @InventarioId');
      vQry.ParamByName('pInventarioId').Value := pInventarioId;
      vQry.Open();
      if DebugHook <> 0 then
         vQry.SQL.SaveToFile('InventarioIntegracaoretorno.Sql');
      vQry.Open();
      if vQry.IsEmpty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
               .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', TuEvolutConst.QrySemDados));
      End
      Else Begin
        Result := vQry.ToJSONArray;
        vQryStatus.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
        vQryStatus.SQL.Add('Update IA Set Status = 1');
        vQryStatus.SQL.Add('From InventarioAjuste IA');
        vQryStatus.SQL.Add('Inner Join Inventarios I On I.InventarioId = IA.InventarioId');
        vQryStatus.SQL.Add('Where IA.Status = 0 And (Cast(IA.InventarioId as VarChar(36)) = @InventarioId or Cast(I.uuid as Varchar(36)) = @InventarioId)');
        vQryStatus.ParamByName('pInventarioId').Value := pInventarioId;
        If DebugHook <> 0 then
           vQryStatus.SQL.SaveToFile('RegInventarioRetorno.Sql');
        vQryStatus.ExecSQL;
      End;
      vQry.connection.Commit;
    Except On E: Exception do
      Begin
        vQry.connection.Rollback;
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(TJsonObject.Create.AddPair('status', '500')
                     .AddPair('ajuste', TJsonNumber.Create(0))
                     .AddPair('mensagem', 'Processo: InventarioAjusteIntegracao - ' + TUtil.TratarExcessao(E.Message)));
      End;
    End;
  Finally
    vQry.Free;
    vQryStatus.Free;
  End;
end;

function TInventarioDao.PutInventarioIntegracaoLote(pInventarioId: String) : TJsonArray;
var vQry, vQryStatus: TFdQuery;
    ErroJsonArray: TJsonArray;
begin
  Try
    vQry       := TFdQuery.Create(Nil);
    vQryStatus := TFdQuery.Create(Nil);
    Try
      vQry.Connection       := Connection;
      vQryStatus.Connection := Connection;
      vQryStatus.connection.StartTransaction;
      vQry.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
      vQry.SQL.Add('select * from vinventarioajusteintegracaoLote where Cast(InventarioId as VarChar(36)) = @InventarioId or Cast(uuid as Varchar(36)) = @InventarioId');
      vQry.ParamByName('pInventarioId').Value := pInventarioId;
      if DebugHook <> 0 then
         vQry.SQL.SaveToFile('InventarioIntegracaoretornoLote.Sql');
      vQry.Open();
      if vQry.IsEmpty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
               .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', TuEvolutConst.QrySemDados));
      End
      Else Begin
        Result := vQry.ToJSONArray;
        vQryStatus.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
        vQryStatus.SQL.Add('Update IA Set Status = 1');
        vQryStatus.SQL.Add('From InventarioAjuste IA');
        vQryStatus.SQL.Add('Inner Join Inventarios I On I.InventarioId = IA.InventarioId');
        vQryStatus.SQL.Add('Where IA.Status = 0 And (Cast(IA.InventarioId as VarChar(36)) = @InventarioId or Cast(I.uuid as Varchar(36)) = @InventarioId)');
        vQryStatus.ParamByName('pInventarioId').Value := pInventarioId;
        If DebugHook <> 0 then
           vQryStatus.SQL.SaveToFile('RegInventarioRetorno.Sql');
        vQryStatus.ExecSQL;
      End;
      vQry.connection.Commit;
    Except On E: Exception do
      Begin
        vQry.connection.Rollback;
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(TJsonObject.Create.AddPair('status', '500')
                     .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', 'Processo: InventarioAjusteIntegracao - ' + TUtil.TratarExcessao(E.Message)));
      End;
    End;
  Finally
    vQry.Free;
    vQryStatus.Free;
  End;
end;

function TInventarioDao.SalvarModeloInventario(
  pJsonObject: TJsonObject): TJsonArray;
var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Close;
      If PJsonObject.GetValue<Integer>('modeloid', 0) = 0 then Begin
         Query.Sql.Add('Insert Into InventarioModelo (EstruturaId, ZonaId, EnderecoInicial, EnderecoFinal, RuaInicial, RuaFinal, RuaPar, RuaImpar,');
         Query.SQL.Add('                              PredioInicial, PredioFinal, PredioPar, PredioImpar,');
         Query.SQL.Add('                              NivelInicial, NivelFinal, NivelPar, NivelImpar, AptoInicial, AptoFinal, AptoPar, AptoImpar,');
         Query.SQL.Add('                              Usuarioid, Terminal, DtCriacao) Values (:estruturaid, :zonaid, :enderecoinicial, :enderecofinal, ');
         Query.SQL.Add('                              :RuaInicial, :RuaFinal, :RuaPar, :RuaImpar, :PredioInicial, :PredioFinal, :PredioPar, :PredioImpar,');
         Query.SQL.Add('                              :NivelInicial, :NivelFinal, :NivelPar, :NivelImpar, :AptoInicial, :AptoFinal, :AptoPar, :AptoImpar,');
         Query.SQL.Add('                              :Usuarioid, :Terminal, :Data)');
      End
      Else Begin
        Query.SQL.Add('Update InventarioModelo Set');
        Query.SQL.Add('  EstruturaId     = :EstruturaId,');
        Query.SQL.Add('  Zonaid          = :ZonaId,');
        Query.SQL.Add('  EnderecoInicial = :EnderecoInicial,');
        Query.SQL.Add('  EnderecoFinal   = :EnderecoFinal,');
        Query.SQL.Add('  RuaInicial      = :RuaInicial,');
        Query.SQL.Add('  RuaFinal        = :RuaFinal,');
        Query.SQL.Add('  RuaPar          = :RuaPar,');
        Query.SQL.Add('  RuaImpar        = :RuaImpar,');
        Query.SQL.Add('  PredioInicial   = :PredioInicial,');
        Query.SQL.Add('  PredioFinal     = :PredioFinal,');
        Query.SQL.Add('  PredioPar       = :PredioPar,');
        Query.SQL.Add('  PredioImpar     = :PredioImpar,');
        Query.SQL.Add('  NivelInicial    = :NivelInicial,');
        Query.SQL.Add('  NivelFinal      = :NivelFinal,');
        Query.SQL.Add('  NivelPar        = :NivelPar,');
        Query.SQL.Add('  NivelImpar      = :NivelImpar,');
        Query.SQL.Add('  AptoInicial     = :AptoInicial,');
        Query.SQL.Add('  AptoFinal       = :AptoFinal,');
        Query.SQL.Add('  AptoPar         = :AptoPar,');
        Query.SQL.Add('  AptoImpar       = :AptoImpar,');
        Query.SQL.Add('  UsuarioId       = :UsuarioId,');
        Query.SQL.Add('  Terminal        = :Terminal,');
        Query.Sql.Add('  DtAlteracao     = :Data');
        Query.SQL.Add('Where ModeloId = :ModeloId');
        Query.ParamByName('ModeloId').Value := pJsonObject.GetValue<Integer>('modeloid');
      End;
      Query.ParamByName('EstruturaId').Value     := pJsonObject.GetValue<String>('estruturaid');
      Query.ParamByName('ZonaId').Value          := pJsonObject.GetValue<String>('zonaid');
      Query.ParamByName('EnderecoInicial').Value := pJsonObject.GetValue<String>('enderecoinicial');
      Query.ParamByName('Enderecofinal').Value   := pJsonObject.GetValue<String>('enderecofinal');
      Query.ParamByName('Ruainicial').Value      := pJsonObject.GetValue<String>('ruainicial');
      Query.ParamByName('Ruafinal').Value        := pJsonObject.GetValue<String>('ruafinal');
      Query.ParamByName('Ruapar').Value          := pJsonObject.GetValue<String>('ruapar');
      Query.ParamByName('Ruaimpar').Value        := pJsonObject.GetValue<String>('ruaimpar');
      Query.ParamByName('Predioinicial').Value   := pJsonObject.GetValue<String>('predioinicial');
      Query.ParamByName('Prediofinal').Value     := pJsonObject.GetValue<String>('prediofinal');
      Query.ParamByName('Prediopar').Value       := pJsonObject.GetValue<String>('prediopar');
      Query.ParamByName('Predioimpar').Value     := pJsonObject.GetValue<String>('predioimpar');
      Query.ParamByName('Nivelinicial').Value    := pJsonObject.GetValue<String>('nivelinicial');
      Query.ParamByName('Nivelfinal').Value      := pJsonObject.GetValue<String>('nivelfinal');
      Query.ParamByName('Nivelpar').Value        := pJsonObject.GetValue<String>('nivelpar');
      Query.ParamByName('Nivelimpar').Value      := pJsonObject.GetValue<String>('nivelimpar');
      Query.ParamByName('Aptoinicial').Value     := pJsonObject.GetValue<String>('aptoinicial');
      Query.ParamByName('Aptofinal').Value       := pJsonObject.GetValue<String>('aptofinal');
      Query.ParamByName('Aptopar').Value         := pJsonObject.GetValue<String>('aptopar');
      Query.ParamByName('Aptoimpar').Value       := pJsonObject.GetValue<String>('aptoimpar');
      Query.ParamByName('Usuarioid').Value       := pJsonObject.GetValue<String>('usuarioid');
      Query.ParamByName('Terminal').Value        := pJsonObject.GetValue<String>('terminal');
      Query.ParamByName('Data').Value            := FormatDateTime('YYYY-MM-DD', Date());
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('SalvarModeloInventario.Sql');
      Query.ExecSql;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Modelo Salvo com sucesso!'));
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: SalvarModeloInventario - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.SaveContagem(pJsonArray: TJsonArray): TJsonObject;
Var
  xItemContagem: Integer;
  vErro: Boolean;
  vErroMens: String;
  vInventarioId: Integer;
  vProcessoId: Integer;
  vUsuarioId: Integer;
  vEstacao: String;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    Query.connection.TxOptions.Isolation := xiReadCommitted;
    Query.SQL.Add(TuEvolutConst.SqlSaveContagem);
    vErro             := False;
    vInventarioId     := pJsonArray.Items[0].GetValue<Integer>('inventarioid');
    vUsuarioId        := pJsonArray.Items[0].GetValue<Integer>('usuarioid');
    vEstacao          := pJsonArray.Items[0].GetValue<String>('estacao');
    //FConexao.Query.Sql.Add(pJsonArray.ToString);
    //FConexao.Query.SaveToFile('cont_'+pJsonArray.Items[0].GetValue<String>('inventarioid') );
    For xItemContagem := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add(TuEvolutConst.SqlSaveContagem);
        Query.ParamByName('pInventarioId').Value := pJsonArray.Items[xItemContagem].GetValue<Integer>('inventarioid');
        Query.ParamByName('pEnderecoId').Value   := pJsonArray.Items[xItemContagem].GetValue<Integer>('enderecoid');
        Query.ParamByName('ProdutoId').Value     := pJsonArray.Items[xItemContagem].GetValue<Integer>('produtoid');
        Query.ParamByName('pLoteId').Value       := pJsonArray.Items[xItemContagem].GetValue<Integer>('loteid');
        Query.ParamByName('pDescrLote').Value    := pJsonArray.Items[xItemContagem].GetValue<String>('descrlote');
        if pJsonArray.Items[xItemContagem].GetValue<String>('descrlote') = '' then Begin
           Query.ParamByName('pDtFabricacao').Value := 0;
           Query.ParamByName('pDtVencimento').Value := 0;
        End
        Else begin
           Query.ParamByName('pDtFabricacao').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(pJsonArray.Items[xItemContagem].GetValue<String>('dtfabricacao')));
           Query.ParamByName('pDtVencimento').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(pJsonArray.Items[xItemContagem].GetValue<String>('dtvencimento')));
        end;
        Query.ParamByName('pItemId').Value     := pJsonArray.Items[xItemContagem].GetValue<Integer>('itemid');
        Query.ParamByName('pQuantidade').Value := pJsonArray.Items[xItemContagem].GetValue<Integer>('quantidade');
        Query.ParamByName('pStatus').Value     := pJsonArray.Items[xItemContagem].GetValue<String>('status');
        Query.ParamByName('pUsuarioId').Value  := pJsonArray.Items[xItemContagem].GetValue<Integer>('usuarioid');
        Query.ParamByName('pEstacao').Value    := pJsonArray.Items[xItemContagem].GetValue<String>('estacao');
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('SaveContagem' + pJsonArray.Items[xItemContagem].GetValue<Integer>('inventarioid').ToString + '_'+
                                         pJsonArray.Items[xItemContagem].GetValue<Integer>('enderecoid').ToString+
                                         '_' + pJsonArray.Items[xItemContagem].GetValue<Integer>('produtoid').ToString + '_'+
                                         pJsonArray.Items[xItemContagem].GetValue<Integer>('loteid').ToString + '.Sql');
        Query.ExecSQL;
      Except On E: Exception do
        Begin
          vErro := True;
          vErroMens := E.Message;
          Query.connection.Rollback;
          Break;
        End;
      End;
      if vErro then
        Break;
    End;
    Result := TJsonObject.Create;
    if vErro then Begin
       Result.AddPair('Erro', 'Tabela: InventarioContagem - '+StringReplace( vErroMens,
                      '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))
    End
    Else
    Begin
      Try
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Select ProcessoId From ProcessoEtapas Where Descricao = ' + #39 + 'Inventario - Em Contagem' + #39);
        Query.Open;
        vProcessoId := Query.FieldByName('ProcessoId').AsInteger;
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('If (select De.Descricao ');
        Query.SQL.Add('   From Inventarios I');
        Query.SQL.Add('   Inner Join vDocumentoEtapas DE On De.Documento = I.uuid and');
        Query.SQL.Add('                                     De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
        Query.SQL.Add('   where I.InventarioId = '+vInventarioId.ToString()+') = '#39+'Inventario - Gerado'+#39);
        Query.SQL.Add('Begin');
        Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where InventarioId = '+vInventarioId.ToString() + ')');
        Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
        Query.ParamByName('pTerminal').Value := vEstacao;
        Query.ParamByName('pProcessoId').Value := vProcessoId;
        Query.ParamByName('pUsuarioId').Value := vUsuarioId;
        Query.SQL.Add('End');
        Query.ExecSQL;
        Query.connection.Commit;
        Result.AddPair('ok', 'Contagem arquivada com sucesso')
      Except
        On E: Exception do
        Begin
          Query.connection.Rollback;
          Result.AddPair('Erro', 'Tabela: InventarioContagem - '+StringReplace(vErroMens,
                         '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))
        End;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.ZerarContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonObject;
var Query : TFdQuery;
begin
  Result := TJsonObject.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlZerarEndereco);
      Query.ParamByName('pInventarioId').Value := pInventarioId;
      Query.ParamByName('pEnderecoId').Value := pEnderecoId;
      Query.ParamByName('pProdutoId').Value := pProdutoId;
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('ZerarContagem' + pInventarioId.ToString +
          '_' + pEnderecoId.ToString + '_' + pProdutoId.ToString + '.Sql');
      Query.ExecSQL;
      Result.AddPair('ok', 'Endereço zerado com sucesso')
    Except On E: Exception do
      Begin
        Raise Exception.Create('Processo: ZerarContagem - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

Function TInventarioDao.GetPendente: TJsonArray;
var
  vParamOk: Integer;
  vProcessoId: Integer;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetInventarioPendente);
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('InventarioPendente.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TJsonArray.Create();
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray;
    Except
      On E: Exception do
      Begin
        Raise Exception.Create('Processo: GetPendente - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.GetRelatorioAjuste(const AParams: TDictionary<string, string>): TJsonArray;
Var vParamOk : Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    vParamOk := 0;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetRelatorioAjuste);
      if AParams.ContainsKey('inventarioid') then begin
         Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pInventarioId').Value := 0;
      if AParams.ContainsKey('datacriacaoinicial') then begin
         Query.ParamByName('pDataCriacaoinicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datacriacaoinicial']));
         Inc(vParamOk);
      end
      Else Query.ParamByName('pdatacriacaoinicial').Value := 0;
      if AParams.ContainsKey('datacriacaofinal') then begin
         Query.ParamByName('pDataCriacaoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datacriacaofinal']));
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pDataCriacaoFinal').Value := 0;

      if AParams.ContainsKey('datafinalizacaoinicial') then begin
         Query.ParamByName('pDataFinalizacaoInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinalizacaoinicial']));
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pDataFinalizacaoInicial').Value := 0;
      if AParams.ContainsKey('datafinalizacaofinal') then begin
         Query.ParamByName('pDataFinalizacaoFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinalizacaoFinal']));
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pDataFinalizacaoFinal').Value := 0;
      //Só existe Apuração no Processo 153
//      if AParams.ContainsKey('processoid') then begin
//         Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'];
//         Inc(vParamOk);
//      end
//      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if AParams.ContainsKey('inventariotipo') then begin
         Query.ParamByName('pInventarioTipo').Value := AParams.Items['inventariotipo'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pInventarioTipo').Value := 0;
         //Não existe Apuração de Inventario Pendente
//      if AParams.ContainsKey('pendente') then begin
//         Query.ParamByName('pPendente').Value := AParams.Items['pendente'];
//         Inc(vParamOk);
//      end
//      Else
         Query.ParamByName('pPendente').Value := 0;
      if AParams.ContainsKey('produtoid') then begin
         Query.ParamByName('pProdutoId').Value := AParams.Items['produtoid'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pProdutoId').Value := 0;

      If DebugHook <> 0 then
         Query.SQL.SaveToFile('RelatorioAjuste.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except On E: Exception do
      Raise Exception.Create('Processo: GetRelatorioAjuste - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.GetInventario(Const AParams : TDictionary<string, string>): TJsonArray;
var vParamOk: Integer;
    vProcessoId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Connection.ResourceOptions.CmdExecTimeout := 120000;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetInventario);
      vParamOk := 0;
      if AParams.ContainsKey('inventarioid') then begin
         Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pInventarioId').Value := 0;
      if AParams.ContainsKey('datacriacao') then begin
         Query.ParamByName('pDataCriacao').Value := AParams.Items['datacriacao'];
         Inc(vParamOk);
      end
      Else Query.ParamByName('pDataCriacao').Value := 0;
      if AParams.ContainsKey('datacriacaofinal') then begin
         Query.ParamByName('pDataCriacaoFinal').Value := AParams.Items['datacriacaofinal'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pDataCriacaoFinal').Value := 0;
      if AParams.ContainsKey('datafinalizacao') then begin
         Query.ParamByName('pDataFinalizacao').Value := AParams.Items['datafinalizacao'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pDataFinalizacao').Value := 0;
      if AParams.ContainsKey('datacancelamento') then begin
         Query.ParamByName('pDataCancelamento').Value := AParams.Items['datacancelamento'];
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pDataCancelamento').Value := 0;
      if AParams.ContainsKey('processoid') then begin
         Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pProcessoId').Value := 0;
      if AParams.ContainsKey('tipo') then begin
         Query.ParamByName('pTipo').Value := AParams.Items['tipo'].ToInteger();
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pTipo').Value := 0;
      if AParams.ContainsKey('pendente') then begin
         Query.ParamByName('pPendente').Value := (AParams.Items['pendente'].ToInteger());
         //FConexao.Query.SQL.Add('and (De.ProcessoId in (123, 133))');
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pPendente').Value := 0;
      if AParams.ContainsKey('produtoid') then begin
         Query.ParamByName('pProdutoId').Value := AParams.Items['produtoid'].ToInteger();
         Inc(vParamOk);
      end
      Else
         Query.ParamByName('pProdutoId').Value := 0;
      if vParamOk <> AParams.Count then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'))
      Else
      begin
        If DebugHook <> 0 Then
           Query.SQL.SaveToFile('Inventario.Sql');
        Query.Open();
        if Query.IsEmpty then Begin
           Result := TJsonArray.Create();
           Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
        End
        Else
           Result := Query.ToJSONArray;
      end;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: GetInventario - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

Function TInventarioDao.GetInventario4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var QryPesquisa, QryRecordCount: TFdQuery;
    vParamOk: Integer;
begin
  Try
    QryPesquisa    := TFdQuery.Create(nil);
    QryRecordCount := TFdQuery.Create(Nil);
    Try
      QryPesquisa.Connection    := Connection;
      QryRecordCount.Connection := Connection;
      QryPesquisa.SQL.Add(TuEvolutConst.SqlGetInventario);
      QryRecordCount.SQL.Add(TuEvolutConst.SqlGetInventario);
      vParamOk := 0;
      if AParams.ContainsKey('inventarioid') then begin
         QryPesquisa.SQL.Add('and InventarioId = :pInventarioId');
         QryPesquisa.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'];
         QryRecordCount.SQL.Add('and InventarioId = :pInventarioId');
         QryRecordCount.ParamByName('pInventarioId').AsString := AParams.Items['inventarioid'];
         Inc(vParamOk);
      end;
      if AParams.ContainsKey('datacriacao') then begin
         QryPesquisa.SQL.Add('and datacriacao = :pDataCriacao');
         QryPesquisa.ParamByName('pDataCriacao').Value := AParams.Items['datacriacao'];
         QryRecordCount.SQL.Add('and datacriacao = :pDataCriacao');
         QryRecordCount.ParamByName('pDataCriacao').AsString := AParams.Items['datacriacao'];
      end;
      if AParams.ContainsKey('datafinalizacao') then begin
         QryPesquisa.SQL.Add('and datafinalizacao = :pDataFinalizacao');
         QryPesquisa.ParamByName('pDataFinalizacao').Value := AParams.Items['datafinalizacao'];
         QryRecordCount.SQL.Add('and datafinalizacao = :pDataFinalizacao');
         QryRecordCount.ParamByName('pDataFinalizacao').AsString := AParams.Items['datafinalizacao'];
      end;
      if AParams.ContainsKey('datacancelamento') then begin
         QryPesquisa.SQL.Add('and DataCancelamento = :pDataCancelamento');
         QryPesquisa.ParamByName('pDataCancelamento').Value := AParams.Items['datacancelamento'];
         QryRecordCount.SQL.Add('and datacancelamento = :pDataCancelamento');
         QryRecordCount.ParamByName('pDataCancelamento').AsString := AParams.Items['datacancelamento'];
      end;
      if AParams.ContainsKey('processoid') then begin
         QryPesquisa.SQL.Add('and ProcessoId = :pProcessoId');
         QryPesquisa.ParamByName('pProcessoId').Value := AParams.ContainsKey('datacancelamento').ToInteger();
         QryRecordCount.SQL.Add('and processoid = :pProcessoId');
         QryRecordCount.ParamByName('pProcessoId').AsString := AParams.Items['processoid'];
      end;
      QryPesquisa.SQL.Add('order by InventarioId');
      QryPesquisa.Open();
      Result.AddPair('data', QryPesquisa.ToJSONArray());
      QryRecordCount.Open();
      Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
    Except On E: Exception do
      Begin
        raise Exception.Create(TUtil.TratarExcessao(E.Message));
      End
    End;
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TInventarioDao.GetInventarioConsultaIntegracao: TJsonArray;
var ErroJsonArray: TJsonArray;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('select Ia.inventarioid id, Inv.uuid, count(*) totaljuste, count(*) totalajuste');
      Query.SQL.Add('From (Select Ia.InventarioId, Ia.ProdutoId');
      Query.SQL.Add('      From InventarioAjuste IA');
      Query.SQL.Add('	    Inner Join Produto Prd On Prd.IdProduto = Ia.ProdutoId');
      Query.SQL.Add('      where Ia.status = 0');
      Query.SQL.Add('	    Group by Ia.inventarioid, Ia.ProdutoId) Ia');
      Query.SQL.Add('Inner Join Inventarios Inv on Inv.InventarioId = Ia.inventarioid');
      Query.SQL.Add('Group by Ia.inventarioid, Inv.uuid');
      Query.SQL.Add('Order by Ia.InventarioId');
      Query.Open();
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('vInventarioIntegracaoConsulta.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('status', '200')
               .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', TuEvolutConst.QrySemDados))
      End
      Else
         Result := Query.ToJSONArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: InventarioConsultaIntegração - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.GetItens(const pInventarioId: Integer): TJsonArray;
var vQry, QryPesquisa: TFdQuery;
begin
  Try
    vQry        := TFdQuery.Create(Nil);
    QryPesquisa := TFdQuery.Create(Nil);
    Try
      vQry.Connection        := Connection;
      QryPesquisa.Connection := Connection;
      vQry.SQL.Add('Select InventarioTipo From Inventarios Where InventarioId = ' + pInventarioId.ToString);
      vQry.Open();
      if vQry.FieldByName('InventarioTipo').AsInteger = 1 then
         QryPesquisa.SQL.Add(TuEvolutConst.SqlGetInventarioItensEndereco)
      Else if vQry.FieldByName('InventarioTipo').AsInteger = 2 then
         QryPesquisa.SQL.Add(TuEvolutConst.SqlGetInventarioItensProduto);
      QryPesquisa.ParamByName('pInventarioId').Value := pInventarioId;
      if DebugHook <> 0 then
         QryPesquisa.SQL.SaveToFile('InventarioItens.Sql');
      QryPesquisa.Open();
      if QryPesquisa.IsEmpty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := QryPesquisa.ToJSONArray;
    Except On E: Exception do
      Begin
        QryPesquisa.Close;
        raise Exception.Create('Processo: Inventario/GetItens'+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    vQry.Free;
    QryPesquisa.Free;
  End;
end;

function TInventarioDao.GetLoteInventariado(const AParams : TDictionary<string, string>): TJsonArray;
var vParamOk: Integer;
    vProcessoId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      vParamOk := 0;
      if AParams.ContainsKey('tipo') then Begin
         If AParams.Items['tipo'] = '2' then
           Query.SQL.Add(TuEvolutConst.SqlGetLoteInventarioPorProduto)
         Else
           Query.SQL.Add(TuEvolutConst.SqlGetLoteInventario);
         Inc(vParamOk);
      End
      Else
         Query.SQL.Add(TuEvolutConst.SqlGetLoteInventario);
      if AParams.ContainsKey('inventarioid') then begin
         Query.SQL.Add('and II.InventarioId = :pInventarioId');
         Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'];
         Inc(vParamOk);
      end;
      if AParams.ContainsKey('produtoid') then begin
         Query.SQL.Add('and II.ProdutoId = :pProdutoId');
         Query.ParamByName('pProdutoId').Value := AParams.Items['produtoid'];
         Inc(vParamOk);
      end;
      if AParams.ContainsKey('enderecoid') then begin
         Query.SQL.Add('and II.EnderecoId = :pEnderecoId');
         Query.ParamByName('pEnderecoId').Value := AParams.Items['enderecoid'];
         Inc(vParamOk);
      end;
      if vParamOk <> AParams.Count then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'))
      End
      Else begin
        Query.SQL.Add('Order by II.InventarioId, II.Status, ');
        Query.SQL.Add
          ('         Case When Inv.inventariotipo = 1 then TEnd.Descricao--, ProdutoId, DescrLote');
        Query.SQL.Add
          ('              When Inv.inventariotipo = 2 then II.ProdutoId --, Endereco, DescrLote');
        Query.SQL.Add('	     End,');
        Query.SQL.Add
          ('         Case When Inv.inventariotipo = 1 then II.ProdutoId--, DescrLote');
        Query.SQL.Add
          ('              When Inv.inventariotipo = 2 then II.InventarioId--, ProdutoId, Endereco, DescrLote');
        Query.SQL.Add('	     End');
        Query.SQL.Add('		 , DescrLote');
        If DebugHook <> 0 Then
           Query.SQL.SaveToFile('LoteInventariado.Sql');
        Query.Open();
        if Query.IsEmpty then
        Begin
          Result := TJsonArray.Create();
          Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
        End
        Else
          Result := Query.ToJSONArray;
      end;
    Except
      On E: Exception do
      Begin
        raise Exception.Create('Processo: GetLoteInventariado - '+TUtil.TratarExcessao(E.Message));
      End
    End;
  Finally
    Query.Free;
  End;
end;

function TInventarioDao.GetModeloInventarioLista(
  pModeloId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Declare @ModeloId Integer = :pModeloId');
      Query.Sql.Add('Select * From InventarioModelo');
      Query.Sql.Add('Where (@ModeloId = 0 or @ModeloId = ModeloId)');
      Query.Sql.Add('Order By ModeloId');
      Query.ParamByName('pModeloId').Value := pModeloId;
      Query.Open;
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', 'Não há dados para gerar o relatório'));
      End
      Else
        Result := Query.ToJSONArray();
    Except
      ON E: Exception do
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Tabele: GetModeloInventarioLista - ' + TUtil.TratarExcessao(E.Message)));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

// https://stackoverflow.com/questions/7917695/sql-server-return-value-after-insert
Function TInventarioDao.InsertUpdate(pJsonInventario: TJsonObject): TJsonObject;
var vSql, vComplemento: String;
    InventarioId: Integer;
    pProcessoId, xEndereco: Integer;
    JsonArrayItens: TJsonArray;
    pDataLiberacao: String;
    InventarioTipo: Integer;
    vSeqMil       : Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    //Query.connection.TxOptions.Isolation := xiReadCommitted;
    If pJsonInventario.GetValue<TDateTime>('dataliberacao') = 0 then
       pDataLiberacao := 'Null'
    Else
       pDataLiberacao := #39 + FormatDateTime('YYYY-MM-DD', pJsonInventario.GetValue<TDateTime>('dataliberacao')) + #39;
    try
      Query.Open('(select processoid from processoetapas where descricao = ' + QuotedStr('Inventario - Gerado') + ')');
      pProcessoId := Query.FieldByName('ProcessoId').AsInteger;
      Query.Close;
      Query.SQL.Clear;
      if pJsonInventario.GetValue<Integer>('inventarioid') = 0 then Begin
         vSql := 'Declare @uuid UNIQUEIDENTIFIER = NewId()' + sLineBreak +
                 'Insert Into Inventarios (inventariotipo, motivo, dataliberacao, tipoajuste, status, uuid) OUTPUT Inserted.InventarioId Values ('+sLineBreak+
                 pJsonInventario.GetValue<Integer>('inventariotipo').ToString() + ', '+sLineBreak+
                 QuotedStr(pJsonInventario.GetValue<String>('motivo')) + ', ' +sLineBreak+
                 pDataLiberacao + ', ' + pJsonInventario.GetValue<Integer>('tipoajuste').ToString() + ', ' +sLineBreak+
                 pJsonInventario.GetValue<Integer>('status').ToString() + ', @uuid)' + sLineBreak;
      End
      Else
        vSql := 'Update Inventarios Set ' + sLineBreak +
                '     inventariotipo     = ' + pJsonInventario.GetValue<Integer>('inventariotipo').ToString() + sLineBreak +
                '   , motivo             = ' + QuotedStr(pJsonInventario.GetValue<String>('motivo')) + sLineBreak +
                '   , dataliberacao      = ' + pDataLiberacao + sLineBreak +
                '   , TipoAjuste         = ' + pJsonInventario.GetValue<Integer>('tipoajuste').ToString() + sLineBreak +
                '   , Status             = ' + pJsonInventario.GetValue<Integer>('status').ToString() + sLineBreak +
                '   OUTPUT Inserted.InventarioId as InventarioId' + sLineBreak +
                'where InventarioId = ' + pJsonInventario.GetValue<Integer>('inventarioid').ToString();
      Query.SQL.Add(vSql);
      If DebugHook <> 0 Then
        Query.SQL.SaveToFile('Inventario_InsertUpdate.Sql');
      // FConexao.Query.ExecSQL;
      Query.Open;
      InventarioId := Query.FieldByName('InventarioId').AsInteger;
      Result := Query.ToJSONObject();
      if pJsonInventario.GetValue<Integer>('inventarioid') = 0 then
      Begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where '+'InventarioId = ' + InventarioId.ToString() + ')');
        Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
        Query.ParamByName('pTerminal').Value := pJsonInventario.GetValue<String>('terminal');
        Query.ParamByName('pProcessoId').Value := pProcessoId;
        Query.ParamByName('pUsuarioId').Value := pJsonInventario.GetValue<Integer>('usuarioid');
        Query.ExecSQL;
      End;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Delete From InventarioItens Where InventarioId = ' + InventarioId.ToString());
      Query.ExecSQL;
      JsonArrayItens := pJsonInventario.GetValue<TJsonArray>('endereco');
      Query.Close;
      vSeqMil := 0; //Pred(JsonArrayItens.Count);
      Repeat
        Query.SQL.Clear;
        Query.SQL.Add('Insert into InventarioItens (InventarioId, EnderecoId, ProdutoId) Values ');
        vComplemento := '';
        For xEndereco := vSeqMil to IfThen(Pred(JsonArrayItens.Count)-vSeqMil>999, vSeqMil+999, Pred(JsonArrayItens.Count)) do Begin //  Pred(JsonArrayItens.Count) do Begin
          If pJsonInventario.GetValue<Integer>('inventariotipo') = 1 Then
             Query.SQL.Add('       ' + vComplemento + '(' + InventarioId.ToString() + ', ' + JsonArrayItens.Items[xEndereco].GetValue<Integer>('enderecoid').ToString + ', Null )')
          Else If pJsonInventario.GetValue<Integer>('inventariotipo') = 2 Then
             Query.SQL.Add('       ' + vComplemento + '(' + InventarioId.ToString() + ', Null, ' + JsonArrayItens.Items[xEndereco].GetValue<Integer>('produtoid').ToString + ' )');
          vComplemento := ', ';
        End;
        vSeqMil := xEndereco;
        If DebugHook <> 0 then
           Query.SQL.SaveToFile('InventarioItens.Sql');
        Query.ExecSQL;
      Until vSeqMil >= Pred(JsonArrayItens.Count);
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('Delete from InventarioInicial Where inventarioid = '+InventarioId.ToString());
      Query.SQL.Add('Insert Into InventarioInicial');
      If pJsonInventario.GetValue<Integer>('inventariotipo') = 1 then Begin
         Query.SQL.Add('select II.InventarioId, II.enderecoid, ');
         Query.SQL.Add('       Est.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
      End
      Else If pJsonInventario.GetValue<Integer>('inventariotipo') = 2 then Begin
         Query.SQL.Add('select II.InventarioId, Est.enderecoid, ');
         Query.SQL.Add('       II.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
      End;
      Query.SQL.Add('       Coalesce(Est.QtdeProducao, 0) EstoqueInicial, ' + #39 + 'I' + #39+' Status, 1 as Automatico');
      Query.SQL.Add('from inventarioitens II');
      If pJsonInventario.GetValue<Integer>('inventariotipo') = 1 then
         Query.SQL.Add('Left Join vestoque Est on Est.EnderecoId = II.enderecoid')
      Else If pJsonInventario.GetValue<Integer>('inventariotipo') = 2 then
         Query.SQL.Add('Left Join vestoque Est on Est.ProdutoId = II.Produtoid');
      Query.SQL.Add('where II.inventarioid = ' + InventarioId.ToString());
      if pJsonInventario.GetValue<Integer>('inventariotipo') = 2 then
         Query.SQL.Add('  And (Est.ZonaId Is Null Or Est.ZonaID > 3)');
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('InventarioInicial.Sql');
      //FConexao.Query.ExecSQL; //Não congelar estoque na criação do Inventário
      Query.connection.Commit;
    Except ON E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Tabela: Inventarios/InsertUpdate - ' + Tutil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
