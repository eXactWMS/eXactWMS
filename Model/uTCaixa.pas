unit uTCaixa;

interface

uses uTCaixaTipo, uTCaixaMotivoRetirada, System.Variants;

type
  TCaixaStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

  TCaixa = class
  private
    FCodigo: Int64;
    FCodigoTipo: Integer;
    FTipo: TCaixaTipo;
    FStatus: TCaixaStatus;
    FMotivoRetirada: TCaixaMotivoRetirada;

    function  getTipo: TCaixaTipo;
    procedure setMotivo(pMotivo: TCaixaMotivoRetirada);
    procedure setStatus(pStatus: TCaixaStatus);
    procedure setTipo(pTipo: TCaixaTipo);
  public
    property Codigo: Int64                          read FCodigo          write FCodigo;
    property Tipo: TCaixaTipo                       read getTipo          write setTipo;
    property Status: TCaixaStatus                   read FStatus          write setStatus;
    property MotivoRetirada: TCaixaMotivoRetirada   read FMotivoRetirada  write setMotivo;

    destructor Destroy; override;

    class procedure ExcluirCaixa(pCodigoCaixa: Int64);
    class procedure InserirCaixa(pCodigoTipo: Integer; pCodigoCaixa: Int64);
    class function  PegarCaixa(pCodigo: Int64): TCaixa;
    class function  GetCaixa(pCodigo: Int64): TCaixa;
    class function  Pesquisar(pCodigoInicial, pCodigoFinal: Int64): OleVariant;
    class procedure RegistrarEmLoja(pCodigoCaixa: Int64);
    class procedure RegistrarRetorno(pCodigoCaixa: Int64);
    class function  RelatorioStatus(pDtInicio : String= ''; pDtFinal : String = ''; pCdCaixaStatus : Integer = 0; pCdCliente : Integer = 0; pCdRota : Integer = 0): OleVariant;
    class procedure RetirarCaixa(pCodigoMotivo: Integer; pCodigoCaixa: Int64);
    Class Function RelRastreamentoStatus(pDtInicio : String= ''; pDtFinal : String = ''; pCdCaixaStatus : Integer = 0; pCdCliente : Integer = 0; pCdRota : Integer = 0) : OleVariant;
    Class Function RelCaixaSitRotaCli(pCdRota, pCdCliente : Integer; pDataInicial, pDataFinal : string) : OleVariant;
  end;
implementation

{ TCaixa }

uses uDmCaixa, SysUtils, DB, DBClient;

destructor TCaixa.Destroy;
begin
  FreeAndNil(FTipo);
  FreeAndNil(FStatus);
  FreeAndNil(FMotivoRetirada);

  inherited;
end;

class procedure TCaixa.ExcluirCaixa(pCodigoCaixa: Int64);
begin
  try
    dmCaixa.qryExcluirCaixa.Close;
    dmCaixa.qryExcluirCaixa.Parameters.ParamByName('pCdCaixa').Value := pCodigoCaixa;
    dmCaixa.qryExcluirCaixa.ExecSQL;
  except
    raise Exception.Create('Operação não permitida!' + #13 +
                           'Esta Caixa possui histórico de uso e não pode ser excluída.');
  end;
end;

function TCaixa.getTipo: TCaixaTipo;
begin
  if (Assigned(FTipo) = False) and (FCodigoTipo >= 0) then
    begin
      setTipo(TCaixaTipo.PegarTipoCaixa(FCodigoTipo));
    end;

  Result := FTipo;
end;

class procedure TCaixa.InserirCaixa(pCodigoTipo: Integer; pCodigoCaixa: Int64);
begin
  dmCaixa.qryInserirCaixa.Close;
  dmCaixa.qryInserirCaixa.Parameters.ParamByName('pCdCaixaTipo').Value := pCodigoTipo;
  dmCaixa.qryInserirCaixa.Parameters.ParamByName('pCdCaixa').Value     := pCodigoCaixa;
  dmCaixa.qryInserirCaixa.ExecSQL;
end;

class function TCaixa.GetCaixa(pCodigo: Int64): TCaixa;
var vlCaixa: TCaixa;
    vlStatus: TCaixaStatus;
    vlMotivoRetirada: TCaixaMotivoRetirada;
