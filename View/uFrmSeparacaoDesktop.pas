unit uFrmSeparacaoDesktop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Generics.Collections,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC,
  AdvSmoothGauge, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits, Vcl.ComCtrls,
  Vcl.DBGrids, ACBrBarCode, Vcl.Buttons, Rest.Json, System.Json, Rest.Types
  , PedidoVolumeSeparacaoClass
  , EmbalagemCaixaClass
  , PedidoVolumeClass
  , PedidoVolumeSeparacaoCtrl
  , EmbalagemCaixaCtrl
  , PedidoVolumeCtrl
  , ProdutoCtrl, JvSpin, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  dxCameraControl;

type
  TFrmSeparacaoDesktop = class(TFrmBase)
    PnlCxaVol: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Image2: TImage;
    EdtCaixaEmbalagemId: TEdit;
    EdtVolumeId: TEdit;
    PnlDigitacao: TPanel;
    Label4: TLabel;
    LblProduto: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LblPedido: TLabel;
    Label7: TLabel;
    LblDtPedido: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    LblCliente: TLabel;
    Label12: TLabel;
    LblCodBarraProd: TACBrBarCode;
    GrdLoteProd: TDBGrid;
    EdtCodBarra: TEdit;
    PnlEndereco: TPanel;
    EdtEndereco: TLabeledEdit;
    StatusBar1: TStatusBar;
    PnlQtde: TPanel;
    EdtQtde: TJvCalcEdit;
    EdtUnid: TEdit;
    IndProdutividade: TAdvSmoothGauge;
    IndEficiencia: TAdvSmoothGauge;
    Label13: TLabel;
    LblHPedido: TLabel;
    Label15: TLabel;
    LblHDtPedido: TLabel;
    Label17: TLabel;
    LblHCliente: TLabel;
    EdtTotItensVol: TJvCalcEdit;
    Label8: TLabel;
    Label11: TLabel;
    EdtTotItensSep: TJvCalcEdit;
    FdMemLotes: TFDMemTable;
    FdMemLotesPedidoVolumeId: TIntegerField;
    FdMemLotesPedidoVolumeLoteId: TIntegerField;
    FdMemLotesProdutoId: TIntegerField;
    FdMemLotesDescricao: TStringField;
    FdMemLotesCodProduto: TIntegerField;
    FdMemLotesLoteId: TIntegerField;
    FdMemLotesDescrLote: TStringField;
    FdMemLotesVencimento: TDateField;
    FdMemLotesEnderecoId: TIntegerField;
    FdMemLotesRuaId: TIntegerField;
    FdMemLotesRuaDescricao: TStringField;
    FdMemLotesQuantidade: TIntegerField;
    FdMemLotesEmbalagemPadrao: TIntegerField;
    FdMemLotesQtdSuprida: TIntegerField;
    FdMemLotesVolumeLoteCheckIn: TIntegerField;
    FdMemLotesEnderecoDescricao: TStringField;
    DsLotes: TDataSource;
    FdMemLotesMascara: TStringField;
    LblLote: TLabel;
    LblVencimento: TLabel;
    EdtSeparado: TJvCalcEdit;
    Edit1: TEdit;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtCaixaEmbalagemIdExit(Sender: TObject);
    procedure EdtCaixaEmbalagemIdChange(Sender: TObject);
    procedure EdtCodBarraKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtCodBarraChange(Sender: TObject);
    procedure EdtCaixaEmbalagemIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtSeparadoExit(Sender: TObject);
    procedure EdtSeparadoEnter(Sender: TObject);
    procedure EdtSeparadoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtCodBarraEnter(Sender: TObject);
    procedure EdtCodBarraExit(Sender: TObject);
    procedure EdtSeparadoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCaixaEmbalagemIdEnter(Sender: TObject);
    procedure EdtVolumeIdExit(Sender: TObject);
  private
    { Private declarations }
    StartSeparacao         : Boolean;
    ObjVolumeSeparacaoCtrl : TVolumeSeparacaoCtrl;
    ObjCaixaEmbalagemCtrl  : TCaixaEmbalagemCtrl;
    ObjPedidoVolumeCtrl    : TPedidoVolumeCtrl;
    F3Press : boolean;
    Procedure ConfereVolumeOnOff(pStatus : Boolean);
    Procedure BuscarVolumeParaSeparacao;
    Procedure GetVolumeSeparacao;
    Function HeaderVolume : Boolean;
    Procedure GetReConferencia;
    Procedure GetItens;
    Procedure AtivarSeparacao;
    Procedure DesativarCheckIn;
    Procedure GetDadosItens;
    function GetCodigoERP(pCodigoERP: String): Boolean;
    Procedure SalvarSeparacao;
    Procedure FinalizarSeparacao;
    Procedure LimparDigitacao;
    Procedure LimparHeader;
    Procedure LogOff;
  public
    { Public declarations }
  end;

