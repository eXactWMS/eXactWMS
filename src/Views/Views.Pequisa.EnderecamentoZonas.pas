unit Views.Pequisa.EnderecamentoZonas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaEnderecamentoZonas = class(TFrmBaseCadastro)
    Label1: TLabel;
    EdtZonaId: TEdit;
    EdtDescricao: TEdit;
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
  FrmPesquisaEnderecamentoZonas: TFrmPesquisaEnderecamentoZonas;

implementation

{$R *.dfm}

uses Services.EnderecamentoZonas, uFrmeXactWMS;

{ TFrmPesquisaEnderecamentoZonas }

procedure TFrmPesquisaEnderecamentoZonas.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('ZonaId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaEnderecamentoZonas.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('zonaid', EdtZonaId.Text)
    .AddParam('descricao',     EdtDescricaO.Text);
end;

procedure TFrmPesquisaEnderecamentoZonas.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceEnderecamentoZonas.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/enderecamentozona4D');
end;

end.
