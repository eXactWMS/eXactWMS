unit uTEtiquetaArmazenagem;

interface

uses uTEtiqueta, Classes;

type
  TEtiquetaArmazenagem = class(TEtiqueta)
  private
    FFornecedor: string;
    FNotaFiscal: string;
    FDataEntrada: TDateTime;
    FCodigoProduto: Int64;
    FProduto: string;
    FLote: string;
    FDataFabricacao: TDateTime;
    FDataVencimento: TDateTime;
    FQuantidade: Integer;
    FEndereco: string;
    FMascara: string;
  protected
    function ComandosDataMax: TStringList; override;
    function ComandosZebraEPL2: TStringList; override;
    function ComandosZebraZPL2: TStringList; override;

    function getFornecedor: string;
  public
    property Fornecedor: string         read getFornecedor    write FFornecedor;
    property NotaFiscal: string         read FNotaFiscal      write FNotaFiscal;
    property DataEntrada: TDateTime     read FDataEntrada     write FDataEntrada;
    property CodigoProduto: Int64       read FCodigoProduto   write FCodigoProduto;
    property Produto: string            read FProduto         write FProduto;
    property Lote: string               read FLote            write FLote;
    property DataFabricacao: TDateTime  read FDataFabricacao  write FDataFabricacao;
    property DataVencimento: TDateTime  read FDataVencimento  write FDataVencimento;
    property Quantidade: Integer        read FQuantidade      write FQuantidade;
    property Endereco: string           read FEndereco        write FEndereco;
    property Mascara: string            read FMascara         write FMascara;
  end;

implementation

uses
  SysUtils, uFuncoes;

{ TEtiquetaArmazenagem }

