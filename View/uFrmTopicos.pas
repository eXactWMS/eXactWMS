unit uFrmTopicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, Vcl.Buttons,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Generics.Collections
  , TopicosClass, TopicosCtrl
  , FuncionalidadeClass, FuncionalidadeCtrl, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase,
  ACBrETQ, dxCameraControl;

type
  TFrmTopicos = class(TFrmBase)
    EdtTopicoId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    edtDescricao: TLabeledEdit;
    LstAdvFuncionalidades: TAdvStringGrid;
    Panel1: TPanel;
    procedure EdtTopicoIdExit(Sender: TObject);
    procedure EdtTopicoIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure LstAdvFuncionalidadesClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtTopicoIdChange(Sender: TObject);
    procedure EdtTopicoIdEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ObjTopicoCtrl : TTopicosCtrl;
    function GetListaTopicos(pTopico : String = ''): Boolean;
    Procedure MontaListaFuncionalidades(pTopicoId : Integer);
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
  FrmTopicos: TFrmTopicos;

implementation

{$R *.dfm}

uses uFuncoes;

{ TFrmTopicos }

procedure TFrmTopicos.BtnEditarClick(Sender: TObject);
begin
  inherited;
//  LstAdvFuncionalidades.Enabled := True;
  EdtDescricao.SetFocus;
end;

procedure TFrmTopicos.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
end;

function TFrmTopicos.DeleteReg: Boolean;
begin
   Result := ObjTopicoCtrl.DelTopicos;
end;

procedure TFrmTopicos.edtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmTopicos.EdtTopicoIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtTopicoId.ReadOnly) and (StrToIntDef(EdtTopicoId.Text, 0)<>ObjTopicoCtrl.ObjTopicos.Topicoid) then
     Limpar;
  LstAdvFuncionalidades.RowCount := 1;
//  LstAdvFuncionalidades.Enabled := False;
end;

procedure TFrmTopicos.EdtTopicoIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmTopicos.EdtTopicoIdExit(Sender: TObject);
begin
  if (EdtTopicoId.Text<>'') and (StrToIntDef(EdtTopicoId.Text, 0) <= 0) then Begin
     EdtTopicoId.SetFocus;
     ShowErro('Id('+EdtTopicoId.Text+') de Tópico inválido!');
     EdtTopicoId.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtTopicoId.ReadOnly) and (EdtTopicoId.Text<>'') and (StrToIntDef(EdtTopicoId.Text,0)<>ObjTopicoCtrl.ObjTopicos.Topicoid) then Begin
     Limpar;
     if StrToIntDef(EdtTopicoId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtTopicoId.Text+') inválido!');
     ObjTopicoCtrl.ObjTopicos := ObjTopicoCtrl.GetTopicos(EdtTopicoId.Text, 1)[0];
     if ObjTopicoCtrl.ObjTopicos.TopicoId > 0 then
        ShowDados;
  End;
end;

procedure TFrmTopicos.EdtTopicoIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmTopicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmTopicos := Nil;
end;

procedure TFrmTopicos.FormCreate(Sender: TObject);
begin
  inherited;
  ObjTopicoCtrl := TTopicosCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] := 60+Trunc(60*ResponsivoVideo);;
    ColWidths[1] := 250+Trunc(250*ResponsivoVideo);
    ColWidths[2] := 40+Trunc(40*ResponsivoVideo);
    ColWidths[3] := 80+Trunc(80*ResponsivoVideo);
    ColWidths[4] := 80+Trunc(80*ResponsivoVideo);
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taCenter;
  End;
//  GetListaTopicos;
//Grid Funcionalidades do Tópico
  LstAdvFuncionalidades.ColWidths[0] := 50+Trunc(50*ResponsivoVideo);;
  LstAdvFuncionalidades.ColWidths[1] := 350+Trunc(350*ResponsivoVideo);
  LstAdvFuncionalidades.ColWidths[2] := 40+Trunc(40*ResponsivoVideo);;
  LstAdvFuncionalidades.Width := LstAdvFuncionalidades.ColWidths[0]+LstAdvFuncionalidades.ColWidths[1]+
                                 LstAdvFuncionalidades.ColWidths[2]+30;
  LstAdvFuncionalidades.Alignments[0, 0] := taRightJustify;
  LstAdvFuncionalidades.FontStyles[0, 0] := [FsBold];
  LstAdvFuncionalidades.Alignments[2, 0] := taCenter;
end;

procedure TFrmTopicos.FormDestroy(Sender: TObject);
begin
  inherited;
  ObjTopicoCtrl :=  Nil;
end;

procedure TFrmTopicos.GetListaLstCadastro;
begin
  inherited;
  GetListaTopicos;
end;

function TFrmTopicos.GetListaTopicos(pTopico: String): Boolean;
Var xLista, xImg : Integer;
    LstTopicos   : TObjectList<TTopicos>;
