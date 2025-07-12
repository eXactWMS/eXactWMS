unit MService.TopicoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  TopicosClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type

  TTopicoDao = class(TBasicDao)
  private
    
    

    FTopico: TTopicos;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pJsonObject : TjsonObject) : Boolean;
    function GetId(pTopico: String): TjSonArray;
    Function Delete: Boolean;
    Property ObjTopico: TTopicos Read FTopico Write FTopico;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TTopicoDao.Create;
begin
  ObjTopico := TTopicos.Create;
  inherited;
end;

function TTopicoDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Topicos where TopicoId = ' +
      Self.ObjTopico.TopicoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Topicoss - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TTopicoDao.Destroy;
begin
  
  ObjTopico.Free;
  inherited;
end;

function TTopicoDao.GetId(pTopico: String): TjSonArray;
var
  ObjJson: TJsonObject;
  TopicoItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlTopicos);
    if (pTopico = '0') or (StrToInt64Def(pTopico, 0) > 0) then
      FConexao.Query.ParamByName('pTopicoId').Value := pTopico
    Else
      FConexao.Query.ParamByName('pTopicoId').Value := 0;
    if (StrToInt64Def(pTopico, 0) > 0) or (pTopico = '0') then
      FConexao.Query.ParamByName('pDescricao').Value := ''
    Else
      FConexao.Query.ParamByName('pDescricao').Value := '%' + pTopico + '%';
    FConexao.Query.Open;
    while Not FConexao.Query.Eof do
      With ObjTopico do
      Begin
        ObjJson := TJsonObject.Create;
        With ObjJson do
        Begin
          AddPair('topicoid', TJsonNumber.Create(FConexao.Query.FieldByName('TopicoId')
            .AsInteger));
          AddPair('descricao', FConexao.Query.FieldByName('Descricao').AsString);
          AddPair('status', TJsonNumber.Create(FConexao.Query.FieldByName('Status')
            .AsInteger));
          AddPair('data', DateToStr(FConexao.Query.FieldByName('Data').AsDateTime));
          AddPair('hora',
            TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('Hora').AsString,
            1, 8))));

          Result.AddElement(ObjJson);
          // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
        End;
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Topicos - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TTopicoDao.Salvar(pJsonObject : TjsonObject) : Boolean;
var vSql: String;
begin
  try
    if pJsonObject.GetValue<Integer>('topicoId') = 0 then
       vSql := 'Insert Into Topicos (Descricao, Status, Data, Hora) Values (' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +
        pJsonObject.GetValue<String>('status') + ', ' + TuEvolutConst.SqlDataAtual +
        ', ' + TuEvolutConst.SqlHoraAtual + ')'
    Else
      vSql := ' Update Topicos ' + '   Set Descricao = ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) + '      , Status   = ' +
        pJsonObject.GetValue<String>('status') + ' where TopicoId = ' +
        pJsonObject.GetValue<Integer>('topicoId').ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

Function TTopicoDao.TrataErroFireDac(pErro: EFDDBEngineException): String;
begin
  case pErro.Kind of
    ekOther:
      Result := pErro.Message; // 'Operação com o Banco de Dados';
    ekNoDataFound:
      Result := 'Erro! Dados não encontrados';
    ekTooManyRows:
      Result := 'Excesso de Linhas';
    ekRecordLocked:
      Result := 'Registro com acesso bloqueado. Pode está sendo usado por outro processo.';
    ekUKViolated:
      Result := 'Tentativa de incluir registro já existente.';
    ekFKViolated:
      Result := 'Cadastro primário necessário inexistente.';
    ekObjNotExists:
      Result := 'Objeto não encontrado';
    ekUserPwdInvalid:
      Result := 'Usuário e/ou Senha inválido.';
    ekUserPwdExpired:
      Result := 'Usuário e/ou Senha expirou!';
    ekUserPwdWillExpire:
      Result := 'Usuário e/ou Senha prestes a expirar';
    ekCmdAborted:
      Result := 'Operação cancelada.';
    ekServerGone:
      Result := 'Servidor de Banco de Dados inexistente.';
    ekServerOutput:
      Result := 'Servidor de Banco de Dados parece está fora do ar.';
    ekArrExecMalfunc:
      Result := 'Operação mal sucedida.';
    ekInvalidParams:
      Result := 'Parâmetros inválidos para esta operação.';
  end;
  Result := 'Tabela: EnderecamentoRuas - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

end.
