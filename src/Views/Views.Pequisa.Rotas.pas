unit Views.Pequisa.Rotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaRotas = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    EdtRotaId: TEdit;
    EdtIdentificacao: TEdit;
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
  FrmPesquisaRotas: TFrmPesquisaRotas;

implementation

{$R *.dfm}

uses uFrmeXactWMS, Services.Rotas;

procedure TFrmPesquisaRotas.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('rotaid').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaRotas.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', EdtRotaId.Text)
    .AddParam('descricao', EdtIdentificacao.Text);
end;

procedure TFrmPesquisaRotas.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceRotas.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/rotas4D');
end;

end.
