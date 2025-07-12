unit main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  imp.Config,
  Data.DB,
  json,
  postManCollection,
  imp.Connection,
  service.resource.generator,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Menus,
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
  Vcl.ComCtrls;

type
  TFmain = class(TForm)
    Panel1: TPanel;
    imgMain: TImage;
    btMenu: TSpeedButton;
    pgctrlMain: TPageControl;
    tabHome: TTabSheet;
    tabConfig: TTabSheet;
    Label1: TLabel;
    opDlg: TOpenDialog;
    popMain: TPopupMenu;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    memoAlias: TMemo;
    Label3: TLabel;
    edtDiretorio: TEdit;
    Label2: TLabel;
    btDiretorio: TButton;
    Panel2: TPanel;
    memoTabelas: TMemo;
    btLoadTabelas: TSpeedButton;
    Panel3: TPanel;
    edtAddTabela: TEdit;
    btAddTabela: TSpeedButton;
    pnProcesso: TPanel;
    Image1: TImage;
    Panel4: TPanel;
    memoLog: TMemo;
    imgTopProcess: TImage;
    Panel5: TPanel;
    btGerar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btDiretorioClick(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabHomeEnter(Sender: TObject);
    procedure btLoadTabelasClick(Sender: TObject);
    procedure btAddTabelaClick(Sender: TObject);
  private
    FConnection: TConnection;
    sFileName: string;
    Procedure setTabelas();
    procedure saveAliasTabelas();
    procedure loadAliasTabelas();

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmain: TFmain;

const

  _ctAliases = 'aliases.txt';

implementation

{$R *.dfm}

procedure TFmain.addLog(value: string);
begin
  memoLog.Lines.Add(value);
end;
{ ------------------------------------------------------------------------------ }

procedure TFmain.btAddTabelaClick(Sender: TObject);
begin
  if edtAddTabela.Text <> '' then
    memoTabelas.Lines.Add(edtAddTabela.Text);
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.btDiretorioClick(Sender: TObject);
begin
  if opDlg.Execute(self.Handle) then
  begin
    edtDiretorio.Text := ExtractFilePath(opDlg.FileName);
  end;
end;



{ ------------------------------------------------------------------------------ }
procedure TFmain.btGerarClick(Sender: TObject);
var
  nfiles:integer;
begin
  pnProcesso.Visible := true;
  memoLog.Lines.Clear;
  with TResourceGenerator.create do
  begin
    Connection := FConnection;
    aliases:=memoAlias.Text;
    Execute;
    nfiles:=arquivosGerados;
    Free;
  end;

  MessageBox(self.Handle, pchar('sucesso ' + inttostr(nfiles) +
    ' Arquivos criados '), pchar('Aviso'), 32);
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.btLoadTabelasClick(Sender: TObject);
begin
  setTabelas();
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveAliasTabelas();
  FreeAndNil(FConnection);
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.FormCreate(Sender: TObject);
begin
  TServerConfig.GetInstance();
  FConnection := TConnection.create;

  edtDiretorio.Text := ExtractFilePath(GetModuleName(HInstance)) + '\Output';
  ForceDirectories(edtDiretorio.Text);

  pgctrlMain.ActivePageIndex := 0;
  loadAliasTabelas();
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.loadAliasTabelas;
begin
  if FileExists(ExtractFilePath(GetModuleName(HInstance)) + _ctAliases) then
    memoAlias.Lines.LoadFromFile(ExtractFilePath(GetModuleName(HInstance)) +
      _ctAliases);

end;


{ ------------------------------------------------------------------------------ }
procedure TFmain.Sair1Click(Sender: TObject);
begin

  self.Close;
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.saveAliasTabelas;
begin
  memoAlias.Lines.SaveToFile(ExtractFilePath(GetModuleName(HInstance)) +
    _ctAliases);
end;


{ ------------------------------------------------------------------------------ }
procedure TFmain.setTabelas;
begin
  FConnection.DB.GetTableNames('', '', '', memoTabelas.Lines, [osMy],
    [tkTable]);;
end;

{ ------------------------------------------------------------------------------ }
procedure TFmain.tabHomeEnter(Sender: TObject);
begin
  saveAliasTabelas();
end;



{ ------------------------------------------------------------------------------ }
end.
