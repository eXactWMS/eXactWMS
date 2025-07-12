unit uFrmExpedicao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, uMyTabOrderClassHelper,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, System.Rtti, System.Generics.Collections,
  FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Gestures, FMX.ActnList, System.Actions, FMX.TabControl,
  FMX.Edit, FMX.ScrollBox, FMX.Grid, FMX.ListView, FMX.Layouts,
  FMX.Controls.Presentation, FMX.Objects, System.JSON, REST.Json, Rest.Types,
  ksTypes, ksLoadingIndicator, FMX.Media, DataSet.Serialize, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani, FMX.ListBox
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
  TFrmExpedicao = class(TFrmBase)
    BtnSchCaixa: TSpeedButton;
    MPlayer: TMediaPlayer;
    Rectangle1: TRectangle;
    Label1: TLabel;
    EdtPedido: TEdit;
    Label2: TLabel;
    EdtDataDocumento: TEdit;
    Label3: TLabel;
    EdtDestino: TEdit;
    EdtRota: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    LblOrdem: TLabel;
    VsbVolumeParaExpedicao: TVertScrollBox;
    retOffset: TRectangle;
    RctVolumeItem: TRectangle;
    Label6: TLabel;
    LblPedidoId: TLabel;
    Label7: TLabel;
    LblVolumeId: TLabel;
    LblPedidoData: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LblRota: TLabel;
    Label11: TLabel;
    LblDestino: TLabel;
    LytVolumeItem: TLayout;
    Label12: TLabel;
    LblEmbalagem: TLabel;
    Label10: TLabel;
    RctVolumeCorte: TRectangle;
    Label13: TLabel;
    procedure EdtCodigoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure BtnArrowLeftClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Function GetVolume : Boolean;
    procedure MontalistaVolumeParaExpedicao;
    procedure OnEditPedido(ASender: TObject);
    procedure OnDeletePedido(ASender: TObject);
    procedure GetVolumeParaExpedicao(Sender: TObject);
    procedure OnSelecionarVolume(Sender: TObject);
    procedure LimparLista(Sender: TObject; AVertScroll: TVertScrollBox;
      ARectBase: string);
  Protected
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
    Procedure Limpar;
  end;

var
  FrmExpedicao: TFrmExpedicao;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, uDmClient, Providers.Frames.VolumeParaExpedicao,
  uLibThread, Loading, PedidoVolumeCtrl;

procedure TFrmExpedicao.AtivaCampoDefault;
begin
  inherited;
   if CampoDefault = 'EdtCodigo' then Begin
     EdtCodigo.Text := '';
     DelayEdSetFocus(EdtCodigo);
  End;

end;

procedure TFrmExpedicao.BtnArrowLeftClick(Sender: TObject);
begin
  inherited;
  GetVolumeParaExpedicao(BtnArrowLeft);
end;

procedure TFrmExpedicao.EdtCodigoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmExpedicao.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
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
  //Configurar HoneyWell
  //https://www.youtube.com/watch?v=3ZZwNWkhnX4&ab_channel=RF-SMART
  case Key of
    vkReturn:
      If StrToIntDef(EdtCodigo.Text, 0) > 0 then
         GetVolume; //TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
  end;
end;

procedure TFrmExpedicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmExpedicao := Nil;
end;

procedure TFrmExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  PgcPrincipal.ActiveTab := TabDetalhes;
  PgcPrincipal.Repaint;
  LstPrincipal.Visible   := False;
  //GdSearch.Visible       := True;
end;

Function TFrmExpedicao.GetVolume : Boolean;
Var JsonArrayRetorno : TjsonArray;
    vErro, vVolumeId : String;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
