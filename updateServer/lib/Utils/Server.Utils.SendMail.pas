unit Server.Utils.SendMail;

interface

uses
  System.Classes, IdMessage,
  IdSMTP, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  IdText,
  System.SysUtils,
  IdAttachmentFile

    , REST.Authenticator.EnhancedOAuth, IdIntercept, IdGlobal, IdContext,
  IdCustomHTTPServer, IdCustomTCPServer, IdHTTPServer, IdSMTPBase,
  IdTCPConnection, IdTCPClient, IdSASLCollection,
  IdMessageClient, IdPOP3, IdBaseComponent, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSASL,
  IdSASL.OAuth.Base, Email.Demo.Types

    ;

const
  From = 'wilson.rodrigues@wkconsultoria.com.br';
  Password = 'Ww2061614#d';

type
  TSendMail = class(TThread)
  private
    FMensagem: String;
    idMsg: TIdMessage;
    FAssunto: String;
    FDestinatario: String;
    procedure SetDestinatario(const Value: String);

  protected

  public
    procedure Execute; override;
    property Destinatario: String read FDestinatario write SetDestinatario;
    property Mensagem: String read FMensagem write FMensagem;
    property Assunto: String read FAssunto write FAssunto;
    procedure SetAnexo(Path: String);
  end;

implementation

{ TSendMail }

procedure TSendMail.Execute;
var
  IdText: TIdText;
  IdSMTP: TIdSMTP;
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  FOAuth2_Enhanced: TEnhancedOAuth2Authenticator;
  Provider: TMailProviderInfo;
  xoauthSASL: TIdSASLListEntry;
begin
  try

   {  preparacao para oauth2
    FOAuth2_Enhanced := TEnhancedOAuth2Authenticator.Create(nil);
    FOAuth2_Enhanced.ClientID := Provider.ClientID;
    FOAuth2_Enhanced.ClientSecret := Provider.ClientSecret;

    FOAuth2_Enhanced.RefreshAccessTokenIfRequired;

    if FOAuth2_Enhanced.AccessToken.Length = 0 then
    begin

      Exit;
    end;

    xoauthSASL := IdSMTP.SASLMechanisms.Add;
    xoauthSASL.SASL := Provider.AuthenticationType.Create(nil);

    TIdSASLOAuthBase(xoauthSASL.SASL).Token := FOAuth2_Enhanced.AccessToken;
    TIdSASLOAuthBase(xoauthSASL.SASL).User := Provider.ClientAccount; }

    IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvTLSv1_2;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;
    IdSSLIOHandlerSocket.Port := 587;
    if idMsg = nil then
      idMsg := TIdMessage.Create(nil);
    idMsg.CharSet := 'utf-8';
    idMsg.Encoding := meMIME;
    idMsg.From.Name := 'wilson.rodrigues';
    idMsg.From.Address := From;
    idMsg.Priority := mpHigh;
    idMsg.Subject := Assunto;
    idMsg.Recipients.Add;

    idMsg.Recipients.EMailAddresses := FDestinatario;

    IdText := TIdText.Create(idMsg.MessageParts);
    IdText.Body.Add(Mensagem);
    IdText.ContentType := 'text/html; charset=iso-8859-1';

    IdSMTP := TIdSMTP.Create(nil);
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseImplicitTLS;
    //IdSMTP.AuthType := satSASL;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Host := 'smtp.gmail.com';
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := 465;
    IdSMTP.Username := From;
    IdSMTP.Password := Password;

    try
      IdSMTP.Connect;
    except
      on e: exception do
      begin

        raise exception.Create('falha ao conectar ' + e.Message);
      end;

    end;

    IdSMTP.Authenticate;

    IdSMTP.Send(idMsg);

    IdSMTP.Disconnect;
  finally
    FreeAndNil(idMsg);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;

end;

procedure TSendMail.SetAnexo(Path: String);
begin
  if idMsg = nil then
    idMsg := TIdMessage.Create(nil);
  TIdAttachmentFile.Create(idMsg.MessageParts, Path);
end;

procedure TSendMail.SetDestinatario(const Value: String);
begin
  FDestinatario := Value;
end;

end.
