Unit uFrmInventario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Generics.Collections,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, uMyTabOrderClassHelper,
  FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, DataSet.Serialize,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB, System.JSON, REST.Json, Rest.Types,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, ksTypes, ksLoadingIndicator,
  FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Objects, FMX.Ani, FMX.ListBox,
  FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.ListView, U_MsgD,
  FMX.Layouts
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
  , InventarioCtrl
  , EnderecoCtrl
  , ProdutoCtrl, FMX.Memo, LoteCtrl, EstoqueCtrl;

type
  TInventarioTipo = (poNenhum, poGeografico, poPrioritario);

  TFrmInventario = class(TFrmBase)
    LstInventario: TListView;
    LblTitData: TLabel;
    LblTitTipo: TLabel;
    LblTitProcesso: TLabel;
    LytLabelInventario: TLayout;
    LblTituloProcessoInventario: TLabel;
    LblTituloInventarioId: TLabel;
    TabContagem: TTabItem;
    TabItemContagem: TTabItem;
    ChgTabEndereco: TChangeTabAction;
    LytListaEndereco: TLayout;
    RctTitListaEndereco: TRectangle;
    LblTitEndEndereco: TLabel;
    LstInventarioItens: TListView;
    LytTitListaEndereco: TLayout;
    RctTitEndConcluido: TRectangle;
    Label7: TLabel;
    RctTitEndEmContagem: TRectangle;
    Label8: TLabel;
    RctTitEndDivergente: TRectangle;
    Label9: TLabel;
    CircContagem: TCircle;
    LblCircContagem: TLabel;
    Label2: TLabel;
    EdtEndereco: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    LblProduto: TLabel;
    Label12: TLabel;
    EdtLote: TEdit;
    CbListaLote: TComboBox;
    EdtDtFabricacao: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EdtDtVencimento: TEdit;
    Label1: TLabel;
    LnEndereco: TLine;
    LnDtFabricacao: TLine;
    LnDtVencimento: TLine;
    LnLote: TLine;
    EdtProdutoId: TEdit;
    LnProdutoId: TLine;
    FDMemEndereco: TFDMemTable;
    FDMemEnderecoAtivo: TIntegerField;
    FDMemEnderecoEnderecoId: TIntegerField;
    FDMemEnderecoDescricao: TStringField;
    FDMemEnderecoEstrutura: TStringField;
    FDMemEnderecoMascara: TStringField;
    FDMemEnderecoZona: TStringField;
    LblTitEndEstrutura: TLabel;
    LblTitEndZona: TLabel;
    LblEstrutura: TLabel;
    LblZona: TLabel;
    SbSalvarContagem: TSpeedButton;
    PthSalvarContagem: TPath;
    FdMemLoteInventariado: TFDMemTable;
    FdMemLoteInventariadoItemId: TIntegerField;
    FdMemLoteInventariadoInventarioId: TIntegerField;
    FdMemLoteInventariadoEnderecoId: TIntegerField;
    FdMemLoteInventariadoEndereco: TStringField;
    FdMemLoteInventariadoProdutoId: TIntegerField;
    FdMemLoteInventariadoLoteId: TIntegerField;
    FdMemLoteInventariadoDescrLote: TStringField;
    FdMemLoteInventariadoEstoqueInicial: TIntegerField;
    FdMemLoteInventariadoContagemId: TIntegerField;
    FdMemLoteInventariadoStatus: TStringField;
    FdMemLoteInventariadoAutomatico: TIntegerField;
    FdMemLoteInventariadoFabricacao: TDateField;
    FdMemLoteInventariadoVencimento: TDateField;
    FdMemLoteInventariadoQuantidade: TIntegerField;
    Layout1: TLayout;
    RctTitleContagem: TRectangle;
    LblTitContItemid: TLabel;
    LblTitContCodErp: TLabel;
    LblTitContLote: TLabel;
    LstLoteInventariado: TListView;
    LblTitContVencimento: TLabel;
    LblTitContQuant: TLabel;
    ImgLstFdoWhite: TImage;
    FdMemLoteInventariadoCodProduto: TIntegerField;
    FDMemEnderecoStatus: TStringField;
    SbCancelarContagem: TSpeedButton;
    PthCancelarContagem: TPath;
    LblSaveContagem: TLabel;
    SbZerarEndereco: TSpeedButton;
    PthZerarEndereco: TPath;
    LblZerarEndereco: TLabel;
    DataSource1: TDataSource;
    FDMemProdutoDisponivel: TFDMemTable;
    FDMemProdutoDisponivelProdutoId: TIntegerField;
    FDMemProdutoDisponivelCodigoERP: TIntegerField;
    FDMemProdutoDisponivelDescricao: TStringField;
    FDMemProdutoDisponivelPicking: TStringField;
    FDMemProdutoDisponivelmascara: TStringField;
    FDMemProdutoDisponivelZona: TStringField;
    FDMemProdutoDisponivelSngpc: TIntegerField;
    TabProdutos: TTabItem;
    Label10: TLabel;
    LblEstruturaEndereco: TLabel;
    LblZonaEndereco: TLabel;
    EdtEnderecoProduto: TEdit;
    Line1: TLine;
    Label14: TLabel;
    EdtCodigoERP: TEdit;
    Line2: TLine;
    LblCodigoERP: TLabel;
    Label16: TLabel;
    EdtLoteProduto: TEdit;
    Line3: TLine;
    Label17: TLabel;
    CbListaLoteProduto: TComboBox;
    Label18: TLabel;
    EdtDtFabricacaoProduto: TEdit;
    Line4: TLine;
    EdtDtVencimentoProduto: TEdit;
    Line5: TLine;
    Label19: TLabel;
    Label20: TLabel;
    Layout2: TLayout;
    RctDetProduto: TRectangle;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    LstLoteProdutoInventariado: TListView;
    SbSalvarContagemProduto: TSpeedButton;
    PthSalvarContProd: TPath;
    LblSalvarContProd: TLabel;
    SbZerarProduto: TSpeedButton;
    PthZerarContProd: TPath;
    LblZerarContProd: TLabel;
    ChgTabProduto: TChangeTabAction;
    FDMemProdutoDisponivelStatus: TStringField;
    FdMemLoteInventariadoQtdContagem: TIntegerField;
    SbCancelarContagemProduto: TSpeedButton;
    PthCancelarContagemProduto: TPath;
    FDMemInventarioPendente: TFDMemTable;
    LblCancelarContagem: TLabel;
    FdMemLoteInventariadousuarioid: TIntegerField;
    LstItensProduto: TListView;
    LblCancelarContagemProduto: TLabel;
    ActConfirmarZerarNaoContado: TAction;
    ActCancelarZerarNaoContado: TAction;
    EdtQuant: TEdit;
    Line7: TLine;
    EdtQuantProduto: TEdit;
    Line6: TLine;
    ActCongelarEstoque: TAction;
    ActDesistirCongelarEstoque: TAction;
    TabSimplesContagem: TTabItem;
    Label11: TLabel;
    EdtEnderecoCS: TEdit;
    Line8: TLine;
    LblEstruturaCS: TLabel;
    LblZonaCS: TLabel;
    Label21: TLabel;
    EdtCodProdutoCS: TEdit;
    Line9: TLine;
    Label26: TLabel;
    EdtLoteCS: TEdit;
    Line10: TLine;
    Label27: TLabel;
    EdtFabricacaoCS: TEdit;
    Line11: TLine;
    Label28: TLabel;
    EdtVencimentoCS: TEdit;
    Line12: TLine;
    Label29: TLabel;
    EdtQuantCS: TEdit;
    Line13: TLine;
    BtnSalvarCS: TSpeedButton;
    PthBtnSalvarCS: TPath;
    LblBtnSalvarCS: TLabel;
    LytListViewCS: TLayout;
    Rectangle1: TRectangle;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    ListViewCS: TListView;
    LblProdutoCS: TLabel;
    BtnSimplesContagem: TSpeedButton;
    PthSimplesContagem: TPath;
    LblBtnSimplesContagem: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LstInventarioDeleteItem(Sender: TObject; AIndex: Integer);
    procedure LstInventarioItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure BtnSearchPesqClick(Sender: TObject);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure EdtEnderecoValidate(Sender: TObject; var Text: string);
    procedure CircContagemClick(Sender: TObject);
    procedure EdtProdutoIdValidate(Sender: TObject; var Text: string);
    procedure EdtDtFabricacaoTyping(Sender: TObject);
    procedure SbSalvarContagemClick(Sender: TObject);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtEnderecoTyping(Sender: TObject);
    procedure EdtProdutoIdTyping(Sender: TObject);
    procedure EdtEnderecoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtLoteValidate(Sender: TObject; var Text: string);
    procedure EdtLoteTyping(Sender: TObject);
    procedure EdtDtVencimentoExit(Sender: TObject);
    procedure SbCancelarContagemClick(Sender: TObject);
    procedure EdtProdutoIdKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure SbZerarEnderecoClick(Sender: TObject);
    procedure EdtEnderecoChangeTracking(Sender: TObject);
    procedure CbListaLoteChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtCodigoERPChangeTracking(Sender: TObject);
    procedure EdtDtFabricacaoProdutoExit(Sender: TObject);
    procedure EdtLoteProdutoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure BtnArrowLeftClick(Sender: TObject);
    procedure BtnArrowRigthClick(Sender: TObject);
    procedure LstInventarioDblClick(Sender: TObject);
    procedure LstInventarioItensItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LstLoteProdutoInventariadoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LstLoteInventariadoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LstItensProdutoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ActConfirmarZerarNaoContadoExecute(Sender: TObject);
    procedure EdtDtFabricacaoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtQuantValidate(Sender: TObject; var Text: string);
    procedure EdtQuantProdutoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure EdtQuantProdutoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure ActCongelarEstoqueExecute(Sender: TObject);
    procedure ActDesistirCongelarEstoqueExecute(Sender: TObject);
    procedure EdtConteudoPesqKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure EdtEnderecoCSChangeTracking(Sender: TObject);
    procedure EdtEnderecoCSValidate(Sender: TObject; var Text: string);
    procedure BtnSimplesContagemClick(Sender: TObject);
  private
    { Private declarations }
    ObjInventarioCtrl : TInventarioCtrl;
    InventarioTipo    : TInventarioTipo;
    vCodProduto : Integer;
    vProdutoPicking : integer;
    vCodigoProdutoDigitado : Integer;
    Procedure PositionField;
    Procedure MontaListaEndereco;
    Procedure MontaListaProduto;
    Procedure OpenInventario(pInventarioId : Integer);
    Procedure GetInventarioEndereco;
    Procedure GetInventarioProduto;
    Procedure CheckEndereco(Sender : TObject);
    Procedure GetLotes(pProdutoId : Integer);
    Function GetListaInventario : Boolean;
    Procedure CtrlDigitacao(pOnOff : Boolean);
    Function ValidarContagem : Boolean;
    Procedure BuscarInventarioInicial;
    procedure MontaListaLoteInventariado;
    Procedure MontaListaProdutoLoteInventariado;
    Procedure SalvarContagemLote;
    Procedure TabListaOnOff;
    Function ValidaLotePallet : Boolean;
    procedure SalvarContagemProdutoLote;
    Function contagemCompletaDoEndereco : Boolean;
    Procedure ConfirmarZerarNaoContados;
    procedure SalvarContagem;
    procedure OpenInventarioCongelarEstoque;
    Procedure GetDataInventario;
    Procedure GetLoteCS;
    Procedure SalvaSimplesContagem;
    Function ValidarFabricacaoVencimento(Sender : TObject) : Boolean;
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Procedure ShowDados; OverRide;
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
  end;

var
  FrmInventario: TFrmInventario;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, ProcessoCtrl;

procedure TFrmInventario.ActConfirmarZerarNaoContadoExecute(Sender: TObject);
begin
  inherited;
  SalvarContagem;
end;

