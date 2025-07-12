unit uFrmRelPlanilhaCega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, JvToolEdit,
  Rest.Json, System.Json, Rest.Types, JvBaseEdits
  , EntradaCtrl, Vcl.Buttons, DataSet.Serialize, Vcl.DBGrids, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.ComCtrls, ACBrBase, ACBrETQ, dxCameraControl,
  PessoaCtrl;

type
  TFrmRelPlanilhaCega = class(TFrmReportBase)
    Label2: TLabel;
    EdtEntradaId: TJvCalcEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EdtDocumentoNr: TLabeledEdit;
    EdtDocumentoData: TJvDateEdit;
    Label13: TLabel;
    LblProcesso: TLabel;
    Label4: TLabel;
    CbOperacaoTipo: TComboBox;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralCodigoERP: TIntegerField;
    FdMemPesqGeralDescrProduto: TStringField;
    FdMemPesqGeralDescrLote: TStringField;
    FdMemPesqGeralQtdXml: TIntegerField;
    FdMemPesqGeralFabricacao: TStringField;
    FdMemPesqGeralVencimento: TStringField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralEmbalagemPrim: TStringField;
    FdMemPesqGeralQtdUnid: TIntegerField;
    FdMemPesqGeralEmbalagemSec: TStringField;
    FdMemPesqGeralAltura: TIntegerField;
    FdMemPesqGeralLargura: TIntegerField;
    FdMemPesqGeralComprimento: TIntegerField;
    FdMemPesqGeralVolume: TIntegerField;
    FdMemPesqGeralQtdSec: TIntegerField;
    FDMemEntrada: TFDMemTable;
    frxDBDataset2: TfrxDBDataset;
    FDMemEntradaEntradaId: TIntegerField;
    FDMemEntradaDocumentoNr: TStringField;
    FDMemEntradaDocumentoData: TDateField;
    FDMemEntradaPessoaid: TIntegerField;
    FDMemEntradaCodPessoa: TIntegerField;
    FDMemEntradaRazao: TStringField;
    FDMemEntradaRegistroERP: TStringField;
    EdtPessoaId: TLabeledEdit;
    LblFornecedor: TLabel;
    BtnPesqFornecedor: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtEntradaIdExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtEntradaIdChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure BtnPesqFornecedorClick(Sender: TObject);
    procedure EdtPessoaIdEndDock(Sender, Target: TObject; X, Y: Integer);
    procedure EdtPessoaIdExit(Sender: TObject);
  private
    { Private declarations }
    ObjEntradaCtrl : TEntradaCtrl;
    Procedure ShowDados;
    Procedure GetListaPlanilha(pJsonArrayPlanilha : TJsonArray);
  public
    { Public declarations }
  end;

var
  FrmRelPlanilhaCega: TFrmRelPlanilhaCega;

implementation

{$R *.dfm}

Uses Views.Pequisa.Pessoas;

procedure TFrmRelPlanilhaCega.BtnPesqFornecedorClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtPessoaId.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtPessoaId.Text := FrmPesquisaPessoas.Tag.ToString;
       ObjPessoaCtrl := TPessoaCtrl.Create;
       ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtPessoaId.text, 0), '', '', 2, 0);
       if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
          LblFornecedor.Caption := '';
          ShowErro( '😢Fornecedor('+EdtPessoaId.Text+') não encontrado!' );
          EdtPessoaId.Clear;
       end
       Else Begin
          LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
          EdtPessoaIdExit(EdtPessoaId);
       End;
       ReturnjsonArray := Nil;;
       ObjPessoaCtrl.Free;
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmRelPlanilhaCega.BtnPesquisarStandClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmRelPlanilhaCega.EdtEntradaIdChange(Sender: TObject);
begin
  inherited;
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
  Limpar;
end;

procedure TFrmRelPlanilhaCega.EdtEntradaIdExit(Sender: TObject);
begin
  if (EdtEntradaId.Text<>'') and (StrToIntDef(EdtEntradaId.Text, 0) <= 0) then Begin
     EdtEntradaId.SetFocus;
     ShowErro('Id('+EdtEntradaId.Text+') da Entrada Inválido!');
     EdtEntradaId.Clear;
     Exit;
  End;
  inherited;
  if EdtEntradaId.Text = '' then Begin
     BtnImprimirStand.Enabled := False;
     Exit;
  End;
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := True;
  ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtEntradaId.Text, 0);
  ObjEntradaCtrl := ObjEntradaCtrl.GetEntrada(StrToIntDef(EdtEntradaId.Text, 0), 0, '', '', '', 0, 1)[0];
  ShowDados;
end;

