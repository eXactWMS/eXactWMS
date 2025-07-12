unit uFrmSair;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, acPNG, Vcl.ExtCtrls;

type
  TFrmSair = class(TForm)
    PnlSair: TPanel;
    ImgClose: TImage;
    ImgTrocaUser: TImage;
    ImgLockSys: TImage;
    ImgHome: TImage;
    LblTrocarUsuario: TLabel;
    LblBloquearAcesso: TLabel;
    LblRetornaTelaPrincipal: TLabel;
    LblSair: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    procedure ImgCloseClick(Sender: TObject);
    procedure LblRetornaTelaPrincipalClick(Sender: TObject);
    procedure LblTrocarUsuarioMouseEnter(Sender: TObject);
    procedure LblTrocarUsuarioMouseLeave(Sender: TObject);
    procedure ImgTrocaUserMouseLeave(Sender: TObject);
    procedure ImgLockSysMouseLeave(Sender: TObject);
    procedure ImgHomeMouseLeave(Sender: TObject);
    procedure ImgCloseMouseEnter(Sender: TObject);
    procedure ImgCloseMouseLeave(Sender: TObject);
    procedure ImgTrocaUserMouseEnter(Sender: TObject);
    procedure ImgLockSysMouseEnter(Sender: TObject);
    procedure ImgHomeMouseEnter(Sender: TObject);
    procedure LblTrocarUsuarioClick(Sender: TObject);
    procedure LblBloquearAcessoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSair: TFrmSair;

implementation

{$R *.dfm}

procedure TFrmSair.ImgCloseClick(Sender: TObject);
begin
  Close;
  ModalResult := MrOk;
end;

procedure TFrmSair.ImgCloseMouseEnter(Sender: TObject);
begin
  LblTrocarUsuarioMouseEnter(LblSair);
end;

procedure TFrmSair.ImgCloseMouseLeave(Sender: TObject);
begin
  LblTrocarUsuarioMouseLeave(LblSair);
end;

procedure TFrmSair.ImgHomeMouseEnter(Sender: TObject);
begin
  LblTrocarUsuarioMouseEnter(LblRetornaTelaPrincipal);
end;

procedure TFrmSair.ImgHomeMouseLeave(Sender: TObject);
begin
  LblTrocarUsuarioMouseLeave(LblRetornaTelaPrincipal);
end;

procedure TFrmSair.ImgLockSysMouseEnter(Sender: TObject);
begin
  LblTrocarUsuarioMouseEnter(LblBloquearAcesso);
end;

procedure TFrmSair.ImgLockSysMouseLeave(Sender: TObject);
begin
 LblTrocarUsuarioMouseLeave(LblBloquearAcesso);
end;

procedure TFrmSair.ImgTrocaUserMouseEnter(Sender: TObject);
begin
  LblTrocarUsuarioMouseEnter(LblTrocarUsuario);
end;

procedure TFrmSair.ImgTrocaUserMouseLeave(Sender: TObject);
begin
  LblTrocarUsuarioMouseLeave(LblTrocarUsuario);
end;

procedure TFrmSair.LblTrocarUsuarioClick(Sender: TObject);
begin
  Close;
  ModalResult := mrAbort;
end;

procedure TFrmSair.LblTrocarUsuarioMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsItalic];
end;

procedure TFrmSair.LblTrocarUsuarioMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
end;

procedure TFrmSair.LblBloquearAcessoClick(Sender: TObject);
begin
  Close;
  ModalResult := mrRetry;
end;

procedure TFrmSair.LblRetornaTelaPrincipalClick(Sender: TObject);
begin
  Close;
  ModalResult := mrIgnore;
end;

end.
