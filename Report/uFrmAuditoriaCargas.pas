unit uFrmAuditoriaCargas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, Vcl.DialogMessage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, DataSet.Serialize,
  JvExMask, JvSpin, JvToolEdit, JvBaseEdits,System.JSON, REST.Json, Rest.Types, Generics.Collections;

type
  TFrmAuditoriaCargas = class(TFrmReportBase)
    Label30: TLabel;
    EdtCargaIdAC: TJvCalcEdit;
    BitBtn4: TBitBtn;
    LblCargaAC: TLabel;
    Label32: TLabel;
    EdtRotaIdAC: TJvCalcEdit;
    LblRotaAC: TLabel;
    Label33: TLabel;
    EdtDtCargaAC: TJvDateEdit;
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
    LblCubagemAC: TLabel;
    LblCubagemTotalAC: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure EdtCargaIdACExit(Sender: TObject);
    procedure EdtCargaIdACChange(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Function GetTransportadora(pTransportadoraId : Integer) : Boolean;
    Function GetVeiculo(pVeiculoId : String) : Boolean;
    Function GetMotorista(pMotoristaId   : Integer) : Boolean;
    Procedure MontaListaAnaliseCubagemPorProduto;
    Function GetCargaAnaliseCubagemPorProduto : Boolean;
  Protected
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmAuditoriaCargas: TFrmAuditoriaCargas;

implementation

{$R *.dfm}

Uses Views.Pequisa.Cargas, CargasCtrl, PessoaCtrl, VeiculoCtrl, uFuncoes;

procedure TFrmAuditoriaCargas.BitBtn4Click(Sender: TObject);
begin
  inherited;
  if EdtCargaIdAC.ReadOnly then Exit;
  inherited;
  FrmPesquisaCargas := TFrmPesquisaCargas.Create(Application);
  try
    if (FrmPesquisaCargas.ShowModal = mrOk) then Begin
       EdtCargaIdAC.Text := FrmPesquisaCargas.Tag.ToString();
       EdtCargaIdACExit(EdtCargaIdAC);
    End;
  finally
    FreeAndNil(FrmPesquisaCargas);
  end;
end;

procedure TFrmAuditoriaCargas.BtnExportarStandClick(Sender: TObject);
begin
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.IsEmpty) then
     raise Exception.Create('Não há dados para exportar!');
  if (BtnExportarStand.Grayed) or (FdMemPesqGeral.IsEmpty) then Exit;
  Try
    ExportarExcel(FdMemPesqGeral, 'CargaAnaliseCubagemXls');
  Except
    raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
  End;
//inherited;
end;

procedure TFrmAuditoriaCargas.EdtCargaIdACChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmAuditoriaCargas.EdtCargaIdACExit(Sender: TObject);
Var JsonArrayRetornoAC, JsonArrayRetornoCub : TJsonArray;
    vTransportadoraId, vVeiculoId, vMotoristaId : Integer;
    vErro, vDtInclusao : String;
    ObjCargaCtrl : TCargasCtrl;
begin
  inherited;
  if (Not EdtCargaIdAC.ReadOnly) and (EdtCargaIdAC.Text<>'') then Begin
     //Limpar;
     if StrToIntDef(EdtCargaIdAC.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtCargaIdAC.Text+') inválido!');
     Try
       ObjCargaCtrl := TCargasCtrl.Create;
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
       JsonArrayRetornoCub := Nil;
       JsonArrayRetornoAC  := Nil;
     Finally
       FreeAndNil(ObjCargaCtrl);
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmAuditoriaCargas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmAuditoriaCargas := Nil;
end;

procedure TFrmAuditoriaCargas.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[ 0] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 1] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 2] := 110+Trunc(110*ResponsivoVideo);
  LstReport.ColWidths[ 3] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[ 4] := 320+Trunc(320*ResponsivoVideo);
  LstReport.ColWidths[ 5] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 6] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[ 7] :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[ 8] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[ 9] :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[10] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[11] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[12] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.ColWidths[13] :=  90+Trunc(90*ResponsivoVideo);
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
  LstReport.Alignments[11, 0] := taRightJustify;
  LstReport.Alignments[12, 0] := taRightJustify;
  LstReport.Alignments[13, 0] := taRightJustify;
end;

procedure TFrmAuditoriaCargas.FormShow(Sender: TObject);
begin
  inherited;
  EdtCargaIdAC.SetFocus;