Begin
  dmCaixa.qryPegar.Close;
  dmCaixa.qryPegar.Parameters.ParamByName('pCdCaixa').Value := pCodigo;
  dmCaixa.qryPegar.Open;

  //////////// Criação do Onjeto Status //////////////
  vlStatus        := TCaixaStatus.Create;
  vlStatus.Codigo := dmCaixa.qryPegar.FieldByName('cdCaixaStatus').AsInteger;
  vlStatus.Nome   := dmCaixa.qryPegar.FieldByName('nmCaixaStatus').AsString;
  ////////////////////////////////////////////////////

  vlCaixa        := TCaixa.Create;
  vlCaixa.Codigo := dmCaixa.qryPegar.FieldByName('cdCaixa').AsLargeInt;
  vlCaixa.Status := vlStatus;

  if (dmCaixa.qryPegar.FieldByName('cdCaixaMotivoRetirada').AsInteger <> 0) then
    begin
      /////////// Criação do Objeto Motivo de Retirada ////////////
      vlMotivoRetirada        := TCaixaMotivoRetirada.Create;
      vlMotivoRetirada.Codigo := dmCaixa.qryPegar.FieldByName('cdCaixaMotivoRetirada').AsInteger;
      vlMotivoRetirada.Nome   := dmCaixa.qryPegar.FieldByName('nmCaixaMotivoRetirada').AsString;
      /////////////////////////////////////////////////////////////

      vlCaixa.MotivoRetirada  := vlMotivoRetirada;
    end;

  vlCaixa.FCodigoTipo := dmCaixa.qryPegar.FieldByName('cdCaixaTipo').AsInteger;

  Result := vlCaixa;
end;

class function TCaixa.PegarCaixa(pCodigo: Int64): TCaixa;
var
  vlCaixa: TCaixa;
  vlStatus: TCaixaStatus;
  vlMotivoRetirada: TCaixaMotivoRetirada;
begin

  dmCaixa.qryPegar.Close;
  dmCaixa.qryPegar.Parameters.ParamByName('pCdCaixa').Value := pCodigo;
  dmCaixa.qryPegar.Open;

  if (dmCaixa.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código da Caixa não encontrado!');
    end;

  //////////// Criação do Onjeto Status //////////////
  vlStatus        := TCaixaStatus.Create;
  vlStatus.Codigo := dmCaixa.qryPegar.FieldByName('cdCaixaStatus').AsInteger;
  vlStatus.Nome   := dmCaixa.qryPegar.FieldByName('nmCaixaStatus').AsString;
  ////////////////////////////////////////////////////

  vlCaixa        := TCaixa.Create;
  vlCaixa.Codigo := dmCaixa.qryPegar.FieldByName('cdCaixa').AsLargeInt;
  vlCaixa.Status := vlStatus;

  if (dmCaixa.qryPegar.FieldByName('cdCaixaMotivoRetirada').AsInteger <> 0) then
    begin
      /////////// Criação do Objeto Motivo de Retirada ////////////
      vlMotivoRetirada        := TCaixaMotivoRetirada.Create;
      vlMotivoRetirada.Codigo := dmCaixa.qryPegar.FieldByName('cdCaixaMotivoRetirada').AsInteger;
      vlMotivoRetirada.Nome   := dmCaixa.qryPegar.FieldByName('nmCaixaMotivoRetirada').AsString;
      /////////////////////////////////////////////////////////////

      vlCaixa.MotivoRetirada  := vlMotivoRetirada;
    end;

  vlCaixa.FCodigoTipo := dmCaixa.qryPegar.FieldByName('cdCaixaTipo').AsInteger;

  Result := vlCaixa;
end;

class function TCaixa.Pesquisar(pCodigoInicial, pCodigoFinal: Int64): OleVariant;
begin
  dmCaixa.qryPesquisar.Close;
  dmCaixa.qryPesquisar.Parameters.ParamByName('pCdCaixaInicial').Value := pCodigoInicial;
  dmCaixa.qryPesquisar.Parameters.ParamByName('pCdCaixaFinal').Value   := pCodigoFinal;
  dmCaixa.qryPesquisar.Open;

  Result := dmCaixa.dspPesquisar.Data;
end;

class procedure TCaixa.RegistrarEmLoja(pCodigoCaixa: Int64);
begin
  dmCaixa.qryRegistrarEmLoja.Close;
  dmCaixa.qryRegistrarEmLoja.Parameters.ParamByName('pCdCaixa').Value := pCodigoCaixa;
  dmCaixa.qryRegistrarEmLoja.ExecSQL;
end;

class procedure TCaixa.RegistrarRetorno(pCodigoCaixa: Int64);
begin
  dmCaixa.qryRegistrarRetorno.Close;
  dmCaixa.qryRegistrarRetorno.Parameters.ParamByName('pCdCaixa').Value := pCodigoCaixa;
  dmCaixa.qryRegistrarRetorno.ExecSQL;
end;

class function TCaixa.RelatorioStatus(pDtInicio, pDtFinal : String; pCdCaixaStatus, pCdCliente, pCdRota : Integer): OleVariant;
var
  vlCodigoStatus: string;
begin
{
   if (pCodigoStatus = 0) then
       vlCodigoStatus := '%'
   else
       vlCodigoStatus := pCdCaixaStatus;
}
  With dmCaixa.qryRelatorioStatus do Begin
    Close;
    if pDtInicio = '' then
       Parameters.ParamByName('pDtInicio').Value   := Null
    Else Parameters.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDtInicio));
    if PDtFinal  = '' then
       Parameters.ParamByName('pDtFinal').Value   := Null
    Else Parameters.ParamByName('pDtFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDtFinal));
    Parameters.ParamByName('pCdCaixaStatus').Value := pCdCaixaStatus;
    Parameters.ParamByName('pCdCliente').Value := pCdCliente;
    Parameters.ParamByName('pCdRota').Value    := pCdRota;
    Open;
  End;
  Result := dmCaixa.dspRelatorioStatus.Data;
end;

class function TCaixa.RelCaixaSitRotaCli(pCdRota, pCdCliente: Integer;
  pDataInicial, pDataFinal: string): OleVariant;
begin
  With dmCaixa.QryRelSituacaoPorCliente do Begin
    Close;
    Parameters.ParamByName('pCdRota').Value    := pCdRota;
    Parameters.ParamByName('pCdCliente').Value := pCdCliente;
    if pDataInicial = '' then Parameters.ParamByName('pDataInicial').Value := Null
    Else Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial));;
    if pDataFinal = '' then Parameters.ParamByName('pDataFinal').Value := Null
    Else Parameters.ParamByName('pDataFinal').Value := FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal));;
    Open;
  End;
  Result := DmCaixa.DspRelSituacaoPorCliente.Data;