var
  FrmSeparacaoDesktop: TFrmSeparacaoDesktop;

implementation

{$R *.dfm}

uses uFrmeXactWMS, uFuncoes;

procedure TFrmSeparacaoDesktop.AtivarSeparacao;
begin
  PnlDigitacao.Enabled := True;
  EdtCodBarra.SetFocus;
  PnlCxaVol.Enabled    := False;
  GetDadosItens;
end;

procedure TFrmSeparacaoDesktop.BuscarVolumeParaSeparacao;
Var LstVolumeSeparacao : TObjectList<TVolumeSeparacao>;
begin
  if (EdtVolumeId.Text<>'') and (strToIntDef(EdtCaixaEmbalagemId.Text, 0) = 0) then Begin
//     EdtCaixaEmbalagemId.Setfocus;
//     raise Exception.Create('Informe uma caixa para separação/conferência.');
     EdtCaixaEmbalagemId.Text := '0';//EdtVolumeId.Text;
  End;
  if StrToIntDef(EdtVolumeId.Text, 0) > 0 then Begin
     LstVolumeSeparacao := ObjVolumeSeparacaoCtrl.GetVolumeSeparacao(0, StrToInt(EdtVolumeId.Text), 0, 0);
     if (Assigned(LstVolumeSeparacao)) and (LstVolumeSeparacao.Count >= 1) and (LstVolumeSeparacao[0].PedidoVolumeId>0) then Begin
//        EdtVolumeId.SetFocus
//     Else Begin
        if (LstVolumeSeparacao[0].CaixaEmbalagemId <> 0) and (LstVolumeSeparacao[0].UsuarioId<>FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId)  then
           raise Exception.Create('Volume já está em Separação/Conferência. Caixa: '+
           LstVolumeSeparacao[0].CaixaEmbalagemId.ToString()+'  Usuário: '+
           LstVolumeSeparacao[0].UsuarioId.ToString());
        EdtVolumeId.Text := LstVolumeSeparacao[0].PedidoVolumeId.ToString();
     End;
     StartSeparacao := True;
     GetVolumeSeparacao;
  End;
end;

procedure TFrmSeparacaoDesktop.ConfereVolumeOnOff(pStatus: Boolean);
begin
  PnlCxaVol.Enabled    := pStatus;
  PnlDigitacao.Enabled := Not PnlCxaVol.Enabled;
  if pStatus = True then Begin
     EdtCaixaEmbalagemId.ReadOnly := False;
     EdtVolumeId.ReadOnly         := False;
     EdtCodBarra.ReadOnly         := True;
  End
  Else begin
     EdtCaixaEmbalagemId.ReadOnly := True;
     EdtVolumeId.ReadOnly         := True;
     EdtCodBarra.ReadOnly         := False;
  end;
end;

procedure TFrmSeparacaoDesktop.DesativarCheckIn;
begin
  PnlCxaVol.Enabled     := True;
  PnlDigitacao.Enabled  := False;
  EdtCaixaEmbalagemId.Clear;
  LimparDigitacao;
  LimparHeader;
  PnlDigitacao.Enabled  := False;
  if Not PnlCxaVol.Enabled then
     EdtCodBarra.SetFocus;
end;

procedure TFrmSeparacaoDesktop.EdtCaixaEmbalagemIdChange(Sender: TObject);
begin
  inherited;
//  EdtVolumeId.Text := '';
end;

procedure TFrmSeparacaoDesktop.EdtCaixaEmbalagemIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender)
end;

procedure TFrmSeparacaoDesktop.EdtCaixaEmbalagemIdExit(Sender: TObject);
Var jsonReturn : TjsonArray;
    LstCaixaEmbalagem  : TObjectList<TCaixaEmbalagem>;
    LstVolumeSeparacao : TObjectList<TVolumeSeparacao>;
    vUsuarioId : Integer;
