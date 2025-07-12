Unit uFrmMovimentacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Gestures, System.Actions, FMX.ActnList, FMX.TabControl,
  FMX.Edit, FMX.Layouts, FMX.Grid, FMX.ListView, FMX.Controls.Presentation,
  FMX.Objects, FMX.ListBox, uFuncoes, uMyTabOrderClassHelper, uTProdutoColetor,
  uDmClient, Data.FireDACJSONReflect, uTEnderecoColetor, FMX.Effects, FMX.Ani, ksTypes,
  ksLoadingIndicator, FMX.Grid.Style, FMX.ScrollBox
  {$IFDEF IOS}
      ,Macapi.Helpers
  {$ENDIF IOS}
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os
  {$Endif};

type
  TFrmMovimentacao = class(TFrmBase)
    PgcMovimentacao: TTabControl;
    TbArmazenagem: TTabItem;
    TbPickPallet: TTabItem;
    TbPalletPick: TTabItem;
    TbPalletPallet: TTabItem;
    TbPalletAll: TTabItem;
    Label1: TLabel;
    LBlProdutoArm: TLabel;
    LblEnderecoArm: TLabel;
    LblZerado: TLabel;
    Label3: TLabel;
    LblEstoqueArm: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    QryEstoqueEspera: TFDMemTable;
    EdtCodProdArm: TEdit;
    CbLoteArm: TComboBox;
    EdtQtdMovimentadaArm: TEdit;
    EdtEnderecoDestinoArm: TEdit;
    RctPick: TRectangle;
    Label4: TLabel;
    EdtPickingPF: TEdit;
    Label7: TLabel;
    RctPallet: TRectangle;
    EdtPalletPF: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    LblLotePF: TLabel;
    LblVencimentoPF: TLabel;
    EdtProdutoPF: TEdit;
    LblEstoquePF: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EdtQtdMovPF: TEdit;
    EdtPickConfPF: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    RctPalletPick: TRectangle;
    Label2: TLabel;
    CbMovimentacao: TComboBox;
    QryEstoquePalletPF: TFDMemTable;
    QryEstoque: TFDMemTable;
    Rectangle1: TRectangle;
    EdtPalletPP: TEdit;
    Label10: TLabel;
    EdtCdProdutoPP: TEdit;
    Label11: TLabel;
    Label19: TLabel;
    CbLotePP: TComboBox;
    LblEstoquePP: TLabel;
    Label21: TLabel;
    EdtQtdMovPP: TEdit;
    Label22: TLabel;
    EdtPalletDestPP: TEdit;
    Label12: TLabel;
    LblPickProdPP: TLabel;
    LblEstPickPP: TLabel;
    LblProdutoPP: TLabel;
    QryEstoquePP: TFDMemTable;
    Rectangle2: TRectangle;
    EdtPalletOrigemPA: TEdit;
    Label18: TLabel;
    Label20: TLabel;
    Rectangle3: TRectangle;
    EdtPalletDestinoPA: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Rectangle4: TRectangle;
    EdtPickFP: TEdit;
    Label26: TLabel;
    LblLoteFP: TLabel;
    LblVenctoFP: TLabel;
    LblEstoqueFP: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    EdtQtdMovFP: TEdit;
    EdtPalletFP: TEdit;
    Label34: TLabel;
    EdtProdutoFP: TEdit;
    RctMensBcg: TRectangle;
    ColorAnimation1: TColorAnimation;
    RctMens: TRectangle;
    LblConfMens: TLabel;
    LblMens1: TLabel;
    LblMens2: TLabel;
    LblMens3: TLabel;
    LblMens4: TLabel;
    LblMens5: TLabel;
    ShadowEffect1: TShadowEffect;
    RctPickPallet: TRectangle;
    RctArmazenagem: TRectangle;
    RctPalletAll: TRectangle;
    RctPalletPallet: TRectangle;
    QryEstoqueFP: TFDMemTable;
    Rectangle5: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    BtnConfirmaMov: TButton;
    BtnCancelar: TButton;
    GlowEffect1: TGlowEffect;
    GlowEffect2: TGlowEffect;
    TbCrossDockingRetirar: TTabItem;
    RctCrossdockRetirar: TRectangle;
    CbLoteCrossRet: TComboBox;
    EdtPalletCrossRet: TEdit;
    EdtQtdMovCrossRet: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label35: TLabel;
    LblEstCrossRet: TLabel;
    Rectangle7: TRectangle;
    EdtCrossDocking: TEdit;
    Label37: TLabel;
    EdtCdProdCrossRet: TEdit;
    Label38: TLabel;
    LblEstPickCrossRet: TLabel;
    LblPickCrossRet: TLabel;
    LblProdCrossRet: TLabel;
    QryEstoqueCross: TFDMemTable;
    procedure FormCreate(Sender: TObject);
    procedure EdtCodProdArmKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodProdArmValidate(Sender: TObject; var Text: string);
    procedure CbLoteArmChange(Sender: TObject);
    procedure EdtQtdMovimentadaArmKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtQtdMovimentadaArmValidate(Sender: TObject; var Text: string);
    procedure EdtEnderecoDestinoArmValidate(Sender: TObject; var Text: string);
    procedure CbMovimentacaoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPickConfPFValidate(Sender: TObject; var Text: string);
    procedure EdtPickingPFValidate(Sender: TObject; var Text: string);
    procedure EdtPalletPFValidate(Sender: TObject; var Text: string);
    procedure EdtQtdMovPFValidate(Sender: TObject; var Text: string);
    procedure EdtEnderecoDestinoArmTyping(Sender: TObject);
    procedure EdtCdProdutoPPValidate(Sender: TObject; var Text: string);
    procedure EdtPalletPPValidate(Sender: TObject; var Text: string);
    procedure EdtPalletDestPPValidate(Sender: TObject; var Text: string);
    procedure EdtQtdMovPPValidate(Sender: TObject; var Text: string);
    procedure EdtCdProdutoPPTyping(Sender: TObject);
    procedure EdtPalletOrigemPAValidate(Sender: TObject; var Text: string);
    procedure EdtPalletDestinoPATyping(Sender: TObject);
    procedure EdtQtdMovFPValidate(Sender: TObject; var Text: string);
    procedure EdtPickFPValidate(Sender: TObject; var Text: string);
    procedure EdtPalletFPTyping(Sender: TObject);
    procedure EdtPalletFPValidate(Sender: TObject; var Text: string);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure EdtPickFPKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtPickConfPFTyping(Sender: TObject);
    procedure BtnConfirmaMovClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdtPalletFPEnter(Sender: TObject);
    procedure EdtPalletPFEnter(Sender: TObject);
    procedure EdtPickFPTyping(Sender: TObject);
    procedure EdtPickingPFTyping(Sender: TObject);
    procedure EdtPalletPPTyping(Sender: TObject);
    procedure EdtPalletOrigemPATyping(Sender: TObject);
    procedure EdtCdProdCrossRetValidate(Sender: TObject; var Text: string);
    procedure EdtCdProdCrossRetTyping(Sender: TObject);
    procedure CbLoteCrossRetChange(Sender: TObject);
    procedure EdtQtdMovCrossRetValidate(Sender: TObject; var Text: string);
    procedure EdtPalletCrossRetValidate(Sender: TObject; var Text: string);
  private
    { Private declarations }
    ObjProduto, ObjProdutoPP, ObjProdutoCrossRet : TProdutoColetor;
    ObjPickPick, ObjEndDestinoArm, ObjPalletPP, ObjPalletDestPP : TEnderecoColetor;
    ObjPalletOrigemPA, ObjPalletDestinoPA, ObjPickFP, ObjPalletFP, ObjPalletCrossRet : TEnderecoColetor;

    vProdutoPF, vProdutoFP : Int64;
    //Confirmação do Movimento
    vlMensagem, vlOrigem, vlDestino : String;
    vQtdMov, vQtdMovPP : Integer;

    Procedure LimparArmazenagem(Inicio : Boolean);
    Procedure LimparCrossdockingRet(Inicio : Boolean);
    Procedure LimparPalletAll(Inicio : Boolean);
    Procedure LimparPalletPick(Inicio : Boolean);
    Procedure LimparPalletPallet(Inicio : Boolean);
    Procedure LimparPickPallet(Inicio :  Boolean);
    Procedure GetEstoqueEspera(vCdProduto : Int64);
    Function GetProduto(vCdProduto : String) : TProdutoColetor;
    Function GetProdutoPP(vCdProduto: String): TProdutoColetor;
    Procedure SalvarMovimentacao;
    procedure GetEstoqueProducao(vCdProduto: Int64; pNmEndereco: String; vQuery : TFdMemTable);
    Procedure GetEstoqueCrossDocking(vCdProduto: Int64; vQuery : TFdMemTable);
    Procedure Limpar;
    procedure PositionField;
    Procedure ConfirmMov(vMensagem : String);
  public
    { Public declarations }
  end;

