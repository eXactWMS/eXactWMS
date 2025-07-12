unit MService.EntradaIntegracaoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error, FireDAC.Stan.Option, DataSet.Serialize, System.JSON, REST.JSON,
  Generics.Collections, exactwmsservice.lib.connection, uFuncoes, Web.HTTPApp, exactwmsservice.lib.utils, exactwmsservice.dao.base;

Const SqlEntradaIntegracaoConsulta = ';With'+sLineBreak+
      'Ped as (Select Ped.PedidoId, '+#39+'Entrada'+#39+' OperacaoNome, P.CodPessoaERP, P.Razao, P.Fantasia, P.CnpjCpf, P.Email,'+sLineBreak+
      '               Ped.DocumentoNr, Rd.Data DocumentoData, Ped.RegistroERP, De.Processo'+sLineBreak+
      '        From Pedido Ped'+sLineBreak+
      '		     Inner Join Pessoa P ON P.PessoaId = Ped.PessoaId and P.PessoaTipoId = 2'+sLineBreak+
      '		     Inner join Rhema_Data Rd ON Rd.IdData = Ped.DocumentoData'+sLineBreak+
      '		     Outer Apply (select Top 1 De.ProcessoId, Pe.Descricao Processo'+sLineBreak+
      '		     From DocumentoEtapas De'+sLineBreak+
      '				 Inner join ProcessoEtapas Pe on Pe.ProcessoId = De.ProcessoId'+sLineBreak+
      '				 Where De.Documento = Ped.Uuid'+sLineBreak+
      '				 Order by De.ProcessoId Desc) De'+sLineBreak+
      '        Where Ped.OperacaoTipoId = 3 and DE.ProcessoId in ( 5, 15, 31) and Ped.Status not in (5, 31)),'+sLineBreak+
      'TotCheckIn as (Select PI.PedidoId, Coalesce(Sum(QtdXML), 0) QtdXml, Coalesce(Sum(QtdCheckIn), 0) QtdCheckIn,'+sLineBreak+
      '                      Coalesce(Sum(QtdDevolvida), 0) QtdDevolvida, Coalesce(Sum(QtdSegregada), 0) QtdSegregada'+sLineBreak+
      '               From PedidoItens PI'+sLineBreak+
      '               Inner Join Ped P ON P.PedidoId = PI.PedidoId'+sLineBreak+
      '               Group by PI.PedidoId)'+sLineBreak+
      ''+sLineBreak+
      'Select P.*, Tc.QtdXml, Tc.QtdCheckIn, Tc.QtdDevolvida, Tc.QtdSegregada'+sLineBreak+
      'From Ped P'+sLineBreak+
      'Left Join TotCheckIn TC On Tc.PedidoId = P.PedidoId'+sLineBreak+
      'Order by P.PedidoId';

Const SqlEntradaIntegracaoConsulta_190525 = ';With' + sLineBreak +
      'Ped as (Select Ped.*'+sLineBreak +
      '        From VPedidos Ped' + sLineBreak +
      '        Inner Join vDocumentoEtapas De on De.Documento = Ped.uuid and --De.Horario = DeM.horario and'+sLineBreak+
      '                                          De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento )--and Horario = De.Horario) '+sLineBreak+
      '        Where Ped.OperacaoTipoId = 3 and DE.ProcessoId in ( 5, 15, 31) and Ped.Status <> 5'+ sLineBreak +
      '          --And De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'+sLineBreak+
      '), '+ sLineBreak +
      'TotCheckIn as (Select PI.PedidoId, Coalesce(Sum(QtdXML), 0) QtdXml, Coalesce(Sum(QtdCheckIn), 0) QtdCheckIn, '+ sLineBreak +
      '                Coalesce(Sum(QtdDevolvida), 0) QtdDevolvida, Coalesce(Sum(QtdSegregada), 0) QtdSegregada'+sLineBreak +
      'From PedidoItens PI' + sLineBreak +
      'Inner Join Ped P ON P.PedidoId = PI.PedidoId' + sLineBreak +
      'Group by PI.PedidoId) ' + sLineBreak + 'Select P.*, TC.*' + sLineBreak +
      'From Ped P' + sLineBreak +
      'Left Join TotCheckIn TC On Tc.PedidoId = P.PedidoId' + sLineBreak +
      'Order by P.PedidoId'; // CheckIn Concluído

Const SqlEntradaIntegracaoRetornoPedido = 'Declare @RegistroERP Varchar(36) = :pRegistroERP' + sLineBreak +
      'Select PedidoId, OperacaoTipoId, OperacaoNome, PessoaId, Razao, Fantasia,'+ sLineBreak +
      '       CnpjCpf, Email, DocumentoNr, DocumentoData, Ped.Status,' +sLineBreak +
      '       RegistroERP, uuid, De.processoId,' + sLineBreak +
      '   	   (Case When DE.ProcessoId = 31 then '+#39+'Documento Excluido'+#39 + ' Else Ped.StatusNome End) StatusNome' + sLineBreak +
      'From vPedidos Ped' + sLineBreak +
      '--Inner join (Select Documento, Max(DataHora) horario From DocumentoEtapas Where Status = 1 Group by Documento) DeM On DeM.Documento = Pv.Uuid'+sLineBreak+
      'Inner Join vDocumentoEtapas De on De.Documento = Ped.uuid and --De.Horario = DeM.horario and'+sLineBreak+
      '                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento )--and Horario = De.Horario) '+sLineBreak+
      'Where (Cast(PedidoId as varchar(36)) = @RegistroERP or RegistroERP = @RegistroERP) and De.ProcessoId in (5, 6, 15, 31)' + sLineBreak +
      '      --And De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)';

Const SqlEntradaIntegracaoRetornoPedidoProdutos = 'Select * from vPedidoItemProdutos';

Const SqlEntradaIntegracaoRetornoPedidoLotes = 'Select * from vPedidoItemLotes';

Const SqlFornecedorInsert = 'If Not Exists (Select CodPessoaERP From Pessoa Where CodPessoaERP = @CodPessoaERP and PessoaTipoId = 2) Begin'+sLineBreak+
      ' 		insert into pessoa (CodPessoaERP, Razao, Fantasia, PessoaTipoID, CnpjCpf, Email, Status)'+sLineBreak+
      '      		Values (@CodPessoaERP, @Razao, @Fantasia, 2, @CnpjCpf, @Email, 1)'+sLineBreak+
      'End'+sLineBreak+
      'Else Begin'+sLineBreak+
      '   Update Pessoa ' + #13 + #10 + '       Set Razao     = @Razao' +sLineBreak+
      '           ,Fantasia = @Fantasia'+sLineBreak+
      '           ,CnpjCpf  = @CnpjCpf'+sLineBreak+
      '           ,Email    = @Email'+sLineBreak+
      '   Where CodPessoaERP = @CodPessoaERP and PessoaTipoId = 2' +sLineBreak+
      'End';

Const SqlLaboratorioInsert = 'If Not Exists (Select Nome From Laboratorios Where Nome = @Nome) Begin'+sLineBreak+
      ' 		insert into Laboratorios (Nome, Status, uuii)'+sLineBreak+
      '        Values (@Nome, 1, NewId())'+sLineBreak+
      'End;';

Const SqlUnidadesInsert = 'If Not Exists (Select Id From Unidades Where Sigla = @Sigla) Begin'+sLineBreak+
      '   Insert Into Unidades Values (@Sigla, @Descricao, 1)'+sLineBreak+
      'End;';

