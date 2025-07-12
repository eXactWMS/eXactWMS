unit uFrmDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, Rest.Types, System.Json,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, DataSet.Serialize,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtDlgs, System.ImageList, Generics.Collections,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit
  , DevolucaoCtrl, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmDevolucao = class(TFrmBase)
    Panel1: TPanel;
    EdtEntradaId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EdtDocumentoNr: TLabeledEdit;
    EdtDocumentoData: TJvDateEdit;
    EdtRegistroERP: TLabeledEdit;
    CbOperacaoTipo: TComboBox;
    Label2: TLabel;
    EdtPessoaId: TLabeledEdit;
    BtnPesqFornecedor: TBitBtn;
    LblFornecedor: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BtnPesqFornecedorClick(Sender: TObject);
    procedure EdtPessoaIdExit(Sender: TObject);
    procedure EdtPessoaIdChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function GetListaDevolucao(pDevolucaoId : Integer = 0; pCodigoERP : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = '';
                            pRazao : String = ''; pShowErro : Integer = 0) : Boolean;
    Procedure MontaLstCadastro;
  public
    { Public declarations }
  end;

var
  FrmDevolucao: TFrmDevolucao;

implementation

{$R *.dfm}

Uses Views.Pequisa.Pessoas, uFuncoes, PessoaCtrl;

procedure TFrmDevolucao.BtnPesqFornecedorClick(Sender: TObject);
Var ReturnJsonArray : TjsonArray;
    ObjPessoaCtrl   : TPessoaCtrl;
    vErro           : String;
begin
  inherited;
  if EdtPessoaId.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       ObjPessoaCtrl := TPessoaCtrl.Create();
       ReturnjsonArray := ObjPessoaCtrl.FindPessoa(FrmPesquisaPessoas.Tag, 0, '', '', 2, 0);
       if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Items[0].tryGetValue<String>('Erro', vErro)) then Begin
          LblFornecedor.Caption := '';
          ObjPessoaCtrl   := Nil;
          ReturnjsonArray := Nil;
          ShowErro( '😢Fornecedor('+EdtPessoaId.Text+') não encontrado!' );
          EdtPessoaId.Clear;
       end
       Else begin
          EdtPessoaid.Text := ReturnJsonArray.Items[0].GetValue<Integer>('codpessoaerp').ToString;
          EdtPessoaIdExit(EdtPessoaId);
       end;
       ObjPessoaCtrl.DisposeOf;
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmDevolucao.EdtPessoaIdChange(Sender: TObject);
begin
  inherited;
  LblFornecedor.Caption := '...';
end;

procedure TFrmDevolucao.EdtPessoaIdExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtPessoaId.Text = '' then Begin
     LblFornecedor.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtPessoaId.Text, 0) <= 0 then Begin
     LblFornecedor.Caption := '';
     ShowErro( 'Id do 😢Fornecedor('+EdtPessoaId.Text+')inválido!' );
     EdtPessoaId.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtPessoaId.text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Items[0].tryGetValue<String>('Erro', vErro)) then Begin
     LblFornecedor.Caption := '';
     ObjPessoaCtrl   := Nil;
     ReturnjsonArray := Nil;
     ShowErro( '😢Fornecedor('+EdtPessoaId.Text+') não encontrado!' );
     EdtPessoaId.Clear;
  end
  Else
     LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ObjPessoaCtrl   := Nil;
  ReturnjsonArray := Nil;
  ExitFocus(Sender);
end;

procedure TFrmDevolucao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmDevolucao := Nil;
end;

procedure TFrmDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  CbOperacaoTipo.ItemIndex := 4;
  LstCadastro.ColWidths[0] := 60;
  LstCadastro.ColWidths[1] := 230;
  LstCadastro.ColWidths[2] := 80;
  LstCadastro.ColWidths[3] := 80;
  LstCadastro.ColWidths[4] := 50;
  LstCadastro.ColWidths[5] := 80;
  LstCadastro.Alignments[5 ,0] := taRightJustify;
  GetListaDevolucao(0, 0, 0, '', '', 0);
end;

function TFrmDevolucao.GetListaDevolucao(pDevolucaoId, pCodigoERP,
  pPessoaId: Integer; pDocumentoNr, pRazao: String; pShowErro: Integer): Boolean;
Var ObjDevolucaoCtrl : TDevolucaoCtrl;
    JsonDevolucao : TJsonArray;
    vErro         : String;
begin
  Result := False;
  ObjDevolucaoCtrl := TDevolucaoCtrl.Create;
  JsonDevolucao := ObjDevolucaoCtrl.GetDevolucao(pDevolucaoId, pCodigoERP, pPessoaId, pDocumentoNr, 0);
  if JsonDevolucao.Items[0].tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
  End
  Else Begin
     FdMemPesqGeral.LoadFromJSON(JsonDevolucao, False);
     MontaLstCadastro;
     Result := True;
  end;
  JsonDevolucao := Nil;
  FreeAndNil(ObjDevolucaoCtrl);
end;

procedure TFrmDevolucao.MontaLstCadastro;
Var xDev : Integer;
begin
  LstCadastro.RowCount := FdMemPesqGeral.RecordCount+1;
  if LstCadastro.RowCount > 1 then
     LstCadastro.FixedRows := 1;
  FdMemPesqGeral.First;
  xDev := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstCadastro.Cells[0, xDev] := FdMemPesqGeral.FieldByName('pedidoid').AsString;
{    LstCadastro.Cells[1, xRetorno+1] := jsonPedido.GetValue<String>('documentodatar');
    jsonOperacao := jsonPedido.GetValue<tJsonObject>('operacaotipo');
    LstCadastro.Cells[2, xRetorno+1] := jsonOperacao.GetValue<String>('descricao');
    jsonPessoa   := jsonPedido.GetValue<tJsonObject>('pessoa');
    LstCadastro.Cells[3, xRetorno+1] := jsonPessoa.GetValue<String>('pessoaid');
    LstCadastro.Cells[4, xRetorno+1] := jsonPessoa.GetValue<String>('razao');
    LstCadastro.Cells[5, xRetorno+1] := jsonPedido.GetValue<String>('documentonr');
    LstCadastro.Cells[6, xRetorno+1] := jsonPedido.GetValue<String>('processoetapa');
    LstCadastro.Cells[7, xRetorno+1] := jsonPedido.GetValue<Integer>('qtdproduto').ToString();
    LstCadastro.Cells[8, xRetorno+1] := jsonPedido.GetValue<Integer>('volume').ToString();
    LstCadastro.Cells[9, xRetorno+1] := jsonPedido.GetValue<Integer>('peso').ToString();;
    LstCadastro.Cells[10, xRetorno+1] := jsonPedido.GetValue<String>('registroerp');
    LstCadastro.Alignments[0, xDev] := taRightJustify;
    LstCadastro.FontStyles[0, xDev] := [FsBold];
}//    LstCadastro.Alignments[3, xDev] := taRightJustify;
//    LstCadastro.Alignments[7, xDev] := taRightJustify;
//    LstCadastro.Alignments[8, xDev] := taRightJustify;
//    LstCadastro.Alignments[9, xDev] := taRightJustify;
    Inc(xDev);
    FdMemPesqGeral.Next;
  End;

end;

end.
