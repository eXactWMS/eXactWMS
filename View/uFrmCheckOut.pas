unit uFrmCheckOut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, JvBaseDlg, JvCalc,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, DataSet.Serialize,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid,
  cxPC, ACBrBarCode, JvToolEdit, JvBaseEdits, Rest.Json, System.Json, Rest.Types
  , EmbalagemCaixaClass
  , EmbalagemCaixaCtrl
  , PedidoSaidaCtrl
  , PedidoVolumeCtrl
  , ProdutoCtrl, Vcl.DBGrids, Vcl.Samples.Gauges, VrControls, VrAngularMeter,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.Buttons, Vcl.ComCtrls, ACBrBase,
  ACBrETQ, dxCameraControl,
  Services.Base.Cadastro, uFrmAutorizarOperacao;

type
  TOperacao = (opCheckOut, opReCheckOut);

  TFrmCheckOut = class(TFrmBase)
    PnlCxaVol: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Label13: TLabel;
    LblHPedido: TLabel;
    Label15: TLabel;
    LblHDtPedido: TLabel;
    Label17: TLabel;
    LblHCliente: TLabel;
    EdtCaixaEmbalagemId: TEdit;
    PnlProduto: TPanel;
    PnlIndicador: TPanel;
    PnlDigitacao: TPanel;
    LblProduto: TLabel;
    EdtProdutoId: TJvCalcEdit;
    Label4: TLabel;
    LblEan: TACBrBarCode;
    EdtQtde: TJvCalcEdit;
    Label6: TLabel;
    Label5: TLabel;
    EdtZona: TEdit;
    Panel1: TPanel;
    Label8: TLabel;
    EdtTotItensVol: TJvCalcEdit;
    EdtTotItensSep: TJvCalcEdit;
    Label11: TLabel;
    Label7: TLabel;
    LblHRota: TLabel;
    Label10: TLabel;
    LblSequencia: TLabel;
    LstCheckOutProdutoAdv: TAdvStringGrid;
    JvCalculator1: TJvCalculator;
    EdtVolumeId: TJvCalcEdit;
    LblVolumeTipo: TLabel;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    FdMemPesqGeralCodBarras: TStringField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralEmbalagemPadrao: TIntegerField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FdMemPesqGeralQtdCheckOut: TIntegerField;
    PnlIndicadorTop: TPanel;
    Panel6: TPanel;
    Shape8: TShape;
    Label9: TLabel;
    LblErros: TLabel;
    LblPercErro: TLabel;
    Image1: TImage;
    Panel5: TPanel;
    Shape7: TShape;
    LblEtqSobra: TLabel;
    LblSobras: TLabel;
    Image3: TImage;
    LblPercSobras: TLabel;
    PnlKeyFunction: TPanel;
    LblF2: TLabel;
    LblF5: TLabel;
    LblF3: TLabel;
    pbrProdutividadeAnalogico: TVrAngularMeter;
    TmProdutividade: TTimer;
    Panel3: TPanel;
    Label18: TLabel;
    LblUnidHora: TLabel;
    GProcIEC: TGauge;
    Label16: TLabel;
    LblEmbalagemCxa: TLabel;
    LblEmbalagemUnid: TLabel;
    Label12: TLabel;
    LblTempoAbertura: TLabel;
    TabVolumeLacre: TcxTabSheet;
    PnlVolumeLacreTop: TPanel;
    Label14: TLabel;
    Label19: TLabel;
    Image4: TImage;
    Label20: TLabel;
    LblPedidoLacre: TLabel;
    Label22: TLabel;
    LblDtPedidoLacre: TLabel;
    Label24: TLabel;
    LblClienteLacre: TLabel;
    Label26: TLabel;
    LblRotaLacre: TLabel;
    Label28: TLabel;
    LblSequenciaLacre: TLabel;
    LblVolumeTipoLacre: TLabel;
    EdtCaixaIdLacre: TEdit;
    Panel4: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    EdtTotItensVolumeLacre: TJvCalcEdit;
    EdtTotItensSepLacre: TJvCalcEdit;
    EdtVolumeIdLacre: TJvCalcEdit;
    PnlLacreMain: TPanel;
    LstVolumeLacre: TAdvStringGrid;
    BtnSalvarLacre: TPanel;
    sImage2: TsImage;
    BntFinalizarSemLacre: TPanel;
    sImage1: TsImage;
    Label21: TLabel;
    EdtLacre: TEdit;
    ChkRegistradoExpedicao: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure EdtCaixaEmbalagemIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtCaixaEmbalagemIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdtProdutoIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EdtQtdeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TmProdutividadeTimer(Sender: TObject);
    procedure EdtQtdeExit(Sender: TObject);
    procedure EdtVolumeIdEnter(Sender: TObject);
    procedure EdtVolumeIdExit(Sender: TObject);
    procedure EdtCaixaEmbalagemIdEnter(Sender: TObject);
    procedure EdtCaixaEmbalagemIdExit(Sender: TObject);
    procedure EdtProdutoIdEnter(Sender: TObject);
    procedure EdtProdutoIdExit(Sender: TObject);
    procedure BntFinalizarSemLacreClick(Sender: TObject);
    procedure BtnSalvarLacreClick(Sender: TObject);
    procedure EdtLacreKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    ObjVolumeCtrl : TPedidoVolumeCtrl;
    TotIndErro, TotIndSobra : Integer;
    Operacao : TOperacao;
    F3Press : Boolean;
    HrTempoAbertura : Cardinal;
    vTimerIndProdutividade : Integer;
    Procedure AtualizaCheckOut;
    Procedure AtualizaGrid(xTotItens : Integer);
    Procedure LimparDigitacaoStart(Const pStart : Boolean = True);
    Procedure LimparDigitacao;
    Procedure ControlaDigitacao(pStart : Boolean);
    procedure BuscarVolumeCheckOut;
    Procedure GetPedidoSaida(pPedidoId : Integer; pRota : String);
    Procedure GetVolume(pVolumeId : Integer);
    Procedure GetVolumeProduto(pPedidoVolumeId : Integer);
    Procedure StartCheckOut;
    Procedure ShowIndErro;
    Procedure SalvarCheckOut;
    Procedure RegistrarSobras;
    Procedure ShowIndicesProdutividade;
    Function ValidarCaixa : Boolean;
    Procedure FinalizarRegistroCheckOut;
    Procedure AtivarPanelAutorizacaoCheckOutComDivergencia;
    Procedure AtivarPanelAutorizacaoVolumeExtra(pJsonObjectFinalizacao : TJsonObject);
    Procedure FinalizarConferenciaComRegistro(pJsonObjectFinalizacao : TJsonObject);
    Procedure SalvarCheckOutComDivergencia;
    Procedure ConfirmarFinalizacao(pRegistradoExpedido : Boolean);
    Procedure AtivarEditLacre;
  public
    { Public declarations }
  end;

var
  FrmCheckOut: TFrmCheckOut;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS, Services.Caixas, Providers.Request;

procedure TFrmCheckOut.ConfirmarFinalizacao(pRegistradoExpedido : Boolean);
begin
  if pRegistradoExpedido then
     ShowOk('CheckOut concluído. Direcione o volume para expedição')
  Else
     ShowOk('CheckOut concluído. Volume já registrado na expedição.');
  ControlaDigitacao(True);
