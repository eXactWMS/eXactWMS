unit Services.EnderecamentoZonas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceEnderecamentoZonas = class(TServiceBaseCadastro)
    mtPesquisaZonaId: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaEstoqueTipoId: TIntegerField;
    mtPesquisaStatus: TIntegerField;
    mtPesquisaEstoqueTipo: TStringField;
    mtCadastroZonaId: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroEstoqueTipoId: TIntegerField;
    mtCadastroStatus: TIntegerField;
    mtCadastroEstoqueTipo: TStringField;
    procedure mtPesquisaStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastroBeforeInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceEnderecamentoZonas: TServiceEnderecamentoZonas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceEnderecamentoZonas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/enderecamentozona4D');
end;

procedure TServiceEnderecamentoZonas.mtCadastroBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceEnderecamentoZonas.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
