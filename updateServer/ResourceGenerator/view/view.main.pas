unit view.main;

interface

uses
  System.SysUtils,
  FMX.Types,
  System.Types,
  FMX.ListView.Types,
  Inifiles,

  FMX.Platform, FMX.VirtualKeyboard,
  lib.util,
  lib.Connection,
  lib.Config,

  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  System.Rtti,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  System.ImageList,
  FMX.ImgList,
  Data.Bind.Components,
  Data.Bind.DBScope,
  FMX.Controls,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.StdCtrls,
  FMX.ListView,
  FMX.Edit,
  FMX.Layouts,
  FMX.Objects,
  FMX.TabControl,
  System.Classes,
  FMX.Controls.Presentation,
  System.UITypes,
  System.JSON,
  service.resource.generator,
  FMX.DialogService,
  FMX.WebBrowser,
  FMX.Calendar,
  System.IOUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

{$IF DEFINED(ANDROID)}
  // -----------------ANDROID

  Androidapi.JNI.Webkit,
  Androidapi.JNI.App,
  FMX.Helpers.android,
  Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNIBridge,
  Androidapi.JNI.Os,
  Androidapi.JNI.Net,
  Androidapi.Helpers,
  Androidapi.JNI.Widget,

  FMX.ZOrder.android,
  nagram.service.geolocation,
  FMX.Platform.android,

  FMX.FontGlyphs.android,
{$ENDIF}
{$IF DEFINED(MSWINDOWS)}
{$ENDIF}
  FMX.Surfaces,
  FMX.DialogService.Async,
  FMX.Forms,
  FMX.Effects,
  FMX.Dialogs,
  FMX.Ani,
  FMX.ListBox,
  System.Actions,
  FMX.ActnList,
  FMX.MultiView,
  FMX.Menus,
  System.Sensors,
  System.Sensors.Components,
  FMX.Graphics,
  FMX.Memo.Types, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Comp.UI

    ;

type
  Tfmain = class(TForm)
    toolbarmain: TToolBar;
    AniIndicator1: TAniIndicator;
    ImageList1: TImageList;
    TmLabel: TTimer;
    ImageList2: TImageList;
    tm_iniciar: TTimer;
    pnloperacao: TToolBar;
    Rectangle5: TRectangle;
    btGerarResource: TSpeedButton;
    lblinteracao: TLabel;
    toomainconfig: TToolBar;
    SettingsMain: TLabel;
    lstdadosgerais: TListBox;
    AccountInfo: TListBoxGroupHeader;
    SyncSettings: TListBoxGroupHeader;
    lstDadosAlias: TListBoxItem;
    Label10: TLabel;
    btoptions: TSpeedButton;
    pnexec: TRectangle;
    ccopanel: TColorAnimation;
    FloatAnimation1: TFloatAnimation;
    layoutmaster: TLayout;
    recBody: TRectangle;
    rectarquee: TRectangle;
    lbinfouser: TLabel;
    flapnexec: TFloatAnimation;
    ColorAnimation2: TColorAnimation;
    flatoooperacao: TFloatAnimation;
    lstDadosDiretorio: TListBoxItem;
    Label3: TLabel;
    edtDiretorio: TEdit;
    lblversion: TLabel;
    lbexec: TLabel;
    MultiView1: TMultiView;
    OverflowMenu: TListBox;
    ListBoxItem3: TListBoxItem;
    Image2: TImage;
    lilogout: TListBoxItem;
    liespace: TListBoxItem;
    ListBoxItem1: TListBoxItem;
    sweoverflowmenu: TShadowEffect;
    efcoverflowmenu: TFloatAnimation;
    Label4: TLabel;
    stepindicador: TAniIndicator;
    tabmaster: TTabControl;
    taboperacao: TTabItem;
    tabconfig: TTabItem;
    mainthema: TStyleBook;
    imgLogo: TImage;
    memoLog: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    memoTabelas: TMemo;
    edtAddTabela: TEdit;
    btAddTabela: TButton;
    memoAlias: TMemo;
    btLoadTabelas: TButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Label1: TLabel;
    Label2: TLabel;
    lstDadosBanco: TListBoxItem;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtServer: TEdit;
    edtBanco: TEdit;
    edtUser: TEdit;
    edtSenha: TEdit;
    btGravar: TButton;
    procedure btGerarResourceClick(Sender: TObject);
    procedure btstopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure btaddtagClick(Sender: TObject);
    procedure btaba1Click(Sender: TObject);
    procedure TmLabelTimer(Sender: TObject);

    procedure edtusercontaEnter(Sender: TObject);
    procedure btbackeditcomentarioClick(Sender: TObject);
    procedure tm_iniciarTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var action: TCloseAction);
    procedure lilogoutClick(Sender: TObject);
    procedure taboperacaoPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure taboperacaoTap(Sender: TObject; const Point: TPointF);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btAddTabelaClick(Sender: TObject);
    procedure btLoadTabelasClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure linomecontaClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);

  private
    { Private declarations }
    FConnection: TConnection;

    Procedure setTabelas();
    procedure saveAliasTabelas();
    procedure loadAliasTabelas();
    procedure OnInputQuery_Close(const AResult: TModalResult;
      const AValues: array of string);

    procedure LogOut;
    procedure OnCloseDialog(Sender: TObject; const AResult: TModalResult);

    procedure onGerarResource(Sender: TObject; mensagem: string);
    procedure onlog(Sender: TObject; mensagem: string);
    procedure onFinalizar(Sender: TObject);

  public
    { Public declarations }

  end;

