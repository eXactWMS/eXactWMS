unit uFrmFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPessoa, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid,
  cxPC, Vcl.Buttons, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  dxCameraControl, Vcl.ComCtrls, Vcl.DBGrids;

type
  TFrmFornecedor = class(TFrmPessoa)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFornecedor: TFrmFornecedor;

implementation

{$R *.dfm}

procedure TFrmFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmFornecedor := Nil;
end;

procedure TFrmFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  EdtRotaId.Visible   := False;
  LblRota.Visible     := False;
  BtnPesqRota.Visible := False;
  EdtTransportadoraId.Visible := False;
end;

end.
