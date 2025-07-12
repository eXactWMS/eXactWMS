unit uFrmRelDshCheckOut;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, System.Generics.Collections, DataSet.Serialize, System.Json,
  Rest.Types, JvToolEdit, dxCameraControl;

type
  TFrmRelDshCheckOut = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicioProducao: TJvDateEdit;
    EdtTerminoProducao: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BtnPesqUsuario: TBitBtn;
    Label4: TLabel;
    LblTPedido: TLabel;
    Label6: TLabel;
    LblTVolume: TLabel;
    Label8: TLabel;
    LblTUnidade: TLabel;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    EdtMetaFracionado: TEdit;
    Label9: TLabel;
    EdtToleranciaFracionado: TEdit;
    Label5: TLabel;
    EdtMetaCxaFechada: TEdit;
    Label10: TLabel;
    EdtToleranciaCxaFechada: TEdit;
    Bevel1: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel2: TBevel;
    GroupBox4: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    EdtInicioPedido: TJvDateEdit;
    EdtTerminoPedido: TJvDateEdit;
    RgEmbalagem: TRadioGroup;
    GroupBox2: TGroupBox;
    ChkRecheckOut: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EdtInicioProducaoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure BtnPesqUsuarioClick(Sender: TObject);
    procedure RgEmbalagemClick(Sender: TObject);
  public
    { Public declarations }
  private
    { Private declarations }
    //Procedure MontaListaDshCheckOut;
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
  end;

var
  FrmRelDshCheckOut: TFrmRelDshCheckOut;

implementation

{$R *.dfm}

uses Vcl.DialogMessage, PedidoVolumeCtrl, uFuncoes, UsuarioCtrl, Views.Pequisa.Usuarios;

procedure TFrmRelDshCheckOut.BtnPesqUsuarioClick(Sender: TObject);
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

procedure TFrmRelDshCheckOut.EdtInicioProducaoChange(Sender: TObject);
begin
  inherited;
  LblUsuario.Caption  := '';
  LimparLstAdvReport;
  LblTPedido.Caption  := '0';
  LblTVolume.Caption  := '0';
  LblTUnidade.Caption := '0';
end;

procedure TFrmRelDshCheckOut.EdtUsuarioIdExit(Sender: TObject);
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

procedure TFrmRelDshCheckOut.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelDshCheckOut := Nil;
end;

