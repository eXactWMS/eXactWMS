unit Resources.rotas;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('rotas')]
   [Table('rotas')]

   TRotas = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('ROTAID'  ,True, True,false, PrimaryKey)]
     Rotaid : String;
     [DBField('DESCRICAO'  ,True, True,True, null)]
     Descricao : String;
     [DBField('GOOGLEMAPS'  ,True, True,True, null)]
     Googlemaps : String;
     [DBField('LATITUDE'  ,True, True,True, null)]
     Latitude : String;
     [DBField('LONGITUDE'  ,True, True,True, null)]
     Longitude : String;
     [DBField('DTINCLUSAO'  ,True, True,True, null)]
     Dtinclusao : Integer;
     [DBField('HRINCLUSAO'  ,True, True,True, null)]
     Hrinclusao : Integer;
     [DBField('STATUS'  ,True, True,True, null)]
     Status : Integer;
     
	  
   end;

implementation

{TRotas }
procedure TRotas.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TRotas);

end.
