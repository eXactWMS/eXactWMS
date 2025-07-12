unit uFrmRelResumoPedidos;

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
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  dxCameraControl, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids;

type
  TFrmRelResumoPedidos = class(TFrmReportBase)
    FrxPedidoResumoAtendimento: TfrxReport;
    FDMemPedidoResumoAtendimento: TFDMemTable;
    frxDBPedidoResumoAtendimento: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelResumoPedidos: TFrmRelResumoPedidos;

implementation

{$R *.dfm}

procedure TFrmRelResumoPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  With FrxPedidoResumoAtendimento do Begin
    Variables['vModulo']  := frxReport1.Variables['vModulo']; //QuotedStr(pChar(Application.Title));
    Variables['vVersao']  := frxReport1.Variables['vVersao']; //QuotedStr(Versao);
    Variables['vUsuario'] := frxReport1.Variables['vUsuario']; //QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
  End;
end;

end.
