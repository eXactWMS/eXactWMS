unit uFrmCaixa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, Data.DbxJsonReflect,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, FMX.Edit, FMX.ListView,
  FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts, FMX.ListBox, uTCaixa,
  FMX.ScrollBox, FMX.Memo, FMX.Gestures, System.Actions, FMX.ActnList,
  FMX.Objects, System.Rtti, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.Generics.Collections,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Grid, FMX.Grid.Style, ksTypes,
  ksLoadingIndicator, FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani
  , DataSet.Serialize, System.JSON, REST.Json, Rest.Types
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
     , Androidapi.Helpers//, FMX.Grid.Style
  {$Endif}
  , VolumeEmbalagemCtrl
  , EmbalagemCaixaCtrl;
type
  TOperacao = (NovaCxa, ExcluirCxa, RetirarCxa, InativaCxa);

  TFrmCaixa = class(TFrmBase)
    CbTipoCaixa: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    ComboBox2: TComboBox;
    PnlMultCaixas: TPanel;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    EdtCodIni: TEdit;
    Label6: TLabel;
    EdtCodFin: TEdit;
    Label7: TLabel;
    CbMotRetirada2: TComboBox;
    BtnConfirma: TButton;
    Button2: TButton;
    Button1: TButton;
    Layout1: TLayout;
    ToolBar2: TToolBar;
    BtnNovasCxa: TSpeedButton;
    BtnExcluirCxa: TSpeedButton;
    BtnRetirarCxa: TSpeedButton;
    BtnInativarCxa: TSpeedButton;
    LstTipoEmbalagem: TListView;
    LytTitleTipoEmbalagemTop: TLayout;
    LblTit02: TLabel;
    LblTit06: TLabel;
    Rectangle1: TRectangle;
    LblTit01Top: TLabel;
    LblTit02Top: TLabel;
    LblTit03Top: TLabel;
    LblTit04Top: TLabel;
    LblTit05Top: TLabel;
    LblTit06Top: TLabel;
    img_check: TImage;
    img_uncheck: TImage;
    procedure FormShow(Sender: TObject);
    procedure LstPrincipalItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure Button1Click(Sender: TObject);
    procedure BtnConfirmaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EdtCodFinValidate(Sender: TObject; var Text: string);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure LstPrincipalGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure BtnNovasCxaClick(Sender: TObject);
    procedure PgcPrincipalGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LstTipoEmbalagemItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
    CaixaTipo            : TCaixaTipo;
    ListaCaixaTipo       : TListaCaixaTipo;
    CaixaTipoStatus      : TCaixaTipoStatus;
    ListaCaixaTipoStatus : TListaCaixaTipoStatus;
    Caixa                : TCaixa;
    Operacao             : TOperacao;

    ObjVolumeEmbalagemCtrl : TVolumeEmbalagemCtrl;  //Tipo de Embalagem
    ObjCaixaEmbalagemCtrl  : TCaixaEmbalagemCtrl;   //Caixas usada para volumes
    Procedure AtivarBtns;
    Procedure ClearPnlMultCaixas;
    Function GetListaTipoEmbalagem : Boolean;
    Procedure AtualizarVolumeEmbalagem;
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCaixa: TFrmCaixa;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

uses uDmClient, System.StrUtils, uRetorno, uListview;

procedure TFrmCaixa.AtivarBtns;
begin
  PnlMultCaixas.Visible  := Not PnlMultCaixas.Visible;
  BtnNovasCxa.Visible    := Not PnlMultCaixas.Visible;
  BtnExcluirCxa.Visible  := Not PnlMultCaixas.Visible;
  BtnRetirarCxa.Visible  := Not PnlMultCaixas.Visible;
  BtnInativarCxa.Visible := Not PnlMultCaixas.Visible;
  EdtCodIni.ReadOnly     := Not PnlMultCaixas.Visible;
  EdtCodFin.ReadOnly     := Not PnlMultCaixas.Visible;
  CbMotRetirada2.Enabled := Operacao = RetirarCxa;
end;

procedure TFrmCaixa.AtualizarVolumeEmbalagem;
Var xTipo, xEmbalagemId, xCaixa : Integer;
    JsonArrayCaixaEmbalagem : TJsonArray;
    LvItem : TListItemText;
    vErro  : String;
