unit Resources.configuracao;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('configuracao')]
   [Table('configuracao')]

   TConfiguracao = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('CADCLIENTEINCLUIR'  ,True, True,false, null)]
     Cadclienteincluir : Integer;
     [DBField('CADFORNECEDORINCLUIR'  ,True, True,True, null)]
     Cadfornecedorincluir : Integer;
     [DBField('CADPRODUTOINCLUIR'  ,True, True,True, null)]
     Cadprodutoincluir : Integer;
     [DBField('CADENTRADAINCLUIR'  ,True, True,True, null)]
     Cadentradaincluir : Integer;
     [DBField('ENTRADABLOQUEIOVENCIMENTO'  ,True, True,True, null)]
     Entradabloqueiovencimento : Integer;
     [DBField('SAIDABLOQUEIOVENCIMENTO'  ,True, True,True, null)]
     Saidabloqueiovencimento : Integer;
     [DBField('STATUSFORNECEDOR'  ,True, True,True, null)]
     Statusfornecedor : Integer;
     [DBField('STATUSCLIENTE'  ,True, True,True, null)]
     Statuscliente : Integer;
     [DBField('TAGPRODUTOENTRADA'  ,True, True,True, null)]
     Tagprodutoentrada : Integer;
     [DBField('CHECKINITEM'  ,True, True,True, null)]
     Checkinitem : Integer;
     [DBField('CADRASTROIDPRODNOVO'  ,True, True,True, null)]
     Cadrastroidprodnovo : Integer;
     [DBField('AUTORIZARALTLOTE'  ,True, True,True, null)]
     Autorizaraltlote : Integer;
     [DBField('SHELFLIFERECEBIMENTO'  ,True, True,True, null)]
     Shelfliferecebimento : Integer;
     [DBField('SHELFLIFEEXPEDICAO'  ,True, True,True, null)]
     Shelflifeexpedicao : Integer;
     [DBField('MESESPARAPREVENCIDO'  ,True, True,True, null)]
     Mesesparaprevencido : Integer;
     [DBField('ENDERECARPRODUTOENTRADA'  ,True, True,True, null)]
     Enderecarprodutoentrada : Integer;
     [DBField('CUBAGEMPRODUTOENTRADA'  ,True, True,True, null)]
     Cubagemprodutoentrada : Integer;
     [DBField('ENDERECOSEGREGADOID'  ,True, True,True, null)]
     Enderecosegregadoid : Integer;
     [DBField('ENDERECOIDVOLUMEEXPEDIDOCANCELADO'  ,True, True,True, null)]
     Enderecoidvolumeexpedidocancelado : Integer;
     [DBField('BALANCAPRECISAO'  ,True, True,True, null)]
     Balancaprecisao : Integer;
     [DBField('ESTEIRADESVIOROTA'  ,True, True,True, null)]
     Esteiradesviorota : Integer;
     [DBField('ESTEIRADESVIOAUDITORIA'  ,True, True,True, null)]
     Esteiradesvioauditoria : Integer;
     [DBField('ESTEIRATIPODESVIOAUDITORIA'  ,True, True,True, null)]
     Esteiratipodesvioauditoria : Integer;
     [DBField('PICKINGBYLIGHT'  ,True, True,True, null)]
     Pickingbylight : Integer;
     [DBField('PICKGINBYLIGHTMODELO'  ,True, True,True, null)]
     Pickginbylightmodelo : Integer;
     [DBField('PICKINGBYVOICE'  ,True, True,True, null)]
     Pickingbyvoice : Integer;
     [DBField('PICKGINBYVOICEMODELO'  ,True, True,True, null)]
     Pickginbyvoicemodelo : Integer;
     [DBField('MODELOPRINTERCODBARRA'  ,True, True,True, null)]
     Modeloprintercodbarra : String;
     [DBField('PORTAPRINTERCODBARRA'  ,True, True,True, null)]
     Portaprintercodbarra : String;
     [DBField('MODELOPRINTERGERENCIAL'  ,True, True,True, null)]
     Modeloprintergerencial : String;
     [DBField('PORTAPRINTERGERENCIAL'  ,True, True,True, null)]
     Portaprintergerencial : String;
     [DBField('REGAPANHE'  ,True, True,True, null)]
     Regapanhe : Integer;
     [DBField('APANHECONSOLIDADO'  ,True, True,True, null)]
     Apanheconsolidado : Integer;
     [DBField('PRINTERETQVOLUMEEXTRAAUTO'  ,True, True,True, null)]
     Printeretqvolumeextraauto : Integer;
     [DBField('BEEPPRODINDIVIDUAL'  ,True, True,True, null)]
     Beepprodindividual : Integer;
     [DBField('BEEPINDIVIDUALLIMITEUNID'  ,True, True,True, null)]
     Beepindividuallimiteunid : Integer;
     [DBField('IDENTCAIXAAPANHE'  ,True, True,True, null)]
     Identcaixaapanhe : Integer;
     [DBField('LACRESEGURANCA'  ,True, True,True, null)]
     Lacreseguranca : Integer;
     [DBField('CORTESUPERVISIONADO'  ,True, True,True, null)]
     Cortesupervisionado : Integer;
     [DBField('LOTEAPANHE'  ,True, True,True, null)]
     Loteapanhe : Integer;
     [DBField('INVENTARIOFORCARMAXCONTAGEM'  ,True, True,True, null)]
     Inventarioforcarmaxcontagem : Integer;
     [DBField('INVENTARIODIVERGENCIASEGREGADO'  ,True, True,True, null)]
     Inventariodivergenciasegregado : Integer;
     [DBField('INTEGRARAJUSTEERP'  ,True, True,True, null)]
     Integrarajusteerp : Integer;
     [DBField('TAGVOLUMEORDEM'  ,True, True,True, null)]
     Tagvolumeordem : Integer;
     [DBField('EMPRESA'  ,True, True,True, null)]
     Empresa : String;
     [DBField('SQL_CLIENT_NET_ADDRESS'  ,True, True,True, null)]
     SqlClientNetAddress : String;
     [DBField('REPOSICAOCOLETOR'  ,True, True,True, NotNull)]
     Reposicaocoletor : Integer;
     [DBField('REPOSICAOAUTOMATICA'  ,True, True,True, NotNull)]
     Reposicaoautomatica : Integer;
     [DBField('SCRIPTBD'  ,True, True,True, null)]
     Scriptbd : String;
     [DBField('TIPOAJUSTE'  ,True, True,True, NotNull)]
     Tipoajuste : Integer;
     [DBField('SEPARACAOFRACIONADOMETA'  ,True, True,True, NotNull)]
     Separacaofracionadometa : Integer;
     [DBField('SEPARACAOFRACIONADOTOLERANCIA'  ,True, True,True, NotNull)]
     Separacaofracionadotolerancia : Integer;
     [DBField('CHECKOUTFRACIONADOMETA'  ,True, True,True, NotNull)]
     Checkoutfracionadometa : Integer;
     [DBField('CHECKOUTFRACIONADOTOLERANCIA'  ,True, True,True, NotNull)]
     Checkoutfracionadotolerancia : Integer;
     [DBField('CHECKOUTCXAFECHADAMETA'  ,True, True,True, NotNull)]
     Checkoutcxafechadameta : Integer;
     [DBField('CHECKOUTCXAFECHADATOLERANCIA'  ,True, True,True, NotNull)]
     Checkoutcxafechadatolerancia : Integer;
     [DBField('EXPEDICAOMETA'  ,True, True,True, NotNull)]
     Expedicaometa : Integer;
     [DBField('EXPEDICAOTOLERANCIA'  ,True, True,True, NotNull)]
     Expedicaotolerancia : Integer;
     [DBField('ENDERECOIDSTAGE'  ,True, True,True, null)]
     Enderecoidstage : Integer;
     [DBField('DTULTIMOINVENTARIOGERAL'  ,True, True,True, null)]
     Dtultimoinventariogeral : TDate;
     [DBField('INTREGARAJUSTEERP'  ,True, True,True, null)]
     Intregarajusteerp : Integer;
     [DBField('MODELOETQVOLUME'  ,True, True,True, null)]
     Modeloetqvolume : Integer;
     [DBField('RECHECKOUTUSUARIO'  ,True, True,True, null)]
     Recheckoutusuario : Integer;
     [DBField('ENDERECOIDSTAGESNGPC'  ,True, True,True, NotNull)]
     Enderecoidstagesngpc : Integer;
     [DBField('ATIVARBACKUP'  ,True, True,True, NotNull)]
     Ativarbackup : Integer;
     [DBField('BACKUPBD'  ,True, True,True, null)]
     Backupbd : TDate;
     [DBField('VOLCXAFECHADAEXPEDICAO'  ,True, True,True, null)]
     Volcxafechadaexpedicao : Integer;
     [DBField('CHAVE_ENTRADA_INTEGRACAO'  ,True, True,True, null)]
     ChaveEntradaIntegracao : Integer;
     [DBField('SEPARACAOCODINTERNO'  ,True, True,True, null)]
     Separacaocodinterno : Integer;
     [DBField('REPOSICAOCOLETAPARAPICKING'  ,True, True,True, null)]
     Reposicaocoletaparapicking : Integer;
     
	  
   end;

implementation

{TConfiguracao }
procedure TConfiguracao.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TConfiguracao);

end.
