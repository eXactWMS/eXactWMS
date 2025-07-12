unit Repository.UploadApk;

interface

uses
  System.Classes,
  Server.Attributes,
  Server.Constants,

  json,
  System.SysUtils,
  Server.Connection,

  REST.json,
  NetEncoding,

  System.Generics.Collections,
  Server.MessageList,
  Web.HTTPApp,
  Server.Message,
  System.Rtti,

  Server.ResourceBaseClass;

type

  [Resource('uploadapk')]

  UploadApk = class(TPersistent)
  private

  protected

  public
    [DBField('arquivobase64', True, True, True, notnull)]
    arquivobase64: String;
    [Post]
    procedure Post(Response: TWebResponse; Dados: TJSONObject;
      Conn: TConnection = nil); virtual;
  end;

implementation

{ UploadApk }

procedure UploadApk.Post(Response: TWebResponse; Dados: TJSONObject;
  Conn: TConnection);
var
  LJsonResponse: TJSONObject;
  LMessageType: TMessageType;
  Larquivobase64: string;
  AOutFileName: string;

  inStream: TStream;
  outStream: TStream;
begin
  LJsonResponse := TJSONObject.Create;

  LMessageType := EErroGeral;
  if not assigned(Dados) then
  begin
    TMessage.Create(LMessageType, 'Corpo da requisição invalido')
      .SendMessage(Response);
    Exit;
  end;

  Dados.TryGetValue<string>('arquivobase64', Larquivobase64);

  if (Larquivobase64.trim.IsEmpty) then
  begin
    TMessage.Create(LMessageType, 'Arquivo não informado!')
      .SendMessage(Response);
    Exit
  end;

  AOutFileName := ExtractFilePath(GetModuleName(HInstance)) + 'www\update\'
    + cFileAPK;
  ForceDirectories(ExtractFilePath(AOutFileName));
  inStream := TStringStream.Create(TNetEncoding.Base64.decode(Larquivobase64));
  Larquivobase64 := (TNetEncoding.Base64.decode(Larquivobase64));
  try
    outStream := TFileStream.Create(AOutFileName, fmCreate);
    try
      outStream.WriteBuffer(Pointer(Larquivobase64)^, Length(Larquivobase64));
    finally
      outStream.Free;
    end;
    LMessageType := IArquivoEnviado;
    LMessageType.Content := LJsonResponse;
    TMessage.Create(LMessageType).SendMessage(Response);
  except
    on e: Exception do
    begin

      LJsonResponse.AddPair('erro', e.Message);
      LMessageType := EErroGeral;
      LMessageType.Content := LJsonResponse;
      TMessage.Create(LMessageType).SendMessage(Response);
    end;

  end;

end;

initialization

RegisterClass(UploadApk);

end.
