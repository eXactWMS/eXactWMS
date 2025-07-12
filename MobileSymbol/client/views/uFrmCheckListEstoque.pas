unit uFrmCheckListEstoque;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.ActnList,
  System.Actions, FMX.TabControl, ksTypes, ksLoadingIndicator, FMX.Media,
  FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.Objects, FMX.ListView,
  FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.Layouts, EnderecoCtrl, EstoqueCtrl, ProdutoCtrl,
  System.JSON, REST.Json, Rest.Types, DataSet.Serialize;

type
  TFrmCheckListEstoque = class(TFrmBase)
    Layout1: TLayout;
    LytDadosCheckList: TLayout;
    LblProduto: TLabel;
    LblEndereco: TLabel;
    LytContagem: TLayout;
    Label2: TLabel;
    EdtQtdUnid: TEdit;
    Line2: TLine;
    Label3: TLabel;
    EdtQtdEmbalagem: TEdit;
    Line3: TLine;
    LblEmbalagem: TLabel;
    Label4: TLabel;
    EdtCodigoERP: TEdit;
    Line4: TLine;
    Label5: TLabel;
    LytCheckList: TLayout;
    RctTitleContagem: TRectangle;
    LblTitContCodErp: TLabel;
    LblTitContLote: TLabel;
    LblTitContVencimento: TLabel;
    LblTitContQuant: TLabel;
    LstCheckList: TListView;
    EdtLote: TEdit;
    LnLote: TLine;
    Label1: TLabel;
    Label6: TLabel;
    FDMemCheckList: TFDMemTable;
    ImgLstFdoWhite: TImage;
    FDMemCheckListDescrLote: TStringField;
    FDMemCheckListVencimento: TDateField;
    FDMemCheckListQtde: TIntegerField;
    FDMemCheckListQtdCheckList: TIntegerField;
    FDMemCheckListCodigoERP: TIntegerField;
    FDMemCheckListProduto: TStringField;
    FDMemCheckListEmbPrim: TStringField;
    FDMemCheckListEmbSec: TStringField;
    FDMemCheckListFatorConversao: TIntegerField;
    FDMemCheckListProdutoId: TIntegerField;
    SwtInventario: TSwitch;
    LblInventario: TLabel;
    FDMemCheckListEnderecoId: TIntegerField;
    procedure EdtCodigoValidate(Sender: TObject; var Text: string);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure EdtCodigoERPValidate(Sender: TObject; var Text: string);
    procedure EdtCodigoERPTyping(Sender: TObject);
    procedure EdtLoteTyping(Sender: TObject);
    procedure EdtLoteValidate(Sender: TObject; var Text: string);
    procedure EdtQtdUnidKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure SwtInventarioClick(Sender: TObject);
  private
    { Private declarations }
    vEnderecoId : integer;
    Procedure GetEndereco;
    procedure MontaListaCheckList;
    function GetCodigoERP(pCodigoERP: String): Integer;
    Procedure GetEstoqueEndereco;
    Procedure LimparContagem;
    Procedure AtualizarContagem(Sender: TObject);
    Procedure SalvarCancelar(pPermitir : Boolean);
  Protected
    Procedure Limpar; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure AtivaCampoDefault; OverRide;
    Procedure ConfirmacaoCancel; OverRide;
    Function SalvarReg : Boolean; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCheckListEstoque: TFrmCheckListEstoque;

implementation

{$R *.fmx}

{ TFrmCheckListEstoque }

uses uFuncoes, uFrmeXactWMS, U_MsgD;

