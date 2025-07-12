unit Views.Pequisa.Unidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels, Services.Unidades;

type
  TFrmPesquisaUnidades = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    EdtUnidadeId: TEdit;
    lblPesquisaNome: TLabel;
    EdtDescricao: TEdit;
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
  FrmPesquisaUnidades: TFrmPesquisaUnidades;

implementation

{$R *.dfm}

uses uFrmeXactWMS;

{ TFrmBaseCadastro1 }

procedure TFrmPesquisaUnidades.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('Id').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaUnidades.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('unidadeid', EdtUnidadeId.Text)
    .AddParam('descricao', EdtDescricao.Text);
end;

procedure TFrmPesquisaUnidades.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceUnidades.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/unidade4D');
  btnPesquisarClick(btnPesquisar);
end;

end.
