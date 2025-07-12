

unit WkMail;



interface

uses
  Classes, syncobjs, SysUtils,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$Else}
   Contnrs,
  {$IfEnd}
  SSL_OpenSSL, SMTPSend, MimePart, MimeMess, SynaChar, SynaUtil;

type

  TMailStatus = (pmsStartProcess, pmsConfigHeaders, pmsAddingMimeParts,
                 pmsLoginSMTP, pmsStartSends, pmsSendTo, pmsSendCC, pmsSendBCC,
                 pmsSendReplyTo, pmsSendData, pmsLogoutSMTP, pmsDone, pmsError);

  TMailCharset = TMimeChar;

  TMailAttachmentDisposition = (adAttachment, adInline);

  { TMailAttachment }

  TMailAttachment = class
  private
    FFileName: String;
    FDescription: String;
    FStream: TMemoryStream;
    FDisposition: TMailAttachmentDisposition;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Assign(Source: TMailAttachment);

    property FileName: String read FFileName write FFileName;
    property Stream: TMemoryStream read FStream;
    property Description: String read FDescription write FDescription;

    property Disposition: TMailAttachmentDisposition read FDisposition
      write FDisposition;
  end;

  { TMailAttachments }

  TMailAttachments = class(TObjectList{$IfDef HAS_SYSTEM_GENERICS}<TMailAttachment>{$EndIf})
  protected
    procedure SetObject (Index: Integer; Item: TMailAttachment);
    function GetObject (Index: Integer): TMailAttachment;
    procedure Insert (Index: Integer; Obj: TMailAttachment);
  public
    function New: TMailAttachment;
    function Add (Obj: TMailAttachment): Integer;
    property Objects [Index: Integer]: TMailAttachment read GetObject write SetObject; default;
  end;

  TWKMail = class;

  TWKOnMailProcess = procedure(const AMail: TWKMail; const aStatus: TMailStatus) of object;
  TWKOnMailException = procedure(const AMail: TWKMail; const E: Exception; var ThrowIt: Boolean) of object;

  { TWKMailThread }

  TWKMailThread = class(TThread)
  private
    FWKMail : TWKMail;
    FException: Exception;
    FThrowIt: Boolean;
    FStatus: TMailStatus;
    FOnMailProcess: TWKOnMailProcess;
    FOnMailException: TWKOnMailException;
    FOnBeforeMailProcess: TNotifyEvent;
    FOnAfterMailProcess: TNotifyEvent;

    procedure MailException(const AMail: TWKMail; const E: Exception; var ThrowIt: Boolean);
    procedure DoMailException;
    procedure MailProcess(const AMail: TWKMail; const aStatus: TMailStatus);
    procedure DoMailProcess;
    procedure BeforeMailProcess(Sender: TObject);
    procedure DoBeforeMailProcess;
    procedure AfterMailProcess(Sender: TObject);
    procedure DoAfterMailProcess;

  protected
    procedure Execute; override;

  public
    constructor Create(AOwner : TWKMail);
  end;

  { TWKMail }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piWKAllPlatforms)]
  {$ENDIF RTL230_UP}
  TWKMail = class(TComponent)
  private
    fSMTP                : TSMTPSend;
    fMIMEMess            : TMimeMess;
    fArqMIMe             : TMemoryStream;

    fReadingConfirmation : boolean;
    fDeliveryConfirmation: boolean;
    fOnMailProcess       : TWKOnMailProcess;
    fOnMailException     : TWKOnMailException;

    fIsHTML              : boolean;
    fAttempts            : Byte;
    fFrom                : string;
    fFromName            : string;
    fSubject             : string;
    fBody                : TStringList;
    fAltBody             : TStringList;
    fAttachments         : TMailAttachments;
    fReplyTo             : TStringList;
    fBCC                 : TStringList;
    fTimeOut             : Integer;
    fUseThread           : boolean;

    fDefaultCharsetCode  : TMimeChar;
    fIDECharsetCode      : TMimeChar;

    fOnAfterMailProcess  : TNotifyEvent;
    fOnBeforeMailProcess : TNotifyEvent;

    fGetLastSmtpError    : String;

    function GetHost: string;
    function GetPort: string;
    function GetUsername: string;
    function GetPassword: string;
    function GetFullSSL: Boolean;
    function GetAutoTLS: Boolean;
    function GetPriority: TMessPriority;

    procedure SetHost(const aValue: string);
    procedure SetPort(const aValue: string);
    procedure SetUsername(const aValue: string);
    procedure SetPassword(const aValue: string);
    procedure SetFullSSL(aValue: Boolean);
    procedure SetAutoTLS(aValue: Boolean);
    procedure SetPriority(aValue: TMessPriority);
    procedure SetAttempts(AValue: Byte);

    procedure SmtpError(const pMsgError: string);

    procedure DoException(E: Exception);
    procedure AddEmailWithDelimitersToList( aEmail: String; aList: TStrings);

  protected
    procedure SendMail;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure MailProcess(const aStatus: TMailStatus);
    procedure Send(UseThreadNow: Boolean); overload;
    procedure Send; overload;
    procedure BuildMimeMess;
    procedure Clear;
    procedure SaveToFile(const AFileName: String);
    function SaveToStream(AStream: TStream): Boolean;

    procedure AddAttachment(const aFileName: string; aDescription: string;
      const aDisposition: TMailAttachmentDisposition = adInline); overload;
    procedure AddAttachment(const aFileName: string); overload;
    procedure AddAttachment(aStream: TStream; aDescription: string;
      const aDisposition: TMailAttachmentDisposition = adInline); overload;
    procedure AddAttachment(aStream: TStream); overload;
    procedure ClearAttachments;

    procedure AddAddress(const aEmail: string; const aName: string = '');
    procedure AddReplyTo(const aEmail: string; const aName: string = '');
    procedure AddCC(const aEmail: string; const aName: string = '');
    procedure AddBCC(const aEmail: string);

    property SMTP: TSMTPSend read fSMTP;
    property MIMEMess: TMimeMess read fMIMEMess;
    property Attachments: TMailAttachments read fAttachments;
    property BCC: TStringList read fBCC;
    property ReplyTo: TStringList read fReplyTo;

    property AltBody: TStringList read fAltBody;
    property Body: TStringList read fBody;

    property GetLastSmtpError: string read fGetLastSmtpError;

  published
    property Host: string read GetHost write SetHost;
    property Port: string read GetPort write SetPort;
    property Username: string read GetUsername write SetUsername;
    property Password: string read GetPassword write SetPassword;
    property SetSSL: boolean read GetFullSSL write SetFullSSL;
    property SetTLS: boolean read GetAutoTLS write SetAutoTLS;
    property Priority: TMessPriority read GetPriority write SetPriority default MP_normal;
    property ReadingConfirmation: boolean read fReadingConfirmation write fReadingConfirmation default False;
    property DeliveryConfirmation: boolean read fDeliveryConfirmation write fDeliveryConfirmation default False;
    property IsHTML: boolean read fIsHTML write fIsHTML default False;
    property UseThread: boolean read fUseThread write fUseThread default False;
    property TimeOut: Integer read fTimeOut write fTimeOut default 0;
    property Attempts: Byte read fAttempts write SetAttempts;
    property From: string read fFrom write fFrom;
    property FromName: string read fFromName write fFromName;
    property Subject: string read fSubject write fSubject;
    property DefaultCharset: TMailCharset read fDefaultCharsetCode write fDefaultCharsetCode;
    property IDECharset: TMailCharset read fIDECharsetCode write fIDECharsetCode;
    property OnBeforeMailProcess: TNotifyEvent read fOnBeforeMailProcess write fOnBeforeMailProcess;
    property OnMailProcess: TWKOnMailProcess read fOnMailProcess write fOnMailProcess;
    property OnAfterMailProcess: TNotifyEvent read fOnAfterMailProcess write fOnAfterMailProcess;
    property OnMailException: TWKOnMailException read fOnMailException write fOnMailException;
  end;

