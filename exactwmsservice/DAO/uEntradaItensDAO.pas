unit uEntradaItensDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, DataSet.Serialize,
  FireDAC.Stan.Option, System.JSON, REST.JSON, Generics.Collections,
  EntradaItensClass, MService.ProdutoDAO, LotesClass,
  exactwmsservice.lib.connection, exactwmsservice.dao.base;

// Const SqlDataAtual    = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';
// Const SqlHoraAtual    = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';
Const SqlEntradaItens = 'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.ProdutoId, Prd.CodProduto CodigoERP, Pl.DescrLote'
    + #13 + #10 + ', FORMAT(DF.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as Fabricacao' + #13 + #10 + ', FORMAT(DV.Data, ' + #39 + 'dd/MM/yyyy' +
    #39 + ') as Vencimento  ' + #13 + #10 + ', FORMAT(RD.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtEntrada  ' + #13 + #10 +
    ', Rh.Hora HrEntrada, ' + #13 + #10 +
    'PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, PIt.QtdSegregada, ' + #13 +
    #10 + 'Prd.Descricao DescrProduto' + #13 + #10 + 'From PedidoItens PIt' +
    #13 + #10 + 'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + #13 +
    #10 + 'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + #13 + #10
    + ' Inner Join Rhema_Data DF On DF.IdData = Pl.Fabricacao ' + #13 + #10 +
    ' Inner Join Rhema_Data DV On DV.IdData = Pl.Vencimento ' + #13 + #10 +
    'Inner join Rhema_Data RD on Rd.IdData = Pl.DtEntrada' + #13 + #10 +
    'Inner Join Rhema_Hora RH on Rh.IdHora = Pl.HrEntrada';

Const SqlEntradaProduto = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'if object_id ('#39+'tempdb..#MemItens'+#39+') is not null drop table #MemItens '+sLineBreak+
      ''+sLineBreak+
      'select PIt.PedidoId, Pl.ProdutoId,'+sLineBreak+
      '       Sum(PIt.QtdXml) as QtdXml, Sum(PIt.QtdCheckIn) QtdCheckIn,'+sLineBreak+
      '       Sum(PIt.QtdDevolvida) QtdDevolvida, Sum(PIt.QtdSegregada) QtdSegregada Into #MemItens'+sLineBreak+
      'From PedidoItens PIt'+sLineBreak+
      'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId'+sLineBreak+
      'WHERE pIT.PedidoId = @PedidoId'+sLineBreak+
      'Group by PIt.PedidoId, Pl.ProdutoId'+sLineBreak+
      ''+sLineBreak+
      'Select Itens.*,'+sLineBreak+
      '       Prod.FatorConversao, Prod.PesoLiquido, Prod.Altura, Prod.Largura, Prod.Comprimento,'+sLineBreak+
      '       (Prod.Altura*Prod.Largura*Prod.Comprimento) Volume,'+sLineBreak+
      '       Prod.CodProduto, Prod.Descricao, Prod.EnderecoDescricao Picking, Prod.Mascara,'+sLineBreak+
      '       Prod.SNGPC, RastroId, UnidadeSecundariaId, UnidadeSecundariaDescricao,'+sLineBreak+
      '       Prod.ZonaID, Prod.ZonaDescricao Zona, Prod.ProdutoSNGPC ZonaSNGPC, Prod.UnidadeId, Prod.UnidadeDescricao Unidade,'+sLineBreak+
      '	   Prod.MesEntradaMinima'+sLineBreak+
      'From #MemItens Itens'+sLineBreak+
      'Inner Join vProduto Prod On Prod.IdProduto = Itens.ProdutoId'+sLineBreak+
      'Order by Itens.PedidoId, Prod.Descricao';

