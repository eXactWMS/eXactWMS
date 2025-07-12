unit Views.Pequisa.Perfil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.WinXPanels, Services.Perfil;

type
  TFrmPesquisaPerfil = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    lblPesquisaNome: TLabel;
    EdtPerfilId: TEdit;
    EdtPerfil: TEdit;
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
  FrmPesquisaPerfil: TFrmPesquisaPerfil;

implementation

{$R *.dfm}

uses uFrmeXactWMS;

procedure TFrmPesquisaPerfil.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('PerfilId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaPerfil.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('perfilid', EdtPerfilId.Text)
    .AddParam('descricao', EdtPerfil.Text);
end;

procedure TFrmPesquisaPerfil.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServicePerfil.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/perfil4D');

end;

end.