end;

procedure TFrmCheckOut.ControlaDigitacao(pStart : Boolean);
begin
  if pStart then Begin
     LimparDigitacaoStart;
     LimparDigitacao;
  End;
  PnlCxaVol.Enabled    := pStart;
  PnlDigitacao.Enabled := Not pStart;
  if PnlCxaVol.Enabled then Begin
//     EdtCaixaEmbalagemId.SetFocus;
     If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe = 1) then begin
        EdtCaixaEmbalagemId.Visible := True;
        EdtCaixaEmbalagemId.SetFocus;
     end
     Else Begin
        EdtCaixaEmbalagemId.Visible := False;
        EdtVolumeId.SetFocus;
     End;
  End
  Else EdtProdutoId.SetFocus;
end;

procedure TFrmCheckOut.EdtCaixaEmbalagemIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmCheckOut.EdtCaixaEmbalagemIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(EdtCaixaEmbalagemId);
end;

procedure TFrmCheckOut.EdtCaixaEmbalagemIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmCheckOut.EdtCaixaEmbalagemIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) then Begin
     if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe=1) and (EdtCaixaEmbalagemId.Text='') then Begin
        Key := 0;
        ShowErro('Informe a caixa usada para Check-Out!', 'alarme');
        EdtCaixaEmbalagemId.SetFocus;
        Exit;
     End
     Else if (Sender=EdtCaixaEmbalagemId) and (EdtCaixaEmbalagemId.Text<>'0') and (StrToIntDef(EdtCaixaEmbalagemId.Text, 0) <= 0) then Begin
        Key := 0;
        EdtCaixaEmbalagemId.SetFocus;
        ShowErro('Identificação da caixa inválido!', 'alarme');
        EdtCaixaEmbalagemId.Clear;
        Exit;
     End
     Else if (Sender=EdtVolumeId) and (StrToIntDef(EdtVolumeId.Text, 0) <= 0) then Begin
        Key := 0;
        ShowErro('Id do Volume inválido!', 'alarme');
        EdtCaixaEmbalagemId.SetFocus;
        Exit;
     End;
     if Sender = EdtVolumeId then Begin
        HrTempoAbertura := GetTickCount;
        ExitFocus(EdtVolumeId);
        BuscarVolumeCheckOut;
     End
     Else Begin
       if (Sender = EdtCaixaEmbalagemId) And (Not ValidarCaixa)then Begin
          EdtCaixaEmbalagemId.Clear;
          EdtCaixaEmbalagemId.SetFocus;
       End
       Else SelectNext(ActiveControl, True, True);
     End;
  End
  Else Begin
     If Sender = EdtCaixaEmbalagemId Then Begin
        EdtVolumeId.Clear;
        LimparDigitacaoStart(False);
     End;
  End;
end;

procedure TFrmCheckOut.EdtLacreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then Begin
     if StrToInt64Def(EdtLacre.Text, 0) <= 0 then Begin
        EdtLacre.Clear;
        EdtLacre.SetFocus;
        ShowErro('Lacre inválido!');
     End;
     LstVolumeLacre.RowCount := LstVolumeLacre.RowCount+1;
     LstVolumeLacre.Cells[0, Pred(LstVolumeLacre.RowCount)] := EdtVolumeId.Text;
     LstVolumeLacre.Cells[1, Pred(LstVolumeLacre.RowCount)] := EdtLacre.Text;
     LstVolumeLacre.AddDataImage(2, Pred(LstVolumeLacre.RowCount), 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
     LstVolumeLacre.Cells[2, Pred(LstVolumeLacre.RowCount)] := '2';
     LstCadastro.Alignments[0, Pred(LstVolumeLacre.RowCount)] := taRightJustify;
     LstCadastro.FontStyles[0, Pred(LstVolumeLacre.RowCount)] := [FsBold];
     LstCadastro.Alignments[1, Pred(LstVolumeLacre.RowCount)] := taRightJustify;
     LstCadastro.Alignments[2, Pred(LstVolumeLacre.RowCount)] := taCenter;
     EdtLacre.Clear;
     EdtLacre.SetFocus;
  End;
end;

procedure TFrmCheckOut.EdtProdutoIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmCheckOut.EdtProdutoIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(EdtProdutoId);
end;

procedure TFrmCheckOut.EdtProdutoIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F2) Then //and (Confirmacao('Confirme a Operação', 'Concluir o CheckOut com pendências')) then
     SalvarCheckOutComDivergencia
  Else if (Key = VK_F3) and (LblVolumeTipo.Caption <> 'Caixa Fechada') then Begin
     EdtQtde.ReadOnly := False;
     EdtQtde.SetFocus;
     F3Press := True;
  End
  Else if (Key = VK_F5) and (PnlDigitacao.Enabled) then  Begin
//     if Application.MessageBox('Cancelar CheckOut', 'Deseja Cancelar o CheckOut do Volume?', MB_YESNO) = MrYes then Begin
     if (Confirmacao('Confirme a Operação', 'Deseja Cancelar o CheckOut do Volume')) then Begin
        //ObjVolumeCtrl.RegistrarDocumentoEtapa(ObjVolumeCtrl.ObjPedidoVolume.ProcessoEtapaId);
        ObjVolumeCtrl.DesfazerInicioCheckOutOpen;
        //LimparDigitacao;
        //LimparDigitacaoStart;
        ControlaDigitacao(True);
        Exit;
     End;
  End
  Else If (Key = 13) and (EdtProdutoId.Text<> '') Then Begin
     if (StrToInt64Def(EdtProdutoId.Text, 0)<>0)  then Begin
        ExitFocus(EdtProdutoId);
        AtualizaCheckOut;
     End
     Else Begin
       MensagemSis('Atenção!', 'Código e/ou Ean inválido!!!',
                   'Código e/ou Ean inválido('+EdtProdutoId.Text+')!!!', '', False, True);
       EdtProdutoId.Clear;
       EdtProdutoId.SetFocus;
     End;
  End
  else
     EdtProdutoId.SetFocus;
end;

procedure TFrmCheckOut.EdtQtdeExit(Sender: TObject);
begin
  inherited;
  if (F3Press) then Begin
     if (EdtQtde.Value < 0) or ((EdtQtde.Value=0) and (EdtQtde.Text<>'0')) then Begin
        MensagemSis('Atenção!', 'Quantidade inválida!',
                   'Quantidade deve ser maior que zero', '', False, True);
        EdtQtde.Clear;
        EdtQtde.SetFocus;
     End;
  End;
end;

procedure TFrmCheckOut.EdtQtdeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13 then
     EdtProdutoId.SetFocus;
end;

procedure TFrmCheckOut.EdtVolumeIdEnter(Sender: TObject);
begin
  inherited;
  LblTempoAbertura.Caption := '...';
  EnterFocus(Sender);
end;

procedure TFrmCheckOut.EdtVolumeIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(EdtVolumeId);
end;

procedure TFrmCheckOut.AtivarEditLacre;
begin
  PnlVolumeLacreTop.Enabled := False;
  EdtLacre.ReadOnly := False;
  EdtLacre.SetFocus;
end;

procedure TFrmCheckOut.AtivarPanelAutorizacaoCheckOutComDivergencia;
Var //JsonArrayVolumeExtra : TJsonArray;
    pJsonArrayProdutoCorte : TJsonArray;
    vErro : String;
