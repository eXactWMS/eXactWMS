unit uFrmUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, DataSet.Serialize,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, ImagePicker,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, System.Json, Rest.Json
  , UsuarioCtrl, JvToolEdit, Vcl.Mask, JvExMask, JvBaseEdits, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.Buttons, Generics.Collections,
  Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ, dxCameraControl,
  Views.Pequisa.Perfil, Vcl.DialogMessage;

type
  TFrmUsuario = class(TFrmBase)
    edtCodigo: TLabeledEdit;
    EdtLogin: TLabeledEdit;
    EdtNome: TLabeledEdit;
    Label2: TLabel;
    EdtSenha: TEdit;
    ChkSenhaPadrao: TCheckBox;
    Label22: TLabel;
    EdtDiasSenhaValida: TJvCalcEdit;
    Label3: TLabel;
    EdtEmail: TLabeledEdit;
    Panel1: TPanel;
    Label5: TLabel;
    EdtDtUltimaAlteracaoSenha: TJvDateEdit;
    Label4: TLabel;
    EdtHrUltimaAlteracaoSenha: TLabeledEdit;
    BtnPesqPerfil: TBitBtn;
    LblPerfil: TLabel;
    Label6: TLabel;
    EdtPerfilId: TEdit;
    BalloonHint2: TBalloonHint;
    GbControleAcesso: TGroupBox;
    Panel2: TPanel;
    LstTopicoAcesso: TAdvStringGrid;
    LstFuncionalidadeAcesso: TAdvStringGrid;
    Bevel1: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    DBGrid1: TDBGrid;
    CheckBox1: TCheckBox;
    ChkConectado: TCheckBox;
    ShpConectado: TShape;
    LblDetalheConectado: TLabel;
    TabUsuarioConectado: TcxTabSheet;
    LstUsuarioConectado: TAdvStringGrid;
    FdMemUsuarioConectado: TFDMemTable;
    DsUsuarioConectado: TDataSource;
    ChkSomenteAtivo: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtLoginExit(Sender: TObject);
    procedure EdtNomeExit(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure EdtPerfilIdExit(Sender: TObject);
    procedure EdtPerfilIdChange(Sender: TObject);
    procedure LstTopicoAcessoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstFuncionalidadeAcessoClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure LstTopicoAcessoClick(Sender: TObject);
    procedure LstFuncionalidadeAcessoClick(Sender: TObject);
    procedure EdtSenhaChange(Sender: TObject);
    procedure BtnPesqPerfilClick(Sender: TObject);
    procedure EdtPerfilIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPerfilIdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChkConectadoClick(Sender: TObject);
    procedure TabUsuarioConectadoShow(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure TabUsuarioConectadoExit(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure DbgImportaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EdtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChkSomenteAtivoClick(Sender: TObject);
  private
    { Private declarations }
    ObjUsuarioCtrl : TUsuarioCtrl;
    SelectFuncionalidades : Integer;
    Senha_Update : Boolean;
    Function GetListaUsuario(pUsuarioId : Integer = 0; pLogin : String = ''; pNome : String = ''; pSomenteAtivo : Integer = -1) : Boolean;
    Procedure GetControleAcesso;
    Procedure GetPerfilAcessoTopicos;
    procedure GetPerfilAcessoFuncionalidades;
    Procedure SelectFuncionalidade(pTopicoId, pSelectOnOff, pUpdate : Integer);
    Procedure MarkTopico(pTopicoId : Integer);
    Procedure DefineField;
    Procedure AtualizaAcessoTopico;
  Protected
    Function DeleteReg : Boolean; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure Limpar; OverRide;
    Function SavePhoto : Boolean; OverRide;
    procedure OpenFileImport; OverRide;
  public
    { Public declarations }
  end;

var
  FrmUsuario: TFrmUsuario;

implementation

{$R *.dfm}

uses uFuncoes, PerfilCtrl, PerfilClass;

procedure TFrmUsuario.BtnPesqPerfilClick(Sender: TObject);
begin
  inherited;
  if EdtPerfilId.ReadOnly then Exit;
  inherited;
  FrmPesquisaPerfil := TFrmPesquisaPerfil.Create(Application);
  try
    if (FrmPesquisaPerfil.ShowModal = mrOk) then Begin
       EdtPerfilId.Text := FrmPesquisaPerfil.Tag.ToString;
       EdtPerfilIdExit(EdtPerfilId);
    End;
  finally
    FreeAndNil(FrmPesquisaPerfil);
  end;
end;

procedure TFrmUsuario.ChkConectadoClick(Sender: TObject);
begin
  inherited;
  if ChkConectado.Checked then Begin
     ShpConectado.Pen.Color := ClGreen;
     ShpConectado.Brush.Color := ClGreen;
  End
  Else Begin
    ShpConectado.Pen.Color   := ClRed;
    ShpConectado.Brush.Color := ClRed;
  End;
end;

procedure TFrmUsuario.ChkSomenteAtivoClick(Sender: TObject);
begin
  inherited;
  GetListaLstCadastro;
end;

procedure TFrmUsuario.AtualizaAcessoTopico;
Var xFuncionalidade : Integer;
    xTopicoAcesso   : Boolean;
begin
  FdMemPesqGeral.Filter   := 'TopicoId = '+LstTopicoAcesso.Cells[0, LstTopicoAcesso.Row]+' and Acesso = 1';
  FdMemPesqGeral.Filtered := True;
  if FdMemPesqGeral.IsEmpty then
     LstTopicoAcesso.Cells[2, LstTopicoAcesso.Row] := '0'
  Else
     LstTopicoAcesso.Cells[2, LstTopicoAcesso.Row] := '1';
  FdMemPesqGeral.Filter   := '';
  FdMemPesqGeral.Filtered := False;
  Exit;


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

procedure TFrmUsuario.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtLogin.SetFocus;
  EdtDtUltimaAlteracaoSenha.Text := DateToStr(Date());
  EdtHrUltimaAlteracaoSenha.Text := TimeToStr(Time());
  TabUsuarioConectado.TabVisible := False;
end;

procedure TFrmUsuario.BtnExportarStandClick(Sender: TObject);
begin
  //inherited;
  if PgcBase.ActivePage = TabUsuarioConectado then Begin
    if (Not FdMemUsuarioConectado.Active) or (FdMemUsuarioConectado.IsEmpty) then
       raise Exception.Create('Não há dados para exportar!');
    if (BtnExportarStand.Grayed) or (FdMemUsuarioConectado.IsEmpty) then Exit;
    Try
      DsUsuarioConectado.DataSet := nil;
      ExportarExcel(FdMemUsuarioConectado);
      DsUsuarioConectado.DataSet := FdMemUsuarioConectado;
    Except
      raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
    End;
  End;
end;

procedure TFrmUsuario.BtnImportClick(Sender: TObject);
Var ObjUsuarioCtrl   : TusuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro :String;
    xErro : Integer;
begin
  inherited;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  FdMemPesqGeral.First;
  ObjUsuarioCtrl := TusuarioCtrl.Create;
  JsonArrayRetorno := TJsonArray.Create;
  While Not FdMemPesqGeral.Eof Do Begin
    JsonArrayRetorno.AddElement(TJsonObject.Create
                                .AddPair('reg', TJsonNumber.Create(FdMemPesqGeral.Recno))
                                .AddPair('login', FdMemPesqGeral.FieldByName('login').AsString)
                                .AddPair('nome', FdMemPesqGeral.FieldByName('nome').AsString)
                                .AddPair('senha', FdMemPesqGeral.FieldByName('Senha').AsString)
                                .AddPair('perfil', FdMemPesqGeral.FieldByName('Perfil').AsString)
                                .AddPair('email', FdMemPesqGeral.FieldByName('email').AsString));
    PbImportaFile.Position := PbImportaFile.Position + 1;
    FdMemPesqGeral.Next;
  End;
  JsonArrayRetorno := ObjUsuarioCtrl.ImportCSV(JsonArrayRetorno);
  for xErro := 0 to Pred(JsonArrayRetorno.Count) do Begin
    if JsonArrayRetorno.Items[xErro].TryGetValue('Erro', vErro) then
       MmImporta.Lines.Add(JsonArrayRetorno.Items[xErro].GetValue<String>('login')+' - '+JsonArrayRetorno.Items[xErro].GetValue<String>('nome'));
  End;
  JsonArrayRetorno.Free;
  ObjUsuarioCtrl.Free;
  ShowMessage('Importação concluída...');
end;

procedure TFrmUsuario.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtLogin.SetFocus;
  EdtDiasSenhaValida.Value := 30;
  TabUsuarioConectado.TabVisible := False;
//  GbControleAcesso.Enabled := False;
end;

procedure TFrmUsuario.DbgImportaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    If (FdMemUsuarioConectado.RecNo Mod 2 = 0) then   //Query dos itens
       Canvas.Brush.Color := $00F5EFE7 // Pedido não finalizado
    Else  Canvas.Brush.Color := $00FFCF9F; //Pedido Finalizado
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TFrmUsuario.DefineField;
Begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
  End;
  With FdMemPesqGeral.FieldDefs do begin
     Add('login', ftString,  20, True);
     Add('nome',  ftString,  50, True);
     Add('senha', ftString,   6, True);
     Add('perfil', ftstring, 50, True);
     Add('email', ftString, 200, True);
  End;
  FdMemPesqGeral.CreateDataSet;
  FdMemPesqGeral.Open;
end;

function TFrmUsuario.DeleteReg: Boolean;
begin
  Result := ObjUsuarioCtrl.DelUsuario(StrToIntDef(EdtCodigo.Text, 0));
end;

procedure TFrmUsuario.edtCodigoChange(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (StrToIntDef(EdtCodigo.Text,0)<>ObjUsuarioCtrl.ObjUsuario.UsuarioId) Then
     Limpar;
end;

procedure TFrmUsuario.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmUsuario.edtCodigoExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if (EdtCodigo.Text<>'') and (StrToIntDef(EdtCodigo.Text, 0) <= 0) then Begin
     EdtCodigo.SetFocus;
     ShowErro('Id('+EdtCodigo.Text+') do Usuário inválido!');
     EdtCodigo.Clear;
     Exit;
  End;
  inherited;
  if (Sender=EdtCodigo) and (EdtCodigo.Text<>'') and (Not EdtCodigo.ReadOnly) and (StrToIntDef(EdtCodigo.Text,0)<>ObjUsuarioCtrl.ObjUsuario.UsuarioId) then Begin
     //Limpar;
     if StrToIntDef(EdtCodigo.Text,0) <= 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     Limpar;
     JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtCodigo.Text, -1);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        EdtCodigo.Clear;
        EdtCodigo.SetFocus;
        ShowErro('Erro: '+vErro);
     End
     Else
        ShowDados;
     JsonArrayRetorno := Nil;
  End;
  ExitFocus(Sender);
end;

procedure TFrmUsuario.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmUsuario.EdtLoginExit(Sender: TObject);
Var ReturnJson : TJsonArray;
    vErro      : String;
begin
  inherited;
  if (EdtLogin.ReadOnly) or (EdtLogin.Text='') then Begin
     ExitFocus(Sender);
     Exit;
  End;
  ReturnJson := ObjUsuarioCtrl.FindUsuario(EdtLogin.Text, 0);
  if (ReturnJson.Count>0) and (ReturnJson.Items[0].tryGetValue<String>('usuarioid', vErro)) then Begin
     if (ObjUsuarioCtrl.ObjUsuario.UsuarioId>0) and (ObjUsuarioCtrl.ObjUsuario.UsuarioId <> StrToIntDef(edtCodigo.Text, 0)) then Begin
        ShowErro('Login já existe!');
        EdtLogin.SetFocus;
        Exit;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmUsuario.EdtNomeExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmUsuario.EdtPerfilIdChange(Sender: TObject);
begin
  inherited;
  LblPerfil.Caption := '';
end;

procedure TFrmUsuario.EdtPerfilIdExit(Sender: TObject);
Var ObjPerfilCtrl : TPerfilCtrl;
    LstPerfil     : TObjectList<TPerfil>;
    vErro : String;
begin
  inherited;
  if (Not EdtPerfilId.ReadOnly) and (EdtPerfilId.Text <> '') AND (StrToIntDef(EdtPerfilId.Text,0) <> ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId) then Begin
     ObjPerfilCtrl := TPerfilCtrl.Create();
     LstPerfil     := ObjPerfilCtrl.GetPerfil(EdtPerfilId.Text, 0);
     if LstPerfil[0].PerfilId = 0 Then begin
        ShowErro('Perfil('+EdtPerfilId.ToString()+' de Usuário não encontrado!');
        EdtPerfilId.Clear;
        EdtPerfilId.SetFocus;
     End
     Else Begin
       ObjUsuarioCtrl.ObjUsuario.Perfil := LstPerfil[0];
       LblPerfil.Caption := ObjUsuarioCtrl.ObjUsuario.Perfil.Descricao;
       if BtnSalvar.Enabled then Begin
          GetPerfilAcessoTopicos;
          GetPerfilAcessoFuncionalidades;
       End;
     End;
     ObjPerfilCtrl.DisposeOf;
  End;
end;

procedure TFrmUsuario.EdtPerfilIdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
  inherited;
end;

procedure TFrmUsuario.EdtPerfilIdKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  Key := #0;
end;

procedure TFrmUsuario.EdtSenhaChange(Sender: TObject);
begin
  inherited;
  Senha_Update := True;
end;

procedure TFrmUsuario.EdtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Senha_Update) and (Length(EdtSenha.Text)>=6) then Begin
     Key := 0;
     ShowErro('Tamanho(6) máximo da senha atingido!');
     Exit;
  End;

  inherited;

end;

procedure TFrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmUsuario := Nil;
end;

procedure TFrmUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  ObjUsuarioCtrl := TUsuarioCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] :=  80+Trunc(60*ResponsivoVideo);;
    ColWidths[1] := 100+Trunc(100*ResponsivoVideo);;
    ColWidths[2] := 250+Trunc(250*ResponsivoVideo);;
    ColWidths[3] := 120+Trunc(120*ResponsivoVideo);;
    ColWidths[4] :=  70+Trunc(70*ResponsivoVideo);;
    ColWidths[5] := 300+Trunc(300*ResponsivoVideo);;
    ColWidths[6] :=  80+Trunc(80*ResponsivoVideo);;
    ColWidths[7] :=  80+Trunc(80*ResponsivoVideo);;
    ColWidths[8] :=  45+Trunc(45*ResponsivoVideo);;
    ColWidths[9] :=  60+Trunc(60*ResponsivoVideo);;
    FontStyles[0, 0] := [FsBold];
    Alignments[0, 0] := taRightJustify;
    Alignments[4, 0] := taRightJustify;
    Alignments[6, 0] := taCenter;
    Alignments[7, 0] := taCenter;
    Alignments[8, 0] := taCenter;
    Alignments[9, 0] := taCenter;
  End;
  //GetListaUsuario('0');
  LstTopicoAcesso.ColWidths[0] :=  70+Trunc(70*ResponsivoVideo);;
  LstTopicoAcesso.ColWidths[1] := 230+Trunc(230*ResponsivoVideo);;
  LstTopicoAcesso.ColWidths[2] :=  50+Trunc(50*ResponsivoVideo);;
  LstTopicoAcesso.FontStyles[0, 0] := [FsBold];
  LstTopicoAcesso.Alignments[0, 0] := taRightJustify;
  LstTopicoAcesso.Alignments[2, 0] := taCenter;
  LstTopicoAcesso.Width := LstTopicoAcesso.ColWidths[0]+LstTopicoAcesso.ColWidths[1]+
                           LstTopicoAcesso.ColWidths[2]+35;
  LstFuncionalidadeAcesso.ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);;
  LstFuncionalidadeAcesso.ColWidths[1] := 300+Trunc(300*ResponsivoVideo);;
  LstFuncionalidadeAcesso.ColWidths[2] :=  50+Trunc(50*ResponsivoVideo);;
  LstFuncionalidadeAcesso.FontStyles[0, 0] := [FsBold];
  LstFuncionalidadeAcesso.Alignments[0, 0] := taRightJustify;
  LstFuncionalidadeAcesso.Alignments[2, 0] := taCenter;
  LstFuncionalidadeAcesso.Width := LstFuncionalidadeAcesso.ColWidths[0]+LstFuncionalidadeAcesso.ColWidths[1]+
                                   LstFuncionalidadeAcesso.ColWidths[2]+35;
  LstUsuarioConectado.ColWidths[0] :=  70+Trunc(70*ResponsivoVideo);;
  LstUsuarioConectado.ColWidths[1] :=  70+Trunc(70*ResponsivoVideo);;
  LstUsuarioConectado.ColWidths[2] := 280+Trunc(280*ResponsivoVideo);;
  LstUsuarioConectado.ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);;
  LstUsuarioConectado.ColWidths[4] :=  70+Trunc(70*ResponsivoVideo);;
  LstUsuarioConectado.ColWidths[5] := 150+Trunc(150*ResponsivoVideo);;
  LstUsuarioConectado.ColWidths[6] :=  80+Trunc(80*ResponsivoVideo);;
  LstUsuarioConectado.Alignments[0, 0] := taRightJustify;
  LstUsuarioConectado.FontStyles[0, 0] := [FsBold];
  LstUsuarioConectado.Alignments[1, 0] := taRightJustify;
  LstUsuarioConectado.Alignments[3, 0] := taCenter;
  LstUsuarioConectado.Alignments[4, 0] := taCenter;
  //ChkSomenteAtivo.Checked := True;
