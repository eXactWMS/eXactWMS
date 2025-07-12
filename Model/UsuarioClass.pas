{
  UsuarioClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 22/04/2021
  Projeto: eXactWMS
}
unit UsuarioClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Rest.Json, System.Json, Rest.Types, PerfilClass;

Type

  TUsuario = Class
  private
    FUsuarioId: Integer;
    FLogin: String;
    FNome: String;
    FSenha: String;
    FSenhaPadrao: Integer;
    FDiasSenhaValida: Integer;
    FEmail: String;
    FPerfil: TPerfil;
    FDtUltimaAlteracaoSenha: TDate;
    FHrUltimaAlteracaoSenha: TTime;
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FDtAlteracao: TDate;
    FHrAlteracao: TTime;
    FStatus: Integer;
    FIdLogOn: Integer;
    FTerminal: String;
    FDataInicio: TDate;
    FHoraInicio: TTime;

    procedure SetUsuarioId(const Value: Integer);
    Procedure SetLogin(Const Value: String);
    procedure SetNome(const Value: String);
    Procedure SetSenha(Const Value: String);
    Procedure SetSenhaPadrao(Const Value: Integer);
    Procedure SetDiasSenhaValida(Const Value: Integer);
    Procedure SetEmail(Const Value: String);
    procedure SetStatus(const Value: Integer);
  Public
    constructor Create;
    destructor Destroy; override;
    Class Function ClassToJson(Const ObjUsuario: TUsuario): String;
    Class Function JsonToClass(Json: String): TUsuario;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Procedure Limpar;
    Property UsuarioId: Integer read FUsuarioId write SetUsuarioId;
    Property Login: String read FLogin write SetLogin;
    Property Nome: String Read FNome Write FNome;
    Property Senha: String Read FSenha Write FSenha;
    Property SenhaPadrao: Integer Read FSenhaPadrao Write FSenhaPadrao;
    Property DiasSenhaValida: Integer Read FDiasSenhaValida
      Write FDiasSenhaValida;
    Property Email: String Read FEmail Write FEmail;
    Property Perfil: TPerfil Read FPerfil Write FPerfil;
    Property DtUltimaAlteracaoSenha: TDate Read FDtUltimaAlteracaoSenha
      Write FDtUltimaAlteracaoSenha;
    Property HrUltimaAlteracaoSenha: TTime Read FHrUltimaAlteracaoSenha
      Write FHrUltimaAlteracaoSenha;
    Property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    Property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property Status: Integer read FStatus Write SetStatus;
    Property IdLogOn: Integer Read FIdLogOn Write FIdLogOn;
    Property Terminal: String Read FTerminal Write FTerminal;
    Property DataInicio: TDate Read FDataInicio Write FDataInicio;
    Property HoraInicio: TTime Read FHoraInicio Write FHoraInicio;
  End;

implementation

{ TUsuario }

class function TUsuario.ClassToJson(Const ObjUsuario: TUsuario): String;
begin
  Result := tJson.ObjectToJsonString(ObjUsuario);
end;

class procedure TUsuario.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TUsuario.Create;
begin
  FPerfil := TPerfil.Create();
  Limpar;
end;

destructor TUsuario.Destroy;
begin
  FreeAndNil(FPerfil);
  inherited;
end;

class function TUsuario.JsonToClass(Json: String): TUsuario;
begin
  Result := tJson.JsonToObject<TUsuario>(Json, [joDateFormatUnix])
end;

procedure TUsuario.Limpar;
begin
  UsuarioId := 0;
  FLogin := '';
  FNome := '';
  FSenha := '';
  FSenhaPadrao := 0;
  FDiasSenhaValida := 0;
  FEmail := '';
  FDtUltimaAlteracaoSenha := 0;
  FHrUltimaAlteracaoSenha := 0;
  FDtInclusao := 0;
  FHrInclusao := 0;
  FStatus := 0;
  FPerfil.Limpar;
  FIdLogOn := 0;
  FTerminal := '';
  FDataInicio := 0;
  FHoraInicio := 0;
end;

procedure TUsuario.SetDiasSenhaValida(const Value: Integer);
begin
  FDiasSenhaValida := Value;
end;

procedure TUsuario.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TUsuario.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TUsuario.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TUsuario.SetSenhaPadrao(const Value: Integer);
begin
  FSenhaPadrao := Value;
end;

procedure TUsuario.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

procedure TUsuario.SetUsuarioId(const Value: Integer);
begin
  FUsuarioId := Value;
end;

end.
