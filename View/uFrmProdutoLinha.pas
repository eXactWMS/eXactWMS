unit uFrmProdutoLinha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, ProdutoLinhaCtrl,
  Generics.Collections, System.Json, DataSet.Serialize, uFuncoes;

type
  TFrmProdutoLinha = class(TFrmBase)
    edtCodigo: TLabeledEdit;
    EdtDescricao: TLabeledEdit;
    EdtSigla: TLabeledEdit;
    btnPesquisar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnImportarStandClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSiglaExit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    Function GetListaProdutoLinha(pProdutoLinhaId : Integer = 0; pDescricao : String = '') : Boolean;
    Procedure HeaderLstCadastro;
    Procedure DefineField;
  public
    { Public declarations }
  Protected
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Function DeleteReg : Boolean; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure Limpar; OverRide;
    procedure OpenFileImport; OverRide;
  end;

var
  FrmProdutoLinha: TFrmProdutoLinha;

implementation

{$R *.dfm}

procedure TFrmProdutoLinha.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtSigla.SetFocus;
end;

procedure TFrmProdutoLinha.BtnImportarStandClick(Sender: TObject);
begin
  inherited;
  if Not EdtCodigo.ReadOnly then Exit;
end;

procedure TFrmProdutoLinha.BtnImportClick(Sender: TObject);
Var RetJsonArray : TJsonArray;
    vErro :String;
    vProblema : Boolean;
    ObjProdutoLinhaCtrl : TProdutoLinhaCtrl;
begin
  inherited;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  vProblema := False;
  FdMemPesqGeral.First;
  ObjProdutoLinhaCtrl := TProdutoLinhaCtrl.Create;
  While Not FdMemPesqGeral.Eof Do Begin
    if (Not ObjProdutoLinhaCtrl.ImportDados(FdMemPesqGeral.FieldByName('id').AsInteger,
                                           FdMemPesqGeral.FieldByName('sigla').AsString,
                                           FdMemPesqGeral.FieldByName('descricao').AsString , 1)) then Begin
       MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('Id').AsString+' - '+
                            FdMemPesqGeral.FieldByName('Descricao').AsString);
       vProblema := True;
    End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemPesqGeral.Next;
  End;
  if Not vProblema then
     ShowMessage('Importação concluída...')
  Else ShowMessage('Importação concluída com erros...');
  ObjProdutoLinhaCtrl.Free;
end;

procedure TFrmProdutoLinha.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtSigla.SetFocus;
end;

procedure TFrmProdutoLinha.DefineField;
begin
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.Close;
  FdMemPesqGeral.FieldDefs.Clear;
  with FdMemPesqGeral.FieldDefs do begin
    Add('Id', ftInteger, 0,False);
    Add('Sigla', ftString, 5, False);
    Add('Descricao', ftString, 60, False);
    Add('Status', ftInteger, 0, False);
    FdMemPesqGeral.CreateDataSet;
    FdMemPesqGeral.Open;
  end;
end;

function TFrmProdutoLinha.DeleteReg: Boolean;
Var ObjProdutoLinhaCtrl : TProdutoLinhaCtrl;
begin
  Result := ObjProdutoLinhaCtrl.DelProdutoLinha(StrToIntDef(EdtCodigo.Text, 0));
end;

procedure TFrmProdutoLinha.edtCodigoChange(Sender: TObject);
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) then
     Limpar;
end;

procedure TFrmProdutoLinha.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmProdutoLinha.edtCodigoExit(Sender: TObject);
Var JsonArrayRetorno   : TJsonArray;
    ObjProdutoLinhaCtrl : TProdutoLinhaCtrl;
    vErro : String;