Const SqlEntradaProdutoOLD_021024 = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
    'Select Itens.*,' + sLineBreak +
    '       Prod.FatorConversao, Prod.PesoLiquido, Prod.Altura, Prod.Largura, Prod.Comprimento,' + sLineBreak +
    '	      (Prod.Altura*Prod.Largura*Prod.Comprimento) Volume,' + sLineBreak +
    '	      Prod.CodProduto, Prod.Descricao, Prod.EnderecoDescricao Picking, Prod.Mascara,' + sLineBreak +
    '       Prod.SNGPC, RastroId, UnidadeSecundariaId, UnidadeSecundariaDescricao' + sLineBreak +
    '	    , Prod.ZonaID, Prod.ZonaDescricao Zona, Prod.ProdutoSNGPC ZonaSNGPC, Prod.UnidadeId, Prod.UnidadeDescricao Unidade' + sLineBreak +
    'From (select PIt.PedidoId, Pl.ProdutoId,' + sLineBreak +
    '             Sum(PIt.QtdXml) as QtdXml, Sum(PIt.QtdCheckIn) QtdCheckIn,' + sLineBreak +
    '			          Sum(PIt.QtdDevolvida) QtdDevolvida, Sum(PIt.QtdSegregada) QtdSegregada' + sLineBreak +
    '      From PedidoItens PIt' + sLineBreak +
    '      Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
    '      WHERE pIT.PedidoId = @PedidoId' + sLineBreak +
    '      Group by PIt.PedidoId, Pl.ProdutoId ) Itens' + sLineBreak +
    'Inner Join vProduto Prod On Prod.IdProduto = Itens.ProdutoId' + sLineBreak +
    'Order by Itens.PedidoId, Prod.Descricao';

Const
  SqlGetProdutoTag =
    'Declare @TagProdutoSNGPC integer = (Select TagProdutoEntrada From Configuracao)'
    + sLineBreak + 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
    'Declare @DocumentoNr VarChar(20) = :pDocumentoNr;' + sLineBreak +
    'Declare @RegistroERP VarChar(26) = :pRegistroERP' + sLineBreak +
    'Declare @DtDocumentoData DateTime= :pDtDocumentoData;' + sLineBreak +
    'Declare @DtCheckInFinalizacao DateTime = :pDtCheckInFinalizacao;' +
    sLineBreak + 'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
    'select PIt.PedidoId, PD.Data DocumentoData, Pl.ProdutoId, Prd.CodProduto' +
    sLineBreak +
    '       CodigoERP, Prd.Descricao DescrProduto, Prd.FatorConversao Embalagem,'
    + sLineBreak + '       Prd.EnderecoDescricao Picking, Prd.Mascara,' +
    sLineBreak + '       Pl.LoteId, Pl.DescrLote, RD.Data As Vencimento,' +
    sLineBreak +
    '       PIt.QtdCheckIn, Coalesce(Pit.PrintEtqControlado, 0) PrintEtqControlado'
    + sLineBreak + 'From PedidoItens PIt' + sLineBreak +
    'Inner join Pedido Ped On Ped.PedidoId = PIt.PedidoId' + sLineBreak +
    'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
    'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
    'Left Join Rhema_Data RD On RD.IdData = Pl.Vencimento' + sLineBreak +
    'Left Join Rhema_Data PD On Ped.DocumentoData = PD.IdData' + sLineBreak +
    'Inner Join (select Ic.PedidoId, Ic.LoteId, max(Rd.Data) Data' + sLineBreak
    + '            From PedidoItensCheckIn Ic' + sLineBreak +
    '            Inner Join PedidoItens Pi On Pi.PedidoId = Ic.PedidoId and Pi.LoteId = Ic.LoteId'
    + sLineBreak +
    '            Inner Join Rhema_Data Rd On Rd.IdData = Ic.CheckInDtInicio' +
    sLineBreak + '            where Ic.QtdCheckIn > 0' + sLineBreak +
    '            Group by  Ic.PedidoId, Ic.LoteId) ItemCheckIn ON ItemCheckIn.PedidoId = PIt.PedidoId and ItemCheckIn.LoteId = Pl.LoteId'
    + sLineBreak +
    'WHERE (@PedidoId=0 or Pit.PedidoId = @PedidoId) and ( (@TagProdutoSNGPC=1) or (@TagProdutoSNGPC=2 and Prd.ProdutoSNGPC=1) or (@TagProdutoSNGPC=3 and Prd.SNGPC=1) )'
    + sLineBreak + '      And Pit.QtdCheckIn > 0' + sLineBreak +
    '      AND (@DocumentoNr = ' + #39 + #39 +
    ' or @DocumentoNr = Ped.DocumentoNr)' + sLineBreak +
    '      And (@RegistroERP = ' + #39 + #39 +
    ' or @RegistroERP = Ped.RegistroERP)' + sLineBreak +
    '      And (@DtDocumentoData = 0 Or @DtDocumentoData = Pd.Data)' +
    sLineBreak +
    '      And (@DtCheckInFinalizacao = 0 or  @DtCheckInFinalizacao = ItemCheckIn.Data)'
    + sLineBreak + '      And (@CodigoERP = 0 or @CodigoERP = Prd.CodProduto)' +
    sLineBreak + 'Order by PIt.PedidoId, Prd.Descricao, RD.Data';