procedure TFrmInventario.ActCongelarEstoqueExecute(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  //CongelarEstoque
  JsonArrayRetorno := ObjInventarioCtrl.CongelarEstoqueInicial(ObjInventarioCtrl.ObjInventario.inventarioid, ObjInventarioCtrl.ObjInventario.InventarioTipo);
  If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     SetCampoDefault('EdtConteudoPesq');
     ShowErro('Não foi possível congelar o Estoque do Inventário.');
  End
  Else
     GetDataInventario;
  JsonArrayRetorno := Nil;
end;

procedure TFrmInventario.ActDesistirCongelarEstoqueExecute(Sender: TObject);
begin
  inherited;
  PgcPrincipal.ActiveTab := TabLista;
  EdtConteudoPesq.Text := '';
  DelayEdSetFocus(EdtConteudoPesq);
end;

procedure TFrmInventario.AtivaCampoDefault;
begin
  inherited;
  If (CampoDefault = 'EdtConteudoPesq') then Begin
     EdtConteudoPesq.Text := '';
     DelayEdSetFocus(EdtConteudoPesq);
  End
  Else if (CampoDefault = 'EdtCodigERP') or (CampoDefault = 'EdtProdutoId') then Begin
     if PgcPrincipal.ActiveTab = TabProdutos then Begin
        EdtCodigoERP.Text := '';
        DelayEdSetFocus(EdtCodigoERP);
     End
     Else Begin
        EdtProdutoId.Text := '';
        DelayEdSetFocus(EdtProdutoId);
     End;
  End
  Else if CampoDefault = 'EdtDtFabricacao' then Begin
     if PgcPrincipal.ActiveTab = TabProdutos then Begin
        EdtDtFabricacaoProduto.ReadOnly := False;
        EdtDtFabricacaoProduto.Text := '';
        DelayEdSetFocus(EdtDtFabricacaoProduto);
     End
     Else Begin
        EdtDtFabricacao.ReadOnly := False;
        EdtDtFabricacao.Text := '';
        DelayEdSetFocus(EdtDtFabricacao);
     End;
  End
  Else if CampoDefault = 'EdtEndereco' then Begin
     if PgcPrincipal.ActiveTab = TabProdutos then Begin
        EdtEnderecoProduto.ReadOnly := False;
        EdtEnderecoProduto.Text := '';
        DelayEdSetFocus(EdtEnderecoProduto);
     End
     Else Begin
        EdtEndereco.ReadOnly := False;
        EdtEndereco.Text := '';
        DelayEdSetFocus(EdtEndereco);
     End;
  End
  Else if CampoDefault = 'EdtLote' then Begin
      if PgcPrincipal.ActiveTab = TabProdutos then Begin
         EdtLoteProduto.ReadOnly := False;
         EdtLoteProduto.Text := '';
         DelayEdSetFocus(EdtLoteProduto);
      End
      Else Begin
         EdtLote.ReadOnly := False;
         EdtLote.Text := '';
         DelayEdSetFocus(EdtLote);
      End;
  End
  Else if CampoDefault = 'EdtLoteProduto' then Begin
     EdtLoteProduto.ReadOnly := False;
     EdtLoteProduto.Text := '';
     DelayEdSetFocus(EdtLoteProduto);
  End
  Else If CampoDefault = 'EdtLoteCS' then Begin
    EdtLoteCS.Text := '';
    DelayEdSetFocus(EdtLoteCS);
  End
  Else if CampoDefault = 'EdtEnderecoProduto' then Begin
     EdtEnderecoProduto.ReadOnly := False;
     EdtEnderecoProduto.Text := '';
     DelayEdSetFocus(EdtEnderecoProduto);
  End
  Else if CampoDefault = 'EdtQuant' then Begin
     if PgcPrincipal.ActiveTab = TabProdutos then Begin
        EdtQuantProduto.ReadOnly := False;
        EdtQuantProduto.Text := '';
        DelayEdSetFocus(EdtQuantProduto);
     End
     Else Begin
        EdtQuant.ReadOnly := False;
        EdtQuant.Text := '';
        DelayEdSetFocus(EdtQuant);
     End;
  End
  Else if CampoDefault = 'EdtDtVencimento' then Begin
     if PgcPrincipal.ActiveTab = TabProdutos then Begin
        EdtDtVencimentoProduto.ReadOnly := False;
        EdtDtVencimentoProduto.Text := '';
        DelayEdSetFocus(EdtDtVencimentoProduto);
     End
     Else Begin
        EdtDtVencimento.ReadOnly := False;
        EdtDtVencimento.Text := '  /  /    ';
        DelayEdSetFocus(EdtDtVencimento);
     End;
  End
  Else If CampoDefault = 'EdtEnderecoCS' then Begin
    EdtEnderecoCS.Text := '';
    DelayEdSetFocus(EdtEnderecoCS);
  End
  Else If CampoDefault = 'EdtCodProdutoCS' then Begin
    EdtCodProdutoCS.Text := '';
    DelayEdSetFocus(EdtCodProdutoCS);
  End
  Else If CampoDefault = 'EdtFabricaoCS' then Begin
    EdtFabricacaoCS.Text := '';
    DelayEdSetFocus(EdtFabricacaoCS);
  End
  Else If CampoDefault = 'EdtVencimentoCS' then Begin
    EdtVencimentoCS.Text := '';
    DelayEdSetFocus(EdtVencimentoCS);
  End
  Else If CampoDefault = 'EdtQuantCS' then Begin
    EdtQuantCS.Text := '';
    DelayEdSetFocus(EdtQuantCS);
  End;
end;

procedure TFrmInventario.BtnArrowLeftClick(Sender: TObject);
begin
  inherited;
  if PgcPrincipal.ActiveTab = TabLista then
     GetListaInventario;
end;

procedure TFrmInventario.BtnArrowRigthClick(Sender: TObject);
begin
  inherited;
  if PgcPrincipal.ActiveTab = TabLista then
     GetListaInventario;
end;

procedure TFrmInventario.BtnSearchPesqClick(Sender: TObject);
begin
  inherited;
  if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
     OpenInventario(StrToIntDef(EdtConteudoPesq.Text, 0))
  Else DelayEdSetFocus(EdtConteudoPesq);
end;

procedure TFrmInventario.BtnSimplesContagemClick(Sender: TObject);
begin
  inherited;
  PgcPrincipal.ActiveTab := TabSimplesContagem;
  DelayEdSetFocus(EdtEnderecoCS);
end;

//Lotes Inventariado
procedure TFrmInventario.BuscarInventarioInicial;
Var JsonArrayLoteInventariado : TJsonArray;
    vErro : String;
    xLote : Integer;
begin
  Try
    if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then //Por Localizacao
       JsonArrayLoteInventariado := ObjInventarioCtrl.GetLoteInventariado(ObjInventarioCtrl.ObjInventario.InventarioId, EdtEndereco.Tag, 0, 0, 0)
    Else
       JsonArrayLoteInventariado := ObjInventarioCtrl.GetLoteInventariado(ObjInventarioCtrl.ObjInventario.InventarioId, 0, EdtCodigoERP.Tag, 0, 0);
    If FdMemLoteInventariado.Active then
       FdMemLoteInventariado.EmptyDataSet;
    FdMemLoteInventariado.Close;
    if Not JsonArrayLoteInventariado.Items[0].TryGetValue('Erro', vErro) then Begin
       FdMemLoteInventariado.LoadFromJSON(JsonArrayLoteInventariado, False);
       if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
          MontaListaLoteInventariado
       Else If ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
          FdMemLoteInventariado.IndexFieldNames := 'Endereco';
          MontaListaProdutoLoteInventariado;
       End;
    End
    else
       FdMemLoteInventariado.Open;
    JsonArrayLoteInventariado := Nil;
  Except On E: Exception do begin
    JsonArrayLoteInventariado := Nil;
    raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TFrmInventario.CbListaLoteChange(Sender: TObject);
begin
  inherited;
  if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     if CbListaLote.itemindex >= 0 then Begin
        EdtLote.Text := CbListaLote.Items[CbListaLote.ItemIndex];
        DelayEdSetFocus(EdtQuant);
     End;
  End
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
     if CbListaLoteProduto.itemindex >= 0 then Begin
        EdtLoteProduto.Text := CbListaLoteProduto.Items[CbListaLoteProduto.ItemIndex];
        DelayEdSetFocus(EdtQuantProduto);
     End;
  End;
end;

procedure TFrmInventario.CheckEndereco(Sender : TObject);
Var ObjEnderecoCtrl   : TEnderecoCtrl;
    JsonArrayEndereco : TJSonArray;
    vErro             : String;
begin
  ObjEnderecoCtrl   := TEnderecoCtrl.Create;
  JsonArrayEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, TEdit(Sender).Text, TEdit(Sender).Text, 'T', 99, 0, 0, 0);
  if JsonArrayEndereco.Items[0].TryGetValue('Erro', vErro) then Begin
     If Sender = EdtEndereco Then
        SetCampoDefault('EdtEndereco')
     Else If Sender = EdtEnderecoProduto Then
        SetCampoDefault('EdtEnderecoProduto')
     Else If Sender = EdtEnderecoCS Then
        SetCampoDefault('EdtEndereco');
     ShowErro(vErro);
     DelayEdSetFocus(TEdit(Sender));
     FreeAndNil(ObjEnderecoCtrl);
     Exit;
  End;
  if Sender = EdtEndereco then Begin
     EdtEndereco.Tag   := JsonArrayEndereco.Items[0].GetValue<Integer>('enderecoid');
     LblEstrutura.Text := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
     LblZona.Text      := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
     vProdutoPicking   := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid');
  End
  Else if Sender = EdtEnderecoProduto then Begin
     EdtEnderecoProduto.Tag    := JsonArrayEndereco.Items[0].GetValue<Integer>('enderecoid');
     LblEstruturaEndereco.Text := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
     LblZonaEndereco.Text      := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
  End
  Else if Sender = EdtEnderecoCS then Begin
     EdtEnderecoCS.Tag   := JsonArrayEndereco.Items[0].GetValue<Integer>('enderecoid');
     LblEstruturaCS.Text := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
     LblZonaCS.Text      := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
  End;
  if JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('pickingfixo') = 1 then Begin
     If Sender = EdtEnderecoCS then Begin
        EdtCodProdutoCS.Tag    := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid');
        vCodigoProdutoDigitado := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
     End
     Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
        EdtProdutoId.Tag       := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid');
        vCodigoProdutoDigitado := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
        End
     Else if ((ObjInventarioCtrl.ObjInventario.inventariotipo = 2) or (Sender=EdtEnderecoCS))and
             (JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('pickingfixo')=1) and
             (JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid')<>EdtCodigoERP.Tag) then Begin
        raise Exception.Create('Picking não vinculado ao produto em contagem!');
     End;
  End
  Else If ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
     EdtProdutoid.Tag := 0;
  ObjEnderecoCtrl.Free;
  If Sender = EdtEnderecoCS then Begin
     CtrlDigitacao(True);
     DelayEdSetFocus(EdtCodProdutoCS);
  End  
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     BuscarInventarioInicial;
     CtrlDigitacao(True);
     SbZerarEndereco.Visible := Not SbSalvarContagem.Visible;
     SbZerarEndereco.Position.X := SbSalvarContagem.Position.X;
     SbZerarEndereco.Position.Y := SbSalvarContagem.Position.Y;
     SbCancelarContagem.Visible := True;
     DelayEdSetFocus(EdtProdutoId);
  End
  Else If ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
{     BuscarInventarioInicial;
     CtrlDigitacao(True);
     SbZerarProduto.Visible := Not SbSalvarContagemProduto.Visible;
     SbZerarProduto.Position.X := SbSalvarContagemProduto.Position.X;
     SbZerarProduto.Position.Y := SbSalvarContagemProduto.Position.Y;
     SbCancelarContagemProduto.Visible := True;
}     DelayEdSetFocus(EdtLoteProduto);
  End;
end;

procedure TFrmInventario.CircContagemClick(Sender: TObject);
begin
  inherited;
  PgcPrincipal.ActiveTab := TabItemContagem;
end;

procedure TFrmInventario.ConfirmarZerarNaoContados;
begin
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Itens não contados';
  MsgD.Text       := 'Deseja Zerar os itens?';
  MsgD.ActionOk   := ActConfirmarZerarNaoContado;
  MsgD.ActionCancel := ActCancelarZerarNaoContado;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

procedure TFrmInventario.OpenInventarioCongelarEstoque;
begin
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Congelar Estoque para Contagem';
  MsgD.Text       := 'O estoque será congelado/bloqueado. Continuar?';
  MsgD.ActionOk   := ActCongelarEstoque;
  MsgD.ActionCancel := ActDesistirCongelarEstoque;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

function TFrmInventario.contagemCompletaDoEndereco: Boolean;
begin
  Result := True;
  FdMemLoteInventariado.Filter   := '(usuarioid is null and Status = '+#39+'C'+#39+')';
  FdMemLoteInventariado.Filtered := True;
  if Not FdMemLoteInventariado.IsEmpty then
     Result := False;
  FdMemLoteInventariado.Filter   := '';
  FdMemLoteInventariado.Filtered := False;
  Exit;
  FdMemLoteInventariado.First;
  while Not FdMemLoteInventariado.Eof do Begin
     if FdMemLoteInventariado.FieldByName('Status').AsString = 'I' then Begin
        Result := False;
        ShowErro('Conclua a contagem do Endereço.');
        Break;
     End;
     FdMemLoteInventariado.Next;
  End;
end;

procedure TFrmInventario.CtrlDigitacao(pOnOff : Boolean);
begin
  If PgcPrincipal.ActiveTab = TabSimplesContagem then Begin
     EdtEnderecoCS.Enabled      := Not pOnOff;
     TabListaOnOff;
     EdtCodProdutoCS.ReadOnly    := Not pOnOff;
     EdtLoteCs.ReadOnly         := Not pOnOff;
     EdtFabricacaoCS.ReadOnly := Not pOnOff;
     EdtVencimentoCS.ReadOnly := Not pOnOff;
     EdtQuantCS.ReadOnly        := Not pOnOff;
     if (EdtEnderecoCS.Enabled) then Begin
        SbSalvarContagem.Visible   := False;
        DelayEdSetFocus(EdtCodProdutoCS);
     End;
  End;
  if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     EdtEndereco.Enabled      := Not pOnOff;
     TabListaOnOff;
     EdtProdutoId.ReadOnly    := Not pOnOff;
     EdtLote.ReadOnly         := Not pOnOff;
     CbListaLote.Enabled      := pOnOff;
     EdtDtFabricacao.ReadOnly := Not pOnOff;
     EdtDtVencimento.ReadOnly := Not pOnOff;
     EdtQuant.ReadOnly        := Not pOnOff;
     if (EdtEndereco.Enabled) and (ObjInventarioCtrl.ObjInventario.inventarioid=1) then Begin
        SbSalvarContagem.Visible   := False;
        SbCancelarContagem.Visible := False;
        DelayEdSetFocus(EdtEndereco);
     End;
  End
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
     EdtCodigoERP.Enabled            := Not pOnOff;
     TabListaOnOff;
     EdtEnderecoProduto.ReadOnly     := Not pOnOff;
     EdtLoteProduto.ReadOnly         := Not pOnOff;
     CbListaLoteProduto.Enabled      := pOnOff;
     EdtDtFabricacaoProduto.ReadOnly := Not pOnOff;
     EdtDtVencimentoProduto.ReadOnly := Not pOnOff;
     EdtQuantProduto.ReadOnly        := Not pOnOff;
     if (EdtCodigoERP.Enabled) and (ObjInventarioCtrl.ObjInventario.inventarioid=2) then Begin
        SbSalvarContagemProduto.Visible   := False;
        SbCancelarContagemProduto.Visible := False;
        DelayEdSetFocus(EdtCodigoERP);
     End;
  End;
end;

procedure TFrmInventario.EdtEnderecoCSChangeTracking(Sender: TObject);
begin
  inherited;
  if Sender = EdtEndereco then Begin
     LblEstrutura.Text := '';
     LblZona.Text      := '';
  End
  Else Begin
     LblEstruturaEndereco.Text := '';
     LblZonaEndereco.Text      := '';
  End;
end;

procedure TFrmInventario.EdtEnderecoCSValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  CheckEndereco(Sender);
end;

procedure TFrmInventario.EdtCodigoERPChangeTracking(Sender: TObject);
begin
  inherited;
  EdtEnderecoProduto.Text     := '';
  LblCodigoERP.Text           := '';
  EdtLoteProduto.Text         := '';
  CbListaLoteProduto.Items.Clear;
  EdtDtFabricacaoProduto.Text := '';
  EdtDtVencimentoProduto.Text := '';
  EdtQuantProduto.Text        := '';
end;

procedure TFrmInventario.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  if (Sender=Edtcodigo) and (FrmeXactWMS.Brand_Collector = 'Zebra') then Begin
     If ((key = 0) and (IntToStr(ord(KeyChar))='0') ) then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
        {$if defined(Android)}
          i := TJIntent.JavaClass.init;
          i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
          i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
          TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
        {$Endif}
     end;
  End;
  case
     Key of vkReturn: Begin
       Key := 0;
       TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     End;
//    vkTab:
//      TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
  end;
end;

procedure TFrmInventario.EdtConteudoPesqKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  //inherited;
  if (Key = 13) and (EdtConteudoPesq.Text<>'') and
     ((CbCampoPesq.ItemIndex >= 0) or (Not CbCampoPesq.Visible))then
     BtnSearchPesqClick(EdtConteudoPesq);
end;

procedure TFrmInventario.EdtDtFabricacaoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  if (Sender=Edtcodigo) and (FrmeXactWMS.Brand_Collector = 'Zebra') then Begin
     If ((key = 0) and (IntToStr(ord(KeyChar))='0') ) then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
        {$if defined(Android)}
          i := TJIntent.JavaClass.init;
          i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
          i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
          TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
        {$Endif}
     end;
     Exit;
  End;
  case
     Key of vkReturn: Begin
       Key := 0;
       TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
       Exit;
     End;
  end;
  TThread.Queue(Nil,
    Procedure
    begin
      TEdit(Sender).Text := ApplyMask('##/##/####', TEdit(Sender).Text);
      TEdit(Sender).CaretPosition := TEdit(Sender).Text.Length;
    End);
end;

procedure TFrmInventario.EdtDtFabricacaoProdutoExit(Sender: TObject);
begin
  inherited;
  if (TEdit(Sender).Text = '') or (TEdit(Sender).Text = '  /  /    ') then Exit;
  If (not ValidarFabricacaoVencimento(Sender)) then exit;
  Try
  Except Begin
    TEdit(Sender).Text := '';
    If InventarioTipo = poGeografico then
       setCampoDefault('EdtDtFabricacao')
    Else
       SetCampoDefault('EdtDtFabricaoProduto');
    ShowErro('Data de Fabricação inválida');
    End;
  End;
  if StrToDate(TEdit(Sender).Text) > Date() then Begin
     If InventarioTipo = poGeografico then
        setCampoDefault('EdtDtFabricacao')
     Else
        SetCampoDefault('EdtDtFabricaoProduto');
     ShowErro('Data de Fabricação não pode ser maior que hoje!');
     DelayEdSetFocus(TEdit(Sender));
     Exit;
  End;
end;

procedure TFrmInventario.EdtDtFabricacaoTyping(Sender: TObject);
begin
  inherited;
  Exit;

  TThread.Queue(Nil,
    Procedure
    begin
      TEdit(Sender).Text := ApplyMask('##/##/####', TEdit(Sender).Text);
      TEdit(Sender).CaretPosition := TEdit(Sender).Text.Length;
    End);
end;

procedure TFrmInventario.EdtDtVencimentoExit(Sender: TObject);
begin
  inherited;
  if (TEdit(Sender).Text = '  /  /    ') or  (TEdit(Sender).Text = '') Then Exit;
  If (Not ValidarFabricacaoVencimento(Sender)) Then Exit;
  if (ObjInventarioCtrl.ObjInventario.inventariotipo = 1) and
     (StrToDate(EdtDtVencimento.Text)<=StrToDate(EdtDtFabricacao.Text)) then Begin
     If InventarioTipo = poGeografico then
        SetCampoDefault('EdtDtVencimento')
     Else
        SetCampoDefault('EdtVencimentoProduto');
     ShowErro('Validade inválida!'+#13+'Não pode ser inferior ou igual a fabricação.');
  End
  Else if (ObjInventarioCtrl.ObjInventario.inventariotipo = 2) and
     (StrToDate(EdtDtVencimentoProduto.Text)<=StrToDate(EdtDtFabricacaoProduto.Text)) then Begin
     If InventarioTipo = poGeografico then
        SetCampoDefault('EdtDtVencimento')
     Else
        SetCampoDefault('EdtVencimentoProduto');
     ShowErro('Validade inválida!'+#13+'Não pode ser inferior ou igual a fabricação.');
  End;
end;

procedure TFrmInventario.EdtEnderecoChangeTracking(Sender: TObject);
begin
  inherited;
  if Sender = EdtEndereco then Begin
     LblEstrutura.Text := '';
     LblZona.Text      := '';
  End
  Else Begin
     LblEstruturaEndereco.Text := '';
     LblZonaEndereco.Text      := '';
  End;
end;

procedure TFrmInventario.EdtEnderecoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
//  inherited;
//  if Key = vkReturn then
//     Key := 0;
end;

procedure TFrmInventario.EdtEnderecoTyping(Sender: TObject);
begin
  inherited;
  if Sender = EdtEndereco then Begin
     EdtEndereco.Tag      := 0;
     EdtProdutoId.Text    := '';
     EdtProdutoId.Tag     := 0;
     LblProduto.Text      := '';
     EdtLote.Text         := '';
     EdtLote.Tag          := 0;
     CbListaLote.Items.Clear;
     EdtDtFabricacao.Text := '';
     EdtDtVencimento.Text := '';
     EdtQuant.Text        := '';
  End
  Else if Sender = EdtEnderecoProduto then Begin
     LblCodigoERP.Text          := '';
     EdtLoteProduto.Text         := '';
     CbListaLoteProduto.Items.Clear;
     EdtDtFabricacaoProduto.Text := '';
     EdtDtVencimentoProduto.Text := '';
     EdtQuantProduto.Text        := '';
  End
  Else if Sender = EdtEnderecoCS then Begin
     EdtEnderecoCS.Tag    := 0;
     EdtCodProdutoCS.Text := '';
     EdtCodProdutoCS.Tag  := 0;
     LblProdutoCS.Text    := '';
     EdtLoteCS.Text       := '';
     EdtLoteCS.Tag        := 0;
     EdtFabricacaoCS.Text := '';
     EdtVencimentoCS.Text := '';
     EdtQuant.Text        := '';
  End;
end;

procedure TFrmInventario.EdtEnderecoValidate(Sender: TObject; var Text: string);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  if Text = '' then exit;
  vProdutoPicking := 0;
  if Inventariotipo = poGeografico then Begin
     FdMemEndereco.first;
     if Not FdMemEndereco.Locate('Descricao', EdtEndereco.Text, []) then Begin
        Text := '';
        SetCampoDefault('EdtEndereco');
        ShowErro('Endereço inválido para este inventário!');
        Exit;
     End
     Else If FdMemEndereco.FieldByName('Status').AsString = 'F' Then Begin
        Text := '';
        SetCampoDefault('EdtEndereco');
        ShowErro('Endereço já foi inventariado!');
        Exit;
     End;
  End;
  TabListaOnOff;
  CheckEndereco(TEdit(Sender));
  If Inventariotipo = poPrioritario Then
     GetLotes(EdtCodigoERP.Tag);
end;

procedure TFrmInventario.EdtLoteProdutoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (InventarioTipo = poPrioritario) and (EdtLoteProduto.Text<>'') then
     DelayEdSetFocus(EdtDtFabricacaoProduto);
end;

procedure TFrmInventario.EdtLoteTyping(Sender: TObject);
begin
  inherited;
  if (Sender = EdtLoteCS) And (EdtCodProdutoCS.Text = '') then begin
     SetCampoDefault('EdtCodProdutoCS');
     ShowErro('Informe o Produto!');
     DelayEdSetFocus(EdtCodProdutoCS);
  End
  Else if ((ObjInventarioCtrl.ObjInventario.InventarioTipo = 1) and (EdtProdutoId.Text = '')) then Begin
     SetCampoDefault('EdtLote');
     ShowErro('Informe o Produto!');
     DelayEdSetFocus(EdtProdutoId);
  End
  Else If ((ObjInventarioCtrl.ObjInventario.InventarioTipo = 2) and (EdtEnderecoProduto.Text = '')) then Begin
     SetCampoDefault('EdtEnderecoProduto');
     ShowErro('Informe o Endereço para contagem!');
     DelayEdSetFocus(EdtEnderecoProduto);
  End;
  If Sender = EdtCodProdutoCS Then Begin
     EdtFabricacaoCS.Text := '';
     EdtVencimentoCS.Text := '';
     EdtLoteCS.Tag := 0;
     EdtQuantCS.Text := '';  
  End
  Else if InventarioTipo = poGeografico then Begin
     EdtDtFabricacao.Text := '';
     EdtDtVencimento.Text := '';
     EdtLote.Tag := 0;
     EdtQuant.Text := '';
  End
  Else Begin
     EdtDtFabricacaoProduto.Text := '';
     EdtDtVencimentoProduto.Text := '';
     EdtLoteProduto.Tag := 0;
     EdtQuantProduto.Text := '';
  End;
end;

Procedure TFrmInventario.EdtLoteValidate(Sender: TObject; var Text: string);
Var JsonArrayProdutoLotes : TJsonArray;
    ObjProdutoCtrl        : TProdutoCtrl;
    vErro                 : String;
    vEndereco             : String;
begin
  If ((Sender = EdtLote) or (Sender=EdtLoteProduto) or (Sender=EdtLoteCS)) and (TEdit(Sender).Text<>'') then Begin
     if Not ValidarLote(TEdit(Sender).Text) then Begin
        If (Sender = EdtLote) Then
           SetCampoDefault('EdtLote')
        Else If (Sender=EdtLoteProduto) then
           SetCampoDefault('EdtLoteProduto')
        Else If (Sender = EdtLoteCS) then
           SetCampoDefault('EdtLoteCS');
        ShowErro('Erro: Lote Inválido!');
        Exit;
     End;
  End;
  inherited;
  if Text <> '' then Begin
     If Sender = EdtLoteCS then
        vEndereco := EdtEnderecoCS.Text
     Else if Inventariotipo = poGeografico then
        vEndereco := EdtEndereco.Text
     Else if Inventariotipo = poGeografico then
        vEndereco := EdtEnderecoProduto.Text;
     TEdit(Sender).Tag := 0;
     If (Not (TEdit(Sender) = EdtLoteCS)) then
        FdMemLoteInventariado.First;
     vErro := EdtProdutoId.Tag.ToString+'  Lt: '+TEdit(Sender).Text;
     If Sender = EdtLoteCS then
        GetLoteCS
     Else If FdMemLoteInventariado.Locate('ProdutoId; Endereco; DescrLote',  VarArrayOf([EdtProdutoId.Tag, vEndereco, TEdit(Sender).Text]), []) then begin
        If (FdMemLoteInventariado.FieldByName('Status').AsString = 'F') then Begin
           Text := '';
           setCampoDefault('EdtLote');
           ShowErro('Lote já inventariado.');
        End
        Else Begin
//          If Not ValidaLotePallet then Exit;
          if Inventariotipo = poGeografico then Begin
             EdtLote.tag :=  FdMemLoteInventariado.FieldByName('LoteId').AsInteger;
             EdtDtFabricacao.Text := FdMemLoteInventariado.FieldByName('Fabricacao').AsString;
             EdtDtVencimento.Text := FdMemLoteInventariado.FieldByName('Vencimento').AsString;
             DelayEdSetFocus(edtQuant);
          End
          Else if Inventariotipo = poPrioritario then Begin
             EdtDtFabricacaoProduto.Text := FdMemLoteInventariado.FieldByName('Fabricacao').AsString;
             EdtDtVencimentoProduto.Text := FdMemLoteInventariado.FieldByName('Vencimento').AsString;
             DelayEdSetFocus(EdtQuantProduto);
          End;
        End;
     end
     Else begin
        if ObjInventarioCtrl.ObjInventario.inventariotipo >= 1 then Begin //= 1 then Begin
           ObjProdutoCtrl := TProdutoCtrl.Create;
           if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
              JsonArrayProdutoLotes := ObjProdutoCtrl.GetProdutoLotes(EdtProdutoId.Tag, EdtLote.Text)
           Else JsonArrayProdutoLotes := ObjProdutoCtrl.GetProdutoLotes(EdtProdutoId.Tag, EdtLoteProduto.Text);
           if (JsonArrayProdutoLotes.Count = 0) or (JsonArrayProdutoLotes.Items[0].TryGetValue('Erro', vErro)) then Begin
              if Inventariotipo = poGeografico then
              EdtDtFabricacao.text := '';
              EdtDtVencimento.Text := '';
              DelayEdSetFocus(CbListaLote);
           End
           Else Begin
              if InventarioTipo = poGeografico then Begin
                 EdtLote.tag := JsonArrayProdutoLotes.Items[0].GetValue<Integer>('loteid');
                 EdtDtFabricacao.text := JsonArrayProdutoLotes.Items[0].GetValue<String>('fabricacao');
                 EdtDtVencimento.Text := JsonArrayProdutoLotes.Items[0].GetValue<String>('vencimento');
                 DelayEdSetFocus(CbListaLote);
              End
              Else Begin
                 EdtLoteProduto.tag := JsonArrayProdutoLotes.Items[0].GetValue<Integer>('loteid');
                 EdtDtFabricacaoProduto.text := JsonArrayProdutoLotes.Items[0].GetValue<String>('fabricacao');
                 EdtDtVencimentoProduto.Text := JsonArrayProdutoLotes.Items[0].GetValue<String>('vencimento');
                 DelayEdSetFocus(CbListaLoteProduto);
              End;
        End;
           ObjProdutoCtrl.Free;
        End
        Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
           EdtDtFabricacaoProduto.text := '';
           EdtDtVencimentoProduto.Text := '';
           DelayEdSetFocus(CbListaLoteProduto);
        End
     end;



     
{     if (((ObjInventarioCtrl.ObjInventario.InventarioTipo=1) and (UpperCase(LblEstrutura.Text)<>'PICKING')) or //(UpperCase(FdMemEndereco.FieldByName('Estrutura').AsString) <> 'PICKING') and
         ((ObjInventarioCtrl.ObjInventario.InventarioTipo=2) and (UpperCase(LblEstruturaEndereco.Text)<>'PICKING'))) And
         (Not ValidaLotePallet()) then Begin
        Text := '';
        if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
           DelayEdSetFocus(EdtLote)
        Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then
           DelayEdSetFocus(EdtLoteProduto);
        Exit;
     End
     Else Begin
        if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
           sleep(1) //DelayEdSetFocus(EdtDtFabricacao)
        Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then
           DelayEdSetFocus(EdtLoteProduto);
     End;
}  End;
end;

procedure TFrmInventario.EdtProdutoIdKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Key := 0;
  inherited;
end;

procedure TFrmInventario.EdtProdutoIdTyping(Sender: TObject);
begin
  inherited;
  If Sender = EdtEnderecoCS then begin
     LblProdutoCS.Text           := '';
     EdtLoteCS.Text         := '';
     EdtFabricacaoCS.Text := '';
     EdtVencimentoCS.Text := '';
     EdtQuantCS.Text        := '';  
  end
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     LblProduto.Text      := '';
     EdtProdutoId.Tag     := 0;
     EdtLote.Text         := '';
     EdtLote.Tag          := 0;
     CbListaLote.Items.Clear;
     EdtDtFabricacao.Text := '';
     EdtDtVencimento.Text := '';
     EdtQuant.Text        := '';
  End
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
     LblCodigoERP.Text           := '';
     EdtLoteProduto.Text         := '';
     CbListaLoteProduto.Items.Clear;
     EdtDtFabricacaoProduto.Text := '';
     EdtDtVencimentoProduto.Text := '';
     EdtQuantProduto.Text        := '';
  End;
end;

procedure TFrmInventario.EdtProdutoIdValidate(Sender: TObject;
  var Text: string);
Var ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayProduto : TJsonArray;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  inherited;
  if (Text = '') or (StrToInt64Def(Text, 0) <=0) then Exit;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  //Ver se rota ler Código de Barras
  JsonArrayProduto := ObjProdutoCtrl.GetCodigoERPJson(Text);
  if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then Begin
     SetCampoDefault('EdtCodigoERP');
     ShowErro(vErro);
     Text := '';
     DelayEdSetFocus(TEdit(Sender));
     JsonArrayProduto := Nil;
     ObjProdutoCtrl.DisposeOf;
     Exit;
  End;
  if (Sender = EdtCodProdutoCS) and (JsonArrayProduto.Items[0].GetValue<Integer>('codProduto') <> vCodigoProdutoDigitado) then Begin
     SetCampoDefault('EdtCodProdutoCS');
     ShowErro('Produto não pertence ao Picking Informado.');
     Text := '';
     JsonArrayProduto := Nil;
     FreeAndNil(ObjProdutoCtrl);
     Exit;
  End
  Else if (ObjInventarioCtrl.ObjInventario.inventariotipo = 1) Then Begin
     FdMemEndereco.First;
     if (FdMemEndereco.Locate('Descricao', EdtEndereco.Text, [])) and
        (UpperCase(FdMemEndereco.FieldByName('Estrutura').AsString)='PICKING') and
        (vProdutoPicking <> JsonArrayProduto.Items[0].GetValue<Integer>('idProduto')) then Begin
        SetCampoDefault('EdtProdutoId');
        ShowErro('Produto não está vinculado ao Picking em Contagem.');
        Text := '';
        JsonArrayProduto := Nil;
        ObjProdutoCtrl.DisposeOf;
        Exit;
     End;
  End
  Else if (ObjInventarioCtrl.ObjInventario.inventariotipo = 2) then Begin
     FDMemProdutoDisponivel.First;
     If (Not FDMemProdutoDisponivel.Locate('Produtoid', JsonArrayProduto.Items[0].GetValue<Integer>('idProduto'), [])) then Begin
        SetCampoDefault('EdtEndereco');
        ShowErro('Produto não pertence ao inventário em Contagem.');
        Text := '';
        JsonArrayProduto := Nil;
        ObjProdutoCtrl.DisposeOf;
        Exit;
     End;
  End;
  vCodProduto      := ObjProdutoCtrl.ObjProduto.CodProduto;
  If Sender = EdtCodProdutoCS then Begin
     LblProdutoCS.Text := JsonArrayProduto.Items[0].GetValue<String>('descricao');
     EdtCodProdutoCS.Tag := ObjProdutoCtrl.ObjProduto.IdProduto;
     EdtCodProdutoCS.Tag  := ObjProdutoCtrl.ObjProduto.IdProduto;
     DelayEdSetFocus(EdtLoteCS);
     CtrlDigitacao(True);
  End
  Else if (ObjInventarioCtrl.ObjInventario.inventariotipo = 1) then Begin
     EdtProdutoId.Tag := ObjProdutoCtrl.ObjProduto.IdProduto;
     GetLotes(ObjProdutoCtrl.ObjProduto.IdProduto);
     LblProduto.Text  := JsonArrayProduto.Items[0].GetValue<String>('descricao');
     EdtProdutoId.Tag := ObjProdutoCtrl.ObjProduto.IdProduto;
     EdtProdutoId.TagString := ObjProdutoCtrl.ObjProduto.CodProduto.ToString(); //Usado para Testa no Click do ListView
     DelayEdSetFocus(EdtLote);
  End
  Else If (ObjInventarioCtrl.ObjInventario.inventariotipo = 2) then Begin
     //FDMemProdutoDisponivel.Locate('Produtoid', JsonArrayProduto.Items[0].GetValue<Integer>('idProduto'), []);
     If FDMemProdutoDisponivel.FieldByName('Status').AsString = 'F' Then Begin
        Text := '';
        SetCampoDefault('EdtCodigoERP');
        ShowErro('Produto já foi inventariado!');
        JsonArrayProduto := Nil;
        ObjProdutoCtrl.DisposeOf;
        Exit;
     End;
     LblCodigoERP.Text := JsonArrayProduto.Items[0].GetValue<String>('descricao');
     EdtCodigoERP.Tag  := ObjProdutoCtrl.ObjProduto.IdProduto;
     EdtProdutoId.Tag  := ObjProdutoCtrl.ObjProduto.IdProduto;
     DelayEdSetFocus(EdtEnderecoProduto);
     Try
       BuscarInventarioInicial;
       CtrlDigitacao(True);
       SbZerarProduto.Visible := True;
       SbZerarProduto.Position.X := SbSalvarContagemProduto.Position.X;
       SbZerarProduto.Position.Y := SbSalvarContagemProduto.Position.Y;
       SbCancelarContagemProduto.Visible := True;
     Except On E: Exception do Begin
       SetCampoDefault('EdtCodigoERP');
       ShowErro('Erro: '+E.Message);
       EdtCodigoERP.Text := '';
       End;
     End;
  End;
  JsonArrayProduto := Nil;
  FreeAndNil(ObjProdutoCtrl);
end;

procedure TFrmInventario.EdtQuantProdutoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
//  inherited;
//  SoNumeros(KeyChar);
end;

procedure TFrmInventario.EdtQuantProdutoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
(*
  inherited;
  if (Sender=Edtcodigo) and (FrmeXactWMS.Brand_Collector = 'Zebra') then Begin
      If ((key = 0) and (IntToStr(ord(KeyChar))='0') ) then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
         {$if defined(Android)}
           i := TJIntent.JavaClass.init;
           i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
           i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
           TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
         {$Endif}
      end;
   End;
   if (Key = vkReturn) and ((StrToIntDef(TEdit(Sender).Text, 0)>0) or (TEdit(Sender).Text='0')) then Begin
      Key := 0;
      if (((ObjInventarioCtrl.ObjInventario.InventarioTipo=1) and (UpperCase(LblEstrutura.Text)<>'PICKING')) or //(UpperCase(FdMemEndereco.FieldByName('Estrutura').AsString) <> 'PICKING') and
          ((ObjInventarioCtrl.ObjInventario.InventarioTipo=2) and (UpperCase(LblEstruturaEndereco.Text)<>'PICKING'))) And
          (Not ValidaLotePallet()) then Exit;
      If ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
         SalvarContagemLote
      Else If ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then
         SalvarContagemProdutoLote;
   End;
*)
end;

procedure TFrmInventario.EdtQuantValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if StrToIntDef(TEdit(Sender).Text, 0) < 0 then Begin
     If Sender = EdtQuant then
        setCampoDefault('EdtQuant')
     Else If Sender = EdtQuantProduto then
        setCampoDefault('EdtQuantProduto')
     Else If Sender = EdtQuantCS then
        setCampoDefault('EdtQuantCS');
     Text := '';
     If Sender = EdtQuantCS then
        ShowErro('Quantidade inválida!')
     Else
        ShowErro('Quantidade inválida para inventariar');
  End;
  if PgcPrincipal.ActiveTab = tabDetalhes then Begin
     If NOt ValidarFabricacaoVencimento(EdtDtFabricacao) then Exit;
     If NOt ValidarFabricacaoVencimento(EdtDtVencimento) then Exit;
  End
  Else if PgcPrincipal.ActiveTab = TabProdutos then Begin
     If NOt ValidarFabricacaoVencimento(EdtDtFabricacaoProduto) then Exit;
     If NOt ValidarFabricacaoVencimento(EdtDtVencimentoProduto) then Exit;
  End;
  if Sender = EdtQuantCS then Begin
     If StrToIntDef(EdtQuantCS.Text, 0) <= 0 then Begin
        SetCampoDefault('EdtQuantCS');
        ShowErro('Quantidade inválida para lançar no estoque');
     End
     Else Begin
       //Validar Lote Diferente no Pallet
       SalvaSimplesContagem;
     End;
  End
  Else If ((StrToIntDef(TEdit(Sender).Text, 0)>0) or (TEdit(Sender).Text='0')) then Begin
     if (((ObjInventarioCtrl.ObjInventario.InventarioTipo=1) and (UpperCase(LblEstrutura.Text)<>'PICKING')) or
         ((ObjInventarioCtrl.ObjInventario.InventarioTipo=2) and (UpperCase(LblEstruturaEndereco.Text)<>'PICKING'))) And
         (Not ValidaLotePallet()) then Exit;
     If ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
        SalvarContagemLote;
        Text := '';
     End
     Else If ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then
        SalvarContagemProdutoLote;
  End;
end;

procedure TFrmInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ObjInventarioCtrl) then
     ObjInventarioCtrl.DisposeOf;  QryListaPadrao.Close;
  inherited;
  Frminventario := Nil;
end;

procedure TFrmInventario.FormCreate(Sender: TObject);
begin
  ObjInventarioCtrl    := TInventarioCtrl.Create;
  CircleStatus.Visible := False;
  LblAtivo.Visible     := False;
  inherited;
  PositionField;
  PgcPrincipal.ActiveTab     := TabLista;
  SbSalvarContagem.Visible   := False;
  SbCancelarContagem.Visible := False;
  BtnSimplesContagem.Visible := DebugHook <> 0;
  //GetListaLstCadastro;
end;

procedure TFrmInventario.FormShow(Sender: TObject);
begin
  inherited;
  If PgcPrincipal.ActiveTab = TabLista then
     CbCampoPesq.Enabled := True;
end;

procedure TFrmInventario.GetDataInventario;
begin
  if ObjInventarioCtrl.ObjInventario.InventarioTipo = 1 then Begin
     GetInventarioEndereco;
     PgcPrincipal.ActiveTab       := TabDetalhes;
     PgcPrincipal.Tabs[0].Visible := True;
     PgcPrincipal.Tabs[1].Visible := True;
     //PgcContagem.ActiveTab := TabContagem;
     EdtEndereco.ReadOnly         := False;
     DelayedSetFocus(EdtEndereco);
  End
  Else If ObjInventarioCtrl.ObjInventario.InventarioTipo = 2 then Begin
     GetInventarioProduto;
     PgcPrincipal.ActiveTab       := TabProdutos;
     PgcPrincipal.Tabs[0].Visible := True;
     PgcPrincipal.Tabs[4].Visible := True;
     //PgcContagem.ActiveTab := TabContagem;
     EdtCodigoERP.ReadOnly        := False;
     DelayedSetFocus(EdtCodigoERP);
     BtnArrowRigth.Action         := ChgTabProduto;
  End;
end;

procedure TFrmInventario.GetInventarioEndereco;
Var JsonArrayEndereco : TJsonArray;
    vErro : String;
    xEndereco : Integer;
begin
    JsonArrayEndereco := ObjInventarioCtrl.GetInventarioItens(ObjInventarioCtrl.ObjInventario.InventarioId, 0);
    if JsonArrayEndereco.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro('Não há endereços para contagem no inventário.'+#13+vErro);
       Exit;
    End;
    FdMemEndereco.Close;
    FdMemEndereco.CreateDataSet;
    FdMemEndereco.EmptyDataSet;
    For xEndereco := 0 to JsonArrayEndereco.Count - 1 do Begin
      FdMemEndereco.Append;
      FdMemEndereco.FieldByName('Ativo').AsInteger      := 0;
      FdMemEndereco.FieldByName('EnderecoId').AsInteger := JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('enderecoid');
      FdMemEndereco.FieldByName('Descricao').AsString   := JsonArrayEndereco.Items[xEndereco].GetValue<String>('endereco');
      FdMemEndereco.FieldByName('Estrutura').AsString   := JsonArrayEndereco.Items[xEndereco].GetValue<String>('estrutura');
      FdMemEndereco.FieldByName('Mascara').AsString     := JsonArrayEndereco.Items[xEndereco].GetValue<String>('mascara');
      FdMemEndereco.FieldByName('Zona').AsString        := JsonArrayEndereco.Items[xEndereco].GetValue<String>('zona');
      FdmemEndereco.FieldByName('Status').AsString      := JsonArrayEndereco.Items[xEndereco].GetValue<String>('status');
    End;
    If JsonArrayEndereco.Count > 0 then
       FdMemEndereco.Post;
    MontaListaEndereco;
end;

procedure TFrmInventario.GetInventarioProduto;
Var JsonArrayProduto : TJsonArray;
    vErro    : String;
    xProduto : Integer;
begin
  JsonArrayProduto  := ObjInventarioCtrl.GetInventarioItens(ObjInventarioCtrl.ObjInventario.InventarioId, 0);
  if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Não há endereços para contagem no inventário.'+#13+vErro);
     Exit;
  End;
  FDMemProdutoDisponivel.Close;
  FDMemProdutoDisponivel.CreateDataSet;
  FDMemProdutoDisponivel.EmptyDataSet;
  For xProduto := 0 to JsonArrayProduto.Count - 1 do Begin
    FDMemProdutoDisponivel.Append;
    //FdMemEndereco.FieldByName('Ativo').AsInteger      := 0;
    FDMemProdutoDisponivel.FieldByName('ProdutoId').AsInteger  := JsonArrayProduto.Items[xProduto].GetValue<Integer>('produtoid');
    FDMemProdutoDisponivel.FieldByName('CodigoERP').AsInteger  := JsonArrayProduto.Items[xProduto].GetValue<Integer>('codigoerp');
    FDMemProdutoDisponivel.FieldByName('Descricao').AsString   := JsonArrayProduto.Items[xProduto].GetValue<String>('produto');
    FDMemProdutoDisponivel.FieldByName('Picking').AsString     := JsonArrayProduto.Items[xProduto].GetValue<String>('picking');
    FDMemProdutoDisponivel.FieldByName('Mascara').AsString     := JsonArrayProduto.Items[xProduto].GetValue<String>('mascara');
    FDMemProdutoDisponivel.FieldByName('Zona').AsString        := JsonArrayProduto.Items[xProduto].GetValue<String>('zona');
    FDMemProdutoDisponivel.FieldByName('Sngpc').Asinteger      := JsonArrayProduto.Items[xProduto].GetValue<Integer>('sngpc');
    FDMemProdutoDisponivel.FieldByName('Status').AsString      := JsonArrayProduto.Items[xProduto].GetValue<String>('status');
  End;
  If JsonArrayProduto.Count > 0 then
     FDMemProdutoDisponivel.Post;
  MontaListaProduto;
end;

Function TFrmInventario.GetListaInventario : Boolean;
Var JsonArrayInventario : TJsonArray;
    vErro               : String;
    xInventario         : Integer;
begin
  Result := False;
  Showloading;
  if LstInventario.Items.Count > 0 then begin
     LstInventario.BeginUpdate;
     LstInventario.Items.Clear;
     LstInventario.EndUpdate;
  end;
  Try
    JsonArrayInventario := ObjInventarioCtrl.GetPendente;
    if JsonArrayInventario.Items[0].TryGetValue('Erro', vErro) then
       ShowErro(vErro)
    Else Begin
       Result := JsonArrayInventario.Count >= 1;
       If FdMemInventarioPendente.Active then
          FdMemInventarioPendente.EmptyDataSet;
       FdMemInventarioPendente.Close;
       FdMemInventarioPendente.LoadFromJSON(JsonArrayInventario, False);
       LstInventario.BeginUpdate;
       LstInventario.Items.Clear;
       If JsonArrayInventario.Count >= 1 then Begin
          For xInventario := 0 to Pred(JsonArrayInventario.Count) do Begin
            With LstInventario.Items.Add do Begin
              TListItemText(Objects.FindDrawable('InventarioId')).Text := JsonArrayInventario.Items[xInventario].GetValue<Integer>('inventarioid').ToString;
              TListItemText(Objects.FindDrawable('DataCriacao')).Text  := JsonArrayInventario.Items[xInventario].GetValue<String>('datacriacao');
              TListItemText(Objects.FindDrawable('Tipo')).Text         := JsonArrayInventario.Items[xInventario].GetValue<String>('tipo');
              TListItemText(Objects.FindDrawable('Processo')).Text     := JsonArrayInventario.Items[xInventario].GetValue<String>('processo');
            End;
          End;
       End;
       LstInventario.EndUpdate;
    End;
  Except On E: Exception do
    ShowErro('Erro: '+E.Message);
  End;
  JsonArrayInventario := Nil;
  HideLoading;
end;

procedure TFrmInventario.GetListaLstCadastro;
begin
  inherited;
  GetListaInventario;
end;

procedure TFrmInventario.GetLoteCS;
Var ObjLoteCtrl : TLoteCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
   ObjLoteCtrl := TLoteCtrl.Create;
   JsonArrayRetorno := ObjLoteCtrl.GetProdutoLoteJson(EdtCodProdutoCS.Tag, EdtLote.Text, 0);
   If Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin   
      EdtLoteCS.tag        := JsonArrayRetorno.Items[0].GetValue<Integer>('loteid');
      EdtFabricacaoCS.Text := JsonArrayRetorno.Items[0].GetValue<string>('fabricacao');
      EdtVencimentoCS.Text := JsonArrayRetorno.Items[0].GetValue<string>('vencimento');
      DelayEdSetFocus(edtQuantCS);
   End
   Else 
      DelayEdSetFocus(EdtFabricacaoCS);
end;

procedure TFrmInventario.GetLotes(pProdutoId : Integer);
begin
  if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     CbListaLote.Items.Clear;
     FdMemLoteInventariado.Filter   := 'EnderecoId = '+EdtEndereco.Tag.ToString()+' and ProdutoId = '+EdtProdutoId.Tag.ToString();
     FdMemLoteInventariado.Filtered := True;
     if Not FdMemLoteInventariado.IsEmpty then Begin
        FdMemLoteInventariado.First;
        while Not FdMemLoteInventariado.Eof do Begin
          CbListaLote.Items.Add(FdMemLoteInventariado.FieldByName('descrlote').AsString);
          FdMemLoteInventariado.Next;
        End;
     End;
  End
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
     CbListaLoteProduto.Items.Clear;
     FdMemLoteInventariado.Filter   := 'EnderecoId = '+EdtEnderecoProduto.Tag.ToString()+' and ProdutoId = '+EdtCodigoERP.Tag.ToString();
     FdMemLoteInventariado.Filtered := True;
     if Not FdMemLoteInventariado.IsEmpty then Begin
        FdMemLoteInventariado.First;
        while Not FdMemLoteInventariado.Eof do Begin
          CbListaLoteProduto.Items.Add(FdMemLoteInventariado.FieldByName('descrlote').AsString);
          FdMemLoteInventariado.Next;
        End;
     End;
  End;
  FdMemLoteInventariado.Filter   := '';
  FdMemLoteInventariado.Filtered := True;
end;

procedure TFrmInventario.Limpar;
begin
  inherited;
  //EdtEndereco.Text     := '';
  if ObjInventarioCtrl.ObjInventario.inventarioid = 1 then Begin
     EdtProdutoId.Text    := '';
     EdtLote.Text         := '';
     CbListaLote.Items.clear;
     EdtDtFabricacao.Text := '';
     EdtDtVencimento.Text := '';
     EdtQuant.Text        := '';
     LblEstrutura.Text    := '';
     LblZona.Text         := '';
  End
  Else if ObjInventarioCtrl.ObjInventario.inventarioid = 1 then Begin
     EdtEnderecoProduto.Text     := '';
     EdtLoteProduto.Text         := '';
     CbListaLoteProduto.Items.clear;
     EdtDtFabricacaoProduto.Text := '';
     EdtDtVencimentoProduto.Text := '';
     EdtQuantProduto.Text        := '';
     LblZonaEndereco.Text      := '';
     LblEstruturaEndereco.Text := '';
  End;
  if Assigned(ObjInventarioCtrl.ObjInventario) then
     ObjInventarioCtrl.ObjInventario.Limpar;
  If FdMemInventarioPendente.Active then
     FdMemInventarioPendente.EmptyDataSet;
  FdMemInventarioPendente.Close;
  If FdMemEndereco.Active then
     FdMemEndereco.EmptyDataSet;
  FdMemEndereco.Close;
  If FdMemProdutoDisponivel.Active then
     FdMemProdutoDisponivel.EmptyDataSet;
  FdMemProdutoDisponivel.Close;
  LstInventario.Items.Clear;
  LstLoteInventariado.Items.Clear;
  LstLoteProdutoInventariado.Items.Clear;
  CtrlDigitacao(False);
  //BtnArrowLeft.Enabled := True;
end;

procedure TFrmInventario.LstInventarioDblClick(Sender: TObject);
//Var TxtItem : TListItemText;
begin
  inherited;
  //TxtItem := TListItemText(LstInventario.Items[AItem.Index].Objects.FindDrawable('InventarioId'));
//  EdtConteudoPesq.text := LstInventario.Selected.SubItems.Strings[0] TxtItem.Text; //Txt.TagString;
  BtnSearchPesqClick(Sender);
end;

procedure TFrmInventario.LstInventarioDeleteItem(Sender: TObject;
  AIndex: Integer);
Var txt : TListItemText;
begin
  inherited;
{  txt := TListItemText(LstInventario.Items[AIndex].Objects.FindDrawable('InventarioId'));
//  if txt.TagString <> '111' then
  EdtCodInventario.Text := txt.tagstring;
  ACanDelete := false;
  BtnOkInventarioClick(BtnOkInventario);
}end;


//https://stackoverflow.com/questions/39099708/detect-where-listviewitem-has-been-clicked-pressed
procedure TFrmInventario.LstInventarioItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstInventario.Items[AItem.Index].Objects.FindDrawable('InventarioId'));
  EdtConteudoPesq.text := TxtItem.Text; //Txt.TagString;
end;

procedure TFrmInventario.LstInventarioItensItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstInventarioItens.Items[AItem.Index].Objects.FindDrawable('LEndereco'));
  PgcPrincipal.ActiveTab := TabDetalhes;
  if EdtEndereco.Text = '' then
     EdtEndereco.Text := StringReplace( TxtItem.Text, '.', '', [rfReplaceAll]);
end;

procedure TFrmInventario.LstItensProdutoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstItensProduto.Items[AItem.Index].Objects.FindDrawable('CodProduto'));
  if InventarioTipo = poGeografico then Begin
     PgcPrincipal.ActiveTab := TabDetalhes;
     If EdtProdutoId.Text = '' then
        EdtProdutoId.Text := TxtItem.Text;
  End
  Else if InventarioTipo = poPrioritario then Begin
     PgcPrincipal.ActiveTab := TabProdutos;
     If EdtCodigoERP.Text = '' then
        EdtCodigoERP.Text := TxtItem.Text;
  End;
