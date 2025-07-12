unit uTHistorico;

interface

type
  THistorico = class
    private
      FCodigo: Integer;
      FCodigoUsuario: Integer;
      FCodigoFuncao: Integer;
      FCodigoRegistro: Int64;
      FDataHora: TDateTime;
      FEstacao: string;
      FModulo: string;
      FVersao: string;
      FObservacao: string;
    public
      property Codigo: Integer        read FCodigo;
      property CodigoUsuario: Integer read FCodigoUsuario   write FCodigoUsuario;
      property CodigoFuncao: Integer  read FCodigoFuncao    write FCodigoFuncao;
      property CodigoRegistro: Int64  read FCodigoRegistro  write FCodigoRegistro;
      property DataHora: TDateTime    read FDataHora        write FDataHora;
      property Estacao: string        read FEstacao         write FEstacao;
      property Modulo: string         read FModulo          write FModulo;
      property Versao: string         read FVersao          write FVersao;
      property Observacao: string     read FObservacao      write FObservacao;

      class function ListarFuncoes: OleVariant;
      class function Pesquisar(pCodigoFuncao, pCodigoRegistro: Int64): OleVariant;

      procedure Salvar;
  end;

implementation

uses uDmHistorico, SysUtils;

{ THistorico }

class function THistorico.ListarFuncoes: OleVariant;
begin
  dmHistorico.qryListarFuncoes.Close;
  dmHistorico.qryListarFuncoes.Open;

  Result := dmHistorico.dspListarFuncoes.Data;
end;

class function THistorico.Pesquisar(pCodigoFuncao, pCodigoRegistro: Int64): OleVariant;
begin
  dmHistorico.qryPesquisar.Close;
  dmHistorico.qryPesquisar.Parameters.ParamByName('pCdFuncao').Value   := pCodigoFuncao;
  dmHistorico.qryPesquisar.Parameters.ParamByName('pCdRegistro').Value := pCodigoRegistro;
  dmHistorico.qryPesquisar.Open;

  Result := dmHistorico.dspPesquisar.Data;
end;

procedure THistorico.Salvar;
begin
  dmHistorico.qrySalvar.Close;
  dmHistorico.qrySalvar.Parameters.ParamByName('pCdUsuario').Value  := FCodigoUsuario;
  dmHistorico.qrySalvar.Parameters.ParamByName('pCdFuncao').Value   := FCodigoFuncao;
  dmHistorico.qrySalvar.Parameters.ParamByName('pCdRegistro').Value := FCodigoRegistro;
  dmHistorico.qrySalvar.Parameters.ParamByName('pEstacao').Value    := FEstacao;
  dmHistorico.qrySalvar.Parameters.ParamByName('pModulo').Value     := FModulo;
  dmHistorico.qrySalvar.Parameters.ParamByName('pVersao').Value     := FVersao;
  dmHistorico.qrySalvar.Parameters.ParamByName('pObservacao').Value := FObservacao;

  if (FDataHora = 0) then
    begin
      dmHistorico.qrySalvar.Parameters.ParamByName('pDataHora').Value := '';
    end
  else
    begin
      dmHistorico.qrySalvar.Parameters.ParamByName('pDataHora').Value := FormatDateTime('yyyy-mm-dd HH:MM', FDataHora);
    end;

  dmHistorico.qrySalvar.ExecSQL;
end;

end.
