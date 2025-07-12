unit uFrmReposicaoTransferenciaPicking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, System.Generics.Collections,
  FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, System.JSON, REST.Json, Rest.Types,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Bindings.Outputs, DataSet.Serialize,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB, uMyTabOrderClassHelper,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Objects, FMX.ListBox,
  FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.ListView,
  FMX.Layouts, Fmx.Bind.Grid, ksTypes, ksLoadingIndicator, FMX.Media,
  FMX.Effects, FMX.Filter.Effects, FMX.Ani
  {$IFDEF IOS}
    ,Macapi.Helpers
  {$ENDIF IOS}
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os
    ,Androidapi.JNI.Telephony //Sms
  {$Endif}
  , PedidoSaidaCtrl, ProdutoCtrl;

type
  TFrmReposicaoTransferenciaPicking = class(TFrmBase)
    LblTit02: TLabel;
    LblTit03: TLabel;
    LblTit04: TLabel;
    LytLabelReposicao: TLayout;
    LblProcessoReposicao: TLabel;
    LblTitReposicao: TLabel;
    CircContagem: TCircle;
    LblCircContagem: TLabel;
    LblDtReposicao: TLabel;
    EdtDtReposicao: TEdit;
    LnDtReposicao: TLine;
    LblZona: TLabel;
    EdtZona: TEdit;
    LnZona: TLine;
    FDMemReposicao: TFDMemTable;
    LytTop: TLayout;
    LytBottom: TLayout;
    LytColeta: TLayout;
    EdtCodProduto: TEdit;
    LnCodProduto: TLine;
    Rct01Produto: TRectangle;
    LblProduto: TLabel;
    TxtProduto: TLabel;
    LblEmbalagem: TLabel;
    LblPicking: TLabel;
    LblZonaProduto: TLabel;
    TxtEmbalagem: TLabel;
    TxtPicking: TLabel;
    TxtZona: TLabel;
    Rct02Coleta: TRectangle;
    LblColeta: TLabel;
    LblLote: TLabel;
    LblVencimento: TLabel;
    TxtLote: TLabel;
    TxtVencimento: TLabel;
    LblDemanda: TLabel;
    LblDisponivel: TLabel;
    EdtDemanda: TEdit;
    LnDemanda: TLine;
    EdtDisponivel: TEdit;
    LnDisponivel: TLine;
    Rct03Apanhe: TRectangle;
    LblApanhe: TLabel;
    LblEndereco: TLabel;
    EdtEndereco: TEdit;
    LnEndereco: TLine;
    LblEnderecoColeta: TLabel;
    LblQtdApanhe: TLabel;
    EdtQtdApanhe: TEdit;
    LnQtdApanhe: TLine;
    FdMemReposicaoColeta: TFDMemTable;
    IntegerField13: TIntegerField;
    FdMemReposicaoColetaProdutoId: TIntegerField;
    FdMemReposicaoColetaCodProduto: TIntegerField;
    FdMemReposicaoColetaDescricao: TStringField;
    FdMemReposicaoColetaEmbalagem: TStringField;
    FdMemReposicaoColetaFatorConversao: TIntegerField;
    FdMemReposicaoColetaPickingId: TIntegerField;
    FdMemReposicaoColetaPicking: TStringField;
    FdMemReposicaoColetaMascaraPicking: TStringField;
    FdMemReposicaoColetaEnderecoId: TIntegerField;
    FdMemReposicaoColetaEndereco: TStringField;
    FdMemReposicaoColetaMascara: TStringField;
    FdMemReposicaoColetaZonaId: TIntegerField;
    FdMemReposicaoColetaZona: TStringField;
    FdMemReposicaoColetaLoteId: TIntegerField;
    FdMemReposicaoColetaDescrLote: TStringField;
    FdMemReposicaoColetaVencimento: TDateField;
    FdMemReposicaoColetaDemanda: TIntegerField;
    FdMemReposicaoColetaEstoqueTipoId: TIntegerField;
    FdMemReposicaoColetaReposicao: TIntegerField;
    FdMemReposicaoColetaUsuarioId: TIntegerField;
    FdMemReposicaoColetaNome: TStringField;
    FdMemReposicaoColetaTerminal: TStringField;
    FdMemReposicaoColetaDtColeta: TDateField;
    FdMemReposicaoColetaHrColeta: TStringField;
    FdMemReposicaoColetaDisponivel: TIntegerField;
    DsReposicaoColeta: TDataSource;
    EdtReposicaoId: TEdit;
    Line1: TLine;
    Label1: TLabel;
    EdtEan: TEdit;
    Line2: TLine;
    ActContrMovQtde: TAction;
    ActContrMovQtdeNegada: TAction;
    TabReposicaoTransferencia: TTabItem;
    Rct01ProdutoTransferencia: TRectangle;
    EdtCodProdutoTransferencia: TEdit;
    Line3: TLine;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LblEmbalagemTransferencia: TLabel;
    LblPickingTransferencia: TLabel;
    LblZonaTransferencia: TLabel;
    LblProdutoTransferencia: TLabel;
    Rct02Transferencia: TRectangle;
    Label14: TLabel;
    EdtEnderecoTransferencia: TEdit;
    Line4: TLine;
    Label16: TLabel;
    EdtQtdTransferencia: TEdit;
    Line5: TLine;
    Label17: TLabel;
    Label18: TLabel;
    CbLoteTransferencia: TComboBox;
    LytFootTransferencia: TLayout;
    RctTituloTransferencia: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LstTransferenciaEstoque: TListView;
    FDMemReposicaoTransferencia: TFDMemTable;
    Label10: TLabel;
    Label11: TLabel;
    LblVencimentoTransferencia: TLabel;
    ChgTabTransferencia: TChangeTabAction;
    BtnAtualizaListaTransferencia: TSpeedButton;
    PthAtualizaListaTransferencia: TPath;
    LytAignTitulo: TLayout;
    procedure BtnSearchPesqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstPrincipalItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure EdtCodigoExit(Sender: TObject);
    procedure EdtCodigoChange(Sender: TObject);
    procedure EdtQtdApanheKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure EdtEnderecoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure EdtEanValidate(Sender: TObject; var Text: string);
    procedure EdtEanKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ActContrMovQtdeExecute(Sender: TObject);
    procedure ActContrMovQtdeNegadaExecute(Sender: TObject);
    procedure EdtCodProdutoTransferenciaExit(Sender: TObject);
    procedure CbLoteTransferenciaExit(Sender: TObject);
    procedure EdtEnderecoTransferenciaTyping(Sender: TObject);
    procedure EdtQtdTransferenciaTyping(Sender: TObject);
    procedure EdtEnderecoTransferenciaExit(Sender: TObject);
    procedure EdtQtdTransferenciaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodProdutoTransferenciaTyping(Sender: TObject);
    procedure EdtCodProdutoTransferenciaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure CbLoteTransferenciaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    pVisualizarSaldoTransferecia : Boolean;
    pVisualizarEstoqueDisponivel : Boolean;
    Procedure GetListaReposicaoPendente;
    Procedure OpenReposicao(pReposicaoId : Integer);
    Procedure LimpaListaColeta;
    Procedure MontaListaColeta;
    procedure ClearRegistroColeta;
    Procedure GetColeta;
    Function SalvaItemColetado : Boolean;
    Procedure FinalizarColeta;
    Procedure PositionAddress;
    Procedure ContrMovQtde;
    Procedure SalvarColeta;
    Procedure GetEstoqueColeta;
    Procedure GetLoteTransferencia;
    Procedure LimparTransferencia;
    Procedure GetProdutoTransferencia;
    Procedure MontaListaProdutoTransferencia;
    Procedure ThreadTerminatePTransf(Sender : TObject);
    Procedure SalvarTransferencia;
    Function ReposicaoTransferenciaPicking : Boolean;
    Procedure PosicionaLstTransferenciaEstoque;
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Procedure ShowDados; OverRide;
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
    Procedure AtivarTransferenciaPicking;
  end;

