unit Views.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrmBase4D = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uFrmeXactWMS;

procedure TFrmBase4D.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmBase4D.FormCreate(Sender: TObject);
begin
  Top    := Round((FrmeXactWMS.Height-FrmeXactWMS.PnlTopRhemaSys.Height-Height)/2)+FrmeXactWMS.PnlTopRhemaSys.Height;  //Round(FrmeXactWMS.Top+FrmeXactWMS.PnlTopRhemaSys.Height);
  Left   := Round((FrmeXactWMS.Width-FrmeXactWMS.MenuSplit.Width-Width)/2)+FrmeXactWMS.MenuSplit.Width;  //Round(FrmeXactWMS.Top+FrmeXactWMS.PnlTopRhemaSys.Height);  //FrmeXactWMS.Left+FrmeXactWMS.MenuSplit.Width;
  //Height := Round(FrmBase.Height);
  //Width  := FrmBase.Width;
end;

procedure TFrmBase4D.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        SelectNext(ActiveControl as TWinControl, True, True);
        Key := 0;
      end;
  end;
end;

end.
