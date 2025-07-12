unit Services.Rotas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceRotas = class(TServiceBaseCadastro)
    mtCadastrorotaid: TIntegerField;
    mtCadastrodescricao: TStringField;
    mtCadastrogooglemaps: TStringField;
    mtCadastrolatitude: TStringField;
    mtCadastrolongitude: TStringField;
    mtCadastrodtinclusao: TIntegerField;
    mtCadastrohrinclusao: TIntegerField;
    mtCadastrostatus: TIntegerField;
    mtPesquisarotaid: TIntegerField;
    mtPesquisadescricao: TStringField;
    mtPesquisagooglemaps: TStringField;
    mtPesquisalatitude: TStringField;
    mtPesquisalongitude: TStringField;
    mtPesquisadtincluscao: TDateField;
    mtPesquisahrinclusao: TIntegerField;
    mtPesquisastatus: TIntegerField;
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtPesquisadtincluscaoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceRotas: TServiceRotas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceRotas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/rotas4D');
end;

procedure TServiceRotas.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceRotas.mtPesquisadtincluscaoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := MtCadastro.FieldByName('DtInclusao').AsString;
end;

procedure TServiceRotas.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if Sender.AsInteger = 0 then
     Text := 'Inativo';
end;

end.

