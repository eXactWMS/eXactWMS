unit uFrmCheckOut;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types, FMX.Platform,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, System.Generics.Collections,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Objects, ksTypes,
  ksLoadingIndicator, FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani,
  FMX.ListView, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.Layouts, System.JSON, REST.Json, Rest.Types, DataSet.Serialize, FMX.DialogService;

type
  TOperacao = (opCheckOut, opReCheckOut);

  TFrmCheckOut = class(TFrmBase)
    LytSeparacao: TLayout;
    RctApanhe: TRectangle;
    LytDigitacaoApanhe: TLayout;
    LytBeepProduto: TLayout;
    Label9: TLabel;
    EdtProduto: TEdit;
    Line3: TLine;
    LytQtdDemanda: TLayout;
    Label10: TLabel;
    EdtQtdDemanda: TEdit;
    LytUnid: TLayout;
    Label12: TLabel;
    EdtUnid: TEdit;
    LytQtdApanhe: TLayout;
    Label11: TLabel;
    EdtQtdApanhe: TEdit;
    Line4: TLine;
    LytEndereco: TLayout;
    LblEndereco: TLabel;
    LytProduto: TLayout;
    RctProduto: TRectangle;
    LblProduto: TLabel;
    Label6: TLabel;
    LytRodape: TLayout;
    RctRodape: TRectangle;
    LytRodapeLeft: TLayout;
    Rectangle1: TRectangle;
    Label2: TLabel;
    LytSkuVolume: TLayout;
    LblSkuVolume: TLabel;
    LytRodapeRight: TLayout;
    Rectangle2: TRectangle;
    Label4: TLabel;
    Layout1: TLayout;
    LblSkuSeparada: TLabel;
    LytTeclaFuncao: TLayout;
    RctF9: TRectangle;
    LblF10: TLabel;
    VsbLotes: TVertScrollBox;
    LytLotesItem: TLayout;
    retOffset: TRectangle;
    RctLoteItem: TRectangle;
    Label15: TLabel;
    Label16: TLabel;
    LblLote: TLabel;
    LblVencimento: TLabel;
    LblQuantidade: TLabel;
    Label19: TLabel;
    LytDetalheVolume: TLayout;
    RctCabecalho: TRectangle;
    Layout02: TLayout;
    Layout3: TLayout;
    Label3: TLabel;
    LblPedido: TLabel;
    Layout4: TLayout;
    Label5: TLabel;
    LblRota: TLabel;
    Layout5: TLayout;
    LblDestino: TLabel;
    Label7: TLabel;
    Layout01: TLayout;
    EdtDtPedido: TEdit;
    Line6: TLine;
    EdtEmbalagemId: TEdit;
    Line5: TLine;
    EdtVolumeId: TEdit;
    Line1: TLine;
    Label1: TLabel;
    Label8: TLabel;
    LblEmbalagemId: TLabel;
    MPlayer: TMediaPlayer;
    actCancelarVolume: TAction;
    QryListaPadraoPedidoVolumeId: TIntegerField;
    QryListaPadraoProdutoid: TIntegerField;
    QryListaPadraoCodProduto: TIntegerField;
    QryListaPadraoCodBarras: TStringField;
    QryListaPadraoDescricao: TStringField;
    QryListaPadraounidadesecundariasigla: TStringField;
    QryListaPadraoendereco: TStringField;
    QryListaPadraomascara: TStringField;
    QryListaPadraoDemanda: TIntegerField;
    QryListaPadraoembalagempadrao: TIntegerField;
    QryListaPadraoqtdsuprida: TIntegerField;
    LblProd2: TLabel;
    RctF5: TRectangle;
    LblF5: TLabel;
    RctF8: TRectangle;
    LblF8: TLabel;
    FDMemProdutoCodBarras: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtProdutoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Ac_OkExecute(Sender: TObject);
    procedure actCancelarVolumeExecute(Sender: TObject);
  private
    { Private declarations }
    StartSeparacao         : Boolean;
    F3Press : Boolean;
    Operacao : TOperacao;
    vProdutoId : iNTEGER; //Id do Produto Digitado
    Function ValidarVolume : Boolean;
    Procedure CabecalhoPedido(pPedidoId : Integer; pRazao, pDocumentoData : String; pRotaid : Integer);
    Procedure GetInicioCheckout;
    Procedure CancelarVolume;
    Procedure StartCheckOut;
    Procedure MontaListaProdutoLotes;
    procedure LimparLista(Sender: TObject; AVertScroll: TVertScrollBox;
      ARectBase: string);
    procedure OnSelecionarLotes(Sender: TObject);
    Procedure AtualizaCheckOut;
    Procedure SalvarCheckOut;
    Procedure ResetVolume;
    procedure ConfirmaResetVolume(pPedidoVolumeId: Integer);
    Procedure ThreaConfirmaResetVolumeTerminate(Sender: TObject);
    Procedure Limpar; OverRide;
    procedure StartCheckOutColetor(pJsonArrayProduto: TJsonArray);
  Protected
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCheckOut: TFrmCheckOut;

