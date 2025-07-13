unit uFrmDashProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, DataSet.Serialize, Rest.Types,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, System.Json.Types, System.Json,
  cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, math,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, Vcl.OleCtrls, SHDocVw, JvToolEdit, View.WebCharts,
  cxLookAndFeels, dxSkinBasic, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinOffice2019Black, dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray,
  dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint, dxSkinWXI,
  dxSkinXmas2008Blue, frxSmartMemo, frxExportBaseImageSettingsDialog,
  frCoreClasses;

type
  TFrmDashProducao = class(TFrmReportBase)
    PnlTopFilter: TPanel;
    GroupBox14: TGroupBox;
    Label45: TLabel;
    Label46: TLabel;
    EdtDtPedidoInicial: TJvDateEdit;
    EdtDtPedidoFinal: TJvDateEdit;
    PnlGrafico: TPanel;
    BtnRefresh: TsImage;
    PnDshDemanda: TPanel;
    LblTotalDemanda: TLabel;
    PnlTitDemanda: TPanel;
    BvDemanda: TBevel;
    PnlProducao: TPanel;
    LblTotalProducao: TLabel;
    PnlTitProducao: TPanel;
    BvProducao: TBevel;
    PnlDshCancelamentos: TPanel;
    LblTotalCancelamentos: TLabel;
    PnlTitCancelamentos: TPanel;
    BvCancelamentos: TBevel;
    GbAtualizarDsh: TGroupBox;
    CbTime: TComboBox;
    FdMemDashBoardDemanda: TFDMemTable;
    StringField5: TStringField;
    IntegerField3: TIntegerField;
    StringField6: TStringField;
    FdMemDashBoardCortes: TFDMemTable;
    StringField7: TStringField;
    IntegerField4: TIntegerField;
    StringField8: TStringField;
    FdMemDashBoardCancelados: TFDMemTable;
    StringField9: TStringField;
    IntegerField5: TIntegerField;
    StringField10: TStringField;
    WebCharts1: TWebCharts;
    LblProducaoDia: TLabel;
    FdMemPesqGeralData: TStringField;
    FdMemPesqGeralValue: TIntegerField;
    FdMemPesqGeralRGB: TStringField;
    PnlWebBrowser1: TPanel;
    WebBrowser1: TWebBrowser;
    TmDashBoard: TTimer;
    FDMemEficiencia: TFDMemTable;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    FDMemDashBoardZona: TFDMemTable;
    StringField3: TStringField;
    IntegerField2: TIntegerField;
    StringField4: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CbTimeClick(Sender: TObject);
    procedure TmDashBoardTimer(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowGrafico;
    procedure ShowCard;
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmDashProducao: TFrmDashProducao;

implementation

{$R *.dfm}

Uses TypInfo, PedidoSaidaCtrl, uFuncoes;

procedure TFrmDashProducao.CbTimeClick(Sender: TObject);
begin
  inherited;
  TmDashBoard.Enabled := False;
  case CbTime.ItemIndex of
    1: TmDashBoard.Interval := 60000;
    2: TmDashBoard.Interval := Trunc(1.5*60000);
    3: TmDashBoard.Interval := 2*60000;
    4: TmDashBoard.Interval := Trunc(2.5*60000);
    5: TmDashBoard.Interval := 3*60000;
    6: TmDashBoard.Interval := 4*60000;
    7: TmDashBoard.Interval := 5*60000;
    8: TmDashBoard.Interval := 10*60000;
  end;
  TmDashBoard.Enabled := CbTime.ItemIndex > 0;
end;

procedure TFrmDashProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmDashProducao := Nil;
end;

procedure TFrmDashProducao.Limpar;
begin
  inherited;
  EdtDtPedidoInicial.Clear;
  EdtDtPedidoFinal.Clear;
  LblTotalDemanda.Caption  := '0';
  LblTotalProducao.Caption := '0';
  LblTotalCancelamentos.Caption   := '0';
  If FdMemDashBoardDemanda.Active then
     FdMemDashBoardDemanda.EmptyDataSet;
  FdMemDashBoardDemanda.Close;
  If FdMemDashBoardCortes.Active then
     FdMemDashBoardCortes.EmptyDataSet;
  FdMemDashBoardCortes.Close;
  If FdMemDashBoardCancelados.Active then
     FdMemDashBoardCancelados.EmptyDataSet;
  FdMemDashBoardCancelados.Close;

  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  If FdMemEficiencia.Active then
     FdMemEficiencia.EmptyDataSet;
  FdMemEficiencia.Close;

end;

procedure TFrmDashProducao.PesquisarDados;
Var ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonObjectRetorno  : TJsonObject;
    JsonArrayRetorno   : TJsonArray;
    vData, vErro       : String;
    RowData, vCountDia : Integer;
    vTotalDemanda, vTotalProducao, vTotalCorte : Integer;
begin
  vTotalDemanda  := 0;
  vTotalProducao := 0;
  vTotalCorte    := 0;
  vCountDia      := 0;
  Try
    if (EdtDtPedidoInicial.Text = '  /  /    ') or (EdtDtPedidoFinal.Text = '  /  /    ') then Begin
       ShowErro('Informe a Data do Pedido para análise!');
       EdtDtPedidoInicial.SetFocus;
       Exit;
    End;
    inherited;
    If FdMemPesqGeral.Active then
       FdMemPesqGeral.EmptyDataSet;
    FdMemPesqGeral.Close;
    If FdMemDashBoardDemanda.Active then
       FdMemDashBoardDemanda.EmptyDataSet;
    FdMemDashBoardDemanda.Close;
    If FdMemDashBoardCortes.Active then
       FdMemDashBoardCortes.EmptyDataSet;
    FdMemDashBoardCortes.Close;
    If FdMemDashBoardCancelados.Active then
       FdMemDashBoardCancelados.EmptyDataSet;
    FdMemDashBoardCancelados.Close;
    If FdMemEficiencia.Active then
       FdMemEficiencia.EmptyDataSet;
    FdMemEficiencia.Close;
    If FdMemDashBoardZona.Active then
       FdMemDashBoardZona.EmptyDataSet;
    FdMemDashBoardZona.Close;
    ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.create;
    JsonArrayRetorno   := ObjPedidoSaidaCtrl.GetDashProducaoDiaria(StrToDate(EdtDtPedidoInicial.Text), StrToDate(EdtDtPedidoFinal.Text));
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
       ShowErro('Erro: '+vErro)
    Else if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then
       ShowMSG(vErro)
    Else Begin
       FdMemDashBoardDemanda.Open;
       FdMemDashBoardCortes.Open;
       FdMemDashBoardCancelados.Open;
       FdMemPesqGeral.Open;
       FdMemEficiencia.Open;
       for RowData := 0 to Pred(JsonArrayRetorno.Count) do Begin
         vData := DateEuaToBr(JsonArrayRetorno.Items[RowData].GetValue<String>('data'));
         FdMemDashBoardDemanda.Append;
         FdMemDashBoardDemanda.FieldByName('Label').Value := Copy(vData, 1, 2)+NomeMes(StrToIntDef(copy(vData, 4,2), 0), 1);
         FdMemDashBoardDemanda.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtddemanda');
         FdMemDashBoardDemanda.FieldByName('RGB').Value   := '255, 255, 0';
         FdMemDashBoardCortes.Append;
         FdMemDashBoardCortes.FieldByName('Label').Value  := Copy(vData, 1, 2)+NomeMes(StrToIntDef(copy(vData, 4,2), 0), 1);
         FdMemDashBoardCortes.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtdproducao');
         FdMemDashBoardCortes.FieldByName('RGB').Value   := '0, 164, 82';
         FdMemDashBoardCancelados.Append;
         FdMemDashBoardCancelados.FieldByName('Label').Value := Copy(vData, 1, 2)+NomeMes(StrToIntDef(copy(vData, 4,2),0), 1);
         FdMemDashBoardCancelados.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtdcorte');
         FdMemDashBoardCancelados.FieldByName('RGB').Value   := '255, 0, 0';
         vTotalDemanda  := vTotalDemanda  + JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtddemanda');
         vTotalProducao := vTotalProducao + JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtdproducao');
         vTotalCorte    := vTotalCorte    + JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtdcorte');
         Inc(vCountDia);
       End;
       LblTotalDemanda.Caption       := FormatFloat('0', vTotalDemanda);
       LblTotalProducao.Caption      := FormatFloat('0', vTotalProducao);
       LblTotalCancelamentos.Caption := FormatFloat('0', vTotalCorte);
       //Media Diaria
       for RowData := 0 to Pred(JsonArrayRetorno.Count) do Begin
         FdMemPesqGeral.Append;
         FdMemPesqGeral.FieldByName('Label').Value := Copy(vData, 1, 2)+NomeMes(StrToIntDef(copy(vData, 4,2),0), 1);
         FdMemPesqGeral.FieldByName('Value').Value := Trunc(vTotalDemanda/vCountDia);
         FdMemPesqGeral.FieldByName('RGB').Value   := '0, 0, 0';
         FdMemEficiencia.Append;
         FdMemEficiencia.FieldByName('Label').Value := Copy(vData, 1, 2)+NomeMes(StrToIntDef(copy(vData, 4,2),0), 1);
         FdMemEficiencia.FieldByName('Value').Value := RoundTo(JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtdproducao') /
                                                               JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtddemanda') * 100 , -2);
         FdMemEficiencia.FieldByName('RGB').Value   := '175, 220, 240';
       End;

       JsonArrayRetorno   := ObjPedidoSaidaCtrl.GetDashProducaoDiariaZona(StrToDate(EdtDtPedidoInicial.Text), StrToDate(EdtDtPedidoFinal.Text));
       if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
          ShowErro('Erro: '+vErro)
       Else if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then
          ShowMSG(vErro)
       Else Begin
          FdMemDashBoardZona.Open;
          for RowData := 0 to Pred(JsonArrayRetorno.Count) do Begin
            FdMemDashBoardZona.Append;
            FdMemDashBoardZona.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('zona');
            FdMemDashBoardZona.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('qtdatendida');
            FdMemDashBoardZona.FieldByName('RGB').Value   := '128, 128, 0';
          End;
       End;
       ShowGrafico;
       //ShowCard;
    End;
  Finally
    JsonArrayRetorno := Nil;
    FreeAndNil(ObjPedidoSaidaCtrl);
  End;
end;

procedure TFrmDashProducao.ShowCard;
begin

end;

procedure TFrmDashProducao.ShowGrafico;
Var //ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    //JsonDashBoard0102  : TJsonObject;
    //JsonDashBoard030405, JsonDashBoard06 : TJsonArray;
    xRetorno : Integer;
Begin
end;

procedure TFrmDashProducao.TmDashBoardTimer(Sender: TObject);
begin
  inherited;
  PesquisarDados;
end;

end.
