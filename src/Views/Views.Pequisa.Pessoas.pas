unit Views.Pequisa.Pessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.WinXPanels;

type
  TFrmPesquisaPessoas = class(TFrmBaseCadastro)
    EdtPessoaId: TEdit;
    lblPesquisaCodigo: TLabel;
    EdtRazao: TEdit;
    lblPesquisaNome: TLabel;
    EdtCodigoERP: TEdit;
    Label1: TLabel;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoBeforeList; override;
  public
    { Public declarations }
    PessoaTipoId : Integer;
    somenteDisponivelAgrupamento : Boolean;
  end;

var
  FrmPesquisaPessoas: TFrmPesquisaPessoas;

implementation

{$R *.dfm}

{ TFrmPesquisaPessoa }

uses uFrmeXactWMS, Services.Pessoas;

procedure TFrmPesquisaPessoas.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then
     if PessoaTipoId in [1,2] then
        Tag := dsPesquisa.DataSet.FieldByName('codpessoaerp').AsInteger
     Else Tag := dsPesquisa.DataSet.FieldByName('pessoaid').AsInteger;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaPessoas.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('pessoatipoid', PessoaTipoId.ToString)
    .AddParam('id', EdtPessoaId.Text)
    .AddParam('codpessoaerp', EdtCodigoERP.Text)
    .AddParam('razao', EdtRazao.Text)
    .AddParam('disponivelagrupamento', Ord(somenteDisponivelAgrupamento).ToString());
end;

procedure TFrmPesquisaPessoas.FormCreate(Sender: TObject);
begin
  inherited;
  somenteDisponivelAgrupamento := False;
  FService := TServicePessoas.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/pessoas4D');

end;

procedure TFrmPesquisaPessoas.FormShow(Sender: TObject);
begin
  inherited;
  if PessoaTipoId = 1	      Then LblTitle.Caption := 'Cliente'
  Else If PessoaTipoid = 2	then LblTitle.Caption := 'Fornecedor'
  Else If PessoaTipoid = 3	Then LblTitle.Caption := 'Transportadora'
  Else If PessoaTipoid = 4	Then LblTitle.Caption := 'Motorista';
end;

end.
