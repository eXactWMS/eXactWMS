unit uTRota;

interface

uses uTCaixaTipo, uTMotorista, uTCaminhao, uTHistorico;

type
  TRotaStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarStatus: OleVariant;
  end;

  TRota = class
  private
    FCodigo: Integer;
    FCodigoAnterior: Integer;
    FNome: string;
    FStatus: TRotaStatus;
    FCodigoTipoCaixa: Integer;
    FCodigoMotorista: Integer;
    FCodigoCaminhao: Integer;
    FTipoCaixa: TCaixaTipo;
    FMotorista: TMotorista;
    FCaminhao: TCaminhao;

    function  getCaminhao: TCaminhao;
    function  getMotorista: TMotorista;
    function  getTipoCaixa: TCaixaTipo;
    procedure setCaminhao(pCaminhao: TCaminhao);
    procedure setMotorista(pMotorista: TMotorista);
    procedure setStatus(pStatus: TRotaStatus);
    procedure setTipoCaixa(pTipo: TCaixaTipo);

    procedure SalvarClientes(pClientes: OleVariant);
    procedure ValidarDados(pCodigoTipo, pCodigoMotorista, pCodigoCaminhao: Integer);
  public
    property Codigo: Integer        read FCodigo       write FCodigo;
    property Nome: string           read FNome         write FNome;
    property Status: TRotaStatus    read FStatus       write setStatus;
    property TipoCaixa: TCaixaTipo  read getTipoCaixa  write setTipoCaixa;
    property Motorista: TMotorista  read getMotorista  write setMotorista;
    property Caminhao: TCaminhao    read getCaminhao   write setCaminhao;

    constructor Create;
    destructor Destroy; override;

    class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
    class function  PegarRota(pCodigo: Integer): TRota;
    Class Function GetNome(pCdRota : Integer) : String;
    class function  Pesquisar(pCodigo, pNome, pStatus: string): OleVariant;

    function  ListarClientes: OleVariant;
    procedure Salvar(pCodigoTipo, pCodigoMotorista, pCodigoCaminhao: Integer; pClientes: OleVariant; pHistorico: THistorico);
  end;

implementation

{ TRota }

uses uDmRota, SysUtils, DBClient, DB, uTTransportadora;

constructor TRota.Create;
begin
  FCodigoAnterior := 0;
end;

destructor TRota.Destroy;
begin
  FreeAndNil(FStatus);
  FreeAndNil(FTipoCaixa);
  FreeAndNil(FMotorista);
  FreeAndNil(FCaminhao);

  inherited;
end;

class procedure TRota.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmRota.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmRota.qryExcluir.Connection.BeginTrans;

    dmRota.qryExcluir.Close;
    dmRota.qryExcluir.Parameters.ParamByName('pCdRota').Value := pCodigo;
    dmRota.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro da Rota';

    pHistorico.Salvar;

    dmRota.qryExcluir.Connection.CommitTrans;
  except
    dmRota.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão desta Rota.');
  end;
end;

function TRota.getCaminhao: TCaminhao;
begin
  if (Assigned(FCaminhao) = False) and (FCodigoCaminhao > 0) then
    begin
      setCaminhao(TCaminhao.PegarCaminhao(FCodigoCaminhao));
    end;

  Result := FCaminhao;
end;

function TRota.getMotorista: TMotorista;
begin
  if (Assigned(FMotorista) = False) and (FCodigoMotorista > 0) then
    begin
      setMotorista(TMotorista.PegarMotorista(FCodigoMotorista));
    end;

  Result := FMotorista;
end;

class function TRota.GetNome(pCdRota: Integer): String;
begin
  With dmRota.qryPegar do Begin
    Close;
    Parameters.ParamByName('pCdRota').Value := pCdRota;
    Open;
    Result := FieldByName('NmRota').AsString;
    Close;
  End;
end;

function TRota.getTipoCaixa: TCaixaTipo;
begin
  if (Assigned(FTipoCaixa) = False) and (FCodigoTipoCaixa >= 0) then
    begin
      setTipoCaixa(TCaixaTipo.PegarTipoCaixa(FCodigoTipoCaixa));
    end;

  Result := FTipoCaixa;
end;

function TRota.ListarClientes: OleVariant;
begin
  dmRota.qryListarClientes.Close;
  dmRota.qryListarClientes.Parameters.ParamByName('pCdRota').Value := FCodigo;
  dmRota.qryListarClientes.Open;

  Result := dmRota.dspListarClientes.Data;
end;

class function TRota.PegarRota(pCodigo: Integer): TRota;
var
  vlRota: TRota;
  vlStatus: TRotaStatus;
