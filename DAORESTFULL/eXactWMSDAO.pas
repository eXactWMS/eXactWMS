unit eXactWMSDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PerfilClass, System.JSON, REST.Json, Rest.Types;

Type

  TeXactWSMDAO = class
  private
    FeXactWSMDAO : TeXactWSMDAO;
  public
    constructor Create;
    Class Function eXactWMS : String;
    Class Function ServerBD : String;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

Class function TeXactWSMDAO.eXactWMS : String;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'eXactWMS';
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.StatusText
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Class function TeXactWSMDAO.ServerBD : String;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'serverbd';
  DmeXactWMS.RESTRequestWMS.Method := rmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.Content
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Constructor TeXactWSMDAO.Create;
begin
  Self.FeXactWSMDAO := TeXactWSMDAO.Create;
end;

end.
