unit uFrmReposicaoReabastecer;

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
  TFrmReposicaoReabastecer = class(TFrmBase)
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
    LblProdutoColeta: TLabel;
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
    FdMemReposicaoColetaBloqueioInventarioProduto: TIntegerField;
    FdMemReposicaoColetaBloqueioInventarioEndereco: TIntegerField;
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
    procedure EdtEnderecoTransferenciaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
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
    vUltimoEnderecoColetado      : String;
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
    Procedure ReposicaoRegistrarInUse;
    Procedure ThreadReposicaoRegistrarInUseTerminate(Sender : TObject);
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
  FrmReposicaoReabastecer: TFrmReposicaoReabastecer;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, U_MsgD, EstoqueCtrl;

procedure TFrmReposicaoReabastecer.ActContrMovQtdeNegadaExecute(Sender: TObject);
begin
  inherited;
  EdtQtdApanhe.Text := '';
  DelayEdSetFocus(EdtQtdApanhe);
end;

procedure TFrmReposicaoReabastecer.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtCodProdutoTransferencia' then Begin
     EdtCodProdutoTransferencia.Text := '';
     DelayEdSetFocus(EdtCodProdutoTransferencia);
  End
  Else if CampoDefault = 'EdtEan' then Begin
     EdtEan.Text := '';
     DelayEdSetFocus(EdtEan);
  End
  Else if CampoDefault = 'EdtEndereco' then Begin
     EdtEndereco.Text := '';
     DelayEdSetFocus(EdtEndereco);
  end
  Else if CampoDefault = 'EdtEnderecoTransferencia' then Begin
     EdtEnderecoTransferencia.Text := '';
     DelayEdSetFocus(EdtEnderecoTransferencia);
  end
  Else if CampoDefault = 'EdtQtdApanhe' then Begin
     EdtQtdApanhe.Text := '';
     DelayEdSetFocus(EdtQtdApanhe);
  end
  Else if CampoDefault = 'EdtQtdTransferencia' then Begin
     EdtQtdTransferencia.Text := '';
     DelayEdSetFocus(EdtQtdTransferencia);
  end
  Else if CampoDefault = 'CbLoteTransferencia' then Begin
     CbLoteTransferencia.ItemIndex := -1;
     DelayEdSetFocus(CbLoteTransferencia);
  end;
End;

procedure TFrmReposicaoReabastecer.AtivarTransferenciaPicking;
begin
  PgcPrincipal.ActiveTab := TabReposicaoTransferencia;
  BtnArrowLeft.Enabled   := False;
  BtnArrowRigth.Enabled  := False;
end;

procedure TFrmReposicaoReabastecer.ActContrMovQtdeExecute(Sender: TObject);
begin
  inherited;
  SalvarColeta;
end;

procedure TFrmReposicaoReabastecer.BtnSearchPesqClick(Sender: TObject);
begin
//  inherited;
  if StrToIntDef(EdtConteudoPesq.Text, 0) =  0 then Begin
     ShowErro('Informe um Id válido');
     DelayEdSetFocus(EdtConteudoPesq);
     Exit;
  End ;
  OpenReposicao(StrToIntDef(EdtConteudoPesq.Text, 0));
end;

procedure TFrmReposicaoReabastecer.EdtCodigoChange(Sender: TObject);
begin
  inherited;
//  Limpar;
end;

procedure TFrmReposicaoReabastecer.EdtCodigoExit(Sender: TObject);
begin
  inherited;
  if (EdtCodigo.ReadOnly) or (EdtReposicaoId.Text= '') then Exit;
  if StrToIntDef(EdtReposicaoId.Text, 0) <= 0 then Begin
     ShowErro('Id da Reposição é inválido!');
     Exit;
  End;
  OpenReposicao(StrToIntDef(EdtReposicaoId.Text, 0));
end;