procedure TFrmCheckListEstoque.AtualizarContagem;
begin
  if (StrToInt64Def(EdtQtdUnid.Text, 0)<0) then Begin
     if Sender = EdtQtdUnid then Begin
        SetCampoDefault('EdtQtdUnid');
        ShowErro('Quantidade inválida');
     End
     Else Begin
        ShowErro('Quantidade de embalagem inválida');
        SetCampoDefault('EdtQtdEmbalagem');
     End;
  End
  Else if ((Sender=EdtQtdUnid) and (StrToInt64Def(EdtQtdUnid.Text, 0)>99999)) then Begin
     SetCampoDefault('EdtQtdUnid');
     ShowErro('Não é permitido quantidade maior que 99999.');
  End
  Else if ((Sender=EdtQtdEmbalagem) and ((StrToInt64Def(EdtQtdEmbalagem.Text, 0)*FdMemCheckList.FieldByName('FatorConversao').AsInteger)>99999)) then Begin
     SetCampoDefault('EdtQtdEmbalagem');
     ShowErro('Qtd de Embalagem não é permitido. Quantidade maior que 99999.');
  End;
  FdMemCheckList.Edit;
  if Sender = EdtQtdUnid then
     FdMemCheckList.FieldByName('QtdCheckList').Value := FdMemCheckList.FieldByName('QtdCheckList').AsInteger + StrToInt64Def(EdtQtdUnid.Text, 0)
  Else
     FdMemCheckList.FieldByName('QtdCheckList').Value := FdMemCheckList.FieldByName('QtdCheckList').AsInteger +
     (StrToInt64Def(EdtQtdEmbalagem.Text, 0)*FdMemCheckList.FieldByName('FatorConversao').Value);
  FdMemCheckList.Post;
  LimparContagem;
end;

procedure TFrmCheckListEstoque.ConfirmacaoCancel;
begin
  inherited;
  EdtCodigo.Text := '';
  Limpar;
end;

procedure TFrmCheckListEstoque.EdtCodigoERPTyping(Sender: TObject);
begin
  inherited;
  EdtLote.text         := '';
  EdtQtdUnid.Text      := '';
  EdtQtdEmbalagem.Text := '';
end;

procedure TFrmCheckListEstoque.EdtCodigoERPValidate(Sender: TObject; var Text: string);
Var vCodigoERP : Integer;
begin
  inherited;
  if EdtCodigoERP.Text = '' then Exit;
  FdMemCheckList.First;
  if Not FdmemCheckList.Locate('CodigoERP', EdtCodigoERP.Text, [loPartialKey]) then Begin
     vCodigoERP := GetCodigoERP(EdtCodigoERP.Text);
     if vCodigoERP = 0 then Begin
        EdtCodigoERP.Text := '';
        DelayEdSetFocus(EdtCodigoERP);
        Exit;
     End;
  End
  Else
     vCodigoERP := FdmemCheckList.FieldByName('CodigoERP').AsInteger;
  LblProduto.Text   := FdmemCheckList.FieldByName('Produto').AsString;
  DelayEdSetFocus(EdtLote);
  if FdmemCheckList.FieldByName('FatorConversao').AsInteger > 1 then Begin
     If FdmemCheckList.FieldByName('EmbSec').AsString <> 'Unidade' then
        LblEmbalagem.Text := FdmemCheckList.FieldByName('EmbSec').AsString+ ' c/ '+FdmemCheckList.FieldByName('FatorConversao').AsString
     Else LblEmbalagem.Text := 'Caixa c/ '+FdmemCheckList.FieldByName('FatorConversao').AsString;
     EdtQtdEmbalagem.Visible := True;
  End
  Else  Begin
     LblEmbalagem.Text := '';
     EdtQtdEmbalagem.Visible := False;
  End;
end;

procedure TFrmCheckListEstoque.EdtLoteTyping(Sender: TObject);
begin
  inherited;
  EdtQtdUnid.Text      := '';
  EdtQtdEmbalagem.Text := '';
end;

procedure TFrmCheckListEstoque.EdtLoteValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if EdtLote.Text = '' then Exit;

  if Not FdMemCheckList.Locate('CodigoERP; DescrLote', VarArrayOf([EdtCodigoERP.Text, EdtLote.Text]), []) then begin
     SetCampoDefault('EdtLote');
     ShowErro('Lote não pertence a esse endereço!');
     Text := '';
  end
  Else
     DelayEdSetFocus(EdtQtdUnid);
end;

procedure TFrmCheckListEstoque.EdtQtdUnidKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (key = 13) and (TEdit(Sender).Text <> '') then
     AtualizarContagem(Sender);
end;

