unit Views.Pequisa.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaUsuario = class(TFrmBaseCadastro)
    EdtUsuarioId: TEdit;
    lblPesquisaCodigo: TLabel;
    lblPesquisaNome: TLabel;
    EdtNome: TEdit;
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
  FrmPesquisaUsuario: TFrmPesquisaUsuario;

implementation

{$R *.dfm}

{ TFrmPesquisaUsuario }

Uses uFrmeXactWMS, Services.Usuarios;

procedure TFrmPesquisaUsuario.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('UsuarioId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaUsuario.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('usuarioid', EdtUsuarioId.Text)
    .AddParam('nome', EdtNome.Text);
end;

procedure TFrmPesquisaUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceUsuario.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/usuario4D');
end;

end.
