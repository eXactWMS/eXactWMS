unit uFrmRelProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, ProdutoCtrl,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons, System.JSON, REST.Json,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar, Rest.Types,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, Generics.Collections, Vcl.DialogMessage, dxCameraControl,
  System.Win.ComObj, ActiveX;

type
  TFrmRelProdutos = class(TFrmReportBase)
    GbProduto: TGroupBox;
    LblProduto: TLabel;
    BtnSchProduto: TBitBtn;
    EdtProdutoId: TEdit;
    GbZona: TGroupBox;
    LblZona: TLabel;
    BtnSchZona: TBitBtn;
    EdtZonaId: TEdit;
    GbOpcoes: TGroupBox;
    ChkSaldoEstoque: TCheckBox;
    ChkSemPicking: TCheckBox;
    ChkDadosLogisticos: TCheckBox;
    ChkListaEan: TCheckBox;
    GroupBox1: TGroupBox;
    LblLaboratorio: TLabel;
    BtnSchLaboratorio: TBitBtn;
    EdtLaboratorioId: TEdit;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralEmbalagem: TStringField;
    FdMemPesqGeralZonaDescricao: TStringField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralMascara: TStringField;
    FdMemPesqGeralRastro: TStringField;
    FdMemPesqGeralLaboratorioId: TIntegerField;
    FdMemPesqGeralFabricante: TStringField;
    FdMemPesqGeralCurva: TStringField;
    FdMemPesqGeralPesoLiquido: TFloatField;
    FdMemPesqGeralAltura: TFloatField;
    FdMemPesqGeralLargura: TFloatField;
    FdMemPesqGeralComprimento: TFloatField;
    FdMemPesqGeralVolCm3: TFloatField;
    FdMemPesqGeralSngpc: TIntegerField;
    FdMemPesqGeralEstoque: TIntegerField;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    frxDadosLogisticos: TfrxReport;
    FdMemPesqGeralEan02: TStringField;
    FdMemPesqGeralEan03: TStringField;
    FdMemPesqGeralEan04: TStringField;
    FdMemPesqGeralEan05: TStringField;
    FdMemPesqGeralEan06: TStringField;
    FdMemPesqGeralEan07: TStringField;
    FdMemPesqGeralEan08: TStringField;
    FdMemPesqGeralEan09: TStringField;
    FdMemPesqGeralEan10: TStringField;
    FdMemPesqGeralEan01: TStringField;
    frxListaEan: TfrxReport;
    FdMemPesqGeralSomenteCxaFechada: TIntegerField;
    ChkSomenteCxaFechada: TCheckBox;
    LblExportando: TLabel;
    ChkAtivo: TCheckBox;
    ChkBloqueado: TCheckBox;
    procedure BtnSchProdutoClick(Sender: TObject);
    procedure EdtProdutoIdExit(Sender: TObject);
    procedure BtnSchZonaClick(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnSchLaboratorioClick(Sender: TObject);
    procedure EdtLaboratorioIdExit(Sender: TObject);
    procedure ChkSaldoEstoqueClick(Sender: TObject);
    procedure EdtProdutoIdChange(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure EdtLaboratorioIdChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure ChkAtivoClick(Sender: TObject);
    procedure ChkBloqueadoClick(Sender: TObject);
  private
    { Private declarations }
    vCodProduto : Integer;
    Procedure HideUnhideColumn;
    Procedure ExportaExcelDadosLogisticos;
  Protected
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelProdutos: TFrmRelProdutos;

implementation

{$R *.dfm}

uses Services.Produtos, Views.Pequisa.Produtos, EnderecamentoZonaCtrl, Views.Pequisa.EnderecamentoZonas,
     LaboratorioCtrl, uFrmeXactWMS, uFuncoes, Views.Pequisa.Laboratorio;

procedure TFrmRelProdutos.BtnExportarStandClick(Sender: TObject);
begin
  if ChkDadosLogisticos.Checked then
     ExportaExcelDadosLogisticos
  Else
     inherited;
end;

procedure TFrmRelProdutos.BtnImprimirStandClick(Sender: TObject);
Var vFiltro : String;
begin
  vFiltro := 'Produto: ';
  If EdtProdutoId.Text <> '' then
     vFiltro := vFiltro+Copy(LblProduto.Caption,1,20)
  Else vFiltro := vFiltro+'...';
  vFiltro := vFiltro + '   Zona: ';
  If EdtZonaid.Text <> '' then
     vFiltro := vFiltro+Copy(LblZona.Caption, 1, 20)
  Else vFiltro := vFiltro+'...';
  vFiltro := vFiltro + '   Fabricante: ';
  If EdtlaboratorioId.Text <> '' then
     vFiltro := vFiltro+Copy(LblLaboratorio.Caption, 1, 20)
  Else vFiltro := vFiltro+'...';
  frxReport1.Variables['vFiltro'] := QuotedStr(vFiltro );
  if ChkDadosLogisticos.Checked then
     frxDadosLogisticos.ShowReport
  Else if ChkListaEan.Checked then
     frxListaEan.ShowReport
  Else
     inherited;
end;

procedure TFrmRelProdutos.BtnPesquisarStandClick(Sender: TObject);
Var ObjProdutoCtrl : TProdutoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    vEstoque, vSemPicking, vListaEan, xItens : Integer;
    vSomenteCxaFechada, vAtivo, vBloqueado : Integer;
begin
  if (EdtProdutoId.Text<>'') and (StrToInt64Def(EdtProdutoId.Text, 0) <= 0) then Begin
     EdtProdutoId.SetFocus;
     ShowErro('Código('+EdtProdutoId.Text+') do Produto inválido!');
     EdtProdutoId.SetFocus;
     Exit;
  End;
  if (EdtLaboratorioId.Text<>'') and (StrToIntDef(EdtLaboratorioId.Text, 0) <= 0) then Begin
     EdtLaboratorioId.SetFocus;
     ShowErro('Id('+EdtLaboratorioId.Text+') do fabricante inválido!');
     EdtLaboratorioId.SetFocus;
     Exit;
  End;
  //inherited;
  BtnImprimirStand.Enabled := True;
  BtnImprimirStand.Grayed  := False;
  BtnExportarStand.Enabled := True;
  BtnExportarStand.Grayed  := True;
  LstReport.RowCount := 1;
  //FdMemPesqGeral.Close;
  BtnImprimirStand.Grayed := True;
  If ChkSaldoEstoque.Checked then
     vEstoque := 1
  Else vEstoque := 0;
  If ChkSemPicking.Checked Then
     vSemPicking := 1
  Else vSemPicking := 0;
  If ChkListaEan.Checked Then
     vListaEan := 1
  Else vListaEan := 0;

  TDialogMessage.ShowWaitMessage('Buscando Dados. Conectado com servidor...',
    procedure
    Var xItens, vCodStatusRetorno : Integer;
    begin
      ObjProdutoCtrl     := TProdutoCtrl.Create();
      if ChkSomenteCxaFechada.Checked then vSomenteCxaFechada := 1 Else vSomenteCxaFechada := 0;
      if ChkAtivo.Checked then vAtivo := 1 Else vAtivo := 0;
      if ChkBloqueado.Checked then vBloqueado := 1 Else vBloqueado := 0;
      JsonArrayRetorno := ObjProdutoCtrl.GetRelProdutos01(vEstoque, vSemPicking, vCodProduto,
                          StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtLaboratorioId.Text, 0), vListaEan, vSomenteCxaFechada, vAtivo, vBloqueado);
      vCodStatusRetorno := 0;
      if JsonArrayRetorno.Items[0].TryGetValue<String>('status', vErro) then
         vCodStatusRetorno := JsonArrayRetorno.Items[0].GetValue<Integer>('status')
      Else if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
         EdtProdutoId.SetFocus;
         JsonArrayRetorno := Nil;
         FreeAndNil(ObjProdutoCtrl);
         raise Exception.Create(vErro);
      End;
      if vCodStatusRetorno > 299 then Begin
         EdtProdutoId.SetFocus;
         ShowErro(JsonArrayRetorno.Items[0].GetValue<String>('mensagem'));
         JsonArrayRetorno := Nil;
         FreeAndNil(ObjProdutoCtrl);
         Exit;
      End;
      If FdMemPesqGeral.Active then
         FdmemPesqGeral.EmptyDataSet;
      FdMemPesqGeral.Close;
      FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
      LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
      if Not FdMemPesqGeral.IsEmpty then Begin
         LstReport.RowCount  := FdMemPesqGeral.RecordCount+1;
         LstReport.FixedRows := 1;
      End;
      for xItens := 1 to FdMemPesqGeral.RecordCount do Begin
        LstReport.AddDataImage(14, xItens, 0, haCenter, vaTop);
        LstReport.AddDataImage(26, xItens, 0, haCenter, vaTop);
      End;
      xItens := 1;
      HideUnhideColumn;
      While Not FdMemPesqGeral.Eof do Begin
        LstReport.Cells[0, xItens]  := FdMemPesqGeral.FieldByName('CodProduto').AsString;
        LstReport.Cells[1, xItens]  := FdMemPesqGeral.FieldByName('Descricao').AsString;
        LstReport.Cells[2, xItens]  := FdMemPesqGeral.FieldByName('Embalagem').AsString;
        LstReport.Cells[3, xItens]  := FdMemPesqGeral.FieldByName('ZonaDescricao').AsString;
        LstReport.Cells[4, xItens]  := FdMemPesqGeral.FieldByName('EnderecoFormatado').AsString;
        LstReport.Cells[5, xItens]  := FdMemPesqGeral.FieldByName('Rastro').AsString;
        LstReport.Cells[6, xItens]  := FdMemPesqGeral.FieldByName('Fabricante').AsString;
        LstReport.Cells[7, xItens]  := FdMemPesqGeral.FieldByName('Curva').AsString;
        LstReport.Cells[8, xItens]  := FormatFloat('0.000', FdMemPesqGeral.FieldByName('PesoLiquido').AsFloat);
        LstReport.Cells[9, xItens]  := FdMemPesqGeral.FieldByName('Altura').AsString;
        LstReport.Cells[10, xItens] := FdMemPesqGeral.FieldByName('largura').AsString;
        LstReport.Cells[11, xItens] := FdMemPesqGeral.FieldByName('Comprimento').AsString;
        LstReport.Cells[12, xItens] := (FdMemPesqGeralAltura.Value*FdMemPesqGeralLargura.Value*FdMemPesqGeralComprimento.Value).ToString();
        LstReport.Cells[13, xItens] := FormatFloat('0.000000', FdMemPesqGeral.FieldByName('Volm3').AsFloat);
        LstReport.Cells[14, xItens] := FdMemPesqGeral.FieldByName('Sngpc').AsString;
        LstReport.Cells[15, xItens] := FdMemPesqGeral.FieldByName('Estoque').AsString;
        LstReport.Cells[16, xItens] := FdMemPesqGeral.FieldByName('Ean01').AsString;
        LstReport.Cells[17, xItens] := FdMemPesqGeral.FieldByName('Ean02').AsString;
        LstReport.Cells[18, xItens] := FdMemPesqGeral.FieldByName('Ean03').AsString;
        LstReport.Cells[19, xItens] := FdMemPesqGeral.FieldByName('Ean04').AsString;
        LstReport.Cells[20, xItens] := FdMemPesqGeral.FieldByName('Ean05').AsString;
        LstReport.Cells[21, xItens] := FdMemPesqGeral.FieldByName('Ean06').AsString;
        LstReport.Cells[22, xItens] := FdMemPesqGeral.FieldByName('Ean07').AsString;
        LstReport.Cells[23, xItens] := FdMemPesqGeral.FieldByName('Ean08').AsString;
        LstReport.Cells[24, xItens] := FdMemPesqGeral.FieldByName('Ean09').AsString;
        LstReport.Cells[25, xItens] := FdMemPesqGeral.FieldByName('Ean10').AsString;
        LstReport.Cells[26, xItens] := FdMemPesqGeral.FieldByName('SomenteCxaFechada').AsString;

        LstReport.Alignments[0,  xItens] := taRightJustify;
        LstReport.FontStyles[0,  xItens] := [FsBold];
        LstReport.Alignments[7,  xItens] := taCenter;
        LstReport.Alignments[8,  xItens] := taRightJustify;
        LstReport.Alignments[9,  xItens] := taRightJustify;
        LstReport.Alignments[10, xItens] := taRightJustify;
        LstReport.Alignments[11, xItens] := taRightJustify;
        LstReport.Alignments[12, xItens] := taRightJustify;
        LstReport.Alignments[13, xItens] := taRightJustify;
        LstReport.Alignments[14, xItens] := taCenter;
        LstReport.Alignments[15, xItens] := taRightJustify;
        Inc(xItens);
        FdMemPesqGeral.Next;
      End;
      BtnImprimirStand.Enabled := True;
      BtnImprimirStand.Grayed  := False;
      BtnExportarStand.Enabled := True;
      BtnExportarStand.Grayed  := False;
      JsonArrayRetorno := Nil;
      FreeAndNil(ObjProdutoCtrl);
    End);
end;

procedure TFrmRelProdutos.BtnSchLaboratorioClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaLaboratorio := TFrmPesquisaLaboratorio.Create(Application);
  try
    if (FrmPesquisaLaboratorio.ShowModal = mrOk) then  Begin
       EdtLaboratorioId.Text := FrmPesquisaLaboratorio.Tag.ToString();
       EdtLaboratorioIdExit(EdtLaboratorioId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelProdutos.BtnSchProdutoClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then  Begin
       EdtProdutoId.Text := FrmPesquisaProduto.Tag.ToString();
       EdtProdutoIdExit(EdtProdutoId);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelProdutos.BtnSchZonaClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmRelProdutos.ChkAtivoClick(Sender: TObject);
begin
  inherited;
  if ChkAtivo.CheckEd then ChkBloqueado.Checked := False;
end;

procedure TFrmRelProdutos.ChkBloqueadoClick(Sender: TObject);
begin
  inherited;
  if ChkBloqueado.CheckEd then ChkAtivo.Checked := False;
end;

procedure TFrmRelProdutos.ChkSaldoEstoqueClick(Sender: TObject);
begin
  inherited;
  Limpar;
  if (Sender = ChkDadosLogisticos) and (ChkDadosLogisticos.Checked)  then
     ChkListaEan.Checked := False;
  if (Sender = ChkListaEan) and (ChkListaEan.Checked)  then
     ChkDadosLogisticos.Checked := False;
  HideUnhideColumn;
end;

procedure TFrmRelProdutos.EdtLaboratorioIdChange(Sender: TObject);
begin
  inherited;
  LblLaboratorio.Caption     := '';
  Limpar;
end;

procedure TFrmRelProdutos.EdtLaboratorioIdExit(Sender: TObject);
Var ObjLaboratorioCtrl : TLaboratorioCtrl;
    LstLaboratorioCtrl : TObjectList<TLaboratorioCtrl>;
begin
  if (EdtLaboratorioId.Text<>'') and (StrToIntDef(EdtLaboratorioId.Text, 0) <= 0) then Begin
     EdtLaboratorioId.SetFocus;
     ShowErro('Id('+EdtLaboratorioId.Text+') do fabricante inválido!');
     EdtLaboratorioId.SetFocus;
     Exit;
  End;
  inherited;
  if (Not EdtLaboratorioId.ReadOnly) and (EdtLaboratorioId.Text<>'') then Begin
     if StrToIntDef(EdtLaboratorioId.Text, 0) <= 0 then
        raise Exception.Create('Código de Fabricante inválido!');
     Try
       ObjLaboratorioCtrl := TLaboratorioCtrl.Create;
       LstLaboratorioCtrl := ObjLaboratorioCtrl.GetLaboratorio(StrToIntDef(EdtLaboratorioId.Text, 0), '', 0);
       If LstLaboratorioCtrl.Items[0].ObjLaboratorio.IdLaboratorio = 0 then Begin
          ObjLaboratorioCtrl.Free;
          LstLaboratorioCtrl := Nil;
          raise Exception.Create('Fabricante('+EdtLaboratorioId.Text+') não entrado!');
       End;
       LblLaboratorio.Caption := LstLaboratorioCtrl.Items[0].ObjLaboratorio.NOme;
     Except On E: Exception do Begin
        ObjLaboratorioCtrl.Free;
        LstLaboratorioCtrl := Nil;
        raise Exception.Create('Fabricante: '+EdtLaboratorioId.Text+sLineBreak+E.Message);
        End;
     End;
     ObjLaboratorioCtrl.Free;
     LstLaboratorioCtrl := Nil;
  End;
  ExitFocus(Sender);
end;

procedure TFrmRelProdutos.EdtProdutoIdChange(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LblProduto.Caption := '';
  Limpar;
end;

procedure TFrmRelProdutos.EdtProdutoIdExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    ObjProdutoCtrl   : TProdutoCtrl;
    vErro, vCodDig   : String;
    vProdutoDigitado : Integer;
begin
  if (EdtProdutoId.Text<>'') and (StrToInt64Def(EdtProdutoId.Text, 0) <= 0) then Begin
     EdtProdutoId.SetFocus;
     ShowErro('Código('+EdtProdutoId.Text+') de Produto inválido!');
     EdtProdutoId.SetFocus;
     Exit;
  End;
  inherited;
  LblProduto.Caption  := '';
  if EdtProdutoId.Text = '' then Exit;
  vProdutoDigitado := tProdutoCtrl.GetCodProdEan(EdtProdutoId.Text);
  if vProdutoDigitado = 0 then Begin
     vCodDig := EdtProdutoId.Text;
     EdtProdutoId.Clear;
     raise Exception.Create('Produto não encontrado! Verifique o Código/Ean('+vCodDig+')');
  End;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  JsonArrayRetorno := ObjProdutoCtrl.FindProduto(vProdutoDigitado.ToString, '', '', 0, 0);
  if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtProdutoId.Text := '';
     EdtProdutoId.SetFocus;
     JsonArrayRetorno := Nil;
     ObjProdutoCtrl.Free;
     //JsonArrayRetorno.DisposeOf;
     raise Exception.Create('Produto não encontrado!');
  End;
  vCodProduto := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto');
  LblProduto.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  FreeAndNil(ObjProdutoCtrl);
  JsonArrayRetorno := Nil;
end;

procedure TFrmRelProdutos.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '';
  Limpar;
end;

procedure TFrmRelProdutos.EdtZonaIdExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl  : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  if (EdtZonaId.Text<>'') and (StrToIntDef(EdtZonaId.Text, 0) <= 0) then Begin
     EdtZonaId.SetFocus;
     ShowErro('Id('+EdtZonaId.Text+') da Zona/Setor inválido!');
     EdtZonaId.SetFocus;
     Exit;
  End;
  inherited;
  LblZona.Caption := '';
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Exit;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create();
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(StrToIntDef(EdtZonaId.Text, 0), '', 0);
  if JsonArrayRetorno.Count < 1 Then Begin
     EdtZonaId.Text := '';
     EdtZonaId.SetFocus;
     ObjEnderecamentoZonaCtrl.Free;
     JsonArrayRetorno := Nil;
     raise Exception.Create('Zona não encontrada!');
  End;
  LblZona.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  ObjEnderecamentoZonaCtrl.Free;
  JsonArrayRetorno := Nil;
end;

procedure TFrmRelProdutos.FdMemPesqGeralCalcFields(DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByName('EnderecoFormatado').AsString := EnderecoMask(FdMemPesqGeral.FieldByName('Endereco').AsString, FdMemPesqGeral.FieldByName('Mascara').AsString, True);
end;

procedure TFrmRelProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRelProdutos := Nil;
end;

procedure TFrmRelProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LstReport.ColWidths[0]  :=  90;
  LstReport.ColWidths[1]  := 250;
  LstReport.ColWidths[2]  := 110;
  LstReport.ColWidths[3]  := 120;
  LstReport.ColWidths[4]  :=  90;
  LstReport.ColWidths[5]  := 100;
  LstReport.ColWidths[6]  := 200;
  LstReport.ColWidths[7]  :=  60;
  LstReport.ColWidths[8]  :=  60;
  LstReport.ColWidths[9]  :=  70; //Vencimento
  LstReport.ColWidths[10] :=  70;
  LstReport.ColWidths[11] :=  70;
  LstReport.ColWidths[12] :=  80;
  LstReport.ColWidths[13] :=  80;
  LstReport.ColWidths[14] :=  50;
  LstReport.ColWidths[15] :=  60;
  LstReport.ColWidths[16] :=  90;
  LstReport.ColWidths[17] :=  90;
  LstReport.ColWidths[18] :=  90;
  LstReport.ColWidths[19] :=  90;
  LstReport.ColWidths[20] :=  90;
  LstReport.ColWidths[21] :=  90;
  LstReport.ColWidths[22] :=  90;
  LstReport.ColWidths[23] :=  90;
  LstReport.ColWidths[24] :=  90;
  LstReport.ColWidths[25] :=  90;
  LstReport.ColWidths[26] :=  50;

  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[7, 0]  := taCenter;
  LstReport.Alignments[8, 0]  := taRightJustify;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
  LstReport.Alignments[11, 0] := taRightJustify;
  LstReport.Alignments[12, 0] := taRightJustify;
  LstReport.Alignments[13, 0] := taRightJustify;
  LstReport.Alignments[14, 0] := taCenter;
  LstReport.Alignments[15, 0] := taRightJustify;
  LstReport.HideColumn(8);
  LstReport.HideColumn(9);
  LstReport.HideColumn(10);
  LstReport.HideColumn(11);
  LstReport.HideColumn(12);
  LstReport.HideColumn(13);
  LstReport.HideColumn(14);
  LstReport.HideColumn(15);
  LstReport.HideColumn(16);
  LstReport.HideColumn(17);
  LstReport.HideColumn(18);
  LstReport.HideColumn(19);
  LstReport.HideColumn(20);
  LstReport.HideColumn(21);
  LstReport.HideColumn(22);
  LstReport.HideColumn(23);
  LstReport.HideColumn(24);
  LstReport.HideColumn(25);

  LstReport.RowCount := 1;
end;

procedure TFrmRelProdutos.HideUnhideColumn;
begin
  if ChkSaldoEstoque.Checked then
     LstReport.unHideColumn(14)
  Else
     LstReport.HideColumn(14);
  FdMemPesqGeralEstoque.Visible := ChkSaldoEstoque.Checked;
  if Not ChkListaEan.Checked then Begin
     LstReport.HideColumn(16);
     LstReport.HideColumn(17);
     LstReport.HideColumn(18);
     LstReport.HideColumn(19);
     LstReport.HideColumn(20);
     LstReport.HideColumn(21);
     LstReport.HideColumn(22);
     LstReport.HideColumn(23);
     LstReport.HideColumn(24);
     LstReport.HideColumn(25);
     FdMemPesqGeralEan01.Visible := False;
     FdMemPesqGeralEan02.Visible := False;
     FdMemPesqGeralEan03.Visible := False;
     FdMemPesqGeralEan04.Visible := False;
     FdMemPesqGeralEan05.Visible := False;
     FdMemPesqGeralEan06.Visible := False;
     FdMemPesqGeralEan07.Visible := False;
     FdMemPesqGeralEan08.Visible := False;
     FdMemPesqGeralEan09.Visible := False;
     FdMemPesqGeralEan10.Visible := False;
     LstReport.UnHideColumn(8);
     LstReport.UnHideColumn(9);
     LstReport.UnHideColumn(10);
     LstReport.UnHideColumn(11);
     LstReport.UnHideColumn(12);
     LstReport.UnHideColumn(13);
     LstReport.UnHideColumn(14);
     FdMemPesqGeralPesoLiquido.Visible := True;
     FdMemPesqGeralAltura.Visible := True;
     FdMemPesqGeralLargura.Visible := True;
     FdMemPesqGeralComprimento.Visible := True;
     FdMemPesqGeralVolCm3.Visible := True;
     FdMemPesqGeralSngpc.Visible := True;
  End
  Else Begin
     LstReport.UnHideColumn(16);
     LstReport.UnHideColumn(17);
     LstReport.UnHideColumn(18);
     LstReport.UnHideColumn(19);
     LstReport.UnHideColumn(20);
     LstReport.UnHideColumn(21);
     LstReport.UnHideColumn(22);
     LstReport.UnHideColumn(23);
     LstReport.UnHideColumn(24);
     LstReport.UnHideColumn(25);
     FdMemPesqGeralEan01.Visible := True;
     FdMemPesqGeralEan02.Visible := True;
     FdMemPesqGeralEan03.Visible := True;
     FdMemPesqGeralEan04.Visible := True;
     FdMemPesqGeralEan05.Visible := True;
     FdMemPesqGeralEan06.Visible := True;
     FdMemPesqGeralEan07.Visible := True;
     FdMemPesqGeralEan08.Visible := True;
     FdMemPesqGeralEan09.Visible := True;
     FdMemPesqGeralEan10.Visible := True;
     LstReport.HideColumn(8);
     LstReport.HideColumn(9);
     LstReport.HideColumn(10);
     LstReport.HideColumn(11);
     LstReport.HideColumn(12);
     LstReport.HideColumn(13);
     LstReport.HideColumn(14);
     FdMemPesqGeralPesoLiquido.Visible := False;
     FdMemPesqGeralAltura.Visible := False;
     FdMemPesqGeralLargura.Visible := False;
     FdMemPesqGeralComprimento.Visible := False;
     FdMemPesqGeralVolCm3.Visible := False;
     FdMemPesqGeralSngpc.Visible := False;
  End;
  FdMemPesqGeralEnderecoFormatado.Visible := False;
end;

procedure TFrmRelProdutos.Limpar;
begin
  inherited;
  LblExportando.Visible := False;
end;

procedure TFrmRelProdutos.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  LstReport.Row := aRow;
  if (aRow = 0) and (aCol <= 7) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelProdutos.ExportaExcelDadosLogisticos;
var
  Excel    : Variant;
  Linha, i : Integer;
  vPath    : String;
  ExcelApp : OleVariant;
  ExcelWorkbook: OleVariant;
  ExcelWorksheet: OleVariant;
  ColumnIndex, RowIndex: Integer;

begin
  if not FDMemPesqGeral.IsEmpty then
  begin
    LblExportando.Visible  := True;
    vPath := ExtractFilePath(Application.ExeName)+'Relatorio\';
    if not DirectoryExists(vPath) then
       ForceDirectories(vPath);
    FDMemPesqGeral.First;
    Try
      CoInitialize(nil);
      ExcelApp := CreateOleObject('Excel.Application');
      Try
        ExcelApp.Visible := False;
        ExcelWorkbook := ExcelApp.Workbooks.Add;
        ExcelWorksheet := ExcelWorkbook.Worksheets[1];
        ExcelWorksheet.cells[1, 1] := 'Cód.Prod';
        ExcelWorksheet.cells[1, 2] := 'Descricao';
        ExcelWorksheet.cells[1, 3] := 'Embalagem';
        ExcelWorksheet.cells[1, 4] := 'Zona';
        ExcelWorksheet.cells[1, 5] := 'Picking';
        ExcelWorksheet.cells[1, 6] := 'Rastro';
        ExcelWorksheet.cells[1, 7] := 'Fabricante';
        ExcelWorksheet.cells[1, 8] := 'Curva';
        ExcelWorksheet.cells[1, 9] := 'Peso(g)';
        ExcelWorksheet.cells[1,10] := 'Altura';
        ExcelWorksheet.cells[1,11] := 'Largua';
        ExcelWorksheet.cells[1,12] := 'Comprimento';
        ExcelWorksheet.cells[1,13] := 'Volume(cm3)';
        ExcelWorksheet.cells[1,14] := 'Volume(m3)';
        ExcelWorksheet.cells[1,15] := 'SNGPC';
        ExcelWorksheet.cells[1,16] := 'Estoque';
        ExcelWorksheet.cells[1,17] := 'Cxa.Fechada';
        Linha := 2;
        While not FDMemPesqGeral.Eof do Begin
          ExcelWorksheet.cells[Linha, 1] := FdMemPesqGeralCodProduto.Value;
          ExcelWorksheet.cells[Linha, 2] := FdMemPesqGeralDescricao.Value;
          ExcelWorksheet.cells[Linha, 3] := FdMemPesqGeralEmbalagem.Value;
          ExcelWorksheet.cells[Linha, 4] := FdMemPesqGeralZonaDescricao.Value;
          ExcelWorksheet.cells[Linha, 5] := FdMemPesqGeralEnderecoFormatado.Value;
          ExcelWorksheet.cells[Linha, 6] := FdMemPesqGeralRastro.Value;
          ExcelWorksheet.cells[Linha, 7] := FdMemPesqGeralFabricante.Value;
          ExcelWorksheet.cells[Linha, 8] := FdMemPesqGeralCurva.Value;
          ExcelWorksheet.cells[Linha, 9] := FdMemPesqGeralPesoLiquido.Value;
          ExcelWorksheet.cells[Linha,10] := FdMemPesqGeralAltura.Value;
          ExcelWorksheet.cells[Linha,11] := FdMemPesqGeralComprimento.Value;
          ExcelWorksheet.cells[Linha,12] := FdMemPesqGeralLargura.Value;
          ExcelWorksheet.cells[Linha,13] := (FdMemPesqGeralAltura.Value*FdMemPesqGeralLargura.Value*FdMemPesqGeralComprimento.Value);
          ExcelWorksheet.cells[Linha,14] := FdMemPesqGeralVolCm3.Value;
          if FdMemPesqGeralSngpc.Value = 1 then
             ExcelWorksheet.cells[Linha,15] := 'Sim'
          Else
             ExcelWorksheet.cells[Linha,15] := 'Não';
          ExcelWorksheet.cells[Linha,16] := FdMemPesqGeralEstoque.Value;
          if FdMemPesqGeralSomenteCxaFechada.Value = 1 then
             ExcelWorksheet.cells[Linha,17] := 'Sim'
          Else
             ExcelWorksheet.cells[Linha,17] := 'Não';
          FDMemPesqGeral.Next;
          LstReport.Row := Linha-1;
          Inc(Linha);
          LblExportando.Caption := 'Exportando Registro: '+Linha.ToString()+' de '+FdMemPesqGeral.RecordCount.ToString;
          Application.ProcessMessages;
        end;
        ExcelApp.DisplayAlerts := False;
        ExcelWorkbook.SaveAs(vPath+'ProdutoDadosLogistico.xlsx');
        ExcelWorkbook.Close;
        ExcelApp.DisplayAlerts := True;
        LblExportando.Visible  := False;
        ShowMessage('Exportação Concluída. '+vPath+'ProdutoDadosLogistico.xlsx');
      Except On E: Exception do Begin
        LblExportando.Visible  := False;
        raise Exception.Create('Erro: '+E.Message);
        End;
      End;
    Finally
      if not VarIsEmpty(ExcelApp) then begin
         ExcelApp.Quit; // Encerra o Excel
         ExcelApp := Unassigned; // Libera a referência
      end;
      ExcelWorksheet := Unassigned;
      ExcelWorkbook := Unassigned;
      CoUninitialize;
    End;
  end;
end;

end.
