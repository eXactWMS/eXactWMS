unit uDmeXactWMS;

interface

uses
  System.SysUtils, System.Classes, uDmBase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, IniFiles,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSon, ConfiguracaoClass,
  FireDAC.Phys.MSSQLDef, FireDAC.Comp.UI,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, ufuncoes, FireDAC.ConsoleUI.Wait;

type
  TDmeXactWMS = class(TDmBase)

    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure GetConfig;
    procedure CopyArqIni;
  public
    { Public declarations }
    BASEURL, BASEURLREPORT: String;
    HOST_RABBIT: string;
    USER_RABBIT: string;
    PASSWORD_RABBIT: string;
  end;

var
  DmeXactWMS: TDmeXactWMS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDmeXactWMS.DataModuleCreate(Sender: TObject);
begin
  inherited;
  GetConfig;
end;

procedure TDmeXactWMS.GetConfig;
Var
  ArqIni: TIniFile;
  vIpMain, vIpReport, vIpSeach: AnsiString;
  vPortMain, vPortReport, vPortSearch: String;
  EtqCodBarra_Modelo, EtqCodBarra_Porta, TimeEtq, Temperatura: String;
begin
  inherited;

  If GetEnvironmentVariable('SERVIDOR_API') <> '' then
  begin
    Writeln('caregando variaveis de ambiente ' + GetEnvironmentVariable
      ('SERVIDOR_API'));
    RESTClientWMS.BASEURL := GetEnvironmentVariable('SERVIDOR_API');
    ClientReport.BASEURL := GetEnvironmentVariable('SERVIDOR_API');
    ClientGraphics.BASEURL := GetEnvironmentVariable('SERVIDOR_API');
    HOST_RABBIT := GetEnvironmentVariable('HOST_RABBIT');
    USER_RABBIT := GetEnvironmentVariable('USER_RABBIT');
    PASSWORD_RABBIT := GetEnvironmentVariable('PASSWORD_RABBIT');
    Writeln('leitura das variaveis de ambiente finalizada');

  end
  else
  begin
    Writeln('caregando arquivo ini');
    ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) +
      'eXactWMS.Ini');
    ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) +
      'eXactWMS.Ini');
    if ArqIni.ReadString('msService', 'cripto', '0') = '1' then
    Begin
      RESTClientWMS.BASEURL := 'http://' + CriptografarSimples
        (ArqIni.ReadString('msService', 'IpMain', 'exactwms.ddns.net:32100'));
      ClientReport.BASEURL := 'http://' + CriptografarSimples
        (ArqIni.ReadString('msService', 'IpReport', '127.0.0.1:8200'));
      ClientGraphics.BASEURL := 'http://' + CriptografarSimples
        (ArqIni.ReadString('msService', 'IpMain', '127.0.0.1:8200'));
    End
    Else
    Begin
      RESTClientWMS.BASEURL := 'http://' + ArqIni.ReadString('msService',
        'IpMain', 'exactwms.ddns.net:32100');
      ClientReport.BASEURL := 'http://' + ArqIni.ReadString('msService',
        'IpReport', 'exactwms.ddns.net:32100');
      ClientGraphics.BASEURL := 'http://' + ArqIni.ReadString('msService',
        'IpMain', 'exactwms.ddns.net:32100');

      HOST_RABBIT := ArqIni.ReadString('msService', 'hostRabbit', ' 192.168.1.143');
      USER_RABBIT := ArqIni.ReadString('msService', 'userRabbit', 'guest');
      PASSWORD_RABBIT := ArqIni.ReadString('msService',
        'passWordRabbit', 'guest');
    End;
    BASEURL := RESTClientWMS.BASEURL;
    BASEURLREPORT := ClientReport.BASEURL;
    FreeAndNil(ArqIni);
  end;

end;

{ This one uses LZCopy, which USES LZExpand. }

procedure TDmeXactWMS.CopyArqIni;
Var
  S, T: TFileStream;
  Str: TStrings;
  PathAtualizar: String;
begin
  exit;
  Str := TStringList.Create();
  Str.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'configatualizador.dat');
  PathAtualizar := StringReplace(Str[0], 'exe', 'ini', []);
  Str.Free;

  // if Not fileexists('\\192.168.1.5\atualiza\eXactWMS\eXactWMS.ini') then Exit;
  if (UpperCase(PathAtualizar) = UpperCase(ExtractFilePath(ParamStr(0)) +
    'eXactWMS.ini')) or (Not fileexists(PathAtualizar)) then
    exit;
  try
    Try
      S := TFileStream.Create(PathAtualizar, fmOpenRead);
      // '\\192.168.1.5\atualiza\eXactWMS\eXactWMS.ini'
      T := TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'eXactWMS.ini',
        fmOpenWrite or fmCreate);
      // Atualizar Impressora no arquivo INI
      try
        T.CopyFrom(S, S.Size);
      finally
        T.Free;
      end;
    Except

    End;
  finally
    If Assigned(S) Then
      S.Free;
  end;
end;

end.
