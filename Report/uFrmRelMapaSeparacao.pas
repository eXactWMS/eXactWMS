unit uFrmRelMapaSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, Generics.Collections,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, System.Json, Rest.Types,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, DataSet.Serialize, Vcl.DialogMessage,
  PedidoSaidaCtrl, PedidoVolumeCtrl, Services.Base.Cadastro,
  frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, frxRich, frxCross, frxOLE, frxBarcode, frxChBox, frxGradient,
  JvToolEdit, dxCameraControl, PessoaCtrl;

type
  TFrmRelMapaSeparacao = class(TFrmReportBase)
    QryMapaSeparacao: TFDMemTable;
    QryMapaSeparacaoPedidoId: TIntegerField;
    QryMapaSeparacaoDocumentoNr: TStringField;
    QryMapaSeparacaoData: TDateField;
    QryMapaSeparacaoPedidoVolumeId: TIntegerField;
    QryMapaSeparacaoSequencia: TIntegerField;
    QryMapaSeparacaoPessoaId: TIntegerField;
    QryMapaSeparacaoRazao: TStringField;
    QryMapaSeparacaoRotaId: TIntegerField;
    QryMapaSeparacaoRotaDescricao: TStringField;
    QryMapaSeparacaoEndereco: TStringField;
    QryMapaSeparacaoDescrLote: TStringField;
    QryMapaSeparacaoVencimento: TDateField;
    QryMapaSeparacaoProdutoId: TIntegerField;
    QryMapaSeparacaoCodProduto: TIntegerField;
    QryMapaSeparacaoProdutoDescricao: TStringField;
    QryMapaSeparacaoEan: TStringField;
    QryMapaSeparacaoQuantidade: TIntegerField;
    QryMapaSeparacaoUnidade: TStringField;
    QryMapaSeparacaoEmbalagemPadrao: TIntegerField;
    QryMapaSeparacaoVolumeTipo: TStringField;
    QryMapaSeparacaoCodPessoaERP: TIntegerField;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoIdInicial: TEdit;
    EdtPedidoIdFinal: TEdit;
    QryMapaSeparacaoEmbalagem: TStringField;
    QryMapaSeparacaoRua: TStringField;
    QryMapaSeparacaoZona: TStringField;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralDocumentoData: TDateField;
    FdMemPesqGeralRazao: TStringField;
    FdMemPesqGeralRota: TStringField;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    FdMemPesqGeralEmbalagem: TStringField;
    FdMemPesqGeralRuaId: TIntegerField;
    FdMemPesqGeralZona: TStringField;
    FdMemPesqGeralPredioInicial: TStringField;
    FdMemPesqGeralRua: TStringField;
    FdMemPesqGeralProcessoId: TIntegerField;
    FdMemPesqGeralProcesso: TStringField;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    BtnPesqCliente: TBitBtn;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    Label2: TLabel;
    EdtPedidoVolumeIdInicial: TEdit;
    LblVolumeProceso: TLabel;
    Label5: TLabel;
    EdtPedidoVolumeIdFinal: TEdit;
    Label6: TLabel;
    ChkImprimirPDF: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPedidoVolumeIdInicialExit(Sender: TObject);
    procedure EdtPedidoIdInicialChange(Sender: TObject);
    procedure EdtPedidoIdInicialExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure LstCadastroRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure LstCadastroDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstCadastroClick(Sender: TObject);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
  private
    { Private declarations }
    FService : TServiceBaseCadastro;
    SelecaoVolumes : Boolean;
    PrintGeral     : Boolean;
    Procedure Limpar;
    Procedure MontaListaVolumes;
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Imprimir; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelMapaSeparacao: TFrmRelMapaSeparacao;

implementation

{$R *.dfm}

uses uFuncoes, Services.Pedido, uFrmeXactWMS, Views.Pequisa.Pessoas, Views.Pequisa.Rotas,
  RotaCtrl;

procedure TFrmRelMapaSeparacao.BtnImprimirStandClick(Sender: TObject);
Var xMapa, xPrint : Integer;
begin
  inherited;
  PrintGeral := True;
  xPrint := 0;
  for xMapa := 1 to Pred(LstReport.RowCount) do Begin
    LstReportClickCell(LstReport, xMapa, 10);
    Inc(xPrint);
  End;
  if xPrint > 1 then
     ShowOk('Impressos '+xPrint.ToString()+' Mapas de Separação.')
  Else
     ShowErro('Não foram impressos Mapas.');
  PrintGeral := False;