begin
  dmRota.qryPegar.Close;
  dmRota.qryPegar.Parameters.ParamByName('pCdRota').Value := pCodigo;
  dmRota.qryPegar.Open;

  if (dmRota.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código da Rota não encontrado!');
    end;

  ///////// Criação do Objeto Status ///////////
  vlStatus        := TRotaStatus.Create;
  vlStatus.Codigo := dmRota.qryPegar.FieldByName('cdRotaStatus').AsInteger;
  vlStatus.Nome   := dmRota.qryPegar.FieldByName('nmRotaStatus').AsString;
  //////////////////////////////////////////////

  vlRota           := TRota.Create;
  vlRota.Codigo    := dmRota.qryPegar.FieldByName('cdRota').AsInteger;
  vlRota.Nome      := dmRota.qryPegar.FieldByName('nmRota').AsString;
  vlRota.Status    := vlStatus;

  vlRota.FCodigoTipoCaixa := dmRota.qryPegar.FieldByName('cdCaixaTipo').AsInteger;
  vlRota.FCodigoMotorista := dmRota.qryPegar.FieldByName('cdMotorista').AsInteger;
  vlRota.FCodigoCaminhao  := dmRota.qryPegar.FieldByName('cdCaminhao').AsInteger;

  vlRota.FCodigoAnterior := vlRota.Codigo;

  Result := vlRota;
end;

class function TRota.Pesquisar(pCodigo, pNome, pStatus: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  if (Trim(pStatus) = '') then
    begin
      pStatus := '%';
    end;

  dmRota.qryPesquisar.Close;
  dmRota.qryPesquisar.Parameters.ParamByName('pCdRota').Value       := pCodigo;
  dmRota.qryPesquisar.Parameters.ParamByName('pNmRota').Value       := '%' + pNome + '%';
  dmRota.qryPesquisar.Parameters.ParamByName('pCdRotaStatus').Value := pStatus;
  dmRota.qryPesquisar.Open;

  Result := dmRota.dspPesquisar.Data;
end;

procedure TRota.Salvar(pCodigoTipo, pCodigoMotorista, pCodigoCaminhao: Integer; pClientes: OleVariant; pHistorico: THistorico);
begin
  ValidarDados(pCodigoTipo, pCodigoMotorista, pCodigoCaminhao);

  try
    dmRota.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmRota.qrySalvar.Connection.BeginTrans;

    dmRota.qrySalvar.Close;
    dmRota.qrySalvar.Parameters.ParamByName('pCdRota').Value          := FCodigo;
    dmRota.qrySalvar.Parameters.ParamByName('pNmRota').Value          := FNome;
    dmRota.qrySalvar.Parameters.ParamByName('pCdRotaStatus').Value    := FStatus.Codigo;
    dmRota.qrySalvar.Parameters.ParamByName('pCdCaixaTipo').Value     := FCodigoTipoCaixa;
    dmRota.qrySalvar.Parameters.ParamByName('pCdMotorista').Value     := FCodigoMotorista;
    dmRota.qrySalvar.Parameters.ParamByName('pCdCaminhao').Value      := FCodigoCaminhao;
    dmRota.qrySalvar.Parameters.ParamByName('pCdRotaAnterior').Value  := FCodigoAnterior;
    dmRota.qrySalvar.ExecSQL;

    SalvarClientes(pClientes);

    if (FCodigoAnterior = 0) then
      begin
        pHistorico.CodigoRegistro := FCodigo;
        pHistorico.Observacao     := 'Cadastro de nova Rota: ' + FNome;
        pHistorico.Salvar;
      end
    else
      begin
        pHistorico.CodigoRegistro := FCodigo;
        pHistorico.Observacao     := 'Alteração do Cadastro da Rota: ' + FNome;
        pHistorico.Salvar;

        if (FCodigo <> FCodigoAnterior) then
          begin
            pHistorico.Observacao := 'Código anterior da Rota: ' + IntToStr(FCodigoAnterior);
            pHistorico.Salvar;

            pHistorico.CodigoRegistro := FCodigoAnterior;
            pHistorico.Observacao     := 'Alteração do Cadastro da Rota: ' + FNome;
            pHistorico.Salvar;

            pHistorico.Observacao := 'Código da Rota alterado para ' + IntToStr(FCodigo);
            pHistorico.Salvar;
          end;
      end;

    dmRota.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmRota.qrySalvar.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TRota.SalvarClientes(pClientes: OleVariant);
var
  vlClientes: TClientDataSet;
begin
  dmRota.qryLimparClientes.Close;
  dmRota.qryLimparClientes.Parameters.ParamByName('pCdRotaAnterior').Value := FCodigoAnterior;
  dmRota.qryLimparClientes.ExecSQL;

  vlClientes := TClientDataSet.Create(nil);
  try
    vlClientes.Close;
    vlClientes.Data := pClientes;

    vlClientes.First;
    while (vlClientes.Eof = False) do
      begin
        dmRota.qrySalvarCliente.Close;
        dmRota.qrySalvarCliente.Parameters.ParamByName('pCdRota').Value    := FCodigo;
        dmRota.qrySalvarCliente.Parameters.ParamByName('pOrdemRota').Value := vlClientes.FieldByName('OrdemRota').Value;
        dmRota.qrySalvarCliente.Parameters.ParamByName('pCdCliente').Value := vlClientes.FieldByName('cdCliente').Value;
        dmRota.qrySalvarCliente.ExecSQL;

        vlClientes.Next;
      end;
  finally
    FreeAndNil(vlClientes);
  end;
end;

procedure TRota.setCaminhao(pCaminhao: TCaminhao);
begin
  FreeAndNil(FCaminhao);

  FCaminhao := pCaminhao;

  if (Assigned(FCaminhao) = True) then
    begin
      FCodigoCaminhao := FCaminhao.Codigo;
    end
  else
    begin
      FCodigoCaminhao := 0;
    end;
end;

procedure TRota.setMotorista(pMotorista: TMotorista);
begin
  FreeAndNil(FMotorista);

  FMotorista := pMotorista;

  if (Assigned(FMotorista) = True) then
    begin
      FCodigoMotorista := FMotorista.Codigo;
    end
  else
    begin
      FCodigoMotorista := 0;
    end;
end;

procedure TRota.setStatus(pStatus: TRotaStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;
end;

procedure TRota.setTipoCaixa(pTipo: TCaixaTipo);
begin
  FreeAndNil(FTipoCaixa);

  FTipoCaixa := pTipo;

  if (Assigned(FTipoCaixa) = True) then
    begin
      FCodigoTipoCaixa := FTipoCaixa.Codigo;
    end
  else
    begin
      FCodigoTipoCaixa := -1;
    end;
end;

procedure TRota.ValidarDados(pCodigoTipo, pCodigoMotorista, pCodigoCaminhao: Integer);
var
  vlRota: TRota;
begin
  if (FCodigo <> FCodigoAnterior) then
    begin
      try
        vlRota := TRota.PegarRota(FCodigo);
      except
        vlRota := nil;
      end;

      if (Assigned(vlRota) = True) then
        begin
          try
            raise Exception.Create('Código inválido!' + #13 +
                                   'Já existe outra Rota cadastrada com o código informado: ' + #13 + #13 +
                                   'Código: ' + IntToStr(vlRota.Codigo) + #13 +
                                   'Nome: ' + vlRota.Nome);
          finally
            FreeAndNil(vlRota);
          end;
        end;
    end;

  if (FStatus.Codigo = 2) then // 2 = Inativo
    begin
      dmRota.qryVinculos.Close;
      dmRota.qryVinculos.Parameters.ParamByName('pCdRota').Value := FCodigo;
      dmRota.qryVinculos.Open;

      if (dmRota.qryVinculos.IsEmpty = False) then
        begin
          raise Exception.Create('Operação não permitida!' + #13 +
                                 'Esta Rota possui vínculos com Cargas que estão ativas.');
        end;
    end;

  ////////// Validar Tipo de Caixa /////////////
  try
    TipoCaixa := TCaixaTipo.PegarTipoCaixa(pCodigoTipo);
  except
    raise Exception.CreateHelp('Tipo de Caixa não encontrado!' + #13 +
                               'O Tipo de Caixa selecionado não existe ou foi excluído. Selecione outro Tipo de Caixa para continuar o cadastro.', 1);
  end;

  if (FStatus.Codigo = 1) and (TipoCaixa.Status.Codigo = 2) then // 1 = Rota Ativa e 2 = Tipo de Caixa Inativo
    begin
      raise Exception.CreateHelp('Tipo de Caixa inválido!' + #13 +
                                 'O Tipo de Caixa selecionado foi inativado. Selecione outro Tipo de Caixa para continuar o cadastro.', 1);
    end;
  //////////////////////////////////////////////

  ////////// Validar Motorista /////////////
  try
    Motorista := TMotorista.PegarMotorista(pCodigoMotorista);
  except
    raise Exception.CreateHelp('Motorista não encontrado!' + #13 +
                               'O Motorista selecionado não existe ou foi excluído. Selecione outro Motorista para continuar o cadastro.', 2);
  end;

  if (FStatus.Codigo = 1) and (Motorista.Status.Codigo = 2) then // 1 = Rota Ativa e 2 = Motorista Inativo
    begin
      raise Exception.CreateHelp('Motorista inválido!' + #13 +
                                 'O Motorista selecionado foi inativado. Selecione outro Motorista para continuar o cadastro.', 2);
    end;
  //////////////////////////////////////////////

  ////////// Validar Caminhão /////////////
  try
    Caminhao := TCaminhao.PegarCaminhao(pCodigoCaminhao);
  except
    raise Exception.CreateHelp('Caminhão não encontrado!' + #13 +
                               'O Caminhão selecionado não existe ou foi excluído. Selecione outro Caminhão para continuar o cadastro.', 3);
  end;

  if (FStatus.Codigo = 1) and (Caminhao.Status.Codigo = 2) then // 1 = Rota Ativa e 2 = Caminhão Inativo
    begin
      raise Exception.CreateHelp('Caminhão inválido!' + #13 +
                                 'O Caminhão selecionado foi inativado. Selecione outro Caminhão para continuar o cadastro.', 3);
    end;
  //////////////////////////////////////////////
end;

class function TRotaStatus.ListarStatus: OleVariant;
begin
  dmRota.qryListarRotaStatus.Close;
  dmRota.qryListarRotaStatus.Open;

  Result := dmRota.dspListarRotaStatus.Data;
end;

end.