begin
  LstPrincipal.Items.Clear;
  for xTipo := 0 to Pred(LstTipoEmbalagem.Items.Count) do Begin
    If (LstTipoEmbalagem.Items[xTipo].Checked) then Begin
       lvItem       := TListItemText(LstTipoEmbalagem.Items[xTipo].Objects.FindDrawable('TipoId'));
        xEmbalagemId := StrToIntDef(LvItem.Text, 0);
        JsonArrayCaixaEmbalagem := ObjCaixaEmbalagemCtrl.GetCaixaEmbalagemJson(0, 0, 0, 0, 'A', 99);
        if Not JsonArrayCaixaEmbalagem.Items[0].TryGetValue<String>('Erro', vErro) then Begin
           for xCaixa := 0 to Pred(JsonArrayCaixaEmbalagem.Count) do Begin

             With LstPrincipal.Items.Add do Begin
               TListItemText(Objects.FindDrawable('Identificacao')).Text := JsonArrayCaixaEmbalagem.Items[xCaixa].GetValue<Integer>('numsequencia').ToString;
               TListItemText(Objects.FindDrawable('Situacao')).Text      := JsonArrayCaixaEmbalagem.Items[xCaixa].GetValue<String>('situacao');
               If JsonArrayCaixaEmbalagem.Items[xCaixa].GetValue<Integer>('disponivel') = 1 then
                  TListItemImage(Objects.FindDrawable('Image3')).Bitmap     := Img_check.Bitmap
               Else TListItemImage(Objects.FindDrawable('Image3')).Bitmap     := Img_uncheck.Bitmap;
             End;

           End;
        End;
    End;
  End;
end;

procedure TFrmCaixa.BtnConfirmaClick(Sender: TObject);
Var vRetorno  : TRetorno;
    unMarshal : TJSONUnMarshal;
    Msg : String;
    vCodI, vCodF : Integer;
