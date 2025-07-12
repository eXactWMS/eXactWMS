unit Services.Caixas;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON, REST.Json, Rest.Types;

type
  TServiceCaixas = class(TServiceBaseCadastro)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Delete : Boolean;
    Function GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function GetCaixaEmbalagemJson(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin,
             pVolumeEmbalagemId : Integer; pSituacao : String; pStatus : Integer) : TJsonArray;
    Function Salvar : TJsonObject;
  end;

var
  ServiceCaixas: TServiceCaixas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceCaixas.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/caixaembalagem');
end;

function TServiceCaixas.Delete: Boolean;
begin

end;

function TServiceCaixas.GetCaixaEmbalagem(pCaixaEmbalagemId,
  pShowErro: Integer): TJsonArray;
begin

end;

function TServiceCaixas.GetCaixaEmbalagemJson(pCaixaEmbalagemId, pSequenciaIni,
  pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus: Integer): TJsonArray;
begin

end;

function TServiceCaixas.Salvar: TJsonObject;
begin

end;

end.