procedure TFrmRelDshCheckOut.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[1]  := 100+Trunc(100*ResponsivoVideo);
  LstReport.ColWidths[2]  :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[3]  := 250+Trunc(250*ResponsivoVideo);
  LstReport.ColWidths[4]  :=  60+Trunc(60*ResponsivoVideo);
  LstReport.ColWidths[5]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[6]  :=  70+Trunc(70*ResponsivoVideo);
  LstReport.ColWidths[7]  := 130+Trunc(130*ResponsivoVideo);
  LstReport.ColWidths[8]  := 130+Trunc(130*ResponsivoVideo);
  LstReport.ColWidths[9]  :=  80+Trunc(80*ResponsivoVideo);
  LstReport.ColWidths[10] := 85+Trunc(85*ResponsivoVideo);
  LstReport.ColWidths[11] := 65+Trunc(65*ResponsivoVideo);
  LstReport.Alignments[0, 0]  := taCenter;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[2, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[7, 0]  := taCenter;
  LstReport.Alignments[8, 0]  := taCenter;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
  LstReport.Alignments[11, 0] := taRightJustify;
  LstReport.HideColumn(4);
end;

procedure TFrmRelDshCheckOut.FormShow(Sender: TObject);
begin
  inherited;
  EdtInicioPedido.SetFocus;
end;

procedure TFrmRelDshCheckOut.Limpar;
begin
  inherited;
  EdtInicioPedido.Clear;
  EdtTerminoPedido.Clear;
  EdtInicioProducao.Clear;
  EdtTerminoProducao.Clear;
  EdtUsuarioId.Clear;
  Lblusuario.Caption    := '';
  RgEmbalagem.ItemIndex := -1;
  LimparLstAdvReport;
  LblTPedido.Caption    := '0';
  LblTVolume.Caption    := '0';
  LblTUnidade.Caption   := '0';
end;

//procedure TFrmRelDshCheckOut.MontaListaDshCheckOut;
//begin

//end;

procedure TFrmRelDshCheckOut.MontarLstAdvReport(pJsonArray: TJsonArray);
Var xRetorno : Integer;
    vTPedido, vTVolume, vTUnidade : Integer;
    vDataInicio, vDataTermino : TDateTime;
    vUnidadePorHora : Integer;
begin
  inherited;
  //FdMemPesqGeral.fielddeflist --Exibir campos da query
  vTPedido  := 0;
  vTVolume  := 0;
  vTUnidade := 0;
  LstReport.RowCount       := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRetorno := 1;
  EdtMetaFracionado.Text       := FdMemPesqGeral.FieldByName('checkoutfracionadometa').AsString;
  EdtToleranciaFracionado.Text := FdMemPesqGeral.FieldByName('checkoutfracionadotolerancia').AsString;
  EdtMetaCxaFechada.Text       := FdMemPesqGeral.FieldByName('checkoutcxafechadameta').AsString;
  EdtToleranciaCxaFechada.Text := FdMemPesqGeral.FieldByName('checkoutcxafechadatolerancia').AsString;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRetorno] := FdMemPesqGeral.FieldByName('data').AsString;
    LstReport.Cells[1, xRetorno] := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Cells[2, xRetorno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString;
    LstReport.Cells[3, xRetorno] := FdMemPesqGeral.FieldByName('Nome').AsString;
    LstReport.Cells[4, xRetorno] := FdMemPesqGeral.FieldByName('TPedido').AsString;
    LstReport.Cells[5, xRetorno] := FdMemPesqGeral.FieldByName('TVolume').AsString;
    LstReport.Cells[6, xRetorno] := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    //2022-10-26 21:56:55.617
    vDataInicio  := StrToDateTime(Copy(FdMemPesqGeral.FieldByName('Inicio').AsString, 9, 2)+'/'+
                    Copy(FdMemPesqGeral.FieldByName('Inicio').AsString, 6, 2)+'/'+
                    Copy(FdMemPesqGeral.FieldByName('Inicio').AsString, 1, 4)+' '+
                    Copy(FdMemPesqGeral.FieldByName('Inicio').AsString, 12, 12));
    vDataTermino := StrToDateTime(Copy(FdMemPesqGeral.FieldByName('Termino').AsString, 9, 2)+'/'+
                    Copy(FdMemPesqGeral.FieldByName('Termino').AsString, 6, 2)+'/'+
                    Copy(FdMemPesqGeral.FieldByName('Termino').AsString, 1, 4)+' '+
                    Copy(FdMemPesqGeral.FieldByName('Termino').AsString, 12, 12));
    LstReport.Cells[7, xRetorno]  := DateTimeToStr(vDataInicio); //FdMemPesqGeral.FieldByName('Inicio').AsString;
    LstReport.Cells[8, xRetorno]  := DateTimeToStr(vDataTermino); //FdMemPesqGeral.FieldByName('Termino').AsString;
    LstReport.Cells[9, xRetorno]  := Calculatempo(vDataInicio, vDataTermino); //(FdMemPesqGeral.FieldByName('Inicio').AsDateTime, FdMemPesqGeral.FieldByName('Termino').AsDateTime);
    LstReport.Cells[10, xRetorno] := CalcUnidHr(FdMemPesqGeral.FieldByName('TVolume').AsInteger,
                                                LstReport.Cells[9, xRetorno] ).ToString();
    vUnidadePorHora := CalcUnidHr(FdMemPesqGeral.FieldByName('QtdSuprida').AsInteger, LstReport.Cells[9, xRetorno] );
    LstReport.Cells[11, xRetorno] := vUnidadePorHora.ToString();
//    if FdMemPesqGeral.FieldByName('EmbalagemId').AsInteger = 0 then Begin
       if vUnidadePorHora >= FdMemPesqGeral.FieldByName('CheckOutMeta').AsInteger then
          LstReport.Colors[11, xRetorno] := ClGreen
       Else if vUnidadePorHora >= FdMemPesqGeral.FieldByName('CheckOutTolerancia').AsInteger then
          LstReport.Colors[11, xRetorno] := ClYellow
       Else //if FdMemPesqGeral.FieldByName('UnidadePorHora').AsInteger > FdMemPesqGeral.FieldByName('apanhe').AsInteger then
          LstReport.Colors[11, xRetorno] := ClRed;
//    End
//    Else Begin

//    End;
    vTPedido  := vTPedido  + FdMemPesqGeral.FieldByName('TPedido').Asinteger;
    vTVolume  := vTVolume  + FdMemPesqGeral.FieldByName('TVolume').AsInteger;
    vTUnidade := vTUnidade + FdMemPesqGeral.FieldByName('QtdSuprida').AsInteger;
//    LstReport.Cells[9, xRetorno] := FdMemPesqGeral.FieldByName('VolumePorHora').AsString;
//    LstReport.Cells[10, xRetorno] := FdMemPesqGeral.FieldByName('UnidadeporHora').AsString;
//    EdtMeta.Text       := FdMemPesqGeral.FieldByName('Meta').AsString;
//    EdtTolerancia.Text := FdMemPesqGeral.FieldByName('Tolerancia').AsString;
    LstReport.Alignments[0, xRetorno]  := taRightJustify;
    LstReport.FontStyles[0, xRetorno]  := [FsBold];
    LstReport.Alignments[2, xRetorno]  := taRightJustify;
    LstReport.Alignments[4, xRetorno]  := taRightJustify;
    LstReport.Alignments[5, xRetorno]  := taRightJustify;
    LstReport.Alignments[6, xRetorno]  := taRightJustify;
    LstReport.Alignments[7, xRetorno]  := taCenter;
    LstReport.Alignments[8, xRetorno]  := taCenter;
    LstReport.Alignments[9, xRetorno]  := taRightJustify;
    LstReport.Alignments[10, xRetorno] := taRightJustify;
    LstReport.Alignments[11, xRetorno] := taRightJustify;
    FdMemPesqGeral.Next;
    Inc(xRetorno);
  End;
  LblTPedido.Caption  := FormatFloat('###,##0', vTPedido);
  LblTVolume.Caption  := FormatFloat('###,##0', vTVolume);
  LblTUnidade.Caption := FormatFloat('###,##0', vTUnidade);
end;

procedure TFrmRelDshCheckOut.PesquisarDados;
Var JsonArrayRetorno : TJsonArray;
    vDataInicialPedido, vDataFinalPedido     : TDateTime;
    vDataInicialProducao, vDataFinalProducao : TDateTime;
    ObjPedidoVolumeCtrl       : TPedidoVolumeCtrl;
    vEmbalagemId : Integer;
    vErro        : String;
begin
//  inherited;
  if (EdtInicioPedido.Text = '  /  /    ') And (EdtTerminoProducao.Text = '  /  /    ') and
     (EdtInicioProducao.Text = '  /  /    ') And (EdtTerminoProducao.Text = '  /  /    ') then Begin
     ShowErro('Informe o período(Pedidos e/ou Produção) para gerar os dados.');
     EdtInicioPedido.SetFocus;
     Exit;
  End;
  if (EdtInicioPedido.Text <> '  /  /    ') And (EdtTerminoPedido.Text <> '  /  /    ') and
     (StrToDate(EdtInicioPedido.Text) > StrToDate(EdtTerminoPedido.Text)) then Begin
     ShowErro('Data Final dos Pedidos não pode ser inferior a Data Inicial.');
     EdtInicioProducao.SetFocus;
     Exit;
  End;

  if (EdtInicioProducao.Text <> '  /  /    ') And (EdtTerminoProducao.Text <> '  /  /    ') and
     (StrToDate(EdtInicioProducao.Text) > StrToDate(EdtTerminoProducao.Text)) then Begin
     ShowErro('Data Final da Produção não pode ser inferior a Data Inicial.');
     EdtInicioProducao.SetFocus;
     Exit;
  End;
  if (RgEmbalagem.ItemIndex < 0) then Begin
     ShowErro('Informe o tipo de embalagem para análise.');
     EdtInicioProducao.SetFocus;
     Exit;
  End;
  if EdtInicioPedido.Text = '  /  /    ' then
     vDataInicialPedido := 0
  Else vDataInicialPedido := StrToDate(EdtInicioPedido.Text);
  if EdtTerminoPedido.Text = '  /  /    ' then
     vDataFinalPedido := 0
  Else vDataFinalPedido := StrToDate(EdtTerminoPedido.Text);
  if EdtInicioProducao.Text = '  /  /    ' then
     vDataInicialProducao := 0
  Else vDataInicialProducao := StrToDate(EdtInicioProducao.Text);
  if EdtTerminoProducao.Text = '  /  /    ' then
     vDataFinalProducao := 0
  Else vDataFinalProducao := StrToDate(EdtTerminoProducao.Text);
  vEmbalagemId := 99;
  if (RgEmbalagem.ItemIndex = 0) then
     vEmbalagemId := 0
  Else vEmbalagemId := 1;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno, vReCheckOut : Integer;
    begin
      ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
      if ChkRecheckOut.Checked then
         vReCheckOut := 1
      Else
         vReCheckOut := 0;
      JsonArrayRetorno := ObjPedidoVolumeCtrl.GetDshCheckOut(vDataInicialPedido, vDataFinalPedido,
                          vDataInicialProducao, vDataFinalProducao, StrToIntDef(EdtusuarioId.Text, 0), vEmbalagemId, vReCheckOut);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LimparLstAdvReport
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdmemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
        FdmemPesqGeral.Open;
        //LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
      End;
      JsonArrayRetorno := Nil;
      ObjPedidoVolumeCtrl.Free;
    End);
end;

procedure TFrmRelDshCheckOut.RgEmbalagemClick(Sender: TObject);
begin
  inherited;
  LimparLstAdvReport;
  LblTPedido.Caption  := '0';
  LblTVolume.Caption  := '0';
  LblTUnidade.Caption := '0';
end;

end.
