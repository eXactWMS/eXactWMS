unit uTSaida;

interface

uses SysUtils, uTCaixa, uTHistorico;

type
  TSaidaTipo = Class
  Private
    FCdSaidaTipo : Int64;
    FNmSaidaTipo : String;
  Public
    Constructor Create(cCdSaidaTipo : Int64 = 0; cNmSaidaTipo : String = ''); Reintroduce;
  Published
    Property CdSaidaTipo : Int64   Read FCdSaidaTipo  Write FCdSaidaTipo;
    Property NmSaidaTipo : String  Read FNmSaidaTipo  Write FNmSaidaTipo;
  End;

  TArrayListaSaidaTipo = Array Of TSaidaTipo;

  TListaSaidaTipo = Class
  private
    FItems: TArrayListaSaidaTipo;
    procedure SetItems(const Value: TArrayListaSaidaTipo);
    Published
      Property Items : TArrayListaSaidaTipo read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TSaidaTipo) : Integer;
  End;

  TSaidaStatus = Class
  Private
    FCdSaidaStatus : Int64;
    FNmSaidaStatus : String;
  Public
    Constructor Create(cCdSaidaStatus : Int64 = 0; cNmSaidaStatus : String = ''); Reintroduce;
  Published
    Property CdSaidaStatus : Int64   Read FCdSaidaStatus  Write FCdSaidaStatus;
    Property NmSaidaStatus : String  Read FNmSaidaStatus  Write FNmSaidaStatus;
  End;

  TArrayListaSaidaStatus = Array Of TSaidaStatus;

  TListaSaidaStatus = Class
  private
    FItems: TArrayListaSaidaStatus;
    procedure SetItems(const Value: TArrayListaSaidaStatus);
    Published
      Property Items : TArrayListaSaidaStatus read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TSaidaStatus) : Integer;
  End;

  TSaida = Class
  Private
    FCdSaida : Int64;
    FSaidaTipo : TSaidaTipo;
//    FCliente   : TCliente;
//    FCarga     : TCarga;
    FDtSaida   : TDateTime;
    FDocumento : String;
    FSaidaStatus : TSaidaStatus;
  Public
    Constructor Create(cCdSaida : Int64 = 0; cSaidaTipo : TSaidaTipo = Nil;
    //                 cCliente : TCliente = Nil; cCarga : TCarga = Nil;
                       cDtSaida : TDateTime = 0; cDocumento : String = '';
                       cSaidaStatus : TSaidaStatus = Nil); Reintroduce;
  Published
     Property CdSaida        : Int64          read FCdSaida        write FCdSaida;
     Property SaidaTipo      : TSaidaTipo     read FSaidaTipo      write FSaidaTipo;
//     Property Cliente        : TClinte        read FCliente        write FCliente;
//     Property Carga          : TCarga         read FCarga          write FCarga;
     Property DtSaida        : TDateTime      Read FDtSaida        write FDtSaida;
     Property Documento      : String         Read FDocumento      Write FDocumento;
     Property SaidaStatus    : TSaidaStatus   Read FSaidaStatus    Write FSaidaStatus;
  End;

  TArrayListaSaida = Array Of TSaida;

  TListaSaida = Class
  private
    FItems: TArrayListaSaida;
    procedure SetItems(const Value: TArrayListaSaida);
    Published
      Property Items : TArrayListaSaida read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TSaida) : Integer;
  End;

  StatusVolume = (Processado, Impresso, Separacao, Separado, Conferencia,
                  Conferido, Expedicao, Carregado, Transito, Entregue,
                  Cancelado, Reconferencia, Reconferido);

  TSaidaVolumeStatus = Class
  Private
    FCdStatus : Integer;
    FNome     : String;
  Public
    Constructor Create(cCdStatus :Integer = 0; cNome : String = ''); Reintroduce;
  Published
    Property CdStatus : Integer  Read FCdStatus Write FCdStatus;
    Property Nome     : String   Read FNome     Write FNome;
  End;

  TArrayListaSaidaVolumeStatus = Array Of TSaidaVolumeStatus;

  TListaSaidaVolumeStatus = Class
  private
    FItems: TArrayListaSaidaVolumeStatus;
    procedure SetItems(const Value: TArrayListaSaidaVolumeStatus);
    Published
      Property Items : TArrayListaSaidaVolumeStatus read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TSaidaVolumeStatus) : Integer;
  End;

  TSaidaVolume = Class
  Private
    FCdVolume  : Int64;
    FNumero    : Integer;
    FStatus    : TSaidaVolumeStatus;
    FSaida     : TSaida;
    FCaixaTipo : TCaixaTipo;
    FCaixa     : TCaixa;

    FCodigoStatus : Integer;
    FCodigoSaida  : Int64;
    FCodigoTipoCaixa : Integer;
    FCodigoCaixa  : Int64;
  Public
    Constructor Create(cCdVolume :Int64 = 0; cNumero : Integer = 0;
                       cStatus : TSaidaVolumeStatus = Nil; cSaida : TSaida = Nil; cCaixaTipo : TCaixaTipo = Nil;
                       cCaixa : TCaixa = Nil; cCodigoStatus : Integer = 0; cCodigoSaida : Int64 = 0;
                       cCodigoTipoCaixa : Integer = 0; cCodigoCaixa : Int64 = 0); Reintroduce;
  Published
    Property CdVolume  : Int64              Read FCdVolume  Write FCdVolume;
    Property Numero    : Integer            Read FNumero    Write FNumero;
    Property Status    : TSaidaVolumeStatus Read FStatus    Write FStatus;
    Property Saida     : TSaida             Read FSaida     Write FSaida;
    Property TipoCaixa : TCaixaTipo         Read FCaixaTipo Write FCaixaTipo;
    Property Caixa     : TCaixa             Read FCaixa     Write FCaixa;
    Property CodigoStatus : Integer         Read FCodigoStatus Write FCodigoStatus;
    Property CodigoSaida  : Int64           Read FCodigoSaida Write FCodigoSaida;
    Property CodigoTipoCaixa : Integer      Read FCodigoTipoCaixa Write FCodigoTipoCaixa;
    Property CodigoCaixa  : Int64           Read FCodigoCaixa Write FCodigoCaixa;
  End;
