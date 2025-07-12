unit uFrmAutorizarOperacao;

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

  TFrmAutorizarOperacao = class(TForm)
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
    LblAutorizarOperacao: TLabel;
    Bevel1: TBevel;
    PnlLogIn: TPanel;
    LblLogin: TLabel;
    BtnLogin: TShape;
    Bevel2: TBevel;
    PnlImgFoot: TPanel;
    Image1: TImage;
    Label2: TLabel;
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
  private
    { Private declarations }
    vSysInfo : tSysInfo;
    Autorizador_Senha : String;
    UsuarioFuncionalidade : Boolean;
    function Confirmacao(pMensagem1 : String; pMensagem2 : String; Answer : Boolean) : Boolean;
  public
    { Public declarations }
    Autorizar_Funcionalidade : String;
  end;

var
  FrmAutorizarOperacao: TFrmAutorizarOperacao;

implementation

uses uFuncoes, uFrmeXactWMS, UsuarioCtrl, uDmeXactWMS, UFrmConfirmacao;

{$IFDEF WIN32}
  const PlatformApp : String = 'Windows 32 ';
{$ENDIF}
{$IFDEF WIN64}
  const PlatformApp : String = 'Windows 64 ';
{$ENDIF}

{$R *.dfm}

procedure TFrmAutorizarOperacao.edtCodigoExit(Sender: TObject);
Var Resultado : TJsonArray;
    vErro     : String;
    ObjUsuarioAutorizador : TUsuarioCtrl;
begin
  FrmeXactWMS.Usuario_AutorizadorOperacao := 0;
  if EdtCodigo.Text <> '' then Begin
     ObjUsuarioAutorizador := TUsuarioCtrl.Create;
     Resultado := ObjUsuarioAutorizador.FindUsuario(EdtCodigo.Text, 0);
     if Resultado.Get(0).TryGetValue<String>('Erro', vErro) then Begin
        Resultado := Nil;
        ObjUsuarioAutorizador.Free;
        raise Exception.Create(vErro);
     End;
     FrmeXactWMS.Usuario_AutorizadorOperacao := Resultado.Items[0].GetValue<Integer>('usuarioid');
     Autorizador_Senha  := Resultado.Items[0].GetValue<String>('senha');
     LblUsuario.Caption := Resultado.Items[0].GetValue<String>('nome');
     UsuarioFuncionalidade := ObjUsuarioAutorizador.AcessoFuncionalidade(Autorizar_Funcionalidade);
     Resultado := Nil;
     ObjUsuarioAutorizador.Free;
  End;
end;

procedure TFrmAutorizarOperacao.edtCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LblUsuario.Caption := '';
  if (key=13) and (TLabelEdEdit(Sender).Text<>'') then
     SelectNext(ActiveControl, True, True);
end;

procedure TFrmAutorizarOperacao.edtSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Sender=EdtSenha) and (Key = 13) and (EdtCodigo.Text<>'') and (EdtSenha.Text<>'') then Begin
//     ImgBtnOk.Grayed := False;
     sleep(500);
     PnlLogInClick(PnlLogIn);
  End;
end;

procedure TFrmAutorizarOperacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAutorizarOperacao.FormCreate(Sender: TObject);
begin
  LblUsuario.Caption := '';
  LblServidor.Caption := 'Servidor: '+DmeXactWMS.BASEURL;
end;

procedure TFrmAutorizarOperacao.FormResize(Sender: TObject);
begin
  EdtCodigo.SetFocus;
  LblVersao.Caption   := 'Versão: '+Versao+' '+PlatformApp+' bits';
end;

procedure TFrmAutorizarOperacao.ImgBtnCancelarClick(Sender: TObject);
begin
  FrmeXactWMS.Usuario_AutorizadorOperacao := 0;
  EdtCodigo.Clear;
  Close;
end;

procedure TFrmAutorizarOperacao.PnlLogInClick(Sender: TObject);
begin
  FrmeXactWMS.Usuario_AutorizadorOperacao := 0;
  if (edtCodigo.Text = '') and (edtSenha.Text='') then
     raise Exception.Create('Informe as credenciais de acesso!');
  inherited;
  edtCodigoExit(EdtCodigo);
  try
    if (FrmeXactWMS.Usuario_AutorizadorOperacao = 0) or (Autorizador_Senha <> MD5Texto(edtSenha.Text)) then Begin
       EdtCodigo.SetFocus;
       raise Exception.Create('Acesso não permitido! Não foi possível autenticar as credenciais.');
    End;
    If Not UsuarioFuncionalidade then Begin
       EdtCodigo.Clear;
       edtSenha.Clear;
       EdtCodigo.SetFocus;
       raise Exception.Create('Usuário não autorizado para liberar acesso!');
    End;
  except on e: Exception do
    begin
      FrmeXactWMS.Usuario_AutorizadorOperacao := 0;
      EdtSenha.Text   := '';
//      ImgBtnOk.Grayed := True;
      //FreeAndNil(tmpUsuario);
      raise Exception.Create(e.Message);
    end;
  end;
  ModalResult := mrOk;
end;

procedure TFrmAutorizarOperacao.BtnLoginMouseEnter(Sender: TObject);
begin
  BtnLogin.Pen.Color   := $00ECDECE; //Azul
  BtnLogin.Brush.Color := $004080FF; //Chocolate
  LblLogin.Font.Color  := $00ECDECE;
  LblLogin.Color       := $004080FF;
end;

procedure TFrmAutorizarOperacao.BtnLoginMouseLeave(Sender: TObject);
begin
  BtnLogin.Pen.Color   := $004080FF; //Azul
  BtnLogin.Brush.Color := $00ECDECE; //Chocolate
  LblLogin.Font.Color  := $004080FF;
  LblLogin.Color       := $00ECDECE;
end;

procedure TFrmAutorizarOperacao.Timer1Timer(Sender: TObject);
begin
  //Label1.Caption := DatetoStr(Now);
  //Label2.Caption := Copy(timetoStr(Time()),1,5)+'h';
end;

function TFrmAutorizarOperacao.Confirmacao(pMensagem1 : String; pMensagem2 : String; Answer : Boolean) : Boolean;
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
