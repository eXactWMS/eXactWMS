unit uFrmRelTagProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, Generics.Collections,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, System.Json, Rest.Types,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, IniFiles,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,  DataSet.Serialize,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, Vcl.Buttons, JvToolEdit, Vcl.DBGrids, ACBrBase, ACBrETQ, ACBrDevice,
  Vcl.ComCtrls, dxCameraControl;

type
  TFrmRelTagProduto = class(TFrmReportBase)
    GroupBox2: TGroupBox;
    Label7: TLabel;
    EdtPedidoId: TJvComboEdit;
    EdtDocumentoNr: TJvComboEdit;
    Label2: TLabel;
    EdtRegistroERP: TJvComboEdit;
    Label3: TLabel;
    EdtDocumentoData: TJvDateEdit;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    EdtDtFinalizacao: TJvDateEdit;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    EdtCodigoERP: TJvComboEdit;
    BtnPesqProduto: TBitBtn;
    LblProduto: TLabel;
    grpEntradas: TGroupBox;
    DbgEtqControlados: TDBGrid;
    ImgPrint: TImageList;
    imgAtivo: TImageList;
    DsEtiquetaPrint: TDataSource;
    FdMemPesqGeralImpr: TIntegerField;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralDocumentoData: TDateField;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralCodigoERP: TIntegerField;
    FdMemPesqGeralPicking: TStringField;
    FdMemPesqGeralMascara: TStringField;
    FdMemPesqGeralLoteId: TIntegerField;
    FdMemPesqGeralDescrLote: TStringField;
    FdMemPesqGeralVencimento: TDateField;
    FdMemPesqGeralQtdCheckIn: TIntegerField;
    FdMemPesqGeralDescrProduto: TStringField;
    ACBrETQ: TACBrETQ;
    ChkForcarSalto: TCheckBox;
    ChkTagProduto: TCheckBox;
    FdMemPesqGeralPrintEtqControlado: TIntegerField;
    procedure DbgEtqControladosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtDtFinalizacaoChange(Sender: TObject);
    procedure EdtCodigoERPKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodigoERPExit(Sender: TObject);
    procedure DbgEtqControladosCellClick(Column: TColumn);
    procedure DbgEtqControladosTitleClick(Column: TColumn);
  private
    { Private declarations }
    pCodigoERP : Integer;
    pSelectColumn : Boolean;
    procedure ConfigACBrETQ;
  public
    { Public declarations }
  end;

var
  FrmRelTagProduto: TFrmRelTagProduto;

implementation

{$R *.dfm}

uses uFuncoes, EntradaItensCtrl, Views.Pequisa.Produtos, ProdutoCtrl,
  uFrmeXactWMS, TypInfo, ACBrETQClass;

procedure TFrmRelTagProduto.BtnImprimirStandClick(Sender: TObject);
Var X, vPosEtq, vQtdEtiq : Integer;
    TextProd : String;
    pColIni1, pColIni2, pColIni3 : Integer;
    Erro, CancelarImpressao : Boolean;
    ArrayJsonProduto    : TJsonArray;
    ObjEntradaItensCtrl : TEntradaItensCtrl;
    vErro               : String;
begin
  //inherited;
  pColIni1 := 0;
  pColIni2 := 0;
  pColIni3 := 0;
  if FdMemPesqGeral.IsEmpty then
     raise Exception.Create('Não há dados para impressão!');
  vPosEtq  := 1;
  ACBrETQConfig.Desativar;
  ConfigACBrETQ;
  ACBrETQConfig.DPI           := TACBrETQDPI(1);

  AcbrEtqConfig.Temperatura   := 10;
  AcbrEtqConfig.LimparMemoria := True;
  with ACBrETQConfig do Begin
     Ativar;

     if Not device.EmLinha() then
        raise Exception.Create('ocorreu um erro na impressora.');
     FdMemPesqGeral.Filter   := 'Impr = 1';
     FdMemPesqGeral.Filtered := True;
     FdMemPesqGeral.First;
     if FdMemPesqGeral.IsEmpty then Begin
        FdMemPesqGeral.Filtered := False;
        raise Exception.Create('Selecione itens para impressão de Etiquetas.');
     End;
     vQtdEtiq := 1;
     while (Not FdMemPesqGeral.Eof) do Begin
       for X := 1 to FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger do Begin
         Erro := True;
         CancelarImpressao := False;
         While Erro do Begin
           Erro := False;
           if Not device.EmLinha() then Begin
              If Application.MessageBox(pWideChar('Continuar impressão?'), 'Erro na Impressora!',
                                   MB_ICONQUESTION + MB_YESNO) = mrYes then
                 Erro := True
              Else
                 CancelarImpressao := True;;
           End
         End;
         If CancelarImpressao then
            Break;
         Inc(vQtdEtiq);
         case vPosEtq of
           1: Begin
