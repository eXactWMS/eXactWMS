unit Resources.cargas;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('cargas')]
   [Table('cargas')]

   TCargas = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('CARGAID'  ,True, True,false, PrimaryKey)]
     Cargaid : String;
     [DBField('ROTAID'  ,True, True,True, null)]
     Rotaid : Integer;
     [DBField('TRANSPORTADORAID'  ,True, True,True, null)]
     Transportadoraid : Integer;
     [DBField('VEICULOID'  ,True, True,True, null)]
     Veiculoid : Integer;
     [DBField('MOTORISTAID'  ,True, True,True, null)]
     Motoristaid : Integer;
     [DBField('DTINCLUSAO'  ,True, True,True, null)]
     Dtinclusao : TDate;
     [DBField('HRINCLUSAO'  ,True, True,True, null)]
     Hrinclusao : TTime;
     [DBField('USUARIOID'  ,True, True,True, null)]
     Usuarioid : Integer;
     [DBField('STATUS'  ,True, True,True, null)]
     Status : Integer;
     [DBField('UUID'  ,True, True,True, null)]
     Uuid : String;
     
	  
   end;

implementation

{TCargas }
procedure TCargas.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TCargas);

end.
