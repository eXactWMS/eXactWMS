unit Services.PedidoVolume;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  REST.JSON, Generics.Collections,
  FireDAC.Comp.Client, FireDAC.Stan.Error;

Type
  TServicePedidoVolume = class
  private

    procedure SalvarLog(pUsuarioId: Integer; pTerminal, pIpClient: String;
      pPort: Integer; pUrl, pParams, pBody, pResponseStr: String;
      pResponseJson: AnsiString; pRespStatus: Integer; pTimeExecution: Double);
  public
    Function BaixarEstoqueExpedicao: Boolean;
  end;

implementation

uses
  Repository.SqlScripts.PedidoVolume, Server.Connection;

{ ------------------------------------------------------------------------- }
procedure TServicePedidoVolume.SalvarLog(pUsuarioId: Integer;
  pTerminal, pIpClient: String; pPort: Integer;
  pUrl, pParams, pBody, pResponseStr: String; pResponseJson: AnsiString;
  pRespStatus: Integer; pTimeExecution: Double);
Var
  vMethod: String;
  Lconnection: Tconnection;
  LjsonValue: TJSONValue;
begin
  Lconnection := Tconnection.Create(1);
  Try
    try
      If length(pParams) > 1000 then
         pParams := Copy(pParams, 1, 1000);
      If length(pBody) > 4000 then
         pBody := Copy(pBody, 1, 4000);
      If length(pResponseStr) > 1000 then
         pResponseStr := Copy(pResponseStr, 1, 1000);
      If length(pResponseJson) > 8000 then
         pResponseJson := Copy(pResponseJson, 1, 8000);
      pResponseJson := StringReplace(pResponseJson, #39, #34, [rfReplaceAll]);
      LjsonValue := TJSONObject.ParseJSONValue(pBody);
      if pBody = '' then
        pBody := '[]'
      Else
      begin
        if (LjsonValue Is TJSONObject) or (LjsonValue Is TJsonArray) then
        Else
        Begin
          pBody := '[]';
        End;
      end;
      If pResponseJson = '' then
        pResponseJson := 'Null'
      Else
      Begin
        if (LjsonValue Is TJsonArray) then
        Begin
          if (LjsonValue as TJsonArray).Count > 1 then
          Begin
            pResponseStr := 'Retorno: ' +
              (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes
              (pResponseJson), 0) as TJsonArray).Count.ToString + ' Registros.';
            pResponseJson := '[]';
          End;
        End
        Else if (LjsonValue Is TJSONObject) then
        Begin
          if (LjsonValue as TJSONObject).Count > 1 then
          Begin
            pResponseStr := 'Retorno: ' + (LjsonValue as TJSONObject)
              .Count.ToString + ' Registros.';
            pResponseJson := '[]';
          End;
        End
        Else
        Begin
          pResponseStr := pResponseJson;
          pResponseJson := '[]'
        End;
      End;
      Lconnection.Query.SQL.add
        ('Insert into RequestResponse (data,	hora,	usuarioid,	terminal,	verbo	,'
        + sLineBreak +
        '            ipclient,	Port,	url,	params, body,	responsestr,	responsejson, '
        + sLineBreak +
        '           	respstatus,	timeexecution) Values (GetDate(), GetDate(), '
        + '      ' + pUsuarioId.ToString() + ', ' + #39 + pTerminal + #39 + ', '
        + #39 + vMethod + #39 + ', ' + '      ' + #39 + pIpClient + #39 + ', ' +
        pPort.ToString() + ', ' + #39 + pUrl + #39 + ', ' +
        '      :pParams, :pBody, ' + #39 + pResponseStr + #39 + ', ' +
        '      :pResponseJson, ' +

        pRespStatus.ToString() + ', ' + StringReplace(pTimeExecution.ToString(),
        ',', '.', [rfReplaceAll]) +

        ')');

      Lconnection.Query.ParamByName('pParams').Value := pParams;
      Lconnection.Query.ParamByName('pBody').Value := pBody;
      Lconnection.Query.ParamByName('pResponseJson').AsAnsiString :=
        pResponseJson;
      Lconnection.Query.ExecSQL;
    Except
    End;
  Finally
    Lconnection.Query.Close;
    try
      if assigned(LjsonValue) then
        LjsonValue.Free;
    except
    end;
    try
      Lconnection.DB.Close;
    except
    end;
    try
      FreeAndNil(Lconnection);
    except
    end;
  End;
end;

{ ------------------------------------------------------------------------- }
Function TServicePedidoVolume.BaixarEstoqueExpedicao: Boolean;
Var
  vQryVolumeParaExpedicao, vQryLoteExistente, vQryLoteInexistente,
    vQryGerarKardex, vQryBaixaEstoque: TFdQuery;

begin
  var
  LTime := Time;
  var
    Con := Tconnection.Create();
  try
    Try
      vQryVolumeParaExpedicao := TFdQuery.Create(Nil);
      vQryVolumeParaExpedicao.Connection := Con.DB;
      vQryLoteExistente := TFdQuery.Create(Nil);
      vQryLoteExistente.Connection := vQryVolumeParaExpedicao.Connection;
      vQryLoteInexistente := TFdQuery.Create(Nil);
      vQryLoteInexistente.Connection := vQryVolumeParaExpedicao.Connection;
      vQryGerarKardex := TFdQuery.Create(Nil);
      vQryGerarKardex.Connection := vQryVolumeParaExpedicao.Connection;
      vQryBaixaEstoque := TFdQuery.Create(Nil);
      vQryBaixaEstoque.Connection := vQryVolumeParaExpedicao.Connection;
      vQryVolumeParaExpedicao.SQL.add(TScriptRepository.GetVolumeParaExpedicao);
      vQryVolumeParaExpedicao.Open;
{
       If Con.DB.Connected then Begin
          Writeln('       '+FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now)+' - ' +'Sem Conexão com o Banco de Dados! Reinicie o serviço, por favor!');
          Result := False;
          Exit;
       End;
}
      Writeln('       '+FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now)+' - ' +'VolumeParaExpedicao: '+
              inttostr(vQryVolumeParaExpedicao.RecordCount)+' Registros');
      While Not vQryVolumeParaExpedicao.Eof do
      Begin
