unit Service.Cargas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceCargas = class(TServiceBaseCadastro)
    mtPesquisaCargaId: TIntegerField;
    mtPesquisaRotaId: TIntegerField;
    mtPesquisaTransportadoraId: TIntegerField;
    mtPesquisaTransportadora: TStringField;
    mtPesquisaVeiculoId: TIntegerField;
    mtPesquisaPlaca: TStringField;
    mtPesquisaModelo: TStringField;
    mtPesquisaMarca: TStringField;
    mtPesquisaCor: TStringField;
    mtPesquisaMotoristaid: TIntegerField;
    mtPesquisamotorista: TStringField;
    mtPesquisaUsuarioid: TIntegerField;
    mtPesquisaUsuario: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtPesquisauuid: TStringField;
    mtPesquisaProcessoId: TIntegerField;
    mtPesquisaProcesso: TStringField;
    mtPesquisaDtInclusao: TDateField;
    mtPesquisaHrInclusao: TTimeField;
    mtPesquisarota: TStringField;
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
  ServiceCargas: TServiceCargas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceCargas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/cargas4D');
end;

procedure TServiceCargas.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  //mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceCargas.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
