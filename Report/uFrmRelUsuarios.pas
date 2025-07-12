unit uFrmRelUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, DataSet.Serialize,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, System.Generics.Collections,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, PerfilCtrl, PerfilClass,
  UsuarioCtrl, System.JSON, REST.Json, Rest.Types;

type
  TFrmRelUsuarios = class(TFrmReportBase)
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BtnPesqUsuario: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    LblPerfil: TLabel;
    EdtPerfilId: TEdit;
    BtnPesqPerfil: TBitBtn;
    GroupBox2: TGroupBox;
    ChkAtivo: TCheckBox;
    ChkInativo: TCheckBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    LblFuncionalidade: TLabel;
    EdtFuncionalidadeId: TEdit;
    BtnPesqFuncionalidade: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqPerfilClick(Sender: TObject);
    procedure EdtPerfilIdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesqUsuarioClick(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure EdtFuncionalidadeIdChange(Sender: TObject);
    procedure EdtPerfilIdChange(Sender: TObject);
    procedure ChkAtivoClick(Sender: TObject);
    procedure EdtFuncionalidadeIdExit(Sender: TObject);
    procedure BtnPesqFuncionalidadeClick(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaListaUsuarios;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelUsuarios: TFrmRelUsuarios;

implementation

{$R *.dfm}

Uses Views.Pequisa.Perfil, Views.Pequisa.Usuarios, Vcl.DialogMessage, FuncionalidadeCtrl,
  FuncionalidadeClass, Views.Pesquisa.Funcionalidades;

procedure TFrmRelUsuarios.BtnPesqUsuarioClick(Sender: TObject);
begin
  if EdtUsuarioId.ReadOnly then Exit;
  inherited;
  FrmPesquisaUsuario := TFrmPesquisaUsuario.Create(Application);
  try
    if (FrmPesquisaUsuario.ShowModal = mrOk) then Begin
       EdtUsuarioId.Text := FrmPesquisaUsuario.Tag.ToString;
       EdtUsuarioIdExit(EdtUsuarioId);
    End;
  finally
    FreeAndNil(FrmPesquisaUsuario);
  end;
end;

procedure TFrmRelUsuarios.BtnPesqFuncionalidadeClick(Sender: TObject);
begin
  inherited;
  if EdtFuncionalidadeId.ReadOnly then Exit;
  inherited;
  FrmPesquisaFuncionalidade := TFrmPesquisaFuncionalidade.Create(Application);
  try
    if (FrmPesquisaFuncionalidade.ShowModal = mrOk) then Begin
       EdtFuncionalidadeId.Text := FrmPesquisaFuncionalidade.Tag.ToString;
       EdtFuncionalidadeIdExit(EdtFuncionalidadeId);
    End;
  finally
    FreeAndNil(FrmPesquisaFuncionalidade);
  end;
end;

procedure TFrmRelUsuarios.BtnPesqPerfilClick(Sender: TObject);
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

procedure TFrmRelUsuarios.ChkAtivoClick(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelUsuarios.EdtFuncionalidadeIdChange(Sender: TObject);
begin
  inherited;
  LblFuncionalidade.Caption := '...';
  Limpar;
end;

procedure TFrmRelUsuarios.EdtFuncionalidadeIdExit(Sender: TObject);
Var ObjFuncionalidadeCtrl : TFuncionalidadeCtrl;
    LstFuncionalidade     : TObjectList<TFuncionalidade>;
    vErro : String;
begin
  if (EdtFuncionalidadeId.Text<>'') and (StrToIntDef(EdtFuncionalidadeId.Text, 0) <= 0) then Begin
     EdtFuncionalidadeId.SetFocus;
     ShowErro('Id('+EdtFuncionalidadeId.Text+') da Funcionalidade inválida!');
     EdtFuncionalidadeId.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtFuncionalidadeId.ReadOnly) and (EdtFuncionalidadeId.Text <> '') then Begin
     ObjFuncionalidadeCtrl := TFuncionalidadeCtrl.Create();
     LstFuncionalidade     := ObjFuncionalidadeCtrl.GetFuncionalidade(EdtFuncionalidadeId.Text, 0);
     if LstFuncionalidade[0].FuncionalidadeId = 0 Then begin
        ShowErro('Funcionalidade('+EdtFuncionalidadeId.ToString()+' não encontrada!');
        EdtFuncionalidadeId.Clear;
        EdtFuncionalidadeId.SetFocus;
     End;
     LblFuncionalidade.Caption := LstFuncionalidade[0].Descricao;
     LstFuncionalidade := Nil;
     ObjFuncionalidadeCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelUsuarios.EdtPerfilIdChange(Sender: TObject);
begin
  inherited;
  LblPerfil.caption := '...';
  Limpar;
end;

procedure TFrmRelUsuarios.EdtPerfilIdExit(Sender: TObject);
Var ObjPerfilCtrl : TPerfilCtrl;
    LstPerfil     : TObjectList<TPerfil>;
    vErro : String;
begin
  if (EdtPerfilId.Text<>'') and (StrToIntDef(EdtPerfilId.Text, 0) <= 0) then Begin
     EdtPerfilId.SetFocus;
     ShowErro('Id('+EdtPerfilId.Text+') do Perfil inválido!');
     EdtPerfilId.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtPerfilId.ReadOnly) and (EdtPerfilId.Text <> '') then Begin
     ObjPerfilCtrl := TPerfilCtrl.Create();
     LstPerfil     := ObjPerfilCtrl.GetPerfil(EdtPerfilId.Text, 0);
     if LstPerfil[0].PerfilId = 0 Then begin
        ShowErro('Perfil('+EdtPerfilId.ToString()+' de Usuário não encontrado!');
        EdtPerfilId.Clear;
        EdtPerfilId.SetFocus;
     End;
     LblPerfil.Caption := LstPerfil[0].Descricao;
     LstPerfil := Nil;
     ObjPerfilCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelUsuarios.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  Lblusuario.Caption := '';
  Limpar;
end;

procedure TFrmRelUsuarios.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl   : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if (EdtUsuarioId.Text<>'') and (StrToIntDef(EdtUsuarioId.Text, 0) <= 0) then Begin
     EdtUsuarioId.SetFocus;
     ShowErro('Id('+EdtUsuarioId.Text+') do Usuário inválido!');
     EdtUsuarioId.Clear;
     Exit;
  End;
  inherited;
  LblUsuario.Caption := '';
  if (Not EdtUsuarioId.ReadOnly) and (EdtUsuarioId.Text <> '') then Begin
     ObjUsuarioCtrl   := TUsuarioCtrl.Create();
     JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) Then begin
        ShowErro(vErro);
        EdtUsuarioId.Clear;
        EdtUsuarioId.SetFocus;
     End
     Else
        LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
     JsonArrayRetorno := Nil;
     ObjUsuarioCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRelUsuarios := Nil;
