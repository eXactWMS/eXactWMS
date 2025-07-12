unit uFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uLoggerSingleton, System.Notification, JvComputerInfoEx, JclSysInfo,
  Vcl.StdCtrls, acImage, Vcl.Buttons, Vcl.ExtCtrls, JvComponentBase, acPNG
  , Rest.Json, System.Json, Rest.Types;

type
  TSysInfo = Record
    PercBattery : Integer;
    KeyBoard    : tJvKeyInfo;
    OS          : tJvOsVersionInfo;
    Screen      : tJvScreenInfo;
  End;

  TFrmLogin = class(TForm)
    ImgFdo: TImage;
    JvComputerInfoEx1: TJvComputerInfoEx;
    Timer1: TTimer;
    edtCodigo: TLabeledEdit;
    btnPesquisar: TSpeedButton;
    edtSenha: TLabeledEdit;
    Label3: TLabel;
    LblUsuario: TLabel;
    BalloonHint1: TBalloonHint;
    PnlFooter: TPanel;
    LblVersao: TLabel;
    LblServidor: TLabel;
    PnlFundo: TPanel;
    ImgBtnCancelar: TsImage;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    PnlLogIn: TPanel;
    LblLogin: TLabel;
    BtnLogin: TShape;
    Bevel2: TBevel;
    Label1: TLabel;
    PnlImgFoot: TPanel;
    Image1: TImage;
    Label2: TLabel;
    PnlAlterarSenha: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    LblUsuarioAtSenha: TLabel;
    EdtSenhaAtSenha: TLabeledEdit;
    EdtConfirmaSenhaAtSenha: TLabeledEdit;
    Button1: TButton;
    procedure edtSenhaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ImgBtnCancelarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure BtnLoginMouseEnter(Sender: TObject);
    procedure BtnLoginMouseLeave(Sender: TObject);
    procedure PnlLogInClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vSysInfo : tSysInfo;
    function Confirmacao(pMensagem1 : String; pMensagem2 : String; Answer : Boolean) : Boolean;
    Procedure AlterarSenha;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses uFuncoes, uFrmeXactWMS, UsuarioCtrl, uDmeXactWMS, UFrmConfirmacao,
  ConfiguracaoCtrl;

{$IFDEF WIN32}
  const PlatformApp : String = 'Windows 32 ';
{$ENDIF}
{$IFDEF WIN64}
  const PlatformApp : String = 'Windows 64 ';
{$ENDIF}

{$R *.dfm}

procedure TFrmLogin.Button1Click(Sender: TObject);
begin
  if (EdtSenhaAtSenha.Text='') or (EdtConfirmaSenhaAtSenha.Text='') then
     raise Exception.Create('Informe a senha e confirme a mesma.');
  if EdtSenhaAtSenha.Text <> EdtConfirmaSenhaAtSenha.Text then
     raise Exception.Create('As senhas não confere!!!');
  if Length(EdtSenhaAtSenha.Text) < 4 then Begin
     EdtSenhaAtSenha.Clear;
     EdtConfirmaSenhaAtSenha.Clear;
     EdtSenhaAtSenha.SetFocus;
     raise Exception.Create('Senha precisa de pelo menos 4 caracter.');
  End;
  if MD5Texto(EdtSenhaAtSenha.Text) = FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Senha then Begin
     EdtSenhaAtSenha.Clear;
     EdtConfirmaSenhaAtSenha.Clear;
     EdtSenhaAtSenha.SetFocus;
     raise Exception.Create('Senha precisa ser diferente da Atual.');
  End;
  FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Senha := MD5Texto(EdtSenhaAtSenha.Text);
  If Not FrmeXactWMS.ObjUsuarioCtrl.AtualizarSenha then  begin
     EdtSenhaAtSenha.SetFocus;
     raise Exception.Create('Não foi possível alterar sua senha!');
  End;
  EdtSenha.Clear;
  EdtSenha.SetFocus;
  TThread.CreateAnonymousThread(procedure
  Var xLeft, xTime : Integer;
  begin
    for xLeft := PnlAlterarSenha.Left to (FrmLogin.Width) do begin
      TThread.Synchronize(nil, procedure
      begin
        PnlAlterarSenha.Left := xLeft;
        if PnlAlterarSenha.Left >= (FrmLogin.Width) then
           PnlAlterarSenha.Visible := False;
      End);
      for xTime := 0 to 700 do
    end;
  end).Start;
end;

