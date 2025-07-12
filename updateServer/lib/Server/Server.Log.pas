unit Server.Log;

interface

uses
  System.SysUtils
  ;

type
  TLog = class
  private
   // EventsApplication: TApplicationEvents;
    FFileLog: TextFile;
    constructor Create;
  public
    class function GetInstance: TLog;
    destructor Destroy;
    procedure OnException(Sender: TObject; E: Exception);
    procedure CreateFileLog;
    property FileLog: TextFile read FFileLog write FFileLog;

  end;

implementation

{ TLog }

constructor TLog.Create;
begin
  CreateFileLog;
end;

procedure TLog.CreateFileLog;
begin
  if not FileExists(ExtractFilePath(GetModuleName(HInstance)) + 'Server.log') then
    Rewrite(FileLog,ExtractFilePath(GetModuleName(HInstance)) + 'Server.log');
  AssignFile(FileLog, ExtractFilePath(GetModuleName(HInstance))+ 'Server.log');
end;

destructor TLog.Destroy;
begin
  CloseFile(FileLog);
end;

class function TLog.GetInstance: TLog;
begin
  Result := Self.Create;
end;

procedure TLog.OnException(Sender: TObject; E: Exception);
begin
  Writeln(TObject(Sender).ClassName);

end;

end.
