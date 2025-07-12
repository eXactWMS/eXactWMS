unit uFrmRelReposicaoDemanda;

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
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, JvToolEdit, DataSet.Serialize, System.JSON, REST.Json, Rest.Types,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmRelReposicaoDemanda = class(TFrmReportBase)
    FdMemPesqGeralProdutoid: TIntegerField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralFatorConversao: TIntegerField;
    FdMemPesqGeralEmbalagemPadrao: TIntegerField;
    FdMemPesqGeralQuantidade: TIntegerField;
    FdMemPesqGeralFracionado: TIntegerField;
    FdMemPesqGeralEstPicking: TIntegerField;
    FdMemPesqGeralQtdReposicao: TIntegerField;
    GroupBox1: TGroupBox;
    EdtDtDocumento: TJvDateEdit;
    FdMemPesqGeralReAbastecer: TIntegerField;
    FdMemPesqGeralEmbalagem: TStringField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FdMemPesqGeralDisponivel: TIntegerField;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    FdMemPesqGeralMascara: TStringField;
    procedure EdtDtDocumentoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  Protected
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelReposicaoDemanda: TFrmRelReposicaoDemanda;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl, Vcl.DialogMessage, uFuncoes;

procedure TFrmRelReposicaoDemanda.EdtDtDocumentoChange(Sender: TObject);
begin
  inherited;
  LimparLstAdvReport;
end;

