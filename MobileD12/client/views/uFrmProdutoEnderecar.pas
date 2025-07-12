unit uFrmProdutoEnderecar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, System.Generics.Collections,
  FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Objects, FMX.ListBox,
  FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.ListView,
  FMX.Layouts, uListview, System.JSON, REST.Json, Rest.Types, DataSet.Serialize
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
  , EnderecoCtrl, EnderecoClass
  , EnderecamentoZonaCtrl, ksTypes, ksLoadingIndicator, FMX.Media, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani;

type
  TFrmProdutoEnderecar = class(TFrmBase)
    LytZona: TLayout;
    RctZona: TRectangle;
    EdtZonaId: TEdit;
    Label1: TLabel;
    BtnSearchZona: TSpeedButton;
    Path1: TPath;
    LvZona: TListView;
    img_check: TImage;
    img_uncheck: TImage;
    RctZonaEmpty: TRectangle;
    Label2: TLabel;
    LblZona: TLabel;
    LytProduto: TLayout;
    RctProduto: TRectangle;
    EdtProduto: TEdit;
    Label3: TLabel;
    LblProduto: TLabel;
    BtnSearchProduto: TSpeedButton;
    Path2: TPath;
    Line1: TLine;
    Line2: TLine;
    LytEnderecoDisponivel: TLayout;
    RctEnderecoDisponivel: TRectangle;
    lvEnderecoDisponivel: TListView;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Label15: TLabel;
    Label16: TLabel;
    EdtEndereco: TEdit;
    Line3: TLine;
    Label4: TLabel;
    LblEndereco: TLabel;
    LytLvZona: TLayout;
    LytTopZona: TLayout;
    LytHearderZona: TLayout;
    Rectangle1: TRectangle;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure BtnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure LvZonaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure EdtProdutoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtZonaIdKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtProdutoTyping(Sender: TObject);
    procedure EdtZonaIdTyping(Sender: TObject);
    procedure EdtProdutoValidate(Sender: TObject; var Text: string);
    procedure FormDestroy(Sender: TObject);
    procedure EdtZonaIdValidate(Sender: TObject; var Text: string);
    procedure EdtEnderecoTyping(Sender: TObject);
    procedure EdtEnderecoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    ObjProduto  : TProduto;
    ObjEndereco : TEndereco;
    Procedure GetZonaEnderecoDisponivel(pZonaId : Integer = 0; pPickingFixo : Integer = 1; pDisponivel : Integer = 1);
    Procedure GetProduto;
    Function GetEndereco : Boolean;
    Procedure ListaEndereco(pZonaId : Integer);
    Procedure ProdutoEnderecar;
    Function CheckZona : Boolean;
    Function CheckEnderecoDiponivel : Boolean;
  public
    { Public declarations }
  end;

var
  FrmProdutoEnderecar: TFrmProdutoEnderecar;

implementation

{$R *.fmx}

uses uMyTabOrderClassHelper, uFuncoes, EstoqueCtrl;

procedure TFrmProdutoEnderecar.BtnAddClick(Sender: TObject);
begin
  //inherited;
  FuncaoDesabilitada(FrmProdutoEnderecar);
end;

procedure TFrmProdutoEnderecar.BtnCancelClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmProdutoEnderecar.BtnSaveClick(Sender: TObject);
begin
//  inherited;

end;

function TFrmProdutoEnderecar.CheckEnderecoDiponivel: Boolean;
Var xLista : Integer;
    LvItem : TListItemText;
begin
  Result := True;
  For xLista := 0 to Pred(lvEnderecoDisponivel.Items.Count) do Begin
    LvItem := TListItemText(lvEnderecoDisponivel.Items[xLista].Objects.FindDrawable('ItEndereco'));
    If StringReplace(LvItem.Text, '.', '', [rfReplaceAll]) = EdtEndereco.Text then Begin
       Result := True;
       Break;
    End;
  End;
end;

