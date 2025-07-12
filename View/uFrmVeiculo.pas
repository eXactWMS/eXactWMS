unit uFrmVeiculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid,
  cxPC, Vcl.Buttons, JvToolEdit, JvBaseEdits, System.JSON, REST.Json, Rest.Types
  , VeiculoCtrl
  , PessoaCtrl, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  Vcl.ComCtrls, Vcl.DBGrids, dxCameraControl;

type
  TFrmVeiculo = class(TFrmBase)
    EdtVeiculoId: TLabeledEdit;
    btnPesqVeiculo: TBitBtn;
    Label2: TLabel;
    CbProcedencia: TComboBox;
    CbTipo: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    CbMarca: TComboBox;
    CbModelo: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    CbAnoFabricacao: TComboBox;
    CbAnoModelo: TComboBox;
    Label7: TLabel;
    CbChassiTipo: TComboBox;
    Label8: TLabel;
    EdtChassiNumero: TEdit;
    Label9: TLabel;
    EdtPlaca: TEdit;
    Label10: TLabel;
    CbCarroceria: TComboBox;
    Label11: TLabel;
    EdtRenavam: TEdit;
    EdtMotoNumero: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    CbCor: TComboBox;
    Label14: TLabel;
    CbCombustivel: TComboBox;
    GroupBox2: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    EdtAltura: TJvCalcEdit;
    EdtLargura: TJvCalcEdit;
    EdtComprimento: TJvCalcEdit;
    EdtVolume: TJvCalcEdit;
    EdtAproveitamento: TJvCalcEdit;
    Label21: TLabel;
    EdtCapacidade: TJvCalcEdit;
    EdtTara: TJvCalcEdit;
    Label15: TLabel;
    ChkRastreado: TCheckBox;
    ChkSegurado: TCheckBox;
    EdtTransportadoraId: TLabeledEdit;
    BtnPesqTransportadora: TBitBtn;
    LblTransportadora: TLabel;
    procedure EdtVeiculoIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtVeiculoIdExit(Sender: TObject);
    procedure EdtAlturaChange(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure EdtTransportadoraIdExit(Sender: TObject);
    procedure EdtTransportadoraIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtVeiculoIdChange(Sender: TObject);
    procedure BtnPesqTransportadoraClick(Sender: TObject);
  private
    { Private declarations }
    ObjVeiculoCtrl : TVeiculoCtrl;
    Function GetListaVeiculos(pVeiculoId : Integer; pPlaca : String; pTransportadoraId : Integer; pRecsSkip : Integer) : Boolean;
    Function GetTransportadora(pTransportadoraId : Integer) : String;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmVeiculo: TFrmVeiculo;

implementation

{$R *.dfm}

uses uFuncoes, Views.Pequisa.Pessoas;

procedure TFrmVeiculo.BtnEditarClick(Sender: TObject);
begin
  inherited;
  CbProcedencia.SetFocus;
end;

procedure TFrmVeiculo.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbProcedencia.SetFocus;
end;

procedure TFrmVeiculo.BtnPesqTransportadoraClick(Sender: TObject);
begin
  if EdtTransportadoraid.ReadOnly then Exit;
  inherited;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 3;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtTransportadoraid.Text := FrmPesquisaPessoas.Tag.ToString();
       EdtTransportadoraidExit(EdtTransportadoraid);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

function TFrmVeiculo.DeleteReg: Boolean;
begin
  ObjVeiculoCtrl.ObjVeiculo.VeiculoId := StrToIntDef(EdtVeiculoId.Text, 0);
  Result := ObjVeiculoCtrl.DelVeiculo;
end;

procedure TFrmVeiculo.EdtAlturaChange(Sender: TObject);
begin
  inherited;
//  if (Not TJvCalcEdit(Sender).ReadOnly) then
     EdtVolume.Value := EdtAltura.Value * EdtLargura.Value * EdtComprimento.Value;
end;

procedure TFrmVeiculo.EdtTransportadoraIdExit(Sender: TObject);
begin
  inherited;
  if (Not EdtTransportadoraId.ReadOnly) and (EdtTransportadoraId.Text<>'') then
     LblTransportadora.Caption := GetTransportadora(StrToIntDef(EdtTransportadoraId.Text, 0));
end;

procedure TFrmVeiculo.EdtTransportadoraIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Not EdtTransportadoraId.ReadOnly then LblTransportadora.Caption := '';  
end;

procedure TFrmVeiculo.EdtVeiculoIdChange(Sender: TObject);
begin
  inherited;
  if (Sender=EdtVeiculoId)  and (Not EdtVeiculoId.ReadOnly) and (StrToIntDef(EdtVeiculoId.Text, 0)<>ObjVeiculoCtrl.ObjVeiculo.VeiculoId) then
     Limpar;
end;

procedure TFrmVeiculo.EdtVeiculoIdExit(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    vErro : String;
begin
  if (EdtVeiculoId.Text<>'') and (StrToIntDef(EdtVeiculoId.Text, 0) <= 0) then Begin
     EdtVeiculoId.SetFocus;
     ShowErro('Id('+EdtVeiculoId.Text+') de Veículo inválido!');
     EdtVeiculoId.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtVeiculoId.ReadOnly) and (EdtVeiculoId.Text<>'') and (StrToIntDef(EdtVeiculoId.Text,0)<>ObjVeiculoCtrl.ObjVeiculo.VeiculoId) then Begin
     Limpar;
     if StrToIntDef(EdtVeiculoId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtVeiculoId.Text+') inválido!');
     ReturnJsonArray := ObjVeiculoCtrl.GetVeiculo(StrToIntDef(EdtVeiculoId.Text, 0), '', 0, 1);
     if ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
        ShowErro('Erro: '+vErro);
        Exit;
     End;
     ObjVeiculoCtrl.ObjVeiculo := ObjVeiculoCtrl.ObjVeiculo.JsonToClass((ReturnJsonArray.Get(0) as TJsonObject).ToJSON);
     if ObjVeiculoCtrl.ObjVeiculo.VeiculoId > 0 then Begin
        ShowDados;
     End;
  End;
end;

procedure TFrmVeiculo.EdtVeiculoIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmVeiculo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmVeiculo := Nil;
end;

procedure TFrmVeiculo.FormCreate(Sender: TObject);
Var xAno : Integer;
begin
  inherited;
  ObjVeiculoCtrl := TVeiculoCtrl.Create;
  LstCadastro.ColWidths[0]  := 	70;
  LstCadastro.ColWidths[1]  := 120;
  LstCadastro.ColWidths[2]  := 150;
  LstCadastro.ColWidths[3]  := 150;
  LstCadastro.ColWidths[4]  := 150;
  LstCadastro.ColWidths[5]  := 120;
  LstCadastro.ColWidths[6]  := 140;
  LstCadastro.ColWidths[7]  := 120;
  LstCadastro.ColWidths[8]  := 130;
  LstCadastro.ColWidths[9]  := 250;
  LstCadastro.ColWidths[10] := 60;
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[6, 0] := taRightJustify;
  LstCadastro.Alignments[7, 0] := taRightJustify;
  LstCadastro.Alignments[8, 0] := taRightJustify;
  LstCadastro.Alignments[10, 0] := taCenter;
  LstCadastro.SortSettings.Column := 1;
  LstCadastro.QSort;
  AdvGridLookupBar1.Column := 1;
  for xAno := 2022 to StrToInt(Copy(DateToStr(Date), 7, 4)) do Begin
    CbAnoFabricacao.Items.Add(xAno.ToString);
    CbAnoModelo.Items.Add(xAno.ToString);
  End;
//  GetListaVeiculos(0, '', 0, 0);
end;

procedure TFrmVeiculo.FormDestroy(Sender: TObject);
begin
  inherited;
  ObjVeiculoCtrl := Nil;
end;

procedure TFrmVeiculo.GetListaLstCadastro;
begin
  inherited;
  GetListaVeiculos(0, '', 0, 0)
end;

function TFrmVeiculo.GetListaVeiculos(pVeiculoId: Integer; pPlaca: String;
  pTransportadoraId, pRecsSkip: Integer): Boolean;
Var xReturn         : Integer;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
  ReturnJsonArray      := ObjVeiculoCtrl.GetVeiculo(pVeiculoId, pPlaca, pTransportadoraId, 0);
  LstCadastro.RowCount := 1;
  If ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
     Result := False;
     Exit;
  End;
  LstCadastro.RowCount  := ReturnJsonArray.Count+1;
  Result := ReturnJsonArray.Count >= 1;
  If ReturnJsonArray.Count >= 1 then Begin
     LstCadastro.FixedRows := 1;
     for xReturn := 1 to LstCadastro.RowCount do
       LstCadastro.AddDataImage(10, xReturn, 0, haCenter, vaTop);
     For xReturn := 0 To ReturnJsonArray.Count-1 do begin
       LstCadastro.Cells[0, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('veiculoid').ToString();
       LstCadastro.Cells[1, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('placa', '');
       LstCadastro.Cells[2, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('cor', '');
       LstCadastro.Cells[3, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('tipo', '');
       LstCadastro.Cells[4, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<String>('marca', '');
       LstCadastro.Cells[5, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('carroceriatipo');
       LstCadastro.Cells[6, xReturn+1] := FormatFloat('0.00', ReturnJsonArray.Get(xReturn).GetValue<Double>('altura', 8)*
                                                              ReturnJsonArray.Get(xReturn).GetValue<Double>('largura', 8)*
                                                              ReturnJsonArray.Get(xReturn).GetValue<Double>('comprimento', 8));
       LstCadastro.Cells[7, xReturn+1] := FormatFloat('0.00', ReturnJsonArray.Get(xReturn).GetValue<Double>('aproveitamento', 100));
       LstCadastro.Cells[8, xReturn+1] := FormatFloat('0.000', ReturnJsonArray.Get(xReturn).GetValue<Double>('capacidadekg', 0));
       LstCadastro.Cells[9, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<String>('transportadoraid', '')+ ' '+
                                          ReturnJsonArray.Get(xReturn).GetValue<String>('transportadora', '');
       LstCadastro.Cells[10, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('status', 1).ToString;
       LstCadastro.Alignments[0, xReturn+1] := taRightJustify;
       LstCadastro.FontStyles[0, xReturn+1] := [FsBold];
       LstCadastro.Alignments[6, xReturn+1] := taRightJustify;
       LstCadastro.Alignments[7, xReturn+1] := taRightJustify;
       LstCadastro.Alignments[8, xReturn+1] := taRightJustify;
       LstCadastro.Alignments[10, xReturn+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
     ReturnJsonArray := Nil;
  End;
end;

function TFrmVeiculo.GetTransportadora(pTransportadoraId: Integer): String;
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  if pTransportadoraId <= 0 then Begin
     Result := '';
     Exit;
  End;
  ObjPessoaCtrl   := TPessoaCtrl.Create;
  ReturnJsonArray := ObjPessoaCtrl.FindPessoa(pTransportadoraId, 0, '', '', 3, 1);
  if ReturnJsonArray.Count < 1 then Exit;
  if ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     Exit;
  End
  Else
     Result := ReturnJsonArray.Get(0).GetValue<String>('razao');
  ObjPessoaCtrl.Free;
end;

procedure TFrmVeiculo.Limpar;
begin
  EnabledButtons := False;
  if Not (EdtVeiculoId.Enabled) then
     EdtVeiculoId.Clear;
  If Assigned(ObjVeiculoCtrl) Then ObjVeiculoCtrl.ObjVeiculo.Limpar;
  CbProcedencia.ItemIndex := -1;
  EdtPlaca.Clear;
  CbTipo.ItemIndex          := -1;
  CbMarca.ItemIndex         := -1;
  CbModelo.ItemIndex        := -1;
  CbAnoFabricacao.ItemIndex := -1;
  CbAnoModelo.ItemIndex     := -1;
  CbCarroceria.ItemIndex    := -1;
  CbChassiTipo.ItemIndex    := -1;
  EdtChassiNumero.Clear;
  EdtRenavam.Clear;
  EdtMotoNumero.Clear;
  CbCor.ItemIndex           := -1;
  CbCombustivel.ItemIndex   := -1;
  EdtTara.Value             := 0;
  EdtCapacidade.Value       := 0;
  EdtAltura.Value           := 0;
  EdtLargura.Value          := 0;
  EdtComprimento.Value      := 0;
  EdtVolume.Value           := 0;
  EdtAproveitamento.Value   := 0;
  ChkRastreado.Checked      := False;
  ChkSegurado.Checked       := False;
  EdtTransportadoraId.Clear;
  LblTransportadora.Caption := '';
  ChkCadastro.Checked       := False;
end;

procedure TFrmVeiculo.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtVeiculoId.Text := LstCadastro.Cells[0, aRow];
  EdtVeiculoIdExit(EdtVeiculoId);
end;

function TFrmVeiculo.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if (CbCampoPesq.ItemIndex = 0) then
        Result := GetListaVeiculos(StrToIntDef(EdtConteudoPesq.Text, 0), '', 0, 0)
     Else if CbCampoPesq.ItemIndex = 1 then
        Result := GetListaVeiculos(0, EdtConteudoPesq.Text, 0, 0)
     Else if CbCampoPesq.ItemIndex = 2 then
        Result := GetListaVeiculos(0, '', StrToIntDef(EdtConteudoPesq.Text, 0), 0);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmVeiculo.SalvarReg: Boolean;
begin
  Try
    ObjVeiculoCtrl.ObjVeiculo.VeiculoId        := StrToIntDef(EdtVeiculoId.Text, 0);
    if CbProcedencia.ItemIndex = 0 then
       ObjVeiculoCtrl.ObjVeiculo.Procedencia := 'I'
    Else ObjVeiculoCtrl.ObjVeiculo.Procedencia := 'N';
  //  ObjVeiculoCtrl.ObjVeiculo.ProcedenciaDescr := '';
    ObjVeiculoCtrl.ObjVeiculo.Placa            := EdtPlaca.Text;
    ObjVeiculoCtrl.ObjVeiculo.Tipo             := CbTipo.Text;
    ObjVeiculoCtrl.ObjVeiculo.Marca            := CbMarca.Text;
    ObjVeiculoCtrl.ObjVeiculo.Modelo           := CbModelo.Text;
    ObjVeiculoCtrl.ObjVeiculo.AnoFabricacaoModelo := CbAnoFabricacao.Text+CbAnoModelo.Text;
    ObjVeiculoCtrl.ObjVeiculo.ChassiTipo       := CbChassiTipo.Text; //1 Monobloco - 2 Monobloco Estrutura   3 Chassi Tunel Central   4 Chassi de Longarina   5 Subchassi
  //  ObjVeiculoCtrl.ObjVeiculo.ChassiTipoDescr  := ;
    ObjVeiculoCtrl.ObjVeiculo.ChassiNumero     := EdtChassiNumero.Text;
    ObjVeiculoCtrl.ObjVeiculo.CarroceriaTipo   := CbCarroceria.Text;
  //  ObjVeiculoCtrl.ObjVeiculo.CarroceriaDescr  := ;
    ObjVeiculoCtrl.ObjVeiculo.Renavam          := EdtRenavam.Text;
    ObjVeiculoCtrl.ObjVeiculo.MotorNumero      := EdtMotoNumero.Text;
    ObjVeiculoCtrl.ObjVeiculo.Cor              := CbCor.Text;
    if CbCombustivel.ItemIndex = 0 then
       ObjVeiculoCtrl.ObjVeiculo.CombustivelTipo := 'E'
    Else if CbCombustivel.ItemIndex = 1 then
       ObjVeiculoCtrl.ObjVeiculo.CombustivelTipo := 'D'
    Else If CbCombustivel.ItemIndex = 2 then
       ObjVeiculoCtrl.ObjVeiculo.CombustivelTipo := 'F'
    Else
       ObjVeiculoCtrl.ObjVeiculo.CombustivelTipo := 'G';
    ObjVeiculoCtrl.ObjVeiculo.TaraKg           := EdtTara.Value;
    ObjVeiculoCtrl.ObjVeiculo.Capacidadekg     := EdtCapacidade.Value;
    ObjVeiculoCtrl.ObjVeiculo.Altura           := EdtAltura.Value;
    ObjVeiculoCtrl.ObjVeiculo.Largura          := EdtLargura.Value;
    ObjVeiculoCtrl.ObjVeiculo.Comprimento      := EdtComprimento.Value;
    //ObjVeiculoCtrl.ObjVeiculo.Volume           := ;
    ObjVeiculoCtrl.ObjVeiculo.Aproveitamento   := EdtAproveitamento.Value;
    ObjVeiculoCtrl.ObjVeiculo.Rastreado        := Ord(ChkRastreado.Checked);
    ObjVeiculoCtrl.ObjVeiculo.Segurado         := Ord(ChkSegurado.Checked);
    ObjVeiculoCtrl.ObjVeiculo.TransportadoraId := StrToIntDef(EdtTransportadoraId.Text, 0);
    ObjVeiculoCtrl.ObjVeiculo.DtInclusao       := now();
    ObjVeiculoCtrl.ObjVeiculo.HrInclusao       := Time();
    ObjVeiculoCtrl.ObjVeiculo.Status           := Ord(ChkCadastro.Checked);
    Result := ObjVeiculoCtrl.Salvar;
    if Result then ObjVeiculoCtrl.ObjVeiculo.VeiculoId := 0;
  Except On E: Exception do Begin
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmVeiculo.ShowDados;
begin
  inherited;
  EdtVeiculoId.Text := ObjVeiculoCtrl.ObjVeiculo.VeiculoId.ToString();
  If ObjVeiculoCtrl.ObjVeiculo.Procedencia = 'N' then
     CbProcedencia.ItemIndex := 1
  Else CbProcedencia.ItemIndex := 0;
  //ObjVeiculoCtrl.ObjVeiculo.ProcedenciaDescr;
  EdtPlaca.Text      := ObjVeiculoCtrl.ObjVeiculo.Placa;
  CbTipo.ItemIndex   := CbTipo.Items.IndexOf(ObjVeiculoCtrl.ObjVeiculo.Tipo);
  CbMarca.ItemIndex  := CbMarca.Items.IndexOf(ObjVeiculoCtrl.ObjVeiculo.Marca);
  CbModelo.ItemIndex := CbModelo.Items.IndexOf(ObjVeiculoCtrl.ObjVeiculo.Modelo);
  CbAnoFabricacao.ItemIndex := CbAnoFabricacao.Items.IndexOf(Copy(ObjVeiculoCtrl.ObjVeiculo.AnoFabricacaoModelo, 1, 4));
  CbAnoModelo.ItemIndex     := CbAnoModelo.Items.IndexOf(Copy(ObjVeiculoCtrl.ObjVeiculo.AnoFabricacaoModelo, 5, 4));
  CbCarroceria.ItemIndex    := CbCarroceria.Items.IndexOf(ObjVeiculoCtrl.ObjVeiculo.CarroceriaTipo);
  //ObjVeiculoCtrl.ObjVeiculo.CarroceriaDescr;
  CbChassiTipo.ItemIndex    := CbChassiTipo.Items.IndexOf(ObjVeiculoCtrl.ObjVeiculo.ChassiTipo);
  //ObjVeiculoCtrl.ObjVeiculo.ChassiTipoDescr;
  EdtChassiNumero.Text      := ObjVeiculoCtrl.ObjVeiculo.ChassiNumero;
  EdtRenavam.Text           := ObjVeiculoCtrl.ObjVeiculo.Renavam;
  EdtMotoNumero.Text        := ObjVeiculoCtrl.ObjVeiculo.MotorNumero;
  CbCor.ItemIndex           := CbCor.Items.Indexof(ObjVeiculoCtrl.ObjVeiculo.Cor);
  CbCombustivel.ItemIndex   := CbCombustivel.Items.IndexOf(ObjVeiculoCtrl.ObjVeiculo.Combustivel);
  //ObjVeiculoCtrl.ObjVeiculo.Combustivel;
  EdtTara.Value             :=  ObjVeiculoCtrl.ObjVeiculo.TaraKg;
  EdtCapacidade.Value       := ObjVeiculoCtrl.ObjVeiculo.CapacidadeKg;
  EdtAltura.Value           := ObjVeiculoCtrl.ObjVeiculo.Altura;
  EdtLargura.Value          := ObjVeiculoCtrl.ObjVeiculo.Largura;
  EdtComprimento.Value      := ObjVeiculoCtrl.ObjVeiculo.Comprimento;
  //EdtVolume.Value           := ObjVeiculoCtrl.ObjVeiculo.Volume;
  EdtAproveitamento.Value   := ObjVeiculoCtrl.ObjVeiculo.AProveitamento;
  ChkRastreado.Checked      := ObjVeiculoCtrl.ObjVeiculo.Rastreado = 1;
  ChkSegurado.Checked       := ObjVeiculoCtrl.ObjVeiculo.Segurado = 1;
  EdtTransportadoraId.Text  := IfThen(ObjVeiculoCtrl.ObjVeiculo.TransportadoraId>0, ObjVeiculoCtrl.ObjVeiculo.TransportadoraId.ToString(), '');
  LblTransportadora.Caption := GetTransportadora(ObjVeiculoCtrl.ObjVeiculo.TransportadoraId);
  //ObjVeiculoCtrl.ObjVeiculo.DtInclusao;
  //ObjVeiculoCtrl.ObjVeiculo.HrInclusao;
  ChkCadastro.Checked       := ObjVeiculoCtrl.ObjVeiculo.Status = 1;
end;

end.
