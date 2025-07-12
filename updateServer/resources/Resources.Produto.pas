unit Resources.produto;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('produto')]
   [Table('produto')]

   TProduto = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('IDPRODUTO'  ,True, True,false, PrimaryKey)]
     Idproduto : String;
     [DBField('CODPRODUTO'  ,True, True,True, NotNull)]
     Codproduto : Integer;
     [DBField('DESCRICAO'  ,True, True,True, null)]
     Descricao : String;
     [DBField('DESCRREDUZIDA'  ,True, True,True, null)]
     Descrreduzida : String;
     [DBField('CODIGOMS'  ,True, True,True, null)]
     Codigoms : String;
     [DBField('PRODUTOTIPOID'  ,True, True,True, NotNull)]
     Produtotipoid : Integer;
     [DBField('UNIDADEID'  ,True, True,True, null)]
     Unidadeid : Integer;
     [DBField('QTDUNID'  ,True, True,True, null)]
     Qtdunid : Integer;
     [DBField('UNIDADESECUNDARIAID'  ,True, True,True, null)]
     Unidadesecundariaid : Integer;
     [DBField('FATORCONVERSAO'  ,True, True,True, null)]
     Fatorconversao : Integer;
     [DBField('ENDERECOID'  ,True, True,True, null)]
     Enderecoid : Integer;
     [DBField('RASTROID'  ,True, True,True, null)]
     Rastroid : Integer;
     [DBField('IMPORTADO'  ,True, True,True, null)]
     Importado : Integer;
     [DBField('MEDICAMENTOTIPOID'  ,True, True,True, null)]
     Medicamentotipoid : Integer;
     [DBField('SNGPC'  ,True, True,True, null)]
     Sngpc : Integer;
     [DBField('ARMAZENAMENTOZONAID'  ,True, True,True, null)]
     Armazenamentozonaid : Integer;
     [DBField('EANPRINCIPAL'  ,True, True,True, null)]
     Eanprincipal : String;
     [DBField('IDUNIDMEDINDUSTRIAL'  ,True, True,True, null)]
     Idunidmedindustrial : Integer;
     [DBField('LABORATORIOID'  ,True, True,True, null)]
     Laboratorioid : Integer;
     [DBField('PESOLIQUIDO'  ,True, True,True, null)]
     Pesoliquido : double;
     [DBField('LIQUIDO'  ,True, True,True, null)]
     Liquido : Integer;
     [DBField('PERIGOSO'  ,True, True,True, null)]
     Perigoso : Integer;
     [DBField('INFLAMAVEL'  ,True, True,True, null)]
     Inflamavel : Integer;
     [DBField('MEDICAMENTO'  ,True, True,True, null)]
     Medicamento : Integer;
     [DBField('ALTURA'  ,True, True,True, null)]
     Altura : double;
     [DBField('LARGURA'  ,True, True,True, null)]
     Largura : double;
     [DBField('COMPRIMENTO'  ,True, True,True, null)]
     Comprimento : double;
     [DBField('CURVA'  ,True, True,True, null)]
     Curva : String;
     [DBField('MINPICKING'  ,True, True,True, null)]
     Minpicking : Integer;
     [DBField('MAXPICKING'  ,True, True,True, null)]
     Maxpicking : Integer;
     [DBField('QTDREPOSICAO'  ,True, True,True, null)]
     Qtdreposicao : Integer;
     [DBField('PERCREPOSICAO'  ,True, True,True, null)]
     Percreposicao : Integer;
     [DBField('MESENTRADAMINIMA'  ,True, True,True, null)]
     Mesentradaminima : Integer;
     [DBField('MESSAIDAMINIMA'  ,True, True,True, null)]
     Messaidaminima : Integer;
     [DBField('UUID'  ,True, True,True, null)]
     Uuid : String;
     [DBField('STATUS'  ,True, True,True, null)]
     Status : Integer;
     [DBField('SOMENTECXAFECHADA'  ,True, True,True, null)]
     Somentecxafechada : Integer;
     
	  
   end;

implementation

{TProduto }
procedure TProduto.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TProduto);

end.