end;

function TFrmAuditoriaCargas.GetCargaAnaliseCubagemPorProduto: Boolean;
Var JsonArrayRetornoAC : TJsonArray;
    ObjCargaCA : TCargasCTRL;
    vErro : String;
    pEmbalagem : Integer;
    ObjCargaCtrl : TCargasCtrl;
begin
  Result := False;
  pEmbalagem := 2; //Criar combo para Tipo de Embalagem
  ObjCargaCtrl := TCargasCtrl.Create;
  Try
    Try
      JsonArrayRetornoAC := ObjCargaCtrl.GetCargaAnaliseCubagemPorProduto(StrToIntDef(EdtCargaIdAC.Text, 0), pEmbalagem);
      if JsonArrayRetornoAC.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LstReport.ClearRect(0, 1, LstReport.ColCount-1, LstReport.RowCount-1);
         LstReport.RowCount := 1;
      End
      Else
         FdMemPesqGeral.LoadFromJSON(JsonArrayRetornoAC, false);
      JsonArrayRetornoAC := Nil;
      Result := True
    Except On E: Exception do
      ShowErro('Erro: '+E.Message);
    End;
  Finally
    FreeAndNil(ObjCargaCtrl);
  End;
end;

function TFrmAuditoriaCargas.GetMotorista(pMotoristaId: Integer): Boolean;
Var ObjMotoristaCtrl : TPessoaCtrl;
    vArrayRetorno : TJsonArray;
    vErro : String;
begin
  ObjMotoristaCtrl := TPessoaCtrl.Create;
  LblMotoristaAC.Caption := '...';
  Try
    vArrayRetorno := ObjMotoristaCtrl.FindPessoa(pMotoristaId, 0, '', '', 4, 1);
    if vArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro(vErro);
    End
    Else Begin
      EdtMotoristaIdAC.Text  := pMotoristaId.ToString();
      LblMotoristaAC.Caption := vArrayRetorno.Items[0].GetValue<String>('razao');
      Result := True;
    End;
    vArrayRetorno := Nil;
  Finally
    FreeAndNil(ObjMotoristaCtrl);
  End;
end;

function TFrmAuditoriaCargas.GetTransportadora(pTransportadoraId: Integer): Boolean;
Var ObjTransportadoraCtrl  : TPessoaCtrl;
    JsonArrayRetorno : TJsonArray;
    VErro : String;
begin
  If pTransportadoraid = 0 then Exit;
  Try
    LblTransportadoraAC.Caption := '';
    ObjTransportadoraCtrl  := TPessoaCtrl.Create();
    JsonArrayRetorno := ObjTransportadoraCtrl.FindPessoa(ptransportadoraid, 0, '', '', 3, 1);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Transportadora não encontrada.');
       Exit;
    End;
    EdtTransportadoraIdAC.Text  := pTransportadoraId.ToString();
    LblTransportadoraAC.Caption := JsonArrayRetorno.Items[0].GetValue<String>('fantasia');
    Result := True;
    JsonArrayRetorno := Nil;
  Finally
    FreeAndNil(ObjTransportadoraCtrl);
  End;
end;

function TFrmAuditoriaCargas.GetVeiculo(pVeiculoId: String): Boolean;
Var ObjVeiculoCtrl : TVeiculoCtrl;
    vArrayRetornov : TJsonArray;
    vErro : String;
begin
  Try
    LblVeiculoAC.Caption := '';
    ObjVeiculoCtrl := TVeiculoCtrl.Create;
    if (StrToIntDef(pVeiculoId, 0)=0) then
       vArrayRetornov := ObjVeiculoCtrl.GetVeiculo(0, pVeiculoId, 0, 0)  //Placa
    Else
       vArrayRetornov := ObjVeiculoCtrl.GetVeiculo(StrToInt(pVeiculoId), '', 0, 0);
    if vArrayRetornov.Items[0].TryGetValue<String>('Erro', vErro) then
       ShowErro(vErro)
    Else Begin
       EdtVeiculoIdAC.Text        := vArrayRetornov.Items[0].GetValue<String>('veiculoid');
       LblVeiculoAC.Caption       := vArrayRetornov.Items[0].GetValue<String>('placa');
       LblVeiculoCapacidadeAC.Caption   := FormatFloat('######0.000', vArrayRetornov.Items[0].GetValue<Double>('capacidadekg'))+' Kg';
       LblVeiculoAC.Caption := FloatToStrF((vArrayRetornov.Items[0].GetValue<Double>('tarakg')*
                                            vArrayRetornov.Items[0].GetValue<Double>('largura')*
                                            vArrayRetornov.Items[0].GetValue<Double>('aproveitamento')), ffNumber, 18, 3)+' m3';
      Result := True;
    End;
    vArrayRetornov := Nil;
  Finally
    FreeAndNil(ObjVeiculoCtrl);
  End;
