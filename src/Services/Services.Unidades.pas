unit Services.Unidades;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceUnidades = class(TServiceBaseCadastro)
    mtPesquisaId: TIntegerField;
    mtPesquisaSigla: TStringField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaStatus: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtPesquisaStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceUnidades: TServiceUnidades;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceUnidades.DataModuleCreate(Sender: TObject);
begin
  inherited;
 Request
    .BaseURL(BASEURL)
    .Resource('v1/unidade4D');  //ProcessoId

end;

procedure TServiceUnidades.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