procedure SendEmailByThread( MailToClone: TWKMail);

var
  MailCriticalSection : TCriticalSection;

implementation

Uses
  strutils, math;

procedure SendEmailByThread(MailToClone: TWKMail);
var
  AMail: TWKMail;
begin
  if not Assigned(MailToClone) then
    raise Exception.Create( 'MailToClone not specified' );

  AMail := TWKMail.Create(nil);
  AMail.Assign( MailToClone );

  // Thread is FreeOnTerminate, and also will destroy "AMail"
  TWKMailThread.Create(AMail);
end;

{ TMailAttachment }

constructor TMailAttachment.Create;
begin
  inherited Create;
  FStream := TMemoryStream.Create;
  FDisposition := adInline;
  Clear;
end;

destructor TMailAttachment.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

procedure TMailAttachment.Clear;
begin
  FFileName := '';
  FDescription  := '';
  FStream.Clear;
end;

procedure TMailAttachment.Assign(Source: TMailAttachment);
begin
  Clear;
  FFileName := Source.FileName;
  FDescription  := Source.Description;
  Source.Stream.Position := 0;
  FStream.CopyFrom(Source.Stream, Stream.Size);
  FDisposition := Source.Disposition;
end;

{ TMailAttachments }

procedure TMailAttachments.SetObject(Index: Integer; Item: TMailAttachment);
begin
   inherited Items[Index] := Item;