end;

procedure TFrmInventario.LstLoteInventariadoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
    Teste : String;
begin
  inherited;
  if (EdtProdutoId.Text = '') then Begin
     TxtItem := TListItemText(LstLoteInventariado.Items[AItem.Index].Objects.FindDrawable('LInvCodErp'));
     EdtProdutoId.Text := TxtItem.Text;
  End
  Else if (EdtProdutoId.Text <> '') then Begin
     TxtItem := TListItemText(LstLoteInventariado.Items[AItem.Index].Objects.FindDrawable('LInvLote'));
     If (EdtProdutoId.TagString = TListItemText(LstLoteInventariado.Items[AItem.Index].Objects.FindDrawable('LInvCodErp')).Text) Then
        EdtLote.Text := TxtItem.Text;
  End;
end;

procedure TFrmInventario.LstLoteProdutoInventariadoItemClick(
  const Sender: TObject; const AItem: TListViewItem);
Var TxtItem : TListItemText;
Var xCount  : Integer;
begin
  inherited;
  xCount := LstLoteProdutoInventariado.Items.Count;
  if xCount > 0 then Begin
     If (EdtEnderecoProduto.Text='') then
        EdtEnderecoProduto.text := TListItemText(LstLoteProdutoInventariado.Items[AItem.Index].Objects.FindDrawable('LInvEndereco')).Text
     Else
        EdtLoteProduto.Text   := TListItemText(LstLoteProdutoInventariado.Items[AItem.Index].Objects.FindDrawable('LInvLote')).Text;
  End;
