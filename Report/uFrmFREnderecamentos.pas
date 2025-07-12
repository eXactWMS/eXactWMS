unit uFrmFREnderecamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar, DataSet.Serialize,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Buttons, Vcl.Mask,
  JvExMask, JvToolEdit, JvSpin, dxSkinsCore, dxSkinsDefaultPainters, Vcl.DBGrids,
  Vcl.ComCtrls, ACBrBase, ACBrETQ, dxCameraControl, System.Win.ComObj, ActiveX;

type
  TFrmFREnderecamentos = class(TFrmReportBase)
    Label2: TLabel;
    CbEstrutura: TComboBox;
    Label3: TLabel;
    EdtZona: TJvComboEdit;
    BtnPesqZona: TBitBtn;
    LblZona: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    EdtEnderecoIni: TJvComboEdit;
    BtnSearchLocalIni: TBitBtn;
    EdtEnderecoFin: TJvComboEdit;
    BtnSearchLocalFin: TBitBtn;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEstruturaID: TIntegerField;
    FdMemPesqGeralEstrutura: TStringField;
    FdMemPesqGeralRuaId: TIntegerField;
    FdMemPesqGeralRua: TStringField;
    FdMemPesqGeralLado: TStringField;
    FdMemPesqGeralOrdem: TIntegerField;
    FdMemPesqGeralPickingFixo: TIntegerField;
    FdMemPesqGeralZonaId: TIntegerField;
    FdMemPesqGeralZona: TStringField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralDesenhoArmazemId: TIntegerField;
    FdMemPesqGeralStatus: TIntegerField;
    FdMemPesqGeralMascara: TStringField;
    GbOcupacaoEndereco: TGroupBox;
    RbTodos: TRadioButton;
    RbLivres: TRadioButton;
    RbOcupados: TRadioButton;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralProduto: TStringField;
    GbStatus: TGroupBox;
    RbStatusTodos: TRadioButton;
    RbStatusAtivo: TRadioButton;
    RbStatusInativo: TRadioButton;
    FdMemPesqGeralQtde: TIntegerField;
    FdMemPesqGeralQtdePulmao: TIntegerField;
    FDMemReUsoPicking: TFDMemTable;
    FDMemReUsoPickingEnderecoId: TIntegerField;
    FDMemReUsoPickingEndereco: TStringField;
    FDMemReUsoPickingCodProduto: TIntegerField;
    FDMemReUsoPickingProduto: TStringField;
    FDMemReUsoPickingMascara: TStringField;
    FDMemReUsoPickingZona: TStringField;
    FDMemReUsoPickingStatus: TIntegerField;
    FDMemReUsoPickingSaldo: TIntegerField;
    TabReUsoPicking: TcxTabSheet;
    Label4: TLabel;
    EdtZonaIdReUso: TJvComboEdit;
    BtnPesqZonaReUso: TBitBtn;
    LblZonaReUso: TLabel;
    Label6: TLabel;
    CbDias: TComboBox;
    LstPickingReuso: TAdvStringGrid;
    LblTotRegPickingReuso: TLabel;
    LblTotPickingReuso: TLabel;
    BtnDesvincularPicking: TPanel;
    ImgDesvincularPicking: TsImage;
    FdMemPesqGeralQtdePicking: TIntegerField;
    FdMemPesqGeralQtdeReserva: TIntegerField;
    FdMemPesqGeralBloqueado: TIntegerField;
    RbBloqueado: TRadioButton;
    TabOcupacaoCD: TcxTabSheet;
    LstZona: TAdvStringGrid;
    Label5: TLabel;
    ChkPortaPallet: TCheckBox;
    ChkPicking: TCheckBox;
    ChkBloqueado: TCheckBox;
    LstEnderecoOcupado: TAdvStringGrid;
    Label8: TLabel;
    LblEnderecoOcupado: TLabel;
    FDMemEnderecoOcupado: TFDMemTable;
    IntegerField1: TIntegerField;
    FDMemEnderecoOcupadoZonaId: TIntegerField;
    FDMemEnderecoOcupadoZona: TStringField;
    FDMemEnderecoOcupadoRuaId: TIntegerField;
    FDMemEnderecoOcupadoCurva: TStringField;
    FDMemEnderecoOcupadoVolume: TFloatField;
    FDMemEnderecoOcupadoCapacidade: TIntegerField;
    FDMemEnderecoOcupadoEstoque: TIntegerField;
    FDMemEnderecoOcupadoVlmOcupado: TFloatField;
    FDMemEnderecoOcupadoTxOcupacao: TFloatField;
    FDMemZonaOcupacao: TFDMemTable;
    FDMemZonaOcupacaoZonaid: TIntegerField;
    FDMemZonaOcupacaoDescricao: TStringField;
    FDMemZonaOcupacaoAtivo: TIntegerField;
    Panel5: TPanel;
    Shape7: TShape;
    Label10: TLabel;
    LblTotEndereco: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    Label11: TLabel;
    LblTotVolume: TLabel;
    Panel2: TPanel;
    Shape2: TShape;
    Label14: TLabel;
    LblTaxaOcupacao: TLabel;
    Panel3: TPanel;
    Shape3: TShape;
    Label17: TLabel;
    LblTotEnderecoOcupado: TLabel;
    LblPercEndOcupado: TLabel;
    PnlCardOcupacao: TPanel;
    Label9: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label13: TLabel;
    LblPercCubEnd: TLabel;
    LblCubTotalEndereco: TLabel;
    Label20: TLabel;
    FDMemEnderecoOcupadoEndereco: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtEnderecoIniChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtZonaChange(Sender: TObject);
    procedure EdtZonaExit(Sender: TObject);
    procedure FdMemPesqGeralStatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FdMemPesqGeralLadoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure CbEstruturaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure CbDiasChange(Sender: TObject);
    procedure LstPickingReusoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnDesvincularPickingClick(Sender: TObject);
    procedure ChkBloqueadoClick(Sender: TObject);
    procedure LstZonaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnExportarStandClick(Sender: TObject);
  private
    { Private declarations }
    SelEndereco, SelZona : Boolean;
    Procedure GetEstrutura;
    Procedure PesquisarPickingReuso;
    Procedure PesquisarOcupacaoCD;
    Procedure LimparLstOcupacao;
    Procedure CalcularTotalEndereco;
    Procedure GetZonaOcupacao;
    Procedure MontaListaZonaOcupacao;
    Procedure MontaListaEnderecoOcupacao;
    Procedure ExportarOcupacaoExcel(QryOcupacao : TFdMemTable);
  Protected
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmFREnderecamentos: TFrmFREnderecamentos;