Const SqlProdutoInsert = 'If Not Exists (Select CodProduto From Produto Where CodProduto = @CodProduto) Begin'+sLineBreak+
      ' 		insert into Produto (CodProduto, Descricao, DescrReduzida, RastroId, ProdutoTipoId, UnidadeId,'+sLineBreak+
      '                        QtdUnid, UnidadeSecundariaId, FatorConversao, LaboratorioId, PesoLiquido, '+sLineBreak+
      '                        Liquido, Perigoso, Inflamavel, Altura, Largura, Comprimento, MesEntradaMinima,'+sLineBreak+
      '                        MesSaidaMinima, Status, uuid)'+sLineBreak+
      '   Values (@CodProduto, @Descricao, SubString(@Descricao, 1, 40), (Select CadRastroIdProdNovo From Configuracao), 1, '+sLineBreak+
      '           (Select Id From Unidades where Sigla = @SiglaUnidPrimaria), @QtdUnidPrimaria,'+sLineBreak+
      '           (Select Id From Unidades where Sigla = @SiglaUnidSecundaria), '+sLineBreak+
      '           @QtdUnidSecundaria, (Case When @LaboratorioId = 0 Then Null Else (Select IdLaboratorio '+sLineBreak+
      '                                From Laboratorios Where IdLaboratorio = @LaboratorioId) End), @Peso, @Liquido, '+sLineBreak+
      '           @Perigoso, @Inflamavel, @Altura, @Largura, @Comprimento, (Select ShelflifeRecebimento From Configuracao), '+sLineBreak+
      '           (Select ShelflifeExpedicao From Configuracao), 1, NewId())'+sLineBreak+
      'End'+sLineBreak+
      'Else Begin'+sLineBreak+
      '   Update Produto Set ' + #13 + #10 + '     Descricao = @Descricao'+sLineBreak+
      '   Where CodProduto = @CodProduto'+sLineBreak+
      'End;';

Const SqlProdutoLotesInsert = 'If Not Exists (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote) Begin'+sLineBreak +
      '   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, @Fabricacao, @Vencimento, '+sLineBreak +
      '                                    (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+sLineBreak +
      '                                    (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '+sLineBreak +
      '                                    NewId())' + sLineBreak +
      'End' + sLineBreak +
      'Else Begin' + sLineBreak +
      '   Update ProdutoLotes Set ' + sLineBreak +
      '      Fabricacao = @Fabricacao' + sLineBreak +
      '    , Vencimento = @Vencimento' + sLineBreak +
      '   Where 0 = 1 and ProdutoId = @ProdutoId and DescrLote = @DescrLote' +sLineBreak +
      'End';

Const SqlEntradaInsert = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @OperacaoTipoId Integer = (Select OperacaoTipoId From OperacaoTipo Where Upper(Descricao) = '+#39+'ENTRADA' + #39 + ')' + sLineBreak +
      'Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = :pPessoaId and PessoaTipoId = 2)'+sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +sLineBreak +
      'Declare @DocumentoOriginal Varchar(20) = :pDocumentoOriginal'+sLineBreak +
      'Declare @DocumentoData Int = (Select IdData From Rhema_Data Where Data = :pDocumentoData)'+sLineBreak +
      'Declare @RegistroERP Varchar(36) = :pRegistroERP'+sLineBreak +
      'If Not Exists (Select PedidoId From Pedido Where RegistroERP = @RegistroERP) Begin'+sLineBreak+
      '   Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DocumentoOriginal, DtInclusao, '+sLineBreak +
      '                       HrInclusao, ArmazemId, RegistroERP, Status, uuid) Values '+sLineBreak +
      '                      (@OperacaoTipoId, @PessoaId, @DocumentoNr, @DocumentoData, @DocumentoOriginal, '+sLineBreak+
      '                              (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+sLineBreak+
      '                              (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),'+sLineBreak +
      '                       1, @RegistroERP, 0, NewId())'+sLineBreak+
      '   Insert Into DocumentoEtapas Values ((select uuid from pedido where PessoaId = @PessoaId and DocumentoNr = @DocumentoNr),  '+sLineBreak +
      '                                       1, Null, (Select IdData From Rhema_Data Where Data = '+'  Cast(GetDate() as Date)),  '+sLineBreak+
      '          (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), '+#39+'IntegracaoERP'#39 + ', 1)'+sLineBreak+
      'End'+sLineBreak+
      'Else Begin '+sLineBreak+
      '   Update Pedido Set' +sLineBreak +
      '    OperacaoTipoId  = @OperacaoTipoId' + sLineBreak +
      '	   , Pessoaid      = @Pessoaid' + sLineBreak +
      '	   , DocumentoNr   = @DocumentoNr' + sLineBreak +
      '    , DocumentoData = @DocumentoData' + sLineBreak +
      '    , ArmazemId     = 1' + sLineBreak +
      '    , RegistroERP   = @RegistroERP' + sLineBreak +
      '  Where RegistroERP = @RegistroERP' + sLineBreak +
      '  Delete from PedidoItens where PedidoId = (Select PedidoId from Pedido where RegistroErp = @RegistroERP and OperacaoTipoId = 3)'+sLineBreak +
      'End;' + sLineBreak+
      'Select PedidoId From Pedido Where PessoaId = @PessoaId and RegistroERP = @RegistroERP and OperacaoTipoId = @OperacaoTipoId';

Const SqlEntradaInsertDocumentoNr = 'Declare @PedidoId Integer = :pPedidoId' +sLineBreak +
      'Declare @OperacaoTipoId Integer = (Select OperacaoTipoId From OperacaoTipo Where Upper(Descricao) = '+#39+'ENTRADA'+#39+')'+sLineBreak +
      'Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = :pPessoaId and PessoaTipoId = 2)'+sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +sLineBreak +
      'Declare @DocumentoOriginal Varchar(20) = :pDocumentoOriginal'+sLineBreak +
      'Declare @DocumentoData Int = (Select IdData From Rhema_Data Where Data = :pDocumentoData)'+sLineBreak +
      'Declare @RegistroERP Varchar(36) = :pRegistroERP' +sLineBreak +
      'If Not Exists (Select PedidoId From Pedido Where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                  or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and DocumentoData = @DocumentoData)) Begin'+sLineBreak+
      '   Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DocumentoOriginal, DtInclusao, '+sLineBreak +
      '                       HrInclusao, ArmazemId, RegistroERP, Status, uuid) Values '+sLineBreak +
      '                      (@OperacaoTipoId, @PessoaId, @DocumentoNr, @DocumentoData, @DocumentoOriginal, '+sLineBreak+
      '                              (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+sLineBreak+
      '                              (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),'+sLineBreak +
      '                       1, @RegistroERP, 0, NewId())'+sLineBreak+
      '   Insert Into DocumentoEtapas Values ((select uuid from pedido where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                  or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and DocumentoData = @DocumentoData)),  '+sLineBreak +
      '                                       1, Null, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),  '+sLineBreak+
      '          (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), '+#39 + 'IntegracaoERP'#39 + ', 1)'+sLineBreak+
      'End'+sLineBreak+
      'Else Begin '+sLineBreak+
      '  Update Pedido Set' +sLineBreak +
      '    OperacaoTipoId      = @OperacaoTipoId' + sLineBreak +
      '	   , Pessoaid          = @Pessoaid' + sLineBreak +
      '	   , DocumentoNr       = @DocumentoNr' + sLineBreak +
      '    , DocumentoOriginal = @DocumentoOriginal' + sLineBreak +
      '    , DocumentoData     = @DocumentoData' + sLineBreak +
      '    , ArmazemId         = 1' + sLineBreak +
      '    , RegistroERP       = @RegistroERP' + sLineBreak +
      '    , Status            = (Case When (select sum(QtdCheckin+QtdDevolvida+QtdSegregada)'+sLineBreak +
      '                                      from PedidoItens' +sLineBreak +
      '									                     where pedidoid = (Select PedidoId From Pedido Where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                        or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and DocumentoData = @DocumentoData))'+ ') > 0 then 1 Else 0 End)'+sLineBreak +
      '                                                             Where PedidoId = (Select PedidoId From Pedido Where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                        or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and DocumentoData = @DocumentoData))'+sLineBreak +
      '  Update DocumentoEtapas Set status = 0' + sLineBreak +
      '  Where Documento = (Select Uuid From Pedido Where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                  or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and DocumentoData = @DocumentoData))'+sLineBreak +
      '  Delete from PedidoItens where PedidoId = (Select PedidoId From Pedido where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP))'+sLineBreak +
      '              or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr and DocumentoData = @DocumentoData))'+sLineBreak +
      '  Insert Into DocumentoEtapas Values ((select uuid from pedido where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                  or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr And DocumentoData = @DocumentoData)),  '+sLineBreak +
      '                                       1, Null, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),  ' + sLineBreak +
      '          (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), '+#39+'IntegracaoERP'#39 + ', 1)'+sLineBreak +
      'End;' + sLineBreak +
      'Select PedidoId From Pedido Where (((Select chave_entrada_integracao From Configuracao)=0) and (RegistroERP = @RegistroERP)) '+sLineBreak +
      '                                                  or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr And DocumentoData = @DocumentoData)';