begin
  inherited;
  if (Not EdtCodigo.ReadOnly) and (EdtCodigo.Text<>'') then Begin
     Limpar;
     if StrToInt64Def(EdtCodigo.Text, 0) = 0 then
        raise Exception.Create('Id da Linha inválido para pesquisa!');
     ObjProdutoLinhaCtrl := TProdutoLinhaCtrl.Create;
     JsonArrayRetorno := ObjProdutoLinhaCtrl.GetProdutoLinha(StrToIntDef(EdtCodigo.Text, 0), '', 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
        ShowErro('Id da Linha não encontrado!')
     Else Begin
       If FdMemPesqGeral.Active then
          FdMemPesqGeral.EmptyDataSet;
       FdMemPesqGeral.Close;
       FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
       ShowDados;
     End;
     JsonArrayRetorno := Nil;
     ObjProdutoLinhaCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProdutoLinha.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmProdutoLinha.EdtConteudoPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex = 0 then
     SoNumeros(Key);
end;

procedure TFrmProdutoLinha.EdtSiglaExit(Sender: TObject);
begin
  inherited;
  Exitfocus(Sender);
end;

procedure TFrmProdutoLinha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmProdutoLinha := Nil;
end;

function TFrmProdutoLinha.GetListaProdutoLinha(pProdutoLinhaId: Integer;
  pDescricao: String): Boolean;
Var xLista             : Integer;
    JsonArrayRetorno   : TJsonArray;
    ObjProdutoLinhaCtrl : TProdutoLinhaCtrl;
    vErro : String;
begin
  Result := True;
  LblTotReg.Caption := '0';
  HeaderLstCadastro;
  LstCadastro.RowCount := 1;
  ImprimirExportar(False);
  ObjProdutoLinhaCtrl := TProdutoLinhaCtrl.Create;
  jsonArrayRetorno := ObjProdutoLinhaCtrl.GetProdutoLinha(pProdutoLinhaId, pDescricao);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     Result := True;
     If FdMemPesqGeral.Active then
        FdMemPesqGeral.EmptyDataSet;
     FdMemPesqGeral.Close;
     FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
     LstCadastro.RowCount := JsonArrayRetorno.Count+1;
     for xLista := 0 to Pred(JsonArrayRetorno.Count) do
       LstCadastro.AddDataImage(3, xLista+1, 0, haCenter, vaTop);
     For xLista := 0 To Pred(JsonArrayRetorno.Count) do begin
       LstCadastro.Cells[0, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<Integer>('linhaid').ToString();
       LstCadastro.Cells[1, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('sigla');
       LstCadastro.Cells[2, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('descricao');
       LstCadastro.Cells[3, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('status');
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[3, xLista+1] := taCenter;
     end;
     LstCadastro.FixedRows := 1;
     //MontarPaginacao(FLaboratorio.MontarPaginacao);
     LstCadastro.SortSettings.Column := 2;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
     LblTotReg.Caption := JsonArrayRetorno.Count.ToString();
     ImprimirExportar(True);
  End;
  JsonArrayRetorno := Nil;
  ObjProdutoLinhaCtrl.Free;
end;

procedure TFrmProdutoLinha.GetListaLstCadastro;
begin
  inherited;
  GetListaProdutoLinha(0, '');
end;

procedure TFrmProdutoLinha.HeaderLstCadastro;
begin
  LstCadastro.ColCount := 4;
  With LstCadastro do Begin
    Cells[0, 0] := 'Id';
    Cells[1, 0] := 'Sigla';
    Cells[2, 0] := 'Descricao';
    Cells[3, 0] := 'Ativo';
    ColWidths[0] :=  60;
    ColWidths[1] := 120;
    ColWidths[2] := 350;
    ColWidths[3] :=  40;
  End;
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[3, 0] := taCenter;
end;

procedure TFrmProdutoLinha.Limpar;
begin
  inherited;
  if Not (EdtCodigo.Enabled) then
     EdtCodigo.Clear;
  EdtSigla.Clear;
  EdtDescricao.Clear;
  ChkCadastro.Checked := False;
end;

procedure TFrmProdutoLinha.OpenFileImport;
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
      FdMemPesqGeral.FieldByName('Id').AsInteger       := StrToInt64(MontaValor);
      FdMemPesqGeral.FieldByName('Sigla').AsString     := MontaValor;
      FdMemPesqGeral.FieldByName('Descricao').AsString := MontaValor;
      FdMemPesqGeral.FieldByName('Status').AsInteger   := StrToIntDef(MontaValor, 0);
      LblImportaCSV.Caption := 'Importando: '+FdMemPesqGeral.FieldByName('descricao').AsString;
      Application.ProcessMessages;
    end;
  Except On E: Exception do
    showErro('Erro: '+E.Message);
  end;
  CloseFile(ArquivoCSV);
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmProdutoLinha.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  edtCodigo.Text := LstCadastro.Cells[aCol, aRow];
  edtCodigoExit(EdtCodigo);
  PgcBase.ActivePage := TabPrincipal;
end;

function TFrmProdutoLinha.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Begin
        if StrToIntDef(EdtConteudoPesq.Text, 0) = 0 then
           raise Exception.Create('Conteúdo(Id) inválido para pesquisa.')
        Else Result := GetListaProdutoLinha(StrToIntDef(EdtConteudoPesq.Text,0), '')
     End
     Else if Length(EdtConteudoPesq.text) < 3 then
             raise Exception.Create('você deve digitar pelo menos 3 character!')
          Else Result := GetListaProdutoLinha(0, EdtConteudoPesq.Text);
     If Result then
        EdtConteudoPesq.Clear;
  End;
end;

function TFrmProdutoLinha.SalvarReg: Boolean;
Var ObjProdutoLinhaCtrl : TProdutoLinhaCtrl;
begin
  ObjProdutoLinhaCtrl := TProdutoLinhaCtrl.Create;
  With ObjProdutoLinhaCtrl.ObjProdutoLinha do Begin
     Id        := StrToIntDef(EdtCodigo.Text, 0);
     Sigla     := EdtSigla.Text;
     Descricao := EdtDescricao.Text;
     Status    := Ord(ChkCadastro.Checked);
  End;
  Result := ObjProdutoLinhaCtrl.Salvar;
end;

procedure TFrmProdutoLinha.ShowDados;
begin
  inherited;
  EdtSigla.Text       := FdMemPesqGeral.FieldByName('Sigla').AsString;
  EdtDescricao.Text   := FdMemPesqGeral.FieldByName('Descricao').AsString;
  ChkCadastro.Checked := FdMemPesqGeral.FieldByName('Status').AsInteger = 1;
  ChkCadastroClick(ChkCadastro);
end;

end.