end;

function TMailAttachments.GetObject(Index: Integer): TMailAttachment;
begin
  Result := TMailAttachment(inherited Items[Index]);
end;

procedure TMailAttachments.Insert(Index: Integer; Obj: TMailAttachment);
begin
  inherited Insert(Index, Obj);
end;

function TMailAttachments.New: TMailAttachment;
begin
  Result := TMailAttachment.Create;
  Add(Result);
end;

function TMailAttachments.Add(Obj: TMailAttachment): Integer;
begin
  Result := inherited Add(Obj) ;
end;

{ TWKMail }

function TWKMail.GetHost: string;
begin
  Result := fSMTP.TargetHost;
end;

function TWKMail.GetPort: string;
begin
  Result := fSMTP.TargetPort;
end;

function TWKMail.GetUsername: string;
begin
  Result := fSMTP.UserName;
end;

function TWKMail.GetPassword: string;
begin
  Result := fSMTP.Password;
end;

function TWKMail.GetFullSSL: Boolean;
begin
  Result := fSMTP.FullSSL;
end;

function TWKMail.GetAutoTLS: Boolean;
begin
  Result := fSMTP.AutoTLS;
end;

procedure TWKMail.SetHost(const aValue: string);
begin
  fSMTP.TargetHost := aValue;
end;

procedure TWKMail.SetPort(const aValue: string);
begin
  fSMTP.TargetPort := aValue;
end;

procedure TWKMail.SetUsername(const aValue: string);
begin
  fSMTP.UserName := aValue;
end;

procedure TWKMail.SetPassword(const aValue: string);
begin
  fSMTP.Password := aValue;
end;

procedure TWKMail.SetFullSSL(aValue: Boolean);
begin
  fSMTP.FullSSL := aValue;
end;

procedure TWKMail.SetAutoTLS(aValue: Boolean);
begin
  fSMTP.AutoTLS := aValue;
end;

function TWKMail.GetPriority: TMessPriority;
begin
  Result := fMIMEMess.Header.Priority;
end;

procedure TWKMail.SetPriority(aValue: TMessPriority);
begin
  fMIMEMess.Header.Priority := aValue;
end;

procedure TWKMail.SetAttempts(AValue: Byte);
begin
  if fAttempts = AValue then Exit;
  fAttempts := Max(AValue, 1);
end;

procedure TWKMail.SmtpError(const pMsgError: string);
begin
  try
    fGetLastSmtpError := pMsgError;
    MailProcess(pmsError);
    DoException( Exception.Create(pMsgError) );
  finally
    Clear;
  end;
end;

procedure TWKMail.DoException(E: Exception);
Var
  ThrowIt: Boolean;
begin
  if Assigned(fOnMailException) then
  begin
    ThrowIt := True;
    fOnMailException( Self, E, ThrowIt );

    if ThrowIt then
      raise E
    else
    begin
      E.Free;
      Abort;
    end;
  end
  else
    raise E;
end;

procedure TWKMail.AddEmailWithDelimitersToList(aEmail: String; aList: TStrings
  );
var
  sDelimiter: Char;
begin
  aEmail := Trim(aEmail);