implementation

{$R *.fmx}

uses uFrmeXactWMS, uFuncoes, uDmClient, Notificacao, uLibThread, U_MsgD,
  PedidoVolumeCtrl;

procedure TFrmCheckOut.actCancelarVolumeExecute(Sender: TObject);
Var ObjPedidoVolumeCtrl      : TPedidoVolumeCtrl;
    JsonArrayVolumeExtra     : TJsonArray;
    JsonObjectCancelarVolume : TJsonObject;
    vErro : String;
begin
  inherited;
  Try
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    JsonObjectCancelarVolume := TJsonObject.Create;
    JsonObjectCancelarVolume.AddPair('pedidoId', TJsonNumber.Create(0));
    JsonObjectCancelarVolume.AddPair('pedidoVolumeId', TJsonNumber.Create(StrToIntDef(EdtVolumeId.Text, 0)));
    JsonObjectCancelarVolume.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    JsonObjectCancelarVolume.AddPair('terminal', NomeDoComputador);
    ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    JsonArrayVolumeExtra   := ObjPedidoVolumeCtrl.CancelarVolume(JsonObjectCancelarVolume);
    if Not JsonArrayVolumeExtra.Items[0].TryGetValue('Erro', vErro) then Begin
       MensagemStand('Volume('+EdtVolumeId.Text+') Cancelado com sucesso');
       Limpar;
    End
    Else Begin
       SetCampoDefault('EdtVolumeId');
       ShowErro('Não foi possível Cancelar! '+vErro, 'alerta');
    End;
    JsonObjectCancelarVolume.Free;
    JsonArrayVolumeExtra := Nil;
    ObjPedidoVolumeCtrl.Free;
  Except On E: Exception do Begin
    JsonObjectCancelarVolume.Free;
    JsonArrayVolumeExtra := Nil;
    ObjPedidoVolumeCtrl.Free;
    Limpar;
    Raise Exception.Create('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmCheckOut.Ac_OkExecute(Sender: TObject);
begin
  inherited;
  //Limpar;
end;

procedure TFrmCheckOut.AtivaCampoDefault;
begin
  inherited;
  inherited;
   if CampoDefault = 'EdtVolumeId' then Begin
     EdtVolumeId.Text := '';
     DelayEdSetFocus(EdtVolumeId);
  End
  Else if CampoDefault = 'EdtProduto' then Begin
     EdtProduto.Text := '';
     DelayEdSetFocus(EdtProduto);
  End;
end;

procedure TFrmCheckOut.AtualizaCheckOut;
Var pQtdCheckOut   : Integer;
    vCodDigitado : String;
    JsonObjectRetorno : TJsonObject;
    vErro : String;
begin
  vCodDigitado := EdtProduto.Text;
  if (StrToIntDef(EdtProduto.Text, 0) <> FDMemProdutoCodBarras.FieldByName('Produtoid').AsInteger) then Begin
{     JsonObjectRetorno := DmClient.GetCodProdEan(EdtProduto.Text);
     if JsonObjectRetorno.TryGetValue('Erro', vErro) then Begin
        SetCampoDefault('EdtProduto');
        ShowErro('Erro: '+vErro);
        JsonObjectRetorno := Nil;
        Exit;
     End;
}
     vProdutoId := 0;
     if (FDMemProdutoCodBarras.Locate('CodBarras', EdtProduto.Text, [])) then
        vProdutoId :=  JsonObjectRetorno.GetValue<Integer>('produtoid');
     if (vProdutoId <= 0) Then Begin
        SetCampoDefault('EdtProduto');
        MensagemStand('Código/Ean do produto inválido!');
        Exit;
     End;
{     if (FrmeXactWMS.ConfigWMS.SeparacaoCodInterno = 0) and
        (vProdutoId<>0) and (EdtProduto.Text <> JsonObjectRetorno.GetValue<String>('ean')) then Begin
        SetCampoDefault('EdtProduto');
        JsonObjectRetorno := Nil;
        MensagemStand('Informe o Ean do produto!');
        Exit;
     End;
     if vProdutoId <= 0 then Begin
        EdtProduto.Text := '';
        SetCampoDefault('EdtProduto');
        MensagemStand('Produto('+vCodDigitado+') não encontrado!');
        JsonObjectRetorno := Nil;
        Exit;
     End;
     if Not (QryListaPadrao.Locate('ProdutoId', vProdutoId, [])) then Begin
        EdtProduto.Text := '';
        SetCampoDefault('EdtProduto');
        MensagemStand('Produto('+vCodDigitado+') não faz parte deste volume!');
        JsonObjectRetorno := Nil;
        Exit;
     End;
}  End;
  if F3Press then Begin
     if (Trunc(StrToIntDef(EdtQtdApanhe.Text, 0)) Mod QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger) <> 0 then Begin
        SetCampoDefault('EdtQtdApanhe');
        MensagemStand('Quantidade precisa ser equivalente a embalagem.');
        JsonObjectRetorno := Nil;
        Exit;
     End;
     pQtdCheckOut := StrToIntDef(EdtQtdApanhe.Text, 0);
  End
  Else pQtdCheckOut := QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger;
  pQtdCheckOut      := QryListaPadrao.FieldByName('Demanda').AsInteger;
  EdtQtdApanhe.Text := QryListaPadrao.FieldByName('Demanda').AsString;
  F3Press := False;
  JsonObjectRetorno := Nil;
  SalvarCheckOut;
end;

procedure TFrmCheckOut.SalvarCheckOut;
Var JsonConferencia      : TJsonObject;
    JsonArrayConferencia : TJsonArray;
    xProd                : Integer;
    vDivergencia         : Boolean;
    vErro                : String;
    JsonArrayVolumeExtra : TJsonArray;
    vTotCheckOut         : Integer;
    ObjVolumeCtrl        : TPedidoVolumeCtrl;
    JsonArrayRetorno     : TJsonArray;
    vContErro            : Integer;
begin
  Try
    ObjVolumeCtrl := TPedidoVolumeCtrl.Create;
    ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    if Operacao = opCheckOut then Begin
       ObjVolumeCtrl.RegistrarDocumentoEtapa(10);
       if (ObjVolumeCtrl.ObjPedidoVolume.VolumeEmbalagem.EmbalagemId = 0) and
          (FrmeXactWMS.ConfigWMS.VolCxaFechadaExpedicao = 1) then begin
          vContErro := 0;
          Repeat
            if FrmeXactWMS.ConfigWMS.ExpedicaoOffLine = 0 then
               JsonArrayRetorno := ObjVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoqueJson(13)
            Else JsonArrayRetorno := ObjVolumeCtrl.RegistrarDocumentoEtapaSemBaixaEstoqueJson(13);
            if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
               If vContErro <= 4 then Begin
                  Inc(vContErro);

               End
               else Begin
                  SetCampoDefault('EdtVolumeId');
                  ShowErro('Erro: '+vErro);
                  vContErro := 0;
                  JsonArrayRetorno := Nil;
                  ObjVolumeCtrl.Free;
                  Limpar;
                  Exit;
               End;
            End
            Else
               vContErro := 0;
            JsonArrayRetorno := Nil;
          Until vContErro = 0;
       End;
    End
    Else ObjVolumeCtrl.RegistrarDocumentoEtapa(12);
    ObjVolumeCtrl.Free;
    if FrmeXactWMS.ConfigWMS.VolCxaFechadaExpedicao = 1 then
       ShowOk('CheckOut concluído. Expedição Automática.')
    Else
       ShowOk('CheckOut concluído. Direcione para expedição');
    Limpar;
    //JsonConferencia := Nil;
    //JsonArrayConferencia.Free;// := Nil;
  Except On E: Exception do Begin
    //JsonConferencia := Nil;
    //JsonArrayConferencia.Free;// := Nil;
    SetCampoDefault('EdtProduto');
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmCheckOut.CabecalhoPedido(pPedidoId: Integer; pRazao,
  pDocumentoData: String; pRotaid: Integer);
begin
  LblPedido.Text   := pPedidoId.ToString();
  LblDestino.Text  := Copy(pRazao, 1, 25);
  EdtDtPedido.Text := Copy(pDocumentoData, 9, 2)+'/'+Copy(pDocumentoData, 6, 2)+'/'+Copy(pDocumentoData, 1, 4);
  LblRota.Text     := pRotaId.ToString();
end;

procedure TFrmCheckOut.CancelarVolume;
begin
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Cancelar CheckOut';
  MsgD.Text       := 'Deseja realmente Cancelar?';
  MsgD.ActionOk   := actCancelarVolume;
  MsgD.ActionCancel := Ac_Ok;
  MsgD.TypeInfo   := tMsgDWarning;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
end;

procedure TFrmCheckOut.ConfirmaResetVolume(pPedidoVolumeId: Integer);
Var TH : TThread;
Begin
  TH := TThread.CreateAnonymousThread(procedure
  Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
      JsonArrayRetorno : TJsonArray;
      vErro : String;
  begin
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    JsonArrayRetorno := ObjPedidoVolumeCtrl.ResetSeparacao;
    if JsonArrayRetorno.TryGetValue('Erro', vErro) then Begin
       JsonArrayRetorno := Nil;
       ObjPedidoVolumeCtrl.Free;
       Raise Exception.Create(vErro);
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
  End);
  TH.OnTerminate := ThreaConfirmaResetVolumeTerminate;
  TH.Start;
end;

procedure TFrmCheckOut.EdtProdutoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if key = vkF5 then
       Limpar
  Else if Key = vkF8 then
     ResetVolume
  Else If Key = vkF9 then
//     CancelarVolume   //Para ativar color RctF9.Visible := True;
  Else if Key = vkReturn then Begin
     if StrToInt64Def(EdtProduto.Text, 0 ) > 0 then
        AtualizaCheckOut
     else if EdtProduto.Text <> '' Then Begin
        SetCampoDefault('EdtProduto');
        ShowErro('Código/Ean de produto inválido!');
     End;
  End;
end;

procedure TFrmCheckOut.EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  SoNumeros(KeyChar);
  inherited;
  if StrToIntDef(EdtVolumeId.Text, 0) = 0 then Exit;
  if key = 13 then Begin
     if not ValidarVolume then Begin
        EdtVolumeId.Text := '';
        DelayedSetFocus(EdtVolumeId);
        exit;
     End
     Else
        GetInicioCheckout;
  End;
end;

procedure TFrmCheckOut.FormActivate(Sender: TObject);
begin
  inherited;
  DelayedSetFocus(EdtVolumeId);
end;

procedure TFrmCheckOut.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCheckOut := Nil;
end;

procedure TFrmCheckOut.FormCreate(Sender: TObject);
begin
  inherited;
  PgcPrincipal.ActiveTab := TabDetalhes;
  PgcPrincipal.Repaint;
  LblEmbalagemId.Visible := False;
  EdtEmbalagemId.Visible := False;
  BtnArrowLeft.Enabled   := False;
  BtnArrowRigth.Enabled  := False;
  //Limpar;
end;

procedure TFrmCheckOut.GetInicioCheckout;
Var JsonArrayVolumeSeparacao : TJsonArray;
    vErro : String;
begin
  RctCabecalho.Enabled := False;
  RctApanhe.Enabled    := True;
  DelayEdSetFocus(EdtProduto);
end;

procedure TFrmCheckOut.Limpar;
begin
  inherited;
  EdtEmbalagemId.Text := '';
  EdtEmbalagemId.Visible := False;
  LblEmbalagemId.Visible := False;
  DelayedSetFocus(EdtVolumeId);
  EdtDtPedido.Text     := '';
  LblPedido.Text       := '';
  LblDestino.Text      := '';
  LblRota.Text         := '';
  LblEndereco.Text     := '';
  LblProduto.Text      := '';
  LblProd2.Text        := '';
  EdtVolumeId.Text     := '';
  LblSkuVolume.Text    := '';
  LblSkuSeparada.Text  := '';
  RctCabecalho.Enabled := True;
  RctApanhe.Enabled    := False;

  EdtProduto.Text     := '';
  EdtQtdDemanda.Text  := '';
  EdtUnid.Text        := '';
  EdtQtdApanhe.Text   := '';
  If QryListaPadrao.Active then
     QryListaPadrao.EmptyDataSet;
  QryListaPadrao.Close;
end;

procedure TFrmCheckOut.LimparLista(Sender: TObject; AVertScroll: TVertScrollBox;
  ARectBase: string);
var
  I      : Integer;
  lFrame : Tlayout;
begin
  //Pesquisar e deixar isso no formulário padrão de listas.
  AVertScroll.BeginUpdate;
  for I := Pred(AVertScroll.Content.ChildrenCount) downto 0 do
  begin
    if (AVertScroll.Content.Children[I] is Tlayout) then
    begin
      if not (Tlayout(AVertScroll.Content.Children[I]).Name = LytLotesItem.Name) then
      begin
        lFrame := (AVertScroll.Content.Children[I] as Tlayout);
        lFrame.DisposeOf;
        lFrame := nil;
      end;
    end;
  end;
  AVertScroll.EndUpdate;
end;

procedure TFrmCheckOut.MontaListaProdutoLotes;
Var ReturnJsonArray : TJsonArray;
Begin
  TLibrary.CustomThread(
    procedure ()
    begin
      //Start do processamento
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          TLoading.Show(FrmeXactWMS, 'Carregando Lotes...');
          Self.VsbLotes.Visible := False;
          Self.VsbLotes.BeginUpdate;
          Self.LimparLista(FrmeXactWMS, VsbLotes, LytLotesItem.Name);
          //DM.QryCidades.DisableControls;
        end
      );
    end,
    procedure ()
    var
      LFrame        : TLayout;
      LPos          : Single;
      X : Integer;
      vErro : String;
    begin
      LPos                      := 8;
      LytLotesItem.Visible     := False;
        While Not QrylistaPadrao.Eof do Begin
           //Preencher os dados
           Self.LblLote.Text       := ReturnJsonArray.Items[X].GetValue<String>('lote');
           Self.LblVencimento.Text := Copy(ReturnJsonArray.Items[X].GetValue<String>('vencimento'), 9, 2)+'/'+
                                      Copy(ReturnJsonArray.Items[X].GetValue<String>('vencimento'), 6, 2)+'/'+
                                      Copy(ReturnJsonArray.Items[X].GetValue<String>('vencimento'), 1, 4);
           Self.LblQuantidade.Text := ReturnJsonArray.Items[X].GetValue<Integer>('demanda').ToString();
           LytLotesItem.Tag        := X; //DM.QryCidadesCID_ID.AsInteger;

           LFrame                  := TLayout(LytLotesItem.Clone(VsbLotes));
           LFrame.Parent           := VsbLotes;
           LFrame.Height           := LytLotesItem.Height - 4;
           LFrame.Width            := LytLotesItem.Width;

           LFrame.Position.X       := 4;
           LFrame.Position.Y       := LPos;
           LFrame.Margins.Left     := 4;
           LFrame.Margins.Top      := 4;
           LFrame.Margins.Bottom   := 4;
           LFrame.Margins.Right    := 4;


           for var I : Integer := 0 to Pred(LFrame.ComponentCount) do
           begin
             if LFrame.Components[I] is TSpeedButton then
             begin
               TThread.Synchronize(
                 TThread.CurrentThread,
                 procedure ()
                 begin
                   TSpeedButton(LFrame.Components[I]).OnClick := OnSelecionarLotes;
                 end
               );
               break;
             end;
           end;

           LFrame.Visible          := True;

           LPos                    := LPos + LytLotesItem.Height + 4;

           QryListaPadrao.Next;
        end;
//      End;
    end,
    procedure ()
    begin
      //Complete
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          TLoading.Hide;
          Self.VsbLotes.EndUpdate;
          Self.VsbLotes.Visible := True;
        end
      );
    end,
    procedure (const AException : string)
    begin
      MensagemStand(AException);
    end,
    True
  );
