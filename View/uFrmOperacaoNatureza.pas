unit uFrmOperacaoNatureza;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB, Vcl.ExtDlgs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, cxPC, acPNG, acImage, dxGDIPlusClasses, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, OperacaoNaturezaCtrl, DataSet.Serialize,
  AdvUtil, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  AdvLookupBar, AdvGridLookupBar, AdvObj, BaseGrid, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ, Vcl.ComCtrls;

type
  TFrmOperacaoNatureza = class(TFrmBase)
    edtCodigo: TLabeledEdit;
    CbOperacaoTipo: TComboBox;
    EdtDescricao: TLabeledEdit;
    Label2: TLabel;
    FdMemPesqGeralId: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralTipo: TStringField;
    procedure BtnPesqConsGeralClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure ConsGeralCellClick(Column: TColumn);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
  private
    { Private declarations }
    ObjOperacaoNaturezaCtrl : TOperacaoNaturezaCtrl;
  Protected
    Procedure ShowDados; override;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmOperacaoNatureza: TFrmOperacaoNatureza;

implementation

{$R *.dfm}

uses uFuncoes;

{ TFrmTipoOperacao }

procedure TFrmOperacaoNatureza.BtnEditarClick(Sender: TObject);
begin
  inherited;
  CbOperacaoTipo.SetFocus;
end;

procedure TFrmOperacaoNatureza.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbOperacaoTipo.SetFocus;
end;

procedure TFrmOperacaoNatureza.BtnPesqConsGeralClick(Sender: TObject);
begin
  inherited;
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Informe o campo para pesquisar!');
     if not (FdMemPesqGeral.Active) then
       FdMemPesqGeral.Open;
     FdMemPesqGeral.EmptyDataSet;
     if (CbCampoPesq.ItemIndex = 0) and (StrToIntDef(EdtConteudoPesq.Text, 0)<>0) then
        FdMemPesqGeral.LoadFromJSON(ObjOperacaoNaturezaCtrl.FindOperacaoNatureza(StrToIntDef(EdtConteudoPesq.Text, 0), ''), False)
     Else FdMemPesqGeral.LoadFromJSON(ObjOperacaoNaturezaCtrl.FindOperacaoNatureza(0, EdtConteudoPesq.Text), False);
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmOperacaoNatureza.BtnPesquisarStandClick(Sender: TObject);
begin
  inherited;
{
   if (PnlConsGeral.Visible) and (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text='') then Begin
      if not (FdMemPesqGeral.Active) then
        FdMemPesqGeral.Open;
      FdMemPesqGeral.EmptyDataSet;
      FdMemPesqGeral.LoadFromJSON(ObjtipooperacaoCtrl.Findtipooperacao(0, '').ToString, False);
   End;

}end;

procedure TFrmOperacaoNatureza.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  With ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza do Begin
     OperacaoNaturezaId := StrToIntDef(EdtCodigo.Text, 0);
     Descricao         := EdtDescricao.Text;
     if CbOperacaoTipo.ItemIndex = 0 then
        Tipo := 'E' else Tipo := 'S';
  End;
  If ObjOperacaoNaturezaCtrl.VerificaDados then Begin
     inherited;
     ObjOperacaoNaturezaCtrl.Salvar();
  End;
end;

procedure TFrmOperacaoNatureza.ConsGeralCellClick(Column: TColumn);
begin
  If (Not FdMemPesqGeral.IsEmpty) then With ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza do Begin
     OperacaoNaturezaId := FdMemPesqGeral.FieldByName('Id').AsInteger;
     Descricao          := FdMemPesqGeral.FieldByName('Descricao').AsString;
     Tipo               := FdMemPesqGeral.FieldByName('Tipo').AsString;
  End;
  inherited;
end;

procedure TFrmOperacaoNatureza.edtCodigoChange(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (StrToInt64Def(EdtCodigo.Text,0)<>ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza.OperacaoNaturezaId) then
     Limpar;
end;

procedure TFrmOperacaoNatureza.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmOperacaoNatureza.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text<>'') and (StrToIntDef(EdtCodigo.Text,0)<>ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza.OperacaoNaturezaId) then Begin
     Limpar;
     ObjOperacaoNaturezaCtrl.FindOperacaoNatureza(StrToIntDef(EdtCodigo.Text, 0), '');
     ShowDados;
  End;
end;

procedure TFrmOperacaoNatureza.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Sonumeros(key);
end;

procedure TFrmOperacaoNatureza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmOperacaoNatureza := Nil;
end;

procedure TFrmOperacaoNatureza.FormCreate(Sender: TObject);
begin
  inherited;
  ObjOperacaoNaturezaCtrl := TOperacaoNaturezaCtrl.Create;
end;

procedure TFrmOperacaoNatureza.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ObjOperacaoNaturezaCtrl);
end;

procedure TFrmOperacaoNatureza.Limpar;
begin
  EnabledButtons := False;
  if Not EdtCodigo.Enabled then
     EdtCodigo.Clear;
  If Assigned(ObjOperacaoNaturezaCtrl) Then ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza.Limpar;
  EdtDescricao.Clear;
  ChkCadastro.Checked := False;
end;

procedure TFrmOperacaoNatureza.ShowDados;
begin
  inherited;
  With ObjOperacaoNaturezaCtrl.ObjOperacaoNatureza do Begin
    EdtCodigo.Text    := OperacaoNaturezaId.ToString();
    EdtDescricao.Text := Descricao;
    if tipo = 'E' then
       CbOperacaoTipo.ItemIndex := 0 Else CbOperacaoTipo.ItemIndex := 1;
  End;
end;

end.
