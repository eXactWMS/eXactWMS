{
  VolumeEmbalagemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.CargasDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.Types, System.JSON, REST.JSON, System.JSON.Types, FireDAC.Stan.Option,
  System.Generics.Collections, CargasClass, Web.HTTPApp,
  exactwmsservice.lib.utils, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TCargasDAO = class(TBasicDao)
  private
    FCargaDAO: TCargas;
    Function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  Public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(Const pCargaId: Integer; pJsonObject: TJsonObject) : TJSonArray;
    // (pVolumeEmbalagemId : Integer; pDescricao : String; pStatus : Integer ) : TjSonArray;
    function Get(Const AParams: TDictionary<string, string>): TJSonArray;
    Function Get4D(const AParams: TDictionary<string, string>): TJsonObject;
    Function GetCargaCarregarClientes(Const pCarga: Integer): TJSonArray;
    Function GetCargaCarregarPedidos(Const pCarga: Integer): TJSonArray;
    Function GetCargaCarregarVolumes(Const pCarga, pPessoaId: Integer; pProcesso: String): TJSonArray;
    Function Delete(pCargaId: Integer; pJsonObject: TJsonObject): Boolean;
    Function CargaCarregamento(pJsonObject: TJsonObject): TJsonObject;
    Function CargaCarregamentoFinalizar(pJsonObject: TJsonObject): TJsonObject;
    Function CancelarCarregamento(Const pCargaId: Integer): TJsonObject;
    Function CancelarConferencia(Const pCargaId: Integer): TJsonObject;
    Function CancelarCarga(pJsonObject: TJsonObject): TJsonObject;
    Property ObjCarga: TCargas Read FCargaDAO Write FCargaDAO;
    Function GetCargaHearder(pCargaId: Integer): TJSonArray;
    Function GetCargaPessoas(pCargaId: Integer; pProcesso : String): TJSonArray;
    Function GetCargaPedidos(pCargaId, pPessoaId: Integer; pProcesso: String) : TJSonArray;
    Function GetCargaPedidosRomaneio(pCargaId, pPessoaId: Integer; pProcesso: String): TJSonArray;
    Function GetCargaNotaFiscal(pCargaId: Integer): TJSonArray;
    Function GetCargaPedidoVolumes(pCargaId: Integer; pProcesso: String) : TJSonArray;
    Function GetCargaPedidoVolumesConferencia(pCargaId: Integer; pProcesso: String) : TJSonArray;
    Function CargaLista(pCargaId, pRotaId, pProcessoId, pPendente: Integer; pProcesso : String) : TJSonArray;
    Function GetResumoCarga(const AParams: TDictionary<string, string>) : TJSonArray;
    function GetMapaCarga(pCargaId: Integer): TJSonArray;
    Function PedidosParaCargas(Const AParams: TDictionary<string, string>) : TJSonArray;
    Function PedidosParaCargasNFs(Const AParams: TDictionary<string, string>) : TJSonArray;
    Function GetRelAnaliseConsolidada(Const AParams : TDictionary<string, string>): TJSonArray;
    Function PutAtualizarStatus(Const pJsonObjectCargas: TJsonObject) : TJSonArray;
    Function GetConfereCargaBody(Const AParams : TDictionary<string, string>): TJSonArray;
    Function GetConfereCargaHeader(Const AParams : TDictionary<string, string>): TJSonArray;
    Function GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem : Integer) : TJsonArray;

    Function IntegracaoImportaCarga(const AParams : TDictionary<string, string>): TJSonArray;
    Function IntegracaoListaCarga(const AParams : TDictionary<string, string>): TJSonArray;

  end;

implementation

uses Constants, System.Math; //uSistemaControl,

{ TClienteDao }