var
  FrmReposicaoTransferenciaPicking: TFrmReposicaoTransferenciaPicking;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, U_MsgD, EstoqueCtrl;

procedure TFrmReposicaoTransferenciaPicking.ActContrMovQtdeNegadaExecute(Sender: TObject);
begin
  inherited;
  EdtQtdApanhe.Text := '';
  DelayEdSetFocus(EdtQtdApanhe);
end;

procedure TFrmReposicaoTransferenciaPicking.AtivarTransferenciaPicking;
begin
  PgcPrincipal.ActiveTab := TabReposicaoTransferencia;
  BtnArrowLeft.Enabled   := False;
  BtnArrowRigth.Enabled  := False;
end;

procedure TFrmReposicaoTransferenciaPicking.ActContrMovQtdeExecute(Sender: TObject);
begin
  inherited;
  SalvarColeta;
end;

procedure TFrmReposicaoTransferenciaPicking.BtnSearchPesqClick(Sender: TObject);
begin
//  inherited;
  if StrToIntDef(EdtConteudoPesq.Text, 0) =  0 then Begin
     ShowErro('Informe um Id válido');
     Exit;
  End;
  OpenReposicao(StrToIntDef(EdtConteudoPesq.Text, 0));
end;

procedure TFrmReposicaoTransferenciaPicking.EdtCodigoChange(Sender: TObject);
begin
  inherited;
//  Limpar;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtCodigoExit(Sender: TObject);
begin
  inherited;
  if (EdtCodigo.ReadOnly) or (EdtReposicaoId.Text= '') then Exit;
  if StrToIntDef(EdtReposicaoId.Text, 0) <= 0 then Begin
     SetCampoDefault('EdtReposicaoId');
     ShowErro('Id da Reposição é inválido!');
     Exit;
  End;
  OpenReposicao(StrToIntDef(EdtReposicaoId.Text, 0));
end;

procedure TFrmReposicaoTransferenciaPicking.EdtCodProdutoTransferenciaExit(
  Sender: TObject);
Var ObjProdutoCtrl : TProdutoCtrl;
    vProdutoId     : Integer;
    FocusActual    : TControl;
begin
  inherited;
  if EdtCodprodutoTransferencia.Text = '' then Exit;
  inherited;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  vProdutoId     := ObjProdutoCtrl.GetCodProdEan(EdtCodProdutoTransferencia.Text);
  if vProdutoId <= 0 then Begin
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Produto não encontrado!');
  End
  Else If (Not FdMemReposicaoTransferencia.Locate('IdProduto', vProdutoId, [])) then Begin
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Produto sem transferência!');
  End
  Else Begin
    EdtCodProdutoTransferencia.Tag :=  FdMemReposicaoTransferencia.FieldByName('IdProduto').AsInteger;
    LblProdutoTransferencia.Text   :=  FdMemReposicaoTransferencia.FieldByName('Descricao').AsString;
    LblPickingTransferencia.Text   :=  EnderecoMask(FdMemReposicaoTransferencia.FieldByName('Endereco').AsString,FdMemReposicaoTransferencia.FieldByName('Mascara').AsString, True);
    LblZonaTransferencia.Text      :=  FdMemReposicaoTransferencia.FieldByName('Zona').AsString;
    GetLoteTransferencia;
    if CbLoteTransferencia.Items.Count = 1 then Begin
       CbLoteTransferencia.ItemIndex := 0;
       DelayEdSetFocus(EdtEnderecoTransferencia);
    End
    Else
       DelayEdSetFocus(CbLoteTransferencia);
  End;
  ObjProdutoCtrl.Free;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtCodProdutoTransferenciaKeyUp(
  Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key=13) and (EdtCodprodutoTransferencia.Text<>'') then Begin
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     Key := 0;
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtCodProdutoTransferenciaTyping(
  Sender: TObject);