end;

procedure TFrmInventario.MontaListaEndereco;
Var item : TListViewItem;
    txt : TListItemText;
    img : TListItemImage;
    Cor : Cardinal;
    vEnderecoPendente : Integer;
begin
  LblTitEndZona.Visible      := False;
  LstInventarioItens.Visible := True;
  LstItensProduto.Visible    := False;
  FdMemEndereco.First;
  LstInventarioItens.BeginUpdate;
  LstInventarioItens.Items.Clear;
  vEnderecoPendente := 0;
  While Not FdMemEndereco.Eof do Begin
    item := LstInventarioItens.Items.Add;
    item.Objects.Clear;
//     item.Text := FdMemEndereco.FieldByName('Descricao').AsString;
    item.TagString := FdMemEndereco.FieldByName('Descricao').AsString;
    with item do begin
      // Status do Endereço...
      img := TListItemImage(Objects.FindDrawable('ImgFdoListaEndereco'));
      img.PlaceOffset.X := 0;
      img.PlaceOffset.Y := 0;
      img.Width  := 390;
      img.Height := 30;
      img.ScalingMode := TImageScalingMode.Stretch;
      If FdMemEndereco.FieldByName('Status').AsString = 'I' then Begin
         img.Bitmap := ImgLstFdoWhite.Bitmap;
         Cor:= $FF5DA9BC;
      End
      Else if FdMemEndereco.FieldByName('Status').AsString = 'C' then Begin
         img.Bitmap := ImgLstFdoyellow.Bitmap;
         Cor:= $FFE9C168;
      End
      Else if FdMemEndereco.FieldByName('Status').AsString = 'F' then Begin
          img.Bitmap := ImgLstFdoGreen.BitMap;
          Cor:= $FF32B932;
      end;
      // Endereço...
      txt := TListItemText(Objects.FindDrawable('LEndereco'));
      txt.Text := EnderecoMask(FdMemEndereco.FieldByName('Descricao').AsString, FdMemEndereco.FieldByName('Mascara').AsString, True);
      txt.Font.Size := 16;
      txt.Height := 20;
      txt.Width  := 95;
      //txt.Font.Style := [TFontStyle.fsBold];
      txt.PlaceOffset.X := 2;
      txt.PlaceOffset.Y := 2;
      txt.TagString     := FdMemEndereco.FieldByName('Descricao').AsString;
      //Txt.TextColor := TAlphaColorRec.Green;

      //Estrutura
      // Setor...
      txt := TListItemText(Objects.FindDrawable('LEstrutura'));
      txt.Text := FdMemEndereco.FieldByName('Estrutura').AsString;
      txt.Font.Size := 16;
      txt.Height    := 20;
      Txt.Width     := 100;
      //txt.Font.Style := [TFontStyle.fsBold];
      txt.PlaceOffset.X := 103;
      txt.PlaceOffset.Y := 2;
      txt.TagString     := FdMemEndereco.FieldByName('Estrutura').AsString;

      // Setor...
      txt := TListItemText(Objects.FindDrawable('LZona'));
      txt.Text := FdMemEndereco.FieldByName('Zona').AsString;
      txt.Font.Size := 16;
      txt.Height := 20;
      Txt.Width  := 120;
      //txt.Font.Style := [TFontStyle.fsBold];
      txt.PlaceOffset.X := 208;
      txt.PlaceOffset.Y := 2;
      txt.TagString     := FdMemEndereco.FieldByName('Zona').AsString;

      {// Data do Inventário...
      txt := TListItemText(Objects.FindDrawable('Text4'));
      txt.Text := QryEndereco.FieldByName('Status').AsString;
      txt.Font.Size := 16;
      txt.Height := 21;
      Txt.Width  := 50;
      //txt.Font.Style := [TFontStyle.fsBold];
      txt.PlaceOffset.X := 340;
      txt.PlaceOffset.Y := 1;
      txt.TagString     := QryEndereco.FieldByName('Status').AsString; }
    end;
    if FdMemEndereco.FieldByName('Status').AsString <> 'F' then
       Inc(vEnderecoPendente);
    FdMemEndereco.Next;
  End;
  LstInventarioItens.EndUpdate;
  LblCircContagem.Text := vEnderecoPendente.ToString;
