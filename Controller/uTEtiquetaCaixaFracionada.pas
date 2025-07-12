unit uTEtiquetaCaixaFracionada;

interface

uses uTEtiqueta, Classes;

type
  TEtiquetaCaixaFracionada = class(TEtiqueta)
  private
    FCodigoSaida   : Int64;
    FDataSaida     : TDateTime;
    FCodigoRota    : Integer;
    FNomeRota      : String;
    FCodigoCliente : Integer;
    FNomeCliente   : String;
    FNumeroVolume  : Integer;
    FCodigoVolume  : Int64;
    FObservacao    : string;
    FEndereco      : String;
    FEnderecoFinal : String;
    FQtUnid        : Int64;
  protected
    function ComandosDataMax: TStringList; override;
    function ComandosZebraEPL2: TStringList; override;
    function ComandosZebraZPL2: TStringList; override;
  public
    property CodigoSaida: Int64       read FCodigoSaida     write FCodigoSaida;
    property DataSaida: TDateTime     read FDataSaida       write FDataSaida;
    property CodigoRota: Integer      read FCodigoRota      write FCodigoRota;
    Property NomeRota  : String       Read FNomeRota        Write FNomeRota;
    property CodigoCliente: Integer   read FCodigoCliente   write FCodigoCliente;
    Property NomeCliente : String     Read FNomeCliente     Write FNomeCliente;
    property NumeroVolume: Integer    read FNumeroVolume    write FNumeroVolume;
    property CodigoVolume: Int64      read FCodigoVolume    write FCodigoVolume;
    property Observacao: string       read FObservacao      write FObservacao;
    Property Endereco  : String       Read FEndereco        Write FEndereco;
    Property EnderecoFinal : String   Read FEnderecoFinal   Write FEnderecoFinal;
    Property QtUnid    : Int64        Read FQtUnid          Write FQtUnid;
  end;

implementation

uses  SysUtils, uFuncoes;
{ TEtiquetaCaixaFracionada }

