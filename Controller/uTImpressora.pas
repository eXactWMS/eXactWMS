unit uTImpressora;

interface

uses uTEtiqueta;

type
  TImpressaoStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class function ListarStatus: OleVariant;
  end;

  TImpressora = class
    private
      FModelo: TImpressoraModelo;
      FPorta: string;
    public
      property Modelo: TImpressoraModelo  read FModelo    write FModelo;
      property Porta: string              read FPorta     write FPorta;

      procedure Imprimir(pEtiqueta: TEtiqueta);
  end;

implementation

uses
  SysUtils, System.Classes, uDmConfig;

{ TImpressora }

procedure TImpressora.Imprimir(pEtiqueta: TEtiqueta);
var
  vlArquivo  : TextFile;
  vlComandos : TStringList;
begin
  vlComandos := pEtiqueta.Comandos(FModelo);
  try
    try
      AssignFile(vlArquivo, FPorta);
      Rewrite(vlArquivo);
      Writeln(vlArquivo, vlComandos.Text);
      CloseFile(vlArquivo);
      Sleep(500);
    except
      raise Exception.Create('Falha ao imprimir etiqueta('+FPorta+')!' + #13 +
                             'Verifique as configurações da estação em:' + #13 + #13 +
                             'Configurar \ Estação');
    end;
  finally
    FreeAndNil(vlComandos);
  end;
end;

class function TImpressaoStatus.ListarStatus: OleVariant;
begin
  DmConfig.qryListarImprStatus.Close;
  dmConfig.qryListarImprStatus.Open;

  Result := dmConfig.dspListarImprStatus.Data;
end;

end.