procedure TFrmCheckListEstoque.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtCodigo' then Begin
     EdtCodigo.Text := '';
     DelayEdSetFocus(EdtCodigo);
  End
  Else if CampoDefault = 'EdtCodigoERP' then Begin
     EdtCodigoERP.Text := '';
     DelayEdSetFocus(EdtCodigoERP);
  End
  Else if CampoDefault = 'EdtLote' then Begin
     EdtLote.Text := '';
     DelayEdSetFocus(EdtLote);
  End
  Else if CampoDefault = 'EdtQtdUnid' then Begin
     EdtQtdUnid.Text := '';
     DelayEdSetFocus(EdtQtdUnid);
  End
  Else if CampoDefault = 'EdtQtdEmbalagem' then Begin
     EdtQtdEmbalagem.Text := '';
     DelayEdSetFocus(EdtQtdEmbalagem);
  End;
end;

procedure TFrmCheckListEstoque.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmCheckListEstoque.EdtCodigoValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  if Text = '' then Exit;
  GetEndereco;
end;

Function TFrmCheckListEstoque.GetCodigoERP(pCodigoERP: String) : Integer;
Var ObjProdutoCtrl    : TProdutoCtrl;
    JsonArrayRetorno  : TJsonArray;
    vErro             : String;
begin
  Result := 0;
  ObjProdutoCtrl := TProdutoCtrl.Create();
  JsonArrayRetorno := ObjProdutoCtrl.FindProduto('0', pCodigoERP, '', 0, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     SetCampoDefault('EdtCodigoERP');
     DelayEdSetFocus(EdtCodigoERP);
     ShowErro('Codigo de produto inválido!!!');
  End
  Else Begin
    Result := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto');
    FdMemCheckList.First;
    if Not FdMemCheckList.Locate('CodigoERP', Result, [loPartialKey]) then Begin
       SetCampoDefault('EdtCodigoERP');
       ShowErro('Produto não armazenado esse endereço!');
       //Verificar Tratativam: Deve contar ou retirar do Endereco ?????
    End
  End;
  JsonArrayRetorno := Nil;
  ObjProdutoCtrl.Free;
end;

procedure TFrmCheckListEstoque.GetEndereco;
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    verro            : String;
begin
  vEnderecoId      := 0;
  LblEndereco.Text := '';
  if EdtCodigo.Text = '' then Exit;
  Try
    ShowLoading;
    ObjEnderecoCtrl  := TEnderecoCtrl.Create;
    JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EdtCodigo.Text, EdtCodigo.Text, 'T', 99, 0, 0);
    if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
       EdtCodigo.Text := '';
       HideLoading;
       SetCampoDefault('EdtCodigo');
       ShowErro('Endereço não encontrado!');
       DelayedSetFocus(EdtCodigo);
       JsonArrayRetorno := Nil;
       ObjEnderecoCtrl.Free;
       Exit;
    End
    Else Begin
       LblEndereco.Text := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao')+': ';
       LblEndereco.Text := LblEndereco.Text+JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao')+' - ';
       if JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<Integer>('estruturaid') = 2 then
          LblProduto.Text :=  JsonArrayRetorno.Items[0].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
       vEnderecoId  := JsonArrayRetorno.Items[0].GetValue<Integer>('enderecoid');
       GetEstoqueEndereco;
    End;
  Except On E: Exception do  Begin
    EdtCodigo.Text := '';
    ShowErro(E.Message);
    DelayEdSetFocus(EdtCodigo);
    End;
  End;
  HideLoading;
  JsonArrayRetorno := Nil;
  ObjEnderecoCtrl.Free;
end;

procedure TFrmCheckListEstoque.GetEstoqueEndereco;
Var ObjEstoqueCtrl : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if vEnderecoId = 0 then begin
     ShowErro('Informe o Endereço para buscar o estoque.');
     exit;
  End;
  ObjEstoqueCtrl   := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueJson(0, 0, vEnderecoId, 0, 2, 2, 'N', 'N', 0);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     SetCampoDefault('EdtCodigo');
     ShowErro('Erro: '+vErro, 'alerta');
  End
  Else if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     SetCampoDefault('EdtCodigo');
     ShowErro('Atenção: '+vErro, 'alerta');
  End
  Else begin
     If FdMemCheckList.Active then
        FdMemCheckList.EmptyDataSet;
     FdMemCheckList.Close;
     FdMemCheckList.LoadFromJson(JsonArrayRetorno, False);
     MontaListaCheckList;
     SalvarCancelar(True);
     DelayEdSetFocus(EdtCodigoERP);
  End;
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmCheckListEstoque.GetListaLstCadastro;
begin
//  inherited;
  PgcPrincipal.GotoVisibleTab(1);//  ActiveTab := TabDetalhes;
