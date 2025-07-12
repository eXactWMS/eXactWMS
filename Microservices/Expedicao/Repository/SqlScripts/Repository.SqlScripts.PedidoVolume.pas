unit Repository.SqlScripts.PedidoVolume;
interface
Type
  TScriptRepository = class
  Class function ScriptBaixaEstoqueReposicao: string;
  Class Function GetVolumeParaExpedicao : String;
  Class Function GetLoteExistente   : String;
  Class Function GetLoteInexistente : String;
  Class Function GerarKardexReserva : String;
  end;
implementation
{ TScriptRepository }

class function TScriptRepository.GerarKardexReserva: String;
begin
  Result := 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak+
            'Declare @UsuarioId Integer      = :pUsuarioId'+sLineBreak+
            'INSERT INTO KARDEX'+sLineBreak+
            '   SELECT 2, VL.LOTEID, VL.ENDERECOID, VL.ESTOQUETIPOID, VL.QTDSUPRIDA, (SELECT Coalesce(QTDE, 0)'+sLineBreak+
            '   FROM ESTOQUE'+sLineBreak+
            '   WHERE  LOTEID = VL.LOTEID AND ENDERECOID = VL.ENDERECOID AND ESTOQUETIPOID = VL.ESTOQUETIPOID ),'+sLineBreak+
            '     (SELECT Coalesce(QTDE, 0)-VL.QTDSUPRIDA'+sLineBreak+
            '      FROM ESTOQUE'+sLineBreak+
            '      WHERE LOTEID = VL.LOTEID AND ENDERECOID = VL.ENDERECOID AND ESTOQUETIPOID = VL.ESTOQUETIPOID) ,'+sLineBreak+
            '         '+#39+'BAIXA VOLUME: '+#39+'+ CAST(VL.PEDIDOVOLUMEID AS VARCHAR), NULL, 0, 0, '+#39+'TRANSFERENCIA PARA LOJA'+#39+', '+sLineBreak+
            '     (SELECT IDDATA FROM RHEMA_DATA WHERE DATA = CAST(GETDATE() AS DATE)) ,'+sLineBreak+
            '     (SELECT IDHORA FROM RHEMA_HORA WHERE HORA = (SELECT SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),'+sLineBreak+
            '     @USUARIOID, '+#39+'API EXP OFF'+#39+sLineBreak+
            '  FROM PEDIDOVOLUMELOTES VL'+sLineBreak+
            '  WHERE VL.PEDIDOVOLUMEID =@PEDIDOVOLUMEID AND VL.QTDSUPRIDA > 0'+sLineBreak+
            ' '+sLineBreak+
            '  UPDATE EST  '+sLineBreak+
            '     SET QTDE = EST.QTDE - Quantidade'+sLineBreak+ //VL.QTDSUPRIDA'+sLineBreak+
            '    , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+sLineBreak+
            '    , HrAlteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
            '    , UsuarioIdAlt = @UsuarioId'+sLineBreak+
            '  FROM PEDIDOVOLUMELOTES VL'+sLineBreak+
            '  INNER JOIN ESTOQUE EST ON EST.LOTEID = VL.LOTEID'+sLineBreak+
            '                            AND EST.ENDERECOID = VL.ENDERECOID AND EST.ESTOQUETIPOID = 6'+sLineBreak+
            '  WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID'+sLineBreak+
            '		UPDATE PEDIDOVOLUMES SET EXPEDIDO = 1'+sLineBreak+
            '  WHERE PEDIDOVOLUMEID = @PEDIDOVOLUMEID    '+sLineBreak+
            ' '+sLineBreak+
            'DELETE FROM ESTOQUE WHERE QTDE <= 0 AND ESTOQUETIPOID = 6';
end;