Type
  TEntradaItensDao = class(TBasicDao)
  private
    // FIndexConn : Integer;

    FEntradaItens: TEntradaItens;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoItemId, pPedidoId, pLoteId, pQtdXml,
      pQtdCheckIn, pQtdDevolvida, pQtdSegregada: Integer): TjSonArray;
    Function Salvar: Boolean;
    function GetId(pPedidoItemId: Integer): TjSonArray;
    Function Delete: Boolean;
    Function DelCheckIn: Boolean;
    Function GetEntradaItens(pEntradaId: Integer = 0; pProdutoId: Integer = 0;
      pLoteId: Integer = 0; pShowErro: Integer = 1): TjSonArray;
    Function GetEntradaProduto(pEntradaId: Integer = 0; pShowErro: Integer = 1)
      : TjSonArray;
    Function GetProdutoTag(aQuery: TDictionary<String, String>): TjSonArray;
    Function GetProdutoTagClass(pPedidoId: Integer; pDocumentoNr: String;
      pDtDocumentoData: TDateTime; pRegistroERP: String;
      pDtCheckInFinalizacao: TDateTime; pCodigoERP: Integer;
      pTagEstoque: Boolean): TjSonArray;
    Property EntradaItens: TEntradaItens Read FEntradaItens Write FEntradaItens;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TEntradaItensDao.Create;
begin
  FEntradaItens := TEntradaItens.Create;
  inherited;
end;

function TEntradaItensDao.DelCheckIn: Boolean;
begin
  Result := False;
  try
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.SQL.Add('Declare @ProdutoId integer = ' + Self.FEntradaItens.EntradaItemId.ToString);
    FConexao.Query.SQL.Add('Update PI Set QtdCheckIn = 0, QtdDevolvida = 0, QtdSegregada = 0');
    FConexao.Query.SQL.Add('From PedidoItens PI');
    FConexao.Query.SQL.Add('Inner join vProdutoLotes Pl On Pl.LoteId = PI.LoteID');
    FConexao.Query.SQL.Add('where PedidoId = '+Self.FEntradaItens.EntradaId.ToString);
    FConexao.Query.SQL.Add('  And (@ProdutoId=0 or Pl.CodProduto = @ProdutoId) ');
    FConexao.Query.SQL.Add('  And PI.QtdXml <> 0');
    FConexao.Query.SQL.Add('Delete Pi');
    FConexao.Query.SQL.Add('From PedidoItens PI');
    FConexao.Query.SQL.Add('Inner join vProdutoLotes Pl On Pl.LoteId = PI.LoteID');
    FConexao.Query.SQL.Add('where PedidoId = '+Self.FEntradaItens.EntradaId.ToString);
    FConexao.Query.SQL.Add(' And (@ProdutoId=0 or Pl.CodProduto = @ProdutoId)');
    FConexao.Query.SQL.Add(' And PI.QtdXml = 0');
    FConexao.Query.SQL.Add('Delete Pi');
    FConexao.Query.SQL.Add('From PedidoItensCheckIn PI');
    FConexao.Query.SQL.Add('Inner join vProdutoLotes Pl On Pl.LoteId = PI.LoteID');
    FConexao.Query.SQL.Add('where PedidoId = '+Self.FEntradaItens.EntradaId.ToString);
    FConexao.Query.SQL.Add('  And (@ProdutoId=0 or Pl.CodProduto = @ProdutoId)');
    if Self.FEntradaItens.EntradaItemId = 0 then Begin
       FConexao.Query.SQL.Add('Update Pedido Set Status = 0 where PedidoId = '+Self.FEntradaItens.EntradaId.ToString());
       FConexao.Query.SQL.Add('Update DocumentoEtapas');
       FConexao.Query.SQL.Add('  Set Status = 0');
       FConexao.Query.SQL.Add('Where Documento = (Select Uuid From Pedido where PedidoId = '+Self.FEntradaItens.EntradaId.ToString()+')');
       FConexao.Query.SQL.Add('  And ProcessoId > 1');
    End;
    FConexao.Query.ExecSQL;
    Result := True;
    FConexao.Query.connection.Commit;
  Except On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TEntradaItensDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from PedidoItens where PedidoItemId = ' +
      Self.FEntradaItens.EntradaItemId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TEntradaItensDao.Destroy;
