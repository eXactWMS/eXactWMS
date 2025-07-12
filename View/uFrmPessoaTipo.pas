unit uFrmPessoaTipo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Imaging.jpeg,
  cxPC, acImage, dxGDIPlusClasses, acPNG, PessoaTipoCtrl, Vcl.Buttons, AdvUtil,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, AdvLookupBar,
  AdvGridLookupBar, AdvObj, BaseGrid, System.Json, ImagePicker, Vcl.Mask,
  JvExMask, JvSpin, System.Generics.Collections;

type
  TFrmPessoaTipo = class(TFrmBase)
    edtCodigo: TLabeledEdit;
    EdtDescricao: TLabeledEdit;
    CbPessoaTipo: TComboBox;
    Label2: TLabel;
    FdMemPesqGeralId: TIntegerField;
    FdMemPesqGeralIdPessoaTipo: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralStatus: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure ConsGeralCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqConsGeralClick(Sender: TObject);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoChange(Sender: TObject);
  private
    { Private declarations }
    ObjPessoaTipoCtrl : TPessoaTipoCtrl;
    Procedure GetListaPessoaTipo(pPessoaTipoId : Integer = 0; pDescricao : String = '');
  Protected
    Procedure ShowDados; override;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmPessoaTipo: TFrmPessoaTipo;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmPessoaTipo.BtnEditarClick(Sender: TObject);
begin
  inherited;
  CbPessoaTipo.SetFocus;
end;

procedure TFrmPessoaTipo.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbPessoaTipo.SetFocus;
end;

procedure TFrmPessoaTipo.BtnPesqConsGeralClick(Sender: TObject);
begin
  inherited;
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        GetListaPessoaTipo(StrToIntDef(EdtConteudoPesq.Text,0), '')
     Else if CbCampoPesq.ItemIndex = 1 then //Razao Social
        GetListaPessoaTipo(0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmPessoaTipo.ConsGeralCellClick(Column: TColumn);
begin
  If (Not FdMemPesqGeral.IsEmpty) then With ObjPessoaTipoCtrl.ObjPessoaTipo do Begin
    PessoaTipoId := FdMemPesqGeral.FieldByName('Id').AsInteger;
    Descricao    := FdMemPesqGeral.FieldByName('Fone').AsString;
    Status       := FdMemPesqGeral.FieldByName('Status').Asinteger;
  End;
  inherited;
end;

procedure TFrmPessoaTipo.edtCodigoChange(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (StrToIntDef(EdtCodigo.Text,0)<>ObjPessoaTipoCtrl.ObjPessoaTipo.PessoaTipoId) then
     Limpar;
end;

procedure TFrmPessoaTipo.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text<>'') and (StrToIntDef(EdtCodigo.Text,0)<>ObjPessoaTipoCtrl.ObjPessoaTipo.PessoaTipoId) then Begin
     Limpar;
     ObjPessoaTipoCtrl.FindPessoaTipo(StrToIntDef(EdtCodigo.Text, 0), '', 1);
     ShowDados;
  End;
end;

procedure TFrmPessoaTipo.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoaTipo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPessoaTipo := Nil;
end;

procedure TFrmPessoaTipo.FormCreate(Sender: TObject);
begin
  inherited;
  ObjPessoaTipoCtrl := TPessoaTipoCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] := 40;
    ColWidths[1] := 300;
    ColWidths[2] := 60;
  End;
  GetListaPessoaTipo(0, '');
  LstCadastro.SortSettings.Column := 1;
  LstCadastro.QSort;
  AdvGridLookupBar1.Column := 1;
end;

procedure TFrmPessoaTipo.GetListaPessoaTipo(pPessoaTipoId: Integer;
  pDescricao: String);
Var ArrayListPessoa : tJsonArray;
    jSonObj         : tJsonObject;
    I, xLista       : Integer;
begin
  ArrayListPessoa := ObjPessoaTipoCtrl.FindPessoaTipo(pPessoaTipoId, pDescricao, 0);
  LstCadastro.RowCount := ArrayListPessoa.Count+1;
  for i := 1 to LstCadastro.RowCount - 1 do
  begin
    LstCadastro.AddDataImage(7,i,0,haCenter,vaTop);
  end;
  For xLista := 0 To ArrayListPessoa.Count-1 do begin
    jSonObj := tJsonObject.Create;
    jSonObj := ArrayListPessoa.Items[xLista] as TJSONObject;
    LstCadastro.Cells[0, xLista+1] := GetValueInjSon(jSonObj, 'Id');
    LstCadastro.Cells[1, xLista+1] := GetValueInjSon(jSonObj, 'Descricao');
    LstCadastro.Cells[2, xLista+1] := GetValueInjSon(jSonObj, 'status');
    jSonObj := Nil;
    jSonObj.DisposeOf;
    LstCadastro.Alignments[0, xLista+1] := taRightJustify;
    LstCadastro.FontStyles[0, xLista+1] := [FsBold];
  end;
End;

procedure TFrmPessoaTipo.Limpar;
begin
  if Not edtCodigo.Enabled then
     EdtCodigo.Clear;
  If Assigned(ObjPessoaTipoCtrl) Then ObjPessoaTipoCtrl.ObjPessoaTipo.Limpar;
  EdtDescricao.Clear;
  CbPessoaTipo.ItemIndex := -1;
  ChkCadastro.Checked    := False;
end;

procedure TFrmPessoaTipo.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
Var I : Integer;
begin
  inherited;
  if not Assigned(AEditLink) then
    Exit;
  If aCol = 2 then begin
     with (aEditLink.GetEditControl as TImagePicker) do begin
       BeginUpdate;
       Items.Clear;
       for i := 0 to 1 do
         Items.Add.ImageIndex := i;
       EndUpdate;
     end;
 end;
end;

procedure TFrmPessoaTipo.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if acol<2then LstCadastro.EditLink:=el1
  Else if acol=2 then LstCadastro.EditLink:=el6;
  if acol in [1,2] then aEditor:=edCustom;
end;

procedure TFrmPessoaTipo.ShowDados;
begin
  inherited;
  With ObjPessoaTipoCtrl.ObjPessoaTipo do Begin
    edtCodigo.Text    := PessoaTipoId.ToString();
    //CbPessoaTipo.ItemIndex := pessoaTipo;
    EdtDescricao.Text := Descricao;
    ChkCadastro.Checked := Status = 1;
  End;
end;

end.