//              IniciarEtiqueta;
              TextProd := FdMemPesqGeral.FieldByName('CodigoERP').Asstring+' '+FdMemPesqGeral.FieldByName('DescrProduto').Asstring;
              ImprimirTexto(orNormal, 1, 1, 1,           0, 2, Copy(TextProd, 1, 23)); //'Farmácias INDIANA');
              ImprimirTexto(orNormal, 1, 1, 1,           1, 2, Copy(TextProd, 24, 23));
              ImprimirBarras(orNormal, barCODE128, 2, 1, 2, 2, FdMemPesqGeral.FieldByName('DescrLote').Asstring, 4, becNAO);
              ImprimirTexto(orNormal, 2, 1, 1,           7, 2, FdMemPesqGeral.FieldByName('DescrLote').Asstring); //105
              inc(vPosEtq);
           End;
           2: begin
              TextProd := FdMemPesqGeral.FieldByName('CodigoERP').Asstring+' '+FdMemPesqGeral.FieldByName('DescrProduto').Asstring;
              ImprimirTexto(orNormal, 1, 1, 1,            0, 26, Copy(TextProd, 1, 23)); //'Farmácias INDIANA');
              ImprimirTexto(orNormal, 1, 1, 1,            1, 26, Copy(TextProd, 24, 23));
              ImprimirBarras(orNormal, barCODE128, 2, 1,  2, 26, FdMemPesqGeral.FieldByName('DescrLote').Asstring, 4, becNAO);
              ImprimirTexto(orNormal, 2, 1, 1,            7, 26, FdMemPesqGeral.FieldByName('DescrLote').Asstring); //105
              inc(vPosEtq);
           End;
           3: Begin
              TextProd := FdMemPesqGeral.FieldByName('CodigoERP').Asstring+' '+FdMemPesqGeral.FieldByName('DescrProduto').Asstring;
              ImprimirTexto(orNormal, 1, 1, 1,            0, 49, Copy(TextProd, 1, 23)); //'Farmácias INDIANA');
              ImprimirTexto(orNormal, 1, 1, 1,            1, 49, Copy(TextProd, 24, 23));
              ImprimirBarras(orNormal, barCODE128, 2, 1,  2, 49, FdMemPesqGeral.FieldByName('DescrLote').Asstring, 4, becNAO);
              ImprimirTexto(orNormal, 2, 1, 1,            7, 49, FdMemPesqGeral.FieldByName('DescrLote').Asstring); //105
              inc(vPosEtq);
           End;
         end;
         if (((vQtdEtiq Div 50)*1)=vQtdEtiq) and (vQtdEtiq Div 50 > 1)then
            Sleep(150);
         if (vPosEtq > 3) then Begin
            FinalizarEtiqueta;//(1, 5);
            Imprimir(1, 0); //5);
            vPosEtq := 1;
            //Break;
         End;
       End;