begin
  FrmAutorizarOperacao := TFrmAutorizarOperacao.Create(Application);
  FrmAutorizarOperacao.LblVersao.Caption := 'Versão: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
  FrmAutorizarOperacao.LblAutorizarOperacao.Caption := 'Finalizar com Divergência.';
  FrmAutorizarOperacao.Autorizar_Funcionalidade := 'Permitir Finalizar CheckOut com Divergência.';
  if (FrmAutorizarOperacao.ShowModal = mrOk) then
     SalvarCheckOut
  Else Begin
     ShowErro('Não autorizado finalização com divergência!', 'alarme');
  End;
  FrmAutorizarOperacao := Nil;
end;

procedure TFrmCheckOut.AtivarPanelAutorizacaoVolumeExtra(pJsonObjectFinalizacao : TJsonObject);
Var //JsonArrayVolumeExtra : TJsonArray;
    pJsonArrayProdutoCorte : TJsonArray;
    vErro : String;
begin
//  pJsonArrayProdutoCorte := TJsonArray.Create();
  FrmAutorizarOperacao := TFrmAutorizarOperacao.Create(Application);
  FrmAutorizarOperacao.LblVersao.Caption := 'Versão: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
  FrmAutorizarOperacao.LblAutorizarOperacao.Caption := 'Gerar Volume Extra.';
  FrmAutorizarOperacao.Autorizar_Funcionalidade := 'Permitir Gerar Volume Extra - CheckOut';
  if (FrmAutorizarOperacao.ShowModal = mrOk) then begin
//     JsonArrayVolumeExtra := ObjVolumeCtrl.GerarVolumeExtra(pJsonArrayProdutoCorte);
//     if Not JsonArrayVolumeExtra.Items[0].TryGetValue('Erro', vErro) then
//        Confirmacao('Volume Extra!', 'Volume Extra Gerado: '+JsonArrayVolumeExtra.Items[0].Value, False)  //GetValue<String>('pedidovolumeid')
//     Else ShowErro('Não foi possível gerar o volume Extra: '+vErro, 'apito');
     pJsonObjectFinalizacao.AddPair('volumeextra', TJsonNumber.Create(1));
  End
  Else Begin
     ShowErro('Volume Extra não autorizado! Volume finalizado com pendência!', 'alarme');
     pJsonObjectFinalizacao.AddPair('volumeextra', TJsonNumber.Create(0));
  End;
  FinalizarConferenciaComRegistro(pJsonObjectFinalizacao);
//  FinalizarRegistroCheckOut;
//  JsonArrayVolumeExtra := Nil;
  FrmAutorizarOperacao := Nil;
end;

procedure TFrmCheckOut.AtualizaCheckOut;
Var vProdutoId, pQtdCheckOut, vQtdeEmbalagem   : Integer;
    vCodDigitado : String;
    Var ObjProdutoCtrl : TPRodutoCtrl;
begin
  Try
    vCodDigitado := EdtProdutoId.Text;
    ObjProdutoCtrl := TProdutoCtrl.Create;
    vProdutoId := ObjProdutoCtrl.GetCodProdEan(EdtProdutoId.Text);
    if vProdutoId <= 0 then Begin
       EdtProdutoId.Clear;
       TotIndErro := TotIndErro + 1;
       ShowIndErro;
       MensagemSis('Atenção!', 'Produto('+vCodDigitado+') não encontrado!', '', '', False, True);
       EdtProdutoId.SetFocus;
       ObjProdutoCtrl.Free;
       Exit;
    End;
    If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno = 0) and
       (StrToInt64Def(EdtProdutoId.Text, 0) = FdMemPesqGeral.FieldByName('CodProduto').AsLargeInt) then Begin
       EdtProdutoId.SetFocus;
       ShowErro('Scanear o EAN do produto!');
       Exit;
    End;
    if Not (FdMemPesqGeral.Locate('ProdutoId', vProdutoId, [])) then Begin
       EdtProdutoId.Clear;
       //ShowErro('Produto('+vCodDigitado+') não faz parte deste volume!');
       //Confirmacao('CheckOut', 'Produto('+vCodDigitado+') não faz parte deste volume!', False);
       TotIndErro := TotIndErro + 1;
       ShowIndErro;
       MensagemSis('Atenção!', 'Produto('+vCodDigitado+') não faz parte deste volume!', '', '', False, True);
       EdtProdutoId.SetFocus;
       ObjProdutoCtrl.Free;
       Exit;
    End
    Else If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno = 0) and (EdtProdutoId.Text = FdMemPesqGeral.FieldByName('CodProduto').AsString) then Begin
       EdtProdutoId.Text := '';
       ShowErro('Scanear o EAN do produto!');
       Exit;
    End
    Else If (FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger) >= FdMemPesqGeral.FieldByName('Demanda').AsInteger then Begin
       MensagemSis('Atenção!', 'Sobra: Produto já conferido.',
                   Copy(FdMemPesqGeral.FieldByName('Descricao').AsString, 1, 40),
                   Copy(FdMemPesqGeral.FieldByName('Descricao').AsString, 41, 40), False, True);
       EdtProdutoId.Clear;
       TotIndSobra := TotIndSobra + 1;
       ShowIndErro;
       EdtProdutoId.SetFocus;
       ObjProdutoCtrl.Free;
       exit;
    End;
    //LblEan.Text := FdMemPesqGeral.FieldByName('CodBarras').AsString;
    if F3Press then Begin
       if (((Trunc(EdtQtde.Value*FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger)+FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger)
           Mod FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger) <> 0) then Begin
  //        raise Exception.Create('Quantidade precisa ser equivalente a embalagem.');
          Confirmacao('CheckOut', 'Quantidade precisa ser equivalente a embalagem.', False);
          EdtProdutoId.SetFocus;
          ObjProdutoCtrl.Free;
          Exit;
       End
       Else if ((EdtQtde.Value*FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger)+FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger >
                FdMemPesqGeral.FieldByName('Demanda').AsInteger)  then Begin
          Confirmacao('CheckOut', 'Quantidade maior que Demanda.', False);
          EdtQtde.Value := 1;
          EdtProdutoId.Clear;
          EdtProdutoId.SetFocus;
          ObjProdutoCtrl.Free;
          Exit;
       End;
       pQtdCheckOut         := (StrToIntDef(EdtQtde.Text, 0)*FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger)+FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger;
       EdtTotItensSep.Value := EdtTotItensSep.Value - FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger;
       vQtdeEmbalagem       := (StrToIntDef(EdtQtde.Text, 0)*FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger)+FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger;
    End
    Else Begin
       pQtdCheckOut   := FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger+
                         FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger;
       vQtdeEmbalagem := FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger;
    End;
    if ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId = 0 then Begin
       pQtdCheckOut   := FdMemPesqGeral.FieldByName('Demanda').AsInteger;
       EdtQtde.Value  := FdMemPesqGeral.FieldByName('Demanda').AsInteger;
       vQtdeEmbalagem := FdMemPesqGeral.FieldByName('Demanda').AsInteger;
    End;

    F3Press := False;
    FdMemPesqGeral.Edit;
    FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger := pQtdCheckOut; //FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger+
                                                                         //FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger;    //Round(EdtQtde.Value); //1
    FdmemPesqGeral.Post;
    ObjProdutoCtrl.Free;
    AtualizaGrid(Round(vQtdeEmbalagem)); //EdtQtde.Value));
    LimparDigitacao;
  Except On E: Exception do Begin
    EdtProdutoId.SetFocus;
    ObjProdutoCtrl.Free;
    ShowErro('Erro: '+E.Message, 'alarme');
    End;
  End;