Const SqlEntradaItensInsert = 'If Not Exists (Select PedidoItemId From PedidoItens Where PedidoId = @PedidoId and LoteId = @LoteId) Begin'+sLineBreak+
      '   Insert Into PedidoItens (PedidoId, LoteId, QtdXML, PrintEtqControlado, uuid) Values (@PedidoId, @LoteId, @QtdXML, 0, NewId())'+sLineBreak+
      'End'+sLineBreak+
      'Else Begin '+sLineBreak+
      '   Update PedidoItens Set' + #13 + #10 + '     QtdXML = @QtdXML'+sLineBreak+
      '   Where PedidoId = @PedidoId and LoteId = @LoteId'+sLineBreak+
      'End;';

Const SqlGetValidaEntrada =
      'Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = :pCodPessoaERP and PessoaTipoId = 2)'+ sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak+
      'Declare @Documentodata DateTime  = :pDocumentoData'+sLineBreak+
      'select Ped.DocumentoNr, Ped.RegistroERP, De.ProcessoId, De.Descricao Proceso, De.Horario, Ped.Status'+ sLineBreak +
      'From pedido Ped' + sLineBreak +
      '--Inner join (Select Documento, Max(DataHora) horario From DocumentoEtapas Where Status = 1 Group by Documento) DeM On DeM.Documento = Pv.Uuid'+sLineBreak+
      'Inner Join vDocumentoEtapas De on De.Documento = Ped.uuid and --De.Horario = DeM.horario and'+sLineBreak+
      '                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento )--and Horario = De.Horario) '+sLineBreak+
      'Inner join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData'+sLineBreak+
      'where De.Documento = Ped.Uuid and ' + sLineBreak +
      '      --DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and'+sLineBreak+
      '      Ped.OperacaoTipoId = 3 And' + sLineBreak +
      '      Ped.PedidoId = (Select PedidoId From Pedido Where (((Select chave_entrada_integracao From Configuracao)=0) and (Cast(RegistroERP as VarChar(36)) = @RegistroERP)) '+sLineBreak +
      '                                                  or ((Select chave_entrada_integracao From Configuracao)=1 and PessoaId = @PessoaId and DocumentoNr = @DocumentoNr And DocumentoData = @DocumentoData))'+sLIneBreak+
      '  And Rd.Data = @DocumentoData';

type

  TEntradaIntegracaoDao = class(TBasicDao)
  private
    Procedure SalvarFornecedor(pConneXact: TConnection; pCodigo: Integer = 0; pRazao: String = '';
                               pFantasia: String = ''; pCnpj: String = ''; pEmail: String = '');
    Function SalvarLaboratorio(pConneXact: TConnection; pIdLaboratorio: Integer = 0; pNome: String = ''): Integer;
    Procedure SalvarUnidades(pConneXact: TConnection; pSigla: String = 'Un'; pDescricao: String = 'Unidade');
    Procedure SalvarProduto(pConneXact: TConnection; pCodProduto: Integer = 0;
                            pDescricao: String = ''; pSiglaUnidPrimaria: String = 'Un';
                            pQtdUnidPrimaria: Integer = 1; pSiglaUnidSecundaria: String = 'Un';
                            pFatorConversao: Integer = 1; pLaboratorioId: Integer = 0;
                            pPeso: Integer = 1; pLiquido: Integer = 0; pPerigoso: Integer = 0;
                            pInflamavel: Integer = 0; pAltura: Integer = 8; pLargura: Integer = 8;
                            pComprimento: Integer = 8; pMesEntradaMinima: Integer = 0;
                            pMesSaidaMinima: Integer = 0; pEan: String = '');
    Procedure SalvarProdutoCodbarras(pConneXact: TConnection;
      pCodProdutoERP: Integer = 0; pEan: String = '');
    Procedure SalvarProdutoLotes(pConneXact: TConnection; pProdutoId: Integer = 0; pDescrLote: String = '';
                                 pFabricacao: String = ''; pVencimento: String = '');
    Function SalvarEntrada(pConneXact: TConnection; pPedidoId: Integer = 0; pPessoaId: Integer = 0;
                           pNatureza: String = ''; pDocumentoNr: String = ''; pDocumentoData: String = '';
                           pDocumentoOriginal: String = ''; pRegistroERP: String = ''; pArmazemId: Integer = 0): Integer;
    Procedure SalvarEntradaItens(pConneXact: TConnection; pPedidoId, pIdProduto: Integer; pLote: String; pQtdXML: Integer);
    Procedure DeleteCheckIn(pConneXact: TConnection; pEntradaId: Integer);
    Function ValidaEntrada(pConneXact: TConnection; pCodPessoaERP: Integer; pDocumentoNr, pRegistroERP, pDocumentoData: String): Boolean;
    procedure SalvarLogOld(pFuncao, pMensagem: String);
    Procedure ReEnvioPreEntradaAgrupamento(pEntradaId : Integer);
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Consulta: TJsonArray;
    function Insert(ArrayEntradas: TJsonArray): TJsonArray;
    Function Retorno(pPedidoId: String): TJsonArray;
    Procedure RegistrarRetorno(pEntradaId: Integer);
  end;

implementation

uses uSistemaControl, Constants;

function TEntradaIntegracaoDao.Consulta : TJsonArray;
var vSql: String;
    jsonRetorno, jsonFornecedor: TJsonObject;
    vTeste: String;