procedure TFrmReposicaoReabastecer.EdtCodProdutoTransferenciaExit(
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
    DelayEdSetFocus(CbLoteTransferencia);
  End;
  ObjProdutoCtrl.Free;
end;

procedure TFrmReposicaoReabastecer.EdtCodProdutoTransferenciaKeyUp(
  Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key=13) and (EdtCodprodutoTransferencia.Text<>'') then Begin
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     Key := 0;
  End;
end;

procedure TFrmReposicaoReabastecer.EdtCodProdutoTransferenciaTyping(
  Sender: TObject);
begin
  inherited;
  LimparTransferencia;
end;

procedure TFrmReposicaoReabastecer.EdtEanKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  //Key := 0;
  //KeyChar := #0;
end;

procedure TFrmReposicaoReabastecer.EdtEanValidate(Sender: TObject;
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
     Text        := '';
  End
  Else Begin
    DelayEdSetFocus(EdtQtdApanhe);
    //FocusActual := ActiveControl;
    //ActiveControl := nil;
  End;
  ObjProdutoCtrl.Free;
end;

procedure TFrmReposicaoReabastecer.EdtEnderecoExit(Sender: TObject);
begin
  inherited;
  if EdtEndereco.Text = '' then Exit;
  if EdtEndereco.text <> StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then Begin
     SetCampoDefault('EdtEndereco');
     ShowErro('Endereço('+EdtEndereco.Text+') de Coleta inválido!');
  End
end;

procedure TFrmReposicaoReabastecer.EdtEnderecoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = 13)then Begin
     if (EdtEndereco.Text='') then Begin
        SetCampoDefault('EdtEndereco');
        ShowErro('Informe o endereço da coleta.');
     End
     Else
        DelayEdSetFocus(EdtEan);
  End;
end;

procedure TFrmReposicaoReabastecer.EdtEnderecoTransferenciaExit(
  Sender: TObject);
begin
  inherited;
  if EdtEnderecoTransferencia.Text <> '' then Begin
     if EdtEnderecoTransferencia.Text <> FdMemReposicaoTransferencia.FieldByName('Endereco').AsString then Begin
        SetCampoDefault('EdtEnderecoTransferencia');
        ShowErro('Picking(GSS) inválido para transferência!');
     End
     Else
        DelayEdSetFocus(EdtQtdTransferencia);
  End;
end;

procedure TFrmReposicaoReabastecer.EdtEnderecoTransferenciaKeyUp(
  Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (EdtCodProdutoTransferencia.Text = '') then Begin
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Informe o produto para Transferir.');
  End;
end;

procedure TFrmReposicaoReabastecer.EdtEnderecoTransferenciaTyping(
  Sender: TObject);
begin
  inherited;
  if (EdtCodProdutoTransferencia.Text = '') then Begin
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Informe o produto para Transferir.');
  End;
end;

procedure TFrmReposicaoReabastecer.EdtQtdApanheKeyUp(Sender: TObject;
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
     If (FdMemReposicaoColeta.FieldByName('BloqueioInventarioProduto').AsInteger=1) and (StrToIntDef(EdtQtdApanhe.Text, 0)<>0) then Begin
        EdtQtdApanhe.Text := '';
        SetCampoDefault('EdtQtdApanhe');
        ShowErro('Atenção: Produto bloqueado para Inventariar(Informe 0)!', 'alerta');
        Exit
     End;
     If (FdMemReposicaoColeta.FieldByName('BloqueioInventarioEndereco').AsInteger=1) and (StrToIntDef(EdtQtdApanhe.Text, 0)<>0) then Begin
        EdtQtdApanhe.Text := '';
        SetCampoDefault('EdtQtdApanhe');
        ShowErro('Atenção: Endereço bloqueado para Inventariar(Informe 0)!', 'alerta');
        Exit
     End;
     if EdtEndereco.Text <>  StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then Begin
        EdtEndereco.Text  := '';
        EdtQtdApanhe.Text := '';
        SetCampoDefault('EdtEndereco');
        ShowErro('Erro: Endereço de coleta inválido', 'alerta');
        Exit
     End;
     Key := 0;
     if EdtQtdApanhe.Text = '' then Begin
        EdtQtdApanhe.Text := '';
        SetCampoDefault('EdtQtdApanhe');
        ShowErro('Erro: Informe a coleta ou 0(Zero)', 'alerta');
        Exit;
     End;
     if StrToIntDef(EdtQtdApanhe.Text, 0) < 0 then Begin
        EdtQtdApanhe.Text := '';
        SetCampoDefault('EdtQtdApanhe');
        ShowErro('Erro: Quantidade de Coleta inválida', 'alerta');
        Exit;
     End;
     if StrToIntDef(EdtQtdApanhe.Text, 0) > StrToIntDef(EdtDisponivel.Text, 0) then Begin
        SetCampoDefault('EdtQtdApanhe');
        ShowErro('Erro: Quantidade não disponível!', 'alerta');
        Exit;
     End;
     Try
       if StrToInt64(EdtQtdApanhe.Text) > 9999 then
          ContrMovQtde
       Else SalvarColeta;
     Except On E: Exception do Begin
       SetCampoDefault('EdtQtdApanhe');
       ShowErro('Erro: Quatidade('+EdtQtdApanhe.Text+') com erro. '+E.Message);
       End;
     End;
  End
end;

procedure TFrmReposicaoReabastecer.EdtQtdTransferenciaKeyUp(Sender: TObject;
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

procedure TFrmReposicaoReabastecer.EdtQtdTransferenciaTyping(Sender: TObject);
begin
  inherited;
  if (EdtCodProdutoTransferencia.Text = '') then Begin
     SetCampoDefault('EdtCodProdutoTransferencia');
     ShowErro('Informe o produto para Transferir.');
  End
  Else if (EdtEnderecoTransferencia.Text = '') then Begin
     SetCampoDefault('EdtEnderecoTransferencia');
     ShowErro('Informe o Picking para Transferir.');
  End;
end;

procedure TFrmReposicaoReabastecer.CbLoteTransferenciaExit(Sender: TObject);
begin
  inherited;
  LblVencimentoTransferencia.Text := '';
  If CbLoteTransferencia.ItemIndex < 0 then Exit;
  if CbLoteTransferencia.Items.Strings[CbLoteTransferencia.ItemIndex] <> '' then Begin
     If Not FdMemReposicaoTransferencia.Locate('IdProduto;Lote', VarArrayOf([EdtCodProdutoTransferencia.Tag, CbLoteTransferencia.Items.Strings[CbLoteTransferencia.ItemIndex]]), []) then Begin
        SetCampoDefault('CbLoteTransferencia');
        ShowErro('Lote inválido para transferência');
        CbLoteTransferencia.itemindex := -1;
        Exit;
     End;
     LblVencimentoTransferencia.Text := FdMemReposicaoTransferencia.FieldByName('Vencimento').AsString;
  End;
end;

procedure TFrmReposicaoReabastecer.CbLoteTransferenciaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then Begin
     Key := 0;
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
  End;
end;

procedure TFrmReposicaoReabastecer.ClearRegistroColeta;
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

procedure TFrmReposicaoReabastecer.ContrMovQtde;
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

procedure TFrmReposicaoReabastecer.FinalizarColeta;
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

procedure TFrmReposicaoReabastecer.FormCreate(Sender: TObject);
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
//Ativado para Piloto na Indiana
//  LblDisponivel.Visible := pVisualizarEstoqueDisponivel;
//  EdtDisponivel.Visible := pVisualizarEstoqueDisponivel;
  LblDisponivel.Visible := True;
  EdtDisponivel.Visible := True;
end;

procedure TFrmReposicaoReabastecer.GetColeta;
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
  if vUltimoEnderecoColetado = StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]) then begin
     EdtEndereco.Text := StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]);
     DelayEdSetFocus(EdtEan);
  End
  Else Begin
     EdtEndereco.Text := '';
     DelayEdSetFocus(EdtEndereco);
  End;
  vUltimoEnderecoColetado := StringReplace(FdMemReposicaoColeta.FieldByName('Endereco').AsString, '.', '', [rfReplaceAll]);
  EdtDisponivel.Text := FdMemReposicaoColeta.FieldByName('Disponivel').AsString;
  GetEstoqueColeta;
  LblEndereco.Text   := FdMemReposicaoColeta.FieldByName('Endereco').AsString;
  if FdMemReposicaoColeta.FieldByName('Reposicao').AsString <> '0' then
     EdtQtdApanhe.Text  := FdMemReposicaoColeta.FieldByName('Reposicao').AsString
  Else EdtQtdApanhe.Text := '';
  LblEnderecoColeta.Text := 'Endereço';
  LblProdutoColeta.Text  := 'Produto';
  If FdMemReposicaoColeta.FieldByName('bloqueioinventarioendereco').AsInteger = 1 then Begin
     EdtEndereco.FontColor := tAlphaColorRec.Red;
     LblEnderecoColeta.Text             := 'Endereço(Bloqueado)';
  End
  Else
     EdtEndereco.FontColor := tAlphaColorRec.black;
  If FdMemReposicaoColeta.FieldByName('BloqueioInventarioProduto').AsInteger = 1 then Begin
     EdtEan.FontColor := tAlphaColorRec.Red;
     LblProdutoColeta.Text         := 'Produto(Bloqueado)';
  End
  Else
     EdtEan.FontColor := tAlphaColorRec.black;