//wilson
 { sDelimiter := FindDelimiterInText(aEmail);

  if (sDelimiter = ' ') then
    aList.Add(aEmail)
  else
    AddDelimitedTextToList(aEmail, sDelimiter, aList);


    }
end;

procedure TWKMail.Clear;
begin
  ClearAttachments;
  fMIMEMess.Header.Clear;
  fMIMEMess.Clear;
  fReplyTo.Clear;
  fBCC.Clear;
  fSubject := '';
  fBody.Clear;
  fAltBody.Clear;
end;

procedure TWKMail.SaveToFile(const AFileName: String);
begin
  BuildMimeMess;
  
  if AFileName <> '' then
    fArqMIMe.SaveToFile(AFileName);

  Clear;
end;

procedure TWKMail.MailProcess(const aStatus: TMailStatus);
begin
  if Assigned(fOnMailProcess) then
    fOnMailProcess(Self, aStatus);
end;

constructor TWKMail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fSMTP := TSMTPSend.Create;
  fMIMEMess := TMimeMess.Create;
  fAltBody := CreateStringList;
  fBody := CreateStringList;
  fArqMIMe := TMemoryStream.Create;
  fAttachments := TMailAttachments.Create(True); // FreeObjects
  fTimeOut := 0;

  fOnBeforeMailProcess := nil;
  fOnAfterMailProcess := nil;

  fAttachments.Clear;
  SetPriority(MP_normal);
  fDefaultCharsetCode := UTF_8;
  fIDECharsetCode := {$IfDef USE_UTF8}UTF_8{$Else}{$IfDef MSWINDOWS}CP1252{$Else}UTF_8{$EndIf}{$EndIf};
  fReadingConfirmation := False;
  fDeliveryConfirmation := False;
  fIsHTML := False;
  fUseThread := False;
  fAttempts := 3;
  fFrom := '';
  fFromName := '';
  fSubject := '';

  fReplyTo := CreateStringList;
  {$IfDef HAS_STRICTDELIMITER}
  fReplyTo.StrictDelimiter := True;
  {$EndIf}
  fReplyTo.Delimiter := ';';

  fBCC := CreateStringList;
  {$IfDef HAS_STRICTDELIMITER}
  fBCC.StrictDelimiter := True;
  {$EndIf}
  fBCC.Delimiter := ';';

  // NOTAR ISSO: fSMTP.Sock.OnStatus := ;

end;

destructor TWKMail.Destroy;
begin
  ClearAttachments;
  fAltBody.Free;
  fBody.Free;
  fBCC.Free;
  fReplyTo.Free;
  fMIMEMess.Free;
  fSMTP.Free;
  fArqMIMe.Free;
  fAttachments.Free;
  
  inherited Destroy;
end;

procedure TWKMail.Assign(Source: TPersistent);
var
  i: Integer;
  AAttachment: TMailAttachment;
begin
  if not (Source is TWKMail) then
    raise Exception.Create('Source must be TWKMail');

  with TWKMail(Source) do
  begin
    Self.Host := Host;
    Self.Port := Port;
    Self.Username := Username;
    Self.Password := Password;
    Self.SetSSL := SetSSL;
    Self.SetTLS := SetTLS;
    Self.Priority := Priority;
    Self.ReadingConfirmation := ReadingConfirmation;
    Self.IsHTML := IsHTML;
    Self.UseThread := UseThread;
    Self.Attempts := Attempts;
    Self.From := From;
    Self.FromName := FromName;
    Self.Subject := Subject;
    Self.DefaultCharset := DefaultCharset;
    Self.IDECharset := IDECharset;
    Self.OnBeforeMailProcess := OnBeforeMailProcess;
    Self.OnMailProcess := OnMailProcess;
    Self.OnAfterMailProcess := OnAfterMailProcess;
    Self.OnMailException := OnMailException;
    Self.Tag := Tag;

    for i := 0 to Attachments.Count-1 do
    begin
      AAttachment := Self.Attachments.New;
      AAttachment.Assign(Attachments[I]);
    end;

    Self.AltBody.Assign(AltBody);
    Self.Body.Assign(Body);
    Self.ReplyTo.Assign(ReplyTo);
    Self.BCC.Assign(BCC);

    Self.MIMEMess.Header.ToList.Assign( MIMEMess.Header.ToList );
    Self.MIMEMess.Header.CCList.Assign( MIMEMess.Header.CCList );
    Self.MIMEMess.Header.Organization := MIMEMess.Header.Organization;
    Self.MIMEMess.Header.CustomHeaders.Assign( MIMEMess.Header.CustomHeaders );
    Self.MIMEMess.Header.Date := MIMEMess.Header.Date;
    Self.MIMEMess.Header.XMailer := MIMEMess.Header.XMailer;
  end;