end;

procedure TFrmAuditoriaCargas.Limpar;
begin
  inherited;
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
  LStReport.FixedCols := 0;
  LStReport.RowCount  := 1;
  LblTotRegistro.Caption         := '0';
  LblCubagemTotalAC.caption      := '0';
end;

procedure TFrmAuditoriaCargas.MontaListaAnaliseCubagemPorProduto;
Var xCarga   : Integer;
    xCubagem : Double;
begin
  LstReport.RowCount := FdMemPesqGeral.RecordCount+1;
  If FdMemPesqGeral.IsEmpty() Then Begin
     LstReport.FixedRows := 0;
     LstReport.RowCount  := 1;
  End
  Else Begin
     LstReport.FixedRows := 1;
     ImprimirExportar(True);
  End;
  FdMemPesqGeral.First;
  LblTotRegistro.Caption := FdMemPesqGeral.RecordCount.ToString();
  xCarga   := 1;
  xCubagem := 0;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xCarga]  := FdMemPesqGeral.FieldByName('PedidoId').AsString;
    LstReport.Cells[1, xCarga]  := FdMemPesqGeral.FieldByName('PedidoVolumeId').AsString;
    LstReport.Cells[2, xCarga]  := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Cells[3, xCarga]  := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[4, xCarga]  := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[5, xCarga]  := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    LstReport.Cells[6, xCarga]  := FdMemPesqGeral.FieldByName('Altura').AsString;
    LstReport.Cells[7, xCarga]  := FdMemPesqGeral.FieldByName('Largura').AsString;
    LstReport.Cells[8, xCarga]  := FdMemPesqGeral.FieldByName('Comprimento').AsString;
    LstReport.Cells[9, xCarga]  := FdMemPesqGeral.FieldByName('Volume').AsString;
    LstReport.Cells[10, xCarga] := FdMemPesqGeral.FieldByName('VolumeTotal').AsString;
    LstReport.Cells[11, xCarga] := FormatFloat('0.000000', (FdMemPesqGeral.FieldByName('VolumeTotal').AsInteger/1000000));
    LstReport.Cells[12, xCarga] := FdMemPesqGeral.FieldByName('PesoTotal').AsString;
    LstReport.Cells[13, xCarga] := FormatFloat('0.000', (FdMemPesqGeral.FieldByName('PesoTotal').AsInteger/1000));
    xCubagem := xCubagem + FdMemPesqGeral.FieldByName('VolumeTotal').AsFloat;
    LstReport.Alignments[0, xCarga]  := taRightJustify;
    LstReport.FontStyles[0, xCarga]  := [FsBold];
    LstReport.Alignments[1, xCarga]  := taRightJustify;
    LstReport.Alignments[3, xCarga]  := taRightJustify;
    LstReport.Alignments[5, xCarga]  := taRightJustify;
    LstReport.Alignments[6, xCarga]  := taRightJustify;
    LstReport.Alignments[7, xCarga]  := taRightJustify;
    LstReport.Alignments[8, xCarga]  := taRightJustify;
    LstReport.Alignments[9, xCarga] := taRightJustify;
    LstReport.Alignments[10, xCarga] := taRightJustify;
    LstReport.Alignments[11, xCarga] := taRightJustify;
    LstReport.Alignments[12, xCarga] := taRightJustify;
    LstReport.Alignments[13, xCarga] := taRightJustify;
    LstReport.FontStyles[11, xCarga]  := [FsBold];
    LstReport.FontStyles[13, xCarga]  := [FsBold];
    Inc(xCarga);
    FdMemPesqGeral.Next;
  End;
  LblCubagemTotalAC.Caption := FormatFloat('0.', xCubagem)+'Cm'+'      '+FormatFloat('0.000000', xCubagem/1000000)+'m3';
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
end;

end.
