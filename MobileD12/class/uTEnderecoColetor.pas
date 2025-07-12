unit uTEnderecoColetor;

interface

uses SysUtils, uTHistorico, uTProdutoControle;

Type
{$Region Tipos de Endereco}
  TEnderecoTipo = class
    private
      FCodigo   : Integer;
      FNome    : string;
      FMascara : String;
    public
      property Codigo  : Integer  read FCodigo  write FCodigo;
      property Nome    : string   read FNome    write FNome;
      Property Mascara : String   Read FMascara Write FMascara;
      class function ListarEnderecoTipo: OleVariant;
      class function PegarEnderecoTipo(pCodigo: Integer): TEnderecoTipo;
      class function Pesquisar(pCodigo, pNome : string): OleVariant;
      procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
  end;
{$EndRegion}

{$Region Setores de Endereços}
  TEnderecoSetor = Class
    private
      FCodigo  : Integer;
      FNome    : string;
      FProdutoControle : TProdutoControle;
      procedure SetProdutoControle(Const Value : TProdutoControle);
    public
      constructor Create(cCodigo : Integer = 0;
                         cNome: string = '';
                         cProdutoControle : TProdutoControle = Nil); Reintroduce;
      destructor Destroy; override;
    Published
      property Codigo: Integer                    read FCodigo          write FCodigo;
      property Nome: string                       read FNome            write FNome;
      Property ProdutoControle : TPRodutoControle Read FProdutoControle Write SetProdutoControle;

      class function Pesquisar(pCodigo, pNome, pTipoEndereco: string) : OleVariant;
      class function PegarSetor(pCodigo: Integer; PNome : String = ''; pTipoSetor : String = ''): TEnderecoSetor;
      procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
      class function ListarEnderecoSetor: OleVariant; static;
  End;
{$EndRegion}

{$Region Ruas de Endereços}
  TEnderecoRua = class
    private
      FCodigo : Integer;
      FNome   : string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;
      class function ListarEnderecoRua: OleVariant;
      class function GetEnderecoRua(pCodigo: Integer = 0; pNome : String = ''): TEnderecoTipo;
      procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
  end;

  TArrayListaEnderecoRua = Array Of TEnderecoRua;

  TListaEnderecoRua = Class
  private
    FItems: TArrayListaEnderecoRua;
    procedure SetItems(const Value: TArrayListaEnderecoRua);
    Published
      Property Items : TArrayListaEnderecoRua read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TEnderecoRua) : Integer;
  End;
{$EndRegion}

{$Region Endereços}
  TEnderecoColetor = class
    private
      FCodigo   : Integer;
      FEndereco : string;
      FEnderecoFormatado : String;
      FRua      : TEnderecoRua;
      FSetor    : TEnderecoSetor;
      FTipo     : TEnderecoTipo;
      FStatus   : Boolean;
      Function GetEnderecoFormatado : String;
      Procedure SetEnderecoFormatado(Const Value : String);
      procedure setRua(Const Value: TEnderecoRua);
      procedure setSetor(Const Value: TEnderecoSetor);
      procedure setTipo(Const Value: TEnderecoTipo);
    public
      property Codigo   : Integer        read FCodigo    write FCodigo;
      //property Endereco : string         read FEndereco  write FEndereco;
      Property Endereco : String Read GetEnderecoFormatado Write SetEnderecoFormatado;
     	Property EnderecoFor : String      Read FEnderecoFormatado Write FEnderecoFormatado;
      property Rua      : TEnderecoRua   read FRua       write setRua;
      property Setor    : TEnderecoSetor Read FSetor     write setSetor;
      property Tipo     : TEnderecoTipo  Read FTipo      write setTipo;
      Property Status   : Boolean        Read FStatus    Write FStatus;

      destructor Destroy; override;

      class function FormatarEndereco(pEndereco, pMascara: string): string;
      class function ListarEnderecamento(pCodigoSetor: string; pStatus: Integer): OleVariant;
      class function GetEnderecoOcupacao(pCodigoSetor, pSituacao, pEnderecoInicial, PEnderecoFinal : string): OleVariant;
      class function ListarEnderecos(pEndInicial, pEndFinal: string; pTipo: Integer): OleVariant;
      Class Function ListarEnderecoResumida(Filtro : String) : OleVariant;
      class function PegarEndereco(pCodigo: Integer; pNome : String = ''): TEnderecoColetor; OverLoad;
      Class Function PesquisarSetor(pCdEndereco, pSetor : Integer; pEndereco : String): OleVariant;
      class function Pesquisar(pCdEndereco, pCdSetor : Integer; pNome, pSetor: string): OleVariant; OverLoad;
      class function Pesquisar(pNome: string): OleVariant; OverLoad;

      function EnderecoFormatado(pMascara: string): string;
      Procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
  End;
  TArrayListaEndereco = Array Of TEnderecoColetor;

  TListaEndereco = Class
  private
    FItems: TArrayListaEndereco;
    procedure SetItems(const Value: TArrayListaEndereco);
    Published
      Property Items : TArrayListaEndereco read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TEnderecoColetor) : Integer;
  End;
{$EndRegion}