begin
  inherited;
  if StrToIntDef(EdtCaixaEmbalagemId.Text, 0) > 0 then Begin
     LstCaixaEmbalagem := ObjCaixaEmbalagemCtrl.GetCaixaEmbalagem(StrToInt(EdtCaixaEmbalagemId.Text), 0); //1);
     if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe = 1) and (LstCaixaEmbalagem[0].CaixaEmbalagemid = 0) then begin
        ShowErro('Caixa('+EdtCaixaEmbalagemId.Text+') inválida!!!');
        EdtCaixaEmbalagemId.Clear;
        EdtCaixaEmbalagemId.SetFocus;
        Exit;
     end;
     if LstCaixaEmbalagem[0].Status = 0 then Begin
        ShowErro('Caixa('+EdtCaixaEmbalagemId.Text+') inativa.');
        EdtCaixaEmbalagemId.Clear;
        EdtCaixaEmbalagemId.SetFocus;
        Exit;
     End;
     LstVolumeSeparacao := ObjVolumeSeparacaoCtrl.GetVolumeSeparacao(StrToInt(EdtCaixaEmbalagemId.Text), 0, 0, 0);
     if (Not Assigned(LstVolumeSeparacao)) or ((LstVolumeSeparacao.Count < 1) or (LstVolumeSeparacao[0].VolumeSeparacaoId=0)) then Begin
        //Ativar Quando usar Controle de Caixa
        //EdtVolumeId.SetFocus;
        Exit;
     End
     Else Begin
        vUsuarioId := LstVolumeSeparacao[0].UsuarioId;
        if (LstVolumeSeparacao[0].UsuarioId<>0) and (LstVolumeSeparacao[0].UsuarioId <> FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId) then
           raise Exception.Create('Caixa em Uso por outro usuário: '+LstVolumeSeparacao[0].UsuarioId.ToString);
           //Buscar na funcao getvolumeseparacao o nome do usuario para exibir no Raise acima
        EdtVolumeId.Text := LstVolumeSeparacao[0].PedidoVolumeId.ToString();
        StartSeparacao := False;
        GetVolumeSeparacao;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmSeparacaoDesktop.EdtCaixaEmbalagemIdKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (TEdit(Sender).Text<>'') then Begin
     if Sender = EdtVolumeId then Begin
        if StrToIntDef(EdtCaixaEmbalagemId.Text, 0) =0 then Begin
           EdtCaixaEmbalagemId.Text := '0';//EdtVolumeId.Text;
           EdtCaixaEmbalagemIdExit(EdtCaixaEmbalagemId);
        End;
        BuscarVolumeParaSeparacao;
     End
     Else SelectNext(ActiveControl, True, True);
  End
  Else
     If Sender = EdtCaixaEmbalagemId then EdtVolumeId.Clear
end;

procedure TFrmSeparacaoDesktop.EdtCodBarraChange(Sender: TObject);
begin
  inherited;
  Exit;
  if EdtCodBarra.Text = '' then Begin
     LblProduto.Caption    := '';
     LblLote.Caption       := '';
     LblVencimento.Caption := '';
     LblCodBarraProd.Text  := '';
  End;
end;

procedure TFrmSeparacaoDesktop.EdtCodBarraEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmSeparacaoDesktop.EdtCodBarraExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmSeparacaoDesktop.EdtCodBarraKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var vCod : Integer;
    vCodBarra   : String;
    vQtdSuprida : Integer;
