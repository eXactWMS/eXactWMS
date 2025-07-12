unit uFrmVolumeEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, Math,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Generics.Collections,
  Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits
  , VolumeEmbalagemCtrl, JvSpin, dxSkinsCore, dxSkinsDefaultPainters,DataSet.Serialize,
  Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ, dxCameraControl, System.Json, Rest.Types,
  Vcl.WinXCtrls;

type
  TFrmVolumeEmbalagem = class(TFrmBase)
    EdtEmbalagemId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    Label2: TLabel;
    CbTipo: TComboBox;
    edtDescricao: TLabeledEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EdtPeso: TJvCalcEdit;
    EdtAltura: TJvCalcEdit;
    EdtLargura: TJvCalcEdit;
    EdtComprimento: TJvCalcEdit;
    EdtVolume: TJvCalcEdit;
    EdtCapacidade: TJvCalcEdit;
    Label3: TLabel;
    EdtQtdLacres: TJvCalcEdit;
    Label5: TLabel;
    ChkCodigoBarras: TCheckBox;
    ChkDisponivel: TCheckBox;
    EdtPrecoCusto: TJvCalcEdit;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    EdtAproveitamento: TJvCalcEdit;
    EdtIdentificacao: TLabeledEdit;
    TabCaixas: TcxTabSheet;
    GroupBox1: TGroupBox;
    EdtDescricaoCaixa: TLabeledEdit;
    EdtIdentificacaoCaixa: TLabeledEdit;
    GbNovaCaixa: TGroupBox;
    EdtCaixaIdInicial: TJvCalcEdit;
    Label8: TLabel;
    ChkSequenciaAutomatica: TCheckBox;
    Label13: TLabel;
    EdtCaixaIdFinal: TJvCalcEdit;
    BtnCriarCaixas: TPanel;
    sImage1: TsImage;
    Label14: TLabel;
    PnlGetCaixa: TPanel;
    TmGetCaixa: TTimer;
    Label15: TLabel;
    LblTotCaixa: TLabel;
    FDMemCaixaEmbalagem: TFDMemTable;
    FDMemCaixaEmbalagemTEMP: TFDMemTable;
    Label16: TLabel;
    EdtCaixaSearch: TSearchBox;
    DataSource1: TDataSource;
    GbGroupCaixa: TGroupBox;
    Label17: TLabel;
    EdtCaixaIniSearch: TJvCalcEdit;
    Label18: TLabel;
    EdtCaixaFinSearch: TJvCalcEdit;
    BtnSearchCaixa: TPanel;
    sImage2: TsImage;
    lstacompanhamentocaixa: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEmbalagemIdExit(Sender: TObject);
    procedure EdtEmbalagemIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtAlturaChange(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtEmbalagemIdChange(Sender: TObject);
    procedure EdtCaixaIdInicialChange(Sender: TObject);
    procedure TabCaixasShow(Sender: TObject);
    procedure ChkSequenciaAutomaticaClick(Sender: TObject);
    procedure BtnCriarCaixasClick(Sender: TObject);
    procedure TmGetCaixaTimer(Sender: TObject);
    procedure LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtCaixaSearchInvokeSearch(Sender: TObject);
    procedure BtnSearchCaixaClick(Sender: TObject);
    procedure LstAcompanhamentoCaixaClickCell(Sender: TObject; ARow,
      ACol: Integer);
  private
    { Private declarations }
    vAutorizarCaixaInativar : Boolean;
    ObjVolumeEmbalagemCtrl : TVolumeEmbalagemCtrl;
    function GetListaVolumeEmbalagem(pVolumeEmbalagemId: Integer = 0;
      pDescricao: String = ''): Boolean;
    function IfThen(AValue: Boolean; const ATrue, AFalse: String): String;
    Procedure ShowAcompanhamentoCaixas;
    Procedure MontaListaAcompanhamentoCaixas;
    Procedure ThreadTerminateAcompanhamentoCaixas(Sender: TObject);
    Procedure CaixaInativar(pCaixaId, aRow : Integer);
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmVolumeEmbalagem: TFrmVolumeEmbalagem;

implementation

{$R *.dfm}

uses uFuncoes, EmbalagemCaixaCtrl, Vcl.DialogMessage, uFrmeXactWMS;

procedure TFrmVolumeEmbalagem.BtnCriarCaixasClick(Sender: TObject);
Var ObjCaixaEmbalagemCtrl : TCaixaEmbalagemCtrl;
    JsonObjectRetorno     : TJsonObject;
    vErro : String;
Begin
  inherited;
  Try
    Try
      ObjCaixaEmbalagemCtrl := TCaixaEmbalagemCtrl.Create;
      JsonObjectRetorno     := ObjCaixaEmbalagemCtrl.InsertFilaCaixa(TJsonObject.Create
                               .addPair('caixaidinicial', TJsonNumber.Create(StrToIntDef(EdtCaixaIdInicial.Text, 0)))
                               .addPair('caixaidfinal', TJsonNumber.Create(StrToIntDef(EdtCaixaIdFinal.Text, 0)))
                               .addPair('embalagemid', TJsonNumber.Create(StrToIntDef(EdtEmbalagemId.Text, 0)))
                               );
      if JsonObjectRetorno.TryGetValue('Erro', vErro) then
         ShowErro('Erro: '+vErro)
      Else Begin
        ChkSequenciaAutomatica.Checked := False;
        ShowOk('Caixas criadas com sucesso!');
        EdtCaixaIniSearch.Text := EdtCaixaIdInicial.Text;
        EdtCaixaFinSearch.Text := EdtCaixaIdFinal.Text;
        ShowAcompanhamentoCaixas;
        EdtCaixaIdInicial.Clear;
        EdtCaixaIdFinal.Clear;
      End;
      JsonObjectRetorno := Nil;
    Except on E: Exception do Begin
      ShowErro('Erro: '+E.Message);
      End;
    End;
  Finally
   FreeAndNil(ObjCaixaEmbalagemCtrl);
  End;
end;

procedure TFrmVolumeEmbalagem.BtnEditarClick(Sender: TObject);
begin
  inherited;
  CbTipo.SetFocus;
  TabCaixas.TabVisible := False;
end;

procedure TFrmVolumeEmbalagem.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbTipo.SetFocus;
  TabCaixas.TabVisible := False;
end;

procedure TFrmVolumeEmbalagem.BtnSearchCaixaClick(Sender: TObject);
begin
  inherited;
  ShowAcompanhamentoCaixas;
end;

procedure TFrmVolumeEmbalagem.CaixaInativar(pCaixaId, aRow : Integer);
Var ObjCaixaEmbalagemCtrl : TCaixaEmbalagemCtrl;
    JsonArrayRetorno      : TJsonArray;
    vErro : String;
begin
  Try
    Try
      ObjCaixaEmbalagemCtrl := TCaixaEmbalagemCtrl.Create;
      JsonArrayRetorno      := ObjCaixaEmbalagemCtrl.CaixaInativar(pCaixaId);
      if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
         ShowErro(vErro)
      Else Begin
         ShowOk('Caixa('+pCaixaId.ToString()+') inativada!');
         LstAcompanhamentoCaixa.Cells[1, aRow] := '0';
         LstAcompanhamentoCaixa.Cells[5, aRow] := '3';
      End;
    Except On E: Exception do Begin
      ShowErro('Erro: '+E.Message);
      End;
    End;
  Finally
   FreeAndNil(ObjCaixaEmbalagemCtrl);
  End;
end;

procedure TFrmVolumeEmbalagem.ChkSequenciaAutomaticaClick(Sender: TObject);
Var xRow : Integer;
    ObjCaixaEmbalagemCtrl : TCaixaEmbalagemCtrl;
    JsonArrayRetorno      : TJsonArray;
    vErro : String;
begin
  inherited;
  if ChkSequenciaAutomatica.Checked then Begin
     ObjCaixaEmbalagemCtrl := TCaixaEmbalagemCtrl.Create;
     jsonArrayRetorno := ObjCaixaEmbalagemCtrl.GetMaxCaixa;
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then  Begin
        ShowErro('Não foi possível pegar a sequência das Caixas.');
     End
     Else Begin
        EdtCaixaIdInicial.Text := JsonArrayRetorno.Items[0].GetValue<Integer>('numsequencia', 0).ToString();
     End;
     JsonArrayRetorno := Nil;
     FreeAndNil(ObjCaixaEmbalagemCtrl);
  End
  Else
     EdtCaixaIdInicial.Text := '';

  Exit;

  if ChkSequenciaAutomatica.Checked then Begin
     EdtCaixaIdFinal.Clear;
     for xRow := 1 to LstAcompanhamentoCaixa.RowCount do Begin
       if StrToIntDef(LstAcompanhamentoCaixa.Cells[0, xRow], 0) > StrToIntDef(EdtCaixaIdInicial.Text, 0) then
          EdtCaixaIdInicial.Text := LstAcompanhamentoCaixa.Cells[0, xRow];
     End;
     EdtCaixaIdInicial.Text := (StrToIntDef(EdtCaixaIdInicial.Text, 0)+1).ToString();
  End
  Else
     EdtCaixaIdInicial.Text := '';
end;

function TFrmVolumeEmbalagem.DeleteReg: Boolean;
begin
   Result := ObjVolumeEmbalagemCtrl.DelVolumeEmbalagem;
end;

procedure TFrmVolumeEmbalagem.EdtAlturaChange(Sender: TObject);
begin
  inherited;
  if (Not TJvCalcEdit(Sender).ReadOnly) then
     EdtVolume.Value := EdtAltura.Value * EdtLargura.Value * EdtComprimento.Value;
end;

procedure TFrmVolumeEmbalagem.EdtCaixaIdInicialChange(Sender: TObject);
begin
  inherited;
  if (StrToIntDef(EdtCaixaIdInicial.Text, 0)>0) and (StrToIntDef(EdtCaixaIdFinal.Text,0)>0) and
     (StrToIntDef(EdtCaixaIdInicial.Text, 0)<=StrToIntDef(EdtCaixaIdFinal.Text,0)) then Begin
     BtnCriarCaixas.Color   := $0077C03A;
     BtnCriarCaixas.Enabled := True;
  End
  Else Begin
     BtnCriarCaixas.Color   := clGray;
     BtnCriarCaixas.Enabled := False;
  End;
end;

procedure TFrmVolumeEmbalagem.EdtEmbalagemIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtEmbalagemId.ReadOnly) and (StrToIntDef(EdtEmbalagemId.Text, 0)<>ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId) then
     Limpar;