procedure TFrmLogin.edtCodigoExit(Sender: TObject);
Var Resultado : TJsonArray;
    vErro     : String;
begin
  if EdtCodigo.Text <> '' then Begin
     Resultado := FrmeXactWMS.ObjUsuarioCtrl.FindUsuario(EdtCodigo.Text, 0);
     if Resultado.Get(0).TryGetValue<String>('Erro', vErro) then Begin
        raise Exception.Create(vErro);
     End;
     If (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Status = 0)then Begin
       EdtCodigo.SetFocus;
       EdtCodigo.Clear;
       raise Exception.Create('Acesso não permitido! Usuário inativo');
     End;
     LblUsuario.Caption := FrmeXactWMS.ObjusuarioCtrl.ObjUsuario.Nome;
  End;
end;

procedure TFrmLogin.edtCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LblUsuario.Caption := '';
  if (key=13) and (TLabelEdEdit(Sender).Text<>'') then
     SelectNext(ActiveControl, True, True);
end;

procedure TFrmLogin.edtSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Sender=EdtSenha) and (Key = 13) and (EdtCodigo.Text<>'') and (EdtSenha.Text<>'') then Begin
//     ImgBtnOk.Grayed := False;
     sleep(500);
     PnlLogInClick(PnlLogIn);
  End;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
//  Width  := 646;
//  Height := 490;
  if DebugHook <> 0 then Begin
     EdtCodigo.Text := '1';
     EdtSenha.Text  := '2022';
  End;
  LblUsuario.Caption := '';
  FrmeXactWMS.AcessoBloqueado := True;
  LblServidor.Caption := 'Servidor: '+DmeXactWMS.BASEURL;
end;

procedure TFrmLogin.FormResize(Sender: TObject);
begin
  EdtCodigo.SetFocus;
  LblVersao.Caption   := 'Versão: '+Versao+' '+PlatformApp+' bits';
end;

procedure TFrmLogin.ImgBtnCancelarClick(Sender: TObject);
begin
 EdtCodigo.Clear;
 Close;
end;

procedure TFrmLogin.PnlLogInClick(Sender: TObject);
var oLogger: TLoggerSingleton;
    MyNotification: TNotification;
    MyNotificationCenter : TNotificationCenter;
    JsonArrayLogOn : TJsonArray;
    vErro          : String;
begin
  if (edtCodigo.Text = '') and (edtSenha.Text='') then
     raise Exception.Create('Informe as credenciais de acesso!');
  inherited;
  //if Assigned(tmpUsuario) = False then PegarUsuario;
  if PnlAlterarSenha.Visible then
     Exit;
  if ((StrToIntDef(EdtCodigo.Text, 0)<>0) and
     (StrToIntDef(EdtCodigo.Text, 0)<>FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId)) or
     ((StrToIntDef(EdtCodigo.Text, 0)=0) and
     (EdtCodigo.Text<>FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Login)) then
     edtCodigoExit(EdtCodigo);
  try
    if (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId = 0) or (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Senha <> MD5Texto(edtSenha.Text)) then Begin
       EdtCodigo.SetFocus;
       raise Exception.Create('Acesso não permitido! Não foi possível autenticar as credenciais.');
    End;
    if (FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Status = 0) then Begin
       EdtCodigo.SetFocus;
       raise Exception.Create('Acesso não permitido! Usuário inativo.');
    End;
    if FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.SenhaPadrao = 1 then Begin
       Confirmacao('Atualizar Senha.', 'Sua Senha padrão precisa ser mudada.', False);
       AlterarSenha;
       Exit;
    End
    Else If ((FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.DtUltimaAlteracaoSenha+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.DiasSenhaValida) < Date()) then Begin
       Confirmacao('Atualizar Senha.', 'Sua Senha expirou. Vamos atualizá-la.', False);
       AlterarSenha;
       Exit;
    End
    Else If ((FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.DtUltimaAlteracaoSenha+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.DiasSenhaValida) <= (Date()+5)) then Begin
       If Confirmacao('Atualizar Senha.', 'Senha expirar em '+
       (((FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.DtUltimaAlteracaoSenha+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.DiasSenhaValida)-Date)).Tostring+'dias. Vamos Atualizar?', True) then begin
          AlterarSenha;
          //Exit;
       end;
    End;
    //  tmpUsuario.ValidarAcesso(vgCodigoModulo, edtSenha.Text);
    // obtém a instância do Singleton para registrar um log
    oLogger := TLoggerSingleton.ObterInstancia;
    oLogger.RegistrarLog('***************************************');
    oLogger.RegistrarLog(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome+' iniciou a aplicação às '+Copy(TimeToStr(Time()),1,5)+'h.');
    if vSysInfo.OS.OSVersion = wvwin10 then Begin
       MyNotification       := TNotification.Create();//
       MyNotificationCenter := TNotificationCenter.Create(self);
       MyNotification       := MyNotificationCenter.CreateNotification;
       try
         MyNotification.Name  := 'eXactWMS';
         MyNotification.Title := 'eXact WMS'; //'Controle de Acesso';
         MyNotification.AlertBody   := LblUsuario.Caption+#13+'Seja Bem Vindo!!!'+#13+'http://www.rhemasys.com.br/';
         MyNotification.EnableSound := True;
         MyNotificationCenter.PresentNotification(MyNotification);
       finally
         FreeAndNil(MyNotification);
         FreeAndNil(MyNotificationCenter);
         MyNotification.DisposeOf;
         MyNotificationCenter.DisposeOf;
       end;
    End;
    JsonArrayLogOn := FrmeXactWMS.ObjUsuarioCtrl.LogOn;
    if Not JsonArrayLogOn.Items[0].TryGetValue('Erro', vErro) then  Begin
       FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.IdLogOn := JsonArrayLogOn.Items[0].getValue<Integer>('idlogon');
    End;
    JsonArrayLogOn := Nil;
    //FrmeXactWMS.ConfigWMS    := TConfiguracaoCtrl.Create;
    FrmeXactWMS.ConfigWMS.ObjConfiguracao   := FrmeXactWMS.ConfigWMS.GetConfiguracao[0];
  except on e: Exception do
    begin
      EdtSenha.Text   := '';
