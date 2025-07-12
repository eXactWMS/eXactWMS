unit uFrmEmbalagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types, System.Generics.Collections,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, FMX.Objects, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, ksTypes, ksLoadingIndicator,
  FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.ListView,
  FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.Layouts
  , DataSet.Serialize, System.JSON, REST.Json, Rest.Types
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
  , VolumeEmbalagemCtrl
  , EmbalagemCaixaCtrl;

type
  TFrmEmbalagem = class(TFrmBase)
    img_check: TImage;
    img_uncheck: TImage;
    CbTipoEmbalagem: TComboBox;
    Label3: TLabel;
    CbSituacao: TComboBox;
    Label1: TLabel;
    EdtObservacao: TEdit;
    Line10: TLine;
    Label2: TLabel;
    LytTitleTipoEmbalagemTop: TLayout;
    LstTipoEmbalagem: TListView;
    Rectangle1: TRectangle;
    LblTit01Top: TLabel;
    LblTit02Top: TLabel;
    LblTit03Top: TLabel;
    LblTit04Top: TLabel;
    LblTit05Top: TLabel;
    LblTit06Top: TLabel;
    LblTit02: TLabel;
    LblTit06: TLabel;
    TabLiberacaoCaixa: TTabItem;
    Label4: TLabel;
    EdtCaixaId: TEdit;
    Line1: TLine;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LstTipoEmbalagemItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure EdtCodigoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtCodigoValidate(Sender: TObject; var Text: string);
  private
    { Private declarations }
    ObjVolumeEmbalagemCtrl : TVolumeEmbalagemCtrl;  //Tipo de Embalagem
    ObjCaixaEmbalagemCtrl  : TCaixaEmbalagemCtrl;   //Caixas usada para volumes
    Function GetListaTipoEmbalagem : Boolean;
    Function GetListaEmbalagem : Boolean;
    Procedure AtualizarVolumeEmbalagem;
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure ShowDados; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmEmbalagem: TFrmEmbalagem;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, uMyTabOrderClassHelper;

{ TFrmEmbalagem }

procedure TFrmEmbalagem.AtualizarVolumeEmbalagem;
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

function TFrmEmbalagem.DeleteReg: Boolean;
begin
end;

procedure TFrmEmbalagem.EdtCodigoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
  if (Sender = EdtCodigo) and (Key<>13) then
     Limpar;
end;

procedure TFrmEmbalagem.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
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
  case Key of
    vkReturn:
        TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
//    vkTab:
//      TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
  end;
end;

procedure TFrmEmbalagem.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmEmbalagem.EdtCodigoValidate(Sender: TObject; var Text: string);
Var JsonArrayEmbalagem : TJsonArray;
    vErro : String;
begin
  inherited;
  if EdtCodigo.Text = '' then Exit;
  JsonArrayEmbalagem := ObjCaixaEmbalagemCtrl.GetCaixaEmbalagemJson(StrToIntDef(EdtCodigo.Text,0), 0, StrToIntDef(EdtCodigo.Text,0), 0, 'A', 99, 0);
  if (JsonArrayEmbalagem.Items[0].TryGetValue('Erro', vErro)) then
     ShowErro(vErro)
  Else Begin
    ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem := ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem.JsonArrayToClass(JsonArrayEmbalagem);
    ShowDados;
  End;
end;

procedure TFrmEmbalagem.FormCreate(Sender: TObject);
Var JsonArrayTipoEmbalagem : TJsonArray;
    vErro            : String;
    xTipoEmbalagem   : Integer;
begin
  inherited;
  ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
  ObjCaixaEmbalagemCtrl  := TCaixaEmbalagemCtrl.Create;
  GetListaLstCadastro;
//Preparar Combo com Tipos de Embalagem
  Showloading;
  JsonArrayTipoEmbalagem := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagemJson(0, '', 0);
  if JsonArrayTipoEmbalagem.Items[0].TryGetValue('Erro', vErro) then Begin
      HideLoading;
     ShowErro(vErro);
     Exit;
  End;
  CbTipoEmbalagem.Items.Clear;
  for xTipoEmbalagem := 0 to Pred(JsonArrayTipoEmbalagem.Count) do
    CbTipoEmbalagem.Items.Add(JsonArrayTipoEmbalagem.Items[xTipoEmbalagem].GetValue<String>('descricao'));
  HideLoading;
end;

procedure TFrmEmbalagem.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(ObjCaixaEmbalagemCtrl) then
     ObjCaixaEmbalagemCtrl.DisposeOf;
  if Assigned(ObjVolumeEmbalagemCtrl) then
     ObjVolumeEmbalagemCtrl.DisposeOf;
end;

function TFrmEmbalagem.GetListaEmbalagem: Boolean;
begin

end;

procedure TFrmEmbalagem.GetListaLstCadastro;
begin
  inherited;
  GetListaTipoEmbalagem;
end;

function TFrmEmbalagem.GetListaTipoEmbalagem: Boolean;
Var JsonArrayTipoEmbalagem : TJsonArray;
    vErro            : String;
    xTipoEmbalagem   : Integer;
begin
  Result := False;
  Showloading;
  JsonArrayTipoEmbalagem := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagemJson(0, '', 0);
  if JsonArrayTipoEmbalagem.Items[0].TryGetValue('Erro', vErro) then Begin
     HideLoading;
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
       End;
     End;
  End;
  LstTipoEmbalagem.EndUpdate;
  HideLoading;
end;

procedure TFrmEmbalagem.Limpar;
begin
  inherited;
  //EdtoCodigo.Text := '';
  EdtObservacao.Text        := '';
  CbTipoEmbalagem.ItemIndex := -1;
  CbSituacao.ItemIndex      := -1;
  SetAtivoOnOff(True);
end;

procedure TFrmEmbalagem.LstTipoEmbalagemItemClick(const Sender: TObject;
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

function TFrmEmbalagem.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin

end;

function TFrmEmbalagem.SalvarReg: Boolean;
begin

end;

procedure TFrmEmbalagem.ShowDados;
Begin
  CbTipoEmbalagem.ItemIndex := CbTipoEmbalagem.Items.IndexOf(ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem.VolumeEmbalagem.Descricao);
  EdtCodigo.Text     := ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem.CaixaEmbalagemid.ToString();
  if ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem.Disponivel = 1 then
     CbSituacao.ItemIndex := 0
  Else CbSituacao.ItemIndex := 1;
  EdtObservacao.Text := ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem.Observacao;
  SetAtivoOnOff(ObjCaixaEmbalagemCtrl.ObjCaixaEmbalagem.Status = 1);
end;

end.

