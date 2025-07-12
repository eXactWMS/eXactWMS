unit uTProduto;

interface

uses uTFabricante, uTProdutoControle, uTEndereco, uTHistorico, Dialogs;

type
  TProduto = class
  private
    FCodigo: Int64;
    FNome: string;
    FEmbalagem: Integer;
    FAltura: Integer;
    FLargura: Integer;
    FComprimento: Integer;
    FVolume: Integer;
    FPeso: Integer;
    FLiquido: Boolean;
    FEstoqueMinimo   : Integer;
    FEstoqueMaximo   : Integer;
    FQtdEspera       : Integer;
    FQtdEstoque      : Integer;
    FQtdReserva      : Integer;
    FSaldoEstoq      : Integer;
    FQtdCrossDocking : Integer;
    FQtdVencido      : Integer;
    FValidadeMinimaEntrada     : Integer;
    FDataValidadeMinimaEntrada : TDateTime;
    FValidadeMinimaSaida       : Integer;
    FDataValidadeMinimaSaida   : TDateTime;
    FFabricante: TFabricante;
    FControle: TProdutoControle;
    FCodigoEndereco: Integer;
    FEndereco: TEndereco;
    FCodigoEnderecoAntigo: Integer;
    FEnderecoAntigo: TEndereco;
    FEAN: string;
    FQtdEAN: Integer;
    //ERP
    FCdProdutoERP : String;
    FVariacaoERP  : String;
    FTamanhoERP   : String;

    function  getEndereco: TEndereco;
    function  getEnderecoAntigo: TEndereco;

    procedure setEndereco(pEndereco: TEndereco);
    procedure setEnderecoAntigo(pEndereco: TEndereco);

    procedure ValidarDados;
  public
    property Codigo: Int64                          read FCodigo                      write FCodigo;
    property Nome: string                           read FNome                        write FNome;
    property Embalagem: Integer                     read FEmbalagem                   write FEmbalagem;
    property Altura: Integer                        read FAltura                      write FAltura;
    property Largura: Integer                       read FLargura                     write FLargura;
    property Comprimento: Integer                   read FComprimento                 write FComprimento;
    property Volume: Integer                        read FVolume;
    property Peso: Integer                          read FPeso                        write FPeso;
    property Liquido: Boolean                       read FLiquido                     write FLiquido;
    property EstoqueMinimo  : Integer               read FEstoqueMinimo               write FEstoqueMinimo;
    property EstoqueMaximo  : Integer               read FEstoqueMaximo               write FEstoqueMaximo;
    Property QtdEsEspera    : Integer               Read FQtdEspera                   Write FQtdEspera;
    Property QtdEstoque     : Integer               Read FQtdEstoque                  Write FQtdEstoque;
    Property QtdReserva     : Integer               Read FQtdReserva                  Write FQtdReserva;
    Property SaldoEstoq     : Integer               Read FSaldoEstoq                  Write FSaldoEstoq;
    Property QtdCrosDocking : Integer               Read FQtdCrossDocking             Write FQtdCrossDocking;
    Property QtdVencido     : Integer               Read FQtdVencido                  Write FQtdVencido;

    property ValidadeMinimaEntrada: Integer         read FValidadeMinimaEntrada       write FValidadeMinimaEntrada;
    property DataValidadeMinimaEntrada: TDateTime   read FDataValidadeMinimaEntrada   write FDataValidadeMinimaEntrada;
    property ValidadeMinimaSaida: Integer           read FValidadeMinimaSaida         write FValidadeMinimaSaida;
    property DataValidadeMinimaSaida: TDateTime     read FDataValidadeMinimaSaida     write FDataValidadeMinimaSaida;
    property Fabricante: TFabricante                read FFabricante                  write FFabricante;
    property Controle: TProdutoControle             read FControle                    write FControle;
    property Endereco: TEndereco                    read getEndereco                  write setEndereco;
    property EAN: string                            read FEAN                         write FEAN;
    property QtdEAN: Integer                        read FQtdEAN                      write FQtdEAN;
    //ERP
    Property CdProdutoERP : String                  Read FCdProdutoERP                Write FCdProdutoERP;
    Property VariacaoERP  : String                  Read FVariacaoERP                 Write FVariacaoERP;
    Property TamanhoERP   : String                  Read FTamanhoERP                  Write FTamanhoERP;

    destructor Destroy; override;

    class function ListarLotes(pCodigo: Int64): OleVariant;
    class function ListarEnderecos(pCodigo: Int64): OleVariant;
    class function ListarVincendos(pCodigoSetor, pDataInicial, pDataFinal: string): OleVariant;
    class function ListarProdutoSemMovimentacao(pCodigoSetor, pDataInicial,
      pDataFinal: string): OleVariant; static;
    class function PegarProduto(pCodigo: string): TProduto;
    Class Function GetProdEndereco(pEndereco : String) : Tproduto;
    Class Function ProductFound(pCodigo: string) : Int64;
    class function PegarProdutoConferencia(pCodigo: string): TProduto;
    class function PegarCadastro(pCodigo: string): TProduto;
    class function Pesquisar(pCodigo, pNome, pEndereco: string): OleVariant;
    class function PesquisarCadastro(pFiltros: OleVariant): OleVariant;
    class function RelatorioEstoqueGeral(pCodigo: string): OleVariant;

    function  CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
    function  EstoqueDisponivel: Integer;
    function  ListarSaidas(pCodigoEstacao: Integer): OleVariant;
    procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses SysUtils, DB, DBClient, uDmProduto, uFuncoes, uTEstoque,
  Variants;