end;

procedure TFrmRelMapaSeparacao.BtnPesqClienteClick(Sender: TObject);
begin
  inherited;
  if EdtDestinatario.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioExit(EdtDestinatario);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmRelMapaSeparacao.BtnPesqRotaClick(Sender: TObject);
begin
  inherited;
  if ((Sender=BtnPesqRota) and (EdtRotaId.ReadOnly)) then Exit;
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

procedure TFrmRelMapaSeparacao.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtDestinatario.Text = '' then Begin
     LblDestinatario.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaSeparacao.EdtPedidoIdInicialChange(Sender: TObject);
begin
  inherited;
  LimparLstAdvReport;
end;

procedure TFrmRelMapaSeparacao.EdtPedidoIdInicialExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  FService := TServicePedidos.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/saida/cubagem')

     .ClearParams
     .AddParam('pedidoid', TEdit(Sender).Text);
     //.AddParam('pedidovolumeid', EdtPedidoVolumeId.Text);
  JsonArrayRetorno := FService.ListarRegistroJson;
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Pedido: '+TEdit(Sender).Text+' '+UTF8Encode(vErro));
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else Begin

  End;
  JsonArrayRetorno := Nil;
  FService.Free;
  //if Assigned(JsonArrayRetorno) then
  //  FreeAndNil(JsonArrayRetorno);
end;

procedure TFrmRelMapaSeparacao.EdtPedidoVolumeIdInicialExit(Sender: TObject);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno :TJsonArray;
    vErro : String;
