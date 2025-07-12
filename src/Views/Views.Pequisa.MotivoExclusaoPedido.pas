unit Views.Pequisa.MotivoExclusaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.WinXPanels;

type
  TFrmPesquisaMotivoExclusaoPedido = class(TFrmBaseCadastro)
    edtPesquisaCodigo: TEdit;
    lblPesquisaCodigo: TLabel;
    edtPesquisaNome: TEdit;
    lblPesquisaNome: TLabel;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure DoBeforeList; override;
  end;

var
  FrmPesquisaMotivoExclusaoPedido: TFrmPesquisaMotivoExclusaoPedido;

implementation

{$R *.dfm}

uses Services.MotivoExclusaoPedido, uFrmeXactWMS;
{ TFrmBaseCadastro1 }

procedure TFrmPesquisaMotivoExclusaoPedido.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('MotivoId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaMotivoExclusaoPedido.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', edtPesquisaCodigo.Text)
    .AddParam('nome', edtPesquisaNome.Text);
end;

procedure TFrmPesquisaMotivoExclusaoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceMotivoExclusaoPedido.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/motivoexclusaopedido4D');

end;

end.