{ TProduto }

function TProduto.CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
begin
  Result := (pAltura * pLargura * pComprimento);
end;

destructor TProduto.Destroy;
begin
  FreeAndNil(FFabricante);
  FreeAndNil(FControle);
  FreeAndNil(FEndereco);
  FreeAndNil(FEnderecoAntigo);

  inherited;
end;

function TProduto.EstoqueDisponivel: Integer;
begin
  dmProduto.qryEstoqueDisponivel.Close;
  dmProduto.qryEstoqueDisponivel.Parameters.ParamByName('pCdProduto').Value := FCodigo;
  dmProduto.qryEstoqueDisponivel.Open;

  Result := dmProduto.qryEstoqueDisponivel.FieldByName('qtEstoque').AsInteger;
end;

function TProduto.getEndereco: TEndereco;
begin
  if (Assigned(FEndereco) = False) and (FCodigoEndereco > 0) then
    begin
      setEndereco(TEndereco.PegarEndereco(FCodigoEndereco));
    end;

  Result := FEndereco;
end;

function TProduto.getEnderecoAntigo: TEndereco;
begin
  if (Assigned(FEnderecoAntigo) = False) and (FCodigoEnderecoAntigo > 0) then
    begin
      setEnderecoAntigo(TEndereco.PegarEndereco(FCodigoEnderecoAntigo));
    end;

  Result := FEnderecoAntigo;
end;

class function TProduto.GetProdEndereco(pEndereco: String): Tproduto;
begin
  Result := Nil;
  With DmProduto.QryGetProdEndereco do Begin
    Close;
    Parameters.ParamByName('pEndereco').Value := pEndereco;
    Open;
    if (DmProduto.QryGetProdEndereco.IsEmpty) or (FieldByName('CdProduto').AsString='') then
       raise Exception.Create('Não existe produto vinculado a este Endereço!');
    result := PegarProduto(FieldByName('CdProduto').AsString);
    Close;
  End;
end;

class function TProduto.ListarLotes(pCodigo: Int64): OleVariant;
begin
  dmProduto.qryListarLotes.Close;
  dmProduto.qryListarLotes.Parameters.ParamByName('pCdProduto').Value := pCodigo;
  dmProduto.qryListarLotes.Open;

  Result := dmProduto.dspListarLotes.Data;
end;

class function TProduto.ListarEnderecos(pCodigo: Int64): OleVariant;
begin
  dmProduto.qryListarEnderecos.Close;
  dmProduto.qryListarEnderecos.Parameters.ParamByName('pCod_Prod').Value := pCodigo;
  dmProduto.qryListarEnderecos.Open;

  Result := dmProduto.dspListarEnderecos.Data;
end;

function TProduto.ListarSaidas(pCodigoEstacao: Integer): OleVariant;
begin
  dmProduto.qryListarSaidas.Close;
  dmProduto.qryListarSaidas.Parameters.ParamByName('pCdProduto').Value := Self.Codigo;
  dmProduto.qryListarSaidas.Parameters.ParamByName('pCdEstacao').Value := pCodigoEstacao;
  dmProduto.qryListarSaidas.Open;

  Result := dmProduto.dspListarSaidas.Data;
end;

class function TProduto.ListarVincendos(pCodigoSetor, pDataInicial, pDataFinal: string): OleVariant;
begin
  ValidarParametroTexto(pCodigoSetor);
  ValidarData(pDataInicial, 'Data Inicial');
  ValidarData(pDataFinal, 'Data Final');

  dmProduto.qryListarVincendos.Close;
  dmProduto.qryListarVincendos.Parameters.ParamByName('pCdEnderecoSetor').Value := pCodigoSetor;
  dmProduto.qryListarVincendos.Parameters.ParamByName('pDataInicial').Value     := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));
  dmProduto.qryListarVincendos.Parameters.ParamByName('pDataFinal').Value       := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));
  dmProduto.qryListarVincendos.Open;

  Result := dmProduto.dspListarVincendos.Data;
