unit RabbitConsumer;

interface

uses
  AMQP.Connection,
  System.SyncObjs,
  AMQP.Interfaces,
  AMQP.Classes,
  AMQP.Message,
  AMQP.StreamHelper,

  AMQP.Arguments,
  AMQP.IMessageProperties,
  AMQP.MessageProperties,
  AMQP.Types,
  ufuncoes,
  Classes,
  System.SysUtils;

type
  TConsumerCallback = reference to procedure(Msg: string);

  TConsumerThread = Class(TThread)
  Strict Private
    FQueue: TAMQPMessageQueue;
    Procedure execProcedure(msgBody: String; Sync: Boolean);

  Protected
    FCallback: TConsumerCallback;
    Procedure Execute; Override;
    Constructor Create(AQueue: TAMQPMessageQueue; ACallback: TConsumerCallback);
      Reintroduce;
  End;

type

  TRabitmqObj = class
  private
    AMQP: TAMQPConnection;
    Channel: IAMQPChannel;
    DebugLock: TCriticalSection;

  public
    procedure Start();
    procedure publishMessage(fila, Msg: string);
    procedure consumirFila(fila: string; Callback: TConsumerCallback);
  end;

var
  FRabitmqObj: TRabitmqObj;

implementation

uses uDmeXactWMS;

{ TRabitmqObj }
{ ------------------------------------------------------------------------------ }
procedure TRabitmqObj.consumirFila(fila: string; Callback: TConsumerCallback);
var
  Queue: TAMQPMessageQueue;
  Thread: TConsumerThread;
begin
  Channel.QueueDeclare(fila, []);
  Queue := TAMQPMessageQueue.Create;
  Channel.BasicConsume(Queue, fila, 'Consumer_' + fila);
  Thread := TConsumerThread.Create(Queue, Callback);
end;

{ ------------------------------------------------------------------------------ }
procedure TRabitmqObj.publishMessage(fila, Msg: string);

begin
  try
    Channel.QueueDeclare(fila, []);
    Channel.BasicPublish('', fila, Msg);
  except
    on e: exception do
      gravaLog('falha ao enviar mensagem  ' + e.Message)
  end;

end;

{ ------------------------------------------------------------------------------ }
procedure TRabitmqObj.Start();
var
  Conectado: Boolean;
begin
  // ReportMemoryLeaksOnShutdown := True;
  DebugLock := TCriticalSection.Create;

  // Inicializa a conexão
  AMQP := TAMQPConnection.Create;
  AMQP.Host := DmeXactWMS.HOST_RABBIT;
  AMQP.Port := 5672;
  AMQP.VirtualHost := '/';
  AMQP.Username := DmeXactWMS.USER_RABBIT;
  AMQP.Password := DmeXactWMS.PASSWORD_RABBIT;
  AMQP.ApplicationID := 'workerWms';
  AMQP.HeartbeatSecs := 120;
  AMQP.Timeout := 60000;
  AMQP.MaxFrameSize := 4096;
  gravaLog('Conectando servidor rabbit :  ' + DmeXactWMS.HOST_RABBIT);
  while not Conectado do
  begin
    try
      AMQP.Connect;
      Conectado := true;
      gravaLog('Sucesso  servidor rabbit :  ' + DmeXactWMS.HOST_RABBIT);
    except
      on e: exception do
      begin
        gravaLog('Imposivel conectar tentando novamente em 5 segundos - ' +
          e.Message);
        Conectado := false;
        sleep(5000);
      end;
    end;
  end;
  sleep(1000);
  Channel := AMQP.OpenChannel(0, 1);
end;
{ ------------------------------------------------------------------------------ }
{ TConsumerThread }

constructor TConsumerThread.Create(AQueue: TAMQPMessageQueue;
  ACallback: TConsumerCallback);
begin
  FQueue := AQueue;
  FCallback := ACallback;
  inherited Create;
end;

{ ------------------------------------------------------------------------------ }
procedure TConsumerThread.Execute;
var
  Msg: TAMQPMessage;

begin
  NameThreadForDebugging('ConsumerThread');
  Repeat
    try
      Msg := FQueue.Get(INFINITE);
      if Msg = nil then
        Terminate;
      if not Terminated then
      Begin
        try
          Msg.Ack;
          execProcedure(Msg.Body.AsString[TEncoding.ASCII], false);
        except
          on e: exception do
          begin
            writeln('processamento com erro ' + e.Message);

          end;
        end;
        Msg.Free;

      End;
    except
      on e: exception do
        gravaLog('faha na leitura da fila ampq ' + e.Message)
    end;
  Until Terminated;
  FQueue.Free;
  gravaLog('finalizado fila ampq o serviço sera reniciado ') ;
  halt;
end;

{ ------------------------------------------------------------------------------ }
procedure TConsumerThread.execProcedure(msgBody: String; Sync: Boolean);
begin

  self.FCallback(msgBody)

end;

{ ------------------------------------------------------------------------------ }
end.
