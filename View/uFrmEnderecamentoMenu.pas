unit uFrmEnderecamentoMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls, acPNG, Vcl.Buttons;

type
  TFrmEnderecamentoMenu = class(TForm)
    PnHeader: TPanel;
    LblForm: TLabel;
    ImgClose: TImage;
    ImgMinimize: TImage;
    Image1: TImage;
    BtnArmazem: TPanel;
    ShpArmazem: TShape;
    SpbArmazem: TSpeedButton;
    PnlArmazem: TPanel;
    ImgArmazem: TImage;
    BtnZonas: TPanel;
    ShpZonas: TShape;
    SpbZonas: TSpeedButton;
    PnlZonas: TPanel;
    ImgZonas: TImage;
    BtnRuas: TPanel;
    ShpRuas: TShape;
    SpbRuas: TSpeedButton;
    PnlRuas: TPanel;
    ImgRuas: TImage;
    BtnEnderecos: TPanel;
    ShpEnderecos: TShape;
    SpbEnderecos: TSpeedButton;
    PnlEnderecos: TPanel;
    ImgEnderecos: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure SpbArmazemClick(Sender: TObject);
    procedure SpbZonasClick(Sender: TObject);
    procedure SpbRuasClick(Sender: TObject);
    procedure SpbEnderecosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEnderecamentoMenu: TFrmEnderecamentoMenu;

implementation

{$R *.dfm}

uses uFrmEnderecamento, uFrmDesenhoArmazem, uFrmEnderecamentoRuas,
  uFrmEnderecamentoZonas, uFrmeXactWMS;

procedure TFrmEnderecamentoMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    FrmEnderecamentoMenu := Nil;
end;

procedure TFrmEnderecamentoMenu.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmEnderecamentoMenu.SpbArmazemClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamento CD')) then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmDesenhoArmazem) = False) then
     FrmDesenhoArmazem := TFrmDesenhoArmazem.Create(Application);
  try
    FrmDesenhoArmazem.Module     := 'Logística';
    FrmDesenhoArmazem.ModuleMenu := 'Armazéns';
    FrmDesenhoArmazem.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmDesenhoArmazem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmEnderecamentoMenu.SpbZonasClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamento CD')) then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmEnderecamentoZonas) = False) then
     FrmEnderecamentoZonas := TFrmEnderecamentoZonas.Create(Application);
  try
    FrmEnderecamentoZonas.Module     := 'Logística';
    FrmEnderecamentoZonas.ModuleMenu := 'Zonas';
    FrmEnderecamentoZonas.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamentoZonas);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmEnderecamentoMenu.SpbEnderecosClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamento CD')) and
     (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamentos - Manutenção')) then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmEnderecamento) = False) then
     FrmEnderecamento := TFrmEnderecamento.Create(Application);
  try
    FrmEnderecamento.Module     := 'Logística';
    FrmEnderecamento.ModuleMenu := 'Endereçamento CD';
    FrmEnderecamento.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamento);
      raise Exception.Create('FrmEnderecamentos: '+e.Message);
    end;
  end;
end;

procedure TFrmEnderecamentoMenu.SpbRuasClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endereçamento CD')) then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmEnderecamentoRuas) = False) then
     FrmEnderecamentoRuas := TFrmEnderecamentoRuas.Create(Application);
  try
    FrmEnderecamentoRuas.Module     := 'Logística';
    FrmEnderecamentoRuas.ModuleMenu := 'Endereçamento Ruas';
    FrmEnderecamentoRuas.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamentoRuas);
      raise Exception.Create(e.Message);
    end;
  end;
end;

end.