end;

class function TProduto.ListarProdutoSemMovimentacao(pCodigoSetor, pDataInicial, pDataFinal: string): OleVariant;
begin
  ValidarParametroTexto(pCodigoSetor);
  ValidarData(pDataInicial, 'Data Inicial');
  ValidarData(pDataFinal, 'Data Final');

  dmProduto.qryListarProdutoSemMovimentacao.Close;
  dmProduto.qryListarProdutoSemMovimentacao.Parameters.ParamByName('pCdEnderecoSetor').Value := pCodigoSetor;
  dmProduto.qryListarProdutoSemMovimentacao.Parameters.ParamByName('pDataInicial').Value     := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));
  dmProduto.qryListarProdutoSemMovimentacao.Parameters.ParamByName('pDataFinal').Value       := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));
  dmProduto.qryListarProdutoSemMovimentacao.Open;

  Result := dmProduto.dspListarProdutoSemMovimentacao.Data;
end;

class function TProduto.PegarCadastro(pCodigo: string): TProduto;
var
  vlProduto: TProduto;
  vlFabricante: TFabricante;
  vlControle: TProdutoControle;
  vlCodigo: Int64;
  vlEAN: string;
begin
  pCodigo := RemoverEspacos(pCodigo);
  vlEAN   := pCodigo;

  try
    vlCodigo := StrToInt64(pCodigo);
  except
    vlCodigo := 0;
  end;

  dmProduto.qryPegarCadastro.Close;
  dmProduto.qryPegarCadastro.Parameters.ParamByName('pCdProduto').Value := vlCodigo;
  dmProduto.qryPegarCadastro.Parameters.ParamByName('pNmEAN').Value     := vlEAN;
  dmProduto.qryPegarCadastro.Open;

  if (dmProduto.qryPegarCadastro.IsEmpty = True) then
    begin
      raise Exception.Create('Produto não encontrado!');
    end;

  vlProduto := TProduto.Create;

  try
    vlProduto.Codigo := dmProduto.qryPegarCadastro.FieldByName('cdProduto').AsLargeInt;
    vlProduto.Nome   := dmProduto.qryPegarCadastro.FieldByName('nmProduto').AsString;

    vlProduto.Embalagem             := dmProduto.qryPegarCadastro.FieldByName('Embalagem').AsInteger;
    vlProduto.Altura                := dmProduto.qryPegarCadastro.FieldByName('Altura').AsInteger;
    vlProduto.Largura               := dmProduto.qryPegarCadastro.FieldByName('Largura').AsInteger;
    vlProduto.Comprimento           := dmProduto.qryPegarCadastro.FieldByName('Comprimento').AsInteger;
    vlProduto.FVolume               := dmProduto.qryPegarCadastro.FieldByName('Volume').AsInteger;
    vlProduto.Peso                  := dmProduto.qryPegarCadastro.FieldByName('Peso').AsInteger;
    vlProduto.Liquido               := dmProduto.qryPegarCadastro.FieldByName('Liquido').AsInteger = 1;
    vlProduto.EstoqueMinimo         := dmProduto.qryPegarCadastro.FieldByName('EstoqueMinimo').AsInteger;
    vlProduto.EstoqueMaximo         := dmProduto.qryPegarCadastro.FieldByName('EstoqueMaximo').AsInteger;
    vlProduto.ValidadeMinimaEntrada := dmProduto.qryPegarCadastro.FieldByName('ValidadeMinimaEntrada').AsInteger;
    vlProduto.ValidadeMinimaSaida   := dmProduto.qryPegarCadastro.FieldByName('ValidadeMinimaSaida').AsInteger;

    vlFabricante         := TFabricante.Create;
    vlFabricante.Codigo  := dmProduto.qryPegarCadastro.FieldByName('cdFabricante').AsInteger;
    vlFabricante.Nome    := dmProduto.qryPegarCadastro.FieldByName('nmFabricante').AsString;
    vlProduto.Fabricante := vlFabricante;

    vlControle         := TProdutoControle.Create;
    vlControle.Codigo  := dmProduto.qryPegarCadastro.FieldByName('cdProdutoControle').AsInteger;
    vlControle.Nome    := dmProduto.qryPegarCadastro.FieldByName('nmProdutoControle').AsString;
    vlProduto.Controle := vlControle;

    vlProduto.FCodigoEndereco       := dmProduto.qryPegarCadastro.FieldByName('cdEndereco').AsInteger;
    vlProduto.FCodigoEnderecoAntigo := dmProduto.qryPegarCadastro.FieldByName('cdEndereco').AsInteger;
    vlProduto.FCdProdutoERP         := DmProduto.qryPegarCadastro.FieldByName('CdProdutoERP').AsString;
    vlProduto.FVariacaoERP          := DmProduto.qryPegarCadastro.FieldByName('VariacaoERP').AsString;
    vlProduto.FTamanhoERP           := DmProduto.qryPegarCadastro.FieldByName('TamanhoERP').AsString;