//        Writeln('       ' + FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now) + ' - ' +
//                'Processando Volume: ' + vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsString);
        Try
          vQryLoteInexistente.Close;
          vQryLoteInexistente.SQL.Clear;
          vQryLoteInexistente.SQL.add(TScriptRepository.GetLoteInexistente);
          vQryLoteInexistente.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
          //vQryLoteInexistente.ParamByName('pUsuarioId').Value      := vQryVolumeParaExpedicao.FieldByName('UsuarioId').AsInteger;
          vQryLoteInexistente.Open;
          if DebugHook <> 0 then
             vQryLoteInexistente.Sql.SaveToFile('Expedicao_LoteInexistente.Sql');

          vQryVolumeParaExpedicao.Connection.StartTransaction;
          vQryGerarKardex.Close;
          vQryGerarKardex.SQL.Clear;
          vQryGerarKardex.SQL.add(TScriptRepository.GerarKardexReserva);
          vQryGerarKardex.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
          vQryGerarKardex.ParamByName('pUsuarioId').Value := vQryVolumeParaExpedicao.FieldByName('UsuarioId').AsInteger;
          if DebugHook <> 0 then
             vQryGerarKardex.Sql.SaveToFile('Expedicao_GerarKardexReserva.Sql');
          vQryGerarKardex.ExecSQL;
          vQryLoteExistente.Close;
          vQryLoteExistente.SQL.Clear;
          vQryLoteExistente.SQL.add(TScriptRepository.GetLoteExistente);
          vQryLoteExistente.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
          vQryLoteExistente.ParamByName('pUsuarioId').Value      := vQryVolumeParaExpedicao.FieldByName('UsuarioId').AsInteger;
          if DebugHook <> 0 then
             vQryLoteInexistente.Sql.SaveToFile('Expedicao_GetLoteExistente.Sql');
          vQryLoteExistente.ExecSQL;

          While Not vQryLoteInexistente.Eof do
          Begin
            vQryBaixaEstoque.Close;
            vQryBaixaEstoque.SQL.Clear;
            vQryBaixaEstoque.SQL.add('Insert Into Estoque Values (');
            vQryBaixaEstoque.SQL.add(vQryLoteInexistente.FieldByName('LoteId').AsString+', '+
            vQryLoteInexistente.FieldByName('EnderecoId').AsString + ', ' +
            vQryLoteInexistente.FieldByName('EstoqueTipoId').AsString + ', ' +
            (vQryLoteInexistente.FieldByName('QtdSuprida').AsInteger).ToString() + ', ');
            vQryBaixaEstoque.SQL.add('   (SELECT IDDATA FROM RHEMA_DATA WHERE DATA = CAST(GETDATE() AS DATE)) ,');
            vQryBaixaEstoque.SQL.add('   (SELECT IDHORA FROM RHEMA_HORA WHERE HORA = (SELECT SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), ');
            vQryBaixaEstoque.Sql.Add(vQryVolumeParaExpedicao.FieldByName('UsuarioId').AsString+', NULL, NULL, Null)');
            LTime := Time;
            if DebugHook <> 0 then
               vQryLoteInexistente.Sql.SaveToFile('Expedicao_BaixarLoteInexistente.Sql');
            vQryBaixaEstoque.ExecSQL;
            vQryLoteInexistente.Next;
          End;
          vQryVolumeParaExpedicao.Connection.Commit;
          SalvarLog(0, 'API EXP OFF', '', 0, 'Baixa Estoque', 'pedidovolumeid = '+vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsString,
                    '', '', '', 200, Time - LTime);
          Sleep(10);
        Except On e: exception do
          Begin
            SalvarLog(0, 'API EXP OFF', '', 0, 'Erro Baixa Estoque. Volume: '+vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsString, e.Message, '', '', '', 500, Time - LTime);
            if vQryVolumeParaExpedicao.Connection.InTransaction then
               vQryVolumeParaExpedicao.Connection.RollBack;
            Writeln('       ' + FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now)+' - '+'ERRO: Volume: '+vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsString);
            Sleep(50);
          End;
        End;
        vQryVolumeParaExpedicao.Next;
      End;
    Except on e: exception do Begin
      Writeln('       '+FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now)+' - ' +'Erro de Conexão com o Banco de Dados! Reinicie o serviço, por favor!');
      Result := False;
      SalvarLog(0, 'MicroserviceExpedicao', '', 0, 'ErroBaixaEstoque', e.Message, '', '', '', 0, 0);
      End;
    End;
    // Con.DB.ExecSQL(TScriptRepository.ScriptBaixaEstoqueReposicao);
  finally
    FreeAndNil(vQryVolumeParaExpedicao);
    FreeAndNil(vQryLoteExistente);
    FreeAndNil(vQryLoteInexistente);
    FreeAndNil(vQryGerarKardex);
    FreeAndNil(vQryBaixaEstoque);
    If Con.DB.Connected then
       Con.DB.Connected := False;
    FreeAndNil(Con);
  end;
end;

end.