var
  FrmMovimentacao: TFrmMovimentacao;

implementation

{$R *.fmx}

uses uFrmeXactWMS, uRetorno;

procedure TFrmMovimentacao.Button1Click(Sender: TObject);
begin
  inherited;
  With FloatAnimation2 do Begin
    StartValue := (Self.Height /2) - (RctMens.Height/2);
    StopValue := -RctMens.Height;
    Start;
  End;
//  MensagemStand('Movimentação cancelada...');
  Limpar;
end;

procedure TFrmMovimentacao.BtnConfirmaMovClick(Sender: TObject);
begin
  inherited;
  SalvarMovimentacao;
  FloatAnimation2.StartValue := (Self.Height / 2) - (RctMens.Height /2);
  FloatAnimation2.StopValue  := -RctMens.Height;
  FloatAnimation2.Start;
end;

procedure TFrmMovimentacao.CbLoteArmChange(Sender: TObject);
begin
  inherited;
  if PgcMovimentacao.ActiveTab = TbArmazenagem then Begin
     QryEstoqueEspera.First;
     QryEstoqueEspera.MoveBy(CbLoteArm.ItemIndex);
     LblEstoqueArm.Text := 'Estoque: '+FormatFloat('####0', QryEstoqueEspera.FieldByName('Disponivel').AsInteger);
     EdtQtdMovimentadaArm.Text := '';
  End
  Else If PgcMovimentacao.ActiveTab = TbPalletPallet then Begin
     QryEstoquePP.First;
     QryEstoquePP.MoveBy(CbLotePP.ItemIndex);
     LblEstoquePP.Text := 'Estoque: '+FormatFloat('####0', QryEstoquePP.FieldByName('Disponivel').AsInteger);
     EdtQtdMovPP.Text := '';
  End;
end;

procedure TFrmMovimentacao.CbLoteCrossRetChange(Sender: TObject);
begin
  inherited;
  QryEstoqueCross.First;
  QryEstoqueCross.MoveBy(CbLoteCrossRet.ItemIndex);
  LblEstCrossRet.Text := 'Estoque: '+FormatFloat('####0', QryEstoqueCross.FieldByName('Disponivel').AsInteger);
  EdtQtdMovimentadaArm.Text := '';
end;

procedure TFrmMovimentacao.EdtEnderecoDestinoArmTyping(Sender: TObject);
begin
  inherited;
  if StrToIntDef(EdtQtdMovimentadaArm.Text, 0) <= 0 then Begin
     EdtEnderecoDestinoArm.Text := '';
     DelayedSetfocus(EdtQtdMovimentadaArm);
  End;
end;

procedure TFrmMovimentacao.EdtEnderecoDestinoArmValidate(Sender: TObject; var Text: string);
Var vQryEstPallet : TFDMemTable;
begin
  inherited;
  if Text='' then Exit;
  ObjEndDestinoArm := dmClient.GetEndereco(0, EdtEnderecoDestinoArm.Text);
  if (ObjEndDestinoArm = Nil) or (ObjEndDestinoArm.Codigo = 0) then Begin
     EdtEnderecoDestinoArm.Text := '';
     DelayedSetFocus(EdtEnderecoDestinoArm);
     raise Exception.Create('Endereco Inválido');
  End;
  if ObjEndDestinoArm.Status then Begin
     EdtEnderecoDestinoArm.Text := '';
     raise Exception.Create('O Endereço está bloqueado e não pode ser utilizado!');
  End;
  if (ObjEndDestinoArm.Tipo.Codigo = 1) and (ObjProduto.Endereco.Endereco<>ObjEndDestinoArm.Endereco) then Begin
     EdtEnderecoDestinoArm.Text := '';
     DelayedSetFocus(EdtEnderecoDestinoArm);
     raise Exception.Create('Endereço de Picking pertence a outro produto.');
  End
  Else if (ObjEndDestinoArm.Tipo.Codigo = 2) then Begin //Verificar se existe outro Lote do Produto neste Pallet
     vQryEstPallet := TFDMemTable.Create(Nil);
     GetEstoqueProducao(ObjProduto.Codigo, '', vQryEstPallet);
     if Not vQryEstPallet.IsEmpty then Begin
        vQryEstPallet.Filter := 'cdEndereco = '+ObjEndDestinoArm.Codigo.ToString()+
                                ' and NmLote <> '+QryEstoqueEspera.FieldByName('NmLote').AsString;
        vQryEstPallet.Filtered := True;
        if Not vQryEstPallet.IsEmpty then Begin
           Text := '';
           EdtEnderecoDestinoArm.Text := '';
           MensagemStand('Movimentação Inválida!'+#13+#13+
                'Não é permitido inserir dois Lotes diferentes do produto num único Pallet');
           Exit;
        End;
        FreeAndNil(vQryEstPallet);
        vQryEstPallet.DisposeOf;
     End;
  End;
  vlMensagem := '';
  if CbMovimentacao.ItemIndex = 0 then Begin // Movimentacao da Área de Transferência
     vlOrigem  := 'Área de Transferência';
     vlDestino := ObjEndDestinoArm.EnderecoFor;
     vQtdMov   := EdtQtdMovimentadaArm.Text.ToInteger;
     LblMens1.Text := 'Produto: ' + ObjProduto.Descricao;
     LblMens2.Text := 'Lote: ' + QryEstoqueEspera.FieldByName('NmLote').AsString;
  End;
  LblMens3.Text := 'End. Origem: ' + vlOrigem;
  LblMens4.Text := 'End. Destino: ' + vlDestino;
  LblMens5.Text := 'Quantidade: ' + EdtQtdMovimentadaArm.Text;
  Text := '';
  ConfirmMov(vlMensagem);
end;

procedure TFrmMovimentacao.EdtPalletOrigemPATyping(Sender: TObject);
begin
  inherited;
  LimparPalletAll(False);
end;

