unit Server.Utils.SingletonPermissoes;

interface

uses

  Server.Constants,
  System.Classes,
  Server.Attributes,
  json,
  System.SysUtils,
  Server.Connection,
  REST.json,
  Server.Token,
  math,
  JOSE.Core.JWT,
  JOSE.Core.JWA,
  JOSE.Core.Builder,
  JOSE.Core.JWK,
  JOSE.Types.Bytes,
  System.NetEncoding,
  Server.Util,
  Server.Utils.SectionVariables,
  System.DateUtils,
  Server.Records,
  System.Generics.Collections,
  Server.MessageList,
  Web.HTTPApp,
  Server.Message,

  System.Rtti,
  Server.ResourceBaseClass;

type
  TPermissao = class
  private

    FIdPerfil: integer;
    FIdFuncao: integer;

    FPerfilNome: string;
    FFuncaoNome: string;
    FCamada: integer;
    FEndPoint: string;
    FPermissao: integer;

  public

    property IdFuncao: integer read FIdFuncao write FIdFuncao;
    property idperfil: integer read FIdPerfil write FIdPerfil;
    property PerfilNome: string read FPerfilNome write FPerfilNome;
    property funcaonome: string read FFuncaoNome write FFuncaoNome;
    property Camada: integer read FCamada write FCamada;
    property EndPoint: string read FEndPoint write FEndPoint;
    property Permissao: integer read FPermissao write FPermissao;

  end;

type
  TPermissoes = TObjectList<TPermissao>;

type
  TSingletonPermissoes = class
  private
    FPermissoes: TPermissoes;
    FPublicEndpoints: TStringList;
    procedure cloneIten(source, dest: TPermissao);
    procedure SetDados(Dados: TJSONObject);

  public
    property Permissoes: TPermissoes read FPermissoes write FPermissoes;
    property PublicEndpoints: TStringList read FPublicEndpoints
      write FPublicEndpoints;
    procedure initialize();
    function GetPermissoes(idperfil, Camada: integer): TPermissoes;
    function GetPermissao(idperfil, Camada: integer; EndPoint: string)
      : TPermissao;
    procedure Refresh();
  end;

var
  FSingletonPermissoes: TSingletonPermissoes;

implementation

uses
  Resources.perfilfuncoes;
{ TSingletonPermissoes }

procedure TSingletonPermissoes.cloneIten(source, dest: TPermissao);
begin
  dest.idperfil := source.idperfil;
  dest.IdFuncao := source.IdFuncao;
  dest.Camada := source.Camada;
  dest.EndPoint := source.EndPoint;
  dest.PerfilNome := source.PerfilNome;
  dest.funcaonome := source.funcaonome;
  dest.Permissao := source.Permissao;
end;

function TSingletonPermissoes.GetPermissao(idperfil, Camada: integer;
  EndPoint: string): TPermissao;
var
  Litem: TPermissao;
  Lindex: integer;

begin
  result := TPermissao.create;
  for Lindex := 0 to FPermissoes.Count - 1 do
  begin
    if (FPermissoes[Lindex].idperfil = idperfil) and
      (FPermissoes[Lindex].Camada = Camada) and
      (UpperCase(FPermissoes[Lindex].EndPoint) = UpperCase(EndPoint)) then
    begin
      Litem := TPermissao.create;
      cloneIten(FPermissoes[Lindex], Litem);
      result := Litem;
    end;
  end;
end;

function TSingletonPermissoes.GetPermissoes(idperfil, Camada: integer)
  : TPermissoes;
var
  Litem: TPermissao;
  Lindex: integer;
begin
  result := TPermissoes.create;
  for Lindex := 0 to FPermissoes.Count - 1 do
  begin
    if (FPermissoes[Lindex].idperfil = idperfil) and
      (FPermissoes[Lindex].Camada = Camada) then
    begin
      Litem := TPermissao.create;
      cloneIten(FPermissoes[Lindex], Litem);
      result.Add(Litem);
    end;
  end;
end;

procedure TSingletonPermissoes.SetDados(Dados: TJSONObject);
var
  Item: TJSONPair;
  FieldName: String;
  Value: String;
  Litem: TPermissao;
begin
  Litem := TPermissao.create;
  for Item in Dados do
  begin
    FieldName := Item.JsonString.Value;
    Value := Item.JsonValue.Value;
    TWKUtil.SetObjectProperty(FieldName, Value, Litem)
  end;
  FPermissoes.Add(Litem);
end;

procedure TSingletonPermissoes.initialize;
var
  LResource: TPerfilFuncoes;
  I: integer;
begin
  LResource := TPerfilFuncoes.create;
  try
    LResource.Get(Nil, 1, 50, EmptyStr, EmptyStr, EmptyStr, EmptyStr,
      EmptyStr, nil);
    FPermissoes := TPermissoes.create;
    for I := 0 to LResource.JsonArrayList.Count - 1 do
    begin
      SetDados((LResource.JsonArrayList[I]) as TJSONObject);
    end;
  finally
    FreeAndNil(LResource);
  end;
  // melhorar depois

  FPublicEndpoints := TStringList.create;
  FPublicEndpoints.Clear;
  FPublicEndpoints.Add('empresasusuario');
  FPublicEndpoints.Add('enviarcodigoreset');
  FPublicEndpoints.Add('getcurrentuser');
  FPublicEndpoints.Add('tipossolicitacoes');
  FPublicEndpoints.Add('sendemail');
  FPublicEndpoints.Add('authorization');
  FPublicEndpoints.Add('perfilfuncoes');
  FPublicEndpoints.Add('usuariosempresa');
  FPublicEndpoints.Add('funcoes');
  FPublicEndpoints.Add('planos');
  FPublicEndpoints.Add('empresaplanos');
  FPublicEndpoints.Add('revendas');
  FPublicEndpoints.Add('revendaplanos');
  FPublicEndpoints.Add('configuracaohorario');
  FPublicEndpoints.Add('configuracaohorariodiasemana');
  FPublicEndpoints.Add('colaboradorhorario');
  FPublicEndpoints.Add('colaboradorafastamentoferias');
  FPublicEndpoints.Add('extra');
  FPublicEndpoints.Add('locaistrabalho');
  FPublicEndpoints.Add('colaboradordemissao');
  FPublicEndpoints.Add('meuperfil');
  FPublicEndpoints.Add('alterarsenha');
  FPublicEndpoints.Add('trocarsenha');
  FPublicEndpoints.Add('revendaplanos');
  FPublicEndpoints.Add('colaboradorlocaistrabalho');
  FPublicEndpoints.Add('colaboradordemissao');
  FPublicEndpoints.Add('colaboradorafastamentoferias');
  FPublicEndpoints.Add('colaboradorhorario');
  FPublicEndpoints.Add('colaboradorbancohoraextras');
  FSingletonPermissoes := Self;
end;

procedure TSingletonPermissoes.Refresh;
var
  LResource: TPerfilFuncoes;
  I: integer;
begin
  try
    LResource := TPerfilFuncoes.create;
    FPermissoes.Clear;
    try
      LResource.Get(Nil, 1, 50, EmptyStr, EmptyStr, EmptyStr, EmptyStr,
        EmptyStr, nil);

      for I := 0 to LResource.JsonArrayList.Count - 1 do
      begin
        SetDados((LResource.JsonArrayList[I]) as TJSONObject);
      end;
    finally
      FreeAndNil(LResource);
    end;
  except
    on e: exception do
      Writeln('[223] Erro ao atualizar permissoes ' + e.Message)

  end;
end;

{ TPermissao }

end.
