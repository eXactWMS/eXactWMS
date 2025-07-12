unit uFrmEnderecamentoRuas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, System.JSOn,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, Generics.Collections,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin
  , EnderecamentoRuaClass
  , EnderecamentoRuaCtrl, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmEnderecamentoRuas = class(TFrmBase)
    Label2: TLabel;
    EdtRuaId: TEdit;
    Label3: TLabel;
    EdtDescricao: TEdit;
    Label4: TLabel;
    CbLado: TComboBox;
    procedure EdtDescricaoExit(Sender: TObject);
    procedure EdtDescricaoEnter(Sender: TObject);
    procedure EdtRuaIdExit(Sender: TObject);
    procedure EdtRuaIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtRuaIdKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    //procedure BtnOpeFileClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
  private
    { Private declarations }
    ObjEnderecamentoRuasCtrl : TEnderecoRuaCtrl;
    Function GetListaEnderecamentoRuas(pId : Integer; pDescricao : String) : Boolean;
    Procedure DefineField;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure Limpar; OverRide;  public
    procedure OpenFileImport; OverRide;
    { Public declarations }
  end;

var
  FrmEnderecamentoRuas: TFrmEnderecamentoRuas;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmEnderecamentoRuas.BtnImportClick(Sender: TObject);
Var JsonRetorno : TJsonObject;
    vErro :String;
begin
  inherited;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  FdMemPesqGeral.First;
  While Not FdMemPesqGeral.Eof Do Begin
    ObjEnderecamentoRuasCtrl.ObjEnderecoRua.RuaId     := 0;
    ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Descricao := FdMemPesqGeral.FieldByName('Descricao').AsString;
    ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Lado      := FdMemPesqGeral.FieldByName('Lado').AsString;
    ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Status    := 1;
    Try
      JsonRetorno := ObjEnderecamentoRuasCtrl.Salvar;
      If JsonRetorno.TryGetValue('Erro', vErro) then Begin
         MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('Descricao').AsString+' - '+
                              FdMemPesqGeral.FieldByName('Lado').AsString);
    End;
    Except On E: Exception do Begin
      MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('Descricao').AsString+' - '+
                              FdMemPesqGeral.FieldByName('Lado').AsString);
      End;
    End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemPesqGeral.Next;
  End;
  ShowMessage('Importação concluída...');
end;

procedure TFrmEnderecamentoRuas.OpenFileImport; //.BtnOpeFileClick(Sender: TObject);
var ArquivoCSV: TextFile;
    Linha : String;
    I     : Integer;
    vLado : String;
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
      FdMemPesqGeral.FieldByName('Descricao').AsString := GetValor;
      vLado := GetValor;
      if (UpperCase(vLado) = 'PAR') or (vLado = 'P') then
         vLado := 'P'
      Else If (UpperCase(vLado) = 'IMPAR') or (vLado = 'I') then
         vLado := 'I'
      Else vLado := 'U';
      FdMemPesqGeral.FieldByName('Lado').AsString := vLado;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmEnderecamentoRuas.DefineField;
begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
  End;
  With FdMemPesqGeral.FieldDefs do begin
     Add('Descricao', ftString, 30, True);
     Add('Lado',      ftstring,  10, True);
  End;
  FdMemPesqGeral.CreateDataSet;
  FdMemPesqGeral.Open;
end;

function TFrmEnderecamentoRuas.DeleteReg: Boolean;
begin
  Result := ObjEnderecamentoRuasCtrl.DelEnderecoRua;
end;

procedure TFrmEnderecamentoRuas.EdtConteudoPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex in [0] then
     SoNumeros(Key);
end;

procedure TFrmEnderecamentoRuas.EdtDescricaoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmEnderecamentoRuas.EdtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamentoRuas.EdtRuaIdExit(Sender: TObject);
Var
    vErro : String;
begin
  if (EdtRuaId.Text<>'') and (StrToIntDef(EdtRuaId.Text, 0) <= 0) then Begin
     EdtRuaId.setFocus;
     ShowErro('Id da Rua inválido!');
     EdtRuaId.Clear;
     Exit;
  End;
  inherited;
  if (EdtRuaId.Text<>'') and (EdtRuaId.Text<>ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Descricao) then Begin
     Limpar;
     if StrToIntDef(EdtRuaId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtRuaId.Text+') inválido!');
     ObjEnderecamentoRuasCtrl.ObjEnderecoRua := ObjEnderecamentoRuasCtrl.GetEnderecoRua(StrToIntDef(EdtRuaId.Text, 0), '', '', 0)[0];
     if ObjEnderecamentoRuasCtrl.ObjEnderecoRua.RuaId > 0 then
        ShowDados;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamentoRuas.EdtRuaIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmEnderecamentoRuas.EdtRuaIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Not EdtRuaId.ReadOnly) and (Sender=EdtRuaId) then Begin
     EdtDescricao.Clear;
     Limpar;
  End;
end;

procedure TFrmEnderecamentoRuas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmEnderecamentoRuas := Nil;
end;

