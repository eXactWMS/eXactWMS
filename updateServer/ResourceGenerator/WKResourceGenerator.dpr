program WKResourceGenerator;

uses
  System.StartUpCopy,
  FMX.Forms,
  view.main in 'view\view.main.pas' {fmain},
  service.resource.generator in 'service\service.resource.generator.pas',
  lib.Config in 'lib\lib.Config.pas',
  lib.Connection in 'lib\lib.Connection.pas',
  lib.util in 'lib\lib.util.pas',
  imp.model.postman in 'model\imp.model.postman.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
