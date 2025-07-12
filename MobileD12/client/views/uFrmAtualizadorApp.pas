unit uFrmAtualizadorApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Gestures, FMX.ActnList, System.Actions, FMX.TabControl,
  ksTypes, ksLoadingIndicator, FMX.Edit, FMX.Layouts, FMX.Grid, FMX.ListView,
  FMX.Controls.Presentation, FMX.Objects,
  IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient,
  {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.Jni.Telephony, //Sms
  FMX.Helpers.Android,
  FMX.Platform.Android,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os, //Receber Intent
  Androidapi.IOUtils,
  {$Endif}
  IdHTTP, FMX.Grid.Style, FMX.ScrollBox, FMX.Media, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani, FMX.ListBox;

type
  TFrmAtualizadorApp = class(TFrmBase)
    BtnDownload: TButton;
    BtnAtualizar: TButton;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    IdHTTP1: TIdHTTP;
    procedure FormCreate(Sender: TObject);
    procedure BtnDownloadClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAtualizadorApp: TFrmAtualizadorApp;

implementation

{$R *.fmx}

procedure TFrmAtualizadorApp.BtnAtualizarClick(Sender: TObject);
{$IFDEF ANDROID}
var aFile  : Jfile;
    Intent : JIntent;
{$Endif}
begin
  inherited;
  {$IFDEF ANDROID}
  aFile  := TJfile.JavaClass.Init(stringtojstring(GetSharedDownloadsDir), StringToJString('ClientWMS.apk'));
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.addFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
  Intent.setDataAndType(TJnet_Uri.JavaClass.fromFile(aFile),StringToJString('application/vnd.android.package-archive'));

  SharedActivityContext.startActivity(Intent);
  {$Endif}
end;

procedure TFrmAtualizadorApp.BtnDownloadClick(Sender: TObject);
var
  Caminho_D : String;
  MyFile    : TFileStream;
begin
  inherited;
  {$IFDEF ANDROID}
     {Verifica se o arquivo já existe na pasta de downloads. Apaga caso exista e cria novamente}
     if FileExists(GetSharedDownloadsDir + '/ClientWMS.apk') then
       DeleteFile(GetSharedDownloadsDir+'/ClientWMS.apk');

     {Difinição do link de download}
     {Nesse momento, você deverá informar o link completo para o download do arquivo}
     Caminho_D:= 'http://www.grupox3.com.br/ClientWMS.apk';

     {Criação a instância do tipo TFileStream}
     {Aqui informamos o local (diretório no mobile) onde o aplicativo será baixado}
     MyFile := TFileStream.Create(GetSharedDownloadsDir + '/ClientWMS.apk', fmCreate);
     try
       {Download do arquivo}
       IdHTTP1.Get(Caminho_D, MyFile);
     finally
       MyFile.Free;
     end;
  {$Endif}
end;

procedure TFrmAtualizadorApp.FormCreate(Sender: TObject);
begin
  inherited;
  Codigo.Visible    := False;
  EdtCodigo.Visible := False;
  Label1.Text       := '...';
end;

procedure TFrmAtualizadorApp.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  inherited;
  ProgressBar1.value := AWorkCount;
  Application.ProcessMessages;
end;

procedure TFrmAtualizadorApp.IdHTTP1WorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  inherited;
   ProgressBar1.value := 0;
   ProgressBar1.Max := AWorkCountMax;
   Label1.Text := 'Download em andamente, Aguarde!';
end;

procedure TFrmAtualizadorApp.IdHTTP1WorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  inherited;
   ProgressBar1.Value := ProgressBar1.Max;
   Label1.text := 'Download Concluído!';
end;

end.