end;

procedure TFrmUsuario.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ObjUsuarioCtrl);
  inherited;
end;

procedure TFrmUsuario.GetControleAcesso;
Var JsonRetorno              : TJsonObject;
    JsonArrayTopicos         : TJsonArray;
    JsonArrayFuncionalidades : TJsonArray;
    vErro : String;
    xTopico, xImg : Integer;
begin
  JsonRetorno := ObjUsuarioCtrl.ControleAcesso;
  JsonArrayTopicos         := JsonRetorno.GetValue<TJsonArray>('topicos');
  JsonArrayFuncionalidades := JsonRetorno.GetValue<TJsonArray>('funcionalidades');
  if JsonArrayTopicos.Items[0].tryGetValue<String>('Erro', vErro) then
     LstTopicoAcesso.RowCount := 1
  Else begin
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
  End;
  If FdMemPesqGeral.Active then
       FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  if JsonArrayFuncionalidades.Items[0].tryGetValue<String>('Erro', vErro) then Begin
     LstFuncionalidadeAcesso.RowCount := 1;
//     FdMemPesqGeral.Open;
  End
  Else Begin
     FdMemPesqGeral.LoadFromJson(JsonArrayFuncionalidades, False);
     SelectFuncionalidade(JsonArrayTopicos.Items[0].GetValue<Integer>('topicoid'),
                          JsonArrayTopicos.Items[0].GetValue<Integer>('acesso'), 0);
  End;
  JsonArrayTopicos         := Nil;
  JsonArrayFuncionalidades := Nil;
  JsonRetorno              := Nil;
