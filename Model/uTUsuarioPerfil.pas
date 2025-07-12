unit uTUsuarioPerfil;

interface

uses
  uTHistorico;

type
  TUsuarioPerfil = class
    private
      FCodigo: Integer;
      FNome: string;
      FModulos: OleVariant;
      FFuncoes: OleVariant;

      procedure SalvarFuncoes;
      procedure SalvarModulos;
    public
      property Codigo: Integer      read FCodigo    write FCodigo;
      property Nome: string         read FNome      write FNome;
      property Modulos: OleVariant  read FModulos   write FModulos;
      property Funcoes: OleVariant  read FFuncoes   write FFuncoes;

      class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
      class function  ListarFuncoes(pCodigo: Integer): OleVariant;
      class function  ListarModulos(pCodigo: Integer): OleVariant;
      class function  PegarPerfil(pCodigo: Integer): TUsuarioPerfil;
      Class Function  PegarModulo(pCodigo : Integer) : String;
      Class Function  PegarFuncao(pCodigo : Integer) : String;
      class function  Pesquisar(pCodigo, pNome: string): OleVariant;

      procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses uDmUsuarioPerfil, SysUtils, DBClient, DB;

{ TUsuarioPerfil }

class procedure TUsuarioPerfil.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmUsuarioPerfil.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmUsuarioPerfil.qryExcluir.Connection.BeginTrans;

    dmUsuarioPerfil.qryExcluir.Close;
    dmUsuarioPerfil.qryExcluir.Parameters.ParamByName('pCdPerfil').Value := pCodigo;
    dmUsuarioPerfil.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Perfil de Usuário';

    pHistorico.Salvar;

    dmUsuarioPerfil.qryExcluir.Connection.CommitTrans;
  except
    dmUsuarioPerfil.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem usuários cadastrados com este perfil.' + #13 +
                           'Altere o perfil destes usuários antes de realizar esta exclusão.');
  end;
end;

class function TUsuarioPerfil.ListarFuncoes(pCodigo: Integer): OleVariant;
begin
  dmUsuarioPerfil.qryListarFuncoes.Close;
  dmUsuarioPerfil.qryListarFuncoes.Parameters.ParamByName('pCdPerfil').Value := pCodigo;
  dmUsuarioPerfil.qryListarFuncoes.Open;

  Result := dmUsuarioPerfil.dspListarFuncoes.Data;
end;

class function TUsuarioPerfil.ListarModulos(pCodigo: Integer): OleVariant;
begin
  dmUsuarioPerfil.qryListarModulos.Close;
  dmUsuarioPerfil.qryListarModulos.Parameters.ParamByName('pCdPerfil').Value := pCodigo;
  dmUsuarioPerfil.qryListarModulos.Open;

  Result := dmUsuarioPerfil.dspListarModulos.Data;
end;

class function TUsuarioPerfil.PegarFuncao(pCodigo: Integer): String;
begin
  With dmUsuarioPerfil.QryPegarFuncao do Begin
    Close;
    Parameters.ParamByName('pCdFuncao').Value := pCodigo;
    Open;
    Result := FieldByName('NmFuncao').AsString;
    Close;
  End;
end;

class function TUsuarioPerfil.PegarModulo(pCodigo: Integer): String;
begin
  With dmUsuarioPerfil.QryPegarModulo do Begin
    Close;
    Parameters.ParamByName('pCdModulo').Value := pCodigo;
    Open;
    Result := FieldByName('NmModulo').AsString;
    Close;
  End;
end;

class function TUsuarioPerfil.PegarPerfil(pCodigo: Integer): TUsuarioPerfil;
var
  vlPerfil: TUsuarioPerfil;
  vlPesquisar: TClientDataSet;
begin
  vlPerfil    := TUsuarioPerfil.Create;
  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Data := Pesquisar(IntToStr(pCodigo), '%');

    if (vlPesquisar.IsEmpty = True) then
      begin
        raise Exception.Create('Código do Perfil inválido!');
      end;

    vlPerfil.Codigo  := vlPesquisar.FieldByName('cdPerfil').AsInteger;
    vlPerfil.Nome    := vlPesquisar.FieldByName('nmPerfil').AsString;
    vlPerfil.Modulos := ListarModulos(vlPerfil.Codigo);
    vlPerfil.Funcoes := ListarFuncoes(vlPerfil.Codigo);
  finally
    FreeAndNil(vlPesquisar);
  end;

  Result := vlPerfil;
end;

