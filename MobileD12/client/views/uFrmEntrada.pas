unit uFrmEntrada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.DateUtils,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types, System.JSON, REST.Json, Rest.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, System.Generics.Collections,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, DataSet.Serialize,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB, FMX.DialogService,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.ActnList,
  System.Actions, FMX.TabControl, FMX.Objects, ksTypes, ksLoadingIndicator,
  FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.ListView,
  FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.Layouts, uMyTabOrderClassHelper, EntradaCtrl, EntradaItensCtrl,
  ProdutoCtrl, ProdutoCodBarrasCtrl, EnderecoCtrl, LotesClass, LoteCtrl, Math,
  UsuarioCtrl
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    , Androidapi.Helpers
    , Androidapi.JNI.Embarcadero
    , Androidapi.JNIBridge
    , Androidapi.JNI.GraphicsContentViewText
    , Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    , Androidapi.JNI.Os
  {$Endif};

type
  TTipoAutorizarAlteracaoLote = (poNenhuma, poTodos, poZona, poProduto);

  TFrmEntrada = class(TFrmBase)
    LblTitDocumento: TLabel;
    LblTitData: TLabel;
    LblTitFornecedor: TLabel;
    TabItens: TTabItem;
    LytLegendaCheckIn: TLayout;
    RctCheckIn: TRectangle;
    RctCheckInConferido: TRectangle;
    LblCheckInConferido: TLabel;
    RctVCheckInIniciado: TRectangle;
    LblCheckInIniciado: TLabel;
    LytEntradadaItens: TLayout;
    LstEntradaItens: TListView;
    RctLegendaItens: TRectangle;
    LblLegLote: TLabel;
    LblLegCheckIn: TLabel;
    LblLegVencimento: TLabel;
    LblLegCodProduto: TLabel;
    EdtDocumentoNr: TEdit;
    Line1: TLine;
    EdtDocumentoData: TEdit;
    Line2: TLine;
    LblDocumento: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtFornecedor: TEdit;
    Line3: TLine;
    FdMemEntradaProduto: TFDMemTable;
    ChgTabItens: TChangeTabAction;
    TabCheckIn: TTabItem;
    ChgTabCheckIn: TChangeTabAction;
    LytCheckInPedido: TLayout;
    Label4: TLabel;
    EdtPedidoId_CheckIn: TEdit;
    Line4: TLine;
    Label5: TLabel;
    EdtDocumentoNr_CheckIn: TEdit;
    Line5: TLine;
    LblLegSegregada: TLabel;
    LblLegDevolvida: TLabel;
    Label12: TLabel;
    LytCheckInDigitacao: TLayout;
    TabLogistico: TTabItem;
    TabDevolucaoSegregado: TTabItem;
    FDMemEntradaLotes: TFDMemTable;
    Rct01DigProduto: TRectangle;
    Label13: TLabel;
    EdtCodProduto: TEdit;
    Line6: TLine;
    Label14: TLabel;
    EdtPicking: TEdit;
    Line7: TLine;
    Label15: TLabel;
    StcSngpc: TSwitch;
    Rct02DataProduct: TRectangle;
    EdtDescricao: TEdit;
    Line10: TLine;
    Label19: TLabel;
    EdtFatorConversao: TEdit;
    Line12: TLine;
    Label20: TLabel;
    EdtAltura: TEdit;
    Line13: TLine;
    Label21: TLabel;
    EdtLargura: TEdit;
    Line14: TLine;
    Label22: TLabel;
    EdtComprimento: TEdit;
    Line15: TLine;
    Label23: TLabel;
    EdtVolume: TEdit;
    Line16: TLine;
    Label24: TLabel;
    EdtLote: TEdit;
    Line17: TLine;
    Label25: TLabel;
    EdtDtFabricacao: TEdit;
    LnDtFabricacao: TLine;
    EdtDtVencimento: TEdit;
    LnDtVencimento: TLine;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    EdtPeso: TEdit;
    Line19: TLine;
    Label29: TLabel;
    Rct03EndCheckIn: TRectangle;
    EdtQtdUnidPrimCheckIn: TEdit;
    Line8: TLine;
    EdtQtdUnidSecCheckIn: TEdit;
    Line9: TLine;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    SbSalvarCheckIn    : TSpeedButton;
    PthSalvarCheckIn   : TPath;
    LblSalvarCheckIn   : TLabel;
    SbCancelarCheckIn  : TSpeedButton;
    PthCancelarCheckIn : TPath;
    LblCancelarCheckIn : TLabel;
    EdtQtdTotCheckIn: TEdit;
    Line11: TLine;
    ActConfirmarNovoLote: TAction;
    ActNaoConfirmarNovoLote: TAction;
    ImgDevSeg: TImage;
    FDMemAgrupamentoLoteXML: TFDMemTable;
    FDMemLotesCheckIn: TFDMemTable;
    FdMemListaPedido: TFDMemTable;
    LblAgrup: TLabel;
    Label30: TLabel;
    LblRastro: TLabel;
    LytDevolucaoSegregadoPedido: TLayout;
    Label31: TLabel;
    EdtPedidoIdDevSeg: TEdit;
    Line20: TLine;
    Label32: TLabel;
    EdtDocumentoNrDevSeg: TEdit;
    Line21: TLine;
    RctDevolucaoSegregadoProduto: TRectangle;
    EdtCodProdutoDevSeg: TEdit;
    Line22: TLine;
    EdtPickingDevSeg: TEdit;
    Line23: TLine;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    RctDevolucaoSegregadoTipo: TRectangle;
    Label36: TLabel;
    CbTipoMovimentacaoDevSeg: TComboBox;
    RctDevolucaoSegregadoMovimento: TRectangle;
    Label37: TLabel;
    CbLoteDevSeg: TComboBox;
    Label38: TLabel;
    LblLoteFabricacaoDevSeg: TLabel;
    LblLoteVencimentoDevSeg: TLabel;
    LblTitLoteFabricacao: TLabel;
    LblTitLoteVencimento: TLabel;
    LytQtdeSubstituto: TLayout;
    LblQtdeSubstituto: TLabel;
    EdtQtdeDevSeg: TEdit;
    Line24: TLine;
    SbSalvarDevSeg: TSpeedButton;
    PthSalvarDevSeg: TPath;
    LblSaveDevSeg: TLabel;
    Path1: TPath;
    SwtSngpcDevSeg: TSwitch;
    EdtDescricaoDevSeg: TEdit;
    Line25: TLine;
    Label39: TLabel;
    Label40: TLabel;
    LblRastroDevSeg: TLabel;
    Label41: TLabel;
    EdtDocumentoDataDevSeg: TEdit;
    Line26: TLine;
    SbCancelarDevSeg: TSpeedButton;
    PthCancelarDevSeg: TPath;
    LblCancelarDevSeg: TLabel;
    CbCausaDevolucaoSegregado: TComboBox;
    Label42: TLabel;
    BtnLoginMaster: TSpeedButton;
    PthLoginMaster: TPath;
    LytEntradaItens: TLayout;
    LstEntradaProduto: TListView;
    LytRodapeFinalizar: TLayout;
    BtnFinalizarCheckIn: TSpeedButton;
    PthFinalizarCheckIn: TPath;
    LblFinalizarCheckIn: TLabel;
    BtnAbortarCheckIn: TSpeedButton;
    PthAbortarCheckIn: TPath;
    LblAbortarCheckIn: TLabel;
    RctEntradaProduto: TRectangle;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label43: TLabel;
    CbRastroTipo: TComboBox;
    FDMemSegregadoCausa: TFDMemTable;
    FDMemAgrupamentoCheckIn: TFDMemTable;
    FDMemProdutoCheckIn: TFDMemTable;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LstPrincipalDblClick(Sender: TObject);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure EdtCodigoValidate(Sender: TObject; var Text: string);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure ValidarCodProduto;
    procedure SbCancelarCheckInClick(Sender: TObject);
    procedure EdtCodProdutoTyping(Sender: TObject);
    procedure SbSalvarCheckInClick(Sender: TObject);
    procedure EdtDtFabricacaoTyping(Sender: TObject);
    procedure EdtDtFabricacaoExit(Sender: TObject);
    procedure EdtQtdUnidPrimCheckInTyping(Sender: TObject);
    procedure EdtLoteTyping(Sender: TObject);
    procedure EdtDtVencimentoValidate(Sender: TObject; var Text: string);
    procedure EdtQtdUnidPrimCheckInKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtLoteExit(Sender: TObject);
    procedure EdtCodProdutoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtDtFabricacaoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtLoteKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtPickingValidate(Sender: TObject; var Text: string);
    procedure EdtPickingKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ActConfirmarNovoLoteExecute(Sender: TObject);
    procedure ActNaoConfirmarNovoLoteExecute(Sender: TObject);
    procedure EdtSenhaCtrlSegValidate(Sender: TObject; var Text: string);
    procedure EdtUsuarioCtrlSegValidate(Sender: TObject; var Text: string);
    procedure BtnLogInClick(Sender: TObject);
    procedure EdtSenhaCtrlSegKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtUsuarioCtrlSegKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure LstPrincipalButtonClick(const Sender: TObject;
      const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure EdtLoteEnter(Sender: TObject);
    procedure LstEntradaProdutoItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure EdtCodProdutoDevSegExit(Sender: TObject);
    procedure EdtCodProdutoDevSegKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodProdutoDevSegTyping(Sender: TObject);
    procedure CbLoteDevSegChange(Sender: TObject);
    procedure SbSalvarDevSegClick(Sender: TObject);
    procedure SbCancelarDevSegClick(Sender: TObject);
    procedure EdtQtdeDevSegKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure BtnAbortarCheckInClick(Sender: TObject);
    procedure BtnFinalizarCheckInClick(Sender: TObject);
    procedure BtnLoginMasterClick(Sender: TObject);
    procedure CbRastroTipoExit(Sender: TObject);
    procedure EdtAlturaValidate(Sender: TObject; var Text: string);
    procedure EdtComprimentoValidate(Sender: TObject; var Text: string);
    procedure EdtPesoValidate(Sender: TObject; var Text: string);
  private
    { Private declarations }
    EventCreate : Boolean;
    vCodProdutoCheckIn, vCodProdutoDevSeg : Integer;
    vUsuarioAutorizadorUpdLote : Integer;
    TipoAutorizarAlteracaoLote     : TTipoAutorizarAlteracaoLote;
    StartEntrada, permitirVisualizarDivergencia : Boolean;
    Function GetListaEntrada(pPedidoId : Integer = 0; pPessoaId : Integer = 0; pDocumento : String = '';
             pRazao : String = ''; pRegistroERP : String = ''; pDtNotaFiscal : TDateTime = 0;
             pPendente : Integer = 1; pAgrupamentoId : Integer = 0; pCodProduto : String = '0') : Boolean;
    Procedure OpenEntrada;
    Function GetEntradaProduto(pPedidoId, pAgrupamentoId : Integer) : TJsonArray;
    Procedure GetEntradaLotes(pPedidoId, pAgrupamentoId  : Integer);
    Function  GetCodigoERP(pCodProduto: String) : Integer;
    Procedure LimparRct02_Rct03;
    Procedure ValidarSets;
    Function ValidarQuantidade : Boolean;
    Procedure ShowDadosProduto;
    Function SaveItemCheckIn(pQtdDevolvida, pQtdSegregada, pCausaId : Integer) : Boolean;
    Function AtualizaEntradaLotes(pLote : String) : Boolean;
    Procedure VerifyEndCheckIn;
    Function FinalizarCheckIn : Boolean;
    Function FatorarCheckInNotas : Boolean;
    Function ExigirTagControlados : Boolean;
    Function ValidarFinalizacaoComDevolucao_Segregado : Boolean;
    Function VerifyAutorization : Boolean;
    Procedure LoteNovoNaEntrada;
    Function ConfirmarNovoLote : Boolean;
    Procedure AtivarPanelAutorizacao;
    procedure ThreadTerminatePrincipal(Sender: TObject);
    procedure ThreadTerminateProduto(Sender: TObject);
    Function ValidarCheckInProduto(pCodProdutoCheckIn : Integer) : Boolean;
    Procedure LimparDevolucaoSegregado;
    Procedure PreencherDevolucaoSegregado(pCodProduto : String);
    Procedure GetLotesParaDevolucao;
    Procedure ShowDadosProdutosParaDevolucao;
    Procedure GetProdutoControle;
    Procedure GetSegregadoCausa;

    Procedure ThreadAtualizarRastroTerminate(Sender : TObject);
  public
    { Public declarations }
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Procedure ShowDados; OverRide;
    Procedure PermitirAcessoCtrlSeg; OverRide;
    Procedure BlockFuncaoAutorizacao; OverRide;
    Procedure LiberarFuncaoBloqueada; OverRide;
    Procedure AtivaCampoDefault; OverRide;
  end;

var
  FrmEntrada: TFrmEntrada;

implementation

{$R *.fmx}

uses uFrmeXactWMS, uLibThread, U_MsgD, Notificacao, uFuncoes, uDmClient, System.Threading,
  SegregadoCausaCtrl;

{ TFrmEntrada }

procedure TFrmEntrada.ActConfirmarNovoLoteExecute(Sender: TObject);
begin
  inherited;
  If VerifyAutorization then
     DelayEdSetFocus(EdtDtFabricacao)
  Else Begin
     funcaoParaAutorizar := 'Recebimentos - Altera��o Lotes';
     AtivarPanelAutorizacao;
  End;
end;

procedure TFrmEntrada.ActNaoConfirmarNovoLoteExecute(Sender: TObject);
begin
  inherited;
  EdtLote.Text := '';
  DelayEdSetFocus(EdtLote);
end;

procedure TFrmEntrada.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'CbCampoPesq' then Begin
     DelayEdSetFocus(CbCampoPesq);
  End
  Else if CampoDefault = 'EdtConteudoPesq' then Begin
     EdtConteudoPesq.Text := '';
     DelayEdSetFocus(EdtConteudoPesq);
  End
  Else if CampoDefault = 'EdtCodigo' then Begin
     EdtCodigo.Text := '';
     DelayEdSetFocus(EdtCodigo);
  End
  Else if CampoDefault = 'EdtCodProdutoDevSeg' then Begin
     EdtCodProdutoDevSeg.Text := '';
     DelayEdSetFocus(EdtCodProdutoDevSeg);
  End
  Else if CampoDefault = 'CbTipoMovimentacaoDevSeg' then Begin
     CbTipoMovimentacaoDevSeg.ItemIndex := -1;
     DelayEdSetFocus(CbTipoMovimentacaoDevSeg);
  End
  Else if CampoDefault = 'CbLoteDevSeg' then Begin
     CbLoteDevSeg.ItemIndex := -1;
     DelayEdSetFocus(CbLoteDevSeg);
  End
  Else if CampoDefault = 'EdtQtdeDevSeg' then Begin
     EdtQtdeDevSeg.Text := '';
     DelayEdSetFocus(EdtQtdeDevSeg);
  End
  Else if CampoDefault = 'CbCausaDevolucaoSegregado' then Begin
     CbCausaDevolucaoSegregado.ItemIndex := -1;
     DelayEdSetFocus(CbCausaDevolucaoSegregado);
  End
  Else if CampoDefault = 'EdtCodProduto' then Begin
     EdtCodProduto.Text := '';
     DelayEdSetFocus(EdtCodProduto);
  End
  Else if CampoDefault = 'EdtPicking' then Begin
     EdtPicking.Text := '';
     DelayEdSetFocus(EdtPicking);
  End
  Else if CampoDefault = 'CbRastroTipo' then Begin
     CbRastroTipo.ItemIndex := -1;
     DelayEdSetFocus(CbRastroTipo);
  End
  Else if CampoDefault = 'EdtFatorConversao' then Begin
     EdtFatorConversao.Text := '';
     DelayEdSetFocus(EdtFatorConversao);
  End
  Else if CampoDefault = 'EdtPeso' then Begin
     EdtPeso.Text := '';
     DelayEdSetFocus(EdtPeso);
  End
  Else if CampoDefault = 'EdtAltura' then Begin
     EdtAltura.Text := '';
     DelayEdSetFocus(EdtAltura);
  End
  Else if CampoDefault = 'EdtLargura' then Begin
     EdtLargura.Text := '';
     DelayEdSetFocus(EdtLargura);
  End
  Else if CampoDefault = 'EdtComprimento' then Begin
     EdtComprimento.Text := '';
     DelayEdSetFocus(EdtComprimento);
  End
  Else if CampoDefault = 'EdtLote' then Begin
     EdtLote.Text := '';
     DelayEdSetFocus(EdtLote);
  End
  Else if CampoDefault = 'EdtDtFabricacao' then Begin
     EdtDtFabricacao.Text := '';
     DelayEdSetFocus(EdtDtFabricacao);
  End
  Else if CampoDefault = 'EdtDtVencimento' then Begin
     EdtDtVencimento.Text := '';
     DelayEdSetFocus(EdtDtVencimento);
  End
  Else if CampoDefault = 'EdtQtdUnidPrimCheckIn' then Begin
     EdtQtdUnidPrimCheckin.Text := '';
     DelayEdSetFocus(EdtQtdUnidPrimCheckIn);
  End
  Else if CampoDefault = 'EdtQtdUnidSecCheckIn' then Begin
     EdtQtdUnidSecCheckIn.Text := '';
     DelayEdSetFocus(EdtQtdUnidSecCheckIn);
  End
  Else if CampoDefault = 'EdtLote' then Begin
     EdtLote.Text := '';
     DelayEdSetFocus(EdtLote);
  End

end;

procedure TFrmEntrada.AtivarPanelAutorizacao;
begin
  AtivarPanelSeguranca;
end;

procedure TFrmEntrada.BlockFuncaoAutorizacao;
begin
  inherited;
  if funcaoParaAutorizar = 'Recebimentos - Visualizar Diverg�ncias no CheckIn' then Begin
  End
  Else if funcaoParaAutorizar = 'Permitir Recebimento fora do Shelf-Life' then Begin
    EdtDtVencimento.Text := '';
    DelayEdSetFocus(EdtDtFabricacao);
  End;
  if funcaoParaAutorizar = 'Recebimentos - Altera��o Lotes' then Begin
     EdtLote.Text := '';
     DelayEdSetFocus(EdtLote);
  End;
end;

procedure TFrmEntrada.BtnAbortarCheckInClick(Sender: TObject);
Var ObjEntradaItensCtrl : TEntradaItensCtrl;
begin
  inherited;
  TDialogService.MessageDialog('Cancelar a confer�ncia da Nota ?',
                 TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
     procedure(const AResult: TModalResult)
     Var ObjEntradaItensCtrl : TEntradaItensCtrl;
         ReturnJsonArray     : TJsonArray;
         vErro : String;
     begin
       if AResult = mrYes then Begin
         ObjEntradaItensCtrl := TEntradaItensCtrl.Create;
         ReturnJsonArray := ObjEntradaItensCtrl.CancelarCheckInProduto(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger,
                                                QryListaPadrao.FieldByName('PedidoId').AsInteger,
                                                0);
         if ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then
            ShowErro('Erro: '+vErro)
         Else GetEntradaProduto(QryListaPadrao.FieldByName('PedidoId').AsInteger, QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
         ReturnJsonArray := Nil;
         ObjEntradaItensCtrl.Free;
       End;
     end);
end;

procedure TFrmEntrada.BtnFinalizarCheckInClick(Sender: TObject);
Var ObjEntradaCtrl : TEntradaCtrl;
    Continua : Boolean;
begin
  inherited;
  Continua := True;
  If ExigirTagControlados Then Begin
     TDialogService.MessageDialog('Etiquetas Controlados j� impressas?',
                  TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult = mrNo then Begin
           Continua := False;
           Exit;
        End;
      end);
  End;
  if Not Continua then Exit;
  if Not ValidarFinalizacaoComDevolucao_Segregado then Begin
     MensagemStand('Entrada com Segregado/Devolu��o. Solicite Solicite autoriza��o.');
     if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Finalizar com Devolu��o e Segregado') then Begin
        funcaoParaAutorizar := 'Recebimento - Finalizar com Devolu��o e Segregado';
        AtivarPanelSeguranca;
        Exit;
     End;
  End;
  TDialogService.MessageDialog('Finalizar o recebimento ?',
                 TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
     procedure(const AResult: TModalResult)
     begin
       if AResult = mrYes then Begin
          if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger > 0 then Begin
//             ObjEntradaCtrl := TEntradaCtrl.Create;
//             ObjEntradaCtrl.AgrupamentoCheckInReiniciar(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
//             FreeAndNil(ObjEntradaCtrl);
             FatorarCheckInNotas;
          End
          Else Begin
             ObjEntradaCtrl := TEntradaCtrl.Create;
             ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtCodigo.Text, 0);
             FinalizarCheckIn;
             //If FinalizarCheckIn Then ObjEntradaCtrl.RegistrarDocumentoEtapa(5);
             ObjEntradaCtrl.Free;
          End;
       End;
     end);
end;

procedure TFrmEntrada.BtnLogInClick(Sender: TObject);
Var UsuarioJsonArray          : TJsonArray;
    ObjUsuarioAutorizacaoCtrl : TUsuarioCtrl;
    vErro                     : String;
begin

  inherited;
  EXIT;
  if (EdtUsuarioCtrlSeg.Text='') or (EdtSenhaCtrlSeg.Text='') then Begin
     if EdtUsuarioCtrlSeg.Text = '' then
        SetCampoDefault('EdtUsuarioCtrlSeg')
     Else
        SetCampoDefault('EdtSenhaCtrlSeg');
     ShowErro('Informe o Usu�rio e a Senha!');
     Exit;
  End;
  if (Sender=EdtUsuarioCtrlSeg) and (EdtUsuarioCtrlSeg.Text = '') then
     Exit;
  if (Sender=BtnLogIn) and ((EdtUsuarioCtrlSeg.Text = '') or (EdtSenhaCtrlSeg.Text='')) then Begin
     SetCampoDefault('EdtUsuarioCtrlSeg');
     ShowErro('Informe usu�rio e senha.');
     Exit;
  End;
  Try
    EdtSenhaCtrlSeg.TagString := '';
    //ShowLoadingIndicator(Self, True, True, 0.3);
    ksLoadingIndicator1.ShowLoading;
    Application.ProcessMessages;
    ObjUsuarioAutorizacaoCtrl := TUsuarioCtrl.Create;
    UsuarioJsonArray := ObjUsuarioAutorizacaoCtrl.FindUsuario(EdtUsuarioCtrlSeg.Text, 0);
    if UsuarioJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin
       SetCampoDefault('EdtUsuarioCtrlSeg');
       ShowErro('Erro: '+vErro);
    End
    Else if UsuarioJsonArray.Items[0].GetValue<Integer>('usuarioid') = 0 then Begin
       SetCampoDefault('EdtUsuarioCtrlSeg');
       ShowErro('Usu�rio Inv�lido!!!');
    End
    Else if (UsuarioJsonArray.Items[0].GetValue<Integer>('status') = 2) then Begin
       SetCampoDefault('EdtUsuarioCtrlSeg');
       ShowErro('Acesso negado! Usu�rio inativo.');
    End;
    LblUsuarioCtrlSeg.Text      := UsuarioJsonArray.Items[0].GetValue<String>('nome');
    sleep(300);
    if Not ((MD5Texto(EdtSenhaCtrlSeg.Text) = UsuarioJsonArray.Items[0].GetValue<String>('senha'))) Then Begin
       SetCampoDefault('EdtUsuarioCtrlSeg');
       ShowErro('Usu�rio/Senha inv�lido!');
    End;
    ObjUsuarioAutorizacaoCtrl.ObjUsuario.UsuarioId := UsuarioJsonArray.Items[0].GetValue<Integer>('usuarioid');
    if Not (ObjUsuarioAutorizacaoCtrl.AcessoFuncionalidade('Recebimentos - Altera��o Lotes')) then Begin
       SetCampoDefault('EdtUsuarioCtrlSeg');
       ShowErro('Usu�rio n�o autorizado!');
       EdtSenhaCtrlSeg.Text   := '';
    End
    Else Begin
       EdtUsuarioCtrlSeg.Text := '';
       EdtSenhaCtrlSeg.Text   := '';
       AnimaAutorizacao.Inverse := true;
       AnimaAutorizacao.Start;
       ShowOk('Acesso autorizadao!');
       DelayEdSetFocus(EdtDtFabricacao);
    End;
  Except on E : Exception do Begin
    LblUsuarioAut.Text     := '';
    EdtUsuarioCtrlSeg.Text := '';
    EdtSenhaCtrlSeg.Text   := '';
    SetCampoDefault('EdtUsuarioCtrlSeg');
    ShowErro('Erro: ('+DmCLient.RESTResponse1.StatusCode.ToString()+') '+E.Message);
    End;
  End;
  UsuarioJsonArray := Nil;
  ObjUsuarioAutorizacaoCtrl.Free;
  ksLoadingIndicator1.HideLoading;
end;

procedure TFrmEntrada.BtnLoginMasterClick(Sender: TObject);
begin
  inherited;
  If Not permitirVisualizarDivergencia then Begin
     funcaoParaAutorizar := 'Recebimentos - Visualizar Diverg�ncias no CheckIn';
     AtivarPanelSeguranca;
  End;
end;

procedure TFrmEntrada.LoteNovoNaEntrada;
Var ObjLoteCtrl    : TLoteCtrl;
    LotesJsonArray : TJsonArray;
    vErro          : String;
begin
  Try
    ObjLoteCtrl    := TLoteCtrl.Create;
    LotesJsonArray := ObjLoteCtrl.FindLote(FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger, 0, EdtLote.Text, 0);
    if (LotesJsonArray.Count > 0) and (Not LotesJsonArray.TryGetValue('Erro', vErro)) then Begin
       EdtDtFabricacao.Text := LotesJsonArray.Items[0].GetValue<String>('fabricacao');
       EdtDtVencimento.Text := LotesJsonArray.Items[0].GetValue<String>('vencimento');
    End
    Else if LotesJsonArray.Count = 0 then
       ConfirmarNovoLote
    Else
       ActConfirmarNovoLoteExecute(ActConfirmarNovoLote);
  Except On E: Exception do Begin
    SetCampoDefault('EdtLote.Text');
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmEntrada.CbLoteDevSegChange(Sender: TObject);
begin
  inherited;
  if CbLoteDevSeg.ItemIndex < 0 then Exit;
  if FDMemEntradaLotes.Locate('ProdutoId;DescrLote', VarArrayOf([FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger, CbLoteDevSeg.Items[CbLoteDevSeg.ItemIndex]]), []) then Begin
     LblLoteFabricacaoDevSeg.Text := FDMemEntradaLotes.FieldByName('Fabricacao').AsString;
     LblLoteVencimentoDevSeg.Text := FDMemEntradaLotes.FieldByName('Vencimento').AsString;
  End;
end;

procedure TFrmEntrada.CbRastroTipoExit(Sender: TObject);
Var TH : TThread;
begin
  inherited;
  //Incluir controle de acesso
  TH := TThread.CreateAnonymousThread(procedure
  Var ObjProdutoCtrl : TProdutoCtrl;
  begin
    if (CbRastroTipo.ItemIndex+1 <> FdMemEntradaProduto.FieldByName('RastroId').AsInteger) then Begin
       FdMemEntradaProduto.Edit;
       FdMemEntradaProduto.FieldByName('Rastroid').AsInteger := CbRastroTipo.ItemIndex+1;
       FdMemEntradaProduto.Post;
       TThread.Synchronize(TThread.CurrentThread, procedure
       begin
         ValidarSets;
       end);
       ObjProdutoCtrl := TProdutoCtrl.Create;
       ObjProdutoCtrl.AtualizarRastreabilidade(FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger,
                      CbRastroTipo.ItemIndex+1);
       ObjProdutoCtrl.Free;
    End;
  end);
  TH.OnTerminate := ThreadAtualizarRastroTerminate;
  TH.Start;
end;

Function TFrmEntrada.ConfirmarNovoLote : Boolean;
Begin
  Result := False;
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Criar Novo Lote';
  MsgD.Text   := 'Confirma o Lote: '+EdtLote.Text+' ?';
  MsgD.ActionOk   := ActConfirmarNovoLote;
  MsgD.ActionCancel := ActNaoConfirmarNovoLote;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
End;

procedure TFrmEntrada.EdtAlturaValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if StrToFloatDef(TEdit(Sender).Text, 0) > 2000 then Begin
     if Sender = EdtAltura then
        SetCampoDefault('EdtAltura')
     Else
        SetCampoDefault('EdtLargura');
     ShowErro('Medidas fora do padr�o(2Mt)');
     DelayEdSetFocus(TEdit(Sender));
  End;
end;

procedure TFrmEntrada.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  If ((key = 0) and (IntToStr(ord(KeyChar))='0') and (Sender=Edtcodigo)) Then Begin
  {$if defined(Android)}
    i := TJIntent.JavaClass.init;
    i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
    i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
    TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
  {$Endif}
  end;
  case Key of
    vkReturn: Begin
      if Sender = EdtComprimento then Begin
         if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 1 then
            DelayEdSetFocus(EdtQtdUnidPrimCheckIn)
         Else if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 2 then
            DelayEdSetFocus(EdtDtVencimento)
         Else if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 3 then
            DelayEdSetFocus(EdtLote);
      End
      Else Begin
         TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
      End;
      Key     := 0;
      KeyChar := #0;
    End;
    vkTab: Begin
      //TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
      Key := 0;
    End;
  end;
end;

procedure TFrmEntrada.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmEntrada.EdtCodigoValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if (Text = '') then Exit; //or (Not QryListaPadrao.Active) then Exit;
  OpenEntrada;
  permitirVisualizarDivergencia := False;
//  GetEntradaProduto(Text.ToInteger());
end;

procedure TFrmEntrada.EdtCodProdutoDevSegExit(Sender: TObject);
begin
  inherited;
  if EdtCodProdutoDevSeg.Text <> '' then Begin
     if Not FdMemEntradaProduto.Locate('CodProduto', EdtCodProdutoDevSeg.Text, []) then Begin
        vCodProdutoDevSeg := GetCodigoERP(EdtCodProdutoDevSeg.Text);
        if vCodProdutoDevSeg = 0 then Begin
           EdtCodProdutoDevSeg.Text := '';
           DelayEdSetFocus(EdtCodProdutoDevSeg);
           Exit;
        End;
     End
     Else
        vCodProdutoDevSeg := FdMemEntradaProduto.FieldByName('CodProduto').AsInteger;
{     If (FrmeXactWMS.ConfigWMS.SeparacaoCodInterno = 0) and
        (StrToInt64Def(EdtCodProdutoDevSeg.Text, 0) = vCodProdutoDevSeg) then Begin
        SetCampoDefault('EdtCodProdutoDevSeg');
        ShowErro('Scanear o EAN do produto!');
        Exit;
     End;
}
     if Not ValidarCheckInProduto(vCodProdutoDevSeg) then Begin
        EdtCodProdutoDevSeg.Text := '';
        DelayEdSetFocus(EdtCodProdutoDevSeg);
        Exit;
     End;
     ShowDadosProdutosParaDevolucao;
     GetLotesParaDevolucao;
  End;
end;

procedure TFrmEntrada.EdtCodProdutoDevSegKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then  Begin
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     Key := 0;
  End;
end;

procedure TFrmEntrada.EdtCodProdutoDevSegTyping(Sender: TObject);
begin
  inherited;
  LimparDevolucaoSegregado;
end;

procedure TFrmEntrada.EdtCodProdutoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  If (Key = 13) and (EdtCodProduto.Text<> '') then Begin
     //TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     Key     := 0;
     KeyChar := #0;
     ValidarCodProduto;
  End;
end;

procedure TFrmEntrada.EdtCodProdutoTyping(Sender: TObject);
begin
  inherited;
  LimparRct02_Rct03;
end;

procedure TFrmEntrada.EdtComprimentoValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if StrToFloatDef(TEdit(Sender).Text, 0) > 3000 then Begin
     SetCampoDefault('EdtComprimento');
     ShowErro('Medida fora do padr�o(3Mt)!');
  End;
end;

function TFrmEntrada.ValidarCheckInProduto(pCodProdutoCheckIn : Integer): Boolean;
Var xRecno : Integer;
begin
  xRecno := FdMemEntradaProduto.Recno;
  FdMemEntradaProduto.First;
  If (FdMemEntradaProduto.Locate('CodProduto', pCodProdutoCheckin, [])) and
     (FdMemEntradaProduto.FieldByName('QtdXml').AsInteger<=(FdMemEntradaProduto.FieldByName('QtdCheckin').AsInteger+
                                                            FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                                                            FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger)) then Begin
     If PgcPrincipal.ActiveTab = TabCheckIn  then
        SetCampoDefault('EdtCodProduto')
     Else
        SetCampoDefault('EdtCodProdutoDevSeg');
     ShowErro('Produto com CheckIn conclu�do');
     Result := False;
     End
  Else
     Result := True;
  FdMemEntradaProduto.Recno := xRecno;
end;

procedure TFrmEntrada.ValidarCodProduto;
//Var ObjProdutoCtrl : TProdutoCtrl;
Var ObjCodBarrasCtrl  : TProdutoCodBarrasCtrl;
    LstCodBarras      : TObjectList<TProdutoCodBarrasCtrl>;
begin
  inherited;
  if EdtCodProduto.Text = '' then Exit;
  FdMemEntradaProduto.First;
  if Not FdMemEntradaProduto.Locate('CodProduto', EdtCodProduto.Text, [loPartialKey]) then Begin
     vCodProdutoCheckIn := GetCodigoERP(EdtCodProduto.Text);
     if vCodProdutoCheckIn = 0 then Begin
        EdtCodProduto.Text := '';
        DelayEdSetFocus(EdtCodProduto);
        Exit;
     End;
  End
  Else
     vCodProdutoCheckIn := FdMemEntradaProduto.FieldByName('CodProduto').AsInteger;
  If (FrmeXactWMS.ConfigWMS.SeparacaoCodInterno = 0) and
     (StrToInt64Def(EdtCodProduto.Text, 0) = vCodProdutoCheckIn) then Begin
     SetCampoDefault('EdtCodProduto');
     ShowErro('Scanear o EAN do produto!');
     Exit;
  End;
  if Not ValidarCheckInProduto(vCodProdutoCheckIn) then Begin
     EdtCodProduto.Text := '';
     DelayEdSetFocus(EdtCodProduto);
     Exit;
  End;
  ShowDadosProduto;
  ObjCodBarrasCtrl := TProdutoCodBarrasCtrl.Create();
  LstCodBarras := ObjCodBarrasCtrl.GetProdutoCodBarras(0, 0, EdtCodProduto.Text, 0);
  if LstCodBarras.Count > 0 then Begin
     if (FdMemEntradaProduto.FieldbyName('FatorConversao').AsInteger > 1) and
        (LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem = FdMemEntradaProduto.FieldbyName('FatorConversao').AsInteger) then
        EdtQtdUnidSecCheckIn.Text := LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem.ToString()
     Else If LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem > 1 then
        EdtQtdUnidPrimCheckIn.Text := LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem.ToString();
  End;
//        Else
//           EdtQtdUnidPrimCheckIn.Text := LstCodBarras[0].ObjProdutoCodBarras.UnidadesEmbalagem.ToString();
  Rct02DataProduct.Enabled := True;
  Rct03EndCheckIn.Enabled  := True;
  ValidarSets;
  LstCodBarras := Nil;
  ObjCodBarrasCtrl.Free;
end;

function TFrmEntrada.ValidarFinalizacaoComDevolucao_Segregado: Boolean;
begin
  Result := True;
  FdMemEntradaProduto.First;
  FdMemEntradaProduto.Filter   := '(QtdSegregada > 0) or (QtdDevolvida > 0)';
  FdMemEntradaProduto.Filtered := True;
  if (Not FdMemEntradaProduto.IsEmpty) and
     (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Finalizar com Devolu��o e Segregado')) then
     Result := False;
  FdMemEntradaProduto.First;
  FdMemEntradaProduto.Filter   := '';
  FdMemEntradaProduto.Filtered := False;
end;

procedure TFrmEntrada.EdtDtFabricacaoExit(Sender: TObject);
Var vMesEntrada : Integer;
begin
  inherited;
  if (TEdit(Sender).Text = '') or (TEdit(Sender).Text = '  /  /    ') then exit;
  if Length(TEdit(Sender).Text) = 8 then
     TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
  if (Sender = EdtDtVencimento) and ((EdtDtFabricacao.text = '  /  /    ') or
                                     (EdtDtFabricacao.text = '  /  /  ') or
                                     (EdtDtFabricacao.Text='')) Then Begin
     If ((FdMemEntradaProduto.FieldByName('SNGPC').AsInteger = 0) and
         (FdMemEntradaProduto.FieldByName('ZonaSNGPC').AsInteger = 0)) then Begin
        if (StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2) < (StrToInt(Copy(DateToStr(Now()), 7, 4))) then
           EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2).ToString
        Else
           EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(DateToStr(Now()), 7, 4))-2).ToString;
     End
     Else Begin
        SetCampoDefault('EdtDtFabricacao');
        ShowErro('Informe a data de Fabricacao');
        Exit;
     End;
  End;
  Try
    StrToDate(TEdit(Sender).Text);
    if (StrToDate(TEdit(Sender).Text) < StrToDate('01/01/1990')) or
       (StrToDate(TEdit(Sender).Text) > StrToDate('19/08/2130')) then
       if Sender = EdtDtFabricacao then
          raise Exception.Create('Dt.Fabrica��o inv�lida!')
       else raise Exception.Create('Dt.Vencimento inv�lida!');
  Except Begin
    TEdit(Sender).Text := '';
    if Sender = EdtDtFabricacao then Begin
       SetCampoDefault('EdtDtFabricacao');
       ShowErro('Data de Fabrica��o inv�lida');
    End
    Else if Sender = EdtDtVencimento then Begin
       SetCampoDefault('EdtDtFabricacao');
       ShowErro('Data de Fabrica��o inv�lida');
    End;
    End;
  End;
  if ((Sender) = EdtDtFabricacao) and (StrToDate(TEdit(Sender).Text) > Date()) then Begin
     TEdit(Sender).Text := '';
     SetCampoDefault('EdtDtFabricacao');
     ShowErro('Data de Fabrica��o n�o pode ser maior que hoje!');
  End;
  if (Sender = EdtDtVencimento) then Begin
     If (StrToDate(EdtDtVencimento.Text) <= StrToDate(EdtDtFabricacao.Text)) then Begin
        TEdit(Sender).Text := '';
        SetCampoDefault('EdtDtVencimento');
        ShowErro('EdtDtVencimento');
        DelayEdSetFocus(TEdit(Sender));
     End
     Else Begin
        If (StrToDate(EdtDtVencimento.Text)<Now()) then
           raise Exception.Create('N�o � permitido Produto vencido!')
        Else If (StrToDate(EdtDtVencimento.Text)<=StrToDate(EdtDtFabricacao.Text)) then
           raise Exception.Create('Data de vencimento inv�lida!')
        else If DaysBetween(StrToDate(FormatDateTime('dd/mm/yyyy', Now())), StrToDate(EdtDtVencimento.Text)) < (FdMemEntradaProduto.FieldBYname('MesEntradaMinima').AsInteger*30) then Begin
           if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Permitir Recebimento fora do Shelf-Life') then Begin
              vMesEntrada := DaysBetween(StrToDate(FormatDateTime('dd/mm/yyyy', Now())), StrToDate(EdtDtVencimento.Text));
              funcaoParaAutorizar := 'Permitir Recebimento fora do Shelf-Life';
              AtivarPanelSeguranca;
           End;
        End;
     End;
  End;
