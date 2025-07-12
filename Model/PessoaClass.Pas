{
  Pessoa.Pas
  Criado por Genilson S Soares (RhemaSys) em 15/09/2020
  Projeto: RhemaWMS
}
unit PessoaClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, PessoaTipoClass;

type
  TCrud = (Ins, Upd);

  TPessoa = class
  private
    [JSONMarshalledAttribute(False)]
    FCrud: TCrud;
    [JSONNameAttribute('codigo')]
    FPessoaId: Integer;
    [JSONNameAttribute('codpessoaerp')]
    FCodpessoaerp: Integer;
    [JSONNameAttribute('razao')]
    Frazao: String;
    [JSONNameAttribute('fantasia')]
    FFantasia: String;
    [JSONNameAttribute('pessoatipo')]
    FPessoatipo: TPessoaTipo;
    [JSONNameAttribute('fone')]
    FFone: String;
    [JSONNameAttribute('cnpjcpf')]
    FCnpjcpf: String;
    [JSONNameAttribute('email')]
    FEmail: String;
    [JSONNameAttribute('homepage')]
    FHomepage: String;
    FRotaId: Integer;
    [JSONNameAttribute('status')]
    FTransportadoraId: Integer;
    FGoogleMaps: String;
    FLatitude: String;
    FLongitude: String;
    FStatus: Integer;
    FShelflife: Integer;
    Cep: String;
  Protected
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjPessoa: TPessoa): String;
    Class Function JsonToClass(Json: String): TPessoa;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    property CRUD: TCrud Read FCrud Write FCrud;
    [JSONNameAttribute('codigo')]
    property PessoaId: Integer Read FPessoaId Write FPessoaId;
    property CodPessoa: Integer Read FCodpessoaerp Write FCodpessoaerp;
    property Razao: String Read Frazao Write Frazao;
    property Fantasia: String Read FFantasia Write FFantasia;
    property PessoaTipo: TPessoaTipo Read FPessoatipo Write FPessoatipo;
    property CnpjCpf: String Read FCnpjcpf Write FCnpjcpf;
    Property Fone: String Read FFone Write FFone;
    property Email: String Read FEmail Write FEmail;
    property HomePage: String Read FHomepage Write FHomepage;
    Property RotaId: Integer Read FRotaId Write FRotaId;
    Property TransportadoraId: Integer Read FTransportadoraId
      Write FTransportadoraId;
    Property GoogleMaps: String Read FGoogleMaps Write FGoogleMaps;
    Property Latitude: String Read FLatitude Write FLatitude;
    Property Longitude: String Read FLongitude Write FLongitude;
    Property shelflife: Integer Read FShelflife Write FShelflife;
    Property Status: Integer Read FStatus Write FStatus;

  End;

  TEnderecoTipo = class
  private
    FEnderecoTipoId: Integer;
    FDescricao: String;
    FStatus: Integer;
  Protected
  Public
    constructor Create;
    Class Function ClassToJson(Const ObjEnderecoTipo: TEnderecoTipo): String;
    Class Function JsonToClass(Json: String): TEnderecoTipo;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property EnderecoTipoId: Integer Read FEnderecoTipoId Write FEnderecoTipoId;
    Property Descricao: String Read FDescricao Write FDescricao;
    Property Status: Integer Read FStatus Write FStatus;
  end;

  TPessoaEndereco = Class
  private
    FId: Integer;
    FPessoaId: Integer;
    FEnderecoTipo: TEnderecoTipo;
    FEndereco: String;
    FNumero: String;
    FComplemento: String;
    FReferencia: String;
    FBairro: String;
    FMunicipio: String;
    FUf: String;
    FCep: String;
    FCodIbge: String;
    FStatus: Integer;
  Protected
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjPessoaEndereco
      : TPessoaEndereco): String;
    Class Function JsonToClass(Json: String): TPessoaEndereco;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property Id: Integer Read FId Write FId;
    Property PessoaId: Integer Read FPessoaId Write FPessoaId;
    Property EnderecoTipo: TEnderecoTipo Read FEnderecoTipo Write FEnderecoTipo;
    Property Endereco: String Read FEndereco Write FEndereco;
    Property Numero: String Read FNumero Write FNumero;
    Property Complemento: String Read FComplemento Write FComplemento;
    Property Referencia: String Read FReferencia Write FReferencia;
    Property Bairro: String Read FBairro Write FBairro;
    Property Municipio: String Read FMunicipio Write FMunicipio;
    Property Uf: String Read FUf Write FUf;
    Property Cep: String Read FCep Write FCep;
    Property CodIbge: String Read FCodIbge Write FCodIbge;
    Property Status: Integer Read FStatus Write FStatus;
  end;

  TPessoaTelefone = Class
  private
    FId: Integer;
    FPessoaId: Integer;
    FTipo: String;
    FTelefone: String;
    FCodPais: String;
    FContato: String;
    FObservacao: String;
    FStatus: Integer;
    FIndFone: Integer;
  Protected
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjPessoaTelefone
      : TPessoaTelefone): String;
    Class Function JsonToClass(Json: String): TPessoaTelefone;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Property Id: Integer Read FId Write FId;
    Property PessoaId: Integer Read FPessoaId Write FPessoaId;
    Property Tipo: String Read FTipo Write FTipo;
    Property Telefone: String Read FTelefone Write FTelefone;
    Property CodPais: String Read FCodPais Write FCodPais;
    Property Contato: String Read FContato Write FContato;
    Property Observacao: String Read FObservacao Write FObservacao;
    Property Status: Integer Read FStatus Write FStatus;
    Property IndFone: Integer Read FIndFone Write FIndFone;
  end;

