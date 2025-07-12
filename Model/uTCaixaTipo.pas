unit uTCaixaTipo;

interface

uses uTHistorico;

type
  TCaixaTipoStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

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

    procedure ValidarDados;
  public
    property Codigo: Integer          read FCodigo          write FCodigo;
    property Nome: string             read FNome            write FNome;
    property Altura: Integer          read FAltura          write FAltura;
    property Largura: Integer         read FLargura         write FLargura;
    property Comprimento: Integer     read FComprimento     write FComprimento;
    property Volume: Integer          read FVolume;
    property Aproveitamento: Integer  read FAproveitamento  write FAproveitamento;
    property Peso: Integer            read FPeso            write FPeso;
    property Capacidade: Integer      read FCapacidade      write FCapacidade;
    property QtdLacre: Integer        read FQtdLacre        write FQtdLacre;
    property ValorUnitario: Currency  read FValorUnitario   write FValorUnitario;
    property Rastrear: Boolean        read FRastrear        write FRastrear;
    property Status: TCaixaTipoStatus read FStatus          write setStatus;

    destructor Destroy; override;

    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function PegarTipoCaixa(pCodigo: Integer): TCaixaTipo;
    class function Pesquisar(pCodigo, pNome, pRastrear, pStatus: string): OleVariant;

    function CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
    procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses uDmCaixaTipo, SysUtils, DBClient, DB;

{ TCaixaTipo }

function TCaixaTipo.CalcularVolume(pAltura, pLargura, pComprimento: Integer): Integer;
begin
  Result := (pAltura * pLargura * pComprimento);
end;

destructor TCaixaTipo.Destroy;
begin
  FreeAndNil(FStatus);

  inherited;
end;

class procedure TCaixaTipo.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmCaixaTipo.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmCaixaTipo.qryExcluir.Connection.BeginTrans;

    dmCaixaTipo.qryExcluir.Close;
    dmCaixaTipo.qryExcluir.Parameters.ParamByName('pCdCaixaTipo').Value := pCodigo;
    dmCaixaTipo.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro do Tipo de Caixa';

    pHistorico.Salvar;

    dmCaixaTipo.qryExcluir.Connection.CommitTrans;
  except
    dmCaixaTipo.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste Tipo de Caixa.');
  end;
end;

class function TCaixaTipo.PegarTipoCaixa(pCodigo: Integer): TCaixaTipo;
var
  vlTipo: TCaixaTipo;
  vlStatus: TCaixaTipoStatus;