end;

procedure TWKMail.Send(UseThreadNow: Boolean);
begin
  if UseThreadNow then
    SendEmailByThread(Self)
  else
    SendMail;
end;

procedure TWKMail.Send;
begin
  Send( UseThread );
end;

procedure TWKMail.BuildMimeMess;
var
  i: Integer;
  MultiPartParent, MimePartAttach : TMimePart;
  NeedMultiPartRelated, BodyHasImage: Boolean;
  AAttachment: TMailAttachment;
begin
  if Assigned(OnBeforeMailProcess) then
    OnBeforeMailProcess( self );

  MailProcess(pmsStartProcess);

  // Configuring the Headers //
  MailProcess(pmsConfigHeaders);

  fMIMEMess.Header.CharsetCode := fDefaultCharsetCode;
  fMIMEMess.Header.TargetCharset := fIDECharsetCode;
  fMIMEMess.Header.Subject := fSubject;

  if Trim(fFromName) <> '' then
    fMIMEMess.Header.From := '"' + fFromName + '" <' + From + '>'
  else
    fMIMEMess.Header.From := fFrom;

  if fReplyTo.Count > 0 then
    fMIMEMess.Header.ReplyTo := fReplyTo.DelimitedText;

  if fReadingConfirmation then
    fMIMEMess.Header.CustomHeaders.Insert(0, 'Disposition-Notification-To: ' + fMIMEMess.Header.From);

  if fDeliveryConfirmation then
    fMIMEMess.Header.CustomHeaders.Insert(0, 'Return-Receipt-To: ' + fMIMEMess.Header.From);

  fMIMEMess.Header.XMailer := 'Synapse - WKMail';

  // Adding MimeParts //
  // Inspiration: http://www.ararat.cz/synapse/doku.php/public:howto:mimeparts
  MailProcess(pmsAddingMimeParts);

  // Encoding according to IDE and Mail Charset //
  NeedMultiPartRelated := fIsHTML and (fBody.Count > 0) and (fAltBody.Count > 0);

  // The Root //
  MultiPartParent := fMIMEMess.AddPartMultipart( IfThen(NeedMultiPartRelated, 'alternative', 'mixed'), nil );
  MultiPartParent.CharsetCode := fDefaultCharsetCode;
  MultiPartParent.TargetCharset := fIDECharsetCode;
  MultiPartParent.ConvertCharset := (fDefaultCharsetCode <> fIDECharsetCode);

  // Text part //
  if (fAltBody.Count > 0) then
  begin
    with fMIMEMess.AddPart( MultiPartParent ) do
    begin
      fAltBody.SaveToStream(DecodedLines);
      Primary := 'text';
      Secondary := 'plain';
      Description := 'Message text';
      Disposition := 'inline';
      CharsetCode := fDefaultCharsetCode;
      TargetCharset := fIDECharsetCode;
      ConvertCharset := (fDefaultCharsetCode <> fIDECharsetCode);
      EncodingCode := ME_BASE64;
      EncodePart;
      EncodePartHeader;
    end;
  end;

  // Need New branch ? //
  if NeedMultiPartRelated then
  begin
    MultiPartParent := fMIMEMess.AddPartMultipart( 'related', MultiPartParent );
    MultiPartParent.CharsetCode := fDefaultCharsetCode;
    MultiPartParent.TargetCharset := fIDECharsetCode;
    MultiPartParent.ConvertCharset := (fDefaultCharsetCode <> fIDECharsetCode);
  end;

  if fIsHTML and (fBody.Count > 0) then
  begin
    // Adding HTML Part //
    with fMIMEMess.AddPart( MultiPartParent ) do
    begin
      fBody.SaveToStream(DecodedLines);
      Primary := 'text';
      Secondary := 'html';
      Description := 'HTML text';
      Disposition := 'inline';
      CharsetCode := fDefaultCharsetCode;
      TargetCharset := fIDECharsetCode;
      ConvertCharset := (fDefaultCharsetCode <> fIDECharsetCode);
      EncodingCode := ME_BASE64;
      EncodePart;
      EncodePartHeader;
    end;
  end;

  // Adding the Attachments //
  for i := 0 to fAttachments.Count-1 do
  begin
    AAttachment := fAttachments[i];
    BodyHasImage := pos(':'+LowerCase(AAttachment.Description), LowerCase(fBody.Text)) > 0;

    AAttachment.Stream.Position := 0;
    MimePartAttach := fMIMEMess.AddPart(MultiPartParent);
    MimePartAttach.DecodedLines.LoadFromStream(AAttachment.Stream);
    MimePartAttach.Description := AAttachment.Description;
    case AAttachment.Disposition of
      adInline: MimePartAttach.Disposition := 'inline';
    else
      MimePartAttach.Disposition := 'attachment';
    end;
    if fIsHTML and BodyHasImage then
      MimePartAttach.ContentID := AAttachment.Description;

    MimePartAttach.FileName    := ExtractFileName(AAttachment.FileName);
    MimePartAttach.EncodingCode:= ME_BASE64;
    MimePartAttach.PrimaryCode := MP_BINARY;  // To avoid MP_TEXT internal conversion ;
    MimePartAttach.CharsetCode := fIDECharsetCode;
    MimePartAttach.TargetCharset := fIDECharsetCode;
    MimePartAttach.ConvertCharset := False;
    MimePartAttach.MimeTypeFromExt(AAttachment.FileName);

    MimePartAttach.EncodePart;
    MimePartAttach.EncodePartHeader;
  end;

  fMIMEMess.EncodeMessage;

  fArqMIMe.Clear;
  fMIMEMess.Lines.SaveToStream(fArqMIMe);
