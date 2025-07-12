unit Views.Pequisa.Endereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TFrmPesquisaEndereco = class(TFrmBaseCadastro)
    Label1: TLabel;
    EdtEndereco: TEdit;
    lblPesquisaNome: TLabel;
    EdtZona: TEdit;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoBeforeList; override;
  public
    { Public declarations }
    EnderecoSelecionado : String;
  end;

var
  FrmPesquisaEndereco: TFrmPesquisaEndereco;

implementation

{$R *.dfm}

uses Services.Enderecos, uFrmeXactWMS;

{ TFrmPesquisaEndereco }

procedure TFrmPesquisaEndereco.DBGridDblClick(Sender: TObject);
begin
  inherited;
  Tag := 0;
  if Not dsPesquisa.DataSet.IsEmpty then Begin
     Tag := dsPesquisa.DataSet.FieldByName('EnderecoId').AsInteger;
     EnderecoSelecionado := dsPesquisa.DataSet.FieldByName('Endereco').AsString;
  End;
  ModalResult := MrOk;
end;

procedure TFrmPesquisaEndereco.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('endereco', EdtEndereco.Text)
    .AddParam('zona',     EdtZona.Text);
end;

procedure TFrmPesquisaEndereco.FormCreate(Sender: TObject);
begin
  inherited;
  EnderecoSelecionado := '';
  FService := TServiceEnderecos.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/endereco4D');
end;

end.