end;

procedure TFrmInventario.MontaListaLoteInventariado;
Var item : TListViewItem;
    txt : TListItemText;
    img : TListItemImage;
    Cor : Cardinal;
begin
  //FdMemLoteInventariado.Filter   := 'EnderecoId = '+EdtEndereco.Tag.ToString();
  //FdMemLoteInventariado.Filtered := True;
  FdMemLoteInventariado.First;
  //Incluindo em 13/05
  FdMemLoteInventariado.Filter := 'Status <> '+#39+'I'+#39;
  FdMemLoteInventariado.Filtered := True;

  LstLoteInventariado.BeginUpdate;
  LstLoteInventariado.Items.Clear;
  While Not FdMemLoteInventariado.Eof do Begin
    if (FdMemLoteInventariado.FieldByName('Status').AsString <> 'F1') then Begin
       item := LstLoteInventariado.Items.Add;
       item.Objects.Clear;
       item.TagString := FdMemLoteInventariado.FieldByName('ItemId').AsString;
       with item do begin
         // Status do Endereço...
         img := TListItemImage(Objects.FindDrawable('ImgFdoLoteInventariado'));
         img.PlaceOffset.X := 0;
         img.PlaceOffset.Y := 0;
         img.Width := 390;
         img.Height := 25;
         img.ScalingMode := TImageScalingMode.Stretch;
         If (FdMemLoteInventariado.FieldByName('Quantidade').AsString = '') and
            (FdMemLoteInventariado.FieldByName('Status').AsString <> 'F') then begin
            //FdMemLoteInventariado.FieldByName('Status').AsString = 'I' Then begin       //Inicializado
            img.Bitmap := ImgLstFdoWhite.Bitmap;
            Cor:= $FF5DA9BC;
         End
         Else If (FdMemLoteInventariado.FieldByName('Status').AsString = 'C') or
                 (FdMemLoteInventariado.FieldByName('Quantidade').AsString <> '') Then Begin  //Em Contagem
            img.Bitmap := ImgLstFdoYellow.Bitmap;
            Cor:= $FFE9C168;
         End
         Else If FdMemLoteInventariado.FieldByName('Status').AsString = 'F' then Begin  //Concluído/Finalizado
            img.Bitmap := ImgLstFdoGreen.BitMap;
            Cor:= $FF32B932;
         end;
         // Endereço...
         txt := TListItemText(Objects.FindDrawable('LInvItem'));
         txt.Text := FdMemLoteInventariado.FieldByName('ItemId').AsString;
         txt.Font.Size := 14;
         txt.Height := 21;
         txt.Width  := 30;
         //txt.Font.Style := [TFontStyle.fsBold];
         txt.PlaceOffset.X := 2;
         txt.PlaceOffset.Y := 2;
         txt.TagString     := FdMemLoteInventariado.FieldByName('ItemId').AsString;
         //Txt.TextColor := TAlphaColorRec.Green;

         //Estrutura
         // Setor...
         txt := TListItemText(Objects.FindDrawable('LInvCodErp'));
         txt.Text := FdMemLoteInventariado.FieldByName('CodProduto').AsString;
         txt.Font.Size := 14;
         txt.Height    := 21;
         Txt.Width     := 48;
         //txt.Font.Style := [TFontStyle.fsBold];
         txt.PlaceOffset.X := 45;
         txt.PlaceOffset.Y := 2;
         txt.TagString     := FdMemLoteInventariado.FieldByName('CodProduto').AsString;

         // Setor...
         txt := TListItemText(Objects.FindDrawable('LInvLote'));
         txt.Text := FdMemLoteInventariado.FieldByName('DescrLote').AsString;
         txt.Font.Size := 14;
         txt.Height := 21;
         Txt.Width  := 115;
         //txt.Font.Style := [TFontStyle.fsBold];
         txt.PlaceOffset.X := 96;
         txt.PlaceOffset.Y := 2;
         txt.TagString     := FdMemLoteInventariado.FieldByName('DescrLote').AsString;

         txt := TListItemText(Objects.FindDrawable('LInvVencimento'));
         txt.Text := Copy(FdMemLoteInventariado.FieldByName('Vencimento').AsString, 1, 6)+
                     Copy(FdMemLoteInventariado.FieldByName('Vencimento').AsString, 9, 2) ;
         txt.Font.Size := 14;
         txt.Height := 21;
         Txt.Width  := 90;
         //txt.Font.Style := [TFontStyle.fsBold];
         txt.PlaceOffset.X := 205;
         txt.PlaceOffset.Y := 2;

         txt := TListItemText(Objects.FindDrawable('LInvQuant'));
         txt.Text := FdMemLoteInventariado.FieldByName('Quantidade').AsString;
         txt.Font.Size := 14;
         txt.Height := 21;
         Txt.Width  := 40;
         //txt.Font.Style := [TFontStyle.fsBold];
         txt.PlaceOffset.X := 289;
         txt.PlaceOffset.Y := 2;
       end;
    End;
    FdMemLoteInventariado.Next;
  End;
  LstLoteInventariado.EndUpdate;

  FdMemLoteInventariado.Filter   := '';
  FdMemLoteInventariado.Filtered := False;
