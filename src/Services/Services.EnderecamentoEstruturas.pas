unit Services.EnderecamentoEstruturas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceEnderecamentoEstruturas = class(TServiceBaseCadastro)
    mtPesquisaEstruturaId: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaPickingFixo: TIntegerField;
    mtPesquisaVolumePadrao: TFloatField;
    mtPesquisaCapacidadePadrao: TFloatField;
    mtPesquisaMascara: TStringField;
    mtCadastroEstruturaId: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroPickingFixo: TIntegerField;
    mtCadastroVolumePadrao: TFloatField;
    mtCadastroCapacidadePadrao: TFloatField;
    mtCadastroMascara: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtCadastroStatus: TIntegerField;
    mtPesquisaAltura: TFloatField;
    mtPesquisaLargura: TFloatField;
    mtPesquisaComprimento: TFloatField;
    mtCadastroAltura: TFloatField;
    mtCadastroLargura: TFloatField;
    mtCadastroComprimento: TFloatField;
    procedure mtPesquisaPickingFixoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtPesquisaStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceEnderecamentoEstruturas: TServiceEnderecamentoEstruturas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceEnderecamentoEstruturas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/enderecoestrutura4D');
end;

procedure TServiceEnderecamentoEstruturas.mtCadastroAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceEnderecamentoEstruturas.mtPesquisaPickingFixoGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Sim';
  if (Sender.AsInteger = 0) then
    Text := 'Não';
end;

procedure TServiceEnderecamentoEstruturas.mtPesquisaStatusGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
