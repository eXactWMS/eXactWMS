unit Server.Interfaces.SendEMail;

interface

uses
  Web.HTTPApp;

type

  iSendEMail = interface
  ['{5D744494-C942-4C96-A075-5266ABC56740}']
   procedure Send(MessegeEmail, Email, Subject:string; IsBase64:Boolean) ;
  end;

implementation

end.
