unit Services.Usuarios;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceUsuario = class(TServiceBaseCadastro)
    mtPesquisaUsuarioId: TIntegerField;
    mtPesquisaNome: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtCadastroUsuarioId: TIntegerField;
    mtCadastroNome: TStringField;
    mtCadastroPerfilId: TIntegerField;
    mtCadastroPerfil: TStringField;
    mtCadastroStatus: TIntegerField;
    mtPesquisaPerfilId: TIntegerField;
    mtPesquisaPerfil: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtPesquisaStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceUsuario: TServiceUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceUsuario.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/usuario4D');  //ProcessoId
end;

procedure TServiceUsuario.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1
end;

procedure TServiceUsuario.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
