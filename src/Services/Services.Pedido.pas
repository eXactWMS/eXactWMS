unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON, REST.Json, Rest.Types;

type
  TServicePedidos = class(TServiceBaseCadastro)
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  Protected
    { Public declarations }
    //Function ListarRegistroJson : TJsonArray; OverRide;
  end;

var
  ServicePedidos: TServicePedidos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServicePedidos.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request
    .BaseURL(BASEURL)
    .Resource('v1/saida/cubagem');
end;

{
 function TServicePedidos.ListarRegistroJson: TJsonArray;
 Var ObjJson : TJsonObject;
 begin
   Result := TJsonArray.Create;
   Result.AddElement(TJsonObject.Create.AddPair('Teste','Positivo'));
 end;
}

procedure TServicePedidos.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  //mtCadastrostatus.AsInteger := 1;
end;

end.
