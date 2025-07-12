unit Resources.pedido;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('pedido')]
   [Table('pedido')]

   TPedido = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('PEDIDOID'  ,True, True,false, PrimaryKey)]
     Pedidoid : String;
     [DBField('OPERACAOTIPOID'  ,True, True,True, NotNull)]
     Operacaotipoid : Integer;
     [DBField('OPERACAONATUREZAID'  ,True, True,True, null)]
     Operacaonaturezaid : Integer;
     [DBField('PESSOAID'  ,True, True,True, null)]
     Pessoaid : Integer;
     [DBField('DOCUMENTONR'  ,True, True,True, null)]
     Documentonr : String;
     [DBField('DOCUMENTOORIGINAL'  ,True, True,True, null)]
     Documentooriginal : String;
     [DBField('DOCUMENTODATA'  ,True, True,True, null)]
     Documentodata : Integer;
     [DBField('DTINCLUSAO'  ,True, True,True, null)]
     Dtinclusao : Integer;
     [DBField('HRINCLUSAO'  ,True, True,True, null)]
     Hrinclusao : Integer;
     [DBField('ARMAZEMID'  ,True, True,True, null)]
     Armazemid : Integer;
     [DBField('REGISTROERP'  ,True, True,True, null)]
     Registroerp : String;
     [DBField('STATUS'  ,True, True,True, null)]
     Status : Integer;
     [DBField('UUID'  ,True, True,True, null)]
     Uuid : String;
     [DBField('NOTAFISCALERP'  ,True, True,True, null)]
     Notafiscalerp : String;
     
	  
   end;

implementation

{TPedido }
procedure TPedido.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TPedido);

end.
