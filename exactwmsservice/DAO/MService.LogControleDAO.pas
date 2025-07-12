unit MService.LogControleDAO;

interface

uses
  FireDAC.Comp.Client, EnderecoClass, System.SysUtils,
  DataSet.Serialize, exactwmsservice.lib.utils,
  System.JSON, REST.JSON, System.Generics.Collections, Constants,
  FireDAC.Stan.Option, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlEndereco = 'Select * From vEnderecamentos';

type
  TLogControleDao = class(TBasicDao)
  private
//    ObjLogControleDAO: TLogControle;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Get(pDataInicio, pDataTermino : TDateTime; pUsuarioId : Integer; pTerminal : String; pSomenteErro : Integer) : TJsonArray;
  end;

implementation

{ TLogControleDao }

constructor TLogControleDao.Create;
begin

end;

destructor TLogControleDao.Destroy;
begin

  inherited;
end;

function TLogControleDao.Get(pDataInicio, pDataTermino: TDateTime;
  pUsuarioId: Integer; pTerminal: String; pSomenteErro: Integer): TJsonArray;
Var FConexaoLog : TConnection;
    vQryLog: TFDQuery;
begin
  Try
    try
      FconexaoLog := TConnection.Create(1);
      vQryLog := FconexaoLog.Query;
      vQryLog.Sql.Add('SET NOCOUNT ON');
      vQryLog.Sql.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED');
      vQryLog.Sql.Add('Declare @DataInicio DateTime  = :pDataInicio');
      vQryLog.Sql.Add('Declare @DataTermino DateTime = :pDataTermino');
      vQryLog.Sql.Add('Declare @UsuarioId Integer = :pUsuarioId');
      vQryLog.Sql.Add('Declare @Terminal  VarChar(50) = :pTerminal');
      vQryLog.Sql.Add('Declare @SomenteErro Integer = :pSomenteErro');
      vQryLog.Sql.Add('Select L.*');
      vQryLog.Sql.Add('From RequestResponse L');
      vQryLog.Sql.Add('Where (@DataInicio = 0 or L.Data >= @DataInicio)');
      vQryLog.Sql.Add('  And (@DataTermino = 0 or L.Data <= @DataTermino)');
      vQryLog.Sql.Add('  And (@UsuarioId = 0 or L.UsuarioID = @UsuarioId)');
      vQryLog.Sql.Add('  And (@Terminal = '+#39+#39+' or L.Terminal  = @Terminal)');
      vQryLog.Sql.Add('  And (@SomenteErro = 0 or L.RespStatus > 299)');
      vQryLog.Sql.Add('SET NOCOUNT OFF');
      vQryLog.Sql.Add('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
      vQryLog.ParamByName('pDataInicio').Value  := pDataInicio;
      vQryLog.ParamByName('pDataTermino').Value := pDataTermino;
      vQryLog.ParamByName('pUsuarioId').Value   := pUsuarioId;
      vQryLog.ParamByName('pTerminal').Value    := pTerminal;
      vQryLog.ParamByName('pSomenteErro').Value := pSomenteErro;
      if DebugHook <> 0 then
        vQryLog.Sql.SaveToFile('RelLogControle.Sql');
      vQryLog.Open;
      if (vQryLog.IsEmpty) Then Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('Erro', 'não foram encontrado dados na pesquisa.'));
      End
      Else
        Result := vQryLog.ToJsonArray;
    Except ON E: Exception do
      Begin
        raise Exception.Create('Tabela: LogControles - '+TUtil.TratarExcessao(E.Message));
      End;
    end;
  Finally
    vQryLog.Close;
  End;
end;

end.
