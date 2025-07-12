unit uFrmRelReposicaoColeta;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, Generics.Collections, System.Json, Rest.Types
  , frxRich, frxCross, frxOLE, frxBarcode, frxChBox, frxGradient,
  dxCameraControl, ProcessoCtrl, JvToolEdit, Views.Pequisa.Processos,
  UsuarioCtrl, ProdutoCtrl;

type
  TFrmRelReposicaoColeta = class(TFrmReportBase)
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblReposicao: TLabel;
    EdtReposicaoId: TEdit;
    BtnPesqRota: TBitBtn;
    FdMemPesqGeralReposicaoId: TIntegerField;
    FdMemPesqGeralDtRessuprimento: TDateField;
    FdMemPesqGeralReposicaoTipo: TIntegerField;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralZonaId: TIntegerField;
    FdMemPesqGeralZona: TStringField;
    FdMemPesqGeralEnderecoInicial: TStringField;
    FdMemPesqGeralEnderecoFinal: TStringField;
    FdMemPesqGeralUsuarioId: TIntegerField;
    FdMemPesqGeralTerminal: TStringField;
    FdMemPesqGeralDtReposicao: TDateField;
    FdMemPesqGeralHrReposicao: TStringField;
    FdMemPesqGeralUuid: TStringField;
    FdMemPesqGeralUsuarioReposicao: TStringField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemReposicaoColeta: TFDMemTable;
    IntegerField1: TIntegerField;
    frxDBReposicaoColeta: TfrxDBDataset;
    FdMemReposicaoColetaProdutoId: TIntegerField;
    FdMemReposicaoColetaCodProduto: TIntegerField;
    FdMemReposicaoColetaDescricao: TStringField;
    FdMemReposicaoColetaFatorConversao: TIntegerField;
    FdMemReposicaoColetaEmbalagem: TStringField;
    FdMemReposicaoColetaPickingId: TIntegerField;
    FdMemReposicaoColetaPicking: TStringField;
    FdMemReposicaoColetaMascaraPicking: TStringField;
    FdMemReposicaoColetaEnderecoId: TIntegerField;
    FdMemReposicaoColetaEndereco: TStringField;
    FdMemReposicaoColetaMascara: TStringField;
    FdMemReposicaoColetaZonaId: TIntegerField;
    FdMemReposicaoColetaZona: TStringField;
    FdMemReposicaoColetaLoteId: TIntegerField;
    FdMemReposicaoColetaDescrLote: TStringField;
    FdMemReposicaoColetaVencimento: TDateField;
    FdMemReposicaoColetaDemanda: TIntegerField;
    FdMemReposicaoColetaEstoqueTipoId: TIntegerField;
    FdMemReposicaoColetaReposicao: TIntegerField;
    FdMemReposicaoColetaUsuarioId: TIntegerField;
    FdMemReposicaoColetaNome: TStringField;
    FdMemReposicaoColetaTerminal: TStringField;
    FdMemReposicaoColetaDtColeta: TDateField;
    FdMemReposicaoColetaHrColeta: TStringField;
    DsReposicaoColeta: TDataSource;
    GbPeriodo: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GbProcesso: TGroupBox;
    Label4: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    ChkPendentes: TCheckBox;
    RgTipoRelatorio: TRadioGroup;
    RadioGroup1: TRadioGroup;
    LblTipoRelatorioResumo: TLabel;
    CbTipoRelatorio: TComboBox;
    Gbusuario: TGroupBox;
    Label5: TLabel;
    LblUsuario: TLabel;
    EdtUsuarioId: TEdit;
    BtnPesqUsuario: TBitBtn;
    FDMemAnaliseColetaAnalitico: TFDMemTable;
    FDMemAnaliseColetaSintetico: TFDMemTable;
    FDMemRelTransPickingAnalitico: TFDMemTable;
    FDMemRelTransPickingSintetico: TFDMemTable;
    LblDivergencia: TLabel;
    CbDivergencia: TComboBox;
    FDMemHistoricoTransferenciaAnalitico: TFDMemTable;
    FDMemHistoricoTransferenciaSintetico: TFDMemTable;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProd: TBitBtn;
    FdMemReposicaoColetaDisponivel: TIntegerField;
    GroupBox3: TGroupBox;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    LblZona: TLabel;
    bvProdutividade: TBevel;
    LblTitleProdutividade: TLabel;
    LblMetaProdutividade: TLabel;
    EdtMeta: TEdit;
    LblToleranciaProdutividade: TLabel;
    EdtTolerancia: TEdit;
    FDMemReposicaoColetaProdutividade: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure EdtReposicaoIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtReposicaoIdChange(Sender: TObject);
    procedure EdtProcessoIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtReposicaoIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure RgTipoRelatorioClick(Sender: TObject);
    procedure CbTipoRelatorioClick(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesqProdClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure EdtZonaIdEnter(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnPesqZonaExit(Sender: TObject);
    procedure BtnPesqUsuarioClick(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure EdtCodProdutoChange(Sender: TObject);
    procedure EdtReposicaoIdExit(Sender: TObject);
  private
    { Private declarations }
    vSelLst : Integer;
    vCodproduto : Integer;
    procedure MontaListaReposicao;
    Procedure MontaAnaliseColetaAnalitico;
    Procedure MontaAnaliseColetaSintetico;
    Procedure MontaTransfPickingAnalitico;
    Procedure MontaTransfPickingSintetico;
    Procedure MontaHistoricoTransferenciaAnalitico;
    Procedure MontaHistoricoTransferenciaSintetico;
    Procedure PreencherResumoColeta(pJsonArrayRetorno : TJsonArray);
    Procedure PreencherAnaliseColeta(pJsonArrayRetorno : TJsonArray);
    Procedure PreencherTransfPicking(pJsonArrayRetorno : TJsonArray);
    Procedure PreencherHistoricoTransferencia(pJsonArrayRetorno : TJsonArray);
    Procedure PreencherReposicaoColetaProdutividade(pJsonArrayRetorno : TJsonArray);
    procedure HeaderLstReport;
    Procedure EnableProdutividade(pEnabled : Boolean);
  Protected
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelReposicaoColeta: TFrmRelReposicaoColeta;

implementation

{$R *.dfm}

Uses uFrmeXactWMS, PedidoSaidaCtrl, Views.Pequisa.Produtos, uFuncoes, Vcl.DialogMessage,
  EnderecamentoZonaCtrl, Views.Pequisa.EnderecamentoZonas, Views.Pequisa.Usuarios;

procedure TFrmRelReposicaoColeta.BtnPesqUsuarioClick(Sender: TObject);
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

procedure TFrmRelReposicaoColeta.BtnExportarStandClick(Sender: TObject);
begin
  if RgTipoRelatorio.ItemIndex = 0 then
     inherited
  Else if RgTipoRelatorio.ItemIndex in [1, 2] then Begin
     if CbTipoRelatorio.ItemIndex = 0 then Begin//Analitico
        if (Not FDMemAnaliseColetaAnalitico.Active) or (FDMemAnaliseColetaAnalitico.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemAnaliseColetaAnalitico);
        Except
          raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
        End;
     End
     Else Begin
        if (Not FDMemAnaliseColetaSintetico.Active) or (FDMemAnaliseColetaSintetico.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemAnaliseColetaSintetico);
        Except
          raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
        End;
     End;
  End
  Else if RgTipoRelatorio.ItemIndex = 3 then Begin
     if CbTipoRelatorio.ItemIndex = 0 then Begin//Analitico
        if (Not FDMemRelTransPickingAnalitico.Active) or (FDMemRelTransPickingAnalitico.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemRelTransPickingAnalitico);
        Except
          raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
        End;
     End
     Else Begin
        if (Not FDMemRelTransPickingSintetico.Active) or (FDMemRelTransPickingSintetico.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemRelTransPickingSintetico);
        Except
          raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
        End;
     End;
  End
  Else if RgTipoRelatorio.ItemIndex = 4 then Begin
     if CbTipoRelatorio.ItemIndex = 0 then Begin//Analitico
        if (Not FDMemHistoricoTransferenciaAnalitico.Active) or (FDMemHistoricoTransferenciaAnalitico.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemHistoricoTransferenciaAnalitico);
        Except
          raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
        End;
     End
     Else Begin
        if (Not FDMemHistoricoTransferenciaSintetico.Active) or (FDMemHistoricoTransferenciaSintetico.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemHistoricoTransferenciaSintetico);
        Except
          raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
        End;
     End;
  End;
end;

procedure TFrmRelReposicaoColeta.BtnImprimirStandClick(Sender: TObject);
Var xLst : Integer;
    pNotificationPrint : Boolean;
begin
  if Sender = LstReport then
     inherited
  Else Begin
    if RgTipoRelatorio.ItemIndex = 1 then Begin

    End
    Else if RgTipoRelatorio.ItemIndex = 0 then Begin
       pNotificationPrint := True;
       for xLst := 1 to Pred(LstReport.RowCount) do Begin
         if LstReport.Cells[10, xLst] = '1' then Begin
            If pNotificationPrint then Begin
               Confirmacao('Ordem de Reposição', 'Prepare a impressora.', False);
               pNotificationPrint := False;
            End;
//            frxPDFExport1.ShowDialog := False;
//            frxReport1.PrepareReport();
//            frxReport1.PrintOptions.ShowDialog := False;
//            FrxReport1.Print;

            FdMemPesqGeral.Filter   := 'ReposicaoId = '+LstReport.Cells[0, xLst];
            FdmemPesqGeral.Filtered := True;
            frxPDFExport1.ShowDialog := False;
            frxReport1.PrepareReport();
            frxReport1.PrintOptions.ShowDialog := False;
            FrxReport1.Print;
            FdMemPesqGeral.Filter   := '';
            FdmemPesqGeral.Filtered := False;
         End;
       End;
    End;
  End;
end;

procedure TFrmRelReposicaoColeta.BtnPesqProcessoClick(Sender: TObject);
begin
  inherited;
  if EdtProcessoId.ReadOnly then Exit;
  inherited;
  FrmPesquisaProcessos := TFrmPesquisaProcessos.Create(Application);
  try
    if (FrmPesquisaProcessos.ShowModal = mrOk) then Begin
       EdtProcessoId.Text := FrmPesquisaProcessos.Tag.ToString;
       EdtProcessoIdExit(EdtProcessoId);
    End;
  finally
    FreeAndNil(FrmPesquisaProcessos);
  end;
end;

procedure TFrmRelReposicaoColeta.BtnPesqProdClick(Sender: TObject);
begin
  inherited;
  if EdtCodProduto.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelReposicaoColeta.BtnPesqZonaClick(Sender: TObject);
begin
  inherited;
  if EdtZonaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelReposicaoColeta.BtnPesqZonaExit(Sender: TObject);
begin
  inherited;
  if EdtZonaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelReposicaoColeta.CbTipoRelatorioClick(Sender: TObject);
begin
  inherited;
  HeaderLstReport;
end;

procedure TFrmRelReposicaoColeta.EdtCodProdutoChange(Sender: TObject);
begin
  inherited;
  LblProduto.Caption     := '';
  vCodProduto            := 0;
  LblTotRegistro.Caption := '0';
  LimparLstAdvReport;
end;

procedure TFrmRelReposicaoColeta.EdtCodProdutoExit(Sender: TObject);
Var JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.Setfocus;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vCodProduto  := JsonProduto.GetValue<Integer>('codproduto');
  if JsonProduto.GetValue<Integer>('produtoid') <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     EdtCodProduto.Setfocus;
     Exit;
  End;
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
end;

procedure TFrmRelReposicaoColeta.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  if EdtProcessoId.Text = '' then Begin
     LblProcesso.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtProcessoId.Text, 0) <= 0 then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo('+EdtProcessoId.Text+') inválido!' );
     EdtProcessoId.Clear;
     Exit;
  end;
  ObjProcessoCtrl  := TProcessoCtrl.Create;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(EdtProcessoId.text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo não('+EdtProcessoId.Text+') encontrado!');
     EdtProcessoId.Clear;
  end
  Else
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  JsonArrayRetorno := Nil;
  ObjProcessoCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelReposicaoColeta.EdtProcessoIdKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  LblProduto.Caption := '';
end;

procedure TFrmRelReposicaoColeta.EdtReposicaoIdChange(Sender: TObject);
begin
  inherited;
  LblTotRegistro.Caption := '0';
  LimparLstAdvReport;
  if Sender = EdtProcessoId then
     LblProcesso.Caption := '...';
  if Sender = EdtReposicaoId then
     LblReposicao.Caption := '...';
end;

procedure TFrmRelReposicaoColeta.EdtReposicaoIdExit(Sender: TObject);
begin
  inherited;
  if (EdtReposicaoId.Text<>'') and (StrToIntDef(EdtReposicaoId.Text,0)<=0) then Begin
     EdtReposicaoId.SetFocus;
     ShowErro('Id('+EdtReposicaoId.text+') da Reposição inválido!');
     EdtReposicaoId.Clear;
     Exit;
  End;
end;

procedure TFrmRelReposicaoColeta.EdtReposicaoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
//  if (Key = #13) AND (StrToIntDef(EdtReposicaoId.Text, 0)>0) then
//     BtnPesquisarStandClick(BtnPesquisarStand);
end;

procedure TFrmRelReposicaoColeta.EdtReposicaoIdKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  LblReposicao.Caption := '';
end;

procedure TFrmRelReposicaoColeta.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  LblUsuario.Caption     := '';
  LblTotRegistro.Caption := '0';
  LimparLstAdvReport;
end;

procedure TFrmRelReposicaoColeta.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  if StrToIntDef(EdtUsuarioId.Text, 0) = 0 then Exit;
  ObjUsuarioCtrl := TUsuarioCtrl.Create;
  JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro'+vErro);
  End
  Else
     LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
  JsonArrayRetorno := Nil;
  ObjUsuarioCtrl.Free;
end;

procedure TFrmRelReposicaoColeta.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '...';
end;

procedure TFrmRelReposicaoColeta.EdtZonaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRelReposicaoColeta.EdtZonaIdExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl   : TEnderecamentoZonaCtrl;
    ZonaJsonArray : TJSONArray;
    vErro         : String;
begin
  inherited;
  if EdtZonaId.Text = '' then Begin
     LblZona.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Begin
     LblZona.Caption := '';
     ShowErro( '😢Zona/Setor('+EdtZonaId.Text+') inválida!' );
     EdtZonaId.Clear;
     EdtZonaId.SetFocus;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl   := TEnderecamentoZonaCtrl.Create;
  ZonaJsonArray := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(EdtZonaId.text, 0), '', 0);
  if ZonaJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin // (ReturnLstRota.Count <= 0) then Begin
     LblZona.Caption := '';
     ShowErro(vErro, 'toast4');
     EdtZonaId.Clear;
     EdtZonaId.SetFocus;
  end
  Else
     LblZona.Caption := ZonaJsonArray.Items[0].GetValue<String>('descricao');
  ZonaJsonArray := Nil;
  ObjEnderecamentoZonaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelReposicaoColeta.EnableProdutividade(pEnabled: Boolean);
begin
  bvProdutividade.Visible            := pEnabled;
  LblTitleProdutividade.Visible      := pEnabled;
  LblMetaProdutividade.Visible       := pEnabled;
  EdtMeta.Visible                    := pEnabled;
  LblToleranciaProdutividade.Visible := pEnabled;
  EdtTolerancia.Visible              := pEnabled;
end;

procedure TFrmRelReposicaoColeta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelReposicaoColeta := Nil;
end;

procedure TFrmRelReposicaoColeta.FormCreate(Sender: TObject);
begin
  inherited;
  LblDivergencia.Visible := False;
  CbDivergencia.Visible  := False;
  EdtMeta.Text       := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaMeta.ToString();
  EdtTolerancia.Text := FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReposicaoColetaTolerancia.ToString();
  EnableProdutividade(False);
end;

procedure TFrmRelReposicaoColeta.HeaderLstReport;
begin
  LimparLstAdvReport;
  LblTotRegistro.Caption := '0';
  if RgTipoRelatorio.ItemIndex = 0 then Begin
     LstReport.ColCount := 12;
     LstReport.Cells[0, 0]  := 'Id';
     LstReport.Cells[1, 0]  := 'Dt.Ressuprimento';
     LstReport.Cells[2, 0]  := 'Tipo';
     LstReport.Cells[3, 0]  := 'Tipo';
     LstReport.Cells[4, 0]  := 'End.Inicial';
     LstReport.Cells[5, 0]  := 'End.Final';
     LstReport.Cells[6, 0]  := 'Usuário';
     LstReport.Cells[7, 0]  := 'Terminal';
     LstReport.Cells[8, 0]  := 'Dt.Reposição';
     LstReport.Cells[9, 0]  := 'Processo';
     LstReport.Cells[10, 0] := 'Selecione';
     LstReport.Cells[11, 0] := 'Ação';
     LstReport.ColWidths[ 0] :=  70+Trunc(70*ResponsivoVideo);
     LstReport.ColWidths[ 1] := 110+Trunc(110*ResponsivoVideo);
     LstReport.ColWidths[ 2] := 110+Trunc(110*ResponsivoVideo);
     LstReport.ColWidths[ 3] := 120+Trunc(120*ResponsivoVideo);
     LstReport.ColWidths[ 4] := 100+Trunc(100*ResponsivoVideo);
     LstReport.ColWidths[ 5] := 100+Trunc(100*ResponsivoVideo);
     LstReport.ColWidths[ 6] := 120+Trunc(120*ResponsivoVideo);
     LstReport.ColWidths[ 7] := 100+Trunc(100*ResponsivoVideo);
     LstReport.ColWidths[ 8] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[ 9] := 120+Trunc(120*ResponsivoVideo);
     LstReport.ColWidths[10] :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[11] :=  35+Trunc(35*ResponsivoVideo);
     LstReport.Alignments[ 0, 0] := taRightJustify;
     LstReport.FontStyles[ 0, 0] := [FsBold];
     LstReport.Alignments[ 1, 0] := taCenter;
     LstReport.Alignments[ 2, 0] := taLeftJustify;
     LstReport.Alignments[ 3, 0] := taLeftJustify;
     LstReport.Alignments[ 4, 0] := taCenter;
     LstReport.Alignments[ 5, 0] := taCenter;
     LstReport.Alignments[ 6, 0] := taLeftJustify;
     LstReport.Alignments[ 7, 0] := taLeftJustify;
     LstReport.Alignments[ 8, 0] := taLeftJustify;
     LstReport.Alignments[ 9, 0] := taLeftJustify;
     LstReport.Alignments[10, 0] := taCenter;
     LstReport.Alignments[11, 0] := taCenter;
  End
  Else if RgTipoRelatorio.ItemIndex in [1, 2] then Begin
     if CbTipoRelatorio.ItemIndex = 0 then Begin
        LstReport.ColCount := 14;
        LstReport.Cells[0, 0] := 'Id';
        LstReport.Cells[1, 0] := 'Cod.Prod.';
        LstReport.Cells[2, 0] := 'Descrição';
        LstReport.Cells[3, 0] := 'Picking';
        LstReport.Cells[4, 0] := 'Pallet';
        LstReport.Cells[5, 0] := 'Lote';
        LstReport.Cells[6, 0] := 'Fabricação';
        LstReport.Cells[7, 0] := 'Vencimento';
        LstReport.Cells[8, 0] := 'Demanda';
        LstReport.Cells[9, 0] := 'Coleta';
        LstReport.Cells[10,0] := 'Transferido';
        LstReport.Cells[11,0] := 'Pendente';
        LstReport.Cells[12,0] := 'Usuário Id';
        LstReport.Cells[13,0] := 'Nome';
        LstReport.ColWidths[ 0] :=  90+Trunc(90*ResponsivoVideo);
        LstReport.ColWidths[ 1] :=  80+Trunc(80*ResponsivoVideo);
        LstReport.ColWidths[ 2] := 250+Trunc(250*ResponsivoVideo);
        LstReport.ColWidths[ 3] :=  90+Trunc(90*ResponsivoVideo);
        LstReport.ColWidths[ 4] :=  90+Trunc(90*ResponsivoVideo);
        LstReport.ColWidths[ 5] := 120+Trunc(120*ResponsivoVideo);
        LstReport.ColWidths[ 6] :=  80+Trunc(80*ResponsivoVideo);
        LstReport.ColWidths[ 7] :=  80+Trunc(80*ResponsivoVideo);
        LstReport.ColWidths[ 8] :=  60+Trunc(60*ResponsivoVideo);
        LstReport.ColWidths[ 9] :=  60+Trunc(60*ResponsivoVideo);
        LstReport.ColWidths[10] :=  75+Trunc(75*ResponsivoVideo);
        LstReport.ColWidths[11] :=  60+Trunc(60*ResponsivoVideo);
        LstReport.ColWidths[12] :=  70+Trunc(70*ResponsivoVideo);
        LstReport.ColWidths[13] := 150+Trunc(150*ResponsivoVideo);
        LstReport.Alignments[ 0, 0] := taRightJustify;
        LstReport.FontStyles[ 0, 0] := [FsBold];
        LstReport.Alignments[ 1, 0] := taLeftJustify;
        LstReport.Alignments[ 2, 0] := taLeftJustify;
        LstReport.Alignments[ 3, 0] := taCenter;
        LstReport.Alignments[ 4, 0] := taCenter;
        LstReport.Alignments[ 5, 0] := taLeftJustify;
        LstReport.Alignments[ 6, 0] := taCenter;
        LstReport.Alignments[ 7, 0] := taCenter;
        LstReport.Alignments[ 8, 0] := taRightJustify;
        LstReport.Alignments[ 9, 0] := taRightJustify;
        LstReport.Alignments[10, 0] := taRightJustify;
        LstReport.Alignments[11, 0] := taRightJustify;
        LstReport.Alignments[12, 0] := taRightJustify;
        LstReport.Alignments[13, 0] := taLeftJustify;
     End
     Else Begin
        LstReport.ColCount := 9;
        LstReport.Cells[0, 0] := 'Cod.Prod.';
        LstReport.Cells[1, 0] := 'Descrição';
        LstReport.Cells[2, 0] := 'Picking';
        LstReport.Cells[3, 0] := 'Demanda';
        LstReport.Cells[4, 0] := 'Coleta';
        LstReport.Cells[5, 0] := 'Transferido';
        LstReport.Cells[6, 0] := 'Pendência';
        LstReport.Cells[7, 0] := 'Usuario Id';
        LstReport.Cells[8, 0] := 'Nome';
        LstReport.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
        LstReport.ColWidths[1] := 300+Trunc(300*ResponsivoVideo);
        LstReport.ColWidths[2] :=  90+Trunc(90*ResponsivoVideo);
        LstReport.ColWidths[3] :=  70+Trunc(70*ResponsivoVideo);
        LstReport.ColWidths[4] :=  70+Trunc(70*ResponsivoVideo);
        LstReport.ColWidths[5] :=  80+Trunc(80*ResponsivoVideo);
        LstReport.ColWidths[6] :=  70+Trunc(70*ResponsivoVideo);
        LstReport.ColWidths[7] :=  65+Trunc(65*ResponsivoVideo);
        LstReport.ColWidths[8] := 200+Trunc(200*ResponsivoVideo);
        LstReport.Alignments[0, 0] := taRightJustify;
        LstReport.FontStyles[0, 0] := [FsBold];
        LstReport.Alignments[1, 0] := taLeftJustify;
        LstReport.Alignments[2, 0] := taCenter;
        LstReport.Alignments[3, 0] := taRightJustify;
        LstReport.Alignments[4, 0] := taRightJustify;
        LstReport.Alignments[5, 0] := taRightJustify;
        LstReport.Alignments[6, 0] := taRightJustify;
        LstReport.Alignments[7, 0] := taRightJustify;
        LstReport.Alignments[8, 0] := taLeftJustify;
     End;
  End
  Else if RgTipoRelatorio.ItemIndex = 3 then Begin
    if CbTipoRelatorio.ItemIndex = 1 then Begin
       LstReport.ColCount := 7;
       LstReport.Cells[0, 0] := 'Cod.Prod.';
       LstReport.Cells[1, 0] := 'Descrição';
       LstReport.Cells[2, 0] := 'Picking';
       LstReport.Cells[3, 0] := 'Coleta';
       LstReport.Cells[4, 0] := 'Transferência';
       LstReport.Cells[5, 0] := 'Pendência';
       LstReport.Cells[6, 0] := 'Concluído';
       LstReport.ColWidths[ 0] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 1] := 200+Trunc(200*ResponsivoVideo);
       LstReport.ColWidths[ 2] := 100+Trunc(100*ResponsivoVideo);
       LstReport.ColWidths[ 3] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 4] := 120+Trunc(120*ResponsivoVideo);
       LstReport.ColWidths[ 5] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 6] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.Alignments[ 0, 0] := taRightJustify;
       LstReport.FontStyles[ 0, 0] := [FsBold];
       LstReport.Alignments[ 1, 0] := taLeftJustify;
       LstReport.Alignments[ 2, 0] := taCenter;
       LstReport.Alignments[ 3, 0] := taRightJustify;
       LstReport.Alignments[ 4, 0] := taRightJustify;
       LstReport.Alignments[ 5, 0] := taRightJustify;
       LstReport.Alignments[ 6, 0] := taRightJustify;
    End
    Else Begin
       LstReport.ColCount := 12;
       LstReport.Cells[0, 0]  := 'Id';
       LstReport.Cells[1, 0]  := 'Cód.Prod.';
       LstReport.Cells[2, 0]  := 'Descrição';
       LstReport.Cells[3, 0]  := 'Picking';
       LstReport.Cells[4, 0]  := 'Pallet';
       LstReport.Cells[5, 0]  := 'Lote';
       LstReport.Cells[6, 0]  := 'Fabricação';
       LstReport.Cells[7, 0]  := 'Vencimento';
       LstReport.Cells[8, 0]  := 'Coleta';
       LstReport.Cells[9, 0]  := 'Transferência';
       LstReport.Cells[10, 0] := 'Pendente';
       LstReport.Cells[11, 0] := 'Concluído';
       LstReport.ColWidths[ 0] :=  70+Trunc(70*ResponsivoVideo);
       LstReport.ColWidths[ 1] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 2] := 200+Trunc(200*ResponsivoVideo);
       LstReport.ColWidths[ 3] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 4] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 5] := 110+Trunc(110*ResponsivoVideo);
       LstReport.ColWidths[ 6] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 7] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 8] :=  70+Trunc(70*ResponsivoVideo);
       LstReport.ColWidths[ 9] :=  90+Trunc(90*ResponsivoVideo);
       LstReport.ColWidths[10] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[11] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.Alignments[ 0, 0] := taRightJustify;
       LstReport.FontStyles[ 0, 0] := [FsBold];
       LstReport.Alignments[ 2, 0] := taLeftJustify;
       LstReport.Alignments[ 3, 0] := taLeftJustify;
       LstReport.Alignments[ 4, 0] := taLeftJustify;
       LstReport.Alignments[ 5, 0] := taLeftJustify;
       LstReport.Alignments[ 6, 0] := taCenter;
       LstReport.Alignments[ 7, 0] := taCenter;
       LstReport.Alignments[ 8, 0] := taRightJustify;
       LstReport.Alignments[ 9, 0] := taRightJustify;
       LstReport.Alignments[10, 0] := taRightJustify;
       LstReport.Alignments[11, 0] := taRightJustify;
    End;
  End
  Else if RgTipoRelatorio.ItemIndex = 4 then Begin
    if CbTipoRelatorio.ItemIndex = 1 then Begin //Sintético
       LstReport.ColCount := 5;
       LstReport.Cells[0, 0] := 'Cod.Prod.';
       LstReport.Cells[1, 0] := 'Descrição';
       LstReport.Cells[2, 0] := 'Qtd.Transf.';
       LstReport.Cells[3, 0] := 'Id Usuário';
       LstReport.Cells[4, 0] := 'Nome';
       LstReport.ColWidths[ 0] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 1] := 250+Trunc(250*ResponsivoVideo);
       LstReport.ColWidths[ 2] :=  90+Trunc(90*ResponsivoVideo);
       LstReport.ColWidths[ 3] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 4] := 200+Trunc(200*ResponsivoVideo);
       LstReport.Alignments[ 0, 0] := taRightJustify;
       LstReport.FontStyles[ 0, 0] := [FsBold];
       LstReport.Alignments[ 1, 0] := taLeftJustify;
       LstReport.Alignments[ 2, 0] := taRightJustify;
       LstReport.Alignments[ 3, 0] := taRightJustify;
       LstReport.Alignments[ 4, 0] := taLeftJustify;
    End
    Else Begin
       LstReport.ColCount := 11;
       LstReport.Cells[0, 0]  := 'Id';
       LstReport.Cells[1, 0]  := 'Cód.Prod.';
       LstReport.Cells[2, 0]  := 'Descrição';
       LstReport.Cells[3, 0]  := 'Picking';
       LstReport.Cells[4, 0]  := 'Lote';
       LstReport.Cells[5, 0]  := 'Vencimento';
       LstReport.Cells[6, 0]  := 'Pallet';
       LstReport.Cells[7, 0]  := 'Qtd.Transf.';
       LstReport.Cells[8, 0]  := 'Data/Hora';
       LstReport.Cells[9, 0]  := 'Id Usuário';
       LstReport.Cells[10, 0] := 'Nome';
       LstReport.ColWidths[ 0] :=  70+Trunc(70*ResponsivoVideo);
       LstReport.ColWidths[ 1] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 2] := 250+Trunc(250*ResponsivoVideo);
       LstReport.ColWidths[ 3] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 4] := 120+Trunc(120*ResponsivoVideo);
       LstReport.ColWidths[ 5] := 110+Trunc(110*ResponsivoVideo);
       LstReport.ColWidths[ 6] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[ 7] :=  90+Trunc(90*ResponsivoVideo);
       LstReport.ColWidths[ 8] := 120+Trunc(120*ResponsivoVideo);
       LstReport.ColWidths[ 9] :=  80+Trunc(80*ResponsivoVideo);
       LstReport.ColWidths[10] := 200+Trunc(200*ResponsivoVideo);
       LstReport.Alignments[ 0, 0] := taRightJustify;
       LstReport.FontStyles[ 0, 0] := [FsBold];
       LstReport.Alignments[ 1, 0] := taRightJustify;
       LstReport.Alignments[ 2, 0] := taLeftJustify;
       LstReport.Alignments[ 3, 0] := taCenter;
       LstReport.Alignments[ 4, 0] := taLeftJustify;;
       LstReport.Alignments[ 5, 0] := taCenter;
       LstReport.Alignments[ 6, 0] := taCenter;
       LstReport.Alignments[ 7, 0] := taRightJustify;
       LstReport.Alignments[ 8, 0] := taLeftJustify;
       LstReport.Alignments[ 9, 0] := taRightJustify;
       LstReport.Alignments[10, 0] := taLeftJustify;
    End;
  End
  Else if RgTipoRelatorio.ItemIndex = 5 then Begin
     LstReport.ColCount := 11;
     LstReport.Cells[0, 0]  := 'Id';
     LstReport.Cells[1, 0]  := 'Nome';
     LstReport.Cells[2, 0]  := 'Data';
     LstReport.Cells[3, 0]  := 'Inicio';
     LstReport.Cells[4, 0]  := 'Término';
     LstReport.Cells[5, 0]  := 'Demanda';
     LstReport.Cells[6, 0]  := 'Coleta Unid';
     LstReport.Cells[7, 0]  := 'Qtd.Caixa';
     LstReport.Cells[8, 0]  := 'Hr.Trabalhada';
     LstReport.Cells[9, 0]  := 'Unid/Hr';
     LstReport.Cells[10, 0]  := 'Caixa/Hr';
     LstReport.ColWidths[ 0] :=  70+Trunc(70*ResponsivoVideo);
     LstReport.ColWidths[ 1] := 250+Trunc(250*ResponsivoVideo);
     LstReport.ColWidths[ 2] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[ 3] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[ 4] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[ 5] :=  90+Trunc(90*ResponsivoVideo);
     LstReport.ColWidths[ 6] :=  90+Trunc(90*ResponsivoVideo);
     LstReport.ColWidths[ 7] :=  90+Trunc(90*ResponsivoVideo);
     LstReport.ColWidths[ 8] := 100+Trunc(100*ResponsivoVideo);
     LstReport.ColWidths[ 9] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[10] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.Alignments[ 0, 0] := taRightJustify;
     LstReport.FontStyles[ 0, 0] := [FsBold];
     LstReport.Alignments[ 2, 0] := taCenter;
     LstReport.Alignments[ 3, 0] := taCenter;
     LstReport.Alignments[ 4, 0] := taCenter;
     LstReport.Alignments[ 5, 0] := taRightJustify;
     LstReport.Alignments[ 6, 0] := taRightJustify;
     LstReport.Alignments[ 7, 0] := taRightJustify;
     LstReport.Alignments[ 8, 0] := taCenter;
     LstReport.Alignments[ 9, 0] := taRightJustify;
     LstReport.Alignments[10, 0] := taRightJustify;
  End;