class function TScriptRepository.GetLoteExistente: String;
begin
  Result := 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak+
            'Declare @Usuarioid Integer      = :pUsuarioId'+sLineBreak+
            '-- Baixa Estoque Existente'+sLineBreak+
            'UPDATE EST '+sLineBreak+
            '  SET QTDE         = EST.QTDE - VL.QTDSUPRIDA'+sLineBreak+
            '    , DtAlteracao  = (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'+sLineBreak+
            '    , HrAlteracao  = (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'+sLineBreak+
            '    , UsuarioIdAlt = @UsuarioId'+sLineBreak+
            'FROM PEDIDOVOLUMELOTES VL'+sLineBreak+
            'INNER JOIN ESTOQUE EST ON EST.LOTEID = VL.LOTEID'+sLineBreak+
            '  AND EST.ENDERECOID = VL.ENDERECOID'+sLineBreak+
            '  AND EST.ESTOQUETIPOID = VL.ESTOQUETIPOID'+sLineBreak+
            'WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID    ';
end;

Class function TScriptRepository.GetLoteInexistente: String;
begin
  Result := 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak+
            'Select Vl.Loteid, Vl.EnderecoId, Vl.EstoqueTipoId, Vl.QtdSuprida*-1 QtdSuprida,'+sLineBreak+
  		        '   (SELECT IDDATA FROM RHEMA_DATA WHERE DATA = CAST(GETDATE() AS DATE)) ,'+sLineBreak+
  		        '   (SELECT IDHORA FROM RHEMA_HORA WHERE HORA = (SELECT SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), NULL, NULL, NULL, Null'+sLineBreak+
  		        '   FROM PEDIDOVOLUMELOTES VL'+sLineBreak+
  		        '   Left join Estoque Est On Est.Loteid = Vl.Loteid and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = Vl.EstoqueTipoId'+sLineBreak+
  		        '   WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID and Est.LoteId Is Null';
end;

Class function TScriptRepository.GetVolumeParaExpedicao: String;
begin
  Result := 'DECLARE @PROCESSOID INTEGER;'+sLineBreak+
            'DECLARE @USUARIOID INTEGER;'+sLineBreak+
            'SELECT TOP 100 PV.PEDIDOVOLUMEID, DE.PROCESSOID, DE.USUARIOID'+sLineBreak+
            '      FROM PEDIDOVOLUMES PV'+sLineBreak+
            '      INNER JOIN VDOCUMENTOETAPAS DE ON DE.DOCUMENTO = PV.UUID'+sLineBreak+
            'WHERE DE.Processoid = (SELECT MAX(ProcessoId) FROM VDOCUMENTOETAPAS WHERE DOCUMENTO = PV.UUID AND STATUS = 1)'+sLineBreak+
            '        AND DE.PROCESSOID >= 13'+sLineBreak+
            '        AND DE.PROCESSOID NOT IN (15,31)'+sLineBreak+
            '        AND EXPEDIDO = 0 '+sLineBreak+
            '        AND (SELECT EXPEDICAOOFFLINE FROM CONFIGURACAO) = 1'+sLineBreak+
            '        ORDER BY DE.PROCESSOID DESC';
end;