begin
  Limpar;
  Result := False;
  ksLoadingIndicator1.ShowLoading;
  Try
    ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
    JsonArrayRetorno := ObjPedidoVolumeCtrl.GetVolumeRegistrarExpedicao(StrToIntDef(EdtCodigo.Text, 0));
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       SetCampoDefault('EdtCodigo');
       ShowErro('Volume: ('+EdtCodigo.Text+') '+vErro, 'alarme');
       JsonArrayRetorno := Nil;
       ObjPedidoVolumeCtrl.Free;
       Limpar;
       Exit;
    End
    Else If JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') = 0 then Begin
       SetCampoDefault('EdtCodigo');
       ShowErro('Volume Sem Produto coletado. Cancele o volume!', 'alarme');
       JsonArrayRetorno := Nil;
       ObjPedidoVolumeCtrl.Free;
       Limpar;
       Exit;
    End
    Else If (FrmeXactWMS.ConfigWMS.VolumeAuditoria = 1) and (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid') <> 12) and
            (JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') <> JsonArrayRetorno.Items[0].GetValue<Integer>('demanda')) then Begin
       vVolumeId := EdtCodigo.Text;
       SetCampoDefault('EdtCodigo');
       ShowErro('Enviar Volume'+vVolumeId+' para Auditoria!', 'alarme');
       JsonArrayRetorno := Nil;
       ObjPedidoVolumeCtrl.Free;
       Limpar;
       Exit;
    End
    Else Begin
       EdtPedido.Text         := JsonArrayRetorno.Items[0].GetValue<String>('pedidoid')+' / '+JsonArrayRetorno.Items[0].GetValue<String>('pedidovolumeid');
       EdtDataDocumento.Text  := JsonArrayRetorno.Items[0].GetValue<String>('documentodata');
       EdtDestino.Text        := JsonArrayRetorno.Items[0].GetValue<String>('codpessoaerp')+' '+JsonArrayRetorno.Items[0].GetValue<String>('fantasia');
       EdtRota.Text           := JsonArrayRetorno.Items[0].GetValue<String>('rotaid')+' '+JsonArrayRetorno.Items[0].GetValue<String>('rota');
       RctVolumeCorte.Visible := (JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') <> JsonArrayRetorno.Items[0].GetValue<Integer>('demanda'));
    End;
    If Not (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid') in [8, 10, 12]) then Begin
       SetCampoDefault('EdtCodigo');
       ShowErro('Operação não permitida. Etapa Atual:'+JsonArrayRetorno.Items[0].GetValue<String>('processo'), 'apito');
    End
    Else Begin
       if (FrmeXactWMS.ConfigWMS.ExigirReconferenciaToExpedicao = 1) and
           (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid')<> 12) and
           (JsonArrayRetorno.Items[0].GetValue<String>('embalagem')<>'Caixa Fechada') then Begin
           SetCampoDefault('EdtCodigo');
           Limpar;
           ShowErro('O Volume('+EdtCodigo.Text+') deve ser Reconferido!', 'apito');
           Exit;
       End;
       ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtCodigo.Text, 0);
       if FrmeXactWMS.ConfigWMS.ExpedicaoOffLine = 0 then
          JsonArrayRetorno := ObjPedidoVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoqueJson(13, 0)
       Else
          JsonArrayRetorno := ObjPedidoVolumeCtrl.RegistrarDocumentoEtapaSemBaixaEstoqueJson(13, 0);
       if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
          SetCampoDefault('EdtCodigo');
          ShowErro('Erro'+vErro, 'apito');
       End
       Else Begin
         ShowOk('Volume Expedido!', 'concluido');
         Result := True;
       End;
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoVolumeCtrl.Free;
    EdtCodigo.Text := '';
    DelayEdSetFocus(EdtCodigo);
    ksLoadingIndicator1.HideLoading;
  Except On E: Exception do Begin
    ksLoadingIndicator1.HideLoading;
    JsonArrayRetorno := Nil;
    ksLoadingIndicator1.HideLoading;
    ShowErro('Erro: '+E.Message, 'alarme');
    End;
  End;
end;

procedure TFrmExpedicao.Limpar;
begin
  EdtPedido.Text        := '';
  EdtDataDocumento.Text := '';
  EdtDestino.Text       := '';
  EdtRota.Text          := '';
  LblOrdem.Text         := '';
end;

procedure TFrmExpedicao.LimparLista(Sender: TObject;
  AVertScroll: TVertScrollBox; ARectBase: string);
var
  I      : Integer;
  lFrame : TRectangle;
begin
  //Pesquisar e deixar isso no formulário padrão de listas.
  AVertScroll.BeginUpdate;
  for I := Pred(AVertScroll.Content.ChildrenCount) downto 0 do
  begin
    if (AVertScroll.Content.Children[I] is TRectangle) then
    begin
      if not (TRectangle(AVertScroll.Content.Children[I]).Name = ARectBase) then
      begin
        lFrame := (AVertScroll.Content.Children[I] as TRectangle);
        lFrame.DisposeOf;
        lFrame := nil;
      end;
    end;
  end;
  AVertScroll.EndUpdate;
end;

Procedure TFrmExpedicao.GetVolumeParaExpedicao(Sender: TObject);
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
          TLoading.Show(FrmeXactWMS, 'Carregando Volumes...');
          Self.VsbVolumeParaExpedicao.Visible := False;
          Self.VsbVolumeParaExpedicao.BeginUpdate;
          Self.LimparLista(FrmeXactWMS, VsbVolumeParaExpedicao, RetOffSet.Name);
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
      //Processamento principal
      LPos                      := 8;
      lytVolumeItem.Visible     := False;

      //Buscar os volume na APIO
      ReturnJsonArray      := DmClient.VolumeExpedicao;
      If ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
         //Tratar o Erro
      End
      Else Begin
        If QryListaPadrao.Active then
           QryListaPadrao.EmptyDataSet;
        QryListaPadrao.Close;
        QryListaPadrao.LoadFromJson(ReturnJsonARRAY, False);
        QryListaPadrao.First; //FdMemTable
        While not QryListaPadrao.EOF do Begin
         //for X := 0 to 1000 do  Begin

           //Preencher os dados
           Self.LblPedidoId.Text  := QryListaPadrao.FieldByName('PedidoId').AsString;
           Self.LblVolumeId.Text  := QryListaPadrao.FieldByName('PedidoVolumeId').AsString;
           Self.LblEmbalagem.Text := QryListaPadrao.FieldByName('embalagem').AsString;

           Self.LblPedidoData.Text := QryListaPadrao.FieldByName('documentodata').AsString;
           Self.LblDestino.Text    := Copy(QryListaPadrao.FieldByName('razao').AsString, 1, 20);
           Self.LblRota.Text       := Copy(QryListaPadrao.FieldByName('rotaid').AsString, 1, 20);

           LytVolumeItem.Tag       := X; //DM.QryCidadesCID_ID.AsInteger;

           LFrame                  := TLayout(LytVolumeItem.Clone(VsbVolumeParaExpedicao));
           LFrame.Parent           := VsbVolumeParaExpedicao;
           LFrame.Height           := LytVolumeItem.Height - 4;
           LFrame.Width            := LytVolumeItem.Width;

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
                   TSpeedButton(LFrame.Components[I]).OnClick := OnSelecionarVolume;
                 end
               );
               break;
             end;
           end;

           LFrame.Visible          := True;

           LPos                    := LPos + LytVolumeItem.Height + 4;

           QryListaPadrao.Next;
        end;
      End;
    end,
    procedure ()
    begin
      //Complete
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          TLoading.Hide;
          Self.VsbVolumeParaExpedicao.EndUpdate;
          Self.VsbVolumeParaExpedicao.Visible := True;
          //DM.QryCidades.EnableControls;
        end
      );
    end,
    procedure (const AException : string)
    begin
      //ShowErro(AException);
    end,
    True
  );
End;

{Procedure TFrmExpedicao.GetVolumeParaExpedicao;
Begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        Sleep(5000);
      finally
        TThread.Synchronize(TThread.Current,
          procedure
          begin
            MontalistaVolumeParaExpedicao;
          end);
      end;
    end).Start;
End;
}
Procedure TFrmExpedicao.MontalistaVolumeParaExpedicao;
var
  I: Integer;
  LFrameVolumeParaExpedicao: TFrameVolumeParaExpedicao;
