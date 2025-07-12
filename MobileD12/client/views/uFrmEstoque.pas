unit uFrmEstoque;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, System.Generics.Collections,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, FMX.ListView, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.Rtti,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Gestures, FMX.ActnList, System.Actions, FMX.TabControl,
  FMX.Edit, FMX.Layouts, FMX.Controls.Presentation,
  Data.FireDACJSONReflect,
  FMX.Grid, ksTypes, ksLoadingIndicator, FMX.Grid.Style,
  FMX.ScrollBox, FMX.ListBox, System.JSON, REST.Json, Rest.Types, DataSet.Serialize
  {$IFDEF IOS}
      ,Macapi.Helpers
  {$ENDIF IOS}
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os
  {$Endif}
  , ProdutoCtrl,  ProdutoClass
  , EnderecoCtrl, EnderecoClass, FMX.Media, FMX.Effects, FMX.Filter.Effects,
  FMX.Ani, FMX.Memo;

type
  TFrmEstoque = class(TFrmBase)
    EdtEndereco: TEdit;
    Label1: TLabel;
    BtnSchCaixa: TSpeedButton;
    Layout4: TLayout;
    LytProdutoEndereco: TLayout;
    Layout2: TLayout;
    LblProduto: TLabel;
    Layout3: TLayout;
    LblEndereco: TLabel;
    LytEstoque: TLayout;
    LstEstoqueEndereco: TListView;
    LytEstoqueBottom: TLayout;
    Layout5: TLayout;
    Rectangle1: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LytEstoqueTop: TLayout;
    Rectangle2: TRectangle;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    LstEstoqueLote: TListView;
    Line1: TLine;
    ImgLstFdoWhite: TImage;
    LblPicking: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    procedure EdtCodigoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtCodigoValidate(Sender: TObject; var Text: string);
    procedure BtnSchCaixaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LstEstoquePaint(Sender: TObject; Canvas: TCanvas;
      const [Ref] ARect: TRectF);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtEnderecoTyping(Sender: TObject);
    procedure EdtEnderecoChange(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
  private
    { Private declarations }
    ObjProduto  : TProduto;
    ObjEndereco : TEndereco;
    Function GetProduto : Boolean;
    Function GetEndereco : Boolean;
    Procedure ShowProduto;
    Procedure GetEstoque;
  public
    { Public declarations }
    Procedure Limpar;
  end;

var
  FrmEstoque: TFrmEstoque;

implementation

{$R *.fmx}

uses uFuncoes, uMyTabOrderClassHelper, uDmClient, EstoqueCtrl;

procedure TFrmEstoque.BtnAddClick(Sender: TObject);
begin
  inherited;
  FuncaoDesabilitada(FrmEstoque);
end;

procedure TFrmEstoque.BtnSchCaixaClick(Sender: TObject);
begin
  inherited;
  if (EdtCodigo.Text='') and (EdtEndereco.Text='') then Exit;
  if ((EdtCodigo.Text<>'') and (ObjProduto = Nil)) then
     If Not GetProduto Then Exit;
  if ((EdtEndereco.Text<>'') and (ObjEndereco = Nil)) then
     If Not GetEndereco Then Exit;
  GetEstoque;
end;

procedure TFrmEstoque.EdtCodigoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Assigned(ObjProduto) then ObjProduto := Nil;
  if Assigned(ObjEndereco) then ObjEndereco := Nil;
  SoNumeros(KeyChar);
end;

procedure TFrmEstoque.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  If ((key = 0) and (IntToStr(ord(KeyChar))='0') and ((Sender=Edtcodigo) or (Sender=EdtEndereco))) then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
  {$if defined(Android)}
    i := TJIntent.JavaClass.init;
    i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
    i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
    TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
  {$Endif}
  end;
  case Key of
    vkReturn:
      TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
    vkTab:
      TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
  end;
end;

procedure TFrmEstoque.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmEstoque.EdtCodigoValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if Sender=EdtCodigo then Begin
     //if StrToInt64Def(Text, 0) > 0 then
     if (Text<>'') and (Text<>'0') then
        GetProduto;
  End
  Else if Text <> '' then
    GetEndereco;
end;

procedure TFrmEstoque.EdtEnderecoChange(Sender: TObject);
begin
  inherited;
  if Assigned(ObjEndereco) then
     ObjEndereco := Nil;
end;

procedure TFrmEstoque.EdtEnderecoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmEstoque.FormActivate(Sender: TObject);
begin
  inherited;
  DelayedSetFocus(EdtCodigo);
end;

procedure TFrmEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  limpar;
  PgcPrincipal.ActiveTab := TabDetalhes;
  LytEstoqueTop.Visible  := False;
end;

procedure TFrmEstoque.FormShow(Sender: TObject);
begin
  inherited;
  DelayedSetFocus(EdtCodigo);
end;

Function TFrmEstoque.GetEndereco : Boolean;
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    verro            : String;
begin
  Result := False;
  LblEndereco.Text := '';
  if EdtEndereco.Text = '' then Exit;
  Try
    ShowLoading;
    ObjEnderecoCtrl  := TEnderecoCtrl.Create;
    JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EdtEndereco.Text,
                        EdtEndereco.Text, 'T', 99, 0);
    if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
       EdtEndereco.Text := '';
       HideLoading;
       MensagemStand('Endereço não encontrado!');
       DelayedSetFocus(EdtEndereco);
       ObjEnderecoCtrl := Nil;
       Exit;
    End;
    if Not Assigned(ObjEndereco) then
       ObjEndereco := TEndereco.Create;
    ObjEndereco := ObjEndereco.JsontoClass(JsonArrayRetorno.Items[0].ToString());
    LblEndereco.Text := ObjEndereco.EnderecoEstrutura.Descricao+#13+ObjEndereco.EnderecamentoZona.Descricao;
    if (EdtCodigo.Text = '') and (ObjEndereco.EnderecoEstrutura.EstruturaId = 2) then Begin
       lblProduto.Text := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('produto').GetValue<string>('codproduto')+' - '+
                          JsonArrayRetorno.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
    End;
    Result := True;
  Except On E: Exception do  Begin
    if Assigned(ObjEnderecoCtrl) then
       ObjEnderecoCtrl.DisposeOf;
    EdtEndereco.Text := '';
    HideLoading;
    ShowErro(E.Message);
    DelayEdSetFocus(EdtEndereco);
  End;
  End;
  HideLoading;