Class function TScriptRepository.ScriptBaixaEstoqueReposicao: string;
begin
  result :=
    'DECLARE @PEDIDOVOLUMEID INTEGER;                          '+#13#10
    + 'DECLARE @PROCESSOID INTEGER;                            ' +#13#10
    + 'DECLARE @USUARIOID INTEGER;                             ' +#13#10
    + 'DECLARE CVOLUMES CURSOR FAST_FORWARD READ_ONLY FOR      ' +#13#10
    + 'SELECT                                                  ' +#13#10
    + '   TOP 200                                              ' +#13#10
    + '          PV.PEDIDOVOLUMEID                             ' +#13#10
    + '         ,DE.PROCESSOID                                 ' +#13#10
    + '         ,DE.USUARIOID                                  ' +#13#10
    + '      FROM PEDIDOVOLUMES PV                             ' +#13#10
    + '      INNER JOIN VDOCUMENTOETAPAS DE                    ' +#13#10
    + '         ON DE.DOCUMENTO = PV.UUID                      ' +#13#10
    + '      WHERE                                             ' +#13#10
    + '          DE.ProcessoId = (SELECT MAX(ProcessoId)       ' +#13#10
    + '                         FROM VDOCUMENTOETAPAS          ' +#13#10
    + '                          WHERE                         ' +#13#10
    + '                             DOCUMENTO = PV.UUID AND STATUS = 1)' +#13#10
    + '        AND DE.PROCESSOID >= 13                         ' +#13#10
    + '        AND DE.PROCESSOID NOT IN (15,31)                ' +#13#10
    + '        AND EXPEDIDO = 0                                ' +#13#10
    + '        AND (SELECT EXPEDICAOOFFLINE FROM CONFIGURACAO) = 1'  +#13#10
    + '        ORDER BY DE.PROCESSOID DESC                     ' +#13#10
    + '                                                        ' +#13#10
    + '  OPEN CVOLUMES                                         ' +#13#10
    + 'FETCH NEXT FROM CVOLUMES INTO @PEDIDOVOLUMEID,          ' +#13#10
    + '  @PROCESSOID,@USUARIOID                                ' +#13#10
    + 'WHILE @@FETCH_STATUS=0                                  ' +#13#10
    + 'BEGIN                                                   ' +#13#10
    + '  BEGIN TRY                                             ' +#13#10
    + '     BEGIN TRAN                                         ' +#13#10
    + '          INSERT INTO KARDEX                            ' +#13#10
    + '            SELECT                                      ' +#13#10
    + '               2,                                       ' +#13#10
    + '               VL.LOTEID,                               ' +#13#10
    + '               VL.ENDERECOID,                           ' +#13#10
    + '               VL.ESTOQUETIPOID,                        ' +#13#10
    + '                VL.QTDSUPRIDA,                          ' +#13#10
    + '               (SELECT                                  ' +#13#10
    + '                  Coalesce(QTDE, 0)                     ' +#13#10
    + '                FROM ESTOQUE                            ' +#13#10
    + '                  WHERE                                 ' +#13#10
    + '                   LOTEID = VL.LOTEID                   ' +#13#10
    + '                   AND ENDERECOID = VL.ENDERECOID       ' +#13#10
    + '                   AND ESTOQUETIPOID = VL.ESTOQUETIPOID ' +#13#10
    + '                ),                                      ' +#13#10
    + '                                                        ' +#13#10
    + '                (SELECT                                 ' +#13#10
    + '                    Coalesce(QTDE, 0)-VL.QTDSUPRIDA     ' +#13#10
    + '                  FROM                                  ' +#13#10
    + '                    ESTOQUE                             ' +#13#10
    + '                  WHERE                                 ' +#13#10
    + '                     LOTEID = VL.LOTEID                 ' +#13#10
    + '                     AND ENDERECOID = VL.ENDERECOID     ' +#13#10
    + '                     AND ESTOQUETIPOID = VL.ESTOQUETIPOID ' +#13#10
    + '			           	 ) ,                                   ' +#13#10
    + '                   ''BAIXA VOLUME:''+ CAST(VL.PEDIDOVOLUMEID AS VARCHAR), ' +#13#10
    + '                   NULL,                                           ' +#13#10
    + '                    0,                                             ' +#13#10
    + '                    0,                                             ' +#13#10
    + '            ''TRANSFERNCIA PARA LOJA'' ,                          ' +#13#10
    + '          	(SELECT IDDATA FROM RHEMA_DATA WHERE DATA =             ' +#13#10
    + '              CAST(GETDATE() AS DATE)) ,                           ' +#13#10
    + '            (SELECT IDHORA FROM RHEMA_HORA WHERE HORA =            ' +#13#10
    + '            (SELECT SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),' +#13#10
    + '           @USUARIOID,                                            ' +#13#10
    + '          ''API EXP OFF''                                         ' +#13#10
    + '          FROM                                                    ' +#13#10
    + '            PEDIDOVOLUMELOTES VL                                  ' +#13#10
    + '          WHERE                                                   ' +#13#10
    + '             VL.PEDIDOVOLUMEID =@PEDIDOVOLUMEID                   ' +#13#10
    + '          AND VL.QTDSUPRIDA > 0                                   ' +#13#10
    + ' '+sLineBreak
    + ' -- Inserir Estoque Negativo                                      ' +#13#10
    + '     Insert Into Estoque Select Vl.Loteid, Vl.EnderecoId, Vl.EstoqueTipoId, Vl.QtdSuprida*-1,'   +#13#10
  		+ '           	(SELECT IDDATA FROM RHEMA_DATA WHERE DATA =       ' +#13#10
    + '           CAST(GETDATE() AS DATE)) ,                            ' +#13#10
    + '           (SELECT IDHORA FROM RHEMA_HORA WHERE HORA =         ' +#13#10
    + '         (SELECT SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), ' +#13#10
    + '      	NULL,	NULL,	NULL,	Null                                  ' +#13#10
    + '       FROM PEDIDOVOLUMELOTES VL                                ' +#13#10
    + '       Left join Estoque Est On Est.Loteid = Vl.Loteid and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = Vl.EstoqueTipoId ' +#13#10
    + '       WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID and Est.LoteId Is Null  ' +#13#10
    + '                                                                  ' +#13#10
    + '-- Baixa Estoque Existente                                        ' +#13#10
    + '          UPDATE EST SET QTDE = EST.QTDE - VL.QTDSUPRIDA          ' +#13#10
    + '          FROM PEDIDOVOLUMELOTES VL                               ' +#13#10
    + '          INNER JOIN ESTOQUE EST ON EST.LOTEID = VL.LOTEID        ' +#13#10
    + '          AND EST.ENDERECOID = VL.ENDERECOID                      ' +#13#10
    + '          AND EST.ESTOQUETIPOID = VL.ESTOQUETIPOID                ' +#13#10
    + '          WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID               ' +#13#10
    + '                                                                 ' +#13#10
    + ' --Baixar Estoque em Reserva ' +#13#10
    + '          UPDATE EST SET QTDE = EST.QTDE - VL.QTDSUPRIDA          ' +#13#10
    + '          FROM PEDIDOVOLUMELOTES VL                               ' +#13#10
    + '          INNER JOIN ESTOQUE EST ON EST.LOTEID = VL.LOTEID        ' +#13#10
    + '          AND EST.ENDERECOID = VL.ENDERECOID AND EST.ESTOQUETIPOID = 6  ' +#13#10
    + '          WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID               ' +#13#10
    + '		       UPDATE PEDIDOVOLUMES SET EXPEDIDO = 1                   ' +#13#10
    + '          WHERE PEDIDOVOLUMEID = @PEDIDOVOLUMEID                  ' +#13#10
    + '  COMMIT TRAN -- Transaction Success!                             ' +#13#10
    + '  END TRY                                                         ' +#13#10
    + '  BEGIN CATCH                                                       ' +#13#10
    + '    IF @@TRANCOUNT > 0                                                ' +#13#10
    + '      ROLLBACK TRAN                                                 ' +#13#10
    + '    DECLARE @ErrorMessage NVARCHAR(4000);                              ' +#13#10
		+ '    DECLARE @ErrorSeverity INT;                                        ' +#13#10
		+ '    DECLARE @ErrorState INT;                                           ' +#13#10
		+ '   SELECT                                                          ' +#13#10
		+ ' 	  @ErrorMessage = ERROR_MESSAGE(),                              ' +#13#10
		+ '    	@ErrorSeverity = ERROR_SEVERITY(),                            ' +#13#10
		+ '    	@ErrorState = ERROR_STATE();                                  ' +#13#10
    + '     RAISERROR (@ErrorMessage,                                   ' +#13#10
		+ '		   @ErrorSeverity, -- Severity.                               ' +#13#10
		+ '		   @ErrorState -- State.                                      ' +#13#10
		+ '		   );                                                         ' +#13#10
    + '  END CATCH                                                      ' +#13#10
    + '   FETCH NEXT FROM CVOLUMES INTO @PEDIDOVOLUMEID, @PROCESSOID,@USUARIOID  ' +#13#10
    + 'END                                                               ' +#13#10
    + 'CLOSE CVOLUMES                                                    ' +#13#10
    + 'DEALLOCATE CVOLUMES                                               ' +#13#10
    + 'DELETE FROM ESTOQUE WHERE QTDE < 0 AND ESTOQUETIPOID = 6                  ';
end;
end.
