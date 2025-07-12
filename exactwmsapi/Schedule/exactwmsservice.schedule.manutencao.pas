unit exactwmsservice.schedule.manutencao;
{$TYPEINFO OFF}

interface

uses

  System.SysUtils,
  System.Classes,
  exactwmsservice.lib.utils,
  dateutils,
  inifiles,
  variants,
  Data.DB,
  math,
  System.IOUtils,
  Datasnap.DBClient,
  Datasnap.Provider,
  SyncObjs;

type

  TScheduleManutencao = Class(TThread)
  private
    Ftimework: Integer;

    Procedure Executar;
    procedure Execute; override;

  public

    Terminar: Boolean;
    constructor create(suspensa: Boolean);
  published

  end;

var
  CountExecs: Integer;
  ccCritical: TCriticalSection;
  FScheduleManutencao: TScheduleManutencao;

implementation

{ TScheduleManutencao }

procedure TScheduleManutencao.Execute;
begin
  inherited;
  Executar();
end;

constructor TScheduleManutencao.create(suspensa: Boolean);
begin

  inherited;
  FScheduleManutencao := self;
end;

{ ------------------------------------------------------------------------------ }
procedure TScheduleManutencao.Executar;
var
  I: Integer;
begin
  Ftimework := 600;
  Tutil.gravalog('[ScheduleManutencao] Serviço manutencao iniciado');
  while not Terminar do
  begin
    sleep(10);
    if Ftimework <= 0 then
    begin
      try
        try
          Tutil.EncerarConexoesInativas();
          Tutil.gravalog('[ScheduleManutencao] Limpeza executada');
        except
          on e: exception do
            Tutil.gravalog('[[ScheduleManutencao]161 ' + e.Message);

        end;

      finally
        Ftimework := (600); // 600 *1000 milesecundos
      end;

    end;
    sleep(1000); // pausar a execução em 1 segundo
    dec(Ftimework);

  end;
end;

{ ------------------------------------------------------------------------------ }

end.
