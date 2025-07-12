unit uTCliente;

interface

uses uTRota, uTHistorico;

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    FIdCep : String;
    FLog_Nu_Sequencial : Integer;
    FEndereco : String;
    FComplementoEndereco : String;
    FIdBairro : Integer;
    FIdCidade : String;
    FDdd      : Integer;
    FFone     : String;
    FEmail    : String;
    FResponsavel : String;

    FCodigoRota: Integer;
    FRota: TRota;

    function  getRota: TRota;
    procedure setRota(pRota: TRota);
  public
    property Codigo: Integer   read FCodigo  write FCodigo;
    property Nome: string      read FNome    write FNome;
    property Rota: TRota       read getRota  write setRota;
    Property IdCep : String    Read FIdCep   Write FIdCep;
    Property Log_Nu_Sequencial : Integer  Read FLog_Nu_Sequencial Write FLog_Nu_Sequencial;
    Property Endereco : String            Read FEndereco          Write Fendereco;
    Property ComplementoEndereco : String Read FComplementoEndereco Write FComplementoEndereco;
    Property IdBairro : Integer           Read FidBairro    Write FIdBairro;
    Property IdCidade : String            Read FIdCidade    Write FIdCidade;
    Property Ddd  : Integer               Read FDdd         Write FDdd;
    Property Fone : String                Read FFone        Write FFone;
    Property Email : String               Read FEmail       Write FEmail;
    Property Responsavel : String         Read FResponsavel Write FResponsavel;

    destructor Destroy; override;

    class function PegarCliente(pCodigo: Integer): TCliente;
    class function PegarNomeCliente(pNome : String): TCliente;
    class function Pesquisar(pCodigo, pNome: string): OleVariant;
    Class Function GetNome(pCdCliente : Integer) : String;
    procedure Salvar(pHistorico: THistorico);
  end;

implementation

{ TCliente }

uses uDmCliente, SysUtils, DBClient, DB;

destructor TCliente.Destroy;
begin
  FreeAndNil(FRota);

  inherited;
end;

class function TCliente.GetNome(pCdCliente: Integer): String;
begin
  With dmCliente.QryPegar do Begin
    Close;
    Parameters.ParamByName('pCdCliente').Value := pCdCliente;
    Open;
    Result := FieldByName('NmCliente').AsString;
    Close;
  End;
end;

function TCliente.getRota: TRota;
begin
  if (Assigned(FRota) = False) and (FCodigoRota >= 0) then
    begin
      setRota(TRota.PegarRota(FCodigoRota));
    end;

  Result := FRota;
end;

class function TCliente.PegarCliente(pCodigo: Integer): TCliente;
var
  vlCodigo: Integer;
  vlCliente: TCliente;
begin
  if (pCodigo < 0) then
    begin
      vlCodigo := pCodigo * -1;
    end
  else
    begin
      vlCodigo := pCodigo;
    end;
  With dmCliente.qryPegar do begin
    Close;
    Parameters.ParamByName('pCdCliente').Value := vlCodigo;
    Open;
    if (IsEmpty = True) then
      raise Exception.Create('Código do Cliente não encontrado!');
    vlCliente := TCliente.Create;
    if (pCodigo < 0) then begin
       vlCliente.Codigo := 0;
       vlCliente.Nome   := 'DADOS DO CLIENTE OCULTOS';
    end
    else begin
      vlCliente.Codigo := FieldByName('cdCliente').AsInteger;
      vlCliente.Nome   := FieldByName('nmCliente').AsString;
    end;
    vlCliente.IdCep    := FieldByName('IdCep').AsString;
    vlCliente.Endereco := FieldByName('Endereco').AsString;
    vlCliente.FComplementoEndereco :=  FieldByName('ComplementoEndereco').AsString;
    vlCliente.IdBairro := StrToIntDef(FieldByName('IdBairro').AsString, 0);
    vlCliente.IdCidade := FieldByName('IdCidade').AsString;
    vlCliente.Ddd      := FieldByName('Ddd').AsInteger;
    VlCliente.Fone     := FieldByName('Fone').AsString;
    vlCliente.Email    := FieldByName('Email').AsString;
    vlCliente.Responsavel := FieldByName('Responsavel').AsString;
    vlCliente.FCodigoRota := StrToIntDef(FieldByName('cdRota').AsString, 0);;
  End;
  Result := vlCliente;