end;

procedure TFrmUsuario.GetListaLstCadastro;
begin
  inherited;
  GetListaUsuario(0, '', '', 1);
end;

Function TFrmUsuario.GetListaUsuario(pUsuarioId : Integer; pLogin, pNome : String; pSomenteAtivo : Integer) : Boolean;
Var ArrayListPessoa : tJsonArray;
    jSonObj         : tJsonObject;
    I, xLista       : Integer;
    vErro           : String;
begin
  if (pUsuarioId<>0) or ((pLogin = '') and (pNome = '')) then Begin
     if (pSomenteAtivo = 1) and (ChkSomenteAtivo.Checked) then
        ArrayListPessoa := ObjUsuarioCtrl.FindUsuario(pUsuarioId.ToString, 0, 1)
     Else
        ArrayListPessoa := ObjUsuarioCtrl.FindUsuario(pUsuarioId.ToString, 0);
     if ArrayListPessoa.Items[0].TryGetValue('Erro', vErro) then Begin
        ArrayListPessoa := Nil;
        ShowErro(vErro);
        Exit;
     End;
  End
  Else Begin
     ArrayListPessoa := ObjUsuarioCtrl.FindLoginNome(pLogin, pNome);
     if ArrayListPessoa.Items[0].TryGetValue('Erro', vErro) then Begin
        ArrayListPessoa := Nil;
        ShowErro(vErro);
        Exit;
     End;
  End;
  LstCadastro.RowCount := ArrayListPessoa.Count+1;
  Result := LstCadastro.RowCount > 1;
  if LstCadastro.RowCount > 1 then Begin
     for i := 1 to LstCadastro.RowCount - 1 do begin
       LstCadastro.AddDataImage(8, i, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(9, i, 0, haCenter,vaTop);
     end;
     For xLista := 0 To ArrayListPessoa.Count-1 do begin
       jSonObj := tJsonObject.Create;
       jSonObj := ArrayListPessoa.Items[xLista] as TJSONObject;
       LstCadastro.Cells[0, xLista+1] := GetValueInjSon(jSonObj, 'UsuarioId');
       LstCadastro.Cells[1, xLista+1] := GetValueInjSon(jSonObj, 'Login');
       LstCadastro.Cells[2, xLista+1] := GetValueInjSon(jSonObj, 'Nome');
       LstCadastro.Cells[3, xLista+1] := GetValueInJson(JsonObj, 'descricao');
       LstCadastro.Cells[4, xLista+1] := GetValueInJson(JsonObj, 'DiasSenhaValida');
       LstCadastro.Cells[5, xLista+1] := GetValueInJson(JsonObj, 'Email');
       LstCadastro.Cells[6, xLista+1] := GetValueInJson(JsonObj, 'DtUltimaAlteracaoSenha');
       LstCadastro.Cells[7, xLista+1] := GetValueInJson(JsonObj, 'HrUltimaAlteracaoSenha');
       LstCadastro.Cells[8, xLista+1] := GetValueInJson(JsonObj, 'Status');
       if StrToIntDef(GetValueInJson(JsonObj, 'idlogon'), 0) >= 1 then
          LstCadastro.Cells[9, xLista+1] := '1'
       Else LstCadastro.Cells[9, xLista+1] := '0';
       if JsonObj.GetValue<Integer>('status') = 1 then Begin
          LstCadastro.FontColors[1, xLista+1] := ClBlack;
          LstCadastro.FontColors[2, xLista+1] := ClBlack;
          LstCadastro.FontColors[3, xLista+1] := ClBlack;
          LstCadastro.FontColors[4, xLista+1] := ClBlack;
          LstCadastro.FontColors[5, xLista+1] := ClBlack;
          LstCadastro.FontColors[6, xLista+1] := ClBlack;
          LstCadastro.FontColors[7, xLista+1] := ClBlack;
       End
       Else Begin
          LstCadastro.FontColors[1, xLista+1] := ClRed;
          LstCadastro.FontColors[2, xLista+1] := ClRed;
          LstCadastro.FontColors[3, xLista+1] := ClRed;
          LstCadastro.FontColors[4, xLista+1] := ClRed;
          LstCadastro.FontColors[5, xLista+1] := ClRed;
          LstCadastro.FontColors[6, xLista+1] := ClRed;
          LstCadastro.FontColors[7, xLista+1] := ClRed;
       End;
       jSonObj := Nil;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[4, xLista+1] := taRightJustify;
       LstCadastro.Alignments[6, xLista+1] := taCenter;
       LstCadastro.Alignments[7, xLista+1] := taCenter;
       LstCadastro.Alignments[8, xLista+1] := taCenter;
     end;
     LstCadastro.FixedRows := 1;
     LstCadastro.SortSettings.Column := 2;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  ArrayListPessoa := Nil;
  Limpar;
end;

procedure TFrmUsuario.GetPerfilAcessoTopicos;
Var ObjPerfilCtrl : TPerfilCtrl;
    JsonRetorno              : TJsonObject;
    JsonArrayTopicos         : TJsonArray;
    vErro         : String;
    xTopico, xImg : Integer;
begin
  ObjPerfilCtrl := TPerfilCtrl.Create;
  ObjPerfilCtrl.ObjPerfil.PerfilId := StrToIntDef(EdtPerfilId.Text, 0);
  JsonRetorno := ObjPerfilCtrl.ControleAcessoTopicos;
  if JsonRetorno.TryGetValue<String>('Erro', vErro) then Begin
     LstTopicoAcesso.RowCount := 1;
     ObjPerfilCtrl.DisposeOf;
     Exit;
  End;
  JsonArrayTopicos         := JsonRetorno.GetValue<TJsonArray>('topicos');
  LstTopicoAcesso.ClearRect(0, 1, LstTopicoAcesso.ColCount-1, LstTopicoAcesso.RowCount-1);
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
  JsonRetorno := Nil;
  ObjPerfilCtrl.DisposeOf;
end;

procedure TFrmUsuario.GetPerfilAcessoFuncionalidades;
Var ObjPerfilCtrl            : TPerfilCtrl;
    JsonRetorno              : TJsonObject;
    JsonArrayFuncionalidades : TJsonArray;
    vErro : String;
    xFuncionalidade, xImg : Integer;
    vListaTopicos         : String;
    xTopicos              : Integer;
begin

//  for xTopicos := 1 to Pred(LstTopicoAcesso.RowCount) do
//    if LstTopicoAcesso.Cells[2, xTopicos] = '1' then
//       vListaTopicos := vListaTopicos+IfThen(vListaTopicos<>'',', ','') + LstTopicoAcesso.Cells[0, xTopicos];
//  if vListaTopicos = '' then
     vListaTopicos := '0';
  ObjPerfilCtrl := TPerfilCtrl.Create();
  ObjPerfilCtrl.ObjPerfil.PerfilId := StrToIntDef(EdtPerfilId.Text, 0);
  JsonRetorno := ObjPerfilCtrl.ControleAcessoFuncionalidades(vListaTopicos);
  if JsonRetorno.TryGetValue<String>('Erro', vErro) then Begin
     LstFuncionalidadeAcesso.RowCount := 1;
     Exit;
  End;
  JsonArrayFuncionalidades := JsonRetorno.GetValue<TJsonArray>('funcionalidades');
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJson(JsonArrayFuncionalidades, False);

exit;

  LstFuncionalidadeAcesso.RowCount  := JsonArrayFuncionalidades.Count+1;
  LstFuncionalidadeAcesso.FixedRows := 1;
  for xImg := 1 to LstFuncionalidadeAcesso.RowCount - 1 do
  begin
    LstFuncionalidadeAcesso.AddDataImage(2, xImg, 0, haCenter, vaTop);
  end;
  for xFuncionalidade := 0 to Pred(JsonArrayFuncionalidades.Count) do Begin
    LstFuncionalidadeAcesso.Cells[0, xFuncionalidade+1] := JsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>('funcionalidadeid').ToString();
    LstFuncionalidadeAcesso.Cells[1, xFuncionalidade+1] := JsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<String>('descricao');
    LstFuncionalidadeAcesso.Cells[2, xFuncionalidade+1] := JsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>('acesso').ToString();
    LstFuncionalidadeAcesso.FontStyles[0, xFuncionalidade+1] := [FsBold];
    LstFuncionalidadeAcesso.Alignments[0, xFuncionalidade+1] := taRightJustify;
    LstFuncionalidadeAcesso.Alignments[2, xFuncionalidade+1] := taCenter;
  End;
  JsonRetorno := Nil;
  ObjPerfilCtrl.Free;
end;

procedure TFrmUsuario.Limpar;
begin
  if Not edtCodigo.Enabled then
     EdtCodigo.Clear;
  EnabledButtons := False;
  If Assigned(ObjUsuarioCtrl) Then ObjUsuarioCtrl.ObjUsuario.Limpar;
  EdtLogin.Clear;
  EdtNome.Clear;
  EdtSenha.Clear;
  EdtDiasSenhaValida.Value := 0;
  ChkSenhaPadrao.Checked   := False;
  EdtEmail.Clear;
  EdtDtUltimaAlteracaoSenha.Clear;
  EdtHrUltimaAlteracaoSenha.Clear;
  ChkCadastro.Checked      := False;
  ChkConectado.Checked     := False;
  LblDetalheConectado.Caption := '...';
  LstTopicoAcesso.RowCount := 1;
  LstFuncionalidadeAcesso.RowCount := 1;
  TabUsuarioConectado.TabVisible := True;
end;

procedure TFrmUsuario.LstFuncionalidadeAcessoClick(Sender: TObject);
begin
  inherited;
  if LstFuncionalidadeAcesso.Row > 0 then
     LstFuncionalidadeAcessoClickCell(Sender, LstFuncionalidadeAcesso.Row, 0);
end;

procedure TFrmUsuario.LstFuncionalidadeAcessoClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0) and (LstFuncionalidadeAcesso.RowCount > 1) then Begin  //and (aCol in [0, 1, 7])
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  if LstFuncionalidadeAcesso.RowCount <= 1 then Exit;
  if (aCol = 2) And (ARow > 0) and (BtnSalvar.Enabled) then Begin
     If LstFuncionalidadeAcesso.Cells[2, ARow] = '1' then Begin
        LstFuncionalidadeAcesso.Cells[2, ARow] := '0';
        if FdMemPesqGeral.Locate('FuncionalidadeId', LstFuncionalidadeAcesso.Cells[0, ARow].ToInteger, [loPartialKey]) then Begin
           FdMemPesqGeral.Edit;
           FdMemPesqGeral.FieldByName('Acesso').AsInteger := 0;
           FdmemPesqGeral.Post;
        End;
     End
     Else Begin
       LstFuncionalidadeAcesso.Cells[2, ARow] := '1';
       //MarkTopico(FdMemPesqGeral.FieldByName('TopicoId').AsInteger);
       if FdMemPesqGeral.Locate('FuncionalidadeId', LstFuncionalidadeAcesso.Cells[0, ARow].ToInteger, [loPartialKey]) then Begin
          FdMemPesqGeral.Edit;
          FdMemPesqGeral.FieldByName('Acesso').AsInteger := 1;
          FdmemPesqGeral.Post;
       End;
     End;
     AtualizaAcessoTopico;
  End;
