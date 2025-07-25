unit MainDebug;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Horse, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    edtPort: TSpinEdit;
    Button1: TButton;
    leKey: TLabeledEdit;
    leCrt: TLabeledEdit;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    lePassword: TLabeledEdit;
    StatusBar1: TStatusBar;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function GetFile(const description, extension: string): string;
    procedure Start;
    procedure OnGetPassword(var Password: string);
  end;

var
  frmMain: TfrmMain;

implementation

uses IdSSLOpenSSL;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Start;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  leKey.Text := GetFile('Private Key', '*key');
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  leCrt.Text := GetFile('Public Key', '*crt');
end;

function TfrmMain.GetFile(const description, extension: string): string;
begin
  Result := '';
  OpenDialog1.Filter := description + '|' + extension;
  if OpenDialog1.Execute() then
  begin
    if OpenDialog1.FileName <> '' then
    begin
      Result := OpenDialog1.FileName;
    end;
  end;
end;

procedure TfrmMain.OnGetPassword(var Password: string);
begin
  Password := lePassword.Text;
end;

procedure TfrmMain.Start;
begin
// To use ssl it is necessary to have the ssl, libeay32.dll and ssleay32.dll
// libraries in your executable folder.
//
// Command to generate a self-signed certificate using openssl, on windows it is recommended to use git bash.
// openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cert.key -out cert.crt
//
// Not recommended for production, only for testing and internal use, for commercial use in production
// use a valid certificate, such as Let's Encrypt.

 

  THorse.Get('/ping',
    procedure(Res: THorseResponse)
    begin
      Res.Send('securite pong');
    end);

  THorse.Listen(edtPort.Value,
    procedure(Horse: THorse)
    begin
      StatusBar1.Panels.Items[0].Text := Format('Securite Server is running on https://%s:%d',
        [Horse.Host, Horse.Port]);
    end);
end;

end.
