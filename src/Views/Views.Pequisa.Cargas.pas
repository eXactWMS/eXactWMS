unit Views.Pequisa.Cargas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaCargas = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    lblPesquisaNome: TLabel;
    EdtIdentificacao: TEdit;
    EdtCargaId: TEdit;
    Label1: TLabel;
    EdtRotaId: TEdit;
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
  FrmPesquisaCargas: TFrmPesquisaCargas;

implementation

{$R *.dfm}

Uses uFrmeXactWMS, Service.Cargas;

{ TFrmPesquisaCargas }

procedure TFrmPesquisaCargas.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('cargaid').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaCargas.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('cargaid', EdtRotaId.Text)
    .AddParam('rotaid',  EdtRotaId.Text);
end;

procedure TFrmPesquisaCargas.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceCargas.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/cargas4D');
end;

end.
