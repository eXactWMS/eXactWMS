unit uTEtiquetaCaixaSeparacao;

interface

uses uTEtiqueta, Classes;

type
  TEtiquetaCaixaSeparacao = class(TEtiqueta)
  private
    FCodigo: Int64;
  protected
    function ComandosDataMax: TStringList; override;
    function ComandosZebraEPL2: TStringList; override;
    function ComandosZebraZPL2: TStringList; override;
  public
    property Codigo: Int64  read FCodigo  write FCodigo;
  end;

implementation

uses SysUtils;

{ TEtiquetaCaixa }

function TEtiquetaCaixaSeparacao.ComandosDataMax: TStringList;
var
  vlComandos: TStringList;
  vlCodigo: string;
begin
  vlCodigo := IntToStr(FCodigo);

  while (Length(vlCodigo) < 9) do
    begin
      vlCodigo := '0' + vlCodigo;
    end;

  vlComandos := TStringList.Create;

  vlComandos.Add(#2 + 'L' + #13); // Inicializa a impressão

  vlComandos.Add('4911S0100400030P005P005X3 WMS' + #13); // X3 WMS
  vlComandos.Add('1E1108000150050' + vlCodigo + #13); // Código da Caixa

  vlComandos.Add('Q0001' + #13); // Quantidade de etiquetas
  vlComandos.Add('E' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaCaixaSeparacao.ComandosZebraEPL2: TStringList;
var
  vlComandos: TStringList;
  vlCodigo: string;
begin
  vlCodigo := IntToStr(FCodigo);

  while (Length(vlCodigo) < 9) do
    begin
      vlCodigo := '0' + vlCodigo;
    end;

  vlComandos := TStringList.Create;

  vlComandos.Add('N' + #13); // Inicia a impressão

  vlComandos.Add('B50,50,0,1,2,3,150,B,"' + vlCodigo + '"' + #13); // Código da Caixa

  vlComandos.Add('P1' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaCaixaSeparacao.ComandosZebraZPL2: TStringList;
var
  vlComandos: TStringList;
  vlCodigo: string;
begin
  vlCodigo := IntToStr(FCodigo);

  while (Length(vlCodigo) < 9) do
    begin
      vlCodigo := '0' + vlCodigo;
    end;

  vlComandos := TStringList.Create;

  vlComandos.Add('^XA'); // Inicia a impressão
  vlComandos.Add('^MMT'); // Informa para a impressora avaçar a etiqueta ao final da impressão

  vlComandos.Add('^FO100,80^BY2^BCN,160,Y,N,N^FD' + vlCodigo + '^FS'); // Código da Caixa
  vlComandos.Add('^FO40,120^A0B,30,30^FDX3 WMS^FS'); // X3 WMS

  vlComandos.Add('^XZ'); // Finaliza a impressão

  Result := vlComandos;
end;

end.
