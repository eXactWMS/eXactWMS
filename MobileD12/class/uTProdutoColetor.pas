unit uTProdutoColetor;

interface

uses SysUtils, uTHistorico, uTEnderecoColetor, uTProdutoControle;

type

{$Region Produto}
  TProdutoColetor = Class
    Private
      FProdutoId   : Int64;
      FCodigo      : Int64;
      FDescricao   : string;
      FEmbalagem   : Integer;
      FAltura      : Double;
      FLargura     : Double;
      FComprimento : Double;
      FVolume      : Double;
      FPeso        : Double;
      FLiquido     : Boolean;
      FEstoqueMinimo   : Integer;
      FEstoqueMaximo   : Integer;
      FQtdEstoque      : Integer;
      FQtdCrossDocking : Integer;
      FValidadeMinimaEntrada     : Integer;
      FDataValidadeMinimaEntrada : TDateTime;
      FValidadeMinimaSaida       : Integer;
      FDataValidadeMinimaSaida   : TDateTime;
  //    FFabricante: TFabricante;
      FControle: TProdutoControle;
      FCodigoEndereco: Integer;
      FEndereco: TEnderecoColetor;
      FCodigoEnderecoAntigo: Integer;
      FEnderecoAntigo: TEnderecoColetor;
      FEAN: string;
      FQtdEAN: Integer;

      procedure ValidarDados;
    Public
      Constructor Create(cCodigo : Int64 = 0; cDescricao : string = ''; cEmbalagem : Integer = 0;
                         cAltura : Integer = 0; cLargura : Integer = 0; cComprimento : Integer = 0;
                         cVolume : Integer = 0; cPeso : Integer = 0; cLiquido : Boolean = False;
                         cEstoqueMinimo : Integer = 0; cEstoqueMaximo : Integer = 0;
                         cQtdEstoque : Integer = 0; cQtdCrossDocking : Integer = 0;
                         cValidadeMinimaEntrada : Integer = 0; cDataValidadeMinimaEntrada : TDateTime = 0;
                         cValidadeMinimaSaida : Integer = 0; cDataValidadeMinimaSaida : TDateTime = 0;
                        //cFabricante : TFabricante = Nil;
                         cProdutoControle : TProdutoControle = Nil; cCodigoEndereco : Integer = 0;
                         cEndereco: TEnderecoColetor = Nil; cCodigoEnderecoAntigo : Integer = 0;
                         cEnderecoAntigo : TEnderecoColetor = Nil; cEAN : string = ''; cQtdEAN : Integer = 0); Reintroduce;
      destructor Destroy; override;

    Published
      Property Produtoid : Int64                      Read FProdutoId                   Write FProdutoId;
      property Codigo    : Int64                      read FCodigo                      write FCodigo;
      property Descricao : string                     read FDescricao                   write FDescricao;
      property Embalagem: Integer                     read FEmbalagem                   write FEmbalagem;
      property Altura: Double                         read FAltura                      write FAltura;
      property Largura: Double                        read FLargura                     write FLargura;
      property Comprimento: Double                    read FComprimento                 write FComprimento;
      property Volume: Double                         read FVolume                      Write FVolume;
      property Peso: Double                           read FPeso                        write FPeso;
      property Liquido: Boolean                       read FLiquido                     write FLiquido;
      property EstoqueMinimo  : Integer               read FEstoqueMinimo               write FEstoqueMinimo;
      property EstoqueMaximo  : Integer               read FEstoqueMaximo               write FEstoqueMaximo;
      Property QtdEstoque     : Integer               Read FQtdEstoque                  Write FQtdEstoque;
      Property QtdCrosDocking : Integer               Read FQtdCrossDocking             Write FQtdCrossDocking;

      property ValidadeMinimaEntrada: Integer         read FValidadeMinimaEntrada       write FValidadeMinimaEntrada;
      property DataValidadeMinimaEntrada: TDateTime   read FDataValidadeMinimaEntrada   write FDataValidadeMinimaEntrada;
      property ValidadeMinimaSaida: Integer           read FValidadeMinimaSaida         write FValidadeMinimaSaida;
      property DataValidadeMinimaSaida: TDateTime     read FDataValidadeMinimaSaida     write FDataValidadeMinimaSaida;
