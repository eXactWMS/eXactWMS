unit UfrmEmbalagemCaixaManutenção;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin;

type
  TFrmBase1 = class(TFrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBase1: TFrmBase1;

implementation

{$R *.dfm}

end.