end;

procedure TFrmRelReposicaoColeta.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xLin : Integer;
begin
  if Arow=0 then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
     Exit;
  End;
  inherited;
  if RgTipoRelatorio.ItemIndex <> 0 then Exit;
  if (aCol=10) and (aRow>0) then Begin
     if LstReport.Cells[10, aRow] = '1' then
        LstReport.Cells[10, aRow] := '0'
     Else LstReport.Cells[10, aRow] := '1';
     if LstReport.Cells[10, aRow].ToInteger() = 0 then
        vSelLst := 1
     Else vSelLst := 0;
  End;
  if (ACol=10) and (aRow=0) then Begin
     for xLin := 1 to Pred(LstReport.RowCount) do
       LstReport.Cells[10, xLin] := vSelLst.ToString;
     if vSelLst = 1 then vSelLst := 0
     Else vSelLst := 1;
  End;
  if (ACol=11) and (aRow>0) then Begin
     FdMemPesqGeral.Filter   := 'ReposicaoId = '+LstReport.Cells[0, aRow];
     FdmemPesqGeral.Filtered := True;
     BtnImprimirStandClick(LstReport);
     FdMemPesqGeral.Filter   := '';
     FdmemPesqGeral.Filtered := False;
  End;
end;

procedure TFrmRelReposicaoColeta.MontaAnaliseColetaAnalitico;
Var xRep : Integer;
begin
  LstReport.RowCount  := FDMemAnaliseColetaAnalitico.RecordCount+1;
  LstReport.FixedRows := 1;
  FDMemAnaliseColetaAnalitico.First;
  xRep := 1;
  While Not FDMemAnaliseColetaAnalitico.Eof do Begin
    LstReport.Cells[0, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('reposicaoid').AsString;
    LstReport.Cells[1, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('CodProduto').AsString;
    LstReport.Cells[2, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Descricao').AsString;
    LstReport.Cells[3, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Picking').AsString;
    LstReport.Cells[4, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('PalletColeta').AsString;
    LstReport.Cells[5, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Lote').AsString;
    LstReport.Cells[6, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Fabricacao').AsString;
    LstReport.Cells[7, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Vencimento').AsString;
    LstReport.Cells[8, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Demanda').AsString;
    LstReport.Cells[9, xRep]  := FDMemAnaliseColetaAnalitico.FieldByName('Coleta').AsString;
    LstReport.Cells[10, xRep] := FDMemAnaliseColetaAnalitico.FieldByName('Transferido').AsString;
    LstReport.Cells[11, xRep] := FDMemAnaliseColetaAnalitico.FieldByName('QtdePendente').AsString;
    LstReport.Cells[12, xRep] := FDMemAnaliseColetaAnalitico.FieldByName('usuarioid').AsString;
    LstReport.Cells[13, xRep] := FDMemAnaliseColetaAnalitico.FieldByName('Nome').AsString;
    LstReport.Alignments[ 0, xRep] := taRightJustify;
    LstReport.FontStyles[ 0, xRep] := [FsBold];
    LstReport.Alignments[ 3, xRep] := taCenter;
    LstReport.Alignments[ 4, xRep] := taCenter;
    LstReport.Alignments[ 6, xRep] := taCenter;
    LstReport.Alignments[ 7, xRep] := taCenter;
    LstReport.Alignments[ 8, xRep] := taRightJustify;
    LstReport.Alignments[ 9, xRep] := taRightJustify;
    LstReport.Alignments[10, xRep] := taRightJustify;
    LstReport.Alignments[11, xRep] := taRightJustify;
    LstReport.Alignments[12, xRep] := taRightJustify;
    Inc(xRep);
    FDMemAnaliseColetaAnalitico.Next;
  End;
  FDMemAnaliseColetaAnalitico.First;
end;

procedure TFrmRelReposicaoColeta.MontaAnaliseColetaSintetico;
Var xRep : Integer;
begin
  LstReport.RowCount  := FDMemAnaliseColetaSintetico.RecordCount+1;
  LstReport.FixedRows := 1;
  FDMemAnaliseColetaSintetico.First;
  xRep := 1;
  While Not FDMemAnaliseColetaSintetico.Eof do Begin
    LstReport.Cells[0, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('CodProduto').AsString;
    LstReport.Cells[1, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('Descricao').AsString;
    LstReport.Cells[2, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('Picking').AsString;
    LstReport.Cells[3, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('Demanda').AsString;
    LstReport.Cells[4, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('Coleta').AsString;
    LstReport.Cells[5, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('Transferido').AsString;
    LstReport.Cells[6, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('QtdePendente').AsString;
    LstReport.Cells[7, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('UsuarioId').AsString;
    LstReport.Cells[8, xRep]  := FDMemAnaliseColetaSintetico.FieldByName('Nome').AsString;


    LstReport.Alignments[0, xRep] := taRightJustify;
    LstReport.FontStyles[0, xRep] := [FsBold];
    LstReport.Alignments[2, xRep] := taCenter;
    LstReport.Alignments[3, xRep] := taRightJustify;
    LstReport.Alignments[4, xRep] := taRightJustify;
    LstReport.Alignments[5, xRep] := taRightJustify;
    LstReport.Alignments[6, xRep] := taRightJustify;
    LstReport.Alignments[7, xRep] := taRightJustify;
    Inc(xRep);
    FDMemAnaliseColetaSintetico.Next;
  End;
  FDMemAnaliseColetaSintetico.First;
end;

procedure TFrmRelReposicaoColeta.MontaHistoricoTransferenciaAnalitico;
Var xRep : Integer;
begin
  LstReport.RowCount  := FDMemhistoricoTransferenciaAnalitico.RecordCount+1;
  LstReport.FixedRows := 1;
  FDMemhistoricoTransferenciaAnalitico.First;
  xRep := 1;
  While Not FDMemhistoricoTransferenciaAnalitico.Eof do Begin
    LstReport.Cells[0, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('reposicaoid').AsString;
    LstReport.Cells[1, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('CodProduto').AsString;
    LstReport.Cells[2, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('Descricao').AsString;
    LstReport.Cells[3, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('Picking').AsString;
    LstReport.Cells[4, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('Lote').AsString;
    LstReport.Cells[5, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('Vencimento').AsString;
    LstReport.Cells[6, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('PalletColeta').AsString;
    LstReport.Cells[7, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('QtdeTransferida').AsString;
    LstReport.Cells[8, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('Horario').AsString;
    LstReport.Cells[9, xRep]  := FDMemhistoricoTransferenciaAnalitico.FieldByName('UsuarioId').AsString;
    LstReport.Cells[10, xRep] := FDMemhistoricoTransferenciaAnalitico.FieldByName('Nome').AsString;

    LstReport.Alignments[ 0, xRep] := taRightJustify;
    LstReport.FontStyles[ 0, xRep] := [FsBold];
    LstReport.Alignments[ 1, xRep] := taRightJustify;
    LstReport.Alignments[ 2, xRep] := taLeftJustify;
    LstReport.Alignments[ 3, xRep] := taCenter;
    LstReport.Alignments[ 4, xRep] := taLeftJustify;;
    LstReport.Alignments[ 5, xRep] := taCenter;
    LstReport.Alignments[ 6, xRep] := taCenter;
    LstReport.Alignments[ 7, xRep] := taRightJustify;
    LstReport.Alignments[ 8, xRep] := taLeftJustify;
    LstReport.Alignments[ 9, xRep] := taRightJustify;
    LstReport.Alignments[10, xRep] := taLeftJustify;
    Inc(xRep);
    FDMemhistoricoTransferenciaAnalitico.Next;
  End;
  FDMemhistoricoTransferenciaAnalitico.First;
end;

procedure TFrmRelReposicaoColeta.MontaHistoricoTransferenciaSintetico;
Var xRep : Integer;
begin
  LstReport.RowCount  := FDMemhistoricoTransferenciaSintetico.RecordCount+1;
  LstReport.FixedRows := 1;
  FDMemhistoricoTransferenciaSintetico.First;
  xRep := 1;
  While Not FDMemhistoricoTransferenciaSintetico.Eof do Begin
    LstReport.Cells[0, xRep]  := FDMemhistoricoTransferenciaSintetico.FieldByName('CodProduto').AsString;
    LstReport.Cells[1, xRep]  := FDMemhistoricoTransferenciaSintetico.FieldByName('Descricao').AsString;
    LstReport.Cells[2, xRep]  := FDMemhistoricoTransferenciaSintetico.FieldByName('QtdeTransferida').AsString;
    LstReport.Cells[3, xRep]  := FDMemhistoricoTransferenciaSintetico.FieldByName('usuarioid').AsString;
    LstReport.Cells[4, xRep]  := FDMemhistoricoTransferenciaSintetico.FieldByName('Nome').AsString;
    LstReport.Alignments[ 0, xRep] := taRightJustify;
    LstReport.FontStyles[ 0, xRep] := [FsBold];
    LstReport.Alignments[ 1, xRep] := taLeftJustify;
    LstReport.Alignments[ 2, xRep] := taRightJustify;
    LstReport.Alignments[ 3, xRep] := taRightJustify;
    LstReport.Alignments[ 4, xRep] := taRightJustify;
    Inc(xRep);
    FDMemhistoricoTransferenciaSintetico.Next;
  End;
  FDMemhistoricoTransferenciaSintetico.First;
end;

procedure TFrmRelReposicaoColeta.MontaListaReposicao;
Var xRep : Integer;
begin
  if FdMemPesqGeral.IsEmpty then Begin
     LstReport.RowCount  := 1;
     Exit;
  End;
  vSelLst := 0;
  LstReport.RowCount  := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRep := 1;
  FdMemPesqGeral.First;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRep]  := FdMemPesqGeral.FieldByName('ReposicaoId').AsString;
    LstReport.Cells[1, xRep]  := FdMemPesqGeral.FieldByName('DtRessuprimento').AsString;
    LstReport.Cells[2, xRep]  := FdMemPesqGeral.FieldByName('Reposicaotipo').AsString;
    LstReport.Cells[3, xRep]  := FdMemPesqGeral.FieldByName('Zona').AsString;
    LstReport.Cells[4, xRep]  := FdMemPesqGeral.FieldByName('EnderecoInicial').AsString;
    LstReport.Cells[5, xRep]  := FdMemPesqGeral.FieldByName('EnderecoFinal').AsString;
    LstReport.Cells[6, xRep]  := FdMemPesqGeral.FieldByName('UsuarioReposicao').AsString;
    LstReport.Cells[7, xRep]  := FdMemPesqGeral.FieldByName('Terminal').AsString;
    LstReport.Cells[8, xRep]  := FdMemPesqGeral.FieldByName('DtReposicao').AsString;
    LstReport.Cells[9, xRep]  := FdMemPesqGeral.FieldByName('Processo').AsString;
    LstReport.AddDataImage(10, xRep, 1, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstReport.AddDataImage(11, xRep, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstReport.Cells[10, xRep]  := '1';
    LstReport.Cells[11, xRep]  := '5';
    LstReport.Alignments[0,  xRep] := taRightJustify;
    LstReport.FontStyles[0,  xRep] := [FsBold];
    LstReport.Alignments[1,  xRep] := taCenter;
    LstReport.Alignments[4,  xRep] := taCenter;
    LstReport.Alignments[5,  xRep] := taCenter;
    LstReport.Alignments[10, xRep] := taCenter;
    Inc(xRep);
    FdMemPesqGeral.Next;
  End;
  FdMemPesqGeral.First;
end;

procedure TFrmRelReposicaoColeta.MontaTransfPickingAnalitico;
Var xRep : Integer;
begin
  LstReport.RowCount  := FDMemRelTransPickingAnalitico.RecordCount+1;
  LstReport.FixedRows := 1;
  FDMemRelTransPickingAnalitico.First;
  xRep := 1;
  While Not FDMemRelTransPickingAnalitico.Eof do Begin
    LstReport.Cells[0, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('reposicaoid').AsString;
    LstReport.Cells[1, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('CodProduto').AsString;
    LstReport.Cells[2, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('Descricao').AsString;
    LstReport.Cells[3, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('Picking').AsString;
    LstReport.Cells[4, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('PalletColeta').AsString;
    LstReport.Cells[5, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('Lote').AsString;
    LstReport.Cells[6, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('Fabricacao').AsString;
    LstReport.Cells[7, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('Vencimento').AsString;
    LstReport.Cells[8, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('QtdColeta').AsString;
    LstReport.Cells[9, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('QtdTransferida').AsString;
    LstReport.Cells[10, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('QtdePendente').AsString;
    LstReport.Cells[11, xRep]  := FDMemRelTransPickingAnalitico.FieldByName('Concluido').AsString;
    LstReport.Alignments[ 0, xRep] := taRightJustify;
    LstReport.FontStyles[ 0, xRep] := [FsBold];
    LstReport.Alignments[ 2, xRep] := taLeftJustify;
    LstReport.Alignments[ 3, xRep] := taLeftJustify;
    LstReport.Alignments[ 4, xRep] := taLeftJustify;
    LstReport.Alignments[ 5, xRep] := taLeftJustify;
    LstReport.Alignments[ 6, xRep] := taCenter;
    LstReport.Alignments[ 7, xRep] := taCenter;
    LstReport.Alignments[ 8, xRep] := taRightJustify;
    LstReport.Alignments[ 9, xRep] := taRightJustify;
    LstReport.Alignments[10, xRep] := taRightJustify;
    LstReport.Alignments[11, xRep] := taRightJustify;
    Inc(xRep);
    FDMemRelTransPickingAnalitico.Next;
  End;
  FDMemRelTransPickingAnalitico.First;
end;

procedure TFrmRelReposicaoColeta.MontaTransfPickingSintetico;
Var xRep : Integer;
begin
  LstReport.RowCount  := FDMemRelTransPickingSintetico.RecordCount+1;
  LstReport.FixedRows := 1;
  FDMemRelTransPickingSintetico.First;
  xRep := 1;
  While Not FDMemRelTransPickingSintetico.Eof do Begin
    LstReport.Cells[0, xRep]  := FDMemRelTransPickingSintetico.FieldByName('CodProduto').AsString;
    LstReport.Cells[1, xRep]  := FDMemRelTransPickingSintetico.FieldByName('Descricao').AsString;
    LstReport.Cells[2, xRep]  := FDMemRelTransPickingSintetico.FieldByName('Picking').AsString;
    LstReport.Cells[3, xRep]  := FDMemRelTransPickingSintetico.FieldByName('QtdColeta').AsString;
    LstReport.Cells[4, xRep]  := FDMemRelTransPickingSintetico.FieldByName('QtdTransferida').AsString;
    LstReport.Cells[5, xRep]  := FDMemRelTransPickingSintetico.FieldByName('QtdePendente').AsString;
    LstReport.Cells[6, xRep]  := FDMemRelTransPickingSintetico.FieldByName('Concluido').AsString;
    LstReport.Alignments[ 0, xRep] := taRightJustify;
    LstReport.FontStyles[ 0, xRep] := [FsBold];
    LstReport.Alignments[ 1, xRep] := taLeftJustify;
    LstReport.Alignments[ 2, xRep] := taLeftJustify;
    LstReport.Alignments[ 3, xRep] := taRightJustify;
    LstReport.Alignments[ 4, xRep] := taRightJustify;
    LstReport.Alignments[ 5, xRep] := taRightJustify;
    LstReport.Alignments[ 6, xRep] := taRightJustify;
    Inc(xRep);
    FDMemRelTransPickingSintetico.Next;
  End;
  FDMemRelTransPickingSintetico.First;
end;

procedure TFrmRelReposicaoColeta.PesquisarDados;
Var vDtInicio, vDtFinal : TDateTime;
    vErro   : String;
    pProcessoId      : Integer;
    vPendente        : Integer;
begin
  if (EdtReposicaoId.Text<>'') and (StrToIntDef(EdtReposicaoId.Text,0)<=0) then Begin
     EdtReposicaoId.SetFocus;
     ShowErro('Id('+EdtReposicaoId.text+') da Reposição inválido!');
     EdtReposicaoId.Clear;
     Exit;
  End;
  if (EdtCodProduto.Text<> '') and (StrToInt64Def(EdtCodProduto.Text, 0) <= 0) then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.Setfocus;
     Exit;
  end;
  if (EdtZonaId.Text<> '') and (StrToIntDef(EdtZonaId.Text, 0) <= 0) then Begin
     ShowErro( '😢Id('+EdtZonaId.Text+') da Zona/Setor inválido!' );
     EdtZonaId.Clear;
     EdtZonaId.Setfocus;
     Exit;
  end;
  if (EdtUsuarioId.Text<> '') and (StrToIntDef(EdtUsuarioId.Text, 0) <= 0) then Begin
     ShowErro( '😢Id('+EdtUsuarioId.Text+') do usuário inválido!' );
     EdtUsuarioId.Clear;
     EdtUsuarioId.Setfocus;
     Exit;
  end;
  if (EdtProcessoId.Text<> '') and (StrToIntDef(EdtProcessoId.Text, 0) <= 0) then Begin
     ShowErro( '😢Id('+EdtProcessoId.Text+') do Processo inválido!' );
     EdtProcessoId.Clear;
     EdtProcessoId.Setfocus;
     Exit;
  end;
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  if RgTipoRelatorio.itemindex < 0 then Begin
     ShowErro('Selecione o tipo de relatório!');
     Exit;
  End;
  if (CbTipoRelatorio.Visible) and (CbTipoRelatorio.ItemIndex < 0) then Begin
     ShowErro('Selecione o Tipo de Resulta para Análise(Analítico/Sintétido) do relatório!');
     Exit;
  End;
  if (CbDivergencia.Visible) and (CbDivergencia.ItemIndex < 0) then Begin
     ShowErro('Selecione o tipo de divergência!');
     Exit;
  End;
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       vDtFinal := 0
    Else vDtFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  if ChkPendentes.Checked then
     vPendente   := 1
  Else vPendente := 0;
  HeaderLstReport;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var JsonArrayRetorno : TJsonArray;
        ObjPedidoCtrl    : TPedidoSaidaCtrl;
    begin
      if (RgTipoRelatorio.ItemIndex = 0) and (ChkPendentes.Checked) then
         pProcessoId := 27
      Else pProcessoId := StrToIntDef(EdtProcessoId.Text, 0); //Trocar por Status de Gerada
      ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
      If RgTipoRelatorio.ItemIndex = 0 then
         JsonArrayRetorno := ObjPedidoCtrl.GetConsultaReposicao(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0))
      Else If RgTipoRelatorio.ItemIndex = 1 then Begin
         if CbTipoRelatorio.ItemIndex = 0 then
            JsonArrayRetorno   := ObjPedidoCtrl.GetAnaliseColeta(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'analitico', 0, 0, vCodProduto, StrToIntDef(EdtZonaId.Text, 0))
         Else JsonArrayRetorno := ObjPedidoCtrl.GetAnaliseColeta(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'sintetico', 0, 0, vCodProduto, StrToIntDef(EdtZonaId.Text, 0));
      End
      Else If RgTipoRelatorio.ItemIndex = 2 then Begin
         if CbTipoRelatorio.ItemIndex = 0 then Begin
            if CbDivergencia.ItemIndex = 0 then
               JsonArrayRetorno := ObjPedidoCtrl.GetAnaliseColeta(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'analitico', 1, 0, vCodProduto, StrToIntDef(EdtZonaId.Text, 0))
            Else JsonArrayRetorno := ObjPedidoCtrl.GetAnaliseColeta(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'analitico', 1, 1, vCodProduto, StrToIntDef(EdtZonaId.Text, 0));
         End
         Else Begin
            if CbDivergencia.ItemIndex = 0 then
               JsonArrayRetorno := ObjPedidoCtrl.GetAnaliseColeta(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'sintetico', 1, 0, vCodProduto, StrToIntDef(EdtZonaId.Text, 0))
            Else JsonArrayRetorno := ObjPedidoCtrl.GetAnaliseColeta(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'sintetico', 1, 1, vCodProduto, StrToIntDef(EdtZonaId.Text, 0));
         End;
      End
      Else If RgTipoRelatorio.ItemIndex = 3 then Begin
         if CbTipoRelatorio.ItemIndex = 0 then
            JsonArrayRetorno := ObjPedidoCtrl.RelReposicaoTransfPicking(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'analitico', vCodProduto, StrToIntDef(EdtZonaId.Text, 0))
         Else JsonArrayRetorno := ObjPedidoCtrl.RelReposicaoTransfPicking(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'sintetico', vCodProduto, StrToIntDef(EdtZonaId.Text, 0));
      End
      Else If RgTipoRelatorio.ItemIndex = 4 then Begin
         if CbTipoRelatorio.ItemIndex = 0 then
            JsonArrayRetorno := ObjPedidoCtrl.GetRelHistoricoTransferenciaPicking(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'analitico', vCodProduto, StrToIntDef(EdtZonaId.Text, 0))
         Else
            JsonArrayRetorno := ObjPedidoCtrl.GetRelHistoricoTransferenciaPicking(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), 'sintetico', vCodProduto, StrToIntDef(EdtZonaId.Text, 0));
      End
      Else If RgTipoRelatorio.ItemIndex = 5 then Begin
         JsonArrayRetorno := ObjPedidoCtrl.GetReposicaoColetaProdutividade(vDtInicio, vDtFinal, StrToIntDef(EdtReposicaoId.Text, 0), pProcessoId, vPendente, StrToIntDef(EdtUsuarioId.Text, 0), vCodProduto, StrToIntDef(EdtZonaId.Text, 0))
      End;
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LstReport.ClearRect(0, 1, LstReport.ColCount-1, LstReport.RowCount-1);
         LstReport.RowCount := 1;
      End
      Else If RgTipoRelatorio.ItemIndex = 0 then
        PreencherResumoColeta(JsonArrayRetorno)
      Else If RgTipoRelatorio.ItemIndex in [1, 2] then
        PreencherAnaliseColeta(JsonArrayRetorno)
      Else If RgTipoRelatorio.ItemIndex = 3 then
        PreencherTransfPicking(JsonArrayRetorno)
      Else If RgTipoRelatorio.ItemIndex = 4 then
        PreencherHistoricoTransferencia(JsonArrayRetorno)
      Else If RgTipoRelatorio.ItemIndex = 5 then
        PreencherReposicaoColetaProdutividade(JsonArrayRetorno);
      ImprimirExportar(True);
      JsonArrayRetorno := Nil;
      ObjPedidoCtrl.Free;
    End);
end;

procedure TFrmRelReposicaoColeta.PreencherAnaliseColeta(
  pJsonArrayRetorno: TJsonArray);
begin
  if CbTipoRelatorio.ItemIndex = 0 then Begin
     If FDMemAnaliseColetaAnalitico.Active then
        FDMemAnaliseColetaAnalitico.EmptyDataSet;
     FDMemAnaliseColetaAnalitico.Close;
     FDMemAnaliseColetaAnalitico.LoadFromJSON(pJsonArrayRetorno, False);
     LblTotRegistro.Caption := FormatFloat('######0', FDMemAnaliseColetaAnalitico.RecordCount);
     MontaAnaliseColetaAnalitico;
  End
  Else Begin
     If FDMemAnaliseColetaSintetico.Active then
        FDMemAnaliseColetaSintetico.EmptyDataSet;
     FDMemAnaliseColetaSintetico.Close;
     FDMemAnaliseColetaSintetico.LoadFromJSON(pJsonArrayRetorno, False);
     LblTotRegistro.Caption := FormatFloat('######0', FDMemAnaliseColetaSintetico.RecordCount);
     MontaAnaliseColetaSintetico;
  End;
end;

procedure TFrmRelReposicaoColeta.PreencherHistoricoTransferencia(
  pJsonArrayRetorno : TJsonArray);
begin
  if CbTipoRelatorio.ItemIndex = 0 then Begin
     If FDMemHistoricoTransferenciaAnalitico.Active then
        FDMemHistoricoTransferenciaAnalitico.EmptyDataSet;
     FDMemHistoricoTransferenciaAnalitico.Close;
     FDMemHistoricoTransferenciaAnalitico.LoadFromJSON(pJsonArrayRetorno, False);
     LblTotRegistro.Caption := FormatFloat('######0', FDMemHistoricoTransferenciaAnalitico.RecordCount);
     MontaHistoricoTransferenciaAnalitico;
  End
  Else Begin
     If FDMemHistoricoTransferenciaSintetico.Active then
        FDMemHistoricoTransferenciaSintetico.EmptyDataSet;
     FDMemHistoricoTransferenciaSintetico.Close;
     FDMemHistoricoTransferenciaSintetico.LoadFromJSON(pJsonArrayRetorno, False);
     LblTotRegistro.Caption := FormatFloat('######0', FDMemHistoricoTransferenciaSintetico.RecordCount);
     MontaHistoricoTransferenciaSintetico;
  End;
end;

procedure TFrmRelReposicaoColeta.PreencherReposicaoColetaProdutividade(
  pJsonArrayRetorno: TJsonArray);
Var xRep, vUnidadesPorHora : Integer;
begin
  If FDMemReposicaoColetaProdutividade.Active then
     FDMemReposicaoColetaProdutividade.EmptyDataSet;
  FDMemReposicaoColetaProdutividade.Close;
  FDMemReposicaoColetaProdutividade.LoadFromJSON(pJsonArrayRetorno, False);
  LstReport.RowCount     := FDMemReposicaoColetaProdutividade.RecordCount+1;
  LblTotregistro.Caption := FDMemReposicaoColetaProdutividade.RecordCount.ToString();
  LstReport.FixedRows := 1;
  FDMemReposicaoColetaProdutividade.First;
  xRep := 1;
  While Not FDMemReposicaoColetaProdutividade.Eof do Begin
    LstReport.Cells[ 0, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('usuarioid').AsString;
    LstReport.Cells[ 1, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('nome').AsString;
    LstReport.Cells[ 2, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('dtentrada').AsString;
    LstReport.Cells[ 3, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('Inicio').AsString;
    LstReport.Cells[ 4, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('Termino').AsString;
    LstReport.Cells[ 5, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('Demanda').AsString;
    LstReport.Cells[ 6, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('Coleta').AsString;
    LstReport.Cells[ 7, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('QtdCaixa').AsString;
    LstReport.Cells[ 8, xRep]  := FDMemReposicaoColetaProdutividade.FieldByName('HoraTrabalhada').AsString;

    if FDMemReposicaoColetaProdutividade.FieldByName('CalcHora').AsInteger = 1 then
       vUnidadesPorHora := CalcUnidHr(FDMemReposicaoColetaProdutividade.FieldByName('Coleta').AsInteger, FDMemReposicaoColetaProdutividade.FieldByName('HoraTrabalhada').AsString )
    Else vUnidadesPorHora := FDMemReposicaoColetaProdutividade.FieldByName('Coleta').AsInteger;
    if vUnidadesPorHora >= STrToIntDef(EdtMeta.Text, 0) then
       LstReport.Colors[9, xRep] := clGreen
    Else if vUnidadesPorHora >= STrToIntDef(EdtTolerancia.Text, 0) then
       LstReport.Colors[9, xRep] := clYellow
    Else
       LstReport.Colors[9, xRep] := clRed;
    LstReport.FontStyles[9, xRep] := [fsBold];
    LstReport.Cells[9, xRep] := vUnidadesPorHora.ToString();
    if FDMemReposicaoColetaProdutividade.FieldByName('CalcHora').AsInteger = 1 then
       LstReport.Cells[10, xRep] := CalcUnidHr(FDMemReposicaoColetaProdutividade.FieldByName('QtdCaixa').AsInteger, FDMemReposicaoColetaProdutividade.FieldByName('HoraTrabalhada').AsString ).ToString()
    Else
       LstReport.Cells[10, xRep] := FDMemReposicaoColetaProdutividade.FieldByName('QtdCaixa').AsString;
    LstReport.FontStyles[10, xRep] := [fsBold];
    LstReport.Alignments[ 0, xRep] := taRightJustify;
    LstReport.FontStyles[ 0, xRep] := [FsBold];
    LstReport.Alignments[ 2, xRep] := taCenter;
    LstReport.Alignments[ 3, xRep] := taCenter;
    LstReport.Alignments[ 4, xRep] := taCenter;
    LstReport.Alignments[ 5, xRep] := taRightJustify;
    LstReport.Alignments[ 6, xRep] := taRightJustify;
    LstReport.Alignments[ 7, xRep] := taRightJustify;
    LstReport.Alignments[ 8, xRep] := taCenter;
    LstReport.Alignments[ 9, xRep] := taRightJustify;
    LstReport.Alignments[10, xRep] := taRightJustify;
    Inc(xRep);
    FDMemReposicaoColetaProdutividade.Next;
  End;
  FDMemReposicaoColetaProdutividade.First;
end;

procedure TFrmRelReposicaoColeta.PreencherResumoColeta(
  pJsonArrayRetorno: TJsonArray);
Var xRetorno, xBody  : Integer;
    vZonaNull : String;
    vDtRessuprimento : String;
begin
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdmemPesqGeral.Open;
  for xRetorno := 0 to Pred(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Count) do Begin
    FdMemPesqGeral.Append;
    FdMemPesqGeral.FieldByName('ReposicaoId').AsInteger      := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('reposicaoid');
    if (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento') <> '') and
       (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento') <> 'null') then Begin
       vDtRessuprimento := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtressuprimento');
       vDtRessuprimento := Copy(vDtRessuprimento, 9, 2)+'/'+Copy(vDtRessuprimento, 6, 2)+'/'+Copy(vDtRessuprimento, 1, 4);
       FdMemPesqGeral.FieldByName('DtRessuprimento').AsDateTime := StrToDate(vDtRessuprimento);
    End;
    FdMemPesqGeral.FieldByName('Reposicaotipo').AsInteger    := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('reposicaotipo');
    vZonaNull := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('zonaid');
    if (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('zonaid') <> '') then
        FdMemPesqGeral.FieldByName('ZonaId').AsInteger           := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('zonaid');
    if (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('zona') <> '') Then
       FdMemPesqGeral.FieldByName('Zona').AsString              := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('zona');
    if (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('enderecoinicial') <> '') Then
       FdMemPesqGeral.FieldByName('EnderecoInicial').AsString   := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('enderecoinicial');
    if (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('enderecofinal') <> '') Then
       FdMemPesqGeral.FieldByName('EnderecoFinal').AsString     := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('enderecofinal');
    FdMemPesqGeral.FieldByName('Usuarioid').AsInteger        := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('usuarioid');
    FdMemPesqGeral.FieldByName('Terminal').AsString          := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('terminal');
    if (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao') <> '') and
       (pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao') <> '') then
       FdMemPesqGeral.FieldByName('DtReposicao').AsDateTime     := StrToDate(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('datareposicao'));
    FdMemPesqGeral.FieldByName('HrReposicao').AsString       := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('hrreposicao');
    FdMemPesqGeral.FieldByName('uuid').AsString              := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('uuid');
    FdMemPesqGeral.FieldByName('UsuarioReposicao').AsString  := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('usuarioreposicao');
    FdMemPesqGeral.FieldByName('ProcessoId').AsInteger       := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<Integer>('processoid');
    FdMemPesqGeral.FieldByName('Processo').AsString          := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('processo');
    FdmemPesqGeral.Post;
    //Dados da Coleta
  End;
    If FdMemReposicaoColeta.Active then
       FdMemReposicaoColeta.EmptyDataSet;
    FdMemReposicaoColeta.Close;
    FdMemReposicaoColeta.Open;
    for xBody := 0 to Pred(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Count) do Begin
      FdMemReposicaoColeta.Append;
      FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger    := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicaoid');
      FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger      := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('produtoid');
      FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger     := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('codproduto');
      FdMemReposicaoColeta.FieldByName('Descricao').AsString       := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descricao');
      FdMemReposicaoColeta.FieldByName('Embalagem').AsString       := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('embalagem');
      FdMemReposicaoColeta.FieldByName('FatorConversao').AsInteger := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('fatorconversao');
      if pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('pickingid') <> '' then
         FdMemReposicaoColeta.FieldByName('PickingId').AsInteger      := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('pickingid');
      FdMemReposicaoColeta.FieldByName('Picking').AsString         := EnderecoMask(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('picking'),
                                                                                   pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking'), True);
      FdMemReposicaoColeta.FieldByName('MascaraPicking').AsString  := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking');
      FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger     := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('enderecoid');
      FdMemReposicaoColeta.FieldByName('Endereco').AsString        := EnderecoMask(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('endereco'),
                                                                                   pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascara'), True);
      FdMemReposicaoColeta.FieldByName('Mascara').AsString        := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascara');
      FdMemReposicaoColeta.FieldByName('ZonaId').AsInteger        := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('zonaid');
      FdMemReposicaoColeta.FieldByName('Zona').AsString           := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('zona');
      FdMemReposicaoColeta.FieldByName('LoteId').AsInteger        := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('loteid');
      FdMemReposicaoColeta.FieldByName('DescrLote').AsString      := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descrlote');
      FdMemReposicaoColeta.FieldByName('Vencimento').AsDateTime   := StrToDate(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('vencimento'));
      FdMemReposicaoColeta.FieldByName('Disponivel').AsInteger    := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('disponivel');
      FdMemReposicaoColeta.FieldByName('Demanda').AsInteger       := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('demanda');
      if pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('estoquetipoid') <> '' then
         FdMemReposicaoColeta.FieldByName('estoquetipoid').AsInteger  := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<integer>('estoquetipoid');
      if pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('reposicao') <> '' then
         FdMemReposicaoColeta.FieldByName('Reposicao').AsInteger      := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicao');
      if pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('usuarioid') <> '' then
         FdMemReposicaoColeta.FieldByName('UsuarioId').Asinteger      := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<integer>('usuarioid');
      FdMemReposicaoColeta.FieldByName('Nome').AsString               := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('nome');
      FdMemReposicaoColeta.FieldByName('Terminal').AsString           := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('terminal');
      if pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<string>('dataentrada') <> '' then
         FdMemReposicaoColeta.FieldByName('DtColeta').AsDateTime      := StrToDate(pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('dataentrada'));
      FdMemReposicaoColeta.FieldByName('HrColeta').AsString           := pJsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('hrentrada');
      FdMemReposicaoColeta.Post;
    End;
  //End;
  if (StrToIntDef(EdtReposicaoId.Text, 0)>0) then Begin
     FdMemReposicaoColeta.First;
     LblReposicao.Caption := DateToStr(FdMemPesqGeral.FieldByName('DtReposicao').AsDateTime)+' ' +
                             FdMemPesqGeral.FieldByName('Processo').AsString;
  End;
  LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
  MontaListaReposicao;
end;

procedure TFrmRelReposicaoColeta.PreencherTransfPicking(
  pJsonArrayRetorno: TJsonArray);
begin
  if CbTipoRelatorio.ItemIndex = 0 then Begin
     If FDMemRelTransPickingAnalitico.Active then
        FDMemRelTransPickingAnalitico.EmptyDataSet;
     FDMemRelTransPickingAnalitico.Close;
     FDMemRelTransPickingAnalitico.LoadFromJSON(pJsonArrayRetorno, False);
     LblTotRegistro.Caption := FormatFloat('######0', FDMemRelTransPickingAnalitico.RecordCount);
     MontaTransfPickingAnalitico;
  End
  Else Begin
     If FDMemRelTransPickingSintetico.Active then
        FDMemRelTransPickingSintetico.EmptyDataSet;
     FDMemRelTransPickingSintetico.Close;
     FDMemRelTransPickingSintetico.LoadFromJSON(pJsonArrayRetorno, False);
     LblTotRegistro.Caption := FormatFloat('######0', FDMemRelTransPickingSintetico.RecordCount);
     MontaTransfPickingSintetico;
  End;

end;

procedure TFrmRelReposicaoColeta.RgTipoRelatorioClick(Sender: TObject);
begin
  inherited;
  LblTipoRelatorioResumo.Visible := RgTipoRelatorio.ItemIndex in [1, 2, 3, 4] ;
  CbTipoRelatorio.Visible        := RgTipoRelatorio.ItemIndex in [1, 2, 3, 4] ;
  LblDivergencia.Visible         := RgTipoRelatorio.ItemIndex = 2;
  CbDivergencia.Visible          := RgTipoRelatorio.ItemIndex = 2;
  ChkPendentes.Visible           := RgTipoRelatorio.ItemIndex in [0] ;
  if RgTipoRelatorio.itemindex = 4 then
     GbPeriodo.Caption := ' Data Transferência '
  Else
     GbPeriodo.Caption := ' Período da Reposição ';
  if RgTipoRelatorio.Itemindex > 1 then Begin
     EdtProcessoId.Text := '';
     GbProcesso.Visible := False;
  End
  Else
     GbProcesso.Visible := True;
  EnableProdutividade(RgTipoRelatorio.ItemIndex = 5);
  HeaderLstReport;
end;

end.