function TFrmProdutoEnderecar.CheckZona: Boolean;
Var xZona, vZonaId : Integer;
    LvItem : TListItemText;
begin
  Result := True;
  For xZona := 0 to Pred(LvZona.Items.Count) do Begin
    LvItem := TListItemText(LvZona.Items[xZona].Objects.FindDrawable('ItZonaId'));
    if (LvZona.Items[xZona].Checked) and (ObjEndereco.EnderecamentoZona.ZonaId <> StrToIntDef(LvItem.Text, 0)) then
       Result := False;
  End;
end;

procedure TFrmProdutoEnderecar.EdtEnderecoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (Key = vkReturn) and (EdtEndereco.Text<>'') then Begin
     if (edtProduto.Text = '') or (Not Assigned(ObjProduto)) then Begin
        ShowErro('Informe o produto para endereçar.');
        EdtEndereco.Text := '';
        DelayEdSetFocus(EdtProduto);
     End
//     Else if  (EdtEndereco.Text='0') or ((EdtEndereco.Text <> '0') and (GetEndereco)) then Begin
     Else if GetEndereco then Begin
        if EdtEndereco.Text = '0' then
           ObjEndereco.EnderecoId := 0;
        ProdutoEnderecar;
     End;
  End;
end;

procedure TFrmProdutoEnderecar.EdtEnderecoTyping(Sender: TObject);
begin
  inherited;
  LblEndereco.Text := '';
end;

procedure TFrmProdutoEnderecar.EdtProdutoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;  If ((key = 0) and (IntToStr(ord(KeyChar))='0') and ((Sender=EdtProduto) or (Sender=EdtEndereco))) then Begin //Descobrir Key do Ativador de Leitor de Código de Barras//  https://developer.zebra.com/thread/29927
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

procedure TFrmProdutoEnderecar.EdtProdutoTyping(Sender: TObject);
begin
  inherited;
  EdtEndereco.Text := '';
  LblProduto.Text  := '';
  LblEndereco.Text := '';
//  if Assigned(ObjProduto) then
//     ObjProduto.DisposeOf;
//  if Assigned(ObjEndereco) and (ObjEndereco <> Nil) then
//     ObjEndereco.DisposeOf;
end;

procedure TFrmProdutoEnderecar.EdtProdutoValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if StrToInt64Def(Text, 0) > 0 then
     GetProduto;
end;

procedure TFrmProdutoEnderecar.EdtZonaIdKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmProdutoEnderecar.EdtZonaIdTyping(Sender: TObject);
begin
  inherited;
  LblZona.Text     := '';
  EdtProduto.Text  := '';
  EdtEndereco.Text := '';
  LblProduto.Text  := '';
  LblEndereco.Text := '';
  LvZona.Items.Clear;
  lvEnderecoDisponivel.Items.Clear;
  if Assigned(ObjProduto) and (ObjProduto <> Nil) then
     ObjProduto.DisposeOf;
  if Assigned(ObjEndereco) and (ObjEndereco <> Nil) then
     ObjEndereco.DisposeOf;
end;

procedure TFrmProdutoEnderecar.EdtZonaIdValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Begin
     Text := '';
     raise Exception.Create('Id da Zona Inválido!');
  End;
  GetZonaEnderecoDisponivel(StrToIntDef(EdtZonaId.Text, 0), 1, 1);
end;

procedure TFrmProdutoEnderecar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmProdutoEnderecar := Nil;
end;

procedure TFrmProdutoEnderecar.FormCreate(Sender: TObject);
begin
  inherited;
  GetZonaEnderecoDisponivel(0, 1, 1);
  img_uncheck.Visible := false;
  img_check.Visible   := false;
  PgcPrincipal.ActiveTab := TabDetalhes;
end;

procedure TFrmProdutoEnderecar.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(ObjProduto) then
     ObjProduto.DisposeOf;
  if Assigned(ObjEndereco) then
     ObjEndereco.DisposeOf;