//      ImgBtnOk.Grayed := True;
      //FreeAndNil(tmpUsuario);
      raise Exception.Create(e.Message);
    end;
  end;
  ModalResult := mrOk;
  FrmeXactWMS.AcessoBloqueado := False;
end;

procedure TFrmLogin.AlterarSenha;
begin
  LblUsuarioAtSenha.Caption := LblUsuario.Caption;
  PnlAlterarSenha.Top  := Bevel1.Top;
  PnlAlterarSenha.Left := (PnlAlterarSenha.Width*-1);
  PnlAlterarSenha.Visible := True;
  EdtSenhaAtSenha.Clear;
  EdtConfirmaSenhaAtSenha.Clear;
  EdtSenhaAtSenha.SetFocus;
  TThread.CreateAnonymousThread(procedure
  Var xLeft, xTime : Integer;
  begin
    for xLeft := PnlAlterarSenha.Left to Bevel1.Left do begin
      TThread.Synchronize(nil, procedure
      begin
        PnlAlterarSenha.Left := xLeft;
      End);
      for xTime := 0 to 700 do
    end;
  end).Start;
end;

procedure TFrmLogin.BtnLoginMouseEnter(Sender: TObject);
begin
  BtnLogin.Pen.Color   := $00ECDECE; //Azul
  BtnLogin.Brush.Color := $004080FF; //Chocolate
  LblLogin.Font.Color  := $00ECDECE;
  LblLogin.Color       := $004080FF;
end;

procedure TFrmLogin.BtnLoginMouseLeave(Sender: TObject);
begin
  BtnLogin.Pen.Color   := $004080FF; //Azul
  BtnLogin.Brush.Color := $00ECDECE; //Chocolate
  LblLogin.Font.Color  := $004080FF;
  LblLogin.Color       := $00ECDECE;
end;

procedure TFrmLogin.Timer1Timer(Sender: TObject);
begin
  //Label1.Caption := DatetoStr(Now);
  //Label2.Caption := Copy(timetoStr(Time()),1,5)+'h';
end;

function TFrmLogin.Confirmacao(pMensagem1 : String; pMensagem2 : String; Answer : Boolean) : Boolean;
Begin
  With TFrmConfirmacao.Create(Self) do Try
    Mensag1.Caption := pMensagem1;
    Mensag2.Caption := pMensagem2;
    ImgOk.Visible   := True;
    BtnOk.Visible         := Not Answer;
    PctSim.Visible        := Answer;
    LblConfirmSim.Visible := Answer;
    PctNao.Visible        := Answer;
    LblConfirmNao.Visible := Answer;
    If ShowModal = MrOk Then Begin
       Result := True;
       End
    Else Begin
       Result := False;
       abort;
       Exit;
    End;
  Finally
    Free;
  end;
End;

end.
