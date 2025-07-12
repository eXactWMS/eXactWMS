unit Services.Laboratorios;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceLaboratorios = class(TServiceBaseCadastro)
    mtCadastroidlaboratorio: TIntegerField;
    mtCadastrocoderp: TIntegerField;
    mtCadastronome: TStringField;
    mtCadastrofone: TStringField;
    mtCadastroemail: TStringField;
    mtCadastrohomepage: TStringField;
    mtCadastrostatus: TIntegerField;
    mtCadastrouuid: TStringField;
    mtPesquisacoderp: TIntegerField;
    mtPesquisanome: TStringField;
    mtPesquisafone: TStringField;
    mtPesquisaemail: TStringField;
    mtPesquisahomepage: TStringField;
    mtPesquisastatus: TIntegerField;
    mtPesquisauuid: TStringField;
    mtPesquisaidlaboratorio: TIntegerField;
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
  ServiceLaboratorios: TServiceLaboratorios;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceLaboratorios.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('laboratorio4D');
end;

procedure TServiceLaboratorios.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceLaboratorios.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
