unit uFrmCargaMontar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSON, REST.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, Generics.Collections,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid,
  cxPC, JvToolEdit, JvBaseEdits, Vcl.Buttons, Vcl.DBGrids , DataSet.Serialize
  , CargasCtrl
  , RotaCtrl
  , PessoaCtrl
  , VeiculoCtrl, dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls, ACBrBase,
  ACBrETQ, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet, Vcl.DialogMessage,
  dxCameraControl;

type
  TFrmCargaMontar = class(TFrmBase)
    Label2: TLabel;
    EdtCargaId: TJvCalcEdit;
    LblProcesso: TLabel;
    Label3: TLabel;
    EdtRotaId: TJvCalcEdit;
    LblRota: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    EdtDtInicioMontagem: TJvDateEdit;
    EdtDtTerminoMontagem: TJvDateEdit;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    EdtTransportadoraId: TJvCalcEdit;
    LblTransportadora: TLabel;
    Label4: TLabel;
    LblVeiculo: TLabel;
    Label10: TLabel;
    EdtMotoristaId: TJvCalcEdit;
    LblMotorista: TLabel;
    BtnPesqTransp: TBitBtn;
    BtnPesqVeic: TBitBtn;
    BtnPesqMotorista: TBitBtn;
    BtnPesqRota: TBitBtn;
    Label8: TLabel;
    TotPedidos: TLabel;
    Label11: TLabel;
    TotPeso: TLabel;
    TotVolume: TLabel;
    Label15: TLabel;
    LblCapacidadeVolume: TLabel;
    EdtVeiculoId: TEdit;
    PnlListaCliPedidos: TPanel;
    LstAdvPedidos: TAdvStringGrid;
    LstAdvClientesRota: TAdvStringGrid;
    PnlResumoCarga: TPanel;
    Label9: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    LblVolumeVeiculo: TLabel;
    LblPesoVeiculo: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    LblPesoCarga: TLabel;
    LblVolumeCarga: TLabel;
    BtnCargaPesq: TBitBtn;
    frxMapaCarga: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxDBDataset2: TfrxDBDataset;
    frxDBDataset3: TfrxDBDataset;
    FDMemCargaPessoas: TFDMemTable;
    DsCargaPessoas: TDataSource;
    DsCargaPedidos: TDataSource;
    FDMemCargaPedidos: TFDMemTable;
    FdMemPesqGeralCargaId: TIntegerField;
    FdMemPesqGeralDtInclusao: TDateField;
    FdMemPesqGeralHrInclusao: TTimeField;
    FdMemPesqGeralRotaId: TIntegerField;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralTranspId: TIntegerField;
    FdMemPesqGeralTransportadora: TStringField;
    FdMemPesqGeralMotoristaId: TIntegerField;
    FdMemPesqGeralMotorista: TStringField;
    FdMemPesqGeralVeiculoId: TIntegerField;
    FdMemPesqGeralPlaca: TStringField;
    FDMemCargaPessoasCargaId: TIntegerField;
    FDMemCargaPessoasPessoaId: TIntegerField;
    FDMemCargaPessoasRazao: TStringField;
    FDMemCargaPessoasOrdem: TIntegerField;
    FDMemCargaPedidosCargaId: TIntegerField;
    FDMemCargaPedidosPedidoId: TIntegerField;
    FDMemCargaPedidosPessoaId: TIntegerField;
    FDMemCargaPedidosQtdVolume: TIntegerField;
    FDMemCargaPedidosItens: TIntegerField;
    frxDBDataset1: TfrxDBDataset;
    FDMemCargaPessoasCodPessoaERP: TIntegerField;
    FDMemCargaPessoasPedidoId: TIntegerField;
    FDMemCargaPessoasQtdVolume: TIntegerField;
    FDMemCargaPessoasItens: TIntegerField;
    FdMemPesqGeralTDestinatario: TIntegerField;
    FdMemPesqGeralTPedido: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FDMemCargaPedidosDocumentoNr: TStringField;
    FDMemCargaPedidosDocumentoOriginal: TStringField;
    FDMemCargaPessoasDocumentoNr: TStringField;
    FDMemCargaPessoasDocumentoOriginal: TStringField;
    TabAcompanhamentoCarga: TcxTabSheet;
    RgCargaProcesso: TRadioGroup;
    LstCargaResumo: TAdvStringGrid;
    LblTotRegCaption: TLabel;
    LblTotRegistro: TLabel;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label19: TLabel;
    EdtdtCargaInicial: TJvDateEdit;
    EdtdtCargaFinal: TJvDateEdit;
    GroupBox5: TGroupBox;
    Label20: TLabel;
    LblRotaInicial: TLabel;
    Label22: TLabel;
    LblRotaFinal: TLabel;
    EdtRotaIdInicial: TEdit;
    BtnPesqRotaInicial: TBitBtn;
    EdtRotaIdFinal: TEdit;
    BtnPesqRotaFinal: TBitBtn;
    FDMemResumoCarga: TFDMemTable;
    Label21: TLabel;
    LblQtdVolumeCarga: TLabel;
    BtnFiltro: TPanel;
    sImage1: TsImage;
    TabCargaAnaliseCubagem: TcxTabSheet;
    GroupBox4: TGroupBox;
    Label23: TLabel;
    LblTransportadoraAC: TLabel;
    Label25: TLabel;
    LblVeiculoAC: TLabel;
    Label27: TLabel;
    LblMotoristaAC: TLabel;
    LblVeiculoCapacidadeAC: TLabel;
    EdtTransportadoraIdAC: TJvCalcEdit;
    EdtMotoristaIdAC: TJvCalcEdit;
    EdtVeiculoIdAC: TEdit;
    Label30: TLabel;
    EdtCargaIdAC: TJvCalcEdit;
    BitBtn4: TBitBtn;
    LblCargaAC: TLabel;
    Label32: TLabel;
    EdtRotaIdAC: TJvCalcEdit;
    LstCargaAnaliseCubagem: TAdvStringGrid;
    LblRegAc: TLabel;
    LblTotalRegAC: TLabel;
    LblCubagemAC: TLabel;
    LblCubagemTotalAC: TLabel;
    Label33: TLabel;
    EdtDtCargaAC: TJvDateEdit;
    LblRotaAC: TLabel;
    FdMemCargaAnaliseCubagem: TFDMemTable;
    procedure FormCreate(Sender: TObject);
    procedure EdtCargaIdEnter(Sender: TObject);
    procedure EdtCargaIdExit(Sender: TObject);
    procedure EdtTransportadoraIdExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtMotoristaIdExit(Sender: TObject);
    procedure EdtVeiculoIdExit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtTransportadoraIdEnter(Sender: TObject);
    procedure BtnPesqTranspClick(Sender: TObject);
    procedure BtnPesqMotoristaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure TabListagemShow(Sender: TObject);
    procedure EdtRotaIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesqVeicClick(Sender: TObject);
    procedure EdtDtInicioMontagemExit(Sender: TObject);
    procedure LstAdvPedidosClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtTransportadoraIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtVeiculoIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtMotoristaIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtCargaIdChange(Sender: TObject);
    procedure LstAdvClientesRotaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnCargaPesqClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnPesqRotaInicialClick(Sender: TObject);
    procedure EdtRotaIdInicialExit(Sender: TObject);
    procedure RgCargaProcessoClick(Sender: TObject);
    procedure EdtdtCargaInicialChange(Sender: TObject);
    procedure LstCargaResumoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnFiltroClick(Sender: TObject);
    procedure EdtCargaIdACExit(Sender: TObject);
    procedure TabCargaAnaliseCubagemShow(Sender: TObject);
    procedure EdtCargaIdACKeyPress(Sender: TObject; var Key: Char);
    procedure LstCargaAnaliseCubagemClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure LstCadastroDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    ObjCargaCtrl : TCargasCtrl;
    //ObjTransportadoraCtrl     : TPessoaCtrl;
    //ObjVeiculoCtrl            : TVeiculoCtrl;
    //ObjMotoristaCtrl          : TPessoaCtrl;
    SelClienteRota, SelPedido : Boolean;
    SelEntrega, SelTransito   : Boolean;
    Function GetListaCarga(pCargaId, pRotaId, pProcessoId, pPendente : Integer) : Boolean;
    Function GetClientesRotaCarga : Boolean;
    Procedure GetPedidosExpedido(pShowErro : Integer = 0);
    Procedure GetPedidoCarga(pMontagemCarga : Integer); //Pedidos para montagem da carga
    Function GetTransportadora(pTransportadoraId : Integer) : Boolean;
    Function GetRota(pRotaid : Integer) : Boolean;
    Function GetVeiculo(pVeiculoId : String) : Boolean;
    Function GetMotorista(pMotoristaId   : Integer) : Boolean;
    Procedure MontaPedidoCarga(pJsonArray : TJsonArray);
    Procedure MontaListaPedido(pJsonArray : TJsonArray);
    Procedure MontaListaClientesRotaCarga(pJsonArray : TJsonArray);
    Procedure SelecionarClientePedidos(pRetornoArray : TJsonArray);
    Procedure CalculaPesoVolume;
    Procedure GetCargaPessoas;
    Procedure MontaListacarga(pJsonArrayRetorno : TJsonArray);
    Procedure PesquisarResumoCarga;
    Procedure MontaResumoCarga;
    Procedure LimparResumoCarga;
    Procedure AtualizarStatus(pLinha, pProcessoId : Integer);
    Function GetCargaAnaliseCubagemPorProduto : Boolean;
    Procedure MontaListaAnaliseCubagemPorProduto;
  Protected
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure AfterCancelar; OverRide;
    Procedure Limpar; OverRide;
    Procedure Imprimir; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCargaMontar: TFrmCargaMontar;

implementation

{$R *.dfm}

uses Views.Pequisa.Pessoas, Views.Pequisa.Rotas, PedidoSaidaCtrl, uFuncoes,
  Views.Pequisa.Veiculos, uFrmeXactWMS, PessoaClass, VeiculoClass, CargasClass, Views.Pequisa.Cargas,
  ProcessoCtrl;

procedure TFrmCargaMontar.BtnPesqRotaInicialClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       if Sender = BtnPesqRotaInicial then
          EdtRotaIdInicial.Text := FrmPesquisaRotas.Tag.ToString()
       Else
          EdtRotaIdFinal.Text := FrmPesquisaRotas.Tag.ToString();
       if Sender = BtnPesqRotaInicial then
          EdtRotaIdInicialExit(EdtRotaIdInicial)
       Else If Sender = BtnPesqRotaFinal then
          EdtRotaIdInicialExit(EdtRotaIdFinal);
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmCargaMontar.AfterCancelar;
begin
  BtnFiltro.Visible := False;
end;

procedure TFrmCargaMontar.AtualizarStatus(pLinha, pProcessoId: Integer);
Var xCargas : Integer;
    pJsonObjectCargas     : TJsonObject;
    pJsonObjectCargaItems : TJsonObject;
    pJsonArrayCargas      : TJsonArray;
    JsonArrayRetorno      : TJsonArray;
    vErro                 : String;
begin
  pJsonObjectCargas := TJsonObject.Create;
  pJsonObjectCargas.AddPair('processoid', TJsonNumber.Create(pProcessoId));
  pJsonObjectCargas.AddPair('usuarioid',  TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  pJsonObjectCargas.AddPair('terminal',   NomeDoComputador);
  pJsonArrayCargas      := TJsonArray.Create;
  if pLinha = 0 then Begin
     For xCargas := 1 To LstCargaResumo.RowCount do begin
       pJsonObjectCargaItems := TJsonObject.Create;
       pJsonObjectCargaItems.AddPair('cargaid', TJsonNumber.Create(LstCargaResumo.Cells[ 0, xCargas].ToInteger));
       if pProcessoId = 18 then
          pJsonObjectCargaItems.AddPair('status',  TJsonNumber.Create(LstCargaResumo.Cells[10, xCargas].ToInteger))
       Else
          pJsonObjectCargaItems.AddPair('status',  TJsonNumber.Create(LstCargaResumo.Cells[11, xCargas].ToInteger));
       pJsonArrayCargas.AddElement(pJsonObjectCargaItems);
     End;
  End
  Else Begin
    pJsonObjectCargaItems := TJsonObject.Create;
    pJsonObjectCargaItems.AddPair('cargaid', TJsonNumber.Create(LstCargaResumo.Cells[ 0, pLinha].ToInteger));
    if pProcessoId = 18 then
       pJsonObjectCargaItems.AddPair('status',  TJsonNumber.Create(LstCargaResumo.Cells[10, pLinha].ToInteger))
    Else
       pJsonObjectCargaItems.AddPair('status',  TJsonNumber.Create(LstCargaResumo.Cells[11, pLinha].ToInteger));
    pJsonArrayCargas.AddElement(pJsonObjectCargaItems);
  End;
  pJsonObjectCargas.AddPair('cargas', pJsonArrayCargas);
  JsonArrayRetorno := ObjCargaCtrl.Atualizarstatus(pJsonObjectCargas);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro);
  JsonArrayRetorno := Nil;
  FreeAndNil(pJsonObjectCargas);
