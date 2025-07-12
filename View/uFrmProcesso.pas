unit uFrmProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  Vcl.Imaging.jpeg, acImage, acPNG, dxGDIPlusClasses, cxPC, AdvUtil, AdvObj,
  BaseGrid, AdvGrid, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, Vcl.Mask,
  JvExMask, JvSpin, AdvLookupBar, AdvGridLookupBar;

type
  TFrmProcesso = class(TFrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProcesso: TFrmProcesso;

implementation

{$R *.dfm}

end.
