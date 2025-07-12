unit uFrmSobre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg, WinApi.ShellApi,
  dxGDIPlusClasses, acImage, acPNG;

type
  TfrmSobre = class(TForm)
    imgSobre: TImage;
    Label2: TLabel;
    lblCopyright: TLabel;
    Label4: TLabel;
    lblVersao: TLabel;
    BtnSair: TsImage;
    procedure FormCreate(Sender: TObject);
    procedure imgSobreDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnSairMouseEnter(Sender: TObject);
    procedure BtnSairMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

{$R *.dfm}

uses uFuncoes, DateUtils;

procedure TfrmSobre.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSobre.BtnSairMouseEnter(Sender: TObject);
begin
  BtnSair.Grayed := False;
end;

procedure TfrmSobre.BtnSairMouseLeave(Sender: TObject);
begin
  BtnSair.Grayed := True;
end;

procedure TfrmSobre.FormCreate(Sender: TObject);
begin
  //lblModulo.Caption    := Application.Name;
  lblVersao.Caption    := Versao;
  lblCopyright.Caption := 'Copyright(C) 2018-' + IntToStr(YearOf(Now)) + ' - RhemaSYS';
end;

procedure TfrmSobre.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then Close;
end;

procedure TfrmSobre.imgSobreDblClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://www.rhemasys.com.br/'), '', '', SW_SHOWNORMAL);
end;

end.