begin
  inherited;
  if (EdtPedidoVolumeIdInicial.Text <> '') then Begin
     EdtPedidoIdInicial.Clear;
     EdtPedidoIdFinal.Clear;
     JsonArrayRetorno := ObjpedidoVolumeCtrl.GetVolume(0, StrToIntDef(EdtPedidoVolumeIdInicial.Text, 0), 0, 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro('Volume: '+EdtPedidoVolumeIdInicial.Text+' '+vErro);
        EdtPedidoVolumeIdInicial.Clear;
        EdtPedidoVolumeIdInicial.SetFocus;
     End
     else
        LblVolumeProceso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('processo');
     JsonArrayRetorno := Nil;
  End;
end;

procedure TFrmRelMapaSeparacao.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblRota.Caption := '';
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     ShowErro( '😢Rota('+TEdit(Sender).Text+') inválida!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     ShowErro('Rota não encontrada!');
     TEdit(Sender).Clear;
  end
  Else Begin
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao
  End;
  ObjRotaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelMapaSeparacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelMapaSeparacao := Nil
end;

procedure TFrmRelMapaSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  :=  80;
  LstReport.ColWidths[1]  :=  80;
  LstReport.ColWidths[2]  := 250;
  LstReport.ColWidths[3]  := 120;
  LstReport.ColWidths[4]  :=  50;
  LstReport.ColWidths[5]  := 70;
  LstReport.ColWidths[6]  := 120;
  LstReport.ColWidths[7]  := 120;
  LstReport.ColWidths[8]  :=  60;
  LstReport.ColWidths[9]  := 120;
  LstReport.ColWidths[10] :=  60;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taCenter;
  LstReport.HideColumn(11);
  SelecaoVolumes := True;
end;

procedure TFrmRelMapaSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  EdtPedidoIdInicial.SetFocus;
end;

procedure TFrmRelMapaSeparacao.Imprimir;
Var pNotificationPrint  : Boolean;
    xVolumes, xItens    : Integer;
    ReturnJsonArray     : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vErro               : String;
begin
  pNotificationPrint := True;
  If pNotificationPrint then Begin
     Confirmacao('Mapa Separação', 'Prepare a impressora.', False);
     pNotificationPrint := False;
  End;
//  inherited;
  For xVolumes := 1 to Pred(LstReport.RowCount) do Begin
    if LstReport.Cells[0, xVolumes].ToInteger() = 5 then Begin
      ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
      ReturnJsonArray     := ObjPedidoVolumeCtrl.MapaSeparacao(LstReport.Cells[0, xVolumes].ToInteger(), 0);
      if ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin
         ShowErro('Erro: Volume: '+LstReport.Cells[0, xVolumes]+' '+vErro);
      End
      Else Begin
        QryMapaSeparacao.Close;
        QryMapaSeparacao.CreateDataSet;
        QryMapaSeparacao.Open;
        For xItens := 0 to Pred(ReturnJsonArray.Count) do Begin
          QryMapaSeparacao.Append;
          QryMapaSeparacao.FieldByName('PedidoId').AsInteger        := ReturnJsonArray.Items[xItens].GetValue<Integer>('pedidoid');
          QryMapaSeparacao.FieldByName('Data').AsDateTime           := StrToDate(ReturnJsonArray.Items[xItens].GetValue<String>('data'));
          QryMapaSeparacao.FieldByName('PedidoVolumeId').AsInteger  := ReturnJsonArray.Items[xItens].GetValue<Integer>('pedidovolumeid');
          QryMapaSeparacao.FieldByName('Sequencia').AsInteger       := ReturnJsonArray.Items[xItens].GetValue<Integer>('sequencia');
          //QryMapaSeparacao.FieldByName('Embalagem').AsString        := ReturnJsonArray.Items[xVolumes].GetValue<String>('embalagem');
          QryMapaSeparacao.FieldByName('PessoaId').AsInteger        := ReturnJsonArray.Items[xItens].GetValue<Integer>('pessoaid');
          QryMapaSeparacao.FieldByName('CodPessoaERP').AsInteger    := ReturnJsonArray.Items[xItens].GetValue<Integer>('codpessoaerp');
          QryMapaSeparacao.FieldByName('Razao').AsString            := ReturnJsonArray.Items[xItens].GetValue<String>('razao');
          QryMapaSeparacao.FieldByName('RotaId').AsInteger          := ReturnJsonArray.Items[xItens].GetValue<Integer>('rotaid');
          QryMapaSeparacao.FieldByName('RotaDescricao').AsString    := ReturnJsonArray.Items[xItens].GetValue<String>('rotadescricao');
          QryMapaSeparacao.FieldByName('Endereco').AsString         := EnderecoMask(ReturnJsonArray.Items[xItens].GetValue<String>('endereco'), ReturnJsonArray.Items[xItens].GetValue<String>('mascara'), True);
          //QryMapaSeparacao.FieldByName('Endereco').AsString         := ReturnJsonArray.Items[xVol](xVol).GetValue<String>('endereco');
          QryMapaSeparacao.FieldByName('Zona').AsString             := ReturnJsonArray.Items[xItens].GetValue<String>('zona');
          QryMapaSeparacao.FieldByName('DescrLote').AsString        := ReturnJsonArray.Items[xItens].GetValue<String>('descrlote');
          QryMapaSeparacao.FieldByName('Vencimento').AsDatetime     := StrToDate(ReturnJsonArray.Items[xItens].GetValue<String>('vencimento'));
          QryMapaSeparacao.FieldByName('Produtoid').AsInteger       := ReturnJsonArray.Items[xItens].GetValue<Integer>('produtoid');
          QryMapaSeparacao.FieldByName('CodProduto').AsInteger       := ReturnJsonArray.Items[xItens].GetValue<Integer>('codproduto');
          QryMapaSeparacao.FieldByName('ProdutoDescricao').AsString := ReturnJsonArray.Items[xItens].GetValue<String>('produtodescricao');
          QryMapaSeparacao.FieldByName('Ean').AsString              := ReturnJsonArray.Items[xItens].GetValue<String>('ean');
          QryMapaSeparacao.FieldByName('Quantidade').AsInteger      := ReturnJsonArray.Items[xItens].GetValue<Integer>('quantidade');
          if ReturnJsonArray.Items[xItens].GetValue<String>('unidade') = 'Un' then
             QryMapaSeparacao.FieldByName('Unidade').AsString       := ReturnJsonArray.Items[xItens].GetValue<String>('unidade')
          Else QryMapaSeparacao.FieldByName('Unidade').AsString     := 'Cx('+trim(FormatFloat('####', ReturnJsonArray.Items[xItens].GetValue<Integer>('quantidade') /
                                                                                ReturnJsonArray.Items[xItens].GetValue<Integer>('embalagempadrao') ))  +')';
          QryMapaSeparacao.FieldByName('embalagempadrao').AsInteger := ReturnJsonArray.Items[xItens].GetValue<Integer>('embalagempadrao');
          QryMapaSeparacao.FieldByName('VolumeTipo').AsString       := ReturnJsonArray.Items[xItens].GetValue<String>('volumetipo');
        End;
        frxPDFExport1.Title    := 'Mapa Separacao_'+QryMapaSeparacao.FieldByName('Sequencia').AsString;
        frxPDFExport1.DefaultPath := ExtractFilePath(ParamStr(0))+'\Relatorio';
        frxPDFExport1.FileName := 'Mapa Separacao_'+QryMapaSeparacao.FieldByName('PedidoVolumeId').AsString+'_'+QryMapaSeparacao.FieldByName('Sequencia').AsString+'.Pdf';
        frxPDFExport1.ShowDialog := False;
        frxPDFExport1.ShowProgress := False;
        frxPDFExport1.OverwritePrompt := False;
        if ChkImprimirPDF.Checked then Begin
           frxReport1.PrepareReport();
           frxReport1.Export(frxPDFExport1);;
        End
        Else Begin
           frxReport1.PrepareReport();
           frxReport1.PrintOptions.ShowDialog := False;
           FrxReport1.Print;
        End;
      End;
      FreeAndNil(ObjPedidoVolumeCtrl);
    End;
  End;
end;

procedure TFrmRelMapaSeparacao.Limpar;
begin
  LimparLstAdvReport;
  EdtInicio.Enabled                := True;
  EdtTermino.Enabled                := True;
  EdtPedidoIdInicial.Enabled       := True;
  EdtPedidoIdFinal.Enabled         := True;
  EdtRotaId.Enabled                := True;
  EdtDestinatario.Enabled          := True;
  EdtPedidoVolumeIdInicial.Enabled := True;
  EdtPedidoVolumeIdFinal.Enabled   := True;
  EdtInicio.Clear;
  EdtTermino.Clear;
  EdtPedidoIdInicial.Clear;
  EdtPedidoIdFinal.Clear;
  EdtRotaId.Clear;
  EdtDestinatario.Clear;
  EdtPedidoVolumeIdInicial.Clear;
  EdtPedidoVolumeIdFinal.Clear;
  LblVolumeProceso.Caption := '';
  if not (QryMapaSeparacao.Active) then
     QryMapaSeparacao.Open;
  QryMapaSeparacao.EmptyDataSet;
  BtnImprimirStand.Grayed  := True;
  BtnImprimirStand.Enabled := False;
  EdtPedidoIdInicial.SetFocus;
  PrintGeral := False;
end;

procedure TFrmRelMapaSeparacao.LstCadastroClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmRelMapaSeparacao.LstCadastroDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  inherited;

end;

procedure TFrmRelMapaSeparacao.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
begin
//  inherited;

end;

procedure TFrmRelMapaSeparacao.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
//  inherited;

end;

procedure TFrmRelMapaSeparacao.LstCadastroRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
//  inherited;

end;

procedure TFrmRelMapaSeparacao.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xSel : Integer;
    pNotificationPrint  : Boolean;
    xVolumes, xItens    : Integer;
    ReturnJsonArray     : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vErro               : String;
begin
  if (aCol <> 10) or (aRow=0) or (LstReport.Cells[10, aRow]='6') then Exit;
  pNotificationPrint := True;
  If (pNotificationPrint) and (Not PrintGeral) then Begin
     Confirmacao('Mapa Separação' , 'Vol: '+LstReport.Cells[4, aRow]+'. Prepare a impressora.', False);
     pNotificationPrint := False;
  End;
  inherited;
  if LstReport.Cells[10, aRow].ToInteger() = 5 then Begin
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    ReturnJsonArray     := ObjPedidoVolumeCtrl.MapaSeparacao(LstReport.Cells[0, aRow].ToInteger(), LstReport.Cells[4, aRow].ToInteger());
    if ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Erro: Volume: '+LstReport.Cells[4, xVolumes]+' '+vErro);
    End
    Else Begin
      QryMapaSeparacao.Close;
      QryMapaSeparacao.CreateDataSet;
      QryMapaSeparacao.Open;
      For xItens := 0 to Pred(ReturnJsonArray.Count) do Begin
        QryMapaSeparacao.Append;
        QryMapaSeparacao.FieldByName('PedidoId').AsInteger        := ReturnJsonArray.Items[xItens].GetValue<Integer>('pedidoid');
        QryMapaSeparacao.FieldByName('Data').AsDateTime           := StrToDate(ReturnJsonArray.Items[xItens].GetValue<String>('data'));
        QryMapaSeparacao.FieldByName('PedidoVolumeId').AsInteger  := ReturnJsonArray.Items[xItens].GetValue<Integer>('pedidovolumeid');
        QryMapaSeparacao.FieldByName('Sequencia').AsInteger       := ReturnJsonArray.Items[xItens].GetValue<Integer>('sequencia');
        //QryMapaSeparacao.FieldByName('Embalagem').AsString        := ReturnJsonArray.Items[xItens].GetValue<String>('embalagem');
        QryMapaSeparacao.FieldByName('PessoaId').AsInteger        := ReturnJsonArray.Items[xItens].GetValue<Integer>('pessoaid');
        QryMapaSeparacao.FieldByName('CodPessoaERP').AsInteger    := ReturnJsonArray.Items[xItens].GetValue<Integer>('codpessoaerp');
        QryMapaSeparacao.FieldByName('Razao').AsString            := ReturnJsonArray.Items[xItens].GetValue<String>('razao');
        QryMapaSeparacao.FieldByName('RotaId').AsInteger          := ReturnJsonArray.Items[xItens].GetValue<Integer>('rotaid');
        QryMapaSeparacao.FieldByName('RotaDescricao').AsString    := ReturnJsonArray.Items[xItens].GetValue<String>('rotadescricao');
        QryMapaSeparacao.FieldByName('Endereco').AsString         := EnderecoMask(ReturnJsonArray.Items[xItens].GetValue<String>('endereco'), ReturnJsonArray.Items[xItens].GetValue<String>('mascara'), True);
        //QryMapaSeparacao.FieldByName('Endereco').AsString         := ReturnJsonArray.Items[xItens](xItens).GetValue<String>('endereco');
        QryMapaSeparacao.FieldByName('Zona').AsString             := ReturnJsonArray.Items[xItens].GetValue<String>('zona');
        QryMapaSeparacao.FieldByName('DescrLote').AsString        := ReturnJsonArray.Items[xItens].GetValue<String>('descrlote');
        QryMapaSeparacao.FieldByName('Vencimento').AsDatetime     := StrToDate(ReturnJsonArray.Items[xItens].GetValue<String>('vencimento'));
        QryMapaSeparacao.FieldByName('Produtoid').AsInteger       := ReturnJsonArray.Items[xItens].GetValue<Integer>('produtoid');
        QryMapaSeparacao.FieldByName('CodProduto').AsInteger       := ReturnJsonArray.Items[xItens].GetValue<Integer>('codproduto');
        QryMapaSeparacao.FieldByName('ProdutoDescricao').AsString := ReturnJsonArray.Items[xItens].GetValue<String>('produtodescricao');
        QryMapaSeparacao.FieldByName('Ean').AsString              := ReturnJsonArray.Items[xItens].GetValue<String>('ean');
        QryMapaSeparacao.FieldByName('Quantidade').AsInteger      := ReturnJsonArray.Items[xItens].GetValue<Integer>('quantidade');
        if ReturnJsonArray.Items[xItens].GetValue<String>('unidade') = 'Un' then
           QryMapaSeparacao.FieldByName('Unidade').AsString       := ReturnJsonArray.Items[xItens].GetValue<String>('unidade')
        Else QryMapaSeparacao.FieldByName('Unidade').AsString     := 'Cx('+trim(FormatFloat('####', ReturnJsonArray.Items[xItens].GetValue<Integer>('quantidade') /
                                                                              ReturnJsonArray.Items[xItens].GetValue<Integer>('embalagempadrao') ))  +')';
        QryMapaSeparacao.FieldByName('embalagempadrao').AsInteger := ReturnJsonArray.Items[xItens].GetValue<Integer>('embalagempadrao');
        QryMapaSeparacao.FieldByName('VolumeTipo').AsString       := ReturnJsonArray.Items[xItens].GetValue<String>('volumetipo');
      End;
      frxPDFExport1.Title    := 'Mapa Separacao_'+QryMapaSeparacao.FieldByName('Sequencia').AsString;
      frxPDFExport1.DefaultPath := ExtractFilePath(ParamStr(0))+'\Relatorio';
      frxPDFExport1.FileName := 'Mapa Separacao_'+QryMapaSeparacao.FieldByName('PedidoVolumeId').AsString+'_'+QryMapaSeparacao.FieldByName('Sequencia').AsString+'.Pdf';
      frxPDFExport1.ShowDialog := False;
      frxPDFExport1.ShowProgress := False;
      frxPDFExport1.OverwritePrompt := False;
      if ChkImprimirPDF.Checked then Begin
         frxReport1.PrepareReport();
         frxReport1.Export(frxPDFExport1);;
      End
      Else Begin
         frxReport1.PrepareReport();
         frxReport1.PrintOptions.ShowDialog := False;
         FrxReport1.Print;
      End;
    End;
    FreeAndNil(ObjPedidoVolumeCtrl);
    ShowOk('Mapa de Serapação impresso.');
  End;
end;

procedure TFrmRelMapaSeparacao.MontaListaVolumes;
var xVolume : Integer;
begin
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  BtnExportarStand.Enabled := False;
  BtnExportarStand.Grayed  := True;
  LstReport.RowCount       := FdMemPesqGeral.RecordCount+1;
  FdMemPesqGeral.First;
  LstReport.FixedRows := 1;
  for xVolume := 1 to FdMemPesqGeral.RecordCount do
    LstReport.AddDataImage(10, xVolume, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xVolume := 1;
  while Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[ 0, xVolume]     := FdMemPesqGeral.FieldByName('PedidoId').AsString;
    LstReport.Cells[ 1, xVolume]     := FdMemPesqGeral.FieldByName('DocumentoData').AsString;
    LstReport.Cells[ 2, xVolume]     := FdMemPesqGeral.FieldByName('Razao').AsString;
    LstReport.Cells[ 3, xVolume]     := FdMemPesqGeral.FieldByName('Rota').AsString;
    LstReport.Cells[ 4, xVolume]     := FdMemPesqGeral.FieldByName('PedidoVolumeId').AsString;
    LstReport.Cells[ 5, xVolume]     := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Cells[ 6, xVolume]     := FdMemPesqGeral.FieldByName('RuaId').AsString+' '+FdMemPesqGeral.FieldByName('Rua').AsString;
    LstReport.Cells[ 7, xVolume]     := FdMemPesqGeral.FieldByName('Zona').AsString;
    LstReport.Cells[ 8, xVolume]     := FdMemPesqGeral.FieldByName('PredioInicial').AsString;
    LstReport.Cells[ 9, xVolume]     := FdMemPesqGeral.FieldByName('processo').AsString;
    if FdMemPesqGeral.FieldByName('ProcessoId').AsInteger < 13 then
       LstReport.Cells[10, xVolume]     := '5'
    Else LstReport.Cells[10, xVolume]     := '6';
    LstReport.Cells[11, xVolume]     := FdMemPesqGeral.FieldByName('processoId').AsString;
    LstReport.Alignments[ 0, xVolume] := taRightJustify;
    LstReport.FontStyles[ 0, xVolume] := [FsBold];
    LstReport.Alignments[ 4, xVolume] := taRightJustify;
    LstReport.Alignments[ 8, xVolume] := taCenter;
    LstReport.Alignments[10, xVolume] := taCenter;
    FdMemPesqGeral.Next;
    Inc(xVolume);
  End;
  BtnImprimirStand.Enabled := True;
  BtnImprimirStand.Grayed  := False;
  BtnExportarStand.Enabled := True;
  BtnExportarStand.Grayed  := False;
end;

procedure TFrmRelMapaSeparacao.PesquisarDados;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    ReturnJsonArray : tjsonArray;
    vErro, vData    : String;
    pDtPedidoInicial, pDtPedidoFinal : TDateTime;
begin
  if (EdtInicio.Text='  /  /    ') and (EdtTermino.Text='  /  /    ') and
     (StrToIntDef(EdtPedidoIdInicial.Text,0)<=0) and (StrToIntDef(EdtPedidoIdFinal.Text,0)<=0) and
     (StrToIntDef(EdtRotaId.Text,0)<=0) and (StrToIntDef(EdtDestinatario.Text, 0)<=0) And
     (StrToIntDef(EdtPedidoVolumeIdInicial.Text, 0)<=0) and (StrToIntDef(EdtPedidoVolumeIdFinal.Text, 0)<=0) then Begin
      ShowMessage('Informe o filtro para pesquisa!');
      Exit
     End;
  inherited;
  PrintGeral := False;
  TDialogMessage.ShowWaitMessage('Aguarde!!! Buscando dados...',
  procedure
  Var xVol : Integer;
  begin
  Try
    If EdtInicio.Text = '  /  /    ' then
       pDtPedidoInicial := 0
    Else pDtPedidoInicial :=StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       pDtPedidoFinal := 0
    Else pDtPedidoFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
  End;
  if (pDtPedidoInicial <> 0) and (pDtPedidoFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    ReturnJsonArray := ObjPedidoVolumeCtrl.GetMapaSeparacaoLista(StrToIntDef(EdtPedidoIdInicial.Text, 0),
                       StrToIntDef(EdtPedidoIdFinal.Text, 0), StrToIntDef(EdtPedidoVolumeIdInicial.Text, 0),
            StrToIntDef(EdtPedidoVolumeIdFinal.Text, 0), StrToIntDef(EdtRotaId.Text, 0),
            StrToIntDef(EdtDestinatario.Text, 0), pDtPedidoInicial, pDtPedidoFinal);
    if ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin
       If Assigned(ReturnJsonArray) Then
          ReturnJsonArray := Nil;
       ObjPedidoVolumeCtrl.Free;
       ShowErro(vErro);
       Exit;
    End;
    FdMemPesqGeral.Close;
    FdMemPesqGeral.CreateDataSet;
    FdMemPesqGeral.Open;
    For xVol := 0 to Pred(ReturnJsonArray.Count) do Begin
      FdMemPesqGeral.Append;
      FdMemPesqGeral.FieldByName('PedidoId').AsInteger       := ReturnJsonArray.Items[xVol].GetValue<Integer>('pedidoid');
      vData := ReturnJsonArray.Items[xVol].GetValue<String>('documentodata');
      FdMemPesqGeral.FieldByName('DocumentoData').AsDateTime := StrToDate(Copy(vdata, 9, 2)+'/'+Copy(vData, 6, 2)+'/'+Copy(vData, 1, 4));
      FdMemPesqGeral.FieldByName('Razao').AsString           := ReturnJsonArray.Items[xVol].GetValue<String>('fantasia');
      FdMemPesqGeral.FieldByName('Rota').AsString            := ReturnJsonArray.Items[xVol].GetValue<String>('rota');
      FdMemPesqGeral.FieldByName('PedidoVolumeId').AsInteger := ReturnJsonArray.Items[xVol].GetValue<Integer>('pedidovolumeid');
      FdMemPesqGeral.FieldByName('Embalagem').AsString       := ReturnJsonArray.Items[xVol].GetValue<String>('embalagem');
      FdMemPesqGeral.FieldByName('RuaId').AsInteger          := ReturnJsonArray.Items[xVol].GetValue<Integer>('ruaid');
      FdMemPesqGeral.FieldByName('Rua').AsString             := ReturnJsonArray.Items[xVol].GetValue<String>('rua');
      FdMemPesqGeral.FieldByName('Zona').AsString            := ReturnJsonArray.Items[xVol].GetValue<String>('zona');
      FdMemPesqGeral.FieldByName('PredioInicial').AsString   := ReturnJsonArray.Items[xVol].GetValue<String>('predioinicial');
      FdMemPesqGeral.FieldByName('ProcessoId').AsInteger     := ReturnJsonArray.Items[xVol].GetValue<integer>('processoid');
      FdMemPesqGeral.FieldByName('Processo').AsString        := ReturnJsonArray.Items[xVol].GetValue<String>('processo');
    End;
    FdMemPesqGeral.Post;
    MontaListaVolumes;
    ReturnJsonArray := Nil;
    ObjPedidoVolumeCtrl.Free;
  End);
end;

end.
