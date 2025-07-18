unit uFrmDashRotaProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.JSON, REST.Json, System.JSON.Types, View.WebCharts,
  uFrmReportBase, dxSkinsCore, dxSkinsDefaultPainters, dxBarBuiltInMenu, DataSet.Serialize, Rest.Types,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, AdvUtil,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.OleCtrls, SHDocVw, frxExportXLS, frxClass, frxExportPDF, frxExportMail,
  frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV,
  ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList, AsgLinks,
  AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar, Vcl.DialogMessage,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, JvToolEdit;

type
  TFrmDashRotaProducao = class(TFrmReportBase)
    WebBrowser1: TWebBrowser;
    WebCharts1: TWebCharts;
    FdMemDashBoard01Unidades: TFDMemTable;
    FdMemDashBoard01UnidadesLabel: TStringField;
    FdMemDashBoard01UnidadesValue: TIntegerField;
    FdMemDashBoard01UnidadesRGB: TStringField;
    FdMemDashBoard02Unidades: TFDMemTable;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    PnlGrafico: TPanel;
    PnlTopFilter: TPanel;
    GroupBox14: TGroupBox;
    Label45: TLabel;
    Label46: TLabel;
    EdtDtPedidoInicial: TJvDateEdit;
    EdtDtPedidoFinal: TJvDateEdit;
    FdMemDashBoard03Unidades: TFDMemTable;
    StringField3: TStringField;
    IntegerField2: TIntegerField;
    StringField4: TStringField;
    FdMemDashBoard01Volumes: TFDMemTable;
    StringField5: TStringField;
    IntegerField3: TIntegerField;
    StringField6: TStringField;
    FdMemDashBoard02Volumes: TFDMemTable;
    StringField7: TStringField;
    IntegerField4: TIntegerField;
    StringField8: TStringField;
    FdMemDashBoard03Volumes: TFDMemTable;
    StringField9: TStringField;
    IntegerField5: TIntegerField;
    StringField10: TStringField;
    PnlCard: TPanel;
    WebBrowser2: TWebBrowser;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralProducao: TStringField;
    FdMemPesqGeralDemanda: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  FrmDashRotaProducao: TFrmDashRotaProducao;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl, Charts.Types, TypInfo, RotaCtrl;

procedure TFrmDashRotaProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmDashRotaProducao := Nil;
end;

procedure TFrmDashRotaProducao.FormCreate(Sender: TObject);
begin
  inherited;
//  PnlCard.Height := TabPrincipal.Height - (PnlTopFilter.Height+390);
end;

procedure TFrmDashRotaProducao.FormShow(Sender: TObject);
begin
  inherited;
  EdtDtPedidoInicial.SetFocus;
end;

procedure TFrmDashRotaProducao.Limpar;
begin
  inherited;
  EdtDtPedidoInicial.Clear;
  EdtDtPedidoFinal.Clear;
  If FdMemDashBoard01Unidades.Active then
     FdMemDashBoard01Unidades.EmptyDataSet;
  FdMemDashBoard01Unidades.Close;
  If FdMemDashBoard02Unidades.Active then
     FdMemDashBoard02Unidades.EmptyDataSet;
  FdMemDashBoard02Unidades.Close;
  If FdMemDashBoard03Unidades.Active then
     FdMemDashBoard03Unidades.EmptyDataSet;
  FdMemDashBoard03Unidades.Close;
  If FdMemDashBoard01Volumes.Active then
     FdMemDashBoard01Volumes.EmptyDataSet;
  FdMemDashBoard01Volumes.Close;
  If FdMemDashBoard02Volumes.Active then
     FdMemDashBoard02Volumes.EmptyDataSet;
  FdMemDashBoard02Volumes.Close;
  If FdMemDashBoard03Volumes.Active then
     FdMemDashBoard03Volumes.EmptyDataSet;
  FdMemDashBoard03Volumes.Close;
end;