function TCargasDAO.CancelarCarga(pJsonObject: TJsonObject): TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.connection.StartTransaction;
      Query.SQL.Add('Declare @CargaId Integer = :pCargaId');
      Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Cargas where CargaId = @CargaId)');
      Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      Query.ParamByName('pCargaId').Value := pJsonObject.GetValue<Integer>('cargaid');
      Query.ParamByName('pProcessoId').Value := 21;
      Query.ParamByName('pUsuarioId').Value := pJsonObject.GetValue<Integer>('usuarioid');
      Query.ParamByName('pTerminal').Value := pJsonObject.GetValue<String>('terminal', '');
      Query.Sql.Add('Delete CargaPedidos Where CargaId = @CargaId');
      Query.Sql.Add('Delete CargaCarregamento Where CargaId = @CargaId');
      Query.ExecSQL(vSql);
      Query.connection.Commit;
      Result := TJsonObject.Create.AddPair('Ok', '200');
    Except ON E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Tabela: CancelarCarregamento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.CancelarCarregamento(const pCargaId: Integer): TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Delete from CargaCarregamento where CargaId = '+pCargaId.ToString + ' and Processo = ' + QuotedStr('CA'));
      Query.SQL.Add('Update CargaPedidos Set Conferido = 0 Where CargaId = '+pCargaId.ToString);
      Query.ExecSQL(vSql);
      Result := TJsonObject.Create.AddPair('Ok', '200');
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: CancelarCarregamento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.CancelarConferencia(const pCargaId: Integer): TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Delete from CargaCarregamento where CargaId = '+pCargaId.ToString + ' and Processo = ' + QuotedStr('CO'));
      Query.SQL.Add('Update CargaPedidos Set Conferido = 0 Where CargaId = '+pCargaId.ToString);
      Query.SQL.Add('Delete De From DocumentoEtapas De');
      Query.SQL.Add('Inner Join Cargas C On C.Uuid = De.Documento');
      Query.SQL.Add('Where C.CargaId = '+pCargaId.ToString()+' and processoId > 16');
      Query.ExecSQL(vSql);
      Result := TJsonObject.Create.AddPair('Ok', '200');
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: CancelarConferência - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.CargaCarregamento(pJsonObject: TJsonObject): TJsonObject;
var vSql: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Declare @CargaId Integer = ' + pJsonObject.GetValue<Integer>('cargaid').ToString() + sLineBreak +
              'Declare @PedidoVolumeId Integer = ' + pJsonObject.GetValue<Integer>('pedidovolumeid').ToString() + sLineBreak+
              'Declare @PedidoId Integer = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId)' + sLineBreak +
              'Insert Into CargaCarregamento (Cargaid, PedidoVolumeId, UsuarioId, Data, Hora, Terminal, Processo) Values ('+sLineBreak+
              pJsonObject.GetValue<Integer>('cargaid').ToString() + ', ' + pJsonObject.GetValue<Integer>('pedidovolumeid').ToString() + ', ' +
              pJsonObject.GetValue<Integer>('usuarioid').ToString() + ', ' + ' GetDate(), GetDate(), ' +
              QuotedStr(pJsonObject.GetValue<String>('terminal')) + ', ' + QuotedStr(pJsonObject.GetValue<String>('processo')) + ')';
      Query.SQL.Add(vSql);
      Query.SQL.Add('Update Cp Set Conferido = 1');
      Query.SQL.Add('From CargaPedidos Cp');
      Query.SQL.Add('Left Join (select Pv.PedidoId, Count(Pv.PedidoVolumeId) TVlmPendente'); //, Pv.PedidoVolumeId, CC.PedidoVolumeId VlmConferido');
      Query.SQL.Add('			        From PedidoVolumes Pv');
      Query.SQL.Add('			        inner Join vDocumentoEtapas De ON De.Documento = Pv.Uuid');
      Query.SQL.Add('			        Left Join CargaCarregamento CC On Cc.PedidoVolumeId = Pv.PedidoVolumeId');
      Query.SQL.Add('			        where DE.ProcessoId = (Select Max(ProcessoId) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)');
      Query.SQL.Add('			        And De.ProcessoId <> 15 and CC.PedidoVOlumeId is Null');
      Query.SQL.Add('              Group by Pv.PedidoId) CC On Cc.PedidoId = Cp.PedidoId ');
      Query.SQL.Add('where Cp.CargaId = @CargaId and Cp.PedidoId = @PedidoId and isNull(CC.TVlmPendente, 0) = 0');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaCarregamento.Sql');
      Query.ExecSQL;
      Result := TJsonObject.Create.AddPair('Ok', '200');
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: CargaCarregamento - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.CargaCarregamentoFinalizar(pJsonObject: TJsonObject) : TJsonObject;
var Sql: String;
    vProcessoId: Integer;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pJsonObject.GetValue<String>('operacao') = 'CO' then Begin
         vProcessoId := 17;
         Query.SQL.Add('Update CargaPedidos Set Conferido = 0 ');
         Query.SQL.Add('Where CargaId = '+pJsonObject.GetValue<Integer>('cargaid').ToString());
         Query.SQL.Add('Update Cargas Set Conferencia = 1 ');
         Query.SQL.Add('Where CargaId = '+pJsonObject.GetValue<Integer>('cargaid').ToString());
      End
      Else Begin
         vProcessoId := 17;
         Query.SQL.Add('Update De Set Status = 0');
         Query.SQL.Add('From CargaPedidos Cp');
         Query.SQL.Add('Inner join Pedido Ped on Ped.PedidoId = Cp.PedidoId');
         Query.SQL.Add('Inner Join DocumentoEtapas De On De.Documento = Ped.Uuid');
         Query.SQL.Add('Where Cp.CargaId = '+pJsonObject.GetValue<Integer>('cargaid').ToString());
         Query.SQL.Add('  And De.ProcessoId in (17, 18) and De.Status = 1');
         Query.SQL.Add('Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId, ');
         Query.SQL.Add('DataId, HoraId, DataHora, Terminal, Status)');
         Query.SQL.Add('Select (Select uuid From Pedido where PedidoId = CP.PedidoId), 17, ');
         Query.SQL.Add('        '+pJsonObject.GetValue<Integer>('usuarioid').ToString());
         Query.SQL.Add('       , (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), ');
         Query.SQL.Add('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))');
         Query.SQL.Add('       , GETDATE(), ' + QuotedStr(pJsonObject.GetValue<String>('terminal'))+', 1');
         Query.SQL.Add('From cargaPedidos CP ');
         Query.SQL.Add('Where CP.cargaid = '+pJsonObject.GetValue<Integer>('cargaid').ToString());
         Query.SQL.Add('Update DocumentoEtapas Set Status = 0');
         Query.SQL.Add('Where Documento = (Select Uuid From Cargas');
         Query.SQL.Add('                   Where CargaId = '+pJsonObject.GetValue<Integer>('cargaid').ToString()+')');
         Query.SQL.Add('  And Status = 1');
         if pJsonObject.GetValue<String>('operacao') = 'CO' then
            Query.SQL.Add('  And ProcessoId = '+vProcessoId.ToString())
         Else
            Query.SQL.Add('  And ProcessoId in (17,18)');
         //Registrar Carga Concluída
         Query.SQL.Add('Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId,');
         Query.SQL.Add('                             DataId, HoraId, DataHora, Terminal, Status)');
         Query.SQL.Add('       Values ((Select uuid From Cargas ');
         Query.SQL.Add('                where CargaId = ' +pJsonObject.GetValue<Integer>('cargaid').ToString()+'), ');
         Query.SQL.Add('               '+vProcessoId.ToString() + ', ');
         Query.SQL.Add('               '+pJsonObject.GetValue<Integer>('usuarioid').ToString()+', ');
         Query.SQL.Add('                (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), ');
         Query.SQL.Add('                (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), ');
         Query.SQL.Add('                GETDATE(), '+QuotedStr(pJsonObject.GetValue<String>('terminal')) + ', 1)');
         //Registrar Carga Em Trânsito
         if pJsonObject.GetValue<String>('operacao') = 'CA' then Begin
            Query.SQL.Add('If (select CargaEmTransito from configuracao) = 1 Begin');
            Query.SQL.Add('   Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId,');
            Query.SQL.Add('                                DataId, HoraId, DataHora, Terminal, Status)');
            Query.SQL.Add('          Values ((Select uuid From Cargas ');
            Query.SQL.Add('                   where CargaId = ' +pJsonObject.GetValue<Integer>('cargaid').ToString()+'), 18, ');
            Query.SQL.Add('                  '+pJsonObject.GetValue<Integer>('usuarioid').ToString()+', ');
            Query.SQL.Add('                   (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), ');
            Query.SQL.Add('                   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), ');
            Query.SQL.Add('                   GETDATE(), '+QuotedStr(pJsonObject.GetValue<String>('terminal')) + ', 1)');
            Query.SQL.Add('End;');
         End;
      End;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaCarregamentoFinalizar.Sql');
      Query.ExecSQL;
      Result := TJsonObject.Create.AddPair('Ok', '200');
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: CargaCarregamentoFinalizar - ' + TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

constructor TCargasDAO.Create;
begin
  ObjCarga := TCargas.Create;
  inherited;
end;

