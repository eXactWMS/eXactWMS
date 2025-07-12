unit uFrmRelApanhePicking;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, DataSet.Serialize,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar, Generics.Collections,
  System.Json, Rest.Types, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, JvToolEdit, dxCameraControl;

type
  TFrmRelApanhePicking = class(TFrmReportBase)
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FdMemPesqGeralApanhe: TIntegerField;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralMascara: TStringField;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    BtnPesqCliente: TBitBtn;
    FdMemPesqGeralDisponivel: TIntegerField;
    FdMemPesqGeralFatorConversao: TStringField;
    FdMemPesqGeralDescrLote: TStringField;
    ChkReposicao: TCheckBox;
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaListaApanhe;
    Procedure Limpar;
  public
    { Public declarations }
  end;

var
  FrmRelApanhePicking: TFrmRelApanhePicking;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl, uFuncoes, RotaCtrl, PessoaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas, Views.Pequisa.Processos;

procedure TFrmRelApanhePicking.BtnImprimirStandClick(Sender: TObject);
Var ObjPedidoCtrl    : TPedidoSaidaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
    vFiltro          : String;
begin
  vFiltro := 'Período: ';
  If EdtInicio.Text <> '  /  /    ' then
     vFiltro := vFiltro+EdtInicio.Text
  Else vFiltro := vFiltro+'... a ';
  If EdtTermino.Text <> '  /  /    ' then
     vFiltro := vFiltro+EdtTermino.Text
  Else vFiltro := vFiltro+'...';
  If EdtDestinatario.Text <> '' then
     vFiltro := vFiltro+'  Destinatário: '+EdtDestinatario.Text+' '+LblDestinatario.Caption;
  If EdtRotaId.Text <> '' then
     vFiltro := vFiltro+'  Rota: '+EdtRotaId.Text+' '+LblRota.Caption;
  frxReport1.Variables['vFiltro'] := QuotedStr(vFiltro);
  inherited;
end;

procedure TFrmRelApanhePicking.BtnPesqClienteClick(Sender: TObject);
begin
  inherited;
  if EdtDestinatario.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioExit(EdtDestinatario);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmRelApanhePicking.BtnPesqRotaClick(Sender: TObject);
begin
  inherited;
  if EdtRotaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       EdtRotaId.Text := FrmPesquisaRotas.Tag.ToString();
       EdtRotaIdExit(EdtRotaId);
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmRelApanhePicking.BtnPesquisarStandClick(Sender: TObject);
Var ObjPedidoCtrl      : TPedidoSaidaCtrl;
    JsonArrayRetorno   : TJsonArray;
    vErro              : String;
    pDataIni, pDataFin : TDateTime;
begin
  pDataIni := 0;
  pDataFin := 0;
  Try
    If EdtInicio.Text <> '  /  /    ' then
       pDataIni := StrToDate(EdtInicio.Text);
  Except
    raise Exception.Create('Data Inicial inválida!');
  End;
  Try
    If EdtTermino.Text <> '  /  /    ' then
       pDataFin := StrToDate(EdtTermino.Text);
  Except
    raise Exception.Create('Data Final inválida!');
  End;
//  if StrToIntDef(EdtPedidoId.Text, 0) < 0 then
//     raise Exception.Create('Id de Pedido inválido!');
//  if StrToIntDef(EdtCodProduto.Text, 0) < 0 then
//     raise Exception.Create('Código do produto inválido!');
  inherited;
  BtnImprimirStand.Grayed := True;
  ObjPedidoCtrl := TPedidoSaidaCtrl.Create();
  jsonArrayRetorno := ObjPedidoCtrl.GetRelApanhePicking(pDataIni, pDataFin, StrToIntDef(EdtDestinatario.Text, 0), StrToIntDef(EdtRotaId.Text, 0)); //, StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtCodProduto.Text, 0));
  if JsonArrayRetorno.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro(verro);
     JsonArrayRetorno := Nil;
     ObjPedidoCtrl.Free;
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
  BtnImprimirStand.Grayed := FdMemPesqGeral.IsEmpty;
  BtnExportarStand.Grayed := FdMemPesqGeral.IsEmpty;
  BtnImprimirStand.Enabled := True;
  BtnExportarStand.Enabled := True;
  if ChkReposicao.Checked then Begin
     FdMemPesqGeral.Filter   := 'Disponivel < QtdSuprida';
     FdMemPesqGeral.Filtered := True;
  End;
  If Not FdMemPesqGeral.IsEmpty then
     MontaListaApanhe
  Else ShowErro('Não foi encontrado dados na consulta.');
  JsonArrayRetorno := Nil;
  ObjPedidoCtrl.Free;