procedure TFrmRelReposicaoDemanda.FdMemPesqGeralCalcFields(DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByName('EnderecoFormatado').asString :=
      EnderecoMask(FdMemPesqGeral.FieldByName('Endereco').asString,
                   FdMemPesqGeral.FieldByName('mascara').asString, True);
end;

procedure TFrmRelReposicaoDemanda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelReposicaoDemanda := Nil;
end;

procedure TFrmRelReposicaoDemanda.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 80;
  LstReport.ColWidths[1]  := 100;
  LstReport.ColWidths[2]  := 250;
  LstReport.ColWidths[3]  := 120;
  LstReport.ColWidths[4]  := 120;
  LstReport.ColWidths[5]  := 100;
  LstReport.ColWidths[6]  := 100;
  LstReport.ColWidths[7]  := 110;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taRightJustify;
  LstReport.RowCount := 1;
end;

procedure TFrmRelReposicaoDemanda.MontarLstAdvReport(pJsonArray : TJsonArray);
Var xRetorno : Integer;
begin
  inherited;
  LstReport.RowCount       := pJsonArray.Count+1;
  LstReport.FixedRows := 1;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(pJsonArray, False);
  for XRetorno := 0 to Pred(pJsonArray.Count) do Begin
    LstReport.Cells[0, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('idproduto').ToString;
    LstReport.Cells[1, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('codproduto').ToString();
    LstReport.Cells[2, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<String>('descricao');
    //LstReport.Cells[2, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('enderecoid').ToString();
    LstReport.Cells[3, xRetorno+1] :=  //pJsonArray.Items[xRetorno].GetValue<String>('endereco');
                                       EnderecoMask(pJsonArray.Items[xRetorno].GetValue<String>('endereco'),
                                                    pJsonArray.Items[xRetorno].GetValue<String>('mascara'), True);
    LstReport.Cells[4, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<String>('embalagem');
   // LstReport.Cells[5, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('embalagempadrao').ToString();
    LstReport.Cells[5, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('demanda').ToString();
    LstReport.Cells[6, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('disponivel').ToString();
    if pJsonArray.Items[xRetorno].GetValue<Integer>('disponivel') > (pJsonArray.Items[xRetorno].GetValue<Integer>('demanda')-pJsonArray.Items[xRetorno].GetValue<Integer>('saldopicking'))then
       LstReport.Cells[7, xRetorno+1] :=  (pJsonArray.Items[xRetorno].GetValue<Integer>('demanda')-pJsonArray.Items[xRetorno].GetValue<Integer>('saldopicking')).ToString()
    Else LstReport.Cells[7, xRetorno+1] :=  pJsonArray.Items[xRetorno].GetValue<Integer>('disponivel').ToString();
    LstReport.Alignments[0, xRetorno+1]  := taRightJustify;
    LstReport.FontStyles[0, xRetorno+1]  := [FsBold];
    LstReport.Alignments[1, xRetorno+1]  := taRightJustify;
    LstReport.Alignments[4, xRetorno+1]  := taRightJustify;
    LstReport.Alignments[5, xRetorno+1]  := taRightJustify;
    LstReport.Alignments[6, xRetorno+1]  := taRightJustify;
    LstReport.Alignments[7, xRetorno+1]  := taRightJustify;
{
     With FdMemPesqGeral do begin
       Append;
       FieldByName('EnderecoId').AsInteger  := LstEndereco[xRetorno].EnderecoId;
       FieldByName('EstruturaID').AsInteger := LstEndereco[xRetorno].EnderecoEstrutura.EstruturaId;
       FieldByName('Estrutura').AsString    := LstEndereco[xRetorno].EnderecoEstrutura.Descricao;
       FieldByName('RuaId').AsInteger       := LstEndereco[xRetorno].EnderecoRua.RuaId;
       FieldByName('Rua').AsString          := LstEndereco[xRetorno].EnderecoRua.Descricao;
       FieldByName('Lado').AsString         := LstEndereco[xRetorno].EnderecoRua.Lado;
       FieldByName('Ordem').AsInteger       := LstEndereco[xRetorno].EnderecoRua.Ordem;
       FieldByName('PickingFixo').AsInteger := LstEndereco[xRetorno].EnderecoEstrutura.PickingFixo;
       FieldByName('ZonaID').AsInteger      := LstEndereco[xRetorno].EnderecamentoZona.ZonaId;
       FieldByName('Zona').AsString         := LstEndereco[xRetorno].EnderecamentoZona.Descricao;
       FieldByName('Endereco').AsString     := EnderecoMask(LstEndereco[xRetorno].Descricao, LstEndereco[xRetorno].EnderecoEstrutura.Mascara, True);
       FieldByName('DesenhoArmazemID').AsInteger := LstEndereco[xRetorno].DesenhoArmazem.Id;
       FieldByName('Status').AsInteger      := LstEndereco[xRetorno].Status;
       FieldByName('Mascara').AsString      := LstEndereco[xRetorno].EnderecoEstrutura.Mascara;
     End;

} End;
  BtnImprimirStand.Enabled := True;
  BtnImprimirStand.Grayed  := False;
  BtnExportarStand.Enabled := True;
  BtnExportarStand.Grayed  := False;
end;

procedure TFrmRelReposicaoDemanda.PesquisarDados;
Var ArrayJsonReposicao : TJsonArray;
    ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    vErro              : String;
    xRetorno           : Integer;
begin
//  inherited;
{
   if (EdtDtDocumento.Text='  /  /    ') then Begin
      ShowErro('🙋🏼‍♀ Informe a data do Ressuprimento para cálculo.');
      EdtDtDocumento.clear;
      exit;
   End;
}
  TDialogMessage.ShowWaitMessage('Aguarde!!! Buscando dados para CheckIn...',
    procedure
    begin
      ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
      if (EdtDtDocumento.Text='  /  /    ') then
         ArrayJsonReposicao     := ObjPedidoSaidaCtrl.GetReposicaoGerar(Date(), 0, '', '')
      Else ArrayJsonReposicao     := ObjPedidoSaidaCtrl.GetReposicaoGerar(StrToDate(EdtDtDocumento.Text), 0, '', '');
                                                       //GetProdutoReposicao(StrToDate(EdtDtDocumento.Text), 0);
      if ArrayJsonReposicao.Items[0].tryGetValue<String>('Erro', vErro) then
         ShowErro(vErro)
      Else Begin
         MontarLstAdvReport(ArrayJsonReposicao);
      End;
      ArrayJsonReposicao := Nil;
      ObjPedidoSaidaCtrl.Free;
    End);
end;

end.