end;

procedure TFrmCheckOut.AtualizaGrid(xTotItens : Integer);
Var xProd : Integer;
begin
  for XProd := 1 to Pred(LstCheckOutProdutoAdv.RowCount) do Begin
    if FdMemPesqGeral.FieldByName('CodProduto').AsInteger = StrToInt(LstCheckOutProdutoAdv.Cells[0, xProd]) then Begin
       LstCheckOutProdutoAdv.Cells[6, xProd] := FdMemPesqGeral.FieldByName('QtdCheckOut').AsString;
       if LstCheckOutProdutoAdv.Cells[6, xProd].ToInteger = LstCheckOutProdutoAdv.Cells[5, xProd].ToInteger Then
          LstCheckOutProdutoAdv.colors[6, xProd] := ClGreen
       Else LstCheckOutProdutoAdv.colors[6, xProd] := clYellow;
       EdtTotItensSep.Value := EdtTotItensSep.Value + xTotItens;
       if (FdMemPesqGeral.FieldByName('Demanda').AsInteger = FdMemPesqGeral.FieldByName('QtdCheckOut').AsInteger) then
          LstCheckOutProdutoAdv.Cells[7, xProd] := '1';
       LstCheckOutProdutoAdv.Row := xProd;
    End;
  End;
  if EdtTotItensVol.Value = EdtTotItensSep.Value then
     SalvarCheckOut;
end;

procedure TFrmCheckOut.BntFinalizarSemLacreClick(Sender: TObject);
begin
  inherited;
  ConfirmarFinalizacao(ChkRegistradoExpedicao.Checked);
end;

procedure TFrmCheckOut.BtnSalvarLacreClick(Sender: TObject);
Var xLacre : Integer;
    JsonObjectVolume : TJsonObject;
    JsonArrayLacre   : TJsonArray;
    JsonArrayRetorno : TJsonArray;
    JsonObjectLacre  : TJsonObject;
    vErro : String;
begin
  if LstVolumeLacre.RowCount = 1 then Begin
     EdtLacre.SetFocus;
     ShowErro('Informe os lacres da Caixa!');
     Exit;
  End;
  inherited;
  JsonObjectVolume := TJSONObject.Create;
  JsonArrayLacre   := TJSONArray.Create;
  for xLacre := 1 to Pred(LstVolumeLacre.RowCount) do
    JsonArrayLacre.AddElement(TJsonObject.Create.AddPair('lacre', LstVolumeLacre.Cells[1, xLacre]));
  JsonObjectVolume.AddPair('volumeid', TJsonNumber.Create(StrToIntDef(EdtVolumeId.Text, 0)));
  JsonObjectVolume.AddPair('lacres', JsonArrayLacre);
  JsonArrayRetorno := ObjVolumeCtrl.VolumeLacres(JsonObjectVolume);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     EdtLacre.SetFocus;
  End
  Else
    ConfirmarFinalizacao(ChkRegistradoExpedicao.Checked);
  JsonArrayRetorno := Nil;
  FreeAndNil(JsonArrayLacre);
end;

procedure TFrmCheckOut.BuscarVolumeCheckOut;
begin
  inherited;
  if EdtVolumeId.Text = '' then Exit;
  if StrToIntDef(EdtVolumeId.Text, 0) <= 0 then Begin
     EdtVolumeId.Text := '';
     raise Exception.Create('Volume inválido!!!');
  End;
  GetVolume(StrToIntDef(EdtVolumeId.Text, 0));
end;

procedure TFrmCheckOut.FinalizarConferenciaComRegistro(
  pJsonObjectFinalizacao: TJsonObject);
Var vErro : String;
    JsonArrayRetorno : TJsonArray;
    vVolumeExtraId   : Integer;
begin
  JsonArrayRetorno := ObjVolumeCtrl.FinalizarConferenciaComRegistro(pJsonObjectFinalizacao);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro, 'alarme');
  End
  Else Begin
     if JsonArrayRetorno.Items[0].TryGetValue('volumeextra', vVolumeExtraId) then Begin
        if JsonArrayRetorno.Items[0].GetValue<Integer>('volumeextra') >0 then
           Confirmacao('Volume Extra!', 'Volume Extra Gerado: '+vVolumeExtraId.ToString, False);
     End;
     if FrmeXactWMS.ConfigWMS.ObjConfiguracao.LacreSeguranca = 1 then Begin
        TabVolumeLacre.TabVisible := True;
        TabPrincipal.TabVisible   := False;
        AtivarEditLacre;
     End
     Else Begin
        ChkRegistradoExpedicao.Checked := pJsonObjectFinalizacao.GetValue<Integer>('processoid')=13;
        ConfirmarFinalizacao(pJsonObjectFinalizacao.GetValue<Integer>('processoid')=13);
     End;
  End;
  JsonArrayRetorno := Nil;
end;

procedure TFrmCheckOut.FinalizarRegistroCheckOut;
Var vRegistradoExpedicao : Boolean;
begin
  vRegistradoExpedicao := False;
  if Operacao = opCheckOut then Begin
     ObjVolumeCtrl.RegistrarDocumentoEtapa(10);
     if (ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId = 0) and
        (FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolCxaFechadaExpedicao = 1) then begin
        vRegistradoExpedicao := True;
        ObjVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoque(13, 0);
     End;
  End
  Else ObjVolumeCtrl.RegistrarDocumentoEtapa(12);
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.LacreSeguranca = 1 then Begin
     TabVolumeLacre.TabVisible := True;
     TabPrincipal.TabVisible   := False;
     AtivarEditLacre;
  End
  Else Begin
     ChkRegistradoExpedicao.Checked := vRegistradoExpedicao;
     ConfirmarFinalizacao(vRegistradoExpedicao);
  End;
end;

procedure TFrmCheckOut.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ObjVolumeCtrl.Free;
  inherited;
  FrmCheckOut   := Nil;
end;

procedure TFrmCheckOut.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if PnlDigitacao.Enabled then Begin
     CanClose := False;
     raise Exception.Create('Finalize ou Cancele o processo de CheckOut!');
  End;
  inherited;
end;

