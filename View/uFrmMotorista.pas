unit uFrmMotorista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPessoa, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  JvExMask, JvSpin, acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids,
  AdvObj, BaseGrid, cxPC, Rest.Json, System.Json, Rest.Types
  , PessoaCtrl, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  dxCameraControl, Vcl.ComCtrls, Vcl.DBGrids;

type
  TFrmMotorista = class(TFrmPessoa)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtHomePageExit(Sender: TObject);
  private
    { Private declarations }
    ObjPessoaCtrl : TPessoaCtrl;
  Protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmMotorista: TFrmMotorista;

implementation

{$R *.dfm}

uses Views.Pequisa.Pessoas;

{ TFrmMotorista }

procedure TFrmMotorista.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtRazao.SetFocus;
end;

procedure TFrmMotorista.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtRazao.SetFocus;
end;

procedure TFrmMotorista.EdtHomePageExit(Sender: TObject);
begin
  inherited;
  if (Sender=EdtRazao) and (Not EdtRazao.ReadOnly) then
     EdtFantasia.Text := EdtRazao.Text
end;

procedure TFrmMotorista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmMotorista := Nil;
end;

procedure TFrmMotorista.FormCreate(Sender: TObject);
begin
  inherited;
  EdtRotaId.Visible    := False;
  LblRota.Visible      := False;
  BtnPesqRota.Visible  := False;
  EdtCodigoERP.Visible := False;
  LstCadastro.HideColumn(1);
  LstCadastro.HideColumn(3);
end;

procedure TFrmMotorista.Limpar;
begin
  inherited;
  LblTransportadora.Caption := '';
end;

function TFrmMotorista.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Begin //0 Id 1-Criar no server consulta por Cod.ERP
        If StrToInt64Def(EdtConteudoPesq.Text,0) = 0 then
           raise Exception.Create('Conteúdo para pesquisa inválido! Tente novamente.');
        Result := GetListaPessoa(StrToInt64Def(EdtConteudoPesq.Text,0), 0, '')
     End
     Else if CbCampoPesq.ItemIndex = 1 then //Razao Social
        Result := GetListaPessoa(0, 0, EdtConteudoPesq.Text);
//     Else if CbCampoPesq.ItemIndex = 2 then //Fantasia
//        Result := GetListaPessoa(0, 0, '', EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

end.
