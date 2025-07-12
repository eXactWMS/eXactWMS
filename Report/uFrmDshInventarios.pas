unit uFrmDshInventarios;

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
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvBaseEdits, JvToolEdit, System.Generics.Collections,
  DataSet.Serialize, System.Json, Rest.Types, InventarioCtrl;

type
  TFrmDshInventarios = class(TFrmReportBase)
    GbPeriodo: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    GbAtualizarDsh: TGroupBox;
    CbTime: TComboBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    EdtDtInventarioInicial: TJvDateEdit;
    EdtDtInventarioFinal: TJvDateEdit;
    EdtInventarioIdInicial: TJvCalcEdit;
    EdtInventarioIdFinal: TJvCalcEdit;
    GbDshInventarios: TPanel;
    Label25: TLabel;
    PnlInventarioFinalizado: TPanel;
    Shape7: TShape;
    Label9: TLabel;
    LblTotalFinalizado: TLabel;
    Image1: TImage;
    LblPercFinalizado: TLabel;
    PnlInventarioPendencia: TPanel;
    Shape1: TShape;
    Label12: TLabel;
    LblTotalPendente: TLabel;
    LblPercPendente: TLabel;
    Image4: TImage;
    PnlInventarioTotal: TPanel;
    Shape2: TShape;
    Label6: TLabel;
    LblTotalInventario: TLabel;
    Image5: TImage;
    PnlInventarioCancelado: TPanel;
    Shape3: TShape;
    Label7: TLabel;
    LblTotalCancelado: TLabel;
    lblPercCancelado: TLabel;
    Image6: TImage;
    GbDshEnderecos: TPanel;
    Label8: TLabel;
    PnlEnderecoFinalizado: TPanel;
    Shape4: TShape;
    Label10: TLabel;
    LblEnderecoFinalizado: TLabel;
    Image2: TImage;
    LblPercEnderecoFinalizado: TLabel;
    PnlEnderecoEmContagem: TPanel;
    Shape5: TShape;
    Label14: TLabel;
    LblEnderecoEmContagem: TLabel;
    LblPercEmContagem: TLabel;
    Image3: TImage;
    PnlEnderecoPendente: TPanel;
    Shape6: TShape;
    Label17: TLabel;
    LblEnderecoPendente: TLabel;
    Image7: TImage;
    PnlInventarioEmContagem: TPanel;
    ShpInventarioEmContagem: TShape;
    Label11: TLabel;
    LblInventarioEmContagem: TLabel;
    LblPercInventarioEmContagem: TLabel;
    Image8: TImage;
    PnlEnderecoTotal: TPanel;
    Shape8: TShape;
    Label13: TLabel;
    LblEnderecoTotal: TLabel;
    Image9: TImage;
    LblPercEnderecoPendente: TLabel;
    Panel1: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    EdtContagemInicio: TEdit;
    EdtContagemTermino: TEdit;
    EdtContagemMedia: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInventarioIdInicialChange(Sender: TObject);
  private
    { Private declarations }
    Procedure GetDshInventarios;
    Procedure MontaDshInventarios;
    Procedure ThreadValidarDshInventarios(Sender : TObject);
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmDshInventarios: TFrmDshInventarios;

implementation

{$R *.dfm}

procedure TFrmDshInventarios.EdtInventarioIdInicialChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmDshInventarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmDshInventarios := Nil;
end;

procedure TFrmDshInventarios.GetDshInventarios;
Var TH : TThread;
    vDataInicial, vDataFinal : TDateTime;
