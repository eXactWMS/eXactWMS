unit Services.EnderecamentoRuas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceEnderecamentoRuas = class(TServiceBaseCadastro)
    mtPesquisaRuaId: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaLado: TStringField;
    mtPesquisaOrdem: TIntegerField;
    mtPesquisaStatus: TIntegerField;
    mtCadastroRuaId: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroLado: TStringField;
    mtCadastroOrdem: TIntegerField;
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
  ServiceEnderecamentoRuas: TServiceEnderecamentoRuas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceEnderecamentoRuas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/enderecorua4D');
end;

procedure TServiceEnderecamentoRuas.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceEnderecamentoRuas.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
