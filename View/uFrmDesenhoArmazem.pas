unit uFrmDesenhoArmazem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, System.JSOn,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, DesenhoArmazemCtrl, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmDesenhoArmazem = class(TFrmBase)
    Label2: TLabel;
    Label3: TLabel;
    EdtDescricao: TEdit;
    EdtDesenhoArmazemId: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure EdtDesenhoArmazemIdExit(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDesenhoArmazemIdEnter(Sender: TObject);
    procedure EdtDesenhoArmazemIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDesenhoArmazemIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EdtDescricaoExit(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
  private
    { Private declarations }
    ObjDesenhoArmazemCtrl : TDesenhoArmazemCtrl;
    Function GetListaDesenhoArmazem(pId : Integer; pDescricao : String) : Boolean;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmDesenhoArmazem: TFrmDesenhoArmazem;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmDesenhoArmazem.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtDesenhoArmazemId.ReadOnly := True;
  EdtDescricao.SetFocus;
end;

procedure TFrmDesenhoArmazem.BtnIncluirClick(Sender: TObject);
begin
  MensagemSis('Novo CD', 'Cadastro não permitido!', 'Fale com o Departamento Comercial', 'Rhemasys Soluções', False);
  Exit;

  inherited;
  //EdtDesenhoArmazemId.ReadOnly := False;
  EdtDescricao.SetFocus;
end;

function TFrmDesenhoArmazem.DeleteReg: Boolean;
begin
   Result := ObjDesenhoArmazemCtrl.DelArmazem;
end;

procedure TFrmDesenhoArmazem.EdtConteudoPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex in [0] then
     SoNumeros(Key);
end;

procedure TFrmDesenhoArmazem.EdtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender)
end;

procedure TFrmDesenhoArmazem.EdtDesenhoArmazemIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmDesenhoArmazem.EdtDesenhoArmazemIdExit(Sender: TObject);
Var JsonArrayDesenhoArmazem : TJsonArray;
    vErro : String;
begin
  if (EdtDesenhoArmazemId.Text<>'') and (StrToIntDef(EdtDesenhoArmazemId.Text, 0) <= 0) then Begin
     EdtDesenhoArmazemId.setFocus;
     ShowErro('Id do Armazém inválido!');
     EdtDesenhoArmazemId.Clear;
     Exit;
  End;  inherited;
  if (EdtDesenhoArmazemId.Text<>'') and (EdtDesenhoArmazemId.Text<>ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Descricao) then Begin
     Limpar;
     JsonArrayDesenhoArmazem := ObjDesenhoArmazemCtrl.GetDesenhoArmazem(StrToIntDef(EdtDesenhoArmazemId.Text, 0), '', 0);
     if JsonArrayDesenhoArmazem.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro('Erro: '+vErro);
        Exit;
     End;
     ObjDesenhoArmazemCtrl.ObjDesenhoArmazem := ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.JsonToClass((JsonArrayDesenhoArmazem.items[0] as TJsonObject).ToJSON);
     if ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Id > 0 then Begin
        ShowDados;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmDesenhoArmazem.EdtDesenhoArmazemIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmDesenhoArmazem.EdtDesenhoArmazemIdKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Not EdtDesenhoArmazemId.ReadOnly) and (Sender=EdtDesenhoArmazemId) then Begin
     EdtDescricao.Clear;
     Limpar;
  End;
end;

procedure TFrmDesenhoArmazem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmDesenhoArmazem := Nil;
end;

procedure TFrmDesenhoArmazem.FormCreate(Sender: TObject);
begin
  inherited;
  ObjDesenhoArmazemCtrl := TDesenhoArmazemCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0]  := 70;
    ColWidths[1]  := 150;
    ColWidths[2]  := 40;
    Alignments[0, 0]  := taRightJustify;
    FontStyles[0, 0]  := [FsBold];
  End;
  GetListaDesenhoArmazem(0, '');
end;

procedure TFrmDesenhoArmazem.FormDestroy(Sender: TObject);
begin
  ObjDesenhoArmazemCtrl.DisposeOf;
  inherited;
end;