end;

procedure TFrmEstoque.GetEstoque;
Var vProdutoId       : Int64;
    vEnderecoId      : Int64;
    vErro            : String;
    ListItem         : TListViewItem;
    JsonArrayRetorno : TJsonArray;
    ObjEstoqueCtrl   : TEstoqueCtrl;
    xReg : Integer;
    item : TListViewItem;
    Txt  : TListItemText;
    img  : TListItemImage;
    Cor  : Cardinal;
begin
  ShowLoading;
  if EdtCodigo.Text<> '' then //Assigned(ObjProduto) then
     vProdutoId := ObjProduto.IdProduto
  Else vProdutoId := 0;
  if EdtEndereco.Text <> '' then  //Assigned(ObjEndereco) then
     vEnderecoId := ObjEndereco.EnderecoId
  Else vEnderecoId := 0;
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueEnderecoPorTipo(vProdutoId, 0, venderecoId, 0, 2, 2, 'S', 'S', 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtEndereco.Text := '';
     EdtCodigo.Text   := '';
     HideLoading;
     MensagemStand('Estoque não diponível!');
     DelayedSetFocus(EdtCodigo);
     JsonArrayRetorno := Nil;
     ObjEstoqueCtrl.Free;
     Exit;
  End;
  LstEstoqueEndereco.BeginUpdate;
  LstEstoqueEndereco.Items.Clear;
//  while NOT QryListaPadrao.Eof do begin
  For xReg := 0 to Pred(JsonArrayRetorno.Count) do begin
    item := LstEstoqueEndereco.Items.Add;
    item.Objects.Clear;
    item.TagString := JsonArrayRetorno.items[xreg].GetValue<String>('loteid');
    with item do begin
      img := TListItemImage(Objects.FindDrawable('ImgFdoLst'));
      If xReg Mod 2 = 0 Then begin       //Inicializado
         img.Bitmap := ImgFdoGrid01.Bitmap;
         Cor:= $FF5DA9BC;
      End
      Else Begin  //Em Contagem
         img.Bitmap := ImgFdoGrid02.Bitmap;
         Cor:= $FFE9C168;
      End;
      txt := TListItemText(Objects.FindDrawable('CodProd'));
      txt.Text := JsonArrayRetorno.Items[xreg].GetValue<String>('codproduto');
      txt := TListItemText(Objects.FindDrawable('DescrProd'));
      txt.Text := JsonArrayRetorno.Items[xreg].GetValue<String>('produto');
      txt := TListItemText(Objects.FindDrawable('Picking'));
      txt.Text := JsonArrayRetorno.Items[xreg].GetValue<String>('picking');

      txt := TListItemText(Objects.FindDrawable('Endereco'));
      txt.Text := EnderecoMask(JsonArrayRetorno.Items[xreg].GetValue<String>('endereco'),
                               JsonArrayRetorno.Items[xreg].GetValue<String>('mascara'), True);
      txt.TagString     := JsonArrayRetorno.Items[xreg].GetValue<String>('endereco');

      txt := TListItemText(Objects.FindDrawable('Estrutura'));
      txt.Text := JsonArrayRetorno.items[xreg].GetValue<String>('estrutura');
      txt.TagString     := JsonArrayRetorno.Items[xreg].GetValue<String>('estrutura');

      txt := TListItemText(Objects.FindDrawable('Lote'));
      txt.Text := JsonArrayRetorno.items[xreg].GetValue<String>('descrlote');
      txt.TagString     := JsonArrayRetorno.Items[xreg].GetValue<String>('descrlote');

      txt := TListItemText(Objects.FindDrawable('Vencimento'));
      txt.Text := JsonArrayRetorno.Items[xreg].GetValue<String>('vencimento');
      txt := TListItemText(Objects.FindDrawable('QtdStage'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('stage'));
      txt := TListItemText(Objects.FindDrawable('QtdProd'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('producao'));
      txt := TListItemText(Objects.FindDrawable('QtdCross'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('crossdocking'));
      txt := TListItemText(Objects.FindDrawable('QtdSegr'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('segregado'));
      txt := TListItemText(Objects.FindDrawable('QtdExp'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('expedicao'));
      txt := TListItemText(Objects.FindDrawable('QtdReserva'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('reserva'));
      txt := TListItemText(Objects.FindDrawable('QtdSaldo'));
      txt.Text := FormatFloat('0', JsonArrayRetorno.Items[xreg].GetValue<Integer>('saldo'));
   End;
//    QryListaPadrao.Next;
  end;

  LstEstoqueEndereco.EndUpdate;

  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
  HideLoading;
//  LstEstoque.ColumnByIndex(1).HorizontalAlign:=TTextAlign.taCenter;
//https://stackoverflow.com/questions/9250491/firemonkey-grid-control-aligning-a-column-to-the-right
//Alteracoes para o FMX.Grid
end;

Function TFrmEstoque.GetProduto : Boolean;
Var vCod      : Integer;
    vErro, vCodBarra : String;
    JsonArrayRetorno : TJsonArray;
    ObjProdutoCtrl : TProdutoCtrl;
begin
  Try
    Result := False;
    LblProduto.Text := '***';
    LblPicking.Text := '...';
    ShowLoading;
    ObjProdutoCtrl := TProdutoCtrl.Create;
    JsonArrayRetorno := ObjProdutoCtrl.FindProduto('0', EdtCodigo.Text, '', 0, 0);
    if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
       EdtCodigo.Text := '';
       HideLoading;
       MensagemStand('Produto não encontrado!');
       DelayedSetFocus(EdtCodigo);
       JsonArrayRetorno := Nil;
       ObjProdutoCtrl.DisposeOf;
       Exit;
    End;
    if Not Assigned(ObjProduto) then
       ObjProduto := TProduto.Create;
  //  ObjProduto := ObjProduto.JsonToClass(JsonArrayRetorno.Items[0].ToString());
    ObjProduto.IdProduto  := JsonArrayRetorno.Items[0].GetValue<Integer>('idProduto');
    ObjProduto.CodProduto := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto');
    ObjProduto.Descricao  := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
    //EdtCodigo.Text  := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto').ToString();
    LblProduto.Text := ObjProduto.Descricao;
    LblPicking.Text := 'Picking: '+EnderecoMask(JsonArrayRetorno.Items[0].GetValue<TJsonObject>('endereco').GetValue<String>('descricao'),
                                                JsonArrayRetorno.Items[0].GetValue<TJsonObject>('endereco').GetValue<TJsonObject>('enderecoEstrutura').GetValue<String>('mascara'), True)+
                       '  Zona: '+JsonArrayRetorno.Items[0].GetValue<TJsonObject>('endereco').GetValue<TJsonObject>('enderecamentoZona').GetValue<String>('descricao');
    HideLoading;
    JsonArrayRetorno := Nil;
    ObjProdutoCtrl.Free;
    Result := True;
  Except On E: Exception do Begin
    if Assigned(ObjProdutoCtrl) then
       ObjProdutoCtrl.DisposeOf;
    HideLoading;
    ShowErro('Erro(22): '+E.Message);
    EdtCodigo.Text := '';
    DelayEdSetFocus(EdtCodigo);
    End;
  End;
end;

procedure TFrmEstoque.Limpar;
begin
  //EdtEndereco.Text := '';
  LblProduto.Text  := '...';
  LblPicking.Text  := '...';
  LblEndereco.Text := '...';
  if Assigned(ObjProduto) then Begin
     ObjProduto.DisposeOf;
  End;
  if Assigned(ObjEndereco) then Begin
     ObjEndereco.DisposeOf;
  End;
  LstEstoqueLote.Items.Clear;
  LstEstoqueEndereco.Items.Clear;
  if (QryListaPadrao.Active) then Begin
     QryListaPadrao.EmptyDataSet;
     QryListaPadrao.FieldDefs.Clear;
     QryListaPadrao.Close;
  End;
end;

procedure TFrmEstoque.LstEstoquePaint(Sender: TObject; Canvas: TCanvas;
  const [Ref] ARect: TRectF);
Var J : Integer;
//    T : TTextCell;
begin
  inherited;
{   For J := 0 to LstEstoque.RowCount - 1 do begin
     T := TTextCell(LstEstoque.Columns[3].Children[1]);
     T.TextAlign := TTextAlign.Trailing;
   End;
}end;

procedure TFrmEstoque.ShowProduto;
begin
  if Assigned(ObjProduto) then Begin
     EdtCodigo.Text   := ObjProduto.CodProduto.ToString();
     LblProduto.Text := 'TESTe';
     LblProduto.Text  := ObjProduto.Descricao;
     LblPicking.Text := ObjProduto.Endereco.Descricao+'  Zona: '+ObjProduto.EnderecamentoZona.Descricao;
  End
  Else
    LblProduto.Text := 'Obj Morto';
end;

end.
