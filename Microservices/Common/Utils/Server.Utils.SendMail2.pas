unit Server.Utils.SendMail2;

interface

uses
  System.Classes,
  Server.Constants,
  strutils,
  sysutils,
  synacode,
  ServerMail

    ;

const
  From = 'wilson.rodrigues@wkconsultoria.com.br';
  Password = 'Ww2061614#';
  SmtpServer = 'smtp.gmail.com';
  SmtpPort = '465';

type
  TSendMail = class(TThread)
  private
    FMensagem: String;

    FAssunto: String;
    FDestinatario: String;
    FAnexos: TstringList;
    FWKMail: TWKMail;
    FCopias: TstringList;
    FCC: TstringList;
    FIsBase64: Boolean;
    procedure SetDestinatario(const Value: String);

  protected

  public
    procedure Execute; override;
    property Destinatario: String read FDestinatario write SetDestinatario;
    property Mensagem: String read FMensagem write FMensagem;
    property Assunto: String read FAssunto write FAssunto;
    property IsBase64: Boolean read FIsBase64 write FIsBase64;
    procedure SetAnexo(Path: String);

  end;

implementation

{ TSendMail }
function PosExA(const SubStr, S: AnsiString; Offset: Integer): Integer;
begin
{$IFDEF DELPHIXE3_UP}
  Result := Pos(SubStr, S, Offset);
{$ELSE}
  Result := PosEx(SubStr, S, Offset);
{$ENDIF}
end;

procedure AcharProximaTag(const ABinaryString: AnsiString;
  const PosIni: Integer; var ATag: AnsiString; var PosTag: Integer);
var
  PosTagAux, FimTag, LenTag: Integer;
begin
  ATag := '';
  PosTag := PosExA('<', ABinaryString, PosIni);
  if PosTag > 0 then
  begin
    PosTagAux := PosExA('<', ABinaryString, PosTag + 1);
    FimTag := PosExA('>', ABinaryString, PosTag + 1);
    if FimTag = 0 then
    begin
      PosTag := 0;
      exit;
    end;

    while (PosTagAux > 0) and (PosTagAux < FimTag) do
    begin
      PosTag := PosTagAux;
      PosTagAux := PosExA('<', ABinaryString, PosTag + 1);
    end;

    LenTag := FimTag - PosTag + 1;
    ATag := LowerCase(copy(ABinaryString, PosTag, LenTag));
  end;
end;

function StripHTML(const AHTMLString: String): String;
var
  ATag, VHTMLString: AnsiString;
  PosTag, LenTag: Integer;
begin
  VHTMLString := AHTMLString;
  ATag := '';
  PosTag := 0;

  AcharProximaTag(VHTMLString, 1, ATag, PosTag);
  while ATag <> '' do
  begin
    LenTag := Length(ATag);
    Delete(VHTMLString, PosTag, LenTag);

    ATag := '';
    AcharProximaTag(VHTMLString, PosTag, ATag, PosTag);
  end;
  Result := VHTMLString;
end;

procedure TSendMail.Execute;

var
  Data: TstringList;
  I: Integer;
  LMessagem: String;

begin
  LMessagem := FMensagem;
  if FileExists(ExtractFilePath(GetModuleName(HInstance)) + 'templateMail.html')
  then
  begin
    Data := TstringList.Create;
    Data.LoadFromFile(ExtractFilePath(GetModuleName(HInstance)) +
      'templateMail.html');

    LMessagem := Data.Text;
    LMessagem := StringReplace(LMessagem, '$message', FMensagem,[rfReplaceAll, rfIgnoreCase]);
  end;

  if FIsBase64 then
    LMessagem := DecodeBase64(FMensagem);

  FWKMail := TWKMail.Create(Nil);
  FCopias := TstringList.Create;
  FWKMail.IsHTML := true;
  FWKMail.Host := SmtpServer;
  FWKMail.Port := SmtpPort;
  FWKMail.Username := From;
  FWKMail.Password := Password;
  FWKMail.From := From;
  FWKMail.SetSSL := true;
  FWKMail.SetTLS := true;
  FWKMail.ReadingConfirmation := False;
  FWKMail.UseThread := False;
  FWKMail.FromName := 'Mail Service 2.0';
  FWKMail.Clear;
  if Pos(';', FDestinatario) > 0 then
  begin
    for I := 0 to Length(SplitString(FDestinatario, ';')) - 1 do
      FWKMail.AddAddress(SplitString(FDestinatario, ';')[I]);
  end
  else
    FWKMail.AddAddress(Destinatario);
  FWKMail.Subject := Assunto;
  FWKMail.Body.Text := LMessagem;
  FWKMail.AltBody.Text := (StripHTML(LMessagem));

  FWKMail.ClearAttachments;
  { if Assigned(StreamAnexos) then
    FWKMail.AddAttachment(StreamAnexos, FnomeAtach, adAttachment);
  }
  if Assigned(FAnexos) then
  begin
    for I := 0 to FAnexos.Count - 1 do
      FWKMail.AddAttachment(FAnexos[I], '', adAttachment);
  end;
  if Assigned(FCC) then
  begin
    for I := 0 to FCC.Count - 1 do
      FWKMail.AddCC(FCC[I]);
  end;
  FWKMail.Send;

end;

procedure TSendMail.SetAnexo(Path: String);
begin
  if not Assigned(FAnexos) then
    FAnexos := TstringList.Create;
  FAnexos.Add(Path);
end;

procedure TSendMail.SetDestinatario(const Value: String);
begin
  FDestinatario := Value;
end;

end.
