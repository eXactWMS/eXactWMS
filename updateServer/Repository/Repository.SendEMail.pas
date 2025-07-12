unit Repository.SendEMail;

interface

uses
  System.Classes,
  Server.Attributes,
  Server.Utils.SendMail2,

  json,
  System.SysUtils,
  Server.Connection,
  Server.Interfaces.SendEMail,
  REST.json,

  System.Generics.Collections,
  Server.MessageList,
  Web.HTTPApp,
  Server.Message,
  System.Rtti,

  Server.ResourceBaseClass;

type

  [Resource('sendemail')]

  TSendEmail = class(TPersistent,iSendEMail)
  private
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    procedure Send(MessegeEmail, Email, Subject:string; IsBase64:Boolean) ;

  public
    [DBField('email', True, True, True, notnull)]
    email: String;
    [DBField('subject', True, True, True, null)]
    subject: String;
    [DBField('message', True, True, True, notnull)]
    Message: String;
    [DBField('base64', True, True, True, null)]
    base64: Boolean;
    [Post]
    procedure Post(Response: TWebResponse; Dados: TJSONObject;
      Conn: TConnection = nil);
  end;

implementation

{ TSendEmail }

procedure TSendEmail.Post(Response: TWebResponse; Dados: TJSONObject;
  Conn: TConnection);
var
  LJsonResponse: TJSONObject;
  LMessageType: TMessageType;
  LMessegeEmail: string;
  LEmail: string;
  LSubject: string;
  LIsBase64: Boolean;
begin

  LJsonResponse := TJSONObject.Create;
  try
    LMessageType := EErroGeral;
    if not assigned(Dados) then
    begin
      TMessage.Create(LMessageType, 'Corpo da requisição invalido')
        .SendMessage(Response);
      Exit;
    end;

    Dados.TryGetValue<string>('email', LEmail);
    Dados.TryGetValue<string>('message', LMessegeEmail);
    Dados.TryGetValue<string>('subject', LSubject);
    Dados.TryGetValue<Boolean>('base64', LIsBase64);

    if (LEmail.trim.IsEmpty) then
    begin
      TMessage.Create(LMessageType, 'Email não informado!')
        .SendMessage(Response);
      Exit
    end;


    try

      Send(LMessegeEmail, LEmail, LSubject, LIsBase64);
      LMessageType := IEmailEnviado;
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

  finally

  end;
end;

function TSendEmail.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
 Inherited;
end;
function TSendEmail._AddRef: Integer;
begin
 Inherited;
end;

function TSendEmail._Release: Integer;
begin
   Inherited;
end;
procedure TSendEmail.Send(MessegeEmail, Email, Subject: string;
  IsBase64: Boolean);
var
  LSendEmail: TSendMail;
begin
  LSendEmail := TSendMail.Create(True);
  try
    LSendEmail.Mensagem := MessegeEmail;
    LSendEmail.Destinatario := Email;
    LSendEmail.Assunto := Subject;
    LSendEmail.Isbase64 := Isbase64;
    // LSendEmail.FreeOnTerminate := True;
    LSendEmail.Execute;
  finally
    FreeAndNil(LSendEmail);
  end;

end;


initialization

RegisterClass(TSendEmail);

end.