procedure TFrmRelPlanilhaCega.EdtPessoaIdEndDock(Sender, Target: TObject; X,
  Y: Integer);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  LblFornecedor.Caption := '';
  if EdtPessoaId.Text = '' then Exit;
  if StrToIntDef(EdtPessoaId.Text, 0) <= 0 then Begin
     ShowErro( '😢Código('+EdtPessoaId.Text+' de Fornecedor inválido' );
     EdtPessoaId.Clear;
     EdtPessoaId.SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtPessoaId.text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblFornecedor.Caption := '';
     ShowErro( '😢Fornecedor('+EdtPessoaId.Text+') não encontrado!' );
     EdtPessoaId.Clear;
     EdtPessoaId.SetFocus;
  end
  Else
     LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelPlanilhaCega.EdtPessoaIdExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
     ShowErro( '😢Fornecedor('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(TEdit(Sender).text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
   ShowErro( '😢Fornecedor('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia')
  End;
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelPlanilhaCega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelPlanilhaCega := Nil;
end;

procedure TFrmRelPlanilhaCega.FormCreate(Sender: TObject);
begin
  inherited;
  TabListagem.TabVisible   := False;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
  LstReport.ColWidths[0] := 70;
  LstReport.ColWidths[1] := 70;
  LstReport.ColWidths[2] := 200;
  LstReport.ColWidths[3] := 120;
  LstReport.ColWidths[4] := 100;
  LstReport.ColWidths[5] := 100;
  LstReport.ColWidths[6] := 60;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.Alignments[1, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taRightJustify;
end;

procedure TFrmRelPlanilhaCega.FormDestroy(Sender: TObject);
begin
  inherited;
  ObjEntradaCtrl :=  Nil;
end;

procedure TFrmRelPlanilhaCega.FormShow(Sender: TObject);
begin
  inherited;
  EdtEntradaId.SetFocus;
end;

procedure TFrmRelPlanilhaCega.GetListaPlanilha(pJsonArrayPlanilha : TJsonArray);
Var xItem : Integer;
begin
  LstReport.RowCount := pJSonArrayPlanilha.Count+1;
  For xItem := 0 to Pred(pJSonArrayPlanilha.Count) do Begin
    LstReport.Cells[0, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<Integer>('produtoid').ToString;
    LstReport.Cells[1, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<Integer>('codigoerp').ToString;
    LstReport.Cells[2, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<String>('descrproduto');
    LstReport.Cells[3, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<String>('descrlote');
    LstReport.Cells[4, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<String>('fabricacao');
    LstReport.Cells[5, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<String>('vencimento');
    LstReport.Cells[6, xItem+1] := pJsonArrayPlanilha.Items[xItem].GetValue<Integer>('qtdxml').ToString;
    LstReport.Alignments[0, xItem+1] := taRightJustify;
    LstReport.Alignments[1, xItem+1] := taRightJustify;
    LstReport.Alignments[6, xItem+1] := taRightJustify;
  End;
  FdMemPesqGeral.LoadFromJSON(pJSonArrayPlanilha, False);
end;

procedure TFrmRelPlanilhaCega.ShowDados;
Var JsonArrayPlanilha : TJsonArray;
    vErro : String;
begin
  With ObjEntradaCtrl.Entrada do Begin
    EdtEntradaId.Text        := EntradaId.ToString();
    CbOperacaoTipo.ItemIndex := CbOperacaoTipo.Items.IndexOf(OperacaoTipo.Descricao);
    EdtDocumentoNr.Text      := DocumentoNr;
    EdtDocumentoData.Text    := DateToStr(DocumentoData);
    EdtPessoaId.Text         := Pessoa.PessoaId.ToString();
    LblFornecedor.Caption    := Pessoa.Razao;
    LblProcesso.Caption      := Processo;
    if not (FdMemEntrada.Active) then
        FdMemEntrada.Open;
     FdMemEntrada.EmptyDataSet;
     FdMemEntrada.Append;
     FdMemEntrada.FieldByName('EntradaId').AsInteger := EntradaId;
     FdMemEntrada.FieldByName('DocumentoNr').AsString := DocumentoNr;
     FdMemEntrada.FieldByName('DocumentoData').AsDateTime := DocumentoData;
     FdMemEntrada.FieldByName('PessoaId').AsInteger       := Pessoa.PessoaId;
     FdMemEntrada.FieldByName('CodPessoa').AsInteger      := Pessoa.CodPessoa;
     FdMemEntrada.FieldByName('Razao').AsString           := Pessoa.Razao;
     FdMemEntrada.FieldByName('RegistroERP').AsString     := RegistroERP;
    //FdMemEntrada.LoadFromJSON(ObjEntradaCtrl.Entrada.ClassToJson(ObjEntradaCtrl.Entrada), False);
  End;
  JsonArrayPlanilha := ObjEntradaCtrl.GetPlanilhaCega(ObjEntradaCtrl.Entrada.EntradaId);
  if JsonArrayPlanilha.Items[0].TryGetValue('Erro', vErro) then
     ShowErro(vErro)
  Else Begin
    BtnImprimirStand.Grayed  := False;
    BtnImprimirStand.Enabled := True;
    GetListaPlanilha(JsonArrayPlanilha);
  End;
end;

end.