end;

Function TFrmProdutoEnderecar.GetEndereco : Boolean;
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    verro            : String;
begin
Try
  Result := True;
  LblEndereco.Text := '';
  if EdtEndereco.Text = '' then Exit;
  ShowLoading;
  ObjEnderecoCtrl  := TEnderecoCtrl.Create;
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 2, 0, 0, EdtEndereco.Text, EdtEndereco.Text, 'T', 99, 99, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtEndereco.Text := '';
     JsonArrayRetorno := Nil;
     FreeAndNil(ObjEnderecoCtrl);
     HideLoading;
     Result := False;
     ShowErro('Endereço não encontrado!');
     DelayedSetFocus(EdtEndereco);
     Exit;
  End;
  if Not Assigned(ObjEndereco) then
     ObjEndereco := TEndereco.Create;
  ObjEndereco := ObjEndereco.JsontoClass(JsonArrayRetorno.Items[0].ToString());
  If JsonArrayRetorno.Items[0].GetValue<Integer>('status') = 0 then Begin
     EdtEndereco.Text := '';
     JsonArrayRetorno := Nil;
     FreeAndNil(ObjEnderecoCtrl);
     HideLoading;
     Result := False;
     ShowErro('Endereço inativo!');
     DelayedSetFocus(EdtEndereco);
     Exit;
  End
  Else If JsonArrayRetorno.Items[0].GetValue<Integer>('bloqueado') = 1 then Begin
     EdtEndereco.Text := '';
     JsonArrayRetorno := Nil;
     FreeAndNil(ObjEnderecoCtrl);
     HideLoading;
     Result := False;
     ShowErro('Endereço Bloqueado!');
     DelayedSetFocus(EdtEndereco);
     Exit;
  End;
  LblEndereco.Text := ObjEndereco.EnderecoEstrutura.Descricao+#13+ObjEndereco.EnderecamentoZona.Descricao;
  if ObjEndereco.EnderecoEstrutura.PickingFixo = 0 then begin
     Result := False;
     ShowErro('Estrutura do Endereço não é Picking.');
     EdtEndereco.Text := '';
     DelayEdSetFocus(EdtEndereco);
  End
  Else Begin
     ObjEndereco.ProdutoId := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('produto').GetValue<Integer>('produtoid');
     If (ObjEndereco.ProdutoId <> 0)  and (ObjEndereco.ProdutoId<>ObjProduto.IdProduto) Then Begin
        Result := False;
        ShowErro('Endereço já vinculado ao produto: '+JsonArrayRetorno.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('codproduto')); //ObjEndereco.CodProduto.ToString());
        EdtEndereco.Text := '';
        DelayEdSetFocus(EdtEndereco);
     End
     Else if Not CheckZona then Begin
        Result := False;
        ShowErro('Endereço('+EdtEndereco.Text+') não pertence a Zona Selecionada.');
        EdtEndereco.Text := '';
        DelayEdSetFocus(EdtEndereco);
     End
     Else if Not CheckEnderecoDiponivel then begin
        Result := False;
        ShowErro('Endereço não pertence a lista diponível.');
        EdtEndereco.Text := '';
        DelayEdSetFocus(EdtEndereco);
     End;
  End;
  //BtnSchCaixaClick(BtnSchCaixa);
  JsonArrayRetorno := Nil;
  ObjEnderecoCtrl.Disposeof;
  HideLoading;
Except On E: Exception do Begin
  HideLoading;
  raise Exception.Create('Erro GetEndereco : '+E.Message);
  End;
End;
end;

procedure TFrmProdutoEnderecar.GetProduto;
Var vCod      : Integer;
    vErro, vCodBarra : String;
    JsonArrayRetorno : TJsonArray;
    ObjProdutoCtrl : TProdutoCtrl;
