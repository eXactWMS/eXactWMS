unit Repository.SqlScripts.PedidoVolume;

interface

Type
  TScriptRepository = class
  Class function ScriptBaixaEstoqueReposicao: string;
  end;

implementation

{ TScriptRepository }

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
    + '          DE.HORARIO = (SELECT MAX(HORARIO)             ' +#13#10
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
    + '                  QTDE                                  ' +#13#10
    + '                FROM ESTOQUE                            ' +#13#10
    + '                  WHERE                                 ' +#13#10
    + '                   LOTEID = VL.LOTEID                   ' +#13#10
    + '                   AND ENDERECOID = VL.ENDERECOID       ' +#13#10
    + '                   AND ESTOQUETIPOID = VL.ESTOQUETIPOID ' +#13#10
    + '                ),                                      ' +#13#10
    + '                                                        ' +#13#10
    + '                (SELECT                                 ' +#13#10
    + '                    QTDE-VL.QTDSUPRIDA                  ' +#13#10
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
    + '            ''TRANSFERÊNCIA PARA LOJA'' ,                          ' +#13#10
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
    + '                                                                  ' +#13#10
    + '          UPDATE EST SET QTDE = EST.QTDE - VL.QTDSUPRIDA          ' +#13#10
    + '          FROM PEDIDOVOLUMELOTES VL                               ' +#13#10
    + '                                                                  ' +#13#10
    + '          INNER JOIN ESTOQUE EST ON EST.LOTEID = VL.LOTEID        ' +#13#10
    + '          AND EST.ENDERECOID = VL.ENDERECOID                      ' +#13#10
    + '          AND EST.ESTOQUETIPOID = VL.ESTOQUETIPOID                ' +#13#10
    + '          WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID               ' +#13#10
    + '          UPDATE EST SET QTDE = EST.QTDE - VL.QTDSUPRIDA          ' +#13#10
    + '          FROM PEDIDOVOLUMELOTES VL                               ' +#13#10
    + '          INNER JOIN ESTOQUE EST ON EST.LOTEID = VL.LOTEID        ' +#13#10
    + '          AND EST.ENDERECOID = VL.ENDERECOID AND EST.ESTOQUETIPOID = 6  ' +#13#10
    + '          WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID               ' +#13#10
    + '		       UPDATE PEDIDOVOLUMES SET EXPEDIDO = 1                   ' +#13#10
    + '          WHERE PEDIDOVOLUMEID = @PEDIDOVOLUMEID                  ' +#13#10
    + '   FETCH NEXT FROM CVOLUMES INTO @PEDIDOVOLUMEID, @PROCESSOID,@USUARIOID  ' +#13#10
    + '  COMMIT TRAN -- Transaction Success!                             ' +#13#10
    + '  END TRY                                                         ' +#13#10
    + 'BEGIN CATCH                                                       ' +#13#10
    + 'IF @@TRANCOUNT > 0                                                ' +#13#10
    + '    ROLLBACK TRAN                                                 ' +#13#10
    + 'END CATCH                                                         ' +#13#10
    + 'END                                                               ' +#13#10
    + 'CLOSE CVOLUMES                                                    ' +#13#10
    + 'DEALLOCATE CVOLUMES                                               ' +#13#10
    + 'DELETE FROM ESTOQUE WHERE QTDE < 0 AND ESTOQUETIPOID = 6                  ';

end;

end.