//GSS em 13/05/2016 - Dados do Estoque
    With DmProduto.QryEstProd do Begin
      Close;
      Parameters.ParamByName('pCod_Prod').Value := VlCodigo;
      Open;
      vlProduto.QtdEsEspera    := FieldByname('QtdEspera').AsInteger;
      VlProduto.QtdEstoque     := FieldByName('QtdProducao').AsInteger;
      VlProduto.QtdReserva     := FieldByName('QtdReserva').AsInteger;
      VlProduto.SaldoEstoq     := FieldByName('Saldo').AsInteger;
      VlProduto.QtdCrosDocking := FieldByName('QtdCrossDocking').AsInteger;
      VlProduto.QtdVencido     := FieldByName('QtdVencido').AsInteger;
    End;
    Result := vlProduto;
  except
    on e: Exception do
      begin
        FreeAndNil(vlProduto);

        raise Exception.Create(e.Message);
      end;
  end;
end;

class function TProduto.PegarProduto(pCodigo: string): TProduto;
var
  vlProduto: TProduto;
  vlFabricante: TFabricante;
  vlControle: TProdutoControle;
  vlCodigo: Int64;
  vlEAN: string;
begin
  pCodigo := RemoverEspacos(pCodigo);
  vlEAN   := pCodigo;

  try
    vlCodigo := StrToIntDef(pCodigo, 0);
  except
    vlCodigo := 0;
  end;

  With dmProduto.qryPegarProduto do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value := vlCodigo;
    Parameters.ParamByName('pNmEAN').Value     := vlEAN;
    Open;

    if (dmProduto.qryPegarProduto.IsEmpty = True) then
        raise Exception.Create('Produto não encontrado!');

    vlProduto := TProduto.Create;

    try
      vlProduto.Codigo := FieldByName('cdProduto').AsLargeInt;
      vlProduto.Nome   := FieldByName('nmProduto').AsString;

      vlProduto.Embalagem                 := FieldByName('Embalagem').AsInteger;
      vlProduto.Altura                    := FieldByName('Altura').AsInteger;
      vlProduto.Largura                   := FieldByName('Largura').AsInteger;
      vlProduto.Comprimento               := FieldByName('Comprimento').AsInteger;
      vlProduto.FVolume                   := FieldByName('Volume').AsInteger;
      vlProduto.Peso                      := FieldByName('Peso').AsInteger;
      vlProduto.Liquido                   := FieldByName('Liquido').AsInteger = 1;
      vlProduto.EstoqueMinimo             := FieldByName('EstoqueMinimo').AsInteger;
      vlProduto.EstoqueMaximo             := FieldByName('EstoqueMaximo').AsInteger;
      vlProduto.ValidadeMinimaEntrada     := FieldByName('ValidadeMinimaEntrada').AsInteger;
      vlProduto.DataValidadeMinimaEntrada := FieldByName('dtValidadeMinimaEntrada').AsDateTime;
      vlProduto.ValidadeMinimaSaida       := FieldByName('ValidadeMinimaSaida').AsInteger;
      vlProduto.DataValidadeMinimaSaida   := FieldByName('dtValidadeMinimaSaida').AsDateTime;
      vlProduto.EAN                       := FieldByName('nmEAN').AsString;
      vlProduto.QtdEAN                    := FieldByName('qtEAN').AsInteger;

      vlFabricante         := TFabricante.Create;
      vlFabricante.Codigo  := FieldByName('cdFabricante').AsInteger;
      vlFabricante.Nome    := FieldByName('nmFabricante').AsString;
      vlProduto.Fabricante := vlFabricante;

      vlControle         := TProdutoControle.Create;
      vlControle.Codigo  := FieldByName('cdProdutoControle').AsInteger;
      vlControle.Nome    := FieldByName('nmProdutoControle').AsString;
      vlProduto.Controle := vlControle;

      vlProduto.FCodigoEndereco       := FieldByName('cdEndereco').AsInteger;
      vlProduto.FCodigoEnderecoAntigo := FieldByName('cdEndereco').AsInteger;
      vlProduto.FCdProdutoERP         := FieldByName('CdProdutoERP').AsString;
      vlProduto.FVariacaoERP          := FieldByName('VariacaoERP').AsString;
      vlProduto.FTamanhoERP           := FieldByName('TamanhoERP').AsString;

      Result := vlProduto;
    except
      on e: Exception do
        begin
          FreeAndNil(vlProduto);

          raise Exception.Create(e.Message);
        end;
    end;
  End;
