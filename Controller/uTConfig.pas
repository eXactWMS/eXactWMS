unit uTConfig;

interface

uses uTHistorico;

type
  TConfig = class
    private
      FCodigo: Integer;
      FNome: string;
      FValor: string;

      procedure Salvar;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;
      property Valor: string    read FValor   write FValor;

      class function  AtualizarParametros: OleVariant;
      class function  ListarDestinatarios: OleVariant;
      class function  PegarParametro(pNome: string): string;
      class procedure SalvarParametros(pParametros: OleVariant; pHistorico: THistorico);
      class procedure SalvarDestinatarios(pDestinatarios: OleVariant);
  end;

implementation

uses uDmConfig, SysUtils, DBClient, uFuncoes, DB;

{ TParametro }

class function TConfig.AtualizarParametros: OleVariant;
begin
  DmConfig.qryAtualizarParametros.Close;
  DmConfig.qryAtualizarParametros.Open;

  if (DmConfig.qryAtualizarParametros.Locate('nmParametro', 'intSMTPSenha', []) = True) then
    begin
      DmConfig.qryAtualizarParametros.Edit;
      DmConfig.qryAtualizarParametros.FieldByName('vlParametro').Value := Criptografar(dmConfig.qryAtualizarParametros.FieldByName('vlParametro').AsString);
      DmConfig.qryAtualizarParametros.FieldByName('vlAntigo').Value    := Criptografar(dmConfig.qryAtualizarParametros.FieldByName('vlAntigo').AsString);
      DmConfig.qryAtualizarParametros.Post;
    end;

  Result := DmConfig.dspAtualizarParametros.Data;
end;

class function TConfig.ListarDestinatarios: OleVariant;
begin
  DmConfig.qryListarDestinatarios.Close;
  DmConfig.qryListarDestinatarios.Open;

  Result := DmConfig.dspListarDestinatarios.Data;
end;

class function TConfig.PegarParametro(pNome: string): string;
begin
  DmConfig.qryPegarParametro.Close;
  DmConfig.qryPegarParametro.Parameters.ParamByName('pNmParametro').Value := pNome;
  DmConfig.qryPegarParametro.Open;

  if (DmConfig.qryPegarParametro.IsEmpty = True) then
    begin
      raise Exception.Create('Parâmetro "' + pNome + '" não encontrado!');
    end
  else
    begin
      Result := DmConfig.qryPegarParametro.FieldByName('vlParametro').AsString;
    end;
end;

procedure TConfig.Salvar;
begin
  DmConfig.qrySalvar.Close;
  DmConfig.qrySalvar.Parameters.ParamByName('pVlParametro').Value := Self.Valor;
  DmConfig.qrySalvar.Parameters.ParamByName('pCdParametro').Value := Self.Codigo;
  DmConfig.qrySalvar.ExecSQL;
end;

class procedure TConfig.SalvarDestinatarios(pDestinatarios: OleVariant);
var
  vlDestinatarios: TClientDataSet;
begin
  DmConfig.qryExcluirDestinatarios.Close;
  DmConfig.qryExcluirDestinatarios.ExecSQL;

  vlDestinatarios := TClientDataSet.Create(nil);

  try
    vlDestinatarios.Close;
    vlDestinatarios.Data := pDestinatarios;

    vlDestinatarios.First;
    while (vlDestinatarios.Eof = False) do
      begin
        DmConfig.qrySalvarDestinatario.Close;
        DmConfig.qrySalvarDestinatario.Parameters.ParamByName('pNmEmail').Value := vlDestinatarios.FieldByName('nmEmail').Value;
        DmConfig.qrySalvarDestinatario.ExecSQL;

        vlDestinatarios.Next;
      end;
  finally
    FreeAndNil(vlDestinatarios);
  end;
end;

class procedure TConfig.SalvarParametros(pParametros: OleVariant; pHistorico: THistorico);
var
  vlParametro: TConfig;
  vlParametros: TClientDataSet;
begin
  vlParametros := TClientDataSet.Create(nil);

  try
    vlParametros.Close;
    vlParametros.Data            := pParametros;
    vlParametros.IndexFieldNames := 'cdParametro';

    pHistorico.CodigoRegistro := 0;

    DmConfig.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    DmConfig.qrySalvar.Connection.BeginTrans;

    try
      vlParametros.First;
      while (vlParametros.Eof = False) do
        begin
          if (vlParametros.FieldByName('vlParametro').AsString <> vlParametros.FieldByName('vlAntigo').AsString) then
            begin
              vlParametro := TConfig.Create;

              try
                vlParametro.Codigo := vlParametros.FieldByName('cdParametro').AsInteger;
                vlParametro.Nome   := vlParametros.FieldByName('nmParametro').AsString;
                vlParametro.Valor  := vlParametros.FieldByName('vlParametro').AsString;

                if (vlParametro.Nome = 'intSMTPSenha') then
                  begin
                    vlParametro.Valor := Criptografar(vlParametro.Valor);
                  end
                else if (vlParametro.Nome = 'entValidadeMinimaPadrao') then
                  begin
                    DmConfig.qryAlterarValidadeMinimaEntrada.Close;
                    DmConfig.qryAlterarValidadeMinimaEntrada.Parameters.ParamByName('pValidadeNova').Value   := vlParametro.Valor;
                    DmConfig.qryAlterarValidadeMinimaEntrada.Parameters.ParamByName('pValidadeAntiga').Value := vlParametros.FieldByName('vlAntigo').AsString;
                    DmConfig.qryAlterarValidadeMinimaEntrada.ExecSQL;
                  end
                else if (vlParametro.Nome = 'saiValidadeMinimaPadrao') then
                  begin
                    DmConfig.qryAlterarValidadeMinimaSaida.Close;
                    DmConfig.qryAlterarValidadeMinimaSaida.Parameters.ParamByName('pValidadeNova').Value   := vlParametro.Valor;
                    DmConfig.qryAlterarValidadeMinimaSaida.Parameters.ParamByName('pValidadeAntiga').Value := vlParametros.FieldByName('vlAntigo').AsString;
                    DmConfig.qryAlterarValidadeMinimaSaida.ExecSQL;
                  end;

                vlParametro.Salvar;

                pHistorico.Observacao := 'Alterado o valor do parâmetro "' + vlParametro.Nome + '"';
                pHistorico.Salvar;
              finally
                FreeAndNil(vlParametro);
              end;
            end;

          vlParametros.Next;
        end;

      DmConfig.qrySalvar.Connection.CommitTrans;
    except on E: Exception do
      begin
        DmConfig.qrySalvar.Connection.RollbackTrans;

        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(vlParametros);
  end;
end;

end.