begin
  inherited;
  LimparTransferencia;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtEanKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  //Key := 0;
  //KeyChar := #0;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtEanValidate(Sender: TObject;
  var Text: string);
Var ObjProdutoCtrl : TProdutoCtrl;
    vProdutoId     : Integer;
    FocusActual    : TControl;
begin
  if Text = '' then Exit;
  inherited;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  If ObjProdutoCtrl.GetCodProdEan(Text) <> FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger then Begin
     SetCampoDefault('EdtEan');
     ShowErro('Produto inválido!');
     EdtEan.Text := '';
     Text        := '';
  End
  Else Begin
    DelayEdSetFocus(EdtQtdApanhe);
    //FocusActual := ActiveControl;
    //ActiveControl := nil;
  End;
  ObjProdutoCtrl.Free;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtEnderecoExit(Sender: TObject);
begin
  inherited;
  if EdtEndereco.Text = '' then Exit;
  if EdtEndereco.text <> StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then Begin
     SetCampoDefault('EdtEndereco');
     ShowErro('Endereço('+EdtEndereco.Text+') de Coleta inválido!');
     EdtEndereco.Text := '';
  End;
//  Else
//     GetEstoqueColeta;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtEnderecoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = 13)then Begin
     if (EdtEndereco.Text='') then Begin
        SetCampoDefault('EdtEndereco');
        ShowErro('Informe o endereço da coleta.');
        DelayEdSetFocus(EdtEndereco);
     End
     Else
        DelayEdSetFocus(EdtEan);
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtEnderecoTransferenciaExit(
  Sender: TObject);
begin
  inherited;
  if EdtEnderecoTransferencia.Text <> '' then Begin
     if StringReplace(EdtEnderecoTransferencia.Text, ' ', '', [rfReplaceAll]) <> FdMemReposicaoTransferencia.FieldByName('Endereco').AsString then Begin
        SetCampoDefault('EdtEnderecoTransferencia');
        ShowErro('Picking inválido.', 'alerta'); //correto: '+FdMemReposicaoTransferencia.FieldByName('Endereco').AsString);
     End
     Else  DelayEdSetFocus(EdtQtdTransferencia);
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtEnderecoTransferenciaTyping(
  Sender: TObject);
begin
  inherited;
  if (EdtCodProdutoTransferencia.Text = '') and (EdtEnderecoTransferencia.Text<>'') then Begin
     EdtEnderecoTransferencia.Text := '';
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Informe o Produto antes do Endereço.');
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtQtdApanheKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
 Var xRecno : Integer;
begin
  inherited;
  if EdtQtdApanhe.Text = '' then Exit;
  if (key = 27) and ((Sender = EdtEndereco) or (Sender = EdtQtdApanhe)) then
     //ClearRegistroColeta
  Else if (Key = 13) then Begin
     if EdtEan.Text = '' then Begin
        SetCampoDefault('EdtEan');
        ShowErro('Beep o Produto.');
        Exit;
     End;
     if EdtEndereco.Text <>  StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then Begin
        EdtEndereco.Text  := '';
        EdtQtdApanhe.Text := '';
        DelayEdSetFocus(EdtEndereco);
        raise Exception.Create('Erro: Endereço de coleta inválido');
     End;
     Key := 0;
     if EdtQtdApanhe.Text = '' then Begin
        EdtQtdApanhe.Text := '';
        DelayEdSetFocus(EdtQtdApanhe);
        raise Exception.Create('Erro: Informe a coleta ou 0(Zero)');
     End;
     if StrToIntDef(EdtQtdApanhe.Text, 0) < 0 then Begin
        EdtQtdApanhe.Text := '';
        DelayEdSetFocus(EdtQtdApanhe);
        raise Exception.Create('Erro: Quantidade de Coleta inválida');
     End;
     if StrToIntDef(EdtQtdApanhe.Text, 0) > StrToIntDef(EdtDisponivel.Text, 0) then Begin
        EdtQtdApanhe.Text := '';
        DelayEdSetFocus(EdtQtdApanhe);
        raise Exception.Create('Erro: Quantidade não disponível!');
     End;
     if (StrToIntDef(EdtQtdApanhe.Text, 0) > 999) then Begin

     End;

{     if (1=2) and (StrToIntDef(EdtQtdApanhe, 0) > StrToIntDef(EdtDisponivel.Text, 0)) then Begin
        EdtQtdApanhe.Text := '';
        DelayEdSetFocus(EdtQtdApanhe);
        raise Exception.Create('Erro: Não há estoque disponível para transferência.');
     End;
}     //SalvarItemColetado //Criar rotina para gravar item a item na Área De Espera da reposição
     Try
       if StrToInt64(EdtQtdApanhe.Text) > 100 then
          ContrMovQtde
       Else SalvarColeta;
     Except On E: Exception do Begin
       SetCampoDefault('EdtQtdApanhe');
       ShowErro('Erro: Quatidade('+EdtQtdApanhe.Text+') com erro. '+E.Message);
     End;
     End;
  End
end;