begin
  Result := TJsonArray.Create;
  try
    FConexao.Query.Sql.Add(SqlEntradaIntegracaoConsulta);
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('status', '200').AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
            .AddPair('mensagem', TuEvolutConst.QrySemDados));
    End
    Else
      while (Not FConexao.Query.Eof) do Begin
        jsonRetorno := TJsonObject.Create();
        With jsonRetorno do Begin
          AddPair('entradaid', TJsonNumber.Create(FConexao.Query.FieldByName('PedidoId').AsInteger));
          AddPair('operacao', FConexao.Query.FieldByName('OperacaoNome').AsString);
          jsonFornecedor := TJsonObject.Create();
          jsonFornecedor.AddPair('fornecedorcodigo', TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaERP').AsInteger));
          jsonFornecedor.AddPair('razao', FConexao.Query.FieldByName('Razao').AsString);
          jsonFornecedor.AddPair('fantasia', FConexao.Query.FieldByName('Fantasia').AsString);
          jsonFornecedor.AddPair('cnpj', FConexao.Query.FieldByName('CnpjCpf').AsString);
          jsonFornecedor.AddPair('email', FConexao.Query.FieldByName('Email').AsString);
          AddPair('fornecedor', jsonFornecedor);
          AddPair('documentonr', FConexao.Query.FieldByName('DocumentoNr').AsString);
          AddPair('documentodata', FormatDateTime('YYYY-MM-DD', FConexao.Query.FieldByName('DocumentoData').AsDateTime));
          AddPair('registroerp', FConexao.Query.FieldByName('RegistroERP').AsString);
          AddPair('processo', FConexao.Query.FieldByName('Processo').AsString);
          AddPair('qtdxml', TJsonNumber.Create(FConexao.Query.FieldByName('QtdXML').AsInteger));
          AddPair('qtdcheckin', TJsonNumber.Create(FConexao.Query.FieldByName('QtdCheckIn').AsInteger));
          AddPair('qtddevolvida', TJsonNumber.Create(FConexao.Query.FieldByName('QtdDevolvida').AsInteger));
          AddPair('qtdsegregada', TJsonNumber.Create(FConexao.Query.FieldByName('QtdSegregada').AsInteger));
        End;
        Result.AddElement(jsonRetorno);
        FConexao.Query.Next;
      End;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracaoConsulta - '+StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

constructor TEntradaIntegracaoDao.Create;
begin
  inherited;
end;

procedure TEntradaIntegracaoDao.DeleteCheckIn(pConneXact: TConnection;
  pEntradaId: Integer);
begin
  //
  // Fconexao := TConnection.create(0);
  FConexao.Query.Close;
  FConexao.Query.Sql.Clear;
  FConexao.Query.Sql.Add('Declare @PedidoId Integer = ' +
    pEntradaId.ToString());
  FConexao.Query.Sql.Add('Delete PI');
  FConexao.Query.Sql.Add
    ('From (select PI.PedidoId, PI.ProdutoId, Coalesce(PI.TotXml, 0) TotXml, Coalesce(Pc.TotCheckIn, 0) TotCheckIn');
  FConexao.Query.Sql.Add
    ('From (Select PI.PedidoId, Prd.ProdutoId, SUM(PI.QtdXml) TotXml');
  FConexao.Query.Sql.Add('      From PedidoItens PI');
  FConexao.Query.Sql.Add
    ('      Inner Join ProdutoLotes Prd On Prd.LoteId = PI.Loteid');
  FConexao.Query.Sql.Add('      Where PI.PedidoId = @PedidoId');
  FConexao.Query.Sql.Add('      Group By PI.PedidoId, Prd.ProdutoId) PI');
  FConexao.Query.Sql.Add
    ('Left Join (Select Pc.PedidoId, Prd.ProdutoId, SUM(Coalesce(Pc.QtdCheckIn, 0)+Coalesce(Pc.QtdDevolvida, 0)+Coalesce(Pc.QtdSegregada, 0)) TotCheckIn');
  FConexao.Query.Sql.Add('           From PedidoItensCheckIn Pc');
  FConexao.Query.Sql.Add
    ('           Inner Join ProdutoLotes Prd On Prd.LoteId = Pc.Loteid');
  FConexao.Query.Sql.Add('           Where Pc.PedidoId = @PedidoId');
  FConexao.Query.Sql.Add
    ('           Group By Pc.PedidoId, Prd.ProdutoId) Pc On Pc.PedidoId = PI.PedidoId and Pc.ProdutoId = PI.ProdutoId');
  FConexao.Query.Sql.Add('Where Pi.TotXml < Pc.TotCheckIn) Pic');
  FConexao.Query.Sql.Add
    ('Inner Join (Select PedidoId, LoteId, QtdXml From PedidoItens) Pi On Pi.PedidoId = Pic.PedidoId');
  FConexao.Query.Sql.Add('WHERE PI.QtdXml = 0');
  FConexao.Query.Sql.Add('');
  FConexao.Query.Sql.Add('Delete Pc');
  FConexao.Query.Sql.Add('From (');
  FConexao.Query.Sql.Add
    ('      select PI.PedidoId, PI.ProdutoId, Coalesce(PI.TotXml, 0) TotXml, Coalesce(Pc.TotCheckIn, 0) TotCheckIn');
  FConexao.Query.Sql.Add
    ('From (Select PI.PedidoId, Prd.ProdutoId, SUM(PI.QtdXml) TotXml');
  FConexao.Query.Sql.Add('      From PedidoItens PI');
  FConexao.Query.Sql.Add
    ('      Inner Join ProdutoLotes Prd On Prd.LoteId = PI.Loteid');
  FConexao.Query.Sql.Add('      Where PI.PedidoId = @PedidoId');
  FConexao.Query.Sql.Add('      Group By PI.PedidoId, Prd.ProdutoId) PI');
  FConexao.Query.Sql.Add
    ('Left Join (Select Pc.PedidoId, Prd.ProdutoId, SUM(Coalesce(Pc.QtdCheckIn, 0)+Coalesce(Pc.QtdDevolvida, 0)+Coalesce(Pc.QtdSegregada, 0)) TotCheckIn');
  FConexao.Query.Sql.Add('           From PedidoItensCheckIn Pc');
  FConexao.Query.Sql.Add
    ('           Inner Join ProdutoLotes Prd On Prd.LoteId = Pc.Loteid');
  FConexao.Query.Sql.Add('           Where Pc.PedidoId = @PedidoId');
  FConexao.Query.Sql.Add
    ('           Group By Pc.PedidoId, Prd.ProdutoId) Pc On Pc.PedidoId = PI.PedidoId and Pc.ProdutoId = PI.ProdutoId');
  FConexao.Query.Sql.Add('Where Pi.TotXml < Pc.TotCheckIn) Pic');
  FConexao.Query.Sql.Add
    ('Inner Join (Select PedidoId, LoteId, QtdXml From PedidoItensCheckIn) Pc On Pc.PedidoId = Pic.PedidoId');
  FConexao.Query.Sql.Add('');
  FConexao.Query.Sql.Add('Update Pi');
  FConexao.Query.Sql.Add
    ('   Set Pi.QtdCheckIn = Pc.QtdCheckIn, Pi.QtdDevolvida = Pc.QtdDevolvida, Pi.QtdSegregada = Pc.QtdSegregada');
  FConexao.Query.Sql.Add('From PedidoItens Pi');
  FConexao.Query.Sql.Add
    ('Inner Join (Select Pc.PedidoId, Pc.LoteId, SUM(Pc.QtdCheckIn) QtdCheckIn, SUM(Pc.QtdDevolvida) QtdDevolvida, SUM(Pc.QtdSegregada) QtdSegregada');
  FConexao.Query.Sql.Add('           From PedidoItensCheckIn Pc');
  FConexao.Query.Sql.Add
    ('		   Group by Pc.PedidoId, Pc.LoteId) Pc On Pc.PedidoId = Pi.PedidoId and Pc.LoteId = Pi.LoteId');
  FConexao.Query.Sql.Add('where Pi.PedidoId = @PedidoId');
  FConexao.Query.Sql.Add('');
  FConexao.Query.Sql.Add
    ('Insert Into PedidoItens (PedidoId, LoteId, QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada, Uuid)');
  FConexao.Query.Sql.Add
    ('select Pc.PedidoId, Pc.LoteId, 0, Pc.QtdCheckIn, Pc.QtdDevolvida, Pc.QtdSegregada, NEWID()');
  FConexao.Query.Sql.Add
    ('From (Select Pc.PedidoId, Pc.LoteId, Sum(Pc.QtdCheckIn) QtdCheckIn, Sum(Pc.QtdDevolvida) QtdDevolvida, Sum(Pc.QtdSegregada) QtdSegregada');
  FConexao.Query.Sql.Add('      From PedidoItensCheckIn Pc');
  FConexao.Query.Sql.Add
    ('      Left Join PedidoItens Pi ON Pi.PedidoId = Pc.PedidoId and Pi.LoteId = Pc.LoteId');
  FConexao.Query.Sql.Add('      where Pc.PedidoId = @PedidoId');
  FConexao.Query.Sql.Add('	    and Pi.LoteId Is Null');
  FConexao.Query.Sql.Add('	  Group By Pc.PedidoId, Pc.LoteId) Pc');
  If DebugHook <> 0 Then
    FConexao.Query.Sql.SaveToFile('PedidoCheckIn_Delete.Sql');
  FConexao.Query.ExecSQL;
end;

destructor TEntradaIntegracaoDao.Destroy;
begin

  inherited;
end;

function TEntradaIntegracaoDao.Insert(ArrayEntradas: TJsonArray): TJsonArray;
var // vQry : TFDQuery;
  vSql: String;
  xEntrada, xItens, xLotes: Integer;
  JSONPedido, jsonFornecedor: TJsonObject;
  JSONProduto, JSONFabricante: TJsonObject;
  ArrayJSONItens, ArrayJSONLotes: TJsonArray;
  JSONUnidPrimaria, JSONUnidSecundaria: TJsonObject;
  JSONLote: TJsonObject;
  JSONVal: TJSONValue;
  vEntradaId, vFornecedor, vLaboratorioId: Integer;
  vDocumentoOriginal: String; // Código do pedido no ERP
  verro: string;
  ErroJsonArray: TJsonArray;
  JsonErro: TJsonObject;
  TesteCodBarras : String;
begin
  Result := TJsonArray.Create;
  Try
    FConexao.Query.Sql.Add('Insert Into JsonIntegracao Values (NewId(), ' + #39+ArrayEntradas.ToString() + #39 + ')');
    If DebugHook <> 0 Then
       FConexao.Query.Sql.SaveToFile('JsonIntegracao.Sql');
    FConexao.Query.ExecSQL;
  Except
  End;
  If (ArrayEntradas.items[0] as TJsonObject).GetValue<TjsonArray>('itens').Count <= 0 then
     raise Exception.Create('Documento recusado. Não contém itens!');
  Try
    FConexao.Query.connection.StartTransaction;
    for xEntrada := 0 to ArrayEntradas.Count - 1 do
    Begin
      JSONPedido := ArrayEntradas.items[xEntrada] as TJsonObject;
      // Validar Se Entrada Existe e ainda Pendente
      If Not ValidaEntrada(FConexao, JSONPedido.getValue<TJsonObject>('fornecedor')
                                               .getValue<Integer>('fornecedorcodigo'),
                                     JSONPedido.getValue<String>('documentonr'),
                                     JSONPedido.getValue<String>('registroerp'),
                                     JSONPedido.getValue<String>('documentodata')) then
      Begin
        Result := TJsonArray.Create(TJsonObject.Create.AddPair('status', '500')
                 .AddPair('entradaid', TJsonNumber.Create(JSONPedido.getValue<Integer>('entradaid', 0)))
                 .AddPair('documentoerp', JSONPedido.getValue<String>('registroerp'))
                 .AddPair('mensagem', 'Recebimento não pode ser alterado.'));
      End
      Else Begin
        jsonFornecedor := JSONPedido.getValue<TJsonObject>('fornecedor');
        Try
          SalvarFornecedor(FConexao, jsonFornecedor.getValue<Integer>('fornecedorcodigo'),
                                     jsonFornecedor.getValue<String>('razao'),
                                     jsonFornecedor.getValue<String>('fantasia'),
                                     jsonFornecedor.getValue<String>('cnpj'),
                                     jsonFornecedor.getValue<String>('email'));
        Except On E: Exception do
          raise Exception.Create('SalvarFornecedor. '+E.Message);
        End;
        ArrayJSONItens := JSONPedido.getValue<TJsonArray>('itens');
        vDocumentoOriginal := '';
        vDocumentoOriginal := GetValueInjSon(JSONPedido, 'documentooriginal');
        Try
          vEntradaId := SalvarEntrada(FConexao, JSONPedido.getValue<Integer>('entradaid', 0),
                                      JsonFornecedor.getValue<Integer>('fornecedorcodigo', 0),
                                      JSONPedido.getValue<String>('natureza'),
                                      JSONPedido.getValue<String>('documentonr'),
                                      JSONPedido.getValue<String>('documentodata'), vDocumentoOriginal,
                                      JSONPedido.getValue<String>('registroerp'), 0);
        Except On E: Exception do
          raise Exception.Create('SalvarEntrada. '+E.Message);
        End;
        For xItens := 0 To ArrayJSONItens.Count - 1 do Begin
          JSONProduto := ArrayJSONItens.Get(xItens) as TJsonObject;
          JSONFabricante := JSONProduto.getValue<TJsonObject>('fabricante');
          // Laboratorio
          try
            vLaboratorioId := SalvarLaboratorio(FConexao, JSONFabricante.getValue<Integer>('id'), JSONFabricante.getValue<String>('nome'));
          Except On E: Exception do
            raise Exception.Create('SalvarLaboratório. '+E.Message);
          End;
          JSONUnidPrimaria := JSONProduto.getValue<TJsonObject>('embalagemprimaria');
          JSONUnidSecundaria := JSONProduto.getValue<TJsonObject>('embalagemsecundaria');
          Try
            SalvarUnidades(FConexao, JSONUnidPrimaria.getValue<String>('sigla'), JSONUnidPrimaria.getValue<String>('descricao'));
          Except On E: Exception do
            raise Exception.Create('SalvarUnidades(Primária). '+E.Message);
          End;
          Try
            SalvarUnidades(FConexao, JSONUnidSecundaria.getValue<String>('sigla'), JSONUnidSecundaria.getValue<String>('descricao'));
          Except On E: Exception do
            raise Exception.Create('SalvarUnidades(Secundária). '+E.Message);
          End;
          Try
            SalvarProduto(FConexao, JSONProduto.getValue<Integer>('produtoid', 0), JSONProduto.getValue<String>('descricao'),
                                    JSONUnidPrimaria.getValue<String>('sigla'), JSONUnidPrimaria.getValue<Integer>('qtdembalagem'),
                                    JSONUnidSecundaria.getValue<String>('sigla'), JSONUnidSecundaria.getValue<Integer>('qtdembalagem'),
                                    vLaboratorioId, 1, 0, 0, 0, 8, 8, 8, 0, 0, JSONProduto.getValue<String>('ean'));
          Except On E: Exception do
            raise Exception.Create('SalvarProduto. '+E.Message);
          End;
          Try
            if StrToInt64Def(JSONProduto.getValue<String>('ean'), 0) > 999999 then
               SalvarProdutoCodbarras(FConexao, JSONProduto.getValue<Integer>('produtoid', 0), JSONProduto.getValue<String>('ean'));
          Except On E: Exception do
            raise Exception.Create('SalvarPRodutoCodBarras. '+E.Message);
          End;
          ArrayJSONLotes := JSONProduto.getValue<TJsonArray>('lote');
          for xLotes := 0 to ArrayJSONLotes.Count - 1 do Begin
            JSONLote := ArrayJSONLotes.Get(xLotes) as TJsonObject;
            // JSONLote  := TJSONObject.ParseJSONValue(ArrayJSONLotes.Get(xEntrada).ToString);
            Try
              SalvarProdutoLotes(FConexao, JSONProduto.getValue<Integer>('produtoid', 0),
                                           JSONLote.getValue<String>('descricao'),
                                           JSONLote.getValue<String>('fabricacao'),
                                           JSONLote.getValue<String>('vencimento'));
            Except On E: Exception do
              raise Exception.Create('SalvarProdutoLotes. '+E.Message);
            End;
            Try
              SalvarEntradaItens(FConexao, vEntradaId, JSONProduto.getValue<Integer>('produtoid', 0),
                                                     JSONLote.getValue<String>('descricao'),
                                                     JSONLote.getValue<Integer>('quantidade'));
            Except On E: Exception do
              raise Exception.Create('SalvarEntradaItens. '+E.Message);
            End;
            JSONLote.Free;
          End;
        End;
        Try
          DeleteCheckIn(FConexao, vEntradaId);
        Except On E: Exception do
          raise Exception.Create('DeleteCheckin. '+E.Message);
        End;
        ReEnvioPreEntradaAgrupamento( vEntradaId );
        Result.AddElement(TJsonObject.Create.AddPair('status', '200')
                         .AddPair('entradaid', TJsonNumber.Create(JSONPedido.getValue<Integer>('entradaid', 0)))
                         .AddPair('id_wms', TJsonNumber.Create(vEntradaId))
                         .AddPair('documentoerp', JSONPedido.getValue<String>('registroerp'))
                         .AddPair('mensagem', 'Ok!'));
      End;
    End;
    FConexao.Query.connection.Commit;
  Except ON E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
{      JsonErro := TJsonObject.Create;
      JsonErro.AddPair('status', '500');
      JsonErro.AddPair('entradaid', TJsonNumber.Create(JSONPedido.getValue<Integer>('entradaid', 0)));
      JsonErro.AddPair('documentoerp', JSONPedido.getValue<String>('registroerp'));
      JsonErro.AddPair('mensagem', StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
      Result.AddElement(JsonErro);
}      raise Exception.Create(E.Message);
    End;
  end;
End;

procedure TEntradaIntegracaoDao.ReEnvioPreEntradaAgrupamento(pEntradaId: Integer);
Var vQryReEnvioAgrupamento : TFdQuery;
begin
  Try
    Try
      vQryReEnvioAgrupamento := FConexao.GetQuery;
      vQryReEnvioAgrupamento.SQL.Add('Declare @AgrupamentoId Int = (select AgrupamentoId From PedidoAgrupamentoNotas where pedidoid = '+pEntradaId.ToString()+')');
      vQryReEnvioAgrupamento.SQL.Add(';With');
      vQryReEnvioAgrupamento.SQL.Add('Pc As (select Pl.CodProduto, Sum(QtdCheckIn) CheckIn, Sum(QtdDevolvida) Devol, Sum(QtdSegregada) Segr');
      vQryReEnvioAgrupamento.SQL.Add('from PedidoItensCheckInAgrupamento Pc');
      vQryReEnvioAgrupamento.SQL.Add('Inner join vProdutoLotes Pl on Pl.Loteid = Pc.Loteid');
      vQryReEnvioAgrupamento.SQL.Add('where Agrupamentoid = @AgrupamentoId');
      vQryReEnvioAgrupamento.SQL.Add('Group by Pl.CodProduto),');
      vQryReEnvioAgrupamento.SQL.Add('');
      vQryReEnvioAgrupamento.SQL.Add('Pi As (select Pl.CodProduto, Sum(QtdXml) QtdXml');
      vQryReEnvioAgrupamento.SQL.Add('from pedidoItens pi');
      vQryReEnvioAgrupamento.SQL.Add('Inner join Pedido Ped On Ped.Pedidoid = Pi.PedidoId');
      vQryReEnvioAgrupamento.SQL.Add('Inner join PedidoAgrupamentoNotas Pn On Pn.PedidoId = Pi.PedidoId');
      vQryReEnvioAgrupamento.SQL.Add('Inner join vProdutoLotes Pl on Pl.Loteid = Pi.Loteid');
      vQryReEnvioAgrupamento.SQL.Add('where Pn.Agrupamentoid = @AgrupamentoId');
      vQryReEnvioAgrupamento.SQL.Add('Group by Pl.CodProduto)');
      vQryReEnvioAgrupamento.SQL.Add('');
      vQryReEnvioAgrupamento.SQL.Add(', Pic as (Select Pc.CodProduto');
      vQryReEnvioAgrupamento.SQL.Add('          From Pc');
      vQryReEnvioAgrupamento.SQL.Add('		  Left Join Pi On Pi.CodProduto = Pc.Codproduto');
      vQryReEnvioAgrupamento.SQL.Add('		  where (Coalesce(pi.QtdXml, 0) < (Coalesce(Pc.CheckIn, 0)+Coalesce(Pc.Devol, 0)+Coalesce(Pc.Segr, 0))');
      vQryReEnvioAgrupamento.SQL.Add('                 or Pi.CodProduto Is Null) )');
      vQryReEnvioAgrupamento.SQL.Add('');
      vQryReEnvioAgrupamento.SQL.Add('Delete Pca');
      vQryReEnvioAgrupamento.SQL.Add('From PedidoitensCheckInAgrupamento Pca');
      vQryReEnvioAgrupamento.SQL.Add('Inner join vProdutoLotes Pl On Pl.LoteId = Pca.LoteId');
      vQryReEnvioAgrupamento.SQL.Add('Inner join Pic On Pic.CodProduto = Pl.Codproduto');
      vQryReEnvioAgrupamento.SQL.Add('where Pca.agrupamentoid = @AgrupamentoId');
      vQryReEnvioAgrupamento.ExecSQL;
    Except On E: Exception do
      Raise Exception.Create(E.Message);
    End;
  Finally
    vQryReEnvioAgrupamento.Close;
  End;
end;

procedure TEntradaIntegracaoDao.RegistrarRetorno(pEntradaId: Integer);
begin
  Try
    FConexao.Query.Sql.Add('Update Pedido Set Status = 5 Where PedidoId = ' + pEntradaId.ToString());
    FConexao.Query.ExecSQL;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - RegistrarRetorno: ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEntradaIntegracaoDao.Retorno(pPedidoId: String): TJsonArray;
var VQryPed, vQryPedProd, vQryPedLotes, vQryReg, vQryAtualizaStatusPedido : TFDQuery;
    ArrayJsonProdutos, ArrayJSONLotes: TJsonArray;
    jsonRetorno, jsonFornecedor, JSONProduto, JSONFabricante, jsonLotes: TJsonObject;
    vProcessoId: Integer;
begin
  Result       := TJsonArray.Create;
  VQryPed      := FConexao.GetQuery;
  vQryPedProd  := FConexao.GetQuery;
  vQryPedLotes := FConexao.GetQuery;
  vQryReg      := FConexao.GetQuery;
  vQryPedLotes.FetchOptions.Unidirectional := false;
  VQryPed.FetchOptions.Unidirectional := false;
  vQryPedProd.FetchOptions.Unidirectional := false;
  vQryAtualizaStatusPedido := FConexao.GetQuery;
  Try
    try
      Result := TJsonArray.Create();
      VQryPed.Sql.Add(SqlEntradaIntegracaoRetornoPedido);
      VQryPed.ParamByName('pRegistroERP').Value := pPedidoId;
      if DebugHook <> 0 then
         VQryPed.Sql.SaveToFile('IntegracaoEntradaRetorno.Sql');
      VQryPed.Open();
      if (VQryPed.IsEmpty) then Begin
         Result.AddElement(TJsonObject.Create.AddPair('status', '500')
               .AddPair('saidaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
               .AddPair('mensagem', TuEvolutConst.QrySemDados));
      End
      Else
      Begin
        vProcessoId := VQryPed.FieldByName('ProcessoId').AsInteger;
        jsonRetorno := TJsonObject.Create();
        if Not VQryPed.IsEmpty then Begin
            vQryPedProd.Sql.Add(SqlEntradaIntegracaoRetornoPedidoProdutos + ' where PedidoId = ' + VQryPed.FieldByName('PedidoId').AsString);
            vQryPedLotes.Sql.Add(SqlEntradaIntegracaoRetornoPedidoLotes + ' where PedidoId = ' + VQryPed.FieldByName('PedidoId').AsString);
            vQryPedProd.Open();
            vQryPedLotes.Open();
        End;
        With VQryPed do
          While Not Eof do Begin
            With jsonRetorno do Begin
              AddPair('identificadao', 'v1/entradaintegracao/retorno/');
              AddPair('entradaid', TJsonNumber.Create(VQryPed.FieldByName('PedidoId').AsInteger));
              AddPair('operacao', VQryPed.FieldByName('OperacaoNome').AsString);
              jsonFornecedor := TJsonObject.Create();
              jsonFornecedor.AddPair('fornecedorcodigo', TJsonNumber.Create(VQryPed.FieldByName('PessoaId').AsInteger));
              jsonFornecedor.AddPair('razao', VQryPed.FieldByName('Razao').AsString);
              jsonFornecedor.AddPair('fantasia', VQryPed.FieldByName('Fantasia').AsString);
              jsonFornecedor.AddPair('cnpj', VQryPed.FieldByName('CnpjCpf').AsString);
              jsonFornecedor.AddPair('email', VQryPed.FieldByName('Email').AsString);
              AddPair('fornecedor', jsonFornecedor);
              AddPair('documentonr', VQryPed.FieldByName('DocumentoNr').AsString);
              AddPair('documentodata', FormatDateTime('YYYY-MM-DD', VQryPed.FieldByName('DocumentoData').AsDateTime));
              AddPair('situacao', VQryPed.FieldByName('StatusNome').AsString);
              AddPair('registroerp', VQryPed.FieldByName('RegistroERP').AsString);
              ArrayJsonProdutos := TJsonArray.Create();
              if VQryPed.FieldByName('Processoid').AsInteger = 31 then Begin
                 vQryAtualizaStatusPedido.Sql.Clear;
                 vQryAtualizaStatusPedido.Sql.Add('Update Pedido Set Status = 31 where PedidoId = ' +
                 VQryPed.FieldByName('PedidoId').AsString);
                 vQryAtualizaStatusPedido.ExecSQL;
              End
              Else With vQryPedProd do
                 while Not Eof do Begin
                    JSONProduto := TJsonObject.Create();
                    JSONProduto.AddPair('produtoid', TJsonNumber.Create(FieldByName('CodigoERP').AsInteger));
                    JSONProduto.AddPair('descricao', FieldByName('Descricao').AsString);
                    JSONFabricante := TJsonObject.Create();
                    JSONFabricante.AddPair('id', TJsonNumber.Create(FieldByName('FabricanteId').AsInteger));
                    JSONFabricante.AddPair('nome', FieldByName('FabricanteNome').AsString);
                    JSONProduto.AddPair('fabricante', JSONFabricante);
                    JSONProduto.AddPair('qtdcaixa', TJsonNumber.Create(FieldByName('FatorConversao').AsInteger));
                    JSONProduto.AddPair('qtdcaixamaster', TJsonNumber.Create(FieldByName('FatorConversao').AsInteger));
                    JSONProduto.AddPair('qtdxml', TJsonNumber.Create(FieldByName('QtdXML').AsInteger));
                    ArrayJSONLotes := TJsonArray.Create();
                    With vQryPedLotes do Begin
                      Filter := 'IdProduto = ' + vQryPedProd.FieldByName('IdProduto').AsString;
                      Filtered := True;
                      while Not Eof do Begin
                        jsonLotes := TJsonObject.Create();
                        jsonLotes.AddPair('descricao', FieldByName('Lote').AsString);
                        jsonLotes.AddPair('fabricacao', FormatDateTime('YYYY-MM-DD', FieldByName('Fabricacao').AsDateTime));
                        jsonLotes.AddPair('vencimento', FormatDateTime('YYYY-MM-DD', FieldByName('Vencimento').AsDateTime));
                        jsonLotes.AddPair('qtdcheckin', TJsonNumber.Create(FieldByName('QtdCheckIn').AsInteger));
                        jsonLotes.AddPair('qtddevolvida', TJsonNumber.Create(FieldByName('QtdDevolvida').AsInteger));
                        jsonLotes.AddPair('qtdsegregada', TJsonNumber.Create(FieldByName('QtdSegregada').AsInteger));
                        ArrayJSONLotes.AddElement(jsonLotes);
                        Next;
                      End;
                    End;
                    JSONProduto.AddPair('lotes', ArrayJSONLotes);
                    ArrayJsonProdutos.AddElement(JSONProduto);
                    // jsonRetorno.AddPair('produto', JsonProduto);
                    vQryPedLotes.Filter := '';
                    vQryPedLotes.Filtered := false;
                    Next;
                 End;
              jsonRetorno.AddPair('produto', ArrayJsonProdutos);
            End;
            Result.AddElement(jsonRetorno);
            // tJson.ObjectToJsonObject(jsonRetorno, [joDateFormatISO8601]));
            Next;
          End;
        if (vProcessoId = 5) then Begin // and (DebugHook = 0)
           vQryReg.connection := FConexao.DB;
           vQryReg.Sql.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where ' +
                           '(Cast(PedidoId as varchar(36)) = ' + #39 + pPedidoId + #39 +
                           ' or (RegistroERP=' + #39 + pPedidoId + #39 + ')))');
           vQryReg.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
           vQryReg.ParamByName('pProcessoId').Value := 6;
           vQryReg.ParamByName('pUsuarioId').Value := 0;
           vQryReg.ParamByName('pTerminal').Value := 'IntegracaoERP';
           vQryReg.ExecSQL;
        End;
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: EntradaIntegracaoRetorno - ' + StringReplace(E.Message,
              '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
      End;
    end;
  Finally
    VQryPed.Close;
    vQryPedProd.Close;
    vQryPedLotes.Close;
    vQryReg.Close;
    vQryAtualizaStatusPedido.Close;
  End;
end;

procedure TEntradaIntegracaoDao.SalvarProdutoLotes(pConneXact: TConnection;
  pProdutoId: Integer; pDescrLote: String; pFabricacao, pVencimento: String);
Begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @ProdutoId Integer = (Select IdProduto From Produto Where CodProduto = '+pProdutoId.ToString() + ')');
    FConexao.Query.Sql.Add('Declare @DescrLote VarChar(30) = ' + QuotedStr(pDescrLote));
    if pFabricacao = '' then
       FConexao.Query.Sql.Add('Declare @Fabricacao Int = (Select IdData From Rhema_Data Where Data = Cast(GetDate()-720 as Date))')
    Else
       FConexao.Query.Sql.Add('Declare @Fabricacao Int = (Select IdData From Rhema_Data Where Data ='+#39 + pFabricacao + #39 + ')');
    if pVencimento = '' then
       FConexao.Query.Sql.Add('Declare @Vencimento Int = (Select IdData From Rhema_Data Where Data = Cast(GetDate()+(360*10) as Date))')
    Else
       FConexao.Query.Sql.Add('Declare @Vencimento Int = (Select IdData From Rhema_Data Where Data ='+#39 + pVencimento + #39 + ')');
    FConexao.Query.Sql.Add('If @DescrLote = '+#39+'SL'+#39+' or (Select RastroId From Produto where IdProduto = @ProdutoId) = 1');
    FConexao.Query.Sql.Add('   Set @Vencimento = (Select IdData From Rhema_Data where Data = Cast(GetDate() as Date))+(360*10)');
    FConexao.Query.Sql.Add(SqlProdutoLotesInsert);
    if (DebugHook <> 0) and (pProdutoId = 145717) then
      FConexao.Query.Sql.SaveToFile('EntradaInsertLote.Sql');
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - Fornecedor: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Function TEntradaIntegracaoDao.SalvarEntrada(pConneXact: TConnection;
  pPedidoId, pPessoaId: Integer; pNatureza, pDocumentoNr, pDocumentoData,
  pDocumentoOriginal: String; pRegistroERP: String;
  pArmazemId: Integer): Integer;
begin
  Try
    // vQry.Sql.Add(SqlEntradaInsert); //DrogaCenter e Brasil
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add(SqlEntradaInsertDocumentoNr);
    FConexao.Query.ParamByName('pPedidoId').Value          := pPedidoId;
    FConexao.Query.ParamByName('pPessoaId').Value          := pPessoaId.ToString();
    FConexao.Query.ParamByName('pDocumentoNr').Value       := pDocumentoNr;
    FConexao.Query.ParamByName('pDocumentoOriginal').Value := pDocumentoOriginal;
    FConexao.Query.ParamByName('pDocumentoData').Value     := pDocumentoData;
    FConexao.Query.ParamByName('pDocumentoOriginal').Value := pDocumentoOriginal;
    FConexao.Query.ParamByName('pRegistroERP').Value       := pRegistroERP;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('EntradaInsert.Sql');
    FConexao.Query.Open;
    Result := FConexao.Query.FieldByName('PedidoId').AsInteger;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao. ' +StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
            '', [rfReplaceAll]));
    End;
  end;
end;

procedure TEntradaIntegracaoDao.SalvarEntradaItens(pConneXact: TConnection;
  pPedidoId, pIdProduto: Integer; pLote: String; pQtdXML: Integer);
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @PedidoId Integer = ' +
      pPedidoId.ToString());
    FConexao.Query.Sql.Add
      ('Declare @LoteId   Integer = (Select LoteId From ProdutoLotes Where ProdutoId = '
      + '(Select IdProduto From Produto Where CodProduto = ' +
      pIdProduto.ToString() + ')' + ' and DescrLote = ' +
      QuotedStr(pLote) + ')');
    FConexao.Query.Sql.Add('Declare @QtdXML Integer = ' + pQtdXML.ToString());
    FConexao.Query.Sql.Add(SqlEntradaItensInsert);
    // ClipBoard.AsText := FConexao.Query.Sql.ToString();
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - PedidoItens: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Procedure TEntradaIntegracaoDao.SalvarFornecedor(pConneXact: TConnection;
  pCodigo: Integer; pRazao, pFantasia, pCnpj, pEmail: String);
Var
  vQryFornecedor: TFDQuery;
begin
  Try
    Try
      vQryFornecedor := FConexao.GetQuery;
      vQryFornecedor.Sql.Add('Declare @CodPessoaERP Integer = ' +
        pCodigo.ToString());
      vQryFornecedor.Sql.Add('Declare @Razao VarChar(100) = ' +
        QuotedStr(pRazao));
      vQryFornecedor.Sql.Add('Declare @Fantasia VarChar(100) = ' +
        QuotedStr(pFantasia));
      vQryFornecedor.Sql.Add('Declare @CnpjCpf VarChar(14) = ' +
        QuotedStr(StringReplace(StringReplace(StringReplace(pCnpj, '.', '',
        [rfReplaceAll]), '-', '', [rfReplaceAll]), '/', '', [rfReplaceAll])));
      vQryFornecedor.Sql.Add('Declare @Email Varchar(100)  = ' +
        QuotedStr(pEmail));
      vQryFornecedor.Sql.Add(SqlFornecedorInsert);
      vQryFornecedor.ExecSQL;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: EntradaIntegracao - Destinatario: ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQryFornecedor.Close;
  End;
end;

Function TEntradaIntegracaoDao.SalvarLaboratorio(pConneXact: TConnection;
  pIdLaboratorio: Integer; pNome: String): Integer;
Var
  vQryLaboratorio: TFDQuery;
begin
  Try
    Try
      vQryLaboratorio := FConexao.GetQuery;
      vQryLaboratorio.Close;
      vQryLaboratorio.Sql.Add('Declare @IdLaboratorio Integer = ' +
        pIdLaboratorio.ToString());
      vQryLaboratorio.Sql.Add('Declare @Nome VarChar(50) = ' + QuotedStr(pNome));
      vQryLaboratorio.Sql.Add(SqlLaboratorioInsert);
      vQryLaboratorio.Sql.Add
        ('Select IdLaboratorio From Laboratorios Where Nome = ' +
        QuotedStr(pNome));
      vQryLaboratorio.Open;
      Result := vQryLaboratorio.FieldByName('IdLaboratorio').AsInteger;
    Except
      ON E: Exception do
      Begin
        vQryLaboratorio.Close;
        raise Exception.Create('Processo: EntradaIntegracao - Fabricantes: ' +  TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQryLaboratorio.Close;
  End;
end;

procedure TEntradaIntegracaoDao.SalvarProduto(pConneXact: TConnection;
  pCodProduto: Integer = 0; pDescricao: String = '';
  pSiglaUnidPrimaria: String = 'Un'; pQtdUnidPrimaria: Integer = 1;
  pSiglaUnidSecundaria: String = 'Un'; pFatorConversao: Integer = 1;
  pLaboratorioId: Integer = 0; pPeso: Integer = 1; pLiquido: Integer = 0;
  pPerigoso: Integer = 0; pInflamavel: Integer = 0; pAltura: Integer = 8;
  pLargura: Integer = 8; pComprimento: Integer = 8;
  pMesEntradaMinima: Integer = 0; pMesSaidaMinima: Integer = 0;
  pEan: String = '');
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @CodProduto Integer = ' +pCodProduto.ToString());
    FConexao.Query.Sql.Add('Declare @Descricao VarChar(80) = ' + QuotedStr(pDescricao));
    FConexao.Query.Sql.Add('Declare @SiglaUnidPrimaria VarChar(10) = ' + QuotedStr(pSiglaUnidPrimaria));
    FConexao.Query.Sql.Add('Declare @QtdUnidPrimaria Integer = ' + pQtdUnidPrimaria.ToString());
    FConexao.Query.Sql.Add('Declare @SiglaUnidSecundaria VarChar(10) = ' + QuotedStr(pSiglaUnidSecundaria));
    FConexao.Query.Sql.Add('Declare @QtdUnidSecundaria Integer = ' + pFatorConversao.ToString());
    FConexao.Query.Sql.Add('Declare @LaboratorioId Integer = ' + pLaboratorioId.ToString());
    FConexao.Query.Sql.Add('Declare @Peso Integer = ' + pPeso.ToString());
    FConexao.Query.Sql.Add('Declare @Liquido Integer = ' + pLiquido.ToString());
    FConexao.Query.Sql.Add('Declare @Perigoso Integer = ' + pPerigoso.ToString());
    FConexao.Query.Sql.Add('Declare @Inflamavel Integer = ' + pInflamavel.ToString());
    FConexao.Query.Sql.Add('Declare @Altura Integer = ' + pAltura.ToString());
    FConexao.Query.Sql.Add('Declare @Largura Integer = ' + pLargura.ToString());
    FConexao.Query.Sql.Add('Declare @Comprimento Integer = ' + pComprimento.ToString());
    FConexao.Query.Sql.Add('Declare @MesEntradaMinima Integer = ' + pMesEntradaMinima.ToString());
    FConexao.Query.Sql.Add('Declare @MesSaidaMinima Integer = ' + pMesSaidaMinima.ToString());
    FConexao.Query.Sql.Add('Declare @Ean VarChar(20) = ' + QuotedStr(pEan));
    FConexao.Query.Sql.Add(SqlProdutoInsert);
    Fconexao.Query.Execute;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - Produtos: '+StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;

end;

procedure TEntradaIntegracaoDao.SalvarProdutoCodbarras(pConneXact: TConnection;
  pCodProdutoERP: Integer; pEan: String);
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlInsProdutoCodBarras);
    if DebugHook <> 0 then Begin
       FConexao.Query.Sql.Add('--pCodProdutoERP  := '+pCodProdutoERP.ToString());
       FConexao.Query.Sql.Add('--pCodBarras := '+pEan);
    End;
    FConexao.Query.ParamByName('pCodProdutoERP').Value := pCodProdutoERP;
    FConexao.Query.ParamByName('pCodBarras').Value := pEan;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('SalvaProdutoCodBarras.Sql');
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - Código de Barras: '
        + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

procedure TEntradaIntegracaoDao.SalvarUnidades(pConneXact: TConnection;
  pSigla, pDescricao: String);
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @Sigla VarChar(10) = ' + QuotedStr(pSigla));
    FConexao.Query.Sql.Add('Declare @Descricao VarChar(20) = ' +
      QuotedStr(pDescricao));
    FConexao.Query.Sql.Add(SqlUnidadesInsert);
    FConexao.Query.ExecSQL;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - Fabricantes: ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEntradaIntegracaoDao.ValidaEntrada(pConneXact: TConnection;
  pCodPessoaERP: Integer; pDocumentoNr, pRegistroERP, pDocumentoData : String): Boolean;
begin
  Result := True;
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add(SqlGetValidaEntrada);
    FConexao.Query.Sql.Add('-- pCodPessoaERP  = ' + pCodPessoaERP.ToString());
    FConexao.Query.Sql.Add('-- pDocumentoNr   = ' + pDocumentoNr);
    FConexao.Query.Sql.Add('-- pRegistroERP   = ' + pRegistroERP);
    FConexao.Query.Sql.Add('-- pDocumentodata = ' + pDocumentoData);
    FConexao.Query.ParamByName('pCodPessoaERP').Value  := pCodPessoaERP;
    FConexao.Query.ParamByName('pDocumentoNr').Value   := pDocumentoNr;
    FConexao.Query.ParamByName('pRegistroERP').Value   := pRegistroERP;
    FConexao.Query.ParamByName('pDocumentoData').Value := pDocumentoData;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ValidaEntrada.Sql');

    FConexao.Query.Open;
    If Not FConexao.Query.IsEmpty Then
    Begin
      if ((FConexao.Query.FieldByName('ProcessoId').AsInteger > 4) and
        (FConexao.Query.FieldByName('ProcessoId').AsInteger <> 31)) or
        (FConexao.Query.FieldByName('Status').AsInteger = 2) then
        Result := false;
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: EntradaIntegracao - ValidarRecebimento: ' + Tutil.TratarExcessao(E.Message));
    End;
  end;
end;

procedure TEntradaIntegracaoDao.SalvarLogOld(pFuncao, pMensagem: String);
var
  vQryLog: TFDQuery;

  FconexaoLog: TConnection;
begin
  Try
    FconexaoLog := TConnection.Create(1);
    try
      vQryLog := FconexaoLog.Query;
      pMensagem := StringReplace(pMensagem, #39, '', [rfReplaceAll]);
      vQryLog.Sql.Add('Insert into LogOperacao Values (' + #39 + pFuncao + #39 +
        ', ' + #39 + pMensagem + #39 + ', GetDate(), GetDate())');
      If DebugHook <> 0 then
        vQryLog.Sql.SaveToFile('SalvarLogIntegracaoEntrada.Sql');
      vQryLog.ExecSQL;
    Except
    end;
  Finally
   vQryLog.Close;
  End;
end;

end.