end;

procedure TFrmRelApanhePicking.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtDestinatario then LblDestinatario.Caption := ''
  else LblRota.Caption := '';
  Limpar;
end;

procedure TFrmRelApanhePicking.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtDestinatario.Text = '' then Begin
     LblDestinatario.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelApanhePicking.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelApanhePicking.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if EdtRotaId.Text = '' then Begin
     LblRota.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtRotaId.Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     Player('toast4');
     ShowErro( '😢Rota('+EdtRotaId.Text+') inválida!' );
     EdtRotaId.Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     Player('toast4');
     ShowErro( '😢Rota não('+EdtRotaId.Text+') encontrado!');
     EdtRotaId.Clear;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  ReturnLstRota := Nil;
  ObjRotaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelApanhePicking.FdMemPesqGeralCalcFields(DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByName('EnderecoFormatado').AsString := EnderecoMask(FdMemPesqGeral.FieldByName('Endereco').AsString, FdMemPesqGeral.FieldByName('Mascara').AsString, True);
end;

procedure TFrmRelApanhePicking.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelApanhePicking := Nil;
end;

procedure TFrmRelApanhePicking.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  :=  80;
  LstReport.ColWidths[1]  := 250;
  LstReport.ColWidths[2]  :=  70;
  LstReport.ColWidths[3]  := 100;
  LstReport.ColWidths[4]  := 120;
  LstReport.ColWidths[5]  :=  70;
  LstReport.ColWidths[6]  :=  70;
  LstReport.ColWidths[7]  :=  70;
  LstReport.ColWidths[8]  :=  70;
  LstReport.RowCount      := 1;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taRightJustify;
end;

procedure TFrmRelApanhePicking.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmRelApanhePicking := Nil;
end;

procedure TFrmRelApanhePicking.Limpar;
begin
  BtnExportarStand.Grayed := True;
  BtnImprimirStand.Grayed := True;
  FdMemPesqGeral.Close;
  LstReport.RowCount      := 1;
  FdMemPesqGeral.Filter   := '';
  FdmemPesqGeral.Filtered := False;
end;

procedure TFrmRelApanhePicking.MontaListaApanhe;
Var xApanhe : Integer;
begin
  LstReport.RowCount := FdMempesqGeral.RecordCount+1;
  If LstReport.RowCount > 1 Then LstReport.FixedRows := 1;
//  LblRegistro.Caption := FormatFloat('#0', FdMemPesqGeral.RecordCount);
  xApanhe := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xApanhe] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[1, xApanhe] := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[2, xApanhe] := FdMemPesqGeral.FieldByName('FatorConversao').AsString;
    LstReport.Cells[3, xApanhe] := FdMemPesqGeral.FieldByName('EnderecoFormatado').AsString;
    LstReport.Cells[4, xApanhe] := FdMemPesqGeral.FieldByName('DescrLote').AsString;
    LstReport.Cells[5, xApanhe] := FdMemPesqGeral.FieldByName('Demanda').AsString;
    LstReport.Cells[6, xApanhe] := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    LstReport.Cells[7, xApanhe] := FdMemPesqGeral.FieldByName('Disponivel').AsString;
    LstReport.Cells[8, xApanhe] := FdMemPesqGeral.FieldByName('Apanhe').AsString;
    LstReport.Alignments[0, xApanhe]  := taRightJustify;
    LstReport.FontStyles[0, xApanhe]  := [FsBold];
    LstReport.Alignments[5, xApanhe]  := taRightJustify;
    LstReport.Alignments[6, xApanhe]  := taRightJustify;
    LstReport.Alignments[7, xApanhe]  := taRightJustify;
    LstReport.Alignments[8, xApanhe]  := taRightJustify;
    Inc(xApanhe);
    FdMemPesqGeral.Next;
  End
end;

end.