procedure TFrmReposicaoTransferenciaPicking.EdtQtdTransferenciaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key=13) and (EdtQtdTransferencia.Text<>'') then Begin
     if StrToIntDef(EdtQtdTransferencia.text, 0) <= 0 then Begin
        SetCampoDefault('EdtQtdTransferencia');
        ShowErro('Quantidade inválida para transferência!');
     End
     Else if (StrToIntDef(EdtQtdTransferencia.Text, 0) > FdMemReposicaoTransferencia.FieldByName('Qtde').AsInteger) then Begin
        SetCampoDefault('EdtQtdTransferencia');
        ShowErro('Quantidade não disponível para transferência!');
     End
     Else
        SalvarTransferencia;
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.EdtQtdTransferenciaTyping(Sender: TObject);
begin
  inherited;
  if EdtQtdTransferencia.Text = '' then exit;
  if (EdtCodProdutoTransferencia.Text = '') then Begin
     EdtQtdTransferencia.Text := '';
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Informe o Produto antes da Quantidade.');
  End
  Else if (EdtEnderecoTransferencia.Text = '') then Begin
     EdtQtdTransferencia.Text := '';
     SetCampoDefault('EdtEnderecoTransferencia');
     ShowErro('Informe o Picking para Transferir.');
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.CbLoteTransferenciaExit(Sender: TObject);
Var xRecno : Integer;
begin
  inherited;
  LblVencimentoTransferencia.Text := '';
  If CbLoteTransferencia.ItemIndex < 0 then Exit;
  xRecno := FdMemReposicaoTransferencia.RecNo;
  if CbLoteTransferencia.Items.Strings[CbLoteTransferencia.ItemIndex] <> '' then Begin
     If Not FdMemReposicaoTransferencia.Locate('IdProduto;Lote', VarArrayOf([EdtCodProdutoTransferencia.Tag, CbLoteTransferencia.Items.Strings[CbLoteTransferencia.ItemIndex]]), []) then Begin
        SetCampoDefault('CbLoteTransferencia');
        ShowErro('Lote inválido para transferência');
        LblVencimentoTransferencia.Text := '';
        FdMemReposicaoTransferencia.RecNo := xRecno;
     End
     else Begin
        LblVencimentoTransferencia.Text := FdMemReposicaoTransferencia.FieldByName('Vencimento').AsString;
     End;
  End
  Else Begin
    SetCampoDefault('CbLoteTransferencia');
    ShowErro('Selecione o Lote');
    FdMemReposicaoTransferencia.RecNo := xRecno;
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.CbLoteTransferenciaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then Begin
     Key := 0;
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.ClearRegistroColeta;
begin
  EdtCodProduto.Text := '';
  Txtproduto.Text    := '';
  TxtEmbalagem.Text  := '';
  TxtPicking.Text    := '';
  TxtZona.Text       := '';
  TxtLote.Text       := '';
  TxtVencimento.Text := '';
  EdtDemanda.Text    := '';
  EdtDisponivel.Text := '';
  EdtEndereco.Text   := '';
  LblEndereco.Text   := '';
  EdtEan.Text        := '';
  EdtQtdApanhe.Text  := '';
end;

procedure TFrmReposicaoTransferenciaPicking.ContrMovQtde;
begin
  MsgD.FormMsg := FrmeXactWMS;
  MsgD.Title   := 'Controle Coleta';
  MsgD.Text    := 'Deseja Movimentar '+EdtQtdApanhe.Text+' Unid.?';
  MsgD.ActionOk   := ActContrMovQtde;
  MsgD.ActionCancel := ActContrMovQtdeNegada;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

procedure TFrmReposicaoTransferenciaPicking.FinalizarColeta;
Var JsonArrayColeta : TJsonArray;
    JsonColeta      : TJsonObject;
    xColeta         : integer;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