end;

procedure TFrmCheckListEstoque.Limpar;
begin
  inherited;
  LblProduto.Text  := '';
  lblEndereco.Text := '';
  If FdMemCheckList.Active then
     FdMemCheckList.EmptyDataSet;
  FdMemCheckList.Close;
  LstCheckList.BeginUpdate;
  LstCheckList.Items.Clear;
  LstCheckList.EndUpdate;
  SalvarCancelar(False);
  DelayEdSetFocus(EdtCodigo);
  SwtInventario.IsChecked := False;
  LblInventario.FontColor := TAlphaColorRec.Gray;
end;

procedure TFrmCheckListEstoque.LimparContagem;
begin
  MontaListaCheckList;
  EdtCodigoERP.Text    := '';
  EdtLote.Text         := '';
  EdtQtdUnid.Text      := '';
  EdtQtdEmbalagem.Text := '';
  DelayEdSetFocus(EdtCodigoERP);
end;

procedure TFrmCheckListEstoque.MontaListaCheckList;
Var item : TListViewItem;
    txt : TListItemText;
    img : TListItemImage;
    Cor : Cardinal;
begin
  FdMemCheckList.First;
  LstCheckList.BeginUpdate;
  LstCheckList.Items.Clear;
  While Not FdMemCheckList.Eof do Begin
    item := LstCheckList.Items.Add;
    item.Objects.Clear;
    item.TagString := FdMemCheckList.FieldByName('CodigoERP').AsString;
    with item do begin
      // Status do Endereço...
      img := TListItemImage(Objects.FindDrawable('ImgFdoCheckList'));

      img.ScalingMode := TImageScalingMode.Stretch;
      If (FdMemCheckList.FieldByName('QtdCheckList').AsInteger = 0) then begin
         img.Bitmap := ImgLstFdoWhite.Bitmap;
         Cor:= $FF5DA9BC;
      End
      Else If (FdMemCheckList.FieldByName('QtdCheckList').AsInteger>FdMemCheckList.FieldByName('Qtde').AsInteger) Then Begin  //Em Contagem
         img.Bitmap := ImgLstFdoRed.Bitmap;
         Cor:= $FFE9C168;
      End
      Else If (FdMemCheckList.FieldByName('QtdCheckList').AsInteger<>FdMemCheckList.FieldByName('Qtde').AsInteger) Then Begin  //Em Contagem
         img.Bitmap := ImgLstFdoYellow.Bitmap;
         Cor:= $FFE9C168;
      End
      Else Begin
         img.Bitmap := ImgLstFdoGreen.BitMap;
         Cor:= $FF32B932;
      end;
      //Estrutura
      // Setor...
      txt := TListItemText(Objects.FindDrawable('TxtCodProduto'));
      txt.Text := FdMemCheckList.FieldByName('CodigoERP').AsString;
      txt := TListItemText(Objects.FindDrawable('TxtDescricao'));
      txt.Text := FdMemCheckList.FieldByName('Produto').AsString;

      // Setor...
      txt := TListItemText(Objects.FindDrawable('TxtLote'));
      txt.Text := FdMemCheckList.FieldByName('DescrLote').AsString;

      txt := TListItemText(Objects.FindDrawable('TxtVencimento'));
      txt.Text := FdMemCheckList.FieldByName('Vencimento').AsString;

      txt := TListItemText(Objects.FindDrawable('TxtQtdCheckList'));
      txt.Text := FdMemCheckList.FieldByName('QtdCheckList').AsString;
    End;
    FdMemCheckList.Next;
  End;
  LstCheckList.EndUpdate;
end;