end;

class function TCaixa.RelRastreamentoStatus(pDtInicio, pDtFinal : String; pCdCaixaStatus, pCdCliente, pCdRota : Integer): OleVariant;
begin
  With DmCaixa.QryRelRastreamentoStatus do Begin
    Close;
    if pDtInicio = '' then
       Parameters.ParamByName('pDtInicio').Value   := Null
    Else Parameters.ParamByName('pDtInicio').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDtInicio));
    if PDtFinal  = '' then
       Parameters.ParamByName('pDtFinal').Value   := Null
    Else Parameters.ParamByName('pDtFinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDtFinal));
    Parameters.ParamByName('pCdCaixaStatus').Value := pCdCaixaStatus;
    Parameters.ParamByName('pCdCliente').Value := pCdCliente;
    Parameters.ParamByName('pCdRota').Value    := pCdRota;
    Open;
  End;
  Result := DmCaixa.DspRelRastreamentoStatus.Data;
end;

class procedure TCaixa.RetirarCaixa(pCodigoMotivo: Integer; pCodigoCaixa: Int64);
begin
  dmCaixa.qryRetirarCaixa.Close;
  dmCaixa.qryRetirarCaixa.Parameters.ParamByName('pCdCaixaMotivoRetirada').Value := pCodigoMotivo;
  dmCaixa.qryRetirarCaixa.Parameters.ParamByName('pCdCaixa').Value               := pCodigoCaixa;
  dmCaixa.qryRetirarCaixa.ExecSQL;
end;

procedure TCaixa.setMotivo(pMotivo: TCaixaMotivoRetirada);
begin
  FreeAndNil(FMotivoRetirada);

  FMotivoRetirada := pMotivo;
end;

procedure TCaixa.setStatus(pStatus: TCaixaStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

procedure TCaixa.setTipo(pTipo: TCaixaTipo);
begin
  FreeAndNil(FTipo);

  FTipo := pTipo;

  if (Assigned(FTipo) = True) then
    begin
      FCodigoTipo := FTipo.Codigo;
    end
  else
    begin
      FCodigoTipo := -1;
    end;
end;

class function TCaixaStatus.ListarStatus: OleVariant;
begin
  dmCaixa.qryListarCxaStatus.Close;
  dmCaixa.qryListarCxaStatus.Open;

  Result := dmCaixa.dspListarCxaStatus.Data;
end;

end.
