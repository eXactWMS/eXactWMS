unit uFrmOperacaoTipo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB, Vcl.ExtDlgs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, cxPC, acPNG, acImage, dxGDIPlusClasses, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, OperacaoTipoCtrl, DataSet.Serialize,
  AdvUtil, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  AdvLookupBar, AdvGridLookupBar, AdvObj, BaseGrid, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ, Vcl.ComCtrls,
  dxCameraControl;

type
  TFrmOperacaoTipo = class(TFrmBase)
    edtCodigo: TLabeledEdit;
    CbOperacaoTipo: TComboBox;
    EdtDescricao: TLabeledEdit;
    Label2: TLabel;
    FdMemPesqGeralId: TIntegerField;
    FdMemPesqGeralDescriccao: TStringField;
    FdMemPesqGeralTipoOperacaoId: TIntegerField;
    FdMemPesqGeralStatus: TIntegerField;
    procedure BtnPesqConsGeralClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CbOperacaoTipoClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
  private
    { Private declarations }
    ObjOperacaoTipoCtrl : TOperacaoTipoCtrl;
  Protected
    Procedure ShowDados; override;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmOperacaoTipo: TFrmOperacaoTipo;

implementation

{$R *.dfm}

uses uFuncoes;

{ TFrmOperacaoTipo }

procedure TFrmOperacaoTipo.BtnEditarClick(Sender: TObject);
begin
  inherited;
  CbOperacaoTipo.SetFocus;
end;

procedure TFrmOperacaoTipo.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  If ObjOperacaoTipoCtrl.DelOperacaoTipo(StrToIntDef(EdtCodigo.Text, 0)) then
     Limpar;
end;

procedure TFrmOperacaoTipo.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbOperacaoTipo.SetFocus;
end;

procedure TFrmOperacaoTipo.BtnPesqConsGeralClick(Sender: TObject);
begin
  inherited;
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Informe o campo para pesquisar!');
     if not (FdMemPesqGeral.Active) then
       FdMemPesqGeral.Open;
     FdMemPesqGeral.EmptyDataSet;
     if (CbCampoPesq.ItemIndex = 0) and (StrToIntDef(EdtConteudoPesq.Text, 0)<>0) then
        FdMemPesqGeral.LoadFromJSON(ObjOperacaoTipoCtrl.FindOperacaoTipo(StrToIntDef(EdtConteudoPesq.Text, 0), ''), False)
     Else FdMemPesqGeral.LoadFromJSON(ObjOperacaoTipoCtrl.FindOperacaoTipo(0, EdtConteudoPesq.Text), False);
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmOperacaoTipo.BtnPesquisarStandClick(Sender: TObject);
begin
  inherited;
{
   if (PnlConsGeral.Visible) and (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text='') then Begin
      if not (FdMemPesqGeral.Active) then
        FdMemPesqGeral.Open;
      FdMemPesqGeral.EmptyDataSet;
      FdMemPesqGeral.LoadFromJSON(ObjOperacaoTipoCtrl.FindOperacaoTipo(0, '').ToString, False);
   End;

}end;

procedure TFrmOperacaoTipo.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  With ObjOperacaoTipoCtrl.ObjOperacaoTipo do Begin
     OperacaoTipoId := StrToIntDef(EdtCodigo.Text, 0);
     Descricao      := EdtDescricao.Text;
     //TipoOperacao := CbOperacaoTipo.ItemIndex;
     Status := Ord(ChkCadastro.Checked);
  End;
  If ObjOperacaoTipoCtrl.VerificaDados then Begin
     inherited;
     ObjOperacaoTipoCtrl.Salvar();
  End;
end;

procedure TFrmOperacaoTipo.CbOperacaoTipoClick(Sender: TObject);
begin
  inherited;
//  ObjOperacaoTipoCtrl.ObjOperacaoTipo.TipoOperacao :=
end;

procedure TFrmOperacaoTipo.edtCodigoChange(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (StrToIntDef(EdtCodigo.Text, 0)<>ObjOperacaoTipoCtrl.ObjOperacaoTipo.OperacaoTipoId) then
     Limpar;
end;

procedure TFrmOperacaoTipo.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmOperacaoTipo.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text<>'') and (StrToIntDef(EdtCodigo.Text, 0)<>ObjOperacaoTipoCtrl.ObjOperacaoTipo.OperacaoTipoId) then Begin
     Limpar;
     ObjOperacaoTipoCtrl.FindOperacaoTipo(StrToIntDef(EdtCodigo.Text, 0), '');
     ShowDados;
  End;
end;

procedure TFrmOperacaoTipo.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmOperacaoTipo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmOperacaoTipo := Nil;
end;

procedure TFrmOperacaoTipo.FormCreate(Sender: TObject);
begin
  inherited;
  ObjOperacaoTipoCtrl := TOperacaoTipoCtrl.Create;
end;

procedure TFrmOperacaoTipo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ObjOperacaoTipoCtrl);
end;

procedure TFrmOperacaoTipo.Limpar;
begin
  EnabledButtons := False;
  if Not EdtCodigo.Enabled then
     edtCodigo.Clear;
  If Assigned(ObjOperacaoTipoCtrl) Then ObjOperacaoTipoCtrl.ObjOperacaoTipo.Limpar;
  CbOperacaoTipo.ItemIndex := -1;
  EdtDescricao.Clear;
  ChkCadastro.Checked := False;
end;

procedure TFrmOperacaoTipo.ShowDados;
begin
  inherited;
  With ObjOperacaoTipoCtrl.ObjOperacaoTipo do Begin
    EdtCodigo.Text    := OperacaoTipoId.ToString();
    EdtDescricao.Text := Descricao;
//    CbOperacaoTipo.ItemIndex := IdTipoOperacao;
    ChkCadastro.Checked := Status =1;
  End;
end;

end.
