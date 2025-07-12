unit Model.Entity.Produto;

interface

Type
  TProduto = class
  private
    FID: Integer;
    FIdProduto: Integer;
    FDESCRICAO: String;
    procedure SetID(const Value: Integer);
    procedure SetIdProduto(const Value: Integer);
    procedure SetDESCRICAO(const Value: String);

  public
    constructor Create;
    destructor Destroy; override;
  published
    property ID: Integer read FID write SetID;
    property IdProduto: Integer read FIdProduto write SetIdProduto;
    property DESCRICAO: String read FDESCRICAO write SetDESCRICAO;
  end;

implementation


{ TProduto }

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

procedure TProduto.SetIdProduto(const Value: Integer);
begin
  FIdProduto := Value;
end;

procedure TProduto.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TProduto.SetID(const Value: Integer);
begin
  FID := Value;
end;

end.