end;

procedure TFrmReposicaoReabastecer.GetEstoqueColeta;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueJson(FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger,
                      FdMemReposicaoColeta.FieldByName('LoteId').AsInteger,
                      FdMemReposicaoColeta.FieldByName('EnderecoId').AsInteger, 0, 1, 1,
                      'S', 'N', 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     EdtDisponivel.Text := '0'
  Else
     if JsonArrayRetorno.Items[0].GetValue<Integer>('qtdereserva') >= FdMemReposicaoColeta.FieldByName('Demanda').AsInteger then
        EdtDisponivel.Text   := IntToStr(JsonArrayRetorno.Items[0].GetValue<Integer>('qtde')+FdMemReposicaoColeta.FieldByName('Demanda').AsInteger)
     Else EdtDisponivel.Text := IntToStr(JsonArrayRetorno.Items[0].GetValue<Integer>('qtde')+JsonArrayRetorno.Items[0].GetValue<Integer>('qtdereserva'));
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmReposicaoReabastecer.GetListaLstCadastro;
begin
  inherited;
  GetListaReposicaoPendente;
end;

procedure TFrmReposicaoReabastecer.GetListaReposicaoPendente;
Var JsonArrayRetorno : TJsonArray;
    ObjReposicaoCtrl : TPedidoSaidaCtrl;
    vErro            : String;
    xReposicao       : Integer;
begin
  LstPrincipal.Items.Clear;
  Showloading;
  Try
    JsonArrayRetorno := ObjReposicaoCtrl.GetConsultaReposicao(0, 0, 0, 0, 1, 0);
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

procedure TFrmReposicaoReabastecer.GetLoteTransferencia;
Var xRecno     : Integer;
    vProdutoid : Integer;
begin
  xRecno     := FdMemReposicaoTransferencia.RecNo;
  vProdutoId := FdMemReposicaoTransferencia.FieldByName('IdProduto').Asinteger;
  CbLoteTransferencia.Items.Clear;
  while (Not FdMemReposicaoTransferencia.Eof) and (vProdutoId = FdMemReposicaoTransferencia.FieldByName('IdProduto').Asinteger) do Begin
    CbLoteTransferencia.Items.Add(FdMemReposicaoTransferencia.FieldByName('Lote').AsString);
    FdMemReposicaoTransferencia.Next;
  End;
  FdMemReposicaoTransferencia.RecNo := xRecno;
  PosicionaLstTransferenciaEstoque;
end;

procedure TFrmReposicaoReabastecer.GetProdutoTransferencia;
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
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     FDMemReposicaoTransferencia.LoadFromJSON(JsonArrayRetorno, False);
     MontaListaProdutoTransferencia;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmReposicaoReabastecer.LimpaListaColeta;
begin
  //LstInventario.Items.Clear;
end;

procedure TFrmReposicaoReabastecer.Limpar;
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
  EdtReposicaoId.Text        := '';
  EdtDtReposicao.Text        := '';
  EdtZona.Text               := '';;
  LblCircContagem.Text       := '';
  LblTitReposicao.Text       := '';
  LblProdutoColeta.Text      := 'Produto';
  LblEnderecoColeta.Text     := 'Endereço';
end;

procedure TFrmReposicaoReabastecer.LimparTransferencia;
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

procedure TFrmReposicaoReabastecer.LstPrincipalItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstPrincipal.Items[AItem.Index].Objects.FindDrawable('ReposicaoId'));
  EdtConteudoPesq.text := TxtItem.Text; //Txt.TagString;