end;

procedure TFrmInventario.MontaListaProduto;
Var item : TListViewItem;
    txt : TListItemText;
    img : TListItemImage;
    Cor : Cardinal;
    vEnderecoPendente : Integer;
begin
  LstInventarioItens.visible := False;
  LstItensProduto.Visible    := True;
  LblTitEndEndereco.Text  := 'Código';
  LblTitEndEstrutura.Text := 'Descrição';
  LblTitEndZona.Text      := '';
  FDMemProdutoDisponivel.First;
  LstItensProduto.BeginUpdate;
  LstItensProduto.Items.Clear;
  vEnderecoPendente := 0;
  While Not FDMemProdutoDisponivel.Eof do Begin
    //if FDMemProdutoDisponivel.FieldByName('Status').AsString <> 'F' then Begin
       item := LstItensProduto.Items.Add;
       item.Objects.Clear;
   //     item.Text := FdMemEndereco.FieldByName('Descricao').AsString;
       item.TagString := FDMemProdutoDisponivel.FieldByName('CodigoERP').AsString;
       with item do begin
         // Status do Endereço...
         Height := 35;
         img := TListItemImage(Objects.FindDrawable('ImgFdoListaProduto'));
         img.PlaceOffset.X := 0;
         img.PlaceOffset.Y := 0;
         img.Width  := 390;
         img.Height := 20;
     //    img.ScalingMode := TImageScalingMode.Original;// Stretch;
         If FDMemProdutoDisponivel.FieldByName('Status').AsString = 'I' then Begin
            img.Bitmap := ImgLstFdoWhite.Bitmap;
            Cor:= $FF5DA9BC;
         End
         Else if FDMemProdutoDisponivel.FieldByName('Status').AsString = 'C' then Begin
            img.Bitmap := ImgLstFdoyellow.Bitmap;
            Cor:= $FFE9C168;
         End
         Else if FDMemProdutoDisponivel.FieldByName('Status').AsString = 'F' then Begin
             img.Bitmap := ImgLstFdoGreen.BitMap;
             Cor:= $FF32B932;
         end;
         // CodProduto...
         txt := TListItemText(Objects.FindDrawable('CodProduto'));
         txt.Text := EnderecoMask(FDMemProdutoDisponivel.FieldByName('CodigoERP').AsString,
                                  FdMemEndereco.FieldByName('Mascara').AsString, True);
         //txt.Height := 20;
         //txt.Width  := 95;
         txt.Font.Size := 14;
         //Txt.TextVertAlign := TTextAlign.Leading;
         txt.Font.Style := [TFontStyle.fsBold];
         //txt.PlaceOffset.X := 2;
         //txt.PlaceOffset.Y := 2;
   //      txt.TagString     := FDMemProdutoDisponivel.FieldByName('Picking').AsString;

         //Descricao
         txt := TListItemText(Objects.FindDrawable('Descricao'));
         txt.Text := FDMemProdutoDisponivel.FieldByName('Descricao').AsString;
         txt.Font.Size := 14;
         //txt.Height    := 20;
         //Txt.Width     := 250;
         //txt.Font.Style := [TFontStyle.fsBold];
         //txt.PlaceOffset.X := 103;
         //txt.PlaceOffset.Y := 2;
         txt.TagString     := FDMemProdutoDisponivel.FieldByName('Picking').AsString;
         //txt.Visible       := False;
   //      EnderecoMask(FDMemProdutoDisponivel.FieldByName('CodigoERP').AsString,
   //                               FdMemEndereco.FieldByName('Mascara').AsString, True);

       end;
       if FDMemProdutoDisponivel.FieldByName('Status').AsString <> 'F' then
          Inc(vEnderecoPendente);
    //End;
    FDMemProdutoDisponivel.Next;
  End;
  LstItensProduto.EndUpdate;
  LblCircContagem.Text := vEnderecoPendente.ToString;
end;

procedure TFrmInventario.MontaListaProdutoLoteInventariado;
Var item : TListViewItem;
    txt : TListItemText;
    img : TListItemImage;
    Cor : Cardinal;
begin
  //FdMemLoteInventariado.Filter   := 'EnderecoId = '+EdtEndereco.Tag.ToString();
  //FdMemLoteInventariado.Filtered := True;
  FdMemLoteInventariado.First;
  LstLoteProdutoInventariado.BeginUpdate;
  LstLoteProdutoInventariado.Items.Clear;
  While Not FdMemLoteInventariado.Eof do Begin
    If FdMemLoteInventariado.FieldByName('Status').AsString <> 'F' then Begin
       item := LstLoteProdutoInventariado.Items.Add;
       item.Objects.Clear;
   //     item.Text := FdMemEndereco.FieldByName('Descricao').AsString;
       item.TagString := FdMemLoteInventariado.FieldByName('ItemId').AsString;
       with item do begin
         // Status do Endereço...
         img := TListItemImage(Objects.FindDrawable('ImgFdoLoteInventariado'));
         img.ScalingMode := TImageScalingMode.Stretch;
         If FdMemLoteInventariado.FieldByName('Status').AsString = 'I' Then begin       //Inicializado
            img.Bitmap := ImgLstFdoWhite.Bitmap;
            Cor:= $FF5DA9BC;
         End
         Else If FdMemLoteInventariado.FieldByName('Status').AsString = 'C' Then Begin  //Em Contagem
            img.Bitmap := ImgLstFdoYellow.Bitmap;
            Cor:= $FFE9C168;
         End
         Else If FdMemLoteInventariado.FieldByName('Status').AsString = 'F' then Begin  //Concluído/Finalizado
            img.Bitmap := ImgLstFdoGreen.BitMap;
            Cor:= $FF32B932;
         end;
         // Endereço...
         txt := TListItemText(Objects.FindDrawable('LInvItem'));
         txt.Text := FdMemLoteInventariado.FieldByName('ItemId').AsString;
         txt.TagString     := FdMemLoteInventariado.FieldByName('ItemId').AsString;
         Txt.Font.Size := 13;
         //Txt.TextColor := TAlphaColorRec.Green;

         //Estrutura
         // Setor...
         txt := TListItemText(Objects.FindDrawable('LInvEndereco'));
         txt.Text := FdMemLoteInventariado.FieldByName('Endereco').AsString;
         txt.TagString := FdMemLoteInventariado.FieldByName('Endereco').AsString;
         Txt.Font.Size := 13;

         // Setor...
         txt := TListItemText(Objects.FindDrawable('LInvLote'));
         txt.Text := FdMemLoteInventariado.FieldByName('DescrLote').AsString;
         Txt.Font.Size := 13;
         txt.TagString     := FdMemLoteInventariado.FieldByName('DescrLote').AsString;

         txt := TListItemText(Objects.FindDrawable('LInvVencimento'));
         txt.Text := FdMemLoteInventariado.FieldByName('Vencimento').AsString;
         Txt.Font.Size := 13;
         txt := TListItemText(Objects.FindDrawable('LInvQuant'));
         txt.Text := FdMemLoteInventariado.FieldByName('Quantidade').AsString;
         Txt.Font.Size := 13;
       end;
    End;
    FdMemLoteInventariado.Next;
  End;
  LstLoteProdutoInventariado.EndUpdate;
end;

procedure TFrmInventario.OpenInventario(pInventarioId : Integer);
Var JsonArrayInventario : TJsonArray;
    JsonArrayProcesso   : TJsonArray;
    JsonArrayRetorno    : TJsonArray;
    ObjProcessoCtrl     : TProcessoCtrl;
    vProcessoId : Integer;
    vErro       : String;
    vSaldoInicial, vEnderecoBloqueado, vProdutoBloqueado : Integer; //0 - Indica que o Estoque não foi congelado para contagem
Begin
  Try
    ShowLoading;
    JsonArrayInventario := ObjInventarioCtrl.GetInventario(pInventarioId);
    LblTituloInventarioId.Text := 'Inventário: '+pInventarioId.ToString();
    if JsonArrayInventario.Items[0].TryGetValue('Erro', vErro) then Begin
       HideLoading;
       ShowErro(vErro);
       Exit;
    End;
    vSaldoInicial      := JsonArrayInventario.Items[0].GetValue<Integer>('saldoinicial');
    vEnderecoBloqueado := JsonArrayInventario.Items[0].GetValue<Integer>('totalenderecobloqueado');
    vProdutoBloqueado  := JsonArrayInventario.Items[0].GetValue<Integer>('totalprodutobloqueado');
    ObjInventarioCtrl.ObjInventario := ObjInventarioCtrl.ObjInventario.JsonToClass((JsonArrayInventario.Items[0] as TJsonObject).ToString);
    JsonArrayProcesso := ObjProcessoCtrl.GetProcesso('Inventario - Gerado');
    if JsonArrayProcesso.Items[0].TryGetValue('Erro', vErro) then Begin
       HideLoading;
       JsonArrayInventario := Nil;
       ShowErro(vErro);
       Exit;
    End;
    if ObjInventarioCtrl.ObjInventario.InventarioTipo = 1 then
       InventarioTipo := poGeografico
    Else if ObjInventarioCtrl.ObjInventario.InventarioTipo = 2 then
       InventarioTipo := poPrioritario;
    vProcessoId := JsonArrayProcesso.Items[0].GetValue<Integer>('codigo');
    if Not (ObjInventarioCtrl.ObjInventario.ProcessoId in [123, 133]) then Begin //<> vProcessoId then Begin
       ShowErro('Inventário não pode ser Editado.');
       SetCampoDefault('EdtConteudoPesq');
       PgcPrincipal.ActiveTab := TabLista;
    End;
    if (InventarioTipo = poGeografico) and (vEnderecoBloqueado > 0) then Begin
       ShowErro('Inventário com Endereço(s) em Produção!');
       SetCampoDefault('EdtConteudoPesq');
       PgcPrincipal.ActiveTab := TabLista;
    End
    Else if (InventarioTipo = poPrioritario) and (vProdutoBloqueado > 0) then Begin
       ShowErro('Inventário com Produto(s) em Produção!');
       SetCampoDefault('EdtConteudoPesq');
       PgcPrincipal.ActiveTab := TabLista;
    End
    Else If vSaldoInicial <= 0 then Begin
       OpenInventarioCongelarEstoque;
    End
    Else  Begin
       GetDataInventario;
    End;
    JsonArrayRetorno := Nil;
    HideLoading;
  //Montar Lista de Endereços
  Except On E: Exception do Begin
    HideLoading;
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

function TFrmInventario.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  If (pCampo = 0) and (StrToIntDef(EdtConteudoPesq.Text, 0) <= 0) then Begin
     ShowErro('Id de Inventário inválido!');
     Exit;
  End;
  Result := True;
  if pCampo = 0 then Begin
     FDMemInventarioPendente.First;
     if Not FDMemInventarioPendente.Locate('inventarioid', pConteudo.ToInteger, []) then Begin
        ShowErro('Inventário não está na lista de Inventários Pendentes!');
        Exit;
     End;
  End
  Else Begin
     ShowErro('Inventário não está na lista de Inventários Pendentes!');
     Exit;
  End;
  If InventarioTipo = poGeografico then Begin
     PgcPrincipal.ActiveTab := TabDetalhes;
     DelayEdSetFocus(EdtCodigo);
  End
  Else Begin
     PgcPrincipal.ActiveTab := TabProdutos;
     DelayEdSetFocus(EdtCodigoERP);
  End;
  LblTituloForm.Text := 'Inventário - Contagem. Nr: '+FdMemInventarioPendente.FieldByName('InventarioId').Asstring;
