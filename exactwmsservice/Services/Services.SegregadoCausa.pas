unit Services.SegregadoCausa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections, Constants,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TServiceSegregadoCausa = class(TBasicDao)
  private

    { Private declarations }
  public
    { Public declarations }
    Function GetSegregadoCausa(AQueryParam: TDictionary<String, String>)
      : TJsonArray;
    Function Delete(pSegregadoCausaId: Integer): TJsonArray;
    Function Salvar(pJsonArray: TJsonArray): TJsonArray;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServiceSegregadoCausa: TServiceSegregadoCausa;

implementation

{ TServiceSegregadoCausa }

constructor TServiceSegregadoCausa.Create;
begin
  inherited;
end;

function TServiceSegregadoCausa.Delete(pSegregadoCausaId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  if pSegregadoCausaId <= 0 then
  Begin
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Id da causa dos segregados é inválido.'));
    Exit;
  End;
  Try
    FConexao.Query.Sql.Add('Delete from SegregadoCausa');
    FConexao.Query.Sql.Add('Where SegregadoCausaId = :pSegregadoCausaId');
    FConexao.Query.ParamByName('pSegregadoCausaId').Value := pSegregadoCausaId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('DeleteSegregadoCausa.Sql');
    FConexao.Query.ExecSql;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok',
      'Registro excluído com sucesso.')));
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Processo: DeleteSegregadoCausa(Service) - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

destructor TServiceSegregadoCausa.Destroy;
begin

  inherited;
end;

function TServiceSegregadoCausa.GetSegregadoCausa(AQueryParam: TDictionary<String, String>): TJsonArray;
begin
  Result := TJsonArray.Create;
  Try
    FConexao.Query.Sql.Add('Select * from SegregadoCausa');
    FConexao.Query.Sql.Add('Where (1 = 1) ');
    if AQueryParam.ContainsKey('id') then begin
       FConexao.Query.Sql.Add(' And (SegregadoCausaId = :pSegregadoCausaId)');
       FConexao.Query.ParamByName('pSegregadoCausaId').Value := AQueryParam.Items['id'].ToInt64;
    end;
    if AQueryParam.ContainsKey('descricao') then begin
       FConexao.Query.Sql.Add(' And (Descricao Like :pDescricao)');
       FConexao.Query.ParamByName('pDescricao').Value := '%' + AQueryParam.Items['descricao'] + '%';
    end;
    if AQueryParam.ContainsKey('status') then begin
       FConexao.Query.Sql.Add(' And (Status = :pStatus)');
       FConexao.Query.ParamByName('pStatus').Value := AQueryParam.Items['status'].ToInteger;
    end;
    if DebugHook <> 0 then
       FConexao.Query.Sql.SaveToFile('GetSegregadoCausaService.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create(TJSONPair.Create('MSG', tuEvolutConst.QrySemDados)));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create('Processo: GetSegregadoCausa(Service) - ' +StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TServiceSegregadoCausa.Salvar(pJsonArray: TJsonArray): TJsonArray;
var
  JsonRetorno: TJsonObject;
  xArray: Integer;
  vCompl, vListaPedido: String;
begin
  Try
    Result := TJsonArray.Create;
    for xArray := 0 to Pred(pJsonArray.Count) do
    Begin
      if pJsonArray.Items[xArray].GetValue<Integer>('segregadocausaid') = 0 then
      begin
        FConexao.Query.Sql.Add
          ('Insert Into SegregadoCausa (Descricao, status, uuid) Values (');
        FConexao.Query.Sql.Add('            ' + #39 + pJsonArray.Items[xArray]
          .GetValue<string>('descricao') + #39 + ', 1, NewId())');
      end
      Else
      begin
        FConexao.Query.Sql.Add('Update SegregadoCausa');
        FConexao.Query.Sql.Add('  set Descricao = ' + #39 + pJsonArray.Items
          [xArray].GetValue<string>('descricao') + #39);
        FConexao.Query.Sql.Add('    , Status    = ' + pJsonArray.Items[xArray]
          .GetValue<Integer>('status').ToString());
        FConexao.Query.Sql.Add('Where SegregadoCausaId = ' + pJsonArray.Items
          [xArray].GetValue<Integer>('segregadocausaid').ToString());
      end;
      FConexao.Query.ExecSql;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok',
        'Registro salvo com sucesso.')));
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: SalvarSegregadoCausa(Service) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
