unit Services.MotivoExclusaoPedido;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceMotivoExclusaoPedido = class(TServiceBaseCadastro)
    mtCadastroMotivoId: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroStatus: TIntegerField;
    mtPesquisaMotivoId: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaStatus: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtCadastroStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceMotivoExclusaoPedido: TServiceMotivoExclusaoPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceMotivoExclusaoPedido.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('motivoexclusaopedido4D');
end;

procedure TServiceMotivoExclusaoPedido.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceMotivoExclusaoPedido.mtCadastroStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.
