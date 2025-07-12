unit uTSaidaVolumeErro;

interface

type
  TSaidaVolumeErroTipo = class
  private
  public
  end;

  TSaidaVolumeErro = class
  private
  public
    class procedure RegistrarErroConferencia(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
    class procedure RegistrarErroSeparacao(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
    class function  RelatorioErrosConferencia(pDataInicial, pDataFinal: string): OleVariant;
    class function  RelatorioErrosSeparacao(pDataInicial, pDataFinal: string): OleVariant;
  end;

implementation

{ TSaidaVolumeErro }

uses uDmSaidaVolumeErro, SysUtils;

class procedure TSaidaVolumeErro.RegistrarErroConferencia(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
begin
  dmSaidaVolumeErro.qryRegistrarErroConferencia.Close;
  dmSaidaVolumeErro.qryRegistrarErroConferencia.Parameters.ParamByName('pCdVolume').Value   := pCodigoVolume;
  dmSaidaVolumeErro.qryRegistrarErroConferencia.Parameters.ParamByName('pCdProduto').Value  := pCodigoProduto;
  dmSaidaVolumeErro.qryRegistrarErroConferencia.Parameters.ParamByName('pCdErroTipo').Value := pCodigoTipo;
  dmSaidaVolumeErro.qryRegistrarErroConferencia.ExecSQL;
end;

class procedure TSaidaVolumeErro.RegistrarErroSeparacao(pCodigoVolume, pCodigoProduto: Int64; pCodigoTipo: Integer);
begin
  dmSaidaVolumeErro.qryRegistrarErroSeparacao.Close;
  dmSaidaVolumeErro.qryRegistrarErroSeparacao.Parameters.ParamByName('pCdVolume').Value   := pCodigoVolume;
  dmSaidaVolumeErro.qryRegistrarErroSeparacao.Parameters.ParamByName('pCdProduto').Value  := pCodigoProduto;
  dmSaidaVolumeErro.qryRegistrarErroSeparacao.Parameters.ParamByName('pCdErroTipo').Value := pCodigoTipo;
  dmSaidaVolumeErro.qryRegistrarErroSeparacao.ExecSQL;
end;

class function TSaidaVolumeErro.RelatorioErrosConferencia(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaidaVolumeErro.qryRelatorioErrosConferencia.Close;
  dmSaidaVolumeErro.qryRelatorioErrosConferencia.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaidaVolumeErro.qryRelatorioErrosConferencia.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaidaVolumeErro.qryRelatorioErrosConferencia.Open;

  Result := dmSaidaVolumeErro.dspRelatorioErrosConferencia.Data;
end;

class function TSaidaVolumeErro.RelatorioErrosSeparacao(pDataInicial, pDataFinal: string): OleVariant;
var
  vlDataInicial: TDateTime;
  vlDataFinal: TDateTime;
begin
  try
    vlDataInicial := StrToDateTime(pDataInicial);
  except
    raise Exception.Create('Data Inicial inválida!');
  end;

  try
    vlDataFinal := StrToDateTime(pDataFinal);
  except
    raise Exception.Create('Data Final inválida!');
  end;

  if (vlDataInicial > vlDataFinal) then
    begin
      raise Exception.Create('Datas inválidas!' + #13 +
                             'A Data Inicial não pode ser maior que a Data Final');
    end;

  dmSaidaVolumeErro.qryRelatorioErrosSeparacao.Close;
  dmSaidaVolumeErro.qryRelatorioErrosSeparacao.Parameters.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd 00:00:00', vlDataInicial);
  dmSaidaVolumeErro.qryRelatorioErrosSeparacao.Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('yyyy-mm-dd 23:59:59', vlDataFinal);
  dmSaidaVolumeErro.qryRelatorioErrosSeparacao.Open;

  Result := dmSaidaVolumeErro.dspRelatorioErrosSeparacao.Data;
end;

end.

