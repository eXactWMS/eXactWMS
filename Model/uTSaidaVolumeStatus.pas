unit uTSaidaVolumeStatus;

interface

type
  TSaidaVolumeStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function PegarStatus(pCodigo: Integer): TSaidaVolumeStatus;
  end;

implementation

{ TSaidaVolumeStatus }

uses uDmSaidaVolume, System.SysUtils, Data.DB;

class function TSaidaVolumeStatus.PegarStatus(pCodigo: Integer): TSaidaVolumeStatus;
var
  vlStatus: TSaidaVolumeStatus;
begin
  dmSaidaVolume.qryPegarVolStatus.Close;
  dmSaidaVolume.qryPegarVolStatus.Parameters.ParamByName('pCdVolumeStatus').Value := pCodigo;
  dmSaidaVolume.qryPegarVolStatus.Open;

  if (dmSaidaVolume.qryPegarVolStatus.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Status do Volume inválido!');
    end;

  vlStatus        := TSaidaVolumeStatus.Create;
  vlStatus.Codigo := dmSaidaVolume.qryPegarVolStatus.FieldByName('cdVolumeStatus').Value;
  vlStatus.Nome   := dmSaidaVolume.qryPegarVolStatus.FieldByName('nmVolumeStatus').Value;

  Result := vlStatus;
end;

end.