end;

procedure TFrmInventario.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if (PgcPrincipal.ActiveTab = TabLista) then Begin
     if ObjInventarioCtrl.ObjInventario.InventarioTipo = 1 then
        BtnArrowLeft.Action              := ChgTabEndereco
     Else if ObjInventarioCtrl.ObjInventario.InventarioTipo = 2 then
        BtnArrowLeft.Action              := ChgTabProduto;
     BtnArrowRigth.Action                := ChgTabDet;
     LblTituloProcessoInventario.Text    := 'Listagem';
     LblTituloInventarioId.Text          := '';
     CircContagem.Visible                := False;
  End
  Else if (PgcPrincipal.ActiveTab = TabDetalhes) or (PgcPrincipal.ActiveTab = TabProdutos) then Begin //Contagem de Itens
     TabListaOnOff;
     BtnArrowRigth.Action := ChgTabEndereco;
     if EdtEndereco.Enabled then
        DelayedSetFocus(EdtCodigo);
     LblTituloProcessoInventario.Text := 'Em Contagem';
     LblTituloInventarioId.Text       := 'Inventário: '+ObjInventarioCtrl.ObjInventario.InventarioId.ToString();
     CircContagem.Visible := True;
  End
  Else if (PgcPrincipal.ActiveTab = TabItemContagem) then Begin
     if ObjInventarioCtrl.ObjInventario.InventarioTipo = 1 then
        BtnArrowLeft.Action              := ChgTabDet
     Else if ObjInventarioCtrl.ObjInventario.InventarioTipo = 2 then
        BtnArrowLeft.Action              := ChgTabProduto;
     TabListaOnOff;
     if InventarioTipo = poGeografico then
        LblTituloProcessoInventario.Text := 'Endereço(s) para Contagem'
     Else
        LblTituloProcessoInventario.Text := 'Produto(s) para Contagem';
     LblTituloInventarioId.Text       := '';
     CircContagem.Visible := False;
  End;
end;

procedure TFrmInventario.PositionField;
begin

end;

procedure TFrmInventario.ShowDados;
begin
  inherited;
  //
end;

procedure TFrmInventario.TabListaOnOff;
begin
  BtnArrowLeft.Enabled     := True;
  PthArrowLeft.Fill.Color  := TAlphaColorRec.chocolate;
  PthArrowRight.Fill.Color := TAlphaColorRec.chocolate;
  if (PgcPrincipal.ActiveTab=TabDetalhes) then Begin
     If EdtEndereco.Enabled Then begin
        BtnArrowLeft.Action      := ChgTabLista;
        BtnArrowLeft.Enabled     := True;
        PthArrowLeft.Fill.Color  := TAlphaColorRec.chocolate;
     end
     Else Begin
        BtnArrowLeft.Action     := Nil;
        BtnArrowLeft.Enabled    := False;
        PthArrowLeft.Fill.Color := TAlphaColorRec.DarkGray;
     End;
  End
  Else if (PgcPrincipal.ActiveTab=TabProdutos) then Begin
     If EdtCodigoERP.Enabled Then begin
        BtnArrowLeft.Action      := ChgTabLista;
        BtnArrowLeft.Enabled     := True;
        PthArrowLeft.Fill.Color  := TAlphaColorRec.chocolate;
     end
     Else Begin
        BtnArrowLeft.Action     := Nil;
        BtnArrowLeft.Enabled    := False;
        PthArrowLeft.Fill.Color := TAlphaColorRec.DarkGray;
     End;
  End
  Else If (PgcPrincipal.ActiveTab = TabItemContagem) then begin
     If EdtEndereco.Enabled Then begin
        BtnArrowRigth.Action     := ChgTabLista;
        BtnArrowRigth.Enabled    := True;
        PthArrowRight.Fill.Color := TAlphaColorRec.chocolate;
     end
     Else begin
       BtnArrowRigth.Action     := Nil;
       BtnArrowRigth.Enabled    := False;
       PthArrowRight.Fill.Color := TAlphaColorRec.DarkGray;
     end;
  end
  Else If (PgcPrincipal.ActiveTab = TabSimplesContagem) then begin
     If EdtEnderecoCS.Enabled Then begin
        BtnArrowRigth.Action     := ChgTabLista;
        BtnArrowRigth.Enabled    := True;
        PthArrowRight.Fill.Color := TAlphaColorRec.chocolate;
     end
     Else begin
       BtnArrowRigth.Action     := Nil;
       BtnArrowRigth.Enabled    := False;
       PthArrowRight.Fill.Color := TAlphaColorRec.DarkGray;
     end;
  end;
end;

procedure TFrmInventario.SbZerarEnderecoClick(Sender: TObject);
Var vErro : String;
    JsonArrayRetorno : TJsonObject;
begin
  inherited;
  FdMemLoteInventariado.First;
  if (FdMemLoteInventariado.RecordCount<1) and (FdMemLoteInventariado.FieldByName('Loteid').AsString='') then Begin
     If ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
        JsonArrayRetorno := ObjInventarioCtrl.ZerarEndereco(ObjInventarioCtrl.ObjInventario.inventarioid,
                                                            EdtEndereco.Tag, 0)
     Else If ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then
        JsonArrayRetorno := ObjInventarioCtrl.ZerarEndereco(ObjInventarioCtrl.ObjInventario.inventarioid, 0, EdtCodigoERP.Tag);
     If JsonArrayRetorno.TryGetValue('Erro', vErro) Then Begin
        ShowErro(vErro);
        Exit;
     End
     Else Begin
       if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
          CtrlDigitacao(False);
          EdtEndereco.Text := '';
          EdtProdutoId.Text := '';
          EdtProdutoIdTyping(EdtProdutoId);
          LstLoteInventariado.Items.Clear;
          CtrlDigitacao(False);
          SbZerarEndereco.Visible := False;
          GetInventarioEndereco;
          DelayEdSetFocus(EdtEndereco);
       End
       Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
          CtrlDigitacao(False);
          EdtEnderecoProduto.Text := '';
          EdtCodigoERP.Text := '';
          EdtProdutoIdTyping(EdtCodigoERP);
          LstLoteProdutoInventariado.Items.Clear;
          CtrlDigitacao(False);
          SbZerarProduto.Visible := False;
          GetInventarioProduto;
          DelayEdSetFocus(EdtCodigoERP);
       End;
       ShowOk('Endereço Zerado com sucesso!');
     End;
  End
  Else Begin
    While Not FdMemLoteInventariado.Eof do Begin
      FdMemLoteInventariado.Edit;
      FdMemLoteInventariado.FieldByName('Quantidade').AsInteger := 0;
      FdMemLoteInventariado.FieldByName('UsuarioId').AsInteger  := FrmeXactWMs.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
{      if FdMemLoteInventariado.FieldByName('Status').AsString = 'I' then
         FdMemLoteInventariado.FieldByName('Status').AsString := 'C'
      Else
      if (FdMemLoteInventariado.FieldByName('Status').AsString <> 'I') And     //GSS em 03/07
         (FdMemLoteInventariado.FieldByName('QtdContagem').AsInteger = 0) then
         FdMemLoteInventariado.FieldByName('Status').AsString := 'F'
      Else FdMemLoteInventariado.FieldByName('Status').AsString := 'C'; //'I'; //Genilson Brasil
}      FdMemLoteInventariado.Post;
      FdMemLoteInventariado.Next;
    End;
    SbSalvarContagemClick(SbSalvarContagem);
  End;
end;

procedure TFrmInventario.SalvarContagemLote;
begin
  if Not ValidarContagem then exit;
  FdMemLoteInventariado.First;
  if Not (FdMemLoteInventariado.Locate('EnderecoId;ProdutoId;DescrLote', VarArrayOf([EdtEndereco.Tag, EdtProdutoId.Tag, EdtLote.Text]), [])) then Begin
     FdMemLoteInventariado.Append;
     FdMemLoteInventariado.FieldByName('ItemId').AsInteger         := 0;
     FdMemLoteInventariado.FieldByName('InventarioId').AsInteger   := ObjInventarioCtrl.ObjInventario.InventarioId;
     FdMemLoteInventariado.FieldByname('EnderecoId').AsInteger     := EdtEndereco.Tag;
     FdMemLoteInventariado.FieldByName('Endereco').AsString        := EdtEndereco.Text;
     FdMemLoteInventariado.FieldByName('ProdutoId').Asinteger      := EdtProdutoId.Tag;
     FdMemLoteInventariado.FieldByName('CodProduto').AsInteger     := vCodProduto;
     FdMemLoteInventariado.FieldByName('LoteId').AsInteger         := EdtLote.Tag;
     FdMemLoteInventariado.FieldByName('DescrLote').AsString       := EdtLote.Text;
     FdMemLoteInventariado.FieldByName('EstoqueInicial').AsInteger := 0;
     FdMemLoteInventariado.FieldByName('Automatico').AsInteger     := 0;
     //FdMemLoteInventariado.FieldByName('Status').AsString          := 'I';   'C'; //
     End
  Else
     FdMemLoteInventariado.Edit;
  FdMemLoteInventariado.FieldByName('Fabricacao').AsDateTime := StrToDate(EdtDtFabricacao.Text);
  FdMemLoteInventariado.FieldByName('Vencimento').AsDateTime := StrToDate(EdtDtVencimento.Text);
  FdMemLoteInventariado.FieldByName('Quantidade').AsInteger  := StrToIntDef(EdtQuant.Text, 0);
  FdMemLoteInventariado.FieldByName('Status').AsString := 'C';
  FdMemLoteInventariado.FieldByName('usuarioid').AsInteger := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
  FdMemLoteInventariado.Post;
  MontaListaLoteInventariado;
  EdtProdutoId.Text := '';
  EdtProdutoIdTyping(EdtProdutoId);
  DelayEdSetFocus(EdtProdutoId);      //(Status<>'+#39+'I'+#39+') and
//  FdMemLoteInventariado.Filter   := '(Status<>'+#39+'I'+#39+') and (UsuarioId is Null) and (Status<>'+#39+'F'+#39+') and (Quantidade is Null) and (LoteId Is Not Null)';     //and (ContagemId Is Not Null) and (Quantidade Is Null)';
//  FdMemLoteInventariado.Filtered := True;
//  SbSalvarContagem.Visible       := FdMemLoteInventariado.IsEmpty;
  SbSalvarContagem.Visible       := True; // para forçar recontagem, desativar essa linha e ativar as de cima
  SbZerarEndereco.Visible        := False;
  FdMemLoteInventariado.Filter   := '';
  FdMemLoteInventariado.Filtered := False;
end;

procedure TFrmInventario.SalvarContagemProdutoLote;
begin
  if Not ValidarContagem then exit;
  FdMemLoteInventariado.First;
  if Not (FdMemLoteInventariado.Locate('EnderecoId;ProdutoId;DescrLote',
         VarArrayOf([EdtEnderecoProduto.Tag, EdtCodigoERP.Tag, EdtLoteProduto.Text]), [])) then Begin
     FdMemLoteInventariado.Append;
     FdMemLoteInventariado.FieldByName('ItemId').AsInteger         := 0;
     FdMemLoteInventariado.FieldByName('InventarioId').AsInteger   := ObjInventarioCtrl.ObjInventario.InventarioId;
     FdMemLoteInventariado.FieldByname('EnderecoId').AsInteger     := EdtEnderecoProduto.Tag;
     FdMemLoteInventariado.FieldByName('Endereco').AsString        := EdtEnderecoProduto.Text;
     FdMemLoteInventariado.FieldByName('ProdutoId').Asinteger      := EdtCodigoERP.Tag;
     FdMemLoteInventariado.FieldByName('CodProduto').AsInteger     := vCodProduto;
     FdMemLoteInventariado.FieldByName('LoteId').AsInteger         := EdtLoteProduto.Tag;
     FdMemLoteInventariado.FieldByName('DescrLote').AsString       := EdtLoteProduto.Text;
     FdMemLoteInventariado.FieldByName('EstoqueInicial').AsInteger := 0;
     FdMemLoteInventariado.FieldByName('Automatico').AsInteger     := 0;
     End
  Else
     FdMemLoteInventariado.Edit;
  FdMemLoteInventariado.FieldByName('Fabricacao').AsDateTime := StrToDate(EdtDtFabricacaoProduto.Text);
  FdMemLoteInventariado.FieldByName('Vencimento').AsDateTime := StrToDate(EdtDtVencimentoProduto.Text);
  FdMemLoteInventariado.FieldByName('Quantidade').AsInteger  := StrToIntDef(EdtQuantProduto.Text, 0);

//  if FdMemLoteInventariado.FieldByName('ContagemId').AsInteger <> 0 then
     FdMemLoteInventariado.Post;
  MontaListaProdutoLoteInventariado;
  EdtEnderecoProduto.Text := '';
  EdtEnderecoTyping(EdtEnderecoProduto);
  DelayEdSetFocus(EdtEnderecoProduto);
  FdMemLoteInventariado.Filter   := '(Status<>'+#39+'F'+#39+') and (Quantidade is Null) and (LoteId Is Not Null)';     //and (ContagemId Is Not Null) and (Quantidade Is Null)';
  FdMemLoteInventariado.Filtered := True;
  SbSalvarContagemProduto.Visible   := FdMemLoteInventariado.IsEmpty;
  SbZerarProduto.Visible    := False;
  FdMemLoteInventariado.Filter   := '';
  FdMemLoteInventariado.Filtered := False;
end;

procedure TFrmInventario.SalvaSimplesContagem;
Var JsonArrayRetorno  : TJsonArray;
    JsonObjectEstoque : TEstoqueCtrl;
    vErro : String;
    ObjEstoqueCtrl : TEstoqueCtrl;
begin
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
//  JsonArrayRetorno := ObjEstoqueCtrl.SalvarSimplesContagem(JsonObjectEstoque);
  If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     SetCampoDefault('EdtQuantCS');
     ShowErro('Contamgem não foi salva.');
  End
  Else Begin
    JsonArrayRetorno := Nil;
  End;
  JSonArrayRetorno := Nil;
  FreeAndNil(ObjEstoqueCtrl);
end;

procedure TFrmInventario.SbCancelarContagemClick(Sender: TObject);
begin
  inherited;
  CtrlDigitacao(False);
  if Inventariotipo = poGeografico then Begin
     EdtEndereco.Text := '';
     EdtProdutoId.Text := '';
     EdtProdutoIdTyping(EdtProdutoId);
     LstLoteInventariado.Items.Clear;
     SbSalvarContagem.Visible := False;
     SbZerarEndereco.Visible := False;
     SbCancelarContagem.Visible := False;
     DelayEdSetFocus(EdtEndereco);
  End
  Else If Inventariotipo = poPrioritario then Begin
     EdtEnderecoProduto.Text := '';
     EdtCodigoERP.Text := '';
     EdtProdutoIdTyping(EdtCodigoERP);
     LstLoteProdutoInventariado.Items.Clear;
     SbSalvarContagemProduto.Visible := False;
     SbZerarProduto.Visible := False;
     SbCancelarContagemProduto.Visible := False;
     DelayEdSetFocus(EdtCodigoERP);
  End;
  CtrlDigitacao(False);