begin
  JsonArrayColeta := TJsonArray.Create;
  FdMemReposicaoColeta.First;
  while Not FdMemReposicaoColeta.Eof do Begin
    JsonColeta := TJsonObject.Create;
    JsonColeta.AddPair('reposicaoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger));
    JsonColeta.AddPair('produtoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger));
    JsonColeta.AddPair('codproduto', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger));
    JsonColeta.AddPair('pickingid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('PickingId').AsInteger));
    JsonColeta.AddPair('loteid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('LoteId').AsInteger));
    JsonColeta.AddPair('enderecoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger));
    JsonColeta.AddPair('estoquetipoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('EstoqueTipoId').AsInteger));
    JsonColeta.AddPair('qtde', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('Demanda').AsInteger));
    JsonColeta.AddPair('qtdrepo', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('Reposicao').AsInteger));
    JsonColeta.AddPair('usuarioid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('UsuarioId').AsInteger));
    JsonColeta.AddPair('terminal', FdMemReposicaoColeta.FieldByName('Terminal').AsString);
    JsonColeta.AddPair('dtentrada', DateToStr(FdMemReposicaoColeta.FieldByName('Dtcoleta').AsDateTime));
    JsonColeta.AddPair('hrentrada', FdMemReposicaoColeta.FieldByName('hrColeta').AsString);
    JsonArrayColeta.AddElement(JsonColeta);
    FdMemReposicaoColeta.Next;
  End;
  If ObjReposicaoCtrl.reposicaofinalizar(JsonArrayColeta) Then Begin
     ShowOk('Coleta da reposição('+EdtReposicaoId.Text+') finalizada!');
     PgcPrincipal.ActiveTab := TabLista;
     JsonArrayColeta.Free;
     ClearRegistroColeta;
     Limpar;
//     GetListaReposicaoPendente;
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.FormCreate(Sender: TObject);
begin
  inherited;
  if FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposição - Visualizar Saldo para Transferência') then
     pVisualizarSaldoTransferecia := True
  Else
     pVisualizarSaldoTransferecia := False;
  if FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposição - Visualizar Estoque Disp. Coleta') then
     pVisualizarEstoqueDisponivel := True
  Else
     pVisualizarEstoqueDisponivel := False;
  LblDisponivel.Visible := pVisualizarEstoqueDisponivel;
  EdtDisponivel.Visible := pVisualizarEstoqueDisponivel;
end;

procedure TFrmReposicaoTransferenciaPicking.GetColeta;
begin
  ClearRegistroColeta;
  EdtCodProduto.Text := FdMemReposicaoColeta.FieldByName('CodProduto').AsString;
  TxtProduto.Text    := FdMemReposicaoColeta.FieldByName('Descricao').AsString;
  TxtEmbalagem.Text  := FdMemReposicaoColeta.FieldByName('Embalagem').AsString;
  TxtPicking.Text    := EnderecoMask(FdMemReposicaoColeta.FieldByName('picking').AsString,
                                     FdMemReposicaoColeta.FieldByName('mascarapicking').AsString, True);
  TxtZona.Text       := FdMemReposicaoColeta.FieldByName('Zona').AsString;
  TxtLote.Text       := FdMemReposicaoColeta.FieldByName('DescrLote').AsString;
  TxtVencimento.Text := FdMemReposicaoColeta.FieldByName('Vencimento').AsString;
  EdtDemanda.Text    := FdMemReposicaoColeta.FieldByName('Demanda').AsString;
  EdtDisponivel.Text := FdMemReposicaoColeta.FieldByName('Disponivel').AsString;
  GetEstoqueColeta;
  LblEndereco.Text   := FdMemReposicaoColeta.FieldByName('Endereco').AsString;
  if FdMemReposicaoColeta.FieldByName('Reposicao').AsString <> '0' then
     EdtQtdApanhe.Text  := FdMemReposicaoColeta.FieldByName('Reposicao').AsString
  Else EdtQtdApanhe.Text := '';
  DelayEdSetFocus(EdtEndereco);
end;

procedure TFrmReposicaoTransferenciaPicking.GetEstoqueColeta;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if Not pVisualizarEstoqueDisponivel then Exit;  
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueJson(FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger,
                      FdMemReposicaoColeta.FieldByName('LoteId').AsInteger,
                      FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger, 0, 1, 1,
                      'N', 'N', 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     EdtDisponivel.Text := '0'
  Else
     if JsonArrayRetorno.Items[0].GetValue<Integer>('qtdereserva') >= FdMemReposicaoColeta.FieldByName('Demanda').AsInteger then
        EdtDisponivel.Text   := IntToStr(JsonArrayRetorno.Items[0].GetValue<Integer>('qtde')+FdMemReposicaoColeta.FieldByName('Demanda').AsInteger)
     Else EdtDisponivel.Text := IntToStr(JsonArrayRetorno.Items[0].GetValue<Integer>('qtde')+JsonArrayRetorno.Items[0].GetValue<Integer>('qtdereserva'));
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmReposicaoTransferenciaPicking.GetListaLstCadastro;
begin
  inherited;
  //GetListaReposicaoPendente;
end;

procedure TFrmReposicaoTransferenciaPicking.GetListaReposicaoPendente;
Var JsonArrayRetorno : TJsonArray;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
    vErro            : String;
    xReposicao       : Integer;
begin
  Showloading;
  Try
    JsonArrayRetorno := ObjReposicaoCtrl.GetConsultaReposicao(0, 0, 0, 0, 1);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro(vErro);
       JsonArrayRetorno := Nil;
       HideLoading;
       Exit;
    End;
    If QryListaPadrao.Active then
       QryListaPadrao.EmptyDataSet;
    QryListaPadrao.Close;
    QryListaPadrao.LoadFromJSON(JsonArrayRetorno, False);
    LstPrincipal.BeginUpdate;
    LstPrincipal.Items.Clear;
    If JsonArrayRetorno.Count >= 1 then Begin
       For xReposicao := 0 to Pred(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Count) do Begin
         With LstPrincipal.Items.Add do Begin
           TListItemText(Objects.FindDrawable('ReposicaoId')).Text     := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<Integer>('reposicaoid').ToString();
           if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<string>('dtreposicao') <> '') and
              (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<string>('dtreposicao') <> 'null') then
              TListItemText(Objects.FindDrawable('DtReposicao')).Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<string>('dtreposicao');
           if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<string>('enderecoinicial') <> '') Then
              TListItemText(Objects.FindDrawable('EnderecoIni')).Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<String>('enderecoinicial');
           if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<string>('zona') <> '') then
               TListItemText(Objects.FindDrawable('Zona')).Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xReposicao].GetValue<String>('zona');
         End;
       End;
    End;
    LstPrincipal.EndUpdate;
    JsonArrayRetorno := Nil;
  Except On E: Exception do
    ShowErro('Erro: '+E.Message);
  End;
  HideLoading;
end;

procedure TFrmReposicaoTransferenciaPicking.GetLoteTransferencia;
Var xRecno, xRecno2     : Integer;
    vProdutoid : Integer;
begin
  Try
    xRecno     := FdMemReposicaoTransferencia.RecNo;
    xRecno2    := FdMemReposicaoTransferencia.RecNo;
    vProdutoId := EdtCodProdutoTransferencia.Tag; //FdMemReposicaoTransferencia.FieldByName('IdProduto').Asinteger;
    CbLoteTransferencia.Items.Clear;
    FdMemReposicaoTransferencia.Filter   := 'IdProduto = '+vProdutoId.ToString();
    FdMemReposicaoTransferencia.Filtered := True;
    while (Not FdMemReposicaoTransferencia.Eof) do Begin //and (vProdutoId = FdMemReposicaoTransferencia.FieldByName('IdProduto').Asinteger) do Begin
      CbLoteTransferencia.Items.Add(FdMemReposicaoTransferencia.FieldByName('Lote').AsString);
      FdMemReposicaoTransferencia.Next;
    End;
    FdMemReposicaoTransferencia.Filter   := '';
    FdMemReposicaoTransferencia.Filtered := False;
    PosicionaLstTransferenciaEstoque;
    FdMemReposicaoTransferencia.RecNo := xRecno;
  Except On E: Exception do Begin
    SetCampoDefault('EdtCodProdutoTransferencia');
    ShowErro('Erro: '+E.Message);
    End;
  End;
  if StringReplace(LblPickingTransferencia.Text, '.', '', [rfReplaceAll]) <> FdMemReposicaoTransferencia.FieldByName('Endereco').AsString then Begin
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Informe o produto. '+xRecno.ToString()+', '+xRecno2.ToString()+', '+
              FdMemReposicaoTransferencia.RecNo.ToString() );
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.GetProdutoTransferencia;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  LblCircContagem.Text := '';
  if (FDMemReposicaoTransferencia.Active) then
     FDMemReposicaoTransferencia.EmptyDataSet;
  FDMemReposicaoTransferencia.Close;
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetListaTransferencia;
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     FDMemReposicaoTransferencia.LoadFromJSON(JsonArrayRetorno, False);
     MontaListaProdutoTransferencia;
  End
  Else
     ShowErro('Lista de Transferência vazia!');
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmReposicaoTransferenciaPicking.LimpaListaColeta;
begin
  //LstInventario.Items.Clear;
