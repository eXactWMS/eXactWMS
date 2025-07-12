unit uFrmRelControleArmazenagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, Generics.Collections,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  System.JSON, REST.Json, Rest.Types, DataSet.Serialize,
  JvExMask, JvSpin, JvToolEdit;

type
  TFrmRelControleArmazenagem = class(TFrmReportBase)
    GroupBox6: TGroupBox;
    LblProduto: TLabel;
    BtnSearchProdMovInterna: TBitBtn;
    EdtCodProduto: TEdit;
    GroupBox7: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EdtDataInicial: TJvDateEdit;
    EdtDataFinal: TJvDateEdit;
    GroupBox11: TGroupBox;
    LblEndereco: TLabel;
    EdtEndereco: TEdit;
    BtnPesqEndereco: TBitBtn;
    GroupBox8: TGroupBox;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BitBtn2: TBitBtn;
    GbTipoMovimentacao: TGroupBox;
    ChkArmazenamento: TCheckBox;
    ChkMovInterna: TCheckBox;
    GroupBox10: TGroupBox;
    EdtDocumentoNr: TEdit;
    LblQtdeMovimentada: TLabel;
    Label5: TLabel;
    GbTipoRelatorio: TGroupBox;
    ChkAnalitico: TCheckBox;
    ChkSintetico: TCheckBox;
    Bevel1: TBevel;
    Label2: TLabel;
    Label6: TLabel;
    EdtMeta: TEdit;
    Label7: TLabel;
    EdtTolerancia: TEdit;
    procedure BtnSearchProdMovInternaClick(Sender: TObject);
    procedure EdtCodProdutoChange(Sender: TObject);
    procedure EdtEnderecoChange(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure EdtDocumentoNrChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqEnderecoClick(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ChkAnaliticoClick(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
  private
    { Private declarations }
    vCodProduto, vEnderecoId : Integer;
    Procedure MontaListaCA;
    Procedure ShowFieldLstReport;
    Procedure ConfigSizeLstReport(pRow : Integer);
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelControleArmazenagem: TFrmRelControleArmazenagem;

implementation

{$R *.dfm}

uses uFuncoes, Views.Pequisa.Produtos, Views.Pequisa.Endereco, EnderecoCtrl, ProdutoCtrl,
     EstoqueCtrl, UsuarioCtrl, uFrmeXactWMS, Vcl.DialogMessage, Views.Pequisa.Usuarios;

procedure TFrmRelControleArmazenagem.BitBtn2Click(Sender: TObject);
begin
  inherited;
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

procedure TFrmRelControleArmazenagem.BtnPesqEnderecoClick(Sender: TObject);
Var vEnderecoId : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       EdtEndereco.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 0, 1)[0].Descricao;
       EdtEnderecoExit(EdtEndereco);
       ObjEnderecoCtrl := Nil;
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmRelControleArmazenagem.BtnPesquisarStandClick(Sender: TObject);
begin
  if ChkSintetico.Checked then
     PesquisarDados
  Else
     inherited;
end;

procedure TFrmRelControleArmazenagem.BtnSearchProdMovInternaClick(
  Sender: TObject);
begin
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then  Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelControleArmazenagem.ChkAnaliticoClick(Sender: TObject);
begin
  inherited;
  if Sender = ChkAnalitico then
     ChkSintetico.Checked := Not ChkAnalitico.Checked
  Else if Sender = ChkSintetico then
     ChkAnalitico.Checked := Not ChkSintetico.Checked;
  ShowFieldLstReport;
  Limpar;
end;

procedure TFrmRelControleArmazenagem.ConfigSizeLstReport(pRow: Integer);
Var xCol : Integer;
begin
  for xCol := 0 to 19 do  Begin
    LstReport.FontSizes[xCol, pRow] := 10;
  End;
end;

procedure TFrmRelControleArmazenagem.EdtCodProdutoChange(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LblProduto.Caption := '...';
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtCodProdutoExit(Sender: TObject);
Var ObjProdutoCtrl : TProdutoCtrl;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '...';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  if JsonProduto.GetValue<Integer>('codproduto') <= 0 then Begin
     ShowErro('Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     vCodProduto := 0;
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     JsonProduto := Nil;
     Exit;
  End;
  vCodProduto := JsonProduto.GetValue<Integer>('codproduto');
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmRelControleArmazenagem.EdtEnderecoChange(Sender: TObject);
begin
  inherited;
  vEnderecoId := 0;
  LblProduto.Caption := '...';
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtEnderecoExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
   LblEndereco.Caption := '';
   vEnderecoId := 0;
   if EdtEndereco.Text  = '' then Exit;
   ObjEnderecoCtrl := TEnderecoCtrl.Create();
   JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EdtEndereco.Text, EdtEndereco.Text, 'T', 2, 0, 1);
   if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
      EdtEndereco.SetFocus;
      ShowErro('Endereço não encontrado!');
   End
   Else Begin
      vEnderecoId := JsonArrayRetorno.Items[0].GetValue<Integer>('enderecoid');
      LblEndereco.Caption := (JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecoestrutura')).GetValue<String>('descricao')+' - '+
                             (JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecamentozona')).GetValue<String>('descricao');
   End;
   JsonArrayRetorno := Nil;
   ObjEnderecoCtrl.Free;
end;

procedure TFrmRelControleArmazenagem.EdtDocumentoNrChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  LblUsuario.Caption := '...';
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl   : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
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
end;

procedure TFrmRelControleArmazenagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelControleArmazenagem := Nil;
end;

procedure TFrmRelControleArmazenagem.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[ 0] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[ 1] :=  55+Trunc(55*ResponsivoVideo);
  LstReport.ColWidths[ 2] :=  60+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[ 3] :=  60+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[ 4] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[ 5] := 300+Trunc(300*ResponsivoVideo);
  LstReport.ColWidths[ 6] := 100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[ 7] :=  70+Trunc(70*ResponsivoVideo); //Endereco Origem
  LstReport.ColWidths[ 8] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[ 9] :=  70+Trunc(70*ResponsivoVideo); //Dt.Processo
  LstReport.ColWidths[10] :=  70+Trunc(70*ResponsivoVideo); //Dt.Processo
  LstReport.ColWidths[11] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[12] :=  70+Trunc(70*ResponsivoVideo); //Endereco Destino
  LstReport.ColWidths[13] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[14] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[15] := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[16] := 120+Trunc(120*ResponsivoVideo);
  LstReport.ColWidths[17] := 100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[18] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[19] :=  60+Trunc(60*ResponsivoVideo);
  LstReport.Alignments[ 0, 0] := taCenter;
  LstReport.FontStyles[ 0, 0] := [FsBold];
  LstReport.Alignments[ 1, 0] := taCenter;
  LstReport.Alignments[ 2, 0] := taCenter;
  LstReport.Alignments[ 3, 0] := taCenter;
  LstReport.Alignments[ 5, 0] := taLeftJustify;
  LstReport.Alignments[ 6, 0] := taLeftJustify;
  LstReport.Alignments[ 7, 0] := taCenter;
  LstReport.FontStyles[ 7, 0] := [FsBold];
  LstReport.Alignments[ 8, 0] := taRightJustify;
  LstReport.Alignments[ 9, 0] := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
  LstReport.Alignments[11, 0] := taRightJustify;
  LstReport.Alignments[12, 0] := taCenter;
  LstReport.Alignments[13, 0] := taRightJustify;
  LstReport.Alignments[14, 0] := taRightJustify;
  LstReport.Alignments[17, 0] := taCenter;
  LstReport.Alignments[18, 0] := taRightJustify;
  LstReport.Alignments[19, 0] := taRightJustify;
  ChkAnaliticoClick(ChkAnalitico);
end;

procedure TFrmRelControleArmazenagem.Imprimir;
begin
  inherited;

end;

procedure TFrmRelControleArmazenagem.Limpar;
begin
  inherited;
  FDMemPesqGeral.Fields.Clear;
  FDMemPesqGeral.FieldDefs.Clear;
  LblQtdeMovimentada.Caption := '0';
end;

procedure TFrmRelControleArmazenagem.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if ChkSintetico.Checked then Exit;
  inherited;
end;

procedure TFrmRelControleArmazenagem.MontaListaCA;
Var xRecno : Integer;
    xTotalQtde : Integer;
    vUsuarioId, vTotalQtdeUsuario, vTotalCxaUsuario : Integer;
    vUsuarioAtual : String;
    vUnidadesPorHora : Integer;
begin
  FdMemPesqGeral.First;
  xRecno     := 1;
  xTotalQtde := 0;
  vTotalQtdeUsuario := 0;
  vTotalCxaUsuario  := 0;
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[ 0, xRecno] := FdMemPesqGeral.FieldByName('Data').AsString;
    if ChkAnalitico.CheckEd then Begin
       LstReport.Cells[ 1, xRecno] := Copy(FdMemPesqGeral.FieldByName('Hora').AsString, 1, 8);
       LstReport.Cells[ 4, xRecno] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
       LstReport.Cells[ 5, xRecno] := FdMemPesqGeral.FieldByName('Produto').AsString;
       LstReport.Cells[ 6, xRecno] := FdMemPesqGeral.FieldByName('Lote').AsString;
    End
    Else Begin
       LstReport.Cells[ 2, xRecno] := FdMemPesqGeral.FieldByName('Inicio').AsString;
       LstReport.Cells[ 3, xRecno] := FdMemPesqGeral.FieldByName('Termino').AsString;
    End;
    LstReport.Cells[ 7, xRecno] := EnderecoMask(FdMemPesqGeral.FieldByName('EnderecoOrigem').AsString,
                                                FdMemPesqGeral.FieldByName('MascaraOrigem').AsString, True);
    if ChkAnalitico.CheckEd then
       LstReport.Cells[ 8, xRecno] := FdMemPesqGeral.FieldByName('SaldoInicialOrigem').AsString;
    LstReport.Cells[ 9, xRecno] := FdMemPesqGeral.FieldByName('Qtde').AsString;
    LstReport.Cells[10, xRecno] := FdMemPesqGeral.FieldByName('QtdCaixa').AsString;
    LstReport.FontStyles[9, xRecno]  := [FsBold];
    LstReport.FontStyles[10, xRecno]  := [FsBold];
    if ChkAnalitico.CheckEd then Begin
       LstReport.Cells[11, xRecno] := FdMemPesqGeral.FieldByName('SaldoFinalOrigem').AsString;
       LstReport.Cells[12, xRecno] := EnderecoMask(FdMemPesqGeral.FieldByName('EnderecoDestino').AsString,
                                                   FdMemPesqGeral.FieldByName('MascaraDestino').AsString, True);
       LstReport.Cells[13, xRecno] := FdMemPesqGeral.FieldByName('SaldoInicialDestino').AsString;
       LstReport.Cells[14, xRecno] := FdMemPesqGeral.FieldByName('SaldoFinalDestino').AsString;
    End;
    LstReport.Cells[15, xRecno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString+' '+FdMemPesqGeral.FieldByName('Nome').AsString;
    if ChkAnalitico.CheckEd then
       LstReport.Cells[16, xRecno] := FdMemPesqGeral.FieldByName('Terminal').AsString;
    if ChkSintetico.CheckEd then Begin
       LstReport.Cells[17, xRecno] := FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString;
       if FdMemPesqGeral.FieldByName('CalcHora').AsInteger = 1 then
          vUnidadesPorHora := CalcUnidHr(FdMemPesqGeral.FieldByName('Qtde').AsInteger, FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString )
       Else vUnidadesPorHora := FdMemPesqGeral.FieldByName('Qtde').AsInteger;
       if vUnidadesPorHora >= STrToIntDef(EdtMeta.Text, 0) then
          LstReport.Colors[18, xRecno] := clGreen
       Else if vUnidadesPorHora >= STrToIntDef(EdtTolerancia.Text, 0) then
          LstReport.Colors[18, xRecno] := clYellow
       Else
          LstReport.Colors[18, xRecno] := clRed;
       LstReport.FontStyles[18, xRecno] := [fsBold];
       LstReport.Cells[18, xRecno] := vUnidadesPorHora.ToString();
       if FdMemPesqGeral.FieldByName('CalcHora').AsInteger = 1 then
          LstReport.Cells[19, xRecno] := CalcUnidHr(FdMemPesqGeral.FieldByName('QtdCaixa').AsInteger, FdMemPesqGeral.FieldByName('HoraTrabalhada').AsString ).ToString()
       Else
          LstReport.Cells[19, xRecno] := FdMemPesqGeral.FieldByName('QtdCaixa').AsString;
       LstReport.FontStyles[19, xRecno] := [fsBold];
    End;
    xTotalQtde := xTotalQtde + FdMemPesqGeral.FieldByName('Qtde').AsInteger;
    LstReport.Alignments[ 0, xRecno] := taCenter;
    LstReport.FontStyles[ 0, xRecno] := [FsBold];
    LstReport.Alignments[ 1, xRecno] := taCenter;
    LstReport.Alignments[ 2, xRecno] := taCenter;
    LstReport.Alignments[ 3, xRecno] := taCenter;
    LstReport.Alignments[ 4, xRecno] := taRightJustify;
    LstReport.Alignments[ 7, xRecno] := taCenter;
    LstReport.Alignments[ 8, xRecno] := taRightJustify;
    LstReport.Alignments[ 9, xRecno] := taRightJustify;
    LstReport.Alignments[10, xRecno] := taRightJustify;
    LstReport.Alignments[11, xRecno] := taRightJustify;
    LstReport.Alignments[12, xRecno] := taCenter;
    LstReport.Alignments[13, xRecno] := taRightJustify;
    LstReport.Alignments[14, xRecno] := taRightJustify;
    LstReport.Alignments[17, xRecno] := taCenter;
    LstReport.Alignments[18, xRecno] := taRightJustify;
    LstReport.Alignments[19, xRecno] := taRightJustify;
    ConfigSizeLstReport(xRecno);
    vUsuarioId := FdMemPesqGeral.FieldByName('UsuarioId').AsInteger;
    vTotalQtdeUsuario := vTotalQtdeUsuario+FdMemPesqGeral.FieldByName('Qtde').AsInteger;
    vTotalCxaUsuario  := vTotalCxaUsuario+FdMemPesqGeral.FieldByName('QtdCaixa').AsInteger;
    vUsuarioAtual     := FdMemPesqGeral.FieldByName('Nome').AsString;
    FdMemPesqGeral.Next;
    Inc(xRecno);
    if (((vUsuarioId<>FdMemPesqGeral.FieldByName('UsuarioId').AsInteger) and (xTotalQtde<>0) or (FdMemPesqGeral.Eof)) and (ChkSintetico.Checked))  then Begin
       LstReport.Cells[ 9, xRecno] := vTotalQtdeUsuario.ToString;
       LstReport.Cells[10, xRecno] := vTotalCxaUsuario.ToString;
       LstReport.Cells[15, xRecno] := 'Total de: '+Copy(vUsuarioAtual, 1, Pos(' ', vUsuarioAtual)-1 );
       LstReport.Alignments[ 9, xRecno] := taRightJustify;
       LstReport.Alignments[10, xRecno] := taRightJustify;
       LstReport.FontStyles[ 9, xRecno] := [FsBold];
       LstReport.FontStyles[10, xRecno] := [FsBold];
       LstReport.FontStyles[15, xRecno] := [FsBold];
       LstReport.FontSizes[  9, xRecno] := 10;
       LstReport.FontSizes[ 10, xRecno] := 10;
       LstReport.FontSizes[ 15, xRecno] := 10;
       LstReport.FontColors[ 9, xRecno] := clNavy;
       LstReport.FontColors[10, xRecno] := clNavy;
       LstReport.FontColors[15, xRecno] := clNavy;
       LstReport.RowCount := LstReport.RowCount+1;
       vTotalQtdeUsuario := 0;
       vTotalCxaUsuario  := 0;
       Inc(xRecno);
    End;
  End;
  LblQtdeMovimentada.Caption := xTotalQtde.ToString();
end;

procedure TFrmRelControleArmazenagem.PesquisarDados;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    pDataInicial     : TDateTime;
    pDataFinal       : TDateTime;
    vErro : String;
begin
  inherited;
  if (StrToIntDef(EdtCodProduto.Text, 0)=0) and (EdtDocumentoNr.Text='') and
     (EdtDataInicial.Text='  /  /    ') and (EdtDataFinal.Text='  /  /    ') and
     (EdtEndereco.Text='') and (StrToIntDef(EdtUsuarioId.Text, 0) = 0) then Begin
     ShowErro('Informe os parâmetro para pesquisa.');
     EdtCodProduto.SetFocus;
     Exit;
  End;
  if EdtDataInicial.Text <>'  /  /    ' then
     pDataInicial := StrToDate(EdtDataInicial.Text)
  Else
     pDataInicial := 0;
  if EdtDataFinal.Text <>'  /  /    ' then
     pDataFinal := StrToDate(EdtDataFinal.Text)
  Else
     pDataFinal := 0;
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.EmptyDataSet;
     FdMemPesqGeral.ClearFields;
  End;
  FdMemPesqGeral.Close;
  TDialogMessage.ShowWaitMessage('Buscando Dados dos Volumes...',
  procedure
  Begin
    ObjEstoqueCtrl   := TEstoqueCtrl.Create;
    if ChkAnalitico.checked then
       JsonArrayRetorno := ObjEstoqueCtrl.GetControleArmazenagem(pDataInicial, pDataFinal,
                           vCodProduto, EdtDocumentoNr.Text, vEnderecoId, StrToIntDef(EdtUsuarioId.text, 0), 0)
    Else if ChkSintetico.checked then
       JsonArrayRetorno := ObjEstoqueCtrl.GetControleArmazenagem(pDataInicial, pDataFinal,
                           vCodProduto, EdtDocumentoNr.Text, vEnderecoId, StrToIntDef(EdtUsuarioId.text, 0), 1);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro(vErro);
       EdtCodProduto.SetFocus;
    End
    Else Begin
       FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
       MontaListaCA;
    End;
    JsonArrayRetorno := Nil;
    ObjEstoqueCtrl.Free;
  End);
end;

procedure TFrmRelControleArmazenagem.ShowFieldLstReport;
begin
  if ChkAnalitico.CheckEd then Begin
     LstReport.UnHideColumn(1);
     LstReport.HideColumn(2);
     LstReport.HideColumn(3);
     LstReport.UnHideColumn(4);
     LstReport.UnHideColumn(5);
     LstReport.UnHideColumn(6);
     LstReport.UnHideColumn(7);
     LstReport.UnHideColumn(8);
     LstReport.UnHideColumn(9);
     LstReport.UnHideColumn(10);
     LstReport.UnHideColumn(11);
     LstReport.UnHideColumn(12);
     LstReport.UnHideColumn(13);
     LstReport.UnHideColumn(14);
     LstReport.UnHideColumn(15);
     LstReport.UnHideColumn(16);
     LstReport.HideColumn(17);
     LstReport.HideColumn(18);
     LstReport.HideColumn(19);
  End
  Else if ChkSintetico.CheckEd then Begin
     LstReport.HideColumn(1);
     LstReport.unHideColumn(2);
     LstReport.unHideColumn(3);
     LstReport.HideColumn(4);
     LstReport.HideColumn(5);
     LstReport.HideColumn(6);
     LstReport.UnHideColumn(7);
     LstReport.HideColumn(8);
     LstReport.UnHideColumn(9);
     LstReport.UnHideColumn(10);
     LstReport.HideColumn(11);
     LstReport.HideColumn(12);
     LstReport.HideColumn(13);
     LstReport.HideColumn(14);
     LstReport.UnHideColumn(15);
     LstReport.HideColumn(16);
     LstReport.UnHideColumn(17);
     LstReport.UnHideColumn(18);
     LstReport.UnHideColumn(19);
  End;
end;

procedure TFrmRelControleArmazenagem.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  EdtMeta.Text       := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ArmazenagemMeta.ToString();
  EdtTolerancia.Text := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ArmazenagemTolerancia.ToString();
end;

End.