begin
//  inherited;
  if (Key = VK_F12) and (PnlDigitacao.Enabled) then Begin
     if Application.MessageBox('Cancelar Separação', 'Deseja Cancelar a Separação do Volume?', MB_YESNO) = MrYes then Begin
        DesativarCheckIn;
        if ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.VolumeSeparacaoId > 0 then
           ObjVolumeSeparacaoCtrl.DelVolumeSeparacao;
        Exit;
     End;
  End;
{
   if (Key = Vk_F3) then begin
      F3Press := True;
      PnlQtde.Enabled      := True;
      EdtSeparado.ReadOnly := False;
      EdtSeparado.SetFocus;
   end;
}
  if (key = vk_F5) then begin
     LogOff;
  end

  Else If (Key = vk_F6) and (Confirmacao('Corte', 'Deseja cortar '+(FdMemLotes.FieldByName('Quantidade').AsInteger-(StrToIntDef(EdtSeparado.Text, 0))).ToString()+' unidades?', True)) then Begin
     FdMemLotes.Edit;
     FdMemLotes.FieldByName('QtdSuprida').AsInteger := FdMemLotes.FieldByName('Quantidade').AsInteger - (FdMemLotes.FieldByName('Quantidade').AsInteger-(StrToIntDef(EdtSeparado.Text, 0)));
     FdMemLotes.Post;
     SalvarSeparacao;
     FdMemLotes.Next;
     if FdMemLotes.Eof then
        FinalizarSeparacao
     Else Begin
       LimparDigitacao;
       GetDadosItens;
     End;
  End

  Else If (Key = 13) then Begin
     If (StrToInt64Def(EdtCodBarra.Text, 0)<>0) Then Begin
        vCod := TProdutoCtrl.GetCodProdEan(EdtCodBarra.Text);
        if vCod = 0 then Begin
           vCodBarra := EdtCodBarra.Text;
           EdtCodBarra.Clear;
           raise Exception.Create('Código de Produto('+vCodBarra+') inválido!');
        End
        Else If ((FrmeXactWMS.ConfigWMS.ObjConfiguracao.SeparacaoCodInterno=0) and
              (vCod = FdMemLotes.FieldByName('ProdutoId').AsInteger)) then Begin
           EdtCodBarra.Clear;
           EdtCodBarra.SetFocus;
           ShowErro('Informe o Ean do produto!');
           Exit;
        End;
        if vCod <> FdMemLotes.FieldByName('ProdutoId').AsInteger then  Begin
           vCodBarra := EdtCodBarra.Text;
           EdtCodBarra.Clear;
           raise Exception.Create('Produto('+vCodBarra+') não encontrado!');
        End;
        FdMemLotes.Edit;
//        if FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger = 1 then
//           vQtdSuprida   := StrToIntDef(EdtSeparado.Text, 0)* FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger
//        else vQtdSuprida := FdMemLotes.FieldByName('Quantidade').AsInteger;
        If (Not F3Press) and (FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepProdIndividual = 1) then
           EdtSeparado.Value := EdtSeparado.Value + 1;
//        Else EdtSeparado.Value := EdtSeparado.Value;
        vQtdSuprida := StrToIntDef(EdtSeparado.Text, 0)*FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger;
        FdMemLotes.FieldByName('QtdSuprida').AsInteger := vQtdSuprida; //StrToIntDef(EdtSeparado.Text, 0);
        if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepProdIndividual = 0) or (FdMemLotes.FieldByName('QtdSuprida').AsInteger >= FdMemLotes.FieldByName('Quantidade').AsInteger) then Begin
           SalvarSeparacao;
           FdMemLotes.Next;
           if FdMemLotes.Eof then
              FinalizarSeparacao
           Else Begin
             LimparDigitacao;
             GetDadosItens;
           End;
        End
        Else Begin
           EdtCodBarra.Clear;
           EdtCodBarra.SetFocus;
        End;
     End;
  End;
end;

procedure TFrmSeparacaoDesktop.EdtSeparadoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmSeparacaoDesktop.EdtSeparadoExit(Sender: TObject);
begin
  inherited;
  if (F3Press) then Begin
     if (EdtSeparado.Value < 0) or ((EdtSeparado.Value=0) and (EdtSeparado.Text<>'0')) then Begin
        PnlQtde.Enabled  := True;
        EdtQtde.ReadOnly := False;
        raise Exception.Create('Quantidade inválida!');
     End
     Else if (EdtSeparado.Value > EdtQtde.Value) then begin
        PnlQtde.Enabled  := True;
        EdtQtde.ReadOnly := False;
        raise Exception.Create('Quantidade inválida, maior que demanda.');
     end;
  End;
  EdtCodBarra.SetFocus;
  EdtSeparado.ReadOnly := True;
  PnlQtde.Enabled      := False;
  ExitFocus(Sender);
end;

procedure TFrmSeparacaoDesktop.EdtSeparadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmSeparacaoDesktop.EdtSeparadoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13 then EdtCodBarra.SetFocus;

