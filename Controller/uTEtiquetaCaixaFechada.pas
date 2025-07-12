unit uTEtiquetaCaixaFechada;

interface

uses uTEtiqueta, Classes;

type
  TEtiquetaCaixaFechada = class(TEtiqueta)
  private
    FCodigoSaida: Int64;
    FDataSaida: TDateTime;
    FCodigoRota: Integer;
    FCodigoCliente: Integer;
    FCodigoVolume: Int64;
    FNumeroVolume: Integer;
    FCodigoProduto: Int64;
    FNomeProduto: string;
    FEnderecoProduto: string;
    FMascaraEnderecoProduto: string;
    FLote: string;
    FDataVencimento: TDateTime;
    FQuantidade: Integer;
    FEnderecoEstoque: string;
    FMascaraEnderecoEstoque: string;
    FObservacao: string;
  protected
    function ComandosDataMax: TStringList; override;
    function ComandosZebraEPL2: TStringList; override;
    function ComandosZebraZPL2: TStringList; override;

    function getEnderecoEstoque: string;
  public
    property CodigoSaida: Int64               read FCodigoSaida             write FCodigoSaida;
    property DataSaida: TDateTime             read FDataSaida               write FDataSaida;
    property CodigoRota: Integer              read FCodigoRota              write FCodigoRota;
    property CodigoCliente: Integer           read FCodigoCliente           write FCodigoCliente;
    property CodigoVolume: Int64              read FCodigoVolume            write FCodigoVolume;
    property NumeroVolume: Integer            read FNumeroVolume            write FNumeroVolume;
    property CodigoProduto: Int64             read FCodigoProduto           write FCodigoProduto;
    property NomeProduto: string              read FNomeProduto             write FNomeProduto;
    property EnderecoProduto: string          read FEnderecoProduto         write FEnderecoProduto;
    property MascaraEnderecoProduto: string   read FMascaraEnderecoProduto  write FMascaraEnderecoProduto;
    property Lote: string                     read FLote                    write FLote;
    property DataVencimento: TDateTime        read FDataVencimento          write FDataVencimento;
    property Quantidade: Integer              read FQuantidade              write FQuantidade;
    property EnderecoEstoque: string          read getEnderecoEstoque       write FEnderecoEstoque;
    property MascaraEnderecoEstoque: string   read FMascaraEnderecoEstoque  write FMascaraEnderecoEstoque;
    property Observacao: string               read FObservacao              write FObservacao;
  end;

implementation

uses SysUtils, uFuncoes;

{ TEtiquetaCaixaFechada }