end;

procedure TFrmInventario.SbSalvarContagemClick(Sender: TObject);
Begin
  If (InventarioTipo =  poGeografico) and (Not contagemCompletaDoEndereco) then
     ConfirmarZerarNaoContados
  Else
     SalvarContagem;
End;

procedure TFrmInventario.SalvarContagem;
Var JsonArrayContagem : TJsonArray;
    JsonContagem      : TJsonObject;
    vErro             : String;
    pStatus           : String;
    vRecord, vDelete, vRecno : Integer;
    vEstoqueInicial   : Integer;
begin
  inherited;
  if (InventarioTipo =  poGeografico) and (EdtProdutoId.Text <> '') then Begin
     if (not ValidarContagem) then Exit;
     SalvarContagemLote;
  End
  Else if (InventarioTipo =  poPrioritario) and (EdtEnderecoProduto.Text <> '') then Begin
     if not ValidarContagem then Exit;
     SalvarContagemProdutoLote;
  End;
  //Enviar dados para o servidor
  JsonArrayContagem := TJsonArray.Create();
  FdMemLoteInventariado.First;
  vRecord := FdMemLoteInventariado.RecordCount;
  vDelete := 0;
  vRecno  := 1;
  vRecord := FdMemLoteInventariado.RecordCount;
  FdMemLoteInventariado.First;
  vRecord := FdMemLoteInventariado.RecordCount;
  While Not FdMemLoteInventariado.Eof do Begin
    if FdMemLoteInventariado.FieldByName('Status').AsString <> 'F' then Begin
       JsonContagem := TJsonObject.Create();
       JsonContagem.AddPair('inventarioid', TJsonNumber.Create(FdMemLoteInventariado.FieldByName('InventarioId').AsInteger));
       JsonContagem.AddPair('itemid', TJsonNumber.Create(FdMemLoteInventariado.FieldByName('ItemId').AsInteger));
       JsonContagem.AddPair('enderecoid', TJsonNumber.Create(FdMemLoteInventariado.FieldByName('EnderecoId').AsInteger));
       JsonContagem.AddPair('produtoid', TJsonNumber.Create(FdMemLoteInventariado.FieldByName('ProdutoId').AsInteger));
       JsonContagem.AddPair('loteid', TJsonNumber.Create(FdMemLoteInventariado.FieldByName('LoteId').AsInteger));
       JsonContagem.AddPair('descrlote', FdMemLoteInventariado.FieldByName('DescrLote').AsString);
       JsonContagem.AddPair('dtfabricacao', FdMemLoteInventariado.FieldByName('Fabricacao').AsString);
       JsonContagem.AddPair('dtvencimento', FdMemLoteInventariado.FieldByName('Vencimento').AsString);
       JsonContagem.AddPair('quantidade', TJsonNumber.Create(FdMemLoteInventariado.FieldByName('Quantidade').AsInteger));
       vEstoqueInicial := FdMemLoteInventariado.FieldByName('EstoqueInicial').AsInteger;
       //If adicionado em 15022023
       if ((FdMemLoteInventariado.FieldByName('Status').AsString = 'I') And  //I2 POG para evitar de finalizar contagem unica zerada
           (FdMemLoteInventariado.FieldByName('quantidade').Asinteger=0) And
           (FdMemLoteInventariado.FieldByName('usuarioid').Asinteger=0)) or
           (FdMemLoteInventariado.FieldByName('Status').AsString = 'F') then Begin
          If (FdMemLoteInventariado.FieldByName('Status').AsString = 'I') and (FdMemLoteInventariado.FieldByName('usuarioid').Asinteger=0) then
             JsonContagem.AddPair('status', 'F')
          Else
             JsonContagem.AddPair('status', 'C');
       End
       Else Begin
          pStatus := 'F';
          if (FdMemLoteInventariado.FieldByName('Status').AsString <> 'F')  then
             if ((FdMemLoteInventariado.FieldByName('Status').AsString='I') and
                 (FrmeXactWMS.ConfigWMS.InventarioForcarMaxContagem = 0)) or
                  (FdMemLoteInventariado.FieldByName('Quantidade').AsInteger<>
                   FdMemLoteInventariado.FieldByName('QtdContagem').Asinteger) then
                pStatus := 'C';
          JsonContagem.AddPair('status', pStatus);
       End;
       JsonContagem.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWms.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
       {$IfDef Android}
          JsonContagem.AddPair('estacao', IMEI); //IMEI;
       {$else}
         JsonContagem.AddPair('estacao', NomeDoComputador);
       {$ENdif}
       JsonArrayContagem.AddElement(JsonContagem);
    End;
    FdMemLoteInventariado.Next;
  End;
  If ObjInventarioCtrl.SaveContagem(JsonArrayContagem).TryGetValue('Erro', vErro) Then Begin
     ShowErro(vErro);
     FdMemLoteInventariado.Filter := '';
     FdMemLoteInventariado.Filtered := False;
     Exit;
  End;
  FdMemLoteInventariado.Filter   := '';
  FdMemLoteInventariado.Filtered := False;
  JsonArrayContagem.DisposeOf;
  CtrlDigitacao(False);
  If (ObjInventarioCtrl.ObjInventario.InventarioTipo =  1) then Begin
     EdtEndereco.Text := '';
     EdtProdutoId.Text := '';
     EdtProdutoIdTyping(EdtProdutoId);
     LstLoteInventariado.Items.Clear;
     SbSalvarContagem.Visible   := False;
     SbCancelarContagem.Visible := False;
     SbZerarEndereco.Visible    := False;
     GetInventarioEndereco;
  End
  Else If (ObjInventarioCtrl.ObjInventario.InventarioTipo =  2) then Begin
     EdtEnderecoProduto.Text := '';
     EdtCodigoERP.Text := '';
     EdtProdutoIdTyping(EdtCodigoERP);
     LstLoteProdutoInventariado.Items.Clear;
     SbSalvarContagemProduto.Visible   := False;
     SbCancelarContagemProduto.Visible := False;
     SbZerarProduto.Visible := False;
     GetInventarioProduto;
  End;
  CtrlDigitacao(False);
  ShowOk('Contagem Gravada!');
  If (ObjInventarioCtrl.ObjInventario.InventarioTipo =  1) then
     DelayEdSetFocus(EdtEndereco);
end;

function TFrmInventario.ValidaLotePallet: Boolean;
Var vLote     : String;
    vEndereco : String;
    vQuant    : Integer;
begin
  if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then Begin
     vLote     := EdtLote.Text;
     vEndereco := EdtEndereco.Text;
     vQuant    := StrToIntDef(EdtQuant.Text, 0);
  End
  Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then Begin
     vLote     := EdtLoteProduto.Text;
     vEndereco := EdtEnderecoProduto.Text;
     vQuant    := StrToIntDef(EdtQuantProduto.Text, 0);
  End;
 // FdMemLoteInventariado.Filter   := 'CodProduto = '+vCodProduto.ToString();
  FdMemLoteInventariado.Filter   := 'CodProduto = '+vCodProduto.ToString()+' and Endereco = '+#39+vEndereco+#39;
  FdmemLoteInventariado.Filtered := True;
  Result := True;
  While Not FdMemLoteInventariado.Eof do Begin
    if (FdMemLoteInventariado.FieldByName('DescrLote').AsString <> vLote) and (vQuant > 0) and
       (FdMemLoteInventariado.FieldByName('Quantidade').AsInteger > 0) then Begin
       Result := False;
       if ObjInventarioCtrl.ObjInventario.inventariotipo = 1 then
          SetCampoDefault('EdtLote')
       Else if ObjInventarioCtrl.ObjInventario.inventariotipo = 2 then
          SetCampoDefault('EdtLoteProduto');
       ShowErro('Não é permitido mais de um lote do mesmo produto em um Pallet.');
       Break;
    End;
    FdMemLoteInventariado.Next;
  End;
  FdMemLoteInventariado.Filter   := '';
  FdmemLoteInventariado.Filtered := False;
end;

Function TFrmInventario.ValidarContagem : Boolean;
begin
  Result := False;
  if (ObjInventarioCtrl.ObjInventario.inventariotipo = 1) then Begin
     if EdtProdutoId.Text = '' then begin
        setCampoDefault('EdtCodigoERP');
        ShowErro('Informe o produto!');
        Exit
     End;
     if EdtLote.Text = '' then begin
        setCampoDefault('EdtLote');
        ShowErro('Informe o Lote!');
        Exit
     End;
     If (EdtDtFabricacao.Text = '') or (EdtDtFabricacao.Text = '  /  /    ') Then Begin
        setCampoDefault('EdtDtFabricacao');
        ShowErro('Informe a Data de Fabricação do Lote!');
        Exit
     End;
     If (EdtDtVencimento.Text='') or (EdtDtVencimento.Text = '  /  /    ') Then Begin
        setCampoDefault('EdtDtVencimento');
        ShowErro('Informe a Data de Venciemnto do Lote!');
        Exit
     End;
     Try
       StrToDate(EdtDtFabricacao.Text);
     Except
        setCampoDefault('EdtDtFabricacao');
        ShowErro('Informe a Data de Fabricação do Lote!');
        Exit
     End;
     Try
       StrToDate(EdtDtVencimento.Text);
     Except
        SetCampoDefault('EdtDtFabricacao');
        ShowErro('Informe a Data de Vencimento do Lote!');
        Exit
     End;
     if StrToDate(EdtDtVencimento.text) < StrToDate(EdtDtFabricacao.text) then begin
        setCampoDefault('EdtDtVencimento');
        ShowErro('Data vencimento inválida!');
        Exit;
     end;
     if StrToIntDef(EdtQuant.Text, 0) < 0 then begin
        setCampoDefault('EdtQuant');
        ShowErro('Quantidade inválida!');
        Exit;
     end;
  End
  Else If ObjInventarioCtrl.ObjInventario.InventarioTipo = 2 then Begin
     if EdtCodigoERP.Text = '' then begin
        setCampoDefault('EdtCodigoERP');
        ShowErro('Informe o produto!');
        Exit
     End;
     if EdtLoteProduto.Text = '' then begin
        setCampoDefault('EdtLote');
        ShowErro('Informe o Lote!');
        Exit
     End;
     If (EdtDtFabricacaoProduto.Text = '') or (EdtDtFabricacaoProduto.Text = '  /  /    ') Then Begin
        setCampoDefault('EdtDtFabricacaoProduto');
        ShowErro('Informe a Data de Fabricação do Lote!');
        Exit
     End;
     If (EdtDtVencimentoProduto.Text = '') or (EdtDtVencimentoProduto.Text = '  /  /    ') Then Begin
        setCampoDefault('EdtDtVencimentoProduto');
        ShowErro('Informe a Data de Venciemnto do Lote!');
        Exit
     End;
     Try
       StrToDate(EdtDtFabricacaoProduto.Text);
     Except
        setCampoDefault('EdtDtFabricacaoProduto');
        ShowErro('Informe a Data de Fabricação do Lote!');
        Exit
     End;
     Try
       StrToDate(EdtDtVencimentoProduto.Text);
     Except
        setCampoDefault('EdtDtFabricacaoProduto');
        ShowErro('Informe a Data de Vencimento do Lote!');
        Exit
     End;
     if StrToDate(EdtDtVencimentoProduto.text) < StrToDate(EdtDtFabricacaoProduto.text) then begin
        setCampoDefault('EdtDtVencimentoProduto');
        ShowErro('Data vencimento inválida!');
        Exit;
     end;
     if StrToIntDef(EdtQuantProduto.Text, 0) < 0 then begin
        ShowErro('Quantidade inválida!');
        DelayEdSetFocus(EdtQuantProduto);
        Exit;
     end;
  End;
  result := True;
end;

function TFrmInventario.ValidarFabricacaoVencimento(Sender: TObject): Boolean;
begin
  Result := False;
  if (TEdit(Sender).Text = '') or (TEdit(Sender).Text = '  /  /    ') then Exit;
  Try
    if Length(TEdit(Sender).Text) = 8 then
       TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
    StrToDate(TEdit(Sender).Text);
    if (StrToDate(TEdit(Sender).Text) < StrToDate('01/01/1990')) or
       (StrToDate(TEdit(Sender).Text) > StrToDate('19/08/2130')) then Begin
       if (Sender = EdtDtFabricacao) or (Sender = EdtDtFabricacaoProduto) then Begin
          TEdit(Sender).Text := '';
          ShowErro('Data de fabricação não permitida!');
       End
       Else Begin
          TEdit(Sender).Text := '';
          ShowErro('Data de Vencimento não permitida!');
       End;
    End
    Else if (Sender=EdtDtFabricacao) and (StrToDate(EdtDtFabricacao.Text) > Date()) then
      ShowErro('Data de fabricação inválida, não pode ser data futura!')
    Else if ((Sender=EdtDtVencimento) and (StrToDate(EdtDtFabricacao.Text) >= StrToDate(EdtDtVencimento.Text))) or
            ((Sender=EdtDtVencimentoProduto) and (StrToDate(EdtDtFabricacaoProduto.Text) >= StrToDate(EdtDtVencimentoProduto.Text))) then Begin
      TEdit(Sender).Text := '';
      ShowErro('Data de vencimento inválida, menor que fabricação!');
    End
    Else
      Result := True;
    if Not Result then Begin
       If Sender = EdtDtFabricacao then DelayEdSetFocus(EdtDtFabricacao)
       Else If Sender = EdtDtVencimento then DelayEdSetFocus(EdtDtVencimento)
       Else If Sender = EdtDtFabricacaoProduto then DelayEdSetFocus(EdtDtFabricacaoProduto)
       Else If Sender = EdtDtVencimentoProduto then DelayEdSetFocus(EdtDtVencimentoProduto);
    End;
  Except Begin
    If Sender = EdtDtFabricacao then SetCampoDefault('EdtDtFabricacao')
    Else If Sender = EdtDtVencimento then SetCampoDefault('EdtDtVencimento')
    Else If Sender = EdtDtFabricacaoProduto then SetCampoDefault('EdtDtFabricacaoProduto')
    Else If Sender = EdtDtVencimentoProduto then SetCampoDefault('EdtDtVencimentoProduto');
    if (Sender = EdtDtFabricacao) or (Sender = EdtDtFabricacaoProduto) then Begin
       TEdit(Sender).Text := '';
       ShowErro('Data de fabricação do lote inválida');
    End
    Else Begin
       TEdit(Sender).Text := '';
       ShowErro('Data de Vencimento do lote inválida');
       End;
    End;
  End;
end;

end.