end;

class function TProduto.PegarProdutoConferencia(pCodigo: string): TProduto;
var
  vlProduto: TProduto;
  vlCodigo: Int64;
  vlEAN: string;
begin
  pCodigo := RemoverEspacos(pCodigo);
  vlEAN   := pCodigo;

  try
    vlCodigo := StrToInt64(pCodigo);
  except
    vlCodigo := 0;
  end;

  dmProduto.qryPegarProdutoConferencia.Close;
  dmProduto.qryPegarProdutoConferencia.Parameters.ParamByName('pCdProduto').Value := vlCodigo;
  dmProduto.qryPegarProdutoConferencia.Parameters.ParamByName('pNmEAN').Value     := vlEAN;
  dmProduto.qryPegarProdutoConferencia.Open;

  if (dmProduto.qryPegarProdutoConferencia.IsEmpty = True) then
    begin
      raise Exception.Create('Produto não encontrado!');
    end;

  vlProduto := TProduto.Create;

  try
    vlProduto.Codigo := dmProduto.qryPegarProdutoConferencia.FieldByName('cdProduto').AsLargeInt;
    vlProduto.Nome   := dmProduto.qryPegarProdutoConferencia.FieldByName('nmProduto').AsString;
    vlProduto.QtdEAN := dmProduto.qryPegarProdutoConferencia.FieldByName('qtEAN').AsInteger;

    Result := vlProduto;
  except
    on e: Exception do
      begin
        FreeAndNil(vlProduto);
        raise Exception.Create(E.Message);
      end;
  end;
end;

class function TProduto.Pesquisar(pCodigo, pNome, pEndereco: string): OleVariant;
var
  vlCodigo: Int64;
  vlEAN: string;
begin
  pCodigo := RemoverEspacos(pCodigo);
  vlEAN   := pCodigo;

  try
    vlCodigo := StrToInt64Def(pCodigo, 0);
  except
    vlCodigo := 0;
  end;

  if (Trim(vlEAN) = '') then
    begin
      vlEAN := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  if (Trim(pEndereco) = '') then
    begin
      pEndereco := '%';
    end
  else
  	begin
  	  pEndereco := RemoverCaracteres(pEndereco);
  	end;

  dmProduto.qryPesquisar.Close;
  dmProduto.qryPesquisar.Parameters.ParamByName('pCdProduto').Value    := vlCodigo;
  dmProduto.qryPesquisar.Parameters.ParamByName('pNmEAN').Value        := vlEAN;
  dmProduto.qryPesquisar.Parameters.ParamByName('pNmProduto').Value    := '%' + pNome + '%';
  dmProduto.qryPesquisar.Parameters.ParamByName('pNmEndereco').Value   := pEndereco;
  DmProduto.QryPesquisar.Parameters.ParamByname('pCdProdutoERP').Value := pCodigo;
  dmProduto.qryPesquisar.Open;

  Result := dmProduto.dspPesquisar.Data;
end;

class function TProduto.PesquisarCadastro(pFiltros: OleVariant): OleVariant;
var
  vlCodigo, vlNome, vlCodFabricante: string;
  vlLiquido, vlTipoControle, vlSetor: string;
  vlEmbalagemInicial, vlEmbalagemFinal: string;
  vlAlturaInicial, vlAlturaFinal: string;
  vlLarguraInicial, vlLarguraFinal: string;
  vlComprimentoInicial, vlComprimentoFinal: string;
  vlVolumeInicial, vlVolumeFinal: string;
  vlPesoInicial, vlPesoFinal: string;
  vlEstMinimoInicial, vlEstMinimoFinal: string;
  vlEstMaximoInicial, vlEstMaximoFinal: string;
  vlEnderecoInicial, vlEnderecoFinal: string;
  vlValMinEntradaInicial, vlValMinEntradaFinal: string;
  vlValMinSaidaInicial, vlValMinSaidaFinal: string;
  vlFiltros: TClientDataSet;