end;

procedure TFrmUsuario.LstTopicoAcessoClick(Sender: TObject);
begin
  inherited;
  LstTopicoAcessoClickCell(Sender, LstTopicoAcesso.Row, 0);
end;

procedure TFrmUsuario.LstTopicoAcessoClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0) and (LstTopicoAcesso.RowCount > 1) then Begin  //and (aCol in [0, 1, 7])
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  if LstTopicoAcesso.RowCount <= 1 then Exit;
  if (aCol = 2) And (ARow > 0) and (BtnSalvar.Enabled) then Begin
     If LstTopicoAcesso.Cells[2, ARow] = '1' then
        LstTopicoAcesso.Cells[2, ARow] := '0'
     Else
       LstTopicoAcesso.Cells[2, ARow] := '1';
  End;
  if (aRow <> 0) and (aCol = 2) then
     SelectFuncionalidade(LstTopicoAcesso.Cells[0, ARow].ToInteger(), LstTopicoAcesso.Cells[2, ARow].ToInteger, 1)
  Else
     SelectFuncionalidade(LstTopicoAcesso.Cells[0, ARow].ToInteger(), LstTopicoAcesso.Cells[2, ARow].ToInteger, 0);
end;

procedure TFrmUsuario.MarkTopico(pTopicoId: Integer);
Var xTopico : Integer;
begin
  for xTopico := 1 to Pred(LstTopicoAcesso.RowCount) do Begin
    if LstTopicoAcesso.Cells[0, xTopico].ToInteger = pTopicoId then Begin
       LstTopicoAcesso.Cells[2, xTopico] := '1';
       Break;
    End;
  End;
