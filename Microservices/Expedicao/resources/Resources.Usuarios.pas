unit Resources.usuarios;
interface
uses
  System.Classes,
  Server.Attributes,
  System.Generics.Collections,
  Server.ResourceBaseClass;
type

   [Resource('usuarios')]
   [Table('usuarios')]

   TUsuarios = class(TResourceBaseClass)
   private
      
   protected
      procedure ValidateBusiness(List: TObjectList<TObject>); override; 
   public
     [DBField('USUARIOID'  ,True, True,false, PrimaryKey)]
     Usuarioid : String;
     [DBField('LOGIN'  ,True, True,false, NotNull)]
     Login : String;
     [DBField('NOME'  ,True, True,false, NotNull)]
     Nome : String;
     [DBField('SENHA'  ,True, True,false, NotNull)]
     Senha : String;
     [DBField('SENHAPADRAO'  ,True, True,false, null)]
     Senhapadrao : Integer;
     [DBField('DIASSENHAVALIDA'  ,True, True,false, null)]
     Diassenhavalida : Integer;
     [DBField('EMAIL'  ,True, True,false, null)]
     Email : String;
     [DBField('PERFILID'  ,True, True,false, null)]
     Perfilid : Integer;
     [DBField('DTULTIMAALTERACAOSENHA'  ,True, True,false, null)]
     Dtultimaalteracaosenha : Integer;
     [DBField('HRULTIMAALTERACAOSENHA'  ,True, True,false, null)]
     Hrultimaalteracaosenha : Integer;
     [DBField('DTINCLUSAO'  ,True, True,false, null)]
     Dtinclusao : Integer;
     [DBField('HRINCLUSAO'  ,True, True,false, null)]
     Hrinclusao : Integer;
     [DBField('STATUS'  ,True, True,false, null)]
     Status : Integer;
     [DBField('FOTO'  ,True, True,false, null)]
     Foto : TBytea;
     [DBField('UUID'  ,True, True,false, null)]
     Uuid : String;
     
	  
   end;

implementation

{TUsuarios }
procedure TUsuarios.ValidateBusiness(List: TObjectList<TObject>);
begin
end;
initialization

RegisterClass(TUsuarios);

end.