implementation

{$R *.dfm}

uses EnderecamentoZonaClass, EnderecamentoZonaCtrl, EnderecoEstruturaClass, EnderecamentoEstruturaCtrl,
     EnderecoClass, EnderecoCtrl, uFuncoes, TypInfo, uFrmeXactWMS,
     Vcl.DialogMessage, Views.Pequisa.EnderecamentoZonas;

procedure TFrmFREnderecamentos.BtnPesqZonaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoZonas;
begin
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       if Sender = BtnPesqzonaReUso then Begin
          EdtZonaIdReUso.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaExit(EdtZonaIdReUso);
       End
       Else Begin
          EdtZona.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaExit(EdtZona);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmFREnderecamentos.BtnDesvincularPickingClick(Sender: TObject);
begin
  inherited;
  if Confirmacao('Reuso de Picking', 'Deseja Desvincular os ('+LblTotPickingReuso.Caption+') produtos?', True) then Begin
     TDialogMessage.ShowWaitMessage('Buscando Informações...',
       procedure
       Var vErro  : String;
           JsonArrayRetorno : TJsonArray;
           ObjEnderecoCtrl   : TEnderecoCtrl;
           JsonArrayEndereco : TJsonArray;
           xEndereco         : Integer;
       begin
         JsonArrayEndereco := TJsonArray.Create;
         for xEndereco := 1 to Pred(LstPickingReuso.RowCount) do Begin
           if LstPickingReuso.Cells[7, xEndereco].toInteger() = 1 then
              JsonArrayEndereco.AddElement(TJsonObject.Create.AddPair('enderecoid', TJsonNumber.Create(LstPickingReuso.Cells[8, xEndereco].toInteger())));
         End;
         if JsonArrayEndereco.Count > 0 then Begin
            ObjEnderecoCtrl := TEnderecoCtrl.Create;
            JsonArrayRetorno := ObjEnderecoCtrl.DesvincularPicking(JsonArrayEndereco);
            If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
               ShowErro('Erro: '+vErro)
            Else Begin
               ShowOk(JsonArrayRetorno.Count.ToString+' Picking´s liberado(s) para reuso.');
               Limpar;
               EdtZonaIdReUso.SetFocus;
            End;
            JsonArrayRetorno := Nil;
            ObjEnderecoCtrl.Free;
         End;
         JsonArrayEndereco.Free;
         BtnDesvincularPicking.Visible := False;
       End);
  End;
end;

procedure TFrmFREnderecamentos.BtnExportarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabPrincipal then
     inherited
  Else Begin
     ExportarOcupacaoExcel(FDMemEnderecoOcupado);
  End;

end;

procedure TFrmFREnderecamentos.BtnPesquisarStandClick(Sender: TObject);
Var ArrayJsonEndereco : TJsonArray;
    ObjEnderecoCtrl   : TEnderecoCtrl;
    vOcupacao, vErro  : String;
    xRetorno, vStatus : Integer;
    vEstruturaId      : Integer;
    vBloqueado        : Integer;
    vTotalRegistro    : Integer;
