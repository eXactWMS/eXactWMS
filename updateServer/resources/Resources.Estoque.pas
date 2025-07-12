unit Resources.estoque;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('estoque')]
   [Table('estoque')]

   TEstoque = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('LOTEID'  ,True, True,false, PrimaryKey)]
     Loteid : Integer;
     [DBField('ENDERECOID'  ,True, True,True, PrimaryKey)]
     Enderecoid : Integer;
     [DBField('ESTOQUETIPOID'  ,True, True,True, PrimaryKey)]
     Estoquetipoid : Integer;
     [DBField('QTDE'  ,True, True,True, null)]
     Qtde : Integer;
     [DBField('DTINCLUSAO'  ,True, True,True, null)]
     Dtinclusao : Integer;
     [DBField('HRINCLUSAO'  ,True, True,True, null)]
     Hrinclusao : Integer;
     [DBField('USUARIOIDINC'  ,True, True,True, null)]
     Usuarioidinc : Integer;
     [DBField('DTALTERACAO'  ,True, True,True, null)]
     Dtalteracao : Integer;
     [DBField('HRALTERACAO'  ,True, True,True, null)]
     Hralteracao : Integer;
     [DBField('USUARIOIDALT'  ,True, True,True, null)]
     Usuarioidalt : Integer;
     
	  
   end;

implementation

{TEstoque }
procedure TEstoque.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TEstoque);

end.
