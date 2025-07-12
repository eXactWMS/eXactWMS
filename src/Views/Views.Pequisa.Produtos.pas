unit Views.Pequisa.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaProduto = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    EdtProdutoId: TEdit;
    EdtDescricao: TEdit;
    lblPesquisaNome: TLabel;
    Label1: TLabel;
    EdtCodigoERP: TEdit;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoBeforeList; override;
  public
    { Public declarations }
  end;

var
  FrmPesquisaProduto: TFrmPesquisaProduto;

implementation

{$R *.dfm}

uses Services.Produtos, uFrmeXactWMS;

procedure TFrmPesquisaProduto.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('CodProduto').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaProduto.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('produtoid', EdtProdutoId.Text)
    .AddParam('codproduto', EdtCodigoERP.Text)
    .AddParam('descricao', EdtDescricao.Text);
end;

procedure TFrmPesquisaProduto.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceProdutos.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/produto4D');
end;

end.
