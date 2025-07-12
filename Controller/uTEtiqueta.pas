unit uTEtiqueta;

interface

uses
  Classes;

type
  TImpressoraModelo = (imDataMax, imZebraEPL2, imZebraZPL2);

  TEtiqueta = class
    private
    protected
      function ComandosDataMax: TStringList; dynamic;
      function ComandosZebraEPL2: TStringList; dynamic;
      function ComandosZebraZPL2: TStringList; dynamic;
    public
      function Comandos(pModelo: TImpressoraModelo): TStringList;
  end;

implementation

{ TEtiqueta }

function TEtiqueta.Comandos(pModelo: TImpressoraModelo): TStringList;
begin
  case pModelo of
    imDataMax:   Result := ComandosDataMax;   // Impressora Modelo DataMax
    imZebraEPL2: Result := ComandosZebraEPL2; // Impressora Modelo Zebra EPL2
    imZebraZPL2: Result := ComandosZebraZPL2; // Impressora Modelo Zebra ZPL2
  end;
end;

function TEtiqueta.ComandosDataMax: TStringList;
begin
//
end;

function TEtiqueta.ComandosZebraEPL2: TStringList;
begin
//
end;

function TEtiqueta.ComandosZebraZPL2: TStringList;
begin
//
end;

end.
