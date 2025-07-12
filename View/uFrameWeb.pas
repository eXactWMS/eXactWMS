unit uFrameWeb;

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  {$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFConstants, uCEFTypes,
  uCEFWinControl, uCEFSentinel, uCEFChromiumCore;
type
  TFrameNavigator = class(TFrame)
    TmFrameWeb: TTimer;
    Chromium1: TChromium;
    CEFSentinel1: TCEFSentinel;
    CEFWindowParent1: TCEFWindowParent;
    procedure TmFrameWebTimer(Sender: TObject);
    procedure CEFSentinel1Close(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1BeforePopup(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; const targetUrl, targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings;
      var extra_info: ICefDictionaryValue; var noJavascriptAccess,
      Result: Boolean);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser;
      var aAction: TCefCloseBrowserAction);
    procedure Chromium1OpenUrlFromTab(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const targetUrl: ustring; targetDisposition: TCefWindowOpenDisposition;
      userGesture: Boolean; out Result: Boolean);
  private

  protected
    // You have to handle this two messages to call NotifyMoveOrResizeStarted or some page elements will be misaligned.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
    // You also have to handle these two messages to set GlobalCEFApp.OsmodalLoop
    procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
    procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;

    procedure BrowserCreatedMsg(var aMessage : TMessage); message CEF_AFTERCREATED;
    procedure BrowserDestroyMsg(var aMessage : TMessage); message CEF_DESTROY;
  public
    FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
    FClosing  : boolean;  // Set to True in the CloseQuery event.
    Procedure GetUrl(pUrl : uString);
  end;

implementation

{$R *.dfm}

Uses uCEFApplication, uCefMiscFunctions;

{ TFrameNavigator }

{ TFrameNavigator }

procedure TFrameNavigator.BrowserCreatedMsg(var aMessage: TMessage);
begin
//
end;

procedure TFrameNavigator.BrowserDestroyMsg(var aMessage: TMessage);
begin
  CEFWindowParent1.Free;
end;

procedure TFrameNavigator.CEFSentinel1Close(Sender: TObject);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TFrameNavigator.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  PostMessage(Handle, CEF_AFTERCREATED, 0, 0);
end;

procedure TFrameNavigator.Chromium1BeforeClose(Sender: TObject;
  const browser: ICefBrowser);
begin
  CEFSentinel1.Start;
end;

procedure TFrameNavigator.Chromium1BeforePopup(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl,
  targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition;
  userGesture: Boolean; const popupFeatures: TCefPopupFeatures;
  var windowInfo: TCefWindowInfo; var client: ICefClient;
  var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue;
  var noJavascriptAccess, Result: Boolean);
begin
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TFrameNavigator.Chromium1Close(Sender: TObject;
  const browser: ICefBrowser; var aAction: TCefCloseBrowserAction);
begin
  PostMessage(Handle, CEF_DESTROY, 0, 0);
  aAction := cbaDelay;
end;

procedure TFrameNavigator.Chromium1OpenUrlFromTab(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl: ustring;
  targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
  out Result: Boolean);
begin
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TFrameNavigator.GetUrl(pUrl: uString);
begin
  Chromium1.LoadURL(pUrl);
end;

procedure TFrameNavigator.TmFrameWebTimer(Sender: TObject);
begin
  TmFrameWeb.Enabled := False;
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) and not(Chromium1.Initialized) then
    TmFrameWeb.Enabled := True;
end;

procedure TFrameNavigator.WMEnterMenuLoop(var aMessage: TMessage);
begin
  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := True;
end;

procedure TFrameNavigator.WMExitMenuLoop(var aMessage: TMessage);
begin
  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := False;
end;

procedure TFrameNavigator.WMMove(var aMessage: TWMMove);
begin
  if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure TFrameNavigator.WMMoving(var aMessage: TMessage);
begin
  if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

end.