begin
  vlCodigo               := '%';
  vlNome                 := '%';
  vlCodFabricante        := '%';
  vlLiquido              := '%';
  vlTipoControle         := '%';
  vlSetor                := '%';
  vlEmbalagemInicial     := '0';
  vlEmbalagemFinal       := '999999999';
  vlAlturaInicial        := '0';
  vlAlturaFinal          := '999999999';
  vlLarguraInicial       := '0';
  vlLarguraFinal         := '999999999';
  vlComprimentoInicial   := '0';
  vlComprimentoFinal     := '999999999';
  vlVolumeInicial        := '0';
  vlVolumeFinal          := '999999999';
  vlPesoInicial          := '0';
  vlPesoFinal            := '999999999';
  vlEstMinimoInicial     := '0';
  vlEstMinimoFinal       := '999999999';
  vlEstMaximoInicial     := '0';
  vlEstMaximoFinal       := '999999999';
  vlEnderecoInicial      := '';
  vlEnderecoFinal        := '999999999';
  vlValMinEntradaInicial := '0';
  vlValMinEntradaFinal   := '999999999';
  vlValMinSaidaInicial   := '0';
  vlValMinSaidaFinal     := '999999999';

  vlFiltros := TClientDataSet.Create(nil);

  try
    vlFiltros.Close;
    vlFiltros.Data := pFiltros;

    if (vlFiltros.Locate('nmCampo', 'cdProduto', []) = True)             then vlCodigo               := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'nmProduto', []) = True)             then vlNome                 := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'cdFabricante', []) = True)          then vlCodFabricante        := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'cdProdutoControle', []) = True)     then vlTipoControle         := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Liquido', []) = True)               then vlLiquido              := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'cdEnderecoSetor', []) = True)       then vlSetor                := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'nmEndereco', []) = True)            then vlEnderecoInicial      := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'nmEndereco', []) = True)            then vlEnderecoFinal        := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'Embalagem', []) = True)             then vlEmbalagemInicial     := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Embalagem', []) = True)             then vlEmbalagemFinal       := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'Altura', []) = True)                then vlAlturaInicial        := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Altura', []) = True)                then vlAlturaFinal          := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'Largura', []) = True)               then vlLarguraInicial       := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Largura', []) = True)               then vlLarguraFinal         := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'Comprimento', []) = True)           then vlComprimentoInicial   := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Comprimento', []) = True)           then vlComprimentoFinal     := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'Volume', []) = True)                then vlVolumeInicial        := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Volume', []) = True)                then vlVolumeFinal          := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'Peso', []) = True)                  then vlPesoInicial          := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'Peso', []) = True)                  then vlPesoFinal            := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'EstoqueMinimo', []) = True)         then vlEstMinimoInicial     := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'EstoqueMinimo', []) = True)         then vlEstMinimoFinal       := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'EstoqueMaximo', []) = True)         then vlEstMaximoInicial     := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'EstoqueMaximo', []) = True)         then vlEstMaximoFinal       := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'ValidadeMinimaEntrada', []) = True) then vlValMinEntradaInicial := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'ValidadeMinimaEntrada', []) = True) then vlValMinEntradaFinal   := vlFiltros.FieldByName('vlCampo2').AsString;
    if (vlFiltros.Locate('nmCampo', 'ValidadeMinimaSaida', []) = True)   then vlValMinSaidaInicial   := vlFiltros.FieldByName('vlCampo1').AsString;
    if (vlFiltros.Locate('nmCampo', 'ValidadeMinimaSaida', []) = True)   then vlValMinSaidaFinal     := vlFiltros.FieldByName('vlCampo2').AsString;
  finally
    FreeAndNil(vlFiltros);
  end;

  dmProduto.qryPesquisarCadastro.Close;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pCdProduto').Value            := vlCodigo;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pNmProduto').Value            := '%' + vlNome + '%';
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pCdFabricante').Value         := vlCodFabricante;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pCdProdutoControle').Value    := vlTipoControle;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pLiquido').Value              := vlLiquido;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pCdEnderecoSetor').Value      := vlSetor;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pNmEnderecoInicial').Value    := vlEnderecoInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pNmEnderecoFinal').Value      := vlEnderecoFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pEmbalagemInicial').Value     := vlEmbalagemInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pEmbalagemFinal').Value       := vlEmbalagemFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pAlturaInicial').Value        := vlAlturaInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pAlturaFinal').Value          := vlAlturaFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pLarguraInicial').Value       := vlLarguraInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pLarguraFinal').Value         := vlLarguraFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pComprimentoInicial').Value   := vlComprimentoInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pComprimentoFinal').Value     := vlComprimentoFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pVolumeInicial').Value        := vlVolumeInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pVolumeFinal').Value          := vlVolumeFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pPesoInicial').Value          := vlPesoInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pPesoFinal').Value            := vlPesoFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pEstoqueMinimoInicial').Value := vlEstMinimoInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pEstoqueMinimoFinal').Value   := vlEstMinimoFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pEstoqueMaximoInicial').Value := vlEstMaximoInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pEstoqueMaximoFinal').Value   := vlEstMaximoFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pValMinEntradaInicial').Value := vlValMinEntradaInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pValMinEntradaFinal').Value   := vlValMinEntradaFinal;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pValMinSaidaInicial').Value   := vlValMinSaidaInicial;
  dmProduto.qryPesquisarCadastro.Parameters.ParamByName('pValMinSaidaFinal').Value     := vlValMinSaidaFinal;
  dmProduto.qryPesquisarCadastro.Open;

  Result := dmProduto.dspPesquisarCadastro.Data;