begin
  LblProduto.Text := '...';
  ShowLoading;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  JsonArrayRetorno := ObjProdutoCtrl.FindProduto('0', EdtProduto.Text, '', 0, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtProduto.Text := '';
     DelayedSetFocus(EdtProduto);
     JsonArrayRetorno := Nil;
     ObjProdutoCtrl.DisposeOf;
     HideLoading;
     ShowErro('Produto não encontrado!');
     Exit;
  End;
  if Not Assigned(ObjProduto) then
     ObjProduto := TProduto.Create;
  ObjProduto    := ObjProduto.JsonToClass(JsonArrayRetorno.Items[0].ToString());
  if ObjProduto.Endereco.EnderecoId <> 0 then Begin
     //EdtEndereco.Text := ObjProduto.Endereco.Descricao;
     //LblEndereco.Text := ObjProduto.EnderecamentoZona.Descricao;
     //GetEndereco;
     ShowErro('Produro('+EdtProduto.Text+') já vinculado a Picking.');
     EdtProduto.Text := '';
  End;
  LblProduto.Text  := ObjProduto.Descricao;;
  JsonArrayRetorno := Nil;
  ObjProdutoCtrl.DisposeOf;
  DelayEdSetFocus(EdtEndereco);
  HideLoading;
end;

//https://www.youtube.com/watch?v=Zt7UIulMkeE&ab_channel=Delphisemenrola%C3%A7%C3%A3o-ComJonatanSouza
procedure TFrmProdutoEnderecar.GetZonaEnderecoDisponivel(pZonaId,
  pPickingFixo: Integer; pDisponivel : Integer);
Var ObjEnderamentoZonaCtrl : TEnderecamentoZonaCtrl;
    JsonArrayRetorno       : TJsonArray;
    vErro                  : String;
    xZona, vZonaId         : Integer;
begin
  ShowLoading;
  RctZonaEmpty.Visible := True;
  LvZona.Visible       := False;
  LblZona.Text         := '';
  ObjEnderamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  JsonArrayRetorno := TJsonArray.Create();
  JsonArrayRetorno := ObjEnderamentoZonaCtrl.GetZonaPicking(pZonaId, pPickingFixo, pDisponivel, 0);
  ObjEnderamentoZonaCtrl := Nil;
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtProduto.Text := '';
     DelayedSetFocus(EdtCodigo);
     ObjEnderamentoZonaCtrl := Nil;
     JsonArrayRetorno := Nil;
     HideLoading;
     ShowErro('Não há Zona/Picking Disponível!');
     Exit;
  End
  Else Begin
    RctZonaEmpty.Visible := False;
    LvZona.Visible       := True;
    For xZona := 0 to Pred(JsonArrayRetorno.Count) do Begin
      vZonaId := JsonArrayRetorno.Items[xZona].GetValue<Integer>('zonaid');
      if EdtZonaId.Text = '' then
         TMyListview.AddItem(LvZona, vZonaId.ToString(),
                                     JsonArrayRetorno.Items[xZona].GetValue<String>('descricao'),
                                     JsonArrayRetorno.Items[xZona].GetValue<Integer>('enddisponivel'),
                                     img_uncheck.Bitmap, False)

      Else
         TMyListview.AddItem(LvZona, vZonaId.ToString(),
                                     JsonArrayRetorno.Items[xZona].GetValue<String>('descricao'),
                                     JsonArrayRetorno.Items[xZona].GetValue<Integer>('enddisponivel'),
                                     img_check.Bitmap, True);
    End;
    if EdtZonaId.Text <> '' then
       LblZona.Text := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
    //ListaEndereco(0);
  End;
  JsonArrayRetorno := Nil;
  HideLoading;
end;

procedure TFrmProdutoEnderecar.ListaEndereco(pZonaId: Integer);
Var JsonArrayEndereco : TJsonArray;
    ObjEnderecoCtrl   : TEnderecoCtrl;
    xLista            : Integer;
    vErro             : String;
Var LvItem : TListItemText;
    xZona  : Integer;
begin
  LvEnderecoDisponivel.Items.Clear;
  For xZona := 0 to Pred(LvZona.Items.Count) do Begin
    If (LvZona.Items[xZona].Checked) then Begin
       LvItem := TListItemText(LvZona.Items[xZona].Objects.FindDrawable('ItZonaId'));

       pZonaId := StrToIntDef(LvItem.Text, 0);
       ObjEnderecoCtrl   := TEnderecoCtrl.Create;
       JsonArrayEndereco := TJsonArray.Create;
       JsonArrayEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 0, pZonaId, 0, '', '', 'L', 99, 0, 1);
       if Not JsonArrayEndereco.Items[0].TryGetValue<String>('Erro', vErro) then Begin
          for xLista := 0 to Pred(JsonArrayEndereco.Count) do Begin
              TMyListview.AddItem(lvEnderecoDisponivel, JsonArrayEndereco.Items[xLista].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('zonaid'),
                                       EnderecoMask(JsonArrayEndereco.Items[xLista].GetValue<String>('descricao'),
                                                    JsonArrayEndereco.Items[xLista].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True),
                                       0, img_uncheck.Bitmap, False);
          End;
       End;
       ObjEnderecoCtrl   := Nil;
       JsonArrayEndereco := Nil;
    End;
  End;
