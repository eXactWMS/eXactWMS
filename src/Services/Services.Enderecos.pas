unit Services.Enderecos;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceEnderecos = class(TServiceBaseCadastro)
    mtPesquisaEnderecoId: TIntegerField;
    mtPesquisaEndereco: TStringField;
    mtPesquisaEstrutura: TStringField;
    mtPesquisaRua: TStringField;
    mtPesquisaLado: TStringField;
    mtPesquisaZona: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtCadastroEnderecoId: TIntegerField;
    mtCadastroEndereco: TStringField;
    mtCadastroEstrutura: TStringField;
    mtCadastroRua: TStringField;
    mtCadastroLado: TStringField;
    mtCadastroZona: TStringField;
    mtCadastroStatus: TIntegerField;
    procedure mtPesquisaStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtPesquisaLadoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceEnderecos: TServiceEnderecos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceEnderecos.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('endereco4D');
end;

procedure TServiceEnderecos.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceEnderecos.mtPesquisaLadoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if (Sender.AsString = 'I') then
     Text := 'Impar'
  Else
    Text := 'Par';
end;

procedure TServiceEnderecos.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
