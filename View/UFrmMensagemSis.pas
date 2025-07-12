unit UFrmMensagemSis;
//{$Include ..\DataLoja.Inc}

interface

uses
  winApi.Windows, WinApi.Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, dxGDIPlusClasses, acPNG, acImage,
  CurvyControls;

type
  TFrmMensagemSis = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Mensag1: TLabel;
    Mensag2: TLabel;
    ImgOk: TImage;
    ImgCancel: TImage;
    Pergunta: TLabel;
    LblConfirmSim: TLabel;
    LblConfirmNao: TLabel;
    PctSim: TsImage;
    PctNao: TsImage;
    BtnOk: TCurvyPanel;
    Label3: TLabel;
    Mensag3: TLabel;
    Mensag4: TLabel;
    procedure BitBtn2KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PctSimClick(Sender: TObject);
    procedure PctNaoClick(Sender: TObject);
    procedure BtnOkMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMensagemSis: TFrmMensagemSis;

implementation

{$R *.dfm}

Uses uFrmeXactWMS;

procedure TFrmMensagemSis.PctNaoClick(Sender: TObject);
begin
   ModalResult := MrNo;
   Close;
end;

procedure TFrmMensagemSis.BitBtn2KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFrmMensagemSis.PctSimClick(Sender: TObject);
begin
  ModalResult := MrOk;
end;

procedure TFrmMensagemSis.BtnOkMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  PctSimClick(PctSim);
end;

procedure TFrmMensagemSis.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key Of
     83: if (Shift = [ssAlt]) then PctSimClick(Sender);
     78: if (Shift = [ssAlt]) then PctNaoClick(Sender);
  end;
end;

procedure TFrmMensagemSis.FormResize(Sender: TObject);
begin
  Invalidate;
end;

procedure TFrmMensagemSis.FormShow(Sender: TObject);
begin
  ImgCancel.Top := ImgOk.Top;
  ImgCancel.Left := ImgOk.Left;
end;

end.