procedure TFrmMovimentacao.EdtPalletOrigemPAValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if Sender = EdtPalletOrigemPA then Begin
     ObjPalletOrigemPA := DmClient.GetEndereco(0, EdtPalletOrigemPA.Text);
     if (ObjPalletOrigemPA = Nil) or (ObjPalletOrigemPA.Codigo = 0) then Begin
        MensagemStand('Endereo Origem inválido!');
        Exit;
     End
     Else if ObjPalletOrigemPA.Tipo.Codigo = 1 then Begin
        MensagemStand('Endereço Origem dever ser um Pallet!');
        Exit;
     End;
     EdtPalletDestinoPA.ReadOnly := False;
     DelayedSetFocus(EdtPalletDestinoPA);
     Exit;
  End
  Else Begin
    if EdtPalletDestinoPA.Text = EdtPalletOrigemPA.Text then Begin
       MensagemStand('Endeo inválido.'+#13+'Informe um Pallet diferente.');
       Exit;
    End;
    ObjPalletDestinoPA := DmClient.GetEndereco(0, EdtPalletDestinoPA.Text);
     if (ObjPalletDestinoPA = Nil) or (ObjPalletDestinoPA.Codigo = 0) then Begin
        MensagemStand('Endereço Destino inválido!');
        Exit;
     End
     Else if ObjPalletDestinoPA.Tipo.Codigo = 1 then Begin
        MensagemStand('Endereço Destino dever ser um Pallet!');
        Exit;
     End;
  End;
  if ObjPalletDestinoPA.Status then Begin
     Text := '';
     raise Exception.Create('O Endereço está bloqueado e não pode ser utilizado!');
  End;
  GetEstoqueProducao(0, EdtPalletDestinoPA.Text, QryEstoque);
  if Not QryEstoque.IsEmpty then Begin
     MensagemStand('Pallert Destino deve está vazio!');
     Exit;
  End;
  LblMens1.Text := 'Todos os Produtos serão movimentados.';
  LblMens2.Text := '';
  LblMens3.Text := 'De: Pallet Origem: ' + ObjPalletOrigemPA.EnderecoFor;
  LblMens4.Text := '';
  LblMens5.Text := 'Para: Palletr Destino: ' + ObjPalletDestinoPa.EnderecoFor;
  Text := '';
  ConfirmMov(vlMensagem);
end;

procedure TFrmMovimentacao.EdtPalletCrossRetValidate(Sender: TObject;
  var Text: string);
Var vQuery : TFdMemTable;
begin
  inherited;
  if EdtPalletCrossRet.Text = '' then Exit;
  ObjPalletCrossRet := DmClient.GetEndereco(0, EdtPalletCrossRet.Text);
  if (ObjPalletCrossRet = Nil) or (ObjPalletCrossRet.Codigo = 0) Then Begin
     Text := '';
     MensagemStand('Endereço inválido...');
     EdtPalletCrossRet.Text := '';
     Exit;
  End;
  if ObjPalletCrossRet.Status then Begin
     Text := '';
     EdtPalletCrossRet.Text := '';
     raise Exception.Create('O Endereço está bloqueado e não pode ser utilizado!');
  End
  Else if (ObjPalletCrossRet.Tipo.Codigo = 1) and (ObjPalletCrossRet.EnderecoFor<>LblProdCrossRet.text)then Begin
     Text := '';
     EdtPalletCrossRet.Text := '';
     raise Exception.Create('O Endereço Picking não pertence a este produto!');
  End;
  vQuery := TFDMemTable.Create(Nil);
  GetEstoqueProducao(EdtCdProdCrossRet.Text.ToInt64(), ObjPalletCrossRet.Endereco, vQuery);
  With vQuery do While Not Eof do Begin
    if CbLoteCrossRet.Items.Strings[CbLoteCrossRet.ItemIndex] <> FieldByName('NmLote').AsString then
       raise Exception.Create('Não é possível armazenar lotes diferentes no mesmo Pallet!');
    Next;
  End;
  vlMensagem := '';
  vlOrigem   := 'CrossDocking';
  vlDestino  := EdtPalletCrossRet.Text;
  vQtdMovPP  := EdtQtdMovCrossRet.Text.ToInteger;
  LblMens1.Text := 'Produto: ' + LblProdCrossRet.Text;
  LblMens2.Text := 'Lote: ' + QryEstoqueCross.FieldByName('NmLote').AsString+
                ' - '+QryEstoqueCross.FieldByName('DtVencimento').AsString;
  LblMens3.Text := 'End. Origem: ' + 'CrossDocking';
  LblMens4.Text := 'End. Destino: ' + ObjPalletCrossRet.EnderecoFor;
  LblMens5.Text := 'Quantidade: ' + vQtdMovPP.ToString;
  Text := '';
  ConfirmMov(vlMensagem);
end;

procedure TFrmMovimentacao.EdtPalletDestinoPATyping(Sender: TObject);
begin
  inherited;
  if EdtPalletOrigemPA.Text = '' then Begin
     EdtPalletDestinoPA.Text     := '';
     EdtPalletDestinoPA.ReadOnly := True;
     DelayedSetFocus(EdtPalletOrigemPA);
  End;
end;

procedure TFrmMovimentacao.EdtPalletDestPPValidate(Sender: TObject;
  var Text: string);
Var vQuery : TFdMemTable;
begin
  inherited;
  if EdtPalletDestPP.Text = '' then Exit;
  if (Text <> '')  and (Text = EdtPalletPP.Text) then Begin
     MensagemStand('Confirmação inválida!' + #13 +
                'O Pallet Destino deve ser diferente da Origem.');
     Text := '';
     DelayedSetFocus(EdtPickConfPF);
     Exit;
  End;
  ObjPalletDestPP := DmClient.GetEndereco(0, EdtPalletDestPP.Text);
  if (ObjPalletDestPP = Nil) or (ObjPalletDestPP.Codigo = 0) Then Begin
     Text := '';
     MensagemStand('Endereço inválido...');
     Exit;
  End
  Else if ObjPalletDestPP.Tipo.Codigo = 1 then Begin
     Text := '';
     MensagemStand('Endereço refere-se a Pickging...');
     Exit;
  End;
  if ObjPalletDestPP.Status then Begin
     Text := '';
     raise Exception.Create('O Endereço está bloqueado e não pode ser utilizado!');
  End;
  vQuery := TFDMemTable.Create(Nil);
  GetEstoqueProducao(EdtCdProdutoPP.Text.ToInt64(), ObjPalletDestPP.Endereco, vQuery);
  With vQuery do While Not Eof do Begin
    if QryEstoquePP.FieldByName('NmLote').AsString <> FieldByName('NmLote').AsString then //CbLotePP.Items.Strings[CbLotePP.ItemIndex]
       raise Exception.Create('Não é possível armazenar lotes diferentes no mesmo Pallet!'+
       #13+CbLotePP.Items.Strings[CbLotePP.ItemIndex]+' --> '+FieldByName('NmLote').AsString);
    Next;
  End;
  vlMensagem := '';
  vlOrigem   := EdtPalletPF.Text;
  vlDestino  := EdtPalletDestPP.Text;
  vQtdMovPP  := EdtQtdMovPP.Text.ToInteger;
  LblMens1.Text := 'Produto: ' + LblProdutoPP.Text;
  LblMens2.Text := 'Lote: ' + QryEstoquePP.FieldByName('NmLote').AsString+
                ' - '+QryEstoquePP.FieldByName('DtVencimento').AsString;
  LblMens3.Text := 'End. Origem: ' + ObjPalletPP.EnderecoFor;
  LblMens4.Text := 'End. Destino: ' + ObjPalletDestPP.EnderecoFor;
  LblMens5.Text := 'Quantidade: ' + vQtdMovPP.ToString;
  Text := '';
  ConfirmMov(vlMensagem);
end;

procedure TFrmMovimentacao.EdtPalletFPEnter(Sender: TObject);
begin
  inherited;
  if EdtQtdMovFP.Text = '' then DelayedSetFocus(EdtQtdMovFP);
end;

procedure TFrmMovimentacao.EdtPalletFPTyping(Sender: TObject);
begin
  inherited;
  if EdtQtdMovFP.Text = '' then Begin
     EdtPalletFP.Text := '';
     DelayedSetFocus(EdtQtdMovFP);
  End;
end;

procedure TFrmMovimentacao.EdtPalletFPValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtPalletFP.Text = '' then Exit;
  ObjPalletFP := DmClient.GetEndereco(0, EdtPalletFP.Text);
  if (ObjPalletFP = Nil) or (ObjPalletFP.Codigo = 0) or (ObjPalletFP.Tipo.Codigo <> 2) then Begin
     if ObjPalletFP.Tipo.Codigo = 1 then
        MensagemStand('Endereço inválido, referente a Pickging')
     Else MensagemStand('Endereço inválido!');
     EdtPalletFP.Text := '';
     Exit;
  End;
  if ObjPalletFP.Status then Begin
     EdtPalletFP.Text := '';
     raise Exception.Create('O Endereço está bloqueado e não pode ser utilizado!');
  End;
  GetEstoqueProducao(vProdutoFP, EdtPalletFP.Text, QryEstoque);
  QryEstoque.Filter   := 'NmLote <> '+quotedStr(LblLoteFP.Text);
  QryEstoque.Filtered := True;
  if Not QryEstoque.IsEmpty then Begin
     EdtPalletFP.Text := '';
     MensagemStand('Movimentação Inválida!'+#13+#13+
          'Não é permitido inserir dois Lotes diferentes do produto num único Pallet');
     Exit;
  End;
  vlMensagem := '';
  vlOrigem  := EdtPickFP.Text;
  vlDestino := EdtPalletFP.Text;
  vQtdMov   := EdtQtdMovFP.Text.ToInteger;
  LblMens1.Text := 'Produto: ' + EdtProdutoFP.Text;
  LblMens2.Text := 'Lote: ' + LblLoteFP.Text+' - '+LblVenctoFP.Text;
  LblMens3.Text := 'End. Origem: ' + AplicarMascara(vlOrigem, '');
  LblMens4.Text := 'End. Destino: ' + ObjPalletFP.EnderecoFor; // AplicarMascara(vlDestino, '');
  LblMens5.Text := 'Quantidade: ' + vQtdMov.ToString;
  Text := '';
  ConfirmMov(vlMensagem);
end;

procedure TFrmMovimentacao.EdtPalletPFEnter(Sender: TObject);
begin
  inherited;
  if EdtPickingPF.Text = '' then DelayedSetFocus(EdtPickingPF);

end;

procedure TFrmMovimentacao.EdtPalletPFValidate(Sender: TObject;
  var Text: string);
Var ObjPalletPF : TEnderecoColetor;
begin
  if Text = '' then Exit;
  inherited;
  ObjPalletPF := dmClient.GetEndereco(0, Text);
  if (ObjPalletPF = Nil) or (ObjPalletPF.Codigo = 0) or (ObjPalletPF.Tipo.Codigo<>2) then Begin
     Text := '';
     EdtPalletPF.Text := '';
     //DelayedSetFocus(EdtPickingPF);
     if ObjPalletPF.Tipo.Codigo<>2 then
        raise Exception.Create('Endereço referente a Picking!')
     Else Raise Exception.Create('Endereço inválido!');
  End;
//  GetEstoqueProducao(0, Text, QryEstoquePalletPF);
  if QryEstoquePalletPF.IsEmpty then Begin
     EdtPalletPF.Text := '';
     Text := '';
     DelayedSetFocus(EdtPalletPF);
     raise Exception.Create('Pallet vazio... Estoque não disponível!');
  End;
  if not QryEstoquePalletPF.Locate('CdProduto', vProdutoPF) then Begin
     EdtPalletPF.Text := '';
     Text := '';
     DelayedSetFocus(EdtPalletPF);
     raise Exception.Create('Estoque não disponível do produto neste Pallet!');
  End;
  LblLotePF.Text       := QryEstoquePalletPF.FieldByName('NmLote').AsString;
  LblVencimentoPF.Text := QryEstoquePalletPF.FieldByName('DtVencimento').AsString;
  LblEstoquePF.Text    := QryEstoquePalletPF.FieldByName('Disponivel').AsString;
end;

procedure TFrmMovimentacao.EdtPalletPPTyping(Sender: TObject);
begin
  inherited;
  LimparPalletPallet(False);
end;

procedure TFrmMovimentacao.EdtPalletPPValidate(Sender: TObject;
  var Text: string);
begin
  if Text = '' then Exit;
  inherited;
  ObjPalletPP := dmClient.GetEndereco(0, Text);
  if (ObjPalletPP = Nil) or (ObjPalletPP.Codigo = 0) or (ObjPalletPP.Tipo.Codigo<>2) then Begin
     Text := '';
     if ObjPalletPP.Tipo.Codigo<>2 then
        MensagemStand('Endereço referente a Picking!')
     Else MensagemStand('Endereço inválido!');
     EdtPalletPP.Text := '';
     DelayedSetFocus(EdtQtdMovPP);
     DelayedSetFocus(EdtPalletPP);
     Exit;
  End;
  EdtCdProdutoPP.ReadOnly := False;
  EdtQtdMovPP.ReadOnly    := False;
  EdtPalletPP.ReadOnly    := False;
  DelayedSetFocus(EdtCdProdutoPP);
end;

procedure TFrmMovimentacao.EdtPickConfPFTyping(Sender: TObject);
begin
  inherited;
  if EdtQtdMovPF.Text = '' then Begin
     EdtPickConfPF.Text := '';
     DelayedSetFocus(EdtQtdMovPF);
  End;
end;

procedure TFrmMovimentacao.EdtPickConfPFValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtPickConfPF.Text = '' then Exit;
  if (Text <> '')  and (Text <> EdtPickingPF.Text) then Begin
     MensagemStand('Confirmação inválida!' + #13 +
                'O endereço Confirmado é diferente do endereço solicitado.');
     Text := '';
     DelayedSetFocus(EdtPickConfPF);
     Exit;
  End;
  vlMensagem := '';
  if CbMovimentacao.ItemIndex = 2 then Begin // Movimentacao da Área de Transferência
     vlOrigem  := EdtPickingPF.Text;
     vlDestino := EdtPalletPF.Text;
     vQtdMov   := EdtQtdMovPF.Text.ToInteger;
     LblMens1.Text := 'Produto: ' + EdtProdutoPF.Text;
     LblMens2.Text := 'Lote: ' + LblLotePF.Text+' - '+LblVencimentoPF.Text;
  End;
  LblMens3.Text := 'End. Origem: ' + AplicarMascara(vlOrigem, '');
  LblMens4.Text := 'End. Destino: ' + AplicarMascara(vlDestino, '');
  LblMens5.Text := 'Quantidade: ' + vQtdMov.ToString;
  Text := '';
  ConfirmMov(vlMensagem);
end;

procedure TFrmMovimentacao.EdtPickFPKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  if ((Sender=EdtPickFP) or (Sender=EdtPalletOrigemPA) or (Sender=EdtPalletDestinoPA) or
      (Sender=EdtPalletPP) or (Sender=EdtCdProdutoPP) or (Sender=EdtPalletDestPP) or
      (Sender=EdtPickingPF) or (Sender=EdtPalletFP) or (Sender=EdtCdProdCrossRet))
      and (FrmeXactWMS.Brand_Collector = 'Zebra') then Begin
     If ((key = 0) and (IntToStr(ord(KeyChar))='0') ) then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
        {$if defined(Android)}
          i := TJIntent.JavaClass.init;
          i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
          i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
          TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
        {$Endif}
     end;
  End;
  case Key of
    vkReturn:
      TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
  end;
end;

procedure TFrmMovimentacao.EdtPickFPTyping(Sender: TObject);
begin
  inherited;
  LimparPickPallet(False);
end;

procedure TFrmMovimentacao.EdtPickFPValidate(Sender: TObject; var Text: string);
Var vObjProd : TProdutoColetor;
begin
  inherited;
  if EdtPickFP.Text = '' then Exit;
  ObjPickFP := DmClient.GetEndereco(0, EdtPickFP.Text);
  if (ObjPickFp = Nil) or (ObjPickFP.Codigo = 0) or (ObjPickFP.Tipo.Codigo <> 1) then Begin
     Text := '';
     if ObjPickFP.Tipo.Codigo<>1 then
        MensagemStand('Endereço referente a Pallet!')  //raise Exception.Create('Endereço referente a Pallet!')
     Else MensagemStand('Endereço inválido!');
     Exit;
  End;
  vObjProd := DmClient.GetPickingProduto(0, EdtPickFP.Text);
  if (vObjProd = Nil) or (vObjProd.Codigo = 0) then Begin
     Text := '';
     MensagemStand('Não produto cadastrado neste Picking!');
     Exit;
  End;
  vProdutoFP        := vObjProd.Codigo;
  EdtProdutoFP.Text := vObjProd.Descricao;
  GetEstoqueProducao(vObjProd.Codigo, EdtPickFP.Text, QryEstoqueFP);
  if QryEstoqueFP.IsEmpty then
     MensagemStand('Não há Estoque Diponínvel no Picking')
  Else Begin;
     QryEstoqueFP.Last;
     LblLoteFP.Text    := QryEstoqueFP.FieldByName('NmLote').AsString;
     LblVenctoFP.Text  := QryEstoqueFP.FieldByName('DtVencimento').AsString;
     LblEstoqueFP.Text := IntToStr(QryEstoqueFP.FieldByName('Estoque').AsInteger-QryEstoqueFP.FieldByName('QtReserva').AsInteger);
     DelayedSetFocus(EdtQtdMovFP);
     EdtQtdMovFP.ReadOnly := False;
     EdtPalletFP.ReadOnly := False;
  End;
end;

procedure TFrmMovimentacao.EdtPickingPFTyping(Sender: TObject);
begin
  inherited;
  LimparPalletPick(False);
end;

procedure TFrmMovimentacao.EdtPickingPFValidate(Sender: TObject;
  var Text: string);
Var vObjProd : TProdutoColetor;
begin
  if Text = '' then Exit;
  inherited;
  ObjPickPick := dmClient.GetEndereco(0, Text);
  if (ObjPickPick = Nil) or (ObjPickPick.Codigo = 0) or (ObjPickPick.Tipo.Codigo<>1) or
     (ObjPickPick.Status) then Begin
     EdtPickingPF.Text := '';
     if (ObjPickPick = Nil) or (ObjPickPick.Codigo=0) then
        Raise Exception.Create('Endereço inválido!')
     Else if ObjPickPick.Tipo.Codigo<>1 then
        raise Exception.Create('Endereço referente a Pallet!')
     Else if ObjPickPick.Status then Begin
        raise Exception.Create('O Endereço está bloqueado e não pode ser utilizado!');
     End;
//     KeyDown(13, #0, Nil); //Descobrir como usar
//     keybd_event(VK_SHIFT,0,0,0);
//     tShiftstate
  End;
  //Buscar produto do picking
  vObjProd := dmClient.GetPickingProduto(0, EdtPickingPF.Text);
  if (vObjProd = Nil) or (vObjProd.Codigo = 0) then Begin
     EdtPickingPF.Text := '';
     Text := '';
     DelayedSetFocus(EdtPickingPF);
     raise Exception.Create('Não há produto cadastrado neste Picking!');
  End;
  QryEstoquePalletPF.Filtered := False;
  GetEstoqueProducao(vObjProd.Codigo, '', QryEstoquePalletPF);
  QryEstoquePalletPF.Filter := 'CdEndereco <> '+ObjPickPick.Codigo.ToString()+' and NmEndereco<>'+QuotedStr('99999999');
  QryEstoquePalletPF.Filtered := True;
  if QryEstoquePalletPF.IsEmpty then Begin
     EdtPickingPF.Text := '';
     Text := '';
     DelayedSetFocus(EdtPickingPF);
     raise Exception.Create('Não há Estoque deste produto para movimentação!');
  End;
  vProdutoPF := vObjProd.Codigo;
  EdtProdutoPF.Text := vObjProd.Descricao;
  EdtPalletPF.ReadOnly   := True;
  EdtQtdMovPF.ReadOnly   := False;
  EdtPickConfPF.ReadOnly := False;
  EdtPalletPF.Text := QryEstoquePalletPF.FieldByName('NmEndereco').AsString;
  DelayedSetFocus(EdtQtdMovPF);
end;

procedure TFrmMovimentacao.CbMovimentacaoChange(Sender: TObject);
begin
  inherited;
  if CbMovimentacao.ItemIndex = 0 then Begin
     PgcMovimentacao.ActiveTab := TbArmazenagem;
     DelayedSetFocus(EdtCodProdArm);
  End
  Else if CbMovimentacao.ItemIndex = 1 then Begin
     PgcMovimentacao.ActiveTab := TbPickPallet;
     DelayedSetFocus(EdtPickFP);
  End
  Else if CbMovimentacao.ItemIndex = 2 then Begin
     PgcMovimentacao.ActiveTab := TbPalletPick;
     DelayedSetFocus(EdtPickingPF);
  End
  Else if CbMovimentacao.ItemIndex = 3 then Begin
     PgcMovimentacao.ActiveTab := TbPalletPallet;
     DelayedSetFocus(EdtPalletPP);
  End
  Else if CbMovimentacao.ItemIndex = 4 then Begin
     PgcMovimentacao.ActiveTab := TbPalletAll;
     DelayedSetFocus(EdtPalletOrigemPA);
  End
  Else if CbMovimentacao.ItemIndex = 5 then Begin
     PgcMovimentacao.ActiveTab := TbCrossDockingRetirar;
     DelayedSetFocus(EdtCdProdCrossRet);
  End;
  PositionField;
end;

procedure TFrmMovimentacao.ConfirmMov(vMensagem : String);
begin
//https://www.youtube.com/watch?v=KxO6VxfHcmE
  RctMensBcg.Visible := True;
  RctMens.Visible := True;
  With FloatAnimation2 do Begin
    StartValue := -RctMens.Height;
    StopValue := (Self.Height /2) - (RctMens.Height/2);
    Start;
  End;
  DelayedSetFocus(BtnConfirmaMov);
end;

procedure TFrmMovimentacao.EdtCdProdCrossRetTyping(Sender: TObject);
begin
  inherited;
  LimparCrossdockingRet(False);
end;

procedure TFrmMovimentacao.EdtCdProdCrossRetValidate(Sender: TObject;
  var Text: string);
Var vTotEstPick : Integer;
begin
  inherited;
  if EdtCdProdCrossRet.Text.IsEmpty then Exit;
  Try
    ObjProdutoCrossRet := dmClient.GetProduto(EdtCdProdCrossRet.Text);
    LblProdCrossRet.Text := ObjProdutoCrossRet.Descricao;
    if (ObjProdutoCrossRet = Nil) or (ObjProdutoCrossRet.Codigo = 0) then Begin
       LimparCrossdockingRet(True);
       MensagemStand('Produto não encontrado!');
       exit
       End
    Else if (ObjProdutoCrossRet.Endereco = Nil) or (ObjProdutoCrossRet.Endereco.Codigo=0) then
       LblPickProdPP.Text := 'Sem Endereço de Picking'
    Else LblPickCrossRet.Text := 'Picking: '+ObjProdutoCrossRet.Endereco.EnderecoFor;
    GetEstoqueProducao(EdtCdProdCrossRet.Text.ToInt64, ObjProdutoCrossRet.Endereco.Endereco, QryEstoque);
    vTotEstPick := 0;
    while Not QryEstoque.Eof do Begin
      vTotEstPick := vTotEstPick + QryEstoque.FieldByName('Estoque').AsInteger;
      QryEstoque.Next;
    End;
    if (QryEstoque.IsEmpty) or (vTotEstPick=0) then
       LblPickCrossRet.Text := 'ZERADO'
    Else if vTotEstPick < 0 then
       LblPickCrossRet.Text := 'NEGATIVO'
    Else LblEstPickCrossRet.Text := QryEstoque.FieldByName('Estoque').AsString;
    CbLoteCrossRet.Items.Clear;
    GetEstoqueCrossDocking(ObjProdutoCrossRet.Codigo, QryEstoqueCross);
    if QryEstoqueCross.IsEmpty then Begin
       MensagemStand('Produto sem Estoque no Crossdocking');
       LimparCrossdockingRet(True);
       exit;
    End;
    With QryEstoqueCross do Begin
      First;
      while Not Eof do Begin
        CbLoteCrossRet.Items.Add(FieldByName('NmLote').AsString+' | '+FieldByName('DtVencimento').AsString);
        Next;
      End;
    End;
  Except Begin
    DelayedSetFocus(EdtCdProdCrossRet);
    raise Exception.Create('Ocorreu um problema na pesquisa...');
    End;
  End;
  EdtQtdMovCrossRet.readOnly := False;
  EdtPalletCrossRet.readOnly := False;
  CbLoteCrossRet.Enabled     := True;
  QryEstoqueCross.First;
  CbLoteCrossRet.ItemIndex   := 0;
  DelayedSetFocus(CbLoteCrossRet);
end;

procedure TFrmMovimentacao.EdtCdProdutoPPTyping(Sender: TObject);
begin
  inherited;
//  if EdtCdProdutoPP.Text = '' then LimparPalletPallet(False);
  LblProdutoPP.Text   := '';
  LblPickProdPP.Text  := '';
  LblEstPickPP.Text   := '';
  LblEstoquePP.Text   := '';
  CbLotePP.Items.Clear;
  EdtQtdMovPP.Text    := '';
end;

procedure TFrmMovimentacao.EdtCdProdutoPPValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtCdProdutoPP.Text <> '' then GetProdutoPP(EdtCdProdutoPP.Text); //.ToInt64());
end;

procedure TFrmMovimentacao.EdtCodProdArmKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  If (((key = 0) and (IntToStr(ord(KeyChar))='0') and ((Sender=EdtCodigo) or (Sender=EdtPickConfPF) or
      (Sender=EdtEnderecoDestinoArm) or (Sender=EdtCodProdArm)))) and (FrmeXactWMS.Brand_Collector = 'Zebra') then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
    {$if defined(Android)}
       i := TJIntent.JavaClass.init;
       i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
       i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
       TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
    {$Endif}
  end;
  case Key of
    vkReturn:
      TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
//    vkTab:
//      TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
    vkEscape: Limpar;
    Else if Sender = EdtCodProdArm then
       LimparArmazenagem(False)
    Else If Sender = EdtPickingPF then
       LimparPalletPick(False);
  End
end;

procedure TFrmMovimentacao.EdtCodProdArmValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if Text='' then Begin
     DelayedSetFocus(EdtCodProdArm);
     Exit;
  End;
  GetProduto(EdtCodProdArm.Text); //.ToInt64());
  Text := EdtCodProdArm.Text;
end;

procedure TFrmMovimentacao.EdtQtdMovCrossRetValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtQtdMovCrossRet.Text = '' then Exit
  Else if StrToIntDef(EdtQtdMovCrossRet.Text, 0)  <= 0 then Begin
     Text := '';
     EdtQtdMovCrossRet.Text := '';
     MensagemStand('Quantidade inválida para movimentação!');
     DelayedSetFocus(EdtQtdMovCrossRet);
     End
  Else if StrToIntDef(EdtQtdMovCrossRet.Text, 0) >= QryEstoqueCross.FieldByName('Disponivel').AsInteger then Begin
     Text := '';
     EdtQtdMovCrossRet.Text := '';
     MensagemStand('Quantidade inválida para movimentação!'+#13+
                            'Estoque indisponível.');
     DelayedSetFocus(EdtQtdMovCrossRet);
     End
  Else
     DelayedSetFocus(EdtPalletCrossRet);
end;

procedure TFrmMovimentacao.EdtQtdMovFPValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtQtdMovFP.Text = '' then Exit;
  if StrToIntDef(EdtQtdMovFP.Text, 0) <= 0 then Begin
     MensagemStand('Quantidade inválida!');
     Text := '';
  End
  Else if EdtQtdMovFP.Text.ToInteger > LblEstoqueFP.Text.ToInteger then Begin
     MensagemStand('Quantidade maior que estoque disponível.');
     Text := '';
  End;
  DelayedSetFocus(EdtPalletFP);
end;

procedure TFrmMovimentacao.EdtQtdMovimentadaArmKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmMovimentacao.EdtQtdMovimentadaArmValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtQtdMovimentadaArm.Text = '' then Exit
  Else if StrToIntDef(EdtQtdMovimentadaArm.Text, 0) <= 0 then Begin
     Text := '';
     EdtQtdMovimentadaArm.Text := '';
     raise Exception.Create('Quantidade inválida!');
  End;
  if EdtQtdMovimentadaArm.Text.ToInteger>(QryEstoqueEspera.FieldByName('Disponivel').Asinteger) then Begin
     Text := '';
     EdtQtdMovimentadaArm.Text := '';
     raise Exception.Create('Quantidade inválida!'+#13+'Quantidade movimentada não disponível.');
  End;
end;

procedure TFrmMovimentacao.EdtQtdMovPFValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtQtdMovPF.Text = '' then Exit
  Else if StrToIntDef(EdtQtdMovPF.Text, 0)  <= 0 then Begin
     Text := '';
     EdtQtdMovPF.Text := '';
     DelayedSetFocus(EdtQtdMovPF);
     raise Exception.Create('Quantidade inválida para movimentação!');
     End
  Else if StrToIntDef(EdtQtdMovPF.Text, 0) > StrToIntDef(LblEstoquePF.Text, 0) then Begin
     Text := '';
     EdtQtdMovPF.Text := '';
     DelayedSetFocus(EdtQtdMovPF);
     raise Exception.Create('Quantidade inválida para movimentação!'+#13+
                            'Estoque indisponível.');
     End;
end;

procedure TFrmMovimentacao.EdtQtdMovPPValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtQtdMovPP.Text = '' then Exit
  Else if StrToIntDef(EdtQtdMovPP.Text, 0)  <= 0 then Begin
     Text := '';
     EdtQtdMovPP.Text := '';
     MensagemStand('Quantidade inválida para movimentação!');
     DelayedSetFocus(EdtQtdMovPP);
     Exit;
     End
  Else if StrToIntDef(EdtQtdMovPP.Text, 0) > QryEstoquePP.FieldByName('Disponivel').AsInteger then Begin
     Text := '';
     EdtQtdMovPP.Text := '';
     MensagemStand('Quantidade inválida para movimentação!'+#13+
                            'Estoque indisponível.');
     DelayedSetFocus(EdtQtdMovPP);
     Exit;
     End;
  DelayedSetFocus(EdtPalletDestPP);
end;

procedure TFrmMovimentacao.FloatAnimation2Finish(Sender: TObject);
begin
  inherited;
  RctMensBcg.Visible := (FloatAnimation2.StartValue = -RctMens.Height);
  RctMens.Visible    := RctMensBcg.Visible;
end;

procedure TFrmMovimentacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ObjProduto)         Then ObjProduto         := Nil;
  if Assigned(ObjProdutoPP)       Then ObjProdutoPP       := Nil;
  if Assigned(ObjPickPick)        Then ObjPickPick        := Nil;
  if Assigned(ObjEndDestinoArm)   Then ObjEndDestinoArm   := Nil;
  if Assigned(ObjPalletPP)        Then ObjPalletPP        := Nil;
  if Assigned(ObjPalletDestPP)    Then ObjPalletDestPP    := Nil;
  if Assigned(ObjPalletOrigemPA)  Then ObjPalletOrigemPA  := Nil;
  if Assigned(ObjPalletDestinoPA) Then ObjPalletDestinoPA := Nil;
  if Assigned(ObjProdutoCrossRet) then ObjProdutoCrossRet := Nil;

  inherited;
end;

procedure TFrmMovimentacao.FormCreate(Sender: TObject);
begin
  inherited;
  PgcPrincipal.ActiveTab   := TabDetalhes;
  CbMovimentacao.ItemIndex := 0;
  CbMovimentacao.Enabled   := True;
  LimparArmazenagem(True);
  LimparCrossdockingRet(True);
  LimparPalletPick(True);
  LimparPalletAll(True);
  LimparPalletPallet(True);
  LimparPickPallet(True);
  RctMens.Visible          := False;
  RctMensBcg.Visible       := False;
  With BtnConfirmaMov do Begin
    Width          := 50;
    Height         := 40;
    Margins.Left   := 10;
    Margins.Right  := 10;
    StyledSettings := StyledSettings - [TStyledSetting.Style];
    StyledSettings := StyledSettings - [TStyledSetting.Family];
    StyledSettings := StyledSettings - [TStyledSetting.Size];
    StyledSettings := StyledSettings - [TStyledSetting.FontColor];
    StyledSettings := StyledSettings - [TStyledSetting.Other];
    TextSettings.Font.Family := 'Roboto Th';
    TextSettings.Font.Size   := 18;
    Text           := 'OK';
  End;
end;

procedure TFrmMovimentacao.GetEstoqueCrossDocking(vCdProduto: Int64;
  vQuery: TFdMemTable);
Var Ret_EstoqueCross : TFDJSONDataSets;
begin
   Ret_EstoqueCross := dmClient.GetEstoqueCrossDocking(vCdProduto);
   With vQuery do Begin
     Close;
     AppendData(TFDJSONDataSetsReader.GetListValue(Ret_EstoqueCross, 0));
     Open;
   End;
end;

procedure TFrmMovimentacao.GetEstoqueEspera(vCdProduto: Int64);
Var Ret_EstoqueEspera : TFDJSONDataSets;
begin
   Ret_EstoqueEspera := dmClient.GetEstoqueEspera(vCdProduto);
   With QryEstoqueEspera do Begin
     Close;
     AppendData(TFDJSONDataSetsReader.GetListValue(Ret_EstoqueEspera, 0));
     Open;
   End;
end;

procedure TFrmMovimentacao.GetEstoqueProducao(vCdProduto: Int64; pNmEndereco : String; vQuery : TFdMemTable);
Var Ret_EstoqueProducao : TFDJSONDataSets;
begin
   Ret_EstoqueProducao := dmClient.GetEstoqueProducao(vCdProduto, pNmEndereco);
   With vQuery do Begin
     Close;
     AppendData(TFDJSONDataSetsReader.GetListValue(Ret_EstoqueProducao, 0));
     Open;
   End;
end;

//Usado na Movimentação Área de Espera
function TFrmMovimentacao.GetProduto(vCdProduto: String): TProdutoColetor;
begin
  Try
    ObjProduto := dmClient.GetProduto(vCdProduto);
    LBlProdutoArm.Text := ObjProduto.Descricao;
    if (ObjProduto = Nil) or (ObjProduto.Codigo = 0) then Begin
       MensagemStand('Produto não encontrado!');
       LimparArmazenagem(True);
       exit
       End
    Else if (ObjProduto.Endereco = Nil) or (ObjProduto.Endereco.Codigo=0) then
       LblEnderecoArm.Text := 'Sem Endereço de Picking'
    Else LblEnderecoArm.Text := 'Picking: '+ObjProduto.Endereco.EnderecoFor;
    GetEstoqueProducao(0, ObjProduto.Endereco.Endereco, QryEstoque);
    LblZerado.Visible := QryEstoque.IsEmpty;
    CbLoteArm.Items.Clear;
    GetEstoqueEspera(ObjProduto.Codigo);
    if QryEstoqueEspera.IsEmpty then Begin
       MensagemStand('Produto sem Estoque na Área de Espera');
       LimparArmazenagem(True);
       exit;
    End;
    With QryEstoqueEspera  do Begin
      First;
      while Not Eof do Begin
        CbLoteArm.Items.Add(FieldByName('NmLote').AsString+' | '+FieldByName('DtVencimento').AsString);
        Next;
      End;
    End;
  Except Begin
    DelayedSetFocus(EdtCodProdArm);
    raise Exception.Create('Ocorreu um erro problema na pesquisa...');
    End;
  End;
  EdtQtdMovimentadaArm.readOnly  := False;
  EdtEnderecoDestinoArm.readOnly := False;
  CbLoteArm.Enabled              := True;
  QryEstoqueEspera.First;
  CbLoteArm.ItemIndex := 0;
  if QryEstoqueEspera.RecordCount = 1 then
     DelayedSetFocus(EdtQtdMovimentadaArm);
end;

//Usado na Movimentação Pallet TO Pallet
Function TFrmMovimentacao.GetProdutoPP(vCdProduto: String): TProdutoColetor;
Var vTotEstPick : Integer;
begin
  Try
    ObjProdutoPP := dmClient.GetProduto(vCdProduto);
    LblProdutoPP.Text := ObjProdutoPP.Descricao;
    if (ObjProdutoPP = Nil) or (ObjProdutoPP.Codigo = 0) then Begin
       LimparPalletPallet(True);
       MensagemStand('Produto não encontrado!');
       exit
       End
    Else if (ObjProdutoPP.Endereco = Nil) or (ObjProdutoPP.Endereco.Codigo=0) then
       LblPickProdPP.Text := 'Sem Endereço de Picking'
    Else LblPickProdPP.Text := 'Picking: '+ObjProdutoPP.Endereco.EnderecoFor;
    GetEstoqueProducao(EdtCdProdutoPP.Text.ToInt64, ObjProdutoPP.Endereco.Endereco, QryEstoque);
    vTotEstPick := 0;
    while Not QryEstoque.Eof do Begin
      vTotEstPick := vTotEstPick + QryEstoque.FieldByName('Estoque').AsInteger;
      QryEstoque.Next;
    End;
    if (QryEstoque.IsEmpty) or (vTotEstPick=0) then
       LblPickProdPP.Text := 'ZERADO'
    Else if vTotEstPick < 0 then
       LblPickProdPP.Text := 'NEGATIVO'
    Else LblEstPickPP.Text := QryEstoque.FieldByName('Estoque').AsString;
    CbLotePP.Items.Clear;
    GetEstoqueProducao(ObjProdutoPP.Codigo, EdtPalletPP.Text, QryEstoquePP);
    if QryEstoquePP.IsEmpty then Begin
       MensagemStand('Produto sem Estoque neste Pallet');
       LimparPalletPallet(False);
       exit;
    End;
    With QryEstoquePP do Begin
      First;
      while Not Eof do Begin
        CbLotePP.Items.Add(FieldByName('NmLote').AsString+' | '+FieldByName('DtVencimento').AsString);
        Next;
      End;
    End;
  Except Begin
    DelayedSetFocus(EdtCdProdutoPP);
    raise Exception.Create('Ocorreu um erro problema na pesquisa...');
    End;
  End;
  EdtQtdMovPP.readOnly     := False;
  EdtPalletDestPP.readOnly := False;
  CbLotePP.Enabled         := True;
  QryEstoquePP.First;
  CbLotePP.ItemIndex       := 0;
  DelayedSetFocus(CbLotePP);
end;

procedure TFrmMovimentacao.Limpar;
begin
  If PgcMovimentacao.ActiveTab = TbArmazenagem then LimparArmazenagem(True)
  Else if PgcMovimentacao.ActiveTab = TbPalletPick then LimparPalletPick(True)
  Else if PgcMovimentacao.ActiveTab = TbPalletAll then LimparPalletAll(True)
  Else if PgcMovimentacao.ActiveTab = TbPalletPallet Then LimparPalletPallet(True)
  Else if PgcMovimentacao.ActiveTab = TbPickPallet   Then LimparPickPallet(True);
end;

procedure TFrmMovimentacao.LimparArmazenagem(Inicio : Boolean);
begin
  If Inicio Then Begin
     EdtCodProdArm.Text             := '';
     EdtCodProdArm.readOnly         := False;
  End;
  EdtQtdMovimentadaArm.readOnly  := True;
  EdtEnderecoDestinoArm.readOnly := True;
  CbLoteArm.Enabled              := False;
  LBlProdutoArm.Text  := '';
  LblEnderecoArm.Text := '';
  LblZerado.Visible   := False;
  LblEstoqueArm.Text  := '';
  EdtQtdMovimentadaArm.Text  := '';
  EdtEnderecoDestinoArm.Text := '';
  CbLoteArm.Items.Clear;
  DelayedSetFocus(EdtCodProdArm);
end;

procedure TFrmMovimentacao.LimparCrossdockingRet(Inicio: Boolean);
begin
  if Inicio then Begin
     EdtCdProdCrossRet.Text     := '';
     EdtCdProdCrossRet.ReadOnly := False;
  End;
  EdtCrossDocking.Text      := 'CrossDocking';
  LblProdCrossRet.Text      := '';
  LblPickCrossRet.Text      := '';
  LblEstPickCrossRet.Text   := '';
  LblEstPickCrossRet.Text   := '';
  CbLoteCrossRet.Items.Clear;
  EdtQtdMovCrossRet.Text    := '';
  EdtPalletCrossRet.Text    := '';
  DelayedSetFocus(EdtCdProdCrossRet);
end;

procedure TFrmMovimentacao.LimparPalletAll(Inicio: Boolean);
begin
  if Inicio then Begin
     EdtPalletOrigemPA.Text     := '';
     EdtPalletOrigemPA.ReadOnly := False;
  End;
  EdtPalletDestinoPA.Text;
  DelayedSetFocus(EdtPalletOrigemPA);
end;

procedure TFrmMovimentacao.LimparPalletPallet(Inicio: Boolean);
begin
  if Inicio then Begin
     EdtPalletPP.Text     := '';
     EdtPalletPP.ReadOnly := False;
  End;
  EdtCdProdutoPP.Text := '';
  LblProdutoPP.Text   := '';
  LblPickProdPP.Text  := '';
  LblEstPickPP.Text   := '';
  LblEstoquePP.Text   := '';
  CbLotePP.Items.Clear;
  EdtQtdMovPP.Text    := '';
  //EdtPalletPP.Text    := '';
  DelayedSetFocus(EdtPalletPP);
end;

procedure TFrmMovimentacao.LimparPalletPick(Inicio: Boolean);
begin
  if Inicio = True then Begin
     EdtPickingPF.Text     := '';
     EdtPickingPF.ReadOnly := False;
  End;
  EdtPalletPF.ReadOnly   := True;
  EdtQtdMovPF.ReadOnly   := True;
  EdtPickConfPF.ReadOnly := True;
  EdtProdutoPF.Text    := '';
  EdtPalletPF.Text     := '';
  LblLotePF.Text       := '';
  LblVencimentoPF.Text := '';
  LblEstoquePF.Text    := '';
  EdtQtdMovPF.Text     := '';
  EdtPickConfPF.Text   := '';
  DelayedSetFocus(EdtPickingPF);
end;

procedure TFrmMovimentacao.LimparPickPallet(Inicio: Boolean);
begin
  if Inicio then Begin
     EdtPickFP.Text := '';
     EdtPickFP.ReadOnly := False;
  End;
  EdtProdutoFP.Text := '';
  EdtQtdMovFP.Text  := '';
  EdtPalletFP.Text  := '';
  LblLoteFP.Text    := '';
  LblVenctoFP.Text    := '';
  LblEstoqueFP.Text   := '';
  EdtQtdMovFP.ReadOnly := True;
  EdtPalletFP.ReadOnly := True;
  DelayedSetFocus(EdtPickFP);
end;

procedure TFrmMovimentacao.SalvarMovimentacao;
Var ObjRetorno : TRetorno;
 vCdEndereco : Integer;
begin
  ShowLoading;
  Try
  If PgcMovimentacao.ActiveTab = TbArmazenagem then Begin
     ObjRetorno := dmClient.GetSalvarMovimentacaoPF(0, ObjEndDestinoArm.Codigo,
                   0 , //EstoqueEspera
                   QryEstoqueEspera.FieldByName('CdLote').AsInteger,
                   EdtQtdMovimentadaArm.Text.ToInteger(),
                   FrmeXactWMS.ObjUsuario.Nome);
     if ObjRetorno.Codigo <> 1 then
        MensagemStand('Ocorreu um erro. Movimentação cancelada.'+#13+
                      ObjRetorno.Descricao);
  End
  Else if PgcMovimentacao.ActiveTab = TbPickPallet then Begin
     ObjRetorno := dmClient.GetSalvarMovimentacaoPF(1, ObjPalletFP.Codigo,
                   ObjPickFP.Codigo,
                   QryEstoqueFP.FieldByName('CdLote').AsInteger,
                   EdtQtdMovFP.Text.ToInteger(),
                   FrmeXactWMS.ObjUsuario.Nome);
  End
  Else if PgcMovimentacao.ActiveTab = TbPalletPick then Begin
     ObjRetorno := dmClient.GetSalvarMovimentacaoPF(2, ObjPickPick.Codigo,
                   QryEstoquePalletPF.FieldByName('CdEndereco').AsInteger,
                   QryEstoquePalletPF.FieldByName('CdLote').AsInteger,
                   EdtQtdMovPF.Text.ToInteger(),
                   FrmeXactWMS.ObjUsuario.Nome);
  End
  Else if PgcMovimentacao.ActiveTab = TbPalletPallet then Begin
     ObjRetorno := dmClient.GetSalvarMovimentacaoPF(3, ObjPalletDestPP.Codigo,
                   ObjPalletPP.Codigo,
                   QryEstoquePP.FieldByName('CdLote').AsInteger,
                   EdtQtdMovPP.Text.ToInteger(),
                   FrmeXactWMS.ObjUsuario.Nome);
  End
  Else if PgcMovimentacao.ActiveTab = TbPalletAll then Begin
     ObjRetorno := dmClient.GetSalvarMovimentacaoPF(4, ObjPalletDestinoPA.Codigo,
                   ObjPalletOrigemPA.Codigo,
                   0,
                   0,
                   FrmeXactWMS.ObjUsuario.Nome);
  End
  Else if PgcMovimentacao.ActiveTab = TbCrossDockingRetirar then Begin
     vCdEndereco := ObjPalletCrossRet.Codigo;
     ObjRetorno := dmClient.GetSalvarMovimentacaoPF(5, ObjPalletCrossRet.Codigo,
                   0, QryEstoqueCross.FieldByName('CdLote').Asinteger,
                   EdtQtdMovCrossRet.Text.toInteger, FrmeXactWMS.ObjUsuario.Nome);
  End;
  Except on E: Exception do Begin
    HideLoading;
    raise Exception.Create('Ocorreu um erro no servidor!');
    End;
  End;
  if ObjRetorno.Codigo <> 1 then
     MensagemStand('Ocorreu um erro. Movimentação cancelada.'+#13+ObjRetorno.Descricao);
//  Else MensagemStand('Movimentação Realizada com Sucesso!!!.');
  FreeAndNil(ObjRetorno);
  Limpar;
  HideLoading;
end;

procedure TFrmMovimentacao.PositionField;
begin
  if CbMovimentacao.ItemIndex = 0 then Begin
     EdtCodProdArm.TabOrder         := 0;
     CbMovimentacao.TabOrder        := 1;
     EdtQtdMovimentadaArm.TabOrder  := 2;
     EdtEnderecoDestinoArm.TabOrder := 3
  End
  Else if CbMovimentacao.ItemIndex = 3 then Begin
     EdtPickingPF.TabOrder  := 0;
     EdtPalletPF.TabOrder   := 1;
     EdtQtdMovPF.TabOrder   := 2;
     EdtPickConfPF.TabOrder := 3;
  End;

end;

end.
