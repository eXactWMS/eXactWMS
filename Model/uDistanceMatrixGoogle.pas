unit uDistanceMatrixGoogle;

interface

Uses
{  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
} REST.Response.Adapter, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, System.TypInfo, System.SysUtils;

Type

  TDistanceMatrixGoogle = Class
    Private
      FKey : String;
    Public
      FOrigem     : String;
      FDestino    : String;
      FEndereco   : String;
      FLogradouro : String;
      FBairro     : String;
      FCidade     : String;
      FUF         : String;
      FCep        : String;
      FDistancia  : Integer;
      FDuracao    : Integer;
      Constructor Create(cKey : String = ''; cOrigem : String = ''; cDestino : String = '';
                         cEndereco : String = ''; cLogradouro : String = ''; cBairro : String = '';
                         cCidade : String = ''; cUF : String = ''; cCep : String = '';
                         cDistancia : Integer = 0; cDuracao : Integer = 0);
      Function GETDados : TDistanceMatrixGoogle;  //(pOrigem, pDestino : String)
    Published
      Property Key : String Read FKey Write FKey;
      Property Origem     : String Read FOrigem     Write FOrigem;
      Property Destino    : String Read FDestino    Write FDestino;
      Property Endereco   : String Read FEndereco   Write FEndereco;
      Property Logradouro : String Read FLogradouro Write FLogradouro;
      Property Bairro     : String Read FBairro     Write FBairro;
      Property Cidade     : String Read FCidade     Write FCidade;
      Property UF         : String Read FUF         Write FUF;
      Property Cep        : String Read FCep        Write FCep;
      Property Distancia : Integer Read FDistancia Write FDistancia;
      Property Duracao   : Integer Read FDuracao   Write FDuracao;
  End;

implementation

{ TDistanceMatrixGoogle }

{ TDistanceMatrixGoogle }

Uses uDmeXactWMS, Vcl.Clipbrd;

constructor TDistanceMatrixGoogle.Create(cKey, cOrigem, cDestino, cEndereco,
  cLogradouro, cBairro, cCidade, cUF, cCep: String; cDistancia,
  cDuracao: Integer);
begin
//https://map.googleapis.com/maps/api/distancematrix/json?origins=[Origem]&destinations=[Destino]&mode=driving&language=pt-BR&key=AIzaSyAFbAnuE9XBn7sX-1FGI8kKOpMuV8FunQg
  FKey        := 'AIzaSyAFbAnuE9XBn7sX-1FGI8kKOpMuV8FunQg';
  FOrigem     := '-10.2197173,-48.334408';  //CHurrascaria Temperus
  FDestino    := cDestino;
  FEndereco   := cEndereco;
  FLogradouro := cLogradouro;
  FBairro     := cBairro;
  FCidade     := cCidade;
  FUF         := cUF;
  FCep        := cCep;
  FDistancia  := cDistancia;
  FDuracao    := cDuracao;
end;

function TDistanceMatrixGoogle.GETDados : TDistanceMatrixGoogle; //(pOrigem, pDestino : String)
var
  AText: string;
  Objeto, ObjRows, ObjElements, ObjDuration, ObjDistance: TJSONObject;
  ParRows: TJSONPair;
  ArrayRows, ArrayElements: TJSONArray;
  DistanciaTexto, DuracaoTexto: string;
  X: Integer;
  PosIni, PosFin : Integer;
begin
  //if pOrigem = '' then pOrigem := FOrigem;
  Result := TDistanceMatrixGoogle.Create();
  DmeXactWMS.RESTClientWMS.BaseURL := 'https://maps.googleapis.com/maps/api/distancematrix/json?origins='+FOrigem+
                         '&destinations='+FDestino+'&mode=driving&language=pt-BR&key='+FKey;
  DmeXactWMS.RESTRequestWMS.Execute;
  //Alan - Bruto do delphi -->
  Clipboard.AsText := DmeXactWMS.RESTResponseWMS.JSONText;
  Objeto := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
  if Not (Objeto.GetValue<String>('status') = 'REQUEST_DENIED') then Begin
     ParRows := Objeto.Get('destination_addresses');
     ArrayRows := ParRows.JsonValue as TJSONArray;
     FEndereco := ArrayRows.Items[0].Value;
     //Q. 1104 Sul Alameda 2, 18 - Arse, Palmas - TO, 77024-028, Brasil
     PosIni := 0;
     PosFin := 0;
     for X := Length(FEndereco) DownTo  1 do Begin
         if FEndereco[X] = ',' then Begin
            if PosFin = 0  then PosFin := X Else PosIni := X+1;
            if PosIni <> 0 then Begin
               FCep := Trim(Copy(FEndereco, PosIni, PosFin-PosIni));
               Break;
            End;
         End;
     End;
     ParRows := Objeto.Get('rows');
     ArrayRows := ParRows.JsonValue as TJSONArray;
     ObjRows := ArrayRows.Items[0] as TJSONObject;
     ArrayElements := ObjRows.GetValue('elements') as TJSONArray;
     ObjElements := ArrayElements.Items[0] as TJSONObject;
     ObjDistance := ObjElements.GetValue('distance') as TJSONObject;
     ObjDuration := ObjElements.GetValue('duration') as TJSONObject;
     if (Not (ObjDistance = Nil)) and (Not (ObjDuration = Nil)) then Begin
        FDistancia := StrToIntDef(ObjDistance.GetValue('value').Value, 0);
        FDuracao   := StrToIntDef(ObjDuration.GetValue('value').Value, 0);
     End
     Else Begin
       FDistancia := 0;
       FDuracao   := 0;
     End;
  End
  Else Begin
    FDistancia := 0;
    FDuracao   := 0;
  End;
end;

{ TDistanceMatrixGoogle }

end.