implementation

{ TEnderecoSetor }

constructor TEnderecoSetor.Create(cCodigo: Integer; cNome: string;
  cProdutoControle : TProdutoControle);
begin
  Inherited Create;
  FCodigo := cCodigo;
  FNome   := cNome;
  FProdutoControle := cProdutoControle;
end;

destructor TEnderecoSetor.Destroy;
begin
  if Assigned(FProdutoControle) then
     FreeAndNil(FProdutoControle);
  inherited;
end;

class procedure TEnderecoSetor.Excluir(pCodigo: Integer;
  pHistorico: THistorico);
begin

end;

class function TEnderecoSetor.ListarEnderecoSetor: OleVariant;
begin

end;

class function TEnderecoSetor.PegarSetor(pCodigo: Integer; PNome,
  pTipoSetor: String): TEnderecoSetor;
begin

end;

class function TEnderecoSetor.Pesquisar(pCodigo, pNome,
  pTipoEndereco: string): OleVariant;
begin

end;

procedure TEnderecoSetor.Salvar(pHistorico: THistorico);
begin

end;

procedure TEnderecoSetor.SetProdutoControle(Const Value : TProdutoControle);
begin
  FProdutoControle := Value;
end;

{ TEnderecoTipo }

class procedure TEnderecoTipo.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin

end;

class function TEnderecoTipo.ListarEnderecoTipo: OleVariant;
begin

end;

class function TEnderecoTipo.PegarEnderecoTipo(pCodigo: Integer): TEnderecoTipo;
begin

end;

class function TEnderecoTipo.Pesquisar(pCodigo, pNome: string): OleVariant;
begin

end;

procedure TEnderecoTipo.Salvar(pHistorico: THistorico);
begin

end;

{ TEndereco }

destructor TEnderecoColetor.Destroy;
begin

  inherited;
end;

function TEnderecoColetor.EnderecoFormatado(pMascara: string): string;
begin

end;

class procedure TEnderecoColetor.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin

end;

class function TEnderecoColetor.FormatarEndereco(pEndereco, pMascara: string): string;
begin

end;

Function TEnderecoColetor.GetEnderecoFormatado : String;
begin
  Result := FEndereco;
  SetEnderecoFormatado(FEndereco);
  Result := FEndereco;
end;

class function TEnderecoColetor.GetEnderecoOcupacao(pCodigoSetor, pSituacao,
  pEnderecoInicial, PEnderecoFinal: string): OleVariant;
begin

end;

class function TEnderecoColetor.ListarEnderecamento(pCodigoSetor: string;
  pStatus: Integer): OleVariant;
begin

end;

class function TEnderecoColetor.ListarEnderecoResumida(Filtro: String): OleVariant;
begin

end;

class function TEnderecoColetor.ListarEnderecos(pEndInicial, pEndFinal: string;
  pTipo: Integer): OleVariant;
begin

end;

class function TEnderecoColetor.PegarEndereco(pCodigo: Integer;
  pNome: String): TEnderecoColetor;
begin
end;

class function TEnderecoColetor.Pesquisar(pCdEndereco, pCdSetor: Integer; pNome,
  pSetor: string): OleVariant;
begin

end;

class function TEnderecoColetor.Pesquisar(pNome: string): OleVariant;
begin

end;

class function TEnderecoColetor.PesquisarSetor(pCdEndereco, pSetor: Integer;
  pEndereco: String): OleVariant;
begin

end;

procedure TEnderecoColetor.Salvar(pHistorico: THistorico);
begin

end;

procedure TEnderecoColetor.SetEnderecoFormatado(const Value: String);
begin
  FEndereco := Value;
  if Value <> '' then
     FEnderecoFormatado := Copy(Value,1,2)+'.'+copy(Value,3,2)+'.'+Copy(Value,5,2)+'.'+Copy(Value,7,3);
end;

procedure TEnderecoColetor.setRua(const Value : TEnderecoRua);
begin
  FRua := Value;
end;

procedure TEnderecoColetor.setSetor(const Value: TEnderecoSetor);
begin
  FSetor := Value;
end;

procedure TEnderecoColetor.setTipo(const Value: TEnderecoTipo);
begin
  FTipo:= Value;
end;

{ TEnderecoRua }

class procedure TEnderecoRua.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin

end;

class function TEnderecoRua.GetEnderecoRua(pCodigo: Integer;
  pNome: String): TEnderecoTipo;
begin

end;

class function TEnderecoRua.ListarEnderecoRua: OleVariant;
begin

end;

procedure TEnderecoRua.Salvar(pHistorico: THistorico);
begin

end;

{ TListaEnderecoRua }

function TListaEnderecoRua.Add(Item: TEnderecoRua): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaEnderecoRua.SetItems(const Value: TArrayListaEnderecoRua);
begin
  Fitems := Value;
end;

function TListaEnderecoRua.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TListaEndereco }

function TListaEndereco.Add(Item: TEnderecoColetor): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaEndereco.SetItems(const Value: TArrayListaEndereco);
begin
  FItems := Value;
end;

function TListaEndereco.Size: Integer;
begin
  Result := Length(FItems);
end;

end.
