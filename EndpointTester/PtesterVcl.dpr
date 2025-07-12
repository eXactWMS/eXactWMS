program PtesterVcl;

uses
  Vcl.Forms,
  testervcl.main in 'testervcl.main.pas' {FmainVcl},
  tester.service.http in 'service\tester.service.http.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmainVcl, FmainVcl);
  Application.Run;
end.
