unit UFrmBase4D;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Services.Base.Cadastro, UFrmBase, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.ImageList, Vcl.ImgList, AsgLinks,
  AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls,
  Vcl.Mask, JvExMask, JvSpin, acPNG, acImage, AdvLookupBar, AdvGridLookupBar,
  Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Buttons;

type
  TFrmBasePSV = class(TFrmBase)
    pnlFooter: TPanel;
    btnPrimeiro: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    btnUltimo: TSpeedButton;
    lblPagina: TLabel;
    pnlRegistros: TPanel;
    lblRegistros: TLabel;
    cmbRegistros: TComboBox;
    dsPesquisa: TDataSource;
    dsCadastro: TDataSource;
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure cmbRegistrosChange(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function GetPageLimit: Integer;
    procedure CalcularPaginacao;
    procedure ListarRegistros;
  protected
    FService: TServiceBaseCadastro;
    procedure DoBeforeList; virtual;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Function DeleteReg : Boolean; OverRide;
  public
    { Public declarations }
  end;

var
  FrmBasePSV: TFrmBasePSV;

implementation

{$R *.dfm}

{ TFrmBase1 }

procedure TFrmBasePSV.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = 1) then
    Exit;
  FService.Page := FService.Page - 1;
  ListarRegistros;
end;

procedure TFrmBasePSV.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if TsImage(sender).Enabled then Exit;
  dsCadastro.DataSet.Cancel;
end;

procedure TFrmBasePSV.BtnEditarClick(Sender: TObject);
begin
  inherited;
  FService.Alterar;
end;

procedure TFrmBasePSV.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmBasePSV.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  FService.Incluir;
end;

procedure TFrmBasePSV.btnPrimeiroClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = 1) then
    Exit;
  FService.Page := 1;
  ListarRegistros;
end;

procedure TFrmBasePSV.btnProximoClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = FService.Pages) then
    Exit;
  FService.Page := FService.Page + 1;
  ListarRegistros;
end;

procedure TFrmBasePSV.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  PanWin8.SetFocus;
//  SalvarReg;
end;

procedure TFrmBasePSV.btnUltimoClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = FService.Pages) then
    Exit;
  FService.Page := FService.Pages;
  ListarRegistros;
end;

procedure TFrmBasePSV.CalcularPaginacao;
var
  LTotalPaginas: Double;
begin
  if (FService.Page <= 0) then
    FService.Page := 1;
  LTotalPaginas := (FService.Records / GetPageLimit);
  FService.Pages := Trunc(LTotalPaginas);
  if ((LTotalPaginas - FService.Pages) > 0) or (FService.Pages = 0) then
     FService.Pages := FService.Pages + 1;
end;

procedure TFrmBasePSV.cmbRegistrosChange(Sender: TObject);
begin
  inherited;
  FService.PageLimit := GetPageLimit;
  FService.Page := 1;
  ListarRegistros;
end;

function TFrmBasePSV.DeleteReg: Boolean;
begin
  Result := False;
  Try
    FService.Excluir;
  Finally
    Result := True;
  End;

end;

procedure TFrmBasePSV.DoBeforeList;
begin

end;

procedure TFrmBasePSV.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if (dsCadastro.DataSet.State in dsEditModes) then
    PgcBase.ActivePage := TabPrincipal
  else
    PgcBase.ActivePage := TabListagem;
end;

procedure TFrmBasePSV.FormDestroy(Sender: TObject);
begin
  if Assigned(FService) then
    FService.Free;
  inherited;
end;

procedure TFrmBasePSV.FormShow(Sender: TObject);
begin
  inherited;
  dsPesquisa.DataSet := FService.mtPesquisa;
  dsCadastro.DataSet := FService.mtCadastro;
end;

procedure TFrmBasePSV.GetListaLstCadastro;
begin
  inherited;
  ListarRegistros;
end;

function TFrmBasePSV.GetPageLimit: Integer;
begin
  Result := StrToIntDef(cmbRegistros.Text, 50);
end;

procedure TFrmBasePSV.ListarRegistros;
begin
  DoBeforeList;
  FService.ListarRegistro;
  CalcularPaginacao;
  lblPagina.Caption := Format('Página %d de %d', [FService.Page, FService.Pages]);
end;

function TFrmBasePSV.SalvarReg: Boolean;
begin
  Result := False;
  Try
    FService.Salvar;
  Finally
    Result := True
  End;
end;

end.
