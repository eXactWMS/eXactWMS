unit Services.Veiculos;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServicesVeiculos = class(TServiceBaseCadastro)
    mtCadastrostatus: TIntegerField;
    mtPesquisaveiculoid: TIntegerField;
    mtPesquisaplaca: TStringField;
    mtPesquisatipo: TStringField;
    mtPesquisamarca: TStringField;
    mtPesquisamodelo: TStringField;
    mtPesquisacor: TStringField;
    mtPesquisatara: TFloatField;
    mtPesquisacapacidade: TFloatField;
    mtPesquisatransportadoraid: TIntegerField;
    mtPesquisatransportadora: TStringField;
    mtPesquisastatus: TIntegerField;
    mtCadastroveiculoid: TIntegerField;
    mtCadastroplaca: TStringField;
    mtCadastromarca: TStringField;
    mtCadastromodelo: TStringField;
    mtCadastrocor: TStringField;
    mtCadastrotara: TIntegerField;
    mtCadastrocapacidade: TIntegerField;
    mtCadastrotransportadoraid: TIntegerField;
    mtCadastrotransportadora: TStringField;
    mtPesquisaVolume: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtPesquisaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServicesVeiculos: TServicesVeiculos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServicesVeiculos.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/veiculos4D');
end;

procedure TServicesVeiculos.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServicesVeiculos.mtPesquisaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(mtPesquisa.FieldByName('Tarakg')).DisplayFormat     := '#####0.000';
  TNumericField(mtPesquisa.FieldByName('Capacidade')).DisplayFormat := '#####0.000';
  TNumericField(mtPesquisa.FieldByName('Volume')).DisplayFormat     := '#####0.000';
end;

procedure TServicesVeiculos.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