begin
   dmCaixaTipo.qryPegar.Close;
   dmCaixaTipo.qryPegar.Parameters.ParamByName('pCdCaixaTipo').Value := pCodigo;
   dmCaixaTipo.qryPegar.Open;

  if (dmCaixaTipo.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Tipo de Caixa não encontrado!');
    end;

  ///////// Criação do Objeto Status ///////////
  vlStatus        := TCaixaTipoStatus.Create;
  vlStatus.Codigo := dmCaixaTipo.qryPegar.FieldByName('cdCaixaTipoStatus').AsInteger;
  vlStatus.Nome   := dmCaixaTipo.qryPegar.FieldByName('nmCaixaTipoStatus').AsString;
  //////////////////////////////////////////////

  vlTipo                := TCaixaTipo.Create;
  vlTipo.Codigo         := dmCaixaTipo.qryPegar.FieldByName('cdCaixaTipo').AsLargeInt;
  vlTipo.Nome           := dmCaixaTipo.qryPegar.FieldByName('nmCaixaTipo').AsString;
  vlTipo.Altura         := dmCaixaTipo.qryPegar.FieldByName('Altura').AsInteger;
  vlTipo.Largura        := dmCaixaTipo.qryPegar.FieldByName('Largura').AsInteger;
  vlTipo.Comprimento    := dmCaixaTipo.qryPegar.FieldByName('Comprimento').AsInteger;
  vlTipo.FVolume        := dmCaixaTipo.qryPegar.FieldByName('Volume').AsInteger;
  vlTipo.Aproveitamento := dmCaixaTipo.qryPegar.FieldByName('Aproveitamento').AsInteger;
  vlTipo.Peso           := dmCaixaTipo.qryPegar.FieldByName('Peso').AsInteger;
  vlTipo.Capacidade     := dmCaixaTipo.qryPegar.FieldByName('Capacidade').AsInteger;
  vlTipo.QtdLacre       := dmCaixaTipo.qryPegar.FieldByName('qtLacre').AsInteger;
  vlTipo.ValorUnitario  := dmCaixaTipo.qryPegar.FieldByName('vlUnitario').AsCurrency;
  vlTipo.Rastrear       := dmCaixaTipo.qryPegar.FieldByName('Rastrear').AsInteger = 1;
  vlTipo.Status         := vlStatus;

  Result := vlTipo;
end;

class function TCaixaTipo.Pesquisar(pCodigo, pNome, pRastrear, pStatus: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  if (Trim(pRastrear) = '') then
    begin
      pRastrear := '%';
    end;

  if (Trim(pStatus) = '') then
    begin
      pStatus := '%';
    end;

  dmCaixaTipo.qryPesquisar.Close;
  dmCaixaTipo.qryPesquisar.Parameters.ParamByName('pCdCaixaTipo').Value       := pCodigo;
  dmCaixaTipo.qryPesquisar.Parameters.ParamByName('pNmCaixaTipo').Value       := '%' + pNome + '%';
  dmCaixaTipo.qryPesquisar.Parameters.ParamByName('pRastrear').Value          := pRastrear;
  dmCaixaTipo.qryPesquisar.Parameters.ParamByName('pCdCaixaTipoStatus').Value := pStatus;
  dmCaixaTipo.qryPesquisar.Open;

  Result := dmCaixaTipo.dspPesquisar.Data;
end;

procedure TCaixaTipo.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  FVolume := CalcularVolume(FAltura, FLargura, FComprimento);

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de novo Tipo de Caixa: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Cadastro do Tipo de Caixa: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmCaixaTipo.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmCaixaTipo.qrySalvar.Connection.BeginTrans;

    dmCaixaTipo.qrySalvar.Close;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pCdCaixaTipo').Value       := FCodigo;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pNmCaixaTipo').Value       := FNome;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pAltura').Value            := FAltura;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pLargura').Value           := FLargura;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pComprimento').Value       := FComprimento;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pVolume').Value            := FVolume;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pAproveitamento').Value    := FAproveitamento;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pPeso').Value              := FPeso;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pCapacidade').Value        := FCapacidade;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pQtLacre').Value           := FQtdLacre;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pVlUnitario').Value        := FValorUnitario;
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pRastrear').Value          := Ord(FRastrear);
    dmCaixaTipo.qrySalvar.Parameters.ParamByName('pCdCaixaTipoStatus').Value := FStatus.Codigo;
    dmCaixaTipo.qrySalvar.Open;

    FCodigo := dmCaixaTipo.qrySalvar.FieldByName('cdCaixaTipo').AsInteger;

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmCaixaTipo.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmCaixaTipo.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TCaixaTipo.setStatus(pStatus: TCaixaTipoStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

procedure TCaixaTipo.ValidarDados;
begin
  if (FAproveitamento <= 0) then
    begin
      raise Exception.Create('Aproveitamento do Tipo de Caixa inválido!');
    end;

  if (FStatus.Codigo = 2) then // 2 = Inativo
    begin
      dmCaixaTipo.qryVinculos.Close;
      dmCaixaTipo.qryVinculos.Parameters.ParamByName('pCdCaixaTipo').Value := FCodigo;
      dmCaixaTipo.qryVinculos.Open;

      if (dmCaixaTipo.qryVinculos.IsEmpty = False) then
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Este Tipo de Caixa possui vínculos com Rotas, Saídas ou Caixas que estão ativas.');
        end;
    end;
end;

class function TCaixaTipoStatus.ListarStatus: OleVariant;
begin
  dmCaixaTipo.qryListarCxaTpStatus.Close;
  dmCaixaTipo.qryListarCxaTpStatus.Open;

  Result := dmCaixaTipo.dspListarCxaTpStatus.Data;
end;

end.