end;

procedure TFrmVolumeEmbalagem.EdtEmbalagemIdExit(Sender: TObject);
begin
  if (EdtEmbalagemId.Text<>'') and (StrToIntDef(EdtEmbalagemId.Text, 0) <= 0) then Begin
     EdtEmbalagemId.SetFocus;
     ShowErro('Id('+EdtEmbalagemId.Text+') da Embalagem é inválido!');
     EdtEmbalagemId.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtEmbalagemId.ReadOnly) and (EdtEmbalagemId.Text<>'') and (StrToIntDef(EdtEmbalagemId.Text,0)<>ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId) then Begin
     Limpar;
     if StrToIntDef(EdtEmbalagemId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtEmbalagemId.Text+') inválido!');
     ObjVolumeEmbalagemCtrl := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(StrToIntDef(EdtEmbalagemId.Text, 0), '', 1)[0];
     if ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId > 0 then
        ShowDados;
  End;
  ExitFocus(Sender)
end;

procedure TFrmVolumeEmbalagem.EdtEmbalagemIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmVolumeEmbalagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmVolumeEmbalagem := Nil;
end;

procedure TFrmVolumeEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;
  ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] :=  70+Trunc(70*ResponsivoVideo);
    ColWidths[1] := 250+Trunc(250*ResponsivoVideo);
    ColWidths[2] := 100+Trunc(100*ResponsivoVideo);
    ColWidths[3] := 100+Trunc(100*ResponsivoVideo);
    ColWidths[4] :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[5] :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[6] :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[7] :=  60+Trunc(60*ResponsivoVideo);
    Alignments[0 ,0] := taRightJustify;
    LstCadastro.FontStyles[0, 0] := [FsBold];
    Alignments[4 ,0] := taRightJustify;
    Alignments[5 ,0] := taRightJustify;
    Alignments[6 ,0] := taRightJustify;
  End;
  LstAcompanhamentoCaixa.ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);
  LstAcompanhamentoCaixa.ColWidths[1] :=  50+Trunc(50*ResponsivoVideo);
  LstAcompanhamentoCaixa.ColWidths[2] :=  70+Trunc(70*ResponsivoVideo);
  LstAcompanhamentoCaixa.ColWidths[3] :=  70+Trunc(70*ResponsivoVideo);
  LstAcompanhamentoCaixa.ColWidths[4] := 300+Trunc(300*ResponsivoVideo);
  LstAcompanhamentoCaixa.ColWidths[5] :=  50+Trunc(50*ResponsivoVideo);
  LstAcompanhamentoCaixa.Alignments[0 ,0] := taRightJustify;
  LstAcompanhamentoCaixa.FontStyles[0, 0] := [FsBold];
  LstAcompanhamentoCaixa.Alignments[1 ,0] := taCenter;
  LstAcompanhamentoCaixa.Alignments[2 ,0] := taCenter;
  LstAcompanhamentoCaixa.Alignments[3 ,0] := taRightJustify;
  LstAcompanhamentoCaixa.Alignments[5 ,0] := taCenter;
  //GetListaVolumeEmbalagem;
  GbNovaCaixa.Enabled  := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Criar novas caixas');
  GbGroupCaixa.Enabled := True;
  vAutorizarCaixaInativar := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Caixas - Inativar');
  PnlGetCaixa.Visible := False;
  TmGetCaixa.Enabled  := False;
