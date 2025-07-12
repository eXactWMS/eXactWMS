unit uDmuEvolut;

interface

uses
  Dialogs, System.SysUtils, System.Classes, uDmBase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, IniFiles,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, ACBrBase, ACBrSocket,
  ACBrConsultaCNPJ, FireDAC.Comp.Script, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, VCL.Forms, WinApi.Windows, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSon, ConfiguracaoClass,
  JvMemoryDataset;

type
  TDmuEvolut = class(TDmBase)
    JvMemoryData1: TJvMemoryData;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure GetConfig;
  public
    { Public declarations }
    BASEURL : String;
  end;

var
  DmuEvolut: TDmuEvolut;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses uFuncoes, uFrmuEvolut;

procedure TDmuEvolut.DataModuleCreate(Sender: TObject);
var vlData: TSystemTime;

begin
  inherited;
  GetConfig;



{
   If ConectarFD Then Begin
      Application.MessageBox('Erro de conexão com Banco de Dados.', 'Erro', MB_ICONERROR + MB_OK);
      Application.Terminate;
   End;
   qryData.Close;
   qryData.Open;
   DateTimeToSystemTime(qryData.FieldByName('Data').AsDateTime, vlData);
   SetLocalTime(vlData);
   QryData.Close;
}
end;

procedure TDmuEvolut.GetConfig;
Var ArqIni : TIniFile;
    vIpMain,   vIpReport,   vIpSeach    : AnsiString;
    vPortMain, vPortReport, vPortSearch : String;
begin
  inherited;
  if Not fileexists(ExtractFilePath( Application.ExeName )+'eXactWMS.ini') then Begin
     ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');
//Banco de Dados
     vIpMain := '127.0.0.1';
     repeat
       vIpMain := InputBox('Servidor de Serviços eXactWMS', 'Informe o Ip do Server Principal.', '');
     until vIpMain <> '';
     vPortMain := '8200';
     repeat
       vPortMain := InputBox('Porta do Servidor eXactWMS', 'Informe a Porta do Server Principal.', '');
     until StrToIntDef(vPortMain, 0) <> 0;
     ArqIni.WriteString('msService','IpMain', CriptografarSimples(vIpMain+':'+vPortMain));

     vIpReport := '127.0.0.1';
     repeat
       vIpReport := InputBox('Servidor de Serviços eXactWMS', 'Informe o Ip do Serviço de Relatórios', '');
     until vIpReport <> '';
     vPortReport := '8300';
     repeat
       vPortReport := InputBox('Porta do Servidor eXactWMS', 'Informe a Porta do Server de Relatórios.', '');
     until StrToIntDef(vPortReport, 0) <> 0;
     ArqIni.WriteString('msService','IpReport',CriptografarSimples(vIpReport+':'+vPortReport));

     vIpSeach := '127.0.0.1';
     repeat
       vIpSeach := InputBox('Servidor de Serviços eXactWMSt', 'Informe o Ip do Server de Consultas', '');
     until vIpSeach <> '';
     vPortSearch := '8400';
     repeat
       vPortSearch := InputBox('Porta do Servidor eXactWMS', 'Informe a Porta do Server de Consultas.', '');
     until StrToIntDef(vPortSearch, 0) <> 0;
     ArqIni.WriteString('msService','IpSearch',CriptografarSimples(vIpSeach+':'+vPortSearch)); //yeratad806092'));
   //Chave de Proteção
     ArqIni.Destroy;
  End;
  Try
    ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');
    RESTClientWMS.BaseURL := 'http://'+CriptografarSimples(ArqIni.ReadString('msService', 'IpMain','127.0.0.1:8200'));
    BASEURL := RESTClientWMS.BaseURL;
  Except
    Application.MessageBox('Inconsistência no arquivo de parâmetros de inicialização...', 'Erro', MB_ICONERROR + MB_OK);
    FreeAndNil(ArqIni);
    Application.Terminate;
  End;
  FreeAndNil(ArqIni);
end;

end.
