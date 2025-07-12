unit Views.Pequisa.Laboratorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaLaboratorio = class(TFrmBaseCadastro)
    edtPesquisaCodigo: TEdit;
    edtPesquisaNome: TEdit;
    lblPesquisaCodigo: TLabel;
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
  FrmPesquisaLaboratorio: TFrmPesquisaLaboratorio;

implementation

{$R *.dfm}

uses Services.Laboratorios, uFrmeXactWMS;

procedure TFrmPesquisaLaboratorio.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('IdLaboratorio').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaLaboratorio.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', edtPesquisaCodigo.Text)
    .AddParam('nome', edtPesquisaNome.Text);
end;

procedure TFrmPesquisaLaboratorio.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceLaboratorios.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/laboratorio4D');
end;

end.