end;

procedure TFrmUsuario.OpenFileImport;
var ArquivoCSV: TextFile;
    Linha : String;
    I : Integer;
    vAltura, vLargura, vComprimento, vCodProduto, pEndereco, vPicking, vErro : String;
    vEstruturaId : String;
//    JsonArrayProduto, JsonArrayEndereco : TJsonArray;
  Function GetValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
    inc(I);
    While Linha[I] >= ' ' do
    begin
      If Linha[I] = ';' then // vc pode usar qualquer delimitador ... eu
        // estou usando o ";"
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;
begin
  inherited;
  DefineField;
  if EdtFileIimport.Text = '' then
     raise Exception.Create('Informe o arquivo a ser importado!');
  if Not FileExists(EdtFileIimport.Text) then Begin
     ShowMessage('Arquivo para Importacao não encontrado.');
     Exit;
  End;
  AssignFile(ArquivoCSV, EdtFileIimport.Text);
  try
    TmImportacaoCSV.Enabled := True;
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);    //Pular Cabecalho
    while not Eoln(ArquivoCSV) do begin
      Readln(ArquivoCSV, Linha);
      I := 0;
      FdMemPesqGeral.Append;
      FdMemPesqGeral.FieldByName('login').AsString  := GetValor;
      FdMemPesqGeral.FieldByName('Nome').AsString   := GetValor;
      FdMemPesqGeral.FieldByName('Senha').AsString  := GetValor;
      FdMemPesqGeral.FieldByName('Perfil').AsString := UTF8Decode(GetValor);
      FdMemPesqGeral.FieldByName('email').AsString  := GetValor;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0', FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmUsuario.PesquisarClickInLstCadastro(aCol, aRow: Integer);
