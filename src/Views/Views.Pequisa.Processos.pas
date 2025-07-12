unit Views.Pequisa.Processos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaProcessos = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    EdtProcessoId: TEdit;
    EdtProcesso: TEdit;
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
  FrmPesquisaProcessos: TFrmPesquisaProcessos;

implementation

{$R *.dfm}

uses uFrmeXactWMS, Services.Processos;

procedure TFrmPesquisaProcessos.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('ProcessoId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaProcessos.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', EdtProcessoId.Text)
    .AddParam('descricao', EdtProcesso.Text);
end;

procedure TFrmPesquisaProcessos.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceProcessos.Create(Self);
//  FService. Request.BaseURL('http://localhost:9000').Resource('v1/clientes');
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/processo4D');
end;

end.