end;

procedure TFrmCargaMontar.BtnCargaPesqClick(Sender: TObject);
begin
  inherited;
  if EdtCargaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaCargas := TFrmPesquisaCargas.Create(Application);
  try
    if (FrmPesquisaCargas.ShowModal = mrOk) then Begin
       EdtCargaId.Text := FrmPesquisaCargas.Tag.ToString();
       EdtCargaIdExit(EdtCargaId);
    End;
  finally
    FreeAndNil(FrmPesquisaCargas);
  end;
end;

procedure TFrmCargaMontar.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtRotaId.SetFocus;
  BtnFiltro.Visible := True;
//  PnlListaCliPedidos.Enabled := True;
end;

procedure TFrmCargaMontar.BtnExcluirClick(Sender: TObject);
begin
//  if ObjCargaCtrl.ObjCargas.ProcessoId > 16 then
//     raise Exception.Create('Não é possível Cancelar/Excluir a carga.');
  inherited;
end;

procedure TFrmCargaMontar.BtnExportarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabCargaAnaliseCubagem then Begin
     if (Not FdMemCargaAnaliseCubagem.Active) or (FdMemCargaAnaliseCubagem.IsEmpty) then
        raise Exception.Create('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) or (FdMemCargaAnaliseCubagem.IsEmpty) then Exit;
     Try
       ExportarExcel(FdMemCargaAnaliseCubagem, 'CargaAnaliseCubage.Xls');
     Except
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End
  Else if PgcBase.ActivePage = TabPrincipal then
    inherited;
end;

procedure TFrmCargaMontar.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtRotaId.SetFocus;
  BtnFiltro.Visible := True;
//  PnlListaCliPedidos.Enabled := True;
end;

procedure TFrmCargaMontar.BtnPesqMotoristaClick(Sender: TObject);
begin
  inherited;
  if EdtMotoristaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 4;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then  Begin
       EdtMotoristaId.Text := FrmPesquisaPessoas.Tag.ToString();
       EdtMotoristaIdExit(EdtmotoristaId);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmCargaMontar.BtnPesqRotaClick(Sender: TObject);
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

procedure TFrmCargaMontar.BtnPesqTranspClick(Sender: TObject);
begin
  if EdtTransportadoraId.ReadOnly then Exit;
  inherited;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 3;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then  Begin
       EdtTransportadoraId.Text := FrmPesquisaPessoas.Tag.ToString();
       EdtTransportadoraIdExit(EdtTransportadoraId);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmCargaMontar.BtnPesquisarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabAcompanhamentoCarga then Begin
     if RgCargaProcesso.ItemIndex < 0 then Begin
        ShowErro('Selecione o processo.', 'alerta');
        Exit;
     End;
     PesquisarResumoCarga;
  End
  Else
     inherited;

end;

procedure TFrmCargaMontar.BtnPesqVeicClick(Sender: TObject);
begin
  inherited;
  if EdtVeiculoId.ReadOnly then Exit;
  inherited;
  FrmPesquisaVeiculos := TFrmPesquisaVeiculos.Create(Application);
  try
    if (FrmPesquisaVeiculos.ShowModal = mrOk) then  Begin
       EdtVeiculoId.Text := FrmPesquisaVeiculos.Tag.ToString();
       EdtVeiculoIdExit(EdtVeiculoId);
    End;
  finally
    FreeAndNil(FrmPesquisaVeiculos);
  end;
end;

procedure TFrmCargaMontar.BtnFiltroClick(Sender: TObject);
begin
  inherited;
  if StrToIntDef(EdtRotaId.Text, 0) <= 0 then Begin
     ShowErro('Informe a Rota...');
     EdtRotaId.SetFocus;
     Exit;
  End;
  if StrToIntDef(EdtTransportadoraId.Text, 0) <= 0 then Begin
     ShowErro('Informe a Transportadora...');
     EdtTransportadoraId.SetFocus;
     Exit;
  End;
  if StrToIntDef(EdtVeiculoId.Text, 0) <= 0 then Begin
     ShowErro('Informe o veículo...');
     EdtVeiculoId.SetFocus;
     Exit;
  End;
  if StrToIntDef(EdtMotoristaId.Text, 0) <= 0 then Begin
     ShowErro('Informe o Motorista...');
     EdtMotoristaId.SetFocus;
     Exit;
  End;
  Try
    StrToDate(EdtDtInicioMontagem.Text);
  Except
    EdtDtInicioMontagem.SetFocus;
    Exit;
  End;
  Try
    StrToDate(EdtDtTerminoMontagem.Text);
  Except
    EdtDtTerminoMontagem.SetFocus;
    Exit;
  End;
  if EdtDtInicioMontagem.Text = '  /  /    ' then Begin
     ShowErro('Informe a data Inicial para montagem da carga...');
     EdtDtInicioMontagem.SetFocus;
     Exit;
  End;
  if EdtDtTerminoMontagem.Text = '  /  /    ' then Begin
     ShowErro('Informe a data Final para montagem da carga...');
     EdtDtTerminoMontagem.SetFocus;
     Exit;
  End;
  if StrToDate(EdtDtTerminoMontagem.Text) < StrToDate(EdtDtInicioMontagem.Text) then Begin
     ShowErro('Data Final não pode ser inferior a data inicial.');
     EdtDtTerminoMontagem.SetFocus;
     Exit;
  End;
  If GetClientesRotaCarga then
     GetPedidoCarga(0);
end;

procedure TFrmCargaMontar.CalculaPesoVolume;
Var vPesoGeral, vVolumeGeral, vPesoSel, vVolumeSel : Real;
    xPed, vQtdVolumes : Integer;
begin
  vPesoGeral   := 0;
  vVolumeGeral := 0;
  vPesoSel     := 0;
  vVolumeSel   := 0;
  vQtdVolumes  := 0;
  for xPed := 1 to Pred(LstAdvPedidos.RowCount) do Begin
    if LstAdvPedidos.Cells[10, xPed] = '1' then Begin
       vPesoSel     := vPesoSel    + StrToFloat(LstAdvPedidos.Cells[8, xPed]);
       vVolumeSel   := vVolumeSel  + StrToFloat(LstAdvPedidos.Cells[9, xPed]);
       vQtdVolumes  := vQtdVolumes + (StrToInt(LstAdvPedidos.Cells[5, xPed]));//+StrToInt(LstAdvPedidos.Cells[6, xPed]));
    End;
    vPesoGeral   := vPesoGeral   + StrToFloat(LstAdvPedidos.Cells[8, xPed]);
    vVolumeGeral := vVolumeGeral + StrToFloat(LstAdvPedidos.Cells[9, xPed]);
  End;
  TotPedidos.Caption        := FormatFloat('####0',     LstAdvPedidos.Rowcount-1);
  TotPeso.Caption           := FormatFloat('####0.000', vPesoGeral)+' Kg';
  TotVolume.Caption         := FormatFloat('####0.000', vVolumeGeral)+' m3';
  LblPesoCarga.Caption      := FormatFloat('####0.000', vPesoSel)+' Kg';
  LblVolumeCarga.Caption    := FormatFloat('####0.000000', vVolumeSel)+' m3';
  LblQtdVolumeCarga.Caption := FormatFloat('0', vQtdVolumes);

  if vPesoSel > ObjCargaCtrl.ObjCargas.veiculo.CapacidadeKg then
     LblPesoCarga.Font.Color := ClRed
  Else LblPesoCarga.Font.Color := ClBlack;
  if vVolumeSel > ObjCargaCtrl.ObjCargas.Veiculo.Volume then
     LblVolumeCarga.Font.Color := ClRed
  Else LblVolumeCarga.Font.Color := ClBlack;
  if (vPesoSel > ObjCargaCtrl.ObjCargas.veiculo.CapacidadeKg) or (vVolumeSel > ObjCargaCtrl.ObjCargas.Veiculo.Volume) then
     Player('toast2');
end;

function TFrmCargaMontar.DeleteReg: Boolean;
Var JsonObjectRetorno : TJsonObject;
    vErro : String;
begin
  Result := False;
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Carga - Excluir') then Begin
     ShowErro('Acesso não autorizado a esta funcionalidade!');
     Exit;
  End;
  JsonObjectRetorno := ObjCargaCtrl.DelCargas;
  if JsonObjectRetorno.TryGetValue('Erro', vErro) then
     ShowErro(vErro)
  Else Begin
     ShowOk('Carga Excluída com sucesso!');
     Result := True;
  End;
end;

procedure TFrmCargaMontar.EdtCargaIdACExit(Sender: TObject);
Var JsonArrayRetornoAC, JsonArrayPedidos : TJsonArray;
    vTransportadoraId, vVeiculoId, vMotoristaId : Integer;
    vErro, vDtInclusao : String;
begin
  inherited;
  if (Not EdtCargaIdAC.ReadOnly) and (EdtCargaIdAC.Text<>'') then Begin
     //Limpar;
     if StrToIntDef(EdtCargaIdAC.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtCargaIdAC.Text+') inválido!');
     JsonArrayRetornoAC := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaIdAC.Text, 0), 0, 0, '', '', '', '', 0, '', '', 0);
     if Not JsonArrayRetornoAC.Items[0].TryGetValue('Erro', vErro) then Begin
        EdtRotaIdAC.Text   := JsonArrayRetornoAC.Items[0].GetValue<Integer>('rotaid', 0).ToString();
        EdtDtCargaAC.Text  := JsonArrayRetornoAC.Items[0].GetValue<String>('dtinclusao', '  /  /    ');
        LblCargaAC.Caption := JsonArrayRetornoAC.Items[0].GetValue<String>('processo');
        vTransportadoraId  := JsonArrayRetornoAC.Items[0].GetValue<Integer>('transportadoraid', 0);
        vVeiculoId         := JsonArrayRetornoAC.Items[0].GetValue<Integer>('veiculoid', 0);
        vMotoristaId       := JsonArrayRetornoAC.Items[0].GetValue<Integer>('motoristaid', 0);
        GetTransportadora(vTransportadoraId); //          JsonCarga.GetValue<Integer>('transportadoraid', 0));
        GetVeiculo(       vVeiculoId.ToString());
        GetMotorista(     vMotoristaId);
        if GetCargaAnaliseCubagemPorProduto then
           MontaListaAnaliseCubagemPorProduto;
     End
     Else
        ShowErro('Erro: '+vErro);
//     JsonArrayRetornoAC := Nil;
//     FreeAndNil(ObjCargaCtrl);
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtCargaIdACKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) and (EdtCargaIdAC.Text<>'') then
     LstCargaAnaliseCubagem.SetFocus;
end;

procedure TFrmCargaMontar.EdtCargaIdChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmCargaMontar.EdtCargaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmCargaMontar.EdtCargaIdExit(Sender: TObject);
Var JsonArrayRetorno, JsonArrayPedidos : TJsonArray;
    JsonCarga : TJsonObject;
    vTransportadoraId, vVeiculoId, vMotoristaId : Integer;
    vErro, vDtInclusao : String;
begin
  if (EdtCargaId.Text<>'') and (StrToIntDef(EdtCargaId.Text, 0)<=0) then Begin
     EdtCargaId.SetFocus;
     ShowErro('Id de Carga('+EdtCargaId.Text+') inválido!');
     EdtCargaId.Clear;
  End;  inherited;
  if (Not EdtCargaId.ReadOnly) and (EdtCargaId.Text<>'') and (StrToIntDef(EdtCargaId.Text,0)<>ObjCargaCtrl.ObjCargas.CargaId) then Begin
     //Limpar;
     if StrToIntDef(EdtCargaId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtCargaId.Text+') inválido!');
     JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', '', 0, '', '', 0);
     if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
