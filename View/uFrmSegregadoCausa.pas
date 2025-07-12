unit uFrmSegregadoCausa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, DataSet.Serialize,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, System.Json, Rest.Json, Generics.Collections,
  uFuncoes, SegregadoCausaCtrl;

type
  TFrmSegregadoCausa = class(TFrmBase)
    EdtSegregadoCausaId: TLabeledEdit;
    EdtDescricao: TLabeledEdit;
    btnPesquisar: TBitBtn;
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure EdtDescricaoExit(Sender: TObject);
    procedure EdtSegregadoCausaIdChange(Sender: TObject);
    procedure EdtSegregadoCausaIdEnter(Sender: TObject);
    procedure EdtSegregadoCausaIdExit(Sender: TObject);
    procedure EdtSegregadoCausaIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LstCadastroClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Function GetListaSegregadoCausa(pSegregadoCausaId : Integer; pDescricao : string) : Boolean;
  Protected
    Procedure ShowDados; override;
    Procedure Limpar; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
  end;

var
  FrmSegregadoCausa: TFrmSegregadoCausa;

implementation

{$R *.dfm}

{ TFrmSegregadoCausa }

procedure TFrmSegregadoCausa.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
end;

procedure TFrmSegregadoCausa.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
end;

function TFrmSegregadoCausa.DeleteReg: Boolean;
Var ObjSegregadoCausaCtrl : TSegregadoCausaCtrl;
begin
  ObjSegregadoCausaCtrl := TSegregadoCausaCtrl.Create;
  Result := ObjSegregadoCausaCtrl.Delete(StrToIntDef(EdtSegregadoCausaId.Text, 0));
  if Result then Begin
     ShowOk('Registro excluído com sucesso!');
     Limpar;
  End
  Else
     ShowErro('Não foi possível Excluir o registro.');
  ObjSegregadoCausaCtrl.Free;
end;

procedure TFrmSegregadoCausa.EdtSegregadoCausaIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtSegregadoCausaId.ReadOnly) then
     Limpar;
end;

procedure TFrmSegregadoCausa.EdtSegregadoCausaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmSegregadoCausa.EdtSegregadoCausaIdExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
    ObjSegregadoCausaCtrl : TSegregadoCausaCtrl;
begin
  inherited;
  if (Not EdtSegregadoCausaId.ReadOnly) and (EdtSegregadoCausaId.Text<>'') then Begin
     Limpar;
     if StrToIntDef(EdtSegregadoCausaId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtSegregadoCausaId.Text+') inválido!');
     ObjSegregadoCausaCtrl := TSegregadoCausaCtrl.Create;
     JsonArrayRetorno := ObjSegregadoCausaCtrl.GetSegregadoCausa(StrToIntDef(EdtSegregadoCausaId.Text, 0), '');
     if JsonArrayRetorno.TryGetValue('Erro', vErro) then
        ShowMessage('Causa do segregado não encontrada.')
     Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
        ShowDados;
     End;
     JsonArrayRetorno := Nil;
     ObjSegregadoCausaCtrl.Free;
  End;
end;

procedure TFrmSegregadoCausa.EdtSegregadoCausaIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmSegregadoCausa.EdtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmSegregadoCausa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmSegregadoCausa := Nil;
end;

procedure TFrmSegregadoCausa.FormCreate(Sender: TObject);
begin
  inherited;
  With LstCadastro do Begin
    ColWidths[0] :=  60;
    ColWidths[1] := 350;
    ColWidths[2] :=  40;
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taCenter;
  End;
end;

procedure TFrmSegregadoCausa.GetListaLstCadastro;
begin
  inherited;
  GetListaSegregadoCausa(0, '');
end;

Function TFrmSegregadoCausa.GetListaSegregadoCausa(pSegregadoCausaId : Integer; pDescricao : string) : Boolean;
Var xLista, xImg : Integer;
    vErro : String;
    JsonArrayRetorno : TJsonArray;
    ObjSegregadoCausaCtrl : TSegregadoCausaCtrl;