procedure TFrmCheckListEstoque.SalvarCancelar(pPermitir: Boolean);
begin
  BtnCancel.Visible := pPermitir;
  BtnSave.Visible   := pPermitir;
  BtnCancel.Enabled := pPermitir;
  BtnSave.Enabled   := pPermitir;
  PthBtnCancel.Fill.Color := TAlphaColorRec.Chocolate;
  PthBtnSave.Fill.Color   := TAlphaColorRec.Chocolate;
  LblInventario.FontColor := TAlphaColorRec.Gray;
  EdtCodigoErp.Enabled    := pPermitir;
  EdtLote.Enabled         := pPermitir;
  EdtQtdUnid.Enabled      := pPermitir;
  EdtQtdEmbalagem.Enabled := pPermitir;
  SwtInventario.Enabled   := pPermitir;
  EdtCodigoErp.ReadOnly    := Not pPermitir;
  EdtLote.ReadOnly         := Not pPermitir;
  EdtQtdUnid.ReadOnly      := Not pPermitir;
  EdtQtdEmbalagem.ReadOnly := Not pPermitir;
end;

function TFrmCheckListEstoque.SalvarReg: Boolean;
var ObjEstoqueCtrl    : TEstoqueCtrl;
    JsonArrayretorno  : TJsonArray;
    vErro : String;
    JsonCheckList     : TJsonObject;
    JsonInventario    : TjsonObject;
    JsonArrayEndereco : TJsonArray;
begin
  Result := False;
  JsonCheckList  := TJsonObject.Create;
  JsonInventario := TjsonObject.Create;
  JsonCheckList.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonCheckList.AddPair('terminal',  NomeDoComputador);
  if SwtInventario.IsChecked then Begin
     Jsoninventario.AddPair('inventarioid', TJsonNumber.Create(0));
     Jsoninventario.AddPair('datacriacao', DateToStr(Now()));
     Jsoninventario.AddPair('dataliberacao', '');
     Jsoninventario.AddPair('inventariotipo', TJsonNumber.Create(1));
     Jsoninventario.AddPair('motivo', 'CheckList de Estoque');
     if FrmeXactWMS.ConfigWMS.InventarioAjustePadrao = 0 then
        Jsoninventario.AddPair('tipoajuste', TJsonNumber.Create(0))
     Else
        Jsoninventario.AddPair('tipoajuste', TJsonNumber.Create(FrmeXactWMS.ConfigWMS.InventarioAjustePadrao));
     Jsoninventario.AddPair('status', TJsonNumber.Create(1));
     JsonArrayEndereco := TJsonArray.Create;
     JsonArrayEndereco.AddElement(TJsonObject.Create.AddPair('enderecoid', TJsonNumber.Create(FdMemCheckList.FieldByName('EnderecoId').AsInteger)));
     JsonInventario.AddPair('endereco', JsonArrayEndereco);
  End;
  JsonCheckList.AddPair('checklist',  FdMemCheckList.ToJsonArray);
  JsonCheckList.AddPair('inventario', JsonInventario);
  ObjEstoqueCtrl   := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.SalvarEstoqueChecklist(JsonCheckList);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro, 'alarme');
  End
  Else Begin
     Result := True;
     DelayEdSetFocus(EdtCodigo);
     if JsonArrayRetorno.Items[0].GetValue<Integer>('inventarioid') = 0 then
        ShowOk('CheckList('+JsonArrayRetorno.Items[0].GetValue<Integer>('checklistid').ToString()+') do Estoque Salvo com sucesso.', 'ok')
     Else
        MensagemStand('CheckList = '+JsonArrayRetorno.Items[0].GetValue<Integer>('checklistid').ToString()+
               '  InventárioId = '+JsonArrayRetorno.Items[0].GetValue<Integer>('inventarioid').ToString()+'.');
  End;
  JsonInventario   := Nil;
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmCheckListEstoque.SwtInventarioClick(Sender: TObject);
begin
  inherited;
  If SwtInventario.IsChecked then
     LblInventario.FontColor := TAlphaColorRec.Chocolate
  else
     LblInventario.FontColor := TAlphaColorRec.Gray;
end;

end.
