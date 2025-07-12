unit Resources.kardex;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('kardex')]
   [Table('kardex')]

   TKardex = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('KARDEXID'  ,True, True,false, PrimaryKey)]
     Kardexid : double;
     [DBField('OPERACAOTIPOID'  ,True, True,True, null)]
     Operacaotipoid : Integer;
     [DBField('LOTEID'  ,True, True,True, null)]
     Loteid : Integer;
     [DBField('ENDERECOID'  ,True, True,True, null)]
     Enderecoid : Integer;
     [DBField('ESTOQUETIPOID'  ,True, True,True, null)]
     Estoquetipoid : Integer;
     [DBField('QTDE'  ,True, True,True, null)]
     Qtde : Integer;
     [DBField('SALDOINICIALORIGEM'  ,True, True,True, null)]
     Saldoinicialorigem : String;
     [DBField('SALDOFINALORIGEM'  ,True, True,True, null)]
     Saldofinalorigem : String;
     [DBField('OBSERVACAOORIGEM'  ,True, True,True, null)]
     Observacaoorigem : String;
     [DBField('ENDERECOIDDESTINO'  ,True, True,True, null)]
     Enderecoiddestino : Integer;
     [DBField('SALDOINICIALDESTINO'  ,True, True,True, null)]
     Saldoinicialdestino : Integer;
     [DBField('SALDOFINALDESTINO'  ,True, True,True, null)]
     Saldofinaldestino : Integer;
     [DBField('OBSERVACAODESTINO'  ,True, True,True, null)]
     Observacaodestino : String;
     [DBField('DATA'  ,True, True,True, null)]
     Data : Integer;
     [DBField('HORA'  ,True, True,True, null)]
     Hora : Integer;
     [DBField('USUARIOID'  ,True, True,True, null)]
     Usuarioid : Integer;
     [DBField('NOMEESTACAO'  ,True, True,True, null)]
     Nomeestacao : String;
     
	  
   end;

implementation

{TKardex }
procedure TKardex.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TKardex);

end.
