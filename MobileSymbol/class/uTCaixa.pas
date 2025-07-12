unit uTCaixa;

interface

uses SysUtils;

type
  TCaixaTipoStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;
  end;

  TListaCaixaTipoStatus = Array Of TCaixaTipoStatus;

  TCaixaTipo = class
  private
    FCodigo: Integer;
    FNome: string;
    FAltura: Integer;
    FLargura: Integer;
    FComprimento: Integer;
    FVolume: Integer;
    FAproveitamento: Integer;
    FPeso: Integer;
    FCapacidade: Integer;
    FQtdLacre: Integer;
    FValorUnitario: Currency;
    FRastrear: Boolean;
    FStatus: TCaixaTipoStatus;

    procedure setStatus(pStatus: TCaixaTipoStatus);
  public
    Constructor Create(cCodigo : Integer; cNome : String = '';
                       cAltura : Integer = -1;
                       cLargura : Integer = 0;
                       cComprimento : Integer = 0;
                       cVolume      : Integer = 0;
                       cAproveitamento : Integer = 0;
                       cPeso           : Integer = 0;
                       cCapacidade     : Integer = 0;
                       cQtdLacre       : Integer = 0;
                       cValorUnitario  : Integer = 0;
                       cRastrear       : Integer = 0;
                       cStatus         : TCaixaTipoStatus = Nil); Reintroduce;
  Published
    property Codigo: Integer          read FCodigo          write FCodigo;
    property Nome: string             read FNome            write FNome;
    property Altura: Integer          read FAltura          write FAltura;
    property Largura: Integer         read FLargura         write FLargura;
    property Comprimento: Integer     read FComprimento     write FComprimento;
    property Volume: Integer          read FVolume          Write FVolume;
    property Aproveitamento: Integer  read FAproveitamento  write FAproveitamento;
    property Peso: Integer            read FPeso            write FPeso;
    property Capacidade: Integer      read FCapacidade      write FCapacidade;
    property QtdLacre: Integer        read FQtdLacre        write FQtdLacre;
    property ValorUnitario: Currency  read FValorUnitario   write FValorUnitario;
    property Rastrear: Boolean        read FRastrear        write FRastrear;
    property Status: TCaixaTipoStatus read FStatus          write setStatus;

    destructor Destroy; override;

    function CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
  end;

  TArrayListaCaixaTipo = Array Of TCaixaTipo;

  TListaCaixaTipo = Class
  private
    FItems: TArrayListaCaixaTipo;
    procedure SetItems(const Value: TArrayListaCaixaTipo);
    Published
      Property Items : TArrayListaCaixaTipo read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TCaixaTipo) : Integer;
  End;

  TCaixa = Class
  Private
    FCdCaixa: Integer;
    FCdCaixaTipo : Integer;
    FCaixaTipo: TCaixaTipo;
    FCdMotivoRetirada: Integer;
    FCdCaixaSatus: TCaixaTipoStatus;
    procedure SetCdCaixa(const Value: Integer);
    Procedure SetCdCaixaTipo(Const Value : Integer);
    procedure SetCdCaixaSatus(const Value: TCaixaTipoStatus);
    procedure SetCaixaTipo(const Value: TCaixaTipo);
    procedure SetCdMotivoRetirada(const Value: Integer);
  Public
     Property CdCaixa          : Integer          read FCdCaixa          write SetCdCaixa;
     Property CdCaixaTipo      : Integer          Read FCdCaixaTipo      Write SetCdCaixaTipo;
     Property CaixaTipo        : TCaixaTipo       read FCaixaTipo        write SetCaixaTipo;
     Property CdCaixaSatus     : TCaixaTipoStatus read FCdCaixaSatus     write SetCdCaixaSatus;
     Property CdMotivoRetirada : Integer          read FCdMotivoRetirada write SetCdMotivoRetirada;
  End;

  TArrayListaCaixa = Array Of TCaixa;

  TListaCaixa = Class
  private
    FItems: TArrayListaCaixa;
    procedure SetItems(const Value: TArrayListaCaixa);
    Published
      Property Items : TArrayListaCaixa read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TCaixa) : Integer;
  End;

implementation

//uses uDmCaixaTipo;

{ TCaixaTipo }

function TCaixaTipo.CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
begin
  Result := (pAltura * pLargura * pComprimento);
end;

constructor TCaixaTipo.Create(cCodigo: Integer; cNome: String; cAltura,
  cLargura, cComprimento, cVolume, cAproveitamento, cPeso, cCapacidade,
  cQtdLacre, cValorUnitario, cRastrear : Integer; cStatus: TCaixaTipoStatus);
begin
  Inherited Create;
  FCodigo      := cCodigo;
  FNome        := cNome;
  FAltura      := cAltura;
  FLargura     := cLargura;
  FComprimento := cComprimento;
  FVolume      := cVolume;
  FAproveitamento := cAproveitamento;
  FPeso           := cPeso;
  FCapacidade     := cCapacidade;
  FQtdLacre       := cQtdLacre;
  FValorUnitario  := cValorUnitario;
  FRastrear       := cRastrear = 1;
  FStatus         := cStatus;
end;

destructor TCaixaTipo.Destroy;
begin
  FreeAndNil(FStatus);
  inherited;
end;

procedure TCaixaTipo.setStatus(pStatus: TCaixaTipoStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

{ TCaixa }

procedure TCaixa.SetCdCaixa(const Value: Integer);
begin
  FCdCaixa := Value;
end;

procedure TCaixa.SetCdCaixaSatus(const Value: TCaixaTipoStatus);
begin
  FCdCaixaSatus := Value;
end;

procedure TCaixa.SetCdCaixaTipo(const Value: Integer);
begin
  FCdCaixaTipo := Value;
end;

procedure TCaixa.SetCaixaTipo(const Value: TCaixaTipo);
begin
  FCaixaTipo := Value;
end;

procedure TCaixa.SetCdMotivoRetirada(const Value: Integer);
begin
  FCdMotivoRetirada := Value;
end;

{ TListaCaixaTipo }

Function TListaCaixa.Add(Item: TCaixa) : Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaCaixa.SetItems(const Value: TArrayListaCaixa);
begin
  FItems := Value;
end;

Function TListaCaixaTipo.Add(Item: TCaixaTipo) : Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

function TListaCaixa.Size: Integer;
begin
  Result := Length(FItems);
end;

procedure TListaCaixaTipo.SetItems(const Value: TArrayListaCaixaTipo);
begin
  FItems := Value;
end;

function TListaCaixaTipo.Size: Integer;
begin
  Result := Length(FItems);
end;

end.