begin
  Limpar;
  if (EdtDtInventarioInicial.Text = '  /  /    ') then
     vDataInicial := 0
  Else
     vDataInicial := StrToDate(EdtDtInventarioInicial.Text);
  if (EdtDtInventarioFinal.Text = '  /  /    ') then
     vDataFinal := 0
  Else
     vDataFinal := StrToDate(EdtDtInventarioFinal.Text);
  FdMemPesqGeral.Close;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  TH := TThread.CreateAnonymousThread(procedure
  Var JsonObjectRetorno : TJsonObject;
      ObjInventarioCtrl : TInventarioCtrl;
      xLines : Integer;
      vErro  : String;
      vTotalPendente, vTotalContagem, vTotalCancelado, vTotalFinalizado : Integer;
      vEnderecoPendente, vEnderecoFinalizado, vEnderecoContagem : Integer;
      vTotal : Integer;
  begin
    ObjInventarioCtrl := TInventarioCtrl.Create;
    JsonObjectRetorno := ObjInventarioCtrl.GetDshInventarios(vDataInicial, vDataFinal,
                        StrToIntDef(EdtInventarioIdInicial.Text, 0), StrToIntDef(EdtInventarioIdFinal.Text, 0));
    if JsonObjectRetorno.TryGetValue('Erro', vErro) then Begin
       JsonObjectRetorno := Nil;
       ObjInventarioCtrl.Free;
       raise Exception.Create(vErro);
       Exit;
    End;
    vTotalPendente      := 0;
    vTotalContagem      := 0;
    vTotalCancelado     := 0;
    vTotalFinalizado    := 0;
    vTotal              := 0;
    vEnderecoPendente   := 0;
    vEnderecoFinalizado := 0;
    vEnderecoContagem   := 0;
    for xLines := 0 to Pred(JsonObjectRetorno.GetValue<TJsonArray>('inventario').Count) do Begin
      case JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('processoid') of
        123: Begin
             LblTotalPendente.Caption        := JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario').ToString();
             vTotalPendente := vTotalPendente + JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario');
        End;
        133: Begin
             LblInventarioEmContagem.Caption := JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario').ToString();
             vTotalContagem := vTotalContagem + JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario');
        End;
        143: Begin
             LblTotalCancelado.Caption       := JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario').ToString();
             vTotalCancelado := vTotalCancelado + JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario');
        End;
        153: Begin
             LblTotalFinalizado.Caption      := JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario').ToString();
             vTotalFinalizado := vTotalFinalizado + JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario');
        End;
      end;
      vTotal := vTotal + JsonObjectRetorno.GetValue<TJsonArray>('inventario').Items[xLines].GetValue<Integer>('totalinventario');
    End;
    LblTotalInventario.Caption := vTotal.ToString();
    LblPercPendente.Caption := FormatFloat('0.00', vTotalPendente/vTotal*100)+'%';
    LblPercInventarioEmContagem.Caption := FormatFloat('0.00', vTotalContagem/vTotal*100)+'%';
    LblPercFinalizado.Caption := FormatFloat('0.00', vTotalFinalizado/vTotal*100)+'%';
    LblPercCancelado.Caption := FormatFloat('0.00', vTotalCancelado/vTotal*100)+'%';
    vTotal := 0;
    for xLines := 0 to Pred(JsonObjectRetorno.GetValue<TJsonArray>('endereco').Count) do Begin
      If JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<String>('status') = 'I' then Begin
         LblEnderecoPendente.Caption := JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco').ToString();
         vEnderecoPendente := vEnderecoPendente + JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco');
      End;
      If JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<String>('status') = 'C' then Begin
         LblEnderecoEmContagem.Caption := JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco').ToString();
         vEnderecoContagem := vEnderecoContagem + JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco');
      End;
      If JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<String>('status') = 'F' then Begin
         LblEnderecoFinalizado.Caption := JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco').ToString();
         vEnderecoFinalizado := vEnderecoFinalizado + JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco');
      End;
      vTotal := vTotal + JsonObjectRetorno.GetValue<TJsonArray>('endereco').Items[xLines].GetValue<Integer>('totalendereco');
    End;
    LblEnderecoTotal.Caption := vTotal.ToString();
    LblPercEnderecoPendente.Caption   := FormatFloat('0.00', vEnderecoPendente/vTotal*100)+'%';
    LblPercEmContagem.Caption         := FormatFloat('0.00', vEnderecoContagem/vTotal*100)+'%';
    LblPercEnderecoFinalizado.Caption := FormatFloat('0.00', vEnderecoFinalizado/vTotal*100)+'%';
    JsonObjectRetorno := Nil;
    ObjInventarioCtrl.Free;
  end);
  TH.OnTerminate := ThreadValidarDshInventarios;
  TH.Start;
end;

procedure TFrmDshInventarios.Limpar;
begin
  inherited;
  LblTotalInventario.Caption := '0';
  LblTotalPendente.Caption   := '0';
  LblPercPendente.Caption    := '0';
  LblInventarioEmContagem.Caption     := '0';
  LblPercInventarioEmContagem.Caption := '0';
  LblTotalFinalizado.Caption := '0';
  LblPercFinalizado.Caption  := '0';
  LblTotalCancelado.Caption  := '0';
  LblPercCancelado.Caption   := '0';
  LblEnderecoTotal.Caption   := '0';
  LblEnderecoPendente.Caption     := '0';
  LblPercEnderecoPendente.Caption := '0';
  LblEnderecoEmContagem.Caption := '0';
  LblPercEmContagem.Caption  := '0';
  LblEnderecoFinalizado.Caption     := '0';
  LblPercEnderecoFinalizado.Caption := '0';
end;

procedure TFrmDshInventarios.MontaDshInventarios;
Begin

end;

procedure TFrmDshInventarios.PesquisarDados;
begin
  inherited;
  if (EdtDtInventarioInicial.Text = '  /  /    ') and
     (EdtDtInventarioFinal.Text   = '  /  /    ') and
     (StrToIntDef(EdtInventarioIdInicial.Text, 0) = 0) and
     (StrToIntDef(EdtInventarioIdFinal.Text, 0)=0) then Begin
     ShowErro('Informe os parâmetros para pesquisa!');
     Exit;
  End;
  if (EdtDtInventarioInicial.Text <> '  /  /    ') and
     (EdtDtInventarioFinal.Text   <> '  /  /    ') Then
     if (StrToDate(EdtDtInventarioInicial.Text) > StrToDate(EdtDtInventarioFinal.Text)) then Begin
        ShowErro('Data final não pode ser menor que Data Inicial.');
        EdtDtInventarioInicial.SetFocus;
        Exit;
     End;
  GetDshInventarios;
end;

procedure TFrmDshInventarios.ThreadValidarDshInventarios(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then begin
     ShowErro(Exception(TThread(sender).FatalException).Message, 'alerta');
     Exit;
  end;
end;

end.