procedure TFrmEnderecamentoRuas.FormCreate(Sender: TObject);
begin
  inherited;
  ObjEnderecamentoRuasCtrl := TEnderecoRuaCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0]  := 70;
    ColWidths[1]  := 150;
    ColWidths[2]  := 70;
    ColWidths[3]  := 40;
    Alignments[0, 0]  := taRightJustify;
    FontStyles[0, 0]  := [FsBold];
  End;
  GetListaEnderecamentoRuas(0, '');
end;

procedure TFrmEnderecamentoRuas.FormDestroy(Sender: TObject);
begin
  ObjEnderecamentoRuasCtrl := Nil;
  inherited;
end;

function TFrmEnderecamentoRuas.GetListaEnderecamentoRuas(pId: Integer;
  pDescricao: String): Boolean;
Var xLista, xImg         : Integer;
    LstEnderecamentoRuas : TObjectList<TEnderecoRua>;
begin
  LstEnderecamentoRuas := ObjEnderecamentoRuasCtrl.GetEnderecoRua(pId, pDescricao, '', 1);
  Result := (LstEnderecamentoRuas.Count >= 1) and (LstEnderecamentoRuas[0].RuaId <> 0);
  If LstEnderecamentoRuas.Count >= 1 then  Begin
     LstCadastro.RowCount := LstEnderecamentoRuas.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount do
       LstCadastro.AddDataImage( 3, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstEnderecamentoRuas.Count-1 do begin
       LstCadastro.Cells[0, xLista+1] := LstEnderecamentoRuas[xLista].RuaId.ToString();
       LstCadastro.Cells[1, xLista+1] := LstEnderecamentoRuas[xLista].Descricao;
       If LstEnderecamentoRuas[xLista].Lado = 'I' then
          LstCadastro.Cells[2, xLista+1] := 'Impar'
       else If LstEnderecamentoRuas[xLista].Lado = 'P' then
          LstCadastro.Cells[2, xLista+1] := 'Par'
       else
          LstCadastro.Cells[2, xLista+1] := 'Único';
       LstCadastro.Cells[3, xLista+1] := LstEnderecamentoRuas[xLista].Status.ToString;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[2, xLista+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
end;

procedure TFrmEnderecamentoRuas.GetListaLstCadastro;
begin
  inherited;
   GetListaEnderecamentoRuas(0, '');
end;

procedure TFrmEnderecamentoRuas.Limpar;
begin
  inherited;
  EnabledButtons := False;
  //EdtRuaId.ReadOnly := False;
  EdtDescricao.Clear;
  CbLado.ItemIndex := - 1;
  ShCadastro.Brush.Color := ClRed;
  ShCadastro.Pen.Color   := ClRed;
  If Assigned(ObjEnderecamentoRuasCtrl) Then
     ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Limpar;
end;

procedure TFrmEnderecamentoRuas.PesquisarClickInLstCadastro(aCol,
  aRow: Integer);
begin
  inherited;
  EdtRuaId.Text := LstCadastro.Cells[0, aRow];
  EdtRuaIdExit(EdtRuaId);
end;

function TFrmEnderecamentoRuas.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para pesquisar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaEnderecamentoRuas(StrToIntDef(EdtConteudoPesq.Text, 0), '')
        else raise Exception.Create('Id da Rua inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then
        Result := GetListaEnderecamentoRuas(0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmEnderecamentoRuas.SalvarReg: Boolean;
Var vErro : String;
begin
  ObjEnderecamentoRuasCtrl.ObjEnderecoRua.RuaId     := StrToIntDef(EdtRuaId.Text, 0);
  ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Descricao := EdtDescricao.Text;
  if CbLado.ItemIndex = 0 then
     ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Lado := 'I'
  Else if CbLado.ItemIndex = 1 then
     ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Lado := 'P'
  Else
     ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Lado := 'U';
  If ChkCadastro.Checked Then ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Status := 1
  Else ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Status := 0;
  If Not ObjEnderecamentoRuasCtrl.Salvar.TryGetValue('Erro', vErro) then Begin
     ObjEnderecamentoRuasCtrl.ObjEnderecoRua.RuaId  := 0;
     Result := True
  End
  Else Result := False;
end;

procedure TFrmEnderecamentoRuas.ShowDados;
begin
  inherited;
  If EdtRuaId.Text = '' then
     EdtRuaId.Text    := ObjEnderecamentoRuasCtrl.ObjEnderecoRua.RuaId.ToString();
  EdtDescricao.Text   := ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Descricao;
  if ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Lado = 'I' then
     CbLado.ItemIndex := 0
  Else if ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Lado = 'P' then
     CbLado.ItemIndex := 1
  Else CbLado.ItemIndex := 2;
  ChkCadastro.Checked := ObjEnderecamentoRuasCtrl.ObjEnderecoRua.Status = 1;
  if ChkCadastro.Checked then Begin
    ShCadastro.Brush.Color := ClGreen;
    ShCadastro.Pen.Color   := ClGreen;
  End
  Else Begin
    ShCadastro.Brush.Color := ClRed;
    ShCadastro.Pen.Color   := ClRed;
  End;
end;

procedure TFrmEnderecamentoRuas.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  If EdtRuaId.Enabled then
     EdtRuaId.SetFocus;
end;

end.
