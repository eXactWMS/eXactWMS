unit Services.ProdutoLinha;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections, Constants,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.lib.utils, exactwmsservice.dao.base;

type
  TServiceProdutoLinha = class (TBasicDao)
  private
    { Private declarations }

  public
    { Public declarations }
    Function Import(pJsonObjectImport: TJsonObject): TJsonArray;
    function Salvar(pJsonArrayProdutoLinha: TJsonArray): TJsonArray;
    function GetProdutoLinha(AQueryParam: TDictionary<String, String>)
      : TJsonArray;
    Function Delete(pProdutoLinhaId: Integer): TJsonArray;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServiceProdutoLinha: TServiceProdutoLinha;

implementation

{ TServiceProdutoLinha }

constructor TServiceProdutoLinha.Create;
begin
 inherited;
end;

function TServiceProdutoLinha.Delete(pProdutoLinhaId: Integer): TJsonArray;
Var Query : TFdQuery;
begin
  Result := TJsonArray.Create;
  Try
    if pProdutoLinhaId <= 0 then Begin
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Id da causa dos segregados é inválido.'));
       Exit;
    End;
    Query := TFDQuery.Create(nil);
    Try
      Query.Connection := Connection;
      Query.Sql.Add('Delete from Linhas');
      Query.Sql.Add('Where LinhaId = :pProdutoLinhaId');
      Query.ParamByName('pProdutoLinhaId').Value := pProdutoLinhaId;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('DeleteProdutoLinha.Sql');
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Registro excluído com sucesso.')));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: DeleteProdutoLinhaId(Service) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

destructor TServiceProdutoLinha.Destroy;
begin
  inherited;
end;

function TServiceProdutoLinha.GetProdutoLinha(AQueryParam
  : TDictionary<String, String>): TJsonArray;
Var Query : TFdQuery;
begin
  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := Connection;
    Try
      Query.Sql.Add('Select * from Linhas');
      Query.Sql.Add('Where 1 = 1');
      if AQueryParam.ContainsKey('produtolinhaid') then begin
         Query.Sql.Add(' And (LinhaId = :pProdutoLinhaId)');
         Query.ParamByName('pProdutoLinhaId').Value := AQueryParam.Items['produtolinhaid'].ToInt64;
      end;
      if AQueryParam.ContainsKey('descricao') then begin
         Query.Sql.Add(' And (Descricao Like :pDescricao)');
         Query.ParamByName('pDescricao').Value := '%' + AQueryParam.Items['descricao'] + '%';
      end;
      if DebugHook <> 0 then
         Query.Sql.SaveToFile('ProdutoLinha.Sql');
      Query.Open;
      if Query.IsEmpty then Begin
         Result := TJsonArray.Create;
         Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', tuEvolutConst.QrySemDados)));
      End
      Else
         Result := Query.ToJSONArray();
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetProdutoLinha(Service) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProdutoLinha.Import(pJsonObjectImport: TJsonObject) : TJsonArray;
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
      Query.Sql.Add('Insert Into Linhas (Descricao, Sigla, Status) Values (');
      Query.Sql.Add('            ' + #39 + pJsonObjectImport.GetValue<string>('descricao') + #39 + ', ' + #39 +
                    pJsonObjectImport.GetValue<String>('sigla') + #39 + ', ' +
                    pJsonObjectImport.GetValue<Integer>('status').ToString() + ')');
      // +', NewId())');
      If DebugHook <> 0 Then
         Query.Sql.SaveToFile('ImportProdutoLinhas.Sql');
      Query.ExecSql;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Registro salvo com sucesso.')));
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: ImportProdutoLinhas(Service) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

function TServiceProdutoLinha.Salvar(pJsonArrayProdutoLinha: TJsonArray) : TJsonArray;
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
      for xArray := 0 to Pred(pJsonArrayProdutoLinha.Count) do Begin
        if pJsonArrayProdutoLinha.Items[xArray].GetValue<Integer>('id') = 0 then begin
           Query.Sql.Add('Insert Into Linhas (Descricao, Sigla, status) Values ('); //, uuid
           Query.Sql.Add('     ' + #39 + pJsonArrayProdutoLinha.Items[0].GetValue<string>('descricao') + #39 + ', ' + #39+
           pJsonArrayProdutoLinha.Items[xArray].GetValue<String>('sigla')+#39+ ', ' +
           pJsonArrayProdutoLinha.Items[xArray].GetValue<Integer>('status').ToString() + ')'); // +', NewId())');
        end
        Else begin
          Query.Sql.Add('Update Linhas');
          Query.Sql.Add('  Set Descricao = ' + #39 + pJsonArrayProdutoLinha.Items[xArray].GetValue<string>('descricao') + #39);
          Query.Sql.Add('    , Sigla     = ' + #39 + pJsonArrayProdutoLinha.Items[xArray].GetValue<string>('sigla') + #39);
          Query.Sql.Add('    , Status    = ' + pJsonArrayProdutoLinha.Items[xArray].GetValue<Integer>('status').ToString());
          Query.Sql.Add('Where LinhaId = ' + pJsonArrayProdutoLinha.Items[xArray].GetValue<Integer>('id').ToString());
        end;
        If DebugHook <> 0 Then
           Query.Sql.SaveToFile('InsertUpdateProdutoLinhas.Sql');
        Query.ExecSql;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok', 'Registro salvo com sucesso.')));
      End;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Processo: SalvarProdutoLinhas(Service) - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    FreeAndNil(Query);
  End;
end;

end.