class function TUsuarioPerfil.Pesquisar(pCodigo, pNome: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%';
    end;

  if (Trim(pNome) = '') then
    begin
      pNome := '%';
    end;

  dmUsuarioPerfil.qryPesquisar.Close;
  dmUsuarioPerfil.qryPesquisar.Parameters.ParamByName('pCdPerfil').Value := pCodigo;
  dmUsuarioPerfil.qryPesquisar.Parameters.ParamByName('pNmPerfil').Value := '%' + pNome + '%';
  dmUsuarioPerfil.qryPesquisar.Open;

  Result := dmUsuarioPerfil.dspPesquisar.Data;
end;

procedure TUsuarioPerfil.Salvar(pHistorico: THistorico);
var
  vlPesquisar: TClientDataSet;
  vlCodigo: Integer;
begin
  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Data := Pesquisar('', FNome);

    if (vlPesquisar.IsEmpty = False) then
    	begin
    		if (vlPesquisar.FieldByName('cdPerfil').AsInteger <> FCodigo) then
        	begin
        		raise Exception.Create('Nome do Perfil inválido!' + #13 +
                                   'Já existe outro perfil registrado com esse nome');
        	end;
    	end;
  finally
    FreeAndNil(vlPesquisar);
  end;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de Novo Perfil de Usuário: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Perfil de Usuário: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmUsuarioPerfil.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmUsuarioPerfil.qrySalvar.Connection.BeginTrans;

    dmUsuarioPerfil.qrySalvar.Close;
    dmUsuarioPerfil.qrySalvar.Parameters.ParamByName('pCdPerfil').Value := FCodigo;
    dmUsuarioPerfil.qrySalvar.Parameters.ParamByName('pNmPerfil').Value := FNome;
    dmUsuarioPerfil.qrySalvar.Open;

    FCodigo := dmUsuarioPerfil.qrySalvar.FieldByName('cdPerfil').AsInteger;

    SalvarModulos;
    SalvarFuncoes;

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmUsuarioPerfil.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmUsuarioPerfil.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TUsuarioPerfil.SalvarFuncoes;
var
  vlFuncoes: TClientDataSet;
begin
  vlFuncoes := TClientDataSet.Create(nil);

  try
    vlFuncoes.Data     := FFuncoes;
    vlFuncoes.Filter   := '(Ativo = 1)';
    vlFuncoes.Filtered := True;

    dmUsuarioPerfil.qryExcluirFuncoes.Close;
    dmUsuarioPerfil.qryExcluirFuncoes.Parameters.ParamByName('pCdPerfil').Value := FCodigo;
    dmUsuarioPerfil.qryExcluirFuncoes.ExecSQL;

    vlFuncoes.First;
    while (vlFuncoes.Eof = False) do
      begin
        dmUsuarioPerfil.qrySalvarFuncao.Close;
        dmUsuarioPerfil.qrySalvarFuncao.Parameters.ParamByName('pCdPerfil').Value := FCodigo;
        dmUsuarioPerfil.qrySalvarFuncao.Parameters.ParamByName('pCdFuncao').Value := vlFuncoes.FieldByName('cdFuncao').AsInteger;
        dmUsuarioPerfil.qrySalvarFuncao.ExecSQL;

        vlFuncoes.Next;
      end;
  finally
    FreeAndNil(vlFuncoes);
  end;
end;

procedure TUsuarioPerfil.SalvarModulos;
var
  vlModulos: TClientDataSet;
begin
  vlModulos := TClientDataSet.Create(nil);

  try
    vlModulos.Data     := FModulos;
    vlModulos.Filter   := '(Ativo = 1)';
    vlModulos.Filtered := True;

    dmUsuarioPerfil.qryExcluirModulos.Close;
    dmUsuarioPerfil.qryExcluirModulos.Parameters.ParamByName('pCdPerfil').Value := FCodigo;
    dmUsuarioPerfil.qryExcluirModulos.ExecSQL;

    vlModulos.First;
    while (vlModulos.Eof = False) do
      begin
        dmUsuarioPerfil.qrySalvarModulo.Close;
        dmUsuarioPerfil.qrySalvarModulo.Parameters.ParamByName('pCdPerfil').Value := FCodigo;
        dmUsuarioPerfil.qrySalvarModulo.Parameters.ParamByName('pCdModulo').Value := vlModulos.FieldByName('cdModulo').AsInteger;
        dmUsuarioPerfil.qrySalvarModulo.ExecSQL;

        vlModulos.Next;
      end;
  finally
    FreeAndNil(vlModulos);
  end;
end;

end.