end;

class function TProduto.ProductFound(pCodigo: string): Int64;
Var vlCodigo : Int64;
    vlEan    : String;
begin
  pCodigo := RemoverEspacos(pCodigo);
  vlEAN   := pCodigo;
  try
    vlCodigo := StrToIntDef(pCodigo, 0);
  except
    vlCodigo := 0;
  end;
  With dmProduto.QryProductFound do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value := vlCodigo;
    Parameters.ParamByName('pNmEAN').Value     := vlEAN;
    Open;
    Result :=  FieldByName('CdProduto').AsInteger;
    Close;
  End;
end;

class function TProduto.RelatorioEstoqueGeral(pCodigo: string): OleVariant;
begin
  ValidarParametroTexto(pCodigo);
  dmProduto.qryRelatorioEstoqueGeral.Close;
  dmProduto.qryRelatorioEstoqueGeral.Parameters.ParamByName('pCdProduto').Value := pCodigo;
  dmProduto.qryRelatorioEstoqueGeral.Open;
  Result :=   dmProduto.dspRelatorioEstoqueGeral.Data;
end;

procedure TProduto.Salvar(pHistorico: THistorico);
begin
  ValidarDados;

  Self.FVolume := CalcularVolume(Self.Altura, Self.Largura, Self.Comprimento);

  dmProduto.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
  dmProduto.qrySalvar.Connection.BeginTrans;

  try
    dmProduto.qrySalvar.Close;
    dmProduto.qrySalvar.Parameters.ParamByName('pEmbalagem').Value             := Self.Embalagem;
    dmProduto.qrySalvar.Parameters.ParamByName('pAltura').Value                := Self.Altura;
    dmProduto.qrySalvar.Parameters.ParamByName('pLargura').Value               := Self.Largura;
    dmProduto.qrySalvar.Parameters.ParamByName('pComprimento').Value           := Self.Comprimento;
    dmProduto.qrySalvar.Parameters.ParamByName('pVolume').Value                := Self.Volume;
    dmProduto.qrySalvar.Parameters.ParamByName('pPeso').Value                  := Self.Peso;
    dmProduto.qrySalvar.Parameters.ParamByName('pLiquido').Value               := Ord(Self.Liquido);
    dmProduto.qrySalvar.Parameters.ParamByName('pEstoqueMinimo').Value         := Self.EstoqueMinimo;
    dmProduto.qrySalvar.Parameters.ParamByName('pEstoqueMaximo').Value         := Self.EstoqueMaximo;
    dmProduto.qrySalvar.Parameters.ParamByName('pValidadeMinimaEntrada').Value   := Self.ValidadeMinimaEntrada;
    dmProduto.qrySalvar.Parameters.ParamByName('pValidadeMinimaSaida').Value   := Self.ValidadeMinimaSaida;
    DmProduto.qrySalvar.Parameters.ParamByName('pCdProdutoERP').Value          := Self.CdProdutoERP;
    DmProduto.qrySalvar.Parameters.ParamByName('pVariacaoERP').Value           := Self.VariacaoERP;
    DmProduto.qrySalvar.Parameters.ParamByName('pTamanhoERP').Value            := Self.TamanhoERP;
    if (Self.FCodigoEndereco > 0) then
      begin
        dmProduto.qrySalvar.Parameters.ParamByName('pCdEndereco').Value := Self.FCodigoEndereco;
      end
    else
      begin
        dmProduto.qrySalvar.Parameters.ParamByName('pCdEndereco').Value := Null;
      end;

    dmProduto.qrySalvar.Parameters.ParamByName('pCdProdutoControle').Value := Self.Controle.Codigo;
    dmProduto.qrySalvar.Parameters.ParamByName('pCdProduto').Value         := Self.Codigo;
    dmProduto.qrySalvar.ExecSQL;

    pHistorico.CodigoRegistro := Self.Codigo;
    pHistorico.Observacao     := 'Alteração do Cadastro do Produto';

    pHistorico.Salvar;

    dmProduto.qrySalvar.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmProduto.qrySalvar.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TProduto.setEndereco(pEndereco: TEndereco);