//        If JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
//           ShowErro(vErro);
//           Exit;
//        End;
        JsonCarga := JsonArrayRetorno.Items[0] as TJsonObject;
        ObjCargaCtrl.ObjCargas.CargaId    := JsonCarga.GetValue<Integer>('cargaid', 0);
        ObjCargaCtrl.ObjCargas.RotaId     := JsonCarga.GetValue<Integer>('rotaid', 0);
        vDtInclusao := JsonCarga.GetValue<String>('dtinclusao', '  /  /    ');
        ObjCargaCtrl.ObjCargas.DtInclusao := StrToDate(JsonCarga.GetValue<String>('dtinclusao', '  /  /    ')); //EncodeDate(StrToInt(Copy(vDtInclusao, 1, 4)),
                                                        //StrToInt(Copy(vDtInclusao, 6, 2)),
                                                        //StrToInt(Copy(vDtInclusao, 9, 2)) );
        //StrToDate(RetornoArray.Items[0].GetValue<String>('dtinclusao', '  /  /    '));
        ObjCargaCtrl.ObjCargas.HrInclusao := StrToTime( JsonCarga.GetValue<String>('hrinclusao'));  //StrToTime(Copy(RetornoArray.Items[0].GetValue<String>('hrinclusao'),1,8));
        ObjCargaCtrl.ObjCargas.status     := JsonCarga.GetValue<Integer>('status', 0);
        ObjCargaCtrl.ObjCargas.UsuarioId  := JsonCarga.GetValue<Integer>('usuarioid', 0);
        ObjCargaCtrl.ObjCargas.ProcessoId := JsonCarga.GetValue<Integer>('processoid', 0);
        ObjCargaCtrl.ObjCargas.EmConferencia := JsonCarga.GetValue<Integer>('emconferencia', 0);
        ObjCargaCtrl.ObjCargas.Carregando    := JsonCarga.GetValue<Integer>('carregando', 0);
        ObjCargaCtrl.ObjCargas.StatusOper    := JsonCarga.GetValue<Integer>('statusoper', 0);
        ObjCargaCtrl.ObjCargas.Conferencia   := JsonCarga.GetValue<Integer>('conferencia', 0);
        vTransportadoraId := JsonCarga.GetValue<Integer>('transportadoraid', 0);
        vVeiculoId        := JsonCarga.GetValue<Integer>('veiculoid', 0);
        vMotoristaId      := JsonCarga.GetValue<Integer>('motoristaid', 0);
        GetTransportadora(vTransportadoraId);
        GetVeiculo(vVeiculoId.ToString());
        GetMotorista(vMotoristaId);
        ShowDados;
        JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', '', 0, '', '', 0);
        if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
           ShowErro('Erro: '+vErro)
        Else Begin
           SelecionarClientePedidos(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('pedidos'));
           CalculaPesoVolume;
        End;
     End Else
       ShowErro('Carga não encontrada!');
     //JsonArrayRetorno := Nil;
     //JsonArrayPedidos := Nil;
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtdtCargaInicialChange(Sender: TObject);
begin
  inherited;
  if (Sender = EdtRotaIdInicial) then LblRotaInicial.Caption := '...'
  Else if (Sender = EdtRotaIdFinal) then LblRotaFinal.Caption := '...';
  LimparResumoCarga;
end;

procedure TFrmCargaMontar.EdtDtInicioMontagemExit(Sender: TObject);
begin
  inherited;
  if (Not EdtRotaId.ReadOnly) and (TEdit(Sender).Text<>'  /  /    ') then Begin
     Try
       StrToDate(TEdit(Sender).Text);
     Except
       ShowErro('Data inválida!');
       TEdit(Sender).SetFocus;
       ExitFocus(Sender);
     End;
     //GetClientesRotaCarga;
     //GetPedidoCarga(0);
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtMotoristaIdExit(Sender: TObject);
begin
  if (EdtMotoristaId.Text<>'') and (StrToIntDef(EdtMotoristaId.Text, 0)<=0) then Begin
     EdtMotoristaId.SetFocus;
     ShowErro('Id do Motorista('+EdtMotoristaId.Text+') inválido!');
     EdtMotoristaId.Clear;
     Exit;
  End;
  inherited;
  if EdtMotoristaId.Text = '' then Begin ExitFocus(Sender); Exit; End;
  if StrToIntDef(EdtMotoristaId.Text, 0) <=0 then Begin ExitFocus(Sender); Exit; End;
  Try
    If Not GetMotorista(StrToIntDef(EdtMotoristaId.Text, 0)) Then Begin
       EdtMotoristaId.Clear;
       EdtMotoristaId.SetFocus;
    End;
    ExitFocus(Sender);
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtMotoristaIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Not EdtMotoristaId.ReadOnly then
     LblMotorista.Caption := '';
end;

procedure TFrmCargaMontar.EdtRotaIdExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
begin
  if ((TEdit(Sender).Text<>'') And (StrToIntDef(TEdit(Sender).Text, 0)<=0)) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id da Rota('+TEdit(Sender).Text+') inválido!');
     TEdit(Sender).Clear;
     Exit;
  End;
  inherited;
  if (Sender = TEdit(Sender)) and (TEdit(Sender).Text<>'') and (Not TEdit(Sender).ReadOnly) then Begin
     Try
       If Not GetRota(StrToIntDef(TEdit(Sender).Text, 0)) then Begin
          TEdit(Sender).Clear;
          TEdit(Sender).SetFocus;
       End
       Else if StrToIntDef(EdtCargaId.Text, 0) > 0 then Begin
          JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', '', 0, '', '', 2);
          SelecionarClientePedidos(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('pedidos'));
          JsonArrayRetorno := Nil;
       End;
     Except On E: Exception do Begin
       EdtRotaId.Clear;
       EdtRotaId.SetFocus;
       raise Exception.Create(E.Message);
       End;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtRotaIdInicialExit(Sender: TObject);
Var ObjRotaCtrl    : TRotaCtrl;
    ReturnLstRota  : TObjectList<TRotaCtrl>;
    xRetorno       : Integer;
    vErro          : String;
begin
  if (Sender=EdtRotaIdFinal) and (StrToIntDef(EdtRotaIdFinal.Text, 0) > 0) and
     (StrToIntDef(EdtRotaIdFinal.Text, 0) < StrToIntDef(EdtRotaIdInicial.Text, 0)) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Rota Final inválida!!!');
     Exit;
  End;
  inherited;
  if (TEdit(Sender).Text<>'') and (Not TEdit(Sender).ReadOnly) then Begin
     if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
        TEdit(Sender).SetFocus;
        ShowErro('😢Rota('+TEdit(Sender).Text+') inválida!');
        ReturnLstRota := Nil;
        ObjRotaCtrl.Free;
        Exit
     end;
     ObjRotaCtrl   := TRotaCtrl.Create;
     ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
     if (ReturnLstRota.Count <= 0) then Begin
        TEdit(Sender).Clear;
        TEdit(Sender).SetFocus;
        ShowErro('😢Rota não('+TEdit(Sender).Text+') encontrada!');
     end
     Else Begin
        if Sender = EdtRotaIdInicial then
           LblRotaInicial.Caption := ReturnLstRota.Items[0].ObjRota.Descricao
        Else LblRotaFinal.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
     End;
     ReturnLstRota := Nil;
     ObjRotaCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtRotaIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Sender=EdtRotaId) and (Not EdtRotaId.ReadOnly)) or (Not TJvDateEdit(Sender).ReadOnly) then Begin
     LstAdvClientesRota.ClearRect(0, 1, LstAdvClientesRota.ColCount-1, LstAdvClientesRota.RowCount-1);
     LstAdvClientesRota.RowCount := 1;
     LstAdvPedidos.ClearRect(0, 1, LstAdvPedidos.ColCount-1, LstAdvPedidos.RowCount-1);
     LstAdvPedidos.RowCount := 1;
  End;
end;

procedure TFrmCargaMontar.EdtTransportadoraIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmCargaMontar.EdtTransportadoraIdExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
    //ObjTransportadoraCtrl : TPessoaCtrl;
