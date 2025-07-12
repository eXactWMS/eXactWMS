unit MService.EnderecoTipoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  PessoaClass, exactwmsservice.lib.connection,exactwmsservice.dao.base,
  exactwmsservice.lib.utils;
type

  TEnderecoTipoDao = class(TBasicDao)
  private
    FEnderecoTipo: TEnderecoTipo;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    function GetId(pEnderecoTipoId: Integer): TjSonArray;
    function GetDescricao(pDescricao: String): TjSonArray;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Property ObjEnderecoTipo: TEnderecoTipo Read FEnderecoTipo
      Write FEnderecoTipo;
  end;

implementation

uses Constants; //uSistemaControl,

{ TClienteDao }

constructor TEnderecoTipoDao.Create;
begin
  ObjEnderecoTipo := TEnderecoTipo.Create;
  inherited;
end;

function TEnderecoTipoDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from EnderecoTipo where EnderecoTipoId = ' + Self.ObjEnderecoTipo.EnderecoTipoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except
      On E: Exception do
      Begin
        raise Exception.Create('Tabela: EnderecoTipo - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TEnderecoTipoDao.Destroy;
begin
  ObjEnderecoTipo.free;
  inherited;
end;

function TEnderecoTipoDao.Estrutura: TjSonArray;
Var vRegEstrutura: TJsonObject;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := TjSonArray.Create;
      Query.Open('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'+sLineBreak+
                 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
                 'Where TABLE_NAME = ' + QuotedStr('EnderecoTipo') + ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
      if Query.IsEmpty Then
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'))
      Else
      Begin
        While Not Query.Eof do Begin
          vRegEstrutura := TJsonObject.Create;
          vRegEstrutura.AddPair('coluna', LowerCase(Query.FieldByName('Nome').AsString));
          vRegEstrutura.AddPair('tipo', LowerCase(Query.FieldByName('Tipo').AsString));
          vRegEstrutura.AddPair('tamanho', TJsonNumber.Create(Query.FieldByName('Tamanho').AsInteger));
          Result.AddElement(vRegEstrutura);
          Query.Next;
        End;
      End;
    Except On E: Exception Do
      Raise Exception.Create('Processo: GetEstrutura - '+TUtil.TratarExcessao(E.Message));
    End;
  Finally
    Query.Free;
  End;
end;

function TEnderecoTipoDao.GetDescricao(pDescricao: String): TjSonArray;
var ObjJson: TJsonObject;
    EnderecoTipoItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEnderecoTipo);
      Query.ParamByName('pEnderecoTipoId').Value := 0;
      Query.ParamByName('pDescricao').Value := pDescricao;
      Query.Open;
      while Not Query.Eof do
        With ObjEnderecoTipo do
        Begin
          ObjJson := TJsonObject.Create;
          With ObjJson do Begin
            AddPair('enderecotipoid', TJsonNumber.Create(Query.FieldByName('EnderecoTipoId').AsInteger));
            AddPair('descricao', Query.FieldByName('Descricao').AsString);
            AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
            Result.AddElement(ObjJson);
            // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
          End;
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: EnderecoTipo - ' +TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoTipoDao.GetId(pEnderecoTipoId: Integer): TjSonArray;
var ObjJson: TJsonObject;
    EnderecoTipoItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlGetEnderecoTipo);
      Query.ParamByName('pEnderecoTipoId').Value := pEnderecoTipoId;
      Query.ParamByName('pDescricao').Value := '';
      Query.Open;
      while Not Query.Eof do
        With ObjEnderecoTipo do Begin
          ObjJson := TJsonObject.Create;
          With ObjJson do
          Begin
            AddPair('enderecotipoid', TJsonNumber.Create(Query.FieldByName('EnderecoTipoId').AsInteger));
            AddPair('descricao', Query.FieldByName('Descricao').AsString);
            AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
            Result.AddElement(ObjJson);
            // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
          End;
          Query.Next;
        End;
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Tabela: EnderecoTipo - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TEnderecoTipoDao.Salvar: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if Self.ObjEnderecoTipo.EnderecoTipoId = 0 then
        vSql := 'Insert Into EnderecoTipo (Descricao, Status) Values (' +
          QuotedStr(Self.ObjEnderecoTipo.Descricao) + ', ' +
          Self.ObjEnderecoTipo.Status.ToString() + ')'
      Else
        vSql := ' Update EnderecoTipo ' + '   Set Descricao = ' +
          QuotedStr(Self.ObjEnderecoTipo.Descricao) + '      , Status   = ' +
          Self.ObjEnderecoTipo.Status.ToString() + ' where EnderecoTipoId = ' +
          Self.ObjEnderecoTipo.EnderecoTipoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: EnderecoTipoSalvar'+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
