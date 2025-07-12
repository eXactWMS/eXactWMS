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
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

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
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TJsonArray.Create;
    if pSegregadoCausaId <= 0 then
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Id da causa dos segregados é inválido.'));
      Exit;
    End;
    Try
      Query.Sql.Add('Delete from SegregadoCausa');
      Query.Sql.Add('Where SegregadoCausaId = :pSegregadoCausaId');
      Query.ParamByName('pSegregadoCausaId').Value := pSegregadoCausaId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('DeleteSegregadoCausa.Sql');
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Registro excluído com sucesso.')));
    Except ON E: Exception do
      Begin
        Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Processo: SegregadaoCausa/delete - '+TUtil.tratarExcessao(E.Message)));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TServiceSegregadoCausa.Destroy;
begin
  inherited;
end;

function TServiceSegregadoCausa.GetSegregadoCausa(AQueryParam: TDictionary<String, String>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Result := TJsonArray.Create;
    Try
      Query.Sql.Add('Select * from SegregadoCausa');
      Query.Sql.Add('Where (1 = 1) ');
      if AQueryParam.ContainsKey('id') then begin
         Query.Sql.Add(' And (SegregadoCausaId = :pSegregadoCausaId)');
         Query.ParamByName('pSegregadoCausaId').Value := AQueryParam.Items['id'].ToInt64;
      end;
      if AQueryParam.ContainsKey('descricao') then begin
         Query.Sql.Add(' And (Descricao Like :pDescricao)');
         Query.ParamByName('pDescricao').Value := '%' + AQueryParam.Items['descricao'] + '%';
      end;
      if AQueryParam.ContainsKey('status') then begin
         Query.Sql.Add(' And (Status = :pStatus)');
         Query.ParamByName('pStatus').Value := AQueryParam.Items['status'].ToInteger;
      end;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('GetSegregadoCausaService.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('MSG', tuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetSegregadoCausa - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceSegregadoCausa.Salvar(pJsonArray: TJsonArray): TJsonArray;
var JsonRetorno: TJsonObject;
    xArray: Integer;
    vCompl, vListaPedido: String;
    Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Result := TJsonArray.Create;
      for xArray := 0 to Pred(pJsonArray.Count) do
      Begin
        if pJsonArray.Items[xArray].GetValue<Integer>('segregadocausaid') = 0 then begin
           Query.Sql.Add('Insert Into SegregadoCausa (Descricao, status, uuid) Values (');
           Query.Sql.Add('       ' + #39 + pJsonArray.Items[xArray].GetValue<string>('descricao') + #39 + ', 1, NewId())');
        end
        Else begin
          Query.Sql.Add('Update SegregadoCausa');
          Query.Sql.Add('  set Descricao = ' + #39 + pJsonArray.Items[xArray].GetValue<string>('descricao') + #39);
          Query.Sql.Add('    , Status    = ' + pJsonArray.Items[xArray].GetValue<Integer>('status').ToString());
          Query.Sql.Add('Where SegregadoCausaId = ' + pJsonArray.Items[xArray].GetValue<Integer>('segregadocausaid').ToString());
        end;
        Query.ExecSql;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Registro salvo com sucesso.')));
      End;
    Except On E: Exception do
      Begin
        raise Exception.Create('Processo: SalvarSegregadoCausa - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
