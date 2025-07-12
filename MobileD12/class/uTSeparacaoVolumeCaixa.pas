unit uTSeparacaoVolumeCaixa;

interface

uses SysUtils;

type
  TProdutoSeparado = Class
   Private
     FCdVolume   : Int64;
     FCdProduto  : Int64;
     FQtSeparada : Integer;
     FDataHora   : TDateTime;
     FQtCorte    : Integer;
   Public
     Constructor Create(cCdvolume : Int64 = 0; cCdProduto : Int64 = 0;
                        cQtSeparada : Integer = 0; cDataHora : TDateTime = 0; cQtCorte : Integer = 0);
   Published
   Property CdVolume   : Int64     Read FCdVolume   Write FCdVolume;
   Property CdProduto  : Int64     Read FCdProduto  Write FCdproduto;
   Property QtSeparada : Integer   Read FQtSeparada Write FQtSeparada;
   Property DataHora   : TDateTime Read FDataHora   Write FDataHora;
   Property QtCorte    : Integer   Read FQtCorte    Write FQtCorte;
  End;

  TArrayListaProdutoSeparado = Array Of TPRodutoSeparado;

  TListaProdutoSeparado = Class
  private
    FItems: TArrayListaProdutoSeparado;
    procedure SetItems(const Value: TArrayListaProdutoSeparado);
    Published
      Property Items : TArrayListaProdutoSeparado read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TProdutoSeparado) : Integer;
  End;

  TSeparacaoVolumeCaixa = class
  private
    FIdSeparacao    : Integer;
    FCdCaixa        : Int64;
    FCdCaixaTipo    : Int64;
    FCdCaixaStatus  : Integer;
    FStatus         : Integer; //0 Iniciada ou 1 Finalizada - Status da Separação
    FVlmNumero      : Integer;
    FCdVolume       : Int64;
    FVlmCxaTipo     : Int64;
    FCdVolumeStatus : Integer;
    FCdProduto      : Int64;
    FCdEndereco     : Integer;
    FCdUsuario      : Integer;
    FDtInicio       : TDateTime;
    FDtFinal        : TDateTime;
    FGerarExtra     : Integer;
    FListaPrdSep    : TListaProdutoSeparado;
  public
    Constructor Create(cIdSeparacao : Integer = 0;
                       cStatus : Integer = 0; cVlmNumero : Integer =0; cCdCaixa : Int64 = 0; cCdCaixaTipo : Int64 = 0;
                       cCdCaixaStatus : Integer = 0; cCdVolume : Int64 = 0; cVlmCxaTipo : Int64 = 0;
                       cCdProduto : Int64 = 0; cCdVolumeStatus : Integer = 0; cCdendereco : Integer = 0;
                       cCdUsuario : Integer = 0; cDtInicio : TDateTime = 0;
                       cDtFinal : TDateTime = 0; cGerarExtra : Integer = 0; cListaPrdSep : TListaProdutoSeparado = Nil); Reintroduce;
  Published
    Property IdSeparacao    : Integer   Read FIdSeparacao write FIdSeparacao;
    Property CdCaixa        : Int64     Read FCdCaixa     Write FCdCaixa;
    Property CdCaixaTipo    : Int64     Read FCdCaixaTipo Write FCdCaixaTipo;
    Property CdCaixaStatus  : Integer   Read FCdCaixaStatus Write FCdCaixaStatus;
    Property Status         : Integer   Read FStatus      Write FStatus;
    Property VlmNumero      : Integer   Read FVlmNumero   Write FVlmNumero;
    Property CdVolume       : Int64     Read FCdVolume    Write FCdVolume;
    Property VlmCxaTipo     : Int64     Read FVlmCxaTipo  Write FVlmCxaTipo;
    Property CdVolumeStatus : Integer   Read FCdVolumeStatus Write FCdVolumeStatus;
    Property CdProduto      : Int64     Read FCdProduto   Write FCdProduto;
    Property CdEndereco     : Integer   Read FCdEndereco  Write FCdEndereco;
    Property CdUsuario      : Integer   Read FCdUsuario   Write FCdUsuario;
    Property DtInicio       : TDateTime Read FDtInicio    Write FDtInicio;
    Property DtFinal        : TDateTime Read FDtFinal     Write FDtFinal;
    Property GerarExra      : Integer   Read FGerarExtra  Write FGerarExtra;
    Property ListaprdSep    : TListaProdutoSeparado Read FListaPrdSep Write FListaPrdSep;
  end;

implementation

{ TSeparacaoVolumeCaixa }

{ TSeparacaoVolumeCaixa }

constructor TSeparacaoVolumeCaixa.Create(cIdSeparacao,
  cStatus, cVlmNumero : Integer; cCdCaixa, cCdCaixaTipo : Int64; cCdCaixaStatus : Integer; cCdVolume, cVlmCxaTipo, cCdProduto: Int64; cCdVolumeStatus, cCdendereco,
  cCdUsuario: Integer; cDtInicio, cDtFinal: TDateTime; cGerarExtra : Integer; cListaPrdSep : TListaProdutoSeparado);
begin
  FIdSeparacao    := cIdSeparacao;
  FCdCaixa        := cCdCaixa;
  FCdCaixaTipo    := cCdCaixaTipo;
  FCdCaixaStatus  := cCdCaixaStatus;
  FStatus         := cStatus;
  FVlmNumero      := cVlmNumero;
  FCdVolume       := cCdVolume;
  FVlmCxaTipo     := cVlmCxaTipo;
  FCdVolumeStatus := cCdVolumeStatus;
  FCdProduto      := cCdProduto;
  FCdEndereco     := cCdendereco;
  FCdUsuario      := cCdUsuario;
  FDtInicio       := cDtInicio;
  FDtFinal        := cDtFinal;
  FGerarExtra     := cGerarExtra;
  FListaPrdSep    := cListaPrdSep;
end;

{ TProdutoSeparado }

constructor TProdutoSeparado.Create(cCdvolume, cCdProduto: Int64;
  cQtSeparada: Integer; cDataHora: TDateTime; cQtCorte : Integer);
begin
  FCdVolume   := cCdVolume;
  FCdProduto  := cCdProduto;
  FQtSeparada := cQtSeparada;
  FDataHora   := cDataHora;
  FQtCorte    := cQtCorte;
end;

{ TListaProdutoSeparado }

function TListaProdutoSeparado.Add(Item: TProdutoSeparado): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaProdutoSeparado.SetItems(
  const Value: TArrayListaProdutoSeparado);
begin
  FItems := Value;
end;

function TListaProdutoSeparado.Size: Integer;
begin
  Result := Length(FItems);
end;

end.