//      property Fabricante: TFabricante                read FFabricante                  write FFabricante;
      property Controle: TProdutoControle             read FControle                    write FControle;
      Property CodigoEndereco : Integer               Read FCodigoEndereco              Write FCodigoEndereco;
      property Endereco: TEnderecoColetor             read FEndereco                    write FEndereco;
      property EAN: string                            read FEAN                         write FEAN;
      property QtdEAN: Integer                        read FQtdEAN                      write FQtdEAN;

      class function ListarLotes(pCodigo: Int64): OleVariant;
      class function ListarEnderecos(pCodigo: Int64): OleVariant;
      class function ListarVincendos(pCodigoSetor, pDataInicial, pDataFinal: string): OleVariant;
      class function ListarProdutoSemMovimentacao(pCodigoSetor, pDataInicial,
        pDataFinal: string): OleVariant; static;
      class function PegarProduto(pCodigo: string): TProdutoColetor;
      Class Function ProductFound(pCodigo: string) : Int64;
      class function PegarProdutoConferencia(pCodigo: string): TProdutoColetor;
      class function PegarCadastro(pCodigo: string): TProdutoColetor;
      class function Pesquisar(pCodigo, pDescricao, pEndereco: string): OleVariant;
      class function PesquisarCadastro(pFiltros: OleVariant): OleVariant;
      class function RelatorioEstoqueGeral(pCodigo: string): OleVariant;

      function  CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
      function  EstoqueDisponivel: Integer;
      function  ListarSaidas(pCodigoEstacao: Integer): OleVariant;
      procedure Salvar(pHistorico: THistorico);
      Class Function GetProduto(pCdProduto : String; pNmProduto : String = '') : TProdutoColetor;
  End;

  TArrayListaProduto = Array Of TProdutoColetor;

  TListaProduto = Class
  private
    FItems: TArrayListaProduto;
    procedure SetItems(const Value: TArrayListaProduto);
    Published
      Property Items : TArrayListaProduto read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TProdutoColetor) : Integer;
  End;

  TArrayListaProdSaiProcessamento = Array Of TProdutoColetor;

  TListaProdSaiProcessamento = Class
  private
    FItems: TArrayListaProdSaiProcessamento;
    procedure SetItems(const Value: TArrayListaProdSaiProcessamento);
    Published
      Property Items : TArrayListaProdSaiProcessamento read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TProdutoColetor) : Integer;
  End;

{$EndRegion}

implementation

{ TListaProdutoControle }
function TProdutoColetor.CalcularVolume(pAltura, pLargura,
  pComprimento: Integer): Integer;
begin
  Result := pAltura * pLargura * pComprimento;
end;

constructor TProdutoColetor.Create(cCodigo: Int64; cDescricao: string; cEmbalagem, cAltura,
  cLargura, cComprimento, cVolume, cPeso: Integer; cLiquido: Boolean;
  cEstoqueMinimo, cEstoqueMaximo, cQtdEstoque, cQtdCrossDocking : Integer;
  cValidadeMinimaEntrada : Integer; cDataValidadeMinimaEntrada: TDateTime;
  cValidadeMinimaSaida : Integer; cDataValidadeMinimaSaida: TDateTime;
  cProdutoControle : TProdutoControle; cCodigoEndereco: Integer; cEndereco: TEnderecoColetor;
  cCodigoEnderecoAntigo: Integer; cEnderecoAntigo: TEnderecoColetor; cEAN: string;
  cQtdEAN: Integer);
