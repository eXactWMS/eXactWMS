unit Resources.pessoa;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('pessoa')]
   [Table('pessoa')]

   TPessoa = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('PESSOAID'  ,True, True,false, PrimaryKey)]
     Pessoaid : String;
     [DBField('CODPESSOAERP'  ,True, True,True, NotNull)]
     Codpessoaerp : Integer;
     [DBField('RAZAO'  ,True, True,True, NotNull)]
     Razao : String;
     [DBField('FANTASIA'  ,True, True,True, null)]
     Fantasia : String;
     [DBField('PESSOATIPOID'  ,True, True,True, null)]
     Pessoatipoid : Integer;
     [DBField('FONE'  ,True, True,True, null)]
     Fone : String;
     [DBField('CNPJCPF'  ,True, True,True, null)]
     Cnpjcpf : String;
     [DBField('EMAIL'  ,True, True,True, null)]
     Email : String;
     [DBField('HOMEPAGE'  ,True, True,True, null)]
     Homepage : String;
     [DBField('GOOGLEMAPS'  ,True, True,True, null)]
     Googlemaps : String;
     [DBField('LATITUDE'  ,True, True,True, null)]
     Latitude : String;
     [DBField('LONGITUDE'  ,True, True,True, null)]
     Longitude : String;
     [DBField('TRANSPORTADORAID'  ,True, True,True, null)]
     Transportadoraid : Integer;
     [DBField('STATUS'  ,True, True,True, null)]
     Status : Integer;
     [DBField('UUID'  ,True, True,True, null)]
     Uuid : String;
     [DBField('SHELFLIFE'  ,True, True,True, null)]
     Shelflife : Integer;
     
	  
   end;

implementation

{TPessoa }
procedure TPessoa.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TPessoa);

end.