procedure TFrmDashRotaProducao.PesquisarDados;
Var ObjRotaCtrl       : TRotaCtrl;
    JsonObjectRetorno : TJsonObject;
    JsonArrayRetorno  : TJsonArray;
    vErro   : String;

begin
    if (EdtDtPedidoInicial.Text = '  /  /    ') or (EdtDtPedidoFinal.Text = '  /  /    ') then Begin
       ShowErro('Informe a Data do Pedido para an�lise!');
       EdtDtPedidoInicial.SetFocus;
       Exit;
    End;
    inherited;
    If FdMemPesqGeral.Active then
       FdMemPesqGeral.EmptyDataSet;
    FdMemPesqGeral.Close;
    If FdMemDashBoard01Unidades.Active then
       FdMemDashBoard01Unidades.EmptyDataSet;
    FdMemDashBoard01Unidades.Close;
    If FdMemDashBoard02Unidades.Active then
       FdMemDashBoard02Unidades.EmptyDataSet;
    FdMemDashBoard02Unidades.Close;
    If FdMemDashBoard03Unidades.Active then
       FdMemDashBoard03Unidades.EmptyDataSet;
    FdMemDashBoard03Unidades.Close;
    TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
      procedure
      Var xItens : Integer;
      RowData : Integer;
      begin
        Try
          ObjRotaCtrl     := TRotaCtrl.create;
          JsonObjectRetorno := ObjRotaCtrl.GetProducaoDiaria(StrToDate(EdtDtPedidoInicial.Text), StrToDate(EdtDtPedidoFinal.Text));
          if JsonObjectRetorno.TryGetValue('Erro', vErro) then
             ShowErro('Erro: '+vErro)
          Else if JsonObjectRetorno.TryGetValue('MSG', vErro) then
             ShowMSG(vErro)
          Else Begin
             FdMemDashBoard01Unidades.Open;
             FdMemDashBoard02Unidades.Open;
             FdMemDashBoard03Unidades.Open;
             FdMemPesqGeral.Open;
             JsonArrayRetorno := JsonObjectRetorno.GetValue<TJsonArray>('unidades');
             for RowData := 0 to Pred(JsonArrayRetorno.Count) do Begin
               FdMemDashBoard01Unidades.Append;
               FdMemDashBoard01Unidades.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemDashBoard01Unidades.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('demanda');
               FdMemDashBoard01Unidades.FieldByName('RGB').Value   := '255, 255, 0';
               FdMemDashBoard02Unidades.Append;
               FdMemDashBoard02Unidades.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemDashBoard02Unidades.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('producao');
               FdMemDashBoard02Unidades.FieldByName('RGB').Value   := '0, 164, 82';
               FdMemDashBoard03Unidades.Append;
               FdMemDashBoard03Unidades.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemDashBoard03Unidades.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('corte');
               FdMemDashBoard03Unidades.FieldByName('RGB').Value   := '255, 0, 0';
               FdMemPesqGeral.Append;
               FdMemPesqGeral.FieldByName('Rota').Value     := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemPesqGeral.FieldByName('Demanda').Value  := ' Demanda: '+JsonArrayRetorno.Items[RowData].GetValue<Integer>('demanda').ToString()+ ' Un';
               FdMemPesqGeral.FieldByName('Producao').Value := 'Produ��o: '+(JsonArrayRetorno.Items[RowData].GetValue<Integer>('producao')+JsonArrayRetorno.Items[RowData].GetValue<Integer>('corte')).ToString()+ ' Un'+
                                                               '   '+((JsonArrayRetorno.Items[RowData].GetValue<Integer>('producao')+JsonArrayRetorno.Items[RowData].GetValue<Integer>('corte'))/
                                                                       JsonArrayRetorno.Items[RowData].GetValue<Integer>('demanda')*100).ToString()+'%';
             End;
             FdMemDashBoard01Volumes.Open;
             FdMemDashBoard02Volumes.Open;
             FdMemDashBoard03Volumes.Open;
             JsonArrayRetorno := JsonObjectRetorno.GetValue<TJsonArray>('volumes');
             for RowData := 0 to Pred(JsonArrayRetorno.Count) do Begin
               FdMemDashBoard01Volumes.Append;
               FdMemDashBoard01Volumes.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemDashBoard01Volumes.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('demanda');
               FdMemDashBoard01Volumes.FieldByName('RGB').Value   := '255, 255, 0';
               FdMemDashBoard02Volumes.Append;
               FdMemDashBoard02Volumes.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemDashBoard02Volumes.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('producao');
               FdMemDashBoard02Volumes.FieldByName('RGB').Value   := '0, 164, 82';
               FdMemDashBoard03Volumes.Append;
               FdMemDashBoard03Volumes.FieldByName('Label').Value := JsonArrayRetorno.Items[RowData].GetValue<String>('rota');
               FdMemDashBoard03Volumes.FieldByName('Value').Value := JsonArrayRetorno.Items[RowData].GetValue<Integer>('cancelado');
               FdMemDashBoard03Volumes.FieldByName('RGB').Value   := '255, 0, 0';
             End;
             ShowGrafico;
             ShowCard;
          End;
        Finally
          JsonArrayRetorno := Nil;
          FreeAndNil(ObjRotaCtrl);
        End;
     End);
