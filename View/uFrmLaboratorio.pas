unit uFrmLaboratorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB, Vcl.ExtDlgs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, cxPC, acPNG, acImage, dxGDIPlusClasses, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize,
  AdvUtil, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  AdvLookupBar, AdvGridLookupBar, AdvObj, BaseGrid, ImagePicker, System.Json
  , LaboratorioCtrl, Generics.Collections, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls, ACBrBase, ACBrETQ,
  dxCameraControl;

type
  TFrmLaboratorio = class(TFrmBase)
    EdtHomePage: TLabeledEdit;
    EdtEmail: TLabeledEdit;
    EdtFone: TLabeledEdit;
    EdtNome: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    FdMemPesqGeralNome: TStringField;
    FdMemPesqGeralFone: TStringField;
    FdMemPesqGeralEmail: TStringField;
    FdMemPesqGeralhomepage: TStringField;
    FdMemPesqGeralStatus: TIntegerField;
    FdMemPesqGeralidlaboratorio: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtFoneKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEnter(Sender: TObject);
    procedure EdtNomeExit(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure BtnImportarStandClick(Sender: TObject);
    //procedure BtnOpeFileClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
  private
    { Private declarations }
    FLaboratorio     : TLaboratorioCtrl;
    Function GetListaLaboratorio(pIdLaboratorio : Integer = 0; pNome : String = '') : Boolean;
    Procedure HeaderLstCadastro;
    Procedure DefineField;
  Protected
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Function DeleteReg : Boolean; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure Limpar; OverRide;
    procedure OpenFileImport; OverRide;
  public
    { Public declarations }
    //http://equivalentes.com.br/lista-laboratorios/
  end;

var
  FrmLaboratorio: TFrmLaboratorio;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmLaboratorio.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtNome.SetFocus;
end;

procedure TFrmLaboratorio.BtnImportarStandClick(Sender: TObject);
begin
  if EdtCodigo.ReadOnly = True then Exit;
  inherited;
end;

procedure TFrmLaboratorio.BtnImportClick(Sender: TObject);
Var RetJsonArray : TJsonArray;
    vErro :String;
    vProblema : Boolean;
    ObjLaboratorioCtrl : TLaboratorioCtrl;
begin
  inherited;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  vProblema := False;
  FdMemPesqGeral.First;
  ObjLaboratorioCtrl := TLaboratorioCtrl.Create;
  While Not FdMemPesqGeral.Eof Do Begin
    if (Not ObjLaboratorioCtrl.ImportDados(FdMemPesqGeral.FieldByName('IdLaboratorio').AsInteger,
                                           FdMemPesqGeral.FieldByName('Nome').AsString,
                                           FdMemPesqGeral.FieldByName('Fone').AsString,
                                           FdMemPesqGeral.FieldByName('Email').AsString,
                                           FdMemPesqGeral.FieldByName('HomePage').AsString )) then Begin
       MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('IdLaboratorio').AsString+' - '+
                            FdMemPesqGeral.FieldByName('Nome').AsString);
       vProblema := True;
    End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemPesqGeral.Next;
  End;
  if Not vProblema then
     ShowMessage('Importação concluída...')
  Else ShowMessage('Importação concluída com erros...');
  FreeAndNil(ObjLaboratorioCtrl);
end;

procedure TFrmLaboratorio.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtNome.SetFocus;
end;

procedure TFrmLaboratorio.OpenFileImport; //BtnOpeFileClick(Sender: TObject);
var ArquivoCSV: TextFile;
    Linha : String;
    I : Integer;
    vLaboratorioId : Integer;
    vLaboratorio, vErro : String;
    JsonArrayProduto, JsonArrayEndereco : TJsonArray;
  Function MontaValor: String;
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
      //vCdProduto := MontaValor;
      FdMemPesqGeral.Append;
      FdMemPesqGeral.FieldByName('IdLaboratorio').AsInteger := StrToInt64(MontaValor);
      FdMemPesqGeral.FieldByName('Nome').AsString    := MontaValor;
      FdMemPesqGeral.FieldByName('Fone').AsString    := MontaValor;
      FdMemPesqGeral.FieldByName('Email').AsString    := MontaValor;
      FdMemPesqGeral.FieldByName('HomePage').AsString    := MontaValor;
      FdMemPesqGeral.FieldByName('Status').AsInteger    := 1;
      LblImportaCSV.Caption := 'Importando: '+FdMemPesqGeral.FieldByName('IdLaboratorio').AsString;
      Application.ProcessMessages;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmLaboratorio.DefineField;
begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
  End;
  with FdMemPesqGeral.FieldDefs do begin
    Add('IdLaboratorio', ftInteger, 0,False);
    Add('Nome', ftString, 50, False);
    Add('Fone', ftString, 11, False);
    Add('Email', ftString, 100, False);
    Add('HomePage', ftString, 100, False);
    Add('Status', ftInteger, 0, False);
    FdMemPesqGeral.CreateDataSet;
    FdMemPesqGeral.Open;
  end;
end;

function TFrmLaboratorio.DeleteReg: Boolean;
begin
  Result := FLaboratorio.DelLaboratorio;
end;

procedure TFrmLaboratorio.edtCodigoChange(Sender: TObject);
begin
  inherited;
  if (Sender=EdtCodigo) and (Not EdtCodigo.ReadOnly) and (StrToInt64Def(EdtCodigo.Text,0)<>FLaboratorio.ObjLaboratorio.IdLaboratorio)then
     Limpar;
end;

procedure TFrmLaboratorio.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmLaboratorio.edtCodigoExit(Sender: TObject);
Var LstLaboratorio       : TObjectList<TLaboratorioCtrl>;
begin
  if (EdtCodigo.Text<>'')  and (StrToIntDef(EdtCodigo.Text,0)<=0) then Begin
     EdtCodigo.SetFocus;
     ShowErro('Código('+EdtCodigo.Text+') inválido!');
     EdtCodigo.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text<>'') and (StrToIntDef(EdtCodigo.Text, 0)<>FLaboratorio.ObjLaboratorio.IdLaboratorio) then Begin
     Limpar;
     if StrToInt64Def(EdtCodigo.Text, 0) = 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     FLaboratorio.ObjLaboratorio.IdLaboratorio := StrToIntDef(EdtCodigo.Text, 0);
     LstLaboratorio := FLaboratorio.GetLaboratorio(StrToIntDef(EdtCodigo.Text, 0), '');
     if LstLaboratorio.Count > 0 then Begin
        FLaboratorio := LstLaboratorio[0];
        ShowDados;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmLaboratorio.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmLaboratorio.EdtConteudoPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex = 0 then
     SoNumeros(Key);
end;

procedure TFrmLaboratorio.EdtFoneKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmLaboratorio.EdtNomeExit(Sender: TObject);
begin
  inherited;
  Exitfocus(Sender);
end;

procedure TFrmLaboratorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmLaboratorio := Nil;
end;

procedure TFrmLaboratorio.FormCreate(Sender: TObject);
Var I : Integer;
begin
  inherited;
  FLaboratorio := TLaboratorioCtrl.Create;
  //GetListaLaboratorio;
end;

procedure TFrmLaboratorio.FormDestroy(Sender: TObject);
begin
  FLaboratorio.DisposeOf;
  inherited;
end;

Function TFrmLaboratorio.GetListaLaboratorio(pIdLaboratorio : Integer = 0; pNome : String = '') : Boolean;
Var xLista         : Integer;
    LstLaboratorio : TObjectList<TLaboratorioCtrl>;
begin
  HeaderLstCadastro;
  LstLaboratorio := FLaboratorio.GetLaboratorio(PIdLaboratorio, pNome, 0);
  Result := LstLaboratorio.Count >= 1;
  for xLista := 1 to LstLaboratorio.Count do
    LstCadastro.AddDataImage(5, xLista, 0, haCenter, vaTop);
  If LstLaboratorio.Count >= 1 then Begin
     LstCadastro.RowCount := LstLaboratorio.Count+1;
     For xLista := 0 To LstLaboratorio.Count-1 do begin
       LstCadastro.Cells[0, xLista+1] := LstLaboratorio[xLista].ObjLaboratorio.IdLaboratorio.ToString();
       LstCadastro.Cells[1, xLista+1] := LstLaboratorio[xLista].ObjLaboratorio.Nome;
       LstCadastro.Cells[2, xLista+1] := LstLaboratorio[xLista].ObjLaboratorio.Fone;
       LstCadastro.Cells[3, xLista+1] := LstLaboratorio[xLista].ObjLaboratorio.Email;
       LstCadastro.Cells[4, xLista+1] := LstLaboratorio[xLista].ObjLaboratorio.HomePage;
       LstCadastro.Cells[5, xLista+1] := Trim(LstLaboratorio[xLista].ObjLaboratorio.Status.ToString());
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.Alignments[5, xLista+1] := taCenter;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
     end;
     LstCadastro.FixedRows := 1;
     //MontarPaginacao(FLaboratorio.MontarPaginacao);
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  LblTotReg.Caption := Pred(LstCadastro.RowCount).ToString();
  //LstLaboratorio := Nil;