function TEtiquetaArmazenagem.ComandosDataMax: TStringList;
var
  vlComandos: TStringList;
  vlCodigoProduto: string;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add(#2 + 'L' + #13); // Inicializa a impressão

  vlComandos.Add('1X1100000030020B380290002002'); // Moldura

  vlComandos.Add('1911S0102820025P003P003Fornecedor' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102700030P004P003' + Self.Fornecedor + #13); // Nome do Fornecedor
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002650265L002028' + #13); // Coluna 1
  vlComandos.Add('1911S0102820270P003P003Nota Fiscal' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102700275P004P003' + Self.NotaFiscal + #13); // Número da Nota Fiscal
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002650335L002028' + #13); // Coluna 2
  vlComandos.Add('1911S0102820340P003P003Dt. Entrada' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102700345P004P003' + FormatDateTime('dd/mm/yy', Self.DataEntrada) + #13); // Data da Entrada
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002630021L379002' + #13); // Linha 1

  vlCodigoProduto := IntToStr(FCodigoProduto);

  while (Length(vlCodigoProduto) < 6) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('1911S0102540025P003P003Produto' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102410030P005P004' + vlCodigoProduto + ' - ' + Self.Produto + #13); // Produto
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002340021L379002' + #13); // Linha 2

  vlComandos.Add('1911S0102250025P003P003Lote' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102100030P005P004' + Self.Lote + #13); // Lote
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002050180L002030' + #13); // Coluna 1
  vlComandos.Add('1911S0102250185P003P003Fabricacao' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102100190P005P004' + FormatDateTime('dd/mm/yy', Self.DataFabricacao) + #13); // Data de Fabricação
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002050260L002030' + #13); // Coluna 1
  vlComandos.Add('1911S0102250265P003P003Vencimento' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102100270P005P004' + FormatDateTime('dd/mm/yy', Self.DataVencimento) + #13); // Data de Vencimento
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002050340L002030' + #13); // Coluna 2
  vlComandos.Add('1911S0102250345P003P003Qtd.' + #13);
  vlComandos.Add('FB+' + #13);
  vlComandos.Add('1911S0102100350P005P004' + IntToStr(Self.Quantidade) + #13); // Quantidade
  vlComandos.Add('FB-' + #13);

  vlComandos.Add('1X1100002040021L379002' + #13); // Linha 3
  vlComandos.Add('FB+' + #13);

  if (Length(FEndereco) <= 5) then // Verifica se o Endereço tem menos de 5 caracteres
    begin
      vlComandos.Add('1911S0100900030P050P037' + AplicarMascara(Self.Endereco, Self.Mascara) + #13); // Localização do Produto
    end
  else
    begin
      vlComandos.Add('1911S0100900030P050P020' + AplicarMascara(Self.Endereco, Self.Mascara) + #13); // Localização do Produto
    end;

  vlComandos.Add('FB-' + #13);

  while (Length(vlCodigoProduto) < 15) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('1E1103000250110' + vlCodigoProduto + #13); // Código do Produto

  vlComandos.Add('1911S0100100340P004P004X3 WMS' + #13); // X3 WMS

  vlComandos.Add('Q0001' + #13); // Quantidade de etiquetas
  vlComandos.Add('E' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaArmazenagem.ComandosZebraEPL2: TStringList;
var
  vlComandos: TStringList;
  vlCodigoProduto: string;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('N' + #13); // Inicia a impressão

  vlComandos.Add('X10,10,4,770,580'); // Moldura

  vlComandos.Add('A25,20,0,2,1,1,N,"Fornecedor"' + #13);
  vlComandos.Add('A30,45,0,2,1,1,N,"' + Self.Fornecedor + '"' + #13); // Nome do Fornecedor

  vlComandos.Add('LO430,10,4,60' + #13); // Coluna 1
  vlComandos.Add('A445,20,0,2,1,1,N,"Nota Fiscal"' + #13);
  vlComandos.Add('A450,45,0,2,1,1,N,"' + Self.NotaFiscal + '"' + #13); // Número da Nota Fiscal

  vlComandos.Add('LO600,10,4,60' + #13); // Coluna 2
  vlComandos.Add('A615,20,0,2,1,1,N,"Dt. Entrada"' + #13);
  vlComandos.Add('A620,45,0,2,1,1,N,"' + FormatDateTime('dd/mm/yy', Self.DataEntrada) + '"' + #13); // Data da Entrada

  vlComandos.Add('LO10,70,760,4' + #13); // Linha 1

  vlCodigoProduto := IntToStr(FCodigoProduto);

  while (Length(vlCodigoProduto) < 6) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('A25,80,0,2,1,1,N,"Produto"' + #13);
  vlComandos.Add('A30,105,0,3,1,1,N,"' + vlCodigoProduto + ' - ' + Self.Produto + '"' + #13); // Produto

  vlComandos.Add('LO10,130,760,4' + #13); // Linha 2

  vlComandos.Add('A25,140,0,2,1,1,N,"Lote"' + #13);
  vlComandos.Add('A30,165,0,3,1,1,N,"' + Self.Lote + '"' + #13); // Lote

  vlComandos.Add('LO325,130,4,60' + #13); // Coluna 1
  vlComandos.Add('A340,140,0,2,1,1,N,"Fabricacao"' + #13);
  vlComandos.Add('A345,165,0,3,1,1,N,"' + FormatDateTime('dd/mm/yy', Self.DataFabricacao) + '"' + #13); // Data de Fabricação

  vlComandos.Add('LO495,130,4,60' + #13); // Coluna 1
  vlComandos.Add('A510,140,0,2,1,1,N,"Vencimento"' + #13);
  vlComandos.Add('A515,165,0,3,1,1,N,"' + FormatDateTime('dd/mm/yy', Self.DataVencimento) + '"' + #13); // Data de Vencimento

  vlComandos.Add('LO670,130,4,60' + #13); // Coluna 2
  vlComandos.Add('A685,140,0,2,1,1,N,"Qtd."' + #13);
  vlComandos.Add('A690,165,0,3,1,1,N,"' + IntToStr(Self.Quantidade) + '"' + #13); // Quantidade

  vlComandos.Add('LO10,190,760,4' + #13); // Linha 3

  if (Length(FEndereco) <= 5) then // Verifica se o Endereço tem menos de 5 caracteres
    begin
      vlComandos.Add('A100,230,0,4,6,9,N,"' + AplicarMascara(Self.Endereco, Self.Mascara) + '"' + #13); // Localização do Produto
    end
  else
    begin
      vlComandos.Add('A100,230,0,4,3,9,N,"' + AplicarMascara(Self.Endereco, Self.Mascara) + '"' + #13); // Localização do Produto
    end;

  while (Length(vlCodigoProduto) < 15) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('B180,440,0,1,3,4,70,B,"' + vlCodigoProduto + '"' + #13); // Código do Produto

  vlComandos.Add('A640,550,0,4,1,1,N,"X3 WMS"' + #13); // X3 WMS

  vlComandos.Add('P1' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaArmazenagem.ComandosZebraZPL2: TStringList;
var
  vlComandos: TStringList;
  vlCodigoProduto: string;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('^XA'); // Inicia a impressão
  vlComandos.Add('^MMT'); // Informa para a impressora avaçar a etiqueta ao final da impressão

  vlComandos.Add('^FO20,30^GB760,580,3^FS'); // Moldura

  vlComandos.Add('^FO30,40^A0N,17,17^FDFornecedor^FS');
  vlComandos.Add('^FO40,60^A0N,25,25^FD' + Self.Fornecedor + '^FS'); // Nome do Fornecedor

  vlComandos.Add('^FO490,30^GB000,060,3^FS'); // Coluna 1
  vlComandos.Add('^FO500,40^A0N,17,17^FDNota Fiscal^FS');
  vlComandos.Add('^FO510,60^A0N,25,25^FD' + Self.NotaFiscal + '^FS'); // Número da Nota Fiscal

  vlComandos.Add('^FO640,30^GB000,060,3^FS' + #13); // Coluna 2
  vlComandos.Add('^FO650,40^A0N,17,17^FDDt. Entrada^FS');
  vlComandos.Add('^FO660,60^A0N,25,25^FD' + FormatDateTime('dd/mm/yy', Self.DataEntrada) + '^FS'); // Data da Entrada

  vlComandos.Add('^FO020,090^GB760,000,3^FS'); // Linha 1

  vlCodigoProduto := IntToStr(FCodigoProduto);

  while (Length(vlCodigoProduto) < 6) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('^FO30,100^A0N,17,17^FDProduto^FS');
  vlComandos.Add('^FO40,120^A0N,25,25^FD' + vlCodigoProduto + ' - ' + Self.Produto + '^FS'); // Produto

  vlComandos.Add('^FO020,150^GB760,000,3^FS'); // Linha 2

  vlComandos.Add('^FO30,160^A0N,17,17^FDLote^FS');
  vlComandos.Add('^FO40,180^A0N,25,25^FD' + Self.Lote + '^FS'); // Lote

  vlComandos.Add('^FO350,150^GB000,060,3^FS'); // Coluna 1
  vlComandos.Add('^FO360,160^A0N,17,17^FDFabricacao^FS');
  vlComandos.Add('^FO370,180^A0N,25,25^FD' + FormatDateTime('dd/mm/yy', Self.DataFabricacao) + '^FS'); // Data de Fabricação

  vlComandos.Add('^FO510,150^GB000,060,3^FS'); // Coluna 1
  vlComandos.Add('^FO520,160^A0N,17,17^FDVencimento^FS');
  vlComandos.Add('^FO530,180^A0N,25,25^FD' + FormatDateTime('dd/mm/yy', Self.DataVencimento) + '^FS'); // Data de Vencimento

  vlComandos.Add('^FO660,150^GB000,060,3^FS'); // Coluna 2
  vlComandos.Add('^FO670,160^A0N,17,17^FDQtd.^FS');
  vlComandos.Add('^FO680,180^A0N,25,25^FD' + IntToStr(Self.Quantidade) + '^FS'); // Quantidade

  vlComandos.Add('^FO020,210^GB760,000,3^FS'); // Linha 3

  if (Length(FEndereco) <= 5) then // Verifica se o Endereço tem menos de 5 caracteres
    begin
      vlComandos.Add('^FO030,230^A0N,290,270^FD' + AplicarMascara(Self.Endereco, Self.Mascara) + '^FS'); // Localização do Produto
    end
  else
    begin
      vlComandos.Add('^FO040,250^A0N,250,140^FD' + AplicarMascara(Self.Endereco, Self.Mascara) + '^FS'); // Localização do Produto
    end;

  while (Length(vlCodigoProduto) < 15) do
    begin
      vlCodigoProduto := '0' + vlCodigoProduto;
    end;

  vlComandos.Add('^FO200,490^BY2^BCN,060,Y,N,N^FD' + vlCodigoProduto + '^FS'); // Código do Produto

  vlComandos.Add('^FO670,580^A0N,20,20^FDX3 WMS^FS'); // X3 WMS

  vlComandos.Add('^XZ'); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaArmazenagem.getFornecedor: string;
begin
  Result := Copy(Self.FFornecedor, 0, 35);
end;

end.