end;

procedure TFrmSeparacaoDesktop.EdtVolumeIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmSeparacaoDesktop.FinalizarSeparacao;
begin
  ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.DtFinalizacao := Date;
  ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.HrFinalizacao := Time;
  ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.Operacao      := 1;
  //ReturnJsonObject :=
  ObjVolumeSeparacaoCtrl.FinalizarSeparacao;
  LimparDigitacao;
  ShowMessage('Processo de Separação Finalizado!!!');
  DesativarCheckIn;
  EdtVolumeId.SetFocus;
  ObjCaixaEmbalagemCtrl  := Nil;
  ObjVolumeSeparacaoCtrl := Nil;
  ObjPedidoVolumeCtrl    := Nil;
  ObjCaixaEmbalagemCtrl  := TCaixaEmbalagemCtrl.Create;
  ObjVolumeSeparacaoCtrl := TVolumeSeparacaoCtrl.Create;
  ObjPedidoVolumeCtrl    := TPedidoVolumeCtrl.Create;
end;

procedure TFrmSeparacaoDesktop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(ObjVolumeSeparacaoCtrl) then
     FreeAndNil(ObjVolumeSeparacaoCtrl);
  if Assigned(ObjCaixaEmbalagemCtrl) then
     FreeAndNil(ObjCaixaEmbalagemCtrl);
  if Assigned(ObjPedidoVolumeCtrl) then
     FreeAndNil(ObjPedidoVolumeCtrl);
  FrmSeparacaoDesktop := Nil;
end;

procedure TFrmSeparacaoDesktop.FormCreate(Sender: TObject);
begin
  inherited;
  ConfereVolumeOnOff(True);
  ObjCaixaEmbalagemCtrl  := TCaixaEmbalagemCtrl.Create;
  ObjVolumeSeparacaoCtrl := TVolumeSeparacaoCtrl.Create;
  ObjPedidoVolumeCtrl    := TPedidoVolumeCtrl.Create;
  EdtCaixaEmbalagemId.ReadOnly := False;
  EdtVolumeId.ReadOnly         := False;
  EdtCodBarra.ReadOnly         := False;
  LimparDigitacao;
end;

procedure TFrmSeparacaoDesktop.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;
  if (Key = Vk_F3) and (PnlDigitacao.Enabled) then Begin
     F3Press := True;
     PnlQtde.Enabled      := True;
     EdtSeparado.ReadOnly := False;
     EdtSeparado.SetFocus;
  End
end;

procedure TFrmSeparacaoDesktop.FormShow(Sender: TObject);
begin
  inherited;
  TabListagem.TabVisible := False;
end;

procedure TFrmSeparacaoDesktop.GetVolumeSeparacao;
Var LstVolume : TObjectList<TPedidoVolume>;
begin
  LstVolume := ObjPedidoVolumeCtrl.GetPedidoVolumeSeparacao(0, StrToIntDef(EdtVolumeId.Text, 1));
  if LstVolume.Count < 1 then
     raise Exception.Create('Volume não encontrado.');
  Case LstVolume[0].ProcessoEtapaId of
    2: raise Exception.Create('Etiqueta de expedição não impressa!');
    3, 7: Begin //3-Etiqueta Impressa 7-Apanhe Iniciado
            ObjPedidoVolumeCtrl.ObjPedidoVolume := LstVolume[0];
            If HeaderVolume then
               AtivarSeparacao;
          End;
    8, 10: Begin
             ObjPedidoVolumeCtrl.ObjPedidoVolume := LstVolume[0];
             if HeaderVolume then
                GetReConferencia;
           End;
    Else raise Exception.Create('Volume não pode ser separado. Etapa Atual: '+LstVolume[0].ProcessoEtapa);
  End;
end;

Function TFrmSeparacaoDesktop.HeaderVolume : Boolean;
Var ReturnJsonObject : TJsonObject;
    vErro : String;
