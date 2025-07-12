unit uFrmRelPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, DataSet.Serialize,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, System.Math,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvToolEdit, JvSpin, Generics.Collections, System.Json, Rest.Types,
  PedidoSaidaCtrl, PedidoVolumeCtrl, Vcl.Buttons, Vcl.DBGrids, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.ComCtrls, FireDAC.UI.Intf, FireDAC.VCLUI.Script,
  FireDAC.Comp.UI, ACBrBase, ACBrETQ, Vcl.DialogMessage, dxCameraControl;

type
  TFrmRelPedidos = class(TFrmBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    EdtPedidoId: TEdit;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    PgcPedidos: TcxPageControl;
    TabPedidos: TcxTabSheet;
    TabVolumes: TcxTabSheet;
    LstPedidosAdv: TAdvStringGrid;
    LstVolumesAdv: TAdvStringGrid;
    LstVolumeProdutosAdv: TAdvStringGrid;
    BtnPesqRota: TBitBtn;
    BtnPesqCliente: TBitBtn;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    LblProcesso: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    LblRegistro: TLabel;
    LblItens: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LblDemanda: TLabel;
    LblPerda: TLabel;
    LblPercPerda: TLabel;
    TabResumo: TcxTabSheet;
    LstPedidoResumoAdv: TAdvStringGrid;
    FdMemPesqPedidoResumoAtendimento: TFDMemTable;
    LstVolumeEtapas: TAdvStringGrid;
    FDGUIxScriptDialog1: TFDGUIxScriptDialog;
    EdtDocumentoNr: TEdit;
    Label10: TLabel;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    ChkPedidoPendente: TCheckBox;
    LstPedidoProcesso: TAdvStringGrid;
    Label14: TLabel;
    LblNProcessado: TLabel;
    Label16: TLabel;
    LblProcessado: TLabel;
    Label18: TLabel;
    LblConcluido: TLabel;
    LblPercNProc: TLabel;
    LblPercProc: TLabel;
    LblPercConcluido: TLabel;
    GbNotaFiscal: TGroupBox;
    LblNotaFiscal: TLabel;
    EdtNotaFiscalERP: TEdit;
    TabRelVolumes: TcxTabSheet;
    GroupBox8: TGroupBox;
    Label15: TLabel;
    Label17: TLabel;
    EdtPedido_AnalRua: TEdit;
    EdtDocumentoNr_AnalRua: TEdit;
    GroupBox9: TGroupBox;
    Label19: TLabel;
    LblRotaVolume_Consulta: TLabel;
    EdtRotaId_AnalRua: TEdit;
    BtnPesqRotaVolume_Consulta: TBitBtn;
    GroupBox10: TGroupBox;
    Label21: TLabel;
    LblProdutoConsulta: TLabel;
    EdtCodProduto_AnalRua: TEdit;
    BtnPesqProdutoConsulta: TBitBtn;
    GroupBox11: TGroupBox;
    Label23: TLabel;
    LblProcessoVolume: TLabel;
    EdtProcessoId_AnalRua: TEdit;
    BtnProcesso_Consulta: TBitBtn;
    GroupBox12: TGroupBox;
    Label25: TLabel;
    LblDestinatarioVolume_Consulta: TLabel;
    EdtDestinatario_AnalRua: TEdit;
    BtnPesqDestinatarioVolume_Consulta: TBitBtn;
    GbVolumeConsulta: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    LblTotVolume: TLabel;
    LblTotVolumePendente: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    LblTotVolumeExpedido: TLabel;
    LblTotVolumeCancelado: TLabel;
    LblTotVolumeCanceladoPerc: TLabel;
    Label38: TLabel;
    LblTotVolumeCxaFechada: TLabel;
    Label40: TLabel;
    LblTotVolumeCxaFracionada: TLabel;
    LblTotVolumeCxaFechadaPerc: TLabel;
    LblTotVolumeCxaFracionadaPerc: TLabel;
    PgcVolumesGeral: TcxPageControl;
    TabVolumeResumo: TcxTabSheet;
    TabAnalisePorSetor: TcxTabSheet;
    TabAnalisePorRua: TcxTabSheet;
    LstVolumeConsulta: TAdvStringGrid;
    LstVolumeHistoricoConsulta: TAdvStringGrid;
    LstVolumeProdutosConsulta: TAdvStringGrid;
    GroupBox14: TGroupBox;
    Label45: TLabel;
    Label46: TLabel;
    EdtDtPedidoInicial_AnalRua: TJvDateEdit;
    EdtDtPedidoFinal_AnalRua: TJvDateEdit;
    GbEstrutura: TGroupBox;
    ChkPulmao: TCheckBox;
    LstAnalisePorRua: TAdvStringGrid;
    PnlVolumeTotal: TPanel;
    Label47: TLabel;
    LblTotPedido_AnalisePorRua: TLabel;
    Label49: TLabel;
    LblTotVolumeCxaFechada_AnalisePorRua: TLabel;
    LblTotVolumeFracionado_AnalisePorRua: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    LblTotVolume_AnalisePorRua: TLabel;
    ChkPicking: TCheckBox;
    GbPedidoVolume: TGroupBox;
    Label48: TLabel;
    EdtPedidoVolumeId: TEdit;
    FDMemAnalisePorRua: TFDMemTable;
    FDMemAnalisePorRuaZonaId: TIntegerField;
    FDMemAnalisePorRuaZona: TStringField;
    FDMemAnalisePorRuaRua: TStringField;
    FDMemAnalisePorRuaVolumeCxaFechada: TIntegerField;
    FDMemAnalisePorRuaVolumeFracionado: TIntegerField;
    FDMemAnalisePorRuaUnidadeCxaFechada: TIntegerField;
    FDMemAnalisePorRuaUnidadeFracionado: TIntegerField;
    FDMemAnalisePorRuaTotalVolumes: TIntegerField;
    FDMemAnalisePorRuaTotalUnidades: TIntegerField;
    ChkResumoPorVolume: TCheckBox;
    ChkAnalisePorSetor: TCheckBox;
    ChkAnalisePorRua: TCheckBox;
    ChkAnalisePorRota: TCheckBox;
    ChkAnalisePorLoja: TCheckBox;
    Panel1: TPanel;
    Label20: TLabel;
    LblTotPedido_AnalisePorSetor: TLabel;
    Label50: TLabel;
    LblTotVolumeCxaFechada_AnalisePorSetor: TLabel;
    LblTotVolumeFracionado_AnalisePorSetor: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    LblTotVolume_AnalisePorSetor: TLabel;
    LstAnalisePorSetor: TAdvStringGrid;
    FDMemAnalisePorSetor: TFDMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    FDMemAnalisePorRota: TFDMemTable;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    IntegerField13: TIntegerField;
    IntegerField14: TIntegerField;
    FDMemAnalisePorLoja: TFDMemTable;
    IntegerField16: TIntegerField;
    IntegerField17: TIntegerField;
    IntegerField18: TIntegerField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    IntegerField21: TIntegerField;
    TabAnalisePorRota: TcxTabSheet;
    PnlVolumeTotalPorRota: TPanel;
    Label22: TLabel;
    LblTotPedido_AnalisePorRota: TLabel;
    Label51: TLabel;
    LblTotVolumeCxaFechada_AnalisePorRota: TLabel;
    LblTotVolumeFracionado_AnalisePorRota: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    LblTotVolume_AnalisePorRota: TLabel;
    LstAnalisePorRota: TAdvStringGrid;
    TabAnalisePorLoja: TcxTabSheet;
    PnlVolumeTotalPorLoja: TPanel;
    Label61: TLabel;
    LblTotPedido_AnalisePorLoja: TLabel;
    Label63: TLabel;
    LblTotVolumeCxaFechada_AnalisePorLoja: TLabel;
    LblTotVolumeFracionado_AnalisePorLoja: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    LblTotVolume_AnalisePorLoja: TLabel;
    LstAnalisePorLoja: TAdvStringGrid;
    FDMemAnalisePorRotaRotaId: TIntegerField;
    FDMemAnalisePorRotaRota: TStringField;
    FDMemAnalisePorLojaCodPessoaERP: TIntegerField;
    FDMemAnalisePorLojaRazao: TStringField;
    FDMemAnalisePorLojaFantasia: TStringField;
    GroupBox15: TGroupBox;
    Label24: TLabel;
    LblZonaVolume: TLabel;
    EdtZonaId_Volume: TEdit;
    BtnPesqZonaVolume: TBitBtn;
    LblTotVolumeExpedidoPerc: TLabel;
    GroupBox13: TGroupBox;
    CbEmbalagem: TComboBox;
    ChkVolumePendente: TCheckBox;
    FDMemVolumeConsulta: TFDMemTable;
    FDMemVolumeLotes: TFDMemTable;
    FDMemVolumeConsultaLotes: TFDMemTable;
    FdMemVolumeExcel: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtPedidoIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure LstPedidosAdvDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstVolumesAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure TabPedidosShow(Sender: TObject);
    procedure LstPedidosAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstPedidoResumoAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstVolumeProdutosAdvClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure LstVolumesAdvClick(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure ChkPedidoPendenteClick(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure EdtDtPedidoInicial_AnalRuaChange(Sender: TObject);
    procedure ChkResumoPorVolumeClick(Sender: TObject);
    procedure LstAnalisePorSetorClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstAnalisePorRuaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure TabRelVolumesShow(Sender: TObject);
    procedure LstVolumeConsultaClick(Sender: TObject);
    procedure EdtZonaId_VolumeExit(Sender: TObject);
    procedure BtnPesqZonaVolumeClick(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
    procedure TabAnalisePorLojaShow(Sender: TObject);
    procedure TabAnalisePorRotaShow(Sender: TObject);
    procedure TabAnalisePorRuaShow(Sender: TObject);
    procedure TabAnalisePorSetorShow(Sender: TObject);
    procedure TabVolumeResumoShow(Sender: TObject);
  private
    { Private declarations }
    ClickCellVolume : Boolean;
    vCodProduto, vCodProdutoVolume : Integer;
    Procedure MontaListaPedido(pJsonArray : TJsonArray);
    Procedure MontaListaPedidoResumo(pJsonArray : TJsonArray);
    Procedure MontaListaVolume(pJsonArray : TJsonArray);
    Procedure MontaListaVolumeProdutos(Sender : TObject; pJsonArray : TJsonArray);
    Procedure MontaListaHistoricoVolume(Sender : TObject; pPedidoVolumeId : Integer);
    Procedure CancelarPedido(pPedidoId : Integer);
    procedure BuscarVolumeClick(Sender : TObject; aRow, aCol: Integer);
    Procedure GetListaVolume(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pEmbalagem : String = 'T');
    procedure MontaListaPedidoProcesso(pPedidoId: Integer);
    Procedure PesquisarVolumes;
    Procedure MontaListaAnalisePorLoja(pJsonObjectRetorno : TJsonObject);
    Procedure MontaListaAnalisePorRota(pJsonObjectRetorno : TJsonObject);
    Procedure MontaListaAnalisePorSetor(pJsonObjectRetorno : TJsonObject);
    Procedure MontaListaAnalisePorRua(pJsonObjectRetorno : TJsonObject);
    procedure HeaderLstAnalisePorLoja;
    procedure HeaderLstAnalisePorRota;
    procedure HeaderLstAnalisePorSetor;
    procedure HeaderLstAnalisePorRua;
    Procedure HeaderLstVolumeConsulta;
    procedure TotalizarLstAnalise(Sender : TObject);
    procedure TotalizarLstAnalisePorRua;
    Procedure TotalizarLstVolumeConsulta;
    Procedure LimparConsultaVolumes(Sender: TObject);
    Procedure MontaListaVolumeConsulta(pJsonArrayRetorno : TJsonArray);
    Procedure ReimpressaoTAGVolume(pPedidoVolumeId, pTipoEmbalagem : Integer);   //pTipoEmbalagem 0-Fechada 1-Fracionado
    Procedure GetRelVolumeLotes;
    Procedure GetVolumeExportarExcel;
    Procedure AtualizarStatusPedido(pPedidoId : Integer);
    Procedure PosicionarPedido(pPedidoId : Integer);
  public
    { Public declarations }
  end;

var
  FrmRelPedidos: TFrmRelPedidos;

implementation

{$R *.dfm}

uses uFuncoes, RotaCtrl, PessoaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas,
  uFrmeXactWMS, Views.Pequisa.Processos, ProcessoCtrl, uFrmRelResumoPedidos, Views.Pequisa.Produtos,
  ProdutoCtrl, EnderecoCtrl, EnderecamentoZonaCtrl, Views.Pequisa.EnderecamentoZonas,
  uFrmPrintTAG, uFrmRelVolumeConsulta;

procedure TFrmRelPedidos.AtualizarStatusPedido(pPedidoId: Integer);
Var ObjPedidoCtrl : TPedidoSaidaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  Try
    ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
    JsonArrayRetorno := ObjPedidoCtrl.AtualizarProcesso(pPedidoId);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       JsonArrayRetorno := Nil;
       FreeAndNil(ObjPedidoCtrl);
       ShowErro('Erro: '+vErro);
    End
    Else Begin
       JsonArrayRetorno := Nil;
       FreeAndNil(ObjPedidoCtrl);
       ShowOk('manutenção realizada com sucesso');
       BtnPesquisarStandClick(BtnPesquisarStand);
       PosicionarPedido(pPedidoId);
    End;
  Except On E: Exception do
    ShowErro('Erro: '+E.Message);
  End;
end;

procedure TFrmRelPedidos.BtnExportarStandClick(Sender: TObject);
begin
  If BtnExportarStand.Grayed then Exit;
  if PgcBase.ActivePage = TabRelVolumes then Begin//Analitico
     if PgcVolumesGeral.ActivePage = TabVolumeResumo then Begin
        GetVolumeExportarExcel;
        if (Not FdMemVolumeExcel.Active) or (FdMemVolumeExcel.IsEmpty) then
           raise Exception.Create('Não há dados de Volume(s) para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FdMemVolumeExcel, 'Volumes');
        Except On E: Exception do
          ShowErro('Erro: '+E.message);
        End;
     End
     Else if PgcVolumesGeral.ActivePage = TabAnalisePorRua then Begin
        if (Not FDMemAnalisePorRua.Active) or (FDMemAnalisePorRua.IsEmpty) then
           raise Exception.Create('Não há dados para exportar!');
        if (BtnExportarStand.Grayed) then Exit;
        Try
          ExportarExcel(FDMemAnalisePorRua);
        Except On E: Exception do
          ShowErro('Erro: '+E.message);
        End;
     End;
     Exit;
  End;
  inherited;
end;

procedure TFrmRelPedidos.BtnImprimirStandClick(Sender: TObject);
Var vVolumePendente : Integer;
    vErro           : String;
    JsonArrayRetorno    : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    pEmbalagem          : String;
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then Begin
     With TFrmRelResumoPedidos.Create(Self) do
       Try
         If FdMemPesqGeral.Active then
            FdMemPesqGeral.EmptyDataSet;
         FdMemPesqGeral.Close;
         //https://www.youtube.com/watch?v=z4t7BiQVnQ0
         if PgcPedidos.ActivePageIndex = 0 then Begin
            FdMemPesqGeral.CopyDataSet(FrmRelPedidos.FdMemPesqGeral, [coStructure, coAppend]);
            ImprimirRelatorios;
         End
         Else Begin
            FDMemPedidoResumoAtendimento.CopyDataSet(FrmRelPedidos.FdMemPesqPedidoResumoAtendimento, [coStructure, coAppend]);
            if FDMemPedidoResumoAtendimento.IsEmpty then
               raise Exception.Create('Não há dados para gerar o relatório.');
            FrxPedidoResumoAtendimento.ShowReport;
         End;
       Finally
         Free;
       end;
  End
  Else if PgcBase.ActivePage = TabRelVolumes then Begin
     if PgcVolumesGeral.ActivePage = TabVolumeResumo then Begin
        With TFrmRelVolumeConsulta.Create(Self) do
          Try
            If FdMemPesqGeral.Active then
               FdMemPesqGeral.EmptyDataSet;
            FdMemPesqGeral.Close;
            //https://www.youtube.com/watch?v=z4t7BiQVnQ0
            FdMemPesqGeral.CopyDataSet(FrmRelPedidos.FDMemVolumeConsulta, [coStructure, coAppend]);
            if ChkvolumePendente.Checked then
               vVolumePendente := 1
            Else
               vVolumePendente := 0;
            case CbEmbalagem.ItemIndex Of
               0: pEmbalagem := 'T';
               1: pEmbalagem := 'F';
               2: pEmbalagem := 'B';
            end;
            JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeConsultaLotes(EdtDtPedidoInicial_AnalRua.Date, EdtDtPedidoFinal_AnalRua.Date, StrToIntDef(EdtPedido_AnalRua.Text, 0),
                                                    StrToIntDef(EdtPedidoVolumeId.Text, 0), EdtDocumentoNr_AnalRua.Text, 0, StrToIntDef(EdtDestinatario_AnalRua.Text, 0),
                                                    StrToIntDef(EdtProcessoId_AnalRua.Text, 0), StrToIntDef(EdtRotaId_AnalRua.Text, 0), vCodProdutoVolume,
                                                    StrToIntDef(EdtZonaId_Volume.Text, 0), vVolumePendente, pEmbalagem);
            if JsonArrayRetorno.Items[0].tryGetValue<String>('MSG', vErro) then Begin
               LstVolumeConsulta.ClearRect(0, 1, LstVolumeConsulta.ColCount-1, LstVolumeConsulta.RowCount-1);
               LstVolumeConsulta.RowCount := 1;
               ShowMSG(vErro);
            End
            Else if JsonArrayRetorno.Items[0].tryGetValue<String>('Erro', vErro) then Begin
               LstVolumeConsulta.ClearRect(0, 1, LstVolumeConsulta.ColCount-1, LstVolumeConsulta.RowCount-1);
               LstVolumeConsulta.RowCount := 1;
               ShowErro('Erro: '+vErro);
            End
            Else Begin
               If FrmRelPedidos.FDMemVolumeConsultaLotes.Active then
                  FrmRelPedidos.FDMemVolumeConsultaLotes.EmptyDataSet;
               FrmRelPedidos.FDMemVolumeConsultaLotes.Close;
               FrmRelPedidos.FDMemVolumeConsultaLotes.LoadFromJSON(JsonArrayRetorno, False);
               FDMemLotes.CopyDataSet(FrmRelPedidos.FDMemVolumeConsultaLotes, [coStructure, coAppend]);
               FrxReport1.ShowReport;
            End;
          Finally
            JsonArrayRetorno := nil;
            FreeAndNil(ObjPedidoVolumeCtrl);
            Free;
          end;
     End;
  End;
end;

procedure TFrmRelPedidos.BtnPesqClienteClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if ((Sender=BtnPesqCliente) and (EdtDestinatario.ReadOnly)) or
     ((Sender=BtnPesqDestinatarioVolume_Consulta) and (EdtDestinatario_AnalRua.ReadOnly))  then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       if (Sender=BtnPesqCliente) Then Begin
          EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
          EdtDestinatarioExit(EdtDestinatario);
       End
       Else Begin
          EdtDestinatario_AnalRua.Text := FrmPesquisaPessoas.Tag.ToString;
          EdtDestinatarioExit(EdtDestinatario_AnalRua);
       End;
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmRelPedidos.BtnPesqProcessoClick(Sender: TObject);
begin
  inherited;
  if ((Sender=BtnPesqProcesso) and (EdtProcessoId.ReadOnly)) or
     ((Sender=BtnProcesso_Consulta) and (EdtProcessoId_AnalRua.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaProcessos := TFrmPesquisaProcessos.Create(Application);
  try
    if (FrmPesquisaProcessos.ShowModal = mrOk) then Begin
       if Sender = BtnProcesso_Consulta then Begin
          EdtProcessoId_AnalRua.Text := FrmPesquisaProcessos.Tag.ToString;
          EdtProcessoIdExit(EdtProcessoId_AnalRua);
       End
       Else Begin
          EdtProcessoId.Text := FrmPesquisaProcessos.Tag.ToString;
          EdtProcessoIdExit(EdtProcessoId);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaProcessos);
  end;
end;

procedure TFrmRelPedidos.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       if Sender = BtnPesqProduto then Begin
          EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
          EdtCodProdutoExit(EdtCodproduto);
       End
       Else Begin
          EdtCodProduto_AnalRua.Text := FrmPesquisaProduto.Tag.ToString();
          EdtCodProdutoExit(EdtCodProduto_AnalRua);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelPedidos.BtnPesqRotaClick(Sender: TObject);
begin
  if ((Sender=BtnPesqRota) and (EdtRotaId.ReadOnly)) or
     ((Sender=BtnPesqRotaVolume_Consulta) and (EdtRotaId_AnalRua.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       if (Sender=BtnPesqRota) then Begin
          EdtRotaId.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaIdExit(EdtRotaId);
       End
       Else Begin
          EdtRotaId_AnalRua.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaIdExit(EdtRotaId_AnalRua);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmRelPedidos.BtnPesquisarStandClick(Sender: TObject);
Var vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vRecebido, vCubagem, vEtiqueta, vPedidoPendente : Integer;
    JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
begin
  if PgcBase.ActivePage = TabRelVolumes then Begin
     PesquisarVolumes;
     Exit;
  End;
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
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
  if (vDtInicio=0) and (vDtFinal=0) and (EdtPedidoId.Text='') and (EdtDocumentoNr.Text='') and
     (EdtRotaId.Text='') and (EdtCodProduto.text='') and (EdtDestinatario.Text='') and
     (EdtProcessoId.Text='') And (EdtNotaFiscalERP.Text='') then Begin
     ShowErro('Informe o filtro para a pesquisa!');
     Exit;
  End;
  if (EdtPedidoid.Text<>'') and (StrToIntDef(EdtPedidoId.Text, 0)<=0) then Begin
     ShowErro('Id do Pedido inválido!');
     Exit;
  End;
  if (EdtRotaid.Text<>'') and (StrToIntDef(EdtRotaId.Text, 0)<=0) then Begin
     ShowErro('Id da Rota inválido!');
     Exit;
  End;
  if (EdtDestinatario.Text<>'') and (StrToIntDef(EdtDestinatario.Text, 0)<=0) then Begin
     ShowErro('Id do Destinatário inválido!');
     Exit;
  End;
  if (EdtProcessoId.Text<>'') and (StrToIntDef(EdtProcessoId.Text, 0)<=0) then Begin
     ShowErro('Id do Processo inválido!');
     Exit;
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  PgcPedidos.ActivePage := TabPedidos;
  TDialogMessage.ShowWaitMessage('👨‍💼'+'Aguarde! Estou trabalhando para buscar os dados...',
    procedure
    begin
      if ChkpedidoPendente.Checked then
         vPedidoPendente := 1
      else vPedidoPendente := 0;
      ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
      JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(StrToInt64Def(EdtPedidoId.Text, 0), StrToInt64Def(EdtDestinatario.Text, 0), 0, vDtInicio, vDtFInal,
                                                        EdtDocumentoNr.Text, '', '', StrToInt64Def(EdtRotaId.Text, 0), StrToInt64Def(EdtRotaId.Text, 0), 0, StrToInt64Def(EdtProcessoId.Text, 0),
                                                        1, 1, 1, False, 2, vCodProduto, vPedidoPendente, 0, EdtNotaFiscalERP.Text, 2, 2);
      if JsonArrayRetorno.items[0].tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
         LstPedidosAdv.RowCount := 1;
         //JsonArrayRetorno := Nil;
         //ObjPedidoCtrl.Free;
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        MontaListaPedido(JsonArrayRetorno);
        FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
      End;
      JsonArrayRetorno := Nil;
      ObjPedidoCtrl.Free;
    End);
end;

procedure TFrmRelPedidos.BtnPesqZonaVolumeClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    ObjPessoaCtrl   : TPessoaCtrl;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId_Volume.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
       EdtZonaId_VolumeExit(EdtZonaId_Volume);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelPedidos.CancelarPedido(pPedidoId : Integer);
Var JsonPedidoCancelar : TJsonObject;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayCancelar   : TJsonArray;
    vErro : String;
begin
  If Confirmacao('Cancelamento', 'Cancelar o Pedido: '+pPedidoId.ToString()+'?', True) Then Begin
     JsonPedidoCancelar := TJsonObject.Create();
     JsonPedidoCancelar.AddPair('pedidoId', TJsonNumber.Create(pPedidoId));
     JsonPedidoCancelar.AddPair('pedidoVolumeId', TJsonNumber.Create(0));
     JsonPedidoCancelar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
     JsonPedidoCancelar.AddPair('terminal', NomeDoComputador);
     ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
     Try
       JsonArrayCancelar := ObjPedidoVolumeCtrl.CancelarVolume(JsonPedidoCancelar);
       If JsonArrayCancelar.Items[0].TryGetValue('Erro', vErro) then
          ShowErro('Erro: '+vErro)
       Else Begin
//          LstPedidosAdv.Cells[24, LstPedidosAdv.Row] := '3';
          LstPedidosAdv.AddDataImage(25, LstPedidosAdv.Row, 3, TCellHAlign.haCenter, TCellVAlign.vaTop);
          LstPedidosAdv.Cells[25, LstPedidosAdv.Row] := '3';
          LstPedidosAdv.Cells[ 5, LstPedidosAdv.Row] := 'Cancelado';
          LstPedidosAdv.Colors[5, LstPedidosAdv.Row] := ClRed;
          Player('toast');
       End;
     Except
     End;
     JsonPedidoCancelar.Free;
     ObjPedidoVolumeCtrl.Free;
  End;
end;

procedure TFrmRelPedidos.ChkPedidoPendenteClick(Sender: TObject);
begin
  inherited;
  if ChkPedidoPendente.Checked then
     EdtProcessoId.Clear;
end;

procedure TFrmRelPedidos.ChkResumoPorVolumeClick(Sender: TObject);
begin
  inherited;
  if (Sender = ChkResumoPorVolume) then Begin
     if ChkResumoPorVolume.Checked then Begin
        ChkAnalisePorSetor.Checked := False;
        ChkAnalisePorRua.Checked   := False;
        ChkAnalisePorRota.Checked  := False;
        ChkAnalisePorLoja.Checked  := False;
     End;
  End
  Else if (Sender <> ChkResumoPorVolume) and (TCheckBox(Sender).Checked) then
    ChkResumoPorVolume.Checked  := False;
  GbVolumeConsulta.Visible      := ChkResumoPorVolume.Checked;
  TabVolumeResumo.TabVisible    := ChkResumoPorVolume.Checked;
  TabAnalisePorLoja.TabVisible  := ChkAnalisePorLoja.Checked;
  TabAnalisePorRota.TabVisible  := ChkAnalisePorRota.Checked;
  TabAnalisePorSetor.TabVisible := ChkAnalisePorSetor.Checked;
  TabAnalisePorRua.TabVisible   := ChkAnalisePorRua.Checked;

  If TabVolumeResumo.TabVisible    then TabAnalisePorRua.Show;
  if TabAnalisePorLoja.TabVisible  then TabAnalisePorLoja.Show;
  if TabAnalisePorRota.TabVisible  then TabAnalisePorRota.Show;
  if TabAnalisePorSetor.TabVisible then TabAnalisePorSetor.Show;
  if TabAnalisePorRua.TabVisible   then TabAnalisePorRua.Show;

  if TabVolumeResumo.TabVisible         then PgcVolumesGeral.ActivePage := TabVolumeResumo
  Else if TabAnalisePorSetor.TabVisible then PgcVolumesGeral.ActivePage := TabAnalisePorSetor
  Else if TabAnalisePorRua.TabVisible   then PgcVolumesGeral.ActivePage := TabAnalisePorRua
  Else if TabAnalisePorRota.TabVisible  then PgcVolumesGeral.ActivePage := TabAnalisePorRota
  Else if TabAnalisePorLoja.TabVisible  then PgcVolumesGeral.ActivePage := TabAnalisePorLoja;
  LimparConsultaVolumes(Sender);
end;

procedure TFrmRelPedidos.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if StrToInt64Def(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Código do produto('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(TEdit(Sender).Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if Sender = EdtCodproduto then
     vCodProduto := JsonProduto.GetValue<Integer>('codproduto')
  Else
     vCodProdutoVOlume := JsonProduto.GetValue<Integer>('codproduto');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+TEdit(Sender).Text+') não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else Begin
     if Sender = EdtCodProduto then
        LblProduto.Caption := JsonProduto.GetValue<String>('descricao')
     Else
        LblProdutoConsulta.Caption := JsonProduto.GetValue<String>('descricao');
  End;
  JsonProduto := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelPedidos.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(TEdit(Sender).text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     if Sender = EdtDestinatario then
        LblDestinatario.Caption := ''
     Else
        LblDestinatarioVolume_Consulta.Caption := '';
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     if Sender = EdtDestinatario then
        LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia')
     Else
        LblDestinatarioVolume_Consulta.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia');
  End;
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelPedidos.EdtDtPedidoInicial_AnalRuaChange(Sender: TObject);
begin
  inherited;
  LimparConsultaVolumes(Sender);
end;

procedure TFrmRelPedidos.EdtInicioChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtRotaId then
     LblRota.Caption := ''
  Else If Sender = EdtDestinatario Then
     LblDestinatario.Caption := ''
  Else If Sender = EdtProcessoId Then
     LblProcesso.Caption   := ''
  Else if Sender = EdtCodProduto then begin
    LblProduto.Caption := '';
    vCodProduto        := 0;
  End;
  LblRegistro.caption      := '';
  LblItens.Caption         := '';
  LblDemanda.Caption       := '';
  LblPerda.Caption         := '';
  LblPercPerda.Caption     := '';
  LblNProcessado.Caption   := '';
  LblProcessado.Caption    := '';
  LblConcluido.Caption     := '';
  LblPercNProc.Caption     := '';
  LblPercProc.Caption      := '';
  LblPercConcluido.Caption := '';
  LstPedidosAdv.RowCount        := 1;
  LstPedidoResumoAdv.RowCount   := 1;
  LstVolumesAdv.RowCount        := 1;
  LstVolumeProdutosAdv.RowCount := 1;
  LstVolumeEtapas.RowCount      := 1;
  LblProduto.Caption            := '';
  ImprimirExportar(False);
end;

procedure TFrmRelPedidos.EdtPedidoIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #13) and (TEdit(Sender).Text<> '') then Begin
     if ((Sender=EdtPedidoId) or (Sender=EdtPedido_AnalRua)) and (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
        TEdit(Sender).SetFocus;
        ShowErro('Id de Pedido inválido!');
        Exit;
     End
     Else if (Sender=EdtPedidoVolumeId) and (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
        TEdit(Sender).SetFocus;
        ShowErro('Id de Volume inválido!');
        Exit;
     End;
     if Sender = EdtPedidoId then
        BtnPesquisarStandClick(Sender)
     Else If Sender = EdtPedidoVolumeId Then
        PesquisarVolumes;
  End;
  SoNumeros(Key);
end;

procedure TFrmRelPedidos.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Processo('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(TEdit(Sender).text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     If Sender = EdtPRocessoId then
        LblProcesso.Caption := ''
     Else LblProcessoVolume.Caption := '';
     ShowErro( '😢Processo não('+TEdit(Sender).Text+') encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     if Sender = EdtProcessoId then Begin
        LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
        ChkPedidoPendente.Checked := False;
     End
     Else Begin
        LblProcessoVolume.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
        ChkVolumePendente.Checked := False;
     End;
  End;
  JsonArrayRetorno := Nil;
  ObjProcessoCtrl  := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelPedidos.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     if Sender = EdtRotaId then
        LblRota.Caption := ''
     Else
        LblRotaVolume_Consulta.Caption := '';
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     if Sender = EdtRotaId then
        LblRota.Caption := ''
     Else LblRotaVolume_Consulta.Caption := '';
     ShowErro( '😢Rota('+TEdit(Sender).Text+') inválida!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     if Sender = EdtRotaId then  Begin
        LblRota.Caption := '';
     End
     Else
        LblRotaVolume_Consulta.Caption := '';
     ShowErro('Erro: Zona/Setor não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     if Sender = EdtRotaId then
        LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao
     Else
        LblRotaVolume_Consulta.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  End;
//  ReturnLstRota.Free;
  ObjRotaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelPedidos.EdtZonaId_VolumeExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblZonaVolume.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblZonaVolume.Caption := '';
     ShowErro( '😢Código de Zona('+TEdit(Sender).Text+') inválido!' );
     ExitFocus(Sender);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  JsonArrayZona := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(TEdit(Sender).Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Erro : '+vErro);
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     ExitFocus(Sender);
  End
  Else
     LblZonaVolume.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonArrayZona := Nil;
  FreeAndNil(ObjEnderecamentoZonaCtrl);
end;

procedure TFrmRelPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRelPedidos := Nil;
end;

procedure TFrmRelPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  vCodProdutoVolume := 0;
  TabListagem.TabVisible := False;
  LstPedidosAdv.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstPedidosAdv.ColWidths[1]  :=  75+Trunc(75*ResponsivoVideo);
  LstPedidosAdv.ColWidths[2]  :=  70+Trunc(70*ResponsivoVideo);
  LstPedidosAdv.ColWidths[3]  :=  75+Trunc(75*ResponsivoVideo);
  LstPedidosAdv.ColWidths[4]  := 280+Trunc(280*ResponsivoVideo);
  LstPedidosAdv.ColWidths[5]  := 160+Trunc(160*ResponsivoVideo);
  LstPedidosAdv.ColWidths[6]  :=  75+Trunc(75*ResponsivoVideo); //Dt.Processo
  LstPedidosAdv.ColWidths[7]  :=  50+Trunc(50*ResponsivoVideo);
  LstPedidosAdv.ColWidths[8]  :=  40+Trunc(40*ResponsivoVideo);
  LstPedidosAdv.ColWidths[9]  :=  70+Trunc(70*ResponsivoVideo);
  LstPedidosAdv.ColWidths[10] :=  80+Trunc(80*ResponsivoVideo);
  LstPedidosAdv.ColWidths[11] :=  60+Trunc(60*ResponsivoVideo);
  LstPedidosAdv.ColWidths[12] :=  80+Trunc(80*ResponsivoVideo);
  LstPedidosAdv.ColWidths[13] :=  85+Trunc(85*ResponsivoVideo);
  LstPedidosAdv.ColWidths[14] :=  70+Trunc(70*ResponsivoVideo);
  LstPedidosAdv.ColWidths[15] :=  80+Trunc(80*ResponsivoVideo);
  LstPedidosAdv.ColWidths[16] :=  80+Trunc(80*ResponsivoVideo);
  LstPedidosAdv.ColWidths[17] :=  85+Trunc(85*ResponsivoVideo);
  LstPedidosAdv.ColWidths[18] :=  80+Trunc(80*ResponsivoVideo);
  LstPedidosAdv.ColWidths[19] := 100+Trunc(100*ResponsivoVideo);
  LstPedidosAdv.ColWidths[20] := 150+Trunc(150*ResponsivoVideo);
  LstPedidosAdv.ColWidths[21] :=  60+Trunc(60*ResponsivoVideo);
  LstPedidosAdv.ColWidths[22] := 120+Trunc(120*ResponsivoVideo);
  LstPedidosAdv.ColWidths[23] :=  60+Trunc(60*ResponsivoVideo);
  LstPedidosAdv.ColWidths[24] :=  70+Trunc(70*ResponsivoVideo);
  LstPedidosAdv.ColWidths[25] :=  40+Trunc(40*ResponsivoVideo);
  LstPedidosAdv.ColWidths[26] :=  40+Trunc(40*ResponsivoVideo);
//  if LstPedidosAdv.ColCount = 27 then
     LstPedidosAdv.ColWidths[27] := 250+Trunc(250*ResponsivoVideo);
  LstPedidosAdv.Alignments[0, 0]  := taRightJustify;
  LstPedidosAdv.FontStyles[0, 0]  := [FsBold];
  LstPedidosAdv.Alignments[1, 0]  := taCenter;
  LstPedidosAdv.Alignments[7, 0]  := taCenter;
  LstPedidosAdv.Alignments[8, 0]  := taRightJustify;
  LstPedidosAdv.Alignments[9, 0]  := taRightJustify;
  LstPedidosAdv.Alignments[10, 0]  := taRightJustify;
  LstPedidosAdv.Alignments[11, 0] := taRightJustify;
  LstPedidosAdv.Alignments[12, 0] := taRightJustify;
  LstPedidosAdv.Alignments[13, 0] := taRightJustify;
  LstPedidosAdv.Alignments[14, 0] := taRightJustify;
  LstPedidosAdv.Alignments[15, 0] := taRightJustify;
  LstPedidosAdv.Alignments[16, 0] := taRightJustify;
  LstPedidosAdv.Alignments[19, 0] := taRightJustify;
  LstPedidosAdv.Alignments[21, 0] := taRightJustify;
  LstPedidosAdv.Alignments[23, 0] := taRightJustify;
  LstPedidosAdv.Alignments[24, 0] := tacenter;
  LstPedidosAdv.Alignments[26, 0] := tacenter;
  LstPedidosAdv.HideColumn(23);
{  if LstPedidosAdv.ColCount = 27 then
     LstPedidosAdv.HideColumn(26);
}  PgcPedidos.ActivePage := TabPedidos;
  LStPedidosAdv.RowCount := 1;
  //Volumes do Pedido
  LstVolumesAdv.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
  LstVolumesAdv.ColWidths[1] :=  60+Trunc(60*ResponsivoVideo);
  LstVolumesAdv.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
  LstVolumesAdv.ColWidths[3] := 160+Trunc(160*ResponsivoVideo);
  LstVolumesAdv.ColWidths[4] := 40+Trunc(40*ResponsivoVideo);
  LstVolumesAdv.ColWidths[5] := 40+Trunc(40*ResponsivoVideo);
  LstVolumesAdv.ColWidths[6] := 70+Trunc(70*ResponsivoVideo);
  LstVolumesAdv.ColWidths[7] := 120+Trunc(120*ResponsivoVideo);
  LstVolumesAdv.ColWidths[8] :=  40+Trunc(40*ResponsivoVideo);
  LstVolumesAdv.ColWidths[9] :=  40+Trunc(40*ResponsivoVideo);
  LstVolumesAdv.ColWidths[10] := 40+Trunc(40*ResponsivoVideo);
  LstVolumesAdv.Alignments[ 0, 0] := taRightJustify;
  LstVolumesAdv.FontStyles[ 0, 0] := [FsBold];
  LstVolumesAdv.Alignments[ 1, 0] := taRightJustify;
  LstVolumesAdv.FontStyles[ 4, 0] := [FsBold];
  LstVolumesAdv.Alignments[ 5, 0] := taRightJustify;
  LstVolumesAdv.Alignments[ 6, 0] := taRightJustify;
  LstVolumesAdv.Alignments[ 8, 0] := taCenter;
  LstVolumesAdv.Alignments[ 9, 0] := taCenter;
  LstVolumesAdv.Alignments[10, 0] := taCenter;
  LstVolumesAdv.HideColumn(3);
  LstVolumesAdv.HideColumn(5);
  LstVolumesAdv.HideColumn(11);
  LstVolumesAdv.width := (100+Trunc(100*ResponsivoVideo))+
                         (60+Trunc(60*ResponsivoVideo))+
                         (180+Trunc(180*ResponsivoVideo))+
                         //(160+Trunc(160*ResponsivoVideo))+
                         (40+Trunc(40*ResponsivoVideo))+
                         //(40+Trunc(40*ResponsivoVideo))+
                         (70+Trunc(70*ResponsivoVideo))+
                         (120+Trunc(120*ResponsivoVideo))+
                         (40+Trunc(40*ResponsivoVideo))+
                         (40+Trunc(40*ResponsivoVideo))+
                         (40+Trunc(40*ResponsivoVideo))+20;
  //Resumo Atendimento do Pedido
  LstPedidoResumoAdv.ColWidths[0] := 80+Trunc(80*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[1] := 60+Trunc(60*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[2] := 250+Trunc(250*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[3] := 120+Trunc(120*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[4] := 200+Trunc(200*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[5] := 70+Trunc(70*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[6] := 90+Trunc(90*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[7] := 70+Trunc(70*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[8] := 70+Trunc(70*ResponsivoVideo);
  LstPedidoResumoAdv.ColWidths[9] := 70+Trunc(70*ResponsivoVideo);
  LstPedidoResumoAdv.Alignments[0, 0] := taRightJustify;
  LstPedidoResumoAdv.FontStyles[0, 0] := [FsBold];
  LstPedidoResumoAdv.Alignments[5, 0] := taRightJustify;
  LstPedidoResumoAdv.Alignments[7, 0] := taRightJustify;
  LstPedidoResumoAdv.Alignments[8, 0] := taRightJustify;
  LstPedidoResumoAdv.Alignments[9, 0] := taRightJustify;

  //Produtos do Volume
  LstVolumeProdutosAdv.ColWidths[0]  :=  75+Trunc(75*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[1]  := 150+Trunc(150*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[2]  := 100+Trunc(100*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[3]  :=  80+Trunc(80*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[4]  :=  90+Trunc(90*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[5]  := 120+Trunc(120*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[6]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[7]  :=  80+Trunc(80*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[8]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[9]  :=  90+Trunc(90*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[10]  := 120+Trunc(120*ResponsivoVideo);
  LstVolumeProdutosAdv.ColWidths[11] := 130+Trunc(130*ResponsivoVideo);//80;
  LstVolumeProdutosAdv.ColWidths[12] := 150+Trunc(150*ResponsivoVideo);//80;
  LstVolumeProdutosAdv.Alignments[0, 0] := taRightJustify;
  LstVolumeProdutosAdv.FontStyles[0, 0] := [FsBold];
  LstVolumeProdutosAdv.Alignments[3, 0] := taCenter;
  LstVolumeProdutosAdv.Alignments[4, 0] := taCenter;
  LstVolumeProdutosAdv.Alignments[6, 0] := taRightJustify;
  LstVolumeProdutosAdv.Alignments[7, 0] := taRightJustify;
  LstVolumeProdutosAdv.Alignments[8, 0] := taRightJustify;
  LstVolumeProdutosAdv.Alignments[9, 0] := taRightJustify;
  LstVolumeProdutosAdv.Alignments[11, 0] := taCenter;
  //LstVolumeEtapas.Left := LstVolumesAdv.Width+50;
  lstVolumeEtapas.ColWidths[0]     := 100+Trunc(100*ResponsivoVideo);
  lstVolumeEtapas.ColWidths[1]     :=  80+Trunc(80*ResponsivoVideo);
  lstVolumeEtapas.ColWidths[2]     :=  65+Trunc(65*ResponsivoVideo);
  lstVolumeEtapas.ColWidths[3]     := 130+Trunc(130*ResponsivoVideo);
  lstVolumeEtapas.ColWidths[4]     := 120+Trunc(120*ResponsivoVideo);
  lstVolumeEtapas.Alignments[1, 0] := taCenter;
  lstVolumeEtapas.Alignments[2, 0] := taCenter;
  
  LstPedidoProcesso.ColWidths[0]     := 100+Trunc(100*ResponsivoVideo);
  LstPedidoProcesso.ColWidths[1]     :=  80+Trunc(80*ResponsivoVideo);
  LstPedidoProcesso.ColWidths[2]     :=  65+Trunc(65*ResponsivoVideo);
  LstPedidoProcesso.ColWidths[3]     := 130+Trunc(130*ResponsivoVideo);
  LstPedidoProcesso.ColWidths[4]     := 120+Trunc(120*ResponsivoVideo);
  LstPedidoProcesso.Alignments[1, 0] := taCenter;
  LstPedidoProcesso.Alignments[2, 0] := taCenter;
  LstPedidoProcesso.RowCount         := 1;
  ChkResumoPorVolumeClick(ChkAnalisePorSetor);
  HeaderLstVolumeConsulta;
  HeaderLstAnalisePorLoja;
  HeaderLstAnalisePorRota;
  HeaderLstAnalisePorSetor;
  HeaderLstAnalisePorRua;
  ClickCellVolume := False;
end;

procedure TFrmRelPedidos.FormShow(Sender: TObject);
begin
  inherited;
  EdtInicio.SetFocus;
end;

procedure TFrmRelPedidos.GetListaVolume(pPedidoId, pPedidoVolumeId, pSequencia,
  pOrdem: Integer; pEmbalagem: String);
Var ReturnJsonArray     : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vErro : String;
begin
  ReturnJsonArray := ObjPedidoVolumeCtrl.GetVolume(StrToIntDef(LstPedidosAdv.Cells[0, LstPedidosAdv.Row], 0), 0, 0, 0);
  if ReturnJsonArray.Get(0).tryGetValue<String>('Erro', vErro) then Begin
     LstVolumesAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
     LstVolumesAdv.RowCount := 1;
  End
  Else Begin
     //LstPedidosAdv.Row := aRow;
     MontaListaVolume(ReturnJsonArray);
     if LstPedidosAdv.Cells[24, LstPedidosAdv.Row] = '3' then
        LstVolumesAdv.HideColumn(8)
     Else LstVolumesAdv.UnHideColumn(8);
     //LstVolumesAdvClickCell(LstVolumesAdv, 1,  0);
     //LstVolumesAdv.Col := 0;
     LstVolumesAdv.Row := 1;
     BuscarVolumeClick(LstVolumesAdv, 1, 0);
  End;
end;

procedure TFrmRelPedidos.GetRelVolumeLotes;
begin

end;

procedure TFrmRelPedidos.GetVolumeExportarExcel;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonObjectRetorno   : TJsonObject;
    vEstruturaId        : Integer;
    vVolumePendente     : Integer;
    vErro : String;
begin
  if (EdtDtPedidoInicial_AnalRua.Date = 0) and (EdtDtPedidoFinal_AnalRua.Date = 0) then Begin
     EdtDtPedidoInicial_AnalRua.SetFocus;
     ShowErro('Informe o Período para a pesquisa!');
     Exit;
  End;
  if (vCodProdutoVolume=0) and (EdtCodProduto_AnalRua.Text<>'') then  Begin
     EdtCodProduto_AnalRua.SetFocus;
     EdtCodProdutoExit(EdtCodProduto_AnalRua);
     Exit;
  End;
  if (not ChkResumoPorVolume.Checked) and (not ChkAnalisePorRua.Checked)  and (not ChkAnalisePorSetor.Checked)  and
     (not ChkAnalisePorRota.Checked) and (not ChkAnalisePorLoja.Checked) then Begin
     ShowErro('Selecione o(s) relatórios para gerar!');
     Exit;
  End;
  if (EdtPedido_AnalRua.Text<>'') and (StrToIntDef(EdtPedido_AnalRua.Text, 0)<=0) then Begin
     EdtPedido_AnalRua.SetFocus;
     ShowErro('Id('+EdtPedido_AnalRua.Text+')do Pedido inválido!');
     EdtPedidoVolumeId.Clear;
     Exit;
  End;
  if (EdtPedidoVolumeId.Text<>'') and (StrToIntDef(EdtPedidoVolumeId.Text, 0)<=0) then Begin
     EdtPedidoVolumeId.SetFocus;
     ShowErro('Id('+EdtPedidoVolumeId.Text+') do Volume inválido!');
     EdtPedidoVolumeId.Clear;
     Exit;
  End;
  if (EdtRotaId_AnalRua.Text<>'') and (StrToIntDef(EdtRotaId_AnalRua.Text, 0)<=0) then Begin
     EdtRotaId_AnalRua.SetFocus;
     ShowErro('Id('+EdtRotaId_AnalRua.Text+') da Rota inválido!');
     EdtRotaId_AnalRua.Clear;
     Exit;
  End;
  if (EdtDestinatario_AnalRua.Text<>'') and (StrToIntDef(EdtDestinatario_AnalRua.Text, 0)<=0) then Begin
     ShowErro('Id do Destinatário inválido!');
     Exit;
  End;
  if (EdtProcessoId_AnalRua.Text<>'') and (StrToIntDef(EdtProcessoId_AnalRua.Text, 0)<=0) then Begin
     EdtProcessoId_AnalRua.SetFocus;
     ShowErro('Id do Processo inválido!');
     EdtProcessoId_AnalRua.Clear;
     Exit;
  End;
  if (EdtCodProduto_AnalRua.Text<>'') and (StrToInt64Def(EdtCodProduto_AnalRua.Text, 0)<=0) then Begin
     EdtCodProduto_AnalRua.SetFocus;
     ShowErro('Id('+EdtCodProduto_AnalRua.Text+') do Processo inválido!');
     EdtCodProduto_AnalRua.Clear;
     Exit;
  End;
  if (EdtDtPedidoInicial_AnalRua.Date = 0) and (EdtDtPedidoFinal_AnalRua.Date = 0) and (StrToIntDef(EdtPedido_AnalRua.Text, 0) = 0) and
     (StrToIntDef(EdtPedidoVolumeId.Text, 0) = 0) and (EdtDocumentoNr_AnalRua.Text='') and (StrToIntDef(EdtDestinatario_AnalRua.Text, 0) = 0) and
     (StrToIntDef(EdtProcessoId_AnalRua.Text, 0) = 0) and (StrToIntDef(EdtRotaId_AnalRua.Text, 0) = 0) and (StrToInt64Def(EdtCodProduto_AnalRua.Text, 0) = 0) then Begin
     ShowErro('Informe o filtro para a pesquisa!');
     Exit;
  End;
  if ((ChkPulmao.Checked) and (ChkPicking.Checked)) or
     ((Not ChkPulmao.Checked) and (Not ChkPicking.Checked)) then
     vEstruturaId := 0
  Else if (ChkPulmao.Checked) then
     vEstruturaId := 1
  Else if (ChkPicking.Checked) then
     vEstruturaId := 2;
  if ChkvolumePendente.Checked then
     vVolumePendente := 1
  Else
     vVolumePendente := 0;
  TDialogMessage.ShowWaitMessage('👨‍💼'+'Aguarde!!! Estou coletando as informações...',
    procedure
    Var JsonArrayRetorno    : TJsonArray;
        ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
        pEmbalagem : String;
        vErro      : String;
    begin
      If FDMemVolumeExcel.Active then
         FDMemVolumeExcel.EmptyDataSet;
      FDMemVolumeExcel.Close;
      case CbEmbalagem.ItemIndex Of
        0: pEmbalagem := 'T';
        1: pEmbalagem := 'F';
        2: pEmbalagem := 'B';
      end;
      JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeExcel(EdtDtPedidoInicial_AnalRua.Date, EdtDtPedidoFinal_AnalRua.Date,
                     StrToIntDef(EdtPedido_AnalRua.Text, 0), StrToIntDef(EdtPedidoVolumeId.Text, 0),
                     EdtDocumentoNr_AnalRua.Text, 0, StrToIntDef(EdtDestinatario_AnalRua.Text, 0),
                     StrToIntDef(EdtProcessoId_AnalRua.Text, 0), StrToIntDef(EdtRotaId_AnalRua.Text, 0),
                     vCodProdutoVolume, StrToIntDef(EdtZonaId_Volume.Text, 0), vVolumePendente, pEmbalagem);
      if JsonArrayRetorno.Items[0].tryGetValue<String>('MSG', vErro) then Begin
         ShowMSG(vErro);
      End
      Else if JsonArrayRetorno.Items[0].tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('Erro: '+vErro);
      End
      Else
         FDMemVolumeExcel.LoadFromJSON(JsonArrayRetorno, False);
    End);
end;

procedure TFrmRelPedidos.LimparConsultaVolumes(Sender: TObject);
begin
  if Sender = EdtRotaId_AnalRua then
     LblRotaVolume_Consulta.Caption := ''
  Else If Sender = EdtDestinatario_AnalRua then
     LblDestinatarioVolume_Consulta.Caption := ''
  Else If Sender = EdtProcessoId_AnalRua then
     LblProcessoVolume.Caption := ''
  Else If Sender = EdtZonaId_Volume then
     LblZonaVolume.Caption := ''
  Else If Sender = EdtCodProduto_AnalRua then Begin
     LblProdutoConsulta.Caption := '';
     vCodProdutoVolume := 0;
  End;
  If FDMemAnalisePorRua.Active then
     FDMemAnalisePorRua.EmptyDataSet;
  FDMemAnalisePorRua.Close;
  If FDMemAnalisePorLoja.Active then
     FDMemAnalisePorLoja.EmptyDataSet;
  FDMemAnalisePorLoja.Close;
  If FDMemAnalisePorRota.Active then
     FDMemAnalisePorRota.EmptyDataSet;
  FDMemAnalisePorRota.Close;
  If FDMemAnalisePorSetor.Active then
     FDMemAnalisePorSetor.EmptyDataSet;
  FDMemAnalisePorSetor.Close;
  LstVolumeConsulta.RowCount          := 1;
  LstVolumeProdutosConsulta.RowCount  := 1;
  LstVolumeHistoricoConsulta.RowCount := 1;
  LstAnalisePorRua.RowCount           := 1;
  LstAnalisePorSetor.RowCount         := 1;
  LblTotPedido_AnalisePorRua.Caption           := '0';
  LblTotVolumeCxaFechada_AnalisePorRua.Caption := '0';
  LblTotVolumeFracionado_AnalisePorRua.Caption := '0';
  LblTotVolume_AnalisePorRua.Caption           := '0';
  LblTotPedido_AnalisePorSetor.Caption           := '0';
  LblTotVolumeCxaFechada_AnalisePorSetor.Caption := '0';
  LblTotVolumeFracionado_AnalisePorSetor.Caption := '0';
  LblTotVolume_AnalisePorRua.Caption             := '0';
  ImprimirExportar(False);
  LblTotVolume.Caption                  := '0';
  LblTotVolumePendente.Caption          := '0';
  LblTotVolumeExpedido.Caption          := '0';
  LblTotVolumeExpedidoPerc.Caption      := '0.00%';
  LblTotVolumeCancelado.Caption         := '0';
  LblTotVolumeCanceladoPerc.Caption     := '0.00%';
  LblTotVolumeCxaFechada.Caption        := '0';
  LblTotVolumeCxaFechadaPerc.Caption    := '0.00%';
  LblTotVolumeCxaFracionada.Caption     := '0';
  LblTotVolumeCxaFracionadaPerc.caption := '0.00%';
end;

procedure TFrmRelPedidos.LstAnalisePorRuaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0) and (aCol in [0, 1, 2]) then Begin
     TAdvStringGrid(Sender).RowCount := TAdvStringGrid(Sender).RowCount - 1;
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     TAdvStringGrid(Sender).RowCount := TAdvStringGrid(Sender).RowCount + 1;
     if (PgcVolumesGeral.ActivePage = TabAnalisePorSetor) or
        (PgcVolumesGeral.ActivePage = TabAnalisePorRota) Or
        (PgcVolumesGeral.ActivePage = TabAnalisePorLoja) then
        TotalizarLstAnalise(TAdvStringGrid(Sender));
  End
end;

procedure TFrmRelPedidos.LstAnalisePorSetorClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0) and (aCol in [0, 1]) then Begin
     TAdvStringGrid(Sender).RowCount := TAdvStringGrid(Sender).RowCount - 1;
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     TAdvStringGrid(Sender).RowCount := TAdvStringGrid(Sender).RowCount + 1;
  End
end;

procedure TFrmRelPedidos.LstPedidoResumoAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  TAdvStringGrid(Sender).Row := aRow;
  if (aRow = 0) then Begin //and (aCol in [0, 1, 2, 3, 4]) then Begin
//     TAdvStringGrid(Sender).RowCount := TAdvStringGrid(Sender).RowCount - 1;
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
//     TAdvStringGrid(Sender).RowCount := TAdvStringGrid(Sender).RowCount + 1;
  End
end;

procedure TFrmRelPedidos.LstPedidosAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var  xCol, xRow : Integer;
 xVal : String;
begin
  inherited;
  LstPedidosAdv.Row := aRow;
  if (aRow = 0) and (aCol < 25) Then Begin //in [0, 1, 2, 3, 4, 5, 7]) then Begin
     LstPedidosAdv.SortSettings.Column := aCol;
     LstPedidosAdv.QSort;
     Exit;
  End
  Else if (aRow>0) and (aCol = 24) then Begin
    If LstPedidosAdv.Cells[aCol+1, aRow] = '2' then
       CancelarPedido(LstPedidosAdv.Cells[0, aRow].ToInteger());
  End
  Else if (aRow>0) and (aCol = 25) then Begin
    If LstPedidosAdv.Cells[aCol, aRow] = '2' then
      AtualizarStatusPedido(LstPedidosAdv.Cells[0, aRow].ToInteger());
  End;
  if (aCol=0) and (aRow>0) then
     MontalistaPedidoProcesso(LstPedidosAdv.Cells[0, aRow].ToInteger());
end;

procedure TFrmRelPedidos.LstPedidosAdvDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ReturnJsonArray     : TJsonArray;
    ObjPedidoCtrl       : TPedidoSaidaCtrl;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vErro               : String;
begin
  inherited;
  if (ACol <> 25) and (ARow>0) then Begin
     //Buscar Resumo do Atendimento para o Pedido
     TDialogMessage.ShowWaitMessage('Buscando Dados do Pedido...',
       procedure
       begin
       ReturnJsonArray := ObjPedidoCtrl.GetPedidoResumoAtendimento(StrToIntDef(LstPedidosAdv.Cells[0, ARow], 0), 0, 0,0);
       if ReturnJsonArray.Get(0).tryGetValue<String>('Erro', vErro) then Begin
          ShowErro('😢Erro: '+vErro);
          LstPedidoResumoAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
          LstPedidoResumoAdv.RowCount := 1;
          Exit;
       End
       Else Begin
          LstPedidosAdv.Row := aRow;
          MontaListaPedidoResumo(ReturnJsonArray);
       End;
       GetListaVolume(StrToIntDef(LstPedidosAdv.Cells[Acol, ARow], 0), 0, 0, 0);
       PgcPedidos.ActivePage := TabResumo;
     End);
  End;
end;

procedure TFrmRelPedidos.LstVolumeConsultaClick(Sender: TObject);
begin
  inherited;
  if TAdvStringGrid(Sender).Col = 0 then Exit;
  BuscarVolumeClick(LstVolumeConsulta, TAdvStringGrid(Sender).Row, TAdvStringGrid(Sender).Col);
end;

procedure TFrmRelPedidos.LstVolumeProdutosAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) Then Begin //and (aCol in [0, 1, 4, 9]) then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
  End
end;

procedure TFrmRelPedidos.LstVolumesAdvClick(Sender: TObject);
Var lin, col : Integer;
begin
  if TAdvStringGrid(Sender).Col = 0 then Exit;

//  BuscarVolumeClick(LstVolumesAdv, TAdvStringGrid(Sender).Row, TAdvStringGrid(Sender).Col);
  Lin := TAdvStringGrid(Sender).Row;
  Col := TAdvStringGrid(Sender).Col;
  if Not ClickCellVolume then
     BuscarVolumeClick(LstVolumesAdv, TAdvStringGrid(Sender).Row, TAdvStringGrid(Sender).Col);
  ClickCellVolume := False;
end;

Procedure TFrmRelPedidos.BuscarVolumeClick(Sender : TObject; aRow, aCol : Integer);
Var ReturnJsonArray     : TJsonArray;
    JsonArrayCancelar   : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonVolume          : TJsonObject;
    vErro               : String;
Begin
  //TAdvStringGrid(Sender).Row := aRow;
  //TAdvStringGrid(Sender).Col := aCol;
  if (aCol <> 8) and (aRow>0) then Begin
     ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
     ReturnJsonArray := ObjPedidoVolumeCtrl.GetVolumeLotes(StrToIntDef(TAdvStringGrid(Sender).Cells[0, ARow], 0));
     if ReturnJsonArray.Get(0).tryGetValue<String>('Erro', vErro) then Begin
        ShowErro('😢Erro: '+vErro);
        TAdvStringGrid(Sender).ClearRect(0, 1, TAdvStringGrid(Sender).ColCount-1, TAdvStringGrid(Sender).RowCount-1);
        if Sender = LstVolumesAdv then
           LstVolumeProdutosAdv.RowCount := 1
        Else
           LstVolumeProdutosConsulta.RowCount := 1;
        ReturnJsonArray := Nil;
        ObjPedidoVolumeCtrl.Free;
     End
     Else Begin
        //LstVolumesAdv.Row := aRow;
        If FDMemVolumeLotes.Active then
           FDMemVolumeLotes.EmptyDataSet;
        FDMemVolumeLotes.Close;
        FDMemVolumeLotes.LoadFromJSON(ReturnJsonArray, False);
        if PgcBase.ActivePage = TabPrincipal then Begin
           MontaListaVolumeProdutos(LstVolumeProdutosAdv, ReturnJsonArray);
           MontaListaHistoricoVolume(LstVolumeEtapas, StrToIntDef(TAdvStringGrid(Sender).Cells[0, ARow], 0));
        End
        Else Begin
           MontaListaVolumeProdutos(LstVolumeProdutosConsulta, ReturnJsonArray);
           MontaListaHistoricoVolume(LstVolumeHistoricoConsulta, StrToIntDef(TAdvStringGrid(Sender).Cells[0, ARow], 0));
        End;
        ReturnJsonArray := Nil;
        ObjPedidoVolumeCtrl.Free;
     End;
  End;
//  TAdvStringGrid(Sender).Row := aRow;
End;

procedure TFrmRelPedidos.LstVolumesAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ReturnJsonArray   : TJsonArray;
  JsonArrayCancelar   : TJsonArray;
  ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
  JsonVolume          : TJsonObject;
  vErro               : String;
  aColGrid            : Integer;
  ColCancVolume       : Integer;
begin
  inherited;
  If TAdvStringGrid(Sender).Name = 'LstVolumesAdv' then Begin
     aColGrid := 6;
     ColCancVolume := 11;
  End
  Else Begin
     aColGrid := 8;
     ColCancVolume := 11;
  End;
  if (aRow = 0) and ( ACol <> aColGrid ) then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End
  Else if (aRow > 0) and (((aCol = 10) and (Sender=LstVolumeConsulta)) or ((aCol = 8) and (Sender=LstVolumesAdv))) then Begin
     If (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relatórios - Re-Impressão de TAG')) then
        raise Exception.Create('Acesso não autorizado para Reimpressão de TAG!');
     if ((Sender=LstVolumesAdv) and (LstVolumesAdv.Cells[2, aRow] = 'Caixa Fechada')) or ((Sender=LstVolumeConsulta) and (LstVolumeConsulta.Cells[3, aRow] = 'Caixa Fechada'))then
        ReimpressaoTAGVolume(TAdvStringGrid(Sender).Cells[0, aRow].ToInteger(), 0)
     Else
        ReimpressaoTAGVolume(TAdvStringGrid(Sender).Cells[0, aRow].ToInteger(), 1);
  End
  Else if (aColGrid = aCol) and (ARow>0) and (TAdvStringGrid(Sender).Cells[8, aRow]='2') and (TAdvStringGrid(Sender).Cells[8, 0]='Ação') then Begin
     if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Volumes Cancelar') then Begin
        ShowErro('Acesso não autorizado a esta funcionalidade!');
        Exit;
     End;
     if (TAdvStringGrid(Sender).Ints[ColCancVolume, aRow] = 7) and
        (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId <> 1) then Begin
        ShowErro('Volume em Separação. Finalize antes de Cancelar', 'inválido');
        exit;
     End
     Else if (TAdvStringGrid(Sender).Ints[ColCancVolume, aRow] =  9) and
        (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId <> 1) then Begin
        ShowErro('Volume com CheckOut iniciado. Finalize antes de Cancelar', 'inválido');
        exit;
     End
     Else if (TAdvStringGrid(Sender).Ints[ColCancVolume, aRow] =  11) and
        (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId <> 1) then Begin
        ShowErro('Volume Em Re-CheckOut. Finalize antes de Cancelar', 'inválido');
        exit;
     End;
     If Confirmacao('Cancelar Volume.', 'Deseja cancelar o volume('+TAdvStringGrid(Sender).Cells[0, aRow]+')?', True) then begin
        if TAdvStringGrid(Sender).Cells[7, aRow] = 'Na Expedição' then
           MensagemSis('ATENÇÃO: Volume Expedido.', 'Estoque DIRECIONADO para: '+
                      FrmeXactWMS.ConfigWMS.ObjConfiguracao.EnderecoVolumeExpedidoCancelado
                       , '   Os produtos deverão ser MOVIMENTADO(S)', 'para o local correto.');
        JsonVolume := TJsonObject.Create();
        JsonVolume.AddPair('pedidoId', TJsonNumber.Create(0));
        JsonVolume.AddPair('pedidoVolumeId', TJsonNumber.Create(TAdvStringGrid(Sender).Cells[0, aRow].ToInteger()));
        JsonVolume.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
        JsonVolume.AddPair('terminal', NomeDoComputador);
        ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
        Try
          JsonArrayCancelar := ObjPedidoVolumeCtrl.CancelarVolume(JsonVolume);
          If JsonArrayCancelar.Items[0].TryGetValue('Erro', vErro) then
             ShowErro('Não foi possível cancelar o volume!')
          Else Begin
            if PgcBase.ActivePage = TabPrincipal then Begin
               //GetListaVolume(StrToIntDef(TAdvStringGrid(Sender).Cells[0, TAdvStringGrid(Sender).Row], 0), 0, 0, 0);
               TAdvStringGrid(Sender).Cells[7, aRow] := 'Cancelado';
               TAdvStringGrid(Sender).Cells[8, aRow] := '3';
               TAdvStringGrid(Sender).Colors[7, aRow] := ClRed;
               ShowOk('ao retornar a Aba Pedidoso, atualze a consulta');
            End
            Else Begin
               LstVolumeConsulta.Cells[7, ARow]  := 'Cancelado';
               LstVolumeConsulta.Colors[7, ARow] := ClRed;
               LstVolumeConsulta.Cells[8, ARow]  := '3';
            End;
          End;
        Except
        End;
        JsonVolume.Free;
        ObjPedidoVolumeCtrl.Free;
     end;
     exit;
  End
  Else If (aCol = 0) and (aRow>0) Then Begin
     ClickCellVolume := True;
     //TAdvStringGrid(Sender).Col := 0;
     TAdvStringGrid(Sender).Row := aRow;
     //BuscarVolumeClick(TAdvStringGrid(Sender), aRow, aCol);
  End
  Else If aCol >  0 then Begin
     //BuscarVolumeClick(LstVolumesAdv, aRow, aCol);
  End;
end;

procedure TFrmRelPedidos.MontaListaPedidoProcesso(pPedidoId : Integer);
Var JsonArrayRetorno    : TJsonArray;
    ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    vErro               : String;
    xHistorico          : Integer;
begin
  Try
    LstPedidoProcesso.RowCount := 1;
    ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
    JsonArrayRetorno := ObjPedidoSaidaCtrl.GetPedidoProcesso(pPedidoId);
    if Not JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
       LstPedidoProcesso.RowCount := JsonArrayRetorno.Count+1;
       LstPedidoProcesso.FixedRows := 1;
       for xHistorico := 0 to Pred(JsonArrayRetorno.Count) do Begin
         LstPedidoProcesso.Cells[0, xHistorico+1]  := JsonArrayRetorno.Items[xHistorico].GetValue<String>('etapa');
         LstPedidoProcesso.Cells[1, xHistorico+1]  := DateToStr(JsonArrayRetorno.Items[xHistorico].GetValue<TDateTime>('horario'));
         LstPedidoProcesso.Cells[2, xHistorico+1]  := TimeToStr((JsonArrayRetorno.Items[xHistorico].GetValue<TDateTime>('horario') ));
         LstPedidoProcesso.Cells[3, xHistorico+1]  := JsonArrayRetorno.Items[xHistorico].GetValue<String>('usuario');
         LstPedidoProcesso.Cells[4, xHistorico+1]  := JsonArrayRetorno.Items[xHistorico].GetValue<String>('terminal');
         LstPedidoProcesso.Alignments[1, xHistorico+1] := taCenter;
         LstPedidoProcesso.Alignments[2, xHistorico+1] := taCenter;
       End;
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoSaidaCtrl.Free;
  Except
    //ShowErro('Aconteceu Aqui');
    JsonArrayRetorno := Nil;
    ObjPedidoSaidaCtrl.Free;
  End;
end;

procedure TFrmRelPedidos.HeaderLstAnalisePorLoja;
begin
  LstAnalisePorLoja.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstAnalisePorLoja.ColWidths[1]  := 300+Trunc(300*ResponsivoVideo);
  LstAnalisePorLoja.ColWidths[2]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorLoja.ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorLoja.ColWidths[4]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorLoja.ColWidths[5]  := 110+Trunc(110*ResponsivoVideo); //Dt.Processo
  LstAnalisePorLoja.ColWidths[6]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorLoja.ColWidths[7]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorLoja.Alignments[0, 0] := taRightJustify;
  LstAnalisePorLoja.FontStyles[0, 0] := [FsBold];
  LstAnalisePorLoja.Alignments[2, 0] := taRightJustify;
  LstAnalisePorLoja.Alignments[3, 0] := taRightJustify;
  LstAnalisePorLoja.Alignments[4, 0] := taRightJustify;
  LstAnalisePorLoja.Alignments[5, 0] := taRightJustify;
  LstAnalisePorLoja.Alignments[6, 0] := taRightJustify;
  LstAnalisePorLoja.Alignments[7, 0] := taRightJustify;
end;

procedure TFrmRelPedidos.HeaderLstAnalisePorRota;
begin
  LstAnalisePorRota.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstAnalisePorRota.ColWidths[1]  := 300+Trunc(300*ResponsivoVideo);
  LstAnalisePorRota.ColWidths[2]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorRota.ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorRota.ColWidths[4]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorRota.ColWidths[5]  := 110+Trunc(110*ResponsivoVideo); //Dt.Processo
  LstAnalisePorRota.ColWidths[6]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorRota.ColWidths[7]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorRota.Alignments[0, 0] := taRightJustify;
  LstAnalisePorRota.FontStyles[0, 0] := [FsBold];
  LstAnalisePorRota.Alignments[2, 0] := taRightJustify;
  LstAnalisePorRota.Alignments[3, 0] := taRightJustify;
  LstAnalisePorRota.Alignments[4, 0] := taRightJustify;
  LstAnalisePorRota.Alignments[5, 0] := taRightJustify;
  LstAnalisePorRota.Alignments[6, 0] := taRightJustify;
  LstAnalisePorRota.Alignments[7, 0] := taRightJustify;
end;

Procedure TFrmRelPedidos.HeaderLstAnalisePorRua;
Begin
  LstAnalisePorRua.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[1]  := 300+Trunc(300*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[2]  :=  50+Trunc(50*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[3]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[4]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[5]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[6]  := 110+Trunc(110*ResponsivoVideo); //Dt.Processo
  LstAnalisePorRua.ColWidths[7]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorRua.ColWidths[8]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorRua.Alignments[0, 0] := taRightJustify;
  LstAnalisePorRua.FontStyles[0, 0] := [FsBold];
  LstAnalisePorRua.Alignments[3, 0] := taRightJustify;
  LstAnalisePorRua.Alignments[4, 0] := taRightJustify;
  LstAnalisePorRua.Alignments[5, 0] := taRightJustify;
  LstAnalisePorRua.Alignments[6, 0] := taRightJustify;
  LstAnalisePorRua.Alignments[7, 0] := taRightJustify;
  LstAnalisePorRua.Alignments[8, 0] := taRightJustify;
End;

procedure TFrmRelPedidos.HeaderLstAnalisePorSetor;
Begin
  LstAnalisePorSetor.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstAnalisePorSetor.ColWidths[1]  := 300+Trunc(300*ResponsivoVideo);
  LstAnalisePorSetor.ColWidths[2]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorSetor.ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorSetor.ColWidths[4]  := 115+Trunc(115*ResponsivoVideo);
  LstAnalisePorSetor.ColWidths[5]  := 110+Trunc(110*ResponsivoVideo); //Dt.Processo
  LstAnalisePorSetor.ColWidths[6]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorSetor.ColWidths[7]  := 100+Trunc(100*ResponsivoVideo);
  LstAnalisePorSetor.Alignments[0, 0] := taRightJustify;
  LstAnalisePorSetor.FontStyles[0, 0] := [FsBold];
  LstAnalisePorSetor.Alignments[2, 0] := taRightJustify;
  LstAnalisePorSetor.Alignments[3, 0] := taRightJustify;
  LstAnalisePorSetor.Alignments[4, 0] := taRightJustify;
  LstAnalisePorSetor.Alignments[5, 0] := taRightJustify;
  LstAnalisePorSetor.Alignments[6, 0] := taRightJustify;
  LstAnalisePorSetor.Alignments[7, 0] := taRightJustify;
end;

procedure TFrmRelPedidos.HeaderLstVolumeConsulta;
Begin
  LstVolumeConsulta.ColWidths[0]  :=  90+Trunc(90*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[1]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[2]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[4]  := 30+Trunc(30*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[5]  :=  60+Trunc(60*ResponsivoVideo); //Dt.Processo
  LstVolumeConsulta.ColWidths[6]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[7]  := 120+Trunc(120*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[8]  :=  40+Trunc(40*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[9]  :=  40+Trunc(40*ResponsivoVideo);
  LstVolumeConsulta.ColWidths[10] :=  40+Trunc(40*ResponsivoVideo);
  LstVolumeConsulta.Width := Trunc(Screen.Width*0.53);  //  720; //(90+60+0+100+170+80+60+40+40+40)+40;


  LstVolumeHistoricoConsulta.width := Width - (LstVolumeConsulta.Width+50);
  LstVolumeConsulta.Alignments[ 0, 0] := taRightJustify;
  LstVolumeConsulta.FontStyles[ 0, 0] := [FsBold];
  LstVolumeConsulta.Alignments[ 1, 0] := taRightJustify;
  LstVolumeConsulta.Alignments[ 2, 0] := taRightJustify;
  LstVolumeConsulta.Alignments[ 3, 0] := taLeftJustify;
  LstVolumeConsulta.Alignments[ 4, 0] := taCenter;
  LstVolumeConsulta.Alignments[ 5, 0] := taLeftJustify;
  LstVolumeConsulta.FontStyles[ 5, 0] := [FsBold];
  LstVolumeConsulta.Alignments[ 6, 0] := taRightJustify;
  LstVolumeConsulta.Alignments[ 7, 0] := taLeftJustify;
  LstVolumeConsulta.Alignments[ 8, 0] := taCenter;
  LstVolumeConsulta.Alignments[ 9, 0] := taCenter;
  LstVolumeConsulta.Alignments[10, 0] := taCenter;
  //LstVolumeConsulta.HideColumn(4);
  LstVolumeConsulta.HideColumn(11);

  LstVolumeHistoricoConsulta.ColWidths[0]  := 100+Trunc(100*ResponsivoVideo);
  LstVolumeHistoricoConsulta.ColWidths[1]  :=  80+Trunc(80*ResponsivoVideo);
  LstVolumeHistoricoConsulta.ColWidths[2]  :=  65+Trunc(65*ResponsivoVideo);
  LstVolumeHistoricoConsulta.ColWidths[3]  := 130+Trunc(130*ResponsivoVideo);
  LstVolumeHistoricoConsulta.ColWidths[4]  := 120+Trunc(120*ResponsivoVideo);
  LstVolumeHistoricoConsulta.Alignments[1, 0] := taCenter;
  LstVolumeHistoricoConsulta.Alignments[2, 0] := taCenter;

  //Produtos do Volume
  LstVolumeProdutosConsulta.ColWidths[0]  :=  75+Trunc(75*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[1]  := 250+Trunc(25*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[2]  := 150+Trunc(150*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[3]  :=  80+Trunc(80*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[4]  :=  90+Trunc(90*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[5]  := 120+Trunc(120*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[6]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[7]  :=  80+Trunc(80*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[8]  :=  60+Trunc(60*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[9]  :=  90+Trunc(90*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[10]  := 120+Trunc(120*ResponsivoVideo);
  LstVolumeProdutosConsulta.ColWidths[11] := 130+Trunc(130*ResponsivoVideo);//80;
  LstVolumeProdutosConsulta.ColWidths[12] := 150+Trunc(150*ResponsivoVideo);//80;
  LstVolumeProdutosConsulta.Alignments[0,  0] := taRightJustify;
  LstVolumeProdutosConsulta.FontStyles[0,  0] := [FsBold];
  LstVolumeProdutosConsulta.Alignments[3,  0] := taCenter;
  LstVolumeProdutosConsulta.Alignments[4,  0] := taCenter;
  LstVolumeProdutosConsulta.Alignments[6,  0] := taRightJustify;
  LstVolumeProdutosConsulta.Alignments[7,  0] := taRightJustify;
  LstVolumeProdutosConsulta.Alignments[8,  0] := taRightJustify;
  LstVolumeProdutosConsulta.Alignments[9,  0] := taRightJustify;
  LstVolumeProdutosConsulta.Alignments[11, 0] := taCenter;
end;

procedure TFrmRelPedidos.MontaListaAnalisePorLoja(pJsonObjectRetorno : TJsonObject);
Var xLoja : Integer;
    Totvolumecxafechada, Totvolumefracionado   : Integer;
    Totunidadecxafechada, Totunidadefracionado : Integer;
begin
  LblTotPedido_AnalisePorLoja.Caption           := pJsonObjectRetorno.GetValue<Integer>('totalpedidos').ToString();
  LblTotVolumeCxaFechada_AnalisePorLoja.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada').ToString();
  LblTotVolumeFracionado_AnalisePorLoja.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado').ToString();
  LblTotVolume_AnalisePorLoja.Caption           := (pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada')+
                                                   pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado')).ToString();
  LstAnalisePorLoja.RowCount  := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count+2;
  if pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count >= 1 then
     LstAnalisePorLoja.FixedRows := 1;
  HeaderLstAnalisePorLoja;
  FDMemAnalisePorLoja.Open;
  Totvolumecxafechada  := 0;
  Totvolumefracionado  := 0;
  Totunidadecxafechada := 0;
  Totunidadefracionado := 0;

  for xLoja := 0 to Pred(pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count) do Begin
    LstAnalisePorLoja.RowHeights[xLoja+1] := 30;
    LstAnalisePorLoja.Cells[0, xLoja+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('codpessoaerp');
    LstAnalisePorLoja.Cells[1, xLoja+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('fantasia');
    LstAnalisePorLoja.Cells[2, xLoja+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('volumecxafechada');
    LstAnalisePorLoja.Cells[3, xLoja+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('volumefracionado');
    LstAnalisePorLoja.Cells[4, xLoja+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('unidadecxafechada');
    LstAnalisePorLoja.Cells[5, xLoja+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('unidadefracionado');
    Totvolumecxafechada  := Totvolumecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<integer>('volumecxafechada');
    Totvolumefracionado  := Totvolumefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<integer>('volumefracionado');
    Totunidadecxafechada := Totunidadecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('unidadecxafechada');
    Totunidadefracionado := Totunidadefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('unidadefracionado');
    LstAnalisePorLoja.Cells[6, xLoja+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('volumefracionado')).ToString();
    LstAnalisePorLoja.Cells[7, xLoja+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('unidadefracionado')).ToString();
    FDMemAnalisePorLoja.Append;
    FDMemAnalisePorLoja.FieldByName('CodPessoaERP').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('codpessoaerp');
    FDMemAnalisePorLoja.FieldByName('Razao').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('razao');
    FDMemAnalisePorLoja.FieldByName('Fantasia').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('fantasia');
    FDMemAnalisePorLoja.FieldByName('volumecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('volumecxafechada');
    FDMemAnalisePorLoja.FieldByName('volumefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('volumefracionado');
    FDMemAnalisePorLoja.FieldByName('unidadecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('unidadecxafechada');
    FDMemAnalisePorLoja.FieldByName('unidadefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<String>('unidadefracionado');
    FDMemAnalisePorLoja.FieldByName('TotalVolumes').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('volumefracionado'));
    FDMemAnalisePorLoja.FieldByName('TotalUnidades').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xLoja].GetValue<Integer>('unidadefracionado'));

    FDMemAnalisePorLoja.Post;
    LstAnalisePorLoja.FontSizes[0, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[1, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[2, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[3, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[4, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[5, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[6, xLoja+1] := 10;
    LstAnalisePorLoja.FontSizes[7, xLoja+1] := 10;

    LstAnalisePorLoja.Alignments[0, xLoja+1] := taRightJustify;
    LstAnalisePorLoja.FontStyles[0, xLoja+1] := [FsBold];
    LstAnalisePorLoja.Alignments[2, xLoja+1] := taRightJustify;
    LstAnalisePorLoja.Alignments[3, xLoja+1] := taRightJustify;
    LstAnalisePorLoja.Alignments[4, xLoja+1] := taRightJustify;
    LstAnalisePorLoja.Alignments[5, xLoja+1] := taRightJustify;
    LstAnalisePorLoja.Alignments[6, xLoja+1] := taRightJustify;
    LstAnalisePorLoja.Alignments[7, xLoja+1] := taRightJustify;
  End;
  //Incluir Total
//  LstAnalisePorLoja.RowHeights[xLoja+1] := 35;
//  LstAnalisePorLoja.Cells[0, xLoja+1] := '';
//  LstAnalisePorLoja.Cells[1, xLoja+1] := 'Total';
//  LstAnalisePorLoja.Cells[2, xLoja+1] := Totvolumecxafechada.ToString();
//  LstAnalisePorLoja.Cells[3, xLoja+1] := Totvolumefracionado.ToString();
//  LstAnalisePorLoja.Cells[4, xLoja+1] := Totunidadecxafechada.ToString();
//  LstAnalisePorLoja.Cells[5, xLoja+1] := Totunidadefracionado.ToString();
//  LstAnalisePorLoja.Cells[6, xLoja+1] := (Totvolumecxafechada+Totvolumefracionado).ToString();
//  LstAnalisePorLoja.Cells[7, xLoja+1] := (Totunidadecxafechada+Totunidadefracionado).ToString();
  TotalizarLstAnalise(LstAnalisePorLoja);
  LstAnalisePorLoja.FontSizes[0, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[1, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[2, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[3, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[4, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[5, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[6, xLoja+1] := 14;
  LstAnalisePorLoja.FontSizes[7, xLoja+1] := 14;

  LstAnalisePorLoja.Alignments[0, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.FontStyles[0, xLoja+1] := [FsBold];
  LstAnalisePorLoja.Alignments[1, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.Alignments[2, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.Alignments[3, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.Alignments[4, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.Alignments[5, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.Alignments[6, xLoja+1] := taRightJustify;
  LstAnalisePorLoja.Alignments[7, xLoja+1] := taRightJustify;
end;

procedure TFrmRelPedidos.MontaListaAnalisePorRota(pJsonObjectRetorno : TJsonObject);
Var xRota : Integer;
    Totvolumecxafechada, Totvolumefracionado   : Integer;
    Totunidadecxafechada, Totunidadefracionado : Integer;
begin
  LblTotPedido_AnalisePorRota.Caption           := pJsonObjectRetorno.GetValue<Integer>('totalpedidos').ToString();
  LblTotVolumeCxaFechada_AnalisePorRota.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada').ToString();
  LblTotVolumeFracionado_AnalisePorRota.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado').ToString();
  LblTotVolume_AnalisePorRota.Caption           := (pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada')+
                                                   pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado')).ToString();
  LstAnalisePorRota.RowCount  := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count+2;
  if pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count >= 1 then
     LstAnalisePorRota.FixedRows := 1;
  HeaderLstAnalisePorRota;
  FDMemAnalisePorRota.Open;
  Totvolumecxafechada  := 0;
  Totvolumefracionado  := 0;
  Totunidadecxafechada := 0;
  Totunidadefracionado := 0;

  for xRota := 0 to Pred(pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count) do Begin
    LstAnalisePorRota.RowHeights[xRota+1] := 30;
    LstAnalisePorRota.Cells[0, xRota+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('rotaid');
    LstAnalisePorRota.Cells[1, xRota+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('rota');
    LstAnalisePorRota.Cells[2, xRota+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('volumecxafechada');
    LstAnalisePorRota.Cells[3, xRota+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('volumefracionado');
    LstAnalisePorRota.Cells[4, xRota+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('unidadecxafechada');
    LstAnalisePorRota.Cells[5, xRota+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('unidadefracionado');
    Totvolumecxafechada  := Totvolumecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<integer>('volumecxafechada');
    Totvolumefracionado  := Totvolumefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<integer>('volumefracionado');
    Totunidadecxafechada := Totunidadecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('unidadecxafechada');
    Totunidadefracionado := Totunidadefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('unidadefracionado');
    LstAnalisePorRota.Cells[6, xRota+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('volumefracionado')).ToString();
    LstAnalisePorRota.Cells[7, xRota+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('unidadefracionado')).ToString();
    FDMemAnalisePorRota.Append;
    FDMemAnalisePorRota.FieldByName('RotaId').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('rotaid');
    FDMemAnalisePorRota.FieldByName('Rota').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('rota');
    FDMemAnalisePorRota.FieldByName('volumecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('volumecxafechada');
    FDMemAnalisePorRota.FieldByName('volumefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('volumefracionado');
    FDMemAnalisePorRota.FieldByName('unidadecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('unidadecxafechada');
    FDMemAnalisePorRota.FieldByName('unidadefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<String>('unidadefracionado');
    FDMemAnalisePorRota.FieldByName('TotalVolumes').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('volumefracionado'));
    FDMemAnalisePorRota.FieldByName('TotalUnidades').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRota].GetValue<Integer>('unidadefracionado'));

    FDMemAnalisePorRota.Post;
    LstAnalisePorRota.FontSizes[0, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[1, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[2, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[3, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[4, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[5, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[6, xRota+1] := 10;
    LstAnalisePorRota.FontSizes[7, xRota+1] := 10;

    LstAnalisePorRota.Alignments[0, xRota+1] := taRightJustify;
    LstAnalisePorRota.FontStyles[0, xRota+1] := [FsBold];
    LstAnalisePorRota.Alignments[2, xRota+1] := taRightJustify;
    LstAnalisePorRota.Alignments[3, xRota+1] := taRightJustify;
    LstAnalisePorRota.Alignments[4, xRota+1] := taRightJustify;
    LstAnalisePorRota.Alignments[5, xRota+1] := taRightJustify;
    LstAnalisePorRota.Alignments[6, xRota+1] := taRightJustify;
    LstAnalisePorRota.Alignments[7, xRota+1] := taRightJustify;
  End;
  //Incluir Total
//  LstAnalisePorRota.RowHeights[xRota+1] := 35;
//  LstAnalisePorRota.Cells[0, xRota+1] := '';
//  LstAnalisePorRota.Cells[1, xRota+1] := 'Total';
//  LstAnalisePorRota.Cells[2, xRota+1] := Totvolumecxafechada.ToString();
//  LstAnalisePorRota.Cells[3, xRota+1] := Totvolumefracionado.ToString();
//  LstAnalisePorRota.Cells[4, xRota+1] := Totunidadecxafechada.ToString();
//  LstAnalisePorRota.Cells[5, xRota+1] := Totunidadefracionado.ToString();
//  LstAnalisePorRota.Cells[6, xRota+1] := (Totvolumecxafechada+Totvolumefracionado).ToString();
//  LstAnalisePorRota.Cells[7, xRota+1] := (Totunidadecxafechada+Totunidadefracionado).ToString();
  TotalizarLstAnalise(LstAnalisePorRota);

  LstAnalisePorRota.FontSizes[0, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[1, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[2, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[3, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[4, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[5, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[6, xRota+1] := 14;
  LstAnalisePorRota.FontSizes[7, xRota+1] := 14;

  LstAnalisePorRota.Alignments[0, xRota+1] := taRightJustify;
  LstAnalisePorRota.FontStyles[0, xRota+1] := [FsBold];
  LstAnalisePorRota.Alignments[1, xRota+1] := taRightJustify;
  LstAnalisePorRota.Alignments[2, xRota+1] := taRightJustify;
  LstAnalisePorRota.Alignments[3, xRota+1] := taRightJustify;
  LstAnalisePorRota.Alignments[4, xRota+1] := taRightJustify;
  LstAnalisePorRota.Alignments[5, xRota+1] := taRightJustify;
  LstAnalisePorRota.Alignments[6, xRota+1] := taRightJustify;
  LstAnalisePorRota.Alignments[7, xRota+1] := taRightJustify;
end;

procedure TFrmRelPedidos.MontaListaAnalisePorRua(
  pJsonObjectRetorno: TJsonObject);
Var xRua : Integer;
    Totvolumecxafechada, Totvolumefracionado   : Integer;
    Totunidadecxafechada, Totunidadefracionado : Integer;
begin
  LblTotPedido_AnalisePorRua.Caption           := pJsonObjectRetorno.GetValue<Integer>('totalpedidos').ToString();
  LblTotVolumeCxaFechada_AnalisePorRua.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada').ToString();
  LblTotVolumeFracionado_AnalisePorRua.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado').ToString();
  LblTotVolume_AnalisePorRua.Caption           := (pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada')+
                                                   pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado')).ToString();
  LstAnalisePorRua.RowCount  := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count+2;
  if pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count >= 1 then
     LstAnalisePorRua.FixedRows := 1;
  HeaderLstAnalisePorRua;
  FDMemAnalisePorRua.Open;
  Totvolumecxafechada  := 0;
  Totvolumefracionado  := 0;
  Totunidadecxafechada := 0;
  Totunidadefracionado := 0;

  for xRua := 0 to Pred(pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count) do Begin
    LstAnalisePorRua.RowHeights[xRua+1] := 30;
    LstAnalisePorRua.Cells[0, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('zonaid');
    LstAnalisePorRua.Cells[1, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('zona');
    LstAnalisePorRua.Cells[2, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('rua');
    LstAnalisePorRua.Cells[3, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('volumecxafechada');
    LstAnalisePorRua.Cells[4, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('volumefracionado');
    LstAnalisePorRua.Cells[5, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('unidadecxafechada');
    LstAnalisePorRua.Cells[6, xRua+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('unidadefracionado');
    Totvolumecxafechada  := Totvolumecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<integer>('volumecxafechada');
    Totvolumefracionado  := Totvolumefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<integer>('volumefracionado');
    Totunidadecxafechada := Totunidadecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('unidadecxafechada');
    Totunidadefracionado := Totunidadefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('unidadefracionado');
    LstAnalisePorRua.Cells[7, xRua+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('volumefracionado')).ToString();
    LstAnalisePorRua.Cells[8, xRua+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('unidadefracionado')).ToString();
    FDMemAnalisePorRua.Append;
    FDMemAnalisePorRua.FieldByName('ZonaId').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('zonaid');
    FDMemAnalisePorRua.FieldByName('Zona').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('zona');
    FDMemAnalisePorRua.FieldByName('Rua').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('rua');
    FDMemAnalisePorRua.FieldByName('volumecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('volumecxafechada');
    FDMemAnalisePorRua.FieldByName('volumefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('volumefracionado');
    FDMemAnalisePorRua.FieldByName('unidadecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('unidadecxafechada');
    FDMemAnalisePorRua.FieldByName('unidadefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<String>('unidadefracionado');
    FDMemAnalisePorRua.FieldByName('TotalVolumes').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('volumefracionado'));
    FDMemAnalisePorRua.FieldByName('TotalUnidades').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xRua].GetValue<Integer>('unidadefracionado'));

    FDMemAnalisePorRua.Post;
    LstAnalisePorRua.FontSizes[0, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[1, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[2, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[3, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[4, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[5, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[6, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[7, xRua+1] := 12;
    LstAnalisePorRua.FontSizes[8, xRua+1] := 12;

    LstAnalisePorRua.Alignments[0, xRua+1] := taRightJustify;
    LstAnalisePorRua.FontStyles[0, xRua+1] := [FsBold];
    LstAnalisePorRua.Alignments[3, xRua+1] := taRightJustify;
    LstAnalisePorRua.Alignments[4, xRua+1] := taRightJustify;
    LstAnalisePorRua.Alignments[5, xRua+1] := taRightJustify;
    LstAnalisePorRua.Alignments[6, xRua+1] := taRightJustify;
    LstAnalisePorRua.Alignments[7, xRua+1] := taRightJustify;
    LstAnalisePorRua.Alignments[8, xRua+1] := taRightJustify;
  End;
  //Incluir Total
//  LstAnalisePorRua.RowHeights[xRua+1] := 35;
//  LstAnalisePorRua.Cells[0, xRua+1] := '';
//  LstAnalisePorRua.Cells[1, xRua+1] := 'Total';
//  LstAnalisePorRua.Cells[2, xRua+1] := '';
//  LstAnalisePorRua.Cells[3, xRua+1] := Totvolumecxafechada.ToString();
//  LstAnalisePorRua.Cells[4, xRua+1] := Totvolumefracionado.ToString();
//  LstAnalisePorRua.Cells[5, xRua+1] := Totunidadecxafechada.ToString();
//  LstAnalisePorRua.Cells[6, xRua+1] := Totunidadefracionado.ToString();
//  LstAnalisePorRua.Cells[7, xRua+1] := (Totvolumecxafechada+Totvolumefracionado).ToString();
//  LstAnalisePorRua.Cells[8, xRua+1] := (Totunidadecxafechada+Totunidadefracionado).ToString();
  TotalizarLstAnalisePorRua;

  LstAnalisePorRua.FontSizes[0, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[1, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[2, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[3, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[4, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[5, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[6, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[7, xRua+1] := 14;
  LstAnalisePorRua.FontSizes[8, xRua+1] := 14;

  LstAnalisePorRua.Alignments[0, xRua+1] := taRightJustify;
  LstAnalisePorRua.FontStyles[0, xRua+1] := [FsBold];
  LstAnalisePorRua.Alignments[1, xRua+1] := taRightJustify;
  LstAnalisePorRua.Alignments[3, xRua+1] := taRightJustify;
  LstAnalisePorRua.Alignments[4, xRua+1] := taRightJustify;
  LstAnalisePorRua.Alignments[5, xRua+1] := taRightJustify;
  LstAnalisePorRua.Alignments[6, xRua+1] := taRightJustify;
  LstAnalisePorRua.Alignments[7, xRua+1] := taRightJustify;
  LstAnalisePorRua.Alignments[8, xRua+1] := taRightJustify;
end;

procedure TFrmRelPedidos.MontaListaAnalisePorSetor(
  pJsonObjectRetorno: TJsonObject);
Var xSetor : Integer;
    Totvolumecxafechada, Totvolumefracionado   : Integer;
    Totunidadecxafechada, Totunidadefracionado : Integer;
begin
  LblTotPedido_AnalisePorSetor.Caption           := pJsonObjectRetorno.GetValue<Integer>('totalpedidos').ToString();
  LblTotVolumeCxaFechada_AnalisePorSetor.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada').ToString();
  LblTotVolumeFracionado_AnalisePorSetor.Caption := pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado').ToString();
  LblTotVolume_AnalisePorSetor.Caption           := (pJsonObjectRetorno.GetValue<Integer>('totalvolumecxafechada')+
                                                   pJsonObjectRetorno.GetValue<Integer>('totalvolumefracionado')).ToString();
  LstAnalisePorSetor.RowCount  := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count+2;
  if pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count >= 1 then
     LstAnalisePorSetor.FixedRows := 1;
  HeaderLstAnalisePorSetor;
  FDMemAnalisePorSetor.Open;
  Totvolumecxafechada  := 0;
  Totvolumefracionado  := 0;
  Totunidadecxafechada := 0;
  Totunidadefracionado := 0;

  for xSetor := 0 to Pred(pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Count) do Begin
    LstAnalisePorSetor.RowHeights[xSetor+1] := 30;
    LstAnalisePorSetor.Cells[0, xSetor+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('zonaid');
    LstAnalisePorSetor.Cells[1, xSetor+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('zona');
    LstAnalisePorSetor.Cells[2, xSetor+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('volumecxafechada');
    LstAnalisePorSetor.Cells[3, xSetor+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('volumefracionado');
    LstAnalisePorSetor.Cells[4, xSetor+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('unidadecxafechada');
    LstAnalisePorSetor.Cells[5, xSetor+1] := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('unidadefracionado');
    Totvolumecxafechada  := Totvolumecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<integer>('volumecxafechada');
    Totvolumefracionado  := Totvolumefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<integer>('volumefracionado');
    Totunidadecxafechada := Totunidadecxafechada+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('unidadecxafechada');
    Totunidadefracionado := Totunidadefracionado+pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('unidadefracionado');
    LstAnalisePorSetor.Cells[6, xSetor+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('volumefracionado')).ToString();
    LstAnalisePorSetor.Cells[7, xSetor+1] := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('unidadefracionado')).ToString();
    FDMemAnalisePorSetor.Append;
    FDMemAnalisePorSetor.FieldByName('ZonaId').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('zonaid');
    FDMemAnalisePorSetor.FieldByName('Zona').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('zona');
    FDMemAnalisePorSetor.FieldByName('volumecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('volumecxafechada');
    FDMemAnalisePorSetor.FieldByName('volumefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('volumefracionado');
    FDMemAnalisePorSetor.FieldByName('unidadecxafechada').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('unidadecxafechada');
    FDMemAnalisePorSetor.FieldByName('unidadefracionado').Value := pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<String>('unidadefracionado');
    FDMemAnalisePorSetor.FieldByName('TotalVolumes').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('volumecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('volumefracionado'));
    FDMemAnalisePorSetor.FieldByName('TotalUnidades').Value := (pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('unidadecxafechada')+
                                          pJsonObjectRetorno.GetValue<TJsonArray>('detalhe').Items[xSetor].GetValue<Integer>('unidadefracionado'));

    FDMemAnalisePorSetor.Post;
    LstAnalisePorSetor.FontSizes[0, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[1, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[2, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[3, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[4, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[5, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[6, xSetor+1] := 12;
    LstAnalisePorSetor.FontSizes[7, xSetor+1] := 12;

    LstAnalisePorSetor.Alignments[0, xSetor+1] := taRightJustify;
    LstAnalisePorSetor.FontStyles[0, xSetor+1] := [FsBold];
    LstAnalisePorSetor.Alignments[2, xSetor+1] := taRightJustify;
    LstAnalisePorSetor.Alignments[3, xSetor+1] := taRightJustify;
    LstAnalisePorSetor.Alignments[4, xSetor+1] := taRightJustify;
    LstAnalisePorSetor.Alignments[5, xSetor+1] := taRightJustify;
    LstAnalisePorSetor.Alignments[6, xSetor+1] := taRightJustify;
    LstAnalisePorSetor.Alignments[7, xSetor+1] := taRightJustify;
  End;
  //Incluir Total
//  LstAnalisePorSetor.RowHeights[xSetor+1] := 35;
//  LstAnalisePorSetor.Cells[0, xSetor+1] := '';
//  LstAnalisePorSetor.Cells[1, xSetor+1] := 'Total';
//  LstAnalisePorSetor.Cells[2, xSetor+1] := Totvolumecxafechada.ToString();
//  LstAnalisePorSetor.Cells[3, xSetor+1] := Totvolumefracionado.ToString();
//  LstAnalisePorSetor.Cells[4, xSetor+1] := Totunidadecxafechada.ToString();
//  LstAnalisePorSetor.Cells[5, xSetor+1] := Totunidadefracionado.ToString();
//  LstAnalisePorSetor.Cells[6, xSetor+1] := (Totvolumecxafechada+Totvolumefracionado).ToString();
//  LstAnalisePorSetor.Cells[7, xSetor+1] := (Totunidadecxafechada+Totunidadefracionado).ToString();
  TotalizarLstAnalise(LstAnalisePorSetor);

  LstAnalisePorSetor.FontSizes[0, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[1, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[2, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[3, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[4, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[5, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[6, xSetor+1] := 14;
  LstAnalisePorSetor.FontSizes[7, xSetor+1] := 14;

  LstAnalisePorSetor.Alignments[0, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.FontStyles[0, xSetor+1] := [FsBold];
  LstAnalisePorSetor.Alignments[1, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.Alignments[2, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.Alignments[3, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.Alignments[4, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.Alignments[5, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.Alignments[6, xSetor+1] := taRightJustify;
  LstAnalisePorSetor.Alignments[7, xSetor+1] := taRightJustify;
end;

procedure TFrmRelPedidos.MontaListaHistoricoVolume(Sender : TObject; pPedidoVolumeId : Integer);
Var JsonArrayRetorno    : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vErro               : String;
    xHistorico          : Integer;
begin
  Try
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeEtapas(pPedidoVolumeId);
    if Not JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
       TAdvStringGrid(Sender).RowCount := JsonArrayRetorno.Count+1;
       TAdvStringGrid(Sender).FixedRows := 1;
       for xHistorico := 0 to Pred(JsonArrayRetorno.Count) do Begin
         TAdvStringGrid(Sender).Cells[0, xHistorico+1]  := JsonArrayRetorno.Items[xHistorico].GetValue<String>('etapa');
         TAdvStringGrid(Sender).Cells[1, xHistorico+1]  := DateToStr(JsonArrayRetorno.Items[xHistorico].GetValue<TDateTime>('horario'));
         TAdvStringGrid(Sender).Cells[2, xHistorico+1]  := TimeToStr((JsonArrayRetorno.Items[xHistorico].GetValue<TDateTime>('horario') ));
         TAdvStringGrid(Sender).Cells[3, xHistorico+1]  := JsonArrayRetorno.Items[xHistorico].GetValue<String>('usuario');
         if FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId = 1 then
            TAdvStringGrid(Sender).Cells[4, xHistorico+1]  := JsonArrayRetorno.Items[xHistorico].GetValue<String>('terminal')
         Else TAdvStringGrid(Sender).Cells[4, xHistorico+1]  := Copy(JsonArrayRetorno.Items[xHistorico].GetValue<String>('terminal'), 1, 6)+
              Repl('*', Length(JsonArrayRetorno.Items[xHistorico].GetValue<String>('terminal'))-6);
         TAdvStringGrid(Sender).Alignments[1, xHistorico+1] := taCenter;
         TAdvStringGrid(Sender).Alignments[2, xHistorico+1] := taCenter;
       End;
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
  Except
    //ShowErro('Aconteceu Aqui');
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
  End;
end;

procedure TFrmRelPedidos.MontaListaPedido(pJsonArray: TJsonArray);
Var xPed, xItens, xDemanda, xPerda, xNProcessado, xProcessado, xConcluido : Integer;
begin
  LstPedidosAdv.RowCount := pjsonArray.Count+1;
  If LstPedidosAdv.RowCount > 1 Then LstPedidosAdv.FixedRows := 1;
  for xPed := 1 to pJsonArray.Count do Begin
    LstPedidosAdv.AddDataImage( 7, xPed, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstPedidosAdv.AddDataImage(25, xPed, 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstPedidosAdv.AddDataImage(26, xPed, 6, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  ImprimirExportar(True);
  LblRegistro.Caption := FormatFloat('#0', pJsonArray.Count);
  xItens       := 0;
  xDemanda     := 0;
  xPerda       := 0;
  xNProcessado := 0;
  xProcessado  := 0;
  xConcluido   := 0;
//  for xPed := 1 to pJsonArray.Count do
//    LstPedidosAdv.AddDataImage(22, xPed, 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
  for xPed := 0 to Pred(pJsonArray.Count) do Begin
    LstPedidosAdv.Cells[0, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('pedidoid');
    LstPedidosAdv.Cells[1, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('documentodata');
    LstPedidosAdv.Cells[2, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('operacao');
    LstPedidosAdv.Cells[3, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('codpessoaerp');
    LstPedidosAdv.Cells[4, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('fantasia');
    if pJsonArray.Get(xPed).GetValue<Integer>('rotaid') = 0 then Begin
       LstPedidosAdv.Colors[3, xPed+1] := ClRed;
       LstPedidosAdv.Colors[4, xPed+1] := ClRed;
    End
    Else begin
       LstPedidosAdv.Colors[3, xPed+1] := LstPedidosAdv.Colors[2, xPed+1];
       LstPedidosAdv.Colors[4, xPed+1] := LstPedidosAdv.Colors[2, xPed+1];
    end;
    LstPedidosAdv.Cells[5, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('etapa');
    if pJsonArray.Get(xPed).GetValue<Integer>('processoid') = 8 then
       LstPedidosAdv.Colors[5, xPed+1] := $00B0FFFF
    Else if pJsonArray.Get(xPed).GetValue<Integer>('processoid') in [10, 12] then
       LstPedidosAdv.Colors[5, xPed+1] := $006FB7FF
    Else If pJsonArray.Get(xPed).GetValue<Integer>('processoid') in [13, 14] then
       LstPedidosAdv.Colors[5, xPed+1] := $00006C00
    Else If (pJsonArray.Get(xPed).GetValue<Integer>('processoid') = 15) Or (pJsonArray.Get(xPed).GetValue<Integer>('processoid') = 31) then
       LstPedidosAdv.Colors[5, xPed+1] := ClRed
    Else
       LstPedidosAdv.Colors[5, xPed+1] := LstPedidosAdv.Colors[2, xPed+1];
    //LstPedidosAdv.Colors[5, xPed+1] := LstPedidosAdv.Colors[2, xPed+1];
    LstPedidosAdv.Cells[6, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('dtprocesso');
    LstPedidosAdv.Cells[7, xPed+1]    := pJsonArray.Get(xPed).GetValue<Integer>('picking').ToString;
    LstPedidosAdv.Cells[8, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('itens');
    LstPedidosAdv.Cells[9, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('demanda');
    LstPedidosAdv.Cells[10, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('qtdsuprida');
    xItens   := xItens + pJsonArray.Get(xPed).GetValue<Integer>('itens');
    xDemanda := xDemanda + pJsonArray.Get(xPed).GetValue<Integer>('demanda');
    if pJsonArray.Get(xPed).GetValue<Integer>('processoid') = 1 then
       xNProcessado := xNProcessado + (pJsonArray.Get(xPed).GetValue<Integer>('demanda'));
    if pJsonArray.Get(xPed).GetValue<Integer>('processoid') > 1 then
       xPerda   := xPerda + (pJsonArray.Get(xPed).GetValue<Integer>('demanda')-pJsonArray.Get(xPed).GetValue<Integer>('qtdsuprida'));
    xProcessado := xProcessado + (pJsonArray.Get(xPed).GetValue<Integer>('processado'));
    xConcluido  := xConcluido  + (pJsonArray.Get(xPed).GetValue<Integer>('concluido'));
    if pJsonArray.Get(xPed).GetValue<Integer>('processoid') > 1 then Begin
       if pJsonArray.Get(xPed).GetValue<Integer>('qtdsuprida') = 0 then
          LstPedidosAdv.Colors[10, xPed+1] := ClRed
       else if pJsonArray.Get(xPed).GetValue<Integer>('qtdsuprida') < pJsonArray.Get(xPed).GetValue<Integer>('demanda') then
          LstPedidosAdv.Colors[10, xPed+1] := ClYellow
       Else if pJsonArray.Get(xPed).GetValue<Integer>('qtdsuprida') = pJsonArray.Get(xPed).GetValue<Integer>('demanda') then
          LstPedidosAdv.Colors[10, xPed+1] := ClGreen
       Else LstPedidosAdv.Colors[10, xPed+1] := LstPedidosAdv.Colors[8, xPed+1];
    End
    Else LstPedidosAdv.Colors[10, xPed+1] := LstPedidosAdv.Colors[8, xPed+1];
    LstPedidosAdv.Cells[11, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('tvolumes');
    LstPedidosAdv.Cells[12, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('tvolcxafechada');
    LstPedidosAdv.Cells[13, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('tvolfracionado');
    LstPedidosAdv.Cells[14, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('cancelado');
    LstPedidosAdv.Cells[15, xPed+1]    := FormatFloat('0.000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('peso'),'.',',',[rfReplaceAll])));
    LstPedidosAdv.Cells[16, xPed+1]    := FormatFloat('0.000000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('volm3'),'.',',',[rfReplaceAll])));
    LstPedidosAdv.Cells[17, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('documentonr');
    LstPedidosAdv.Cells[18, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('documentooriginal');
    LstPedidosAdv.Cells[19, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('notafiscalerp');

    LstPedidosAdv.Cells[20, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('rota');
    LstPedidosAdv.Cells[21, xPed+1]    := pJsonArray.Get(xPed).GetValue<Integer>('cargaid').ToString;//pJsonArray.Get(xPed).GetValue<String>('registroerp');
    LstPedidosAdv.Cells[22, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('processocarga');//pJsonArray.Get(xPed).GetValue<String>('uuid');
    if (pJsonArray.Get(xPed).GetValue<Integer>('processoidcarga') = 16) and (pJsonArray.Get(xPed).GetValue<Integer>('carregamentoid')>0) then
       LstPedidosAdv.Cells[22, xPed+1] := 'Em Carregamento';
    LstPedidosAdv.Cells[23, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('rotaid');
    if (pJsonArray.Get(xPed).GetValue<Integer>('processoid') >= 13) and
       (pJsonArray.Get(xPed).GetValue<Integer>('status') = 5) then
       LstPedidosAdv.Cells[24, xPed+1]   := 'Concluída'
    else LstPedidosAdv.Cells[24, xPed+1] := 'Pendente';
    if pJsonArray.Get(xPed).GetValue<Integer>('processoid') < 13 then
       LstPedidosAdv.Cells[25, xPed+1]    := '2'
    Else LstPedidosAdv.Cells[25, xPed+1]    := '3';
    LstPedidosAdv.Cells[26, xPed+1]    := '6';
    LstPedidosAdv.Cells[27, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('motivoexclusao');
    LstPedidosAdv.Alignments[0, xPed+1] := taRightJustify;
    LstPedidosAdv.FontStyles[0, xPed+1] := [FsBold];
    LstPedidosAdv.Alignments[1, xPed+1] := taCenter;
    LstPedidosAdv.Alignments[7, xPed+1] := taCenter;
    LstPedidosAdv.Alignments[8, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[9, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[10, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[11, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[12, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[13, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[14, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[15, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[16, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[19, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[21, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[23, xPed+1] := taRightJustify;
    LstPedidosAdv.Alignments[25, xPed+1] := taCenter;
    LstPedidosAdv.Alignments[26, xPed+1] := taCenter;
  End;
  LblItens.Caption       := FormatFloat(',0', xItens);
  LblDemanda.Caption     := FormatFloat(',0', xDemanda);
  LblPerda.Caption       := FormatFloat(',0', xPerda);
  LblPercPerda.Caption   := FormatFloat(',0.00',(xPerda / xDemanda * 100))+'%';
  LblNProcessado.Caption := FormatFloat(',0', xNProcessado);
  LblProcessado.Caption  := FormatFloat(',0', xProcessado);
  LblConcluido.Caption   := FormatFloat(',0', xConcluido);
  LblPercNProc.Caption     := FormatFloat(',0.00',(xNprocessado / xDemanda * 100))+'%';
  LblPercProc.Caption      := FormatFloat(',0.00',(xProcessado / xDemanda * 100))+'%';
  LblPercConcluido.Caption := FormatFloat(',0.00',(xConcluido / xDemanda * 100))+'%';
end;

procedure TFrmRelPedidos.MontaListaPedidoResumo(pJsonArray: TJsonArray);
Var xProd : Integer;
begin
  FdMemPesqPedidoResumoAtendimento.LoadFromJSON(pJsonArray, False);
  LstPedidoResumoAdv.RowCount := pjsonArray.Count+1;
  If LstPedidoResumoAdv.RowCount > 1 Then LstPedidoResumoAdv.FixedRows := 1;
  for xProd := 0 to Pred(pJsonArray.Count) do Begin
    LstPedidoResumoAdv.Cells[0, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('produtoid');
    LstPedidoResumoAdv.Cells[1, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('codproduto');
    if (EdtCodProduto.Text<>'') and (StrToIntDef(EdtCodproduto.Text, 0)=pJsonArray.Get(xProd).GetValue<Integer>('codproduto')) then Begin
        LstPedidoResumoAdv.FontColors[1, xProd+1] := $004080FF;
        LstPedidoResumoAdv.FontStyles[1, xProd+1] := [FsBold];
        End
    Else Begin
        LstPedidoResumoAdv.FontColors[1, xProd+1] := LstPedidoResumoAdv.FontColors[0, xProd+1];
        LstPedidoResumoAdv.FontStyles[1, xProd+1] := [];
    End;
    LstPedidoResumoAdv.Cells[2, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('descricao');
    LstPedidoResumoAdv.Cells[3, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('picking');
    LstPedidoResumoAdv.Cells[4, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('zonadescricao');
    LstPedidoResumoAdv.Cells[5, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('demanda');
    LstPedidoResumoAdv.Cells[6, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('embalagempadrao');
    LstPedidoResumoAdv.Cells[7, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('qtdsuprida');
    LstPedidoResumoAdv.Cells[8, xProd+1]    := pJsonArray.Get(xProd).GetValue<String>('volume(cm3)');
    LstPedidoResumoAdv.Cells[9, xProd+1]    := FormatFloat('#0.000', pJsonArray.Get(xProd).GetValue<Double>('peso'));
    if LstPedidosAdv.Cells[5, LstPedidosAdv.Row] <> 'Recebido do ERP' then Begin
       if pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida') = 0 then
          LstPedidoResumoAdv.Colors[7, xProd+1] := ClRed
       Else if pJsonArray.Get(xProd).GetValue<Integer>('demanda') > pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida') then
          LstPedidoResumoAdv.Colors[7, xProd+1] := ClYellow
       Else If pJsonArray.Get(xProd).GetValue<Integer>('demanda') = pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida') then
          LstPedidoResumoAdv.Colors[7, xProd+1] := clGreen
       Else Begin
          LstPedidoResumoAdv.Colors[7, xProd+1] := LstPedidoResumoAdv.Colors[4, xProd+1];
          if pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida') > pJsonArray.Get(xProd).GetValue<Integer>('demanda') then
             LstPedidoResumoAdv.FontColors[7, xProd+1] := clRed
          Else
             LstPedidoResumoAdv.FontColors[7, xProd+1] := LstPedidoResumoAdv.FontColors[6, xProd+1];
       End;
    End
    Else
       LstPedidoResumoAdv.Colors[7, xProd+1] := LstPedidoResumoAdv.Colors[4, xProd+1];
    LstPedidoResumoAdv.Colors[5, xProd+1] := LstPedidoResumoAdv.Colors[7, xProd+1];
    LstPedidoResumoAdv.Colors[6, xProd+1] := LstPedidoResumoAdv.Colors[7, xProd+1];
    LstPedidoResumoAdv.Alignments[0, xProd+1] := taRightJustify;
    LstPedidoResumoAdv.FontStyles[0, xProd+1] := [FsBold];
    LstPedidoResumoAdv.Alignments[5, xProd+1] := taRightJustify;
    LstPedidoResumoAdv.Alignments[7, xProd+1] := taRightJustify;
    LstPedidoResumoAdv.Alignments[8, xProd+1] := taRightJustify;
    LstPedidoResumoAdv.Alignments[9, xProd+1] := taRightJustify;
  End;
  TabVolumes.TabVisible := True;
  TabResumo.TabVisible  := True;
  PgcPedidos.ActivePage := TabResumo;
end;

procedure TFrmRelPedidos.MontaListaVolume(pJsonArray: TJsonArray);
Var xVol : Integer;
begin
  LstVolumesAdv.RowCount := pjsonArray.Count+1;
  If LstVolumesAdv.RowCount > 1 Then LstVolumesAdv.FixedRows := 1;
  for xVol := 1 to pJsonArray.Count do Begin
    LstVolumesAdv.AddDataImage( 8, xVol, 3, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstVolumesAdv.AddDataImage( 9, xVol, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstVolumesAdv.AddDataImage(10, xVol, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  for xVol := 0 to Pred(pJsonArray.Count) do Begin
    LstVolumesAdv.Cells[0, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('pedidovolumeid');
    LstVolumesAdv.Cells[1, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('sequencia');
    LstVolumesAdv.Cells[2, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('embalagem');
    //LstVolumesAdv.Cells[3, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('descricao');
    LstVolumesAdv.Cells[4, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('identificacao');
    LstVolumesAdv.Cells[5, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('tara');
    LstVolumesAdv.Cells[6, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('volumecaixa');
    LstVolumesAdv.Cells[7, xVol+1]    := pJsonArray.Get(xVol).GetValue<String>('processo');
    if (pJsonArray.Get(xVol).GetValue<Integer>('processoid') < 15) And
       (pJsonArray.Items[xVol].GetValue<TJsonObject>('pedido').GetValue<Integer>('processoidped') < 13) then
       LstVolumesAdv.Cells[8, xVol+1]    := '2'
    Else LstVolumesAdv.Cells[8, xVol+1]    := '3';
    if pJsonArray.Get(xVol).GetValue<Integer>('carregamentoid') > 0 then
       LstVolumesAdv.Cells[9, xVol+1]    := '1'
    Else LstVolumesAdv.Cells[9, xVol+1]    := '0';
    LstVolumesAdv.Cells[10, xVol+1]    := '5';
    if pJsonArray.Get(xVol).GetValue<Integer>('processoid') = 13 then
       LstVolumesAdv.Colors[7, xVol+1] := ClRed
    Else LstVolumesAdv.Colors[7, xVol+1] := LstVolumesAdv.Colors[6, xVol+1];
    if pJsonArray.Get(xVol).GetValue<Integer>('processoid') = 8 then
       LstVolumesAdv.Colors[7, xVol+1] := $00B0FFFF
    Else if pJsonArray.Get(xVol).GetValue<Integer>('processoid') in [10, 12] then
       LstVolumesAdv.Colors[7, xVol+1] := $006FB7FF
    Else If pJsonArray.Get(xVol).GetValue<Integer>('processoid') in [13, 14] then
       LstVolumesAdv.Colors[7, xVol+1] := $00006C00
    Else If pJsonArray.Get(xVol).GetValue<Integer>('processoid') = 15 then
       LstVolumesAdv.Colors[7, xVol+1] := ClRed
    Else
       LstVolumesAdv.Colors[7, xVol+1] := LstVolumesAdv.Colors[6, xVol+1];
    LstVolumesAdv.Cells[11, xVol+1] := pJsonArray.Get(xVol).GetValue<String>('processoid');

    LstVolumesAdv.Alignments[0, xVol+1] := taRightJustify;
    LstVolumesAdv.FontStyles[0, xVol+1] := [FsBold];
    LstVolumesAdv.Alignments[1, xVol+1] := taRightJustify;
    LstVolumesAdv.FontStyles[ 4,xVol+1] := [FsBold];
    LstVolumesAdv.Alignments[5, xVol+1] := taRightJustify;
    LstVolumesAdv.Alignments[6, xVol+1] := taRightJustify;
  End;
  TabVolumes.TabVisible := True;
  TabResumo.TabVisible  := True;
end;

procedure TFrmRelPedidos.MontaListaVolumeConsulta(pJsonArrayRetorno: TJsonArray);
Var xVol : Integer;
  vTotVolume, vTotVolumePendente, vTotVolumeExpedido : Integer;
  vTotVolumeCancelado, vTotVolumeCxaFechada, vTotVolumeCxaFracionada   : Integer;
  vTotVolumeExpedidoPerc, vTotVolumeCanceladoPerc : Real;
  vTotVolumeCxaFechadaPerc, vTotVolumeCxaFracionadaPerc : Real;
begin
  LstVolumeConsulta.RowCount := pJsonArrayRetorno.Count+1;
  If LstVolumeConsulta.RowCount > 1 Then
     LstVolumeConsulta.FixedRows := 1;
  ImprimirExportar(LstVolumeConsulta.RowCount > 1);
  for xVol := 1 to pJsonArrayRetorno.Count do Begin
    LstVolumeConsulta.AddDataImage( 4, xVol, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstVolumeConsulta.AddDataImage( 8, xVol, 3, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstVolumeConsulta.AddDataImage( 9, xVol, 1, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstVolumeConsulta.AddDataImage(10, xVol, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  vTotVolume := pJsonArrayRetorno.Count;
  vTotVolumePendente          := 0;
  vTotVolumeExpedido          := 0;
  vTotVolumeExpedidoPerc      := 0;
  vTotVolumeCancelado         := 0;
  vTotVolumeCanceladoPerc     := 0;
  vTotVolumeCxaFechada        := 0;
  vTotVolumeCxaFechadaPerc    := 0;
  vTotVolumeCxaFracionada     := 0;
  vTotVolumeCxaFracionadaPerc := 0;
  For xVol := 0 to Pred(pJsonArrayRetorno.Count) do Begin
    LstVolumeConsulta.Cells[0, xVol+1] := pJsonArrayRetorno.Get(xVol).GetValue<String>('pedidovolumeid');
    LstVolumeConsulta.Cells[1, xVol+1] := pJsonArrayRetorno.Get(xVol).GetValue<String>('sequencia');
    LstVolumeConsulta.Cells[2, xVol+1] := pJsonArrayRetorno.Get(xVol).GetValue<String>('pedidoid');
    LstVolumeConsulta.Cells[3, xVol+1] := pJsonArrayRetorno.Get(xVol).GetValue<String>('embalagem');
    LstVolumeConsulta.Cells[4, xVol+1] := pJsonArrayRetorno.Get(xVol).GetValue<String>('tipo');
    if pJsonArrayRetorno.Get(xVol).GetValue<String>('tipo') = 'E' then
       LstVolumeConsulta.Cells[4, xVol+1] := '1'
    Else
       LstVolumeConsulta.Cells[4, xVol+1]    := '0';
    LstVolumeConsulta.Cells[5, xVol+1]       := pJsonArrayRetorno.Get(xVol).GetValue<String>('identificacao');
    if pJsonArrayRetorno.Get(xVol).GetValue<integer>('volumecaixa') <> 0 then
       LstVolumeConsulta.Cells[6, xVol+1]    := pJsonArrayRetorno.Get(xVol).GetValue<String>('volumecaixa')
    Else LstVolumeConsulta.Cells[6, xVol+1]  := '';
    LstVolumeConsulta.Cells[7, xVol+1]       := pJsonArrayRetorno.Get(xVol).GetValue<String>('processo');
    if (pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') < 15) and
       (pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoidped') < 13) then
       LstVolumeConsulta.Cells[8, xVol+1]    := '2'
    Else LstVolumeConsulta.Cells[8, xVol+1]  := '3';
    if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('cargaid') > 0 then
       LstVolumeConsulta.Cells[9, xVol+1]    := '1'
    Else LstVolumeConsulta.Cells[9, xVol+1]  := '0';
    LstVolumeConsulta.Cells[11, xVol+1]      := pJsonArrayRetorno.Get(xVol).GetValue<String>('processoid');
    if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') = 13 then
       LstVolumeConsulta.Colors[7, xVol+1]   := ClRed
    Else LstVolumeConsulta.Colors[7, xVol+1] := LstVolumeConsulta.Colors[6, xVol+1];
    if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') = 8 then
       LstVolumeConsulta.Colors[7, xVol+1]   := $00B0FFFF
    Else if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') in [10, 12] then
       LstVolumeConsulta.Colors[7, xVol+1]   := $006FB7FF
    Else If pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') in [13, 14] then
       LstVolumeConsulta.Colors[7, xVol+1]   := $00006C00
    Else If pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') = 15 then
       LstVolumeConsulta.Colors[7, xVol+1]   := ClRed
    Else
       LstVolumeConsulta.Colors[7, xVol+1]   := LstVolumeConsulta.Colors[6, xVol+1];
    LstVolumeConsulta.Alignments[0, xVol+1]  := taRightJustify;
    LstVolumeConsulta.FontStyles[0, xVol+1]  := [FsBold];
    LstVolumeConsulta.Alignments[1, xVol+1]  := taRightJustify;
    LstVolumeConsulta.Alignments[2, xVol+1]  := taRightJustify;
    LstVolumeConsulta.Alignments[3, xVol+1]  := taLeftJustify;
    LstVolumeConsulta.Alignments[4, xVol+1]  := taCenter;
    LstVolumeConsulta.Alignments[5, xVol+1]  := taLeftJustify;
    LstVolumeConsulta.FontStyles[5, xVol+1]  := [FsBold];
    LstVolumeConsulta.Alignments[6, xVol+1]  := taRightJustify;
    LstVolumeConsulta.Alignments[7, xVol+1]  := taLeftJustify;
    LstVolumeConsulta.Alignments[8, xVol+1]  := taCenter;
    LstVolumeConsulta.Alignments[9, xVol+1]  := taCenter;
    if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') < 13 Then
       Inc(vTotVolumePendente)
    Else if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') = 13 Then
       Inc(vTotVolumeExpedido)
    Else if pJsonArrayRetorno.Get(xVol).GetValue<Integer>('processoid') = 15 Then
       Inc(vTotVolumeCancelado);
    if pJsonArrayRetorno.Get(xVol).GetValue<String>('embalagem') = 'Caixa Fechada' then
       Inc(vTotVolumeCxaFechada)
    Else
       Inc(vTotVolumeCxaFracionada);
  End;
  vTotVolumeExpedidoPerc      := RoundTo(vTotVolumeExpedido / vTotVolume * 100, -2);
  vTotVolumeCanceladoPerc     := RoundTo(vTotVolumeCancelado / vTotVolume * 100, -2);
  vTotVolumeCxaFechadaPerc    := RoundTo(vTotVolumeCxaFechada / vTotVolume * 100, -2);
  vTotVolumeCxaFracionadaPerc := RoundTo(vTotVolumeCxaFracionada / vTotVolume * 100, -2);
  LblTotVolume.Caption                  := vTotVolume.ToString();
  LblTotVolumePendente.Caption          := vTotVolumePendente.ToString();
  LblTotVolumeExpedido.Caption          := vTotVolumeExpedido.ToString();
  LblTotVolumeCancelado.Caption         := vTotVolumeCancelado.ToString();
  LblTotVolumeCxaFechada.Caption        := vTotVolumeCxaFechada.ToString();
  LblTotVolumeCxaFracionada.Caption     := vTotVolumeCxaFracionada.ToString();
  LblTotVolumeExpedidoPerc.Caption      := FormatFloat('##0.00', vTotVolumeExpedidoPerc);
  LblTotVolumeCanceladoPerc.Caption     := FormatFloat('##0.00', vTotVolumeCanceladoPerc);
  LblTotVolumeCxaFechadaPerc.Caption    := FormatFloat('##0.00', vTotVolumeCxaFechadaPerc);
  LblTotVolumeCxaFracionadaPerc.caption := FormatFloat('##0.00', vTotVolumeCxaFracionadaPerc);
end;

procedure TFrmRelPedidos.MontaListaVolumeProdutos(Sender : TObject; pJsonArray: TJsonArray);
Var xProd : Integer;
    vColor : TColor;
begin
  TAdvStringGrid(Sender).RowCount := pjsonArray.Count+1;
  If TAdvStringGrid(Sender).RowCount > 1 THen TAdvStringGrid(Sender).FixedRows := 1;
  for xProd := 0 to Pred(pJsonArray.Count) do Begin
    TAdvStringGrid(Sender).Cells[0, xProd+1]  := pJsonArray.Get(xProd).GetValue<String>('codproduto');
    TAdvStringGrid(Sender).Cells[1, xProd+1]  := pJsonArray.Get(xProd).GetValue<String>('descricao');
    TAdvStringGrid(Sender).Cells[2, xProd+1]  := pJsonArray.Get(xProd).GetValue<String>('lote');
    TAdvStringGrid(Sender).Cells[3, xProd+1]  := pJsonArray.Get(xProd).GetValue<String>('vencimento');
    TAdvStringGrid(Sender).Cells[4, xProd+1]  := EnderecoMask(pJsonArray.Get(xProd).GetValue<String>('endereco'),
                                                            pJsonArray.Get(xProd).GetValue<String>('mascara'), True);
    TAdvStringGrid(Sender).Cells[5, xProd+1]  := pJsonArray.Get(xProd).GetValue<String>('zona');
    if pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida') = 0 then
       vColor := ClRed
    Else If pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida') < pJsonArray.Get(xProd).GetValue<Integer>('demanda') then
       vColor := clYellow
    Else vColor := TAdvStringGrid(Sender).Colors[4, xProd+1];
    TAdvStringGrid(Sender).Cells[6, xProd+1]  := pJsonArray.Get(xProd).GetValue<Integer>('demanda').toString;
    TAdvStringGrid(Sender).Colors[6, xProd+1] := vColor;
    if ((PgcBase.ActivePage = TabPrincipal) and ((LstVolumesAdv.Cells[7, LstVolumesAdv.Row] = 'Processado') or
       (LstVolumesAdv.Cells[8, LstVolumesAdv.Row] = 'Etiqueta Impressa'))) or
       ((PgcBase.ActivePage = TabRelVolumes) and ((LstVolumeConsulta.Cells[7, LstVolumeConsulta.Row] = 'Processado') or
       (LstVolumeConsulta.Cells[8, LstVolumeConsulta.Row] = 'Etiqueta Impressa'))) then
       TAdvStringGrid(Sender).Cells[7, xProd+1]  := '0'
    Else
       TAdvStringGrid(Sender).Cells[7, xProd+1]  := pJsonArray.Get(xProd).GetValue<Integer>('qtdsuprida').ToString;

    TAdvStringGrid(Sender).Colors[7, xProd+1] := vColor;
    TAdvStringGrid(Sender).Cells[8, xProd+1]  := FormatFloat('#0.000', pJsonArray.Get(xProd).GetValue<Double>('pesokg'));
    TAdvStringGrid(Sender).Cells[9, xProd+1]  := FormatFloat('#0.000000', pJsonArray.Get(xProd).GetValue<Double>('volm3'));
    TAdvStringGrid(Sender).Cells[10, xProd+1]  := pJsonArray.Get(xProd).GetValue<string>('nome');
    TAdvStringGrid(Sender).Cells[11, xProd+1] := FormatDateTime('DD/MM/YYYY hh:mm:ss', pJsonArray.Get(xProd).GetValue<TDateTime>('horario'));
    TAdvStringGrid(Sender).Cells[12, xProd+1] := pJsonArray.Get(xProd).GetValue<string>('terminal');//TimeToStr((pJsonArray.Get(xProd).GetValue<TDateTime>('horario') ));

    TAdvStringGrid(Sender).Alignments[ 0, xProd+1] := taRightJustify;
    TAdvStringGrid(Sender).FontStyles[ 0, xProd+1] := [FsBold];
    TAdvStringGrid(Sender).Alignments[ 3, xProd+1] := taCenter;
    TAdvStringGrid(Sender).Alignments[ 4, xProd+1] := taCenter;
    TAdvStringGrid(Sender).Alignments[ 6, xProd+1] := taRightJustify;
    TAdvStringGrid(Sender).Alignments[ 7, xProd+1] := taRightJustify;
    TAdvStringGrid(Sender).Alignments[ 8, xProd+1] := taRightJustify;
    TAdvStringGrid(Sender).Alignments[ 9, xProd+1] := taRightJustify;
    TAdvStringGrid(Sender).Alignments[11, xProd+1] := taCenter;
  End;
end;

procedure TFrmRelPedidos.PesquisarVolumes;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonObjectRetorno   : TJsonObject;
    vEstruturaId        : Integer;
    vVolumePendente     : Integer;
    vErro : String;
begin
{  if (EdtDtPedidoInicial_AnalRua.Date = 0) and (EdtDtPedidoFinal_AnalRua.Date = 0) then Begin
     EdtDtPedidoInicial_AnalRua.SetFocus;
     ShowErro('Informe o Período para a pesquisa!');
     Exit;
  End;
  if (vCodProdutoVolume=0) and (EdtCodProduto_AnalRua.Text<>'') then  Begin
     EdtCodProduto_AnalRua.SetFocus;
     EdtCodProdutoExit(EdtCodProduto_AnalRua);
     Exit;
  End;
}  if (not ChkResumoPorVolume.Checked) and (not ChkAnalisePorRua.Checked)  and (not ChkAnalisePorSetor.Checked)  and
     (not ChkAnalisePorRota.Checked) and (not ChkAnalisePorLoja.Checked) then Begin
     ShowErro('Selecione o(s) relatórios para gerar!');
     Exit;
  End;
  if (EdtPedido_AnalRua.Text<>'') and (StrToIntDef(EdtPedido_AnalRua.Text, 0)<=0) then Begin
     EdtPedido_AnalRua.SetFocus;
     ShowErro('Id('+EdtPedido_AnalRua.Text+')do Pedido inválido!');
     EdtPedidoVolumeId.Clear;
     Exit;
  End;
  if (EdtPedidoVolumeId.Text<>'') and (StrToIntDef(EdtPedidoVolumeId.Text, 0)<=0) then Begin
     EdtPedidoVolumeId.SetFocus;
     ShowErro('Id('+EdtPedidoVolumeId.Text+') do Volume inválido!');
     EdtPedidoVolumeId.Clear;
     Exit;
  End;
  if (EdtRotaId_AnalRua.Text<>'') and (StrToIntDef(EdtRotaId_AnalRua.Text, 0)<=0) then Begin
     EdtRotaId_AnalRua.SetFocus;
     ShowErro('Id('+EdtRotaId_AnalRua.Text+') da Rota inválido!');
     EdtRotaId_AnalRua.Clear;
     Exit;
  End;
  if (EdtDestinatario_AnalRua.Text<>'') and (StrToIntDef(EdtDestinatario_AnalRua.Text, 0)<=0) then Begin
     ShowErro('Id do Destinatário inválido!');
     Exit;
  End;
  if (EdtProcessoId_AnalRua.Text<>'') and (StrToIntDef(EdtProcessoId_AnalRua.Text, 0)<=0) then Begin
     EdtProcessoId_AnalRua.SetFocus;
     ShowErro('Id do Processo inválido!');
     EdtProcessoId_AnalRua.Clear;
     Exit;
  End;
  if (EdtCodProduto_AnalRua.Text<>'') and (StrToInt64Def(EdtCodProduto_AnalRua.Text, 0)<=0) then Begin
     EdtCodProduto_AnalRua.SetFocus;
     ShowErro('Id('+EdtCodProduto_AnalRua.Text+') do Processo inválido!');
     EdtCodProduto_AnalRua.Clear;
     Exit;
  End;
  if (EdtDtPedidoInicial_AnalRua.Date = 0) and (EdtDtPedidoFinal_AnalRua.Date = 0) and (StrToIntDef(EdtPedido_AnalRua.Text, 0) = 0) and
     (StrToIntDef(EdtPedidoVolumeId.Text, 0) = 0) and (EdtDocumentoNr_AnalRua.Text='') and (StrToIntDef(EdtDestinatario_AnalRua.Text, 0) = 0) and
     (StrToIntDef(EdtProcessoId_AnalRua.Text, 0) = 0) and (StrToIntDef(EdtRotaId_AnalRua.Text, 0) = 0) and (StrToInt64Def(EdtCodProduto_AnalRua.Text, 0) = 0) then Begin
     ShowErro('Informe o filtro para a pesquisa!');
     Exit;
  End;
  if ((ChkPulmao.Checked) and (ChkPicking.Checked)) or
     ((Not ChkPulmao.Checked) and (Not ChkPicking.Checked)) then
     vEstruturaId := 0
  Else if (ChkPulmao.Checked) then
     vEstruturaId := 1
  Else if (ChkPicking.Checked) then
     vEstruturaId := 2;
  if ChkvolumePendente.Checked then
     vVolumePendente := 1
  Else
     vVolumePendente := 0;
  if ChkResumoPorVolume.Checked then Begin
     TDialogMessage.ShowWaitMessage('👨‍💼'+'Aguarde! Estou trabalhando para buscar os dados...',
       procedure
          procedure GetVolumeConsulta(pDataInicial, pDataFinal : TDateTime; pPedidoId, pPedidoVolumeId : Integer;
                                      pDocumentoNr : String; pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto , pPendente : Integer);
          Var JsonArrayRetorno    : TJsonArray;
              ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
              pEmbalagem : String;
              vErro      : String;
          begin
            case CbEmbalagem.ItemIndex Of
              0: pEmbalagem := 'T';
              1: pEmbalagem := 'F';
              2: pEmbalagem := 'B';
            end;
            JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeConsulta(pDataInicial, pDataFinal, pPedidoId, pPedidoVolumeId,
                                        pDocumentoNr, pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto,
                                        StrToIntDef(EdtZonaId_Volume.Text, 0), pPendente, pEmbalagem);
            if JsonArrayRetorno.Items[0].tryGetValue<String>('MSG', vErro) then Begin
               LstVolumeConsulta.ClearRect(0, 1, LstVolumeConsulta.ColCount-1, LstVolumeConsulta.RowCount-1);
               LstVolumeConsulta.RowCount := 1;
               ShowMSG(vErro);
            End
            Else if JsonArrayRetorno.Items[0].tryGetValue<String>('Erro', vErro) then Begin
               LstVolumeConsulta.ClearRect(0, 1, LstVolumeConsulta.ColCount-1, LstVolumeConsulta.RowCount-1);
               LstVolumeConsulta.RowCount := 1;
               ShowErro('Erro: '+vErro);
            End
            Else Begin
               If FDMemVolumeConsulta.Active then
                  FDMemVolumeConsulta.EmptyDataSet;
               FDMemVolumeConsulta.Close;
               FDMemVolumeConsulta.LoadFromJSON(JsonArrayRetorno, False);
               MontaListaVolumeConsulta(JsonArrayRetorno);
               ImprimirExportar(LstVolumeConsulta.RowCount > 1);
               BuscarVolumeClick(LstVolumeConsulta, 1, 0);
            End;
          end;
       begin
         GetVolumeConsulta(EdtDtPedidoInicial_AnalRua.Date, EdtDtPedidoFinal_AnalRua.Date,
                           StrToIntDef(EdtPedido_AnalRua.Text, 0), StrToIntDef(EdtPedidoVolumeId.Text, 0),
                           EdtDocumentoNr_AnalRua.Text, 0, StrToIntDef(EdtDestinatario_AnalRua.Text, 0),
                           StrToIntDef(EdtProcessoId_AnalRua.Text, 0), StrToIntDef(EdtRotaId_AnalRua.Text, 0),
                           vCodProdutoVolume, vVolumePendente );
       End);
  End;
  if ChkAnalisePorRua.Checked then Begin
     TDialogMessage.ShowWaitMessage('Buscando Dados para Análise por Rua...',
       procedure
       begin
         If FDMemAnalisePorRua.Active then
            FDMemAnalisePorRua.EmptyDataSet;
         FDMemAnalisePorRua.Close;
         ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
         JsonObjectRetorno    := ObjPedidoVolumeCtrl.GetProducaoDiariaPorRua(EdtDtPedidoInicial_AnalRua.Date,
                                EdtDtPedidoFinal_AnalRua.Date, vEstruturaId);
         if JsonObjectRetorno.TryGetValue('Erro', vErro) then
            ShowErro('Erro: '+vErro)
         Else if JsonObjectRetorno.TryGetValue('MSG', vErro) then
            ShowMSG(vErro)
         Else Begin
            If FDMemAnalisePorRua.Active then
               FDMemAnalisePorRua.EmptyDataSet;
            FDMemAnalisePorRua.Close;
            FdMemAnalisePorRua.LoadFromJSON(JsonObjectRetorno, False);
            MontaListaAnalisePorRua(JsonObjectRetorno);
            ImprimirExportar(True);
         End;
         JsonObjectRetorno := Nil;
         ObjPedidoVolumeCtrl.Free;
      End);
  End;
  if ChkAnalisePorSetor.Checked then Begin
     TDialogMessage.ShowWaitMessage('Buscando Dados para Análise por Rua...',
       procedure
       begin
         If FDMemAnalisePorSetor.Active then
            FDMemAnalisePorSetor.EmptyDataSet;
         FDMemAnalisePorSetor.Close;
         ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
         JsonObjectRetorno    := ObjPedidoVolumeCtrl.GetProducaoDiariaPorSetor(EdtDtPedidoInicial_AnalRua.Date,
                                EdtDtPedidoFinal_AnalRua.Date, vEstruturaId);
         if JsonObjectRetorno.TryGetValue('Erro', vErro) then
            ShowErro('Erro: '+vErro)
         Else Begin
            If FDMemAnalisePorSetor.Active then
               FDMemAnalisePorSetor.EmptyDataSet;
            FDMemAnalisePorSetor.Close;
            FdMemAnalisePorSetor.LoadFromJSON(JsonObjectRetorno, False);
            MontaListaAnalisePorSetor(JsonObjectRetorno);
            ImprimirExportar(True);
         End;
         JsonObjectRetorno := Nil;
         ObjPedidoVolumeCtrl.Free;
      End);
  End;

  if ChkAnalisePorRota.Checked then Begin
     TDialogMessage.ShowWaitMessage('Buscando Dados para Análise por Rota...',
       procedure
       begin
         If FDMemAnalisePorRota.Active then
            FDMemAnalisePorRota.EmptyDataSet;
         FDMemAnalisePorRota.Close;
         ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
         JsonObjectRetorno    := ObjPedidoVolumeCtrl.GetProducaoDiariaPorRota(EdtDtPedidoInicial_AnalRua.Date,
                                EdtDtPedidoFinal_AnalRua.Date, vEstruturaId);
         if JsonObjectRetorno.TryGetValue('Erro', vErro) then
            ShowErro('Erro: '+vErro)
         Else Begin
            If FDMemAnalisePorRota.Active then
               FDMemAnalisePorRota.EmptyDataSet;
            FDMemAnalisePorRota.Close;
            FdMemAnalisePorRota.LoadFromJSON(JsonObjectRetorno, False);
            MontaListaAnalisePorRota(JsonObjectRetorno);
            ImprimirExportar(True);
         End;
         JsonObjectRetorno := Nil;
         ObjPedidoVolumeCtrl.Free;
      End);
  End;
  if ChkAnalisePorLoja.Checked then Begin
     TDialogMessage.ShowWaitMessage('Buscando Dados para Análise por Loja...',
       procedure
       begin
         If FDMemAnalisePorLoja.Active then
            FDMemAnalisePorLoja.EmptyDataSet;
         FDMemAnalisePorLoja.Close;
         ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
         JsonObjectRetorno    := ObjPedidoVolumeCtrl.GetProducaoDiariaPorLoja(EdtDtPedidoInicial_AnalRua.Date,
                                EdtDtPedidoFinal_AnalRua.Date, vEstruturaId);
         if JsonObjectRetorno.TryGetValue('Erro', vErro) then
            ShowErro('Erro: '+vErro)
         Else Begin
            If FDMemAnalisePorLoja.Active then
               FDMemAnalisePorLoja.EmptyDataSet;
            FDMemAnalisePorLoja.Close;
            FdMemAnalisePorLoja.LoadFromJSON(JsonObjectRetorno, False);
            MontaListaAnalisePorLoja(JsonObjectRetorno);
            ImprimirExportar(True);
         End;
         JsonObjectRetorno := Nil;
         ObjPedidoVolumeCtrl.Free;
      End);
  End;
end;

procedure TFrmRelPedidos.PosicionarPedido(pPedidoId: Integer);
Var xRow : Integer;
begin
  For xRow := 1 to Pred(LstPedidosAdv.RowCount) do Begin
    if LstPedidosAdv.Ints[0, xRow] = pPedidoId then Begin
       LstPedidosAdv.Row := xRow;
       Break;
    End;
  End;
end;

procedure TFrmRelPedidos.ReimpressaoTAGVolume(pPedidoVolumeId, pTipoEmbalagem : Integer);   //pTipoEmbalagem 0-Fechada 1-Fracionado
Var vPrintTag, vEmbalagem : Integer;
    ObjPedidoVolumeCtrl    : TPedidoVOlumeCtrl;
    jsonEtiquetasPorVolume : tjsonArray;
    vErro, vPredIni, vPredFin, pMascara, vEmbIdentificacao : String;
    vCaixaEmbalagemId : Integer;
begin
  vPrintTag  := 2;
  vEmbalagem := 2;
  if (pTipoEmbalagem = 1)then Begin
     ObjPedidoVolumeCtrl := TPedidoVOlumeCtrl.Create;
     jsonEtiquetasPorVolume := ObjPedidoVolumeCtrl.EtiquetasPorVolume(pPedidoVolumeId);  //Fracionados
     if jsonEtiquetasPorVolume.Items[0].tryGetValue<String>('Erro', vErro) then Begin
        ShowErro('Erro na Impressão. Volume: '+pPedidoVolumeId.ToString()+' - '+vErro);
        jsonEtiquetasPorVolume := Nil;
        ObjPedidoVolumeCtrl.Free;
     End;
     vCaixaEmbalagemId := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('embalagemid');
     jsonEtiquetasPorVolume := ObjPedidoVolumeCtrl.EtiquetasPorVolume(pPedidoVolumeId);
     If (jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid') > 2)and
        (jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid') <> 15) then Begin
        pMascara           := jsonEtiquetasPorVolume.Items[0].GetValue<String>('mascara');
        vPredini           := jsonEtiquetasPorVolume.Items[0].GetValue<String>('inicio');
        vPredIni           := copy(EnderecoMask(vPredIni, pMascara, True), 1, 5);
        vPredFin           := jsonEtiquetasPorVolume.items[0].GetValue<String>('termino');
        vPredFin           := copy(EnderecoMask(vPredFin, pMascara, True), 1, 5);
        vEmbIdentificacao  :=  jsonEtiquetasPorVolume.items[0].GetValue<String>('embidentificacao');
        if (Assigned(frmPrintTAG) = False) then
           FrmPrintTAG := TfrmPrintTAG.Create(Application);
        try
          FrmPrintTAG.EdtPedidoVolumeId.Text := pPedidoVolumeId.ToString;
          FrmPrintTAG.RbProcesso.ItemIndex   := 1;
          FrmPrintTAG.Module     := 'Relatórios';
          FrmPrintTAG.ModuleMenu := 'Impressão Tag';
          if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqPpla' ) then Begin
             FrmPrintTag.TagVolumeFracionado8x10etqPpla(
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('pedidoid'),
                         pPedidoVolumeId,
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('sequencia'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('codpessoaerp'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('ordem'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('itens'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('qtdsuprida'), jsonEtiquetasPorVolume.Items[0].GetValue<String>('fantasia'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<String>('rotas'), vPredini, vPredFin, DateEUAToBr( jsonEtiquetasPorVolume.Items[0].GetValue<String>('dtpedido')),       // DateToStr(StrToDate(jsonEtiquetasPorVolume.Items[0].GetValue<String>('dtpedido'))),
                         jsonEtiquetasPorVolume.Items[0].GetValue<String>('documentooriginal'), jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('rotaid'), jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('totalvolumes'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<String>('zona'), vEmbIdentificacao)
          End
          Else if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqEpl2' ) then Begin
             FrmPrintTag.TagVolumeFracionado8x10etqEpl2(jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('pedidoid'),
                         pPedidoVolumeId, jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('sequencia'), jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('codpessoaerp'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('ordem'), jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('itens'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('qtdsuprida'), jsonEtiquetasPorVolume.Items[0].GetValue<String>('fantasia'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<String>('rotas'), vPredini, vPredFin, DateEUAToBr(jsonEtiquetasPorVolume.Items[0].GetValue<String>('dtpedido')),
                         jsonEtiquetasPorVolume.Items[0].GetValue<String>('documentooriginal'), jsonEtiquetasPorVolume.Items[0].GetValue<String>('zona'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<String>('endereco'), jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid'),
                         jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('rotaid'), jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('totalvolumes'),
                         vEmbIdentificacao)
          End;
        except on e: Exception do
          begin
            FreeAndNil(frmPrintTAG);
            raise Exception.Create(e.Message);
          end;
        end;
     End;
  End
  Else Begin
     if (Assigned(frmPrintTAG) = False) then
        FrmPrintTAG := TfrmPrintTAG.Create(Application);
     try
       //Buscar os dados para o VOlume
       FrmPrintTAG.EdtPedidoVolumeId.Text := pPedidoVolumeId.ToString;
       FrmPrintTAG.RbProcesso.ItemIndex := 1;
       FrmPrintTAG.Module     := 'Relatórios';
       FrmPrintTAG.ModuleMenu := 'Impressão Tag';
       if FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 0 then //Padrão eXactWMS
          FrmPrintTag.TagVolumeCaixaFechada8x10etqEpl2(pPedidoVolumeId)
       Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 1 then //Padrão eXactWMS com Endereço
          FrmPrintTag.TagVolumeCaixaFechada_Address_8x10etqEpl2(pPedidoVolumeId)
       Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 2 then Begin //Destaque para Cliente e Rota
          if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqEpl2' ) then
              FrmPrintTag.TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqEpl2(pPedidoVolumeId)
          Else if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqPpla' ) then
              FrmPrintTag.TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqPpla(pPedidoVolumeId);
       End;
     except on e: Exception do
       begin
         FreeAndNil(frmPrintTAG);
         raise Exception.Create(e.Message);
       end;
     end;
  End;
  jsonEtiquetasPorVolume := Nil;
  ObjPedidoVolumeCtrl.Free;
end;

procedure TFrmRelPedidos.TabAnalisePorLojaShow(Sender: TObject);
begin
  inherited;
  ImprimirExportar(LstAnalisePorLoja.RowCount>1);
end;

procedure TFrmRelPedidos.TabAnalisePorRotaShow(Sender: TObject);
begin
  inherited;
  ImprimirExportar(LstAnalisePorRota.RowCount>1);
end;

procedure TFrmRelPedidos.TabAnalisePorRuaShow(Sender: TObject);
begin
  inherited;
  ImprimirExportar(LstAnalisePorRua.RowCount>1);
end;

procedure TFrmRelPedidos.TabAnalisePorSetorShow(Sender: TObject);
begin
  inherited;
  ImprimirExportar(LstAnalisePorSetor.RowCount>1);
end;

procedure TFrmRelPedidos.TabPedidosShow(Sender: TObject);
begin
  inherited;
  TabVolumes.TabVisible := False;
  TabResumo.TabVisible  := False;
end;

procedure TFrmRelPedidos.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  ImprimirExportar(LstPedidosAdv.RowCount>1);
end;

procedure TFrmRelPedidos.TabRelVolumesShow(Sender: TObject);
begin
  inherited;
  CbEmbalagem.ItemIndex := 0;
  EdtDtPedidoInicial_AnalRua.SetFocus;
  if (PgcVolumesGeral.ActivePage = TabVolumeResumo) then
     ImprimirExportar(LstVolumeConsulta.RowCount>1)
  Else if (PgcVolumesGeral.ActivePage = TabAnalisePorSetor) then
     ImprimirExportar(LstAnalisePorSetor.RowCount>1)
  Else if (PgcVolumesGeral.ActivePage = TabAnalisePorRua) then
     ImprimirExportar(LstAnalisePorRua.RowCount>1)
  Else if (PgcVolumesGeral.ActivePage = TabAnalisePorRota) then
     ImprimirExportar(LstAnalisePorRota.RowCount>1)
  Else if (PgcVolumesGeral.ActivePage = TabAnalisePorLoja) then
     ImprimirExportar(LstAnalisePorLoja.RowCount>1)
  Else
     ImprimirExportar(False);
end;

procedure TFrmRelPedidos.TabVolumeResumoShow(Sender: TObject);
begin
  inherited;
  ImprimirExportar(LstVolumeConsulta.RowCount>1);
end;

procedure TFrmRelPedidos.TotalizarLstAnalise(Sender : TObject);
Var xLinha : Integer;
    Totvolumecxafechada, Totvolumefracionado   : Integer;
    Totunidadecxafechada, Totunidadefracionado : Integer;
begin
  TAdvStringGrid(Sender).Cells[1, TAdvStringGrid(Sender).RowCount-1] := 'Total';
  Totvolumecxafechada  := 0;
  Totvolumefracionado  := 0;
  Totunidadecxafechada := 0;
  Totunidadefracionado := 0;
  for xLinha := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
    Totvolumecxafechada  := Totvolumecxafechada+StrToIntDef(TAdvStringGrid(Sender).Cells[2, xLinha], 0);
    Totvolumefracionado  := Totvolumefracionado+StrToIntDef(TAdvStringGrid(Sender).Cells[3, xLinha], 0);
    Totunidadecxafechada := Totunidadecxafechada+StrToIntDef(TAdvStringGrid(Sender).Cells[4, xLinha], 0);
    Totunidadefracionado := Totunidadefracionado+StrToIntDef(TAdvStringGrid(Sender).Cells[5, xLinha], 0);
  End;
  TAdvStringGrid(Sender).Cells[2, TAdvStringGrid(Sender).RowCount-1] := Totvolumecxafechada.ToString();
  TAdvStringGrid(Sender).Cells[3, TAdvStringGrid(Sender).RowCount-1] := Totvolumefracionado.ToString();
  TAdvStringGrid(Sender).Cells[4, TAdvStringGrid(Sender).RowCount-1] := Totunidadecxafechada.ToString();
  TAdvStringGrid(Sender).Cells[5, TAdvStringGrid(Sender).RowCount-1] := Totunidadefracionado.ToString();
  TAdvStringGrid(Sender).Cells[6, TAdvStringGrid(Sender).RowCount-1] := (Totvolumecxafechada+Totvolumefracionado).ToString();
  TAdvStringGrid(Sender).Cells[7, TAdvStringGrid(Sender).RowCount-1] := (Totunidadecxafechada+Totunidadefracionado).ToString();
end;

procedure TFrmRelPedidos.TotalizarLstAnalisePorRua;
Var Totvolumecxafechada, Totvolumefracionado   : Integer;
    Totunidadecxafechada, Totunidadefracionado : Integer;
    xLinha : Integer;
begin
  Totvolumecxafechada  := 0;
  Totvolumefracionado  := 0;
  Totunidadecxafechada := 0;
  Totunidadefracionado := 0;
  For xLinha := 1 to Pred(LstAnalisePorRua.RowCount) do Begin
    Totvolumecxafechada  := Totvolumecxafechada+StrToIntDef(LstAnalisePorRua.Cells[3, xLinha], 0);
    Totvolumefracionado  := Totvolumefracionado+StrToIntDef(LstAnalisePorRua.Cells[4, xLinha], 0);
    Totunidadecxafechada := Totunidadecxafechada+StrToIntDef(LstAnalisePorRua.Cells[5, xLinha], 0);
    Totunidadefracionado := Totunidadefracionado+StrToIntDef(LstAnalisePorRua.Cells[6, xLinha], 0);
  End;
  LstAnalisePorRua.RowHeights[LstAnalisePorRua.RowCount-1] := 35;
  LstAnalisePorRua.Cells[0, LstAnalisePorRua.RowCount-1]   := '';
  LstAnalisePorRua.Cells[1, LstAnalisePorRua.RowCount-1]   := 'Total';
  LstAnalisePorRua.Cells[2, LstAnalisePorRua.RowCount-1]   := '';
  LstAnalisePorRua.Cells[3, LstAnalisePorRua.RowCount-1]   := Totvolumecxafechada.ToString();
  LstAnalisePorRua.Cells[4, LstAnalisePorRua.RowCount-1]   := Totvolumefracionado.ToString();
  LstAnalisePorRua.Cells[5, LstAnalisePorRua.RowCount-1]   := Totunidadecxafechada.ToString();
  LstAnalisePorRua.Cells[6, LstAnalisePorRua.RowCount-1]   := Totunidadefracionado.ToString();
  LstAnalisePorRua.Cells[7, LstAnalisePorRua.RowCount-1]   := (Totvolumecxafechada+Totvolumefracionado).ToString();
  LstAnalisePorRua.Cells[8, LstAnalisePorRua.RowCount-1]   := (Totunidadecxafechada+Totunidadefracionado).ToString();
end;

procedure TFrmRelPedidos.TotalizarLstVolumeConsulta;
begin

end;

end.