implementation

{ TListaSaidaTipo }

//uses uDmClient;

function TListaSaidaTipo.Add(Item: TSaidaTipo): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaSaidaTipo.SetItems(const Value: TArrayListaSaidaTipo);
begin
  FItems := Value;
end;

function TListaSaidaTipo.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TListaSaidaStatus }

function TListaSaidaStatus.Add(Item: TSaidaStatus): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaSaidaStatus.SetItems(const Value: TArrayListaSaidaStatus);
begin
  FItems := Value;
end;

function TListaSaidaStatus.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TListaSaida }

function TListaSaida.Add(Item: TSaida): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaSaida.SetItems(const Value: TArrayListaSaida);
begin
  FItems := Value;
end;

function TListaSaida.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TSaidaVolumeStatus }

constructor TSaidaVolumeStatus.Create(cCdStatus: Integer; cNome: String);
begin
  FCdStatus := cCdStatus;
  FNome     := cNome;
end;

{ TSaidaVolume }

constructor TSaidaVolume.Create(cCdVolume: Int64; cNumero: Integer;
  cStatus: TSaidaVolumeStatus; cSaida : TSaida; cCaixaTipo: TCaixaTipo; cCaixa: TCaixa;
  cCodigoStatus: Integer; cCodigoSaida: Int64; cCodigoTipoCaixa: Integer;
  cCodigoCaixa: Int64);
begin
  FCdVolume  := cCdVolume;
  FNumero    := cNumero;
  FStatus    := cStatus;
  FSaida     := cSaida;
  FCaixaTipo := cCaixaTipo;
  FCaixa     := cCaixa;
  FCodigoStatus := cCodigoStatus;
  FCodigoSaida  := cCodigoSaida;
  FCodigoTipoCaixa := cCodigoTipoCaixa;
  FCodigoCaixa     := cCodigoCaixa;
end;

{ TListaSaidaVolumeStatus }

function TListaSaidaVolumeStatus.Add(Item: TSaidaVolumeStatus): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaSaidaVolumeStatus.SetItems(
  const Value: TArrayListaSaidaVolumeStatus);
begin
  FItems := Value;
end;

function TListaSaidaVolumeStatus.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TSaida }

constructor TSaida.Create(cCdSaida: Int64; cSaidaTipo: TSaidaTipo;
  cDtSaida: TDateTime; cDocumento: String; cSaidaStatus: TSaidaStatus);
begin
  FCdSaida     := cCdSaida;
  FSaidaTipo   := cSaidaTipo;
  FDtSaida     := cDtSaida;
  FDocumento   := cDocumento;
  FSaidaStatus := cSaidaStatus;
end;

{ TSaidaTipo }

constructor TSaidaTipo.Create(cCdSaidaTipo: Int64; cNmSaidaTipo: String);
begin
  FCdSaidaTipo := cCdSaidaTipo;
  FNmSaidaTipo := cNmSaidaTipo;
end;

{ TSaidaStatus }

constructor TSaidaStatus.Create(cCdSaidaStatus: Int64; cNmSaidaStatus: String);
begin
  FCdSaidaStatus := cCdSaidaStatus;
  FNmSaidaStatus := cNmSaidaStatus;
end;

end.