begin
  VsbVolumeParaExpedicao.BeginUpdate;
  try
    for I := Pred(VsbVolumeParaExpedicao.Content.ControlsCount) downto 0 do Begin
      if not (VsbVolumeParaExpedicao.Content.Controls.Items[I] = retOffset) then
         VsbVolumeParaExpedicao.Content.Controls.Items[I].DisposeOf;
    end;
    //FService.mtPedidos.First;
    //while not FService.mtPedidos.Eof do
    For I := 0 to 1000 do Begin //
      LFrameVolumeParaExpedicao := TFrameVolumeParaExpedicao.Create(VsbVolumeParaExpedicao);
      LFrameVolumeParaExpedicao.Align := TAlignLayout.Top;
      LFrameVolumeParaExpedicao.LblPedidoId.Text := (I+1000).ToString(); //FService.mtPedidosid.AsString;
      LFrameVolumeParaExpedicao.LblVolumeId.Text := I.ToString;
      LFrameVolumeParaExpedicao.LblPedidoData.Text := '09/11/2021'; //FormatFloat('R$ ,0.00', FService.mtPedidostotal.AsFloat);
      LFrameVolumeParaExpedicao.LblDestino.Text    := 'Loja '+I.ToString(); //FService.mtPedidosnome_cliente.AsString;
      LFrameVolumeParaExpedicao.Name := LFrameVolumeParaExpedicao.ClassName + LFrameVolumeParaExpedicao.LblPedidoId.Text; //FService.mtPedidosid.AsString;
      LFrameVolumeParaExpedicao.Parent := VsbVolumeParaExpedicao;
      LFrameVolumeParaExpedicao.Identify := (I+1000).ToString(); //FService.mtPedidosid.AsString;
      LFrameVolumeParaExpedicao.OnDeletePedido := Self.OnDeletePedido;
      LFrameVolumeParaExpedicao.OnEditPedido := Self.OnEditPedido;
      //FService.mtPedidos.Next;
    end;
    retOffset.Position.Y := VsbVolumeParaExpedicao.Content.ControlsCount * 130 + retOffset.Height;
    //retFooter.Visible := (FService.GetPaginas > 1);
    //if retFooter.Visible then
    //  lblPaginas.Text := Format('%d de %d', [FService.GetPaginaCorrente, FService.GetPaginas]);
  finally
    VsbVolumeParaExpedicao.EndUpdate;
  end;
end;

procedure TFrmExpedicao.OnDeletePedido(ASender: TObject);
begin
//
end;

procedure TFrmExpedicao.OnEditPedido(ASender: TObject);
begin
//
end;

procedure TFrmExpedicao.OnSelecionarVolume(Sender: TObject);
begin

end;

end.