function TFrmDesenhoArmazem.GetListaDesenhoArmazem(pId: Integer;
  pDescricao: String): Boolean;
Var JsonArrayArmazem : TJsonArray;
    xLista, xImg     : Integer;
    vErro            : String;
begin
  LstCadastro.RowCount := 1;
  ImprimirExportar(False);
  JsonArrayArmazem := ObjDesenhoArmazemCtrl.GetDesenhoArmazem(pId, pDescricao, 0);
  if Not JsonArrayArmazem.Items[0].TryGetValue('Erro', vErro) then Begin
     Result := (JsonArrayArmazem.Count >= 1);
     LstCadastro.RowCount := JsonArrayArmazem.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount do
       LstCadastro.AddDataImage( 2, xImg, 0, haCenter, vaTop);
     for xLista := 0 to Pred(JsonArrayArmazem.Count) do Begin
       LstCadastro.Cells[0, xLista+1] := JsonArrayArmazem.Items[xLista].GetValue<Integer>('id').ToString();
       LstCadastro.Cells[1, xLista+1] := JsonArrayArmazem.Items[xLista].GetValue<String>('descricao');
       LstCadastro.Cells[2, xLista+1] := JsonArrayArmazem.Items[xLista].GetValue<Integer>('status').ToString();
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
     End;
  End;
  LstCadastro.QSort;
  AdvGridLookupBar1.Column := 1;
end;

procedure TFrmDesenhoArmazem.GetListaLstCadastro;
begin
  inherited;
  GetListaDesenhoArmazem(0, '');
end;

procedure TFrmDesenhoArmazem.Limpar;
begin
  inherited;
  EnabledButtons := False;
  EdtDesenhoArmazemId.ReadOnly := False;
  EdtDescricao.Clear;
  ShCadastro.Brush.Color := ClRed;
  ShCadastro.Pen.Color   := ClRed;
  If Assigned(ObjDesenhoArmazemCtrl) Then ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Limpar;
end;

procedure TFrmDesenhoArmazem.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtDesenhoArmazemId.Text := LstCadastro.Cells[0, aRow];
  EdtDesenhoArmazemIdExit(EdtDesenhoArmazemId);
end;

function TFrmDesenhoArmazem.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para pesquisar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaDesenhoArmazem(StrToIntDef(EdtConteudoPesq.Text, 0), '')
        else raise Exception.Create('Id do Armazém inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then
        if Length(EdtConteudoPesq.Text) < 3 then
           raise Exception.Create('Digite ao menos 3 carater(es)!')
        Else
           Result := GetListaDesenhoArmazem(0, EdtConteudoPesq.Text);
     If Result then
        EdtConteudoPesq.Clear;
  End;
end;

function TFrmDesenhoArmazem.SalvarReg: Boolean;
Var vErro : String;
begin
  ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Id        := StrToIntDef(EdtDesenhoArmazemId.Text, 0);
  ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Descricao := EdtDescricao.Text;
  If ChkCadastro.Checked Then ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Status := 1
  Else ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Status := 0;
  If Not ObjDesenhoArmazemCtrl.Salvar.TryGetValue('Erro', vErro) then Begin
     ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Id := 0;
     Result := True
  End
  Else Result := False;
end;

procedure TFrmDesenhoArmazem.ShowDados;
begin
  inherited;
  If EdtDesenhoArmazemId.Text = '' then EdtDesenhoArmazemId.Text := ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Id.ToString();
  EdtDescricao.Text          := ObjDesenhoArmazemCtrl.ObjDesenhoArmazem.Descricao;
  ChkCadastro.Checked        := ObjDesenhOArmazemCtrl.ObjDesenhoArmazem.Status = 1;
  if ChkCadastro.Checked then Begin
    ShCadastro.Brush.Color := ClGreen;
    ShCadastro.Pen.Color   := ClGreen;
  End
  Else Begin
    ShCadastro.Brush.Color := ClRed;
    ShCadastro.Pen.Color   := ClRed;
  End;
end;

procedure TFrmDesenhoArmazem.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  If EdtDesenhoArmazemId.Enabled then
     EdtDesenhoArmazemId.SetFocus;
end;

end.