end;

class function TCliente.PegarNomeCliente(pNome: String): TCliente;
var
  vlCodigo: Integer;
  vlCliente: TCliente;
begin
  if (pNome = '') then
     raise Exception.Create('Nome inválido para pesquisa no Banco de Dados!');
  With dmCliente.qryPegarNome do Begin
    Close;
    Parameters.ParamByName('pNmCliente').Value := pNome;
    Open;
    if IsEmpty = True then
       raise Exception.Create('Nome do Cliente não encontrado!');
    vlCliente := TCliente.Create;
    vlCliente.Codigo      := FieldByName('cdCliente').AsInteger;
    vlCliente.Nome        := FieldByName('nmCliente').AsString;
    vlCliente.IdCep       := FieldByName('IdCep').AsString;
    vlCliente.Endereco    := FieldByName('Endereco').AsString;
    vlCliente.FComplementoEndereco :=  FieldByName('ComplementoEndereco').AsString;
    vlCliente.IdBairro    := StrToIntDef(FieldByName('IdBairro').AsString, 0);
    vlCliente.IdCidade    := FieldByName('IdCidade').AsString;
    vlCliente.Ddd         := FieldByName('Ddd').AsInteger;
    VlCliente.Fone        := FieldByName('Fone').AsString;
    vlCliente.Email       := FieldByName('Email').AsString;
    vlCliente.Responsavel := FieldByName('Responsavel').AsString;
    vlCliente.FCodigoRota := StrToIntDef(FieldByName('cdRota').AsString, 0);;
  End;
  Result := vlCliente;
end;

class function TCliente.Pesquisar(pCodigo, pNome: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  dmCliente.qryPesquisar.Close;
  dmCliente.qryPesquisar.Parameters.ParamByName('pCdCliente').Value := pCodigo;
  dmCliente.qryPesquisar.Parameters.ParamByName('pNmCliente').Value := '%' + pNome + '%';
  dmCliente.qryPesquisar.Open;

  Result := dmCliente.dspPesquisar.Data;
end;

procedure TCliente.Salvar(pHistorico: THistorico);
begin
  DmCliente.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
  DmCliente.qrySalvar.Connection.BeginTrans;

  try
    With DmCliente.qrySalvar do begin
      Close;
      Parameters.ParamByName('pCodigo').Value      := Self.Codigo;
      Parameters.ParamByName('pCodRota').Value     := Self.Rota.Codigo;
      Parameters.ParamByName('pIdCep').Value       := Self.IdCep;
      Parameters.ParamByName('pEndereco').Value    := Self.Endereco;
      Parameters.ParamByName('pComplementoEndereco').Value   := Self.ComplementoEndereco;
      Parameters.ParamByName('pIdBairro').Value    := Self.IdBairro;
      Parameters.ParamByName('pIdCidade').Value    := Self.IdCidade;
      Parameters.ParamByName('pDdd').Value         := Self.Ddd;
      Parameters.ParamByName('pFone').Value        := Self.Fone;
      Parameters.ParamByName('pEmail').Value       := Self.Email;
      Parameters.ParamByName('pResponsavel').Value := Self.Responsavel;
      ExecSQL;
      pHistorico.CodigoRegistro := Self.Codigo;
      pHistorico.Observacao     := 'Alteração do Cadastro de Cliente';
      pHistorico.Salvar;
      Connection.CommitTrans;
    end;
  except on e: Exception do
    begin
      DmCliente.qrySalvar.Connection.RollbackTrans;
      raise Exception.Create(e.Message);
    end;
  end;

end;

procedure TCliente.setRota(pRota: TRota);
begin
  FreeAndNil(FRota);

  FRota := pRota;

  if (Assigned(FRota) = True) then
    begin
      FCodigoRota := FRota.Codigo;
    end
  else
    begin
      FCodigoRota := 0;
    end;
end;

end.