end;

procedure TWKMail.SendMail;
var
  vAttempts: Byte;
  c, i: Integer;
  ErrorMsgs: String;

  procedure AddErrorMsg(const AError: String);
  begin
    if Trim(AError) = '' then
      Exit;

    if (pos(AError, ErrorMsgs) = 0) then
    begin
      if (ErrorMsgs <> '') then
        ErrorMsgs := ErrorMsgs + sLineBreak;

      ErrorMsgs := ErrorMsgs + AError;
    end;
  end;

begin
  ErrorMsgs := '';
  BuildMimeMess;

  if fTimeOut > 0 then
  begin
    fSMTP.Timeout := fTimeOut;
    fSMTP.Sock.ConnectionTimeout := fTimeOut;
  end;

  // DEBUG //
  // SaveToFile('c:\app\Mail.eml'); {Para debug, comentar o Clear; da linha 367}

  // Login in SMTP //
  MailProcess(pmsLoginSMTP);
  if (fSMTP.TargetHost = '') then
    SmtpError('SMTP Error: Server not informed');

  for vAttempts := 1 to fAttempts do
  begin
    if fSMTP.Login then
      Break;

    AddErrorMsg(fSMTP.ResultString);
    AddErrorMsg(IntToStr(fSMTP.Sock.LastError) + ' - ' + fSMTP.Sock.LastErrorDesc);

    if vAttempts >= fAttempts then
      SmtpError('SMTP Error: Unable to Login.' + sLineBreak + ErrorMsgs);
  end;

  if fDeliveryConfirmation then
  begin
    if (fSMTP.FindCap('DSN') = '') then
      SmtpError('SMTP Error: The SMTP Server does not support Delivery Status Notification');

    fSMTP.DeliveryStatusNotification := [dsnSucecess, dsnFailure];
  end;

  // Sending Mail Form //
  MailProcess(pmsStartSends);

  for vAttempts := 1 to fAttempts do
  begin
    if fSMTP.MailFrom(fFrom, Length(fFrom)) then
      Break;

    AddErrorMsg(fSMTP.ResultString);
    if vAttempts >= fAttempts then
      SmtpError('SMTP Error: Unable to send MailFrom.' + sLineBreak + ErrorMsgs);
  end;

  // Sending MailTo //
  MailProcess(pmsSendTo);

  for i := 0 to fMIMEMess.Header.ToList.Count - 1 do
  begin
    for vAttempts := 1 to fAttempts do
    begin
      if fSMTP.MailTo(GetEmailAddr(fMIMEMess.Header.ToList[i]))then
        Break;

      AddErrorMsg(fSMTP.ResultString);
      if vAttempts >= fAttempts then
        SmtpError('SMTP Error: Unable to send MailTo.' + sLineBreak + ErrorMsgs);
    end;
  end;

  // Sending Carbon Copies //
  c := fMIMEMess.Header.CCList.Count;
  if c > 0 then
    MailProcess(pmsSendCC);

  for i := 0 to c - 1 do
  begin
    for vAttempts := 1 to fAttempts do
    begin
      if fSMTP.MailTo(GetEmailAddr(fMIMEMess.Header.CCList[i])) then
        Break;

      AddErrorMsg(fSMTP.ResultString);
      if vAttempts >= fAttempts then
        SmtpError('SMTP Error: Unable to send CC list.' + sLineBreak + ErrorMsgs);
    end;
  end;

  // Sending Blind Carbon Copies //
  c := fBCC.Count;
  if c > 0 then
    MailProcess(pmsSendBCC);

  for i := 0 to c - 1 do
  begin
    for vAttempts := 1 to fAttempts do
    begin
      if fSMTP.MailTo(GetEmailAddr(fBCC[I])) then
        Break;

      AddErrorMsg(fSMTP.ResultString);
      if vAttempts >= fAttempts then
        SmtpError('SMTP Error: Unable to send BCC list.' + sLineBreak + ErrorMsgs);
    end;
  end;

  // Sending MIMEMess Data //
  MailProcess(pmsSendData);

  for vAttempts := 1 to fAttempts do
  begin
    if fSMTP.MailData(fMIMEMess.Lines) then
      Break;

    AddErrorMsg(fSMTP.ResultString);
    if vAttempts >= fAttempts then
      SmtpError('SMTP Error: Unable to send Mail data.' + sLineBreak + ErrorMsgs);
  end;

  // Login out from SMTP //
  MailProcess(pmsLogoutSMTP);

  for vAttempts := 1 to fAttempts do
  begin
    if fSMTP.Logout then
      Break;

    AddErrorMsg(fSMTP.ResultString);
    if vAttempts >= fAttempts then
      SmtpError('SMTP Error: Unable to Logout.' + sLineBreak + ErrorMsgs);
  end;

  // Done //
  try
    MailProcess(pmsDone);

    if Assigned(OnAfterMailProcess) then
      OnAfterMailProcess( self );
  finally
    Clear;
  end;