begin
  Try
    Result := False;
    LblHPedido.Caption   := ObjPedidoVolumeCtrl.ObjPedidoVolume.Pedido.PedidoId.ToString();
    LblHDtPedido.Caption := DateToStr(ObjPedidoVolumeCtrl.ObjPedidoVolume.Pedido.DocumentoData);
    LblHCliente.Caption  :=  ObjPedidoVolumeCtrl.ObjPedidoVolume.Pedido.Pessoa.Razao;
    ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.UsuarioId := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId;
    ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.CaixaEmbalagemId := StrToIntDef(EdtCaixaEmbalagemId.Text, 0);
    if StartSeparacao then Begin
       ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.DtInicio := Date;
       ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.HrInicio := Time;
    End;
    ReturnJsonObject := ObjVolumeSeparacaoCtrl.FinalizarSeparacao;
    if ReturnJsonObject.TryGetValue('Erro', vErro) then Begin
       ShowErro('Erro: '+vErro);
       Limpar;
       EdtCaixaEmbalagemId.Clear;
       EdtVolumeId.Clear;
       EdtCaixaEmbalagemId.SetFocus;
    End
    Else Begin
       ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.VolumeSeparacaoId := ReturnJsonObject.GetValue<Integer>('volumeseparacaoid', 0);
       if ReturnJsonObject.TryGetValue<String>('Erro', vErro) then
          ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.VolumeSeparacaoId := ReturnJsonObject.GetValue<Integer>('separacaovolumeid');
       GetItens;
       Result := True;
    End;
  Except On E: Exception do Begin
    Limpar;
    EdtCaixaEmbalagemId.Clear;
    EdtVolumeId.Clear;
    EdtCaixaEmbalagemId.SetFocus;
    ShowErro('Erro: '+E.Message, 'alerta');
    End;
  End;
end;

procedure TFrmSeparacaoDesktop.LimparDigitacao;
begin
  EdtCodBarra.Clear;
  LblProduto.Caption    := '';
  LblLote.Caption       := '';
  LblVencimento.Caption := '';
  LblCodBarraProd.Text  := '';
  EdtEndereco.Clear;
  PnlQtde.Enabled       := False;
  EdtQtde.ReadOnly      := True;
  F3Press               := False;
  EdtQtde.Clear;
  EdtUnid.Clear;
  EdtSeparado.Clear;
end;

procedure TFrmSeparacaoDesktop.LimparHeader;
begin
  EnabledButtons        := False;
  EdtVolumeId.Clear;
  LblHPedido.Caption    := '';
  LblHDtPedido.Caption  := '';
  LblHCliente.Caption   := '';
  LblProduto.Caption    := '';
  LblLote.Caption       := '';
  LblVencimento.Caption := '';
  If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.IdentCaixaApanhe = 1) then begin
     EdtCaixaEmbalagemId.Visible := True;
     EdtCaixaEmbalagemId.SetFocus;
  end
  Else Begin
     EdtCaixaEmbalagemId.Visible := False;
     EdtVolumeId.SetFocus;
  End;
end;

procedure TFrmSeparacaoDesktop.LogOff;
var ReturnJson : TJsonObject;
    vErro      : String;
begin
  //Save LogOff
  ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.UsuarioId := 0;
  ReturnJson := ObjVolumeSeparacaoCtrl.FinalizarSeparacao;
  ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.VolumeSeparacaoId := ReturnJson.GetValue<Integer>('volumeseparacaoid', 0);
  if ReturnJson.TryGetValue<String>('Erro', vErro) then
     ShowErro(vErro)
  Else
     DesativarCheckIn;
end;