begin
  inherited;
  vCodI := StrToInt(IfThen(EdtCodIni.Text.ToInt64=0, '1', EdtCodIni.Text));
  vCodF := StrToInt(IfThen(EdtCodFin.Text.ToInt64=0, EdtCodIni.Text, EdtCodFin.Text));
  case Operacao of
    NovaCxa: Msg := 'Confirma o Lançamento de '+(EdtCodFin.Text.ToInt64-EdtCodIni.Text.ToInt64+1).ToString()+
                    ' novas caixas ?';
    ExcluirCxa: Msg := 'Confirma a Exclusão de '+(EdtCodFin.Text.ToInt64-EdtCodIni.Text.ToInt64+1).ToString()+
                    ' caixas ?';
    RetirarCxa: Msg := 'Confirma a Retirada de '+(EdtCodFin.Text.ToInt64-EdtCodIni.Text.ToInt64+1).ToString()+
                    ' caixas ?';
    InativaCxa: Msg := 'Confirma Inativar '+(EdtCodFin.Text.ToInt64-EdtCodIni.Text.ToInt64+1).ToString()+
                    ' caixas ?';
  end;

  MessageDlg(Msg, TMsgDlgType.mtConfirmation,[TMsgDlgBtn.MbYes, TMsgDlgBtn.MbNo], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = MrYes then Begin
           With dmClient.RESTRequest1 do Begin
             Method   := RmGet;
             case Operacao of
               NovaCxa: Resource    := 'GetCaixaNova/{CdCaixaIni}/{CdCaixaFin}/{CdCaixaTipo}';
               ExcluirCxa: Resource := 'GetCaixaExcluir/{CdCaixaIni}/{CdCaixaFin}/{CdCaixaTipo}';
               RetirarCxa: Resource := 'GetCaixaRetirar/{CdCaixaIni}/{CdCaixaFin}/{CdCaixaTipo}//{CdCaixaMotRetirada}';
               InativaCxa: Resource := 'GetCaixaInativar/{CdCaixaIni}/{CdCaixaFin}/{CdCaixaTipo}';
             end;
             Params.AddUrlSegment('CdCaixaIni', vCodI.ToString());
             Params.AddUrlSegment('CdCaixaFin', vCodF.ToString());
             Params.AddUrlSegment('CdCaixaTipo', CbTipoCaixa.ItemIndex.ToString());
             if Sender = BtnRetirarCxa then
                Params.AddUrlSegment('CdCaixaMotRetidada', '1');
             Execute;
             unMarshal := TJSONUnMarshal.Create;
             vRetorno  := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TRetorno;
             if vRetorno.Codigo < 0 then
                ShowMessage(vRetorno.Descricao+#13+vRetorno.MSGErro)
             Else ShowMessage(vRetorno.Descricao);
           End;
        End;
      end
  );
  ClearPnlMultCaixas;
  AtivarBtns;
end;

procedure TFrmCaixa.Button1Click(Sender: TObject);
begin
  inherited;
  AtivarBtns;
end;

procedure TFrmCaixa.Button2Click(Sender: TObject);
begin
  inherited;
  AtivarBtns;
end;

procedure TFrmCaixa.ClearPnlMultCaixas;
begin
  EdtCodIni.Text := '';
  EdtCodFin.Text := '';
  CbMotRetirada2.ItemIndex := -1;
end;

procedure TFrmCaixa.EdtCodFinValidate(Sender: TObject; var Text: string);
begin
  inherited;
  If (EdtCodFin.Text<>'') and (EdtCodFin.Text.ToInt64() < EdtCodIni.Text.ToInt64()) Then
     ShowMessage('Código Final inválido, deve ser maior ou igual ao Código Inicial...');
end;

procedure TFrmCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  FormShow(Self);
  ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
  ObjCaixaEmbalagemCtrl  := TCaixaEmbalagemCtrl.Create;
  GetListaLstCadastro;
end;

procedure TFrmCaixa.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(ObjCaixaEmbalagemCtrl) then
     ObjCaixaEmbalagemCtrl.DisposeOf;
  if Assigned(ObjVolumeEmbalagemCtrl) then
     ObjVolumeEmbalagemCtrl.DisposeOf;
end;

procedure TFrmCaixa.FormShow(Sender: TObject);
Var unMarshal : TJsonUnmarshal;
    xCount    : Integer;
    ListItem  : TListViewItem;
begin
//WebService com BD parte 1 - 11Min
  inherited;
(*
   With dmClient.RESTRequest1 do Begin
     Resource := 'GetListaCaixaTipo/{CdCaixaTipo}';
     Method   := RmGet;
     Params.AddUrlSegment('CdCaixaTipo', '-1');
     Execute;
     unMarshal := TJSONUnMarshal.Create;
     ListaCaixaTipo := UnMarshal.Unmarshal(DmClient.RESTResponse1.JSONValue) as TListaCaixaTipo;
     CbTipoCaixa.Items.Clear;
     LstPrincipal.Items.Clear;
     LstPrincipal.BeginUpdate;
     For xCount := 0 to ListaCaixaTipo.size-1 do Begin
       CbTipoCaixa.Items.Add(ListaCaixaTipo.Items[xCount].Codigo.ToString()+' '+ListaCaixaTipo.Items[xCount].Nome);
       ListItem := LstPrincipal.Items.Add;
       ListItem.Text    := ListaCaixaTipo.Items[xCount].Nome;
       ListItem.Detail  := ListaCaixaTipo.Items[xCount].Codigo.ToString;
       ListItem.Tag     := ListaCaixaTipo.Items[xCount].Codigo;
       ListItem.Data[TMultiDetailAppearanceNames.Detail1] := ListaCaixaTipo.Items[xCount].Status.Nome+
                                                             '        Rastrear: '+IfThen(ListaCaixaTipo.Items[xCount].Rastrear, 'Sim','Nao');
       ListItem.Data[TMultiDetailAppearanceNames.Detail2] := '     Altura: '+ListaCaixaTipo.Items[xCount].Altura.ToString+'Cm        Largura: '+ListaCaixaTipo.Items[xCount].Largura.ToString+'Cm'+
                                                             '        Comprimento: '+ListaCaixaTipo.Items[xCount].Comprimento.ToString+'Cm         Volume: '+ListaCaixaTipo.Items[xCount].Volume.ToString+'Cm3';
       ListItem.Data[TMultiDetailAppearanceNames.Detail3] := '     Aproveitamento: '+ListaCaixaTipo.Items[xCount].Aproveitamento.ToString+'%        Peso: '+ListaCaixaTipo.Items[xCount].Peso.ToString+
                                                             '        Capacidade: '+ListaCaixaTipo.Items[xCount].Capacidade.ToString+'         Lacre: '+ListaCaixaTipo.Items[xCount].QtdLacre.ToString+
                                                             '        Vlr Unitário: '+FormatFloat('##,##0.00', ListaCaixaTipo.Items[xCount].ValorUnitario);
     End;
     LstPrincipal.EndUpdate;
   End;
   FreeAndNil(unMarshal);
*)
  PnlMultCaixas.Visible := False;
end;

procedure TFrmCaixa.GetListaLstCadastro;
begin
  inherited;
  GetListaTipoEmbalagem;
end;

function TFrmCaixa.GetListaTipoEmbalagem: Boolean;
Var JsonArrayTipoEmbalagem : TJsonArray;
    vErro            : String;
    xTipoEmbalagem   : Integer;
begin
  Result := False;
  Showloading;
  JsonArrayTipoEmbalagem := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagemJson(0, '', 0);
  if JsonArrayTipoEmbalagem.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     Exit;
  End;
  Result := JsonArrayTipoEmbalagem.Count >= 1;
  LstTipoEmbalagem.BeginUpdate;
  LstTipoEmbalagem.Items.Clear;
  If JsonArrayTipoEmbalagem.Count >= 1 then Begin
     For xTipoEmbalagem := 0 to Pred(JsonArrayTipoEmbalagem.Count) do Begin
       With LstTipoEmbalagem.Items.Add do Begin
         TListItemText(Objects.FindDrawable('TipoId')).Text          := JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<Integer>('embalagemid').ToString;
         TListItemText(Objects.FindDrawable('TipoDescricao')).Text   := JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<String>('descricao');
         TListItemText(Objects.FindDrawable('TipoAltura')).Text      := JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<Integer>('altura').ToString();
         TListItemText(Objects.FindDrawable('TipoLargura')).Text     := JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<Integer>('largura').ToString();
         TListItemText(Objects.FindDrawable('TipoComprimento')).Text := JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<Integer>('comprimento').ToString();
         TListItemText(Objects.FindDrawable('TipoCapacidade')).Text  := JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<Integer>('capacidade').ToString()+'Kg';
         TListItemImage(Objects.FindDrawable('ImgOption')).Bitmap    := Img_uncheck.Bitmap;


//         If JsonArrayProduto.Items[xProduto].GetValue<TJsonObject>('endereco').GetValue<Integer>('enderecoId') = 0 then
//            TListItemImage(Objects.FindDrawable('Image2')).Bitmap := ImgLstFdoRed.BitMap
//         Else TListItemImage(Objects.FindDrawable('Image2')).Bitmap := Nil;
       End;
     End;
  End;
  LstTipoEmbalagem.EndUpdate;
  HideLoading;
end;

procedure TFrmCaixa.LstPrincipalGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
showmessage('Gesture em acao');
  inherited;
  if (EventInfo.GestureID = igiLongTap) and (LstPrincipal.ItemIndex>=0) then Begin
     CbTipoCaixa.ItemIndex := LstPrincipal.Items[LstPrincipal.ItemIndex].Tag;
     PgcPrincipal.ActiveTab := TabDetalhes;
  End
  else if EventInfo.GestureID = sgiLeft Then
     PgcPrincipal.ActiveTab := TabDetalhes
  else if EventInfo.GestureID = sgiRight Then
     PgcPrincipal.ActiveTab := TabLista;
end;

procedure TFrmCaixa.LstPrincipalItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  inherited;
  Exit; //Incluindo no evento OnItemClick
//  if (ItemObject is TListItemAccessory) or
  If (LocalClickPos.X >= TListView(Sender).Width - 60 ) then Begin
     CbTipoCaixa.ItemIndex := TlistView(Sender).Items[ItemIndex].Tag;
     PgcPrincipal.ActiveTab := TabDetalhes;
  End;
end;

procedure TFrmCaixa.LstTipoEmbalagemItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  AItem.Checked := Not AItem.Checked;
  With AItem do Begin
    if Checked then
       TListItemImage(Objects.FindDrawable('ImgOption')).Bitmap := img_check.BitMap
    else
       TListItemImage(Objects.FindDrawable('ImgOption')).Bitmap := img_uncheck.BitMap;
    AtualizarVolumeEmbalagem;
  End;
end;

function TFrmCaixa.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin

end;

procedure TFrmCaixa.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if PgcPrincipal.ActiveTab = TabDetalhes then
     if LstPrincipal.ItemIndex < 0 then CbTipoCaixa.ItemIndex := 0;
end;

procedure TFrmCaixa.PgcPrincipalGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
//  if EventInfo.GestureID = sgiRight Then
//     PgcPrincipal.ActiveTab := TabLista;
end;

procedure TFrmCaixa.BtnNovasCxaClick(Sender: TObject);
begin
  inherited;
  if CbTipoCaixa.ItemIndex < 0 then Begin
     MessageDlg('Selecione o Tipo de Caixa na Tela Anterior!!!', TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK], 0,
         procedure (const AResult: TModalResult)
         begin
           if AResult = mrYes then
              PgcPrincipal.ActiveTab := TabLista;
         end
     );
     Exit;
  End;
  Label4.Text := TButton(Sender).Text;
  If Sender = BtnNovasCxa Then Operacao := NovaCxa
  Else If Sender = BtnExcluirCxa Then Operacao := ExcluirCxa
  Else If Sender = BtnRetirarCxa Then Operacao := RetirarCxa
  Else If Sender = BtnInativarCxa Then Operacao := InativaCxa;
  AtivarBtns;
end;

end.
