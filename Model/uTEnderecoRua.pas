unit uTEnderecoRua;

interface

type
  TEnderecoRua = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;
  end;

implementation

end.