end;

Procedure TFrmDashRotaProducao.ShowCard;
Begin
  WebCharts1
    .NewProject
    .Cards
      .FieldHeader('Rota')
      .FieldTitle('Demanda')
      .FieldBody('Producao')
      .ColSpan(4)
      .Colors
        .Secondary
      .&End
      .DataSet
        .DataSet(FdMemPesqGeral)
      .&End
    .&End
    .WebBrowser(WebBrowser2)
    .Generated;
End;

procedure TFrmDashRotaProducao.ShowGrafico;
Var ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonDashBoard0102  : TJsonObject;
    JsonDashBoard030405, JsonDashBoard06 : TJsonArray;
    xRetorno : Integer;
Begin
TThread.Synchronize(TThread.CurrentThread, procedure
begin
  WebCharts1

  .NewProject
  .Rows
  .tag
  .add(
    WebCharts1
    .ContinuosProject
       .Charts
         ._ChartType(HorizontalBar)
           .Attributes
             .Name('Diariox')
             .ColSpan(6)
             .Options
               .SemiCircule(True)
             .&End
             .Heigth(600)
             .Options
                .Title
                  .fontSize(14)
                  .Text('Produ��o Unidades')
                .&End
             .&End
                 .DataSet
                   .textLabel('Demanda')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoard01Unidades)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('255,255,0')
                 .&End
                 .DataSet
                   .textLabel('Producao')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoard02Unidades)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('0,164,82')
                 .&End
                 .DataSet
                   .textLabel('Cortes/Cancelamento')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoard03Unidades)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('255,0,0')
                 .&End
           .&End
         .&End
         .HTML
    )
  .&End
//Grafico 02
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(HorizontalBar)
             .Attributes
               .Name('Mensal')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .fontSize(14)
                    .Text('Produ��o Volumes')
                  .&End
               .&End
               .Heigth(600)
                 .DataSet
                   .textLabel('Demanda')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoard01Volumes)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('255,255,0')
                 .&End
                 .DataSet
                   .textLabel('Producao')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoard02Volumes)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('0,164,82')
                 .&End
                 .DataSet
                   .textLabel('Cortes/Cancelamento')
                   //.BackgroundColor('30,182,100')
                   .DataSet(FdMemDashBoard03Volumes)
                   .Fill(False)
                   .BorderWidth(2)
                   .BorderColor('0,164,82')
                 .&End
             .&End
           .&End
           .HTML
      )
    .&End
  .&End

  .WebBrowser(WebBrowser1)
  .Generated;
End);
  JsonDashBoard0102   := Nil;
  JsonDashBoard030405 := Nil;
  JsonDashBoard06     := Nil;
  ObjPedidoSaidaCtrl  := Nil;

end;

end.