end;

procedure TFrmRelUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  ChkAtivo.Checked       := True;
  ChkInativo.Checked     := True;
  LstReport.ColWidths[0] :=  80;
  LstReport.ColWidths[1] := 300;
  LstReport.ColWidths[2] := 150;
  LstReport.ColWidths[3] := 120;
  LstReport.ColWidths[4] :=  60;
  LstReport.ColWidths[5] := 300;
  LstReport.ColWidths[6] :=  40; //Dt.Processo
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[4, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taCenter;
end;

procedure TFrmRelUsuarios.Imprimir;
begin
  inherited;

end;

procedure TFrmRelUsuarios.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelUsuarios.MontaListaUsuarios;
Var xRecno : Integer;
begin
  FdMemPesqGeral.First;
  xRecno := 1;
  for xRecno := 1 to FdMemPesqGeral.RecordCount do
    LstReport.AddDataImage(6, xRecno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xRecno := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRecno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString;
    LstReport.Cells[1, xRecno] := FdMemPesqGeral.FieldByName('Nome').AsString;
    LstReport.Cells[2, xRecno] := FdMemPesqGeral.FieldByName('Perfil').AsString;
    LstReport.Cells[3, xRecno] := FdMemPesqGeral.FieldByName('Topico').AsString;
    LstReport.Cells[4, xRecno] := FdMemPesqGeral.FieldByName('FuncionalidadeId').AsString;
    LstReport.Cells[5, xRecno] := FdMemPesqGeral.FieldByName('Funcionalidade').AsString;
    LstReport.Cells[6, xRecno] := FdMemPesqGeral.FieldByName('Status').AsString;
    LstReport.Alignments[0, xRecno] := taRightJustify;
    LstReport.FontStyles[0, xRecno] := [FsBold];
    LstReport.Alignments[4, xRecno] := taRightJustify;
    LstReport.Alignments[6, xRecno] := taCenter;
    FdMemPesqGeral.Next;
    Inc(xRecno);
  End;
end;

procedure TFrmRelUsuarios.PesquisarDados;
Var JsonArrayRetorno : tJsonArray;
    xInventario      : Integer;
    vErro            : String;
    ObjUsuarioCtrl   : TUsuarioCtrl;
    pStatus          : Integer;
begin
  if (EdtUsuarioId.Text<>'') and (StrToIntDef(EdtUsuarioId.Text, 0) <= 0) then Begin
     EdtUsuarioId.SetFocus;
     ShowErro('Id('+EdtUsuarioId.Text+') do Usuário inválido!');
     EdtUsuarioId.Clear;
     Exit;
  End;
  if (EdtPerfilId.Text<>'') and (StrToIntDef(EdtPerfilId.Text, 0) <= 0) then Begin
     EdtPerfilId.SetFocus;
     ShowErro('Id('+EdtPerfilId.Text+') do Perfil inválido!');
     EdtPerfilId.Clear;
     Exit;
  End;
  if (EdtFuncionalidadeId.Text<>'') and (StrToIntDef(EdtFuncionalidadeId.Text, 0) <= 0) then Begin
     EdtFuncionalidadeId.SetFocus;
     ShowErro('Id('+EdtFuncionalidadeId.Text+') da Funcionalidade inválida!');
     EdtFuncionalidadeId.Clear;
     Exit;
  End;
  inherited;
  Limpar;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  TDialogMessage.ShowWaitMessage('Buscando Dados dos Volumes...',
  procedure
  Begin
    if (ChkAtivo.Checked) and (ChkInativo.Checked) then
       pStatus := 3
    Else if (ChkAtivo.Checked) then
       pStatus := 1
    Else If (ChkInativo.Checked) then
       pStatus := 0;
    ObjUsuarioCtrl   := TUsuarioCtrl.Create;
    JsonArrayRetorno := ObjUsuarioCtrl.GetUsuarioLista(StrToIntDef(EdtUsuarioId.Text, 0), StrToIntDef(EdtFuncionalidadeId.Text, 0), StrToIntDef(EdtPerfilId.Text,0), pStatus);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro(vErro);
       JsonArrayRetorno := Nil;
       ObjUsuarioCtrl.Free;
       Exit;
    End;
    LstReport.RowCount := JsonArrayRetorno.Count+1;
    FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
    MontaListaUsuarios;
    JsonArrayRetorno := Nil;
    ObjUsuarioCtrl.Free;
  End);
end;

end.