end;

procedure TFrmReposicaoTransferenciaPicking.Limpar;
begin
  //inherited;
  If FDMemReposicao.Active then begin
     FdMemReposicao.EmptyDataSet;
     //FdMemReposicaoColeta.Filter   := '';
     //FdMemReposicaoColeta.Filtered := False;
  end;
  FdMemReposicao.Close;
  If FDMemReposicaoColeta.Active then
     FdMemReposicaoColeta.EmptyDataSet;
  FdMemReposicaoColeta.Close;
  EdtReposicaoId.Text       := '';
  EdtDtReposicao.Text  := '';
  EdtZona.Text         := '';;
  LblCircContagem.Text := '';
  LblTitReposicao.Text := '';
end;

procedure TFrmReposicaoTransferenciaPicking.LimparTransferencia;
begin
  LblProdutoTransferencia.Text    := '';
  LblEmbalagemTransferencia.Text  := '';
  LblPickingTransferencia.Text    := '';
  LblZonaTransferencia.Text       := '';
  CbLoteTransferencia.Items.Clear;
  LblVencimentoTransferencia.Text := '';
  EdtEnderecoTransferencia.Text   := '';
  EdtQtdTransferencia.Text        := '';
  LblCircContagem.Text            := '';
end;

procedure TFrmReposicaoTransferenciaPicking.LstPrincipalItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstPrincipal.Items[AItem.Index].Objects.FindDrawable('ReposicaoId'));
  EdtConteudoPesq.text := TxtItem.Text; //Txt.TagString;
//  EdtReposicaoId.Text       := TxtItem.Text; //Txt.TagString;
end;

procedure TFrmReposicaoTransferenciaPicking.MontaListaColeta;
begin

end;

procedure TFrmReposicaoTransferenciaPicking.MontaListaProdutoTransferencia;
var TThreadPTransf : TThread;
begin
  LstTransferenciaEstoque.ScrollTo(0);
  LstTransferenciaEstoque.BeginUpdate;
  LstTransferenciaEstoque.Items.Clear;
  TThreadPTransf := TThread.CreateAnonymousThread(procedure
  Begin
    While Not FDMemReposicaoTransferencia.Eof do Begin
      With LstTransferenciaEstoque.Items.Add do Begin
        TThread.Synchronize(TThread.CurrentThread, procedure
          Begin
            TListItemText(Objects.FindDrawable('CodProduto')).Text := FdMemReposicaoTransferencia.FieldByName('CodProduto').AsString;
            TListItemText(Objects.FindDrawable('Descricao')).Text  := FdMemReposicaoTransferencia.FieldByName('Descricao').AsString;
            TListItemText(Objects.FindDrawable('Lote')).Text       := FdMemReposicaoTransferencia.FieldByName('Lote').AsString;
            TListItemText(Objects.FindDrawable('Vencimento')).Text := FdMemReposicaoTransferencia.FieldByName('Vencimento').AsString;
            if pVisualizarSaldoTransferecia then
               TListItemText(Objects.FindDrawable('Saldo')).Text   := FdMemReposicaoTransferencia.FieldByName('Qtde').AsString
            Else
               TListItemText(Objects.FindDrawable('Saldo')).Text   := '';
          end);
      End;
      FDMemReposicaoTransferencia.Next;
    End;
  end);
  TThreadPTransf.OnTerminate := ThreadTerminatePTransf;
  TThreadPTransf.Start;
  LstPrincipal.EndUpdate;
end;

procedure TFrmReposicaoTransferenciaPicking.OpenReposicao(pReposicaoId: Integer);
Var vErro   : String;
    pProcessoId      : Integer;
    vZonaId : Integer;
    xRetorno  : Integer;
    xBody     : Integer;
    vZonaNull : String;
    JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
