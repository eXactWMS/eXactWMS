unit Services.Funcionalidades;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceFuncionalidade = class(TServiceBaseCadastro)
    mtPesquisaFuncionalidadeId: TIntegerField;
    mtPesquisaDescricao: TStringField;
    mtPesquisaStatus: TIntegerField;
    mtCadastroFuncionalidadeId: TIntegerField;
    mtCadastroDescricao: TStringField;
    mtCadastroStatus: TIntegerField;
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
  ServiceFuncionalidade: TServiceFuncionalidade;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceFuncionalidade.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/funcionalidade4D');  //ProcessoId
end;

procedure TServiceFuncionalidade.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1
end;

procedure TServiceFuncionalidade.mtPesquisaStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.
