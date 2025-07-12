unit uRotaDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  Dialogs, System.Classes, System.SysUtils, RotaClass, System.JSON, REST.Json,
  Rest.Types, System.Threading;

Type

  TRotaDao = class
  private
    FRota : TRota;
  public
    constructor Create;
    Function RotaOnOff(pRotaId : Integer = 0) : Boolean; //tJsonArray;
    Function GetRota(pRotaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : tJsonArray;
    Function GetRotaParticipante(pRotaId : Integer = 0; pPessoaId : Integer = 0) : tJsonArray;
    Function Salvar : Boolean;
    Function Delete : Boolean;
    Function InsUpdParticipante(pJsonObject : TJsonObject) : TJsonObject;
    Function DelParticipante(pPessoaId : Integer) : Boolean;
    Function Distancia(pLatitude, pLongitude : String) : Integer;
    Function GetProducaoDiaria(pDataInicial, pDataFinal: TDateTime) : TJsonObject;
    Property Rota : TRota Read FRota Write FRota;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uDistanceMatrixGoogle;

constructor TRotaDao.Create;
begin
  Self.FRota := TRota.Create;
end;

function TRotaDao.Delete : Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/{rotaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', Self.Rota.RotaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TRotaDao.DelParticipante(pPessoaId: Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/participante/{pessoaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TRotaDao.Distancia(pLatitude, pLongitude : String): Integer;
Var ObjDistanceMatrix : TDistanceMatrixGoogle;
    iT: ITask;
    vDistancia : Integer;
begin
//   iT := TTask.Run(Procedure
//      Begin
        ObjDistanceMatrix := TDistanceMatrixGoogle.Create;
        ObjDistanceMatrix.Origem  := '-10.250828, -48.328974';
        ObjDistanceMatrix.Destino := StringReplace(pLatitude, ',', '.', [rfReplaceAll]) + ',' +
                                     StringReplace(pLongitude, ',', '.', [rfReplaceAll]);
        ObjDistanceMatrix.GETDados;
//        TThread.Queue(TThread.CurrentThread,
//            procedure
//            begin
              vDistancia := ObjDistanceMatrix.Distancia;
//            end);
//      End);
   Result := vDistancia;
end;

function TRotaDao.GetProducaoDiaria(pDataInicial,
  pDataFinal: TDateTime): TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/producao?datainicial='+DateToStr(pDataInicial)+'&datafinal='+DateToStr(pDataFinal);
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Timeout := 30000*3;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

function TRotaDao.GetRota(pRotaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1): tJsonArray;
//Var //jSonObj     : tJsonObject;
    //xItens      : Integer;
    //ObjRota     : TRota;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pRotaId <> 0) or (pDescricao<>'') then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/{rotaid}';
     if pRotaId <> 0 then
        DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', pRotaId.ToString())
     else DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', pDescricao);
  End
  Else if pRotaId = 0 then
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota';
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TRotaDao.GetRotaParticipante(pRotaId, pPessoaId: Integer): tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjRota  : TRota;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/participante/{rotaid}/{pessoaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', pRotaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pessoaid', pPessoaId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TRotaDao.InsUpdParticipante(pJsonObject: TJsonObject): TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonObject.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/rotaparticipante';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject;
end;

function TRotaDao.RotaOnOff(pRotaId: Integer): Boolean; //tJsonArray;
begin

end;

function TRotaDao.Salvar: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.AddBody(tJson.ObjectToJsonObject(Self.FRota).ToJson, ContentTypeFromString('application/json'));
  if Self.Rota.RotaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/rota/{rotaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('rotaid', Self.FRota.RotaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
