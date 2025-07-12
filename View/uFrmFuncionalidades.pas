unit uFrmFuncionalidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Generics.Collections,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC
  , FuncionalidadeClass, FuncionalidadeCtrl, Vcl.Buttons, Vcl.Mask, JvExMask,
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  dxCameraControl, Vcl.ComCtrls, Vcl.DBGrids;

type
  TFrmFuncionalidades = class(TFrmBase)
    EdtFuncionalidadeId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    edtDescricao: TLabeledEdit;
    procedure EdtFuncionalidadeIdExit(Sender: TObject);
    procedure EdtFuncionalidadeIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtFuncionalidadeIdEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
    procedure EdtFuncionalidadeIdChange(Sender: TObject);
  private
    { Private declarations }
    ObjFuncionalidadeCtrl : TFuncionalidadeCtrl;
    function GetListaFuncionaldades(pFuncionalidade : String = ''): Boolean;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmFuncionalidades: TFrmFuncionalidades;

implementation

{$R *.dfm}

uses uFuncoes;

{ TFrmFuncionalidades }

procedure TFrmFuncionalidades.BtnEditarClick(Sender: TObject);
begin
//  if (StrToIntDef(EdtFuncionalidade.Text, 0) <= 0) then
//     raise Exception.Create('Selecione o Id para alteração');
  inherited;
  EdtDescricao.SetFocus;
end;

procedure TFrmFuncionalidades.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
end;

function TFrmFuncionalidades.DeleteReg: Boolean;
begin
  Result := ObjFuncionalidadeCtrl.DelFuncionalidade;
end;

procedure TFrmFuncionalidades.edtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmFuncionalidades.EdtFuncionalidadeIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtFuncionalidadeId.ReadOnly) and (StrToIntDef(EdtFuncionalidadeId.Text,0)<>ObjFuncionalidadeCtrl.ObjFuncionalidade.Funcionalidadeid) then
     Limpar;
end;

procedure TFrmFuncionalidades.EdtFuncionalidadeIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmFuncionalidades.EdtFuncionalidadeIdExit(Sender: TObject);
begin
  inherited;
  if (EdtFuncionalidadeId.Text<>'') and (StrToIntDef(EdtFuncionalidadeId.Text, 0) <= 0) then Begin
     EdtFuncionalidadeId.SetFocus;
     ShowErro('Id('+EdtFuncionalidadeId.Text+') de Tópico inválido!');
     EdtFuncionalidadeId.Clear;
     Exit;
  End;
  if (Not EdtFuncionalidadeId.ReadOnly) and (EdtFuncionalidadeId.Text<>'') and (StrToIntDef(EdtFuncionalidadeId.Text,0)<>ObjFuncionalidadeCtrl.ObjFuncionalidade.Funcionalidadeid) then Begin
     Limpar;
     if StrToIntDef(EdtFuncionalidadeId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtFuncionalidadeId.Text+') inválido!');
     ObjFuncionalidadeCtrl.ObjFuncionalidade := ObjFuncionalidadeCtrl.GetFuncionalidade(EdtFuncionalidadeId.Text, 1)[0];
     if ObjFuncionalidadeCtrl.ObjFuncionalidade.Funcionalidadeid > 0 then
        ShowDados;
  End;
  ExitFocus(Sender);
end;

procedure TFrmFuncionalidades.EdtFuncionalidadeIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmFuncionalidades.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmFuncionalidades := Nil;
end;

procedure TFrmFuncionalidades.FormCreate(Sender: TObject);
begin
  inherited;
  ObjFuncionalidadeCtrl := TFuncionalidadeCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] := 70;
    ColWidths[1] := 450;
    ColWidths[2] := 40;
    ColWidths[3] := 80;
    ColWidths[4] := 80;
    Alignments[0 ,0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taCenter;
  End;
  GetListaFuncionaldades;
end;

function TFrmFuncionalidades.GetListaFuncionaldades(
  pFuncionalidade: String): Boolean;
Var xLista, xImg : Integer;
    LstFuncionalidades : TObjectList<TFuncionalidade>;
begin
  if pFuncionalidade = '' then pFuncionalidade := '0';
  LstFuncionalidades := ObjFuncionalidadeCtrl.GetFuncionalidade(pFuncionalidade, 0);
  Result := LstFuncionalidades.Count >= 1;
  If LstFuncionalidades.Count >= 1 then  Begin
     LstCadastro.RowCount := LstFuncionalidades.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount - 1 do
       LstCadastro.AddDataImage(2, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstFuncionalidades.Count-1 do begin
       With LstFuncionalidades[xLista] do Begin
         LstCadastro.Cells[0, xLista+1] := FuncionalidadeId.ToString();
         LstCadastro.Cells[1, xLista+1] := Descricao;
         LstCadastro.Cells[2, xLista+1] := Status.ToString;
         LstCadastro.Cells[3, xLista+1] := DateToStr(Data);
         LstCadastro.Cells[4, xLista+1] := TimeToStr(Hora);
       End;
       LstCadastro.Alignments[0 ,xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[2, xLista+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  LstFuncionalidades := Nil;
end;

procedure TFrmFuncionalidades.GetListaLstCadastro;
begin
  inherited;
  GetListaFuncionaldades;
End;

procedure TFrmFuncionalidades.Limpar;
begin
  EnabledButtons := False;
  if Not (EdtFuncionalidadeId.Enabled) then
     EdtFuncionalidadeId.Clear;
  If Assigned(ObjFuncionalidadeCtrl) Then ObjFuncionalidadeCtrl.ObjFuncionalidade.Limpar;
  edtDescricao.Clear;
  ChkCadastro.Checked := False;
end;

procedure TFrmFuncionalidades.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtFuncionalidadeId.Text := LstCadastro.Cells[0, aRow];
  EdtFuncionalidadeIdExit(EdtFuncionalidadeId);
end;

function TFrmFuncionalidades.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaFuncionaldades(EdtConteudoPesq.Text)
        else raise Exception.Create('Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           raise Exception.Create('Realize a pesquisa por Id!')
        Else
           Result := GetListaFuncionaldades(EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmFuncionalidades.SalvarReg: Boolean;
Var vErro : String;
begin
  ObjFuncionalidadeCtrl.ObjFuncionalidade.Funcionalidadeid  := StrToIntDef(EdtFuncionalidadeId.Text, 0);
  ObjFuncionalidadeCtrl.ObjFuncionalidade.Descricao := EdtDescricao.Text;
  If ChkCadastro.Checked Then ObjFuncionalidadeCtrl.ObjFuncionalidade.Status := 1 Else ObjFuncionalidadeCtrl.ObjFuncionalidade.Status := 0;
  If Not ObjFuncionalidadeCtrl.Salvar.TryGetValue('Erro', verro) then Begin
     ObjFuncionalidadeCtrl.ObjFuncionalidade.Funcionalidadeid := 0;
     Result := True
  End
  Else Result := False;
end;

procedure TFrmFuncionalidades.ShowDados;
begin
  inherited;
  EdtFuncionalidadeId.Text := ObjFuncionalidadeCtrl.ObjFuncionalidade.Funcionalidadeid.ToString();
  edtDescricao.Text        := ObjFuncionalidadeCtrl.ObjFuncionalidade.Descricao;
  ChkCadastro.Checked      := ObjFuncionalidadeCtrl.ObjFuncionalidade.Status = 1;
end;

end.
