unit uFrmTransportadora;

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
  AdvObj, BaseGrid, cxPC
  , PessoaCtrl;
type
  TFrmTransportadora = class(TFrmPessoa)
    procedure FormCreate(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
     ObjPessoaCtrl : TPessoaCtrl;
  Protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
  public
    { Public declarations }
  end;

var
  FrmTransportadora: TFrmTransportadora;

implementation

{$R *.dfm}

procedure TFrmTransportadora.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtRazao.SetFocus;
end;

procedure TFrmTransportadora.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtRazao.SetFocus;
end;

procedure TFrmTransportadora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmTransportadora := Nil;
end;

procedure TFrmTransportadora.FormCreate(Sender: TObject);
begin
  inherited;
  EdtRotaId.Visible    := False;
  LblRota.Visible      := False;
  BtnPesqRota.Visible  := False;
  EdtCodigoERP.Visible := False;
  LstCadastro.HideColumn(1);
end;

function TFrmTransportadora.PesquisarComFiltro(pCampo: Integer;
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
        Result := GetListaPessoa(0, 0, EdtConteudoPesq.Text)
     Else if CbCampoPesq.ItemIndex = 2 then //Fantasia
        Result := GetListaPessoa(0, 0, '', EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
  //if Result = False then
  //   raise Exception.Create('Não econtrei dados da pesquisa!');
end;

end.
