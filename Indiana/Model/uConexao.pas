unit uConexao;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  classes,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB,
  System.SysUtils,
  FireDAC.DApt,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  IniFiles,
  FireDAC.Phys.MSSQL,
  FireDAC.Comp.UI;

type
  TConexao = class
  private
    FConn: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysMSSQLDriverLink; // TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure ConfigurarConexao;
    procedure SetDate;
  public
    constructor Create;
    destructor Destroy; override;
    function GetConn: TFDConnection;
    function CriarQuery: TFDQuery;
    Class Function ServerBd: String;
  end;

implementation

uses
  exactwmsservice.lib.utils;

{ TConexao }
procedure gravalog(mensagem: string);
var
  strSaida: string;
  HWND: Cardinal;
  procedure registrarLogEmArquivo;
  var
    p: string;
    F: TextFile;
  begin
    try
      try
        p := ExtractFilePath(ParamStr(0)) + 'log/';
        ForceDirectories(p);
        p := p + FormatDateTime('yyyymmdd', now) + '_' +
          ChangeFileExt(ExtractFileName(ParamStr(0)), '') + '.log';
        AssignFile(F, p);
        if not FileExists(p) then
          Rewrite(F)
        else
          Append(F);
        Writeln(F, strSaida);
      except
      end;
    finally
      Closefile(F);
    end;
  end;

begin
  Try
    HWND := 0;

    strSaida := FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + mensagem;

    registrarLogEmArquivo;

  except
  end;
end;

procedure TConexao.ConfigurarConexao;

begin
  Writeln('abrindo conexao pelo create do TConexao');
  Tutil.SetConectionsDef();
  With FConn do
  Begin
    Params.Values['DriverID'] := 'MSSQL';
    ConnectionDefName := _CTCONEXAO;
  end;

end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);
  FDPhysPgDriverLink1 := TFDPhysMSSQLDriverLink.Create(Nil);

  FDGUIxWaitCursor1 := TFDGUIxWaitCursor.Create(Nil);
  Self.ConfigurarConexao();
end;

destructor TConexao.Destroy;
begin
  FConn.Free;
  inherited;
end;

procedure TConexao.SetDate;
begin
end;

function TConexao.CriarQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
  VQuery := TFDQuery.Create(nil);
  if (Assigned(FConn)) and (Not(FConn = Nil)) then
    VQuery.Connection := FConn
  Else
    Self.ConfigurarConexao();
  Result := VQuery;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;

Class function TConexao.ServerBd: String;
Var
  ArqIni: TIniFile;
begin
  // Exit; Ativar para conexao unica
  if FileExists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini') then
  Begin
    ArqIni := TIniFile.Create((ExtractFilePath(GetModuleName(HInstance)) +
      'eXactWMS.ini'));
    Result := 'Servidor: ' + ArqIni.ReadString('BD', 'Server', 'locahost');
    // '192.168.0.165');
    Result := Result + '  Bd: ' + ArqIni.ReadString('BD', 'DataBase',
      'eXactWMS');
  End
  else
    Writeln('Arquivo de configuracao não encontrado');
end;

end.
