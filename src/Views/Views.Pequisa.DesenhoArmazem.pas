unit Views.Pequisa.DesenhoArmazem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.WinXPanels;

type
  TFrmPesquisaDesenhoArmazem = class(TFrmBaseCadastro)
    Label1: TLabel;
    lblPesquisaNome: TLabel;
    EdtArmazemId: TEdit;
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
  FrmPesquisaDesenhoArmazem: TFrmPesquisaDesenhoArmazem;

implementation

{$R *.dfm}

{ TFrmBaseCadastro1 }

uses uFrmeXactWMS, Services.DesenhoArmazem;

procedure TFrmPesquisaDesenhoArmazem.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     Tag := dsPesquisa.DataSet.FieldByName('Id').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaDesenhoArmazem.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', EdtArmazemId.Text)
    .AddParam('descricao',     EdtDescricao.Text);
end;

procedure TFrmPesquisaDesenhoArmazem.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceDesenhoArmazem.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/desenhoarmazem4D');
end;

end.
