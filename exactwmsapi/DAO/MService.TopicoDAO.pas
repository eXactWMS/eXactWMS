unit MService.TopicoDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  TopicosClass, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type

  TTopicoDao = class(TBasicDao)
  private
    FTopico: TTopicos;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pJsonObject : TjsonObject) : Boolean;
    function GetId(pTopico: String): TjSonArray;
    Function Delete: Boolean;
    Property ObjTopico: TTopicos Read FTopico Write FTopico;
  end;

implementation

uses Constants; //uSistemaControl,

{ TClienteDao }

constructor TTopicoDao.Create;
begin
  ObjTopico := TTopicos.Create;
  inherited;
end;

function TTopicoDao.Delete: Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      vSql := 'Delete from Topicos where TopicoId = ' + Self.ObjTopico.TopicoId.ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: Topicos/delete - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

destructor TTopicoDao.Destroy;
begin
  ObjTopico.Free;
  inherited;
end;

function TTopicoDao.GetId(pTopico: String): TjSonArray;
var ObjJson: TJsonObject;
    TopicoItensDAO: TjSonArray;
    Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      Query.Sql.Add(TuEvolutConst.SqlTopicos);
      if (pTopico = '0') or (StrToInt64Def(pTopico, 0) > 0) then
         Query.ParamByName('pTopicoId').Value := pTopico
      Else
         Query.ParamByName('pTopicoId').Value := 0;
      if (StrToInt64Def(pTopico, 0) > 0) or (pTopico = '0') then
         Query.ParamByName('pDescricao').Value := ''
      Else
         Query.ParamByName('pDescricao').Value := '%' + pTopico + '%';
      Query.Open;
      while Not Query.Eof do
        With ObjTopico do Begin
          ObjJson := TJsonObject.Create;
          With ObjJson do
          Begin
            AddPair('topicoid', TJsonNumber.Create(Query.FieldByName('TopicoId').AsInteger));
            AddPair('descricao', Query.FieldByName('Descricao').AsString);
            AddPair('status', TJsonNumber.Create(Query.FieldByName('Status').AsInteger));
            AddPair('data', DateToStr(Query.FieldByName('Data').AsDateTime));
            AddPair('hora', TimeToStr(StrToTime(Copy(Query.FieldByName('Hora').AsString, 1, 8))));
            Result.AddElement(ObjJson);
            // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
          End;
          Query.Next;
        End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Topicos/getid - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

function TTopicoDao.Salvar(pJsonObject : TjsonObject) : Boolean;
var vSql: String;
    Query : TFdQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    try
      if pJsonObject.GetValue<Integer>('topicoId') = 0 then
         vSql := 'Insert Into Topicos (Descricao, Status, Data, Hora) Values (' +
                         QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +
          pJsonObject.GetValue<String>('status') + ', ' + TuEvolutConst.SqlDataAtual + ', ' +
          TuEvolutConst.SqlHoraAtual + ')'
      Else
         vSql := ' Update Topicos ' + '   Set Descricao = ' +
                 QuotedStr(pJsonObject.GetValue<String>('descricao')) + '      , Status   = ' +
                 pJsonObject.GetValue<String>('status') + ' where TopicoId = ' +
                 pJsonObject.GetValue<Integer>('topicoId').ToString;
      Query.ExecSQL(vSql);
      Result := True;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: Topico/salvar - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    Query.Free;
  End;
end;

end.