//Registrar a Impressão das etiquetas
//       TEntrada.SavePrinEtqSNGPC(CdsEtqControlados.FieldByName('CdEntrada').AsInteger, CdsEtqControlados.FieldByName('CdLote').AsInteger);
       if Not ChkTagProduto.Checked then Begin
          ObjEntradaItensCtrl := TEntradaItensCtrl.Create;
          ArrayJsonProduto    := ObjEntradaItensCtrl.RegPrintEtqProduto(FdMemPesqGeral.FieldByname('PedidoId').AsInteger, FdMemPesqGeral.FieldByname('LoteId').AsInteger);
          if Not ArrayJsonProduto.TryGetValue('Erro', vErro) then Begin
             FdMemPesqGeral.Edit;
             FdMemPesqGeral.FieldByname('PrintEtqControlado').AsInteger := 1;
             FdMemPesqGeral.Next;
          End;
          ArrayJsonProduto := Nil;
          ObjEntradaItensCtrl.Free;
       End
       Else Begin
          FdMemPesqGeral.Edit;
          FdMemPesqGeral.FieldByname('PrintEtqControlado').AsInteger := 1;
          FdMemPesqGeral.Next;
       End;
       if (FdMemPesqGeral.Eof) and (vPosEtq<>1) then Begin
          FinalizarEtiqueta;//(1, 5);
          Imprimir(1, 0);
       End;
       //Forcar salto de Etiqueta
       if ChkForcarSalto.Checked then Begin
          ImprimirTexto(orNormal, 1, 1, 1, 2,  2, '  '); //'Farmácias INDIANA');
          ImprimirTexto(orNormal, 1, 1, 1, 3, 2, '  ');
//          ImprimirTexto(orNormal, 1, 1, 2, 80, pColIni1+10,  '  '); //105
          FinalizarEtiqueta;//(1, 5);
          Imprimir(1, 0);
       End;
       vPosEtq := 1;
     End;
     //if (CdsEtqControlados.Eof) and (vPosEtq<>1) then Begin
     //   FinalizarEtiqueta(1, 5);
     //   Imprimir(1, 5);
     //End;
     FdMemPesqGeral.Filter   := 'Impr = 1';
     FdMemPesqGeral.Filtered := False;
     ShowMessage('Etiquetas impressas com sucesso!');
  end;
end;

procedure TFrmRelTagProduto.BtnPesqProdutoClick(Sender: TObject);
var LForm: TFrmPesquisaProduto;
    ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  if EdtCodigoERP.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then  Begin
       EdtCodigoERP.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodigoERPExit(EdtCodigoERP);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelTagProduto.BtnPesquisarStandClick(Sender: TObject);
Var ArrayJsonProduto : TJsonArray;
    ObjEntradaProdutoCtrl   : TEntradaItensCtrl;
    vErro             : String;
    xRetorno          : Integer;
    pDtDocumentoData, pDtCheckInFinalizacao : TDateTime;
