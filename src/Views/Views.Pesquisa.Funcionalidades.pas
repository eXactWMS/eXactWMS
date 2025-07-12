unit Views.Pesquisa.Funcionalidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels,
  uFrmeXactWMS, Services.Funcionalidades;

type
  TFrmPesquisaFuncionalidade = class(TFrmBaseCadastro)
    EdtFuncionalidadeId: TEdit;
    EdtFuncionalidade: TEdit;
    lblPesquisaNome: TLabel;
    lblPesquisaCodigo: TLabel;
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
  FrmPesquisaFuncionalidade: TFrmPesquisaFuncionalidade;

implementation

{$R *.dfm}

procedure TFrmPesquisaFuncionalidade.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('FuncionalidadeId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaFuncionalidade.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('funcionalidadeid', EdtFuncionalidadeId.Text)
    .AddParam('nome', EdtFuncionalidade.Text);
end;

procedure TFrmPesquisaFuncionalidade.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceFuncionalidade.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/funcionalidade4D');
end;

end.