begin
  inherited;
  Limpar;
  Showloading;
  ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
  JsonArrayRetorno := ObjPedidoCtrl.GetConsultaReposicao(0, 0, pReposicaoId, 0, 0);
  if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
     LimpaListaColeta;
     JsonArrayRetorno := Nil;
     ObjPedidoCtrl.Free;
  End
  Else Begin
    EdtReposicaoId.Text := EdtConteudoPesq.Text;
    LblTitReposicao.Text := 'Ordem: '+EdtReposicaoId.Text;
    EdtConteudoPesq.Text := '';
    xRetorno := 0;
    if (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtreposicao') <> '') and
       (JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtreposicao') <> 'null') then
       EdtDtReposicao.Text := JsonArrayRetorno.Items[xRetorno].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<string>('dtreposicao');
    EdtZona.Text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[xRetorno].GetValue<String>('zona');
    FdMemReposicaoColeta.Open;
    for xRetorno := 0 to Pred(JsonArrayRetorno.Count) do Begin
      //Dados da Coleta
      for xBody := 0 to Pred(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Count) do Begin
        FdMemReposicaoColeta.Append;
        FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger    := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicaoid');
        FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('produtoid');
        FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger     := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('codproduto');
        FdMemReposicaoColeta.FieldByName('Descricao').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descricao');
        FdMemReposicaoColeta.FieldByName('Embalagem').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('embalagem');
        FdMemReposicaoColeta.FieldByName('FatorConversao').AsInteger := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('fatorconversao');
        FdMemReposicaoColeta.FieldByName('PickingId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('pickingid');
        FdMemReposicaoColeta.FieldByName('Picking').AsString         := EnderecoMask(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('picking'),
                                                                                     JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking'), True);
        FdMemReposicaoColeta.FieldByName('MascaraPicking').AsString  := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking');
        FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger     := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('enderecoid');
        FdMemReposicaoColeta.FieldByName('Endereco').AsString        := EnderecoMask(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('endereco'),
                                                                                     JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascara'), True);
        FdMemReposicaoColeta.FieldByName('Mascara').AsString         := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascara');
        FdMemReposicaoColeta.FieldByName('ZonaId').AsInteger         := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('zonaid');
        FdMemReposicaoColeta.FieldByName('Zona').AsString            := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('zona');
        FdMemReposicaoColeta.FieldByName('LoteId').AsInteger         := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('loteid');
        FdMemReposicaoColeta.FieldByName('DescrLote').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descrlote');
        FdMemReposicaoColeta.FieldByName('Vencimento').AsDateTime    := StrToDate(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('vencimento'));
        FdMemReposicaoColeta.FieldByName('Demanda').AsInteger        := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('demanda');
        if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('estoquetipoid') <> '' then
           FdMemReposicaoColeta.FieldByName('estoquetipoid').AsInteger  := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<integer>('estoquetipoid');
        if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('reposicao') <> '' then
           FdMemReposicaoColeta.FieldByName('Reposicao').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicao');
        if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('usuarioid') <> '' then
           FdMemReposicaoColeta.FieldByName('UsuarioId').Asinteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<integer>('usuarioid');
        FdMemReposicaoColeta.FieldByName('Nome').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('nome');
        FdMemReposicaoColeta.FieldByName('Terminal').AsString      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('terminal');
        if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<string>('dataentrada') <> '' then
           FdMemReposicaoColeta.FieldByName('DtColeta').AsDateTime      := StrToDate(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('dataentrada'));
        FdMemReposicaoColeta.FieldByName('HrColeta').AsString        := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('hrentrada');
        FdMemReposicaoColeta.Post;
      End;
    End;
    //FdMemReposicaoColeta.Filter   := 'UsuarioId is Null or UsuarioId = 0';
    //FdMemReposicaoColeta.Filtered := True;
    FdMemReposicaoColeta.First;
    PositionAddress;
    JsonArrayRetorno := Nil;
    ObjPedidoCtrl.Free;
    GetColeta;
    //GetReposicaoProduto;
  End;
  PgcPrincipal.ActiveTab := TabDetalhes;
  LblCircContagem.Text   := FdMemReposicaoColeta.RecordCount.ToString;
  HideLoading
end;

function TFrmReposicaoTransferenciaPicking.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin

end;

procedure TFrmReposicaoTransferenciaPicking.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if PgcPrincipal.ActiveTab = TabLista then Begin
     CbCampoPesq.Enabled := True;
     //GetListaReposicaoPendente;
     BtnArrowLeft.Action       := ChgTabTransferencia;
     LblProcessoReposicao.Text := 'Reposição - Coleta';
     BtnArrowRigth.Action      := ChgTabDet;
     if FdMemReposicaoColeta.Active then
        LblCircContagem.Text   := FdMemReposicaoColeta.RecordCount.ToString;
  End
  Else If PgcPrincipal.ActiveTab = TabDetalhes then Begin
     LblProcessoReposicao.Text := 'Reposição - Coleta';
     BtnArrowLeft.Action       := ChgTabLista;
     BtnArrowRigth.Action      := ChgTabLista; //ChgTabTransferencia;
  End
  Else If PgcPrincipal.ActiveTab = TabReposicaoTransferencia then Begin
     LblProcessoReposicao.Text := 'Transferência Picking';
     GetProdutoTransferencia;
     DelayEdSetFocus(EdtCodProdutoTransferencia);
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.PosicionaLstTransferenciaEstoque;
Var xItem : Integer;
    TxtItem : TListItemText;
begin
  for xItem := 0 to Pred(LstTransferenciaEstoque.Items.Count) do Begin
    TxtItem := TListItemText(LstTransferenciaEstoque.Items[xItem].Objects.FindDrawable('CodProduto'));
    if TxtItem.Text = EdtCodProdutoTransferencia.Text then Begin
       //{ Seleciona o quarto item }
       LstTransferenciaEstoque.ItemIndex := xItem;
       { Manda o foco para o quarto item }
       //LstTransferenciaEstoque.Items.Item[xItem].Focused := true;
       Break;
    End;
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.PositionAddress;
begin
  FdMemReposicaoColeta.First;
  While (FdMemReposicaoColeta.FieldByName('UsuarioId').AsInteger <> 0) And
        (Not FdMemReposicaoColeta.Eof) Do Begin
    FdMemReposicaoColeta.Next;
  End;
end;

Function TFrmReposicaoTransferenciaPicking.SalvaItemColetado : Boolean;
Var JsonArrayColeta : TJsonArray;
    JsonColeta      : TJsonObject;
    xColeta         : integer;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
begin
  JsonArrayColeta := TJsonArray.Create;
  JsonColeta := TJsonObject.Create;
  JsonColeta.AddPair('reposicaoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger));
  JsonColeta.AddPair('produtoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger));
  JsonColeta.AddPair('codproduto', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger));
  JsonColeta.AddPair('pickingid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('PickingId').AsInteger));
  JsonColeta.AddPair('loteid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('LoteId').AsInteger));
  JsonColeta.AddPair('enderecoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger));
  JsonColeta.AddPair('estoquetipoid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('EstoqueTipoId').AsInteger));
  JsonColeta.AddPair('qtde', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('Demanda').AsInteger));
  JsonColeta.AddPair('qtdrepo', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('Reposicao').AsInteger));
  JsonColeta.AddPair('usuarioid', TJsonNumber.Create(FdMemReposicaoColeta.FieldByName('UsuarioId').AsInteger));
  JsonColeta.AddPair('terminal', FdMemReposicaoColeta.FieldByName('Terminal').AsString);
  JsonColeta.AddPair('dtentrada', DateToStr(FdMemReposicaoColeta.FieldByName('Dtcoleta').AsDateTime));
  JsonColeta.AddPair('hrentrada', FdMemReposicaoColeta.FieldByName('hrColeta').AsString);
  JsonArrayColeta.AddElement(JsonColeta);
  If Not ObjReposicaoCtrl.reposicaoSalvarItemColetado(JsonArrayColeta) Then Begin
     ShowErro('Erro no registro da coleta.');
     Result := False;
  End
  Else Begin
     Result := True;
  End;
  JsonArrayColeta.Free;
end;

procedure TFrmReposicaoTransferenciaPicking.SalvarColeta;
Var xRecno : Integer;
begin
  xRecno := FdMemReposicaoColeta.Recno;
  FdMemReposicaoColeta.Edit;
  FdMemReposicaoColeta.FieldByName('Reposicao').Value := StrToIntDef(EdtQtdApanhe.Text, 0);
  FdMemReposicaoColeta.FieldByName('UsuarioId').Value := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  FdMemReposicaoColeta.FieldByName('Nome').Value      := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome;
  FdMemReposicaoColeta.FieldByName('Terminal').Value  := NomeDoComputador;
  FdMemReposicaoColeta.FieldByName('DtColeta').Value  := DateToStr(Now());
  FdMemReposicaoColeta.FieldByName('HrColeta').Value  := TimeToStr(Time());
  FdMemReposicaoColeta.Post;
  FdMemReposicaoColeta.Recno := xRecno;
  xRecno := FdMemReposicaoColeta.Recno;
  If SalvaItemColetado Then begin
     FdmemReposicaoColeta.Next;
     if FdMemReposicaoColeta.Eof then
        FinalizarColeta
     Else
        GetColeta;
  end
  Else begin
     EdtEndereco.Text  := '';
     EdtEan.Text       := '';
     EdtQtdApanhe.Text := '';
     DelayEdSetFocus(EdtEndereco);
  end;
end;

Function TFrmReposicaoTransferenciaPicking.ReposicaoTransferenciaPicking: Boolean;
Var JsonTransferecia : TJsonObject;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
    JsonArrayRetorno : TjsonArray;
    vErro : String;
begin
  Result := False;
  JsonTransferecia := TJsonObject.Create;
  JsonTransferecia.AddPair('produtoid', TJsonNumber.Create(FdMemReposicaoTransferencia.FieldByName('IdProduto').AsInteger));
  JsonTransferecia.AddPair('codproduto', TJsonNumber.Create(FdMemReposicaoTransferencia.FieldByName('CodProduto').AsInteger));
  JsonTransferecia.AddPair('pickingid', TJsonNumber.Create(FdMemReposicaoTransferencia.FieldByName('EnderecoId').AsInteger));
  JsonTransferecia.AddPair('loteid', TJsonNumber.Create(FdMemReposicaoTransferencia.FieldByName('LoteId').AsInteger));
  JsonTransferecia.AddPair('enderecoid', TJsonNumber.Create(FdMemReposicaoTransferencia.FieldByName('EnderecoId').AsInteger));
  JsonTransferecia.AddPair('estoquetipoid', TJsonNumber.Create(4));
  JsonTransferecia.AddPair('qtde', TJsonNumber.Create(FdMemReposicaoTransferencia.FieldByName('Qtde').AsInteger));
  JsonTransferecia.AddPair('qtdrepo', TJsonNumber.Create(StrToIntDef(EdtqtdTransferencia.Text, 0)));//FdMemReposicaoTransferencia.FieldByName('Qtde').AsInteger));
  JsonTransferecia.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
//  Para Log/Histórico
  JsonTransferecia.AddPair('terminal', NomeDoComputador);
//  JsonTransferecia.AddPair('data', DateToStr(Date()));
//  JsonTransferecia.AddPair('hora', FdMemReposicaoTransferencia.FieldByName('hrColeta').AsString);
  JsonArrayRetorno := ObjReposicaoCtrl.ReposicaoTransferenciaPicking(JsonTransferecia);
  If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) Then Begin
     SetCampoDefault('EdtQtdTransferencia');
     ShowErro('Erro: '+vErro);
     Result := False;
  End
  Else
     Result := True;
  Try 
    JsonArrayRetorno := Nil;
    JsonTransferecia.Free;
    ObjReposicaoCtrl.Free; 
  Except 
  End;
end;

procedure TFrmReposicaoTransferenciaPicking.SalvarTransferencia;
begin
//GSS 210324
  if ReposicaoTransferenciaPicking then Begin
     GetProdutoTransferencia;
     EdtCodProdutoTransferencia.Text := '';
     LimparTransferencia;
     DelayEdSetFocus(EdtCodProdutoTransferencia);
  End
end;

procedure TFrmReposicaoTransferenciaPicking.ShowDados;
begin
  inherited;

end;

procedure TFrmReposicaoTransferenciaPicking.ThreadTerminatePTransf(Sender: TObject);
begin
   LstTransferenciaEstoque.EndUpdate;
   LblCircContagem.Text := FdMemReposicaoTransferencia.RecordCount.ToString();
end;

procedure TFrmReposicaoTransferenciaPicking.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtEnderecoTransferencia' then Begin
     EdtEnderecoTransferencia.Text := '';
     DelayEdSetFocus(EdtEnderecoTransferencia);
  End                  //'EdtCodProdutoTransferencia'
  Else if CampoDefault = 'EdtCodProdutoTransferencia' then Begin
     EdtCodprodutoTransferencia.Text := '';
     DelayEdSetFocus(EdtCodprodutoTransferencia);
  End
  Else if CampoDefault = 'CbLoteTransferencia' then Begin
     CbLoteTransferencia.ItemIndex := -1;
     DelayEdSetFocus(CbLoteTransferencia);
  End
  Else if CampoDefault = 'EdtQtdTransferencia' then Begin
     EdtQtdTransferencia.Text := '';
     DelayEdSetFocus(EdtQtdTransferencia);
  End
end;

end.

