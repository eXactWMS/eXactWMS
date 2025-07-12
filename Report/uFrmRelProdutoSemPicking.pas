unit uFrmRelProdutoSemPicking;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids;

type
  TFrmRelProdutoSemPicking = class(TFrmReportBase)
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralEmbalagem: TIntegerField;
    FdMemPesqGeralLargura: TFloatField;
    FdMemPesqGeralAltura: TFloatField;
    FdMemPesqGeralComprimento: TFloatField;
    FdMemPesqGeralVolume: TFloatField;
    FdMemPesqGeralPeso: TFloatField;
    FdMemPesqGeralCodProduto: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelProdutoSemPicking: TFrmRelProdutoSemPicking;

implementation

{$R *.dfm}

end.
