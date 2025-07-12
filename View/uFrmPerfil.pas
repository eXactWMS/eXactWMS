unit uFrmPerfil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, DataSet.Serialize,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Generics.Collections,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC
  , PerfilClass, PerfilCtrl, Vcl.Buttons, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, System.Json, Rest.Json, Math,
  Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmPerfil = class(TFrmBase)
    EdtPerfilId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    btnPesquisar: TBitBtn;
    GbControleAcesso: TGroupBox;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    LstTopicoAcesso: TAdvStringGrid;
    LstFuncionalidadeAcesso: TAdvStringGrid;
    FdMemFuncionalidadesAcesso: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPerfilIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPerfilIdExit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtPerfilIdEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
    procedure EdtPerfilIdChange(Sender: TObject);
    procedure LstTopicoAcessoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstFuncionalidadeAcessoClickCell(Sender: TObject; ARow,
      ACol: Integer);
  private
    { Private declarations }
    ObjPerfilCtrl : TPerfilCtrl;
    function GetListaPerfil(pPerfil : String = ''): Boolean;
    Procedure GetControleAcessoTopicos;
    Procedure GetControleAcesoFuncionalidades(pListaTopicos : String);
    Procedure AtualizaAcessoTopico;
    Procedure MontaListaFuncionalidadesAcesso;
    Procedure FuncionalidadeAcessoAddDel(pFuncionalidadeId, pAcesso : Integer);
    procedure MontaListaTopicoPerfil;
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
  FrmPerfil: TFrmPerfil;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmPerfil.AtualizaAcessoTopico;
Var xFuncionalidade : Integer;
    xTopicoAcesso   : Boolean;
begin
  xTopicoAcesso := False;
  for xFuncionalidade := 1 to Pred(LstFuncionalidadeAcesso.RowCount) do  Begin
    if LstFuncionalidadeAcesso.Cells[2, xFuncionalidade] = '1' then Begin
       xTopicoAcesso := True;
       Break;
    End;
  End;
  if xTopicoAcesso then
     LstTopicoAcesso.Cells[2, LstTopicoAcesso.Row] := '1'
  Else LstTopicoAcesso.Cells[2, LstTopicoAcesso.Row] := '0';
end;

procedure TFrmPerfil.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
//  GbControleAcesso.Enabled := True;
end;

procedure TFrmPerfil.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  ObjPerfilCtrl.ObjPerfil.PerfilId  := StrToIntDef(EdtPerfilId.Text, 0);
  MontaListaTopicoPerfil;
//  GetControleAcessoTopicos;
//  GbControleAcesso.Enabled := True;
  LstFuncionalidadeAcesso.RowCount := 1;
  EdtDescricao.SetFocus;
end;

function TFrmPerfil.DeleteReg: Boolean;
begin
  Result := ObjPerfilCtrl.DelPerfil;
end;

procedure TFrmPerfil.edtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmPerfil.EdtPerfilIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtPerfilId.ReadOnly) and (StrToIntDef(EdtPerfilId.Text,0)<>ObjPerfilCtrl.ObjPerfil.PerfilId) then
     Limpar;
end;

procedure TFrmPerfil.EdtPerfilIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmPerfil.EdtPerfilIdExit(Sender: TObject);
begin
  inherited;
  if (Not EdtPerfilId.ReadOnly) and (EdtPerfilId.Text<>'') and (EdtPerfilId.Text<>'') then Begin
     Limpar;
     if StrToIntDef(EdtPerfilId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtPerfilId.Text+') inválido!');
     ObjPerfilCtrl.ObjPerfil := ObjPerfilCtrl.GetPerfil(EdtPerfilId.Text, 1)[0];
     if ObjPerfilCtrl.ObjPerfil.PerfilId > 0 then
        ShowDados;
  End;
end;

procedure TFrmPerfil.EdtPerfilIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPerfil := Nil;
end;

procedure TFrmPerfil.FormCreate(Sender: TObject);
begin
  inherited;
  ObjPerfilCtrl := TPerfilCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);;
    ColWidths[1] := 350+Trunc(350*ResponsivoVideo);;
    ColWidths[2] :=  40+Trunc(40*ResponsivoVideo);;
    ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);;
    ColWidths[4] :=  80+Trunc(80*ResponsivoVideo);;
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taCenter;
  End;
  With LstTopicoAcesso do Begin
    ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);;
    ColWidths[1] := 320+Trunc(320*ResponsivoVideo);;
    ColWidths[2] :=  45+Trunc(45*ResponsivoVideo);;
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taCenter;
  End;
  With LstFuncionalidadeAcesso do Begin
    ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[1] := 470+Trunc(470*ResponsivoVideo);
    ColWidths[2] :=  45+Trunc(45*ResponsivoVideo);
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taCenter;
  End;
  LstTopicoAcesso.Width         := LstTopicoAcesso.ColWidths[0]+LstTopicoAcesso.ColWidths[1]+LstTopicoAcesso.ColWidths[2]+30;
  LstFuncionalidadeAcesso.Left  := LstTopicoAcesso.Left+LstTopicoAcesso.Width+50;
  LstFuncionalidadeAcesso.Width := LstFuncionalidadeAcesso.ColWidths[0]+LstFuncionalidadeAcesso.ColWidths[1]+LstFuncionalidadeAcesso.ColWidths[2]+30;
  //GetListaPerfil;