end;

procedure TFrmEntrada.EdtDtFabricacaoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if TEdit(Sender).Text <> '' then Begin
     TThread.Queue(Nil,
       Procedure
       begin
         TEdit(Sender).Text := ApplyMask('##/##/####', TEdit(Sender).Text);
         TEdit(Sender).CaretPosition := TEdit(Sender).Text.Length;
       End);
  End;
  inherited;
  If (Key = 13) then Begin
     if Sender = EdtDtFabricacao then
        DelayEdSetFocus(EdtDtVencimento)
     Else DelayEdSetFocus(EdtQtdUnidPrimCheckIn);
     Key     := 0;
     KeyChar := #0;
  End;
end;

procedure TFrmEntrada.EdtDtFabricacaoTyping(Sender: TObject);
begin
  inherited;
  exit;

  if TEdit(Sender).Text = '' then Exit;
  TThread.Queue(Nil,
    Procedure
    begin
      TEdit(Sender).Text := ApplyMask('##/##/####', TEdit(Sender).Text);
      TEdit(Sender).CaretPosition := TEdit(Sender).Text.Length;
    End);
end;

procedure TFrmEntrada.EdtDtVencimentoValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
//  DelayEdSetFocus(EdtQtdUnidPrimCheckIn);
end;

procedure TFrmEntrada.EdtLoteEnter(Sender: TObject);
begin
  inherited;
  if EdtLote.ReadOnly then
     DelayEdSetFocus(EdtDtFabricacao);
