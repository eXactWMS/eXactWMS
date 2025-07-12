unit Resources.categorias;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('categorias')]
   [Table('categorias')]

   TCategorias = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('CATEGORIAID'  ,True, True,false, null)]
     Categoriaid : String;
     [DBField('DESCRICAO'  ,True, True,True, null)]
     Descricao : String;
     [DBField('SIGLA'  ,True, True,True, null)]
     Sigla : String;
     [DBField('STATUS'  ,True, True,True, null)]
     Status : Integer;
     
	  
   end;

implementation

{TCategorias }
procedure TCategorias.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TCategorias);

end.