end;

procedure TFrmLaboratorio.GetListaLstCadastro;
begin
  inherited;
  GetListaLaboratorio(0, '');
end;

procedure TFrmLaboratorio.HeaderLstCadastro;
begin
  LstCadastro.ColCount := 6;
  With LstCadastro do Begin
    Cells[0, 0] := 'Id';
    Cells[1, 0] := 'Nome';
    Cells[2, 0] := 'Fone';
    Cells[3, 0] := 'Email';
    Cells[4, 0] := 'Home Page';
    Cells[5, 0] := 'Status';
    ColWidths[0] := 70;
    ColWidths[1] := 300;
    ColWidths[2] := 140;
    ColWidths[3] := 250;
    ColWidths[4] := 250;
    ColWidths[5] := 60;
  End;
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.Alignments[2, 0] := taCenter;
  LstCadastro.Alignments[5, 0] := taCenter;
  LstCadastro.FontStyles[0, 0] := [FsBold];
end;

procedure TFrmLaboratorio.Limpar;
begin
  EnabledButtons := False;
  if Not (EdtCodigo.Enabled) then
     EdtCodigo.Clear;
  If Assigned(FLaboratorio) then FLaboratorio.ObjLaboratorio.Limpar;
  EdtNome.Clear;
  EdtFone.Clear;
  EdtEmail.Clear;

  EdtHomePage.clear;
  ChkCadastro.Checked := False;
end;

procedure TFrmLaboratorio.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
var
  i: integer;
begin
//  inherited;
  if not Assigned(AEditLink) then
    Exit;
  If aCol = 5 then begin
     with (aEditLink.GetEditControl as TImagePicker) do begin
       BeginUpdate;
       Items.Clear;
       for i := 0 to 1 do
         Items.Add.ImageIndex := i;
       EndUpdate;
     end;
 end;
end;

procedure TFrmLaboratorio.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
//  inherited;
  if acol<5 then LstCadastro.EditLink:=el1
  Else if acol=5 then LstCadastro.EditLink:=el6;
  if acol in [2,3,4,5] then aEditor:=edCustom;

end;

procedure TFrmLaboratorio.PesquisarClickInLstCadastro(aCol, aRow : Integer);
begin
  inherited;
  edtCodigo.Text := LstCadastro.Cells[aCol, aRow];
  edtCodigoExit(EdtCodigo);
  PgcBase.ActivePage := TabPrincipal;
end;

function TFrmLaboratorio.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  inherited;
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Begin
        if StrToIntDef(EdtConteudoPesq.Text, 0) = 0 then
           raise Exception.Create('Conteúdo(Id) inválido para pesquisa.')
        Else Result := GetListaLaboratorio(StrToIntDef(EdtConteudoPesq.Text,0), '')
     End
     Else if Length(EdtConteudoPesq.text) < 3 then
             raise Exception.Create('você deve digitar pelo menos 3 character!')
          Else Result := GetListaLaboratorio(0, EdtConteudoPesq.Text);
     If Result then
        EdtConteudoPesq.Clear;
  End;
  //Result := True;
end;

function TFrmLaboratorio.SalvarReg: Boolean;
begin
  With FLaboratorio.ObjLaboratorio do Begin
     IdLaboratorio := StrToIntDef(EdtCodigo.Text, 0);
     Nome          := EdtNome.Text;
     Fone          := EdtFone.Text;
     Email         := EdtEmail.Text;
     HomePage      := EdtHomePage.Text;
     Status        := Ord(ChkCadastro.Checked);
  End;
  Result := FLaboratorio.Salvar;
  if Result then FLaboratorio.ObjLaboratorio.IdLaboratorio := 0;
end;

procedure TFrmLaboratorio.ShowDados;
begin
  inherited;
  With FLaboratorio.ObjLaboratorio do Begin
    edtCodigo.Text := IdLaboratorio.ToString();
    EdtNome.Text   := Nome;
    EdtFone.Text   := Fone;
    EdtEmail.Text  := Email;
    EdtHomePage.Text  := HomePage;
    ChkCadastro.Checked := Status = 1;
    ChkCadastroClick(ChkCadastro);
  End;
end;

end.