begin
  if PgcBase.ActivePage = TabReUsoPicking then
     PesquisarPickingReuso
  Else if PgcBase.ActivePage = TabOcupacaoCD then
     PesquisarOcupacaoCD
  Else begin
     inherited;
     if (EdtEnderecoIni.Text='') and (EdtEnderecoFin.Text='') and (CbEstrutura.Text='') and (EdtZona.Text='') then Begin
        ShowErro('🙋🏼‍♀ Informe o Tipo e/ou Faixa de Endereço para pesquisar.');
        EdtEnderecoIni.SetFocus;
        exit;
     End;
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     vStatus := 99;  //Qualquer Número diferente de 0(Inativo) e 1(Ativo)
     if RbStatusAtivo.Checked then vStatus := 1
     else if RbStatusInativo.Checked then vStatus := 0;
     if CbEstrutura.ItemIndex <= 0 then
        vEstruturaId := 0
     Else vEstruturaId := CbEstrutura.ItemIndex;
     if CbEstrutura.ItemIndex = 2 then
        LstReport.UnHideColumn(12)
     Else LstReport.HideColumn(12);
     if CbEstrutura.Itemindex = 2 then Begin
        if RbTodos.Checked then
           vOcupacao := 'T'
        Else if RbLivres.Checked then
           vOcupacao := 'L'
        Else if RbOcupados.Checked then
           vOcupacao := 'O';
        End
     Else vOcupacao := 'T';
     if RbBloqueado.Checked then
        vBloqueado := 1
     Else
        vBloqueado := 0;
       //Tela Aguarde...
     If FdMemPesqGeral.Active then
        FdmemPesqGeral.EmptyDataSet;
     FdMemPesqGeral.Close;
     FdMemPesqGeral.Open;
     LstReport.RowCount  := 1;
     TDialogMessage.ShowWaitMessage('Buscando Informações...',
       procedure
       Var xRetorno : Integer;
           vErro : String;
           vLimit, vOffSet : Integer;
           JsonObjectRetorno : TJsonObject;
       begin
         vTotalRegistro := 0;
         vLimit         := 1000;
         vOffSet        := 0;
         Repeat
           JsonObjectRetorno := ObjEnderecoCtrl.GetEnderecoJsonPaginacao(0, vEstruturaId, StrToIntDef(EdtZona.Text, 0), 0, EdtEnderecoIni.Text,
                                EdtEnderecoFin.Text, vOcupacao, vStatus, vBloqueado, 1, 0, vLimit, vOffSet);
           if JsonObjectRetorno.TryGetValue<string>('Erro', vErro) then Begin
              ShowErro('Não foram encontrado(s) dados para o relatório');
              //ObjEnderecoCtrl.Free;
           End
           Else Begin
              ArrayJsonEndereco  := JsonObjectRetorno.GetValue<TJsonArray>('endereco');
              LstReport.RowCount := LstReport.RowCount+ArrayJsonEndereco.Count;
              LstReport.FixedRows := 1;
              vTotalRegistro := JsonObjectRetorno.GetValue<Integer>('recodcount');
              For xRetorno := vOffSet+1 to LstReport.RowCount - 1 do Begin
                LstReport.AddDataImage(5, xRetorno, 0, haCenter,vaTop);
                LstReport.AddDataImage(7, xRetorno, 0, haCenter,vaTop);
                LstReport.AddDataImage(8, xRetorno, 0, haCenter,vaTop);
              End;
              ImprimirExportar(True);
              for XRetorno := 0 to Pred(ArrayJsonEndereco.Count) do Begin
                LstReport.Cells[0, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid').ToString;
                LstReport.Cells[1, vOffSet+xRetorno+1] := EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
                LstReport.Cells[2, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
                LstReport.Cells[3, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
                if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'U' then
                   LstReport.Cells[4, vOffSet+xRetorno+1] := 'Único'
                Else if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'I' then
                   LstReport.Cells[4, vOffSet+xRetorno+1] := 'Impar'
                Else if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'P' then
                   LstReport.Cells[4, vOffSet+xRetorno+1] := 'Par'
                Else LstReport.Cells[4, vOffSet+xRetorno+1] := '---';
                LstReport.Cells[5, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('pickingfixo');
                LstReport.Cells[6, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
                LstReport.Cells[7, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('status');
                LstReport.Cells[8, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('bloqueado');
                if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') <> 0then begin
                   LstReport.Cells[ 9, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('codproduto');
                   LstReport.Cells[10, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
                end
                Else Begin
                   LstReport.Cells[ 9, vOffSet+xRetorno+1] := '';
                   LstReport.Cells[10, vOffSet+xRetorno+1] := '';
                End;
                if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde') <> 0 then
                   LstReport.Cells[11, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde').ToString()
                Else LstReport.Cells[11, vOffSet+xRetorno+1] := '';
                if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva') <> 0 then
                   LstReport.Cells[12, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva').ToString()
                Else LstReport.Cells[12, vOffSet+xRetorno+1] := '0';
                if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao') <> 0 then
                   LstReport.Cells[13, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao').ToString()
                Else LstReport.Cells[13, xRetorno+1] := '';
                LstReport.Cells[14, vOffSet+xRetorno+1] := ArrayJsonEndereco.Items[xRetorno].GetValue<String>('Ocupacao')+'%';
                LstReport.Alignments[0,  vOffSet+xRetorno+1] := taRightJustify;
                LstReport.FontStyles[0,  vOffSet+xRetorno+1] := [FsBold];
                LstReport.FontStyles[1,  vOffSet+xRetorno+1] := [FsBold];
                LstReport.Alignments[1,  vOffSet+xRetorno+1] := taCenter;
                LstReport.Alignments[5,  vOffSet+xRetorno+1] := taCenter;
                LstReport.Alignments[7,  vOffSet+xRetorno+1] := taCenter;
                LstReport.Alignments[8,  vOffSet+xRetorno+1] := taCenter;
                LstReport.Alignments[9,  vOffSet+xRetorno+1] := taRightJustify;
                LstReport.Alignments[11, vOffSet+xRetorno+1] := taRightJustify;
                LstReport.Alignments[12, vOffSet+xRetorno+1] := taRightJustify;
                LstReport.Alignments[13, vOffSet+xRetorno+1] := taRightJustify;
                LstReport.Alignments[14, vOffSet+xRetorno+1] := taRightJustify;
                With FdMemPesqGeral do begin
                  Append;
                  FieldByName('EnderecoId').AsInteger  := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid');
                  FieldByName('EstruturaID').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<integer>('estruturaid');
                  FieldByName('Estrutura').AsString    := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
                  FieldByName('RuaId').AsInteger       := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ruaid');
                  FieldByName('Rua').AsString          := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
                  FieldByName('Lado').AsString         := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado');
                  FieldByName('Ordem').AsInteger       := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ordem');
                  FieldByName('PickingFixo').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<integer>('pickingfixo');
                  FieldByName('ZonaID').AsInteger      := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid');
                  FieldByName('Zona').AsString         := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
                  FieldByName('Endereco').AsString     := EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
                  FieldByName('DesenhoArmazemID').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('desenhoarmazem').GetValue<integer>('Id');
                  FieldByName('Status').AsInteger      := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('status');
                  FieldByName('Bloqueado').AsInteger   := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('bloqueado');
                  FieldByName('Mascara').AsString      := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara');
                  FieldByName('CodProduto').AsInteger  := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
                  FieldByName('Produto').AsString      := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
                  FieldByName('Qtde').AsInteger        := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde');
                  FieldByName('QtdePulmao').AsInteger  := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao');
                  FieldByName('QtdePicking').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepicking');
                  FieldByName('QtdeReserva').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva');
                  Post;
                End;
              End;
           End;
           JsonObjectRetorno := Nil;
           vOffSet := vOffSet + vLimit;
         Until FdMemPesqGeral.RecordCount >= vTotalRegistro;
       end);
       LblTotRegistro.Caption := FdMemPesqGeral.RecordCount.ToString()+' de '+vTotalRegistro.ToString();
     ArrayJsonEndereco := Nil;
     ObjEnderecoCtrl.Free;
  end;
end;

procedure TFrmFREnderecamentos.CbEstruturaClick(Sender: TObject);
begin
  inherited;
  GbOcupacaoEndereco.Visible := CbEstrutura.ItemIndex = 2;
  if CbEstrutura.ItemIndex <> 2 then
     LstReport.HideColumn(12)
  Else Begin
     LstReport.UnHideColumn(12);
     LstReport.RowCount :=  1;
//     LstReport.ColCount := 12;
     LstReport.Resize;
  End;
  Limpar;
end;

procedure TFrmFREnderecamentos.ChkBloqueadoClick(Sender: TObject);
begin
  inherited;
  LimparLstOcupacao;
  GetZonaOcupacao;
end;

procedure TFrmFREnderecamentos.CalcularTotalEndereco;
Var xEndereco, xTotalEndereco : Integer;
begin
  xTotalEndereco := 0;
  for xEndereco := 1 to Pred(LstPickingReUso.RowCount) do Begin
    if LstPickingReUso.Cells[7, xEndereco].ToInteger = 1 then
       Inc(xTotalEndereco);
  End;
  LblTotPickingReuso.Caption    := xTotalEndereco.ToString;
  BtnDesvincularPicking.Visible := xTotalEndereco > 0;
end;

procedure TFrmFREnderecamentos.CbDiasChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmFREnderecamentos.EdtEnderecoIniChange(Sender: TObject);
begin
  inherited;
  Limpar;
  if CbEstrutura.ItemIndex <> 2 then
     LstReport.HideColumn(12)
  Else LstReport.HideColumn(12);
end;

procedure TFrmFREnderecamentos.EdtZonaChange(Sender: TObject);
begin
  inherited;
  if PgcBase.ActivePage = TabReUsoPicking then
     LblZonaReUso.Caption := ''
  Else
     LblZona.Caption := '';
  Limpar;
end;

procedure TFrmFREnderecamentos.EdtZonaExit(Sender: TObject);
Var ObjEnderecoZonaCtrl : TEnderecamentoZonaCtrl;
    ReturnLstZona       : TObjectList<TEnderecamentoZona>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  if PgcBase.ActivePage = TabReUsoPicking then Begin
     if EdtZOnaIdReUso.Text = '' then Exit;     
     LblZonaReUso.Caption := ''
  End
  Else Begin
     if EdtZona.Text = '' then Exit;
     
     LblZona.Caption  := '';
  End;
  ObjEnderecoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  If PgcBase.ActivePage = TabReUsoPicking then
     ReturnLstZona       := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrtoIntDef(EdtZonaIdReUso.Text, 0), '', 0)
  Else
     ReturnLstZona       := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrtoIntDef(EdtZona.Text, 0), '', 0);
  if ReturnLstZona.Count <= 0 then Begin
     if PgcBase.ActivePage = TabReUsoPicking then Begin
        EdtZonaIdReUso.Clear;
        ShowErro('Zona('+EdtZonaIdReUso.Text+') não encontrada!');
     End
     Else Begin
        EdtZona.Clear;
        ShowErro('Zona('+EdtZona.Text+') não encontrada!');
     End
  End
  else Begin
     if PgcBase.ActivePage = TabReUsoPicking then
        LblZonaReUso.Caption   := ReturnLstZona.Items[0].Descricao
     Else
        LblZona.Caption   := ReturnLstZona.Items[0].Descricao;
  End;
  ReturnLstZona := Nil;
  ObjEnderecoZonaCtrl.Free;
end;

procedure TFrmFREnderecamentos.ExportarOcupacaoExcel(QryOcupacao: TFdMemTable);
var
  Excel    : Variant;
  Linha, i : Integer;
  vPath    : String;
  ExcelApp : OleVariant;
  ExcelWorkbook: OleVariant;
  ExcelWorksheet: OleVariant;
  ColumnIndex, RowIndex: Integer;

begin
  if not FdMemEnderecoOcupado.IsEmpty then
  begin
    vPath := ExtractFilePath(Application.ExeName)+'Relatorio\';
    if not DirectoryExists(vPath) then
       ForceDirectories(vPath);
    FdMemEnderecoOcupado.First;
    Try
      CoInitialize(nil);
      ExcelApp := CreateOleObject('Excel.Application');
      Try
        ExcelApp.Visible := False;
        ExcelWorkbook := ExcelApp.Workbooks.Add;
        ExcelWorksheet := ExcelWorkbook.Worksheets[1];
        ExcelWorksheet.cells[1, 1] := 'Endereço';
        ExcelWorksheet.cells[1, 2] := 'ZonaId';
        ExcelWorksheet.cells[1, 3] := 'Zona';
        ExcelWorksheet.cells[1, 4] := 'RuaId';
        ExcelWorksheet.cells[1, 5] := 'Curva';
        ExcelWorksheet.cells[1, 6] := 'Volume do Endereço';
        ExcelWorksheet.cells[1, 7] := 'Capacidade';
        ExcelWorksheet.cells[1, 8] := 'Estoque';
        ExcelWorksheet.cells[1, 9] := 'Vol.Ocupado';
        ExcelWorksheet.cells[1,10] := '%Ocupação';
        Linha := 2;
        While not FdMemEnderecoOcupado.Eof do Begin
          ExcelWorksheet.cells[Linha, 1] := FdMemEnderecoOcupadoEndereco.Value;
          ExcelWorksheet.cells[Linha, 2] := FDMemEnderecoOcupadoZonaId.Value;
          ExcelWorksheet.cells[Linha, 3] := FdMemEnderecoOcupadoZona.Value;
          ExcelWorksheet.cells[Linha, 4] := FDMemEnderecoOcupadoRuaId.Value;
          ExcelWorksheet.cells[Linha, 5] := FDMemEnderecoOcupadoCurva.Value;
          ExcelWorksheet.cells[Linha, 6] := FDMemEnderecoOcupadoVolume.Value;
          ExcelWorksheet.cells[Linha, 7] := FDMemEnderecoOcupadoCapacidade.Value;
          ExcelWorksheet.cells[Linha, 8] := FDMemEnderecoOcupadoEstoque.Value;
          ExcelWorksheet.cells[Linha, 9] := FDMemEnderecoOcupadoVlmOcupado.Value/1000000;
          ExcelWorksheet.cells[Linha,10] := FDMemEnderecoOcupadoTxOcupacao.Value;
          FDMemEnderecoOcupado.Next;
          //LstReport.Row := Linha-1;
          Inc(Linha);
          Application.ProcessMessages;
        end;
        ExcelApp.DisplayAlerts := False;
        ExcelWorkbook.SaveAs(vPath+'EnderecoOcupado.xlsx');
        ExcelWorkbook.Close;
        ExcelApp.DisplayAlerts := True;
        ShowMessage('Exportação Concluída. '+vPath+'EnderecoOcupado.xlsx');
      Except On E: Exception do Begin
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

procedure TFrmFREnderecamentos.FdMemPesqGeralLadoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := '---';
  if (Sender.AsString = 'U') then
     Text := 'Único'
  Else if (Sender.AsString = 'I') then
     Text := 'Impar'
  Else if (Sender.AsString = 'P') then
     Text := 'Par';
end;

procedure TFrmFREnderecamentos.FdMemPesqGeralStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
     Text := 'Inativo';
end;

procedure TFrmFREnderecamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmFREnderecamentos := Nil;
end;

procedure TFrmFREnderecamentos.FormCreate(Sender: TObject);
begin
  inherited;
  SelEndereco := True;
  SetReadOnly;
  LstReport.RowCount   := 1;
  With LstReport do Begin
    ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[1]  :=  90+Trunc(90*ResponsivoVideo);
    ColWidths[2]  := 100+Trunc(100*ResponsivoVideo);
    ColWidths[3]  :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[4]  :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[5]  :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[6]  := 160+Trunc(160*ResponsivoVideo);
    ColWidths[7]  :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[8]  :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[9]  :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[10] := 300+Trunc(300*ResponsivoVideo);
    ColWidths[11] :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[12] :=  60+Trunc(60*ResponsivoVideo);
    ColWidths[13] :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[14] :=  80+Trunc(80*ResponsivoVideo);
    Alignments[0, 0]  := taRightJustify;
    FontStyles[0, 0]  := [FsBold];
    FontStyles[1, 0]  := [FsBold];
    Alignments[1, 0]  := taCenter;
    Alignments[5, 0]  := taCenter;
    Alignments[7, 0]  := taCenter;
    Alignments[8, 0]  := taCenter;
    Alignments[11, 0] := taRightJustify;
    Alignments[12, 0] := taRightJustify;
    Alignments[13, 0] := taRightJustify;
    Alignments[14, 0] := taRightJustify;
  End;
  With LstPickingReuso do Begin
    ColWidths[0] :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[1] := 120+Trunc(120*ResponsivoVideo);
    ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
    ColWidths[3] := 400+Trunc(400*ResponsivoVideo);
    ColWidths[4] := 180+Trunc(180*ResponsivoVideo);
    ColWidths[5] :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[6] :=  50+Trunc(50*ResponsivoVideo);
    ColWidths[7] :=  50+Trunc(50*ResponsivoVideo);
    Alignments[0, 0] := taRightJustify;
    FontStyles[1, 0] := [FsBold];
    Alignments[1, 0] := taCenter;
    Alignments[2, 0] := taRightJustify;
    Alignments[5, 0] := taRightJustify;
    Alignments[6, 0] := taCenter;
    Alignments[7, 0] := taCenter;
  End;
  LstPickingReuso.HideColumn(8);
  GetEstrutura;
  RbStatusTodos.Checked := True;
  rbTodos.Checked       := True;
  SelZona := True;
  LstZona.RowCount := 1;
  LstZona.ColWidths[0] :=  60+Trunc(60*ResponsivoVideo);
  LstZona.ColWidths[1] := 250+Trunc(250*ResponsivoVideo);
  LstZona.ColWidths[2] :=  60+Trunc(60*ResponsivoVideo);
  LstZona.Alignments[0, 0] := taRightJustify;
  LstZona.FontStyles[0, 0] := [fsBold];
  LstZona.Alignments[2, 2] := taCenter;
  LstZona.Width := (LstZona.ColWidths[0]+LstZona.ColWidths[1]+LstZona.ColWidths[2])+(35+Trunc(35*ResponsivoVideo));
  ChkPortaPallet.Left := LstZona.Left+LstZona.Width + 25;
  ChkPicking.Left     := ChkPortaPallet.Left;
  ChkBloqueado.Left   := ChkPortaPallet.Left;
  LstEnderecoOcupado.ColWidths[0] := 70+Trunc(70*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[1] := 90+Trunc(90*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[2] := 180+Trunc(180*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[3] :=  50+Trunc(50*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[4] := 80+Trunc(80*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[5] := 80+Trunc(80*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[6] := 80+Trunc(80*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[7] := 100+Trunc(100*ResponsivoVideo);
  LstEnderecoOcupado.ColWidths[8] := 80+Trunc(80*ResponsivoVideo);
  LstEnderecoOcupado.Alignments[0, 0] := taRightJustify;
  LstEnderecoOcupado.FontStyles[0, 0] := [fsBold];
  LstEnderecoOcupado.Alignments[1, 0] := taCenter;
  LstEnderecoOcupado.Alignments[3, 0] := taCenter;
  LstEnderecoOcupado.Alignments[4, 0] := taRightJustify;
  LstEnderecoOcupado.Alignments[5, 0] := taRightJustify;
  LstEnderecoOcupado.Alignments[6, 0] := taRightJustify;
  LstEnderecoOcupado.Alignments[7, 0] := taRightJustify;
  LstEnderecoOcupado.Alignments[8, 0] := taRightJustify;
  LstEnderecoOcupado.Width := LstEnderecoOcupado.ColWidths[0]+LstEnderecoOcupado.ColWidths[1]+LstEnderecoOcupado.ColWidths[2]+
                              LstEnderecoOcupado.ColWidths[3]+LstEnderecoOcupado.ColWidths[4]+LstEnderecoOcupado.ColWidths[5]+
                              LstEnderecoOcupado.ColWidths[6]+LstEnderecoOcupado.ColWidths[7]+LstEnderecoOcupado.ColWidths[8]+25;
  GetZonaOcupacao;
end;

procedure TFrmFREnderecamentos.FormShow(Sender: TObject);
begin
  inherited;
  RbTodos.Checked := True;
end;

procedure TFrmFREnderecamentos.GetEstrutura;
Var ObjEnderecoEstruturaCtrl : TEnderecoEstruturaCtrl;
    ReturnLstEstrutura       : TObjectList<TEnderecoEstrutura>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create;
  ReturnLstEstrutura       := ObjEnderecoEstruturaCtrl.GetEnderecoEstrutura(0, '', 0);
  CbEstrutura.Items.Clear;
  CbEstrutura.Items.Add('');
  For xRetorno := 0 to Pred(ReturnLstEstrutura.Count) do Begin
    CbEstrutura.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
  End;
  ReturnLstEstrutura       := Nil;
  ObjEnderecoEstruturaCtrl.Free;
  CbEstrutura.ItemIndex    := 0;
end;

procedure TFrmFREnderecamentos.GetZonaOcupacao;
Var ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    vEstrutura : Integer;
begin
  vEstrutura := 0;
  if (ChkPortaPallet.Checked) and (ChkPicking.Checked) then
     vEstrutura := 0
  Else if (ChkPortaPallet.Checked) then
     vEstrutura := 1
  Else if (ChkPicking.Checked) then
     vEstrutura := 2;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  LstZona.RowCount := 1;
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetZonas(0, vEstrutura, 2, '');
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     Exit;
  End;
  If FDMemZonaOcupacao.Active then
     FDMemZonaOcupacao.EmptyDataSet;
  FDMemZonaOcupacao.Close;
  FDMemZonaOcupacao.LoadFromJSON(JsonArrayRetorno, False);
  FDMemZonaOcupacao.First;
  While Not FDMemZonaOcupacao.Eof do Begin
    FDMemZonaOcupacao.Edit;
    FDMemZonaOcupacao.FieldByName('Ativo').AsInteger := 1;
    FDMemZonaOcupacao.Next;
  End;
  FDMemZonaOcupacao.First;
  MontaListaZonaOcupacao;
end;

procedure TFrmFREnderecamentos.Limpar;
begin
  if PgcBase.ActivePage = TabReUsoPicking then Begin
     LstPickingReuso.RowCount      := 1;
     BtnDesvincularPicking.Visible := False;
     LbltotPickingReuso.Caption    := '';
     End
  Else
     inherited;
end;

procedure TFrmFREnderecamentos.LimparLstOcupacao;
begin
  LstEnderecoOcupado.ClearRect(0, 1, LstEnderecoOcupado.ColCount-1, LstEnderecoOcupado.RowCount-1);
  LstEnderecoOcupado.RowCount := 1;
  LblTotEndereco.Caption := '0';
  LblTotVolume.Caption   := '0';
  LblTotEnderecoOcupado.Caption := '0';
  LblTaxaOcupacao.Caption := '0';
end;

procedure TFrmFREnderecamentos.LstPickingReusoClickCell(Sender: TObject; ARow, ACol: Integer);
Var xEndereco : Integer;
begin
  inherited;
  if LstPickingReuso.RowCount <= 1 then Exit;
  if (Arow=0) and (acol < 7) then Begin
     LstPickingReuso.SortSettings.Column := aCol;
     LstPickingReuso.QSort;
  End;
  If (aCol = 7) then Begin
     if (aRow = 0) and (LstPickingReuso.RowCount>1) then Begin
        For xEndereco := 1 to Pred(LstPickingReuso.RowCount) do Begin
          if LstPickingReuso.Cells[5, xEndereco].ToInteger = 0 then Begin
             if SelEndereco then Begin
                if LstPickingReuso.Cells[7, xEndereco] = '1' then
                   LstPickingReuso.Cells[7, xEndereco] := '0';
             End
             Else Begin
                if LstPickingReuso.Cells[7, xEndereco] = '0' then
                   LstPickingReuso.Cells[7, xEndereco] := '1';
             End;
          End;
        End;
        SelEndereco := Not SelEndereco;
     End
     Else Begin
       if LstPickingReuso.Cells[5, aRow].ToInteger = 0 then Begin
          if (StrToIntDef(LstPickingReuso.Cells[7, aRow], 0) = 0) then
             LstPickingReuso.Cells[7, aRow] := '1'
          Else
             LstPickingReuso.Cells[7, aRow] := '0';
       End;
     End;
     CalcularTotalEndereco;
  End;
end;

procedure TFrmFREnderecamentos.LstZonaClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xZona : Integer;
begin
  inherited;
  if LstZona.RowCount <= 1 then Exit;
  LimparLstOcupacao;
  if (aCol = 2) then Begin
     if (aRow = 0) and (LstZona.RowCount>1) then Begin
        For xZona := 1 to Pred(LstZona.RowCount) do Begin
          if SelZona then Begin
             LstZona.Cells[2, xZona] := '0';
          End
          Else Begin
             LstZona.Cells[2, xZona] := '1';
          End;
        End;
        FDMemZonaOcupacao.First;
        While Not FDMemZonaOcupacao.Eof do Begin
          FDMemZonaOcupacao.Edit;
          if SelZona then
             FDMemZonaOcupacao.FieldByName('Ativo').AsInteger := 0
          Else
             FDMemZonaOcupacao.FieldByName('Ativo').AsInteger := 1;
          FDMemZonaOcupacao.Next
        End;
        SelZona := Not SelZona;
     End
     Else Begin
       if StrToIntDef(LstZona.Cells[2, aRow], 0) = 0 then
          LstZona.Cells[2, aRow] := '1'
       Else
         LStZona.Cells[2, aRow] := '0';
       FDMemZonaOcupacao.First;
       If FDMemZonaOcupacao.Locate('ZonaId', LstZona.Cells[0, aRow], []) then Begin
          FDMemZonaOcupacao.Edit;
          FDMemZonaOcupacao.FieldByName('Ativo').AsInteger := LStZona.ints[2, aRow];
       End;
     End;
  End;
end;

procedure TFrmFREnderecamentos.MontaListaEnderecoOcupacao;
Var xLin : Integer;
    xEnderecoOcupado : Integer;
    xTotVolume, xTotVolumeOcupado, xEnderecoVolumeTotal : Real;
begin
  LstEnderecoOcupado.RowCount := 1;
  if (Not FDMemEnderecoOcupado.Active) or (FDMemEnderecoOcupado.IsEmpty) then Begin
     Exit;
  End;
  LstEnderecoOcupado.RowCount  := FDMemEnderecoOcupado.RecordCount+1;
  LstEnderecoOcupado.FixedRows := 1;
  LblEnderecoOcupado.Caption   := FDMemEnderecoOcupado.RecordCount.ToString();
  xLin := 1;
  LblTotEndereco.Caption := FDMemEnderecoOcupado.RecordCount.ToString();
  xEnderecoOcupado     := 0;
  xTotVolume           := 0;
  xTotVolumeOcupado    := 0;
  xEnderecoVolumeTotal := 0;
  ImprimirExportar(True);
  while Not FDMemEnderecoOcupado.Eof do Begin
     LstEnderecoOcupado.Cells[0, xLin] := FDMemEnderecoOcupado.FieldByName('EnderecoId').AsString;
     LstEnderecoOcupado.Cells[1, xLin] := FDMemEnderecoOcupado.FieldByName('Endereco').AsString;
     LstEnderecoOcupado.Cells[2, xLin] := FDMemEnderecoOcupado.FieldByName('Zona').AsString;
     LstEnderecoOcupado.Cells[3, xLin] := FDMemEnderecoOcupado.FieldByName('Curva').AsString;
     LstEnderecoOcupado.Cells[4, xLin] := FormatFloat('0.000000', FDMemEnderecoOcupado.FieldByName('Volume').AsFloat/1000000);
     LstEnderecoOcupado.Cells[5, xLin] := FDMemEnderecoOcupado.FieldByName('Capacidade').AsString;
     LstEnderecoOcupado.Cells[6, xLin] := FDMemEnderecoOcupado.FieldByName('Estoque').AsString;
     LstEnderecoOcupado.Cells[7, xLin] := FormatFloat('0.000000', FDMemEnderecoOcupado.FieldByName('VlmOcupado').AsFloat/1000000);
     LstEnderecoOcupado.Cells[8, xLin] := FormatFloat('0.00', FDMemEnderecoOcupado.FieldByName('TxOcupacao').AsFloat)+'%';
     xTotVolume           := xTotVolume + FDMemEnderecoOcupado.FieldByName('Volume').AsFloat;
     xTotVolumeOcupado    := xTotVolumeOcupado + FDMemEnderecoOcupado.FieldByName('VlmOcupado').AsFloat;
     xEnderecoVolumeTotal := xEnderecoVolumeTotal + FDMemEnderecoOcupado.FieldByName('Volume').AsFloat;
     If FDMemEnderecoOcupado.FieldByName('TxOcupacao').AsFloat > 100 then
        LstEnderecoOcupado.Colors[8, xLin] := clRed
     Else
        LstEnderecoOcupado.Colors[8, xLin] := LstEnderecoOcupado.Colors[8, xLin];
     LstEnderecoOcupado.Alignments[0, xLin] := taRightJustify;
     LstEnderecoOcupado.FontStyles[0, xLin] := [fsBold];
     LstEnderecoOcupado.Alignments[1, xLin] := taCenter;
     LstEnderecoOcupado.Alignments[3, xLin] := taCenter;
     LstEnderecoOcupado.Alignments[4, xLin] := taRightJustify;
     LstEnderecoOcupado.Alignments[5, xLin] := taRightJustify;
     LstEnderecoOcupado.Alignments[6, xLin] := taRightJustify;
     LstEnderecoOcupado.Alignments[7, xLin] := taRightJustify;
     LstEnderecoOcupado.Alignments[8, xLin] := taRightJustify;
     LstEnderecoOcupado.FontStyles[8, xLin] := [fsBold];
     if FDMemEnderecoOcupado.FieldByName('VlmOcupado').AsFloat > 0 then
        Inc(xEnderecoOcupado);
     Inc(xLin);
     FDMemEnderecoOcupado.Next;
  End;
  LblTotEnderecoOcupado.Caption := xEnderecoOcupado.ToString();
  LblTotVolume.Caption          := FormatFloat('0', xTotVolumeOcupado);
  LblTaxaOcupacao.Caption       := FormatFloat('0.00', (xTotVolumeOcupado/xTotVolume*100))+'%';
  LblCubTotalEndereco.Caption   := 'Cub.(m3): '+FormatFloat('0.000000', (xEnderecoVolumeTotal/1000000));
  LblTotVolume.Caption          := FormatFloat('0.', Round(xTotVolumeOcupado/1000000)); //Volume Total Ocupacao
  LblPercEndOcupado.Caption     := FormatFloat('0.00', (xEnderecoOcupado/FDMemEnderecoOcupado.RecordCount*100))+'%'; //Capacidade Total Endereco
end;

procedure TFrmFREnderecamentos.MontaListaZonaOcupacao;
Var xLin : Integer;
begin
  LstZona.RowCount := 1;
  if (Not FDMemZonaOcupacao.Active) or (FDMemZonaOcupacao.IsEmpty) then Begin
     Exit;
  End;
  LstZona.RowCount := FDMemZonaOcupacao.RecordCount+1;
  LstZona.FixedRows := 1;
  for xLin := 1 to Pred(LstZona.RowCount) do
    LstZona.AddDataImage(2, xLin, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xLin := 1;
  while Not FDMemZonaOcupacao.Eof do Begin
     LstZona.Cells[0, xLin] := FDMemZonaOcupacao.FieldByName('ZonaId').AsString;
     LstZona.Cells[1, xLin] := FDMemZonaOcupacao.FieldByName('Descricao').AsString;
     LstZona.Cells[2, xLin] := FDMemZonaOcupacao.FieldByName('Ativo').AsString;
     LstZona.Alignments[0, xLin] := taRightJustify;
     LstZona.FontStyles[0, xLin] := [fsBold];
     LstZona.Alignments[2, xLin] := taCenter;
     Inc(xLin);
     FDMemZonaOcupacao.Next;
  End;
end;

procedure TFrmFREnderecamentos.PesquisarOcupacaoCD;
var pListaZonaIdStr, xCompl : String;
    pBloqueado : Integer;
    JsonArrayRetorno : TjsonArray;
    vErro : String;
    ObjEnderecoCtrl   : TEnderecoCtrl;
begin
  if (Not ChkPortaPallet.Checked) and (Not Chkpicking.Checked) and (Not ChkBloqueado.Checked) then Begin
     ShowErro('Selecione o Tipo de Estrutura para Análise');
     Exit
  End;
  if (Not FDMemZonaOcupacao.Active) or (FDMemZonaOcupacao.IsEmpty) then Begin
     ShowErro('Selecione as Zonas/Setor...');
     Exit;
  End;
  FDMemZonaOcupacao.Filter   := 'Ativo = 1';
  FDMemZonaOcupacao.Filtered := True;
  If FDMemZonaOcupacao.IsEmpty then Begin
     ShowErro('Selecione pelo menos uma Zona/Setor...');
     FDMemZonaOcupacao.Filter   := '';
     FDMemZonaOcupacao.Filtered := False;
     Exit;
  End;
  pListaZonaIdStr := '';
  xCompl := '';
  FdMemZonaOcupacao.First;
  while Not FDMemZonaOcupacao.Eof do Begin
     if FDMemZonaOcupacao.FieldByName('Ativo').AsInteger = 1 then Begin
        pListaZonaIdStr := pListaZonaIdStr+xCompl+FdMemZonaOcupacao.FieldByName('ZonaId').AsString;
        xCompl := ', ';
     End;
     FDMemZonaOcupacao.Next;
  End;
  FDMemZonaOcupacao.Filter   := '';
  FDMemZonaOcupacao.Filtered := False;
  if ChkBloqueado.Checked  then
     pBloqueado := 1
  Else
     pBloqueado := 0;
  ObjEnderecoCtrl  := TEnderecoCtrl.Create;
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoOcupacao(pBloqueado, pListaZonaIdStr);
  if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then
     ShowErro('Atenção: '+vErro)
  Else if JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then
     ShowErro('Atenção: '+vErro)
  Else Begin
     If FDMemEnderecoOcupado.Active then
        FDMemEnderecoOcupado.EmptyDataSet;
     FDMemEnderecoOcupado.Close;
     FDMemEnderecoOcupado.LoadFromJSON(JsonArrayRetorno, False);
     FDMemEnderecoOcupado.First;
     MontaListaEnderecoOcupacao;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjEnderecoCtrl);
end;

procedure TFrmFREnderecamentos.PesquisarPickingReuso;
begin
//  inherited;
  LstPickingReUso.RowCount := 1;
  If FdMemReUsoPicking.Active then
     FdMemReUsoPicking.EmptyDataSet;
  FdMemReUsoPicking.Close;
  if (EdtZonaIdReUso.Text='') or (StrToIntDef(EdtZonaIdReUso.Text, 0) = 0) then Begin
     ShowErro('🙋🏼‍♀ Informe a Zona/Setor para pesquisar Picking disponível para Reuso.');
     EdtZonaIdReUso.SetFocus;
     exit;
  End;
  if CbDias.ItemIndex < 0 then Begin
     ShowErro('🙋🏼‍♀ Informe a quantidade de dias para Análise de disponibilidade.');
     EdtZonaIdReUso.SetFocus;
     exit;
  End;
  TDialogMessage.ShowWaitMessage('Buscando Informações...',
    procedure
    Var xRecno : Integer;
        vErro  : String;
        vDias  : Integer;
        ArrayJsonEndereco : TJsonArray;
        ObjEnderecoCtrl   : TEnderecoCtrl;
        vProduto : String;
    begin
      if CbDias.ItemIndex = 0 then
         vDias := 0
      Else if CbDias.ItemIndex = 1 then
         vDias := 20
      Else if CbDias.ItemIndex = 2 then
         vDias := 30
      Else if CbDias.ItemIndex = 3 then
         vDias := 60
      Else if CbDias.ItemIndex = 4 then
         vDias := 120
      Else if CbDias.ItemIndex = 5 then
         vDias := 180
      Else if CbDias.ItemIndex = 6 then
         vDias := 240
      Else if CbDias.ItemIndex = 7 then
         vDias := 360
      Else if CbDias.ItemIndex = 8 then
         vDias := 361;
      ObjEnderecoCtrl   := TEnderecoCtrl.Create;
      ArrayJsonEndereco := ObjEnderecoCtrl.GetReUsoPicking(StrToIntDef(EdtZonaIdReUso.Text, 0), vDias);
      if ArrayJsonEndereco.Items[0].TryGetValue<string>('Erro', vErro) then Begin
         ShowErro('Não foram encontrado(s) dados para o relatório');
         //ObjEnderecoCtrl.Free;
      End
      Else Begin
         FdMemReUsoPicking.LoadFromJSON(ArrayJsonEndereco, False);
         LstPickingReUso.RowCount   := FdMemReUsoPicking.RecordCount+1;
         LstPickingReUso.FixedRows  := 1;
         xRecno := 1;
         For xRecno := 1 to FdMemReUsoPicking.RecordCount do Begin
           LstPickingReUso.AddDataImage(6, xRecno, 0, haCenter,vaTop);
           LstPickingReUso.AddDataImage(7, xRecno, 0, haCenter,vaTop);
         End;
         FdMemPesqGeral.Open;
         ImprimirExportar(True);
         FdMemReUsoPicking.First;
         xRecno := 1;
         While Not FdMemReUsoPicking.Eof do Begin
           LstPickingReUso.Cells[0, xRecno] := FdMemReUsoPicking.FieldByName('EnderecoId').AsString;
           LstPickingReUso.Cells[1, xRecno] := EnderecoMask(FdMemReUsoPicking.FieldByName('Endereco').AsString,
                                               FdMemReUsoPicking.FieldByName('Mascara').AsString, True);
           LstPickingReUso.Cells[2, xRecno] := FdMemReUsoPicking.FieldByName('CodProduto').AsString;
           LstPickingReUso.Cells[3, xRecno] := FdMemReUsoPicking.FieldByName('Produto').AsString;
           LstPickingReUso.Cells[4, xRecno] := FdMemReUsoPicking.FieldByName('Zona').AsString;
           LstPickingReUso.Cells[5, xRecno] := FdMemReUsoPicking.FieldByName('Saldo').AsString;
           LstPickingReUso.Cells[6, xRecno] := FdMemReUsoPicking.FieldByName('Status').AsString;
           if FdMemReUsoPicking.FieldByName('Saldo').AsInteger > 0 then
              LstPickingReUso.Cells[7, xRecno] := '0'
           Else
              LstPickingReUso.Cells[7, xRecno] := '1';
           LstPickingReUso.Cells[8, xRecno] := FdMemReUsoPicking.FieldByName('EnderecoId').AsString;
           LstPickingReUso.Alignments[0, xRecno] := taRightJustify;
           LstPickingReUso.FontStyles[0, xRecno] := [FsBold];
           LstPickingReUso.Alignments[1, xRecno] := taCenter;
           LstPickingReUso.FontStyles[1, xRecno] := [FsBold];
           LstPickingReUso.Alignments[2, xRecno] := taRightJustify;
           LstPickingReUso.Alignments[5, xRecno] := taRightJustify;
           LstPickingReUso.Alignments[6, xRecno] := taCenter;
           LstPickingReUso.Alignments[7, xRecno] := taCenter;
           FdMemReUsoPicking.Next;
           Inc(xRecno);
         End;
         CalcularTotalEndereco;
      End;
      ArrayJsonEndereco := Nil;
      ObjEnderecoCtrl.Free;
    end);
end;

end.