end;

procedure TFrmPerfil.FuncionalidadeAcessoAddDel(pFuncionalidadeId,
  pAcesso: Integer);
begin
  If FdMemFuncionalidadesAcesso.Locate('FuncionalidadeId', pFuncionalidadeId, []) then Begin
     FdMemFuncionalidadesAcesso.Edit;
     FdMemFuncionalidadesAcesso.FieldByname('Acesso').Value := pAcesso;
     FdMemFuncionalidadesAcesso.Post;
  End;
end;

procedure TFrmPerfil.GetControleAcesoFuncionalidades(pListaTopicos: String);
Var JsonRetorno              : TJsonObject;
    JsonArrayFuncionalidades : TJsonArray;
    vErro : String;
begin
  JsonRetorno := ObjPerfilCtrl.ControleAcessoFuncionalidades('*');
  if JsonRetorno.TryGetValue<String>('Erro', vErro) then Begin
     LstFuncionalidadeAcesso.RowCount := 1;
     JsonRetorno := Nil;
     Exit;
  End;
  JsonArrayFuncionalidades := JsonRetorno.GetValue<TJsonArray>('funcionalidades');
  If FdMemFuncionalidadesAcesso.Active then
   FdMemFuncionalidadesAcesso.EmptyDataSet;
  FdMemFuncionalidadesAcesso.Close;
  FdMemFuncionalidadesAcesso.LoadFromJSON(JsonArrayFuncionalidades, False);
  JsonRetorno := Nil;
  JsonArrayFuncionalidades := Nil;
  MontaListaFuncionalidadesAcesso;
end;

procedure TFrmPerfil.GetControleAcessoTopicos;
Var JsonRetorno              : TJsonObject;
    JsonArrayTopicos         : TJsonArray;
    vErro         : String;
    xTopico, xImg : Integer;
begin
  JsonRetorno := ObjPerfilCtrl.ControleAcessoTopicos;
  if JsonRetorno.TryGetValue<String>('Erro', vErro) then Begin
     LstTopicoAcesso.RowCount := 1;
     Exit;
  End;
  JsonArrayTopicos         := JsonRetorno.GetValue<TJsonArray>('topicos');
  LstTopicoAcesso.RowCount  := JsonArrayTopicos.Count+1;
  LstTopicoAcesso.FixedRows := 1;
  for xImg := 1 to LstTopicoAcesso.RowCount - 1 do
  begin
    LstTopicoAcesso.AddDataImage(2, xImg, 0, haCenter, vaTop);
  end;
  for xTopico := 0 to Pred(JsonArrayTopicos.Count) do Begin
    LstTopicoAcesso.Cells[0, xTopico+1] := JsonArrayTopicos.Items[xTopico].GetValue<Integer>('topicoid').ToString();
    LstTopicoAcesso.Cells[1, xTopico+1] := JsonArrayTopicos.Items[xTopico].GetValue<string>('descricao');
    LstTopicoAcesso.Cells[2, xTopico+1] := JsonArrayTopicos.Items[xTopico].GetValue<Integer>('acesso').ToString();
    LstTopicoAcesso.FontStyles[0, xTopico+1] := [FsBold];
    LstTopicoAcesso.Alignments[0, xTopico+1] := taRightJustify;
    LstTopicoAcesso.Alignments[2, xTopico+1] := taCenter;
  End;
  if LstTopicoAcesso.RowCount>1 then
     LstTopicoAcesso.Row := 1;
end;

procedure TFrmPerfil.GetListaLstCadastro;
Begin
  inherited;
  GetListaPerfil;
end;

function TFrmPerfil.GetListaPerfil(pPerfil: String): Boolean;
Var xLista, xImg : Integer;
    LstPerfil    : TObjectList<TPerfil>;