function TCargasDAO.Delete(pCargaId: Integer; pJsonObject: TJsonObject) : Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add('Declare @CargaId Integer = ' + pCargaId.ToString);
      Query.SQL.Add('select CC.IdMin, De.Processoid, De.Descricao Processo, C.*');
      Query.SQL.Add('From Cargas C');
      Query.SQL.Add('Left Join vDocumentoEtapas DE On De.Documento = C.uuid');
      Query.SQL.Add('Left Join (Select CargaId, Min(CarregamentoId) IdMin');
      Query.SQL.Add('           From CargaCarregamento');
      Query.SQL.Add('           Group by CargaId) Cc ON Cc.CargaId = C.CargaId');
      Query.SQL.Add('Where C.CargaId = @CargaId');
      Query.SQL.Add('  And De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = C.Uuid ) ');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargasDelete.Sql');
      Query.Open;
      if (Query.FieldByName('ProcessoId').AsInteger > 16) then Begin
         Result := False;
         raise Exception.Create('Não é possível Cancelar a Carga. Processo Atual: '+
                                Query.FieldByName('Processo').AsString);
      End
      Else if (Not Query.IsEmpty) and (Query.FieldByName('IdMin').AsInteger > 0) then Begin
         raise Exception.Create('Abortar Conferência/Carregamento antes de Excluir!');
      End
      Else if (Not Query.IsEmpty) and (Query.FieldByName('IdMin').AsInteger = 0) then Begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Update De Set Status = 0');
        Query.SQL.Add('From DocumentoEtapas De');
        Query.SQL.Add('Inner join Cargas C On C.Uuid = De.Documento');
        Query.SQL.Add('Where C.CargaId = '+pCargaId.ToString);
        Query.SQL.Add('Delete CargaPedidos where CargaId = '+pCargaId.ToString);
        Query.SQL.Add('Delete CargaCarregamento where CargaId = '+pCargaId.ToString);
        Query.SQL.Add('Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId,');
        Query.SQL.Add('       DataId, HoraId, DataHora, Terminal, Status)');
        Query.SQL.Add('       Select C.Uuid, 31, '+pJsonObject.GetValue<Integer>('usuarioid').ToString());
        Query.SQL.Add('            , (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)) ');
        Query.SQL.Add('            , (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GETDATE(),');
        Query.SQL.Add('              '+QuotedStr(pJsonObject.GetValue<String>('terminal')) + ', 1 ');
        Query.SQL.Add('from cargas C ');
        Query.SQL.Add('Where C.cargaid = ' + pCargaId.ToString);
        if DebugHook <> 0 then
           Query.SQL.SaveToFile('CargaExcluir.Sql');
        Query.ExecSQL;
        Result := True;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create(E.Message);
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TCargasDAO.Destroy;
begin
  ObjCarga.Free;
  inherited;
end;

function TCargasDAO.Get(const AParams: TDictionary<string, string>): TJSonArray;
var vQuery, vQryPed: TFDQuery;
    JsonCargas: TJsonObject;
