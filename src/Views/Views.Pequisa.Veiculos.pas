unit Views.Pequisa.Veiculos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.WinXPanels;

type
  TFrmPesquisaVeiculos = class(TFrmBaseCadastro)
    EdtVeiculoId: TEdit;
    EdtTransportadora: TEdit;
    lblPesquisaCodigo: TLabel;
    lblPesquisaNome: TLabel;
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
  FrmPesquisaVeiculos: TFrmPesquisaVeiculos;

implementation

{$R *.dfm}

uses uFrmeXactWMS, Services.Veiculos;
{ TFrmBaseCadastro1 }

procedure TFrmPesquisaVeiculos.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('Veiculoid').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaVeiculos.DoBeforeList;
Var pTransportadoraId, pTransportadora : String;
begin
  inherited;
  if StrToIntDef(EdtTransportadora.Text, 0) <> 0 then Begin
     pTransportadoraId := EdtTransportadora.Text;
     pTransportadora   := '';
  End
  Else Begin
    pTransportadoraId := '';
    pTransportadora   := EdtTransportadora.Text;
  End;
  FService.Request
    .ClearParams
    .AddParam('id', EdtVeiculoId.Text)
    .AddParam('transportadoraid', pTransportadoraId)
    .AddParam('transportadora', pTransportadora);
end;

procedure TFrmPesquisaVeiculos.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServicesVeiculos.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/veiculos4D');
end;

end.
