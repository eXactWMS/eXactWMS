unit Views.Pequisa.EnderecamentoEstruturas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaEnderecamentoEstruturas = class(TFrmBaseCadastro)
    Label1: TLabel;
    EdtEstruturaId: TEdit;
    EdtDescricao: TEdit;
    lblPesquisaNome: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoBeforeList; override;
  public
    { Public declarations }
  end;

var
  FrmPesquisaEnderecamentoEstruturas: TFrmPesquisaEnderecamentoEstruturas;

implementation

{$R *.dfm}

uses Services.EnderecamentoEstruturas, uFrmeXactWMS;

procedure TFrmPesquisaEnderecamentoEstruturas.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('EstruturaId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaEnderecamentoEstruturas.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('estruturaid', EdtEstruturaId.Text)
    .AddParam('descricao',     EdtDescricao.Text);
end;

procedure TFrmPesquisaEnderecamentoEstruturas.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceEnderecamentoEstruturas.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/enderecoestrutura4D');
end;

end.
