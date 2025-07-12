unit uFrmCorrecaoLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, System.Json, Rest.Types,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses,
  acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC,
  Vcl.Mask, JvExMask, JvSpin, JvToolEdit, JvBaseEdits, Generics.Collections, DataSet.Serialize,
  dxCameraControl;

type
  TFrmCorrecaoLotes = class(TFrmBase)
    PnlCadProduto: TPanel;
    edtCodProduto: TLabeledEdit;
    btnPesquisar: TBitBtn;
    edtDescricao: TLabeledEdit;
    Label23: TLabel;
    CbRastroTipo: TComboBox;
    EdtDescricaoRed: TLabeledEdit;
    PnlLotes: TPanel;
    PnlLstLotes: TPanel;
    DbgLotes: TDBGrid;
    PnlEditLotes: TPanel;
    EdtDescricaoLote: TEdit;
    EdtDtFabricacaoLote: TJvDateEdit;
    EdtDtVencimentoLote: TJvDateEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LblQtdeLote: TLabel;
    EdtQtdeLote: TJvCalcEdit;
    DbgEditLotes: TDBGrid;
    FDMemCorrecaoLote: TFDMemTable;
    DsCorrecaoLote: TDataSource;
    BtnSalvarLote: TPanel;
    sImage1: TsImage;
    BtnCancelarLote: TPanel;
    sImage2: TsImage;
    EdtProdutoId: TLabeledEdit;
    FdMemPesqGeralLoteId: TIntegerField;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralCodigoERP: TIntegerField;
    FdMemPesqGeralDescrLote: TStringField;
    FdMemPesqGeralEstoque: TIntegerField;
    FdMemPesqGeralBloqueado: TIntegerField;
    FdMemPesqGeralFabricacao: TStringField;
    FdMemPesqGeralVencimento: TStringField;
    FdMemPesqGeralDtEntrada: TStringField;
    FdMemPesqGeralHrEntrada: TStringField;
    FDMemCorrecaoLoteloteid: TIntegerField;
    FDMemCorrecaoLotedescrlote: TStringField;
    FDMemCorrecaoLoteFabricacao: TDateField;
    FDMemCorrecaoLoteVencimento: TDateField;
    FDMemCorrecaoLoteQtde: TIntegerField;
    Label3: TLabel;
    EdtLoteOriginal: TEdit;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralQtdeProducao: TIntegerField;
    FDMemCorrecaoLoteAcao: TIntegerField;
    ImgLixeiraOnOff: TImageList;
    FdMemPesqGeralEstoqueTipoId: TIntegerField;
    Label4: TLabel;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    FdMemPesqGeralMascara: TStringField;
    FdMemPesqGeralEstruturaId: TIntegerField;
    ChkCorrecaoLoteAgrupado: TCheckBox;
    FdMemPesqGeralZonaId: TIntegerField;
    FdMemPesqGeralBloqueioInventario: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodProdutoEnter(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure DbgLotesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DbgLotesDblClick(Sender: TObject);
    procedure BtnCancelarLoteClick(Sender: TObject);
    procedure BtnSalvarLoteClick(Sender: TObject);
    procedure EdtQtdeLoteExit(Sender: TObject);
    procedure EdtQtdeLoteKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDtFabricacaoLoteExit(Sender: TObject);
    procedure EdtLoteOriginalExit(Sender: TObject);
    procedure EdtDescricaoLoteExit(Sender: TObject);
    procedure DbgEditLotesCellClick(Column: TColumn);
    procedure EdtDescricaoLoteChange(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
    procedure ChkCorrecaoLoteAgrupadoClick(Sender: TObject);
    procedure EdtDtVencimentoLoteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    Procedure GetProdutoLotes;
    Procedure LimparCorreçãoLotes;
  Protected
    Procedure Limpar; OverRide;
    Procedure ShowDados; override;
  public
    { Public declarations }
  end;

var
  FrmCorrecaoLotes: TFrmCorrecaoLotes;

implementation

{$R *.dfm}

uses uFuncoes, ProdutoCtrl, LoteCtrl, uFrmeXactWMS, Views.Pequisa.Produtos;

procedure TFrmCorrecaoLotes.BtnCancelarLoteClick(Sender: TObject);
begin
  inherited;
  LimparCorreçãoLotes;
end;

procedure TFrmCorrecaoLotes.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then  Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtProdutoId);
       EdtCodProduto.SetFOcus;
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmCorrecaoLotes.BtnSalvarLoteClick(Sender: TObject);
Var JsonObjectLoteAltecao : TJsonObject;
    JsonArrayLotes        : TJsonArray;
    vQtdLoteCorrecao      : Integer;
    ObjProdutoLoteCtrl    : TLoteCtrl;
    JsonArrayRetorno      : TJsonArray;
    vErro : String;
begin
  inherited;
  FDMemCorrecaoLote.First;
  vQtdLoteCorrecao := 0;
  if EdtQtdeLote.Visible then Begin
     while (Not FDMemCorrecaoLote.Eof) do Begin
      vQtdLoteCorrecao := vQtdLoteCorrecao + FDMemCorrecaoLote.FieldByName('Qtde').AsInteger;
      FDMemCorrecaoLote.Next;
     End;
     if vQtdLoteCorrecao <> FdMemPesqGeral.FieldByName('QtdeProducao').AsInteger then
        raise Exception.Create('Quantidade Divergente do estoque do lote em correção.');
  End;
  JsonObjectLoteAltecao := TJsonObject.Create;
  JsonArrayLotes        := TJsonArray.Create;
  JsonObjectLoteAltecao.AddPair('produtoid', TJsonNumber.Create(FdMemPesqGeral.FieldByName('ProdutoId').AsInteger));
  JsonObjectLoteAltecao.AddPair('loteid', TJsonNumber.Create(FdMemPesqGeral.FieldByName('LoteId').AsInteger));
  JsonObjectLoteAltecao.AddPair('lote', FdMemPesqGeral.FieldByName('DescrLote').AsString);
  JsonObjectLoteAltecao.AddPair('enderecoid', TJsonNumber.Create(FdMemPesqGeral.FieldByName('EnderecoId').AsInteger));
  JsonObjectLoteAltecao.AddPair('estoquetipoid', TJsonNumber.Create(FdMemPesqGeral.FieldByName('EstoqueTipoId').AsInteger));
  JsonObjectLoteAltecao.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  FDMemCorrecaoLote.First;
  While Not FDMemCorrecaoLote.Eof do Begin
    JsonArrayLotes.AddElement(TJsonObject.Create.AddPair('lote', FDMemCorrecaoLote.FieldByName('DescrLote').AsString)
                                                .AddPair('fabricacao', FDMemCorrecaoLote.FieldByName('Fabricacao').AsString)
                                                .AddPair('vencimento', FDMemCorrecaoLote.FieldByName('Vencimento').AsString)
                                                .AddPair('qtde', TJsonNumber.Create(FDMemCorrecaoLote.FieldByName('Qtde').AsInteger)) );

    FDMemCorrecaoLote.Next;
  End;
  JsonObjectLoteAltecao.AddPair('correcao', JsonArrayLotes);
  ObjProdutoLoteCtrl := TLoteCtrl.Create;
  JsonArrayRetorno := ObjProdutoLoteCtrl.Correcaolote(JsonObjectLoteAltecao);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  else Begin
     ShowOk('Correção efetivada com sucesso!');
     LimparCorreçãoLotes;
     EdtCodProduto.Clear;
  End;
  JsonArrayLotes   := Nil;
  JsonArrayRetorno := Nil;
  JsonObjectLoteAltecao.Free;
  ObjProdutoLoteCtrl.Free;
end;

procedure TFrmCorrecaoLotes.ChkCorrecaoLoteAgrupadoClick(Sender: TObject);
begin
  inherited;
  GetProdutoLotes
end;

procedure TFrmCorrecaoLotes.DbgEditLotesCellClick(Column: TColumn);
begin
  inherited;
  if (FDMemCorrecaoLote.Active) and (Not FDMemCorrecaoLote.IsEmpty) then Begin
     if Column.FieldName = 'Acao' then Begin
        FDMemCorrecaoLote.Delete;
     End;
  End;
end;

procedure TFrmCorrecaoLotes.DbgLotesDblClick(Sender: TObject);
begin
  inherited;
  if FdMemPesqGeral.IsEmpty then Exit;
  If Not FDMemCorrecaoLote.Active then
     FDMemCorrecaoLote.Open;
  if FdMemPesqGeral.FieldByName('bloqueioinventario').AsInteger = 1 then Begin
     ShowErro('Endereço('+FdMemPesqGeral.FieldByName('Endereco').AsString+') bloqueado para inventariar.');
     Exit;
  End;
  EdtLoteOriginal.Text     := FdMemPesqGeral.FieldByName('DescrLote').AsString;
  EdtDescricaoLote.Text    := FdMemPesqGeral.FieldByName('DescrLote').AsString;
  EdtDtFabricacaoLote.Text := FdMemPesqGeral.FieldByName('Fabricacao').AsString;
  EdtDtVencimentoLote.Text := FdMemPesqGeral.FieldByName('Vencimento').AsString;
  if (Not ChkCorrecaoLoteAgrupado.Checked) and (FdMemPesqGeral.FieldByName('EstruturaId').AsInteger In [1, 3, 4, 5]) then
     EdtQtdeLote.Text := FdMemPesqGeral.FieldByName('QtdeProducao').AsString;
  BtnSalvarLote.Visible   := True;
  BtnCancelarLote.Visible := True;
  DbgLotes.Enabled        := False;
  EdtDescricaoLote.ReadOnly    := False;
  EdtDtFabricacaoLote.ReadOnly := False;
  EdtDtVencimentoLote.ReadOnly := False;
  EdtQtdeLote.ReadOnly         := False;
end;

procedure TFrmCorrecaoLotes.DbgLotesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    if (Column.FieldName = 'Vencimento') and (((Sender=DbgLotes) and (FdMemPesqGeral.FieldByName('Vencimento').AsDateTime>Date())) or
                                              ((Sender=DbgEditLotes) and (FDMemCorrecaoLote.FieldByName('Vencimento').AsDateTime<Date())) ) then
       Canvas.Brush.Color := $008080FF; // Pedido não finalizado
    if (FdMemPesqGeral.FieldByName('bloqueioinventario').AsInteger = 1) and (TDbGrid(Sender).Name='DbgLotes')then
       Canvas.Brush.Color := clRed
    Else If (FdMemPesqGeral.RecNo Mod 2 = 0) then   //Query dos itens
       Canvas.Brush.Color := $00F5EFE7 // Pedido não finalizado
    Else  Canvas.Brush.Color := clWhite;//$00FFE8E8; //Pedido Finalizado
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
  if Sender = DbgEditLotes then Begin
     if (Column.FieldName = 'Acao') then
        ExibirCheckBox(Column, TDbGrid(Sender), ImgLixeiraOnOff, Rect);
  End;
end;

procedure TFrmCorrecaoLotes.EdtLoteOriginalExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmCorrecaoLotes.edtCodProdutoChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmCorrecaoLotes.edtCodProdutoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmCorrecaoLotes.edtCodProdutoExit(Sender: TObject);
Var ObjProdutoCtrl   : TProdutoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
   if (Sender = EdtCodProduto) and (EdtCodProduto.Text<>'') then Begin
     if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then
        raise Exception.Create('CódigoERP inválido para pesquisa!');
     ObjProdutoCtrl   := TProdutoCtrl.Create;
     JsonArrayRetorno := ObjProdutoCtrl.FindProduto('0', EdtCodProduto.Text, '', 0, 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro(vErro);
        EdtCodProduto.Text := '';
     End
     Else If JsonArrayRetorno.Items[0].GetValue<integer>('bloqueioInventario') = 1 then Begin
        ShowErro('Produto bloqueado para inventariar!');
        EdtCodProduto.Text := '';
     End
     Else if ObjProdutoCtrl.ObjProduto.IdProduto > 0 then Begin
        //ShowDados;
        CbRastroTipo.Items.Clear;
        CbRastroTipo.Items.Add(JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rastro').GetValue<String>('descricao'));
        CbRastroTipo.ItemIndex := 0;
        EdtDescricao.Text    := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
        EdtDescricaoRed.Text := JsonArrayRetorno.Items[0].GetValue<String>('descricaoRed');
        EdtProdutoId.Text    := JsonArrayRetorno.Items[0].GetValue<String>('idProduto');
        GetProdutoLotes;
     End
     Else begin
        ShowErro('Produto('+EdtCodProduto.Text+') não encontrado!');
        EdtCodProduto.Text := '';
        EdtCodProduto.SetFocus;
     end;
     JsonArrayRetorno := Nil;
     FreeAndNil(ObjProdutoCtrl);
  End;
  ExitFocus(Sender);
end;

procedure TFrmCorrecaoLotes.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmCorrecaoLotes.EdtDescricaoLoteChange(Sender: TObject);
begin
  inherited;
  EdtDtFabricacaoLote.Clear;
  EdtDtVencimentoLote.clear;
end;

procedure TFrmCorrecaoLotes.EdtDescricaoLoteExit(Sender: TObject);
Var ObjLoteCtrl : TLoteCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  if EdtDescricaoLote.Text = '' then Exit;
  if Not ValidarLote(EdtDescricaoLote.Text) then Begin
     EdtDescricaoLote.SetFocus;
     ShowErro('Erro: Lote('+EdtDescricaoLote.Text+') inválido!');
     EdtDescricaoLote.Clear;
     Exit;
  End;
  ObjLoteCtrl      := TLoteCtrl.Create;
  JsonArrayRetorno := ObjLoteCtrl.GetProdutoLoteJson(FdMemPesqGeral.FieldByName('Produtoid').AsInteger,
                                                     EdtDescricaoLote.Text, 0);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then begin
     EdtDtFabricacaoLote.Text := JsonArrayRetorno.Items[0].GetValue<String>('fabricacao');
     EdtDtVencimentoLote.Text := JsonArrayRetorno.Items[0].GetValue<String>('vencimento');
  end
  Else Begin
     EdtDtFabricacaoLote.Clear;
     EdtDtVencimentoLote.Clear;
  End;
  JsonArrayRetorno := Nil;
  ObjLoteCtrl.Free;
end;

procedure TFrmCorrecaoLotes.EdtDtFabricacaoLoteExit(Sender: TObject);
begin
  inherited;
  if (TJvDateEdit(Sender).Text = '') or (TJvDateEdit(Sender).Text = '  /  /    ') then Exit;
  Try
    if Length(TEdit(Sender).Text) = 8 then
       TEdit(Sender).Text := Copy(TEdit(Sender).Text, 1, 6)+'20'+Copy(TEdit(Sender).Text, 7, 2);
    StrToDate(TEdit(Sender).Text);
    if (StrToDate(TEdit(Sender).Text) < StrToDate('01/01/1990')) or
       (StrToDate(TEdit(Sender).Text) > StrToDate('19/08/2130')) then
       raise Exception.Create('Dt.Fabricação inválida!');
  Except Begin
    EdtDtFabricacaoLote.SetFocus;
    if Sender = EdtDtFabricacaoLote then
       ShowErro('Data de fabricação do lote inválida')
    Else
       ShowErro('Data de Vencimento do lote inválida');
    TEdit(Sender).SetFocus;
    End;
  End;
  if (Sender=EdtDtFabricacaoLote) and (EdtDtFabricacaoLote.Date > Date()) then
     raise Exception.Create('Data de fabricação inválida, não pode ser data futura!');
  if (Sender=EdtDtVencimentoLote) and (EdtDtFabricacaoLote.Date >= EdtDtVencimentoLote.Date) then
     raise Exception.Create('Data de vencimento inválida, menor que fabricação!');
  ExitFocus(Sender);
end;

procedure TFrmCorrecaoLotes.EdtDtVencimentoLoteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (Not EdtQtdeLote.Visible) then Begin
     if (EdtDtFabricacaoLote.Text = '  /  /    ') or (EdtDtVencimentoLote.Text = '  /  /    ') or
        (EdtDescricaoLote.Text='') then
        raise Exception.Create('Corrija as data de Fabricação/Vencimento.');
     FDMemCorrecaoLote.First;
     FDMemCorrecaoLote.Append;
     FDMemCorrecaoLote.FieldByName('LoteId').AsInteger      := 0;
     FDMemCorrecaoLote.FieldByName('DescrLote').AsString    := EdtDescricaoLote.Text;
     FDMemCorrecaoLote.FieldByName('Fabricacao').AsDateTime := StrToDate(EdtDtFabricacaoLote.Text);
     FdMemCorrecaoLote.FieldByName('Vencimento').AsDateTime := StrToDate(EdtDtVencimentoLote.Text);
     FdMemCorrecaoLote.FieldByName('Qtde').AsInteger        := StrToIntDef(EdtQtdeLote.Text, 0);
     FDMemCorrecaoLote.Post;
     BtnSalvarLote.Color      := ClGreen;
     BtnSalvarLote.Enabled    := True;
     EdtDescricaoLote.Text    := '';
     EdtDtFabricacaoLote.Text := '';
     EdtDtVencimentoLote.Text := '';
     EdtQtdeLote.Text         := '';
  End;
end;

procedure TFrmCorrecaoLotes.EdtQtdeLoteExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmCorrecaoLotes.EdtQtdeLoteKeyPress(Sender: TObject; var Key: Char);
Var vQtdLoteCorrecao : Integer;
begin
  inherited;
  if (Key = #13) and (EdtQtdeLote.Value>0) then Begin
     if (EdtDtFabricacaoLote.Text = '  /  /    ') or (EdtDtVencimentoLote.Text = '  /  /    ') then
        raise Exception.Create('Corrija as data de Fabricação/Vencimento.');
     if (FdMemPesqGeral.FieldByName('EstruturaId').AsInteger in [1, 3, 4, 5]) and
        (FdMemPesqGeral.FieldByName('ZonaId').AsInteger <> 1) and
        (FdMemPesqGeral.FieldByName('QtdeProducao').AsInteger<>StrToIntDef(EdtQtdeLote.Text, 0)) then
        raise Exception.Create('Correção de Lote em Pallet a quantidade alterada deve ser igual a quantidade original.');
     FDMemCorrecaoLote.First;
     vQtdLoteCorrecao := 0;
     while (Not FDMemCorrecaoLote.Eof) do Begin
      vQtdLoteCorrecao := vQtdLoteCorrecao + FDMemCorrecaoLote.FieldByName('Qtde').AsInteger;
      FDMemCorrecaoLote.Next;
     End;
     if vQtdLoteCorrecao+StrToIntDef(EdtQtdeLote.Text, 0) > FdMemPesqGeral.FieldByName('QtdeProducao').AsInteger then
        raise Exception.Create('Quantidade maior que estoque do lote em correção.');
     FDMemCorrecaoLote.Append;
     FDMemCorrecaoLote.FieldByName('LoteId').AsInteger      := 0;
     FDMemCorrecaoLote.FieldByName('DescrLote').AsString    := EdtDescricaoLote.Text;
     FDMemCorrecaoLote.FieldByName('Fabricacao').AsDateTime := StrToDate(EdtDtFabricacaoLote.Text);
     FdMemCorrecaoLote.FieldByName('Vencimento').AsDateTime := StrToDate(EdtDtVencimentoLote.Text);
     FdMemCorrecaoLote.FieldByName('Qtde').AsInteger        := StrToIntDef(EdtQtdeLote.Text, 0);
     FDMemCorrecaoLote.Post;
     if vQtdLoteCorrecao+StrToIntDef(EdtQtdeLote.Text, 0) = FdMemPesqGeral.FieldByName('QtdeProducao').AsInteger then Begin
        BtnSalvarLote.Color   := ClGreen;
        BtnSalvarLote.Enabled := True;
     End;
     EdtDescricaoLote.Text    := '';
     EdtDtFabricacaoLote.Text := '';
     EdtDtVencimentoLote.Text := '';
     EdtQtdeLote.Text         := '';
  End;
end;

procedure TFrmCorrecaoLotes.FdMemPesqGeralCalcFields(DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByName('EnderecoFormatado').AsString := EnderecoMask(FdMemPesqGeral.FieldByName('Endereco').AsString,
                                                                           FdMemPesqGeral.FieldByName('Mascara').AsString, True);
end;

procedure TFrmCorrecaoLotes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmCorrecaoLotes := Nil;
end;

procedure TFrmCorrecaoLotes.FormCreate(Sender: TObject);
begin
  inherited;
  DbgLotes.Columns[0].width     := 120;
  DbgEditLotes.Columns[0].width := 120;
  PgcBase.ActivePage := TabPrincipal;
end;

procedure TFrmCorrecaoLotes.GetProdutoLotes;
Var ObjProdutoLote       : TLoteCtrl;
    JsonArrayRetornoLotes : TJsonArray;
    vErro : String;
begin
  ObjProdutoLote := TLoteCtrl.Create;
  if Not ChkCorrecaoLoteAgrupado.Checked then
     JsonArrayRetornoLotes := ObjProdutoLote.GetLoteResumo(StrToInt64Def(EdtProdutoId.Text, 0), '*', 0)
  Else JsonArrayRetornoLotes := ObjProdutoLote.GetLoteResumo(StrToInt64Def(EdtProdutoId.Text, 0), '*', 1);
  if JsonArrayRetornoLotes.Items[0].TryGetValue('Erro', vErro) then Begin
     JsonArrayRetornoLotes := Nil;
     ObjProdutoLote.Free;
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetornoLotes, False);
  DbgLotes.Columns[1].Visible := Not ChkCorrecaoLoteAgrupado.Checked;
  DbgLotes.Columns[5].Visible := Not ChkCorrecaoLoteAgrupado.Checked;
  DbgLotes.Columns[6].Visible := Not ChkCorrecaoLoteAgrupado.Checked;
  LblQtdeLote.Visible := Not ChkCorrecaoLoteAgrupado.Checked;
  EdtQtdeLote.Visible := Not ChkCorrecaoLoteAgrupado.Checked;
  JsonArrayRetornoLotes := Nil;
  ObjProdutoLote.Free;
end;

procedure TFrmCorrecaoLotes.Limpar;
begin
  inherited;
  CbRastroTipo.ItemIndex := -1;
  EdtDescricao.Clear;
  EdtDescricaoRed.Clear;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  If FDMemCorrecaoLote.Active then
     FDMemCorrecaoLote.EmptyDataSet;
  FDMemCorrecaoLote.Close;
  LimparCorreçãoLotes;
end;

procedure TFrmCorrecaoLotes.LimparCorreçãoLotes;
begin
  EdtLoteOriginal.Text     := '';
  EdtDescricaoLote.Text    := '';
  EdtDtFabricacaoLote.Text := '';
  EdtDtVencimentoLote.Text := '';
  EdtQtdeLote.Text         := '';
  EdtDescricaoLote.ReadOnly := True;
  EdtDtFabricacaoLote.ReadOnly := True;
  EdtDtVencimentoLote.ReadOnly := True;
  EdtQtdeLote.ReadOnly         := True;
  BtnSalvarLote.Visible    := False;
  BtnCancelarLote.Visible  := False;
  DbgLotes.Enabled         := True;
  If FDMemCorrecaoLote.Active then
     FDMemCorrecaoLote.EmptyDataSet;
  FDMemCorrecaoLote.Close;
  BtnSalvarLote.Color   := ClGray;
  BtnSalvarLote.Enabled := False;
end;

procedure TFrmCorrecaoLotes.ShowDados;
begin
  inherited;

end;

end.