end;

procedure TFrmCheckOut.OnSelecionarLotes(Sender: TObject);
begin

end;

procedure TFrmCheckOut.ResetVolume;
begin
  If (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Separação - Resetar Volume')) then Begin
     SetCampoDefault('EdtVolumeId');
     ShowErro('Usuário não autorizado!', 'alarme');
     Exit;
  End;
  TDialogService.MessageDialog('Resetar o volume('+EdtVolumeId.Text+')?',
               TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
   procedure(const AResult: TModalResult)
   begin
     if AResult = mrYes then Begin
        ConfirmaResetVolume(StrToIntDef(EdtVolumeId.Text, 0));
     End;
   End);
end;

procedure TFrmCheckOut.ThreaConfirmaResetVolumeTerminate(
  Sender: TObject);
begin
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then begin
        SetCampoDefault('EdtProduto');
        ShowErro(Exception(TThread(sender).FatalException).Message);
        exit;
     end;
  end;
  Limpar;
end;

procedure TFrmCheckOut.StartCheckOutColetor(pJsonArrayProduto : TJsonArray);
Var Svc: IFMXClipboardService;
    xProd : Integer;
begin
  If QryListaPadrao.Active then
     QryListaPadrao.EmptyDataSet;
  QryListaPadrao.Close;
  QryListaPadrao.Open;
  For xProd := 0 To Pred(pJsonArrayProduto.Count) do Begin
    QryListaPadrao.Append;
    QryLIstaPadrao.FieldByName('pedidovolumeid').AsInteger  := pJsonArrayProduto.Items[xProd].GetValue<Integer>('pedidovolumeid');
    QryLIstaPadrao.FieldByName('produtoid').AsInteger       := pJsonArrayProduto.Items[xProd].GetValue<Integer>('produtoid');
    QryLIstaPadrao.FieldByName('codproduto').AsInteger      := pJsonArrayProduto.Items[xProd].GetValue<Integer>('codproduto');
    QryLIstaPadrao.FieldByName('codbarras').AsString        := pJsonArrayProduto.Items[xProd].GetValue<String>('codbarras');
    QryLIstaPadrao.FieldByName('descricao').AsString        := pJsonArrayProduto.Items[xProd].GetValue<String>('descricao');
    QryLIstaPadrao.FieldByName('unidadesecundariasigla').AsString := pJsonArrayProduto.Items[xProd].GetValue<String>('unidadesecundariasigla');
    QryLIstaPadrao.FieldByName('endereco').AsString         := pJsonArrayProduto.Items[xProd].GetValue<String>('endereco');
    QryLIstaPadrao.FieldByName('mascara').AsString          := pJsonArrayProduto.Items[xProd].GetValue<String>('mascara');
    QryLIstaPadrao.FieldByName('demanda').AsInteger         := pJsonArrayProduto.Items[xProd].GetValue<Integer>('demanda');
    QryLIstaPadrao.FieldByName('embalagempadrao').AsInteger := pJsonArrayProduto.Items[xProd].GetValue<Integer>('embalagempadrao');
    QryLIstaPadrao.FieldByName('qtdsuprida').AsInteger      := pJsonArrayProduto.Items[xProd].GetValue<Integer>('qtdsuprida');
  End;
  LblEndereco.Text := EnderecoMask(QryListaPadrao.FieldByName('Endereco').AsString,
                                     QryListaPadrao.FieldByName('Mascara').AsString, True);
  LblProduto.Text := QryListaPadrao.FieldByName('CodProduto').AsString+' '+Copy(QryListaPadrao.FieldByName('Descricao').AsString, 1, 30);
  LblProd2.Text   := Copy(QryListaPadrao.FieldByName('Descricao').AsString, 31,30);
  if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1 then
     EdtQtdApanhe.Text := '0'
  Else EdtQtdApanhe.Text := (QryListaPadrao.FieldByName('Demanda').AsInteger Div QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger).ToString();
  EdtQtdDemanda.Text := (QryListaPadrao.FieldByName('Demanda').AsInteger Div QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger).ToString();
  if QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger = 1 then
     EdtUnid.Text := QryListaPadrao.FieldByName('EmbalagemPadrao').AsString
  else EdtUnid.Text := QryListaPadrao.FieldByName('UnidadeSecundariaSigla').AsString+
                       ' c/ '+QryListaPadrao.FieldByName('EmbalagemPadrao').AsString;
  LblSkuVolume.Text := QryListaPadrao.FieldByName('Demanda').AsString;
  DelayedSetFocus(EdtProduto);
  F3Press   := False;
  EdtQtdApanhe.ReadOnly := True;
End;

procedure TFrmCheckOut.StartCheckOut;
Var JsonArrayRetorno, JsonArrayVolumeProduto : TJsonArray;
    vErro : String;
    Svc: IFMXClipboardService;
    xProd : Integer;
begin
  JsonArrayRetorno       := DmClient.RegistrarDocumentoEtapa(StrTointDef(EdtVolumeId.Text, 0), 9 );
  JsonArrayVolumeProduto := DmClient.GetVolumeProdutos(StrTointDef(EdtVolumeId.Text, 0));
  if JsonArrayVolumeProduto.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     SetCampoDefault('EdtVolumeId');
     ShowErro('Erro: '+vErro);
     Limpar;
     Exit;
  End;
  //ShowMessage('Reg: '+'Json: '+JsonArrayVolumeProduto.ToString);

  //if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
  //   Svc.SetClipboard(JsonArrayRetorno.ToString());
  If QryListaPadrao.Active then
     QryListaPadrao.EmptyDataSet;
  QryListaPadrao.Close;
  QryListaPadrao.Open;
  For xProd := 0 To Pred(JsonArrayVolumeProduto.Count) do Begin
    QryListaPadrao.Append;
    QryLIstaPadrao.FieldByName('pedidovolumeid').AsInteger  := JsonArrayVolumeProduto.Items[xProd].GetValue<Integer>('pedidovolumeid');
    QryLIstaPadrao.FieldByName('produtoid').AsInteger       := JsonArrayVolumeProduto.Items[xProd].GetValue<Integer>('produtoid');
    QryLIstaPadrao.FieldByName('codproduto').AsInteger      := JsonArrayVolumeProduto.Items[xProd].GetValue<Integer>('codproduto');
    QryLIstaPadrao.FieldByName('codbarras').AsString        := JsonArrayVolumeProduto.Items[xProd].GetValue<String>('codbarras');
    QryLIstaPadrao.FieldByName('descricao').AsString        := JsonArrayVolumeProduto.Items[xProd].GetValue<String>('descricao');
    QryLIstaPadrao.FieldByName('unidadesecundariasigla').AsString := JsonArrayVolumeProduto.Items[xProd].GetValue<String>('unidadesecundariasigla');
    QryLIstaPadrao.FieldByName('endereco').AsString         := JsonArrayVolumeProduto.Items[xProd].GetValue<String>('endereco');
    QryLIstaPadrao.FieldByName('mascara').AsString          := JsonArrayVolumeProduto.Items[xProd].GetValue<String>('mascara');
    QryLIstaPadrao.FieldByName('demanda').AsInteger         := JsonArrayVolumeProduto.Items[xProd].GetValue<Integer>('demanda');
    QryLIstaPadrao.FieldByName('embalagempadrao').AsInteger := JsonArrayVolumeProduto.Items[xProd].GetValue<Integer>('embalagempadrao');
    QryLIstaPadrao.FieldByName('qtdsuprida').AsInteger      := JsonArrayVolumeProduto.Items[xProd].GetValue<Integer>('qtdsuprida');
  End;
  LblEndereco.Text := EnderecoMask(QryListaPadrao.FieldByName('Endereco').AsString,
                                     QryListaPadrao.FieldByName('Mascara').AsString, True);
  LblProduto.Text := QryListaPadrao.FieldByName('CodProduto').AsString+' '+Copy(QryListaPadrao.FieldByName('Descricao').AsString, 1, 30);
  LblProd2.Text   := Copy(QryListaPadrao.FieldByName('Descricao').AsString, 31,30);
  if FrmeXactWMS.ConfigWMS.BeepProdIndividual = 1 then
     EdtQtdApanhe.Text := '0'
  Else EdtQtdApanhe.Text := (QryListaPadrao.FieldByName('Demanda').AsInteger Div QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger).ToString();
  EdtQtdDemanda.Text := (QryListaPadrao.FieldByName('Demanda').AsInteger Div QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger).ToString();
  if QryListaPadrao.FieldByName('EmbalagemPadrao').AsInteger = 1 then
     EdtUnid.Text := QryListaPadrao.FieldByName('EmbalagemPadrao').AsString
  else EdtUnid.Text := QryListaPadrao.FieldByName('UnidadeSecundariaSigla').AsString+
                       ' c/ '+QryListaPadrao.FieldByName('EmbalagemPadrao').AsString;
  DelayedSetFocus(EdtProduto);
  F3Press   := False;
  EdtQtdApanhe.ReadOnly := True;
end;

function TFrmCheckOut.ValidarVolume: Boolean;
Var JsonArrayVolume     : TJsonArray;
    JsonObjectVolume    : TJsonObject;
    vErro               : String;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
begin
  Try
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create();
    Result := False;
    Try
      //JsonArrayVolume := DmClient.GetVolumeeXact(StrTointDef(EdtVolumeId.Text, 0));   //Substituido pelo trecho abaixo, Indiana 050324
      JsonObjectVolume := ObjPedidoVolumeCtrl.GetPedidoCxaFechadaCheckOut(StrTointDef(EdtVolumeId.Text, 0));
      if JsonObjectVolume.TryGetValue('Erro', vErro) then Begin
         SetCampoDefault('EdtVolumeId');
         ShowErro('Erro: '+vErro);
         //FrmeXactWMS.PlaySound('notfound.wav');
      End
      Else Begin
         JsonArrayVolume := JsonObjectVolume.GetValue<TJsonArray>('volume');
         If FDMemProdutoCodBarras.Active then
            FDMemProdutoCodBarras.EmptyDataSet;
         FDMemProdutoCodBarras.Close;
         FdMemProdutoCodBarras.LoadFromJSON(JsonObjectVolume.GetValue<TJsonArray>('codbarras'), False);
         FDMemProdutoCodBarras.Open;
         Result := True;
         CabecalhoPedido(JsonArrayVolume.Items[0].GetValue<Integer>('pedidoid'),
                         JsonArrayVolume.Items[0].GetValue<String>('fantasia'),
                         DateEUAToBr( JsonArrayVolume.Items[0].GetValue<String>('documentodata')),
                         JsonArrayVolume.Items[0].GetValue<Integer>('rotaid') );
         StartCheckOutColetor(JsonObjectVolume.GetValue<TJsonArray>('produto'));
         Operacao := opCheckOut;
      End;

      Exit;

      if 1=2 then Begin //JsonArrayVolume.Items[0].TryGetValue('Erro', vErro) then Begin
         SetCampoDefault('EdtVolumeId');
         ShowErro('Erro: '+vErro);
         //FrmeXactWMS.PlaySound('notfound.wav');
      End
      Else Begin
         if JsonArrayVolume.Items[0].GetValue<Integer>('volumetipo') = 0 then Begin
            LblTituloForm.Text := 'CheckOut Volume Cxa.Fechada';
         End
         Else Begin
           SetCampoDefault('EdtVolumeId');
           ShowErro('Fracionado(s) devem ir para o CheckOut.');
           Exit;
         End;
         case JsonArrayVolume.Items[0].GetValue<Integer>('processoid') of
            2: Begin
                 SetCampoDefault('EdtVolumeId');
                 ShowErro('Imprima a etiqueta do volume!');
                 Exit
               End;
            3, 7, 8, 9: Begin Result := True; CabecalhoPedido(JsonArrayVolume.Items[0].GetValue<Integer>('pedidoid'),
                                                              JsonArrayVolume.Items[0].Getvalue<TjsonObject>('destino').GetValue<String>('fantasia'),
                                                              JsonArrayVolume.Items[0].GetValue<TJsonObject>('pedido'). GetValue<String>('documentodata'),
                                                              JsonArrayVolume.Items[0].GetValue<TJsonObject>('rota').GetValue<Integer>('rotaid') );
                 StartCheckOut;
                 Operacao := opCheckOut;
               End;
            71: Begin
                 SetCampoDefault('EdtVolumeId');
                 ShowErro('Volume em Separação. Finalize ou Envie para CheckOut!');
                 DelayEdSetFocus(EdtVolumeId);
                 Exit;
               End;
            10, 11, 12: Begin //Reconferência
                SetCampoDefault('EdtVolumeId');
                ShowErro('Não é possível Recheckout do volume ('+EdtVolumeId.Text+')!');
                End;
            Else Begin
               EdtVolumeId.Text := '';
               DelayedSetFocus(EdtVolumeId);
               ObjPedidoVolumeCtrl.Free;
               raise Exception.Create('Volume não pode ser separado. Etapa Atual: '+JsonArrayVolume.Items[0].GetValue<String>('processo'));
            End;
         end;
      End;
    Except On E: Exception do Begin
      Limpar;
      SetCampoDefault('EdtVolumeId');
      ShowErro('Erro: '+E.Message);
      End;
    End;
  Finally
    ObjPedidoVolumeCtrl.Free;
  End;
end;

end.
