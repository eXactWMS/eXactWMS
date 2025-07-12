unit uFrmRelMapaCarga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, System.JSON, REST.Json, Rest.Types,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage, AdvLookupBar, AdvGridLookupBar,
  Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, Generics.Collections,
  CargasCtrl, JvToolEdit, JvBaseEdits, Vcl.DialogMessage,

  frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, frxRich, frxCross, frxOLE, frxBarcode, frxChBox, frxGradient,

  dxCameraControl, PessoaCtrl;

type
  TFrmRelMapaCarga = class(TFrmReportBase)
    FDMemCargaPessoas: TFDMemTable;
    FDMemCargaPessoasCargaId: TIntegerField;
    FDMemCargaPessoasPessoaId: TIntegerField;
    FDMemCargaPessoasRazao: TStringField;
    FDMemCargaPessoasOrdem: TIntegerField;
    FDMemCargaPessoasCodPessoaERP: TIntegerField;
    DsCargaPessoas: TDataSource;
    FDMemCargaPedidos: TFDMemTable;
    FDMemCargaPedidosCargaId: TIntegerField;
    FDMemCargaPedidosPedidoId: TIntegerField;
    FDMemCargaPedidosPessoaId: TIntegerField;
    FDMemCargaPedidosQtdVolume: TIntegerField;
    FDMemCargaPedidosItens: TIntegerField;
    DsCargaPedidos: TDataSource;
    FdMemPesqGeralCargaId: TIntegerField;
    FdMemPesqGeralDtInclusao: TDateField;
    FdMemPesqGeralHrInclusao: TTimeField;
    FdMemPesqGeralRotaId: TIntegerField;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralTranspId: TIntegerField;
    FdMemPesqGeralMotoristaId: TIntegerField;
    FdMemPesqGeralMotorista: TStringField;
    FdMemPesqGeralVeiculoId: TIntegerField;
    FdMemPesqGeralPlaca: TStringField;
    FDMemCargaPessoasPedidoId: TIntegerField;
    FDMemCargaPessoasQtdVolume: TIntegerField;
    FDMemCargaPessoasItens: TIntegerField;
    FdMemPesqGeralTDestinatario: TIntegerField;
    FdMemPesqGeralTPedido: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FDMemCargaPessoasDocumentoNr: TStringField;
    FDMemCargaPedidosDocumentoNr: TStringField;
    FDMemCargaPedidosDocumentoOriginal: TStringField;
    frxMapaCarga: TfrxReport;
    frxDBCargas: TfrxDBDataset;
    frxDBCargaPessoas: TfrxDBDataset;
    frxDBCargaPedidos: TfrxDBDataset;
    FDMemCargaPessoasDocumentoOriginal: TStringField;
    FdMemPesqGeralTransportadora: TStringField;
    Label2: TLabel;
    EdtCargaId: TJvCalcEdit;
    Label13: TLabel;
    LblProcesso: TLabel;
    GbPeriodoCarga: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EdtDtInicio: TJvDateEdit;
    EdtDtTermino: TJvDateEdit;
    GbProcesso: TGroupBox;
    Label4: TLabel;
    LblProcessoPesq: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    FDMemResumoCargas: TFDMemTable;
    DsResumoCargas: TDataSource;
    FdMemCargaPedidoVolumes: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    DsCargaPedidoVolumes: TDataSource;
    FdMemCargaPedidoVolumesPedidoVolumeid: TIntegerField;
    FdMemCargaPedidoVolumesUsuarioId: TIntegerField;
    FdMemCargaPedidoVolumesUsuario: TStringField;
    FdMemCargaPedidoVolumesData: TDateField;
    FdMemCargaPedidoVolumesHora: TTimeField;
    FdMemCargaPedidoVolumesTerminal: TStringField;
    FdMemCargaPedidoVolumesConferido: TIntegerField;
    FrxPedidoVolumes: TfrxDBDataset;
    FDMemCargaPessoasFantasia: TStringField;
    FdMemCargaPedidoVolumesEmbalagem: TStringField;
    FdMemCargaPedidoVolumesQtdSuprida: TIntegerField;
    RbTipoRelatorio: TRadioGroup;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralStatusOper: TIntegerField;
    frxRomaneio: TfrxReport;
    FDMemCargaPedidosDocumentoData: TDateField;
    FDMemCargaPedidosNotaFiscalERP: TStringField;
    FDMemCargaPessoasDocumentoData: TDateField;
    FDMemCargaPessoasNotaFiscalERP: TStringField;
    FdMemPedidosParaCarga: TFDMemTable;
    FdMemPedidosParaCargaDocumentoData: TDateField;
    FdMemPedidosParaCargaCodPessoaERP: TIntegerField;
    FdMemPedidosParaCargafantasia: TStringField;
    FdMemPedidosParaCargaNotaFiscalERP: TStringField;
    FdMemPedidosParaCargaDocumentoOriginal: TStringField;
    FdMemPedidosParaCargaPedidoid: TIntegerField;
    FdMemPedidosParaCargaQtdVolume: TIntegerField;
    FdMemPedidosParaCargaProcesso: TStringField;
    frxPedidoParaCarga: TfrxReport;
    frxDBPedidoParaCarga: TfrxDBDataset;
    GbRota: TGroupBox;
    Label3: TLabel;
    BtnPesqRota: TBitBtn;
    LblRota: TLabel;
    BtnPesqRotaFinal: TBitBtn;
    Label7: TLabel;
    LblRotaFinal: TLabel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    LblZona: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatarioId: TEdit;
    BtnPesqDestinatario: TBitBtn;
    RbOrdem: TRadioGroup;
    FDMemAnaliseConsolidada: TFDMemTable;
    DsAnaliseConsolidada: TDataSource;
    FDMemAnaliseConsolidadaFantasia: TStringField;
    FDMemAnaliseConsolidadaRotaId: TIntegerField;
    FDMemAnaliseConsolidadaRota: TStringField;
    FDMemAnaliseConsolidadaTotPedido: TIntegerField;
    FDMemAnaliseConsolidadaTotVolume: TIntegerField;
    FDMemAnaliseConsolidadaTotVolumeExpedido: TIntegerField;
    FDMemAnaliseConsolidadaTotVolumeCancelado: TIntegerField;
    FDMemAnaliseConsolidadaTotVolumePendente: TIntegerField;
    FDMemAnaliseConsolidadaPesoKg: TFloatField;
    frxAnaliseConsolidada: TfrxReport;
    frxDBAnaliseConsolidada: TfrxDBDataset;
    FDMemAnaliseConsolidadaCodPessoaERP: TIntegerField;
    FDMemAnaliseConsolidadaVolCm3: TFloatField;
    FDMemAnaliseConsolidadaVolM3: TFloatField;
    FdMemPedidosParaCargaZona: TStringField;
    EdtRotaid: TEdit;
    EdtRotaFinalid: TEdit;
    ChkSomenteExpedido: TCheckBox;
    FDMemAnaliseConsolidadaRazao: TStringField;
    LblTotalPesoKg: TLabel;
    LblPesoKg: TLabel;
    LblVolumem3: TLabel;
    LblTotalVolumem3: TLabel;
    DsCargaNotaFiscal: TDataSource;
    FDMemCargaNotaFiscal: TFDMemTable;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    FDMemCargaNotaFiscalId: TIntegerField;
    FDMemCargaNotaFiscalNotaFiscal: TStringField;
    FDMemCargaNotaFiscalData: TDateField;
    FDMemCargaNotaFiscalHora: TTimeField;
    frxCargaNotaFiscal: TfrxDBDataset;
    FDMemCargaNotaFiscalChaveNfe: TStringField;
    FDMemCargaNotaFiscalDataHora: TStringField;
    FDMemPedidosParaCargaNFs: TFDMemTable;
    IntegerField6: TIntegerField;
    FDMemPedidosParaCargaNFsId: TIntegerField;
    FDMemPedidosParaCargaNFsNotaFiscal: TStringField;
    FDMemPedidosParaCargaNFsChaveNfe: TStringField;
    FDMemPedidosParaCargaNFsData: TDateField;
    FDMemPedidosParaCargaNFsHora: TTimeField;
    FdMemPesqGeralConferencia: TIntegerField;
    FdMemCargaPedidoVolumesLacreNr: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure EdtCargaIdChange(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure EdtCargaIdEnter(Sender: TObject);
    procedure EdtDtInicioExit(Sender: TObject);
    procedure EdtCargaIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtCargaIdExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RbTipoRelatorioClick(Sender: TObject);
    procedure FDMemAnaliseConsolidadaAfterOpen(DataSet: TDataSet);
    procedure EdtProcessoIdChange(Sender: TObject);
    procedure EdtRotaidChange(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure DsCargaPedidosDataChange(Sender: TObject; Field: TField);
    procedure FDMemCargaNotaFiscalCalcFields(DataSet: TDataSet);
    procedure BtnPesqDestinatarioClick(Sender: TObject);
    procedure EdtDestinatarioIdExit(Sender: TObject);
  private
    { Private declarations }
    PrintGeral     : Boolean;
    procedure ImprimirMapaCarga(pCargaId : Integer);
    Procedure AtualizarStatusCarga;
    Procedure MontarListaPedidosParaCarga(pJsonArrayRetorno : TJsonArray);
    Procedure MontarListaCargas(pJsonArray : TJsonArray);
    Procedure MontarListaAnaliseConsolidada(pJsonArray : TJsonArray);
    procedure HeaderLstReport;
    Procedure ExportaExceltCargaConsolidada;
    Procedure AtualizarNFSPedido;
    Procedure GetVolumeLacres(pCargaId : Integer);
  Protected
    Procedure Limpar; OVerRide;
    procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure PesquisarDados; OverRide;
    Procedure Imprimir; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelMapaCarga: TFrmRelMapaCarga;

implementation

{$R *.dfm}

Uses DataSet.Serialize, uFrmeXactWMS, FuncionalidadeClass, uFuncoes, Views.Pequisa.Rotas,
  RotaCtrl, Views.Pequisa.Processos, ProcessoCtrl, System.Win.ComObj,
  Views.Pequisa.EnderecamentoZonas, Views.Pequisa.Pessoas,
  EnderecamentoZonaCtrl, PedidoVolumeCtrl;

procedure TFrmRelMapaCarga.AtualizarNFSPedido;
Var vPedido : Integer;
    vNotas, vComplemento : String;
begin
  FdMemPedidosParaCargaNFs.First;
  while not FdMemPedidosParaCargaNFs.Eof do Begin
    if vPedido <> FdMemPedidosParaCargaNFs.FieldByName('PedidoId').AsInteger then Begin
       vPedido := FdMemPedidosParaCargaNFs.FieldByName('PedidoId').AsInteger;
       vNotas  := '';
       vComplemento := '';
    End;
    vNotas       := vNotas + vComplemento + FdMemPedidosParaCargaNFs.FieldByName('NotaFiscal').AsString;
    vComplemento := '; ';
    FdMemPedidosParaCargaNFs.Next;
    if (vPedido <> FdMemPedidosParaCargaNFs.FieldByName('PedidoId').AsInteger) or (FdMemPedidosParaCargaNFs.Eof) then Begin
       If FdMemPedidosParaCarga.Locate('PedidoId', vPedido, []) then Begin
          FdMemPedidosParaCarga.Edit;
          FdMemPedidosParaCarga.FieldByName('NotaFiscalERP').AsString := vNotas;
          FdMemPedidosParaCarga.Post;
       End;
    End;
  End;
end;

procedure TFrmRelMapaCarga.AtualizarStatusCarga;
begin
  FdMemPesqGeral.First;
  While Not FdMemPesqGeral.Eof do Begin
    if (FdMemPesqGeral.FieldByname('processoid').AsInteger = 16) And
       (FdMemPesqGeral.FieldByname('statusoper').AsInteger = 1) And
       (FdMemPesqGeral.FieldByname('conferencia').AsInteger = 0) then Begin
       FdMemPesqGeral.Edit;
       FdMemPesqGeral.FieldByname('Processo').AsString := 'Em Conferência';
    End
    Else if (FdMemPesqGeral.FieldByname('processoid').AsInteger = 16) And
       (FdMemPesqGeral.FieldByname('statusoper').AsInteger = 1) And
       (FdMemPesqGeral.FieldByname('conferencia').AsInteger = 1) then Begin
       FdMemPesqGeral.Edit;
       FdMemPesqGeral.FieldByname('Processo').AsString := 'Conferida';
    End
    Else If (FdMemPesqGeral.FieldByname('processoid').AsInteger = 16) And
            (FdMemPesqGeral.FieldByname('statusoper').AsInteger = 2) then Begin
       FdMemPesqGeral.Edit;
       FdMemPesqGeral.FieldByname('Processo').AsString := 'Carregando';
    End;
    FdMempesqGeral.Next;
  End;
  FdMemPesqGeral.First;
end;

procedure TFrmRelMapaCarga.BtnExportarStandClick(Sender: TObject);
begin
//  inherited; //Desativar porque FdMemPesqGeral usado em outra ação
  if RbTipoRelatorio.ItemIndex < 3 then Begin
     FDMemResumoCargas.FieldByName('VEICULOID').Visible := False;
     FDMemResumoCargas.FieldByName('PLACA').Visible := False;
     FDMemResumoCargas.FieldByName('MODELO').Visible := False;
     FDMemResumoCargas.FieldByName('MARCA').Visible := False;
     FDMemResumoCargas.FieldByName('COR').Visible := False;
     FDMemResumoCargas.FieldByName('UUID').Visible := False;
     FDMemResumoCargas.FieldByName('PEDIDOS').Visible := False;
     if (Not FDMemResumoCargas.Active) or (FDMemResumoCargas.IsEmpty) then
        raise Exception.Create('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) or (FDMemResumoCargas.IsEmpty) then Exit;
     Try
       DsResumoCargas.DataSet := nil;
       ExportarExcel(FDMemResumoCargas);
       DsResumoCargas.DataSet := FDMemResumoCargas;
     Except
   //    result := False;
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End
  Else if RbTipoRelatorio.ItemIndex = 3 then Begin
     if (Not FDMemAnaliseConsolidada.Active) or (FDMemAnaliseConsolidada.IsEmpty) then
        ShowErro('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) or (FDMemAnaliseConsolidada.IsEmpty) then Exit;
     Try
       //ExportarExcel(FDMemAnaliseConsolidada);
       ExportaExceltCargaConsolidada;
     Except
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End
  Else if RbTipoRelatorio.ItemIndex = 4 then Begin
     if (Not FdMemPedidosParaCarga.Active) or (FdMemPedidosParaCarga.IsEmpty) then
        ShowErro('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) or (FdMemPedidosParaCarga.IsEmpty) then Exit;
     Try
//       DsResumoCargas.DataSet := nil;
       ExportarExcel(FdMemPedidosParaCarga);
//       DsResumoCargas.DataSet := FDMemResumoCargas;
     Except
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End;
end;

procedure TFrmRelMapaCarga.BtnPesqDestinatarioClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtDestinatarioId.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatarioId.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioIdExit(EdtDestinatarioId);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmRelMapaCarga.BtnPesqProcessoClick(Sender: TObject);
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

procedure TFrmRelMapaCarga.BtnPesqRotaClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       if Sender = BtnPesqRota then begin
          EdtRotaId.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaIdExit(EdtRotaId);
       End
       Else if Sender = BtnPesqRotaFinal then Begin
          EdtRotaFinalId.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaIdExit(EdtRotaFinalId);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmRelMapaCarga.BtnPesqZonaClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelMapaCarga.DsCargaPedidosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  //FDMemCargaNotaFiscal.Close;
  //FDMemCargaNotaFiscal.Open;
end;

procedure TFrmRelMapaCarga.EdtCargaIdChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtCargaId then
     LblProcesso.Caption := '';
  if Sender = EdtRotaId then
     LblRota.Caption := '';
  Limpar;
end;

procedure TFrmRelMapaCarga.EdtCargaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRelMapaCarga.EdtCargaIdExit(Sender: TObject);
Var ObjCargaCtrl     : TCargasCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  LblProcesso.Caption := '';
  if EdtCargaId.Text = '' then exit;
  if StrToIntDef(EdtCargaId.Text, 0) <= 0 then Begin
     EdtCargaId.Text := '';
     raise Exception.Create('Id da Carga Inválido para pesquisa!');
  End;
  ObjCargaCtrl := TCargasCtrl.Create;
  JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', '', 0, '', '', 0);

  If JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     ShowErro(vErro);
     EdtCargaId.Clear;
     EdtCargaId.SetFocus;
  End
  Else Begin
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('processo');
     if (JsonArrayRetorno.Items[0].GetValue<integer>('processoid') = 16) And
        (JsonArrayRetorno.Items[0].GetValue<integer>('statusoper') = 1) And
        (JsonArrayRetorno.Items[0].GetValue<integer>('conferencia') = 0)  then
        LblProcesso.Caption := 'Em Conferência'
     Else if (JsonArrayRetorno.Items[0].GetValue<integer>('processoid') = 16) And
        (JsonArrayRetorno.Items[0].GetValue<integer>('statusoper') = 1) And
        (JsonArrayRetorno.Items[0].GetValue<integer>('conferencia') = 1)  then
        LblProcesso.Caption := 'Conferida'
     Else If (JsonArrayRetorno.Items[0].GetValue<integer>('processoid') = 16) and
             (JsonArrayRetorno.Items[0].GetValue<integer>('statusoper') = 2) then
        LblProcesso.Caption := 'Carregando'
     Else
        LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('processo');
  End;
  JsonArrayRetorno := Nil;
  ObjCargaCtrl.Free;
end;

procedure TFrmRelMapaCarga.EdtCargaIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  SoNumeros(Char(Key));
end;

procedure TFrmRelMapaCarga.EdtDestinatarioIdExit(Sender: TObject);
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
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia');
  End;
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaCarga.EdtDtInicioExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaCarga.EdtProcessoIdChange(Sender: TObject);
begin
  inherited;
  LblProcessoPesq.Caption := '...';
  Limpar;
end;

procedure TFrmRelMapaCarga.EdtProcessoIdExit(Sender: TObject);
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
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(EdtProcessoId.text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo não('+EdtProcessoId.Text+') encontrado!');
     EdtProcessoId.Clear;
  end
  Else
     LblProcessoPesq.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  JsonArrayRetorno := Nil;
  ObjProcessoCtrl  := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaCarga.EdtRotaidChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelMapaCarga.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl  : TRotactrl;
begin
  Try
    if Sender = EdtRotaId then
       LblRota.Caption := ''
    Else LblRotaFinal.Caption := '';
    if TEdit(Sender).Text = '' then Exit;
    if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
       TEdit(Sender).Text := '';
       raise Exception.Create('Id da Rota Inválido para pesquisa!');
    End;
    ObjRotaCtrl := TRotaCtrl.Create;
    ObjRotaCtrl := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).Text, 0), '')[0];
    if Sender = EdtRotaId then
       LblRota.Caption := ObjRotaCtrl.ObjRota.Descricao
    Else LblRotaFinal.Caption := ObjRotaCtrl.ObjRota.Descricao;
    ObjRotaCtrl.Free;
  Except On E: Exception do Begin
    if Assigned(ObjRotaCtrl) then
       ObjRotaCtrl.Free;
    TEdit(Sender).Text := '';
    ShowErro('Erro: Não foi possível pegar os dados da rota.'+E.Message);
    End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaCarga.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '...';
  Limpar;
end;

procedure TFrmRelMapaCarga.EdtZonaIdExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblZona.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblZona.Caption := '';
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
     LblZona.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonArrayZona := Nil;
  ObjEnderecamentoZonaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaCarga.ExportaExceltCargaConsolidada;
var
  Excel    : Variant;
  Linha, i : Integer;
begin
  if not FDMemAnaliseConsolidada.IsEmpty then
  begin
    FDMemAnaliseConsolidada.First;
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible := True;
    Excel.Workbooks.Add(1);
    Linha := 1;
    Excel.cells[1, 1] := 'Cód.Destino';
    Excel.cells[1, 2] := 'Nome';
    Excel.cells[1, 3] := 'Id Rota';
    Excel.cells[1, 4] := 'Rota';
    Excel.cells[1, 5] := 'Pedido(s)';
    Excel.cells[1, 6] := 'Volume(s)';
    Excel.cells[1, 7] := 'Expedido(s)';
    Excel.cells[1, 8] := 'Cancelado(s)';
    Excel.cells[1, 9] := 'Pendente(s)';
    Excel.cells[1,10] := 'Vol.cm3';
    Excel.cells[1,11] := 'Vol.m3';
    Excel.cells[1,12] := 'Peso(Kg)';
    Linha := 2;
    While not FDMemAnaliseConsolidada.Eof do
    Begin
      Excel.cells[Linha, 1] := FDMemAnaliseConsolidadaCodPessoaERP.Value;
      Excel.cells[Linha, 2] := FDMemAnaliseConsolidadaFantasia.Value;
      Excel.cells[Linha, 3] := FDMemAnaliseConsolidadaRotaId.Value;
      Excel.cells[Linha, 4] := FDMemAnaliseConsolidadaRota.Value;
      Excel.cells[Linha, 5] := FDMemAnaliseConsolidadaTotPedido.Value;
      Excel.cells[Linha, 6] := FDMemAnaliseConsolidadaTotVolume.Value;
      Excel.cells[Linha, 7] := FDMemAnaliseConsolidadaTotVolumeExpedido.Value;
      Excel.cells[Linha, 8] := FDMemAnaliseConsolidadaTotVolumeCancelado.Value;
      Excel.cells[Linha, 8] := FDMemAnaliseConsolidadaTotVolumePendente.Value;
      Excel.cells[Linha,10] := FDMemAnaliseConsolidadaVolCm3.Value;
      Excel.cells[Linha,11] := FDMemAnaliseConsolidadaVolM3.Value;
      Excel.cells[Linha,12] := FDMemAnaliseConsolidadaPesoKg.Value;
      FDMemAnaliseConsolidada.Next;
      Inc(Linha);
    end;
    excel.columns.AutoFit;
    Excel := UnAssigned;
  end;
end;

procedure TFrmRelMapaCarga.FDMemAnaliseConsolidadaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(FDMemAnaliseConsolidada.FieldByName('VolCm3')).DisplayFormat := '####0.000';
  TNumericField(FDMemAnaliseConsolidada.FieldByName('Volm3')).DisplayFormat := '####0.000000';
  TNumericField(FDMemAnaliseConsolidada.FieldByName('PesoKg')).DisplayFormat := '####0.000';
end;

procedure TFrmRelMapaCarga.FDMemCargaNotaFiscalCalcFields(DataSet: TDataSet);
begin
  inherited;
  FDMemCargaNotaFiscal.FieldByName('DataHora').AsString := FDMemCargaNotaFiscal.FieldByName('Data').AsString+' '+
                                                           Copy(FDMemCargaNotaFiscal.FieldByName('Hora').AsString, 1, 5)+'h';
end;

procedure TFrmRelMapaCarga.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRelMapaCarga := Nil;
end;

procedure TFrmRelMapaCarga.FormCreate(Sender: TObject);
begin
  inherited;
  HeaderLstReport;
end;

procedure TFrmRelMapaCarga.GetVolumeLacres(pCargaId : Integer);
Var ObjVolumeLacres : TPedidoVolumeCtrl;
    JsonArrayRetorno : TjsonArray;
    vErro : String;
    xLacres : Integer;
    vComplemento : String;
begin
  ObjVolumeLacres := TPedidoVolumeCtrl.Create;
  JsonArrayRetorno := ObjVolumeLacres.VolumeLacresCarga(pCargaId);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     for xLacres := 0 to Pred(JsonArrayRetorno.Count) do Begin
       FDMemCargaPedidoVolumes.First;
       If FDMemCargaPedidoVolumes.Locate('PedidoVolumeId', JsonArrayRetorno.Items[xLacres].GetValue<Integer>('pedidovolumeid'), [] ) then Begin
          if FDMemCargaPedidoVolumes.FieldByName('Lacres').AsString <> '' then
             vComplemento := ', '
          Else
             vComplemento := '';
          FDMemCargaPedidoVolumes.Edit;
          FDMemCargaPedidoVolumes.FieldByName('Lacres').AsString := FDMemCargaPedidoVolumes.FieldByName('Lacres').AsString+vComplemento+
                                                                    JsonArrayRetorno.Items[xLacres].GetValue<String>('lacrenr');
       End;
     End;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjVolumeLacres);
end;

procedure TFrmRelMapaCarga.HeaderLstReport;
begin
  LstReport.RowCount := 1;
  if RbTipoRelatorio.ItemIndex < 3 then Begin
     LstReport.ColCount := 12;
     LstReport.Cells[0, 0]   := 'Carga Id';
     LstReport.Cells[1, 0]   := 'Data';
     LstReport.Cells[2, 0]   := 'Rota';
     LstReport.Cells[3, 0]   := 'Transportadora';
     LstReport.Cells[4, 0]   := 'Motorista';
     LstReport.Cells[5, 0]   := 'Veículo';
     LstReport.Cells[6, 0]   := 'Pedidos';
     LstReport.Cells[7, 0]   := 'Processo';
     LstReport.Cells[8, 0]   := 'Pedidos';
     LstReport.Cells[9, 0]   := 'Volumes';
     LstReport.Cells[10, 0]  := 'Unidades';
     LstReport.Cells[11, 0]  := 'Print';
     LstReport.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[1]  :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[2]  := 150+Trunc(150*ResponsivoVideo);
     LstReport.ColWidths[3]  := 150+Trunc(150*ResponsivoVideo);
     LstReport.ColWidths[4]  := 120+Trunc(120*ResponsivoVideo);
     LstReport.ColWidths[5]  :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[6]  :=  70+Trunc(70*ResponsivoVideo);
     LstReport.ColWidths[7]  := 160+Trunc(160*ResponsivoVideo);
     LstReport.ColWidths[8]  :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[9]  :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[10] :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[11] :=  40+Trunc(40*ResponsivoVideo);
     LstReport.Alignments[0, 0]  := taCenter;
     LstReport.FontStyles[0, 0]  := [FsBold];
     LstReport.Alignments[1, 0]  := taCenter;
     LstReport.Alignments[2, 0]  := taLeftJustify;
     LstReport.Alignments[3, 0]  := taLeftJustify;
     LstReport.Alignments[4, 0]  := taLeftJustify;
     LstReport.Alignments[5, 0]  := taLeftJustify;
     LstReport.Alignments[6, 0]  := taRightJustify;
     LstReport.Alignments[7, 0]  := taLeftJustify;
     LstReport.Alignments[8, 0]  := taRightJustify;
     LstReport.Alignments[9, 0]  := taRightJustify;
     LstReport.Alignments[10, 0] := taRightJustify;
     LstReport.Alignments[11, 0] := taCenter;
  End
  Else if RbTipoRelatorio.ItemIndex = 3 then Begin
     LstReport.ColCount     := 11;
     LstReport.Cells[0, 0]  := 'Cód.Dest.';
     LstReport.Cells[1, 0]  := 'Destinatário';
     LstReport.Cells[2, 0]  := 'Rota';
     LstReport.Cells[3, 0]  := 'Pedido(s)';
     LstReport.Cells[4, 0]  := 'Volume(s)';
     LstReport.Cells[5, 0]  := 'Expedido';
     LstReport.Cells[6, 0]  := 'Cancelado';
     LstReport.Cells[7, 0]  := 'Pendente';
     LstReport.Cells[8, 0]  := 'Vol.Cm3';
     LstReport.Cells[9, 0]  := 'Vol.m3';
     LstReport.Cells[10, 0]  := 'Peso(Kg)';
     LstReport.ColWidths[0]  :=  90+Trunc(90*ResponsivoVideo);
     LstReport.ColWidths[1]  := 300+Trunc(300*ResponsivoVideo);
     LstReport.ColWidths[2]  := 180+Trunc(180*ResponsivoVideo);
     LstReport.ColWidths[3]  :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[4]  :=  65+Trunc(65*ResponsivoVideo);
     LstReport.ColWidths[5]  :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[6]  :=  70+Trunc(70*ResponsivoVideo);
     LstReport.ColWidths[7]  :=  60+Trunc(60*ResponsivoVideo);
     LstReport.ColWidths[8]  :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[9]  :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[10] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.Alignments[0, 0] := taRightJustify;
     LstReport.FontStyles[0, 0] := [FsBold];
     LstReport.Alignments[1, 0] := taLeftJustify;
     LstReport.Alignments[2, 0] := taLeftJustify;
     LstReport.Alignments[3, 0] := taRightJustify;
     LstReport.Alignments[4, 0] := taRightJustify;
     LstReport.Alignments[5, 0] := taRightJustify;
     LstReport.Alignments[6, 0] := taRightJustify;
     LstReport.Alignments[7, 0] := taRightJustify;
     LstReport.Alignments[8, 0] := taRightJustify;
     LstReport.Alignments[9, 0] := taRightJustify;
     LstReport.Alignments[10, 0] := taRightJustify;
  End
  Else if RbTipoRelatorio.ItemIndex = 4 then Begin
     LstReport.ColCount     := 9;
     LstReport.Cells[0, 0]  := 'Data';
     LstReport.Cells[1, 0]  := 'Cód.Dest.';
     LstReport.Cells[2, 0]  := 'Destinatário';
     LstReport.Cells[3, 0]  := 'Ressuprimento';
     LstReport.Cells[4, 0]  := 'Id WMS';
     LstReport.Cells[5, 0]  := 'Volumes';
     LstReport.Cells[6, 0]  := 'Zona/Setor';
     LstReport.Cells[7, 0]  := 'Processo';
     LstReport.Cells[8, 0]  := 'Nota Fiscal';
     LstReport.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
     LstReport.ColWidths[1] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[2] := 320+Trunc(320*ResponsivoVideo);
     LstReport.ColWidths[3] :=  90+Trunc(90*ResponsivoVideo);
     LstReport.ColWidths[4] :=  90+Trunc(90*ResponsivoVideo);
     LstReport.ColWidths[5] :=  80+Trunc(80*ResponsivoVideo);
     LstReport.ColWidths[6] := 150+Trunc(150*ResponsivoVideo);
     LstReport.ColWidths[7] := 120+Trunc(120*ResponsivoVideo);
     LstReport.ColWidths[8] := 390+Trunc(390*ResponsivoVideo);
     LstReport.Alignments[0, 0] := taCenter;
     LstReport.FontStyles[0, 0] := [FsBold];
     LstReport.Alignments[1, 0] := taRightJustify;
     LstReport.Alignments[2, 0] := taLeftJustify;
     LstReport.Alignments[3, 0] := taRightJustify;
     LstReport.Alignments[4, 0] := taRightJustify;
     LstReport.Alignments[5, 0] := taRightJustify;
     LstReport.Alignments[6, 0] := taLeftJustify;
     LstReport.Alignments[7, 0] := taLeftJustify;
     LstReport.Alignments[8, 0] := taLeftJustify;
  End;
end;

Procedure TFrmRelMapaCarga.Imprimir;
Var xMapa : Integer;
Begin
  if RbTipoRelatorio.ItemIndex <= 2 then begin
     If ((RbTipoRelatorio.ItemIndex<2) and (Confirmacao('Mapa de Carga', 'Todos os mapas(selecionados) serão impressos!', True))) or
        ((RbTipoRelatorio.ItemIndex=2) and (Confirmacao('Romaneio de Carga', 'Todos os romaneios(selecionados) serão impressos!', True))) then Begin
        PrintGeral := True;
        for xMapa := 1 to Pred(LstReport.RowCount) do
          ImprimirMapaCarga(LstReport.Cells[0, xMapa].Tointeger);
     End;
  End
  Else if RbTipoRelatorio.ItemIndex = 3 then Begin
    With frxPedidoParaCarga do Begin
      Variables['vModulo']  := QuotedStr(pChar(Application.Title));
      Variables['vVersao']  := QuotedStr(Versao);
      Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
    End;
    if (Not FDMemAnaliseConsolidada.Active) then
       FDMemAnaliseConsolidada.Open;
    frxPDFExport1.Title    := 'Análise Consolidada para Cargas';
    frxPDFExport1.FileName := 'AnaliseConsolidadaCargas.Pdf';
    frxPDFExport1.ShowDialog      := False;
    frxPDFExport1.ShowProgress    := False;
    frxPDFExport1.OverwritePrompt := False;
    frxAnaliseConsolidada.PrepareReport();
    frxAnaliseConsolidada.PrintOptions.ShowDialog := False;
    frxAnaliseConsolidada.ShowReport;
    BtnImprimirStand.Enabled := True;
    BtnImprimirStand.Grayed  := False;
    BtnExportarStand.Enabled := True;
    BtnExportarStand.Grayed  := False;
  End
  Else if RbTipoRelatorio.ItemIndex = 4 then Begin
    With frxPedidoParaCarga do Begin
      Variables['vModulo']  := QuotedStr(pChar(Application.Title));
      Variables['vVersao']  := QuotedStr(Versao);
      Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
    End;
    frxPDFExport1.Title    := 'Pedidos para Carga(s)';
    frxPDFExport1.FileName := 'PedidosParaCarga.Pdf';
    frxPDFExport1.ShowDialog := False;
    frxPDFExport1.ShowProgress := False;
    frxPDFExport1.OverwritePrompt := False;
    frxPedidoParaCarga.PrepareReport();
    frxPedidoParaCarga.PrintOptions.ShowDialog := False;
    frxPedidoParaCarga.ShowReport;
    BtnImprimirStand.Enabled := True;
    BtnImprimirStand.Grayed  := False;
    BtnExportarStand.Enabled := True;
    BtnExportarStand.Grayed  := False;
  End;
End;

procedure TFrmRelMapaCarga.ImprimirMapaCarga(pCargaId : Integer);
Var JsonArrayCarga         : TJsonArray;
    JsonArrayCargaPessoas  : TJsonArray;
    JsonArrayCargaPedidos  : TJsonArray;
    JsonArrayPedidoVolumes : TJsonArray;
    JsonArrayCargaNF       : TJsonArray;
    vErro : String;
    ObjCargaCtrl : TCargasCtrl;
begin
  Try
    TDialogMessage.ShowWaitMessage('Aguarde!!! Gerando relatório...',
    procedure
    begin
      ObjCargaCtrl   := TCargasCtrl.Create;
      JsonArrayCarga := ObjCargaCtrl.GetCargaHeader(pCargaId, 0);
      If JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then Begin
         ShowErro('Erro: Mapa: '+pCargaId.ToString+#13+vErro);
      End;
      If FdMemPesqGeral.Active then
         FdMemPesqGeral.EmptyDataSet;
      FdMemPesqGeral.Close;
      FdMemPesqGeral.LoadFromJSON(JsonArrayCarga, False);
      AtualizarStatusCarga;
      Application.ProcessMessages;
      JsonArrayCargaPessoas := ObjCargaCtrl.GetCargaPessoasPedido(pCargaId, 0);//    GetCargaPessoas(pCargaId, 0);
      If JsonArrayCargaPessoas.Items[0].TryGetValue('Erro', vErro) then Begin
         ShowErro(vErro);
      End;
      If FDMemCargaPessoas.Active then
         FDMemCargaPessoas.EmptyDataSet;
      FDMemCargaPessoas.Close;
      FDMemCargaPessoas.LoadFromJSON(JsonArrayCargaPessoas, False);
      if ((FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 16) and
          (FdMemPesqGeral.FieldByName('StatusOper').AsInteger = 1) and
          (FdMemPesqGeral.FieldByName('Conferencia').AsInteger = 1)) then Begin
         if RbTipoRelatorio.itemIndex < 2 then
            JsonArrayCargaPedidos := ObjCargaCtrl.GetCargaPedidos(pCargaId, 0, 'CO', 0)
         Else
            JsonArrayCargaPedidos := ObjCargaCtrl.GetCargaPedidosRomaneio(pCargaId, 0, 'CO', 0);
      End
      Else Begin
         if RbTipoRelatorio.itemIndex < 2 then
            JsonArrayCargaPedidos := ObjCargaCtrl.GetCargaPedidos(pCargaId, 0, 'CA', 0)
         Else JsonArrayCargaPedidos := ObjCargaCtrl.GetCargaPedidosRomaneio(pCargaId, 0, 'CA', 0);
      End;
      If JsonArrayCargaPedidos.Items[0].TryGetValue('Erro', vErro) then Begin
         ShowErro(vErro);
      End;
      If FDMemCargaPedidos.Active then
         FDMemCargaPedidos.EmptyDataSet;
      FDMemCargaPedidos.Close;
      FDMemCargaPedidos.LoadFromJSON(JsonArrayCargaPedidos, False);
      if RbTipoRelatorio.itemIndex = 2 then Begin  //Buscar NF dos Pedidos pertecente a Carga
         JsonArrayCargaNF := ObjCargaCtrl.GetCargaNF(pCargaId);
         If JsonArrayCargaNF.Items[0].TryGetValue('Erro', vErro) then Begin
            raise Exception.Create(vErro);
         End;
         If FDMemCargaNotaFiscal.Active then
            FDMemCargaNotaFiscal.EmptyDataSet;
         FDMemCargaNotaFiscal.Close;
         FDMemCargaNotaFiscal.LoadFromJSON(JsonArrayCargaNF, False);
      End;
      if ((FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 16) and
          (FdMemPesqGeral.FieldByName('StatusOper').AsInteger = 1) and
          (FdMemPesqGeral.FieldByName('Conferencia').AsInteger = 0)) then//or
//         ((FdMemPesqGeral.FieldByName('ProcessoId').AsInteger = 18) and
//          (FdMemPesqGeral.FieldByName('StatusOper').AsInteger = 0)) then
         JsonArrayPedidoVolumes := ObjCargaCtrl.GetCargaPedidoVolumes(pCargaId, 'CO')
      Else JsonArrayPedidoVolumes := ObjCargaCtrl.GetCargaPedidoVolumes(pCargaId, 'CA');
      If FDMemCargaPedidoVolumes.Active then
         FDMemCargaPedidoVolumes.EmptyDataSet;
      FDMemCargaPedidoVolumes.Close;
      if Not JsonArrayPedidoVolumes.Items[0].TryGetValue<String>('Erro', vErro) then Begin
         FDMemCargaPedidoVolumes.LoadFromJSON(JsonArrayPedidoVolumes, False);
         //GetVolumeLacres(pCargaId);
      End;
    End);
    //  inherited;

      With FrxMapaCarga do Begin
        Variables['vModulo']  := QuotedStr(pChar(Application.Title));
        Variables['vVersao']  := QuotedStr(Versao);
        Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
        if RbTipoRelatorio.itemIndex = 1 then
           FrxMapaCarga.Variables['vDrillDown']  := QuotedStr('1')
        Else if RbTipoRelatorio.itemIndex = 0 then
           FrxMapaCarga.Variables['vDrillDown']  := QuotedStr('0')
        Else if RbTipoRelatorio.itemIndex = 2 then
           FrxMapaCarga.Variables['vDrillDown']  := QuotedStr('0')
      End;
      If RbTipoRelatorio.itemIndex < 2 then Begin
         frxPDFExport1.Title    := 'Mapa de Carga: '+pCargaId.ToString;
         frxPDFExport1.FileName := 'MapaCarga_'+pCargaId.ToString+'.Pdf';
      End
      Else Begin
         frxPDFExport1.Title    := 'Romaneio '+pCargaId.ToString;
         frxPDFExport1.FileName := 'Romaneio_'+pCargaId.ToString+'.Pdf';
      End;
      frxPDFExport1.ShowDialog := False;
      frxPDFExport1.ShowProgress := False;
      frxPDFExport1.OverwritePrompt := False;
      //FrxMapaCarga.PrintOptions.ShowDialog := False;
      If RbTipoRelatorio.itemIndex < 2 then Begin
         FrxMapaCarga.PrepareReport();
         if Not PrintGeral then
            FrxMapaCarga.ShowReport
         Else
            FrxMapaCarga.Print;
      End
      Else Begin
         frxRomaneio.PrepareReport();
         frxRomaneio.ShowReport;
      End;
  Except On E: Exception do
    ShowErro('Erro: '+ E.MEssage);
  End;
  JsonArrayCarga         := Nil;
  JsonArrayCargaPessoas  := Nil;
  JsonArrayCargaPedidos  := Nil;
  JsonArrayPedidoVolumes := Nil;
  JsonArrayCargaNF       := Nil;
  FreeAndNil(ObjCargaCtrl);
  BtnImprimirStand.Enabled := True;
  BtnImprimirStand.Grayed  := False;
  BtnExportarStand.Enabled := True;
  BtnExportarStand.Grayed  := False;
end;

procedure TFrmRelMapaCarga.Limpar;
begin
  inherited;
  if (FdMemPesqGeral.Active) then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  if (FDMemCargaPessoas.Active) then
     FDMemCargaPessoas.EmptyDataSet;
  FDMemCargaPessoas.Close;
  if (FDMemCargaPedidos.Active) then
     FDMemCargaPedidos.EmptyDataSet;
  FDMemCargaPedidos.Close;
  if (FDMemCargaPedidoVolumes.Active) then
     FDMemCargaPedidoVolumes.EmptyDataSet;
  FDMemCargaPedidoVolumes.Close;
  LblTotalPesoKg.Caption   := '0';
  LblTotalVolumem3.Caption := '0';
  PrintGeral := False;
end;

procedure TFrmRelMapaCarga.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aCol <> 11) or (aRow=0) or (RbTipoRelatorio.ItemIndex > 2) then Exit;
    ImprimirMapaCarga(LstReport.Cells[0, aRow].ToInteger);
end;

procedure TFrmRelMapaCarga.MontarListaAnaliseConsolidada(
  pJsonArray: TJsonArray);
Var xPed : Integer;
    vTotalPesoKg, vTotalVolumem3 : Real;
begin
  vTotalPesoKg   := 0;
  vTotalVolumem3 := 0;
  BtnImprimirStand.Enabled := pJsonArray.Count >= 1;
  BtnImprimirStand.Grayed  := Not BtnImprimirStand.Enabled;
  BtnExportarStand.Enabled := pJsonArray.Count >= 1;
  BtnExportarStand.Grayed  := Not BtnImprimirStand.Enabled;
  LstReport.RowCount  := pJsonArray.Count+1;
  LstReport.FixedRows := 1;
  LblTotRegistro.Caption := FormatFloat('######0', pJsonArray.Count);
  For xPed := 0 to Pred(pJsonArray.Count) do Begin
    LstReport.Cells[0, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('codpessoaerp');
    LstReport.Cells[1, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('fantasia');
    LstReport.Cells[2, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('rota');
    LstReport.Cells[3, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('totpedido');
    LstReport.Cells[4, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('totvolume');
    LstReport.Cells[5, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('totvolumeexpedido');
    LstReport.Cells[6, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('totvolumecancelado');
    LstReport.Cells[7, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('totvolumependente');
    LstReport.Cells[8, xPed+1]  := pJsonArray.items[xPed].GetValue<String>('volcm3');
    LstReport.Cells[9, xPed+1]  := FormatFloat('####0.000000', pJsonArray.items[xPed].GetValue<Real>('volm3'));  //StringReplace(pJsonArray.items[xPed].GetValue<String>('volm3'), '.', ',', [rfReplaceAll]);
    LstReport.Cells[10, xPed+1] := FormatFloat('####0.000', pJsonArray.items[xPed].GetValue<Real>('pesokg')); //StringReplace(pJsonArray.items[xPed].GetValue<String>('pesokg'), '.', ',', [rfReplaceAll]);
    vTotalPesoKg   := vTotalPesoKg + pJsonArray.items[xPed].GetValue<Real>('pesokg');
    vTotalVolumem3 := vTotalVolumem3 + pJsonArray.items[xPed].GetValue<Real>('volm3');
    LstReport.Alignments[0, xPed+1]  := taRightJustify;
    LstReport.FontStyles[0, xPed+1]  := [FsBold];
    LstReport.Alignments[1, xPed+1]  := taLeftJustify;
    LstReport.Alignments[2, xPed+1]  := taLeftJustify;
    LstReport.Alignments[3, xPed+1]  := taRightJustify;
    LstReport.Alignments[4, xPed+1]  := taRightJustify;
    LstReport.Alignments[5, xPed+1]  := taRightJustify;
    LstReport.Alignments[6, xPed+1]  := taRightJustify;
    LstReport.Alignments[7, xPed+1]  := taRightJustify;
    LstReport.Alignments[8, xPed+1]  := taRightJustify;
    LstReport.Alignments[9, xPed+1]  := taRightJustify;
    LstReport.Alignments[10, xPed+1] := taRightJustify;
    LblTotalPesoKg.Caption   := FormatFloat('####0.000', vTotalPesoKg);
    LblTotalVolumem3.caption := FormatFloat('####0.000000', vTotalVolumem3);
  End;
end;

procedure TFrmRelMapaCarga.MontarListaCargas(pJsonArray: TJsonArray);
Var xCargas : Integer;
    JsonArrayPedidos : TJsonArray;
begin
  inherited;
  BtnImprimirStand.Enabled := pJsonArray.Count >= 1;
  BtnImprimirStand.Grayed  := Not BtnImprimirStand.Enabled;
  BtnExportarStand.Enabled := pJsonArray.Count >= 1;
  BtnExportarStand.Grayed  := Not BtnImprimirStand.Enabled;
  LstReport.RowCount  := pJsonArray.Count+1;
  LstReport.FixedRows := 1;
  LblTotRegistro.Caption := FormatFloat('######0', pJsonArray.Count);
  For xCargas := 1 to pJsonArray.Count do
    LstReport.AddDataImage(11, xCargas, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
  For xCargas := 0 to Pred(pJsonArray.Count) do Begin
    LstReport.Cells[0, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('cargaid');
    LstReport.Cells[1, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('dtinclusao');
    LstReport.Cells[2, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('rota');
    LstReport.Cells[3, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('transportadora');
    LstReport.Cells[4, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('motorista');
    LstReport.Cells[5, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('placa');
    JsonArrayPedidos := pJsonArray.items[xCargas].GetValue<TjsonArray>('pedidos');
    LstReport.Cells[6, xCargas+1] := pJsonArray.items[xCargas].GetValue<TjsonArray>('pedidos').Count.ToString();
    LstReport.Cells[7, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('processo');
    if (pJsonArray.Items[xCargas].GetValue<integer>('processoid') = 16) And
       (pJsonArray.Items[xCargas].GetValue<integer>('statusoper') = 1) and
       (pJsonArray.Items[xCargas].GetValue<integer>('conferencia') = 0) then
       LstReport.Cells[7, xCargas+1] := 'Em Conferência'
    Else if (pJsonArray.Items[xCargas].GetValue<integer>('processoid') = 16) And
       (pJsonArray.Items[xCargas].GetValue<integer>('statusoper') = 1) and
       (pJsonArray.Items[xCargas].GetValue<integer>('conferencia') = 1) then
       LstReport.Cells[7, xCargas+1] := 'Conferida'
    Else if (pJsonArray.Items[xCargas].GetValue<integer>('processoid') = 16) And
            (pJsonArray.Items[xCargas].GetValue<integer>('statusoper') = 2) then
       LstReport.Cells[7, xCargas+1] := 'Carregando'
    Else
       LstReport.Cells[7, xCargas+1] := pJsonArray.Items[xCargas].GetValue<String>('processo');
//    LstReport.Cells[7, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('processo');
    LstReport.Cells[8, xCargas+1]  := pJsonArray.items[xCargas].GetValue<String>('tpedido');
    LstReport.Cells[9, xCargas+1]  := pJsonArray.items[xCargas].GetValue<String>('tvolume');
    LstReport.Cells[10, xCargas+1] := pJsonArray.items[xCargas].GetValue<String>('tunidade');
    LstReport.Cells[11, xCargas+1] := '5';
    LstReport.Alignments[ 0, xCargas+1] := taRightJustify;
    LstReport.FontStyles[ 0, xCargas+1] := [FsBold];
    LstReport.Alignments[ 6, xCargas+1] := taRightJustify;
    LstReport.Alignments[ 8, xCargas+1] := taRightJustify;
    LstReport.Alignments[ 9, xCargas+1] := taRightJustify;
    LstReport.Alignments[10, xCargas+1] := taRightJustify;
    LstReport.Alignments[11, xCargas+1] := taCenter;
  End;
end;

procedure TFrmRelMapaCarga.MontarListaPedidosParaCarga(pJsonArrayRetorno : TJsonArray);
Var xPed : Integer;
begin
  inherited;
  BtnImprimirStand.Enabled := FDMemPedidosParaCarga.RecordCount >= 1;
  BtnImprimirStand.Grayed  := Not BtnImprimirStand.Enabled;
  BtnExportarStand.Enabled := FDMemPedidosParaCarga.RecordCount >= 1;
  BtnExportarStand.Grayed  := Not BtnImprimirStand.Enabled;
  LstReport.RowCount  := FDMemPedidosParaCarga.RecordCount+1;
  LstReport.FixedRows := 1;
  LblTotRegistro.Caption := FormatFloat('######0', FDMemPedidosParaCarga.RecordCount);
  FDMemPedidosParaCarga.First;
  xPed := 0;
  While Not FDMemPedidosParaCarga.Eof do Begin
    LstReport.Cells[0, xPed+1] := FDMemPedidosParaCarga.FieldByName('documentodata').AsString;
    LstReport.Cells[1, xPed+1] := FDMemPedidosParaCarga.FieldByName('codpessoaerp').AsString;
    LstReport.Cells[2, xPed+1] := FDMemPedidosParaCarga.FieldByName('fantasia').AsString;
    LstReport.Cells[3, xPed+1] := FDMemPedidosParaCarga.FieldByName('documentooriginal').AsString;
    LstReport.Cells[4, xPed+1] := FDMemPedidosParaCarga.FieldByName('pedidoid').AsString;
    LstReport.Cells[5, xPed+1] := FDMemPedidosParaCarga.FieldByName('qtdvolume').AsString;
    LstReport.Cells[6, xPed+1] := FDMemPedidosParaCarga.FieldByName('zona').AsString;
    LstReport.Cells[7, xPed+1] := FDMemPedidosParaCarga.FieldByName('processo').AsString;
    LstReport.Cells[8, xPed+1] := FDMemPedidosParaCarga.FieldByName('notafiscalerp').AsString;
    LstReport.Alignments[0, xPed+1] := taCenter;
    LstReport.FontStyles[0, xPed+1] := [FsBold];
    LstReport.Alignments[1, xPed+1] := taRightJustify;
    LstReport.Alignments[2, xPed+1] := taLeftJustify;
    LstReport.Alignments[3, xPed+1] := taRightJustify;
    LstReport.Alignments[4, xPed+1] := taRightJustify;
    LstReport.Alignments[5, xPed+1] := taRightJustify;
    LstReport.Alignments[6, xPed+1] := taLeftJustify;
    LstReport.Alignments[7, xPed+1] := taLeftJustify;
    LstReport.Alignments[8, xPed+1] := taLeftJustify;
    Inc(xPed);
    FDMemPedidosParaCarga.Next;
  End;
end;

procedure TFrmRelMapaCarga.MontarLstAdvReport(pJsonArray: TJsonArray);
begin
//  inherited;

end;

procedure TFrmRelMapaCarga.PesquisarDados;
Var JsonArrayRetorno, JsonArrayPedidos, JsonArrayPedidoVolumes : TJsonArray;
    vErro : String;
    vDataInicial, vDataFinal : TDateTime;
    ObjCargaCtrl : TCargasCtrl;
    vOrdem : Integer;
begin
  if (EdtCargaId.Text='') and (EdtProcessoId.Text='') and (EdtRotaId.Text='') and (EdtRotaFinalId.Text='') and
     (EdtZonaId.Text='') and (EdtDestinatarioId.Text='') and
     (EdtDtInicio.Text='  /  /    ') And (EdtDtTermino.Text='  /  /    ') then Begin
     ShowErro('Informe o período do relatório');
     exit;
  End;
//  if (EdtCargaId.Text = '') and (EdtRotaId.Text='') and (EdtProcessoId.Text='') and then
//     raise Exception.Create('Informe pelo menos uma informação dos Filtros.');
  if RbTipoRelatorio.ItemIndex < 0 then
     raise Exception.Create('Selecione o tipo de relatório.');
  inherited;
  PrintGeral := False;
  TDialogMessage.ShowWaitMessage('Aguarde!!! Buscando dados para relatório...',
  procedure
  begin
    if EdtDtInicio.Text <> '  /  /    ' then
       vDataInicial := StrToDate(EdtDtInicio.text)
    Else vDataInicial := 0;
    if EdtDtTermino.Text <> '  /  /    ' then
       vDataFinal := StrToDate(EdtDtTermino.text)
    Else vDataFinal := 0;
    ObjCargaCtrl := TCargasCtrl.Create;
    if RbTiporelatorio.ItemIndex < 3 then
       JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), vDataInicial, vDataFinal,
                           EdtRotaId.Text, EdtRotaFinalId.Text, '', '', 0, '', EdtProcessoId.Text, 1)
    Else if RbTiporelatorio.ItemIndex = 3 then Begin
       vOrdem := ifThenInt(RbOrdem.ItemIndex>=0, RbOrdem.ItemIndex, 0);
       JsonArrayRetorno := ObjCargaCtrl.GetRelAnaliseConsolidada(0, vDataInicial, vDataFinal, '',
                           StrToIntDef(EdtRotaId.Text, 0), StrToIntDef(EdtRotaFinalId.Text, 0),
                           StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtDestinatarioId.Text, 0),
                           Ord(ChkSomenteExpedido.Checked), vOrdem )
    End
    Else if RbTiporelatorio.ItemIndex = 4 then
       JsonArrayRetorno := ObjCargaCtrl.GetPedidosParaCargas(vDataInicial, vDataFinal, StrToIntDef(EdtDestinatarioId.Text, 0),
                           StrToIntDef(EdtRotaId.Text, 0), StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtProcessoId.Text, 0));
    if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
          ShowErro(vErro);
       JsonArrayRetorno := Nil;
       ObjCargaCtrl.Free;
       Exit;
    End;
    if RbTiporelatorio.ItemIndex < 3 then Begin
       If FDMemResumoCargas.Active then
          FDMemResumoCargas.EmptyDataSet;
       FDMemResumoCargas.Close;
       FDMemResumoCargas.LoadFromJSON(JsonArrayRetorno, False);
       MontarListaCargas(JsonArrayRetorno);
    End
    Else If RbTiporelatorio.ItemIndex = 3 then Begin
       If FDMemAnaliseConsolidada.Active then
          FDMemAnaliseConsolidada.EmptyDataSet;
       FDMemAnaliseConsolidada.Close;
       FDMemAnaliseConsolidada.LoadFromJSON(JsonArrayRetorno, False);
       MontarListaAnaliseConsolidada(JsonArrayRetorno);
    End
    Else If RbTiporelatorio.ItemIndex = 4 then Begin
       If FDMemPedidosParaCarga.Active then
          FDMemPedidosParaCarga.EmptyDataSet;
       FDMemPedidosParaCarga.Close;
       FDMemPedidosParaCarga.LoadFromJSON(JsonArrayRetorno, False);
       //Pegando Multiplas NFs de cada Pedido
       If FDMemPedidosParaCargaNFs.Active then
          FDMemPedidosParaCargaNFs.EmptyDataSet;
       FDMemPedidosParaCargaNFs.Close;
       JsonArrayRetorno := ObjCargaCtrl.GetPedidosParaCargasNFs(vDataInicial, vDataFinal, StrToIntDef(EdtDestinatarioId.Text, 0),
                           StrToIntDef(EdtRotaId.Text, 0), StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtProcessoId.Text, 0));
       if Not (JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro)) then Begin
          FDMemPedidosParaCargaNFs.LoadFromJSON(JsonArrayRetorno, False);
          AtualizarNFSPedido;
       End;
       MontarListaPedidosParaCarga(JsonArrayRetorno);
    End;
    ObjCargaCtrl.Free;
  End);
end;

procedure TFrmRelMapaCarga.RbTipoRelatorioClick(Sender: TObject);
begin
  inherited;
  if RbTipoRelatorio.ItemIndex = 3 then begin
     EdtCargaid.Text    := '';
     EdtProcessoId.Text := '';
  End;
  if RbTipoRelatorio.Itemindex < 3 then
     GbPeriodoCarga.Caption := 'Período das Cargas'
  Else
     GbPeriodoCarga.Caption  := 'Período dos Pedidos';
  ChkSomenteExpedido.Visible := RbTipoRelatorio.ItemIndex = 3;
  if RbTipoRelatorio.ItemIndex <> 3 then Begin
     EdtCargaId.Enabled         := True; //Not RbTipoRelatorio.ItemIndex = 3;
     EdtProcessoId.Enabled      := True; //Not RbTipoRelatorio.ItemIndex = 3;
  end
  Else Begin
     EdtCargaId.Enabled         := False; //Not RbTipoRelatorio.ItemIndex = 3;
     EdtProcessoId.Enabled      := False; //Not RbTipoRelatorio.ItemIndex = 3;
  End;
  LblPesoKg.Visible          := RbTipoRelatorio.ItemIndex = 3;
  LblTotalPesoKg.Visible     := RbTipoRelatorio.ItemIndex = 3;
  LblVolumem3.Visible        := RbTipoRelatorio.ItemIndex = 3;
  LblTotalVolumem3.Visible   := RbTipoRelatorio.ItemIndex = 3;
  if RbTipoRelatorio.ItemIndex = 3 then Begin
     EdtCargaId.Clear;
     EdtProcessoId.Clear;
  End;
  HeaderLstReport;
end;

end.