begin
  FProdutoId   := 0;
  FCodigo      := cCodigo;
  FDescricao   := cDescricao;
  FEmbalagem   := cEmbalagem;
  FAltura      := cAltura;
  FLargura     := cLargura;
  FComprimento := cComprimento;
  FVolume      := cVolume;
  FPeso        := cPeso;
  FLiquido     := cLiquido;
  FEstoqueMinimo   := cEstoqueMinimo;
  FEstoqueMaximo   := cEstoqueMaximo;
  FQtdEstoque      := cQtdEstoque;
  FQtdCrossDocking := cQtdCrossDocking;
  FValidadeMinimaEntrada     := cValidadeMinimaEntrada;
  FDataValidadeMinimaEntrada := cDataValidadeMinimaEntrada;
  FValidadeMinimaSaida       := cValidadeMinimaSaida;
  FDataValidadeMinimaSaida   := cDataValidadeMinimaSaida;
//    FFabricante := cFabricante;
  FControle       := TProdutoControle.Create(0, ''); //cProdutoControle;
  FCodigoEndereco := cCodigoEndereco;
  FEndereco       := TEnderecoColetor.Create; //cEndereco;
  FCodigoEnderecoAntigo := cCodigoEnderecoAntigo;
  FEnderecoAntigo       := cEnderecoAntigo;
  FEAN            := cEan;
  FQtdEAN         := cQtdEan;
end;

destructor TProdutoColetor.Destroy;
begin
//  if Assigned(FFabricante) then FreeAndNil(FFabricante);
  if Assigned(FControle) then FreeAndNil(FControle);
  if Assigned(FEndereco) then FreeAndNil(FEndereco);
  if Assigned(FEnderecoAntigo) then FreeAndNil(FEnderecoAntigo);
  inherited;
end;

function TProdutoColetor.EstoqueDisponivel: Integer;
begin

end;

class function TProdutoColetor.GetProduto(pCdProduto: String;
  pNmProduto: String): TProdutoColetor;
begin

end;

class function TProdutoColetor.ListarEnderecos(pCodigo: Int64): OleVariant;
begin

end;

class function TProdutoColetor.ListarLotes(pCodigo: Int64): OleVariant;
begin

end;

class function TProdutoColetor.ListarProdutoSemMovimentacao(pCodigoSetor, pDataInicial,
  pDataFinal: string): OleVariant;
begin

end;

function TProdutoColetor.ListarSaidas(pCodigoEstacao: Integer): OleVariant;
begin

end;

class function TProdutoColetor.ListarVincendos(pCodigoSetor, pDataInicial,
  pDataFinal: string): OleVariant;
begin

end;

class function TProdutoColetor.PegarCadastro(pCodigo: string): TProdutoColetor;
begin

end;

class function TProdutoColetor.PegarProduto(pCodigo: string): TProdutoColetor;
begin

end;

class function TProdutoColetor.PegarProdutoConferencia(pCodigo: string): TProdutoColetor;
begin

end;

class function TProdutoColetor.Pesquisar(pCodigo, pDescricao,
  pEndereco: string): OleVariant;
begin

end;

class function TProdutoColetor.PesquisarCadastro(pFiltros: OleVariant): OleVariant;
begin

end;

class function TProdutoColetor.ProductFound(pCodigo: string): Int64;
begin

end;

class function TProdutoColetor.RelatorioEstoqueGeral(pCodigo: string): OleVariant;
begin

end;

procedure TProdutoColetor.Salvar(pHistorico: THistorico);
begin

end;

procedure TProdutoColetor.ValidarDados;
begin

end;

{ TListaProduto }

function TListaProduto.Add(Item: TProdutoColetor): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaProduto.SetItems(const Value: TArrayListaProduto);
begin
  FItems := Value;
end;

function TListaProduto.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TListaProdSaiProcessamento }

function TListaProdSaiProcessamento.Add(Item: TProdutoColetor): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaProdSaiProcessamento.SetItems(
  const Value: TArrayListaProdSaiProcessamento);
begin
  FItems := Value;
end;

function TListaProdSaiProcessamento.Size: Integer;
begin
  Result := Length(FItems);
end;

end.