begin
  FEntradaItens.Free;
  inherited;
end;

function TEntradaItensDao.GetEntradaItens(pEntradaId, pProdutoId, pLoteId,
  pShowErro: Integer): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
  ObjProdutoDAO: TPRodutoDAO;
  // ObjLote       : TLote;
  vProdutoId: Integer;
begin
  Result := TjSonArray.Create;
  try
    vSql := 'Declare @PedidoId  Integer = ' + pEntradaId.ToString() + #13 + #10;
    vSql := vSql + 'Declare @ProdutoId Integer = ' + pProdutoId.ToString() +
      #13 + #10;
    vSql := vSql + 'Declare @LoteId Integer    = ' + pLoteId.ToString() +
      #13 + #10;
    vSql := vSql + SqlEntradaItens + #13 + #10;
    vSql := vSql + ' Where (@PedidoId  = 0 or PIt.PedidoId  = ' +
      pEntradaId.ToString + ') and ' + #13 + #10;
    vSql := vSql + '       (@ProdutoId = 0 or Prd.IdProduto = ' +
      pProdutoId.ToString + ') and ' + #13 + #10;
    vSql := vSql + '       (@LoteId    = 0 or Pl.LoteId     = ' +
      pLoteId.ToString + ') ' + #13 + #10;
    vSql := vSql + 'Order by PIt.PedidoId, PIt.PedidoItemId';
    FConexao.Query.SQL.Add(vSql);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoItens.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      While Not FConexao.Query.Eof do
      Begin
        FEntradaItens.EntradaId := FConexao.Query.FieldByName('PedidoId')
          .AsInteger;
        FEntradaItens.EntradaItemId := FConexao.Query.FieldByName
          ('PedidoItemId').AsInteger;
        ObjProdutoDAO := TPRodutoDAO.Create;
        try

          vProdutoId := 0;
          FEntradaItens := TEntradaItens.Create;
          if vProdutoId <> FConexao.Query.FieldByName('ProdutoId').AsInteger
          then
          Begin
            FEntradaItens.ProdutoLotes.Produto :=
              FEntradaItens.ProdutoLotes.Produto.JsonToClass
              (ObjProdutoDAO.GetId(FConexao.Query.FieldByName('ProdutoId')
              .AsString, 0, '0', nil).Items[0].ToString());
            vProdutoId := FConexao.Query.FieldByName('ProdutoId').AsInteger;
          End;
          FEntradaItens.EntradaId := FConexao.Query.FieldByName('PedidoId')
            .AsInteger;
          FEntradaItens.EntradaItemId := FConexao.Query.FieldByName
            ('PedidoItemId').AsInteger;
          FEntradaItens.ProdutoLotes.Lotes.LoteId :=
            FConexao.Query.FieldByName('LoteId').AsInteger;
          FEntradaItens.ProdutoLotes.Lotes.ProdutoId :=
            FConexao.Query.FieldByName('ProdutoId').AsInteger;
          FEntradaItens.ProdutoLotes.Lotes.DescrLote :=
            FConexao.Query.FieldByName('descrLote').AsString;
          FEntradaItens.ProdutoLotes.Lotes.Fabricacao :=
            FConexao.Query.FieldByName('Fabricacao').AsDateTime;
          FEntradaItens.ProdutoLotes.Lotes.Vencimento :=
            FConexao.Query.FieldByName('Vencimento').AsDateTime;
          FEntradaItens.ProdutoLotes.Lotes.DtEntrada :=
            FConexao.Query.FieldByName('DtEntrada').AsDateTime;
          FEntradaItens.ProdutoLotes.Lotes.HrEntrada :=
            FConexao.Query.FieldByName('HrEntrada').AsDateTime;
          FEntradaItens.ProdutoLotes.Lotes.QtdeDisponivel := 0;

          FEntradaItens.QtdXml := FConexao.Query.FieldByName('QtdXml')
            .AsInteger;
          FEntradaItens.QtdCheckIn := FConexao.Query.FieldByName('QtdCheckIn')
            .AsInteger;
          FEntradaItens.QtdDevolvida := FConexao.Query.FieldByName
            ('QtdDevolvida').AsInteger;
          FEntradaItens.QtdSegregada := FConexao.Query.FieldByName
            ('QtdSegregada').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(FEntradaItens,
            [joDateFormatISO8601]));
        finally
          FreeAndNil(ObjProdutoDAO);
        end;
        FConexao.Query.Next;
      End;
  except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TEntradaItensDao.GetEntradaProduto(pEntradaId, pShowErro: Integer) : TjSonArray;
