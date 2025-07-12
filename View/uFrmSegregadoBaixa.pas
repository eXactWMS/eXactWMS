unit uFrmSegregadoBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, Generics.Collections,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, uFuncoes,
  System.Json, Rest.Types, JvToolEdit, EnderecoCtrl, JvBaseEdits;

type
  TFrmSegregadoBaixa = class(TFrmBase)
    EdtBaixaId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    Label3: TLabel;
    EdtDocumentoData: TJvDateEdit;
    EdtCodPessoa: TLabeledEdit;
    BtnPesqPessoa: TBitBtn;
    LblPessoa: TLabel;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    Endereço: TLabel;
    EdtEndereco: TEdit;
    BtnPesqEndereco: TBitBtn;
    Label2: TLabel;
    EdtLote: TEdit;
    BtnPesqLote: TBitBtn;
    LblLote: TLabel;
    JvQtdeBaixa: TJvCalcEdit;
    Label5: TLabel;
    BtnSalvarBaixa: TPanel;
    ShpBtnSalvarBaixa: TShape;
    SpbBtnSalvarBaixa: TSpeedButton;
    PnlBtnSalvarBaixa: TPanel;
    ImgBtnSalvarBaixa: TImage;
    EdtNotaFiscal: TLabeledEdit;
    Label6: TLabel;
    CbDescarte: TComboBox;
    Label4: TLabel;
    FDMemSegregadoCausa: TFDMemTable;
    CbMotivo: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnPesqPessoaClick(Sender: TObject);
    procedure EdtCodPessoaExit(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure EdtCodProdutoChange(Sender: TObject);
    procedure BtnPesqEnderecoClick(Sender: TObject);
    procedure EdtLoteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CbMotivoClick(Sender: TObject);
    procedure EdtCodPessoaChange(Sender: TObject);
  private
    { Private declarations }
    Procedure LimparLancamento;
    Procedure GetSegregadoCausa;
    Procedure GetEstoqueSegregado(pCodProduto, pCausaId : Integer);
  public
    { Public declarations }
  end;

var
  FrmSegregadoBaixa: TFrmSegregadoBaixa;

implementation

{$R *.dfm}

Uses Views.Pequisa.Pessoas, Views.Pequisa.Endereco, Views.Pequisa.Produtos, PessoaCtrl, ProdutoCtrl,
  SegregadoCausaCtrl, EstoqueCtrl;

procedure TFrmSegregadoBaixa.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtDocumentoData.Text := DateToStr(Now());
  EdtCodPessoa.SetFocus;
  CbDescarte.ItemIndex := -1;
end;

procedure TFrmSegregadoBaixa.BtnPesqEnderecoClick(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then Begin
       If FrmPesquisaEndereco.Tag <> 0 then Begin
          ObjEnderecoCtrl := TEnderecoCtrl.Create;
          JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(FrmPesquisaEndereco.Tag, 0, 3, 0, '', '', 'T', 3, 0);
          if (JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro)) then
             ShowErro('Erro: '+vErro)
          Else Begin
             EdtEndereco.Text := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
             EdtLote.SetFocus;
          End;
       End;
       EdtEnderecoExit(EdtEndereco);
    End;
  finally
    JsonArrayRetorno := Nil;
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmSegregadoBaixa.BtnPesqPessoaClick(Sender: TObject);
begin
  inherited;
  if EdtCodPessoa.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtCodPessoa.Text := FrmPesquisaPessoas.Tag.ToString();
       EdtCodPessoaExit(EdtCodPessoa);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;

end;

procedure TFrmSegregadoBaixa.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if EdtCodProduto.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmSegregadoBaixa.CbMotivoClick(Sender: TObject);
begin
  inherited;
  FDMemSegregadoCausa.Locate('Descricao', CbMotivo.Items.Strings[CbMotivo.ItemIndex], []);
end;

procedure TFrmSegregadoBaixa.EdtCodProdutoChange(Sender: TObject);
begin
  inherited;
  LblProduto.Caption := '';
end;

procedure TFrmSegregadoBaixa.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     Exit;
  End;
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  GetEstoqueSegregado(JsonProduto.GetValue<Integer>('codproduto'), 0);
  ExitFocus(Sender);
end;

procedure TFrmSegregadoBaixa.EdtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmSegregadoBaixa.EdtEnderecoExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    RetornoJsonArray : TJsonArray;
    vErro : String;
begin
  inherited;
  if (Not EdtEndereco.ReadOnly) then Begin
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     RetornoJsonArray := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 3, 0, EdtEndereco.Text, EdtEndereco.Text, 'T', 3, 0);
     if (RetornoJsonArray.Items[0].TryGetValue('Erro', vErro)) or (RetornoJsonArray.Count < 1) then Begin
        EdtEndereco.Text := '';
        RetornoJsonArray := Nil;
        ObjEnderecoCtrl.Free;
        raise Exception.Create('Endereço ('+EdtEndereco.Text+') não encontrado!');
     End;
     RetornoJsonArray := Nil;
     ObjEnderecoCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmSegregadoBaixa.EdtLoteChange(Sender: TObject);
