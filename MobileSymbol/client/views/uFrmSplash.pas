unit uFrmSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Effects;

type
  TFrmSplash = class(TForm)
    Timer1: TTimer;
    Fdo: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    AniIndicator1: TAniIndicator;
    Label2: TLabel;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Layout5: TLayout;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}

uses uFrmLogin;

procedure TFrmSplash.FormActivate(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TFrmSplash.Timer1Timer(Sender: TObject);
Var Form : TForm;
begin
  Timer1.Enabled := False;
  Try
    form := TFrmLogin.Create(Application);
    form.Show;
    Application.MainForm := form;
    Close;
    DisposeOf;
  Finally
    Form := Nil;
    Form.DisposeOf;
  End;
end;

end.