function TEtiquetaCaixaFracionada.ComandosDataMax: TStringList;
var
  vlComandos: TStringList;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add(#2 + 'L' + #13); // Inicializa a impressão

  vlComandos.Add('1X1100000030020B380290002002'); // Moldura

  vlComandos.Add('1911S0102630025P011P008N:' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102630050P011P008' + IntToStr(Self.CodigoSaida)+'   '+Self.Endereco + #13); // Código da Saída
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002550300L002035' + #13);
  vlComandos.Add('1911S0102800305P003P003Data' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102630313P006P005' + FormatDateTime('dd/mm/yy', Self.DataSaida) + #13); // Data do Pedido
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002550022L378002' + #13); // Linha 1

  vlComandos.Add('1911S0102450025P003P003Rota' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102050030P018P015' + IntToStr(Self.CodigoRota) + #13); // Código da Rota
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001950120L002060' + #13); // Coluna 1
  vlComandos.Add('1911S0102450125P003P003Cliente' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102050130P018P015' + IntToStr(Self.CodigoCliente) + #13); // Código do Cliente
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001950220L002060' + #13); // Coluna 2
  vlComandos.Add('1911S0102450225P003P003Volume' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102050230P014P010' + IntToStr(Self.NumeroVolume) + #13); // Número do Volume
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001950022L378002' + #13); // Linha 2

  vlComandos.Add('1E1105000900145' + Format('%.9d', [Self.CodigoVolume]) + #13); // Código do Volume

  vlComandos.Add('1911S0100530025P005P004' + Self.Observacao + #13);

  vlComandos.Add('1X1100000470022L378002' + #13); // Linha 3

  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0100150025P011P010CAIXA FRACIONADA' + #13);
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1911S0100100340P004P004Linx WMS' + #13);

  vlComandos.Add('Q0001' + #13); // Quantidade de etiquetas
  vlComandos.Add('E' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaCaixaFracionada.ComandosZebraEPL2: TStringList;
var
  vlComandos: TStringList;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('N' + #13); // Inicia a impressão

  vlComandos.Add('X10,10,4,770,580' + #13); // Moldura

  vlComandos.Add('A25,25,0,3,2,3,N,"N:' + IntToStr(Self.CodigoSaida)+'      '+Self.Endereco + '"' + #13); // Código da Saída
  vlComandos.Add('LO300,10,3,75' + #13);
  vlComandos.Add('A310,20,0,2,1,1,N,"Endereco:"' + #13);

  vlComandos.Add('LO580,10,3,75' + #13);
  vlComandos.Add('A590,20,0,2,1,1,N,"Data"' + #13);
  vlComandos.Add('A595,50,0,4,1,1,N,"' + FormatDateTime('dd/mm/yy', Self.DataSaida)+ '"' + #13); // Data da Saída

  vlComandos.Add('LO10,85,760,3' + #13); // Linha 1

  vlComandos.Add('A25,95,0,2,1,1,N,"Rota"' + #13);
  vlComandos.Add('A30,120,0,3,4,4,N,"' + IntToStr(Self.CodigoRota) + '"' + #13); // Código da Rota

  vlComandos.Add('LO220,85,3,115' + #13); // Coluna 1
  vlComandos.Add('A235,95,0,2,1,1,N,"Cliente"' + #13);
  vlComandos.Add('A240,120,0,3,4,4,N,"' + IntToStr(Self.CodigoCliente) + '"' + #13); // Código do Cliente

  vlComandos.Add('LO420,85,3,115' + #13); // Coluna 2
  vlComandos.Add('A435,95,0,2,1,1,N,"Volume"' + #13);
  vlComandos.Add('A440,130,0,3,2,3,N,"' + IntToStr(Self.NumeroVolume) + '"' + #13); // Número do Volume

  vlComandos.Add('LO10,200,760,3' + #13); // Linha 2
//30/08/2017
//  vlComandos.Add('^FO30,250^A0N,25,25^FD'+Copy(Self.NomeRota,1,20)+'^FS');
//  vlComandos.Add('^FO235,250^A0N,25,25^FD'+Self.NomeCliente+'^FS');

  vlComandos.Add('A30,210,0,2,1,2,N,"' + Copy(Self.NomeRota,1,20) + '"' + #13); // Número do Volume
  vlComandos.Add('A230,210,0,2,1,2,N,"' + Self.NomeCliente + '"' + #13); // Número do Volume
  vlComandos.Add('LO10,240,760,3' + #13); // Linha 2

  vlComandos.Add('A30,250,0,2,1,2,N,"' + 'Endereco: '+Self.Endereco+' a '+Self.EnderecoFinal  + '"' + #13);
  vlComandos.Add('A570,250,0,2,1,2,N,"' + 'Unid: '+Repl(' ',4-Length(Self.QtUnid.ToString()))+FormatFloat('###0', Self.QtUnid)+ '"' + #13);
  vlComandos.Add('LO10,285,760,3' + #13); // Linha 2

  vlComandos.Add('B300,310,0,1,2,3,100,B,"' + Format('%.9d', [Self.CodigoVolume]) + '"' + #13); // Código do Volume

  vlComandos.Add('A25,460,0,2,1,2,N,"' + Self.Observacao + '"' + #13);

  vlComandos.Add('LO10,495,760,3' + #13); // Linha 3

  vlComandos.Add('A25,510,0,3,2,3,N,"CAIXA FRACIONADA"' + #13);
  vlComandos.Add('A640,550,0,4,1,1,N,"Linx WMS"' + #13);

  vlComandos.Add('P1' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

//BigBen
function TEtiquetaCaixaFracionada.ComandosZebraZPL2: TStringList;
var
  vlComandos: TStringList;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('^XA'); // Inicia a impressão
  vlComandos.Add('^MMT'); // Informa para a impressora avaçar a etiqueta ao final da impressão

  vlComandos.Add('^FO20,30^GB760,580,3^FS'); // Moldura

  vlComandos.Add('^FO30,40^A0N,60,50^FDN:^FS');

  vlComandos.Add('^FO350,30^GB000,070,3^FS'); // Coluna
  vlComandos.Add('^FO370, 40^A0N,17,17^FDEndereco:^FS');

  vlComandos.Add('^FO80,40^A0N,60,50^FD' + IntToStr(Self.CodigoSaida)+'               '+Self.Endereco + '^FS'); // Número da Saída

  vlComandos.Add('^FO580,30^GB000,070,3^FS'); // Coluna
  vlComandos.Add('^FO590,40^A0N,17,17^FDData^FS');
  vlComandos.Add('^FO600,60^A0N,35,35^FD' + '   '+FormatDateTime('dd/mm/yy', Self.DataSaida) + '^FS'); // Data da Saída

  vlComandos.Add('^FO20,100^GB760,000,3^FS'); // Linha 1

  vlComandos.Add('^FO30,110^A0N,17,17^FDRota^FS');
  vlComandos.Add('^FO40,135^A0N,110,110^FD' + IntToStr(Self.CodigoRota) + '^FS'); // Código da Rota

  vlComandos.Add('^FO230,100^GB000,130,3^FS'); // Coluna
  vlComandos.Add('^FO240,110^A0N,17,17^FDCliente^FS');
  vlComandos.Add('^FO250,135^A0N,110,110^FD' + IntToStr(Self.CodigoCliente) + '^FS'); // Código do Cliente

  vlComandos.Add('^FO430,100^GB000,130,3^FS'); // Coluna
  vlComandos.Add('^FO440,110^A0N,17,17^FDVolume^FS');
  vlComandos.Add('^FO450,150^A0N,70,60^FD' +'    '+IntToStr(Self.NumeroVolume) + '^FS'); // Número do Volume

  vlComandos.Add('^FO20,230^GB760,000,3^FS'); // Linha 2
                       //320
  vlComandos.Add('^FO260,340^BY2^BCN,120,Y,N,N^FD' + Format('%.9d', [Self.CodigoVolume]) + '^FS'); // Código do Volume

  vlComandos.Add('^FO30,500^A0N,25,25^FD' + Self.Observacao + '^FS');

  vlComandos.Add('^FO20,530^GB760,000,3^FS'); // Linha 3
//                  Col  Lin
  vlComandos.Add('^FO30,250^A0N,25,25^FD'+Copy(Self.NomeRota,1,20)+'^FS');
  vlComandos.Add('^FO235,250^A0N,25,25^FD'+Self.NomeCliente+'^FS');
  vlComandos.Add('^FO20,270^GB760,000,3^FS'); // Linha 3

  vlComandos.Add('^FO30, 280^A0N,30,30^FD'+'Endereco: '+Self.Endereco+' a '+Self.EnderecoFinal+'^FS');
  vlComandos.Add('^FO630, 280^A0N,30,30^FD'+'Unid: '+Repl(' ',4-Length(Self.QtUnid.ToString()))+FormatFloat('###0', Self.QtUnid)+'^FS');
  vlComandos.Add('^FO20, 310^GB760,000,3^FS'); // Linha 3

  vlComandos.Add('^FO30,550^A0N,60,70^FDCAIXA FRACIONADA^FS');
  vlComandos.Add('^FO660,570^A0N,25,25^FDLinx WMS^FS');

  vlComandos.Add('^XZ'); // Finaliza a impressão

  Result := vlComandos;
end;

end.