var x : Integer;
begin
  inherited;
  X := ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  EdtCodigo.Text := LstCadastro.Cells[0, aRow];
  EdtCodigoExit(EdtCodigo);
end;

function TFrmUsuario.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para pesquisa!');
     if (CbCampoPesq.ItemIndex > 0) and (StrToIntDef(EdtConteudoPesq.Text, 0) > 0) then
        raise Exception.Create('Realize a pesquisa por Id!')
     Else
        If CbCampoPesq.ItemIndex = 0      then Result := GetListausuario(StrToIntDef(EdtConteudoPesq.Text, 0), '', '')
        Else If CbCampoPesq.ItemIndex = 1 then Result := GetListausuario(0, EdtConteudoPesq.Text, '')
        Else If CbCampoPesq.ItemIndex = 2 then Result := GetListausuario(0, '', EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmUsuario.SalvarReg: Boolean;
Var xTopicos, xFuncionalidades : Integer;
    JsonArrayTopicos, JsonArrayFuncionalidades : TJsonArray;
    JsonTopicos, JsonFuncionalidades, JsonAcesso : TJsonObject;
    xFuncionalidade : Integer;
begin
  With ObjUsuarioCtrl.ObjUsuario do Begin
     UsuarioId   := StrToIntDef(EdtCodigo.Text, 0);
     Login       := EdtLogin.Text;
     Nome        := EdtNome.Text;
     if Senha_Update then
        Senha       := Md5Texto(EdtSenha.Text);
     SenhaPadrao := Ord(ChkSenhaPadrao.Checked);
     DiasSenhaValida := StrToIntDef(EdtDiasSenhaValida.Text, 0);
     Email       := EdtEmail.Text;
     Status    := Ord(ChkCadastro.Checked);
  End;
  If ObjUsuarioCtrl.VerificaDados then Begin
//Preparar Itens do Controle de Acesso
//     if StrToIntDef(EdtCodigo.Text, 0) > 0 then Begin
        JsonAcesso               := TJsonObject.Create;
        JsonArrayTopicos         := TJsonArray.Create;
        JsonArrayFuncionalidades := TJsonArray.Create;
        for xTopicos := 1 to Pred(LstTopicoAcesso.RowCount) do Begin
          JsonTopicos := TJsonObject.Create;
          JsonTopicos.AddPair('topicoid', TJsonNumber.Create(LstTopicoAcesso.Cells[0, xTopicos].ToInteger()));
          JsonTopicos.AddPair('acesso',   TJsonNumber.Create(LstTopicoAcesso.Cells[2, xTopicos].ToInteger()));
          JsonArrayTopicos.AddElement(JsonTopicos);
        End;
        JsonAcesso.AddPair('topicos', JsonArrayTopicos);
        xFuncionalidade := 0;
        FdMemPesqGeral.Filter   := 'Acesso = 1';
        FdMemPesqGeral.Filtered := True;
        FdmemPesqGeral.First;
        JsonArrayFuncionalidades := FdMemPesqGeral.ToJSONArray();
(*        While Not FdMemPesqGeral.Eof do Begin //for xFuncionalidades := 1 to Pred(LstFuncionalidadeAcesso.RowCount) do Begin
          JsonFuncionalidades := TJsonObject.Create;
          JsonFuncionalidades.AddPair('funcionalidadeid', TJsonNumber.Create(FdMemPesqGeral.FieldByName('FuncionalidadeId').AsInteger));
          JsonFuncionalidades.AddPair('acesso',   TJsonNumber.Create(FdMemPesqGeral.FieldByName('Acesso').AsInteger));
          JsonArrayFuncionalidades.AddElement(JsonFuncionalidades);
          FdMemPesqGeral.Next;
        End;
*)        FdMemPesqGeral.Filter   := '';
        FdMemPesqGeral.Filtered := False;
        JsonAcesso.AddPair('funcionalidades', JsonArrayFuncionalidades);
//     End;
     Result := ObjUsuarioCtrl.Salvar;
     if Result then Begin
        //if StrToIntDef(EdtCodigo.Text, 0) > 0 then Begin
           ObjUsuarioCtrl.SalvarAcesso(JsonAcesso);
           //JsonAcesso.DisposeOf;
        //End;
        ObjUsuarioCtrl.ObjUsuario.UsuarioId := 0;
     End;
     JsonAcesso.Free;
//     JsonArrayTopicos := Nil;
//     JsonArrayFuncionalidades := Nil;
     TabUsuarioConectado.TabVisible := True;
  End;
end;

function TFrmUsuario.SavePhoto: Boolean;
begin

end;

procedure TFrmUsuario.SelectFuncionalidade(pTopicoId, pSelectOnOff, pUpdate : Integer);
Var xImg, xFuncionalidade : Integer;
begin
  FdMemPesqGeral.Filter := 'TopicoId = '+pTopicoId.ToString();
  FdMemPesqGeral.Filtered := True;
  FdMemPesqGeral.First;
  LstFuncionalidadeAcesso.RowCount  := FdMemPesqGeral.RecordCount+1;
  xFuncionalidade := 1;
  if FdMemPesqGeral.RecordCount >= 1 then Begin
     LstFuncionalidadeAcesso.FixedRows := 1;
     for xImg := 1 to LstFuncionalidadeAcesso.RowCount - 1 do
       LstFuncionalidadeAcesso.AddDataImage(2, xImg, 0, haCenter, vaTop);
     While not FdMemPesqGeral.Eof  do Begin
       //FdMemPesqGeral.Edit;
       //FdMemPesqGeral.FieldByName('Acesso').AsInteger := pSelect;
       //FdMemPesqGeral.Post;
       LstFuncionalidadeAcesso.Cells[0, xFuncionalidade] := FdMemPesqGeral.FieldByName('funcionalidadeid').AsString;
       LstFuncionalidadeAcesso.Cells[1, xFuncionalidade] := FdMemPesqGeral.FieldByName('descricao').AsString;
       if pUpdate = 0 then
          LstFuncionalidadeAcesso.Cells[2, xFuncionalidade] := FdMemPesqGeral.FieldByName('acesso').AsString
       Else Begin
          LstFuncionalidadeAcesso.Cells[2, xFuncionalidade] := pSelectOnOff.ToString;
          FdMemPesqGeral.Edit;
          FdMemPesqGeral.FieldByName('Acesso').AsInteger := pSelectOnOff;
          FdmemPesqGeral.Post;
       End;
       LstFuncionalidadeAcesso.FontStyles[0, xFuncionalidade] := [FsBold];
       LstFuncionalidadeAcesso.Alignments[0, xFuncionalidade] := taRightJustify;
       LstFuncionalidadeAcesso.Alignments[2, xFuncionalidade] := taCenter;
       FdMemPesqGeral.Next;
       Inc(xFuncionalidade);
     End;
  End;
end;

procedure TFrmUsuario.ShowDados;
begin
  inherited;
  With ObjUsuarioCtrl.ObjUsuario do Begin
    EdtCodigo.Text    := UsuarioId.ToString();
    EdtLogin.Text     := Login;
    EdtNome.Text      := Nome;
    EdtSenha.Text     := Senha;
    Senha_Update      := False;
    ChkSenhaPadrao.Checked  := SenhaPadrao = 1;
    EdtDiasSenhaValida.Text := DiasSenhaValida.ToString();
    EdtEmail.Text     := Email;
    EdtPerfilId.Text  := Perfil.PerfilId.ToString();
    LblPerfil.Caption := Perfil.Descricao;
    EdtDtUltimaAlteracaoSenha.Text := DateToStr(DtUltimaAlteracaoSenha);
    EdtHrUltimaAlteracaoSenha.Text := TimeToStr(HrUltimaAlteracaoSenha);
    ChkCadastro.Checked := Status = 1;
    if ObjUsuarioCtrl.ObjUsuario.IdLogOn > 0 then Begin
       ChkConectado.Checked := ObjUsuarioCtrl.ObjUsuario.IdLogOn > 0;
       LblDetalheConectado.Caption := ObjUsuarioCtrl.ObjUsuario.Terminal+' em '+
                                      DateToStr(ObjUsuarioCtrl.ObjUsuario.DataInicio)+' às '+
                                      TimeToStr(ObjUsuarioCtrl.ObjUsuario.HoraInicio);
    End;
    GetControleAcesso;
//    GbControleAcesso.Enabled := True;
  End;
end;

procedure TFrmUsuario.TabUsuarioConectadoExit(Sender: TObject);
begin
  inherited;
  BtnExportarStand.Grayed  := True;
  BtnExportarStand.Enabled := False;
end;

procedure TFrmUsuario.TabUsuarioConectadoShow(Sender: TObject);
begin
  inherited;
  TDialogMessage.ShowWaitMessage('Buscando usuários conectado. Conectando com servidor...',
  procedure
  Var ObjUsuCtrl       : TUsuarioCtrl;
      JsonArrayRetorno : TJsonArray;
      vErro            : String;
      xUsuario         : Integer;
  begin
    LstUsuarioConectado.RowCount := 1;
    ObjUsuCtrl := TUsuarioCtrl.Create();
    JsonArrayRetorno := ObjUsuCtrl.UsuarioConectado;
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then begin
       ShowErro(vErro);
       JsonArrayRetorno := Nil;
       ObjUsuCtrl.Free;
       Exit;
    End;
    If FdMemUsuarioConectado.Active then
       FdMemUsuarioConectado.EmptyDataSet;
    FdMemUsuarioConectado.Close;
    FdMemUsuarioConectado.LoadFromJSON(JsonArrayRetorno, False);
    BtnExportarStand.Grayed  := Not FdMemUsuarioConectado.RecordCount > 0;
    BtnExportarStand.Enabled := FdMemUsuarioConectado.RecordCount > 0;
    LstUsuarioConectado.RowCount := JsonArrayRetorno.Count+1;
    LstUsuarioConectado.FixedRows := 1;
    for xUsuario := 0 to Pred(JsonArrayRetorno.Count) do Begin
      LstUsuarioConectado.Cells[0, xUsuario+1] := JsonArrayRetorno.Items[xUsuario].GetValue<integer>('idlogon').ToString();
      LstUsuarioConectado.Cells[1, xUsuario+1] := JsonArrayRetorno.Items[xUsuario].GetValue<integer>('usuarioid').ToString();
      LstUsuarioConectado.Cells[2, xUsuario+1] := JsonArrayRetorno.Items[xUsuario].GetValue<String>('nome');
      LstUsuarioConectado.Cells[3, xUsuario+1] := DateEUAtoBr(JsonArrayRetorno.Items[xUsuario].GetValue<String>('datainicio'));
      LstUsuarioConectado.Cells[4, xUsuario+1] := Copy(JsonArrayRetorno.Items[xUsuario].GetValue<String>('horainicio'), 1, 8);
      LstUsuarioConectado.Cells[5, xUsuario+1] := JsonArrayRetorno.Items[xUsuario].GetValue<String>('terminal');
      LstUsuarioConectado.Cells[6, xUsuario+1] := JsonArrayRetorno.Items[xUsuario].GetValue<String>('versaoapp');
      LstUsuarioConectado.Alignments[0, xUsuario+1] := taRightJustify;
      LstUsuarioConectado.FontStyles[0, xUsuario+1] := [FsBold];
      LstUsuarioConectado.Alignments[1, xUsuario+1] := taRightJustify;
      LstUsuarioConectado.Alignments[3, xUsuario+1] := taCenter;
      LstUsuarioConectado.Alignments[4, xUsuario+1] := taCenter;
    End;
    JsonArrayRetorno := Nil;
    ObjUsuCtrl.Free;
  End);
end;

end.
