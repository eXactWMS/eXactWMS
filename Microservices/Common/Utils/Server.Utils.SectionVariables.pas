unit Server.Utils.SectionVariables;

interface
 uses
   classes;

type
  TSectionVariables =record
    IdEmpresa:string;
    Userid:integer;
    Camada:integer;
    IdPerfil:integer;
    IdColaborador:integer;
    IdRevenda:integer;
    IpClient:string;

  end;
  threadvar
   FTSectionVariables:TSectionVariables ;
implementation


end.