end;

procedure TFrmEntrada.EdtLoteExit(Sender: TObject);
begin
  inherited;
  if EdtLote.Text <> '' then begin
     If Not ValidarLote(EdtLote.Text) then Begin
        SetCampoDefault('EdtLote');
        ShowErro('Erro: Lote inv�lido!');
        Exit;
     End;
     If FDMemEntradaLotes.Locate('CodProduto; DescrLote', VarArrayOf([vCodProdutoCheckIn, EdtLote.Text]), []) then Begin
        EdtDtFabricacao.Text := FdMemEntradaLotes.FieldByName('Fabricacao').AsString;
        EdtDtVEncimento.Text := FdMemEntradaLotes.FieldByName('Vencimento').AsString;
        DelayEdSetFocus(EdtDtFabricacao);
     End
     Else
        LoteNovoNaEntrada;
  End;
end;

procedure TFrmEntrada.EdtLoteKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = 13) then Begin
     //TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     DelayEdSetFocus(EdtDtFabricacao);
     Key     := 0;
     KeyChar := #0;
  End;
end;

procedure TFrmEntrada.EdtLoteTyping(Sender: TObject);
begin
  inherited;
  EdtDtFabricacao.Text := '';
  EdtDtVencimento.Text := '';
end;

procedure TFrmEntrada.EdtPesoValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if StrToFloatDef(TEdit(Sender).Text, 0) > 50000 then Begin
     SetCampoDefault('EdtPeso');
     ShowErro('Peso fora do padr�o(50Kg)');
  End;
end;

procedure TFrmEntrada.EdtPickingKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = 13) or (key = vkTab) then Begin
     if Not EdtPeso.ReadOnly then
        DelayEdSetFocus(EdtPeso)
     Else if Not EdtLote.ReadOnly then
        DelayEdSetFocus(EdtLote)
     Else Begin
        if CbRastroTipo.ItemIndex = 0 then
           DelayEdSetFocus(EdtQtdUnidPrimCheckIn)
        Else if CbRastroTipo.ItemIndex = 1 then
           DelayEdSetFocus(EdtDtVencimento)
        Else
           DelayEdSetFocus(EdtLote);
     End;
  End;
end;

procedure TFrmEntrada.EdtPickingValidate(Sender: TObject; var Text: string);
Var ObjEnderecoCtrl   : TEnderecoCtrl;
    EnderecoJsonArray : TJsonArray;
    ProdutoJsonArray  : TjsonArray;
    ObjProdutoCtrl    : TProdutoCtrl;
    vCodProduto       : Integer;
    vErro : String;
