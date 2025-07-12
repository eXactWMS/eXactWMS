unit MService.LoteDAO;

interface

uses
  FireDAC.Comp.Client, LotesClass, System.SysUtils,  DataSet.Serialize,
  System.Types, FireDAC.Stan.Option, Web.HTTPApp,
  System.JSON, REST.JSON, System.JSON.Types, Constants,
  exactwmsservice.lib.connection, exactwmsservice.lib.utils,
  exactwmsservice.dao.base;

type
  TLoteDao = class(TBasicDao)
  private
    ObjLoteDAO: TLote;
    
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pLoteId, pProdutoId: Integer; pDescricao: String;
      pFabricacao, pVencimento: TDate): TjSonArray;
    function SalvarLote(pLoteId, pProdutoId: Integer; pDescricao: String;
      pFabricacao, pVencimento: TDate): TJSONObject;
    function GetId(pId: Integer): TjSonArray;
    function GetDescricao(pProdutoId, pLoteId: Integer; pDescricao: String)
      : TjSonArray;
    function GetLoteResumo(pProdutoId: Integer; pDescricao: String): TjSonArray;
    function GetLoteResumoAgrupado(pProdutoId: Integer; pDescricao: String)
      : TjSonArray;
    Function Delete(pId: Integer): Boolean;
    Function PutCorrecaoLote(pJsonObjectLotes: TJSONObject): TjSonArray;

    Function Estrutura: TjSonArray;
  end;

implementation

{ TClienteDao }

constructor TLoteDao.Create;
begin
  ObjLoteDAO := TLote.Create;
  inherited;
end;

function TLoteDao.Delete(pId: Integer): Boolean;
var Query : TFdQuery;
    vSql: String;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from ProdutoLotes where LoteId = ' + pId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      raise Exception.Create('Processo: Lote/Delete'+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

destructor TLoteDao.Destroy;
begin
  FreeAndNil(ObjLoteDAO);
  inherited;
end;

function TLoteDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJSONObject;
var Query : TFdQuery;
    vSql: String;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak +
               'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
               'Where TABLE_NAME = ' + QuotedStr('ProdutoLotes') +' --and CHARACTER_MAXIMUM_LENGTH Is Not Null');
    if Query.IsEmpty Then
      Result.AddElement(TJSONObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
    Else
    Begin
      While Not Query.Eof do Begin
        vRegEstrutura := TJSONObject.Create;
        vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
        vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
        vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
        Result.AddElement(vRegEstrutura);
        Query.Next;
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TLoteDao.GetDescricao(pProdutoId, pLoteId: Integer; pDescricao: String) : TjSonArray;
var
  vSql: String;
  jsonLote: TJSONObject;
  Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pDescricao = '*' then
         pDescricao := '';
      vSql := 'Declare @ProdutoId Integer = ' + pProdutoId.ToString + '; ' + #13 +
        #10 + 'Declare @LoteId Integer = ' + pLoteId.ToString + '; ' + #13 + #10 +
        'Declare @Descricao Varchar(30) = ' + QuotedStr('%' + pDescricao + '%') +
        '; ' + #13 + #10 + ';with' + sLineBreak +
        'Estoq As (Select LoteId, Sum(Est.Qtde) Estoque' + sLineBreak +
        '          From vEstoque Est' + sLineBreak +
        '          Where (@ProdutoId = 0 or @ProdutoId = Est.ProdutoId) and' +
        sLineBreak + '                (@LoteId = 0 or @Loteid = Est.LoteId) and' +
        sLineBreak + '   	            (@Descricao = ' + #39 + #39 +
        ' or DescrLote like @Descricao) and Producao = 1' + sLineBreak +
        '          Group by LoteId),' + sLineBreak +
        'EstoqBlock As (Select LoteId, Sum(Est.Qtde) Estoque' + sLineBreak +
        '          From vEstoque Est' + sLineBreak +
        '          Where (@ProdutoId = 0 or @ProdutoId = Est.ProdutoId) and' +
        sLineBreak + '                (@LoteId = 0 or @Loteid = Est.LoteId) and' +
        sLineBreak + '   	            (@Descricao = ' + #39 + #39 +
        ' or DescrLote like @Descricao) and EstoqueTipoId = 6' + sLineBreak +
        '          Group by LoteId)' + sLineBreak +
        'select Pl.LoteId, Pl.ProdutoId, Prd.CodProduto CodigoERP, Pl.DescrLote' +
        #13 + #10 +
        '       , DF.Data as Fabricacao, DV.Data as Vencimento, RD.Data as DtEntrada, Rh.Hora as HrEntrada '
        + #13 + #10 +
        '       , Coalesce(Est.Estoque, 0) Estoque, Coalesce(Blc.Estoque, 0) Bloqueado'
        + sLineBreak + 'From ProdutoLotes Pl' + #13 + #10 +
        ' Inner join Produto Prd On Prd.IdProduto = Pl.ProdutoId' + #13 + #10 +
        ' Inner Join Rhema_Data DF On DF.IdData = Pl.Fabricacao ' + #13 + #10 +
        ' Inner Join Rhema_Data DV On DV.IdData = Pl.Vencimento ' + #13 + #10 +
        ' Inner Join Rhema_Data RD On Rd.IdData = Pl.DtEntrada ' + #13 + #10 +
        ' Inner Join Rhema_Hora RH On Rh.IdHora = Pl.HrEntrada ' + #13 + #10 +
        ' Left Join Estoq Est On Est.LoteId = PL.LoteId' + sLineBreak +
        ' Left Join EstoqBlock Blc On Blc.LoteId = Pl.LoteId' + sLineBreak +
        'Where (@ProdutoId = 0 or @ProdutoId = Pl.ProdutoId)' + #13 + #10 +
        '      and (@LoteId = 0 or @Loteid = Pl.LoteId)' + #13 + #10 +
        '   	  and (@Descricao = ' + #39 + #39 +
        ' or DescrLote like @Descricao)';
      Query.SQL.Add(vSql);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('Produtolotes.Sql');
      Query.Open;
      while Not Query.Eof do
      Begin
        jsonLote := TJSONObject.Create;
        jsonLote.AddPair('loteid',
          TJsonNumber.Create(Query.FieldByName('LoteId').AsInteger));
        jsonLote.AddPair('produtoid',
          TJsonNumber.Create(Query.FieldByName('ProdutoId').AsInteger));
        jsonLote.AddPair('codigoerp',
          TJsonNumber.Create(Query.FieldByName('CodigoERP').AsInteger));
        jsonLote.AddPair('descrlote', Query.FieldByName('DescrLote')
          .AsString);
        jsonLote.AddPair('fabricacao', Query.FieldByName('Fabricacao')
          .AsString);
        jsonLote.AddPair('vencimento', Query.FieldByName('Vencimento')
          .AsString);
        jsonLote.AddPair('dtentrada', Query.FieldByName('DtEntrada')
          .AsString);
        jsonLote.AddPair('hrentrada', Query.FieldByName('HrEntrada')
          .AsString);
        jsonLote.AddPair('estoque',
          TJsonNumber.Create(Query.FieldByName('Estoque').AsInteger));
        jsonLote.AddPair('bloqueado',
          TJsonNumber.Create(Query.FieldByName('Bloqueado').AsInteger));
        Result.AddElement(jsonLote);
        // tJson.ObjectToJsonObject(ObjLoteDao, [joDateFormatISO8601]));
        Query.Next;
      End;
    Except ON E: Exception do
        raise Exception.Create('Processo: GetLoteDescricao - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TLoteDao.GetId(pId: Integer): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'select Prd.CodProduto CodigoERP, Pl.* from ProdutoLotes Pl';
      vSql := vSql + ' Inner Join Produto Prd On Prd.IdProduto = Pl.ProdutoId';
      if pId <> 0 then
        vSql := vSql + ' where Pl.LoteId = ' + pId.ToString;
      Query.Open(vSql);
      while Not Query.Eof do
      Begin
        ObjLoteDAO.ProdutoId  := Query.FieldByName('ProdutoId').AsInteger;
        ObjLoteDAO.CodigoERP  := Query.FieldByName('CodigoERP').AsInteger;
        ObjLoteDAO.LoteId     := Query.FieldByName('LoteId').AsInteger;
        ObjLoteDAO.DescrLote  := Query.FieldByName('DescrLote').AsString;
        ObjLoteDAO.Fabricacao := Query.FieldByName('Fabricacao').AsDateTime;
        ObjLoteDAO.Vencimento := Query.FieldByName('Vencimento').AsDateTime;
        Result.AddElement(tJson.ObjectToJsonObject(ObjLoteDAO));
        Query.Next;
      End;
    Except ON E: Exception do
        raise Exception.Create('Processo: Inventario/GetId - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TLoteDao.GetLoteResumo(pProdutoId: Integer; pDescricao: String) : TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pDescricao = '*' then
         pDescricao := '';
      vSql := 'Declare @ProdutoId Integer = ' + pProdutoId.ToString + '; '+sLineBreak+
              'Declare @Descricao Varchar(30) = ' +QuotedStr('%' + pDescricao + '%') + '; '+sLineBreak+
              'Select vEst.LoteId, vEst.ProdutoId, vEst.CodigoERP, vEst.EnderecoId, vEst.Endereco,'+sLineBreak+
              '       vEst.DescrLote DescrLote,' + sLineBreak +
              '       FORMAT(vEst.Fabricacao, ' + #39+'dd/MM/yyyy' + #39+') Fabricacao,'+sLineBreak+
              '       FORMAT(vEst.Vencimento, ' + #39+'dd/MM/yyyy' + #39+') Vencimento,'+sLineBreak+
              '       FORMAT(vEst.DtEntrada, ' + #39 + 'dd/MM/yyyy'+ #39+') DtEntrada, vEst.HrEntrada,'+sLineBreak+
              '       vEst.QtdeProducao, vEst.QtdeReserva Bloqueado, vEst.Qtde Estoque, vEst.EstoquetipoId,'+sLineBreak+
              '	     TEnd.EstruturaId, vEst.Mascara, vEst.zonaid, TEnd.BloqueioInventario'+sLineBreak +
              'From vEstoque vEst'+sLineBreak+
              'Inner Join Enderecamentos TEnd On TEnd.Descricao = vEst.Endereco'+sLineBreak +
              'Where (@ProdutoId = 0 or @ProdutoId = ProdutoId)'+sLineBreak+
              '  and (@Descricao = '+#39+#39+' or DescrLote like @Descricao)'+sLineBreak+
              'Order by vEst.CodigoERP, vEst.DescrLote, vEst.Vencimento, vEst.Endereco';
      Query.SQL.Add(vSql);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('LoteResumo.Sql');
      Query.Open;
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJSONObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
      End
      Else
        Result := Query.ToJsonArray;
    Except
      On E: Exception Do
      Begin
        raise Exception.Create('Processo: GetLoteResumo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TLoteDao.GetLoteResumoAgrupado(pProdutoId: Integer; pDescricao: String)
  : TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pDescricao = '*' then
        pDescricao := '';
      vSql := 'Declare @ProdutoId Integer = ' + pProdutoId.ToString + '; ' + #13 +
        #10 + 'Declare @Descricao Varchar(30) = ' +
        QuotedStr('%' + pDescricao + '%') + '; ' + sLineBreak +
        'Select vEst.LoteId, vEst.ProdutoId, vEst.CodigoERP, vEst.DescrLote,' +
        sLineBreak + '       FORMAT(vEst.Fabricacao, ' + #39 + 'dd/MM/yyyy' + #39
        + ') Fabricacao,' + sLineBreak + '       FORMAT(vEst.Vencimento, ' + #39 +
        'dd/MM/yyyy' + #39 + ') Vencimento,' + sLineBreak +
        '       Sum(vEst.QtdeProducao) QtdeProducao, Sum(vEst.QtdeReserva) Bloqueado, Sum(vEst.Qtde) Estoque'
        + sLineBreak + 'From vEstoque vEst' + sLineBreak +
        'Inner Join Enderecamentos TEnd On TEnd.Descricao = vEst.Endereco' +
        sLineBreak + 'Where (@ProdutoId = 0 or @ProdutoId = ProdutoId)' +
        sLineBreak + '  and (@Descricao = ' + #39 + #39 +
        ' or DescrLote like @Descricao)' + sLineBreak +
        'Group by vEst.LoteId, vEst.ProdutoId, vEst.CodigoERP,' + sLineBreak +
        '         vEst.DescrLote, vEst.Fabricacao, vEst.Vencimento' + sLineBreak +
        'Order by vEst.CodigoERP, vEst.DescrLote, vEst.Vencimento';
      Query.SQL.Add(vSql);
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('LoteResumoAgrupado.Sql');
      Query.Open;
      if Query.IsEmpty then
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJSONObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
      End
      Else
        Result := Query.ToJsonArray;
    Except
      On E: Exception Do
      Begin
        raise Exception.Create('Processo: GetLoteResumoAgrupado - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TLoteDao.InsertUpdate(pLoteId, pProdutoId: Integer; pDescricao: String;
  pFabricacao, pVencimento: TDate): TjSonArray;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pLoteId = 0 then
        vSql := 'Insert Into ProdutoLotes (ProdutoId, DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada, uuid) Values ('
          + pProdutoId.ToString() + ', ' + QuotedStr(pDescricao) + ', ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', pFabricacao)) + ', ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', pVencimento)) + ', ' +
          '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))' +
          ', ' + 'select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)), NewId() )'
      Else
        vSql := 'Update ProdutoLotes ' + '    Set DescrLote   = ' +
          QuotedStr(pDescricao) +
          '        ,Fabricacao = (Select IdData From Rhema_Data Where Data = ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', pFabricacao)) + ')' +
          '        ,Vencimento = (Select IdData From Rhema_Data Where Data = ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', pVencimento)) + ')' +
          'where LoteId = ' + pLoteId.ToString;
      Query.ExecSQL(vSql);
      Result := Query.ToJsonArray;
    Except On E: Exception do
        raise Exception.Create('Processo: Lote/InsertUpdate - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

function TLoteDao.PutCorrecaoLote(pJsonObjectLotes: TJSONObject): TjSonArray;
var xLote: Integer;
   vProdutoId: Integer;
   vDelLote: Boolean;
   vAgrupado2: Boolean;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    Try
      vProdutoId := pJsonObjectLotes.GetValue<Integer>('produtoid');
      vDelLote := True;
      vAgrupado2 := False;
      for xLote := 0 to Pred(pJsonObjectLotes.GetValue<TjSonArray>
        ('correcao').Count) do
      Begin
        if pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
          .GetValue<String>('lote') = pJsonObjectLotes.GetValue<String>('lote')
        then
          vDelLote := False;
        Query.SQL.Clear;
        Query.SQL.Add('If Not Exists (Select LoteId From ProdutoLotes');
        Query.SQL.Add('               Where ProdutoId = ' +
          vProdutoId.ToString + ' and DescrLote = ' + #39 +
          pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
          .GetValue<String>('lote') + #39 + ')');
        Query.SQL.Add('   Insert Into ProdutoLotes values (' +
          vProdutoId.ToString + ', ' + #39 + pJsonObjectLotes.GetValue<TjSonArray>
          ('correcao').Items[xLote].GetValue<String>('lote') + #39 + ', ' +
          '(Select IdData From Rhema_Data Where Data = ' + #39 +
          FormatDateTime('YYYY-MM-DD',
          StrToDate(pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
          .GetValue<String>('fabricacao'))) + #39 + '), ' +
          '(Select IdData From Rhema_Data Where Data = ' + #39 +
          FormatDateTime('YYYY-MM-DD',
          StrToDate(pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
          .GetValue<String>('vencimento'))) + #39 + '), ' +
          TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual +
          ', NewId())');
        Query.SQL.Add('Else Begin');
        Query.SQL.Add('  Update ProdutoLotes Set');
        Query.SQL.Add
          ('    Fabricacao = (Select IdData From Rhema_Data Where Data = ' + #39 +
          FormatDateTime('YYYY-MM-DD',
          StrToDate(pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
          .GetValue<String>('fabricacao'))) + #39 + '), ');
        Query.SQL.Add
          ('    Vencimento = (Select IdData From Rhema_Data Where Data = ' + #39 +
          FormatDateTime('YYYY-MM-DD',
          StrToDate(pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
          .GetValue<String>('vencimento'))) + #39 + ')');
        Query.SQL.Add('  Where ProdutoId = ' + vProdutoId.ToString() +
          ' and DescrLote = ' + #39 + pJsonObjectLotes.GetValue<TjSonArray>
          ('correcao').Items[xLote].GetValue<String>('lote') + #39);
        Query.SQL.Add('End');
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('CorrecaoLotes.Sql');
        Query.ExecSQL;
        Query.Close;
        // if pJsonObjectLotes.GetValue<Integer>('EnderecoId') = 0 then
        // vAgrupado := True;
      End;
      if (1 = 1) then
      begin // (Not vAgrupado) then Begin
        if vDelLote then
        Begin
          Query.SQL.Clear;
          Query.SQL.Add('Delete from Estoque where LoteId = ' +
            pJsonObjectLotes.GetValue<Integer>('loteid').ToString +
            ' and EstoqueTipoId <> 6');
          // FConexao.Query.ExecSql;
        End;
        // Alterar-Inserir Estoque conforme correção de lote
        for xLote := 0 to Pred(pJsonObjectLotes.GetValue<TjSonArray>
          ('correcao').Count) do
        Begin
          Query.SQL.Clear;
          Query.SQL.Add('Declare @LoteId Integer = '+'(Select LoteId From ProdutoLotes where ProdutoId = '+
            pJsonObjectLotes.GetValue<Integer>('produtoid').ToString +          '        And DescrLote = ' + #39 +
            pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote]
            .GetValue<String>('lote') + #39 + ')');
          Query.SQL.Add('If Not Exists (Select LoteId From Estoque ');
          Query.SQL.Add('Where LoteId = @LoteId and EstoqueTipoId = '+pJsonObjectLotes.GetValue<Integer>('estoquetipoid').ToString);
          Query.SQL.Add('  And EnderecoId = '+pJsonObjectLotes.GetValue<Integer>('enderecoid').ToString + ')');
          Query.SQL.Add('   Insert Into Estoque Values (@LoteId, '+pJsonObjectLotes.GetValue<Integer>('enderecoid').ToString + ', ' +
            pJsonObjectLotes.GetValue<Integer>('estoquetipoid').ToString  + ', ' +pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote].GetValue<Integer>('qtde').ToString + ', ' +
            TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual+ ', '+pJsonObjectLotes.GetValue<Integer>('usuarioid').ToString+', '+'Null, Null, Null)');
          Query.SQL.Add('Else Begin');
          Query.SQL.Add('  Update Estoque Set');
          Query.SQL.Add('     Qtde        = Qtde +'+pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote].GetValue<Integer>('qtde').ToString);
          Query.SQL.Add('  where LoteId   = @LoteId and EstoqueTipoId = '+pJsonObjectLotes.GetValue<Integer>('estoquetipoid').ToString);
          Query.SQL.Add('    And EnderecoId = '+pJsonObjectLotes.GetValue<Integer>('enderecoid').ToString);
          Query.SQL.Add('End');
          Query.SQL.Add('update Estoque Set Qtde = Qtde - ' +pJsonObjectLotes.GetValue<TjSonArray>('correcao').Items[xLote].GetValue<Integer>('qtde').ToString);
          Query.SQL.Add('Where LoteId        = ' +pJsonObjectLotes.GetValue<Integer>('loteid').ToString);
          Query.SQL.Add('  and EstoqueTipoId = ' + pJsonObjectLotes.GetValue<Integer>('estoquetipoid').ToString);
          Query.SQL.Add('  And EnderecoId    = ' +pJsonObjectLotes.GetValue<Integer>('enderecoid').ToString);
          Query.SQL.Add('');
          if DebugHook <> 0 then
             Query.SQL.SaveToFile('CorrecaoLotesEstoque.Sql');
          Query.ExecSQL;
        End;
      End;
      Result.AddElement(TJSONObject.Create.AddPair('status', '200 - Ok'));
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Process: PutCorrecaoLote - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

Function TLoteDao.SalvarLote(pLoteId, pProdutoId: Integer; pDescricao: String;
  pFabricacao, pVencimento: TDate): TJSONObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Declare @LoteId Integer = ' + pLoteId.ToString);
      Query.SQL.Add
        ('If Not Exists (select Loteid From ProdutoLotes Where ProdutoId = ' +
        pProdutoId.ToString);
      Query.SQL.Add('               and DescrLote = ' +
        QuotedStr(pDescricao) + ') Begin');
      Query.SQL.Add
        ('Insert Into ProdutoLotes (ProdutoId, DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada, uuid) Values (');
      Query.SQL.Add('          ' + pProdutoId.ToString() + ', ' +
        QuotedStr(pDescricao) + ', ');
      Query.SQL.Add
        ('         (Select IdData From Rhema_Data Where Data = ' +
        QuotedStr(FormatDateTime('YYYY-MM-DD', pFabricacao)) + '), ');
      Query.SQL.Add
        ('         (Select IdData From Rhema_Data Where Data = ' +
        QuotedStr(FormatDateTime('YYYY-MM-DD', pVencimento)) + '), ');
      Query.SQL.Add
        ('            (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'
        + ', ');
      Query.SQL.Add
        ('            (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), NewId())');
      Query.SQL.Add('            Set @LoteId = SCOPE_IDENTITY()');
      Query.SQL.Add('End');
      Query.SQL.Add('Else Begin');
      Query.SQL.Add
        ('   Set @LoteId = (select Loteid From ProdutoLotes Where ProdutoId = ' +
        pProdutoId.ToString);
      Query.SQL.Add('               and DescrLote = ' +
        QuotedStr(pDescricao) + ')');
      Query.SQL.Add('End');
      Query.SQL.Add('Select * From ProdutoLotes Where LoteId = @LoteId');
      If DebugHook <> 0 Then
        Query.SQL.SaveToFile('LotesSave.Sql');
      Query.Open;
      Result := Query.ToJSONObject; // TJsonArray.Create;
    Except
      ON E: Exception do
        raise Exception.Create('Processo: SalvarLote - '+TUtil.TratarExcessao(E.Message));
    end;
  Finally
    Query.Free;
  End;
end;

end.