end;

procedure TFrmVolumeEmbalagem.GetListaLstCadastro;
begin
  inherited;
  GetListaVolumeEmbalagem(0, '');
end;

function TFrmVolumeEmbalagem.GetListaVolumeEmbalagem(pVolumeEmbalagemId: Integer; pDescricao: String): Boolean;
Var xLista, xImg       : Integer;
    LstVolumeEmbalagem : TObjectList<TVolumeEmbalagemCtrl>;
begin
//  LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
  if pDescricao = '' then
     LstVolumeEmbalagem   := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(pVolumeEmbalagemId, '')
  Else LstVolumeEmbalagem := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(0, pDescricao);
  LstCadastro.RowCount  := 1;
  Result := LstVolumeEmbalagem.Count >= 1;
  If LstVolumeEmbalagem.Count >= 1 then Begin
     LstCadastro.RowCount  := LstVolumeEmbalagem.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount do
       LstCadastro.AddDataImage(7, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstVolumeEmbalagem.Count-1 do begin
       With LstVolumeEmbalagem[xLista].ObjVolumeEmbalagem do Begin
         LstCadastro.Cells[0, xLista+1] := EmbalagemId.ToString();
         LstCadastro.Cells[1, xLista+1] := Descricao;
         LstCadastro.Cells[2, xLista+1] := IfThen(Tipo = 'R', 'Retornável',
         IfThen(Tipo = 'P', 'Própria',
         IfThen(Tipo = 'C','Pacote',
         'Reutilizável')));
         LstCadastro.Cells[3, xLista+1] := Identificacao;
         LstCadastro.Cells[4, xLista+1] := FormatFloat('0.00', Volume);
         LstCadastro.Cells[5, xLista+1] := FormatFloat('0.000', Tara);
         LstCadastro.Cells[6, xLista+1] := FormatFloat('0.00', Capacidade);
         LstCadastro.Cells[7, xLista+1] := Status.ToString;
       End;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[4, xLista+1] := taRightJustify;
       LstCadastro.Alignments[5, xLista+1] := taRightJustify;
       LstCadastro.Alignments[6, xLista+1] := taRightJustify;
     end;
     LstVolumeEmbalagem := Nil;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
end;

function TFrmVolumeEmbalagem.IfThen(AValue: Boolean; const ATrue,
  AFalse: String): String;
begin
 if AValue then
    Result := ATrue
 else
    Result := AFalse;
end;

procedure TFrmVolumeEmbalagem.Limpar;
begin
  EnabledButtons := False;
  If Assigned(ObjVolumeEmbalagemCtrl) Then ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.Limpar;
  if Not EdtEmbalagemId.Enabled then
     EdtEmbalagemId.Clear;
  edtDescricao.Clear;
  CbTipo.ItemIndex := -1;
  EdtIdentificacao.Clear;
  EdtPeso.Value           := 0;
  EdtAltura.Value         := 0;
  EdtLargura.Value        := 0;
  EdtComprimento.Value    := 0;
  EdtVolume.Value         := 0;
  EdtCapacidade.Value     := 0;
  EdtAproveitamento.value := 0;
  EdtQtdLacres.Value      := 0;
  EdtPrecoCusto.Value     := 0;
  ChkCodigoBarras.Checked := False;
  ChkDisponivel.Checked   := False;
  ChkCadastro.Checked     := False;
  TabCaixas.TabVisible    := False;
  TmGetCaixa.Enabled      := False;
end;

procedure TFrmVolumeEmbalagem.LstAcompanhamentoCaixaClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
  if (aRow>0) and (aCol = 5) then Begin
    If LstAcompanhamentoCaixa.Cells[1, aRow] = '1' then
       CaixaInativar(LstAcompanhamentoCaixa.Ints[0, aRow], aRow);
  End;
end;

procedure TFrmVolumeEmbalagem.LstCadastroClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if aRow = 0 then
     inherited
  Else Begin
  End;
end;

procedure TFrmVolumeEmbalagem.MontaListaAcompanhamentoCaixas;
Var xRow : Integer;
begin
  LblTotCaixa.Caption     := FDMemCaixaEmbalagem.RecordCount.ToString();
  LstAcompanhamentoCaixa.RowCount  := FDMemCaixaEmbalagem.RecordCount+1;
  LstAcompanhamentoCaixa.FixedRows := 1;
  for xRow := 1 to (FDMemCaixaEmbalagem.RecordCount) do Begin
    LstAcompanhamentoCaixa.AddDataImage(1, xRow, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstAcompanhamentoCaixa.AddDataImage(2, xRow, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstAcompanhamentoCaixa.AddDataImage(5, xRow, 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
  End;
  xRow := 0;
  FDMemCaixaEmbalagem.First;
  While Not FDMemCaixaEmbalagem.Eof do Begin
    LstAcompanhamentoCaixa.Cells[0, xRow+1] := FdMemCaixaEmbalagem.FieldByName('numsequencia').AsString;
    LstAcompanhamentoCaixa.Cells[1, xRow+1] := FdMemCaixaEmbalagem.FieldByName('status').AsString;
    if FdMemCaixaEmbalagem.FieldByName('situacao').AsString = 'Disponível' then
       LstAcompanhamentoCaixa.Cells[2, xRow+1] := '1'
    Else
       LstAcompanhamentoCaixa.Cells[2, xRow+1] := '0';
    If FdMemCaixaEmbalagem.FieldByName('pedidovolumeid').AsInteger = 0 then
       LstAcompanhamentoCaixa.Cells[3, xRow+1] := ''
    Else
       LstAcompanhamentoCaixa.Cells[3, xRow+1] := FdMemCaixaEmbalagem.FieldByName('pedidovolumeid').AsString;
    If (FdMemCaixaEmbalagem.FieldByName('status').AsInteger = 1) and (vAutorizarCaixaInativar) then
       LstAcompanhamentoCaixa.Cells[5, xRow+1] := '2'
    Else
       LstAcompanhamentoCaixa.Cells[5, xRow+1] := '3';
    LstAcompanhamentoCaixa.Cells[4, xRow+1] := FdMemCaixaEmbalagem.FieldByName('observacao').AsString;
    LstAcompanhamentoCaixa.Alignments[0 ,xRow+1] := taRightJustify;
    LstAcompanhamentoCaixa.FontStyles[0, xRow+1] := [FsBold];
    LstAcompanhamentoCaixa.Alignments[1, xRow+1] := taCenter;
    LstAcompanhamentoCaixa.Alignments[2, xRow+1] := taCenter;
    LstAcompanhamentoCaixa.Alignments[3, xRow+1] := taRightJustify;
    LstAcompanhamentoCaixa.Alignments[5, xRow+1] := taCenter;
    Inc(xRow);
    FdMemCaixaEmbalagem.Next;
  End;
end;

procedure TFrmVolumeEmbalagem.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtEmbalagemId.Text := LstCadastro.Cells[0, aRow];
  EdtEmbalagemIdExit(EdtEmbalagemId);
end;

function TFrmVolumeEmbalagem.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaVolumeEmbalagem(StrToIntDef(EdtConteudoPesq.Text, 0), '')
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaVolumeEmbalagem(-1, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmVolumeEmbalagem.SalvarReg: Boolean;
begin
  With ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem do begin
    EmbalagemId    := StrToIntDef(EdtEmbalagemId.Text, 0);
    Descricao      := EdtDescricao.Text;
    case CbTipo.ItemIndex of
      0: Tipo := 'R';
      1: Tipo := 'P';
      2: Tipo := 'C';
      3: Tipo := 'U';
      Else Tipo := '';
    end;
    Identificacao := EdtIdentificacao.Text;
    Tara        := EdtPeso.Value;
    Altura      := EdtAltura.Value;
    Largura     := EdtLargura.Value;
    Comprimento := EdtComprimento.value;
    Aproveitamento := Round(EdtAproveitamento.Value);
    Capacidade  := EdtCapacidade.Value;
    QtdLacres   := Round(EdtQtdLacres.Value);
    PrecoCusto  := EdtPrecoCusto.Value;
    CodBarras   := Ord(ChkCodigoBarras.Checked);
    Disponivel := Ord(ChkDisponivel.Checked);
    Status := Ord(ChkCadastro.Checked);
  end;
  Result := ObjVolumeEmbalagemCtrl.Salvar;
  if Result then ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId := 0;
end;

procedure TFrmVolumeEmbalagem.EdtCaixaSearchInvokeSearch(Sender: TObject);
Var xRow : Integer;
begin
  inherited;
  for xRow := 1 to Pred(LstAcompanhamentoCaixa.RowCount) do Begin
    if LstAcompanhamentoCaixa.Cells[0, xRow] = EdtCaixaSearch.Text then Begin
       LstAcompanhamentoCaixa.Row := xRow;
       Break;
    End;
  End;
end;

procedure TFrmVolumeEmbalagem.ShowAcompanhamentoCaixas;
Var ObjCaixaEmbalagemCtrl : TCaixaEmbalagemCtrl;
    JsonObjectRetorno     : TJsonObject;
    JsonArrayRetorno      : TJsonArray;
    vErro : String;
    xReg, xPaginacao, xTotalCaixa : Integer;
begin
   //TmGetCaixa.Enabled := True;
   If FDMemCaixaEmbalagem.Active then
      FDMemCaixaEmbalagem.EmptyDataSet;
   FDMemCaixaEmbalagem.Close;
   TDialogMessage.ShowWaitMessage('Buscando Dados...',
   Procedure
   begin
     xPaginacao  := 1;
     xTotalCaixa := 0;
     Repeat
       JsonObjectRetorno := ObjCaixaEmbalagemCtrl.GetCaixaEmbalagemListaPaginacao(0, StrToIntDef(EdtCaixaIniSearch.Text, 0), StrToIntDef(EdtCaixaFinSearch.Text, 0),
                            StrToIntDef(EdtEmbalagemId.Text, 0), 'A', 99, xPaginacao);
       xTotalCaixa := JsonObjectRetorno.GetValue<Integer>('registro', 0);
       JsonArrayRetorno := JsonObjectRetorno.GetValue<TJsonArray>('caixas');
       if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
          JsonArrayRetorno := Nil;
          FreeAndNil(ObjCaixaEmbalagemCtrl);
          raise Exception.Create(vErro);
          //JsonRetorno.Free;
       End;
       If FDMemCaixaEmbalagemTEMP.Active then
          FDMemCaixaEmbalagemTEMP.EmptyDataSet;
       FDMemCaixaEmbalagemTEMP.Close;
       FDMemCaixaEmbalagemTEMP.LoadFromJSON(JsonArrayRetorno, False);
       FDMemCaixaEmbalagem.AppendData(FDMemCaixaEmbalagemTEMP);
       Inc(xPaginacao);
       xReg := FDMemCaixaEmbalagem.RecordCount;
     Until ((xPaginacao-1) * 4000) > xTotalCaixa;
     xReg := FDMemCaixaEmbalagem.RecordCount;
     MontaListaAcompanhamentoCaixas;
     JsonObjectRetorno := Nil;
     JsonArrayRetorno  := Nil;
     FreeAndNil(ObjCaixaEmbalagemCtrl);
   End);
end;

procedure TFrmVolumeEmbalagem.ShowDados;
begin
  inherited;
  With ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem do Begin
    If EmbalagemId <> 0 Then Begin
       PgcBase.ActivePage     := TabPrincipal;
       EnabledButtons         := True;
    End;
    EdtEmbalagemId.Text := EmbalagemId.ToString();
    edtDescricao.Text   := Descricao;
    if Tipo = 'R' then CbTipo.ItemIndex := 0
    Else if Tipo = 'P' then CbTipo.ItemIndex := 1
    Else if Tipo = 'C' then CbTipo.ItemIndex := 2
    Else CbTipo.ItemIndex   := 3;
    EdtIdentificacao.Text   := Identificacao;
    EdtPeso.Value           := Tara;
    EdtAltura.Value         := Altura;
    EdtLargura.Value        := Largura;
    EdtComprimento.Value    := Comprimento;
    EdtVolume.Value         := Volume;
    EdtCapacidade.Value     := Capacidade;
    EdtAproveitamento.value := Aproveitamento;
    EdtQtdLacres.Value      := QtdLacres;
    EdtPrecoCusto.Value     := PrecoCusto;
    ChkCodigoBarras.Checked := CodBarras = 1;
    ChkDisponivel.Checked   := Disponivel = 1;
    ChkCadastro.Checked     := Status = 1;
    EdtDescricaoCaixa.Text  := EdtDescricao.Text;
    EdtIdentificacaoCaixa.Text := EdtIdentificacao.Text;
  End;
  LblTotCaixa.Caption     := '0';
  TabCaixas.TabVisible    := True;
  //ShowAcompanhamentoCaixas;
end;

procedure TFrmVolumeEmbalagem.TabCaixasShow(Sender: TObject);
begin
  inherited;
  EdtCaixaIdInicial.ReadOnly     := False;
  EdtCaixaIdFinal.ReadOnly       := False;
  EdtCaixaIniSearch.ReadOnly     := False;
  EdtCaixaFinSearch.ReadOnly     := False;
  ChkSequenciaAutomatica.Enabled := True;
end;

procedure TFrmVolumeEmbalagem.ThreadTerminateAcompanhamentoCaixas(Sender: TObject);
begin
  TmGetCaixa.Enabled  := False;
  PnlGetCaixa.Visible := False;
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then begin
        ShowErro('Não foi possível exibir as Caixas!');
        exit;
     end
     Else Begin
        TabCaixas.TabVisible := True;
     End;
  end;
end;

procedure TFrmVolumeEmbalagem.TmGetCaixaTimer(Sender: TObject);
begin
  inherited;
  PnlGetCaixa.Visible := Not PnlGetCaixa.Visible;
end;

end.