const

  _ctAliases = 'aliases.txt';

var
  fmain: Tfmain;
  fbol: Boolean;

implementation

{$R *.fmx}

procedure Tfmain.btstopClick(Sender: TObject);
begin
  AniIndicator1.Enabled := false;
  AniIndicator1.Visible := false;
  btGerarResource.Enabled := True;
  lblinteracao.Text := 'Processo interompido.';
  TmLabel.Enabled := false;
  btGerarResource.ImageIndex := 12;
  lblinteracao.Visible := True;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.edtusercontaEnter(Sender: TObject);
begin
  if assigned(TEdit(Sender).Parent) and
    (TEdit(Sender).Parent.ClassName = 'TListBoxItem') then
    TListBoxItem(TEdit(Sender).Parent).TextSettings.Font.Size := 5;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.btaba1Click(Sender: TObject);
begin
  tabmaster.ActiveTab := taboperacao;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.btAddTabelaClick(Sender: TObject);
begin
  if edtAddTabela.Text <> '' then
    memoTabelas.Lines.Add(edtAddTabela.Text);
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.btaddtagClick(Sender: TObject);
begin
  TDialogServiceAsync.InputQuery('Indique a hash tag', [''], [''],
    Self.OnInputQuery_Close);

end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.btGerarResourceClick(Sender: TObject);

begin
  try
    if memoTabelas.Lines.Count = 0 then
      raise Exception.Create('Nehuma tabela selecionada');
    AniIndicator1.Visible := True;
    TServerConfig.ConfigDB;

    AniIndicator1.Enabled := True;
    LogOut;
    AniIndicator1.Enabled := True;
    btGerarResource.Enabled := false;
    btGerarResource.ImageIndex := 7;
    lblinteracao.Text := 'Iniciando processo';
    TmLabel.Enabled := True;
    stepindicador.Visible := True;
    with TResourceGenerator.Create(True) do
    begin

      aliases := memoAlias.Text;
      tabelasText := memoTabelas.Text;
      diretorio := edtDiretorio.Text;
      onlog := Self.onlog;
      onGerarResource := Self.onGerarResource;
      onterminate := Self.onFinalizar;
      FreeOnTerminate := True;
      resume();
    end;
  except
    on e: Exception do
    begin
      ShowMessage('Lamento não pude iniciar  ' + e.Message);
      AniIndicator1.Enabled := false;
      AniIndicator1.Visible := false;
      btGerarResource.Enabled := True;
      lblinteracao.Text := 'Inativo';
    end;
  end;
end;

procedure Tfmain.btGravarClick(Sender: TObject);
var
  IniPath: string;
  IniFile: TIniFile;

begin

  IniPath := ExtractFilePath(GetModuleName(HInstance)) + IniName;
  try
    IniFile := TIniFile.Create(IniPath);
    IniFile.WriteString('Config', 'Database', edtBanco.Text);
    IniFile.WriteString('Config', 'Server', edtServer.Text);
    IniFile.WriteString('Config', 'User_Name', edtUser.Text);
    IniFile.WriteString('Config', 'Password', edtSenha.Text);
  finally
    FreeAndNil(IniFile);
  end;

  TServerConfig.ConfigDB;
  try
    if not assigned(FConnection) then
      FConnection := TConnection.Create;

  finally
    FConnection.DB.Close;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.btLoadTabelasClick(Sender: TObject);
begin
  setTabelas();
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.FormClose(Sender: TObject; var action: TCloseAction);
begin
  Halt(0);
  fmain := nil;

end;

procedure Tfmain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.FormCreate(Sender: TObject);
var
  IniPath: string;
  IniFile: TIniFile;
begin
  try
{$IF DEFINED(MSWINDOWS)}
    Self.FullScreen := false;
    Self.ShowFullScreenIcon := false;

