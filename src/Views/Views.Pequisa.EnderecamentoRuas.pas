unit Views.Pequisa.EnderecamentoRuas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaEnderecamentoRuas = class(TFrmBaseCadastro)
    EdtRuaId: TEdit;
    Label1: TLabel;
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
  FrmPesquisaEnderecamentoRuas: TFrmPesquisaEnderecamentoRuas;

implementation

{$R *.dfm}

uses Services.EnderecamentoRuas, uFrmeXactWMS;

{ TFrmPesquisaEnderecamentoRuas }

procedure TFrmPesquisaEnderecamentoRuas.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('RuaId').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaEnderecamentoRuas.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('ruaid', EdtRuaId.Text)
    .AddParam('descricao',     EdtDescricao.Text);
end;

procedure TFrmPesquisaEnderecamentoRuas.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceEnderecamentoRuas.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/enderecorua4D');
end;

end.
