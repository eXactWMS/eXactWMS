unit exactwmsservice.schedule.expedicao;
{$TYPEINFO OFF}

interface

uses

  System.SysUtils,
  System.Classes,
  exactwmsservice.lib.utils,
  Services.PedidoVolume,
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

  TScheduleexpedicao = Class(TThread)
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
  FScheduleexpedicao: TScheduleexpedicao;

implementation

{ TScheduleexpedicao }

//uses Services.PedidoVolume;

procedure TScheduleexpedicao.Execute;
begin
  inherited;
  Executar();
end;

constructor TScheduleexpedicao.create(suspensa: Boolean);
begin

  inherited;
  FScheduleexpedicao := self;
end;

{ ------------------------------------------------------------------------------ }
procedure TScheduleexpedicao.Executar;
var
  I: Integer;
  ObjPedidoVolume : TServicePedidoVolume;
begin
  Ftimework := 0;
  //Tutil.gravalog('[Scheduleexpedicao] Iniciando Expedição de volumes');
  while not Terminar do
  begin
    sleep(10);
    if (Ftimework <= 0) then
    begin
      try
        try
          //Tutil.EncerarConexoesInativas();
          ObjPedidoVolume := TServicePedidoVolume.Create;
          if ObjPedidoVolume.BaixarEstoqueExpedicao then
             Tutil.gravalog('[Scheduleexpedicao] Expedição executada')
          Else
             Tutil.gravalog('[Scheduleexpedicao] Expedição executada com ERRO(s).');
        except on e: exception do
          Tutil.gravalog('[[Scheduleexpedicao]261 ' + e.Message);
        end;
      finally
        Ftimework := (60); // 600 *1000 milesecundos
        ObjPedidoVolume.Free;
      end;

    end;
    sleep(1000); // pausar a execução em 1 segundo
    dec(Ftimework);

  end;
end;

{ ------------------------------------------------------------------------------ }

end.