{$ELSE}
    Self.FullScreen := True;
    Self.ShowFullScreenIcon := True;
{$ENDIF}
    tm_iniciar.Enabled := True;

    tabmaster.ActiveTab := taboperacao;

    MultiView1.Mode := TMultiViewMode(3);

    AniIndicator1.Visible := false;
    AniIndicator1.Enabled := false;
    pnexec.Visible := false;

    edtDiretorio.Text := ExtractFilePath(GetModuleName(HInstance)) + '\Output';
    ForceDirectories(edtDiretorio.Text);
    loadAliasTabelas();

    IniPath := ExtractFilePath(GetModuleName(HInstance)) + IniName;
    try
      IniFile := TIniFile.Create(IniPath);
      edtBanco.Text := IniFile.ReadString('Config', 'Database', '');
      edtServer.Text := IniFile.ReadString('Config', 'Server', '');
      edtUser.Text := IniFile.ReadString('Config', 'User_Name', '');
      edtSenha.Text := IniFile.ReadString('Config', 'Password', '');
    finally
      FreeAndNil(IniFile);
    end;

  except
    on e: Exception do
    begin
      tutil.gravalog('[TVIEWMAIN 548]' + e.Message);
    end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);

var
  FService: IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService
      (IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible
      in FService.VirtualKeyBoardState) then
    begin

    end
    else
    begin
      Key := 0;

      MessageDlg('Sair do sistema?', TMsgDlgType.mtConfirmation,
        [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel], -1, OnCloseDialog);
    end;
  end;
end;

procedure Tfmain.FormPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.OnCloseDialog(Sender: TObject; const AResult: TModalResult);
begin
  if AResult = mrOK then
  begin
    Halt(0);
    // Close;
  end;
end;

procedure Tfmain.onFinalizar(Sender: TObject);
begin
  stepindicador.Visible := false;
  Application.ProcessMessages;
  stepindicador.Visible := True;
  TmLabel.Enabled := false;
  AniIndicator1.Enabled := false;
  AniIndicator1.Visible := false;
  btGerarResource.Enabled := True;
  btGerarResource.ImageIndex := 12;
  lblinteracao.Text := 'Processo finalizado';
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.onGerarResource(Sender: TObject; mensagem: string);
begin
  if mensagem <> '' then
  begin
    memoLog.BeginUpdate;
    lblinteracao.Text := mensagem;
    memoLog.Lines.Add(mensagem);
    memoLog.EndUpdate;
    memoLog.UpdateRect;

  end;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.lilogoutClick(Sender: TObject);
begin
  btstopClick((Nil));

  Self.Close;
end;

procedure Tfmain.linomecontaClick(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.loadAliasTabelas;
begin

end;

procedure Tfmain.LogOut;
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
var

  CookieSyncManager: JCookieSyncManager;
  CookieManager: JCookieManager;

{$ENDIF}
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  CookieSyncManager := TJCookieSyncManager.JavaClass.createInstance
    (TAndroidHelper.Context);
  CookieManager := TJCookieManager.JavaClass.GetInstance;
  CookieManager.removeAllCookie
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.OnInputQuery_Close(const AResult: TModalResult;
  const AValues: array of string);
begin

end;

procedure Tfmain.onlog(Sender: TObject; mensagem: string);
begin
  memoLog.Lines.Add(mensagem);
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.saveAliasTabelas;
begin
  memoAlias.Lines.SaveToFile(ExtractFilePath(GetModuleName(HInstance)) +
    _ctAliases);
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.setTabelas;
begin
  TServerConfig.ConfigDB;
  try
    if not assigned(FConnection) then
      FConnection := TConnection.Create;
    FConnection.DB.GetTableNames('', 'public', '', memoTabelas.Lines, [osMy],
      [tkTable]);;
  finally
    FConnection.DB.Close;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.btbackeditcomentarioClick(Sender: TObject);
begin
  // tabcontrolcomentarios.SetActiveTabWithTransition(tabsubcomentariosview,
  // TTabTransition(2), TTabTransitionDirection(1));
end;

procedure Tfmain.taboperacaoPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  stepindicador.Visible := false;
  stepindicador.Enabled := false;
end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.taboperacaoTap(Sender: TObject; const Point: TPointF);
begin
  stepindicador.Visible := True;
  stepindicador.Enabled := True;
end;

procedure Tfmain.TmLabelTimer(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure Tfmain.tm_iniciarTimer(Sender: TObject);
begin
  stepindicador.Visible := True;
  pnexec.Visible := True;
  lbexec.Text := 'Iniciando app';
  // sleep(1000);
  tm_iniciar.Enabled := false;
  stepindicador.Visible := false;
  pnexec.Visible := false;
  lbexec.Text := '';

end;

end.
