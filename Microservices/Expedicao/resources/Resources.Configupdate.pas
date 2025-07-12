unit Resources.configupdate;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('configupdate')]
   [Table('configupdate')]

   TConfigupdate = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('APKVERSION'  ,True, True,false, NotNull)]
     Apkversion : Integer;
     [DBField('LASTUPDATE'  ,True, True,True, null)]
     Lastupdate : TDateTime;
     [DBField('URLDOWLOAD'  ,True, True,True, null)]
     Urldowload : String;
     
	  
   end;

implementation

{TConfigupdate }
procedure TConfigupdate.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TConfigupdate);

end.
