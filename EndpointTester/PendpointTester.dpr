program PendpointTester;

uses
  System.StartUpCopy,
  FMX.Forms,
  tester.main in 'tester.main.pas' {Fmain},
  tester.service.http in 'service\tester.service.http.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFmain, Fmain);
  Application.Run;
end.