var JsonProduto: TJsonObject;
    ObjProdutoDAO: TPRodutoDAO;
begin
  try
    FConexao.Query.SQL.Add(SqlEntradaProduto);
    FConexao.Query.ParamByName('pPedidoId').Value := pEntradaId;
    If DebugHook <> 0 Then
       FConexao.Query.SQL.SaveToFile('EntradaItensProduto.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception Do
      raise Exception.Create(E.Message);
  end;
end;

function TEntradaItensDao.GetId(pPedidoItemId: Integer): TjSonArray;
var
  vSql: String;
  ObjJson: TJsonObject;
  ObjProdutoDAO: TPRodutoDAO;
  // ObjLote       : TLote;
  vProdutoId: Integer;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEntradaItens;
    if pPedidoItemId <> 0 then
      vSql := vSql + ' Where PedidoItemId = ' + pPedidoItemId.ToString;
    vSql := vSql + 'Order by PIt.PedidoId, PIt.PedidoItemId';
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      While Not FConexao.Query.Eof do
      Begin
        FEntradaItens.EntradaId := FConexao.Query.FieldByName('PedidoId')
          .AsInteger;
        FEntradaItens.EntradaItemId := FConexao.Query.FieldByName
          ('PedidoItemId').AsInteger;
        ObjProdutoDAO := TPRodutoDAO.Create;
        // ObjLote       := TLote.Create;
        vProdutoId := 0;
        FEntradaItens := TEntradaItens.Create;
        if vProdutoId <> FConexao.Query.FieldByName('ProdutoId').AsInteger then
        Begin
          FEntradaItens.ProdutoLotes.Produto :=
            FEntradaItens.ProdutoLotes.Produto.JsonToClass
            (ObjProdutoDAO.GetId(FConexao.Query.FieldByName('ProdutoId')
            .AsString, 0, '0', nil).Items[0].ToString());
          vProdutoId := FConexao.Query.FieldByName('ProdutoId').AsInteger;
        End;
        FEntradaItens.EntradaId := FConexao.Query.FieldByName('PedidoId')
          .AsInteger;
        FEntradaItens.EntradaItemId := FConexao.Query.FieldByName
          ('PedidoItemId').AsInteger;
        FEntradaItens.ProdutoLotes.Lotes.LoteId :=
          FConexao.Query.FieldByName('LoteId').AsInteger;
        FEntradaItens.ProdutoLotes.Lotes.ProdutoId :=
          FConexao.Query.FieldByName('ProdutoId').AsInteger;
        FEntradaItens.ProdutoLotes.Lotes.DescrLote :=
          FConexao.Query.FieldByName('descrLote').AsString;
        FEntradaItens.ProdutoLotes.Lotes.Fabricacao :=
          FConexao.Query.FieldByName('Fabricacao').AsDateTime;
        FEntradaItens.ProdutoLotes.Lotes.Vencimento :=
          FConexao.Query.FieldByName('Vencimento').AsDateTime;
        FEntradaItens.ProdutoLotes.Lotes.DtEntrada :=
          FConexao.Query.FieldByName('DtEntrada').AsDateTime;
        FEntradaItens.ProdutoLotes.Lotes.HrEntrada :=
          FConexao.Query.FieldByName('HrEntrada').AsDateTime;
        FEntradaItens.ProdutoLotes.Lotes.QtdeDisponivel := 0;
        // FConexao.Query.FieldByName('QtdeDisponivel').AsInteger;
        FEntradaItens.QtdXml := FConexao.Query.FieldByName('QtdXml').AsInteger;
        FEntradaItens.QtdCheckIn := FConexao.Query.FieldByName('QtdCheckIn')
          .AsInteger;
        FEntradaItens.QtdDevolvida := FConexao.Query.FieldByName('QtdDevolvida')
          .AsInteger;
        FEntradaItens.QtdSegregada := FConexao.Query.FieldByName('QtdSegregada')
          .AsInteger;
        // FEntradaItens.ProdutoLotes.Lotes.Add(ObjLote);
        {
          FEntradaItens.Lote.ProdutoId  := FConexao.Query.FieldByName('ProdutoId').AsInteger;
          FEntradaItens.Lote.CodigoERP  := FConexao.Query.FieldByName('CodigoERP').AsInteger;
          FEntradaItens.Lote.LoteId     := FConexao.Query.FieldByName('LoteId').AsInteger;
          FEntradaItens.Lote.DescrLote  := FConexao.Query.FieldByName('DescrLote').AsString;
          FEntradaItens.Lote.Fabricacao := FConexao.Query.FieldByName('Fabricacao').AsDateTime;
          FEntradaItens.Lote.Vencimento := FConexao.Query.FieldByName('Vencimento').AsDateTime;
          FEntradaItens.Lote.DtEntrada  := FConexao.Query.FieldByName('DtEntrada').AsDateTime;
          FEntradaItens.Lote.HrEntrada  := FConexao.Query.FieldByName('HrEntrada').AsDateTime;
        }
        Result.AddElement(tJson.ObjectToJsonObject(FEntradaItens,
          [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TEntradaItensDao.GetProdutoTag(aQuery: TDictionary<String, String>)
  : TjSonArray;
Var
  vParamsOk: Integer;
  pPedidoId, pCodigoERP: Integer;
  pDocumentoNr, pRegistroERP: String;
  pDtDocumentoData, pDtCheckInFinalizacao: TDateTime;
begin
  If aQuery.Count <= 0 then
  Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
      'Parâmetros da consulta não definidos!')));
    Exit;
  End;
  pPedidoId := 0;
  pCodigoERP := 0;
  pDocumentoNr := '';
  pRegistroERP := '';
  pDtDocumentoData := 0;
  pDtCheckInFinalizacao := 0;
  vParamsOk := 0;
  if aQuery.ContainsKey('pedidoid') then
  Begin
    pPedidoId := StrToIntDef(aQuery.Items['pedidoid'], 0);
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('codigoerp') then
  Begin
    pCodigoERP := StrToIntDef(aQuery.Items['codigoerp'], 0);
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('documentonr') then
  Begin
    pDocumentoNr := aQuery.Items['documentonr'];
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('registroerp') then
  Begin
    pRegistroERP := aQuery.Items['registroerp'];
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('documentodata') then
  Begin
    Try
      pDtDocumentoData := StrToDate(aQuery.Items['documentodata']);
      vParamsOk := vParamsOk + 1;
    Except Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Data dos Pedidos é inválida!')));
      Exit;
      End;
    End;
  End;
  if aQuery.ContainsKey('dtcheckinfinalizacao') then
  Begin
    Try
      pDtCheckInFinalizacao := StrToDate(aQuery.Items['dtcheckinfinalizacao']);
      vParamsOk := vParamsOk + 1;
    Except Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Data de finalização do CheckIn é inválida!')));
      Exit;
      End;
    End;
  End;
  if vParamsOk <> aQuery.Count then
  Begin  Begin
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
      'Parâmetros da consulta definidos incorretamente!')));
    Exit;
    End;
  End;
  try
    FConexao.Query.SQL.Add(SqlGetProdutoTag);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    if pDtDocumentoData = 0 then
      FConexao.Query.ParamByName('pDtDocumentoData').Value := 0
      // pDtDocumentoData
    Else
      FConexao.Query.ParamByName('pDtDocumentoData').Value :=
        FormatDateTime('YYYY-MM-DD', pDtDocumentoData);
    if pDtCheckInFinalizacao = 0 then
      FConexao.Query.ParamByName('pDtCheckInFinalizacao').Value := 0
      // pDtCheckInFinalizacao
    Else
      FConexao.Query.ParamByName('pDtCheckInFinalizacao').Value :=
        FormatDateTime('YYYY-MM-DD', pDtCheckInFinalizacao);

    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ProdutoTag.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TEntradaItensDao.GetProdutoTagClass(pPedidoId: Integer;
  pDocumentoNr: String; pDtDocumentoData: TDateTime; pRegistroERP: String;
  pDtCheckInFinalizacao: TDateTime; pCodigoERP: Integer; pTagEstoque: Boolean)
  : TjSonArray;