begin
  if pPerfil = '' then pPerfil := '0';
  LstPerfil := ObjPerfilCtrl.GetPerfil(pPerfil, 0);
  Result := LstPerfil.Count >= 1;
  If LstPerfil.Count >= 1 then  Begin
     LstCadastro.RowCount := LstPerfil.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount - 1 do
       LstCadastro.AddDataImage(2, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstPerfil.Count-1 do begin
       With LstPerfil[xLista] do Begin
         LstCadastro.Cells[0, xLista+1] := PerfilId.ToString();
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
  LstPerfil.DisposeOf;
end;

procedure TFrmPerfil.Limpar;
begin
  EnabledButtons := False;
  if Not EdtPerfilId.Enabled then
     EdtPerfilId.Clear;
  If Assigned(ObjPerfilCtrl) Then ObjPerfilCtrl.ObjPerfil.Limpar;
  edtDescricao.Clear;
  ChkCadastro.Checked := False;
//  GbControleAcesso.Enabled := False;
  LstTopicoAcesso.RowCount := 1;
  LstFuncionalidadeAcesso.RowCount := 1;
end;

procedure TFrmPerfil.LstFuncionalidadeAcessoClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if LstFuncionalidadeAcesso.RowCount <= 1 then Exit;
  if (aCol = 2) And (ARow > 0) and (BtnSalvar.Enabled) then Begin
     If LstFuncionalidadeAcesso.Cells[2, ARow] = '1' then Begin
        LstFuncionalidadeAcesso.Cells[2, ARow] := '0';
        FuncionalidadeAcessoAddDel(LstFuncionalidadeAcesso.Ints[0, ARow], 0);
     End
     Else Begin
        LstFuncionalidadeAcesso.Cells[2, ARow] := '1';
        FuncionalidadeAcessoAddDel(LstFuncionalidadeAcesso.Ints[0, ARow], 1);
     End;
     AtualizaAcessoTopico;
  End;
end;

procedure TFrmPerfil.LstTopicoAcessoClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xTopicos : Integer;
    vListaTopicos : String;
begin
  inherited;
  if LstTopicoAcesso.RowCount <= 1 then Exit;
  if (aCol = 2) And (ARow > 0) and (BtnSalvar.Enabled) then Begin
     If LstTopicoAcesso.Cells[2, ARow] = '1' then
        LstTopicoAcesso.Cells[2, ARow] := '0'
     Else
       LstTopicoAcesso.Cells[2, ARow] := '1';
     vListaTopicos := '';
     for xTopicos := 1 to Pred(LstTopicoAcesso.RowCount) do
       if LstTopicoAcesso.Cells[2, xTopicos] = '1' then
          vListaTopicos := vListaTopicos+IfThen(vListaTopicos<>'',', ','') + LstTopicoAcesso.Cells[0, xTopicos];
     if vListaTopicos = '' then vListaTopicos := '0';
  End;
  MontaListaFuncionalidadesAcesso;
end;

procedure TFrmPerfil.MontaListaFuncionalidadesAcesso;
Var xFuncionalidade, xImg : Integer;
begin
  FdMemFuncionalidadesAcesso.Filter   := 'TopicoId = '+LstTopicoAcesso.Cells[0, LstTopicoAcesso.Row];
  FdMemFuncionalidadesAcesso.Filtered := True;
  FdMemFuncionalidadesAcesso.First;
  LstFuncionalidadeAcesso.RowCount  := FdMemFuncionalidadesAcesso.RecordCount+1;
  if Not FdMemFuncionalidadesAcesso.IsEmpty then Begin
     LstFuncionalidadeAcesso.FixedRows := 1;
     for xImg := 1 to FdMemFuncionalidadesAcesso.RecordCount do
       LstFuncionalidadeAcesso.AddDataImage(2, xImg, 0, haCenter, vaTop);
     for xFuncionalidade := 1 to FdMemFuncionalidadesAcesso.RecordCount do Begin
       LstFuncionalidadeAcesso.Cells[0, xFuncionalidade] := FdMemFuncionalidadesAcesso.FieldbyName('funcionalidadeid').AsString;
       LstFuncionalidadeAcesso.Cells[1, xFuncionalidade] := FdMemFuncionalidadesAcesso.FieldbyName('descricao').AsString;
       LstFuncionalidadeAcesso.Cells[2, xFuncionalidade] := FdMemFuncionalidadesAcesso.FieldbyName('acesso').AsString;
       LstFuncionalidadeAcesso.FontStyles[0, xFuncionalidade] := [FsBold];
       LstFuncionalidadeAcesso.Alignments[0, xFuncionalidade] := taRightJustify;
       LstFuncionalidadeAcesso.Alignments[2, xFuncionalidade] := taCenter;
       FdMemFuncionalidadesAcesso.Next;
     End;
  End;
  FdMemFuncionalidadesAcesso.Filter   := '';
  FdMemFuncionalidadesAcesso.Filtered := False;
end;

procedure TFrmPerfil.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtPerfilId.Text := LstCadastro.Cells[0, aRow];
  EdtPerfilIdExit(EdtPerfilId);
end;

function TFrmPerfil.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaPerfil(EdtConteudoPesq.Text)
        else raise Exception.Create('Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           raise Exception.Create('Realize a pesquisa por Id!')
        Else
           Result := GetListaPerfil(EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmPerfil.SalvarReg: Boolean;
Var vErro : String;
    xTopicos, xFuncionalidades : Integer;
    JsonArrayTopicos, JsonArrayFuncionalidades : TJsonArray;
    JsonTopicos, JsonFuncionalidades, JsonAcesso : TJsonObject;
    vOperacaoPerfil : String;
    JsonObjectRetorno : TJsonObject;
begin
  If ObjPerfilCtrl.ObjPerfil.PerfilId = 0 then
     vOperacaoPerfil := 'Novo Perfil'
  Else
     vOperacaoPerfil := 'Alteração de Perfil';
  ObjPerfilCtrl.ObjPerfil.PerfilId  := StrToIntDef(EdtPerfilId.Text, 0);
  ObjPerfilCtrl.ObjPerfil.Descricao := EdtDescricao.Text;
  If ChkCadastro.Checked Then ObjPerfilCtrl.ObjPerfil.Status := 1 Else ObjPerfilCtrl.ObjPerfil.Status := 0;
  //Controle de Acesso Padrão do Perfil
  JsonAcesso := TJsonObject.Create;
  JsonArrayTopicos         := TJsonArray.Create;
  JsonArrayFuncionalidades := TJsonArray.Create;
  for xTopicos := 1 to Pred(LstTopicoAcesso.RowCount) do Begin
    JsonTopicos := TJsonObject.Create;
    JsonTopicos.AddPair('topicoid', TJsonNumber.Create(LstTopicoAcesso.Cells[0, xTopicos].ToInteger()));
    JsonTopicos.AddPair('acesso',   TJsonNumber.Create(LstTopicoAcesso.Cells[2, xTopicos].ToInteger()));
    JsonArrayTopicos.AddElement(JsonTopicos);
  End;
  JsonAcesso.AddPair('topicos', JsonArrayTopicos);
  FdMemFuncionalidadesAcesso.First;
  While Not FdMemFuncionalidadesAcesso.Eof do Begin  //for xFuncionalidades := 1 to Pred(LstFuncionalidadeAcesso.RowCount) do Begin
    JsonFuncionalidades := TJsonObject.Create;
    JsonFuncionalidades.AddPair('funcionalidadeid', TJsonNumber.Create(FdMemFuncionalidadesAcesso.FieldByName('FuncionalidadeId').AsInteger));
    JsonFuncionalidades.AddPair('acesso',   TJsonNumber.Create(FdMemFuncionalidadesAcesso.FieldByName('Acesso').AsInteger));
    JsonArrayFuncionalidades.AddElement(JsonFuncionalidades);
    FdMemFuncionalidadesAcesso.Next;
  End;
  JsonAcesso.AddPair('funcionalidades', JsonArrayFuncionalidades);
  JsonObjectRetorno := ObjPerfilCtrl.Salvar;
  If Not JsonObjectRetorno.TryGetValue('Erro', vErro) then Begin
    ObjPerfilCtrl.ObjPerfil.PerfilId := JsonObjectRetorno.GetValue<Integer>('perfilid');
     Result := True;
     ObjPerfilCtrl.SalvarAcesso(JsonAcesso);
     if vOperacaoPerfil <> 'Novo Perfil' then Begin
        if Confirmacao(vOperacaoPerfil, 'Deseja alterar usuários deste perfil?', True) then
           ObjPerfilCtrl.AtualizarPermissao;
     End;
     JsonAcesso.DisposeOf;
     ObjPerfilCtrl.ObjPerfil.PerfilId := 0;
  End
  Else
     Result := False;
end;

procedure TFrmPerfil.ShowDados;
begin
  inherited;
  EdtPerfilId.Text    := ObjPerfilCtrl.ObjPerfil.PerfilId.ToString();
  edtDescricao.Text   := ObjPerfilCtrl.ObjPerfil.Descricao;
  ChkCadastro.Checked := ObjPerfilCtrl.ObjPerfil.Status = 1;
  MontaListaTopicoPerfil;
end;

Procedure TFrmPerfil.MontaListaTopicoPerfil;
Var xTopicos : Integer;
    vListaTopicos : String;
Begin
  GetControleAcessoTopicos;
  vListaTopicos := '';
  for xTopicos := 1 to Pred(LstTopicoAcesso.RowCount) do
    if LstTopicoAcesso.Cells[2, xTopicos] = '1' then
       vListaTopicos := vListaTopicos+IfThen(vListaTopicos<>'',', ','') + LstTopicoAcesso.Cells[0, xTopicos];
  if vListaTopicos = '' then vListaTopicos := '0';
  GetControleAcesoFuncionalidades(vListaTopicos);
  LstTopicoAcesso.Row := 1;
End;

end.