implementation

{ TPessoa }

class function TPessoa.ClassToJson(Const ObjPessoa: TPessoa): String;
begin
  Result := tJson.ObjectToJsonString(ObjPessoa);
end;

class procedure TPessoa.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TPessoa.Create;
Begin
  FPessoatipo := TPessoaTipo.Create;
  Limpar;
End;

destructor TPessoa.Destroy;
begin
  FreeAndNil(FPessoatipo);
  inherited;
end;

class function TPessoa.JsonToClass(Json: String): TPessoa;
begin
  Result := TPessoa.Create;
  Result := tJson.JsonToObject<TPessoa>(Json, [joDateFormatUnix])
end;

procedure TPessoa.Limpar;
begin
  FPessoaId := 0;
  FCodpessoaerp := 0;
  Frazao := '';
  FFantasia := '';
  FCnpjcpf := '';
  FFone := '';
  FEmail := '';
  FHomepage := '';
  FRotaId := 0;
  FTransportadoraId := 0;
  FGoogleMaps := '';
  FLatitude := '';
  FLongitude := '';
  FShelflife := 0;
  FStatus := 0;
end;

{ TPessoaEndereco }

class function TPessoaEndereco.ClassToJson(const ObjPessoaEndereco
  : TPessoaEndereco): String;
begin
  Result := tJson.ObjectToJsonString(ObjPessoaEndereco);
end;

class procedure TPessoaEndereco.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin
  //
end;

constructor TPessoaEndereco.Create;
begin
  FId := 0;
  FPessoaId := 0;
  FEnderecoTipo := TEnderecoTipo.Create;;
  FEndereco := '';
  FNumero := '';
  FComplemento := '';
  FReferencia := '';
  FBairro := '';
  FMunicipio := '';
  FUf := '';
  FCep := '';
  FCodIbge := '';
  FStatus := 0;
end;

destructor TPessoaEndereco.Destroy;
begin
  FEnderecoTipo.Free;
  inherited;
end;

class function TPessoaEndereco.JsonToClass(Json: String): TPessoaEndereco;
begin
  Result := TPessoaEndereco.Create;
  Result := tJson.JsonToObject<TPessoaEndereco>(Json, [joDateFormatUnix]);
end;

{ TEnderecoTipo }

class function TEnderecoTipo.ClassToJson(const ObjEnderecoTipo
  : TEnderecoTipo): String;
begin
  Result := tJson.ObjectToJsonString(ObjEnderecoTipo);
end;

class procedure TEnderecoTipo.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TEnderecoTipo.Create;
begin
  FEnderecoTipoId := 0;
  FDescricao := '';
  FStatus := 0;
end;

class function TEnderecoTipo.JsonToClass(Json: String): TEnderecoTipo;
begin
  Result := TEnderecoTipo.Create;
  Result := tJson.JsonToObject<TEnderecoTipo>(Json, [joDateFormatUnix])
end;

{ TPessoaTelefone }

class function TPessoaTelefone.ClassToJson(const ObjPessoaTelefone
  : TPessoaTelefone): String;
begin
  Result := tJson.ObjectToJsonString(ObjPessoaTelefone);
end;

class procedure TPessoaTelefone.ConfigSizeField(Tabela: String;
  Sender: TObject);
begin

end;

constructor TPessoaTelefone.Create;
begin
  FId := 0;
  FPessoaId := 0;
  FTipo := '';
  FTelefone := '';
  FCodPais := '';
  FContato := '';
  FObservacao := '';
  FStatus := 0;
  FIndFone := 1;
end;

destructor TPessoaTelefone.Destroy;
begin

  inherited;
end;

class function TPessoaTelefone.JsonToClass(Json: String): TPessoaTelefone;
begin
  Result := TPessoaTelefone.Create;
  Result := tJson.JsonToObject<TPessoaTelefone>(Json, [joDateFormatUnix])
end;

End.