begin
//  inherited;
  if (EdtPedidoId.Text='') and (EdtDocumentoNr.Text='') and (EdtDocumentoData.Text='  /  /    ') and
     (EdtRegistroERP.Text='') and (EdtDtFinalizacao.Text='  /  /    ') and (EdtCodigoERP.Text='') then Begin
     ShowErro('🙋🏼‍♀ Informe ao menos um parâmetro para pesquisar.');
     EdtPedidoId.SetFocus;
     exit;
  End;
  Try
    If EdtDocumentoData.Text = '  /  /    ' then
       pDtDocumentoData := 0
    Else pDtDocumentoData :=StrToDate(EdtDocumentoData.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data do documento inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtFinalizacao.Text = '  /  /    ' then
       pDtCheckInFinalizacao := 0
    Else pDtCheckInFinalizacao :=StrToDate(EdtDtFinalizacao.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data do documento inválida!'+#13+#10+E.Message);
  End;
  if (EdtCodigoERP.Text<>'') and (LblProduto.Caption = '...') then Begin
     EdtCodigoERPExit(EdtCodigoERP);
     If LblProduto.Caption = '...' then
        Exit;
  End;
  if (EdtCodigoERP.Text<>'') and (StrToInt64Def(EdtCodigoERP.Text, 0) <= 0) then Begin
     EdtCodigoERP.SetFocus;
     ShowErro('Código('+EdtCodigoERP.Text+') de Produto inválido!');
     EdtCodigoERP.Clear;
     Exit;
  End;
  if (EdtPedidoId.Text<>'') and (StrToInt64Def(EdtPedidoId.Text, 0) <= 0) then Begin
     EdtPedidoId.SetFocus;
     ShowErro('Id('+EdtPedidoId.Text+') do Pedido inválido!');
     EdtPedidoId.Clear;
     Exit;
  End;
  if (EdtDocumentoNR.Text<>'') and (StrToInt64Def(EdtDocumentoNR.Text, 0) <= 0) then Begin
     EdtDocumentoNR.SetFocus;
     ShowErro('Documento('+EdtDocumentoNR.Text+') inválido!');
     EdtDocumentoNR.Clear;
     Exit;
  End;
  ObjEntradaProdutoCtrl := TEntradaItensCtrl.Create;
  ArrayJsonProduto := ObjEntradaProdutoCtrl.GetProdutoTag(StrToIntDef(EdtPedidoId.Text, 0), EdtDocumentoNr.Text,
                           pDtDocumentoData, EdtRegistroERP.Text, pDtCheckInFinalizacao, pCodigoERP, ChkTagProduto.Checked);
  if ArrayJsonProduto.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
  End
  Else Begin
     If FdMemPesqGeral.Active then
        FdmemPesqGeral.EmptyDataSet;
     FdMemPesqGeral.Close;
     FdMemPesqGeral.LoadFromJSON(ArrayJsonProduto, False);
     if Not FdMemPesqGeral.IsEmpty then begin
        BtnImprimirStand.Enabled := True;
        BtnImprimirStand.Grayed  := False;
        FdMemPesqGeral.First;
        With FdMemPesqGeral do While Not Eof do Begin
          Edit;
          //WriteAguarde('Selecionando: '+CdsPesqEtqControlados.RecNo.ToString()+' de '+CdsPesqEtqControlados.RecordCount.ToString());
          if Length(FieldByName('DescrLote').AsString) <= 15 then
             FieldByName('Impr').AsInteger  := 1;
          Next;
        End;
        FdMemPesqGeral.First;
        pSelectColumn := True;
     end;
  End;
  ObjEntradaProdutoCtrl.DisposeOf;
end;

procedure TFrmRelTagProduto.ConfigACBrETQ;
var vlIni: TIniFile;
begin
  vlIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.ini');
  try
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra := CbModeloConfigPrinter.Text;
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra  := CbPortaConfigPrinter.Text;
    CbModeloConfigPrinter.ItemIndex := CbModeloConfigPrinter.Items.IndexOf(vlIni.ReadString('PRINTER', 'EtqCodBarra_Modelo', FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra));
    CbPortaConfigPrinter.ItemIndex := CbPortaConfigPrinter.Items.IndexOf(vlIni.ReadString('PRINTER',  'EtqCodBarra_Porta' , FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra));
  finally
    vlIni.Free;
  end;

  with ACBrETQConfig do
  begin
     Desativar;
     DPI           := TACBrETQDPI(2);
     LimparMemoria := True;
     Temperatura   := 10;
     Velocidade    := -1;
     BackFeed      := TACBrETQBackFeed(-1);
     Unidade       := etqMilimetros; //etqDecimoDeMilimetros;
     MargemEsquerda:= 0;
     Origem        := TACBrETQOrigem(1); //cbOrigem.ItemIndex);
     PaginaDeCodigo:= TACBrETQPaginaCodigo(2);
     Porta         := CbPortaConfigPrinter.Text;
     Modelo        := TACBrETQModelo(CbModeloConfigPrinter.ItemIndex);
  end;
end;

procedure TFrmRelTagProduto.DbgEtqControladosCellClick(Column: TColumn);
begin
  inherited;
  if Length(FdMemPesqGeral.FieldByName('DescrLote').AsString) <= 15 then Begin
     if Column.FieldName = 'Impr' then Begin
        if FdMemPesqGeral.FieldByName('Impr').AsInteger = 0 then
           SelecionarRegistroFdMem(FdMemPesqGeral, 'impr')
        Else if FdMemPesqGeral.FieldByName('Impr').AsInteger = 1 then
           SelecionarRegistroFdMem(FdMemPesqGeral, 'impr');
     End;
  End;
end;

procedure TFrmRelTagProduto.DbgEtqControladosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    if Length(FdMemPesqGeral.FieldByName('DescrLote').AsString) > 15 then Begin
       Canvas.Brush.Color := $008080FF // Pedido não finalizado
    End
    Else begin
       If (FdMemPesqGeral.RecNo Mod 2 = 0) then   //Query dos itens
          Canvas.Brush.Color := $00F5EFE7 // Pedido não finalizado
       Else  Canvas.Brush.Color := $00FFCF9F;; //Pedido Finalizado
    End;
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
  if (Column.FieldName = 'Impr') then
      ExibirCheckBox(Column, DbgEtqControlados, ImgAtivo, Rect);
  if (Column.FieldName = 'PrintEtqControlado') then
      ExibirCheckBox(Column, DbgEtqControlados, ImgPrint, Rect);
end;

procedure TFrmRelTagProduto.DbgEtqControladosTitleClick(Column: TColumn);
begin
  inherited;
  if Column.Field.Name = 'FdMemPesqGeralImpr' then Begin
     DsEtiquetaPrint.DataSet := nil;
     FdMemPesqGeral.First;
     while Not FdMemPesqGeral.Eof do Begin
       FdMemPesqGeral.Edit;
       if (pSelectColumn) Then
          FdMemPesqGeral.FieldByName('Impr').AsInteger  := 0
       Else
          If (Length(FdMemPesqGeral.FieldByName('DescrLote').AsString) <= 15) then
             FdMemPesqGeral.FieldByName('Impr').AsInteger  := 1;
       FdMemPesqGeral.Post;
       FdMemPesqGeral.Next;
     End;
     FdMemPesqGeral.First;
     pSelectColumn := Not pSelectColumn;
     DsEtiquetaPrint.DataSet := FdMemPesqGeral;
  End;
end;

procedure TFrmRelTagProduto.EdtCodigoERPExit(Sender: TObject);
Var ObjProdutoCtrl    : TProdutoCtrl;
    JsonArrayRetorno  : TJsonArray;
    JsonObjectProduto : TJsonObject;
    vErro             : String;
begin
  if (EdtCodigoERP.Text<>'') and (StrToInt64Def(EdtCodigoERP.Text, 0) <= 0) then Begin
     EdtCodigoERP.SetFocus;
     ShowErro('Código de Produto inválido!');
     EdtCodigoERP.Clear;
     Exit;
  End;
  inherited;
  pCodigoERP := 0;
  if EdtCodigoERP.Text = '' then Exit;
  ObjProdutoCtrl   := TProdutoCtrl.Create;
  JsonObjectProduto := TProdutoCtrl.GetEan(EdtCodigoERP.Text);
  if JsonObjectProduto.TryGetValue<String>('Erro', vErro) then Begin
     EdtCodigoERP.Clear;
     EdtCodigoERP.SetFocus;
     ShowErro('Codigo de produto inválido!!!');
  End
  Else
     LblProduto.Caption := JsonObjectProduto.GetValue<String>('descricao');
  pCodigoERP            := JsonObjectProduto.GetValue<Integer>('codproduto');
  JsonObjectProduto     := Nil;
  ObjProdutoCtrl.Free;
end;

procedure TFrmRelTagProduto.EdtCodigoERPKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  LblProduto.Caption := '...';
end;

procedure TFrmRelTagProduto.EdtDtFinalizacaoChange(Sender: TObject);
begin
  inherited;
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  ChkTagProduto.Visible := EdtCodigoErp.Text <> '';
  If EdtCodigoErp.Text = '' then
     ChkTagProduto.Checked := False;
end;

procedure TFrmRelTagProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelTagProduto := Nil;
end;

procedure TFrmRelTagProduto.FormCreate(Sender: TObject);
begin
  inherited;
  DbgEtqControlados.Columns[0].Width := 30;
  ConfigPrinterEtq;
  ConfigACBrETQ;
  if DebugHook <> 0 then ChkForcarSalto.Checked := False;
  
end;

end.
