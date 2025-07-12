unit Services.Perfil;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServicePerfil = class(TServiceBaseCadastro)
    mtPesquisaPerfilId: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtPesquisaData: TDateField;
    mtPesquisaHora: TTimeField;
    mtCadastroPerfilId: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroData: TDateField;
    mtCadastrohora: TTimeField;
    mtCadastroStatus: TIntegerField;
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
  ServicePerfil: TServicePerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServicePerfil.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/perfil4D');  //ProcessoId
end;

procedure TServicePerfil.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServicePerfil.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