begin
  ObjSegregadoCausaCtrl := TSegregadoCausaCtrl.Create;
  JsonArrayRetorno := ObjSegregadoCausaCtrl.GetSegregadoCausa(pSegregadoCausaId, pDescricao);
  if JsonArrayRetorno.items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else Begin
     LstCadastro.RowCount := JsonArrayRetorno.Count+1;
     Result := JsonArrayRetorno.Count >= 1;
     LstCadastro.FixedRows := 1;
     for xImg := 0 to Pred(JsonArrayRetorno.Count) do
       LstCadastro.AddDataImage(2, xImg+1, 0, haCenter, vaTop);
     For xLista := 0 To Pred(JsonArrayRetorno.Count) do begin
       LstCadastro.Cells[0, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('segregadocausaid');
       LstCadastro.Cells[1, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('descricao');
       LstCadastro.Cells[2, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('status');
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[2, xLista+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  JsonArrayRetorno := Nil;
  ObjSegregadoCausaCtrl.Free;
end;

procedure TFrmSegregadoCausa.Limpar;
begin
  inherited;
  if Not EdtSegregadoCausaId.Enabled then
     EdtSegregadoCausaId.Clear;
  EdtDescricao.Clear;
  ChkCadastro.Checked    := False;
  if (FdMemPesqGeral.Active) then
     FdMemPesqGeral.Close;
end;

procedure TFrmSegregadoCausa.LstCadastroClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xCol, xRow : Integer;
    xVal : String;
begin
  inherited;
  LstCadastro.Row := aRow;
  if (aRow = 0) and (aCol in [0, 1]) then Begin
     LstCadastro.SortSettings.Column := aCol;
     LstCadastro.QSort;
  End;
end;

procedure TFrmSegregadoCausa.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtSegregadoCausaId.Text := LstCadastro.Cells[0, aRow];
  EdtSegregadoCausaIdExit(EdtSegregadoCausaId);
end;

function TFrmSegregadoCausa.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaSegregadoCausa(StrToIntDef(EdtConteudoPesq.Text, 0), '')
        else raise Exception.Create('Id inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Descricao
        Result := GetListaSegregadoCausa(0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmSegregadoCausa.SalvarReg: Boolean;
Var vErro   : String;
    vStatus : Integer;
    JsonSegregadoCausa      : TJsonObject;
    JsonArraySegregadoCausa : TJsonArray;
    ObjSegregadoCausaCtrl   : TSegregadoCausaCtrl;
begin
  If ChkCadastro.Checked Then
     vStatus := 1
  Else vStatus := 0;
  JsonSegregadoCausa      := TJsonObject.Create;
  JsonArraySegregadoCausa := TJsonArray.Create;
  JsonSegregadoCausa.AddPair('segregadocausaid', TJsonNumber.Create(StrToIntDef(EdtSegregadoCausaId.Text, 0)));
  JsonSegregadoCausa.AddPair('descricao', EdtDescricao.Text);
  JsonSegregadoCausa.AddPair('status', TJsonNumber.Create(vStatus));
  JsonArraySegregadoCausa.AddElement(JsonSegregadoCausa);
  ObjSegregadoCausaCtrl := TSegregadoCausaCtrl.Create;
  Result := ObjSegregadoCausaCtrl.Salvar(JsonArraySegregadoCausa);
  if Result then
     ShowOk('Registro salvo com sucesso!')
  Else ShowErro('Não foi possível salvar o registro. Tente novamente!');
  JsonArraySegregadoCausa.Free;
  ObjSegregadoCausaCtrl.Free;
end;

procedure TFrmSegregadoCausa.ShowDados;
begin
  inherited;
  EdtSegregadoCausaId.Text := FdMemPesqGeral.FieldByName('segregadoCausaId').AsString;
  EdtDescricao.Text        := FdMemPesqGeral.FieldByName('Descricao').AsString;
  ChkCadastro.Checked      := FdMemPesqGeral.FieldByName('Status').AsInteger = 1;
end;

end.
