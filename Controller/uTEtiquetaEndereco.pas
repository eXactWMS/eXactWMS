unit uTEtiquetaEndereco;

interface

uses uTEtiqueta, Classes;

type
  TEtiquetaEnderecoTipo = (etEndereco, etCodigo, etProduto);
  TEtiquetaEnderecoTamanho = (etPequena, etMedia, etGrande);

  TEtiquetaEndereco = class (TEtiqueta)
  private
    FTipo: TEtiquetaEnderecoTipo;
    FTamanho: TEtiquetaEnderecoTamanho;
    FEndereco: string;
    FCodBarras: string;
    FProduto: string;
  protected
    function ComandosDataMax: TStringList; override;
    function ComandosZebraEPL2: TStringList; override;
    function ComandosZebraZPL2: TStringList; override;
  public
    property Tipo: TEtiquetaEnderecoTipo        read FTipo      write FTipo;
    property Tamanho: TEtiquetaEnderecoTamanho  read FTamanho   write FTamanho;
    property Endereco: string                   read FEndereco  write FEndereco;
    property CodBarras: string                  read FCodBarras write FCodBarras;
    property Produto: string                    read FProduto   write FProduto;
  end;

implementation

{ TEtiquetaEndereco }

function TEtiquetaEndereco.ComandosDataMax: TStringList;
var
  vlComandos: TStringList;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add(#2 + 'L' + #13); // Inicia o desenho da etiqueta

  case Self.Tipo of
    etEndereco: // Etiqueta apenas com o Endereço
      begin
        vlComandos.Add('FB+' + #13);

        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              case Length(Self.Endereco) of
                6: vlComandos.Add('1911S0100350120P030P020' + Self.Endereco + #13); // Padrão 99.999
                9: vlComandos.Add('1911S0100350060P025P020' + Self.Endereco + #13); // Padrão X.999.999

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('1911S0100350030P030P018' + Self.Endereco + #13);
                  end;
              end;

              vlComandos.Add('FB-' + #13);

              vlComandos.Add('4911S0100400395P005P004Rhemasys' + #13);
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              case Length(Self.Endereco) of
                6: vlComandos.Add('1911S0100500090P040P025' + Self.Endereco + #13); // Padrão 99.999
                9: vlComandos.Add('1911S0100450035P040P025' + Self.Endereco + #13); // Padrão X.999.999

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('1911S0100500040P040P018' + Self.Endereco + #13);
                  end;
              end;

              vlComandos.Add('FB-' + #13);

              vlComandos.Add('4911S0100400395P005P004Rhemasys' + #13);
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              case Length(Self.Endereco) of
                6: vlComandos.Add('1911S0101000045P055P035' + Self.Endereco + #13); // Padrão 99.999
                9: vlComandos.Add('1911S0101000035P050P025' + Self.Endereco + #13); // Padrão X.999.999

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('1911S0101000030P050P020' + Self.Endereco + #13);
                  end;
              end;

              vlComandos.Add('FB-' + #13);

              vlComandos.Add('1911S0100100345P005P004Rhemasys' + #13);
            end;
        end;
      end;

    etCodigo: // Etiqueta com Endereço e Código de Barras
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100350030P020P015' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1103000300250' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100350030P020P015' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1103000300250' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100350030P020P011' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1103000300240' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('4911S0100400395P005P004Rhemasys' + #13);
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100900090P040P025' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1204000250120' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100850035P040P025' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1204000150090' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100850050P040P018' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1204000150080' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('4911S0100400395P005P004Rhemasys' + #13);
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0101500070P050P030' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1207000400120' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0101500035P050P025' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1207000400090' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0101500035P050P020' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1207000400085' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('1911S0100100345P005P004Rhemasys' + #13);
            end;
        end;
      end;

    etProduto: // Etiqueta com Endereço, Código de Barras e Produto
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100400030P020P015' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1103000350250' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100400030P020P015' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1103000350250' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100400030P020P011' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1103000350240' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('FB+' + #13);
              vlComandos.Add('1911S0100150030P006P004' + Self.Produto + #13);
              vlComandos.Add('FB-' + #13);

              vlComandos.Add('4911S0100400395P005P004Rhemasys' + #13);
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100900090P040P025' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1204000250120' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100900030P040P020' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1204000250080' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0100900030P040P020' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1204000250080' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('FB+' + #13);
              vlComandos.Add('1911S0100050020P006P004' + Self.Produto + #13);
              vlComandos.Add('FB-' + #13);

              vlComandos.Add('4911S0100400395P005P004Rhemasys' + #13);
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0101600070P050P030' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1206000700120' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0101600035P050P025' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1206000600090' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('FB+' + #13);
                    vlComandos.Add('1911S0101600030P040P020' + Self.Endereco + #13); // Endereço com Máscara
                    vlComandos.Add('FB-' + #13);
                    vlComandos.Add('1E1206000700085' + Self.CodBarras + #13); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('FB+' + #13);
              vlComandos.Add('1911S0100350030P006P004' + Self.Produto + #13);
              vlComandos.Add('FB-' + #13);

              vlComandos.Add('1911S0100100345P005P004Rhemasys' + #13);
            end;
        end;
      end;
  end;

  vlComandos.Add('Q0001' + #13); // Quantidade de etiquetas
  vlComandos.Add('E' + #13);     // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaEndereco.ComandosZebraEPL2: TStringList;
var
  vlComandos: TStringList;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('N' + #13); // Inicia a impressão

  case Self.Tipo of
    etEndereco: // Etiqueta apenas com o Endereço
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              vlComandos.Add('A660,40,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A100,80,0,4,3,5,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              vlComandos.Add('A660,40,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A100,130,0,4,3,5,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              vlComandos.Add('A660,30,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A100,150,0,4,3,9,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
            end;
        end;
      end;

    etCodigo: // Etiqueta com Endereço e Código de Barras
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              vlComandos.Add('A660,40,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A40,80,0,4,2,4,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
              vlComandos.Add('B460,80,0,1,3,7,80,N,"' + Self.CodBarras  + '"' + #13); // Código de Barras do Endereço
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              vlComandos.Add('A660,40,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A100,80,0,4,3,4,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
              vlComandos.Add('B100,180,0,1,5,7,150,N,"' + Self.CodBarras  + '"' + #13); // Código de Barras do Endereço
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              vlComandos.Add('A660,30,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A80,100,0,4,3,7,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
              vlComandos.Add('B80,260,0,1,5,7,130,N,"' + Self.CodBarras  + '"' + #13); // Código de Barras do Endereço
            end;
        end;
      end;

    etProduto: // Etiqueta com Endereço, Código de Barras e Produto
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              vlComandos.Add('A660,30,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A40,50,0,4,2,4,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
              vlComandos.Add('B460,50,0,1,3,7,80,N,"' + Self.CodBarras  + '"' + #13); // Código de Barras do Endereço
              vlComandos.Add('A40,160,0,4,1,2,N,"' + Self.Produto + '"' + #13); // Descrição do Produto
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              vlComandos.Add('A660,30,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A40,100,0,4,2,4,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
              vlComandos.Add('B460,100,0,1,3,7,80,N,"' + Self.CodBarras  + '"' + #13); // Código de Barras do Endereço
              vlComandos.Add('A40,220,0,4,1,3,N,"' + Self.Produto + '"' + #13); // Descrição do Produto
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              vlComandos.Add('A660,30,0,2,1,1,N,"Rhemasys"' + #13);
              vlComandos.Add('A80,80,0,4,3,5,N,"' + Self.Endereco + '"' + #13); // Endereço com Máscara
              vlComandos.Add('B80,220,0,1,5,7,100,N,"' + Self.CodBarras  + '"' + #13); // Código de Barras do Endereço
              vlComandos.Add('A80,350,0,4,1,3,N,"' + Self.Produto + '"' + #13); // Descrição do Produto
            end;
        end;
      end;
  end;

  vlComandos.Add('P1' + #13); // Finaliza a impressão

  Result := vlComandos;
end;

function TEtiquetaEndereco.ComandosZebraZPL2: TStringList;
var
  vlComandos: TStringList;
begin
  vlComandos := TStringList.Create;

  vlComandos.Add('^XA'); // Inicia a impressão
  vlComandos.Add('^MMT'); // Informa para a impressora avaçar a etiqueta ao final da impressão

  case Self.Tipo of
    etEndereco: // Etiqueta apenas com o Endereço
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              vlComandos.Add('^FO210,50^A0N,250,150^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
              vlComandos.Add('^FO750,100^A0B,30,30^FDRhemasys^FS');
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              vlComandos.Add('^FO630,30^A0N,30,30^FDRhemasys^FS');
              vlComandos.Add('^FO200,130^A0N,230,140^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              vlComandos.Add('^FO630,100^A0N,30,30^FDRhemasys^FS');
              vlComandos.Add('^FO100,320^A0N,250,150^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
            end;
        end;
      end;

    etCodigo: // Etiqueta com Endereço e Código de Barras
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              vlComandos.Add('^FO630,50^A0N,20,20^FDRhemasys^FS');
              vlComandos.Add('^FO60,100^A0N,140,80^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
              vlComandos.Add('^FO520,100^BY2,1,1^BCN,100,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              vlComandos.Add('^FO630,30^A0N,30,30^FDRhemasys^FS');
              vlComandos.Add('^FO200,130^A0N,230,140^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
              vlComandos.Add('^FO60,225^BY5,5,15^BCN,100,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              vlComandos.Add('^FO630,50^A0N,30,30^FDRhemasys^FS');
              vlComandos.Add('^FO100,150^A0N,250,150^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
              vlComandos.Add('^FO200,370^BY3,3,15^BCN,100,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
            end;
        end;
      end;

    etProduto: // Etiqueta com Endereço, Código de Barras e Produto
      begin
        case Self.Tamanho of
          etPequena: // Etiqueta Pequena (3 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('^FO40,50^A0N,210,130^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO450,60^BY2^BCN,120,N,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('^FO40,50^A0N,180,100^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO470,60^BY2^BCN,120,N,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('^FO40,50^A0N,170,75^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO460,60^BY2^BCN,120,N,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('^FO50,230^A0N,30,30^FD' + Self.Produto + '^FS'); // Código de Barras do Endereço
              vlComandos.Add('^FO750,80^A0B,30,30^FDRhemasys^FS');
            end;

          etMedia: // Etiqueta Média (5 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('^FO220,40^A0N,220,130^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO270,240^BY3,2,15^BCN,50,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('^FO140,40^A0N,220,130^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO230,240^BY3,2,15^BCN,50,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('^FO40,40^A0N,220,130^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO210,240^BY3,2,15^BCN,50,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('^FO50,350^A0N,30,30^FD' + Self.Produto + '^FS'); // Código de Barras do Endereço
              vlComandos.Add('^FO750,100^A0B,30,30^FDRhemasys^FS');
            end;

          etGrande: // Etiqueta Grande (8 x 10)
            begin
              case Length(Self.Endereco) of
                6: // Padrão 99.999
                  begin
                    vlComandos.Add('^FO200,150^A0N,250,150^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO280,370^BY3,3,15^BCN,100,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;

                9: // Padrão X.999.999
                  begin
                    vlComandos.Add('^FO110,150^A0N,250,150^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO230,370^BY3,3,15^BCN,100,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;

                else // Padrão 99.99.99.999 e outros
                  begin
                    vlComandos.Add('^FO50,150^A0N,250,135^FD' + Self.Endereco + '^FS'); // Endereço com Máscara
                    vlComandos.Add('^FO210,370^BY3,3,15^BCN,100,Y,N,N^FD' + Self.CodBarras + '^FS'); // Código de Barras do Endereço
                  end;
              end;

              vlComandos.Add('^FO60,550^A0N,30,30^FD' + Self.Produto + '^FS'); // Produto
              vlComandos.Add('^FO630,50^A0N,30,30^FDRhemasys^FS');
            end;
        end;
      end;
  end;

  vlComandos.Add('^XZ'); // Finaliza a impressão

  Result := vlComandos;
end;

end.