begin
  //
end;

function TEntradaItensDao.InsertUpdate(pPedidoItemId, pPedidoId, pLoteId,
  pQtdXml, pQtdCheckIn, pQtdDevolvida, pQtdSegregada: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pPedidoItemId = 0 then
      vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('
        + pPedidoId.ToString() + ', ' + pLoteId.ToString() + ', ' +
        pQtdXml.ToString() + ', ' + pQtdCheckIn.ToString() + ', ' +
        pQtdDevolvida.ToString() + ', ' + pQtdSegregada.ToString()
    Else
      vSql := ' Update PedidoItens ' + '   Set QtdXml   = ' + pQtdXml.ToString()
        + '   , QtdCheckIn = ' + pQtdCheckIn.ToString() + '   , QtdDevolvida = '
        + pQtdDevolvida.ToString() + '   , QtdSegregada = ' +
        pQtdSegregada.ToString() + ' where EntradaId = ' + pPedidoId.ToString +
        ' and LoteId = ' + pLoteId.ToString();
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TEntradaItensDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.FEntradaItens.EntradaId = 0 then
      vSql := 'Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada) Values ('
        +
      // Self.FEntradaItens.EntradaId.ToString()+', '+Self.FEntradaItens.Lote.LoteId.ToString()+', '+
        Self.FEntradaItens.QtdXml.ToString() + ', ' +
        Self.FEntradaItens.QtdCheckIn.ToString() + ', ' +
        Self.FEntradaItens.QtdDevolvida.ToString() + ', ' +
        Self.FEntradaItens.QtdSegregada.ToString()
    Else
      vSql := ' Update PedidoItens ' + '   Set QtdXml     = ' +
        Self.FEntradaItens.QtdXml.ToString() + '   , QtdCheckIn   = ' +
        Self.FEntradaItens.QtdCheckIn.ToString() + '   , QtdDevolvida = ' +
        Self.FEntradaItens.QtdDevolvida.ToString() + '   , QtdSegregada = ' +
        Self.FEntradaItens.QtdSegregada.ToString() + ' where EntradaId  = ' +
        Self.FEntradaItens.EntradaId.ToString + ' and LoteId = '; // +
    // Self.FEntradaItens.Lote.LoteId.ToString();
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
