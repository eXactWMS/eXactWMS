unit testervcl.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, tester.service.http, Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage;

type
  TFmainVcl = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    bt_executar: TButton;
    ProgressBar1: TProgressBar;
    chethreads: TCheckBox;
    GroupBox1: TGroupBox;
    memoUrls: TMemo;
    GroupBox2: TGroupBox;
    MemoResults: TMemo;
    Label1: TLabel;
    Image1: TImage;
    LblErro: TLabel;
    Shape1: TShape;
    lblSucesso: TLabel;
    Shape2: TShape;
    Image2: TImage;
    procedure bt_executarClick(Sender: TObject);
  private
    { Private declarations }
    FExecPath: TExecPath;
    FtheadsCount: Integer;
    Ferros: Integer;
    Fsucesso: Integer;
    procedure DoConsulta(Url: string);
    procedure ProcessConsulta(Sender: TObject);
    procedure onfinalizethd(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FmainVcl: TFmainVcl;

implementation

{$R *.dfm}

procedure TFmainVcl.bt_executarClick(Sender: TObject);
var

  myThread: TThread;

begin
  bt_executar.Enabled := false;
  Ferros := 0;
  Fsucesso := 0;
  (Image2.Picture.Graphic as TGIFImage).Animate := True;
  // (Image2.Picture.Graphic as TGIFImage).AnimationSpeed := 500;
  self.DoubleBuffered := True;
  FtheadsCount := 0;
  myThread := TThread.CreateAnonymousThread(
    procedure
    begin
      var
        i: Integer;

      MemoResults.Lines.Clear;
      for i := 0 to memoUrls.Lines.Count - 1 do
      begin
        Application.ProcessMessages;
        try

          caption := memoUrls.Lines[i];
          DoConsulta(memoUrls.Lines[i]);

        except
          on e: exception do
          begin
            Application.ProcessMessages;
            caption := e.Message;
          end;

        end;
      end;

    end);

  myThread.Start();
end;

procedure TFmainVcl.DoConsulta(Url: string);
begin
  try
    Application.ProcessMessages;
    FExecPath := TExecPath.Create(True);
    FExecPath.Lurl := Url;
    FExecPath.FreeOnTerminate := True;
    FExecPath.OnTerminate := ProcessConsulta;
    if chethreads.Checked then
      FExecPath.Resume
    else
    begin
      FExecPath.Execute;
      sleep(200);

      Application.ProcessMessages;
      ProcessConsulta(FExecPath);

    end;
  except
    on e: exception do
      ShowMessage(e.Message);
  end;
end;

procedure TFmainVcl.onfinalizethd(Sender: TObject);
begin

end;

procedure TFmainVcl.ProcessConsulta(Sender: TObject);
begin
  try
    try
      if FtheadsCount >= pred(memoUrls.Lines.Count) then
      begin
        Application.ProcessMessages;
        bt_executar.Enabled := True;
        (Image2.Picture.Graphic as TGIFImage).Animate := false;

      end;
      Application.ProcessMessages;
      if (Sender as TExecPath).returnCod <> 200 then
      begin
        inc(Ferros);
        LblErro.caption := 'Erros: ' + inttostr(Ferros);
        MemoResults.Lines.Add('ERRO  ' + (Sender as TExecPath).Lurl + ' - ' +
          copy((Sender as TExecPath).Retorno, 0, 200));
      end
      else
      begin
        inc(Fsucesso);
        lblSucesso.caption := 'Sucessos: ' + inttostr(Fsucesso);
        MemoResults.Lines.Add('SUCESSO  ' + (Sender as TExecPath).Lurl);
        MemoResults.Lines.Add('  ->  ' + (Sender as TExecPath).Retorno);

      end;
      MemoResults.Lines.Add('') ;
      MemoResults.Lines.Add('--------------------------------------------------') ;
      Application.ProcessMessages;
    except
      on e: exception do
        ShowMessage(e.Message);
    end;
  finally
    inc(FtheadsCount);
  end;

end;

end.