begin
  if (TEdit(Sender).Text<>'') And (StrToIntDef(TEdit(Sender).Text, 0)<=0) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id da Transportadora2('+TEdit(Sender).Text+') inválido!');
     TEdit(Sender).Clear;
     Exit;
  End;
  inherited;
  if TEdit(Sender).Text = '' then Begin
     ExitFocus(Sender);
     Exit;
  End;
  if PgcBase.ActivePage = TabPrincipal then
     LblTransportadora.Caption := ''
  Else
     LblTransportadoraAC.Caption := '';
  if StrToIntDef(TEdit(Sender).Text, 0) <=0 then Begin ExitFocus(Sender); Exit; End;
  Try
    If Not GetTransportadora(StrToIntDef(TEdit(Sender).Text, 0)) Then Begin
       TEdit(Sender).Clear;
       TEdit(Sender).SetFocus;
    End;
    ExitFocus(Sender);
  Except On E: Exception do
    raise Exception.Create('Erro: '+#13+E.Message);
  End;
  ExitFocus(Sender);
end;

procedure TFrmCargaMontar.EdtTransportadoraIdKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Not EdtTransportadoraId.ReadOnly then
     LblTransportadora.Caption := '';
end;

procedure TFrmCargaMontar.EdtVeiculoIdExit(Sender: TObject);
Var vErro : String;
    //ObjVeiculoCtrl : TVeiculoCtrl;
begin
  if (TEdit(Sender).Text<>'') and (StrToIntDef(TEdit(Sender).Text, 0)<=0) then Begin
     TEdit(Sender).SetFocus;
     ShowErro('Id do Veículo('+TEdit(Sender).Text+') inválido!');
     TEdit(Sender).Clear;
     Exit;
  End;
  inherited;
  if (TEdit(Sender).Text = '') or (TEdit(Sender).ReadOnly) then Begin ExitFocus(Sender); Exit; ExitFocus(Sender); End;
  Try
    If Not GetVeiculo(TEdit(Sender).Text) Then Begin
       TEdit(Sender).Clear;
       TEdit(Sender).SetFocus;
    End;
    ExitFocus(Sender);
  Except On E: Exception do begin
    ExitFocus(Sender);
    Raise Exception.Create('Erro: '+E.Message);
    end;
  end;
end;

procedure TFrmCargaMontar.EdtVeiculoIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Not TEdit(Sender).ReadOnly then Begin
     if PgcBase.ActivePage = TabPrincipal then Begin
        LblVeiculo.Caption := '';
        LblCapacidadeVolume.Caption := '';
     End
     Else if PgcBase.ActivePage = TabPrincipal then Begin
        LblVeiculoAC.Caption := '';
     End
   End;
end;

procedure TFrmCargaMontar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCargaMontar := Nil;
end;

procedure TFrmCargaMontar.FormCreate(Sender: TObject);
begin
  inherited;
  ObjCargaCtrl             := TCargasCtrl.Create;
  LstCadastro.ColWidths[0] :=  65+Trunc(65*ResponsivoVideo);
  LstCadastro.ColWidths[1] :=  80+Trunc(80*ResponsivoVideo);
  LstCadastro.ColWidths[2] := 200+Trunc(200*ResponsivoVideo);
  LstCadastro.ColWidths[3] := 250+Trunc(250*ResponsivoVideo);
  LstCadastro.ColWidths[4] := 100+Trunc(100*ResponsivoVideo);
  LstCadastro.ColWidths[5] := 130+Trunc(130*ResponsivoVideo);
  LstCadastro.ColWidths[6] :=  65+Trunc(65*ResponsivoVideo);
  LstCadastro.ColWidths[7] :=  65+Trunc(65*ResponsivoVideo);
  LstCadastro.ColWidths[8] :=  65+Trunc(65*ResponsivoVideo);
  LstCadastro.ColWidths[9] :=  40+Trunc(40*ResponsivoVideo);
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[1, 0] := taCenter;
  LstCadastro.Alignments[2, 0] := taLeftJustify;
  LstCadastro.Alignments[3, 0] := taLeftJustify;
  LstCadastro.Alignments[4, 0] := taLeftJustify;
  LstCadastro.Alignments[6, 0] := taRightJustify;
  LstCadastro.Alignments[7, 0] := taRightJustify;
  LstCadastro.Alignments[8, 0] := taRightJustify;
  LstCadastro.Alignments[9, 0] := taCenter;
  LstCadastro.RowCount := 1;

  LstAdvClientesRota.ColWidths[0] :=  70+Trunc(70*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[1] :=  60+Trunc(60*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[2] := 280+Trunc(280*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[3] :=  40+Trunc(40*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[4] :=  50+Trunc(50*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[5] :=  70+Trunc(70*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[6] :=  80+Trunc(80*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[7] :=  70+Trunc(70*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[8] :=  90+Trunc(90*ResponsivoVideo);
  LstAdvClientesRota.ColWidths[9] :=  60+Trunc(60*ResponsivoVideo);
  LstAdvClientesRota.Alignments[1 ,0] := taRightJustify;
  LstAdvClientesRota.Alignments[4 ,0] := taRightJustify;
  LstAdvClientesRota.Alignments[5 ,0] := taRightJustify;
  LstAdvClientesRota.Alignments[6 ,0] := taRightJustify;
  LstAdvClientesRota.Alignments[7 ,0] := taRightJustify;
  LstAdvClientesRota.Alignments[8 ,0] := taRightJustify;
  LstAdvClientesRota.Alignments[9 ,0] := taCenter;
  LstAdvClientesRota.FontStyles[0, 0] := [FsBold];
  LstAdvClientesRota.RowCount := 1;
//Listagem de Pedidos para Carga
  LstAdvPedidos.ColWidths[0]  :=  60+Trunc(60*ResponsivoVideo);
  LstAdvPedidos.ColWidths[1]  :=  75+Trunc(75*ResponsivoVideo);
  LstAdvPedidos.ColWidths[2]  := 100+Trunc(100*ResponsivoVideo);
  LstAdvPedidos.ColWidths[3]  :=  60+Trunc(60*ResponsivoVideo);
  LstAdvPedidos.ColWidths[4]  := 280+Trunc(280*ResponsivoVideo);
  LstAdvPedidos.ColWidths[5]  :=  60+Trunc(60*ResponsivoVideo);
  LstAdvPedidos.ColWidths[6]  :=  80+Trunc(80*ResponsivoVideo);
  LstAdvPedidos.ColWidths[7]  :=  85+Trunc(85*ResponsivoVideo);
  LstAdvPedidos.ColWidths[8]  :=  80+Trunc(80*ResponsivoVideo);
  LstAdvPedidos.ColWidths[9]  :=  80+Trunc(80*ResponsivoVideo);
  LstAdvPedidos.ColWidths[10] :=  60+Trunc(60*ResponsivoVideo);
  LstAdvPedidos.Alignments[0, 0]  := taRightJustify;
  LstAdvPedidos.FontStyles[0, 0]  := [FsBold];
  LstAdvPedidos.Alignments[1, 0]  := taCenter;
  LstAdvPedidos.Alignments[2, 0] := taRightJustify;
  LstAdvPedidos.Alignments[3, 0] := taRightJustify;
  LstAdvPedidos.Alignments[5, 0] := taRightJustify;
  LstAdvPedidos.Alignments[6, 0] := taRightJustify;
  LstAdvPedidos.Alignments[7, 0] := taRightJustify;
  LstAdvPedidos.Alignments[8, 0] := taRightJustify;
  LstAdvPedidos.Alignments[9, 0] := taRightJustify;
  LstAdvPedidos.Alignments[10, 0] := taCenter;

   LstCargaResumo.ColWidths[ 0]  :=  80+Trunc(80*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 1]  :=  80+Trunc(80*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 2]  := 120+Trunc(120*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 3]  := 200+Trunc(200*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 4]  := 220+Trunc(220*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 5]  :=  70+Trunc(70*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 6]  :=  60+Trunc(60*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 7]  :=  70+Trunc(70*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 8]  :=  90+Trunc(90*ResponsivoVideo);
   LstCargaResumo.ColWidths[ 9]  :=  40+Trunc(40*ResponsivoVideo);
   LstCargaResumo.ColWidths[10]  :=  40+Trunc(40*ResponsivoVideo);
   LstCargaResumo.ColWidths[11]  :=  40+Trunc(40*ResponsivoVideo);
   LstCargaResumo.ColWidths[12]  :=  40+Trunc(40*ResponsivoVideo);
   LstCargaResumo.Alignments[0, 0]  := taRightJustify;
   LstCargaResumo.FontStyles[0, 0]  := [FsBold];
   LstCargaResumo.Alignments[1, 0]  := taCenter;
   LstCargaResumo.Alignments[6, 0]  := taRightJustify;
   LstCargaResumo.Alignments[7, 0]  := taRightJustify;
   LstCargaResumo.Alignments[8, 0]  := taRightJustify;
   LstCargaResumo.Alignments[9, 0]  := taRightJustify;
   LstCargaResumo.Alignments[10, 0]  := taCenter;
   LstCargaResumo.Alignments[11, 0]  := taCenter;
   LstCargaResumo.HideColumn(12);
//Analise de Cubagem
   LstCargaAnaliseCubagem.ColWidths[ 0] :=  80+Trunc(80*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 1] :=  80+Trunc(80*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 2] := 120+Trunc(120*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 3] :=  70+Trunc(70*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 4] := 320+Trunc(320*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 5] :=  70+Trunc(70*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 6] :=  70+Trunc(70*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 7] :=  70+Trunc(70*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 8] :=  70+Trunc(70*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[ 9] :=  70+Trunc(70*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[10] :=  90+Trunc(90*ResponsivoVideo);
   LstCargaAnaliseCubagem.ColWidths[11] :=  90+Trunc(90*ResponsivoVideo);
   LstCargaAnaliseCubagem.Alignments[0, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.FontStyles[0, 0]  := [FsBold];
   LstCargaAnaliseCubagem.Alignments[1, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[3, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[5, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[6, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[7, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[8, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[9, 0]  := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[10, 0] := taRightJustify;
   LstCargaAnaliseCubagem.Alignments[11, 0] := taRightJustify;
//  LstAdvPedidos.HideColumn(18);
  LstAdvPedidos.RowCount := 1;
  SelClienteRota := False;
  SelPedido      := False;
  SelEntrega     := False;
  SelTransito    := False;
  RgCargaProcesso.ItemIndex := 7;
  TabCargaAnaliseCubagem.TabVisible := False;
end;

procedure TFrmCargaMontar.FormDestroy(Sender: TObject);
begin
  Try
    FreeAndNil(ObjCargaCtrl);
  Except
  End;
  inherited;
end;

function TFrmCargaMontar.GetCargaAnaliseCubagemPorProduto: Boolean;
Var JsonArrayRetornoAC : TJsonArray;
    ObjCargaCA : TCargasCTRL;
    vErro : String;
    pEmbalagem : Integer;
begin
  Result := False;
  pEmbalagem := 2; //Criar combo para Tipo de Embalagem
  Try
    //ObjCargaCA := TCargasCTRL.Create;
    ObjCargaCtrl := TCargasCtrl.Create;
    JsonArrayRetornoAC := ObjCargaCtrl.GetCargaAnaliseCubagemPorProduto(StrToIntDef(EdtCargaIdAC.Text, 0), pEmbalagem);
    if JsonArrayRetornoAC.Items[0].tryGetValue<String>('Erro', vErro) then Begin
       ShowErro('😢Erro: '+vErro);
       Player('toast4');
       LstCargaAnaliseCubagem.ClearRect(0, 1, LstCargaAnaliseCubagem.ColCount-1, LstCargaAnaliseCubagem.RowCount-1);
       LstCargaAnaliseCubagem.RowCount := 1;
    End
    Else
       FdMemCargaAnaliseCubagem.LoadFromJSON(JsonArrayRetornoAC, false);
    JsonArrayRetornoAC := Nil;
    Result := True
  Except On E: Exception do
    ShowErro('Erro: '+E.Message);
  End;
end;

procedure TFrmCargaMontar.GetCargaPessoas;
Var vErro : String;
    JsonArrayRetorno : TJsonArray;
begin
  JsonArrayRetorno := ObjCargaCtrl.GetCargaPessoas(StrToIntDef(EdtCargaId.Text, 0), 'CO', 0);
  if JsonArrayRetorno.Items[0].tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
     Player('toast4');
     LstAdvClientesRota.ClearRect(0, 1, LstAdvClientesRota.ColCount-1, LstAdvClientesRota.RowCount-1);
     LstAdvClientesRota.RowCount := 1;
  End
  Else
     MontaListaClientesRotaCarga(JsonArrayRetorno);
  JsonArrayRetorno := Nil;
end;

Function TFrmCargaMontar.GetClientesRotaCarga : Boolean;
Var vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vProcessoId, vRecebido, vCubagem, vEtiqueta : Integer;
    JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
begin
  Result := False;
  vProcessoId := 13;
  Try
    If EdtDtInicioMontagem.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtDtInicioMontagem.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtTerminoMontagem.Text = '  /  /    ' then
       vDtFinal := 0
    Else vDtFinal := StrToDate(EdtDtTerminoMontagem.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtDtInicioMontagem.Text) > StrToDate(EdtDtTerminoMontagem.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  if (vDtInicio <> 0) and (vDtFinal=0) then
     vDtFinal := vDtInicio;
  if (vDtInicio = 0) and (vDtFinal<>0) then
     vDtInicio := vDtFinal;
  ObjPedidoCtrl := tPedidoSaidaCtrl.Create;
  //JsonArrayRetorno := TJsonArray.Create;
  JsonArrayRetorno := ObjPedidoCtrl.GetClientesRotaCarga(0, '', vDtInicio, vDtFInal, StrToIntDef(EdtRotaId.Text, 0), 13);
  if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
     Player('toast4');
     LstAdvClientesRota.ClearRect(0, 1, LstAdvClientesRota.ColCount-1, LstAdvClientesRota.RowCount-1);
     LstAdvClientesRota.RowCount := 1;
  End
  Else Begin
    if JsonArrayRetorno.Count < 1 then Begin
       ShowErro('😢Erro: Não foram encontrado dados para geração de carga!');
       Player('toast4');
       LstAdvClientesRota.ClearRect(0, 1, LstAdvClientesRota.ColCount-1, LstAdvClientesRota.RowCount-1);
       LstAdvClientesRota.RowCount := 1;
    End
    Else Begin
       MontaListaClientesRotaCarga(JsonArrayRetorno);
       Result := True;
    End;
  End;
  JsonArrayRetorno := Nil;
  ObjPedidoCtrl.Free;
end;

function TFrmCargaMontar.GetListaCarga(pCargaId, pRotaId, pProcessoId, pPendente : Integer) : Boolean;
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  JsonArrayRetorno := ObjCargaCtrl.Lista(0, 0, 0, 1);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     MontaListacarga(JsonArrayRetorno);
  End;
  JsonArrayRetorno := Nil;
end;

procedure TFrmCargaMontar.GetListaLstCadastro;
begin
  inherited;
  GetListaCarga(0, 0, 16, 1);
end;

Function TFrmCargaMontar.GetMotorista(pMotoristaId : Integer) : Boolean;
Var ObjMotoristaCtrl : TPessoaCtrl;
    vArrayRetornoMotor : TJsonArray;
    vErro : String;
begin
  Result := False;
  ObjMotoristaCtrl := TPessoaCtrl.Create;
  vArrayRetornoMotor := ObjMotoristaCtrl.FindPessoa(pMotoristaId, 0, '', '', 4, 1);
  if vArrayRetornoMotor.Items[0].TryGetValue('Erro', vErro) then Begin
     EdtMotoristaId.Clear;
     EdtMotoristaId.SetFocus;
     Raise Exception.Create(vErro);
  End
  Else if (vArrayRetornoMotor.Items[0].GetValue<Integer>('status') = 0) and
    ((PgcBase.ActivePage = TabPrincipal) and (not EdtMotoristaId.ReadOnly)) Then Begin
    EdtMotoristaId.Clear;
    EdtMotoristaId.SetFocus;
    Raise Exception.Create('Motorista Inativo');
  End
  Else Begin
    if PgcBase.ActivePage = TabPrincipal then Begin
       LblMotorista.Caption := '...';
       ObjCargaCtrl.ObjCargas.Motorista.PessoaId  := vArrayRetornoMotor.Items[0].GetValue<Integer>('pessoaId');
       ObjCargaCtrl.ObjCargas.Motorista.CodPessoa := vArrayRetornoMotor.Items[0].GetValue<Integer>('codpessoaerp');
       ObjCargaCtrl.ObjCargas.Motorista.Razao     := vArrayRetornoMotor.Items[0].GetValue<String>('razao');
       ObjCargaCtrl.ObjCargas.Motorista.Fantasia  := vArrayRetornoMotor.Items[0].GetValue<String>('fantasia');
       LblMotorista.Caption             := ObjCargaCtrl.ObjCargas.Motorista.Razao;
    End
    Else Begin
       EdtMotoristaIdAC.Text  := pMotoristaId.ToString();
       LblMotoristaAC.Caption := vArrayRetornoMotor.Items[0].GetValue<String>('fantasia');
    End;
    Result := True;
  End;
  vArrayRetornoMotor := Nil;
  FreeAndNil(ObjMotoristaCtrl);
end;

procedure TFrmCargaMontar.GetPedidoCarga(pMontagemCarga : Integer);
Var vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vProcessoId, vRecebido, vCubagem, vEtiqueta : Integer;
    JsonArrayRet : TJsonArray;
    ObjPedCtrl   : TPedidoSaidaCtrl;
begin
  vProcessoId := 0; //Criar combo para selecionar a etapa do pedidos
  Try
    if EdtDtInicioMontagem.Text <> '  /  /    ' then
       vDtInicio := StrToDate(EdtDtInicioMontagem.Text)
    else
       vDtInicio := 0;
  Except
    raise Exception.Create('Data inicial para montagem da carga é inválida!');
  End;
  Try
    if EdtDtTerminoMontagem.Text <> '  /  /    ' then
       vDtFinal := StrToDate(EdtDtTerminoMontagem.Text)
    else
       vDtFinal := 0;
  Except
    raise Exception.Create('Data Final para montagem da carga é inválida!');
  End;
  if (vDtInicio <> 0) and (vDtFinal=0) then
     vDtFinal := vDtInicio;
  if (vDtInicio = 0) and (vDtFinal<>0) then
     vDtInicio := vDtFinal;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    begin
      ObjPedCtrl := TPedidoSaidaCtrl.Create;
      Try
        JsonArrayRet := ObjPedCtrl.PedidoParaCargas(0, 0, 0, vDtInicio, vDtFinal,
                                                   '', '', '', StrToIntDef(EdtRotaId.Text, 0), StrToIntDef(EdtRotaId.Text, 0), 0,
                                                   pMontagemCarga, StrToIntDef(EdtcargaId.Text, 0));
       Except
      End;
      if JsonArrayRet.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LstAdvPedidos.ClearRect(0, 1, LstAdvPedidos.ColCount-1, LstAdvPedidos.RowCount-1);
         LstAdvPedidos.RowCount := 1;
      End
      Else Begin
         MontaPedidoCarga(JsonArrayRet);
      End;
      JsonArrayRet := Nil;
      ObjPedCtrl.Free;
    End);
end;

procedure TFrmCargaMontar.GetPedidosExpedido(pShowErro : Integer);
Var vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vProcessoId, vRecebido, vCubagem, vEtiqueta : Integer;
    JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
begin
  vProcessoId := 0; //Criar combo para selecionar a etapa do pedidos
  vDtInicio := 0;
  vDtFinal  := 0;
  JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(0, 0, 0, vDtInicio, vDtFInal,
                                                   '', '', '', 0, 0, 0, 13, 1, 1, 1, False, 0, 0, 0, 0, '', 2, 2);
  if (JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     if pShowErro = 1 then Begin
        ShowErro('😢Erro: '+vErro);
        Player('toast4');
     End;
     LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
     LstCadastro.RowCount := 1;
  End
  Else
    MontaListaPedido(JsonArrayRetorno);
  JsonArrayRetorno := Nil;
  ObjPedidoCtrl := Nil;
end;

function TFrmCargaMontar.GetRota(pRotaid: Integer): Boolean;
Var ObjRotaCtrl  : TRotactrl;
begin
  Result := False;
  Try
    Try
      if PgcBase.ActivePage = TabPrincipal then
         LblRota.Caption := ''
      Else
         LblRotaAC.Caption := '';
      if pRotaId <=0 then
         raise Exception.Create('Id da Rota Inválido para pesquisa!');
      ObjRotaCtrl := TRotaCtrl.Create;
      ObjRotaCtrl := ObjRotaCtrl.GetRota(pRotaId, '')[0];
      if PgcBase.ActivePage = TabPrincipal then
         LblRota.Caption := ObjRotaCtrl.ObjRota.Descricao
      Else
         LblRotaAC.Caption := ObjRotaCtrl.ObjRota.Descricao;
      if (ObjRotaCtrl.ObjRota.Status = 0) and (PgcBase.ActivePage = TabPrincipal) then Begin
         LblRota.Caption := '...';
         EdtRotaId.Clear;
         EdtRotaId.SetFocus;
         raise Exception.Create('Rota inativada!');
      End
      Else Begin
         if (Not BtnSalvar.Enabled) and (PgcBase.ActivePage = TabPrincipal) then Begin
            GetCargaPessoas;
            if EdtRotaId.ReadOnly  then
               GetPedidoCarga(1) //Invertido em 29-11-2022
            Else GetPedidoCarga(0);
         End;
         Result := True;
      End;
    Except On E: Exception do Begin
      raise Exception.Create('Erro: '+E.Message);
      End;
    End;
  Finally
    FreeAndNil(ObjRotaCtrl);
  End;
end;

Function TFrmCargaMontar.GetTransportadora(pTransportadoraId: Integer) : Boolean;
Var ObjTransportadoraCtrl  : TPessoaCtrl;
    JsonArrayRetornoTransp : TJsonArray;
    VErro : String;
begin
  Result := False;
  If pTransportadoraid <> 0 then Begin
     LblTransportadora.Caption := '';
     ObjTransportadoraCtrl  := TPessoaCtrl.Create();
     JsonArrayRetornoTransp := ObjTransportadoraCtrl.FindPessoa(ptransportadoraid, 0, '', '', 3, 1);
     if JsonArrayRetornoTransp.Items[0].TryGetValue('Erro', vErro) then Begin
        EdtTransportadoraId.Clear;
        EdtTransportadoraId.SetFocus;
        Raise Exception.Create('Transportadora não encontrada.');
     End
     Else if (JsonArrayRetornoTransp.Items[0].GetValue<Integer>('status') = 0) and
       ((PgcBase.ActivePage = TabPrincipal) and (not EdtTransportadoraId.ReadOnly)) Then Begin
       EdtTransportadoraId.Clear;
       EdtTransportadoraId.SetFocus;
       Raise Exception.Create('Transportadora Inativa!');
     End
     Else if PgcBase.ActivePage = TabPrincipal then begin
        ObjCargaCtrl.ObjCargas.Transportadora.Pessoaid  := JsonArrayRetornoTransp.Items[0].GetValue<Integer>('pessoaId');
        ObjCargaCtrl.ObjCargas.Transportadora.CodPessoa := JsonArrayRetornoTransp.Items[0].GetValue<Integer>('codpessoaerp');
        ObjCargaCtrl.ObjCargas.Transportadora.Razao     := JsonArrayRetornoTransp.Items[0].GetValue<String>('razao');
        ObjCargaCtrl.ObjCargas.Transportadora.Fantasia  := JsonArrayRetornoTransp.Items[0].GetValue<String>('fantasia');
        LblTransportadora.Caption := JsonArrayRetornoTransp.Items[0].GetValue<String>('razao');
        Result := True;
     end
     Else if PgcBase.ActivePage = TabPrincipal then Begin
        EdtTransportadoraIdAC.Text := pTransportadoraId.ToString();
        LblTransportadoraAC.Caption := JsonArrayRetornoTransp.Items[0].GetValue<String>('fantasia');
        Result := True;
     End;
     JsonArrayRetornoTransp := Nil;
     FreeAndNil(ObjTransportadoraCtrl);
  End;
end;

Function TFrmCargaMontar.GetVeiculo(pVeiculoId : String) : Boolean;
Var ObjVeiculoCtrl : TVeiculoCtrl;
    vArrayRetornov : TJsonArray;
    vErro : String;
begin
  ObjVeiculoCtrl := TVeiculoCtrl.Create;
  if (StrToIntDef(pVeiculoId, 0)=0) then
     vArrayRetornov := ObjVeiculoCtrl.GetVeiculo(0, pVeiculoId, 0, 0)  //Placa
  Else
     vArrayRetornov := ObjVeiculoCtrl.GetVeiculo(StrToInt(pVeiculoId), '', 0, 0);
  if vArrayRetornov.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtVeiculoId.Clear;
     EdtVeiculoId.SetFocus;
     Raise Exception.Create(vErro);
  End
  Else if (vArrayRetornov.Items[0].GetValue<Integer>('status') = 0) and
    ((PgcBase.ActivePage = TabPrincipal) and (not EdtVeiculoId.ReadOnly)) Then Begin
    EdtVeiculoId.Clear;
    EdtVeiculoId.SetFocus;
    Raise Exception.Create('Veículo Inativo');
  End
  Else Begin
    if PgcBase.ActivePage = TabPrincipal then Begin
       LblVeiculo.Caption := '';
       LblCapacidadeVolume.Caption := '';
       ObjCargaCtrl.ObjCargas.Veiculo.VeiculoId      := vArrayRetornov.Items[0].GetValue<Integer>('veiculoid');
       ObjCargaCtrl.ObjCargas.Veiculo.Placa          := vArrayRetornov.Items[0].GetValue<String>('placa');
       ObjCargaCtrl.ObjCargas.Veiculo.TaraKg         := vArrayRetornov.Items[0].GetValue<Double>('tarakg');
       ObjCargaCtrl.ObjCargas.Veiculo.CapacidadeKg   := vArrayRetornov.Items[0].GetValue<Double>('capacidadekg');
       ObjCargaCtrl.ObjCargas.Veiculo.Altura         := vArrayRetornov.Items[0].GetValue<Double>('altura');
       ObjCargaCtrl.ObjCargas.Veiculo.Largura        := vArrayRetornov.Items[0].GetValue<Double>('largura');
       ObjCargaCtrl.ObjCargas.Veiculo.Comprimento    := vArrayRetornov.Items[0].GetValue<Double>('comprimento');
       ObjCargaCtrl.ObjCargas.Veiculo.Aproveitamento := vArrayRetornov.Items[0].GetValue<Double>('aproveitamento');
       ObjCargaCtrl.ObjCargas.Veiculo.SetVolume;
       EdtVeiculoId.Text        := ObjCargaCtrl.ObjCargas.Veiculo.VeiculoId.ToString();
       LblVeiculo.Caption       := ObjCargaCtrl.ObjCargas.Veiculo.Placa+'  '+ObjCargaCtrl.ObjCargas.Veiculo.Marca+' '+ObjCargaCtrl.ObjCargas.Veiculo.Modelo;
       LblPesoVeiculo.Caption   := FormatFloat('######0.000', ObjCargaCtrl.ObjCargas.Veiculo.CapacidadeKg)+' Kg';
       LblVolumeVeiculo.Caption := FloatToStrF(ObjCargaCtrl.ObjCargas.Veiculo.Volume, ffNumber, 18, 3)+' m3';
    End
    Else Begin
       EdtVeiculoIdAC.Text        := vArrayRetornov.Items[0].GetValue<String>('veiculoid');
       LblVeiculoAC.Caption       := vArrayRetornov.Items[0].GetValue<String>('placa');
       LblVeiculoCapacidadeAC.Caption   := FormatFloat('######0.000', vArrayRetornov.Items[0].GetValue<Double>('capacidadekg'))+' Kg';
       LblVeiculoAC.Caption := FloatToStrF((vArrayRetornov.Items[0].GetValue<Double>('tarakg')*
                                            vArrayRetornov.Items[0].GetValue<Double>('largura')*
                                            vArrayRetornov.Items[0].GetValue<Double>('aproveitamento')), ffNumber, 18, 3)+' m3';
    End;
    Result := True;
  End;
  vArrayRetornov := Nil;
  FreeAndNil(ObjVeiculoCtrl);
end;

procedure TFrmCargaMontar.Imprimir;
Var JsonArrayCarga        : TJsonArray;
    JsonArrayCargaPessoas : TJsonArray;
    JsonArrayCargaPedidos : TJsonArray;
    vErro : String;
begin
{  if (Not FdMemPesqGeral.Active) then Exit;
  if FdMempesqGeral.IsEmpty then Begin
     ShowErro('Não há dados para gerar o relatório.');
     Exit;
  End;
}  inherited;

  JsonArrayCarga        := ObjCargaCtrl.GetCargaHeader(StrToIntDef(EdtCargaId.Text, 0), 0);
  If JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(JsonArrayCarga, False);

  JsonArrayCargaPessoas := ObjCargaCtrl.GetCargaPessoasPedido(StrToIntDef(EdtCargaId.Text, 0), 0);
  If JsonArrayCargaPessoas.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
  End;
  If FDMemCargaPessoas.Active then
     FDMemCargaPessoas.EmptyDataSet;
  FDMemCargaPessoas.Close;
  FDMemCargaPessoas.LoadFromJSON(JsonArrayCargaPessoas, False);

{  JsonArrayCargaPedidos := ObjCargaCtrl.GetCargaPedidos(StrToIntDef(EdtCargaId.Text, 0), 0);
  If JsonArrayCargaPedidos.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
  End;
  If FDMemCargaPedidos.Active then
     FDMemCargaPedidos.EmptyDataSet;
  FDMemCargaPedidos.Close;
  FDMemCargaPedidos.LoadFromJSON(JsonArrayCargaPedidos, False);
}  With FrxMapaCarga do Begin
    Variables['vModulo']  := QuotedStr(pChar(Application.Title));
    Variables['vVersao']  := QuotedStr(Versao);
    Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
  End;
  //frxPDFExport1.ShowDialog := False;
  //FrxMapaCarga.PrepareReport();
  FrxMapaCarga.ShowReport;
end;

procedure TFrmCargaMontar.Limpar;
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then Begin
     if Not (EdtCargaId.Enabled) then
        EdtCargaId.Clear;
     EnabledButtons := False;
     EdtDtInicioMontagem.Clear;
     EdtDtTerminoMontagem.Clear;
     EdtRotaId.Clear;
     EdtTransportadoraId.Clear;
     EdtVeiculoId.Clear;
     EdtMotoristaId.Clear;
     LblProcesso.Caption         := '';
     LblTransportadora.Caption   := '';
     LblRota.Caption             := '';
     LblVeiculo.Caption          := '';
     LblCapacidadeVolume.Caption := '';
     LblMotorista.Caption        := '';
     LblPesoVeiculo.Caption      := '0 Kg';
     LblVolumeVeiculo.Caption    := '0 m3';
     TotPedidos.Caption          := '0';
     TotPeso.Caption             := '0 Kg';
     TotVolume.Caption           := '0 m3';
     LblPesoCarga.Caption        := '0 Kg';
     LblVolumeCarga.Caption      := '0 m3';
     LblQtdVolumeCarga.Caption   := '0';
     LstAdvClientesRota.ClearRect(0, 1, LstAdvClientesRota.ColCount-1, LstAdvClientesRota.RowCount-1);
     LstAdvClientesRota.RowCount := 1;
     LstAdvPedidos.ClearRect(0, 1, LstAdvPedidos.ColCount-1, LstAdvPedidos.RowCount-1);
     LstAdvPedidos.RowCount := 1;
     If FdMemPesqGeral.Active then
        FdmemPesqGeral.EmptyDataSet;
     FdMemPesqGeral.Close;
     If Assigned(ObjCargaCtrl) then ObjCargaCtrl.ObjCargas.Limpar;
   //  PnlListaCliPedidos.Enabled := False;
  End
  else if PgcBase.ActivePage = TabCargaAnaliseCubagem Then Begin
    LblCargaAC.Caption             := '';
    EdtRotaIdAC.Clear;
    LblRotaAC.Caption              := '';
    EdtDtCargaAC.Clear;
    EdtTransportadoraIdAC.Clear;
    LblTransportadoraAC.Caption    := '';
    EdtVeiculoIdAC.Text            := '';
    LblVeiculoAC.Caption           := '';
    LblVeiculoCapacidadeAC.Caption := '';
    LblMotoristaAC.Caption         := '';
    LstCargaAnaliseCubagem.FixedCols := 0;
    LstCargaAnaliseCubagem.RowCount  := 1;
    LblTotalRegAC.Caption          := '0';
    LblCubagemTotalAC.caption      := '0';
    If Assigned(ObjCargaCtrl) then
       ObjCargaCtrl.ObjCargas.Limpar;
  End;
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
end;

procedure TFrmCargaMontar.LimparResumoCarga;
begin
  If FdMemResumoCarga.Active then
     FdMemResumoCarga.EmptyDataSet;
  FdMemResumoCarga.Close;
  LstCargaResumo.RowCount := 1;
end;

procedure TFrmCargaMontar.LstAdvClientesRotaClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xCliente, xPed : Integer;
    vCodigoERP : Integer;
begin
  if (aRow = 0) and (aCol<>9) then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  inherited;
  if (LstAdvClientesRota.RowCount <= 1) or (BtnSalvar.Grayed) then Exit;
  if (aCol = 9) then Begin
     if (aRow = 0) and (LstAdvClientesRota.RowCount>1) then Begin
        For xCliente := 1 to Pred(LstAdvClientesRota.RowCount) do Begin
          vCodigoERP := StrToInt(LstAdvClientesRota.Cells[1, xCliente]);
          if SelClienteRota then Begin
             LstAdvClientesRota.Cells[9, xCliente] := '0';
          End
          Else Begin
             LstAdvClientesRota.Cells[9, xCliente] := '1';
          End;
          for xPed := 1 to Pred(LstAdvPedidos.RowCount) do
            if StrToInt(LstAdvPedidos.Cells[3, xPed]) = vCodigoERP then
               LstAdvPedidos.Cells[10, xPed] := LstAdvClientesRota.Cells[9, xCliente];
        End;
        SelClienteRota := Not SelClienteRota;
        CalculaPesoVolume;
     End
     Else Begin
       if StrToIntDef(LstAdvClientesRota.Cells[9, aRow], 0) = 0 then Begin
          LstAdvClientesRota.Cells[9, aRow] := '1';
          SelClienteRota := True;
       End
       Else Begin
         LstAdvClientesRota.Cells[9, aRow] := '0';
         SelClienteRota := False;
       End;
       vCodigoERP := StrToInt(LstAdvClientesRota.Cells[1, aRow]);
       For xPed := 1 to Pred(LstAdvPedidos.RowCount) do
         if StrToInt(LstAdvPedidos.Cells[3, xPed]) = vCodigoERP then
            LstAdvPedidos.Cells[10, xPed] := LstAdvClientesRota.Cells[9, aRow];
       CalculaPesoVolume;
     End;
  End;
end;

procedure TFrmCargaMontar.LstAdvPedidosClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xPed : Integer;
begin
  if (aRow = 0) and (aCol<>10) then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  inherited;
  if (LstAdvPedidos.RowCount <= 1) or (BtnSalvar.Grayed) then Exit;
  if (aCol = 10) then Begin
     if (aRow = 0) and (LstAdvPedidos.RowCount>1) then Begin
        For xPed := 1 to Pred(LstAdvPedidos.RowCount) do
          if SelPedido then Begin
             LstAdvPedidos.Cells[10, xPed] := '0';
          End
          Else LstAdvPedidos.Cells[10, xPed] := '1';
        SelPedido := Not SelPedido;
     End
     Else Begin
       if StrToIntDef(LstAdvPedidos.Cells[10, aRow], 0) = 0 then Begin
          LstAdvPedidos.Cells[10, aRow] := '1';
          SelPedido := True;
       End
       Else Begin
         LstAdvPedidos.Cells[10, aRow] := '0';
         SelPedido := False;
       End;
     End;
     CalculaPesoVolume;
  End;
end;

procedure TFrmCargaMontar.LstCadastroClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var vErro : String;
    JsonCargaCancelar : TJsonObject;
begin
  inherited;
  if (LstCadastro.RowCount <= 1) then Exit;
  if (aCol = 9) then Begin
     if Confirmacao('Cancelar carga', 'Deseja cancelar a caraga('+
                    LstCadastro.Cells[0, aRow]+') ?', True) then Begin
        JsonCargaCancelar := TJsonObject.Create;
        JsonCargaCancelar.AddPair('cargaid', TJsonNumber.Create(StrToIntDef(LstCadastro.Cells[0, aRow],0)));
        JsonCargaCancelar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
        JsonCargaCancelar.AddPair('terminal', NomeDoComputador);
        If ObjCargaCtrl.CancelarCarga(JsonCargaCancelar).TryGetValue('Erro', vErro) then
           ShowErro('Erro:'+vErro)
        Else Begin
           ShowOk('Carga('+LstCadastro.Cells[0, aRow]+') cancelada com sucesso!');
           GetListaLstCadastro;
        End;
        FreeAndNil(JsonCargaCancelar);
     End
  End;
end;

procedure TFrmCargaMontar.LstCadastroDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  inherited;
  EdtCargaId.Text  := LstCargaResumo.Cells[0, aRow];
  EdtCargaIdExit(EdtCargaId);
  PgcBase.ActivePage := TabPrincipal;
  EdtCargaId.SetFocus;
end;

procedure TFrmCargaMontar.LstCargaAnaliseCubagemClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  If aRow = 0 then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  Try TAdvStringGrid(Sender).Row := aRow; Except End;
end;

procedure TFrmCargaMontar.LstCargaResumoClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xRota, xTotRotas : Integer;
begin
  If aRow = 0 then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
     Exit;
  End;
  inherited;
  Try TAdvStringGrid(Sender).Row := aRow; Except End;
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;
  if (aCol = 10) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        For xRota := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if (TAdvStringGrid(Sender).Cells[11, xRota] = '0') and
             (LstCargaResumo.Cells[12, xRota].ToInteger in [17,18]) then Begin
             if SelTransito then Begin
                TAdvStringGrid(Sender).Cells[10, xRota] := '0';
             End
             Else Begin
                TAdvStringGrid(Sender).Cells[10, xRota] := '1';
             End;
          End;
        End;
        SelTransito := Not SelTransito;
        AtualizarStatus(0, 18);
     End
     Else If (TAdvStringGrid(Sender).Cells[11, aRow] = '0') then Begin
       if (StrToIntDef(TAdvStringGrid(Sender).Cells[10, aRow], 0) = 0) and
          (LstCargaResumo.Cells[12, aRow].ToInteger in [17,18]) then
          TAdvStringGrid(Sender).Cells[10, aRow] := '1'
       Else
         TAdvStringGrid(Sender).Cells[10, aRow] := '0';
       AtualizarStatus(aRow, 18);
     End;
  End
  Else if (aCol = 11) and (TAdvStringGrid(Sender).Ints[10, aRow] = 1) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        For xRota := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          //if (LstCargaResumo.Cells[10, xRota].ToInteger = 1) then Begin
             if (SelEntrega) then Begin
                TAdvStringGrid(Sender).Cells[11, xRota] := '0';
             End
             Else Begin
                TAdvStringGrid(Sender).Cells[11, xRota] := '1';
             End;
          //End;
        End;
        SelEntrega := Not SelEntrega;
        AtualizarStatus(0, 20);
     End
     Else begin //If (TAdvStringGrid(Sender).Cells[10, aRow] = '1') then Begin
       if StrToIntDef(TAdvStringGrid(Sender).Cells[11, aRow], 0) = 0 then
          TAdvStringGrid(Sender).Cells[11, aRow] := '1'
       Else
         TAdvStringGrid(Sender).Cells[11, aRow] := '0';
       AtualizarStatus(aRow, 20);
     End;
  End;
End;

procedure TFrmCargaMontar.MontaListaAnaliseCubagemPorProduto;
Var xCarga   : Integer;
    xCubagem : Double;
begin
  LstCargaAnaliseCubagem.RowCount := FdMemCargaAnaliseCubagem.RecordCount+1;
  If FdMemCargaAnaliseCubagem.IsEmpty() Then Begin
     LstCargaAnaliseCubagem.FixedRows := 0;
     LstCargaAnaliseCubagem.RowCount  := 1;
  End
  Else Begin
     LstCargaAnaliseCubagem.FixedRows := 1;
     ImprimirExportar(True);
  End;
  FdMemCargaAnaliseCubagem.First;
  LblTotalRegAC.Caption := FdMemCargaAnaliseCubagem.RecordCount.ToString();
  xCarga   := 1;
  xCubagem := 0;
  While Not FdMemCargaAnaliseCubagem.Eof do Begin
    LstCargaAnaliseCubagem.Cells[0, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('PedidoId').AsString;
    LstCargaAnaliseCubagem.Cells[1, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('PedidoVolumeId').AsString;
    LstCargaAnaliseCubagem.Cells[2, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('Embalagem').AsString;
    LstCargaAnaliseCubagem.Cells[3, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('CodProduto').AsString;
    LstCargaAnaliseCubagem.Cells[4, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('Descricao').AsString;
    LstCargaAnaliseCubagem.Cells[5, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('QtdSuprida').AsString;
    LstCargaAnaliseCubagem.Cells[6, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('Altura').AsString;
    LstCargaAnaliseCubagem.Cells[7, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('Largura').AsString;
    LstCargaAnaliseCubagem.Cells[8, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('Comprimento').AsString;
    LstCargaAnaliseCubagem.Cells[9, xCarga]  := FdMemCargaAnaliseCubagem.FieldByName('Volume').AsString;
    LstCargaAnaliseCubagem.Cells[10, xCarga] := FdMemCargaAnaliseCubagem.FieldByName('VolumeTotal').AsString;
    LstCargaAnaliseCubagem.Cells[11, xCarga] := FdMemCargaAnaliseCubagem.FieldByName('PesoTotal').AsString;
    xCubagem := xCubagem + FdMemCargaAnaliseCubagem.FieldByName('VolumeTotal').AsFloat;
    LstCargaAnaliseCubagem.Alignments[0, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.FontStyles[0, xCarga]  := [FsBold];
    LstCargaAnaliseCubagem.Alignments[1, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[3, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[5, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[6, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[7, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[8, xCarga]  := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[9, xCarga] := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[10, xCarga] := taRightJustify;
    LstCargaAnaliseCubagem.Alignments[11, xCarga] := taRightJustify;
    LstCargaAnaliseCubagem.FontStyles[10, xCarga]  := [FsBold];
    LstCargaAnaliseCubagem.FontStyles[11, xCarga]  := [FsBold];
    Inc(xCarga);
    FdMemCargaAnaliseCubagem.Next;
  End;
  LblCubagemTotalAC.Caption := FormatFloat('0.000000', xCubagem);
end;

procedure TFrmCargaMontar.MontaListacarga(pJsonArrayRetorno: TJsonArray);
Var xCarga : Integer;
begin
  LstCadastro.RowCount := pjsonArrayRetorno.Count+1;
  If LstCadastro.RowCount > 1 Then LstCadastro.FixedRows := 1;
  for xCarga := 1 to pJsonArrayRetorno.Count do
    LstCadastro.AddDataImage( 9, xCarga, 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
  for xCarga := 0 to Pred(pJsonArrayRetorno.Count) do Begin
    LstCadastro.Cells[0, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('cargaid');
    LstCadastro.Cells[1, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('data');
    LstCadastro.Cells[2, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('rota');
    LstCadastro.Cells[3, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('transportadora');
    LstCadastro.Cells[4, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('placa');
    if (pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('processoid') = 16) and
       (pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('statusoper') > 0) then Begin
       if (pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('statusoper') = 1) then Begin
          if (pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('totalvolume') > pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('volumecarregado')) then
             LstCadastro.Cells[5, xCarga+1] := 'Carga - Em Conferência'
          Else
             LstCadastro.Cells[5, xCarga+1] := 'Carga - Conferida';
       End
       Else if (pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('statusoper') = 2) then Begin
          if (pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('totalvolume') > pJsonArrayRetorno.Items[xCarga].GetValue<Integer>('volumecarregado')) then
             LstCadastro.Cells[5, xCarga+1] := 'Carga - Carregando'
          Else
             LstCadastro.Cells[5, xCarga+1] := 'Carga - Carregada';
      End;
    End
    Else
       LstCadastro.Cells[5, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('processo');
    LstCadastro.Cells[6, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('totalvolume');
    LstCadastro.Cells[7, xCarga+1] := pJsonArrayRetorno.Items[xCarga].GetValue<String>('volumecarregado');
    LstCadastro.Cells[8, xCarga+1] := FormatFloat('0.00', pJsonArrayRetorno.Items[xCarga].GetValue<Double>('perccarregado'));

    LstCadastro.Cells[9, xCarga+1] := '2';
    LstCadastro.Alignments[0, xCarga+1] := taRightJustify;
    LstCadastro.FontStyles[0, xCarga+1] := [FsBold];
    LstCadastro.Alignments[1, xCarga+1] := taCenter;
    LstCadastro.Alignments[2, xCarga+1] := taLeftJustify;
    LstCadastro.Alignments[3, xCarga+1] := taLeftJustify;
    LstCadastro.Alignments[4, xCarga+1] := taLeftJustify;
    LstCadastro.Alignments[6, xCarga+1] := taRightJustify;
    LstCadastro.Alignments[7, xCarga+1] := taRightJustify;
    LstCadastro.Alignments[8, xCarga+1] := taRightJustify;
    LstCadastro.Alignments[9, xCarga+1] := taCenter;
  End;
end;

procedure TFrmCargaMontar.MontaListaClientesRotaCarga(pJsonArray: TJsonArray);
Var xCli : Integer;
begin
  LstAdvClientesRota.RowCount := pjsonArray.Count+1;
  LstAdvClientesRota.FixedRows := 1;
  for xCli := 0 to Pred(pJsonArray.Count) do
    LstAdvClientesRota.AddDataImage(9, xCli+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  for xCli := 0 to Pred(pJsonArray.Count) do Begin
    LstAdvClientesRota.Cells[0, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('pessoaid');
    LstAdvClientesRota.Cells[1, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('codpessoaerp');
    LstAdvClientesRota.Cells[2, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('fantasia');
    LstAdvClientesRota.Cells[3, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('ordem');
    LstAdvClientesRota.Cells[4, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('totped');
    LstAdvClientesRota.Cells[5, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('tvolcxafechada');
    LstAdvClientesRota.Cells[6, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('tvolfracionado');
    LstAdvClientesRota.Cells[7, xCli+1] := pJsonArray.Get(xCli).GetValue<String>('peso');
    LstAdvClientesRota.Cells[8, xCli+1] := FormatFloat('0,000000', pJsonArray.Get(xCli).GetValue<Double>('volm3'));
    LstAdvClientesRota.Cells[9, xCli+1] := '0';
    LstAdvClientesRota.Alignments[0, xCli+1] := taRightJustify;
    LstAdvClientesRota.FontStyles[0, xCli+1] := [fsBold];
    LstAdvClientesRota.Alignments[1, xCli+1] := taRightJustify;
    LstAdvClientesRota.FontStyles[3, xCli+1] := [fsBold];
    LstAdvClientesRota.Alignments[3, xCli+1] := taRightJustify;
    LstAdvClientesRota.Alignments[4, xCli+1] := taRightJustify;
    LstAdvClientesRota.Alignments[5, xCli+1] := taRightJustify;
    LstAdvClientesRota.Alignments[6, xCli+1] := taRightJustify;
    LstAdvClientesRota.Alignments[7, xCli+1] := taRightJustify;
    LstAdvClientesRota.Alignments[8, xCli+1] := taRightJustify;
    LstAdvClientesRota.Alignments[9, xCli+1] := taCenter;
  End;
  LstAdvClientesRota.SortSettings.Column := 1;
  LstAdvClientesRota.QSort;
end;

procedure TFrmCargaMontar.MontaListaPedido(pJsonArray: TJsonArray);
Var xPed : Integer;
begin
  LstCadastro.RowCount := pjsonArray.Count+1;
  LstCadastro.FixedRows := 1;
  for xPed := 0 to Pred(pJsonArray.Count) do Begin
    LstCadastro.Cells[0, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('pedidoid');
    LstCadastro.Cells[1, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('documentodata');
    LstCadastro.Cells[2, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('operacao');
    LstCadastro.Cells[3, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('codpessoaerp');
    LstCadastro.Cells[4, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('razao');
    if pJsonArray.Get(xPed).GetValue<Integer>('rotaid') = 0 then Begin
       LstCadastro.Colors[3, xPed+1] := ClRed;
       LstCadastro.Colors[4, xPed+1] := ClRed;
    End
    Else begin
       LstCadastro.Colors[3, xPed+1] := LstCadastro.Colors[2, xPed+1];
       LstCadastro.Colors[4, xPed+1] := LstCadastro.Colors[2, xPed+1];
    end;
    LstCadastro.Cells[5, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('etapa');
    if pJsonArray.Get(xPed).GetValue<Integer>('processoid') = 8 then
       LstCadastro.Colors[5, xPed+1] := $00B0FFFF
    Else if pJsonArray.Get(xPed).GetValue<Integer>('processoid') in [10, 12] then
       LstCadastro.Colors[5, xPed+1] := $006FB7FF
    Else If pJsonArray.Get(xPed).GetValue<Integer>('processoid') in [13, 14] then
       LstCadastro.Colors[5, xPed+1] := $00006C00
    Else If pJsonArray.Get(xPed).GetValue<Integer>('processoid') = 15 then
       LstCadastro.Colors[5, xPed+1] := ClRed
    Else
       LstCadastro.Colors[5, xPed+1] := LstCadastro.Colors[2, xPed+1];
    LstCadastro.Cells[6, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('itens');
    LstCadastro.Cells[7, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('demanda');
    LstCadastro.Cells[8, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('qtdsuprida');
    if pJsonArray.Get(xPed).GetValue<String>('qtdsuprida') < pJsonArray.Get(xPed).GetValue<String>('demanda') then
       LstCadastro.Colors[8, xPed+1] := ClYellow
    Else LstCadastro.Colors[8, xPed+1] := ClGreen; //LstCadastro.Colors[8, xPed+1];
    LstCadastro.Cells[9, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('tvolumes');
    LstCadastro.Cells[10, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('tvolcxafechada');
    LstCadastro.Cells[11, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('tvolfracionado');
    LstCadastro.Cells[12, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('cancelado');
    LstCadastro.Cells[13, xPed+1]    := FormatFloat('#####0.000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('peso'),'.',',',[rfReplaceAll])));
//    LstCadastro.Cells[15, xPed+1]    := FormatFloat('#####0.000000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('volcm3'),'.',',',[rfReplaceAll])));
    LstCadastro.Cells[14, xPed+1]    := FormatFloat('#####0.000000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('volm3'),'.',',',[rfReplaceAll])));
    LstCadastro.Cells[15, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('documentonr');
    LstCadastro.Cells[16, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('registroerp');
    LstCadastro.Cells[17, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('rotaid');
    LstCadastro.Cells[18, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('rota');
    LstCadastro.Cells[19, xPed+1]    := pJsonArray.Get(xPed).GetValue<String>('uuid');
    LstCadastro.Alignments[0, xPed+1] := taRightJustify;
    LstCadastro.FontStyles[0, xPed+1] := [FsBold];
    LstCadastro.Alignments[1, xPed+1] := taCenter;
    LstCadastro.Alignments[6, xPed+1] := taRightJustify;
    LstCadastro.Alignments[7, xPed+1] := taRightJustify;
    LstCadastro.Alignments[8, xPed+1] := taRightJustify;
    LstCadastro.Alignments[9, xPed+1] := taRightJustify;
    LstCadastro.Alignments[10, xPed+1] := taRightJustify;
    LstCadastro.Alignments[11, xPed+1] := taRightJustify;
    LstCadastro.Alignments[12, xPed+1] := taRightJustify;
    LstCadastro.Alignments[13, xPed+1] := taRightJustify;
    LstCadastro.Alignments[14, xPed+1] := taRightJustify;
    LstCadastro.Alignments[17, xPed+1] := taRightJustify;
  End;
end;

procedure TFrmCargaMontar.MontaPedidoCarga(pJsonArray: TJsonArray);
Var xPed : Integer;
begin
  LstAdvPedidos.RowCount := pjsonArray.Count+1;
  LstAdvPedidos.FixedRows := 1;
  for xPed := 0 to Pred(pJsonArray.Count) do
    LstAdvPedidos.AddDataImage(10, xPed+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  for xPed := 0 to Pred(pJsonArray.Count) do Begin
    LstAdvPedidos.Cells[0, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('pedidoid');
    LstAdvPedidos.Cells[1, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('documentodata');
    LstAdvPedidos.Cells[2, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('documentooriginal');
    LstAdvPedidos.Cells[3, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('codpessoaerp');
    LstAdvPedidos.Cells[4, xPed+1] := pJsonArray.Get(xPed).GetValue<String>('fantasia');
    if pJsonArray.Get(xPed).GetValue<Integer>('rotaid') = 0 then Begin
       LstAdvPedidos.Colors[3, xPed+1] := ClRed;
       LstAdvPedidos.Colors[4, xPed+1] := ClRed;
    End
    Else begin
       LstAdvPedidos.Colors[3, xPed+1] := LstCadastro.Colors[2, xPed+1];
       LstAdvPedidos.Colors[4, xPed+1] := LstCadastro.Colors[2, xPed+1];
    end;
    LstAdvPedidos.Cells[ 5, xPed+1]      := pJsonArray.Get(xPed).GetValue<String>('tvolumes');
    LstAdvPedidos.Cells[ 6, xPed+1]      := pJsonArray.Get(xPed).GetValue<String>('tvolcxafechada');
    LstAdvPedidos.Cells[ 7, xPed+1]      := pJsonArray.Get(xPed).GetValue<String>('tvolfracionado');
    LstAdvPedidos.Cells[ 8, xPed+1]      := FormatFloat('#####0.000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('peso'),'.',',',[rfReplaceAll])));
    LstAdvPedidos.Cells[ 9, xPed+1]      := FormatFloat('#####0.000000', StrToFloat(StringReplace(pJsonArray.Get(xPed).GetValue<String>('volm3'),'.',',',[rfReplaceAll])));
    if (pJsonArray.Get(xPed).GetValue<Integer>('cargaid') > 0) and (pJsonArray.Get(xPed).GetValue<Integer>('cargaid') = StrToIntDef(EdtCargaId.Text, 0)) then
           LstAdvPedidos.Cells[10, xPed+1] := '1'
    Else LstAdvPedidos.Cells[10, xPed+1]   := '0';
    LstAdvPedidos.Alignments[0, xPed+1]  := taRightJustify;
    LstAdvPedidos.FontStyles[0, xPed+1]  := [FsBold];
    LstAdvPedidos.Alignments[1, xPed+1]  := taCenter;
    LstAdvPedidos.Alignments[2, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[3, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[5, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[6, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[7, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[8, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[9, xPed+1]  := taRightJustify;
    LstAdvPedidos.Alignments[10, xPed+1] := taCenter;
  End;
  CalculaPesoVolume;
  LstAdvPedidos.SortSettings.Column := 3;
  LstAdvPedidos.QSort;
end;

procedure TFrmCargaMontar.MontaResumoCarga;
Var xRecno : Integer;
begin
  LstCargaResumo.RowCount  := FdMemResumoCarga.RecordCount+1;
  LstCargaResumo.FixedRows := 1;
  LblTotRegistro.Caption   := FdMemResumoCarga.RecordCount.ToString();
  for xRecno := 1 to Pred(LstCargaResumo.RowCount) do Begin
    LstCargaResumo.AddDataImage(10, xRecno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstCargaResumo.AddDataImage(11, xRecno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  xRecno := 1;
  FDMemResumoCarga.First;
  while Not FDMemResumoCarga.Eof do Begin
    LstCargaResumo.Cells[ 0, xRecno] := FDMemResumoCarga.FieldByName('CargaId').AsString;
    LstCargaResumo.Cells[ 1, xRecno] := FDMemResumoCarga.FieldByName('data').AsString;
    LstCargaResumo.Cells[ 2, xRecno] := FDMemResumoCarga.FieldByName('Processo').AsString;
    LstCargaResumo.Cells[ 3, xRecno] := FDMemResumoCarga.FieldByName('Transportadora').AsString;
    LstCargaResumo.Cells[ 4, xRecno] := FDMemResumoCarga.FieldByName('Motorista').AsString;
    LstCargaResumo.Cells[ 5, xRecno] := Copy(FDMemResumoCarga.FieldByName('Placa').AsString, 1, 3)+'-'+
                                        Copy(FDMemResumoCarga.FieldByName('Placa').AsString, 4, 4);
    LstCargaResumo.Cells[ 6, xRecno] := FDMemResumoCarga.FieldByName('QtdPedido').AsString;
    LstCargaResumo.Cells[ 7, xRecno] := FDMemResumoCarga.FieldByName('QtdVolume').AsString;
    LstCargaResumo.Cells[ 8, xRecno] := FDMemResumoCarga.FieldByName('QtdVolumeCarregado').AsString;
    LstCargaResumo.Cells[ 9, xRecno] := FDMemResumoCarga.FieldByName('RotaId').AsString;
    If (FDMemResumoCarga.FieldByName('ProcessoId').AsInteger < 18)  or (FDMemResumoCarga.FieldByName('ProcessoId').AsInteger = 21) then
       LstCargaResumo.Cells[10, xRecno] := '0'
    Else LstCargaResumo.Cells[10, xRecno] := '1';
    If (FDMemResumoCarga.FieldByName('ProcessoId').AsInteger < 20) or (FDMemResumoCarga.FieldByName('ProcessoId').AsInteger = 21) then
       LstCargaResumo.Cells[11, xRecno] := '0'
    Else
       LstCargaResumo.Cells[11, xRecno] := '1';
    LstCargaResumo.Cells[12, xRecno] := FDMemResumoCarga.FieldByName('ProcessoId').AsString;
    LstCargaResumo.Alignments[ 0, xRecno] := taRightJustify;
    LstCargaResumo.FontStyles[ 0, xRecno] := [FsBold];
    LstCargaResumo.Alignments[ 1, xRecno] := taCenter;
    LstCargaResumo.Alignments[ 6, xRecno] := taRightJustify;
    LstCargaResumo.Alignments[ 7, xRecno] := taRightJustify;
    LstCargaResumo.Alignments[ 8, xRecno] := taRightJustify;
    LstCargaResumo.Alignments[ 9, xRecno] := taRightJustify;
    LstCargaResumo.Alignments[10, xRecno] := taCenter;
    LstCargaResumo.Alignments[11, xRecno] := taCenter;
    FDMemResumoCarga.Next;
    Inc(xRecno);
  End;
end;

procedure TFrmCargaMontar.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtCargaId.Text  := LstCadastro.Cells[aCol, aRow];
  EdtCargaIdExit(EdtCargaId);
  PgcBase.ActivePage := TabPrincipal;
  EdtCargaId.SetFocus;
end;

function TFrmCargaMontar.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String) : Boolean;
Var JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
    vErro            : String;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Begin
        Try
          StrToDate(EdtConteudoPesq.Text);
          JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(0, 0, 0, StrToDate(EdtConteudoPesq.Text), StrToDate(EdtConteudoPesq.Text),
                                                   '', '', '', 0, 0, 0, 13, 1, 1, 1, False, 1, 0, 0, 0, '', 2, 2);
        Except
          raise Exception.Create('Data inválida para pesquisa!');
        End;
     End
     Else if CbCampoPesq.ItemIndex = 1 then Begin//0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(0, 0, StrToInt(EdtConteudoPesq.Text), 0, 0,
                                                    '', '', '', 0, 0, 0,13, 1, 1, 1, False, 1, 0, 0, 0, '', 2, 2)
        Else raise Exception.Create('Id Loja inválido para pesquisa!');
     End
     Else if CbCampoPesq.ItemIndex = 2 then Begin//0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
          JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(0, StrToInt(EdtConteudoPesq.Text), 0, 0, 0,
                                                    '', '', '', 0, 0, 0, 13, 1, 1, 1, False, 1, 0, 0, 0, '', 2, 2)
        Else raise Exception.Create('Código ERP inválido para pesquisa!');
     End
     Else if CbCampoPesq.ItemIndex = 3 then //0 Id 1-Criar no server consulta por Cod.ERP
        JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(0, 0, 0 , 0, 0,
                                                   '', EdtConteudoPesq.Text, '', 0, 0, 0, 13, 1, 1, 1, False, 1, 0, 0, 0, '', 2, 2)
     Else if CbCampoPesq.ItemIndex = 4 then Begin //0 Id 1-Criar no server consulta por Cod.ERP
        JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(0, 0, 0 , 0, 0,
                                                   '', EdtConteudoPesq.Text, '', StrToIntDef(EdtConteudoPesq.Text, 0), 0, 0, 13, 1, 1, 1, False, 1, 0, 0, 0, '', 2, 2);
     End;
     Result := JsonArrayRetorno.Count > 0;
     if Result then Begin
        if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
           ShowErro('😢Erro: '+vErro);
           Player('toast4');
           LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
           LstCadastro.RowCount := 1;
        End
        else
          MontaListaPedido(JsonArrayRetorno);
     End;
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmCargaMontar.PesquisarResumoCarga;
Var JsonArrayRetorno : TJsonArray;
//    ObjCargaCtrl : TCargasCtrl;
    vErro        : String;
    vProcessoId  : Integer;
    vDataInicial : TDateTime;
    vDataFinal   : TDateTime;
    vPendente    : Integer;
begin
  LstCargaResumo.RowCount := 1;
  case RgCargaProcesso.ItemIndex of
    0: vProcessoId := 16;
    1: vProcessoId := 17;
    2: vProcessoId := 18;
    3: vProcessoId := 19;
    4: vProcessoId := 20;
    5: vProcessoId := 21;
    6: vProcessoId := 0;
    7: vProcessoId :=  0;
  end;
  if RgCargaProcesso.ItemIndex = 6 then
     vPendente := 1;
  if EdtdtCargaInicial.Text <> '  /  /    ' then
     vDataInicial := StrToDate(EdtDtCargaInicial.Text)
  Else vDataInicial := 0;
  if EdtdtCargaFinal.Text <> '  /  /    ' then
     vDataFinal := StrToDate(EdtDtCargaFinal.Text)
  Else vDataFinal := 0;
  if (EdtdtCargaInicial.Text <> '  /  /    ') AND (EdtdtCargaFinal.Text <> '  /  /    ') Then Begin
     if (StrToDate(EdtdtCargaFinal.Text) < StrToDate(EdtdtCargaInicial.Text)) then Begin
        EdtDtCargaFinal.SetFocus;
        ShowErro('DataFinal inválida!');
        Exit;
     End;
  End;
  //ObjCargaCtrl := TCargasCtrl.Create;
  JsonArrayRetorno := ObjCargaCtrl.ResumoCarga(vDataInicial, vDataFinal,
                      StrToIntDef(EdtRotaIdInicial.Text, 0), StrToIntDef(EdtRotaIdFinal.Text, 0),
                      vProcessoId, vPendente);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     RgCargaProcesso.SetFocus;
  End
  Else Begin
    If FdMemResumoCarga.Active then
       FdMemResumoCarga.EmptyDataSet;
    FdMemResumoCarga.Close;
    FdMemResumoCarga.loadFromJson(JsonArrayRetorno, False);
    MontaResumoCarga;
  End;
  JsonArrayRetorno := Nil;
  //ObjCargaCtrl.Free;
end;

procedure TFrmCargaMontar.RgCargaProcessoClick(Sender: TObject);
begin
  inherited;
  LimparResumoCarga;
end;

function TFrmCargaMontar.SalvarReg: Boolean;
Var xPed, xPedSel : Integer;
    JsonCarga, JsonPedidos, JsonRetorno : TJsonObject;
    JsonListaPedidos : TJsonArray;
    vErro : String;
begin
  Result := False;
  If StrToIntDef(EdtRotaId.Text, 0) <= 0 Then Begin
     ShowErro('Informe a rota para Carga!');
     EdtRotaId.SetFocus;
     Exit;
  End;
  If ObjCargaCtrl.ObjCargas.Transportadora.PessoaId <= 0 Then Begin
     ShowErro('Informe a transportadora!');
     EdtTransportadoraId.SetFocus;
     Exit;
  End;
  ObjCargaCtrl.ObjCargas.CargaId   := StrToIntDef(EdtCargaId.Text, 0);
  ObjCargaCtrl.ObjCargas.Rotaid    := StrToIntDef(EdtRotaId.Text, 0);
  ObjCargaCtrl.ObjCargas.Usuarioid := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  ObjCargaCtrl.ObjCargas.Status    := 1;//Ord(ChkCadastro.Checked);
  JsonCarga := TJsonObject.Create;
  JsonCarga.AddPair('cargaid',          TJSONNumber.Create(ObjCargaCtrl.ObjCargas.cargaid));
  JsonCarga.AddPair('rotaid',           TJSONNumber.Create(ObjCargaCtrl.ObjCargas.RotaId));
  JsonCarga.AddPair('transportadoraid', TJSONNumber.Create(ObjCargaCtrl.ObjCargas.Transportadora.PessoaId));
  JsonCarga.AddPair('veiculoid', TJSONNumber.Create(ObjCargaCtrl.ObjCargas.Veiculo.VeiculoId));
  JsonCarga.AddPair('motoristaid', TJSONNumber.Create(ObjCargaCtrl.ObjCargas.Motorista.PessoaId));
  JsonCarga.AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonCarga.AddPair('status', TJSONNumber.Create(1));


//  JsonCarga := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ObjCargaCtrl.ObjCargas.ClassToJson(ObjCargaCtrl.ObjCargas)),0) as TJSONObject;

  JsonCarga.AddPair('terminal', NomeDoComputador);
  JsonListaPedidos := TJsonArray.Create();
  for xPed := 1 to Pred(LstAdvPedidos.RowCount) do Begin
    if LstAdvPedidos.Cells[10, xPed] = '1' then Begin
       JsonPedidos:= TJsonObject.Create();
       JsonPedidos.AddPair('pedidoid', TJSONNumber.Create(LstAdvPedidos.Cells[0, xPed].ToInteger()));
       JsonListaPedidos.AddElement(JsonPedidos);
    End;
  End;
  if JsonListaPedidos.Count < 1 then Begin
     ShowErro('Selecione os Pedidos para a montagem da carga.');
     JsonListaPedidos := Nil;
     Exit;
  End;
  JsonCarga.AddPair('pedidos', JsonListaPedidos);
  JsonRetorno := ObjCargaCtrl.Salvar(JsonCarga);
  If Not JsonRetorno.TryGetValue('Erro', vErro) then
    Result := True;
  if Result then Begin
     ObjCargaCtrl.ObjCargas.CargaId := 0;
     if EdtCargaId.Text = '' then
        Confirmacao('Novo Mapa de Carga', 'Carga Id: '+JsonRetorno.GetValue<Integer>('cargaid').ToString(), False);
  End;
  JsonListaPedidos := Nil;
  FreeAndNil(JsonCarga);
  BtnFiltro.Visible := False;
  //FreeAndNil(JsonListaPedidos);
end;

procedure TFrmCargaMontar.SelecionarClientePedidos(pRetornoArray: TJsonArray);
Var xCliPed, xLista : Integer;
begin
  for xCliPed := 0 to Pred(pRetornoArray.Count) do Begin
    for xLista := 1 to Pred(LstAdvClientesRota.RowCount) do Begin
      if LstAdvClientesRota.Cells[0, xLista] = pRetornoArray.Items[xCliPed].GetValue<String>('pessoaid') then
         LstAdvClientesRota.Cells[9, xLista] := '1';
    End;
    for xLista := 1 to Pred(LstAdvPedidos.RowCount) do Begin
      if LstAdvPedidos.Cells[0, xLista] = pRetornoArray.Items[xCliPed].GetValue<String>('pedidoid') then
         LstAdvPedidos.Cells[10, xLista] := '1';
    End;
  End;
end;

procedure TFrmCargaMontar.ShowDados;
Var ObjProcessoCtrl  : TProcessoCtrl;
    JsonArrayRetornoProcesso : TJsonArray;
    vErro : String;
begin
  inherited;
  Try
  EdtRotaId.Text           := ObjCargaCtrl.ObjCargas.RotaId.ToString();
  GetRota(ObjCargaCtrl.ObjCargas.RotaId);
  EdtTransportadoraId.Text := ObjCargaCtrl.ObjCargas.Transportadora.PessoaId.ToString();
  EdtVeiculoId.Text        := ObjCargaCtrl.ObjCargas.Veiculo.VeiculoId.ToString();
  EdtMotoristaId.Text      := ObjCargaCtrl.ObjCargas.Motorista.PessoaId.ToString();
  BtnImprimirStand.Grayed  := False;
  BtnImprimirStand.Enabled := True;
  ObjProcessoCtrl     := TProcessoCtrl.Create;
  LblProcesso.Caption := ObjCargaCtrl.ObjCargas.ProcessoId.ToString();
  if (ObjCargaCtrl.ObjCargas.ProcessoId=16) and (ObjCargaCtrl.ObjCargas.StatusOper = 1) and (ObjCargaCtrl.ObjCargas.Conferencia = 0) then
     LblProcesso.Caption := ObjCargaCtrl.ObjCargas.ProcessoId.ToString()+' '+'Carga - Em Conferência'
  Else if (ObjCargaCtrl.ObjCargas.ProcessoId=16) and (ObjCargaCtrl.ObjCargas.StatusOper = 1) and (ObjCargaCtrl.ObjCargas.Conferencia = 1) then
     LblProcesso.Caption := ObjCargaCtrl.ObjCargas.ProcessoId.ToString()+' '+'Carga - Conferida'
  Else if (ObjCargaCtrl.ObjCargas.Carregando=2) then
     LblProcesso.Caption := ObjCargaCtrl.ObjCargas.ProcessoId.ToString()+' '+'Carga - Montando Carga'
  Else begin
     JsonArrayRetornoProcesso := ObjProcessoCtrl.GetProcesso(ObjCargaCtrl.ObjCargas.ProcessoId.ToString(), 0);
     if Not JsonArrayRetornoProcesso.items[0].TryGetValue('Erro', vErro) then
        LblProcesso.Caption := ObjCargaCtrl.ObjCargas.ProcessoId.ToString()+' '+JsonArrayRetornoProcesso.Items[0].GetValue<String>('descricao');
     FreeAndNil(ObjProcessoCtrl);
  end;
  Except On E: Exception do
     ShowMessage('Erro: '+E.Message);
  End;
end;

procedure TFrmCargaMontar.TabCargaAnaliseCubagemShow(Sender: TObject);
begin
  inherited;
  EdtCargaIdAC.SetFocus;
end;

procedure TFrmCargaMontar.TabListagemShow(Sender: TObject);
begin
  inherited;
  //GetPedidosExpedido;
end;

end.