begin
  Result  := TJSonArray.Create();
  vQuery  := TFDQuery.Create(nil);
  vQryPed := TFdQuery.Create(Nil);
  Try
    vQuery.Connection  := Connection;
    vQryPed.Connection := Connection;
    Try
      vQuery.SQL.Add(TuEvolutConst.SqlGetCargas);
      if AParams.ContainsKey('id') then begin
         //vQuery.SQL.Add('and (@CargaId = 0 or C.cargaid = @CargaId)');
         vQuery.ParamByName('pCargaid').AsLargeInt := AParams.Items['id'].ToInt64;
      end;
      if AParams.ContainsKey('datainicial') then begin
    //     vQuery.SQL.Add('and C.DtInclusao >= :datainicial');
         vQuery.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']));
      end
      Else
         vQuery.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then begin
    //     vQuery.SQL.Add('and C.DtInclusao <= :datafinal');
         vQuery.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']));
      end
      Else
         vQuery.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('rotaid') then begin
         //vQuery.SQL.Add('and C.Rotaid = :rotaid');
         vQuery.ParamByName('protaid').AsInteger := AParams.Items['rotaid'].Tointeger;
      end
      Else
         vQuery.ParamByName('protaid').AsInteger := 0;
      if AParams.ContainsKey('rotaidfinal') then
         vQuery.ParamByName('protaidfinal').AsInteger := AParams.Items['rotaidfinal'].Tointeger
      else
         vQuery.ParamByName('protaidfinal').AsInteger := 0;
      if AParams.ContainsKey('rota') then begin
         vQuery.SQL.Add('and R.Descricao like :rota');
         vQuery.ParamByName('rota').AsString := '%' + AParams.Items['rota'] + '%';
      end;
      if AParams.ContainsKey('transportadoraid') then begin
         vQuery.SQL.Add('and C.transportadoraid = :tranportadoraid');
         vQuery.ParamByName('transportadoraid').AsInteger := AParams.Items['transportadoraid'].Tointeger;
      end;
      if AParams.ContainsKey('transportadora') then begin
         vQuery.SQL.Add('and T.Razao Like :transportadora');
         vQuery.ParamByName('Transportadora').AsString := '%' + AParams.Items['transportadora'] + '%';
      end;
      if AParams.ContainsKey('veiculoid') then begin
         vQuery.SQL.Add('and C.veiculoid = :veiculoid');
         vQuery.ParamByName('veiculoid').AsInteger := AParams.Items['veiculoid'].Tointeger;
      end;
      if AParams.ContainsKey('placa') then begin
         vQuery.SQL.Add('and V.Placa = :placa');
         vQuery.ParamByName('placa').AsString := AParams.Items['placa'];
      end;
      if AParams.ContainsKey('motoristaid') then begin
         vQuery.SQL.Add('and C.motoristaid = :motoristaid');
         vQuery.ParamByName('motoristaid').AsInteger := AParams.Items['motoristaid'].Tointeger;
      end;
      if AParams.ContainsKey('motorista') then begin
         vQuery.SQL.Add('and M.Razao like :motorista');
         vQuery.ParamByName('motorista').AsString := '%' + AParams.Items['motorista'] + '%';
      end;
      if AParams.ContainsKey('status') then begin
         vQuery.SQL.Add('and C.Status = :Status');
         vQuery.ParamByName('status').AsInteger := AParams.Items['status'].Tointeger;
      end;
      if AParams.ContainsKey('processoid') then begin
         //vQuery.SQL.Add('and De.Processoid = :processoid');
         vQuery.ParamByName('pprocessoid').AsInteger := StrToIntDef(AParams.Items['processoid'], 0);
      end;
      if AParams.ContainsKey('processo') then begin
         vQuery.SQL.Add('and De.Processo = :processo');
         vQuery.ParamByName('processo').AsString := AParams.Items['processo'];
      end;
      if AParams.ContainsKey('limit') then begin
         vQuery.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
         vQuery.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
      end;
      if AParams.ContainsKey('offset') then
         vQuery.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
      if AParams.ContainsKey('processoid') then
         vQuery.ParamByName('pProcessoId').AsLargeInt := AParams.Items['processoid'].ToInt64
      Else
         vQuery.ParamByName('pProcessoId').AsLargeInt := 0;
      vQuery.SQL.Add('order by CargaId');
      if DebugHook <> 0 then
         vQuery.SQL.SaveToFile('Cargas.Sql');
      vQuery.Open();
      if vQuery.IsEmpty then
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      Else
      begin
        vQryPed.SQL.Add('Select C.CargaPedidoId, C.CargaId, C.PedidoId, P.PessoaId, P.DocumentoNr, Rd.Data as Data');
        vQryPed.SQL.Add('From CargaPedidos C');
        vQryPed.SQL.Add('Inner Join Pedido P On P.PedidoId = C.PedidoId');
        vQryPed.SQL.Add('Inner join Rhema_Data RD ON Rd.IdData = P.DocumentoData');
        vQryPed.SQL.Add('Where C.CargaId = :pCargaId');
        while Not vQuery.Eof do Begin
          JsonCargas := TJsonObject.Create();
          JsonCargas.AddPair('cargaid', TJsonNumber.Create(vQuery.FieldByName('cargaid').AsInteger));
          JsonCargas.AddPair('rotaid', TJsonNumber.Create(vQuery.FieldByName('rotaid').AsInteger));
          JsonCargas.AddPair('rota', vQuery.FieldByName('rota').AsString);
          JsonCargas.AddPair('transportadoraid', TJsonNumber.Create(vQuery.FieldByName('transportadoraid').AsInteger));
          JsonCargas.AddPair('transportadora', vQuery.FieldByName('Transportadora').AsString);
          JsonCargas.AddPair('veiculoid', TJsonNumber.Create(vQuery.FieldByName('veiculoid').AsInteger));
          JsonCargas.AddPair('placa', vQuery.FieldByName('placa').AsString);
          JsonCargas.AddPair('modelo', vQuery.FieldByName('modelo').AsString);
          JsonCargas.AddPair('marca', vQuery.FieldByName('marca').AsString);
          JsonCargas.AddPair('cor', vQuery.FieldByName('cor').AsString);
          JsonCargas.AddPair('motoristaid', TJsonNumber.Create(vQuery.FieldByName('motoristaid').AsInteger));
          JsonCargas.AddPair('motorista', vQuery.FieldByName('Motorista').AsString);
          JsonCargas.AddPair('usuarioid', TJsonNumber.Create(vQuery.FieldByName('usuarioid').AsInteger));
          JsonCargas.AddPair('usuario', vQuery.FieldByName('usuario').AsString);
          JsonCargas.AddPair('dtinclusao', vQuery.FieldByName('dtinclusao').AsString);
          JsonCargas.AddPair('hrinclusao', vQuery.FieldByName('hrinclusao').AsString);
          JsonCargas.AddPair('status', TJsonNumber.Create(vQuery.FieldByName('status').AsInteger));
          JsonCargas.AddPair('uuid', vQuery.FieldByName('uuid').AsString);
          JsonCargas.AddPair('conferencia', TJsonNumber.Create(vQuery.FieldByName('Conferencia').AsInteger));
          JsonCargas.AddPair('processoid', TJsonNumber.Create(vQuery.FieldByName('ProcessoId').AsInteger));
          JsonCargas.AddPair('processo', vQuery.FieldByName('processo').AsString);
          JsonCargas.AddPair('emconferencia', vQuery.FieldByName('EmConferencia').AsString);
          JsonCargas.AddPair('carregando', vQuery.FieldByName('carregando').AsString);
          JsonCargas.AddPair('statusoper', TJsonNumber.Create(vQuery.FieldByName('StatusOper').AsInteger));
          JsonCargas.AddPair('tpedido', TJsonNumber.Create(vQuery.FieldByName('TPedido').AsInteger));
          JsonCargas.AddPair('tvolume', TJsonNumber.Create(vQuery.FieldByName('TVolume').AsInteger));
          JsonCargas.AddPair('tunidade', TJsonNumber.Create(vQuery.FieldByName('TUnidade').AsInteger));
          vQryPed.Close;
          vQryPed.ParamByName('pCargaId').Value := vQuery.FieldByName('cargaid').AsInteger;
          vQryPed.Open;
          JsonCargas.AddPair('pedidos', vQryPed.ToJSONArray());
          Result.AddElement(JsonCargas);
          vQuery.Next;
          JsonCargas := Nil;
        End;
      End;
    Except On E: Exception Do
      Raise Exception.Create('Processo: CargaGet - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
   vQuery.Free;
   vQryPed.Free;
  End;
end;

function TCargasDAO.Get4D(const AParams: TDictionary<string, string>) : TJsonObject;
Var QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  QryPesquisa    := TFdQuery.Create(Nil);
  QryRecordCount := TFdQuery.Create(Nil);
  Try
    Try
      QryPesquisa.Connection := Connection;
      QryPesquisa.SQL.Add(TuEvolutConst.SqlGetCargas);
      QryRecordCount.Connection := Connection;
      QryRecordCount.SQL.Add('Declare @ProcessoId Integer = :pProcessoId');
      QryRecordCount.SQL.Add('Select Count(C.CargaId) cReg');
      QryRecordCount.SQL.Add('from Cargas C');
      QryRecordCount.SQL.Add('Left Join vDocumentoEtapas DE On De.Documento = C.Uuid and');
      QryRecordCount.SQL.Add('                                 De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
      QryRecordCount.SQL.Add('Inner join Rotas R On R.RotaId = C.RotaId');
      QryRecordCount.SQL.Add('Left Join Pessoa T ON T.PessoaId = C.transportadoraid');
      QryRecordCount.SQL.Add('Inner Join Pessoa M On M.Pessoaid = C.motoristaid');
      QryRecordCount.SQL.Add('Inner Join Veiculos V ON V.VeiculoId = C.veiculoid');
      QryRecordCount.SQL.Add('Inner Join usuarios U On U.UsuarioId = C.Usuarioid');
      QryRecordCount.SQL.Add('Where (@ProcessoId = 0 or @ProcessoId = DE.ProcessoId)');
      if AParams.ContainsKey('cargaid') then begin
         // qryPesquisa.SQL.Add('and C.CargaId = :Cargaid');
         QryPesquisa.ParamByName('pCargaId').AsLargeInt   := AParams.Items['cargaid'].ToInt64;
         QryRecordCount.SQL.Add('and C.CargaId = :Cargaid');
         QryRecordCount.ParamByName('CargaId').AsLargeInt := AParams.Items['cargaid'].ToInt64;
      end
      Else
         QryPesquisa.ParamByName('pCargaId').AsLargeInt := 0;
      if AParams.ContainsKey('status') then begin
         QryPesquisa.SQL.Add('and Status = :Status');
         QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status'].Tointeger;
         QryRecordCount.SQL.Add('and Status = :Status');
         QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status'].Tointeger;
      end;
      if AParams.ContainsKey('processoid') then begin
         QryPesquisa.ParamByName('pProcessoId').AsInteger := AParams.Items['processoid'].Tointeger;
         QryRecordCount.ParamByName('pProcessoId').AsInteger := AParams.Items['processoid'].Tointeger;
      end
      Else Begin
         QryPesquisa.ParamByName('pProcessoId').AsInteger    := 0;
         QryRecordCount.ParamByName('pProcessoId').AsInteger := 0;
      End;
      if AParams.ContainsKey('limit') then begin
         QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
         QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
      end;
      if AParams.ContainsKey('offset') then
         QryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
      QryPesquisa.SQL.Add('order by CargaId Desc');
      if DebugHook <> 0 then
         QryPesquisa.SQL.SaveToFile('Cargas4D.Sql');
      QryPesquisa.Open();
      Result.AddPair('data', QryPesquisa.ToJSONArray());
      QryRecordCount.Open();
      Result.AddPair('records', TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
    Except On E: Exception do
      Raise Exception.Create('Processo: CargaGet4D - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    QryPesquisa.Free;
    QryRecordCount.Free;
  End;
end;

function TCargasDAO.GetCargaAnaliseCubagemPorProduto(pCargaId, pEmbalagem: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlCargaAnaliseCubagemPorProduto);
      Query.ParamByName('pCargaId').Value   := pCargaId;
      Query.ParamByName('pEmbalagem').Value := pEmbalagem;
      If DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaAnaliseCubagem.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do Begin
       Raise Exception.Create('Processo: CargaGetCargaAnaliseCubagemPorProduto - '+TUtil.TratarExcessao(E.Message));
       End;
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaCarregarClientes(const pCarga: Integer): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
    Query.SQL.Add(TuEvolutConst.SqlCargaCarregarCliente);
    Query.ParamByName('CargaId').Value := pCarga;
    Query.Open();
    if Query.IsEmpty then
    Begin
      Result := TJSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := Query.ToJSONArray();
    Except On E: Exception Do
      Raise Exception.Create('Processo: GetCargaCarregarClientes - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaCarregarPedidos(const pCarga: Integer): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
    Query.SQL.Add(TuEvolutConst.SqlCargaCarregarPedido);
    Query.ParamByName('CargaId').Value := pCarga;
    Query.SQL.SaveToFile('CargaCarregarPedidos.Sql');
    Query.Open();
    if Query.IsEmpty then
    Begin
      Result := TJSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
      Result := Query.ToJSONArray();
    Except On E: Exception Do
      Raise Exception.Create('Processo: GetCargaCarregarPeidos - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaCarregarVolumes(const pCarga, pPessoaId: Integer;
  pProcesso: String): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add(TuEvolutConst.SqlCargaCarregarVolumes);
      Query.ParamByName('pCargaId').Value := pCarga;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pProcesso').Value := pProcesso;
      Query.Open();
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('CargaCarregarPedidos.Sql');
      if Query.IsEmpty then Begin
        Result := TJSonArray.Create();
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception Do
      Raise Exception.Create('Processo: CargaCarregarVolumes - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaHearder(pCargaId: Integer): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetCargaHeader);
      Query.ParamByName('pCargaId').Value := pCargaId;
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('CargaHearder.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TJSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception Do
      Raise Exception.Create('Processo: GetCargaHeader - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaNotaFiscal(pCargaId: Integer): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add('Declare @CargaId Integer = :pCargaId');
      Query.SQL.Add('Select Cp.CargaId, PNF.*');
      Query.SQL.Add('From CargaPedidos Cp');
      Query.SQL.Add('Inner join PedidoNotaFiscal PNF On PNF.PedidoId = Cp.PedidoId');
      Query.SQL.Add('where Cp.CargaId = @CargaId');
      Query.SQL.Add('Order by PedidoId, NotaFiscal');
      Query.ParamByName('pCargaId').Value := pCargaId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaNotaFiscal.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: GetCargaNotaFiscal - '+TUtil.TratarExcessao(E.Message));
      End;
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaPedidos(pCargaId, pPessoaId: Integer; pProcesso: String): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidos);
      Query.ParamByName('pCargaId').Value := pCargaId;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pProcesso').Value := pProcesso;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaPedidos.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TJSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception Do
      Raise Exception.Create('Processo: GetCargaPedidos - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
End;
// Function semelhante a anterior(GetCargaPedidos). porém trabalhando com multiplas NF
function TCargasDAO.GetCargaPedidosRomaneio(pCargaId, pPessoaId: Integer;
  pProcesso: String): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidos);
      Query.ParamByName('pCargaId').Value  := pCargaId;
      Query.ParamByName('pPessoaId').Value := pPessoaId;
      Query.ParamByName('pProcesso').Value := pProcesso;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaPedidosRomaneio.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TJSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Raise Exception.Create('Processo: GetCargaPedidosRomaneio - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaPedidoVolumes(pCargaId: Integer; pProcesso: String) : TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidoVolumes);
      Query.ParamByName('pCargaId').Value := pCargaId;
      Query.ParamByName('pProcesso').Value := pProcesso;
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('CargaPedidoVolumes.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Raise Exception.Create('Processo: GetCargaPedidoVolumes - '+Tutil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaPedidoVolumesConferencia(pCargaId: Integer; pProcesso: String) : TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidoVolumesConferencia);
      Query.ParamByName('pCargaId').Value := pCargaId;
      Query.ParamByName('pProcesso').Value := pProcesso;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaPedidoVolumesConferencia.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      Raise Exception.Create('Processo: GetCargaPedidoVolumesConferencia - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetMapaCarga(pCargaId: Integer): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetMapaCarga);
      Query.ParamByName('pCargaId').Value := pCargaId;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('MapaCarga.Sql');
      Query.Open();
      if Query.IsEmpty then
      Begin
        Result := TJSonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except ON E: Exception do
      Raise Exception.Create('Processo: GetMapaCarga - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetRelAnaliseConsolidada(const AParams : TDictionary<string, string>): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelCargaAnaliseConsolidada);
      if AParams.ContainsKey('datainicial') then
        Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
        Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
        Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
        Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('rotainicialid') then
        Query.ParamByName('pRotaInicial').AsInteger := AParams.Items['rotainicialid'].Tointeger
      Else
        Query.ParamByName('pRotaInicial').AsInteger := 0;
      if AParams.ContainsKey('rotafinalid') then
        Query.ParamByName('pRotaFinal').AsInteger := AParams.Items['rotafinalid'].Tointeger
      Else
        Query.ParamByName('pRotaFinal').AsInteger := 0;
      if AParams.ContainsKey('zonaid') then
        Query.ParamByName('pZonaId').AsInteger := AParams.Items['zonaid'].Tointeger
      Else
        Query.ParamByName('pZonaId').AsInteger := 0;
      if AParams.ContainsKey('codpessoa') then
        Query.ParamByName('pCodPessoa').AsInteger := AParams.Items['codpessoa'].Tointeger
      Else
        Query.ParamByName('pCodPessoa').AsInteger := 0;
      if AParams.ContainsKey('somenteexpedido') then
        Query.ParamByName('pSomenteExpedido').Value := AParams.Items['somenteexpedido'].Tointeger()
      Else
        Query.ParamByName('pSomenteExpedido').Value := 0;
      if AParams.ContainsKey('ordem') then
        Query.ParamByName('pOrdem').Value := AParams.Items['ordem'].Tointeger()
      Else
        Query.ParamByName('pOrdem').Value := 0;
      // if AParams.ContainsKey('limit') then begin
      // Query.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
      // Query.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
      // end;
      // if AParams.ContainsKey('offset') then
      // Query.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('CargaAnaliseConsolidada.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
        Result := TJSonArray.Create();
        Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      begin
        Raise Exception.Create('Processo: GetAnaliseConsolidada - '+TUtil.TratarExcessao(E.Message));
      end;
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetResumoCarga(const AParams: TDictionary<string, string>) : TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelCargaResumo);
      if AParams.ContainsKey('datainicial') then
        Query.ParamByName('pdatainicial').Value :=
          FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
        Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
        Query.ParamByName('pdatafinal').Value :=
          FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
        Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('rotainicial') then
        Query.ParamByName('pRotaIdInicial').AsInteger :=
          AParams.Items['rotainicial'].Tointeger
      Else
        Query.ParamByName('pRotaIdInicial').AsInteger := 0;
      if AParams.ContainsKey('rotafinal') then
        Query.ParamByName('pRotaIdFinal').AsInteger :=
          AParams.Items['rotafinal'].Tointeger
      Else
        Query.ParamByName('pRotaIdFinal').AsInteger := 0;
      if AParams.ContainsKey('processoid') then
        Query.ParamByName('pProcessoId').AsInteger :=
          AParams.Items['processoid'].Tointeger
      Else
        Query.ParamByName('pProcessoId').AsInteger := 0;
      if (AParams.ContainsKey('pendente')) and
        (AParams.Items['pendente'].Tointeger = 1) then
        Query.ParamByName('pPendente').AsInteger :=
          AParams.Items['pendente'].Tointeger
      Else
        Query.ParamByName('pPendente').AsInteger := 0;
      Query.Open();
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('ResumoCarga.Sql');
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      begin
        Raise Exception.Create('Processo: GetResumoCarga - '+TUtil.TratarExcessao(E.Message));
      end;
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetCargaPessoas(pCargaId: Integer; pProcesso : String): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetCargaPessoas);
      Query.ParamByName('pCargaId').Value  := pCargaId;
      Query.ParamByName('pProcesso').Value := pProcesso;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargaPessoas.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except On E: Exception do
      begin
        Raise Exception.Create('Processo: GetCargaPessoas - '+TUtil.TratarExcessao(E.Message));
      end;
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetConfereCargaBody(
  const AParams: TDictionary<string, string>): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetConfereCargaBody);
      if AParams.ContainsKey('cargaidinicial') then
         Query.ParamByName('pcargaidinicial').Value := StrtoInt(AParams.Items['cargaidinicial'])
      Else
         Query.ParamByName('pcargaidinicial').Value := 0;
      if AParams.ContainsKey('cargaidfinal') then
         Query.ParamByName('pcargaidfinal').Value := StrtoInt(AParams.Items['cargaidfinal'])
      Else
         Query.ParamByName('pcargaidfinal').Value := 0;
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;

      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('rotaidinicial') then
         Query.ParamByName('protaidinicial').AsInteger := AParams.Items['rotaidinicial'].Tointeger
      Else
         Query.ParamByName('protaidinicial').AsInteger := 0;
      if AParams.ContainsKey('rotaidfinal') then
         Query.ParamByName('protaidfinal').AsInteger := AParams.Items['rotaidfinal'].Tointeger
      Else
         Query.ParamByName('protaidfinal').AsInteger := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('GetConfereCargaBody.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do Begin
      raise Exception.Create('Processo: GetConferenciaBody - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.GetConfereCargaHeader(
  const AParams: TDictionary<string, string>): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlGetConfereCargaHeader);
      if AParams.ContainsKey('cargaidinicial') then
         Query.ParamByName('pcargaidinicial').Value := StrtoInt(AParams.Items['cargaidinicial'])
      Else
         Query.ParamByName('pcargaidinicial').Value := 0;
      if AParams.ContainsKey('cargaidfinal') then
         Query.ParamByName('pcargaidfinal').Value := StrtoInt(AParams.Items['cargaidfinal'])
      Else
         Query.ParamByName('pcargaidfinal').Value := 0;
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;

      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('rotaidinicial') then
         Query.ParamByName('protaidinicial').AsInteger := AParams.Items['rotaidinicial'].Tointeger
      Else
         Query.ParamByName('protaidinicial').AsInteger := 0;
      if AParams.ContainsKey('rotaidfinal') then
         Query.ParamByName('protaidfinal').AsInteger := AParams.Items['rotaidfinal'].Tointeger
      Else
         Query.ParamByName('protaidfinal').AsInteger := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('GetConfereCargaHeader.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do Begin
      raise Exception.Create('Processo: GetConferenciaHeader - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

Function TCargasDAO.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

Function TCargasDAO.InsertUpdate(Const pCargaId: Integer;
  pJsonObject: TJsonObject): TJSonArray;
var
  vSql: String;
  vCargaId, xPed: Integer;
  vGuuid: string;
  vCompl, vListaPedidos: String;
  Query : TFdQuery;
  Function MontaValor2(pValor: Single): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Query.connection.StartTransaction;
    try
      ObjCarga.CargaId := pJsonObject.GetValue<Integer>('cargaid');
      ObjCarga.Rotaid := pJsonObject.GetValue<Integer>('rotaid');
      ObjCarga.Transportadora.PessoaId := pJsonObject.GetValue<Integer>
        ('transportadoraid');
      ObjCarga.Veiculo.VeiculoId := pJsonObject.GetValue<Integer>('veiculoid');
      ObjCarga.Motorista.PessoaId := pJsonObject.GetValue<Integer>('motoristaid');
      ObjCarga.Usuarioid := pJsonObject.GetValue<Integer>('usuarioid');
      ObjCarga.Status := pJsonObject.GetValue<Integer>('status');
      // ObjCargaDAO := tJson.JsonToObject<tCargas>(pJsonObject.ToString(), [joDateIsUTC, joDateFormatISO8601]);
      if pCargaId = 0 then
      Begin
        vGuuid := TGUID.NewGuid.ToString() + sLineBreak;
        Query.SQL.Add('Insert Into Cargas (rotaid, transportadoraid,	veiculoid,	');
        Query.SQL.Add('       motoristaid, dtinclusao,	hrinclusao,	usuarioid,	status, uuid, Conferencia)');
        Query.SQL.Add('Values (' + ObjCarga.Rotaid.ToString() + ', ' );
        Query.SQL.Add('        '+IfThen(ObjCarga.Transportadora.PessoaId = 0, 'Null', ObjCarga.Transportadora.PessoaId.ToString) + ', ');
        Query.SQL.Add('        '+ObjCarga.Veiculo.VeiculoId.ToString + ', ');
        Query.SQL.Add('        '+ObjCarga.Motorista.PessoaId.ToString() + ', ');
        Query.SQL.Add('        '+'GetDate(), GetDate(), '+ ObjCarga.Usuarioid.ToString()+', ');
        Query.SQL.Add('         1, Cast('+QuotedStr(vGuuid)+' AS UNIQUEIDENTIFIER), 0)');
        Query.SQL.Add('Select CargaId From Cargas where Uuid = Cast('+QuotedStr(vGuuid)+' AS UNIQUEIDENTIFIER)');
        Query.Open;
        vCargaId := Query.FieldByName('CargaId').AsInteger;
        // Registrar o Pedido em Montagem de Carga
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Cargas where CargaId = '+vCargaId.ToString() + ')');
        Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
        Query.ParamByName('pProcessoId').Value := 16;
        Query.ParamByName('pTerminal').Value   := pJsonObject.GetValue<String>('terminal');
        Query.ParamByName('pUsuarioId').Value  := ObjCarga.Usuarioid;
        // ClipBoard.AsText := Query.Sql.Text;
        Query.ExecSQL;
      End
      Else
      Begin
        vSql := 'Update Cargas ' + '    Set RotaId           = ' +
          ObjCarga.Rotaid.ToString() + #13 + #10 + '      , TransportadoraId = ' +
          IfThen(ObjCarga.Transportadora.PessoaId = 0, 'Null',
          ObjCarga.Transportadora.PessoaId.ToString) + #13 + #10 +
          '      , Veiculoid        = ' + ObjCarga.Veiculo.VeiculoId.ToString +
          #13 + #10 + '      , MotoristaId      = ' +
          ObjCarga.Motorista.PessoaId.ToString() + #13 + #10 +
          '      , UsuarioId        = ' + ObjCarga.Usuarioid.ToString + #13 + #10
          + '        ,Status          = ' + ObjCarga.Status.ToString() + #13 + #10
          + 'where CargaId = ' + pCargaId.ToString;
        vCargaId := pCargaId;
        Query.ExecSQL(vSql);
      End;
      Query.Close;
      Query.SQL.Clear;
      // Query.SQL.Add('Delete From CargaPedidos Where CargaId = '+vCargaId.ToString);
      vCompl := '';
      vListaPedidos := '';
      For xPed := 0 To Pred(pJsonObject.GetValue<TJSonArray>('pedidos').Count) do
      Begin
        vListaPedidos := vListaPedidos + vCompl + pJsonObject.GetValue<TJSonArray>
          ('pedidos').Items[xPed].GetValue<Integer>('pedidoid').ToString();
        vCompl := ', ';
      End;
      Query.SQL.Add('Delete Cc');
      Query.SQL.Add('from CargaCarregamento cc');
      Query.SQL.Add
        ('Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = cc.PedidoVolumeId');
      Query.SQL.Add('where Cc.Cargaid = ' + vCargaId.ToString +
        ' and (Pv.PedidoId Not in (' + vListaPedidos + '))');
      Query.SQL.Add('Delete Cp');
      Query.SQL.Add('from CargaPedidos Cp');
      Query.SQL.Add('where Cp.Cargaid = ' + vCargaId.ToString +
        ' and (Cp.PedidoId Not in (' + vListaPedidos + '))');
      Query.SQL.Add('');
      Query.ExecSQL;
      // Result := Query.toJsonArray;
      For xPed := 0 To Pred(pJsonObject.GetValue<TJSonArray>('pedidos').Count) do
      Begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add
          ('If Not Exists (Select PedidoId From CargaPedidos Where PedidoId = ' +
          pJsonObject.GetValue<TJSonArray>('pedidos').Items[xPed]
          .GetValue<Integer>('pedidoid').ToString() + ' and CargaId  = ' +
          vCargaId.ToString + ')');
        Query.SQL.Add('   Insert Into CargaPedidos Values (' +
          pJsonObject.GetValue<TJSonArray>('pedidos').Items[xPed]
          .GetValue<Integer>('pedidoid').ToString() + ', ' + vCargaId.ToString() +
          ', GetDate(), GetDate(), ' + ObjCarga.Usuarioid.ToString + ', 1, 0)');
        Query.ExecSQL;
        { //Registrar o Pedido em Montagem de Carga
          Query.Close;
          Query.Sql.Clear;
          Query.Sql.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+pJsonObject.GetValue<TJsonArray>('pedidos').Items[xPed].GetValue<Integer>('pedidoid').ToString+')');
          Query.SQL.Add( TuEvolutConst.SqlRegistrarDocumentoEtapa );
          Query.ParamByName('pProcessoId').Value  := 16; //2	Cubagem Realizada
          Query.ParamByName('pTerminal').Value    := pJsonObject.GetValue<String>('terminal');
          Query.ParamByName('pUsuarioId').Value   := ObjCarga.UsuarioId;
          //ClipBoard.AsText := Query.Sql.Text;
          Query.ExecSql;
        } End;
      Result := TJSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('cargaid', TJsonNumber.Create(vCargaId)));
      Query.connection.Commit;
    Except On E: Exception do
      Begin
        Query.connection.Rollback;
        raise Exception.Create('Tabela: CargasInsertUpdate - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free
  End;
end;

function TCargasDAO.IntegracaoImportaCarga(const AParams: TDictionary<string, string>): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := TJSonArray.Create();
      Query.SQL.Add(TuEvolutConst.IntegracaoImportaCarga);
      if AParams.ContainsKey('cargaid') then
         Query.ParamByName('pCargaId').AsInteger := AParams.Items['cargaid'].Tointeger
      Else
         Query.ParamByName('pCargaId').AsInteger := 0;
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pdatafinal').Value := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('IntegracaoImportaCarga.Sql');
      Query.Open();
      if (Query.IsEmpty) or (Query.FieldByName('ConsultaRetorno').AsString='') then
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      Else
         Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Query.FieldByName('ConsultaRetorno').AsString), 0) as TJsonArray;
    Except On E: Exception do
      Raise  Exception.Create('Tabela: IntegracaoImportaCarga - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.IntegracaoListaCarga(
  const AParams: TDictionary<string, string>): TJSonArray;
Var Query : TFdQuery;
begin
  Result := TJSonArray.Create();
  Query  := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
     Try
       Query.SQL.Add(TuEvolutConst.IntegracaoListaCarga);
       if AParams.ContainsKey('datainicial') then
          Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
       Else
          Query.ParamByName('pdatainicial').Value := 0;
       if AParams.ContainsKey('datafinal') then
          Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
       Else
          Query.ParamByName('pdatafinal').Value := 0;
       if AParams.ContainsKey('processoid') then
          Query.ParamByName('pProcessoid').Value := StrtoIntDef(AParams.Items['processoid'], 0)
       Else
          Query.ParamByName('pProcessoId').Value := 0;

      if DebugHook <> 0 then
         Query.SQL.SaveToFile('IntegracaoListaCarga.Sql');
      Query.Open();
      if (Query.IsEmpty) or (Query.FieldByName('ConsultaRetorno').AsString='') then
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados))
      Else
         Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Query.FieldByName('ConsultaRetorno').AsString), 0) as TJsonArray;
    Except On E: Exception do
      Raise  Exception.Create('Tabela: IntegracaoListaCarga - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.PedidosParaCargas(const AParams : TDictionary<string, string>): TJSonArray;
var JsonCargas: TJsonObject;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelPedidosParaCargas);
      if AParams.ContainsKey('datainicial') then
         Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
         Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
         Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
         Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('codpessoaerp') then
        Query.ParamByName('pCodPessoaERP').AsInteger := AParams.Items['codpessoaerp'].Tointeger
      Else
        Query.ParamByName('pCodPessoaERP').AsInteger := 0;
      if AParams.ContainsKey('rotaid') then
         Query.ParamByName('protaid').AsInteger := AParams.Items['rotaid'].Tointeger
      Else
         Query.ParamByName('protaid').AsInteger := 0;
      if AParams.ContainsKey('zonaid') then
         Query.ParamByName('pzonaid').AsInteger := AParams.Items['zonaid'].Tointeger
      Else
         Query.ParamByName('pzonaid').AsInteger := 0;
      if AParams.ContainsKey('processoid') then
         Query.ParamByName('pprocessoid').Value := AParams.Items['processoid'].Tointeger()
      Else
         Query.ParamByName('pprocessoid').Value := 0;
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('RelPedidoParaCargas.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception Do
      Raise Exception.Create('Processo: PedidosParaCargas - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.PedidosParaCargasNFs(const AParams : TDictionary<string, string>): TJSonArray;
var JsonCargas: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlRelPedidosParaCargasNFs);
      if AParams.ContainsKey('datainicial') then
        Query.ParamByName('pdatainicial').Value :=
          FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
      Else
        Query.ParamByName('pdatainicial').Value := 0;
      if AParams.ContainsKey('datafinal') then
        Query.ParamByName('pdatafinal').Value :=
          FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
      Else
        Query.ParamByName('pdatafinal').Value := 0;
      if AParams.ContainsKey('codpessoaerp') then
        Query.ParamByName('pCodPessoaERP').AsInteger :=
          AParams.Items['codpessoaerp'].Tointeger
      Else
        Query.ParamByName('pCodPessoaERP').AsInteger := 0;
      if AParams.ContainsKey('rotaid') then
        Query.ParamByName('protaid').AsInteger :=
          AParams.Items['rotaid'].Tointeger
      Else
        Query.ParamByName('protaid').AsInteger := 0;
      if AParams.ContainsKey('zonaid') then
        Query.ParamByName('pzonaid').AsInteger :=
          AParams.Items['zonaid'].Tointeger
      Else
        Query.ParamByName('pzonaid').AsInteger := 0;
      if AParams.ContainsKey('processoid') then
        Query.ParamByName('pprocessoid').Value :=
          AParams.Items['processoid'].Tointeger()
      Else
        Query.ParamByName('pprocessoid').Value := 0;
      if DebugHook <> 0 then
        Query.SQL.SaveToFile('PedidoParaCargasNFs.Sql');
      Query.Open();
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('MSG', TuEvolutConst.QrySemDados));
      End
      Else
         Result := Query.ToJSONArray();
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: PedidoParaCargasNFs - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.PutAtualizarStatus(const pJsonObjectCargas: TJsonObject) : TJSonArray;
var
  xCargas: Integer;
  vListaCarga: String;
  vListaCargaOff: String;
  vCompl: String;
  vComplOff: String;
  Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.SQL.Add(TuEvolutConst.SqlCargaAtualizarStatus);
      vListaCarga := '';
      vListaCargaOff := '';
      vCompl := '';
      vComplOff := '';
      for xCargas := 0 to Pred(pJsonObjectCargas.GetValue<TJSonArray>('cargas').Count) do Begin
        if pJsonObjectCargas.GetValue<TJSonArray>('cargas').Items[xCargas].GetValue<Integer>('status') = 1 then Begin
           vListaCarga := vListaCarga + vCompl + pJsonObjectCargas.GetValue<TJSonArray>('cargas').Items[xCargas].GetValue<String>('cargaid');
           vCompl := ', ';
        End
        Else
        Begin
           vListaCargaOff := vListaCargaOff + vComplOff + pJsonObjectCargas.GetValue<TJSonArray>('cargas').Items[xCargas].GetValue<String>('cargaid');
           vComplOff := ', ';
        End;
      End;
      Query.SQL.Add('  and C.CargaId in (' + vListaCarga + ')');
      Query.ParamByName('pProcessoId').Value := pJsonObjectCargas.GetValue<Integer>('processoid');
      Query.ParamByName('pUsuarioId').Value := pJsonObjectCargas.GetValue<Integer>('usuarioid');
      Query.ParamByName('pTerminal').Value := pJsonObjectCargas.GetValue<String>('terminal');
      if DebugHook <> 0 then
         Query.SQL.SaveToFile('CargasAtualizarStatus.Sql');
      if vListaCarga <> '' then
         Query.ExecSQL;
      if vListaCargaOff <> '' then Begin
         Query.Close;
         Query.SQL.Clear;
         Query.SQL.Add('Update De Set Status = 0');
         Query.SQL.Add('From DocumentoEtapas De');
         Query.SQL.Add('Inner Join Cargas C On C.Uuid = De.Documento');
         Query.SQL.Add('Where C.CargaId In ('+vListaCargaOff+') and De.ProcessoId = '+pJsonObjectCargas.GetValue<String>('processoid'));
         Query.ExecSQL;
      End;
      Result := TJSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Atualizado com sucesso!'));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: PutAtualizarStatus - ' +tUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TCargasDAO.CargaLista(pCargaId, pRotaId, pProcessoId, pPendente: Integer; pProcesso : String): TJSonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.SQL.Add(TuEvolutConst.SqlCargaLista);
      Query.ParamByName('pCargaId').Value    := pCargaId;
      Query.ParamByName('pRotaId').Value     := pRotaId;
      Query.ParamByName('pProcessoId').Value := pProcessoId;
      Query.ParamByName('pPendente').Value   := pPendente;
      Query.ParamByName('pProcesso').Value   := pProcesso;
      If DebugHook <> 0 Then
         Query.SQL.SaveToFile('CargaLista.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJSonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
        Result := Query.ToJSONArray();
    Except On E: Exception do
      Begin
        raise Exception.Create('Tabela: CargaLista - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
