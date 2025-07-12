unit Services.Produtos;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceProdutos = class(TServiceBaseCadastro)
    mtPesquisaIdProduto: TIntegerField;
    mtPesquisaCodProduto: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaFatorConversao: TIntegerField;
    mtPesquisaEnderecoDescricao: TStringField;
    mtPesquisaRastroDescricao: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtCadastroIdProduto: TIntegerField;
    mtCadastroCodProduto: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroFatorConversao: TIntegerField;
    mtCadastroUnidadeSecundariaSigla: TStringField;
    mtPesquisaUnidadeSecundariaSigla: TStringField;
    mtCadastroEnderecoDescricao: TStringField;
    mtCadastroRastroDescricao: TStringField;
    mtCadastroStatus: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisaStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceProdutos: TServiceProdutos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceProdutos.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/produto4D');
end;

procedure TServiceProdutos.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceProdutos.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