begin
  FreeAndNil(FEndereco);

  FEndereco := pEndereco;

  if (Assigned(FEndereco) = True) then
    begin
      FCodigoEndereco := FEndereco.Codigo;
    end
  else
    begin
      FCodigoEndereco := 0;
    end;
end;

procedure TProduto.setEnderecoAntigo(pEndereco: TEndereco);
begin
  FreeAndNil(FEnderecoAntigo);

  FEnderecoAntigo := pEndereco;

  if (Assigned(FEnderecoAntigo) = True) then
    begin
      FCodigoEnderecoAntigo := FEnderecoAntigo.Codigo;
    end
  else
    begin
      FCodigoEnderecoAntigo := 0;
    end;
end;

procedure TProduto.ValidarDados;
var
  vlPesquisar: TClientDataSet;
begin
  if (FCodigo <= 0) then
    begin
      raise Exception.Create('Código do Produto inválido!');
    end;

  if (FEmbalagem <= 0) then
    begin
      raise Exception.Create('Quantidade da Embalagem inválida!');
    end;

  if (FAltura <= 0) then
    begin
      raise Exception.Create('Altura do Produto inválida!');
    end;

  if (FLargura <= 0) then
    begin
      raise Exception.Create('Largura do Produto inválida!');
    end;

  if (FComprimento <= 0) then
    begin
      raise Exception.Create('Comprimento do Produto inválido!');
    end;

  if (FPeso <= 0) then
    begin
      raise Exception.Create('Peso do Produto inválido!');
    end;

  if (FEstoqueMinimo < 0) then
    begin
      raise Exception.Create('Estoque de Reposição Mínimo inválido!');
    end;
  if FCdProdutoERP.IsEmpty then raise Exception.Create('Informe o Código do Produto no ERP!');

  if (FEstoqueMaximo < 0) then
    begin
      raise Exception.Create('Estoque de Reposição Máximo inválido!');
    end;

  if (FEstoqueMinimo > FEstoqueMaximo) then
    begin
      raise Exception.Create('Estoque de Reposição Mínimo inválido!' + sLineBreak +
                             'O Estoque de Reposição Mínimo não pode ser maior que o Estoque de Reposição Máximo.');
    end;

  if (FCodigoEnderecoAntigo > 0) then // Se havia um endereço
    begin
      if (FCodigoEndereco = 0) or (FCodigoEndereco <> FCodigoEnderecoAntigo) then // Verifica se o endereço foi removido ou alterado
        begin
          if (TEstoque.PegarEstoqueProduto(FCodigo, getEnderecoAntigo.Endereco) > 0) then // Verifica se existe estoque no endereço antigo
            begin
              raise Exception.Create('O Endereço original do produto ainda possui estoque!' + sLineBreak +
                                     'Remova o estoque do endereço anterior antes de fazer esta alteração.');
            end;
        end;
    end;

  if (FValidadeMinimaEntrada < 0) then
    begin
      raise Exception.Create('Validade Mínima para Entrada inválida!');
    end;

  if (FValidadeMinimaSaida < 0) then
    begin
      raise Exception.Create('Validade Mínima para Saída inválida!');
    end;

  if (FCodigoEndereco > 0) then // Se há um endereço
    begin
      if (Endereco.Tipo.Codigo <> 1) then // Verifica se é um endereço de Picking (1)
        begin
          raise Exception.Create('O endereço informado não é um endereço de Picking!');
        end;

      if (FCodigoEnderecoAntigo = 0) or (FCodigoEndereco <> FCodigoEnderecoAntigo) then // Verifica se o endereço foi adicionado ou alterado
        begin
          vlPesquisar := TClientDataSet.Create(nil);

          try
            vlPesquisar.Close;
            vlPesquisar.Data := Pesquisar('', '', Endereco.Endereco);

            if (vlPesquisar.IsEmpty = False) then // Verifica se existe algum produto neste endereço
              begin
                if (FCodigo <> vlPesquisar.FieldByName('cdProduto').AsLargeInt) then
                  begin
                    if (FCodigoEnderecoAntigo > 0) then
                      begin
                        Endereco := TEndereco.PegarEndereco(FCodigoEnderecoAntigo);
                      end
                    else
                      begin
                        Endereco := nil;
                      end;

                    raise Exception.Create('O endereço informado já está vinculado a outro produto!' + sLineBreak + sLineBreak +
                                           'Código: ' + vlPesquisar.FieldByName('cdProduto').AsString + sLineBreak +
                                           'Produto: ' + vlPesquisar.FieldByName('nmProduto').AsString);
                  end;
              end;
          finally
            FreeAndNil(vlPesquisar);
          end;
        end;
    end;
end;

end.