end;

procedure TWKMail.ClearAttachments;
begin
  fAttachments.Clear;
end;

procedure TWKMail.AddAttachment(const aFileName: string; aDescription: string;
  const aDisposition: TMailAttachmentDisposition = adInline);
var
  AAttachment: TMailAttachment;
begin
  if not FileExists(aFileName) then
    DoException( Exception.Create('Add Attachment: File not Exists.') );

  AAttachment := fAttachments.New;
  AAttachment.FileName     := aFileName;

  if (aDescription = '') then
    AAttachment.Description := ExtractFileName(AAttachment.FileName)
  else
    AAttachment.Description := aDescription;

  AAttachment.Disposition := aDisposition;

  AAttachment.Stream.LoadFromFile(aFileName)
end;

procedure TWKMail.AddAttachment(const aFileName: string);
begin
  AddAttachment(aFileName, '');
end;

procedure TWKMail.AddAttachment(aStream: TStream; aDescription: string;
  const aDisposition: TMailAttachmentDisposition = adInline);
var
  AAttachment: TMailAttachment;
begin
  if not Assigned(aStream) then
    DoException( Exception.Create('Add Attachment: Access Violation.') );

  if (Trim(aDescription) = '') then
    aDescription := 'file_' + FormatDateTime('hhnnsszzz',Now);

  aStream.Position := 0;
  AAttachment := fAttachments.New;
  AAttachment.FileName    := aDescription;
  AAttachment.Description := aDescription;
  AAttachment.Disposition := aDisposition;
  AAttachment.Stream.CopyFrom(aStream, aStream.Size);