end;

procedure TFrmProdutoEnderecar.LvZonaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  TMyListview.SelecionarItem(LvZona, Aitem, img_uncheck.Bitmap, img_check.Bitmap);
  Try
    ListaEndereco(0);
  Except
    TMyListview.SelecionarItem(LvZona, Aitem, img_uncheck.Bitmap, img_check.Bitmap);
  End;
end;

procedure TFrmProdutoEnderecar.ProdutoEnderecar;
Var ProdutoCtrl      : TProdutoCtrl;
    ObjestoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    //JsonArrayEstoque : TJsonArray;
    vErro            : String;
begin
  Try
    ShowLoading;
//Se for troca de Picking, verificar se existe Estoque no Picking anterior, e impedir caso positivo.
    if (ObjProduto.Endereco.EnderecoId <> 0) and (ObjProduto.Endereco.EnderecoId<>ObjEndereco.EnderecoId) then Begin
       ObjEstoqueCtrl := TEstoqueCtrl.Create;
       JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueLotePorTipo(0, 0, ObjProduto.Endereco.Enderecoid, 0, 2, 2, 'S', 'S', 0);
       if (Not JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro)) and (JsonArrayRetorno.Count>=1) then Begin
          JsonArrayRetorno := Nil;
          ObjEstoqueCtrl.DisposeOf;
          EdtProduto.Text := '';
          EdtProdutoTyping(EdtProduto);
          DelayEdSetFocus(EdtProduto);
          HideLoading;
          ShowErro('Produto não pode ter o picking alterado, pois existe estoque no mesmo.');
          Exit;
       End;
       JsonArrayRetorno := Nil;
       ObjEstoqueCtrl.DisposeOf;
    End;
    ProdutoCtrl := TProdutoCtrl.Create;
    JsonArrayRetorno := ProdutoCtrl.EnderecarProduto(ObjProduto.IdProduto, ObjEndereco.EnderecoId);
    if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then
       raise Exception.Create('Erro no Endereçamento: '+verro)
    else
       MensagemStand('Produto endereçado no Picking');
  Except On E: Exception do Begin
    JsonArrayRetorno := Nil;
    ProdutoCtrl.DisposeOf;
    HideLoading;
    raise Exception.Create('Erro no Endereçamento: '+EnderecoMask(EdtEndereco.Text, '', False)+sLineBreak+E.Message);
    End;
  End;
  JsonArrayRetorno := Nil;
  ProdutoCtrl.DisposeOf;
  EdtProduto.Text := '';
  EdtProdutoTyping(EdtProduto);
  HideLoading;
end;

End.