procedure TFrmSeparacaoDesktop.SalvarSeparacao;
Var JsonSeparacao : tjsonObject;
Begin
  JsonSeparacao := tjsonObject.Create;
  JsonSeparacao.AddPair('pedidovolumeloteid', TJSONNumber.Create(FdMemLotes.FieldByName('PedidoVolumeLoteId').AsInteger));
  JsonSeparacao.AddPair('qtdsuprida', TJSONNumber.Create(FdMemLotes.FieldByName('QtdSuprida').AsInteger));
  JsonSeparacao.AddPair('usuarioid',  TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonSeparacao.AddPair('estacao', NomeDoComputador);
  ObjVolumeSeparacaoCtrl.SaveSeparacao(JsonSeparacao);
  JsonSeparacao.DisposeOf;
  LimparDigitacao;
End;

procedure TFrmSeparacaoDesktop.GetDadosItens;
Begin
  EdtEndereco.Text     := EnderecoMask(FdMemLotes.FieldByName('EnderecoDescricao').AsString, FdMemLotes.FieldByName('Mascara').AsString, True);
   if FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger = 1 then
     EdtQtde.Value := FdMemLotes.FieldByName('Quantidade').AsInteger / FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger
  else EdtQtde.Value        := FdMemLotes.FieldByName('Quantidade').AsInteger;
  if FrmeXactWMS.ConfigWMS.ObjConfiguracao.BeepProdIndividual = 1 then
     EdtSeparado.Value    := 0
  else EdtSeparado.Value := FdMemLotes.FieldByName('Quantidade').AsInteger;//EdtQtde.Value;
  EdtSeparado.MaxValue := EdtQtde.Value;
  if FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger = 1 then
     EdtUnid.Text := 'Un'
  else EdtUnid.Text := 'CX('+FdMemLotes.FieldByName('EmbalagemPadrao').AsString+')';
  LblProduto.Caption    := FdMemLotes.FieldByName('CodProduto').AsString+' '+FdMemLotes.FieldByName('Descricao').AsString;;
  LblCodBarraProd.Text  := FdMemLotes.FieldByName('CodProduto').AsString;
  LblLote.Caption       := FdMemLotes.FieldByName('DescrLote').AsString;
  LblVencimento.Caption := DateToStr(FdMemLotes.FieldByName('Vencimento').AsDateTime);
  EdtCodBarra.SetFocus;
end;

procedure TFrmSeparacaoDesktop.GetItens;
Var xItens, vPosReg : Integer;
begin
//  ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes.Count;
  vPosReg := 0;
  if not (FdMemLotes.Active) then
     FdMemLotes.Open;
  FdMemLotes.EmptyDataSet;
  for xItens := 0 to Pred(ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes.Count) do Begin
    FdMemLotes.Append;
    FdMemLotes.FieldByName('PedidoVolumeLoteId').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].PedidoVolumeLoteId;
    FdMemLotes.FieldByName('PedidoVolumeId').AsInteger     := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].PedidoVolumeId;
    FdMemLotes.FieldByName('ProdutoId').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Lote.Produto.IdProduto;
    FdMemLotes.FieldByName('CodProduto').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Lote.Produto.CodProduto;
    FdMemLotes.FieldByName('Descricao').AsString   := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Lote.Produto.Descricao;
    FdMemLotes.FieldByName('LoteId').AsInteger   := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Lote.Lotes.LoteId;
    FdMemLotes.FieldByName('DescrLote').AsString := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Lote.Lotes.DescrLote;
    FdMemLotes.FieldByName('Vencimento').AsDateTime := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Lote.Lotes.Vencimento;
    FdMemLotes.FieldByName('EnderecoId').AsInteger  := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Endereco.EnderecoId;
    FdMemLotes.FieldByName('EnderecoDescricao').AsString := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Endereco.Descricao;
    FdMemLotes.FieldByName('Mascara').AsString := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Endereco.EnderecoEstrutura.Mascara;
    FdMemLotes.FieldByName('RuaId').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Endereco.EnderecoRua.RuaId;
    FdMemLotes.FieldByName('RuaDescricao').AsString := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Endereco.EnderecoRua.Descricao;
    FdMemLotes.FieldByName('Quantidade').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Quantidade;
    FdMemLotes.FieldByName('EmbalagemPadrao').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].EmbalagemPadrao;
    FdMemLotes.FieldByName('QtdSuprida').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].QtdSuprida;
    if (ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.EnderecoId <> 0) and (ObjVolumeSeparacaoCtrl.ObjVolumeSeparacao.EnderecoId = ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[xItens].Endereco.EnderecoId) then
       vPosReg := xItens + 1;
    //Dados do CheckIn para Gravacao
//    FdMemLotes.FieldByName('VolumeLoteCheckIn').AsInteger := ObjPedidoVolumeCtrl.ObjPedidoVolume.Lotes[0].VolumeLoteCheckIn;
  End;
  FdMemLotes.RecNo := vPosReg+1;
End;

procedure TFrmSeparacaoDesktop.GetReConferencia;
Begin
  AtivarSeparacao;
End;

function TFrmSeparacaoDesktop.GetCodigoERP(pCodigoERP: String): Boolean;
Var ObjProdutoCtrl : TProdutoCtrl;
    xListaProd     : Integer;
    vCodProdutoId  : Integer;
begin


end;

end.