end;

procedure TWKMail.AddAttachment(aStream: TStream);
begin
  AddAttachment(aStream, '');
end;

procedure TWKMail.AddAddress(const aEmail: string; const aName: string);
begin
  if Trim(aName) <> '' then
    fMIMEMess.Header.ToList.Add('"' + aName + '" <' + aEmail + '>')
  else
    AddEmailWithDelimitersToList(aEmail, fMIMEMess.Header.ToList);
end;

procedure TWKMail.AddReplyTo(const aEmail: string; const aName: string);
begin
  if Trim(aName) <> '' then
    fReplyTo.Add('"' + aName + '" <' + aEmail + '>')
  else
    AddEmailWithDelimitersToList(aEmail, fReplyTo);
end;

procedure TWKMail.AddCC(const aEmail: string; const aName: string);
begin
  if Trim(aName) <> '' then
    fMIMEMess.Header.CCList.Add('"' + aName + '" <' + aEmail + '>')
  else
    AddEmailWithDelimitersToList(aEmail, fMIMEMess.Header.CCList);
end;

procedure TWKMail.AddBCC(const aEmail: string);
begin
  AddEmailWithDelimitersToList(aEmail, fBCC);
end;

function TWKMail.SaveToStream(AStream: TStream): Boolean;
begin
  Result := True;
  try
    fArqMIMe.SaveToStream(AStream);
  except
    Result := False;
  end;
end;

{ TWKMailThread }

constructor TWKMailThread.Create(AOwner: TWKMail);
begin
  FreeOnTerminate  := True;
  FWKMail        := AOwner;

  inherited Create(False);
end;

procedure TWKMailThread.Execute;
begin
  FStatus := pmsStartProcess;

  // Save events pointers
  FOnMailProcess   := FWKMail.OnMailProcess ;
  FOnMailException := FWKMail.OnMailException;
  FOnBeforeMailProcess := FWKMail.OnBeforeMailProcess;
  FOnAfterMailProcess := FWKMail.OnAfterMailProcess;
  MailCriticalSection.Acquire;
  try
    // Redirect events to Internal methods, to use Synchronize
    FWKMail.OnMailException := MailException;
    FWKMail.OnMailProcess := MailProcess;
    FWKMail.OnBeforeMailProcess := BeforeMailProcess;
    FWKMail.OnAfterMailProcess := AfterMailProcess;
    FWKMail.UseThread := False;

    if (not Self.Terminated) then
      FWKMail.SendMail;
  finally
    // Discard WKMail copy
    FWKMail.Free;
    Terminate;
    MailCriticalSection.Release;
  end;
end;

procedure TWKMailThread.MailProcess(const AMail: TWKMail;
  const aStatus: TMailStatus);
begin
  FStatus := aStatus;
  Synchronize(DoMailProcess);
end;

procedure TWKMailThread.DoMailProcess;
begin
  if Assigned(FOnMailProcess) then
    FOnMailProcess(FWKMail, FStatus) ;
end;

procedure TWKMailThread.BeforeMailProcess(Sender: TObject);
begin
  Synchronize(DoBeforeMailProcess);
end;

procedure TWKMailThread.DoBeforeMailProcess;
begin
  if Assigned(FOnBeforeMailProcess) then
    FOnBeforeMailProcess( FWKMail );
end;

procedure TWKMailThread.AfterMailProcess(Sender: TObject);
begin
  Synchronize(DoAfterMailProcess);
end;

procedure TWKMailThread.DoAfterMailProcess;
begin
  if Assigned(FOnAfterMailProcess) then
    FOnAfterMailProcess( FWKMail );
end;

procedure TWKMailThread.MailException(const AMail: TWKMail;
  const E: Exception; var ThrowIt: Boolean);
begin
  FException := E;
  Synchronize(DoMailException);
  ThrowIt := False;
end;

procedure TWKMailThread.DoMailException;
begin
  FThrowIt := False;
  if Assigned(FOnMailException) then
    FOnMailException(FWKMail, FException, FThrowIt);
end;

initialization
  MailCriticalSection := TCriticalSection.Create;

finalization;
  MailCriticalSection.Free;

end.