begin
  inherited;
  LblLote.Caption := '';
end;

procedure TFrmSegregadoBaixa.EdtCodPessoaChange(Sender: TObject);
begin
  inherited;
  LblPessoa.Caption := '';
end;

procedure TFrmSegregadoBaixa.EdtCodPessoaExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtCodPessoa.Text = '' then Begin
     LblPessoa.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodPessoa.Text, 0) <= 0 then Begin
     LblPessoa.Caption := '';
     ShowErro( '😢Código de Fornecedor('+EdtCodPessoa.Text+') inválido!' );
     EdtCodPessoa.Clear;
     EdtCodPessoa.SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtCodPessoa.text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblPessoa.Caption := '';
     ShowErro( '😢Erro: ' );
     EdtCodPessoa.Clear;
  end
  Else
     LblPessoa.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnJsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmSegregadoBaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmSegregadoBaixa := Nil;
end;

procedure TFrmSegregadoBaixa.FormCreate(Sender: TObject);
begin
  inherited;
  GetSegregadoCausa; //Segregado e Devolução
end;

procedure TFrmSegregadoBaixa.GetEstoqueSegregado(pCodProduto, pCausaId: Integer);
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  ObjEstoqueCtrl   := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueZona(pCodProduto, 3, 0);
end;

procedure TFrmSegregadoBaixa.GetSegregadoCausa;
Var JsonArrayRetorno : TJsonArray;
    ObjSegregaCausaCtrl : TSegregadoCausaCtrl;
    vErro : String;
begin
  If FdMemSegregadoCausa.Active then
     FdMemSegregadoCausa.EmptyDataSet;
  FdMemSegregadoCausa.Close;
  ObjSegregaCausaCtrl := TSegregadoCausaCtrl.Create;
  JsonArrayRetorno := ObjSegregaCausaCtrl.GetSegregadoCausa(0, '', 1);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowMSG(vErro)
  Else Begin
     FDMemSegregadoCausa.LoadFromJSON(JsonArrayRetorno, False);
     cbMotivo.Items.Clear;
     FDMemSegregadoCausa.First;
     while Not FDMemSegregadoCausa.Eof do Begin
       CbMotivo.Items.Add(FDMemSegregadoCausa.FieldByName('Descricao').AsString);
       FDMemSegregadoCausa.Next;
     End;
  End;
  JsonArrayRetorno := Nil;
  FreeAndNil(ObjSegregaCausaCtrl);
end;

procedure TFrmSegregadoBaixa.LimparLancamento;
begin
  LblProduto.Caption  := '';
  EdtEndereco.Text    := '';
  CbMotivo.ItemIndex  := -1;
  EdtLote.Text        := '';
  LblLote.Caption     := '';
  JvQtdeBaixa.Value   := 0;
end;

end.