begin
  inherited;
  if (EdtPicking.Text <> '') and (EdtPicking.Text <> FdMemEntradaProduto.FieldByName('Picking').AsString) then Begin
        Try
          ObjEnderecoCtrl  := TEnderecoCtrl.Create;
          EnderecoJsonArray := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EnderecoMask(EdtPicking.Text, '', False), EnderecoMask(EdtPicking.Text, '', False), 'T', 2, 0, 0);
          if (EnderecoJsonArray.Items[0].TryGetValue('Erro', vErro)) or (EnderecoJsonArray.Count < 1) then Begin
             SetCampoDefault('EdtPicking');
             ShowErro('Endere�o '+EnderecoMask(EdtPicking.Text, '', False)+' n�o encontrado!');
             EdtPicking.Text := '';
          End
          Else If EnderecoJsonArray.Items[0].GetValue<Integer>('status') = 0 then Begin
             SetCampoDefault('EdtPicking');
             ShowErro('Endere�o('+EnderecoMask(EdtPicking.Text, '', True)+') inativo!');
             EdtPicking.Text := '';
          End
          Else If EnderecoJsonArray.Items[0].GetValue<Integer>('bloqueado') = 1 then Begin
             SetCampoDefault('EdtPicking');
             ShowErro('Endere�o('+EnderecoMask(EdtPicking.Text, '', True)+') bloqueado para uso!');
             EdtPicking.Text := '';
          End
          Else if ((EnderecoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> 0) and
                  ((EnderecoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger) then Begin
             vCodProduto := EnderecoJsonArray.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
             EdtPicking.Text := '';
             DelayEdSetFocus(EdtPicking);
             raise Exception.Create('Picking em uso. Produto: '+vCodProduto.ToString());
          End
          Else Begin //Alterar picking do produto
            FdMemEntradaProduto.Edit;
            FdMemEntradaProduto.FieldByName('EnderecoId').AsInteger := EnderecoJsonArray.Items[0].GetValue<Integer>('enderecoid');
            FdMemEntradaProduto.FieldByName('picking').AsString     := EnderecoJsonArray.Items[0].GetValue<String>('descricao');
            FdMemEntradaProduto.FieldByName('ZonaSNGPC').AsInteger  := EnderecoJsonArray.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('produtosngpc');
            ObjProdutoCtrl := TProdutoCtrl.Create;
            ProdutoJsonArray := ObjProdutoCtrl.EnderecarProduto(FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger, FdMemEntradaProduto.FieldByName('EnderecoId').AsInteger);
            if Not ProdutoJsonArray.Items[0].TryGetValue('Erro', vErro) then
               FdMemEntradaProduto.Post
            Else
               FdMemEntradaProduto.Cancel;
            ProdutoJsonArray := Nil;
            ObjProdutoCtrl.Free;
          End;
          //EdtPicking.Text := EnderecoMask(EdtPicking.Text, FdMemEntradaProduto.FieldByName('Mascara').AsString, True);
          EnderecoJsonArray := Nil;
          ObjEnderecoCtrl.Free;
        Except On E: Exception do  Begin
          If Assigned(EnderecoJsonArray) Then
             EnderecoJsonArray := Nil;
          If Assigned(ObjEnderecoCtrl) then
             ObjEnderecoCtrl.Free;
          raise Exception.Create('Erro: '+EnderecoMask(EdtPicking.Text, '', False)+sLineBreak+E.Message);
          End;
        End;
  End;
end;

procedure TFrmEntrada.EdtQtdeDevSegKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (key = 13) and (StrtoIntDef(EdtQtdeDevSeg.Text, 0)>0) then Begin
     If CbCausaDevolucaoSegregado.ItemIndex >= 0 then
        SbSalvarDevSegClick(SbSalvarDevSeg)
     Else
        DelayEdSetFocus(CbCausaDevolucaoSegregado);
  End;
end;

procedure TFrmEntrada.EdtQtdUnidPrimCheckInKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
Var vQtdDig : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if (key = 13)  then Begin
     if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
        vQtdDig := TEdit(Sender).Text;
        TEdit(Sender).Text := '';
        raise Exception.Create('Quantidade('+vQtdDig+') inv�lida!');
     End;
     SbSalvarCheckInClick(EdtQtdUnidPrimCheckIn);
  End;
end;

procedure TFrmEntrada.EdtQtdUnidPrimCheckInTyping(Sender: TObject);
begin
  inherited;
  EdtQtdTotCheckIn.Text := (strToIntDef(EdtQtdUnidPrimCheckIn.Text, 0) + (StrToIntDef(EdtQtdUnidSecCheckIn.Text, 0)*StrToIntDef(EdtFatorConversao.Text, 1))).ToString();
end;

procedure TFrmEntrada.EdtSenhaCtrlSegKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
//  inherited;

end;

procedure TFrmEntrada.EdtSenhaCtrlSegValidate(Sender: TObject;
  var Text: string);
begin
  //inherited;
end;

procedure TFrmEntrada.EdtUsuarioCtrlSegKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
//  inherited;

end;

procedure TFrmEntrada.EdtUsuarioCtrlSegValidate(Sender: TObject;
  var Text: string);
begin
//  inherited;

end;

function TFrmEntrada.ExigirTagControlados: Boolean;
Var teste : Integer;
begin
  Result := False;
  FdMemEntradaProduto.First;
  If FrmeXactWMS.ConfigWMS.TagProdutoEntrada in [ 2, 3 ] Then Begin
     while Not FdMemEntradaProduto.Eof do Begin
       if ((FrmeXactWMS.ConfigWMS.TagProdutoEntrada = 2) and ((StrToIntDef(FdMemEntradaProduto.FieldByName('EnderecoId').AsString, 0) = 0) or
          (FdMemEntradaProduto.FieldByName('ZonaSNGPC').AsInteger = 1))) or
          ((FrmeXactWMS.ConfigWMS.TagProdutoEntrada = 3) and (FdMemEntradaProduto.FieldByName('Sngpc').AsInteger = 1)) then
          Result := True;
       FdMemEntradaProduto.Next;
     End;
  End;
end;

//Fatorar Checkin por Agrupamento  - 02 Janeiro 2025
Function TFrmEntrada.FatorarCheckInNotas : Boolean;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayAgrupamentoLoteXML    : TJsonArray;
    JsonArrayLotesCheckIn          : TJsonArray;
    JsonArrayProdutoCheckIn        : TJsonArray;
    JsonArrayAgrupamentoCheckIn    : TJsonArray;
    JsonArrayValidarCheckIn        : TJsonArray;
    vQtdeLote, vProdutoId, vLoteId : Integer;
    vQtdCheckIn, vQtdDevolvida, vQtdSegregada : Integer;
    vSaldoDivergente : Integer;
    JsonArrayListaPedido : TJsonArray;
    JsonObjectEntrada    : TJsonObject;
    xListaPedido   : Integer;
    vFinalizarErro : Integer;
    vErro          : String;
    xRecno         : Integer;
    vSaldoLoteAgrupado : integer;
    JsonArrayFinalizacaoRetorno : TJsonArray;

    vRecnoAgrupamento, vRecnoItens : integer;

    Function MontarJsonCheckIn(pPedidoId, pPedidoItemId, pQtdCheckIn, pQtdDevolvida, pQtdSegregada : Integer) : Boolean;
    Var JsonObjectPedido, JsonObjectCheckIn, JsonRetorno : TJsonObject;
        JsonArrayCheckIn  : TJsonArray;
    Begin
      JsonObjectPedido := TJsonObject.Create;
      JsonObjectPedido.AddPair('pedido', TJSONNumber.Create(pPedidoId));
      JsonObjectPedido.AddPair('operacaoid', TJSONNumber.Create(0));
      JsonObjectPedido.AddPair('operacaodescricao', '');
      JsonArrayCheckIn  := TJsonArray.Create;
      JsonObjectCheckIn := TJsonObject.Create;
      JsonObjectCheckIn.AddPair('entradaitemid', tJSONNumber.Create(pPedidoItemId));
      JsonObjectCheckIn.AddPair('produtoid',     tJSONNumber.Create(FDMemAgrupamentoCheckIn.FieldByName('produtoid').AsInteger));
      JsonObjectCheckIn.AddPair('loteid',        tJSONNumber.Create(FDMemAgrupamentoCheckIn.FieldByName('LoteId').AsInteger));
      JsonObjectCheckIn.AddPair('descrlote',     FDMemAgrupamentoCheckIn.FieldByName('DescrLote').AsString);
      JsonObjectCheckIn.AddPair('fabricacao',    DateEUAtoBr( FDMemAgrupamentoCheckIn.FieldByName('Fabricacao').AsString));
      JsonObjectCheckIn.AddPair('vencimento',    DateEUAtoBr(FDMemAgrupamentoCheckIn.FieldByName('Vencimento').AsString));
      JsonObjectCheckIn.AddPair('dtentrada',     DateEUAtoBr(FDMemAgrupamentoCheckIn.FieldByName('Data').AsString));//
      JsonObjectCheckIn.AddPair('hrentrada',     Copy(FDMemAgrupamentoCheckIn.FieldByName('Hora').AsString, 1, 8));
      JsonObjectCheckIn.AddPair('qtdxml',        tJSONNumber.Create(0)); //FDMemAgrupamentoCheckIn.FieldByName('QtdXml').AsInteger));
      JsonObjectCheckIn.AddPair('qtdcheckin',    tJSONNumber.Create(pQtdCheckIn));
      JsonObjectCheckIn.AddPair('qtddevolvida',  tJSONNumber.Create(pQtdDevolvida));
      JsonObjectCheckIn.AddPair('causaid',       tJSONNumber.Create(FDMemAgrupamentoCheckIn.FieldByName('CausaId').AsInteger));
      JsonObjectCheckIn.AddPair('qtdsegregada',  tJSONNumber.Create(pQtdSegregada));
      JsonObjectCheckIn.AddPair('usuarioid',     tJSONNumber.Create(FDMemAgrupamentoCheckIn.FieldByName('usuarioId').AsInteger));
      JsonObjectCheckIn.AddPair('respaltloteid', tJSONNumber.Create(StrToIntDef(FDMemAgrupamentoCheckIn.FieldByName('RespAltLote').AsString, 0)));
      {$IfDef Android}
         JsonObjectCheckIn.AddPair('terminal', IMEI); //IMEI;   //Substitu�do estacao por terminal em 18/03/2021
      {$else}
         JsonObjectCheckIn.AddPair('terminal', NomeDoComputador);
      {$Endif}

      JsonArrayCheckIn.AddElement(JsonObjectCheckIn);
      JsonObjectPedido.AddPair('itens', JsonArrayCheckIn);
      //Pegar Retorno e Analisar
      ObjEntradaCtrl := TEntradaCtrl.Create;
      JsonRetorno := ObjEntradaCtrl.SalvarCheckInItem(0, JsonObjectPedido);
      If JsonRetorno.TryGetValue('Erro', vErro) then Begin
         HideLoading;
         MensagemStand('Erro Ped: '+pPedidoId.ToString+' '+'Prod: '+ FDMemAgrupamentoCheckIn.FieldByName('produtoid').AsString+' '+vErro);
      End;
    End;
begin
  ShowLoading;
//  ksLoadingIndicator1.ShowLoading;
//Validar necessidade de imprimir Etiqueta de Controlados
  Result := False;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  //Desfazer tentativa anterior de Checkin Agrupado
  JsonArrayAgrupamentoCheckIn := ObjEntradaCtrl.AgrupamentoCheckInReiniciar(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  If JsonArrayAGrupamentoCheckIn.Items[0].TryGetValue('Erro', vErro) then Begin
     HideLoading;
     ShowErro('Erro: '+vErro);
     Exit;
  End;
  //Validar Quantidade Divergentes Entre QtdXML da NF e Qtd.CheckIn Agrupada
{  JsonArrayValidarCheckIn  := ObjEntradaCtrl.ValidarCheckInAgrupamentoFinalizar(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  If Not JsonArrayAGrupamentoCheckIn.Items[0].TryGetValue('Erro', vErro) then Begin
     HideLoading;
     ShowErro('Erro: Diverg�ncia na quantidade do XML X CheckIn!');
     Exit;
  End;
}
//-- 1o) Checkin Agrupado
//Buscar todos os Itens no Checkin Agrupado --PedidoItensCheckInAgrupamento
  JsonArrayAgrupamentoCheckIn := Nil;
  JsonArrayAgrupamentoCheckIn := ObjEntradaCtrl.GetAgrupamentoCheckIn(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  If JsonArrayAGrupamentoCheckIn.Items[0].TryGetValue('Erro', vErro) then Begin
     HideLoading;
     ShowErro('Erro: '+vErro);
     Exit;
  End;
  If FDMemAgrupamentoCheckIn.Active then
     FDMemAgrupamentoCheckIn.EmptyDataSet;
  FDMemAgrupamentoCheckIn.Close;
  FDMemAgrupamentoCheckIn.LoadFromJSON(JsonArrayAgrupamentoCheckIn, False);
//2o) Itens Para CheckIn - PedidoitensCheckIn
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonArrayLotesCheckIn := ObjEntradaCtrl.GetAgrupamentoFatorarPedidoLotes(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  If JsonArrayLotesCheckIn.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     Exit;
  End;
  If FDMemLotesCheckIn.Active then Begin
     FDMemLotesCheckIn.EmptyDataSet;
     FDMemLotesCheckIn.FieldDefs.Clear;
  End;
  FDMemLotesCheckIn.Close;
  FDMemLotesCheckIn.LoadFromJSON(JsonArrayLotesCheckIn, False);
  FDMemLotesCheckIn.First;

  //Distribuir Lotes Checkin Agrupamento para a Tabela PedidoItens
  FDMemAgrupamentoCheckIn.First;
  FdMemAgrupamentoCheckIn.Filter   := '(LoteExiste = 1)';// and (QtdCheckIn+QtdDevolvida+QtdSegregada>0) and (ProdutoId = 35157)';
  FdMemAgrupamentoCheckIn.Filtered := True;

  vRecnoAgrupamento := FDMemAgrupamentoCheckIn.RecordCount;
  vRecnoItens       := FDMemLotesCheckIn.RecordCount;
  While (Not FDMemAgrupamentoCheckIn.Eof) Do Begin //and (FDMemAgrupamentoCheckIn.FieldByName('ProdutoId').AsInteger= 35157) do Begin //CheckIn Agrupamento
    vProdutoId    := FDMemAgrupamentoCheckIn.FieldByName('ProdutoId').AsInteger;
    vLoteId       := FDMemAgrupamentoCheckIn.FieldByName('LoteId').AsInteger;
    vSaldoLoteAgrupado := (FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger+      //PedidoItens
                                                      FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger+
                                                      FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger);
    FDMemLotesCheckIn.First;
    if FDMemLotesCheckIn.Locate('LoteId', vLoteId, []) then begin
      repeat
        If FDMemLotesCheckIn.FieldByName('QtdXml').AsInteger > (FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger+
                                                                FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger+
                                                                FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger) then Begin
           vSaldoDivergente := FDMemLotesCheckIn.FieldByName('QtdXml').AsInteger-(FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger+
                                                                                  FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger+
                                                                                  FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger);
           If FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger > 0 then Begin //CheckIn
              If (vSaldoDivergente >= FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger) then Begin
                 FDMemLotesCheckIn.Edit;
                 FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger := FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger+FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger;
                 MontarJsonChecKIn(FDMemLotesCheckIn.FieldByName('PedidoId').AsInteger, FDMemLotesCheckIn.FieldByName('PedidoItemId').AsInteger, FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger, 0, 0);
                 FDMemAgrupamentoCheckIn.Edit;
                 FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger := 0;
              End
              Else Begin
                 FDMemLotesCheckIn.Edit;
                 FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger := FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger+vSaldoDivergente;
                 FDMemAgrupamentoCheckIn.Edit;
                 FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger := FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger - vSaldoDivergente;
                 MontarJsonChecKIn(FDMemLotesCheckIn.FieldByName('PedidoId').AsInteger, FDMemLotesCheckIn.FieldByName('PedidoItemId').AsInteger, vSaldoDivergente, 0, 0);
              End;
           End;

           vSaldoDivergente := FDMemLotesCheckIn.FieldByName('QtdXml').AsInteger-(FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger+
                                                                                  FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger+
                                                                                  FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger);
           If (FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger > 0) and (vSaldoDivergente > 0) then Begin //Devolucao
              If (vSaldoDivergente >= FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger) then Begin
                 FDMemLotesCheckIn.Edit;
                 FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger := FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger+FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger;
                 MontarJsonChecKIn(FDMemLotesCheckIn.FieldByName('PedidoId').AsInteger, FDMemLotesCheckIn.FieldByName('PedidoItemId').AsInteger, 0, FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger, 0);
                 FDMemAgrupamentoCheckIn.Edit;
                 FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger := 0;
              End
              Else Begin
                 FDMemLotesCheckIn.Edit;
                 FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger := FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger+vSaldoDivergente;
                 FDMemAgrupamentoCheckIn.Edit;
                 FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger := FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger - vSaldoDivergente;
                 MontarJsonChecKIn(FDMemLotesCheckIn.FieldByName('PedidoId').AsInteger, FDMemLotesCheckIn.FieldByName('PedidoItemId').AsInteger, 0, vSaldoDivergente, 0);
              End;
           End;

           vSaldoDivergente := FDMemLotesCheckIn.FieldByName('QtdXml').AsInteger-(FDMemLotesCheckIn.FieldByName('QtdCheckIn').AsInteger+
                                                                                  FDMemLotesCheckIn.FieldByName('QtdDevolvida').AsInteger+
                                                                                  FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger);
           If (FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger > 0) and (vSaldoDivergente > 0) then Begin //Segregado
              If (vSaldoDivergente >= FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger) then Begin
                 FDMemLotesCheckIn.Edit;
                 FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger := FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger+FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger;
                 MontarJsonChecKIn(FDMemLotesCheckIn.FieldByName('PedidoId').AsInteger, FDMemLotesCheckIn.FieldByName('PedidoItemId').AsInteger, 0, 0, FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger);
                 FDMemAgrupamentoCheckIn.Edit;
                 FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger := 0;
              End
              Else Begin
                 FDMemLotesCheckIn.Edit;
                 FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger := FDMemLotesCheckIn.FieldByName('QtdSegregada').AsInteger+vSaldoDivergente;
                 FDMemAgrupamentoCheckIn.Edit;
                 FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger := FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger - vSaldoDivergente;
                 MontarJsonChecKIn(FDMemLotesCheckIn.FieldByName('PedidoId').AsInteger, FDMemLotesCheckIn.FieldByName('PedidoItemId').AsInteger, 0, 0, vSaldoDivergente);
              End;
           End;
        End;
        vSaldoLoteAgrupado := (FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger+      //PedidoItens
                               FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger+
                               FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger);
        FDMemLotesCheckIn.Next;
      until (FDMemLotesCheckIn.Eof) or (FDMemLotesCheckIn.FieldByName('LoteId').AsInteger <> vLoteId) or (vSaldoLoteAgrupado<=0) or (vSaldoLoteAgrupado >= FDMemLotesCheckIn.FieldByName('QtdXml').AsInteger);
    end;
    FDMemAgrupamentoCheckIn.Next;
  End;
  //3o) CheckIn Produtos Com Saldo(QtdXml) incompleto
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonArrayProdutoCheckIn := ObjEntradaCtrl.GetAgrupamentoFatorarProduto(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  If Not JsonArrayProdutoCheckIn.Items[0].TryGetValue('Erro', vErro) then Begin
     If FDMemProdutoCheckIn.Active then Begin
        FDMemProdutoCheckIn.EmptyDataSet;
        FdMemProdutoCheckIn.FieldDefs.Clear;
     End;
     FDMemProdutoCheckIn.Close;
     FDMemProdutoCheckIn.LoadFromJSON(JsonArrayProdutoCheckIn, False); //Produto da tabela Pedidoitens com saldo incompleto
     xRecno := FDMemProdutoCheckIn.RecordCount;
     FDMemAgrupamentoCheckIn.Filter   := '';
     FDMemAgrupamentoCheckIn.Filtered := False;
     FDMemAgrupamentoCheckIn.First; //Produto da tabela PeditoItensCheckInAgrupamento com saldo para completar a tabela PedidoItens
  End;
  Var vCodProduto : integer;
  while (Not FDMemAgrupamentoCheckIn.Eof) do Begin
    vCodproduto := FDMemAgrupamentoCheckIn.FieldByName('ProdutoId').AsInteger;
    FDMemAgrupamentoCheckIn.Next;
  End;
  FDMemAgrupamentoCheckIn.First;

  while (Not FDMemAgrupamentoCheckIn.Eof) do Begin
    If (FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger+
                                                      FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger+
                                                      FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger) > 0 then Begin
       vProdutoId    := FDMemAgrupamentoCheckIn.FieldByName('ProdutoId').AsInteger;
       vLoteId       := FDMemAgrupamentoCheckIn.FieldByName('LoteId').AsInteger;
       vSaldoLoteAgrupado := (FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger+      //PedidoItens
                                                         FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger+
                                                         FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger);
       If (DebugHook<>0) and (vProdutoId = 74334) then
          xRecno := FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger;
       if FDMemProdutoCheckIn.Locate('ProdutoId', vProdutoId, []) then begin
         repeat
           If FDMemProdutoCheckIn.FieldByName('QtdXml').AsInteger > (FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger) then Begin
              vSaldoDivergente := FDMemProdutoCheckIn.FieldByName('QtdXml').AsInteger-FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger;
              If FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger > 0 then Begin //CheckIn
                 If (vSaldoDivergente >= FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger) then Begin
                    FDMemProdutoCheckIn.Edit;
                    FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger+FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger;
                    MontarJsonChecKIn(FDMemProdutoCheckIn.FieldByName('PedidoId').AsInteger, 0, FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger, 0, 0);
                    FDMemAgrupamentoCheckIn.Edit;
                    FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger := 0;
                 End
                 Else Begin
                    FDMemProdutoCheckIn.Edit;
                    FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger+vSaldoDivergente;
                    FDMemAgrupamentoCheckIn.Edit;
                    FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger := FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger - vSaldoDivergente;
                    MontarJsonChecKIn(FDMemProdutoCheckIn.FieldByName('PedidoId').AsInteger, 0, vSaldoDivergente, 0, 0);
                 End;
              End;
              vSaldoDivergente := FDMemProdutoCheckIn.FieldByName('QtdXml').AsInteger-FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger;
              If (FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger > 0) and (vSaldoDivergente > 0) then Begin //Devolucao
                 If (vSaldoDivergente >= FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger) then Begin
                    FDMemProdutoCheckIn.Edit;
                    FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger+FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger;
                    MontarJsonChecKIn(FDMemProdutoCheckIn.FieldByName('PedidoId').AsInteger, 0, 0, FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger, 0);
                    FDMemAgrupamentoCheckIn.Edit;
                    FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger := 0;
                 End
                 Else Begin
                    FDMemProdutoCheckIn.Edit;
                    FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger+vSaldoDivergente;
                    FDMemAgrupamentoCheckIn.Edit;
                    FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger := FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger - vSaldoDivergente;
                    MontarJsonChecKIn(FDMemProdutoCheckIn.FieldByName('PedidoId').AsInteger, 0, 0, vSaldoDivergente, 0);
                 End;
              End;

              vSaldoDivergente := FDMemProdutoCheckIn.FieldByName('QtdXml').AsInteger-FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger;
              If (FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger > 0) and (vSaldoDivergente > 0) then Begin //Segregado
                 If (vSaldoDivergente >= FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger) then Begin
                    FDMemProdutoCheckIn.Edit;
                    FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger+FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger;
                    MontarJsonChecKIn(FDMemProdutoCheckIn.FieldByName('PedidoId').AsInteger, 0, 0, 0, FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger);
                    FDMemAgrupamentoCheckIn.Edit;
                    FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger := 0;
                 End
                 Else Begin
                    FDMemProdutoCheckIn.Edit;
                    FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdCheckInTotal').AsInteger+vSaldoDivergente;
                    FDMemAgrupamentoCheckIn.Edit;
                    FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger := FDMemProdutoCheckIn.FieldByName('QtdSegregada').AsInteger - vSaldoDivergente;
                    MontarJsonChecKIn(FDMemProdutoCheckIn.FieldByName('PedidoId').AsInteger, 0, 0, 0, vSaldoDivergente);
                 End;
              End;
           End;
           vSaldoLoteAgrupado := (FDMemAgrupamentoCheckIn.FieldByName('QtdCheckIn').AsInteger+      //PedidoItens
                                                     FDMemAgrupamentoCheckIn.FieldByName('QtdSegregada').AsInteger+
                                                     FDMemAgrupamentoCheckIn.FieldByName('QtdDevolvida').AsInteger);
           FDMemProdutoCheckIn.Next;
         until (FDMemProdutoCheckIn.Eof) or (FDMemProdutoCheckIn.FieldByName('ProdutoId').AsInteger <> vProdutoId) or (vSaldoLoteAgrupado<=0) // or (vSaldoLoteAgrupado >= FDMemProdutoCheckIn.FieldByName('QtdXml').AsInteger);;
       end
       Else Begin
          HideLoading;
          ShowErro('Produto: '+FdMemAgrupamentoCheckIn.FieldByName('CodProduto').AsString+' n�o encontrado!');
          Exit;
       End;
    End;
    FDMemAgrupamentoCheckIn.Next;
  End;
//Finalizando as Notas
  JsonObjectEntrada := TJsonObject.Create;
  With JsonObjectEntrada do Begin
    AddPair('agrupamentoid', TJSONNumber.Create( QryListaPadrao.FieldByName('AgrupamentoId').AsInteger ));
    AddPair('operacaoid', TJSONNumber.Create(0));
    AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    {$IfDef Android}
       AddPair('terminal', IMEI); //IMEI;
    {$else}
       AddPair('terminal', NomeDoComputador);
    {$Endif}
  End;
  JsonArrayFinalizacaoRetorno := ObjEntradaCtrl.FinalizarAgrupamentonotas(JsonObjectEntrada);
  If JsonArrayFinalizacaoRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else Begin
     EdtCodigo.Text := '';
     ShowOk('Check-In finalizado!');
     TDialogService.MessageDialog('Check-In finalizado!',
                    TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        begin
          if AResult = mrOk then
             Limpar;
        end);
     Limpar;
     PgcPrincipal.ActiveTab := TabLista;
     Result := True;
  End;
  HideLoading;
//  ksLoadingIndicator1.HideLoading;
end;

Function TFrmEntrada.FinalizarCheckIn : Boolean;
var ObjEntradaCtrl             : TEntradaCtrl;
    jsonObjEnt, jsonObjEntItem : TJSONObject;
    jsonArrayEntItem           : TJSONArray;
    xEntItens                  : Integer;
begin
  inherited;
  Result := False;
  jsonObjEnt := TJSONObject.Create;
  With jsonObjEnt do Begin
    AddPair('pedido', TJSONNumber.Create(StrToIntDef(EdtCodigo.Text, 0)));
    AddPair('operacaoid', TJSONNumber.Create(3));
    AddPair('operacaodescricao', '');
    addPair('usuarioid', tJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
   {$IfDef Android}
      AddPair('terminal', IMEI); //IMEI;   //Substitu�do estacao por terminal em 18/03/2021
   {$else}
      AddPair('terminal', NomeDoComputador);
   {$Endif}
  End;
  // Itens...
  jsonArrayEntItem := TJSONArray.Create;
  FdMemEntradaLotes.First;
  While Not FdMemEntradaLotes.Eof do Begin
    jsonObjEntItem := TJSONObject.Create;
    With jsonObjEntItem do Begin
      AddPair('entradaitemid', tJSONNumber.Create(FdMemEntradaLotes.FieldByName('pedidoitemid').AsInteger));
      AddPair('produtoid',     tJSONNumber.Create(FdMemEntradaLotes.FieldByName('ProdutoId').AsInteger));
      AddPair('loteid',        tJSONNumber.Create(FdMemEntradaLotes.FieldByName('LoteId').AsInteger));
      AddPair('descrlote',     FdMemEntradaLotes.FieldByName('DescrLote').AsString);
      AddPair('fabricacao',    DateToStr(FdMemEntradaLotes.FieldByName('Fabricacao').AsDateTime));
      AddPair('vencimento',    DateToStr(FdMemEntradaLotes.FieldByName('Vencimento').AsDateTime));
      AddPair('dtentrada',     DateToStr(FdMemEntradaLotes.FieldByName('dtentrada').AsDateTime));
      AddPair('hrentrada',     Copy(FdMemEntradaLotes.FieldByName('hrentrada').AsString, 1, 8));
      AddPair('qtdxml',        tJSONNumber.Create(FdMemEntradaLotes.FieldByName('QtdXml').AsInteger));
      AddPair('qtdcheckin',    tJSONNumber.Create(FdMemEntradaLotes.FieldByName('QtdCheckIn').AsInteger));
      AddPair('qtddevolvida',  tJSONNumber.Create(FdMemEntradaLotes.FieldByName('QtdDevolvida').AsInteger));
      AddPair('qtdsegregada',  tJSONNumber.Create(FdMemEntradaLotes.FieldByName('QtdSegregada').AsInteger));
      AddPair('usuarioid',     tJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    End;
    jsonArrayEntItem.AddElement(jsonObjEntItem);
    FdMemEntradaLotes.Next;
  End;
  jsonObjEnt.AddPair('itens', jsonArrayEntItem);
  ObjEntradaCtrl := TEntradaCtrl.Create;
  ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtCodigo.Text, 0);
  If ObjEntradaCtrl.FinalizarCheckIn(jsonObjEnt) then Begin
     //ObjEntradaCtrl.RegistrarDocumentoEtapa(5);
     EdtCodigo.Text := '';
     Result := False;
     ShowOk('Check-In finalizado!');
     TDialogService.MessageDialog('Check-In finalizado!',
                    TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        begin
          if AResult = mrOk then
             Limpar;
        end);
     Limpar;
     PgcPrincipal.ActiveTab := TabLista;
  End
  Else Begin
     Result := False;
     ShowErro('N�o foi poss�vel Finalizar o CheckIn!');
  End;
  //Linhas abaixo alteradas em 23/02/2023
  //jsonObjEnt.Free;
  jsonArrayEntItem.DisposeOf;//.Free;
  ObjEntradaCtrl.Free;
end;

procedure TFrmEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmEntrada := Nil;
end;

procedure TFrmEntrada.FormCreate(Sender: TObject);
begin
  EventCreate := True;
  CircleStatus.Visible := False;
  LblAtivo.Visible     := False;
  inherited;
  //PgcPrincipal.ActiveTab := TabLista;
  //GetListaLstCadastro;
  //PgcPrincipal.tabs[2].Visible := False;
  TipoAutorizarAlteracaoLote := TTipoAutorizarAlteracaoLote(FrmeXactWMS.ConfigWMS.AutorizarAltLote);
  BtnLoginMaster.Visible     := Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimentos - Visualizar Diverg�ncias no CheckIn');
  GetProdutoControle;
  GetSegregadoCausa;
end;

Function TFrmEntrada.GetCodigoERP(pCodProduto: String) : Integer;
Var ObjProdutoCtrl    : TProdutoCtrl;
    JsonArrayRetorno  : TJsonArray;
    vErro             : String;
begin
  Result := 0;
  ObjProdutoCtrl := TProdutoCtrl.Create();
  JsonArrayRetorno := ObjProdutoCtrl.FindProduto('0', pCodProduto, '', 0, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     If PgcPrincipal.ActiveTab = TabCheckIn then
        SetCampoDefault('EdtCodProduto')
     Else
        SetCampoDefault('EdtCodProdutoDevSeg');
     ShowErro('Codigo de produto inv�lido!!!');
  End
  Else Begin
    Result := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto');
    FdMemEntradaProduto.First;
    if Not FdMemEntradaProduto.Locate('CodProduto', Result, [loPartialKey]) then Begin
       Result := 0;
       If PgcPrincipal.ActiveTab = TabCheckIn then
          SetCampoDefault('EdtCodProduto')
       Else
          SetCampoDefault('EdtCodProdutoDevSeg');
       ShowErro('Produto n�o pertence a este CheckIn!');
    End
  End;
  JsonArrayRetorno := Nil;
  ObjProdutoCtrl.Free;
end;

procedure TFrmEntrada.GetEntradaLotes(pPedidoId, pAgrupamentoId : Integer);
Var ObjEntradaCtrl : TEntradaCtrl;
    LotesJsonArray      : TJsonArray;
    vErro : String;
begin
   ObjEntradaCtrl := TEntradaCtrl.Create;
   LotesJsonArray := ObjEntradaCtrl.GetEntradaLotes(pPedidoId, pAgrupamentoId, 0, 0);
   if LotesJsonArray.Items[0].TryGetValue('Erro', vErro) then begin
      LotesJsonArray := Nil;
      ObjEntradaCtrl.Free;
      raise Exception.Create(vErro);
   end;
   If FDMemEntradaLotes.Active then
      FDMemEntradaLotes.EmptyDataSet;
   FDMemEntradaLotes.Close;
   FDMemEntradaLotes.LoadFromJSON(LotesJsonArray, False);
   LotesJsonArray := Nil;
   ObjEntradaCtrl.Free;
end;

function TFrmEntrada.GetEntradaProduto(pPedidoId, pAgrupamentoId : Integer): TJsonArray;
Var xLista           : Integer;
    Th               : TThread;
begin
  ShowLoading;
  Th := TThread.CreateAnonymousThread(procedure
  Var JsonArrayProduto    : TJsonArray;
      LotesJsonArray      : TJsonArray;
      vErro               : String;
      ObjEntradaCtrl : TEntradaCtrl;
      vCodProduto : Integer;
      xRecno : Integer;
  Begin
    ObjEntradaCtrl   := TEntradaCtrl.Create;
    JsonArrayProduto := ObjEntradaCtrl.GetEntradaProduto(IfThen(pAgrupamentoId=0, pPedidoId, 0), pAgrupamentoId);
    if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then begin
       JsonArrayProduto := Nil;
       ObjEntradaCtrl.Free;
       raise Exception.Create(vErro);
    end;
    If FdMemEntradaProduto.Active then Begin
       FdMemEntradaProduto.EmptyDataSet;
       FdMemEntradaProduto.FieldDefs.clear;
    End;
    FdMemEntradaProduto.Close;
    FdMemEntradaProduto.LoadFromJSON(JsonArrayProduto, False);
    xRecno := FdMemEntradaProduto.RecordCount;
    vCodProduto := FdMemEntradaProduto.FieldByName('CodProduto').AsInteger;
    //Buscar os Lotes
    If FDMemEntradaLotes.Active then Begin
       FDMemEntradaLotes.EmptyDataSet;
       FdMemEntradalotes.FieldDefs.clear;
    End;
    FDMemEntradaLotes.Close;
    LotesJsonArray := ObjEntradaCtrl.GetEntradaLotes(IfThen(pAgrupamentoId=0, pPedidoId, 0), pAgrupamentoId, 0, 0);
    if Not LotesJsonArray.Items[0].TryGetValue('Erro', vErro) then begin
       FDMemEntradaLotes.LoadFromJSON(LotesJsonArray, False);
    End
    Else Begin
       Raise Exception.Create('Erro(51 - AGNF): '+vErro);
       Limpar;
       Exit;
    End;

{       LotesJsonArray := Nil;
       ObjEntradaCtrl.Free;
       raise Exception.Create(vErro);
    end;
}
    FDMemEntradaLotes.Open;
    xRecno := FdMemEntradaLotes.RecordCount;
    vCodProduto := FdMemEntradaProduto.FieldByName('CodProduto').AsInteger;
    LotesJsonArray := Nil;
    TThread.Synchronize(TThread.CurrentThread, procedure
    Var item : TListViewItem;
        txt  : TListItemText;
        img, ImgBtnCancelarCheckIn, ImgBtn  : TListItemImage;
        vQtdXml, vQtdCheckIn, vQtdDevolvida, vQtdSegregado : Integer;
    begin
      LstEntradaProduto.BeginUpdate;
      LstEntradaProduto.Items.Clear;
      FdMemEntradaProduto.First;
      vQtdXml       := 0;
      vQtdCheckIn   := 0;
      vQtdDevolvida := 0;
      vQtdSegregado := 0;
      While Not FdMemEntradaProduto.Eof do Begin
        item := LstEntradaProduto.Items.Add;
        item.Objects.Clear;
        item.Tag := FdMemEntradaProduto.FieldByName('CodProduto').AsLargeInt;
        TThread.Synchronize(TThread.CurrentThread, procedure
        begin
          with item do begin
            img := TListItemImage(Objects.FindDrawable('ImgFdoProduto'));
            img.ScalingMode := TImageScalingMode.Stretch;
            if ((FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+
                 FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                 FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger) >= FdMemEntradaProduto.FieldByName('QtdXml').AsInteger) then
               img.Bitmap := IMgLstFdoGreen.Bitmap
            Else if ((FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+
                FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger) > 0) then
               img.Bitmap := ImgLstFdoYellow.Bitmap
            Else If FdMemEntradaProduto.RecNo Mod 2 = 0 Then begin       //Inicializado
               img.Bitmap := ImgFdoGrid01.Bitmap;
               //Cor:= $FF5DA9BC;
            End
            Else Begin  //Em Contagem
               img.Bitmap := ImgFdoGrid02.Bitmap;
               //Cor:= $FFE9C168;
            End;
            txt := TListItemText(Objects.FindDrawable('CodProduto'));
            txt.Text := FdMemEntradaProduto.FieldByName('CodProduto').AsString;

            txt := TListItemText(Objects.FindDrawable('Descricao'));
            txt.Text := FdMemEntradaProduto .FieldByName('Descricao').AsString;

            txt := TListItemText(Objects.FindDrawable('Picking'));
            txt.Text := //FdMemEntradaProduto.FieldByName('Picking').AsString;
                        EnderecoMask(FdMemEntradaProduto.FieldByName('Picking').AsString, FdMemEntradaProduto.FieldByName('Mascara').AsString, True);
            txt := TListItemText(Objects.FindDrawable('CheckIn'));
            txt.Text := FdMemEntradaProduto.FieldByName('QtdCheckIn').AsString;
            txt := TListItemText(Objects.FindDrawable('Segregada'));
            txt.Text := FdMemEntradaProduto.FieldByName('QtdSegregada').AsString;
            txt := TListItemText(Objects.FindDrawable('Devolvida'));
            txt.Text := FdMemEntradaProduto.FieldByName('QtdDevolvida').AsString;
            if (Not BtnLoginMaster.Visible) or (permitirVisualizarDivergencia) then Begin
               txt := TListItemText(Objects.FindDrawable('QtdXml')); //Substituir QtdXml por Diverg�ncia
               txt.Text := FdMemEntradaProduto.FieldByName('QtdXml').AsString;
            End;
            ImgBtnCancelarCheckIn := TListItemImage(Objects.FindDrawable('ImgBtnCancelarCheckIn'));
            ImgBtnCancelarCheckIn.ScalingMode := TImageScalingMode.Stretch;
            ImgBtnCancelarCheckIn.Bitmap := ImgLstRecycledChocolate.Bitmap;
            ImgBtnCancelarCheckIn.TagString := FdMemEntradaProduto.FieldByName('CodProduto').AsString;

            ImgBtn := TListItemImage(Objects.FindDrawable('ImgBtnDevSeg'));
            ImgBtn.ScalingMode := TImageScalingMode.Stretch;
            ImgBtn.Bitmap := ImgDevSeg.Bitmap;
            ImgBtn.TagString := FdMemEntradaProduto.FieldByName('CodProduto').AsString;
            vQtdXml       := vQtdXml       + FdMemEntradaProduto.FieldByName('QtdXml').AsInteger;
            vQtdCheckIn   := vQtdCheckIn   + FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger;
            vQtdDevolvida := vQtdDevolvida + FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger;
            vQtdSegregado := vQtdSegregado + FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger;
         End;
        End);
        FdMemEntradaProduto.Next;
      End;
      LytRodapeFinalizar.Visible  := vQtdCheckIn + vQtdDevolvida + vQtdSegregado > 0;
      BtnAbortarCheckIn.Visible   := vQtdCheckIn + vQtdDevolvida + vQtdSegregado > 0;
      BtnFinalizarCheckIn.Visible := (vQtdCheckIn + vQtdDevolvida + vQtdSegregado) >= vQtdXml;
    End);
    JsonArrayProduto := Nil;
    //LotesJsonArray   := Nil;
    ObjEntradaCtrl.Free;
  End);
  Th.OnTerminate := ThreadTerminateProduto;
  Th.Start;
end;

{function TFrmEntrada.GetListaEntrada(pPedidoId, pPessoaId: Integer; pDocumento,
  pRazao, pRegistroERP: String; pDtNotaFiscal : TDateTime; pPendente: Integer; pAgrupamentoId : Integer): Boolean;
Var xLista           : Integer;
    Th               : TThread;
begin
   Result := True;
   ShowLoading;
   TTask.Create(
    procedure()
    Var JsonArrayEntrada : TJsonArray;
       vErro            : String;
       ObjEntradaCtrl   : TEntradaCtrl;
    begin
      ObjEntradaCtrl   := TEntradaCtrl.Create;
      JsonArrayEntrada := ObjEntradaCtrl.GetEntradaBasica(pPedidoId, pPessoaId, PDocumento, pRazao, pRegistroERP, 0, 1, pAgrupamentoId, 0);
      if JsonArrayEntrada.Items[0].TryGetValue('Erro', vErro) then begin
         JsonArrayEntrada := Nil;
         ObjEntradaCtrl.Free;
         raise Exception.Create('Erro ao Buscar as Entradas.'+vErro);
      end;
      If QryListaPadrao.Active then
         QryListaPadrao.EmptyDataSet;
      QryListaPadrao.Close;
      QryListaPadrao.LoadFromJSON(JsonArrayEntrada, False);
      TThread.Synchronize(Nil, procedure
       Var item : TListViewItem;
           txt  : TListItemText;
           img  : TListItemImage;
       begin
         LstPrincipal.ScrollTo(0);
         LstPrincipal.BeginUpdate;
         LstPrincipal.Items.Clear;
         QryListaPadrao.First;
         While Not QryListaPadrao.Eof do Begin
           item := LstPrincipal.Items.Add;
           item.Objects.Clear;
           item.Tag := QryListaPadrao.FieldByName('PedidoId').AsLargeInt;
           with item do begin
             img := TListItemImage(Objects.FindDrawable('ImgFdoPedido'));
             img.ScalingMode := TImageScalingMode.Stretch;
             If QryListaPadrao.FieldByName('Status').AsInteger > 0 Then       //Inicializado
                img.Bitmap := ImgLstFdoYellow.Bitmap
             Else
                img.Bitmap := ImgFdoGrid01.Bitmap;
             txt := TListItemText(Objects.FindDrawable('PedidoId'));
             txt.Text := QryListaPadrao.FieldByName('PedidoId').AsString;

             txt := TListItemText(Objects.FindDrawable('Documento'));
             txt.Text := QryListaPadrao .FieldByName('DocumentoNr').AsString;

             txt := TListItemText(Objects.FindDrawable('Data'));
             txt.Text := QryListaPadrao.FieldByName('DocumentoData').AsString;
             txt := TListItemText(Objects.FindDrawable('Fornecedor'));
             txt.Text := QryListaPadrao.FieldByName('Razao').AsString;
             txt := TListItemText(Objects.FindDrawable('AgrupamentoId'));
             txt.Text := QryListaPadrao.FieldByName('AgrupamentoId').AsString;
             txt := TListItemText(Objects.FindDrawable('BtnOpenEntrada'));
             txt.TagString := QryListaPadrao.FieldByName('PedidoId').AsString;
           End;
            QryListaPadrao.Next;
         End;
       End);
       JsonArrayEntrada := Nil;
       ObjEntradaCtrl.Free;
    End);
end;
}
function TFrmEntrada.GetListaEntrada(pPedidoId, pPessoaId: Integer; pDocumento,
  pRazao, pRegistroERP: String; pDtNotaFiscal : TDateTime; pPendente: Integer; pAgrupamentoId : Integer; pCodProduto : String): Boolean;
Var Th               : TThread;
    JsonArrayEntrada : TJsonArray;
    vErro            : String;
    ObjEntradaCtrl   : TEntradaCtrl;    item : TListViewItem;
    txt  : TListItemText;
    img  : TListItemImage;
begin
   Result := True;
   ShowLoading;
//   Th := TThread.CreateAnonymousThread(procedure
//   Var JsonArrayEntrada : TJsonArray;
//       vErro            : String;
//       ObjEntradaCtrl   : TEntradaCtrl;
//   Begin
     ObjEntradaCtrl   := TEntradaCtrl.Create;
     JsonArrayEntrada := ObjEntradaCtrl.GetEntradaBasica(pPedidoId, pPessoaId, PDocumento,
                         pRazao, pRegistroERP, 0, 1, pAgrupamentoId, pCodProduto);
     if JsonArrayEntrada.Items[0].TryGetValue('Erro', vErro) then begin
        JsonArrayEntrada := Nil;
        ObjEntradaCtrl.Free;
        HideLoading;
        ShowErro(vErro);
        Exit;
     end;
     If QryListaPadrao.Active then
        QryListaPadrao.EmptyDataSet;
     QryListaPadrao.Close;
     QryListaPadrao.LoadFromJSON(JsonArrayEntrada, False);

      //TThread.Synchronize(TThread.CurrentThread, procedure
      //Var item : TListViewItem;
      //    txt  : TListItemText;
      //    img  : TListItemImage;
      //begin
       LstPrincipal.ScrollTo(0);
       LstPrincipal.BeginUpdate;
       LstPrincipal.Items.Clear;
       QryListaPadrao.First;
       While Not QryListaPadrao.Eof do Begin
         item := LstPrincipal.Items.Add;
         item.Objects.Clear;
         item.Tag := QryListaPadrao.FieldByName('PedidoId').AsLargeInt;
         with item do begin
           img := TListItemImage(Objects.FindDrawable('ImgFdoPedido'));
           img.ScalingMode := TImageScalingMode.Stretch;
           If QryListaPadrao.FieldByName('Status').AsInteger > 0 Then       //Inicializado
              img.Bitmap := ImgLstFdoYellow.Bitmap
           Else
              img.Bitmap := ImgFdoGrid01.Bitmap;
           txt := TListItemText(Objects.FindDrawable('PedidoId'));
           txt.Text := QryListaPadrao.FieldByName('PedidoId').AsString;

           txt := TListItemText(Objects.FindDrawable('Documento'));
           txt.Text := QryListaPadrao .FieldByName('DocumentoNr').AsString;

           txt := TListItemText(Objects.FindDrawable('Data'));
           txt.Text := QryListaPadrao.FieldByName('DocumentoData').AsString;
           txt := TListItemText(Objects.FindDrawable('Fornecedor'));
           txt.Text := QryListaPadrao.FieldByName('Razao').AsString;
           txt := TListItemText(Objects.FindDrawable('AgrupamentoId'));
           txt.Text := QryListaPadrao.FieldByName('AgrupamentoId').AsString;
           txt := TListItemText(Objects.FindDrawable('BtnOpenEntrada'));
           txt.TagString := QryListaPadrao.FieldByName('PedidoId').AsString;
         End;
          QryListaPadrao.Next;
       End;
       LstPrincipal.EndUpdate;
//     End);
     JsonArrayEntrada := Nil;
     ObjEntradaCtrl.Free;
     HideLoading;
//   End);
//   Th.OnTerminate := ThreadTerminatePrincipal;
//   Th.Start;
end;

procedure TFrmEntrada.GetListaLstCadastro;
begin
  inherited;
  GetListaEntrada;
end;

procedure TFrmEntrada.GetLotesParaDevolucao;
begin
  FDMemEntradaLotes.First;
  FDMemEntradaLotes.Filter     := 'Produtoid = '+FdMemEntradaProduto.FieldByName('ProdutoId').AsString+' and QtdXML > 0';
  FDMemEntradaLotes.Filtered := True;
  CbLoteDevSeg.Items.Clear;
  while Not FDMemEntradaLotes.Eof do Begin
    CbLoteDevSeg.Items.Add(FDMemEntradaLotes.FieldByName('DescrLote').AsString);
    FDMemEntradaLotes.Next;
  End;
  FDMemEntradaLotes.Filter     := '';
  FDMemEntradaLotes.Filtered := False;
end;

procedure TFrmEntrada.GetProdutoControle;
Var xCount       : Integer;
    ArrayRetorno : TJsonArray;
begin
  inherited;
  DmClient.RESTRequest1.ResetToDefaults;
  DmClient.RESTResponse1.ResetToDefaults;
  DmClient.RESTResponseDataSetAdapter1.Response := Nil;
  With dmClient.RESTRequest1 do Begin
    Resource  := 'v1/rastro';
    Method    := RmGet;
    Execute;
    if (dmClient.RESTResponse1.StatusCode = Ok200) or (dmClient.RESTResponse1.StatusCode = Ok201) Then Begin
        CbRastroTipo.Items.Clear;
        ArrayRetorno := DmClient.RESTResponse1.JSONValue as TJsonArray;
        For xCount := 0 to Pred(ArrayRetorno.Count) do
          CbRastroTipo.Items.Add(ArrayRetorno.Items[xCount].GetValue<String>('rastroId')+' '+ArrayRetorno.Items[xCount].GetValue<String>('descricao'));
        ArrayRetorno := Nil;
    End;
  End;
end;

procedure TFrmEntrada.GetSegregadoCausa;
Var JsonArrayRetorno : TJsonArray;
    ObjSegregaCausaCtrl : TSegregadoCausaCtrl;
    vErro : String;
begin
  If FdMemSegregadoCausa.Active then
     FdMemSegregadoCausa.EmptyDataSet;
  FdMemSegregadoCausa.Close;
  ObjSegregaCausaCtrl := TSegregadoCausaCtrl.Create;
  JsonArrayRetorno := ObjSegregaCausaCtrl.GetSegregadoCausa(0, '', 1);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Aten~��o: '+vErro)
  Else Begin
     FDMemSegregadoCausa.LoadFromJSON(JsonArrayRetorno, False);
     CbCausaDevolucaoSegregado.Items.Clear;
     FDMemSegregadoCausa.First;
     while Not FDMemSegregadoCausa.Eof do Begin
       CbCausaDevolucaoSegregado.Items.Add(FDMemSegregadoCausa.FieldByName('Descricao').AsString);
       FDMemSegregadoCausa.Next;
     End;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjSegregaCausaCtrl);
end;

procedure TFrmEntrada.LiberarFuncaoBloqueada;
begin
  inherited;
  if funcaoParaAutorizar = 'Recebimentos - Visualizar Diverg�ncias no CheckIn' then Begin
  End
  Else if funcaoParaAutorizar = 'Permitir Recebimento fora do Shelf-Life' then Begin
    DelayEdSetFocus(EdtQtdUnidPrimCheckIn);
  End;
  if funcaoParaAutorizar = 'Recebimentos - Altera��o Lotes' then
     DelayEdSetFocus(EdtDtFabricacao);
end;

procedure TFrmEntrada.Limpar;
begin
  inherited;
  EdtDocumentoNr.Text   := '';
  EdtDocumentoData.Text := '';
  EdtFornecedor.Text    := '';
  If FdMemEntradaProduto.Active then
     FdMemEntradaProduto.EmptyDataSet;
  FdMemEntradaProduto.Close;
  If FdMemEntradaLotes.Active then
     FdMemEntradaLotes.EmptyDataSet;
  FdMemEntradaLotes.Close;
  LstEntradaProduto.Items.Clear;
  LstEntradaItens.Items.Clear;
  LytCheckInDigitacao.Enabled := False;
  LimparRct02_Rct03;
  CbCampoPesq.ItemIndex := 2;
  BtnAbortarCheckIn.Visible   := False;
  BtnFinalizarCheckIn.Visible := False;
end;

procedure TFrmEntrada.LimparDevolucaoSegregado;
begin
  CbTipoMovimentacaoDevSeg.ItemIndex  := -1;
  CbLoteDevSeg.ItemIndex              := -1;
  CbCausaDevolucaoSegregado.ItemIndex := -1;
  LblLoteFabricacaoDevSeg.Text        := '...';
  LblLoteVencimentoDevSeg.Text        := '...';
  EdtPickingDevSeg.Text               := '';
  EdtDescricaoDevSeg.Text             := '';
  EdtQtdeDevSeg.Text                  := '';
end;

procedure TFrmEntrada.LimparRct02_Rct03;
begin
  EdtPicking.Text            := '';
  StcSngpc.IsChecked         := False;
  EdtDescricao.Text          := '';
  LblRastro.Text             := '...';
  //EdtEmbalagemSecId.Text     := '';
  //LblEmbalagem.Text          := '';
  CbRastroTipo.ItemIndex     := -1;
  EdtFatorConversao.Text     := '';
  EdtPeso.Text               := '';
  EdtAltura.Text             := '';
  EdtLargura.Text            := '';
  EdtComprimento.Text        := '';
  EdtVolume.Text             := '';
  EdtLote.Text               := '';
  EdtDtFabricacao.Text       := '';
  EdtDtVencimento.Text       := '';
  EdtQtdUnidPrimCheckIn.Text := '';
  EdtQtdUnidSecCheckIn.Text  := '';
  EdtQtdTotCheckIn.Text      := '';
  if FdMemEntradaProduto.Active then
     FdMemEntradaProduto.First;
  if FdMemEntradaLotes.Active then
     FDMemEntradaLotes.First;
  Rct02DataProduct.Enabled   := False;
  Rct03EndCheckIn.Enabled    := False;
  DelayEdSetFocus(EdtCodProduto);
end;

procedure TFrmEntrada.LstEntradaProdutoItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  inherited;
  If ItemObject.Name = 'ImgBtnDevSeg' then Begin
     PgcPrincipal.ActiveTab := TabDevolucaoSegregado;
     LimparDevolucaoSegregado;
     PreencherDevolucaoSegregado(LstEntradaProduto.Items[ItemIndex].Tag.ToString);

  End
  Else If ItemObject.Name = 'ImgBtnCancelarCheckIn' then Begin
     TDialogService.MessageDialog('Cancelar o CheckIn (' +
                                  LstEntradaProduto.Items[ItemIndex].Tag.ToString + ') ?',
                    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        Var ObjEntradaItensCtrl : TEntradaItensCtrl;
            ReturnJsonArray     : TJsonArray;
            vErro : String;
        begin
          if AResult = mrYes then Begin
            ObjEntradaItensCtrl := TEntradaItensCtrl.Create;
            ReturnJsonArray := ObjEntradaItensCtrl.CancelarCheckInProduto(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger,
                               IfThen(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger=0, QryListaPadrao.FieldByName('PedidoId').AsInteger, 0),
                               LstEntradaProduto.Items[ItemIndex].Tag);
            if ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then
               ShowErro('Erro: '+vErro)
            Else GetEntradaProduto(QryListaPadrao.FieldByName('PedidoId').AsInteger, QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);;
            ReturnJsonArray := Nil;
            ObjEntradaItensCtrl.Free;
          End;
        end);
  End
end;

procedure TFrmEntrada.LstPrincipalButtonClick(const Sender: TObject;
  const AItem: TListItem; const AObject: TListItemSimpleControl);
begin
  inherited;
  if Assigned(AItem) then Begin
     EdtCodigo.Text := '';
     EdtCodigo.Text := AObject.TagString;
     BtnArrowRigth.Action := ChgTabCheckIn;
  End;
end;

procedure TFrmEntrada.LstPrincipalDblClick(Sender: TObject);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstPrincipal.Items[ LstPrincipal.ItemIndex ].Objects.FindDrawable('PedidoId'));
//  EdtConteudoPesq.text := TxtItem.Text;
  EdtCodigo.Text := '';
  EdtCodigo.Text := TListItemText(LstPrincipal.Items[ LstPrincipal.ItemIndex ].Objects.FindDrawable('PedidoId')).Text;
  BtnArrowRigth.Action := ChgTabCheckIn;
end;

procedure TFrmEntrada.OpenEntrada;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayEntrada : TjsonArray;
    vErro            : String;
begin
  if Not QryListaPadrao.Active then Begin
    ObjEntradaCtrl   := TEntradaCtrl.Create;
    JsonArrayEntrada := ObjEntradaCtrl.GetEntradaBasica(StrToIntDef(EdtCodigo.Text, 0), 0, '', '', '', 0, 1, 0, '');
    if JsonArrayEntrada.Items[0].TryGetValue('Erro', vErro) then begin
       JsonArrayEntrada := Nil;
       ObjEntradaCtrl.Free;
       SetCampoDefault('EdtCodigo');
       ShowErro(vErro);
       Exit;
    end;
    If QryListaPadrao.Active then
       QryListaPadrao.EmptyDataSet;
    QryListaPadrao.Close;
    QryListaPadrao.LoadFromJSON(JsonArrayEntrada, False);
    JsonArrayEntrada := Nil;
    ObjEntradaCtrl.Free;
  End;
  If QryListaPadrao.Locate('PedidoId', EdtCodigo.Text, [loPartialKey]) Then Begin
     if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger > 0 then begin
        LblDocumento.Text   := 'Agrupamento';
        EdtDocumentoNr.Text := QryListaPadrao.FieldByName('AgrupamentoId').AsString;
     End
     Else Begin
        LblDocumento.Text   := 'Documento Nr';
        EdtDocumentoNr.Text := QryListaPadrao.FieldByName('DocumentoNr').AsString;
     End;
     EdtDocumentoData.Text := QryListaPadrao.FieldByName('DocumentoData').AsString;
     EdtFornecedor.Text    := QryListaPadrao.FieldByName('Razao').AsString;
     EdtPedidoId_CheckIn.Text    := EdtCodigo.Text;
     EdtDocumentoNr_CheckIn.Text := EdtDocumentoNr.Text;
     StartEntrada := True;
     GetEntradaProduto(QryListaPadrao.FieldByName('PedidoId').AsInteger, QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
     PgcPrincipal.ActiveTab := TabDetalhes;
     LytCheckInDigitacao.Enabled := True;
     BtnArrowRigth.Action := ChgTabCheckIn;
     DelayEdSetFocus(EdtCodigo);
  End
  Else Begin
     SetCampoDefault('EdtCodigo');
     ShowErro('Recebimento('+EdtCodigo.Text+') n�o encontradao!');
  End;
end;

procedure TFrmEntrada.PermitirAcessoCtrlSeg;
Var ObjEntradaCtrl : TEntradaCtrl;
begin
  inherited;
  //if Not funcaoParaAutorizar_Liberada then Exit;
  if funcaoParaAutorizar = 'Recebimentos - Visualizar Diverg�ncias no CheckIn' then Begin
     permitirVisualizarDivergencia := True;
     GetEntradaProduto(QryListaPadrao.FieldByName('PedidoId').AsInteger, QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  End
  Else if funcaoParaAutorizar = 'Permitir Recebimento fora do Shelf-Life' then Begin
     permitirVisualizarDivergencia := True;
     DelayEdSetFocus(EdtQtdUnidPrimCheckIn);
  End
  Else if funcaoParaAutorizar = 'Permitir Recebimento fora do Shelf-Life' then Begin
     permitirVisualizarDivergencia := True;
     DelayEdSetFocus(EdtDtFabricacao);
  End
  Else If funcaoParaAutorizar = 'Recebimento - Finalizar com Devolu��o e Segregado' then Begin
     TDialogService.MessageDialog('Finalizar o recebimento ?',
                 TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
     procedure(const AResult: TModalResult)
     begin
       if AResult = mrYes then Begin
          if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger > 0 then
             FatorarCheckInNotas
          Else Begin
             ObjEntradaCtrl := TEntradaCtrl.Create;
             ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtCodigo.Text, 0);
             If FinalizarCheckIn Then
                ObjEntradaCtrl.RegistrarDocumentoEtapa(5);
             ObjEntradaCtrl.Free;
          End;
       End;
     end);
  End;
end;

function TFrmEntrada.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if pConteudo = '0' then raise Exception.Create('conte�do inv�lido para pesquisar!');
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then Begin
        SetCampoDefault('CbCampoPesq');
        ShowErro('Selecione o campo para procurar!');
        CbCampoPesq.SetFocus;
        Exit;
     End
     Else If (CbCampoPesq.ItemIndex = 5) then Begin
       Try
         StrToDate(EdtConteudoPesq.Text);
       Except
         SetCampoDefault('EdtConteudoPesq');
         ShowErro('Data Inv�lida para pesquisa.');
         Exit;
       End;
     End;
     Try
       if CbCampoPesq.ItemIndex = 0 then //0 Id
          if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
             Result := GetListaEntrada(StrToInt(EdtConteudoPesq.Text), 0, '', '', '', 0, 0, 0, '0')
          else raise Exception.Create('Id inv�lido para pesquisar!')
       Else if (CbCampoPesq.ItemIndex = 1) and (StrToIntDef(EdtConteudoPesq.Text, 0)>0) then //C�digo ERP
          Result := GetListaEntrada(0, StrToInt(EdtConteudoPesq.Text), '', '', '', 0, 0, 0, '0')
       Else if CbCampoPesq.ItemIndex = 2 then //Documento Nr
          Result := GetListaEntrada(0, 0, EdtConteudoPesq.Text, '', '', 0, 0, 0, '0')
       Else if CbCampoPesq.ItemIndex = 3 then //Razao
          Result := GetListaEntrada(0, 0, '', EdtConteudoPesq.Text, '', 0, 0, 0, '0')
       Else if CbCampoPesq.ItemIndex = 4 then //RegistroERP
          Result := GetListaEntrada(0, 0, '', '', EdtConteudoPesq.Text, 0, 0, 0, '0')
       Else if CbCampoPesq.ItemIndex = 5 then //Data Nota Fiscal
          Result := GetListaEntrada(0, 0, '', '', '', StrToDate(EdtConteudoPesq.Text), 0, 0, '0')
       Else if CbCampoPesq.ItemIndex = 6 then //Agrupamento
          Result := GetListaEntrada(0, 0, '', '', '', 0, 0, StrToIntDef(EdtConteudoPesq.Text, 0), '0')
       Else if CbCampoPesq.ItemIndex = 7 then //Agrupamento
          Result := GetListaEntrada(0, 0, '', '', '', 0, 0, 0, EdtConteudoPesq.Text);
     Except On E: Exception do  Begin
        SetCampoDefault('EdtConteudo');
        ShowErro('Erro: '+E.Message);
        End;
     End;
     EdtConteudoPesq.Text := '';
  End;
end;

procedure TFrmEntrada.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if (PgcPrincipal.ActiveTab = TabLista) then Begin
     BtnArrowRigth.Action := ChgTabDet;
     BtnArrowLeft.Action  := Nil;
     //If Not EventCreate then GetListaEntrada;
     EventCreate := False;
  End
  Else if (PgcPrincipal.ActiveTab = TabDetalhes) then Begin
     if FdMemEntradaProduto.RecordCount > 0 then
        BtnArrowRigth.Action := ChgTabCheckIn
     Else BtnArrowRigth.Action := Nil;
     BtnArrowLeft.Action  := ChgTabLista;
     DelayEdSetFocus(EdtCodigo);
  End
  Else If (PgcPrincipal.ActiveTab = TabCheckIn) then Begin
     BtnArrowLeft.Action  := ChgTabDet;
     BtnArrowRigth.Action := ChgTabItens;
     BtnArrowRigth.Enabled := True;
     DelayEdSetFocus(EdtCodProduto);
     //GetEntradaItens;
  End
  Else If (PgcPrincipal.ActiveTab = TabItens) then Begin
     BtnArrowLeft.Action  := ChgTabCheckIn;
     BtnArrowRigth.Action := ChgTabDet;
     BtnArrowRigth.Enabled := True;
     //GetEntradaItens;
  End
  Else If (PgcPrincipal.ActiveTab = TabDevolucaoSegregado) then Begin
     BtnArrowLeft.Action  := ChgTabDet;
     BtnArrowRigth.Action := ChgTabItens;
     BtnArrowRigth.Enabled := True;
     //GetEntradaItens;
  End;
end;

procedure TFrmEntrada.PreencherDevolucaoSegregado(pCodProduto : String);
begin
  FdMemEntradaProduto.First;
  If (FdMemEntradaProduto.Locate('CodProduto', pCodProduto, [])) then Begin
     EdtPedidoIdDevSeg.Text      := EdtCodigo.Text;
     EdtDocumentoNrDevSeg.Text   := EdtDocumentoNr.Text;
     EdtDocumentoDataDevSeg.Text := EdtDocumentoData.Text;
     EdtCodProdutoDevSeg.Text := pCodProduto;
     ShowDadosProdutosParaDevolucao;
     DelayEdSetFocus(EdtCodProdutoDevSeg);
     EdtCodProdutoDevSegExit(EdtCodProdutoDevSeg);
  End;
end;

Function TFrmEntrada.SaveItemCheckIn(pQtdDevolvida, pQtdSegregada, pCausaId : Integer) : Boolean;  //Enviar Dados para Base de Dados
var jsonObjEnt, jsonObjEntItem : TJSONObject;
    jsonArrayEntItem           : TJSONArray;
    jsonRetorno                : TJsonObject;
    vErro : String;
    ObjEntradaCtrl             : TEntradaCtrl;
begin
  Result := False;
  Try
    JsonObjEnt := TJSONObject.Create;
    if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger = 0 then With jsonObjEnt do Begin
      AddPair('pedido', TJSONNumber.Create(StrToIntDef(EdtPedidoId_CheckIn.Text, 0)));
      AddPair('operacaoid', TJSONNumber.Create(0));
      AddPair('operacaodescricao', '');
    End
    Else With jsonObjEnt do Begin
      AddPair('agrupamentoid', tJSONNumber.Create(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger));
    End;
    // Itens...
    jsonArrayEntItem := TJSONArray.Create;
    jsonObjEntItem := TJSONObject.Create;
    With jsonObjEntItem do Begin
      if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger = 0 then Begin
         AddPair('entradaitemid', tJSONNumber.Create(FdMemEntradaLotes.FieldByName('pedidoitemid').AsInteger));
      End
      Else
         AddPair('agrupamentoid', tJSONNumber.Create(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger));
      AddPair('produtoid',     tJSONNumber.Create(FdMemEntradaProduto.FieldByName('produtoid').AsInteger));
      AddPair('loteid',        tJSONNumber.Create(FdMemEntradaLotes.FieldByName('LoteId').AsInteger));
      AddPair('descrlote',     FdMemEntradaLotes.FieldByName('DescrLote').AsString);
      AddPair('fabricacao',    DateToStr(FdMemEntradaLotes.FieldByName('Fabricacao').AsDateTime));
      AddPair('vencimento',    DateToStr(FdMemEntradaLotes.FieldByName('Vencimento').AsDateTime));
      if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger = 0 then Begin
         AddPair('dtentrada',     DateToStr(Date()));
         AddPair('hrentrada',     TimeToStr(time()));
         AddPair('qtdxml',        tJSONNumber.Create(FdMemEntradaLotes.FieldByName('QtdXml').AsInteger));
      End;
      AddPair('qtdcheckin',    tJSONNumber.Create(StrToIntDef(EdtQtdTotCheckIn.Text, 0)));
      AddPair('qtddevolvida',  tJSONNumber.Create(pQtdDevolvida));
      AddPair('qtdsegregada',  tJSONNumber.Create(pQtdSegregada));
      AddPair('causaid', TJsonNumber.Create(pCausaId)); //Causa da Devolu��o ou Segregado
      AddPair('usuarioid',     tJSONNumber.Create(FrmeXactWMS.ObjusuarioCtrl.ObjUsuario.UsuarioId));
      AddPair('respaltloteid', tJSONNumber.Create(vUsuarioAutorizadorUpdLote)); //ObjUsuarioAltLoteCtrl.ObjUsuario.Usuarioid));
      {$IfDef Android}
         AddPair('terminal', IMEI); //IMEI;   //Substitu�do estacao por terminal em 18/03/2021
      {$else}
         AddPair('terminal', NomeDoComputador);
      {$Endif}
      vUsuarioAutorizadorUpdLote := 0;
    End;
    jsonArrayEntItem.AddElement(jsonObjEntItem);
    jsonObjEnt.AddPair('itens', jsonArrayEntItem);
    //Pegar Retorno e Analisar
    ObjEntradaCtrl := TEntradaCtrl.Create;

    jsonRetorno := ObjEntradaCtrl.SalvarCheckInItem(QryListaPadrao.FieldByName('AgrupamentoId').AsInteger, JsonObjEnt);

    if (not jsonRetorno.TryGetValue<String>('Erro', vErro)) then Begin
       If (QryListaPadrao.FieldByName('AgrupamentoId').AsInteger=0) Then Begin
          FdMemEntradaLotes.Edit;
          FdMemEntradaLotes.FieldByName('PedidoItemId').AsInteger := jsonRetorno.GetValue<Integer>('pedidoitemid');
          FdMemEntradaLotes.FieldByName('LoteId').AsInteger        := jsonRetorno.GetValue<Integer>('loteid');
          FdMemEntradaLotes.FieldByName('DtEntrada').AsDateTime    := StrToDate(jsonObjEntItem.GetValue<String>('dtentrada'));
          FdMemEntradaLotes.FieldByName('HrEntrada').AsDateTime    := StrToTime(jsonObjEntItem.GetValue<String>('hrentrada'));
          FdMemEntradaLotes.Post;
       End;
       Result := True;
    End;
    jsonArrayEntItem := Nil;
    JsonObjEnt.Free;
    ObjEntradaCtrl.Free; //Incluido em 03/04 para Liberar memoria do ojbeto
  Except On E: Exception do Begin
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

function TFrmEntrada.AtualizaEntradaLotes(pLote : String): Boolean;
Var vTotalCheckin : Integer;
    vLote : String;
begin
  Result := False;
  If PgcPrincipal.ActiveTab = TabCheckIn then
     vLote := EdtLote.Text
  Else
     vLote := CbLoteDevSeg.Text;
  if Not FDMemEntradaLotes.Locate('CodProduto;DescrLote', VarArrayOf([IfThen(PgcPrincipal.ActiveTab = TabCheckIn, vCodProdutoCheckIn, vCodProdutoDevSeg), vLote]), []) then Begin
     FdMemEntradaLotes.Append;
     FdMemEntradaLotes.FieldByName('Agrupamentoid').AsInteger := QryListaPadrao.FieldByName('AgrupamentoId').AsInteger;
     FdMemEntradaLotes.FieldByName('loteid').AsInteger       := 0;
     FdMemEntradaLotes.FieldByName('produtoid').AsInteger    := FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger;
     FdMemEntradaLotes.FieldByName('CodProduto').AsInteger   := IfThen(PgcPrincipal.ActiveTab = TabCheckIn, vCodProdutoCheckIn, vCodProdutoDevSeg);
     FdMemEntradaLotes.FieldByName('descrlote').AsString     := pLote;
     If PgcPrincipal.ActiveTab = TabCheckIn then Begin
        FdMemEntradaLotes.FieldByName('fabricacao').AsDateTime  := StrToDate(EdtDtFabricacao.Text);
        FdMemEntradaLotes.FieldByName('vencimento').AsDateTime  := StrToDate(EdtDtVencimento.Text);
     End
     Else Begin
        FdMemEntradaLotes.FieldByName('fabricacao').AsDateTime  := StrToDate(LblLoteFabricacaoDevSeg.Text);
        FdMemEntradaLotes.FieldByName('vencimento').AsDateTime  := StrToDate(LblLoteVencimentoDevSeg.Text);
     End;
     FdMemEntradaLotes.FieldByName('qtdxml').AsInteger       := 0;
     FdMemEntradaLotes.FieldByName('qtdcheckin').AsInteger   := 0;
     FdMemEntradaLotes.FieldByName('qtddevolvida').AsInteger := 0;
     FdMemEntradaLotes.FieldByName('qtdsegregada').AsInteger := 0;
     FdmemEntradaLotes.Post;
  End;
end;

procedure TFrmEntrada.SbCancelarCheckInClick(Sender: TObject);
begin
  inherited;
  EdtCodProduto.Text := '';
  LimparRct02_Rct03;
end;

procedure TFrmEntrada.SbCancelarDevSegClick(Sender: TObject);
begin
  inherited;
  EdtCodProdutoDevSeg.Text := '';
  LimparDevolucaoSegregado;
  PgcPrincipal.ActiveTab   := TabDetalhes;
end;

procedure TFrmEntrada.SbSalvarCheckInClick(Sender: TObject);
Var vLote       : String;
    vFabricacao : TDateTime;
    vVencimento : TDateTime;
begin
  inherited;
  if StrToIntDef(EdtFatorConversao.Text, 0) <= 0 then
     EdtFatorConversao.Text := '1';
  If Not ValidarQuantidade then
     Exit;
  vLote       := 'SL';
  vFabricacao := Now(); //StrToDate('01/01/1900');
  vVencimento := now()+(360*10); //StrToDate('31/12/2099');
  if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 1 then  Begin
     vLote       := 'SL';
     vFabricacao := Date();
     vVencimento := Date()+(360*10);
     EdtDtFabricacao.Text := DatetoStr(vFabricacao);
     EdtDtVencimento.Text := DatetoStr(vVencimento);
  End
  Else If FdMemEntradaProduto.FieldByName('RastroId').AsInteger in [2,3] then  Begin
    if (EdtDtFabricacao.Text = '  /  /    ') then Begin
       SetCampoDefault('EdtDtFabricacao');
       ShowErro('Informe a data de Fabricao!');
       Exit;
    End;
    if (EdtDtVencimento.Text = '  /  /    ') then Begin
       SetCampoDefault('EdtDtVencimento');
       ShowErro('Informe a data de Vencimento!');
       Exit;
    End;
    if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 2 then Begin
       If PgcPrincipal.ActiveTab = TabCheckIn then Begin
          if (StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2) < (StrToInt(Copy(DateToStr(Now()), 7, 4))) then
             EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(EdtDtVencimento.Text, 7, 4))-2).ToString
          Else
             EdtDtFabricacao.Text := Copy(EdtDtVencimento.Text, 1, 6)+(StrToInt(Copy(DateToStr(Now()), 7, 4))-2).ToString;
          vLote  := Copy(EdtDtVencimento.Text, 9, 2)+Copy(EdtDtVencimento.Text, 4, 2)+Copy(EdtDtVencimento.Text, 1, 2);
       End
       Else Begin
          vFabricacao := StrToDate(LblLoteFabricacaoDevSeg.Text);
          vVencimento := StrToDate(LblLoteVencimentoDevSeg.Text);
          vLote       := CbLoteDevSeg.Text;
       End;
    End
    Else Begin
       if (EdtLote.Text = '') then Begin
          SetCampoDefault('EdtLote');
          ShowErro('Informe o lote do Produto!');
          Exit;
       End;
       vLote  := EdtLote.Text;
    End;
    If PgcPrincipal.ActiveTab = TabCheckIn then Begin
       vFabricacao := StrToDate(EdtDtFabricacao.Text);
       vVencimento := StrToDate(EdtDtVencimento.Text);
    End;
  End;
  FDMemEntradaLotes.First;
  if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger = 0 then Begin
     if Not FDMemEntradaLotes.Locate('CodProduto;DescrLote', VarArrayOf([IfThen(PgcPrincipal.ActiveTab = TabCheckIn, vCodProdutoCheckIn, vCodProdutoDevSeg), EdtLote.Text]), []) then Begin
        FdMemEntradaLotes.Append;
//      FdMemEntradaLotes.FieldByName('pedidoid').AsInteger     := FdMemEntradaProduto.FieldByName('PedidoId').AsInteger;
        FdMemEntradaLotes.FieldByName('pedidoitemid').AsInteger := 0;
        FdMemEntradaLotes.FieldByName('loteid').AsInteger       := 0;
        FdMemEntradaLotes.FieldByName('produtoid').AsInteger    := FdMemEntradaProduto.FieldByName('ProdutoId').AsInteger;
        FdMemEntradaLotes.FieldByName('CodProduto').AsInteger   := IfThen(PgcPrincipal.ActiveTab = TabCheckIn, vCodProdutoCheckIn, vCodProdutoDevSeg);
        FdMemEntradaLotes.FieldByName('descrlote').AsString     := vLote;
        FdMemEntradaLotes.FieldByName('fabricacao').AsDateTime  := StrToDate(EdtDtFabricacao.Text);
        FdMemEntradaLotes.FieldByName('vencimento').AsDateTime  := StrToDate(EdtDtVencimento.Text);
        FdMemEntradaLotes.FieldByName('dtentrada').AsDateTime   := Date();
        FdMemEntradaLotes.FieldByName('hrentrada').AsDateTime   := Time();
        FdMemEntradaLotes.FieldByName('qtdxml').AsInteger       := 0;
        FdMemEntradaLotes.FieldByName('qtdcheckin').AsInteger   := 0;
        FdMemEntradaLotes.FieldByName('qtddevolvida').AsInteger := 0;
        FdMemEntradaLotes.FieldByName('qtdsegregada').AsInteger := 0;
        If PgcPrincipal.ActiveTab = TabCheckIn then
           FdMemEntradaLotes.FieldByName('descrproduto').AsString  := EdtDescricao.Text
        Else
           FdMemEntradaLotes.FieldByName('descrproduto').AsString  := EdtDescricaoDevSeg.Text;
        FdmemEntradaLotes.Post;
     End
     Else begin
        FdMemEntradaLotes.Edit;
        FdMemEntradaLotes.FieldByName('fabricacao').AsDateTime  := StrToDate(EdtDtFabricacao.Text);
        FdMemEntradaLotes.FieldByName('vencimento').AsDateTime  := StrToDate(EdtDtVencimento.Text);
        FdMemEntradaLotes.Post;
     End;
  End
  Else
     AtualizaEntradaLotes(vLote); //Trocar nome da funcao para Atualizar Tabela de Lotes
  if SaveItemCheckIn(0, 0, 0) then begin
     FdMemEntradaProduto.Edit;
     FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger := FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+StrToIntDef(EdtQtdTotCheckIn.Text, 0);
     FdMemEntradaProduto.Post;
     if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger = 0 then Begin
        FdMemEntradaLotes.Edit;
        FdMemEntradaLotes.FieldByName('qtdcheckin').AsInteger := FdMemEntradaLotes.FieldByName('qtdcheckin').AsInteger+
                                                                 StrToIntDef(EdtQtdTotCheckIn.Text, 0);
        FdMemEntradaLotes.Post;
     End;
     EdtCodproduto.Text := '';
     LimparRct02_Rct03;
     GetEntradaProduto(QryListaPadrao.FieldByName('PedidoId').AsInteger, QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
//     VerifyEndCheckIn;
  End
  Else Begin
     SetCampoDefault('EdtQtdUnidPrimCheckIn');
     ShowErro('N�o foi poss�vel salvar o CheckIn. tente novamente!');
  End;
end;

procedure TFrmEntrada.SbSalvarDevSegClick(Sender: TObject);
Var vQtdDevolvida, vQtdSegregada, vCodMotivoDevSeg : Integer;
begin
  inherited;
  if CbTipoMovimentacaoDevSeg.ItemIndex < 0 then Begin
     SetCampoDefault('CbTipoMovimentacaoDevSeg');
     ShowErro('Informe o motivo da opera��o.');
     Exit;
  End;
  if (EdtCodProdutoDevSeg.Text = '') or (StrToInt64Def(EdtCodProdutoDevSeg.Text, 0)<=1) then begin
     SetCampoDefault('EdtCodProdutoDevSeg');
     if EdtCodProdutoDevSeg.Text = '' then
        ShowErro('Informe o C�digo do Produto.')
     Else
        ShowErro('C�digo de Produto inv�lido!');
     Exit;
  end;
  if CbLoteDevSeg.ItemIndex < 0 then begin
     SetCampoDefault('CbLoteDevSeg');
     if CbTipoMovimentacaoDevSeg.ItemIndex < 0 then Begin
        SetCampoDefault('CbTipoMovimentacaoDevSeg');
        ShowErro('Selecione o Tipo de Movimenta��o e o Lote.');
        End
     Else if CbTipoMovimentacaoDevSeg.ItemIndex = 0 then
        ShowErro('Selecione o Lote que deseja Devolver.')
     Else
        ShowErro('Selecione o Lote que deseja Segregar.');
     Exit;
  end;
  If CbCausaDevolucaoSegregado.ItemIndex < 0 then Begin
     if CbTipoMovimentacaoDevSeg.ItemIndex = 0 then
        ShowErro('Selecione o Motivo da Devolu��o.')
     Else
        ShowErro('Selecione o Motivo para Segregar.');
     Exit;
  End;
  if StrToIntDef(EdtQtdeDevSeg.Text, 0) <= 0 then Begin
     SetCampoDefault('EdtQtdeDevSeg');
     ShowErro('Informe uma quantidade v�lida.');
     Exit;
  End;
  FDMemSegregadoCausa.First;
  If FDMemSegregadoCausa.Locate('Descricao', CbCausaDevolucaoSegregado.Items.Strings[CbCausaDevolucaoSegregado.ItemIndex], []) then
     vCodMotivoDevSeg := FDMemSegregadoCausa.FieldByName('segregadocausaid').AsInteger
  Else Begin
     SetCampoDefault('CbCausaDevolucaoSegregado');
     ShowErro('Motivo para movimenta��o Inv�lido!');
     Exit;
  End;
  if FdMemEntradaProduto.FieldByName('QtdXml').AsInteger <
     (StrToIntDef(EdtQtdeDevSeg.Text, 0)+FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+
      FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger) Then Begin
     SetCampoDefault('EdtQtdeDevSeg');
     ShowErro('Quantidade Total maior que na Nota!');
     Exit;
  End;

  if CbTipoMovimentacaoDevSeg.ItemIndex = 0 then Begin
     vQtdDevolvida := StrToIntDef(EdtQtdeDevSeg.Text, 0);
     vQtdSegregada := 0;
  End
  Else Begin
     vQtdDevolvida := 0;
     vQtdSegregada := StrToIntDef(EdtQtdeDevSeg.Text, 0);
  End;
  if SaveItemCheckIn(vQtdDevolvida, vQtdSegregada, vCodMotivoDevSeg) then  begin
     FdMemEntradaProduto.Edit;
     if CbLoteDevSeg.ItemIndex = 0 then
        FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger   := FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                                                                       StrToIntDef(EdtQtdeDevSeg.Text, 0)
     Else FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger := FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger+
                                                                      StrToIntDef(EdtQtdeDevSeg.Text, 0);
     FdMemEntradaProduto.Post;
     if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger = 0 then Begin
        FdMemEntradaLotes.Edit;
        if CbLoteDevSeg.ItemIndex = 0 then
           FdMemEntradaLotes.FieldByName('QtdDevolvida').AsInteger := FdMemEntradaLotes.FieldByName('QtdDevolvida').AsInteger+
                                                                      StrToIntDef(EdtQtdeDevSeg.Text, 0)
        Else
           FdMemEntradaLotes.FieldByName('QtdSegregada').AsInteger := FdMemEntradaLotes.FieldByName('QtdSegregada').AsInteger+
                                                                      StrToIntDef(EdtQtdeDevSeg.Text, 0);

        FdMemEntradaLotes.Post;
     End;
     EdtCodproduto.Text := '';
     EdtCodProdutoDevSeg.Text := '';
     DelayEdSetFocus(EdtCodProdutoDevSeg);
     LimparDevolucaoSegregado;
     GetEntradaProduto(QryListaPadrao.FieldByName('PedidoId').AsInteger, QryListaPadrao.FieldByName('AgrupamentoId').AsInteger);
  //     VerifyEndCheckIn;
  End
  Else Begin
     SetCampoDefault('EdtQtdUnidPrimCheckIn');
     ShowErro('N�o foi poss�vel salvar o CheckIn. tente novamente!');
  End;
end;

procedure TFrmEntrada.ShowDados;
begin
  inherited;

end;

procedure TFrmEntrada.ShowDadosProduto;
begin
  EdtPicking.Text        := EnderecoMask(  FdMemEntradaProduto.FieldByName('Picking').AsString,   FdMemEntradaProduto.FieldByName('Mascara').AsString, False);
  StcSngpc.IsChecked     := FdMemEntradaProduto.FieldByName('Sngpc').AsInteger = 1;
  EdtDescricao.Text      := FdMemEntradaProduto.FieldByName('Descricao').AsString;
  CbRastroTipo.itemIndex := FdMemEntradaProduto.FieldByName('RastroId').AsInteger-1;
  If FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 1 then
     LblRastro.Text := 'Sem Rastreabilidade'
  Else If FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 2 then
     LblRastro.Text := 'Vencimento'
  Else If FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 3 then
     LblRastro.Text := 'Por Lote'
  Else LblRastro.Text := 'N�o Definido';
  //EdtEmbalagemSecId.Text := FdMemEntradaProduto.FieldByName('UnidadeSecundariaId').AsString;
  EdtFatorConversao.Text := FdMemEntradaProduto.FieldByName('FatorConversao').AsString;
  EdtPeso.Text           := FdMemEntradaProduto.FieldByName('PesoLiquido').AsString;
  EdtAltura.Text         := FdMemEntradaProduto.FieldByName('Altura').AsString;
  EdtLargura.Text        := FdMemEntradaProduto.FieldByName('Largura').AsString;
  EdtComprimento.Text    := FdMemEntradaProduto.FieldByName('Comprimento').AsString;
  EdtVolume.Text         := (FdMemEntradaProduto.FieldByName('Altura').AsInteger*
                             FdMemEntradaProduto.FieldByName('Largura').AsInteger*
                             FdMemEntradaProduto.FieldByName('Comprimento').AsInteger).ToString();

end;

procedure TFrmEntrada.ShowDadosProdutosParaDevolucao;
begin
  EdtPickingDevSeg.Text    := EnderecoMask(  FdMemEntradaProduto.FieldByName('Picking').AsString,   FdMemEntradaProduto.FieldByName('Mascara').AsString, False);
  SwtSngpcDevSeg.IsChecked := FdMemEntradaProduto.FieldByName('Sngpc').AsInteger = 1;
  EdtDescricaoDevSeg.Text  := FdMemEntradaProduto.FieldByName('Descricao').AsString;
  If FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 1 then
     LblRastroDevSeg.Text := 'Sem Rastreabilidade'
  Else If FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 2 then
     LblRastroDevSeg.Text := 'Vencimento'
  Else If FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 3 then
     LblRastroDevSeg.Text := 'Por Lote'
  Else LblRastroDevSeg.Text := 'N�o Definido';
end;

procedure TFrmEntrada.ThreadAtualizarRastroTerminate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then begin
     CbRastroTipo.ItemIndex := FdMementradaProduto.FieldByName('RastroId').AsInteger;
     SetCampoDefault('CbRastroTipo');
     ShowErro('N�o foi poss�vel mudar a rastreabilidade. '+Exception(TThread(sender).FatalException).Message, 'alerta');
     Exit;
  end;
end;

procedure TFrmEntrada.ThreadTerminatePrincipal(Sender: TObject);
begin
  LstPrincipal.EndUpdate;
  HideLoading;
  if Sender is TThread then Begin
     if Assigned(TThread(Sender).FatalException) then Begin
        ShowErro('Erro: N�o foi poss�vel carregar os Dados!');
        //ShowErro('N�o foi poss�vel trazer as Entradas!');//
        exit;
     end;
  End;
end;

procedure TFrmEntrada.ThreadTerminateProduto(Sender: TObject);
begin
  HideLoading;
  LstEntradaProduto.EndUpdate;
  if Sender is TThread then Begin
     if Assigned(TThread(Sender).FatalException) then Begin
        ShowErro('Erro: '+Exception(TThread(Sender).FatalException).Message);
        //ShowErro('Erro no(s) Produto(s)/Lote(s) da Entrada!');
     end
     Else if (Not StartEntrada) then
       VerifyEndCheckIn
     Else
     LstEntradaProduto.Selected := LstEntradaProduto.Items[0];
     StartEntrada := False;
  End;
end;

function TFrmEntrada.ValidarQuantidade: Boolean;
Var ValidarQuantidadeJsonArray : TjsonArray;
    ObjEntradaCtrl : TEntradaCtrl;
    vQtdTotCheckIn, vQtdeErro : Integer;
    vErro : String;
begin
  Result         := False;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  ValidarQuantidadeJsonArray := ObjEntradaCtrl.GetValidaQtdCheckIn(StrToIntDef(EdtPedidoId_CheckIn.Text, 0), vCodProdutoCheckIn );
  if (Not ValidarQuantidadeJsonArray.Items[0].TryGetValue('Erro', vErro)) then Begin
     if ValidarQuantidadeJsonArray.Items[0].GetValue<Integer>('qtdcheckin')+StrToIntDef(EdtQtdTotCheckIn.Text, 0) > FdMemEntradaProduto.FieldByName('QtdXML').AsInteger then begin
        Result := False;
        vQtdeErro := ValidarQuantidadeJsonArray.Items[0].GetValue<Integer>('qtdcheckin');
        ValidarQuantidadeJsonArray := Nil;
        ObjEntradaCtrl.Free;
        EdtCodProduto.Text := '';
        LimparRct02_Rct03;
        raise Exception.Create('Erro: Atualize a entrada. CheckIn j� alterado(Qtde= '+vQtdeErro.ToString()+')!');
     End;
  End;
  ValidarQuantidadeJsonArray := Nil;
  ObjEntradaCtrl.Free;
  EdtQtdTotCheckIn.Text := (StrToIntDef(EdtQtdUnidPrimCheckIn.Text, 0) + (StrToIntDef(EdtQtdUnidSecCheckIn.Text, 0)*StrToIntDef(EdtFatorConversao.Text, 0))).ToString();
  if FrmeXactWMS.ConfigWMS.CheckInItem = 0 then
     vQtdTotCheckIn   := Trunc(StrToIntDef(EdtQtdTotCheckIn.Text, 0)+
                               FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+
                               FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                               FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger)
  Else vQtdTotCheckIn := Trunc(StrToIntDef(EdtQtdTotCheckIn.Text, 0)+
                               FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                               FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger);
  if FdMemEntradaProduto.FieldByName('QtdXML').AsInteger < vQtdTotCheckIn then Begin
     Result := False;
     raise Exception.Create('Erro: Qtde total maior que Xml.');
  End;
//  EdtQtdTotCheckIn.Text := vQtdTotCheckIn.ToString();
//  if EdtQtdUnidSecCheckIn.Value > 0 then
//     LblQtdTotCheckIn.Caption := EdtQtdUnidSecCheckIn.Value.ToString()+' '+LblUnidSecCheckIn.Caption+' ';
//  if EdtQtdUnidPrimCheckIn.Value > 0 then
//     LblQtdTotCheckIn.Caption := LblQtdTotCheckIn.Caption + EdtQtdUnidPrimCheckIn.Value.ToString()+' '+LblUnidPrimCheckIn.Caption;
  Result := True;
end;

procedure TFrmEntrada.ValidarSets;
begin
  CbRastroTipo.Enabled := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimento - Permitir definir rastreabilidade');
  if (FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 3) or
     (FdmemEntradaProduto.FieldByName('SNGPC').AsInteger=1) or
     (FdmemEntradaProduto.FieldByName('ZonaSNGPC').AsInteger=1) then Begin
     EdtLote.ReadOnly         := False;
     EdtDtFabricacao.ReadOnly := False;
     EdtDtVencimento.ReadOnly := False;
     if (FrmeXactWMS.ConfigWMS.EnderecarProdutoEntrada = 0) or (EdtPicking.Text<>'') then
        DelayEdSetFocus(EdtLote);
  End
  Else if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 2 then Begin
     EdtLote.ReadOnly         := True;
     EdtDtFabricacao.ReadOnly := True;
     EdtDtVencimento.ReadOnly := False;
     if (FrmeXactWMS.ConfigWMS.EnderecarProdutoEntrada = 0) or (EdtPicking.Text<>'') then
        DelayEdSetFocus(EdtDtVencimento);
  End
  Else if FdMemEntradaProduto.FieldByName('RastroId').AsInteger = 1 then Begin
     EdtLote.ReadOnly         := True;
     EdtDtFabricacao.ReadOnly := True;
     EdtDtVencimento.ReadOnly := True;
     DelayEdSetFocus(EdtQtdUnidPrimCheckIn);
  End;
  if (FrmeXactWMS.ConfigWMS.CubagemProdutoEntrada > 0) and
     ((StrToFloatDef(EdtVolume.Text, 0) = 0) or (StrToFloatDef(EdtVolume.Text, 0) = 512)) then Begin
     EdtFatorConversao.ReadOnly := False;
     EdtPeso.ReadOnly           := False;
     EdtAltura.ReadOnly         := False;
     EdtLargura.ReadOnly        := False;
     EdtComprimento.ReadOnly    := False;
     EdtVolume.ReadOnly         := False;
     DelayEdSetFocus(EdtPeso);
  End
  Else Begin
     EdtFatorConversao.ReadOnly := True;
     EdtPeso.ReadOnly           := True;
     EdtAltura.ReadOnly         := True;
     EdtLargura.ReadOnly        := True;
     EdtComprimento.ReadOnly    := True;
     EdtVolume.ReadOnly         := True;
  End;
  if (EdtPicking.Text = '') and (FrmeXactWMS.ConfigWMS.EnderecarProdutoEntrada >= 1) then Begin
     EdtPicking.ReadOnly := False;
     DelayEdSetFocus(EdtPicking);
  End;
end;

function TFrmEntrada.VerifyAutorization: Boolean;
begin
  Result := False;
//  if StrToIntDef(FdMemEntradaProduto.FieldByName('EnderecoId').AsString, 0) = 0 then
//     Result := False
//  Else
  if ((FdMemEntradaProduto.FieldByName('RastroId').AsInteger<>3) and ((FdMemEntradaProduto.FieldByName('Sngpc').AsInteger = 0) and
      (FdMemEntradaProduto.FieldByName('ZonaSngpc').AsInteger = 0))) or
     (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimentos - Altera��o Lotes')) then
     Result := True
  Else If ((TipoAutorizarAlteracaoLote = poProduto) and (FdMemEntradaProduto.FieldByName('Sngpc').AsInteger = 0)) or
          ((TipoAutorizarAlteracaoLote = poZona) and (FdMemEntradaProduto.FieldByName('ZonaSngpc').AsInteger = 0)) then
     Result := True;
end;

procedure TFrmEntrada.VerifyEndCheckIn;
var vTotXml, vTotCheckIn : Integer;
    ObjEntradaCtrl       : TEntradaCtrl;
begin
  vTotXml     := 0;
  vTotCheckIn := 0;
  FdMemEntradaProduto.First;
  while Not FdMemEntradaProduto.Eof do Begin
    vTotXml     := vTotXml     + FdMemEntradaProduto.FieldByName('QtdXml').AsInteger;
    vTotCheckIn := vTotCheckIn + FdMemEntradaProduto.FieldByName('QtdCheckIn').AsInteger+
                                 FdMemEntradaProduto.FieldByName('QtdDevolvida').AsInteger+
                                 FdMemEntradaProduto.FieldByName('QtdSegregada').AsInteger;
    FdMemEntradaProduto.Next;
  End;
  if vTotXml = vTotCheckIn then Begin
     PgcPrincipal.ActiveTab := TabDetalhes;
     //Evitar Fechamento Autom�tico do Recebimento
{
      if QryListaPadrao.FieldByName('AgrupamentoId').AsInteger > 0 then
         FatorarCheckInNotas
      Else Begin
         ObjEntradaCtrl := TEntradaCtrl.Create;
         ObjEntradaCtrl.Entrada.EntradaId := StrToIntDef(EdtCodigo.Text, 0);
         ObjEntradaCtrl.RegistrarDocumentoEtapa(5);
         ObjEntradaCtrl.Free;
         FinalizarCheckIn;
      End;

}  End;
end;

end.