//  EdtReposicaoId.Text       := TxtItem.Text; //Txt.TagString;
end;

procedure TFrmReposicaoReabastecer.MontaListaColeta;
begin

end;

procedure TFrmReposicaoReabastecer.MontaListaProdutoTransferencia;
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

procedure TFrmReposicaoReabastecer.OpenReposicao(pReposicaoId: Integer);
Var vErro   : String;
    pProcessoId      : Integer;
    vZonaId : Integer;
    xRetorno  : Integer;
    xBody     : Integer;
    vZonaNull : String;
    JsonArrayRetorno : TJsonArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
    pUsuarioIdInUse  : Integer;
    JsonArrayInUse : TJsonArray;
begin
  inherited;
  Limpar;
  Showloading;
  Try
    ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
    JsonArrayRetorno := ObjPedidoCtrl.GetConsultaReposicao(0, 0, pReposicaoId, 0, 0, 0);
    if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
       ShowErro('😢Erro: '+vErro);
       JsonArrayRetorno := Nil;
       ObjPedidoCtrl.Free;
       HideLoading;
       LimpaListaColeta;
       PgcPrincipal.ActiveTab := TabLista;
       Exit;
    End
    Else Begin
      if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[0].GetValue<Integer>('processoid') > 28 then Begin
         ShowErro('Coleta não permitida. Processo: '+JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').items[0].GetValue<String>('processo'));
         JsonArrayRetorno := Nil;
         ObjPedidoCtrl.Free;
         HideLoading;
         LimpaListaColeta;
         PgcPrincipal.ActiveTab := TabLista;
         Exit;
      End;
      pUsuarioIdInUse := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[0].GetValue<Integer>('usuarioidinuse', 0);
      if (pUsuarioIdInUse <> 0) and (pUsuarioIdInUse <> FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) Then Begin
         ShowErro('Reposição em uso por outro usuário: '+
                  JsonArrayRetorno.Items[0].GetValue<TJsonArray>('header').Items[0].GetValue<Integer>('usuarioidinuse', 0).ToString, 'apito');
         JsonArrayRetorno := Nil;
         ObjPedidoCtrl.Free;
         HideLoading;
         LimpaListaColeta;
         PgcPrincipal.ActiveTab := TabLista;
         Exit;
      End;
      EdtReposicaoId.Text := EdtConteudoPesq.Text;
//      if pUsuarioIdInUse = 0 then
//         JsonArrayInUse := ObjPedidoCtrl.ReposicaoRegistrarInUse(StrToIntDef(EdtReposicaoId.Text, 0), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId);
         //ReposicaoRegistrarInUse;
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
          Try
            FdMemReposicaoColeta.Append;
            FdMemReposicaoColeta.FieldByName('ReposicaoId').AsInteger    := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('reposicaoid');
            FdMemReposicaoColeta.FieldByName('ProdutoId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('produtoid');
            FdMemReposicaoColeta.FieldByName('CodProduto').AsInteger     := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('codproduto');
            FdMemReposicaoColeta.FieldByName('Descricao').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('descricao');
            FdMemReposicaoColeta.FieldByName('Embalagem').AsString       := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('embalagem');
            FdMemReposicaoColeta.FieldByName('FatorConversao').AsInteger := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('fatorconversao');
            if JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('pickingid', 0) = 0 then Begin
               FdMemReposicaoColeta.FieldByName('PickingId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('pickingid', 0);
               FdMemReposicaoColeta.FieldByName('Picking').AsString         := 'SEM PICKING';
            End
            Else begin
               FdMemReposicaoColeta.FieldByName('PickingId').AsInteger      := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('pickingid', 0);
               FdMemReposicaoColeta.FieldByName('Picking').AsString         := EnderecoMask(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('picking'),
                                                                                            JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('mascarapicking'), True);
            end;
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
            FdMemReposicaoColeta.FieldByName('BloqueioInventarioProduto').AsInteger  := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('bloqueioinventarioproduto', 0);
            FdMemReposicaoColeta.FieldByName('BloqueioInventarioEndereco').AsInteger := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<Integer>('bloqueioinventarioendereco', 0);
          Except
             raise Exception.Create('Erro no Produto = '+JsonArrayRetorno.Items[0].GetValue<TJsonArray>('body').Items[xBody].GetValue<TJsonObject>.GetValue<String>('codproduto'));
          End;
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
    HideLoading;
  Except On E: Exception do Begin
    HideLoading;
    JsonArrayRetorno := Nil;
    ObjPedidoCtrl.Free;
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

function TFrmReposicaoReabastecer.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin

end;

procedure TFrmReposicaoReabastecer.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if PgcPrincipal.ActiveTab = TabLista then Begin
     CbCampoPesq.Enabled := True;
     //GetListaReposicaoPendente;
     BtnArrowLeft.Action       := Nil; //ChgTabTransferencia;
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
     Exit;
     LblProcessoReposicao.Text := 'Transferência Picking';
     if Not (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposição - Transferência Picking')) then Begin
        ShowErro('Usuário não autorizado!');
        //BtnArrowLeft.Action    := ChgTabDet;
        PgcPrincipal.ActiveTab := TabLista;
     End
     else Begin
        GetProdutoTransferencia;
        DelayEdSetFocus(EdtCodProdutoTransferencia);
        BtnArrowLeft.Action       := ChgTabDet;
        BtnArrowRigth.Action      := ChgTabLista;
     End;
  End;
end;

procedure TFrmReposicaoReabastecer.PosicionaLstTransferenciaEstoque;
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

procedure TFrmReposicaoReabastecer.PositionAddress;
begin
  FdMemReposicaoColeta.First;
  While (FdMemReposicaoColeta.FieldByName('UsuarioId').AsInteger <> 0) And
        (Not FdMemReposicaoColeta.Eof) Do Begin
    FdMemReposicaoColeta.Next;
  End;
end;

Function TFrmReposicaoReabastecer.SalvaItemColetado : Boolean;
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

procedure TFrmReposicaoReabastecer.SalvarColeta;
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
  If SalvaItemColetado Then begin
     FdMemReposicaoColeta.Post;
     FdMemReposicaoColeta.Recno := xRecno;
     xRecno := FdMemReposicaoColeta.Recno;
     FdmemReposicaoColeta.Next;
     if FdMemReposicaoColeta.Eof then
        FinalizarColeta
     Else
        GetColeta;
  end
  Else begin
     FdMemReposicaoColeta.Cancel;
     FdMemReposicaoColeta.Recno := xRecno;
     xRecno := FdMemReposicaoColeta.Recno;
     EdtEndereco.Text  := '';
     EdtEan.Text       := '';
     EdtQtdApanhe.Text := '';
     DelayEdSetFocus(EdtEndereco);
  end;
end;

procedure TFrmReposicaoReabastecer.ReposicaoRegistrarInUse;
Var TH : TThread;
      ObjReposicaoCtrl    : TPedidoSaidaCtrl;
      JsonArrayRegistro : TJsonArray;
      vErro : String;
begin
  inherited;
  //Incluir controle de acesso
//  TH := TThread.CreateAnonymousThread(procedure
//  Var ObjPedidoCtrl    : TPedidoSaidaCtrl;
//      JsonArrayRetorno : TJsonArray;
//      vErro : String;
//  begin
    //ObjReposicaoCtrl    := TPedidoSaidaCtrl.Create;
    //JsonArrayRegistro :=
    ObjReposicaoCtrl.ReposicaoRegistrarInUse(StrToIntDef(EdtReposicaoId.Text, 0), FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId);
    //if JsonArrayRegistro.Items[0].TryGetValue('Erro', vErro) then Begin
    //   JsonArrayRegistro := Nil;
    //   ObjReposicaoCtrl.Free;
    //   raise Exception.Create('Não foi possível registrar o uso da reposição!');
    //End;
    //JsonArrayRegistro := Nil;
    //ObjReposicaoCtrl.Free;
//  end);
//  TH.OnTerminate := ThreadReposicaoRegistrarInUseTerminate;
//  TH.Start;
end;

function TFrmReposicaoReabastecer.ReposicaoTransferenciaPicking: Boolean;
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
//  JsonTransferecia.AddPair('terminal', NomeDoComputador);
//  JsonTransferecia.AddPair('dtentrada', DateToStr(Date()));
//  JsonTransferecia.AddPair('hrentrada', FdMemReposicaoTransferencia.FieldByName('hrColeta').AsString);
  JsonArrayRetorno := ObjReposicaoCtrl.ReposicaoTransferenciaPicking(JsonTransferecia);
  If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) Then Begin
     ShowErro('Erro: '+vErro);
     Result := False;
  End
  Else Begin
     Result := True;
  End;
  JsonTransferecia.Free;
end;

procedure TFrmReposicaoReabastecer.SalvarTransferencia;
begin
  if ReposicaoTransferenciaPicking then Begin
     if StrToIntDef(EdtqtdTransferencia.Text, 0) = FdMemReposicaoTransferencia.FieldByName('Qtde').AsInteger then Begin
       FdMemReposicaoTransferencia.Delete;
     End
     Else Begin
       FdMemReposicaoTransferencia.Edit;
       FdMemReposicaoTransferencia.FieldByName('Qtde').AsInteger := FdMemReposicaoTransferencia.FieldByName('Qtde').AsInteger - StrToIntDef(EdtQtdTransferencia.Text, 0);
       FdMemReposicaoTransferencia.Post;
     End;
     GetProdutoTransferencia;
     EdtCodProdutoTransferencia.Text := '';
     LimparTransferencia;
     EdtCodProdutoTransferencia.SetFocus;
  End
end;

procedure TFrmReposicaoReabastecer.ShowDados;
begin
  inherited;

end;

procedure TFrmReposicaoReabastecer.ThreadReposicaoRegistrarInUseTerminate(
  Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then begin
//     SetCampoDefault('CbRastroTipo');
     ShowErro('Não foi possível Registrar o uso da reposição. Volte a tela inicial e tente reabrir.'+Exception(TThread(sender).FatalException).Message, 'alerta');
     Exit;
  end;
end;

procedure TFrmReposicaoReabastecer.ThreadTerminatePTransf(Sender: TObject);
begin
   LstTransferenciaEstoque.EndUpdate;
   LblCircContagem.Text := FdMemReposicaoTransferencia.RecordCount.ToString();
end;

end.