begin
  if pTopico = '' then pTopico := '0';
  LstTopicos := ObjTopicoCtrl.GetTopicos(pTopico, 0);
  Result := LstTopicos.Count >= 1;
  If LstTopicos.Count >= 1 then  Begin
     LstCadastro.RowCount := LstTopicos.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount do
       LstCadastro.AddDataImage(2, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstTopicos.Count-1 do begin
       With LstTopicos[xLista] do Begin
         LstCadastro.Cells[0, xLista+1] := TopicoId.ToString();
         LstCadastro.Cells[1, xLista+1] := Descricao;
         LstCadastro.Cells[2, xLista+1] := Status.ToString;
         LstCadastro.Cells[3, xLista+1] := DateToStr(Data);
         LstCadastro.Cells[4, xLista+1] := TimeToStr(Hora);
       End;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[2, xLista+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  LstTopicos := Nil;
end;

procedure TFrmTopicos.Limpar;
begin
  EnabledButtons := False;
  if Not EdtTopicoId.Enabled then
     EdtTopicoId.Clear;
  If Assigned(ObjTopicoCtrl) Then ObjTopicoCtrl.ObjTopicos.Limpar;
  EdtDescricao.Clear;
  ChkCadastro.Checked    := False;
  ShCadastro.Brush.Color := ClRed;
  ShCadastro.Pen.Color   := ClRed;
end;

procedure TFrmTopicos.LstAdvFuncionalidadesClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ObjFuncionalidadeCtrl : TFuncionalidadeCtrl;
begin
  inherited;
  if LstAdvFuncionalidades.RowCount <= 1 then Exit;
  if Arow = 0 then
     LstCadastroClickCell(Sender, aRow, aCol)
  Else if (aCol = 2) And (ARow > 0) and (BtnSalvar.Enabled) then Begin
     ObjFuncionalidadeCtrl := TFuncionalidadeCtrl.Create;
     If LstAdvFuncionalidades.Cells[2, ARow] = '1' then
        LstAdvFuncionalidades.Cells[2, ARow] := '0'
     Else
       LstAdvFuncionalidades.Cells[2, ARow] := '1';
     ObjFuncionalidadeCtrl.SalvarTopicoFuncionalidade(StrToInt(EdtTopicoId.Text),
                                                      LstAdvFuncionalidades.Cells[0, ARow].ToInteger,
                                                      LstAdvFuncionalidades.Cells[2, ARow].ToInteger);
  End;
end;

procedure TFrmTopicos.MontaListaFuncionalidades(pTopicoId : Integer);
Var ObjFuncionalidadeCtrl : TFuncionalidadeCtrl;
    LstFuncionalidades : TObjectList<TFuncionalidade>;
    xItens : Integer;
begin
  ObjFuncionalidadeCtrl := TFuncionalidadeCtrl.Create;
  LstFuncionalidades    := ObjFuncionalidadeCtrl.GetTopicoFuncionalidades(pTopicoId);
  LstAdvFuncionalidades.RowCount  := LstFuncionalidades.Count+1;
  LstAdvFuncionalidades.FixedRows := 1;
  For xItens := 1 to LstFuncionalidades.Count do
    LstAdvFuncionalidades.AddDataImage(2, xItens, 0, haCenter, vaTop);
  For xItens := 0 to Pred(LstFuncionalidades.Count) do Begin
    LstAdvFuncionalidades.Cells[0, xItens+1] := LstFuncionalidades[xItens].FuncionalidadeId.Tostring();
    LstAdvFuncionalidades.Cells[1, xItens+1] := LstFuncionalidades[xItens].Descricao;
    LstAdvFuncionalidades.Cells[2, xItens+1] := LstFuncionalidades[xItens].Status.ToString();
    LstAdvFuncionalidades.Alignments[0, xItens+1] := taRightJustify;
    LstAdvFuncionalidades.FontStyles[0, xItens+1] := [FsBold];
    LstAdvFuncionalidades.Alignments[2, xItens+1] := taCenter;
  End;
  ObjFuncionalidadeCtrl := Nil;
  LstFuncionalidades    := Nil;
end;

procedure TFrmTopicos.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtTopicoId.Text := LstCadastro.Cells[0, aRow];
  EdtTopicoIdExit(EdtTopicoId);
end;

function TFrmTopicos.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaTopicos(EdtConteudoPesq.Text)
        else raise Exception.Create('Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           raise Exception.Create('Realize a pesquisa por Id!')
        Else
           Result := GetListaTopicos(EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmTopicos.SalvarReg: Boolean;
Var vErro : String;
begin
  ObjTopicoCtrl.ObjTopicos.Topicoid  := StrToIntDef(EdtTopicoId.Text, 0);
  ObjTopicoCtrl.ObjTopicos.Descricao := EdtDescricao.Text;
  If ChkCadastro.Checked Then ObjTopicoCtrl.ObjTopicos.Status := 1 Else ObjTopicoCtrl.ObjTopicos.Status := 0;
  If Not ObjTopicoCtrl.Salvar.TryGetValue('Erro', verro) then Begin
     ObjTopicoCtrl.ObjTopicos.Topicoid := 0;
     Result := True
  End
  Else Result := False;
end;

procedure TFrmTopicos.ShowDados;
begin
  inherited;
  EdtTopicoId.Text    := ObjTopicoCtrl.ObjTopicos.Topicoid.ToString();
  edtDescricao.Text   := ObjTopicoCtrl.ObjTopicos.Descricao;
  ChkCadastro.Checked := ObjTopicoCtrl.ObjTopicos.Status = 1;
  MontaListaFuncionalidades(ObjTopicoCtrl.ObjTopicos.Topicoid);
end;

end.
