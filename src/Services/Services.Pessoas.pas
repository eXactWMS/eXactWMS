unit Services.Pessoas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServicePessoas = class(TServiceBaseCadastro)
    mtCadastropessoaid: TIntegerField;
    mtCadastrocodpessoaerp: TIntegerField;
    mtCadastrorazao: TStringField;
    mtCadastrofantasia: TStringField;
    mtCadastrocnpj: TStringField;
    mtCadastroemail: TStringField;
    mtCadastrorotaid: TIntegerField;
    mtCadastrorota: TStringField;
    mtCadastrostatus: TIntegerField;
    mtPesquisapessoaid: TIntegerField;
    mtPesquisacodpessoaerp: TIntegerField;
    mtPesquisarazao: TStringField;
    mtPesquisafantasia: TStringField;
    mtPesquisacnpj: TStringField;
    mtPesquisaemail: TStringField;
    mtPesquisarotaid: TIntegerField;
    mtPesquisarota: TStringField;
    mtPesquisastatus: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServicePessoas: TServicePessoas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServicePessoas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/pessoas4D')
end;

procedure TServicePessoas.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServicePessoas.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
