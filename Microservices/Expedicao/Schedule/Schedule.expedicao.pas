unit Schedule.expedicao;
{$TYPEINFO OFF}

interface

uses

  System.SysUtils,
  System.Classes,

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

// uses Services.PedidoVolume;

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
begin
  Ftimework := 0;
  while not Terminar do
  begin
    sleep(10);
    if (Ftimework <= 0) then
    begin
      var ObjPedidoVolume := TServicePedidoVolume.create;
      try
        try
          Writeln(FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now) + ' - ' + 'Realizando baixa estoque expedicao');
          ObjPedidoVolume.BaixarEstoqueExpedicao;
          Writeln(FormatDateTime('DD/MM/YYYY hh:nn:ss.zzz', now) + ' - ' + 'Baixa de estoque expedição realizada !');
        except
          on e: exception do
            Writeln(e.Message)
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