function TEtiquetaCaixaFechada.ComandosDataMax: TStringList;
var
  vlComandos: TStringList;
  vlCodigoProduto: string;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add(#2 + 'L' + #13); // Inicializa a impressão

  vlComandos.Add('1X1100000030020B380290002002'); // Moldura

  vlComandos.Add('1911S0102630025P011P008N:' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102630050P011P008' + IntToStr(Self.CodigoSaida) + #13); // Código da Saída
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002550300L002035' + #13);
  vlComandos.Add('1911S0102800305P003P003Data' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102630313P006P005' + FormatDateTime('dd/mm/yy', Self.DataSaida) + #13); // Data da Saída
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

  vlCodigoProduto := IntToStr(Self.CodigoProduto);

  while (Length(vlCodigoProduto) < 6) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('1911S0101850025P003P003Produto' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0101700030P005P003' + vlCodigoProduto + ' - ' + Self.NomeProduto + #13); // Produto
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001650022L378002' + #13); // Linha 3

  vlComandos.Add('1911S0101550025P003P003Lote' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0101350030P008P006' + Self.Lote + #13); // Lote
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001270220L002038' + #13); // Coluna 1
  vlComandos.Add('1911S0101550225P003P003Vencimento' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0101350230P008P006' + FormatDateTime('dd/mm/yy', Self.DataVencimento) + #13); // Data de Vencimento do Lote
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001270330L002038' + #13); // Coluna 2
  vlComandos.Add('1911S0101550335P003P003Qtd.' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0101350340P008P006' + Format('%.5d', [Self.Quantidade]) + #13); // Quantidade
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100001270022L378002' + #13); // Linha 4

  vlComandos.Add('1911S0101170025P003P003Endereco' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0100820030P014P010' + AplicarMascara(Self.EnderecoEstoque, Self.MascaraEnderecoEstoque) + #13); // Localização do Produto
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100000700220L002060' + #13); // Coluna 2
  vlComandos.Add('1E1103000750230' + Format('%.9d', [Self.CodigoVolume]) + #13); // Código do Volume

  vlComandos.Add('1X1100000700022L378002' + #13); // Linha 5

  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0100530025P005P004Obs.: End.: ' + AplicarMascara(Self.EnderecoProduto, Self.MascaraEnderecoProduto) + ' ' + Self.Observacao + #13);
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100000450022L378002' + #13); // Linha 6

  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0100150025P011P010CAIXA FECHADA' + #13);
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1911S0100100340P004P004Linx WMS' + #13);

  vlComandos.Add('Q0001' + #13); // Quantidade de etiquetas
  vlComandos.Add('E' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaCaixaFechada.ComandosZebraEPL2: TStringList;
var
  vlComandos: TStringList;
  vlCodigoProduto: string;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('N' + #13); // Inicia a impressão

  vlComandos.Add('X10,10,4,770,580' + #13); // Moldura

  vlComandos.Add('A25,25,0,3,2,3,N,"N:' + IntToStr(Self.CodigoSaida) + '"' + #13); // Número da Saída

  vlComandos.Add('LO580,10,3,75' + #13);
  vlComandos.Add('A590,20,0,2,1,1,N,"Data"' + #13);
  vlComandos.Add('A595,50,0,4,1,1,N,"' + FormatDateTime('dd/mm/yy', Self.DataSaida) + '"' + #13); // Data da Saída

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

  vlCodigoProduto := IntToStr(Self.CodigoProduto);

  while (Length(vlCodigoProduto) < 6) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('A25,210,0,2,1,1,N,"Produto"' + #13);
  vlComandos.Add('A30,235,0,2,1,2,N,"' + vlCodigoProduto + ' - ' + Self.NomeProduto + '"' + #13); // Produto

  vlComandos.Add('LO10,270,760,3' + #13); // Linha 3

  vlComandos.Add('A25,280,0,2,1,1,N,"Lote"' + #13);
  vlComandos.Add('A30,305,0,3,1,2,N,"' + Self.Lote + '"' + #13); // Lote

  vlComandos.Add('LO420,270,3,80' + #13); // Coluna 1
  vlComandos.Add('A435,280,0,2,1,1,N,"Vencimento"' + #13);
  vlComandos.Add('A440,305,0,3,1,2,N,"' + FormatDateTime('dd/mm/yy', Self.DataVencimento) + '"' + #13); // Data de Vencimento do Lote

  vlComandos.Add('LO650,270,3,80' + #13); // Coluna 2
  vlComandos.Add('A665,280,0,2,1,1,N,"Qtd."' + #13);
  vlComandos.Add('A670,305,0,3,1,2,N,"' + Format('%.5d', [Self.Quantidade]) + '"' + #13); // Quantidade

  vlComandos.Add('LO10,350,760,3' + #13); // Linha 4

  vlComandos.Add('A25,360,0,2,1,1,N,"Endereco"' + #13);
  vlComandos.Add('A30,390,0,3,2,3,N,"' + AplicarMascara(Self.EnderecoEstoque, Self.MascaraEnderecoEstoque) + '"' + #13); // Localização do Produto

  vlComandos.Add('LO420,350,3,100' + #13); // Coluna 2
  vlComandos.Add('B440,360,0,1,2,3,50,B,"' + Format('%.9d', [Self.CodigoVolume]) + '"' + #13); // Código do Volume

  vlComandos.Add('LO10,450,760,3' + #13); // Linha 5

  vlComandos.Add('A25,460,0,2,1,2,N,"Obs: End.: ' + AplicarMascara(Self.EnderecoProduto, Self.MascaraEnderecoProduto) + ' ' + Self.Observacao + '"' + #13);

  vlComandos.Add('LO10,495,760,3' + #13); // Linha 6

  vlComandos.Add('A25,510,0,3,3,3,N,"CAIXA FECHADA"' + #13);
  vlComandos.Add('A640,550,0,4,1,1,N,"Linx WMS"' + #13);

  vlComandos.Add('P1' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaCaixaFechada.ComandosZebraZPL2: TStringList;
var
  vlComandos: TStringList;
  vlCodigoProduto: string;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('^XA'); // Inicia a impressão
  vlComandos.Add('^MMT'); // Informa para a impressora avaçar a etiqueta ao final da impressão

  vlComandos.Add('^FO20,30^GB760,580,3^FS'); // Moldura

  vlComandos.Add('^FO30,40^A0N,60,50^FDN:^FS');
  vlComandos.Add('^FO80,40^A0N,60,50^FD' + IntToStr(Self.CodigoSaida) + '^FS'); // Código da Saída

  vlComandos.Add('^FO580,30^GB000,070,3^FS');
  vlComandos.Add('^FO590,40^A0N,17,17^FDData^FS');
  vlComandos.Add('^FO600,60^A0N,35,35^FD' + FormatDateTime('dd/mm/yy', Self.DataSaida) + '^FS'); // Data da Saída

  vlComandos.Add('^FO20,100^GB760,000,3^FS'); // Linha 1

  vlComandos.Add('^FO30,110^A0N,17,17^FDRota^FS');
  vlComandos.Add('^FO40,135^A0N,110,110^FD' + IntToStr(Self.CodigoRota) + '^FS'); // Código da Rota

  vlComandos.Add('^FO230,100^GB000,130,3^FS'); // Coluna 1
  vlComandos.Add('^FO240,110^A0N,17,17^FDCliente^FS');
  vlComandos.Add('^FO250,135^A0N,110,110^FD' + IntToStr(Self.CodigoCliente) + '^FS'); // Código do Cliente

  vlComandos.Add('^FO430,100^GB000,130,3^FS'); // Coluna 2
  vlComandos.Add('^FO440,110^A0N,17,17^FDVolume^FS');
  vlComandos.Add('^FO450,150^A0N,70,60^FD' + IntToStr(Self.NumeroVolume) + '^FS'); // Número do Volume

  vlComandos.Add('^FO20,230^GB760,000,3^FS'); // Linha 2

  vlCodigoProduto := IntToStr(Self.CodigoProduto);

  while (Length(vlCodigoProduto) < 6) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('^FO30,240^A0N,17,17^FDProduto^FS');
  vlComandos.Add('^FO40,260^A0N,25,25^FD' + vlCodigoProduto + ' - ' + Self.NomeProduto + '^FS'); // Produto

  vlComandos.Add('^FO20,285^GB760,000,3^FS'); // Linha 3

  vlComandos.Add('^FO30,295^A0N,17,17^FDLote^FS');
  vlComandos.Add('^FO40,315^A0N,45,40^FD' + Self.Lote + '^FS'); // Lote

  vlComandos.Add('^FO430,285^GB000,75,3^FS'); // Coluna 1
  vlComandos.Add('^FO440,295^A0N,17,17^FDVencimento^FS');
  vlComandos.Add('^FO450,315^A0N,45,40^FD' + FormatDateTime('dd/mm/yy', Self.DataVencimento) + '^FS'); // Data de Vencimento do Lote

  vlComandos.Add('^FO650,285^GB000,75,3^FS'); // Coluna 2
  vlComandos.Add('^FO660,295^A0N,17,17^FDQtd.^FS');
  vlComandos.Add('^FO670,315^A0N,45,40^FD' + Format('%.5d', [Self.Quantidade]) + '^FS'); // Quantidade

  vlComandos.Add('^FO20,360^GB760,000,3^FS'); // Linha 4

  vlComandos.Add('^FO30,370^A0N,17,17^FDEndereco^FS');
  vlComandos.Add('^FO40,400^A0N,90,70^FD' + AplicarMascara(Self.EnderecoEstoque, Self.MascaraEnderecoEstoque) + '^FS'); // Localização do Produto

  vlComandos.Add('^FO430,360^GB000,120,3^FS'); // Coluna 2
  vlComandos.Add('^FO460,380^BY2^BCN,60,Y,N,N^FD' + Format('%.9d', [Self.CodigoVolume]) + '^FS'); // Código do Volume

  vlComandos.Add('^FO20,480^GB760,000,3^FS'); // Linha 5

  vlComandos.Add('^FO30,500^A0N,25,25^FDObs.: End.: ' + AplicarMascara(Self.EnderecoProduto, Self.MascaraEnderecoProduto) + ' ' + Self.Observacao + '^FS');

  vlComandos.Add('^FO20,530^GB760,000,3^FS'); // Linha 6

  vlComandos.Add('^FO30,550^A0N,60,70^FDCAIXA FECHADA^FS');
  vlComandos.Add('^FO660,570^A0N,25,25^FDLinx WMS^FS');

  vlComandos.Add('^XZ'); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaCaixaFechada.getEnderecoEstoque: string;
begin
  if (Self.FEnderecoEstoque = 'Área de Espera') then
    begin
      Result := 'Area Espera'
    end
  else
    begin
      Result := Self.FEnderecoEstoque;
    end;

  Result := Copy(Result, 0, 12);
end;

end.