procedure TFrmCheckOut.FormCreate(Sender: TObject);
begin
  inherited;
  LstCadastro.RowCount := 1;
  LstCadastro.ColWidths[0]  :=  70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[1]  :=  70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[2]  := 200+Trunc(200*ResponsivoVideo);
  LstCadastro.ColWidths[3]  := 180+Trunc(180*ResponsivoVideo);
  LstCadastro.ColWidths[4]  := 120+Trunc(120*ResponsivoVideo);
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[1, 0] := taRightJustify;

  LstCheckOutProdutoAdv.RowCount := 1;
  LstCheckOutProdutoAdv.ColWidths[0]  :=  80+Trunc(80*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[1]  := 140+Trunc(140*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[2]  := 290+Trunc(290*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[3]  := 100+Trunc(100*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[4]  :=  90+Trunc(90*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[5]  :=  60+Trunc(60*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[6]  :=  60+Trunc(60*ResponsivoVideo);
  LstCheckOutProdutoAdv.ColWidths[7]  :=  60+Trunc(60*ResponsivoVideo);
  LstCheckOutProdutoAdv.Alignments[0, 0] := taRightJustify;
  LstCheckOutProdutoAdv.FontStyles[0, 0] := [FsBold];
  LstCheckOutProdutoAdv.Alignments[3, 0] := taCenter;
  LstCheckOutProdutoAdv.Alignments[4, 0] := taLeftJustify;
  LstCheckOutProdutoAdv.Alignments[5, 0] := taRightJustify;
  LstCheckOutProdutoAdv.Alignments[6, 0] := taRightJustify;
  LstCheckOutProdutoAdv.Alignments[7, 0] := taCenter;
  LstCheckOutProdutoAdv.HideColumn(5); //Checkout as cegas
  LstCheckOutProdutoAdv.HideColumn(8); //Checkout as cegas

  LstVolumeLacre.RowCount := 1;
  LstVolumeLacre.ColWidths[0]  := 90+Trunc(90*ResponsivoVideo);
  LstVolumeLacre.ColWidths[1]  := 90+Trunc(90*ResponsivoVideo);
  LstVolumeLacre.ColWidths[2]  := 60+Trunc(60*ResponsivoVideo);
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[1, 0] := taRightJustify;
  LstCadastro.Alignments[2, 0] := taCenter;

  PgcBase.ActivePage := TabPrincipal;
  ObjVolumeCtrl := TPedidoVolumeCtrl.Create;
end;

procedure TFrmCheckOut.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

end;

procedure TFrmCheckOut.FormShow(Sender: TObject);
begin
  inherited;
//  LimparDigitacaoStart;
//  LimparDigitacao;
  ControlaDigitacao(True);
end;

procedure TFrmCheckOut.GetPedidoSaida(pPedidoId: Integer; pRota : String);
Var ObjPedidoSaidaCtrl  : TPedidoSaidaCtrl;
    RetornoPedJsonArray : TJsonArray;
    vErro               : String;
begin
  LblHPedido.Caption   := ObjVolumeCtrl.ObjPedidoVolume.Pedido.PedidoId.ToString;
  LblHDtPedido.Caption := DateToStr(ObjVolumeCtrl.ObjPedidoVolume.Pedido.DocumentoData);
  LblHCliente.Caption  := ObjVolumeCtrl.ObjPedidoVolume.Pedido.Pessoa.Fantasia;
  LblHRota.Caption     := pRota;

  EdtCaixaIdLacre.Text        := EdtCaixaEmbalagemId.Text;
  EdtVolumeIdLacre.Text       := EdtVolumeId.Text;
  LblPedidoLacre.Caption      := ObjVolumeCtrl.ObjPedidoVolume.Pedido.PedidoId.ToString;
  LblDtPedidoLacre.Caption    := DateToStr(ObjVolumeCtrl.ObjPedidoVolume.Pedido.DocumentoData);
  LblClienteLacre.Caption     := ObjVolumeCtrl.ObjPedidoVolume.Pedido.Pessoa.Fantasia;
  LblRotaLacre.Caption        := pRota;
  LblSequenciaLacre.Caption   := LblSequencia.Caption;
  LblVolumeTipoLacre.Caption  := LblVolumeTipo.Caption;
  EdtTotItensVolumeLacre.Text := EdtTotItensVol.Text;
  EdtTotItensSepLacre.Text    := EdtTotItensSep.Text;
end;

procedure TFrmCheckOut.GetVolume(pVolumeId: Integer);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    RetornoVolJsonArray : TJsonArray;
    vErro               : String;
    vUsuarioId          : Integer;
begin
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  RetornoVolJsonArray := ObjPedidoVolumeCtrl.GetVolume(0, StrToIntDef(EdtVolumeId.Text, 0), 0, 0);
  if RetornoVolJsonArray.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtVolumeId.Clear;
     ShowErro(vErro, 'alarme');
     RetornoVolJsonArray := Nil;
     ObjPedidoVolumeCtrl.Free;
     raise Exception.Create('Erro: '+vErro);
  End;
  if RetornoVolJsonArray.Items[0].GetValue<Integer>('totalbloqueio') > 0 then Begin
     EdtVolumeId.Clear;
     ShowErro('CheckOut não permitida. Endereço(s) bloqueado para Inventariar.', 'alarme');
     RetornoVolJsonArray := Nil;
     ObjPedidoVolumeCtrl.Free;
     raise Exception.Create('Erro: '+vErro);
  End;
  ObjVolumeCtrl.ObjPedidoVolume.Pedido.PedidoId        := RetornoVolJsonArray.Items[0].GetValue<TJsonObject>('pedido').GetValue<Integer>('pedidoid');
  ObjVolumeCtrl.ObjPedidoVolume.Pedido.DocumentoData   := StrToDate(DateEUAtoBR(RetornoVolJsonArray.Items[0].GetValue<TJsonObject>('pedido').GetValue<String>('documentodata')));
  ObjVolumeCtrl.ObjPedidoVolume.Pedido.Pessoa.Fantasia := RetornoVolJsonArray.Items[0].GetValue<TJsonObject>('destino').GetValue<String>('razao');
  ObjVolumeCtrl.ObjPedidoVolume.Pedido.Pessoa.RotaId   := RetornoVolJsonArray.Items[0].GetValue<TJsonObject>('rota').GetValue<Integer>('rotaid');

  ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId  := RetornoVolJsonArray.Items[0].GetValue<Integer>('pedidovolumeid');
  ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId := RetornoVolJsonArray.Items[0].GetValue<Integer>('volumetipo', 0);
  LblVolumeTipo.Caption := RetornoVolJsonArray.Items[0].GetValue<String>('embalagem');
{  ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.Descricao       := RetornoVolJsonArray.Items[0].GetValue<string>('descricao');
  ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.Identificacao   := RetornoVolJsonArray.Items[0].GetValue<String>('identificacao');
  ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.Tara            := RetornoVolJsonArray.Items[0].GetValue<Double>('tara');
}  ObjVolumeCtrl.ObjPedidoVolume.NumSequencia                    := RetornoVolJsonArray.Items[0].GetValue<Integer>('sequencia');
  ObjVolumeCtrl.ObjPedidoVolume.CaixaEmbalagem.CaixaEmbalagemId := RetornoVolJsonArray.Items[0].GetValue<Integer>('volumecaixa');
  ObjVolumeCtrl.ObjPedidoVolume.ProcessoEtapaId                 := RetornoVolJsonArray.Items[0].GetValue<Integer>('processoid');
  ObjVolumeCtrl.ObjPedidoVolume.ProcessoEtapa                   := RetornoVolJsonArray.Items[0].GetValue<String>('processo');
  vUsuarioId := RetornoVolJsonArray.Items[0].GetValue<Integer>('usuarioid');
  LblSequencia.Caption := ObjVolumeCtrl.ObjPedidoVolume.NumSequencia.ToString();
  case ObjVolumeCtrl.ObjPedidoVolume.ProcessoEtapaId of
    2, 22: Begin
       RetornoVolJsonArray := Nil;
       ObjPedidoVolumeCtrl.Free;
       LimparDigitaCaoStart(True);
       raise Exception.Create('Etiqueta de Volume não impressa!');
    End;
    3, 7, 8, 9: begin //
       if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.RegApanhe = 1) and
          (ObjVolumeCtrl.ObjPedidoVolume.ProcessoEtapaId < 8) then Begin
          EdtVolumeId.Text         := '';
          EdtCaixaEmbalagemId.Text := '';
          if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe = 1) then
             EdtCaixaEmbalagemId.SetFocus
          Else
             EdtVolumeId.SetFocus;
          RetornoVolJsonArray := Nil;
          ObjPedidoVolumeCtrl.Free;
          LimparDigitaCaoStart(True);
          raise Exception.Create('Volume deve ser separado antes do CheckOut.');
       End;
       GetPedidoSaida(ObjVolumeCtrl.ObjPedidoVolume.Pedido.PedidoId, RetornoVolJsonArray.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('rota'));
       StartCheckOut;
       ObjVolumeCtrl.RegistrarDocumentoEtapa(9);
       ObjVolumeCtrl.CaixaSeparacao(StrToIntDef(EdtCaixaEmbalagemId.Text, 0));
       Operacao := opCheckOut;
       end;
    71: Begin
       RetornoVolJsonArray := Nil;
       ObjPedidoVolumeCtrl.Free;
       LimparDigitaCaoStart(True);
       raise Exception.Create('Volume em Separação. Finalize a separação!');
    End;
    10, 11, 12: Begin  //11,
        //Iniciar
         if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReCheckOutUsuario = 1) and
            (ObjVolumeCtrl.ObjPedidoVolume.ProcessoEtapaId in [10, 12]) and
            (vUsuarioId = FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) then Begin
            EdtVolumeId.Clear;
            EdtVolumeId.Setfocus;
            RetornoVolJsonArray := Nil;
            ObjPedidoVolumeCtrl.Free;
            LimparDigitaCaoStart(True);
            ShowErro('Não é permitido o (Re)CheckOut pelo mesmo usuário!', 'alarme');
            raise Exception.Create('Não é permitido o (Re)CheckOut pelo mesmo usuário!');
         End;
         if (Confirmacao('Reconferência', 'Reconferir Volume: '+ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId.ToString+'?')) then Begin
            GetPedidoSaida(ObjVolumeCtrl.ObjPedidoVolume.Pedido.PedidoId, RetornoVolJsonArray.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('rota'));
            ObjVolumeCtrl.RegistrarDocumentoEtapa(11);
            If ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId <> StrToIntDef(EdtCaixaEmbalagemId.Text, 0) then
               ObjVolumeCtrl.CaixaSeparacao(StrToIntDef(EdtCaixaEmbalagemId.Text, 0));
            Operacao := opReCheckOut;
            StartCheckOut;
         End
         Else Begin
            EdtVolumeId.SetFocus;
            EdtVolumeId.Clear;
         End;
       end;
    13, 14: begin
        RetornoVolJsonArray := Nil;
        ObjPedidoVolumeCtrl.Free;
        LimparDigitaCaoStart(True);
        raise Exception.Create('Erro: Volume em Expedição!');
    end;
    15: Begin
      RetornoVolJsonArray := Nil;
      ObjPedidoVolumeCtrl.Free;
      LimparDigitaCaoStart(True);
      raise Exception.Create('Volume Cancelado!');
    End
    Else begin
      RetornoVolJsonArray := Nil;
      ObjPedidoVolumeCtrl.Free;
      LimparDigitaCaoStart(True);
      raise Exception.Create('Operação não permitida('+ObjPedidoVolumeCtrl.ObjPedidoVolume.ProcessoEtapa+').');
    end;
  end;
  if Assigned(ObjPedidoVolumeCtrl) then Begin
     RetornoVolJsonArray := Nil;
     ObjPedidoVolumeCtrl.Free;
  End;
end;

procedure TFrmCheckOut.GetVolumeProduto(pPedidoVolumeId: Integer);
Var RetornoJsonArray : TJsonArray;
    vErro            : String;
    xProd            : Integer;
begin
  EdtTotItensVol.Value := 0;
  LstCheckOutProdutoAdv.RowCount := 1;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ReconferirCorteReconferencia = 1 then
     RetornoJsonArray := ObjVolumeCtrl.GetVolumeProdutos(pPedidoVolumeId)
  Else
     RetornoJsonArray := ObjVolumeCtrl.GetVolumeProdutosReconferencia(pPedidoVolumeId);
  if RetornoJsonArray.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro, 'alarme');
     //LimparDigitacaoStart;
     ControlaDigitacao(True);
     RetornoJsonArray := Nil;
     Exit;
  End;
  LstCheckOutProdutoAdv.RowCount  := RetornoJsonArray.Count+1;
  LstCheckOutProdutoAdv.FixedRows := 1;
  if not (FdMemPesqGeral.Active) then
     FdMemPesqGeral.Open;
  FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.LoadFromJson(RetornoJsonArray, False);
  for xProd := 1 to Pred(LstCheckOutProdutoAdv.RowCount) Do
      LstCheckOutProdutoAdv.AddDataImage(7, xProd, 0, haCenter,vaTop);
  for xProd := 0 to Pred(RetornoJsonArray.Count) do Begin
    LstCheckOutProdutoAdv.Cells[0, xProd+1] := RetornoJsonArray.Items[xProd].GetValue<Integer>('codproduto').ToString();
    LstCheckOutProdutoAdv.Cells[1, xProd+1] := RetornoJsonArray.Items[xProd].GetValue<String>('codbarras');
    LstCheckOutProdutoAdv.Cells[2, xProd+1] := RetornoJsonArray.Items[xProd].GetValue<String>('descricao');
    LstCheckOutProdutoAdv.Cells[3, xProd+1] := EnderecoMask(RetornoJsonArray.Items[xProd].GetValue<String>('endereco'), '99.99.99.999', True);
    if RetornoJsonArray.Items[xProd].GetValue<Integer>('embalagempadrao') = 1 then
       LstCheckOutProdutoAdv.Cells[4, xProd+1] := 'Unidade(1)'
    Else
       LstCheckOutProdutoAdv.Cells[4, xProd+1] := 'Caixa c/'+RetornoJsonArray.Items[xProd].GetValue<Integer>('embalagempadrao').ToString();
    LstCheckOutProdutoAdv.Cells[5, xProd+1]    := RetornoJsonArray.Items[xProd].GetValue<Integer>('demanda').ToString();
    LstCheckOutProdutoAdv.Cells[6, xProd+1]    := ''; //Total checkouteado
    LstCheckOutProdutoAdv.colors[6, xProd+1]   := LstCheckOutProdutoAdv.colors[5, xProd];
    LstCheckOutProdutoAdv.Cells[7, xProd+1]    := '0';
    LstCheckOutProdutoAdv.Cells[8, xProd+1]    := RetornoJsonArray.Items[xProd].GetValue<Integer>('embalagempadrao').ToString();
    LstCheckOutProdutoAdv.Alignments[0, xProd+1] := taRightJustify;
    LstCheckOutProdutoAdv.FontStyles[0, xProd+1] := [FsBold];
    LstCheckOutProdutoAdv.Alignments[3, xProd+1] := taCenter;
    LstCheckOutProdutoAdv.Alignments[4, xProd+1] := taLeftJustify;
    LstCheckOutProdutoAdv.Alignments[5, xProd+1] := taRightJustify;
    LstCheckOutProdutoAdv.Alignments[6, xProd+1] := taRightJustify;
    LstCheckOutProdutoAdv.Alignments[7, xProd+1] := taCenter;
    EdtTotItensVol.Value := EdtTotItensVol.Value+RetornoJsonArray.Items[xProd].GetValue<Integer>('demanda');
  End;
  EdtProdutoId.SetFocus;
//Fim do Tempo de Abertura
  LblTempoAbertura.Caption := Format('Tempo: %f seg.', [((GetTickCount - HrTempoAbertura) / 1000)]);
  if LblVolumeTipo.Caption = 'Caixa Fechada' then Begin
     EdtQtde.Value := FdMemPesqGeral.FieldByName('Demanda').AsInteger;
     LblF3.Font.Color := clGray;
  End
  Else Begin
     EdtQtde.Value := 0;
     LblF3.Font.Color := clBlack;
  End;
  vTimerIndProdutividade  := 0;
  TmProdutividade.Enabled := True;
  RetornoJsonArray := Nil;
end;

procedure TFrmCheckOut.LimparDigitacao;
begin
  EdtProdutoId.Clear;
  LblProduto.Caption  := '';
  LblEan.Text         := '';
  EdtQtde.Value       := 1;//FdMemPesqGeral.FieldByName('EmbalagemPadrao').AsInteger;
  EdtQtde.ReadOnly    := True;
  EdtZona.Clear;
  if (PnlDigitacao.Enabled) and (EdtProdutoId.Focused) then
     EdtProdutoId.SetFocus;
end;

procedure TFrmCheckOut.LimparDigitaCaoStart(Const pStart : Boolean);
begin
  TabPrincipal.TabVisible := True;
  PgcBase.ActivePage      := TabPrincipal;
  if pStart then Begin
     EdtCaixaEmbalagemId.ReadOnly := False;
     EdtVolumeId.ReadOnly         := False;
     EdtCaixaEmbalagemId.Clear;
     EdtVolumeId.Clear;
  End;
  EdtTotItensVol.Clear;
  EdtTotItensSep.Clear;
  LblHPedido.Caption    := '';
  LblHDtPedido.Caption  := '';
  LblHCliente.Caption   := '';
  LblHRota.Caption      := '';
  LblSequencia.Caption  := '';
  LblVolumeTipo.Caption := '';
  TotIndErro            := 0;
  LblErros.Caption      := '0';
  LblPercErro.Caption   := '0%';
  TotIndSobra           := 0;
  LblSobras.Caption     := '0';
  LblPercSobras.Caption := '0%';
  GProcIEC.Progress     := 0;
  LstCheckOutProdutoAdv.RowCount := 1;
  FdMemPesqGeral.Close;
  LblUnidHora.Caption     := '0';
  LblUnidHora.Font.Color  := ClWhite;
  PnlIndicador.Color      := FrmCheckOut.Color;
  PbrProdutividadeAnalogico.Position := 0;
  vTimerIndProdutividade  := 0;
  TmProdutividade.Enabled := False;
  if (PnlCxaVol.Enabled) then//and (EdtCaixaEmbalagemId.Focused) then
     if EdtCaixaEmbalagemId.Visible then
        EdtCaixaEmbalagemId.SetFocus   //
     Else EdtVolumeId.SetFocus; //EdtCaixaEmbalagemId.SetFocus;
  LstVolumeLacre.RowCount   := 1;
  EdtLacre.Clear;
  ChkRegistradoExpedicao.Checked := False;
  TabVolumeLacre.TabVisible      := False;
end;

procedure TFrmCheckOut.RegistrarSobras;
begin

end;

procedure TFrmCheckOut.SalvarCheckOut;
Var JsonConferencia        : TJsonObject;
    JsonArrayConferencia   : TJsonArray;
    JsonArrayVolumeExtra   : TJsonArray;
    xProd                  : Integer;
    vDivergencia           : Boolean;
    vErro                  : String;
    vTotCheckOut           : Integer;
    pJsonArrayProdutoCorte : TJsonArray;
    JsonArrayRetorno       : TJsonArray;
    vRegistradoExpedicao   : Boolean;
    JsonObjectFinalizacao  : TJsonObject;
    vProcessoFinalizar     : Integer;
begin
  vDivergencia           := False;
  vRegistradoExpedicao   := False;
  JsonArrayConferencia   := TJsonArray.Create();
  pJsonArrayProdutoCorte := TJsonArray.Create();
  vTotCheckOut := 0;
  for xProd := 1 to Pred(LstCheckOutProdutoAdv.RowCount) do begin
    JsonConferencia      := TjsonObject.Create();
    jsonConferencia.AddPair('pedidovolumeid', tJsonNumber.Create(ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId));
    jsonConferencia.AddPair('codproduto', tJsonNumber.Create(LstCheckOutProdutoAdv.Cells[0, xProd].ToInteger()));
    jsonConferencia.AddPair('quantidade', tjsonNumber.Create(LstCheckOutProdutoAdv.Cells[5, xProd].ToInteger()));
    jsonConferencia.AddPair('qtdsuprida', tjsonNumber.Create(StrToIntDef(LstCheckOutProdutoAdv.Cells[6, xProd], 0)));
    JsonConferencia.AddPair('usuarioid', tjsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    JsonConferencia.AddPair('data', DateToStr(Date()));
    JsonConferencia.AddPair('horariotermino', TimeToStr(Time()));
    JsonConferencia.AddPair('terminal', NomedoComputador);
    if Operacao = opCheckOut then
       JsonConferencia.AddPair('processoetapa', 'CheckOut Finalizado')
    Else JsonConferencia.AddPair('processoetapa', 'Re-CheckOut Finalizado');
    JsonArrayConferencia.AddElement(JsonConferencia);
    if (StrToIntDef(LstCheckOutProdutoAdv.Cells[5, xProd], 0)) <> (StrToIntDef(LstCheckOutProdutoAdv.Cells[6, xProd], 0)) then
       vDivergencia := True;
    vTotCheckOut := vTotCheckOut + LstCheckOutProdutoAdv.Cells[5, xProd].ToInteger();
  end;
  if ((vDivergencia) and (Not Confirmacao('Divergência!', 'Deseja Gerar Volume Extra?', True))) then  Begin
     vDivergencia := False;
     //Solicitar Autorização para Continuar com Divergência
  End;

  JsonObjectFinalizacao  := TJsonObject.Create;
  JsonObjectFinalizacao.AddPair('itens', JsonArrayConferencia);
  if Operacao = opCheckOut then Begin
     vProcessoFinalizar := 10;
     if (ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId = 0) and
        (FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolCxaFechadaExpedicao = 1) then begin
        vRegistradoExpedicao := True;
        vProcessoFinalizar := 13;
     End;
  End
  Else
     vProcessoFinalizar := 12;
  JsonObjectFinalizacao.AddPair('processoid', TJsonNumber.Create(vProcessoFinalizar));
  JsonObjectFinalizacao.AddPair('usuarioid', tjsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonObjectFinalizacao.AddPair('terminal', NomeDoComputador);
  if (vDivergencia) and (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Permitir Gerar Volume Extra - CheckOut')) then
     AtivarPanelAutorizacaoVolumeExtra(JsonObjectFinalizacao)
  Else Begin
     if vDivergencia then
        JsonObjectFinalizacao.AddPair('volumeextra', TJsonNumber.Create(1))
     Else
        JsonObjectFinalizacao.AddPair('volumeextra', TJsonNumber.Create(0));
     FinalizarConferenciaComRegistro(JsonObjectFinalizacao);
  End;
  JsonConferencia := Nil;
  JsonArrayConferencia := Nil;
  JsonObjectFinalizacao.Free;
end;

procedure TFrmCheckOut.SalvarCheckOutComDivergencia;
Var xItens, vTotCheckOut : Integer;
begin
  vTotCheckOut := 0;
  for xItens := 1 to Pred(LstCheckOutProdutoAdv.RowCount) do
    vTotCheckOut := vTotCheckOut +  LstCheckOutProdutoAdv.Ints[6, xItens];
  If vTotCheckOut = 0 then Begin
     Confirmacao('Finalizar CheckOut!', 'Use <F5> para cancelar.', False);
     Exit;
  End;
  If Not (Confirmacao('Divergência!', 'Finalizar volume com Divergência?', True)) then
     Exit
  Else Begin
     if (FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Permitir Finalizar CheckOut com Divergência.')) then
        SalvarCheckOut
     Else
        AtivarPanelAutorizacaoCheckOutComDivergencia;
  End;
end;

procedure TFrmCheckOut.ShowIndErro;
begin
  LblErros.Caption      := TotIndErro.ToString;
  LblPercErro.Caption   := (TotIndErro / EdtTotItensVol.Value * 100).ToString+'%';
  LblSobras.Caption     := TotIndSobra.ToString;
  LblPercSobras.Caption := (TotIndSobra / EdtTotItensVol.Value * 100).ToString+'%';
end;

procedure TFrmCheckOut.ShowIndicesProdutividade;
var vUnidHora : Integer;
    vgProdutividadeMeta, vgProdutividadeAceitavel, vgEficienciaMinima : Integer;
begin
  vUnidHora := 0;
  //Parametros a serem definidos na Configuração do eXactWMS
  vgProdutividadeMeta      := 1000;
  vgProdutividadeAceitavel :=  800;
  vgEficienciaMinima       :=   95;
  GProcIEC.Progress        := Trunc(EdtTotItensSep.Value / EdtTotItensVol.Value * 100);
  if (Trunc(EdtTotItensSep.Value / EdtTotItensVol.Value * 100) = 100) then
     GProcIEC.ForeColor := clGreen
  else if (Trunc(EdtTotItensSep.Value / EdtTotItensVol.Value * 100) > vgEficienciaMinima) then
     GProcIEC.ForeColor := clYellow
  else
     GProcIEC.ForeColor := clRed;
  if (vTimerIndProdutividade > 0) then Begin
     if (ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId >= 1) then
        vUnidHora := Trunc(EdtTotItensSep.Value / vTimerIndProdutividade * 3600)
     else if EdtTotItensSep.Value > 0 then
        vUnidHora := Trunc(1 / vTimerIndProdutividade * 3600);
  end;
  if (vUnidHora < vgProdutividadeAceitavel) then
     PnlIndicador.Color := clRed
  else if (vUnidHora < vgProdutividadeMeta) then
     PnlIndicador.Color := clYellow
  else
     PnlIndicador.Color := clGreen;
  LblUnidHora.Caption    := vUnidHora.ToString();
  LblUnidHora.Font.Color := PnlIndicador.Color;

//  pbrProdutividadeAnalogico.NeedleColor := clBlack;
  pbrProdutividadeAnalogico.MaxValue := Trunc(1.25 * vgProdutividadeMeta);
  pbrProdutividadeAnalogico.Position := vUnidHora;
  pbrProdutividadeAnalogico.Percent1 := Trunc(vgProdutividadeAceitavel / (1.25 * vgProdutividadeMeta)*100); //vgProdutividadeAceitavel-1;
  pbrProdutividadeAnalogico.Percent2 := Trunc(vgProdutividadeMeta / (1.25 * vgProdutividadeMeta)*100) - pbrProdutividadeAnalogico.Percent1;
end;

procedure TFrmCheckOut.StartCheckOut;
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  LimparDigitacao;
  ControlaDigitacao(False);
  GetVolumeProduto(ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId);
end;

procedure TFrmCheckOut.TmProdutividadeTimer(Sender: TObject);
begin
  inherited;
  Inc(vTimerIndProdutividade);
  ShowIndicesProdutividade;
end;

function TFrmCheckOut.ValidarCaixa: Boolean;
Var JsonArrayCaixas : TjsonArray;
    LstCaixaEmbalagem  : TObjectList<TCaixaEmbalagem>;
    //LstVolumeSeparacao : TObjectList<TVolumeSeparacao>;
    vUsuarioId : Integer;
    ObjCaixaEmbalagemCtrl  : TCaixaEmbalagemCtrl;
    FService : TServiceBaseCadastro;
    vErro    : String;
    LResponse : iResponse;
begin
  inherited;
  Result := True;
  if StrToIntDef(EdtCaixaEmbalagemId.Text, 0) > 0 then Begin
{
      FService := TServiceCaixas.Create(Self);
      LResponse := FService
         .Request
         .ClearParams
         .BaseURL(FrmeXactWMS.BASEURL)
         .Resource('v1/caixaembalagem')
         .AddParam('caixaembalagemid', EdtCaixaEmbalagemId.Text)
         .Get;
      JsonArrayCaixas := LResponse.JSONValue.GetValue<TJSONArray>;
      if JsonArrayCaixas.Items[0].TryGetValue('Erro', vErro) then
         ShowErro('Erro', vErro);
      JsonArrayCaixas := Nil;
      FService.Free;
      Exit;
}
     ObjCaixaEmbalagemCtrl  := TCaixaEmbalagemCtrl.Create;
     LstCaixaEmbalagem := ObjCaixaEmbalagemCtrl.GetCaixaEmbalagem(StrToInt(EdtCaixaEmbalagemId.Text), 0); //1);
    if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe = 1) and
       (LstCaixaEmbalagem[0].CaixaEmbalagemid = 0) then begin
        ShowErro('Caixa('+EdtCaixaEmbalagemId.Text+') inválida!!!', 'alarme');
        EdtCaixaEmbalagemId.Clear;
        EdtCaixaEmbalagemId.SetFocus;
        Result := False;
        ObjCaixaEmbalagemCtrl.Free;
        Exit;
     end;
     if LstCaixaEmbalagem[0].Status = 0 then Begin
        ShowErro('Caixa('+EdtCaixaEmbalagemId.Text+') inativa.', 'alarme');
        EdtCaixaEmbalagemId.Clear;
        EdtCaixaEmbalagemId.SetFocus;
        Result := False;
        ObjCaixaEmbalagemCtrl.Free;
        Exit;
     End;
     ObjCaixaEmbalagemCtrl.Free;
  End;
end;

end.
